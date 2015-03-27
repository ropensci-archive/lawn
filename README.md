lawn
=======



[![Build Status](https://travis-ci.org/ropensci/lawn.svg?branch=master)](https://travis-ci.org/ropensci/lawn)
[![Build status](https://ci.appveyor.com/api/projects/status/v7d3p3q9j97h0ttw?svg=true)](https://ci.appveyor.com/project/sckott/lawn)
[![Coverage Status](https://coveralls.io/repos/ropensci/lawn/badge.svg)](https://coveralls.io/r/ropensci/lawn)

`lawn` is an R wrapper for the Javascript library [turf.js](http://turfjs.org/). In addition, we have a few functions to interface with the [geojson-random](https://github.com/mapbox/geojson-random) Javascript library. 

## Install


```r
install.packages("devtools")
devtools::install_github("ropensci/lawn")
```


```r
library("lawn")
```

## count

Count number of points within polygons


```r
count(polygons = lawn_data$polygons_count, points = lawn_data$points_count)
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
```


## average

Average value of a field for a set of points within a set of polygons


```r
average(polygons = lawn_data$polygons_average, points = lawn_data$points_average, 'population')
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
distance(from, to)
#> [1] 97.15958
```

## random set of points


```r
random(2)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type geometry.coordinates
#> 1 Feature         Point  22.29056, -84.03604
#> 2 Feature         Point -22.41968, -55.05934
```

```r
random(5)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type   geometry.coordinates
#> 1 Feature         Point    -31.33347, 49.97117
#> 2 Feature         Point     61.57815, 51.58939
#> 3 Feature         Point    110.42348, 73.89989
#> 4 Feature         Point -92.6017604, 0.8860521
#> 5 Feature         Point  0.1769651, 68.0722766
```

## random features with geojson-random

Points


```r
gr_point(2)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type geometry.coordinates
#> 1 Feature         Point -81.37980, -76.11838
#> 2 Feature         Point -80.551962, 5.194171
```

Positions


```r
gr_position()
#> [1] -26.35267  47.55159
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
#>                                                                                                           geometry.coordinates
#> 1 -93.58169, -94.17353, -94.97594, -96.41842, -97.84882, -93.58169, 34.84241, 32.90783, 34.15654, 35.41595, 36.75437, 34.84241
```

## sample from a FeatureCollection


```r
dat <- lawn_data$points_average
sample(dat, 1)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        100         Point   10.74600, 59.90857
```

```r
sample(dat, 2)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        600         Point   10.71579, 59.90478
#> 2 Feature        200         Point   10.80643, 59.90891
```

```r
sample(dat, 3)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        200         Point   10.72403, 59.92681
#> 2 Feature        100         Point   10.74600, 59.90857
#> 3 Feature        600         Point   10.71579, 59.90478
```

## extent


```r
extent(lawn_data$points_average)
#> [1] 10.71579 59.90478 10.80643 59.93162
```

## within


```r
within(lawn_data$points_within, lawn_data$polygons_within)
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type geometry.coordinates
#> 1 Feature         Point   -46.6318, -23.5523
#> 2 Feature         Point     -46.643, -23.557
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
buffer(dat, 1, "miles")
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type
#> 1 Feature       Polygon
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           geometry.coordinates
#> 1 -112.07239, -112.07522, -112.07793, -112.08044, -112.08263, -112.08443, -112.08577, -112.08660, -112.08687, -112.08687, -112.08660, -112.08577, -112.08443, -112.08263, -112.08044, -112.07793, -112.07522, -112.07239, -112.02810, -112.02528, -112.02256, -112.02006, -112.01786, -112.01606, -112.01472, -112.01390, -112.01362, -112.01362, -112.01390, -112.01472, -112.01606, -112.01786, -112.02006, -112.02256, -112.02528, -112.02810, -112.07239, 46.57211, 46.57239, 46.57321, 46.57455, 46.57635, 46.57854, 46.58105, 46.58377, 46.58659, 46.61761, 46.62044, 46.62315, 46.62566, 46.62785, 46.62965, 46.63099, 46.63181, 46.63209, 46.63209, 46.63181, 46.63099, 46.62965, 46.62785, 46.62566, 46.62315, 46.62044, 46.61761, 46.58659, 46.58377, 46.58105, 46.57854, 46.57635, 46.57455, 46.57321, 46.57239, 46.57211, 46.57211
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
view(jsonlite::toJSON(sample(lawn_data$points_average, 2), auto_unbox=TRUE))
```

![map1](inst/img/map2.png)

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/lawn/issues).
* License: MIT
* Get citation information for `lawn` in R doing `citation(package = 'lawn')`

[![rofooter](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
