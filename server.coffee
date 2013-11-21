
# deps
api = require './api'
index = require './index'
express = require 'express'
os = require 'os'

# configuration
config =
	port: process.env.PORT or 5000
	static: ['css', 'js', 'img']
	heroku: do os.hostname is '62294dc8-5733-4d4b-a1cd-a4a014dc6e6c' # environment sniffing is dirty dirty!

config.host = if config.heroku then 'contributor.io' else 'localhost'
config.indexSubdomain = if config.heroku then 'www.' else ''

# configure server
app = do express
#app.use do express.logger

# (sub)domains
app.use express.vhost "#{config.indexSubdomain}#{config.host}", index.app
app.use express.vhost "api.#{config.host}", api.app

# static resources
for route in config.static
	app.use "/#{route}", express.static "#{__dirname}/#{route}"

# start server
app.listen config.port
