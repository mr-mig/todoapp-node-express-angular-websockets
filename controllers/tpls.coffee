module.exports = (req, res) ->
	res.render req.path.substr(1)