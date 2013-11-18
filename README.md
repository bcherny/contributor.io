contributor.io
==============

[![Build Status](https://travis-ci.org/eighttrackmind/contributor.io.png)](https://travis-ci.org/eighttrackmind/contributor.io.png)

Fetch counts of a user's contributions to various platforms (Github, NPM, Gem, CPAN, ...)

*Web service coming soon...*

## Platform support

### Current

- Github
- NPM
- Rubygems
- CPAN

### Future

- Bower
- Component

## Usage (as server)

```bash
# install dependencies
npm install

# start server
node server

# send a request!
curl localhost:5000?github=myGithubUsername&npm=myNpmUsername
```

## Usage (as package)

```coffee
contributor = require 'contributor.io'

contributor
	gem: 'bcherny'
	github: 'eighttrackmind'
	npm: 'bcherny'
	cpan: 'FAYLAND'
.then (counts) ->

	# returns an object with counts, eg.:
	# {
	#	gem: 20
	#	github: 50
	#	npm: 45
	#	cpan: 67
	# }
```

### Get supported platforms

```coffee
contributor = require 'contributor.io'

contributor.support #=> returns an array of supported platforms
```

## Environment support

- Node
- CommonJS