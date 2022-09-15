# 2022 Performance queries

<!--
  This directory contains all of the 2022 Performance chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/1IKV40fllCZTqeu-R6-73ckjQR9S6jiBfVBBfdcpAMkI/edit?usp=sharing
[~google-sheets]: https://docs.google.com/spreadsheets/d/1TPA_4xRTBB2fQZaBPZHVFvD0ikrR-4sNkfJfUEpjibs/edit?usp=sharing
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2022/performance.md

## Query List

Taken from [`Metrics` Section](https://docs.google.com/document/d/1IKV40fllCZTqeu-R6-73ckjQR9S6jiBfVBBfdcpAMkI/edit#heading=h.zbvh8yhwkp2i) in planning doc, where technical notes on how queries might be formulated live.

## Query notes

### `inp_long_tasks.sql`

This query generates a scatterplot of field-based, page-level p75 INP versus the sum of all lab-based long tasks on the page according to Lighthouse.

Lab-based mobile CPU throttling necessarily means that long tasks should be higher than desktop. It's interesting to look at the trendlines for both desktop and mobile to see that higher INP correlates with higher long tasks.

### `lcp_resource_delay.sql`

This query subtracts the lab-based TTFB time from the lab-based LCP element's request start time and generates a distribution over all pages.

The `lcp_elem_stats.startTime` and `lcp_resource.timestamp` values did not seem to correspond to the actual LCP element request start times seen in the WPT results, so the query goes the more expensive route to join the pages data with the more reliable requests data.

### `prelcp_domain_sharding.sql`

This query takes the distribution of the number of unique hosts connected prior to the lab-based LCP time, broken down by whether the LCP was good, NI, or poor.

### `ttfb_by_rendering.sql`

This query segments pages by whether they use client-side rendering (CSR) or server-side rendering (SSR). There is no high quality signal for CSR/SSR so the heuristic used in this query is the ratio of the number of words in the document served in the static HTML to the number of words in the final rendered page. If the number of words increases by 1.5x after rendering, then we consider the page to use CSR.

Using both rendering buckets, we then calculate the median field-based p75 TTFB.

This metric is not expected to be very meaningful given the tenuous definition of CSR.
