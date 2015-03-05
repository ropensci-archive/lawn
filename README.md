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
#> 1 Feature         Point  118.95746, 71.49877
#> 2 Feature         Point   95.91548, 74.90674
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
#> 1 Feature         Point -154.10313, -64.23609
#> 2 Feature         Point   -40.37785, 57.48090
#> 3 Feature         Point   -90.97275, 54.40162
#> 4 Feature         Point   153.13890, 73.75951
#> 5 Feature         Point  149.91840, -16.28118
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
#> 1 Feature        300         Point   10.79544, 59.93162
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
#> 2 Feature        200         Point   10.80643, 59.90891
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

<!--html_preserve--><div id="htmlwidget-9818" style="width:504px;height:504px;" class="leaflet"></div>
<script type="application/json" data-for="htmlwidget-9818">{ "x": {
 "calls": [
 {
 "method": "tileLayer",
"args": [
 "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
{
 "minZoom":                 0,
"maxZoom":                18,
"maxNativeZoom": null,
"tileSize":               256,
"subdomains": "abc",
"errorTileUrl": "",
"tms": false,
"continuousWorld": false,
"noWrap": false,
"zoomOffset":                 0,
"zoomReverse": false,
"opacity":                 1,
"zIndex": null,
"unloadInvisibleTiles": null,
"updateWhenIdle": null,
"detectRetina": false,
"reuseTiles": false,
"attribution": "&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>" 
} 
] 
},
{
 "method": "geoJSON",
"args": [
 {
 "type": "FeatureCollection",
"features": [
 {
 "type": "Feature",
"properties": {
 "population": 200 
},
"geometry": {
 "type": "Point",
"coordinates": [
           10.8064,
          59.9089 
] 
} 
},
{
 "type": "Feature",
"properties": {
 "population": 300 
},
"geometry": {
 "type": "Point",
"coordinates": [
           10.7954,
          59.9316 
] 
} 
} 
] 
},
null 
] 
} 
],
"fitBounds": [
           59.9089,
          10.7954,
          59.9316,
          10.8064 
] 
},"evals": [  ] }</script><!--/html_preserve-->

![map1](inst/img/map2.png)
