# MFmask
 The software called MFmask (Matlab package) is used for automated clouds, cloud shadows, and snow masking for Landsat 4-8 images. The MFmask is developed by integrating Digital Elevation Models (DEMs) into the existing Fmask algorithm (Version 3.3; https://github.com/prs021/fmask). It is specifically designed for Landsat images acquired from mountainous area well (thereafter we call this algorithm MFmask, in which the letter “M” refers to mountainous), and also applicative for Landsat images acquired in non-mountainous areas.
 
Available DEMs can be found as follows,
ASTER 30m (1 arc-second) DEM data: http://dx.doi.org/10.5067/aster/astgtm.002.
SRTM 30m (1 arc second) DEM data: https://doi.org/10.5067/measures/srtm/srtmgl1.003.
Note that the corresponding DEM data for each Landsat image needs to bemanually downloaded, mosaicked, projected, and resampled to Landsat's resolution andextent. DEM derivatives (e.g., slope and aspect) are also calculated by using other software, such as ENVI, ERDAS, and ArcMap.

Please contact Shi Qiu (qsly09@hotmail.com) at School of Resources and Environment, University of Electronic Science and Technology of China if you have any questions.
Please cite the following papers:

paper 1: Qiu, S., He, B., Zhu, Z., Liao, Z.,and Quan,X. (2017). Improving Fmask cloud and cloud shadow detection in mountainous area for Landsats 4-8 images, Remote Sensing of Environment, 199, 107-119. doi:10.1016/j.rse.2017.07.002 (paper for MFmask version 1.0.).

paper 2: Zhu, Z., Wang, S., & Woodcock, C. E. (2015). Improvement and expansion of the fmask algorithm: cloud, cloud shadow, and snow detection for landsats 4–7, 8, and sentinel 2 images. Remote Sensing of Environment, 159, 269-277. doi:10.1016/j.rse.2014.12.014 (paper for Fmask version 3.2.).

paper 3: Zhu, Z. and Woodcock, C. E., Zhu, Z., & Woodcock, C. E. (2012). Object-based cloud and cloud shadow detection in landsat imagery. Remote Sensing of Environment, 118(6), 83-94. doi:10.1016/j.rse.2011.10.028 (paper for Fmask version 1.6.).

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
<table border=0 cellpadding=0 cellspacing=0 width=707 class=xl6528235
 style='border-collapse:collapse;table-layout:fixed;width:533pt'>
 <col class=xl6528235 width=13 style='mso-width-source:userset;mso-width-alt:
 465;width:10pt'>
 <col class=xl6528235 width=92 style='mso-width-source:userset;mso-width-alt:
 3211;width:69pt'>
 <col class=xl6528235 width=77 style='mso-width-source:userset;mso-width-alt:
 2699;width:58pt'>
 <col class=xl7028235 width=102 style='mso-width-source:userset;mso-width-alt:
 3560;width:77pt'>
 <col class=xl6828235 width=110 style='mso-width-source:userset;mso-width-alt:
 3840;width:83pt'>
 <col class=xl6828235 width=151 style='mso-width-source:userset;mso-width-alt:
 5282;width:114pt'>
 <col class=xl7328235 width=162 style='mso-width-source:userset;mso-width-alt:
 5655;width:122pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6528235 width=13 style='height:15.0pt;width:10pt'> </td>
  <td class=xl6728235 width=92 style='width:69pt'>Type</td>
  <td class=xl6728235 width=77 style='width:58pt'>Name</td>
  <td class=xl6728235 width=102 style='width:77pt'>Date</td>
  <td class=xl6728235 width=110 style='width:83pt'>Sun Elevation(&deg;)</td>
  <td class=xl6728235 width=151 style='width:114pt'>True Cloud Cover (%)</td>
  <td class=xl6728235 width=162 style='width:122pt'>Elevation Difference (m)</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p227_r98</td>
  <td class=xl6928235>2001/11/3</td>
  <td class=xl7128235>41.19</td>
  <td class=xl7228235>45.10</td>
  <td class=xl7328235>1564</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p228_r94</td>
  <td class=xl6928235>2001/12/12</td>
  <td class=xl7128235>50.72</td>
  <td class=xl7228235>95.92</td>
  <td class=xl7328235>702</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p228_r97</td>
  <td class=xl6928235>2001/11/26</td>
  <td class=xl7128235>46.90</td>
  <td class=xl7228235>67.89</td>
  <td class=xl7328235>630</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p228_r98</td>
  <td class=xl6928235>2001/1/26</td>
  <td class=xl7128235>40.91</td>
  <td class=xl7228235>99.50</td>
  <td class=xl7328235>1553</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p229_r97</td>
  <td class=xl6928235>2001/12/3</td>
  <td class=xl7128235>47.55</td>
  <td class=xl7228235>42.05</td>
  <td class=xl7328235>900</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>austral</td>
  <td class=xl7528235>p230_r92</td>
  <td class=xl7628235>2001/12/26</td>
  <td class=xl7728235>51.62</td>
  <td class=xl7828235>2.32</td>
  <td class=xl7928235>885</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>austral</td>
  <td class=xl7528235>p230_r94</td>
  <td class=xl7628235>2001/12/26</td>
  <td class=xl7728235>49.91</td>
  <td class=xl7828235>12.46</td>
  <td class=xl7928235>1585</td>
 </tr>
 <tr class=xl6528235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p230_r95</td>
  <td class=xl6928235>2001/12/10</td>
  <td class=xl7128235>49.79</td>
  <td class=xl7228235>55.40</td>
  <td class=xl7328235>1830</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p231_r96</td>
  <td class=xl6928235>2001/1/31</td>
  <td class=xl7128235>41.64</td>
  <td class=xl7228235>87.10</td>
  <td class=xl7328235>2799</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p74_r92</td>
  <td class=xl6928235>2001/11/3</td>
  <td class=xl7128235>47.98</td>
  <td class=xl7228235>20.21</td>
  <td class=xl7328235>1066</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p75_r92</td>
  <td class=xl6928235>2001/11/26</td>
  <td class=xl7128235>51.98</td>
  <td class=xl7228235>43.45</td>
  <td class=xl7328235>1583</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>austral</td>
  <td class=xl6628235>p76_r92</td>
  <td class=xl6928235>2001/1/17</td>
  <td class=xl7128235>48.38</td>
  <td class=xl7228235>68.32</td>
  <td class=xl7328235>1460</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>boreal</td>
  <td class=xl6628235>p139_r24</td>
  <td class=xl6928235>2001/8/7</td>
  <td class=xl7128235>51.06</td>
  <td class=xl7228235>7.53</td>
  <td class=xl7328235>1621</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>boreal</td>
  <td class=xl6628235>p143_r21_2</td>
  <td class=xl6928235>2001/5/31</td>
  <td class=xl7128235>53.82</td>
  <td class=xl7228235>45.59</td>
  <td class=xl7328235>625</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>boreal</td>
  <td class=xl7528235>p143_r21_3</td>
  <td class=xl7628235>2001/8/3</td>
  <td class=xl7728235>48.95</td>
  <td class=xl7828235>14.64</td>
  <td class=xl7928235>627</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>boreal</td>
  <td class=xl7528235>p195_r26</td>
  <td class=xl7628235>2001/5/11</td>
  <td class=xl7728235>55.42</td>
  <td class=xl7828235>7.18</td>
  <td class=xl7928235>854</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>boreal</td>
  <td class=xl7528235>p49_r22</td>
  <td class=xl7628235>2001/6/13</td>
  <td class=xl7728235>55.96</td>
  <td class=xl7828235>9.32</td>
  <td class=xl7928235>1009</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>boreal</td>
  <td class=xl6628235>p54_r19</td>
  <td class=xl6928235>2001/6/16</td>
  <td class=xl7128235>52.84</td>
  <td class=xl7228235>60.98</td>
  <td class=xl7328235>1420</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p111_r29</td>
  <td class=xl6928235>2001/4/29</td>
  <td class=xl7128235>55.09</td>
  <td class=xl7228235>62.87</td>
  <td class=xl7328235>977</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p139_r33</td>
  <td class=xl6928235>2001/5/19</td>
  <td class=xl7128235>63.07</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>3204</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p147_r35</td>
  <td class=xl6928235>2001/5/11</td>
  <td class=xl7128235>63.03</td>
  <td class=xl7228235>6.75</td>
  <td class=xl7328235>3678</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p154_r34</td>
  <td class=xl6928235>2001/7/31</td>
  <td class=xl7128235>60.87</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>1968</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p184_r37</td>
  <td class=xl6928235>2001/6/15</td>
  <td class=xl7128235>66.50</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>558</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p186_r32_1</td>
  <td class=xl6928235>2001/2/21</td>
  <td class=xl7128235>33.88</td>
  <td class=xl7228235>33.46</td>
  <td class=xl7328235>1714</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p186_r32_2</td>
  <td class=xl6928235>2001/5/12</td>
  <td class=xl7128235>61.10</td>
  <td class=xl7228235>7.71</td>
  <td class=xl7328235>1703</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p186_r32_4</td>
  <td class=xl6928235>2001/10/3</td>
  <td class=xl7128235>41.91</td>
  <td class=xl7228235>0.49</td>
  <td class=xl7328235>1703</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p196_r35</td>
  <td class=xl6928235>2001/4/16</td>
  <td class=xl7128235>56.59</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>1339</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p33_r37</td>
  <td class=xl6928235>2001/4/26</td>
  <td class=xl7128235>61.07</td>
  <td class=xl7228235>2.95</td>
  <td class=xl7328235>1592</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p36_r37</td>
  <td class=xl6928235>2001/5/1</td>
  <td class=xl7128235>62.29</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>1698</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>mid-latitude_N</td>
  <td class=xl6628235>p46_r32</td>
  <td class=xl6928235>2001/6/8</td>
  <td class=xl7128235>64.33</td>
  <td class=xl7428235>56.84</td>
  <td class=xl7328235>1530</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>mid-latitude_S</td>
  <td class=xl7528235>p171_r82</td>
  <td class=xl7628235>2001/11/11</td>
  <td class=xl7728235>58.60</td>
  <td class=xl7828235>6.76</td>
  <td class=xl7928235>1267</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>mid-latitude_S</td>
  <td class=xl7528235>p71_r87</td>
  <td class=xl7628235>2001/10/29</td>
  <td class=xl7728235>51.87</td>
  <td class=xl7828235>8.14</td>
  <td class=xl7928235>1003</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_S</td>
  <td class=xl6628235>p72_r88</td>
  <td class=xl6928235>2001/1/5</td>
  <td class=xl7128235>53.58</td>
  <td class=xl7228235>14.63</td>
  <td class=xl7328235>1215</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_S</td>
  <td class=xl6628235>p72_r89</td>
  <td class=xl6928235>2001/2/6</td>
  <td class=xl7128235>46.53</td>
  <td class=xl7228235>2.09</td>
  <td class=xl7328235>645</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_S</td>
  <td class=xl6628235>p73_r89</td>
  <td class=xl6928235>2001/12/30</td>
  <td class=xl7128235>53.43</td>
  <td class=xl7228235>1.77</td>
  <td class=xl7328235>1852</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_S</td>
  <td class=xl6628235>p73_r90</td>
  <td class=xl6928235>2001/12/14</td>
  <td class=xl7128235>54.11</td>
  <td class=xl7228235>29.38</td>
  <td class=xl7328235>1424</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>mid-latitude_S</td>
  <td class=xl7528235>p74_r91</td>
  <td class=xl7628235>2001/11/3</td>
  <td class=xl7728235>49.04</td>
  <td class=xl7828235>31.53</td>
  <td class=xl7928235>1705</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_S</td>
  <td class=xl6628235>p89_r82</td>
  <td class=xl6928235>2001/11/12</td>
  <td class=xl7128235>58.80</td>
  <td class=xl7228235>0.99</td>
  <td class=xl7328235>1337</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>mid-latitude_S</td>
  <td class=xl6628235>p92_r86</td>
  <td class=xl6928235>2001/10/16</td>
  <td class=xl7128235>49.22</td>
  <td class=xl7228235>63.17</td>
  <td class=xl7328235>1454</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>polar_north</td>
  <td class=xl6628235>p197_r14</td>
  <td class=xl6928235>2001/6/26</td>
  <td class=xl7128235>47.06</td>
  <td class=xl7228235>18.97</td>
  <td class=xl7328235>1149</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>polar_north</td>
  <td class=xl6628235>p61_r2</td>
  <td class=xl6928235>2000/6/14</td>
  <td class=xl7128235>32.24</td>
  <td class=xl7228235>1.41</td>
  <td class=xl7328235>1700</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_N</td>
  <td class=xl7528235>p118_r40</td>
  <td class=xl7628235>2001/7/3</td>
  <td class=xl7728235>65.82</td>
  <td class=xl7828235>18.11</td>
  <td class=xl7928235>987</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>subtropical_N</td>
  <td class=xl6628235>p131_r46</td>
  <td class=xl6928235>2001/9/16</td>
  <td class=xl7128235>59.49</td>
  <td class=xl7228235>52.04</td>
  <td class=xl7328235>1358</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_N</td>
  <td class=xl6628235>p142_r48</td>
  <td class=xl6928235>2001/4/22</td>
  <td class=xl7128235>63.88</td>
  <td class=xl7228235>0.74</td>
  <td class=xl7328235>1041</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_N</td>
  <td class=xl6628235>p148_r42</td>
  <td class=xl6928235>2001/5/2</td>
  <td class=xl7128235>64.64</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>534</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_N</td>
  <td class=xl7528235>p189_r47</td>
  <td class=xl7628235>2001/8/5</td>
  <td class=xl7728235>62.92</td>
  <td class=xl7828235>12.07</td>
  <td class=xl7928235>1106</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_N</td>
  <td class=xl7528235>p26_r46</td>
  <td class=xl7628235>2001/3/24</td>
  <td class=xl7728235>57.00</td>
  <td class=xl7828235>8.48</td>
  <td class=xl7928235>3200</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_N</td>
  <td class=xl7528235>p31_r43</td>
  <td class=xl7628235>2001/6/15</td>
  <td class=xl7728235>66.29</td>
  <td class=xl7828235>16.93</td>
  <td class=xl7928235>2667</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_N</td>
  <td class=xl7528235>p35_r42</td>
  <td class=xl7628235>2001/8/14</td>
  <td class=xl7728235>62.20</td>
  <td class=xl7828235>3.31</td>
  <td class=xl7928235>858</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_S</td>
  <td class=xl7528235>p1_r75</td>
  <td class=xl7628235>2001/2/5</td>
  <td class=xl7728235>55.37</td>
  <td class=xl7828235>4.24</td>
  <td class=xl7928235>4845</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p1_r76</td>
  <td class=xl6928235>2001/11/20</td>
  <td class=xl7128235>62.13</td>
  <td class=xl7228235>1.41</td>
  <td class=xl7328235>3106</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p113_r75</td>
  <td class=xl6928235>2001/1/5</td>
  <td class=xl7128235>58.62</td>
  <td class=xl7228235>22.07</td>
  <td class=xl7328235>880</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p158_r72_1</td>
  <td class=xl6928235>2001/3/21</td>
  <td class=xl7128235>52.39</td>
  <td class=xl7228235>30.76</td>
  <td class=xl7328235>1259</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'>*</td>
  <td class=xl7528235>subtropical_S</td>
  <td class=xl7528235>p158_r72_2</td>
  <td class=xl7628235>2001/4/22</td>
  <td class=xl7728235>46.98</td>
  <td class=xl7828235>10.48</td>
  <td class=xl7928235>1260</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p158_r72_3</td>
  <td class=xl6928235>2001/9/13</td>
  <td class=xl7128235>52.54</td>
  <td class=xl7228235>55.38</td>
  <td class=xl7328235>1260</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p158_r72_4</td>
  <td class=xl6928235>2001/11/16</td>
  <td class=xl7128235>62.79</td>
  <td class=xl7228235>43.00</td>
  <td class=xl7328235>1260</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p177_r80</td>
  <td class=xl6928235>2001/10/20</td>
  <td class=xl7128235>55.92</td>
  <td class=xl7228235>7.66</td>
  <td class=xl7328235>1000</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p179_r75</td>
  <td class=xl6928235>2001/2/20</td>
  <td class=xl7128235>53.84</td>
  <td class=xl7228235>0.00</td>
  <td class=xl7328235>1430</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p216_r74</td>
  <td class=xl6928235>2001/12/8</td>
  <td class=xl7128235>61.24</td>
  <td class=xl7228235>42.64</td>
  <td class=xl7328235>1471</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p230_r79</td>
  <td class=xl6928235>2001/2/9</td>
  <td class=xl7128235>53.15</td>
  <td class=xl7228235>5.94</td>
  <td class=xl7328235>998</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>subtropical_S</td>
  <td class=xl6628235>p232_r79</td>
  <td class=xl6928235>2001/11/6</td>
  <td class=xl7128235>59.99</td>
  <td class=xl7228235>0.49</td>
  <td class=xl7328235>4934</td>
 </tr>
 <tr class=xl8028235 height=19 style='height:14.5pt'>
  <td height=19 class=xl8028235 style='height:14.5pt'>&nbsp;</td>
  <td class=xl6628235>tropical</td>
  <td class=xl6628235>p11_r55</td>
  <td class=xl6928235>2001/6/3</td>
  <td class=xl7128235>59.05</td>
  <td class=xl7228235>95.63</td>
  <td class=xl7328235>1105</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>tropical</td>
  <td class=xl6628235>p116_r50</td>
  <td class=xl6928235>2001/4/16</td>
  <td class=xl7128235>63.01</td>
  <td class=xl7228235>13.67</td>
  <td class=xl7328235>983</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>tropical</td>
  <td class=xl6628235>p184_r55</td>
  <td class=xl6928235>2001/7/17</td>
  <td class=xl7128235>57.73</td>
  <td class=xl7228235>92.08</td>
  <td class=xl7328235>1117</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>tropical</td>
  <td class=xl6628235>p184_r63</td>
  <td class=xl6928235>2001/12/8</td>
  <td class=xl7128235>56.94</td>
  <td class=xl7228235>89.23</td>
  <td class=xl7328235>607</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>tropical</td>
  <td class=xl6628235>p190_r54</td>
  <td class=xl6928235>2001/9/29</td>
  <td class=xl7128235>61.57</td>
  <td class=xl7228235>34.97</td>
  <td class=xl7328235>527</td>
 </tr>
 <tr height=19 style='height:14.5pt'>
  <td height=19 class=xl6528235 style='height:14.5pt'></td>
  <td class=xl6628235>tropical</td>
  <td class=xl6628235>p4_r70</td>
  <td class=xl6928235>2001/2/26</td>
  <td class=xl7128235>55.53</td>
  <td class=xl7228235>87.75</td>
  <td class=xl7328235>2706</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=151 style='width:114pt'></td>
  <td width=162 style='width:122pt'></td>
 </tr>
 <![endif]>
</table>
