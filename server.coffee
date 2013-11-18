
# deps
api = require './api'
index = require './index'
express = require 'express'

# configuration
config =
	port: 5000

# configure server
app = do express
app.use do express.logger
app.use express.vhost 'localhost', index.app
app.use express.vhost 'api.localhost', api.app

# start server
app.listen config.port
