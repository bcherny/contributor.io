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

## Usage

### Via API

Send a `GET` request to [contributor.io/api](http://contributor.io/api) with each platform/username you'd like as a query parameter.

#### Bash example:

```bash
curl http://contributor.io/api?github=eighttrackmind&npm=bcherny
```

#### JavaScript example:

```js
var xhr = new XMLHttpRequest()
  , url = 'http://contributor.io/api?github=eighttrackmind&npm=bcherny&gem=bcherny';

xhr.onreadystatechange = function () {
	if (req.readyState === 4) {
		var response = xhr.responseText
		  , status = xhr.status;

		if (status < 400) {

			var counts = JSON.parse(response);

			// `counts` is an object with package counts, eg.:
			// {
			//	gem: 20,
			//	github: 50,
			//	npm: 45
			// }

		} else {
			throw new Error(response);
		}
	}
};

xhr.open(url);
xhr.send();
```

### As a server

```bash
# install dependencies
npm install

# start server
node server

# send a request!
curl localhost:5000/api?github=myGithubUsername&npm=myNpmUsername
# => { github: 42, npm: 66 }
```

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