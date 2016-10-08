var applePush = require('../apn/applePush.js')
var token = "8e4c5dbc 894eaf09 9735dc7f db277ca1 588c97ce 0f2c055d 10bba973 0a996de0"
var msg = "测试ios10推送"
applePush.pushMsg(token, msg)
