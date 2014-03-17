socketDAO = require('./socketDAO')

handle = (username, action, data)->
	socketDAO.get(username).forEach (io)->
		io.emit('upd', {action, data})

module.exports = {handle}