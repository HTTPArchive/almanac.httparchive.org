---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Ecommerce
description: Ecommerce chapter of the 2020 Web Almanac covering ecommerce platforms, payloads, images, third-parties, performance, SEO, and PWAs.
authors: [rockeynebhwani, jrharalson]
reviewers: [alankent]
analysts: [jrharalson, rockeynebhwani]
editors: [tunetheweb]
translators: []
rockeynebhwani_bio: Rockey Nebhwani is an independent consultant who has worked in retail and ecommerce since 2001 and has extensive experience in the industry working with retailers like Amazon, Wal-Mart, Tesco, M&S, Safeway etc. across US and UK. Rockey is an occasional speaker at ecommerce events and also tweets at <a href="https://twitter.com/rnebhwani">@rnebhwani</a>.
#jrharalson_bio: TODO
discuss: 2052
results: https://docs.google.com/spreadsheets/d/1Hvsh_ZBKg2vWhouJ8vIzLmp0nLIMzrT2mr6RQbIkxqY/
featured_quote: Covid-19 massively accelerated the growth of ecommerce in 2020 and lot of smaller players had to establish online presence quickly and had to find ways to continue trading during lockdowns. Platforms like WooCommerce / Shopify / Wix / BigCommerce played very important role in bringing more and more small businesses online. Covid-19 also saw launch of D2C (direct to consumer) offerings by brand and this is expected to increase in future.
featured_stat_1: 21.27%
featured_stat_label_1: Mobile sites identified as ecommerce sites
featured_stat_2: 5.19%
featured_stat_label_2: Sites using WooCommerce the most popular ecommerce platform
featured_stat_3: 30
featured_stat_label_3: Median number of JavaScript requests ecommerce sites make
---

## Introduction

An "ecommerce platform" is a set of software or services that enables you to create and operate an online store. There are several types of ecommerce platforms, for example:

- Paid-for services such as Shopify that host your store and help you get started. They provide website hosting, site and page templates, product-data management, shopping carts and payments.
- Software platforms such as Magento Open Source which you set up, host and manage yourself. These platforms can be powerful and flexible but may be more complex to set up and run than services such as Shopify.
- Hosted platforms such as Magento Commerce that offer the same features as their self-hosted counterparts, except that hosting is managed as a service by a third-party.

Last year's analysis could only detect sites built on an ecommerce platform. This means that most large online stores and marketplaces—such as Amazon, JD, and eBay or any ecommerce sites built using in-house platforms (typically by bigger businesses) were not part of the analysis. For this year's analysis, this limitation was addressed by enhancing Wappalyzer's detection of ecommerce sites. See the [Platform detection](#platform-detection) section for more details.

Also note that the data here is for home pages only: not category, product or other pages. Learn more about our [methodology](./methodology).

## Platform detection

How do we check if a page is on an ecommerce platform? Detection is done through Wappalyzer. Wappalyzer is a cross-platform utility that uncovers the technologies used on websites. It detects content management systems, ecommerce platforms, web servers, JavaScript frameworks, analytics tools, and many more technologies.

Compared to 2019, you will notice that in 2020, % of ecommerce websites have increased significantly. This is primarily due to improved detection in Wappalyzer this year using secondary signals. These secondary signals include following:
- Sites using Google Analytics Enhanced Ecommerce tagging is counted as an ecommerce site.
- Secondary signal also includes looking for most commonly used patterns for identifying 'Cart' links.

This change in methodology provides enhanced coverage for enterprise platforms and sites built using headless solutions.

### Limitations

Our methodology has the following limitations:
- Headless ecommerce platforms like <a hreflang="en" href="https://commercetools.com/">commercetools</a> may not get detected as ecommerce platform but if we are able to detect presence of cart on such sites, we will still include sites using such platforms in our overall coverage stats.
- Technologies which are typically deployed outside homepages (e.g. WebAR on product detail pages) are not detected.
- Due to our crawl originating from US, there may be some bias towards US specific platforms. For example, if a global business has ecommerce sites built on different platforms for different countries (using country specific domains/sub-domains), it may not show these regional differences in our analysis.
- It's common for B2B sites to hide the cart functionality behind a login and due to that this study is not a correct representation of B2B market.

## Ecommerce platforms

{{ figure_markup(
  image="ecommerce-comparison-2019-to-2020.png",
  caption="Ecommerce comparison 2019 to 2020.",
  description="A bar chart showing desktop detection of ecommerce websites has increased from 9.67% of sites, to 21.72%. Mobile has similarly increased from 9.41% to 21.27%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1775630157&format=interactive",
  sheets_gid="856812465",
  sql_file="pct_ecommsites_bydevice_compare20192020.sql"
) }}

In total, 21.72% of mobile websites and 21.27% of desktop websites used an ecommerce platform. For 2019, the same number was 9.41% for mobile websites and 9.67% for desktop websites.

<p class="note">Note: This increase is primarily due to improvements made to Wappalyzer to detect ecommerce websites and shouldn't be attributed to other factors like growth due to Covid-19. Also a minor correction was applied to 2019 stats retrospectively to account for an error and hence the 2019 percentages are slightly different than those given in the <a href="../2019/ecommerce">2019 Ecommerce</a> chapter.</p>

### Top ecommerce platforms

{{ figure_markup(
  image="top-ecommerce-platforms.png",
  caption="Top ecommerce platforms.",
  description="A bar chart showing in descending order the usage of ecommerce platforms with WooCommerce at 5.12% on desktop and 5.19% on mobile, followed by Shopify (2.55% and 2.48% respectively), Wix (1.05% and 1.24%), Magento (1.03% and 0.96%), PrestaShop (0.91%, 0.94%), 1C-Bitrix (0.64% and 0.65%), Bigcommerce (0.24% and 0.21%), Cafe24 (0.21% and 0.12%), Shopware (0.14% for both), and Loja Integrade at 0.08% and 0.09% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=795567278&format=interactive",
  sheets_gid="872326386",
  sql_file="top_vendors.sql"
) }}

Our analysis counted 145 separate ecommerce platforms (compared to [116 in last year's analysis](../2019/ecommerce#ecommerce-platforms)). Out of these, only 9 platforms have market share of greater than 0.1%. WooCommerce is the most common ecommerce platform and has maintained its number one position. Wix appears in this analysis for the first time this year, after Wappalyzer started identifying it as ecommerce platform from 30th Jun 2019.

### Top enterprise ecommerce platforms

While it is difficult to discern a platform's precise tier let us highlight four vendors who focus heavily on the Enterprise tier—Salesforce, HCL, SAP, and Oracle.

{{ figure_markup(
  image="enterprise-ecommerce-platforms.png",
  caption="Enterprise ecommerce platforms (desktop).",
  description="A bar chart showing Salesforce Commerce Cloud by 2,653 and 3,347, HCL WebSphere Commerce is used by 2,268 desktop sites in 2019 and 2,604 in 2020, SAP Commerce Cloud by 1,979 and 2,371, and Oracle Commerce Cloud by 1,095 and 917.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=783560373&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Salesforce Commerce Cloud remains the leading platform from this group. The 3,437 desktop websites in 2020 represent a 29.5% increase from 2019's 2,653 desktop websites. Salesforce's websites account for 36.8% of the four enterprise ecommerce platforms.

HCL Technologies acquired WebSphere Commerce from IBM in July 2019. The transition had mixed results in 2020. While HCL's WebSphere Commerce increased their desktop website count by a 14.8% increase this year up to 2,604 from 2019's 2,268 desktop websites, there was a slip in popularity by 0.5% within this group down to 27.9%. Something to watch for in the future.

SAP Commerce Cloud, formally known as Hybris, remains the third most popular enterprise ecommerce platform at 25.4% which is a slight increase from last year's 24.8%. The 2,371 desktop websites is a 19.8% increase from the 1,979 desktop sites found in 2019 attributed to Hybris.

Lastly, Oracle Commerce Cloud unfortunately lost a bit of traction between 2019 and 2020. The desktop websites fell from 1,095 to 917, down 16%, and in turn their Enterprise ecommerce platform foothold fell from 13.7% to 9.8%.

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2019.png",
  caption="Enterprise ecommerce platforms - 2019 desktop",
  description="A pie chart showing Salesforce Commerce Cloud was used by 33.2% of the enterprise ecommerce market in 2019, HCL WebSphere Commerce by 28.4%, SAP Commerce Cloud by 24.8%, and Oracle Commerce Cloud by 13.7%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1864431795&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2020.png",
  caption="Enterprise ecommerce platforms - 2020 desktop",
  description="A pie chart showing Salesforce Commerce Cloud was used by 36.8% of the enterprise ecommerce market in 2020, HCL WebSphere Commerce by 27.9%, SAP Commerce Cloud by 25.4%, and Oracle Commerce Cloud by 9.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1013485197&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Shopify's Shopify Plus, Adobe's Magento Enterprise and Bigcommerce's Enterprise offerings are available and gaining traction but the Platform Detection limitations hamper any ability to isolate the Enterprise websites from their Community or Commercial websites.

## COVID-19 impact on ecommerce

COVID-19 has had a huge impact on the world and necessitated an even bigger move online. Measuring the total increase in ecommerce platforms is influenced by the greatly increased detection undertaken in part for this chapter. So instead we look at some of the platforms that were already being detected and note an increase in their usage - particularly since March 2020 when COVID started impacting large parts of the world:

{{ figure_markup(
  image="ecommerce-vendor-growth-covid-19-impact.png",
  caption="Ecommerce platform growth Covid-19 impact",
  description="A line chart showing the growth of five popular ecommerce platforms: WooCommerce, Shopify, Wix, Magento, and PrestaShop. WooCommerce shows a steady growth with a noticeable bump in February 2020 and again in June and July. Shopify shows similar but for a smaller percentage and the other three show less of such an impact.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1475961371&format=interactive",
  sheets_gid="535254570",
  sql_file="ecomm_vendors_covid_growth.sql"
) }}

There is definitely a measurable increase WooCommerce and Shopify sites around the time COVID started really impacting the world.

<p class="note">Note: <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/pull/2731/commits/f44f20f03618f6a5fd868dd38ce9db5e2e2f1407">Wappalyzer detection for Wix</a> doesn't differentiate if a site is using Wix as CMS or ecommerce platform. Due to this, growth of Wix as ecommerce platform may not be represented correctly in above graph.</p>

## Page weight and requests

The page weight of an ecommerce platform includes all HTML, CSS, JavaScript, JSON, XML, images, audio, and video.

{{ figure_markup(
  image="page-requests-distribution.png",
  caption="Page requests distribution.",
  description="A bar chart showing the number of requests, with the 10th percentile having 46 requests on desktop and 44 on mobile, the 25th percentile having 68 and 65 respectively, 50th having 103 and 98, 75th having 151 and 146, and 90th percentile having 217 on desktop and 208 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1278986228&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

{{ figure_markup(
  image="page-weight-distribution.png",
  caption="Page weight distribution.",
  description="A bar chart showing the page weight in MB, with the 10th percentile having 0.94 MB on desktop and 0.85 on mobile, the 25th percentile having 1.55 and 1.45 respectively, 50th having 2.62 and 2.48, 75th having 4.52 and 4.26, and 90th percentile having 7.89 MB on desktop and 7.3 MB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1078671906&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

Promisingly, mobile page weights have dropped across all percentiles [compared to 2019](../2019/ecommerce#page-weight-and-requests) while desktop page weights have remained the same more or less (except 90th percentile). Requests per page also dropped on mobile (9-11 requests less across all percentiles except 90th percentile) and on desktop.

Ecommerce sites are still larger in terms of requests and size compared to all sites, as shown in the [Page Weight](./page-weight) chapter.

### Page weight by resource type

Breaking this down by resource type, for median pages, we see that images and JavaScript requests dominate ecommerce pages:

{{ figure_markup(
  image="median-page-requests-by-type.png",
  caption="Median page requests by type.",
  description="A bar chart showing a requests per page for file type in decreasing order for the median page. Images are 37 requests on desktop and 34 on mobile, scripts are 31 and 30 respectively, css 8 for both, fonts 5 for both, other 4 for both, html 4 for both, video 3 for both, and xml, text and audio all 1 for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1680167507&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

However, when looking at actual bytes delivered, media are by far the largest assets:

{{ figure_markup(
  image="median-page-kilobytes-by-type.png",
  caption="Median page kilobytes by type.",
  description="A bar chart showing a kilobytes per page for file type in decreasing order for the median page. Images are 1,754 KB on desktop and 2,176 KB on mobile, scripts are 1,271 and 1,208 respectively, css 643 and 611, fonts 143 and 123, html 35 and 34, audio 14 and 9, xml 1 and 1 and text and other 0 for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1077946836&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

Video, despite accounting for a small number of requests, is by far largest resources on ecommerce sites, followed by images and then JavaScript.

### HTML payload size

{{ figure_markup(
  image="distribution-of-html-bytes-per-ecommerce-page.png",
  caption="Distribution of HTML bytes per ecommerce page",
  description="A bar chart showing the number of HTML kilobytes, with the 10th percentile having 12 KB on desktop and 13 KB on mobile, the 25th percentile having 20 and 21 respectively, 50th having 35 and 36, 75th having 76 and 74, and 90th percentile having 133 KB on desktop and 134 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1956748774&format=interactive",
  sheets_gid="1032303587",
  sql_file="pagestats_html_bydevice.sql"
) }}

Note that HTML payloads may include other code such as inline JSON, JavaScript, or CSS directly in the markup itself, rather than referenced as external links. The median HTML payload size for ecommerce pages is 35 KB on mobile and 36 KB on desktop. [Compared to 2019](../2019/ecommerce#html-payload-size), median payload size and 10th, 25th and 50th percentiles have remained approximately the same. However, at 75th and 90th percentile, we see an increase of approximately 10kb and 15kb respectively across mobile and desktop.

Mobile HTML payload sizes are not very different from desktop. In other words, it appears that sites are not delivering significantly different HTML files for different devices or viewport sizes.

### Image usage

Next, let's look at how images are used on ecommerce sites. Note that because our data collection methodology does not simulate user interactions on pages like clicking or scrolling, images that are lazy loaded would not be represented in these results.

{{ figure_markup(
  image="distribution-of-image-requests-for-ecommerce.png",
  caption="Distribution of image requests for ecommerce",
  description="A bar chart showing the number of image requests, with the 10th percentile having 14 requests on desktop and 12 on mobile, the 25th percentile having 22 and 20 respectively, 50th having 37 and 34, 75th having 60 and 56, and 90th percentile having 101 requests on desktop and 91 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=286315936&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-image-bytes-for-ecommerce.png",
  caption="Distribution of image bytes for ecommerce",
  description="A bar chart showing the number of image kilobytes, with the 10th percentile having 242 KB on desktop and 189 KB on mobile, the 25th percentile having 546 and 486 respectively, 50th having 1,271 and 1,208, 75th having 2,835 and 2,737, and 90th percentile having 5,819 KB on desktop and 5,459 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=416820889&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

The figures above show that the median ecommerce page has 34 images and an image payload of 1,208 KB on mobile, 37 images and 1,271 KB on desktop. 10% of home pages have 90 or more images and an image payload of nearly between 5.5 MB on mobile and 5.8MB on desktop.

[Compared to 2019](../2019/ecommerce#image-stats), both median image requests and median image payloads have seen a drop. Median image requests dropped by 3 for both mobile and desktop. Median image payload also dropped by approximately 200kb-250kb across mobile and desktop. This drop may be driven by sites adopting lazy loading techniques such as usage of the `loading="lazy"` attribute which is now <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">supported by more and more browsers</a>. This year's [Markup](./markup#data--attributes) chapter makes an observation usage for native lazy loading appears to be on the increase and around 3.86% of the pages use this in Aug-2020 and this has been on constant rise (as seen in [this tweet](https://twitter.com/rick_viscomi/status/1344380340153016321?s=20)).

#### Popular image formats

{{ figure_markup(
  image="popular-image-formats-on-ecommerce-sites.png",
  caption="Popular image formats on ecommerce sites",
  description="A bar chart showing image formats in descending order of popularity with mobile numbers showing jpg at 50.19%, png on 26.54%, gif at 17.35%, svg at 2.61%, webp at 1.17% and no format at 0.07%. Desktop usage looks to be near identical.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=753462591&format=interactive",
  sheets_gid="943479146",
  sql_file="pagestats_image_bydevice_format.sql"
) }}

<p class="note">Note that some image services or CDNs will automatically deliver WebP (rather than JPEG or PNG) to platforms that support WebP, even for a URL with a <code>.jpg</code> or <code>.png</code> suffix. For example, <code>IMG_20190113_113201.jpg</code> returns a WebP image in Chrome. However, the way HTTP Archive detects image formats is to check for keywords in the MIME type first, then fall back to the file extension. This means that the format for images with URLs such as the above will be given as WebP, since WebP is supported by HTTP Archive as a user agent.</p>

PNG usage remained roughly at the [same level as 2019](../2019/ecommerce#png) (at 27% for both desktop and mobile). We observed drop in JPEG usage (4% for desktop and 6% for mobile). Out of this drop, most of it went towards increased GIF usage. GIFs are quite common on ecommerce homepages whereas GIFs may not be much used on product detail pages. Since our methodology only looks at homepages, this explains the significantly high usage of GIFs across ecommerce sites. Lighthouse has an audit which recommends using "video formats for animated content". This is a technique ecommerce sites can use to optimize for performance but still retain animation properties of GIFs. See <a hreflang="en" href="https://web.dev/replace-gifs-with-videos/">this article</a> for more details.

WebP usage across ecommerce sites still remains very low though usage doubled and went from a total of 1% usage in 2019 to 2% usage in 2020. WebP format is now nearly 10 years old and even after allowing for progressive enhancement using the `picture` element, usage has remained low. In 2020, WebP got a new lease of life when Safari introduced support in <a hreflang="en" href="https://caniuse.com/webp">Safari 14</a>. However, the Web Almanac for this year is based on August 2020 and Safari support came in September 2020 so any stats presented here don't reflect the impact of support added by Safari.

This year, in Chrome 85 (released in August 2020), we also saw support for AVIF which is a <a hreflang="en" href="https://www.ctrl.blog/entry/webp-avif-comparison.html">more efficient image format compared to WebP</a>. In next year's analysis, we hope to cover AVIF usage across ecommerce sites. Similar to WebP, AVIF is also a progressive enhancement and can be implemented using the `picture` element to address <a hreflang="en" href="https://caniuse.com/avif">cross-browser concerns</a>.

As per the author's experience, there is a lack of awareness in engineering teams about image optimization services offered by CDNs where CDNs can do most of the heavy lifting without touching any code. For example, Adobe Scene7 offers this under their <a hreflang="en" href="https://helpx.adobe.com/uk/experience-manager/6-3/assets/using/imaging-faq.html">Smart Imaging solution</a>. Clients on Salesforce Commerce Cloud using the platform's embedded CDN capability (which uses Cloudflare) can enable this with a simple toggle. By increasing the awareness of such solutions, we can try to move the needle in favor of more efficient formats.

Another point for readers who are interested in improving CRUX metrics with images sizes/formats, currently progressive images provides no weightage towards Largest Contentful Paint despite being helpful for user-perceived performance. There is a fascinating <a hreflang="en" href="https://github.com/WICG/largest-contentful-paint/issues/68">discussion</a> in the community on this topic and in the future it is possible that progressive images will contribute towards LCP. There may be renewed interest in the ecommerce community towards formats supporting progressive loading due to this and inclusion of Core Web Vitals in Page Experience signals from May 2021.

### Third-party requests and bytes

Ecommerce platforms and sites often make use of [third-party](./third-party) content. We use the [Third Party Web project](./methodology#third-party-web) to detect third-party usage.

{{ figure_markup(
  image="distribution-of-third-party-requests.png",
  caption="Distribution of third-party requests",
  description="A bar chart showing the number of third-party requests for ecommerce sites, with the 10th percentile having 8 requests on desktop and 7 on mobile, the 25th percentile having 16 and 15 respectively, 50th having 32 and 30, 75th having 60 and 58, and 90th percentile having 103 third-party requests on desktop and 98 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1577985571&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-third-party-bytes.png",
  caption="Distribution of third-party bytes",
  description="A bar chart showing the number of third-party kilobytes for ecommerce sites, with the 10th percentile having 88 KB on desktop and 67 KB on mobile, the 25th percentile having 242 and 208 respectively, 50th having 547 and 489, 75th having 1,179 and 1,098, and 90th percentile having 2,367 KB on desktop and 2,155 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1165664044&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

We see a significant increase in the use of third-party requests and bytes [compared to last year's third-party data](../2019/ecommerce#third-party-requests-and-bytes), but have been unable to identify any particular cause or notable change in detection. We'd love to hear <a hreflang="en" href="https://discuss.httparchive.org/t/2052">readers opinions</a> on this as third-party usage seems to have basically doubled in the last year!

## Ecommerce user experience

Ecommerce is all about converting customers and in order to do that a fast performing website is paramount. In this section, we try to shed light on real-world user experience of ecommerce websites. To achieve this, we turn our analysis towards some user-perceived performance metrics, which are captured in the three <a hreflang="en" href="https://web.dev/vitals/">Core Web Vitals</a> metrics.

### Chrome User Experience Report

In this section we take a look at three important factors provided by the [Chrome User Experience Report](./methodology#chrome-ux-report), which can shed light on our understanding of how users are experiencing ecommerce websites in the wild:

- Largest Contentful Paint (LCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)

These metrics aim to cover the core elements which are indicative of a great web user experience. The [Performance](./performance) chapter covers these in more detail, but here we are interested in looking at these metrics specifically for ecommerce websites. Let's review each of these in turn.

#### Largest Contentful Paint

Largest Contentful Paint (LCP) measures the point when the page's main content has likely loaded and thus the page is useful to the user. It does this by measuring the render time of the largest image or text block visible within the viewport.

This is different to First Contentful Paint (FCP), which measures from page load until content such as text or an image is first displayed. LCP is regarded as a good proxy for measuring when the main content of a page is loaded.

In the context of ecommerce, this metric provides very good indication of most useful content for the users (e.g. Hero banner image for landing pages, Image of 1st product displayed on a search/listings pages, Product image in case of a product detail page). Before this metric, sites had to explicitly instrument sites in their RUM solution but this metric democratizes the measurement for anybody who may not have resources or expertise to do this.

{{ figure_markup(
  image="ecommerce-real-user-largest-contentful-paint-experiences.png",
  caption="Real-user Largest Contentful Paint experiences",
  description="A bar chart showing the number of sites with a good LCP score for the top 5 most popular ecommerce platforms. WooCommerce has 21.73% for desktop and 14.27% for mobile, Shopify has 64% and 47.47% respectively, Magento has 39.45% and 28.17%, Wix has 7.46% and 7.40%, and PrestaShop has 53.03% on desktop and 38.08% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1881724605&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

We see large degrees of variability across the major platforms with Wix, and WooCommerce in particular scoring very low. As two of the three most used ecommerce platforms, it seems they have some improvements to make!

#### First Input Delay

First Input Delay (FID) attempts to measure interactivity, or more importantly any barriers to interactivity when a page is unresponsive while busy processing the page.

{{ figure_markup(
  image="ecommerce-real-user-first-input-delay-experiences.png",
  caption="Real-user First Input Delay experiences",
  description="A bar chart showing the number of sites with a good LCP score for the top 5 most popular ecommerce platforms. WooCommerce has 99.95% for desktop and 92.36% for mobile, Shopify has 99.96% and 96.49% respectively, Magento has 99.99% and 89.02%, Wix has 88.30% and 37.95%, and PrestaShop has 99.93% on desktop and 92.96% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=490091603&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

In general FID scores are typically higher than the other Core Web Vitals, and it is promising that ecommerce sites, despite making use of a lot of Media and JavaScript as we've seen earlier, maintain high scores in this category.

#### Cumulative Layout Shift

Cumulative Layout Shift (CLS) measures how much the page "jumps about" as new content is loaded and placed into the page. From our crawls this will be limited to initial page load above "the fold", but ecommerce sites should understand that below the page fold or other interactions may impact CLS more than our stats show.

{{ figure_markup(
  image="ecommerce-real-user-cumulative-layout-shift-experiences.png",
  caption="Real-user Cumulative Layout Shift experiences",
  description="A bar chart showing the number of sites with a good LCP score for the top 5 most popular ecommerce platforms. WooCommerce has 37.98% for desktop and 51.40% for mobile, Shopify has 40.72% and 40.55% respectively, Magento has 38.11% and 38.28%, Wix has 58.15% and 57.47%, and PrestaShop has 51.56% on desktop and 49.83% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1137826141&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

About half ecommerce sites have good CLS scores and interestingly there is little difference between mobile and desktop, despite the usual convention that mobile devices are usually under powered and often experience variable network changes.

#### Core Web Vitals overall

Looking at Core Web Vitals overall, for which sites pass all three core metrics we see the following:

{{ figure_markup(
  image="ecommerce-real-user-core-web-vitals-exeriences.png",
  caption="Real-user Core Web Vitals experiences",
  description="A bar chart showing the number of sites with a good LCP score for the top 5 most popular ecommerce platforms. WooCommerce has 10.72% for desktop and 8.63% for mobile, Shopify has 28.78% and 21.24% respectively, Magento has 18.33% and 11.14%, Wix has 5.23% and 3.30%, and PrestaShop has 30.43% on desktop and 19.10% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=733851599&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

This is very similar to the LCP chart earlier, perhaps somewhat unsurprisingly since it was the one with the most variability and the most sites that failed this metric.

## Tools

How are ecommerce sites using common tools like Analytics, Tag Managers, Consent Management Platforms and Accessibility solutions?

### Analytics

{{ figure_markup(
  image="top-analytics-solutions-on-ecommerce-sites.png",
  caption="Top analytics solutions on ecommerce sites",
  description="A bar chart showing the top Analytics providers for ecommerce platforms in descending order. For mobile Google Analytics has 77% usage, GA Enhanced eCommerce has 22%, Hotjar has 6%, New Relic has 4%, TrackJs has 3%, Yandex.Metrika has 3%, Matomo Analytics has 2%, BugSnag has 2%, Liveinternet has 2%, comScore has 1%, and Quantcast Measure has 1%. Desktop usage looks near identical.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=431305389&format=interactive",
  sheets_gid="618573782",
  sql_file="top_analytics_bydevice_vendor.sql"
) }}

Google Analytics scores highly unsurprisingly at 77% of mobile ecommerce sites, but what is perhaps more surprising is that Google Analytics Enhanced Ecommerce is only used by 22% of ecommerce sites, reflecting either an opportunity for 55% of sites to get more out of their Google Analytics, or perhaps reflecting another limitation of our methodology which is limited to home pages as some sites may only load this on checkout funnels.

HotJar is another tool often used by ecommerce sites to analyze and improve usage of the site, and so conversions but usage is very low at 6% of mobile sites.

### Tag Managers

Google Tag Manager remains the most used tag manager on ecommerce sites followed by Adobe Tag Manager. We don't expect this to change due to free nature of Google Tag Manager. In August 2020, Google also launched <a hreflang="en" href="https://developers.google.com/tag-manager/serverside">server side tagging</a> in Google Tag Manager. Implementing server-side tagging will incur a small cost for ecommerce sites but it can help sites eliminate third-party overhead and thus improving metrics like Total Blocking Time (TBT), First Input Delay (FID) and Time to Interactive (TTI). Simon Ahava has <a hreflang="en" href="https://www.simoahava.com/analytics/server-side-tagging-google-tag-manager/">lot of useful information on his blog</a> which we recommend to readers.

Adoption of server-side tagging will depend on third parties to provide server side templates to make the migration easier. These are early days for GTM server-side tagging and at the time of writing this chapter, we didn't find any server-side templates in publicly available <a hreflang="en" href="https://tagmanager.google.com/gallery/#/?context=server&page=1">community gallery</a>. But if the adoption increases, it will be interesting to compare the performance scores of sites using client-side vs server-side tagging. Other vendors like Adobe, Signal also offer similar server-side solutions which sites should consider adopting to help with performance.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Tag Manager</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Tag Manager</td>
        <td class="numeric">48.45%</td>
        <td class="numeric">46.56%</td>
      </tr>
      <tr>
        <td>Adobe DTM</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td>Ensighten</td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>TagCommander</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td>Signal</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>Matomo Tag Manager</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Yahoo! Tag Manager</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Total</th>
        <th scope="col" class="numeric">49.14%</th>
        <th scope="col" class="numeric">47.20%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>{{ figure_link(caption="Tag manager usage on ecommerce sites.", sheets_gid="2045910168", sql_file="percent_of_ecommsites_using_each_tag_managers.sql") }}</figcaption>
</figure>

<p class="note">Note: Above analysis is based on Wappalyzer detection which may differ from analysis done using <a href="./methodology#third-party-web">Third Party Web</a> dataset which is used for <a href="./third-parties">Third parties</a> chapter.</p>

### Consent Management Platforms

This year's [Privacy](./privacy) chapter covered the adoption of Consent Management Platforms across all types of websites. When we compare adoption on ecommerce sites versus all sites, we see a slightly higher adoption both across mobile (4.2% on ecommerce sites Vs 4.0% on all sites)  and desktop (4.6% on ecommerce sites Vs 4.4% on all sites).

{{ figure_markup(
  image="ecommerce-consent-management-platform-adoption.png",
  caption="Consent Management Platform adoption",
  description="A bar chart showing that 4.4% of all desktop websites and 4.0% of mobile sites use a Consent Management Platform, compared to 4.6% and 4.2% respectively for ecommerce sites. So ecommerce sites have slightly higher usage of CMPs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=285357141&format=interactive",
  sheets_gid="1374272999",
  sql_file="percent_of_ecommsites_using_cmp.sql"
) }}

In terms of share of various CMPs, the trend for ecommerce websites was similar as all websites covered in [Privacy](./privacy) chapter. In future editions of the Web Almanac, we expect this adoption to increase as more and more countries come up with their own regulations. Also, "Content Management Platform" was recently added to Wappalyzer by the Web Almanac team. Though the team added most popular CMPs, with time we expect additional CMPs to be added and hence expected increase in adoption stats.

### Accessibility solutions

In this year's [Accessibility](./accessibility) Chapter introduction, the Web Almanac team talks about dangers of implementing quick fix accessibility solutions and points to Lainey Feingold's brilliant article, <a hreflang="en" href="https://www.lflegal.com/2020/08/quick-fix/">Honor the ADA: Avoid Web Accessibility Quick Fix Overlays</a>.

Though not recommended, we looked at usage of such solutions across ecommerce websites and found that 0.47% of mobile websites and 0.54% of desktop websites have deployed such solutions.

In the current methodology adopted for this chapter, there is no easy way for us to look at if any top ecommerce websites have gone this quick fix route instead of trying to achieve accessibility by design. It will be possible to find out this in future by combining HTTP Archive data with publications like Top 500 UK sites by International retailing or similar publications.

### AMP adoption

{{ figure_markup(
  caption="AMP usage on ecommerce sites (mobile).",
  content="0.61%",
  classes="big-number",
  sheets_gid="1317152621",
  sql_file="pct_ampusage_bydevice_vendor.sql"
)
}}

In the SEO chapter we covered stats on [AMP usage across all websites](./seo#amp). In this chapter, we look at AMP adoption on ecommerce websites. AMP adoption remains low across ecommerce websites (0.61% on mobile and 0.66% on desktop) as AMP still doesn't support all ecommerce use cases. Also, in this analysis, we rely on detection using Wappalyzer and this may result in double counting of ecommerce sites where AMP is implemented as a different domain using `<link rel="amphtml"...>` element. This shouldn't be an issue while looking at percentages as such domains are also counted twice while coming up with total ecommerce websites.

We also considered looking at CRUX performance of ecommerce websites with their AMP counterpart (where implemented on a different domain using `amphtml` attribute). Such an analysis will help us identify if there was a significant difference in performance of AMP domain, but due to low adoption rates of AMP across ecommerce websites, such an analysis may not give any meaningful results and we deferred the analysis for future years (if adoption rates increase).

### Web Push notifications

Marketeers love push notifications but as per author's experience that awareness among marketeers about web push notifications is still very low in spite of <a hreflang="en" href="https://developers.google.com/web/updates/2015/03/push-notifications-on-the-open-web">Push API</a> being introduced in 2015 for the first time in Chrome. We tried to look at adoption of web push notifications (which are possible using technologies like service workers) on ecommerce sites. As part of CRUX notifications permission data, we have access to metrics like push acceptance rates, push prompts dismissal rates. Please refer <a hreflang="en" href="https://developers.google.com/web/updates/2020/02/notification-permission-data-in-crux">this Google article</a> for more details on how this data is captured and what metrics are available.

In our analysis, we found that only 0.68% of desktop ecommerce sites and 0.69% of mobile ecommerce sites use web push notifications. When it comes to push notifications, it's important that customers find push notifications useful. Key to this is to request permission at right time in customer journey and not to bombard users with irrelevant notifications. To address the customer fatigue with push notifications, Chrome will automatically enroll sites with very low acceptance rates into <a hreflang="en" href="https://blog.chromium.org/2020/05/protecting-chrome-users-from-abusive.html">quieter notifications UI</a> (though exact threshold is not yet defined). Standard UI will be restored for the site when acceptance rates improve within the control group.

PJ Mclachlan (Product Manager, Google) has talked about <a hreflang="en" href="https://www.youtube.com/watch?v=J_t8c9HOjBc">aiming for at least 50% acceptance rates</a> to be in safe territory to avoid falling into quieter notifications UI and aiming for 80% and above acceptance rate. The median notifications acceptance rates for an ecommerce website is 13.6% on mobile and 13.2% on desktop. At median level, these acceptance rates have a lot to be desired. Even at 90th percentile level, numbers don't look very good (36.9% for mobile and 36.8% for desktop). Ecommerce sites can refer to this <a hreflang="en" href="https://www.youtube.com/watch?v=riKmez3sHaM">talk for recommended patterns to make sure push acceptance rates remain healthy</a> and they are not getting caught off guard by upcoming abusive notifications changes.

{{ figure_markup(
  image="web-push-notification-acceptance-rates.png",
  caption="Web Push Notification acceptance rates",
  description="A bar chart showing the percentage acceptance rates of Web Push Notifications, with the 10th percentile having 4% on mobile, the 25th percentile having 9%, 50th having 14%, 75th having 20%, and 90th percentile having 37%, and the 100th percentile having 89% acceptance rates. Desktop acceptance rates look near identical.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1062364223&format=interactive",
  sheets_gid="2129008669",
  sql_file="webpushstats_ecommsites.sql"
) }}

## Future analysis opportunities

It will also be interesting to look at adoption of native apps by ecommerce sites by tapping into native app association standards like `.well-known/assetlinks.json` on play store and `.well-known/apple-app-site-association` on app store. Google has made easy for PWAs to achieve this using Trusted Web Activity but currently there are no public stats available on how many sites may be using this technique to submit their PWAs in play store.

This year's [SEO](./seo) chapter includes analysis of websites using `hreflang` and `lang` attributes, and `content-language` HTTP header. This combined with Wappalyzer detection of cross-border commerce solutions like Global-e, Flow, Borderfree can provide opportunity to just look at Cross border commerce aspects of the ecommerce websites. Currently Wappalyzer doesn't have a separate category for 'Cross-border commerce' and hence this type of analysis is not possible unless we build a repository of such solutions ourselves.

Wappalyzer also provides detection of payment solutions (Apple Pay / PayPal / ShopPay etc.) but based on the types of implementation and solution, it's not always possible to detect this just by looking at homepage but for solutions where detection can be done by just looking at homepage, such an analysis can be useful to look at year of year trends.

## Conclusion

Covid-19 massively accelerated the growth of ecommerce in 2020 and lot of smaller players had to establish online presence quickly and had to find ways to continue trading during lockdowns. Platforms like WooCommerce/Shopify/Wix/BigCommerce played very important role in bringing more and more small businesses online. Covid-19 also saw launch of D2C (direct to consumer) offerings by brand and this is expected to increase in future. Full impact of Covid-19 may not be visible in this year's Web Almanac as these new businesses need to cross certain traffic threshold first in order to become part of CRUX dataset which we use for our analysis. Due to this reason, we may see continued growth in next year's analysis as well.

Improving core web vitals score will be a priority for ecommerce businesses due to changes announced by Google and marketing teams using Web Push Notifications should keep an eye on their notifications stats using CRUX to not get caught by upcoming abusing notifications changes. Tag Managers still seem to cause a lot of friction between marketing and engineering teams and solutions like Google Tag Manager server side tagging will make some inroads but we don't expect a lot to change in 2021 and this will be more like 3-5 years journey but community need to ask their respective third parties to provide compatible solutions to further evolve this ecosystem.

While remembering the limitation that we are looking only homepage data for this analysis, we would like to hear from community what else we should cover in next year's analysis. We have covered some possibilities of further analysis in section above and <a hreflang="en" href="https://discuss.httparchive.org/t/2052">any feedback is greatly appreciated</a>.
