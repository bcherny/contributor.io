
# deps
_ = require 'lodash'
promise = require 'when'
apis =
	github: require 'github-repos'
	npm: require 'npm-packages'

# exports
module.exports = contributor

# contributor

whitelist = ['github', 'npm']

contributor = (identities = {}) ->

	deferred = promise.defer()
	counts = 0
	have = 0
	need = 0

	done = (platform, count) ->

		counts[platform] = count

		if ++have is need
			deferred.resolve counts

		else
			deferred.notify counts

	whitelist.forEach (platform) ->
		++need
		if platform of identities
			apis[platform](identities[platform]).then (count) ->
				done platform, count
			, deferred.reject

	# return
	deferred.promise

contributor
	github: 'eighttrackmind'
	npm: 'bcherny'
.then (counts) ->

	console.log counts