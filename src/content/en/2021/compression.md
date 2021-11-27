---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compression
description: Compression chapter of the 2021 Web Almanac covering HTTP compression, algorithms, compression levels, content types, 1st party and 3rd party compression and opportunities.
authors: [lvandeve, mo271, jyrkialakuijala]
reviewers: [fischbacher, eustas]
analysts: [paulcalvano]
editors: []
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
unedited: true
---

## Introduction

Using HTTP compression makes a website load faster and therefore guarantees a better user experience. Running no compression on HTTP makes for a worse user experience, may affect the growth rate of the related web service, and can affect search rankings. Effective use of compression is an important part of [search engine optimization](./seo), because it can reduce [page weight](./page-weight) and improves [web performance](./performance).

While lossy compression works well for many images, audio and video, text as well as text-based data formats such as SVG require lossless compression, since we need to be able to recover the exact text after decompression.

## What type of content should we compress?

For most text-based assets, such as [HTML](./markup), [CSS](./css), [JavaScript](./javascript), JSON, or SVG, as well as certain non-text formats such as woff, ttf, ico, using compression is recommended.

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="Compression methods for different content types",
  description="A stacked bar chart showing the usage rate of different compression algorithms broken down by the content type. The stacked bars divide up the use of Brotli, Gzip, and no compression. `text/html` is the only content type that is compressed less than 50% of the time. `application/json` is approximately 68% compressed, `image/svg+xml` approximately 64%. `text/css` and `application/javascript` are each over 85% compressed. `application/x-javascript` and `text/javascript` are greater than 90% compressed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1292728213&format=interactive",
  sheets_gid="234112121",
  sql_file="compression_by_content_type.sql"
  )
}}

The figure shows the percent of responses of a certain content type using either Brotli, Gzip or no text compression. It is surprising that while all those content types would profit from compression, the range of percentages varies widely over the different content types: only 44% use compression for `text/html` against 93% for `application/x-javascript`.

For image-based assets and other media, text-based compression is less useful and not widely employed. The data shows that the percentage of image responses that employ either Brotli or Gzip is very low, less than 4%. It is possible that these are the result of a misconfiguration of web servers. For more info on non text-based assets, check out the [Media](./media) chapter.

{{ figure_markup(
  image="http-compression-methods-for-image-types.png",
  caption="Compression methods for image types on desktop.",
  description="This breaks down what compression methods, if any, are used for all the content types which are images. For all three image types, i.e. jpeg, png and gif, around 96% use no compression is used.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=157331869&format=interactive",
  sheets_gid="234112121",
  sql_file="compression_by_content_type.sql"
  )
}}

## How to use HTTP compression?

To reduce the size of the files that we plan to serve one could first use some minimizers, e.g. <a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>, <a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a>, or <a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a>. However bigger gains are expected from using compression.

For HTTP content encoding, the HTTP standard defines the [Accept-Encoding](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding)
request header, with which a HTTP client can announce the content
encodings it can handle to the server. The server\'s response can then
contain a [Content-Encoding](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding) header field that specifies which of the
encodings was chosen to transform the data in the response body.

There are two types of resources that can be compressed on the server
side:

  - Precompressed, also known as static content: can be compressed and
    stored ahead of time
  - Dynamically Compressed: can only be compressed on-the-fly after a
    request is made

Many [popular
servers](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression)
support dynamically and/or pre-compressed HTTP and many of them support
[Brotli](https://en.wikipedia.org/wiki/Brotli).

Practically all text compression is done by one of two HTTP content
encodings: <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> and
<a hreflang="en" href="https://github.com/google/brotli">Brotli</a>. Both are widely supported
by browsers: <a hreflang="en" href="https://caniuse.com/?search=brotli">can I use Brotli</a> /
<a hreflang="en" href="https://caniuse.com/?search=gzip">can I use Gzip</a>. On the server
side, most popular servers can be configured to use Brotli and/or Gzip.

Depending on the web server software you use, compression needs to be
enabled, and the configuration may be separate for precompressed and
dynamically compressed content. Here are a few pointers for two of the
most popular web servers. For <a hreflang="en" href="https://httpd.apache.org/">Apache</a>, Brotli can be enabled with
<a hreflang="en" href="https://httpd.apache.org/docs/2.4/mod/mod_brotli.html">mod\_brotli</a>, and Gzip with
<a hreflang="en" href="https://httpd.apache.org/docs/2.4/mod/mod_deflate.html">mod\_deflate</a>.
For <a hreflang="en" href="https://nginx.org/">NginX</a> instructions for <a hreflang="en" href="https://github.com/google/ngx_brotli">enabling Brotli</a>
and for <a hreflang="en" href="https://nginx.org/en/docs/http/ngx_http_gzip_module.html">enabling Gzip</a> are available as well.

## Current state of HTTP compression

The graph below shows the usage share trend of lossless compression from
the HTTPArchive metrics over the last 3 years. The usage of Brotli has
doubled since 2019, while the usage of Gzip has slightly decreased, and
overall the use of HTTP compression is growing on desktop and on mobile.

{{ figure_markup(
  image="compression-format-trend-desktop.png",
  caption="Compression method trend for desktop.",
  description="This breaks down the usage of Brotli, Gzip or No text compression on desktop for 2019, 2020 and 2021. For 2019, it shows 7.4% Brotli, 29.5% Gzip, 63.1% No text compression. For 2020, it shows 9.1% Brotli, 30.8% Gzip, 60.1% No text compression. For 2021, it shows 14.0% Brotli, 28.2% Gzip, 58.8% No text compression.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1962012452&format=interactive",
  sheets_gid="703407907",
  sql_file="compression_format_trend.sql"
  )
}}

{{ figure_markup(
  image="compression-format-trend-mobile.png",
  caption="Compression method trend for mobile.",
  description="This breaks down the usage of Brotli, Gzip or No text compression on mobile for 2019, 2020 and 2021. For 2019, it shows 7.5% Brotli, 30.8% Gzip, 61.6% No text compression. For 2020, it shows 9.1% Brotli, 31.6% Gzip, 59.3% No text compression. For 2021, it shows 14.3% Brotli, 28.6% Gzip, 57.1% No text compression.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=646268399&format=interactive",
  sheets_gid="703407907",
  sql_file="compression_format_trend.sql"
  )
}}

Of the resources that are served compressed, the majority are using either Gzip (66%) or Brotli (33%). The other compression algorithms are used infrequently.

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

In the [Third Parties](./third-parties) chapter, we learn about third parties and their impact on performance. Using third parties can also have an impact on compression.

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


From these results we can see that, [*compared to
2020*](../2020/compression#first-party-vs-third-party-compression), first party
content has caught up with third party content in the use of compression
and they use compression in comparable ways. Usage of compression and
especially Brotli has grown in both categories. Brotli compression has
doubled in percentage for first party content compared to a year ago.

## Compression levels

Compression level is a parameter given to the encoder adjusting the
amount of effort the encoder is applying to find redundancy in the
input, to consequently achieve higher compression density.

Brotli encoding allows compression levels from 0 to 11, while Gzip uses
levels 1 to 9 as well as higher optimal compression such as with Zopfli,
indicated `opt` in the graph below. A higher compression level results
in slower compression, but does not substantially affect the
decompression speed, even making it slightly faster.

We used the HTTPArchive `summary_response_bodies` data table to analyze
the compression levels currently used on the web. This is estimated by
re-compressing the responses with different compression level settings
and taking the closest actual size, based on around 14000 compressed
responses that used Brotli, and 14000 that used Gzip.

When plotting the amount of instances of each level, it shows two peaks for the most commonly used Brotli compression levels, one around compression level 5, and another at the maximum compression level. Usage of compression levels below 4 is rare.

{{ figure_markup(
  image="compression-levels-brotli.png",
  caption="Compression levels for Brotli.",
  description="This breaks down the usage of compression levels of responses using Brotli, for compression level 0 to 11. It shows peaks at level 5 and at level 11. Each level is also broken down by content type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1630047521&format=interactive",
  sheets_gid="150560131"
  )
}}

Gzip compression is applied largely around compression level 6,
extending to level 9. The peak at level 1 might be explained because
this is the default compression level of the popular web server <a hreflang="en" href="https://nginx.org/">NginX</a>.
For comparison, Gzip level 9 attempts thousands of redundancy matches, level 6 limits it to
about a hundred, while level 1 means limiting redundancy matching to only
four candidates and 15% worse compression.

{{ figure_markup(
  image="compression-levels-gzip.png",
  caption="Compression levels for Gzip.",
  description="This breaks down the usage of compression levels of responses using Gzip, for compression level 1 to 9, as well as `opt` which corresponds to optimizers such as Zopfli. It shows peaks at level 1 and at level 6, as well as a smaller peak at level 9. Each level is also broken down by content type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=586666706&format=interactive",
  sheets_gid="150560131"
  )
}}

## How to analyze compression on your sites

You can use [Firefox Developer Tools](https://developer.mozilla.org/en-US/docs/Tools) or <a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a> to quickly figure out what content a website already compresses. To do this, go to the Network tab, right click and activate "Content Encoding" under Response Headers. Hovering over the size of individual files you will see "transferred over network" and "resource size". Aggregated for the entire site one can see size/transferred size for Firefox and "transferred" and "resources" for Chrome on the bottom left hand side of the Network tab.


{{ figure_markup(
  image="../../2020/compression/content-encoding.png",
  caption='Use DevTools to check if content encoding is used on your site',
  description="Image showing how to use DevTools to see if content encoding is used.",
  width=591,
  height=939
  )
}}

Another tool to better understand compression on your site is Google's <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> tool, which enables you to run a series of audits against web pages. The <a hreflang="en" href="https://web.dev/uses-text-compression/">text compression audit</a> evaluates whether a site can benefit from additional text-based compression. It does this by attempting to compress resources and evaluate whether an object's size can be reduced by at least 10% and 1,400 bytes. Depending on the score, you may see a compression recommendation in the results, with a list of specific resources that could be compressed.

Because the [HTTP Archive runs Lighthouse audits](./methodology#lighthouse) for each mobile page, we can aggregate the scores across all sites to learn how much opportunity there is to compress more content. Overall, 72% of websites are passing this audit, while almost 16% of websites have scored 10 or less. This has dropped 2% compared to [last year's](../2020/compression#identifying-compression-opportunities) 74% of passing scores.



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

To improve compression of your site, a first step is to ensure
compression is enabled. You can verify it is enabled as highlighted in
the previous section, and configure your web server if needed.

When using only Gzip compression (also known as Deflate or Zlib), you can add
support for Brotli. Brotli compresses to <a hreflang="en" href="https://quixdb.github.io/squash-benchmark/">smaller files at the same speed</a>,
decompresses at the same speed, and is widely supported:
<a hreflang="en" href="https://caniuse.com/?search=brotli">can I use Brotli</a>.

You can choose a well-tuned compression level. What compression level is
right for your application might depend on multiple factors, but keep in
mind that a more heavily compressed text file does not need more CPU
when decoding, so for precompressed assets there's no drawback from the
user's perspective to set the compression levels as high as possible.
For dynamic compression, we have to make sure that the user doesn't have
to wait longer for a more heavily compressed file, taking both the time
it takes to compress as well as the potentially decreased transmission
time into account. This difference is borne out when looking at
compression level recommendations for both methods.

When using Gzip compression for precompressed resources, consider using
[Zopfli](https://en.wikipedia.org/wiki/Zopfli), which generates
smaller Gzip compatible files. Zopfli uses an iterative approach to find
an optimal parsing, leading to 3--8% denser output, but taking
substantially longer to compute, whereas Gzip uses a more
straightforward but less effective approach. See <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">this comparison between multiple compressors</a>,
and this <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">comparison between Gzip and Zopfli</a>
that takes into account different compression levels for Gzip.

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

Improving the default settings on web server software would provide
significant improvements to those who are not able to invest time into
web performance, especially Gzip quality level 1 seems to be an outlier
and would benefit from a default of 6, which compresses 15% better on
the HTTPArchive `summary_response_bodies` data. Enabling Brotli by
default instead of Gzip for user agents that support it would also
provide a significant benefit.

## Conclusion

Compared with the [previous year's Almanac](../2020/compression), the trend towards using more
text compression still continues, and especially Brotli has grown
significantly compared to last year. The number of responses using text
compression went up a little more than 2%, while at the same time the
use of Brotli has increased by over 4%. The Lighthouse scores, on the other hand, have dropped
slightly due to unknown causes. The highest score category has dropped 2%
from 2020, but is still 10% above the 2019 reading.

The analysis on compression levels reveals that about 6% of content in
Gzip format is compressed using more advanced compressors such as
Zopfli, while a similar \'optimal parsing\' approach is used for 17% of
content compressed with Brotli. This indicates that when much slower but
slightly more efficient methods are available, a significant amount of
users will deploy these methods for their static content such as
JavaScript.

Text compression is widely used for the relevant formats, although there
is still a significant percentage of HTTP responses that could benefit
from additional compression. You can profit from taking a close look at
the configuration of your server and set compression methods and levels
to your need. A great impact for a more positive user experience could
be made by carefully choosing defaults for the most popular HTTP
servers.



