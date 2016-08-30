var path = require('path');
var log4js = require('log4js');
var defaultLogger = null;

exports.createLog = function(fileName) {
    log4js.configure({
        appenders: [{
            type: 'console'
        }, {
            type: 'dateFile',
            absolute: true,
            filename: fileName,
            maxLogSize: 1024 * 1024,
            backups: 4,
            pattern: 'yyyy-MM-dd.log',
            alwaysIncludePattern: true,
            category: 'normal'
        }],
        replaceConsole: true
    });

    var logger = log4js.getLogger('normal');
    logger.setLevel('DEBUG');
    return logger;
};

exports.setDefaultLogger = function(logger){
    defaultLogger = logger;
}

exports.getDefaultLogger = function(){
    return defaultLogger;
}

exports.setLevel = function(logger, level){
    // 配置日志打印级别，低于此级别的不打印
    logger.setLevel(level);
}

exports.getFileNameAndLineNum = function(fullfilename) {
    // console.log('enter getFileNameAndLineNum');
    try {
        throw new Error('get file name and line number');
        // console.log('throw exception');
    } catch (err) {
        var filename = fullfilename.substr(fullfilename.lastIndexOf('/'));
        var stackArr = err.stack.split('\n');
        // console.log(err.stack);
        if (stackArr.length < 3) {
            return filename;
        }

        var msg = stackArr[2].substr(stackArr[2].lastIndexOf(filename) + 1,
            stackArr[2].length - stackArr[2].lastIndexOf(filename) - 2);

        return msg;
    }
};

exports.info = function(info, fileNameLineNum, logger) {

    if(fileNameLineNum === undefined){
        fileNameLineNum = '';
    }
    if (logger === undefined) {
        logger = defaultLogger;
    }


    if (logger === null) {
        console.log(fileNameLineNum + ' ' + info);
    }else{
        logger.info(fileNameLineNum + ' ' + info);
    }
};

exports.debug = function(info, fileNameLineNum, logger) {
    if(fileNameLineNum === undefined){
        fileNameLineNum = '';
    }
    if (logger === undefined) {
        logger = defaultLogger;
    }
    if (logger === null) {
        console.log(fileNameLineNum + ' ' + info);
    }else{
        logger.debug(fileNameLineNum + ' ' + info);
    }
};

exports.error = function(info, fileNameLineNum, logger) {
    if(fileNameLineNum === undefined){
        fileNameLineNum = '';
    }
    if (logger === undefined) {
        logger = defaultLogger;
    }
    if (logger === null) {
        console.log(fileNameLineNum + ' ' + info);
    }else{
        logger.error(fileNameLineNum + ' ' + info);
    }
};

exports.warn = function(info, fileNameLineNum, logger) {
    if(fileNameLineNum === undefined){
        fileNameLineNum = '';
    }
    if (logger === undefined) {
        logger = defaultLogger;
    }
    if (logger === null) {
        console.log(fileNameLineNum + ' ' + info);
    }else{
        logger.warn(fileNameLineNum + ' ' + info);
    }
};

//req对象详细信息
exports.reqStr = function(req){
    return 'path:'+req.originalUrl+' params:'+JSON.stringify(req.params)+' body:'+JSON.stringify(req.body);
}
