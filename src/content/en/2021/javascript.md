---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: JavaScript chapter of the 2021 Web Almanac covering the usage of JavaScript on the web, libraries and frameworks, compression, web components, and source maps.
authors: [NishuGoel]
reviewers: [soulcorrosion, mgechev, rviscomi, pankajparkar, tunetheweb]
analysts: [pankajparkar, max-ostapenko, rviscomi]
editors: [rviscomi, pankajparkar, shantsis]
translators: []
results: https://docs.google.com/spreadsheets/d/1zU9rHpI3nC6jTz3xgN6w13afW7x34xAKBh2IPH-lVxk/
NishuGoel_bio: Nishu Goel is an engineer at <a hreflang="en" href="http://webdataworks.io/">Web DataWorks</a>. She is a Google Developer Expert for Web Technologies and Angular, Microsoft MVP for Developer Technologies, and the author of Step by Step Guide Angular Routing (BPB, 2019) and A Hands-on Guide to Angular (Educative, 2021). Find her writings at <a hreflang="en" href="https://unravelweb.dev/">unravelweb.dev</a>.
featured_quote: Features provided for improving the rendering time and resource loading time could be leveraged better to see the overall impact and get an even better experience with respect to the performance.
featured_stat_1: 4
featured_stat_label_1: Median asynchronous requests made per mobile page.
featured_stat_2: 45.6%
featured_stat_label_2: Images are the most requested content type on pages loaded by JavaScript.
featured_stat_3: 2.7%
featured_stat_label_3: Percent of desktop pages using custom elements.
---

## Introduction

The speed and consistency in which the JavaScript language has evolved with over the past years is tremendous. While in the past it was used primarily for client-side, it has taken a very important and respected place in the world of building services and server-side tools. JavaScript has evolved to a point where it is not only possible to create faster applications but also to <a hreflang="en" href="https://blog.stackblitz.com/posts/introducing-webcontainers/">run servers within browsers</a>.

There is a lot that happens in the browser when rendering the application, from downloading JavaScript to parsing, compiling and executing it. Let's start with that first step and try to understand how much JavaScript is actually requested by pages.

## How much JavaScript do we load?

To measure is the key towards improvement, they say. To improve the usage of JavaScript in our applications, we need to measure how much of the JavaScript being shipped is actually required. Let's dig in to understand the distribution of JavaScript bytes per page, considering what a major role it plays in the web setup.

{# TODO - "To measure is the key towards improvement, they say." - is this a quotation or a reference to something? the phrasing implies it #}

{{ figure_markup(
  image="javascript-bytes-per-page.png",
  caption="Distribution of the amount of JavaScript kilobytes loaded per page.",
  description="Bar chart showing the distribution of JavaScript bytes per page. The median desktop page loads 463 kilobytes of JavaScript. The 10th, 25th, 50th, 75th, and 90th percentiles for desktop are: 94 KB, 220 KB, 463 KB, 852 KB, and 1,354 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=329775434&format=interactive",
  sheets_gid="18398250",
  sql_file="bytes_2021.sql"
  )
}}

The 50th percentile (median) desktop page loads 463 KB of JavaScript, whereas a median page load on a mobile device sends 427 KB.

Compared to [2019's results](../2019/javascript#fig-2), this shows an increase of 18.4% in the usage of JavaScript for desktop devices and an increase of 18.9% on mobile devices. As we see the trend is moving towards using more JavaScript over the years, this could slow down the rendering of an application given the additional CPU work. It's worth noting that these statistics represent the transferred bytes which could be compressed responses and thus, the actual cost to the CPU could be significantly higher.

Let's have a look at how much JavaScript is actually required to be loaded on the page.

{{ figure_markup(
  image="unused-javascript-bytes-per-page.png",
  caption="Distribution of the amount of unused JavaScript bytes on mobile.",
  description="Bar chart showing the distribution of unused JavaScript bytes per page. The median mobile loads 155 KB of JavaScript that is unused. The 10th, 25th, 50th, 75th, and 90th percentiles for mobile are: 20 KB, 64 KB, 155 KB, 329 KB, 598 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=656542402&format=interactive",
  sheets_gid="1704839581",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

The median page loads 155 KB of unused JavaScript and at the 90th percentile, 598 KB of JavaScript are unused.

{{ figure_markup(
  image="unused-vs-total-javascript.png",
  caption="Percent of JavaScript loaded vs. JavaScript unused on mobile page.",
  description="Bar chart showing the difference in the loaded JavaScript and the unused JavaScript from the total loaded. Out of 427 KB of loaded JavaScript on a median mobile page, 155 KB is unused. 36.2% of the total loaded JavaScript goes unused adding to the CPU cost.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=890651092&format=interactive",
  sheets_gid="1521645399",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

This contributes to 36.2% of unused JavaScript on a page.

{{ figure_markup(
  content="36.2%",
  caption="Percent unused from the total loaded JavaScript",
  classes="big-number",
  sheets_gid="1521645399",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

This is such a significant figure to be using the CPU with other important resources and to just go to waste, given the impact it can have on the <a hreflang="en" href="https://web.dev/optimize-lcp/">Largest Contentful Paint</a> (LCP) of the page, especially for the mobile users with limited data plans. This could be a result of a lot of boilerplate code that is shipped when using large frameworks or libraries.

One step towards improving the percentage is to look at the <a hreflang="en" href="https://web.dev/unused-javascript/">percentage of unused JavaScript</a> when checking the lighthouse report for the page and <a hreflang="en" href="https://web.dev/remove-unused-code/">finding opportunities to get rid of the unnecessary JavaScript.</a>

### JavaScript requests per page

One of the contributing factors towards slow rendering of the web page could be the requests made on the page, especially when they are blocking. It's therefore of interest to look at the number of JavaScript requests made per page on both desktop and mobile devices.

{# TODO - blocking something or just blocking? that's a lack of domain knowledge question :) #}

{{ figure_markup(
  image="js-requests-per-page.png",
  caption="Distribution of JavaScript requests on desktop and mobile pages.",
  description="Bar chart showing the distribution of JavaScript requests on desktop and mobile pages. The median mobile page loads 20 JavaScript resources as compared to 21 JavaScript resources on desktop. The 10th, 25th, 50th, 75th, and 90th percentiles for requests made on mobile are: 4, 10, 20, 35, 56",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1487796178&format=interactive",
  sheets_gid="159538568",
  sql_file="requests_2021.sql"
  )
}}

The median desktop page loads 21 JavaScript resources (`.js` and `.mjs` requests), going up to 59 resources at the 90th percentile.

As compared with [last year's results](../2020/javascript#request-count), there has been a marginal increase in the number of JavaScript resources requested in 2021, with the median number of JavaScript resources loaded being 20 for desktop pages and 19 for mobile.

{{ figure_markup(
  image="js-resources-over-years.png",
  caption="Distribution of JavaScript resources loaded over desktop and mobile devices by year.",
  description="Bar chart showing the distribution of JavaScript resources loaded over desktop and mobile devices by year. In 2020, the median JS requests made on a page were 39 and this has increased to 41 in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=882068136&format=interactive",
  sheets_gid="1068898615",
  sql_file="requests_2020.sql"
  )
}}

The trend is gradually increasing in the number of JavaScript resources loaded on a page. This would make one wonder if the number should actually increase or decrease considering that fewer JavaScript requests might lead to better performance in some cases but not in others.

This is where the recent advances in the HTTP protocol come in and the idea of reducing the number of JavaScript requests for better performance gets inaccurate. With the introduction of HTTP/2 and HTTP/3 the overhead of HTTP requests has significantly reduced, so requesting the same resources over more requests is not necessarily a bad thing anymore. To learn more about these protocols, see the [HTTP chapter](./http).

## How is JavaScript requested?

JavaScript can be loaded into a page in a number of different ways, and how it is requested can influence the performance of the page.

### `module` and `nomodule`

When loading a website, the browser renders the HTML and requests the appropriate resources. It consumes the polyfills referenced in the code for the effective rendering and functioning of the page. The modern browsers that support newer syntax like [arrow functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions), [async functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function), etc. do not need loads of polyfills to make things work and therefore, should not have to.

This is when differential loading takes care of things. Specifying the `type="module"` attribute would serve the modern browsers the bundle with modern syntax and fewer polyfills, if any. Similarly, older browsers that lack support for modules will be served the bundle with required polyfills and transpiled code syntax with attribute `type="nomodule"`. Read more about [the usage of module/nomodule here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules#applying_the_module_to_your_html).

Let's look at the data to understand the adoption of these attributes.

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>`module`</th>
        <th>`nomodule`</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">4.6%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">4.3%</td>
        <td class="numeric">3.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribution of differential loading usage on desktop and mobile clients.", sheets_gid="1261294750", sql_file="module_and_nomodule.sql") }}</figcaption>
</figure>

4.6% of desktop pages use the attribute `type="module"` whereas only 3.9% of mobile pages use `type="nomodule"`. This could be due to the fact that the mobile dataset being much larger contains more "long-tail" websites that might not be using the latest features.

It is important to note that with the <a hreflang="en" href="https://docs.microsoft.com/en-us/lifecycle/announcements/internet-explorer-11-support-end-dates">end of support for IE11 browser</a>, differential loading is less applicable because evergreen browsers support modern JavaScript syntax. One of the JavaScript frameworks, Angular, for example, <a hreflang="en" href="https://github.com/angular/angular/issues/41840">removed support for the legacy browsers with Angular v13</a> released November 2021.

### `async` and `defer`

JavaScript loading could be render blocking unless it is specified as deferred or async. This is one of the contributing factors to the slow website loading as often times JavaScript (or at least some of it) is needed for the initial render.

However, loading the JavaScript asynchronously or deferring it helps in some ways to improve this experience. The `async` and `defer` attribute load the scripts asynchronously. The scripts with `async` attribute are executed irrespective of the order in which they are defined, however, `defer` executes the scripts only after the document is completely parsed and ensures their execution will take place in the specified order. We will see the statistics for how many pages actually specify these attributes for the JavaScript requested in the browser.

{# TODO - not sure how to rephrase "We will see the statistics" to say the stats are right below this paragraph #}

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>`async`</th>
        <th>`defer`</th>
        <th>Neither</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">89.3%</td>
        <td class="numeric">48.1%</td>
        <td class="numeric">10.3%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">89.1%</td>
        <td class="numeric">47.8%</td>
        <td class="numeric">10.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percent of pages using `async`, `defer`, or neither.", sheets_gid="2038121216", sql_file="breakdown_of_pages_using_async_defer.sql") }}</figcaption>
</figure>

There was an anti-pattern observed in the last year's results that some websites use both `async` and `defer` attribute resulting in fallback to `async` if the browser supports it and using `defer` for IE8 and IE9 browsers. This is, however, unnecessary now for most of the sites since `async` takes the precedence on all suppoting browsers and this pattern in turn, interrupts the HTML parsing, instead of deferring until the page has loaded. The usage was so frequent that [11.4%](../2020/javascript#how-do-we-load-our-javascript) of mobile pages were seen with at least one script with `async` and `defer` attributes used together. The [root causes](https://twitter.com/rick_viscomi/status/1331735748060524551?s=20) were found and an action item was also taken down to [remove such usage going forward](https://twitter.com/Kraft/status/1336772912414601224?s=20).

This year, we improved our measures of calculating these figures by looking at the rendered DOM, as opposed to the initial HTML.

{{ figure_markup(
  content="35.6%",
  caption="Percent of pages using the `async` and `defer` attribute together.",
  classes="big-number",
  sheets_gid="2038121216",
  sql_file="breakdown_of_pages_using_async_defer.sql"
  )
}}

We found that 35.6% of mobile pages use the `async` and `defer` attributes together. This was counted using a <a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/javascript.js">custom metric</a> that measures the usage of these attributes on the rendered DOM. Based on the custom metric, the variation is a lot as compared to the previous year. When we dived deeper to understand this gap, it was found that a lot of pages update these attributes dynamically after the pages have already been loaded. This is one reason why more results are found using the results from the custom metric (rendered DOM as opposed to initial DOM).

A typical <a hreflang="en" href="https://www.tntsupercenter.com/">example website</a>, loads the below script:

```js
<!-- Piwik -->
<script type="text/javascript">
   (function() {
      var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
      g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
   })();
</script>
<!-- End Piwik Code -->
```

According to [Wikipedia](https://en.wikipedia.org/wiki/Matomo_(software)), Piwik (now known as Matomo):
<blockquote>is a free and open source web analytics application developed by a team of international developers, that runs on a PHP/MySQL webserver. It tracks online visits to one or more websites and displays reports on these visits for analysis. As of June 2018, Matomo was used by over 1,455,000 websites, or 1.3% of all websites with known traffic analysis tools...</blockquote>

This information strongly suggests that a lot of the increase is due to these marketing and analytics providers that dynamically inject these `async`/`defer` scripts into the page.

{{ figure_markup(
  content="2.6%",
  caption="Percent of requests using the `async` and `defer` attribute together.",
  classes="big-number",
  sheets_gid="655357075",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
  )
}}

Even though a large percentage of pages use this anti-pattern, it turns out only 2.6% of requests use both `async` and `defer` on the same script element.

### First-party vs third-party

The median number of JavaScript resources requested on mobile pages, as [observed earlier](#how-much-javascript-do-we-load), is 20. We'll now look at which ones of these are first-party or third-party requests.

{{ figure_markup(
  image="js-requests-mobile-host.png",
  caption="Distribution of the number of JavaScript requests per mobile page by host",
  description="Bar chart showing distribution of JavaScript requests per mobile page by host. A median mobile page makes 9 first-party requests and 10 third-party ones.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=395424439&format=interactive",
  sheets_gid="1354767842",
  sql_file="requests_by_3p.sql"
  )
}}

A median of mobile pages request 10 third-party resources whereas 9 first-party requests. let's look at how the results vary for the desktop client.

{{ figure_markup(
  image="js-requests-desktop-host.png",
  caption="Distribution of the number of JavaScript requests per desktop page by host.",
  description="Bar chart showing distribution of JavaScript requests per desktop page by host. A median mobile page makes 10 first-party requests and 11 third-party ones. The 10th, 25th, 50th, 75th, and 90th percentiles for requests made on desktop for first-party are: 2, 4, 10, 19, 33.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1584404981&format=interactive",
  sheets_gid="1354767842",
  sql_file="requests_by_3p.sql"
  )
}}

A median of desktop pages request 11 third-party resources compared to 10 first-party requests. This difference increases as we move up to the 90th percentile as 33 requests on mobile pages are first-party but the number goes up to 34 for third-party requests for the mobile pages. Clearly, the number of third-party resources requested is always one step ahead of the first-party ones. Irrespective of the performance and reliability <a hreflang="en" href="https://css-tricks.com/potential-dangers-of-third-party-javascript/">risks that requesting third-party resources brings</a>, the usage seems to favor third-party scripts, which could be due to the <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/critical-rendering-path/adding-interactivity-with-javascript">useful interactivity features</a> that it gives to the web.

This is where one has to put their 'performance-nerd' cap on, and ensure that using third-party scripts <a hreflang="en" href="https://csswizardry.com/2017/07/performance-and-resilience-stress-testing-third-parties/">doesn't result in losing control over the performance of the page,  or the main thread getting bloated</a> with too much JavaScript being transferred by <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">loading these scripts better</a>.

{# TODO - 'performance-nerd' the quotes are rendering weirdly in the staged link #}

### Preload and Prefetch

At the render of a page, the browser downloads the given resources and prioritizes the download of some resources the browser uses over others using [resource hints](../resource-hints). The resource hints, `preload` and `prefetch` tell the browser to either download some resource right away or download it whenever it can to present the resource when required.

The `preload` hint tells the browser to download the resource with a higher priority as it will be required on the current page.
The `prefetch` hint however, tells the browser that the resource could be required after some time (useful for future navigation) and it'd better to fetch it when the browser has the capacity to do so and make it available as soon as it is required.

{{ figure_markup(
  image="javascript-resource-hint-usage.png",
  caption="Use of resource hints on JavaScript resources.",
  description="Bar chart showing that 1.1% of desktop pages and 1.0% of mobile pages use the `prefetch` resource hint on one or more JavaScript resources, and 15.8% of desktop resources and 15.4% of mobile pages use `preload` on one or more JavaScript resources.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=686044315&format=interactive",
  sheets_gid="1387829188",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

The preload hints are used by 15.4% of mobile pages to load JavaScript, whereas only 1.0% of mobile pages use the prefetch hint. Overall, 15.8% and 1.1% repectively of desktop pages use these resource hints to load the JavaScript resources.

It would also be ideal to see how many preload and prefetch hints are used per page as that affects the impact of these hints. For example, if there are 5 resources to be loaded on the render and all 5 use the preload hint, the preload hint would try to prioritize all the resources and this would then work as it would have without the preload hint used.

{{ figure_markup(
  image="prefetch-hints-per-page.png",
  caption="Distribution of prefetch hints per page.",
  description="Bar chart showing the distribution of prefetch hints per page. A median desktop page loads 2 JavaScript resources with the prefetch hint.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1265752379&format=interactive",
  sheets_gid="1107832831",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

{{ figure_markup(
  image="preload-hints-per-page.png",
  caption="Distribution of preload hints per page.",
  description="Bar chart showing the distribution of prefetch hints per page. A median desktop page loads 1 JavaScript resource with the preload hint.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1180601651&format=interactive",
  sheets_gid="1107832831",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

A median desktop page loads 1 JavaScript resource with the preload hint whereas 2 JavaScript resources with the prefetch hint.

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Year over year comparison of the usage of preload hints per page at the median.", sheets_gid="1107832831", sql_file="resource-hints-prefetch-preload-percentage.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Year over year comparison of the usage of prefetch hints per page at the median.", sheets_gid="1107832831", sql_file="resource-hints-prefetch-preload-percentage.sql") }}</figcaption>
</figure>

Looking at the trend of the usage of preload and prefetch hints over the past years, it can be noted that the trend favors a decrease in the usage of more preload and prefetch hints per page.

## How is JavaScript delivered

When sending resources over the network, it becomes important to look at an efficient way of doing it, and compressing these resources using different techniques either statically or dynamically boosts the performance and makes the process faster.

### Compression

Most of the compressed resources use either gzip compression, brotli (br) compression, or a compression technique that is not set.

{# TODO - should we have links for gzip and brotli? i think other chapters do #}

{{ figure_markup(
  image="compression-requests.png",
  caption="Compression methods usage percentage by request.",
  description="Bar chart showing the percent of the usage of compression methods. 55% of JavaScript requests apply the gzip compression on mobile, 31% apply br compression, and 14% do not apply any compression method.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1306457429&format=interactive",
  sheets_gid="1182320606",
  sql_file="compression_method.sql"
  )
}}

It is noted that 55.4% of mobile JavaScript requests apply the gzip compression method, whereas 30.8% of requests from mobile devices have the brotli compression applied.

An interesting observation here is the trend of the usage of these compression methods [compared to the previous year](../2019/javascript#fig-10). The usage of gzip has gone down by almost 10% and brotli has increased by 11%. The trend definitely indicates the focus on smaller size files with more levels of compression that Brotli provides as compared to gzip.

With such comparable data, we checked if the percentage difference is somehow impacted by the resources being first-party or third-party.

{{ figure_markup(
  image="compression-first-third-party.png",
  caption="Compression methods for first party vs third party.",
  description="Bar chart showing the percent of the usage of compression methods for first-party and third-party. 59% of third-party JS requests apply the gzip compression on mobile, 30% third-party requests apply br compression, and 11% third-party scripts do not apply any compression method.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1269923134&format=interactive",
  sheets_gid="821396474",
  sql_file="compression_method_by_3p.sql"
  )
}}

59.1% of third-party scripts are gzipped and 29.6% are brotli compressed. Looking at first-party scripts, these are 51.7% with gzip compression but only 32.0% with brotli. There are still 11% of third-party scripts that do not have any compression method defined for the resources.

{{ figure_markup(
  image="uncompressed-first-third-party.png",
  caption="Uncompressed resources for first party vs third party.",
  description="Bar chart showing the percent of the uncompressed resources for first party vs third party. 90% of uncompressed third party JavaScript resources are < 5 KB, and uncompressed first-party resources less than 10kb are only 8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1043138204&format=interactive",
  sheets_gid="1942216454",
  sql_file="compression_none_by_bytes.sql"
  )
}}

The way preloading all our requests negates the impact of the resource hint, a similar problem occurs when we try to optimize and compress a resource that doesn't need compression and is already small. It is observed that 90% of uncompressed third party JavaScript resources are less than 5 KB, though first-party requests trail a bit.

### Minification

When working towards reducing the script parsing time, we tend to focus on all the opportunities to make our code smaller and more efficient. One such idea is to minify the files and bring down the bytes usage.

The Lighthouse report also <a hreflang="en" href="https://web.dev/unminified-javascript/">highlights the unminified JavaScript being used</a> and lists these unminified files and the opportunities to save.

{{ figure_markup(
  image="unminified-js-audit-scores.png",
  caption="Percentage distribution of unminified JS audit scores.",
  description='Bar chart showing the percentage distribution of unminified JS audit scores. 67% of mobile pages have an "unminified JavaScript" score between 0.9 and 1.0',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1572896641&format=interactive",
  sheets_gid="1539653841",
  sql_file="lighthouse_unminified_js.sql"
  )
}}

Here, 0.00 represents the worst score whereas 1.00 represents the best score. It is noted that 67.1% of mobile pages have an audit score between 0.9 and 1.0, meaning that there are still more than 30% of mobile pages with a unminified JavaScript score of less than 0.9 with less or no minification.
This, as compared to the results from the last year(2020), shows a regression of 10% in mobile pages with "unminified JS" score between 0.9 and 1.0. 

To understand the reason for the less score this year, let's dive deeper to look at how many bytes per page are unminified.

{{ figure_markup(
  image="unminified-js-bytes.png",
  caption="Percentage distribution of unminified JS bytes per page.",
  description="Bar chart showing the percentage distribution of unminified JS bytes per page. 57% of mobile pages have 0 KB of unminified JS whereas 18% of those have 0-10 kilobytes of unminified JS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1069289665&format=interactive",
  sheets_gid="1511556407",
  sql_file="lighthouse_unminified_js_bytes.sql"
  )
}}

It is found that 57.4% of mobile pages have 0 KB of unminified JavaScript. This indicates that more than 50% of mobile pages have 100% minification with 0 KBs of unminified JavaScript found. On the other hand, less than 20% of mobile pages have 0-10 KB of unminified JavaScript with scope for better minification score. The rest have less to no minification and these are the pages that fall in category of bad "unminified JavaScript" audit score that we saw in the previous chart.

The first-party vs. third-party analysis in this case shows that 82% of the average mobile pages' unminified JavaScript bytes actually come from first-party scripts. This indicates that the third-party scripts are definitely doing better than the first-party ones in the case of minification.

{{ figure_markup(
  image="average-unminified-js-bytes.png",
  caption="Average distribution of unminified JavaScript Bytes.",
  description="Pie chart showing the average distribution of unminified JavaScript bytes. 82% of the average mobile page's unminified JavaScript bytes actually come from first-party scripts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1119550643&format=interactive",
  sheets_gid="127709080",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

### Source maps

Source maps are files sent along with the JavaScript resource files to let the browser map the minified or compressed file to their original version of that file. This is how source maps help us in debugging in the production environment.

{{ figure_markup(
  content="0.1%",
  caption="Mobile pages using the sourcemap header.",
  classes="big-number",
  sheets_gid="1186092564",
  sql_file="sourcemap_header.sql"
  )
}}

It is found that only 0.1% of mobile pages use the SourceMap response header on script resources. One reason for this extremely small percentage could be that not many sites choose to put their original source code in production through the source map.

An analysis of how many sites actually send the source map header on their first-party or third-party scripts shows that 0.1% of the JavaScript requests that include a SourceMap header on mobile are for first-party scripts.

{# TODO That seems surprising to me. I would have though it was more common to be from third-parties since the likes of query and Bootstrap include source map files. Any thoughts on why this is the reverse? Or am I just wrong about this expectation? Nishu - These results are confusing to me. I reran the query and didn't find 98% anywhere, so I have removed the figure but simply put 0.1% as first-party results for mobile. If you'd like to have a look - here's the data - https://docs.google.com/spreadsheets/d/1zU9rHpI3nC6jTz3xgN6w13afW7x34xAKBh2IPH-lVxk/edit#gid=2057978707 #}

## Libraries and frameworks

Over the past years, the usage of JavaScript has increased tremendously with the adoption of many libraries and frameworks. In an effort to fasten and ease building the web, many frameworks have been introduced with each bringing features that make the app more performant. This was so prevalent that the term _framework fatigue_ came into existence.

### Libraries usage

To understand the usage of libraries and frameworks, HTTP Archive uses [Wappalyzer](./methodology#wappalyzer), which detects many technologies used by the web pages.

{{ figure_markup(
  image="js-libs-frameworks.png",
  caption="Usage of Javascript libraries and frameworks.",
  description="Bar chart showing the usage of Javascript libraries and frameworks. jQuery remains on top with 84% of mobile pages using it.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=584103777&format=interactive",
  sheets_gid="1851485826",
  sql_file="frameworks_libraries.sql"
  )
}}

jQuery remains on top with 84% of mobile pages containing jQuery, however React usage has jumped from 4% to 8% since last year, which is a significant increase. Also worth noticing is the usage of Isotope (uses jQuery) to 7% leading to RequireJS falling out of the picture with 2% usage.

One might wonder why jQuery is so dominant and hasn't disappeared over time. There are two main reasons for this. First, as [highlighted over the previous years](../2019/javascript#open-source-libraries-and-frameworks), is that most of the <a hreflang="en" href="https://wordpress.org/">WordPress</a> sites use jQuery, which contributes to a major participation of jQuery. Second, even if the wide usage of jQuery is ignored for a moment, several of the other top-used JavaScript libraries still rely on jQuery in some way under the hood.

### Libraries used together

The adoption of JavaScript frameworks doesn't see a substantial change compared to the previous years. With the way the adoption is measured, there is a <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">detection limitation</a> which doesn't let Wappalyzer capture the percentage precisely. Additionally, the detection is only run on home pages which doesn't capture accurately the overall framework adoption.

It would instead be interesting to look at how the popular frameworks and libraries approach the usage of other libraries. This means how many frameworks or libraries actually rely on other libraries in production.

<figure>
  <table>
    <thead>
      <tr>
        <th>Frameworks/Libraries</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">16.8%</td>
        <td class="numeric">17.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">8.4%</td>
        <td class="numeric">8.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">4.0%</td>
        <td class="numeric">3.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">2.6%</td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>Slick, jQuery</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>React, jQuery, jQuery Migrate</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Javascript frameworks usage with JavaScript libraries.", sheets_gid="1934429143", sql_file="frameworks_libraries_combos.sql") }}</figcaption>
</figure>

jQuery tops in usage with libraries and frameworks, which could also be a result of using a third-party library that includes it. This, as a result, leads to more processing time for the code that the framework or library uses with the other included libraries.

22% of known versions of jQuery are found to be version 3.5.1. This is a big jump compared to last year's (1.12.4), which could be attributed to Wordpress which constitutes most of the participation of jQuery.

### Security vulnerabilities

Using third-party libraries comes with its own benefits and drawbacks. When using third-party libraries, one extra step for developers is to ensure the security that the library brings. Lighthouse runs this security audit for the third-party libraries used using the package name and its version. These packages can then be checked if there is any vulnerability that has been identified related to those. This is done using the <a hreflang="en" href="https://snyk.io/vuln?type=npm">Snyk's open source vulnerability database</a>.

{{ figure_markup(
  content="63.9%",
  caption="Percentage of mobile pages with libraries having a security vulnerability.",
  classes="big-number",
  sheets_gid="793786066",
  sql_file="lighthouse_vulnerabilities.sql"
  )
}}

As per the analysis, 63.9% of mobile pages use a JS library or framework with some security vulnerability. The number has come down from 83.5% (the previous year) and that is quite an improvement.

We decided to look at what libraries were worked upon and have either the security vulnerability removed, or the library itself is used less.

<figure>
  <table>
    <thead>
      <tr>
        <th>Library</th>
        <th>Percentage</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Angular</td>
        <td class="numeric">0.4%</td>
     </tr>
        <tr>
        <td>AngularJS</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">12.1%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>GreenSock JS</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Highcharts</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>jQuery</td>
        <td class="numeric">57.6%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.5%</td>
        </tr>
        <tr>
        <td>jQuery UI</td>
        <td class="numeric">10.5%</td>
      </tr>
      <tr>
        <td>Knockout</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Lo-Dash</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>Underscore</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>Vue</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Vue (Fast path)</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="List of security vulnerable libraries with their vulnerability percentage.", sheets_gid="551476210", sql_file="lighthouse_vulnerable_libraries.sql") }}</figcaption>
</figure>

The results show that jQuery is the dominant factor in the decrease of vulnerability with at least 23.3% of improvement here and some improvement in jQueryUI too. However, there is little to no difference in other libraries' security vulnerabilities.

## How do we use JavaScript?

Now that we've looked at how we get the JavaScript, what are we using it for?

### AJAX

A lot of JavaScript that is written is used to communicate with servers through asynchronous requests to receive information in various formats. AJAX, or asynchronous JavaScript and XML, is typically used to send and receive data in JSON, XML, HTML, text formats.

{# TODO - "AJAX, or asynchronous JavaScript and XML," is this a list of 3 or grouped together? #}

With multiple ways to send and receive data on the web, let's look into how many async requests are sent per page.

{{ figure_markup(
  image="async-requests-per-page.png",
  caption="The number of asynchronous requests made per page.",
  description="Bar chart showing the number of asynchronous requests made per page. On a desktop page, the 10th, 25th, 50th, 75th, and 90th percentiles for asynchronous requests made are: 2, 3, 4, 8, 15.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=709009883&format=interactive",
  sheets_gid="183546956",
  sql_file="ajax_request_per_page.sql"
  )
}}

A median of 4 asynchronous requests are made per page on both mobile and desktop devices. This applies to the 50th percentile, i.e., the median desktop and mobile pages.

If we look at the long tail and check the number of async requests for the 100th percentile, the difference in the devices is quite remarkable. The most asynchronous requests made by a desktop page is 623, which is eclipsed by the biggest mobile page, which makes 867 asynchronous requests!

An alternative to the asynchronous AJAX requests are that they are synchronous. Rather than passing a request to a callback, they block the main thread until the request completes.

However, [this practice is discouraged](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests#synchronous_request) due to the potential for poor performance and user experiences, and many browsers already warn about the usage. It would be intriguing to see how many pages still use synchronous AJAX requests.

{{ figure_markup(
  image="usage-sync-async.png",
  caption="Usage of synchronous and asynchronous AJAX requests on mobile pages",
  description="Bar chart showing the usage of synchronous and asynchronous AJAX requests on mobile pages. The percent of synchronous requests made on mobile page are 2.5% and that of asynchronous requests are 77.6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=189627938&format=interactive",
  sheets_gid="1113974683",
  sql_file="ajax_async.sql"
  )
}}

As we see, there are still more than 2.5% of desktop and mobile pages that use the deprecated synchronous AJAX requests.
Let's look at the trend by comparing the results with the last two years.

{{ figure_markup(
  image="usage-sync-async-over-years.png",
  caption="Usage of synchronous and asynchronous AJAX requests over years.",
  description="Bar chart showing the usage of synchronous and asynchronous AJAX requests over the past years. In 2019, the percentage of asynchronous requests made on mobile was 54.9% increasing to 61.8% in 2020, 77.6% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=126336838&format=interactive",
  sheets_gid="1113974683",
  sql_file="ajax_async.sql"
  )
}}

We see there is a clear increase in the usage of asynchronous AJAX requests. However, no significant decline in the usage of synchronous AJAX requests can be seen over the years.

An AJAX request works with different formats of data that can be sent and received. When a resource is requested, there is significant information that is sent to the server to make the results specific and clear. One such requirement is sending the relevant content types. The request sent from the browser requests a content type that gets back the data in the requested format.

Out of the vast list of content types that can be requested, we looked at the most commonly requested content types.

<figure>
  <table>
    <thead>
      <tr>
        <th>Category</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Images</td>
        <td class="numeric">45.6%</td>
        <td class="numeric">44.6%</td>
      </tr>
      <tr>
        <td>JavaScript</td>
        <td class="numeric">32.3%</td>
        <td class="numeric">33.3%</td>
      </tr>
      <tr>
        <td>CSS</td>
        <td class="numeric">12.6%</td>
        <td class="numeric">13.2%</td>
      </tr>
      <tr>
        <td>Fonts</td>
        <td class="numeric">5.7%</td>
        <td class="numeric">5.0%</td>
      </tr>
      <tr>
        <td>JSON</td>
        <td class="numeric">3.8%</td>
        <td class="numeric">3.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The most requested content types in AJAX.", sheets_gid="538991873", sql_file="most_requested_content_type.sql") }}</figcaption>
</figure>

The most requested content types on mobile and desktop pages are images at 45% of requests. Images are a broad category inclusive of all the content types related to images, for example, `image/x-icon`, `image/svg+xml`, `image/webp`, `image/jpeg`, etc.

JavaScript is the second most requested content type in AJAX requests, with 33.3% of requests on mobile pages having this content type. This represents content-types like `application/javascript`, `text/javascript`, etc.

Knowing the number of AJAX requests per page now, we'd also be interested in knowing the most commonly used APIs to request the data from the server.

We can broadly classify these AJAX requests into three different APIs and dig in to see the usage of each of these. The core APIs [`XMLHttpRequest`](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest) (XHR), [`Fetch`](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch), and [`Beacon`](https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API) are used commonly across websites with XHR being used primarily, however `Fetch` is gaining popularity and growing rapidly while `Beacon` has minimum usage.

{{ figure_markup(
  image="ajax_xhr.png",
  caption="Usage of XMLHttpRequest",
  description="Bar chart showing the usage of XMLHttpRequest per page on both desktop and mobile pages. The median mobile page makes 2 XHR requests, but at 90th percentile, makes 6 XHR requests. The 10th, 25th, 50th, 75th, and 90th percentiles for usage of XMLHttpRequest on desktop are: 0, 1, 2, 3, 6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1164635195&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

The median mobile page makes 2 XHR requests, but at 90th percentile, makes 6 XHR requests.

{{ figure_markup(
  image="ajax_fetch.png",
  caption="Usage of Fetch",
  description="Bar chart showing the usage of Fetch per page on both desktop and mobile pages. The median mobile page makes 2 Fetch requests, but at 90th percentile, makes 3 Fetch requests. The 10th, 25th, 50th, 75th, and 90th percentiles for usage of Fetch on mobile are: 0, 2, 2, 2, 3.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=147712640&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

In the case of the usage of the Fetch API, a median mobile page makes 2 requests per page and in the long tail, reaches 3 requests. This is reaching towards the standard XHR way of making requests and in turn, with a much cleaner approach and less boilerplate code, the overall load time will improve too.

{{ figure_markup(
  image="ajax_beacon.png",
  caption="Usage of Beacon",
  description="Bar chart showing the usage of Beacon per page on both desktop and mobile pages. The median mobile page makes no Beacon requests, but at 90th percentile, makes 1 Beacon request.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1483701430&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}
One major reason for the lower usage of `Beacon` could be that it is typically used for sending analytics data, especially where one wants to ensure that the request is sent even if the page might unload soon. This is, however, not guaranteed when using XHR. A good experiment for the future would be to see if some statistics could be collected around any pages using XHR for analytics data, session data, etc.

It would be interesting to also compare the adoption of XHR and `Fetch` over time.

{{ figure_markup(
  image="ajax-apis-per-year.png",
  caption="Adoption of AJAX APIs by year.",
  description="Bar chart showing the adoption of XHR and Fetch requests per page on mobile pages. The percent usage of XHR has increased from 58% in 2019 to 62% in 2020 to 78% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1254898632&format=interactive",
  sheets_gid="417043080",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

For both `Fetch` and XHR, the usage has tremendously increased over the years. `Fetch` has seen an increase of 38% on desktop pages and 48% for XHR. With a gradual increase for `Fetch`, the focus seems to be towards cleaner requests and handling responses better.

### Web Components and the shadow DOM

With the web becoming componentized, a developer building a single page application may think about a user view as a set of components. This is not only for the sake of developers building dedicated components for each feature, but also to maximize component reusability. It could be in the same app on a different view or in a completely different application. Such use cases lead to the usage of custom elements and web components in web applications.

It would be justified to say that with many JavaScript frameworks gaining popularity, the idea of reusability and building dedicated feature-based components has been adopted more widely. This feeds our curiosity to look into the adoption of custom elements, shadow DOM, template elements.

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/customelements">Custom Elements</a> are customized elements built on top of the [`HTMLElement`](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement) class. The browser provides a `customElements` API that allows developers to define an element and register it with the browser as a custom element.

It is noted that 2.7% of desktop pages use custom elements for one or more parts of the web page.

{{ figure_markup(
  content="2.7%",
  caption="Percent of desktop pages using custom elements.",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_specs.sql"
  )
}}

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/shadowdom">_Shadow DOM_</a> allows you to create a dedicated subtree in the DOM for the custom element introduced to the browser. It ensures the styles and nodes inside the element are not accessible outside the element.

0.4% of pages use shadow DOM specification of web components to ensure a scoped subtree for the element.

{{ figure_markup(
  content="0.4%",
  caption="Percent of pages using Shadow DOM.",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_specs.sql"
  )
}}

A [`<template>`](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots#the_truth_about_templates) element is very useful when there is a pattern in the markup which could be reused. The contents of _template_ elements render only when referenced by JavaScript.

Templates work well when dealing with web components, as the content that is not yet referenced by JavaScript is then appended to a shadow root using the shadow DOM.

{{ figure_markup(
  content="<0.1%",
  caption="Percent of pages using templates.",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_specs.sql"
  )
}}

Less than 0.1% of web pages have adopted the use of templates. Although templates are well <a hreflang="en" href="https://caniuse.com/template">supported</a> in browsers, there is still a very low percentage of pages using them.

## Conclusion

The numbers that we have seen throughout the chapter have brought us to an understanding of how vast the Javascript usage is and how it's evolving over time. The JavaScript ecosystem has been growing with the focus towards making the web the most performant and fastest experience, with newer features and APIs that make the developer experience easy and productive.

It is observed that so many features provided for improving the rendering time and resource loading time could be leveraged better to see the overall impact and get an even better experience with respect to the performance.

Starting from adopting the features provided by the JavaScript and web community, making sure to use them wisely and ensuring that a tweak only improves the performance and doesn't instead increase the overload (for example, lazy loading all resources on a page is definitely not a good idea), is what it will take us to see these numbers even better in the coming years.

{# TODO - this sentence is long but not sure how to break it down #}

Let's continue to do so.
