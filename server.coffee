
# deps
api = require './api'
index = require './index'
express = require 'express'

# configuration
config =
	port: process.env.PORT or 5000
	static: ['css', 'js', 'img']

# configure server
app = do express
#app.use do express.logger

# (sub)domains
app.use index.app
app.use api.app

# static resources
for route in config.static
	app.use "/#{route}", express.static "#{__dirname}/#{route}"

# start server
app.listen config.port
