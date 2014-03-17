setup = require('./routeSetup')
home = require('../controllers/home')
login = require('../controllers/login')
logout = require('../controllers/logout')
tpls = require('../controllers/tpls')
todo = require('../controllers/todo')
socketCapture = require('../controllers/socketCapture')
register = require('../controllers/register')
auth = require('../auth')

local = auth.local()
token = auth.bearer()
authed = auth.authenticated

routes =
	'get /tpls/*': tpls

	'post /login': [local, login]
	'post /register': register
	'get /logout': logout
	'get /user': [authed, login]

	'get /api/list': [token, todo.list]
	'post /api/create': [token, todo.create]
	'delete /api/delete/:id': [token, todo.remove]
	'post /api/update/:id': [token, todo.update]
	'post /api/input' : [token, todo.parseInput]

	'get /todo': [authed, todo.list]
	'post /todo': [authed, todo.create]
	'post /todo/:id': [authed, todo.update]
	'delete /todo/:id': [authed, todo.remove]

	'get /' : home

	'io ready' : socketCapture

module.exports = setup.bind(null, routes)