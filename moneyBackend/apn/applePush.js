var apn = require('apn')

var pemName = '';
var pemkeyName = '';
var gateway = '';

if (process.env.moneyEnv === 'dev') {
	pemName = 'PushCert.pem';
	pemkeyName = 'PushKey.pem';
	gateway = 'gateway.sandbox.push.apple.com';
}

if (process.env.moneyEnv === 'pro') {
	pemName = 'StockPubPro.pem';
	pemkeyName = 'StockPubKey.pem';
	gateway = 'gateway.push.apple.com';
}

let service = new apn.Provider({
    cert: pemName,
    key: pemkeyName,
});

exports.pushMsg = function(token, msg) {

    let note = new apn.Notification({
	       alert:  msg,
           badge: 1
    });

    service.send(note, token).then( result => {
        console.log(result);
    });

}
