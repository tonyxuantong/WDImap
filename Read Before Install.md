# WDImap
# Google Map and Chart
# Run the following first
library(devtools)
library(roxygen2)
library(raster)
library(rgdal)
library(WDI)
library(leaflet)
library(ggplot2)
library(googleVis)
library(plyr)
# Then install Through
devtools::install_github("tonyxuantong/WDImap")
# Test using
WDImap::WorldBankData_function()
