
# deps
_ = require 'lodash'
promise = require 'when'
apis =
	cpan: require 'cpan-count'
	gem: require 'gem-count'
	github: require 'github-repos'
	npm: require 'npm-packages'
	nuget: require 'nuget-count'

# contributor
contributor = (identities = {}) ->

	deferred = do promise.defer
	counts = {}
	have = 0
	need = (_.keys identities).length

	check = ->

		++have

		action = if have is need then 'resolve' else 'notify'
		deferred[action] counts

	success = (platform, count) ->

		counts[platform] = count
		do check

	error = (platform, err) ->

		counts[platform] = err
		do check

	_.each identities, (identity, platform) ->

		fn = apis[platform]

		# use github oauth?
		if platform is 'github' and process.env.github_oauth_id and process.env.github_oauth_secret
			_fn = fn identities[platform], process.env.github_oauth_id, process.env.github_oauth_secret

		else
			_fn = fn identities[platform]

		# query!
		_fn.then (count) ->
			success platform, count
		, (err) ->
			error platform, err

	# return
	deferred.promise

# add "supported" array
contributor.support = _.keys apis

# exports
module.exports = contributor