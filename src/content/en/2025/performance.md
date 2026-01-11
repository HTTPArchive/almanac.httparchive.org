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
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

Mobile performance has significantly improved due to advancements in mobile hardware, faster internet connections, and more optimized browsers and applications. Mobile Core Web Vitals have shown consistent year-over-year improvement, increasing from 36% in 2023 to 44% in 2024, and reaching 48% in 2025. This significant rise in mobile performance is largely attributable to advancements in mobile hardware, faster internet connections, and more optimized browsers and applications.

Desktop performance also saw a positive trend, moving from 48% in 2023 to 55% in 2024. However, the improvement for 2025 was marginal, increasing only to 56%.

### [TODO] Image

Performance metrics for top mobile websites show a clear distinction: 
- 51% of the 1,000 most popular mobile websites have good Core Web Vitals (CWV), surpassing the overall mobile CWV of 48%.

However, CWV scores drop significantly for less popular sites:
- The next 10,000 websites score 42%.
- The subsequent 1 million websites score 37%.

This data suggests that top-tier websites are prioritizing performance improvements, while mid-tier websites are still lagging.

In contrast, Desktop performance metrics are more uniformly distributed. This disparity highlights a significant gap in the focus on mobile web app performance compared to desktop, which is likely due to an increasing concentration on native applications.

### [TODO] Image

Secondary pages show a significant advantage over home pages in achieving good CWV results, with a 14% lead on Desktop and an 11% lead on Mobile.This performance gap suggests that secondary pages often benefit from having partially cached information, which contributes to faster page loads. 

<a hreflang="en" href="https://developer.chrome.com/blog/new-soft-navigations-origin-trial">Soft navigation</a> support is expected to aid in a more comprehensive collection of Web Vitals data for within the page navigation.

While the current CWV data indicates better overall performance for secondary pages, a deeper dive into specific aspects such as layout shift, loading performance, and interactivity is necessary to fully understand the user experience, which is what we will cover next.



