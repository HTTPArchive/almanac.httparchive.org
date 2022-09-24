---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Fonts
#TODO - Review and update chapter description
description: Fonts chapter of the 2022 Web Almanac covering where fonts are loaded from, font formats, font loading performance, variable fonts and color fonts.
authors: [bramstein]
reviewers: [RoelN, svgeesus, jmsole]
analysts: [konfirmed]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
unedited: true
---

# Introduction

We've come a long way since the early days of web fonts. We went from a handful of web-safe fonts to a typographic explosion of hundreds of thousands web fonts. The technology and ease of use is almost unrecognizable: from elaborate "bullet-proof" font loading strategies with several font formats to simply including a WOFF2 file.

And it shows. Web font usage continues to grow. In the 2020 fonts chapter, 82% of all (desktop) sites used web fonts. In the two years since then, usage has increased to about 84%. The numbers are slightly lower for mobile, but represents a similar growth.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1021821560&format=interactive",
  sheets_gid="1517999851",
  sql_file="TODO.sql"
  )
}}

While we've made tremendous progress we're not quite there yet. Large percentages of the world's population can't use web fonts because their writing systems are either too large or too complex to be delivered as a (small) web font. Fortunately, the W3C Fonts Working Group is working hard on the <a hreflang="en" href="https://www.w3.org/TR/IFT/">Incremental Font Transfer</a> web standard that will hopefully solve this.

There was no font chapter in 2021, but we  hope we can make up for that this year. We took a slightly different angle this year by taking a closer look at what is inside font files and how fonts are used in CSS. We of course also returned to the "classics" such as services, font-display, and resource hints usage. Finally, we wrap up the chapter with two special focus sections on variable and color fonts, because we think they are great (and nobody stopped us).

# Performance

Surprisingly, not a lot has changed in the types of fonts served. About 75% of all font files are served as <a hreflang="en" href="https://www.w3.org/TR/WOFF2/">WOFF2</a>, about 12% as WOFF and the remainder as either octet-stream or ttf (and then a whole bunch of random MIME types). This is fairly similar to the results in the 2020 fonts chapter. Fortunately, SVG and EOT font usage has almost disappeared completely.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1637212263&format=interactive",
  sheets_gid="510414604",
  sql_file="TODO.sql"
  )
}}

As noted in 2019, 2020, and—if there had been a fonts chapter—in 2021 as well: WOFF2 offers the best compression and should be the preferred format. In fact, we think it is also time to proclaim:

> Use only WOFF2 and forget about everything else.

This will simplify your CSS and workflow massively and also prevents any accidental double or incorrect font downloads. WOFF2 is now<a hreflang="en" href="https://caniuse.com/woff2"> supported everywhere</a>. So, unless you need to support _really _ancient browsers, just use WOFF2. If you can't, consider not serving any web fonts to those older browsers at all. This will not be a problem if you have a robust fallback strategy in place. Visitors on older browsers will simply see your fallback fonts.

## Hosting

Where do people get their fonts? Do they self host, or use a web font service? Both? Let's take a look at the numbers.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

In general, it is a mixture: 67% self host _and_ use a service. Only 19% only use self hosting exclusively. We expect this number to go up in the coming years for two reasons: there is no longer a performance benefit to using a hosted service after the introduction of <a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">cache partitioning</a>, and <a hreflang="en" href="https://www.theregister.com/2022/01/31/website_fine_google_fonts_gdpr/">European courts are slowly becoming highly skeptical of European-based companies using Google Fonts</a>.

We can further split this data by service. Perhaps not surprisingly, <a hreflang="en" href="https://fonts.google.com/">Google Fonts</a> is the most popular web font service with nearly 65% of all web pages using it. Free is hard to beat indeed.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The next runner-up is the <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a> web service, which is used on nearly 7% of sites. That is an amazing achievement with only a single font family! In third place is the <a hreflang="en" href="https://fonts.adobe.com/">Adobe Fonts</a> web service, which is used on 4.2% of sites. Trailing far behind are the <a hreflang="en" href="https://www.fonts.com/">Fonts.com</a> and <a hreflang="en" href="https://www.typography.com/webfonts">Cloud.Typography</a> services, both present on 0.2% of sites.

Looking back at previous years, we can see that Google Fonts usage declined for the first time this year! It's hard to say if this is due to the aforementioned cache partitioning, GDPR, or something else entirely. The decline is only slight, so it will be interesting to see if the trend continues next year.

In contrast, both Font Awesome and the Adobe Fonts service grew significantly over the last few years. Font Awesome service usage grew 86% from 2019 to 2022, while Adobe Fonts usage grew by 24% in the same period.

Note that the services data is measured differently compared to the 2020 and 2019 font chapters. Those chapters looked at the number of requests to a service, whereas the 2022 data looks at pages using the services. Thus the data in 2022 is more accurate as it isn't influenced by the number of fonts loaded on a site. For example, the drop in Google Fonts usage noted in the 2020 chapter was most likely caused by Google Fonts switching to variable fonts and thereby significantly reducing the number of requests to their service.

## File sizes

Compression is a great way to reduce the amount of data that needs to be downloaded, but it has its limits. To better understand what influences font file sizes, let's take a look at the median font sizes across all fonts.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The median font size is about 20 kilobytes. That is pretty good. However, as we have seen earlier, font services account for nearly 70% of all font requests. Services like Google Fonts and Adobe Fonts have teams dedicated to optimizing the fonts as much as possible, so the median font sizes are likely heavily skewed by these services.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

Looking at self-hosted font sizes paints a quite different picture. The median font size nearly doubles to about 40 kilobytes. What is going on here? If we revisit the chart of popular web font MIME types, and remove all requests coming from web font services we get some insight into what might be going on.

A lot of websites using self-hosted fonts are still using WOFF instead of WOFF2. It's not clear if the fonts on these sites were never updated since WOFF2 was introduced, or if not enough developers know about WOFF2. Regardless, it's an easy optimization that could benefit a lot of sites.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

However, the difference in median font size between services and self-hosted is too large to be explained by a lower usage of WOFF2. While WOFF2 offers excellent compression, compression alone does not explain the large difference in median font sizes. The web font services must be performing other types of optimizations that aren't being done (enough) for self hosted fonts. To find the answer, we'll need to take a look at the insides of a font.

## OpenType table sizes

A typical font is essentially a tiny relational database with each table storing data like glyph shapes, glyph relationships, and metadata. For example, there are tables to store the vector Bézier curves that make up glyphs. There are also tables for relating glyphs to one another, that store things like kerning and ligature relationships (i.e. swap these two glyphs with this one when they are used together, like the famous _fi_ ligature).

A reasonable way to measure how much of an impact a table has on overall file size is to multiply its median size by the number of fonts that include that table.

<figure>
  <table>
    <thead>
      <tr>
        <th>OpenType table</th>
        <th>Impact</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>glyf (vector shapes)</code></td>
        <td class="numeric">79.6%</td>
      </tr>
      <tr>
        <td><code>CFF (vector shapes)</code></td>
        <td class="numeric">4.9%</td>
      </tr>
      <tr>
        <td><code>GPOS (positioning relationships)</code></td>
        <td class="numeric">4.7%</td>
      </tr>
      <tr>
        <td><code>hmtx (horizontal metrics)</code></td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td><code>post (metadata)</code></td>
        <td class="numeric">2.2%</td>
        </tr>
      <tr>
        <td><code>name (name metadata)</code></td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td><code>cmap (maps character codes to glyphs)</code></td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td><code>fpgm (font program)</code></td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td><code>kern (kerning data)</code></td>
        <td class="numeric">0.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Impact (median file size × number of requests as percentage of total).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

The top ten highest impact tables starts with the `glyf`, `CFF`, `GPOS`, and `hmtx` tables. These contain the data for the Bézier curves that make up the outlines of all glyphs (`glyf` and CFF), OpenType positioning features (GPOS) and horizontal metrics (`hmtx`). This is great because these tables are directly related to the number of glyphs in the font. Reduce the number of glyphs in the font by removing glyphs you don't need and you will dramatically reduce its file size.

Figuring out <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-subsetting.html">what you need and what you don't need</a> is the hard part though. You might accidentally remove glyphs, or break OpenType features that you need to render text correctly. Instead of subsetting manually using, for example, <a hreflang="en" href="https://fonttools.readthedocs.io/en/latest/subset/index.html">font tools</a>, you can use tools like <a hreflang="en" href="https://github.com/Munter/subfont">subfont</a> or <a hreflang="en" href="https://github.com/zachleat/glyphhanger">glyphhanger</a> to automatically create a "perfect" subset based on the content on your site. However, be mindful that the license of your font permits such modifications.

It is interesting to note that the `name` and `post` tables are in the top 10. These two tables primarily contain metadata that is important for desktop fonts, but not necessary for web fonts. This is an indication a lot of web fonts contain metadata that can be stripped without consequences, such as name table entries, glyph names in the post table, non-Unicode cmap entries, etc. We would love to see a universal set of recommendations (or even a <a hreflang="en" href="https://pmt.sourceforge.io/pngcrush/">pngcrush</a>-like tool) that can be used by foundries and web developers to remove every last unnecessary byte from a web font.

## Outline formats

You might have noticed the OpenType sizes table contains two entries for vector glyph outline data: `glyf` and `CFF`. There are actually four competing ways to store vector outlines in OpenType: TrueType (`glyf`), Compact Font Format (`CFF`), Compact Font Format 2 (`CFF2`), and Scalable Vector Graphics (`OT-SVG`; not to be confused with the old SVG font format). There are also three image based formats—we will talk about two of them in the color fonts section.

The OpenType specification is what you could charatibly call "a compromise". Several competing approaches to do mostly the same thing were added to the specification because there was no consensus. If you're interested in how this came to be, <a hreflang="en" href="https://www.pastemagazine.com/design/adobe/the-font-wars/">The Font Wars</a> by David Lemon are a great read. We'll see this pattern of competing approaches repeated again and again in the sections on variable and color fonts (though with different actors). At the end of the day, having multiple ways to store vector outlines mostly works, but it does place a heavy additional burden on type designers and implementations (not to mention increasing the attack surface area for exploits).

Type designers can choose the outline format they prefer. Looking at the distribution of outline formats, it is pretty clear what type designers have chosen. The overwhelming majority (91%) of fonts use the `glyf` outline format, while 9% use the `CFF` outline format. There is some `OT-SVG` color font usage as well, but less than 1% (not pictured).

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The OpenType specification lists <a hreflang="en" href="https://docs.microsoft.com/en-us/typography/opentype/otspec191alpha/glyphformatcomparison_delta">the differences between glyf and CFF</a>:

* The `glyf` format uses quadratic Bézier curves while CFF (and CFF2) uses cubic Bézier curves. This matters to some type designers, but not to users of the font.
* The `glyf` format has more control over hinting (making small adjustments so that the glyph outlines snap to the correct pixels at smaller sizes) while `CFF` has most of its hinting built into the text rasterizer.
* The `CFF` format claims to be a more efficient format, resulting in smaller font sizes.

The last claim is interesting. Is CFF smaller? On average, CFF does indeed produce a smaller table size. However, the reality is more nuanced, as it doesn't take compression into account (the table sizes are recorded after the font has been uncompressed).

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

As can be seen in the <a hreflang="en" href="https://www.w3.org/TR/2016/NOTE-WOFF20ER-20160315/#brotli-adobe-cff">WOFF2 evaluation report</a>, the median `glyf` compression is at 66% while the median `CFF` compression is at 50% (from uncompressed to compressed using WOFF2). Applying compression paints a very different picture. The median file size differences are negligible, and large fonts are much smaller when using `glyf` outlines!

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

In other words, even if `CFF` starts out smaller, it compresses much less than `glyf`, so it all evens out in the end. In fact, for larger files, it appears using the `glyf` format produces smaller sizes.

## Resource hints

Resource hints are special instructions to the browser to load or render a resource  before it normally would. Browsers normally only load web fonts when they know a font is used on the page. In order to know that, it needs to have parsed both the HTML and CSS. However, if you, as a web developer, _know_ that a font will be used, you can use resource hints to tell the browser to load fonts much earlier.

There are several types of resource hints that are relevant to web fonts: `dns-prefetch`, `preconnect`, and `preload` (in order of the lowest to highest impact). Ideally you would like to preload your most important fonts, but depending on where they are hosted that may not always be possible.

There hasn't been any large change in the use of `dns-prefetch` hints since 2020, but there has been a fairly significant increase in the use of `preload` (from 17% in 2020 to 20% in 2022) and `preconnect` (from 8% in 2020 to 15% in 2022). This is great!

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

As [mentioned in the 2020 chapter](../2020/fonts#resource-hints), preload and preconnect resource hints have the **single largest impact on your font loading performance**. In most cases it is as simple as adding a link element to your head. For example, if you use Google Fonts:

```html
<link rel="preconnect" href="https://fonts.gstatic.com">
```

If you self-host your fonts you can go even further and provide hints to the browser to preload your most important fonts (i.e. your primary text font.) That way the browser can load it early and it will likely be available when text rendering starts.

## Font-display

For many years most browsers did not render text until web fonts had loaded. On slow connections, this would often result in several seconds of invisible text even though the text content had already loaded. This behavior is called _block_, because it blocks rendering of the text. Other browsers showed fallback fonts right away and swapped them when the web font loaded. When a fallback font is replaced by a web font, this is called _swap_.

To give web developers more control over font loading, the `font-display` descriptor was introduced to tell the browser how it should behave while web fonts are loading. It defines four different values of what to do while fonts are loading. These values are implemented using different combinations of _block_ and _swap_ behavior.

* `swap`: block for a very short period and always swap.
* `block`: block for a short period and always swap.
* `fallback`: block for a very short period and swap within a short period.
* `optional`: block for a very short period and no swap period.

There is also `auto`, which leaves the decision up to the browser (all modern browsers use `block` as the default value).

Use of `font-display: swap` has grown to an impressive 30% (from 11% in 2020). A fair chunk of this increase can most likely be attributed to <a hreflang="en" href="https://www.google.com/url?q=https://www.youtube.com/watch?v%3DYJGCZCaIZkQ%26t%3D1880s&sa=D&source=docs&ust=1662119120147197&usg=AOvVaw3yrrdDd1irsg4yHKjseYvL">Google Fonts making swap the recommended value in 2019</a>. It is also interesting to see the `block` value overtaking `auto` as the second most used value. We are not sure why developers are intentionally degrading the performance of their site, but it is an interesting, if not slightly worrying, development.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

Our guess is that developers (or their customers) really dislike seeing a flash of fallback fonts. Using `font-display: block` is an easy "fix" for that problem. However, there is a better solution on the horizon. In the near future you can use CSS font metric overrides to tweak your fallback fonts to approximate the metrics of your web fonts. This will reduce the jarring reflow of text when a fallback font is swapped with a web font.

The CSS `ascent-override`, `descent-override`, `line-gap-override`, and `size-adjust` descriptors go into the `@font-face` rule and can be used to override the metrics in any font. You can use these descriptors with `local()` to [create a customized fallback](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/ascent-override#overriding_metrics_of_a_fallback_font) font that roughly matches your web font (hey, finally a good use for <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">`local()`</a>).

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

These `@font-face` descriptors are very new, but are already seeing some use. To make them _even_ more useful developers need two things:

1. A set of consistent fallback fonts that are available in all browsers and on all platforms. They could even be variable fonts. Imagine the possibilities.
2. Tools to automatically match fonts by tweaking its size and metrics. Doing this by hand is very time-consuming, so a tool is a must. This is not intended as a replacement for the web font, but merely as a temporary fallback while the web fonts are loading (or as a standin if the fonts don't load or the browser is very old).

We're slowly getting there with tools such as the <a hreflang="en" href="https://meowni.ca/font-style-matcher/">Font Style Matcher</a>, but unfortunately, fallback fonts are still very much platform dependent.

# Font usage

Performance is important, but it is also interesting to see how fonts are being used on the web. For example, what are the most popular fonts and foundries? Are people using OpenType features? Let's take a look at the data.

## Families & foundries

With Google Fonts' massive impact on web font serving, it is no surprise the most used font on the web is Roboto. Roboto was created by Google as a system font for its Android operating system. This also explains the huge discrepancy between Roboto's use on mobile compared to desktop sites. On Android, Google Fonts will use the system installed version instead of downloading it as a web font.

<figure>
  <table>
    <thead>
      <tr>
        <th>Family</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Roboto</td>
        <td class="numeric">14.5%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Font Awesome</td>
        <td class="numeric">10.5%</td>
        <td class="numeric">12.8%</td>
      </tr>
      <tr>
        <td>Noto Sans</td>
        <td class="numeric">10.1%</td>
        <td class="numeric">8.0%</td>
      </tr>
      <tr>
        <td>Open Sans</td>
        <td class="numeric">5.9%</td>
        <td class="numeric">7.7%</td>
      </tr>
      <tr>
        <td>Lato</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Poppins</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td>Montserrat</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Source Sans Pro</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>icomoon</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Proxima Nova</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Raleway</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Noto Serif</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Ubuntu</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>NanumGothic</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Oswald</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>PT Sans</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>GLYPHICONS Halflings</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Rubik</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>eicons</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>revicons</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="TODO.",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

Font Awesome takes the number two spot, which is an impressive accomplishment for what is essentially a single font family. Font Awesome, combined with Icomoon, Glyphicons, eicons, and revicons make up nearly 18% of all web fonts used on websites! Icon fonts are problematic from an <a hreflang="en" href="https://fontawesome.com/docs/web/dig-deeper/accessibility">accessibility point of view</a>, so it is worrying to see this being so popular.

{{ figure_markup(
  content="18%",
  caption="Sites using icon web fonts.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

A special note should also be made of Proxima Nova at 1% usage. It is the only commercial, non-icon, font in the top 20. That's an amazing achievement by <a hreflang="en" href="https://www.marksimonson.com/">Mark Simonson Studio</a>.

Another interesting fact is that a large portion of the top families are open source. This can be credited to Google Fonts who have either commissioned these fonts or included existing open source fonts in their library.

<figure>
  <table>
    <thead>
      <tr>
        <td><em>Vendor</em></td>
        <td>desktop</td>
        <td>mobile</td>
      </tr>
    </thead>
    <tbody>
    <tr>
      <td>Google</td>
      <td class="numeric">30.5%</td>
      <td class="numeric">17.7%</td>
    </tr>
    <tr>
      <td>Font Awesome</td>
      <td class="numeric">12.3%</td>
      <td class="numeric">15.6%</td>
    </tr>
    <tr>
      <td>Łukasz Dziedzic</td>
      <td class="numeric">3.6%</td>
      <td class="numeric">4.3%</td>
    </tr>
    <tr>
      <td>Indian Type Foundry</td>
      <td class="numeric">3.0%</td>
      <td class="numeric">4.1%</td>
    </tr>
    <tr>
      <td>Julieta Ulanovsky</td>
      <td class="numeric">2.5%</td>
      <td class="numeric">3.1%</td>
    </tr>
    <tr>
      <td>Adobe</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">1.9%</td>
    </tr>
    <tr>
      <td>Ascender Corporation</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">2.0%</td>
    </tr>
    <tr>
      <td>Icomoon</td>
      <td class="numeric">1.3%</td>
      <td class="numeric">1.5%</td>
    </tr>
    <tr>
      <td>Mark Simonson Studio</td>
      <td class="numeric">1.3%</td>
      <td class="numeric">1.3%</td>
    </tr>
    <tr>
      <td>ParaType Inc.</td>
      <td class="numeric">1.0%</td>
      <td class="numeric">1.4%</td>
    </tr>
  </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="TODO.",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

The list of most popular type foundries (or in some cases type designers) is equally fascinating. Besides large companies like Google, Adobe, Ascender (Monotype), it is good to see several smaller companies and even several individuals having such a large impact.

## OpenType features

OpenType features are often referred to as a font's superpowers. And of course, the fonts with superpowers are often unrecognized. OpenType features are hard to discover and use. Fortunately, there are web tools, such as <a hreflang="en" href="https://wakamaifondue.com/">Wakamai Fondue</a>, that clearly show you which features there are, what they do, and how to use them.

Some OpenType features are for stylistic purposes only, while others are required to render text correctly. You might often see these two mentioned as discretionary and required features. Almost 44% of all fonts have either discretionary or required OpenType features. So, there's a good chance the font you are using also has super powers!

{{ figure_markup(
  content="44%",
  caption="Fonts that include OpenType features.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

Discretionary features can be used to, for example, replace two adjacent glyphs with a ligature to improve legibility. It's also common for OpenType features to offer alternative versions of glyphs, for example by adding swashes.

A significant number of fonts have <a hreflang="en" href="https://fonts.google.com/knowledge/introducing_type/introducing_alternate_glyphs">discretionary OpenType features</a>. The most common discretionary feature is, not surprisingly, ligatures. This is followed by a whole range of features that modify numerals like fractions, proportional numerals, tabular numerals, lining numerals, and ordinals. Superscripts are also somewhat common.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

If we look at required OpenType features, there are two that stand out from everything else: _kerning_ and _localized forms_. Localized forms are used to specify alternate glyphs that are required or preferred by some languages. This implies that a good amount of fonts support multiple languages, which is a great sign of progress for internationalization.

Kerning is the process of slightly increasing or decreasing the space between any combination of two glyphs to make the space between them seem more even. Kerning is enabled by default on all browsers, so as long as the font supports kerning it will be enabled.

{{ figure_markup(
  content="34%",
  caption="Fonts including kerning data.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

Only 34% of all web fonts have kerning data stored as either an OpenType feature, or using the older `kern` table. Nearly all fonts need kerning to look correct, so we would have expected this number to be much higher than it is. One explanation is that when web fonts started taking off browser support for kerning wasn't very good, so many early web fonts did not include kerning data to save on space. Nowadays, all browsers support kerning so there is no reason fonts should not have kerning data in them.

What's even more interesting is that kerning is also the most common feature tag used in the `font-feature-settings` property. Nearly 3.2% of sites manually enable (or worse, disable) kerning. There is no need for that; it is enabled by default. In fact, there is no need to _ever_ change kerning settings through `font-feature-settings` or the higher level <code><a hreflang="en" href="https://drafts.csswg.org/css-fonts/#font-kerning-prop">font-kerning property</a></code>. Disabling kerning won't make your site faster, but your typesetting will be poorer for it.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The other most used features are roughly in line with what type designers actually include: ligatures and various numerals. It is interesting to see the `palt` (proportional alternates) feature in this list, as it is primarily used for CJK fonts (which themselves aren't common because they are usually too large to be used as web fonts, even with WOFF2 compression). Like kerning, the `calt` feature (contextual alternates) is enabled by default and should not be explicitly enabled or disabled. There are many other useful OpenType features such as stylistic sets, character variants, small caps, and swashes that have low usage, but have the potential to really enhance your typography. Our recommendation is to drop your fonts in <a hreflang="en" href="https://wakamaifondue.com/">Wakamai Fondue</a> and explore all the hidden superpowers.

Overall, usage of OpenType feature usage is quite low on the web. We were hoping most people are using the high-level `font-variant` properties to enable OpenType features, but their usage is even lower than `font-feature-settings`. The `font-feature-settings` property is used on 12.6% of sites, while the `font-variant` properties are used on only 3.5% of sites.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

This is disappointing. Not only are people not using the OpenType features present in fonts, they are also primarily using the error-prone `font-feature-settings` property instead of the high-level `font-variant` property. You need to be extra careful with the `font-feature-settings` property, as it <a hreflang="en" href="https://pixelambacht.nl/2022/boiled-down-fixing-variable-font-inheritance/">will reset any OpenType feature you didn't explicitly list to its default value</a>.

All of the most commonly used `font-feature-settings` values have `font-variant` equivalents that are more readable, and do not unset other OpenType features as a side effect. While support for these high-level features wasn't that great in the past they are <a hreflang="en" href="https://caniuse.com/?search=font-variant">well supported</a> these days (except for the recently introduced `font-variant-alternates` property).

The most used `font-variant` value is small-caps at 1.4% of pages. This is surprising, because small caps are only supported by 0.7% of fonts. That means that most people using `font-variant: small-caps` and `font-variant-caps` will get faux small caps that are generated by the browser instead of small caps created by the type designer! In the future, you can avoid faux small caps by using the <a hreflang="en" href="https://drafts.csswg.org/css-fonts-4/#font-synthesis-small-caps">font-synthesis-small-caps property</a>.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The other values roughly match what is provided by the fonts themselves. Even though use of the `font-variant` properties is low, we expect (or rather hope) that these numbers will go up over time and use of `font-feature-settings` becomes relegated to use with custom or proprietary OpenType features.

## Writing system & languages

To understand what kind of fonts are being made and used, we thought it would be interesting to look at what languages fonts support. For example, do people make a lot of German, Vietnamese, or Urdu fonts? Unfortunately, it is hard to answer this question because a lot of languages share the same writing system. That means they might share the same character set, but might have only been explicitly designed for one specific language. So instead of languages, we'll take a look at writing systems.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

Not surprisingly, the Latin system is in the lead with a whopping 54% of all fonts supporting (a significant) subset of the <a hreflang="en" href="https://en.wikipedia.org/wiki/List_of_languages_by_writing_system#Latin_script">Latin writing system</a>. This includes a lot of languages used in the western world, like English, French, and German. However, it also covers languages in Asia, such as Vietnamese and Tagalog. The number two and three spots are taken by Cyrillic and Greek. Again, this is not a surprise, they are commonly used and a reasonably small amount of work to add to a font due to their limited number of extra glyphs that need to be added. Katakana and Hiragana (Japanese) are at 1% and 0.9% respectively (a combined 1.9%).

Sadly, other writing systems are much less prevalent. For example, Han (Chinese) is the <a hreflang="en" href="https://www.worldatlas.com/articles/the-world-s-most-popular-writing-scripts.html">2nd most used writing system in the world</a> (after Latin), but only supported by 0.2% of web fonts. Arabic is the third most used writing system, but again, only supported by 0.4% of web fonts. The reason that some of these <a hreflang="en" href="https://www.w3.org/TR/PFE-evaluation/#fail-large">writing systems are not used as web fonts</a> is that they are very large due to the sheer number of glyphs they have to support, and the difficulty in subsetting them correctly.

While services like Google Fonts and Adobe Fonts support these writing systems, they are using proprietary technologies that simply are not available for self-hosting. However, the W3C Fonts Working Group is working on a new standard called <a hreflang="en" href="https://www.w3.org/TR/IFT/">Incremental Font Transfer</a> that enables web developers to self-host large fonts. We hope to see other writing systems catch up with Latin once this technology becomes widely available.

## Generic font families

We already touched on fallback fonts while talking about font-display. Sometimes you don't need web fonts at all though, for example in UI elements or form inputs. One of our favorite ways to avoid using web fonts is to use the new generic `system-ui` family name which maps to the font family used by the operating system. Did you know there are several other generic families? There is `ui-monospace`, `ui-sans-serif`, `ui-serif`, and `ui-rounded` as well, if you want to use an operating system font, but have slightly more specific needs.

While these are fairly new, they are already seeing significant use. The usual suspects, sans-serif, monospace, and serif obviously take the lead as they have been around since the first version of the CSS specification.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The most popular, and well-known, is `system-ui` at 3.6%, followed by `ui-monospace` at 0.5% and `ui-sans-serif` at 0.4%. It isn't clear what the 0.5% of requests for `fantasy` were hoping for, as that generic is so under-specified as to be effectively useless.

We hope to see more use of these generic family names next year. They are great for UI elements, forms, or really anything where you want to evoke a native feel. As an added benefit, they are also great for performance as they are guaranteed to use a locally installed font.

## Font smoothing

And now for a complete surprise (to us anyway): people _really_ like to specify their MacOS-only [font smoothing preferences](https://developer.mozilla.org/en-US/docs/Web/CSS/font-smooth). For example, the `-webkit-font-smoothing: antialiased` value is used on 73.4% of all sites. This is surprising because it (and its siblings `-mox-osx-font-smoothing`, and `font-smoothing`) are not even official CSS properties. This might make them the most used _unofficial_ CSS properties!

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

Our hunch this is a combination of CSS frameworks including these properties and a dislike of how fonts are rendered slightly bolder on macOS (variable font grades to the rescue!) It would be interesting to return to these properties in the 2023 fonts chapter. Perhaps it is also time to put these properties on a standards track? The demand is clearly there.

# Variable fonts

Variable fonts allow type designers to combine multiple styles of a family into a single font file. They do this by defining one or more design axes, such as weight (thin, regular, and bold) or width (condensed, normal, and expanded). Instead of storing each style as individual font files, a variable font interpolates them from a handful of "master" instances.

For example, even if the type designer did not explicitly create a semibold style, using a variable font with a weight axis, the text rendering engine will simply interpolate a semibold style for you (and any other weight you might need, assuming the variable font's weight axis supports that range). Not only do variable fonts increase typographic expressiveness, they also offer a major benefit for web developers in terms of file size savings.

Usage of variable fonts has nearly tripled since the last measurement in the Almanac's 2020 fonts chapter! Nearly 29% of websites use variable fonts. Most of this growth seems to have happened in the last year, with an amazing 125% growth.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

This impressive growth in usage can be explained by splitting the request data by host. Google Fonts accounts for 97% of variable fonts served, while everyone else accounts for only 3%. Even with Google's massive influence on web font serving, this growth can only be explained by replacing popular existing static styles with variable versions, rather than the introduction of completely new variable fonts.

{{ figure_markup(
  content="97%",
  caption="Variable fonts served by Google Fonts.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

As a result, Google Fonts and their users are probably seeing huge benefits in performance. Variable fonts are usually smaller than using multiple static instances. For example, if a website uses more than two or three styles from the same family, a variable font is smaller in file size and only takes a single request. It doesn't take a lot: using regular, bold, and light weights are usually sufficient reasons to use a variable font. As an added benefit, with a variable font you can also tweak the axes to suit your needs (semi-demi-bold anyone?)

Regardless of a single actor being responsible for the growth, it is an amazing achievement, and a good indicator of the usefulness of variable fonts to optimize your site's performance.

Variable fonts also have two competing formats: the variable extensions of the `glyf` format and the Compact Font Format 2 (CFF) format. The main differences between the `glyf` format and `CFF2` are the same as its CFF predecessor: different types of Bézier curves, more automated hinting, and a claim about smaller file sizes.

So which format should you use? Fortunately, for developers, type designers, and browser vendors the situation is quite simple. Out of all variable fonts served, 99.99% use the variable `glyf` format. Even if you exclude Google Fonts and other font services from the calculation the number changes to a whopping 99.98%. Nobody is using `CFF2`.

{{ figure_markup(
  content="99.99%",
  caption="Variable fonts using the `glyf` outline format.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

Our recommendation is to avoid CFF2-based variable fonts (for now, at least). Browsers and operating systems only recently added support for CFF2, and some browsers still don't support it. The only tangible benefit of using `CFF2` over `glyf` based variable fonts is the supposed file size savings, but as we've seen in the performance section this claim is dubious at best.

So, how are people using variable fonts? Not surprisingly the weight axis is the most popular value used with the `font-variation-settings` property, followed by optical sizes, width, slant, italic, and grades.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

This somewhat surprised us, because there is no need to use the low-level `font-feature-settings` property to set a custom weight axis value. You can simply use the `font-weight` property with a custom value, for example, font-weight: 550 for a weight between 500 and 600. Even more puzzling is that the most popular weight axis values are the "default" CSS weight values that have been around since the early days of CSS! Only 16% of the weight values are custom values along the weight range.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

The most popular "custom" weight value is `550` at only 1.5% of use, followed by `450` at 1% use. Similar results can be seen for the optical size, width, italic, and slant axes, which can be set using the high-level `font-optical-sizing`, `font-stretch`, and `font-style` properties. Using the higher level properties will make your CSS more readable and avoid accidentally disabling an axis (a common source of errors with the low-level property).

One of the highly promoted benefits of variable fonts is animating one or multiple axes. Despite the high usage of variable fonts, very few people are actually animating them through CSS transitions or keyframes. Out of the entire HTTP Archive dataset, only a couple hundred websites do any sort of animation involving variable fonts.

To us, it appears that variable fonts are primarily used for their performance benefits, and less so for their ability to make typographic adjustments. While that's great, we do hope to see more people use variable fonts to their full typographic potential in the coming years.

# Color fonts

Color fonts are pretty much what you would expect: fonts with built in colors. Though the technology was originally created for emoji fonts, there are now more text color fonts than emoji fonts.

Color fonts usage has grown quite a bit since the last fonts chapter in 2020. Usage went from 0.004% of pages using color fonts in 2020 to about 0.018% in 2022. While those numbers are still _very_ small, there is a clear growth in their usage.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

However, compared to the growth in variable font usage, the limited uptake of color fonts is somewhat disappointing. While color fonts are a relatively new addition to the OpenType specification (2015), variable fonts are an even more recent addition (2016).

The primary factors that have severely hindered color font adoption (and might continue to do so) is the ongoing standards "battle" for _the one true color font format_, and the lack of support in browsers for the CSS that allows you to select and edit color font palettes (until recently).

There are currently four competing color font formats: two based on vector outlines (OT-SVG and COLR) and two on images (CBDT and sbix). The COLR format re-uses the existing glyph outline and adds solid colors and layering to them. The most recent version, dubbed COLRv1 introduced gradients, compositing and blending modes as well. Due to its re-use of existing glyph outlines, the COLR format also supports variable fonts, so you can have <a hreflang="en" href="https://www.typearture.com/variable-fonts/">animated color fonts</a>. The OT-SVG format takes a different approach and essentially embeds an SVG image for each glyph in the font. Unfortunately, the OT-SVG format does not support variable fonts, and is unlikely to do so in the future. Both CBDT and sbix embed images for each glyph and they only differ in the supported image formats.

Taking a look at usage data paints an interesting picture: 79% of color font usage is using SVG, 19% uses COLR v0, and 2% uses CBDT.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

We can safely conclude that the image based formats are not popular, and for good reasons: the embedded images don't scale well, and their file sizes are not appropriate for web usage.

The split between the vector color font formats however is more nuanced. While OT-SVG seems to have the upper hand at the moment, COLR still has significant usage. The COLR format has a lot going for it: it is supported by all browsers, it can be used in variable fonts, and it is easy to implement. For those reasons alone, we expect it to become the most popular format. A more cynical take is that it will become the most popular format because Google is <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=306078">refusing to implement OT-SVG support in Chrome and Android</a>. Interestingly, <a hreflang="en" href="https://lists.webkit.org/pipermail/webkit-dev/2021-March/031765.html">Apple is refusing to implement COLR v1</a>, because a lot of COLR v1 features are already supported by OT-SVG. Unfortunately, web developers are caught in the middle of this "color fonts war". We hope this situation is soon resolved and we can all start using color fonts.

The CSS specification has been updated to support color fonts to allow <a hreflang="en" href="https://css-tricks.com/colrv1-and-css-font-palette-web-typography/">selection and customization of palettes</a>. Palettes are custom color schemes stored in the font by the type designer. The CSS `font-palette` property allows you to select a palette from the font and the `@font-palette-values` rule allows you to create new palettes or override existing ones. One of the more obvious use cases of this technology is to have light and dark mode palettes built right into the color font. There is a lot of unexplored potential there.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODO.sql"
  )
}}

_ <a hreflang="en" href="https://tools.djr.com/misc/bradley-initials/">Bradley Initials</a> using COLR v1 and multiple palettes by <a hreflang="en" href="https://djr.com/">David Jonathan Ross</a>_

Unfortunately, usage of these CSS properties is currently nonexistent. This is likely because support for these properties was only recently added to browsers combined with the limited number of color fonts.

One of the main drivers behind the development of color font technology was emoji. However, there are only a couple dozen web fonts that have color emoji. Most color fonts are for writing text, not emoji. There could be several explanations for this:

- Every OS already includes their own color emoji font, so users don't feel the need to use anything else.
- There are a large number of emoji and it takes a lot of effort (and money) to create fonts for them.
- Emoji fonts are generally quite large and not as suitable as web fonts.

Still, it would be nice to see some more diversity in emoji fonts. With the introduction of the COLR v1 format we're likely to see more emoji fonts in the future.

Again, all of this is based on very low usage numbers, but there appear to be some developing trends. We're not quite ready to declare 2023 the year of color fonts, but it seems clear we'll see significant color font growth in the coming years, especially as the industry settles on a single recommended color font format and browser support for color fonts improves. Google Fonts has also just <a hreflang="en" href="https://material.io/blog/color-fonts-are-here">added the first batch of color fonts</a> to their library, which will surely have an impact.

# Conclusion

Looking back over this chapter and the previous years it stands out to us how much of an impact web font services have had (and likely will continue to have.) For example, Google Fonts alone is responsible for most of web font usage, most of the popular web fonts, and most of variable fonts usage. That's an impressive feat.

While we strongly believe that self-hosting is the future for web fonts, it can not be denied that using a web font service makes a lot of sense for a lot of developers. They are easy to use, provide good out-of-the-box performance (though not the _best_), and for the most part you do not need to worry about font licensing. It is a good tradeoff.

On the other hand, self-hosting is now easier than ever, and _will_ give you the best performance, more control, and no privacy headaches. If you plan to self-host, be sure to use WOFF2, resource hints, and font-display. Combined, they will have the biggest impact on the font loading performance of your site.

Variable fonts have taken off in a spectacular fashion in the last couple of years (thanks Google!) While most people seem to be using them for performance reasons, we believe this is a case where adoption will drive innovation. We can't wait to see what kind of fun and downright crazy typography we'll see in the coming years.

We're cautiously optimistic about color fonts as well. Usage is finally growing. The technology has been there for a while, but the disagreements over color font formats and the limited CSS support have hindered adoption. We hope these will be resolved soon and we'll start seeing some real growth.

It is clear that web font usage will continue to grow and evolve over time. We're curious to see what the future holds. Technologies like <a hreflang="en" href="https://www.w3.org/TR/IFT/">Incremental Font Transfer</a> will unlock web fonts for more writing systems, enabling billions of people to start using web fonts for the first time. That's exciting!
