// Generated by CoffeeScript 2.0.0-beta7
void function () {
  var userDAO, vow;
  userDAO = require('../services/userDAO');
  vow = require('vow');
  module.exports = function (req, res) {
    var login, user;
    user = req.body;
    userDAO.find(user.username).then(function (found) {
      console.log('after reg', found);
      if (!found) {
        return userDAO.create(user).then(login).then(function (user) {
          return res.json(200, user);
        }).fail(function (err) {
          return res.json(409, { msg: err });
        }).done();
      } else {
        userDAO.dump();
        return res.json(409, { msg: 'User ' + found.username + ' already exists' });
      }
    }).done();
    return login = function (user) {
      var def;
      console.log('login attempt');
      def = vow.defer();
      req.login(user, function (err) {
        userDAO.dump();
        if (err) {
          return def.reject(err);
        } else {
          return def.resolve(user);
        }
      });
      return def.promise();
    };
  };
}.call(this);

//# sourceMappingURL=register.js.map
