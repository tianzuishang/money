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

        socket.on(missedMsgEvent, function(data, fn){
            var feedback = {}

            feedback.code = returnValue.returnCode.SUCCESS
            fn(feedback)
        })

        socket.on(talkMsgEvent, onTalkMsgEvent);

        //断开连接
        socket.on("disconnect", function(data){
            console.log('disconnect ' + data)


        })


        fn({code:returnValue.returnCode.SUCCESS})
    });
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

        if(socketid == null){
            //未登录 添加离线消息
            utility.redisHset(data.targetUserID+".missedMsgHash", data.msg_id, data, function(err){
                if(err){
                    log.error(err, log.getFileNameAndLineNum(__filename))
                }
            });
            return
        }

        if(globalSockets.connected[socketid] != null) {
            //已连接
            globalSockets.connected[socketid].emit(data)

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
    });

    fn({
        code:returnValue.returnCode.SUCCESS,
        data:data
    });

}




// exports.connectionEntry = function(socket){
//     //长连接定义入口
//     //connection 事件触发
//     console.log('connection');
//     socket.emit('authorize', {});//请求token认证
//     socket.on('authorize', function(data){
//         //验证token
//         authe.autheToken(data.token, function(err, code){
//             if (err) {
//                 log.error(err, log.getFileNameAndLineNum(__filename));
//
//                 socket.emit('authorized', {
//                     code: constant.returnCode.ERROR,
//                     msg: err
//                 });
//             }else{
//                 if (code === constant.returnCode.TOKEN_INVALID) {
//                     log.debug('token invalid');
//                     socket.emit('authorized', {
//                         code: constant.returnCode.TOKEN_INVALID,
//                         msg: 'token invalid'
//                     });
//                 }
//                 if (code === constant.returnCode.TOKEN_VALID) {
//                     log.debug('token valid');
//                     socket.emit('authorized', {
//                         code: constant.returnCode.TOKEN_VALID,
//                         msg: 'token valid'
//                     });
//
//                     //定义各类事件响应
//                     ioHandle(socket);
//                 }
//             }
//         });
//     });
// }


// function ioHandle(socket){
//     socket.on('data', function(data){
//         console.log('data event');
//         socket.emit('data', data);
//     });
// }
