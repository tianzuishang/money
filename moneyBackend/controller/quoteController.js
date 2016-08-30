var quoteModel = require('../model/quoteModel.js');
var log = require('../utility/log.js');

var quoteController = {};

function quotePackage(err, data, res){
    var returnData = {};
    if (err) {
        log.error(err, log.getFileNameAndLineNum(__filename));
        returnData.code = -1;
        returnData.msg = err;
    }else{
        var quotes = [];
        if (data!==null) {
            if (data instanceof Array) {
                quotes = data;
            }else{
                quotes.push(data);
            }
        }
        returnData.code = 0;
        returnData.data = quotes;
    }
    res.send(returnData);
}

quoteController.getQuote = function(req, res){
    //获取存量报价
    if (req.query.quote_srno !== undefined) {
        console.log('getQuoteByQuoteSrno:'+req.query.quote_srno);
        quoteModel.getQuoteByQuoteSrno(req.query.quote_srno, function(err, data){
            quotePackage(err, data, res);
        });

    }else if (req.query.code !== undefined) {
        //获取相同债券号的报价
        console.log('getQuoteByCode:'+req.query.code);
        quoteModel.getQuoteByCode(req.query.code, function(err, data){
            quotePackage(err, data, res);
        });

    }else{
        //获取所有报价
        quoteModel.getQuote(function(err, data){
            quotePackage(err, data, res);
        });
    }
}



quoteController.postQuote = function(req, res){
    //新增报价
    quoteModel.newQuote(req.body, function(err, data){
        var returnData = {};
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            returnData.code = 0;
            returnData.data = data;
        }
        res.send(returnData);
    });
}




quoteController.putQuote = function(req, res){
    //修改报价
    quoteModel.modifyQuote(req.query, function(err, data){
        var returnData = {};
        if(err){
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            returnData.code = 0;
            returnData.data = data;
        }
        res.send(returnData);
    });
}


quoteController.delQuote = function(req, res){
    //删除报价
    quoteModel.delQuote(req.query, function(err, data){
        var returnData = {};
        if(err){
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            returnData.code = 0;
            returnData.data = data;
        }
        res.send(returnData);
    });
}


module.exports = quoteController;
