---
title:  'Scraping PDFs and Word Documents with Python'
categories: blog
layout: post
name: blog
tags:
- python
- bash
---

This week I wanted to write a Python script that was able to extract text from both pdf files and Microsoft Word documents (both .doc and .docx formats). This actually proved to be rather difficult, particularly when it came to both Microsoft Word since there was no one utility that was able to handle both the old Word format and the more recent .docx one. This post is a summary of the utilities that I came across and what I finally used to complete this task.     

<br/>
First, with regards to pdf files, the main Python library for opening pdf files is [PDFMiner](http://www.unixuser.org/~euske/python/pdfminer/). There exist several additional libraries that essentially serve as wrappers to PDFMiner, including [Slate](https://pypi.python.org/pypi/slate). Slate is significantly simpler to use than PDFMiner, but this comes at the expense of very basic functionality. Even though I first tried to use Slate, it ended up not performing well for the pdfs I was working with. Specifically, it did not fully respect the original spacing between words, thereby cutting certain words into multiple fragments or concatenating others. I thus switched to PDFMiner because of its customizability. Using the pdf2txt.py command line utility, PDFMiner experienced a similar problem with word spacing. However, this turned out to be extremely easy to tune just using a word margin option passed to the pdf2txt.py utility. Specifically, I ran the following in the command line:
 
{% highlight bash %}
pdf2txt.py -o foo.txt -W 0.5 foo.pdf
{% endhighlight %}

When it comes to Word 2007 .docx files, the Python-based utility that worked well is the [python-docx](https://github.com/mikemaccana/python-docx) library. It worked well in the command line as follows:

{% highlight bash %}
./example-extracttext.py foo.docx foo.txt
{% endhighlight %}

For older Word documents (for example Word 2003), the python-docx library does not work. I ended up using the C-based [antiword](http://linux.die.net/man/1/antiword) utility. Originally a Linux-based utility, antiword (version 0.37) can be installed on Mac OS X as follows:

{% highlight bash %}
brew update
brew install antiword
{% endhighlight %}

From within Python, I was then easily able to convert a .doc document to text:

{% highlight python %}
os.system('antiword foo.doc > foo.txt')
{% endhighlight %}