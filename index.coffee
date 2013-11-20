
# deps
_ = require 'lodash'
contributor = require './contributor'
express = require 'express'
fs = require 'fs'
highlight = (require 'highlight').Highlight

# configure server
app = do express
#app.use do express.logger

# platform descriptions
descriptions =
	cpan: 'CPAN username'
	gem: 'Rubygems username'
	github: 'Github username'
	npm: 'NPM username'

# routes
app.get '/', (req, res) ->

	# feed some data from package.json
	fs.readFile 'package.json', (err, pkg) ->

		pkg = JSON.parse pkg

		# load the template
		fs.readFile 'templates/index.html', (err, template) ->

			if err
				throw new Error err

			html = _.template do template.toString,
				name: pkg.name
				description: pkg.description
				support: _.pick descriptions, (value, key) -> key in contributor.support

			#highlight html, false, true

			res.send html

# export
exports.app = app