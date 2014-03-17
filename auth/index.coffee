passport = require('passport')
LocalStrategy = require('passport-local').Strategy
BearerStrategy = require('passport-http-bearer').Strategy
psioAuth = require('passport.socketio')
express = require('express.io')
userDAO = require('../services/userDAO')

configure = ->
	passport.use new LocalStrategy (username, password, done)->

		checkPass = (user)->
			console.log(user)
			if not user
				done(null, false, {message: 'No user'})
			if user.password isnt userDAO.hashPass(password)
				done(null, false, {message: 'Wrong password'})
			else
				done(null, user)
			this

		console.log('local auth')
		userDAO.find(username)
		.then(checkPass)
		.fail(done)
		.done()

		this


	passport.use new BearerStrategy (token, done)->
		console.log('token auth')
		userDAO.findByToken(token).then((user)->
			if not user
				done(null, false, {message: 'Wrong token'})
			else
				done(null, user)
		).fail done

	passport.serializeUser (user, done)->
		done(null, user.username)

	passport.deserializeUser (username, done)->
		userDAO.find(username)
		.then((user)->
			done(null, user)
		).fail((err)->
			done err
		).done()

configureIO = ->
	express.io.set('authorization', psioAuth.authorize(
		cookieParser : express.cookieParser
		secret: 'somesesi1onSikrit09#123'
		success: ioAuthSuccess
		fail : ioAuthFail
	))

ioAuthSuccess = (data, accept)->
	accept null, true

ioAuthFail = (data, msg, error, accept)->
	if error
		throw new Error error
	accept null, false

local = ()->
	passport.authenticate 'local'

bearer = ()->
	passport.authenticate('bearer', {
		session: false
	})

authenticated = (req, res, next)->
	if req.user
		next()
	else
		next('Not authenticated')

module.exports = {local, bearer, configure, authenticated, configureIO}