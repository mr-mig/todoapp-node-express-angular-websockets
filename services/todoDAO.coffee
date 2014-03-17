Todo = require('../public/js/shared/models/Todo')
userDAO = require('./userDAO')
vow = require('vow')

getFor = (usr)->
	userDAO.find(usr.username)
	.then(init)

init = (user)->
	def = vow.defer()
	if not user.todos
		user.todos =
			entries : []
			_idSequence : 0
	todoDB = user.todos

	def.resolve
		create : (todo)->
			todo.id = ++todoDB._idSequence
			todoDB.entries.push(todo)
			todo

		update : (todo)->
			this.find(todo.id)
			.then (item)->
				idx = todoDB.entries.indexOf(item)
				upd = new Todo(todo.id, todo.title, todo.date, todo.priority, todo.done)
				todoDB.entries[idx] = upd
				upd

		remove : (todo)->
			this.find(todo.id)
			.then (item)->
				idx = todoDB.entries.indexOf(item)
				deleted = todoDB.entries.splice(idx, 1)
				deleted[0]

		list : ()->
			def = vow.defer()
			def.resolve(todoDB.entries)
			def.promise()

		find : (id)->
			def = vow.defer()
			item = todoDB.entries.filter((it)-> it.id is id)[0]
			def.resolve(item)
			def.promise()

		dump : ()->
			console.dir(todoDB.entries)

	def.promise()

module.exports = {getFor}