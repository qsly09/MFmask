# MFmask
 The software called MFmask is used for automated clouds, cloud shadows, and snow masking for Landsat 4-8 images. The MFmask is developed by integrating Digital Elevation Model (DEM) data into the existing Fmask algorithm (Version 3.3; https://github.com/prs021/fmask). It is specifically designed for Landsat images acquired from mountainous area well (thereafter we call this algorithm MFmask, in which the letter “M” refers to mountainous). 
 
The MFmask can provide cloud and cloud shadow detection at similar (or slightly better) accuracy than Fmask for flat places, and can provide substantial higher accuracy than Fmask for mountainous areas. 
 
Please contact Shi Qiu (qsly09@hotmail.com) at School of Resources and Environment, University of Electronic Science and Technology of China if you have any questions.
Please cite the following papers:

paper 1: Shi Q., Binbin H., Zhe Z., Zhanmang L. and Xingwen Q., Cloud and cloud shadow detection in mountainous area for Landsat 4-8 images, submitted to Remote Sensing of Environment.

paper 2: Zhu, Z. and Woodcock, C. E., Improvement and Expansion of the Fmask Algorithm: Cloud, Cloud Shadow, and Snow Detection for Landsats 4-7, 8, and Sentinel 2 images, Remote Sensing of Environment (2014) doi:10.1016/j.rse.2014.12.014 (paper for Fmask version 3.2.).

paper 3: Zhu, Z. and Woodcock, C. E., Object-based cloud and cloud shadow detection in Landsat imagery, Remote Sensing of Environment (2012), doi:10.1016/j.rse.2011.10.028 (paper for Fmask version 1.6.).


The cloud and cloud shadow manual masks used for validating the Fmask mask are availble at the following link: http://landsat.usgs.gov/ccavds.php

After running MFmask, there will be an image called XXXMFmask that can be opened by ENVI. The image values are presenting the following classes:

0 => clear land pixel

1 => clear water pixel

2 => cloud shadow

3 => snow

4 => cloud

255 => no observation

One sample data can be download from the following link:
https://pan.baidu.com/s/1bYENpk
