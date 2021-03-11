#!/bin/bash
########################################################################################
# This script downloads the test DEMs associated with the following source:            #
# https://ccht.ccee.ncsu.edu/downscaling-flooding-inundation-extents-using-kalpana/    #
########################################################################################

# download the test DEMs
wget "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/ArcGrid/USGS_NED_13_n35w077_ArcGrid.zip" -O Test1.zip
wget "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/ArcGrid/USGS_NED_13_n35w078_ArcGrid.zip" -O Test2.zip

# unzip only the data part 
unzip Test1.zip "grdn35w077_13/*"
unzip Test2.zip "grdn35w078_13/*"

# delete the archives
rm Test1.zip Test2.zip
