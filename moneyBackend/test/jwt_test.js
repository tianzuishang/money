var jwt = require('jwt-simple');
var payload = { user: 'wanghan' };
var secret = 'babyface';
var decoded = jwt.decode('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoid2FuZ2hhbiIsInBhc3N3b3JkIjoid2FuZ2hhbiJ9.-CyL7sTpAzLsGDQpgshWeP3WKPlcaSorqzSWqH06smI',
secret);
console.log(decoded); //=> { foo: 'bar' }
