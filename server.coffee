
# deps
contributor = require './contributor'
express = require 'express'

# configuration
config =
	port: 8000

# configure server
app = express()
app.use express.bodyParser()
app.use express.logger()

# start server
app.listen config.port

# routes
app.get '/', (req, res) ->

	# get passed usernames

	params = {}

	for platform in contributor.support

		params[platform] = req.query[platform]