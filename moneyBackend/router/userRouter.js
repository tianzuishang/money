var express = require('express');
var router = express.Router();
var userController = require('../controller/userController.js');





router.route('/user')
.get(function(req, res){
    userController.get(req, res);
}).put(function(req, res){
    userController.put(req, res);
}).post(function(req, res){
    userController.post(req, res);
}).delete(function(req, res){
    userController.delete(req, res);
});



router.get('/test', function(req, res){
    res.send('router test ok');
});

//导出router对象
module.exports = router;
