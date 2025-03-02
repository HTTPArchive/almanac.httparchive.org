---

#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: JavaScript chapter of the 2024 Web Almanac covering the usage of JavaScript on the web, libraries and frameworks, compression, web components, and source maps.
hero_alt: Hero image of the Web Almanac characters cycling to power a website.
authors: [haddiamjad]
reviewers: [tunetheweb]
editors: [tunetheweb]
analysts: [nrllh]
translators: []
results: https://docs.google.com/spreadsheets/d/16isMe5_rvmRmJHtK5Je66AhwO8SowGgq0EFqXyjEXw8/
featured_quote: Heavy dependence on JavaScript involves compromises. Each stage—from downloading and parsing to execution—demands substantial browser resources. Using too little can compromise user experience and business objectives while overusing it can lead to sluggish load times, unresponsive pages, and poor user engagement.
featured_stat_1: 14%
featured_stat_label_1: Increase in median mobile JavaScript bytes.
featured_stat_2: 47%
featured_stat_label_2: Unused median JavaScript on mobile.
featured_stat_3: 30%
featured_stat_label_3: Pages using web wokers
---

## Introduction

JavaScript is essential for creating interactive web experiences, driving everything from basic animations to advanced functionalities. Its development has significantly enhanced the web's dynamic capabilities. However, this heavy dependence on JavaScript involves compromises. Each stage—from downloading and parsing to execution—demands substantial browser resources. Using too little can compromise user experience and business objectives while overusing it can lead to sluggish load times, unresponsive pages, and poor user engagement. In this chapter, we will re-evaluate JavaScript's role on the web and offer recommendations for designing smooth, efficient user experiences.

## How much JavaScript do we load?

We will analyze the volume of JavaScript being deployed by web developers. Gaining a clear picture of the current state is crucial for driving any impactful improvements.

{{ figure_markup(
  image="median-javascript-kilobytes-per-page.png",
  caption="Median JavaScript kilobytes per page.",
  description="Bar chart of median JavaScript usage from 2019 to 2024 showing a steady increase. Median JavaScript on desktop increased from 391 kilobytes, to 444, to 463, to 509, to 538, to 613 kilobytes in 2024. On mobile, median JavaScript on desktop increased from 359 kilobytes in 2019, to 411, to 427, to 461, to 491, to 558 kilobytes in 2024.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1181894330&format=interactive",
  sheets_gid="1824580205",
  sql_file="bytes_2024.sql"
  )
}}

There has been a continuous increase in the volume of JavaScript. In 2024, this upward trend resumed, with the median JavaScript payload rising by 14%, reaching 558 kilobytes on mobile and 613 kilobytes on desktop. This ongoing trend is concerning. While device capabilities are improving, not everyone has access to the latest technology. Larger JavaScript bundles place additional strain on device resources, impacting performance, especially for users with older or less powerful hardware.

## How many JavaScript requests per page?

Every resource on a web page sparks at least one request, but it can snowball quickly if that resource starts pulling in others.

{{ figure_markup(
  image="median-javascript-requests-per-page.png",
  caption="Median JavaScript requests per page.",
  description="Bar chart of median JavaScript requests from 2019 to 2024 showing a steady increase. On desktop usage increased from 19 in 2019 to 23 in 2024, while on mobile it increased from 18 to 22 requests in the same time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2056554025&format=interactive",
  sheets_gid="342139378",
  sql_file="requests_2024.sql"
  )
}}

With script requests, the stakes are higher. The more requests you send, the more JavaScript you load—and the more likely you'll trigger a bottleneck as these scripts compete for attention on the main thread. This battle for resources can grind performance to a crawl, delaying startup and leaving users waiting.

In 2024, the median mobile page is making 22 JavaScript requests, while those in the 90th percentile soar to 68. This represents a subtle yet notable increase of one request at the median and four at the 90th percentile compared to last year.

On the desktop front, the story is similar: the median jumps to 23 JavaScript requests, with the 90th percentile climbing to 70 requests. Again, we see an increase of one request at the median and five at the 90th percentile—echoing the trends we observe in mobile.

While these increases might appear modest at first glance, they signal a continuing evolution in web-behavior. Since the Web Almanac's inception in 2019, we've witnessed a steady rise in JavaScript requests, hinting at a future where growth may substantially outpace performance improvements to counteract this. What will this mean for developers and users alike as we navigate the complexities of an increasingly JavaScript-heavy web?

{{ figure_markup(
  image="distribution-of-unused-javascript.png",
  caption="Distribution of unused JavaScript.",
  description="Bar chart showing unused JavaScript byes by percentile. On desktop it's 21 kilobytes at the 10th perccentile, 87 at the 25th, 235 at the median, 509 at the 75th, and 923 at the 90th percentile. On mobile it's 0 kilobytes at the 10th percentile, 74 at the 25th, 206 at the median, 450 at the 75th and 818 kilobytes 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=762521448&format=interactive",
  sheets_gid="1175581542",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

Along with this increase in JavaScript, we see an increase in unused bytes of JavaScript with approximately half the bytes downloaded being unused during page load (206 kilobytes—or 44% of bytes delivered—at the media on mobile).

## How is JavaScript packaged processed?

JavaScript bundling and transpiling have transformed web development by optimizing how applications are built and delivered. Bundlers like Webpack and Parcel package multiple files into a single bundle, reducing HTTP requests and improving loading times. Transpilers like Babel allow developers to use modern JavaScript features while ensuring compatibility across various browsers. However, managing these processes is crucial to avoid larger payloads that can hinder performance. Ultimately, they strike a balance between innovation and user experience, ensuring powerful yet efficient applications.

### Bundlers

JavaScript bundlers, like Webpack and Parcel, package multiple JavaScript files into a single bundle to streamline delivery to users. They analyze the code and its dependencies, optimizing the final output to reduce the number of HTTP requests. By combining files, bundlers can improve loading times and performance. However, these tools can sometimes unintentionally tangle functional code with user tracking scripts, complicating performance and privacy considerations.

{{ figure_markup(
  image="sites-using-webpack-grouped-by-rank.png",
  caption="Sites using webpack grouped by rank.",
  description="Bar chart showing webpack usage by rank. For desktop it's 15% for the top 1,000 sites, 17% for the top 10,000, 13% for the top 100,000, 9% for the top one million, 6% for the top 10 million, and 6% for all sites. For mobile it's 13% for the top 1,000 sites, 16% for the top 10,000, 13% for the top 100,000, 9% for the top million, and 5% for the top ten million and 5% for all sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=784514302&format=interactive",
  sheets_gid="1114140412",
  sql_file="usage_of_webpack_by_rank.sql"
  )
}}

While Webpack usage remains at a steady 5% across websites, recent trends reveal a decline in its adoption among the top 1,000 sites, both on mobile and desktop. Although 5% may seem modest, it still represents a substantial number of Web Almanac's sites.

{{ figure_markup(
  image="sites-using-parcel-grouped-by-rank.png",
  caption="Sites using Parcel grouped by rank.",
  description="Bar chart showing Parcel usage by rank. For desktop it's 0.32% for the top 1,000 sites, 0.40% for the top 10,000, 0.51% for the top 100,000, 0.65% for the top one million, 0.54% for the top 10 million, and 0.49% for all sites. For mobile it's 0.26% for the top 1,000 sites, 0.28% for the top 10,000, 0.43% for the top 100,000, 0.58% for the top million, and 0.44% for the top ten million and 0.34% for all sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=989440772&format=interactive",
  sheets_gid="422902451",
  sql_file="usage_of_parcel_by_rank.sql"
  )
}}

Parcel stands as the second most popular alternative to Webpack, boasting a notable adoption rate among developers. However, recent trends indicate a decline in its usage, dropping from 1.3% of mobile websites last year to just 0.3% this year. A similar pattern emerges on desktop platforms, reflecting a shift in the landscape of JavaScript bundlers.

### Transpilers

In the 2022 Web Almanac, year we [looked at transpilers as a percentage of those sites with available source maps](../2022/javascript#transpilers). This year, we've changed to the percentage of overall sites. This methodology change means we're moving from a likely over counting of sites (sites using sourcemaps are, by definition, more likely to more complex web applications than need transpilation), to an under counting (as not all sites publish public source maps).

{{ figure_markup(
  image="sites-using-babel-grouped-by-rank.png",
  caption="Sites using Babel grouped by rank.",
  description="Bar chart showing Babel usage by rank. For desktop it's 7.6% for the top 1,000 sites, 8.9% for the top 10,000, 6.9% for the top 100,000, 4.7% for the top one million, 4.1% for the top 10 million, and 5.3% for all sites. For mobile it's 9.9% for the top 1,000 sites, 12.0% for the top 10,000, 9.1% for the top 100,000, 5.8% for the top million, and 4.7% for the top ten million and 6.1% for all sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2030733123&format=interactive",
  sheets_gid="1658473552",
  sql_file="usage_of_typescript_and_babel_by_rank.sql"
  )
}}

Babel is particularly prevalent among higher-ranked websites, with 12% of the top 10,000 mobile sites using Babel (and this is 23% - 38% of sites using source maps, so similar to [last year's Babel results](../2022/javascript#fig-6)). Mobile sites consistently show higher adoption rates than desktop sites, regardless of rank. These trends highlight Babel's prominence, especially among top-tier and mobile-optimized sites, indicating its growing importance in modern web development.

#### How often is TypeScript used?

TypeScript is a superset of JavaScript that adds static types, which help catch errors during development and make the code more maintainable. These tools streamline the development process and ensure cross-browser compatibility.

{{ figure_markup(
  image="sites-using-typescript-grouped-by-rank.png",
  caption="Sites using TypeScript grouped by rank.",
  description="Bar chart showing Babel usage by rank. For desktop it's 5.2% for the top 1,000 sites, 6.7% for the top 10,000, 6.1% for the top 100,000, 5.5% for the top one million, 4.9% for the top 10 million, and 6.0% for all sites. For mobile it's 4.5% for the top 1,000 sites, 6.2% for the top 10,000, 5.7% for the top 100,000, 5.4% for the top million, and 4.9% for the top ten million and 6.2% for all sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=295342967&format=interactive",
  sheets_gid="1658473552",
  sql_file="usage_of_typescript_and_babel_by_rank.sql"
  )
}}

Across all ranks, around 6% of pages use TypeScript, with mobile generally having slightly higher adoption. Again, this only counts sites publishing sourcemaps. The usage is fairly consistent, though top-ranked pages (1,000) show slightly lower TypeScript adoption compared to lower-ranked ones.

## How is JavaScript requested?

In the fast-paced world of web development, the way JavaScript is loaded can make or break a site's performance. From synchronous loading that can slow page rendering to asynchronous techniques that boost speed, developers have a range of options at their disposal. The challenge lies in balancing the power of JavaScript's interactivity with the need for swift, seamless user experiences. By mastering optimal loading strategies, web creators can significantly enhance their sites' responsiveness and user satisfaction.

### `async`, `defer`, `module`, and `nomodule`

When optimizing JavaScript loading, developers have several powerful attributes at their disposal.

The `async` attribute allows scripts to load asynchronously while HTML parsing continues, executing them as soon as they're available. In contrast, `defer` postpones script execution until after HTML parsing is complete, maintaining the order of deferred scripts.

For modern web applications, the `module` attribute indicates that a script is a JavaScript module, enabling ES6 import/export syntax and strict mode by default. Complementing this, the `nomodule` attribute specifies fallback scripts for browsers that don't support ES6 modules, ensuring broader compatibility while allowing modern browsers to ignore these fallbacks. By strategically employing these attributes, developers can fine-tune script loading behavior to optimize page performance and user experience.

{{ figure_markup(
  image="how-is-javascript-requested.png",
  caption="How is JavaScript requested?.",
  description="Bar chart showing that on desktop, `async` is used on 87% of sites, `defer` on 48%, `async` and `defer` on 22%, `module` on 4%, `nomodule` at 0%, and neither `async` nor `defer` at 11%. For mobile it's pretty identical: `async` is used on 87% of sites, `defer` on 47%, `async` and `defer` on 22%, `module` on 4%, `nomodule` at 0%, and neither `async` nor `defer` at 11%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1907402404&format=interactive",
  sheets_gid="901949116",
  sql_file="breakdown_of_pages_using_async_defer.sql"
  )
}}

Comparing JavaScript loading trends from [the last Web Almanac 2022](../javascript/#async-defer-module-and-nomodule) to 2024 reveals notable shifts in developer practices. The use of the `async` attribute has increased significantly, from 76% to 87% of pages on both desktop and mobile. The `defer` attribute usage has seen a modest increase from 42% to 47%. The combination of `async` and `defer` attributes has decreased slightly from 28-29% to 22%, possibly due to developers choosing one method over the other.

`module` usage remains low at 4%, while `nomodule` shows xlose to zero adoption, indicating that modern JavaScript module systems are still not widely implemented across the web.

<figure>
  <table>
    <thead>
      <tr>
        <th>Attribute</th>
        <th>2022</th>
        <th>2024</th>
        <th>% change</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>async</code></td>
        <td class="numeric">47.2%</td>
        <td class="numeric">49.5%</td>
        <td class="numeric">4.8%</td>
      </tr>
      <tr>
        <td><code>defer</code></td>
        <td class="numeric">9.1%</td>
        <td class="numeric">13.0%</td>
        <td class="numeric">43.3%</td>
      </tr>
      <tr>
        <td><code>async</code> and <code>defer</code></td>
        <td class="numeric">3.1%</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">-3.0%</td>
      </tr>
      <tr>
        <td><code>module</code></td>
        <td class="numeric">0.4%</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">208.8%</td>
      </tr>
      <tr>
        <td><code>nomodule</code></td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">N/A</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="JavaScript requests by script (mobile).", sheets_gid="8375823", sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql") }}</figcaption>
</figure>

Comparing the trends on `<script>` tags from 2022 to 2024, the overall use of `async` in scripts saw a 4.8% increase, maintaining its dominance. The `defer` attribute usage, however, experienced a notable increase, where it climbed from 9.1% to 13.0% on mobile in 2024. The combination of `async` and `defer` saw a slight decrease. The `module` attribute saw a tripling in used but continues to have very low adoption across both desktop and mobile platforms.

### `preload`, `prefetch`, and `modulepreload`

Resource hints play a crucial role in optimizing browser performance by indicating which resources should be fetched early. Preload is used to fetch resources required for the current navigation, ensuring that critical assets are available as soon as they are needed. Modulepreload serves a similar purpose but specifically for preloading JavaScript modules, helping to load modular scripts efficiently. Prefetch, on the other hand, is designed for resources that will be needed in the next navigation, allowing the browser to anticipate and prepare for future page transitions.

{{ figure_markup(
  image="resource-hints-adoption-for-javascript-resources.png",
  caption="Resource hints adoption for JavaScript resources.",
  description="Bar chart of resource hint adoption for JavaScript resources. On desktop `prefetch` is used on 5.1% of pages, `preload` on 7.7%, and `modulepreload` on 0.7% of page. On mobile it's similar with `prefetch` used on 4.8% of pages, `preload` on 7.5%, and `modulepreload` on 0.7% of page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=516338021&format=interactive",
  sheets_gid="724748185",
  sql_file="resource-hints-prefetch-preload-modulepreload-percentage.sql"
  )
}}

In comparing the trends between 2022 and 2024 for resource hints adoption, `preload` usage dropped significantly from [16.4% on desktop in 2022](../2022/javascript#preload-prefetch-and-modulepreload) to 7.5% overall in 2024. `prefetch` adoption increased considerably from around 1.0% in 2022 to 4.8% overall in 2024. `modulepreload` usage stayed very minimal across both years, hovering around 0.1% in 2022 and showing a similar low percentage of 0.7% in 2024.

{{ figure_markup(
  image="distribution-of-prefetch-adoption-for-javascript-resources-per-page.png",
  caption="Distribution of `prefetch` adoption for JavaScript resources per page.",
  description="Bar chart of `prefetch` adoption for JavaScript resources by percentile. For desktop, 2 resources are prefetched at the 10th percentile, 12 at the 25th, and 15th at the 50th, 75th, and 90th percentile. For mobile, it's almost identical with 2 resources prefetched at the 10th percentile, 10 at the 25th, and 15th at the 50th, 75th, and 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=598973620&format=interactive",
  sheets_gid="1228269471",
  sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

The distribution of `prefetch` adoption for JavaScript resources (among pages that use `prefetch`) shows that the number of prefetch hints peaks at 15 prefetch hints from the median to 90th percentile.

{{ figure_markup(
  image="distribution-of-preload-adoption-for-javascript-resources-per-page.png",
  caption="Distribution of `preload` adoption for JavaScript resources per page.",
  description="Bar chart of `preload` adoption for JavaScript resources by percentile. Desktop and mobile have identical numbers with 1 resource `preloaded` at the 10th, 25th, and 50th percentiles, 3 at the 75th, and 6 at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=388378073&format=interactive",
  sheets_gid="1228269471",
  sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

Among pages that use `preload`, there is less usage with only one `preload` at the median, increasing to six at the 90th percentile.

{{ figure_markup(
  image="distribution-of-modulepreload-adoption-for-javascript-resources-per-page.png",
  caption="Distribution of `modulepreload` adoption for JavaScript resources per page.",
  description="Bar chart of `modulepreload` adoption for JavaScript resources by percentile. For desktop, 1 resource  at the 10th percentile, 4 at the 25th, and 12 at the 50th, 31 at the 75th, and 68 at the 90th percentile. For mobile it's similar with 1 resource at the 10th percentile, 4 at the 25th, and 12 at the 50th, 26 at the 75th, and 66 at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=922735274&format=interactive",
  sheets_gid="1228269471",
  sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

`modulepreload` usage is much more varied, but with low usage this is easily skewed by a few sites.

### Injected scripts

Script injection involves creating an `HTMLScriptElement` using `document.createElement` and adding it to the DOM via a DOM insertion method, or injecting `<script>` markup as a string using `innerHTML`. While common in many use cases, this practice bypasses the browser's preload scanner, making the script undetectable during the initial HTML parsing. This can negatively impact performance metrics like [Largest Contentful Paint (LCP)](https://web.dev/articles/lcp), especially if the injected script triggers long tasks or parses large amounts of markup dynamically.

{{ figure_markup(
  image="distribution-of-percentage-of-injected-scripts.png",
  caption="Distribution of percentage of injected scripts.",
  description="Bar chart of the percentage of injected scripts by percentile. For desktop it's 0% at the 10th percentile, 5% at the 25th, 24% at the median, 50% at the 75th, and 73% at the 90th percentile. For mobile it's similar with 0% at the 10th percentile, 3% at the 25th, 21% at the median, 50% at the 75th, and 70% at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=153813417&format=interactive",
  sheets_gid="1725251320",
  sql_file="distribution_of_injected_scripts.sql"
  )
}}

Comparing the two distributions of injected scripts, the 2024 graph shows a notable decrease in the percentage of injected scripts at the 50th percentile, rising from 25% in 2022 to 21% in 2024. At higher percentiles, the trend remains consistent between the two years, with 70% of scripts being injected at the 90th percentile in both 2022 and 2024. The early percentiles saw a slight uptick in injection, but overall, the pattern of script injection has remained steady at higher resource levels.

### First-party versus third-party JavaScript

First-party JavaScript is code that is directly served by and belongs to the website's domain, playing a key role in the site's functionality and user experience. In contrast, third-party JavaScript comes from external domains and is typically used for services like analytics, ads, or social media integrations. While first-party scripts have direct control and transparency, third-party scripts can introduce performance, security, and privacy risks. Managing the balance between these two types is crucial for optimizing site performance and safeguarding user data. In this section, we'll explore the distribution of first-party and third-party code and assess how modern websites are splitting their JavaScript loads across different sources.

#### Requests

{{ figure_markup(
  image="distribution-of-javascript-requests-by-host.png",
  caption="Distribution of JavaScript requests by host.",
  description="Bar chart of requests by host by percentile. It's 2 first-party and 2 third-party at the 10th percentile, 5 and 4 respectively at the 25th percentile, 11 and 10 at the 50th, 24 and 20 at the 75th, and 45 and 36 at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2046058068&format=interactive",
  sheets_gid="644448469",
  sql_file="requests_by_3p.sql"
  )
}}

Comparing the two trends, the 2024 graph shows an increase in [third-party JavaScript requests compared to 2022](../2022/javascript#first-party-versus-third-party-javascript), particularly at the 90th percentile, where third-party requests grew from 34 in 2022 to 36 in 2024. First-party requests also increased slightly, but the rise in third-party scripts is more pronounced. This increase in third-party JavaScript is concerning, as it can negatively impact performance, introduce security vulnerabilities, and pose privacy risks for users due to the lack of direct control over external scripts

#### Bytes

{{ figure_markup(
  image="distribution-of-javascript-bytes-by-host.png",
  caption="Distribution of JavaScript bytes by host.",
  description="Bar chart of bytes by percentile for mobile. At the 10th percentile it's 12 kilobytes first-party and 56 kilobytes at third-party, at the 25th it's 68 and 158, at the 50th it's 168 and 375, at the 75th it's 393 and 766, and at the 90th percentile it's 904 kilobytes first-party and 1,292 kilobytes third-party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=227593882&format=interactive",
  sheets_gid="2060931510",
  sql_file="bytes_by_3p.sql"
  )
}}

### Dynamic Imports

Dynamic `import()` offers a more flexible alternative to the traditional static import syntax, allowing it to be called from anywhere within a script, unlike static imports that are restricted to the top of a JavaScript file.

This flexibility empowers developers to "split" JavaScript code into smaller, more manageable chunks that can be loaded on-demand. By deferring the loading of non-essential code until it's actually needed, dynamic imports can significantly enhance startup performance, reducing the initial load and boosting overall efficiency.

{{ figure_markup(
  content="3.70%",
  caption="The percentage of mobile pages using dynamic `import()`.",
  classes="big-number",
  sheets_gid="100825266",
  sql_file="dynamic_import.sql",
) }}

The jump in the usage of dynamic imports on mobile pages from 0.34% to 3.70% signifies a growing adoption of this technique for performance optimization. This sharp increase highlights how developers are increasingly leveraging dynamic imports to improve load times and reduce the upfront JavaScript payload on mobile devices. By deferring non-critical scripts, websites can enhance both performance and user experience, particularly on resource-constrained mobile environments. The rise reflects an industry shift towards more efficient and on-demand loading strategies for better mobile performance.

### Web workers

Web workers are a powerful web platform feature designed to alleviate the load on the main thread by running JavaScript in the background on a separate thread. Unlike traditional scripts, web workers operate independently without direct access to the DOM, allowing them to handle intensive tasks—such as data processing or complex calculations—without affecting the UI's responsiveness. By offloading these resource-heavy operations, web workers ensure smoother performance and prevent the main thread from becoming overwhelmed, making them essential for delivering faster, more efficient web experiences.

{{ figure_markup(
  content="30%",
  caption="The number of mobile pages using web workers.",
  classes="big-number",
  sheets_gid="879412790",
  sql_file="web_workers.sql",
) }}

The increase in mobile pages utilizing web workers from 12% to 30% marks a significant shift in the adoption of this technology. This nearly threefold rise highlights how developers are increasingly leveraging web workers to offload intensive tasks, improving performance and ensuring smoother user experiences on mobile devices. With nearly a third of mobile pages now incorporating web workers, it reflects a growing recognition of the importance of keeping the main thread free for critical UI updates, ultimately driving more responsive and efficient mobile interactions.

### Worklets

Worklets are a specialized class of web workers designed to provide low-level access to rendering pipelines for tasks like painting and audio processing. While there are four types of worklets in total, only paint worklets and audio worklets are currently supported by modern browsers. A key performance advantage of worklets is their ability to run independently on separate threads, offloading resource-intensive tasks from the main thread. This not only boosts efficiency but also enhances performance by keeping the main thread free for essential operations, leading to smoother visuals and seamless audio experiences.

{{ figure_markup(
  content="0.0016%",
  caption="The percentage of mobile pages that register at least one paint worklet.",
  classes="big-number",
  sheets_gid="1929297167",
  sql_file="worklets.sql",
) }}

{{ figure_markup(
  content="0.0004%",
  caption="The percentage of mobile pages that register at least one audio worklet worklet.",
  classes="big-number",
  sheets_gid="1929297167",
  sql_file="worklets.sql",
) }}

The adoption of worklets on mobile devices remains extremely low, with paint worklets slightly higher at 0.0016%, a slight increase from the previous Web Almanac, and audio worklets used on just 0.0004% of mobile pages. These figures suggest that despite the potential benefits worklets offer for offloading tasks like audio processing and rendering, their usage is still far from mainstream in the mobile web development space. This could be due to their specialized functionality and the need for more widespread browser support and developer familiarity.

## How is JavaScript delivered?

The way JavaScript resources are delivered to browsers continues to be a critical aspect of web performance, with compression playing a significant role in reducing payload sizes and improving load times. Let's examine how JavaScript resources are being compressed and delivered across the web in 2024.

### Compression Methods

When JavaScript resources are delivered over the network, they can be compressed to reduce their transfer size. Compression is a crucial optimization technique that helps reduce bandwidth usage and improve page load times. Several compression algorithms used for JavaScript delivery include brotli (br), gzip, zstd.

While brotli offers better compression ratios than gzip, especially for text resources like JavaScript, gzip has been a web standard for many years with its broader browser support and fast compression speeds. Zstandard (zstd) is a newer compression algorithm developed by Facebook that aims to provide high compression ratios with fast compression and decompression speeds. Despite its promising capabilities, our data shows minimal adoption at just 1% of requests in 2024.

{{ figure_markup(
  image="compression-methods-of-script-resources.png",
  caption="Compression methods of script resources.",
  description="Bar chart of compression methods of script resources. For desktop it's 44% brotli (`br`), 41% gzip (`gzip`), 13% not sent and 1% Z-standard (`zstd`). For mobile it's similar with 45% brotli (`br`), 41% gzip (`gzip`), 12% not sent and 1% Z-standard (`zstd`).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1205373602&format=interactive",
  sheets_gid="2030065986",
  sql_file="compression_method.sql"
  )
}}

Turns out 2024 marks a pivotal shift in JavaScript compression trends, with Brotli (`br`) finally overtaking gzip as the most prevalent compression method. Brotli now commands 45% of mobile and 44% of desktop JavaScript requests, compared to gzip's 41% across both platforms. This is a remarkable transformation from 2022, when gzip led with 52% compared to Brotli's 34%, and an even more dramatic change from 2021's numbers (gzip: 55%, Brotli: 30.8%).

This Brotli ascendancy represents a major win for web performance, as Brotli typically achieves better compression ratios than gzip, particularly for JavaScript resources. The steady year-over-year growth in Brotli adoption (30.8% → 34% → 45%) suggests a growing recognition of its benefits among web developers and hosting providers.

{{ figure_markup(
  image="growth-of-brotli-for-compressing-javascript.png",
  caption="Growth of Brotli for compressing JavaScript.",
  description="Bar chart showing the growth of Brotli for JavaScript resources from 2019 to 2024. For desktop it's increased from 15% in 2019, 20% in 2020, 30% in 2021, 33% in 2022, and is now at 44% in 2024. For mobile it's very similar and has increased from 14% in 2019, 20% in 2020, 31% in 2021, 34% in 2022, and is now at 45% in 2024.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1695781069&format=interactive",
  sheets_gid="2030065986",
  sql_file="compression_method.sql"
  )
}}

The remaining landscape shows that about 12-13% of requests still arrive uncompressed, while the newer zstd compression method maintains a minimal 1% adoption rate across both platforms. A negligible amount of websites also seem to use a combination of compression techniques, like gzip + deflate, or br + gzip. This doesn't necessarily mean that both are being used at the same time, because using both anyway doesn't have any additional effect. What could explain the usage is either that different assets on the same page might be using different compression methods, or supporting different kind of browsers when brotli for example was not supported in all browsers.

{{ figure_markup(
  image="compression-methods-of-script-resources-by-host.png",
  caption="Compression methods of script resources by host.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=539033561&format=interactive",
  sheets_gid="271400568",
  sql_file="compression_method_by_3p.sql"
  )
}}

An interesting contrast is seen when looking at third party scripts making gzip a clear winner again. Looking at the trends, gzip is still the primary compression method used with a 60% vs 29% comparison. This shows the missed performance gains due to a lot of third-party JavaScript still being deployed without brotli compression.

{{ figure_markup(
  image="uncompressed-resources-by-host.png",
  caption="Uncompressed resources by host.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1830077596&format=interactive",
  sheets_gid="947283086",
  sql_file="compression_none_by_bytes.sql"
  )
}}

Looking at uncompressed resources across the spectrum, we see the same smaller resources of less than 5 KB that are not sent over with any compression which makes sense as applying compression on such small resources does not add much value and in fact could add the compression overhead. However, some larger first party resources are still not enjoying the benefits of any kind of compression methods, wiht 6% of scripts of 100 kilobytes or mote not being compressed at all.

### Minification

JavaScript minification is a crucial optimization technique that reduces the size of JavaScript code by eliminating unnecessary characters without changing its functionality. Think of it like taking a lengthy novel and removing all the whitespace and making character names shorter - the story remains the same, but it takes up less space. The part about making function names, variable names, class names etc. shorter is also called uglification.

For example:

```js
function calculateTotal(firstNumber, secondNumber) {
    // Add the two numbers together
    let result = firstNumber + secondNumber;
    return result;    // Return the sum
}

```
minifies into:

```js
function c(a,b){let r=a+b;return r}
```

{{ figure_markup(
  image="distribution-of-unminified-javascript-audit-scores.png",
  caption="Distribution of unminified JavaScript audit scores.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=127145587&format=interactive",
  sheets_gid="1963564843",
  sql_file="lighthouse_unminified_js.sql"
  )
}}

Here, 0.00 represents the worst score whereas 1.00 represents the best score. 62% of mobile pages are scoring between 0.9 and 1.0 on Lighthouse's minified JavaScript audit, whereas the figure for desktop pages is 60%. This means that on mobile, 38% of pages have opportunities to ship minified JavaScript, whereas that figure for desktop pages is 40%.

{{ figure_markup(
  image="unminified-javascript-bytes-per-page.png",
  caption="Unminified JavaScript bytes per page.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1457149352&format=interactive",
  sheets_gid="1469161400",
  sql_file="lighthouse_unminified_js_bytes.sql"
  )
}}

At the median, we see that pages are shipping around 12 KB of JavaScript that can be minified. By the time we get to the 75th and 90th percentiles, however, that number jumps quite a bit, from 34 KB to about 76 KB. Third-parties are pretty good throughout, up until we get to the 90th percentile, however, where they're shipping around 19 KB of unminified JavaScript.

{{ figure_markup(
  image="average-wasted-bytes-of-unminified-javascript.png",
  caption="Average wasted bytes of unminified JavaScript.",
  description="Pie chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1906849262&format=interactive",
  sheets_gid="111413017",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

When it comes to unminified JavaScript wasting bandwidth in 2024, first-party code is still the main offender. The numbers don't lie—82.7% of these wasted bytes come from an organization's own scripts, while third-party code chips in a smaller but still notable 17.3%. It's a pattern we've seen before, but it's surprising how little has changed. We often point fingers at third parties for performance issues, but the real low-hanging fruit seems to be the first party code.

Minification isn't just a checkbox—it's a must. Stripping out comments, whitespace, and unused code shrinks file sizes, which speeds up how fast a page loads. And first-party scripts are our responsibility, which if not minified leaves obvious performance gains on the table. Third parties aren't off the hook, though. That 17.3% might seem small, but unoptimized vendor scripts can drag down performance, especially on slower networks or older devices. If a third-party script isn't minified, the question really should be to ask ourselves if the tool is worth it or could we swap it for something leaner?

Every kilobyte shaved off a script means faster load times, happier users, and better SEO.

### Source Maps

Source maps remain a critical tool for developers, bridging the gap between minified production code and its original, human-readable form. They're essential for debugging but often underutilized—or misused—in practice. Let's break down the 2024 data.

{{ figure_markup(
  content="19%",
  caption="The percentage of mobile pages specifying source map comments to publicly accessible source maps.",
  classes="big-number",
  sheets_gid="591409222",
  sql_file="sourcemaps.sql",
) }}

This marks a slight uptick from previous years. In 2022, only 14% of mobile pages used source map comments, and just 0.12% leveraged headers. While adoption is inching upward, progress feels glacial. The HTTP header method remains stubbornly rare, likely due to its reliance on server configuration and developer awareness.

{{ figure_markup(
  content="0.18%",
  caption="The number of mobile pages specifying source map headers.",
  classes="big-number",
  sheets_gid="251410295",
  sql_file="sourcemap_header.sql",
) }}

Source maps themselves aren't a performance issue—browsers ignore them unless explicitly requested (e.g., via DevTools). However, their misuse can backfire:

Inline source maps (base64-encoded within production files) bloat JavaScript payloads, slowing downloads and processing.
Publicly exposed source maps risk revealing sensitive code logic or credentials if not properly scoped.

The data suggests most teams still opt for source map comments over headers. While comments are easier to implement (often automated by build tools like Webpack or Rollup), headers offer better control. For instance, headers can be conditionally served only to internal tools or authenticated users, reducing exposure of raw source code.

## Responsiveness

JavaScript affects more than just startup performance. When we rely on JavaScript to provide interactivity, those interactions are driven by event handlers that take time to execute. Depending on the complexity of interactions and the amount of scripts involved to drive them, users may experience poor input responsiveness.

### Metrics

Many metrics are used to assess responsiveness in both the lab and the field, and tools such as Lighthouse, Chrome UX Report (CrUX), and HTTP Archive track these metrics to provide a data-driven view of the current state of responsiveness on today's websites. Unless otherwise noted, all of the following graphs depict the 75th percentile—the threshold for which Core Web Vitals are determined to be passing—of that metric at the origin level.

#### Interaction to Next Paint (INP)

{{ figure_markup(
  image="distribution-of-inp-by-origin.png",
  caption="Distribution of INP by origin.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1787373547&format=interactive",
  sheets_gid="94761497",
  sql_file="inp.sql"
  )
}}

To get a comprehensive view of page responsiveness across the entire page lifecycle, we examine [Interaction to Next Paint (INP)](https://web.dev/articles/inp), which measures all keyboard, mouse, and touch interactions on a page and selects a high percentile of interaction latency to represent overall page responsiveness.

A "good" INP score is 200 milliseconds or less. At the median (50th percentile), both mobile (100 ms) and desktop (75 ms) score well within this threshold. However, at the 75th percentile, desktop (125 ms) and mobile (150 ms) approach the "needs improvement" range. By the 90th percentile, desktop (225 ms) and mobile (275 ms) exceed the "good" threshold, indicating responsiveness issues for a significant portion of websites.

#### Total Blocking Time (TBT)

{{ figure_markup(
  image="distribution-of-tbt.png",
  caption="Distribution of TBT.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2035948582&format=interactive",
  sheets_gid="1798282039",
  sql_file="tbt.sql"
  )
}}

Dovetailing into long tasks, there's the [Total Blocking Time (TBT)](https://web.dev/articles/tbt) metric, which calculates the total blocking time of long tasks during startup.

Unlike the preceding stats on INP, TBT is not sourced from real-user data. Instead, we're measuring synthetic performance in simulated desktop and mobile environments with device-appropriate CPU and network throttling enabled. As a result, we get exactly one TBT and TTI value for each page, rather than a distribution of real-user values across the entire website.

Considering that INP correlates well with TBT, it's reasonable to assume that high TBT scores may contribute to poorer INP scores. Our synthetic approach highlights a significant disparity between desktop and mobile performance, with mobile experiencing much higher blocking times due to lower processing power. At the 75th percentile, mobile pages have nearly 3.0 seconds (2,988 ms) of blocking time, indicating a poor user experience. By the 90th percentile, mobile blocking time surges to 5.95 seconds (5,950 ms), whereas desktop remains substantially lower, reinforcing the performance gap between device types.

### Long Tasks / blocking time

As you may have gleaned from the previous section, the principal cause of poor interaction responsiveness is long tasks. To clarify, a long task is any task that runs on the main thread for longer than 50 milliseconds. The length of the task beyond 50 milliseconds is that task's blocking time, which can be calculated by subtracting 50 milliseconds from the task's total time.

Long tasks are a problem because they block the main thread from doing any other work until that task is finished. When a page has lots of long tasks, the browser can feel like it's sluggish to respond to user input. In extreme cases, it can even feel like the browser isn't responding at all.

{{ figure_markup(
  image="distribution-of-number-of-long-tasks-per-page.png",
  caption="Distribution of number of long tasks per page.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=38515194&format=interactive",
  sheets_gid="539796368",
  sql_file="distribution_of_number_of_long_tasks.sql"
  )
}}

The median page encounters 14 long tasks on mobile and 3 long tasks on desktop devices. This aligns with expectations, as desktop devices typically have greater processing power and memory resources than mobile devices.

However, the situation worsens at higher percentiles. At the 75th percentile, mobile pages experience 24 long tasks, while desktop pages have 6 long tasks. By the 90th percentile, mobile pages encounter 38 long tasks, whereas desktop pages still manage significantly fewer at 11 long tasks. This highlights the challenge of optimizing JavaScript execution, particularly for mobile users who face a much higher burden of blocking tasks.

{{ figure_markup(
  image="distribution-of-long-tasks-time-per-page.png",
  caption="Distribution of long tasks time per page.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1576475306&format=interactive",
  sheets_gid="560197680",
  sql_file="distribution_of_long_tasks_time.sql"
  )
}}

It's not enough to know how many long tasks occur per page—we also need to understand the total time those tasks consume. The median mobile page has 2.37 seconds (2,366 ms) dedicated to long tasks, whereas desktop pages experience significantly less, at just a fraction of that time.

The 75th percentile paints an even worse picture for mobile users, where pages spend 4.48 seconds (4,483 ms) processing long tasks, while desktop pages remain much lower. By the 90th percentile, mobile long task time soars to 7.77 seconds (7,770 ms), highlighting a major responsiveness issue. This excessive processing time suggests a strong need for JavaScript optimizations, such as breaking up long tasks or leveraging web workers to handle intensive computations off the main thread. These results underscore the challenges mobile users face when dealing with heavy JavaScript execution.

### Scheduler API

Scheduling JavaScript tasks has historically been deferred to the browser. There are methods such as `requestIdleCallback` and `queueMicrotask`, but these APIs schedule tasks in a coarse way, and—especially in the case of `queueMicrotask`—can cause performance issues if misused. queueMicrotask runs immediately after the current script, potentially causing task starvation. Its misuse can lead to UI jank, blocking the main thread, or excessive CPU usage, impacting performance.

The Scheduler API has recently been released, and gives developers finer control over scheduling tasks based on priority—though it is currently only limited to Chromium-based browsers.

{{ figure_markup(
  content="0.65%",
  caption="The percentage of mobile pages using the Scheduler API.",
  classes="big-number",
  sheets_gid="401999176",
  sql_file="posttask_scheduler.sql",
) }}

Currently, only 0.65% desktop pages are shipping JavaScript that uses the Scheduler API, a significant increase from [0.002% last time we looked](../2022/javascript#scheduler-api). On mobile, 0.81% of pages now utilize this feature. This growth from 2022 suggests that as documentation improves and support expands, developers are increasingly integrating the Scheduler API into their applications. The rising adoption, especially in frameworks, indicates a shift towards more efficient scheduling and performance optimization in JavaScript execution. We expect this trend to continue, ultimately contributing to better user experience outcomes.

### Synchronous XHR

AJAX—or usage of the XMLHttpRequest (XHR) has a flag that allows you to make synchronous requests. Synchronous XHR is harmful for performance because the event loop and main thread is blocked until the request is finished, resulting in the page hanging until the data becomes available. `fetch` is a much more effective and efficient alternative with a simpler API, and has no support for synchronous fetching of data.

{{ figure_markup(
  content="2.15%",
  caption="The percentage of mobile pages using synchronous XHR.",
  classes="big-number",
  sheets_gid="1982786595",
  sql_file="sync_requests.sql",
) }}

Synchronous XHR is now used on 2.15% of mobile pages and 2.22% of desktop pages, marking a small decline from 2022 (2.5% and 2.8% respectively). While its usage is decreasing, its continued presence—even at these levels—indicates that some legacy applications still rely on this outdated method, which negatively impacts user experience.

### `document.write`

The only `document.write` API is very problematic for a number of reasons that [the HTML spec itself warns against its use](https://html.spec.whatwg.org/multipage/dynamic-markup-insertion.html#document.write()).

{{ figure_markup(
  content="12%",
  caption="The number of mobile pages using `document.write`.",
  classes="big-number",
  sheets_gid="1535345080",
  sql_file="usage_of_document_write.sql",
) }}

A notable 12% of mobile pages observed are still using `document.write` to add content to the DOM instead of proper insertion methods. On desktop, 13% of pages continue to rely on this approach. This marks a decline from 2022 (18% and 17%), suggesting that more developers are moving away from this inefficient method. However, legacy applications and third-party scripts still contribute to its usage.

### Legacy Javascript

Lighthouse currently checks for Babel transforms that may be unnecessary on the modern web, such as transforming use of `async` and `await`, JavaScript classes, and other newer, yet widely supported language features.

{{ figure_markup(
  content="67%",
  caption="The percentage of mobile pages that ship legacy JavaScript.",
  classes="big-number",
  sheets_gid="265685844",
  sql_file="usage_of_legacy_javascript.sql",
) }}

Just over two-thirds of mobile pages are still shipping JavaScript resources that are being transformed or contain unnecessary legacy JavaScript. This figure remains unchanged from 2022, indicating that despite awareness of performance issues, many pages continue to rely on these transformations. On desktop, 70% of pages are still shipping these transforms.

Despite a negligible change in this statistic from 2022, we hope to see a decline over time as JavaScript's evolution stabilizes and developers adopt more efficient practices.

## How is JavaScript used?

JavaScript can be used directly, or via abstractions such as libraries and frameworks.

### Library usage

To understand the usage of libraries and frameworks, HTTP Archive uses [Wappalyzer](./methodology#wappalyzer) to detect the technologies used on a page.

{{ figure_markup(
  image="adoption-of-top-libraries-and-frameworks.png",
  caption="Adoption of top libraries and frameworks.",
  description="Bar chart of TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=400487834&format=interactive",
  sheets_gid="345976742",
  sql_file="frameworks_libraries.sql",
  width=600,
  height=491
  )
}}

Readers of previous editions of the Web Almanac will not be surprised to see that jQuery still remains the most widely used library on the web, appearing on 74% of pages. A significant portion of this is due to WordPress, but even outside of WordPress, jQuery continues to be a dominant choice for many websites.

The widespread adoption of core-js (41%) is also expected, as many web applications rely on Babel, which often uses core-js to provide polyfills for missing JavaScript features. As browsers continue to evolve and support more modern features natively, this number should decline, reducing unnecessary bytes in web applications.

jQuery Migrate is present on 33% of pages, indicating that a large number of websites are still relying on older jQuery versions. Similarly, jQuery UI is still in use on 22% of pages, despite being mostly deprecated.

Other notable libraries include Swiper (15%), Lodash (11%), and Modernizr (11%), all of which play roles in handling UI elements and feature detection.

React usage has grown slightly to 10%, compared to 8% last year, but this still suggests a relatively stable adoption rate. This may indicate that while React remains popular, its growth has plateaued due to increasing competition in the JavaScript ecosystem.

Meanwhile, libraries like GSAP (9%), OWL Carousel (8%), Slick (8%), LazySizes (8%), and FancyBox (7%) continue to be widely used, especially in performance and animation-heavy applications.

As the web ecosystem continues to modernize, we expect some of these legacy libraries, especially jQuery-based ones, to decline over time in favor of more native solutions and modern frameworks.

### Libraries used together

It's not an uncommon scenario to see multiple frameworks and libraries used on the same page. As with last year, we'll examine this phenomenon to gain insight into how many libraries and frameworks have been used together in 2024.

<figure>
  <table>
    <thead>
      <tr>
        <th>apps</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">7.57%</td>
        <td class="numeric">7.61%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">3.71%</td>
        <td class="numeric">3.91%</td>
      </tr>
      <tr>
        <td>core-js, jQuery</td>
        <td class="numeric">1.71%</td>
        <td class="numeric">1.67%</td>
      </tr>
      <tr>
        <td>GSAP, Lodash, React</td>
        <td class="numeric">1.25%</td>
        <td class="numeric">1.50%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">1.71%</td>
        <td class="numeric">1.48%</td>
      </tr>
      <tr>
        <td>core-js, jQuery, jQuery Migrate</td>
        <td class="numeric">1.33%</td>
        <td class="numeric">1.29%</td>
      </tr>
      <tr>
        <td>Swiper, core-js, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">1.10%</td>
        <td class="numeric">1.22%</td>
      </tr>
      <tr>
        <td>core-js, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td>Lodash, Modernizr, Stimulus, YUI, core-js</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">0.88%</td>
      </tr>
      <tr>
        <td>core-js</td>
        <td class="numeric">0.73%</td>
        <td class="numeric">0.75%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Common library combinations.", sheets_gid="86789973", sql_file="frameworks_libraries_combos.sql") }}</figcaption>
</figure>

It's clear though that jQuery has some serious staying power, with some combination of it, its UI framework, and its migration plugin occurring in the top seven spots, with core-js having a prominent role in library usage as well.

## Web Components and Shadow DOM

For some time, web development has been driven by a componentization model employed by numerous frameworks. The web platform has similarly evolved to provide encapsulation of logic and styling through web components and the shadow DOM. To kick off this year's analysis, we'll begin with custom elements.

{{ figure_markup(
  content="7.8%",
  caption="The percentage of desktop pages that used custom elements.",
  classes="big-number",
  sheets_gid="455028778",
  sql_file="web_components_pct.sql",
) }}

This figure has increased from the 2022 analysis of custom element usage on desktop pages, which was 2.0%. With the advantages that custom elements provide and their reasonably broad support in modern browsers, we're encouraged to see the growing adoption of the web component model. This trend suggests that developers are increasingly leveraging web platform built-ins to create faster user experiences.

{{ figure_markup(
  content="2.5%",
  caption="The percentage of mobile pages that used shadow DOM.",
  classes="big-number",
  sheets_gid="455028778",
  sql_file="web_components_pct.sql",
) }}

Shadow DOM allows you to create dedicated nodes in a document that contain their own scope for sub-elements and styling, isolating a component from the main DOM tree. Compared to the 2022 figure of 0.39% of mobile pages using shadow DOM, adoption of the feature has significantly increased, reaching 2.51% in 2024. This growth indicates a rising trend in developers leveraging shadow DOM for better component encapsulation and styling consistency.

{{ figure_markup(
  content="0.28%",
  caption="The percentage of mobile pages that use templates.",
  classes="big-number",
  sheets_gid="455028778",
  sql_file="web_components_pct.sql",
) }}

The template element helps developers reuse markup patterns. Their contents render only when referenced by JavaScript. Templates work well with web components, as the content that is not yet referenced by JavaScript is then appended to a shadow root using the shadow DOM.

Roughly 0.28% of web pages on mobile are currently using the template element, a notable increase from 0.05% in 2022. Though templates are well-supported in browsers, their adoption remains relatively low but is showing signs of growth.

{{ figure_markup(
  content="0.29%",
  caption="The percentage of mobile pages that used the `is` attribute.",
  classes="big-number",
  sheets_gid="1947715772",
  sql_file="web_components_is_attribute.sql",
) }}

The HTML `is` attribute is an alternate way of inserting custom elements into the page. Rather than using the custom element's name as the HTML tag, the name is passed to any standard HTML element, which implements the web component logic. The `is` attribute is a way to use web components that can still fall back to standard HTML element behavior if web components fail to be registered on the page.

In 2024, the adoption of the `is` attribute has increased to 0.29% from 0.08% in 2022. Despite this growth, its usage remains lower than custom elements themselves. Due to the lack of support in Safari, browsers on iOS and macOS cannot utilize the attribute, possibly contributing to its limited adoption.

## Conclusion

The state of JavaScript continues to follow expected trends—its usage keeps growing, but so do efforts to mitigate its impact. Developers are increasingly leveraging minification, resource hints, compression, and smarter dependency management to balance performance and functionality.

However, our growing reliance on JavaScript raises concerns for web performance and user experience. Reducing unnecessary script execution and optimizing delivery remain crucial challenges. As the web platform evolves, we hope to see greater adoption of native APIs where feasible, while frameworks continue to improve their efficiency and embrace performance-conscious best practices.

Looking ahead, a meaningful shift in the trend would require a collective push toward better tooling, best practices, and awareness. Until then, we must remain diligent in optimizing JavaScript delivery—ensuring a fast, resilient web for all users.
