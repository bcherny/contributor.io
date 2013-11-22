
# deps
_ = require 'lodash'
contributor = require './contributor'
cors = require 'cors'
express = require 'express'
request = require 'request'

# configure server
app = do express
app.use do cors
app.use do express.logger

# request validator
validate = (req, res) ->

	# check that query parameters were sent
	if not (_.keys req.query).length
		error res, 400, 'Error: API requires one or more identities passed as query parameters'

# error handler
error = (res, code, message) ->

	res.send code,
		status: code
		message: message or ''

# query
query = (res, identities) ->

	(contributor identities).then (counts) ->
		res.send 200, counts
	, (e) ->
		error res, 404, e

# routes
app.get '/api', (req, res) ->

	identities = {}

	# validate request
	validate req, res

	# get passed identities
	for platform in contributor.support
		param = req.query[platform]
		if param
			identities[platform] = param

	# query!
	query res, identities

# export
exports.app = app