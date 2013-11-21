
# deps
_ = require 'lodash'
promise = require 'when'
apis =
	gem: require 'gem-count'
	github: require 'github-repos'
	npm: require 'npm-packages'
	cpan: require 'cpan-count'

# contributor
contributor = (identities = {}) ->

	deferred = promise.defer()
	counts = {}
	have = 0
	need = 0

	check = ->

		action = if ++have is need then 'resolve' else 'notify'
		deferred[action] counts

	success = (platform, count) ->

		counts[platform] = count
		do check

	error = (platform, err) ->

		if typeof err is 'object' and err isnt null
			err = err.toString()

		if typeof err is 'string' and (err.charAt 0) is '{'
			err = JSON.parse err

		counts[platform] = err
		do check

	_.each apis, (fn, platform) ->
		if platform of identities

			++need

			fn(identities[platform]).then (count) ->
				success platform, count
			, (err) ->
				error platform, err

	# return
	deferred.promise

# add "supported" array
contributor.support = _.keys apis

# exports
module.exports = contributor