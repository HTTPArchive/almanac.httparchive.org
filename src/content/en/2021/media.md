---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Media chapter of the 2021 Web Almanac covering how images and videos are currently being encoded, embedded, styled, and delivered on the web.
hero_alt: Hero image of Web Almanac characters projecting an image onto a screen while other Web Almanac characters walk to cinema seats with popcorn to watch the projection.
authors: [eeeps, dougsillars]
reviewers: [Navaneeth-akam, tpiros, akshay-ranganath, addyosmani]
analysts: [eeeps, dougsillars, akshay-ranganath]
editors: [tunetheweb]
translators: []
eeeps_bio: Eric Portis is a Web Platform Advocate at <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>.
dougsillars_bio: Doug Sillars is a leader in developer relations, and a digital nomad working on the intersection of performance and media. He tweets [@dougsillars](https://x.com/dougsillars), and blogs regularly at <a hreflang="en" href="https://dougsillars.com">dougsillars.com</a>.
results: https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/
featured_quote: This year, native lazy-loading stemmed the tide of ever-increasing image transfer sizes.
featured_stat_1: 99.93%
featured_stat_label_1: Pages that load an image resource of some kind.
featured_stat_2: 87.1%
featured_stat_label_2: Images on the web delivered as JPEGs, PNGs, or GIFs instead of next-gen formats!
featured_stat_3: 5.6%
featured_stat_label_3: Share of desktop pages that included a `video` element. A three-fold increase from last year.
---

## Introduction

Almost three decades ago <a hreflang="en" href="https://thehistoryoftheweb.com/the-origin-of-the-img-tag/">the `<img>` tag dropped</a> and hyper<em>text</em> became hyper<em>media</em>. The web has become increasingly visual ever since. What is the state of media on the web in 2021? Let's look at images and videos, in turn.

## Images

Images are ubiquitous on the web. Almost every page contains image content.

{{ figure_markup(
  content="95.9%",
  caption="Percentage of pages that contained at least one contentful `<img>`.",
  classes="big-number",
  sheets_gid="1756671383",
  sql_file="at_least_one_img.sql"
)
}}

And effectively all pages serve up some sort of imagery (even if it's just a background or favicon).

{{ figure_markup(
  content="99.9%",
  caption="Percentage of pages that generated at least one request for an image resource.",
  classes="big-number",
  sheets_gid="1062090109",
  sql_file="at_least_one_image_request.sql"
)
}}

The impact that all of these images have is hard to overstate. As the [Page Weight](./page-weight) chapter highlights, images are still responsible for more bytes-per-page than any other resource type. However, year-over-year, per-page image transfer sizes have decreased.

{{ figure_markup(
  image="mobile-image-transfer-size-by-year.png",
  caption="Mobile image transfer size by year.",
  description="Bar chart showing the distribution of total image transfer sizes, per page, and how it has changed between 2020 and 2021. At the 25th percentile, transfer sizes have reduced from 277 kB to 257 kB. At the 50th, they've shrunk from 916 kB to 877 kB. And at the 75th percentile, they've gone down from 2,352 kB to 2,324 kB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=478222195&format=interactive",
  sheets_gid="381418851",
  sql_file="../page-weight/bytes_per_type_2021.sql"
)
}}

This is surprising. For the last decade, the <a hreflang="en" href="https://httparchive.org/reports/state-of-images#bytesImg">Image Bytes</a> chart on the HTTP Archive's monthly <a hreflang="en" href="https://httparchive.org/reports/state-of-images">State of Images report</a> has seemingly only ever gone one direction: up. What reversed this trend in 2021? I think it may have something to do with native lazy-loading's rapid adoption, which we will discuss more later in the chapter.

In any case, by quantity, images continue to make up an awful lot of the stuff of the web. But tallying the sheer number of elements, requests, and bytes doesn't tell us how crucial images are to users' experiences. To get a sense of that, we can look at the <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> metric, which tries to identify the most important piece of above-the-fold content on any given page. As you can see in the [Performance](./performance#fig-19) chapter, the LCP element has an image on around three quarters of pages.

{{ figure_markup(
  content="70.6%",
  caption="Mobile pages whose LCP element has an image. On the desktop it's 79.4%!.",
  classes="big-number",
  sheets_gid="https://docs.google.com/spreadsheets/d/13xhPx6o2Nowz_3b3_5ojiF_mY3Lhs25auBKM6eqGZmo/#gid=1423728540",
  sql_file="../performance/lcp_element_data.sql"
)
}}

Images are crucial to user's experiences of the web! Let's dive in, taking a closer look at how they're encoded, embedded, laid out, and delivered.

### Encoding

Image data on the web is encoded in files. What can we say out about these files, and the image data that they contain?

Let's start by looking at their pixel dimensions. We'll start small.

#### Single pixel images

Many `<img>` elements don't actually represent contentful <a hreflang="en" href="https://www.merriam-webster.com/dictionary/image">images</a> and instead, they contain only a single pixel:

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>1x1 images</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Mobile</td>
        <td class="numeric">7.5%</td>
      </tr>
      <tr>
        <td>Desktop</td>
        <td class="numeric">7.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Single pixel image use.", sheets_gid="1851007461", sql_file="image_1x1.sql") }}</figcaption>
</figure>

These single pixel `<img>` elements are, put bluntly, hacks: they are being abused either [to do layout](https://en.wikipedia.org/wiki/Spacer_GIF) (which would be better done with CSS) or [to track users](https://en.wikipedia.org/wiki/Web_beacon) (which would be better-accomplished using the [Beacon API](https://developer.mozilla.org/docs/Web/API/Beacon_API)).

We can establish a baseline breakdown of what jobs all of these single pixel `<img>`s are doing by looking at how many use [data URIs](https://developer.mozilla.org/docs/Web/HTTP/Basics_of_HTTP/Data_URIs).

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>Data URI single pixel `<img>`s</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Mobile</td>
        <td class="numeric">44.7%</td>
      </tr>
      <tr>
        <td>Desktop</td>
        <td class="numeric">47.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Data URI single pixel images.", sheets_gid="1851007461", sql_file="image_1x1.sql") }}</figcaption>
</figure>

The single pixel `<img>`s containing data URIs are almost certainly being used for layout. The remaining ~54% which generate a request might be there for layout or they might be tracking pixels—we can't tell.

Note that throughout the rest of this analysis, we have excluded single pixel `<img>`s from the results. For this media chapter, we're interested in `<img>` elements that are presenting visual information to the user, not tracking pixels or layout hacks.

#### Multiple pixel images

When `<img>`s contain more than one pixel, how many pixels do they contain?

{{ figure_markup(
  image="image-pixel-counts.png",
  caption="Distribution of image pixel counts.",
  description="Bar chart showing the distribution of pixels per image on desktop and mobile, but there is little difference between them. At the 10th percentile, desktop images contain 676 pixels and mobile 999 pixels, at the 25th percentile it's 7,260 and 9,216 respectively, at the 50th it's 40,000 and 43,200, at the 75th it's 160,000 and 170,496, and at the 90th percentile it's 516,242 and 514,000.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=493015352&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

The median `<img>` loads just over 40,000 pixels on mobile. I found this number surprisingly small. Just under half of crawled `<img>`s (excluding the ones that loaded single pixel images, or nothing at all) contain about the same number of pixels as a 200x200 image.

However, when you consider the number of `<img>` elements per page, this statistic is less surprising. Most pages contain more than 15 images, so they are often made up of many smaller images and icons. Thus, while images with more than half-a-megapixel might only account for one in ten `<img>` elements, they are not at all uncommon, as we navigate across pages. Many pages will include at least one larger image.

{{ figure_markup(
  image="number-of-imgs-per-page.png",
  caption="Number of `<img>`s per page.",
  description="Bar chart showing the distribution of img elements per page. Both the desktop and mobile bars are shown. From the 50th percentile on, the desktop bars are consistently 10-20% larger. At the 10th percentile it's 2 on desktop and 2 on mobile, at the 25th percentile it's 6 and 6 respectively, at the 50th percentile it's 17 and 15, at the 75th percentile it's 36 and 32, and finally, at the 90th percentile it's 70 and 61.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1641393356&format=interactive",
  sheets_gid="1553608446",
  sql_file="imgs_per_page.sql"
  )
}}

I was also surprised that there was almost no difference between desktop and mobile at the top end of the pixel count distribution. Initially, this seemed to indicate a lack of effective adoption of responsive image features, but when you consider that the mobile crawler has a 360 × 512px @3x viewport (so 1,080 by 1,536 physical pixels), while the desktop viewport is 1,376 × 768px @1x, it isn't actually surprising: the crawlers' viewports had similar widths, in physical pixels (1,080 vs 1,376). A bigger difference in physical pixel resolution between the crawlers would be more revealing.

#### Aspect ratios

Images on the web are mostly landscape-oriented, and portrait-oriented images are relatively rare.

{{ figure_markup(
  image="image-orientations.png",
  caption="Image orientations.",
  description="A pair of stacked bars showing what percentage of images are portrait-oriented, landscape-oriented, and square, on both desktop and mobile. The desktop breakdown is: 12.7% portrait, 32.9% square, and 54.4% landscape. The mobile breakdown is very similar: 12.6% portrait, 32.7% square, and 54.5% landscape.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1361616235&format=interactive",
  sheets_gid="478089289",
  sql_file="portrait_landscape_square.sql"
  )
}}

This feels like a missed opportunity on mobile. The success of the <a hreflang="en" href="https://uxdesign.cc/the-powerful-interaction-design-of-instagram-stories-47cdeb30e5b6">"stories" UI pattern</a> shows that there's value in imagery tailored to fill portrait-oriented mobile screens.

Images' aspect ratios were clustered around "standard" values, such as 4:3, 16:9, and especially 1:1 (square). The top 10 aspect ratios accounted for nearly half of all `<img>`s:

<figure>
  <table>
    <thead>
      <tr>
        <th>Aspect ratio</th>
        <th>Desktop images</th>
        <th>Mobile images</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1:1</td>
        <td class="numeric">32.9%</td>
        <td class="numeric">32.7%</td>
      </tr>
      <tr>
        <td>4:3</td>
        <td class="numeric">3.7%</td>
        <td class="numeric">4.1%</td>
      </tr>
      <tr>
        <td>3:2</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>2:1</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>16:9</td>
        <td class="numeric">1.5%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>3:4</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>2:3</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>5:3</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>6:5</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>8:5</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="A ranked list of the top ten image aspect ratios.", sheets_gid="914161583", sql_file="top_aspect_ratios.sql") }}</figcaption>
</figure>

#### Bytes

Let us turn our attention to file sizes.

{{ figure_markup(
  image="distribution-of-image-byte-sizes.png",
  caption="Distribution of image byte sizes.",
  description="A bar chart showing the distribution of image byte sizes (in kilobytes) on both desktop and mobile. At the tenth percentile, 10th percentile it's 0.3 for desktop and mobile, at the 25th percentile it's 1.8 and 1.9 respectively, at the 50th percentile it's 9.7 and 10.3, at the 75th percentile it's 39.2 and 41.6, and finally, at the 90th percentile it's 132.8 and 130.7.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=717078449&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

The median contentful `<img>` weighs in at just over 10kB. But, again, the median page contains more than 15 `<img>`s so, when looking at the ninetieth percentile of all images across pages, images that push past 100kB aren't rare at all.

#### Bits per pixel

Bytes and dimensions are interesting on their own, but to get a sense of how compressed the web's image data is, we need to put bytes and pixels together, to calculate _bits per pixel_. Doing so allows us to make apples-to-apples comparisons of the information density of images, even if those images have different resolutions.

In general, bitmaps on the web decode to eight bits of information per channel, per pixel. So, if we have an RGB image with no transparency, we can expect a decoded, uncompressed image to weigh in at [24 bits per pixel](https://en.wikipedia.org/wiki/Color_depth#True_color_(24-bit)). A good rule of thumb for _lossless_ compression is that it should reduce file sizes by a 2:1 ratio (which would work out to 12 bits per pixel for our 8-bit RGB image). The rule of thumb for 1990s-era lossy compression schemes (JPEG and MP3) was a 10:1 ratio (2.4 bits/pixel). It should be noted that, depending on image content and encoding settings, these ratios vary *widely*, and modern JPEG encoders like <a hreflang="en" href="https://github.com/mozilla/mozjpeg">MozJPEG</a> typically outperform this 10:1 target at their default settings.

So, with all of that context, here's how the web's images stack up:

{{ figure_markup(
  image="distribution-of-image-bits-per-pixel.png",
  caption="Distribution of image bits per pixel.",
  description="A bar chart showing the distribution of image bits per pixel, for both desktop and mobile. The desktop bars are consistently 5-10% taller than the mobile ones. At the tenth percentile, the web's images weigh in at 0.2 bits per pixel for mobile and 0.3 for desktop. At the 25th, 1.1 for both, at the 50th, 2.4 for mobile and 2.5 for desktop, at the 75th, 6.0 for mobile and 6.3 for desktop, and finally, at the 90th percentile, mobile images weigh in at a whopping 13.5 bits per pixel, while desktop are even more at 14.3.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=839945889&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

The median `<img>` on mobile hits that 10:1 compression ratio target on the nose: 2.4 bits/pixel. However, around that median, there is a tremendous spread. Let's break things down by format in order to learn a bit more.

#### Bits per pixel, by format

{{ figure_markup(
  image="median-bits-per-pixel-by-format.png",
  caption="Median bits per pixel by format.",
  description="A bar chart showing the median bits per pixel, by format, for a number of popular image formats. `gif` is 7.2 for desktop and 7.4 for mobile, `png` is 4.8 and 4.6 respectively, `jpg` is 2.1 and 2.1, `avif` is 1.2 and 1.5, `webp` is 1.3 and 1.4.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1390065360&format=interactive",
  sheets_gid="30152726",
  sql_file="bytes_and_dimensions_by_format.sql"
  )
}}

The median JPEG weighs in at 2.1 bits per pixel. Given the format's ubiquity, this is the best baseline to measure other formats by.

The median PNG weighs in at more than twice that. PNG is sometimes called a _lossless_ format, but a median of 4.6 bits per pixel shows how false this is. True lossless compression should typically land at around 12-16 bits per pixel (depending on whether or not we're dealing with an alpha channel). PNG comes in so far below this because common PNG tooling is usually _lossy_: it modifies pixels—reducing color palettes and introducing dithering patterns—before encoding pixels, to boost compression ratios.

GIFs, weighing in at 7.4 bits per pixel, come off terribly here, and make no mistake, <a hreflang="en" href="https://web.dev/efficient-animated-content/">they</a> <a hreflang="en" href="https://bitsofco.de/optimising-gifs/">are</a> <a hreflang="en" href="https://dougsillars.com/2019/01/15/state-of-the-web-animated-gifs/">terrible</a>! But they're also at a bit of an unfair disadvantage here because many GIFs on the web are animated. Web platform APIs don't expose the number of frames in an animated image, so we haven't accounted for frames. To give you a sense of how much this inflates GIF's numbers: a GIF measured as 20 bits per pixel, here, which contains ten frames, should be fairly counted as using two bits per pixel.

Things get really interesting when we look at two next-gen formats: WebP and AVIF. Both weigh in almost 40% lighter than JPEG, at 1.3-1.5 bits per pixel. In formal studies using <a hreflang="en" href="https://kornel.ski/en/faircomparison">matched qualities</a>, WebP outperforms JPEG by <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">between 25-34%</a>, so its real-world performance seems surprisingly *good*. On the other hand, AVIF's creators have published data suggesting that it is capable of <a hreflang="en" href="https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4">outperforming modern JPEG encoders JPEG by 50%+, in the lab</a>. So, while AVIF's performance here is good, I expected it to be better. I can think of a few possible explanations for these discrepancies between lab data and real-world performance.

First: tooling. JPEG encoders vary incredibly widely, ranging from hardware encoders in cameras which don't spend much effort compressing images well, to ancient copies of [`libjpeg`](https://wikipedia.org/wiki/Libjpeg) installed decades ago, to bleeding-edge, best-practice-by-default encoders like MozJPEG. In short, there are a lot of old, badly compressed JPEGs out there, but every WebP and AVIF has been compressed with modern tooling.

Also, anecdotally, the reference WebP encoder (<a hreflang="en" href="https://developers.google.com/speed/webp/download">`cwebp`</a>) is relatively aggressive about quality/compression, and returns lower-quality, more-compressed results by default than most common JPEG tooling.

As far as AVIF is concerned: <a hreflang="en" href="https://github.com/AOMediaCodec/libavif">`libavif`</a> is capable of a wide variety of compression ratios depending on which "speed" setting you choose. At its slowest speeds (producing the highest-efficiency files) `libavif` can take minutes to encode a single image. It's reasonable to assume that different image-rendering pipelines will make different tradeoffs when choosing speed settings, depending on their constraints. This results in a wide distribution of compression performance.

Another thing to keep in mind when evaluating AVIF's real-world performance here, is that there just aren't that many AVIFs on the web, yet. The format is currently being used by relatively few sites, on a limited set of content, so we don't yet have a full sense of how it will ultimately perform "in the wild." This will be interesting to track over the coming years, as adoption increases (and tooling improves).

One thing that is absolutely clear is that both WebP and AVIF can be used to deliver a wide variety of content (including photography, <a hreflang="en" href="https://jakearchibald.com/2020/avif-has-landed/#flat-illustration">illustrations</a>, and images with transparency) more efficiently than the web's legacy formats. But, as we'll see in the next section, not that many sites have adopted them.

#### Format adoption

{{ figure_markup(
  image="image-format-adoption-mobile.png",
  caption="Image format adoption (mobile).",
  description="A pie chart breaking down each format's share of the web's images. JPEG comes in first, at 41.8%. Next, we have PNG, at 28.8%, GIF, at 16.5%, WebP at 6.9%, and SVG, at 4.0%. A couple of tiny slivers of the pie are left unlabeled.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=832165430&format=interactive",
  sheets_gid="1886692503",
  sql_file="media_formats.sql"
  )
}}

The old formats still reign: JPEG dominates, with PNG and GIF rounding out the podium. Together, they account for almost 90% of the images on the web. WebP—which is now more than a decade old but which <a hreflang="en" href="https://www.macrumors.com/2020/06/22/webp-safari-14/">only achieved universal browser support last year</a>—is still in the single digits. And effectively no-one is using AVIF, which accounted for only 0.04% of crawled resources. We found a thousand JPEGs for every AVIF.

For an in-depth analysis of how (and educated guesses as to why) WebP and AVIF adoption has changed over time, the best resource is [Paul Calvano](https://x.com/paulcalvano)'s excellent recent talk at ImageReady (<a hreflang="en" href="https://www.youtube.com/watch?v=tz5bpAQY43k">full video</a> and <a hreflang="en" href="https://docs.google.com/presentation/d/1VS5QjNR6lh2y9jL5xaeainQ2cTAWyy7QiEjDMh4hNQA/edit#slide=id.gefc0d6ffce_0_0">slides 13-15</a>). In it, he shows that WebP adoption increased by ~34% from July 2020 (when Safari added support) to July 2021. AVIF's numbers have risen even more rapidly, in percentage terms, though perhaps that's not surprising given that the format is still brand new and used by relatively few sites. A few [large](https://x.com/chriscoyier/status/1465474900588646408) <a hreflang="en" href="https://medium.com/vimeo-engineering-blog/upgrading-images-on-vimeo-620f79da8605">players</a> adopting AVIF was all it took.

### Embedding

In order to display an image on a web page, we must embed it, using the `<img>` element. This venerable element has gained a handful of new features over the past few years but how are those features being put into practice?

#### Lazy-loading

If there is one breakout story this year as far as images on the web, it is <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">native lazy-loading</a> adoption. Look at this chart:

{{ figure_markup(
  image="adoption-of-native-loading-lazy-on-img.png",
  caption='Adoption of `loading="lazy"` on `<img>`.',
  description="A line chart showing the percent of pages using native lazy-loading, over time. From January 2019 to May 2020 there is 0% usage. From there we get a nice, two-stage curve, with accelerating usage through the summer, up to about August when eight percent of pages used lazy-load, and then decelerating (but still ever-increasing) adoption for the next year or so, through to July 2021, where the line terminates at about 18%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1314627953&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1Mw6TjkIClRtlZPHbij5corOZbaSUp-vgTVq3Ig18IwQ/#gid=157636784",
  sql_file="../resource-hints/imgLazy.sql"
  )
}}

In July of 2020, native lazy-loading was used on just 1% of pages. By July of 2021, that number had exploded, to 18%. This is an unbelievable rate of growth considering the vast number of pages and templates which are not updated from year to year.

Personally, I think native lazy-loading's rapid adoption is the best explanation we have for the trend-breaking reduction in image bytes per page, this year.

What fueled lazy-load adoption? There's some consensus that it was a combination of ease of use, pent-up developer demand, and WordPress <a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">enabling lazy-loading by default across a vast swath of the web</a>.

Perhaps native lazy-loading has been too successful? The Resource Hints chapter notes that [the majority of lazy-loaded images were in the initial viewport](./resource-hints#fig-16) (whereas the feature is ideally used on "below the fold" images). Furthermore, the Performance chapter found that [9.3% of Largest Contentful Paint elements have their `loading` attribute set to `lazy`](./performance#fig-20), which significantly delays the page's most important piece of content from loading, and hurts users' experiences.

#### Decoding

The `decoding` attribute on `<img>` serves as a useful point of contrast to highlight native lazy-loading's success. <a hreflang="en" href="https://www.chromestatus.com/feature/4897260684967936">First supported</a> in 2018—about a year before native lazy-loading—the `decoding` attribute allows developers to prevent large image decode operations from blocking the main thread. It provides functionality that not all web developers need or understand, and that shows in the usage data. <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1934121343">`decoding` is used on just 1% of pages, and on only 0.3% of `<img>` elements</a>.

#### Accessibility

When you embed contentful images on web pages, you should make their content as accessible as possible for non-visual users. I note this only to refer you to the [Accessibility](./accessibility#images) chapter, whose in-depth analysis of image accessibility on the web found small year-over-year progress, but mostly: a whole lot of room for improvement.

#### Responsive images

In 2013, a suite of features enabling adaptive image loading on responsive websites landed, too much fanfare. Eight years in, how are responsive image features being used?

First, let us consider the [`srcset` attribute](https://developer.mozilla.org/docs/Web/API/HTMLImageElement/srcset), which allows developers to supply multiple possible resources for the same `<img>`.

##### `x` and `w` descriptor adoption


{{ figure_markup(
  caption="Percent of mobile pages that use `srcset`.",
  content="30.9%",
  classes="big-number",
  sheets_gid="1594311632",
  sql_file="image_srcset_sizes.sql"
)
}}

Almost a third of crawled pages use `srcset`—pretty good!

And [`w` descriptors](https://cloudfour.com/thinks/responsive-images-101-part-4-srcset-width-descriptors/), which allow browsers to select a resource [based on both varying layout widths and varying screen densities](https://jakearchibald.com/2015/anatomy-of-responsive-images/#varying-size-and-density), are four times more popular than [`x` descriptors](https://cloudfour.com/thinks/responsive-images-101-part-3-srcset-display-density/), [which only enable DPR-adaptation](https://jakearchibald.com/2015/anatomy-of-responsive-images/#fixed-size-varying-density).

{{ figure_markup(
  image="srcset-descriptor-adoption.png",
  caption="`srcset` descriptor adoption.",
  description="A bar chart showing the percentage of pages using `x` descriptors and `w` descriptors, within `srcset` attributes, on both mobile and desktop. `x` descriptors are used on 6.1% of pages on desktop and 6.5% of pages on mobile. `w` descriptors are used four times more: 24.4% of the time on desktop, and 24.3% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=89579817&format=interactive",
  sheets_gid="1030564653",
  sql_file="image_srcset_descriptor.sql"
  )
}}

How are developers populating their `srcset`s with resources?

##### Number of `srcset` candidates

Let's first take a look at the number of candidate resources developers are including:

{{ figure_markup(
  image="number-of-srcset-candidates.png",
  caption="Number of srcset candidates.",
  description="A stacked bar chart showing the percentage of `srcset` attributes which contain different numbers of candidates. Almost all (80-90%) appear to contain 1-5 candidates, on both desktop and mobile. Next we have the 5-10 candidate bucket, which takes us up past 95%. Almost all of the remaining `srcset`s have 10-15 candidates, only a tiny sliver have 15-20.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1875401927&format=interactive",
  sheets_gid="1586096291",
  sql_file="image_srcset_candidates.sql"
  )
}}

A large majority of `srcset`s are populated with five-or-fewer resources.

##### `srcset` density ranges

Are developers giving browsers an appropriately wide range of choices, within their `srcset`s? In order to answer this question, we must first understand how `srcset` and `sizes` values are used by browsers.

When browsers pick a resource to load out of a `srcset`, they first assign every candidate resource a <a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#current-pixel-density">density</a>. Calculating the density of resources that use `x` descriptors is straightforward. A resource with a `2x` density descriptor has a density of (wait for it) 2x.

`w` descriptors complicate things. What's the density of a `1000w` resource? It depends on the resolved `sizes` value (which might depend on the viewport width!). When `w` descriptors are used, each descriptor is divided by the resolved `sizes` value, to determine its density. For example:

```html
<img
  srcset="large.jpg 1000w, medium.jpg 750w, small.jpg 500w"
  sizes="100vw"
/>
```

On a 500-CSS-`px`-wide viewport, these resources will be assigned the following densities:

<figure>
  <table>
    <thead>
      <tr>
        <th>Resource</th>
        <th>Density</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>large.jpg</code></td>
        <td><code>1000w</code> ÷ <code>500px</code> = 2x</td>
      </tr>
      <tr>
        <td><code>medium.jpg</code></td>
        <td><code>750w</code> ÷ <code>500px</code> = 1.5x</td>
      </tr>
      <tr>
        <td><code>small.jpg</code></td>
        <td><code>500w</code> ÷ <code>500px</code> = 1x</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="500px densities") }}</figcaption>
</figure>

However, on a 1000-CSS-`px`-wide viewport, these same resources, marked up with the same `srcset` and `sizes` values, will have different densities:

<figure>
  <table>
    <thead>
      <tr>
        <th>Resource</th>
        <th>Density</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>large.jpg</code></td>
        <td><code>1000w</code> ÷ <code>1000px</code> = 1x</td>
      </tr>
      <tr>
        <td><code>medium.jpg</code></td>
        <td><code>750w</code> ÷ <code>1000px</code> = 0.75x</td>
      </tr>
      <tr>
        <td><code>small.jpg</code></td>
        <td><code>500w</code> ÷ <code>1000px</code> = 0.5x</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="1000px densities") }}</figcaption>
</figure>

After these densities are calculated, browsers pick the resource with the density that's the best match for the current browsing context. It's safe to say that in this example, the `srcset` did not contain a wide-enough range of resources. Viewports measuring more than 1,000 CSS `px` across, with higher than `1x` densities, are not uncommon; if you're reading this on a laptop, you're probably browsing in such a context, right now. And in these contexts, the best browsers can do is pick `large.jpg`, whose 1x density will still appear blurry on the high-density display.

So, armed with both:

1. an understanding of how browsers turn `x` and `w` descriptors, `sizes` values, and browsing contexts into resource densities.
2. an understanding of how the range of resource densities in a `srcset` changes across browsing contexts, and ultimately impacts users.

…let's look at the ranges of densities supplied by the `srcset`s that use either `x` descriptors or `w` descriptors:

{{ figure_markup(
  image="srcset-density-coverage.png",
  caption="Ranges of densities covered by `srcset`s that use either `x` or `w` descriptors.",
  description="A bar chart showing the percent of `srcset`s using descriptors that cover a few different ranges of densities, on both desktop and mobile. On desktop, 91.2% of `srcset`s covered a 1x to 1.5x range. 90.2% covered a 1x to 2x range. 9.2% covered a 1x to 2.5x range. And 9.1% covered a 1x to 3x range. On mobile, 92.9% covered a 1x to 1.5x range. 92.2% covered a 1x to 2x range. 17.4% covered a 1x to 2.5x range. And 17.3% covered a 1x to 3x range.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1895556643&format=interactive",
  sheets_gid="1895556643",
  sql_file="srcset_density_coverage.sql"
  )
}}

As you interpret this data, keep in mind the viewports of the two different crawlers:

- Desktop: 1,376 × 768px @1x
- Mobile: 360 × 512px @3x

Different viewport widths would have altered many resolved `sizes` values and given different results.

That said, these results look good. Nine out of ten `srcset`s are providing a range of resources that covers a reasonable range of output display densities (1x-2x), even on the larger desktop viewport. Given <a hreflang="en" href="https://blog.twitter.com/engineering/en_us/topics/infrastructure/2019/capping-image-fidelity-on-ultra-high-resolution-devices">the exponential bandwidth costs and diminishing visual returns of densities above 2x</a>, the steep drop-off after 2x seems not only reasonable, but perhaps even optimal.

##### `sizes` accuracy

Responsive images can be tricky. Authoring reasonably-accurate `sizes` attributes—and keeping them up to date with evolving page layouts and content—might be the hardest part about getting responsive images right. How many authors get `sizes` wrong? And how wrong do they get it?

{{ figure_markup(
  image="distribution-of-img-sizes-errors.png",
  caption="Distribution of `<img>` sizes errors.",
  description="A bar chart showing the distribution of relative error of sizes attributes on both desktop and mobile. At the 10th and 25th percentile it's 0% on desktop on mobile, at the 50th percentile it's 20% on desktop and 13% on mobile, at the 75th percentile it's 100% and 67% respectively, and finally, at the 90th percentile it's 266% and 148%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1870082934&format=interactive",
  sheets_gid="424107069",
  sql_file="image_sizes_accuracy.sql"
  )
}}

More than a quarter of `sizes` attributes are perfect: exact matches for the layout size of the image. As someone who has authored a number of erroneous `sizes` attributes, myself, I found this both surprising and impressive. That is, until I realized that the accuracy measurement here was taken after JavaScript runs, and many `sizes` attributes are ultimately written by client-side JavaScript. Here are the most common `sizes` values, before JavaScript runs:

<figure>
  <table>
    <thead>
      <tr>
        <th>Sizes</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`auto`</td>
        <td class="numeric">8.2%</td>
        <td class="numeric">9.6%</td>
      </tr>
      <tr>
        <td>`(max-width: 300px) 100vw, 300px`</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">5.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 150px) 100vw, 150px`</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>`(max-width: 600px) 100vw, 600px`</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>`(max-width: 400px) 100vw, 400px`</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>`(max-width: 800px) 100vw, 800px`</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 500px) 100vw, 500px`</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 1024px) 100vw, 1024px`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 320px) 100vw, 320px`</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`(max-width: 100px) 100vw, 100px`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`100vw`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.7%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="A ranked list of the most common sizes attribute values, before JavaScript runs.", sheets_gid="228184279", sql_file="image_sizes_attribute_strings.sql") }}</figcaption>
</figure>

One in ten `sizes` attributes on mobile has an initial value of `auto`. This non-standard value is then presumably replaced by a JavaScript library (probably <a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes.js</a>), using the measured layout size of the image.

Some error in `sizes` is acceptable as the attribute provides a pre-layout hint to the browser in order to help it select an appropriate resource to load, before layout is complete. But large errors can lead to bad resource choices. This appears likely for the least-accurate quarter of `sizes` attributes, which report widths twice as large as the actual `<img>` layout width on desktop and 1.5x as large as the actual `<img>` layout width on mobile.

So: one in ten `sizes` attributes is being authored on the client by a JavaScript library, and at least one in four is inaccurate enough that the error is likely to impact resource selection. Both of these facts represent significant opportunities for either <a hreflang="en" href="https://github.com/ausi/respimagelint">existing tooling</a> or <a hreflang="en" href="https://github.com/whatwg/html/issues/4654">new web platform features</a> to help more authors get `sizes` right.

##### `<picture>` usage

The `<picture>` element serves a couple of use cases:

1. Art direction, with the [`media` attribute](https://developer.mozilla.org/docs/Web/HTML/Element/picture#the_media_attribute)
2. Format-switching, based on MIME-type, via the [`type` attribute](https://developer.mozilla.org/docs/Web/HTML/Element/picture#the_type_attribute)

{{ figure_markup(
  caption="The percentage of mobile pages which use `<picture>`.",
  content="5.9%",
  classes="big-number",
  sheets_gid="620965569",
  sql_file="picture_distribution.sql"
)
}}

`<picture>` is used much less frequently than `srcset`. Here's how usage breaks down between those two use cases:

{{ figure_markup(
  image="picture-feature-usage.png",
  caption="`<picture>` feature usage.",
  description="A bar chart showing the percent of pages which use the `media` and `type` attributes on `source` elements, in conjunction with the `picture` element. `media` is used with 48.1% of `picture` elements on mobile, and 44.7% on desktop. `type` is used with 37.6% of `picture` elements on mobile, and 38.5% of `picture` elements on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1613173002&format=interactive",
  sheets_gid="2031063502",
  sql_file="picture_switching.sql"
  )
}}

Art direction appears a bit more popular than format-switching, but both features appear underutilized when you consider their potential utility. As we've seen, very few pages are tailoring images' aspect ratios to fit mobile screens, and many more pages could deliver their imagery more efficiently using next-generation formats. These are exactly the problems that `<picture>` was invented to solve, and perhaps more than 5.9% of pages could be addressing them, using it.

It's possible that format-switching with `<source type>` is only used on 2-3% of pages because format-switching can also be accomplished using [server-side content negotiation](https://developer.mozilla.org/docs/Web/HTTP/Content_negotiation). Unfortunately, server-side adaptation mechanisms are hard to detect in the crawled data, and we have not analyzed them here.

Notably, `<source type>` and `<source media>` are not mutually exclusive, and, put together, the usage percentages here do not add up to 100%. This suggests that at least 15% of `<picture>` elements do not leverage either of these attributes, making those `<picture>`s functionally equivalent to a `<span>`.

### Layout

Once you've embedded an image on a page, you must lay it out amongst the rest of the page's contents. There are many, many ways to do this, but we can derive a few insights about how it's generally done by zooming out and answering a couple of big-picture questions.

#### Intrinsic vs extrinsic sizing

As [replaced elements](https://developer.mozilla.org/docs/Web/CSS/Replaced_element), images have a natural, ["intrinsic" size](https://developer.mozilla.org/docs/Glossary/Intrinsic_Size). This is the size that they will render at by default, if there are no CSS rules placing "extrinsic" layout constraints upon them.

How many images are intrinsically vs extrinsically sized?

{{ figure_markup(
  image="intrinsic-and-extrinsic-image-sizing.png",
  caption="Intrinsic and extrinsic image sizing.",
  description="A stacked bar chart showing the percentage of images whose width and height are determined based on extrinsic vs extrinsic sizing. There is a (for now) mysterious third category: both. The distributions between intrinsic, extrinsic, and both are quite different for height and width. For height, 59.6% of images are intrinsically sized, and 30.3% extrinsic and the remaining 10.0% fall under both. For width, 9.6% of images are intrinsically sized, and 66.1% are extrinsic, the remaining 24.4% are both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=769042260&format=interactive",
  sheets_gid="576119731",
  sql_file="image_sizing_extrinsic_intrinsic.sql"
  )
}}

The question is a little complicated because some images (those with a `max-width`, `max-height`, `min-width`, or `min-height` constraint), are sometimes extrinsically sized, but sometimes left to their intrinsic size. We've labelled those images as "both."

In any case, perhaps unsurprisingly, most images have extrinsic width constraints and height-constrained sizing is much less common.

#### Reducing layout shifts with `height` and `width`

This brings us to the last web platform feature that we'd like to investigate: <a hreflang="en" href="https://www.youtube.com/watch?v=4-d_SoCHeWE">using the `height` and `width` attributes to reserve layout space for flexible images</a>.

By default, images left to their intrinsic dimensions take up no space until they load, and their intrinsic dimensions become known. At that point—poof—they pop into the page, causing a <a hreflang="en" href="https://developers.google.com/publisher-tag/guides/minimize-layout-shift">layout shift</a>. This was exactly the problem that the `height` and `width` attributes were invented to solve—<a hreflang="en" href="https://www.w3.org/TR/2018/SPSD-html32-20180315/#img">in 1996</a>.

Unfortunately, `height` and `width` never played well with images that are assigned a variable extrinsic size in one dimension (e.g., `width: 100%;`), and left to fill out their intrinsic aspect ratio, in the other dimension. This is the dominant pattern in responsive design. So `width` and `height` fell out of favor within responsive contexts until 2019, when [a tweak to how `height` and `width` are used by browsers](https://developer.mozilla.org/docs/Web/Media/images/aspect_ratio_mapping#a_new_way_of_sizing_images_before_loading_completes) fixed this problem. Now, consistently setting `height` and `width` is one of the best things authors can do to reduce <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a>. How often are these attributes accomplishing this task?

{{ figure_markup(
  caption="The percentage of `<img>`s on mobile that have both `height` and `width` attributes and are extrinsically sized in only one dimension.",
  content="7.5%",
  classes="big-number",
  sheets_gid="1150803469",
  sql_file="img_with_dimensions.sql"
)
}}

It's hard to tell how many of these `<img>`s were authored with the new browser behavior in mind, but they're all benefiting from it. And that was the point—by re-using existing attributes, lots of existing content benefited from the change, automatically.

### Delivery

Finally, let's take a look at how images are delivered over the network.

#### Cross-origin image hosts

How many images are being hosted by the same origin that they're being embedded on? The slimmest of minorities:

{{ figure_markup(
  image="image-origins.png",
  caption="Image origins.",
  description="A bar chart showing how many images were served by the same origin as the root HTML page, vs a different (cross) origin. On both mobile 50.6% and on desktop 51.1% of images have a different origin than the document that embeds them. The other 49.4% and 48.9% are same-origin.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=391739537&format=interactive",
  sheets_gid="2134623775",
  sql_file="img_xdomain.sql"
  )
}}

Cross-origin images are subject to significant [security restrictions](https://developer.mozilla.org/docs/Web/HTML/CORS_enabled_image), and can sometimes incur <a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">performance costs</a>. On the other hand, moving static assets to a dedicated CDN is one of the most impactful things you can do to help [Time to First Byte](https://developer.mozilla.org/docs/Glossary/time_to_first_byte), and image CDNs provide powerful transformation and <a hreflang="en" href="https://web.dev/image-cdns/">optimization</a> features which can automate all sorts of best-practices. It would be fascinating to see how many of the 51% of cross-origin images are hosted on image CDNs and to compare their performance against the rest of the web's. Unfortunately, that was outside the scope of our analysis.

And with that, it is time to turn our attention to...

## Video

As the world has dramatically changed over the last year, we have seen a huge growth in video usage on the web. In the 2020 media report, it was estimated that 1-2% of websites had a `<video>` tag. In 2021, that number has jumped drastically, with over 5% of desktop sites and 4% of mobile sites incorporating a `<video>` tag.

{{ figure_markup(
  image="sites-with-at-least-one-video-element.png",
  caption="Sites with at least one video element.",
  description="A bar chart showing the prevalence of `video` elements. On desktop, 5.6% of sites have at least one video element, on mobile, 4.3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=2077989873&format=interactive",
  sheets_gid="1629096429",
  sql_file="video_adoption.sql"
  )
}}

This huge growth in video usage on the web indicates that as devices/networks improve, there is a desire to add immersive experiences such as video to sites.

When it comes to interaction with video, it is interesting to see how long the videos are when posted on a web page. We were able to query this value for 440k desktop videos, and 382k mobile videos, and broke down the duration into buckets of varying duration (in seconds):

{{ figure_markup(
  image="video-durations.png",
  caption="Video durations.",
  description="A bar chart showing how long videos are, on desktop and mobile. On desktop, 20.7% of videos are between 0-10 seconds, 39.5% are between 10-30 seconds, 18.7% are between 30-60 seconds, 11.5% are between 60-120 seconds, and 9.6% are over 120 seconds. On mobile, 20.8% are between 0-10 seconds, 35.8% are between 10-30 seconds, 20.0% are between 30-60 seconds, 12.6% are between 60-120 seconds, and 10.7% are more than 120 seconds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=366287434&format=interactive",
  sheets_gid="1864781514",
  sql_file="video_durations.sql"
  )
}}

Most videos on the web are short: ~ 60% of videos are under 30 seconds long on both mobile and desktop. However, 12-13% are between one and two minutes, and 10% of videos are over two minutes long.

### Video: formats

What types of files are being delivered as video?  We queried all files with `video` in the MIME type, and then sorted by the file extension.

The chart below shows all video extensions with over 1% market share:

{{ figure_markup(
  image="top-extensions-of-files-with-a-video-mime-type.png",
  caption="Top extensions of files with a video MIME type.",
  description="A bar chart showing the extensions of video files delivered on desktop and mobile, in both 2020 and 2021. Desktop and mobile numbers are similar. The `mp4` extension accounted for 64.3% of videos on desktop in 2020, but only 49.2% in 2021. Blank extensions accounted for 17.8% of videos in 2020, increasing sharply to 32.1% in 2021. The `ts` extension accounted for 6.3% of `fvideos` in 2020, and 10.0% in 2021. `m4s` rose from 2.4% to 3.3%. `webm` fell from 7.6% to 3.3%. Finally, `mov` grew from nothing in 2020 to 0.8% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=2066681624&format=interactive",
  sheets_gid="1430902287",
  sql_file="video_ext.sql"
  )
}}

By far, the #1 video format on the web is the `mp4` (or MPEG-4), since the <a hreflang="en" href="https://caniuse.com/mpeg4">mp4 h264 format has 98.4% support in all modern browsers</a>, and the 1.9% of browsers that do not support `mp4` have no video support, so the number is really 100% coverage. Interestingly, the `mp4` usage has dropped by ~15% YOY on both desktop and mobile. WebM support also [dropped significantly YOY](../2020/media#videos) (50% drop on both mobile and desktop).

Where we see the growth are files with no extension (these are often from YouTube or other streaming platforms), and in web streaming. `ts` files are segments used in HTTP Live Streaming (HLS)  where we see a 4% jump in usage. `.m4s` are MPEG Dynamic Adaptive Streaming over HTTP (MPEG-DASH) video segments. M4S files grew by 50% from 2.3% to 3.3% YOY.

### Video CSS: `display`

To begin, let's look at how a video will appear on a page by looking at the CSS `display` property for that video. What we find is that approximately half of all videos use a display value of `block`—placing the video on its own line and allowing for height and width values to be set for the video. The `inline-block` value also allows height and width to be specified—for a total of two thirds of all videos.

The `display: none` declaration hides the video from the viewer. One in five videos on the web is hidden behind this display value. From a data usage perspective, this is less than optimal, as the video is still downloaded by the browser.

{{ figure_markup(
  image="video-css-display-percentages.png",
  caption="Video CSS display percentages.",
  description="A bar chart showing the percentage of video elements with various values of the CSS display property. `block` accounts for 50.5% of elements on desktop, and 45.4% on mobile. `none` accounts for 17.8% on desktop and 21.1% on mobile. `inline` accounts for 15.5% of elements on desktop, and 16.7% on mobile. Finally, `inline-block` accounts for 14.9% of elements on desktop, and 16.5% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1841222549&format=interactive",
  sheets_gid="428232209",
  sql_file="video_styles.sql"
  )
}}

### Video attributes

The `<video>` HTML5 tag has a number of attributes that can be used to define how the video player will appear to end users.

Let's look at the most common attributes and how they are used inside the `<video>` tag:

{{ figure_markup(
  image="video-element-attributes.png",
  caption="Video element attributes.",
  description="A bar chart showing the number of times various attributes on the HTML video element were found on both desktop and mobile. `preload` is 15.3% on desktop and 15.3% on mobile, `autoplay` is 14.1% and 14.5% respectively, `src` is 8.9% and 7.7%, `playsinline` is 6.9% and 7.8%, `width` is 6.8% and 7.5%, `muted` is 7.1% and 7.1%, `controls` is 5.8% and 7.2%, `loop` is 6.6% and 6.0%, `crossorigin` is 3.9% and 3.0%, `poster` is 0.7% and 0.7%, `controlslist` is 0.2% and 0.2%, and finally `height` is 0.1% and 0.1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1099468813&format=interactive",
  sheets_gid="1827909463",
  sql_file="video_attribute_count.sql"
  )
}}

#### `preload`

The most commonly used attribute is preload. The preload attribute gives the browser a hint on the best way to handle the video download. There are four possible options: `auto`, `metadata`, `none`, and an empty response (which uses the default of `auto`).

{{ figure_markup(
  image="video-preload-values.png",
  caption="Video preload values.",
  description="A bar chart showing the prevalence of the various preload attribute values, on desktop and mobile, in both 2020 and 2021. Preload was not used for 50.6% of videos on desktop in 2020, compared to 54.4% in 2021, with the mobile numbers being 59.2% and 58.8% respectively. The value `none` was used on 19.8% of videos on desktop in 2020 dropping to 18.1% in 2021, for mobile the drop was smaller from 16.8% to 16.7%. The value `auto` was used on 16.6% of videos on desktop, dropping to 12.9% for 2021, with the mobile drop being from 13.7% to 12.0%. `metadata` was used on 10.1% of videos on desktop in 2020 rising to 11.8% in 2021, and on mobile there was a similar rise from 8.0% to 10.1%. No value was set for 1.8% of desktop videos in 2020, 1.7% of desktop videos in 2021, 1.5% of mobile videos in 2020 and 1.6% of mobile videos in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=151055771&format=interactive",
  sheets_gid="1624656886",
  sql_file="video_preload_values.sql"
  )
}}

Interestingly, we see a large push away from `preload` on both mobile and desktop. While it is possible that this changed for many videos, it could just be that the new videos added to the web over the last year do not utilize this setting. From a page weight perspective this is a large win for the web.

#### `autoplay`

The next most commonly used attribute is `autoplay`. This tells the browser that the video should play as soon as possible (and because of this, autoplay will actually override the preload attribute).

The autoplay attribute is a Boolean attribute, meaning that its presence by default means true. So, for the 190 sites that use `autoplay="false"`, we're sorry to tell you that is not going to work.

#### `width`

The `width` attribute is also one of the top `<video>` attributes. It tells the browser how wide the video player should be. Note that `height` is very rarely used, since the browser can set this - but it will use a  <a hreflang="en" href ="https://github.com/whatwg/html/issues/3090">default aspect-ratio of 2:1</a> which may be incorrect if not explicitly overridden with the `aspect-ratio` CSS styling.

The width can be presented as a percentage, or a width in pixels.

* When a percentage width is defined, the value `100%` is used in 99% of cases.
* When a width in pixels is defined, we see very similar numbers of videos at lower widths, but a large drop-off in the 1800 and 1920 widths:

{{ figure_markup(
  image="video-widths.png",
  caption="Video widths.",
  description="A bar chart showing the distribution of `width` attribute values. The values for desktop and mobile are very similar throughout most of the range, until the end. Starting at the left: values between 100-200 pixels were used 0.6% of the time on desktop and 0.5% on mobile, 200 - 300 is used 4.9% and 5.4% respectively, 300 - 400 is used 5.1% and 6.6%, 400 - 500 is used 2.4% and 2.6%, 500 - 600 is used 1.8% and 1.8%, 600 - 700 is used 11.4% and 12.6%, 700 - 800 is used 0.9% and 1.0%, 800 - 900 is used 1.4% and 1.3%, 900 - 1000 is used 0.5% and 0.6%, 1000 - 1100 is used 1.2% and 1.1%, 1100 - 1200 is used 0.5% and 0.7%, 1200 - 1300 is used 0.9% and 1.1%, 1300 - 1400 is used 1.5% and 1.6%, 1400 - 1500 is used 0.2% on desktop and not on mobile, 1800 - 1900 is used 7.2% and 4.8%, 1900 - 2000 is used 4.6% and 2.4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1390110707&format=interactive",
  sheets_gid="1827909463",
  sql_file="video_attribute_widths.sql"
  )
}}

It appears that about half of sites with larger videos that also define the width of the video remove the larger videos for mobile devices. Since very few devices need a 1080p (1920 wide) video embedded in a website, this makes sense.

#### `src` and `<source>`

The `src` attribute is used in the `<video>` tag to point to the URL of the video to be played. Another way to reference the video is to use the `<source>` element.

One of the key ideas behind the `<source>` element is that the developer can supply multiple video formats to the browser, and the browser will select the first format that the browser understands.

When we look at `<source>` usage, we see that about 40% of videos have no `<source>` element—implying that they use the `src` attribute. This is similar to the ratio found in 2020 (35%).

{{ figure_markup(
  image="source-element-count.png",
  caption="`source` element count.",
  description="A bar chart showing the frequency of various numbers of `source` elements per `video` element. The most common number of `source` elements per `video` is 1, around 49.2% of desktop and 51.1% of mobile `video`s contain this many sources. The second most common number of `source` children is 0: 40.5% of desktop and 38.2% of mobile `video`s have no `source` children. 7.2% and 7.6% respectively contain 2, 2.8% on both contain 3, and finally 0.2% of `video` elements on both desktop and mobile contain 4 elements.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=709685412&format=interactive",
  sheets_gid="1279089769",
  sql_file="video_number_of_sources.sql"
  )
}}

We also see that the `<source>` element is most often used with just one element (50% of all `<video>` tags). Only 10% of `<video>` elements have 2 or more video sources named. By a 3:1 ratio, 2 is more common than 3 sources, and then there is a small selection of more than 3 (there is one video with 48 sources!).

Let's look at the videos that use 2 sources. Here are the top 10 occurrences:

<figure>
  <table>
    <thead>
      <tr>
        <th>Format</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    </tbody>
      <tr>
        <td>`["video/mp4","video/webm"]`</td>
        <td class="numeric:">25.9%</td>
        <td class="numeric:">26.1%</td>
      </tr>
      <tr>
        <td>`["video/webm","video/mp4"]`</td>
        <td class="numeric:">22.3%</td>
        <td class="numeric:">23.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/ogg"]`</td>
        <td class="numeric:">20.2%</td>
        <td class="numeric:">24.2%</td>
      </tr>
      <tr>
        <td>`[null,null]`</td>
        <td class="numeric:">14.1%</td>
        <td class="numeric:">8.0%</td>
      </tr>
      <tr>
        <td>`["video/mp4"]`</td>
        <td class="numeric:">3.6%</td>
        <td class="numeric:">3.4%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/mp4"]`</td>
        <td class="numeric:">3.5%</td>
        <td class="numeric:">5.1%</td>
      </tr>
      <tr>
        <td>`["application/x-mpegURL","video/mp4"]`</td>
        <td class="numeric:">2.4%</td>
        <td class="numeric:">2.1%</td>
      </tr>
      <tr>
        <td>`[]`</td>
        <td class="numeric:">2.1%</td>
        <td class="numeric:">1.8%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs="avc1.42E01E, mp4a.40.2","video/webm; codecs="vp8, vorbis"]`</td>
        <td class="numeric:">0.8%</td>
        <td class="numeric:">0.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4;","video/webm;"]`</td>
        <td class="numeric:">0.4%</td>
        <td class="numeric:">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The most common ordered pairs of `type` values, when there are two `source` elements within a `video` element.", sheets_gid="1549760253", sql_file="video_source_formats.sql") }}</figcaption>
</figure>

In six of the top 10 examples, the MP4 is listed as the first source. <a hreflang="en" href="https://caniuse.com/mpeg4">MP4 support on the web is at 98.4%</a>, and the browsers that do not support MP4 generally do not support the `<video>` tag at all. This implies that these sites do not need two sources and could save some storage on their web servers by removing their WebM or Ogg video sources—or they could reverse the order of the videos, and browsers that support WebM will download the WebM.

The same trend holds for `<video>` elements with three sources—eight of the top 10 examples begin with MP4.

<figure>
  <table>
    <thead>
      <tr>
        <th>Format</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    </tbody>
      <tr>
        <td>`["video/mp4","video/webm","video/ogg"]`</td>
        <td class="numeric:">30.4%</td>
        <td class="numeric:">28.6%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=avc1","video/mp4; codecs=avc1","video/mp4; codecs=avc1"]`</td>
        <td class="numeric:">13.3%</td>
        <td class="numeric:">16.4%</td>
      </tr>
      <tr>
        <td>`["video/webm","video/mp4","video/ogg"]`</td>
        <td class="numeric:">7.0%</td>
        <td class="numeric:">6.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=avc1"]`</td>
        <td class="numeric:">5.8%</td>
        <td class="numeric:">7.1%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/ogg","video/webm"]`</td>
        <td class="numeric:">5.0%</td>
        <td class="numeric:">5.5%</td>
      </tr>
      <tr>
        <td>`["video/mp4;","video/ogg; codecs="theora, vorbis","video/webm; codecs="vp8, vorbis"]`</td>
        <td class="numeric:">3.8%</td>
        <td class="numeric:">1.2%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=hevc","video/webm","video/mp4"]`</td>
        <td class="numeric:">3.2%</td>
        <td class="numeric:">3.4%</td>
      </tr>
      <tr>
        <td>`["video/mp4"]`</td>
        <td class="numeric:">3.0%</td>
        <td class="numeric:">3.0%</td>
      </tr>
      <tr>
        <td>`["video/ogg; codecs="theora, vorbis","video/webm","video/mp4"]`</td>
        <td class="numeric:">2.7%</td>
        <td class="numeric:">3.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/webm","video/ogv"]`</td>
        <td class="numeric:">2.5%</td>
        <td class="numeric:">1.7%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The most common ordered triplets of `type` values, when there are three `source` elements within a `video` element.", sheets_gid="1549760253", sql_file="video_source_formats.sql") }}</figcaption>
</figure>

Of course, these implementations will just play the MP4 file, and the WebM and Ogg files will be ignored.

The incorporation of video on the web has grown immensely over the last year—jumping from 1-2% of web pages to 4-5%. We expect this growth to continue. Interestingly, the "king of video", MP4, while still the king, is having its market share eroded by video streaming formats (that feature responsive and adaptive video sizing).

We do see movement to more performant usage of the `<video>` tag—with less use of `preload=auto`—and more use of `preload=none` as well as we see behaviors in the `width` attribute that indicate that videos are being modified (or removed) for smaller screens.

## Conclusion

As we stated at the outset: the web is increasingly visual, and the ways in which we use the web's evolving feature set to encode, embed, lay out, and deliver media continue to evolve. This year, native lazy-loading stemmed the tide of ever-increasing image transfer sizes. And universal support for WebP and initial support for AVIF pave the way for a visually richer and more efficient future. On the video side, we saw an explosion in the number of `<video>` elements and increasing use of sophisticated delivery methods like adaptive bitrate streaming.

The Web Almanac is a chance to take stock and look back. It's also a time to chart a path forward. Here's to ever-more effective visual communication on the web in 2022.

