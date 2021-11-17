---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: TODO
authors: [NishuGoel]
reviewers: [soulcorrosion, mgechev, rviscomi, pankajparkar, tunetheweb]
analysts: [pankajparkar, max-ostapenko, rviscomi]
editors: [rviscomi, pankajparkar]
translators: []
results: https://docs.google.com/spreadsheets/d/1zU9rHpI3nC6jTz3xgN6w13afW7x34xAKBh2IPH-lVxk/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

### <span style="text-decoration:underline;">Introduction</span>

The speed and consistency that the JavaScript language has evolved with over the past years is tremendous. While in the past it was  used primarily for client-side, it has taken a very important and respected place in the world of building services and server-side tools. JavaScript has evolved to a point where it is not only possible to create faster applications but also to [run servers within browsers](https://blog.stackblitz.com/posts/introducing-webcontainers/).

There is a lot that happens in the browser when rendering the application, from downloading JavaScript to parsing, compiling and executing it. Let’s start with that first step and try to understand how much JavaScript is actually requested by pages.


### <span style="text-decoration:underline;">How much JavaScript do we load?</span>

To measure is the key towards improvement, they say. To improve the usage of JavaScript in our applications, we need to measure how much JavaScript being shipped is actually required. Let’s dig in to understand the distribution of JavaScript bytes per page, considering what a major role it plays in the web setup.

The 50th percentile (median) desktop page loads 463 kilobytes of JavaScript, whereas a median page load on a mobile device sends 427 kilobytes. 

<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.1. Distribution of the amount of JavaScript kilobytes loaded per page on desktop and mobile devices.</span>_

Compared to [2019’s results](https://almanac.httparchive.org/en/2019/javascript#fig-2), this shows an increase of 18.4% in the usage of JavaScript for desktop devices and an increase of 18.9% on mobile devices. As we see the trend towards using more JavaScript over the years, which could slow down the rendering of an application given the additional CPU work, let's have a look at how much JavaScript is actually required to be loaded on the page.



<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.2. Distribution of the amount of wasted JavaScript bytes on mobile.</span>_

  

The median page loads 155 kilobytes of unused JavaScript and at the 90th percentile, 598 kilobytes of JavaScript are unused.



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.3. Percent of JavaScript loaded vs. JavaScript unused on mobile page.</span>_

This contributes to 36.2% of unused JavaScript on a page.


        **36.2%**

_<span style="text-decoration:underline;">Figure 2.4. Percent unused from the total loaded JavaScript</span>_

 \
 \
This is such a significant figure to be using the CPU with other important resources and to  just go to waste, given the impact it can have on the [Largest Contentful Paint](https://web.dev/optimize-lcp/) (LCP) of the page, especially for the mobile users with limited data plans. This could be a result of a lot of boilerplate code that is used when using large frameworks or libraries for not very involving features.  \
 \
One step towards improving the percentage is to look at the [percentage of unused JavaScript](https://web.dev/unused-javascript/) when measuring the lighthouse report for the page and [finding opportunities to get rid of the unnecessary JavaScript.](https://web.dev/remove-unused-code/)

**<span style="text-decoration:underline;">JS requests per page </span>**

One of the contributing factors towards slow rendering of the web page could be the requests made on the page, especially when they are blocking.  It would be interesting to look at the number of JavaScript requests made per page on both desktop and mobile devices.



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.5. Distribution of JavaScript requests on desktop and mobile pages.</span>_

The median desktop page loads 21 JavaScript resources(.js and .mjs files), going up to 59 resources at the 90th percentile. 


<table>
  <tr>
   <td><em>percentile</em>
   </td>
   <td>desktop
   </td>
   <td>mobile
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
25</p>

   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
10</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
50</p>

   </td>
   <td><p style="text-align: right">
21</p>

   </td>
   <td><p style="text-align: right">
20</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
75</p>

   </td>
   <td><p style="text-align: right">
37</p>

   </td>
   <td><p style="text-align: right">
35</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
90</p>

   </td>
   <td><p style="text-align: right">
59</p>

   </td>
   <td><p style="text-align: right">
56</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
100</p>

   </td>
   <td><p style="text-align: right">
3509</p>

   </td>
   <td><p style="text-align: right">
2485</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.6. Distribution of the number of JavaScript resources loaded over desktop and mobile devices (2021).</span>_

As compared to the [last year’s results](https://almanac.httparchive.org/en/2020/javascript), there has been a marginal increase in the number of JavaScript resources requested in 2021, with the median number of JavaScript resources loaded being 20 for desktop pages and 19 for mobile.



<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")
 \
_<span style="text-decoration:underline;">Figure 2.7. Distribution of JavaScript resources loaded over desktop and mobile devices by year. \
</span>_

This gives a clear picture of how the number of JS requests made per page has changed over the past year.

 \
To understand the trend of the number of JavaScript resources used over the past years, it would be gripping to see more results from the past years. Let's look into the results for the past three years.


<table>
  <tr>
   <td><strong>Client</strong>
   </td>
   <td><strong>2019</strong>
   </td>
   <td><strong>2020</strong>
   </td>
   <td><strong>2021</strong>
   </td>
  </tr>
  <tr>
   <td><em>Desktop</em>
   </td>
   <td>19
   </td>
   <td>20
   </td>
   <td>21
   </td>
  </tr>
  <tr>
   <td><em>Mobile</em>
   </td>
   <td>18
   </td>
   <td>19
   </td>
   <td>20
   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.8.  Yearly comparison of the median JavaScript resources requested over desktop and mobile from 2019-2021.</span>_

The trend is gradually increasing in the number of JavaScript resources loaded on a page. This would make one wonder if the number should actually increase or decrease considering that fewer JavaScript requests might lead to better performance in some cases but not in others.

This is where the recent advances in the 

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: " HTTP protocol"). Did you generate a TOC? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[ HTTP protocol](#heading=h.whbkdgbdsyom) come in and the idea of reducing the number of JavaScript requests for better performance gets inaccurate.  With the introduction of HTTP/2 and HTTP/3 the overhead of HTTP requests has significantly reduced so requesting the same resources over more requests is not necessarily a bad thing anymore.

Read more about the state of the protocols in the [HTTP](http://./http) chapter.


### [module and nomodule](https://docs.microsoft.com/en-us/lifecycle/announcements/internet-explorer-11-support-end-dates)

When loading a website, the browser renders the HTML and requests the appropriate resources. It consumes the polyfills referenced in the code for the effective rendering and functioning of the page. The modern browsers that support newer syntax like arrow functions, async functions, etc. do not need loads of polyfills to make things work and therefore, should not have to.

This is when differential loading takes care of things. Specifying the `type=”module”`  attribute would serve the modern browsers the bundle with modern syntax with fewer  polyfills, if any. Similarly, older browsers that lack support for modules will be served the bundle with required polyfills and transpiled code syntax with attribute `type=”nomodule”`.

Let's look at the data to understand the adoption of these attributes. \
4.6% of desktop pages use the attribute `type=”module”` whereas only 3.9% of mobile pages use `type=”nomodule”`. This could be due to the fact that the mobile dataset being  much larger contains more “long-tail” websites that might not be using the latest features.


<table>
  <tr>
   <td><strong>client</strong>
   </td>
   <td><strong>module</strong>
   </td>
   <td><strong>nomodule</strong> 
   </td>
  </tr>
  <tr>
   <td><em>Desktop</em>
   </td>
   <td>4.6%
   </td>
   <td>3.9%
   </td>
  </tr>
  <tr>
   <td><em>Mobile</em>
   </td>
   <td>4.3%
   </td>
   <td>3.9%
   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.9.  Distribution of differential loading usage on desktop and mobile clients.</span>_

It is important to note that with the [end of support for IE11 browser](https://docs.microsoft.com/en-us/lifecycle/announcements/internet-explorer-11-support-end-dates), differential loading is now well supported across all browsers that most sites support.

**<span style="text-decoration:underline;">async and defer</span>**

JavaScript loading could be render blocking unless it is specified as deferred or async.

This is one of the contributing factors to the slow website loading as often JavaScript (or at least not all the JavaScript) is needed for the initial render.

However, loading the JavaScript asynchronously or deferring it helps in some ways to improve this experience. The `defer` attribute loads the scripts in the specified order, whereas the `async` attribute loads scripts asynchronously. We will see the statistics for how many pages actually specify these attributes for the JavaScript requested in the browser. 


<table>
  <tr>
   <td>
   </td>
   <td><strong>Values</strong>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><strong>client</strong>
   </td>
   <td><strong>async</strong>
   </td>
   <td><strong>defer</strong>
   </td>
   <td><strong>neither</strong>
   </td>
  </tr>
  <tr>
   <td>desktop
   </td>
   <td><p style="text-align: right">
10.71%</p>

   </td>
   <td><p style="text-align: right">
8.74%</p>

   </td>
   <td><p style="text-align: right">
80.55%</p>

   </td>
  </tr>
  <tr>
   <td>mobile
   </td>
   <td><p style="text-align: right">
10.40%</p>

   </td>
   <td><p style="text-align: right">
9.01%</p>

   </td>
   <td><p style="text-align: right">
80.59%</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.10. Percent of pages using `async`, `defer`, or neither.</span>_

There was an antipattern observed in the last year's results that some websites use both `async` and `defer` attribute resulting in fallback to `async` if the browser supports it.  The usage was so frequent that [11.4%](https://almanac.httparchive.org/en/2020/javascript#how-do-we-load-our-javascript) of mobile pages were seen with at least one 

script with `async` and `defer` attributes used together.  The [root causes](https://twitter.com/rick_viscomi/status/1331735748060524551?s=20) were found and an action item was also taken down to[ remove such usage going forward](https://twitter.com/Kraft/status/1336772912414601224?s=20). It’d be very interesting this year to look at where this stands._<span style="text-decoration:underline;"> \
</span>_

**8.9%**

_<span style="text-decoration:underline;">Figure 2.11. Percent of pages using the `async` and `defer` attribute together.</span>_

_<span style="text-decoration:underline;"> \
</span>_As it turns out, 8.9% of mobile pages still use this antipattern with both `async` and `defer` on the same script element. 

**<span style="text-decoration:underline;">first party vs third party</span>**

The median number of JavaScript resources requested on desktop pages, as observed earlier, is 21. Let us now look into which ones of these are first party or third party requests. \
 \


<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")
_<span style="text-decoration:underline;">Figure 2.12. Distribution of the number of JavaScript requests per mobile page by host.</span>_



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.13. Distribution of the number of JavaScript requests per desktop page by host.</span>_

A median of desktop pages request 11 third-party resources whereas 10 first-party requests. This difference increases as we move up to the 90th percentile as 33 requests on mobile pages are first party but the number goes up to 34 for third-party requests for the mobile pages.  Clearly, the number of third party resources requested is always one step ahead of the first-party resources. Irrespective of the performance and reliability [risks that requesting third-party resources brings](https://css-tricks.com/potential-dangers-of-third-party-javascript/), the usage seems to favour third-party scripts, which could be due to the[ useful interactivity features](https://developers.google.com/web/fundamentals/performance/critical-rendering-path/adding-interactivity-with-javascript) that it gives to the web. 

This is where one has to put their ‘performance-nerd’ cap on, and ensure that using third-party script, he [doesn’t lose control over the performance of the page or let the main thread get bloated](https://csswizardry.com/2017/07/performance-and-resilience-stress-testing-third-parties/) with too much JavaScript being transferred by [loading these scripts better](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript).


### <span style="text-decoration:underline;">AJAX</span>

A lot of JavaScript that we write is used to communicate with servers through asynchronous requests to receive information in various formats. AJAX, or asynchronous JavaScript and XML, is typically used to send and receive data in JSON, XML, HTML, text formats. 

With multiple ways to send and receive data on the web, let's look into how many async requests are sent per page.

A median of 4 asynchronous requests are made per page on both mobile and desktop devices. This applies to the 50th percentile, i.e., the median desktop and mobile pages. 



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.14. The number of asynchronous requests made per page.</span>_

If we look at the long tail and check the number of async requests for the 100th percentile, the difference in the devices is quite remarkable.


<table>
  <tr>
   <td><strong><em>percentile</em></strong>
   </td>
   <td>desktop
   </td>
   <td>mobile
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
25</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
50</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
75</p>

   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
8</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
90</p>

   </td>
   <td><p style="text-align: right">
15</p>

   </td>
   <td><p style="text-align: right">
16</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
100</p>

   </td>
   <td><p style="text-align: right">
623</p>

   </td>
   <td><p style="text-align: right">
867</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.15. Distribution of the number of asynchronous requests made per page.</span>_

The most asynchronous requests made by a desktop page is 623, which is eclipsed by the biggest mobile page, which makes 867 asynchronous requests!

An alternative to the asynchronous AJAX requests are the synchronous. Rather than passing a request to a callback, they block the main thread until the request completes.

However, this practice is [discouraged](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests#:~:text=Note%3A%20Starting%20with%20Gecko%2030.0%20(Firefox%2030.0%20/%20Thunderbird%2030.0%20/%20SeaMonkey%202.27)%2C%20Blink%2039.0%2C%20and%20Edge%2013%2C%20synchronous%20requests%20on%20the%20main%20thread%20have%20been%20deprecated%20due%20to%20their%20negative%20impact%20on%20the%20user%20experience) due to the potential for poor performance and user experiences, and many browsers already warn about the usage.  It would be intriguing to see how many pages still use synchronous AJAX requests.


<table>
  <tr>
   <td><strong>client</strong>
   </td>
   <td><strong>synchronous AJAX (2021)</strong>
   </td>
  </tr>
  <tr>
   <td>mobile
   </td>
   <td><p style="text-align: right">
2.53%</p>

   </td>
  </tr>
  <tr>
   <td>desktop
   </td>
   <td><p style="text-align: right">
2.63%</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.16. Percent of pages that use the deprecated synchronous AJAX requests. </span>_



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.17. Usage of synchronous and asynchronous AJAX requests.</span>_

As we see, there are still more than 2% of desktop and mobile pages that use the deprecated synchronous AJAX requests.



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.18. Usage of synchronous and asynchronous AJAX requests over time on mobile pages.</span>_

Let's look at the trend by comparing the results with the last two years. We see there is a clear increase in the usage of asynchronous AJAX requests. However, no significant decline in the usage of synchronous AJAX requests can be seen over the years.

An AJAX request works with different formats of data that can be sent and received. When a resource is requested, there is more significant information that is sent to the server to make the results specific and clear. One such requirement is sending the correct required content types. The request sent from the browser requests a content type that gets back the data in the requested format.

Out of the vast list of content types that can be requested, let's look at the most commonly requested content types. The commonly requested resources are  JavaScript, images, etc.

The most requested content types on mobile and desktop pages are images at 45% of requests. Images are a broad category inclusive of all the content types related to images, for example, `image/x-icon`, `image/svg+xml`, `image/webp`, `image/jpeg`, etc.

**45.6%**

_<span style="text-decoration:underline;">Figure 2.19. Percent of AJAX requests for images.</span>_


<table>
  <tr>
   <td><strong><em>Values</em></strong>
   </td>
   <td><strong>Desktop</strong>
   </td>
   <td><strong>Mobile</strong>
   </td>
  </tr>
  <tr>
   <td>css
   </td>
   <td><p style="text-align: right">
12.6%</p>

   </td>
   <td><p style="text-align: right">
13.2%</p>

   </td>
  </tr>
  <tr>
   <td>fonts
   </td>
   <td><p style="text-align: right">
5.7%</p>

   </td>
   <td><p style="text-align: right">
5.0%</p>

   </td>
  </tr>
  <tr>
   <td>images
   </td>
   <td><p style="text-align: right">
45.6%</p>

   </td>
   <td><p style="text-align: right">
44.6%</p>

   </td>
  </tr>
  <tr>
   <td>javascript
   </td>
   <td><p style="text-align: right">
32.3%</p>

   </td>
   <td><p style="text-align: right">
33.3%</p>

   </td>
  </tr>
  <tr>
   <td>json
   </td>
   <td><p style="text-align: right">
3.8%</p>

   </td>
   <td><p style="text-align: right">
3.9%</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.20. The most requested content types in AJAX.</span>_

JavaScript is the second most requested content type in AJAX requests, with 33.3% of requests on mobile pages having this content type. This represents content-types like `application/javascript`, `text/javascript`, etc.

**32.3%**

_<span style="text-decoration:underline;">Figure 2.21. Percent of AJAX requests for JavaScript.</span>_

Knowing the number of AJAX requests per page now, we’d also be interested in knowing the most commonly used APIs to request the data from the server.

We can broadly classify these AJAX requests into three different APIs and dig in to see the usage of each of these. The core APIs [XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest) (XHR), [Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch), and [beacon](https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API) are used commonly across websites with XHR being used primarily, however Fetch is gaining popularity and growing rapidly while beacon has minimum usage. 



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")



            _<span style="text-decoration:underline;">Figure 2.22.  Usage of XMLHttpRequest </span>_

The median mobile page makes 2 XHR requests, but at 90th percentile, makes 6 XHR requests. 



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")



                _<span style="text-decoration:underline;">Figure 2.23.  Usage of Fetch</span>_

In the case of the usage of the Fetch API, a median mobile page makes 2 requests per page and in the long tail, reaches 3 requests. This is reaching towards the standard XHR way of making requests and in turn, with a lot more cleaner approach and less boilerplate code, the overall load time will improve too.

One major reason for the lower usage of Beacon could be that it is typically used for sending analytics data, that too in the cases where one wants to ensure the request is sent even if the page might unload soon. This is, however, not guaranteed when using XHR. A good experiment for the future would be to see if some statistics could be collected around any pages using XHR for analytics data, session data etc.



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")



            _<span style="text-decoration:underline;">Figure 2.24.  Usage of Beacon</span>_

It would be interesting to also compare the adoption of XHR and Fetch over time.


<table>
  <tr>
   <td><em>API</em>
   </td>
   <td>2019
   </td>
   <td>2020
   </td>
   <td>2021
   </td>
  </tr>
  <tr>
   <td>Fetch
   </td>
   <td><p style="text-align: right">
20%</p>

   </td>
   <td><p style="text-align: right">
21%</p>

   </td>
   <td><p style="text-align: right">
24%</p>

   </td>
  </tr>
  <tr>
   <td>XHR
   </td>
   <td><p style="text-align: right">
58%</p>

   </td>
   <td><p style="text-align: right">
62%</p>

   </td>
   <td><p style="text-align: right">
78%</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.25.  Adoption of Fetch and XHR by year</span>_



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


_<span style="text-decoration:underline;">			Figure 2.26.  Adoption of AJAX APIs by year</span>_

For both Fetch and XHR, the usage has tremendously increased over the years with Fetch seeing an increase of 38% on desktop pages and 48% for XHR. With a gradual increase for fetch, the focus seems to be towards cleaner requests and handling responses better. 


### <span style="text-decoration:underline;">UI libraries and frameworks</span>

Over the past years, the usage of JavaScript has increased tremendously with the adoption of many libraries and frameworks. In an effort to fasten and ease building the web, many frameworks have been introduced with each bringing features that make the app more performant. This was so prevalent that the term _framework fatigue_ came into existence.

To understand the usage of libraries and frameworks, HTTP Archive uses [Wappalyzer](./methodology#wappalyzer), which detects many technologies used by the web pages.



<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")



        _<span style="text-decoration:underline;">Figure 2.27.  Usage of Javascript libraries and frameworks</span>_

jQuery remains on top with 84% of mobile pages containing jQuery, however React usage has jumped from 4% to 8% since last year, which is a significant increase. Also worth noticing is the usage of Isotope (uses jQuery) to 7% leading to RequireJS falling out of the picture with 2% usage.

One might wonder why jQuery is so dominant and hasn't disappeared over time. There are two main reasons for this. First, as [highlighted over the previous years](https://almanac.httparchive.org/en/2019/javascript#:~:text=There%20are%20a,client-side%20libraries.), is that most of the [WordPress](https://wordpress.org/) sites use jQuery, which contributes to a major participation of jQuery. Second, even if the wide usage of jQuery is ignored for a moment, several of the other top-used JavaScript libraries still rely on jQuery in some way under the hood.

**UI Frameworks **

The adoption of JavaScript frameworks doesn’t see a substantial change compared to the previous years.  With the way the adoption is measured, there is a [detection limitation](https://github.com/AliasIO/wappalyzer/issues/2450) which doesn’t let [Wappalyzer](https://www.wappalyzer.com/) capture the percentage precisely.

It would instead be interesting to look at how the popular frameworks and libraries approach the usage of other libraries. This means how many frameworks or libraries actually rely on other libraries in the production.


<table>
  <tr>
   <td><strong><em>apps</em></strong>
   </td>
   <td><strong>SUM of Percentage</strong>
   </td>
  </tr>
  <tr>
   <td>jQuery
   </td>
   <td><p style="text-align: right">
17%</p>

   </td>
  </tr>
  <tr>
   <td>jQuery, jQuery Migrate
   </td>
   <td><p style="text-align: right">
9%</p>

   </td>
  </tr>
  <tr>
   <td>jQuery, jQuery UI
   </td>
   <td><p style="text-align: right">
4%</p>

   </td>
  </tr>
  <tr>
   <td>jQuery, jQuery Migrate, jQuery UI
   </td>
   <td><p style="text-align: right">
3%</p>

   </td>
  </tr>
  <tr>
   <td>Modernizr, jQuery
   </td>
   <td><p style="text-align: right">
2%</p>

   </td>
  </tr>
  <tr>
   <td>Slick, jQuery, jQuery Migrate
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Slick, jQuery
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>React, jQuery, jQuery Migrate
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>React
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Modernizr, jQuery, jQuery UI
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Modernizr, jQuery, jQuery Migrate, jQuery UI
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Modernizr, jQuery, jQuery Migrate
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Lodash, jQuery
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Lightbox, jQuery, jQuery Migrate
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Lightbox, jQuery
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>Isotope, jQuery, jQuery Migrate
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>GSAP, Lodash, Polyfill, React, RequireJS, jQuery
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>GSAP, Lodash, Polyfill, React, jQuery
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>FancyBox, jQuery, jQuery UI
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
  <tr>
   <td>FancyBox, jQuery
   </td>
   <td><p style="text-align: right">
1%</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.28.  Javascript frameworks usage with JavaScript libraries</span>_

As can be observed, jQuery tops in usage with libraries and frameworks, which could also be a result of using a third party library that involves it. This, as a result, leads to more processing time for the code that the framework or library uses with the other included libraries.

22% of known versions of jQuery are found to be version 3.5.1. This is a big jump compared to last year’s (1.12.4), which could be attributed to Wordpress which constitutes most of the participation of jQuery. 

**Web components and shadow DOM**

With the web becoming componentized, a developer building a single page application may think about a user view as a set of components. This is not only for the sake of developers building dedicated components for each feature, but also when it comes to the reusability of those components. It could be in the same app on a different view or in a completely different application. Such use cases lead to the usage of custom elements and web components in web applications. 

It would be justified to say that with many JavaScript frameworks gaining popularity, the idea of reusability and building dedicated feature-based components has been adopted more widely.  This feeds our curiosity to look into the adoption of custom elements, shadow DOM, template elements.

[Custom Elements](https://developers.google.com/web/fundamentals/web-components/customelements) are customized elements built on top of the [HTMLElement](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement) class. The browser provides a `customElements` API that allows developers to define an element and register it with the browser as a custom element. 

It is noted that 2.7% of desktop pages use custom elements for one or more parts of the web page.

**2.7%**

_<span style="text-decoration:underline;">Figure 2.29. Percent of desktop pages using custom elements.</span>_

[Shadow DOM](https://developers.google.com/web/fundamentals/web-components/shadowdom) allows you to create a dedicated subtree in the DOM for the custom element introduced to the browser. It ensures the styles and nodes inside the element are not accessible outside the element.

0.4% of pages use Shadow DOM specification of web components to ensure a scoped subtree for the element.

**0.4%**

_<span style="text-decoration:underline;">Figure 2.30. Percent of pages using Shadow DOM</span>_

A [&lt;template>](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots#the_truth_about_templates) element is very useful when there is a pattern in the markup which could be reused. The contents of _template_ elements render only when referenced by JavaScript. 

Templates work well when dealing with web components, as the content that is not yet referenced by JavaScript is then appended to a shadow root using the shadow DOM.

**&lt;0.1%**

_<span style="text-decoration:underline;">Figure 2.31. Percent of pages using templates</span>_

Less than 0.1% of web pages have adopted the use of templates. Although templates are well [supported](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots#:~:text=Note%3A%20Templates%20are%20well-supported%20in%20browsers%3B%20the%20Shadow%20DOM%20API%20is%20supported%20by%20default%20in%20Firefox%20(version%2063%20onwards)%2C%20Chrome%2C%20Opera%2C%20Safari%2C%20and%C2%A0Edge%20(starting%20with%20version%2079).) in browsers, there is still a very low percentage of pages using them.


### <span style="text-decoration:underline;">Preload and Prefetch</span>

At the render of a page, the browser downloads the given resources and to prioritise the download of some resources over others the browser uses [resource hints](https://almanac.httparchive.org/en/2021/resource-hints). The resource hints, preload and prefetch, are basically to tell the browser to either download some resource right away or to download it whenever it can to be able to present the resource when required.

The **_preload_** hint tells the browser to download the resource with a higher priority as it will be required on the first page.  \
The **_prefetch_** hint however tells the browser that the resource could be required after some time and it’d better to fetch it when the browser has the capacity to do so and make it available as soon as it is required.

The preload hints are used by almost 15% of mobile pages to load JavaScript, whereas only 1% of mobile pages use the prefetch hint. Overall, 16.1% of desktop pages use one of these resource hints to load the JavaScript resources.

It would also be ideal to see how many preload and prefetch hints are used per page as that affects the impact of these hints. For example, there are 5 resources to be loaded on the render and all five use the preload hint, the preload hint would try to prioritize all the resources and this would then work as it would have without the preload hint.



<p id="gdcalert18" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert19">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.32.  Distribution of prefetch hints per page</span>_



<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image18.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image18.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.33. Distribution of preload hints per page</span>_

A median desktop page loads 1 JavaScript resource with the preload hint whereas 2 JavaScript resources with the prefetch hint. 


<table>
  <tr>
   <td colspan="3" ><strong>Preload</strong>
   </td>
  </tr>
  <tr>
   <td><strong><em>client</em></strong>
   </td>
   <td><p style="text-align: right">
<strong>2020</strong></p>

   </td>
   <td><p style="text-align: right">
<strong>2021</strong></p>

   </td>
  </tr>
  <tr>
   <td>desktop
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td>mobile
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.34. Year over year comparison of the usage of preload hints per page at the 90th percentile.</span>_


<table>
  <tr>
   <td colspan="3" ><strong>Prefetch</strong>
   </td>
  </tr>
  <tr>
   <td><strong><em>client</em></strong>
   </td>
   <td><p style="text-align: right">
<strong>2020</strong></p>

   </td>
   <td><p style="text-align: right">
<strong>2021</strong></p>

   </td>
  </tr>
  <tr>
   <td>desktop
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
13</p>

   </td>
  </tr>
  <tr>
   <td>mobile
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
11</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.35. Year over year comparison of the usage of prefetch hints per page at the 90th percentile.</span>_

Looking at the trend of the usage of preload and prefetch hints over the past years, it can be noted that the trend favours a decrease in the usage of more preload and prefetch hints per page.


### <span style="text-decoration:underline;">Compression</span>

When sending resources over the network, it becomes important to look at an efficient way of doing it, and compressing these resources using different techniques either statically or dynamically boosts the performance and makes the process faster.

Most of the compressed resources use either gzip compression, or brotli (br) compression, or the compression technique is just not set.



<p id="gdcalert20" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert21">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image19.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.36 Compression methods usage percentage by request</span>_

It is noted that 56% of JS requests apply the gzip compression method, whereas 31% of requests from mobile devices have the brotli compression applied. 

**30%**

_<span style="text-decoration:underline;">Figure 2.37 Desktop requests apply brotli compression</span>_

  

An interesting observation here is the trend of the usage of these compression methods as compared to the previous year. The usage of gzip has gone down by almost 10% and brotli has increased by 11%. The trend definitely indicates the focus on smaller size files with more levels of compression that Brotli provides as compared to gzip.



<p id="gdcalert21" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image20.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert22">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image20.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.38 Compression methods for the year 2019</span>_

With such comparable data, let us actually check if the percentage difference is somehow impacted by the resources being first party or third party.



<p id="gdcalert22" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image21.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert23">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image21.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.39 Compression methods for first party vs third party</span>_

59% of third-party scripts are gzipped and 30% are brotli compressed. Looking at first party scripts, these are 52% with gzip compression but only 32% with brotli. There are still 11% of third-party scripts that do not have any compression method defined for the resources.



<p id="gdcalert23" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image22.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert24">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image22.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.40 Uncompressed resources for first party vs third party</span>_

The way preloading all our requests negates the impact of the attribute, a similar problem occurs when we try to optimise and compress some resource that doesn’t need compression and is already small. It is observed that 90% of uncompressed third party JS resources are &lt; 5 KB, and uncompressed first party resources less than 10kb are only 8%. 


### <span style="text-decoration:underline;">Minification</span>

When working towards reducing the script parsing time, we tend to focus on all the opportunities to make our code smaller and relevant. One such idea is to minify the files and bring down the bytes usage.

The lighthouse report also [highlights the unminified JS being used](https://web.dev/unminified-javascript/) and lists these unminified files and the opportunities to save.



<p id="gdcalert24" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image23.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert25">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image23.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.41 Percentage distribution of unminified JS audit scores</span>_

It is noted that 67% of mobile pages have an "unminified JS" score between 0.9 and 1.0, meaning that they have a few unminified JS resources.

 This is an improvement of 10% as compared to the results from the last year (2020).

To dive deeper into understanding how many bytes per page are unminified.



<p id="gdcalert25" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image24.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert26">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image24.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.42 Percentage distribution of unminified JS bytes per page</span>_

And it is found that 57% of mobile pages have 0 KB of unminified JS whereas 18% of those have 0-10 kilobytes of unminified JS.

The first-party vs. third party analysis in this case shows that 82% of the average mobile page's unminified JS bytes actually come from first party scripts.



<p id="gdcalert26" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image25.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert27">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image25.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.43 Average distribution of unminified JS Bytes</span>_


### <span style="text-decoration:underline;">Source maps</span>

Source maps are files sent along with the JavaScript resource files to let the browser map the minified or compressed file to their original version of that file. This is how source maps help us in debugging in the production environment. 

**0.09%**

_<span style="text-decoration:underline;">Figure 2.44 Mobile pages using the sourcemap header</span>_

It is found that ~98% of mobile pages do not use the SourceMap response header on script resources whereas only 0.09% use it on resources. One reason for this extremely small percentage could be that not many sites choose to put their source code in production through the source map.

An analysis of how many sites actually send the source map header on their first party or third party scripts shows:



<p id="gdcalert27" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image26.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert28">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image26.png "image_tooltip")


_<span style="text-decoration:underline;">Figure 2.45 Usage of sourcemap headers in first party vs third party</span>_

98% of the JS requests that include a SourceMap header on mobile are for first party scripts.


### <span style="text-decoration:underline;">Security vulnerabilities</span>

Using third party libraries comes with its own benefits and drawbacks. When using third-party libraries, one extra step for developers is to ensure the security that the library brings. Lighthouse runs this security audit for the third-party libraries used using the package name and its version. These packages can then be checked if there is any vulnerability that has been identified related to those. This is done using the [Snyk’s open source vulnerability database](https://snyk.io/vuln?type=npm).

**63.9%**

_[Figure 2.](https://almanac.httparchive.org/en/2020/javascript#fig-2)<span style="text-decoration:underline;">46 Percentage of mobile pages with libraries having a security vulnerability</span>_

As per the analysis, ~64% of mobile pages use a JS library or framework with some security vulnerability. The number has come down from 83.5% (the previous year) to 64% and that is quite an improvement.

It would be a great idea to now see what libraries were worked upon and have either the security vulnerability removed or the library itself is used less.


<table>
  <tr>
   <td><strong><em>Library</em></strong>
   </td>
   <td>SUM of Vulnerability Percentage
   </td>
  </tr>
  <tr>
   <td>Angular
   </td>
   <td><p style="text-align: right">
0.4</p>

   </td>
  </tr>
  <tr>
   <td>AngularJS
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>Bootstrap
   </td>
   <td><p style="text-align: right">
12.1</p>

   </td>
  </tr>
  <tr>
   <td>Dojo
   </td>
   <td><p style="text-align: right">
0.5</p>

   </td>
  </tr>
  <tr>
   <td>GreenSock JS
   </td>
   <td><p style="text-align: right">
1.8</p>

   </td>
  </tr>
  <tr>
   <td>Handlebars
   </td>
   <td><p style="text-align: right">
1.3</p>

   </td>
  </tr>
  <tr>
   <td>Highcharts
   </td>
   <td><p style="text-align: right">
0.1</p>

   </td>
  </tr>
  <tr>
   <td>jQuery
   </td>
   <td><p style="text-align: right">
57.6</p>

   </td>
  </tr>
  <tr>
   <td>jQuery Mobile
   </td>
   <td><p style="text-align: right">
0.5</p>

   </td>
  </tr>
  <tr>
   <td>jQuery UI
   </td>
   <td><p style="text-align: right">
10.5</p>

   </td>
  </tr>
  <tr>
   <td>Knockout
   </td>
   <td><p style="text-align: right">
0.2</p>

   </td>
  </tr>
  <tr>
   <td>Lo-Dash
   </td>
   <td><p style="text-align: right">
3.1</p>

   </td>
  </tr>
  <tr>
   <td>Moment.js
   </td>
   <td><p style="text-align: right">
2.2</p>

   </td>
  </tr>
  <tr>
   <td>Mustache
   </td>
   <td><p style="text-align: right">
0.7</p>

   </td>
  </tr>
  <tr>
   <td>Underscore
   </td>
   <td><p style="text-align: right">
6.4</p>

   </td>
  </tr>
  <tr>
   <td>Vue
   </td>
   <td><p style="text-align: right">
0.2</p>

   </td>
  </tr>
  <tr>
   <td>Vue (Fast path)
   </td>
   <td><p style="text-align: right">
0.2</p>

   </td>
  </tr>
  <tr>
   <td>React
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
  </tr>
</table>


_<span style="text-decoration:underline;">Figure 2.47 List of security vulnerable libraries with their vulnerability percentage</span>_

The results show that jQuery is the dominant factor in the decrease of vulnerability with at least 23.26% of improvement here and some improvement in jQueryUI too. However, there is little to no difference in other libraries’ security vulnerabilities, except for a few.


### <span style="text-decoration:underline;">Conclusion</span>

The numbers that we have seen throughout the chapter have brought us to an understanding of how vast the Javascript usage is and how it’s evolving over time. The JavaScript ecosystem has been growing with the focus towards making the web the most performant and fastest experience, with newer features and APIs that make the developer experience easy and productive. 

It is observed that so many features provided for improving the rendering time and resource loading time could be leveraged better to see the overall impact making the experience even better in terms of performance.
