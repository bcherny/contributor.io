
# deps
_ = require 'lodash'
apis =
	github: require 'github-repos'
	npm: require 'npm-packages'

# exports
module.exports = contributor

# contributor

whitelist = ['github', 'npm']

contributor = (identities = {}) ->

	counts = 0
	have = 0
	need = 0

	whitelist.forEach (platform) ->
		++need
		if platform of identities
			apis[platform](identities[platform]).then (count) ->
				done platform, count
			, error

	done = (platform, count) ->

		counts[platform] = count

		if ++have is need
			resolve()

	resolve = ->

		counts

	error = (err) ->
		throw new Error err