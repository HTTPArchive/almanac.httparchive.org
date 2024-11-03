---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Ecommerce
description: Ecommerce chapter of the 2019 Web Almanac covering ecommerce platforms, payloads, images, third-parties, performance, SEO, and PWAs.
authors: [samdutton, alankent]
reviewers: [voltek62]
analysts: [rviscomi]
editors: [tunetheweb]
translators: []
discuss: 1768
results: https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/
samdutton_bio: Sam Dutton has worked with the Google Chrome team as a Developer Advocate since 2011. He has organized and presented at a number of events, created and taught several web development courses, and worked on a range of videos, codelabs and written guidance covering PWA, performance, media, image and 'Next Billion Users' initiatives. He maintains <a hreflang="en" href="https://simpl.info">simpl.info</a>, which provides simplest possible examples of HTML, CSS and JavaScript. Sam grew up in South Australia, went to university in Sydney, and has lived since 1986 in London.
alankent_bio: Alan Kent is a Developer Advocate at Google focusing on e-commerce and content ecosystems. He blogs at <a hreflang="en" href="https://alankent.me">alankent.me</a> and tweets as <a href="https://x.com/akent99">@akent99</a>.
featured_quote: Nearly 10% of the home pages in this study were found to be on an ecommerce platform. An "ecommerce platform" is a set of software or services that enables you to create and operate an online store, including Paid-for services such as Shopify, software platforms such as Magento Open Source, and Hosted platforms such as Magento Commerce.
featured_stat_1: 3.98%
featured_stat_label_1: Sites using WooCommerce the most popular ecommerce platform
featured_stat_2: 116
featured_stat_label_2: Number of ecommerce platforms detected
featured_stat_3: 1,517 KB
featured_stat_label_3: Median image bytes per mobile ecommerce page
---

## Introduction

Nearly 10% of the home pages in this study were found to be on an ecommerce platform. An "ecommerce platform" is a set of software or services that enables you to create and operate an online store. There are several types of ecommerce platforms, for example:

- **Paid-for services** such as <a hreflang="en" href="https://www.shopify.com/">Shopify</a> that host your store and help you get started. They provide website hosting, site and page templates, product-data management, shopping carts and payments.
- **Software platforms** such as <a hreflang="en" href="https://magento.com/products/magento-open-source">Magento Open Source</a> which you set up, host and manage yourself. These platforms can be powerful and flexible, but may be more complex to set up and run than services such as Shopify.
- **Hosted platforms** such as <a hreflang="en" href="https://magento.com/products/magento-commerce">Magento Commerce</a> that offer the same features as their self-hosted counterparts, except that hosting is managed as a service by a third-party.

{{ figure_markup(
  caption="Percent of pages on an ecommerce platform.",
  content="10%",
  classes="big-number"
)
}}

This analysis could only detect sites built on an ecommerce platform. This means that most large online stores and marketplaces—such as Amazon, JD, and eBay—are not included here. Also note that the data here is for home pages only: not category, product or other pages. Learn more about our [methodology](./methodology).

## Platform detection

How do we check if a page is on an ecommerce platform?

Detection is done through [Wappalyzer](./methodology#wappalyzer). Wappalyzer is a cross-platform utility that uncovers the technologies used on websites. It detects [content management systems](./cms), ecommerce platforms, web servers, [JavaScript](./javascript) frameworks, [analytics](./third-parties) tools, and many more.

Page detection is not always reliable, and some sites explicitly block detection to protect against automated attacks. We might not be able to catch all websites that use a particular ecommerce platform, but we're confident that the ones we do detect are actually on that platform.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Ecommerce pages</td>
        <td class="numeric">500,595</td>
        <td class="numeric">424,441</td>
      </tr>
      <tr>
        <td>Total pages</td>
        <td class="numeric">5,297,442</td>
        <td class="numeric">4,371,973</td>
      </tr>
      <tr>
        <td>Adoption rate</td>
        <td class="numeric">9.45%</td>
        <td class="numeric">9.70%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percent of ecommerce platforms detected.") }}</figcaption>
</figure>

## Ecommerce platforms

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">3.98</td>
        <td class="numeric">3.90</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">1.59</td>
        <td class="numeric">1.72</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">1.10</td>
        <td class="numeric">1.24</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">0.91</td>
        <td class="numeric">0.87</td>
      </tr>
      <tr>
        <td>Bigcommerce</td>
        <td class="numeric">0.19</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>Shopware</td>
        <td class="numeric">0.12</td>
        <td class="numeric">0.11</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adoption of the top six ecommerce platforms.") }}</figcaption>
</figure>

Out of the 116 ecommerce platforms that were detected, only six are found on more than 0.1% of desktop or mobile websites. Note that these results do not show variation by country, by size of site, or other similar metrics.

Figure 13.3 above shows that WooCommerce has the largest adoption at around 4% of desktop and mobile websites. Shopify is second with about 1.6% adoption. Magento, PrestaShop, Bigcommerce, and Shopware follow with smaller and smaller adoption, approaching 0.1%.

### Long tail

{{ figure_markup(
  image="fig4.png",
  caption="Adoption of top ecommerce platforms.",
  description="Bar chart of the adoption of top 20 ecommerce platforms. Refer to Figure 13.3 above for a data table of adoption of the top six platforms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1565776696&format=interactive",
  width=600,
  height=414,
  data_width=600,
  data_height=414
  )
}}

There are 110 ecommerce platforms that each have fewer than 0.1% of desktop or mobile websites. Around 60 of these have fewer than 0.01% of mobile or desktop websites.

{{ figure_markup(
  image="fig5.png",
  caption="Combined adoption of the top six ecommerce platforms versus the other 110 platforms.",
  description="The top six ecommerce platforms make up 8% of all websites. The rest of the 110 platforms only make up 1.5% of websites. The results for desktop and mobile are similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2093212206&format=interactive",
  width=600,
  height=361,
  data_width=600,
  data_height=361
  )
}}

7.87% of all requests on mobile and 8.06% on desktop are for home pages on one of the top six ecommerce platforms. A further 1.52% of requests on mobile and 1.59% on desktop are for home pages on the 110 other ecommerce platforms.

## Ecommerce (all platforms)

In total, 9.7% of desktop pages and 9.5% of mobile pages used an ecommerce platform.

{{ figure_markup(
  image="fig6.png",
  caption="Percent of pages using any ecommerce platform.",
  description="9.7% of desktop pages use an ecommerce platform and 9.5% of mobile pages use an ecommerce platform.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1360307171&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

Although the desktop proportion of websites was slightly higher overall, some popular platforms (including WooCommerce, PrestaShop and Shopware) actually have more mobile than desktop websites.

## Page weight and requests

The [page weight](./page-weight) of an ecommerce platform includes all HTML, CSS, JavaScript, JSON, XML, images, audio, and video.

{{ figure_markup(
  image="fig7.png",
  caption="Distribution of ecommerce page weight.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of ecommerce page weight. The median desktop ecommerce page loads 2.7 MB. The 10th percentile is 1.0 MB, 25th 1.6 MB, 75th 4.5 MB, and 90th 7.6 MB. Desktop websites are slightly higher than mobile by tenths of a megabyte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=448248428&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Distribution of requests per ecommerce page.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of requests per ecommerce page. The median desktop ecommerce page makes 108 requests. The 10th percentile is 53 requests, 25th 76, 75th 153, and 90th 210. Desktop websites are slightly higher than mobile by about 10 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1968521689&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

The median desktop ecommerce platform page loads 108 requests and 2.7 MB. The median weight for _all_ desktop pages is 74 requests and [1.9 MB](./page-weight#page-weight). In other words, ecommerce pages make nearly 50% more requests than other web pages, with payloads around 35% larger. By comparison, the <a hreflang="en" href="https://amazon.com">amazon.com</a> home page makes around 300 requests on first load, for a page weight of around 5 MB, and <a hreflang="en" href="https://ebay.com">ebay.com</a> makes around 150 requests for a page weight of approximately 3 MB. The page weight and number of requests for home pages on ecommerce platforms is slightly smaller on mobile at every percentile, but around 10% of all ecommerce home pages load more than 7 MB and make over 200 requests.

This data accounts for home page payload and requests without scrolling. Clearly there are a significant proportion of sites that appear to be retrieving more files (the median is over 100), with a larger total payload, than should be necessary for first load. See also: [Third-party requests and bytes](#third-party-requests-and-bytes) below.

We need to do further research to better understand why so many home pages on ecommerce platforms make so many requests and have such large payloads. The authors regularly see home pages on ecommerce platforms that make hundreds of requests on first load, with multi-megabyte payloads. If the number of requests and payload are a problem for performance, then how can they be reduced?

## Requests and payload by type

The charts below are for desktop requests:

<figure>
  <table>
    <thead>
      <tr>
        <th>Type</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>image</td>
        <td class="numeric">353</td>
        <td class="numeric">728</td>
        <td class="numeric">1,514</td>
        <td class="numeric">3,104</td>
        <td class="numeric">6,010</td>
      </tr>
      <tr>
        <td>video</td>
        <td class="numeric">156</td>
        <td class="numeric">453</td>
        <td class="numeric">1,325</td>
        <td class="numeric">2,935</td>
        <td class="numeric">5,965</td>
      </tr>
      <tr>
        <td>script</td>
        <td class="numeric">199</td>
        <td class="numeric">330</td>
        <td class="numeric">572</td>
        <td class="numeric">915</td>
        <td class="numeric">1,331</td>
      </tr>
      <tr>
        <td>font</td>
        <td class="numeric">47</td>
        <td class="numeric">85</td>
        <td class="numeric">144</td>
        <td class="numeric">226</td>
        <td class="numeric">339</td>
      </tr>
      <tr>
        <td>css</td>
        <td class="numeric">36</td>
        <td class="numeric">59</td>
        <td class="numeric">102</td>
        <td class="numeric">180</td>
        <td class="numeric">306</td>
      </tr>
      <tr>
        <td>html</td>
        <td class="numeric">12</td>
        <td class="numeric">20</td>
        <td class="numeric">36</td>
        <td class="numeric">66</td>
        <td class="numeric">119</td>
      </tr>
      <tr>
        <td>audio</td>
        <td class="numeric">7</td>
        <td class="numeric">7</td>
        <td class="numeric">11</td>
        <td class="numeric">17</td>
        <td class="numeric">140</td>
      </tr>
      <tr>
        <td>xml</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>other</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>text</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Percentiles of the distribution of page weight (in KB) by resource type.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Type</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>image</td>
        <td class="numeric">16</td>
        <td class="numeric">25</td>
        <td class="numeric">39</td>
        <td class="numeric">62</td>
        <td class="numeric">97</td>
      </tr>
      <tr>
        <td>script</td>
        <td class="numeric">11</td>
        <td class="numeric">21</td>
        <td class="numeric">35</td>
        <td class="numeric">53</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>css</td>
        <td class="numeric">3</td>
        <td class="numeric">6</td>
        <td class="numeric">11</td>
        <td class="numeric">22</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td>font</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">5</td>
        <td class="numeric">8</td>
        <td class="numeric">11</td>
      </tr>
      <tr>
        <td>html</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">7</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>video</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">5</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>other</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>text</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>xml</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>audio</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentiles of the distribution of requests per page by resource type.") }}</figcaption>
</figure>

Images constitute the largest number of requests and the highest proportion of bytes for ecommerce pages. The median desktop ecommerce page includes 39 images weighing 1,514 KB (1.5 MB).

The number of [JavaScript](./javascript) requests indicates that better bundling (and/or [HTTP/2](./http) multiplexing) could improve performance. JavaScript files are not significantly large in terms of total bytes, but many separate requests are made. According to the [HTTP/2](./http#adoption-of-http2) chapter, more than 40% of requests are not via HTTP/2. Similarly, CSS files have the third highest number of requests but are generally small. Merging CSS files (and/or HTTP/2) could improve performance of such sites. In the authors' experience, many ecommerce pages have a high proportion of unused CSS and JavaScript. [Videos](./media) may require a small number of requests, but (not surprisingly) consume a high proportion of the page weight, particularly on sites with heavy payloads.

## HTML payload size

{{ figure_markup(
  image="fig11.png",
  caption="Distribution of HTML bytes (in KB) per ecommerce page.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of HTML bytes per ecommerce page. The median desktop ecommerce page has 36 KB of HTML. The 10th percentile is 12 KB, 25th 20, 75th 66, and 90th 118. Desktop websites have slightly more HTML bytes than mobile by 1 or 2 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=908924961&format=interactive"
  )
}}

Note that HTML payloads may include other code such as inline JSON, JavaScript, or CSS directly in the markup itself, rather than referenced as external links. The median HTML payload size for ecommerce pages is 34 KB on mobile and 36 KB on desktop. However, 10% of ecommerce pages have an HTML payload of more than 115 KB.

Mobile HTML payload sizes are not very different from desktop. In other words, it appears that sites are not delivering significantly different HTML files for different devices or viewport sizes. On many ecommerce sites, home page HTML payloads are large. We don't know whether this is because of bloated HTML, or from other code (such as JSON) within HTML files.

## Image stats

{{ figure_markup(
  image="fig12.png",
  caption="Distribution of image bytes (in KB) per ecommerce page.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of image bytes per ecommerce page. The median mobile ecommerce page has 1,517 KB of images. The 10th percentile is 318 KB, 25th 703, 75th 3,132, and 90th 5,881. Desktop and mobile websites have similar distributions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=323146848&format=interactive"
  )
}}

{{ figure_markup(
  image="fig13.png",
  caption="Distribution of image requests per ecommerce page.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of image requests per ecommerce page. The median desktop ecommerce page makes 40 image requests. The 10th percentile is 16 requests, 25th 25, 75th 62, and 90th 97. The desktop distribution is slightly higher than mobile by 2-10 requests at each percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1483037371&format=interactive"
  )
}}

<p class="note">Note that because our data collection <a href="./methodology">methodology</a> does not simulate user interactions on pages like clicking or scrolling, images that are lazy loaded would not be represented in these results.</p>

Figures 13.12 and 13.13 above show that the median ecommerce page has 37 images and an image payload of 1,517 KB on mobile, 40 images and 1,524 KB on desktop. 10% of home pages have 90 or more images and an image payload of nearly 6 MB!

{{ figure_markup(
  caption="The median number of image bytes per mobile ecommerce page.",
  content="1,517 KB",
  classes="big-number"
)
}}

A significant proportion of ecommerce pages have sizable image payloads and make a large number of image requests on first load. See HTTP Archive's <a hreflang="en" href="https://httparchive.org/reports/state-of-images">State of Images</a> report and the [media](./media) and [page weight](./page-weight) chapters for more context.

Website owners want their sites to look good on modern devices. As a result, many sites deliver the same high resolution product images to every user _without regard for screen resolution or size_. Developers may not be aware of (or not want to use) responsive techniques that enable efficient delivery of the best possible image to different users. It's worth remembering that high-resolution images may not necessarily increase conversion rates. Conversely, overuse of heavy images is likely to impact page speed and can thereby _reduce_ conversion rates. In the authors' experience from site reviews and events, some developers and other stakeholders have SEO or other concerns about using lazy loading for images.

We need to do more analysis to better understand why some sites are not using responsive image techniques or lazy loading. We also need to provide guidance that helps ecommerce platforms to reliably deliver beautiful images to those with high end devices and good connectivity, while simultaneously providing a best-possible experience to lower-end devices and those with poor connectivity.

## Popular image formats

{{ figure_markup(
  image="fig15.png",
  caption="Popular image formats.",
  description="Bar chart showing the popularity of various image formats. JPEG is the most popular format at 54% of images on desktop ecommerce pages. Next are PNG at 27%, GIF at 14%, SVG at 2%, and WebP and ICO at 1% each.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2108999644&format=interactive"
  )
}}

<p class="note">Note that some image services or CDNs will automatically deliver WebP (rather than JPEG or PNG) to platforms that support WebP, even for a URL with a `.jpg` or `.png` suffix. For example, <a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">IMG_20190113_113201.jpg</a> returns a WebP image in Chrome. However, the way HTTP Archive <a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/31a25b9064a365d746d4811a1d6dda516c0e4985/bulktest/batch_lib.inc#L994">detects image formats</a> is to check for keywords in the MIME type first, then fall back to the file extension. This means that the format for images with URLs such as the above will be given as WebP, since WebP is supported by HTTP Archive as a user agent.</p>

### PNG

One in four images on ecommerce pages are PNG. The high number of PNG requests from pages on ecommerce platforms is probably for product images. Many commerce sites use PNG with photographic images to enable transparency.

Using WebP with a PNG fallback can be a far more efficient alternative, either via a [picture element](http://simpl.info/picturetype) or by using user agent capability detection via an image service such as <a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">Cloudinary</a>.

### WebP

Only 1% of images on ecommerce platforms are WebP, which tallies with the authors' experience of site reviews and partner work. WebP is <a hreflang="en" href="https://caniuse.com/#feat=webp">supported by all modern browsers other than Safari</a> and has good fallback mechanisms available. WebP supports transparency and is a far more efficient format than PNG for photographic images (see PNG section above).

We as a web community can provide better guidance/advocacy for enabling transparency using WebP with a PNG fallback and/or using WebP/JPEG with a solid color background. WebP appears to be rarely used on ecommerce platforms, despite the availability of <a hreflang="en" href="https://web.dev/serve-images-webp">guides</a> and tools (e.g. <a hreflang="en" href="https://squoosh.app/">Squoosh</a> and <a hreflang="en" href="https://developers.google.com/speed/webp/docs/cwebp">cwebp</a>). We need to do further research into why there hasn't been more take-up of WebP, which is now <a hreflang="en" href="https://blog.chromium.org/2010/09/webp-new-image-format-for-web.html">nearly 10 years old</a>.

## Image dimensions

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Mobile</th>
        <th scope="colgroup" colspan="2">Desktop</th>
      </tr>
      <tr>
        <th scope="col">Percentile</th>
        <th scope="col">Width (px)</th>
        <th scope="col">Height (px)</th>
        <th scope="col">Width (px)</th>
        <th scope="col">Height (px)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">100</td>
        <td class="numeric">64</td>
        <td class="numeric">100</td>
        <td class="numeric">60</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">247</td>
        <td class="numeric">196</td>
        <td class="numeric">240</td>
        <td class="numeric">192</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">364</td>
        <td class="numeric">320</td>
        <td class="numeric">400</td>
        <td class="numeric">331</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">693</td>
        <td class="numeric">512</td>
        <td class="numeric">800</td>
        <td class="numeric">546</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribution of intrinsic image dimensions (in pixels) per ecommerce page.") }}</figcaption>
</figure>

The median ('mid-range') dimensions for images requested by ecommerce pages is 247x196 px on mobile and 240x192 px on desktop. 10% of images requested by ecommerce pages are at least 693x512 px on mobile and 800x546 px on desktop. Note that these dimensions are the intrinsic sizes of images, not their display size.

Given that image dimensions at each percentile up to the median are similar on mobile and desktop, or even slightly _larger_ on mobile in some cases, it would seem that many sites are not delivering different image dimensions for different viewports, or in other words, not using responsive image techniques. The delivery of _larger_ images to mobile in some cases may (or may not!) be explained by sites using device or screen detection.

We need to do more research into why many sites are (apparently) not delivering different image sizes to different viewports.

## Third-party requests and bytes

Many websites—especially online stores—load a significant amount of code and content from third-parties: for analytics, A/B testing, customer behavior tracking, advertising, and social media support. Third-party content can have a <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">significant impact on performance</a>. [Patrick Hulce](https://x.com/patrickhulce)'s <a hreflang="en" href="https://github.com/patrickhulce/third-party-web">third-party-web tool</a> is used to determine third-party requests for this report, and this is discussed more in the [Third Parties](./third-parties) chapter.

{{ figure_markup(
  image="fig17.png",
  caption="Distribution of third-party requests per ecommerce page.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of third-party requests per ecommerce page. The median number of third-party requests on desktop is 19. The 10, 25, 75, and 90th percentiles are: 4, 9, 34, and 54. The desktop distribution is higher at each percentile than mobile by only 1-2 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=865791628&format=interactive"
  )
}}

{{ figure_markup(
  image="fig18.png",
  caption="Distribution of third-party bytes per ecommerce page.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of third-party bytes per ecommerce page. The median number of third-party bytes on desktop is 320 KB. The 10, 25, 75, and 90th percentiles are: 42, 129, 651, and 1,071. The desktop distribution is higher at each percentile than mobile by 10-30 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=164264869&format=interactive"
  )
}}

The median ('mid-range') home page on an ecommerce platform makes 17 requests for third-party content on mobile and 19 on desktop. 10% of all home pages on ecommerce platforms make over 50 requests for third-party content, with a total payload of over 1 MB.

<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript/">Other studies</a> have indicated that third-party content can be a major performance bottleneck. This study shows that 17 or more requests (50 or more for the top 10%) is the norm for ecommerce pages.

## Third-party requests and payload per platform

Note the charts and tables below show data for mobile only.

{{ figure_markup(
  image="fig19.png",
  caption="Distribution of third-party requests per mobile page for each ecommerce platform.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of third-party requests per ecommerce page for each platform. Shopify and Bigcommerce load the most third-party requests across the distributions by about 40 requests at the median.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1242665725&format=interactive"
  )
}}

{{ figure_markup(
  image="fig20.png",
  caption="Distribution of third-party bytes (KB) per mobile page for each ecommerce platform.",
  description="Distribution of the 10, 25, 50, 75, and 90th percentiles of third-party bytes (KB) per ecommerce page for each platform. Shopify and Bigcommerce load the most third-party bytes across the distributions by more than 1,000 KB at the median.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1017068803&format=interactive"
  )
}}

Platforms such as Shopify may extend their services using client-side JavaScript, whereas other platforms such as Magento use more server side extensions. This difference in architecture affects the figures seen here.

Clearly, pages on some ecommerce platforms make more requests for third-party content and incur a larger payload of third-party content. Further analysis could be done on _why_ pages from some platforms make more requests and have larger third-party payloads than others.

## First Contentful Paint (FCP)

{{ figure_markup(
  image="fig21.png",
  caption="Average distribution of FCP experiences per ecommerce platform.",
  description="Bar chart of the average distribution of FCP experiences for the top six ecommerce platforms. WooCommerce has the highest density of slow FCP experiences at 43%. Shopify has the highest density of fast FCP experiences at 47%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1341906463&format=interactive"
  )
}}

[First Contentful Paint](./performance#first-contentful-paint) measures the time it takes from navigation until content such as text or an image is first displayed. In this context, **fast** means FCP in under one second, **slow** means FCP in 3 seconds or more, and **moderate** is everything in between. Note that third-party content and code may have a significant impact on FCP.

All top-six ecommerce platforms have worse FCP on mobile than desktop: less fast and more slow. Note that FCP is affected by device capability (processing power, memory, etc.) as well as connectivity.

We need to establish why FCP is worse on mobile than desktop. What are the causes: connectivity and/or device capability, or something else?

## Progressive Web App (PWA) scores

See also the [PWA chapter](./pwa) for more information on this topic beyond just ecommerce sites.

{{ figure_markup(
  image="fig22.png",
  caption="Distribution of Lighthouse PWA category scores for mobile ecommerce pages.",
  description="Distribution of Lighthouse's PWA category scores for ecommerce pages. On a scale of 0 (failing) to 1 (perfect), 40% of pages get a score of 0.33. 1% of pages get a score above 0.6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1148584930&format=interactive"
  )
}}

More than 60% of home pages on ecommerce platforms get a <a hreflang="en" href="https://developers.google.com/web/ilt/pwa/lighthouse-pwa-analysis-tool">Lighthouse PWA score</a> between 0.25 and 0.35. Less than 20% of home pages on ecommerce platforms get a score of more than 0.5 and less than 1% of home pages score more than 0.6.

Lighthouse returns a Progressive Web App (PWA) score between 0 and 1. 0 is the worst possible score, and 1 is the best. The PWA audits are based on the <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">Baseline PWA Checklist</a>, which lists 14 requirements. Lighthouse has automated audits for 11 of the 14 requirements. The remaining 3 can only be tested manually. Each of the 11 automated PWA audits are weighted equally, so each one contributes approximately 9 points to your PWA score.

If at least one of the PWA audits got a null score, Lighthouse nulls out the score for the entire PWA category. This was the case for 2.32% of mobile pages.

Clearly, the majority of ecommerce pages are failing most <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">PWA checklist audits</a>. We need to do further analysis to better understand which audits are failing and why.

## Conclusion

This comprehensive study of ecommerce usage shows some interesting data and also the wide variations in ecommerce sites, even among those built on the same ecommerce platform. Even though we have gone into a lot of detail here, there is much more analysis we could do in this space. For example, we didn't get accessibility scores this year (checkout the [accessibility chapter](./accessibility) for more on that). Likewise, it would be interesting to segment these metrics by geography. This study detected 246 ad providers on home pages on ecommerce platforms. Further studies (perhaps in next year's Web Almanac?) could calculate what proportion of sites on ecommerce platforms shows ads. WooCommerce got very high numbers in this study so another interesting statistic we could look at next year is if some hosting providers are installing WooCommerce but not enabling it, thereby causing inflated figures.
