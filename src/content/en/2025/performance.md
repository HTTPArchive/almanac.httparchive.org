---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Performance
description: Performance chapter of the 2025 Web Almanac covering Core Web Vitals, with deep dives into the Largest Contentful Paint, Cumulative Layout Shift, and Interaction to Next Paint metrics and their diagnostics.
hero_alt: Hero image of Web Almanac characters adding images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [25prathamesh, himanshujariyal, hfhashmi]
reviewers: [aarontgrogg, tunetheweb]
analysts: [tannerhodges]
editors: []
translators: []
himanshujariyal_bio: TODO
25prathamesh_bio: TODO
hfhashmi_bio: TODO
aarontgrogg_bio: TODO
results: https://docs.google.com/spreadsheets/d/1KJQznDT9tL2IYCbYIcWas2k9OG1rK4pkk9U1qOLgBM0/edit
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

Web performance refers to how quickly and smoothly web pages load and respond to user interactions. Performance plays an important role in shaping engagement, retention, and overall trust, particularly as the web is accessed across a wide range of devices and network conditions. Pages that feel fast and responsive encourage exploration and continued use, while experiences that feel slow or unpredictable can interrupt flow and reduce confidence. Understanding the factors that influence performance is therefore essential to building web experiences that feel reliable and consistent to end users.

Measuring web performance includes a broad set of metrics that describe how pages load, render, and respond to user input in real-world conditions. It is not always possible for the web to feel instantaneous due to device, network, and execution constraints. As a result, performance is not only about speed, but also about how an experience feels while work is in progress. Providing clear feedback while content loads, keeping layouts visually stable, and avoiding unexpected changes help users understand page behavior and feel in control as they interact with a site. Although these aspects can be difficult to measure directly, they play an important role in how users perceive and engage with a website.

These considerations have influenced the development and adoption of user-centric performance metrics called **Core Web Vitals**, these include <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint (LCP)</a>, <a hreflang="en" href="https://web.dev/articles/inp">Interaction to Next Paint (INP)</a>, and <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift (CLS)</a>, and capture key aspects of loading performance, interactivity, and visual stability. While Core Web Vitals were initially available primarily in Chromium-based browsers, support has expanded, with Safari and Firefox <a hreflang="en" href="https://www.debugbear.com/blog/firefox-safari-web-vitals">now reporting</a> key Core Web Vitals, enabling more consistent cross-browser performance measurement.

These metrics are complemented by traditional indicators such as <a hreflang="en" href="https://web.dev/articles/ttfb">Time to First Byte (TTFB)</a> and <a hreflang="en" href="https://web.dev/articles/fcp">First Contentful Paint (FCP)</a>, along with measures of resource loading behavior like Fonts, Images and JavaScript. Together, these signals provide important context for understanding where performance bottlenecks occur and how they influence overall page behavior. A comprehensive overview of modern web performance metrics and measurement techniques can be found at <a hreflang="en" href="https://web.dev/performance">web.dev</a>.

The **Web Almanac performance** chapter examines these signals at scale across devices and network conditions to provide a data-driven view of the state of web performance. By analyzing real-world data, it highlights where the web is improving, where challenges remain, and which patterns are associated with better user experiences.

### Data Source
TODO: Add a short closing section describing the data sources, collection period, data volume, and browser coverage used in this chapter.

## Core Web Vitals Summary

Core Web Vitals are Google's key performance metrics that measure how fast, responsive, and visually stable a webpage feels to real users. These include Largest Contentful Paint (LCP), which indicates when a page's main content becomes visible and the page first feels useful; Interaction to Next Paint (INP), which reflects how responsive the page is to user input; and Cumulative Layout Shift (CLS), which measures how often unexpected layout changes occur during a page's lifetime. The following sections examine how Core Web Vitals have evolved over time across mobile and desktop.

{{ figure_markup(
  image="good-core-web-vitals-devices-years.png",
  caption="The percent of websites having good CWV, segmented by year and desktop vs mobile.",
  description="Bar chart showing the percentage of websites with good Core Web Vitals (CWV) performance by device over time. In 2021, 32% of mobile websites and 41% of desktop websites achieved good CWV scores. This increased to 31% mobile and 44% desktop in 2022, then to 36% mobile and 48% desktop in 2023. By 2024, good CWV performance reached 44% on mobile and 55% on desktop, and further improved in 2025 to 48% for mobile websites and 56% for desktop websites.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=221638490&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
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
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

Secondary pages show a significant advantage over home pages in achieving good CWV results, with a 14% lead on Desktop and an 11% lead on Mobile.This performance gap suggests that secondary pages often benefit from having partially cached information, which contributes to faster page loads.

<a hreflang="en" href="https://developer.chrome.com/blog/new-soft-navigations-origin-trial">Soft navigation</a> support is expected to aid in a more comprehensive collection of Web Vitals data for within the page navigation.

While the current CWV data indicates better overall performance for secondary pages, a deeper dive into specific aspects of loading performance, interactivity and visual stability is necessary to fully understand the user experience, which is what we will cover in the following sections.

## Loading Speed

A major factor influencing a user's perception of quality and reliability is the initial loading speed of a website. However, 'speed' is inherently relative and difficult to define with a single value in the context of websites. Because performance varies based on a user's device capabilities and network conditions, we cannot rely on a single 'load time' to capture the user experience. Thus, we look at multiple [user-centric metrics](https://web.dev/articles/user-centric-performance-metrics) that measure not just how fast a site loads, but how fast it *feels*.

### First Contentful Paint

To understand the user's first impression of a webpage's speed, we look at [First Contentful Paint (FCP)](https://web.dev/articles/fcp?hl=en). This metric captures the exact time it takes for a page to begin displaying content, measured from the point the user first requested the page. Any page that has a FCP score under 1.8 seconds is considered  'Good', scores between 1.8 and 3.0 seconds indicate that the page 'Needs Improvement,' and a score over 3.0 seconds is considered 'Poor' performance.

{{ figure_markup(
  image="fcp-performance-by-year-and-device-2025.png",
  caption=" Percentage of websites having good, needs improvement, and poor FCP, segmented by year and device type.",
  description="Stacked bar chart showing TTFB (Time to First Byte) performance for 2024 and 2025, for both desktop and mobile device types. Each bar chart has 3 categories: good (under 0.8 seconds), needs improvement (0.8–1.8 seconds), and poor (over 1.8 seconds). In 2024, 68% of desktop websites had good TTFB, 22% needed improvement, and 10% performed poorly. In 2025, 70% of desktop websites have good TTFB, 21% need improvement, and 9% perform poorly. For mobile websites in 2024, 51% of websites had good TTFB, 31% needed improvement, and 18% performed poorly. In 2025, 55% of mobile websites have good TTFB, 29% need improvement, and 16% perform poorly.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1596764241&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

Based on real user data from [Chrome UX Report (CrUX)](https://developer.chrome.com/docs/crux), FCP performance has improved across both desktop and mobile devices since 2024\. Specifically, the proportion of desktop sites achieving a 'Good' FCP rose by 2%, while mobile sites saw a 4% increase.

While the increase is not drastic, we can still attempt to understand what's driving these FCP improvements. We can view the metric as consisting of two distinct parts. The first is the **initial network and server response**, captured by [Time to First Byte (TTFB)](https://web.dev/articles/ttfb). This includes connection setup (such as the TCP/QUIC handshake), redirects, and server processing time, and is primarily influenced by network infrastructure and protocol efficiency. The second part is **client-side rendering**, which begins after the first byte is received. This is the time it takes for browsers to parse and render the first part of the webpage's content, and is influenced by browser engine, render-blocking resources, and user hardware quality.

{{ figure_markup(
  image="ttfb-performance-by-year-and-device-2025.png",
  caption="Percentage of websites having good, needs improvement, and poor TTFB, segmented by year and device type.",
  description="Stacked bar chart showing TTFB (Time to First Byte) performance for 2024 and 2025, for both desktop and mobile device types. Each bar chart has 3 categories: good (under 0.8 seconds), needs improvement (0.8–1.8 seconds), and poor (over 1.8 seconds). In 2024, 54% of desktop websites had good TTFB, 33% needed improvement, and 13% performed poorly. In 2025, 55% of desktop websites have good TTFB, 33% need improvement, and 12% perform poorly. For mobile websites in 2024, 42% of websites had good TTFB, 40% needed improvement, and 19% performed poorly. In 2025, 44% of mobile websites have good TTFB, 40% need improvement, and 17% perform poorly.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=220208816&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )}}

{{ figure_markup(
  image="pages-passing-render-blocking-audit-2025.png",
  caption="Percentage of pages passing the render-blocking Lighthouse audit , segmented by device and year.",
  description="Bar chart showing the percentage of pages passing the render-blocking resources audit for 2024 and 2025, comparing desktop and mobile device types. In 2024, 13% of desktop pages passed the audit and 14% of mobile pages passed. In 2025, 13% of desktop pages passed the audit and 15% of mobile pages passed. Mobile pages show a slight improvement from 2024 to 2025, while desktop pages remain unchanged.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=102924133&format=interactive",
  sheets_gid="1432298892",
  sql_file="render_blocking_resources.sql"
  )
}}

The TTFB data provides partial insight into these FCP gains between 2024 and 2025\. Desktop sites achieving 'Good' TTFB increased by 1% since 2024, while mobile saw a 2% improvement. This suggests network and server-side optimizations contributed reasonably (\~half) to overall FCP improvements. The remaining FCP gains likely stem from client-side factors—such as elimination of render-blocking resources, improved Chrome browser engine, or better user hardware in general. Given that there are no significant improvements in number of pages passing the Lighthouse [render-blocking resources audit](https://developer.chrome.com/docs/lighthouse/performance/render-blocking-resources)  this year compared to 2024, it would seem that a key factor improving FCP across both device types could be the much [improved rendering engine](https://thinksproutinfotech.com/news/how-google-chrome-received-the-highest-ever-speedometer-score/) in Chrome since 2024, which reduces rendering times regardless of individual website optimizations.

### More subsections upcoming
TODO (Humaira)

## Interactivity

### Interaction to Next Paint (INP)

[Interaction to Next Paint (INP)](https://web.dev/articles/inp) is calculated by observing all the interactions made with a page during the session and reporting the worst latency (for most sites). An interaction's latency consists of the single longest duration of a group of event handlers that drive the interaction, from the time the user begins the interaction to the moment the browser is next able to paint a frame.

For an origin to receive a "good" INP score, at least 75% of all sessions need an INP score of 200 milliseconds or less. The INP score is the slowest or near-slowest interaction time for all interactions on the page. See [Details on how INP is calculated](https://web.dev/articles/inp#good-score) for more information.

{{ figure_markup(
  image="inp-performance-by-device-2025.png",
  caption="Distribution of INP performance by device.",
  description="Stacked bar chart showing INP performance by device, categorized as good (under 200 milliseconds), needs improvement (200–500 milliseconds), and poor (over 500 milliseconds). For desktop, 97% of websites have good INP, 2% need improvement, and less than 1% perform poorly. For phones, 77% of websites have good INP, 21% need improvement, and 3% perform poorly.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=73846591&format=interactive",
  sheets_gid="1060077014",
  sql_file="inp_by_device.sql"
) }}

In 2025, mobile INP performance showed encouraging improvement, with 77% of websites achieving good scores—up from 74% in 2024. This 3 percentage point gain represents meaningful progress, as millions of websites now deliver more responsive experiences to mobile users. Desktop performance remained exemplary at 97%, maintaining the high standard established in previous years.

Notably, the mobile-desktop performance gap has begun to narrow, shrinking from 23 percentage points in 2024 to 20 percentage points in 2025. While a 20 percentage point gap remains substantial, this marks the first measurable step toward closing the divide. The trend demonstrates that mobile optimization efforts are gaining traction across the web.

{{ figure_markup(
  image="mobile-inp-performance-by-rank-2025.png",
  caption="INP performance on mobile devices segmented by rank.",
  description="Stacked bar chart showing mobile INP performance by website rank, categorized into good (under 200 milliseconds), needs improvement (200–500 milliseconds), and poor (over 500 milliseconds). For the top 1,000 websites, 63% have good INP, 32% need improvement, and 5% perform poorly. For the top 10,000 websites, 56% are in the good range, 38% need improvement, and 6% are poor. In the top 100,000, 56% are good, 38% need improvement, and 6% are poor. For the top 1,000,000 websites, 64% have good INP, 31% need improvement, and 5% are poor. As the rank increases to the top 10,000,000 websites, 76% are good, 21% need improvement, and 3% are poor. Finally, for all websites, 77% have good INP, 21% need improvement, and 3% are poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1626195308&format=interactive",
  sheets_gid="1354135914",
  sql_file="inp_by_rank.sql"
) }}

The most popular websites showed remarkable INP improvement in 2025, with the top 1,000 sites jumping from 53% to 63% good scores—a 10 percentage point gain that outpaced all other categories. This signals that high-traffic websites are prioritizing interactivity optimization, likely driven by the direct impact on user engagement and business metrics.

While popular sites still lag behind the overall average of 77%, the gap has narrowed significantly. The top 1,000 sites were 21 percentage points below average in 2024 but only 14 percentage points below in 2025—the fastest rate of improvement observed across any category.

This pattern reflects the unique challenges faced by high-traffic websites: more complex functionality, richer interactive features, heavier third-party integrations, and diverse user interaction patterns. E-commerce platforms, social media sites, and news portals inherently require more JavaScript execution than simpler websites, making good INP scores harder to achieve.

The substantial year-over-year improvements suggest that major websites are successfully tackling these challenges through code splitting, interaction optimization, and selective feature loading. As the most visited sites continue to enhance their performance, they set higher standards and provide valuable optimization patterns for the broader web ecosystem.

{{ figure_markup(
  image="good-inp-for-home-pages-and-secondary-pages-2025.png",
  caption="Good INP performance for home pages and secondary pages.",
  description="Bar chart showing the percentage of pages with good INP for home pages and secondary pages on desktop and mobile. For home pages, 97% of desktop pages have good INP, while 80% of mobile pages achieve good INP. For secondary pages, 95% of desktop pages have good INP, compared to 69% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1226158281&format=interactive",
  sheets_gid="1721986308",
  sql_file="inp_by_page_type.sql"
) }}

In a notable shift from 2024, home pages now demonstrate significantly better INP performance than secondary pages on mobile devices. Mobile home pages achieved 80% good INP scores—a 7 percentage point improvement over 2024—while secondary pages declined to 69%, creating an 11 percentage point gap. This divergence represents a change from 2024, when home and secondary pages performed nearly identically (73% vs 72% on mobile). Desktop performance remained strong for both page types at 97% and 95% respectively.

The improvement in home page INP likely reflects increased optimization focus on landing pages, where first impressions are critical. However, the decline in secondary page performance warrants attention, as these pages often contain more complex interactions like filters, carousels, and form validation, while also accumulating JavaScript from third-party widgets and analytics that activate deeper in the user journey.

### Total Blocking Time (TBT)

[Total Blocking Time (TBT)](https://web.dev/articles/tbt) measures the total amount of time after First Contentful Paint (FCP) where the main thread was blocked for long enough to prevent input responsiveness.

TBT is a lab metric and is often used as a proxy for field-based responsiveness metrics like INP, which can only be collected using real user monitoring. [Lab-based TBT and field-based INP](https://colab.research.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2) are correlated, meaning TBT results generally reflect INP trends. A TBT below 200 milliseconds is considered good, but most mobile websites exceed this target significantly.

{{ figure_markup(
  image="distribution-of-tbt-per-page-2025.png",
  caption="TBT per page by percentile.",
  description="Bar chart showing the distribution of Total Blocking Time (TBT) per page in milliseconds (ms) by percentile. At the 10th percentile, desktop TBT is 0 milliseconds, while mobile is 127 milliseconds. At the 25th percentile, desktop TBT is 3 milliseconds, while mobile is 679 milliseconds. At the 50th percentile, desktop has 92 milliseconds of TBT, and mobile rises significantly to 1,916 milliseconds. At the 75th percentile, desktop reaches 336 milliseconds, with mobile at 4,193 milliseconds. Finally, at the 90th percentile, desktop TBT is 802 milliseconds, and mobile climbs to 7,555 milliseconds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=566862109&format=interactive",
  sheets_gid="309018170",
  sql_file="tbt_by_percentile.sql"
) }}

The median TBT on mobile increased to 1,916 milliseconds in 2025—up 58% from 1,209 milliseconds in 2024. Desktop TBT also rose from 67 milliseconds to 92 milliseconds. At the 90th percentile, mobile users now face over 7.5 seconds of blocking time before the page becomes fully interactive.

This presents an apparent contradiction: while field-based INP scores improved, lab-based TBT worsened significantly. Several factors explain this divergence. Sites may have optimized critical interactions that impact INP while allowing background JavaScript to grow heavier. Real-world devices have become more powerful, masking increased code complexity that lab tests reveal using consistent emulated devices. Modern code-splitting strategies defer non-critical JavaScript after initial interactions, reducing early blocking captured by INP while still contributing to total blocking time. Additionally, third-party scripts continue to proliferate, executing outside critical interaction paths.

The widening gap between desktop (92ms median) and mobile (1,916ms median) reinforces the persistent performance inequality between device classes, suggesting that despite INP improvements, the fundamental challenge of main thread blocking has intensified.

### Interactivity conclusion

The main takeaways of the interactivity results are:

* Mobile INP improved to 77% (up from 74%), narrowing the mobile-desktop gap to 20 percentage points
* Top 1,000 websites achieved the strongest gains, improving from 53% to 63% good INP
* Home pages now outperform secondary pages significantly (80% vs 69% on mobile)
* TBT increased 58% despite INP improvements, indicating heavier overall JavaScript execution

## Visual Stability

Visual stability is primarily measured by Cumulative Layout Shift (CLS) and remains a key indicator of how predictable and smooth pages feel to users. In 2025, CLS adoption and stability continue to trend positively on both desktop and mobile devices. This section focuses on recent years particularly 2023 through 2025 highlighting progress, device differences, and shifts over the last year.

### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS) measures unexpected layout movement during page load and interaction, with higher scores indicating more disruptive visual shifts. CLS scores are categorized into three thresholds: Good (≤ 0.1), Needs Improvement (> 0.1 and ≤ 0.25), and Poor (> 0.25), providing a standardized way to evaluate and compare visual stability across websites.

{{ figure_markup(
  image="good-cls-by-device-2025.png",
  caption="CLS performance by device for 2025",
  description="The chart shows the distribution of Cumulative Layout Shift (CLS) performance by device in 2025, categorized as Good, Needs Improvement, and Poor. On desktop, 72% of pages achieve a Good CLS score, 17% fall into Needs Improvement, and 10% are classified as Poor. Mobile pages perform better overall, with 81% achieving Good CLS, 10% in Needs Improvement, and 9% in the Poor category.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=79158134&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

In 2025, 72% of desktop pages and 81% of mobile pages achieve a Good Cumulative Layout Shift (CLS) score. Desktop pages show a higher share of Needs Improvement CLS (17%) compared to mobile (10%), while the proportion of pages with Poor CLS is similar across devices at around 9-10%. This shows that most pages are close to meeting the CLS threshold, with fewer pages experiencing severe layout instability.

[Compared to 2024](../2024/performance#cumulative-layout-shift-cls), the share of desktop pages with Poor CLS decreased by 1%, with a similar increase in pages classified as Needs Improvement.

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="CLS performance by device from 2021 to 2025",
  description="The chart shows the percentage of websites with good Cumulative Layout Shift (CLS) scores on desktop and mobile from 2021 to 2025. On desktop, the share of sites with good CLS increases from 62% in 2021 to 72% in 2025. On mobile, good CLS increases from 62% in 2021 to 81% in 2025. In each year from 2022 onward, mobile has a higher percentage of sites with good CLS than desktop.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1623776585&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

Looking at the past years, the percentage of websites meeting the Good CLS threshold has increased each year for both desktop and mobile. Desktop CLS improved gradually from 62% in 2021 to 72% in 2025, while mobile saw stronger gains, reaching 81% over the same period. However, the increase compared to last year is marginal, with the share of sites meeting the Good CLS threshold on desktop remaining unchanged and mobile improving by only 2%.

{{ figure_markup(
  image="good-cls-home-secondary-page.png",
  caption="The percent of websites having good CWV, segmented by page type.",
  description="The chart shows the percentage of pages with good Cumulative Layout Shift (CLS) scores for home pages and secondary pages on desktop and mobile in 2025. For home pages, 71% of desktop pages and 79% of mobile pages achieve good CLS. For secondary pages, the share increases to 73% on desktop and 81% on mobile, with mobile outperforming desktop for both page types.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=24521456&format=interactive",
  sheets_gid="1721986308",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

Pages beyond the homepage show slightly better visual stability than homepages across both desktop and mobile devices. In 2025, 73% of desktop secondary pages achieve Good CLS compared to 71% of desktop homepages, while on mobile 81% of secondary pages meet the Good CLS threshold versus 79% of mobile homepages. This suggests that homepages, which often contain more dynamic content such as hero media, banners, and promotional elements, remain more prone to layout shifts than secondary pages.

{{ figure_markup(
  image="good-cls-by-month.png",
  caption="Monthly trend of websites with good CLS by device from 2023 to 2025.",
  description="The chart shows the monthly percentage of websites with good Cumulative Layout Shift (CLS) scores on desktop and mobile from January 2023 through early 2025. Desktop increases from approximately 65% at the start of 2023 to around 72% by 2025, while mobile rises from about 75% to roughly 79–80% over the same period. Mobile maintains a higher share of good CLS than desktop throughout the entire timeframe.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=142338615&format=interactive",
  sheets_gid="1891926464",
  sql_file="monthly_cls_lcp.sql"
  )
}}

From 2023 to 2025, the share of sites with Good CLS increases steadily across both device types, with mobile consistently outperforming desktop. While there are minor fluctuations over time, both trends show a gradual upward trajectory with no sharp inflection points, indicating sustained improvements rather than sudden changes.

### Back/forward cache (bfcache)

[The back/forward cache (bfcache)](https://web.dev/articles/bfcache) allows browsers to instantly restore a page from memory when users navigate using the browser's back or forward buttons. Rather than reloading the page and re-executing JavaScript, the browser preserves the page's state, resulting in near-instant navigations and improved user experience. Because pages are restored in their previous state, BFCache can also help avoid layout shifts that might otherwise occur during re-navigation.

However, all pages are <a hreflang="en" href="https://html.spec.whatwg.org/multipage/nav-history-apis.html#nrr-details-reason">not eligible</a> for BFCache. Eligibility depends on a set of page lifecycle requirements, and pages that violate these constraints fall back to full reloads. 
While BFCache behavior is ultimately handled by the browser, developers can <a hreflang="en" href="https://developer.chrome.com/docs/devtools/application/back-forward-cache">evaluate page eligibility</a> by using Chrome DevTools.

Pages may be excluded from BFCache due to known lifecycle behaviors, including the use of unload or beforeunload event handlers, non-restorable side effects such as active connections or unmanaged timers, and certain third-party scripts that interfere with safe page restoration. Hence, the unload event is deprecated and discouraged due to its negative impact on performance and its incompatibility with the back/forward cache (BFCache).

Browsers <a hreflang="en" href="https://developer.chrome.com/docs/web-platform/deprecating-unload">recommend avoiding unload</a> in favor of alternatives such as visibilitychange or pagehide, a shift that is reflected in recent usage patterns. 

Compared to 2024, unload handler usage declined across all ranks and both devices in 2025. This reduction suggests that more pages are now eligible for BFCache behavior. Despite this progress, unload handlers remain more common on higher-ranked sites and on desktop, continuing to limit BFCache eligibility for a significant portion of the web, as seen below in the 2025 graph.

{{ figure_markup(
  image="unload-handler-usage.png",
  caption="Unload handler usage by website rank and device (2025)",
  description="The chart shows the percentage of pages using unload event handlers by website rank on desktop and mobile in 2025. Among the top 1,000 websites, unload handlers appear on 28% of desktop pages and 20% of mobile pages, with usage declining steadily as rank increases. For all websites, unload handlers are present on 11% of desktop pages and 10% of mobile pages, with desktop usage higher than mobile at every rank.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=140804120&format=interactive",
  sheets_gid="1870744021",
  sql_file="bfcache_unload.sql"
  )
}}

It is interesting to see that unload handler usage decreases consistently as the site rank increases. 

Among higher-traffic websites (top 1000 sites), unload handlers are present on 28% of desktop pages and 20% of mobile pages, and this share declines steadily across lower-ranked sites, reaching 11% on desktop and 10% on mobile. At every rank, desktop pages exhibit higher unload handler usage than mobile, suggesting that unload handlers remain more common on larger, more complex sites than across the long tail of the web. Possibly due to top sites relying more heavily on analytics, advertising, and legacy lifecycle patterns that register unload handlers.

### Images
TODO (Himanshu)

### Animation
TODO (Himanshu)

### Conclusion

The main takeaways are:

- Visual stability across the web has advanced significantly over the years, particularly on mobile devices.
- Most pages now deliver stable experiences with minimal unexpected movement, reflecting improved adoption of best practices.
- However, with around 20-30% of pages still not achieving Good CLS, especially on desktop, there remains room for continued refinement and optimization.

## Early Hints
TODO (Unassigned)

## Speculation Rules
TODO (Unassigned)

## Conclusion
TODO (Unassigned)
