Welcome to use the 1.1 beta version of MFmask(Mountainous Fmask)!

It is spectifcally designed for Landsat images acquired from mountainous area based on
the existing Fmask (Version 3.3; http://github.com/prs021/fmask).

It is capable of detecting cloud, cloud shadow, snow for Landsat 4, 5, 7, and 8

If you have any question please do not hesitate
to contact Shi Qiu and Prof. Binbin He at School of Resources and Enviroment,
University of Electronic Science and Technology of China
email: qsly09@hotmail.com

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
If you HAVE Matlab higher than R2014b and workable network, just run the MFmask package at Landsat folder.

If you HAVE NOT Matlab higher than R2014b or workable network, but you still want to use DEMs to enhance the cloud and cloud shadow detection, please manually download, project, and resample to Landsat's resolution and extent, and resaved the DEM data as a TIFF file named with end of '_dem.TIF'.

If you CANNOT automatedly or manually obtain DEMs, MFmask still works well. It will directly come back to the routine of Fmask, but also improve the cloud shadow location prediction with aid of neighboring clouds. That means MFmask will also generate similar cloud masks and better cloud shadow masks without DEMs, compared with original Fmask.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Inputs:
Each foler only put the original Landat TIF images or DEM file named with end of '_dem.TIF'.


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
2. Type in - 'autoMFmask' or 'autoMFmask(cldpix,sdpix,snpix,cldprb, demtype) in Matlab command window
'cldpix', 'sdpix', 'snpix' are dilated number of pixels for cloud/shadow/snow with default values of 3
3. 'cldprob' is the cloud probability threshold with default values of 22.5 for Landsat 4~7 and 50 for Landsat 8 (range from 0~100).
4. 'demtype' is the DEM type with default values of 30m SRTM DEMs, which can be automatedly downloaded when there is no available DEMs at the orginal Landsat folder.
5. You can get clear pixel percent by using 'clr_pct = autoMFmask'.
6. Please run 'autoMFmaskBatch', when many images need be processed.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Requirements:

1. It needs approximately 8G memory to run this algorithm.
2. It takes 1 to 10 miniutes for processing one Landsat image with one CPU.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Version:

Automately download DEM data derived from TOPOTOOLBOX package (Schwanghart, and Scherler,2014) (7/9/2017 Shi Qiu)
MFmask 1.0 pulished.  (7/7/2017 Shi Qiu)


