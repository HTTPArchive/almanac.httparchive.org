---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Media chapter of the 2022 Web Almanac covering how images and videos are currently being encoded, embedded, styled, and delivered on the web.
hero_alt: Hero image of Web Almanac characters projecting an image onto a screen while other Web Almanac characters walk to cinema seats with popcorn to watch the projection.
authors: [eeeps, akshay-ranganath]
reviewers: [nhoizey, yoavweiss]
analysts: [eeeps, akshay-ranganath]
editors: [MichaelLewittes]
translators: []
eeeps_bio: Eric Portis is a Web Platform Advocate at <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>.
akshay-ranganath_bio: Akshay Ranganath is a Sr. Solution Architect at <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a> and likes to work on CDN/WebPerf challenges.
results: https://docs.google.com/spreadsheets/d/1T5oVAVmcH3sM6R-WwH4ksr2jFtPhuLXs3-iXXoABb3E/
featured_quote: The most exciting developments this year are the accelerating adoption of AVIF and the ever-increasing adoption of lazy-loading and adaptive bitrate streaming. There were, however, some frustrating aspects, including the almost complete lack of wide-gamut color spaces; the undying zombie format that is GIF; and the way that both sizes and lazy-loading ( two features designed for performance) are—through improper use—hurting performance on a significant number of pages.
featured_stat_1: 99.9%
featured_stat_label_1: Pages that generated at least one image request.
featured_stat_2: 405%
featured_stat_label_2: Year-over-year change in AVIF adoption.
featured_stat_3: 59%
featured_stat_label_3: Video elements whose duration is under thirty seconds.
---

## Introduction

Despite being hyper*text*, the web is extremely visual. In fact, images and videos are an essential part of the web user experience. They're also undergoing tremendous innovation, and the Web Almanac gives us a unique opportunity to survey both how far the visual web has come—as authors adopt new technologies such as AVIF, wide color, adaptive bitrate streaming, and lazy loading—and how far it still has to go: I'm looking at you, animated GIF.

Let's dive right in.

## Images

Images account for a huge portion of the typical website's page weight. We see from the [Page Weight](./page-weight) chapter that the median website's total weight in June of 2021 was 2,019 kilobytes (on mobile), and 881 of those kilobytes were images. That's more than HTML (30 KB), CSS (72 KB), JavaScript (461 KB) and fonts (97 KB) combined.

{{ figure_markup(
  content="99.9%",
  caption="Pages that generated at least one request for an image resource.",
  classes="big-number",
  sheets_gid="1169944186",
  sql_file="at_least_one_image_request.sql"
)
}}

Almost every page serves up some kind of an image, even if it's just a background or favicon.

{{ figure_markup(
  content="70%",
  caption="Mobile pages whose LCP responsible element has an image.",
  classes="big-number",
  sheets_gid="1131925867",
  sql_file="lcp_element_data.sql"
)
}}

On the vast majority of pages—70% on mobile, and 80% on desktop—the most impactful resource is an image. <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP) is a web performance metric that identifies the largest element above the fold. Most of the time that element has an image.

It's hard to overstate the importance of images on the web. So, what can we say about the web's images?

### Image resources

Let's start with the resources themselves. Bitmap images are made of pixels. How many pixels do the web's images typically have?

#### A note on single-pixel images

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
        <td class="numeric">7.3%</td>
      </tr>
      <tr>
        <td>Desktop</td>
        <td class="numeric">7.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Resources loaded by `<img>` elements that contain just a single pixel.", sheets_gid="1553017697", sql_file="image_1x1.sql") }}</figcaption>
</figure>

A suspiciously large number of them are 1×1. These `<img>`s don't contain any image content at all. Instead, they're being used for two purposes: for layout (as [spacer GIFs](https://en.wikipedia.org/wiki/Spacer_GIF)) or as [tracking beacons](https://en.wikipedia.org/wiki/Web_beacon).

Any newly authored website should use CSS for layout and the [Beacon API](https://developer.mozilla.org/docs/Web/API/Beacon_API) for tracking. Lots of existing content will use tracking pixels and spacer GIFs forever, but it's disheartening that the desktop number here is unchanged from [last year](../2021/media#fig-5), and that the mobile number has only shrunk by a tiny amount. <a hreflang="en" href="https://developers.facebook.com/docs/meta-pixel/implementation/marketing-api#intialize-img">Old habits</a> <a hreflang="en" href="https://spacergif.org/stats/">die hard</a>!

Wherever possible, we excluded these not-really-an-image `<img>`s from our analysis.

#### Image dimensions

{{ figure_markup(
  image="distribution-of-image-pixel-counts.png",
  caption="Distribution of image pixel counts.",
  description="Bar chart showing the distribution of pixels per image on desktop and mobile, but there is little difference between them (desktop is consistently slightly lower). At the 10th percentile, mobile images contain 0.001 megapixels, at the 25th percentile it's 0.01, at the 50th it's 0.046, at the 75th it's 0.203, and at the 90th percentile it's 0.608.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=988080204&format=interactive",
  sheets_gid="708677709",
  sql_file="bytes_and_dimensions.sql"
)
}}

Moving on to images that contain more than one pixel: Most of them are fairly small, but the majority of pages also contain at least one big image.

"Megapixels" aren't the most intuitive measure of image size. For perspective, at a 4:3 aspect ratio, the median pixel count of 0.046MP works out to a 248×186 image.

That may seem small, but the median page includes at least one `<img>` that contains almost 10 times more pixels than the median `<img>` element.

{{ figure_markup(
  image="largest-image-per-page-by-pixel-count.png",
  caption="Largest image per page (by pixel count).",
  description="Bar chart showing the distribution of largest image per page, by pixels. The chart shows both desktop and mobile; desktop appears consistently 10-20% higher, but those bars are unlabeled. At the 10th percentile, mobile pages' largest image contains 0.201 megapixels. At the 25th percentile it's 0.113 megapixels, at the 50th it's 0.431 megapixels, at the 75th it's 1.088, and at the 90th percentile it's 2.560 megapixels.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=230013578&format=interactive",
  sheets_gid="209430368",
  sql_file="largest_image_per_page_pixels.sql"
)
}}

At the aspect ratio of 4:3, 0.431MP works out to 758×569. Considering the mobile crawler has a (typical) 360px-wide viewport, it's likely that many of these large images end up painted across almost the whole viewport and at high densities.

In short: most images are small, but most pages include at least one big image.

#### Image aspect ratios

What sorts of aspect ratios are common on the web?

{{ figure_markup(
  image="image-orientations.png",
  caption="Image orientations.",
  description="A pair of stacked bars showing what percentage of images are portrait-oriented, landscape-oriented, and square, on both desktop and mobile. The desktop breakdown is: 13% portrait, 33% square, and 54% landscape. The mobile breakdown is identical.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=5572776&format=interactive",
  sheets_gid="976702915",
  sql_file="portrait_landscape_square.sql"
)
}}

[Much like last year](../2021/media#aspect-ratios), most images are landscape-oriented, and there is virtually no difference between the mobile and desktop numbers. Similar to 2021, this feels like a huge missed opportunity. As many-an-Instagrammer knows, portrait-oriented images <a hreflang="en" href="https://uxdesign.cc/the-powerful-interaction-design-of-instagram-stories-47cdeb30e5b6">render larger on mobile screens</a> at full-width than either square or landscape-oriented images do, and <a hreflang="en" href="https://www.dashhudson.com/blog/best-picture-format-instagram-dimensions">drive higher engagement</a>. Even when the source material is landscape-oriented, we can and should try to tailor images for mobile screens, using <a hreflang="en" href="https://web.dev/codelab-art-direction/">art direction</a>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Aspect ratio</th>
        <th>% of images</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1:1</td>
        <td class="numeric">32.92%</td>
      </tr>
      <tr>
        <td>4:3</td>
        <td class="numeric">3.99%</td>
      </tr>
      <tr>
        <td>3:2</td>
        <td class="numeric">2.74%</td>
      </tr>
      <tr>
        <td>2:1</td>
        <td class="numeric">1.66%</td>
      </tr>
      <tr>
        <td>16:9</td>
        <td class="numeric">1.62%</td>
      </tr>
      <tr>
        <td>3:4</td>
        <td class="numeric">1.02%</td>
      </tr>
      <tr>
        <td>2:3</td>
        <td class="numeric">0.72%</td>
      </tr>
      <tr>
        <td>5:3</td>
        <td class="numeric">0.54%</td>
      </tr>
      <tr>
        <td>6:5</td>
        <td class="numeric">0.48%</td>
      </tr>
      <tr>
        <td>8:5</td>
        <td class="numeric">0.47%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="A ranked list of the top ten image aspect ratios (mobile).", sheets_gid="1668821585", sql_file="top_aspect_ratios.sql") }}</figcaption>
</figure>

Images' aspect ratios were clustered around "standard" values, such as 4:3, 3:2 and, in particular, 1:1 (square). In fact, 40% of all images had one of those three aspect ratios, and the top 10 aspect ratios accounted for nearly half of all `<img>`s.

#### Image color spaces

Images are made of pixels and each pixel has a color. The range of colors that are possible within a given image is determined by that image's [color space](https://en.wikipedia.org/wiki/Color_space).

The default color space on the web is [sRGB](https://en.wikipedia.org/wiki/SRGB). CSS colors are specified in sRGB by default and—unless they're marked otherwise—<a hreflang="en" href="https://imageoptim.com/color-profiles.html">browsers assume that the colors in images are sRGB, too</a>.

This made sense in a world where approximately all display and capture hardware dealt in sRGB—or something close to it. But the times, they are a-changin'. In 2022, most phone cameras capture in wider-than-sRGB gamuts. Also, display hardware capable of richer, outside-of-sRGB colors is now quite common.

Every modern browser that's painting to a wide-gamut display will happily paint vibrant, outside-of-sRGB colors, if we encode our images using wider than sRGB gamuts. But are we?

In short: No.

In order to tell a browser that an image uses a non-sRGB color space, authors must generally attach an [ICC profile](https://en.wikipedia.org/wiki/ICC_profile) to it that describes the image's color space. Those ICC profiles have names. We found a little more than 25,000 unique ICC profile names in use on the web. Here are the top 20:


<figure>
  <table>
    <thead>
      <tr>
        <th>ICC profile description</th>
        <th>sRGB-ish</th>
        <th>Wide-gamut</th>
        <th>% of images</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Untagged</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">90.17%</td>
      </tr>
      <tr>
        <td>sRGB IEC61966-2.1</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">3.23%</td>
      </tr>
      <tr>
        <td>c2ci</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">2.40%</td>
      </tr>
      <tr>
        <td>sRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.88%</td>
      </tr>
      <tr>
        <td>Adobe RGB (1998)</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.76%</td>
      </tr>
      <tr>
        <td>uRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.54%</td>
      </tr>
      <tr>
        <td>Display P3</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>c2</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.33%</td>
      </tr>
      <tr>
        <td>Display</td>
        <td></td>
        <td></td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>sRGB built-in</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.24%</td>
      </tr>
      <tr>
        <td>GIMP built-in sRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.22%</td>
      </tr>
      <tr>
        <td>sRGB IEC61966-2-1 black scaled</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td>Generic RGB Profile</td>
        <td></td>
        <td></td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>U.S. Web Coated (SWOP) v2</td>
        <td></td>
        <td></td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>sRGB MozJPEG</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Artifex Software sRGB ICC Profile</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Dot Gain 20%</td>
        <td></td>
        <td></td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Coated FOGRA39 (ISO 12647-2:2004)</td>
        <td></td>
        <td></td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>Apple Wide Color Sharing Profile</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>sRGB v1.31 (Canon)</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>HD 709-A</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="A ranked list of the top twenty ICC color space descriptions (mobile).", sheets_gid="560546690", sql_file="color_spaces_and_depth.sql") }}</figcaption>
</figure>

Nine out of ten images on the web are untagged, meaning that if they contain RGB data, it will be interpreted as sRGB. Most of the remaining 10% are explicitly tagged with sRGB or something similar to it: "c2ci", "uRGB", and "c2" are all sRGB variants <a hreflang="en" href="https://github.com/saucecontrol/Compact-ICC-Profiles">designed to be minimal and lightweight</a>. Just a little more than 1% of all of the web's images have been tagged with a wider-than-sRGB gamut. More succinctly, wide-gamut images are currently about as popular on the web as grayscale images—<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1T5oVAVmcH3sM6R-WwH4ksr2jFtPhuLXs3-iXXoABb3E/edit?pli=1#gid=560546690&range=P5">which account for 1.16% of the web's images</a>.

One caveat: AVIF and PNG allow tagging images with wide-gamut color spaces using format-specific shorthands, without using ICC profiles. We started down the path of trying to detect wide-gamut AVIFs and PNGs that don't use ICC profiles, but accounting for the various ways they are encoded—and the ways our tooling reported on them—proved a bit too complex to tackle this year. Maybe next year!

### Encoding

Now that we've gleaned a bit about the web's image content, what can we say about how that content is encoded for delivery?

#### Format adoption

GIF, JPEG, and PNG have been the standard bitmap image file formats on the web for decades. That started to change when Chrome shipped support for WebP in 2014. Over the past couple of years that change has accelerated. Safari and Firefox have now shipped WebP support, and all three major browsers have shipped at least experimental support for AVIF.

By format, here's every image resource the crawler saw:

{{ figure_markup(
  image="image-format-adoption.png",
  caption="Image format adoption.",
  description="A pie chart breaking down each format's share of the web's images. JPEG comes in first, at 40.3%. Next, we have PNG, at 28.2%, GIF, at 15.9%, WebP at 8.9%, SVG, at 4.7%, and ICO, at 1.6%. A couple of tiny slivers of the pie are left unlabeled.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1390540775&format=interactive",
  sheets_gid="635730566",
  sql_file="media_formats.sql"
)
}}

At 0.22%, AVIF's slice of that pie is so small it's not even labeled on the chart. And while 0.22% may not sound like a lot, compared to last year, it represents quite a bit of progress.

{{ figure_markup(
  image="image-format-adoption-year-over-year-change.png",
  caption="Image format adoption, year-over-year change.",
  description="A bar chart showing the year-over-year change in each format's share of usage. AVIF is the standout, showing a 405% gain. WebP and SVG also saw gains of 29% and 16%, respectively. The legacy formats are all slightly down: JPEG: -4%; PNG: -2%; GIF: -4%; ICO: -8%. Lastly, \"other/unknown\" comes in at +2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1597734507&format=interactive",
  sheets_gid="635730566",
  sql_file="media_formats.sql"
)
}}

Slowly, the old formats are making way for the new ones. As they should! The new formats outperform the old ones by a significant margin. We'll get a sense of that shortly.

#### Bytesizes

How heavy is the typical image on the web?

{{ figure_markup(
  image="distribution-of-image-byte-sizes.png",
  caption="Distribution of image byte sizes.",
  description="A bar chart showing the distribution of image byte sizes on both desktop and mobile, though only the mobile bars are labelled (the desktop bars appear consistently about 5% smaller). At the tenth percentile it's 0 kilobytes, at the 25th percentile it's 2 KB, at the 50th percentile it's 10 KB, at the 75th percentile it's 46 KB, and finally, at the 90th percentile it's 148 KB bytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=961266271&format=interactive",
  sheets_gid="708677709",
  sql_file="bytes_and_dimensions.sql"
)
}}

A median of 10 KB might lead one to think, "Eh, not that heavy!" But, just as when we looked at pixel counts, while there are many small images, most pages have at least one large one:

{{ figure_markup(
  image="largest-image-per-page-by-kilobytes.png",
  caption="Largest image per page (by kilobytes).",
  description="Bar chart showing the distribution of largest image per page, by kilobytes. The chart shows both desktop and mobile; mobile typically appears about 10% lower than desktop. At the 10th percentile, both mobile and desktop pages' largest image weighs in at six kilobytes. At the 25th percentile desktop is at 37 kilobytes and mobile is at 34 kilobytes. At the 50th it's 142 and 127 kilobytes; at the 75th it's 425 and 377 kilobytes, and at the 90th it's 1,013 and 911 kilobytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=185626936&format=interactive",
  sheets_gid="1771092530",
  sql_file="largest_image_per_page_bytes.sql"
)
}}

Most pages have at least one image over 100 KB, and the top 10% of pages have at least one image that weighs almost 1 MB or more.

#### Bits per pixel

Bytes and pixel counts are interesting on their own, but to get a sense of how compressed the web's image data is, we need to put bytes and pixels together to calculate bits per pixel. Doing this allows us to make apples-to-apples comparisons of the information density of images, even if those images have different resolutions.

In general, bitmaps on the web decode to eight bits of information per channel, per pixel. So, if we have an RGB image with no transparency, we can expect a decoded, uncompressed image to weigh in at [24 bits per pixel](https://en.wikipedia.org/wiki/Color_depth#True_color_(24-bit)). A good rule of thumb for lossless compression is that it should reduce file sizes by a 2:1 ratio (which would work out to 12 bits per pixel for our 8-bit RGB image). The rule of thumb for 1990s-era lossy compression schemes—JPEG and MP3—was a 10:1 ratio (2.4 bits per pixel). It should be noted that, depending on image content and encoding settings, these ratios vary widely, and modern JPEG encoders like <a hreflang="en" href="https://github.com/mozilla/mozjpeg">MozJPEG</a> typically outperform this 10:1 target at their default settings. To summarize:

<figure>
  <table>
    <thead>
      <tr>
        <th>Type of bitmap data</th>
        <th>Expected compression ratio</th>
        <th>Bits per pixel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Uncompressed RGB</td>
        <td>1:1</td>
        <td>24 bits/pixel</td>
      </tr>
      <tr>
        <td>Losslessly compressed RGB</td>
        <td>~2:1</td>
        <td>12 bits/pixel</td>
      </tr>
      <tr>
        <td>1990s-era lossy RGB</td>
        <td>~10:1</td>
        <td>2.4 bits/pixel</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Typical compression ratios and resulting bits/pixel numbers for bitmap RGB data.") }}</figcaption>
</figure>

So, with all of that as context, here's how the web's images stack up:

{{ figure_markup(
  image="distribution-of-image-bits-pixel.png",
  caption="Distribution of image bits/pixel.",
  description="A bar chart showing the distribution of image bits per pixel, for both desktop and mobile. The desktop bars are consistently a couple of percentage points taller than the mobile ones, but are unlabelled. At the tenth percentile, the web's images weigh in at 0.1 bits per pixel for mobile. At the 25th, 1.0, at the 50th, 2.3, at the 75th, 5.8, and finally, at the 90th percentile, mobile images weigh in at a whopping 13.3 bits per pixel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1231605169&format=interactive",
  sheets_gid="708677709",
  sql_file="bytes_and_dimensions.sql"
)
}}

At 2.3 bits per pixel, the median `<img>` on mobile almost hits that 10:1 compression ratio target on the nose. However, around that median, there is a tremendous spread. Let's break things down by format in order to learn a bit more.

#### Bits per pixel, by format

{{ figure_markup(
  image="median-bits-per-pixel-by-format.png",
  caption="Median bits per pixel by format.",
  description="A bar chart showing the median bits per pixel, by format, for a number of popular image formats. The desktop and mobile numbers are similar and only the mobile bars are labelled. GIF weighs in at 7.5 bits per pixel; PNG: 4.2; JPG: 2.1; WebP: 1.4 and AVIF is smallest at 1.0 bits per pixel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=816096019&format=interactive",
  sheets_gid="1658597028",
  sql_file="bytes_and_dimensions_by_format.sql"
)
}}

Most of these numbers are essentially unchanged from [last year](../2021/media#bits-per-pixel-by-format).

We can again see that while PNG technically employs "lossless" compression techniques (which would lead us to expect 12-16 bits per pixel, depending on whether or not we're dealing with an alpha channel), its encoders are generally lossy. They reduce color palettes and introduce dithering patterns before "losslessly" compressing images in order to boost compression ratios.

And we again see that the typical WebP is one-third lighter, per pixel, than the typical JPEG. This is about what we would expect: <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">Formal studies</a>, which, vitally, use <a hreflang="en" href="https://kornel.ski/en/faircomparison">matched qualities</a>, have estimated that WebP outperforms JPEG by about that same margin.

The only big mover, when compared to last year, is AVIF. The format dropped from 1.5 bits per pixel last year—less compressed than WebP already!—all the way down to 1.0. This is a huge reduction, but it wasn't entirely unexpected. AVIF is a very young format whose encoders have been quickly iterating, and whose adoption is significantly broadening. I expect next year the median AVIF will be even more compressed.

Without looking at the quality side of the lossy-compression/quality tradeoff, it's not possible to conclude from these results alone that AVIF offers the "best" compression of all of the web-compatible formats. But this year we can conclude that in real-world usage, it exhibits the most compression. Pair that conclusion with <a hreflang="en" href="https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4">in-the-lab results</a>, which suggest it also does a good job of preserving quality, and the picture starts looking pretty good—pun intended.

<a hreflang="en" href="https://caniuse.com/avif">AVIF's browser support</a> also took a huge leap this year. All of this is to say, if you're sending bitmap images across the web—as you may recall, [99.9% of pages do](#images)—you should at least consider sending AVIFs.

#### GIFs, animated and not

At the other end of the compression chart is our old friend GIF. It comes out looking particularly bad, but it's not all the format's fault. One of the reasons this 35-year-old format is still in common use is its ability to do animation, and we have not accounted for the number of frames when calculating the number of pixels. This raises a few interesting questions. First, how many GIFs are animated?

{{ figure_markup(
  content="29%",
  caption="Percentage of GIFs that were animated on mobile.",
  classes="big-number",
  sheets_gid="1586002077",
  sql_file="animated_gif_count.sql"
)
}}

I found this surprisingly low. Ever since <a hreflang="en" href="https://caniuse.com/?search=png">PNG achieved universal support in 2006</a>, there [hasn't been a good reason to ship a non-animated GIF](https://en.wikipedia.org/wiki/Portable_Network_Graphics#Compared_to_GIF). The word "GIF" has become synonymous with its only justifiable use case: Being a portable, universal format for short, silent, autoplaying, looping animation. One wonders whether all of these non-animated GIFs are legacy content, or whether there are a significant number of new, non-animated GIFs being created and published to the web—I hope not!

Now that we've separated out the animated GIFs from the non-animated ones, we can also ask: What are the compression characteristics of non-animated vs animated GIFs?

{{ figure_markup(
  image="gif-bits-per-pixel-animated-vs-non-animated.png",
  caption="GIF bits per pixel: animated vs. non-animated.",
  description="A bar chart showing the distribution of bits per pixel for animated vs non-animated GIFs. The animated GIF bars tower over the non-animated GIF bars. Animated GIFs weigh in at 4.5, 11.3, 30.4, 54.3, and 73.6 bits per pixel, at the 10th, 25th, 50th, 75th, and 90th percentile, respectively. The non-animated gif progression is as follows: 0.9, 1.8, 3.5, 5.7, and 8.5 bits per pixel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1578261884&format=interactive",
  sheets_gid="1549622786",
  sql_file="animated_gif_bpp.sql"
)
}}

Once we remove animated GIFs from the equation, the format looks much better. At a median of 3.5 bits per pixel, GIFs are smaller, pixel-for-pixel, than PNGs. This likely reflects the kinds of content that each format is asked to compress: GIFs, by design, can only contain 256 colors and binary transparency. PNGs can contain 16.7 million colors plus a full alpha channel.

Before we move on from GIFs, I do have one more question about them: How many frames do animated GIFs typically have?

{{ figure_markup(
  image="distribution-of-animated-gif-frame-counts.png",
  caption="Distribution of animated GIF frame counts.",
  description="Bar chart showing the distribution of animated GIF frame counts. The chart shows both desktop and mobile; the numbers are even until we get into the top percentiles, when the mobile numbers start to fall slightly behind. At the 10th percentile, both mobile and desktop saw 3 frames per GIF. At the 25th percentile they're both 8 frames. At the 50th they're both 12 frames; at the 75th it's 24 frames on desktop and 21 frames on mobile. Lastly, at the 90th percentile, the desktop crawler saw 45 frames, and the mobile crawler saw 42.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=514250122&format=interactive",
  sheets_gid="1129449602",
  sql_file="animated_gif_framecount.sql"
)
}}

A majority of animated GIFs come in at a dozen frames or less. Incidentally, the most frames we found in a GIF was 15,341. At 30 FPS, that would work out to an eight-and-a-half-minute GIF. The mind reels.

### Embedding

Now that we have a sense of how the web's image resources have been encoded, what can we say about how they are embedded on web pages?

#### Lazy-loading

{{ figure_markup(
  image="adoption-of-loading-lazy-on-img.png",
  caption="Adoption of `loading=lazy` on `<img>`.",
  description="A line chart showing the percent of pages using native lazy-loading, over time. The chart starts at 0%, in May of 2020. From there we get a three-stage curve, with accelerating usage through the summer, up to about August when eight percent of pages used lazy-load, and then decelerating (but still ever-increasing) adoption through January 2021, where the line (at about 15% usage) becomes more or less linear, until it terminates at just under 25% adoption in June of 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=539020085&format=interactive",
  sheets_gid="747829499",
  sql_file="lazy_loading_adoption_over_time.sql"
)
}}

The biggest story last year was the rapid adoption of lazy-loading. While the pace of adoption has slowed, it's still proceeding at a remarkable rate. Last June, 17% of pages were using lazy-loading. This year, we saw a 1.4x increase. Now 24% of pages are using lazy-loading.

Given the vast amount of legacy content on the web, going from zero adoption to just about one-quarter of crawled pages within two years is a remarkable feat, and shows just how much demand there was for native lazy-loading.

{{ figure_markup(
  content="9.8%",
  caption="Percentage of LCP `<img>`s that use native lazy-loading on mobile.",
  classes="big-number",
  sheets_gid="747829499",
  sql_file="lazy_loading_adoption_over_time.sql"
)
}}

And indeed, just like last year, it seems pages are using lazy-loading a bit _too_ much.

Lazy-loading LCP elements makes LCP scores much worse. It's an anti-pattern that makes pages slower. Seeing that one-in-ten LCP `<img>`s are lazy-loaded is disheartening. Seeing that this anti-pattern has gotten slightly more common since last year is even more so.

#### `alt` text

Images embedded with `<img>` elements are supposed to be contentful. That is to say: They're not just decorative, and they should contain something meaningful. According to both <a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/non-text-content">WCAG requirements</a> and <a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#alt">the HTML spec</a>, all contentful images must have alternative text, and that alternative text should usually be supplied by the `alt` attribute.

{{ figure_markup(
  content="54%",
  caption="Percentage of images that had a non-blank `alt` attribute.",
  classes="big-number",
  sheets_gid="1159402915",
  sql_file="image_alt.sql"
)
}}

This result means that almost half of all `<img>`s are obviously inaccessible. If [the in-depth analysis from this year's accessibility chapter](./accessibility#images) is any indication, a large chunk of the `<img>`s that do have non-blank `alt` attributes aren't all that accessible, either.

We can and must do better.

#### `srcset`

Prior to lazy-loading, the biggest thing to happen to `<img>`s on the web was a suite of features for "responsive images," which  allowed images to tailor themselves to fit within responsive designs. First shipped in 2014, the `srcset` attribute, `sizes` attribute, and the `<picture>` element have allowed authors to mark up adaptable resources for almost a decade now. How much and how well are we using these features?

Let's start with the `srcset` attribute, which allows authors to give the browser a menu of resources to choose from, depending on context.

{{ figure_markup(
  content="34%",
  caption="Percentage of pages using the `srcset` attribute.",
  classes="big-number",
  sheets_gid="632017314",
  sql_file="image_srcset_sizes.sql"
)
}}

One-third of pages use `srcset`, but two-thirds don't. Given the prevalence of fluid grids within responsive designs in 2022, I suspect there are a lot of pages that aren't using `srcset` that should be.

The `srcset` attribute allows authors to describe resources using one of two descriptors: `x` descriptors that specify which screen density a resource is appropriate for, and `w` descriptors, which instead give the browser the resource's width in pixels. Used in conjunction with the `sizes` attribute, `w` descriptors allow browsers to select a resource appropriate for both fluid layout widths and variable screen densities.

{{ figure_markup(
  image="srcset-descriptor-usage.png",
  caption="`srcset` descriptor usage.",
  description="A bar chart showing the percentage of `srcset`s using `x` descriptors and `w` descriptors, on both mobile and desktop. `x` descriptors are used on 15% of `srcset`s on desktop and 14% of `srcset`s on mobile. `w` descriptors are used four times more: 57% of the time on desktop, and 59% of the time on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1207511817&format=interactive",
  sheets_gid="935446394",
  sql_file="image_srcset_descriptor.sql"
)
}}

The `x` descriptor came first, and is simpler to reason about. For years it enjoyed more popularity than the more powerful `w` descriptor. It warms my heart that nearly a decade in, the world has come around to `w` descriptors.

#### `sizes`

I mentioned earlier that `w` descriptors should be used in conjunction with `sizes` attributes. How well are we using `sizes`? In two words: Not very.

The `sizes` attribute is supposed to be a hint to the browser about the eventual layout size of the image, usually relative to the viewport width. There are many variables that can affect an image's layout width. The `sizes` attribute is explicitly supposed to be a hint, and so a little inaccuracy is OK and even expected. But if the `sizes` attribute is more-than-a-little inaccurate, it can affect resource selection, causing the browser to load an image to fit the `sizes` width when the actual layout width of the image is significantly different.

So how accurate are our `sizes`?

{{ figure_markup(
  image="distribution-of-img-sizes-errors.png",
  caption="Distribution of `<img sizes>` errors.",
  description="A bar chart showing the distribution of relative error of `sizes` attributes on both desktop and mobile. At first, it's all zeros: at both the 10th and 25th percentile it's 0% on both desktop on mobile. At the 50th percentile it's 19% on desktop and 13% on mobile, at the 75th percentile it's 105% and 71% respectively, and finally, at the 90th percentile it's 305% and 151%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=173383101&format=interactive",
  sheets_gid="428964279",
  sql_file="image_srcset_sizes_per_image_accuracy_impact.sql"
)
}}

While many `sizes` attributes are entirely accurate, the median `sizes` attribute is 13% too-large on mobile and 19% too-large on desktop. That might be OK, given the hint-like nature of the feature, but as you can see, the p75 and p90 numbers aren't pretty and lead to bad outcomes.

{{ figure_markup(
  content="19%",
  caption="`sizes` attributes that were inaccurate enough to affect `srcset` selection on desktop. On mobile, it's 14%.",
  classes="big-number",
  sheets_gid="1675255539",
  sql_file="image_srcset_sizes_accuracy_pct.sql"
)
}}

On desktop, where the difference between the default `sizes` value (`100vw`) and the actual layout width of the image is likely to be larger than on mobile, one-in-five `sizes` attributes is inaccurate enough to cause browsers to pick a suboptimal resource from the `srcset`. These errors add up.

{{ figure_markup(
  image="excess-kilobytes-loaded-per-page-due-to-inaccurate-sizes.png",
  caption="Excess kilobytes loaded per page due to inaccurate `sizes`.",
  description="A bar chart showing the distribution of wasted kilobytes loaded per page due to inaccurate `sizes` attributes. It starts off with a bunch of zeros. At the tenth, 25th, and 50th percentile, both mobile and desktop weigh in at zero kilobytes. At the 75th percentile, the desktop crawler saw 83 wasted kilobytes and the mobile 27; at the 90th percentile, desktop saw 536 kilobytes and mobile 283.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=2013610794&format=interactive",
  sheets_gid="1909870095",
  sql_file="image_sizes_per_page_accuracy_impact.sql"
)
}}

We estimate that one-quarter of desktop pages are loading more than 83 KB of extra image data, based purely on bad `sizes` attributes. That is to say: A better, smaller resource is there for the picking in the `srcset`, but because the `sizes` attribute is so erroneous, the browser doesn't pick it. Additionally, 10% of desktop pages that use sizes load more than a half-megabyte of excess image data because of bad `sizes` attributes!

<p class="note">Note: Our crawlers didn't actually load the correct resources, so the numbers here are estimates, based in part on the byte sizes of the incorrect resources, which the crawlers actually did load.</p>

In the short term, individual developers can and should use <a hreflang="en" href="https://ausi.github.io/respimagelint/">RespImageLint</a> to audit and fix their badly broken `sizes` attributes and prevent this kind of waste.

In the medium term, where possible, the web platform needs to provide better tooling. For many developers, authoring—and maintaining!—accurate `sizes` attributes has proven to be too hard. A proposal that would allow <a hreflang="en" href="https://github.com/whatwg/html/pull/8008">automatic sizes for lazy-loaded images</a> is on the table. Let's hope it progresses in 2023.

The <a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes.js library</a> has already proven the appetite for this sort of solution: <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1T5oVAVmcH3sM6R-WwH4ksr2jFtPhuLXs3-iXXoABb3E/edit#gid=232511628">10% of `sizes` attributes currently have the value "auto" before JavaScript runs</a> and are later rewritten to perfectly accurate values by lazysizes.js before it lazy-loads the image. Note that, because it relies on lazy-loading, this pattern is not appropriate for LCP images or any `<img>` elements that are above the fold. For these images, the only way forward for performant responsive loading is a well-authored `sizes` attribute.

#### `<picture>`

The last responsive image feature to land in 2014 was the `<picture>` element. While `srcset` hands browsers a menu of resources to choose from, the `<picture>` element allows authors to take charge, giving browsers an explicit set of instructions about which child `<source>` element to load a resource from.

The `<picture>` element is used far less than `srcset`.

{{ figure_markup(
  content="7.7%",
  caption="Percentage of mobile pages that use the `<picture>` element.",
  classes="big-number",
  sheets_gid="1115439529",
  sql_file="picture_distribution.sql"
)
}}

This is up a couple ticks from last year, but the fact that there are almost five pages that use `srcset` for every one page that uses `<picture>` suggests that either `<picture>`'s use cases are more niche, or it's more difficult to deploy—or both.

What are people using `<picture>` for?

The `<picture>` element gives authors two ways to switch between resources. Type-switching allows authors to provide cutting-edge image formats to browsers that support them and fallback formats for everyone else. Media-switching facilitates <a hreflang="en" href="https://www.w3.org/TR/respimg-usecases/#art-direction">art direction</a>, allowing authors to switch between various `<source>`s based on media conditions.

{{ figure_markup(
  image="picture-feature-usage.png",
  caption="`<picture>` feature usage.",
  description="A bar chart showing the percent of pages which use the `media` and `type` attributes on `source` elements, in conjunction with the `picture` element. `media` is used with 41% of `picture` elements on mobile, and 43% on desktop. `type` is used with 43% of `picture` elements on both mobile and desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1200360202&format=interactive",
  sheets_gid="236851814",
  sql_file="picture_switching.sql"
)
}}

Usage is split reasonably evenly. Interestingly, type-switching has closed the gap since [last year](../2021/media#fig-23). This may be related to the increasing popularity of next-generation image formats like AVIF and WebP.

### Layout

Part of what makes responsive images difficult is that it asks us to think about how `<img>`s will be laid out, while writing HTML. Which leads us to a basic question: How are `<img>`s laid out?

We already saw [how the web's image resources size up](#image-dimensions). But before they can be shown to a user, embedded images must be placed within a layout and potentially squished or stretched to fit it.

Throughout this analysis it will be useful to keep in mind the [crawlers' viewports](./methodology#webpagetest): The desktop crawler was 1376px-wide, with a DPR of 1x; the mobile crawler was 360px-wide, with a DPR of 3x.

#### Layout widths

The simplest question here might be: How wide do the web's images end up when painted to the page?

{{ figure_markup(
  image="distribution-of-img-layout-widths.png",
  caption="Distribution of `<img>` layout widths.",
  description="A bar chart showing the distribution of `<img>` layout widths, on both desktop and mobile. At the tenth percentile, both the desktop and mobile layout width was 30 CSS px. The 25th percentile widths were 88 px for desktop and 80 px for mobile. The 50th percentile numbers were 200 px and 159 px; the 75th percentile saw 318 and 300 px, and the 90th percentile saw a comparatively large 558 px on desktop and 340 px on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1449895769&format=interactive",
  sheets_gid="1422214804",
  sql_file="image_layout_widths.sql"
)
}}

Just like the resources that they embed, most of the web's images end up pretty small within layouts. Similarly, most pages have at least one fairly large image.

{{ figure_markup(
  image="widest-img-per-page-layout-width.png",
  caption="Widest `<img>` per page (layout width).",
  description="A bar chart showing the distribution of widest `<img>` per-age layout widths, on both desktop and mobile. At the tenth percentile, the desktop crawler saw 148 CSS px and the mobile crawler saw 107 px. The 25th percentile widths were 307 px for desktop and 278 px for mobile. The 50th percentile numbers were 640 px and 330 px; the 75th percentile saw 1,176 and 360 px, and the 90th percentile saw a towering 1,905 px on desktop and 453 px on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=334270155&format=interactive",
  sheets_gid="1318107523",
  sql_file="largest_image_per_page_layout.sql"
)
}}

More than 75% of mobile pages have at least one image that takes up more than 75vw worth of viewport. From there, things more or less top out, rising slowly until a significant number (somewhere between 10-25%) of pages have an image that ends up wider than the viewport. That's likely because the author has not included a [viewport meta tag](https://developer.mozilla.org/docs/Web/HTML/Viewport_meta_tag) and the desktop-sized page is being scaled down to fit within the mobile screen.

It's interesting to contrast this with the desktop layout widths, which don't top out at all. They just keep growing. I find it surprising that more than 10% of pages on desktop included an image that was wider than the crawler's 1360px viewport, presumably triggering horizontal scrollbars.

#### Intrinsic vs extrinsic sizing

Why do the web's images end up at these layout sizes? There are many ways to scale an image with CSS. But how many images are being scaled with any CSS at all?

Images, like all ["replaced elements"](https://developer.mozilla.org/docs/Web/CSS/Replaced_element), have an [intrinsic size](https://developer.mozilla.org/docs/Glossary/Intrinsic_Size). By default—in the absence of a `srcset` controlling their density or any CSS rules controlling their layout width—images on the web display at a density of 1x. Plop a 640×480 image into an `<img src>` and, by default, that `<img>` will be laid out with a width of 640 CSS pixels.

Authors may apply extrinsic sizing to an image's height, width, or both. If an image has been extrinsically sized in one dimension (e.g., with a `width: 100%;` rule), but left to its intrinsic size in the other (`height: auto;` or no rule at all), it will scale proportionally, using its intrinsic aspect ratio.

Complicating things further, some CSS rules allow `<img>`s to appear at their intrinsic dimensions, unless they violate some constraint. For instance, an `<img>` element with a `max-width: 100%;` rule will be intrinsically sized, unless that intrinsic size is larger than the size of the `<img>` element's container, in which case it will be extrinsically scaled down to fit.

With all of that explanation out of the way, here's how the web's `<img>` elements are sized for layout:

{{ figure_markup(
  image="intrinsic-and-extrinsic-image-sizing.png",
  caption="Intrinsic and extrinsic image sizing.",
  description="A stacked bar chart showing the percentage of images whose width and height are determined based on extrinsic vs extrinsic sizing. There is a (for now) mysterious third category: both. The distributions between intrinsic, extrinsic, and both are quite different for height and width. For height, 59% of images are intrinsically sized, 31% extrinsic and the remaining 10% fall under both. For width, 9% of images are intrinsically sized, and 67% are extrinsic, the remaining 24% are both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1534436519&format=interactive",
  sheets_gid="1153572147",
  sql_file="image_sizing_extrinsic_intrinsic.sql"
)
}}

The majority of images have extrinsic widths; the majority of images have intrinsic heights. The "both" category for width—representing images with either a `max-width` or `min-width` sizing constraint—is also fairly popular. Leaving images to their intrinsic widths is far less popular—and slightly less popular than it was [last year](../2021/media#intrinsic-vs-extrinsic-sizing).

#### `height`, `width`, and Cumulative Layout Shifts

Any `<img>` whose layout size is dependent on its intrinsic width risks triggering a <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a>. In essence, such images risk being laid out twice: Once when the page's DOM and CSS have been processed, and then a second time when they finally finish loading and their intrinsic dimensions are known.

As we've just seen, extrinsically scaling images to fit a certain width while leaving the height (and aspect ratio) intrinsic is very common. To fight the resulting plague of layout shifts, a couple of years ago browsers decided to <a hreflang="en" href="https://developer.mozilla.org/docs/Web/Media/images/aspect_ratio_mapping#a_new_way_of_sizing_images_before_loading_completes">change the way that the `height` and `width` attributes on `<img>` work</a>. These days, consistently setting the `height` and `width` attributes to reflect the aspect ratio of the resource is a universally recommended best practice, which allows authors to tell the browser the intrinsic dimensions of an image resource before it loads.

{{ figure_markup(
  content="28%",
  caption="Percentage of `<img>` elements on mobile that have both `height` and `width` attributes set.",
  classes="big-number",
  sheets_gid="928689051",
  sql_file="img_with_dimensions.sql"
)
}}

Unfortunately, we have a long way to go before we get to universal adoption.

### Delivery

Finally, let's take a look at how images are delivered over the network.

#### Cross-domain image hosts

How many images are being delivered from a different domain than the document they're embedded on? A majority of them, including [3.6 percentage points more than last year](../2021/media#cross-origin-image-hosts).

{{ figure_markup(
  image="image-hosts-cross-vs-same-domain.png",
  caption="Image hosts: cross vs same domain.",
  description="A bar chart showing how many images were served by the same domain as the root HTML page, vs a different (cross) domain. On mobile, 55% of images were cross-domain and 45% were same-domain. On desktop, 53% were cross-domain and 47% were same-domain.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1184925121&format=interactive",
  sheets_gid="431284065",
  sql_file="img_xdomain.sql"
)
}}

The fact that a growing majority of images are being delivered across domains underscores <a hreflang="en" href="https://css-tricks.com/images-are-hard/">how hard images are to get right</a>, and the benefits of enlisting an <a hreflang="en" href="https://web.dev/image-cdns/">image CDN</a> to handle your media for you.

And now let's turn our attention to `<img>`'s younger and more dynamic sibling: `<video>`.

## Video

The `<video>` element shipped in 2010, and has been the best and—since the demise of plugins like Flash and Silverlight—only way to embed video content on websites.

Over the last few years, I have had the sense that web content is shifting. Whereas still images (Flickr, Instagram) once ruled, I'm increasingly seeing moving ones (TikTok) dominate. Is this sense borne out in the Web Almanac's dataset? How are we using `<video>` on the web?

### Video adoption

Usage of the `<video>` element continues to rise:

{{ figure_markup(
  image="adoption-of-video-over-time.png",
  caption="Adoption of `<video>` over time.",
  description="A line chart, showing the percentage of pages containing `<video>` elements over time. The mobile numbers are regularly a percentage point under the desktop numbers. In the fall of 2010, the lines start out at just under 4% on mobile and just under 5% on desktop, in the fall of 2020. They rise, pretty much linearly, until the end of the chart in June 2022, where mobile is at 5% and desktop is at just over 6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=642519393&format=interactive",
  sheets_gid="331851685",
  sql_file="video_adoption.sql"
)
}}

On mobile, `<video>` usage has risen from 4.3% of pages in June 2021 to 5% of pages in June 2022. One in 20 pages now include a `<video>` element, representing an increase of 18% year-over-year. I don't expect the web to contain as many `<video>`s as `<img>`s anytime soon, but there are an increasing number of `<video>`s every year!

### Video durations

How long are those videos? Not very!

{{ figure_markup(
  image="video-durations.png",
  caption="Video durations.",
  description="A bar chart showing how long videos are, on desktop and mobile. Only the mobile bars are labelled; the desktop bars aren't too different. On mobile, 23% of videos are between 0-10 seconds, 36% are between 10-30 seconds, 19% are between 30-60 seconds, 12% are between 60-120 seconds, and 10% are more than 120 seconds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1553889662&format=interactive",
  sheets_gid="1432010937",
  sql_file="video_durations.sql"
)
}}

Nine out of ten videos are less than two minutes long. And more than half are under 30 seconds. Almost a quarter of videos are under 10 seconds. Perhaps these are GIFs in `<video>` clothing?

### Format adoption

What formats are sites delivering in 2022? MP4, with its <a hreflang="en" href="https://caniuse.com/mpeg4">universal support story</a>, is king:

{{ figure_markup(
  image="top-extensions-of-files-with-a-video-mime-type.png",
  caption="Top extensions of files with a video MIME type.",
  description="A bar chart showing the extensions of video files delivered on desktop and mobile. Desktop and mobile numbers are mostly similar, only the mobile bars are labelled. The MP4 extension accounted for 52% of video files; blank extensions accounted for 26% of video files (and were uniquely much higher on mobile); files with a TS extension accounted for 12% of video files; M4S, 6%; WebM, 2%; lastly, MOV, 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=153073113&format=interactive",
  sheets_gid="216837908",
  sql_file="video_ext.sql"
)
}}

But MP4's numbers are a couple ticks down from [last year](../2021/media#fig-29), and we continue to see files with blank extensions, `.ts` files, and `.m4s` files gaining ground. These files are delivered when a `<video>` employs adaptive bitrate streaming using either [HLS](https://en.wikipedia.org/wiki/HTTP_Live_Streaming) or [MPEG-DASH](https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP).

It's encouraging to see responsive video delivery using adaptive streaming on the rise. At the same time, we look forward to the web platform offering <a hreflang="en" href="https://github.com/whatwg/html/issues/6363">a simple, declarative solution to adaptive videos</a> that doesn't rely on JavaScript.

### Embedding

The `<video>` element offers a number of attributes that allow authors to control how the video will be loaded and presented on the page. Here they are, ranked by usage:

{{ figure_markup(
  image="video-attribute-usage.png",
  caption="`<video>` attribute usage.",
  description="A bar chart showing the number of times various attributes on the HTML video element were found on both desktop and mobile. Generally, the mobile and desktop bars are similar; only the mobile bars are labelled. autoplay accounts for 20%; preload, 16%; width, 12%; playsinline, 11%; controls, 9%; src, 8%; muted, 8%; loop, 7%; crossorigin, 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1835151388&format=interactive",
  sheets_gid="1517058887",
  sql_file="video_attribute_names.sql"
)
}}

There are a number of things to unpack here.

First, `autoplay` overtook `preload` to become the most popular attribute this year. We also see `playsinline`, `muted`, and `loop` increasing in popularity. Perhaps an increasing number of people are <a hreflang="en" href="https://web.dev/replace-gifs-with-videos/">using the `<video>` element to replace animated GIFs</a>? If so, good!

The fact that only 12% of `<video>`s have `width` attributes and just 0.4% (!) have `height` attributes means that most `<video>` elements are susceptible to the same kinds of <a hreflang="en" href="https://web.dev/articles/cls">CLS</a> problems we saw with `<img>` elements which lack these attributes. Help the browser help you and add these attributes!

Additionally, the fact that fewer than one-in-ten `<video>` elements has a `controls` attribute suggests a significant number of people are using players that provide their own user interface for interacting with the video.

Usage of `preload` deserves some more investigation.

#### `preload`

The `preload` attribute has seen declining usage over the past couple of years.

{{ figure_markup(
  image="video-preload-attribute-value-usage.png",
  caption="`<video preload>` attribute value usage.",
  description="A bar chart showing the prevalence of the various preload attribute values, on desktop and mobile, in 2020, 2021, and 2022. Only the 2022 bars are labelled. Preload was not used on 59% of video elements in 2022. This percentage is slightly larger than 2021, and significantly larger than 2020, when the bar was around 53%. The none value was used on 15% of video elements in 2022. This number has decreased for two years in a row; it was almost 20% in 2020. Auto was used on 14% of video elements in 2022; this decreased slightly in 2021, but increased again by about the same amount in 2022. The metadata value was used on 9% of video elements in 2022, this has decreased every year from closer to 12% in 2020. Empty was used on 2% of video elements, this appears unchanged from the previous two years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1167702490&format=interactive",
  sheets_gid="192355478",
  sql_file="video_preload_values.sql"
)
}}

Why? I like to think it is authors getting out of the browser's way.

Different browsers do different things when it comes to deciding when to load video data. The `preload` attribute is a way for authors to step in and have more control over that process. That could include explicitly asking the browser not to preload anything with `none`; asking the browser to preload just the `metadata`; or asking the browser to preload, using either the `auto` or empty values. It's interesting, and perhaps heartening, to see authors exert less control over video loading during the past three years. Browsers know the most about their users' contexts; not including the `preload` attribute at all lets them do what they think is best.

#### `src` and `<source>`

The `src` attribute is only present on 8-9% of `<video>` elements. Many of the rest use multiple `<source>` children, allowing authors to instead supply multiple alternate video resources in alternate formats.

{{ figure_markup(
  image="number-of-sources-per-video.png",
  caption="Number of `<source>`s per `<video>`.",
  description="A bar chart showing the frequency of various numbers of `source` elements per `video` element. The most common number of `source` elements per `video` is one: 51.25% of mobile `video`s contain this many sources. The second most common number of `source` children is 0: 38.49% of mobile `video`s have no `source` children. 7.63% contain 2, 2.44% contain 3, and 0.18% of `video` elements on both desktop and mobile contain 4 elements. 0.02% of elements contain 5 children.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=905380642&format=interactive",
  sheets_gid="1523141644",
  sql_file="video_number_of_sources.sql"
)
}}

How many `<source>` children do `<video>` elements have? Most have just one, and very few use multiple.

## Conclusion

So there you have it, a snapshot of the state of media on the web in 2022. We've seen just how pervasive images and – increasingly – videos are on the web, and have gained some insight into how the web's images and videos are encoded and embedded. The most exciting developments this year are the accelerating adoption of AVIF and the ever-increasing adoption of both lazy-loading and adaptive bitrate streaming.

There were, however, some frustrating aspects, including the almost complete lack of wide-gamut color spaces; the undying zombie format that is GIF (in both its animated and, more surprisingly, non-animated forms); and the way that both the `sizes` attribute and lazy-loading – two features designed for performance – are (through improper use) hurting performance on a significant number of pages.

Here's to more effective visual communication on the web in 2023!
