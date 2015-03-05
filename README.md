lawn
=======



[![Build Status](https://api.travis-ci.org/sckott/lawn.png)](https://travis-ci.org/sckott/lawn)
[![Coverage Status](https://coveralls.io/repos/sckott/lawn/badge.svg)](https://coveralls.io/r/sckott/lawn)

`lawn` is an R wrapper for [turf.js](http://turfjs.org/)

## Install


```r
install.packages("devtools")
devtools::install_github("sckott/lawn")
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
#> 1 Feature         Point -173.98268, 78.81371
#> 2 Feature         Point -112.72743, 17.81833
```

```r
random(5)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type geometry.type  geometry.coordinates
#> 1 Feature         Point    26.41179, 37.17540
#> 2 Feature         Point   -31.18082, 53.50672
#> 3 Feature         Point    81.55997, 25.41563
#> 4 Feature         Point -147.59000, -55.09112
#> 5 Feature         Point    10.00120, 19.32502
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
#> 1 Feature        200         Point   10.80643, 59.90891
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
#> 1 Feature        200         Point   10.80643, 59.90891
#> 2 Feature        600         Point   10.71579, 59.90478
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
#> 1 Feature        200         Point   10.80643, 59.90891
#> 2 Feature        600         Point   10.71579, 59.90478
#> 3 Feature        100         Point   10.74600, 59.90857
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

