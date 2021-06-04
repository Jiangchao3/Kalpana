#!/bin/bash
########################################################################################
# This script runs a modification of the downscaling test examples that are            #
# detailed at the following website:                                                   #
# https://ccht.ccee.ncsu.edu/downscaling-flooding-inundation-extents-using-kalpana/    #
#                                                                                      #
# Modifications: Changed to meter output instead of feet. Using Example 3 which uses   #
# the base resolution and projection instead of the specified one which caused         #
# caused problems for me with python3/grass78                                          #
#                                                                                      #
# Requires: - python3 with matplotlib, shapely, netCDF4, fiona, grass.script modules   #
#           - grass78                                                                  #      
#           - zip/unzip                                                                #
#           - wget                                                                     #
#                                                                                      #
# By William Pringle, March 2021                                                       #
#    Argonne National Laboratory                                                       # 
########################################################################################
python=python3
kalpana=../../kalpana.py

# Check for existing data
if [ ! -d "grdn35w077_13" ]; then
   # download the test DEM
   wget "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/ArcGrid/USGS_NED_13_n35w077_ArcGrid.zip" -O temp.zip
   # unzip only the data part 
   unzip temp.zip "grdn35w077_13/*"
   # delete the archive
   rm temp.zip
fi

#Example 3: Native resolution and NAVD EPSG code
echo "Running Example 3 for running the latter examples using r.grow"
$python $kalpana --createlocation yes --raster "./grdn35w077_13/w001001.adf" --resolution align --epsg 4269

#Example 7: Grow using default inputs
echo "Running Example 7"
$python $kalpana --storm florence --filetype maxele.63.nc --contourrange "0 10 0.1" --grow yes --grownoutput WaterLevels_grownDefaults --growmethod without --growradius 30.01 --flooddepth no --grownfiletype ESRI_Shapefile

#Example 10: Visualize grown results as flood depths.
echo "Running Example 10"
$python $kalpana --storm florence --filetype maxele.63.nc --contourrange "0 10 0.1" --grow yes --grownoutput FloodDepth --flooddepth yes
