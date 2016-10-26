
var appConfig = require('./config/appConfig.js');
var log = require('./utility/log.js');
var logger = log.createLog(appConfig.logConfig.logFileName);
log.setLevel(logger, appConfig.logConfig.level);//设置打印级别
log.setDefaultLogger(logger);
var path = require('path');
var express = require('express');
var app = express();

// HS256 secrets are typically 128-bit random strings, for example hex-encoded:
// var secret = Buffer.from('fe1a1915a379f3be5394b64d14794932', 'hex)


//初始化http服务
var server = InitHTTPServer(app);

//初始化长连接
initSocketIO(server);

//初始化路由模块
initRouter(app);


//静态文件路径
initStaticFile(app);




app.get('/', function(req, res) {
    res.send('hello money');
});

process.on('uncaughtException', function(err) {
    log.error(err.stack);
    //处理全局异常
});







////////////////////////////////////////////////////////////////////////////////
function InitHTTPServer(app){

    log.info('InitHTTPServer......');

    var bodyParser = require('body-parser');
    app.use(bodyParser.json()); // parse application/json
    app.use(bodyParser.urlencoded({
        extended: false // parse application/x-www-form-urlencoded
    }));

    var server = app.listen(appConfig.port, function(){
        var host = server.address().address;
        var port = server.address().port;
        log.info('app listening at '+host+':'+port);
    });

    return server;
}


function initSocketIO(server){
    //socket.io 建立长连接
    log.info('initSocketIO......');

    var io = require('./io/io.js');//长连接模块
    var socketio = require('socket.io')(server);
    socketio.on('connection', function(socket){
        io.connectionEntry(socket, socketio);
    });
}


function initRouter(app){
    log.info('initRouter......');

    var moneyRouter = require('./router/moneyRouter.js');
    var userRouter = require('./router/userRouter.js');

    //加载路由模块
    app.use('/news', moneyRouter);
    app.use('/user', userRouter);
}


function initStaticFile(app){
    global.staticPath = [];
    global.staticPath.push(path.join(__dirname, 'static/css'));
    global.staticPath.push(path.join(__dirname, 'static/js'));
    global.staticPath.push(path.join(__dirname, 'static/image'));
    global.staticPath.push(path.join(__dirname, 'static/html'));
    global.staticPath.push(path.join(__dirname, 'static/fonts'));

    console.log('initStaticFile');
    global.staticPath.forEach(function(path){
        app.use(express.static(path));
    })
}
