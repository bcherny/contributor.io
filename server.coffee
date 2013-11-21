
# deps
api = require './api'
index = require './index'
express = require 'express'
os = require 'os'

# environment sniffing is dirty dirty!
heroku = do os.hostname is '62294dc8-5733-4d4b-a1cd-a4a014dc6e6c'

# configuration
config =
	port: process.env.PORT or 5000
	static: ['css', 'js', 'img']
	host: if heroku then 'contributor.io' else 'localhost'
	subdomains:
		api: 'api.'
		index: if heroku then 'www.' else ''

# configure server
app = do express
#app.use do express.logger

# (sub)domains
app.use express.vhost "#{config.subdomains.index}#{config.host}", index.app
app.use express.vhost "#{config.subdomains.api}#{config.host}", api.app

# static resources
for route in config.static
	app.use "/#{route}", express.static "#{__dirname}/#{route}"

# start server
app.listen config.port
