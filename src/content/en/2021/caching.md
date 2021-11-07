---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Caching
description: Caching chapter of the 2021 Web Almanac covering ...
authors: [Zizzamia]
reviewers: [jessnicolet]
analysts: [rviscomi]
editors: []
translators: []
zizzamia_bio: Leonardo is a Staff Software Engineer at <a hreflang="en" href="https://www.coinbase.com/">Coinbase</a>, leading initiatives that enable product engineers to ship the highest quality applications in the world at scale. He curates the <a hreflang="en" href="https://ngrome.io">NGRome Conference</a>. Leo also maintains the <a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a> library, which helps companies prioritize roadmaps and make better business decisions through performance analytics.
results: https://docs.google.com/spreadsheets/d/1-v3yR0LZIC3t4zWtqTgR3jJsKjjRMP-HATU2caP8e2c/
featured_quote: During the past year caching ...
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

Over the past decade ...


## CDN Cache adoption

Talk about CDN adoptions, 14% of desktop pages use a Cloudflare CDN.

{{ figure_markup(
  image="to-do.png",
  caption="Top CDNs adoption",
  description="TODO",
  chart_url="TODO",
  sheets_gid="58739923",
  sql_file="todo.sql"
) }}

## Service Worker adoption

Talk about Service Worker adoptions, 1.2% of desktop pages registered a Service Worker, but 9% of mobile pages in the top 1000 registered a SW.

{{ figure_markup(
  image="to-do.png",
  caption="Service Worker adoption,
  description="TODO",
  chart_url="TODO",
  sheets_gid="802609299",
  sql_file="todo.sql"
) }}

## Headers adoption

Talk about headers trends, Cache-Control vs ETag vs Expires vs Last-Modified.

### Cache Control

Talk about Cache Control adoptions, 74% of responses on mobile pages include the Cache-Control header

{{ figure_markup(
  caption="The percent of pages that use the Cache-Control header.",
  content="74%",
  classes="big-number",
  sheets_gid="2102749619",
  sql_file="todo.sql"
) }}

Cache Control directives, 61% of mobile requests include a Cache-Control response header with a `max-age` directive.

The most common invalid Cache Control directives are: `set-cookie`, `max-stale`, `false`, `max-age:`, `maxage` and `public;`.

Fun fact the the largest max-age value is 1625540701883604800000 seconds or 51545557517871.8 years (51 trillion).

{{ figure_markup(
  caption="TODO",
  content="51 trillion years",
  classes="big-number",
  sheets_gid="529870849",
  sql_file="todo.sql"
) }}

Talk about `immutable` directive, 12% of desktop requests containing Cache-Control: immutable are on the "static.parastorage.com" host.

Talk about invalid date, last modified and expires, (0.11% of dates in desktop requests are invalid).

### Vary

Talk about Vary adoption, 42% of requests on mobile set Vary: accept-encoding.

The most common Vary headers are: `accept-encoding`, `user-agent`, `origin`, `accept`.

### TTL adoption

Talk about 28% of mobile requests use neither Cache-Control nor Expires headers.

The median HTML resource on mobile has a TTL of 14 days

## Cookie Cache adoption

Talk about cookies.

Fun fact `test_cookie` is the most popular desktop and mobile cookie name at 4% of all cookies.

{{ figure_markup(
  caption="TODO",
  content="4%",
  classes="big-number",
  sheets_gid="455647224",
  sql_file="todo.sql"
) }}

Top cookies attributes, SameSite is on 68% of cookies set in mobile responses.

## What type of content are we caching?

Talk about what kind of resources are we caching, (resource age groups: party, type).

Talk about resource age, the median HTML resource on mobile is 9 weeks old.

Talk about, total number of requests with comparable Last-Modified and expiration times, not necessarily all requests.

Talk about 54% of mobile resources are older than their TTL.

{{ figure_markup(
  caption="TODO",
  content="54%",
  classes="big-number",
  sheets_gid="768623684",
  sql_file="todo.sql"
) }}

Total number of requests with comparable Last-Modified and expiration times, not necessarily all requests.

Talk about, 60% of 1P mobile resources are older than their TTL, which is more common than 3P resources (45%).

## How do cache TTLs compare to resource age?

The median difference between resource TTL and resource age is -6 days, meaning the age is 6 days older than the TTL.

## Identifying caching opportunities

Talk about ~100% of fonts on mobile are cacheable!

### Lighthouse TTL score
Talk about 12% of mobile pages score 0.9 or higher on the long TTL audit

### Lighthouse waysted bytes
Talk about 59% of mobile pages could save 0 - 1 MB with caching

## Future

TODO ...


## Conclusion

TODO ...
