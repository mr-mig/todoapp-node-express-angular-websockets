userDAO = require('../services/userDAO')
vow = require('vow')

module.exports = (req, res)->
	user = req.body
	userDAO.find(user.username).then((found)->
		console.log('after reg', found)
		if not found
			userDAO.create(user)
			.then(login)
			.then((user)->
				res.json(200, user)
			).fail((err)->
				res.json(409, {msg: err})
			).done()
		else
			userDAO.dump()
			res.json(409, {msg: 'User ' + found.username + ' already exists'})
	).done()

	login = (user)->
		console.log('login attempt')
		def = vow.defer()
		req.login(user, (err)->
			userDAO.dump()
			if err
				def.reject(err)
			else
				def.resolve(user)
		)
		def.promise()