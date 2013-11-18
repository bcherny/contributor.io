// Generated by CoffeeScript 1.6.3
var app, config, contributor, express;

contributor = require('./contributor');

express = require('express');

config = {
  port: 5000
};

app = express();

app.use(express.logger());

app.listen(config.port);

app.get('/', function(req, res) {
  var identities, param, platform, _i, _len, _ref;
  identities = {};
  _ref = contributor.support;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    platform = _ref[_i];
    param = req.query[platform];
    if (param) {
      identities[platform] = param;
    }
  }
  return contributor(identities).then(function(counts) {
    return console.log(counts);
  });
});
