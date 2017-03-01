# JS dependencies

## turf

Currently (as of 2017-02-28) using `turf` `v3.10.4`

To recreate `inst/js/turf3104.js`:

Download the minified file from <https://npmcdn.com/@turf/turf@3.10.4/turf.min.js>
to `inst/js` directory in the `lawn` package



## @turf/meta

Currently (as of 2017-02-28) using `turf/meta` `v3.10.4`

To recreate `inst/js/turf-meta.js`:

```
npm install @turf/meta
```

Browserify

```
echo "global.turfmeta = require('@turf/meta');" > in.js
browserify in.js -o turf-meta.js
```

Copy js file into the `inst/js` directory in the `lawn` package

```
cp turf-meta.js lawn/inst/js/
```



## @turf/invariant

Currently (as of 2017-02-28) using `turf/invariant` `v3.10.4`

To recreate `inst/js/turf-invariant.js`:

```
npm install @turf/invariant
```

Browserify

```
echo "global.turfinvariant = require('@turf/invariant');" > in.js
browserify in.js -o turf-invariant.js
```

Copy js file into the `inst/js` directory in the `lawn` package

```
cp turf-invariant.js lawn/inst/js/
```



## simple-statistics

Currently (as of 2016-10-12) using `simple-statistics` `v2.1.0`

To recreate `inst/js/simple-statistics.js`:

Download the minified file from <https://npmcdn.com/simple-statistics@2.0.1/dist/simple-statistics.min.js>
to `inst/js` directory in the `lawn` package

## geojsonhint

Currently (as of 2016-10-12) using `geojsonhint` `v2.0.0-beta2`

To recreate `inst/js/geojsohint-v2beta.js`:

Install `geojsonhint` from NPM

```
npm install geojsonhint
```

Browserify

```
echo "global.geojsonhint = require('geojsonhint');" > in.js
browserify in.js -o geojsohint-v2beta.js
```

Copy js file into the `inst/js` directory in the `lawn` package

```
cp geojsohint-v2beta.js lawn/inst/js
```

## clone

Currently (as of 2016-10-12) using `clone` `v2.0.0-beta2`

To recreate `inst/js/cloner.js`:

Install `clone` from NPM

```
npm install clone
```

Browserify

```
echo "global.clone = require('clone');" > in.js
browserify in.js -o cloner.js
```

Copy js file into the `inst/js` directory in the `lawn` package

```
cp cloner.js lawn/inst/js
```

## geojson-random

Currently (as of 2016-10-12) using `geojson-random` `v0.2.2`

To recreate `inst/js/geojson_random.js`:

Install `geojson-random` from NPM

```
npm install geojson-random
```

Browserify

```
echo "global.georandom = require('geojson-random');" > in.js
browserify in.js -o geojson_random.js
```

Copy js file into the `inst/js` directory in the `lawn` package

```
cp geojson_random.js lawn/inst/js
```
