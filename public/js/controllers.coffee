MS_IN_DAY = 1000 * 60 * 60 * 24

angular.module('app').controller('SortCtrl',($scope, $routeParams)->
	$scope.current ?= {sort:{}}

	$scope.current.sort.mode = $routeParams.mode || 'id'
	$scope.current.sort.dir = $routeParams.dir || 'desc'

	this
).controller('LoginCtrl', ($scope, $location, $http, sync) ->

	$scope.login = ()->
		if not $scope.authform.$valid
			return
		$scope.error = null
		console.log('login')
		$http.post('/login', $scope.current.user)
		.success((user, status)->
				user.isAuthenticated = true
				console.log(user)
				$scope.current.user = user
				sync.connect()
				$location.path('/')
		).error((data, status)->
			$scope.error = 'Wrong username or password'
		)

	$scope.register = ()->
		if not $scope.authform.$valid
			return
		$scope.error = null
		console.log('reg')
		$http.post('/register', $scope.current.user)
		.success((user, status)->
			user.isAuthenticated = true
			console.log(user)
			$scope.current.user = user
			sync.connect()
			$location.path('/')
		).error (data, status)->
			$scope.error = data.msg
).controller('LogoutCtrl', ($scope, $http, $location)->
	$http.get('/logout')
	$scope.current.user = {}
	$location.path('/login')
).controller('MainCtrl', ($scope, $rootScope, $location, $http, todoDAO, todoList, inputParser, sync) ->
	$scope.current ?= {sort:{}}
	$scope.current.user ?= {}

	$http.get('/user').success((user)->
		console.log(user)
		user.isAuthenticated = true
		$scope.current.user = user
		sync.connect()
	).error((data)->
		$location.path('/login')
	)

	$scope.current.todoList = todoDAO.list()
	watcher = ()->
		console.log(todoList.items)
		todoList.items
	$rootScope.$watch(watcher, (old, newval)->
		return if old is newval
		$scope.current.todoList = todoList.items
	true)

	$scope.submitTodo = (input) ->
		todo = inputParser.parse(input)
		if ($scope.current.addform.$valid)
			todoDAO.save(todo)

			$scope.current.input = ''
			$scope.current.addform.$setPristine()

	$scope.updateTodo = (todo, input)->
		upd = inputParser.parse(input)
		todo.title = upd.title
		todo.date = upd.date
		todo.priority = upd.priority
		todo.editMode = false
		todoDAO.update(todo)

	$scope.deleteTodo = (id) ->
		todoDAO.remove {id}

	$scope.editMode = (todo)->
		if not todo.done
			todo.editMode = true

	$scope.markDone = (todo, status)->
		todo.done = status
		todoDAO.save todo

	$scope.sort = ()->
		console.log('sort')

	$scope.dueDays = (date)->
		(date - (new Date).getTime()) / MS_IN_DAY
	this
)