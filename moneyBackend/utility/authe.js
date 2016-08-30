var conn = require('../model/utility.js');
var jwt = require('jwt-simple');
var log = require('./log.js')
var appConfig = require('../config/appConfig.js');
var constant = require('./constant.js');

exports.autheToken = function(token, callback){
    console.log(token);
    if (token === undefined||token === null) {
        callback(null, constant.returnCode.TOKEN_INVALID);
        return;
    }
    console.log(token);

    try {
        var payload = jwt.decode(token, 'babyface');
        conn.redisHget(appConfig.redisHashTable.userTokenHash, payload.user, function(err, reply){
            if (err) {
                log.error(err, log.getFileNameAndLineNum(__filename));
                callback(err, null);
            }else{
                console.log(reply);
                if (token === reply.token) {
                    callback(null, constant.returnCode.TOKEN_VALID);
                }else{
                    //token失效
                    callback(null, constant.returnCode.TOKEN_INVALID);
                }
            }
        });
    } catch (e) {
        console.log('token parse exception!');
        callback(null, constant.returnCode.TOKEN_INVALID);
    }
}
