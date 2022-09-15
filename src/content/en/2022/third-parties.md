---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
#TODO - Review and update chapter description
description: Third Parties chapter of the 2022 Web Almanac covering data of what third parties are used, what they are used for, a deep dive into performance impacts and a discussion on security and privacy impacts.
authors: [imeugenia]
reviewers: [tunetheweb, housseindjirdeh, pepelsbey, kevinfarrugia, alexnj]
analysts: [kevinfarrugia, msolercanals]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1YqoRRsyiNsrEabVLu2nRU98JIG_0zLLuoQhC2nX8xbM/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
unedited: true
---

## Introduction

Third parties are an integral part of most websites. This chapter shows that nearly all websites use at least one third party, and nearly half of all requests are third-party requests.

Website owners use third parties to delegate some complex functionality such as analytics, advertising, live chats, consent management, and others. Although website developers may not directly control third-party code, they still can influence third parties' impact on the websites. Taking into account how widely third parties are used, they have a crucial impact on web performance. It is quite common that they are [blocking page rendering especially on mobile devices](&lt;link to render-blocking figure>), for instance, the average median blocking time for top 10 most popular third parties is 1.4 seconds. This way, third-parties affect [Core Web Vitals](https://web.dev/vitals/) and other important performance metrics like [First Contentful Paint](https://web.dev/fcp).

Many recommendations help to eliminate the negative impact. It could be simple techniques like using minified resources or more complex ones, for example, evaluating and choosing third-party scripts that don't serve legacy JavaScript or loading and executing third-party scripts using web workers.

This chapter focuses on the topic of how website owners and third-party developers are eliminating a third-party negative impact and if the best practices are followed. The first part is a review of third-party prevalence and some web performance-related metrics: render-blocking time and impact on the main thread. The second part is an analysis of the best practices regarding minifying and compressing resources, third-party facades, `async` and `defer` script attributes, legacy JavaScript, and other optimization opportunities.


## Definitions

A third-party is an entity outside the primary site-user relationship. It involves the aspects of the site not directly within the control of the site owner but with their approval. Third-party resources are:

* Hosted on a shared and public origin
* Widely used by a variety of sites
* Uninfluenced by an individual site owner

Some examples of third-parties include Google Fonts, the jQuery library served over public origin, and embedded YouTube videos.

To match the definition, only third-parties originating from a domain whose resources can be found on at least 50 unique pages in the HTTP Archive dataset were included.

In the case where third-party content is served from a first-party domain, it is counted as first-party content. For example, self-hosting Google Fonts or bootstrap.css is counted as _first-party content_. Similarly, first-party content served from a third-party domain is counted as third-party content—assuming it passes the “more than 50 pages criteria”.

There are some third parties that serve content from different subdomains. However, regardless of the number of subdomains they should be counted as a single third party. For that reason, a term third-party provider is used in some charts.

### **Third-party categories**

We are relying on the [third-party-web](https://github.com/patrickhulce/third-party-web/#third-parties-by-category) repository from [Patrick Hulce](https://twitter.com/patrickhulce) to help us identify and categorize third parties. This repository breaks down third parties by the following categories:

* **Ad** - These scripts are part of advertising networks, either serving or measuring.
* **Analytics** -These scripts measure or track users and their actions. There’s a wide range in impact here depending on what’s being tracked.
* **CDN** - These are a mixture of publicly hosted open source libraries (e.g. jQuery) served over different public CDNs and private CDN usage.
* **Content** - These scripts are from content providers or publishing-specific affiliate tracking.
* **Customer Success** - These scripts are from customer support/marketing providers that offer chat and contact solutions. These scripts are generally heavier in weight.
* **Hosting*** - These scripts are from web hosting platforms (WordPress, Wix, Squarespace, etc.).
* **Marketing** - These scripts are from marketing tools that add popups/newsletters/etc.
* **Social** - These scripts enable social features.
* **Tag Manager** - These scripts tend to load lots of other scripts and initiate many tasks.
* **Utility** - These scripts are developer utilities (API clients, site monitoring, fraud detection, etc.).
* **Video** - These scripts enable video player and streaming functionality.
* **Consent provider** - These scripts allow sites to manage the user consent (eg. for the [General Data Protection Regulation](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation) compliance). They are also known as the 'Cookie Consent' popups and are usually loaded on the critical path.
* **Other** - These are miscellaneous scripts delivered via a shared origin with no precise category or attribution.

Note: The CDN category here includes providers that provide resources on public CDN domains (e.g. bootstrapcdn.com, cdnjs.cloudflare.com, etc.) and does not include resources that are simply served over a CDN. For example, putting Cloudflare in front of a page would not influence its first-party designation according to our criteria.

*The same as in the previous year, the Hosting category is removed from our analysis. For example, if you happen to use WordPress.com for your blog, or Shopify for your e-commerce platform, then we’re going to ignore other requests for those domains by that site as not truly “third-party” as they are, in many ways, part of hosting on those platforms.

### **Caveats**

* All data presented here is based on a non-interactive, cold load. These values could start to look quite different after user interaction.
* The pages are tested from servers in the US with no cookies set, so third parties requested after opt-in are not included. This will especially affect pages hosted and predominantly served to countries in scope for the [General Data Protection Regulation](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation), or other similar legislation.
* Only the home pages are tested. Other pages may have different third-party requirements.
* Some of the lesser-used third-party domains are grouped into the _unknown_ category.
* We are leveraging different [Lighthouse audits](https://github.com/GoogleChrome/lighthouse/tree/master/core/audits). Some of them have limited coverage. Namely, it is not feasible to cover all existing facade implementations in the [third-party facades audit](https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-facades.js).

Learn more about our [methodology](https://almanac.httparchive.org/en/2021/methodology).


## Prevalence

{{ figure_markup(
  caption="Percent of mobile pages that use at least one third-party",
  content="94%",
  classes="big-number",
  sheets_gid="1355951746",
  sql_file="percent_of_websites_with_third_party.sql"
)
}}

The prevalence of third-parties remained at the same high levels as the previous year, i.e. 94% of websites use at least one-third party.

<!-- TODO: update charts and text once data is validated -->
<!-- {{ figure_markup(
  image="median-number-of-third-parties-by-rank.png",
  caption="Median number of third parties per website by rank.",
  description="Bar chart showing the median number of third-parties across various website rank categories. For the top 1,000 websites 25 and 23 third-parties are used on desktop and mobile websites respectively. The top 10,000 websites use 31 and 28 third-parties on desktop and mobile websites respectively. The top 100,000 websites use 25 and 22 third-parties on desktop and mobile websites respectively. The top 1,000,000 websites use 21 and 19 third-parties on desktop and mobile websites respectively. The median number of third-parties for all websites is 18 and 16 on desktop and mobile websites respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=765132350&format=interactive",
  sheets_gid="1355951746",
  sql_file="number_of_third_party_providers_by_rank.sql"
  )
}} -->
<!--
This figure shows the number of third parties for the most-used websites. For example, on average the top 1,000 popular websites use 23 third-parties on mobile and 25 on desktop devices. More popular websites seem to have a larger number of third parties, i.e. top 10,000 sites have twice more third parties than the median number of third-parties for all websites. -->

<!-- {{ figure_markup(
  image="websites-by-rank-and-third-party-category",
  caption="Percent of websites by third-party category and website rank.",
  description="",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=171851512&format=interactive",
  sheets_gid="1355951746",
  sql_file="number_of_third_parties_by_rank_and_category.sql"
  )
}} -->

<!-- When looking at the distribution of third-parties by category and rank, it becomes clear that the increase in the number of third-parties on more popular websites is mostly made up of the "ad" category. That means the third parties, especially ads have a crucial impact on the user experience because they are more used on the websites with a larger number of users. -->

{{ figure_markup(
  image="top-third-parties-by-number-of-pages.png",
  caption="Top 10 third parties by number of pages they are used on",
  description="Bar chart showing the usage of top 10 most popular third parties. fonts.googleapis.com is used on 63% of mobile pages, google-analytics.com on 51%, accounts.google.com on 49%, adservice.google.com on 47%, and googletagmanager.com on 46%. The rest, i.e. ajax.googleapis.com, facebook.com, cdnjs.cloudflare.com, youtube.com and  maps.google.com are used on less than 30% of mobile pages. Desktop and mobile percentage is similar for all third parties.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=857401072&format=interactive",
  sheets_gid="1355951746",
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

Google APIs: fonts, analytics, account management, advertising, and tag management, are the most popular third-parties across the entire web. 62.6% of all pages use Google Fonts which is over 4.9 million pages out of the 7.9 million mobile pages in our dataset!

{{ figure_markup(
  caption="Percentage of scripts of all third-party requests",
  content="34%",
  classes="big-number",
  sheets_gid="1355951746",
  sql_file="percent_of_third_parties_by_content_type.sql"
)
}}

Third-party requests account for 45% of all requests made by websites. Of those third-party requests, approximately one-third are scripts. This suggests it is worthwhile analyzing scripts in more detail in &lt;link to best practices section>.

## Performance impact

Some third parties might inevitably block page rendering and negatively affect the webpage loading experience. Lighthouse has a [render blocking resources audit]([https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/byte-efficiency/render-blocking-resources.js](https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/byte-efficiency/render-blocking-resources.js)) that provides data about render blocking time.

{{ figure_markup(
  image="render-blocking-time-by-most-popular-third-parties.png",
  caption="Median render blocking time for top 10 most popular third parties.",
  description="Bar chart showing the potential render-blocking time of top 10 most popular render-blocking third parties. Median render-blocking time of fonts.googleapis.com is 1.085 milliseconds on mobile pages, accounts.google.com is render-blocking for 1.077 milliseconds, adservice.google.com for 1.571, googletagmanager.com for 1.806, ajax.googleapis.com for 1.530, cloudflare.com for 1.300, youtube.com for 1.146, bootstrapcdn.com for 1.241, maps.google.com for 2.095 and jsdelivr.net for 1.370. Desktop and mobile data is similar for all third parties.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=549590895&format=interactive",
  sheets_gid="1355951746",
  sql_file="third_parties_blocking_rendering_percentiles.sql"
  )
}}

The figure above shows the median render-blocking time for the top 10 most popular third parties. Google maps have the most significant impact on rendering time. It accounts for more than 2 seconds for the median website. That is a significant impact taking into account that the recommended time for [First Contentful Paint](https://web.dev/fcp)—a page load speed metric, is 1.8 seconds.

A website can save a lot of loading time by eliminating render-blocking resources. There are many methods to [embed third-parties in a non-blocking way](https://web.dev/embed-best-practices/). For example, in the case of Google Maps, the [Maps Static API](https://developers.google.com/maps/documentation/maps-static/overview) could be used to implement a third-party facade. Also, the third-party iframes can be lazy-loaded.

Added third-party scripts compete for the main thread resources with the website's first-party code. If a third-party has a long-running JavaScript task that runs on the main thread for more than 50 ms, it is considered to be blocking the main thread. It could significantly influence user experience when interacting with a page as the main thread is responsible for processing user events. When it is blocked a user suffers from a non-responsive page.

We inspected the [third party summary audit](https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-summary.js) to emulate main thread blocking time caused by third-parties.

{{ figure_markup(
  image="third-parties-blocking-main-thread.png",
  caption="Top 10 third parties blocking main thread",
  description="Bar chart showing the percentage of mobile pages that have main thread blocked by a third party by top 10 third parties. YouTube is blocking main thread on 90% of mobile pages, Google Maps on 85%, Other Google APIs/SDKs on 84%, Facebook 82%, Google Dounbleclick Ads 81%, Google CDN 79%, Google Tag Manager 75%, Cloudfare CDN 71%, Google Analytics 70%, Google Fonts 63%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1753375995&format=interactive",
  sheets_gid="1355951746",
  sql_file="third_parties_blocking_main_thread.sql"
  )
}}

The figure above presents the top 10 most-used third parties and their impact on the main thread on mobile devices. Note that for desktop devices the impact is much lower. For example, YouTube blocks the main thread for 90% of the mobile websites while blocking only 26% on desktop websites it is embedded on. This is logical taking into account that desktop devices are much more powerful. However, nowadays mobile user experience is very important as according to the [Mobile Web](./mobile-web) chapter, 58% of website visits are coming from mobile devices.

To examine in more detail how the website users could be affected by the main thread blocking third-party, we can review the median main thread blocking time.

{{ figure_markup(
  image="main-thread-blocking-time-by-third-party.png",
  caption="Median main thread blocking time in ms for top 5 most popular third parties.",
  description="Bar chart showing the median main thread blocking time by top 5 third parties. YouTube is blocking main thread for 1.721 milliseconds on mobile pages and 117 milliseconds on desktop pages, Google Maps for 298 and 0, Facebook 93 and 0, Google Analytics 76 and 0, Google Tag Manager 65 and 0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1006809602&format=interactive",
  sheets_gid="1355951746",
  sql_file="third_parties_blocking_main_thread.sql"
  )
}}

YouTube is the most blocking third party among top 5 most-used third parties. It blocks the main thread for more than 1.7 seconds for the median website that loads YouTube videos (based on the mobile device we emulate as part of our crawl). There is a notable gap between desktop and mobile websites as the desktop websites are almost not affected.

Note that Lighthouse might mark some third parties as potentially render-blocking while their size is so small that they don’t have any tangible effect on the render-blocking time. This is the case for third parties like Google Fonts or Google/Doubleclick Ads whose median render-blocking time is 0ms.

A blocked main thread has a big impact on [First Input Delay (FID)](https://web.dev/fid/) and [Interaction to Next Paint (INP)](https://web.dev/inp/) performance metrics. To provide good web page responsiveness, the FID should be 100ms or less and INP below 200ms. There is research about [correlation between Total Blocking Time and Interaction to Next Paint on mobile devices](https://github.com/GoogleChromeLabs/chrome-http-archive-analysis/blob/main/notebooks/HTTP_Archive_TBT_and_INP.ipynb) documented by [Annie Sullivan](https://twitter.com/anniesullie). It shows that the lower the main thread blocking time, the larger the percent of websites meet good INP and FID thresholds. That leads to a conclusion that it becomes harder to achieve good core web performance metrics if the third parties are blocking the main thread for such a long time as in the YouTube example. Moreover, other third-parties and first-party assets might also contribute to the render-blocking effect. Despite this, there are many ways to minimize the render-blocking effect of third parties. This will be further explored in the next section.

## Web performance best practices

The previous section confirmed that the third parties are causing a huge performance impact that could affect the entire website experience. However, website and third-party developers can follow many best practices to minimize third-party performance impact from minifying resources to using third-party facades. We looked at different third party usage trends to understand how the best practices are followed.


### Minifying resources

Minifying JavaScript and CSS files is one of the first recommendations when speaking about web performance. To check how third party resources are minified we are making use of the following Lighthouse audits: [Unminified JavaScript](https://web.dev/unminified-javascript/) and [Unminified CSS]([https://web.dev/unminified-css/](https://web.dev/unminified-css/)).

Minifying scripts should have a large positive impact as they are the most popular third-party content type. Moreover, compared to other content types like CSS, scripts tend to be a lot more verbose, with comments and large variable names that affect the file size.

{{ figure_markup(
  image="average-potentially-saved-bytes-of-unminified-javascript.png",
  caption="Percentage of average potentially saved bytes of unminified JavaScript by first and third party.",
  description="Pie chart showing the distribution of the average potentially saved bytes of unminified JavaScript by resource origin type on mobile pages. 18.7% of unminified JavaScript is originated from third parties and 81.3% from a first party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1231774655&format=interactive",
  sheets_gid="1355951746",
  sql_file="lighthouse_average_unminified_js_by_3p.sql"
  )
}}

Although some JavaScript bytes could be saved by minifying third-party resources, the first-party scripts are still responsible for the largest amount of unminified JavaScript on the websites, i.e. 81% of average total potentially saved bytes. The distribution of unminified JavaScript shows that for 75% of websites total potential savings could achieve 34.5 KB of savings while savings from third parties are only 2.8 KB.

The next figure displays the size of potential savings by a third-party. It is important to note that the methodology used only includes third-parties which come from an external domains and does not count third-party content hosted by a first party, for example libraries imported as node modules.

{{ figure_markup(
  image="potential-savings-of-unminified-javascript-by-third-party.png",
  caption="Average potentially saved kilobytes of unminified JavaScript for top 5 third-party script providers.",
  description="Bar chart showing potentially saved kilobytes of unminified JavaScript per page by a third party. Potential savings of minifying scripts served from code.jquery.com are 42 kilobytes for mobile pages, from s0.wp.com 14 kilobytes, from vk.com 13, from shopify.com 20 and from cloudflare.com 14.Data for desktop and mobile pages is almost identical.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=496701127&format=interactive",
  sheets_gid="1355951746",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

jQuery is the most popular JavaScript library being used on 6% of all websites on desktop. On average 43 KB of data per page that has unminified jQuery could be saved by minifying its resources.

{{ figure_markup(
  caption="Percent of desktop pages with unminified jQuery from all pages using jQuery third-party",
  content="17%",
  classes="big-number",
  sheets_gid="1355951746",
  sql_file="lighthouse_unminified_js_by_3p.sql"
)
}}

17% of the websites that use jQuery hosted on a third-party domain fail the [Lighthouse audit for unminified JavaScript]([https://web.dev/unminified-javascript/](https://web.dev/unminified-javascript/)). Digging deeper into how the library is imported shows that many websites are using the unminified versions of jQuery that should be used only for development purposes. A similar tendency can be found in the usage of some other less popular third-party scripts.

This should serve as a reminder for web developers to check if third-party scripts imported on their websites are suitable for production environments.

{{ figure_markup(
  image="average-potentially-saved-bytes-of-unminified-css.png",
  caption="Percentage of average potentially saved bytes of unminified CSS by first and third party",
  description="Pie chart showing the distribution of the average potentially saved bytes of unminified CSS by resource origin type on mobile pages. 10.7% of unminified JavaScript is originated from third parties and 89.3% from a first party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=417912172&format=interactive",
  sheets_gid="1355951746",
  sql_file="lighthouse_average_unminified_css_by_3p.sql"
  )
}}

The unminified CSS audit shows that third-party assets have a much smaller impact, especially when compared with the first-party average of potentially saved bytes of CSS code that is 89% of total average potentially saved bytes. This data demonstrates that third-party CSS content is well minified and has a much lower impact than first-party CSS.

Google fonts are the most-popular third party on mobile devices being used by 62.6% of all websites. The CSS they provide is not minified. The data shows the average page which has Google Fonts could save 13.3 KB from minifying it. This would seem like an opportunity for improvements. However, their CSS contains a number of similar font-face definitions that are repeated in case of many fonts, so HTTP-level compression will work really well and significantly reduce the file size even without minification. That makes the benefits of minifying very low, compared to the code readability for those wanting to see the CSS to potentially replicate locally. Other third-parties with more complicated and larger CSS, may benefit from minification considerably more.


### Compressing resources

Compressing files is another quick win that third-party developers can do to have a positive impact on web performance. Most heavy content types like scripts and CSS have a good compression coverage. Only 12% of scripts and 4.5% of CSS files of total third-party requests are not compressed.

{{ figure_markup(
  image="content-encoding-by-content-type.png",
  caption="Content encoding by third-party content type on mobile pages.",
  description="Distribution chart showing percentage of thirs-party requests by content-encoding type on mobile pages. “video” content has no compression, 2% of “other” content has gzip compression, “font” content has 2.5% gzip and 0.75% brotli comression, “image” content 4.59% and 1.34%, “text” 3.76%  and 5.47%, “plain” 4.43% and 5.37%, “audio” 32.79%, “html” 25.12% and 13.98%, “xml” 29.84% and 18.69%, “script” 59.70% and 28.66%, and “css” 68.93% and 26.91%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1766106033&format=interactive",
  sheets_gid="1355951746",
  sql_file="content_encoding_by_content_type.sql"
  )
}}

Gzip is still the most popular compression type, i.e. 59% of scripts and 68% of CSS are compressed with gzip. However, Brotli compression is more effective. The trends among first and third parties show that usage of Brotli compression has grown in the past 3 years.

{{ figure_markup(
  image="first-party-content-encoding-by-year.png",
  caption="Percentage of first-party script requests by content encoding type and by year on mobile websites.",
  description="Bar chart showing first-party content-encoding trends for the period from 2020 to 2022. In 2020 19% of content has no compression, in 2021 16% and in 2022 15.14%.  In 2020 13% of content has brotli compression, in 2021 32% and in 2022 40%. In 2020 66% of content has gzip compression, in 2021 52% and in 2022 45%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=2058399908&format=interactive",
  sheets_gid="1355951746",
  sql_file="trends_content_encoding_by_type.sql"
  )
}}

The rate of first-party scripts compressed via brotli almost tripled, increasing from 15% to 40%.

{{ figure_markup(
  image="third-party-content-encoding-by-year.png",
  caption="Percentage of third-party script requests by content encoding type and by year",
  description="Bar chart showing first-party content-encoding trends for the period from 2020 to 2022. In 2020 12% of content has no compression, in 2021 11% and in 2022 12%.  In 2020 24% of content has brotli compression, in 2021 30% and in 2022 29%. In 2020 64% of content has gzip compression, in 2021 59% and in 2022 60%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1920216281&format=interactive",
  sheets_gid="1355951746",
  sql_file="trends_content_encoding_by_type.sql"
  )
}}

However, Brotli adoption among third-parties stayed more or less at the same level, changing from 24% to 28%. Despite the slight positive tendency, there is still room for improvement of Brotli adoption for third-parties.

Website content encoding data displayed in the figure &lt;link to Content encoding distribution by third-party content type> revealed an interesting fact about image compression. Even though image formats like JPEG, PNG, WebP, AVIF, and others provide compression under the hood, 5.2% of image content is compressed using Gzip or Brotli compression. Adding additional layers of compression on top of the standard image compression formats is usually unnecessary and may lead to increased file size and add extra load on the CPU when uncompressing the image.


### Usage of third-party facades

There are multiple techniques to eliminate render-blocking resources. One of them is [third-party facades](https://web.dev/third-party-facades/) that are useful for visual content like YouTube videos or interactive widgets like a live chat. They help to exclude third parties from the critical loading sequence and lazy load them. Lighthouse has introduced an audit [Lazy load third-party resources with facades]([https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-facades.js](https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-facades.js)). However, there are multiple third-party facade solutions, for example [lite-youtube-embed](https://github.com/paulirish/lite-youtube-embed), [lite-youtube](https://github.com/justinribeiro/lite-youtube), or some custom approaches, and only a small number of them are in [the list of third-parties]([https://github.com/patrickhulce/third-party-web/blob/master/data/entities.js](https://github.com/patrickhulce/third-party-web/blob/master/data/entities.js)) checked during the audit. This limitation makes it complicated to assess third-party facade usage across the web.

### Usage of `async` and `defer`

Using `async` and `defer` is another technique that could be used by website developers to optimize the loading of render-blocking third-party scripts.

{{ figure_markup(
  image="async-and-defer-for-third-party-scripts.png",
  caption="Percentage of all third-party script requests by `async` and `defer` attributes.",
  description="Bar chart showing 62% of third-party scripts having `async` atribute and 7% `defer` attribute on mobile pages. Data for destop pages is very similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1722277284&format=interactive",
  sheets_gid="1355951746",
  sql_file="scripts_using_async_defer.sql"
  )
}}

The `async` attribute is considerably more popular than `defer`. It is used for 62% of total third-party scripts on mobile devices. Usage of the `async` attribute can still result in a render-blocking script as its execution can start during HTML parsing. The `async` attribute is useful for critical resources that are important during the page loading and can interrupt rendering. The fact  that `async` is more used demonstrates that third-party scripts are mostly treated as critical resources. Although this is true for some scripts, many third-parties, for example, a video player are less critical. Deferred scripts potentially have a better impact on page rendering time that is reflected in core web performance metrics like [Largest Contentful Paint](https://web.dev/lcp/). To sum up, website developers should consider using `defer` for third-party assets that are not important for the critical rendering path.

Which resources are critical and which could be deferred might be a tricky question to consider especially when speaking about consent management third parties that enable other third parties to be used. For example, analytics scripts are usually considered important for site owners but can’t be used without user’s consent in countries with [GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation), making user consent third-party critical. Loading consent third-party resources in a critical path may result in bad user experience causing Cumulative Layout Shifts and First Input Delay. Therefore, developers should strive for balance between the way third parties are loaded and good user experience.

### Legacy JavaScript

Despite JavaScript's rapid involvement, the prevalence of legacy code is still significant. We are using one of the Lighthouse audits to check how much third-parties are [serving legacy JavaScript to modern browsers]([https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/byte-efficiency/legacy-javascript.js](https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/byte-efficiency/legacy-javascript.js)).

{{ figure_markup(
  caption="Percent of legacy JavaScript Lighthouse audit failure caused by third-party",
  content="59%",
  classes="big-number",
  sheets_gid="1355951746",
  sql_file="third_parties_using_legacy_javascript.sql"
)
}}

In general, third parties account for 59% of Lighthouse legacy JavaScript audit failures. A closer look into the audit results highlights top 5 third-party script providers that include legacy JavaScript.

{{ figure_markup(
  image="pages-with-third-parties-that-use-legacy-javascript.png",
  caption="Percentage of websites using third parties that have legacy JavaScript",
  description="Bar chart showing top 5 most-used third parties that serve legacy JavaScript. connect.facebook.net is used on 18.5% of mobile pages, apis.google.com on 3.3%, script.hotjar.com on 3.2%, cdn.shopify.com on 2.8% and static.xx.fbcdn.net on 2.4%. Data for desktop pages is very similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=2145007275&format=interactive",
  sheets_gid="1355951746",
  sql_file="percent_of_third_parties_using_legacy_javascript.sql"
  )
}}

Facebook is a third-party with legacy JavaScript that affects the most pages. It introduces legacy code to around 20% of the total number of webpages on mobile and desktop devices correspondingly when looking at both facebook.net and fbcdn.net from the above graph. Nowadays, when old browsers like Internet Explorer may no longer need to be supported, the necessity to keep legacy JavaScript becomes lower. Despite this fact, the trends of using Facebook resources that have legacy JavaScript in the past 3 years reveal that the numbers increased (from around 14% in 2020 to 18% in 2022 for facebook.net alone). This is due to the increasing number of websites that embed this third party.

Serving legacy JavaScript to the modern browsers results in a bigger amount of redundant and slower code. We can look into this more by  analyzing the size of unused JavaScript.

{{ figure_markup(
  image="size-of-unused-javascript.png",
  caption="Size of unused third-party JavaScript.",
  description="Bar chart showing size of unused third-party JavaScript in kilobytes by percentile. At 25th percentile the size of unused JavaScript is 39 kilobytes for mobile pages, at 50th percentile 116, at 75th 261, and at 90th 507. Desktop pages have slightly larger size of unused JavaScript.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=291457440&format=interactive",
  sheets_gid="1355951746",
  sql_file="distribution_of_lighthouse_unused_js_by_3p.sql"
  )
}}

The median amount of unused third-party JavaScript is approximately 120 KB. For 25% of websites that use third-party scripts, it is more than 261 KB.

Unfortunately, website owners do not always have the possibility to change the way third-party JavaScript is bundled. However, if the third-party dependencies are self-hosted they can be optimized during development by adopting [modern script bundling approaches]([https://web.dev/publish-modern-javascript](https://web.dev/publish-modern-javascript)) that could help to reduce the amount of unused code.


### Other optimization technologies

One of the third-party resource management problems is that sometimes it can skip the development team and be added using tag management tools without proper web performance evaluation. As a result, third-party scripts can uncontrollably affect the page loading and responsiveness experience.

Some modern third-party loading and execution solutions have appeared in recent years. For example, [Partytown]([https://partytown.builder.io/](https://partytown.builder.io/)) is a library that relocates third-party scripts into the web worker to free up the main thread for first-party code. Currently, the library is in the early adoption stage and its usage is very low. Only 70 websites from the whole dataset are using it in 2022. However, this [Next.js framework have started to introduce this solution](https://nextjs.org/docs/basic-features/script#off-loading-scripts-to-a-web-worker-experimental) that could raise Partytown popularity.

The previous sections showed that the responsibility for third-party negative impact is split between first and third-party developers. However, [browsers are also showing interest in optimizing the loading of third-party resources]([https://developer.chrome.com/blog/third-party-scripts/#proposed-approach](https://developer.chrome.com/blog/third-party-scripts/#proposed-approach)). The proposals include better real user monitoring and developer tooling providing more data about the impact of third-parties on their websites.

{{ figure_markup(
  caption="Percent of third-party requests with Timing-Allow-Origin header header",
  content="25%",
  classes="big-number",
  sheets_gid="1355951746",
  sql_file="tao_by_third_party.sql"
)
}}

That might be challenging to achieve given only 25% of total third-party requests provide [Timing-Allow-Origin (TAO) header]([https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Timing-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Timing-Allow-Origin)) that is important for third-party web performance data transparency.

Taking into account the [TAO header prevalence has not improved in comparison to the previous years](../2021/third-parties#timing-allow-origin-header-prevalence), we would encourage third-party providers to use it more actively.


## Conclusion

Third-parties are often associated with a negative impact on the website performance. Indeed some account for notable rendering and main thread blocking time especially on mobile devices, which are increasingly the more popularly used devices. However, the main goal of this chapter is to show that the responsibility for third-party impact on web performance is shared between third-party providers and website owners. There are lots of opportunities for website developers to lower the third-party impact on their websites. In the future, browsers also might look to automatically apply third-party resource optimizations.

We have analyzed data related to different web performance recommendations,including compressed and minified resources, legacy APIs, unused JavaScript, etc. Based on the findings, we have conducted the following action points that could be helpful for website and third-party developers to improve the user experience:

* Load third-party resources suitable for production environments—assets are minified and compressed.
* Leverage different third-party facade techniques, especially for “heavy” content like videos, maps, and live chats, that are render-blocking and have a crucial impact on First Contentful Paint.
* While evaluating third-party candidates, ensure that they are not serving legacy APIs.
* Consider how critical third-party content is for the page and load the non-critical resources using the `defer` attribute that is not render-blocking.
* Explore modern third-party load and execution strategies.
* Choose brotli compression over gzip.

There are many more optimization opportunities out there! We encourage web developers to take them so that functionality provided by third-parties would serve websites well without harming user experience.