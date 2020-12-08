---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 12
title: Mobile Web
description: Mobile Web chapter of the 2020 Web Almanac covering page loading, textual content, zooming and scaling, buttons and links, and ease of filling out forms.
authors: [spanicker, mdiblasio]
reviewers: [malchata, obto, cheneytsai]
analysts: [obto]
translators: []
#spanicker_bio: TODO
#mdiblasio_bio: TODO
discuss: 2048
results: https://docs.google.com/spreadsheets/d/1DGLY7UEWOlDL5_2dtS_j2eqMjiV-Rw5Fe2y6K6-ULvM/
queries: 12_Mobile_Web
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
We keep hearing that the Mobile Web has grown explosively in the last decade and is now the primary way many people experience the web. In this chapter we explore just how significant the mobile web is, and what kind of experiences visitors are expecting and being served.

2020 has seen a big surge in internet usage, on both mobile and desktop, due to the global pandemic. There has been an uptick in visits to news sites, ecommerce and social media sites -- as people across the globe adjusted to a new lifestyle with stay-at-home orders and social distancing. 2020 has been a significant year in history, for the web and for mobile usage.

## A note on our data sources
We’ve used a few different data sources in this chapter: 

* [CrUX](https://almanac.httparchive.org/en/2020/methodology#chrome-ux-report)
* [HTTP archive](https://almanac.httparchive.org/en/2020/methodology#dataset)
* [Lighthouse](https://almanac.httparchive.org/en/2020/methodology#lighthouse)

Please visit the links above to learn more about the methodology and caveats with each data source.
It is worth noting that HTTP Archive and Lighthouse data is limited to the data identified from websites’ home pages only, and not site-wide. 

In addition to the above, we also used a non-public Chrome data source in the section on Page loads in Chrome. For more information on this, read about [Chrome’s data collection API](https://chromium.googlesource.com/chromium/src/+/master/services/metrics/ukm_api.md).

While this data is only collected from a subset of (opted in) Chrome users, it does not suffer from being limited to homepages. It is pseudonymous and consists of histograms and events. 

NOTE: Reporting is enabled if the user has enabled a feature that syncs browser windows, unless they have disabled the "Make searches and browsing better / Sends URLs of pages you visit to Google" setting.
