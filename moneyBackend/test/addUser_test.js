var conn = require('../model/utility.js');


var password = {
    password: 'wanghan'
};

conn.redisHset('userAccountHash', 'wanghan', password, function(err, reply){
    if (err) {
        console.log(err);
    }else{
        console.log('ok');
    }
});
