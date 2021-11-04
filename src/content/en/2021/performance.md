---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Performance
description: Performance chapter of the 2020 Web Almanac covering Core Web Vitals (Largest Contentful Paint, Cumulative Layout Shift, First Input Delay) as well as First Contentful Paint and Time to First Byte
authors: [siakaramalegos]
reviewers: [rviscomi, kevinfarrugia, estelle, ziemek-bucko, jzyang, samarpanda, edmondwwchan, fili]
analysts: [siakaramalegos, rviscomi, Nithanaroy]
editors: [estelle, jzyang]
translators: []
results: https://docs.google.com/spreadsheets/d/13xhPx6o2Nowz_3b3_5ojiF_mY3Lhs25auBKM6eqGZmo/
siakaramalegos_bio: Sia Karamalegos is a web developer, international conference speaker, and writer. She is a Google Developer Expert in Web Technologies, a Cloudinary Media Developer Expert, a Stripe Community Expert, and co-organizes the Eleventy Meetup. Check out her writing, speaking, and newsletter on <a hreflang="en" href="https://sia.codes/">sia.codes</a> or find her on <a hreflang="en" href="https://twitter.com/thegreengreek">Twitter</a>.
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

Performance is important for user experience. Slow-loading and slow-to-respond websites frustrate users and cause lost conversions. This is the first year that the [Core Web Vitals](https://web.dev/vitals/) have contributed to Google search rankings. As such, we've seen greater interest in  improving website performance which is great news for users.

What are our top takeaways from this year's report? First, we still have a long way to go in providing a good user experience. For example, faster networks and devices have not yet reached the point where we can ignore how much JavaScript we deliver to a site. And, we may never get there. Second, sometimes we misuse new features for performance resulting in poorer performance. Finally, we need a better metric for measuring interactivity (and you can help).

What's new this year? We're excited to share performance data by traffic ranking for the first time. We also have all the core performance metrics from previous years. Finally, we added a deeper dive into the Largest Contentful Paint (LCP) element.

### Notes on Methodology

One thing that makes the performance chapter different from the others is that we rely heavily on the [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report) (CrUX) for our analyses. Why? If our number one priority is user experience, then the best way to measure performance is with real user data (real user metrics, or RUM for short).

> The Chrome User Experience Report provides user experience metrics for how real-world Chrome users experience popular destinations on the web. -[Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report)

CrUX data only provides high-level field/RUM metrics and only for the Chrome browser. Additionally, CrUX reports data by origin, or website, instead of by page.

We supplement our CrUX RUM data with lab data from WebPageTest in HTTP Archive. WebPageTest includes very detailed information about each page, including the full Lighthouse report. Note that WebPageTest measures performance in [California and Oregon](https://almanac.httparchive.org/en/2021/methodology#webpagetest). The performance data in CrUX is global since it represents real user page loads.

When comparing performance year-over-year, keep in mind that:

- The Cumulative Layout Shift (CLS) calculation has changed since 2020.
- The First Contentful Paint (FCP) thresholds ("good", "needs improvement", and "poor") have changed since 2020.
- Last year's report was based on August 2020 data, and this year's report was based on the July 2021 run.

Read the full [methodology](./methodology) for the Web Almanac to learn more.

## High-Level Performance: Core Web Vitals

Before we dive into the individual metrics, let's take a look at combined performance for the [Core Web Vitals](https://web.dev/vitals/) (CWV). The Core Web Vitals (LCP, CLS, FID) are a set of performance metrics focused on user experience. They focus on loading, interactivity, and visual stability. Web performance is notorious for an alphabet soup of metrics, but the community is coalescing on this framework.

This section focuses on websites that reached the "good" threshold on all three CWV metrics to understand how the web is performing at a high level. In the Analysis by Metric section, we'll cover the same charts by each metric in detail, plus more metrics not in the CWV.

### By Device

![image](insert_image_url_here)

<!-- TODO: note style -->
<p class="note"><strong>Note:</strong> As the CLS calculation changed since last year, this is not an apples-to-apples comparison.</p>

The Core Web Vitals for websites in the Chrome User Experience Report improved year-over-year. But, a good part of this improvement could be due to a change in the CLS calculation, not necessarily to a performance improvement in CLS. The resulting CLS "improvement" was 8 points on desktop (2 for mobile). LCP improved by 7 points for desktop (2 for mobile). FID was already at 100% for desktop for both years and improved by 10 points on mobile.

As in previous years, performance was better on desktop machines than mobile devices. This is why it's crucial to test your site's performance on real mobile devices and to measure real user metrics (i.e., field data). Emulating mobile in developer tools is convenient in the lab but not representative of real user experiences.

### By Effective Connection Type

The data by connection type in CrUX can be difficult to understand. It is not based on traffic. If a website has any experiences in a connection type, then it increases the denominator for that connection type. If the experiences were good for that website in that connection type, then it increases the numerator. Said another way, for all the websites which experienced page loads at 4G speed, 36% of those websites had good CWV:

![image](insert_image_url_here)

Faster connections correlated with better Core Web Vitals performance. Offline performance was better presumably because of service worker caching in progressive web apps. Yet, the number of origins in the offline effective connection type category is negligible at 2,634 total (0.02%).

The top takeaway is that 3G speeds and lower correlated with significant performance degradation. Consider providing pared-down experiences for access at low connection speeds (e.g., [data saver mode](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/save-data/)). Profile your site with devices and connections that represent your users (based on your analytics data).

![image](insert_image_url_here)

Earlier, we mentioned year-over-year improvements in LCP and FID improvements. These could be partly due to faster mobile devices and mobile networks. The chart above shows total origins accessed on 3G speed dropped by 2 points while 4G origins increased by 3 points. Percent of origins is not necessarily correlated with traffic. But, I would guess if people have more access to higher speeds, then more origins would be accessed from that connection type.

Performance by connection type would be easier to understand if we could start tracking by traffic and not only origin.  It would also be nice to see data for higher speeds. However, [the API is currently limited](https://developer.mozilla.org/en-US/docs/Glossary/Effective_connection_type) to grouping  anything above 4G as 4G.

### By Geographic Region

![image](insert_image_url_here)

Regions in parts of Asia and Europe continued to have higher performance. This may be due to higher network speeds, wealthier populations with faster devices, and closer edge-caching locations.  We should inspect the dataset before drawing too many conclusions. Here are the top 10 regions by the number of websites in CrUX versus their relative population sizes:

![image](insert_image_url_here)
<!-- TODO: add to figure caption -->
Source: [https://datacommons.org/](https://datacommons.org/) Population data is for 2020. Original data comes from the World Bank, the US Census, INSEE, and WikiData.

Similarly, here are the 10 top regions by population and their corresponding share of websites in CrUX:

![image](insert_image_url_here)

<!-- TODO: add to figure caption -->
Source: U.S. Census Bureau Current Population (population clock) at Nov 02, 2021 18:31 UTC (+4) [https://www.census.gov/popclock/print.php?component=counter](https://www.census.gov/popclock/print.php?component=counter) Population data is for 2021

The US, Japan, Brazil, and Western Europe are over-represented in the CrUX dataset origins. Many large countries like China, India, and Nigeria, and Pakistan are underrepresented.

Remember that CrUX data is only gathered in Chrome. The percent of origins by country does not align with relative population sizes. Reasons may include differences in browser share, device share, level of access, and level of use. Also, the origins accessed in that country may not mirror the global top origins included in the dataset. Keep these caveats in mind when evaluating regional-level differences and context for all CrUX analyses.

### By Rank

This year for the first time, we have ranking data! ​​CrUX determines ranking by the number of page views per website measured in Chrome. In the charts, the categories are additive. The top 10,000 sites include the top 1,000 sites, and so forth. The "all" category is sometimes referred to as the top 10,000,000, but it does not have a full 10 million websites in it. See the [methodology](./methodology#chrome-ux-report) for more details.

![image](insert_image_url_here)

The top 1,000 sites significantly outperformed the rest in the Core Web Vitals. An interesting trough of poorer performance occurs in the middle of the chart which is due to CLS. FID was flat across all buckets, and all other metrics correlated with higher performance for higher ranking.

Correlation is not causation. Yet countless companies have shown performance improvements leading to bottom-line business impacts ([WPO stats](https://wpostats.com/)). You don't want performance to be the reason you can't achieve higher traffic and increased engagement.

## Analysis by Metric

In this section, we will dive down into each metric. For those who are less familiar, we include links to articles that explain them in depth.

### Time-to-First-Byte (TTFB)

[Time-to-first-byte](https://web.dev/ttfb/) (TTFB) is the time between the browser requesting a page and when it receives the first byte of information from the server. It is the first metric in the chain for website loading. A poor TTFB will result in a chain reaction impacting FCP and LCP. It's also why we're choosing to talk about it first.

![image](insert_image_url_here)

TTFB was faster on desktop than mobile, presumably because of faster network speeds. Compared to [last year](https://almanac.httparchive.org/en/2020/performance#fig-17), TTFB marginally improved on desktop and slowed on mobile.

![image](insert_image_url_here)

We have a long way to go for TTFB. 75% of our websites were in the 4G connection group and 25% in the 3G group, with the remaining ones negligible. At 4G effective speeds, only 19% of origins had "good" performance.

You may be asking yourself how TTFB can even occur with offline connections. Presumably, most of the offline sites that record and send TTFB data use [service worker caching](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Offline_Service_workers). Service worker startup time can be long (> 1 second) which could be why their "TTFB" isn't always below 0.5 seconds. Remember that the offline category only represents 0.02% of the data.

![image](insert_image_url_here)

For rank, TTFB was faster for higher-ranking sites. One reason could be that most of these are larger companies with more resources to prioritize performance. They may focus on improving server-side performance and delivering assets through edge CDNs. Another reason could be selection bias - the top origins might be accessed more in regions with closer servers, i.e., lower latency.

<!-- TODO: validate CMS chapter link works -->
One more possibility has to do with CMS adoption. The [CMS Chapter](./cms) shows CMS adoption by rank.

![image](insert_image_url_here)

42% of pages (mobile) in the "all" group used a CMS whereas the top 1,000 sites only had 7% adoption.

Then, if we look at the top 5 CMSs by rank, we see that WordPress has the highest adoption at for 31% of "all" pages:

![image](insert_image_url_here)

Finally, if we look at the [Core Web Vitals Technology Report](https://datastudio.google.com/s/o6zLzlTpWaI), we see how each CMS performs by metric:

![image](insert_image_url_here)

<!-- TODO: figcaption -->
Figure: Origins having good TTFB by CMS ([Core Web Vitals Technology Report](https://datastudio.google.com/s/o6zLzlTpWaI))

Only 5% of origins on WordPress experienced good TTFB in July 2021. Considering WordPress's large share of the top 10M sites, its poor TTFB could be a contributor to the TTFB degradation by rank.

### First Contentful Paint (FCP)

[First Contentful Paint (FCP)](https://web.dev/fcp/) measures the time from when a load first begins until the browser first renders any contentful part of the page (e.g, text, images, etc.).

![image](insert_image_url_here)

FCP was faster on desktop than mobile, likely due to both faster average network speeds and faster processors. Only 38% of origins had "good" FCP on mobile. Render-blocking resources such as synchronous JavaScript can be a common culprit. Remember that TTFB is the first part of FCP so a poor TTFB will make it more difficult to achieve a good FCP.

<p class="note"><strong>Note:</strong> The thresholds for FCP have changed since last year so be careful if you try to compare this year's data to last year's data.</p>

![image](insert_image_url_here)

Origins at 3G speeds and below experienced significant degradations in FCP. Again, ensure that you are profiling your website using real devices and networks that reflect your user data from analytics. Your JavaScript bundles may not seem significant when you're only profiling on high-end desktops with fiber connections.

[insert comment on offline - maybe slow startup of service workers (TTFB phase) plus too much JavaScript used for rendering? Could it also be that it times out/never renders?]

![image](insert_image_url_here)

Like TTFB, FCP improved with higher rankings. Also like TTFB, only [19.5% of origins on Wordpress experienced good FCP performance](https://datastudio.google.com/s/kZ9K0d-sBQw). Since their TTFB performance was poor, I am not surprised that their FCP is also slow. It's difficult to achieve good scores on FCP and LCP if TTFB is slow.

Common culprits for poor FCP are render-blocking resources, server response times (anything associated with a slow TTFB), large network payloads, and more.

### Largest Contentful Paint (LCP)

[Largest Contentful Paint (LCP)](https://web.dev/lcp/) measures the time from start load to when the browser renders the largest image or text in the viewport.

![image](insert_image_url_here)

LCP was faster on desktop than mobile. TTFB affects LCP like FCP.  Comparisons by device, connection type, and rank all mirror the trends of FCP. Render-blocking resources, total weight, and loading strategies all affect LCP performance.

![image](insert_image_url_here)

[offline still mirrors fcp - see that explanation and include anything possibly unique for lcp - like maybe the image isn't in the cache or font-display block and no font in the cache. Though then something else would be marked as lcp so not sure it's any different than fcp in terms of reasons]

![image](insert_image_url_here)

For LCP, the differences in performance by rank were closer than FCP. Also, a higher proportion of origins in the top 1,000 had poor LCP. On WordPress, [28% of origins experienced good LCP](https://datastudio.google.com/s/kvq1oJ60jaQ). This is an opportunity to improve user experience as poor LCP is usually caused by a handful of problems.

### The LCP Element

Let's take a deeper dive look at the LCP element.

![image](insert_image_url_here)

IMG, DIV, P, and H1 made up 83% of all LCP nodes (on mobile). This doesn't tell us if the content was an image or text though as background images can be applied with CSS.

![image](insert_image_url_here)

We can see that 71-79% of pages had an LCP element that was an image, regardless of HTML node. Furthermore, desktop devices had a higher rate of LCPs as images. This could be due to less real estate on smaller screens pushing images out of the viewport resulting in heading text being the largest element.

In both cases, images comprised the majority of LCP elements. This warrants a deeper dive into how those images are loading.

![image](insert_image_url_here)

For user experience, we want LCP elements to load as fast as possible. User experience is why LCP was selected as one of the Core Web Vitals. We do not want it to be lazy-loaded nor decoded asynchronously as that further delays the render. However, we can see that 9.3% of pages were using the native loading=lazy flag on an LCP `<img>` element.

Not all browsers support native lazy loading. Popular lazy loading polyfills detect a "lazyload" class on an image element. Thus, we can identify more possibly lazy-loaded images by adding images with a "lazyload" class to the total. The percent of sites probably lazy loading their LCP `<img>` element jumps up to 16.5% on mobile.

Lazy-loading your LCP element will result in worse performance. Don't do it! Luckily, only 0.4% of sites were decoding their LCP images asynchronously. And, the negative impact of asynchronous decode is not as high as lazy loading.

{{ figure_markup(
  content="354 websites",
  caption="attempted to use native lazy-loading on LCP elements that are not images or iframes",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

Interestingly, 354 origins on desktop attempted to use native-lazy loading on HTML elements that do not support the loading attribute (e.g., `<div>`). The loading attribute is only supported on `<img>` and  sometimes `<iframe>` elements ([caniuse](https://caniuse.com/loading-lazy-attr)).

### Cumulative Layout Shift (CLS)

![image](insert_image_url_here)

[Cumulative Layout Shift (CLS)](https://web.dev/cls/) is characterized by how much shift a user experiences, not how long it takes to visually see something like FCP and LCP. As such, performance by device was fairly equivalent.

![image](insert_image_url_here)

Performance degradation from 4G to 3G and below was not as pronounced as with FCP and LCP. Some degradation exists, but it's not reflected in the device data, only the connection type.

![image](insert_image_url_here)

For ranking, CLS performance showed an interesting trough for the top 10,000 websites. In addition, all the ranked groups above 1M performed worse than the sites ranked under 1M. Since the "all"  group had better performance than all the other ranked groupings the sub-1M group performs better. Wordpress may again play a role in this as [60% of origins on Wordpress experienced a good CLS](https://datastudio.google.com/s/qG00yMxSa3o).

Common culprits for poor CLS include not reserving space for images, text shifts when web fonts are loaded, top banners inserted after first paint, non-composited animations, and iframes.

### First Input Delay (FID)

[First Input Delay (FID)](https://web.dev/fid/) measures the time from when a user first interacts with a page to the time the browser begins processing event handlers in response to that interaction.

![image](insert_image_url_here)

FID performance was better on desktop than on mobile devices likely due to device speeds which can better handle larger amounts of JavaScript.

![image](insert_image_url_here)

FID performance degraded some by connection type, but less so than the other metrics. The high distribution of scores seems to be reducing the amount of variance we're seeing in the analysis.

![image](insert_image_url_here)

FID performance by rank was flat.

For all FID metrics, we see very large bars in the "good" category which tells me we should work toward finding a better metric. The good news is the [Chrome team is evaluating this now](https://web.dev/better-responsiveness-metric/) and would like your feedback.

If your site's performance is not in the "good" category, then you definitely have a performance problem. A common culprit for FID issues is too much long-running JavaScript. Keep your bundle sizes small and pay attention to third-party scripts.

### Total Blocking Time (TBT)

> The Total Blocking Time (TBT) metric measures the total amount of time between First Contentful Paint (FCP) and Time to Interactive (TTI) where the main thread was blocked for long enough to prevent input responsiveness. --[Web.dev](https://web.dev/tbt/) ]

[Total Blocking Time (TBT)](https://web.dev/tbt/) is a lab-based metric that helps us debug potential interactivity issues. FID is a field-based metric, and TBT is its lab-based analog. Currently, when evaluating client websites, I reach for total blocking time TBT as another indicator of possible performance issues due to JavaScript.

Unfortunately, TBT is not measured in the Chrome User Experience Report. But, we can still get an idea of what's going on using the HTTP Archive Lighthouse data (only collected for mobile):

![image](insert_image_url_here)

<p class="note"><strong>Note:</strong> The groups in the chart are based off of the Lighthouse score for TBT (e.g., >= 0.9 results in "good"). Due to rounding of the score, some TBT values slightly above 200ms get categorized as "good" (and similarly at the 600ms threshold).</p>

Remember that the data is a single, throttled-CPU Lighthouse run through WebPageTest and does not reflect real user experiences. Yet, potential interactivity looked much worse when looking at TBT versus FID. The "real" evaluation of your interactivity is probably somewhere between. Thus, if your FID is "good", take a look at TBT in case you're missing some poor user experiences that FID can't catch yet. The same issues that cause poor FID also cause poor TBT.

<!-- TODO: check -->
{{ figure_markup(
  content="67 seconds",
  caption="Longest TBT",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

## Conclusion

We still have a long way to go to provide great user experiences, but we can take steps to improve them.

First, you cannot improve performance unless you can measure it. A good first step here is to measure your site using real user devices and to set up real-user monitoring (RUM). You can get a flavor of how your site performs with Chrome users with the [CrUX dashboard launcher](https://rviscomi.github.io/crux-dash-launcher/) (if your site is in the dataset). You should set up a RUM solution that measures across multiple browsers. You can build this yourself or use one of many analytics vendors' solutions.

Second, as new features in HTML, CSS, and JavaScript are released, make sure you understand them before implementing them. Use A/B testing to verify that adopting a new strategy results in improved performance. For example, don't lazy-load images above the fold. If you have a RUM tool implemented, you can better detect when your changes accidentally cause regressions.

Finally, until we have a better metric for interactivity, optimize for both FID (field/real-user data) and TBT (lab data). Take a look at the [proposals](https://web.dev/better-responsiveness-metric/) for new metrics and participate by providing your own feedback.

What did you find most interesting or surprising? Share your thoughts with us on Twitter ([@HTTPArchive](https://twitter.com/HTTPArchive))!
