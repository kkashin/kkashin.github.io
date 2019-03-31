---
title:  'MinionPro for LaTeX on Mac OS X'
categories: blog
layout: post
name: blog
tags:
- LaTeX
- OS X
---

This tutorial shows how to install the MinionPro font for LaTeX. Following these instructions should insure that you can compile LaTeX documents with the \usepackage{MinionPro} command (instead of using XeTeX). Throughout this explanation, the TeX tree that I refer to is located at: /Library/TeX/Root/texmf/. Note that this is equivalent to /usr/local/texlive/2012/texmf/ for my 2012 TeX distribution.

<br/>

In Terminal, I created a variable for the TeX tree directory:

{% highlight bash %}
texmf_folder=/Library/TeX/Root/texmf/
{% endhighlight %}

### Part 1: Install MnSymbol

  1\. Download [MnSymbol package](http://mirror.ctan.org/fonts/mnsymbol.zip), which provides mathematical symbol font for Adobe MinionPro, from CRAN in the form of a zip file. Unzip the file to form a temporary directory (I just created a mnsymbol directory in ~/Downloads temporarily).

  2\. Using Terminal: `cd ~/Downloads/mnsymbol/tex & latex MnSymbol.ins`

  3\. Move contents from MnSymbol directory to appropriate locations of TeX tree:

First create the new directories in TeX tree:

{% highlight bash %}
sudo mkdir -p $texmf_folder/tex/latex/MnSymbol/
sudo mkdir -p $texmf_folder/fonts/source/public/MnSymbol/
sudo mkdir -p $texmf_folder/doc/latex/MnSymbol
{% endhighlight %}

Move MnSymbol.sty to /usr/local/texlive/2012/texmf/tex/latex/MnSymbol.sty:

{% highlight bash %}
sudo cp MnSymbol.sty $texmf_folder/tex/latex/MnSymbol/MnSymbol.sty
{% endhighlight %}

Move all contents of directory source to /texmf/fonts/source/public/MnSymbol/:

{% highlight bash %}
cd ..
sudo cp source/* $texmf_folder/fonts/source/public/MnSymbol/
{% endhighlight %}

Move documentation:

{% highlight bash %}
sudo cp MnSymbol.pdf README $texmf_folder/doc/latex/MnSymbol/
{% endhighlight %}


  4\. To install the PostScript fonts into TeX tree:

{% highlight bash %}
sudo mkdir -p $texmf_folder/fonts/map/dvips/MnSymbol
sudo mkdir -p $texmf_folder/fonts/enc/dvips/MnSymbol
sudo mkdir -p $texmf_folder/fonts/type1/public/MnSymbol
sudo mkdir -p $texmf_folder/fonts/tfm/public/MnSymbol

sudo cp enc/MnSymbol.map $texmf_folder/fonts/map/dvips/MnSymbol/
sudo cp enc/*.enc $texmf_folder/fonts/enc/dvips/MnSymbol/
sudo cp pfb/*.pfb $texmf_folder/fonts/type1/public/MnSymbol/
sudo cp tfm/* $texmf_folder/fonts/tfm/public/MnSymbol/
{% endhighlight %}


  5\. Regenerate TeX tree file database:

{% highlight bash %}
sudo mktexlsr
sudo updmap-sys --enable MixedMap MnSymbol.map
{% endhighlight %}

The following file should now compile: [mnsymbol-test.tex](/assets/latex/mnsymbol-test.tex)

<br/>
<br/>

### Part 2: Install MinionPro

  1\. Locate MinionPro OpenType font files. On Mac OS X, fonts are generally located under /Library/Fonts/. However, on my computer the Adobe fonts are under /Applications/Adobe Reader.app/Contents/Resources/Resource/Font/ (alternatively sometimes /Library/Application Support/Adobe/Fonts).

Note that before proceeding, double-check that you have a working installation of [lcdf-typetools](http://www.lcdf.org/type/), needed to convert the OpenType fonts. On my system, LCDF Typetools were already installed (can check in Terminal if `otfinfo --help` command works).

Figure out version of fonts using following command in Terminal:

{% highlight bash %}
otfinfo -v MinionPro-Regular.otf
{% endhighlight %}

Output for my fonts:

{% highlight bash %}
Version 2.015;PS 002.000;Core 1.0.38;makeotf.lib1.7.9032
{% endhighlight %}

  2\. Go to [CTAN directory for MinionPro](http://www.ctan.org/tex-archive/fonts/minionpro/).


   - Download [scripts.zip](http://mirrors.ctan.org/fonts/minionpro/scripts.zip). This will contains convert.sh, a Unix script. Unzip as a temporary directory wherever you want (I placed in ~/Downloads).
   <br/>
   - Download the appropriate encoding file, corresponding to the version of the MinionPro font you are using. My MinionPro font is of version 2.000, so I downloaded [enc-v2.000.zip](http://mirrors.ctan.org/fonts/minionpro/enc-2.000.zip). I left the zipfile in ~/Downloads.
   <br/>
   - Download [metrics-base.zip](http://mirrors.ctan.org/fonts/minionpro/metrics-base.zip) (contains metrics for Regular, It, Bold, and BoldIt fonts) and, optionally, [metrics-full.zip](http://mirrors.ctan.org/fonts/minionpro/metrics-full.zip) (contains additional metrics for Medium, Medium Italic, Semibold, and SemiboldItalic fonts). I left the zipfiles in ~/Downloads.

  3\. We need to convert the OpenType font files (.otf) to PostScript files (.pfb). In order to do this, copy the MinionPro OpenType files (MinionPro-Regular.otf, MinionPro-Bold.otf, MinionPro-It.otf, and MinionPro-BoldIt.otf) from pre-identified directory to ~Downloads/scripts/otf.

Then in Terminal:

{% highlight bash %}
cd ~/Downloads/scripts
./convert.sh
{% endhighlight %}

  4\. Copy PostScript fonts to TeX tree:

{% highlight bash %}
sudo mkdir -p $texmf_folder/fonts/type1/adobe/MinionPro/
sudo cp pfb/*.pfb $texmf_folder/fonts/type1/adobe/MinionPro/
{% endhighlight %}

  5\. Unzip enc-2.000.zip, metrics-base.zip, and metrics-full.zip files into the TeX directory:

{% highlight bash %}
cd $texmf_folder
sudo unzip ~/Downloads/enc-2.000.zip
sudo unzip ~/Downloads/metrics-base.zip
sudo unzip ~/Downloads/metrics-full.zip
{% endhighlight %}

  6\.  Regenerate TeX tree file database:

{% highlight bash %}
sudo mktexlsr
sudo updmap-sys --enable MixedMap MinionPro.map
{% endhighlight %}

The following file should now compile: [minionpro-test.tex](/assets/latex/minionpro-test.tex).

I would like to thank the following tutorials for help in figuring this out:

* http://carlo-hamalainen.net/blog/2007/12/11/installing-minion-pro-fonts/
* http://jklukas.blogspot.com/2010/02/installing-minionpro-tex-package.html
