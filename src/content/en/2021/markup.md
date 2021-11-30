---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Markup
description: Markup chapter of the 2021 Web Almanac covering the use of elements, attributes, document trends, as well as adoption rates of new standards.
authors: [AlexLakatos]
reviewers: [j9t, bkardell, shantsis, tunetheweb, rviscomi]
analysts: [kevinfarrugia]
editors: []
AlexLakatos_bio: Alex Lakatos has spent the past decade working on the Open Web within Browser, Communications, and FinTech organizations. With a background in web technologies and developer advocacy, he's helping the <a hreflang="en" href="https://interledger.org/">Interledger Foundation</a> build developer-friendly products while engaging with the developer community at large. You can <a hreflang="en" href="https://twitter.com/avolakatos">reach out to him on Twitter</a>.
translators: []
results: https://docs.google.com/spreadsheets/d/1Ta5Ck7y3W6LCn2CeGtW7dAdLF6Lh5wV2UBQJZTz3W5Q/
featured_quote: Be part of the people who increase adoption of new standards every year. Start with something new you’ve learned today, one of the many standards we’ve covered not only in this chapter but in this whole Almanac.
featured_stat_1: 35.3%
featured_stat_label_1: ICO was finally dethroned as the most popular favicon format by PNG
featured_stat_2: 98%
featured_stat_label_2: Pages have at least one <script> element in HTML
featured_stat_3: 4,256
featured_stat_label_3: The most <form> elements found on a single page.
unedited: true
---

## Introduction

Have you ever wondered what happens when you try to visit a web site? After you enter the URL in the address bar of your browser, one of the first things that happens is that a HTML file is downloaded and parsed. You could say that markup is the foundation of the Web. We’ve dedicated this chapter to looking at some of the bricks that make the web stand today.


We’ve drawn on the data analyzed for the past three years to try to come up with a few questions around the future of markup, the trends emerging over the years, and the adoption rate of new standards. We’ve also shared the data in the hopes that you’ll dig deeper into it, and interpret it in a way that we haven’t.

_In the Markup chapter, we focus on HTML. While we briefly touch on other markup languages (like SVG or MathML) or other topics in the Almanac, those are covered in more detail in their own dedicated chapters. Because the markup is the gateway into the web, it was extremely hard not to dedicate a whole chapter to it._


## General


### Doctypes

Ever wondered why all pages start with `&lt;!DOCTYPE html>` or something similar, even in 2021? Doctypes are required because they tell the browsers not to switch into “[quirks mode](https://developer.mozilla.org/en-US/docs/Web/HTML/Quirks_Mode_and_Standards_Mode)” when rendering a page, and instead, they should make a best-effort attempt to follow the HTML spec. 

This year, 97.39% of pages had a doctype, slightly up from last year’s 96.82%. Looking at the past couple of years, the doctype percentage has increased steadily by half a percentage point every year.  In an ideal world, 100% of web pages would have a doctype - at this rate, we’ll live in an ideal world by 2027!

In terms of popularity, HTML5, better known as `&lt;!DOCTYPE html>` is still the most popular doctype, with 87% of pages using it.


<table>
  <tr>
   <td><em>Doctype</em>
   </td>
   <td><em>Desktop</em>
   </td>
   <td><em>Mobile</em>
   </td>
  </tr>
  <tr>
   <td>HTML (“HTML5”)
   </td>
   <td>87.00%
   </td>
   <td>88.77%
   </td>
  </tr>
  <tr>
   <td>XHTML 1.0 Transitional
   </td>
   <td>5.65%
   </td>
   <td>4.64%
   </td>
  </tr>
  <tr>
   <td>XHTML 1.0 Strict
   </td>
   <td>1.40%
   </td>
   <td>1.28%
   </td>
  </tr>
  <tr>
   <td>HTML 4.01 Transitional
   </td>
   <td>0.88%
   </td>
   <td>0.67%
   </td>
  </tr>
  <tr>
   <td>HTML 4.01 Transitional (<a href="https://hsivonen.fi/doctype/#xml">quirky</a>)
   </td>
   <td>0.51%
   </td>
   <td>0.46%
   </td>
  </tr>
</table>


The surprising part is that, [almost 20 years later](https://en.wikipedia.org/wiki/XHTML), XHTML is still a considerable part of the web, with 8% of pages still using it on desktop and a little under 7% on mobile .


### Document size

In a mobile world, where every byte of data has a cost associated with it, document sizes for mobile websites are becoming increasingly more important. It is also increasingly bigger, by the looks of it. This year, the median mobile page had 27 KB of HTML, up 2 KB from last year. On the desktop side, the median page had 29 KB of HTML.



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


The interesting points were:



* The median page sizes in 2020 were shrinking when compared to 2019. Looking at Figure 3, we’ve had a slight increase this year, after the dip in 2020.
* The biggest HTML documents for both desktop and mobile have shed a whopping 20 MB each this year, with the biggest ones being 45 MB on desktop and 21 MB on mobile.


### Compression

With document sizes increasing, we also looked at compression this year. We felt the document size relates closely to the level of compression used when transferring it over the wire.



<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


Out of the 6 million desktop pages scanned, an overwhelming 84.42% were compressed with either gzip (62.68%) or Brotli (21.74%) compression. For mobile pages, the numbers are very similar, 85.60% were compressed with either gzip (63.67%) or Brotli (21.93%) compression.

While the slight variation in percentages for mobile and desktop is not surprising, what is surprising is that almost 1 percentage point more pages are compressed for mobile only. In a [mobile world, where every byte of data has a cost associated with it](https://almanac.httparchive.org/en/2021/mobile-web), seeing that mobile pages are not only optimized, but smaller than the desktop counterparts is great. Learn more about the state of content encoding in the [Compression](./compression) chapter.


### Document language

We’ve encountered 3,598 unique instances for the `lang` attribute on the `html` element. Because there are [7,139 spoken languages](https://www.ethnologue.com/guides/how-many-languages) at the time of writing this chapter, it made us think not all of them were represented. When we factored in the [script and region subtags](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang#language_tag_syntax), even fewer remained.



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")



Out of the pages scanned, 19.6% on desktop, and 18.6% on mobile, [specified no lang attribute](https://almanac.httparchive.org/en/2021/accessibility), even though the Web Content Accessibility Guidelines ([WCAG](https://www.w3.org/TR/UNDERSTANDING-WCAG20/meaning-doc-lang-id.html)) requires that a page language is defined, and ‘programmatically accessible’. Language can be specified in different ways, including an `xml:lang` element, which we didn’t check for, so there might still be hope for some of the pages scanned.




<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")



While we looked at the top 10 normalized languages in the set, some interesting trends emerged:



* Mobile has a lower relative percentage of English websites. We’re not sure why that is the case, we’ve been discussing the cause as a team. It’s possible that some people only use mobile phones to access the web, so that would diversify the mobile set's language landscape. This author believes a lot of the mobile pages are intended to be used on the go and are hence local.
* While Spanish has a lot more region and subscript options than Japanese, it was a tight contest for the second most popular language.
* There is an inverse correlation between the difference in empty attributes for desktop and mobile and English.


### Comments

**88%**

Pages with at least one comment in HTML

Most production build tools have an option to remove comments, but we’ve found a majority of the pages we’ve analyzed, 88%, had at least one comment.

While comments are generally encouraged in code, a particular type of comments, conditional comments, were used in web pages to render markup for particular browsers. 

&lt;!--[if IE 8]>

  &lt;p>This renders in Internet Explorer 8 only.&lt;/p>

&lt;![endif]-->


Microsoft dropped support for conditional comments in IE10. Still, 41% of the pages had at least a conditional comment present. Aside from the possibility that these are very old websites, we could only assume they are using some sort of variation of polyfilling framework for older browsers.


### SVG use

This year, we wanted to take a look at SVG usage. With popular icon libraries using more and more SVG, favicon support improving and SVG images being on the rise in animations, it’s no surprise 46% of web pages had some sort of SVG on them. 37% had a SVG element, 20.04% on desktop and 18.44% on mobile were using SVG images, and a negligible amount had either SVG embeds, objects or iframes in them.

SVGs have more use cases when compared to the style element, but in terms of popularity, the numbers are comparable. SVG sits just outside the top 20 in terms of element popularity on a page.


## Elements

Elements are the DNA of a HTML document. We wanted to analyze the cells that make up the living organism that is a web page. What are the most popular, the most likely to be present, and the obsolete elements on most pages?


### Element diversity

There are [112 elements](https://html.spec.whatwg.org/multipage/indices.html#elements-3) currently defined and in use (excepting SVG and MathML), with another [28 being deprecated](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#obsolete_and_deprecated_elements) or obsolete. We wanted to see how many of them were actually used on a page, and how likely a web of `div`s was. 





<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


No need to panic, the web isn’t all made up of divs. The median page uses 31 different elements, and has a total of 666 elements.



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")



### Top elements

Every year since 2019, the Markup chapter of the Web Almanac has featured the most frequently used elements in reference to[ Ian Hickson’s work in 2005](https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html). This author couldn’t break with tradition, so we had a look at the data again.


<table>
  <tr>
   <td><em>2005</em>
   </td>
   <td><em>2019</em>
   </td>
   <td><em>2020</em>
   </td>
   <td><em>2021</em>
   </td>
  </tr>
  <tr>
   <td>title
   </td>
   <td>div
   </td>
   <td>div
   </td>
   <td>div
   </td>
  </tr>
  <tr>
   <td>a
   </td>
   <td>a
   </td>
   <td>a
   </td>
   <td>a
   </td>
  </tr>
  <tr>
   <td>img
   </td>
   <td>span
   </td>
   <td>span
   </td>
   <td>span
   </td>
  </tr>
  <tr>
   <td>meta
   </td>
   <td>li
   </td>
   <td>li
   </td>
   <td>li
   </td>
  </tr>
  <tr>
   <td>br
   </td>
   <td>img
   </td>
   <td>img
   </td>
   <td>img
   </td>
  </tr>
  <tr>
   <td>table
   </td>
   <td>script
   </td>
   <td>script
   </td>
   <td>script
   </td>
  </tr>
  <tr>
   <td>td
   </td>
   <td>p
   </td>
   <td>p
   </td>
   <td>p
   </td>
  </tr>
  <tr>
   <td>tr
   </td>
   <td>option
   </td>
   <td>link
   </td>
   <td>link
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>i
   </td>
   <td>meta
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>option
   </td>
   <td>i
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>ul
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>option
   </td>
  </tr>
</table>



The top six elements haven’t changed in the past three years, and it looks like the link element is gaining a foothold as a solid number seven.

It’s interesting to see that `i` and `option` have both fallen out of favor. The first probably because libraries that misuse the `i` element for icons have fallen out of popularity in favor of libraries using SVGs for icons. The `meta` element is making a strong push into the top 10 this year, perhaps because social markup is also on the rise. We’ll look at social markup in a later section of this chapter. The rise of styled `select` elements accounts for the `ul` (unordered list) element gaining popularity over the option element.


#### main

With the [creation of content spiking in 2021](https://wordpress.com/activity/posting/) (most likely because the world was stuck in a pandemic), we wanted to see if that correlates to an adoption of content elements as well. We thought `main` is a good indicator, it being an informative element that doesn’t affect the DOMs concept of the structure of a page.

**27%**

Pages with at least one &lt;main> element in HTML

27.68% of desktop pages and 27.88% of mobile pages had a `main` element. In terms of popularity, it made it well in the top 50 elements, with a respectable 34. Before you start thinking that there are only 114 elements, we’ve actually had more than a thousand elements come back from the queries we ran, most of which were custom.


#### base

Another curiosity was how much were developers paying attention to the stricter rules of the HTML spec. For example, the spec says there must be [no more than one `base` element](https://html.spec.whatwg.org/multipage/semantics.html#the-base-element) in a document, because the `base` element defines how user agents should resolve relative URLs. Having more than one `base` element introduces ambiguity, so the spec requires that all `base` elements after the first be ignored, rendering them useless.

From looking at the desktop pages, `base` is a popular element, with 10.39% of pages having one. But do they have only one? There are 5,908 more `base` elements than pages, we can only conclude at least some pages have more than one `base` element. Who said developers were great at following directions? We would also recommend people validate their HTML using the W3C-provided [Markup Validation Service](https://validator.w3.org/).



#### dialog

Throughout the chapter we wanted to also look at the adoption of some of the more controversial or new elements. `dialog` is one of them, with not all major browsers supporting it out of the box yet. Only 7,617 pages on desktop and 7,819 pages on mobile are using a dialog element. When we consider that’s only around  0.1% of the pages analyzed, it doesn’t look like the adoption is there yet.


#### canvas

The `canvas` element can be used with either the [Canvas API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API) or [WebGL API](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API) to draw graphics and animations. It’s one of the main elements used for games or mixed reality on the web. It’s no surprise 3.07% of the desktop pages and 2.61% of the mobile pages use it. The higher usage on desktop makes sense when you consider the graphic capabilities of the different devices, and the use cases skewed towards games and virtual reality.


### Probability of element use

While the `html`, `head`, `body`, `title`, and `meta` elements are all optional, they’re the most common elements this year, all present on more than 99% of the pages.

&lt;p class="note">Note that as we are looking at the rendered HTML, and the browsers will automatically add the `html` and `head` elements, this chart shows we have an error rate of 0.16% of pages in our crawl due to sites no longer being accessible at the time of the crawl.&lt;/p>



<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


While the percentages are slightly different when compared with last year, the order for the most popular elements remains the same. What about some of the more exotic elements?



<table>
  <tr>
   <td><em>Element</em>
   </td>
   <td><em>Percent of pages (mobile)</em>
   </td>
  </tr>
  <tr>
   <td><em>tt</em>
   </td>
   <td>0.04%
   </td>
  </tr>
  <tr>
   <td>ruby
   </td>
   <td>0.02%
   </td>
  </tr>
  <tr>
   <td>rt
   </td>
   <td>0.02%
   </td>
  </tr>
</table>



It’s interesting to see that `tt`, a deprecated element for [Teletype Text](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tt), is 100% more popular than `ruby` and `rt`, which are the [Ruby Annotation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ruby) and [Text](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/rt) elements still used for showing the pronunciation of East Asian characters.


### Script

**98%**

Pages with at least one &lt;script> element in HTML

A little over 98% of the pages scanned contain at least one `script` element. It’s no surprise that `script` is also the 6th most popular element on a page. Compared with last year, the script element seems to remain constant in terms of popularity and has slightly increased levels of occurrence in the millions of pages analyzed, from 97% to 98%.

**51%**

Pages with at least one &lt;noscript> element in HTML

51% of pages also contain a `noscript` element, which is generally used to display a message for browsers that have disabled JavaScript. Another popular use for the `noscript` element is the Google Tag Manager (GTM) snippet. 18.84% of pages on desktop and 16.92% of pages on mobile are using the noscript element as part of the GTM snippet. It’s interesting to note that GTM is more popular on desktop than mobile.


### Template

One of the [least recognized, but most powerful features](https://css-tricks.com/crafting-reusable-html-templates/) of the Web Components specification is the &lt;template> element. Despite the fact that the [`template` element](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots) is well supported on modern browsers since 2013, only 0.5% of the pages were using it in 2021. In terms of popularity, it didn’t even make it into the top 50 elements. We thought this speaks volumes about the adoption curve of the modern HTML specification for web developers.

In case you don’t really know what template does, here is a refresher from the specification: “the template element is used to declare fragments of HTML that can be cloned and inserted in the document by script”. If you’re a web developer and think that sounds familiar, you’re right. Most of the popular frameworks today have a similar non-native mechanism to do the same: Angular has [&lt;ng-content>](https://angular.io/guide/content-projection), React has [portals](https://reactjs.org/docs/portals.html) and Vue has [&lt;slot>](https://v3.vuejs.org/guide/component-slots.html#slots). We would have thought those frameworks would use the native template element or Web Components instead of re-creating the functionality within the frameworks.


### Style

**83%**

Pages with at least one &lt;style> element in HTML

When creating a web page, three things come together. One is HTML, and we’re looking at that throughout this chapter. The second one is JavaScript, and we saw in the previous section that the script element used to load JavaScript is one of the most popular ones. It doesn’t come as a shock that the `style` element, used to inline CSS is similarly popular. 83% of the pages scanned had at least one style element. 

In terms of sheer popularity on a page, it barely made it into the top 20, with 0.7%. That leaves us to believe that while multiple script elements are popular on a page, most have five times less style elements on them. And that makes sense. Because script elements can be used for both inline and external scripts, but CSS uses a separate element, the link element, for loading external style sheets. The link element is present on slightly more pages than the script element, while being slightly less popular in terms of numbers of occurrences.


### Custom elements

We’ve also looked at elements that didn’t show up on the HTML or SVG  spec, be it current or obsolete, to determine what custom elements were out there in the wild.


<table>
  <tr>
   <td><em>Element</em>
   </td>
   <td><em>Pages</em>
   </td>
   <td><em>Percentage</em>
   </td>
  </tr>
  <tr>
   <td><em>rs-module-wrap</em>
   </td>
   <td>123189
   </td>
   <td>1.96%
   </td>
  </tr>
  <tr>
   <td><em>wix-image</em>
   </td>
   <td>76138
   </td>
   <td>1.21%
   </td>
  </tr>
  <tr>
   <td><em>pages-css</em>
   </td>
   <td>75539
   </td>
   <td>1.20%
   </td>
  </tr>
  <tr>
   <td><em>router-outlet</em>
   </td>
   <td>35851
   </td>
   <td>0.57%
   </td>
  </tr>
  <tr>
   <td><em>next-route-announcer</em>
   </td>
   <td>9002
   </td>
   <td>0.14%
   </td>
  </tr>
  <tr>
   <td><em>app-header</em>
   </td>
   <td>7844
   </td>
   <td>0.12%
   </td>
  </tr>
  <tr>
   <td><em>ng-component</em>
   </td>
   <td>3714
   </td>
   <td>0.06%
   </td>
  </tr>
</table>


By far, the most popular one is [Slider Revolution](https://www.sliderrevolution.com/faq/developer-guide-output-class-tag-changes/), with a majority of elements attributed to the framework. It more than tripled in popularity over the past year, which leads us to believe it might be a part of a popular template or site builder. A close second is [Wix](https://www.wix.com/), the popular free site builder. We couldn’t identify pages-css, but we'd love to hear any ideas for why the `pages-css` element is so popular, so let us know by [suggesting an edit]([https://almanac.httparchive.org/en/2020/markup#explore-results](https://almanac.httparchive.org/en/2020/markup#explore-results)) on GitHub.


We would have thought that popular frameworks like [Angular](https://angular.io/), [Next.js](https://nextjs.org/) or the former [Angular.js ](https://angularjs.org/)would account for more custom components, but `router-outlet` and `ng-component` make up a small part of the custom component base. 


### Obsolete elements

There are currently [28 obsolete and deprecated elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#obsolete_and_deprecated_elements) described in the HTML reference. We wanted to see how many of those were still in use today. By far, the most used ones are `center` and `font`, and we’re glad to see their usage has slightly declined when compared with last year.

`nobr` and `big` on the other hand, while still being deprecated, have increased in usage slightly when compared with last year.



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


While the percentage of obsolete elements for mobile pages is slightly different when compared with desktop, the order remains the same. 



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


Google still uses a `center` element on their homepage in 2021, but we’re not going to judge.


### Proprietary and non-standard elements

While custom elements all have a hyphen in them, we’ve also encountered elements that are made up, don’t have a hyphen and don’t show up on the [HTML standard](https://html.spec.whatwg.org/#toc-semantics).

All of them were present last year as well, and can be attributed to popular frameworks or products like JivoChat, Yandex, MediaElement.js and Yandex Maps. And because some people get carried away, or six is just not enough headers, h7 to h9.


<table>
  <tr>
   <td><em>Element</em>
   </td>
   <td><em>Mobile</em>
   </td>
   <td><em>Desktop</em>
   </td>
  </tr>
  <tr>
   <td><em>jdiv</em>
   </td>
   <td>0.78%
   </td>
   <td>0.78%
   </td>
  </tr>
  <tr>
   <td>noindex
   </td>
   <td>0.86%
   </td>
   <td>0.76%
   </td>
  </tr>
  <tr>
   <td><em>mediaelementwrapper</em>
   </td>
   <td>0.56%
   </td>
   <td>0.59%
   </td>
  </tr>
  <tr>
   <td>ymaps
   </td>
   <td>0.29%
   </td>
   <td>0.20%
   </td>
  </tr>
  <tr>
   <td>h7
   </td>
   <td>0.06%
   </td>
   <td>0.07%
   </td>
  </tr>
  <tr>
   <td>h8
   </td>
   <td>0.02%    
   </td>
   <td>0.02%
   </td>
  </tr>
  <tr>
   <td>h9
   </td>
   <td>0.01%   
   </td>
   <td>0.01%   
   </td>
  </tr>
</table>



### Embedded content

Content can be embedded through multiple elements in a page. The most popular is an `iframe`, followed at a considerable distance by `source` and `picture`.

The actual `embed` element is the least popular out of all the present elements for embedding content.


<table>
  <tr>
   <td><em>Element</em>
   </td>
   <td><em>Desktop</em>
   </td>
   <td><em>Mobile</em>
   </td>
  </tr>
  <tr>
   <td><em>iframe</em>
   </td>
   <td>56.66%
   </td>
   <td>54.51%
   </td>
  </tr>
  <tr>
   <td><em>source</em>
   </td>
   <td>9.91%
   </td>
   <td>8.36%
   </td>
  </tr>
  <tr>
   <td><em>picture</em>
   </td>
   <td>6.06%
   </td>
   <td>5.95%
   </td>
  </tr>
  <tr>
   <td><em>object</em>
   </td>
   <td>1.42%
   </td>
   <td>1.98%
   </td>
  </tr>
  <tr>
   <td><em>param</em>
   </td>
   <td>0.43%
   </td>
   <td>0.36%
   </td>
  </tr>
  <tr>
   <td><em>embed</em>
   </td>
   <td>0.42%
   </td>
   <td>0.36%
   </td>
  </tr>
</table>



### Forms

Forms, or ways of getting input from your visitors,  are part of the fabric of the web. It’s no surprise that 71.28% of pages on desktop and 67.49% of pages on mobile had at least one `form` on them. The most common occurrence was one (33.02% on desktop and 31.55% on mobile) or two (17.86% on desktop and 16.81% on mobile) `form` elements on a page. 


**4,256**

The most `form` elements found on a single page.


There are also extreme cases with one page having 4,018 `form` elements on desktop and 4,256 `form` elements on mobile. We can’t help but wonder what kind of input is so valuable, that you’d have to break it up in 4,000 pieces.


## Attributes

Element behaviors are heavily influenced by attributes, so we thought it was only fair we took a look at the attributes used on a page, explore `data-*` patterns, and some popular social attributes for meta elements.


### Top attributes



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


The most popular attribute is `class` and that’s no surprise, given that it’s used for styling. 34.02% of all the attributes found on the pages we queried were `class`. By contrast, `id` was much less used, at 5.09%. It’s interesting to note the `style` attribute edged out the `id` attribute in popularity, accounting for 5.78% of occurrences.

The second most popular attribute is `href`, with 10.11% of occurrences. With links being part of the fabric of the web, it’s not surprising an anchor element attribute was this popular. What was surprising is that the `src` attribute was only twice as popular as the `alt` attribute, despite it being [available to considerably more elements.](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes)



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")




#### Meta flavors

`meta` elements are gaining some of their lost popularity this year, so we wanted to take a closer look at them. They provide a way to add machine-readable information to your pages, as well as perform some nifty HTTP equivalents. For example, setting a content security policy for a page:

```html

&lt;meta http-equiv="Content-Security-Policy"

      content="default-src 'self'; img-src https://*;">

```

From the available attributes, `name`, paired with `content` was the most popular. 14.19% of the `meta` elements did not have a `name` attribute. In conjunction with the `content` attribute, they are used as a key-value pair for passing in information. What information, you ask?



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")



The most popular is viewport information, with the most popular `viewport` value being `initial-scale=1,width=device-width`. 46.56% of desktop pages scanned used that value.

The second most popular combination are `og:*` meta elements, also known as [Open Graph](https://ogp.me/) meta elements. We’ll talk about those in the next section.


#### Social markup
Providing information and assets for social platforms to use when previewing links to your page  is a popular use case for the `meta` element.



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


The most common by far are the Open Graph `meta` elements, used across multiple networks, with Twitter specific elements lagging behind. `og:title`, `og:type`, `og:image` and `og:url` are all required for every page, so it’s interesting there is a variation in their usage numbers.


### `data-` attributes

The [HTML specification allows](https://html.spec.whatwg.org/#embedding-custom-non-visible-data-with-the-data-*-attributes) for custom attributes, prefixed by `data-*`. They are intended to store custom data, state, annotations, and similar, private to the page or application, for which there are no more appropriate attributes or elements.



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


The most common ones, `data-id`, `data-src` and `data-type` are non-specific, with `data-src`,  `data-srcset` and `data-sizes` being very popular with image lazy loading libraries. `data-element_type` and  `data-widget_type` are coming from a popular website builder, [Elementor](https://code.elementor.com/).

[Slick, “the last carousel you’ll ever need”](https://github.com/kenwheeler/slick), is responsible for `data-slick-index`. Popular frameworks like Bootstrap are responsible for `data-toggle`, while [testing-library](https://testing-library.com/docs/queries/bytestid/) is responsible for `data-testid`.


## Miscellaneous

We’ve covered a good chunk of the most common HTML use cases. We’ve set aside this section at the end to look into some of the more esoteric use cases, as well as adoption of new standards on the web.


### `viewport` specifications

The `viewport` meta element is used to control layout on mobile devices. Or at least that was the idea when it came out. Today, [some browsers](https://www.quirksmode.org/blog/archives/2020/12/userscalableno.html) have started to ignore some of the `viewport` options to allow for zooming a page [up to 500%](https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large).


<table>
  <tr>
   <td><em>Attribute</em>
   </td>
   <td><em>Desktop</em>
   </td>
   <td><em>Mobile</em>
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,width=device-width</em>
   </td>
   <td>46.56%
   </td>
   <td>45.01%
   </td>
  </tr>
  <tr>
   <td><em>empty</em>
   </td>
   <td>12.84%
   </td>
   <td>8.21%
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,maximum-scale=1,width=device-width</em>
   </td>
   <td>5.32%
   </td>
   <td>5.56%
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width</em>
   </td>
   <td>4.60%
   </td>
   <td>5.36%
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width</em>
   </td>
   <td>4.00%
   </td>
   <td>4.27%
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,shrink-to-fit=no,width=device-width</em>
   </td>
   <td>3.88%
   </td>
   <td>3.77%
   </td>
  </tr>
  <tr>
   <td><em>width=device-width</em>
   </td>
   <td>3.34%
   </td>
   <td>3.48%
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no,width=device-width</em>
   </td>
   <td>1.92%
   </td>
   <td>2.46%
   </td>
  </tr>
  <tr>
   <td><em>initial-scale=1,user-scalable=no,width=device-width</em>
   </td>
   <td>1.88%
   </td>
   <td>1.93%
   </td>
  </tr>
</table>


The most common `viewport` content option is `initial-scale=1,width=device-width`, which is not surprising when it’s the recommended option on the [MDN guide](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag) explaining viewports. 46.56% of the pages analyzed are using it, almost 3% more than [last year](https://almanac.httparchive.org/en/2020/markup#viewport-specifications). 12.84% of pages had an empty `content` attribute, slightly more than last year as well. That correlates with a decrease in usage for improper combinations of viewport options.


### Favicons

Favicons are one of the most resilient pieces of the web. They work even without markup and accept multiple image formats. There are also literally dozens of sizes you need to use to be thorough.



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")


There were a couple of surprises when we looked at the data:



* ICO was finally dethroned as the most popular format by PNG;
* JPG is still used, even though it’s not the best option when compared with some of the other unpopular options;
* With SVG support for favicons finally improving, SVG has overtaken WebP [this year](https://almanac.httparchive.org/en/2020/markup#favicons) in terms of popularity.


### Button and input types

**66%**

Pages with at least one &lt;button> element in HTML

Buttons are “controversial”. There are a lot of opinions of what does and what doesn’t constitute a button on the web. While we’re not taking sides, we thought we should look at some of the semantic ways to specify a button element, seeing as how 66% of pages already had a `button` element in them.



<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")


When we compared the data to [last year](https://almanac.httparchive.org/en/2020/markup#favicons), we noticed a lot more pages had a `button` element on it. This year we didn’t run a query for `input`-typed buttons, but we’ve seen a definite decrease in usage for the number of `button` elements on pages. The [Accessibility chapter](https://almanac.httparchive.org/en/2021/accessibility) also has a whole section on buttons, you should read that as well!


### Links

Links are the glue that ties the web together. Normally, we wanted to look at the instances where they are proving problematic. Using `target=”_blank”` without `noopener` and `noreferrer` was a security vulnerability for the longest time, but 71.09% of desktop pages and 68.89% of mobile pages still use it today. 


<table>
  <tr>
   <td><em>Link</em>
   </td>
   <td><em>Desktop</em>
   </td>
   <td><em>Mobile</em>
   </td>
  </tr>
  <tr>
   <td><em>Always use `target=”_blank”` with `noopener` and `noreferrer`</em>
   </td>
   <td>22.02%
   </td>
   <td>23.24%
   </td>
  </tr>
  <tr>
   <td><em>Sometimes use `target=”_blank”` with `noopener` and `noreferrer`</em>
   </td>
   <td>77.98%
   </td>
   <td>76.76%
   </td>
  </tr>
  <tr>
   <td><em>Has `target=”_blank”`</em>
   </td>
   <td>81.15%
   </td>
   <td>79.87%
   </td>
  </tr>
  <tr>
   <td><em>Has `target=”_blank”` with `noopener` and `noreferrer`</em>
   </td>
   <td>14.25%
   </td>
   <td>13.22%
   </td>
  </tr>
  <tr>
   <td><em>Has `target=”_blank”` with `noopener`</em>
   </td>
   <td>21.19%
   </td>
   <td>20.14%
   </td>
  </tr>
  <tr>
   <td><em>Has `target=”_blank”` with `noreferrer`</em>
   </td>
   <td>1.18%
   </td>
   <td>1.09%
   </td>
  </tr>
  <tr>
   <td><em>Has `target=”_blank”` without `noopener` and `noreferrer`</em>
   </td>
   <td>71.09%
   </td>
   <td>69.89%
   </td>
  </tr>
</table>


That’s what probably prompted a [spec change](https://github.com/whatwg/html/issues/4078) this year, so now browsers set  `rel=”noopener”` by default on all `target=”_blank”` links.

 


### Web Monetization

[Web Monetization](https://discourse.wicg.io/t/proposal-web-monetization-a-new-revenue-model-for-the-web/3785) is being proposed as a W3C standard at the Web Platform Incubator Community Group (WICG). It’s a young standard that provides an open, native, efficient, and automatic way to compensate creators, pay for API calls, and support crucial web infrastructure. While it is in its early days, and it is not implemented by any of the major browsers, it is supported via forks and extensions, and has been instrumented in Chromium and the HTTP Archive data for over a year.  We wanted to take a look at adoption so far. 


<table>
  <tr>
   <td><em>Client</em>
   </td>
   <td><em>Monetized</em>
   </td>
   <td><em>Pages</em>
   </td>
   <td><em>Percentage</em>
   </td>
  </tr>
  <tr>
   <td><em>Desktop</em>
   </td>
   <td>1258
   </td>
   <td>6286373
   </td>
   <td>0.02%
   </td>
  </tr>
  <tr>
   <td><em>Mobile</em>
   </td>
   <td>1067
   </td>
   <td>7491840
   </td>
   <td>0.01%
   </td>
  </tr>
</table>


Web Monetization popularly uses a `meta` element on the page, specifying the wallet address for the money to be paid into. It looks a little bit like
`&lt;meta name="monetization" content="$wallet.example.com/alice">`.



<p id="gdcalert18" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image18.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert19">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image18.png "image_tooltip")


While it still seems a vanishingly small number by percentages, it has shown growth—more on desktop than mobile. It's important to keep in mind how big the HTTP Archive dataset is and how slowly it takes to gain numbers, even for a feature that is widely and natively supported. It will be interesting to continue to track these numbers and developments over more time. This author might be biased, as an editor for the Web Monetization standard, but you’re encouraged to [give it a try](https://webmonetization.org/docs/getting-started), it’s free.

There has been an [issue open for some time](https://github.com/WICG/webmonetization/issues/19), and the new version of the specification will [use a `&lt;link>` instead.](https://github.com/WICG/webmonetization/pull/193) Only 36 pages in our desktop set and 37 in our mobile set used the `&lt;link>` version, and all of those _also_ included the `&lt; meta>` version as well.


We know there are currently two [Interledger](https://interledger.org/)-enabled wallet providers in the ecosystem, we wanted to see the distribution and adoption of those wallets.



<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image19.png "image_tooltip")


Uphold and Gatehub are the current wallets, and it looks like Uphold is the dominant wallet by far. What is curious, a wallet that was deprecated this year, Stronghold, was more popular than an active wallet provider, Gatehub. We thought that speaks towards the rate at which web developers update their web sites.


## Conclusion

We’ve pointed out interesting, surprising and concerning bits of data throughout the chapter. Let us reflect once more on the state of markup in 2021.

The most surprising for us was that, [almost 20 years later](https://en.wikipedia.org/wiki/XHTML), XHTML was still used on a considerable part of the web, with a little over 7% of pages using it in 2021.

The median page sizes in 2020 were shrinking when compared to 2019, but this year it looks like the trend has regressed, surpassing the median sizes for 2019 as well. The web is getting heavier. Again.

Almost 1 percentage point more pages are compressed for mobile only. In a mobile world, where every byte of data has a cost associated with it, seeing that mobile pages are not only optimized, but smaller than the desktop counterparts is great. 

English is relatively less popular on mobile pages. We’re not sure why, and this author would like to encourage you to explore the possibilities of why this is the case.


It was interesting to see that libraries adopting better practices correlated directly with elements falling out of favor.  Both `i` and `option` are less-used this year because icon libraries have switched over to using SVG. 

It was both great to see ICO finally being dethroned as the most popular favicon format in favour of PNG. Similarly, seeing SVG more than doubling in usage for favicons in the past year made us think we’re 10 years away from dethroning PNG.

The doctype percentage has increased steadily by half a percentage point every year. At this rate, we’ll live in an ideal world where every page has a doctype by 2027.


It was concerning for this author to see that the adoption of  some of the newer standards is slow, sometimes on a 10 year cycle, and that web pages don’t get updated as often as we’d like.

_With that in mind, I’ll leave you to reflect on the state of the web in 2021. I’d also encourage you to be part of the people who increase adoption of new standards every year. Start with something new you’ve learned today, one of the many standards we’ve covered not only in this chapter but in this whole Almanac._
