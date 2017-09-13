Welcome to use the 1.0 version of MFmask (Mountainous Fmask)!

It is spectifcally designed for Landsat images acquired from mountainous area based on
the existing Fmask (Version 3.3; http://github.com/prs021/fmask).

It is capable of detecting cloud, cloud shadow, snow for Landsat 4, 5, 7, and 8

If you have any question please do not hesitate
to contact Shi Qiu and Prof. Binbin He at School of Resources and Enviroment,
University of Electronic Science and Technology of China
email: qsly09@hotmail.com

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Inputs:

Each foler only put one image and includes the following fiels.

1. The original Landat TIF images. 

2. Its corresponding Digital Elevation Moedl (DEM) data. 

The DEM data of each scene need to be manually download, mosaicked, reprojected, and
resampled to Landsat's resolution and extent.

The DEM data is suggested to derive from the Advanced Spaceborne Thermal
Emission and Reflection Radiometer (ASTER) DEM Version 2 (http://gdex.cr.usgs.gov/gdex).

3. The slope and aspect data from the DEM are also needed. 

They can be computed by remote sensing software (like ENVI).

The name of the above DEM, slope, and aspect file need to end with '_dem',
'_slope', and  '_aspect', respectively. 
For example, 
xxx_dem,
xxx_slope,
xxx_aspect.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
This function will calculate the mask for each scence automatically

Output is the final mfmask
clear land = 0
clear water = 1
cloud shadow = 2
snow = 3
cloud = 4
outside = 255

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
How to install it?
1. Copy the "MFmask" folder to your local disk
2. Start matlab and addpath for this folder - addpath('local_disk');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
How to use it?

1. Get to the directory where you save the Landsat scene
2. Type in - 'autoMFmask' or 'autoMFmask(cldpix,sdpix,snpix,cldprb) in Matlab command window
'cldpix', 'sdpix', 'snpix' are dilated number of pixels for cloud/shadow/snow with
default values of 
3. 'cldprob' is the cloud probability threshold with default
values of 22.5 for Landsat 4~7 and 50 for Landsat 8 (range from 0~100).
4. You can get clear pixel percent by using 'clr_pct = autoMFmask'.
5. Please run 'autoMFmaskBatch', when many images need be processed.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Requirements:

1. It needs approximately 8G memory to run this algorithm.
2. It takes 1 to 15 miniutes for processing one Landsat image with one CPU.



