
# deps
_ = require 'lodash'
contributor = require './contributor'
express = require 'express'
ejs = require 'ejs'
fs = require 'fs'
markdown = require 'markdown'

# configure server
app = do express
app.use do express.logger

# routes
app.get '/', (req, res) ->

	# feed some data from package.json
	fs.readFile 'package.json', (err, pkg) ->

		pkg = JSON.parse pkg

		# load the template
		fs.readFile 'templates/index.ejs', (err, template) ->

			if err
				throw new Error err

			res.send ejs.render template.toString(),
				name: pkg.name
				description: pkg.description

# export
exports.app = app