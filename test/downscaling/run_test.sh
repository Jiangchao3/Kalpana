#!/bin/bash
########################################################################################
# This script runs the downscaling test examples detailed at the following website:    #
# https://ccht.ccee.ncsu.edu/downscaling-flooding-inundation-extents-using-kalpana/    #
#                                                                                      #
# Requires: - python3 with matplotlib, shapely, netCDF4, fiona, grass.script modules   #
#           - grass78                                                                  #      
#           - zip/unzip                                                                #
#           - wget                                                                     #
#                                                                                      #
# By William Pringle, Mar 10 2021                                                      #
#    Argonne National Laboratory                                                       # 
########################################################################################
python=python3

# Check for existing data
if [ ! -d "grdn35w077_13" ]; then
   # download the test DEM
   wget "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/ArcGrid/USGS_NED_13_n35w077_ArcGrid.zip" -O temp.zip
   # unzip only the data part 
   unzip temp.zip "grdn35w077_13/*"
   # delete the archive
   rm temp.zip
fi

if [ ! -d "grdn35w078_13" ]; then
   # download the test DEM
   wget "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/ArcGrid/USGS_NED_13_n35w078_ArcGrid.zip" -O temp.zip
   # unzip only the data part 
   unzip Test2.zip "grdn35w078_13/*"
   # delete the archive
   rm temp.zip
fi

#Example 6: Keep original raster resolution and datum using multiple rasters.
$python ./kalpana.py --createlocation yes --raster "./grdn35w077_13/w001001.adf,./grdn35w078_13/w001001.adf" --createmethod existing --vunitconv m2f

#Example 6: Keep original raster resolution and datum using multiple rasters.
#python ./kalpana.py --createlocation yes --raster "./grdn35w077_13/w001001.adf,./grdn35w078_13/w001001.adf" --createmethod existing --vunitconv m2f
