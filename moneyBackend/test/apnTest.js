var applePush = require('../apn/applePush.js')
var token = "8e4c5dbc894eaf099735dc7fdb277ca1588c97ce0f2c055d10bba9730a996de0"
var msg = "测试ios10推送"
applePush.pushMsg(token, msg)
