---
part_number: III
chapter_number: 13
title: Ecommerce
description: Ecommerce chapter of the 2019 Web Almanac covering ecommerce platforms, payloads, images, third parties, performance, seo, and PWAs
authors: [samdutton, alankent]
reviewers: [voltek62]
published: 2019-11-04T12:00:00+00:00:00
last_updated: 2019-11-04T12:00:00+00:00:00 
---

## Introduction

Nearly 10% of the home pages in this study were found to be on an ecommerce platform. An 'ecommerce platform' is a set of software or services that enables you to create and operate an online store. There are several types of ecommerce platform. For example:

-  Paid-for services such as [Shopify](https://www.shopify.com/) that host your store and help you get started. They provide website hosting, site and page templates, product-data management, shopping carts and payments.
-  Software platforms such as [Magento Open Source](https://magento.com/products/magento-open-source) which you set up, host and manage yourself. These platforms can be powerful and flexible but may be  more complex to set up and run than services such as Shopify.
-  Hosted platforms such as [Magento Commerce](https://magento.com/products/magento-commerce) that offer the same features as their self-hosted counterparts, except that hosting is managed as a service by a third party.

This analysis could only detect sites built on an ecommerce platform. This means that most large online stores and marketplaces — such as Amazon, JD, and eBay — are not included here. Also note that the data here is for home pages only: not category, product or other pages.

## Platform detection

How do we check if a page is on an ecommerce platform?

Detection is done through Wappalyzer. Wappalyzer is a cross-platform utility that uncovers the technologies used on websites. It detects content management systems, eCommerce platforms, web servers, JavaScript frameworks, analytics tools and many more.[wappalyzer.com/categories/ecommerce](https://www.wappalyzer.com/categories/ecommerce). Wappalayzer signals are available at [github.com/AliasIO/Wappalyzer/blob/master/src/apps.json](https://github.com/AliasIO/Wappalyzer/blob/master/src/apps.json).

Page detection is not always reliable, and some sites explicitly block detection to protect against automated attacks. We might not be able to catch all websites that use a particular ecommerce platform, but we're confident that the ones we do detect are actually on that platform.

<figure>

|                                   | Mobile    | Desktop   |
|:----------------------------------|:----------|:----------|
| Home pages on all sites           | 5,297,442 | 4,371,973 |
| Home pages on ecommerce platforms | 500,595   | 424,441   |
| Percentage on ecommerce platforms | 9.45%     | 9.70%     |

<figcaption>Figure 1. Total home pages requested in this study</figcaption>
</figure>

## Ecommerce platforms found in this study

The Web Almanac study detected home pages on a total of 116 ecommerce platforms. Of these platforms, six got more than 0.1% each of all web page requests in this study, on either desktop or mobile. In addition, these results do not show variation by country, by size of site, or other similar metrics.

**Please note, as stated above, platform detection is not always reliable. Notably, OpenCart often appears in top platform lists but had a lower rate of page detection in this study. [BuiltWith](https://trends.builtwith.com/shop), for example, lists OpenCart as the fourth most popular ecommerce platform. This may be a result of the data in this study being limited to home pages.**

<figure>
// Chart 13_02: Top shops
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit#gid=1984468159
<figcaption>Figure 2. Percentage of home pages on e-commerce platforms.</figcaption>
</figure>

<figure>

|             | Mobile | Desktop |
|:------------|:-------|:--------|
| WooCommerce | 3.98   | 3.90    |
| Shopify     | 1.59   | 1.72    |
| Magento     | 1.10   | 1.24    |
| PrestaShop  | 0.91   | 0.87    |
| Bigcommerce | 0.19   | 0.22    |
| Shopware    | 0.12   | 0.11    |

<figcaption>Figure 3. Top six ecommerce platforms detected in the Web Almanac study</figcaption>
</figure>


### Long tail

According to Web Almanac data there are 110 ecommerce platforms that each get less than 0.1% of either mobile or desktop page requests. Around 60 of these get less than 0.01% of page requests on mobile or desktop.

<figure>
// Chart 13_02: Number of home pages on each e-commerce platform
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit#gid=1618996184
<figcaption>Figure 4. Number of pages on each e-commerce platform: from the most popular to the least popular.</figcaption>
</figure>

7.87% of all requests on mobile and 8.06% on desktop are for home pages on one of the top six ecommerce platforms. A further 1.52% of requests on mobile and 1.59% on desktop are for home pages on the 110 other ecommerce platforms.

<figure>
// Chart 13_02: Percentage of home pages: top six versus long tail
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit#gid=1618996184
<figcaption>Figure 5. Percentage of home pages: top six versus long tail.</figcaption>
</figure>

## Ecommerce (all platforms)

### Mobile v desktop

In total, 9.39% of all requests on mobile and 9.65% on desktop in this study were for home pages on ecommerce platforms.

<figure>
// Chart 13_02b : % Ecommerce (any shop)
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit#gid=1618996184
<figcaption>Figure 6. Percentage of home pages on an e-commerce platform.</figcaption>
</figure>

Although the desktop proportion of requests was slightly higher overall, some popular platforms (including WooCommerce, PrestaShop and Shopware) actually got more mobile than desktop requests.

## Total payload and requests

'Payload' means all the bytes to load a page, including HTML, CSS, JavaScript, JSON, XML, images, audio and video.

<figure>
// Chart 13_09d: Total payload for pages on ecommerce platforms (MB)
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=2073072298
<figcaption>Figure 7. Total payload for pages on ecommerce platforms (MB).</figcaption>
</figure>

<figure>
// Chart 13_09d: Total requests for pages on ecommerce platforms
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=2073072298
<figcaption>Figure 8. Total requests for pages on ecommerce platforms.</figcaption>
</figure>

Note that, as explained above, this study only covers requests for home pages. Additionally, many successful ecommerce sites such as Amazon and eBay are designed so requests don't block content rendering — even though their pages make a large number of requests and have a heavy total payload. In other words, good performance is not just about smaller payloads and less requests!

The median desktop home page on an ecommerce platform loads 108 requests and 2.65 MB. The median for _all_ pages on desktop is [74 requests and 1.95 MB](https://httparchive.org/reports/page-weight#bytesTotal). In other words, median desktop home pages on ecommerce platforms from this study make nearly 50% more requests than other web pages, with payloads around 35% larger. By comparison, the [amazon.com](amazon.com) home page makes around 300 requests on first load, for a total payload of around 5 MB, and [ebay.com](ebay.com) makes around 150 requests for a total payload of approximately 3 MB. The total payload and number of requests for home pages on ecommerce platforms is slightly less on mobile at every percentile but around 10% of all home pages on ecommerce platforms load more than 7MB and make over 200 requests.

This data accounts for home page payload and requests without scrolling. Clearly there are a significant proportion of sites that appear to be retrieving more files (the median is over 100), with a larger total payload, than should be necessary for first load. See also: [Third party requests and bytes](#third-party-requests-and-bytes) below. 

We need to do further research to better understand why so many home pages on ecommerce platforms make so many requests and have such large payloads. The authors regularly see home pages on ecommerce platforms that make hundreds of requests on first load, with multi-megabyte payloads. If the number of requests and payload are a problem for performance, then how can they be reduced?

## Requests and payload by type

The charts below are for desktop requests:

<figure>
// Chart 13_09d: Ecommerce platforms: requests by type
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=878794652
<figcaption>Figure 9. Ecommerce platforms: payload by type.</figcaption>
</figure>

<figure>
// Chart: 13_09d • Ecommerce platforms: payload by type, https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=878794652
<figcaption>Figure 10. Ecommerce platforms: requests by type.</figcaption>
</figure>

Images constitute the largest number of requests and the highest proportion of payload for home pages on ecommerce platforms. The median desktop ecommerce home page includes 39 images weighing 1,513.67 KB.

The number of JavaScript requests indicates that better bundling (and/or [HTTP/2](./http2)) could improve performance. JavaScript files are not significantly large in terms of total payload, but many separate requests are made. [More than 40% of requests](./http2#user-content-adoption-of-http2) for all sites in this study are not via HTTP/2. CSS files similarly have the third highest number of requests but are generally small. Merging CSS files (and/or HTTP/2) could improve performance of such sites. In the authors' experience, many pages on ecommerce platforms have a high proportion of unused CSS and JavaScript. Videos may require a small number of requests, but (not surprisingly) consume a high proportion of the total bytes, particularly on sites with heavy payloads.

## HTML payload size

<figure>
// Chart 13_09d: Ecommerce platforms: distribution of HTML payload size
// https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/edit?ts=5d768aec#gid=81509282
<figcaption>Figure 11. Ecommerce platforms: distribution of HTML payload size.</figcaption>
</figure>

<figure>

| Percentile | 10    | 25    | 50    | 75    | 90     |
|:-----------|:------|:------|:------|:------|:-------|
| Desktop    | 12.45 | 19.8  | 35.56 | 66.08 | 117.74 |
| Mobile     | 11.44 | 18.63 | 33.8  | 64.01 | 115.85 |


<figcaption>Figure 12. HTML payload size (KB)</figcaption>
</figure>

Note that HTML payload may include other code such as JSON, JavaScript or CSS embedded directly in an HTML page itself, rather than referenced as external links. The median HTML payload size for home pages on ecommerce platforms is 33.8 KB on mobile and 35.56 KB on desktop. However, 10% of home pages on ecommerce platforms have an HTML payload of over 115 KB.

Mobile HTML payload sizes are not very different from desktop. In other words, it appears that sites are not delivering significantly different HTML files for different devices or viewport sizes. On many ecommerce sites, home page HTML payloads are large. It's not known from this study whether this is because of bloated HTML, or from other code (such as JSON) within HTML files.

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

Note that some image services or CDNs will automatically deliver WebP (rather than JPEG or PNG) to platforms that support WebP, even for a URL with a .jpg or .png suffix. For example, this URL will return a WebP image in Chrome: [res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg](https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg). However, HTTP Archive image format detection is done by checking for keywords in the MIME type first, then falling back to the file extension. The code for format detection is [here](https://github.com/HTTPArchive/legacy.httparchive.org/blob/31a25b9064a365d746d4811a1d6dda516c0e4985/bulktest/batch_lib.inc#L994). This means that the format for images with URLs such as the above will be given as WebP, since WebP is supported by HTTP Archive as a user agent.

### PNG

The high number of PNG requests from pages on ecommerce platforms is probably for product images. Many commerce sites use PNG with photographic images to enable transparency.

Using WebP with a PNG fallback can be a far more efficient alternative, either via a picture element (see [simpl.info/picturetype](http://simpl.info/picturetype)) or by using user agent capability detection via an image service such as Cloudinary (see [res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg](https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg)).

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
