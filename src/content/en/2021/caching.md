---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Caching
description: Caching chapter of the 2021 Web Almanac covering ...
authors: [Zizzamia, jessnicolet]
reviewers: []
analysts: [rviscomi]
editors: []
translators: []
zizzamia_bio: Leonardo is a Staff Software Engineer at <a hreflang="en" href="https://www.coinbase.com/">Coinbase</a>, leading initiatives that enable product engineers to ship the highest quality applications in the world at scale. He curates the <a hreflang="en" href="https://ngrome.io">NGRome Conference</a>. Leo also maintains the <a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a> library, which helps companies prioritize roadmaps and make better business decisions through performance analytics.
jessnicolet_bio: TODO
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

Over the last two decades, the way we experience web applications has changed, giving us richer and more interactive content. But, unfortunately, this content comes with a cost in both data storage and bandwidth. Most of the time, this makes it harder for many of us to fully experience a web product when the network we use is degraded, or our device doesn't have enough space. Caching is both a solution to and the cause of some of these problems. Learning to navigate the multiverse of choices will enable you to build not only for HighEnd devices but also for the next Billion users that access your product from LowEnd devices.

Caching is a technique that enables the reuse of previously downloaded content, from simple static assets like Javascript, CSS files or basic string values to more complex JSON API responses.

At its core, Caching avoids making specific HTTP requests and allows an application to feel more responsive and reliable to the user. Each request is usually cached in two main places:
- **Content Delivery Network (CDN)**: Usually a third-party company like Cloudflare with the primary goal of replicating your data as closely as possible to where the user is accessing the application. Most CDNs have some default behavior, but mainly you can instruct them on how to cache by using HTTP Headers.
- **Browser**: Usually will either learn how to cache your resources internally or respect the HTTP Headers you defined to optimize the experience. On top of that, you will have access to additional manual caching strategies including storing simple strings in *Cookies*, complex API responses in *IndexedDB*, or entire JS or HTML resources in the *CacheStorage* with the *Service Worker*.

The three main pillars of how we cache web resources are:
- Cache as much as you can
- Cache for as long as you can
- Cache as close to end users as you can

## CDN Cache adoption

A Content Delivery Network (CDN) is a group of servers spread out over several locations that store copies of data. This allows servers to fulfill requests based on the server closest to the end-user. (Remember we want to cache as close to end-users as possible.) In 2021 across the web, the most popular CDN for Desktop was Cloudflare with 14% of pages, followed by Google at 6% adoption.

{{ figure_markup(
  image="top-cdns.png",
  caption="Adoption of the top CDNs.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2035524639&format=interactive",
  height=501,
  sheets_gid="58739923",
  sql_file="top_cdns.sql"
) }}

While Cloudflare is used twice as much as Google, a large variety of solutions remain available, including Fastly, Amazon CloudFront, Akamai, and many others.

## Service Worker adoption

A Service Worker is a script that the browser allows to run in the background independently from a web page. It supports features that don't need direct user or web page interaction and offer rich offline experiences.

The adoption of Service Workers has continued to steadily increase. While 1% of Mobile pages registered a service worker in 2020, 9% of Mobile pages ranked in the top 1,000 registered one in 2021.

{{ figure_markup(
  image="sw-adoption.png",
  caption="Service Worker adoption.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=688062455&format=interactive",
  sheets_gid="802609299",
  sql_file="service_worker_rank.sql"
) }}

The primary way to cache resources within a Service Worker is by using the *CacheStorage API*. This allows a developer to create a custom cache strategy for any requests passing through the worker; some well-known ones are Stale-While-Revalidate, Cache Falling Back to Network, Network Falling Back to Cache, and Cache Only. In recent years it has become even easier to adopt those strategies through the increased popularity of [Workbox](https://developers.google.com/web/tools/workbox/modules/workbox-strategies), which helps you decide what cache you want to plug and play.

## Headers adoption

With both a CDN and the Browser, HTTP Headers are the primary toolkit a developer needs to master to properly cache resources. Headers are simply instructions known as "*directives*", read during the HTTP Request or Response to control the cache strategy.

The caching-related headers, or the absence of them, tell the browser or CDN three essential pieces of information:
- **Cacheability**: Is this content cacheable?
- **Freshness**: If it is cacheable, how long can it be cached for?
- **Validation**: If it is cacheable, how do I ensure that my cached version is still fresh?

Headers are meant to be used either alone or together. To tell if the content is cacheable and fresh, we have:
- `Expires` specifies an explicit expiration date and time (i.e., when precisely the content expires)
- `Cache-Control` specifies a cache duration (i.e., how long the content can be cached in the browser relative to when it was requested)
When both are specified, `Cache-Control` takes precedence.

The usage of the Cache-Control header has increased steadily since 2019. 74% of responses on Mobile pages included the Cache-Control header, while 75% of responses on Desktop pages utilized the header. From 2020, the usage of this specific header increased by 0.71% for Mobile and by 1.13% for Desktop.

{{ figure_markup(
  image="cache-control-expires.png",
  caption="Percent of responses that set `Cache-Control` and `Expires` headers.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=816405026&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

To validate the content, we have:
- `Last-Modified` indicates when the object was last changed. Its value is a date timestamp.
- `ETag` (Entity Tag) provides a unique identifier for the content as a quoted string. It can take any format the server chooses; it is typically a hash of the file contents, but it could be a timestamp or a simple string.

When both are specified, `ETag` takes precedence.

When compared 2020 with 2021 usage of the Last-Modified header decreased by 1% across both interfaces.

{{ figure_markup(
  image="last-modified-etag.png",
  caption="Percent of responses that set `Last-Modified` and `ETag` headers.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1490687174&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

### `Cache-Control` directives
When using the Cache-Control header, usage increased by 1% for Desktop and remained the same for Mobile.

{{ figure_markup(
  image="cache-control-adoption.png",
  caption="The percent of requests that use the Cache-Control response header.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=885292598&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}


When using the `Cache-Control` header, you specify one or more *directives*—predefined values that indicate specific caching functionality. Multiple directives are separated by commas and can be set in any order, although some clash with one another (e.g., `public` and `private`). In addition, some directives take a value, such as `max-age`.

Below is a table showing the most common `Cache-Control` directives:

<figure>
  <table>
    <tr>
     <th>Directive</th>
     <th>Description</th>
    </tr>
    <tr>
     <td><code class="no-wrap">max-age</code></td>
     <td>Indicates the number of seconds that a resource can be cached for relative to the current time. For example <code>max-age=86400</code>.</td>
    </tr>
    <tr>
     <td><code class="no-wrap">public</code></td>
     <td>Indicates that any cache can store the response, including the Browser and the CDN. This is assumed by default.</td>
    </tr>
    <tr>
     <td><code class="no-wrap">no-cache</code></td>
     <td>A cached resource must be revalidated before its use, via a conditional request, even if it is not marked as stale.</td>
    </tr>
    <tr>
     <td><code class="no-wrap">must-revalidate</code></td>
     <td>A stale cached entry must be revalidated before its use, via a conditional request.</td>
    </tr>
    <tr>
     <td><code class="no-wrap">no-store</code></td>
     <td>Indicates that the response must not be cached.</td>
    </tr>
    <tr>
     <td><code class="no-wrap">private</code></td>
     <td>The response is intended for a specific user and should not be stored by shared caches such as CDNs.</td>
    </tr>
    <tr>
     <td><code class="no-wrap">immutable</code></td>
     <td>Indicates that the cached entry will never change during its TTL and that revalidation is not necessary.</td>
    </tr>
  </table>
  <figcaption>TODO: Caption the table above</figcaption>
</figure>

The `max-age` directive is the most commonly found since it directly defines the TTL the same way that the `Expires` header does.

{{ figure_markup(
  image="cache-control-directives.png",
  caption="Usage of `Cache-Control` directives.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1359015817&format=interactive",
  sheets_gid="1944529311",
  sql_file="cache_control_directives.sql"
) }}

Cache Control directives, 61% of mobile requests include a Cache-Control response header with a `max-age` directive.

The most misused Cache Control directive is `set-cookie`, used for 0.07% of total directives for Desktop and 0.08% for Mobile.

Fun fact the the largest max-age value is 1625540701883604800000 seconds or 51545557517871.8 years (51 trillion).

{{ figure_markup(
  caption="TODO",
  content="51 trillion years",
  classes="big-number",
  sheets_gid="529870849",
  sql_file="todo.sql"
) }}

Talk about `immutable` directive, 12% of desktop requests containing Cache-Control: immutable are on the "static.parastorage.com" host.

### `304` Not Modified status

{{ figure_markup(
  image="http-304-by-caching-strategy.png",
  caption="HTTP 304 response rate by caching strategy.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1965033294&format=interactive",
  sheets_gid="1136058277",
  sql_file="valid_if_none_match_returns_304.sql"
) }}

### Validity of date strings

Talk about invalid date, last modified and expires, (0.11% of dates in desktop requests are invalid).

Desktop - Valid date strings:
99.18% using date, 72.57% using last-modified, 55.48% using expires

Mobile - Valid date strings:
99.07% using date, 70.55% using last-modified, 55.57% using expires

Although 99% of both Desktop and Mobile pages use valid date strings, only 55% of Desktop and 56% of Mobile pages use 'expires'. Last-modified is used at a higher percentage, at 73% for Desktop and 71% for Mobile. While the amount of invalid 'date' and 'last-modified' directives is less than 1%, 2.75% of Mobile and 3.20% of Desktop 'expires' are being used incorrectly.

What is or would be the impact from using expires more effectively?

Could we possibly see big wins from getting more consistent here?

### Vary

Talk about Vary adoption, 42% of requests on mobile set Vary: accept-encoding.

In addition, 83% of mobile Vary: accept-encoding requests also use cache-control. This is another case of the more you know about caching, the more consistently you can make use of all the resources available to you.

The most common Vary headers are: `accept-encoding`, `user-agent`, `origin`, `accept`.

### TTL adoption

Talk about 28% of mobile requests use neither Cache-Control nor Expires headers.

The median HTML resource on mobile has a TTL of 14 days

The median difference between resource TTL and resource age is -6 days, meaning the age is 6 days older than the TTL.

## Cookie Cache adoption

35.63% of Cacheable Desktop pages with set-cookie
Mobile pages with set-cookie: 35.99%

Another area of opportunity we discovered was with cacheable pages that are not using `set-cookie`. About 35% of Desktop and Mobile pages use `set-cookie` while over 64% of them do not.

Large area of opportunity for pages that are actually cacheable, but are just missing this directive?

Fun fact `test_cookie` is the most popular desktop and mobile cookie name at 4% of all cookies.

{{ figure_markup(
  caption="TODO",
  content="4%",
  classes="big-number",
  sheets_gid="455647224",
  sql_file="todo.sql"
) }}

The top cookies attributes used on Desktop and Mobile are SameSite and Secure. SameSite is on 53% of cookies set in Desktop responses and a whopping 68% on Mobile responses.

Why is it a big deal that SameSite is at 68% on mobile?

## What type of content are we caching?

On one end of the spectrum, Font, CSS, and Audio files are over 99% cacheable.
However, of well-used non-cacheable resources, HTML is the highest at 23.4% and Images follow closely with 10.1% being non-cacheable.

When we consider the content that we cache by resource type, the most-cached resources are fonts with almost 100% of pages caching fonts. Followed quickly by CSS, audio, and video which are the most common static files on the web pages. However, the resources we cache the least due to their dynamic nature are text at 29.5% and HTML at 76.6%

{{ figure_markup(
  image="caching-by-resource-type.png",
  caption="The percent of requests that use caching strategies by resource type.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2036781114&format=interactive",
  height=436,
  sheets_gid="1202769738",
  sql_file="non_cacheable_by_resource_type.sql"
) }}

When we compare the mobile data from 2020 and 2021, we notice a 5.1% increase in cacheable HTML. This tells us we may potentially be moving towards better using our CDNs to cache HTML pages that tend to change less frequently. Specifically, ones that are generated by Server-Side Rendered applications. Where usually with SSR when you visit a particular webpage if the content doesn't change, that url will serve the same HTML for potentially weeks or even months, making them highly cacheable.

- Cacheable vs non-cacheable response
- Distribution of TTL in cacheable response
- Cache TTL percentiles by resource type


## How do cache TTLs compare to resource age?
Between 1st and 3rd party resources:  
- Images have the same resource age of 2 years. 
- The majority of Video resources is also between 8-52 weeks

Fonts for 3rd party are cached the most between 8-52 weeks at 72.4%, but interestingly for 1st party, the largest resource age grouping is evenly split between 8-52 weeks and over 2 years.

[TODO Add MAYBE a figure for show the Resource age by content-tyep (first-party and or third-party)]

We see a similar approach for audio and scripts where the majority of 1st party are between 8-52 weeks and the majority of 3rd party are between 1-7 weeks. The most highly cached resources across first and third parties were audio. However, the resource age varied greatly between first party (averaging 8-52 weeks) and third party, at only 1-7 weeks. Audio resources in first party situations are clearly updated less frequently, so third parties may be capitalizing on a caching opportunity by offering fresher resources.

For CSS, 1st party the larger group is 8-52 weeks while the larger group for 3rd party with 51.8% is with less than a week.

Finally, HTML has the largest 1st party group served with less than a week with 42.7% and third party's largest group is between 1-7 weeks with 43.1%. 

Considerations after reviewing this data: 
- The freshest content for 1st party is HTML while for 3rd party it is CSS. 
- The most stale content for both 1st and 3rd party is images.

This data shows how 1st parties have prioritized refreshing HTML content which usually holds the link to JS and CSS files, while 3rd party providers that are mostly CSS and script-driven, like browser extensions, have prioritized keeping their CSS up-to-date.

Mobile resources with a cache TTL that was considered too short compared to its content age have seen an improvement since 2020. 60.2% in 2020 but now 54% in 2021.

{{ figure_markup(
  caption="TODO",
  content="54%",
  classes="big-number",
  sheets_gid="768623684",
  sql_file="todo.sql"
) }}

Developers are getting better at setting the cache duration more accurately to the content age, resulting in more responsible caching.

<figure>
  <table>
    <tr>
     <th>Client</th>
     <th>1st party</th>
     <th>3rd party</th>
     <th>Overall</th>
    </tr>
    <tr>
     <td>desktop</td>
     <td class="numeric">59.3%</td>
     <td class="numeric">46.2%</td>
     <td class="numeric">54.3%</td>
    </tr>
    <tr>
     <td>mobile</td>
     <td class="numeric">60.1%</td>
     <td class="numeric">44.7%</td>
     <td class="numeric">54.3%</td>
    </tr>
  </table>
  <figcaption>TODO: Caption the table above</figcaption>
</figure>

When we split the data between first party and third party providers, the largest improvements come from third party where we have a 13.2% improvement. It is highly encouraging to see how companies around the world are building products for developers that are highly optimized on caching. However, the challenge remains for how first parties can effectively improve over the coming years.

The community's increased attention on improving performance has encouraged and even incentivized third parties to optimize their caching strategies.

## Identifying caching opportunities

Based on the **Lighthouse caching TTL* score, we have seen an improvement in pages ranked with a perfect 100 score increase from 3.3% in 2020 to 4.4% in 2021.

The score reflects whether the pages can benefit from additional caching policy improvements. Even though we are excited to see 31% of pages scoring above the 50 percentile score, we still see a large potential in 52% of pages that have a below-25 percentile score.

[TODO Add MAYBE a figure for Distribution of Lighthouse caching TTL score OR maybe just of the numbers]

This makes us consider that even though web pages have some level of caching, the way the policies are used is outdated and not optimized to the latest state of their products.

Based on **Lighthouse wasted bytes** from 2020 to 2021 on repeated views there was a 3.28% improvement in wasted bytes across all audited pages. This lowered the percentage of pages that waste 1 MB from 42.8% to 39.5%, showing a considerable trend from the community in building products that are less costly for international users with paid internet data plans.

[TODO Add figure for Distribution of potential byte savings from the Lighthouse caching audit]

Something we're looking forward to seeing in the coming years is an increase in the percentage of pages that have 0 wasted bytes, which at the moment is only at 1.34%.

## Future

TODO ...

From [Fonts](https://almanac.httparchive.org/en/2020/fonts#conclusion) chapter: [Partitioning the cache](https://developers.google.com/web/updates/2020/10/http-cache-partitioning)


## Conclusion

Many people may recognize this quote by Phil Karlton, "*There are only two hard things in Computer Science: cache invalidation and naming things.*" And I have always wondered why caching is so hard. My take is that to do caching well, you need two key ingredients: to keep it simple and to understand all potential edge cases. Unfortunately, when we try to make the cache too clever, we can end up caching the wrong things or, worse, caching too much. On a similar note, understanding all the edge cases requires a ton of research, testing, and slow incremental improvements. Even with that, you have to hope that an old browser will not throw you under the bus. But the reason we still chase great caching strategies is that the ultimate reward is very high, with a significant reduction in round-trip requests, high savings for your server, less data required from your users, and ultimately a better user experience.

No matter the case, make sure to have a playbook for how to best use caching:
- Prioritize caching work at an early stage of the development cycle, _and_ after a product is shipped
- Write end-to-end tests to recreate major edge cases
- Regularly audit the site and update cache rules that might be outdated or missing

As a final note, caching can be made less complex if we help our peers by mentoring them and writing simple and good documentation regarding how to use it. Ultimately, caching is not something to be mastered by only a few. It should become common knowledge across an entire company, making it is easier to focus on building easy and frictionless experiences.
