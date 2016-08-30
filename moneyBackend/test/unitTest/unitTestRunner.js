require('mocha');
var config = require('../../config/appConfig');
var http = require('http');
var qs = require('qs');
var hostname = config.unitTestConfig.hostname;
var port = config.unitTestConfig.port;

exports.runTest = function(method, jsonObject, childpath, callback){


    //post
    if (method === 'POST') {
        var buf = new Buffer(JSON.stringify(jsonObject));
        var options = {
            port: port,
            hostname: hostname,
            method: method,
            path: childpath,
            timeout: 10000,
            headers: {
                'Content-Type': 'application/json; encoding=utf-8',
                'Accept': 'application/json',
                'Content-Length': buf.length
            }
        };

        var body = '';

        var req = http.request(options, function(res) {
            //console.log("Got response: " + res.statusCode);
            res.on('data', function(d) {
                body += d;
            }).on('end', function() {
                //console.log(body);
                callback(res.statusCode, JSON.parse(body));
            });
        }).on('error', function(e) {
            console.log("Got error: " + e.message);
            callback(e, e.message);
        });

        req.setTimeout(10000, function(){
            callback('timeout', 'timeout');
        });

        if (jsonObject.token!== undefined) {
            req.setHeader('token', jsonObject.token);
        }
        req.write(JSON.stringify(jsonObject));
        req.end();
    }

    //get
    if(method === 'GET'||method === 'PUT'||method === 'DELETE'){
        var content = qs.stringify(jsonObject);

        var options = {
            port: port,
            hostname: hostname,
            method: method,
            path: childpath + '?' + content,
            timeout: 10000,
            headers: {
                'Content-Type': 'application/json; encoding=utf-8',
                'Accept': 'application/json'
            }
        };

        var body = '';

        var req = http.request(options, function(res) {
            //console.log("Got response: " + res.statusCode);
            res.on('data', function(d) {
                body += d;
            }).on('end', function() {
                //console.log(body);
                callback(res.statusCode, JSON.parse(body));
            });
        }).on('error', function(e) {
            console.log("Got error: " + e.message);
            callback(e, e.message);
        });

        req.setTimeout(10000, function(){
            callback('timeout', 'timeout');
        });

        if (jsonObject.token!== undefined) {
            req.setHeader('token', jsonObject.token);
        }

        req.end();
    }

    // //put
    // if (method === 'PUT') {
    //
    // }
    //
    // //delete
    // if (method === 'DELETE') {
    //
    // }

};
