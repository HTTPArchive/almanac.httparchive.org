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

In the last two decades, the way we experience web applications has changed, having richer and more interactive content. But, unfortunately, this content has a cost in both data storage and bandwidth. Most of the time, this makes it harder for many of us to fully experience a web product when the network we use is degraded, or our device has not enough space. Caching is both a solution to and the cause of some of these problems. Learning how to navigate the multiverse of those choices will lead you to build not just for the HighEnd devices but also for the next Billion of users accessing your product from LowEnd devices.

Caching is a technique that enables the reuse of previously downloaded content, from simple static assets like a Javascript or CSS file to a more complex JSON API response or just a simple string value.

At its core, Caching will avoid making the exact HTTP requests and allow the application to feel more responsive and reliable to the user. Each request is usually cached in two main places:
CDN: is usually a third-party company like Cloudflare with the primary goal to replicate your data as close as possible where the user is accessing the application. Most of the CDNs have some default behavior, but mainly you can instruct them on how to cache by using HTTP Headers.
Browser: It will usually either learn how to cache your resources internally or respect the HTTP Headers you defined to optimize the experience. On top of it, you will have access to several more manual caching strategies either by storing simple strings in Cookies, complex API responses in IndexdDB, or entire JS or HTML resources in the CacheStorage with the Service Worker.

The three main pillars of how we cache web resources are:
- Cache as much as you can
- Cache for as long as you can
- Cache as close to end users as you can

## CDN Cache adoption

A Content Delivery Network (CDN) is a group of servers spread out over several locations that store copies of data. This allows servers to fulfill requests based on the server closest to the end-user. (Remember we want to cache as close to end-users as possible.) In 2021 across the web, the most popular CDN for Desktop was Cloudflare with 14% of pages, followed by Google at 6% adoption. While Cloudflare is used twice as much as Google, a large variety of solutions remains available, including Fastly, Amazon CloudFront, Akamai, and many others.

{{ figure_markup(
  image="top-cdns.png",
  caption="Adoption of the top CDNs.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2035524639&format=interactive",
  height=501,
  sheets_gid="58739923",
  sql_file="top_cdns.sql"
) }}

## Service Worker adoption

A service worker is a script that the browser allows to run in the background independently from a web page. It supports features that don't need direct user or web page interaction and offer rich offline experiences.

The adoption of Service Workers has continued to steadily increase. While 1% of Mobile pages registered a service worker in 2020, 9% of Mobile pages ranked in the top 1,000 registered one in 2021.

{{ figure_markup(
  image="sw-adoption.png",
  caption="Service Worker adoption.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=688062455&format=interactive",
  sheets_gid="802609299",
  sql_file="service_worker_rank.sql"
) }}

The primary way to cache resources within a Service Worker, it's by using the CacheStorage API. This allows a developer to create a custom cache strategy for any requests passing through the worker; some famous ones are Stale-While-Revalidate, Cache Falling Back to Network, Network Falling Back to Cache, Cache Only. In recent years become even easier to adopt those strategies by increasing the popularity of [Workbox](https://developers.google.com/web/tools/workbox/modules/workbox-strategies), which decides what cache you want to plug and play.

## Headers adoption

With both CDN and Browser, the HTTP Headers are the leading toolkit each developer needs to master to properly cache resources. Headers are simply instructions known as "directives", read during the HTTP Request or Response to control the cache strategy.

The caching-related headers, or the absence of them, tell the browser or CDN three essential pieces of information:
- **Cacheability**: Is this content cacheable?
- **Freshness**: If it is cacheable, how long can it be cached for? `Cache-Control` and `Expires` 
- **Validation**: If it is cacheable, how do I ensure that my cached version is still fresh?

Headers are meant to be used either alone or together. To tell if the content is cachable and fresh, we have:
- `Expires` specifies an explicit expiration date and time (i.e., when precisely the content expires)
- `Cache-Control` specifies a cache duration (i.e., how long the content can be cached in the browser relative to when it was requested)
In case both are specified, `Cache-Control` takes precedence.

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

In case both are specified, `ETag` takes precedence.

{{ figure_markup(
  image="last-modified-etag.png",
  caption="Percent of responses that set `Last-Modified` and `ETag` headers.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1490687174&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

### Cachebility and freshness
The `Expires` header, as stated above, it indicates the exact date/time after which the response is considered stale. Therefore, its value is a date and time, such as:

```
Expires: Mon, 29 Nov 2021 16:00:00 GMT
```

This was perfect for the early days of HTTP/1.0, and helped Browser understand how long they can cache a resource.

HTTP/1.1 took a step further by introducing the Cache-Control header, supported by all commonly used browsers for a long time. The Cache-Control header provides much more extensibility and flexibility than Expires via caching directives, several of which can be specified together, making it a better fit in many cases.

Request:
```
> GET /static/js/main.js HTTP/2
> Host: www.example.org
> Accept: */*
```

Response:
```
< HTTP/2 200
< Date: Mon, 29 Nov 2021 08:04:17 GMT
< Expires: Mon, 29 Nov 2021 08:34:17 GMT
< Cache-Control: public, max-age=1200
```

The simple example above shows a request and response for a JavaScript file. First, the `Date` header indicates the current date (precisely, the content was served). Next, the `Expires` header indicates that it can be cached for 30 minutes (the difference between the `Expires` and `Date` headers). Finally, the `Cache-Control` header specifies the `max-age` directive, which indicates that the resource can be cached for 600 seconds (10 minutes). Since `Cache-Control` takes precedence over `Expires`, the browser will cache the response for 10 minutes, after which it will be marked as stale.

Worth to mention if no caching headers are present in a response, then the browser is allowed to *heuristically* cache the response. Some may cache the response indefinitely, and some may not cache it at all. Because of this variation between browsers, it is essential to explicitly set specific caching rules to ensure that you control the cacheability of your content.

### `Cache-Control` directives
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
  <figcaption>{{ figure_link(caption="<code>Cache-Control</code> directives.", sheets_gid="1944529311", sql_file="TODO") }}</figcaption>
</figure>

The `max-age` directive is the most commonly found since it directly defines the TTL the same way that the `Expires` header does.
Here is an example of a valid Cache-Control header with multiple directives:


```
Cache-Control: public, max-age=86400, must-revalidate
```

Usage of this header has increased or remained consistent across web pages. 74% of Mobile and 75% of Desktop pages use Cache-Control.

When using the Cache-Control header, usage increased by 1% for Desktop and remained the same for Mobile. However, usage of the Last-Modified header decreased by 1% across both interfaces.

{{ figure_markup(
  image="cache-control-adoption.png",
  caption="The percent of requests that use the Cache-Control response header.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=885292598&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
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

Talk about invalid date, last modified and expires, (0.11% of dates in desktop requests are invalid).

Desktop - Valid date strings:
99.18% using date, 72.57% using last-modified, 55.48% using expires

Mobile - Valid date strings:
99.07% using date, 70.55% using last-modified, 55.57% using expires

Although 99% of both Desktop and Mobile pages use valid date strings, only 55% of Desktop and 56% of Mobile pages use 'expires'. Last-modified is used at a higher percentage, at 73% for Desktop and 71% for Mobile. While the amount of invalid 'date' and 'last-modified' directives is less than 1%, 2.75% of Mobile and 3.20% of Desktop 'expires' are being used incorrectly.

What is or would be the impact from using expires more effectively?

Could we possibly see big wins from getting more consistent here?

### Conditional requests and revalidation

### `ETag`

<a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag">`ETag`</a> helps ....

```
ETag: "34a64df551429fcc55e4d42a148795d9f25f89d8"
```

### `Last-Modified`

<a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Last-Modified">`Last-Modified`</a> helps ....

```
Last-Modified: Mon, 29 Nov 2021 07:28:00 GMT
```

### Vary

Talk about Vary adoption, 42% of requests on mobile set Vary: accept-encoding.

The most common Vary headers are: `accept-encoding`, `user-agent`, `origin`, `accept`.

### TTL adoption

Talk about 28% of mobile requests use neither Cache-Control nor Expires headers.

The median HTML resource on mobile has a TTL of 14 days

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

Talk about what kind of resources are we caching, (resource age groups: party, type).

The median age of HTML resources cached for mobile is 9 weeks, while for text the median age is 1220 weeks (23.4 years).

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

Explain why this is significant- 60% of 1st Party mobile resources are older than their TTL- is this because 1P are more important or crucial? Because 3P are being deprecated?

## How do cache TTLs compare to resource age?

The median difference between resource TTL and resource age is -6 days, meaning the age is 6 days older than the TTL.

## Identifying caching opportunities

Can we get a graph of the % of cacheable strategies vs. non-cacheable strategies for Desktop and Mobile, based on data from 'Non-cacheable strategies'?

Shows the majority of resources are highly cacheable

{{ figure_markup(
  image="caching-by-resource-type.png",
  caption="The percent of requests that use caching strategies by resource type.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2036781114&format=interactive",
  height=436,
  sheets_gid="1202769738",
  sql_file="non_cacheable_by_resource_type.sql"
) }}

### Lighthouse TTL score
Talk about 12% of mobile pages score 0.9 or higher on the long Time To Live (TTL) audit

The TTL of a cached object defines how long it can be stored in a cache, typically measured in seconds.

### Lighthouse waysted bytes
Talk about 59% of mobile pages could save 0 - 1 MB with caching

## Future

TODO ...

From [Fonts](https://almanac.httparchive.org/en/2020/fonts#conclusion) chapter: [Partitioning the cache](https://developers.google.com/web/updates/2020/10/http-cache-partitioning)


## Conclusion

Many people must have heard this quote by Phil Karlton "There are only two hard things in Computer Science: cache invalidation and naming thing.". And I always wondered why caching is so hard? My take is that to do caching well, you need two key ingredients: keep it simple and understand all potential edge cases. Unfortunately, when we try to make the cache too clever, sometimes we end up catching the wrong things or, worst, caching too much. On a similar note, understanding all edge cases take a ton of research, testing, and slow incremental improvements; and even with that, you have to hope that an old browser will not throw you under the bus. And the reason we still chase great caching strategies is that the ultimate reward is very high, with a significant reduction of round-trip requests, high savings for your server, fewer data required from your users, and ultimately a better user experience.

In any case, make sure to have a playbook for how to best use caching:
- Prioritizing caching work at an early stage of the development cycle and after a product is shipped
- Write end-to-end tests to recreate any major edge case
- Regularly auditing the site and updating any cache rule that might be outdated or missing.

As a final note, caching is less complex if we help our peers by mentoring them and writing simple and good documentation on how to use it. So that is not to be something mastered only by a few, but a common knowledge across your entire company, so it is easier to focus on building easy and frictionless experiences.
