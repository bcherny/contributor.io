
# deps
contributor = require './contributor'
express = require 'express'

# configure server
app = do express
app.use do express.logger

# routes
app.get '/api', (req, res) ->

	console.log 'api!'

	identities = {}

	success = (counts) ->
		res.send counts

	error = (counts) ->
		res.send 404

	# get passed identities
	for platform in contributor.support
		param = req.query[platform]
		if param
			identities[platform] = param

	# query
	contributor(identities).then success, error

# export
exports.app = app