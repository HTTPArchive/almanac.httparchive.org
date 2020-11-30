---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: IV
chapter_number: 19
title: Compression
description: Compression chapter of the 2020 Web Almanac covering HTTP compression, algorithms, content types, 1st party and 3rd party compression and opportunities.
authors: [mo271, veluca93, sboukortt, jyrkialakuijala]
reviewers: [paulcalvano]
analysts: [AbbyTsai]
translators: []
jyrkialakuijala_bio: Jyrki Alakuijala works as a software engineer at Google Switzerland.
sboukortt_bio: Sami Boukortt works as a software engineer at Google Switzerland.
mo271_bio: Moritz Firsching works as a software engineer at Google Switzerland.
veluca93_bio: Luca Versari works as a software engineer at Google Switzerland.
discuss: 2055
results: https://docs.google.com/spreadsheets/d/1NKbP4AqMkgCNCsVD3yLhO2d0aqIsgZ7AGLEtUDHl9yY/
queries: 19_Compression
featured_quote: Using HTTP compression makes a website load faster and therefore guarantees a better user experience.
#featured_stat_1: 23%
#featured_stat_label_1: Compressed requests which use brotli
#featured_stat_2: 77%
#featured_stat_label_2: Compressed requests which use gzip
#featured_stat_3: 74%
#featured_stat_label_3: Websites that pass the Lighthouse audit with maximum score on text compression
---

## Introduction


Using HTTP compression makes a website load faster and therefore guarantees a better user experience. Running no compression on HTTP makes for a worse user experience, may affect the growth rate of the related web service and affects search rankings. Using compression likely produces a web experience that performs better on metrics such as faster Largest Contentful Paint. Using compression reduces [page weight](./page-weight), improves [web performance](./performance), and therefore is an important part of [search engine optimization](./seo).


While lossy compression is often acceptable for images and other [media](./media) types, for text we want to use lossless compression, i.e. recover the exact text after decompression.

## What type of content should we compress?

For most text-based assets, such as [HTML](./markup), [CSS](./css), [JavaScript](./javascript), [JSON](https://www.json.org) or SVG, as well as certain non-text formats such as woff, ttf, ico, using compression is recommended.
Here is an overview over what compression methods are currently used for different content types:

{{ figure_markup(
  image="compression_usage.png",
  caption="Compression Methods for Different Content Types",
  description="This breaks down what compression methods, if any, are used for all the content types which are not images.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1658254159&format=interactive",
  sql_file="19_01.type_of_content_encoding.sql",
  width="800",
  height="622"
  )
}}
The figure shows the percentages of the request of a certain content type using either brotli, gzip or no text compression.
It is surprising that while all those content types would profit from compression, the range of percentages varies widely over the different content types:  only 44% use compression for `text/html` against  93% `application/x-javascript`.


## How to use HTTP compression?

To reduce the file sizes of the files that we plan to serve you could first use a some minimizers, e.g. [HTMLMinifier](https://github.com/kangax/html-minifier), [CSSNano](https://github.com/ben-eb/cssnano)
 or [UglifyJS](https://github.com/mishoo/UglifyJS2). However bigger gains are expected from using compression.

There are two ways of doing the compression on the server side:

  - Precompressed (compress and save assets ahead of time)
  - Dynamically Compressed (compress assets on-the-fly after a request is made)

Since precompression is done beforehand, we can spend more time compressing the assets. For dynamically compressed resources we need to choose the compression levels such that compression takes less time than time difference between sending an uncompressed versus a compressed file. Currently practically all text compression is done by one of two HTTP content encodings: [Gzip](https://tools.ietf.org/html/rfc1952) and [brotli](https://github.com/google/brotli). Both are widely supported by browsers: [can I use brotli](https://caniuse.com/?search=brotli)/[can I use gzip](https://caniuse.com/?search=gzip)
When you want to use gzip, consider using [Zopfli](https://en.wikipedia.org/wiki/Zopfli), which generates smaller gzip compatible files. This should be done especially for precompressed resourses, since here the greatest [gains are expected](https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf) . See this [comparison between gzip and zopfli](https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/) that takes into account different compression levels for gzip.


Many popular servers support dynamically and/or pre-compressed HTTP  (https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression) and many of them support Brotli: https://en.wikipedia.org/wiki/Brotli


Here are some general recommendations on what compression levels to use:

|                         | brotli  | gzip            |
| ----------------------- | ------- | --------------- |
| precompressed           |  11     |   9 or zopfli   |
| dynamically compressed  |   5     |   6             |

Currently, when compression is used, the split between brotli and gzip is about 23% / 77%.

Approximately 60% of HTTP responses are delivered with text-based compression. This may seem like a surprising statistic, but keep in mind that it is based on all HTTP requests in the dataset. Some content, such as images, will not benefit from these compression algorithms. The table below summarizes the percentage of requests served with each content encoding.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="3" >Percent of Requests</th>
      </tr>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Combined</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No Text Compression</em></td>
        <td class="numeric">60.06%</td>
        <td class="numeric">59.31%</td>
        <td class="numeric">59.67%</td>
      </tr>
      <tr>
        <td>gzip</td>
        <td class="numeric">30.82%</td>
        <td class="numeric">31.56%</td>
        <td class="numeric">31.21%</td>
      </tr>
      <tr>
        <td>br</td>
        <td class="numeric">9.10%</td>
        <td class="numeric">9.11%</td>
        <td class="numeric">9.11%</td>
      </tr>
      </tr>
      <tr>
        <td><em>Other</em></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adoption of compression algorithms.") }}</figcaption>
</figure>

Of the resources that are served compressed, the majority are using either gzip (77%) or brotli (23%). The other compression algorithms are used infrequently.

{{ figure_markup(
  image="fig2.png",
  caption="Compression algorithms .",
  description="Pie chart of some data table in Figure 15.1. Around 77% use gzip, the remaining 23% use brotli.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=534412828&amp;format=interactive"
  )
}}


## Current state of HTTP compression

In the graph below, the top 11 content types are displayed with box sizes representing the relative number of requests. The color of each box represents how many of these resources were served compressed. Most of the media content is shaded orange, which is expected since gzip and brotli would have little to no benefit for them.  Most of the text content is shaded blue to indicate that they are being compressed. However, the light blue shading for some content types indicate that they are not compressed as consistently as the others.

{{ figure_markup(
  image="fig3.png",
  caption="Top 11 compressed content types.",
  description="Treemap chart showing image/jpeg (91,926,198 requests - 3.27% compressed), application/javascript (80,360,676 requests - 84.88% compressed), image/png (66,351,767 requests - 3.7% compressed), text/css (54,104,482 requests - 84.0% compressed), text/html (48,670,006 requests - 44.25% compressed), image/gif (39,390,408 requests - 3.42% compressed), text/javascript (35,491,375 requests - 90.74% compressed), application/x-javascript (22,714,896 requests - 93.14% compressed), application/json (13,453,942 requests - 63.02% compressed), text/plain (4,629,644 requests - 32.89% compressed).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=777357707&amp;format=interactive",
  width=814,
  height=503,
  )
}}


Figure 19.1 above breaks down the percentages indicated as shadings in Figure 19.4 for the data types that should use compression.
They are almost identical for desktop and mobile.
Here's the analogous figure for those data types that ordinarily don't profit from further compression:


{{ figure_markup(
  image="fig5.png",
  description="This breaks down what compression methods, if any, are used for all the content types which are images. For all three image types, i.e. jpeg, png and gif, around 96.5% use no compression is used.",
  caption="Compression by content type as a percent for desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1287110333&amp;format=interactive",
  width=800,
  height=360,
  )
}}

## First-party vs third-party compression

In the [Third Parties](./third-parties) chapter, we learn about third parties and their impact on performance. When we compare compression techniques between first and third parties, we can see that third-party content tends to be compressed more than first-party content.

Additionally, the percentage of brotli compression is higher for third-party content. This is likely due to the number of resources served from the larger third parties that typically support brotli, such as Google and Facebook.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">First-Party</th>
        <th scope="col">Third-Party</th>
        <th scope="col">First-Party</th>
        <th scope="col">Third-Party</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No Text Compression</em></td>
        <td class="numeric">61.93%</td>
        <td class="numeric">57.81%</td>
        <td class="numeric">60.36%</td>
        <td class="numeric">58.11%</td>
      </tr>
      <tr>
        <td>gzip</td>
        <td class="numeric">30.95%</td>
        <td class="numeric">30.66%</td>
        <td class="numeric">32.36%</td>
        <td class="numeric">30.65%</td>
      </tr>
      <tr>
        <td>br</td>
        <td class="numeric">7.09%</td>
        <td class="numeric">11.51%</td>
        <td class="numeric">7.26%</td>
        <td class="numeric">11.22%</td>
      </tr>
      <tr>
        <td>deflate</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><em>Other / Invalid</em></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="First-party versus third-party compression by device type.") }}</figcaption>
</figure>

Comparing with [last year's results](https://almanac.httparchive.org/en/2019/compression#first-party-vs-third-party-compression), we can see that there was a significant increase in the use of compression, notably brotli for first parties, almost to the point that the use of compression is around 40% for both first and third party and for desktop and mobile. However within the requests that do use compression, for first party the ratio of brotli compression is only 18%, while the ratio for third party is 27%.


## How to Analyze compression on your sites

You can you [Firefox Developer Tools](https://developer.mozilla.org/en-US/docs/Tools) or [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools) to quickly figure out for what content a website already uses some kind of compression.
For this go to Network tab, right click and activate "Content Encoding" under Response Headers. Hovering over the size of individual files you will see "transferred over network" and "resource size". Aggregated for the entire site one can see size/transferred size for Firefox and  "transferred" and "resources" for Chrome on the bottom left hand side of the Network tab.

{{ figure_markup(
  image="content_encoding.png",
  alt="How to check content encoding in DevTools",
  caption='Use DevTools to check if content encoding is used on your site',
  description="Image showing how to use DevTools to see if content encoding is used.",
  width=591,
  height=939
  )
}}

Another tool to better understand compression on your site is Google's [Lighthouse](https://developers.google.com/web/tools/lighthouse) tool enables users to run a series of audits against web pages. The [text compression audit](https://developers.google.com/web/tools/lighthouse/audits/text-compression) evaluates whether a site can benefit from additional text-based compression. It does this by attempting to compress resources and evaluate whether an object's size can be reduced by at least 10% and 1,400 bytes. Depending on the score, you may see a compression recommendation in the results, with a list of specific resources that could be compressed.


Because the [HTTP Archive runs Lighthouse audits](./methodology#lighthouse) for each mobile page, we can aggregate the scores across all sites to learn how much opportunity there is to compress more content. Overall, 74% of websites are passing this audit and almost 13% of websites have scored below a 40. Compared to [last year's](https://almanac.httparchive.org/en/2019/compression#identifying-compression-opportunities) 62.5%, this year already 74% of the observed pages have the best text compression Lighthouse audio score.

{{ figure_markup(
  image="fig11.png",
  caption="Lighthouse \"enable text compression\" audit scores.",
  description="Stacked bar chart showing 7% are costing less than 10%, 6% of sites are scoring between 10-39%, 10% of sites scoring between 40-79%, 3% of sites scoring between 80-99%, and 74% of sites have a pass with over 100% of text assets being compressed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1438276663&amp;format=interactive",
  width=600,
  height=371,
  data_width=600,
  data_height=371
  )
}}

## Conclusion

Compared with [last year's almanac](../2019/compression), there is a clear trend towards using more text compression. The number of requests that don't use any text compression went down a little more than 2%, while at the same time the use of brotli has increased by almost 2%. The Lighthouse scores have improved significantly.

Text compression is widely used for the relevant formats, although there is still a significant percentage of the http-requests that could benefit from additional compression. You can profit from taking a close look at the configuration of your server and set compression methods and levels to your need. A great impact for a more positive user experience could be made by carefully choosing defaults for the most popular http servers.

