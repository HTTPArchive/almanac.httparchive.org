---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compression
description: Compression chapter of the 2021 Web Almanac covering HTTP compression, algorithms, compression levels, content types, 1st party and 3rd party compression and opportunities.
authors: [lvandeve, mo271, jyrkialakuijala]
reviewers: [fischbacher, eustas, iulia-m-comsa]
analysts: [paulcalvano]
editors: [shantsis]
translators: []
jyrkialakuijala_bio: Jyrki Alakuijala is an active member of the open source software community, and a data compression researcher. Jyrki works at Google as a Technical Lead/Manager, and his recent published work has been with Zopfli, Butteraugli, Guetzli, Gipfeli, WebP lossless, Brotli, and JPEG XL compression formats and algorithms, and two hashing algorithms, CityHash, and HighwayHash. Before his Google employment he developed software for neurosurgery and radiation therapy treatment planning.
mo271_bio: Moritz Firsching is software engineer at Google Switzerland, where he works on progressive image formats and font compression. Before that Moritz did research as a mathematician studying polytopes.
lvandeve_bio: Lode Vandevenne works at Google Switzerland as a software engineer and has contributed to compression projects including Zopfli, Brotli and the JPEG XL image format.
results: https://docs.google.com/spreadsheets/d/1-FQlNvtBw9ai8cBF7wEich_AcXnrNkNGW7dMYvHFl2w/
featured_quote: Using HTTP compression makes a website load faster and therefore guarantees a better user experience.
featured_stat_1: 33%
featured_stat_label_1: Compressed responses which use Brotli
featured_stat_2: 66%
featured_stat_label_2: Compressed responses which use Gzip
featured_stat_3: 72%
featured_stat_label_3: Websites that pass the Lighthouse audit with maximum score on text compression
---

## Introduction

A user's time is valuable, so they shouldn't have to wait a long time for a web page to load. The HTTP protocol allows to compress responses and this decreases the time needed to transfer the content. Compression often leads to significant improvement in the user experience. It can reduce [page weight](./page-weight), improve [web performance](./performance) and boost search rankings. As such it's an important part of [Search Engine Optimization](./seo).

This chapter discusses lossless compression applied on a HTTP response. Lossy and lossless compression used in [media](../2020/media) formats such as images, audio and video are equally if not more important for increasing page speed. However these are not in the scope of this chapter as they usually are part of the file format itself.

## Content types using HTTP compression

HTTP compression is recommended for text-based content, such as [HTML](./markup), [CSS](./css), [JavaScript](./javascript), JSON, or SVG, as well as for `woff`, `ttf` and `ico` files. Media files such as images that are already compressed do not benefit from HTTP compression since, as mentioned previously, their representation already includes internal compression.

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="Compression methods for different content types",
  description="A stacked bar chart showing the usage rate of different compression algorithms broken down by the content type. The stacked bars divide up the use of Brotli, Gzip, and no compression. `text/plain` and `text/html` are the only content types that are compressed less than 50% of the time. `application/json` is compressed approximately 68% of the time, `image/svg+xml` approximately 64%. `text/css` and `application/javascript` are each compressed over 85% of the time, and `application/x-javascript` and `text/javascript` are compressed more than 90% of the time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1292728213&format=interactive",
  sheets_gid="234112121",
  sql_file="compression_by_content_type.sql"
  )
}}

Compared to the other content types, `text/plain` and `text/html` use the least amount of compression, with merely 12% and 14% using compression at all. This might be because `text/html` is more often dynamically generated than static content such as JavaScript and CSS, even though compressing dynamically generated content also has a positive impact. More analysis about the compression of JavaScript content is available in the [JavaScript][./javascript] chapter.

## Server settings for HTTP compression

For HTTP content encoding, the HTTP standard defines the [Accept-Encoding](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding) request header, with which a HTTP client can announce to the server what content encodings it can handle. The server's response can then contain a [Content-Encoding](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding) header field that specifies which of the encodings was chosen to transform the data in the response body.

Practically all text compression is done by one of two HTTP content encodings: <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> and <a hreflang="en" href="https://github.com/google/brotli">Brotli</a>. Both Brotli and Gzip are supported by virtually all browsers. On the server side, most [popular servers](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression) like nginx and Apache can be configured to use Brotli and/or Gzip. The configuration is different depending on when the content is generated:

 - Static content: this content can be precompressed. The web server can be set up to map the URLs to the appropriate compressed files, e.g. based on the filename extension. For example, CSS and JavaScript are often static content and so can be precompressed to reduce effort for the web server to compress for each request.
 - Dynamically generated content: this has to be compressed on the fly for each request by the web server (or a plugin) itself. For example, HTML or JSON can be dynamic content in some cases.

When compressing text with Brotli or Gzip it is possible to select different compression levels. Higher compression levels will result in smaller compressed files, but take a longer time to compress. During decompression, CPU usage tends not to be higher for more heavily compressed files. Rather, files that are compressed with a higher compression level are slightly faster to decode.

Depending on the web server software used, compression needs to be enabled, and the configuration may be separate for precompressed and dynamically compressed content. For <a hreflang="en" href="https://httpd.apache.org/">Apache</a>, Brotli can be enabled with <a hreflang="en" href="https://httpd.apache.org/docs/2.4/mod/mod_brotli.html">mod_brotli</a>, and Gzip with <a hreflang="en" href="https://httpd.apache.org/docs/2.4/mod/mod_deflate.html">mod_deflate</a>. For <a hreflang="en" href="https://nginx.org/">nginx</a> instructions for <a hreflang="en" href="https://github.com/google/ngx_brotli">enabling Brotli</a> and for <a hreflang="en" href="https://nginx.org/en/docs/http/ngx_http_gzip_module.html">enabling Gzip</a> are available as well.

## Trends in HTTP compression

The graph below shows the usage share trend of lossless compression from the HTTP Archive metrics over the last 3 years. The usage of Brotli has doubled since 2019, while the usage of Gzip has slightly decreased, and overall the use of HTTP compression is growing on desktop and on mobile.

{{ figure_markup(
  image="compression-format-trend-desktop.png",
  caption="Compression method trend for desktop.",
  description="A stacked bar chart showing the usage of Brotli, Gzip or No text compression on desktop for 2019, 2020 and 2021. For 2019, it shows 7.4% Brotli, 29.5% Gzip, 63.1% No text compression. For 2020, it shows 9.1% Brotli, 30.8% Gzip, 60.1% No text compression. For 2021, it shows 14.0% Brotli, 28.2% Gzip, 58.8% No text compression.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1962012452&format=interactive",
  sheets_gid="703407907",
  sql_file="compression_format_trend.sql"
  )
}}

{{ figure_markup(
  image="compression-format-trend-mobile.png",
  caption="Compression method trend for mobile.",
  description="A stacked bar chart showing the usage of Brotli, Gzip or No text compression on mobile for 2019, 2020 and 2021. For 2019, it shows 7.5% Brotli, 30.8% Gzip, 61.6% No text compression. For 2020, it shows 9.1% Brotli, 31.6% Gzip, 59.3% No text compression. For 2021, it shows 14.3% Brotli, 28.6% Gzip, 57.1% No text compression.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=646268399&format=interactive",
  sheets_gid="703407907",
  sql_file="compression_format_trend.sql"
  )
}}

Of the resources that are served compressed, the majority are using either Gzip (66%) or Brotli (33%). The other compression algorithms are used infrequently. This split is virtually the same for desktop and mobile.

{{ figure_markup(
  image="compression-algorithms-for-http-responses.png",
  caption="Compression algorithm for HTTP responses.",
  description="A bar chart showing the usage rates of different compression algorithms for HTTP responses. 66.7% of HTTP responses that use compression employ the Gzip algorithm, 33.2% use Brotli, and 0.1% use some other method.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=676651936&format=interactive",
  sheets_gid="1289551244",
  sql_file="compression_formats.sql"
  )
}}

## First-party vs third-party compression

[Third Parties](./third-parties) have an impact on the user experience of a website. Historically the amount of compression used by first parties compared with third parties was significantly different.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Content-encoding</th>
        <th scope="col">First-party</th>
        <th scope="col">Third-party</th>
        <th scope="col">First-party</th>
        <th scope="col">Third-party</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No text compression</em></td>
        <td class="numeric">58.0%</td>
        <td class="numeric">57.5%</td>
        <td class="numeric">56.1%</td>
        <td class="numeric">58.3%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">28.1%</td>
        <td class="numeric">28.4%</td>
        <td class="numeric">29.1%</td>
        <td class="numeric">28.1%</td>
      </tr>
      <tr>
        <td>Brotli</td>
        <td class="numeric">13.9%</td>
        <td class="numeric">14.1%</td>
        <td class="numeric">14.9%</td>
        <td class="numeric">13.7%</td>
      </tr>
      <tr>
        <td>Deflate</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td><em>Other / Invalid</em></td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="First-party versus third-party compression by device type.", sheets_gid="2074687558", sql_file="first_vs_third_party.sql") }}</figcaption>
</figure>

From these results we can see that, [*compared to 2020*](../2020/compression#first-party-vs-third-party-compression), first party content has caught up with third party content in the use of compression and they use compression in comparable ways. Usage of compression and especially Brotli has grown in both categories. Brotli compression has doubled in percentage for first party content compared to a year ago.

## Compression levels

Compression level is a parameter given to the encoder to adjust the amount of effort is applied to find redundancy in the input in order to consequently achieve higher compression density. A higher compression level results in slower compression, but does not substantially affect the decompression speed, even making it slightly faster. For precompressed content, the time needed to compress the data has no effect on the user experience because it can be done beforehand. For dynamic content, the amount time the CPU needs to compress the resource can be traded off to the gain in speed to send the reduced, compressed data over the network.

Brotli encoding allows compression levels from 0 to 11, while Gzip uses levels 1 to 9. Higher levels can be achieved for Gzip as well, with a tool such as Zopfli. This is indicated as `opt` in the graph below.

We used the HTTP Archive `summary_response_bodies` data table to analyze the compression levels currently used on the web. This is estimated by re-compressing the responses with different compression level settings and taking the closest actual size, based on around 14,000 compressed responses that used Brotli, and 11,000 that used Gzip.

When plotting the amount of instances of each level, it shows two peaks for the most commonly used Brotli compression levels, one around compression level 5, and another at the maximum compression level. Usage of compression levels below 4 is rare.

{{ figure_markup(
  image="compression-levels-brotli.png",
  caption="Compression levels for Brotli.",
  description="Stacked bar charts showing the usage of compression levels of responses using Brotli, for compression level 0 to 11. It shows peaks at level 5 and at level 11. Each level is also broken down by content type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1630047521&format=interactive",
  sheets_gid="150560131"
  )
}}

Gzip compression is applied largely around compression level 6, extending to level 9. The peak at level 1 might be explained because this is the default compression level of the popular web server <a hreflang="en" href="https://nginx.org/">nginx</a>. For comparison, Gzip level 9 attempts thousands of redundancy matches, level 6 limits it to about a hundred, while level 1 means limiting redundancy matching to only four candidates and 15% worse compression.

{{ figure_markup(
  image="compression-levels-gzip.png",
  caption="Compression levels for Gzip.",
  description="Stacked bar charts showing the usage of compression levels of responses using Gzip, for compression level 1 to 9, as well as `opt` which corresponds to optimizers such as Zopfli. It shows peaks at level 1 and at level 6 extending through level 9. Each level is also broken down by content type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=586666706&format=interactive",
  sheets_gid="150560131"
  )
}}

The figure breaks down each compression level by content type. JavaScript is the most common content type in almost all cases. For Brotli, the proportion of JavaScript in the highest compression levels is higher than in the lower compression levels, while JSON is more common in the lower compression levels. For Gzip, the distribution of the JavaScript content type is roughly equal at all levels.

## How to analyze compression on sites

To check which content of a website is using HTTP compression, the [Firefox Developer Tools](https://developer.mozilla.org/en-US/docs/Tools) or the <a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a> can be used. In the developer tools, open the Network tab and reload your site. A list of responses such as HTML, CSS, JavaScript, fonts and images should appear. To see which ones are compressed, you can check the content encoding in their response header. You can enable a column to easily see this for all responses at once. To do this, right click on the column titles, and in the menu navigate to Response Headers and enable Content-Encoding.

Responses that are Gzip compressed will show "gzip", while those compressed with Brotli will show "br". If the value is blank, no HTTP compression is used. For images this is normal, since these resources are already compressed on their own.

{{ figure_markup(
  image="content-encoding.png",
  caption='Chrome DevTools checking the content-encoding of responses',
  description="Image showing how to use Chrome DevTools to see if content encoding is used.",
  width=575,
  height=828
  )
}}

 A different tool that can analyze compression on a site is Google's <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> tool. It runs a series of audits, including the <a hreflang="en" href="https://web.dev/uses-text-compression/">"Enable text compression" audit</a>. This audit attempts to compress resources to check if they reduced by at least 10% and 1,400 bytes. Depending on the score, it can show a compression recommendation in the results, with a list of the resources that can be compressed to benefit a website.

The HTTP Archive [runs Lighthouse audits](./methodology#lighthouse) for every mobile page, and from this data we observed that 72% of websites pass this audit. This is 2% less than [last year's](../2020/compression#identifying-compression-opportunities) 74%, which is despite more usage of text compression overall compared to last year, a slight drop.

{{ figure_markup(
  image="text-compression-lighthouse-scores.png",
  caption="Text compression Lighthouse scores.",
  description='Stacked bar chart breaking down the scores pages receive for the "enable text compression" Lighthouse audit. It shows that 16% of sites score less than 10%, 3.3% of sites are scoring between 10-39%, 5.8% of sites scoring between 40-79%, 2.8% of sites scoring between 80-99%, and 72.1% of sites have a pass with over 100% of text assets being compressed.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=261012442&format=interactive",
  sheets_gid="1612612722",
  sql_file="lighthouse_compression_scores.sql"
  )
}}

## How to improve on compression

Before thinking about how to compress content, it is often wise to reduce the content transmitted to begin with. One way of achieving this is to use so-called "minimizers", such as <a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>, <a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a>, or <a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a>.

After having the minimal form of the content to transmit, the next step is to ensure compression is enabled. You can verify it is enabled as highlighted in the previous section, and configure your web server if needed.

If using only Gzip compression (also known as Deflate or Zlib), adding support for Brotli can be beneficial. In comparison to Gzip, Brotli compresses to <a hreflang="en" href="https://quixdb.github.io/squash-benchmark/">smaller files at the same speed</a> and decompresses at the same speed.

You can choose a well-tuned compression level. What compression level is right for your application might depend on multiple factors, but keep in mind that a more heavily compressed text file does not need more CPU when decoding, so for precompressed assets there's no drawback from the user's perspective to set the compression levels as high as possible. For dynamic compression, we have to make sure that the user doesn't have to wait longer for a more heavily compressed file, taking both the time it takes to compress as well as the potentially decreased transmission time into account. This difference is borne out when looking at compression level recommendations for both methods.

When using Gzip compression for precompressed resources, consider using [Zopfli](https://en.wikipedia.org/wiki/Zopfli), which generates smaller Gzip compatible files. Zopfli uses an iterative approach to find an very compact parsing, leading to 3-8% denser output, but taking substantially longer to compute, whereas Gzip uses a more straightforward but less effective approach. See <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">this comparison between multiple compressors</a>, and this <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">comparison between Gzip and Zopfli</a> that takes into account different compression levels for Gzip.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Brotli</th>
        <th scope="col">Gzip</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Precompressed</td>
        <td>11</td>
        <td>9 or Zopfli</td>
      </tr>
      <tr>
        <td>Dynamically compressed</td>
        <td>5</td>
        <td>6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Recommended compression levels to use.") }}</figcaption>
</figure>

Improving the default settings on web server software would provide significant improvements to those who are not able to invest time into web performance, especially Gzip quality level 1 seems to be an outlier and would benefit from a default of 6, which compresses 15% better on the HTTP Archive `summary_response_bodies` data. Enabling Brotli by default instead of Gzip for user agents that support it would also provide a significant benefit.

## Conclusion

The analysis of compression levels used on 28,000 HTTP responses reveals that about 0.5% of Gzip-compressed content uses more advanced compressors such as Zopfli, while a similar "optimal parsing" approach is used for 17% of Brotli-compressed content. This indicates that when more efficient methods are available, even if slower, a significant number of users will deploy these methods for their static content.

Usage of HTTP compression continues to grow, and especially Brotli has increased significantly compared to the [previous year's chapter](../2020/compression). The number of HTTP responses using any text compression increased by 2%, while Brotli increased by over 4%. Despite the increase, we still see opportunities to use more HTTP compression by tweaking the compression settings of servers. You can benefit from taking a closer look at your own website's responses and your server configuration. Where compression is not used, you may consider enabling it, and where it is used you may consider tweaking the compression methods towards higher compression levels, both for dynamic content such as HTML generated on the fly, and static content. Changing the default compression settings in popular HTTP servers could have a great impact for users.



