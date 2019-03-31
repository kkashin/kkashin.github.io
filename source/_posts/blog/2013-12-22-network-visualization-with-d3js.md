---
title:  'Network Visualization with D3.js'
categories: blog
layout: post
name: blog
tags:
- data visualization
- D3.js
---

Here is a visualization I constructed using D3.js based on a visualization for Harvard's Stat 221 class of a network of individuals for whom HIV status is known (original visualization [here](http://theory.info/harvardstat221#?v=network-of-individuals-at-risk-of-hiv)). I wanted the visualization to maximally exploit the information available in the data, such as for example whether friendships are mostly seroconcordant (with individuals of the same HIV status) or serodiscordant. I also wanted to see if most friendships were of the same gender or not. Hence, I adapted the [hive plot template](http://bost.ocks.org/mike/hive/) for this network data. Here is a static picture of the resultant network:   

<div class="post-image">
<a href="/data/hiveplot.html"><img alt="d3 hive plot network" src="/assets/images/blog/hive-plot.png" height="513" width="812"/></a>
</div>

<br/>
Note that the two axes of the hive plot connote the HIV status of the individuals. The nodes are colored and ordered first by gender and then within each gender are subsequently ordered by the number of links, where the nodes closer to the origin of the axis are more well-connected. The links are also color-coded by whether they are friendships between the same gender or opposite genders. Whether a link is serodiscordant or seroconconcordant is evident from its placement relative to the axes.   

<br/>
The full, interactive visualization is available [here](/assets/data/hiveplot.html) and the code is available on [Github](https://github.com/kkashin/dataviz).

<br/>
For those new to D3.js, here are some great resources for getting started:

* [D3 homepage](http://d3js.org/)
* [Mike Bostock's page](http://bost.ocks.org/mike/)
* [D3 Tutorials Wiki](https://github.com/mbostock/d3/wiki/Tutorials)
* [D3 for Mere Mortals](http://www.mentormob.com/learn/i/begin-with-d3js/d3js-principles-for-mere-mortals)
* [Scott Murray's D3 Tutorials](http://alignedleft.com/tutorials/d3/)
* [Christophe Viau's Tutorial](http://christopheviau.com/d3_tutorial/)
