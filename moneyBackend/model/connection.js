var config = require('../config/appConfig.js');
var mysql = require('mysql');
var redis = require("redis");
var redisClient = null;
var mysqlPool = null;
var mongoClient = require('mongodb').MongoClient;


var log = require('../utility/log.js');


function connectRedis(){

    log.info('create redis client');

    if (config.redisConnection === undefined) {
        log.info('redisConnection is undefined', log.getFileNameAndLineNum(__filename));
        return null;
    }

    var redisClient = redis.createClient({auth_pass:config.redisConnection.auth_pass});

    redisClient.on("error", function (err) {
        log.error(err, log.getFileNameAndLineNum(__filename));
    });

    return redisClient;
}

function createMysqlConnectionPool(){

    log.info('create mysql connection pool');

    if(config.mysqlConnection === undefined){
        log.info('mysqlConnection is undefined', log.getFileNameAndLineNum(__filename));
        return null;
    }

    var mysqlPool = mysql.createPool({
    	host: config.mysqlConnection.host,
    	user: config.mysqlConnection.user,
      	password: config.mysqlConnection.password,
    	database: config.mysqlConnection.database,
    	port: config.mysqlConnection.port,
    	acquireTimeout: 80000
    });

    mysqlPool.getConnection(function(err, connection){
        if(err){
            log.error('mysql connection err '+err, log.getFileNameAndLineNum(__filename));
        }else{
            connection.release();
        }
    });

    return mysqlPool;
}

exports.getRedisClient = function(){
    if (redisClient === null) {
        redisClient = connectRedis();
    }
    return redisClient;
}

exports.getMysqlPool = function(){
    if (mysqlPool === null) {
        mysqlPool = createMysqlConnectionPool();
    }
    return mysqlPool;
}
