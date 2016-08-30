var express = require('express');
var router = express.Router();
var jwt = require('jwt-simple');
var secret = 'babyface'; //token的密钥
var conn = require('../model/utility.js');
var appConfig = require('../config/appConfig.js');




var constant = require('../utility/constant.js');
var log = require('../utility/log.js');

//登录
router.post('/login', function(req, res){
    var returnData = {};
    conn.redisHget(appConfig.redisHashTable.userAccountHash, req.body.user, function(err, reply){
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = constant.returnCode.ERROR;
            returnData.msg = err;
            res.send(returnData);
        }else{
            if (reply.password === req.body.password) {
                //密码验证成功
                var payload = {
                    user:req.body.user
                };
                var token = jwt.encode(payload, secret);
                returnData.code = constant.returnCode.LOGIN_SUCCESS;
                returnData.data = {
                    user: req.body.user,
                    token: token
                };
                res.send(returnData);
                conn.redisHset(appConfig.redisHashTable.userTokenHash, req.body.user, {token:token}, function(err, reply){
                    if (err) {
                        log.error(err, log.getFileNameAndLineNum(__filename));
                    }
                });

            }else{
                //密码验证不成功
                returnData.code = constant.returnCode.LOGIN_FAIL;
                returnData.msg = '用户名或密码错误';
                res.send(returnData);
            }
        }
    });
});


//注销
router.post('/logout', function(req, res){
    var returnData = {};
    if (req.body.token === null || req.body.token === undefined) {
        returnData.code = constant.returnCode.ERROR;
        returnData.msg = err;
        res.send(returnData);
        return;
    }

    

    var payload = jwt.decode(req.body.token, secret);
    conn.redisHdel(appConfig.redisHashTable.userTokenHash, payload.user, function(err, reply){
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = constant.returnCode.ERROR;
            returnData.msg = err;
            res.send(returnData);
        }else{
            returnData.code = constant.returnCode.SUCCESS;
            res.send(returnData);
        }
    });
});


//导出router对象
module.exports = router;
