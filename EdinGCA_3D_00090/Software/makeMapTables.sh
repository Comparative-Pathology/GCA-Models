#!/bin/bash
# Simple shell script to compute mearest midline points for all vertices
# in segmented surfaces.
# This script assume that the Woolz executables and python binding have been built,
# installed and are in the python/executable search paths,
# see https://github.com/ma-tech/Woolz
#
# Bill Hill
# 2024-10-07

BASE_DIR='.'
LI_SPLINE="$BASE_DIR"'/Paths/large_intestine_path.jsn'
SI_SPLINE="$BASE_DIR"'/Paths/small_intestine_path.jsn'
LI_MIDLINE="$BASE_DIR"'/Paths/large_intestine_path-domain.wlz'
SI_MIDLINE="$BASE_DIR"'/Paths/small_intestine_path-domain.wlz'
LI="$BASE_DIR"'/Wlz/large_intestine_domain.wlz'
SI="$BASE_DIR"'/Wlz/small_intestine_domain.wlz'
LI_ANAT=('AO-AT' 'ICVc-AO' 'CCJ-ICVc' \
         'HF+-CCJ' 'HF-HF+' 'HF--HF' \
         'SF+-HF-' 'SF-SF+' 'SF--SF' \
         'DSJ-SF-' 'RSJ-DSJ' 'A-RSJ')
SI_ANAT=('OGL-POL' 'GDJ-OGL' 'DJJ-GDJ' 'JIJ-DJJ' 'ITIJ-JIJ' 'ICVi-ITIJ')
MAKEMAPTABLE="$HOME"'/Projects/GutCellAtlas/src/GCAModelScripts/GCAMakeMapTable.py'

# The (large)|(small)_intestine_path-domain.wlz files are voxel representations
# of the B-spline paths ((large)|(small)_intestine_path.wlz) and can be created
# using
#
# WlzBSplineToDomain -o large_intestine_path-domain.wlz large_intestine_path.wlz
#

if true
then
  # Loop through all large intestine anatomy surfaces
  for A in "${LI_ANAT[@]}"
  do
     # Create domain covering the anatomy surface segment
     echo "$A"
     WlzExtFFConvert -o - -F wlz large_intestine_"$A".vtk | \
     WlzRasterObj | \
     WlzDilation -c26 -r3 | \
     WlzDomainFill | \
     WlzErosion -c26 -r 2 | \
     cat - "$LI" | \
     WlzIntersect  >j1.wlz
     # Set coordinates of nearest midline spline location throughout the domain
     WlzDistanceAllNearest -f j1.wlz "$LI_MIDLINE" >j2.wlz
     # For each vertex in the anatomy surface find the index of the nearest
     # midline spline location
     $MAKEMAPTABLE -v -o 'large_intestine_'"$A"'-map.jsn' -b $LI_SPLINE \
	 -s 'large_intestine_'"$A"'.vtk' j2.wlz
  done
fi

if true
then
  # Loop through all small intestine anatomy surfaces
  for A in "${SI_ANAT[@]}"
  do
     # Create domain covering the anatomy surface segment
     echo "$A"
     WlzExtFFConvert -o - -F wlz small_intestine_"$A".vtk | \
     WlzRasterObj | \
     WlzDilation -c26 -r3 | \
     WlzDomainFill | \
     WlzErosion -c26 -r 2 | \
     cat - "$SI" | \
     WlzIntersect  >j1.wlz
     # Set coordinates of nearest midline spline location throughout the domain
     WlzDistanceAllNearest -f j1.wlz "$SI_MIDLINE" >j2.wlz
     # For each vertex in the anatomy surface find the index of the nearest
     # midline spline location
     $MAKEMAPTABLE -v -o 'small_intestine_'"$A"'-map.jsn' -b $SI_SPLINE \
	 -s 'small_intestine_'"$A"'.vtk' j2.wlz
  done
fi
