turf
=======



`turf` is an R wrapper for [proj4js](https://github.com/proj4js/proj4js).

## Install


```r
install.packages("devtools")
devtools::install_github("sckott/turf")
```


```r
library("turf")
```

## count

Count number of points within polygons


```r
count(polygons = polygons_count, points = points_count)
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
average(polygons = polygons_average, points = points_average, 'population')
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
#> 1 Feature         Point -76.97620, -53.14368
#> 2 Feature         Point  -24.45760, 36.80671
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
#> 1 Feature         Point -150.72320, -89.43182
#> 2 Feature         Point  -39.34182, -16.50341
#> 3 Feature         Point -179.90565, -86.86754
#> 4 Feature         Point   -46.31246, 40.35835
#> 5 Feature         Point  -45.19218, -63.02495
```

## sample from a FeatureCollection


```r
dat <- points_average
sample(dat, 1)
```

```
#> $type
#> [1] "FeatureCollection"
#> 
#> $features
#>      type population geometry.type geometry.coordinates
#> 1 Feature        200         Point   10.72403, 59.92681
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
#> 1 Feature        100         Point   10.74600, 59.90857
#> 2 Feature        600         Point   10.71579, 59.90478
#> 3 Feature        200         Point   10.72403, 59.92681
```

