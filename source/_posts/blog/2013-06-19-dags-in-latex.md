---
title:  'DAGs in LaTeX'
categories: blog
layout: post
name: blog
tags:
- LaTeX
- causal inference
---

Directed acyclic graphs (DAGs) are commonly used to represent causal relationships between variables across a wide variety of disciplines. For an excellent (and quite accessible) textbook on the topic, please see the book [*Causal Inference* by Miguel Hernan and Jamie Robins](http://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/).

<br/>
In this post, I briefly explore how you can draw DAGs in LaTeX. In the subsequent post, I will show how to draw DAGs using R.

<br/>
The first example of DAG is the common instrumental variable (IV) setup:

<div class="post-image">
<a href="/assets/images/blog/IVdag_tex.jpg"><img alt="instrumental variables DAG latex" src="/assets/images/blog/IVdag_tex.jpg" height="100" width="200"/></a>
</div>

We seek to identify the effect of treatment *T* on outcome *Y*. However, this is confounded by an unmeasured variable *U*. The IV is denoted as *Z*. Technically, we do not need to put in the crossed out red edges between *U* and *Z* and *Z* and *Y* - absence of edges encodes independence relations. However, I included them to reinforce (and make explicit) the assumptions needed for identification of causal effects using IVs:

* (Quasi)-exogeneity of the instrument (no path from *U* to *Z*)
* Exclusion restriction (no direct path from *Z* to *Y*)

This was made using the [TikZ](http://pgf.sourceforge.net/) package in LaTeX. I used the `\usepackage{pgf,tikz}` command at the beginning of my document.

<br/>
The code to create the DAG above is:

{% highlight r %}
\begin{tikzpicture}
% nodes %
\node[text centered] (z) {$Z$};
\node[right = 1.5 of z, text centered] (t) {$T$};
\node[right=1.5 of t, text centered] (y) {$Y$};
\node[draw, rectangle, dashed, above = 1 of t, text centered] (u) {$U$};

% edges %
\draw[->, line width= 1] (z) --  (t);
\draw [->, line width= 1] (t) -- (y);
\draw[->,red, line width= 1,dashed] (u) --node {X} (z);
\draw[->,line width= 1] (u) --(t);
\draw[->,line width= 1] (u) -- (y);
\draw[->, red, line width=1,dashed] (z) to  [out=270,in=270, looseness=0.5] node{X} (y);
\end{tikzpicture}
{% endhighlight %}

Note that I first create the nodes (corresponding to variables in the DAG), and then draw the directed edges between the nodes.

<br/>
Another example of a DAG is a simple structural equation model where we want each edge to be marked with the parameter signifying the causal effect. For example:

<div class="post-image">
<a href="/assets/images/blog/sem_dag.jpg"><img alt="structural equation model DAG latex" src="/assets/images/blog/sem_dag.jpg" height="120" width="200"/></a>
</div>

In LaTeX:

{% highlight r %}
\begin{tikzpicture}
% nodes %
\node[text centered] (t) {$T$};
\node[right = 1.5 of t, text centered] (m) {$M$};
\node[right=1.5 of m, text centered] (y) {$Y$};

% edges %
\draw[->, line width= 1] (t) -- node[above,font=\footnotesize]{$\beta$}  (m);
\draw [->, line width= 1] (m) -- node[above,font=\footnotesize]{$\gamma$}  (y);
\draw[->, line width=1] (t) to  [out=270,in=270, looseness=0.5] node[below, font=\footnotesize]{$\delta$} (y);
\end{tikzpicture}
{% endhighlight %}
