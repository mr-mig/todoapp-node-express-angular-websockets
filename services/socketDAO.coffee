socketDB = {}

get = (username)->
	if not socketDB[username]
		socketDB[username] = []
	socketDB[username]

store = (username, socket)->
	if not socketDB[username]
		socketDB[username] = []
	if socketDB[username].indexOf(socket) is -1
		socketDB[username].push(socket)

module.exports = {get, store}