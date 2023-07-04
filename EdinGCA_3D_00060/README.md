# EdinGCA_3D_00060

This folder contains the 3D model EdinGCA_3D_00060, version 1.7.

This is a model of the large intestine and the ileum of the small intestine.
The model is derived from a patient CT image in which neither
contrast agent or inflation was used.

The model is comprised of the following files and folders:

* README.md - This file
* EdinGCA_3D_00060_1_7.json - the database generated model configuration file
  which defines the way the model can be visualised with the GCA model viewer
  along with the collection of data required to visualise it and the position
  of landmarks with respect to the midline paths.
* Images - Voxel data for the model.
* Domains - 3D regions of space segmented from the model image.
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
