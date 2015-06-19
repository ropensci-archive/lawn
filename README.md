lawn
=======



[![Build Status](https://travis-ci.org/ropensci/lawn.svg?branch=master)](https://travis-ci.org/ropensci/lawn)
[![Build status](https://ci.appveyor.com/api/projects/status/v7d3p3q9j97h0ttw?svg=true)](https://ci.appveyor.com/project/sckott/lawn)
[![Coverage Status](https://coveralls.io/repos/ropensci/lawn/badge.svg)](https://coveralls.io/r/ropensci/lawn)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/lawn?color=2ECC71)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/lawn)](http://cran.rstudio.com/web/packages/lawn)

`lawn` is an R wrapper for the Javascript library [turf.js](http://turfjs.org/). In addition, we have a few functions to interface with the [geojson-random](https://github.com/mapbox/geojson-random) Javascript library.

## Install

The latest release of `lawn` is available from CRAN.  To install:


```r
install.packages("lawn")
```

To install the development version:


```r
install.packages("devtools")
devtools::install_github("rstudio/leaflet")
devtools::install_github("ropensci/lawn")
```



```r
library("lawn")
```

## count

Count number of points within polygons


```r
lawn_count(polygons = lawn_data$polygons_count, points = lawn_data$points_count)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type pt_count geometry.type
#> 1 Feature        2       Polygon
#> 2 Feature        0       Polygon
#>                                                                                           geometry.coordinates
#> 1 -112.07239, -112.07239, -112.02810, -112.02810, -112.07239, 46.58659, 46.61761, 46.61761, 46.58659, 46.58659
#> 2 -112.02398, -112.02398, -111.96613, -111.96613, -112.02398, 46.57043, 46.61502, 46.61502, 46.57043, 46.57043
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## average

Average value of a field for a set of points within a set of polygons


```r
lawn_average(polygons = lawn_data$polygons_average, points = lawn_data$points_average, 'population')
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type average geometry.type
#> 1 Feature     300       Polygon
#> 2 Feature     250       Polygon
#>                                                                                 geometry.coordinates
#> 1 10.66635, 10.66635, 10.76248, 10.76248, 10.66635, 59.89066, 59.93678, 59.93678, 59.89066, 59.89066
#> 2 10.76454, 10.76454, 10.86617, 10.86617, 10.76454, 59.88928, 59.93713, 59.93713, 59.88928, 59.88928
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## distance

Define two points


```r
from <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
   "type": "Point",
   "coordinates": [-75.343, 39.984]
 }
}'
to <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-75.534, 39.123]
  }
}'
```

Calculate distance, default units is kilometers (`km`)


```r
lawn_distance(from, to)
#> [1] 97.15958
```

## random set of points


```r
lawn_random(n = 2)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type geometry.coordinates
#> 1 Feature         Point 156.64582, -14.15674
#> 2 Feature         Point   41.80835, 71.51460
#> 
#> attr(,"class")
#> [1] "featurecollection"
```


```r
lawn_random(n = 5)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type geometry.coordinates
#> 1 Feature         Point -43.33472, -10.69157
#> 2 Feature         Point -33.59234, -19.95378
#> 3 Feature         Point  108.70868, 30.10512
#> 4 Feature         Point  152.61656, 29.28532
#> 5 Feature         Point  -43.01556, 75.53017
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## random features with geojson-random

Points


```r
gr_point(2)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type  geometry.coordinates
#> 1 Feature         Point -147.66037, -82.87004
#> 2 Feature         Point  135.32629, -59.67756
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

Positions


```r
gr_position()
#> [1] -106.24924  -81.34686
```

Polygons


```r
gr_polygon(n = 1, vertices = 5, max_radial_length = 5)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type
#> 1 Feature       Polygon
#>                                                                                                                 geometry.coordinates
#> 1 -74.29221, -74.83090, -75.16191, -76.50330, -75.67180, -74.29221, -62.37067, -66.04085, -68.03920, -70.61932, -66.25079, -62.37067
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## sample from a FeatureCollection


```r
dat <- lawn_data$points_average
lawn_sample(dat, 1)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        300         Point   10.79544, 59.93162
#> 
#> attr(,"class")
#> [1] "featurecollection"
```


```r
lawn_sample(dat, 2)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        200         Point   10.80643, 59.90891
#> 2 Feature        300         Point   10.79544, 59.93162
#> 
#> attr(,"class")
#> [1] "featurecollection"
```


```r
lawn_sample(dat, 3)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        300         Point   10.79544, 59.93162
#> 2 Feature        200         Point   10.72403, 59.92681
#> 3 Feature        100         Point   10.74600, 59.90857
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## extent


```r
lawn_extent(lawn_data$points_average)
#> [1] 10.71579 59.90478 10.80643 59.93162
```

## within


```r
lawn_within(lawn_data$points_within, lawn_data$polygons_within)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type geometry.coordinates
#> 1 Feature         Point   -46.6318, -23.5523
#> 2 Feature         Point     -46.643, -23.557
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## buffer


```r
dat <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
     "type": "Polygon",
     "coordinates": [[
       [-112.072391,46.586591],
       [-112.072391,46.61761],
       [-112.028102,46.61761],
       [-112.028102,46.586591],
       [-112.072391,46.586591]
     ]]
   }
}'
lawn_buffer(dat, 1, "miles")
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type
#> 1 Feature       Polygon
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           geometry.coordinates
#> 1 -112.07239, -112.07522, -112.07793, -112.08044, -112.08263, -112.08443, -112.08577, -112.08660, -112.08687, -112.08687, -112.08660, -112.08577, -112.08443, -112.08263, -112.08044, -112.07793, -112.07522, -112.07239, -112.02810, -112.02528, -112.02256, -112.02006, -112.01786, -112.01606, -112.01472, -112.01390, -112.01362, -112.01362, -112.01390, -112.01472, -112.01606, -112.01786, -112.02006, -112.02256, -112.02528, -112.02810, -112.07239, 46.57211, 46.57239, 46.57321, 46.57455, 46.57635, 46.57854, 46.58105, 46.58377, 46.58659, 46.61761, 46.62044, 46.62315, 46.62566, 46.62785, 46.62965, 46.63099, 46.63181, 46.63209, 46.63209, 46.63181, 46.63099, 46.62965, 46.62785, 46.62566, 46.62315, 46.62044, 46.61761, 46.58659, 46.58377, 46.58105, 46.57854, 46.57635, 46.57455, 46.57321, 46.57239, 46.57211, 46.57211
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

## view

`lawn` includes a tiny helper function for visualizing geojson.


```r
view(lawn_data$points_average)
```

![map1](inst/img/map1.png)

Or during process of manipulating geojson, view at mostly any time.

Here, we sample at random two points from the same dataset just viewed.


```r
lawn_sample(lawn_data$points_average, 2) %>% view()
```

![map1](inst/img/map2.png)

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/lawn/issues).
* License: MIT
* Get citation information for `lawn` in R doing `citation(package = 'lawn')`

[![rofooter](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
