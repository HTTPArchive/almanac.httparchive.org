---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Media chapter of the 2021 Web Almanac covering how images and videos are currently being encoded, embedded, styled, and delivered on the web
authors: [eeeps, dougsillars]
reviewers: [navaneeth, tpiros, akshay, addyosmani]
analysts: [eeeps, dougsillars, akshay]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---


Almost three decades ago [the `&lt;img&gt;` tag dropped](https://thehistoryoftheweb.com/the-origin-of-the-img-tag/) and hyper_text_ became hyper_media_. The web has become increasingly visual, ever since. What is the state of media on the web in 2021? Let’s look at images and videos, in turn.


## Images

Images are ubiquitous on the web.

{{ figure_markup( content="96%", caption="Percentage of pages that contained at least one contentful `&lt;img&gt;`", classes="big-number", sheets_gid="1756671383", sql_file="at_least_one_img.sql" ) }}

{{ figure_markup( content="99.93%", caption="Percentage of pages that generated at least one request for an image resource", classes="big-number", sheets_gid="1062090109", sql_file="at_least_one_image_request.sql" ) }}

Put simply, almost every page contains image content and effectively all pages serve up _some_ sort of imagery (even if it’s just a background or favicon).

The impact that all of these images have is hard to overstate. [As the Page Weight chapter highlights](https://almanac.httparchive.org/en/2021/page-weight), images are still responsible for more bytes per page than any other resource type. However, year-over-year, image transfer size has decreased.

{{ figure_markup( image="mobile-image-transfer-size-by-year.png", caption="Mobile image transfer size by year", description="Bar chart showing the distribution of total image transfer sizes, per page, and how it‘s changed between 2020 and 2021. At the 25th percentile, transfer sizes have reduced from 277 kB to 257 kB. At the 50th, they've shrunk from 916 kB to 877 kB. And at the 75th percentile, they've gone down from 2,352 kB to 2,324 kB.", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=478222195&format=interactive", sheets_gid="381418851", sql_file="bytes_per_type_2021.sql" ) }}

This is surprising; for the last decade, the [Image Bytes](https://httparchive.org/reports/state-of-images#bytesImg) chart on the HTTP Archive’s monthly [State of Images report](https://httparchive.org/reports/state-of-images) has seemingly only ever gone one direction: up. What reversed this trend in 2021? I think it may have something to do with native lazy-loading’s rapid adoption; more on that later in the chapter.

In any case, by quantity, images continue to make up an awful lot of the _stuff_ of the web. But tallying the sheer number of elements, requests, and bytes doesn’t tell us how crucial images are to users’ experiences. To get a sense of that, we can look at the [Largest Contentful Paint](https://web.dev/lcp/) metric, which tries to identify the most important piece of above-the-fold content on any given page. [As you can see in the Performance chapter](https://almanac.httparchive.org/en/2021/performance#fig-19), the LCP element has an image on around three quarters of pages.

71%

Mobile pages whose LCP element has an image. On the desktop it’s 79%!

[query link TODO]

Images are crucial to user’s experiences of the web! Let’s dive in, taking a closer look at how they’re encoded, embedded, laid out, and delivered.


### Encoding


#### Dimensions


##### Single-pixel images

We’ll start small. Many `&lt;img>` elements don’t actually represent contentful [images](https://www.merriam-webster.com/dictionary/image); instead, they contain a only a single – likely invisible – pixel:


<table>
  <tr>
   <td>
   </td>
   <td><em>Percent of images which are 1x1</em>
   </td>
  </tr>
  <tr>
   <td><em>Mobile</em>
   </td>
   <td><em>7.5%</em>
   </td>
  </tr>
  <tr>
   <td><em>Desktop</em>
   </td>
   <td><em>7.0%</em>
   </td>
  </tr>
</table>


_[query link TODO]_

These single-pixel `&lt;img>` elements  are, put bluntly, hacks: they are being abused either to do layout (which would be better done with CSS) or to track users (which would be better accomplished using the [Beacon API](https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API)).

We can establish a baseline breakdown of what jobs all of these single-pixel `&lt;img>`s are doing by looking at how many use [data URIs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs).


<table>
  <tr>
   <td>
   </td>
   <td><em>Percent of single-pixel `&lt;img>`s which use data URIs</em>
   </td>
  </tr>
  <tr>
   <td><em>Mobile</em>
   </td>
   <td><em>44.7%</em>
   </td>
  </tr>
  <tr>
   <td><em>Desktop</em>
   </td>
   <td><em>47.1%</em>
   </td>
  </tr>
</table>


[query link TODO]

The single-pixel `&lt;img>`s containing data URIs are almost certainly being used for layout. The remaining ~54% which generate a request might be there for layout or they might be tracking pixels; we can’t tell.

Note that throughout the rest of this analysis, we have excluded single-pixel `&lt;img>`s from the results. We’re interested in `&lt;img>` elements that are presenting visual information to the user, not tracking pixels or layout hacks.


##### Multiple-pixel images

When `&lt;img>`s contain more than one pixel – how many pixels do they contain?



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


[todo query link]

The median `&lt;img>` loads ~40,000 pixels on both desktop and mobile. I found this number surprisingly small. Just under half of crawled`&lt;img>`s (excluding the ones that loaded single-pixel images, or nothing at all) contain fewer pixels than a 200x200 image. When you consider the number of `&lt;img>` elements per page, though, this statistic is less surprising. Most pages contain more than 15 images, so while images with more than half-a-megapixel might only account for one in ten `&lt;img>` elements, they are not at all uncommon, as we navigate across pages.



<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


I was also surprised that there was almost no difference between desktop and mobile top end of the pixel count distribution. Initially, this seemed to indicate a lack of effective adoption of responsive image features, but when you consider that the mobile crawler has a 360 × 512px @3x viewport, while the desktop viewport is 1,376 × 768px @1x, it isn’t actually surprising: the crawlers’ viewports had similar widths, in physical pixels (1,080 vs 1,376). A bigger difference in physical pixel resolution between the crawlers would be more revealing.


##### Aspect ratios

Images on the web are mostly landscape-oriented, and portrait-oriented images are relatively rare.



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


[TODO query link]

This feels like a missed opportunity on mobile. The success of the [ “stories” UI pattern](https://uxdesign.cc/the-powerful-interaction-design-of-instagram-stories-47cdeb30e5b6) shows that there’s value in imagery tailored to fill portrait-oriented mobile screens.

Images’ aspect ratios were clustered around “standard” values, such as 4:3, 16:9, and especially 1:1 (square). The top 10 aspect ratios accounted for nearly half of all `&lt;img>`s:


<table>
  <tr>
   <td><em>Aspect ratio</em>
   </td>
   <td>Percent of images (desktop)
   </td>
   <td>Percent of images (mobile)
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
1:1</p>

   </td>
   <td><p style="text-align: right">
32.9%</p>

   </td>
   <td><p style="text-align: right">
32.7%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
4:3</p>

   </td>
   <td><p style="text-align: right">
3.7%</p>

   </td>
   <td><p style="text-align: right">
4.1%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
3:2</p>

   </td>
   <td><p style="text-align: right">
2.5%</p>

   </td>
   <td><p style="text-align: right">
2.6%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
2:1</p>

   </td>
   <td><p style="text-align: right">
1.6%</p>

   </td>
   <td><p style="text-align: right">
1.7%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
16:9</p>

   </td>
   <td><p style="text-align: right">
1.5%</p>

   </td>
   <td><p style="text-align: right">
1.5%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
4:3</p>

   </td>
   <td><p style="text-align: right">
0.9%</p>

   </td>
   <td><p style="text-align: right">
1.0%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
2:3</p>

   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
5:3</p>

   </td>
   <td><p style="text-align: right">
0.6%</p>

   </td>
   <td><p style="text-align: right">
0.5%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
6:5</p>

   </td>
   <td><p style="text-align: right">
0.5%</p>

   </td>
   <td><p style="text-align: right">
0.5%</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
8:5</p>

   </td>
   <td><p style="text-align: right">
0.5%</p>

   </td>
   <td><p style="text-align: right">
0.5%</p>

   </td>
  </tr>
</table>


[todo query link]


#### Bytes

Let us turn our attention to file sizes.



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


[TODO query link]

The median contentful `&lt;img>` weighs in at just over 10kB. But, again, the median page contains 15-17 `&lt;img>`s, so, when looking at _pages_, the ninetieth percentile here – images that push past 100kB – aren’t rare at all.


#### Bits per pixel

Bytes and dimensions are interesting on their own, but to get a sense of how compressed the web’s image data is, we need to put bytes and pixels together, to calculate _bits per pixel_. Doing so allows us to make apples-to-apples comparisons of the information density of images, even if those images have different resolutions.

In general, bitmaps on the web decode to eight bits of information per channel, per pixel. So if we have an RGB image with no transparency, we can expect a decoded, uncompressed image to weigh in at [24 bits per pixel](https://en.wikipedia.org/wiki/Color_depth#True_color_(24-bit)). A good rule of thumb for _lossless_ compression is that it should reduce filesizes by a 2:1 ratio (which would work out to 12 bits per pixel for our 8-bit RGB image); the rule of thumb for 1990s-era lossy compression schemes (JPEG and MP3) was a 10:1 ratio (2.4 bits/pixel). It should be noted that, depending on image content and encoding settings, these ratios vary *widely*, and modern JPEG encoders like [MozJPEG](https://github.com/mozilla/mozjpeg) typically outperform this 10:1 target at their default settings.

So, with all of that context, here’s how the web’s images stack up: \




<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


[TODO query link]

The median `&lt;img>` on mobile hits that 10:1 compression ratio target on the nose: 2.4 bits/pixel.  However, around that median, there is a tremendous spread. Let’s break things down by format and learn a bit more.


##### Bits per pixel, by format



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")


_[TODO query link]_

The median JPEG weighs in at 2.1 bits per pixel. Given the format’s ubiquity, this is the best baseline to measure other formats by.

The median PNG weighs in at more than twice that. PNG is sometimes called a “lossless” format; a median of 4.6 bits per pixel shows how false this is. True lossless compression should typically land at around 12-16 bits per pixel (depending on whether or not we’re dealing with an alpha channel); PNG comes in so far below this because common PNG tooling is usually _lossy_: it modifies pixels – reducing color palettes and introducing dithering patterns – before encoding pixels, to boost compression ratios.

GIFs, weighing in at 7.4 bits per pixel, come off terribly here, and make no mistake, [they](https://web.dev/efficient-animated-content/) [are](https://bitsofco.de/optimising-gifs/) [terrible](https://dougsillars.com/2019/01/15/state-of-the-web-animated-gifs/)! But they’re also at a bit of an unfair disadvantage here because many GIFs on the web are animated. Web platform APIs don’t expose the number of frames in an animated image, so we haven’t accounted for frames. To give you a sense of how much this inflates GIF’s numbers: a GIF measured as 20 bits per pixel, here, which contains ten frames, should be fairly counted as using 2 bits per pixel.

Things get really interesting when we look at two next-gen formats: WebP and AVIF. Both weigh in almost 40% lighter than JPEG, at 1.3-1.5 bits per pixel. In formal studies using [matched qualities](https://kornel.ski/en/faircomparison), WebP outperforms JPEG by [between 25-34%](https://developers.google.com/speed/webp/docs/webp_study), so its real-world performance seems surprisingly *good*. On the other hand, AVIF’s creators have published data suggesting that it is capable of [outperforming modern JPEG encoders JPEG by 50%+, in the lab](https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4). So while AVIF’s performance here is good, I expected it to be better. I can think of a few possible explanations for these discrepancies between lab data and real world performance.

First: tooling. JPEG encoders vary incredibly widely, ranging from hardware encoders in cameras which don’t spend much effort compressing images well, to ancient copies of [libjpeg](https://en.wikipedia.org/wiki/Libjpeg) installed decades ago, to bleeding-edge, best-practice-by-default encoders like MozJPEG. In short, there are a lot of old,  badly-compressed JPEGs out there, but every WebP and AVIF has been compressed with modern tooling.

Also, anecdotally, [cwebp](https://developers.google.com/speed/webp/download) is relatively aggressive about quality/compression, and returns lower-quality, more-compressed results by default than most common JPEG tooling.

And as far as AVIF is concerned: [libavif](https://github.com/AOMediaCodec/libavif) is capable of a wide variety of compression ratios depending on which “speed” setting you choose. At its slowest speeds (producing the highest-efficiency files) libavif can take _minutes_ to render a single image. It’s reasonable to assume that different image-rendering pipelines will make different tradeoffs when choosing speed settings, depending on their constraints. This results in a wide distribution of compression performance.

Another thing to keep in mind when evaluating AVIF’s real-world performance here, is that there just aren’t that many AVIFs out there in the wild, yet. The format is currently being used by relatively few sites, on a limited set of content, so we don’t yet have a full sense of how it will ultimately perform “in the wild,” on the web. This will be interesting to track over the coming years, as adoption increases (and tooling improves).

One thing that is absolutely clear in both lab data and in our results is that both WebP and AVIF can be used to deliver a wide variety of content (including photography, [illustrations](https://jakearchibald.com/2020/avif-has-landed/#flat-illustration), and images with transparency) more efficiently than the web’s legacy formats. But, as we’ll see in the next section, not that many sites have adopted them.


##### Format adoption



<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


The old formats still reign: JPEG dominates, with PNG and GIF rounding out the podium. Together, they account for almost 90% of the images on the web. WebP – which is now more than a decade old but which [only achieved universal browser support last year](https://www.macrumors.com/2020/06/22/webp-safari-14/) – is still in the single digits. And effectively no-one is using AVIF, which accounted for only 0.04% of crawled resources. We found a thousand JPEGs for every AVIF.

For an in-depth analysis of how (and educated guesses as to why!) WebP and AVIF adoption has changed over time, the best resource is Paul Calvano’s excellent recent talk at ImageReady ([full video](https://www.youtube.com/watch?v=tz5bpAQY43k); [slides 13-15](https://docs.google.com/presentation/d/1VS5QjNR6lh2y9jL5xaeainQ2cTAWyy7QiEjDMh4hNQA/edit#slide=id.gefc0d6ffce_0_0)). In it, he shows that WebP adoption increased by ~34% from July 2020 (when Safari added support) to July 2021. AVIF’s numbers have risen even more rapidly, in percentage terms, though perhaps that’s not surprising given that the format is still brand new and used by relatively few sites. A few [large](https://twitter.com/chriscoyier/status/1465474900588646408) [players](https://medium.com/vimeo-engineering-blog/upgrading-images-on-vimeo-620f79da8605) adopting AVIF was all it took.


### Embedding


#### Lazy-loading

If there is one breakout story this year as far as images on the web, it is [native lazy-loading](https://web.dev/browser-level-image-lazy-loading/) adoption. Look at this chart:



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


Data: [https://docs.google.com/spreadsheets/d/1Mw6TjkIClRtlZPHbij5corOZbaSUp-vgTVq3Ig18IwQ/edit#gid=157636784](https://docs.google.com/spreadsheets/d/1Mw6TjkIClRtlZPHbij5corOZbaSUp-vgTVq3Ig18IwQ/edit#gid=157636784)

Query:  https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2021/resource-hints/imgLazy.sql

In July of 2020, native lazy-loading was used on just 1% of pages. By July of 2021, that number had exploded, to 18%. This is an unbelievable rate of  growth considering the vast number of pages and templates which are not updated from year to year.

Personally, I think native lazy-loading’s rapid adoption is the best explanation we have for the trend-breaking reduction in image bytes per page, this year.

What fueled lazy-load adoption? There’s some consensus that it was a combination of ease of use, pent-up developer demand, and WordPress [enabling lazy loading by default across a vast swath of the web](https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/).

Perhaps native lazy-loading has been _too _successful? The Resource Hints chapter notes that [the majority of lazy-loaded images were in the initial viewport](https://almanac.httparchive.org/en/2021/resource-hints#fig-16) (whereas the feature is ideally used on “below the fold” images). Furthermore, the Performance chapter found that [9.3% of Largest Contentful Paint elements have their `loading` attribute set to `lazy](https://almanac.httparchive.org/en/2021/performance#fig-20)`, which significantly delays the page’s most important piece of content from loading, and hurts users’ experiences.


#### Decoding

The `decoding` attribute on `&lt;img>` serves as a useful point of contrast to highlight native lazy loading’s success. [First supported](https://www.chromestatus.com/feature/4897260684967936) in 2018 – about a year before native lazy-loading – the `decoding` attribute allows developers to prevent large image decode operations from blocking the main thread. It provides functionality that not all web developers need or understand, and that shows in the usage data. [`decoding` is used on just 1% of pages, and on only 0.3% of `&lt;img>` elements](https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1934121343).


#### Accessibility

When you embed contentful images on webpages, you should make their content as accessible as possible for non-visual users. I note this only to [defer you to the Accessibility chapter](https://almanac.httparchive.org/en/2021/accessibility#images), whose in-depth analysis of image accessibility on the web found small year-over-year progress in this area, but mostly: a whole lot of room for improvement.


#### Responsive Images

In 2013, a suite of features enabling adaptive image loading on responsive websites landed, to much fanfare. Eight years in, how are responsive image features being used?


##### Srcset

First, let us consider the [`srcset` attribute](https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/srcset), which allows developers to supply multiple possible resources for the same `&lt;img>`:


###### Feature adoption

31%

Percent of pages that use `srcset`

[data: [https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1594311632](https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1594311632)]

[Query: TODO]


<table>
  <tr>
   <td>
   </td>
   <td>Percent of pages using feature
   </td>
  </tr>
  <tr>
   <td>`x` descriptors
   </td>
   <td>6%
   </td>
  </tr>
  <tr>
   <td>`w` descriptors
   </td>
   <td>24%
   </td>
  </tr>
</table>


[Data: https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1030564653]

[Query: ]

Almost a third of crawled pages use `srcset`; pretty good! And `w` descriptors, which allow browsers to select a resource based on both varying layout widths and varying screen densities, are four times more popular than `x` descriptors, which only enable DPR-adaptation.

How are developers populating their `srcset`s with resources?


###### Number of candidates

Let’s first take a look at the number of candidate resources developers are including:



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


[https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1586096291](https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1586096291)]]

A large majority of `srcset`s  are populated with five-or-fewer resources.


###### Resource densities

Are developers giving the browser an appropriately wide range of choices? To figure this out, we can calculate each resource’s [density](https://html.spec.whatwg.org/multipage/images.html#current-pixel-density): a measure of how many image pixels the `&lt;img>` will paint in each CSS `px`, if left to its intrinsic dimensions. If the range of resource densities covers a reasonable range of real-world device DPRs, the `srcset` has a wide-enough range.



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")
[[Data [https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1410495845](https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1410495845)

TODO query]]

The mobile crawler here saw higher densities than the desktop crawler, which is expected. Viewport-relative `sizes` values resolve to smaller values on mobile viewports, resulting in higher densities for the same resources. Taken as a whole, [given that most devicePixelRatios fall somewhere between 1x-3x](https://twitter.com/TheRealNooshu/status/1397862141894529027), this appears to be a healthy range of densities. It would be interesting to perform a deeper analysis that counted how many `srcsets` _didn’t_ fully cover a “reasonable” ~1x-2x range; this is left as an exercise to the reader (or next year’s analysts!).


###### Sizes accuracy

Responsive images can be tricky. Authoring reasonably-accurate `sizes` attributes – and keeping them up to date with evolving page layouts and content – might be the hardest part about getting responsive images right. How many authors  get `sizes` wrong? And how wrong do they get it?



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")


More than a quarter of `sizes` attributes are perfect: exact matches for the layout size of the image. As someone who has authored a number of erroneous `sizes` attributes, myself, I found this both surprising and impressive. That is, until I realized that the accuracy measurement here was taken _after_ Javascript runs, and many `sizes` attributes are ultimately written by client-side Javascript. Here are the most common `sizes` values, _before_ Javascript runs:


<table>
  <tr>
   <td><em>sizes</em>
   </td>
   <td>
   </td>
   <td>desktop
   </td>
   <td>mobile
   </td>
  </tr>
  <tr>
   <td>auto
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
8.2%</p>

   </td>
   <td><p style="text-align: right">
9.6%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 300px) 100vw, 300px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
4.7%</p>

   </td>
   <td><p style="text-align: right">
5.9%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 150px) 100vw, 150px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
1.3%</p>

   </td>
   <td><p style="text-align: right">
1.6%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 600px) 100vw, 600px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
1.0%</p>

   </td>
   <td><p style="text-align: right">
1.2%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 400px) 100vw, 400px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
1.0%</p>

   </td>
   <td><p style="text-align: right">
1.1%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 800px) 100vw, 800px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.8%</p>

   </td>
   <td><p style="text-align: right">
0.9%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 500px) 100vw, 500px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.8%</p>

   </td>
   <td><p style="text-align: right">
0.9%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 1024px) 100vw, 1024px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
   <td><p style="text-align: right">
0.9%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 320px) 100vw, 320px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.5%</p>

   </td>
   <td><p style="text-align: right">
0.8%</p>

   </td>
  </tr>
  <tr>
   <td>(max-width: 100px) 100vw, 100px
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
   <td><p style="text-align: right">
0.8%</p>

   </td>
  </tr>
  <tr>
   <td>100vw
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
  </tr>
</table>


One in ten `sizes` attributes on mobile has an initial value of “auto”. This non-standard value is then presumably replaced by a Javascript library (probably [lazysizes.js](https://github.com/aFarkas/lazysizes)), using the measured layout size of the image.

Some error in `sizes` is acceptable; the attribute provides a pre-layout hint to the browser in order to help it select an appropriate resource to load,_ before_ layout is complete. But large errors can lead to bad resource choices. This appears likely for the least-accurate quarter of `sizes` attributes, which report widths twice as large as the actual `&lt;img>` layout width on desktop and 1.5x as large as the actual `&lt;img>` layout width on mobile.

So: one in ten `sizes` attributes is being authored on the client by a Javascript library, and at least one in four is inaccurate enough that the error is likely to impact resource selection. Both of these facts represent significant opportunities for either [existing tooling](https://github.com/ausi/respimagelint) or [new web platform features](https://github.com/whatwg/html/issues/4654) to help more authors get `sizes` right.


##### &lt;picture>

The `&lt;picture>` element serves a couple of use cases:



1. Art direction, with the [`media` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture#the_media_attribute)
2. Type-switching, via the [`type` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture#the_type_attribute)

6%

Percent of pages which use &lt;picture>

https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=620965569

`&lt;picture>` is used much less frequently than `srcset`, reflecting its somewhat-niche pair of use-cases. Here’s how usage breaks down between those two use cases:



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


[https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=2031063502](https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=2031063502)

Art direction appears a bit more popular than type-switching. Notably, these two features are not mutually exclusive, and, put together, the usage percentages here do not add up to 100%. This suggests that at least 15% of `&lt;picture>` elements do not leverage either of these attributes, making those `&lt;picture>`s  functionally equivalent to a `&lt;span>`.


### Layout


#### Intrinsic vs extrinsic sizing

As [replaced elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Replaced_element), images have a natural, [“intrinsic” size](https://developer.mozilla.org/en-US/docs/Glossary/Intrinsic_Size). This is the size that they will render at by default, if there are no CSS rules placing “extrinsic” layout constraints upon them.

How many images are extrinsically vs extrinsically sized?



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


[https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=576119731](https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=576119731)

The question is a little complicated because some images (those with a `max-width`, `max-height`, `min-width`, or `min-height` constraint), are sometimes extrinsically sized, but sometimes left to their intrinsic size. We’ve labelled those images as “both.”

In any case, perhaps unsurprisingly, most images have extrinsic width constraints and height-constrained sizing is much less common.


#### Reducing layout shifts with `height` and `width`

This brings us to the last web platform feature that we’d like to investigate:  [using the `height` and `width` attributes to reserve layout space for flexible images](https://www.youtube.com/watch?v=4-d_SoCHeWE).

By default, images left to their intrinsic dimensions take up no space until they load and their intrinsic dimensions become known. At that point – poof – they pop into the page, causing a [layout shift](https://developers.google.com/publisher-tag/guides/minimize-layout-shift). This was exactly the problem that the `height` and `width` attributes were invented to solve – [in 1996](https://www.w3.org/TR/2018/SPSD-html32-20180315/#img).

Unfortunately, `height` and `width` never played well with images that are assigned a variable extrinsic size in one dimension (e.g., `width: 100%;`), and left to fill out their intrinsic aspect ratio, in the other dimension. This is the dominant pattern in responsive design. So `width` and `height` fell out of favor within responsive contexts until 2019, when [a tweak to how `height` and `width` are used by browsers](https://developer.mozilla.org/en-US/docs/Web/Media/images/aspect_ratio_mapping#a_new_way_of_sizing_images_before_loading_completes) fixed this problem. Now, consistently setting `height` and `width` is one of the best things authors can do to reduce [Cumulative Layout Shift](https://web.dev/cls/). How often are these attributes accomplishing this task?

7.5%

Of `&lt;img>`s on mobile have `height` and `width` attributes, and are extrinsically sized in only one dimension

[data: https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1150803469]

It’s hard to tell how many of these `&lt;img>`s were authored with the new browser behavior in mind, but they’re all benefiting from it. And that was the point; by re-using existing attributes, lots of existing content benefitted from the change, automatically.


### Delivery

Finally, let’s take a look at how images are delivered over the network.


##### Cross-origin image hosts

How many images are being hosted by the same origin that they’re being embedded on? The slimmest of minorities:



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


Cross-origin images are subject to significant [security restrictions](https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_enabled_image), and can sometimes incur [performance costs](https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/). On the other hand, moving your static assets to a dedicated CDN is one of the most impactful things you can do to help [Time to First Byte](https://developer.mozilla.org/en-US/docs/Glossary/time_to_first_byte), and image CDNs provide powerful transformation and [optimization](https://web.dev/image-cdns/) features which can automate all sorts of best-practices. It would be fascinating to see how many of the 51% of cross-origin images are hosted on image CDNs and to compare their performance against the rest of the web’s; unfortunately that was outside the scope of our analysis.

And with that, it is time to turn our attention to...


## Video

As the world has dramatically changed over the last year, we have seen a huge growth in video usage on the web. In the 2020 media report, it was estimated that 1-2% of websites had a `&lt;video>` tag.  In 2021, that number has jumped drastically, with over 5% of desktop sites and 4% of mobile sites incorporating a `&lt;video>` tag.



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")


This huge growth in video usage on the web indicates that as devices/networks improve, there is a desire to add immersive experiences such as video to sites.

When it comes to interaction with video, it is interesting to see how long the videos are when posted on a webpage.  We were able to query this value for 440k desktop videos, and 382k mobile videos, and broke down the duration into buckets of varying duration (in seconds):



<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")


Most videos on the web are short: ~ 60% of videos are under 30 seconds long on both mobile and desktop.  However, 12-13% are between one and two minutes, and 10% of videos are over two minutes long.


### Video: formats

What types of files are being delivered as video?  We queried all files with “video” in the MIME type, and then sorted by the file extension.

The chart below shows all video extensions with over 1% market share:



<p id="gdcalert18" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image18.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert19">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image18.png "image_tooltip")


By far, the #1 video format on the web is the mp4, since the mp4 h264 format has 98.1% support in all modern browsers ([https://caniuse.com/?search=mp4](https://caniuse.com/?search=mp4)), and the 1.9% of browsers that do not support mp4 have no video support, so the number is really 100% coverage.  Interestingly, the mp4 usage has dropped by ~15% YOY on both desktop and mobile.  WebM support also dropped significantly YOY (50% drop on both mobile and desktop). (2020 data from Web Almanac 2020 (https://almanac.httparchive.org/en/2020/media#videos)

Where we see the growth are files with no extension (these are often from YouTube or other streaming platforms),  and in web streaming. Ts files are segments used in HTTP Live Streaming (HLS)  where we see a 4% jump in usage.  .m4s are MPEG Dynamic Adaptive Streaming over HTTP (MPEG-DASH) video segments.  M4s files grew by 50% from 2.3% to 3.3% YOY.


### Video CSS: Display

To begin, let’s look at how the video will appear on the page by looking at the CSS “display” property for the video.  What we find is that approximately half of all videos use a display value of “block” - placing the video on its own line and allowing for height and width values to be set for the video.  The `inline-block” value also  allows height and width to be specified - for a total of ~⅔ of all videos.

The  ```display: none``` declaration hides the video from the viewer. One in five videos on the web is hidden behind this display value.  From a data usage perspective, this is less than optimal, as the video is still downloaded by the browser.



<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image19.png "image_tooltip")



### Video Attributes

The video HTML5 tag has a number of attributes that can be used to define how the video player will appear to end users.

Let’s look at the most common attributes and how they are used inside the `&lt;video>` tag:



<p id="gdcalert20" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image20.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert21">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image20.png "image_tooltip")



#### Preload

The most commonly used attribute is preload.  The preload attribute gives the browser a hint on the best way to handle the video download.  There are four possible options: “auto,” “metadata,” “none,” and an empty response = “auto”.



<p id="gdcalert21" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image21.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert22">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image21.png "image_tooltip")


Interestingly, we see a large push away from “preload=auto” on both mobile and desktop, with most of the movement to “preload=none.”  While it is possible that this changed for many videos, it could just be that the new videos added to the web over the last year utilize the “none” parameter more than in the past.  From a page weight perspective - this is a large win for the web.


#### Autoplay

The next most commonly used attribute is “autoplay.”  This tells the browser that the video should play as soon as possible (and because of this, autoplay will actually override the preload attribute).

The autoplay attribute is a boolean attribute, meaning that its presence by fault means true.  So for the 190 sites that use “autoplay=”false,” we’re sorry to tell you that is not going to work.


#### Width

The width attribute is also one of the top video attributes.  It tells the browser how wide the video player should be (note that height is very rarely used, since the aspect ratio of the video will decide the space with just one value.)

The width can be presented as a percentage, or a width in pixels.



* When a percentage width is defined, the value “100%” is used in 99% of cases.
* When a width in pixels is defined, we see very similar numbers of videos at lower widths, but a large dropoff in the 1800 and 1920 widths:



<p id="gdcalert22" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image22.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert23">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image22.png "image_tooltip")


It appears that about half of sites with larger videos that also define the width of the video _remove_ the larger videos for mobile devices.  Since very few devices need a 1080p (1920 wide) video embedded in a website, this makes sense.


#### Src and source

The src attribute is used in the `&lt;video>` tag to point to the URL of the video to be played.  Another way to reference the video is to use the `&lt;source>` element.

One of the key ideas behind the `&lt;source>` element is that the developer can supply multiple video formats to the browser, and the browser will select the first format that the browser understands.

When we look at `&lt;source>` usage, we see that about 40% of videos have no `&lt;source>` element - implying that they use the `src` attribute.  This is similar to the ratio found in 2020 (35%).



<p id="gdcalert23" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image23.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert24">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image23.png "image_tooltip")


We also see that the source element is most often used with just one element (50% of all video tags).  Only 10% of videos have 2 or more video sources named. By a 3:1 ratio, 2 is more common than 3 sources, and then there is a small selection of more than 3 (there is one video with 48 sources!).

Let’s look at the videos that use 2 sources.  Here are the top 10 occurrences:


<table>
  <tr>
   <td>["video/mp4","video/webm"]
   </td>
  </tr>
  <tr>
   <td>["video/webm","video/mp4"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4","video/ogg"]
   </td>
  </tr>
  <tr>
   <td>[null,null]
   </td>
  </tr>
  <tr>
   <td>["video/mp4"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4","video/mp4"]
   </td>
  </tr>
  <tr>
   <td>["application/x-mpegURL","video/mp4"]
   </td>
  </tr>
  <tr>
   <td>[]
   </td>
  </tr>
  <tr>
   <td>["video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"","video/webm; codecs=\"vp8, vorbis\""]
   </td>
  </tr>
  <tr>
   <td>["video/mp4;","video/webm;"]
   </td>
  </tr>
</table>


In six of the top 10 examples, the MP4 is listed as the first source.  MP4 support on the web is at 98.4% (https://caniuse.com/?search=mp4), and the browsers that do not support MP4 generally do not support the `&lt;video>` tag at all.  This implies that these sites do not need two sources, and could save some storage on their web servers by removing their WebM or Ogg video sources. (Or, they could reverse the order of the videos, and browsers that support WebM will download the WebM).

The same trend holds for `&lt;video>` elements with three sources - eight of the top 10 examples begin with MP4.


<table>
  <tr>
   <td>["video/mp4","video/webm","video/ogg"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4; codecs=avc1","video/mp4; codecs=avc1","video/mp4; codecs=avc1"]
   </td>
  </tr>
  <tr>
   <td>["video/webm","video/mp4","video/ogg"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4; codecs=avc1"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4","video/ogg","video/webm"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4;","video/ogg; codecs=\"theora, vorbis\"","video/webm; codecs=\"vp8, vorbis\""]
   </td>
  </tr>
  <tr>
   <td>["video/mp4; codecs=hevc","video/webm","video/mp4"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4"]
   </td>
  </tr>
  <tr>
   <td>["video/ogg; codecs=\"theora, vorbis\"","video/webm","video/mp4"]
   </td>
  </tr>
  <tr>
   <td>["video/mp4","video/webm","video/ogv"]
   </td>
  </tr>
</table>


Of course, these implementations will just play the MP4 file, and the WebM and Ogg files will be ignored.

The incorporation of video on the web has grown immensely over the last year - jumping from 1-2% of webpages to 4-5%.  We expect this growth to continue.  Interestingly, the “king of video”, MP4, while still the king, is having its market share eroded by video streaming formats (that feature responsive and adaptive video sizing).

We do see movement to more performant usage of the `&lt;video>` tag - with less use of “preload=auto” - and more use of “preload=none” as well as we see behaviors in the width attribute that indicate that videos are being modified (or removed) for smaller screens.
