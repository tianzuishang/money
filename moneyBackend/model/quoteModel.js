var conn = require('./utility');
var md5 = require('md5');
var log = require('../utility/log.js');
var appConfig = require('../config/appConfig.js');
var quoteHash = appConfig.redisHashTable.quoteHash;

// //新增
// {
//     url: '/data',
//     method: 'POST',
//     parameter: {
//         code:
//         name:
//         price:
//         amount:
//         direct:
//         enty:
//         user:
//     }
//     return:{
//         code:
//         msg:
//         data:{
//             quote_srno:
//             code:
//             name:
//             price:
//             amount:
//             direct:
//             enty:
//             user:
//             timestamp:
//         }
//     }
// }
exports.newQuote = function(quotebody, callback){
    quotebody.quote_srno = md5(quotebody.enty+quotebody.user+quotebody.code+Date.now()+Math.random());
    quotebody.timestamp = Date.now();
    conn.redisHset(quoteHash, quotebody.quote_srno, quotebody, function(err, reply){
        if (err) {
            callback(err, null);
        }else{
            callback(null, quotebody);
        }
    });
}



// //修改
// {
//     url: '/data',
//     method: 'PUT',
//     parameter: {
//         quote_srno:
//         price:
//         amount:
//         enty:
//         user:
//     },
//     return:{
//         code:
//         msg:
//         data:{
//             quote_srno:
//             code:
//             name:
//             price:
//             amount:
//             direct:
//             enty:
//             user:
//             timestamp:
//         }
//     }
// }
exports.modifyQuote = function(quotebody ,callback){
    conn.redisHget(quoteHash, quotebody.quote_srno, function(err, reply){
        var returnData = {};
        if (err) {
            callback(err, reply);
        }else{
            if(reply === null){
                //没有对应报价
                log.info(quotebody.quote_srno+' is not exist');
                callback('no quote', reply);
            }else{
                reply.price = quotebody.price;
                reply.amount = quotebody.amount;
                reply.timestamp = Date.now();
                conn.redisHset(quoteHash, quotebody.quote_srno, reply, callback);
            }
        }
    });
}

// //删除
// {
//     url: '/data',
//     method: 'DELETE',
//     parameter: {
//         quote_srno:
//         enty:
//         user:
//     },
//     return:{
//         code:
//         msg:
//     }
// }

exports.delQuote = function(quotebody, callback){
    conn.redisHdel(quoteHash, quotebody.quote_srno, callback);
}


// // 获取存量数据
// {
//     url: '/data',
//     method: 'GET',
//     parameter: 'code=101010&quote_srno=111111',
//     return:{
//         code:
//         msg:
//         data:[
//             {
//                 quote_srno:
//                 code:
//                 name:
//                 price:
//                 amount:
//                 direct:
//                 enty:
//                 user:
//                 timestamp:
//             },
//         ]
//     }
// }
function packageQuote(err, reply, callback){
    if (err) {
        callback(err, null);
    }else{
        var quotes = [];
        if (reply!==null) {
            if (reply instanceof Array) {
                quotes = reply;
            }else{
                quotes.push(reply);
            }
        }
        callback(null, quotes);
    }
}

exports.getQuote = function(callback){
    conn.redisHvals(quoteHash, callback);
}

exports.getQuoteByCode = function(code, callback){
    conn.redisHvals(quoteHash, function(err, reply){
        if (err) {
            callback(err, null);
        }else{
            var quotes = [];
            if (reply!==null) {
                reply.forEach(function(e){
                    if (e.code === code) {
                        quotes.push(e);
                    }
                });
                callback(null, quotes);
            }else{
                callback(null, []);
            }
        }
    });
}

exports.getQuoteByQuoteSrno = function(quote_srno, callback){
    conn.redisHget(quoteHash, quote_srno, callback);
}
