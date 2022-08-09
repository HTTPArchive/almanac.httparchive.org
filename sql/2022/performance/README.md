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

### Web Getting Right (Not Custom)
- [ ] % of sites that are using priority as an attribute on LCP element
- [ ] % of sites where the LCP is element is preloaded

### Web Getting Wrong

#### Gaming the Metrics (Custom)
- [x] Filtering for synthetic tests
- [x] LCP Animation & Overlay Hack
- [x] LCP Svg Overlay Hack
- [x] CLS Animation Hack
- [x] FID iFrame Hack

#### Antipatterns (Custom)

- [x] LCP Lazy Loaded

#### Antipatterns (Not Custom)

- [x] Are LCP Image Elements Responsive
- [ ] LCP Element Resource Delay
- [ ] TTFB by Category
- [ ] Domain Sharding
- [ ] FID Double Tap to Zoom Disabled
- [ ] FID / INP Long Task Data (let's pick either FID or INP)

#### Web Vitals

- [x] By Device
- [x] By Country
- [x] By Network connection
- [x] By Rank
- [x] By Rank and device
