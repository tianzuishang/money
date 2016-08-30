var authe = require('../utility/authe.js');
var log = require('../utility/log.js');
var constant = require('../utility/constant.js');

//长连接

exports.connectionEntry = function(socket){
    //长连接定义入口
    //connection 事件触发
    console.log('connection');
    socket.emit('authorize', {});//请求token认证
    socket.on('authorize', function(data){
        //验证token
        authe.autheToken(data.token, function(err, code){
            if (err) {
                log.error(err, log.getFileNameAndLineNum(__filename));

                socket.emit('authorized', {
                    code: constant.returnCode.ERROR,
                    msg: err
                });
            }else{
                if (code === constant.returnCode.TOKEN_INVALID) {
                    log.debug('token invalid');
                    socket.emit('authorized', {
                        code: constant.returnCode.TOKEN_INVALID,
                        msg: 'token invalid'
                    });
                }
                if (code === constant.returnCode.TOKEN_VALID) {
                    log.debug('token valid');
                    socket.emit('authorized', {
                        code: constant.returnCode.TOKEN_VALID,
                        msg: 'token valid'
                    });

                    //定义各类事件响应
                    ioHandle(socket);
                }
            }
        });
    });
}


function ioHandle(socket){
    socket.on('data', function(data){
        console.log('data event');
        socket.emit('data', data);
    });
}
