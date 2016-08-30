var should = require('should');
var constant = require('../../utility/constant.js');
var runner = require('./unitTestRunner.js');
var async = require('async');

function getQuoteBySrno(quote){
    it('get quote by srno', function(done){
        console.log('getQuoteBySrno:'+quote.quote_srno);
        runner.runTest('GET', {quote_srno:quote.quote_srno, token:quote.token}, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);

            //检查内部变量
            body.should.have.property('data');
            body.data.should.be.an.Array;
            console.log(body.data);
            done();
        });
    });
}

function createQuote(quote){
    it('create quote', function(done){
        runner.runTest('POST', quote, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);

            //检查内部变量
            body.should.have.property('data');
            quote.quote_srno = body.data.quote_srno;
            done();
        });
    });
}

function modifyQuote(quote){
    it('modify quote', function(done){
        quote.price = 102;
        quote.amount = 2000;
        runner.runTest('PUT', quote, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);

            //检查内部变量
            body.should.have.property('data');
            done();
        });
    });
}

function deleteQuote(quote){
    it('delete quote', function(done){
        console.log('deleteQuote:'+quote.quote_srno);
        runner.runTest('DELETE', quote, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);
            //检查内部变量
            done();
        });
    });
}


function login(user){
    it('login', function(done){
        runner.runTest('POST', {user:'wanghan', password:'wanghan'}, '/login', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.LOGIN_SUCCESS);
            //检查内部变量
            //console.log(body.data.token);
            user.token = body.data.token;
            //console.log(user.token);
            done();
        });
    });
}

function logout(user){
    it('logout', function(done){
        runner.runTest('POST', {token: user.token}, '/logout', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);
            //检查内部变量
            done();
        });
    });
}


describe('test quote api base test', function(){

    //登录
    var quote = {
        code: '100001',
        name: '现券100001',
        price: 101,
        amount: 123456,
        direct: 1,
        enty: '300001',
        user: '400001'
    };

    var user = {};

    before(function(done){
        console.log('enter before');
        runner.runTest('POST', {user:'wanghan', password:'wanghan'}, '/login', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.LOGIN_SUCCESS);
            //检查内部变量
            //console.log(body.data.token);
            //console.log(user.token);
            quote.token = body.data.token;
            user.token = body.data.token;
            console.log(quote.token);
            console.log(user.token);
            done();
        });
    });



    it('create quote', function(done){
        runner.runTest('POST', quote, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);

            //检查内部变量
            body.should.have.property('data');
            quote.quote_srno = body.data.quote_srno;
            done();
        });
    });



    //
    modifyQuote(quote);
    getQuoteBySrno(quote);
    deleteQuote(quote);
    logout(user);

});


//
describe('parameter get quote test', function(){

    //登录

    var quotes = [
        {
            code: '100001',
            name: '现券01',
            price: 102,
            amount: 10000,
            direct: 1,
            enty: '300002',
            user: '400002'
        },
        {
            code: '100001',
            name: '现券01',
            price: 103,
            amount: 20000,
            direct: 1,
            enty: '300001',
            user: '400023'
        },
        {
            code: '100002',
            name: '现券02',
            price: 104,
            amount: 30000,
            direct: 1,
            enty: '300003',
            user: '400012'
        },
        {
            code: '100002',
            name: '现券02',
            price: 105,
            amount: 20000,
            direct: 1,
            enty: '300001',
            user: '400023'
        }
    ];
    var user = {};

    //登录
    before(function(done){
        console.log('enter before');
        runner.runTest('POST', {user:'wanghan', password:'wanghan'}, '/login', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.LOGIN_SUCCESS);
            //检查内部变量
            //console.log(body.data.token);
            //console.log(user.token);
            quotes.forEach(function(e){
                e.token = body.data.token;
            });
            user.token = body.data.token;
            done();
        });
    });


    //添加所有报价
    it('add all quote', function(done){
        async.eachSeries(quotes, function(quote, callback){
            runner.runTest('POST', quote, '/quote', function(statusCode, body){
                statusCode.should.be.equal(200);
                body.code.should.be.equal(constant.returnCode.SUCCESS);

                //检查内部变量
                body.should.have.property('data');
                quote.quote_srno = body.data.quote_srno;
                callback(null);
            });

        }, function(err){
            done();
        });
    });



    //获取所有报价
    it('get all quote', function(done){

        runner.runTest('GET', user, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);

            //检查内部变量
            body.should.have.property('data');
            body.data.should.be.an.Array;
            console.log(body.data);
            done();

        });
    });

    //按照quote_srno获取报价
    it('get quote by quote_srno', function(done){

        runner.runTest('GET', {quote_srno: quotes[0].quote_srno, token:user.token}, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);

            //检查内部变量
            body.should.have.property('data');
            body.data.should.be.an.Array;
            body.data.should.have.length(1);
            body.data[0].should.have.property('quote_srno');
            body.data[0].quote_srno.should.be.equal(quotes[0].quote_srno);
            done();
        });
    });


    //按照债券code获取报价
    it('get quote by code', function(done){

        runner.runTest('GET', {code: '100001', token:user.token}, '/quote', function(statusCode, body){
            statusCode.should.be.equal(200);
            body.code.should.be.equal(constant.returnCode.SUCCESS);
            //检查内部变量
            body.should.have.property('data');
            body.data.should.be.an.Array;

            body.data.forEach(function(e){
                e.code.should.be.equal('100001');
            });
            done();
        });
    });


    //删除
    it('delete all quote', function(done){
        async.eachSeries(quotes, function(quote, callback){

            runner.runTest('DELETE', quote, '/quote', function(statusCode, body){
                statusCode.should.be.equal(200);
                body.code.should.be.equal(constant.returnCode.SUCCESS);
                //检查内部变量
                callback(null);
            });

        }, function(err){
            done();
        });
    });


    //登出
    logout(user);
});
