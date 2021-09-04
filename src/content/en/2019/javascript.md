---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: JavaScript chapter of the 2019 Web Almanac covering how much JavaScript we use on the web, compression, libraries and frameworks, loading, and source maps.
authors: [housseindjirdeh]
reviewers: [obto, paulcalvano, mathiasbynens, rviscomi]
analysts: [rviscomi]
editors: [obto]
translators: []
discuss: 1756
results: https://docs.google.com/spreadsheets/d/1kBTglETN_V9UjKqK_EFmFjRexJnQOmLLr-I2Tkotvic/
housseindjirdeh_bio: Houssein is a Developer Advocate at Google working on speed, performance and the web framework ecosystem. He tweets at <a href="https://twitter.com/hdjirdeh">@hdjirdeh</a> and blogs at <a hreflang="en" href="https://houssein.me/">https://houssein.me/</a>.
featured_quote: JavaScript is the most costly resource we send to browsers; having to be downloaded, parsed, compiled, and finally executed. Although browsers have significantly decreased the time it takes to parse and compile scripts, download and execution have become the most expensive stages when JavaScript is processed by a web page.
featured_stat_1: 89%
featured_stat_label_1: Sites with more third-party code than first-party
featured_stat_2: 83%
featured_stat_label_2: Sites that use jQuery
featured_stat_3: 4.6%
featured_stat_label_3: Home pages using React
---

## Introduction

JavaScript is a scripting language that makes it possible to build interactive and complex experiences on the web. This includes responding to user interactions, updating dynamic content on a page, and so forth. Anything involving how a web page should behave when an event occurs is what JavaScript is used for.

The language specification itself, along with many community-built libraries and frameworks used by developers around the world, has changed and evolved ever since the language was created in 1995. JavaScript implementations and interpreters have also continued to progress, making the language usable in many environments, not only web browsers.

The <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> crawls <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">millions of pages</a> every month and runs them through a private instance of <a hreflang="en" href="https://webpagetest.org/">WebPageTest</a> to store key information of every page. (You can learn more about this in our [methodology](./methodology)). In the context of JavaScript, HTTP Archive provides extensive information on the usage of the language for the entire web. This chapter consolidates and analyzes many of these trends.

## How much JavaScript do we use?

JavaScript is the most costly resource we send to browsers; having to be downloaded, parsed, compiled, and finally executed. Although browsers have significantly decreased the time it takes to parse and compile scripts, <a hreflang="en" href="https://v8.dev/blog/cost-of-javascript-2019">download and execution have become the most expensive stages</a> when JavaScript is processed by a web page.

Sending smaller JavaScript bundles to the browser is the best way to reduce download times, and in turn improve page performance. But how much JavaScript do we really use?

{{ figure_markup(
  image="fig1.png",
  caption="Distribution of JavaScript bytes per page.",
  description="Bar chart showing 70 bytes of JavaScript are used in the 10th percentile, 174 bytes for 25th percentile, 373 bytes for 50th percentile, 693 bytes for 75th percentile, and 1,093 bytes for 90th percentile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1974602890&format=interactive"
  )
}}

Figure 1.1 above shows that we use 373 KB of JavaScript at the 50th percentile, or median. In other words, 50% of all sites ship more than this much JavaScript to their users.

Looking at these numbers, it's only natural to wonder if this is too much JavaScript. However in terms of page performance, the impact entirely depends on network connections and devices used. Which brings us to our next question: how much JavaScript do we ship when we compare mobile and desktop clients?

{{ figure_markup(
  image="fig2.png",
  caption="Distribution of JavaScript per page by device.",
  description="Bar chart showing 76 bytes/65 bytes of JavaScript are used in the 10th percentile on desktop and mobile respectively, 186/164 bytes for 25th percentile, 391/359 bytes for 50th percentile, 721/668 bytes for 75th percentile, and 1,131/1,060 bytes for 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1914565673&format=interactive"
  )
}}

At every percentile, we're sending slightly more JavaScript to desktop devices than we are to mobile.

### Processing time

After being parsed and compiled, JavaScript fetched by the browser needs to processed (or executed) before it can be utilized. Devices vary, and their computing power can significantly affect how fast JavaScript can be processed on a page. What are the current processing times on the web?

We can get an idea by analyzing main thread processing times for V8 at different percentiles:

{{ figure_markup(
  image="fig3.png",
  caption="V8 Main thread processing times by device.",
  description="Bar chart showing 141 ms/377 ms of processing time is used in the 10th percentile on desktop and mobile respectively, 352/988 ms for 25th percentile, 849/2,437 ms for 50th percentile, 1,850/5,518 ms for 75th percentile, and 3,543/10,735 ms for 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=924000517&format=interactive"
  )
}}

At every percentile, processing times are longer for mobile web pages than on desktop. The median total main thread time on desktop is 849 ms, while mobile is at a larger number: 2,437 ms.

Although this data shows how much longer it can take for a mobile device to process JavaScript compared to a more powerful desktop machine, mobile devices also vary in terms of computing power. The following chart shows how processing times on a single web page can vary significantly depending on the mobile device class.

{{ figure_markup(
  image="js-processing-reddit.png",
  caption='JavaScript processing times for reddit.com. From <a hreflang="en" href="https://v8.dev/blog/cost-of-javascript-2019">The cost of JavaScript in 2019</a>.',
  description="Bar chart showing 3 different devices: at the top a Pixel 3 has small amount on both the main thread and the worker thread of less than 400ms. For a Moto G4 it is approximately 900 ms on main thread and a further 300 ms on worker thread. And the final bar is an Alcatel 1X 5059D with over 2,000 ms on the main thread and over 500 ms on worker thread.",
  width=600,
  height=363
  )
}}

### Number of requests

One avenue worth exploring when trying to analyze the amount of JavaScript used by web pages is the number of requests shipped. With [HTTP/2](./http), sending multiple smaller chunks can improve page load over sending a larger, monolithic bundle. If we also break it down by device client, how many requests are being fetched?

{{ figure_markup(
  image="fig5.png",
  caption="Distribution of total JavaScript requests.",
  description="Bar chart showing 4/4 requests for desktop and mobile respectively are used in the 10th percentile, 10/9 in 25th percentile, 19/18 in 50th percentile, 33/32 in 75th percentile and 53/52 in 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1632335480&format=interactive"
  )
}}

At the median, 19 requests are sent for desktop and 18 for mobile.

### First-party vs. third-party

Of the results analyzed so far, the entire size and number of requests were being considered. In a majority of websites however, a significant portion of the JavaScript code fetched and used comes from [third-party](./third-parties) sources.

Third-party JavaScript can come from any external, third-party source. Ads, analytics and social media embeds are all common use-cases for fetching third-party scripts. So naturally, this brings us to our next question: how many requests sent are third-party instead of first-party?

{{ figure_markup(
  image="fig6.png",
  caption="Distribution of first and third-party scripts on desktop.",
  description="Bar chart showing 0/1 request on desktop are first-party and third-party respectively in 10th percentile, 2/4 in 25th percentile, 6/10 in 50th percentile, 13/21 in 75th percentile, and 24/38 in 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1108490&format=interactive"
  )
}}

{{ figure_markup(
  image="fig7.png",
  caption="Distribution of first and third party scripts on mobile.",
  description="Bar chart showing 0/1 request on mobile are first-party and third-party respectively in 10th percentile, 2/3 in 25th percentile, 5/9 in 50th percentile, 13/20 in 75th percentile, and 23/36 in 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=998640509&format=interactive"
  )
}}

For both mobile and desktop clients, more third-party requests are sent than first-party at every percentile. If this seems surprising, let's find out how much actual code shipped comes from third-party vendors.

{{ figure_markup(
  image="fig8.png",
  caption="Distribution of total JavaScript downloaded on desktop.",
  description="Bar chart showing 0/17 bytes of JavaScript are downloaded on desktop for first-party and third-party requests respectively in the 10th percentile, 11/62 in 25th percentile, 89/232 in 50th percentile, 200/525 in 75th percentile, and 404/900 in 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=633945705&format=interactive"
  )
}}

{{ figure_markup(
  image="fig9.png",
  caption="Distribution of total JavaScript downloaded on mobile.",
  description="Bar chart showing 0/17 bytes of JavaScript are downloaded on mobile for first-party and third-party requests respectively in the 10th percentile, 6/54 in 25th percentile, 83/217 in 50th percentile, 189/477 in 75th percentile, and 380/827 in 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1611383649&format=interactive"
  )
}}

At the median, 89% more third-party code is used than first-party code authored by the developer for both mobile and desktop. This clearly shows that third-party code can be one of the biggest contributors to bloat. For more information on the impact of third parties, refer to the ["Third Parties"](./third-parties) chapter.

## Resource compression

In the context of browser-server interactions, resource compression refers to code that has been modified using a data compression algorithm. Resources can be compressed statically ahead of time or on-the-fly as they are requested by the browser, and for either approach the transferred resource size is significantly reduced which improves page performance.

There are multiple text-compression algorithms, but only two are mostly used for the compression (and decompression) of HTTP network requests:

- <a hreflang="en" href="https://www.gzip.org/">Gzip</a> (`gzip`): The most widely used compression format for server and client interactions
- <a hreflang="en" href="https://github.com/google/brotli">Brotli</a> (`br`): A newer compression algorithm aiming to further improve compression ratios. <a hreflang="en" href="https://caniuse.com/#feat=brotli">90% of browsers</a> support Brotli encoding.

Compressed scripts will always need to be uncompressed by the browser once transferred. This means its content remains the same and execution times are not optimized whatsoever. Resource compression, however, will always improve download times which also is one of the most expensive stages of JavaScript processing. Ensuring JavaScript files are compressed correctly can be one of the most significant factors in improving site performance.

How many sites are compressing their JavaScript resources?

{{ figure_markup(
  image="fig10.png",
  caption="Percentage of sites compressing JavaScript resources with Gzip or Brotli.",
  description="Bar chart showing 67%/65% of JavaScript resources are compressed with Gzip on desktop and mobile respectively, and 15%/14% are compressed using Brotli.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=241928028&format=interactive"
  )
}}

The majority of sites are compressing their JavaScript resources. Gzip encoding is used on ~64-67% of sites and Brotli on ~14%. Compression ratios are similar for both desktop and mobile.

For a deeper analysis on compression, refer to the ["Compression"](./compression) chapter.

## Open source libraries and frameworks

Open source code, or code with a permissive license that can be accessed, viewed and modified by anyone. From tiny libraries to entire browsers, such as <a hreflang="en" href="https://www.chromium.org/Home">Chromium</a> and <a hreflang="en" href="https://www.openhub.net/p/firefox">Firefox</a>, open source code plays a crucial role in the world of web development. In the context of JavaScript, developers rely on open source tooling to include all types of functionality into their web page. Regardless of whether a developer decides to use a small utility library or a massive framework that dictates the architecture of their entire application, relying on open-source packages can make feature development easier and faster. So which JavaScript open-source libraries are used the most?

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
   <figcaption>{{ figure_link(caption="Top JavaScript libraries on desktop and mobile.") }}</figcaption>
</figure>

<a hreflang="en" href="https://jquery.com/">jQuery</a>, the most popular JavaScript library ever created, is used in 85.03% of desktop pages and 83.46% of mobile pages. The advent of many Browser APIs and methods, such as [Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) and [querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector), standardized much of the functionality provided by the library into a native form. Although the popularity of jQuery may seem to be declining, why is it still used in the vast majority of the web?

There are a number of possible reasons:

- <a hreflang="en" href="https://wordpress.org/">WordPress</a>, which is used in more than 30% of sites, includes jQuery by default.
- Switching from jQuery to a newer client-side library can take time depending on how large an application is, and many sites may consist of jQuery in addition to newer client-side libraries.

Other top used JavaScript libraries include jQuery variants (jQuery migrate, jQuery UI), <a hreflang="en" href="https://modernizr.com/">Modernizr</a>, <a hreflang="en" href="https://momentjs.com/">Moment.js</a>, <a hreflang="en" href="https://underscorejs.org/">Underscore.js</a> and so on.

### Frameworks and UI libraries

<p class="note">As mentioned in our <a href="./methodology#wappalyzer">methodology</a>, the third-party detection library used in HTTP Archive (Wappalyzer) has a number of limitations with regards to how it detects certain tools. There is an open issue <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">to improve detection of JavaScript libraries and frameworks</a>, which will have impacted the results presented here.</p>

In the past number of years, the JavaScript ecosystem has seen a rise in open-source libraries and frameworks to make building **single-page applications** (SPAs) easier. A single-page application is characterized as a web page that loads a single HTML page and uses JavaScript to modify the page on user interaction instead of fetching new pages from the server. Although this remains to be the main premise of single-page applications, different server-rendering approaches can still be used to improve the experience of such sites. How many sites use these types of frameworks?

{{ figure_markup(
  image="fig12.png",
  caption="Most frequently used frameworks on desktop.",
  description="Bar chart showing 4.6% of sites use React, 2.0% AngularJS, 1.8% Backbone.js, 0.8% Vue.js, 0.4% Knockout.js, 0.3% Zone.js, 0.3% Angular, 0.1% AMP, 0.1% Ember.js.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1699359221&format=interactive"
  )
}}

Only a subset of popular frameworks are being analyzed here, but it's important to note that all of them either follow one of these two approaches:

- A <a hreflang="en" href="https://developer.chrome.com/apps/app_frameworks">model-view-controller</a> (or model-view-viewmodel) architecture
- A component-based architecture

Although there has been a shift towards a component-based model, many older frameworks that follow the MVC paradigm (<a hreflang="en" href="https://angularjs.org/">AngularJS</a>, <a hreflang="en" href="https://backbonejs.org/">Backbone.js</a>, <a hreflang="en" href="https://emberjs.com/">Ember</a>) are still being used in thousands of pages. However, <a hreflang="en" href="https://reactjs.org/">React</a>, <a hreflang="en" href="https://vuejs.org/">Vue</a> and <a hreflang="en" href="https://angular.io/">Angular</a> are the most popular component-based frameworks (<a hreflang="en" href="https://github.com/angular/zone.js">Zone.js</a> is a package that is now part of Angular core).

## Differential loading

<a hreflang="en" href="https://v8.dev/features/modules">JavaScript modules</a>, or ES modules, are supported in <a hreflang="en" href="https://caniuse.com/#feat=es6-module">all major browsers</a>. Modules provide the capability to create scripts that can import and export from other modules. This allows anyone to build their applications architected in a module pattern, importing and exporting wherever necessary, without relying on third-party module loaders.

To declare a script as a module, the script tag must get the `type="module"` attribute:

```html
<script type="module" src="main.mjs"></script>
```

How many sites use `type="module"` for scripts on their page?

{{ figure_markup(
  image="fig13.png",
  caption="Percentage of sites utilizing type=module.",
  description="Bar chart showing 0.6% of sites on desktop use 'type=module', and 0.8% of sites on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1409239029&format=interactive"
  )
}}

Browser-level support for modules is still relatively new, and the numbers here show that very few sites currently use `type="module"` for their scripts. Many sites are still relying on module loaders (2.37% of all desktop sites use <a hreflang="en" href="https://github.com/requirejs/requirejs">RequireJS</a> for example) and bundlers (<a hreflang="en" href="https://webpack.js.org/">webpack</a> for example) to define modules within their codebase.

If native modules are used, it's important to ensure that an appropriate fallback script is used for browsers that do not yet support modules. This can be done by including an additional script with a `nomodule` attribute.

```html
<script nomodule src="fallback.js"></script>
```

When used together, browsers that support modules will completely ignore any scripts containing the `nomodule` attribute. On the other hand, browsers that do not yet support modules will not download any scripts with `type="module"`. Since they do not recognize `nomodule` either, they will download scripts with the attribute normally. Using this approach can allow developers to <a hreflang="en" href="https://web.dev/serve-modern-code-to-modern-browsers/">send modern code to modern browsers for faster page loads</a>. So, how many sites use `nomodule` for scripts on their page?

{{ figure_markup(
  image="fig14.png",
  caption="Percentage of sites using nomodule.",
  description="Bar chart showing 0.8% of sites on desktop use 'nomobule', and 0.5% of sites on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=781034243&format=interactive"
  )
}}

Similarly, very few sites (0.50%-0.80%) use the `nomodule` attribute for any scripts.

## Preload and prefetch

[Preload](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content) and [prefetch](https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ) are [resource hints](./resource-hints) which enable you to aid the browser in determining what resources need to be downloaded.

- Preloading a resource with `<link rel="preload">` tells the browser to download this resource as soon as possible. This is especially helpful for critical resources which are discovered late in the page loading process (e.g., JavaScript located at the bottom of your HTML) and are otherwise downloaded last.
- Using `<link rel="prefetch">` tells the browser to take advantage of any idle time it has to fetch these resources needed for future navigations

So, how many sites use preload and prefetch directives?

{{ figure_markup(
  image="fig15.png",
  caption="Percentage of sites using rel=preload for scripts.",
  description="Bar chart showing 14% of sites on desktop use rel=preload' for scripts, and 15% of sites on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=2007534370&format=interactive"
  )
}}

For all sites measured in HTTP Archive, 14.33% of desktop sites and 14.84% of mobile sites use `<link rel="preload">` for scripts on their page.

For prefetch, we have the following:

{{ figure_markup(
  image="fig16.png",
  caption="Percentage of sites using rel=prefetch for scripts.",
  description="Bar chart showing 0.08% of sites on desktop use 'rel=prefetch', and 0.08% of sites on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=547807937&format=interactive"
  )
}}

For both mobile and desktop, 0.08% of pages leverage prefetch for any of their scripts.

## Newer APIs

JavaScript continues to evolve as a language. A new version of the language standard itself, known as ECMAScript, is released every year with new APIs and features passing proposal stages to become a part of the language itself.

With HTTP Archive, we can take a look at any newer API that is supported (or is about to be) and see how widespread its usage is. These APIs may already be used in browsers that support them _or_ with an accompanying polyfill to make sure they still work for every user.

How many sites use the following APIs?

- [Atomics](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Atomics)
- [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl)
- [Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)
- [WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- [WeakSet](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)

{{ figure_markup(
  image="fig17.png",
  caption="Usage of new JavaScript APIs.",
  description="Bar chart showing 25.5%/36.2% of sites on desktop and mobile respectivdely use WeakMap, 6.1%/17.2% use WeakSet, 3.9%/14.0% use Intl, 3.9%/4.4% use Proxy, 0.4%/0.4% use Atomics, and 0.2%/0.2% use SharedArrayBuffer.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=594315296&format=interactive"
  )
}}

Atomics (0.38%) and SharedArrayBuffer (0.20%) are barely visible on this chart since they are used on such few pages.

It is important to note that the numbers here are approximations and they do not leverage <a hreflang="en" href="https://chromium.googlesource.com/chromium/src.git/+/master/docs/use_counter_wiki.md">UseCounter</a> to measure feature usage.

## Source maps

In many build systems, JavaScript files undergo minification to minimize its size and transpilation for newer language features that are not yet supported in many browsers. Moreover, language supersets like <a hreflang="en" href="https://www.typescriptlang.org/">TypeScript</a> compile to an output that can look noticeably different from the original source code. For all these reasons, the final code served to the browser can be unreadable and hard to decipher.

A **source map** is an additional file accompanying a JavaScript file that allows a browser to map the final output to its original source. This can make debugging and analyzing production bundles much simpler.

Although useful, there are a number of reasons why many sites may not want to include source maps in their final production site, such as choosing not to expose complete source code to the public. So how many sites actually include sourcemaps?

{{ figure_markup(
  image="fig18.png",
  caption="Percentage of sites using source maps.",
  description="Bar chart showing 18% of desktop sites and 17% of mobile sites use source maps.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=906754154&format=interactive"
  )
}}

For both desktop and mobile pages, the results are about the same. 17-18% include a source map for at least one script on the page (detected as a first-party script with `sourceMappingURL`).

## Conclusion

The JavaScript ecosystem continues to change and evolve every year. Newer APIs, improved browser engines, and fresh libraries and frameworks are all things we can expect to happen indefinitely. HTTP Archive provides us with valuable insight on how sites in the wild use the language.

Without JavaScript, the web would not be where it is today, and all the data gathered for this article only proves this.
