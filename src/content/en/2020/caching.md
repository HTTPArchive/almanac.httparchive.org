---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: IV
chapter_number: 20
title: Caching
description: Caching chapter of the 2020 Web Almanac covering cache-control, expires, TTLs, validitaty, vary, set-cookies, AppCache, Service Workers and opportunities.
authors: [roryhewitt]
reviewers: [csswizardry, jzyang, jaisanth, Soham-S-Sarkar]
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

*More importantly, with browser caching, when Jane’s browser receives the page from the server for the first request, it caches the page. All of her future requests for the example.com home page will be served instantly from her browser’s cache, without a network request.  The example.com server also benefits by not having to process or deal with Jane’s request.*

*Jane is happy. Carlos is happy. The example.com folks are happy.  Everyone is happy.*

It should be clear then, that browser caching provides a significant performance benefit by avoiding costly network requests.  It also helps an application scale by reducing the traffic to a website's origin infrastructure. Server caching also significantly reduces the load on the underlying application.

Caching benefits both the end users (they get their web pages quickly) and the companies serving the web pages (reducing the load on their servers). Caching really is a win-win!

Web architectures typically involve multiple tiers of caching. There are 4 main places (‘caching entities’) where caching can occur:

* An end user's web browser.
* A service worker cache running in the end user's web browser.
* A Content Delivery Network (CDN) or similar proxy, which sits between the end user’s web browser and the origin server.
* The origin server itself.

In this chapter, we will primarily be discussing caching within web browsers (1-2), as opposed to caching at the origin server or in a CDN. Nevertheless, many of the specific caching topics discussed in this chapter rely on the relationship between the browser and the server (or CDN, if one is used).

The key to understanding how caching (and the web) works is to remember that it all consists of transactions between a requesting entity (e.g. a browser) and a responding entity (e.g. a server). Each transaction consists of 2 parts: 

* The request from the requesting entity (“I want object X”), and 
* The response from the responding entity (“Here is object X”). 

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

When considering what to cache, it is important to understand whether the response content is static or dynamic.

* An example of static content is an image.  For instance, a picture of a cat is the same regardless of who’s requesting it or where the requester is located.
* An example of dynamic content is a list of events which are specific to a geographic location. The list will be different based on the requester’s location.

Static content is typically cacheable and often for long periods of time.  It has a one-to-many relationship between the content (one) and the requests (many).

Dynamically generated content can be more nuanced and requires careful consideration. Some dynamic content can be cached, but often for a shorter period of time. The example of a list of upcoming events will change, possibly from day to day. Different variants of the list may also need to be cached and what’s cached in a user’s browser may be a subset of what’s cached on the server or CDN. Nevertheless, it is possible to cache some dynamic contents.  It is incorrect to assume that “dynamic” is another word for “uncacheable”.

### Cache for as long as you can
The length of time you would cache a resource is highly dependent on the content’s volatility (the likelihood and/or frequency of change). For example, an image or a versioned JavaScript file could be cached for a very long time.  An API response or a non-versioned JavaScript file may need a shorter cache duration to ensure users get the most up-to-date response. Some content might only be cached for a minute or less. And, of course, some content should not be cached at all. This is discussed in more detail in Identifying caching opportunities.

Another point to bear in mind is that no matter how long you tell a browser to cache content for, the browser may evict that content from cache before that point in time.  It may do so to make room for other content that is accessed more frequently, etc.. However, a browser will never cache content for longer than it is told.

### Cache as close to end users as you can

Caching content close to the end user reduces download times by removing latency. For example, if a resource is cached in a user's browser, then the request never goes out to the network and it is available instantaneously every time the user needs it. For visitors that don't have entries in their browser’s cache, a CDN would be the next place a cached resource is returned from. In most cases, it will be faster to fetch a resource from a local cache or a CDN compared to an origin server.






