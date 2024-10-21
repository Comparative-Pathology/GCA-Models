# GCA-Models
This repository contains 1D, 2D and 3D models of the human gut as described
in the paper
[Towards a clinically‐based common coordinate framework for the human gut cell atlas: the gut models](https://doi.org/10.1186/s12911-023-02111-9)

The models are listed below along with a brief description of their
key features. Each model is contained within a folder of
the repository and README files within these folders provide more
information.

Because of file size limits large 3D images are only contained in the
downloadable releases.

## 1D Model

## 2D Models

* EdinGCA_2D_00030 -
2D model of the large and small intestines based on the 
EMBL-EBI Expression Atlas gut 
[anatomogram](https://github.com/ebi-gene-expression-group/anatomogram) .
The base image is used without any change apart
from format conversion.
[Visualisation](https://comparative-pathology.github.io/GCA-Models/GCA-ModelViewer2D.html?config=EdinGCA_2D_00030_1_13.json)


## 3D Models

* EdinGCA_3D_00020 -
3D model of the large intestine and of the ileum of the small
intestine which is derived from a human CT image.
During imaging a contrast agent was used in the large intestine and
the large intestine inflated.
[Visualisation](https://comparative-pathology.github.io/GCA-Models/GCA-ModelViewer3D.html?config=EdinGCA_3D_00020_1_14.json)

* EdinGCA_3D_00060 -
3D model of the large intestine and of the ileum of the small
intestine which is derived from a human CT image.
Neither contrast agent nor inflation was used.
[Visualisation](https://comparative-pathology.github.io/GCA-Models/GCA-ModelViewer3D.html?config=EdinGCA_3D_00060_1_8.json)

* HuBMAPVHF_3D_00080 -
3D model of the large and small intestines
derived from the [HuBMAP](https://hubmapconsortium.org/)
visible human female large and small intestine models.
[Visualisation](https://comparative-pathology.github.io/GCA-Models/GCA-ModelViewer3D.html?config=HuBMAPVHF_3D_00080_1_6.json)

* HuBMAPVHM_3D_00070 -
3D model of the large and small intestines
derived from the [HuBMAP](https://hubmapconsortium.org/)
visible human male large and small intestine models.
[Visualisation](https://comparative-pathology.github.io/GCA-Models/GCA-ModelViewer3D.html?config=HuBMAPVHM_3D_00070_1_5.json)

* HuBMAPVHM_3D_00090 -
3D model of the large intestine, small intestine, stomach and partial oesophagus
derived from a human CT image.
A contrast agent was used in the small intestine.
There is evidence for diverticular disease in the image.
[Visualisation](https://comparative-pathology.github.io/GCA-Models/GCA-ModelViewer3D.html?config=EdinGCA_3D_00090_1_1.json)


## Overview of Files Comprising the 2 and 3D Models
Each model has folders for domains, image masks, images, paths, sections,
surfaces, segmented surfaces and model specific software.
An overview of these folders is given below along with some discussion
of the file formats used.


### Domains
Domains are regions of space in either 2 or 3 dimensions which are encoded
using pixel/voxel encoding. 
Woolz is used to represent domains
because unlike most image formats Woolz is able to efficiently
represent arbitrary spatial regions.

### Image Masks
Image masks are 2D domains, composited with colour and encoded as PNG images.

### Images
The Images folder holds the grey valued images from which the model was
built (when available).

3D images are encoded using NIfTI when they are cuboid and using Woolz when
they are masked. Masked images only store image values within their domain
and so provide a lossless efficient encoding of images that are
restricted to arbitrary regions.

Because these images may be large they will often only have their file names
listed in the Images folder Readme file. In these cases the images will
only be available through Github as binary releases.

### Paths
Central to our 2 and 3D models are mid-line paths which allow
mapping between all 1, 2 and 3D representations of the gut.
These mid-line paths are represented using both JSON and Woolz encodings
with the JSON encoding being derived from the Woolz encoding.
Using Woolz the paths are represented as B-Splines with knots and coefficients
allowing a compact differentiable parametric representation of smooth curves
in multi-dimensional space.
The JSON encoded files simply encode points and tangents along the evaluated
B-Splines.
Because the principle representation of the paths uses B-Splines it is possible
to compute minimal rotation curves frames for orthogonal sections along the
paths.

### Sections
When a model has been created from grey valued images and paths are defined
then it is possible to compute orthogonal section images along the paths.
These section images are simply encoded as JPEG images along the JSON paths.

### Surfaces
Surfaces may be associated with each of the principle gut domains along with
other reference domains such as the human body boundary.
Because it is used by our visualisation software we have used a
[VTK](https://docs.vtk.org/en/latest/design_documents/VTKFileFormats.html)
ASCII legacy surface format.
Typically these surfaces are triangulated, closed and manifold.

### Segmented Surfaces
To represent the various regions of the gut the 3D models have segmented
surfaces with a separate surface for each region.
Typically and where appropriate these segmented surfaces are contiguous.

### Surface Maps
The Edinburgh GCA viewer allows points on a mid-line path to be picked
interactively by selecting a surface vertices. So that the selection is
unambiguous the indices of the closest mid-line points are encoded as an
array corresponding to the vertex indices of the segmented surfaces.
These are simply encoded as an array of integers using JSON.

### Software
Any software unique to a model and used in it's generation is included in the
model's software folder.

## Common Software

Various [Model Scripts](https://github.com/Comparative-Pathology/GCAModelScripts)
were used to construct the models, extract features and produce
inter-model mappings.

Visualisation of these models is done using [GCARenderer](https://github.com/Comparative-Pathology/GCARenderer)
specifically written for rendering 2 and 3D gut models,
which itself is based on
[Fabric.js](https://github.com/fabricjs/fabric.js) and
[MARender](https://github.com/ma-tech/MARender)/[Three.js](https://threejs.org/)
respectively.

[Woolz](https://github.com/ma-tech/Woolz) is a fairly self contained
set of open source software libraries, a Python binding
and a set of command-line programs for
image processing and pattern recognition.
It is particularly efficient at encoding arbitrary spatial regions in 2 and 3
dimensions and has been used extensively in developing the 2 and 3D models.
Building Woolz from source should not present any special problems, but
various 
[releases](https://github.com/ma-tech/Woolz/releases)
of the Woolz software (ready built) are also available.
Using the Woolz command-line program WlzExtFFConvert most Woolz format
files can be converted to a different file format.
Conversion to different file formats may however
incur some loss of information
such as the offsets with respect to a global origin. Simple examples of
format conversion are:
  
  * Viewing usage and supported file formats  
  `WlzExtFFConvert -h`
  * Converting a Woolz format (possibly) masked image to NIfTI format  
  `WlzExtFFConvert -o EdinGCA_3D_00020_masked.nii EdinGCA_3D_00020_masked.wlz`
  * Converting a VTK format surface to an STL format surface  
  `WlzExtFFConvert -o large-intestine.stl large-intestine.vtk`
  * Converting a Woolz domain which has no image values to a NIfTI
    format mask image in which the background has value 0 and the
    foreground value 255
  `WlzGreySetValue -g 255 dom.wlz | WlzExtFFConvert -o msk.nii -f wlz -`

[ITKsnap](http://www.itksnap.org/pmwiki/pmwiki.php)
was frequently used for for simple region growing based segmentation.

A [PyTorch](https://www.pytorch.org) implementation of
[U-Net](https://doi.org/10.1007/978-3-319-24574-4_28) was used for more complex
segmentation tasks such as segmenting non-inflated
large intestines without added contrast media.

Surfaces were simplified and repaired (to give manifold surfaces) using
a combination of [MeshLab](https://www.meshlab.net) and [Blender](https://www.blender.org).

## License
These models are licensed under the
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
