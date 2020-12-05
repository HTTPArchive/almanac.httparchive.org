---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: I
chapter_number: 4
title: Fonts
description: Fonts chapter of the 2020 Web Almanac covering where fonts are loaded from, font formats, font loading performance, variable fonts and color fonts.
authors: [raphlinus, jpamental]
reviewers: [davelab6, malchata, RoelN, notwaldorf, mandymichael, svgeesus, rsheeter]
analysts: [AbbyTsai]
translators: []
#jpamental_bio: TODO
raphlinus_bio: Raph Levien has been working with fonts for over 35 years, including a PhD from UC Berkeley in font design tools. He is rejoining Google Fonts as a font technology researcher, after having co-founded the team in 2010.
discuss: 2040
results: https://docs.google.com/spreadsheets/d/1jjvZqYay5KmTle4atzFWqtbkz9ohw25KFmNtCS-7n3s/
queries: 04_Fonts
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---
## Introduction

Text is at the heart of most web sites, and typography is the art of presenting that text in a way that's visually appealing and effective. Creating good typography requires choosing the appropriate fonts. Web fonts give designers a tremendous range of fonts to choose from. As with all resources, there are performance and compatibility concerns, but done right, the benefit is well worth it. In this chapter, we'll dive into data to show how web fonts are being used, and in particular how they're optimized.

Web font technology has been fairly mature, with incremental improvements in compression and other technical improvements, but new features are arriving. Browser support for variable fonts has become quite good, and this is the feature that's seen the most growth in the previous year.

## Where are web fonts being used?

Web font usage has been growing steadily over time, with 82% of web pages for desktop using web fonts, and mobile at 80%.

{{ figure_markup(
  image="fonts-web-fonts-usage.png",
  caption="Web font usage over time.",
  description="Scatter plot showing fraction of mobile and desktop web pages containing web fonts, as a function of time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1465601804&format=interactive",
  sheets_gid="655527383",
  sql_file="04_01.web_fonts_usage.sql"
  )
}}

Usage of web fonts is fairly consistent around the world, with a few outliers. The charts below are based on the median number of kilobytes of web fonts per web page, which can be an indicator of lots of fonts, large fonts, or both.

https://discuss.httparchive.org/t/how-does-web-font-usage-vary-by-country/1649

{{ figure_markup(
  image="fonts-web-fonts-usage-by-country.png",
  caption="Web fonts usage by country.",
  description="A map of the world showing the amount of web font usage for each country, measured as median kilobytes of web font data.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1005874204&format=interactive",
  sheets_gid="655527383",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

The single top country is South Korea, which is not all that surprising given their consistently high internet speeds and the fact that Korean (Hangul) fonts are almost an order of magnitude larger than Latin. As we'll see in the "popular typefaces" chapter, Korean fonts are two of the top 14 most popular, further evidence they really like web fonts. Web font usage in Japan and Chinese-speaking countries is considerably lower, likely because CJK fonts are even larger and connections are not as fast.

{{ figure_markup(
  image="fonts-web-fonts-usage-top-countries.png",
  caption="Web fonts usage, top countries.",
  description="A chart showing the top countries by usage of web fonts, measured as median kilobytes of web font data.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1772704624&format=interactive",
  sheets_gid="655527383",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

There's a great thread on [web font usage by country](https://discuss.httparchive.org/t/how-does-web-font-usage-vary-by-country/1649) on the httparchive discussion forum.

### Serving with a service

It likely comes as no surprise that Google Fonts remains by far the most popular platform, but the percentage use has actually dropped almost 5% from 2019 to about 70%. Adobe Fonts (formerly Typekit) has dropped about 3% as well, but Bootstrap usage has grown from about 3% to over 6% (in aggregate from several providers). It’s worth noting that the largest provider for Bootstrap (BootstrapCDN) also provides icon fonts from FontAwesome, so it may be that it’s not Bootstrap itself but rather older versions also referencing icon font files that is behind the rise in that source data.

Another surprise in the data is the rise in fonts being served by Shopify. Growing from roughly 1.1% in 2019 to about 4% in 2020, there has clearly been a significant uptick in usage of web fonts by sites hosted on that platform. It’s unclear if that is due to that service offering more fonts that they host on their CDN, if it’s growth in use of their platform, or both. However, the increase in usage of both Shopify and Bootstrap represent the largest amount of growth other than Google Fonts, making it a very noticeable data point.

{{ figure_markup(
  image="fonts-web-hosting-performance-desktop.png",
  caption="Web font hosting performance, desktop.",
  description="A bar chart showing the desktop median first content paint and last content paint (in milliseconds) for three different web font hosting strategies: local, external or both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=307595140&format=interactive",
  sheets_gid="655527383",
  sql_file="04_04.local_vs_host_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-web-hosting-performance-mobile.png",
  caption="Web font hosting performance, mobile.",
  description="A bar chart showing the mobile median first content paint and last content paint (in milliseconds) for three different web font hosting strategies: local, external or both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=55793395&format=interactive",
  sheets_gid="655527383",
  sql_file="04_04.local_vs_host_with_fcp.sql"
  )
}}

## Racing to first paint

The biggest performance concern about integrating web fonts is that they may delay the time when the first readable text is displayed. Two optimization techniques can help mitigate those issues: `font-display` and `resource-hint`.

The [`font-display`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display) setting controls what happens while waiting for the web font to load, and is generally a tradeoff between performance and visual richness. The most popular is `swap`, used on about 10% of web pages, which displays using the fallback font if the web font doesn't load quickly, then swaps in the web font when it does load. Other settings include `block`, which delays displaying text at all (minimizing the potential flashing effect), and `fallback`, which is like `swap` but gives up quickly and uses the fallback font if the font doesn't load in a moderate amount of time, and `optional`, which immediately gives up and uses the fallback font; this is used by only 1% of web pages, presumably those most concerned with performance.

{{ figure_markup(
  image="fonts-usage-of-font-display.png",
  caption="Usage of font-display.",
  description="A bar chart showing the usage of the different font-display settings, on desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1831117368&format=interactive",
  sheets_gid="655527383",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

We can analyze the effect of these settings on first content paint and last content paint. Not surprisingly, the `optional` setting has a major effect on last content paint. There is also an effect on first content paint, but that might be more correlation than causation, as all of the modes except for `block` display *some* text after an "extremely small block period."

{{ figure_markup(
  image="fonts-font-display-performance-desktop.png",
  caption="font-display, performance, desktop.",
  description="A bar chart showing the desktop median first content paint and last content paint (in milliseconds) for different font-display settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1351778595&format=interactive",
  sheets_gid="655527383",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-font-display-performance-mobile.png",
  caption="font-display, performance, mobile.",
  description="A bar chart showing the mobile median first content paint and last content paint (in milliseconds) for different font-display settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=748174335&format=interactive",
  sheets_gid="655527383",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

There are two other interesting inferences from this data. One might expect the `block` setting to have a significant impact on FCP, especially on mobile, but in practice the effect is not that large. That suggests that waiting for font assets is seldom the "long pole in the tent" for the webpage as a whole, though it would certainly be a major. The `auto` setting (which is also what you get if you don't specify it) looks a lot like `block`; though it's technically up to the browser, [the default seems to be blocking](https://nooshu.github.io/blog/2020/02/23/improving-perceived-performance-with-the-css-font-display-property/).

Finally, the data do not support the use of the `fallback` setting, as there is no actual empirical performance gain compared with `swap`. Fortunately, it only is used by about 1% of pages.

Google Fonts now recommends `swap` in its suggested integration code. If you're not using it now, adding it might be a way to improve performance, especially for users on slow connections.

### Resource hints

While `font-display` can speed up the presentation of the page when the fonts are slow to load, resource hints can move the loading of web font assets to earlier in the cascade. Ordinarily, fetching web fonts is a two-stage process. The first stage is loading the CSS, which contains a reference (in `@font-face` sections) to the actual font binaries. Only then can the connection to that server begin, which further breaks down into the DNS query for the server, and actually initiating a connection (which, these days, usually involves an HTTPS cryptographic handshake).

Adding a `resource-hint` element in the HTML starts that second connection earlier. The various `resource-hint` settings control how far that gets before having the URL for the actual font resource. The most common (at about 32% of web pages) is `dns-prefetch`, but 

{{ figure_markup(
  image="fonts-resource-hints-use.png",
  caption="resource-hints use on fonts.",
  description="A bar chart showing the usage of different resource-hints setting for font data.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2115805374&format=interactive",
  sheets_gid="655527383",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-resource-hints-performance-desktop.png",
  caption="resource-hints performance, desktop.",
  description="A bar chart showing the desktop median first content paint and last content paint (in milliseconds) for different resource-hints settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1518736765&format=interactive",
  sheets_gid="655527383",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-resource-hints-performance-mobile.png",
  caption="resource-hints performance, mobile.",
  description="A bar chart showing the mobile median first content paint and last content paint (in milliseconds) for different resource-hints settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=448614843&format=interactive",
  sheets_gid="655527383",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

Analysis of this data suggests that the `dns-prefetch` setting, while the most popular, doesn't improve performance much. Presumably, the DNS for popular web font servers are likely to be cached anyway. The other settings give a lot more bang for the buck, with `preconnect` being a sweet spot for ease of use, flexibility, and performance improvement. As of March 2020, Google Fonts recommends adding this line to the HTML source, immediately before the CSS link:

```html
<link rel="preconnect" href="https://fonts.gstatic.com">
```

The use of `preconnect` has grown considerably since last year, now at 8% from 2%, but there's a lot more potential performance still left on the table. Adding this line might be the single best optimization for web pages that use Google Fonts.

It might be tempting to go even farther into the pipeline, preloading or prerendering the font asset, but that potentially conflicts with other optimizations, such as fine-tuning the font for the capabilities of the rendering engine, or the `unicode-range` optimization described below. To preload a resource, you have to know *exactly* what resource to load, and the best resource for the task may depend on information not readily available at HTML authoring time.

## Home on the (Unicode) range

Fonts increasingly have support for lots and lots of languages. Other fonts can have a large number of glyphs because the script (especially CJK) requires it. Either way can increase the file size. That's unfortunate if the web page is not in fact a multilingual dictionary, and only uses a fraction of the font's capabilities.

One older approach is for the HTML author to explicitly indicate a font subset. However, that requires deeper knowledge of the content, and risks a "ransom note" effect when the content uses characters supported by the font but not by the chosen subset. See the excellent essay [When fonts fall](https://www.figma.com/blog/when-fonts-fall/) by Marcin Wichary for lots more detail about how fallback works.

The `unicode-range` feature is a newer approach to this problem. The font is sliced into subsets, each with a separate `@font-face` rule that indicates the Unicode coverage for that slice with a `unicode-range` descriptor. The browser then analyzes the content as part of its rendering pipeline, and downloads *only* the slices needed to render that content.

{{ figure_markup(
  image="fonts-usage-of-unicode-range.png",
  caption="usage of unicode-range.",
  description="A bar chart showing the fraction of unicode-range usage in mobile and desktop web pages that use web fonts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2018216759&format=interactive",
  sheets_gid="655527383",
  sql_file="04_08.font_unicode_range_with_fcp.sql"
  )
}}

Correctly applying `unicode-range` is tricky, as there's a lot of complexity to the way text layout maps Unicode into glyphs, but Google Fonts does this automatically and transparently. It's only likely to be a win for fonts with large glyph counts. In any case, current usage is 37% on desktop and 38% on mobile.

{{ figure_markup(
  image="fonts-web-font-mime-types.png",
  caption="Popular web font MIME types.",
  description="A bar chart showing the breakdown of percentage of different MIME types for serving web fonts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1771540678&format=interactive",
  sheets_gid="655527383",
  sql_file="04_10.font_formats.sql"
  )
}}

## Popular fonts

{{ figure_markup(
  image="fonts-popular-typefaces.png",
  caption="Popular typefaces.",
  description="A bar chart showing the 14 most popular web fonts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1129854167&format=interactive",
  sheets_gid="655527383",
  sql_file="04_11a.popular_typeface.sql"
  )
}}

(The above figure is in the process of being revised. I'm going to skip the section for now and get back to it)

## Color fonts

Color fonts, in one form or other, are supported by most modern browsers, but usage is still close to nonexistent (a total of 755 pages total, the majority of which are in a deprecated format). No doubt part of the problem is the diversity of formats, in fact 4 in widespread use. These come in bitmap and vector flavors. The two bitmap formats are technologically very similar, but SBIX (originally a proprietary Apple format) is not supported in Firefox, while CBDT/CBLC is not supported in Safari.

The COLR vector format is supported on all major modern browsers, but only fairly recently. The fourth format is embedding SVG in OpenType (not to be confused with SVG fonts), but not supported in Chrome or Firefox, largely because SVG is a heavyweight format and difficult to render efficiently.

Generally the bitmap format has larger files and doesn’t scale as cleanly to larger sizes, but vectors only offer flat color shading (though work is ongoing to offer richer shading options in a future version).

Probably most usage of color fonts is for emoji, but the capability is general purpose and color fonts offer many design possibilities. While color web fonts haven’t taken off yet, the underlying technology is heavily used to deliver system emoji, where file format compatibility is much less of an issue.

Browser support is so fragmented that color fonts are not yet tracked by caniuse.com, though there is [an issue open for it](https://github.com/Fyrd/caniuse/issues/1018).

Lots more information about color fonts, including examples, are available at [colorfonts.wtf](https://www.colorfonts.wtf/).

## Variable fonts

{{ figure_markup(
  image="fonts-font-variation-settings-usage.png",
  caption="Usage of font-variation-settings axes.",
  description="A bar chart showing the usage of the 6 most popular axes for font variation settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=173491049&format=interactive",
  sheets_gid="655527383",
  sql_file="04_17.VF_axis_value.sql"
  )
}}

Variable fonts are certainly one of the biggest stories this year. They’re seen in 8.37% of desktop pages, and 13.84% of mobile. That’s up from an average of 1.8% last year, a huge growth factor. It’s not hard to see why their popularity is increasing - they offer more design flexibility, and also potentially smaller binary font sizes, especially if multiple styles of the same font are used on the same page.

By far the most commonly used axis is `wght` (which controls weight), at 84.7% desktop and 90.4% mobile. However, `wdth` (width) accounts for approximately 5% of variable font usage. In 2020, Google Fonts began serving 2-axis fonts with both width and weight axes.

The optical size (`opsz`) feature is used for approximately 2% of the variable font usage. This is one to watch, as tuning the appearance of a font to match its intended size of presentation improves the visual refinement in perhaps subtle but very real ways.
