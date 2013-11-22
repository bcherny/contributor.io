
contributor = require '../contributor'

exports.contributor = (test) ->

	test.expect 5

	contributor
		gem: 'bcherny'
		github: 'eighttrackmind'
		npm: 'bcherny'
		cpan: 'FAYLAND'
		nuget: 'microsoft'
	.then (counts) ->

		gemIsZero = counts.gem is 0
		githubIsMoreThan10 = counts.github > 10
		npmIsMoreThan10 = counts.npm > 10
		cpanIsMoreThan10 = counts.cpan > 10
		nugetIsMoreThan10 = counts.nuget > 10

		test.equals gemIsZero, true
		test.equals githubIsMoreThan10, true
		test.equals npmIsMoreThan10, true
		test.equals cpanIsMoreThan10, true
		test.equals nugetIsMoreThan10, true

		do test.done