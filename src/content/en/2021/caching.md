---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Caching
description: Caching chapter of the 2021 Web Almanac covering Cache-control, Expires, TTLs, validity, Vary, Set-cookies, Service Workers and opportunities.
authors: [Zizzamia, jessnicolet]
reviewers: [WilhelmWillie, roryhewitt]
analysts: [rviscomi]
editors: []
translators: []
Zizzamia_bio: Leonardo is a Staff Software Engineer at <a hreflang="en" href="https://www.coinbase.com/">Coinbase</a>, leading initiatives that enable product engineers to ship the highest quality applications in the world at scale. He curates the <a hreflang="en" href="https://ngrome.io">NGRome Conference</a>. Leo also maintains the <a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a> library, which helps companies prioritize roadmaps and make better business decisions through performance analytics.
jessnicolet_bio: Jessica began her career as an opera singer and has been in the classical music industry for the past 10 years. In early 2020 and due to the pandemic, she decided to start a new career in Tech, specifically Web Development. She has always enjoyed writing and telling stories both onstage and off and published a [series of three articles](https://jessicanicolet.medium.com/) on Medium documenting her experience transitioning to this new field. She is currently looking for a full-time position in Technical Writing.
results: https://docs.google.com/spreadsheets/d/1-v3yR0LZIC3t4zWtqTgR3jJsKjjRMP-HATU2caP8e2c/
featured_quote: Adoption of cache headers continues to steadily grow as we learn to navigate the multiverse of caching choices. Optimize pages not only for HighEnd devices but also for the next billion users that access your product from LowEnd devices.
featured_stat_1: 99.8%
featured_stat_label_1: Pages caching fonts
featured_stat_2: 51 trillion year
featured_stat_label_2: Largest `max-age` value recorded
featured_stat_3: 59.1%
featured_stat_label_3: Mobile pages could save up to 1 MB with caching
unedited: true
---

## Introduction

Over the last two decades, the way we experience web applications has changed, giving us richer and more interactive content. But, unfortunately, this content comes with a cost in both data storage and bandwidth. Most of the time, this makes it harder for many of us to fully experience a web product when the network we use is degraded, or our device doesn't have enough space. Caching is both a solution to and the cause of some of these problems. Learning to navigate the multiverse of choices will enable you to build not only for *HighEnd* devices but also for the next billion users that access your product from *LowEnd* devices.

Caching is a technique that enables the reuse of previously downloaded content, from simple static assets like Javascript, CSS files or basic string values to more complex JSON API responses.

At its core, Caching avoids making specific HTTP requests and allows an application to feel more responsive and reliable to the user. Each request is usually cached in two main places:
- **[Content Delivery Network (CDN)](https://20211129t162816-dot-webalmanac.uk.r.appspot.com/en/2021/cdn)**: Usually a third-party company with the primary goal of replicating your data as closely as possible to where the user is accessing the application. Most CDNs have some default behavior, but mainly you can give them instructions on how to cache by using HTTP Headers.
- **Browser**: Usually will either learn how to cache your resources internally or respect the HTTP Headers you defined to optimize the experience. On top of that, you will have access to additional manual caching strategies including storing simple strings in *Cookies*, complex API responses in [*IndexedDB*](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API), or entire JS or HTML resources in the *CacheStorage* with a *Service Worker*.

In this chapter, we will mostly focus on the HTTP Headers used between the Browser and the CDN, briefly mentioning Service Worker caching strategies.

## CDN Cache adoption

A Content Delivery Network (CDN) is a group of servers spread out over several locations that store copies of data. This allows servers to fulfill requests based on the server closest to the end-user. Across the web in 2021, the most popular CDN used for Desktop was Cloudflare with 14% of total pages, followed by Google with 6%.

{{ figure_markup(
  image="top-cdns.png",
  caption="Adoption of the top CDNs.",
  description="A bar chart of the adoption rate of the most popular CDN's by percent of pages. Adoption for mobile and desktop for Cloudflare is 14%, Google is 7%, Fastly is 2%, Amazon CloudFront is 2%, Akamai is 1%, and Automattic is 1%. Remaining CDN's including Sucuri Firewall, Incapsula, and Netlify have an average of 0% adoption.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2035524639&format=interactive",
  height=501,
  sheets_gid="58739923",
  sql_file="top_cdns.sql"
) }}

While Cloudflare is used twice as much as Google, a large variety of solutions remain available, including Fastly, Amazon CloudFront, Akamai, and many others.

## Service Worker adoption

The adoption of [Service Workers](https://developers.google.com/web/fundamentals/primers/service-workers) has continued to steadily increase. While 1% of Desktop pages registered a Service Worker in 2021, 9% of Mobile pages ranked in the top 1k registered one.

This higher adoption of Service Workers from the top 1k pages, could be related to the world-wide trend towards remote-first and by association, mobile-friendly. As our reliance on working and living in one place throughout the entire year shifts, we need our devices to work even harder and smarter to keep up with us. Service Workers are a tool that can improve performance when the user is dealing with unreliable networks or LowEnd devices.

{{ figure_markup(
  image="sw-adoption.png",
  caption="Service Worker adoption.",
  description="A bar chart of Service Worker adoption by site ranking and percent of pages. The adoption rate for sites ranked 1,000 had 9% adoption, sites ranked 10,000 had 8%, 100,000 had 5%, 1,000,000 had 2%, and remaining sites had 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=688062455&format=interactive",
  sheets_gid="802609299",
  sql_file="service_worker_rank.sql"
) }}

The primary way to cache resources within a Service Worker is by using the *CacheStorage API*. This allows a developer to create a custom cache strategy for any requests passing through the worker; some well-known ones are *stale-while-revalidate*, *Cache Falling Back to Network*, *Network Falling Back to Cache*, and *Cache Only*. In recent years it has become even easier to adopt those strategies thanks to the increased popularity of [Workbox](https://developers.google.com/web/tools/workbox/modules/workbox-strategies), which helps you decide what cache you want to plug and play.

## Headers adoption

With both a CDN and the Browser, HTTP Headers are the primary toolkit a developer must master to properly cache resources. Headers are simply instructions read during the HTTP Request or Response, and some of them help control the cache strategy used.

The caching-related headers, or the absence of them, tell the browser or CDN three essential pieces of information:
- **Cacheability**: Is this content cacheable?
- **Freshness**: If it is cacheable, how long can it be cached for?
- **Validation**: If it is cacheable, how do I ensure that my cached version is still fresh?

Headers are meant to be used either alone or together. To determine if the content is **cacheable** and **fresh**, we have:
- `Expires` specifies an explicit expiration date and time (i.e., when precisely the content expires).
- `Cache-Control` specifies a cache duration (i.e., how long the content can be cached in the browser relative to when it was requested).

When both are specified, `Cache-Control` takes precedence.

Usage of the `Cache-Control` header has increased steadily since 2019. 74% of responses on Mobile pages included the `Cache-Control` header, while 75% of responses on Desktop pages utilized the header.

{{ figure_markup(
  image="cache-control-expires.png",
  caption="Percent of responses that set `Cache-Control` and `Expires` headers.",
  description="A bar chart showing usage of Cache-Control and Expires headers. For desktop and mobile, 74.2% use Cache-Control, 55.6% use Expires, 54.9% use both, and 25.1% use neither.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=816405026&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

Since 2020, the usage of this specific header increased by 0.71% for Mobile and by 1.13% for Desktop. But on Mobile, we still have 25.1% of requests using neither `Cache-Control` nor `Expires` headers. This leads us to believe there has been an increase in awareness in the community around proper usage of `Cache-Control`, but we still have a long way to go to full adoption of these headers.

To **validate** the content, we have:
- `Last-Modified` indicates when the object was last changed. Its value is a date timestamp.
- `ETag` (Entity Tag) provides a unique identifier for the content as a quoted string. It can take any format the server chooses; it is typically a hash of the file contents, but it can be a timestamp or a simple string.

When both are specified, `ETag` takes precedence.

{{ figure_markup(
  image="last-modified-etag.png",
  caption="Percent of responses that set `Last-Modified` and `ETag` headers.",
  description="A bar chart showing usage of `Last-Modified` and `ETag` headers. For desktop and mobile, 70.5% use `Last-Modified`, 46.5% us `ETag`, 41.6% use both, and 24.5% use neither.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1490687174&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

Comparing 2020 and 2021, we notice a recurring trend from past years with the `ETag` becoming slightly more popular, and `Last-Modified` being used 1.5% less. What we should probably keep an eye on next year is a new trend of 1.4% more pages using neither `ETag` nor `Last-Modified` headers, as this could imply a challenge in the community understanding the value of these headers.

### `Cache-Control` directives
When using the `Cache-Control` header, you specify one or more *directives*—predefined values that indicate specific caching functionality. Multiple directives are separated by commas and can be set in any order, although some clash with one another (e.g., `public` and `private`). In addition, some directives take a value, such as `max-age`.

Below is a table showing the most common `Cache-Control` directives:

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

The `max-age` directive is the most commonly found with 62.2% of Desktop requests including a `Cache-Control` response header with this directive.

{{ figure_markup(
  image="cache-control-directives.png",
  caption="Usage of `Cache-Control` directives.",
  description="A bar chart showing the distribution of 12 `Cache-Control` directives. The usage for desktop ranges from 62.2% for `max-age`, 29.7% for `public`, 16.5% for `no-cache`, 12.2% for `must-revalidate`, 9.6% for `no-store`, 9.5% for `private`, 3.5% for `immutable`, 1.8% for `no-transform`, 2.3% for `stale-while-revalidate`, 1.6% for `s-maxage`, 0.9% for `proxy-revalidate` , and 0.2% for `stale-if-error`. Usage for mobile ranges from 60.7% for `max-age`, 29.7% for `public`, 15.6% for `no-cache`, 13.2% for `must-revalidate`, 10.3% for `no-store`, 10.1% for `private`, 3.9% for `immutable`, 1.6% for `no-transform`, 2.4% for `stale-while-revalidate`, 1.4% for `s-maxage`, 1.0% for `proxy-revalidate` , and 0.2% for `stale-if-error`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1359015817&format=interactive",
  height=436,
  sheets_gid="1944529311",
  sql_file="cache_control_directives.sql"
) }}

Compared to 2020, `max-age` adoption increased by 2% on Desktop, along with most of the top seven directives in the above chart.

The `immutable` directive is relatively new and can significantly improve cacheability for certain types of requests. However, it is still only supported by a few browsers, and we see most requests coming from from Host Networks like *Wix* with 16.4%, *Facebook* with 8.6%, *Tawk* with 2.8%, and *Shopify* with 2.4%.

The most misused `Cache-Control` directive continues to be `set-cookie`, used for 0.07% of total *directives* for Desktop and 0.08% for Mobile. However, we are pleased to see a meaningful 0.16% reduction of usage from 2020.

When we take a look when `no-cache`, `max-age=0` and `no-store` are used together, we also see a growing trend year after year, in which `no-store` is specified with either/both of `no-cache` and `max-age=0`, the `no-store` directive takes precedence, and the other directives are ignored. Driving more awareness around using these *directives* during larger conferences could help avoid accidentally wasted bytes.

Fun fact: The most common `max-age` value is 30 days, and the largest value is 51 trillion years.

{{ figure_markup(
  caption="Largest recorded value for `max-age`",
  content="51 trillion years",
  classes="medium-number",
  sheets_gid="529870849",
  sql_file="todo.sql"
) }}

### `304` Not Modified status

When it comes to size, `304 Not Modified` responses are much smaller than `200 OK` responses, so it follows that page performance can be sped up by only delivering the necessary size of data. This is where correctly using conditional requests comes in because revalidation, and data savings can be done by using either an `Etag` or `Last-Modified` header.

The `Last-Modified` response header works in conjunction with the `If-Modified-Since` request header to let the browser know if any changes have been made to the requested file.

{{ figure_markup(
  image="http-304-by-caching-strategy.png",
  caption="HTTP 304 response rate by caching strategy.",
  description="A bar chart of HTTP 304 response rate by caching strategy. The usage for desktop ranges from 18% for Expected with `If-Modified-Since`, 94% for Actual with `If-Modified-Since`, 84% for Expected with `ETag`, and 88% for Actual with `ETag`. Usage for mobile ranges from 13% for Expected with `If-Modified-Since`, 86% for Actual with `If-Modified-Since`, 91% for Expected with `ETag`, and 88% for Actual with `ETag` ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1965033294&format=interactive",
  sheets_gid="1136058277",
  sql_file="valid_if_none_match_returns_304.sql"
) }}

We saw the distribution of 304 responses increase by 7.7% for `If-Modified-Since` between 2020 and 2021. This shows that the community is capitalizing on these data savings.

### Validity of date strings

The three main HTTP headers used to represent timestamps, `Date`,`Last-Modified` and `Expires` all use a date formatted string. The `Date` HTTP response header is almost always generated automatically by the web server, meaning that invalid values are extremely rare. Still, in the event that the date is set incorrectly it can affect cacheability on the response on which it is served.

{{ figure_markup(
  image="invalid-date-formats.png",
  caption="Percent of responses with invalid date formats.",
  description="A bar graph showing percentage of response headers with invalid date formats broken down by header. The percent of responses for desktop range from 2.8% for `Expires`, 0.7% for `Last-Modified`, and 0.1% for `Date`. The percent of responses for mobile range from 3.2% for `Expires`, 0.9% for `Last-Modified`, and 0.0% for `Date`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=383751268&format=interactive",
  sheets_gid="1680471251",
  sql_file="invalid_last_modified_and_expires_and_date.sql"
) }}

Between 2020 and 2021, the percent using invalid `Date` improved by 0.5% but worsened for `Last-Modified` and `Expires` showing that it was related to how the date was set on caching.

This shows us that automation of the `Date` header could benefit from further attention...?

### `Vary`

An essential step in caching a resource is understanding if it was previously cached. The browser typically uses the url as the cache key. At the same time, requests with similar urls but different `Accept-Encoding` could be cached incorrectly. That's why we use the `Vary` header to instruct the browser to add a value of one or more headers to the cache key.

{{ figure_markup(
  image="vary-directives.png",
  caption="Usage of `Vary` directives.",
  description="A bar chart showing the distribution of `Vary` header. 90.4% of desktop responses use `Accept-Encoding`, much smaller values for the rest with 10.2% for `User-Agent`, approximately 10.5% for `Origin`, and 5.0% for `Accept`. 90.3% of mobile responses use of `Accept-Encoding`, much smaller values for the rest with 10.9% for `User-Agent`, approximately 10.1% for `Origin`, and 4.8% for `Accept`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1279247484&format=interactive",
  height=436,
  sheets_gid="1033782866",
  sql_file="vary_directives.sql"
) }}

The most popular `Vary` header is `Accept-Encoding` with 90.3% usage, followed by `User-Agent` with 10.9%, `Origin` with 10.1%, and `Accept` with 4.8%.

This shows a 1.5% decrease in use of `Accept-Encoding` from 2020.

{{ figure_markup(
  caption="Percent of mobile responses that set the `Vary` header.",
  content="46.3%",
  classes="big-number",
  sheets_gid="1033782866",
  sql_file="vary_directives.sql"
) }}

It's important to point out that only 46.25% of total requests audited use the `Vary` header, but when compared to 2020, we see an overall increase by 2.85%.

{{ figure_markup(
  caption="Percent of mobile responses with the `Vary` header that also set `Cache-Control`.",
  content="83.4%",
  classes="big-number",
  sheets_gid="1033782866",
  sql_file="vary_directives.sql"
) }}

Of the requests using the `Vary` header, 83.4% also have the `Cache-control`. This shows us a 2.1% improvement from 2020.

## Setting cookies on cacheable responses

In the 2020 Caching chapter, we were reminded to be aware of using `set-cookie` with cacheable responses because only 4.9% of responses used the `private` directive, putting a user's private data at risk of being accidentally served to a different user via a CDN.

{{ figure_markup(
  image="cacheable-set-cookie.png",
  caption="Percent of cacheable responses that use `Set-Cookie`.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=261881101&format=interactive",
  sheets_gid="104392613",
  sql_file="set_cookie.sql"
) }}

In 2021, we see an increase in awareness regarding `set-cookie` and caching coexisting. While still only 5% of web pages are using the private directive with `set-cookie`, the total number of cacheable `set-cookie` responses decreased by 4.41%.

## What type of content are we caching?

Font, CSS, and Audio files are over 99% cacheable, with almost 100% of pages currently caching fonts. This could be in part due to their static nature, making them prime choices for caching.

{{ figure_markup(
  image="caching-by-resource-type.png",
  caption="The percent of requests that use caching strategies by resource type.",
  description="A bar chart showing distribution of cacheable resource types. In desktop responses, 99.8% of font, 99.3% of CSS, 99.3% of audio, 98.8% of video, 95.3% of scripts, 91.3% of images, 80.2% of xml, 72.6% of html, 65.0% of other types, and 29.8% of text is cacheable. In mobile responses, 99.8% of font, 99.1% of CSS, 99.0% of audio, 98.8% of video, 95.1% of scripts, 89.9% of images, 81.0% of xml, 76.6% of html, 65.4% of other types, and 29.5% of text is cacheable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2036781114&format=interactive",
  height=436,
  sheets_gid="1202769738",
  sql_file="non_cacheable_by_resource_type.sql"
) }}

However, some of our most commonly used resources are non-cacheable, likely due to their dynamic nature. Notably, HTML saw the highest percentage of non-cacheable resources at 23.4%, followed closely by Images with 10.1%.

When we compare the mobile data between 2020 and 2021, we notice a 5.1% increase in cacheable HTML. This tells us we may be moving towards better usage of our CDNs to cache HTML pages, like those generated by Server-Side Rendered applications. Pages are typically generated by SSR if the content of a particular web page doesn't change frequently. The url can potentially serve the same HTML for weeks or even months, making that content highly cacheable.

Taking a look at the Median TTL across all resource types, we see that even if we cache a similar percentage in total, there is a much longer cache for mobile, particularly for HTML, audio and video.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Type</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Text</td>
        <td class="numeric">0.2</td>
        <td class="numeric">0.2</td>
      </tr>
      <tr>
        <td>XML</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>Other</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>Video</td>
        <td class="numeric">4</td>
        <td class="numeric">8</td>
      </tr>
      <tr>
        <td>HTML</td>
        <td class="numeric">3</td>
        <td class="numeric">14</td>
      </tr>
      <tr>
        <td>Audio</td>
        <td class="numeric">0.2</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>CSS</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Image</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Script</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Font</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Median TTL (in days)",
    sheets_gid="1792973510",
    sql_file="ttl_by_resource.sql"
  ) }}</figcaption>
</figure>

That said, even as we continue to optimize for the mobile experience, it's interesting to note that the potential amount of cacheable desktop resources remains slightly higher than those for mobile.

{{ figure_markup(
  image="cacheable-responses.png",
  caption="Percent of cacheable vs non-cacheable responses.",
  description="A bar chart showing proportion of cacheable responses. 90.4% of desktop and 89.7% of mobile responses are cacheable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=674929574&format=interactive",
  sheets_gid="812850996",
  sql_file="ttl.sql"
) }}

## How do cache TTLs compare to resource age?

We see that Images and Videos maintained the same average age whether from 1st or 3rd party resources. Images consistently had a resource age of 2 years, while most Video resources were between 8-52 weeks old.

Breaking down the other types of content, we discovered Fonts for 3rd parties are cached the most between 8-52 weeks at 72.4%. However, for 1st party the largest resource age groups is evenly split between 8-52 weeks and over 2 years- quite a large variance.
We see similar results for Audio and Scripts where the majority of 1st party are between 8-52 weeks old while for 3rd party they are between 1-7 weeks.

Audio was the most highly cached resource across both 1st and 3rd parties. However, the resource age varied greatly between first party (averaging 8-52 weeks) and third party, at only 1-7 weeks. Audio resources in 1st party situations tend to be updated less frequently (why?), so 3rd parties may be capitalizing on a caching opportunity by offering fresher resources.

{{ figure_markup(
  image="first-party-resource-age-by-content-type.png",
  caption="Distribution of first-party resource age by content type (mobile only).",
  description="A stack bar chart showing the age of first-party content, split into weeks 0-52, > one year and > two years with null and negative figures shown too. The value 0 is used most particularly for first-party HTML, xml and text. There is a mix using 0-52 weeks and then considerable usage for over two years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=597168369&format=interactive",
  sheets_gid="856268091",
  sql_file="resource_age_party_and_type_wise_groups.sql"
) }}

The largest group of cached 1st party CSS (32.2%) tended to be 8-52 weeks old, while the largest group for 3rd parties was less than a week with 51.8% of resources cached for that duration.

Finally, HTML has the largest 1st party group served with less than a week with 42.7% and 3rd party's largest group is between 1-7 weeks with 43.1%.

Considerations after reviewing this data:
- The freshest content for 1st party is HTML while for 3rd party it is CSS.
- The most stale content for both 1st and 3rd party is Images.

This data shows us that 1st parties have prioritized refreshing HTML content, which usually holds the link to JS and CSS files, while 3rd party providers that are mostly CSS and script-driven, like browser extensions, have prioritized keeping their CSS up-to-date. When we consider the origins behind 1st parties vs. 3rd parties, it follows that the _way_ content is delivered may be more important to 3rd parties than the actual content, thus making their presentation and optimization of it, all the more important.

Mobile resources with a cache TTL that was considered too short compared to its content age have seen an improvement since 2020. This data is exciting because it hints at the community's growing understanding of appropriately relative caching.

While a cache TTL that is too long may serve stale content, there is no benefit for the end user if it is too short. The connection between cache TTL and content age is slowly closing this gap, moving from 60.2% in 2020 to 54% in 2021. The more attentive we can be towards to content age (i.e: how often we revamp a page's HTML, CSS etc), the more accurately we can set cache limits.

{{ figure_markup(
  caption="54% of mobile resources are older than their TTL",
  content="54%",
  classes="big-number",
  sheets_gid="768623684",
  sql_file="todo.sql"
) }}

Developers are getting better at setting the cache duration more accurately to the content age, resulting in more responsible, and therefore more effective, caching.

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>1st party</th>
        <th>3rd party</th>
        <th>Overall</th>
      </tr>
    <thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">59.5%</td>
        <td class="numeric">46.2%</td>
        <td class="numeric">54.3%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">60.1%</td>
        <td class="numeric">44.7%</td>
        <td class="numeric">54.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Percent of requests with short TTLs.",
    sheets_gid="1069912023",
    sql_file="content_age_older_than_ttl_by_party.sql"
  ) }}</figcaption>
</figure>

When we split the data between 1st and 3rd party providers, the largest improvements come from 3rd parties where we have a 13.2% improvement. It is highly encouraging to see companies around the world building products for developers that are optimizing caching. It's possible that the developer community's increased attention towards improving performance has encouraged and even incentivized 3rd parties to optimize their caching strategies.

However, the challenge remains for how 1st parties can effectively improve over the coming years.

## Identifying caching opportunities

Based on the **Lighthouse caching TTL** score, we have seen an improvement in pages ranked with a perfect score of 100 increase from 3.3% in 2020 to 4.4% in 2021.

The score reflects whether the pages can benefit from additional caching policy improvements. Even though we are excited to see 31% of pages scoring above the 50 percentile score, a large potential for improvement exists for the 52% of pages that are ranking below the 25 percentile.

{{ figure_markup(
  image="lighthouse-caching-ttl-scores.png",
  caption="Distribution of Lighthouse caching TTL scores.",
  description="A bar chart showing the distribution of Lighthouse audit scores for the `uses-long-cache-ttl` for mobile web pages. 36.2% of the responses have a score less than 0.10, 25.6% have a score between 0.10-0.39, 20.3% have a score between 0.40-0.79, and 12.1% have a score between 0.80-0.99. 4.4% have a score of 1 and 1.3% have no score.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1825783189&format=interactive",
  sheets_gid="2098771743",
  sql_file="cache_ttl_lighthouse_score.sql"
) }}

This makes us consider that even though web pages have some level of caching, the way the policies are used is outdated and not optimized to the latest state of their products.

Based on **Lighthouse wasted bytes** from 2020 to 2021, there was a 3.28% improvement in wasted bytes across all audited pages on repeated views. This lowers the percentage of pages that waste 1 MB from 42.8% to 39.5%, showing a considerable trend from the community towards building products that are less costly for international users with paid internet data plans.

{{ figure_markup(
  image="lighthouse-caching-byte-savings.png",
  caption="Distribution of potential byte savings from caching.",
  description="A bar chart showing the distribution of potential byte savings from the Lighthouse caching audit for mobile web pages. 59.1% of the responses have a size saving less than 1 MB, 19.8% have a saving between 1-2 MB, 7.1% have a saving between 2-3 MB, and 3.9% have a saving between 3-4 MB. 8.7% have a saving of 4 MB or more.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1045307868&format=interactive",
  sheets_gid="469776025",
  sql_file="cache_wastedbytes_lighthouse.sql"
) }}

The current percentage of pages audited that have 0 wasted bytes is still relatively low at 1.34%. In the coming years, we're looking forward to seeing an increase in that percentage as the community continues to focus on optimizing web performance.

## Conclusion

The late, great [Phil Karlton](https://www.karlton.org/karlton/) famously said, "_There are only two hard things in Computer Science: cache invalidation and naming things._", and in all honesty I have always wondered why caching is so hard. My take is that to do caching well, you need two key ingredients: to keep it simple and to understand all potential edge cases.

Unfortunately, when we try to make the cache too clever, we can end up caching the wrong things or, worse, caching too much. On a similar note, understanding all the edge cases requires extensive research, testing, and slow incremental improvements. Even with that, you have to hope that an old browser will not throw you under the bus. But the reason we still chase great caching strategies is that the ultimate reward is very high, with a significant reduction in round-trip requests, high savings for your server, less data required from your users, and ultimately a better user experience.

No matter the case, make sure to have a playbook for how to best use caching:
- Prioritize caching work at an early stage of the development cycle, _and_ after a product is shipped
- Write end-to-end tests to recreate major edge cases
- Regularly audit the site and update cache rules that might be outdated or missing

Ultimately, caching can be made less complex if we spread the knowledge by mentoring our peers and writing good documentation that is simple to understand. Caching is not something that should only be mastered by a few. Our goal is to move towards it being common knowledge across an entire company. Because at the end of the day, what we really want to focus on is building easy and frictionless experiences for our users.
