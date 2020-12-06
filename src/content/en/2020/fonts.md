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
jpamental_bio: Designer, tinkerer, typographer. Author of Responsive Typography, Invited Expert to the W3C, and 10yrs+ experience focused on better typogography on the web.
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
  description="Scatter plot showing fraction of mobile and desktop web pages containing web fonts, as a function of time. Usage increased roughly linearly from 0% around 2010 to 80% now. Desktop and mobile usage seems similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=666273773&format=interactive",
  sheets_gid="655527383",
  sql_file="04_01.web_fonts_usage.sql"
  )
}}

Usage of web fonts is fairly consistent around the world, with a few outliers. The charts below are based on the median number of kilobytes of web fonts per web page, which can be an indicator of lots of fonts, large fonts, or both.

https://discuss.httparchive.org/t/how-does-web-font-usage-vary-by-country/1649

{{ figure_markup(
  image="fonts-web-fonts-usage-by-country.png",
  caption="Web fonts usage by country (desktop).",
  description='A map of the world showing the amount of web font usage for each country, measured as median kilobytes of web font data. Noteable "hot spots" highlighted with low font usage include Africa, Turkmenistan, Taiwan, Japan and a number of other far eastern countries',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=961243485&format=interactive",
  sheets_gid="68624087",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

The single top country is South Korea, which is not all that surprising given their consistently high internet speeds and the fact that Korean (Hangul) fonts are almost an order of magnitude larger than Latin. As we'll see in the "popular typefaces" chapter, Korean fonts are two of the top 14 most popular, further evidence they really like web fonts. Web font usage in Japan and Chinese-speaking countries is considerably lower, likely because CJK fonts are even larger and connections are not as fast.

{{ figure_markup(
  image="fonts-web-fonts-usage-top-countries.png",
  caption="Web fonts usage, top countries (desktop).",
  description="A chart showing the top countries by usage of web fonts, measured as median kilobytes of web font data. At the top is the Republic of Korea with 155 kilobytes followed by Turkey (117), Iran (115), Solvenia (114), Greece (111), Suadia Arabia (109), and then three countries (Australia, United States of America, and Poland) are at the bottom with 108 kilobytes each.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=705183861&format=interactive",
  sheets_gid="68624087",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

There's a great thread on [web font usage by country](https://discuss.httparchive.org/t/how-does-web-font-usage-vary-by-country/1649) on the httparchive discussion forum.

### Serving with a service

It likely comes as no surprise that Google Fonts remains by far the most popular platform, but the percentage use has actually dropped almost 5% from 2019 to about 70%. Adobe Fonts (formerly Typekit) has dropped about 3% as well, but Bootstrap usage has grown from about 3% to over 6% (in aggregate from several providers). It’s worth noting that the largest provider for Bootstrap (BootstrapCDN) also provides icon fonts from FontAwesome, so it may be that it’s not Bootstrap itself but rather older versions also referencing icon font files that is behind the rise in that source data.

Another surprise in the data is the rise in fonts being served by Shopify. Growing from roughly 1.1% in 2019 to about 4% in 2020, there has clearly been a significant uptick in usage of web fonts by sites hosted on that platform. It’s unclear if that is due to that service offering more fonts that they host on their CDN, if it’s growth in use of their platform, or both. However, the increase in usage of both Shopify and Bootstrap represent the largest amount of growth other than Google Fonts, making it a very noticeable data point.

The use of local is [controversial](https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html), as it can save bytes, but it can also yield bad results if the locally installed version of the font is outdated. As of [November 2020](https://twitter.com/googlefonts/status/1328761547041148929?s=19), Google Fonts has moved to using local only for Roboto on mobile platforms, otherwise the font is always fetched over the network.

Since the data for the following charts was gathered before the switchover, Google Fonts is represented in the "both" category.

{{ figure_markup(
  image="fonts-web-hosting-performance-desktop.png",
  caption="Web font hosting performance, desktop.",
  description="A bar chart showing the desktop median first content paint and last content paint (in milliseconds) for three different web font hosting strategies: local is 2,426 milliseconds for median FCP and 4,176 for median LCP, external is 2,034 and 3,671 respectively, and both is 2,663 and 5,044 milliseconds respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=506816237&format=interactive",
  sheets_gid="838326315",
  sql_file="04_04.local_vs_host_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-web-hosting-performance-mobile.png",
  caption="Web font hosting performance, mobile.",
  description="A bar chart showing the mobile median first content paint and last content paint (in milliseconds) for three different web font hosting strategies: local is 5,326 milliseconds for median FCP and 8,521 for median LCP,  external is 5,056 and 8,229 respectively, and both is 5,847 and 9,900 milliseconds respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1955186104&format=interactive",
  sheets_gid="838326315",
  sql_file="04_04.local_vs_host_with_fcp.sql"
  )
}}

It wouldn't be sound to infer causality between hosting strategy from the above data, as there are other variables that may confound the relationship. But, putting that aside, we find that adding the local reference doesn't improve performance, which certainly supports the decision to remove it.

## Racing to first paint

The biggest performance concern about integrating web fonts is that they may delay the time when the first readable text is displayed. Two optimization techniques can help mitigate those issues: `font-display` and `resource-hint`.

The [`font-display`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display) setting controls what happens while waiting for the web font to load, and is generally a tradeoff between performance and visual richness. The most popular is `swap`, used on about 10% of web pages, which displays using the fallback font if the web font doesn't load quickly, then swaps in the web font when it does load. Other settings include `block`, which delays displaying text at all (minimizing the potential flashing effect), and `fallback`, which is like `swap` but gives up quickly and uses the fallback font if the font doesn't load in a moderate amount of time, and `optional`, which immediately gives up and uses the fallback font; this is used by only 1% of web pages, presumably those most concerned with performance.

{{ figure_markup(
  image="fonts-usage-of-font-display.png",
  caption="Usage of font-display.",
  description="A bar chart showing the usage of the different font-display settings, on desktop and mobile: `swap` is used by 10.9% of desktop sites and 10.3% of mobile sites, `auto` is used by 5.2% and 5.6% respectively, `block` by 4.1% and 4.2% respectively, `fallback` by 0.9% for both, and finally `optional` is used by 0.3% of desktop sites and 0.1% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=654093509&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

We can analyze the effect of these settings on first content paint and last content paint. Not surprisingly, the `optional` setting has a major effect on last content paint. There is also an effect on first content paint, but that might be more correlation than causation, as all of the modes except for `block` display *some* text after an "extremely small block period."

{{ figure_markup(
  image="fonts-font-display-performance-desktop.png",
  caption="font-display, performance, desktop.",
  description="A bar chart showing the desktop median first content paint (FCP) and last content paint (LCP) in milliseconds for different font-display settings: `none` has a median FCP of 2,286 ms and median LCP of 4,028 ms, `optional` has 1,766 ms and 3,055 ms respectively, `swap` has 2,223 ms and 4,176 ms, `fallback` has 2,397 ms and 4,106 ms, `block` has 2,454 ms and 4,669 ms, and `auto has 2,605 ms and 4,883 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1618299142&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-font-display-performance-mobile.png",
  caption="font-display, performance, mobile.",
  description="A bar chart showing the mobile median first content paint (FCP) and last content paint (LCP) in milliseconds for different font-display settings: `none` has a median FCP of 5,279 ms and median LCP of 8,381 ms, `optional` has 4,733 ms and 6,598 ms respectively, `swap` has 5,268 ms and 8,748 ms, `fallback` has 5,478 ms and 8,706 ms, `block` has 5,739 ms and 9,625 ms, and `auto has 6,181 ms and 10,103 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2135700957&format=interactive",
  sheets_gid="1485693069",
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
  description="A bar chart showing the usage of different resource-hints setting for font data: `dns-prefetch` is used by 32% of both desktop and mobile sites, `preload` by 17% of desktop and 16% of mobile, `preconnect` by 8% of both, `prefetch` by 3% of both, and `prerender` by 0% for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1880156934&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-resource-hints-performance-desktop.png",
  caption="resource-hints performance, desktop.",
  description="A bar chart showing the desktop median first content paint and last content paint (in milliseconds) for different resource-hints settings: `prerender` has a median FCP of 1,658 ms and median LCP of 2,904 ms, `preload` has 2,045 ms and 3,865 ms respectively, `prefetch` has 1,909 ms and 3,702 ms, `preconnect` has 2,069 ms and 4,213 ms, `none` has 2,489 ms and 4,816 ms, and `dns-prefetch` has 2,630 ms and 5,061 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=355239876&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-resource-hints-performance-mobile.png",
  caption="resource-hints performance, mobile.",
  description="A bar chart showing the mobile median first content paint and last content paint (in milliseconds) for different resource-hints settings: `prerender` has a median FCP of 3,387 ms and median LCP of 7,362 ms, `preload` has 4,900 ms and 8,222 ms respectively, `prefetch` has 4,942 ms and 8,191 ms, `preconnect` has 4,858 ms and 9,131 ms, `none` has 5,825 ms and 10,027 ms, and `dns-prefetch` has 5,908 ms and 9,962 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=640692889&format=interactive",
  sheets_gid="2079638999",
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
  description="A bar chart showing the fraction of unicode-range usage in mobile and desktop web pages that use web fonts. On desktop 37.05% of pages use unicode-range while 62.95% do not. On mobile 38.27% of pages use unicode-range while 61.73% do not.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1739264728&format=interactive",
  sheets_gid="640499741",
  sql_file="04_08.font_unicode_range_with_fcp.sql"
  )
}}

Correctly applying `unicode-range` is tricky, as there's a lot of complexity to the way text layout maps Unicode into glyphs, but Google Fonts does this automatically and transparently. It's only likely to be a win for fonts with large glyph counts. In any case, current usage is 37% on desktop and 38% on mobile.

## Formats and MIME types

WOFF2 is the best compression format, and is now [supported](https://caniuse.com/woff2) by effectively all browsers except for versions 11 and earlier of Internet Explorer. It's *almost* possible to serve web fonts using an `@font-face` rule with a WOFF2 source only. This format makes up about 75% of all fonts served.

{{ figure_markup(
  image="fonts-web-font-mime-types.png",
  caption="Popular web font MIME types.",
  description="A bar chart showing the breakdown of percentage of different MIME types for serving web fonts: WOFF2 is used by 75.83% of pages using fonts on desktop and 74.32% on mobile, WOFF is used by 11.57% and 11.61% respectively, octet-stream by 6.33% and 6.09%, ttf by 2.54% and 4.42%, and plain by 1.41% and 1.32% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2028456617&format=interactive",
  sheets_gid="316058576",
  sql_file="04_10.font_formats.sql"
  )
}}

WOFF is an older, less efficient compression mechanism, but almost universally supported, accounting for an additional 11.6% of fonts served. In almost all cases (Internet Explorer 9-11 being the main exception), serving a font as WOFF is leaving performance on the table, and shows a risk of self-hosting. Even if the format choices were optimal at the time of integration, it requires extra effort to update them as browsers improve. Using a hosted service guarantees that the best format is chosen, along with all relevant optimizations.

Ancient versions of Internet Explorer (6-8), which still make about 1.5% of global browser share, require EOT. These don't show up in the top 5 MIME formats, but are necessary for maximum compatibility.

Uncompressed fonts are 2-3x larger than compressed, but still make up almost 5% of all fonts served, disproportionally on mobile. If you're serving these, it should be a red flag that optimization is possible.

## Popular fonts

Icon fonts are fully half of the top 10 most popular web fonts, the rest being clean, robust sans-serif typeface designs (Roboto Slab is at #19 and Playfair Display at #28 in this ranking, for debuts of other styles, though serif designs are well represented in the tail of the distribution).

{{ figure_markup(
  image="fonts-popular-typefaces.png",
  caption="Popular typefaces.",
  description="A bar chart showing the 10 most popular web fonts, starting with Font Awesome (35% of desktop and mobile), Open Sans (23% desktop and 25% of mobile)...etc.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=551344676&format=interactive",
  sheets_gid="179750099",
  sql_file="04_11a.popular_typeface.sql",
  width="600",
  height="520"
  )
}}

A note of caution, in determining the most popular fonts you can get different results depending on measurement methodology. The chart above is based on counting the number of pages that include an `@font-face` rule referencing the named font. That counts multiple styles only once, which arguably weights in favor of single-style fonts.

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
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=635348995&format=interactive",
  sheets_gid="309969915",
  sql_file="04_17.VF_axis_value.sql"
  )
}}

Variable fonts are certainly one of the biggest stories this year. They’re seen in 8.37% of desktop pages, and 13.84% of mobile. That’s up from an average of 1.8% last year, a huge growth factor. It’s not hard to see why their popularity is increasing - they offer more design flexibility, and also potentially smaller binary font sizes, especially if multiple styles of the same font are used on the same page.

By far the most commonly used axis is `wght` (which controls weight), at 84.7% desktop and 90.4% mobile. However, `wdth` (width) accounts for approximately 5% of variable font usage. In 2020, Google Fonts began serving 2-axis fonts with both width and weight axes.

The optical size (`opsz`) feature is used for approximately 2% of the variable font usage. This is one to watch, as tuning the appearance of a font to match its intended size of presentation improves the visual refinement in perhaps subtle but very real ways.

## Towards the future

The performance landscape is changing somewhat, as the advent of [cache partitioning](https://developers.google.com/web/updates/2020/10/http-cache-partitioning) reduces the performance benefit from sharing the cache of CDN font resources across multiple sites. The trend of hosting more font assets on the same domain as the site, rather than using a CDN, will probably continue. Even so, services such as Google Fonts are highly optimized, and best practices such as use of `swap` and `preconnect` mitigate much of the impact of the additional HTTP connection.

The use of variable fonts is accelerating greatly, and that trend will no doubt continue, especially as browser and design tool support improve. It's also possible that 2021 will be the year of the color web font; even though the technology has been in place, that certainly hasn't happened yet.
