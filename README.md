lawn
=======



[![Build Status](https://travis-ci.org/ropensci/lawn.svg?branch=master)](https://travis-ci.org/ropensci/lawn)
[![Build status](https://ci.appveyor.com/api/projects/status/v7d3p3q9j97h0ttw?svg=true)](https://ci.appveyor.com/project/sckott/lawn)
[![Coverage Status](https://coveralls.io/repos/ropensci/lawn/badge.svg)](https://coveralls.io/r/ropensci/lawn)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/lawn?color=2ECC71)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/lawn)](http://cran.rstudio.com/web/packages/lawn)

`lawn` is an R wrapper for the Javascript library [turf.js](http://turfjs.org/). In addition, we have a few functions to interface with the [geojson-random](https://github.com/mapbox/geojson-random) Javascript library. 

## Install


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
#> 1 Feature         Point  167.30619, 25.17848
#> 2 Feature         Point  -32.10306, 53.43144
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
#>      type geometry.type   geometry.coordinates
#> 1 Feature         Point    -58.67052, 28.36528
#> 2 Feature         Point    86.82092, -86.67376
#> 3 Feature         Point -170.679818, -5.010867
#> 4 Feature         Point    15.52654, -19.65143
#> 5 Feature         Point   104.18723, -71.66213
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
#> 1 Feature         Point -172.45147, -68.39409
#> 2 Feature         Point  -11.68456, -57.68366
#> 
#> attr(,"class")
#> [1] "featurecollection"
```

Positions


```r
gr_position()
#> [1]  22.57551 -32.57410
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
#>                                                                                                                       geometry.coordinates
#> 1 -116.51079, -115.41952, -115.09452, -118.31157, -116.71443, -116.51079, -44.39019, -43.85438, -46.92479, -47.53488, -41.12107, -44.39019
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
#> 1 Feature        600         Point   10.71579, 59.90478
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
#> 1 Feature        300         Point   10.79544, 59.93162
#> 2 Feature        200         Point   10.72403, 59.92681
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
#> 2 Feature        200         Point   10.80643, 59.90891
#> 3 Feature        600         Point   10.71579, 59.90478
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
