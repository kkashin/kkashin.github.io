---
title:  'Using ggplot2 to Plot Regression Coefficients with Confidence Intervals'
categories: blog
layout: post
name: blog
tags:
- R
- ggplot2
- regression
---

A graphical approach to displaying regression coefficients / effect sizes across multiple specifications can often be significantly more powerful and intuitive than presenting a regression table. Moreover, we can easily express uncertainty in the form of confidence intervals around our estimates. As a quick example, suppose that we wanted to compare the effect of British colonial status upon country-level corruption across multiple specifications and two methods (OLS and WLS) from the following paper: Treisman, Daniel. 2000. "The causes of corruption: a cross-national study," *Journal of Public Economics* 76: 399-457.

<br/>
Specifically, the dependent variable is TI98, the perceived corruption score calculated by Transparency International for 1998. The variable whose effect we seek is an indicator that equals 1 if the country is a former British colony or the UK, and 0 otherwise. I took the coefficients and associated standard errors on British colonial status from Tables 2 and 3 across the 5 different specifications where TI98 is the dependent variable. I then entered them into a data frame with the following structure:

<br/>

<table>
<tr>
<td> </td> <td>coef</td> <td>se</td> <td> method</td><td>specification </td> <td>lb </td> <td>ub </td> </tr>
<tr>
<td>1 </td> <td> -1.99</td> <td>1.01</td> <td>WLS</td> <td>1</td> <td>-3.969564</td> <td>-0.01043638</td></tr>
<tr>
<td>2</td> <td>-1.56</td> <td>0.59</td> <td>WLS</td> <td>2</td> <td>-2.716379</td> <td>-0.40362125</td></tr>
<tr>
<td>3</td> <td>-1.25</td> <td>0.52</td> <td>WLS</td> <td>3 </td> <td>-2.269181</td> <td> -0.23081873</td></tr>
<tr>
<td>4</td> <td>-1.20</td> <td>0.54</td> <td>WLS </td> <td>4 </td> <td> -2.258381</td> <td> -0.14161945</td></tr>
<tr>
<td>5</td> <td>-1.04</td> <td>0.79</td> <td>WLS</td> <td>5</td> <td>-2.588372</td> <td>  0.50837155</td></tr>
<tr>
<td>6</td> <td>-1.25</td> <td>0.81</td> <td>OLS</td> <td>1 </td> <td>-2.837571</td> <td>  0.33757083</td></tr>
<tr>
<td>7</td> <td>-1.08</td> <td>0.54</td> <td>OLS</td> <td>2 </td> <td>-2.138381</td> <td> -0.02161945</td></tr>
<tr>
<td>8</td> <td>-0.98</td> <td>0.53</td> <td> OLS</td> <td>3 </td> <td>-2.018781</td> <td>  0.05878091</td></tr>
<tr>
<td>9</td> <td>-0.82</td> <td>0.58</td> <td>OLS</td> <td>4 </td> <td>-1.956779</td> <td>  0.31677911</td></tr>
<tr>
<td>10</td> <td>-1.06</td> <td>0.96</td> <td>OLS</td> <td>5</td> <td>-2.941565</td> <td>  0.82156543</td></tr>
</table>

<br/>
Note that I calculated the upper bound (ub) and lower bound (lb) of the 95% confidence interval using the standard errors provided in the table (I assumed normality holds due to the Central Limit Theorem, which may be questionable in some specifications given small sample sizes).

<br/>
I then generated the following plot:

<div class="post-image">
<a href="/assets/images/blog/regcoef_ex1.jpg"><img alt="regression coefficients" src="/assets/images/blog/regcoef_ex1.jpg" height="320" width="320"/></a>
</div>

<br/>
Here is the code for making this plot in ggplot2 from the dataframe I provided above:

{% highlight r %}
pd <- position_dodge(width=0.2,height=NULL)

ggplot(treisman, aes(specification,coef, color=method)) +
geom_point(aes(shape=method),size=4, position=pd) +
scale_color_manual(name="Method",values=c("coral","steelblue")) +
scale_shape_manual(name="Method",values=c(17,19)) +
theme_bw() +
scale_x_continuous("Specification", breaks=1:length(specification), labels=specification) +
scale_y_continuous("Estimated effect of being a former British colony or the UK on TI98") +
geom_errorbar(aes(ymin=lb,ymax=ub),width=0.1,position=pd)
{% endhighlight %}

The `geom_errorbar()` function plots the confidence intervals. Note that I use the `position_dodge()` function to horizontally shift the coefficients and confidence intervals for the same specifications for clarity. The `height=NULL` option can be omitted. The color and shape for the legend is controlled manually.

<br/>
What would happen if I just set `name="Method"` for the `scale_color_manual` command, but left out the `scale_shape_manual` command, letting it be automatically determined:

{% highlight r %}
ggplot(treisman, aes(specification,coef, color=method)) +
geom_point(aes(shape=method),size=4, position=pd) +
scale_color_manual(name="Method",values=c("coral","steelblue")) +
theme_bw() +
scale_x_continuous("Specification", breaks=1:length(specification), labels=specification) +
scale_y_continuous("Estimated effect of being a former British colony or the UK on TI98")   +
geom_errorbar(aes(ymin=lb,ymax=ub),width=0.1,position=pd)
{% endhighlight %}

This would be the plot:

<div class="post-image">
<a href="/assets/images/blog/regcoef_ex2.jpg"><img alt="regression coefficients" src="/assets/images/blog/regcoef_ex2.jpg" height="320" width="320"/></a>
</div>

<br/>
This happens because I also set the shape of the points to be determined by the method variable, just as for color. I thus I need to manually give the same name to both scales, or else otherwise they are automatically broken up into two legends, one manual titled "Method" and one automatic title "method".

<br/>
What if I wanted to reorder the ordering of the methods in the plot; that is, if we wanted WLS to be plotted first, then OLS?

<br/>
This can be achieved with the following command before running the first block of code on this page.

{% highlight r %}
df$method <- reorder(df$method,rep(1:2,each=5))
{% endhighlight %}

The result is the following:

<div class="post-image">
<a href="/assets/images/blog/regcoef_ex3.jpg"><img alt="regression coefficients" src="/assets/images/blog/regcoef_ex3.jpg" height="320" width="320"/></a>
</div>

<br/>
Finally, suppose that we wanted to customize the x-axis labels by tilting them diagonally and changing them to a dark grey. Adding the following extra piece of code to the blocks of code above would accomplish that:

{% highlight r %}
+ theme(axis.text.x=element_text(angle=45,color="darkgray"))
{% endhighlight %}
