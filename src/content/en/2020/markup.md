---
part_number: I
chapter_number: 3
title: Markup
description: Markup chapter of the 2020 Web Almanac covering general observations, the use of elements and attributes, as well as trivia and trends.
authors: [j9t, catalinred, iandevlin]
reviewers: [zcorpan, matuzo, bkardell]
analysts: [tiggerito]
translators: []
discuss: @@
results: https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/
queries: 03_Markup
published: 2020-11-01T00:00:00.000Z
last_updated: 2020-11-01T00:00:00.000Z
---

## Introduction

The Web is built on HTML. Without HTML: no web pages, no web sites, no web apps. Nothing. Plain-text documents, perhaps, or XML trees, in some parallel universe that enjoyed that particular kind of challenge. In this universe, HTML is the foundation of the user-facing Web. There are many standards that the Web is resting on, but HTML is certainly one of the most important ones.

How do we use HTML, then, how great of a foundation are we looking at (and in this Markup chapter, we’re focusing almost exclusively on HTML)? The introduction of [last year’s markup chapter](../2019/markup#introduction) suggested that for a long time, we haven’t really known: There were some smaller samples, there was Ian Hickson’s, one of modern HTML’s parents, research [back in 2005](https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html), then there were more small samples, but until last year we lacked major insight into how we as developers, as authors, make use of HTML. In 2019 we then had both [Catalin Rosu’s work](https://www.advancedwebranking.com/html/) (one of this chapter’s co-authors) as well as the 2019 edition of the Web Almanac to give a better view again, at HTML in practice.

Last year marked a first stab at 5,790,700 pages (of which 4,371,973 were tested on desktop, 5,297,442 on mobile) and a review of the data taken. This year we looked at 7,546,709 pages (5,593,642 on desktop, 6,347,919 on mobile) using the latest data on [which websites users are visiting in 2020](./methodology), to run another analysis. We do make some comparisons to last year—but, just as we’ve tried to take some additional metrics for additional insight, we’ve also given this chapter a new personality.

<p class="note">The data for all Almanac chapters is open and available. Take a look at [the results](@@) and share your own observations!</p>

## General

In this section we’re having a look at higher-level aspects of HTML, like document types, the size of documents, as well as the use of comments and scripts. “Living HTML” is very much alive!

### Doctypes

96.99% of the sampled pages use a doctype. That is useful, because, for historic reasons (“[to avoid triggering quirks mode](https://lists.w3.org/Archives/Public/public-html-comments/2009Jul/0020.html) in browsers”) HTML documents need to declare a document type.

What are the most popular ones

| Doctype | Pages | Percentage |
|---|---|---|
| HTML (“HTML5”) | 5,441,815 | 85.73% |
| XHTML 1.0 Transitional | 382,322 | 6.02% |
| XHTML 1.0 Strict | 107,351 | 1.69% |
| HTML 4.01 Transitional | 54,379 | 0.86% |
| HTML 4.01 Transitional ([quirky](https://hsivonen.fi/doctype/#xml)) | 38,504 | 0.61% |

You can already tell how after XHTML 1.0, the numbers decrease quite a bit, and we soon enter the long tail with a few standard, some esoteric, and also bogus doctypes.

What stands out are two things:

1. Almost 10 years after [the announcement of living HTML](https://blog.whatwg.org/html-is-the-new-html5) (aka “HTML5”), living HTML has clearly become not only mainstream, but the norm.
2. That it had not always been like that is exemplified by the next most popular doctypes, those of XHTML 1.0. XHTML, though likely delivered as HTML (with a MIME type of `text/html`), is not dead yet.

### Document size

In the analysis we also had a look at document size, that is, HTML bytes transferred over the network. In the set of 6.3 million documents:

* 1,110 documents are empty (0 bytes).
* The average document size is 50.35 KB ([in most cases compressed](https://w3techs.com/technologies/details/ce-gzipcompression)).
* The (by far) largest document weighs 64.16 _MB_, almost deserving its own analysis and chapter in the Almanac.

How is this situation in general, then? The median document weighs 25.24 KB:

{{ figure_markup(
  image="document-size.png",
  caption="Document size",
  description="@@",
  width=600,
  height=371
  )
}}

### Document language

We identified 2,863 different values for the `lang` attribute on the `html` start tag (compare that to the [7,117 spoken languages](https://www.ethnologue.com/guides/how-many-languages) as per Ethnologue). Almost all of them, [according to the Accessibility chapter](./accessibility), seem valid.

22.36% of all documents specify no `lang` attribute. The commonly accepted view is that [they should](https://www.w3.org/TR/i18n-html-tech-lang/#overall)—but beside the idea that software could eventually [detect language automatically](https://meiert.com/en/blog/lang/), document language can also be specified [on the protocol level](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language). This is something we didn’t check.

Here’s the Top 10 of (normalized) languages in our sample. At first we contemplated merging same-language values, but as the difference between `en-US` and `en-GB`, to give just one example, is pronounced, we decided not to do so.

| Language | Percentage |
|---|---|
| `en` | 18.08% |
| `en-us` | 13.27% |
| `ja` | 5.47% |
| `es` | 4.09% |
| `pt-br` | 2.84% |
| `ru` | 2.53% |
| `en-gb` | 2.19% |
| `de` | 1.92% |
| `de-de` | 1.60% |
| `ru-ru` | 1.60% |

### Comments

Adding comments to code is a good practice and HTML comments are there to add notes to HTML documents, without having them rendered by user agents.

```html
<!-- This is a comment in HTML -->
```

Although many pages will have been stripped of comments for production, we found that index pages in the 90th percentile are using about 73 comments on mobile, respectively 79 comments on desktop, while in the 10th percentile the number of the comments is about 2.

According to stats we’ve gathered, around 89% of the both mobile and desktop pages contain at least one HTML comment, while about 46% of them contain a conditional comment, too.

#### Conditional comments

```html
<!--[if IE 8]>
  <p>This renders in Internet Explorer 8 only.</p>
<![endif]-->
```

The above is a non-standard HTML conditional comment. While those have proved to be helpful in the past in order to tackle browser differences, they are history for some time as Microsoft [dropped conditional comments](https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/compatibility/hh801214(v=vs.85)) in Internet Explorer 10.

Still, on the above percentile extremes, we found that web pages are using about 6 conditional comments in the 90th percentile, and 1 comment while in the 10th percentile.  Most of the pages include them for helpers such as html5shiv, selectivizr, and respond.js. While being decentish and still active pages, our conclusion is that many of them were using obsolete CMS themes.

For production, HTML comments are usually stripped by build tools. Considering all the above counts and percentages—and referring to the use of comments in general—, we can only guess that lots of pages are served without involving an HTML minifier.

### Script use 

As the top elements will show, the `script` is the 6th most frequently used HTML element. From the standpoint of the Markup chapter, we were interested in the ways the `script` element is used across these millions of pages from the data set.

Overall, around 2% (1.96% on desktop and 2.04% on mobile) of the pages we analyzed contain no scripting at all, not even scripts with the `type` attribute set to `application/ld+json`. Considering that nowadays it’s pretty common for a page to include at least one script for an analytics solution, this seems noteworthy.

At the opposite end of the spectrum, the numbers show that more than 97% of pages (97.65% on desktop and 97.63% on mobile) contain at least one script, either inline or external.

{{ figure_markup(
  image="script-use.png",
  caption="Script use",
  description="@@",
  width=600,
  height=371
  )
}}

When scripting is unsupported or turned off in the browser, the `noscript` element helps to add an HTML section within a page. Considering the above script numbers, we were curious about the `noscript` element as well. 

Following the analysis, we found that about 49% of both mobile and desktop index pages are using a `noscript` element. At the same time, 15.78% of `noscript` elements on mobile, and 17.43% of `noscript` elements on desktop were containing an `iframe` with a `src` value referring to “googletagmanager.com.”

This seems to confirm the theory that the total number of `noscript`s in the wild may be affected by common scripts like Google Tag Manager which enforce users to add a `noscript` snippet after the `<body>` start tag on a page.

<div class="note">

What `type` attribute values are used with `script` elements? `text/javascript` (60.03%), `application/ld+json` (1.68%), `application/json` (0.41%), `text/template` (0.41%), and `text/html` (!) (0.27%).

When it comes to loading JavaScript module scripts using `type="module"`, we found 0.13% of scripts to specify `type="module"` at the moment, with only 0.95% of them using the corresponding `nomodule` attribute.

No value has been set on 36.38% of all scripts.

</div>

## Elements

In this section, the focus is on elements: What elements are used, how frequently, which elements are likely to appear on a given page, and how the situation is with respect to custom, obsolete, and proprietary elements. Is “divitis” still a thing? Yes.

### Element diversity

Let’s have a look at how diverse use of HTML actually is: Do authors use many different elements, or are we looking at a landscape that makes use of relatively few elements?

The median web page, it turns out, uses 30 different elements, 587 times:

{{ figure_markup(
  image="element-diversity-element-types.png",
  caption="Element diversity: element types",
  description="@@",
  width=600,
  height=371
  )
}}

{{ figure_markup(
  image="element-diversity.png",
  caption="Element diversity",
  description="@@",
  width=600,
  height=371
  )
}}

Given that [living HTML](https://html.spec.whatwg.org/multipage/) currently has 112 elements, the 90th percentile not using more than 41 elements may suggest that HTML is not nearly being exhausted by most documents. Yet it’s hard to interpret what this really means for HTML and our use of it, as the semantic wealth that HTML offers doesn’t mean that every document would need all of it: HTML elements should be used per purpose (semantics), not per availability.

How are these elements distributed?

{{ figure_markup(
  image="distribution-of-elements-per-page.png",
  caption="Distribution of elements per page",
  description="@@",
  width=600,
  height=371
  )
}}

Not that much changed [compared to 2019](../2019/markup#fig-3)!

### Top elements

Last year, the Almanac featured the most frequently used elements in reference to [Ian Hickson’s work in 2005](https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html). We found this useful and had a look at that data again:

| 2005 | 2019 | 2020 |
|---|---|---|
| `title` | `div` | `div` |
| `a` | `a` | `a` |
| `img` | `span` | `span` |
| `meta` | `li` | `li` |
| `br` | `img` | `img` |
| `table` | `script` | `script` |
| `td` | `p` | `p` |
| `tr` | `option` | `link` |
| | | `i` |
| | | `option`|

Nothing changed in the Top 7, but the `option` element went a little out of favor and dropped from 8 to 10, letting both the `link` and the `i` element pass in popularity. These elements have risen in use, possibly due to an increase in use of [resource hints](https://www.w3.org/TR/resource-hints/) (as with prerendering and prefetching), as well icon solutions like [Font Awesome](https://fontawesome.com/) (which _de facto_ misuses `i` elements for the purpose of displaying icons).

<div class="note">

#### `details` and `summary`

One thing we were curious about, too, was use of [the `details` and `summary` elements](https://html.spec.whatwg.org/multipage/rendering.html#the-details-and-summary-elements), especially since 2020 [brought broad support](https://caniuse.com/details). Are they being used? Are they attractive for, even popular among authors? As it turns out, only 0.39% of all tested pages are using them—although it’s hard to gauge whether they were all used the correct way in exactly the situations when you need them, “popular” is the wrong word.

Here’s a simple example showing the use of `summary` in a `details` element:

```html
<details>
  <summary>Status: Operational</summary>
  <p>Velocity: 12m/s</p>
  <p>Direction: North</p>
</details>
```

A while ago, [Steve Faulkner pointed out](https://twitter.com/stevefaulkner/status/806474286592561152) how these two elements were used poorly in the wild. As you can tell from above, for each `details` element you’d need a `summary` element that may only be used as the [first child of `details`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary#Usage_notes). 

Accordingly we looked at the number of `details` and `summary` elements and it seems that they do continue to be misused. The count of `summary` elements is higher on both mobile and desktop, with a ratio of 1.11 `summary` elements for every `details` element on mobile, and 1.19 on desktop, respectively:

| Element | Occurrences | |
| | Mobile (0.39%) | Desktop (0.22%) |
|---|---|---|
| `summary` | 62,992 | 43,936 |
| `details` | 56,603 | 36,743 |

</div>

### Probability of element use

Another look at element popularity, how likely is it to find a certain element in the DOM of a page? Surely, `html`, `head`, `body` are present on every page (even though [their tags are all optional](https://meiert.com/en/blog/optional-html/)), making them common elements, but what other elements are to be found?

| Element | Probability |
|---|---|
| `title` | 99.34% |
| `meta` | 99% |
| `div` | 98.42% |
| `a` | 98.32% |
| `link` | 97.79% |
| `script` | 97.73% |
| `img` | 95.83% |
| `span` | 93.98% |
| `p` | 88.71% |
| `ul` | 87.68% |

What standard elements—elements that are or were part of the HTML specification—are you really rarely to find? In our sample, that would bring up the following:

| Element | Probability |
|---|---|
| `dir` | 0.0082% |
| `rp` | 0.0087% |
| `basefont` | 0.0092% |

### Custom elements

The 2019 edition of the Web Almanac handled this part [a little differently](../2019/markup#custom-elements), discussing several non-standard elements. However, we found it valuable to have a closer look at custom elements. How did we determine these? Roughly by looking at [their definition](https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts), notably their use of a hyphen. Let’s focus on the top elements, in this case elements used on ≥1% of all URLs in the sample:

| Element | Occurrences | Percentage |
|---|---|---|
| `ym-measure` | 141,156 | 2.22% |
| `wix-image` | 76,969 | 1.21% |
| `rs-module-wrap` | 71,272 | 1.12% |
| `rs-module` | 71,271 | 1.12% |
| `rs-slide` | 70,970 | 1.12% |
| `rs-slides` | 70,993 | 1.12% |
| `rs-sbg-px` | 70,414 | 1.11% |
| `rs-sbg-wrap` | 70,414 | 1.11% |
| `rs-sbg` | 70,413 | 1.11% |
| `rs-progress` | 70,651 | 1.11% |
| `rs-mask-wrap` | 63,871 | 1.01% |
| `rs-loop-wrap` | 63,870 | 1.01% |
| `rs-layer-wrap` | 63,849 | 1.01% |
| `wix-iframe` | 63,590 | 1% |

These elements come from three sources: [Yandex Metrics](https://metrica.yandex.com/about) (`ym-`), an analytics solution we’ve also seen last year; [Slider Revolution](https://www.sliderrevolution.com/) (`rs-`), a WordPress slider, for which there are more elements to be found near the top of the sample; and [Wix](https://www.wix.com/) (`wix-`), a website builder.

Other groups that stand out include [AMP markup](https://amp.dev/) with `amp-` elements like `amp-img` (11,700 cases), `amp-analytics` (10,256) and `amp-auto-ads` (7,621), as well as [Angular](https://angular.io/) `app-` elements like `app-root` (16,314), `app-footer` (6,745), and `app-header` (5,274).

### Obsolete elements

There are more questions to ask about the use of HTML, and one may relate to obsolete elements—elements like `applet`, `bgsound`, `blink`, `center`, `font`, `frame`, `isindex`, `marquee`, or `spacer`.

In our mobile data set of 6.3 million pages, around 0.9 million pages (14.01%) contained one or more of these elements. Here are the Top 9, those elements that were used more than 10,000 times:

| Element | Occurrences | Percentage of pages with this element |
|---|---|---|
| `center` | 458,402 | 7.22% |
| `font` | 430,987 | 6.79% |
| `marquee` | 67,781 | 1.07% |
| `nobr` | 31,138 | 0.49% |
| `big` | 27,578 | 0.43% |
| `frame` | 19,363 | 0.31% |
| `frameset` | 19,163 | 0.30% |
| `strike` | 17,438 | 0.27% |
| `noframes` | 15,016 | 0.24% |

Why are these still alive—even `spacer` is still being used 1,584 times, and present on every 5,000th page. We know that Google has been using a `center` element on [their homepage](https://www.google.com/) [for 22 years](https://web.archive.org/web/19981202230410/https://www.google.com/) now, but does that find so many imitators?

<div class="note">

#### `isindex`

If you were wondering: The [`isindex` element](https://www.w3.org/TR/html401/interact/forms.html#edef-ISINDEX) was present once. (It was part of the HTML specs [until version 4.01, and of XHTML in 1.0](https://meiert.com/en/indices/html-elements/), yet only properly [specified in 2006](https://lists.w3.org/Archives/Public/public-whatwg-archive/2006Feb/0111.html), and [removed in 2016](https://github.com/whatwg/html/pull/1095).)

</div>

### Proprietary and made-up elements

In our set of elements we found some that were neither standard HTML (nor SVG nor MathML) elements, nor custom ones, nor obsolete ones, but somewhat proprietary ones. The Top 10 that we identified were the following:

| Element | Percentage of pages with this element |
|---|---|
| `noindex` | 0.89% |
| `jdiv` | 0.85% |
| `mediaelementwrapper` | 0.49% |
| `ymaps` | 0.26% |
| `yatag` | 0.20% |
| `ss` | 0.11% |
| `include` | 0.08% |
| `olark` | 0.07% |
| `h7` | 0.06% |
| `limespot` | 0.05% |

The source of these elements appears to be mixed, as in some are unknown while others can be traced. The most popular one, `noindex`, is probably due to [Yandex’s recommendation](https://yandex.com/support/webmaster/adding-site/indexing-prohibition.html) of it to prohibit page indexing. `jdiv` was noted in last year’s Almanac and is from JivoChat. `mediaelementwrapper` comes from the MediaElement media player. Both `ymaps` and `yatag` are also from Yandex. The `ss` element could be from ProStores, a former ecommerce product from eBay, and `olark` may be from the Olark chat software. `h7` appears to be a mistake. `limespot` is probably related to the Limespot personalization program for ecommerce. None of these elements are part of a web standard.

### Headings

[Headings](https://html.spec.whatwg.org/multipage/dom.html#heading-content) make for a special category of elements that play an important role in [sectioning](https://html.spec.whatwg.org/multipage/dom.html#sectioning-content-2) and for [accessibility](https://www.w3.org/WAI/tutorials/page-structure/headings/).

| Heading | Occurrences | Average per page |
|---|---|---|
| `h1` | 10,524,810 | 1.66 |
| `h2` | 37,312,338 | 5.88 |
| `h3` | 44,135,313 | 6.96 |
| `h4` | 20,473,598 | 3.23 |
| `h5` | 8,594,500 | 1.36 |
| `h6` | 3,527,470 | 0.56 |

Wait.

| Heading | Occurrences | Average per page |
|---|---|---|
| `h7` | 30,073 | 0.005 |
| `h8` | 9,266 | 0.0015 |

The last two have never been part of HTML, of course, and should not be used.

## Attributes

In our analysis of attributes we were interested to see how attributes are used in documents, and how the situation is around `data-` attributes. We diagnose that `class` is the queen of all attributes.

### Top attributes

Similar to popular elements, we were curious about the most popular attributes. Given how important the `href` attribute is for the Web itself, or the `alt` attribute in order to make information [accessible](./accessibility), would these be most popular?

Yet the most popular attribute is `class`—with almost 3 billion occurrences in our sample and constituting 34% of attributes in use, it’s by far the prevalent attribute:

@@

Attribute
Occurrences
Percentage
class
2,998,695,114
34.23%
href
928,704,735
10.60%
style
523,148,251
5.97%
id
452,110,137
5.16%
src
341,604,471
3.90%
type
282,298,754
3.22%
title
231,960,356
2.65%
alt
172,668,703
1.97%
rel
171,802,460
1.96%
value
140,666,779
1.61%

The value attribute, which specifies the value of an input element, surprisingly completes the top ten—surprising because on our end, subjectively, we didn’t get the impression values were used that frequently.
Attributes on pages
Are there attributes that we find in every document? No—but almost. href (99.21%), src (99.18%), content (98.88%), name (98.61%), type (98.55%), class (98.24%), rel (97.98%), id (97.46%), style (95.95%), and alt (90.75%) make the Top 10 here, with each being found on at least 90% of sampled pages.

This raises questions we cannot answer like yes, type is used on other elements, too, but why this tremendous popularity, given that it’s usually not needed to specify for style sheets or scripts (with CSS and JavaScript being assumed default)? Or how do we really fare with alt, do those 9.25% of pages that don’t include it not contain any images?

To name all the attributes found on at least half of the pages, we would add title (85.5%), target (82.98%), async (81.96%), lang (79.1%), width (78.99%), height (76.36%—note the difference to width), charset (75.44%), value (67.57%), role (62.97%), action (62.34%), http-equiv (62.3%), method (60.27%), media (60.14%), property (55.68%), and placeholder (54.21%).
data- attributes
What we were also curious about were data- attributes. How are these used? What are the popular ones? Is there anything interesting here?

The most popular ones stand out because they are almost twice as popular than each of the attributes that followed (with >1% use):

Attribute
Occurrences
Percentage
data-src
26,734,560
3.30%
data-id
26,596,769
3.28%
data-toggle
12,198,883
1.50%
data-slick-index
11,775,250
1.45%
data-element_type
11,263,176
1.39%
data-type
11,130,662
1.37%
data-requiremodule
8,303,675
1.02%
data-requirecontext
8,302,335
1.02%

Attributes like data-type, data-id, and data-src can have multiple generic uses although data-src is used a lot with lazy image loading via JavaScript (e.g., Bootstrap 4). Bootstrap again explains the presence of data-toggle, where it’s used as a state styling hook on toggle buttons. The Slick carousel plugin is the source of data-slick-index, whereas data-element_type is part of Elementor’s WordPress website builder. Both data-requiremodule and data-requirecontext, then, are part of RequireJS.

<p class="note">Interestingly, the use of native lazy loading on images is similar to that of data-src. 3.86% of img elements use the loading attribute with a value of lazy (this appears to be growing very fast, as back in February, this number was about 0.8%). It’s possible that these are being used together for a cross-browser solution.</p>

Miscellaneous
We’ve covered use of HTML in general as well as the situation around elements and attributes. In this section we’re reviewing special cases around viewports, favicons, buttons and inputs, but also links. Too many links may still point to “http” URLs is one thing we note here.
viewport specifications
The viewport meta element is used to control layout on mobile browsers. While years ago the motto was kind of “Don’t forget the viewport meta element” when building a web page, eventually this became a common practice and the motto changed to “Make sure zooming and scaling are not disabled.”

Users should be able to zoom and scale the text up to 500%, that’s why audits in popular tools like Lighthouse or axe fail when user-scalable="no" is used within the meta name="viewport" element, and when the maximum-scale attribute value is less than 5.

We had a look at the data and in order to better understand the results, we normalized it by removing spaces, converting everything to lowercase, and sorting by comma values of the content attribute.

Content attribute value
Occurrences
Percentage
initial-scale=1,width=device-width
2,728,491
42,98%
blank
688,293
10,84%
initial-scale=1,maximum-scale=1,width=device-width
373,136
5,88%
initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width
352,972
5,56%
initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width
249,662
3,93%
width=device-width
231,668
3,65%

The results show that almost half of the pages we analyzed are using the typical viewport content value. Still, around 688K mobile pages (and 904K desktop pages) are entirely missing a proper content value for the meta viewport element, with the rest of them using an improper combination of maximum-scale, minimum-scale, user-scalable=no, or user-scalable=0.

<p class="note">For a while now the Edge mobile browser allows to zoom into a web page to at least 500%, regardless of the zoom settings defined by a web page employing the viewport meta element.</p>

Favicons
The situation around favicons is fascinating: Favicons work with or without markup—some browsers would fall back to looking at the domain root—, accept several image formats, and then also promote several dozen sizes (some tools are reported to generate 45 of them; realfavicongenerator.net would return 37 if requested to handle every case). There is, as a side note, an issue open for the HTML spec to help improve the situation.

When we built our tests we didn’t check for the presence of images, but only looked at the markup. That means, when you review the following note that it’s more about how favicons are referenced rather than whether or how often they are used.

Favicon format
Ooccurrences
Percentage
ICO
2,245,646
35.38%
PNG
1,966,530
30.98%
No favicon defined
1,643,136
25.88%
JPG
319,935
5.04%
No extension specified (no format identifiable)
37,011
0.58%
GIF
34,559
0.54%
WebP
10,605
0.17%
…




SVG
5,328
0.08%

There may be a couple of surprises in here:

Support for other formats is there but ICO is still the go-to format for favicons on the Web.
JPG is a relatively popular favicon format even though it may not yield the best results (or a comparatively large file size) for many favicon sizes.
WebP is—twice as popular as SVG! (This might change, however, with SVG favicon support improving.)

Button and input types
There has been a lot of discussion on buttons lately and how often they are misused. We looked into this to present findings on some of the native HTML buttons:

Elements
Occurrences
Page percentage
<button type="button">...</button>
15,926,061
36.41%
<button> without type
11,838,110
32.43%
<button type="submit">...</button>
4,842,946
28.55%
<input type="submit" value="...">
4,000,844
31.82%
<input type="button" value="...">
1,087,182
4.07%
<input type="image" src="...">
322,855
2.69%
<button type="reset">...</button>
41,735
0.49%

According to the numbers we gathered, about 60% of the pages contain a button element and more than half of them (32.43%) fail to specify a type attribute.

<div class="note">

The button element has a default type of submit, meaning that the default behavior of a button is to submit the current form data. For extra clarity, consider specifying the button type in order to avoid unexpected situations.

The following table shows that a page in the 90th percentile has at least 13 native buttons, while the pages in the 10th and 25th percentiles contain no buttons at all:

Percentile
Buttons
25
0
50
1
75
5
90
13

</div>

Link targets
What protocols do anchors—a elements—point to? We looked at that information to identify the most popular protocols. How to read this information? Each row shows how many links with that protocol we count, and on how many of all documents at least one such protocol link is being used.

Protocol
Number of pages referencing the protocol
Percentage
https
5,756,444
90.69%
http
4,089,769
64.43%
mailto
1,691,220
26.64%
javascript
1,583,814
24.95%
tel
1,335,919
21.05%
whatsapp
34,643
0.55%
viber
25,951
0.41%
skype
22,378
0.35%
sms
17,304
0.27%
intent
12,807
0.20%

We can see how “https” and “http” are most dominant, followed by “benign” links to make writing email, making phone calls, and sending messages easier. “javascript” stands out as a link target that’s still very popular even though JavaScript offers native and gracefully degrading options to work with.
Links in new windows
Using target="_blank" is known as a security vulnerability for some time now. Yet, within the data set we analyzed, 71.35% of the pages contain links with target="_blank", without noopener or noreferrer:

Elements
Pages
<a target="_blank" rel="noopener noreferrer">
13.63%
<a target="_blank" rel="noopener">
14.14%
<a target="_blank" rel="noreferrer">
0.56%

As a rule of thumb—also for usability reasons—, prefer not to use target=_blank. 

<p class="note">Within the latest Safari and Firefox versions, setting target="_blank" on a elements implicitly provides the same rel behavior as setting rel="noopener". This is currently being implemented in Chromium as well.</p>

Status and trends
We’ve sprinkled some observations throughout the chapter, and you’ll have made your own observations. At the end of this 2020 analysis, here are some things that stood out for us.

Fewer pages land in quirks mode. In 2016, that number was at around 7.4%, at the end of 2019, we observed 4.85%, and now we’re at about 3.97%. This trend, to quote Simon Pieters in his review of this chapter, seems indeed clear and encouraging.

Although we lack historic data to draw the full development, “meaningless” div and span (and also i) markup has pretty much replaced the table markup we’ve observed in the 90s and early 2000’s. While one may question whether div and span elements are always used without there being a semantically more appropriate alternative, these elements are still preferable to table markup, though, as during the heyday of the old Web, these were used for everything but tabular data.

Elements per page and element types per page stayed roughly the same, showing no significant change in our HTML writing practice when compared to 2019. Such changes may require more time to manifest.

Proprietary product-specific elements like g:plusone (used on 17,607 pages in the mobile sample) and fb:like (11,335) have almost disappeared after still being among the most popular ones last year. However, we observe more custom elements for things like Slider Revolution, AMP, and Angular. And: Elements like ym-measure, jdiv, and ymaps persist. What we imagine seeing here is that under the sea of slowly-changing practices, HTML is very much being developed and maintained, as authors toss deprecated markup and embrace new solutions.

We’re leaving this open: What do you observe? What has caught your eye? What do you think has taken a turn for the worse—and what did improve? Leave a comment to share your thoughts!
Conclusion
When we don’t need to cover 14 years for analysis but only 1, one could almost get the impression that HTML is rather inert, that not much changes.

Yet what we observe with this year’s data is that there’s lots of movement at the bottom and near the shore of said sea of HTML: We approach near-complete adoption of living HTML, are quick to prune our pages of fads (like Google and Facebook widgets), and we’re fast in adopting and shunning frameworks (both Angular and AMP—though a “component framework”—seem to have significantly lost in popularity, likely for solutions like React and Vue).

And still, there are no signs we exhausted the options HTML gives us. The median of 30 different elements used on a given page, which is roughly a quarter of the elements HTML provides us with, suggests a rather one-sided use of HTML. That is supported by the immense popularity of elements like div and span, and no custom elements to potentially meet the demands that these two elements may represent. Unfortunately we couldn’t validate each document in the sample (yet we learned—to be used with caution—that of W3C-tested documents, 79% have errors), but after everything we’ve seen it looks like we’re still far from mastering the craft of HTML.

That suggests us to close with an appeal:

Pay attention to HTML. Focus on HTML. It’s important and worthwhile to invest in HTML. HTML is a document language that may not have the charm of a programming language, and yet the Web is built on it. Use less HTML—learn what’s really needed. Use more appropriate HTML—learn what’s available and what it’s there for. And validate your HTML. Everyone can write invalid HTML—just invite the next person you meet to write an HTML document and validate the output—, but a professional developer can be expected to produce valid HTML. Writing correct and valid HTML is a craft to take pride in.

For the next edition of the Web Almanac’s chapter, let’s prepare to look closer at the craft of writing HTML—and, hopefully, how we’ve been improving on it.

@@ Delete (just kept for backup purposes)

## Introduction

In 2005, Ian "Hixie" Hickson posted [some analysis of markup data](https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html)  building upon various previous work. Much of this work aimed to investigate class names to see if there were common informal semantics that were being adopted by developers which it might make sense to standardize upon.  Some of this research helped inform new elements in HTML5.

14 years later, it's time to take a fresh look.  Since then, we've also had the introduction of [Custom Elements](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements) and the [Extensible Web Manifesto](https://extensiblewebmanifesto.org/) encouraging that we find better ways to pave the cowpaths by allowing developers to explore the space of elements themselves and allow standards bodies to [act more like dictionary editors](https://bkardell.com/blog/Dropping-The-F-Bomb-On-Standards.html).  Unlike CSS class names, which might be used for anything, we can be far more certain that authors who used a non-standard *element* really intended this to be an element.  

As of July 2019, the HTTP Archive has begun collecting all used *element* names in the DOM for about 4.4 million desktop home pages, and about 5.3 million mobile home pages which we can now begin to research and dissect. _(Learn more about our [Methodology](./methodology).)_

This crawl encountered *over 5,000 distinct non-standard element names* in these pages, so we capped the total distinct number of elements that we count to the 'top' (explained below) 5,048. 

## Methodology

Names of elements on each page were collected from the DOM itself, after the initial run of JavaScript.

Looking at a raw frequency count isn't especially helpful, even for standard elements:  About 25% of all elements encountered are `<div>`.  About 17% are `<a>`, about 11% are `<span>` -- and those are the only elements that account for more than 10% of occurrences.  Languages are [generally like this](https://www.youtube.com/watch?v=fCn8zs912OE); a small number of terms are astoundingly used by comparison.  Further, when we start looking at non-standard elements for uptake, this would be very misleading as one site could use a certain element a thousand times and thus make it look artificially very popular.  

Instead, as in Hixie's original study,  what we will look at is how many sites include each  element at least once in their homepage.

<p class="note">Note: This is, itself, not without some potential biases.  Popular products can be used by several sites, which introduce non-standard markup, even "invisibly" to individual authors.  Thus, care must be taken to acknowledge that usage doesn't necessarily imply direct author knowledge and conscious adoption as much as it does the servicing of a common need, in a common way.  During our research, we found several examples of this, some we will call out.</p>

## Top elements and general info

In 2005, Hixie's survey listed the top few most commonly used elements on pages.  The top 3 were `html`, `head` and `body` which he noted as interesting because they are optional and created by the parser if omitted.  Given that we use the post-parsed DOM,  they'll show up universally in our data.  Thus, we'll begin with the 4th most used element. Below is a comparison of the data from then to now (I've included the frequency comparison here as well just for fun).

<figure data-markdown="1">

2005 (per site) | 2019 (per site) | 2019 (frequency)
-- | -- | --
title | title | div
a | meta | a
img | a | span
meta | div | li
br | link | img
table | script | script
td | img | p
tr | span | option

<figcaption>{{ figure_link(caption="Comparison of the top elements from 2005 to 2019.") }}</figcaption>
</figure>

### Elements per page

{{ figure_markup(
  image="hixie_elements_per_page.png",
  caption="Distribution of Hixie's 2005 analysis of element frequencies.",
  description="Graph showing a decreasing distribution of relative frequency as the number of elements increases",
  width=600,
  height=318
  )
}}

{{ figure_markup(
  image="fig3.png",
  caption="Element frequencies as of 2019.",
  description="Graph showing about 2,500 pages start with approximately 30 elements, this increases peaking at 6,876 pages have 283 elements, before trailing fairly linearly to 327 pages having 2,000 elements.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=2141583176&format=interactive"
  )
}}

Comparing the latest data in Figure 3.3 to that of Hixie's report from 2005 in Figure 3.2, we can see that the average size of DOM trees has gotten bigger.

{{ figure_markup(
  image="hixie_element_types_per_page.png",
  caption="Histogram of Hixie's 2005 analysis of element types per page.",
  description="Graph that relative frequency is a bell curve around the 19 elements point.",
  width=600,
  height=320
  )
}}

{{ figure_markup(
  image="fig5.png",
  caption="Histogram of element types per page as of 2019.",
  description="Graph showing the average number of elements is a bell curve around the 30 elements marked, as used by 308,168 thousand sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1500675289&format=interactive"
  )
}}

We can see that both the average number of types of elements per page has increased, as well as the maximum numbers of unique elements that we encounter.

## Custom elements

Most of the elements we recorded are custom (as in simply 'not standard'), but discussing which elements are and are not custom can get a little challenging. Written down in some spec or proposal somewhere are, actually, quite a few elements.  For purposes here, we considered 244 elements as standard (though, some of them are deprecated or unsupported):

* 145 Elements from HTML
* 68 Elements from SVG
* 31 Elements from MathML

In practice, we encountered only 214 of these:

* 137 from HTML
* 54 from SVG
* 23 from MathML

In the desktop dataset we collected data for the top 4,834 non-standard elements that we encountered. Of these:

* 155 (3%) are identifiable as very probable markup or escaping errors (they contain characters in the parsed tag name which imply that the markup is broken)
* 341 (7%) use XML-style colon namespacing (though, as HTML, they don't use actual XML namespaces)
* 3,207 (66%) are valid custom element names
* 1,211 (25%) are in the global namespace (non-standard, having neither dash, nor colon)
* 216 of these we have flagged as *possible* typos as they are longer than 2 characters and have a Levenshtein distance of 1 from some standard element name like `<cript>`,`<spsn>` or `<artice>`. Some of these (like `<jdiv>`), however, are certainly intentional.

Additionally, 15% of desktop pages and 16% of mobile pages contain deprecated elements.

<p class="note">Note: A lot of this is very likely due to the use of products rather than individual authors continuing to manually create this markup.</p>

{{ figure_markup(
  image="fig6.png",
  caption="Most frequently used deprecated elements.",
  description="Bar chart showing 'center' in use by 8.31% of desktop sites (7.96% of mobile), 'font' in use by 8.01% of desktop sites (7.38% of mobile), 'marquee' in use by 1.07% of desktop sites (1.20% of mobile), 'nobr' in use by 0.71% of desktop sites (0.55% of mobile), 'big' in use by 0.53% of desktop sites (0.47% of mobile), 'frameset' in use by 0.39% of desktop sites (0.35% of mobile), 'frame' in use by 0.39% of desktop sites (0.35% of mobile), 'strike' in use by 0.33% of desktop sites (0.27% of mobile), and 'noframes' in use by 0.25% of desktop sites (0.27% of mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1304237557&format=interactive"
  )
}}

Figure 3.6 above shows the top 10 most frequently used deprecated elements. Most of these can seem like very small numbers, but perspective matters.

## Perspective on value and usage

In order to discuss numbers about the use of elements (standard, deprecated or custom), we first need to establish some perspective.

{{ figure_markup(
  image="fig7_full.png",
  alt="Top 150 elements.",
  caption='Top 150 elements (<a href="/static/images/2019/markup/fig7_full.png">full detail</a>).',
  description="Bar chart showing a decreasing used of elements in descending order: html, head, body, title at above 99% usage, meta, a, div above 98% usage, link, script, img, span above 90% usage, ul, li , p, style, input, br, form above 70% usage, h2, h1, iframe, h3, button, footer, header, nav above 50% usage and other less well-known tags trailing down from below 50% to almost 0% usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1694360298&format=interactive",
  width=600,
  height=778,
  data_width=600,
  data_height=778
  )
}}

In Figure 3.7 above, the top 150 element names, counting the number of pages where they appear, are shown. Note how quickly use drops off.

Only 11 elements are used on more than 90% of pages:

- `<html>`
- `<head>`
- `<body>`
- `<title>`
- `<meta>`
- `<a>`
- `<div>`
- `<link>`
- `<script>`
- `<img>`
- `<span>`

There are only 15 other elements that occur on more than 50% of pages:

- `<ul>`
- `<li>`
- `<p>`
- `<style>`
- `<input>`
- `<br>`
- `<form>`
- `<h2>`
- `<h1>`
- `<iframe>`
- `<h3>`
- `<button>`
- `<footer>`
- `<header>`
- `<nav>`

And there are only 40 other elements that occur on more than 5% of pages.

Even `<video>`, for example, doesn't make that cut. It appears on only 4% of desktop pages in the dataset (3% on mobile). While these numbers sound very low, 4% is actually *quite* popular by comparison.  In fact, only 98 elements occur on more than 1% of pages.

It's interesting, then, to see what the distribution of these elements looks like and which ones have more than 1% use.

{{ figure_markup(
  link="https://rainy-periwinkle.glitch.me/scatter/html",
  image="element_categories.png",
  caption="Element popularity categorized by standardization.",
  description="Scatter graph showing HTML, SVG, and Math ML use relatively few tags while non-standard elements (split into \"in global ns\", \"dasherized\" and \"colon\") are much more spread out.",
  width=600,
  height=1065
  )
}}

Figure 3.8 shows the rank of each element and which category they fall into.  I've separated the data points into discrete sets simply so that they can be viewed (otherwise there just aren't enough pixels to capture all that data), but they represent a single 'line' of popularity; the bottom-most being the most common, the top-most being the least common.  The arrow points to the end of elements that appear in more than 1% of the pages.

You can observe two things here. First, the set of elements that have more than 1% use are not exclusively HTML.  In fact, *27 of the most popular 100 elements aren't even HTML* - they are SVG! And there are *non-standard tags at or very near that cutoff too*!  Second, note that a whole lot of HTML elements are used by less than 1% of pages.

So, are all of those elements used by less than 1% of pages "useless"?  Definitely not.  This is why establishing perspective matters.  There are around [two billion web sites on the web](https://www.websitehostingrating.com/internet-statistics-facts/). If something appears on 0.1% of all websites in our dataset, we can extrapolate that this represents perhaps *two million web sites* in the whole web. Even 0.01% extrapolates to _two hundred thousand sites_.  This is also why removing support for elements, even very old ones which we think aren't great ideas, is a very rare occurrence.  Breaking hundreds of thousands or millions of sites just isn't a thing that browser vendors can do lightly.  

Many elements, even the native ones, appear on fewer than 1% of pages and are still very important and successful.  `<code>`, for example, is an element that I both use and encounter a lot.  It's definitely useful and important, and yet it is used on only 0.57% of these pages.  Part of this is skewed based on what we are measuring; home pages are generally *less likely* to include certain kinds of things (like `<code>` for example). Home pages serve a less general purpose than, for example, headings, paragraphs, links and lists. However, the data is generally useful.

We also collected information about which pages contained an author-defined (not native) `.shadowRoot`. About 0.22% of desktop pages and 0.15% of mobile pages had a shadow root.  This might not sound like a lot, but it is roughly 6.5k sites in the mobile dataset and 10k sites on the desktop and is more than several HTML elements.  `<summary>` for example, has about equivalent use on the desktop and it is the 146th most popular element. `<datalist>` appears on 0.04% of homepages and it's the 201st most popular element.

In fact, over 15% of elements we're counting as defined by HTML are outside the top 200 in the desktop dataset .  `<meter>` is the least popular "HTML5 era" element, which we can define as 2004-2011, before HTML moved to a Living Standard model. It is around the 1,000th most popular element.  `<slot>`, the most recently introduced element (April 2016), is only around the 1,400th most popular element.

## Lots of data: real DOM on the real web

With this perspective in mind about what use of native/standard features looks like in the dataset, let's talk about the non-standard stuff.

You might expect that many of the elements we measured are used only on a single web page, but in fact all of the 5,048 elements appear on more than one page.  The fewest pages an element in our dataset appears on is 15.  About a fifth of them occur on more than 100 pages.  About 7% occur on more than 1,000 pages.

To help analyze the data, I hacked together a [little tool with Glitch](https://rainy-periwinkle.glitch.me).  You can use this tool yourself, and please share a permalink back with the [@HTTPArchive](https://twitter.com/HTTPArchive) along with your observations. (Tommy Hodgins has also built a similar [CLI tool](https://github.com/tomhodgins/hade) which you can use to explore.)

Let's look at some data.

### Products (and libraries) and their custom markup

For several non-standard elements, their prevalence may have more to do with their inclusion in popular third-party tools than first-party adoption. For example, the `<fb:like>` element is found on 0.3% of pages not because site owners are explicitly writing it out but because they include the Facebook widget. Many of the elements [Hixie mentioned 14 years ago](https://web.archive.org/web/20060203031245/http://code.google.com/webstats/2005-12/editors.html) seem to have dwindled, but others are still pretty huge:

- Popular elements created by [Claris Home Page](https://en.wikipedia.org/wiki/Claris_Home_Page) (whose last stable release was 21 years ago) *still* appear on over 100 pages. [`<x-claris-window>`](https://rainy-periwinkle.glitch.me/permalink/28b0b7abb3980af793a2f63b484e7815365b91c04ae625dd4170389cc1ab0a52.html), for example, appears on 130 pages.
- Some of the `<actinic:*>` elements from British ecommerce provider [Oxatis](https://www.oxatis.co.uk) appear on even more pages. For example, [`<actinic:basehref>`](https://rainy-periwinkle.glitch.me/permalink/30dfca0fde9fad9b2ec58b12cb2b0271a272fb5c8970cd40e316adc728a09d19.html) still shows up on 154 pages in the desktop data.
- Macromedia's elements seem to have largely disappeared. Only one element, [`<mm:endlock>`](https://rainy-periwinkle.glitch.me/permalink/836d469b8c29e5892dedfd43556ed1b0e28a5647066858ca1c395f5b30f8485c.html), appears on our list and on only 22 pages.
- Adobe Go-Live's [`<csscriptdict>`](https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html) still appears on 640 pages in the desktop dataset.
- Microsoft Office's `<o:p>` element still appears on 0.5% of desktop pages, over 20k pages.

But there are plenty of newcomers that weren't in Hixie's original report too, and with even bigger numbers.

- [`<ym-measure>`](https://rainy-periwinkle.glitch.me/permalink/e8bf0130c4f29b28a97b3c525c09a9a423c31c0c813ae0bd1f227bd74ddec03d.html) is a tag injected by Yandex's [Metrica analytics package](https://www.npmjs.com/package/yandex-metrica-watch). It's used on more than 1% of desktop and mobile pages, solidifying its place in the top 100 most used elements. That's huge!
- [`<g:plusone>`](https://rainy-periwinkle.glitch.me/permalink/a532f18bbfd1b565b460776a64fa9a2cdd1aa4cd2ae0d37eb2facc02bfacb40c.html) from the now-defunct Google Plus occurs on over 21k pages.
- Facebook's [`<fb:like>`](https://rainy-periwinkle.glitch.me/permalink/2e2f63858f7715ef84d28625344066480365adba8da8e6ca1a00dfdde105669a.html)  occurs on 14k mobile pages.
- Similarly, [`<fb:like-box>`](https://rainy-periwinkle.glitch.me/permalink/5a964079ac2a3ec1b4f552503addd406d02ec4ddb4955e61f54971c27b461984.html)  occurs on 7.8k mobile pages.
- [`<app-root>`](https://rainy-periwinkle.glitch.me/permalink/6997d689f56fe77e5ce345cfb570adbd42d802393f4cc175a1b974833a0e3cb5.html), which is generally included in frameworks like Angular, appears on 8.2k mobile pages.

Let's compare these to a few of the native HTML elements that are below the 5% bar, for perspective.

{{ figure_markup(
  image="fig9.png",
  caption="Popularity of product-specific and native elements under 5% adoption.",
  description="Bar chart showing video is used by 184,149 sites, canvas by 108,355, ym-measure (a product-specific tag) by 52,146, code by 25,075, g:plusone (a product-specific tag) by 21,098, fb:like (a product-specific tag) by 12,773, fb:like-box (a product-specific tag) by 6,792, app-root (a product-specific tag) by 8,468, summary by 6,578, template by 5,913, and meter by 0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=962404708&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

You could discover interesting insights like these all day long.

Here's one that's a little different: popular elements could be caused by outright errors in products. For example, `<pclass="ddc-font-size-large">` occurs on over 1,000 sites. This was thanks to a missing space in a popular "as-a-service" kind of product.  Happily, we reported this error during our research and it was quickly fixed.

In his original paper, Hixie mentions that:

<blockquote>The good thing, if we can be forgiven for trying to remain optimistic in the face of all this non-standard markup, is that at least these elements are all clearly using vendor-specific names. This massively reduces the likelihood that standards bodies will invent elements and attributes that clash with any of them.</blockquote>

However, as mentioned above, this is not universal.  Over 25% of the non-standard elements that we captured don't use any kind of namespacing strategy to avoid polluting the global namespace.  For example, here is [a list of 1157 elements like that from the mobile dataset](https://rainy-periwinkle.glitch.me/permalink/53567ec94b328de965eb821010b8b5935b0e0ba316e833267dc04f1fb3b53bd5.html).  Many of those, as you can see, are likely to be non-problematic as they have obscure names, misspellings and so on. But at least a few probably present some challenges.  You'll note, for example,  that `<toast>` (which Googlers [recently tried to propose as `<std-toast>`](https://www.chromestatus.com/feature/5674896879255552)) appears in this list.

There are some popular elements that are probably not so challenging:

- [`<ymaps>`](https://rainy-periwinkle.glitch.me/permalink/2ba66fb067dce29ecca276201c37e01aa7fe7c191e6be9f36dd59224f9a36e16.html) from Yahoo Maps appears on ~12.5k mobile pages.
- [`<cufon>` and `<cufontext>`](https://rainy-periwinkle.glitch.me/permalink/5cfe2db53aadf5049e32cf7db0f7f6d8d2f1d4926d06467d9bdcd0842d943a17.html) from a font replacement library from 2008, appear on ~10.5k mobile pages.
- The [`<jdiv>`](https://rainy-periwinkle.glitch.me/permalink/976b0cf78c73d125644d347be9e93e51d3a9112e31a283259c35942bda06e989.html) element, which appears to be injected by the Jivo chat product, appears on ~40.3k mobile pages,

Placing these into our same chart as above for perspective looks something like this (again, it varies slightly based on the dataset)

{{ figure_markup(
  image="fig10.png",
  caption="Other popular elements in the context of product-specific and native elements with under 5% adoption.",
  description="A bar chart showing video is used by 184,149 sites, canvas by 108,355, ym-measure by 52,416, code by 25,075, g:plusone by 21,098, db:like by 12,773, cufon by 10,523, ymaps by 8,303, fb:like-box by 6,972, app-root by 8,468, summary by 6,578, template by 5,913, and meter by 0",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=468373762&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

The interesting thing about these results is that they also introduce a few other ways that our tool can come in very handy.  If we're interested in exploring the space of the data, a very specific tag name is just one possible measure.  It's definitely the strongest indicator if we can find good "slang" developing.  However, what if that's not all we're interested in?

### Common use cases and solutions

What if, for example, we were interested in people solving common use cases?  This could be because we're looking for solutions to use cases that we currently have ourselves, or for researching more broadly what common use cases people are solving with an eye toward incubating some standardization effort.  Let's take a common example: tabs.  Over the years there have been a lot of requests for things like tabs.  We can use a fuzzy search here and find that there are [many variants of tabs](https://rainy-periwinkle.glitch.me/permalink/c6d39f24d61d811b55fc032806cade9f0be437dcb2f5735a4291adb04aa7a0ea.html).  It's a little harder to count usage here since we can't as easily distinguish if two elements appear on the same page, so the count provided there conservatively simply takes the one with the largest count. In most cases the real number of pages is probably significantly larger.

There are also lots of [accordions](https://rainy-periwinkle.glitch.me/permalink/e573cf279bf1d2f0f98a90f0d7e507ac8dbd3e570336b20c6befc9370146220b.html), [dialogs](https://rainy-periwinkle.glitch.me/permalink/0bb74b808e7850a441fc9b93b61abf053efc28f05e0a1bc2382937e3b78695d9.html), at least 65 variants of [carousels](https://rainy-periwinkle.glitch.me/permalink/651e592cb2957c14cdb43d6610b6acf696272b2fbd0d58a74c283e5ad4c79a12.html), lots of stuff about [popups](https://rainy-periwinkle.glitch.me/permalink/981967b19a9346ac466482c51b35c49fc1c1cc66177ede440ab3ee51a7912187.html), at least 27 variants of [toggles and switches](https://rainy-periwinkle.glitch.me/permalink/2e6827af7c9d2530cb3d2f39a3f904091c523c2ead14daccd4a41428f34da5e8.html), and so on.

Perhaps we could research why we need [92 variants of button related elements that aren't a native button](https://rainy-periwinkle.glitch.me/permalink/5ae67c941395ca3125e42909c2c3881e27cb49cfa9aaf1cf59471e3779435339.html), for example, and try to fill the native gap.

If we notice popular things pop up (like `<jdiv>`, solving chat) we can take knowledge of things we know (like, that is what `<jdiv>` is about, or `<olark>`) and try to look [at at least 43 things we've built for tackling that](https://rainy-periwinkle.glitch.me/permalink/db8fc0e58d2d46d2e2a251ed13e3daab39eba864e46d14d69cc114ab5d684b00.html) and follow connections to survey the space.

## Conclusion

So, there's lots of data here, but to summarize: 

* Pages have more elements than they did 14 years ago, both on average and max.
* The lifetime of things on home pages is *very* long.  Deprecating or discontinuing things doesn't make them go away, and it might never.
* There is a lot of broken markup out there in the wild (misspelled tags, missing spaces, bad escaping, misunderstandings).
* Measuring what "useful" means is tricky. Lots of native elements don't pass the 5% bar, or even the 1% bar, but lots of custom ones do, and for lots of reasons.  Passing 1% should definitely grab our attention at least, but perhaps so should 0.5% because that is, according to the data, comparatively *very* successful.
* There is already a ton of custom markup out there.  It comes in a lot of forms, but elements containing a dash definitely seem to have taken off.
* We need to increasingly study this data and come up with good observations to help find and pave the cowpaths.

That last one is where you come in.  We'd love to tap into the creativity and curiosity of the larger community to help explore this data using some of the tools (like [https://rainy-periwinkle.glitch.me/](https://rainy-periwinkle.glitch.me/)). Please share your interesting observations and help build our commons of knowledge and understanding.
