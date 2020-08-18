---
part_number: I
chapter_number: 4
title: Media
description: Media chapter of the 2019 Web Almanac covering image file sizes and formats, responsive images, client hints, lazy loading, accessibility and video.
authors: [colinbendell, dougsillars]
reviewers: [ahmadawais, eeeps]
translators: []
discuss: 1759
results: https://docs.google.com/spreadsheets/d/1hj9bY6JJZfV9yrXHsoCRYuG8t8bR-CHuuD98zXV7BBQ/
queries: 04_Media
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-08-12T00:00:00.000Z
---

## Introduction
Images, animations, and videos are an important part of the web experience. They are important for many reasons: they help tell stories, engage audiences, and provide artistic expression in ways that often cannot be easily produced with other web technologies. The importance of these media resources can be demonstrated in two ways: by the sheer volume of bytes required to download for a page, and also the volume of pixels painted with media. 

From a pure bytes perspective, HTTP Archive has [historically reported](https://legacy.httparchive.org/interesting.php#bytesperpage) an average of two-thirds of resource bytes associated from media. From a distribution perspective, we can see that virtually every web page depends on images and videos. Even at the tenth percentile, we see that 44% of the bytes are from media and can rise to 91% of the total bytes at the 90th percentile of pages. 

<figure>
  <a href="/static/images/2019/media/fig1_bytes_images_and_video_versus_other.png">
    <img src="/static/images/2019/media/fig1_bytes_images_and_video_versus_other.png" alt="Figure 1. Web page bytes: image and video versus other." aria-labelledby="fig1-caption" aria-describedby="fig1-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1189524305&format=interactive">
  </a>
  <div id="fig1-description" class="visually-hidden">Bar chart showing in the p10 percentile 44.1% of page bytes are media, in the p25 percentile 52.7% is media, in the p50 percentile 67.0% is media, in the p75 percentile 81.7% is media, and in the p90 percentile 91.2% is media.</div>
  <figcaption id="fig1-caption">Figure 1. Web page bytes: image and video versus other.</figcaption>
</figure>

While media are critical for the visual experience, the impact of this high volume of bytes has two side effects.

First, the network overhead required to download these bytes can be large and in cellular or slow network environments (like coffee shops or tethering when in an Uber) can dramatically slow down the page [performance](./performance). Images are a lower priority request by the browser but can easily block CSS and JavaScript in the download. This by itself can delay the page rendering. Yet at other times, the image content is the visual cue to the user that the page is ready. Slow transfers of visual content, therefore, can give the perception of a slow web page.

The second impact is on the financial cost to the user. This is often an ignored aspect since it is not a burden on the website owner but a burden to the end-user. Anecdotally, it has been shared that some markets, [like Japan](https://twitter.com/yoavweiss/status/1195036487538003968?s=20), see a drop in purchases by students near the end of the month when data caps are reached, and users cannot see the visual content. 

Further, the financial cost of visiting these websites in different parts of the world is disproportionate. At the median and 90th percentile, the volume of image bytes is 1 MB and 1.9 MB respectively. Using [WhatDoesMySiteCost.com](https://whatdoesmysitecost.com/#gniCost) we can see that the gross national income (GNI) per capita cost to a user in Madagascar a single web page load at the 90th percentile would cost 2.6% of the daily gross income. By contrast, in Germany this would be 0.3% of the daily gross income. 

<figure>
  <a href="/static/images/2019/media/fig2_total_image_bytes_per_web_page_mobile.png">
    <img src="/static/images/2019/media/fig2_total_image_bytes_per_web_page_mobile.png" alt="Figure 2. Total image bytes per web page (mobile)." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2025280105&format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">The median web page on mobile requires 1 MB of images and 4.9 MB at the 90th percentile.</div>
  <figcaption id="fig2-caption">Figure 2. Total image bytes per web page (mobile).</figcaption>
</figure>

Looking at bytes per page results in just looking at the costs—to page performance and the user—but it overlooks the benefits. These bytes are important to render pixels on the screen. As such, we can see the importance of the images and video resources by also looking at the number of media pixels used per page.

There are three metrics to consider when looking at pixel volume: CSS pixels, natural pixels, and screen pixels:

* _CSS pixel volume_ is from the CSS perspective of layout. This measure focuses on the bounding boxes for which an image or video could be stretched or squeezed into. It also does not take into the actual file pixels nor the screen display pixels
* _Natural pixels_ refer to the logical pixels represented in a file. If you were to load this image in GIMP or Photoshop, the pixel file dimensions would be the natural pixels.
* _Screen pixels_ refer to the physical electronics on the display. Prior to mobile phones and modern high-resolution displays, there was a 1:1 relationship between CSS pixels and LED points on a screen. However, because mobile devices are held closer to the eye, and laptop screens are closer than the old mainframe terminals, modern screens have a higher ratio of physical pixels to traditional CSS pixels. This ratio is referred to as Device-Pixel-Ratio or colloquially referred to as Retina™ displays.
 
 <figure>
  <a href="/static/images/2019/media/fig3_image_pixel_per_page_mobile_css_v_actual.png">
    <img src="/static/images/2019/media/fig3_image_pixel_per_page_mobile_css_v_actual.png" alt="Figure 3. Image pixels per page (mobile): CSS versus actual." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2027393897&format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">A comparison of the CSS pixels allocated to image content compared to the actual image pixels for mobile, showing p10 (0.07 MP actual, 0.04 MP CSS), p25 (0.38 MP actual, 0.18 MP CSS), p50 (1.6 MP actual, 0.65 MP CSS), p75 (5.1 MP actual, 1.8 MP CSS), and p90 (12 MP actual, 4.6 MP CSS)</div>
  <figcaption id="fig3-caption">Figure 3. Image pixels per page (mobile): CSS versus actual.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/media/fig4_image_pixel_per_page_desktop_css_v_actual.png">
    <img src="/static/images/2019/media/fig4_image_pixel_per_page_desktop_css_v_actual.png" alt="Figure 4. Image pixels per page (desktop): CSS versus actual." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1364487787&format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">A comparison of the CSS pixels allocated to image content compared to the actual image pixels for desktop, showing p10 (0.09 MP actual, 0.05 MP CSS), p25 (0.52 MP actual, 0.29 MP CSS), p50 (2.1 MP actual, 1.1 MP CSS), p75 (6.0 MP actual, 2.8 MP CSS), and p90 (14 MP actual, 6.3 MP CSS)</div>
  <figcaption id="fig4-caption">Figure 4. Image pixels per page (desktop): CSS versus actual.</figcaption>
</figure>

Looking at the CSS pixel and the natural pixel volume we can see that the median website has a layout that displays one megapixel (MP) of media content. At the 90th percentile, the CSS layout pixel volume grows to 4.6 MP and 6.3 MP mobile and desktop respectively. This is interesting not only because the responsive layout is likely different, but also because the form factor is different. In short, the mobile layout has less space allocated for media compared to the desktop.

In contrast, the natural, or file, pixel volume is between 2 and 2.6 times the layout volume. The median desktop web page sends 2.1MP of pixel content that is displayed in 1.1 MP of layout space. At the 90th percentile for mobile we see 12 MP squeezed into 4.6 MP.

Of course, the form factor for a mobile device is different than a desktop. A mobile device is smaller and usually held in portrait mode while the desktop is larger and used predominantly in landscape mode. As mentioned earlier, a mobile device also typically has a higher device pixel ratio (DPR) because it is held much closer to the eye, requiring more pixels per inch compared to what you would need on a billboard in Times Square. These differences force layout changes and users on mobile more commonly scroll through a site to consume the entirety of content.

Megapixels are a challenging metric because it is a largely abstract metric. A useful way to express this volume of pixels being used on a web page is to represent it as a ratio relative to the display size. 

For the mobile device used in the web page crawl, we have a display of `512 x 360` which is 0.18 MP of CSS content. (Not to be confused with the physical screen which is `3x` or 3^2 more pixels, which is 1.7MP). Dividing this viewer pixel volume by the number of CSS pixels allocated to images we get a relative pixel volume.

If we had one image that filled the entire screen perfectly, this would be a 1x pixel fill rate. Of course, rarely does a website fill the entire canvas with a single image. Media content tends to be mixed in with the design and other content. A value greater than 1x implies that the layout requires the user to scroll to see the additional image content. 

<p class="note">Note: this is only looking at the CSS layout for both the DPR and the volume of layout content. It is not evaluating the effectiveness of the responsive images or the effectiveness of providing high DPR content.</p> 

<figure>
  <a href="/static/images/2019/media/fig5_image_pixel_volume_v_css_pixels.png">
    <img src="/static/images/2019/media/fig5_image_pixel_volume_v_css_pixels.png" alt="Figure 5. Image pixel volume versus screen size (CSS pixels)." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1889020047&format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">A comparison of the pixel volume required per page relative to the actual screen size CSS pixels, showing p10 (20% mobile, 2% desktop), p25 (97% mobile, 13% desktop), p50 (354% mobile, 46% desktop), p75 (1003% mobile, 123% desktop), and p90 (2477% mobile, 273% desktop).</div>
  <figcaption id="fig5-caption">Figure 5. Image pixel volume versus screen size (CSS pixels).</figcaption>
</figure>

For the median web page on desktop, only 46% of the display would have layout containing images and video. In contrast, on mobile, the volume of media pixels fills 3.5 times the actual viewport size. The layout has more content than can be filled in a single screen, requiring the user to scroll. At a minimum, there is 3.5 scrolling pages of content per site (assuming 100% saturation). At the 90th percentile for mobile, this grows substantially to 25x the viewport size!

Media resources are critical for the user experience.

## Images 

Much has already been written on the subject of managing and optimizing images to help reduce the bytes and optimize the user experience. It is an important and critical topic for many because it is the creative media that define a brand experience. Therefore, optimizing image and video content is a balancing act between applying best practices that can help reduce the bytes transferred over the network while preserving the fidelity of the intended experience. 

While the strategies that are utilized for images, videos, and animations are—in broad strokes—similar, the specific approaches can be very different. In general, these strategies boil down to:

* **File formats** - utilizing the optimal file format 
* **Responsive** - applying responsive images techniques to transfer only the pixels that will be shown on screen
* **Lazy loading** - to transfer content only when a human will see it
* **Accessibility** - ensuring a consistent experience for all humans

<p class="note">A word of caution when interpreting these results. The web pages crawled for the Web Almanac were crawled on a Chrome browser. This implies that any content negotiation that might better apply for Safari or Firefox might not be represented in this dataset. For example, the use of file formats like JPEG2000, JPEG-XR, HEVC and HEIC are absent because these are not supported natively by Chrome. This does not mean that the web does not contain these other formats or experiences. Likewise, Chrome has native support for lazy loading (since v76) which is not yet available in other browsers. Read more about these caveats in our <a href="./methodology">Methodology</a>.</p>

It is rare to find a web page that does not utilize images. Over the years, many different file formats have emerged to help present content on the web, each addressing a different problem. Predominantly, there are 4 main universal image formats: JPEG, PNG, GIF, and SVG. In addition, Chrome has enhanced the media pipeline and added support for a fifth image format: WebP. Other browsers have likewise added support for JPEG2000 (Safari), JPEG-XL (IE and Edge) and HEIC (WebView only in Safari).

Each format has its own merits and has ideal uses for the web. A very simplified summary would break down as:

<figure>
<table>
<thead>
<tr>
<th>Format</th>
<th class="width-45">Highlights</th>
<th class="width-45">Drawbacks</th>
</tr>
</thead>
<tbody>
<tr>
<td>JPEG</td>
<td><ul><li>Ubiquitously supported</li><li>Ideal for photographic content</li></ul></td>
<td><ul><li>There is always quality loss</li><li>Most decoders cannot handle high bit depth photographs from modern cameras (> 8 bits per channel)</li><li>No support for transparency</li></ul></td>
</tr>
<tr>
<td>PNG</td>
<td><ul><li>Like JPEG and GIF, shares wide support</li><li>It is lossless</li><li>Supports transparency, animation, and high bit depth</li></ul></td>
<td><ul><li>Much bigger files compared to JPEG</li><li>Not ideal for photographic content</li></ul></td>
</tr>
<tr>
<td>GIF</td>
<td><ul><li>The predecessor to PNG, is most known for animations</li><li>Lossless</li></ul></td>
<td><ul><li>Because of the limitation of 256 colors, there is always visual loss from conversion</li><li>Very large files for animations</li></ul></td>
</tr>
<tr>
<td>SVG</td>
<td><ul><li>A vector based format that can be resized without increasing file size</li><li>It is based on math rather than pixels and creates smooth lines</li></ul></td>
<td><ul><li>Not useful for photographic or other raster content</li></ul></td>
</tr>
<tr>
<td>WebP</td>
<td><ul><li>A newer file format that can produce lossless images like PNG and lossy images like JPEG</li><li>It <a href="https://developers.google.com/speed/webp/faq">boasts a 30% average file reduction compared</a> to JPEG, while other data suggests that median file reduction is <a href="https://cloudinary.com/state-of-visual-media-report/">between 10-28% based on pixel volume</a>.</li></ul></td>
<td><ul><li>Unlike JPEG, it is limited to chroma-subsampling which will make some images appear blurry.</li><li>Not universally supported. Only Chrome, Firefox and Android ecosystems.</li><li>Fragmented feature support depending on browser versions</li></ul></td>
 </tr>
 </tbody>
 </table>

 <figcaption>Figure 6. Explanation of the mainstream file formats.</figcaption>
</figure>
  
### Image formats

In aggregate, across all page, we indeed see the prevalence of these formats. JPEG, one of the oldest formats on the web, is by far the most commonly used image formats at 60% of the image requests and 65% of all image bytes. Interestingly, PNG is the second most commonly used image format 28% of image requests and bytes. The ubiquity of support along with the precision of color and creative content are likely explanations for its wide use. In contrast SVG, GIF, and WebP share nearly the same usage at 4%.

<figure>
  <a href="/static/images/2019/media/fig7_image_format_usage.png">
    <img alt="Most frequent Image types used on web pages" aria-labelledby="fig7-caption" aria-describedby="fig7-description" src="/static/images/2019/media/fig7_image_format_usage.png" width="600" height="376">
  </a>
  <div id="fig7-description" class="visually-hidden">A tree map showing that JPEGs are used 60.27% of the time, PNGs 28.2%, WebP 4.2%, GIF 3.67%, and SVG 3.63%.</div>
  <figcaption id="fig7-caption">Figure 7. Image format usage.</figcaption>
</figure>

Of course, web pages are not uniform in their use of image content. Some depend on images more than others. Look no further than the home page of `google.com` and you will see very little imagery compared to a typical news website. Indeed, the median website has 13 images, 61 images at the 90th percentile, and a whopping 229 images at the 99th percentile.

<figure>
  <a href="/static/images/2019/media/fig8_image_format_usage_per_page.png">
    <img src="/static/images/2019/media/fig8_image_format_usage_per_page.png" alt="Figure 8. Image format usage per page." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=294858455&format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">A bar chart showing in p10 percentile no image formats are used at all, in the p25 percentile three JPGs and four PNGs are used, in the p50 percentile nine JPGs, four PNGs, and one GIF are used, in the p75 percentile 39 JPEGs, 18 PNGs, two SVGs, and two GIFs are used and in the p99 percentile, 119 JPGs, 49 PNGs, 28 WebPs, 19 SVGs and 14 GIFs are used.</div>
  <figcaption id="fig8-caption">Figure 8. Image format usage per page.</figcaption>
</figure>

While the median page has nine JPEGs and four PNGs, and only in the top 25% pages GIFs were used, this doesn't report the adoption rate. The use and frequency of each format per page doesn't provide insight into the adoption of the more modern formats. Specifically, what percent of pages include at least one image in each format?

<figure>
  <a href="/static/images/2019/media/fig9_pages_using_at_least_1_image.png">
    <img src="/static/images/2019/media/fig9_pages_using_at_least_1_image.png" alt="Figure 9. % of pages using at least 1 image." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1024386063&format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">A bar chart showing JPEGs are used on 90% of pages, PNGs on 89%, WebP on 9%, GIF on 37%, and SVG on 22%.</div>
  <figcaption id="fig9-caption">Figure 9. Percent of pages using at least one image.</figcaption>
</figure>

This helps explain why—even at the 90th percentile of pages—the frequency of WebP is still zero; only 9% of web pages have even one resource. There are many reasons that WebP might not be the right choice for an image, but adoption of media best practices, like adoption of WebP itself, still remain nascent. 

### Image file sizes

There are two ways to look at image file sizes: absolute bytes per resource and bytes-per-pixel.
 
<figure>
  <a href="/static/images/2019/media/fig10_image_format_size.png">
    <img alt="A comparison of image formats by file size" aria-labelledby="fig10-caption" aria-describedby="fig10-description" src="/static/images/2019/media/fig10_image_format_size.png" width="600" height="371">
  </a>
  <div id="fig10-description" class="visually-hidden">A chart showing in p10 percentile 4 KB of JPEGs, 2 KB of PNG and 2 KB of GIFs are used, in the p25 percentile 9 KB JPGs, 4 KB of PNGs, 7 KB of WebP, and 3 KB of GIFs are used, in the p50 percentile 24 KB of JPGs, 11 KB of PNGs, 17 KB of WebP, 6 KB of GIFs, and 1 KB of SVGs are used, in the p75 percentile 68 KB of JPEGs, 43 KB of PNGs, 41 KB of WebPs, 17 KB of GIFs and 2 KB of SVGs are used and in the p90 percentile, 116 KB of JPGs, 152 KB of PNGs, 90 KB of WebPs, 87 KB of GIFs, and 8 KB of SVGs are used.</div>
  <figcaption id="fig10-caption">Figure 10. File size (KB) by image format.</figcaption>
</figure>

From this we can start to get a sense of how large or small a typical resource is on the web. However, this doesn't give us a sense of the volume of pixels represented on screen for these file distributions. To do this we can divide each resource bytes by the natural pixel volume of the image. A lower bytes-per-pixel indicates a more efficient transmission of visual content.

 <figure>
  <a href="/static/images/2019/media/fig11_bytes_per_pixel.png">
    <img src="/static/images/2019/media/fig11_bytes_per_pixel.png" alt="Figure 11. Bytes per pixel." aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1379541850&format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">A candlestick chart showing in p10 percentile we have 0.1175 bytes-per-pixel for JPEG, 0.1197 for PNG, 0.1702 for GIF, 0.0586 for WebP, and 0.0293 for SVG. In the p25 percentile we have 0.1848 bytes-per-pixel for JPEGs, 0.2874 for PNG, 0.3641 for GIF, 0.1025 for WebP, and 0.174 for SVG. In the p50 percentile we have 0.2997 bytes-per-pixel for JPEGs, 0.6918 for PNG, 0.7967 for GIF, 0.183 for WebP, and 0.6766 for SVG. In the p75 percentile we have 0.5456 bytes-per-pixel for JPEGs, 1.4548 for PNG, 2.515 for GIF, 0.3272 for WebP, and 1.9261 for SVG. In the p90 percentile we have 0.9822 bytes-per-pixel for JPEGs, 2.5026 for PNG, 8.5151 for GIF, 0.6474 for WebP, and 4.1075 for SVG</div>
  <figcaption id="fig11-caption">Figure 11. Bytes per pixel.</figcaption>
</figure>

While previously it appeared that GIF files were smaller than JPEG, we can now clearly see that the cause of the larger JPEG resources is due to the pixel volume. It is probably not a surprise that GIF shows a very low pixel density compared to the other formats. Additionally, while PNG can handle high bit depth and doesn't suffer from chroma subsampling blurriness, it is about twice the size of JPG or WebP for the same pixel volume.

Of note, the pixel volume used for SVG is the size of the DOM element on screen (in CSS pixels). While considerably smaller for file sizes, this hints that SVGs are generally used in smaller portions of the layout. This is why the bytes-per-pixel appears worse than PNG. 

Again, it is worth emphasizing, this comparison of pixel density is not comparing equivalent images. Rather it is reporting typical user experience. As we will discuss next, even in each of these formats there are techniques that can be used to further optimize and reduce the bytes-per-pixel. 

### Image format optimization

Selecting the best format for an experience is an art of balancing capabilities of the format and reducing the total bytes. For web pages one goal is to help improve web performance through optimizing images. Yet within each format there are additional features that can help reduce bytes. 

Some features can impact the total experience. For example, JPEG and WebP can utilize _quantization_ (commonly referred to as _quality levels_) and _chroma subsampling_, which can reduce the bits stored in the image without impacting the visual experience. Like MP3s for music, this technique depends on a bug in the human eye and allows for the same experience despite the loss of color data. However, not all images are good candidates for these techniques since this can create blocky or blurry images and may distort colors or make text overlays become unreadable. 

Other format features simply organize the content and sometimes require contextual knowledge. For example, applying progressive encoding of a JPEG reorganizes the pixels into scan layers that allows the browser to complete layout sooner and coincidently reduces pixel volume.

One [Lighthouse](./methodology#lighthouse) test is an A/B comparing baseline with a progressively encoded JPEG. This provides a smell to indicate whether the images overall can be further optimized with lossless techniques and potentially with lossy techniques like using different quality levels. 

 <figure>
  <a href="/static/images/2019/media/fig12_percentage_optimized_images.png">
    <img src="/static/images/2019/media/fig12_percentage_optimized_images.png" alt="Figure 12. Percent 'optimized' images." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1569150767">
  </a>
  <div id="fig12-description" class="visually-hidden">Bar chart showing in the p10 percentile 100% of images are optimized, same in p25 percentile, in the p50 percentile 98% of images are optimized (2% not), in the p75 percentile 83% of images are optimized (17% not), and in the p90 percentile 59% of images are optimized and 41% are not.</div>
  <figcaption id="fig12-caption">Figure 12. Percent "optimized" images.</figcaption>
</figure>

The savings in this AB Lighthouse test is not just about potential byte savings, which can accrue to several MBs at the p95, it also demonstrates the page performance improvement. 

 <figure>
  <a href="/static/images/2019/media/fig13_project_perf_improvements_image_optimization.png">
    <img src="/static/images/2019/media/fig13_project_perf_improvements_image_optimization.png" alt="Figure 13. Projected page performance improvements from image optimization from Lighthouse." aria-labelledby="fig12-caption" aria-describedby="fig13-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=167590779">
  </a>
  <div id="fig13-description" class="visually-hidden">Bar chart showing in the p10 percentile 0 ms could be sized, same in p25 percentile, in the p50 percentile 150 ms could be saved, in the p75 percentile 1,460 ms could be saved and in the p90 percentile 5,720 ms could be saved.</div>
  <figcaption id="fig13-caption">Figure 13. Projected page performance improvements from image optimization from Lighthouse.</figcaption>
</figure>

### Responsive images

Another axis for improving page performance is to apply responsive images. This technique focuses on reducing image bytes by reducing the extra pixels that are not shown on the display because of image shrinking. At the beginning of this chapter, you saw that the median web page on desktop used one MP of image placeholders yet transferred 2.1 MP of actual pixel volume. Since this was a 1x DPR test, 1.1 MP of pixels were transferred over the network, but not displayed. To reduce this overhead, we can use one of two (possibly three) techniques:

* **HTML markup** - using a combination of the `<picture>` and `<source>` elements along with the `srcset` and `sizes` attributes allows the browser to select the best image based on the dimensions of the viewport and the density of the display. 
* **Client Hints** - this moves the selection of possible resized images to HTTP content negotiation.
* **BONUS**: JavaScript libraries to delay image loading until the JavaScript can execute and inspect the Browser DOM and inject the correct image based on the container.

### Use of HTML markup

The most common method to implement responsive images is to build a list of alternative images using either `<img srcset>` or `<source srcset>`. If the `srcset` is based on DPR, the browser can select the correct image from the list without additional information. However, most implementations also use `<img sizes>` to help instruct the browser how to perform the necessary layout calculation to select the correct image in the `srcset` based on pixel dimensions.

 <figure>
  <a href="/static/images/2019/media/fig14_html_usage_of_responsive_images.png">
    <img src="/static/images/2019/media/fig14_html_usage_of_responsive_images.png" alt="Figure 14. Percent of pages using responsive images with HTML." aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=582530039&format=interactive">
  </a>
  <div id="fig14-description" class="visually-hidden">A bar chart showing 18% of images uses 'sizes', 21% use 'srcset', and 2% use 'picture'.</div>
  <figcaption id="fig14-caption">Figure 14. Percent of pages using responsive images with HTML.</figcaption>
</figure>

The notably lower use of `<picture>` is not surprising given that it is used most often for advanced responsive web design (RWD) layouts like [art direction](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images#Art_direction).

### Use of sizes

The utility of `srcset` is usually dependent on the precision of the `sizes` media query. Without `sizes` the browser will assume the `<img>` tag will fill the entire viewport instead of smaller component. Interestingly, there are five common patterns that web developers have adopted for `<img sizes>`:

* **`<img sizes="100vw">`** - this indicates that the image will fill the width of the viewport (also the default).
* **`<img sizes="200px">`** - this is helpful for browsers selecting based on DPR.
* **`<img sizes="(max-width: 300px) 100vw, 300px">`** - this is the second most popular design pattern. It is the one auto generated by WordPress and likely a few other platforms. It appears auto generated based on the original image size (in this case 300px).
* **`<img sizes="(max-width: 767px) 89vw, (max-width: 1000px) 54vw, ...">`** - this pattern is the custom built design pattern that is aligned with the CSS responsive layout. Each breakpoint has a different calculation for sizes to use.

<figure markdown>
`<img sizes>` | Frequency (millions) | %
-- | -- | --
(max-width: 300px) 100vw, 300px | 1.47 | 5%
(max-width: 150px) 100vw, 150px | 0.63 | 2%
(max-width: 100px) 100vw, 100px | 0.37 | 1%
(max-width: 400px) 100vw, 400px | 0.32 | 1%
(max-width: 80px) 100vw, 80px | 0.28 | 1%

  <figcaption id="fig15-caption">Figure 15. Percent of pages using the most popular <code>sizes</code> patterns.</figcaption>
</figure>

* **`<img sizes="auto">`** - this is the most popular use, which is actually non-standard and is an artifact of the use of the `lazy_sizes` JavaScript library. This uses client-side code to inject a better `sizes` calculation for the browser. The downside of this is that it depends on the JavaScript loading and DOM to be fully ready, delaying image loading substantially. 

 <figure>
  <a href="/static/images/2019/media/fig16_top_patterns_of_img_sizes.png">
    <img src="/static/images/2019/media/fig16_top_patterns_of_img_sizes.png" alt="Figure 16. Top patterns of 'img sizes'." aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=663985412&format=interactive">
  </a>
  <div id="fig16-description" class="visually-hidden">Bar chart showing 11.3 million images use 'img sizes="(max-width: 300px) 100vw, 300px"', 1.60 million use 'auto', 1.00 million use 'img sizes="(max-width: 767px) 89vw...etc."', 0.23 million use '100vw' and 0.13 million use '300px'</div>
  <figcaption id="fig16-caption" >Figure 16. Top patterns of <code>&lt;img sizes&gt;</code>.</figcaption>
</figure>

### Client Hints

[Client Hints](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/client-hints) allow content creators to move the resizing of images to HTTP content negotiation. In this way, the HTML does not need additional `<img srcset>` to clutter the markup, and instead can depend on a server or [image CDN to select an optimal image](https://cloudinary.com/blog/client_hints_and_responsive_images_what_changed_in_chrome_67) for the context. This allows simplifying of HTML and enables origin servers to adapt overtime and disconnect the content and presentation layers. 

To enable Client Hints, the web page must signal to the browser using either an extra HTTP header `Accept-CH: DPR, Width, Viewport-Width` _or_ by adding the HTML `<meta http-equiv="Accept-CH" content="DPR, Width, Viewport-Width">`. The convenience of one or the other technique depends on the team implementing and both are offered for convenience.

<figure>
  <a href="/static/images/2019/media/fig17_usage_of_accept-ch_http_v_html.png">
    <img src="/static/images/2019/media/fig17_usage_of_accept-ch_http_v_html.png" alt="Usage of the Accept-CH: HTTP versus HTML." aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=284657706&format=interactive">
  </a>
  <div id="fig17-description" class="visually-hidden">Bar chart showing 71% use the 'meta http-equiv', 30% use the 'Accept-CH' HTTP header and 1% use both.</div>
  <figcaption id="fig17-caption">Figure 17. Usage of the <code>Accept-CH</code> header versus the equivalent <code>&lt;meta></code> tag.</figcaption>
</figure>

The use of the `<meta>` tag in HTML to invoke Client Hints is far more common compared with the HTTP header. This is likely a reflection of the convenience to modify markup templates compared to adding HTTP headers in middle boxes. However, looking at the usage of the HTTP header, over 50% of these cases are from a single SaaS platform (Mercado). 

Of the Client Hints invoked, the majority of pages use it for the original three use-cases of `DPR`, `ViewportWidth` and `Width`. Of course, the `Width` Client Hint that requires the use `<img sizes>` for the browser to have enough context about the layout. 

<figure>
  <a href="/static/images/2019/media/fig18_enabled_client_hints.png">
    <img src="/static/images/2019/media/fig18_enabled_client_hints.png" alt="Figure 18. Enabled Client Hints." aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1878506264&format=interactive">
  </a>
  <div id="fig18-description" class="visually-hidden">A doughnut-style pie-chart showing 26.1% of client hints use 'dpr', 24.3% use 'viewport-width', 19.7% use 'width', 6.7% use 'save-data', 6.1% uses 'device-memory', 6.0% uses 'downlink', 5.6% uses 'rtt' and 5.6% uses 'ect'</div>
  <figcaption id="fig18-caption">Figure 18. Enabled Client Hints.</figcaption>
</figure>

The network-related Client Hints, `downlink`, `rtt`, and `ect`, are only available on Android Chrome.

### Lazy loading

Improving web page performance can be partially characterized as a game of illusions; moving slow things out of band and out of site of the user. In this way, lazy loading images is one of these illusions where the image and media content is only loaded when the user scrolls on the page. This improves perceived performance, even on slow networks, and saves the user from downloading bytes that are not otherwise viewed.

Earlier, in <a href="#fig-5">Figure 5</a>, we showed that the volume of image content at the 75th percentile is far more than could theoretically be shown in a single desktop or mobile viewport. The [offscreen images](https://developers.google.com/web/tools/lighthouse/audits/offscreen-images) Lighthouse audit confirms this suspicion. The median web page has 27% of image content significantly below the fold. This grows to 84% at the 90th percentile. 

<figure>
  <a href="/static/images/2019/media/fig19_lighthouse_audit_offscreen.png">
    <img src="/static/images/2019/media/fig19_lighthouse_audit_offscreen.png" alt="Figure 19. Lighthouse audit: Offscreen." aria-labelledby="fig19-caption" aria-describedby="fig19-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2123391693&format=interactive">
  </a>
  <div id="fig19-description" class="visually-hidden">A bar chart showing in the p10 percentile 0% of images are offscreen, in the p25 percentile 2% are offscreen, in the p50 percentile, 27% are offscreen, in the p75 percentile 64% are offscreen, and in the p90 percentile 84% of images are offscreen.</div>
  <figcaption id="fig19-caption">Figure 19. Lighthouse audit: Offscreen.</figcaption>
</figure>

The Lighthouse audit provides us a smell as there are a number of situations that can provide tricky to detect such as the use of quality placeholders. 

Lazy loading [can be implemented](https://developers.google.com/web/fundamentals/performance/lazy-loading-guidance/images-and-video) in many different ways including using a combination of Intersection Observers, Resize Observers, or using JavaScript libraries like [lazySizes](https://github.com/aFarkas/lazysizes), [lozad](https://github.com/ApoorvSaxena/lozad.js), and a host of others. 

In August 2019, Chrome 76 launched with the support for markup-based lazy loading using `<img loading="lazy">`. While the snapshot of websites used for the 2019 Web Almanac used July 2019 data, over 2,509 websites already utilized this feature.

### Accessibility

At the heart of image accessibility is the `alt` tag. When the `alt` tag is added to an image, this text can be used to describe the image to a user who is unable to view the images (either due to a disability, or a poor internet connection). 

We can detect all of the image tags in the HTML files of the dataset. Of 13 million image tags on desktop and 15 million on mobile, 91.6% of images have an `alt` tag present. At initial glance, it appears that image accessibility is in very good shape on the web. However, upon deeper inspection, the outlook is not as good. If we examine the length of the `alt` tags present in the dataset, we find that the median length of the `alt` tag is six characters. This maps to an empty `alt` tag (appearing as `alt=""`). Only 39% of images use `alt` text that is longer than six characters. The median value of "real" `alt` text is 31 characters, of which 25 actually describe the image.

## Video

While images dominate the media being served on web pages, videos are beginning to have a major role in content delivery on the web. According to HTTP Archive, we find that 4.06% of desktop and 2.99% of mobile sites are self-hosting video files. In other words, the video files are not hosted by websites like YouTube or Facebook.

### Video formats

Video can be delivered with many different formats and players. The dominant formats for mobile and desktop are `.ts` (segments of HLS streaming) and `.mp4` (the H264 MPEG):

<figure>
  <a href="/static/images/2019/media/fig20_video_files_by_extension.png">
    <img src="/static/images/2019/media/fig20_video_files_by_extension.png" alt="Figure 20. Count of video files by extension." aria-labelledby="fig20-caption" aria-describedby="fig20-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=999894252&format=interactive">
  </a>
  <div id="fig20-description" class="visually-hidden">A bar chart showing 'ts' usage at 1,283,439 for desktop (792,952 for mobile), 'mp4' at 729,757 thousand for desktop (662,015 for mobile), 'webm' at 38,591 for desktop (32,417 for mobile), 'mov' at 22,194 for desktop (14,986 for mobile), 'm4s' at 17,338 for desktop (16,046 for mobile), 'm4v' at 7,466 for desktop (6,169 for mobile).</div>
  <figcaption id="fig20-caption">Figure 20. Count of video files by extension.</figcaption>
</figure>

Other formats that are seen include `webm`, `mov`, `m4s`, and `m4v` (MPEG-DASH streaming segments). It is clear that the majority of streaming on the web is HLS, and that the major format for static videos is the `mp4`.

The median video size for each format is shown below:

<figure>
  <a href="/static/images/2019/media/fig21_median_vidoe_file_size_by_extension.png">
    <img src="/static/images/2019/media/fig21_median_vidoe_file_size_by_extension.png" alt="Figure 21. Median file size by video extension." aria-labelledby="fig21-caption" aria-describedby="fig21-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=821311770&format=interactive">
  </a>
  <div id="fig21-description" class="visually-hidden">A bar chart showing 'ts' average file size at 335 KB for desktop (156 KB for mobile), 'mp4' at 175 KB for desktop (128 KB for mobile), 'webm' at 359 KB for desktop (192 KB for mobile), 'mov' at 128 KB for desktop (96 KB for mobile), 'm4s' at 324 KB for desktop (246 KB for mobile), and 'm4v' at 383 KB for desktop (161 KB for mobile)</div>
  <figcaption id="fig21-caption">Figure 21. Median file size by video extension.</figcaption>
</figure>

The median values are smaller on mobile, which probably just means that some sites that have very large videos on the desktop disable them for mobile, and that video streams serve smaller versions of videos to smaller screens.

### Video file sizes

When delivering video on the web, most videos are delivered with the HTML5 video player. The HTML video player is extremely customizable to deliver video for many different purposes. For example, to autoplay a video, the parameters `autoplay` and `muted` would be added. The `controls` attribute allows the user to start/stop and scan through the video. By parsing the video tags in the HTTP Archive, we're able to see the usage of each of these attributes:

<figure>
  <a href="/static/images/2019/media/fig22_html_video_tag_attributes_usage.png">
    <img src="/static/images/2019/media/fig22_html_video_tag_attributes_usage.png" alt="Figure 21. Usage of HTML video tag attributes." aria-labelledby="fig21-caption" aria-describedby="fig21-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=593556050&format=interactive">
  </a>
  <div id="fig22-description" class="visually-hidden">A bar chart showing for desktop: 'autoplay' at 11.84%, 'buffered' at 0%, 'controls' at 12.05%, 'crossorigin' at 0.45%, 'currenttime' at 0.01%, 'disablepictureinpicture' at 0.01%, 'disableremoteplayback' at 0.01%, 'duration' at 0.05%, 'height' at 7.33%, 'intrinsicsize' at 0%, 'loop' at 14.57%, 'muted' at 13.92%, 'playsinline' at 6.49%, 'poster' at 8.98%, 'preload' at 11.62%, 'src' at 3.67%, 'use-credentials' at 0%, and 'width' at 9%. And for mobile 'autoplay' at 12.38%, 'buffered' at 0%, 'controls' at 13.88%, 'crossorigin' at 0.16%, 'currenttime' at 0.01%, disablepictureinpicture' at 0.01%, 'disableremoteplayback' at 0.02%, 'duration' at 0.09%, 'height' at 6.54%,  intrinsicsize' at 0%, 'loop' at 14.44%, 'muted' at 13.55%, 'playsinline' at 6.15%, 'poster' at 9.29%, 'preload' at 10.34%, 'src' at 4.13%, 'use-credentials' at 0%, and 'width' at 9.03%.</div>
  <figcaption id="fig22-caption">Figure 22. Usage of HTML video tag attributes.</figcaption>
</figure>

The most common attributes are `autoplay`, `muted` and `loop`, followed by the `preload` tag and `width` and `height`. The use of the `loop` attribute is used in background videos, and also when videos are used to replace animated GIFs, so it is not surprising to see that it is often used on website home pages.

While most of the attributes have similar usage on desktop and mobile, there are a few that have significant differences. The two attributes with the largest difference between mobile and desktop are `width` and `height`, with 4% fewer sites using these attributes on mobile. Interestingly, there is a small increase of the `poster` attribute (placing an image over the video window before playback) on mobile.

From an accessibility point of view, the `<track>` tag can be used to add captions or subtitles. There is data in the HTTP Archive on how often the `<track>` tag is used, but on investigation, most of the instances in the dataset were commented out or pointed to an asset returning a `404` error. It appears that many sites use boilerplate JavaScript or HTML and do not remove the track, even when it is not in use.

### Video players

For more advanced playback (and to play video streams), the HTML5 native video player will not work. There are a few popular video libraries that are used to playback the video:

<figure>
  <a href="/static/images/2019/media/fig23_top_javascript_video_players.png">
    <img src="/static/images/2019/media/fig23_top_javascript_video_players.png" alt="Figure 23. Top JavaScript video players." aria-labelledby="fig23-caption" aria-describedby="fig23-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=215677194&format=interactive">
  </a>
  <div id="fig23-description" class="visually-hidden">Bar chart showing 'flowplayer' used by 3,365 desktop sites (3,400 mobile), 'hls' by 52,375 desktop sites (40,925 mobile), 'jwplayer' by 110,280 desktop sites (96,945 mobile), 'shaka' on 325 desktop sites (275 mobile) and 'video' used on 377,990 desktop sites (391,330 mobile)</div>
  <figcaption id="fig23-caption">Figure 23. Top JavaScript video players.</figcaption>
</figure>

The most popular (by far) is video.js, followed by JWPLayer and HLS.js. The authors do admit that it is possible that there are other files with the name "video.js" that may not be the same video playback library.

## Conclusion
Nearly all web pages use images and video to some degree to enhance the user experience and create meaning. These media files utilize a large amount of resources and are a large percentage of the tonnage of websites (and they are not going away!) Utilization of alternative formats, lazy loading, responsive images, and image optimization can go a long way to lower the size of media on the web. 
