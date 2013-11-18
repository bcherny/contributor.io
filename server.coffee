
# deps
contributor = require './contributor'
express = require 'express'

# configuration
config =
	port: 8000

# configure server
app = express()
app.use cors()
app.use express.bodyParser()
app.use express.logger()

# start server
app.listen config.port

console.log contributor

# routes
app.get '/', (req, res) ->

	npm = req.query.npm