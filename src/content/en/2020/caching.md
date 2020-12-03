---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: IV
chapter_number: 20
title: Caching
description: Caching chapter of the 2020 Web Almanac covering cache-control, expires, TTLs, validitaty, vary, set-cookies, AppCache, Service Workers and opportunities.
authors: [roryhewitt]
reviewers: [csswizardry, jzyang, jaisanth, Soham-S-Sarkar, raghuramakrishnan71]
analysts: [raghuramakrishnan71]
translators: []
#roryhewitt_bio: TODO
discuss: 2056
results: https://docs.google.com/spreadsheets/d/1fYmpSN3diOiFrscS75NsjfsrKXzxxhUMNcYSqXnQJQU/
queries: 20_Caching
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
Caching is a technique that enables the reuse of previously downloaded content. It involves something (a server which builds web pages, a proxy such as a CDN or the browser itself) storing ‘content’ (web pages, CSS, JS, images, fonts, etc.) and tagging it appropriately, so it can be reused.

Here’s a very high-level example:

  *Jane visits the home page of the www.example.com website. Jane lives in Los Angeles, CA, and the example.com server is located in Boston, MA.  Jane visiting www.example.com involves a network request which has to travel across the country.*

  *On the example.com server (a.k.a. Origin server), the home page is retrieved.  The server knows Jane is located in LA and adds dynamic content to the page - a list of upcoming events near her. Then the page is sent back across the country to Jane and displayed on her browser.*

  *If there is no caching, if Carlos in LA also visits www.example.com after Jane, his request must travel across the country to the example.com server.  The server has to build the same page, including the LA events list.  It will have to send the page back to Carlos.*

  *Worse, if Jane revisits the example.com home page, her subsequent requests will act like the first - the request must go across the country and the example.com server must rebuild the home page to send it back to her.*

  *So without any caching, the example.com server builds each request from scratch. That’s bad for the server because it’s more work. Additionally, any communication between either Jane or Carlos and the example.com server requires data to travel across the country.  All of this can add up to a slow experience that’s bad for both of them.*

  *However, with server caching, when Jane makes her first request the server builds the LA variant of the home page.  It caches the data for reuse by all LA visitors. So when Carlos’s request gets to the example.com server, the server checks if it has the LA variant of the home page in its cache. Since that page is in cache as a result of Jane’s earlier request, the server saves time by returning the cached page.*

  *More importantly, with browser caching, when Jane’s browser receives the page from the server for the first request, it caches the page. All of her future requests for the example.com home page will be served instantly from her browser's cache, without a network request.  The example.com server also benefits by not having to process or deal with Jane’s request.*

  *Jane is happy. Carlos is happy. The example.com folks are happy.  Everyone is happy.*

It should be clear then, that browser caching provides a significant performance benefit by avoiding costly network requests.  It also helps an application scale by reducing the traffic to a website's origin infrastructure. Server caching also significantly reduces the load on the underlying application.

Caching benefits both the end users (they get their web pages quickly) and the companies serving the web pages (reducing the load on their servers). Caching really is a win-win!

Web architectures typically involve multiple tiers of caching. There are four main places ('caching entities') where caching can occur:

* An end user's web browser.
* A service worker cache running in the end user's web browser.
* A Content Delivery Network (CDN) or similar proxy, which sits between the end user’s web browser and the origin server.
* The origin server itself.

In this chapter, we will primarily be discussing caching within web browsers (1-2), as opposed to caching at the origin server or in a CDN. Nevertheless, many of the specific caching topics discussed in this chapter rely on the relationship between the browser and the server (or CDN, if one is used).

The key to understanding how caching (and the web) works is to remember that it all consists of transactions between a requesting entity (e.g. a browser) and a responding entity (e.g. a server). Each transaction consists of two parts: 

* The request from the requesting entity ("*I want object X*"), and 
* The response from the responding entity ("*Here is object X*"). 

When we talk about caching, it refers to the object (HTML page, image, etc.) cached by the requesting entity.

Below is a diagram showing how a typical request/response flow works for an object (e.g. a web page).  A CDN sits between the browser and the server. Note that at each point in the browser → CDN → server flow, each of the caching entities first checks whether it has the object in its cache.  It returns the cached object to the requester if found, before forwarding the request to the next caching entity in the chain:

Placeholder for Figure 1

### Caveat
Unless specified otherwise, all statistics in this chapter are for desktop, on the understanding that mobile statistics are similar. Where mobile and desktop statistics differ significantly, that is called out.

Many of the responses used in this chapter are from web servers which use commonly-available server packages.  While we may indicate ‘best practices’, the practices may not be possible if the software package used has a limited number of cache options.

## Caching Guiding Principles
There are three guiding principles to caching web content:

* Cache as much as you can
* Cache for as long as you can
* Cache as close as you can to end users

### Cache as much as you can

When considering what to cache, it is important to understand whether the response content is *static* or *dynamic*.

* An example of static content is an image.  For instance, a picture of a cat is the same regardless of who’s requesting it or where the requester is located.
* An example of dynamic content is a list of events which are specific to a geographic location. The list will be different based on the requester’s location.

Static content is typically cacheable and often for long periods of time.  It has a one-to-many relationship between the content (one) and the requests (many).

Dynamically generated content can be more nuanced and requires careful consideration. Some dynamic content can be cached, but often for a shorter period of time. The example of a list of upcoming events will change, possibly from day to day. Different variants of the list may also need to be cached and what’s cached in a user’s browser may be a subset of what’s cached on the server or CDN. Nevertheless, it is possible to cache some dynamic contents.  It is incorrect to assume that “dynamic” is another word for “uncacheable”.

### Cache for as long as you can
The length of time you would cache a resource is highly dependent on the content’s *volatility* (the likelihood and/or frequency of change). For example, an image or a versioned JavaScript file could be cached for a very long time.  An API response or a non-versioned JavaScript file may need a shorter cache duration to ensure users get the most up-to-date response. Some content might only be cached for a minute or less. And, of course, some content should not be cached at all. This is discussed in more detail in Identifying caching opportunities.

Another point to bear in mind is that no matter how long you *tell* a browser to cache content for, the browser may evict that content from cache before that point in time.  It may do so to make room for other content that is accessed more frequently, etc.. However, a browser will never cache content for longer than it is told.

### Cache as close to end users as you can

Caching content close to the end user reduces download times by removing latency. For example, if a resource is cached in a user's browser, then the request never goes out to the network and it is available instantaneously every time the user needs it. For visitors that don't have entries in their browser’s cache, a CDN would be the next place a cached resource is returned from. In most cases, it will be faster to fetch a resource from a local cache or a CDN compared to an origin server.

## Some terminology
* Caching entity - the hardware or software that is doing the caching. Due to the focus of this chapter, we use “browser” as a synonym for “caching entity” unless otherwise specified.

* TTL - the Time-To-Live of a cached object defines how long it can be stored in a cache, typically measured in seconds. After a cached object reaches its TTL, it is marked as 'stale' by the cache. Depending on how it was added to the cache (see the details of the caching headers below), it may be evicted from cache immediately, or it may remain in the cache but marked as a 'stale' object, requiring revalidation before reuse.

* Eviction - the automated process by which an object is actually removed from a cache when/after it reaches its TTL or possibly when the cache is full.
* Revalidation - a cached object that is marked as stale may need to be ‘revalidated’ with the server before it can be displayed to the user.  The browser must first check with the server that the object the browser has in its cache is still up-to-date and valid.

## Overview of browser caching
When a browser makes a request for a piece of content (e.g. a web page), it will receive a response which includes not just the content itself (the HTML markup), but also a number of response headers which describe the content, including information about its cacheability.

The caching-related headers, or the absence of them, tell the browser three important pieces of information:

* **Cacheability**: Is this content cacheable?
* **Freshness**: If it is cacheable, how long can it be cached for?
* **Validation**: If it is cacheable, how do I subsequently ensure that my cached version is still fresh?

The full specifications for these caching headers are in [RFC 7234](https://tools.ietf.org/html/rfc7234#section-8), and discussed in sections 4.2 (Freshness) and 4.3 (Validation).

The two HTTP response headers typically used for specifying freshness are `Cache-Control` and `Expires`:

* `Expires` specifies an explicit expiration date and time (i.e. when exactly the content expires)
* `Cache-Control` specifies a cache duration (i.e. how long the content can be cached in the browser relative to when it was requested)

Often, both these headers are specified; in that case `Cache-Control` takes precedence. These headers are discussed in more detail below.

## Cache-Control vs Expires

In the early HTTP/1.0 days of the web, the `Expires` header was the only cache-related response header. As stated above, it is used to indicate the exact date/time after which the response is considered stale. Its value is a date and time, such as:

`Expires: Thu, 01 Dec 1994 16:00:00 GMT`

The `Expires` header can be thought of as a 'blunt instrument'.  If a relative cache TTL is required, then processing must be done on the server to generate an appropriate value based upon the current date/time.

HTTP/1.1 introduced the `Cache-Control` header, which is supported by all modern browsers. The `Cache-Control` header provides much more extensibility and flexibility than `Expires` via *caching directives*, several of which can be specified together. Details on the various directives are below.

### Example
The simple example below shows a request and response for a JavaScript file (some headers have been removed for clarity). The `Date` header indicates the current date (specifically, the date that the content was served).  The `Expires` header indicates that it can be cached for 10 minutes (the difference between the `Expires` and `Date` headers). The `Cache-Control` header specifies the `max-age` directive, which indicates that the resource can be cached for 600 seconds (5 minutes). Since `Cache-Control` takes precedence over `Expires`, the browser will cache the response for 5 minutes, after which it will be marked as stale:

<pre><code>
> GET /static/js/main.js HTTP/2
> Host: www.example.org
> Accept: */*
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< Expires: Thu, 23 Jul 2020 03:14:17 GMT
< Cache-Control: public, max-age=600
<code></pre>

RFC 7234 says that if no caching headers are present in a response, then the browser is allowed to *heuristically* cache the response - it suggests a cache duration of 10% of the time since the `Last-Modified header` (if passed). In such cases, most browsers implement a variation of this suggestion, but some may cache the response indefinitely and some may not cache it at all. Because of this variation between browsers, it is important to explicitly set specific caching rules to ensure that you are in control of the cacheability of your content.

Placeholder for Figure 2: Usage of HTTP Cache-Control and Expires headers.

### Statistics
* 73.6% of responses are served with a `Cache-Control` header
* 55.5% of responses are served with an `Expires` header
* 54.8% of responses include both headers
* 25.7% of responses did not include either header, and are therefore subject to heuristic caching

These statistics are interesting, since, when compared with 2019, while we are seeing a noticeable increase in the use of the `Cache-Control` header, we are only seeing a very small decrease in the use of the older `Expires` header - effectively a higher percentage of servers are simply adding the `Cache-Control` header to their responses, without removing the `Expires` header.
As we delve into the various directives allowed in the `Cache-Control` header, we will see how its flexibility and power make it a better fit in many cases.

## Cache-Control directives
When you use the `Cache-Control` header, you specify one or more *directives* - predefined values that indicate specific caching functionality. Multiple directives are separated by commas and can be specified in any order, although some of them 'clash' with one another (e.g. `public` and `private`). Some directives take a value, such as `max-age`.

Below is a table showing the most common `Cache-Control` directives: 

<figure>
  <table>
    <tr>
     <th>Directive</th>
     <th>Description</th>
    </tr>
    <tr>
     <td>max-age</td>
     <td>Indicates the number of seconds that a resource can be cached for, relative to the current time. For example `max-age=86400`.</td>
    </tr>
    <tr>
     <td>public</td>
     <td>Any cache may store the response, including the browser, and any proxies between the server and the browser, such as a CDN. This is assumed by default.</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="`Cache-Control` directives.") }}</figcaption>
</figure>

The `max-age` directive is the most commonly-found, since it directly defines the TTL, in the same way that the `Expires` header does.

### Example

Here is an example of a valid Cache-Control header with multiple directives:

`Cache-Control: public, max-age=86400, must-revalidate`

This indicates that the object can be cached for 86,400 seconds (1 day) and it can be stored by all caches between the server and the browser, as well as in the browser itself. Once it has reached its TTL and is marked as stale, it can remain in cache, but must be conditionally revalidated before reuse.

### Statistics
* 60.2% of responses include a `Cache-Control` header with the `max-age` directive.
* 45.5% of responses include the `Cache-Control` header with the `max-age` directive and the `Expires` header, which means that 10% of responses are caching solely based on the older `Expires` header.

Placeholder for Figure 3: Usage of Cache-Control directives

The above figure illustrates the 11 `Cache-Control` directives in use on mobile and desktop websites. There are a few interesting observations about the popularity of these cache directives:
* `max-age` is used by about 60.2% of `Cache-Control` headers, and `no-store` is used by about 9.2% (see below for some discussion on the meaning and use of the no-store directive).
* Explicitly specifying `public` isn’t ever really necessary since cached entries are assumed `public` unless `private` is specified. Nevertheless, almost one third of responses include `public` - a waste of a few header bytes on every response :)
* The `immutable` directive is relatively new, introduced in 2017 and is only supported on Firefox and Safari - its usage is still only at about 3.5%, but it is widely seen in responses from Facebook, Google, Wix, Shopify and others. It has the potential to greatly improve cacheability for certain types of requests.

As we head out to the long tail, there are a small percentage of 'invalid' directives that can be found; these are ignored by browsers, and just end up wasting header bytes. Broadly they fall into two categories:

* Misspelled directives such as `nocache` and `s-max-age` and invalid directive syntax, such as using : instead of = or using _ instead of -.
* Non-existent directives such as `max-stale`, `proxy-public`, `surrogate-control`.

The most interesting standout in the list of invalid directives is the use of `no-cache="set-cookie"` (even at only 0.2% of all `Cache-Control` header values, it still makes up more than all the other invalid directives combined). In some early discussions on the `Cache-Control` header, this syntax was raised as a possible way to ensure that any `Set-Cookie` response headers (which might be user-specific) would not be cached with the object itself by any intermediate proxies such as CDNs. However, this syntax was not included in the final RFC; nearly equivalent functionality can be implemented using the `private` directive, and the `no-cache` directive does not allow a value.

## Cache-Control: no-store, no-cache and max-age=0

When a response absolutely must not be cached, the `Cache-Control no-store` directive should be used; if this directive is not specified, then the response *is considered cacheable and may be cached*. Note that if `no-store` is specified, it takes precedence over other directive - this makes sense, since serious privacy and security issues could occur if a resource is cached which should not be.

We can see a few common errors that are made when attempting to configure a response to be non-cacheable:

* Specifying `Cache-Control: no-cache` may sound like a directive to not cache the resource. However, as noted above, the `no-cache` directive does allow the resource to be cached - it simply informs the browser to revalidate the resource prior to use and is not the same as stopping the resource from being cached at all.
* Setting `Cache-Control: max-age=0` sets the TTL to 0 seconds, but again, that is not the same as being `non-cacheable`. When `max-age=0` is specified, the resource is cached, but is marked as stale, resulting in the browser having to immediately revalidate its freshness.

Functionally, `no-cache` and `max-age=0` are similar, since they both require revalidation of a cached resource. The no-cache directive can also be used alongside a `max-age` directive that is greater than 0 - this results in the object being cached for the specified TTL, but being revalidated prior to every use.

### Statistics

When looking at the above three discussed directives, 2.3% of responses include the combination of all three `no-store`, `no-cache` and `max-age=0`	directives, 6.6% of responses include both `no-store` and `no-cache`, and a negligible number of responses (< 1%) include `no-store` alone.

As noted above, where `no-store` is specified with either/both of `no-cache` and `max-age=0`, the no-store directive takes precedence, and the other directives are ignored. Therefore, if you don’t want content to be cached anywhere, simply specifying `Cache-Control: no-store` is sufficient, and is both simple and uses the minimum number of header bytes.

The `max-age=0` directive is present on less than 2% of responses where `no-store` is not specified. In such cases, the resource will be cached in the browser but will require revalidation as it is immediately marked as stale.

## Conditional requests and Revalidation

There are often cases where a browser has previously requested an object and already has it in its cache but the cache entry has already exceeded its TTL (and is therefore marked as stale) or where the object is defined as one that must be revalidated prior to use.

In these cases, the browser can make a conditional request to the server - effectively saying "*I have object X in my cache - can I use it, or do you have a more recent version I should use instead?*". The server can respond in one of two ways:


* "*Yes, the version of object X you have in cache is fine to use*" - in this case the server response consists of a `304 Not Modified` status code and response headers, but no response body 
* "*No, here is a more recent version of object X - use this instead*" - in this case the server response consists of a `200 OK` status code, response headers, and a new response body (the actual new version of object X)

In either case, the server can optionally include updated caching response headers, possibly extending the TTL of the object so the browser can use the object for a further period of time without needing to make more conditional requests.

The above is known as *revalidation* and if implemented correctly can significantly improve perceived performance - since a `304 Not Modified` response consists only of headers, it is much smaller than a `200 OK` response, resulting in reduced bandwidth and a quicker response.

So how does the server identify a conditional request from a regular request?

It actually all comes down to the initial request for the object. When a browser requests an object which it does not already have in its cache, it simply makes a GET request, like this (some headers removed for clarity):

<pre><code>
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
<code></pre>

If the server wants to allow the browser to make use of conditional requests (this decision is entirely up to the server!), it can include one or both of two response headers which identify the object as being eligible for subsequent conditional requests. The two response headers are:

* `Last-Modified` - this indicates when the object was last changed. Its value is a date timestamp.
* `ETag` (Entity Tag) - this provides a unique identifier for the content as a quoted string. It can take any format that the server chooses; it is typically a hash of the file contents, but it could be a timestamp or a simple string.

If both headers are present, `ETag` takes precedence.

### Example - Last-Modified
When the server receives the request for the file, it can include the date/time that the file was most recently changed as a response header, like this:

<pre><code>
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< <span class="keyword">Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT</span>
< Cache-Control: max-age=600

< <html>...lots of html here...</html>
<code></pre>

The browser will cache this object for 600 seconds (as defined in the `Cache-Control` header), after which it will mark the object as stale. If the browser needs to use the file again, it requests the file from the server just as it did initially, but this time it includes an additional request header, called `If-Modified-Since`, which it sets to the value that was passed in the `Last-Modified` response header in the initial response:

The browser will cache this object for 600 seconds (as defined in the `Cache-Control` header), after which it will mark the object as stale. If the browser needs to use the file again, it requests the file from the server just as it did initially, but this time it includes an additional request header, called `If-Modified-Since`, which it sets to the value that was passed in the `Last-Modified` response header in the initial response:

<pre><code>> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
> If-Modified-Since: Mon, 20 Jul 2020 11:43:22 GMT<code></pre>

When the server receives this request, it can check whether the object has changed by comparing the `If-Modified-Since` header value with the date that it most recently changed the file.

If the two values are the same, then the server knows that the browser has the latest version of the file and the server can return a `304 Not Modified` response with just headers (including the same `Last-Modified` header value) and no response body:
