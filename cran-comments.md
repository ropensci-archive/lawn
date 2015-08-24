R CMD CHECK passed on my local OS X install with R 3.2.2 and
R development version, Ubuntu running on Travis-CI, and Win-Builder.

This submission fixes a test not passing on CRAN, now imports all
non-base R functions (i.e., from methods, stats, and utils), and a 
few other changes.

Thanks! Scott Chamberlain
