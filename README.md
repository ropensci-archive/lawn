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

Define polygons and points


```r
polygons <- '{
  "type": "FeatureCollection",
  "features": [
    {
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
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Polygon",
        "coordinates": [[
          [-112.023983,46.570426],
          [-112.023983,46.615016],
          [-111.966133,46.615016],
          [-111.966133,46.570426],
          [-112.023983,46.570426]
          ]]
      }
    }
    ]
};'
points <- '{
"type": "FeatureCollection",
"features": [
    {
      "type": "Feature",
      "properties": {
        "population": 200
      },
      "geometry": {
        "type": "Point",
        "coordinates": [-112.0372, 46.608058]
      }
    }, {
      "type": "Feature",
      "properties": {
        "population": 600
      },
      "geometry": {
        "type": "Point",
        "coordinates": [-112.045955, 46.596264]
      }
    }
    ]
};'
```

Count points within polygons


```r
count(polygons = polygons, points = points)
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

