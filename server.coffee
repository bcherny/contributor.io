
# deps
contributor = require './contributor'
express = require 'express'

# configuration
config =
	port: 5000

# configure server
app = express()
app.use express.logger()

# start server
app.listen config.port

# routes
app.get '/', (req, res) ->

	identities = {}

	# get passed identities
	for platform in contributor.support
		param = req.query[platform]
		if param
			identities[platform] = param

	# query
	contributor(identities).then (counts) ->
		console.log counts