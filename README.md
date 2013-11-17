contributor.io
==============

Fetch counts of a user's contributions to various platforms (Github, NPM, ...)

*Web service coming soon...*

## Platform support

### Current

- Github
- NPM
- Rubygems

### Future

- Bower
- Component

## Usage

```coffee
contributor = require 'contributor.io'

contributor
	gem: 'bcherny'
	github: 'eighttrackmind'
	npm: 'bcherny'
.then (counts) ->

	# returns an object with counts, eg.:
	# {
	#	gem: 20
	#	github: 50
	#	npm: 45
	# }
```

## Environment support

- Node
- CommonJS