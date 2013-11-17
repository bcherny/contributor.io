
contributor = require '../contributor'

exports.contributor = (test) ->

	test.expect 3

	contributor
		gem: 'bcherny'
		github: 'eighttrackmind'
		npm: 'bcherny'
	.then (counts) ->

		gemIsZero = counts.gem is 0
		githubIsMoreThan10 = counts.github > 10
		npmIsMoreThan10 = counts.npm > 10

		test.equals gemIsZero, true
		test.equals githubIsMoreThan10, true
		test.equals npmIsMoreThan10, true
		
		test.done()