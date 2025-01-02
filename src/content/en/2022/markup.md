---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Markup
description: Markup chapter of the 2022 Web Almanac covering document data (doctypes, compression, languages, HTML conformance, document size), the use of HTML elements and attributes, data attributes and social media.
hero_alt: Hero image of Web Almanac characters as dressed as constructor workers putting together a web page from HTML element blocks.
authors: [j9t]
reviewers: [bkardell, zcorpan]
analysts: [rviscomi]
editors: [tunetheweb]
translators: []
j9t_bio: Jens Oliver Meiert is an engineering lead and author (<a hreflang="en" href="https://leanpub.com/web-development-glossary"><cite>The Web Development Glossary</cite></a>, <a hreflang="en" href="https://www.amazon.com/dp/B094W54R2N/"><cite>Upgrade Your HTML</cite></a>), who works as an engineering manager at <a hreflang="en" href="https://www.liveperson.com/">LivePerson</a>. He specializes in HTML and CSS minimization and optimization. Jens regularly writes about the craft of web development on his website, <a hreflang="en" href="https://meiert.com/en/">meiert.com</a>.
results: https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/
featured_quote: Without HTML there are no web pages, no web sites, no web apps. You can say that without HTML, there's no Web. That makes HTML one of the most important web standards, if not the most important web standard.
featured_stat_1: 90%
featured_stat_label_1: Documents using the HTML doctype.
featured_stat_2: 30 KB
featured_stat_label_2: Median HTML document transfer size
featured_stat_3: 29%
featured_stat_label_3: Elements which are `div`s.
---

## Introduction

As the [2020 chapter said](../2020/markup#introduction), without HTML there are no web pages, no web sites, no web apps. You can say that without HTML, there's no Web. That makes HTML one of the most important web standards, if not the most important web standard.

Accordingly, like every year, we used the millions of pages in our data set—7.9 million in the mobile set, 5.4 million in the desktop set, with overlap—to also look at HTML. This chapter doesn't cover "everything" there is about HTML, so we explicitly encourage you to [also analyze the data we gathered](https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit) and to share your own conclusions—and when you do, tag them: [#htmlalmanac](https://x.com/hashtag/htmlalmanac).

## Document data

There's much to be curious about when it comes to how we write HTML. We can ask lots of questions, but when it comes to HTML in general, let's have a look at how our HTML is sent to our browsers, before we even get into the contents of the markup itself.

### Doctypes

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
        <td>`html`</td>
        <td class="numeric">88.1%</td>
        <td class="numeric">90.0%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd xhtml 1.0 transitional//en http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd`</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>No doctype</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">2.7%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd xhtml 1.0 strict//en http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd`</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd html 4.01 transitional//en http://www.w3.org/tr/html4/loose.dtd`</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd html 4.01 transitional//en`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Doctype usage.",
      sheets_gid="1535288056",
      sql_file="doctype.sql",
    ) }}
  </figcaption>
</figure>

Let's start with doctypes—which one is the most popular? But you know the answer to this one: It's the short, simple, boring standard HTML doctype, that is, `<!DOCTYPE html>`.

{{ figure_markup(
  content="90%",
  caption="Mobile using the standard HTML doctype.",
  classes="big-number",
  sheets_gid="1535288056",
  sql_file="doctype.sql",
) }}

90% of all mobile pages use it—as the mobile data set is largest, this chapter will usually work with that data. Next most popular is XHTML 1.0 Transitional (3.9%, [down from 4.6% in 2021](../2021/markup#doctypes)). After that it's no doctype being set at all at 2.7%, up from 2.5% last year.

### Compression

{{ figure_markup(
  image="content-encoding.png",
  caption="HTML document content encoding.",
  description="Stacked bar chart, showing 28% of desktop and mobile HTML documents are being compressed with Brotli, 58% of desktop and mobile documents are being compressed with Gzip, and 14% of desktop and 13% of mobile HTML documents are not being compressed at all.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1176900527&format=interactive",
  sheets_gid="1434175283",
  sql_file="content_encoding.sql",
) }}

Are HTML documents being compressed? How many? How? 86% of them are—with 58% (down 5.8% since last year) overall being gzip-compressed, and 28% (up 6.1%) being compressed using Brotli. Overall, slightly more documents are being compressed, and compressed more effectively.

### Languages

{{ figure_markup(
  image="html-languages.png",
  caption="Most popular regional HTML lang values.",
  description="Bar chart showing `en` is the language set on 22% of desktop and 19% of mobile pages, `(not set)` on 18% and 17% respectively, `en-us` on 16% and 13%, `ja` on 6% and 6%, `es` on 4% and 5%, `pt-br` on 2% and 3%, `en-gb` on 2% and 2%, `ru` on 2% and 2%, `de` on 2% and 2%, and `de-de` on 1% of desktop and 2% of mobile pages..",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=677908280&format=interactive",
  sheets_gid="1194853402",
  sql_file="lang.sql",
  width=600,
  height=511
) }}

What about languages? In our data set, 35% of pages used a `lang` attribute mapping to English; 17% had no language set; and you already see the difficulties—the sample is likely biased and also not as big as to reflect all of the world, and no `lang` attribute being used is not equaling no language being set so, this isn't something our data would be useful for.

### Conformance

Do documents conform with the HTML specification—i.e., are they valid? A quick way for you to tell is by using a tool like the <a hreflang="en" href="https://validator.w3.org/">W3C markup validation service</a>.

We didn't and we couldn't check this yet. So why include this section?

The reason to at least mention conformance is that if you don't check on conformance, if you don't validate, there's a good chance—in practice, <a hreflang="en" href="https://meiert.com/en/blog/valid-html-2022/">effectively a 100% chance</a>—you end up writing at least some fictitious and fantasy (and therefore wrong) HTML. But HTML isn't fiction or fantasy—it's a hard technical standard with clear rules on what works and what doesn't.

For a professional, it's good to know these rules. It's good work to produce code that works and that doesn't contain anything superfluous, too. And both of that—learning and not shipping anything non-working or superfluous—is why conformance matters, and why validation matters.

We don't have conformance data to share in the Web Almanac yet, but that doesn't mean the point is any less important. And if you haven't focused on conformance yet—start validating your HTML output. Maybe one of the next editions of the Web Almanac will have some positive news to share because of you.

### Document size

HTML payload and document size are a staple in this series—we've looked at this information since 2019. But the trend is clear, and while it follows a common theme that other chapters will confirm, too, it's not a great one:

{{ figure_markup(
  image="html-document-transfer-size.png",
  caption="Median transfer size of HTML document.",
  description="Column chart showing the transfer size of the median HTML document is trending upwards. In 2019 it was 27 KB on desktop, and 26 KB on mobile, in 2020 it fell slightly to 26 KB and 25 KB respectively, but in 2021 it increased again to 29 KB and 27 KB, and in 2022 it's the largest yet at 31 KB on desktop and 30 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=381017848&format=interactive",
  sheets_gid="1090657426",
  sql_file="document_trends.sql",
) }}

After some brief relief in 2020, document size has continued growing in 2021, and again in 2022, with a median transfer size of 30 kB in our mobile data set.

One way to counter this trend is to <a hreflang="en" href="https://css-tricks.com/write-html-the-html-way-not-the-xhtml-way/">write HTML, the HTML way (and not the XHTML way)</a>, as that would already result in smaller HTML transfer size. _Disclosure: Your author here likes to come up with HTML writing classifications, and enjoys promoting minimal HTML._

## Elements

If you're not including the `svg` and `math` elements—because they're specified outside of HTML—the current HTML specification currently consists of 111 elements.

<aside class="note">Elements, not tags, because we're not referring to mere start or end tags, like `<li>` or `</ins>`. And some people count HTML elements differently, but most important is to <a hreflang="en" href="https://meiert.com/en/blog/the-number-of-html-elements/">be clear about how you're counting</a>.</aside>

What can we observe?

### Element diversity

{{ figure_markup(
  image="element-count-distribution.png",
  caption="Distribution of distinct elements per page.",
  description="Column chart showing the count of distinct elements per page at common percentiles. Desktop and mobile are near identical with 22 elements at the 10th percentile, 27 at the 25th, 32 at the 50th percentiles, 39 for desktop and 38 for mobile at the 75th percentile, and 45 at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=2146886292&format=interactive",
  sheets_gid="1201800477",
  sql_file="element_count_distribution.sql",
) }}

The first thing we can note is that developers use slightly more different elements per page now, with a median of 32 different elements per document.

The median is up from [31 elements in 2021](../2021/markup#element-diversity), and [30 elements in 2020](../2020/markup#element-diversity). As this is a trend throughout, it may be a tender sign that developers put HTML elements to better use, by using more of them for what they're there for.

Alas, there's another trend which aligns with an increasing document size, and that's a growing number of elements per page in total:

{{ figure_markup(
  image="element-count-distribution.png",
  caption="Distribution of elements per page.",
  description="Column chart showing the count of elements per device at common percentiles. For desktop it's 177 elements at 10th percentiles, 394 at the 25th percentiles, 711 at the 50th percentile, 1,220 at the 75th percentile, and 2,023 at the 90the percentile. Mobile trends the same but at at smaller amounts: 192, 371, 653, 1,104, and 1,832 respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1598321449&format=interactive",
  sheets_gid="1201800477",
  sql_file="element_count_distribution.sql",
) }}

The median is currently at 653 elements per page, up from 616 in 2021, and 587 in 2020—all per the respective mobile data set. Do we publish more content, requiring more elements to hold them (something like, more paragraphs per text, more `p` elements)? Or is this just another sign of an unchecked `div` pandemic? Our data doesn't answer this but it is probably due to both—and more—reasons.

### Top elements

The following elements are used most frequently:

<figure>
  <table>
    <thead>
      <tr>
        <th>2019</th>
        <th>2020</th>
        <th>2021</th>
        <th>2022</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`div`</td>
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
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
      </tr>
      <tr>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
      </tr>
      <tr>
        <td>`img`</td>
        <td>`img`</td>
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`option`</td>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td></td>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`i`</td>
      </tr>
      <tr>
        <td></td>
        <td>`option`</td>
        <td>`i`</td>
        <td>`meta`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most used elements.",
      sheets_gid="571472591",
      sql_file="element_frequency.sql",
    ) }}
  </figcaption>
</figure>

The `div` element is—by far—the most popular element: We found 2,123,819,193 occurrences in the mobile data set, and 1,522,017,185 of them in our desktop data set.

{{ figure_markup(
  content="29%",
  caption="Percentage of elements which are `div` elements.",
  classes="big-number",
  sheets_gid="571472591",
  sql_file="element_frequency.sql",
) }}

[Divitis](https://en.wiktionary.org/wiki/divitis) is real.

If you wonder about the odd one out, [the `i` element](https://developer.mozilla.org/docs/Web/HTML/Element/i), it stands to reason that this is still largely due to <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a> and its arguable misuse of this element. The element has also a bad reputation because during XHTML times, everyone suggested to use `em` instead—but that advice wasn't sound, and <a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-i-element">`i` elements have their use cases</a>.

When it comes to what elements are being used on the most documents, the list looks a little different:

{{ figure_markup(
  image="adoption-of-top-html-elements.png",
  caption="Adoption of top HTML elements.",
  description="Bar bar chart showing `html` is used on 99.3% of desktop  and 99.4% of mobile page, `head` on 99.3% and 99.4% respectively, `body` on 99.1% and 99.2%, `title` on 98.9% and 99.0%, `meta` on 98.5% and 98.9%, `div` on 98.3% and 98.5%, `a` on 98.0% and 98.1%, `link` on 97.8% and 98.0%, `script` on 97.6% and 97.8%, `img` on 95.9% and 96.1%, `span` on 94.2% and 94.7%, `p` on 89.9% and 90.0%, `ul` on 88.8% and 88.7%, and finally `li` on 88.7% of desktop and 88.6% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=714125011&format=interactive",
  sheets_gid="2057119066",
  sql_file="element_popularity.sql",
  width=600,
  height=656
) }}

It's not a surprise that nearly every document uses `html`, `head`, or `body` tags—they are automatically inserted in the DOM and that is what is being counted here. That the numbers are slightly less than 100% is due to a small number of pages that break detection by overriding the JavaScript APIs we use—for example, <a hreflang="en" href="https://mootools.net/">MooTools</a> overriding the `JSON.stringify()` API.

It's a lot more surprising to miss `title` on 1% of all sampled documents—this element is not optional, and not being inserted in the DOM, and its omission an indicator for lack of conformance checking.

The elements that then follow are old friends—especially `a`, `img`, and `meta` have been popular elements ever since <a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">Ian Hickson's seminal HTML study back</a> in 2005.

What's the least used HTML element that's part of the current standard, you ask? That's <a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-samp-element">`samp`</a>, with a mere 2,002 findings in our mobile set.

### Custom elements

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts">Custom elements</a>—elements we can loosely identify by their inner-name use of a hyphen—also made it into our samples again. This year, however, the Top 10 is entirely dominated by <a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a>:

<figure>
  <table>
    <thead>
      <tr>
        <th>Custom element</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`rs-module-wrap`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-module`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-slides`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-slide`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-sbg-wrap`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-sbg-px`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-sbg`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-progress`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-layer`</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`rs-mask-wrap`</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most used custom elements.",
      sheets_gid="2057119066",
      sql_file="element_popularity.sql",
    ) }}
  </figcaption>
</figure>

That's impressive—but gives us little to work with other than saying that Slider Revolution is used on roughly 2% of all sampled pages.

What are the next popular custom elements that are not part of Slider Revolution?

<figure>
  <table>
    <thead>
      <tr>
        <th>Custom element</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`pages-css`</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`wix-image`</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`router-outlet`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>`wix-iframe`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>`ss3-loader`</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most used custom elements not starting with `rs-`.",
      sheets_gid="2057119066",
      sql_file="element_popularity.sql",
    ) }}
  </figcaption>
</figure>

This is more diverse: `pages-css`, `wix-image` and `wix-iframe` come from the Wix website builder. `router-outlet` originates in Angular. And `ss3-loader` seems to be related to Smart Slider.

### Obsolete elements

Are obsolete elements still a thing? Given that not-validating is still a thing, yes.

{{ figure_markup(
  image="obsolete-elements.png",
  caption="Obsolete elements.",
  description="Bar chart showing `center` is used on 6.3% of desktop and 6.1% of mobile pages, `font` is used on 5.7% and 5.4% pages respectively, `marquee` on 0.8% and 1.0%, `nobr` on 0.5% and 0.4%, and finally `big` 0.4% of desktop and mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=2039309980&format=interactive",
  sheets_gid="69619977",
  sql_file="obsolete_elements.sql",
) }}

On 6.1% of pages, you still find `center` elements (hi <a hreflang="en" href="https://www.google.com/">Google home page</a>), and on 5.4% of pages, you find `font` elements. Use of both elements went down (down 0.5% in both cases), fortunately, while `marquee`, `nobr`, and `big` didn't witness significant changes.

`center` and `font` make for the lion's share (81.2%) of all obsolete elements, per our analysis:

{{ figure_markup(
  image="obsolete-elements-relative-use.png",
  caption="Obsolete elements relative use.",
  description="Pie chart showing `center` is 43.0% of obsolete element usage on mobile, `font` is 38.2%, `marquee` is 7.0%, `nobr` 2.6%, `big` 2.6%, `frame` 1.5% and the rest of the pie is made up of unlabelled other elements.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1875548366&format=interactive",
  sheets_gid="69619977",
  sql_file="obsolete_elements.sql",
) }}

## Attributes

If elements are the bread of HTML, then attributes are the butter. What can we learn here?

### Top attributes

The most popular attribute, by far, was and still is `class`:

{{ figure_markup(
  image="attribute-usage.png",
  caption="Attribute usage.",
  description="Bar chart showing `class` is 34% of attribute usage on both mobile and desktop, `href` is 10% of usage on desktop and 9% on mobile, `style` is 5% on both, `id` is 5% on both, `src` is 4% on both, `type` is 3% on both, `title` is 2% on both, `alt` is 2% on both, `rel` is 2% on both, and finally `value` is 1% on both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=143284257&format=interactive",
  sheets_gid="1979652187",
  sql_file="attributes.sql",
  width=600,
  height=558
) }}

This order isn't any different from what we've seen last year, but there are some changes:

- `class` (<span class="numeric-bad">▼0.3%</span>), `href` (<span class="numeric-bad">▼0.9%</span>), `style` (<span class="numeric-bad">▼0.6%</span>), `id` (<span class="numeric-bad">▼0.2%</span>), `type` (<span class="numeric-bad">▼0.1%</span>), `title` (<span class="numeric-bad">▼0.3%</span>), and `value` (<span class="numeric-bad">▼0.5%</span>) are all used a little less than before.
- `src` (<span class="numeric-good">▲0.3%</span>) and `alt` (<span class="numeric-good">▲0.1%</span>) are used more than before—tentatively good news for accessibility!
- `rel` usage hasn't changed significantly.

Are there attributes we find on (nearly) every document? Yes:

{{ figure_markup(
  image="attribute-usage.png",
  caption="Attribute usage by page.",
  description="Bar chart showing `href` is used on 99% of desktop and mobile pages, `src` on 99% of both, `content` on 98% of desktop and 99% of mobile, `name` on 98% and 99% respectively, `type` on 98% of both, `class` on 98% of both, `rel` on 98% of both, `id` on 97% and 98% of mobile, `style` on 96% of both, and finally `alt` is used on 91% of both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=143284257&format=interactive",
  sheets_gid="1979652187",
  sql_file="attributes.sql",
  width=600,
  height=558
) }}

`href`, `src`, `content` (metadata), and `name` (metadata, form identifiers) are present on nearly every document in our sample.

### `data-*` attributes

For <a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">`data-*` attributes</a>—which allow authors to embed their own custom metadata—we also pulled new information.

This changed only little compared to [last year's `data-*` attributes stats](../2021/markup#data--attributes). Here are some changes to call out:

- `data-id` is still the most popular `data-*` attribute, with a 0.7% increase compared to 2021.
- `data-element_type`, though its position stayed the same, gained 0.7% as well.
- `data-testid` ranked #6 before, gained 0.3%, and jumped to #4.
- `data-widget_type` ranked #8, gained 0.4% popularity, and also gained two spots, taking #6 in 2022.

`data-element_type` and `data-widget_type` relate to <a hreflang="en" href="https://developers.elementor.com/">Elementor</a>, while data-testid is coming from <a hreflang="en" href="https://testing-library.com/">Testing Library</a>.

Let's have a look at how often we find `data-*` attributes on our pages:

{{ figure_markup(
  image="data-attribute-popularity.png",
  caption="Data attribute popularity.",
  description="Barchart showing `data-toggle` is used on 23% of desktop and 22% of mobile pages, `data-src` on 20% and 20% respectively, `data-target` on 20% and 20%, `data-id` on 18% and 19%, `data-type` on 15% and 15%, `data-href` on 9% and 10%, `data-fbcssmodules` on 10% and 10%, `data-slick-index` on 10% and 9%, `data-google-container-id` on 10% and 9%, and finally `data-load-complete` is used on on 10% of mobile and 9% of desktop pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1008069119&format=interactive",
  sheets_gid="1727867391",
  sql_file="data_attributes.sql",
  width=600,
  height=558
) }}

Their popularity is high! Per the chart above close to every fourth document uses `data-*` attributes. But the overall data show that 88% of documents use at least one `data-*` attribute.  That's quite some adoption.

### Social markup

Last year's edition introduced [a section on social markup](../2021/markup#social-markup), special markup which makes it easier for social platforms to identify and display the respective metadata. Here's the 2022 update:

{{ figure_markup(
  image="social-meta-nodes-usage.png",
  caption="Social meta nodes usage.",
  description="Barchart showing `og:title` is on 56% of desktop and 57% of mobile pages, `og:url` on 53% and 54% respectively, `og:type` on 51% and 51%, `og:description` on 50% and 50%, `og:site_name` on 45% and 45%, `twitter:card` on 40% and 39%, `og:image` on 39% and 39%, `og:locale` on 28% and 29%, `twitter:title` on 24% and 23%, and finally `twitter:description` on 21% of both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=429652195&format=interactive",
  sheets_gid="1925328234",
  sql_file="meta_node_names.sql",
  width=600,
  height=604
) }}

Do you need all of this metadata? That depends on your requirements. But if these requirements are about showing title, description, and image, you don't seem to need nearly as much. You may be able to do with `twitter:card`, `og:title`, `og:description` (hooked up to standard `description` metadata), and `og:image`. The author and many others have described options for <a hreflang="en" href="https://meiert.com/en/blog/minimal-social-markup/">minimal social markup</a>.

## Conclusion

This was a glance at HTML in 2022.

The conclusion is brief: Going from year to year, it's hard to say what important trends were started or reversed. Document size seems to keep growing—at least from 2020 to 2021 to 2022. The number of elements per page goes up every year too. There may be slightly more `alt` attributes now, but that's relative to itself and we can't tell whether more images now do have an appropriate `alt` attribute set—nor whether its text is really <a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#alt">meaningful</a>.

But with all of this, the Web Almanac will help. We're going to look at HTML again—next year, the year after next, and the year after that. And we'll go into more detail again and we'll look back at more years.

What perhaps we'll also be able to do is to look at conformance too. Not everyone may care about this at this time in our field. But we're all professionals, and it seems at least relevant to know whether overall, we produce work that corresponds to <a hreflang="en" href="https://html.spec.whatwg.org/multipage/">the underlying standard(s)</a>. After all, this shouldn't be a chapter about fantasy HTML—it should be one about HTML that actually works. It's one of the most important web standards.
