---
title:  'ggplot2: Density Plots and Histograms'
categories: blog
layout: post
name: blog
tags:
- R
- ggplot2
- causal inference
---

In this post, I'm going to go through how to make plots of distributions (either density plots or histograms) in ggplot2. I'm going to draw upon examples of Fisherian testing in the context of causal inference, but the examples should be completely understandable without knowledge of Fisher's approach to inference.

For example, suppose that we want to plot the randomization distribution of a test statistic (difference in means in this case) under the sharp null of zero treatment effect across all units. The possible values of the test statistic across 1000 randomly sampled randomizations are in the vector `test.stat`. Moreover, the actually observed test statistic is `tau.hat`. Not only do we want to plot the density, but we want to shade in the area under the density that corresponds to the one-sided p-value of this test statistic.

We can first turn the vector into a data frame that contains the values as x and the corresponding density as y:

{% highlight r %}
dd <- with(density(test.stat),data.frame(x,y))
{% endhighlight %}

Then in `ggplot`:

{% highlight r %}
ggplot(data = dd, mapping = aes(x = x, y = y)) +
geom_line(color="black") + layer(data = dd, mapping = aes(x=ifelse(x < tau.hat,x,tau.hat), y=y), geom = "area", geom_params=list(fill="red",alpha=.3)) +
scale_y_continuous(limits = c(0,max(dd$y)), name="Density") +
scale_x_continuous(name="Difference in Means") +
geom_vline(aes(xintercept=tau.hat.1a), color="red", linetype="dashed") +
geom_text(mapping=aes(x2,y2,label = text2), data=data.frame(x2=-42, y2=0.015, text2="T[obs]"), color=I("red"), parse=TRUE) +
geom_text(mapping=aes(x2,y2,label = text2), data=data.frame(x2=-60, y2=0.0025, text2="p-value = 0.041"), size=3)
{% endhighlight %}

<div class="post-image">
<a href="/assets/images/blog/randomization_dist.jpg"><img alt="randomization distribution" src="/assets/images/blog/randomization_dist.jpg" height="320" width="320"/></a>
</div>

Several comments on the syntax passed to the `ggplot()` function above:

* The `layer()` function with the `geom="area"` option fills the area under the distribution corresponding to the one-sided p-value (probability of observing a value of the test statistic at least as small as the one we observe).
* manually pass the location of the text into the `geom_text()` function in this case by creating a data frame within the actual `geom_text()` function.
* Note that in order for `ggplot` to write expressions with text, such as subscripts which I use above, I pass the `parse=TRUE` option to `geom_text()`.

<br/>
Here's another example that involves plotting the distribution of p-values under the sharp null of a constant additive treatment effect for each unit. I wanted to plot the values of the resultant test statistics on the x-axis, the p-values for the sharp null on the y-axis, and then shade the 95% Fisherian confidence interval. In this case, `tau.vector` contains the values of the test statistic (difference in means). `p.vector` is a corresponding vector that contains the one-sided exact Fisher p-value for the sharp null hypothesis that the effect is 0. Note that I placed a dotted horizontal red line at a p-value of 0.025 to obtain approximately 95% coverage on my confidence interval.

{% highlight r %}
ggplot(data = CI.2c, mapping = aes(x = tau.vector, y = p.vector)) +
geom_line(color="black") +
scale_y_continuous(limits = c(0,max(CI.2c$p.vector)),name="p-value") +
scale_x_continuous(name="Difference in Means") +
layer(data = CI.2c, mapping = aes(x=ifelse((lb.2c < tau.vector & tau.vector < ub.2c),tau.vector,lb.2c), y=p.vector), geom = "area", geom_params=list(fill="yellow",alpha=.3)) +
geom_hline(aes(yintercept=0.025), color="red", linetype="dashed") +
geom_text(mapping=aes(x2,y2,label = text2), data=data.frame(x2=-100, y2=0.1, text2="95% CI: [-83,6.33]"), size=5)
{% endhighlight %}

<div class="post-image">
<a href="/assets/images/blog/pval_density.jpg"><img alt="p-value distribution" src="/assets/images/blog/pval_density.jpg" height="320" width="320"/></a>
</div>

Here's a very simple histogram example. Suppose that `pval.5` contains a vector of p-values across all possible assignment vectors. We want to plot the distribution of Fisher's exact p-values, which should be uniformly distributed between 0 and 1 under the null (and generally when dealing with continuous test statistics). We can do so simply using ggplot as:


{% highlight r %}
ggplot() +
geom_histogram(aes(x = pval.5), binwidth=0.1, linetype=1, alpha=.25, color="black", fill="red") +
scale_y_continuous(name="Count") +
scale_x_continuous(name="p-value")
{% endhighlight %}


<div class="post-image">
<a href="/assets/images/blog/pval_hist.jpg"><img alt="p-value histogram" src="/assets/images/blog/pval_hist.jpg" height="320" width="320"/></a>
</div>
