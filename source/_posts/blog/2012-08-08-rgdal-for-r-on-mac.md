---
title:  'rgdal for R on Mac'
categories: blog
layout: post
name: blog
tags:
- R
- GIS
- OS X
---

[rgdal](http://cran.r-project.org/web/packages/rgdal/index.html) provides an interface between R and the [GDAL](http://www.gdal.org/)/[OGR](http://www.gdal.org/ogr/) library, which provides extensive support for a variety of geospatial formats. It is extremely useful for data import and export tasks, particularly because it can read projection information (from .prj files). However, to use rgdal, one must install GDAL and other frameworks on your system first. This is a guide for how to install rgdal on a Mac.

1. Download and install the GDAL, PROJ, and GEOS frameworks: [http://www.kyngchaos.com/software/frameworks](http://www.kyngchaos.com/software/frameworks). The easiest method is just to install all the frameworks using the GDAL 1.9 Complete installer.

2. Verify the directories in which the frameworks were installed. For me, the directories were as follows:
   * /Library/Frameworks/GDAL.framework/
   * /Library/Frameworks/GEOS.framework/
   * /Library/Frameworks/PROJ.framework/

3. Verify that GCC is installed. The easiest way to do so is by opening up Terminal and typing `gcc --version`. If you receive an error, it means that you are either missing GCC or Terminal can't find it. The easiest way to get GCC on a Mac is to install the [Command Line Tools for XCode](http://developer.apple.com/downloads). This is what I did, and for me, when I run the `command gcc --version`, the output is "`i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2336.11.00)`".

4. Download the latest version of rgdal from CRAN: [http://cran.r-project.org/web/packages/rgdal/index.html](http://cran.r-project.org/web/packages/rgdal/index.html).

5. Now, in Terminal, cd to the location of the tarball for rgdal and run the following command: `R CMD INSTALL --configure-args='--with-gdal-config=/Library/Frameworks/GDAL.framework/unix/bin/gdal-config --with-proj-include=/Library/Frameworks/PROJ.framework/unix/include --with-proj-lib=/Library/Frameworks/PROJ.framework/unix/lib' rgdal_0.7-12.tar.gz`

6. If the installation script runs without error in Terminal, you're ready to load the package in R using `library(rgdal)`.

<br/>

*Note:* if upon attempting to load the rgdal library in R using you receive an error of the form "`Error: package ‘rgdal’ is not installed for 'arch=x86_64'`", this means that rgdal was installed for a different architecture of R (32-bit instead of 64-bit in this case). To install rgdal explicitly for the 64-bit architecture, you can modify Step 5 above by adding in the `--arch x86_64` option:

{% highlight bash %}
R --arch x86_64 CMD INSTALL --configure-args='--with-gdal-config=/Library/Frameworks/GDAL.framework/unix/bin/gdal-config --with-proj-include=/Library/Frameworks/PROJ.framework/unix/include --with-proj-lib=/Library/Frameworks/PROJ.framework/unix/lib' rgdal_0.7-12.tar.gz
{% endhighlight %}
