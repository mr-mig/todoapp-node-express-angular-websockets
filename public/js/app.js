// Generated by CoffeeScript 2.0.0-beta7
void function () {
  var module;
  module = angular.module('app', [
    'ngRoute',
    'ngResource',
    'ngSanitize',
    'ui.bootstrap'
  ]);
  module.config(function ($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $locationProvider.hashPrefix('!');
    $routeProvider.when('/sort/:mode/:dir', {
      controller: 'SortCtrl',
      templateUrl: '/tpls/list'
    }).when('/login', {
      controller: 'LoginCtrl',
      templateUrl: '/tpls/login'
    }).when('/logout', {
      controller: 'LogoutCtrl',
      templateUrl: '/tpls/login'
    }).otherwise({
      redirectTo: '/',
      templateUrl: '/tpls/list',
      controller: 'SortCtrl'
    });
    return console.log('configured');
  });
  module.run(function () {
    return console.log('module run');
  });
}.call(this);

//# sourceMappingURL=app.js.map
