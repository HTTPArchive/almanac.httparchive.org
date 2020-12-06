---
part_number: I
chapter_number: 3
title: Markup
description: Markup chapter of the 2020 Web Almanac covering general observations, the use of elements and attributes, as well as trivia and trends.
authors: [j9t, catalinred, iandevlin]
j9t_bio: Jens Oliver Meiert is a web developer and author (<a href="https://leanpub.com/css-optimization-basics"><cite>CSS Optimization Basics</cite></a>, <a href="https://leanpub.com/web-development-glossary"><cite>The Web Development Glossary</cite></a>), who works as an engineering manager at <a href="https://www.jimdo.com/">Jimdo</a>. He's an expert on web development where he specializes in HTML and CSS optimization. Jens contributes to technical standards and regularly writes about his work and research, particularly on his website, <a href="https://meiert.com/en/">meiert.com</a>.
catalinred_bio: Catalin Rosu is a front-end developer at <a href="https://www.caphyon.com/">Caphyon</a> and currently works on <a href="https://www.wattspeed.com/">Wattspeed</a>. He has a passion for web standards and a keen eye for great UX & UI, things he <a href="https://twitter.com/catalinred">tweets</a> and writes about on <a href="https://catalin.red/">his website</a>.
iandevlin_bio: Ian Devlin is a web developer who advocates for good, semantic HTML, as well as accessibility. He once wrote a book about <a href="https://www.peachpit.com/store/html5-multimedia-develop-and-design-9780321793935">HTML5 Multimedia</a>, and sporadically writes on <a href="https://iandevlin.com/">his website</a> about the Web and other things. He currently works as a Senior Frontend Engineer at <a href="https://www.real-digital.de/">real.digital</a> in Germany.
reviewers: [zcorpan, matuzo, bkardell]
analysts: [Tiggerito]
translators: []
discuss: 2039
results: https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/
queries: 03_Markup
featured_quote: We approach near-complete adoption of living HTML, are quick to prune our pages of fads, and we're fast in adopting and shunning frameworks. And still, there are no signs we exhausted the options HTML gives us.
featured_stat_1: 85.73%
featured_stat_label_1: Percentage of pages that use the "living" HTML doctype
featured_stat_2: 30,073
featured_stat_label_2: Number of non-standard <code>h7</code> elements
featured_stat_3: 25.24 KB
featured_stat_label_3: Weight of the median document
---

## Introduction

The web is built on HTML. Without HTML there are no web pages, no web sites, no web apps. Nothing. There may be plain-text documents, perhaps, or XML trees, in some parallel universe that enjoyed that particular kind of challenge. In this universe, HTML is the foundation of the user-facing web. There are many standards that the web is resting on, but HTML is certainly one of the most important ones.

How do we use HTML, then, how great of a foundation do we have? In the introductory section of the [2019 Markup chapter](../2019/markup#introduction), author [Brian Kardell](../2019/contributors#bkardell) suggested that for a long time, we haven't really known. There were some smaller samples. For example, there was [Ian Hickson's research](https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html) (one of modern HTML's parents) among a few others, but until last year we lacked major insight into how we as developers, as authors, make use of HTML. In 2019 we had both [Catalin Rosu's work](https://www.advancedwebranking.com/html/) (one of this chapter's co-authors) as well as the 2019 edition of the Web Almanac to give us a better view again of HTML in practice.

Last year's analysis was based on 5.8 million pages, of which 4.4 million were tested on desktop and 5.3 million on mobile. This year we analyzed 7.5 million pages, of which 5.6 million were tested on desktop and 6.3 million on mobile, using the [latest data](./methodology#websites) on the websites users are visiting in 2020. We do make some comparisons to last year, but just as we've tried to analyze additional metrics for new insights, we've also tried to impart our own personalities and perspectives throughout the chapter.

<p class="note">
  In this Markup chapter, we're focusing almost exclusively on HTML, rather than SVG or MathML, which are also considered markup languages. Unless otherwise noted, stats presented in this chapter refer to the set of mobile pages. Additionally, the data for all Web Almanac chapters is open and available. Take a look at <a href="https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/">the results</a> and <a href="https://discuss.httparchive.org/t/2039">share your observations</a> with the community!
</p>

## General

In this section, we're covering the higher-level aspects of HTML like document types, the size of documents, as well as the use of comments and scripts. "Living HTML" is very much alive!

### Doctypes

{{ figure_markup(
  caption="Percent of pages with a doctype.",
  content="96.82%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

96.82% of pages declare a [_doctype_](https://developer.mozilla.org/en-US/docs/Glossary/Doctype). HTML documents declaring a doctype is useful for historical reasons, "to avoid triggering quirks mode in browsers" as [Ian Hickson wrote in 2009](https://lists.w3.org/Archives/Public/public-html-comments/2009Jul/0020.html). What are the most popular values?

<figure markdown>
| Doctype | Pages | Percentage |
|---|---|---|
| HTML ("HTML5") | 5,441,815 | 85.73% |
| XHTML 1.0 Transitional | 382,322 | 6.02% |
| XHTML 1.0 Strict | 107,351 | 1.69% |
| HTML 4.01 Transitional | 54,379 | 0.86% |
| HTML 4.01 Transitional ([quirky](https://hsivonen.fi/doctype/#xml)) | 38,504 | 0.61% |

<figcaption>{{ figure_link(caption="The 5 most popular doctypes.", sheets_gid="1981441894", sql_file="summary_pages_by_device_and_doctype.sql") }}</figcaption>
</figure>

You can already tell how the numbers decrease quite a bit after XHTML 1.0, before entering the long tail with a few standard, some esoteric, and also bogus doctypes.

Two things stand out from these results:

1. Almost 10 years after [the announcement of living HTML](https://blog.whatwg.org/html-is-the-new-html5) (aka "HTML5"), living HTML has clearly become the norm.
2. The web before living HTML can still be seen in the next most popular doctypes, like XHTML 1.0. XHTML. Although their documents are likely delivered as HTML with a MIME type of `text/html`, these older doctypes are not dead yet.

### Document size

A page's document size refers to the amount of HTML bytes transferred over the network, including compression if enabled. At the extremes of the set of 6.3 million documents:

{# TODO(authors, analysts): Revisit the "largest document" stat and interpretation. #}
* 1,110 documents are empty (0 bytes).
* The average document size is 49.17 KB ([in most cases compressed](https://w3techs.com/technologies/details/ce-gzipcompression)).
* The largest document by far weighs 62.65 _MB_, almost deserving its own analysis and chapter in the Web Almanac.

How is this situation in general, then? The median document weighs 24.65 KB, which comes [without surprises](https://httparchive.org/reports/page-weight):

{{ figure_markup(
  image="document-size.png",
  caption="The amount of HTML bytes transferred over the network, including compression if enabled.",
  description="Document size in bytes per percentile, with the median document weighing 25.99 KB on desktop.",
  sheets_gid="2066175354",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=386686971&format=interactive",
  width=600,
  height=371,
  sql_file="summary_pages_by_device_and_percentile.sql"
  )
}}

### Document language

{# TODO(editors): Link directly to the relevant Accessibility section. #}
We identified 2,863 different values for the `lang` attribute on the `html` start tag (compare that to the [7,117 spoken languages](https://www.ethnologue.com/guides/how-many-languages) as per Ethnologue). Almost all of them seem valid, according to the [Accessibility](./accessibility) chapter.

22.36% of all documents specify no `lang` attribute. The commonly accepted view is that [they should](https://www.w3.org/TR/i18n-html-tech-lang/#overall), but beside the idea that software could eventually [detect language automatically](https://meiert.com/en/blog/lang/), document language can also be specified [on the protocol level](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language). This is something we didn't check.

Here are the 10 most popular (normalized) languages in our sample. It's important to note that the HTTP Archive crawls from US data centers with English language settings, so looking at the language pages are written in will be skewed towards English. Nevertheless we present the `lang` attributes seen to give some context to the sites analyzed.

{{ figure_markup(
  image="document-language.png",
  alt="The top HTML lang attributes.",
  caption="The top HTML `lang` attributes.",
  description="Bar chart showing the top 10 `lang` attributes used in our crawl with 22.82% of desktop and 22.36% of mobile pages not setting this, `en` being used on 20.09% and 18.08% respectively, `ja` on 15.17% and 13.27%, `es` on 4.86% and 4.09% , `pt-br` on 2.65% and 2.84%, `ru` on 2.21% 2.53%, `en-gb` on 2.35% and 2.19%, `de` on 1.50% and 1.92%, and finally `fr` being used on 1.55% and 1.43% respectively.",
  sheets_gid="2047285366",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1873310240&format=interactive",
  width=600,
  height=371,
  sql_file="pages_almanac_by_device_and_html_lang.sql"
  )
}}

### Comments

Adding comments to code is generally a good practice and HTML comments are there to add notes to HTML documents, without having them rendered by user agents.

```html
<!-- This is a comment in HTML -->
```

Although many pages will have been stripped of comments for production, we found that index pages in the 90th percentile are using about 73 comments on mobile, respectively 79 comments on desktop, while in the 10th percentile the number of the comments is about 2. The median page uses 16 (mobile) or 17 comments (desktop).

Around 89% of pages contain at least one HTML comment, while about 46% of them contain a conditional comment.

#### Conditional comments

```html
<!--[if IE 8]>
  <p>This renders in Internet Explorer 8 only.</p>
<![endif]-->
```

The above is a non-standard HTML conditional comment. While those have proven to be helpful in the past in order to tackle browser differences, they are history for some time as Microsoft [dropped conditional comments](https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/compatibility/hh801214(v=vs.85)) in Internet Explorer 10.

Still, on the above percentile extremes, we found that web pages are using about 6 conditional comments in the 90th percentile, and 1 comment while in the 10th percentile.  Most of the pages include them for helpers such as html5shiv, selectivizr, and respond.js. While being decentish and still active pages, our conclusion is that many of them were using obsolete CMS themes.

For production, HTML comments are usually stripped by build tools. Considering all the above counts and percentages, and referring to the use of comments in general, we suppose that lots of pages are served without involving an HTML minifier.

### Script use

As shown in the [Top elements](#top-elements) section below, the `script` element is the 6th most frequently used HTML element. For the purposes of this chapter, we were interested in the ways the `script` element is used across these millions of pages from the data set.

Overall, around 2% of pages contain no scripting at all, not even structured data scripts with the `type="application/ld+json"` attribute. Considering that nowadays it's pretty common for a page to include at least one script for an analytics solution, this seems noteworthy.

At the opposite end of the spectrum, the numbers show that about 97% of pages contain at least one script, either inline or external.

{# TODO(analysts): We still have a problem here with the x-axis label (“Containing”). Can someone help out and look at this? #}
{{ figure_markup(
  image="script-use.png",
  caption="Usage of the <code>script</code> element.",
  description="Percentages of pages (not) containing scripts, and scripts are present in almost every form on almost every page.",
  sheets_gid="150962402",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1895084382&format=interactive",
  width=600,
  height=371,
  sql_file="pages_almanac_by_device.sql"
  )
}}

When scripting is unsupported or turned off in the browser, the `noscript` element helps to add an HTML section within a page. Considering the above script numbers, we were curious about the `noscript` element as well.

Following the analysis, we found that about 49% of pages are using a `noscript` element. At the same time, about 16% of `noscript` elements were containing an `iframe` with a `src` value referring to "googletagmanager.com".

This seems to confirm the theory that the total number of `noscript` elements in the wild may be affected by common scripts like Google Tag Manager which enforce users to add a `noscript` snippet after the `body` start tag on a page.

#### Script types

What `type` attribute values are used with `script` elements?

- `text/javascript`: 60.03%
- `application/ld+json`: 1.68%
- `application/json`: 0.41%
- `text/template`: 0.41%
- `text/html` 0.27%

When it comes to loading [JavaScript module scripts](https://jakearchibald.com/2017/es-modules-in-browsers/) using `type="module"`, we found that 0.13% of `script` elements currently specify this attribute-value combination. `nomodule` is used by 0.95% of all tested pages. (Note that one metric relates to elements, the other to pages.)

36.38% of all scripts have no values set whatsoever.

## Elements

In this section, the focus is on elements: what elements are used, how frequently, which elements are likely to appear on a given page, and how the situation is with respect to custom, obsolete, and proprietary elements. Is [_divitis_](https://en.wiktionary.org/wiki/divitis) still a thing? Yes.

### Element diversity

Let's have a look at how diverse use of HTML actually is: Do authors use many different elements, or are we looking at a landscape that makes use of relatively few elements?

The median web page, it turns out, uses 30 different elements, 587 times:

{{ figure_markup(
  image="element-diversity-element-types.png",
  caption="Distribution of the number of element types per page.",
  description="Element types per percentile, with 90% of pages using at least 20 different elements.",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=924238918&format=interactive",
  width=600,
  height=371,
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

{# Editors note: The caption for the two figures below is intentionally identical. #}

{{ figure_markup(
  image="element-diversity.png",
  caption="Distribution of the total number elements per page.",
  description="Elements per percentile, showing how 10% of all pages employ more than 1,665 elements.",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=680594018&format=interactive",
  width=600,
  height=371,
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

Given that [living HTML](https://html.spec.whatwg.org/multipage/) currently has 112 elements, the 90th percentile not using more than 41 elements may suggest that HTML is not nearly being exhausted by most documents. Yet it's hard to interpret what this really means for HTML and our use of it, as the semantic wealth that HTML offers doesn't mean that every document would need all of it: HTML elements should be used per purpose (semantics), not per availability.

How are these elements distributed?

{{ figure_markup(
  image="distribution-of-elements-per-page.png",
  caption="Distribution of the total number of elements per page.",
  description="Element distribution in a scatter plot, and even for a trained observer it's hard to parse it; interesting is a large group of about 7,500 pages each using roughly 250 elements, after which fewer and fewer pages get back to more and more elements.",
  sheets_gid="1361520223",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1468756779&format=interactive",
  width=600,
  height=371,
  sql_file="pages_element_count_by_device_and_element_count.sql"
  )
}}

Not that much changed [compared to 2019](../2019/markup#fig-3)!

### Top elements

In 2019, the Markup chapter of the Web Almanac featured the most frequently used elements in reference to [Ian Hickson's work in 2005](https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html). We found this useful and had a look at that data again:

<figure markdown>
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

<figcaption>{{ figure_link(caption="The most popular elements in 2005, 2019, and 2020.", sheets_gid="781932961", sql_file="pages_element_count_by_device_and_element_type_frequency.sql") }}</figcaption>
</figure>

Nothing changed in the Top 7, but the `option` element went a little out of favor and dropped from 8 to 10, letting both the `link` and the `i` element pass in popularity. These elements have risen in use, possibly due to an increase in use of [resource hints](./resource-hints) (as with prerendering and prefetching), as well icon solutions like [Font Awesome](https://fontawesome.com/), which _de facto_ misuses `i` elements for the purpose of displaying icons.

#### `details` and `summary`

Another thing we were curious about was the use of the [`details` and `summary` elements](https://html.spec.whatwg.org/multipage/rendering.html#the-details-and-summary-elements), especially since 2020 brought [broad support](https://caniuse.com/details). Are they being used? Are they attractive for—even popular—among authors? As it turns out, only 0.39% of all tested pages are using them, although it's hard to gauge whether they were all used the correct way in exactly the situations when you need them, "popular" is the wrong word.

Here's a simple example showing the use of a `summary` in a `details` element:

```html
<details>
  <summary>Status: Operational</summary>
  <p>Velocity: 12m/s</p>
  <p>Direction: North</p>
</details>
```

A while ago, Steve Faulkner [pointed out](https://twitter.com/stevefaulkner/status/806474286592561152) how these two elements were used inadequately in the wild. As you can tell from the example above, for each `details` element you'd need a `summary` element that may only be used as the [first child](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary#Usage_notes) of `details`.

Accordingly, we looked at the number of `details` and `summary` elements and it seems that they do continue to be misused. The count of `summary` elements is higher on both mobile and desktop, with a ratio of 1.11 `summary` elements for every `details` element on mobile, and 1.19 on desktop, respectively:

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Occurrences</th>
      </tr>
      <tr>
        <th scope="col">Element</th>
        <th scope="col">Mobile (0.39%)</th>
        <th scope="col">Desktop (0.22%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>summary</code></td>
        <td>62,992</td>
        <td>43,936</td>
      </tr>
      <tr>
        <td><code>details</code></td>
        <td>56,60</td>
        <td>36,743</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Adoption of the <code>details</code> and <code>summary</code> elements.", sheets_gid="1406534257", sql_file="pages_element_count_by_device.sql") }}</figcaption>
</figure>

### Probability of element use

Taking another look at element popularity, how likely is it to find a certain element in the DOM of a page? Surely, `html`, `head`, `body` are present on every page (even though [their tags are all optional](https://meiert.com/en/blog/optional-html/)), making them common elements, but what other elements are to be found?

<figure markdown>
| Element | Probability |
|---|---|
| `title` | 99.34% |
| `meta` | 99.00% |
| `div` | 98.42% |
| `a` | 98.32% |
| `link` | 97.79% |
| `script` | 97.73% |
| `img` | 95.83% |
| `span` | 93.98% |
| `p` | 88.71% |
| `ul` | 87.68% |

<figcaption>{{ figure_link(caption="High probabilities of finding a given element in pages of the Web Almanac 2020 sample.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

Standard elements are those that are or were part of the HTML specification. Which ones are you really rarely to find? In our sample, that would bring up the following:

<figure markdown>
| Element | Probability |
|---|---|
| `dir` | 0.0082% |
| `rp` | 0.0087% |
| `basefont` | 0.0092% |

<figcaption>{{ figure_link(caption="Low probabilities of finding a given element in pages of the sample.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

We’re including these elements to give an idea what elements may have gone out of favor. But while `dir` and `basefont` were last specified in XHTML 1.0 (2000), the rare use of `rp`, which has been mentioned [as early as 1998](https://www.w3.org/TR/1998/WD-ruby-19981221/#a2-4) but which is also [still part of HTML](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element), may just suggest that Ruby markup is not very popular.

### Custom elements

The 2019 edition of the Web Almanac handled [custom elements](../2019/markup#custom-elements) by discussing several non-standard elements. This year, we found it valuable to have a closer look at custom elements. How did we determine these? Roughly by looking at [their definition](https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts), notably their use of a hyphen. Let's focus on the top elements, in this case elements used on ≥1% of all URLs in the sample:

{# TODO(authors, analysts): Clarify occurrences and percentages _of what_. Pages? Elements? #}

<figure markdown>
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

<figcaption>{{ figure_link(caption="The 14 most popular custom elements.", sheets_gid="770933671", sql_file="pages_element_count_by_device_and_custom_dash_elements.sql") }}</figcaption>
</figure>

These elements come from three sources: [Yandex Metrica](https://metrica.yandex.com/about) (`ym-`), an analytics solution we've also seen last year; [Slider Revolution](https://www.sliderrevolution.com/) (`rs-`), a WordPress slider, for which there are more elements to be found near the top of the sample; and [Wix](https://www.wix.com/) (`wix-`), a website builder.

{# TODO(authors, analysts): What do "cases" mean here: pages/elements? And for desktop or mobile? #}

Other groups that stand out include [AMP markup](https://amp.dev/) with `amp-` elements like `amp-img` (11,700 cases), `amp-analytics` (10,256) and `amp-auto-ads` (7,621), as well as [Angular](https://angular.io/) `app-` elements like `app-root` (16,314), `app-footer` (6,745), and `app-header` (5,274).

### Obsolete elements

There are more questions to ask about the use of HTML, and one may relate to obsolete elements, which are elements like `applet`, `bgsound`, `blink`, `center`, `font`, `frame`, `isindex`, `marquee`, or `spacer`.

In our mobile dataset of 6.3 million pages, around 0.9 million pages (14.01%) contain one or more of these elements. Here are the top 9, which are used more than 10,000 times:

<figure markdown>
| Element | Occurrences | Pages (%) |
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

<figcaption>{{ figure_link(caption="Obsolete elements with more than 10,000 uses.", sheets_gid="1972617631", sql_file="pages_element_count_by_device_and_obsolete_elements.sql") }}</figcaption>
</figure>

Even `spacer` is still being used 1,584 times, and present on every 5,000th page. We know that Google has been using a `center` element on [their homepage](https://www.google.com/) [for 22 years](https://web.archive.org/web/19981202230410/https://www.google.com/) now, but why are there so many imitators?

#### `isindex`

If you were wondering: The total number of [`isindex`](https://www.w3.org/TR/html401/interact/forms.html#edef-ISINDEX) elements in this dataset is: one. Exactly one page used an `isindex` element. It was part of the specs until [HTML 4.01 and XHTML 1.0](https://meiert.com/en/indices/html-elements/), yet only properly [specified](https://lists.w3.org/Archives/Public/public-whatwg-archive/2006Feb/0111.html) in 2006 (aligning with how it was implemented in browsers), and then [removed](https://github.com/whatwg/html/pull/1095) in 2016.

### Proprietary and made-up elements

In our set of elements we found some that were neither standard HTML (nor SVG nor MathML) elements, nor custom ones, nor obsolete ones, but somewhat proprietary ones. The top 10 that we identified are the following:

<figure markdown>
| Element | Pages (%) |
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

<figcaption>{{ figure_link(caption="Elements of questionable heritage.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

The source of these elements appears to be mixed, as in some are unknown while others can be traced. The most popular one, `noindex`, is probably due to [Yandex's recommendation](https://yandex.com/support/webmaster/adding-site/indexing-prohibition.html) of it to prohibit page indexing. `jdiv` was noted in [last year's Web Almanac](../2019/markup#products-and-libraries-and-their-custom-markup) and is from JivoChat. `mediaelementwrapper` comes from the MediaElement media player. Both `ymaps` and `yatag` are also from Yandex. The `ss` element could be from ProStores, a former ecommerce product from eBay, and `olark` may be from the Olark chat software. `h7` appears to be a mistake. `limespot` is probably related to the Limespot personalization program for ecommerce. None of these elements are part of a web standard.

### Headings

[Headings](https://html.spec.whatwg.org/multipage/dom.html#heading-content) make for a special category of elements that play an important role in [sectioning](https://html.spec.whatwg.org/multipage/dom.html#sectioning-content-2) and for [accessibility](https://www.w3.org/WAI/tutorials/page-structure/headings/).

<figure markdown>
| Heading | Occurrences | Average per page |
|---|---|---|
| `h1` | 10,524,810 | 1.66 |
| `h2` | 37,312,338 | 5.88 |
| `h3` | 44,135,313 | 6.96 |
| `h4` | 20,473,598 | 3.23 |
| `h5` | 8,594,500 | 1.36 |
| `h6` | 3,527,470 | 0.56 |

<figcaption>{{ figure_link(caption="Frequency and average use of standard heading elements.", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

You might have expected to only see the standard `<h1>` to `<h6>` elements, but some sites actually use more levels:

<figure markdown>
| Heading | Occurrences | Average per page |
|---|---|---|
| `h7` | 30,073 | 0.005 |
| `h8` | 9,266 | 0.0015 |

<figcaption>{{ figure_link(caption="Frequency and average use of non-standard heading elements.", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

The last two have never been part of HTML, of course, and should not be used.

## Attributes

This section focuses on how attributes are used in documents and explores patterns in `data-*` usage. Our findings show that `class` is the queen of all attributes.

### Top attributes

Similar to the section on the most [popular elements](#top-elements), this section delves into the most popular attributes on the web. Given how important the `href` attribute is for the web itself, or the `alt` attribute in order to make information [accessible](./accessibility), would these be most popular attributes?

<figure markdown>
| Attribute | Occurrences | Percentage |
|---|---|---|
| `class` | 2,998,695,114 | 34.23% |
| `href` | 928,704,735 | 10.60% |
| `style` | 523,148,251 | 5.97% |
| `id` | 452,110,137 | 5.16% |
| `src` | 341,604,471 | 3.90% |
| `type` | 282,298,754 | 3.22% |
| `title` | 231,960,356 | 2.65% |
| `alt` | 172,668,703 | 1.97% |
| `rel` | 171,802,460 | 1.96% |
| `value` | 140,666,779 | 1.61% |

<figcaption>{{ figure_link(caption="Top 10 attributes by frequency of use.", sheets_gid="1348855449", sql_file="pages_almanac_by_device_and_attribute_name_frequency.sql") }}</figcaption>
</figure>

The most popular attribute is `class`, with nearly 3 billion occurrences in our dataset and constituting 34% of all attributes in use. `class` is by far the most prevalent attribute.

The `value` attribute, which specifies the value of an `input` element, surprisingly completes the top 10. It's surprising to us because, subjectively, we didn't get the impression `value` attributes were used that frequently.

### Attributes on pages

Are there attributes that we find in every document? Not quite, but almost:

<figure markdown>
Element | Pages (%)
-- | --
href | 99.21%
src | 99.18%
content | 98.88%
name | 98.61%
type | 98.55%
class | 98.24%
rel | 97.98%
id | 97.46%
style | 95.95%
alt | 90.75%

<figcaption>{{ figure_link(
  caption="Top 10 attributes by page.",
  sheets_gid="1185369559",
  sql_file="pages_almanac_by_device_and_attribute_name_present.sql"
)}}</figcaption>
</figure>

These results raise some questions that we cannot answer. For example, `type` is used on other elements too, but why this tremendous popularity? Especially given that it's usually not needed to specify for style sheets or scripts, with CSS and JavaScript being assumed default. Or, how do we really fare with `alt`? Do those 9.25% of pages not contain any images or are they just inaccessible?

### `data-*` attributes

Per the HTML spec, [`data-*` attributes](https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes) "are intended to store custom data, state, annotations, and similar, private to the page or application, for which there are no more appropriate attributes or elements." How are they used? What are the popular ones? Is there anything interesting here?

The two most popular ones stand out because they are almost twice as popular than each of the attributes that followed (with >1% use):

<figure markdown>
| Attribute | Occurrences | Percentage |
|---|---|---|
| `data-src` | 26,734,560 | 3.30% |
| `data-id` | 26,596,769 | 3.28% |
| `data-toggle` | 12,198,883 | 1.50% |
| `data-slick-index` | 11,775,250 | 1.45% |
| `data-element_type` | 11,263,176 | 1.39% |
| `data-type` | 11,130,662 | 1.37% |
| `data-requiremodule` | 8,303,675 | 1.02% |
| `data-requirecontext` | 8,302,335 | 1.02% |

<figcaption>{{ figure_link(caption="The most popular <code>data-*</code> attributes.", sheets_gid="764700773", sql_file="pages_almanac_by_device_and_data_attribute_name_frequency.sql") }}</figcaption>
</figure>

Attributes like `data-type`, `data-id`, and `data-src` can have multiple generic uses although `data-src` is used a lot with lazy image loading via JavaScript (e.g., Bootstrap 4). [Bootstrap](https://getbootstrap.com/) again explains the presence of `data-toggle`, where it's used as a state styling hook on toggle buttons. The [Slick carousel plugin](https://kenwheeler.github.io/slick/) is the source of `data-slick-index`, whereas `data-element_type` is part of [Elementor's WordPress website builder](https://elementor.com/). Both `data-requiremodule` and `data-requirecontext`, then, are part of [RequireJS](https://requirejs.org/).

{# TODO(authors): Update this interpretation given that the lazy loading stat is in terms of pages, not img elements. #}
Interestingly, the use of native lazy loading on images is similar to that of `data-src`. 3.86% of pages use the `<img loading="lazy">` attribute. This appears to be growing very fast, as back in February, this number was about [0.8%](https://twitter.com/zcorpan/status/1237016679667970050). It's possible that these are being used together for a [cross-browser solution](https://addyosmani.com/blog/lazy-loading/).

## Miscellaneous

We've covered the use of HTML in general as well as the adoption of top elements and attributes. In this section, we're reviewing some of the special cases of viewports, favicons, buttons, inputs, and links. One thing we note here is that too many links still point to "http" URLs.

### `viewport` specifications

The [viewport](https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag) meta element is used to control layout on mobile browsers. While years ago, the motto was kind of "don't forget the viewport meta element" when building a web page, eventually this became a common practice and the motto changed to "make sure zooming and scaling are not disabled."

Users should be able to zoom and scale the text [up to 500%](https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large). That's why audits in popular tools like [Lighthouse](https://developers.google.com/web/tools/lighthouse) or [axe](https://www.deque.com/axe/) fail when `user-scalable="no"` is used within the `meta name="viewport"` element, and when the `maximum-scale` attribute value is less than `5`.

We had a look at the data and in order to better understand the results, we normalized it by removing spaces, converting everything to lowercase, and sorting by comma values of the `content` attribute.

<figure markdown>
| Content attribute value | Occurrences | Pages (%) |
|---|---|---|
| `initial-scale=1,width=device-width` | 2,728,491 | 42.98% |
| blank | 688,293 | 10,84% |
| `initial-scale=1,maximum-scale=1,width=device-width` | 373,136 | 5.88% |
| `initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width` | 352,972 | 5.56% |
| `initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width` | 249,662 | 3.93% |
| `width=device-width` | 231,668 | 3.65% |

<figcaption>{{ figure_link(caption="<code>viewport</code> specifications, and lack thereof.", sheets_gid="1414206386", sql_file="summary_pages_by_device_and_viewport.sql") }}</figcaption>
</figure>

The results show that almost half of the pages we analyzed are using the typical viewport `content` value. Still, around 10% of mobile pages are entirely missing a proper `content` value for the viewport meta element, with the rest of them using an improper combination of `maximum-scale`, `minimum-scale`, `user-scalable=no`, or `user-scalable=0`.

<p class="note">
  For a while now, the Edge mobile browser allows users to zoom into a web page to <a href="https://blogs.windows.com/windows-insider/2017/01/12/announcing-windows-10-insider-preview-build-15007-pc-mobile/">at least 500%</a>, regardless of the zoom settings defined by a web page employing the viewport meta element.
</p>

### Favicons

The situation around favicons is fascinating. Favicons work with or without markup—some browsers would fall back to [looking at the domain root](https://realfavicongenerator.net/faq#why_icons_in_root)—, accept several image formats, and then also promote several dozen sizes (some tools are reported to generate 45 of them; [realfavicongenerator.net](https://realfavicongenerator.net/) would return _37_ if requested to handle every case). As of this time of writing, there is an [open issue](https://github.com/whatwg/html/issues/4758) for the HTML spec to help improve the situation.

When we built our tests we didn't check for the presence of images, but only looked at the markup. That means, when you review the following, note that it's more about _how_ favicons are referenced rather than whether or how often they are used.

<figure markdown>
| Favicon format | Occurrences | Pages (%) |
|---|---|---|
| ICO | 2,245,646 | 35.38% |
| PNG | 1,966,530 | 30.98% |
| No favicon defined | 1,643,136 | 25.88% |
| JPG | 319,935 | 5.04% |
| No extension specified (no format identifiable) | 37,011 | 0.58% |
| GIF | 34,559 | 0.54% |
| WebP | 10,605 | 0.17% |
| … | | |
| SVG | 5,328 | 0.08% |

<figcaption>{{ figure_link(caption="Common favicon formats.", sheets_gid="1930085905", sql_file="pages_almanac_by_device_and_favicon_image_type.sql") }}</figcaption>
</figure>

There are a couple of surprises in here:

* Support for other formats is there but ICO is still the go-to format for favicons on the web.
* JPG is a relatively popular favicon format even though it may not yield the best results (or a comparatively large weight) for many favicon sizes.
* WebP is twice as popular as SVG! This might change, however, with [SVG favicon support](https://caniuse.com/link-icon-svg) improving.

### Button and input types

There has been a lot of [discussion](https://adrianroselli.com/2016/01/links-buttons-submits-and-divs-oh-hell.html) on buttons lately and how often they are misused. We looked into this to present findings on some of the native HTML buttons.

{{ figure_markup(
  caption="Percent of pages with button elements.",
  content="60.56%",
  classes="big-number",
  sheets_gid="410549982",
  sql_file="pages_markup_by_device.sql"
) }}

{# TODO(analysts): Where do these "occurrences" come from? Ideally we have a single sheet to link to with the results used by this table. #}
<figure markdown>
| Button types | Occurrences | Percentage |
|---|---|---|
| `<button type="button">` | 15,926,061 | 36.41% |
| `<button>` without type | 11,838,110 | 32.43% |
| `<button type="submit">` | 4,842,946 | 28.55% |
| `<input type="submit" value="…">` | 4,000,844 | 31.82% |
| `<input type="button" value="…">` | 1,087,182 | 4.07% |
| `<input type="image" src="…">` | 322,855 | 2.69% |
| `<button type="reset">` | 41,735 | 0.49% |

<figcaption>{{ figure_link(caption="Adoption of button types.", sheets_gid="410549982", sql_file="pages_markup_by_device.sql") }}</figcaption>
</figure>

Our analysis shows that about 60% of pages contain a button element and more than half of the pages (32.43%) have at least one button that fails to specify a `type` attribute. Note that the button element has a [default type](https://dev.w3.org/html5/spec-LC/the-button-element.html) of `submit`, so the default behavior of buttons on these 32% of pages is to submit the current form data. To avoid possibly unexpected behavior like this, a best practice is to specify the `type` attribute.

<figure markdown>
| Percentile | Buttons per page |
|---|---|
| 10 | 0 |
| 25 | 0 |
| 50 | 1 |
| 75 | 5 |
| 90 | 13 |

<figcaption>{{ figure_link(caption="Distribution of the number of buttons per page.", sheets_gid="309769153", sql_file="pages_markup_by_device_and_percentile.sql") }}</figcaption>
</figure>

Pages in the 10th and 25th percentiles contain no buttons at all, while a page in the 90th percentile contains 13 native `button` elements. In other words, 10% of pages contain 13 or more buttons.

### Link targets

The [anchor element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a), or `a` element, links web resources together. In this section, we analyze the adoption of the protocols included in these link targets.

<figure markdown>
| Protocol | Occurrences | Pages (%) |
|---|---|---|
| https | 5,756,444 | 90.69% |
| http | 4,089,769 | 64.43% |
| mailto | 1,691,220 | 26.64% |
| javascript | 1,583,814 | 24.95% |
| tel | 1,335,919 | 21.05% |
| whatsapp | 34,643 | 0.55% |
| viber | 25,951 | 0.41% |
| skype | 22,378 | 0.35% |
| sms | 17,304 | 0.27% |
| intent | 12,807 | 0.20% |

<figcaption>{{ figure_link(caption="Adoption of link target protocols.", sheets_gid="1963376224", sql_file="pages_wpt_bodies_by_device_and_protocol.sql") }}</figcaption>
</figure>

We can see how `https` and `http` are most dominant, followed by "benign" links to make writing email, making phone calls, and sending messages easier. `javascript` stands out as a link target that's still very popular even though JavaScript offers native and gracefully degrading options to work with.

### Links in new windows

{{ figure_markup(
  caption="Percent of pages having neither `noopener` nor `noreferrer` attributes on `target=\"_blank\"` links.",
  content="71.35%",
  classes="big-number",
  sheets_gid="1876528165",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

Using `target="_blank"` has been known to be a [security vulnerability](https://mathiasbynens.github.io/rel-noopener/) for some time now. Yet 71.35% of pages contain links with `target="_blank"`, without `noopener` or `noreferrer`.

<figure markdown>
| Elements | Pages |
|---|---|
| `<a target="_blank" rel="noopener noreferrer">` | 13.63% |
| `<a target="_blank" rel="noopener">` | 14.14% |
| `<a target="_blank" rel="noreferrer">` | 0.56% |

<figcaption>{{ figure_link(caption="Blank relationships.", sheets_gid="1876528165", sql_file="pages_wpt_bodies_by_device.sql") }}</figcaption>
</figure>

As a rule of thumb and for [usability reasons](https://www.nngroup.com/articles/new-browser-windows-and-tabs/), prefer not to use `target="_blank"` in the first place.

<p class="note">Within the latest Safari and Firefox versions, setting <code>target="_blank"</code> on <code>a</code> elements implicitly provides the same <code>rel</code> behavior as setting <code>rel="noopener"</code>. This is already <a href="https://chromium-review.googlesource.com/c/chromium/src/+/1630010">implemented in Chromium</a> as well and will land in Chrome 88.</p>

## Conclusion

We've touched on some observations throughout the chapter, but as a reflection on the state of markup in 2020, here are some things that stood out for us:

{{ figure_markup(
  caption="Percent of pages with a quirky doctype.",
  content="3.97%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

Fewer pages land in quirks mode. In 2016, that number was at [around 7.4%](https://discuss.httparchive.org/t/how-many-and-which-pages-are-in-quirks-mode/777). At the end of 2019, we observed [4.85%](https://twitter.com/zcorpan/status/1205242913908838400). And now, we're at about 3.97%. This trend, to paraphrase [Simon Pieters](./contributors#zcorpan) in his review of this chapter, seems clear and encouraging.

Although we lack historic data to draw the full development picture, "meaningless" `div`, `span`, and `i` markup has pretty much [replaced](#top-elements) the `table` markup we've observed in the 1990s and early 2000s. While one may question whether `div` and `span` elements are always used without there being a semantically more appropriate alternative, these elements are still preferable to `table` markup, though, as during the heyday of the old web, these were seemingly used for everything but tabular data.

Elements per page and element types per page stayed roughly the same, showing [no significant change](#element-diversity) in our HTML writing practice when compared to 2019. Such changes may require more time to manifest.

Proprietary product-specific elements like `g:plusone` (used on 17,607 pages in the mobile sample) and `fb:like` (11,335) have almost disappeared after still being [among the most popular ones](../2019/markup#products-and-libraries-and-their-custom-markup) last year. However, we observe more [custom elements](#custom-elements) for things like Slider Revolution, AMP, and Angular. Elements like `ym-measure`, `jdiv`, and `ymaps` are also still prevalent. What we imagine we're seeing here is that, under the sea of slowly changing practices, HTML is very much being developed and maintained, as authors toss deprecated markup and embrace new solutions.

Now, the [2019 Web Almanac Markup chapter](../2019/markup) had 14 years of catch up to do since the last major study on the topic, so you'd think we wouldn't have much to cover in the year since. Yet what we observe with this year's data is that there's a lot of movement at the bottom and near the shore of said sea of HTML. We approach near-complete adoption of living HTML. We are quick to prune our pages of fads like Google and Facebook widgets. We're also fast in adopting and shunning frameworks, as both Angular and AMP (though a "component framework") seem to have significantly lost in popularity, likely for solutions like React and Vue.

And still, there are no signs we exhausted the options HTML gives us. The median of 30 different elements used on a given page, which is roughly a quarter of the elements HTML provides us with, suggests a rather one-sided use of HTML. That is supported by the immense popularity of elements like `div` and `span`, and no custom elements to potentially meet the demands that these two elements may represent. Unfortunately, we couldn't validate each document in the sample; however, anecdotally and to be taken with caution, we learned that [79%](https://github.com/HTTPArchive/almanac.httparchive.org/issues/899#issuecomment-717856201) of W3C-tested documents have validation errors. After everything we've seen, it looks like we're still far from mastering the craft of HTML.

That compels us to close with an appeal: Pay attention to HTML. Focus on HTML. It's important and worthwhile to invest in HTML. HTML is a document language that may not have the charm of a programming language, and yet the web is built on it. Use less HTML and learn what's really needed. Use more appropriate HTML—learn what's available and what it's there for. And [validate](https://validator.w3.org/docs/why.html) your HTML. Anyone can write invalid HTML (just invite the next person you meet to write an HTML document and validate the output) but a professional developer can be expected to produce valid HTML. Writing correct and valid HTML is a craft to take pride in.

For the next edition of the Web Almanac's chapter, let's prepare to look closer at the craft of writing HTML and, hopefully, how we've been improving on it.

We're leaving this open to you. What are your observations? What has caught your eye? What do you think has taken a turn for the worse, and what has improved? [Leave a comment](https://discuss.httparchive.org/t/2039) to share your thoughts!
