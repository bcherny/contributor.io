
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
app.use do express.logger

# routes (dynamic)
app.use index.app
app.use api.app

# google analytics?
if process.env.heroku
	ga = require 'node-ga'
	app.use do express.cookieParser
	app.use ga 'UA-45941700-1',
		safe: true

# routes (static resources)
for route in config.static
	app.use "/#{route}", express.static "#{__dirname}/#{route}"

# start server
app.listen config.port
