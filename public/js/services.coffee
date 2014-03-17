angular.module('app').service('todoDAO' , ($resource, todoList)->

	todos = $resource('/todo/:id', {id : '@id'})

	this.save = (todo, skip)->
		entity = new Todo(todo.id, todo.title, todo.date, todo.priority, todo.done)
		if !skip
			entity = todos.save entity
			if todo.id? and not todoList.items.filter((it)-> it.id is todo.id).length
				todoList.items.unshift entity

		else if not todoList.items.filter((it)-> it.id is todo.id).length
			todoList.items.unshift entity

	this.update = (todo, skip)->
		entity = new Todo(todo.id, todo.title, todo.date, todo.priority, todo.done)
		if !skip
			entity = todos.save entity
		item = todoList.items.filter((it)-> it.id is entity.id)[0]
		item.title = entity.title
		item.date = entity.date
		item.priority = entity.priority
		item.done = entity.done

	this.remove = (todo, skip)->
		todoList.items = todoList.items.filter((it)-> it.id isnt todo.id)
		if !skip
			todos.remove {id: todo.id}

	this.list = ()->
		todoList.items = todos.query()
		todoList.items

	this
).service('todoList', ()->
	this.items = []

	this
).service('sync', (todoDAO, $rootScope)->
	this.connect = ()->
		this.socket = io.connect '/'
		this.socket.emit('ready')
		this.socket.on('upd', this.handle)

	this.handle = (response)->
		return if not response.data
		switch response.action
			when 'create' then todoDAO.save(response.data, true)
			when 'remove' then todoDAO.remove(response.data, true)
			when 'update' then todoDAO.update(response.data, true)
		$rootScope.$digest()
	this
)