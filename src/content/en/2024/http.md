---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: The HTTP chapter of the 2024 Web Almanac covers data on historical versions of HTTP used across the web, as well as the uptick in adoption of HTTP/2 and HTTP/3. Additionally, it looks at higher level features that impact HTTP behaviour, such as resource hints, 103 Early Hints and FetchPriority.
authors: [rmarx]
reviewers: [tunetheweb,boetgerr]
analysts: [tunetheweb]
editors: [tunetheweb,boetgerr]
translators: []
rmarx_bio: TODO
results: https://docs.google.com/spreadsheets/d/1PfTZkbmgyLA3NmEICeCyxpMWgP7cKY7EsZl9RciE5S4/
featured_quote: TODO
featured_stat_1: 77%
featured_stat_label_1: TODO
featured_stat_2: 1.5%
featured_stat_label_2: TODO
featured_stat_3: 50%
featured_stat_label_3: TODO
---

## Introduction

HTTP remains the cornerstone of the Web ecosystem, providing the foundation for exchanging data and enabling various types of internet services. It is an actively developed protocol, with the latest version [HTTP/3](https://datatracker.ietf.org/doc/html/rfc9114) being standardized a little over two years ago, and new options to enable it being introduced recently, such as the new [DNS HTTPS records](https://developer.mozilla.org/en-US/docs/Glossary/HTTPS_RR). At the same time, the Web platform has been exposing more and more higher-level features that Web developers can use to influence when and how resources are requested and downloaded over HTTP. This includes options like [Resource Hints](https://web.dev/learn/performance/resource-hints) (for example preload and preconnect), [103 Early Hints](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/103) and the [FetchPriority API](https://web.dev/articles/fetch-priority). 

In this chapter, we will first look at the current state of HTTP/3 adoption (triggered by either alt-svc or DNS HTTPS record usage), how it compares to HTTP/2 usage, and how both have evolved since 2022. We then consider TODO.

## HTTP/3 adoption


When we last looked at this, h3 was quite new. Now however 2 years old. Let's see how that changed things!

{{ figure_markup(
  image="http3-support-per-origin.png",
  caption="HTTP/3 support has increased steadily since 2022.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=458096579&format=interactive",
  sheets_gid="1569509568",
  sql_file="h3_usage_site.sql"
) }}

    HTTP/3 support was 15% in 2022, rose steadily over 2023 to now end up +- 10% higher at 

Driven mostly by CDNs:

    TODO image

Which CDNs specifically: Cloudflare, Fastly, Cloudfront. Akamai doesn't enable by default.


Compare HTTP/3 to HTTP/1.1 and HTTP/2... can't really do that
    support above is not how much is actually used for the HTTPArchive runs... it's as measured by alt-svc. BUT only indicates potential, not actualy use (second load onward; httparchive only does 1st)

    compare to cloudflare radar, w3c data (apnic as well?) to show that HTTP/3 adoption depends on the eye of the beholder

    so can't really be sure if HTTP/3 can be used. HTTP/2+

### HTTP/3 announcement via DNS HTTPS records

To work around the bootstrapping issue: DNS HTTPS records!

Don't necessarily overlap with alt-svc: that has 28% on mobile vs 12-ish for DNS HTTPS

    TODO: see if we can get an overview of how many sites do both, and how many only do 1 maybe?


Generally difficult to look at HTTP/3 directly though, since it has to be discovered by the browser first (not all servers + blocked by networks).

alt-svc only from 2nd page load on (and HTTP Archive only does 1st page load... ). This is why HTTPS RRs were introduced: get that down.






