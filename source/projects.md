---
layout: page
title: Projects
permalink: /projects/
---

<section>
  {% for post in site.categories.projects %}
    <article class="post-item">
      <p><strong><a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></strong> — <span> {{ post.content | strip_html | truncatewords: 40 }}</span> <a class="post-link readmore" href="{{ post.url | prepend: site.baseurl }}">Read more</a></p>
    </article>
  {% endfor %}
</section>


## Teaching
See <a href="/teaching/">here for teaching and section notes </a>.
