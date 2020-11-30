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

<!-- Copy and paste the converted output. -->

<!-----
NEW: Check the "Suppress top comment" option to remove this info from the output.

Conversion time: 16.058 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β29
* Sun Nov 29 2020 18:38:55 GMT-0800 (PST)
* Source doc: Caching (Web Almanac 2020)

ERROR:
undefined internal link to this URL: "#heading=h.4yy8ol4xoptc".link text: Identifying caching opportunities
?Did you generate a TOC?

* Tables are currently converted to HTML tables.

ERROR:
undefined internal link to this URL: "#heading=h.45wc40uox3rs".link text: conditionally revalidated
?Did you generate a TOC?


ERROR:
undefined internal link to this URL: "#heading=h.szu3k29j7zz9".link text: below
?Did you generate a TOC?


ERROR:
undefined internal link to this URL: "#heading=h.45wc40uox3rs".link text: revalidate
?Did you generate a TOC?


ERROR:
undefined internal link to this URL: "#heading=h.45wc40uox3rs".link text: revalidate
?Did you generate a TOC?

* This document has images: check for >>>>>  gd2md-html alert:  inline image link in generated source and store images to your server. NOTE: Images in exported zip file from Google Docs may not appear in  the same order as they do in your doc. Please check the images!

----->


<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 5; WARNINGs: 0; ALERTS: 27.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>
<a href="#gdcalert12">alert12</a>
<a href="#gdcalert13">alert13</a>
<a href="#gdcalert14">alert14</a>
<a href="#gdcalert15">alert15</a>
<a href="#gdcalert16">alert16</a>
<a href="#gdcalert17">alert17</a>
<a href="#gdcalert18">alert18</a>
<a href="#gdcalert19">alert19</a>
<a href="#gdcalert20">alert20</a>
<a href="#gdcalert21">alert21</a>
<a href="#gdcalert22">alert22</a>
<a href="#gdcalert23">alert23</a>
<a href="#gdcalert24">alert24</a>
<a href="#gdcalert25">alert25</a>
<a href="#gdcalert26">alert26</a>
<a href="#gdcalert27">alert27</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>


<h2>Caching</h2>


<p>Web Almanac 2020



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


<h2>Content team</h2>


**_Authors: Rory Hewitt (rory.hewitt@gmail.com)_**

**_Reviewers: Julia Yang (zyang@akamai.com), Harry Roberts (email needed!), Jai Santhosh (mail@jaisanth.com)_**

**_Analysts: Raghu Ramakrishnan (raghuramakrishnan71@gmail.com)_**

_Hello content team! This is your personal doc to collaborate on and plan the contents of your chapter. Click **Request edit access** above to get started._

_The objective of your chapter is to write a data-driven answer to this big question:_

_“What is the state of caching in 2020?”_

_Learn more about the [chapter lifecycle](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle) and refer to your chapter’s [tracking issue](https://github.com/HTTPArchive/almanac.httparchive.org/issues/917) on GitHub for more info. Thank you all for your contributions!_

<h2></h2>


<h2>Outline</h2>


_The purpose of this section is to define the scope of the chapter by listing all of the topics to be explored. Think of this as your table of contents and list of talking points._

**_Completed by July 20_**



*   **Introduction - what is “caching”? (Testing editing rights)**
    *   Defining caching (how ‘basic’ do we want to get)
*   **Why do we cache?**
    *   Benefits
        *   Performance (lower latency = better end-user experience)
        *   Fewer hits to origin (less infrastructure requirement)
    *   Drawbacks
        *   Risk of stale data cached
        *   Possible extra complexity
        *   May require developer training
        *   May not be consistent with developer environments
*   **Where do we cache?** - browser vs. CDN/proxies vs. servers
*   **How do we cache?** - explicit headers, browser heuristics, etc.
*   **Caching headers**
    *   Cache-Control
    *   Expires
    *   Last-Modified/If-Modified-Since
    *   ETag/If-None-Match
    *   Vary
*   **Service Worker caching**
*   **Identifying caching opportunities** - Lighthouse, Page Speed Insights, RedBot
*   **Conclusion**

<h2></h2>


<h2>Metrics</h2>


_The purpose of this section is to track all of the metrics needed to substantiate the chapter. Analysts can use this section to triage whether the HTTP Archive dataset on BigQuery is able to measure each metric. _

**_Prepared by July 27_**

**_Queried by September 7_**

**_Reviewed by September 14_**



*   Compare most stats to see how they’ve changed compared with 2019 (and possibly 2018 and earlier - are we seeing any ‘trends’)?
*   Is Expires header still being used a lot? If so, is this in conjunction with Cache-Control? What about the Age header?
*   What’s the usage like of ETag, If-Modified-Since, If-None-Match etc.? Are websites using these, or just using static values? If they are, does it signify ‘smart caching’?
*   Any way of determining whether sites use a CDN (possibly via the Server response header)? If so, are we seeing anything different from them, as opposed to sites that don’t use a CDN? How about sites hosted on cloud providers (AWS, GCP, Azure) - do they have better/different caching rules in place? Same goes for sites that use things like WordPress, Drupal etc...
*   Any obvious differences between ‘big’ sites (e.g. large ECommerce sites) and ‘small’ sites (e.g. personal websites)

<h2></h2>


<h2>Draft</h2>


_The purpose of this section is to iterate on a full draft of the chapter after all of the metric results are ready. Data visualizations for inline figures can be copy/pasted in from the results spreadsheet._

**_First draft peer reviewed by November 12_**

**_Data visualizations prototyped by November 26_**

**_Final markdown submitted for editing by November 26_**

<h3>
[Introduction](https://almanac.httparchive.org/en/2019/caching#introduction) - what is “caching”</h3>


Caching is a technique that enables the reuse of previously downloaded content. It involves something (a server which builds web pages, a proxy such as a CDN or the browser itself) storing ‘content’ (web pages, CSS, JS, images, fonts, etc.) and tagging it appropriately, so it can be reused.

Here’s a very high-level example:


    _Jane visits the home page of the [www.example.com](http://www.example.com) website. Jane lives in Los Angeles, CA, and the example.com server is located in Boston, MA.  Jane visiting [www.example.com](www.example.com) involves a network request which has to travel across the country._


    _On the example.com server (a.k.a. Origin server), the home page is retrieved.  The server knows Jane is located in LA and adds dynamic content to the page - a list of upcoming events near her. Then the page is sent back across the country to Jane and displayed on her browser._


    _If there is no caching, if Carlos in LA also visits [www.example.com](www.example.com) after Jane, his request must travel across the country to the example.com server.  The server has to build the same page, including the LA events list.  It will have to send the page back to Carlos._


    _Worse, if Jane revisits the example.com home page, her subsequent requests will act like the first - the request must go across the country and the example.com server must rebuild the home page to send it back to her._


    _So without any caching, the example.com server builds each request from scratch. That’s bad for the server because it’s more work. Additionally, any communication between either Jane or Carlos and the example.com server requires data to travel across the country.  All of this can add up to a slow experience that’s bad for both of them._


    _However, with server caching, when Jane makes her first request the server builds the LA variant of the home page.  It caches the data for reuse by all LA visitors. So when Carlos’s request gets to the example.com server, the server checks if it has the LA variant of the home page in its cache. Since that page is in cache as a result of Jane’s earlier request, the server saves time by returning the cached page._


    _More importantly, with browser caching, when Jane’s browser receives the page from the server for the first request, it caches the page. All of her future requests for the example.com home page will be served instantly from her browser’s cache, without a network request.  The example.com server also benefits by not having to process or deal with Jane’s request._


    _Jane is happy. Carlos is happy. The example.com folks are happy.  Everyone is happy._

It should be clear then, that browser caching provides a significant [performance](https://almanac.httparchive.org/en/2019/performance) benefit by avoiding costly network requests.  It also helps an application scale by reducing the traffic to a website's origin infrastructure. Server caching also significantly reduces the load on the underlying application.

Caching benefits both the end users (they get their web pages quickly) and the companies serving the web pages (reducing the load on their servers). Caching really is a win-win!

Web architectures typically involve [multiple tiers of caching](https://blog.yoav.ws/tale-of-four-caches/). There are 4 main places (‘caching entities’) where caching can occur:



1. An end user's web browser
2. A service worker cache running in the end user's web browser
3. A Content Delivery Network (CDN) or similar proxy, which sits between the end user’s web browser and the origin server
4. The origin server itself

In this chapter, we will primarily be discussing caching within web browsers (1-2), as opposed to caching at the origin server or in a CDN. Nevertheless, many of the specific caching topics discussed in this chapter rely on the relationship between the browser and the server (or CDN, if one is used).

The key to understanding how caching (and the web) works is to remember that it all consists of transactions between a requesting entity (e.g. a browser) and a responding entity (e.g. a server). Each transaction consists of 2 parts: 



1. The request from the requesting entity (_“I want object X”_), and 
2. the response from the responding entity (_“Here is object X”_). 

When we talk about caching, it refers to the object (HTML page, image, etc.) cached by the requesting entity.

Below is a diagram showing how a typical request/response flow works for an object (e.g. a web page).  A CDN sits between the browser and the server. Note that at each point in the browser → CDN → server flow, each of the caching entities first checks whether it has the object in its cache.  It returns the cached object to the requester if found, before forwarding the request to the next caching entity in the chain:



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


<h4>Caveat</h4>


Unless specified otherwise, all statistics in this chapter are for desktop, on the understanding that mobile statistics are similar. Where mobile and desktop statistics differ significantly, that is called out.

Many of the responses used in this chapter are from web servers which use commonly-available server packages.  While we may indicate ‘best practices’, the practices may not be possible if the software package used has a limited number of cache options.

<h3>Caching Guiding Principles</h3>


There are 3 guiding principles to caching web content:



*   Cache as much as you can
*   Cache for as long as you can
*   Cache as close as you can to end users

<h4>**Cache as much as you can**</h4>


When considering what to cache, it is important to understand whether the response content is _static_ or _dynamic_.



*   An example of static content is an image.  For instance, a picture of a cat is the same regardless of who’s requesting it or where the requester is located. Yes, this chapter has a cat picture. \


<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")

*   An example of dynamic content is a list of events which are specific to a geographic location. The list will be different based on the requester’s location.

Static content is typically cacheable and often for long periods of time.  It has a one-to-many relationship between the content (one) and the requests (many).

Dynamically generated content can be more nuanced and requires careful consideration. Some dynamic content can be cached, but often for a shorter period of time. The example of a list of upcoming events will change, possibly from day to day. Different variants of the list may also need to be cached and what’s cached in a user’s browser may be a subset of what’s cached on the server or CDN. Nevertheless, it is possible to cache some dynamic contents.  It is incorrect to assume that “dynamic” is another word for “uncacheable”.

<h4>**Cache for as long as you can**</h4>


The length of time you would cache a resource is highly dependent on the content’s _volatility_ (the likelihood and/or frequency of change). For example, an image or a versioned JavaScript file could be cached for a very long time.  An API response or a non-versioned JavaScript file may need a shorter cache duration to ensure users get the most up-to-date response. Some content might only be cached for a minute or less. And, of course, some content should not be cached at all. This is discussed in more detail in 

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Identifying caching opportunities"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Identifying caching opportunities](#heading=h.4yy8ol4xoptc).

Another point to bear in mind is that no matter how long you _tell_ a browser to cache content for, the browser may evict that content from cache before that point in time.  It may do so to make room for other content that is accessed more frequently, etc.. However, a browser will never cache content for longer than it is told.

<h4>**Cache as close to end users as you can**</h4>


Caching content close to the end user reduces download times by removing latency. For example, if a resource is cached in a user's browser, then the request never goes out to the network and it is available instantaneously every time the user needs it. For visitors that don't have entries in their browser’s cache, a CDN would be the next place a cached resource is returned from. In most cases, it will be faster to fetch a resource from a local cache or a CDN compared to an origin server.

<h3>Some terminology!</h3>




*   Caching entity - the hardware or software that is doing the caching. Due to the focus of this chapter, we use “browser” as a synonym for “caching entity” unless otherwise specified.
*   TTL - the Time-To-Live of a cached object defines how long it can be stored in a cache, typically measured in seconds. After a cached object reaches its TTL, it is marked as ‘stale’ by the cache. Depending on how it was added to the cache (see the details of the caching headers below), it may be evicted from cache immediately, or it may remain in the cache but marked as a ‘stale’ object, requiring revalidation before reuse.
*   Eviction - the automated process by which an object is actually removed from a cache when/after it reaches its TTL or possibly when the cache is full.
*   Revalidation - a cached object that is marked as stale may need to be ‘revalidated’ with the server before it can be displayed to the user.  The browser must first check with the server that the object the browser has in its cache is still up-to-date and valid.
<h3>
[Overview of browser caching](https://almanac.httparchive.org/en/2019/caching#overview-of-http-caching)</h3>



When a browser makes a request for a piece of content (e.g. a web page), it will receive a response which includes not just the content itself (the HTML markup), but also a number of response headers which describe the content, including information about its cacheability.

The caching-related headers, or the absence of them, tell the browser three important pieces of information:



*   **Cacheability**: Is this content cacheable?
*   **Freshness**: If it is cacheable, how long can it be cached for?
*   **Validation**: If it is cacheable, how do I subsequently ensure that my cached version is still fresh?

The full specifications for these caching headers are in [RFC 7234](https://tools.ietf.org/html/rfc7234), and discussed in sections [4.2 (Freshness)](https://tools.ietf.org/html/rfc7234#section-4.2) and [4.3 (Validation)](https://tools.ietf.org/html/rfc7234#section-4.3).

The two HTTP response headers typically used for specifying freshness are `Cache-Control` and `Expires`:



*   `Expires` specifies an explicit expiration date and time (i.e. when exactly the content expires)
*   `Cache-Control` specifies a cache _duration_ (i.e. how long the content can be cached in the browser <span style="text-decoration:underline;">relative to when it was requested</span>)

Often, both these headers are specified; in that case `Cache-Control` takes precedence. These headers are discussed in more detail below.

<h3>
Cache-Control vs Expires</h3>


In the early HTTP/1.0 days of the web, the `Expires` header was the only cache-related response header. As stated above, it is used to indicate the exact date/time after which the response is considered stale. Its value is a date timestamp, such as:


```
Expires: Thu, 01 Dec 1994 16:00:00 GMT
```


The `Expires` header can be thought of as a ‘blunt instrument’.  If a relative cache TTL is required, then processing must be done on the server to generate an appropriate value based upon the current date/time.

HTTP/1.1 introduced the `Cache-Control` header, which is supported by all modern browsers. The `Cache-Control` header provides much more extensibility and flexibility than `Expires` via _caching directives_, several of which can be specified together. Details on the various directives are below.

<h4>Example</h4>


The simple example below shows a request and response for a JavaScript file (some headers have been removed for clarity). The `Date` header indicates the current date (specifically, the date that the content was served).  The `Expires` header indicates that it can be cached for 10 minutes (the difference between the `Expires` and `Date` headers). The `Cache-Control` header specifies the `max-age` directive, which indicates that the resource can be cached for 600 seconds (5 minutes). Since `Cache-Control` takes precedence over `Expires`, the browser will cache the response for 5 minutes, after which it will be marked as stale:


```
GET /static/js/main.js HTTP/2
Host: www.example.org
Accept: */*

HTTP/2 200
Date: Thu, 23 Jul 2020 03:04:17 GMT
Expires: Thu, 23 Jul 2020 03:14:17 GMT
Cache-Control: public, max-age=600
```


RFC 7234 says that if <span style="text-decoration:underline;">no caching headers</span> are present in a response, then the browser is allowed to _heuristically_ cache the response - it suggests a cache duration of 10% of the time since the `Last-Modified` header (if passed). In such cases, most browsers implement a variation of this suggestion, but some may cache the response indefinitely and some may not cache it at all. Because of this variation between browsers, it is important to explicitly set specific caching rules to ensure that you are in control of the cacheability of your content.

<h4>Statistics</h4>




*   73.6% of responses are served with a `Cache-Control` header
*   55.5% of responses are served with an `Expires` header
*   54.8% of responses include both headers
*   25.7% of responses did not include either header, and are therefore subject to heuristic caching



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


<h3>_Figure 1. Usage of HTTP <code>Cache-Control</code> and <code>Expires</code> headers.</em></h3>


These statistics are interesting, since, when compared with 2019, while we are seeing a noticeable increase in the use of the `Cache-Control` header, we are only seeing a very small decrease in the use of the older `Expires` header - effectively a higher percentage of servers are simply adding the `Cache-Control` header to their responses, without removing the `Expires` header.

As we delve into the various directives allowed in the `Cache-Control` header, we will see how its flexibility and power make it a better fit in many cases.

<h3>Cache-Control directives</h3>


When you use the `Cache-Control` header, you specify one or more _directives_ - predefined values that indicate specific caching functionality. Multiple directives are separated by commas and can be specified in any order, although some of them ‘clash’ with one another (e.g. `public` and `private`). Some directives take a value, such as `max-age`.

Below is a table showing the most common `Cache-Control` directives: 


<table>
  <tr>
   <td><strong><em>Directive</em></strong>
   </td>
   <td><strong><em>Description</em></strong>
   </td>
  </tr>
  <tr>
   <td><em>max-age</em>
   </td>
   <td><em>Indicates the number of seconds that a resource can be cached for, relative to the current time. For example <code>max-age=86400</code></em>
   </td>
  </tr>
  <tr>
   <td><em>public</em>
   </td>
   <td><em>Any cache may store the response, including the browser, and any proxies between the server and the browser, such as a CDN. This is assumed by default.</em>
   </td>
  </tr>
  <tr>
   <td><em>no-cache</em>
   </td>
   <td><em>A cached entry must be revalidated prior to its use, via a conditional request, even if it is not marked as stale.</em>
   </td>
  </tr>
  <tr>
   <td><em>must-revalidate</em>
   </td>
   <td><em>A stale cached entry must be revalidated prior to its use, via a conditional request.</em>
   </td>
  </tr>
  <tr>
   <td><em>no-store</em>
   </td>
   <td><em>Indicates that the response must not be cached.</em>
   </td>
  </tr>
  <tr>
   <td><em>private</em>
   </td>
   <td><em>The response is intended for a specific user and should not be stored by shared caches such as proxies and CDNs.</em>
   </td>
  </tr>
  <tr>
   <td><em>proxy-revalidate</em>
   </td>
   <td><em>Same as must-revalidate but applies to shared caches.</em>
   </td>
  </tr>
  <tr>
   <td><em>s-maxage</em>
   </td>
   <td><em>Same as max-age but applies to shared caches (e.g. CDN’s) only.</em>
   </td>
  </tr>
  <tr>
   <td><em>immutable</em>
   </td>
   <td><em>Indicates that the cached entry will never change during its TTL, and that revalidation is not necessary.</em>
   </td>
  </tr>
  <tr>
   <td><em>stale-while-revalidate</em>
   </td>
   <td><em>Indicates that the client is willing to accept a stale response while asynchronously checking in the background for a fresh one.</em>
   </td>
  </tr>
  <tr>
   <td><em>stale-if-error</em>
   </td>
   <td><em>Indicates that the client is willing to accept a stale response if the check for a fresh one fails.</em>
   </td>
  </tr>
</table>


The `max-age` directive is the most commonly-found, since it directly defines the TTL, in the same way that the `Expires` header does.

<h4>Example</h4>


Here is an example of a valid `Cache-Control` header with multiple directives:


```
Cache-Control: public, max-age=86400, must-revalidate
```


This indicates that the object can be cached for 86,400 seconds (1 day) and it can be stored by all caches between the server and the browser, as well as in the browser itself. Once it has reached its TTL and is marked as stale, it can remain in cache, but must be 

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "conditionally revalidated"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[conditionally revalidated](#heading=h.45wc40uox3rs) before reuse.

<h4>Statistics</h4>




*   60.2% of responses include a `Cache-Control` header with the `max-age` directive.
*   45.5% of responses include the `Cache-Control` header with the `max-age` directive and the Expires header, which means that 10% of responses are caching solely based on the older `Expires` header.



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


<h3>_Figure 3. Usage of <code>Cache-Control</code> directives.</em></h3>


Figure 3 above illustrates the 11 `Cache-Control` directives in use on mobile and desktop websites. There are a few interesting observations about the popularity of these cache directives:



*   `max-age` is used by about 60.2% of `Cache-Control` headers, and `no-store` is used by about 9.2% (see 

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "below"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[below](#heading=h.szu3k29j7zz9) for some discussion on the meaning and use of the `no-store` directive).
*   Explicitly specifying `public` isn’t ever really necessary since cached entries are assumed `public` unless `private` is specified. Nevertheless, almost one third of responses include `public` - a waste of a few header bytes on every response :)
*   The `immutable` directive is relatively new, [introduced in 2017](https://code.facebook.com/posts/557147474482256/this-browser-tweak-saved-60-of-requests-to-facebook) and is [only supported on Firefox and Safari](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control#Browser_compatibility) - its usage is still only at about 3.5%, but it is widely seen in responses from Facebook, Google, Wix, Shopify and others. It has the potential to greatly improve cacheability for certain types of requests.

As we head out to the long tail, there are a small percentage of ‘invalid’ directives that can be found; these are ignored by browsers, and just end up wasting header bytes. Broadly they fall into two categories:



*   Misspelled directives such as `nocache` and `s-max-age` and invalid directive syntax, such as using `:` instead of `=` or using `_` instead of `-`
*   Non-existent directives such as `max-stale`, `proxy-public`, `surrogate-control`

The most interesting standout in the list of invalid directives is the use of `no-cache="set-cookie"` (even at only 0.2% of all `Cache-Control` header values, it still makes up more than all the other invalid directives combined). In some [early discussions](https://www.ietf.org/rfc/rfc2109.txt) on the `Cache-Control` header, this syntax was raised as a possible way to ensure that any `Set-Cookie` response headers (which might be user-specific) would not be cached with the object itself by any intermediate proxies such as CDNs. However, this syntax was not included in the final RFC; nearly equivalent functionality can be implemented using the `private` directive, and the `no-cache` directive does not allow a value.

<h3>
[Cache-Control: no-store, no-cache and max-age=0](https://almanac.httparchive.org/en/2019/caching#cache-control-no-store-no-cache-and-max-age0)</h3>


When a response absolutely <span style="text-decoration:underline;">must not</span> be cached, the `Cache-Control` `no-store` directive should be used; if this directive is not specified, then the response _is considered cacheable and may be cached_. Note that if `no-store` is specified, it takes precedence over other directive - this makes sense, since serious privacy and security issues could occur if a resource is cached which should not be.

We can see a few common errors that are made when attempting to configure a response to be non-cacheable:



*   Specifying `Cache-Control: no-cache` may sound like a directive to not cache the resource. However, as noted above, the `no-cache` directive <span style="text-decoration:underline;">does</span> allow the resource to be cached - it simply informs the browser to 

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "revalidate"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[revalidate](#heading=h.45wc40uox3rs) the resource prior to use and is not the same as stopping the resource from being cached at all.
*   Setting `Cache-Control: max-age=0` sets the TTL to 0 seconds, but again, that is not the same as being non-cacheable. When `max-age=0` is specified, the resource is cached, but is marked as stale, resulting in the browser having to immediately 

<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "revalidate"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[revalidate](#heading=h.45wc40uox3rs) its freshness.

Functionally, `no-cache` and `max-age=0` are similar, since they both require revalidation of a cached resource. The `no-cache` directive can also be used alongside a `max-age` directive that is greater than 0 - this results in the object being cached for the specified TTL, but being revalidated prior to every use.

<h4>Statistics</h4>


When looking at the above three discussed directives, 2.3% of responses include the combination of all three `no-store`, `no-cache` and `max-age=0`	directives, 6.6% of responses include both `no-store` and `no-cache`, and a negligible number of responses (&lt; 1%) include `no-store` alone.

As noted above, where `no-store` is specified with either/both of `no-cache` and `max-age=0`, the `no-store` directive takes precedence, and the other directives are ignored. Therefore, if you don’t want content to be cached anywhere, simply specifying `Cache-Control: no-store` is sufficient, and is both simple and uses the minimum number of header bytes.

The `max-age=0` directive is present on less than 2% of responses where `no-store` is <span style="text-decoration:underline;">not</span> specified. In such cases, the resource will be cached in the browser but will require revalidation as it is immediately marked as stale.

<h3>Conditional requests and Revalidation</h3>


There are often cases where a browser has previously requested an object and already has it in its cache but the cache entry has already exceeded its TTL (and is therefore marked as stale) or where the object is defined as one that must be revalidated prior to use.

In these cases, the browser can make a _conditional request_ to the server - effectively saying “_I have object X in my cache - can I use it, or do you have a more recent version I should use instead?_”. The server can respond in one of two ways:



*   “_Yes, the version of object X you have in cache is fine to use_” - in this case the server response consists of a `304 Not Modified` status code and response headers, but no response body 
*   “_No, here is a more recent version of object X - use this instead_” - in this case the server response consists of a `200 OK` status code, response headers, and a new response body (the actual new version of object X)

In either case, the server can optionally include updated caching response headers, possibly extending the TTL of the object so the browser can use the object for a further period of time without needing to make more conditional requests.

The above is known as _revalidation_ and if implemented correctly can <span style="text-decoration:underline;">significantly</span> improve perceived performance - since a `304 Not Modified` response consists only of headers, it is much smaller than a `200 OK` response, resulting in reduced bandwidth and a quicker response.

So how does the server identify a conditional request from a regular request?

It actually all comes down to the <span style="text-decoration:underline;">initial</span> request for the object. When a browser requests an object which it does not already have in its cache, it simply makes a GET request, like this (some headers removed for clarity):


```
GET /index.html HTTP/2
Host: www.example.org
Accept: */*
```


If the server wants to allow the browser to make use of conditional requests (this decision is entirely up to the server!), it can include one or both of two response headers which identify the object as being eligible for <span style="text-decoration:underline;">subsequent</span> conditional requests. The two response headers are:



*   `Last-Modified` - this indicates when the object was last changed. Its value is a date timestamp.
*   `ETag` (Entity Tag) - this provides a unique identifier for the content as a quoted string. It can take any format that the server chooses; it is typically a hash of the file contents, but it could be a timestamp or a simple string.

If both headers are present, `ETag` takes precedence.

<h4>Example - Last-Modified</h4>


When the server receives the request for the file, it can include the date/time that the file was most recently changed as a response header, like this:


```
    HTTP/2 200
    Date: Thu, 23 Jul 2020 03:04:17 GMT
    Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
    Cache-Control: max-age=600

    <html>...lots of html here...</html>
```


The browser will cache this object for 600 seconds (as defined in the `Cache-Control` header), after which it will mark the object as stale. If the browser needs to use the file again, it requests the file from the server just as it did initially, but this time it includes an additional request header, called `If-Modified-Since`, which it sets to the value that was passed in the `Last-Modified` response header in the initial response:


```
    GET /index.html HTTP/2
    Host: www.example.org
    Accept: */*
    If-Modified-Since: Mon, 20 Jul 2020 11:43:22 GMT
```


When the server receives this request, it can check whether the object has changed by comparing the `If-Modified-Since` header value with the date that it most recently changed the file.

If the two values are the same, then the server knows that the browser has the latest version of the file and the server can return a `304 Not Modified` response with just headers (including the same `Last-Modified` header value) and no response body:


```
    HTTP/2 304
    Date: Thu, 23 Jul 2020 03:14:17 GMT
    Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
    Cache-Control: max-age=600
```


However, if the file on the server has changed since it was last requested by the browser, then the server returns a `200 OK` response consisting of headers (including an updated `Last-Modified` header) and the new version of the file in the body:


```
    HTTP/2 200
    Date: Thu, 23 Jul 2020 03:14:17 GMT
    Last-Modified: Thu, 23 Jul 2020 03:12:42 GMT
    Cache-Control: max-age=600

    <html>...lots of html here...</html>
```


As you can see, the `Last-Modified` response header and `If-Modified-Since` request header work as a pair.

<h4>Example - ETag</h4>


The functionality here is almost exactly the same as the date-based `Last-Modified` / `If-Modified-Since` conditional request processing described above.

However, in this case, the Server sends an `ETag` response header - rather than a date timestamp, an `ETag` is simply a string - often a hash of the file contents or a version number calculated by the server. The format of this string is entirely up to the server - the only important fact is that the server changes the ETag value whenever it changes the file.

In this example, when the server receives the initial request for the file, it can return the file’s version in an `ETag` response header, like this:


```
    HTTP/2 200
    Date: Thu, 23 Jul 2020 03:04:17 GMT
    ETag: "v123.4.01"
    Cache-Control: max-age=600

    <html>...lots of html here...</html>
```


As with the `If-Modified-Since` example above, the browser will cache this object for 600 seconds, as defined in the `Cache-Control` header. When it needs to request the object from the server again, it includes an additional request header, called `If-None-Match`, which has the value passed in the `ETag` response header in the initial response:


```
    GET /index.html HTTP/2
    Host: www.example.org
    Accept: */*
    If-None-Match: "v123.4.01"
```


When the server receives this request, it can check whether the object has changed by comparing the `If-None-Match` header value with the current version it has of the file.

If the two values are the same, then the browser has the latest version of the file and the server can return a `304 Not Modified` response with just headers:


```
    HTTP/2 304
    Date: Thu, 23 Jul 2020 03:14:17 GMT
    ETag: "v123.4.01"
    Cache-Control: max-age=600
```


However, if the values are different, then the version of the file on the server is more recent than the version that the browser has, so the server returns a `200 OK` response consisting of headers (including an updated `ETag` header) and the new version of the file:


```
    HTTP/2 200
    Date: Thu, 23 Jul 2020 03:14:17 GMT
    ETag: "v123.5.06"
    Cache-Control: public, max-age=600

    <html>...lots of html here...<html>
```


Again, we see a pair of headers being used for this conditional request processing - the `ETag` response header and the `If-None-Match` request header.

In the same way that the `Cache-Control` header has more power and flexibility than the `Expires` header, the `ETag` header is in many ways an improvement over the `Last-Modified` header. There are two reasons for this:



1. The server can define its own format for the `ETag` header. The example above shows a version string, but it could be a hash, or a random string. By allowing this, versions of an object are not explicitly linked to dates, and this allows a server to create a new version of a file and yet give it the same ETag as the prior version - perhaps if the file change is unimportant
2. ETags can be defined as either ‘strong’ or ‘weak’, which allows browsers to validate them differently. A full understanding and discussion of this functionality is beyond the scope of this chapter, but can be found in [RFC 7232](https://tools.ietf.org/html/rfc7232).

<h4>Statistics</h4>




*   73.5% of responses are served with a `Last-Modified` header. Its usage has marginally <span style="text-decoration:underline;">increased</span> (by &lt; 1%) in comparison to 2019.
*   47.9% of responses are served with an `ETag` header. Out of these responses, 36% are ‘strong’, 98.2% are ‘weak’, and the remaining 1.8% are invalid. In contrast with Last-Modified, the usage of ETag headers has marginally <span style="text-decoration:underline;">decreased</span> (by &lt;1%) in comparison to 2019.
*   42.8% of responses are served with both headers (as noted above, in this case, the `ETag` header takes precedence).
*   21.4% of responses include neither a `Last-Modified` or `ETag` header.



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


_[Figure 3.](https://almanac.httparchive.org/en/2019/caching#fig-12) Adoption of validating freshness via <code>Last-Modified</code> and <code>ETag</code> headers.</em>



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")


_[Figure 3.](https://almanac.httparchive.org/en/2019/caching#fig-12) Adoption of validating freshness via <code>Last-Modified</code> and <code>ETag</code> headers (2019).</em>

<h4>Note</h4>


Correctly-implemented revalidation using conditional requests can <span style="text-decoration:underline;">significantly</span> reduce bandwidth (304 responses are typically much smaller than 200 responses) , load on servers (only a small amount of processing is required to compare change dates or hashes) and improve perceived performance (servers respond more quickly with a 304). However, as we can see from the above statistics, more than a fifth of all requests are not using any form of conditional requests.



*   Only 0.1% of the responses had a 304 status.
*   20.5% of the responses had no `ETag` header and contained the same `Last-Modified` value, passed in the `If-Modified-Since` header of the corresponding request. Out of these, 86% had a 304 status.
*   86.1% of the responses contained the same `ETag` value, passed in the `If-None-Match` header of the corresponding request. If the `If-Modified-Since` header is also present, `ETag` takes precedence. Out of these, 88.9% had a 304 status.



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


<h3>
[Validity of date strings](https://almanac.httparchive.org/en/2019/caching#validity-of-date-strings)</h3>


Throughout this document, we have discussed several caching-related HTTP headers used to convey timestamps:



*   The `Date` response header indicates when the resource was served to a client
*   The `Last-Modified` response header indicates when a resource was last changed on the server
*   The `Expires` header is used to indicate for how long a resource is cacheable.

All three of these HTTP headers use a date formatted string to represent timestamps. The date-formatted string is defined in [RFC 2616](https://tools.ietf.org/html/rfc2616#section-3.3.1), and must specify the ‘GMT’ timestamp string.

For example:


```
    GET /index.html HTTP/2
    Host: www.example.org
    Accept: */*

    HTTP/2 200
    Date: Thu, 23 Jul 2020 03:14:17 GMT
    Cache-Control: max-age=600
    Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
```


Invalid date strings are ignored by most browsers, which can affect the cacheability of the response on which they are served - for example, an invalid `Last-Modified` header will result in the browser being unable to subsequently perform a conditional request for the object, since it is cached without that invalid timestamp.

Because the `Date` HTTP response header is almost always generated automatically by the web server, invalid values are extremely rare. Similarly `Last-Modified` headers had a very low percentage (0.5%) of invalid values. What was very surprising to see though, was that a relatively high 2.9% of `Expires` headers used an invalid date format (2.5% in mobile)



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


_[Figure 4.](https://almanac.httparchive.org/en/2019/caching#fig-13) Invalid date formats in response headers._

Examples of some of the invalid uses of the `Expires` header are:



*   Valid date formats, but using a time zone other than ‘GMT’
*   Numerical values such as 0 or -1
*   Values that would be valid in a `Cache-Control` header

One large source of invalid `Expires` headers is from assets served from a popular third party, in which a date/time uses the EST time zone, for example `Expires: Tue, 27 Apr 1971 19:44:06 EST`. Note that some browsers may understand and accept this date format, on the principle of [robustness](https://en.wikipedia.org/wiki/Robustness_principle), but it should not be assumed that this will be the case.

<h3>
The [Vary header](https://almanac.httparchive.org/en/2019/caching#vary-header)</h3>


We have discussed how a caching entity can determine whether a response object is cacheable, and for how long it can be cached. However, one of the most important steps the caching entity must take is determining if the resource being requested is already in its cache. While this may seem simple, many times the URL alone is not enough to determine this. For example, requests with the same URL could vary in what [compression](https://almanac.httparchive.org/en/2019/compression) they used (gzip, brotli, etc.) or could be returned in different encodings (XML, JSON etc.).

To solve this problem, when a caching entity caches an object, it gives the object a unique identifier (a cache key). When it needs to determine whether the object is in its cache, it checks for the existence of the object using the cache key as a lookup. By default, this cache key is simply the URL used to retrieve the object, but servers can tell the caching entity to include other ‘attributes’ of the response (such as compression method) in the cache key, by including the `Vary` response header, to ensure that the correct object is subsequently retrieved from cache - the `Vary` header identifies ‘variants’ of the object, based on factors other than the URL.

The `Vary` response header instructs the browser to add the value of one or more request header values to the cache key. The most common example of this is `Vary: Accept-Encoding`, which will result in the browser caching the same object in different formats, based on the different `Accept-Encoding` request header values (i.e. `gzip`, `br`, `deflate`).

<h4>Example</h4>


A caching entity sends a request for an HTML file, indicating that it will accept a gzipped response:


```
    GET /index.html HTTP/2
    Host: www.example.org
    Accept-Encoding: gzip
```


The server responds with the object, and indicates that the version it is sending should include the value of the Accept-Encoding request header


```
    HTTP/2 200 OK
    Content-Type: text/html
    Vary: Accept-Encoding
```


In this simplified example, the caching entity would cache the object using a combination of the URL and the `Vary` header.

Another common value is `Vary: Accept-Encoding, User-Agent`, which instructs the client to include both the `Accept-Encoding` and `User-Agent` values in the cache key. When used from a browser, this might not make much sense - each browser has its own User-Agent value, so a browser would not make a request using different User-Agent values anyway. However, when discussing shared proxies and CDNs, using values other than `Accept-Encoding` can be problematic as it dilutes (‘fragments’) the cache and can reduce the amount of traffic served from cache. For instance, if a CDN attempts to cache many different variants of an object, including not just the URL and the Accept-Encoding header but also the User-Agent string (of which there are several thousand different varieties), it may end up filling up the cache with many almost identical (or indeed, identical) cached objects. This is very inefficient, and can lead to very sub-optimal caching within the CDN, resulting in fewer cache hits and greater latency.

In general, you should only vary the cache if you are serving alternate content to clients based on that header.

The `Vary` header is used on 43.4% of HTTP responses, and 84.2%  of these responses include a `Cache-Control` header.

The graph below details the popularity for the top 10 `Vary` header values. `Accept-Encoding` accounts for almost 92% of `Vary`'s use, with `User-Agent` at 10.7%, `Origin` (used for CORS processing) at 8%, and `Accept` at 4.1% making up much of the rest.



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


_[Figure 14.](https://almanac.httparchive.org/en/2019/caching#fig-14) Vary header usage._

<h3>
[Setting cookies on cacheable responses](https://almanac.httparchive.org/en/2019/caching#setting-cookies-on-cacheable-responses)</h3>


When a response is cached, its entire set of response headers are included with the cached object as well. This is why you can see the response headers when inspecting a cached response in Chrome via DevTools:



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


_[Figure 15.](https://almanac.httparchive.org/en/2019/caching#fig-15) Chrome Dev Tools for a cached resource._

But what happens if you have a `Set-Cookie` on a response? According to [RFC 7234 Section 8](https://tools.ietf.org/html/rfc7234#section-8), the presence of a `Set-Cookie` response header does not inhibit caching. This means that a cached entry might contain a `Set-Cookie` response header. The RFC goes on to recommend that you should configure appropriate `Cache-Control` headers to control how responses are cached.

Since we have primarily been talking about browser caching, you may think this isn’t a big issue - the Set-Cookie response headers that were sent by the server to <span style="text-decoration:underline;">me</span> in responses to <span style="text-decoration:underline;">my</span> requests clearly contain <span style="text-decoration:underline;">my</span> cookies, so there’s no problem if <span style="text-decoration:underline;">my</span> browser caches them. However, if there is a CDN between myself and the server, the server must indicate to the CDN that the response should not be cached in the CDN itself, so that the response meant for me is not cached and then served (including my `Set-Cookie` headers!) to other users.

For example, if a login cookie or a session cookie is present in a CDN’s cached object, then that cookie could potentially be reused by another client. The primary way to avoid this is for the server to send the `Cache-Control:` `private` directive, which tells the CDN not to cache the response, because it may only be cached by the client browser.

41.4%% of cacheable responses contain a `Set-Cookie header`. Of those responses, only 4.6% use the `private` directive. The remaining 95.4% (189.2 million HTTP responses) contain at least one `Set-Cookie` response header and can be cached by both public cache servers, such as CDNs. This is concerning and may indicate a continued lack of understanding about how cacheability and cookies coexist.



<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")


_[Figure 16.](https://almanac.httparchive.org/en/2019/caching#fig-16)<code> Set-Cookie</code> in Cacheable responses.</em>



<p id="gdcalert18" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert19">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


_[Figure 16.](https://almanac.httparchive.org/en/2019/caching#fig-16)<code> Set-Cookie</code> in Private and non Private Cacheable responses.</em>

<h3>
S[ervice Workers](https://almanac.httparchive.org/en/2019/caching#appcache-and-service-workers)</h3>


Service Workers are a feature of HTML5 that allow front-end developers to specify scripts that should run outside the ‘normal’ request/response flow of web pages, communicating with the web page via messages. Common uses of service workers are for background synchronization and push notifications and, obviously, for caching - and [browser support](https://caniuse.com/#feat=serviceworkers) has been rapidly growing for them.

In fact, one of the [HTTP Archive trend reports shows the adoption of service workers](https://httparchive.org/reports/progressive-web-apps#swControlledPages) shown below:



<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


_[Figure 17.](https://almanac.httparchive.org/en/2019/caching#fig-17) Time Series of service worker controlled pages. (Source: [HTTP Archive](https://httparchive.org/reports/progressive-web-apps#swControlledPages))_

Adoption is just at 1% of websites, but it has been steadily increasing since July 2019. The [Progressive Web App](https://almanac.httparchive.org/en/2019/pwa) chapter discusses this more, including the fact that it is used a lot more than this graph suggests due to its usage on popular sites, which are only counted once in the above graph.

In the table below, you can see that out of a total of 6,225,774 websites, only 64,373 (1%) have implemented a service worker.


<table>
  <tr>
   <td>
   </td>
   <td><strong>Does not use Service Worker</strong>
   </td>
   <td><strong>Uses Service Worker</strong>
   </td>
   <td><strong>Total</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Sites</strong>
   </td>
   <td>6,225,774
   </td>
   <td>64,373
   </td>
   <td>6,290,147
   </td>
  </tr>
</table>


_[Figure 18.](https://almanac.httparchive.org/en/2019/caching#fig-18) Number of websites using service workers._

If we break this out by HTTP vs HTTPS, then this gets even more interesting. Even though HTTPS is a requirement for using service workers, 1,469 of the sites using them are served over HTTP. 


<table>
  <tr>
   <td>
   </td>
   <td><strong>http</strong>
   </td>
   <td><strong>https</strong>
   </td>
   <td><strong>Total</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Sites using Service Worker</strong>
   </td>
   <td>1,469
   </td>
   <td>62,904
   </td>
   <td>64,373
   </td>
  </tr>
</table>


_[Figure 19.](https://almanac.httparchive.org/en/2019/caching#fig-19) Number of websites using service workers by HTTP/HTTPS._

<h3>
[What type of content are we caching?](https://almanac.httparchive.org/en/2019/caching#what-type-of-content-are-we-caching)</h3>


As we have seen, a cacheable resource is stored by the browser for a period of time and is available for reuse on subsequent requests. Across all HTTP(S) requests, 90.8% of responses are considered cacheable, meaning that a cache is permitted to store them. Out of these,



*   4.2% of requests have a TTL of 0 seconds, which causes the object to be added to cache, but immediately marked as stale, requiring revalidation.
*   28.2% are cached heuristically because of a lack of either a `Cache-Control` or `Expires` header.
*   59.4% are cached for more than 0 seconds.

The remaining 9.2% of responses are not permitted to be stored in browser caches - typically because of `Cache-Control: no-store`.



<p id="gdcalert20" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert21">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


_[Figure 3.](https://almanac.httparchive.org/en/2019/caching#fig-3) Distribution of cacheable and non-cacheable responses._



<p id="gdcalert21" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert22">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")


_[Figure 3.](https://almanac.httparchive.org/en/2019/caching#fig-3) Distribution of TTL in cacheable responses._

The table below details the cache TTL values for desktop requests by type. Most content types are being cached, however CSS resources are consistently cached with high TTLs.


<table>
  <tr>
   <td colspan="6" ><strong>Cache TTL percentiles (in hours)</strong>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td><strong>10</strong>
   </td>
   <td><strong>25</strong>
   </td>
   <td><strong>50</strong>
   </td>
   <td><strong>75</strong>
   </td>
   <td><strong>90</strong>
   </td>
  </tr>
  <tr>
   <td><strong>audio</strong>
   </td>
   <td>6
   </td>
   <td>6
   </td>
   <td>240
   </td>
   <td>720
   </td>
   <td>8,760
   </td>
  </tr>
  <tr>
   <td><strong>css</strong>
   </td>
   <td>24
   </td>
   <td>24
   </td>
   <td>720
   </td>
   <td>8,760
   </td>
   <td>8,760
   </td>
  </tr>
  <tr>
   <td><strong>font</strong>
   </td>
   <td>720
   </td>
   <td>8,760
   </td>
   <td>8,760
   </td>
   <td>8,760
   </td>
   <td>8,760
   </td>
  </tr>
  <tr>
   <td><strong>html</strong>
   </td>
   <td>0
   </td>
   <td>1
   </td>
   <td>336
   </td>
   <td>8,760
   </td>
   <td>87,600
   </td>
  </tr>
  <tr>
   <td><strong>image</strong>
   </td>
   <td>4
   </td>
   <td>168
   </td>
   <td>720
   </td>
   <td>8,760
   </td>
   <td>8,766
   </td>
  </tr>
  <tr>
   <td><strong>other</strong>
   </td>
   <td>0
   </td>
   <td>1
   </td>
   <td>30
   </td>
   <td>240
   </td>
   <td>8,760
   </td>
  </tr>
  <tr>
   <td><strong>script</strong>
   </td>
   <td>0
   </td>
   <td>2
   </td>
   <td>720
   </td>
   <td>8,760
   </td>
   <td>8,760
   </td>
  </tr>
  <tr>
   <td><strong>text</strong>
   </td>
   <td>0
   </td>
   <td>1
   </td>
   <td>6
   </td>
   <td>6
   </td>
   <td>720
   </td>
  </tr>
  <tr>
   <td><strong>video</strong>
   </td>
   <td>6
   </td>
   <td>12
   </td>
   <td>336
   </td>
   <td>336
   </td>
   <td>8,760
   </td>
  </tr>
  <tr>
   <td><strong>xml</strong>
   </td>
   <td>0
   </td>
   <td>24
   </td>
   <td>24
   </td>
   <td>24
   </td>
   <td>8,760
   </td>
  </tr>
</table>


_[Figure 4.](https://almanac.httparchive.org/en/2019/caching#fig-4) Desktop cache TTL percentiles by resource type._

While most of the median TTLs are high, the lower percentiles highlight some of the missed caching opportunities. For example, the median TTL for images is 720 hours (1 month); however the 25th percentile is just 168 hours (1 week) and the 10th percentile has dropped to just a few hours. Compare this with fonts, which have a very high TTL of 8760 hours (1 year) all the way down to the 25th percentile, with even the 10th percentile showing a TTL of 1 month.

By exploring the cacheability by content type in more detail in figure 5 below, we can see that while fonts, video and audio, and CSS files are browser cached at close to 100% (which makes sense, since these files are typically very static), approximately one third of all HTML responses are considered non-cacheable. Additionally, 13.6% of images and scripts are non-cacheable. There is likely some room for improvement here, since no doubt some of these objects are also static and could be cached at a higher rate - remember: _cache as much as you can for as long as you can_!



<p id="gdcalert22" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert23">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")


_[Figure 5.](https://almanac.httparchive.org/en/2019/caching#fig-5) Distribution of cacheability by content type._

<h3>
[How do cache TTLs compare to resource age?](https://almanac.httparchive.org/en/2019/caching#how-do-cache-ttls-compare-to-resource-age)</h3>


So far we've talked about how servers tell a client what is cacheable, and how long it has been cached for. When designing cache rules, it is also important to understand how old the content you are serving is.

When you (the server) are selecting a cache TTL to specify in response headers to send back to the client, ask yourself: "how often am I updating these assets?" and "what is their content sensitivity?". For example, if a hero image is going to be modified infrequently, then it could be cached with a very long TTL. By contrast, if a JavaScript file will change frequently, then either it should be versioned (for instance, by using an ETag or with a unique query string) and cached with a long TTL or it should be cached with a much shorter TTL.

The graphs below illustrate the relative age of resources by content type. Some of the interesting observations in this data are:



*   First party HTML is the content type with the shortest age, with 42.5% of the requests having an age less than a week. In most of the other content types, third party content has a smaller resource age than first party content.
*   Some of the longest aged first party content on the web, with age eight weeks or more, are the traditionally cacheable objects like images (78.3%), scripts (68.6%), CSS (74.1%), web fonts (79.3%), audio (77.9%) and video (78.6%).
*   There is a significant gap in some first vs. third party resources having an age of more than a week. 93.5% of first party CSS are older than one week compared to 51.5% of 3rd party CSS, which are older than one week.



<p id="gdcalert23" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image18.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert24">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image18.png "image_tooltip")
_[Figure 10.](https://almanac.httparchive.org/en/2019/caching#fig-10) Resource age distribution by content type (1st party)._



<p id="gdcalert24" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert25">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image19.png "image_tooltip")
_[Figure 10.](https://almanac.httparchive.org/en/2019/caching#fig-10) Resource age distribution by content type (3rd party)._

By comparing a resource's cacheability to its age, we can determine if the TTL is appropriate or too low.

For example, the resource served below on 18 Oct 2020 was last modified on 30 Aug 2020, which means that it was well over a month old at the time of delivery - this indicates that it is an object which does not change frequently. However, the `Cache-Control` header says that the browser can cache it for only 86,400 seconds (one day). This is a case where a longer TTL might be appropriate, to avoid the browser needing to re-request it (even conditionally) - especially if the website is one that a user might visit multiple times over the course of several days.


```
    HTTP/1.1 200
    Date: Sun, 18 Oct 2020 19:36:57 GMT
    Content-Type: text/html; charset=utf-8
    Content-Length: 3052
    Vary: Accept-Encoding
    Last-Modified: Sun, 30 Aug 2020 16:00:30 GMT
    Cache-Control: public, max-age=86400
```


Overall, 60.7% of resources served on the web have a cache TTL that could be considered too short compared to its content age. Furthermore, the median delta between the TTL and age is 25 days - again, an indication of significant under-caching.

When we break this out by first party vs third party, we can see that more than two-thirds (61.6%) of first-party resources can benefit from a longer TTL. This clearly highlights a need to spend extra attention focusing on what is cacheable, and then ensuring that caching is configured correctly.


<table>
  <tr>
   <td><strong>Client</strong>
   </td>
   <td><strong>1st party</strong>
   </td>
   <td><strong>3rd party</strong>
   </td>
   <td><strong>Overall</strong>
   </td>
  </tr>
  <tr>
   <td>desktop
   </td>
   <td>61.6%
   </td>
   <td>59.3%
   </td>
   <td>60.7%
   </td>
  </tr>
  <tr>
   <td>mobile
   </td>
   <td>61.8%
   </td>
   <td>57.9%
   </td>
   <td>60.2%
   </td>
  </tr>
</table>


_[Figure 11.](https://almanac.httparchive.org/en/2019/caching#fig-11) Percent of requests with short TTLs._

<h3>
[Identifying caching opportunities](https://almanac.httparchive.org/en/2019/caching#identifying-caching-opportunities)</h3>


Google's [Lighthouse](https://developers.google.com/web/tools/lighthouse) tool enables users to run a series of audits against web pages, and [the cache policy audit](https://developers.google.com/web/tools/lighthouse/audits/cache-policy) evaluates whether a site can benefit from additional caching. It does this by comparing the content age (via the `Last-Modified` header) to the cache TTL and estimating the probability that the resource would be served from cache. Depending on the score, you may see a caching recommendation in the results, with a list of specific resources that could be cached.



<p id="gdcalert25" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image20.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert26">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image20.jpg "image_tooltip")
_[Figure 20.](https://almanac.httparchive.org/en/2019/caching#fig-20) Lighthouse report highlighting potential cache policy improvements._

Lighthouse computes a score for each audit, ranging from 0% to 100%, and those scores are then factored into the overall scores. The [caching score](https://developers.google.com/web/tools/lighthouse/audits/cache-policy) is based on potential byte savings. When we examine the Lighthouse results, we can get a perspective of how many sites are doing well with their cache policies.



<p id="gdcalert26" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image21.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert27">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image21.png "image_tooltip")


_[Figure 21.](https://almanac.httparchive.org/en/2019/caching#fig-21) Distribution of Lighthouse audit scores for the "uses-long-cache-ttl" for mobile web pages._

Only 3.3% of sites scored a 100%, meaning that the vast majority of sites can benefit from some cache optimizations. Approximately two-thirds of sites score below 40%, with almost one-third of sites scoring less than 10%. Based on this, there is a significant amount of under-caching, resulting in excess requests and bytes being served across the network.

Lighthouse also indicates how many bytes could be saved on repeat views by enabling a longer cache policy. Of the sites that could benefit from additional caching, 78.6% of them can reduce their page weight by up to 2MB!



<p id="gdcalert27" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image22.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert28">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image22.png "image_tooltip")


_[Figure 22.](https://almanac.httparchive.org/en/2019/caching#fig-22) Distribution of potential byte savings from the Lighthouse caching audit._

<h3>
[Conclusion](https://almanac.httparchive.org/en/2019/caching#conclusion)</h3>


Caching is an incredibly powerful feature that allows browsers, proxies and other intermediaries (such as CDNs) to store web content and serve it to end users. The performance benefits of this are significant, since it reduces round trip times and minimizes costly network requests.

Caching is also a very complex topic, and one that is often left until late in the development cycle (due to requirements to see the very latest version of a site while it is still being designed), then being added in at the last minute. Additionally, caching rules are often defined once and then never changed, even as the underlying content on a site changes. Frequently a default value is chosen without careful consideration.

To correctly cache objects, there are numerous HTTP response headers that can convey freshness as well as validate cached entries, and `Cache-Control` directives provide a tremendous amount of flexibility and control.

Many object types and content that are typically considered to be uncacheable can actually be cached (remember: cache as much as you can!) and many objects are cached for too short a period of time, requiring repeated requests and revalidation (remember: cache for as long as you can!).However, website developers should be cautious about the additional opportunities for mistakes that come with over-caching content.

If the site is intended to be served through a CDN, additional opportunities for caching at the CDN to reduce server load and provide faster response to end-users should be considered, along with the related risks of accidentally caching private information.

However, ‘powerful’ and ‘complex’ do not imply ‘difficult’ - like most everything else, caching is controlled by rules which can be defined fairly easily to provide the best mix of cacheability and privacy. Regularly auditing your site to ensure that cacheable resources are cached appropriately is recommended, and tools like [Lighthouse](https://developers.google.com/web/tools/lighthouse) and [REDbot](https://redbot.org/) do an excellent job of helping to simplify such an analysis.
