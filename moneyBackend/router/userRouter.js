var express = require('express');
var router = express.Router();
var userModel = require('../model/userModel.js')
var log = require('../utility/log.js');
var returnValue = require('../config/returnValue.js');






router.post('/updateUserDeviceToken', function(req, res){
    log.info(req, log.getFileNameAndLineNum(__filename));

    userModel.updateUserDeviceToken(req.body.userSrno, req.body.userDeviceToken, function(err, data){
        var returnData = {};
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = returnValue.returnCode.ERROR;
            returnData.msg = err;
        }else{
            returnData.code = returnValue.returnCode.SUCCESS;
            returnData.data = data;
        }
        res.send(returnData);
    });
});



router.get('/test', function(req, res){
    res.send('user router test ok');
});

//导出router对象
module.exports = router;
