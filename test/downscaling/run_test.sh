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

if [ ! -d "grdn35w078_13" ]; then
   # download the test DEM
   wget "https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/ArcGrid/USGS_NED_13_n35w078_ArcGrid.zip" -O temp.zip
   # unzip only the data part 
   unzip temp.zip "grdn35w078_13/*"
   # delete the archive
   rm temp.zip
fi

#Example 1: Specified resolution and EPSG code.
echo "Running Example 1 for running the latter examples using r.grow"
$python $kalpana --createlocation yes --raster "./grdn35w077_13/w001001.adf" --resolution 50 --epsg 2264 --vunitconv m2ft

#Example 7: Keep original raster resolution and datum using multiple rasters.
echo "Running Example 7"
$python $kalpana --storm florence --filetype maxele.63.nc --contourrange "0 21 0.5" --units english --grow yes --grownoutput WaterLevels_grownDefaults --growmethod without --growradius 30.01 --flooddepth no --grownfiletype ESRI_Shapefile

#Example 10: Visualize grown results as flood depths.
echo "Running Example 10"
$python $kalpana --storm florence --filetype maxele.63.nc --contourrange "0 21 0.5" --units english --grow yes --grownoutput FloodDepth --flooddepth yes

#Example 6: Keep original raster resolution and datum using multiple rasters.
#echo "Running Example 6 to test multiple dems"
#$python $kalpana --createlocation yes --raster "./grdn35w077_13/w001001.adf,./grdn35w078_13/w001001.adf" --createmethod existing --vunitconv m2f
