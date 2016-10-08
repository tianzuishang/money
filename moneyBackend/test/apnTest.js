var applePush = require('../apn/applePush.js')
var token = "89c9557f96cea47690e165b77a6f70e17b07419372b00a07f711c2556947245d"
var msg = "测试ios10推送"
applePush.pushMsg(token, msg)
