---
title: 'lawn: An R client for the Turf Javascript Library for Geospatial Analysis'
tags:
  - geospatial
  - GeoJSON
  - javascript
authors:
 - name: Scott Chamberlain
   orcid: 0000-0003-1444-9135
   affiliation: 
    - 1
 - name: Jeffrey W. Hollister
   orcid: 0000-0002-9254-9740
   affiliation:
    - 2
affiliations:
 - name: rOpenSci
   index: 1
 - name: US Environmental Protection Agency, Atlantic Ecology Division
   index: 2
date: 16 December 2016
bibliography: paper.bib
---

# Summary

`lawn` is an R package to provide access to the geospatial analysis capabilities in the `Turf` javascript library [@r; @turfjs].  `Turf` expects data in GeoJSON format. Given that many datasets are now available natively in GeoJSON providing an easier method for conducting geospatial analyses on these datasets in R is desired.  Additionally, many existing packages (e.g. `sp` and `rgeos`) do provide similar analysis capabilities; however, they require data be converted to `sp` objects and also have external dependencies (e.g. `gdal` and `geos`) that can be challenging to maintain on some systems [@bivand2013asdar; @rgeos; @gdal; @geos]. To address these challenges and facilitate geospatial analysis of GeoJSON formatted data, we developed the `lawn` package.     

# References