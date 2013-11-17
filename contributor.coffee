
# deps

_ = require 'lodash'
promise = require 'when'
apis =
	gem: require 'gem-count'
	github: require 'github-repos'
	npm: require 'npm-packages'

# contributor

contributor = (identities = {}) ->

	deferred = promise.defer()
	counts = {}
	have = 0
	need = 0

	done = (platform, count) ->

		counts[platform] = count

		if ++have is need
			deferred.resolve counts

		else
			deferred.notify counts

	_.each apis, (fn, platform) ->
		if platform of identities

			++need

			fn(identities[platform]).then (count) ->
				done platform, count
			, deferred.reject

	# return
	deferred.promise

# exports
module.exports = contributor