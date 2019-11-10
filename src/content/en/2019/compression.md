---
part_number: IV
chapter_number: 15
title: Compression
description: Compression chapter of the 2019 Web Almanac covering HTTP compression, algorithms, content types, 1st party and 3rd party compression and opportunities.
authors: [paulcalvano]
reviewers: [obto, yoavweiss]
discuss: 1770
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-07T21:46:11.000Z 
---

## Introduction

HTTP compression is a technique that allows you to encode information using fewer bits than the original representation. When used for delivering web content, it enables web servers to reduce the amount of data transmitted to clients. This increases the efficiency of the client's available bandwidth, reduces [page weight](./page-weight), and improves [web performance](./performance).

Compression algorithms are often categorized as lossy or lossless: 

*   When a lossy compression algorithm is used, the process is irreversible, and the original file cannot be restored via decompression. This is commonly used to compress media resources, such as image and video content where losing some data will not materially affect the resource.
*   Lossless compression is a completely reversible process, and is commonly used to compress text based resources, such as [HTML](./markup), [JavaScript](./javascript), [CSS](./css), etc. 

In this chapter, we are going to explore how text-based content is compressed on the web. Analysis of non-text-based content forms part of the [Media](./media) chapter.


## How HTTP compression works

When a client makes an HTTP request, it often includes an [`Accept-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding) header to advertise the compression algorithms it is capable of decoding. The server can then select from one of the advertised encodings it supports and serve a compressed response. The compressed response would include a [`Content-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding) header so that the client is aware of which compression was used. Additionally, a [`Content-Type`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type) header is often used to indicate the [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types) of the resource being served. 

In the example below, the client advertised support for gzip, brotli, and deflate compression. The server decided to return a gzip compressed response containing a `text/html` document.


```
    > GET / HTTP/1.1
    > Host: httparchive.org
    > Accept-Encoding: gzip, deflate, br

    < HTTP/1.1 200  
    < Content-type: text/html; charset=utf-8
    < Content-encoding: gzip
```


The HTTP Archive contains measurements for 5.3 million web sites, and each site loaded at least 1 compressed text resource on their home page. Additionally, resources were compressed on the primary domain on 81% of web sites.


## Compression algorithms

IANA maintains a [list of valid HTTP content encodings](https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding) that can be used with the `Accept-Encoding` and `Content-Encoding` headers. These include gzip, deflate, br (brotli), as well as a few others. Brief descriptions of these algorithms are given below:

*   [Gzip](https://tools.ietf.org/html/rfc1952) uses the [LZ77](https://en.wikipedia.org/wiki/LZ77_and_LZ78#LZ77) and [Huffman coding](https://en.wikipedia.org/wiki/Huffman_coding) compression techniques, and is older than the web itself. It was originally developed for the UNIX gzip program in 1992. An implementation for web delivery has existed since HTTP/1.1, and most web browsers and clients support it.
*   [Deflate](https://tools.ietf.org/html/rfc1951) uses the same algorithm as gzip, just with a different container. Its use was not widely adopted for the web because of [compatibility issues](https://en.wikipedia.org/wiki/HTTP_compression#Problems_preventing_the_use_of_HTTP_compression) with some servers and browsers.
*   [Brotli](https://tools.ietf.org/html/rfc7932) is a newer compression algorithm that was [invented by Google](https://github.com/google/brotli). It uses the combination of a modern variant of the LZ77 algorithm, Huffman coding, and second order context modeling. Compression via brotli is more computationally expensive compared to gzip, but the algorithm is able to reduce files by [15-25%](https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf) more than gzip compression. Brotli was first used for compressing web content in 2015 and is [supported by all modern web browsers](https://caniuse.com/#feat=brotli).

Approximately 38% of HTTP responses are delivered with text-based compression. This may seem like a surprising statistic, but keep in mind that it is based on all HTTP requests in the dataset. Some content, such as images, will not benefit from these compression algorithms. The table below summarizes the percentage of requests served with each content encoding.

<figure>
  <table>
    <tr>
     <th></th>
     <th colspan="2" >Percent of Requests</th>
     <th colspan="2" >Requests</th>
    </tr>
    <tr>
     <th>Content Encoding</th>
     <th>Desktop</th>
     <th>Mobile</th>
     <th>Desktop</th>
     <th>Mobile</th>
    </tr>
    <tr>
     <td><em>No Text Compression</em></td>
     <td><p style="text-align: right">62.87%</p></td>
     <td><p style="text-align: right">61.47%</p></td>
     <td><p style="text-align: right">260,245,106</p></td>
     <td><p style="text-align: right">285,158,644</p></td>
    </tr>
    <tr>
     <td>gzip</td>
     <td><p style="text-align: right">29.66%</p></td>
     <td><p style="text-align: right">30.95%</p></td>
     <td><p style="text-align: right">122,789,094</p></td>
     <td><p style="text-align: right">143,549,122</p></td>
    </tr>
    <tr>
     <td>br
     </td>
     <td><p style="text-align: right">7.43%</p></td>
     <td><p style="text-align: right">7.55%</p></td>
     <td><p style="text-align: right">30,750,681</p></td>
     <td><p style="text-align: right">35,012,368</p></td>
    </tr>
    <tr>
     <td>deflate</td>
     <td><p style="text-align: right">0.02%</p></td>
     <td><p style="text-align: right">0.02%</p></td>
     <td><p style="text-align: right">68,802</p></td>
     <td><p style="text-align: right">70,679</p></td>
    </tr>
    <tr>
     <td><em>Other / Invalid</em></td>
     <td><p style="text-align: right">0.02%</p></td>
     <td><p style="text-align: right">0.01%</p></td>
     <td><p style="text-align: right">67,527</p></td>
     <td><p style="text-align: right">68,352</p></td>
    </tr>
    <tr>
     <td>identity</td>
     <td><p style="text-align: right">0.000709%</p></td>
     <td><p style="text-align: right">0.000563%</p></td>
     <td><p style="text-align: right">2,935</p></td>
     <td><p style="text-align: right">2,611</p></td>
    </tr>
    <tr>
     <td>x-gzip</td>
     <td><p style="text-align: right">0.000193%</p></td>
     <td><p style="text-align: right">0.000179%</p></td>
     <td><p style="text-align: right">800</p></td>
     <td><p style="text-align: right">829</p></td>
    </tr>
    <tr>
     <td>compress</td>
     <td><p style="text-align: right">0.000008%</p></td>
     <td><p style="text-align: right">0.000007%</p></td>
     <td><p style="text-align: right">33</p></td>
     <td><p style="text-align: right">32</p></td>
    </tr>
    <tr>
     <td>x-compress</td>
     <td><p style="text-align: right">0.000002%</p></td>
     <td><p style="text-align: right">0.000006%</p></td>
     <td><p style="text-align: right">8</p></td>
     <td><p style="text-align: right">29</p></td>
    </tr>
  </table>
  <figcaption>Figure 1. Adoption of compression algorithms.</figcaption>
</figure>

Of the resources that are served compressed, the majority are using either gzip (80%) or brotli (20%). The other compression algorithms are infrequently used.

<figure>
  <iframe aria-labelledby="fig2-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&amp;format=interactive"></iframe>
  <a href="/static/images/2019/15_Compression/fig2.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig2.png" aria-labelledby="fig2-caption" width="600">
  </a>
  <div id="fig2-caption" class="visually-hidden">Pie chart of the data table in Figure 1.</div>
  <figcaption>Figure 2. Adoption of compression algorithms on desktop pages.</figcaption>
</figure>

Additionally, there are 67K requests that return an invalid `Content-Encoding`, such as "none", "UTF-8", "base64", "text", etc. These resources are likely served uncompressed.

We can't determine the compression levels from any of the diagnostics collected by the HTTP Archive, but the best practice for compressing content is:

*   At a minimum, enable gzip compression level 6 for text based assets. This provides a fair tradeoff between computational cost and compression ratio and is the [default for many web servers](https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/)—though [Nginx still defaults to the, often too low, level 1](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level).
*   If you can support brotli and precompress resources, then compress to brotli level 11.  This is more computationally expensive than gzip - so precompression is an absolute must to avoid delays. 
*   If you can support brotli and are unable to precompress, then compress to brotli level 5. This level will result in smaller payloads compared to gzip, with a similar computational overhead.


## What types of content are we compressing?

Most text based resources (such as HTML, CSS, and JavaScript) can benefit from gzip or brotli compression. However, it's often not necessary to use these compression techniques on binary resources, such as images, video, and some web fonts because their file formats are already compressed.

In the graph below, the top 25 content types are displayed with box sizes representing the relative number of requests. The color of each box represents how many of these resources were served compressed. Most of the media content is shaded orange, which is expected since gzip and brotli would have little to no benefit for them.  Most of the text content is shaded blue to indicate that they are being compressed. However, the light blue shading for some content types indicate that they are not compressed as consistently as the others. 

<figure>
  <iframe aria-labelledby="fig3-caption" width="779.5" height="481.99083333333334" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&amp;format=interactive"></iframe>
  <a href="/static/images/2019/15_Compression/fig3.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig3.png" aria-labelledby="fig3-caption" width="600">
  </a>
  <div id="fig3-caption" class="visually-hidden">Figure 3. Top 25 compressed content types.</div>
  <figcaption>Figure 3. Top 25 compressed content types.</figcaption>
</figure>

Filtering out the eight most popular content types allows us to see the compression stats for the rest of these content types more clearly.

<figure>
  <iframe aria-labelledby="fig4-caption" width="779.5" height="481.99083333333334" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&amp;format=interactive"></iframe>
  <a href="/static/images/2019/15_Compression/fig4.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig4.png" aria-labelledby="fig4-caption" width="600">
  </a>
  <div id="fig3-caption" class="visually-hidden">Figure 4. Compressed content types, excluding top 8.</div>
  <figcaption>Figure 4. Compressed content types, excluding top 8.</figcaption>
</figure>

The `application/json` and `image/svg+xml` content types are compressed less than 65% of the time.

Most of the custom web fonts are served without compression, since they are already in a compressed format. However, `font/ttf` is compressible, but only 84% of TTF font requests are being served with compression so there is still room for improvement here.

The graphs below illustrate the breakdown of compression techniques used for each content type. Looking at the top three content types, we can see that across both desktop and mobile there are major gaps in compressing some of the most frequently requested content types. 56% of `text/html` as well as 18% of `application/javascript` and `text/css` resources are not being compressed. This presents a significant performance opportunity.

<figure>
  <iframe aria-labelledby="fig5-caption" width="760" height="470" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&amp;format=interactive"></iframe>
  <a href="/static/images/2019/15_Compression/fig5.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig5.png" aria-labelledby="fig5-caption" width="600">
  </a>
  <div id="fig5-caption" class="visually-hidden">Figure 5. Compression by content type for desktop.</div>
  <figcaption>Figure 5. Compression by content type for desktop.</figcaption>
</figure>

<figure>
  <iframe aria-labelledby="fig6-caption" width="760" height="470" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&amp;format=interactive"></iframe>
  <a href="/static/images/2019/15_Compression/fig6.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig6.png" aria-labelledby="fig6-caption" width="600">
  </a>
  <div id="fig6-caption" class="visually-hidden">Figure 6. Compression by content type for mobile.</div>
  <figcaption>Figure 6. Compression by content type for mobile.</figcaption>
</figure>

The content types with the lowest compression rates include `application/json`, `text/xml`, and `text/plain`. These resources are commonly used for XHR requests to provide data that web applications can use to create rich experiences. Compressing them will likely improve user experience.  Vector graphics such as `image/svg+xml`, and `image/x-icon` are not often thought of as text based, but they are and sites that use them would benefit from compression.

<figure>
  	<iframe aria-labelledby="fig7-caption" width="760" height="470" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&amp;format=interactive"></iframe>
    <a href="/static/images/2019/15_Compression/fig7.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig7.png" aria-labelledby="fig7-caption" width="600">
  </a>
  <div id="fig5-caption" class="visually-hidden">Figure 7. CCompression by content type as a percent for desktop</div>
  <figcaption>Figure 7. Compression by content type as a percent for desktop.</figcaption>
</figure>

<figure>
 <iframe aria-labelledby="fig8-caption" width="760" height="470" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&amp;format=interactive"></iframe>
  <a href="/static/images/2019/15_Compression/fig8.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig8.png" aria-labelledby="fig6-caption" width="600">
  </a>
  <div id="fig8-caption" class="visually-hidden">Figure 8. Compression by content type as a percent for desktop</div>
  <figcaption>Figure 8. Compression by content type as a percent for desktop.</figcaption>
</figure>

Across all content types, gzip is the most popular compression algorithm. The newer brotli compression is used less frequently, and the content types where it appears most are `application/javascript`, `text/css` and `application/x-javascript`. This is likely due to CDNs that automatically apply brotli compression for traffic that passes through them. 

## First party vs third party compression

In the [Third Parties](./third-parties) chapter, we learned about third parties and their impact on performance. When we compare compression techniques between first and third parties, we can see that third party content tends to be compressed more than first party content. 

Additionally, the percentage of brotli compression is higher for third party content. This is likely due to the number of resources served from the larger third parties that typically support brotli, such as Google and Facebook.

<figure>
  <table>
    <tr>
     <th></th>
     <th colspan="2">Desktop</th>
     <th colspan="2">Mobile</th>
    </tr>
    <tr>
     <th>Content Encoding</th>
     <th>First Party</th>
     <th>Third Party</th>
     <th>First Party</th>
     <th>Third Party</th>
    </tr>
    <tr>
     <td><em>No Text Compression</em></td>
     <td><p style="text-align: right">66.23%</p></td>
     <td><p style="text-align: right">59.28%</p></td>
     <td><p style="text-align: right">64.54%</p></td>
     <td><p style="text-align: right">58.26%</p></td>
    </tr>
    <tr>
     <td>gzip</td>
     <td><p style="text-align: right">29.33%</p></td>
     <td><p style="text-align: right">30.20%</p></td>
     <td><p style="text-align: right">30.87%</p></td>
     <td><p style="text-align: right">31.22%</p></td>
    </tr>
    <tr>
     <td>br</td>
     <td><p style="text-align: right">4.41%</p></td>
     <td><p style="text-align: right">10.49%</p></td>
     <td><p style="text-align: right">4.56%</p></td>
     <td><p style="text-align: right">10.49%</p></td>
    </tr>
    <tr>
     <td>deflate</td>
     <td><p style="text-align: right">0.02%</p></td>
     <td><p style="text-align: right">0.01%</p></td>
     <td><p style="text-align: right">0.02%</p></td>
     <td><p style="text-align: right">0.01%</p></td>
    </tr>
    <tr>
     <td><em>Other / Invalid</em></td>
     <td><p style="text-align: right">0.01%</p></td>
     <td><p style="text-align: right">0.02%</p></td>
     <td><p style="text-align: right">0.01%</p></td>
     <td><p style="text-align: right">0.02%</p></td>
    </tr>
  </table>
  <figcaption>Figure 9</figcaption>
</figure>

## Identifying compression opportunities

Google's [Lighthouse](https://developers.google.com/web/tools/lighthouse) tool enables users to run a series of audits against web pages. The [text compression audit](https://developers.google.com/web/tools/lighthouse/audits/text-compression) evaluates whether a site can benefit from additional text-based compression. It does this by attempting to compress resources and evaluate whether an object's size can be reduced by at least 10% and 1,400 bytes. Depending on the score, you may see a compression recommendation in the results, with a list of specific resources that could be compressed.

<figure>
  <a href="/static/images/2019/15_Compression/ch15_fig8_lighthouse.jpg">
    <img src="/static/images/2019/15_Compression/ch15_fig8_lighthouse.jpg" alt="" width="600">
  </a>
  <figcaption>Figure 10. Lighthouse compression suggestions.</figcaption>
</figure>

Because the [HTTP Archive runs Lighthouse audits](./methodology#lighthouse) for each mobile page, we can aggregate the scores across all sites to learn how much opportunity there is to compress more content. Overall, 62% of websites are passing this audit and almost 23% of websites have scored below a 40. This means that over 1.2 million websites could benefit from enabling additional text based compression.

<figure>
  	<iframe aria-labelledby="fig11-caption" width="760" height="330.50000000000006" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&amp;format=interactive"></iframe>
    <a href="/static/images/2019/15_Compression/fig11.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig11.png" aria-labelledby="fig11-caption" width="600">
  </a>
  <div id="fig11-caption" class="visually-hidden">Figure 11. Lighthouse "enable text compression" audit scores.</div>
  <figcaption>Figure 11. Lighthouse "enable text compression" audit scores.</figcaption>
</figure>

Lighthouse also indicates how many bytes could be saved by enabling text-based compression. Of the sites that could benefit from text compression, 82% of them can reduce their page weight by up to 1 MB!

<figure>
  	<iframe aria-labelledby="fig12-caption" width="760" height="330.50000000000006" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&amp;format=interactive"></iframe>
    <a href="/static/images/2019/15_Compression/fig12.png" class="fig-mobile">
    <img src="/static/images/2019/15_Compression/fig12.png" aria-labelledby="fig12-caption" width="600">
  </a>
  <div id="fig12-caption" class="visually-hidden">Figure 12. Lighthouse "enable text compression" audit potential byte savings./div>
  <figcaption>Figure 12. Lighthouse "enable text compression" audit potential byte savings.</figcaption>
</figure>

## Conclusion

HTTP compression is a widely used and highly valuable feature for reducing the size of web content. Both gzip and brotli compression are the dominant algorithms used, and the amount of compressed content varies by content type. Tools like Lighthouse can help uncover opportunities to compress content.

While many sites are making good use of HTTP compression, there is still room for improvement, particularly for the `text/html` format that the web is built upon! Similarly, lesser-understood text formats like `font/ttf`, `application/json`, `text/xml`, `text/plain`, `image/svg+xml`, and `image/x-icon` may take extra configuration that many websites miss.

At a minimum, websites should use gzip compression for all text-based resources, since it is widely supported, easily implemented, and has a low processing overhead. Additional savings can be found with brotli compression, although compression levels should be chosen carefully based on whether a resource can be precompressed.
