
# deps
_ = require 'lodash'
contributor = require './contributor'
cors = require 'cors'
express = require 'express'
https = require 'https'

# configure server
app = do express
app.use do cors
app.use do express.logger

# error handler
error = (res, code, message) ->

	res.send code,
		status: code
		message: message or ''

# request validator
validate = (req, res) ->

	# check that query parameters were sent
	if not (_.keys req.query).length
		error res, 400, 'Error: API requires one or more identities passed as query parameters'

# authorize github?
if process.env.github_oauth_id

	options =
		host: 'https://github.com'
		path: "/login/oauth/authorize?client_id=#{process.env.github_oauth_id}"
		headers:
			Accept: 'application/json'
	
	req = https.get options, (res) ->
		console.log res
		do init

	req.on 'error', (e) ->
		throw new Error e

else do init

init = ->

	# routes
	app.get '/api', (req, res) ->

		identities = {}

		success = (counts) ->
			res.send 200, counts

		# validate request
		validate req, res

		# get passed identities
		for platform in contributor.support
			param = req.query[platform]
			if param
				identities[platform] = param

		# query
		(contributor identities).then success, (e) ->
			error res, 404, e

# export
exports.app = app