var authe = require('../utility/authe.js');
var log = require('../utility/log.js');
var constant = require('../utility/constant.js');
var returnValue = require('../config/returnValue.js');

//长连接
var registerEvent = "register"; //登记socket id 和对应 user id
var talkMsgEvent = "talkMsg"; //发送消息到对手方
var missedMsgEvent = "missedMsg";//获取离线信息

var utility = require('../model/utility.js')
var appConfig = require('../config/appConfig.js')

var encode = require('../utility/encode.js')

var globalSockets = null

exports.connectionEntry = function(socket, sockets) {
    // socket.on('msg', function(data, fn){
    //     console.log(data)
    //     fn(data)
    // });
    if(globalSockets == null){
        globalSockets = sockets
    }


    console.log("connectionEntry")

    socket.on(registerEvent, function(data, fn){
        //注册
        console.log(data)

        utility.redisHset(appConfig.redisHashTable.userIDSocketHash, data.userID, socket.id, function(err, data){
            if(err){
                log.error(err, log.getFileNameAndLineNum(__filename))
            }
        });

        socket.on(missedMsgEvent, onMissedMsgEvent)

        socket.on(talkMsgEvent, onTalkMsgEvent);

        //断开连接
        socket.on("disconnect", function(data){
            console.log('disconnect ' + data)


        })


        fn({code:returnValue.returnCode.SUCCESS})
    });
}


function onMissedMsgEvent(data, fn) {

    utility.redisHvals(data.userID+".missedMsgHash", function(err, missedMsg){
        var feedback = {}
        if(err){
            log.error(err, log.getFileNameAndLineNum(__filename))
            feedback.code = returnValue.returnCode.ERROR
        }else{
            feedback.code = returnValue.returnCode.SUCCESS
            feedback.data = missedMsg

            //清空离线消息
            utility.redisDel(data.userID+".missedMsgHash", function(err, data){
                if(err){
                    log.error(err, log.getFileNameAndLineNum(__filename))
                }
            })
        }
        fn(feedback)
    })
}



function onTalkMsgEvent(data, fn) {

    data.timestamp = Date.now();
    console.log(data.sourceUserID)
    console.log(data.targetUserID)
    console.log(data.timestamp)
    data.msg_id = encode.sha1Cryp(data.sourceUserID + data.targetUserID + data.timestamp);

    utility.redisHget(appConfig.redisHashTable.userIDSocketHash, data.targetUserID, function(err, socketid){
        if(err){
            log.error(err, log.getFileNameAndLineNum(__filename))
            return
        }

        utility.redisHset(data.targetUserID+".missedMsgHash", data.msg_id, data, function(err){
            if(err){
                log.error(err, log.getFileNameAndLineNum(__filename))
            }else{
                if(socketid == null){
                    //未登录 添加离线消息
                    return
                }
                if(globalSockets.connected[socketid] != null) {
                    //已连接
                    globalSockets.connected[socketid].emit(data, function(data){
                        if(data.code === returnValue.returnCode.SUCCESS){
                            //离线消息去除
                            utility.redisHdel(data.targetUserID+".missedMsgHash", data.msg_id, data, function(err){
                                if(err){
                                    log.error(err, log.getFileNameAndLineNum(__filename))
                                }
                            });
                        }
                    })

                }else{
                    //连接失效,去除redis中连接id
                    utility.redisHdel(appConfig.redisHashTable.userIDSocketHash, data.targetUserID, function(err){
                        if(err){
                            log.error(err, log.getFileNameAndLineNum(__filename))
                        }
                    });

                    //离线消息添加
                    utility.redisHset(data.targetUserID+".missedMsgHash", data.msg_id, data, function(err){
                        if(err){
                            log.error(err, log.getFileNameAndLineNum(__filename))
                        }
                    });
                }
            }
        });

    });

    fn({
        code:returnValue.returnCode.SUCCESS,
        data:data
    });

}
