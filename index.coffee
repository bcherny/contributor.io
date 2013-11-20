
# deps
_ = require 'lodash'
contributor = require './contributor'
express = require 'express'
ejs = require 'ejs'
fs = require 'fs'
highlight = (require 'highlight').Highlight

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

			html = ejs.render do template.toString,
				name: pkg.name
				description: pkg.description
				support: ['github', 'NPM', 'CPAN', 'Ruby Gems']

			#highlight html, false, true

			res.send html

# export
exports.app = app