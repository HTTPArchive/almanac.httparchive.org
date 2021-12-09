---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Media chapter of the 2021 Web Almanac covering how images and videos are currently being encoded, embedded, styled, and delivered on the web
authors: [eeeps, dougsillars]
reviewers: [Navaneeth-akam, tpiros, akshay-ranganath, addyosmani]
analysts: [eeeps, dougsillars, akshay-ranganath]
editors: []
translators: []
eeeps_bio: Eric Portis is a Web Platform Advocate at <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>.
dougsillars_bio: Doug Sillars is an leader in developer relations, and a digital nomad working on the intersection of performance and media. He tweets [@dougsillars](https://twitter.com/dougsillars), and blogs regularly at <a hreflang="en" href="https://dougsillars.com">dougsillars.com</a>.
results: https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/
featured_quote: This year, native lazy-loading stemmed the tide of ever-increasing image transfer sizes.
featured_stat_1: 99.93%
featured_stat_label_1: Pages that load an image resource of some kind.
featured_stat_2: 87.1%
featured_stat_label_2: Images on the web delivered as JPEGs, PNGs, or GIFs insteasd of next-gen formats!
featured_stat_3: 5.6%
featured_stat_label_3: Share of desktop pages that included a `video` element. A three-fold increase from last year.
unedited: true
---

## Introduction

Almost three decades ago <a hreflang="en" href="https://thehistoryoftheweb.com/the-origin-of-the-img-tag/">the `<img>` tag dropped</a> and hyper<em>text</em> became hyper<em>media</em>. The web has become increasingly visual ever since. What is the state of media on the web in 2021? Let's look at images and videos, in turn.

## Images

Images are ubiquitous on the web. Almost every page contains image content.

{{ figure_markup(
  content="96%",
  caption="Percentage of pages that contained at least one contentful `<img>`",
  classes="big-number",
  sheets_gid="1756671383",
  sql_file="at_least_one_img.sql"
)
}}

And effectively _all_ pages serve up _some_ sort of imagery (even if it's just a background or favicon).

{{ figure_markup(
  content="99.93%",
  caption="Percentage of pages that generated at least one request for an image resource",
  classes="big-number",
  sheets_gid="1062090109",
  sql_file="at_least_one_image_request.sql"
)
}}

The impact that all of these images have is hard to overstate. [As the Page Weight chapter highlights](./page-weight), images are still responsible for more bytes per page than any other resource type. However, year-over-year, per-page image transfer sizes have decreased.

{{ figure_markup(
  image="mobile-image-transfer-size-by-year.png",
  caption="Mobile image transfer size by year.",
  description="Bar chart showing the distribution of total image transfer sizes, per page, and how it has changed between 2020 and 2021. At the 25th percentile, transfer sizes have reduced from 277 kB to 257 kB. At the 50th, they've shrunk from 916 kB to 877 kB. And at the 75th percentile, they've gone down from 2,352 kB to 2,324 kB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=478222195&format=interactive",
  sheets_gid="381418851",
  sql_file="../page-weight/bytes_per_type_2021.sql"
)
}}

This is surprising; for the last decade, the <a hreflang="en" href="https://httparchive.org/reports/state-of-images#bytesImg">Image Bytes</a> chart on the HTTP Archive's monthly <a hreflang="en" href="https://httparchive.org/reports/state-of-images">State of Images report</a> has seemingly only ever gone one direction: up. What reversed this trend in 2021? I think it may have something to do with native lazy-loading's rapid adoption; more on that later in the chapter.

In any case, by quantity, images continue to make up an awful lot of the _stuff_ of the web. But tallying the sheer number of elements, requests, and bytes doesn't tell us how crucial images are to users' experiences. To get a sense of that, we can look at the <a hreflang="en" href="https://web.dev/lcp/">Largest Contentful Paint</a> metric, which tries to identify the most important piece of above-the-fold content on any given page. [As you can see in the Performance chapter](./performance#fig-19), the LCP element has an image on around three quarters of pages.

{{ figure_markup(
  content="71%",
  caption="Mobile pages whose LCP element has an image. On the desktop it's 79%!",
  classes="big-number",
  sheets_gid="1423728540",
  sql_file="../performance/lcp_element_data.sql"
)
}}

Images are crucial to user's experiences of the web! Let's dive in, taking a closer look at how they're encoded, embedded, laid out, and delivered.

### Encoding

Every image on the web is passed around as a file. What can we say out about the files themselves, and the image data that they contain?

#### Dimensions

Let’s start by looking at their pixel dimensions. We'll start small.

##### Single-pixel images

Many `<img>` elements don't actually represent contentful <a hreflang="en" href="https://www.merriam-webster.com/dictionary/image">images</a>; instead, they contain a only a single–likely invisible–pixel:

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

These single-pixel `<img>` elements  are, put bluntly, hacks: they are being abused either to do layout (which would be better done with CSS) or to track users (which would be better accomplished using the [Beacon API](https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API)).

We can establish a baseline breakdown of what jobs all of these single-pixel `<img>`s are doing by looking at how many use [data URIs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs).

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>Data URI single-pixel `<img>`s</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Mobile</td>
        <td>44.7%</td>
      </tr>
      <tr>
        <td>Desktop</td>
        <td>47.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Data URI single pixel images.", sheets_gid="1851007461", sql_file="image_1x1.sql") }}</figcaption>
</figure>

The single-pixel `<img>`s containing data URIs are almost certainly being used for layout. The remaining ~54% which generate a request might be there for layout or they might be tracking pixels; we can't tell.

Note that throughout the rest of this analysis, we have excluded single-pixel `<img>`s from the results. We're interested in `<img>` elements that are presenting visual information to the user, not tracking pixels or layout hacks.

##### Multiple-pixel images

When `<img>`s contain more than one pixel–how many pixels do they contain?

{{ figure_markup(
  image="image-pixel-counts.png",
  caption="Distribution of image pixel counts.",
  description="Bar chart showing the distribution of megapixels per image. Both the desktop and mobile bars are shown, but there is little difference between them, and only the mobile bars are labeled. At the 10th percentile, images contain 0.001 megapixels; at the 25th, 0.009; at the 50th, 0.043; at the 75th, 0.170, and at the 90th, 0.514.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=493015352&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

The median `<img>` loads ~40,000 pixels on both desktop and mobile. I found this number surprisingly small. Just under half of crawled`<img>`s (excluding the ones that loaded single-pixel images, or nothing at all) contain fewer pixels than a 200x200 image. When you consider the number of `<img>` elements per page, though, this statistic is less surprising. Most pages contain more than 15 images, so while images with more than half-a-megapixel might only account for one in ten `<img>` elements, they are not at all uncommon, as we navigate across pages.

{{ figure_markup(
  image="number-of-imgs-per-page.png",
  caption="Number of `<img>`s per page.",
  description="Bar chart showing the distribution of img elements per page. Both the desktop and mobile bars are shown; the desktop bars are consistently 10-20% larger, but only the mobile bars are labeled. At the 10th percentile, mobile pages contain 2 img elements; at the 25th, 6; at the 50th, 15; at the 75th, 32; and at the 90th, 61.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1641393356&format=interactive",
  sheets_gid="1553608446",
  sql_file="imgs_per_page.sql"
  )
}}

I was also surprised that there was almost no difference between desktop and mobile top end of the pixel count distribution. Initially, this seemed to indicate a lack of effective adoption of responsive image features, but when you consider that the mobile crawler has a 360 × 512px @3x viewport, while the desktop viewport is 1,376 × 768px @1x, it isn't actually surprising: the crawlers' viewports had similar widths, in physical pixels (1,080 vs 1,376). A bigger difference in physical pixel resolution between the crawlers would be more revealing.

##### Aspect ratios

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
        <td>4:3</td>
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
  description="A bar chart showing the distribution of image byte sizes on both desktop and mobile. At the tenth percentile, both the desktop and mobile bars are so small they're effectively invisible; the place where the mobile bar would otherwise be is labeled 252 (bytes). At the 25th percentile both bars are visible and tiny; the mobile bar is labeled 1,902. At the 50th percentile, both bars still look about the same and are still rather short; the mobile bar is labeled 10,290. At the seventy fifth percentile, the mobile bar is slightly taller than the desktop one, and is labelled 41,590. Finally, the 90th percentile bars tower over the rest. The desktop bar is slightly ahead this time; the mobile bar is labelled 130,662.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=717078449&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

The median contentful `<img>` weighs in at just over 10kB. But, again, the median page contains 15-17 `<img>`s, so, when looking at _pages_, the ninetieth percentile here–images that push past 100kB–aren't rare at all.

#### Bits per pixel

Bytes and dimensions are interesting on their own, but to get a sense of how compressed the web's image data is, we need to put bytes and pixels together, to calculate _bits per pixel_. Doing so allows us to make apples-to-apples comparisons of the information density of images, even if those images have different resolutions.

In general, bitmaps on the web decode to eight bits of information per channel, per pixel. So if we have an RGB image with no transparency, we can expect a decoded, uncompressed image to weigh in at <a hreflang="en" href="https://en.wikipedia.org/wiki/Color_depth#True_color_(24-bit">24 bits per pixel</a>). A good rule of thumb for _lossless_ compression is that it should reduce filesizes by a 2:1 ratio (which would work out to 12 bits per pixel for our 8-bit RGB image); the rule of thumb for 1990s-era lossy compression schemes (JPEG and MP3) was a 10:1 ratio (2.4 bits/pixel). It should be noted that, depending on image content and encoding settings, these ratios vary *widely*, and modern JPEG encoders like <a hreflang="en" href="https://github.com/mozilla/mozjpeg">MozJPEG</a> typically outperform this 10:1 target at their default settings.

So, with all of that context, here's how the web's images stack up:

{{ figure_markup(
  image="distribution-of-image-bits-per-pixel.png",
  caption="Distribution of image bits per pixel.",
  description="A bar chart showing the distribution of image bits per pixel, for both desktop and mobile. The desktop bars are consistently 5-10% taller than the mobile ones; only the mobile bars are labelled. At the tenth percentile, the web's images weigh in at 0.2 bits per pixel. At the 25th, 1.1; at the 50th, 2.4; at the 75th, 6.0; and finally at the 90th percentile, mobile images weigh in at a whopping 13.5 bits per pixel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=839945889&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

The median `<img>` on mobile hits that 10:1 compression ratio target on the nose: 2.4 bits/pixel. However, around that median, there is a tremendous spread. Let's break things down by format in order to learn a bit more.

##### Bits per pixel, by format

{{ figure_markup(
  image="median-bits-per-pixel-by-format.png",
  caption="Median bits per pixel by format.",
  description="A bar chart showing the median bits per pixel, by format, for a number of popular image formats. Only the mobile bars are labelled. First we have GIF; the median GIF on mobile weighs in at 7.4 bits per pixel, with the desktop bar being a bit shorter. Second, PNG; the median PNG on mobile has 4.6 bits per pixel; the desktop bar is a tad longer. Next we have JPEG, which weighs in at 2.1 bits per pixel on mobile (ever so slightly higher on desktop). Then, AVIF: 1.5 bits per pixel on mobile, and notably (15%-ish) less on desktop. Last, WebP. The median WebP takes 1.4 bits per pixel on mobile; ever-so-slightly less on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1390065360&format=interactive",
  sheets_gid="30152726",
  sql_file="bytes_and_dimensions_by_format.sql"
  )
}}

The median JPEG weighs in at 2.1 bits per pixel. Given the format's ubiquity, this is the best baseline to measure other formats by.

The median PNG weighs in at more than twice that. PNG is sometimes called a "lossless" format; a median of 4.6 bits per pixel shows how false this is. True lossless compression should typically land at around 12-16 bits per pixel (depending on whether or not we're dealing with an alpha channel); PNG comes in so far below this because common PNG tooling is usually _lossy_: it modifies pixels–reducing color palettes and introducing dithering patterns–before encoding pixels, to boost compression ratios.

GIFs, weighing in at 7.4 bits per pixel, come off terribly here, and make no mistake, <a hreflang="en" href="https://web.dev/efficient-animated-content/">they</a> <a hreflang="en" href="https://bitsofco.de/optimising-gifs/">are</a> <a hreflang="en" href="https://dougsillars.com/2019/01/15/state-of-the-web-animated-gifs/">terrible</a>! But they're also at a bit of an unfair disadvantage here because many GIFs on the web are animated. Web platform APIs don't expose the number of frames in an animated image, so we haven't accounted for frames. To give you a sense of how much this inflates GIF's numbers: a GIF measured as 20 bits per pixel, here, which contains ten frames, should be fairly counted as using 2 bits per pixel.

Things get really interesting when we look at two next-gen formats: WebP and AVIF. Both weigh in almost 40% lighter than JPEG, at 1.3-1.5 bits per pixel. In formal studies using <a hreflang="en" href="https://kornel.ski/en/faircomparison">matched qualities</a>, WebP outperforms JPEG by <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">between 25-34%</a>, so its real-world performance seems surprisingly *good*. On the other hand, AVIF's creators have published data suggesting that it is capable of <a hreflang="en" href="https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4">outperforming modern JPEG encoders JPEG by 50%+, in the lab</a>. So while AVIF's performance here is good, I expected it to be better. I can think of a few possible explanations for these discrepancies between lab data and real world performance.

First: tooling. JPEG encoders vary incredibly widely, ranging from hardware encoders in cameras which don't spend much effort compressing images well, to ancient copies of <a hreflang="en" href="https://en.wikipedia.org/wiki/Libjpeg">libjpeg</a> installed decades ago, to bleeding-edge, best-practice-by-default encoders like MozJPEG. In short, there are a lot of old, badly-compressed JPEGs out there, but every WebP and AVIF has been compressed with modern tooling.

Also, anecdotally, <a hreflang="en" href="https://developers.google.com/speed/webp/download">cwebp</a> is relatively aggressive about quality/compression, and returns lower-quality, more-compressed results by default than most common JPEG tooling.

And as far as AVIF is concerned: <a hreflang="en" href="https://github.com/AOMediaCodec/libavif">libavif</a> is capable of a wide variety of compression ratios depending on which "speed" setting you choose. At its slowest speeds (producing the highest-efficiency files) libavif can take _minutes_ to render a single image. It's reasonable to assume that different image-rendering pipelines will make different tradeoffs when choosing speed settings, depending on their constraints. This results in a wide distribution of compression performance.

Another thing to keep in mind when evaluating AVIF's real-world performance here, is that there just aren't that many AVIFs out there in the wild, yet. The format is currently being used by relatively few sites, on a limited set of content, so we don't yet have a full sense of how it will ultimately perform "in the wild," on the web. This will be interesting to track over the coming years, as adoption increases (and tooling improves).

One thing that is absolutely clear in both lab data and in our results is that both WebP and AVIF can be used to deliver a wide variety of content (including photography, <a hreflang="en" href="https://jakearchibald.com/2020/avif-has-landed/#flat-illustration">illustrations</a>, and images with transparency) more efficiently than the web's legacy formats. But, as we'll see in the next section, not that many sites have adopted them.

##### Format adoption

{{ figure_markup(
  image="image-format-adoption-mobile.png",
  caption="Image format adoption (mobile).",
  description="A pie chart breaking down each format's share of the web's images. JPEG comes in first, at 41.8%. Next we have PNG, at 28.8%; GIF, at 16.5%; WebP at 6.9%; and SVG, at 4.0%. A couple of tiny slivers of the pie are left unlabeled.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=832165430&format=interactive",
  sheets_gid="1886692503",
  sql_file="media_formats.sql"
  )
}}

The old formats still reign: JPEG dominates, with PNG and GIF rounding out the podium. Together, they account for almost 90% of the images on the web. WebP–which is now more than a decade old but which <a hreflang="en" href="https://www.macrumors.com/2020/06/22/webp-safari-14/">only achieved universal browser support last year</a>–is still in the single digits. And effectively no-one is using AVIF, which accounted for only 0.04% of crawled resources. We found a thousand JPEGs for every AVIF.

For an in-depth analysis of how (and educated guesses as to why!) WebP and AVIF adoption has changed over time, the best resource is Paul Calvano's excellent recent talk at ImageReady (<a hreflang="en" href="https://www.youtube.com/watch?v=tz5bpAQY43k">full video</a>; <a hreflang="en" href="https://docs.google.com/presentation/d/1VS5QjNR6lh2y9jL5xaeainQ2cTAWyy7QiEjDMh4hNQA/edit#slide=id.gefc0d6ffce_0_0">slides 13-15</a>). In it, he shows that WebP adoption increased by ~34% from July 2020 (when Safari added support) to July 2021. AVIF's numbers have risen even more rapidly, in percentage terms, though perhaps that's not surprising given that the format is still brand new and used by relatively few sites. A few [large](https://twitter.com/chriscoyier/status/1465474900588646408) <a hreflang="en" href="https://medium.com/vimeo-engineering-blog/upgrading-images-on-vimeo-620f79da8605">players</a> adopting AVIF was all it took.

### Embedding

In order to display an image on a web page, we must embed it, using the `<img>` element. This venerable element has gained a handful of new features over the past few years; how are those features being put into practice?

#### Lazy-loading

If there is one breakout story this year as far as images on the web, it is <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">native lazy-loading</a> adoption. Look at this chart:

{{ figure_markup(
  image="adoption-of-native-loading-lazy-on-img.png",
  caption='Adoption of `loading="lazy"` on `<img>`.',
  description="A line chart showing the percent of pages using native lazy-loading, over time. From January 2019 to May 2020 there is 0% usage. From there we get a nice, two-stage curve, with accelerating usage through the summer, up to about August when eight percent of pages used lazy-load, and then decelerating (but still ever-increasing) adoption for the next year or so, through to July 2021, where the line terminates at about 18%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1314627953&format=interactive",
  sheets_gid="157636784",
  sql_file="../resource-hints/imgLazy.sql"
  )
}}

In July of 2020, native lazy-loading was used on just 1% of pages. By July of 2021, that number had exploded, to 18%. This is an unbelievable rate of  growth considering the vast number of pages and templates which are not updated from year to year.

Personally, I think native lazy-loading's rapid adoption is the best explanation we have for the trend-breaking reduction in image bytes per page, this year.

What fueled lazy-load adoption? There's some consensus that it was a combination of ease of use, pent-up developer demand, and WordPress <a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">enabling lazy-loading by default across a vast swath of the web</a>.

Perhaps native lazy-loading has been _too_ successful? The Resource Hints chapter notes that [the majority of lazy-loaded images were in the initial viewport](./resource-hints#fig-16) (whereas the feature is ideally used on "below the fold" images). Furthermore, the Performance chapter found that [9.3% of Largest Contentful Paint elements have their `loading` attribute set to `lazy`](./performance#fig-20), which significantly delays the page's most important piece of content from loading, and hurts users' experiences.

#### Decoding

The `decoding` attribute on `<img>` serves as a useful point of contrast to highlight native lazy-loading's success. <a hreflang="en" href="https://www.chromestatus.com/feature/4897260684967936">First supported</a> in 2018–about a year before native lazy-loading–the `decoding` attribute allows developers to prevent large image decode operations from blocking the main thread. It provides functionality that not all web developers need or understand, and that shows in the usage data. <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1934121343">`decoding` is used on just 1% of pages, and on only 0.3% of `<img>` elements</a>.

#### Accessibility

When you embed contentful images on webpages, you should make their content as accessible as possible for non-visual users. I note this only to [defer you to the Accessibility chapter](./accessibility#images), whose in-depth analysis of image accessibility on the web found small year-over-year progress in this area, but mostly: a whole lot of room for improvement.

#### Responsive images

In 2013, a suite of features enabling adaptive image loading on responsive websites landed, to much fanfare. Eight years in, how are responsive image features being used?

##### Srcset

First, let us consider the [`srcset` attribute](https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/srcset), which allows developers to supply multiple possible resources for the same `<img>`:

###### Feature adoption

Almost a third of crawled pages use `srcset`; pretty good!

{{ figure_markup(
  caption="Percent of pages that use `srcset`.",
  content="31%",
  classes="big-number",
  sheets_gid="1594311632",
  sql_file="image_srcset_sizes.sql"
)
}}

And `w` descriptors, which allow browsers to select a resource based on both varying layout widths and varying screen densities, are four times more popular than `x` descriptors, which only enable DPR-adaptation.

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

###### Number of candidates

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

A large majority of `srcset`s  are populated with five-or-fewer resources.

###### Resource densities

Are developers giving the browser an appropriately wide range of choices? To figure this out, we can calculate each resource's <a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#current-pixel-density">density</a>: a measure of how many image pixels the `<img>` will paint in each CSS `px`, if left to its intrinsic dimensions. If the range of resource densities covers a reasonable range of real-world device DPRs, the `srcset` has a wide-enough range.

{{ figure_markup(
  image="distribution-of-image-srcset-candidate-densities.png",
  caption="Distribution of image srcset candidate densities.",
  description="A bar chart showing the distribution of image srcset candidate densities, on both desktop and mobile. Only the mobile bars (which are always higher) are labelled. At the tenth percentile, mobile candidates have a density of 0.7x; the desktop bar appears to be about 0.4x. At the 25th, 1.0x on mobile, and close to 0.8x on desktop. At the median (50th percentile), candidates on mobile have a density of 1.5x; the desktop density appears to be about 1x. At the 7th percentile, the mobile density is 2.7x and the desktop density appears to be about 2.0x. Lastly, at the 90th percentile, mobile candidates had 4.3x and desktop candidates were around 3.15x.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=403058700&format=interactive",
  sheets_gid="1410495845",
  sql_file="image_srcset_densities.sql"
  )
}}

The mobile crawler here saw higher densities than the desktop crawler, which is expected. Viewport-relative `sizes` values resolve to smaller values on mobile viewports, resulting in higher densities for the same resources. Taken as a whole, [given that most devicePixelRatios fall somewhere between 1x-3x](https://twitter.com/TheRealNooshu/status/1397862141894529027), this appears to be a healthy range of densities. It would be interesting to perform a deeper analysis that counted how many `srcsets` _didn't_ fully cover a "reasonable" ~1x-2x range; this is left as an exercise to the reader (or next year's analysts!).

###### Sizes accuracy

Responsive images can be tricky. Authoring reasonably-accurate `sizes` attributes–and keeping them up to date with evolving page layouts and content–might be the hardest part about getting responsive images right. How many authors  get `sizes` wrong? And how wrong do they get it?

{{ figure_markup(
  image="distribution-of-img-sizes-errors.png",
  caption="Distribution of `<img>` sizes errors.",
  description="A bar chart showing the distribution of relative error of sizes attributes on both desktop and mobile. Only the mobile bars are labelled. Both desktop and mobile show 0% error at both the 10th and 25th percentiles. At the 50th percentile, mobile error is 13%, dekstop error appears to be about 20%. At the 75th percentile, mobile error is 67%; desktop error looks to be right at 100%. At the ninetieth percentile, mobile error is 148%; desktop error has skyrocketed to over 260%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1870082934&format=interactive",
  sheets_gid="424107069",
  sql_file="image_sizes_accuracy.sql"
  )
}}

More than a quarter of `sizes` attributes are perfect: exact matches for the layout size of the image. As someone who has authored a number of erroneous `sizes` attributes, myself, I found this both surprising and impressive. That is, until I realized that the accuracy measurement here was taken _after_ Javascript runs, and many `sizes` attributes are ultimately written by client-side Javascript. Here are the most common `sizes` values, _before_ Javascript runs:

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
  <figcaption>{{ figure_link(caption="A ranked list of the most common sizes attribute values, before Javascript runs.", sheets_gid="228184279", sql_file="image_sizes_attribute_strings.sql") }}</figcaption>
</figure>

One in ten `sizes` attributes on mobile has an initial value of `auto`. This non-standard value is then presumably replaced by a Javascript library (probably <a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes.js</a>), using the measured layout size of the image.

Some error in `sizes` is acceptable; the attribute provides a pre-layout hint to the browser in order to help it select an appropriate resource to load,_ before_ layout is complete. But large errors can lead to bad resource choices. This appears likely for the least-accurate quarter of `sizes` attributes, which report widths twice as large as the actual `<img>` layout width on desktop and 1.5x as large as the actual `<img>` layout width on mobile.

So: one in ten `sizes` attributes is being authored on the client by a Javascript library, and at least one in four is inaccurate enough that the error is likely to impact resource selection. Both of these facts represent significant opportunities for either <a hreflang="en" href="https://github.com/ausi/respimagelint">existing tooling</a> or <a hreflang="en" href="https://github.com/whatwg/html/issues/4654">new web platform features</a> to help more authors get `sizes` right.

##### `<picture>`

The `<picture>` element serves a couple of use cases:

1. Art direction, with the [`media` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture#the_media_attribute)
2. Type-switching, via the [`type` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture#the_type_attribute)

{{ figure_markup(
  caption="The percentage of pages which use `<picture>`.",
  content="6%",
  classes="big-number",
  sheets_gid="620965569",
  sql_file="picture_distribution.sql"
)
}}

`<picture>` is used much less frequently than `srcset`, reflecting its somewhat-niche pair of use-cases. Here's how usage breaks down between those two use cases:

{{ figure_markup(
  image="picture-feature-usage.png",
  caption="`<picture>` feature usage.",
  description="A bar chart showing the percent of pages which use the `media` and `type` attributes on `source` elements, in conjunction with the `picture` element. `media` is used with 48% of `picture` elements on mobile, and just over 44% on desktop. `type` is used with 37% of `picture` elements on mobile, and close to 39% of `picture` elements on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1613173002&format=interactive",
  sheets_gid="2031063502",
  sql_file="picture_switching.sql"
  )
}}

Art direction appears a bit more popular than type-switching. Notably, these two features are not mutually exclusive, and, put together, the usage percentages here do not add up to 100%. This suggests that at least 15% of `<picture>` elements do not leverage either of these attributes, making those `<picture>`s  functionally equivalent to a `<span>`.

### Layout

Once you've embedded an image on a page, you must lay it out amongst the rest of the page's contents. There are many, many ways to do this, but we can derive a few insights about how it's generally done by zooming out and answering a couple of big-picture questions.

#### Intrinsic vs extrinsic sizing

As [replaced elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Replaced_element), images have a natural, ["intrinsic" size](https://developer.mozilla.org/en-US/docs/Glossary/Intrinsic_Size). This is the size that they will render at by default, if there are no CSS rules placing "extrinsic" layout constraints upon them.

How many images are extrinsically vs extrinsically sized?

{{ figure_markup(
  image="intrinsic-and-extrinsic-image-sizing.png",
  caption="Intrinsic and extrinsic image sizing.",
  description="A stacked bar chart showing the percentage of images whose width and height are determined based on extrinsic vs extrinsic sizing. There is a (for now) mysterious third category: both. The distributions between intrinsic, extrinsic, and both are quite different for height and width. For height, 60% of images are intrinsically sized, and 30% extrinsic; the remainder fall under both. For width, just 10% of images are intrinsically sized, and 66% are extrinsic; the remaining 24% are both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=769042260&format=interactive",
  sheets_gid="576119731",
  sql_file="image_sizing_extrinsic_intrinsic.sql"
  )
}}

The question is a little complicated because some images (those with a `max-width`, `max-height`, `min-width`, or `min-height` constraint), are _sometimes_ extrinsically sized, but sometimes left to their intrinsic size. We've labelled those images as "both."

In any case, perhaps unsurprisingly, most images have extrinsic width constraints and height-constrained sizing is much less common.

#### Reducing layout shifts with `height` and `width`

This brings us to the last web platform feature that we'd like to investigate: <a hreflang="en" href="https://www.youtube.com/watch?v=4-d_SoCHeWE">using the `height` and `width` attributes to reserve layout space for flexible images</a>.

By default, images left to their intrinsic dimensions take up no space until they load and their intrinsic dimensions become known. At that point–poof–they pop into the page, causing a <a hreflang="en" href="https://developers.google.com/publisher-tag/guides/minimize-layout-shift">layout shift</a>. This was exactly the problem that the `height` and `width` attributes were invented to solve–<a hreflang="en" href="https://www.w3.org/TR/2018/SPSD-html32-20180315/#img">in 1996</a>.

Unfortunately, `height` and `width` never played well with images that are assigned a variable extrinsic size in one dimension (e.g., `width: 100%;`), and left to fill out their intrinsic aspect ratio, in the other dimension. This is the dominant pattern in responsive design. So `width` and `height` fell out of favor within responsive contexts until 2019, when [a tweak to how `height` and `width` are used by browsers](https://developer.mozilla.org/en-US/docs/Web/Media/images/aspect_ratio_mapping#a_new_way_of_sizing_images_before_loading_completes) fixed this problem. Now, consistently setting `height` and `width` is one of the best things authors can do to reduce <a hreflang="en" href="https://web.dev/cls/">Cumulative Layout Shift</a>. How often are these attributes accomplishing this task?

{{ figure_markup(
  caption="The percentage of `<img>`s on mobile that have both `height` and `width` attributes, and are extrinsically sized in only one dimension.",
  content="7.5%",
  classes="big-number",
  sheets_gid="1150803469",
  sql_file="img_with_dimensions.sql"
)
}}

It's hard to tell how many of these `<img>`s were authored with the new browser behavior in mind, but they're all benefiting from it. And that was the point; by re-using existing attributes, lots of existing content benefitted from the change, automatically.

### Delivery

Finally, let's take a look at how images are delivered over the network.

#### Cross-origin image hosts

How many images are being hosted by the same origin that they're being embedded on? The slimmest of minorities:

{{ figure_markup(
  image="image-origins.png",
  caption="Image origins.",
  description="A bar chart showing how many images were served by the same origin as the root HTML page, vs a different (cross) origin. On both mobile and desktop, 51% of images are have a different origin than the document that embeds them. The other 49% are same-origin.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=391739537&format=interactive",
  sheets_gid="2134623775",
  sql_file="img_xdomain.sql"
  )
}}

Cross-origin images are subject to significant [security restrictions](https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_enabled_image), and can sometimes incur <a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">performance costs</a>. On the other hand, moving your static assets to a dedicated CDN is one of the most impactful things you can do to help [Time to First Byte](https://developer.mozilla.org/en-US/docs/Glossary/time_to_first_byte), and image CDNs provide powerful transformation and <a hreflang="en" href="https://web.dev/image-cdns/">optimization</a> features which can automate all sorts of best-practices. It would be fascinating to see how many of the 51% of cross-origin images are hosted on image CDNs and to compare their performance against the rest of the web's; unfortunately that was outside the scope of our analysis.

And with that, it is time to turn our attention to...

## Video

As the world has dramatically changed over the last year, we have seen a huge growth in video usage on the web. In the 2020 media report, it was estimated that 1-2% of websites had a `<video>` tag. In 2021, that number has jumped drastically, with over 5% of desktop sites and 4% of mobile sites incorporating a `<video>` tag.

{{ figure_markup(
  image="sites-with-at-least-one-video-element.png",
  caption="Sites with at least one video element.",
  description="A bar chart showing the prevalence of `video` elements. On desktop, 6% of sites have at least one video element; on mobile, 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=2077989873&format=interactive",
  sheets_gid="1629096429",
  sql_file="video_adoption.sql"
  )
}}

This huge growth in video usage on the web indicates that as devices/networks improve, there is a desire to add immersive experiences such as video to sites.

When it comes to interaction with video, it is interesting to see how long the videos are when posted on a webpage. We were able to query this value for 440k desktop videos, and 382k mobile videos, and broke down the duration into buckets of varying duration (in seconds):

{{ figure_markup(
  image="video-durations.png",
  caption="Video durations.",
  description="A bar chart showing how long videos are, on desktop and mobile. On desktop, 21% of videos are between 0-10 seconds, 39% are between 10-30 seconds, 19% are between 30-60 seconds, 12% are between 60-120 seconds, and 10% are over 120 seconds. On mobile, 21% are between 0-10 seconds, 36% are between 10-30 seconds, 20% are between 30-60 seconds, 13% are between 60-120 seconds, and 11% are more than 120 seconds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=366287434&format=interactive",
  sheets_gid="1864781514",
  sql_file="video_durations_mobile.sql"
  )
}}

Most videos on the web are short: ~ 60% of videos are under 30 seconds long on both mobile and desktop. However, 12-13% are between one and two minutes, and 10% of videos are over two minutes long.

### Video: formats

What types of files are being delivered as video?  We queried all files with "video" in the MIME type, and then sorted by the file extension.

The chart below shows all video extensions with over 1% market share:

{{ figure_markup(
  image="top-extensions-of-files-with-a-video-mime-type.png",
  caption="Top extensions of files with a video MIME type.",
  description="A bar chart showing the extensions of video files delivered, on desktop and mobile, in both 2020 and 2021. Only the desktop numebrs are labeled; the mobile numbers are similar. The mp4 extension accounted for 64.31% of videos on desktop in 2020, but only 49.22% in 2021. Blank extensions accounted for 17.76% of videos in 2020, increasing sharply to 32.12% in 2021. The ts extension accounted for 6.27% of fvideos in 2020, and 10.04% in 2021. m4s rose from 2ish% (the label is obscured) to 3.34%. webm fell from 7.62% to 3.28%. Finally, mov fell from 0.83% in 2020 to an unlabelled, almost invisible bar that looks to be approximately 0% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=2066681624&format=interactive",
  sheets_gid="1430902287",
  sql_file="video_ext.sql"
  )
}}

By far, the #1 video format on the web is the mp4, since the <a hreflang="en" href="https://caniuse.com/mpeg4">mp4 h264 format has 98.4% support in all modern browsers</a>, and the 1.9% of browsers that do not support mp4 have no video support, so the number is really 100% coverage. Interestingly, the mp4 usage has dropped by ~15% YOY on both desktop and mobile. WebM support also dropped significantly YOY (50% drop on both mobile and desktop). (data from [Web Almanac 2020](../2020/media#videos)

Where we see the growth are files with no extension (these are often from YouTube or other streaming platforms), and in web streaming. Ts files are segments used in HTTP Live Streaming (HLS)  where we see a 4% jump in usage. .m4s are MPEG Dynamic Adaptive Streaming over HTTP (MPEG-DASH) video segments. M4s files grew by 50% from 2.3% to 3.3% YOY.

### Video CSS: `display`

To begin, let's look at how the video will appear on the page by looking at the CSS `display` property for the video. What we find is that approximately half of all videos use a display value of `block`—placing the video on its own line and allowing for height and width values to be set for the video. The `inline-block` value also  allows height and width to be specified—for a total of two third's of all videos.

The  `display: none` declaration hides the video from the viewer. One in five videos on the web is hidden behind this display value. From a data usage perspective, this is less than optimal, as the video is still downloaded by the browser.

{{ figure_markup(
  image="video-css-display-percentages.png",
  caption="Video CSS display percentages.",
  description="A bar chart showing the percentage of video elements with various values of the CSS display property. `block` accounts for 51% of elements on desktop, and 45% on mobile. `inline` accounts for 15% of elements on desktop, and 17% on mobile. `inline-block` accounts for 15% of elements on desktop, and 16% on mobile. Finally, `none` accounts for 18% on desktop and 21% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1841222549&format=interactive",
  sheets_gid="428232209",
  sql_file="video_styles_mobile.sql"
  )
}}

### Video attributes

The video HTML5 tag has a number of attributes that can be used to define how the video player will appear to end users.

Let's look at the most common attributes and how they are used inside the `<video>` tag:

{{ figure_markup(
  image="video-element-attributes.png",
  caption="Video element attributes.",
  description="A bar chart showing the number of times various attributes on the HTML video element were found, on both desktop and mobile. With the exception of `controls`, which is slightly more common on mobile, every attribute is more common on desktop by 5-30%. The tallest pair of bars is `preload`; `buffered`s are the shortest. None of the bars are labelled, but their desktop numbers are approximately: `autoplay`: 100,000; `buffered`: 0; `controls`: 45,000; `controllist`: 1,000; `crossorigin`: 30,000; `height`: 3,000; `loop`: 50,000; `muted`: 55,000; `playsinline`: 52,000; `poster`: 24,000; `preload`: 115,000; `src`: 90,000; width: 60,000.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1099468813&format=interactive",
  sheets_gid="1827909463",
  sql_file="video_attribute_count_mobile.sql"
  )
}}

#### Preload

The most commonly used attribute is preload. The preload attribute gives the browser a hint on the best way to handle the video download. There are four possible options: `auto`, `metadata`, `none`, and an empty response = `auto`.

{{ figure_markup(
  image="video-preload-values.png",
  caption="Video preload values.",
  description="A bar chart showing the prevalence of the various preload attribute values, on desktop and mobile, in both 2020 and 2021. `auto` was used in 36% of preload attributes in 2020 on desktop, falling to 23% in 2021. On mobile, `auto` fell from 27% to 18%. `metadata` was used in 24% of preload attribuets on desktop in 2020, rising slightly to 25% in 2021. On mobile, `metadata` usage rose from 33% to 36%. The `none` value was present in 33% of preload attributes on desktop in 2020, rising to 46% in 2021. On mobile, usage also rose, from 33% to 40%. Finally, around 4% of preload attributes were present but left blank on desktop, and 5% on mobile, with no change for either between 2020 and 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1322480946&format=interactive",
  sheets_gid="7133313",
  sql_file="video_attribute_count_mobile.sql"
  )
}}

Interestingly, we see a large push away from `preload=auto` on both mobile and desktop, with most of the movement to `preload=none.`  While it is possible that this changed for many videos, it could just be that the new videos added to the web over the last year utilize the "none" parameter more than in the past. From a page weight perspective—this is a large win for the web.

#### Autoplay

The next most commonly used attribute is "autoplay."  This tells the browser that the video should play as soon as possible (and because of this, autoplay will actually override the preload attribute).

The autoplay attribute is a boolean attribute, meaning that its presence by fault means true. So for the 190 sites that use `autoplay="false"`, we're sorry to tell you that is not going to work.

#### Width

The width attribute is also one of the top video attributes. It tells the browser how wide the video player should be (note that height is very rarely used, since the aspect ratio of the video will decide the space with just one value.)

The width can be presented as a percentage, or a width in pixels.

* When a percentage width is defined, the value "100%" is used in 99% of cases.
* When a width in pixels is defined, we see very similar numbers of videos at lower widths, but a large dropoff in the 1800 and 1920 widths:

{{ figure_markup(
  image="video-widths.png",
  caption="Video widths.",
  description="A bar chart showing the distribution of width attribute values. The values for desktop and mobile are very similar throughout most of the range, until the end. Starting at the left: values between 100-200 pixels were used ~800 times. As we go wider, there's a sharp increase, as values between 200-300 and 300-400 are both used around 4,000 times. After that, there's a slow, steady decline for a while, with a large exception in the 600-700 pixel range. This range has far more usage than any other: 7,000 uses. There's another much smaller bump for the 1,200-1,300 range, which looks about twice as high as its preceeding neighbor, measuring 1,200 uses. By the time we hit values of 1700-1800, usage looks close to zero, but then it shoots back up again. On desktop, values between 1800-1900 are found more than 4,000 times, whereas on mobile this range accounts for 2,400 uses. Finally, values between 1900-2000 are also fairly common (and more common on desktop than they are on mobile): 2,800 uses on desktop, and 600 uses on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1390110707&format=interactive",
  sheets_gid="1827909463",
  sql_file="video_attribute_widths.sql"
  )
}}

It appears that about half of sites with larger videos that also define the width of the video _remove_ the larger videos for mobile devices. Since very few devices need a 1080p (1920 wide) video embedded in a website, this makes sense.

#### Src and source

The src attribute is used in the `<video>` tag to point to the URL of the video to be played. Another way to reference the video is to use the `<source>` element.

One of the key ideas behind the `<source>` element is that the developer can supply multiple video formats to the browser, and the browser will select the first format that the browser understands.

When we look at `<source>` usage, we see that about 40% of videos have no `<source>` element—implying that they use the `src` attribute. This is similar to the ratio found in 2020 (35%).

{{ figure_markup(
  image="source-element-count.png",
  caption="`source` element count.",
  description="A bar chart showing the frequency of various numbers of `source` elements per `video` element. 0.02% of `video` elements contain 5 elements; 0.2% contain 4; 2-3% contain 3; and 7.5% contain 2. The most common number of `source` elements per `video` is 1; around 50% of `video`s contain this many sources. The second most common number of `source` children is 0: 38-40% of `video`s have no `source` children.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=709685412&format=interactive",
  sheets_gid="1279089769",
  sql_file="video_number_of_sources_mobile.sql"
  )
}}

We also see that the source element is most often used with just one element (50% of all video tags). Only 10% of videos have 2 or more video sources named. By a 3:1 ratio, 2 is more common than 3 sources, and then there is a small selection of more than 3 (there is one video with 48 sources!).

Let's look at the videos that use 2 sources. Here are the top 10 occurrences:

<figure>
  <table>
    <thead>
      <tr>
        <th>Format</th>
      </tr>
    </thead>
    </tbody>
      <tr>
        <td>`["video/mp4","video/webm"]`</td>
      </tr>
      <tr>
        <td>`["video/webm","video/mp4"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/ogg"]`</td>
      </tr>
      <tr>
        <td>`[null,null]`</td>
      </tr>
      <tr>
        <td>`["video/mp4"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/mp4"]`</td>
      </tr>
      <tr>
        <td>`["application/x-mpegURL","video/mp4"]`</td>
      </tr>
      <tr>
        <td>`[]`</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs="avc1.42E01E, mp4a.40.2","video/webm; codecs="vp8, vorbis"`</td>
      </tr>
      <tr>
        <td>`["video/mp4;","video/webm;"]`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The most common ordered pairs of `type` values, when there are two `source` elements within a `video` element.", sheets_gid="1549760253", sql_file="video_source_formats_mobile.sql") }}</figcaption>
</figure>

{# TODO I'm not sure this is such an interesting table. Consider adding some stats to make it more interesting? % of usage on mobile and desktop? #}

In six of the top 10 examples, the MP4 is listed as the first source. <a hreflang="en" href="https://caniuse.com/mpeg4">MP4 support on the web is at 98.4%</a>, and the browsers that do not support MP4 generally do not support the `<video>` tag at all. This implies that these sites do not need two sources, and could save some storage on their web servers by removing their WebM or Ogg video sources. (Or, they could reverse the order of the videos, and browsers that support WebM will download the WebM).

The same trend holds for `<video>` elements with three sources—eight of the top 10 examples begin with MP4.

<figure>
  <table>
    <thead>
      <tr>
        <th>Format</th>
      </tr>
    </thead>
    </tbody>
      <tr>
        <td>`["video/mp4","video/webm","video/ogg"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=avc1","video/mp4; codecs=avc1","video/mp4; codecs=avc1"]`</td>
      </tr>
      <tr>
        <td>`["video/webm","video/mp4","video/ogg"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=avc1"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/ogg","video/webm"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4;","video/ogg; codecs="theora, vorbis","video/webm; codecs="vp8, vorbis"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=hevc","video/webm","video/mp4"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4"]`</td>
      </tr>
      <tr>
        <td>`["video/ogg; codecs="theora, vorbis","video/webm","video/mp4"]`</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/webm","video/ogv"]`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The most common ordered triplets of `type` values, when there are three `source` elements within a `video` element.", sheets_gid="1549760253", sql_file="video_source_formats_mobile.sql") }}</figcaption>
</figure>

{# TODO I'm not sure this is such an interesting table. Consider adding some stats to make it more interesting? % of usage on mobile and desktop? #}

Of course, these implementations will just play the MP4 file, and the WebM and Ogg files will be ignored.

The incorporation of video on the web has grown immensely over the last year—jumping from 1-2% of webpages to 4-5%. We expect this growth to continue. Interestingly, the "king of video", MP4, while still the king, is having its market share eroded by video streaming formats (that feature responsive and adaptive video sizing).

We do see movement to more performant usage of the `<video>` tag—with less use of `preload=auto`—and more use of `preload=none` as well as we see behaviors in the width attribute that indicate that videos are being modified (or removed) for smaller screens.

## Conclusion

As we stated at the outset: the web is increasingly visual, and the ways in which we use the web's evolving feature set to encode, embed, lay out, and deliver media continue to evolve. This year, native lazy-loading stemmed the tide of ever-increasing image transfer sizes. And universal support for WebP and initial support for AVIF pave the way for a visually-richer and more efficient future. On the video side, we saw an explosion in the number of `<video>` elements, and increasing use of sophisticated delivery methods like adaptive bitrate streaming.

The Web Almanac is a chance to take stock and look back; it's also a time to chart a path forward. Here's to ever-more effective visual communication on the web in 2022.

