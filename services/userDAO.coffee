sjcl = require('sjcl')
vow = require('vow')

SALT = 'salt_541'
NUM_ITERATIONS = 100

userDB =
	_idSequence : 0
	entries : []

find = (username)->
	def = vow.defer()
	usr = userDB.entries.filter((it)-> it.username is username)[0]
	def.resolve(usr)
	def.promise()

findByToken = (token)->
	def = vow.defer()
	usr = userDB.entries.filter((it)-> it.token is token)[0]
	def.resolve(usr)
	def.promise()

create = (user) ->
	def = vow.defer()
	user.password = hashPass(user.password)
	user.id = ++userDB._idSequence
	user.token = generateToken()
	userDB.entries.push(user)
	def.resolve(user)
	def.promise()

update = (user) ->
	def = vow.defer()
	usr = find(user.username)
	usr.password = hashPass user.password if user.password
	usr.todos = user.todos if user.todos
	usr.token = user.token if user.token
	def.resolve(usr)
	def.promise()

hashPass = (pass)->
	sjcl.codec.hex.fromBits sjcl.misc.pbkdf2(pass, sjcl.codec.utf8String.toBits SALT, NUM_ITERATIONS)

generateToken = ->
	rand = -> Math.random().toString(36).substr(2)
	rand() + rand()

dump = ()->
	console.dir(userDB.entries)

module.exports = {find, findByToken, create, update, hashPass, dump}