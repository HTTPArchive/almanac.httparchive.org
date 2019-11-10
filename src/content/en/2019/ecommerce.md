---
part_number: III
chapter_number: 13
title: Ecommerce
description: Ecommerce chapter of the 2019 Web Almanac covering ecommerce platforms, payloads, images, third parties, performance, seo, and PWAs
authors: [samdutton, alankent]
reviewers: [voltek62]
discuss: 1768
published: 2019-11-04T12:00:00+00:00:00
last_updated: 2019-11-07T21:46:11.000Z 
---

## Introduction

Nearly 10% of the home pages in this study were found to be on an ecommerce platform. An "ecommerce platform" is a set of software or services that enables you to create and operate an online store. There are several types of ecommerce platforms, for example:

-  **Paid-for services** such as [Shopify](https://www.shopify.com/) that host your store and help you get started. They provide website hosting, site and page templates, product-data management, shopping carts and payments.
-  **Software platforms** such as [Magento Open Source](https://magento.com/products/magento-open-source) which you set up, host and manage yourself. These platforms can be powerful and flexible, but may be more complex to set up and run than services such as Shopify.
-  **Hosted platforms** such as [Magento Commerce](https://magento.com/products/magento-commerce) that offer the same features as their self-hosted counterparts, except that hosting is managed as a service by a third party.

<figure>
  <div class="big-number">10%</div>
  <figcaption>Figure 1. Percent of pages on an ecommerce platform.</figcaption>
</figure>

This analysis could only detect sites built on an ecommerce platform. This means that most large online stores and marketplaces—such as Amazon, JD, and eBay—are not included here. Also note that the data here is for home pages only: not category, product or other pages. Learn more about our [methodology](./methodology).

## Platform detection

How do we check if a page is on an ecommerce platform?

Detection is done through [Wappalyzer](./methodology#wappalyzer). Wappalyzer is a cross-platform utility that uncovers the technologies used on websites. It detects [content management systems](./cms), ecommerce platforms, web servers, [JavaScript](./javascript) frameworks, [analytics](./third-parties) tools, and many more.

Page detection is not always reliable, and some sites explicitly block detection to protect against automated attacks. We might not be able to catch all websites that use a particular ecommerce platform, but we're confident that the ones we do detect are actually on that platform.

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>Mobile</th>
        <th>Desktop</th>
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
  <figcaption>Figure 2. Percent of ecommerce platforms detected.</figcaption>
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
  <figcaption>Figure 3. Adoption of the top six ecommerce platforms.</figcaption>
</figure>

Out of the 116 ecommerce platforms that were detected, only six are found on more than 0.1% of desktop or mobile websites. Note that these results do not show variation by country, by size of site, or other similar metrics.

Figure 3 above shows that WooCommerce has the largest adoption at around 4% of desktop and mobile websites. Shopify is second with about 1.6% adoption. Magento, PrestaShop, Bigcommerce, and Shopware follow with smaller and smaller adoption, approaching 0.1%.

### Long tail

<figure>
  <iframe aria-labelledby="fig4-caption" width="600" height="414.5" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1565776696&amp;format=interactive"></iframe>
  <a href="/static/images/2019/13_Ecommerce/fig4.png" class="fig-mobile">
    <img src="/static/images/2019/13_Ecommerce/fig4.png" aria-labelledby="fig4-caption" width="600">
  </a>
  <div id="fig4-caption" class="visually-hidden">Bar chart of the adoption of top 20 ecommerce plaforms. Refer to Figure 3 above for a data table of adoption of the top six platforms.</div>
  <figcaption>Figure 4. Adoption of top ecommerce platforms.</figcaption>
</figure>

There are 110 ecommerce platforms that each have fewer than 0.1% of desktop or mobile websites. Around 60 of these have fewer than 0.01% of mobile or desktop websites.

<figure>
  <iframe aria-labelledby="fig5-caption" width="600" height="361" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2093212206&amp;format=interactive"></iframe>
  <a href="/static/images/2019/13_Ecommerce/fig5.png" class="fig-mobile">
    <img src="/static/images/2019/13_Ecommerce/fig5.png" aria-labelledby="fig5-caption" width="600">
  </a>
  <div id="fig5-caption" class="visually-hidden">The top six ecommerce platforms make up 8% of all websites. The rest of the 110 platforms only make up 1.5% of websites. The results for desktop and mobile are similar.</div>
  <figcaption>Figure 5. Combined adoption of the top six ecommerce platforms versus the other 110 platforms.</figcaption>
</figure>

7.87% of all requests on mobile and 8.06% on desktop are for home pages on one of the top six ecommerce platforms. A further 1.52% of requests on mobile and 1.59% on desktop are for home pages on the 110 other ecommerce platforms.

## Ecommerce (all platforms)

In total, 9.7% of desktop pages and 9.5% of mobile pages used an ecommerce platform.

<figure>
  <iframe aria-labelledy="fig6-caption" width="600" height="363" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1360307171&amp;format=interactive"></iframe>
  <a href="/static/images/2019/13_Ecommerce/fig6.png" class="fig-mobile">
    <img src="/static/images/2019/13_Ecommerce/fig6.png" aria-labelledby="fig6-caption" width="600">
  </a>
  <div id="fig6-caption" class="visually-hidden">9.7% of desktop pages use an ecommerce platform and 9.5% of mobile pages use an ecommerce platform.</div>
  <figcaption>Figure 6. Percent of pages using any ecommerce platform.</figcaption>
</figure>

Although the desktop proportion of websites was slightly higher overall, some popular platforms (including WooCommerce, PrestaShop and Shopware) actually have more mobile than desktop websites.

## Page weight and requests

The [page weight](./page-weight) of an ecommerce platform includes all HTML, CSS, JavaScript, JSON, XML, images, audio, and video.

<figure>
  <iframe aria-labelledby="fig7-caption" width="600" height="363" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=448248428&amp;format=interactive"></iframe>
  <a href="/static/images/2019/13_Ecommerce/fig7.png" class="fig-mobile">
    <img src="/static/images/2019/13_Ecommerce/fig7.png" aria-labelledby="fig7-caption" width="600">
  </a>
  <div id="fig7-caption" class="visually-hidden">Distribution of the 10, 25, 50, 75, and 90th percentiles of ecommerce page weight. The median desktop ecommerce page loads 2.7 MB. The 10th percentile is 1.0 MB, 25th 1.6 MB, 75th 4.5 MB, and 90th 7.6 MB. Desktop websites are slightly higher than mobile by tenths of a megabyte.</div>
  <figcaption>Figure 7. Distribution of ecommerce page weight.</figcaption>
</figure>

<figure>
  <iframe aria-labelledby="fig8-caption" width="600" height="363" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1968521689&amp;format=interactive"></iframe>
  <a href="/static/images/2019/13_Ecommerce/fig8.png" class="fig-mobile">
    <img src="/static/images/2019/13_Ecommerce/fig8.png" aria-labelledby="fig8-caption" width="600">
  </a>
  <div id="fig8-caption" class="visually-hidden">Distribution of the 10, 25, 50, 75, and 90th percentiles of requests per ecommerce page. The median desktop ecommerce page makes 108 requests. The 10th percentile is 53 requests, 25th 76, 75th 153, and 90th 210. Desktop websites are slightly higher than mobile by about 10 requests.</div>
  <figcaption>Figure 8. Distribution of requests per ecommerce page.</figcaption>
</figure>

The median desktop ecommerce platform page loads 108 requests and 2.7 MB. The median weight for _all_ desktop pages is 74 requests and [1.9 MB](./page-weight#page-weight). In other words, ecommerce pages make nearly 50% more requests than other web pages, with payloads around 35% larger. By comparison, the [amazon.com](https://amazon.com) home page makes around 300 requests on first load, for a page weight of around 5 MB, and [ebay.com](https://ebay.com) makes around 150 requests for a page weight of approximately 3 MB. The page weight and number of requests for home pages on ecommerce platforms is slightly smaller on mobile at every percentile, but around 10% of all ecommerce home pages load more than 7 MB and make over 200 requests.

This data accounts for home page payload and requests without scrolling. Clearly there are a significant proportion of sites that appear to be retrieving more files (the median is over 100), with a larger total payload, than should be necessary for first load. See also: [Third party requests and bytes](#third-party-requests-and-bytes) below. 

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
<figcaption>Figure 9. Percentiles of the distribution of page weight (in KB) by resource type.</figcaption>
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
  <figcaption>Figure 10. Percentiles of the distribution of requests per page by resource type.</figcaption>
</figure>

Images constitute the largest number of requests and the highest proportion of bytes for ecommerce pages. The median desktop ecommerce page includes 39 images weighing 1,514 KB (1.5 MB).

The number of [JavaScript](./javascript) requests indicates that better bundling (and/or [HTTP/2](./http2) multiplexing) could improve performance. JavaScript files are not significantly large in terms of total bytes, but many separate requests are made. According to the [HTTP/2](./http2#user-content-adoption-of-http2) chapter, more than 40% of requests are not via HTTP/2. Similarly, CSS files have the third highest number of requests but are generally small. Merging CSS files (and/or HTTP/2) could improve performance of such sites. In the authors' experience, many ecommerce pages have a high proportion of unused CSS and JavaScript. [Videos](./media) may require a small number of requests, but (not surprisingly) consume a high proportion of the page weight, particularly on sites with heavy payloads.

## HTML payload size

<figure>
  <iframe aria-labelledby="fig11-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=908924961&amp;format=interactive"></iframe>
  <a href="/static/images/2019/13_Ecommerce/fig11.png" class="fig-mobile">
    <img src="/static/images/2019/13_Ecommerce/fig11.png" aria-labelledby="fig11-caption" width="600">
  </a>
  <div id="fig11-caption" class="visually-hidden">Distribution of the 10, 25, 50, 75, and 90th percentiles of HTML bytes per ecommerce page. The median desktop ecommerce page has 36 KB of HTML. The 10th percentile is 12 KB, 25th 20, 75th 66, and 90th 118. Desktop websites have slightly more HTML bytes than mobile by 1 or 2 KB.</div>
  <figcaption>Figure 11. Distribution of HTML bytes (in KB) per ecommerce page.</figcaption>
</figure>

Note that HTML payloads may include other code such as inline JSON, JavaScript, or CSS directly in the markup itself, rather than referenced as external links. The median HTML payload size for ecommerce pages is 34 KB on mobile and 36 KB on desktop. However, 10% of ecommerce pages have an HTML payload of more than 115 KB.

Mobile HTML payload sizes are not very different from desktop. In other words, it appears that sites are not delivering significantly different HTML files for different devices or viewport sizes. On many ecommerce sites, home page HTML payloads are large. We don't know whether this is because of bloated HTML, or from other code (such as JSON) within HTML files.

## Image stats

<figure>
// Chart 13_06: Image payload by percentile (KB)
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=916461214
<figcaption>Figure 13. Image payload by percentile (KB).</figcaption>
</figure>

<figure>
// Chart 13_06: Number of image requests by percentile
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=916461214
<figcaption>Figure 14. Number of image requests by percentile.</figcaption>
</figure>

<figure>

|         | Number of images | Image payload (KB) |
|:--------|:-----------------|:-------------------|
| Mobile  | 37               | 1,517              |
| Desktop | 40               | 1,524              |

<figcaption>Figure 15. Median image usage for home pages on ecommerce platforms</figcaption>
</figure>

<figure>

|         | Number of images | Image payload (KB) |
|:--------|:-----------------|:-------------------|
| Mobile  | 90               | 5,993              |
| Desktop | 97               | 5,881              |

<figcaption>Figure 16. 90th percentile image usage for home pages on ecommerce platforms</figcaption>
</figure>

Note that the data here is for page load without scrolling.

This shows that the median page on an ecommerce platform (for home pages from the Web Almanac data) has 37 images and an image payload of 1,517.16 KB on mobile, 40 images and 1,524.56 KB on desktop. 10% of home pages have 90 or more images and an image payload of nearly 6 MB.

A significant proportion of home pages on ecommerce platforms have sizeable image payloads and make a large number of image requests on first load. See [httparchive.org/reports/state-of-images](https://httparchive.org/reports/state-of-images) for context on the state of images globally, and also the [media](./media) and [page weight](./page-weight) chapters. Website owners want their sites to look good on modern devices. As a result, many sites deliver the same high resolution product images to every user without regard for screen resolution or size. Developers may not be aware of (or not want to use) responsive techniques that enable efficient delivery of the best possible image to different users. It's worth remembering that high-resolution images may not necessarily increase conversion rates. Conversely, overuse of heavy images is likely to impact page speed and can thereby _reduce_ conversion rates. In the authors' experience from site reviews and events, some developers and other stakeholders have SEO or other concerns about using lazy loading for images.

We need to do more analysis to better understand why some sites are not using responsive image techniques or lazy loading. We also need to provide guidance that helps ecommerce platforms to reliably deliver beautiful images to those with high end devices and good connectivity — while providing a best-possible experience to lower-end devices and those with poor connectivity.

## Popular image formats

<figure>
// Chart 13_06b: Popular image formats
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1240367519
<figcaption>Figure 17. Popular image formats.</figcaption>
</figure>

<aside class="note">Note that some image services or CDNs will automatically deliver WebP (rather than JPEG or PNG) to platforms that support WebP, even for a URL with a `.jpg` or `.png` suffix. For example, this URL will return a WebP image in Chrome: [IMG_20190113_113201.jpg](https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg). However, HTTP Archive image format detection is done by checking for keywords in the MIME type first, then falling back to the file extension. The code for format detection is [here](https://github.com/HTTPArchive/legacy.httparchive.org/blob/31a25b9064a365d746d4811a1d6dda516c0e4985/bulktest/batch_lib.inc#L994). This means that the format for images with URLs such as the above will be given as WebP, since WebP is supported by HTTP Archive as a user agent.</aside>

### PNG

The high number of PNG requests from pages on ecommerce platforms is probably for product images. Many commerce sites use PNG with photographic images to enable transparency.

Using WebP with a PNG fallback can be a far more efficient alternative, either via a [picture element](http://simpl.info/picturetype) or by using user agent capability detection via an image service such as [Cloudinary](https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg).

### WebP

The data shows very few sites on ecommerce platforms using WebP, which tallies with the authors' experience of site reviews and partner work. WebP is [supported by all modern browsers other than Safari](https://caniuse.com/#feat=webp) and has good fallback mechanisms available. WebP supports transparency and is a far more efficient format than PNG for photographic images (see PNG section above).

### Pushing to use WebP more

We as a web community can provide better guidance/advocacy for enabling transparency using WebP with a PNG fallback and/or using WebP/JPEG with a solid color background. WebP appears to be rarely used on ecommerce platforms even though several guides to WebP usage are available (such as [web.dev/serve-images-webp](https://web.dev/serve-images-webp)) as well as apps and tools including [Squoosh](https://squoosh.app/) and [cwebp](https://developers.google.com/speed/webp/docs/cwebp). We need to do further research into why there hasn't been more take-up of WebP, which is now [nearly 10 years old](https://blog.chromium.org/2010/09/webp-new-image-format-for-web.html).

## Image dimensions

<figure>
// Chart 13_06c: Image dimensions
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1050583521
<figcaption>Figure 18. Image dimensions by percentile.</figcaption>
</figure>

<figure>

| Percentile | Mobile width | Mobile height | Desktop width | Desktop height |
|:-----------|:-------------|:--------------|:--------------|:---------------|
| 10         | 16           | 16            | 16            | 16             |
| 25         | 100          | 64            | 100           | 60             |
| 50         | 247          | 196           | 240           | 192            |
| 75         | 364          | 320           | 400           | 331            |
| 90         | 693          | 512           | 800           | 546            |

<figcaption>Figure 19. Image dimensions for home pages on ecommerce platforms.</figcaption>
</figure>

The median ('mid-range') dimensions for images requested by home pages on ecommerce platforms is 247x196 px on mobile and 240x192 px on desktop. 10% of images requested by home pages on ecommerce platforms are at least 693x512 px on mobile and 800x546 px on desktop.

Note that these dimensions are the intrinsic sizes of images, not their display size. The median dimensions for images on ecommerce platforms are 247x196 px on mobile, 240x192 px on desktop though 10% of images for pages on ecommerce platforms are at least 693x512 px on mobile and 800x546 px on desktop.

Given that image dimensions at each percentile up to the median are similar on mobile and desktop, or even slightly _larger_ on mobile in some cases, it would seem that many sites are not delivering different image dimensions for different viewports — in other words, not using responsive image techniques. The delivery of _larger_ images to mobile in some cases may (or may not!) be explained by sites using device or screen detection.

We need to do more research into why many sites are (apparently) not delivering different image sizes to different viewports.

## Third party requests and bytes

Many websites — especially online stores — load a significant amount of code and content from third parties: for analytics, A/B testing, customer behavior tracking, advertising and social media support. Third party content can have a [significant impact on performance](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript). [Patrick Hulce](https://twitter.com/patrickhulce)'s [third-party-web tool](https://github.com/patrickhulce/third-party-web) is used to determine third party requests for this report, and this is discussed more in the [./third-party](Third Party chapter) written by Patrick.

<figure>
// Chart 13_09: Third party requests and bytes
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1605504516
<figcaption>Figure 20. Requests for third party content.</figcaption>
</figure>

<figure>
// Chart 13_09: Third party requests and bytes
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1605504516
<figcaption>Figure 21. Total third party payload.</figcaption>
</figure>

<figure>
  <!-- HTML used here in order to enable colspans -->
  <table>
    <tr>
      <td></td>
      <td colspan="2"><strong>Number of requests</strong></td>
      <td colspan="2"><strong>Payload (KB)</strong></td>
    </tr>
    <tr>
      <td><strong>Percentile</strong></td>
      <td><strong>Mobile</strong></td>
      <td><strong>Desktop</strong></td>
      <td><strong>Mobile</strong></td>
      <td><strong>Desktop</strong></td>
    </tr>
    <tr>
      <td><strong>10</strong></td>
      <td>4</td>
      <td>4</td>
      <td>33.05</td>
      <td>41.51</td>
    </tr>
    <tr>
      <td><strong>25</strong></td>
      <td>8</td>
      <td>9</td>
      <td>118.44</td>
      <td>129.39</td>
    </tr>
    <tr>
      <td><strong>50</strong></td>
      <td>17</td>
      <td>19</td>
      <td>292.61</td>
      <td>320.17</td>
    </tr>
    <tr>
      <td><strong>75</strong></td>
      <td>32</td>
      <td>34</td>
      <td>613.46</td>
      <td>651.19</td>
    </tr>
    <tr>
      <td><strong>90</strong></td>
      <td>50</td>
      <td>54</td>
      <td>1016.45</td>
      <td>1071.3</td>
    </tr>
  </table>
  <figcaption>Figure 22. Total third party requests for home pages on ecommerce platforms.</figcaption>
</figure>

The median ('mid-range') home page on an ecommerce platform makes 17 requests for third party content on mobile and 19 on desktop. 10% of all home pages on ecommerce platforms make over 50 requests for third-party content, with a total payload of over 1 MB.

[Other studies](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript/) indicated that third party content can be a major performance bottleneck. This study shows that 17 or more requests (50 or more for the top 10%) is the norm for home pages on ecommerce platforms.

## Third party requests and payload per platform

Note the charts and tables below show data for mobile only.

<figure>
// Chart 13_09b: 3P requests/bytes per platform
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=281168323
<figcaption>Figure 23. Third party requests from mobile home pages.</figcaption>
</figure>

<figure>

|             | 10 | 25 | 50 | 75  | 90  |
|:------------|:---|:---|:---|:----|:----|
| WooCommerce | 4  | 8  | 16 | 29  | 47  |
| Shopify     | 35 | 49 | 71 | 100 | 134 |
| Magento     | 4  | 9  | 17 | 29  | 44  |
| PrestaShop  | 3  | 7  | 13 | 23  | 34  |
| Bigcommerce | 24 | 33 | 48 | 73  | 99  |
| Shopware    | 3  | 6  | 12 | 20  | 30  |

<figcaption>Figure 24. Number of third requests at each percentile.</figcaption>
</figure>

<figure>
// Chart 13_09b: 3P requests/bytes per platform
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=281168323
<figcaption>Figure 25. Total third party payload for mobile home pages.</figcaption>
</figure>

<figure>

|             | 10  | 25    | 50    | 75    | 90    |
|:------------|:----|:------|:------|:------|:------|
| WooCommerce | 28  | 110   | 266   | 580   | 934   |
| Shopify     | 788 | 1,225 | 1,962 | 3,234 | 5,601 |
| Magento     | 32  | 120   | 279   | 523   | 831   |
| PrestaShop  | 19  | 95    | 221   | 445   | 691   |
| Bigcommerce | 379 | 761   | 1,475 | 2,459 | 3,946 |
| Shopware    | 18  | 74    | 170   | 334   | 621   |

<figcaption>Figure 26. Payload size (KB) at each percentile.</figcaption>
</figure>

Platforms such as Shopify may extend their services using client-side JavaScript, whereas other platforms such as Magento use more server side extensions. This difference in architecture affects the figures seen here.

Clearly, home pages on some platforms make more requests for third party content and incur a larger total third party payload. Further analysis could be completed on why home pages from some platforms make more requests and have larger third party payloads than others.

## Third party requests and payload per category

<figure>
// Chart 13_09c: 3P requests/bytes per category
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=842081746
<figcaption>Figure 27. Median number of third party requests from home pages.</figcaption>
</figure>

<figure>
// Chart 13_09c: 3P requests/bytes per category
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=842081746
<figcaption>Figure 28. Median total third party payload.</figcaption>
</figure>

'Hosting' in these charts refers to files used by the platforms themselves, such as boilerplate JavaScript and CSS. Video libraries constitute the largest number of requests and by far the largest payload size of third party content for home pages on ecommerce platforms (apart from files used by the platforms themselves — the 'Hosting' category).

## Analytics, reviews and user behavior monitoring

<figure>
// Charts • 13_10: Top analytics providers > 1%, https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1232567425
<figcaption>Figure 29. Analytics, review and user behavior monitoring.</figcaption>
</figure>

<figure>
// Charts • 13_10: Top analytics providers non-Google, https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1585341764
<figcaption>Figure 30. Analytics, review and user behavior monitoring — other than Google.</figcaption>
</figure>

138 analytics providers were found, 131 of which get less than 1% of all requests. Of these, more than 100 get less than 0.1% of requests. Google Analytics gets around ten times as many requests (and pages) as the second most popular provider, Hotjar.

## Top ad providers

<figure>
// Chart 13_11: Top ad providers >=1%
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1621252176

<figcaption>Figure 31. Top ad providers.</figcaption>
</figure>

246 ad providers were detected on home pages on ecommerce platforms. Of these, 12 get more than 1% of all requests on either mobile or desktop. 127 providers get less than 0.01% of ad requests from home pages on ecommerce platforms.

## First Contentful Paint (FCP)

See the [performance chapter](./performance) for comparative data.

<figure>

|                     | Total pages | Fast | Average | Slow |
|:--------------------|:------------|:-----|:--------|:-----|
| WooCommerce desktop | 135,290     | 26%  | 37%     | 37%  |
| WooCommerce mobile  | 156,666     | 22%  | 34%     | 43%  |
| Shopify desktop     | 61,274      | 53%  | 36%     | 11%  |
| Shopify mobile      | 66,182      | 47%  | 40%     | 14%  |
| Magento desktop     | 48,358      | 31%  | 43%     | 26%  |
| Magento mobile      | 50,262      | 23%  | 46%     | 31%  |
| PrestaShop desktop  | 31,709      | 36%  | 43%     | 21%  |
| PrestaShop mobile   | 37,256      | 28%  | 46%     | 27%  |
| Bigcommerce desktop | 8,327       | 51%  | 40%     | 9%   |
| Bigcommerce mobile  | 8,435       | 43%  | 45%     | 11%  |
| Shopware desktop    | 4,275       | 52%  | 35%     | 12%  |
| Shopware mobile     | 4,919       | 47%  | 40%     | 12%  |

<figcaption>Figure 32. First Contentful Paint for top ecommerce platforms.</figcaption>
</figure>

<figure>
// Chart 13_08: CrUX FCP
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=498270258
<figcaption>Figure 33. Top six ecommerce platforms: First Contentful Paint.</figcaption>
</figure>

'Total pages' is the total number of home pages retrieved while data was being gathered for this study. For example, 135,290 desktop requests were for home pages on sites built using the WooCommerce platform. [First Contentful Paint](https://developers.google.com/web/tools/lighthouse/audits/first-contentful-paint) measures the time it takes from navigation until content such as text or an image is first displayed. In this context, 'fast' means FCP in under one second, 'slow' means FCP in 2.5 seconds or more, 'average' is everything in between. Note that third party content and code may have a significant impact on FCP.

All top-six ecommerce platforms have worse FCP on mobile than desktop: less 'fast', more 'slow'. Note that FCP is affected by device capability (processing power, memory, etc.) as well as connectivity.

We need to establish why FCP is worse on mobile than desktop. What are the causes: connectivity and/or device capability — or something else?

## SEO Indexability

See also the [SEO chapter](./seo) for more information on this topic beyond just ecommerce sites.

<figure>
// Charts 13_12: SEO Indexability, _pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1788076260
<figcaption>Figure 34. Search engine indexability of home pages on commerce platforms.</figcaption>
</figure>

97.35% of mobile home pages on ecommerce platforms pass the [Lighthouse SEO audit](https://developers.google.com/web/tools/lighthouse/audits/indexing): they do not have HTTP headers or meta tags that block indexing. Note that Lighthouse API SEO audit results are only available for mobile. 0.57% of home pages on ecommerce platforms block indexing. Lighthouse was unable to the SEO audit for 2.08% of home pages.


## Progressive Web App (PWA) scores

See also the [PWA chapter](./pwa) for more information on this topic beyond just ecommerce sites.

<figure>
// Chart 13_13: PWA scores, https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=1548616265
<figcaption>Figure 35. Lighthouse PWA scores.</figcaption>
</figure>

More than 60% of home pages on ecommerce platforms get a [Lighthouse PWA score](https://developers.google.com/web/ilt/pwa/lighthouse-pwa-analysis-tool) between 25 and 35. Less than 20% of home pages on ecommerce platforms get a score of more than 50 and less than 1% of home pages score more than 60.

Lighthouse returns a Progressive Web App (PWA) score between zero and 100. Zero is the worst possible score, and 100 is the best. The PWA audits are based on the [Baseline PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist), which lists 14 requirements. Lighthouse has automated audits for 11 of the 14 requirements. The remaining 3 can only be tested manually. Each of the 11 automated PWA audits are weighted equally, so each one contributes approximately 9 points to your PWA score.

If at least one of the PWA audits got a null score, Lighthouse nulls out the score for the entire PWA category. This was the case for 2.32% of home pages.

Clearly, most home pages on ecommerce platforms are failing most [PWA checklist audits](https://developers.google.com/web/progressive-web-apps/checklist). We need to do further analysis to better understand which audits are failing and why.

## Conclusion

This comprehensive study of ecommerce usage for the sites crawled by HTTP Archive shows some interesting data and also the wide variations in ecommerce sites - even those built on the same ecommerce platform. Even though we have gone into a lot of detail here, there is much more analysis we could do in this space. For example, we didn't get accessibility scores this year (checkout the [accessibility chapter](./accessibility) for more on that). Next year, we should look at this and likewise, for geographical data. This study detected 246 ad providers on home pages on ecommerce platforms. Further studies (perhaps in next year's Web Almanac?) could calculate what proportion of sites on ecommerce platforms shows ads. WooCommerce got very high numbers in this study so another interesting statistic we could look at next year is if some hosting providers are installing WooCommerce but not enabling it, thereby causing inflated figures.
