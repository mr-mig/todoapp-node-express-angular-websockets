module = angular.module('app',['ngRoute', 'ngResource', 'ngSanitize', 'ui.bootstrap'])
module.config ($routeProvider, $locationProvider)->
	$locationProvider.html5Mode(true)
	$locationProvider.hashPrefix('!')
	$routeProvider
		.when('/sort/:mode/:dir', {
			controller: 'SortCtrl'
			templateUrl : '/tpls/list'
		})
		.when('/login',{
			controller: 'LoginCtrl'
			templateUrl : '/tpls/login'
		})
		.when('/logout',{
			controller: 'LogoutCtrl'
			templateUrl : '/tpls/login'
		})
		.otherwise({
			redirectTo: '/',
			templateUrl : '/tpls/list',
			controller: 'SortCtrl'
		})
	console.log 'configured'

module.run ->
	console.log 'module run'