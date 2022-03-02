---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Caching
description: Caching chapter of the 2019 Web Almanac covering cache-control, expires, TTLs, validitaty, vary, set-cookies, AppCache, Service Workers and opportunities.
authors: [paulcalvano]
reviewers: [foxdavidj, bkardell]
analysts: [paulcalvano, foxdavidj]
editors: [tunetheweb]
translators: []
discuss: 1771
results: https://docs.google.com/spreadsheets/d/1mnq03DqrRBwxfDV05uEFETK0_hPbYOynWxZkV3tFgNk/
paulcalvano_bio: Paul Calvano is a Web Performance Architect at <a hreflang="en" href="https://www.akamai.com/">Akamai</a>, where he helps businesses improve the performance of their websites. He's also a co-maintainer of the HTTP Archive project. You can find him tweeting at <a href="https://twitter.com/paulcalvano">@paulcalvano</a>, blogging at <a hreflang="en" href="https://paulcalvano.com">http://paulcalvano.com</a> and sharing HTTP Archive research at <a hreflang="en" href="https://discuss.httparchive.org">https://discuss.httparchive.org</a>.
featured_quote: Caching is a technique that enables the reuse of previously downloaded content. It provides a significant performance benefit by avoiding costly network requests and it also helps scale an application by reducing the traffic to a website's origin infrastructure. There's an old saying, "the fastest request is the one that you don't have to make" and caching is one of the key ways to avoid having to make requests.
featured_stat_1: 27%
featured_stat_label_1: Responses not using any caching headers
featured_stat_2: 39%
featured_stat_label_2: Responses using the `Vary` header
featured_stat_3: 82%
featured_stat_label_3: Sites that could save 1 MB by optimizing caching better
---

## Introduction

Caching is a technique that enables the reuse of previously downloaded content. It provides a significant [performance](./performance) benefit by avoiding costly network requests and it also helps scale an application by reducing the traffic to a website's origin infrastructure. There's an old saying, "the fastest request is the one that you don't have to make," and caching is one of the key ways to avoid having to make requests.

There are three guiding principles to caching web content: cache as much as you can, for as long as you can, as close as you can to end users.

**Cache as much as you can.** When considering how much can be cached, it is important to understand whether a response is static or dynamic. Requests that are served as a static response are typically cacheable, as they have a one-to-many relationship between the resource and the users requesting it. Dynamically generated content can be more nuanced and require careful consideration.

**Cache for as long as you can.** The length of time you would cache a resource is highly dependent on the sensitivity of the content being cached. A versioned JavaScript resource could be cached for a very long time, while a non-versioned resource may need a shorter cache duration to ensure users get a fresh version.

**Cache as close to end users as you can.** Caching content close to the end user reduces download times by removing latency. For example, if a resource is cached on an end user's browser, then the request never goes out to the network and the download time is as fast as the machine's I/O. For first time visitors, or visitors that don't have entries in their cache, a CDN would typically be the next place a cached resource is returned from. In most cases, it will be faster to fetch a resource from a local cache or a CDN compared to an origin server.

Web architectures typically involve <a hreflang="en" href="https://blog.yoav.ws/tale-of-four-caches/">multiple tiers of caching</a>. For example, an HTTP request may have the opportunity to be cached in:

* An end user's browser
* A service worker cache in the user's browser
* A shared gateway
* CDNs, which offer the ability to cache at the edge, close to end users
* A caching proxy in front of the application, to reduce the backend workload
* The application and database layers

This chapter will explore how resources are cached within web browsers.

## Overview of HTTP caching

For an HTTP client to cache a resource, it needs to understand two pieces of information:

* "How long am I allowed to cache this for?"
* "How do I validate that the content is still fresh?"

When a web browser sends a response to a client, it typically includes headers that indicate whether the resource is cacheable, how long to cache it for, and how old the resource is. RFC 7234 covers this in more detail in section <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.2">4.2 (Freshness)</a> and <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.3">4.3 (Validation)</a>.

The HTTP response headers typically used for conveying freshness lifetime are:

* `Cache-Control` allows you to configure a cache lifetime duration (i.e. how long this is valid for).
* `Expires` provides an expiration date or time (i.e. when exactly this expires).

`Cache-Control` takes priority if both are present. These are [discussed in more detail below](#cache-control-vs-expires).

The HTTP response headers for validating the responses stored within the cache, i.e. giving conditional requests something to compare to on the server side, are:

* `Last-Modified` indicates when the object was last changed.
* Entity Tag (`ETag`) provides a unique identifier for the content.

`ETag` takes priority if both are present. These are [discussed in more detail below](#validating-freshness).

The example below contains an excerpt of a request/response header from HTTP Archive's main.js file. These headers indicate that the resource can be cached for 43,200 seconds (12 hours), and it was last modified more than two months ago (difference between the `Last-Modified` and `Date` headers).

```
> GET /static/js/main.js HTTP/1.1
> Host: httparchive.org
> User-agent: curl/7.54.0
> Accept: */*

< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

The tool <a hreflang="en" href="https://redbot.org/">RedBot.org</a> allows you to input a URL and see a detailed explanation of how the response would be cached based on these headers. For example, <a hreflang="en" href="https://redbot.org/?uri=https%3A%2F%2Fhttparchive.org%2Fstatic%2Fjs%2Fmain.js">a test for the URL above</a> would output the following:

{{ figure_markup(
  image="ch16_fig1_redbot_example.jpg",
  caption="<code>Cache-Control</code> information from RedBot.",
  description="Redbot example response showing detailed information about when the resource was changed, whether caches can store it, how long it can be considered fresh for and warnings.",
  width=600,
  height=138
  )
}}

If no caching headers are present in a response, then the <a hreflang="en" href="https://paulcalvano.com/index.php/2018/03/14/http-heuristic-caching-missing-cache-control-and-expires-headers-explained/">client is permitted to heuristically cache the response</a>. Most clients implement a variation of the RFC's suggested heuristic, which is 10% of the time since `Last-Modified`. However, some may cache the response indefinitely. So, it is important to set specific caching rules to ensure that you are in control of the cacheability.

72% of responses are served with a `Cache-Control` header, and 56% of responses are served with an `Expires` header. However, 27% of responses did not use either header, and therefore are subject to heuristic caching. This is consistent across both desktop and mobile sites.

{{ figure_markup(
  image="fig2.png",
  caption="Presence of HTTP <code>Cache-Control</code> and <code>Expires</code> headers.",
  description="Two identical bar charts for mobile and desktop showing 72% of requests use Cache-Control headers, 56% use Expires and the 27% use neither.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1611664016&format=interactive"
  )
}}

## What type of content are we caching?

A cacheable resource is stored by the client for a period of time and available for reuse on a subsequent request. Across all HTTP requests, 80% of responses are considered cacheable, meaning that a cache is permitted to store them. Out of these,

* 6% of requests have a time to live (TTL) of 0 seconds, which immediately invalidates a cached entry.
* 27% are cached heuristically because of a missing `Cache-Control` header.
* 47% are cached for more than 0 seconds.

The remaining responses are not permitted to be stored in browser caches.

{{ figure_markup(
  image="fig3.png",
  caption="Distribution of cacheable responses.",
  description="A stacked bar chart showing 20% of desktop responses are not cacheable, 47% have a cache greater than zero, 27% are heuristically cached and 6% have a TTL of 0. The stats for mobile are very similar (19%, 47%, 27% and 7%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1868559586&format=interactive"
  )
}}

The table below details the cache TTL values for desktop requests by type. Most content types are being cached however CSS resources appear to be consistently cached at high TTLs.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="5" >Desktop Cache TTL Percentiles (Hours)</th>
      </tr>
      <tr>
        <td></td>
        <th scope="col">10</th>
        <th scope="col">25</th>
        <th scope="col">50</th>
        <th scope="col">75</th>
        <th scope="col">90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">Audio</th>
        <td class="numeric">12</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">CSS</th>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Font</th>
        <td class="numeric">< 1</td>
        <td class="numeric">3</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">87,600</td>
      </tr>
      <tr>
        <th scope="row">HTML</th>
        <td class="numeric">< 1</td>
        <td class="numeric">168</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,766</td>
      </tr>
      <tr>
        <th scope="row">Image</th>
        <td class="numeric">< 1</td>
        <td class="numeric">1</td>
        <td class="numeric">28</td>
        <td class="numeric">48</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Other</th>
        <td class="numeric">< 1</td>
        <td class="numeric">2</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Script</th>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">1</td>
        <td class="numeric">6</td>
        <td class="numeric">720</td>
      </tr>
      <tr>
        <th scope="row">Text</th>
        <td class="numeric">21</td>
        <td class="numeric">336</td>
        <td class="numeric">7,902</td>
        <td class="numeric">8,357</td>
        <td class="numeric">8,740</td>
      </tr>
      <tr>
        <th scope="row">Video</th>
        <td class="numeric">< 1</td>
        <td class="numeric">4</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">336</td>
      </tr>
      <tr>
        <th scope="row">XML</th>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Desktop cache TTL percentiles by resource type.") }}</figcaption>
</figure>

While most of the median TTLs are high, the lower percentiles highlight some of the missed caching opportunities. For example, the median TTL for images is 28 hours, however the 25th percentile is just one-two hours and the 10th percentile indicates that 10% of cacheable image content is cached for less than one hour.

By exploring the cacheability by content type in more detail in Figure 16.5 below, we can see that approximately half of all HTML responses are considered non-cacheable. Additionally, 16% of images and scripts are non-cacheable.

{{ figure_markup(
  image="fig5.png",
  caption="Distribution of cacheability by content type for desktop.",
  description="A stacked bar chart showing the split of not cacheable, cached more than 0 seconds and cached for only 0 seconds by type for desktop. A small, but significant proportion are not cacheable and this goes up to 50% for HTML, most have caching greater than 0 and a smaller amount has a 0 TTL",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1493610744&format=interactive"
  )
}}

The same data for mobile is shown below. As can be seen, the cacheability of content types is consistent between desktop and mobile.

{{ figure_markup(
  image="fig6.png",
  caption="Distribution of cacheability by content type for mobile.",
  description="A stacked bar chart showing the split of not cacheable, cached more than 0 seconds and cached for only 0 seconds by type for mobile. A small, but significant proportion are not cacheable and this goes up to 50% for HTML, most have caching greater than 0 and a smaller amount has a 0 TTL",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1713903788&format=interactive"
  )
}}

## `Cache-Control` vs `Expires`

In HTTP/1.0, the `Expires` header was used to indicate the date/time after which the response is considered stale. Its value is a date timestamp, such as:

`Expires: Thu, 01 Dec 1994 16:00:00 GMT`

HTTP/1.1 introduced the `Cache-Control` header, and most modern clients support both headers. This header provides much more extensibility via caching directives. For example:

* `no-store` can be used to indicate that a resource should not be cached.
* `max-age` can be used to indicate a freshness lifetime.
* `must-revalidate` tells the client a cached entry must be validated with a conditional request prior to its use.
* `private` indicates a response should only be cached by a browser, and not by an intermediary that would serve multiple clients.

53% of HTTP responses include a `Cache-Control` header with the `max-age` directive, and 54% include the Expires header. However, only 41% of these responses use both headers, which means that 13% of responses are caching solely based on the older `Expires` header.

{{ figure_markup(
  image="fig7.png",
  caption="Usage of <code>Cache-Control</code> versus <code>Expires</code> headers.",
  description="A bar chart showing 53% of responses have a `Cache-Control: max-age`, 54%-55% use `Expires`, 41%-42% use both, and 34% use neither. The figures are given for both desktop and mobile but the figures are near identical with mobile having a percentage point higher in use of expires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1909701542&format=interactive"
  )
}}

## `Cache-Control` directives

The HTTP/1.1 <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-5.2.1">specification</a> includes multiple directives that can be used in the `Cache-Control` response header and are detailed below. Note that multiple can be used in a single response.

<figure>
  <table>
    <tr>
     <th>Directive</th>
     <th>Description</th>
    </tr>
    <tr>
     <td>max-age</td>
     <td>Indicates the number of seconds that a resource can be cached for.</td>
    </tr>
    <tr>
     <td>public</td>
     <td>Any cache may store the response.</td>
    </tr>
    <tr>
     <td>no-cache</td>
     <td>A cached entry must be revalidated prior to its use.</td>
    </tr>
    <tr>
     <td>must-revalidate</td>
     <td>A stale cached entry must be revalidated prior to its use.</td>
    </tr>
    <tr>
     <td>no-store</td>
     <td>Indicates that a response is not cacheable.</td>
    </tr>
    <tr>
     <td>private</td>
     <td>The response is intended for a specific user and should not be stored by shared caches.</td>
    </tr>
    <tr>
     <td>no-transform</td>
     <td>No transformations or conversions should be made to this resource.</td>
    </tr>
    <tr>
     <td>proxy-revalidate</td>
     <td>Same as must-revalidate but applies to shared caches.</td>
    </tr>
    <tr>
     <td>s-maxage</td>
     <td>Same as max age but applies to shared caches only.</td>
    </tr>
    <tr>
     <td>immutable</td>
     <td>Indicates that the cached entry will never change, and that revalidation is not necessary.</td>
    </tr>
    <tr>
     <td>stale-while-revalidate</td>
     <td>Indicates that the client is willing to accept a stale response while asynchronously checking in the background for a fresh one.</td>
    </tr>
    <tr>
     <td>stale-if-error</td>
     <td>Indicates that the client is willing to accept a stale response if the check for a fresh one fails.</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="<code>Cache-Control</code> directives.") }}</figcaption>
</figure>

For example, `cache-control: public, max-age=43200` indicates that a cached entry should be stored for 43,200 seconds and it can be stored by all caches.

{{ figure_markup(
  image="fig9.png",
  caption="Usage of <code>Cache-Control</code> directives on mobile.",
  description="A bar chart of 15 cache control directives and their usage ranging from 74.8% for max-age, 37.8% for public, 27.8% for no-cache, 18% for no-store, 14.3% for private, 3.4% for immutable, 3.3% for no-transform, 2.4% for stale-while-revalidate, 2.2% for pre-check, 2.2% for post-check, 1.9% for s-maxage, 1.6% for proxy-revalidate, 0.3% for set-cookie and 0.2% for stale-if-error. The stats are near identical for desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1054108345&format=interactive",
  width=600,
  height=662,
  data_width=600,
  data_height=662
  )
}}

Figure 16.9 above illustrates the top 15 `Cache-Control` directives in use on mobile websites. The results for desktop and mobile are very similar. There are a few interesting observations about the popularity of these cache directives:

* `max-age` is used by almost 75% of `Cache-Control` headers, and `no-store` is used by 18%.
* `public` is rarely necessary since cached entries are assumed `public` unless `private` is specified. Approximately 38% of responses include `public`.
* The `immutable` directive is relatively new, <a hreflang="en" href="https://code.facebook.com/posts/557147474482256/this-browser-tweak-saved-60-of-requests-to-facebook">introduced in 2017</a> and is [supported on Firefox and Safari](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control#Browser_compatibility). Its usage has grown to 3.4%, and it is widely used in <a hreflang="en" href="https://discuss.httparchive.org/t/cache-control-immutable-a-year-later/1195">Facebook and Google third-party responses</a>.

Another interesting set of directives to show up in this list are `pre-check` and `post-check`, which are used in 2.2% of `Cache-Control` response headers (approximately 7.8 million responses). This pair of headers was <a hreflang="en" href="https://blogs.msdn.microsoft.com/ieinternals/2009/07/20/internet-explorers-cache-control-extensions/">introduced in Internet Explorer 5 to provide a background validation</a> and was rarely implemented correctly by websites. 99.2% of responses using these headers had used the combination of `pre-check=0` and `post-check=0`. When both of these directives are set to 0, then both directives are ignored. So, it seems these directives were never used correctly!

In the long tail, there are more than 1,500 erroneous directives in use across 0.28% of responses. These are ignored by clients, and include misspellings such as "nocache", "s-max-age", "smax-age", and "maxage". There are also numerous non-existent directives such as "max-stale", "proxy-public", "surrogate-control", etc.

## `Cache-Control`: `no-store`, `no-cache` and `max-age=0`

When a response is not cacheable, the `Cache-Control` `no-store` directive should be used. If this directive is not used, then the response is cacheable.

There are a few common errors that are made when attempting to configure a response to be non-cacheable:

* Setting `Cache-Control: no-cache` may sound like the resource will not be cacheable. However, the `no-cache` directive requires the cached entry to be revalidated prior to use and is not the same as being non-cacheable.
* Setting `Cache-Control: max-age=0` sets the TTL to 0 seconds, but that is not the same as being non-cacheable. When `max-age` is set to 0, the resource is stored in the browser cache and immediately invalidated. This results in the browser having to perform a conditional request to validate the resource's freshness.

Functionally, `no-cache` and `max-age=0` are similar, since they both require revalidation of a cached resource. The `no-cache` directive can also be used alongside a `max-age` directive that is greater than 0.

Over 3 million responses include the combination of `no-store`, `no-cache`, and `max-age=0`. Of these directives `no-store` takes precedence and the other directives are merely redundant

18% of responses include `no-store` and 16.6% of responses include both `no-store` and `no-cache`. Since `no-store` takes precedence, the resource is ultimately non-cacheable.

The `max-age=0` directive is present on 1.1% of responses (more than four million responses) where `no-store` is not present. These resources will be cached in the browser but will require revalidation as they are immediately expired.

## How do cache TTLs compare to resource age?

So far we've talked about how web servers tell a client what is cacheable, and how long it has been cached for. When designing cache rules, it is also important to understand how old the content you are serving is.

When you are selecting a cache TTL, ask yourself: "how often are you updating these assets?" and "what is their content sensitivity?". For example, if a hero image is going to be modified infrequently, then cache it with a very long TTL. If you expect a JavaScript resource to change frequently, then version it and cache it with a long TTL or cache it with a shorter TTL.

The graph below illustrates the relative age of resources by content type, and you can read a <a hreflang="en" href="https://discuss.httparchive.org/t/analyzing-resource-age-by-content-type/1659">more detailed analysis here</a>. HTML tends to be the content type with the shortest age, and a very large % of traditionally cacheable resources ([scripts](./javascript), [CSS](./css), and [fonts](./fonts)) are older than one year!

{{ figure_markup(
  image="ch16_fig8_resource_age.jpg",
  caption="Resource age distribution by content type.",
  description="A stack bar chart showing the age of content, split into weeks 0-52, > one year and > two years with null and negative figures shown too. The stats are split into first-party and third-party. The value 0 is used most particularly for first-party HTML, text and xml, and for up to 50% of third-party requests across all assets types. There is a mix using intermediary years and then considerable usage for one year and two year.",
  width=600,
  height=325
  )
}}

By comparing a resources cacheability to its age, we can determine if the TTL is appropriate or too low. For example, the resource served by the response below was last modified on 25 Aug 2019, which means that it was 49 days old at the time of delivery. The `Cache-Control` header says that we can cache it for 43,200 seconds, which is 12 hours. It is definitely old enough to merit investigating whether a longer TTL would be appropriate.

```
< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

Overall, 59% of resources served on the web have a cache TTL that is too short compared to its content age. Furthermore, the median delta between the TTL and age is 25 days.

When we break this out by first vs third-party, we can also see that 70% of first-party resources can benefit from a longer TTL. This clearly highlights a need to spend extra attention focusing on what is cacheable, and then ensuring caching is configured correctly.

<figure>
  <table>
    <tr>
     <th>Client</th>
     <th>1st Party</th>
     <th>3rd Party</th>
     <th>Overall</th>
    </tr>
    <tr>
     <td>Desktop</td>
     <td class="numeric">70.7%</td>
     <td class="numeric">47.9%</td>
     <td class="numeric">59.2%</td>
    </tr>
    <tr>
     <td>Mobile</td>
     <td class="numeric">71.4%</td>
     <td class="numeric">46.8%</td>
     <td class="numeric">59.6%</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Percent of requests with short TTLs.") }}</figcaption>
</figure>

## Validating freshness

The HTTP response headers used for validating the responses stored within a cache are `Last-Modified` and `ETag`. The `Last-Modified` header does exactly what its name implies and provides the time that the object was last modified. The `ETag` header provides a unique identifier for the content.

For example, the response below was last modified on 25 Aug 2019 and it has an `ETag` value of `"1566748830.0-3052-3932359948"`

```
< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

A client could send a conditional request to validate a cached entry by using the `Last-Modified` value in a request header named `If-Modified-Since`. Similarly, it could also validate the resource with an `If-None-Match` request header, which validates against the `ETag` value the client has for the resource in its cache.

In the example below, the cache entry is still valid, and an `HTTP 304` was returned with no content. This saves the download of the resource itself. If the cache entry was no longer fresh, then the server would have responded with a `200` and the updated resource which would have to be downloaded again.

```
> GET /static/js/main.js HTTP/1.1
> Host: www.httparchive.org
> User-Agent: curl/7.54.0
> Accept: */*
> If-Modified-Since: Sun, 25 Aug 2019 16:00:30 GMT

< HTTP/1.1 304
< Date: Thu, 17 Oct 2019 02:31:08 GMT
< Server: gunicorn/19.7.1
< Cache-Control: public, max-age=43200
< Expires: Thu, 17 Oct 2019 14:31:08 GMT
< ETag: "1566748830.0-3052-3932359948"
< Accept-Ranges: bytes
```

Overall, 65% of responses are served with a `Last-Modified` header, 42% are served with an `ETag`, and 38% use both. However, 30% of responses include neither a `Last-Modified` or `ETag` header.

{{ figure_markup(
  image="fig12.png",
  caption="Adoption of validating freshness via <code>Last-Modified</code> and <code>ETag</code> headers for desktop websites.",
  description="A bar chart showing 64.4% of desktop requests have a last modified, 42.8% have an ETag, 37.9% have both and 30.7% have neither. The stats for mobile are almost identical at 65.3% for Last Modified, 42.8% for ETag, 38.0% for both and 29.9% for neither.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=20297100&format=interactive"
  )
}}

## Validity of date strings

There are a few HTTP headers used to convey timestamps, and the format for these are very important. The `Date` response header indicates when the resource was served to a client. The `Last-Modified` response header indicates when a resource was last changed on the server. And the `Expires` header is used to indicate how long a resource is cacheable until (unless a `Cache-Control` header is present).

All three of these HTTP headers use a date formatted string to represent timestamps.

For example:

```
> GET /static/js/main.js HTTP/1.1
> Host: httparchive.org
> User-Agent: curl/7.54.0
> Accept: */*

< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

Most clients will ignore invalid date strings, which render them ineffective for the response they are served on. This can have consequences on cacheability, since an erroneous `Last-Modified` header will be cached without a Last-Modified timestamp resulting in the inability to perform a conditional request.

The `Date` HTTP response header is usually generated by the web server or CDN serving the response to a client. Because the header is typically generated automatically by the server, it tends to be less prone to error, which is reflected by the very low percentage of invalid `Date` headers. `Last-Modified` headers were very similar, with only 0.67% of them being invalid. What was very surprising to see though, was that 3.64% `Expires` headers used an invalid date format!

{{ figure_markup(
  image="fig13.png",
  caption="Invalid date formats in response headers.",
  description="A bar chart showing 0.10% of desktop responses have an invalid date, 0.67% have an invalid Last-Modified and 3.64% have an invalid Expires. The stats for mobile are very similar with 0.06% of responses have an invalid date, 0.68% have an invalid Last-Modified and 3.50% have an invalid Expires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1500819114&format=interactive"
  )
}}

Examples of some of the invalid uses of the `Expires` header are:

* Valid date formats, but using a time zone other than GMT
* Numerical values such as 0 or -1
* Values that would be valid in a `Cache-Control` header

The largest source of invalid `Expires` headers is from assets served from a popular third-party, in which a date/time uses the EST time zone, for example `Expires: Tue, 27 Apr 1971 19:44:06 EST`.

## `Vary` header

One of the most important steps in caching is determining if the resource being requested is cached or not. While this may seem simple, many times the URL alone is not enough to determine this. For example, requests with the same URL could vary in what [compression](./compression) they used (Gzip, Brotli, etc.) or be modified and tailored for mobile visitors.

To solve this problem, clients give each cached resource a unique identifier (a cache key). By default, this cache key is simply the URL of the resource, but developers can add other elements (like compression method) by using the Vary header.

A Vary header instructs a client to add the value of one or more request header values to the cache key. The most common example of this is `Vary: Accept-Encoding`, which will result in different cached entries for `Accept-Encoding` request header values (i.e. `gzip`, `br`, `deflate`).

Another common value is `Vary: Accept-Encoding, User-Agent`, which instructs the client to vary the cached entry by both the Accept-Encoding values and the `User-Agent` string. When dealing with shared proxies and CDNs, using values other than `Accept-Encoding` can be problematic as it dilutes the cache keys and can reduce the amount of traffic served from cache.

In general, you should only vary the cache if you are serving alternate content to clients based on that header.

The `Vary` header is used on 39% of HTTP responses, and 45% of responses that include a `Cache-Control` header.

The graph below details the popularity for the top 10 `Vary` header values. `Accept-Encoding` accounts for 90% of `Vary`'s use, with `User-Agent` (11%), `Origin` (9%), and `Accept` (3%) making up much of the rest.

{{ figure_markup(
  image="fig14.png",
  caption="Vary header usage.",
  description="A bar chart showing 90% use of accept-encoding, much smaller values for the rest with 10%-11% for user-agent, approximately 7%-8% for origin and less so for accept, almost not usage for cookie, x-forward-proto, accept-language, host, x-origin, access-control-request-method, and access-control-request-headers",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=384675253&format=interactive",
  width=600,
  height=655,
  data_width=600,
  data_height=655
  )
}}

## Setting cookies on cacheable responses

When a response is cached, its entire headers are swapped into the cache as well. This is why you can see the response headers when inspecting a cached response via DevTools.

{{ figure_markup(
  image="ch16_fig12_header_example_with_cookie.jpg",
  caption="Chrome Dev Tools for a cached resource.",
  description="A screenshot of Chrome Developer Tools showing HTTP response headers for a cached response.",
  width=600,
  height=359
  )
}}

But what happens if you have a `Set-Cookie` on a response? According to <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234 Section 8</a>, the presence of a `Set-Cookie` response header does not inhibit caching. This means that a cached entry might contain a `Set-Cookie` if it was cached with one. The RFC goes on to recommend that you should configure appropriate `Cache-Control` headers to control how responses are cached.

One of the risks of caching responses with `Set-Cookie` is that the cookie values can be stored and served to subsequent requests. Depending on the cookie's purpose, this could have worrying results. For example, if a login cookie or a session cookie is present in a shared cache, then that cookie might be reused by another client. One way to avoid this is to use the `Cache-Control` `private` directive, which only permits the response to be cached by the client browser.

3% of cacheable responses contain a `Set-Cookie header`. Of those responses, only 18% use the `private` directive. The remaining 82% include 5.3 million HTTP responses that include a `Set-Cookie` which can be cached by public and private cache servers.

{{ figure_markup(
  image="ch16_fig16_cacheable_responses_set_cookie.jpg",
  caption="Cacheable responses of <code>Set-Cookie</code> responses.",
  description="A bar chart showing 97% of responses do not use Set-Cookie, and 3% do. This 3% is zoomed into for another bar chart showing the split of 15.3% private, 84.7% public for desktop and similar for mobile at 18.4% public and 81.6% private.",
  width=600,
  height=567
  )
}}

## AppCache and service workers

The Application Cache or AppCache is a feature of HTML5 that allows developers to specify resources the browser should cache and make available to offline users. This feature was <a hreflang="en" href="https://web.archive.org/web/20191115024726/https://html.spec.whatwg.org/multipage/offline.html">deprecated and removed from web standards</a>, and browser support has been diminishing. In fact, when its use is detected, [Firefox v44+ recommends that developers should use service workers instead](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API/Using_Service_Workers). <a hreflang="en" href="https://www.chromestatus.com/feature/5714236168732672">Chrome 70 restricts the Application Cache to secure context only</a>. The industry has moved more towards implementing this type of functionality with service workers - and <a hreflang="en" href="https://caniuse.com/#feat=serviceworkers">browser support</a> has been rapidly growing for it.

In fact, one of the <a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">HTTP Archive trend reports shows the adoption of service workers</a> shown below:

{{ figure_markup(
  image="ch16_fig14_service_worker_adoption.jpg",
  caption='Timeseries of service worker controlled pages. (Source: <a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">HTTP Archive</a>)',
  description="A time series chart showing service worker controlled site usage from October 2016 until July 2019. Usage has been steadily growing throughout the years for both mobile and desktop but is still less than 0.6% for both.",
  width=600,
  height=311
  )
}}

Adoption is still below 1% of websites, but it has been steadily increasing since January 2017. The [Progressive Web App](./pwa) chapter discusses this more, including the fact that it is used a lot more than this graph suggests due to its usage on popular sites, which are only counted once in above graph.

In the table below, you can see a summary of AppCache vs service worker usage. 32,292 websites have implemented a service worker, while 1,867 sites are still utilizing the deprecated AppCache feature.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Does Not Use Server Worker</th>
        <th scope="col">Uses Service Worker</th>
        <th scope="col">Total</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Does Not Use AppCache</td>
        <td class="numeric">5,045,337</td>
        <td class="numeric">32,241</td>
        <td class="numeric">5,077,578</td>
      </tr>
      <tr>
        <td>Uses AppCache</td>
        <td class="numeric">1,816</td>
        <td class="numeric">51</td>
        <td class="numeric">1,867</td>
      </tr>
      <tr>
        <td>Total</td>
        <td class="numeric">5,047,153</td>
        <td class="numeric">32,292</td>
        <td class="numeric">5,079,445</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Number of websites using AppCache versus service worker.") }}</figcaption>
</figure>

If we break this out by HTTP vs HTTPS, then this gets even more interesting. 581 of the AppCache enabled sites are served over HTTP, which means that Chrome is likely disabling the feature. HTTPS is a requirement for using service workers, but 907 of the sites using them are served over HTTP.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <td></td>
        <th scope="col">Does Not Use Service Worker</th>
        <th scope="col">Uses Service Worker</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="rowgroup" rowspan="2" >HTTP</th>
        <td>Does Not Use AppCache</td>
        <td class="numeric">1,968,736</td>
        <td class="numeric">907</td>
      </tr>
      <tr>
        <td>Uses AppCache</td>
        <td class="numeric">580</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <th scope="rowgroup" rowspan="2" >HTTPS</th>
        <td>Does Not Use AppCache</td>
        <td class="numeric">3,076,601</td>
        <td class="numeric">31,334</td>
      </tr>
      <tr>
        <td>Uses AppCache</td>
        <td class="numeric">1,236</td>
        <td class="numeric">50</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Number of websites using AppCache versus service worker usage by HTTP/HTTPS.") }}</figcaption>
</figure>

## Identifying caching opportunities

Google's <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> tool enables users to run a series of audits against web pages, and <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">the cache policy audit</a> evaluates whether a site can benefit from additional caching. It does this by comparing the content age (via the `Last-Modified` header) to the cache TTL and estimating the probability that the resource would be served from cache. Depending on the score, you may see a caching recommendation in the results, with a list of specific resources that could be cached.

{{ figure_markup(
  image="ch16_fig15_lighthouse_example.jpg",
  caption="Lighthouse report highlighting potential cache policy improvements.",
  description="A screenshot of part of a report from the Google Lighthouse tool, with the 'Serve static assets with an efficient cache policy' section open where it lists a number of resources, who's names have been redacted, and the Cache TTL versus the size.",
  width=600,
  height=459
  )
}}

Lighthouse computes a score for each audit, ranging from 0% to 100%, and those scores are then factored into the overall scores. The <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">caching score</a> is based on potential byte savings. When we examine the Lighthouse results, we can get a perspective of how many sites are doing well with their cache policies.

{{ figure_markup(
  image="fig21.png",
  caption='Distribution of Lighthouse scores for the "Uses Long Cache TTL" audit for mobile web pages.',
  description="A stacked bar chart 38.2% of websites get a score of < 10%, 29.0% of websites get a score between 10% and 39%, 18.7% of websites get a score of 40%-79%, 10.7% of websites get a score of 80% - 99%, and 3.4% of websites get a score of 100%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=827424070&format=interactive"
  )
}}

Only 3.4% of sites scored a 100%, meaning that most sites can benefit from some cache optimizations. A vast majority of sites sore below 40%, with 38% scoring less than 10%. Based on this, there is a significant amount of caching opportunities on the web.

Lighthouse also indicates how many bytes could be saved on repeat views by enabling a longer cache policy. Of the sites that could benefit from additional caching, 82% of them can reduce their page weight by up to a whole Mb!

{{ figure_markup(
  image="fig22.png",
  caption="Distribution of potential byte savings from the Lighthouse caching audit.",
  description="A stacked bar chart showing 56.8% of websites have potential byte savings of less than one MB, 22.1% could have savings of one to two MB, 8.3% could save two to three MB. 4.3% could save three to four MB and 6.0% could save more than four MB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1698914500&format=interactive"
  )
}}

## Conclusion

Caching is an incredibly powerful feature that allows browsers, proxies and other intermediaries (such as CDNs) to store web content and serve it to end users. The performance benefits of this are significant, since it reduces round trip times and minimizes costly network requests.

Caching is also a very complex topic. There are numerous HTTP response headers that can convey freshness as well as validate cached entries, and `Cache-Control` directives provide a tremendous amount of flexibility and control. However, developers should be cautious about the additional opportunities for mistakes that it comes with. Regularly auditing your site to ensure that cacheable resources are cached appropriately is recommended, and tools like <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> and <a hreflang="en" href="https://redbot.org/">REDbot</a> do an excellent job of helping to simplify the analysis.
