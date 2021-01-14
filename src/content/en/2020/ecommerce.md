---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: III
chapter_number: 16
title: Ecommerce
description: Ecommerce chapter of the 2020 Web Almanac covering ecommerce platforms, payloads, images, third-parties, performance, SEO, and PWAs.
authors: [rockeynebhwani, jrharalson]
reviewers: [drewzboto, alankent]
analysts: [jrharalson, rockeynebhwani]
editors: []
translators: []
#rockeynebhwani_bio: TODO
#jrharalson_bio:
discuss: 2052
results: https://docs.google.com/spreadsheets/d/1Hvsh_ZBKg2vWhouJ8vIzLmp0nLIMzrT2mr6RQbIkxqY/
queries: 16_Ecommerce
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---

## Introduction
An "ecommerce platform" is a set of software or services that enables you to create and operate an online store. There are several types of ecommerce platforms, for example:

- Paid-for services such as Shopify that host your store and help you get started. They provide website hosting, site and page templates, product-data management, shopping carts and payments.
- Software platforms such as Magento Open Source which you set up, host and manage yourself. These platforms can be powerful and flexible, but may be more complex to set up and run than services such as Shopify.
- Hosted platforms such as Magento Commerce that offer the same features as their self-hosted counterparts, except that hosting is managed as a service by a third-party.

Last year's analysis could only detect sites built on an eCommerce platform. This means that most large online stores and marketplaces—such as Amazon, JD, and eBay or any eCommerce sites built using in-house platforms (typically by bigger businesses) were not part of the analysis.  For this year's analysis, this limitation was addressed by enhancing Wapalyzer's detection of eCommerce sites. See Platform detection section for more details.

Also note that the data here is for home pages only: not category, product or other pages. Learn more about our [methodology](./methodology).

## Platform detection

How do we check if a page is on an ecommerce platform? Detection is done through Wappalyzer. Wappalyzer is a cross-platform utility that uncovers the technologies used on websites. It detects content management systems, ecommerce platforms, web servers, JavaScript frameworks, analytics tools, and many more.

Compared to 2019, you will notice that in 2020, % of eCommerce websites have increased significantly. This is primarily due to improved detection in Wappalyzer this year using secondary signals. These secondary signals include following:
- Sites using Google Analytics Enhanced eCommerce tagging is counted as an eCommerce site.
- Sites using cross-border solutions like Global-e etc. are counted as an eCommerce site.
- Secondary signal also includes looking for most commonly used patterns for identifying 'Cart' links

### Limitations

Our methodology has the following limitations:
- Headless eCommerce platforms like commerceTools
- Technologies which are typically deployed outside homepages (e.g. webAR on product detail pages) are not detected.


## Ecommerce (all platforms)

{{ figure_markup(
  image="ecommerce-comparison-2019-to-2020.png",
  caption="Ecommerce comparison 2019 to 2020.",
  description="A bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1775630157&format=interactive",
  sheets_gid="856812465",
  sql_file="pct_ecommsites_bydevice_compare20192020.sql"
) }}

In total, 21.72% of mobile websites and 21.27% of desktop websites used an eCommerce platform. In [last year's analysis](../2019/ecommerce), the same number was 9.41% for mobile websites and 9.67% for desktop websites.

<p class="note">Note: This increase is primarily due to improvements made to Wappalyzer to detect eCommerce websites and shouldn't be attributed to other factors like growth due to Covid-19. Also a minor correction was applied to 2019 stats retrospectively to account for an error and hence the number may not match with 2019 eCommerce chapter.</p>

## Top eCommerce Platforms

{{ figure_markup(
  image="top-ecommerce-platforms.png",
  caption="Top ecommerce platforms.",
  description="A bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=795567278&format=interactive",
  sheets_gid="872326386",
  sql_file="top_vendors.sql"
) }}

Our analysis counted 145 separate eCommerce platforms (compared to 116 in last year's analysis). Out of these, only 9 platforms have market share of greater than 0.1%. WooCommerce is the most common eCommerce platform and has maintained it's number one position.


{# TODO (authors): Wappalyzer started identifying Wix as eCommerce platform from 30th Jun 2019 - #}

{# TODO (authors) Top Enterprise eCommerce platforms #}


{# TODO (authors) Covid-19 impact on eCommerce #}
{# As discussed in https://github.com/HTTPArchive/almanac.httparchive.org/pull/1855 I don't see how you can measure this given the huge increase in detection? Shoudl we drop this? #}

## Page weight and requests

The page weight of an ecommerce platform includes all HTML, CSS, JavaScript, JSON, XML, images, audio, and video.

{{ figure_markup(
  image="page-requests-distribution.png",
  caption="Page requests distribution.",
  description="A bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1278986228&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

{{ figure_markup(
  image="page-weight-distribution.png",
  caption="Page weight distribution.",
  description="A bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1078671906&format=interactive,
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

Mobile page weights have dropped across all percentiles compared to 2019 while desktop page weights have remained the same more or less (except 90th percentile). . Why? May be 'loading' native attributes on mobile?

Requests per page also dropped on mobile (9-11 requests less across all percentiles except 90th percentile). On desktop, also dropped.
Requests and payload by type
The charts below are for mobile requests:



Figure X.X. Percentiles of the distribution of page weight (in KB) by resource type.


Figure X.X. Percentiles of the distribution of requests per page by resource type.

TODO: Check if Service worker pages have higher requests
HTML payload size
Figure 16.xx Distribution of HTML bytes (in KB) for eCommerce home pages.
Note that HTML payloads may include other code such as inline JSON, JavaScript, or CSS directly in the markup itself, rather than referenced as external links. The median HTML payload size for eCommerce pages is 35 KB on mobile and 36 KB on desktop. Compared to 2019, median payload size and 10th, 25th and 50th percentiles have remained approximately the same.  However, at 75th and 90th percentile, we see an increase of approximately 10kb and 15kb respectively across mobile and desktop.
Mobile HTML payload sizes are not very different from desktop. In other words, it appears that sites are not delivering significantly different HTML files for different devices or viewport sizes.







Image stats

Figure 16.xx. Distribution of image requests on eCommerce homepages.



Figure 16.XX. Distribution of image bytes (in KB) on eCommerce homepages.
Note that because our data collection methodology does not simulate user interactions on pages like clicking or scrolling, images that are lazy loaded would not be represented in these results.
Figures 16.xx and 16.xx above show that the median eCommerce page has 34 images and an image payload of 1,208 KB on mobile, 37 images and 1,271 KB on desktop. 10% of home pages have 90 or more images and an image payload of nearly between 5.5 MB on mobile and 5.8MB on desktop.
Compared to 2019, both median image requests and median image payload has seen a drop. Median image requests dropped by 3 for both mobile and desktop. Median image payload also dropped by approx. 200kb-250kb across mobile and desktop. This drop may be driven by sites adopting Lazy load techniques OR usage of <img loading="lazy"> attribute which is now being supported by more and more browsers. This year's Markup chapter makes an observation usage for nativge lazy loading appears to be on the increase and around 3.86% of the pages use this in Aug-2020 and this has been on constant rise (as seen in this tweet).
Popular image formats

Figure 16.xx. Popular image formats on eCommerce homepages.

Note that some image services or CDNs will automatically deliver WebP (rather than JPEG or PNG) to platforms that support WebP, even for a URL with a `.jpg` or `.png` suffix. For example, IMG_20190113_113201.jpg returns a WebP image in Chrome. However, the way HTTP Archive detects image formats is to check for keywords in the MIME type first, then fall back to the file extension. This means that the format for images with URLs such as the above will be given as WebP, since WebP is supported by HTTP Archive as a user agent.

PNG usage remained roughly at the same level as 2019 (at 27% for both desktop and mobile). We observed drop in jpg usage (4% for desktop and 6% for mobile). Out of this drop, most of it went towards increased GIF usage. GIFs are quite common on eCommerce homepages whereas GIFs may not be much used on product detail pages. Since our methodology only looks at homepages, this explains the significantly high usage of GIFs across eCommerce sites.   LightHouse has an audit which recommends to use 'video formats for animated content'. This is a technique eCommerce sites can use to optimize for performance but still retain animation properties of GIFs. See this article for more details
WebP usage across eCommerce sites still remains very low though usage increased by 100% and went from a total of 1% usage in 2019 to 2% usage in 2020.  WebP format is now nearly 10 years old and even after allowing for progressive enhancement using the 'picture' tag, usage has remained low. In 2020, webP got a new lease of life when Safari introduced support in Safari 14. However, web almanac for this year is based on Aug-2020 and Safari suppor came in Sep-2020 so any stats presented here doesn't reflect the impact of support added by Safari.
This year, In Chrome85 (released in Aug-2020), we also saw support for AVIF which is a more efficient image format compared to webP. In next year's analysis, we hope to cover AVIF usage across eCommerce sites. Similar to webP, AVIF is also progressive enhancement and can be implemented using the 'picture' tag to address cross-browser concerns.
As per the author's experience, there is a lack of awareness in engineering teams about image optimization services offered by CDNs where CDNs can do most of the heavy lifting without touching any code. For example, Adobe Scene7 offers this under their Smart Imaging solution. Clients on Salesforce Commerce Cloud using the platform's embedded CDN capability (which uses Cloudflare) can enable this with a simple toggle. By increasing the awareness of such solutions, we can try to move the needle in favour of more efficient formats.
Another point for readers who are interested in images sizes/formats to improve CRUX metrics, currently progressive images provides no weightage towards Largest Contentful Paint despite being helpful for user perceived performance. There is a fascinating discussion in the community on this topic and in future it's possible that progressive images contribute towards LCP. There may be renewed interest in the eCommerce community towards formats supporting progressive loading due to this and inclusion of Core Web Vitals in Page Experience signals from May 2021.























Third-party requests and bytes



eCommerce user experience
eCommerce is all about converting customers and in order to do that a fast performing website is paramount. In this section , we try to shed light on real-world user experience of eCommerce websites.
To achieve this, we turn our analysis towards some user-perceived performance metrics, which are captured in the three Core Web Vitals metrics.
Chrome User Experience Report
In this section we take a look at three important factors provided by the Chrome User Experience Report, which can shed light on our understanding of how users are experiencing eCommerce websites  in the wild:
Largest Contentful Paint (LCP)
First Input Delay (FID)
Cumulative Layout Shift (CLS)
These metrics aim to cover the core elements which are indicative of a great web user experience. The Performance chapter covers these in more detail, but here we are interested in looking at these metrics specifically for eCommerce websites. Let's review each of these in turn.
Largest Contentful Paint
Largest Contentful Paint (LCP) measures the point when the page's main content has likely loaded and thus the page is useful to the user. It does this by measuring the render time of the largest image or text block visible within the viewport.
This is different to First Contentful Paint (FCP), which measures from page load until content such as text or an image is first displayed. LCP is regarded as a good proxy for measuring when the main content of a page is loaded.
In the context of eCommerce, this metric provides very good indication of most useful content for the users (e.g. Hero banner image for landing pages, Image of 1st product displayed on a search/listings pages, Product image in case of a product detail page). Before this metric, sites had to explicitly instrument sites in their RUM solution but this metric democratizes the measurement for anybody who may not have resources or expertise to do this.
TODO - Adopt this paragraph for eCommerce.
A "good" LCP is regarded as under 2.5 seconds. The average website on one of the top five CMSs does not have a good LCP. Only Drupal on desktop scores over 50% here. We see major discrepancies between desktop and mobile scores: WordPress is fairly even at 33% on desktop and 25% on mobile, but Squarespace scores 37% on desktop and only 12% on mobile.

https://twitter.com/jmwind/status/1283467521706700800?s=20
















Analytics


Tag Managers

Add details about GTM SS and Adobe Launch (Alloy.js)

Tag Manager
Desktop
Mobile
Google Tag Manager
48.45%
46.56%
Adobe DTM
0.41%
0.38%
Ensighten
0.13%
0.13%
TagCommander
0.08%
0.07%
Signal
0.05%
0.03%
Matomo Tag Manager
0.02%
0.02%
Yahoo! Tag Manager
0.00%
0.00%
Total
49.14%
47.20%






Consent Management Platforms

This year's Privacy chapter covered the adoption of Consent Management Platforms across all types of websites. When we compare adoption on eCommerce sites Vs all sites, we see a slightly higher adoption both across mobile (4.2% on eCommerce sites Vs 4.0% on all sites)  and desktop (4.6% on eCommerce sites Vs 4.4% on all sites).


In terms of share of various CMPs, the trend for eCommerce websites was similar as all websites covered in Privacy chapter. In future editions of web almanac, we expect this adoption to increase as more and more countries come up with their own regulations. Also, 'Content Management Platform' was recently added to Wappalyzer by the web almanac team. Though the team added most popular CMPs, with time we expect additional CMPs to be added and hence expected  increase in adoption stats.




Accessibility Solutions

In this year's  Accessibility Chapter introduction, the web almanac team talks about dangers of implementing quick fix accessibility solutions  and points to Lainey Feingold's brilliant article, Honor the ADA: Avoid Web Accessibility Quick Fix Overlays.

Though not recommended, we looked at usage of such solutions across eCommerce websites and found that 0.47% of mobile websites and 0.54% of desktop websites have deployed such solutions.


In the current methodology adopted for this chapter,  there is no easy way for us to look at if any top eCommerce websites have gone this quick fix route instead of trying to achieve accessibility by design. It will be possible to find out this in future by combining HTTP Archive data with publications like Top 500 UK sites by  International retailing OR similar publications.

AMP Adoption

In the SEO chapter, we covered stats on AMP usage across all websites. In this chapter, we look at AMP adoption on eCommerce websites. AMP adoption remains low across eCommerce websites (0.61% on mobile and 0.66% on desktop) as AMP still doesn't support all eCommerce use cases. Also, in this analysis, we rely on detection using Wappalyzer and this may result in double counting of eCommerce sites where AMP is implemented as a different domain using AMPHTML tag. This shouldn't be an issue while looking at percentages as such domains are also counted twice while coming up with total eCommerce websites.


We also considered looking at CRUX performance of eCommerce websites with their AMP counterpart (where implemented on a different domain using AMPHTML canonical tag). Such an analysis will help us identify if there was a significant difference in performance of AMP domain, but due to low adoption rates of AMP across eCommerce websites, such an analysis may not give any meaningful results and we deferred the analysis for future years (if adoption rates increase). .
Push Notifications
TODO: In future, Chrome will automatically enroll sites with very low acceptance rates into quieter notifications UI (though exact threshold is not yet defined). Standard UI will be restored for the site when acceptance rates improve within the control group.  https://developers.google.com/web/updates/2020/02/notification-permission-data-in-crux

In this talk, PJ Mclachlan  (Product Manager, Google) talks about aiming for at least 50% acceptance rates to be in safe territory to avoid falling into quieter notifications UI and aiming for 80% and above acceptance rate.



The median notifications acceptance rates for an eCommerce website is 13.6% on mobile and 13.2% on desktop. At median level, these acceptance rates have a lot to be desired. Even at 90th percentile level, numbers are not very good (36.9% for mobile and 36.8% for desktop).

## Future Analysis Opportunities

This year's SEO chapter includes analysis of websites using 'hreflang' and 'content-language' attributes. This combined with Wappalyzer detection of cross-border commerce solutions like Global-e, Flow, Borderfree can provide opportunity to just look at Cross border commerce aspects of the eCommerce websites. Currently Wappalyzer doesn't have a separate category for 'Cross-border commerce' and hence this type of analysis is not possible unless we build a repository of such solutions ourselves.

{# TODO (authors): Enterprise level eCommerce platforms #}

A/B Testing - Wappalyzer category

## Conclusion

{# TODO (authors) - write a conclusion #}

