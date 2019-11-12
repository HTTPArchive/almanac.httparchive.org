---
part_number: I
chapter_number: 1
title: JavaScript
description: JavaScript chapter of the 2019 Web Almanac covering how much JavaScript we use on the web, compression, libraries and frameworks, loading, and source maps.
authors: [housseindjirdeh]
reviewers: [obto, paulcalvano, mathiasbynens]
discuss: 1756
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-11T00:00:00.000Z
---

## Introduction

JavaScript is a scripting language that makes it possible to build interactive and complex experiences on the web. This includes responding to user interactions, updating dynamic content on a page, and so forth. Anything involving how a web page should behave when an event occurs is what JavaScript is used for.

The language specification itself, along with many community-built libraries and frameworks used by developers around the world, has changed and evolved ever since the language was created in 1995. JavaScript implementations and interpreters have also continued to progress, making the language usable in many environments, not only web browsers.

The [HTTP Archive](https://httparchive.org/) crawls [millions of pages](https://httparchive.org/reports/state-of-the-web#numUrls) every month and runs them through a private instance of [WebPageTest](https://webpagetest.org/) to store key information of every page. (You can learn more about this in our [methodology](./methodology)). In the context of JavaScript, HTTP Archive provides extensive information on the usage of the language for the entire web. This chapter consolidates and analyzes many of these trends.

## How much JavaScript do we use?

JavaScript is the most costly resource we send to browsers; having to be downloaded, parsed, compiled, and finally executed. Although browsers have significantly decreased the time it takes to parse and compile scripts, [download and execution have become the most expensive stages](https://v8.dev/blog/cost-of-javascript-2019) when JavaScript is processed by a web page.

Sending smaller JavaScript bundles to the browser is the best way to reduce download times, and in turn improve page performance. **But how much JavaScript do we really use?**

<figure>
	<iframe aria-labelledby="fig1-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1974602890&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig1.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig1.png" aria-labelledby="fig1-caption" width="600">
   </a>
	<div id="fig1-caption" class="visually-hidden">Figure 1. Distribution of JavaScript bytes per page</div>
	<figcaption>Figure 1. Distribution of JavaScript bytes per page.</figcaption>
</figure>

Figure 1 above shows that we use 373 KB of JavaScript at the 50th percentile, or median. In other words, 50% of all sites ship more than this much JavaScript to their users.

Looking at these numbers, it's only natural to wonder if this is too much JavaScript. However in terms of page performance, the impact entirely depends on network connections and devices used. Which brings us to our next question: how much JavaScript do we ship when we compare mobile and desktop clients?

<figure>
	<iframe aria-labelledby="fig2-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1914565673&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig2.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig2.png" aria-labelledby="fig2-caption" width="600">
   </a>
	<div id="fig2-caption" class="visually-hidden">Figure 2. Distribution of JavaScript per page by device</div>
	<figcaption>Figure 2. Distribution of JavaScript per page by device.</figcaption>
</figure>

At every percentile, we're sending slightly more JavaScript to desktop devices than we are to mobile.

### Processing time

After being parsed and compiled, JavaScript fetched by the browser needs to processed (or executed) before it can be utilized. Devices vary, and their computing power can significantly affect how fast JavaScript can be processed on a page. What are the current processing times on the web?

We can get an idea by analyzing main thread processing times for V8 at different percentiles:

<figure>
	<iframe aria-labelledby="fig3-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=924000517&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig2.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig3.png" aria-labelledby="fig3-caption" width="600">
   </a>
	<div id="fig3-caption" class="visually-hidden">Figure 3. V8 Main thread processing times by device</div>
	<figcaption>Figure 3. V8 Main thread processing times by device.</figcaption>
</figure>

At every percentile, processing times are longer for mobile web pages than on desktop. The median total main thread time on desktop is 849 ms, while mobile is at a larger number: 2,436ms.

Although this data shows how much longer it can take for a mobile device to process JavaScript compared to a more powerful desktop machine, mobile devices also vary in terms of computing power. The following chart shows how processing times on a single web page can vary significantly depending on the mobile device class.

<figure>
	<a href="/static/images/2019/01_JavaScript/js-processing-reddit.png">
		<img alt="JavaScript processing times for Reddit.com" src="/static/images/2019/01_JavaScript/js-processing-reddit.png" width="600">
	</a>
	<figcaption>Figure 4. JavaScript processing times for reddit.com. From <a href="https://v8.dev/blog/cost-of-javascript-2019">The cost of JavaScript in 2019</a>.</figcaption>
</figure>

### Number of requests

One avenue worth exploring when trying to analyze the amount of JavaScript used by web pages is the number of requests shipped. With [HTTP/2](https://developers.google.com/web/fundamentals/performance/http2), sending multiple smaller chunks can improve page load over sending a larger, monolithic bundle. If we also break it down by device client, **how many requests are being fetched?**

<figure>
	<iframe aria-labelledby="fig5-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1632335480&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig5.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig5.png" aria-labelledby="fig5-caption" width="600">
   </a>
	<div id="fig5-caption" class="visually-hidden">Figure 5. Distribution of total JavaScript requests</div>
	<figcaption>Figure 5. Distribution of total JavaScript requests.</figcaption>
</figure>

At the median, 19 requests are sent for desktop and 18 for mobile.

### First-party vs. third-party

Of the results analyzed so far, the entire size and number of requests were being considered. In a majority of websites however, a significant portion of the JavaScript code fetched and used comes from third-party sources.

Third-party JavaScript can come from any external, third-party source. Ads, analytics and social media embeds are all common use-cases for fetching third-party scripts. So naturally, this brings us to our next question: **how many requests sent are third-party instead of first-party?**

<figure>
	<iframe aria-labelledby="fig6-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1108490&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig6.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig6.png" aria-labelledby="fig6-caption" width="600">
   </a>
	<div id="fig6-caption" class="visually-hidden">Figure 6. Distribution of first and third-party scripts on desktop</div>
	<figcaption>Figure 6. Distribution of first and third-party scripts on desktop.</figcaption>
</figure>

<figure>
	<iframe aria-labelledby="fig7-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=998640509&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig7.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig7.png" aria-labelledby="fig7-caption" width="600">
   </a>
	<div id="fig6-caption" class="visually-hidden">Figure 7. Distribution of first and third-party scripts on mobile</div>
	<figcaption>Figure 7. Distribution of first and third party scripts on mobile.</figcaption>
</figure>

For both mobile and desktop clients, more third-party requests are sent than first-party at every percentile. If this seems surprising, let's find out how much actual code shipped comes from third-party vendors.

<figure>
	<iframe aria-labelledby="fig8-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=633945705&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig8.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig8.png" aria-labelledby="fig8-caption" width="600">
   </a>
	<div id="fig8-caption" class="visually-hidden">Figure 8. Distribution of total JavaScript downloaded on desktop</div>
	<figcaption>Figure 8. Distribution of total JavaScript downloaded on desktop.</figcaption>
</figure>

<figure>
	<iframe aria-labelledby="fig9-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1611383649&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig9.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig9.png" aria-labelledby="fig9-caption" width="600">
   </a>
	<div id="fig9-caption" class="visually-hidden">Figure 9. Distribution of total JavaScript downloaded on mobile</div>
	<figcaption>Figure 9. Distribution of total JavaScript downloaded on mobile.</figcaption>
</figure>

At the median, 89% more third-party code is used than first-party code authored by the developer for both mobile and desktop. This clearly shows that third-party code can be one of the biggest contributors to bloat.

## Resource compression

In the context of browser-server interactions, resource compression refers to code that has been modified using a data compression algorithm. Resources can be compressed statically ahead of time or on-the-fly as they are requested by the browser, and for either approach the transferred resource size is significantly reduced which improves page performance.

There are multiple text-compression algorithms, but only two are mostly used for the compression (and decompression) of HTTP network requests:

- [Gzip](https://www.gzip.org/) (gzip): The most widely used compression format for server and client interactions
- [Brotli](https://github.com/google/brotli) (br): A newer compression algorithm aiming to further improve compression ratios. [90% of browsers](https://caniuse.com/#feat=brotli) support Brotli encoding.

Compressed scripts will always need to be uncompressed by the browser once transferred. This means its content remains the same and execution times are not optimized whatsoever. Resource compression, however, will always improve download times which also is one of the most expensive stages of JavaScript processing. Ensuring JavaScript files are compressed correctly can be one of the most significant factors in improving site performance.

**How many sites are compressing their JavaScript resources?**

<figure>
	<iframe aria-labelledby="fig10-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=241928028&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig10.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig10.png" aria-labelledby="fig10-caption" width="600">
   </a>
	<div id="fig10-caption" class="visually-hidden">Figure 10. Percentage of sites compressing JavaScript resources with gzip or brotli</div>
	<figcaption>Figure 10. Percentage of sites compressing JavaScript resources with gzip or brotli.</figcaption>
</figure>

The majority of sites are compressing their JavaScript resources. Gzip encoding is used on ~64-67% of sites and Brotli on ~14%. Compression ratios are similar for both desktop and mobile.

For a deeper analysis on compression, refer to the ["Compression"](./compression) chapter.

## Open source libraries and frameworks

Open source code, or code with a permissive license that can be accessed, viewed and modified by anyone. From tiny libraries to entire browsers, such as [Chromium](https://www.chromium.org/Home) and [Firefox](https://www.openhub.net/p/firefox), open source code plays a crucial role in the world of web development. In the context of JavaScript, developers rely on open source tooling to include all types of functionality into their web page. Regardless of whether a developer decides to use a small utility library or a massive framework that dictates the architecture of their entire application, relying on open-source packages cam make feature development easier and faster.

**Which JavaScript open-source libraries are used the most?**

<figure>
	<table>
      <thead>
        <tr>
          <th>Library</th>
          <th>Desktop</th>
          <th>Mobile</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>jQuery</td>
          <td class="numeric">85.03%</td>
          <td class="numeric">83.46%</td>
        </tr>
        <tr>
          <td>jQuery Migrate</td>
          <td class="numeric">31.26%</td>
          <td class="numeric">31.68%</td>
        </tr>
        <tr>
          <td>jQuery UI</td>
          <td class="numeric">23.60%</td>
          <td class="numeric">21.75%</td>
        </tr>
        <tr>
          <td>Modernizr</td>
          <td class="numeric">17.80%</td>
          <td class="numeric">16.76%</td>
        </tr>
        <tr>
          <td>FancyBox</td>
          <td class="numeric">7.04%</td>
          <td class="numeric">6.61%</td>
        </tr>
        <tr>
          <td>Lightbox</td>
          <td class="numeric">6.02%</td>
          <td class="numeric">5.93%</td>
        </tr>
        <tr>
          <td>Slick</td>
          <td class="numeric">5.53%</td>
          <td class="numeric">5.24%</td>
        </tr>
        <tr>
          <td>Moment.js</td>
          <td class="numeric">4.92%</td>
          <td class="numeric">4.29%</td>
        </tr>
        <tr>
          <td>Underscore.js</td>
          <td class="numeric">4.20%</td>
          <td class="numeric">3.82%</td>
        </tr>
        <tr>
          <td>prettyPhoto</td>
          <td class="numeric">2.89%</td>
          <td class="numeric">3.09%</td>
        </tr>
        <tr>
          <td>Select2</td>
          <td class="numeric">2.78%</td>
          <td class="numeric">2.48%</td>
        </tr>
        <tr>
          <td>Lodash</td>
          <td class="numeric">2.65%</td>
          <td class="numeric">2.68%</td>
        </tr>
        <tr>
          <td>Hammer.js</td>
          <td class="numeric">2.28%</td>
          <td class="numeric">2.70%</td>
        </tr>
        <tr>
          <td>YUI</td>
          <td class="numeric">1.84%</td>
          <td class="numeric">1.50%</td>
        </tr>
        <tr>
          <td>Lazy.js</td>
          <td class="numeric">1.26%</td>
          <td class="numeric">1.56%</td>
        </tr>
        <tr>
          <td>Fingerprintjs</td>
          <td class="numeric">1.21%</td>
          <td class="numeric">1.32%</td>
        </tr>
        <tr>
          <td>script.aculo.us</td>
          <td class="numeric">0.98%</td>
          <td class="numeric">0.85%</td>
        </tr>
        <tr>
          <td>Polyfill</td>
          <td class="numeric">0.97%</td>
          <td class="numeric">1.00%</td>
        </tr>
        <tr>
          <td>Flickity</td>
          <td class="numeric">0.83%</td>
          <td class="numeric">0.92%</td>
        </tr>
        <tr>
          <td>Zepto</td>
          <td class="numeric">0.78%</td>
          <td class="numeric">1.17%</td>
        </tr>
        <tr>
          <td>Dojo</td>
          <td class="numeric">0.70%</td>
          <td class="numeric">0.62%</td>
        </tr>
      </tbody>
    </table>
	<figcaption>Figure 11. Top JavaScript libraries on desktop and mobile.</figcaption>
</figure>

[jQuery](https://jquery.com/), the most popular JavaScript library ever created, is used in 85.03% of desktop pages and 83.46% of mobile pages. The advent of many Browser APIs and methods, such as [Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) and [querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector), standardized much of the functionality provided by the library into a native form. Although the popularity of jQuery may seem to be declining, why is it still used in the vast majority of the web?

There are a number of possible reasons:

- [WordPress](https://wordpress.org/), which is used in more than 30% of sites, includes jQuery by default.
- Switching from jQuery to a newer client-side library can take time depending on how large an application is, and many sites may consist of jQuery in addition to newer client-side libraries.

Other top used JavaScript libraries include jQuery variants (jQuery migrate, jQuery UI), [Modernizr](https://modernizr.com/), [Moment.js](https://momentjs.com/), [Underscore.js](https://underscorejs.org/) and so on.

### Frameworks and UI libraries

In the past number of years, the JavaScript ecosystem has seen a rise in open-source libraries and frameworks to make building **single-page applications** (SPAs) easier. A single-page application is characterized as a web page that loads a single HTML page and uses JavaScript to modify the page on user interaction instead of fetching new pages from the server. Although this remains to be the main premise of single-page applications, different server-rendering approaches can still be used to improve the experience of such sites.

**How many sites use these types of frameworks?**

<figure>
	<iframe aria-labelledby="fig12-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1699359221&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig12.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig12.png" aria-labelledby="fig12-caption" width="600">
   </a>
	<div id="fig12-caption" class="visually-hidden">Figure 12. Most frequently used frameworks on desktop</div>
	<figcaption>Figure 12. Most frequently used frameworks on desktop.</figcaption>
</figure>

Only a subset of popular frameworks are being analyzed here, but it's important to note that all of them either follow one of these two approaches:

- A [model-view-controller](https://developer.chrome.com/apps/app_frameworks) (or model-view-viewmodel) architecture
- A component-based architecture

Although there has been a shift towards a component-based model, many older frameworks that follow the MVC paradigm ([AngularJS](https://angularjs.org/), [Backbone.js](https://backbonejs.org/), [Ember](https://emberjs.com/)) are still being used in thousands of pages. However, [React](https://reactjs.org/), [Vue](https://vuejs.org/) and [Angular](https://angular.io/) are the most popular component-based frameworks ([Zone.js](https://github.com/angular/zone.js) is a package that is now part of Angular core).

Although this analysis is interesting, it's important to keep in mind that these results rely on a third-party detection library - [Wappalyzer](https://www.wappalyzer.com). All these usage numbers depend on the accuracy of each [detection mechanism](https://github.com/AliasIO/Wappalyzer/blob/master/src/apps.json) in place.

## Differential loading

[JavaScript modules](https://v8.dev/features/modules), or ES modules, are supported in [all major browsers](https://caniuse.com/#feat=es6-module). Modules provide the capability to create scripts that can import and export from other modules. This allows anyone to build their applications architected in a module pattern, importing and exporting wherever necessary, without relying on third-party module loaders.

To declare a script as a module, the script tag must get the `type="module"`:

```html
<script type="module" src="main.mjs"></script>
```

**How many sites use `type="module"` for scripts on their page?**

<figure>
	<iframe aria-labelledby="fig13-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1409239029&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig13.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig13.png" aria-labelledby="fig13-caption" width="600">
   </a>
	<div id="fig13-caption" class="visually-hidden">Figure 13. Percentage of sites utilizing type=module</div>
	<figcaption>Figure 13. Percentage of sites utilizing type=module.</figcaption>
</figure>

Browser-level support for modules is still relatively new, and the numbers here show that very few sites currently use `type="module"` for their scripts. Many sites are still relying on module loaders (2.37% of all desktop sites use [RequireJS](https://github.com/requirejs/requirejs) for example) and bundlers ([webpack](https://webpack.js.org/) for example) to define modules within their codebase.

If native modules are used, it's important to ensure that an appropriate fallback script is used for browsers that do not yet support modules. This can be done by including an additional script with a `nomodule` attribute.

```html
<script nomodule src="fallback.js"></script>
```

When used together, browsers that support modules will completely ignore any scripts containing the `nomodule` attribute. On the other hand, browsers that do not yet support modules will not download any scripts with `type="module"`. Since they do not recognize `nomodule` either, they will download scripts with the attribute normally. Using this approach can allow developers to [send modern code to modern browsers for faster page loads](https://web.dev/serve-modern-code-to-modern-browsers/).

So, **how many sites use `nomodule` for scripts on their page?**

<figure>
	<iframe aria-labelledby="fig14-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=781034243&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig14.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig14.png" aria-labelledby="fig14-caption" width="600">
   </a>
	<div id="fig14-caption" class="visually-hidden">Figure 14. Percentage of sites using nomodule</div>
	<figcaption>Figure 14. Percentage of sites using nomodule.</figcaption>
</figure>

Similarly, very few sites (0.50%-0.80%) use the `nomodule` attribute for any scripts.

## Preload and prefetch

[Preload](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content) and [prefetch](https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ) are directives which enable you to aid the browser in determining what resources need to be downloaded.

- Preloading a resource with `<link rel="preload">` tells the browser to download this resource as soon as possible. This is especially helpful for critical resources which are discovered late in the page loading process (e.g., javascript located at the bottom of your HTML) and are otherwise downloaded last.
- Using `<link rel="prefetch">` tells the browser to take advantage of any idle time it has to fetch these resources needed for future navigations

**So, how many sites use preload and prefetch directives?**

<figure>
	<iframe aria-labelledby="fig15-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=2007534370&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig15.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig15.png" aria-labelledby="fig15-caption" width="600">
   </a>
	<div id="fig15-caption" class="visually-hidden">Figure 15. Percentage of sites using rel=preload for scripts</div>
	<figcaption>Figure 15. Percentage of sites using rel=preload for scripts.</figcaption>
</figure>

For all sites measured in HTTP Archive, 14.33% of desktop sites and 14.84% of mobile sites use `<link rel="preload">` for scripts on their page.

For prefetch:

<figure>
	<iframe aria-labelledby="fig16-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=547807937&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig16.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig16.png" aria-labelledby="fig16-caption" width="600">
   </a>
	<div id="fig16-caption" class="visually-hidden">Figure 16. Percentage of sites using rel=prefetch for scripts</div>
	<figcaption>Figure 16. Percentage of sites using rel=prefetch for scripts.</figcaption>
</figure>

For both mobile and desktop, 0.08% of pages leverage prefetch for any of their scripts.

## Newer APIs

JavaScript continues to evolve as a language. A new version of the language standard itself, known as ECMAScript, is released every year with new APIs and features passing proposal stages to become a part of the language itself.

With HTTP Archive, we can take a look at any newer API that is supported (or is about to be) and see how widespread its usage is. These APIs may already be used in browsers that support them _or_ with an accompanying polyfill to make sure they still work for every user.

**How many sites use the following APIs?**

- [Atomics](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Atomics)
- [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl)
- [Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)
- [WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- [WeakSet](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)

<figure>
	<iframe aria-labelledby="fig17-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=594315296&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig17.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig17.png" aria-labelledby="fig17-caption" width="600">
   </a>
	<div id="fig17-caption" class="visually-hidden">Figure 17. Usage of new JavaScript APIs</div>
	<figcaption>Figure 17. Usage of new JavaScript APIs.</figcaption>
</figure>

Atomics (0.38%) and SharedArrayBuffer (0.20%) are barely visible on this chart since they are used on such few pages.

It is important to note that the numbers here are approximations and they do not leverage [UseCounter](https://chromium.googlesource.com/chromium/src.git/+/master/docs/use_counter_wiki.md) to measure feature usage.

## Source maps

In many build systems, JavaScript files undergo minification to minimize its size and transpilation for newer language features that are not yet supported in many browsers. Moreover, language supersets like [TypeScript](https://www.typescriptlang.org/) compile to an output that can look noticeably different from the original source code. For all these reasons, the final code served to the browser can unreadable and hard to decipher.

A **source map** is an additional file accompanying a JavaScript file that allows a browser to map the final output to its original source. This can make debugging and analyzing production bundles much simpler.

Although useful, there are a number of reasons why many sites may not want to include source maps in their final production site, such as choosing not to expose complete source code to the public. **So how many sites actually include sourcemaps?**

<figure>
	<iframe aria-labelledby="fig18-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=906754154&format=interactive"></iframe>
   <a href="/static/images/2019/01_JavaScript/fig18.png" class="fig-mobile">
      <img src="/static/images/2019/01_JavaScript/fig18.png" aria-labelledby="fig18-caption" width="600">
   </a>
	<div id="fig18-caption" class="visually-hidden">Figure 18. Percentage of sites using source maps</div>
	<figcaption>Figure 18. Percentage of sites using source maps.</figcaption>
</figure>

For both desktop and mobile pages, the results are about the same. 17-18% include a source map for at least one script on the page (detected as a first-party script with `sourceMappingURL`).

## Conclusion

The JavaScript ecosystem continues to change and evolve every year. Newer APIs, improved browser engines, and fresh libraries and frameworks are all things we can expect to happen indefinitely. HTTP Archive provides us with valuable insight on how sites in the wild use the language.

Without JavaScript, the web would not be where it is today, and all the data gathered for this article only proves this.
