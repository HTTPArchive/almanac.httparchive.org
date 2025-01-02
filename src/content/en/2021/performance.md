---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Performance
description: Performance chapter of the 2021 Web Almanac covering Core Web Vitals (Largest Contentful Paint, Cumulative Layout Shift, First Input Delay) as well as First Contentful Paint and Time to First Byte.
hero_alt: Hero image of Web Almanac characters images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [siakaramalegos]
reviewers: [rviscomi, kevinfarrugia, estelle, ziemek-bucko, jzyang, fili, tunetheweb, samarpanda, edmondwwchan]
analysts: [siakaramalegos, rviscomi, Nithanaroy]
editors: [jzyang]
translators: []
results: https://docs.google.com/spreadsheets/d/13xhPx6o2Nowz_3b3_5ojiF_mY3Lhs25auBKM6eqGZmo/
siakaramalegos_bio: Sia Karamalegos is a web developer, international conference speaker, and writer. She is a Google Developer Expert in Web Technologies, a Cloudinary Media Developer Expert, a Stripe Community Expert, and co-organizes the Eleventy Meetup. Check out her writing, speaking, and newsletter on <a hreflang="en" href="https://sia.codes/">sia.codes</a> or find her on <a hreflang="en" href="https://x.com/thegreengreek">Twitter</a>.
featured_quote: The more we can set up smart defaults for performance at the framework level, the better we can make the web while also make developers' jobs easier.
featured_stat_1: 37%
featured_stat_label_1: Percent of top 1,000 websites passing Core Web Vitals
featured_stat_2: 79%
featured_stat_label_2: Pages on desktop with an image as an LCP element
featured_stat_3: 67 s
featured_stat_label_3: Longest total blocking time
---

## Introduction

Performance is important for user experience. Slow-to-load and slow-to-respond websites frustrate users and cause lost conversions. This is the first year that the <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals</a> have <a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">contributed to Google search rankings</a>. As such, we've seen greater interest in improving website performance which is great news for users.

*What are our top takeaways from this year's report?* First, we still have a long way to go in providing a good user experience. For example, faster networks and devices have not yet reached the point where we can ignore how much JavaScript we deliver to a site; and, we may never get there. Second, sometimes we misuse new features for performance, resulting in poorer performance. Third, we need better metrics for measuring interactivity, and those are on the way. And fourth, CMS- and framework-level work on performance can significantly impact user experience for the top 10M websites.

*What's new this year?* We're excited to share performance data by traffic ranking for the first time. We also have all the core performance metrics from previous years. Finally, we added a deeper dive into the Largest Contentful Paint (LCP) element.

### Notes on Methodology

One thing that makes the performance chapter different from the others is that we rely heavily on the <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report</a> (CrUX) for our analyses. Why? If our number one priority is user experience, then the best way to measure performance is with real user data (real user metrics, or RUM for short).

<figure>
<blockquote>The Chrome User Experience Report provides user experience metrics for how real-world Chrome users experience popular destinations on the web.</blockquote>
<figcaption>— <cite><a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report</a></cite></figcaption>
</figure>

CrUX data only provides high-level field/RUM metrics and only for the Chrome browser. Additionally, CrUX reports data by origin, or website, instead of by page.

We supplement our CrUX RUM data with lab data from WebPageTest in HTTP Archive. WebPageTest includes very detailed information about each page, including the full Lighthouse report. Note that WebPageTest measures performance in [locations across the U.S.](./methodology#webpagetest) The performance data in CrUX is global since it represents real user page loads.

When comparing performance year-over-year, keep in mind that:

- The <a hreflang="en" href="https://web.dev/articles/cls-web-tooling">Cumulative Layout Shift (CLS) calculation has changed</a> since 2020.
- The <a hreflang="en" href="https://web.dev/articles/cls-web-tooling#additional-updates">First Contentful Paint (FCP) thresholds ("good", "needs improvement", and "poor") have changed</a> since 2020.
- Last year's report was based on August 2020 data, and this year's report was based on the July 2021 run.

Read the full [methodology](./methodology) for the Web Almanac to learn more.

## High-Level Performance: Core Web Vitals

Before we dive into the individual metrics, let's take a look at combined performance for <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals</a> (CWV). Core Web Vitals (LCP, CLS, FID) are a set of performance metrics focused on user experience. They focus on loading, interactivity, and visual stability.

Web performance is notorious for an alphabet soup of metrics, but the community is coalescing on this framework.

This section focuses on websites that reached the "good" threshold on all three CWV metrics to understand how the web is performing at a high level. In the Analysis by Metric section, we'll cover the same charts by each metric in detail, plus more metrics not in the CWV.

### By Device

{{ figure_markup(
  image="performance-1-good-cwv-by-device.png",
  caption="Good Core Web Vitals by Device from 2020 to 2021.",
  description="Bar chart showing the percent of origins with good Core Web Vitals in 2020 and 2021. In 2020, 34% of desktop websites were good and 24% of mobile websites. In 2021, 41% of desktop websites were good, and 29% of mobile ones.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=116267418&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

<aside class="note"><strong>Note:</strong> As the CLS calculation changed since last year, this is not an apples-to-apples comparison.</aside>

Core Web Vitals for websites in the Chrome User Experience Report improved year-over-year. But, a good part of this improvement could be due to a change in the CLS calculation, not necessarily to a performance improvement in CLS. The resulting CLS "improvement" was 8 points on desktop (2 for mobile). LCP improved by 7 points for desktop (2 for mobile). FID was already at 100% for desktop for both years and improved by 10 points on mobile.

As in previous years, performance was better on desktop machines than mobile devices. This is why it's crucial to test your site's performance on real mobile devices and to measure real user metrics (i.e., field data). Emulating mobile in developer tools is convenient in the lab (i.e., development) but not representative of real user experiences.

### By Effective Connection Type

The data by connection type in CrUX can be difficult to understand. It is not based on traffic. If a website has any experiences in a connection type, then it increases the denominator for that connection type. If the experiences were good for that website in that connection type, then it increases the numerator. Said another way, for all the websites which experienced page loads at 4G speed, 36% of those websites had good CWV:

{{ figure_markup(
  image="performance-2-good-cwv-by-ect.png",
  caption="Good CWV performance by effective connection type.",
  description="Bar chart showing the percent of origins in a connection type with good Core Web Vitals. The offline category had 44% of websites with good CWV, 0% for slow 2G and 2G, 5% for 3G, and 36% for 4G.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=150765595&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

Faster connections correlated with better Core Web Vitals performance. Offline performance was better presumably because of service worker caching in progressive web apps. Yet, the number of origins in the offline effective connection type category is negligible at 2,634 total (0.02%).

The top takeaway is that 3G and lower speeds correlated with significant performance degradation. Consider providing pared-down experiences for access at low connection speeds (e.g., <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/save-data/">data saver mode</a>). Profile your site with devices and connections that represent your users (based on your analytics data).

{{ figure_markup(
  image="performance-3-change-in-ect.png",
  caption="Change in effective connection type 2020-2021 .",
  description="Bar chart showing the percent of total origins within each connection type for 2020 and 2021. The offline category went from 0% to 0% of origins (2020 to 2021), 1% to 0% for slow 2G and 2G, 27% to 25% for 3G, and 72% to 75% for 4G.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=658987455&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

Earlier, we mentioned year-over-year improvements in LCP and FID improvements. These could be partly due to faster mobile devices and mobile networks. The chart above shows total origins accessed on 3G dropped by 2 percentage points while 4G access increased by 3 percentage points. Percent of origins is not necessarily correlated with traffic. But, I would guess if people have more access to higher speeds, then more origins would be accessed from that connection type.

Performance by connection type would be easier to understand if we could start tracking by traffic and not just origin.  It would also be nice to see data for higher speeds. However, [the API is currently limited](https://developer.mozilla.org/docs/Glossary/Effective_connection_type) to grouping anything above 4G as 4G.

### By Geographic Region

{{ figure_markup(
  image="performance-4-top-cwv-country.png",
  caption="Top 30 regions for good CWV performance.",
  description="Bar chart showing the percent of origins within a country with good CWV. Korea, Republic of 56%, Japan 50%, Czechia 48%, Germany 47%, Netherlands 45%, Taiwan, Province of China 45%, Belgium 45%, Canada 43%, United Kingdom of Great Britain and Northern Ireland 42%, Poland 42%, United States of America 40%, Romania 38%, France 38%, Ukraine 37%, Russian Federation 35%, Turkey 34%, Spain 34%, Italy 33%, Australia 28%, Viet Nam 28%, Thailand 27%, Malaysia 27%, Indonesia 20%, Mexico 19%, Chile 19%, Brazil 17%, Philippines 17%, India 16%, Colombia 15%, Argentina 14%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=162241310&format=interactive",
  width=645,
  height=792,
  sheets_gid="2016679282",
  sql_file="web_vitals_by_country.sql"
  )
}}

Regions in parts of Asia and Europe continued to have higher performance. This may be due to higher network speeds, wealthier populations with faster devices, and closer edge-caching locations. We should understand the dataset better before drawing too many conclusions.

CrUX data is only gathered in Chrome. The percent of origins by country does not align with relative population sizes. Reasons may include differences in browser share, in-app browsing, device share, level of access, and level of use. Keep these caveats in mind when evaluating regional-level differences and context for all CrUX analyses.

### By Rank

This year for the first time, we have ranking data! ​​CrUX determines ranking by the number of page views per website measured in Chrome. In the charts, the categories are additive. The top 10,000 sites include the top 1,000 sites, and so forth. See the [methodology](./methodology#chrome-ux-report) for more details.

{{ figure_markup(
  image="performance-7-cwv-by-rank.png",
  caption="Good CWV performance by rank.",
  description="Bar chart showing percent of websites in each ranking group with good CWV. 37% of the top 1,000 websites had good CWV, 31% of the top 10,000, 29% of the top 100,000, 30% of the top 1,000,000, and 32% of all origins in CrUX.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=444585880&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

The top 1,000 sites significantly outperformed the rest in Core Web Vitals. An interesting trough of poorer performance occurs in the middle of the chart which is due to CLS. FID was flat across all groupings. All other metrics correlated with higher performance for higher ranking.

Correlation is not causation. Yet countless companies have shown performance improvements leading to bottom-line business impacts (<a hreflang="en" href="https://wpostats.com/">WPO stats</a>). You don't want performance to be the reason you can't achieve higher traffic and increased engagement.

## Analysis by Metric

In this section, we dive into each metric. For those who are less familiar, we've included links to articles that explain each metric in depth.

### Time-to-First-Byte (TTFB)

<a hreflang="en" href="https://web.dev/articles/ttfb">Time-to-first-byte</a> (TTFB) is the time between the browser requesting a page and when it receives the first byte of information from the server. It is the first metric in the chain for website loading. A poor TTFB will result in a chain reaction impacting FCP and LCP. It's why we're talking about it first.

{{ figure_markup(
  image="performance-TTFB-by-device.png",
  caption="TTFB performance by device.",
  description="Stacked bar chart showing TTFB performance for desktop and mobile devices. For desktop devices, 26% of websites had good (< 0.5s), 55% needs improvement, and 19% poor (>= 1.5s) TTFB performance. For mobile, 15% were good, 59% needs improvement, and 26% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=594735556&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

TTFB was faster on desktop than mobile, presumably because of faster network speeds. Compared to [last year](../2020/performance#fig-17_), TTFB marginally improved on desktop and slowed on mobile.

{{ figure_markup(
  image="performance-TTFB-by-ect.png",
  caption="TTFB performance by connection type.",
  description="Stacked bar chart showing TTFB performance for effective connection type. For offline websites, 43% had good, 39% needs improvement, and 18% poor performance. For slow 2G, 1% were good, 2% needs improvement, and 98% poor. For 2G, 0% were good, 2% needs improvement, and 97% poor. For 3G, 1% were good, 27% needs improvement, and 72% poor. For 4G, 19% were good, 58% needs improvement, and 23% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1059484029&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

We have a long way to go for TTFB. 75% of our websites were in the 4G connection group and 25% in the 3G group, with the remaining ones negligible. At 4G effective speeds, only 19% of origins had "good" performance.

You may be asking yourself how TTFB can even occur with offline connections. Presumably, most of the offline sites that record and send TTFB data use [service worker caching](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Offline_Service_workers). TTFB measures how long it takes the first byte of the response for the page to be received, even if that response is coming from the Cache Storage API or the HTTP Cache. An actual server doesn't have to be involved. If the response requires action from the service worker, then the time it takes the service worker thread to start up and handle the response can also contribute to TTFB. But even considering service worker startup times, these sites on average receive their first byte faster than the other connection categories.

{{ figure_markup(
  image="performance-TTFB-by-rank.png",
  caption="TTFB performance by rank.",
  description="Stacked bar chart showing TTFB performance for each ranking group. For the top 1,000 websites, 32% had good, 63% needs improvement, and 5% poor performance. For the top 10,000, 27% were good, 66% needs improvement, and 7% poor. For the top 100,000, 22% were good, 65% needs improvement, and 13% poor. For the top 1,000,000, 18% were good, 62% needs improvement, and 20% poor. For all, 18% were good, 58% needs improvement, and 24% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=829561432&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

For rank, TTFB was faster for higher-ranking sites. One reason could be that most of these are larger companies with more resources to prioritize performance. They may focus on improving server-side performance and delivering assets through edge CDNs. Another reason could be selection bias - the top origins might be accessed more in regions with closer servers, i.e., lower latency.

One more possibility has to do with CMS adoption. The [CMS Chapter](./cms) shows CMS adoption by rank.

{{ figure_markup(
  image="cms-adoption-by-rank.png",
  caption="CMS adoption by rank.",
  description="Bar chart showing percent of websites using a CMS for each ranking category. On mobile, the numbers are 7% of websites in the top 1,000, 15% in the top 10,000, 20% in the top 100,000, 29% in the top 1,000,000, and 42% for all sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=409766380&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1gAJh4VcSEU6-6aQxBiTFl-7cbyHukfdhg-Iaq9y5pnc/#gid=158167539",
  sql_file="../cms/cms_adoption_by_rank.sql"
  )
}}

42% of pages (mobile) in the "all" group used a CMS whereas the top 1,000 sites only had 7% adoption.

Then, if we look at the top 5 CMSs by rank, we see that WordPress has the highest adoption at for 33.6% of "all" pages:

{{ figure_markup(
  image="top-cmss-by-rank.png",
  caption="Top 5 CMSs by rank.",
  description="Bar chart showing the top CMSs percent of share of each ranking category. WordPress had 3.1% of the top 1,000, 8.6% of the top 10,000, 13.2% of the top 100,000, 21.1% of the top 1,000,000, and 33.6% of all sites. The remaining CMSs had less than 3% share of all rankings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1745757207&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1gAJh4VcSEU6-6aQxBiTFl-7cbyHukfdhg-Iaq9y5pnc/#gid=670045665",
  sql_file="../cms/top_cms_by_rank.sql"
  )
}}

Finally, if we look at the <a hreflang="en" href="https://datastudio.google.com/s/o6zLzlTpWaI">Core Web Vitals Technology Report</a>, we see how each CMS performs by metric:

{{ figure_markup(
  link="https://datastudio.google.com/s/o6zLzlTpWaI",
  image="cms_ttfb_cwv_report.png",
  caption='Origins having good TTFB by CMS (<a hreflang="en" href="https://datastudio.google.com/s/o6zLzlTpWaI">Core Web Vitals Technology Report</a>)',
  description="Time series chart of Origins Having Good TTFB for WordPress, Wix, and Squarespace. In July, WordPress and Wix were at 5% and Squarespace at 20%."
  )
}}

Only 5% of origins on WordPress experienced good TTFB in July 2021. Considering WordPress's large share of the top 10M sites, its poor TTFB could be a contributor to the TTFB degradation by rank.

### First Contentful Paint (FCP)

<a hreflang="en" href="https://web.dev/articles/fcp">First Contentful Paint (FCP)</a> measures the time from when a load first begins until the browser first renders any contentful part of the page (e.g, text, images, etc.).

{{ figure_markup(
  image="performance-FCP-by-device.png",
  caption="FCP performance by device.",
  description="Stacked bar chart showing FCP performance for desktop and mobile devices. For desktop devices, 60% of websites had good (< 1.8s), 27% needs improvement, and 13% poor (>= 3.0s) FCP performance. For mobile, 38% were good, 38% needs improvement, and 24% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1509111466&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

FCP was faster on desktop than mobile, likely due to both faster average network speeds and faster processors. Only 38% of origins had good FCP on mobile. Render-blocking resources such as synchronous JavaScript can be a common culprit. Because TTFB is the first part of FCP, poor TTFB will make it difficult to achieve a good FCP.

<aside class="note"><strong>Note:</strong> The thresholds for FCP have changed since last year. Be careful if you try to compare this year's data to last year's data.</aside>

{{ figure_markup(
  image="performance-FCP-by-ect.png",
  caption="FCP performance by connection type.",
  description="Stacked bar chart showing FCP performance for effective connection type. For offline websites, 38% had good, 26% needs improvement, and 36% poor performance. For slow 2G, 100% were poor. For 2G, 1% were needs improvement, and 99% poor. For 3G, 4% were good, 21% needs improvement, and 75% poor. For 4G, 46% were good, 35% needs improvement, and 19% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=679577784&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

Origins at 3G and below speeds experienced significant degradations in FCP. Again, ensure that you are profiling your website using real devices and networks that reflect your user data from analytics. Your JavaScript bundles may not seem significant when you're only profiling on high-end desktops with fiber connections.

Offline connections were closer in performance to 4G though not quite as good. Service worker start-up time plus multiple cache reads could have contributed. More factors come into play with FCP than with TTFB.

{{ figure_markup(
  image="performance-FCP-by-rank.png",
  caption="FCP performance by rank.",
  description="Stacked bar chart showing FCP performance for each ranking group. For the top 1,000 websites, 67% had good, 28% needs improvement. For the top 10,000, 62% were good, 31% needs improvement, and 7% poor. For the top 100,000, 54% were good, 35% needs improvement, and 12% poor. For the top 1,000,000, 49% were good, 35% needs improvement, and 16% poor. For all, 45% were good, 35% needs improvement, and 20% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=965739974&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

Like TTFB, FCP improved with higher rankings. Also like TTFB, only <a hreflang="en" href="https://datastudio.google.com/s/kZ9K0d-sBQw">19.5% of origins on WordPress experienced good FCP performance</a>. Since their TTFB performance was poor, it is not surprising that their FCP is also slow. It's difficult to achieve good scores on FCP and LCP if TTFB is slow.

Common culprits for poor FCP are render-blocking resources, server response times (anything associated with a slow TTFB), large network payloads, and more.

### Largest Contentful Paint (LCP)

<a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint (LCP)</a> measures the time from start load to when the browser renders the largest image or text in the viewport.

{{ figure_markup(
  image="performance-LCP-by-device.png",
  caption="LCP performance by device.",
  description="Stacked bar chart showing LCP performance for desktop and mobile devices. For desktop devices, 60% of websites had good (< 2.5s), 27% needs improvement, and 12% poor (>= 4s) LCP performance. For mobile, 45% were good, 35% needs improvement, and 19% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=556816803&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

LCP was faster on desktop than mobile. TTFB affects LCP like FCP.  Comparisons by device, connection type, and rank all mirror the trends of FCP. Render-blocking resources, total weight, and loading strategies all affect LCP performance.

{{ figure_markup(
  image="performance-LCP-by-ect.png",
  caption="LCP performance by connection type.",
  description="Stacked bar chart showing LCP performance for effective connection type. For offline websites, 49% had good, 17% needs improvement, and 34% poor performance. For slow 2G, 1%  were needs improvement and 99% poor. For 2G, 4% were needs improvement and 96% poor. For 3G, 8% were good, 28% needs improvement, and 65% poor. For 4G, 51% were good, 33% needs improvement, and 16% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=583947675&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

Offline origins with good LCP more closely matched 4G experiences, though poor LCP experiences were higher for offline. LCP occurs after FCP, and the additional budget of 0.7 seconds could be why more offline websites achieved good LCP than FCP.

{{ figure_markup(
  image="performance-LCP-by-rank.png",
  caption="LCP performance by rank.",
  description="Stacked bar chart showing LCP performance for each ranking group. For the top 1,000 websites, 64% had good, 25% needs improvement, and 11% poor performance. For the top 10,000, 59% were good, 30% needs improvement, and 11% poor. For the top 100,000, 55% were good, 32% needs improvement, and 13% poor. For the top 1,000,000, 53% were good, 33% needs improvement, and 14% poor. For all, 50% were good, 33% needs improvement, and 17% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1080361066&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

For LCP, the differences in performance by rank were closer than FCP. Also, a higher proportion of origins in the top 1,000 had poor LCP. On WordPress, <a hreflang="en" href="https://datastudio.google.com/s/kvq1oJ60jaQ">28% of origins experienced good LCP</a>. This is an opportunity to improve user experience as poor LCP is usually caused by a handful of problems.

#### The LCP Element

Let's take a deeper dive into the LCP element.

{{ figure_markup(
  image="performance-top-15-lcp-nodes.png",
  caption="Top 15 LCP HTML element nodes.",
  description="Bar chart showing the percent share of pages for each node type for the LCP element- data listed by desktop then mobile: `IMG` 47% and 42%, `DIV` 28% and 27%, `P` 6% and 10%, `H1` 3% and 5%, `SECTION` 3% and 2%, undetected 2% and 2%, `H2` 2% and 2%, `A` 1% and 2%, `SPAN` 1% and 1%, `HEADER` 1% and 1%, `LI` 1% and 1%, `RS-SBG` 1% and 1%, `H3` 0% and 1%, `TD` 1% and 1%, `VIDEO` 0% and 0%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1549429021&format=interactive",
  width=600,
  height=909,
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

IMG, DIV, P, and H1 made up 83% of all LCP nodes (on mobile). This doesn't tell us if the content was an image or text, as background images can be applied with CSS.

{{ figure_markup(
  image="performance-lcp-with-image.png",
  caption="LCP elements with images, by device.",
  description="Bar chart showing 79% of desktop pages have an LCP element with an image and 71% of mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=992354142&format=interactive",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

We can see that 71-79% of pages had an LCP element that was an image, regardless of HTML node. Furthermore, desktop devices had a higher rate of LCPs as images. This could be due to less real estate on smaller screens pushing images out of the viewport resulting in heading text being the largest element.

In both cases, images comprised the majority of LCP elements. This warrants a deeper dive into how those images are loading.

{{ figure_markup(
  image="performance-lcp-antipatterns.png",
  caption="LCP elements with potential performance anti-patterns.",
  description="Bar chart showing 9.3% of pages on mobile use native lazy load on the LCP element, 16.5% probably lazy load, and 0.4% use async decode.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=130632749&format=interactive",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

For user experience, we want LCP elements to load as fast as possible. User experience is why LCP was selected as one of the Core Web Vitals. We do not want it to be lazy-loaded as that further delays the render. However, we can see that 9.3% of pages used the native loading=lazy flag on the LCP `<img>` element.

Not all browsers support native lazy loading. Popular lazy loading polyfills detect a "lazyload" class on an image element. Thus, we can identify more possibly lazy-loaded images by adding images with a "lazyload" class to the total. The percent of sites probably lazy loading their LCP `<img>` element jumps up to 16.5% on mobile.

Lazy loading your LCP element will result in worse performance. *Don't do it!* WordPress was an early adopter of native lazy loading. The early method was a naive solution applying lazy loading to all images, and the results showed a <a hreflang="en" href="https://web.dev/articles/lcp-lazy-loading">negative performance correlation</a>. They were able to use this data to implement a more nuanced approach for better performance.

The [`decode` attribute](https://developer.mozilla.org/docs/Web/HTML/Element/img#attr-decoding) for images is relatively new. Setting it to `async` can improve load and scroll performance. Currently, 0.4% of sites used the async decode directive for their LCP image. The negative impact of asynchronous decode on an LCP image is currently unclear. Thus, test your site before and after if you choose to set an LCP image to `decode="async"`.

{{ figure_markup(
  content="354",
  caption="Websites attempted to use native lazy-loading on LCP elements that are not images or iframes.",
  classes="big-number",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

Interestingly, 354 origins on desktop attempted to use native lazy-loading on HTML elements that do not support the loading attribute (e.g., `<div>`). The loading attribute is only supported on `<img>` and, in some browsers, `<iframe>` elements (see <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">Can I use</a>).

### Cumulative Layout Shift (CLS)

{{ figure_markup(
  image="performance-CLS-by-device.png",
  caption="CLS performance by device.",
  description="Stacked bar chart showing CLS performance for desktop and mobile devices. For desktop devices, 62% of websites had good (< 0.1), 23% needs improvement, and 15% poor (>= 0.25) CLS performance. For mobile, 62% were good, 21% needs improvement, and 17% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=160840238&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

<a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift (CLS)</a> is characterized by how much layout shift a user experiences, not how long it takes to visually see something like FCP and LCP. As such, performance by device was fairly equivalent.

{{ figure_markup(
  image="performance-CLS-by-ect.png",
  caption="CLS performance by connection type.",
  description="Stacked bar chart showing CLS performance for effective connection type. For offline websites, 87% had good and 4% poor performance. For slow 2G and 2G, 53-52% were good, 15% needs improvement, and 32-33% poor. For 3G, 58% were good, 16% needs improvement, and 26% poor. For 4G, 69% were good, 13% needs improvement, and 18% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1650043738&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

Performance degradation from 4G to 3G and below was not as pronounced as with FCP and LCP. Some degradation exists, but it's not reflected in the device data, only the connection type.

Offline websites had the highest CLS performance of all connection types. For sites with service worker caching, some assets like images and ads that would otherwise cause layout shifts may not be cached. Thus, they would never load and never cause a layout shift. Often fallback HTML for these sites can be more basic versions of the online website.

{{ figure_markup(
  image="performance-CLS-by-rank.png",
  caption="CLS performance by rank.",
  description="Stacked bar chart showing CLS performance for each ranking group. For the top 1,000 websites, 53% had good, 25% needs improvement, and 21% poor performance. For the top 10,000, 46% were good, 27% needs improvement, and 27% poor. For the top 100,000, 48% were good, 26% needs improvement, and 26% poor. For the top 1,000,000, 54% were good, 25% needs improvement, and 21% poor. For all, 61% were good, 23% needs improvement, and 16% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1468770181&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

For ranking, CLS performance showed an interesting trough for the top 10,000 websites. In addition, all the ranked groups above 1M performed worse than the sites ranked under 1M. Since the "all"  group had better performance than all the other ranked groupings the sub-1M group performs better. WordPress may again play a role in this as <a hreflang="en" href="https://datastudio.google.com/s/qG00yMxSa3o">60% of origins on WordPress experienced a good CLS</a>.

Common culprits for poor CLS include not reserving space for images, text shifts when web fonts are loaded, top banners inserted after first paint, non-composited animations, and iframes.

### First Input Delay (FID)

<a hreflang="en" href="https://web.dev/articles/fid">First Input Delay (FID)</a> measures the time from when a user first interacts with a page to the time the browser begins processing event handlers in response to that interaction.

{{ figure_markup(
  image="performance-FID-by-device.png",
  caption="FID performance by device.",
  description="Stacked bar chart showing FID performance for desktop and mobile devices. For desktop devices, 100% of websites had good (< 100ms). For mobile, 90% were good, 10% needs improvement, and 0% poor (>= 300ms).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=230841623&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

FID performance was better on desktop than on mobile devices likely due to device speeds which can better handle larger amounts of JavaScript.

{{ figure_markup(
  image="performance-FID-by-ect.png",
  caption="FID performance by connection type.",
  description="Stacked bar chart showing FID performance for effective connection type. For offline websites, 78% had good, 17% needs improvement, and 5% poor performance. For slow 2G and 2G, 81-82% were good, 18% needs improvement, and 0-1% poor. For 3G, 90% were good and 10% needs improvement. For 4G, 93% were good, 7% needs improvement, and 0% poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1135701788&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

FID performance degraded some by connection type, but less so than the other metrics. The high distribution of scores seemed to reduce the amount of variance in the results.

Unlike the other metrics, FID was worse for offline websites than any other connection category. This could be due to the more complex nature of many websites with service workers. Having a service worker does not eliminate the impact of client-side JavaScript running on the main thread.

{{ figure_markup(
  image="performance-FID-by-rank.png",
  caption="FID performance by rank.",
  description="Stacked bar chart showing FID performance for each ranking group. For all categories, 93-94% had good, 5-7% needs improvement, and 0% poor performance.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1539782601&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

FID performance by rank was flat.

For all FID metrics, we see very large bars in the "good" category which makes it less effective unless we've truly hit peak performance. The good news is the <a hreflang="en" href="https://web.dev/better-responsiveness-metric/">Chrome team is evaluating this now</a> and would like your feedback.

If your site's performance is not in the "good" category, then you definitely have a performance problem. A common culprit for FID issues is too much long-running JavaScript. Keep your bundle sizes small and pay attention to third-party scripts.

### Total Blocking Time (TBT)

<figure>
<blockquote>The Total Blocking Time (TBT) metric measures the total amount of time between First Contentful Paint (FCP) and Time to Interactive (TTI) where the main thread was blocked for long enough to prevent input responsiveness.</blockquote>
<figcaption>— <cite><a hreflang="en" href="https://web.dev/tbt/">Web.dev</a></cite></figcaption>
</figure>

<a hreflang="en" href="https://web.dev/tbt/">Total Blocking Time (TBT)</a> is a lab-based metric that helps us debug potential interactivity issues. FID is a field-based metric, and TBT is its lab-based analog. Currently, when evaluating client websites, I reach for total blocking time TBT as another indicator of possible performance issues due to JavaScript.

Unfortunately, TBT is not measured in the Chrome User Experience Report. But, we can still get an idea of what's going on using the HTTP Archive Lighthouse data (only collected for mobile):

{{ figure_markup(
  image="performance-tbt.png",
  caption="Lighthouse TBT scores.",
  description="Bar chart showing 31% of mobile pages with good TBT (<= 200ms), 11% with needs improvement, and 58% with poor (> 600ms) TBT.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=2135422883&format=interactive",
  sheets_gid="46896816",
  sql_file="tbt.sql"
  )
}}

<aside class="note"><strong>Note:</strong> The groups in the chart are based off of the Lighthouse score for TBT (e.g., >= 0.9 results in "good"). Due to rounding of the score, some TBT values slightly above 200ms get categorized as "good" (and similarly at the 600ms threshold).</aside>

Remember that the data is a single, throttled-CPU Lighthouse run through WebPageTest and does not reflect real user experiences. Yet, potential interactivity looked much worse when looking at TBT versus FID. The "real" evaluation of your interactivity is probably somewhere between. Thus, if your FID is "good", take a look at TBT in case you're missing some poor user experiences that FID can't catch yet. The same issues that cause poor FID also cause poor TBT.

{{ figure_markup(
  content="67 seconds",
  caption="Longest TBT.",
  classes="medium-number",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

## Conclusion

Performance improved since 2020. Though we still have a long way to go to provide great user experience, we can take steps to improve it.

First, you cannot improve performance unless you can measure it. A good first step here is to measure your site using real user devices and to set up real-user monitoring (RUM). You can get a flavor of how your site performs with Chrome users with the <a hreflang="en" href="https://rviscomi.github.io/crux-dash-launcher/">CrUX dashboard launcher</a> (if your site is in the dataset). You should set up a RUM solution that measures across multiple browsers. You can build this yourself or use one of many analytics vendors' solutions.

Second, as new features in HTML, CSS, and JavaScript are released, make sure you understand them before implementing them. Use A/B testing to verify that adopting a new strategy results in improved performance. For example, don't lazy-load images above the fold. If you have a RUM tool implemented, you can better detect when your changes accidentally cause regressions.

Third, continue to optimize for both FID (field/real-user data) and TBT (lab data). Take a look at the <a hreflang="en" href="https://web.dev/responsiveness/">proposal</a> for a new responsiveness metric and participate by providing feedback. A new <a hreflang="en" href="https://web.dev/smoothness/">animation smoothness metric</a> is also being proposed. In our quest for a faster web, change is inevitable and for the better. As we continue to optimize, you're participation is key.

Finally, we saw that WordPress can impact the performance of the top 10M websites, and maybe more. This is a lesson that every CMS and framework should heed. The more we can set up smart defaults for performance at the framework level, the better we can make the web while also make developers' jobs easier.

What did you find most interesting or surprising? Share your thoughts with us on Twitter ([@HTTPArchive](https://x.com/HTTPArchive))!
