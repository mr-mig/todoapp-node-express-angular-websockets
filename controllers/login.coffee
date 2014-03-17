module.exports = (req, res)->
	res.json(200, req.user)