---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Performance
description: Performance chapter of the 2025 Web Almanac covering Core Web Vitals, with deep dives into the Largest Contentful Paint, Cumulative Layout Shift, and Interaction to Next Paint metrics and their diagnostics.
hero_alt: Hero image of Web Almanac characters adding images to a web page, while another Web Almanac character times them with a stopwatch.
authors: []
reviewers: []
analysts: []
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1KJQznDT9tL2IYCbYIcWas2k9OG1rK4pkk9U1qOLgBM0/edit
featured_quote: ...
featured_stat_1: ...
featured_stat_label_1: ...
featured_stat_2: ...
featured_stat_label_2: ...
featured_stat_3: ...
featured_stat_label_3: ...
doi: ...
---

## Introduction

Web performance refers to how quickly and smoothly web pages load and respond to user interactions. Performance plays an important role in shaping engagement, retention, and overall trust, particularly as the web is accessed across a wide range of devices and network conditions. Pages that feel fast and responsive encourage exploration and continued use, while experiences that feel slow or unpredictable can interrupt flow and reduce confidence. Understanding the factors that influence performance is therefore essential to building web experiences that feel reliable and consistent to end users.

Measuring web performance includes a broad set of metrics that describe how pages load, render, and respond to user input in real-world conditions. It is not always possible for the web to feel instantaneous due to device, network, and execution constraints. As a result, performance is not only about speed, but also about how an experience feels while work is in progress. Providing clear feedback while content loads, keeping layouts visually stable, and avoiding unexpected changes help users understand page behavior and feel in control as they interact with a site. Although these aspects can be difficult to measure directly, they play an important role in how users perceive and engage with a website.

These considerations have influenced the development and adoption of user-centric performance metrics called **Core Web Vitals**, these include <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint (LCP)</a>, <a hreflang="en" href="https://web.dev/articles/inp">Interaction to Next Paint (INP)</a>, and <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift (CLS)</a>, and capture key aspects of loading performance, interactivity, and visual stability. While Core Web Vitals were initially available primarily in Chromium-based browsers, support has expanded, with Safari and Firefox <a hreflang="en" href="https://www.debugbear.com/blog/firefox-safari-web-vitals">now reporting</a> key Core Web Vitals, enabling more consistent cross-browser performance measurement.

These metrics are complemented by traditional indicators such as <a hreflang="en" href="https://web.dev/articles/ttfb">Time to First Byte (TTFB)</a> and <a hreflang="en" href="https://web.dev/articles/fcp">First Contentful Paint (FCP)</a>, along with measures of resource loading behavior like Fonts, Images and JavaScript. Together, these signals provide important context for understanding where performance bottlenecks occur and how they influence overall page behavior. A comprehensive overview of modern web performance metrics and measurement techniques can be found at <a hreflang="en" href="https://web.dev/performance">web.dev</a>. 

The **Web Almanac performance** chapter examines these signals at scale across devices and network conditions to provide a data-driven view of the state of web performance. By analyzing real-world data, it highlights where the web is improving, where challenges remain, and which patterns are associated with better user experiences.

## Core Web Vitals Summary

Core Web Vitals are Google’s key performance metrics that measure how fast, responsive, and visually stable a webpage feels to real users. These include Largest Contentful Paint (LCP), which indicates when a page’s main content becomes visible and the page first feels useful; Interaction to Next Paint (INP), which reflects how responsive the page is to user input; and Cumulative Layout Shift (CLS), which measures how often unexpected layout changes occur during a page’s lifetime. The following sections examine how Core Web Vitals have evolved over time across mobile and desktop.

{{ figure_markup(
  image="good-core-web-vitals-devices-years.png",
  caption="The percent of websites having good CWV, segmented by year and desktop vs mobile.",
  description="Bar chart showing the percentage of websites with good Core Web Vitals (CWV) performance by device over time. In 2021, 32% of mobile websites and 41% of desktop websites achieved good CWV scores. This increased to 31% mobile and 44% desktop in 2022, then to 36% mobile and 48% desktop in 2023. By 2024, good CWV performance reached 44% on mobile and 55% on desktop, and further improved in 2025 to 48% for mobile websites and 56% for desktop websites.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=221638490&format=interactive",
  sheets_gid="1060077014",
  sql_file="TODO"
  )
}}

Mobile performance has significantly improved due to advancements in mobile hardware, faster internet connections, and more optimized browsers and applications. Mobile Core Web Vitals have shown consistent year-over-year improvement, increasing from 36% in 2023 to 44% in 2024, and reaching 48% in 2025. This significant rise in mobile performance is largely attributable to advancements in mobile hardware, faster internet connections, and more optimized browsers and applications.

Desktop performance also saw a positive trend, moving from 48% in 2023 to 55% in 2024. However, the improvement for 2025 was marginal, increasing only to 56%.

{{ figure_markup(
  image="good-core-web-vitals-by-rank.png",
  caption="The percentage of websites having good CWV, segmented by rank and device type.",
  description="The chart shows the percentage of websites achieving good Core Web Vitals (CWV) scores by site rank, comparing desktop and mobile performance. Among the top 1,000 websites, 59% of desktop sites have good CWV, compared to 51% on mobile, with mobile performance declining further for the next tiers to 42% for the top 10,000 and 37% for the top 100,000 sites. Desktop performance remains relatively stable across ranks, staying between 55% and 57%, while mobile performance improves again for lower-ranked sites, reaching 49% for the top 10 million and 48% overall.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=293787205&format=interactive",
  sheets_gid="1721986308",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

Performance metrics for top mobile websites show a clear distinction: 
- 51% of the 1,000 most popular mobile websites have good Core Web Vitals (CWV), surpassing the overall mobile CWV of 48%.

However, CWV scores drop significantly for less popular sites:
- The next 10,000 websites score 42%.
- The subsequent 1 million websites score 37%.

This data suggests that top-tier websites are prioritizing performance improvements, while mid-tier websites are still lagging.

In contrast, Desktop performance metrics are more uniformly distributed. This disparity highlights a significant gap in the focus on mobile web app performance compared to desktop, which is likely due to an increasing concentration on native applications.

{{ figure_markup(
  image="good-core-web-vitals-home-secondary-page.png",
  caption="The percent of websites having good CWV, segmented by page type.",
  description="The chart shows the percentage of pages with good Core Web Vitals (CWV) scores for home pages and secondary pages on desktop and mobile. On home pages, 47% of desktop pages and 45% of mobile pages achieve good CWV. On secondary pages, the share increases to 61% on desktop and 56% on mobile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=604736426&format=interactive",
  sheets_gid="1721986308",
  sql_file="TODO"
  )
}}

Secondary pages show a significant advantage over home pages in achieving good CWV results, with a 14% lead on Desktop and an 11% lead on Mobile.This performance gap suggests that secondary pages often benefit from having partially cached information, which contributes to faster page loads. 

<a hreflang="en" href="https://developer.chrome.com/blog/new-soft-navigations-origin-trial">Soft navigation</a> support is expected to aid in a more comprehensive collection of Web Vitals data for within the page navigation.

While the current CWV data indicates better overall performance for secondary pages, a deeper dive into specific aspects such as layout shift, loading performance, and interactivity is necessary to fully understand the user experience, which is what we will cover next.


## Visual Stability

Visual stability is primarily measured by Cumulative Layout Shift (CLS) and remains a key indicator of how predictable and smooth pages feel to users. 

In 2025, CLS adoption and stability continue to trend positively on both desktop and mobile devices. This section focuses on recent years particularly 2023 through 2025 highlighting progress, device differences, and shifts over the last year.

### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS) measures unexpected layout movement during page load and interaction, with higher scores indicating more disruptive visual shifts. CLS scores are categorized into three thresholds: Good (≤ 0.1), Needs Improvement (> 0.1 and ≤ 0.25), and Poor (> 0.25), providing a standardized way to evaluate and compare visual stability across websites.

{{ figure_markup(
  image="good-cls-by-device-2025.png",
  caption="CLS performance by device for 2025",
  description="The chart shows the distribution of Cumulative Layout Shift (CLS) performance by device in 2025, categorized as Good, Needs Improvement, and Poor. On desktop, 72% of pages achieve a Good CLS score, 17% fall into Needs Improvement, and 10% are classified as Poor. Mobile pages perform better overall, with 81% achieving Good CLS, 10% in Needs Improvement, and 9% in the Poor category.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=79158134&format=interactive",
  sheets_gid="1060077014",
  sql_file="TODO"
  )
}}

In 2025, 72% of desktop pages and 81% of mobile pages achieve a Good Cumulative Layout Shift (CLS) score. Desktop pages show a higher share of Needs Improvement CLS (17%) compared to mobile (10%), while the proportion of pages with Poor CLS is similar across devices at around 9-10%. This shows that most pages are close to meeting the CLS threshold, with fewer pages experiencing severe layout instability. 

Compared to 2024, the share of desktop pages with Poor CLS decreased by 1%, with a similar increase in pages classified as Needs Improvement.

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="CLS performance by device",
  description="The chart shows the percentage of websites with good Cumulative Layout Shift (CLS) scores on desktop and mobile from 2021 to 2025. On desktop, the share of sites with good CLS increases from 62% in 2021 to 72% in 2025. On mobile, good CLS increases from 62% in 2021 to 81% in 2025. In each year from 2022 onward, mobile has a higher percentage of sites with good CLS than desktop.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1623776585&format=interactive",
  sheets_gid="1060077014",
  sql_file="TODO"
  )
}}

Looking at the past years, the percentage of websites meeting the Good CLS threshold has increased each year for both desktop and mobile. Desktop CLS improved gradually from 62% in 2021 to 72% in 2025, while mobile saw stronger gains, reaching 81% over the same period.

{{ figure_markup(
  image="good-cls-home-secondary-page.png",
  caption="The percent of websites having good CWV, segmented by page type.",
  description="The chart shows the percentage of pages with good Cumulative Layout Shift (CLS) scores for home pages and secondary pages on desktop and mobile in 2025. For home pages, 71% of desktop pages and 79% of mobile pages achieve good CLS. For secondary pages, the share increases to 73% on desktop and 81% on mobile, with mobile outperforming desktop for both page types.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=24521456&format=interactive",
  sheets_gid="1721986308",
  sql_file="TODO"
  )
}}

Pages beyond the homepage show slightly better visual stability than homepages across both desktop and mobile devices. In 2025, 73% of desktop secondary pages achieve Good CLS compared to 71% of desktop homepages, while on mobile 81% of secondary pages meet the Good CLS threshold versus 79% of mobile homepages. This suggests that homepages, which often contain more dynamic content such as hero media, banners, and promotional elements, remain more prone to layout shifts than secondary pages.

{{ figure_markup(
  image="good-cls-by-month.png",
  caption="Monthly trend of websites with good CLS by device from 2023 to 2025.",
  description="The chart shows the monthly percentage of websites with good Cumulative Layout Shift (CLS) scores on desktop and mobile from January 2023 through early 2025. Desktop increases from approximately 65% at the start of 2023 to around 72% by 2025, while mobile rises from about 75% to roughly 79–80% over the same period. Mobile maintains a higher share of good CLS than desktop throughout the entire timeframe.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=142338615&format=interactive",
  sheets_gid="1891926464",
  sql_file="TODO"
  )
}}

Over time, Good CLS increases steadily on both device types, with mobile consistently outperforming desktop. Despite minor month-to-month fluctuations, both curves trend upward, without much sharp inflection points, suggesting sustained improvements rather than abrupt shifts.

### Back/forward cache (bfcache)

[The back/forward cache (bfcache)](https://web.dev/articles/bfcache) allows browsers to instantly restore a page from memory when users navigate using the browser’s back or forward buttons. Rather than reloading the page and re-executing JavaScript, the browser preserves the page’s state, resulting in near-instant navigations and improved user experience. Because pages are restored in their previous state, BFCache can also help avoid layout shifts that might otherwise occur during re-navigation.

However, all pages are <a hreflang="en" href="https://html.spec.whatwg.org/multipage/nav-history-apis.html#nrr-details-reason">not eligible</a> for BFCache. Eligibility depends on a set of page lifecycle requirements, and pages that violate these constraints fall back to full reloads. While BFCache behavior is handled by the browser, developers <a hreflang="en" href="https://developer.chrome.com/docs/devtools/application/back-forward-cache">can assess eligibility</a> using tools such as Chrome DevTools.

Pages may be excluded from BFCache due to known lifecycle behaviors, including the use of unload or beforeunload event handlers, non-restorable side effects such as active connections or unmanaged timers, and certain third-party scripts that interfere with safe page restoration. Hence, the unload event is deprecated and discouraged due to its negative impact on performance and its incompatibility with the back/forward cache (BFCache). 

Browsers recommend avoiding unload in favor of alternatives such as pagehide and pageshow, a shift that is reflected in recent usage patterns. Compared to 2024, unload handler usage declined across all ranks and both devices in 2025. This reduction suggests that more pages are now eligible for BFCache behavior. Despite this progress, unload handlers remain more common on higher-ranked sites and on desktop, continuing to limit BFCache eligibility for a significant portion of the web, as seen below in the 2025 graph.

{{ figure_markup(
  image="unload-handler-usage.png",
  caption="Unload handler usage by website rank and device (2025)",
  description=”The chart shows the percentage of pages using unload event handlers by website rank on desktop and mobile in 2025. Among the top 1,000 websites, unload handlers appear on 28% of desktop pages and 20% of mobile pages, with usage declining steadily as rank increases. For all websites, unload handlers are present on 11% of desktop pages and 10% of mobile pages, with desktop usage higher than mobile at every rank.”,
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=140804120&format=interactive",
  sheets_gid="1870744021",
  sql_file="TODO"
  )
}}

Unload handler usage decreases consistently as site rank increases. Among higher-traffic websites, unload handlers appear on 28% of desktop pages and 20% of mobile pages in the top 1,000 sites, declining steadily across lower-ranked sites to 11% on desktop and 10% on mobile when considering all pages. At every rank, desktop pages exhibit higher unload handler usage than mobile, indicating that unload handlers remain more prevalent on larger, more complex sites than across the long tail of the web.
