var should = require('should');
var constant = require('../../utility/constant.js');
var runner = require('./unitTestRunner.js');


describe('login test', function(){
    it('login test', function(done){
        runner.runTest('POST', {user:'wanghan', password:'wanghan'}, '/login', function(statusCode, body){
            console.log(body);
            statusCode.should.be.equal(200);
            body.code.should.be.equalOneOf(constant.returnCode.LOGIN_SUCCESS,
                constant.returnCode.LOGIN_FAIL);
            //检查内部变量
            done();
        });
    });
});
