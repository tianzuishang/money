var path = require('path');
require('shelljs/global');
console.log(__dirname);
var mainPath = path.dirname(__dirname);
exec('pm2 stop '+path.join(mainPath, 'app.js'));
