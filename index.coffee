
# deps
contributor = require './contributor'
express = require 'express'
ejs = require 'ejs'
fs = require 'fs'

# data for template
config = {}

# configure server
app = do express
app.use do express.logger

# routes
app.get '/', (req, res) ->

	fs.readFile 'templates/index.ejs', (err, template) ->

		if err
			throw new Error err

		res.send ejs.render template.toString(), config

# export
exports.app = app