var apn = require('apn')

var pemName = '';
var pemkeyName = '';
var gateway = '';
var path = require('path')
var log = require('../utility/log.js')


if (process.env.moneyEnv === 'dev') {

    pemName = path.join(__dirname, 'PushCert.pem');
	pemkeyName = path.join(__dirname, 'PushKey.pem');
	//gateway = 'gateway.sandbox.push.apple.com';

    console.log(pemName);
    console.log(pemkeyName);
    console.log(gateway);
}

if (process.env.moneyEnv === 'pro') {
	pemName = 'StockPubPro.pem';
	pemkeyName = 'StockPubKey.pem';
	//gateway = 'gateway.push.apple.com';
}

var service = new apn.Provider({
    cert: pemName,
    key: pemkeyName,
    passphrase: '888888',
    //port: 2195
});

exports.pushMsg = function(token, alertMsg, payload) {

    var note = new apn.Notification({
	       alert:  alertMsg,
           badge: 1
    });

    note.payload = payload;

    service.send(note, token).then( result => {
        console.log(JSON.stringify(result));

        if(result.failed.length > 0) {
            log.error(JSON.stringify(result.failed), log.getFileNameAndLineNum(__filename))
        }
    });

}
