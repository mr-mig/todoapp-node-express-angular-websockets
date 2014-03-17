wireUp = (config, app) ->
	Object.keys(config).forEach (key) ->
		method = key.split(" ")[0]
		path = key.split(" ")[1]
		handler = config[key]
		if method is "io"
			app.io.route path, handler
		else
			app[method] path, handler

module.exports = wireUp