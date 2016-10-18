var authe = require('../utility/authe.js');
var log = require('../utility/log.js');
var constant = require('../utility/constant.js');
var returnValue = require('../config/returnValue.js');

//长连接
var registerEvent = "register"; //登记socket id 和对应 user id
var talkMsgEvent = "talkMsg"; //发送消息到对手方

exports.connectionEntry = function(socket) {
    // socket.on('msg', function(data, fn){
    //     console.log(data)
    //     fn(data)
    // });

    console.log("connectionEntry")

    socket.on(registerEvent, function(data, fn){
        //注册
        console.log(data)
        fn({code:returnValue.returnCode.SUCCESS})


        socket.on(talkMsgEvent, function(data, fn){

            fn({code:returnValue.returnCode.SUCCESS})
        })

        //断开连接
        socket.on("disconnect", function(data){

        })

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
