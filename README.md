contributor.io
==============

[![Build Status](https://travis-ci.org/eighttrackmind/contributor.io.png)](https://travis-ci.org/eighttrackmind/contributor.io.png)

Fetch counts of a user's contributions to various platforms (Github, NPM, Gem, CPAN, ...)

## Platform support

### Current

- Github
- NPM
- Rubygems
- CPAN

### Future

- Bower
- Component

## Usage

### ...Via API

Send a `GET` request to [contributor.io/api](http://contributor.io/api) with each platform/username you'd like as a query parameter.

[CLI example](https://gist.github.com/eighttrackmind/7571801)

[JavaScript example](https://gist.github.com/eighttrackmind/7571653)

### ...As a server

```bash
# install dependencies
npm install

# start server
node server

# send a request!
curl localhost:5000/api?github=myGithubUsername&npm=myNpmUsername
# => { github: 42, npm: 66 }
```

To add Github authentication (optional, increase request limit):

1. [Register a Github Application](http://developer.github.com/guides/basics-of-authentication/) to receive an oauth2 `id` and `secret`.

2. Define `process.env.github_oauth_id` and `process.env.github_oauth_secret` somewhere (eg. at the top of `contributor.coffee`) and set them equal to the keys you got in Step #1.

### ...Or as a package

```bash
# install dependencies
npm install
```
And in your (coffee)script:

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