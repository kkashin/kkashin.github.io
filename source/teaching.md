---
layout: page
title: Teaching
permalink: /teaching/
---

<section>
  {% for post in site.categories.teaching %}
    <article class="post-item">
      <p><strong><a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></strong> — <span> {{ post.content | strip_html | truncatewords: 40 }}</span> <a class="post-link readmore" href="{{ post.url | prepend: site.baseurl }}">Read more</a></p>
    </article>
  {% endfor %}
</section>
