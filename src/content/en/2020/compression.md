---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compression
description: Compression chapter of the 2020 Web Almanac covering HTTP compression, algorithms, content types, 1st party and 3rd party compression and opportunities.
hero_alt: Hero image of Web Almanac charactes using a ray gun to shrink an HTML page to make it much smaller.
authors: [mo271, veluca93, sboukortt, jyrkialakuijala]
reviewers: [paulcalvano]
analysts: [AbbyTsai]
editors: [exterkamp]
translators: []
jyrkialakuijala_bio: Jyrki Alakuijala is an active member of the open source software community, and a data compression researcher. Jyrki works at Google as a Technical Lead/Manager, and his recent published work has been with Zopfli, Butteraugli, Guetzli, Gipfeli, WebP lossless, Brotli, and JPEG XL compression formats and algorithms, and two hashing algorithms, CityHash, and HighwayHash. Before his Google employment he developed software for neurosurgery and radiation therapy treatment planning.
sboukortt_bio: Sami joined Google after completing his studies in engineering mathematics. After a few years of remote interest in compression, he eventually made it his full-time subject of work in 2018.
mo271_bio: Moritz Firsching is software engineer at Google Switzerland, where he works on progressive image formats and font compression. Before that Moritz did research as a mathematician studying polytopes.
veluca93_bio: Luca Versari is a software engineer at Google, working on <a hreflang="en" href="https://gitlab.com/wg1/jpeg-xl">JPEG XL</a>. He's finishing a PhD on graph compression and has a background in mathematics.
discuss: 2055
results: https://docs.google.com/spreadsheets/d/1NKbP4AqMkgCNCsVD3yLhO2d0aqIsgZ7AGLEtUDHl9yY/
featured_quote: Using HTTP compression makes a website load faster and therefore guarantees a better user experience.
featured_stat_1: 23%
featured_stat_label_1: Compressed responses which use Brotli
featured_stat_2: 77%
featured_stat_label_2: Compressed responses which use Gzip
featured_stat_3: 74%
featured_stat_label_3: Websites that pass the Lighthouse audit with maximum score on text compression
---

## Introduction

Using HTTP compression makes a website load faster and therefore guarantees a better user experience. Running no compression on HTTP makes for a worse user experience, may affect the growth rate of the related web service, and affects search rankings.  Effective use of compression can reduce [page weight](./page-weight), improves [web performance](./performance), and therefore is an important part of [search engine optimization](./seo).

While lossy compression is often acceptable for images and other [media](./media) types, for text we want to use lossless compression, i.e. recover the exact text after decompression.

## What type of content should we compress?

For most text-based assets, such as [HTML](./markup), [CSS](./css), [JavaScript](./javascript), JSON, or SVG, as well as certain non-text formats such as woff, ttf, ico, using compression is recommended.

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="Compression methods for different content types.",
  description="A stacked bar chart showing the usage rate of different compression algorithms broken down by the content type. The stacked bars divide up the use of Brotli, Gzip, and no compression. `text/html` is the only content type that is compressed less than 50% of the time. `application/json` and `image/svg+xml` are each approximately 64% compressed. `text/css` and `application/javascript` are each approximately 85% compressed. `application/x-javascript` and `text/javascript` are greater than 90% compressed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1658254159&format=interactive",
  sheets_gid="107138856",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

The figure shows the percent of responses of a certain content type using either Brotli, Gzip or no text compression.
It is surprising that while all those content types would profit from compression, the range of percentages varies widely over the different content types:  only 44% use compression for `text/html` against 93% for `application/x-javascript`.

For image-based assets text-based compression is less useful and not widely employed. The data shows that the percent of image responses that employ either Brotli, or Gzip is very low, less than 4%. For more info on non text-based assets, check out the [Media](./media) chapter.

{{ figure_markup(
  image="http-compression-methods-for-image-types.png",
  caption="Compression methods for image types on desktop.",
  description="This breaks down what compression methods, if any, are used for all the content types which are images. For all three image types, i.e. jpeg, png and gif, around 96.5% use no compression is used.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1287110333&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

## How to use HTTP compression?

To reduce the size of the files that we plan to serve one could first use some minimizers, e.g. <a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>, <a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a>, or <a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a>. However bigger gains are expected from using compression.

There are two ways of doing the compression on the server side:

  - Precompressed (compress and save assets ahead of time)
  - Dynamically Compressed (compress assets on-the-fly after a request is made)

Since precompression is done beforehand, we can spend more time compressing the assets. For dynamically compressed resources, we need to choose the compression levels such that compression takes less time than the time difference between sending an uncompressed versus a compressed file. This difference is borne out when looking at compression level recommendations for both methods.

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

Currently, practically all text compression is done by one of two HTTP content encodings: <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> and <a hreflang="en" href="https://github.com/google/brotli">Brotli</a>. Both are widely supported by browsers: <a hreflang="en" href="https://caniuse.com/?search=brotli">can I use Brotli</a>/<a hreflang="en" href="https://caniuse.com/?search=gzip">can I use Gzip</a>

When you want to use Gzip, consider using [Zopfli](https://en.wikipedia.org/wiki/Zopfli), which generates smaller Gzip compatible files. This should be done especially for precompressed resources, since here the greatest <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">gains are expected</a>. See this <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">comparison between Gzip and Zopfli</a> that takes into account different compression levels for Gzip.

Many [popular servers](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression) support dynamically and/or pre-compressed HTTP and many of them support [Brotli](https://en.wikipedia.org/wiki/Brotli).

## Current state of HTTP compression

Approximately 60% of HTTP responses are delivered with no text-based compression. This may seem like a surprising statistic, but keep in mind that it is based on all HTTP responses in the dataset. Some content, such as images, will not benefit from these compression algorithms and is therefore not often used, as shown in figure 19.2.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Combined</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No text compression</em></td>
        <td class="numeric">60.06%</td>
        <td class="numeric">59.31%</td>
        <td class="numeric">59.67%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30.82%</td>
        <td class="numeric">31.56%</td>
        <td class="numeric">31.21%</td>
      </tr>
      <tr>
        <td>Brotli</td>
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
  <figcaption>{{ figure_link(caption="Adoption of compression algorithms.", sheets_gid="1365871671", sql_file="19_01.type_of_content_encoding.sql") }}</figcaption>
</figure>

Of the resources that are served compressed, the majority are using either Gzip (77%) or Brotli (23%). The other compression algorithms are used infrequently.

{{ figure_markup(
  image="compression-algorithms-for-http-responses.png",
  caption="Compression algorithm for HTTP responses.",
  description="A bar chart showing the usage rates of different compression algorithms for HTTP responses. 77.39% of HTTP responses that use compression employ the Gzip algorithm, 22.59% use Brotli, and 0.03% use some other method.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1523202090&format=interactive",
  sheets_gid="1365871671",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

In the graph below, the top 11 content types are displayed with box sizes representing the relative number of responses. The color of each box represents how many of these resources were served compressed, orange indicates a low percentage of compression while blue indicates a high percentage of compression. Most of the media content is shaded orange, which is expected since Gzip and Brotli would have little to no benefit for them.  Most of the text content is shaded blue to indicate that they are being compressed. However, the light blue shading for some content types indicate that they are not compressed as consistently as the others.

{{ figure_markup(
  image="compression-algorithms-by-content-type-desktop.png",
  caption="Compression by type on desktop pages.",
  description="Treemap chart showing image/jpeg (91,926,198 responses - 3.27% compressed), application/javascript (80,360,676 responses - 84.88% compressed), image/png (66,351,767 responses - 3.7% compressed), text/css (54,104,482 responses - 84.0% compressed), text/html (48,670,006 responses - 44.25% compressed), image/gif (39,390,408 responses - 3.42% compressed), text/javascript (35,491,375 responses - 90.74% compressed), application/x-javascript (22,714,896 responses - 93.14% compressed), application/json (13,453,942 responses - 63.02% compressed), text/plain (4,629,644 responses - 32.89% compressed).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=777357707&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

Figure 19.1 above breaks down the percentage of compression used per content type, in figure 19.6 this percentage is indicated as color. The two figures tell similar stories, non-text based assets are rarely compressed, while text-based assets are often compressed. The rates of compression are also similar for both mobile and desktop.

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
        <td>Gzip</td>
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
  <figcaption>{{ figure_link(caption="First-party versus third-party compression by device type.", sheets_gid="862864630", sql_file="19_03.party_of_content_encoding.sql") }}</figcaption>
</figure>

When we compare compression techniques between first and third parties, we can see that third-party content tends to be compressed more than first-party content. Additionally, the percentage of Brotli compression is higher for third-party content. This is likely due to the number of resources served from the larger third parties that typically support Brotli, such as Google and Facebook.

Compared with [last year's results](../2019/compression#first-party-vs-third-party-compression), we can see that there was a significant increase in the use of compression, notably Brotli for first parties, almost to the point that the use of compression is around 40% for both first and third party, and for desktop and mobile. However within the responses that do use compression, for first parties, the ratio of Brotli compression is only 18%, while the ratio for third parties is 27%.

## How to analyze compression on your sites

You can use [Firefox Developer Tools](https://developer.mozilla.org/docs/Tools) or <a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a> to quickly figure out what content a website already compresses. To do this, go to the Network tab, right click and activate "Content Encoding" under Response Headers. Hovering over the size of individual files you will see "transferred over network" and "resource size". Aggregated for the entire site one can see size/transferred size for Firefox and  "transferred" and "resources" for Chrome on the bottom left hand side of the Network tab.

{{ figure_markup(
  image="content-encoding.png",
  caption='Use DevTools to check if content encoding is used on your site',
  description="Image showing how to use DevTools to see if content encoding is used.",
  width=591,
  height=939
  )
}}

Another tool to better understand compression on your site is Google's <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> tool, which enables you to run a series of audits against web pages. The <a hreflang="en" href="https://web.dev/uses-text-compression/">text compression audit</a> evaluates whether a site can benefit from additional text-based compression. It does this by attempting to compress resources and evaluate whether an object's size can be reduced by at least 10% and 1,400 bytes. Depending on the score, you may see a compression recommendation in the results, with a list of specific resources that could be compressed.

Because the [HTTP Archive runs Lighthouse audits](./methodology#lighthouse) for each mobile page, we can aggregate the scores across all sites to learn how much opportunity there is to compress more content. Overall, 74% of websites are passing this audit, while almost 13% of websites have scored below a 40. This is a 11.5% improvement when compared to [last year's](../2019/compression#identifying-compression-opportunities) 62.5% of passing scores.

{{ figure_markup(
  image="text-compression-lighthouse-scores.png",
  caption="Text compression Lighthouse scores.",
  description='Stacked bar chart breaking down the scores pages receive for the "enable text compression" Lighthouse audit. It shows that 7% of sites score less than 10%, 6% of sites are scoring between 10-39%, 10% of sites scoring between 40-79%, 3% of sites scoring between 80-99%, and 74% of sites have a pass with over 100% of text assets being compressed.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1438276663&format=interactive",
  sheets_gid="1284073179",
  sql_file="19_04.distribution_of_text_compression_lighthouse.sql"
  )
}}

## Conclusion

Compared with [last year's Almanac](../2019/compression), there is a clear trend towards using more text compression. The number of responses that don't use any text compression went down a little more than 2%, while at the same time the use of Brotli has increased by almost 2%. The Lighthouse scores have improved significantly.

Text compression is widely used for the relevant formats, although there is still a significant percentage of HTTP responses that could benefit from additional compression. You can profit from taking a close look at the configuration of your server and set compression methods and levels to your need. A great impact for a more positive user experience could be made by carefully choosing defaults for the most popular HTTP servers.
