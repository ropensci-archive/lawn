lawn 0.4.0
==========

### NEW FEATURES

* `view()` gains `.feature` method to plot `feature` class objects (#57)
* gains new function `as.feature` to attempt to coerce strings or json
to features (#71)
* Xxxxx (#51) (#67) (#68) (#69) (#73) (#74)

### MINOR IMPROVEMENTS

* lots of documentation consistency improvements (#58)
* Now running on `simple-statistics` `v4.1.0` (very close to the
latest version on NPM) (#66)
* Started adding type checks to functions, only in `lawn_within` and
`lawn_buffer` for now. These are type checks to check that the correct
GeoJSON types (e.g., Feature or FeatureCollection) are passed. Will finish
off remainder of package later (#65)

### BUG FIXES

* Xxxxx (#xxx)
* Xxxxx (#xxx)
* Xxxxx (#xxx)


lawn 0.3.0
==========

### NEW FEATURES

* Updated to using turf.js `v3.5.2` (#49) (#50), with the following significant
changes. Defunct functions (these methods were removed from turf, so
made sense to remove them here): `lawn_aggregate`, `lawn_jenks`,
`lawn_quantile`, `lawn_reclass`, `lawn_size`. New functions (these methods
were added to turf): `lawn_circle`, `lawn_collect`, `lawn_bbox`,
`lawn_feature`, `lawn_tesselate`. New data functions
to create geojson: `lawn_multipoint`, `lawn_multipolygon`,
`lawn_multilinestring`, `lawn_geometrycollection`.
* `as.turf` gains S3 methods for `multipoint`, `multipolygon`,
`multilinestring`, and `geometrycollection`.
* `lawn_featurecollection` gains a default S3 method to error
gracefully on classes not supported, and gains S3 methods for `multipoint`,
`multipolygon`, `multilinestring`, and `geometrycollection`.
* `lawn_erase` renamed to `lawn_difference`, following turf changes
* `lawn_average` parameter name changes: `field` to `in_field`,
`outputField` to `out_field`
* `lawn_count` loses parameter `countField`, and gains parameters
`in_field`, and `out_field` (with default 'count')
* `lawn_deviation` parameter name changes: `inField` to `in_field`,
`outField` to `out_field` (with default 'deviation')
* `lawn_max` parameter `out_field` with new default value 'max'
* `lawn_median` parameter `out_field` with new default value 'median'
* `lawn_min` parameter `out_field` with new default value 'min'
* `lawn_sum` parameter `out_field` with new default value 'sum'
* `lawn_variance` parameter `out_field` with new default value 'variance'
* all aggregatation/math functions (`lawn_average`, `lawn_count`, `lawn_deviation`,
`lawn_max`, `lawn_median`, `lawn_min`, `lawn_sum`, `lawn_variance`)
use `turf.collect` internally, same method that's used in `lawn_collect`

### MINOR IMPROVEMENTS

* Fixed example for `lawn_tag()` that wasn't working. Also,
`poly_id` parameter changed to `field`, and `containing_polyid`
changed to `out_field`. (#30)
* `lawn_merge` uses new turf method `turf.union` internally, but
no user facing changes
* Changed `x` parameter to `coordinates` in `lawn_point` for
consistency with similar methods
* Changed `rings` parameter to `coordinates` in `lawn_polygon` for
consistency with similar methods
* Internal changes to `lawn_remove` following turf changes, but
there should be no  user facing changes

### BUG FIXES

* Fixed bug in `lawn_buffer()` (#53)
* Fixed bug in `lawn_random()`. `num_vertices` parameter wasn't working (#44)


lawn 0.1.7
==========

### BUG FIXES

* Fixes tests (#46)

lawn 0.1.6
==========

### MINOR IMPROVEMENTS

* Fixes expectations in test suite on failure for new V8 version (#45)
* Updated `geojsonhint` Javascript library (`v1.2.0`) (#42)

lawn 0.1.4
==========

### NEW FEATURES

* Added a code of conduct

### MINOR IMPROVEMENTS

* Implemented print methods for most output objects for easier
comprehension (#26)

### BUG FIXES

* Import all non-base R functions, now from `methods`, `stats`,
and `utils` (#40)


lawn 0.1.0
==========

### NEW FEATURES

* released to CRAN
