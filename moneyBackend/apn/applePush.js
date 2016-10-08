var apn = require('apn')

var pemName = '';
var pemkeyName = '';
var gateway = '';
var path = require('path')

if (process.env.moneyEnv === 'dev') {

    pemName = path.join(__dirname, 'PushCert.pem');
	pemkeyName = path.join(__dirname, 'PushKey.pem');
	gateway = 'gateway.sandbox.push.apple.com';

    console.log(pemName);
    console.log(pemkeyName);
    console.log(gateway);
}

if (process.env.moneyEnv === 'pro') {
	pemName = 'StockPubPro.pem';
	pemkeyName = 'StockPubKey.pem';
	gateway = 'gateway.push.apple.com';
}

var service = new apn.Provider({
    cert: pemName,
    key: pemkeyName,
    passphrase: '888888',
    port: 2195
});

exports.pushMsg = function(token, msg) {

    var note = new apn.Notification({
	       alert:  msg,
           badge: 1
    });

    service.send(note, token).then( result => {
        console.log(JSON.stringify(result));
    });

}
