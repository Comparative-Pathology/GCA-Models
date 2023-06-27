# EdinGCA_2D_00030

This folder contains the 2D model EdinGCA_3D_00020, version 1.1X.

This is a model of the large and small intestines. The model is derived from the
EMBL-EBI Expression Atlas gut anatomogram available from the
[HCA visualisation portal](https://data.humancellatlas.org/analyze/visualization/anatomogram) .

While the base image is used without any change apart from format conversion,
domains have been defined for the large and small intestines and paths
have been computed through these domains.

The model is comprised of the following files and folders:

* README.md - This file
* EdinGCA_2D_00030_1_1X.json - the database generated model configuration file
  which defines the way the model can be visualised with the GCA model viewer
  along with the collection of data required to visualise it and the position
  of landmarks with respect to the midline paths.
* Images - The anatomogram image.
* Domains - 2D regions of space segmented from the anatomogram model image.
* Paths - Midline paths through the models domains.
* ImageMasks - 2D regions of space segmented from the model image.
* Surfaces - Surfaces generated from the domains of this model.
* SegmentedSurfaces - Segmentations of the main surfaces giving surfaces for
  the regions of the model which are typically defined by bounding
  landmarks or other markers on a midline path.
* SurfaceMaps - Surface specific files with per vertex values representing
  the closest point on the corresponding midline path.
* Software - Software specific to the creation of this model.
* Sections - Section images orthogonal to midline paths and along the paths.
