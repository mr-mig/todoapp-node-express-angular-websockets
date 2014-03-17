// Generated by CoffeeScript 2.0.0-beta7
void function () {
  var wireUp;
  wireUp = function (config, app) {
    return Object.keys(config).forEach(function (key) {
      var handler, method, path;
      method = key.split(' ')[0];
      path = key.split(' ')[1];
      handler = config[key];
      if (method === 'io') {
        return app.io.route(path, handler);
      } else {
        return app[method](path, handler);
      }
    });
  };
  module.exports = wireUp;
}.call(this);

//# sourceMappingURL=routeSetup.js.map