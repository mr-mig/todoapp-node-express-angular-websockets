// Generated by CoffeeScript 2.0.0-beta7
void function () {
  var get, socketDB, store;
  socketDB = {};
  get = function (username) {
    if (!socketDB[username])
      socketDB[username] = [];
    return socketDB[username];
  };
  store = function (username, socket) {
    if (!socketDB[username])
      socketDB[username] = [];
    if (socketDB[username].indexOf(socket) === -1)
      return socketDB[username].push(socket);
  };
  module.exports = {
    get: get,
    store: store
  };
}.call(this);

//# sourceMappingURL=socketDAO.js.map
