# MFmask
 The software called MFmask is used for automated clouds, cloud shadows, and snow masking for Landsat 4-8 images. The MFmask is developed by integrating Digital Elevation Models (DEMs) into the existing Fmask algorithm (Version 3.3; https://github.com/prs021/fmask). It is specifically designed for Landsat images acquired from mountainous area well (thereafter we call this algorithm MFmask, in which the letter “M” refers to mountainous), and also applicative for Landsat images acquired in non-mountainous areas.
 
Please contact Shi Qiu (qsly09@hotmail.com) at School of Resources and Environment, University of Electronic Science and Technology of China if you have any questions.
Please cite the following papers:

paper 1: Qiu, S., He, B., Zhu, Z., Liao, Z.,and Quan,X., Improving Fmask cloud and cloud shadow detection in mountainous area for Landsats 4-8 images, Remote Sensing of Environment, Revised.

paper 2: Zhu, Z. and Woodcock, C. E., Improvement and Expansion of the Fmask Algorithm: Cloud, Cloud Shadow, and Snow Detection for Landsats 4-7, 8, and Sentinel 2 images, Remote Sensing of Environment (2014) doi:10.1016/j.rse.2014.12.014 (paper for Fmask version 3.2.).

paper 3: Zhu, Z. and Woodcock, C. E., Object-based cloud and cloud shadow detection in Landsat imagery, Remote Sensing of Environment (2012), doi:10.1016/j.rse.2011.10.028 (paper for Fmask version 1.6.).

After running MFmask, there will be an image called XXXMFmask that can be opened by ENVI. The image values are presenting the following classes:

0 => clear land pixel

1 => clear water pixel

2 => cloud shadow

3 => snow

4 => cloud

255 => no observation

One sample data can be download from the following links:

Google drive: https://drive.google.com/drive/folders/0B1UcOl384wK-S1hNU0g3UlpGQ2s

or

Baidu drive:https://pan.baidu.com/s/1bYENpk


Table 1. Validation data for MFmask. Note that * indicates the reference image with both manual cloud and cloud shadow mask. All of them are availble at the following link: http://landsat.usgs.gov/ccavds.php.
------------------------------------------------------------------------------------------------------------
    Type         Name(Path_Row)    Date    Sun Elevation(°)  True Cloud Cover (%)   Elevation Difference (m)
------------------------------------------------------------------------------------------------------------
   austral         p227_r98      2001/11/3      41.19             0.4510                     1564
   austral         p228_r94      2001/12/12     50.72             0.9592                     702
   austral         p228_r97      2001/11/26     46.90             0.6789                     630
   austral         p228_r98      2001/1/26      40.91             0.9950                     1553
   austral         p229_r97      2001/12/3      47.55             0.4205                     900
*  austral         p230_r92      2001/12/26     51.62             0.0232                     885
*  austral         p230_r94      2001/12/26     49.91             0.1246                     1585
   austral         p230_r95      2001/12/10     49.79             0.5540                     1830
   austral         p231_r96      2001/1/31      41.64             0.8710                     2799
   austral         p74_r92       2001/11/3      47.98             0.2021                     1066
   austral         p75_r92       2001/11/26     51.98             0.4345                     1583
   austral         p76_r92       2001/1/17      48.38             0.6832                     1460
   boreal          p139_r24      2001/8/7       51.06             0.0753                     1621
   boreal          p143_r21_2    2001/5/31      53.82             0.4559                     625
*  boreal          p143_r21_3    2001/8/3       48.95             0.1464                     627
*  boreal          p195_r26      2001/5/11      55.42             0.0718                     854
*  boreal          p49_r22       2001/6/13      55.96             0.0932                     1009
   boreal          p54_r19       2001/6/16      52.84             0.6098                     1420
   mid-latitude_N  p111_r29      2001/4/29      55.09             0.6287                     977
   mid-latitude_N  p139_r33      2001/5/19      63.07             0.0000                     3204
   mid-latitude_N  p147_r35      2001/5/11      63.03             0.0675                     3678
   mid-latitude_N  p154_r34      2001/7/31      60.87             0.0000                     1968
   mid-latitude_N  p184_r37      2001/6/15      66.50             0.0000                     558
   mid-latitude_N  p186_r32_1    2001/2/21      33.88             0.3346                     1714
   mid-latitude_N  p186_r32_2    2001/5/12      61.10             0.0771                     1703
   mid-latitude_N  p186_r32_4    2001/10/3      41.91             0.0049                     1703
   mid-latitude_N  p196_r35      2001/4/16      56.59             0.0000                     1339
   mid-latitude_N  p33_r37       2001/4/26      61.07             0.0295                     1592
   mid-latitude_N  p36_r37       2001/5/1       62.29             0.0000                     1698
   mid-latitude_N  p46_r32       2001/6/8       64.33             0.5684                     1530
*  mid-latitude_S  p171_r82      2001/11/11     58.60             0.0676                     1267
*  mid-latitude_S  p71_r87       2001/10/29     51.87             0.0814                     1003
   mid-latitude_S  p72_r88       2001/1/5       53.58             0.1463                     1215
   mid-latitude_S  p72_r89       2001/2/6       46.53             0.0209                     645
   mid-latitude_S  p73_r89       2001/12/30     53.43             0.0177                     1852
   mid-latitude_S  p73_r90       2001/12/14     54.11             0.2938                     1424
*  mid-latitude_S  p74_r91       2001/11/3      49.04             0.3153                     1705
   mid-latitude_S  p89_r82       2001/11/12     58.80             0.0099                     1337
   mid-latitude_S  p92_r86       2001/10/16     49.22             0.6317                     1454
   polar_north     p197_r14      2001/6/26      47.06             0.1897                     1149
   polar_north     p61_r2        2000/6/14      32.24             0.0141                     1700
*  subtropical_N   p118_r40      2001/7/3       65.82             0.1811                     987
   subtropical_N   p131_r46      2001/9/16      59.49             0.5204                     1358
   subtropical_N   p142_r48      2001/4/22      63.88             0.0074                     1041
   subtropical_N   p148_r42      2001/5/2       64.64             0.0000                     534
*  subtropical_N   p189_r47      2001/8/5       62.92             0.1207                     1106
*  subtropical_N   p26_r46       2001/3/24      57.00             0.0848                     3200
*  subtropical_N   p31_r43       2001/6/15      66.29             0.1693                     2667
*  subtropical_N   p35_r42       2001/8/14      62.20             0.0331                     858
*  subtropical_S   p1_r75        2001/2/5       55.37             0.0424                     4845
   subtropical_S   p1_r76        2001/11/20     62.13             0.0141                     3106
   subtropical_S   p113_r75      2001/1/5       58.62             0.2207                     880
   subtropical_S   p158_r72_1    2001/3/21      52.39             0.3076                     1259
*  subtropical_S   p158_r72_2    2001/4/22      46.98             0.1048                     1260
   subtropical_S   p158_r72_3    2001/9/13      52.54             0.5538                     1260
   subtropical_S   p158_r72_4    2001/11/16     62.79             0.4300                     1260
   subtropical_S   p177_r80      2001/10/20     55.92             0.0766                     1000
   subtropical_S   p179_r75      2001/2/20      53.84             0.0000                     1430
   subtropical_S   p216_r74      2001/12/8      61.24             0.4264                     1471
   subtropical_S   p230_r79      2001/2/9       53.15             0.0594                     998
   subtropical_S   p232_r79      2001/11/6      59.99             0.0049                     4934
   tropical        p11_r55       2001/6/3       59.05             0.9563                     1105
   tropical        p116_r50      2001/4/16      63.01             0.1367                     983
   tropical        p184_r55      2001/7/17      57.73             0.9208                     1117
   tropical        p184_r63      2001/12/8      56.94             0.8923                     607
   tropical        p190_r54      2001/9/29      61.57             0.3497                     527
   tropical        p4_r70        2001/2/26      55.53             0.8775                     2706
------------------------------------------------------------------------------------------------------------
