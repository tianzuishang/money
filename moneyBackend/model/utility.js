
var log = require('../utility/log.js');
var connection = require('./connection.js');

var mysqlpool = connection.getMysqlPool();
var redisClient = connection.getRedisClient();


exports.redisHvals = function(hash, callback){
    redisClient.hvals(hash, callback);
}

exports.redisHdel = function(hash, key, callback){
    redisClient.hdel(hash, key, callback);
}

exports.redisHset = function(hash, key, value, callback){
    redisClient.hset(hash, key, JSON.stringify(value), function(err, reply){
        if(err){
            log.error(err, log.getFileNameAndLineNum(__filename));
            callback(err, null);
        }else{
            callback(null, reply);
        }
    });
}

exports.redisHget = function(hash, key, callback){
    redisClient.hget(hash, key, function(err, reply){
        if(err){
            log.error(err, log.getFileNameAndLineNum(__filename));
            callback(err, null);
        }else{
            callback(null, JSON.parse(reply));
        }
    });
}

exports.executeSql = function(sql, para, callback) {
	mysqlpool.getConnection(function(err, conn){
		if (err) {
			log.error(err, log.getFileNameAndLineNum(__filename));
			if(callback && typeof callback === 'function'){
				callback(err, null);
			}
		}else{
			var query = conn.query(sql, para, function(err, result){
				if (err) {
					log.error(err+' sql:'+query.sql, log.getFileNameAndLineNum(__filename));
					if(callback && typeof callback === 'function'){
						callback(err, null);
					}
				} else{
					if (callback && typeof callback === 'function') callback(null, result);
				}
				conn.release();
			});
			log.debug(query.sql, log.getFileNameAndLineNum(__filename));
		}
	});
}
