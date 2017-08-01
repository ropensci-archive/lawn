# JS dependencies

## turf

Currently (as of 2017-07-26) using `turf` `v4.5.2`

To recreate `inst/js/turf452.js`:

Download the minified file from <https://npmcdn.com/@turf/turf@4.5.2/turf.min.js>
to `inst/js` directory in the `lawn` package

List methods available

```r
library(V8)
ct <- V8::v8()
ct$source(system.file("js/turf452.js", package = 'lawn'))
funs <- ct$get(JS('Object.keys(turf)'))
sort(funs)

# a single function
ct$eval('turf.isolines')
```


## @turf/meta

Currently (as of 2017-06-13) using `turf/meta` `v4.4.0`

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

Currently (as of 2017-06-13) using `turf/invariant` `v4.4.0`

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

Currently (as of 2017-05-06) using `simple-statistics` `v4.1.0`

To recreate `inst/js/simple-statistics.js`:

Download the minified file from <https://npmcdn.com/simple-statistics@4.1.0/dist/simple-statistics.min.js>
to `inst/js` directory in the `lawn` package



## geojsonhint

Currently (as of 2017-06-13) using `geojsonhint` `v2.0.1`

To recreate `inst/js/geojsohint-v201.js`:

Install `geojsonhint` from NPM

```
npm i @mapbox/geojsonhint
```

Browserify

```
echo "global.geojsonhint = require('@mapbox/geojsonhint');" > in.js
browserify in.js -o geojsohint-v201.js
```

Copy js file into the `inst/js` directory in the `lawn` package

```
cp geojsohint-v201.js lawn/inst/js
```



## clone

Currently (as of 2017-06-13) using `clone` `v2.1.1`

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

Currently (as of 2017-06-13) using `geojson-random` `v0.4.0`

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
