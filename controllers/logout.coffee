module.exports = (req, res)->
	req.logout()
	res.json(200, {status: 'ok'})