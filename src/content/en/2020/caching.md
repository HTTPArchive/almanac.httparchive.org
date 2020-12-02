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

## Caveat
Unless specified otherwise, all statistics in this chapter are for desktop, on the understanding that mobile statistics are similar. Where mobile and desktop statistics differ significantly, that is called out.

Many of the responses used in this chapter are from web servers which use commonly-available server packages.  While we may indicate ‘best practices’, the practices may not be possible if the software package used has a limited number of cache options.



