---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Markup
description: Markup chapter of the 2021 Web Almanac covering the use of elements, attributes, document trends, as well as adoption rates of new standards.
authors: [AlexLakatos]
reviewers: [j9t, bkardell, shantsis, tunetheweb, rviscomi]
analysts: [kevinfarrugia]
editors: []
AlexLakatos_bio: Alex Lakatos has spent the past decade working on the Open Web within Browser, Communications, and FinTech organizations. With a background in web technologies and developer advocacy, he's helping the <a hreflang="en" href="https://interledger.org/">Interledger Foundation</a> build developer-friendly products while engaging with the developer community at large. You can [reach out to him on Twitter](https://twitter.com/avolakatos).
translators: []
results: https://docs.google.com/spreadsheets/d/1Ta5Ck7y3W6LCn2CeGtW7dAdLF6Lh5wV2UBQJZTz3W5Q/
featured_quote: Be part of the people who increase adoption of new standards every year. Start with something new you've learned today, one of the many standards we've covered not only in this chapter but in the whole Web Almanac.
featured_stat_1: 35.3%
featured_stat_label_1: ICO was finally dethroned as the most popular favicon format by PNG
featured_stat_2: 98%
featured_stat_label_2: Pages have at least one `<script>` element in HTML
featured_stat_3: 4,256
featured_stat_label_3: The most `<form>` elements found on a single page.
---

## Introduction

Have you ever wondered what happens when you try to visit a web site? After you enter the URL in the address bar of your browser, one of the first things that happens is that a HTML file is downloaded and parsed. You could say that markup is the foundation of the Web. We've dedicated this chapter to looking at some of the bricks that make the web stand today.

We've drawn on the data analyzed for the past three years to try to come up with a few questions around the future of markup, the trends emerging over the years, and the adoption rate of new standards. We've also shared the data in the hopes that you'll dig deeper into it, and interpret it in a way that we haven't.

_In the Markup chapter, we focus on HTML. While we briefly touch on other markup languages (like SVG or MathML) or other topics in the Web Almanac, those are covered in more detail in their own dedicated chapters. Because the markup is the gateway into the web, it was extremely hard not to dedicate a whole chapter to it._

## General

We'll start with some of the more general aspects of a markup document: things like document types, document sizes, document language, and compression.

### Doctypes

Ever wondered why all pages start with `<!DOCTYPE html>` or something similar, even in 2021? Doctypes are required because they tell the browsers not to switch into "[quirks mode](https://developer.mozilla.org/en-US/docs/Web/HTML/Quirks_Mode_and_Standards_Mode)" when rendering a page, and instead, they should make a best-effort attempt to follow the HTML spec.

This year, 97.4% of pages had a doctype, slightly up from last year's 96.8%. Looking at the past couple of years, the doctype percentage has increased steadily by half a percentage point every year.  In an ideal world, 100% of web pages would have a doctype—at this rate, we'll live in an ideal world by 2027!

In terms of popularity, HTML5, better known as `<!DOCTYPE html>` is still the most popular doctype, with 88.8% of mobile pages using it.

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTML ("HTML5")</td>
        <td class="numeric">87.0%</td>
        <td class="numeric">88.8%</td>
      </tr>
      <tr>
        <td>XHTML 1.0 Transitional</td>
        <td class="numeric">5.7%</td>
        <td class="numeric">4.6%</td>
      </tr>
      <tr>
        <td>XHTML 1.0 Strict</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>HTML 4.01 Transitional</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>HTML 4.01 Transitional (<a href="https://hsivonen.fi/doctype/#xml">quirky</a>)</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Most popular doctypes.",
    sheets_gid="269200864",
    sql_file="doctype.sql"
  ) }}</figcaption>
</figure>

The surprising part is that, <a hreflang="en" href="https://en.wikipedia.org/wiki/XHTML">almost 20 years later</a>, XHTML is still a considerable part of the web, with 8% of pages still using it on desktop and a little under 7% on mobile.

### Document size

In a mobile world, where every byte of data has a cost associated with it, document sizes for mobile websites are becoming increasingly more important. It is also increasingly bigger, by the looks of it. This year, the median mobile page had 27 KB of HTML, up 2 KB from last year. On the desktop side, the median page had 29 KB of HTML.

{{ figure_markup(
  image="page-size-by-year.png",
  caption="The median page size year-over-year.",
  description="Bar chart showing the evolution of median page sizes for mobile and desktop pages for the years 2019, 2020 and 2021. 2020 saw a slight decrease in size, and 2021 surpassed 2019 in size. The sizes gravitate around 27 Kilobytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=618740225&format=interactive",
  sheets_gid="742176410",
  sql_file="document_trends.sql"
) }}

The interesting points were:

* The median page sizes in 2020 were shrinking when compared to 2019. Looking at the figure above, we've had a slight increase this year, after the dip in 2020.
* The biggest HTML documents for both desktop and mobile have shed a whopping 20 MB each this year, with the biggest ones being 45 MB on desktop and 21 MB on mobile.

### Compression

With document sizes increasing, we also looked at compression this year. We felt the document size relates closely to the level of compression used when transferring it over the wire.

{{ figure_markup(
  image="content-encoding.png",
  caption="Adoption of content encoding schemes.",
  description="Bar chart showing the content encoding schemes used by mobile and desktop pages. 63.8% of pages use gzip, 21.9% use Brotli and 14.1% were uncompressed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1960175313&format=interactive",
  sheets_gid="75721024",
  sql_file="content_encoding.sql"
) }}

Out of the 6 million desktop pages scanned, an overwhelming 84.4% were compressed with either gzip (62.7%) or Brotli (21.7%) compression. For mobile pages, the numbers are very similar, 85.6% were compressed with either gzip (63.7%) or Brotli (21.9%) compression.

While the slight variation in percentages for mobile and desktop is not surprising, what is surprising is that almost one percentage point more pages are compressed for mobile only. In a [mobile world, where every byte of data has a cost associated with it](./mobile-web), seeing that mobile pages are not only optimized, but smaller than the desktop counterparts is great. You can learn more about the states of content encoding and the mobile web in the [Compression](./compression) and [Mobile Web](./mobile-web) chapters.

### Document language

We've encountered 3,598 unique instances of the `lang` attribute on the `html` element. Because there are <a hreflang="en" href="https://www.ethnologue.com/guides/how-many-languages">7,139 spoken languages</a> at the time of writing this chapter, it made us think not all of them were represented. When we factored in the [script and region subtags](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang#language_tag_syntax), even fewer remained.

{{ figure_markup(
  image="lang-region.png",
  caption="Adoption of the most popular HTML language codes, including region.",
  description="Bar chart showing the language usage, including region, for the top ten languages in our data set. 19% use english, 18.6% are not set, 13.5% use american english, with japanese, spanish, brazilian portuguese, british english, russian, german and french having various minor percentages of usage, from 5.3 to 1.5.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=742535028&format=interactive",
  sheets_gid="298704786",
  sql_file="html_lang.sql"
) }}

Out of the pages scanned, 19.6% on desktop, and 18.6% on mobile, [specified no `lang` attribute](./accessibility), even though the Web Content Accessibility Guidelines (<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/meaning-doc-lang-id.html">WCAG</a>) requires that a page language is defined and "programmatically accessible". Languages can be specified in different ways, including an `xml:lang` element, which we didn't check for, so there might still be hope for some of the pages scanned.

{{ figure_markup(
  image="lang.png",
  caption="Adoption of the most popular HTML language codes, not including region.",
  description="Bar chart showing the language usage, for the top ten languages in our data set. 35.5% use english, 18.7% are not set, with spanish, japanese, portuguese, russian, german, french, italian and polish having various minor percentages of usage, from 6.3 to 1.9.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=733528618&format=interactive",
  sheets_gid="298704786",
  sql_file="html_lang.sql"
) }}

While we looked at the top 10 normalized languages in the set, some interesting trends emerged:

* Mobile has a lower relative percentage of English websites. We're not sure why that is the case, we've been discussing the cause as a team. It's possible that some people only use mobile phones to access the web, so that would diversify the mobile set's language landscape. This author believes a lot of the mobile pages are intended to be used on the go and are hence local.
* While Spanish has a lot more region and subscript options than Japanese, it was a tight contest for the second most popular language.
* There is an inverse correlation between the difference in empty attributes for desktop and mobile and English.

### Comments

{{ figure_markup(
  caption="Pages with at least one comment in HTML.",
  content="88%",
  classes="big-number",
  sheets_gid="1557885695",
  sql_file="wpt_bodies.sql"
) }}

Most production build tools have an option to remove comments, but we've found a majority of the pages we've analyzed, 88%, had at least one comment.

While comments are generally encouraged in code, a particular type of comment, conditional comments, were used in web pages to render markup for particular browsers.

```html
<!--[if IE 8]>

  <p>This renders in Internet Explorer 8 only.</p>

<![endif]-->
```

Microsoft dropped support for conditional comments in IE 10. Still, 41% of the pages had at least one conditional comment present. Aside from the possibility that these are very old websites, we could only assume they are using some sort of variation of polyfilling framework for older browsers.

### SVG use

{{ figure_markup(
  caption="Pages with at least one SVG element in HTML.",
  content="46.4%",
  classes="big-number",
  sheets_gid="1117632433",
  sql_file="markup.sql"
) }}

This year, we wanted to take a look at SVG usage. With popular icon libraries using more and more SVG, favicon support improving, and SVG images being on the rise in animations, it's no surprise that 46.4% of web pages had some sort of SVG on them. 37.2% had a SVG element, 20.0% on desktop and 18.4% on mobile were using SVG images, and a negligible amount had either SVG embeds, objects, or iframes in them.

SVGs have more use cases when compared to the style element, but in terms of popularity, the numbers are comparable. SVG sits just outside the top 20 in terms of element popularity on a page.

## Elements

Elements are the DNA of a HTML document. We wanted to analyze the cells that make up the living organism that is a web page. What are the most popular, the most likely to be present, and the obsolete elements on most pages?

### Element diversity

There are <a hreflang="en" href="https://html.spec.whatwg.org/multipage/indices.html#elements-3">112 elements</a> currently defined and in use (excepting SVG and MathML), with another [28 being deprecated](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#obsolete_and_deprecated_elements) or obsolete. We wanted to see how many of them were actually used on a page, and how likely a web of `div`s was.

{{ figure_markup(
  image="element-diversity.png",
  caption="Distribution of the number of distinct types of elements per page.",
  description="Element types per percentile, with 90% of pages using at least 42 different elements.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1081218177&format=interactive",
  sheets_gid="920875734",
  sql_file="element_count_distribution.sql"
) }}

No need to panic, the web isn't all made up of divs. The median page uses 31 different elements and has a total of 666 elements.

{{ figure_markup(
  image="element-count.png",
  caption="Distribution of the number elements per page.",
  description="Elements per percentile, showing how 10% of all pages employ more than 1,727 elements.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=957921827&format=interactive",
  sheets_gid="920875734",
  sql_file="element_count_distribution.sql"
) }}

While the median page had 666 elements on desktop, and 616 on mobile, the top 10% of all pages had closer to triple that number, 1,727 for mobile and 1,902 for desktop.

### Top elements

Every year since 2019, the Markup chapter of the Web Almanac has featured the most frequently used elements in reference to <a hreflang="en" href="https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html">Ian Hickson's work in 2005</a>. This author couldn't break with tradition, so we had a look at the data again.

<figure>
  <table>
    <thead>
      <tr>
        <th>2005</th>
        <th>2019</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
      <tbody>
      <tr>
        <td>`title`</td>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
      </tr>
      <tr>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
      </tr>
      <tr>
        <td>`img`</td>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
      </tr>
      <tr>
        <td>`meta`</td>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
      </tr>
      <tr>
        <td>`br`</td>
        <td>`img`</td>
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`table`</td>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`td`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`tr`</td>
        <td>`option`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td>`i`</td>
        <td>`meta`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td>`option`</td>
        <td>`i`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>`ul`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>`option`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Evolution of the most frequently used elements per page.",
    sheets_gid="2049124461",
    sql_file="top_elements.sql"
  ) }}</figcaption>
</figure>

The top six elements haven't changed in the past three years, and it looks like the `link` element is gaining a foothold as a solid number seven.

It's interesting to see that `i` and `option` have both fallen out of favor. The first probably because libraries that misuse the `i` element for icons have fallen out of popularity in favor of libraries using SVGs for icons. The `meta` element is making a strong push into the top 10 this year, perhaps because social markup is also on the rise. We'll look at [social markup](#social-markup) in a later section of this chapter. The rise of styled `select` elements accounts for the `ul` (unordered list) element gaining popularity over the option element.

#### main

With the <a hreflang="en" href="https://wordpress.com/activity/posting/">creation of content spiking in 2021</a> (most likely because the world was stuck in a pandemic), we wanted to see if that correlates to an adoption of content elements as well. We thought `main` is a good indicator, it being an informative element that doesn't affect the DOM's concept of the structure of a page.

{{ figure_markup(
  caption="Percent of mobile pages with at least one `main` element.",
  content="27.9%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

27.7% of desktop pages and 27.9% of mobile pages had a `main` element. In terms of popularity, it made it well in the top 50 elements, at a respectable 34th place. Before you start thinking that there are only 114 elements, we've actually had more than a thousand elements come back from the queries we ran, most of which were custom.

#### base

Another curiosity was how much developers were paying attention to the stricter rules of the HTML spec. For example, the spec says there must be <a hreflang="en" href="https://html.spec.whatwg.org/multipage/semantics.html#the-base-element">no more than one `base` element</a> in a document, because the `base` element defines how user agents should resolve relative URLs. Having more than one `base` element introduces ambiguity, so the spec requires that all `base` elements after the first be ignored, rendering them useless.

From looking at the desktop pages, `base` is a popular element, with 10.4% of pages having one. But do they have only one? There are 5,908 more `base` elements than pages, so we can only conclude at least some pages have more than one `base` element. Who said developers were great at following directions? We would also recommend people validate their HTML using the W3C-provided <a hreflang="en" href="https://validator.w3.org/">Markup Validation Service</a>.

#### dialog

Throughout the chapter we wanted to also look at the adoption of some of the more controversial or new elements. `dialog` is one of them, with not all major browsers supporting it out of the box yet. Only 7,617 pages on desktop and 7,819 pages on mobile are using a dialog element. When we consider that's only around  0.1% of the pages analyzed, it doesn't look like the adoption is there yet.

#### canvas

The `canvas` element can be used with either the [Canvas API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API) or [WebGL API](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API) to draw graphics and animations. It's one of the main elements used for games or mixed reality on the web. It's no surprise 3.1% of the desktop pages and 2.6% of the mobile pages use it. The higher usage on desktop makes sense when you consider the graphic capabilities of the different devices, and the use cases skewed towards games and virtual reality.

### Probability of element use

While the `html`, `head`, `body`, `title`, and `meta` elements are all optional, they're the most common elements this year, all present on more than 99% of the pages.

<p class="note">Note that as we are looking at the rendered HTML, and the browsers will automatically add the `html` and `head` elements, this chart shows we have an error rate of 0.2% of pages in our crawl due to sites no longer being accessible at the time of the crawl.</p>

{{ figure_markup(
  image="element-popularity.png",
  caption="Adoption of the top HTML elements.",
  description="Bar chart showing the adoption of HTML elements. html, head, body, title and meta all show up on over 99% of websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=231602731&format=interactive",
  height=656,
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

While the percentages are slightly different when compared with last year, the order for the most popular elements remains the same. What about some of the more exotic elements?

<figure>
  <table>
    <thead>
      <tr>
        <th>Element</em></th>
        <th>Percent of pages (mobile)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`tt`</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>`ruby`</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>`rt`</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Adoption of `tt`, `ruby`, and `rt` elements on mobile pages.",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

It's interesting to see that `tt`, a deprecated element for [Teletype Text](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tt), is 100% more popular than `ruby` and `rt`, which are the [Ruby Annotation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ruby) and [Text](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/rt) elements still used for showing the pronunciation of East Asian characters.

### Script

{{ figure_markup(
  caption="Percent of mobile pages with at least one `script` element.",
  content="98.2%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

A little over 98% of the pages scanned contain at least one `script` element. It's no surprise that `script` is also the 6th most popular element on a page. Compared with last year, the script element seems to remain constant in terms of popularity and has slightly increased levels of occurrence in the millions of pages analyzed, from 97% to 98%.

{{ figure_markup(
  caption="Percent of mobile pages with at least one `noscript` element.",
  content="51.4%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

51.4% of pages also contain a `noscript` element, which is generally used to display a message for browsers that have disabled JavaScript. Another popular use for the `noscript` element is the Google Tag Manager (GTM) snippet. 18.8% of pages on desktop and 16.9% of pages on mobile are using the `noscript` element as part of the GTM snippet. It's interesting to note that GTM is more popular on desktop than mobile.

### Template

One of the <a hreflang="en" href="https://css-tricks.com/crafting-reusable-html-templates/">least recognized, but most powerful features</a> of the Web Components specification is the `template` element. Despite the fact that the [`template` element](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots) is well supported on modern browsers since 2013, only 0.5% of the pages were using it in 2021. In terms of popularity, it didn't even make it into the top 50 elements. We thought this speaks volumes about the adoption curve of the modern HTML specification for web developers.

In case you don't really know what `template` does, here is a refresher from the specification: "the `template` element is used to declare fragments of HTML that can be cloned and inserted in the document by script". If you're a web developer and think that sounds familiar, you're right. Most of the popular frameworks today have a similar non-native mechanism to do the same: Angular has <a hreflang="en" href="https://angular.io/guide/content-projection">`ng-content`</a>, React has <a hreflang="en" href="https://reactjs.org/docs/portals.html">portals</a> and Vue has <a hreflang="en" href="https://v3.vuejs.org/guide/component-slots.html#slots">`slot`</a>. We would have thought those frameworks would use the native `template` element or Web Components instead of re-creating the functionality within the frameworks.

### Style

{{ figure_markup(
  caption="Percent of mobile pages with at least one `style` element.",
  content="83.8%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

When creating a web page, three things come together. One is HTML, and we're looking at that throughout this chapter. The second one is JavaScript, and we saw in the [previous section](#script) that the `script` element used to load JavaScript is one of the most popular ones. It doesn't come as a shock that the `style` element, used to inline CSS is similarly popular. 83.8% of the mobile pages scanned had at least one `style` element.

In terms of sheer popularity on a page, it barely made it into the top 20, with 0.7%. That leaves us to believe that while multiple `script` elements are popular on a page, most have five times fewer `style` elements on them. And that makes sense. Because `script` elements can be used for both inline and external scripts, but CSS uses a separate element, the `link` element, for loading external stylesheets. The `link` element is present on slightly more pages than the `script` element, while being slightly less popular in terms of the number of occurrences.

### Custom elements

We've also looked at elements that didn't show up in the HTML or SVG spec, be it current or obsolete, to determine what custom elements were out there in the wild.

<figure>
  <table>
    <thead>
      <tr>
        <th>Element</th>
        <th>Number of pages</th>
        <th>Percent of pages</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`rs-module-wrap`</td>
         <td class="numeric">123,189</td>
         <td class="numeric">2.0%</td>
      </tr>
      <tr>
         <td>`wix-image`</td>
         <td class="numeric">76,138</td>
         <td class="numeric">1.2%</td>
      </tr>
      <tr>
         <td>`pages-css`</td>
         <td class="numeric">75,539</td>
         <td class="numeric">1.2%</td>
      </tr>
      <tr>
         <td>`router-outlet`</td>
         <td class="numeric">35,851</td>
         <td class="numeric">0.6%</td>
      </tr>
      <tr>
         <td>`next-route-announcer`</td>
         <td class="numeric">9,002</td>
         <td class="numeric">0.1%</td>
      </tr>
      <tr>
         <td>`app-header`</td>
         <td class="numeric">7,844</td>
         <td class="numeric">0.1%</td>
      </tr>
      <tr>
         <td>`ng-component`</td>
         <td class="numeric">3,714</td>
         <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Adoption of select custom elements on desktop pages.",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

By far, the most popular one is <a hreflang="en" href="https://www.sliderrevolution.com/faq/developer-guide-output-class-tag-changes/">Slider Revolution</a>, with a majority of elements attributed to the framework. It more than tripled in popularity over the past year, which leads us to believe it might be a part of a popular template or site builder. A close second is <a hreflang="en" href="https://www.wix.com/">Wix</a>, the popular free site builder. We couldn't identify `pages-css`, but we'd love to hear any ideas for why the `pages-css` element is so popular, so let us know by [suggesting an edit](#explore-results) on GitHub.

We would have thought that popular frameworks like <a hreflang="en" href="https://angular.io/">Angular</a>, <a hreflang="en" href="https://nextjs.org/">Next.js</a>, or the former <a hreflang="en" href="https://angularjs.org/">Angular.js</a> would account for more custom components, but `router-outlet` and `ng-component` make up a small part of the custom component base.

### Obsolete elements

There are currently [28 obsolete and deprecated elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#obsolete_and_deprecated_elements) described in the HTML reference. We wanted to see how many of those were still in use today. By far, the most used ones are `center` and `font`, and we're glad to see their usage has slightly declined when compared with last year.

`nobr` and `big` on the other hand, while still being deprecated, have increased in usage slightly when compared with last year.

{{ figure_markup(
  image="obsolete-elements.png",
  caption="Adoption of the top obsolete HTML elements.",
  description="Bar chart showing the usage of obsolete HTML elements. center and font are the most popular, with 6.6% and 5.9% of pages using them. marquee, nobr and big have negligible usage, under 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=369760501&format=interactive",
  sheets_gid="1958462994",
  sql_file="top_obsolete_elements.sql"
) }}

While the percentage of obsolete elements for mobile pages is slightly different when compared with desktop, the order remains the same.

{{ figure_markup(
  image="relative-obsolete-elements.png",
  caption="Relative adoption of the top obsolete HTML elements.",
  description="Pie chart showing the relative usage of obsolete HTML elements. center and font are the most popular, with 43.2% and 38.2% of the pie.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=237093362&format=interactive",
  sheets_gid="1958462994",
  sql_file="top_obsolete_elements.sql"
) }}

Google still uses a `center` element on their homepage in 2021, but we're not going to judge.

### Proprietary and non-standard elements

While custom elements all have a hyphen in them, we've also encountered elements that are made up, don't have a hyphen, and don't show up on the <a hreflang="en" href="https://html.spec.whatwg.org/#toc-semantics">HTML standard</a>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Element</th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`jdiv`</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`noindex`</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`mediaelementwrapper`</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>`ymaps`</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`h7`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>`h8`</td>
        <td class="numeric">&lt;0.1%</td>
        <td class="numeric">&lt;0.1%</td>
      </tr>
      <tr>
        <td>`h9`</td>
        <td class="numeric">&lt;0.1%</td>
        <td class="numeric">&lt;0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Adoption of non-standard elements.",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

All of them were present last year as well, and can be attributed to popular frameworks or products like JivoChat, Yandex, MediaElement.js, and Yandex Maps. And because some people get carried away, or six is just not enough headers, `h7` to `h9`.

### Embedded content

<figure>
  <table>
    <thead>
      <tr>
        <th>Element</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`iframe`</td>
        <td class="numeric">56.7%</td>
        <td class="numeric">54.5%</td>
      </tr>
      <tr>
        <td>`source`</td>
        <td class="numeric">9.9%</td>
        <td class="numeric">8.4%</td>
      </tr>
      <tr>
        <td>`picture`</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">6.0%
       </td>
      </tr>
      <tr>
        <td>`object`</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`param`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>`embed`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Adoption of elements for embedding content.",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

Content can be embedded through multiple elements in a page. The most popular is an `iframe`, followed at a considerable distance by `source` and `picture`.

The actual `embed` element is the least popular out of all the present elements for embedding content.

### Forms

Forms, or ways of getting input from your visitors,  are part of the fabric of the web. It's no surprise that 71.3% of pages on desktop and 67.5% of pages on mobile had at least one `form` on them. The most common occurrence was one (33.0% on desktop and 31.6% on mobile) or two (17.9% on desktop and 16.8% on mobile) `form` elements on a page.

{{ figure_markup(
  caption="The most `form` elements found on a single page.",
  content="4,256",
  classes="big-number",
  sheets_gid="1723929411",
  sql_file="forms.sql"
) }}

There are also extreme cases with one page having 4,018 `form` elements on desktop and 4,256 `form` elements on mobile. We can't help but wonder what kind of input is so valuable, that you'd have to break it up in 4,000 pieces.

## Attributes

Element behaviors are heavily influenced by attributes, so we thought it was only fair we took a look at the attributes used on a page, explore `data-*` patterns, and some popular social attributes for `meta` elements.

### Top attributes

{{ figure_markup(
  image="attribute-popularity.png",
  caption="The most popular HTML attributes.",
  description="Bar chart showing top 10 attributes by frequency of use. class is the most popular by far, at 34.3%, followed by href at 9.9%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1580508221&format=interactive",
  height=558,
  sheets_gid="1328339120",
  sql_file="attributes.sql"
) }}

The most popular attribute is `class` and that's no surprise, given that it's used for styling. 34.3% of all the attributes found on the pages we queried were `class`. By contrast, `id` was much less used, at 5.2%. It's interesting to note that the `style` attribute edged out the `id` attribute in popularity, accounting for 5.6% of occurrences.

The second most popular attribute is `href`, with 9.9% of occurrences. With links being part of the fabric of the web, it's not surprising an anchor element attribute was this popular. What was surprising is that the `src` attribute was only twice as popular as the `alt` attribute, despite it being [available to considerably more elements.](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes)

#### Meta flavors

`meta` elements are gaining some of their lost popularity this year, so we wanted to take a closer look at them. They provide a way to add machine-readable information to your pages, as well as perform some nifty HTTP equivalents. For example, setting a content security policy for a page:

```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*;">
```

From the available attributes, `name` (paired with `content`) was the most popular. 14.2% of the `meta` elements did not have a `name` attribute. In conjunction with the `content` attribute, they are used as a key-value pair for passing in information. What information, you ask?

{{ figure_markup(
  image="meta-names.png",
  caption="The most popular `meta` node names.",
  description="Bar chart showing top 10 most popular name attributes for meta elements by frequency of use. 16.3% meta elements don't have a name, and viewport is the only one above 3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1705395065&format=interactive",
  height=604,
  sheets_gid="1907270745",
  sql_file="meta_nodes_name.sql"
) }}

{{ figure_markup(
  caption="Percent of `meta` viewports having a value of `initial-scale=1,width=device-width`.",
  content="45.0%",
  classes="big-number",
  sheets_gid="1885501317",
  sql_file="meta_viewport.sql"
) }}

The most popular is viewport information, with the most popular `viewport` value being `initial-scale=1,width=device-width`. 45.0% of mobile pages scanned used that value.

The second most popular combination are `og:*` meta elements, also known as <a hreflang="en" href="https://ogp.me/">Open Graph</a> meta elements. We'll talk about those in the next section.

#### Social markup
Providing information and assets for social platforms to use when previewing links to your page  is a popular use case for the `meta` element.

{{ figure_markup(
  image="social-meta-names.png",
  caption="The most popular social `meta` node names.",
  description="Bar chart showing top 10 most popular name attributes for social media related meta elements by frequency of use. Open Graph meta elements are more popular than Twitter meta elements.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1723706431&format=interactive",
  height=604,
  sheets_gid="1907270745",
  sql_file="meta_nodes_name.sql"
) }}

The most common by far are the Open Graph `meta` elements, used across multiple networks, with Twitter-specific elements lagging behind. `og:title`, `og:type`, `og:image`, and `og:url` are all required for every page, so it's interesting that there is a variation in their usage numbers.

### `data-` attributes

The <a hreflang="en" href="https://html.spec.whatwg.org/#embedding-custom-non-visible-data-with-the-data-*-attributes">HTML specification allows</a> for custom attributes, prefixed by `data-`. They are intended to store custom data, state, annotations, and the like, private to the page or application, for which there are no more appropriate attributes or elements.

{{ figure_markup(
  image="data-attributes.png",
  caption="The most popular `data-` attributes.",
  description="Bar chart showing top 10 most popular data attributes for elements by frequency of use. The generic data-id and data-src are the most popular ones.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1104552143&format=interactive",
  height=599,
  sheets_gid="319139425",
  sql_file="data_attributes.sql"
) }}

The most common ones, `data-id`, `data-src`, and `data-type` are non-specific, with `data-src`,  `data-srcset`, and `data-sizes` being very popular with image lazy-loading libraries. `data-element_type` and  `data-widget_type` are coming from a popular website builder, <a hreflang="en" href="https://code.elementor.com/">Elementor</a>.

<a hreflang="en" href="https://github.com/kenwheeler/slick">Slick, "the last carousel you'll ever need"</a>, is responsible for `data-slick-index`. Popular frameworks like Bootstrap are responsible for `data-toggle`, while <a hreflang="en" href="https://testing-library.com/docs/queries/bytestid/">testing-library</a> is responsible for `data-testid`.

## Miscellaneous

We've covered a good chunk of the most common HTML use cases. We've set aside this section at the end to look into some of the more esoteric use cases, as well as adoption of new standards on the web.

### `viewport` specifications

The `viewport` `meta` element is used to control layout on mobile devices. Or at least that was the idea when it came out. Today, <a hreflang="en" href="https://www.quirksmode.org/blog/archives/2020/12/userscalableno.html">some browsers</a> have started to ignore some of the `viewport` options to allow for zooming a page <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large">up to 500%</a>.

<figure>
<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Desktop</th>
      <th>Mobile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`initial-scale=1,width=device-width`</td>
      <td class="numeric">46.6%</td>
      <td class="numeric">45.0%</td>
    </tr>
    <tr>
      <td>(empty)</td>
      <td class="numeric">12.8%</td>
      <td class="numeric">8.2%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,width=device-width`</td>
      <td class="numeric">5.3%</td>
      <td class="numeric">5.6%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width`</td>
      <td class="numeric">4.6%</td>
      <td class="numeric">5.4%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width`</td>
      <td class="numeric">4.0%</td>
      <td class="numeric">4.3%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,shrink-to-fit=no,width=device-width`</td>
      <td class="numeric">3.9%</td>
      <td class="numeric">3.8%</td>
    </tr>
    <tr>
      <td>`width=device-width`</td>
      <td class="numeric">3.3%</td>
      <td class="numeric">3.5%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no,width=device-width`</td>
      <td class="numeric">1.9%</td>
      <td class="numeric">2.5%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,user-scalable=no,width=device-width`</td>
      <td class="numeric">1.89%</td>
      <td class="numeric">1.9%</td>
    </tr>
  </tbody>
</table>
  <figcaption>{{ figure_link(
    caption="Adoption of the most popular `meta` viewport values.",
    sheets_gid="1885501317",
    sql_file="meta_viewport.sql"
  ) }}</figcaption>
</figure>

The most common `viewport` content option is `initial-scale=1,width=device-width`, which is not surprising when it's the recommended option on the [MDN guide](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag) explaining viewports. 45.0% of the pages analyzed are using it, almost 3% more than [last year](../2020/markup#viewport-specifications). 8.2% of pages had an empty `content` attribute, slightly more than last year as well. That correlates with a decrease in usage for improper combinations of viewport options.

### Favicons

Favicons are one of the most resilient pieces of the web. They work even without markup and accept multiple image formats. There are also literally dozens of sizes you need to use to be thorough.

{{ figure_markup(
  image="favicons.png",
  caption="The most popular favicon formats.",
  description="Bar chart showing top 10 most popular formats for favicons by frequency of use. The PNG format has surpassed the ICO format for the first time, with favicons without a format specified being a close third.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1768688487&format=interactive",
  height=583,
  sheets_gid="29842244",
  sql_file="favicons.sql"
) }}

There were a few surprises when we looked at the data:

* ICO was finally dethroned as the most popular format by PNG.
* JPG is still used, even though it's not the best option when compared with some of the other unpopular options.
* With SVG support for favicons finally improving, SVG has overtaken WebP [this year](#favicons) in terms of popularity.

### Button and input types

{{ figure_markup(
  caption="Percent of mobile pages with at least one `button` element.",
  content="65.5%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

Buttons are controversial. There are a lot of opinions about what does and what doesn't constitute a button on the web. While we're not taking sides, we thought we should look at some of the semantic ways to specify a `button` element, seeing as how 65.5% of pages already had a `button` element on them.

{{ figure_markup(
  image="buttons.png",
  caption="The most popular button types.",
  description="Bar chart showing top 5 most popular button types by frequency of use. The most popular ones are type button, no type and type submit.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=351242151&format=interactive",
  sheets_gid="1847095902",
  sql_file="buttons.sql"
) }}

When we compared the data to [last year](../2020/markup#button-and-input-types), we noticed a lot more pages had `button` elements on them. This year we didn't run a query for `input`-typed buttons, but we've seen a definite decrease in usage for the number of `button` elements on pages. The [Accessibility chapter](./accessibility) also has a whole section on buttons, you should read that as well!

### Links

<figure>
<table>
  <thead>
    <tr>
     <th>Link</th>
     <th>Desktop</th>
     <th>Mobile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Always uses `target="_blank"` with `noopener` and `noreferrer`</td>
      <td class="numeric">22.0%</td>
      <td class="numeric">23.2%</td>
    </tr>
    <tr>
      <td>Sometimes uses `target="_blank"` with `noopener` and `noreferrer`</td>
      <td class="numeric">78.0%</td>
      <td class="numeric">76.8%</td>
    </tr>
    <tr>
      <td>Has `target="_blank"`</td>
      <td class="numeric">81.2%</td>
      <td class="numeric">79.9%</td>
    </tr>
    <tr>
      <td>Has `target="_blank"` with `noopener` and `noreferrer`</td>
      <td class="numeric">14.3%</td>
      <td class="numeric">13.2%</td>
    </tr>
    <tr>
      <td>Has `target="_blank"` with `noopener`</td>
      <td class="numeric">21.2%</td>
      <td class="numeric">20.1%</td>
    </tr>
    <tr>
      <td>Has `target="_blank"` with `noreferrer`</td>
      <td class="numeric">1.2%</td>
      <td class="numeric">1.1%</td>
    </tr>
    <tr>
      <td>Has `target="_blank"` without `noopener` and `noreferrer`</td>
      <td class="numeric">71.1%</td>
      <td class="numeric">69.9%</td>
    </tr>
  </tbody>
</table>
  <figcaption>{{ figure_link(
    caption="Adoption of various combinations of link attributes.",
    sheets_gid="1557885695",
    sql_file="wpt_bodies.sql"
  ) }}</figcaption>
</figure>

Links are the glue that ties the web together. Normally, we wanted to look at the instances where they are proving problematic. Using `target="_blank"` without `noopener` and `noreferrer` was a security vulnerability for the longest time, but 71.1% of desktop pages and 68.9% of mobile pages still use it today.

That's what probably prompted a <a hreflang="en" href="https://github.com/whatwg/html/issues/4078">spec change</a> this year, so now browsers set `rel="noopener"` by default on all `target="_blank"` links.

### Web Monetization

<a hreflang="en" href="https://discourse.wicg.io/t/proposal-web-monetization-a-new-revenue-model-for-the-web/3785">Web Monetization</a> is being proposed as a W3C standard at the Web Platform Incubator Community Group (WICG). It's a young standard that provides an open, native, efficient, and automatic way to compensate creators, pay for API calls, and support crucial web infrastructure. While it is in its early days, and it is not implemented by any of the major browsers, it is supported via forks and extensions, and has been instrumented in Chromium and the HTTP Archive dataset for over a year. We wanted to take a look at adoption so far.

{{ figure_markup(
  caption="Number of mobile pages that use Web Monetization.",
  content="1,067",
  classes="big-number",
  sheets_gid="2034956621",
  sql_file="monetization.sql"
) }}

Web Monetization popularly uses a `meta` element on the page, specifying the wallet address for the money to be paid into. It looks a little bit like:

```html
<meta name="monetization" content="$wallet.example.com/alice">
```

{{ figure_markup(
  link="https://www.chromestatus.com/metrics/feature/timeline/popularity/3119",
  image="meta-monetization.png",
  caption='Adoption of Web Monetization over time. (Source: <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/3119\">Chrome Status</a>)',
  description="Bar graph showing the increase in adoption of Web Monetization, currently around 0.02% of URLs.",
  width=600,
  height=278
) }}

While it still seems a vanishingly small number by percentages, it has shown growth—more on desktop than mobile. It's important to keep in mind how big the HTTP Archive dataset is and how slowly it takes to gain numbers, even for a feature that is widely and natively supported. It will be interesting to continue to track these numbers and developments over more time. This author might be biased, as an editor for the Web Monetization standard, but you're encouraged to <a hreflang="en" href="https://webmonetization.org/docs/getting-started">give it a try</a>, it's free.

There has been an <a hreflang="en" href="https://github.com/WICG/webmonetization/issues/19">issue open for some time</a>, and the new version of the specification will <a hreflang="en" href="https://github.com/WICG/webmonetization/pull/193">use a `link` instead.</a> Only 36 pages in our desktop set and 37 in our mobile set used the `link` version, and all of those _also_ included the `meta` version as well.

We know there are currently two <a hreflang="en" href="https://interledger.org/">Interledger</a>-enabled wallet providers in the ecosystem, so we wanted to see the distribution and adoption of those wallets.

{{ figure_markup(
  image="monetization-by-host.png",
  caption="The most popular Web Monetization hosts.",
  description="Bar chart showing top 5 most popular wallet providers for payment pointers on web monetized pages. Uphold is by far the most popular one, with 86.3% of hosts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=659719076&format=interactive",
  sheets_gid="688333206",
  sql_file="monetization_by_host.sql"
) }}

Uphold and Gatehub are the current wallets, and it looks like Uphold is the dominant wallet by far. What is curious, a wallet that was deprecated this year, Stronghold, was more popular than an active wallet provider, Gatehub. We thought that speaks towards the rate at which web developers update their web sites.

## Conclusion

We've pointed out interesting, surprising, and concerning bits of data throughout the chapter. Let us reflect once more on the state of markup in 2021.

The most surprising for us was that, <a hreflang="en" href="https://en.wikipedia.org/wiki/XHTML">almost 20 years later</a>, XHTML was still used on a considerable part of the web, with a little over 7% of pages using it in 2021.

The median page sizes in 2020 were shrinking when compared to 2019, but this year it looks like the trend has regressed, surpassing the median sizes for 2019 as well. The web is getting heavier. Again.

Almost one percentage point more pages are compressed for mobile only. In a mobile world, where every byte of data has a cost associated with it, seeing that mobile pages are not only optimized, but smaller than the desktop counterparts is great.

English is relatively less popular on mobile pages. We're not sure why, and this author would like to encourage you to explore the possibilities of why this is the case.

It was interesting to see that libraries adopting better practices correlated directly with elements falling out of favor.  Both `i` and `option` are less-used this year because icon libraries have switched over to using SVG.

It was great to see ICO finally being dethroned as the most popular favicon format in favor of PNG. Similarly, seeing SVG more than doubling in usage for favicons in the past year made us think we're 10 years away from dethroning PNG.

The doctype percentage has increased steadily by half a percentage point every year. At this rate, we'll live in an ideal world where every page has a doctype by 2027.

It was concerning for this author to see that the adoption of  some of the newer standards is slow, sometimes on a 10-year cycle, and that web pages don't get updated as often as we'd like.

_With that in mind, I'll leave you to reflect on the state of the web in 2021. I'd also encourage you to be part of the people who increase adoption of new standards every year. Start with something new you've learned today, one of the many standards we've covered not only in this chapter but in this whole Web Almanac publication._
