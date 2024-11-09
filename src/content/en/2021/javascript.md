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

The speed and consistency at which the JavaScript language has evolved over the past years is tremendous. While in the past it was used primarily on the client side, it has taken a very important and respected place in the world of building services and server-side tools. JavaScript has evolved to a point where it is not only possible to create faster applications but also to <a hreflang="en" href="https://blog.stackblitz.com/posts/introducing-webcontainers/">run servers within browsers</a>.

There is a lot that happens in the browser when rendering the application, from downloading JavaScript to parsing, compiling, and executing it. Let's start with that first step and try to understand how much JavaScript is actually requested by pages.

## How much JavaScript do we load?

They say, "to measure is the key towards improvement". To improve the usage of JavaScript in our applications, we need to measure how much of the JavaScript being shipped is actually required. Let's dig in to understand the distribution of JavaScript bytes per page, considering what a major role it plays in the web setup.

{{ figure_markup(
  image="javascript-bytes-per-page.png",
  caption="Distribution of the amount of JavaScript loaded per page.",
  description="Bar chart showing the distribution of JavaScript bytes per page. The median desktop page loads 463 kilobytes of JavaScript. The 10th, 25th, 50th, 75th, and 90th percentiles for desktop are: 94 KB, 220 KB, 463 KB, 852 KB, and 1,354 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=329775434&format=interactive",
  sheets_gid="18398250",
  sql_file="bytes_2021.sql"
  )
}}

The 50th percentile (median) mobile page loads 427 KB of JavaScript, whereas the median page loaded on a desktop device sends 463 KB.

Compared to [2019's results](../2019/javascript#fig-2), this shows an increase of 18.4% in the usage of JavaScript for desktop devices and an increase of 18.9% on mobile devices. The trend over time is moving towards using more JavaScript, which could slow down the rendering of an application given the additional CPU work. It's worth noting that these statistics represent the transferred bytes which could be compressed responses and thus, the actual cost to the CPU could be significantly higher.

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

According to [Lighthouse](./methodology#lighthouse), the median mobile page loads 155 KB of unused JavaScript. And at the 90th percentile, 598 KB of JavaScript are unused.

{{ figure_markup(
  image="unused-vs-total-javascript.png",
  caption="Distribution of unused and total JavaScript bytes on mobile pages.",
  description="Bar chart showing the difference in the loaded JavaScript and the unused JavaScript from the total loaded. Out of 427 KB of loaded JavaScript on a median mobile page, 155 KB is unused. 36.2% of the total loaded JavaScript goes unused adding to the CPU cost.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=890651092&format=interactive",
  sheets_gid="1521645399",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

{{ figure_markup(
  content="36.2%",
  caption="Percent unused from the total loaded JavaScript.",
  classes="big-number",
  sheets_gid="1521645399",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

To put it another way, 36.2% of JavaScript bytes on the median mobile page go unused. Given the impact JavaScript can have on the <a hreflang="en" href="https://web.dev/articles/optimize-lcp">Largest Contentful Paint</a> (LCP) of the page, especially for mobile users with limited device capabilities and data plans, this is such a significant figure to be consuming CPU cycles with other important resources just to go to waste. Such wastefulness could be the result of a lot of unused boilerplate code that gets shipped with large frameworks or libraries.

Site owners could reduce the percentage of wasted JavaScript bytes by using Lighthouse to check for <a hreflang="en" href="https://web.dev/unused-javascript/">unused JavaScript</a> and follow best practices to <a hreflang="en" href="https://web.dev/remove-unused-code/">remove unused code</a>.

### JavaScript requests per page

One of the contributing factors towards slow rendering of the web page could be the requests made on the page, especially when they are blocking requests. It's therefore of interest to look at the number of JavaScript requests made per page on both desktop and mobile devices.

{{ figure_markup(
  image="js-requests-per-page.png",
  caption="Distribution of the number of JavaScript requests per page.",
  description="Bar chart showing the distribution of JavaScript requests on desktop and mobile pages. The median mobile page loads 20 JavaScript resources as compared to 21 JavaScript resources on desktop. The 10th, 25th, 50th, 75th, and 90th percentiles for requests made on mobile are: 4, 10, 20, 35, 56",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1487796178&format=interactive",
  sheets_gid="159538568",
  sql_file="requests_2021.sql"
  )
}}

The median desktop page loads 21 JavaScript resources (`.js` and `.mjs` requests), going up to 59 resources at the 90th percentile.

{{ figure_markup(
  image="js-resources-over-years.png",
  caption="Distribution of the number of JavaScript requests per page by year.",
  description="Bar chart showing the distribution of JavaScript resources loaded over desktop and mobile devices by year. In 2020, the median JS requests made on a page were 19 and this has increased to 20 in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=882068136&format=interactive",
  sheets_gid="1068898615",
  sql_file="requests_2020.sql"
  )
}}

As compared with [last year's results](../2020/javascript#request-count), there has been a marginal increase in the number of JavaScript resources requested in 2021, with the median number of JavaScript resources loaded being 20 for desktop pages and 19 for mobile.

The trend is gradually increasing in the number of JavaScript resources loaded on a page. This would make one wonder if the number should actually increase or decrease considering that fewer JavaScript requests might lead to better performance in some cases but not in others.

This is where the recent advances in the HTTP protocol come in and the idea of reducing the number of JavaScript requests for better performance gets inaccurate. With the introduction of HTTP/2 and HTTP/3, the overhead of HTTP requests has been significantly reduced, so requesting the same resources over more requests is not necessarily a bad thing anymore. To learn more about these protocols, see the [HTTP chapter](./http).

## How is JavaScript requested?

JavaScript can be loaded into a page in a number of different ways, and how it is requested can influence the performance of the page.

### `module` and `nomodule`

When loading a website, the browser renders the HTML and requests the appropriate resources. It consumes the polyfills referenced in the code for the effective rendering and functioning of the page. Modern browsers that support newer syntax like [arrow functions](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Functions/Arrow_functions) and [async functions](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/async_function) do not need loads of polyfills to make things work and therefore, should not have to.

This is when differential loading takes care of things. Specifying the `type="module"` attribute would serve the modern browsers the bundle with modern syntax and fewer polyfills, if any. Similarly, older browsers that lack support for modules will be served the bundle with required polyfills and transpiled code syntax with the `type="nomodule"` attribute. Read more about [the usage of module/nomodule](https://developer.mozilla.org/docs/Web/JavaScript/Guide/Modules#applying_the_module_to_your_html).

Let's look at the data to understand the adoption of these attributes.

<figure>
  <table>
    <thead>
      <tr>
        <th>Attribute</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`module`</td>
        <td class="numeric">4.6%</td>
        <td class="numeric">4.3%</td>
      </tr>
      <tr>
        <td>`nomodule`</td>
        <td class="numeric">3.9%</td>
        <td class="numeric">3.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Distribution of differential loading usage on desktop and mobile clients.",
    sheets_gid="1261294750",
    sql_file="module_and_nomodule.sql"
  ) }}</figcaption>
</figure>

4.6% of desktop pages use the `type="module"` attribute, whereas only 3.9% of mobile pages use `type="nomodule"`. This could be due to the fact that the mobile dataset being [much larger](./methodology#websites) contains more "long-tail" websites that might not be using the latest features.

It is important to note that with the <a hreflang="en" href="https://docs.microsoft.com/en-us/lifecycle/announcements/internet-explorer-11-support-end-dates">end of support for IE 11 browser</a>, differential loading is less applicable because evergreen browsers support modern JavaScript syntax. The Angular framework, for example, <a hreflang="en" href="https://github.com/angular/angular/issues/41840">removed support for legacy browsers in Angular v13</a>, which was released November 2021.

### `async` and `defer`

JavaScript loading could be render-blocking unless it is specified as asynchronous or deferred. This is one of the contributing factors to slow performance, as oftentimes JavaScript (or at least some of it) is needed for the initial render.

However, loading the JavaScript asynchronously or deferred helps in some ways to improve this experience. Both the `async` and `defer` attributes load the scripts asynchronously. The scripts with the `async` attribute are executed irrespective of the order in which they are defined, however, `defer` executes the scripts only after the document is completely parsed, ensuring that their execution will take place in the specified order. Let's look at how many pages actually specify these attributes for the JavaScript requested in the browser.

<figure>
  <table>
    <thead>
      <tr>
        <th>Attribute</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`async`</td>
        <td class="numeric">89.3%</td>
        <td class="numeric">89.1%</td>
      </tr>
      <tr>
        <td>`defer`</td>
        <td class="numeric">48.1%</td>
        <td class="numeric">47.8%</td>
      </tr>
      <tr>
        <td>Both</td>
        <td class="numeric">35.7%</td>
        <td class="numeric">35.6%</td>
      </tr>
      <tr>
        <td>Neither</td>
        <td class="numeric">10.3%</td>
        <td class="numeric">10.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Percent of pages using `async` and `defer`.",
    sheets_gid="2038121216",
    sql_file="breakdown_of_pages_using_async_defer.sql"
  ) }}</figcaption>
</figure>

There was an anti-pattern observed in last year's results that some websites use both `async` and `defer` attributes on the same script, which falls back to `async` if the browser supports it and using `defer` for IE 8 and IE 9 browsers. This is, however, unnecessary now for most of the sites since `async` takes precedence on all supported browsers and. In turn, this pattern interrupts HTML parsing instead of deferring until the page has loaded. The usage was so frequent that [11.4%](../2020/javascript#how-do-we-load-our-javascript) of mobile pages were seen with at least one script with `async` and `defer` attributes used together. The [root causes](https://x.com/rick_viscomi/status/1331735748060524551?s=20) were found and an action item was also taken down to [remove such usage going forward](https://x.com/Kraft/status/1336772912414601224?s=20).

{{ figure_markup(
  content="35.6%",
  caption="Percent of mobile pages on which the `async` and `defer` attributes are set on the same script.",
  classes="big-number",
  sheets_gid="2038121216",
  sql_file="breakdown_of_pages_using_async_defer.sql"
  )
}}

This year, we found that 35.6% of mobile pages use the `async` and `defer` attributes together. The large discrepancy from last year is due to a methodological improvement to measure attribute usage at runtime, rather than parsing the static contents of the initial HTML. This difference shows that many pages update these attributes dynamically after the document has already been loaded. For example, one website was found to include the following script:

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

So, what is Piwik? According to its Wikipedia entry:

<figure>
<blockquote>Matomo, formerly Piwik, is a free and open source web analytics application developed by a team of international developers, that runs on a PHP/MySQL web server. It tracks online visits to one or more websites and displays reports on these visits for analysis. As of June 2018, Matomo was used by over 1,455,000 websites, or 1.3% of all websites with known traffic analysis tools&hellip;</blockquote>
<figcaption>— <cite><a href="https://en.wikipedia.org/wiki/Matomo_(software)">Matomo (software) on Wikipedia</a></cite></figcaption>
</figure>

This information strongly suggests that much of the increase we observed may be due to similar marketing and analytics providers that dynamically inject these `async` and `defer` scripts into the page later than had been previously detected.

{{ figure_markup(
  content="2.6%",
  caption="Percent of scripts using the `async` and `defer` attribute together.",
  classes="big-number",
  sheets_gid="655357075",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
  )
}}

Even though a large percentage of pages use this anti-pattern, it turns out that only 2.6% of all scripts use both `async` and `defer` on the same script element.

### First-party vs third-party

Recall from the [How much JavaScript do we load](#how-much-javascript-do-we-load) section that the median number of JavaScript requests on mobile pages is 20. In this section, we'll take a look at the breakdown of first and third-party JavaScript requests.

{{ figure_markup(
  image="js-requests-mobile-host.png",
  caption="Distribution of the number of JavaScript requests per mobile page by host.",
  description="Bar chart showing distribution of JavaScript requests per mobile page by host. A median mobile page makes 9 first-party requests and 10 third-party ones.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=395424439&format=interactive",
  sheets_gid="1354767842",
  sql_file="requests_by_3p.sql"
  )
}}

The median mobile page requests 10 third-party resources and 9 first-party requests. This difference increases as we move up to the 90th percentile as 33 requests on mobile pages are first-party but the number goes up to 34 for third-party requests for the mobile pages. Clearly, the number of third-party resources requested is always one step ahead of the first-party ones.

{{ figure_markup(
  image="js-requests-desktop-host.png",
  caption="Distribution of the number of JavaScript requests per desktop page by host.",
  description="Bar chart showing distribution of JavaScript requests per desktop page by host. A median mobile page makes 10 first-party requests and 11 third-party ones. The 10th, 25th, 50th, 75th, and 90th percentiles for requests made on desktop for first-party are: 2, 4, 10, 19, 33.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1584404981&format=interactive",
  sheets_gid="1354767842",
  sql_file="requests_by_3p.sql"
  )
}}

The median desktop page requests 11 third-party resources, compared to 10 first-party requests. Irrespective of the <a hreflang="en" href="https://css-tricks.com/potential-dangers-of-third-party-javascript/">performance and reliability risks</a> that third-party resources may bring, both desktop and mobile pages consistently seem to favor third-party scripts. This effect could be due to the <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/critical-rendering-path/adding-interactivity-with-javascript">useful interactivity features</a> that third-party scripts give to the web.

Nevertheless, site owners must ensure that their third-party scripts are <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">loaded performantly</a>. <a href="https://x.com/csswizardry">Harry Roberts</a> advocates for going a step further and <a hreflang="en" href="https://csswizardry.com/2017/07/performance-and-resilience-stress-testing-third-parties/">stress testing third-parties</a> for performance and resilience.

### `preload` and `prefetch`

As a page is rendered, the browser downloads the given resources and prioritizes the download of some resources the browser uses over others using resource hints. The `preload` hint tells the browser to download the resource with a higher priority as it will be required on the current page. The `prefetch` hint, however, tells the browser that the resource could be required after some time (useful for future navigation) and it'd better to fetch it when the browser has the capacity to do so and make it available as soon as it is required. Learn more about how these features are used in the [Resource Hints](./resource-hints) chapter.

{{ figure_markup(
  image="javascript-resource-hint-usage.png",
  caption="Use of resource hints on JavaScript resources.",
  description="Bar chart showing that 1.1% of desktop pages and 1.0% of mobile pages use the `prefetch` resource hint on one or more JavaScript resources, and 15.8% of desktop resources and 15.4% of mobile pages use `preload` on one or more JavaScript resources.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=686044315&format=interactive",
  sheets_gid="1387829188",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

`preload` hints are used to load JavaScript on 15.4% of mobile pages, whereas only 1.0% of mobile pages use the `prefetch` hint. 15.8% and 1.1% of desktop pages use these resource hints to load JavaScript resources, respectively.

It would also be useful to see how many `preload` and `prefetch` hints are used per page, as that affects the impact of these hints. For example, if there are five resources to be loaded on the render and all five use the `preload` hint, the browser would try to prioritize every resource, which would effectively work as if no `preload` hint was used at all.

{{ figure_markup(
  image="preload-hints-per-page.png",
  caption="Distribution of preload hints for JavaScript resources per page.",
  description="Bar chart showing the distribution of prefetch hints per page. A median desktop page loads 1 JavaScript resource with the preload hint.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1180601651&format=interactive",
  sheets_gid="1107832831",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

{{ figure_markup(
  image="prefetch-hints-per-page.png",
  caption="Distribution of prefetch hints for JavaScript resources per page.",
  description="Bar chart showing the distribution of prefetch hints per page. A median desktop page loads 2 JavaScript resources with the prefetch hint.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1265752379&format=interactive",
  sheets_gid="1107832831",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

The median desktop page loads one JavaScript resource with the `preload` hint and two JavaScript resources with the `prefetch` hint.

<figure>
  <table>
    <thead>
      <tr>
        <th>Hint</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`preload`</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>`prefetch`</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Year-over-year comparison of the median number of `preload` and `prefetch` hints for JavaScript resources per mobile page.",
    sheets_gid="1107832831",
    sql_file="resource-hints-prefetch-preload-percentage.sql"
  ) }}</figcaption>
</figure>

While the median number of `preload` hints per mobile page has stayed the same, the number of `prefetch` hints has decreased from three to two per page. Note that at the median, these results are identical for both mobile and desktop pages.

## How is JavaScript delivered?

JavaScript resources can be loaded more efficiently over the network with compression and minification. In this section, we'll explore the usage of both techniques to better understand the extent to which they're being utilized effectively.

### Compression

Compression is the process of reducing the file size of a resource as it gets transferred over the network. This can be an effective way to improve the download times of JavaScript resources, which are highly compressible. For example, the `almanac.js` script loaded on this page is 28 KB, but only 9 KB over the wire thanks to compression. You can learn more about the ways resources are compressed across the web in the [Compression](./compression) chapter.

{{ figure_markup(
  image="compression-requests.png",
  caption="Adoption of the methods for compressing JavaScript resources.",
  description="Bar chart showing the percent of the usage of compression methods. 55% of JavaScript requests apply the gzip compression on mobile, 31% apply br compression, and 14% do not apply any compression method.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1306457429&format=interactive",
  sheets_gid="1182320606",
  sql_file="compression_method.sql"
  )
}}

Most JavaScript resources are either compressed using <a hreflang="en" href="https://www.gnu.org/software/gzip/manual/gzip.html">Gzip</a>, <a hreflang="en" href="https://github.com/google/brotli">Brotli</a> (br), or not compressed at all (not set). 55.4% of mobile JavaScript resources use Gzip, whereas 30.8% of resources are compressed with Brotli.

Interestingly, compared to [the state of JavaScript compression in 2019](../2019/javascript#fig-10), Gzip has gone down by almost 10 percentage points and Brotli has increased by 16 percentage points. The trend illustrates the shift to focus on smaller size files with higher levels of compression that Brotli provides as compared to Gzip.

To help explain this change, we analyzed the compression methods of first and third-party resources.

{{ figure_markup(
  image="compression-first-third-party.png",
  caption="Adoption of the methods for compressing first and third-party JavaScript resources on mobile pages.",
  description="Bar chart showing the percent of the usage of compression methods for first-party and third-party. 59% of third-party JS requests apply the gzip compression on mobile, 30% third-party requests apply br compression, and 11% third-party scripts do not apply any compression method.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1269923134&format=interactive",
  sheets_gid="821396474",
  sql_file="compression_method_by_3p.sql"
  )
}}

59.1% of third-party scripts on mobile pages are gzipped and 29.6% are compressed with Brotli. Looking at first-party scripts, these are 51.7% with Gzip compression but only 32.0% with Brotli. There are still 11.3% of third-party scripts that do not have any compression method defined.

{{ figure_markup(
  image="uncompressed-first-third-party.png",
  caption="Uncompressed resources for first party vs third party.",
  description="Bar chart showing the percent of the uncompressed resources for first party vs third party. 90% of uncompressed third party JavaScript resources are < 5 KB, and uncompressed first-party resources less than 10kb are only 8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1043138204&format=interactive",
  sheets_gid="1942216454",
  sql_file="compression_none_by_bytes.sql"
  )
}}

90% of uncompressed third-party JavaScript resources are less than 5 KB, though first-party requests trail a bit. This may help explain why so many JavaScript resources go uncompressed. Due to the diminishing returns of compressing small resources, a small script may cost more in terms of the resource consumption of server-side compression and client-side decompression than the performance benefits of saving a few bytes over the network.

### Minification

While compression only changes the transfer size of JavaScript resources over the network, minification actually makes the code itself smaller and more efficient. This not only helps to reduce the load time of the script but also the amount of time the client spends parsing the script.

The <a hreflang="en" href="https://web.dev/unminified-javascript/">unminified JavaScript</a> Lighthouse audit highlights the opportunities of minification.

{{ figure_markup(
  image="unminified-js-audit-scores.png",
  caption="Distribution of unminified JavaScript audit scores.",
  description='Bar chart showing the percentage distribution of unminified JS audit scores. 67% of mobile pages have an "unminified JavaScript" score between 0.9 and 1.0',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1572896641&format=interactive",
  sheets_gid="1539653841",
  sql_file="lighthouse_unminified_js.sql"
  )
}}

Here, 0.00 represents the worst score whereas 1.00 represents the best score. 67.1% of mobile pages have an audit score between 0.9 and 1.0. That means there are still more than 30% of pages that have an unminified JavaScript score worse than 0.9 and could make better use of code minification. Compared to the results from the [2020 edition](../2020/javascript#fig-16), the percent of mobile pages with an "unminified JS" score between 0.9 and 1.0 fell by 10 points.

{# TODO: Rick is checking with the Lighthouse team to see if there were any major scoring algorithm changes to this audit in the past year. That would be a benign explanation for the 10 point drop in good scores. This change is really surprising, good find! #}

To understand the reason for the worse scores this year, let's dive deeper to look at how many bytes per page are unminified.

{{ figure_markup(
  image="unminified-js-bytes.png",
  caption="Distribution of the amount of unminified JavaScript per page, in KB.",
  description="Bar chart showing the percentage distribution of unminified JS bytes per page. 57% of mobile pages have 0 KB of unminified JS whereas 18% of those have 0-10 kilobytes of unminified JS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1069289665&format=interactive",
  sheets_gid="1511556407",
  sql_file="lighthouse_unminified_js_bytes.sql"
  )
}}

57.4% of mobile pages have 0 KB of unminified JavaScript as reported by the Lighthouse audit. 17.9% of mobile pages have between 0 and 10 KB of unminified JavaScript. The rest of the pages have an increasing number of unminified JavaScript bytes and correspond to those having poor "unminified JavaScript" audit scores in the previous chart.

{{ figure_markup(
  image="average-unminified-js-bytes.png",
  caption="Average distribution of unminified JavaScript bytes.",
  description="Pie chart showing the average distribution of unminified JavaScript bytes. 82% of the average mobile page's unminified JavaScript bytes actually come from first-party scripts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1119550643&format=interactive",
  sheets_gid="127709080",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

When we segmented the unminified JavaScript resources by host, we found that 82.0% of the average mobile page's unminified JavaScript bytes actually come from first-party scripts.

### Source maps

[Source maps](https://developer.mozilla.org/docs/Tools/Debugger/How_to/Use_a_source_map) are hints sent along with JavaScript resources that allow the browser to map the minified resource back to their source code. This is especially helpful to web developers for debugging in a production environment.

{{ figure_markup(
  content="0.1%",
  caption="Percent of mobile pages that use the `SourceMap` header.",
  classes="big-number",
  sheets_gid="1186092564",
  sql_file="sourcemap_header.sql"
  )
}}

Only 0.1% of mobile pages use the [`SourceMap`](https://developer.mozilla.org/docs/Web/HTTP/Headers/SourceMap) response header on script resources. One reason for this extremely small percentage could be that not many sites choose to put their original source code in production through the source map.

{{ figure_markup(
  content="98.0%",
  caption="Percent of JavaScript resources on mobile pages using the `SourceMap` header that are first-party resources.",
  classes="big-number",
  sheets_gid="2057978707",
  sql_file="sourcemap_header.sql"
  )
}}

98.0% of the `SourceMap` usage on JavaScript resources can be attributed to first-parties. Only 2.0% of scripts with the header on mobile pages are third-party resources.

## Libraries and frameworks

The usage of JavaScript seems to have increased tremendously over the years, with the adoption of many new libraries and frameworks all promising their own unique improvements to the developer and user experiences. They have become so prevalent that the term <a hreflang="en" href="https://allenpike.com/2015/javascript-framework-fatigue"><em>framework fatigue</em></a> was coined to describe developers' struggle just to keep up. In this section, we'll look at the popularity of the JavaScript libraries and frameworks in use on the web today.

### Libraries usage

To understand the usage of libraries and frameworks, HTTP Archive uses [Wappalyzer](./methodology#wappalyzer) to detect the technologies used on a page.

{{ figure_markup(
  image="js-libs-frameworks.png",
  caption="Usage of JavaScript libraries and frameworks.",
  description="Bar chart showing the usage of JavaScript libraries and frameworks. jQuery remains on top with 84% of mobile pages using it.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=584103777&format=interactive",
  sheets_gid="1851485826",
  sql_file="frameworks_libraries.sql"
  )
}}

jQuery remains the most popular library, used by a staggering 84% of mobile pages. React usage has jumped from 4% to 8% since last year, which is a significant increase. React's increase may be partially due to recent <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">detection improvements</a> to Wappalyzer, and may not necessarily reflect the actual change in adoption. It's also worth noting that Isotope, which uses jQuery, is found on 7% of pages, leading to RequireJS falling out of the top spots on just 2% of pages.

You might wonder why jQuery is still so dominant in 2021. There are two main reasons for this. First, as [highlighted over the previous years](../2019/javascript#open-source-libraries-and-frameworks), most <a hreflang="en" href="https://wordpress.org/">WordPress</a> sites use jQuery. Given that WordPress is used on nearly a third of all websites, according to the [CMS](./cms) chapter, this accounts for a huge proportion of jQuery adoption. Second, several of the other top-used JavaScript libraries still rely on jQuery in some way under the hood, contributing to indirect adoption of the library.

{{ figure_markup(
  content="3.5.1",
  caption="The most popular version of jQuery.",
  classes="big-number",
  sheets_gid="1097559251",
  sql_file="frameworks_libraries_by_version.sql"
  )
}}

The most popular version of jQuery is 3.5.1, which is used by 21.3% of mobile pages. The next most popular version of jQuery is 1.12.4, at 14.4% of mobile pages. The leap to version 3.0 can be explained by a <a hreflang="en" href="https://wptavern.com/major-jquery-changes-on-the-way-for-wordpress-5-5-and-beyond">change to WordPress core</a> in 2020, which upgraded the default version of jQuery from 1.12.4 to 3.5.1.

### Libraries used together

Now let's look at how the popular frameworks and libraries are used together on the same page.

<figure>
  <table>
    <thead>
      <tr>
        <th>Frameworks and libraries</th>
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
  <figcaption>{{ figure_link(
    caption="Top combinations of JavaScript frameworks and libraries used together.",
    sheets_gid="1934429143",
    sql_file="frameworks_libraries_combos.sql"
  ) }}</figcaption>
</figure>

The most widely-used combination of JavaScript libraries and frameworks doesn't actually consist of multiple libraries at all! When used by itself, jQuery is found on 17.4% of mobile pages. The next most popular combination is jQuery and jQuery Migrate, which is used on 8.7% of mobile pages. In fact, all of the top 10 library and framework combinations include jQuery.

### Security vulnerabilities

Using JavaScript libraries can come with its own benefits and drawbacks. When using these libraries, one drawback is that older versions may include security risks like <a hreflang="en" href="https://owasp.org/www-community/attacks/xss/">Cross Site Scripting</a> (XSS). [Lighthouse](./methodology#lighthouse) detects the JavaScript libraries used on a page and fails the audit if their version has any known vulnerabilities in the open-source <a hreflang="en" href="https://snyk.io/vuln?type=npm">Snyk vulnerability database</a>.

{{ figure_markup(
  content="63.9%",
  caption="Percentage of mobile pages with libraries having a security vulnerability.",
  classes="big-number",
  sheets_gid="793786066",
  sql_file="lighthouse_vulnerabilities.sql"
  )
}}

63.9% of mobile pages use a JavaScript library or framework with a known security vulnerability. For context, this number has come down from [83.5% since last year](../2020/javascript#fig-30).

<figure>
  <table>
    <thead>
      <tr>
        <th>Library or framework</th>
        <th>Percent of pages</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">57.6%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">12.2%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">10.5%</td>
      </tr>
      <tr>
        <td>Underscore</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>Lo-Dash</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.3%</td>
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
        <td>AngularJS</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Angular</td>
        <td class="numeric">0.4%</td>
      </tr>
        <td>Vue</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Knockout</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Highcharts</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Next.js</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="The percent of mobile pages found to contain a vulnerable version of a JavaScript library or framework.",
    sheets_gid="551476210",
    sql_file="lighthouse_vulnerable_libraries.sql"
  ) }}</figcaption>
</figure>

When we segment the percent of mobile pages by library and framework, we can see that jQuery is largely responsible for the decrease in vulnerabilities. This year JavaScript vulnerabilities were found on 57.6% of pages with jQuery, compared to [80.9% last year](../2020/javascript#fig-31). As [predicted](../2020/javascript#fig-31) by [Tim Kadlec](../2020/contributors#tkadlec) in the 2020 edition of this chapter, <em>"if we can get folks to migrate away from those outdated, vulnerable versions of jQuery, we would see the number of sites with known vulnerabilities plummet"</em>. And that's exactly what happened; WordPress migrated from jQuery version 1.12.4 to the more secure version 3.5.1, contributing to a 20 point drop in the percent of pages with known JavaScript vulnerabilities.

## How do we use JavaScript?

Now that we've looked at how we get the JavaScript, what are we using it for?

### AJAX

One way that JavaScript is used is to communicate with servers to asynchronously receive information in various formats. [_Asynchronous JavaScript and XML_](https://developer.mozilla.org/docs/Web/Guide/AJAX/Getting_Started) (AJAX) is typically used to send and receive data, and it supports more than just XML, including JSON, HTML, and text formats.

With multiple ways to send and receive data on the web, let's look at how many asynchronous requests are sent per page.

{{ figure_markup(
  image="async-requests-per-page.png",
  caption="Distribution of the number of asynchronous requests made per page.",
  description="Bar chart showing the number of asynchronous requests made per page. On a desktop page, the 10th, 25th, 50th, 75th, and 90th percentiles for asynchronous requests made are: 2, 3, 4, 8, 15.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=709009883&format=interactive",
  sheets_gid="183546956",
  sql_file="ajax_request_per_page.sql"
  )
}}

The median mobile page makes 4 asynchronous requests. If we look at the long tail, the largest number of asynchronous requests on desktop pages is 623, which is eclipsed by the biggest mobile page, which makes 867 asynchronous requests!

An alternative to the asynchronous AJAX requests are the synchronous requests. Rather than passing a request to a callback, they block the main thread until the request completes.

However, [this practice is discouraged](https://developer.mozilla.org/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests#synchronous_request) due to the potential for poor performance and user experiences, and many browsers already warn about such usage. It would be intriguing to see how many pages still use synchronous AJAX requests.

{{ figure_markup(
  image="usage-sync-async.png",
  caption="Usage of synchronous and asynchronous AJAX requests.",
  description="Bar chart showing the usage of synchronous and asynchronous AJAX requests on mobile pages. The percent of synchronous requests made on mobile page are 2.5% and that of asynchronous requests are 77.6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=189627938&format=interactive",
  sheets_gid="1113974683",
  sql_file="ajax_request_per_page.sql"
  )
}}

2.5% of mobile pages use the deprecated synchronous AJAX requests. To put this into perspective, let's look at the trend by comparing the results with the last two years.

{{ figure_markup(
  image="usage-sync-async-over-years.png",
  caption="Usage of synchronous and asynchronous AJAX requests over years.",
  description="Bar chart showing the usage of synchronous and asynchronous AJAX requests over the past years. In 2019, the percentage of asynchronous requests made on mobile was 54.9% increasing to 61.8% in 2020, 77.6% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=126336838&format=interactive",
  sheets_gid="1113974683",
  sql_file="ajax_async.sql"
  )
}}

We see that there is a clear increase in the usage of asynchronous AJAX requests. However, there isn't a significant decline in the usage of synchronous AJAX requests.

Knowing the number of AJAX requests per page now, we'd also be interested in knowing the most commonly used APIs to request the data from the server.

We can broadly classify these AJAX requests into three different APIs and dig in to see how they're used. The core APIs [`XMLHttpRequest`](https://developer.mozilla.org/docs/Web/API/XMLHttpRequest) (XHR), [`Fetch`](https://developer.mozilla.org/docs/Web/API/Fetch_API/Using_Fetch), and [`Beacon`](https://developer.mozilla.org/docs/Web/API/Beacon_API) are used commonly across websites with XHR being used primarily, however `Fetch` is gaining popularity and growing rapidly while `Beacon` has low usage.

{{ figure_markup(
  image="ajax_xhr.png",
  caption="Distribution of the number of XMLHttpRequest requests per page.",
  description="Bar chart showing the usage of XMLHttpRequest per page on both desktop and mobile pages. The median mobile page makes 2 XHR requests, but at 90th percentile, makes 6 XHR requests. The 10th, 25th, 50th, 75th, and 90th percentiles for usage of XMLHttpRequest on desktop are: 0, 1, 2, 3, 6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1164635195&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

The median mobile page makes 2 XHR requests, but at 90th percentile, makes 6 XHR requests.

{{ figure_markup(
  image="ajax_fetch.png",
  caption="Distribution of the number of `Fetch` requests per page.",
  description="Bar chart showing the usage of Fetch per page on both desktop and mobile pages. The median mobile page makes 2 Fetch requests, but at 90th percentile, makes 3 Fetch requests. The 10th, 25th, 50th, 75th, and 90th percentiles for usage of Fetch on mobile are: 0, 2, 2, 2, 3.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=147712640&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

In the case of the usage of the `Fetch` API, the median mobile page makes 2 requests, and in the long tail, reaches 3 requests. This API is becoming the standard XHR way of making requests, due in part to its cleaner approach and less boilerplate code. There may also be <a hreflang="en" href="https://gomakethings.com/the-fetch-api-performance-vs.-xhr-in-vanilla-js/">performance benefits</a> to `Fetch` over the traditional XHR approach, due to the way browsers can decode large JSON payloads off the main thread.

{{ figure_markup(
  image="ajax_beacon.png",
  caption="Distribution of the number of `Beacon` requests per page.",
  description="Bar chart showing the usage of Beacon per page on both desktop and mobile pages. The median mobile page makes no Beacon requests, but at 90th percentile, makes 1 Beacon request.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1483701430&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

`Beacon` usage is almost non-existent, with 0 requests per page until the 90th percentile, at which there's only one request per page. One possible explanation for this low adoption could be that `Beacon` is typically used for sending analytics data, especially when one wants to ensure that the request is sent even if the page might unload soon. This is, however, not guaranteed when using XHR. A good experiment for the future would be to see if some statistics could be collected around any pages using XHR for analytics data, session data, etc.

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

For both `Fetch` and XHR, the usage has increased significantly over the years. `Fetch` usage on mobile pages is up 4 points and XHR is up 19 points. The gradual increase of `Fetch` adoption seems to point towards a trend of cleaner requests and better response handling.

### Web Components and the shadow DOM

With the web becoming [componentized](https://developer.mozilla.org/docs/Web/Web_Components), a developer building a single page application may think about a user view as a set of components. This is not only for the sake of developers building dedicated components for each feature, but also to maximize component reusability. It could be in the same app on a different view or in a completely different application. Such use cases lead to the usage of custom elements and web components in applications.

It would be justified to say that with many JavaScript frameworks gaining popularity, the idea of reusability and building dedicated feature-based components has been adopted more widely. This feeds our curiosity to look into the adoption of custom elements, shadow DOM, template elements.

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/customelements">Custom Elements</a> are customized elements built on top of the [`HTMLElement`](https://developer.mozilla.org/docs/Web/API/HTMLElement) API. Browsers provide a `customElements` API that allows developers to define an element and register it with the browser as a custom element.

{{ figure_markup(
  content="3.0%",
  caption="Percent of desktop pages using custom elements.",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_pct.sql"
  )
}}

3.0% of mobile pages use custom elements for one or more parts of the web page.

{{ figure_markup(
  content="0.4%",
  caption="Percent of pages using Shadow DOM.",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_pct.sql"
  )
}}

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/shadowdom">_Shadow DOM_</a> allows you to create a dedicated subtree in the DOM for the custom element introduced to the browser. It ensures the styles and nodes inside the element are not accessible outside the element.

0.4% of mobile pages use shadow DOM specification of web components to ensure a scoped subtree for the element.

{{ figure_markup(
  content="<0.1%",
  caption="Percent of pages using `template` elements.",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_pct.sql"
  )
}}

A [`template`](https://developer.mozilla.org/docs/Web/Web_Components/Using_templates_and_slots#the_truth_about_templates) element is very useful when there is a pattern in the markup which could be reused. The contents of `template` elements render only when referenced by JavaScript.

Templates work well when dealing with web components, as the content that is not yet referenced by JavaScript is then appended to a shadow root using the shadow DOM.

Fewer than 0.1% of web pages have adopted the use of templates. Although templates are <a hreflang="en" href="https://caniuse.com/template">well supported</a> in browsers, there is still a very low percentage of pages using them.

## Conclusion

The numbers that we have seen throughout the chapter have brought us to an understanding of how vast the JavaScript usage is and how it's evolving over time. The JavaScript ecosystem has been growing with the focus towards making the web more performant and secure for users, with newer features and APIs that make the developer experience easier and more productive.

We saw how so many features that improve rendering and resource loading performance could be more widely utilized to provide users with faster experiences. As a developer, you can start by adopting these new web platform features. However, make sure to use them wisely and ensure that they actually improve performance, as some APIs can cause harm through misuse, as we saw with `async` and `defer` attributes on the same script.

Making appropriate use of the powerful APIs that we now have access to is what it will take to see these numbers improve further in the coming years. Let's continue to do so.
