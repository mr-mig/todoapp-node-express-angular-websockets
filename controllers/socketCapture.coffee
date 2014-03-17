userDAO = require('../services/userDAO')
socketDAO = require('../services/socketDAO')

module.exports = (req, res)->
	userDAO.find(req.session.passport.user).then((user)->
		socketDAO.store(user.username, req.io)
		req.io.emit('user', user)
	).done()
