contributor.io
==============

Fetch counts of a user's contributions to various platforms (Github, NPM, ...)

*Web service coming soon...*

## Platform support

- Github
- NPM

### Future platform support

- Bower
- Component
- Rubygems

## Usage

```coffee
contributor = require 'contributor.io'

contributor
	github: 'eighttrackmind'
	npm: 'bcherny'
.then (counts) ->

	# returns an object with counts, eg.:
	# {
	#	github: 50
	#	npm: 45
	# }
```

## Environment support

- Node
- CommonJS