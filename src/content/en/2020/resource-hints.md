---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Resource Hints
description: Resource Hints chapter of the 2020 Web Almanac covering usage of dns-prefetch, preconnect, preload, prefetch, Priority Hints, and native lazy loading.
authors: [Zizzamia]
reviewers: [jessnicolet, pmeenan, giopunt, mgechev, notwillk]
analysts: [khempenius]
editors: [exterkamp]
translators: []
Zizzamia_bio: Leonardo is a Staff Software Engineer at <a hreflang="en" href="https://www.coinbase.com/">Coinbase</a>, leading web performance and growth initiatives. He curates the <a hreflang="en" href="https://ngrome.io">NGRome Conference</a>. Leo also maintains the <a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a> library, which helps companies prioritize roadmaps and make better business decisions through performance analytics.
discuss: 2057
results: https://docs.google.com/spreadsheets/d/1lXjd8ogB7kYfG09eUdGYXUlrMjs4mq1Z7nNldQnvkVA/
featured_quote: During the past year resource hints increased in adoption, and they have become essential APIs for developers to have more granular control over many aspects of resource prioritizations and ultimately, user experience.
featured_stat_1: 33%
featured_stat_label_1: Sites using `dns-prefetch`
featured_stat_2: 9%
featured_stat_label_2: Sites using `preload`
featured_stat_3: 4.02%
featured_stat_label_3: Sites using native lazy loading
---

## Introduction

Over the past decade <a hreflang="en" href="https://www.w3.org/TR/resource-hints/">resource hints</a> have become essential primitives that allow developers to improve page performance and therefore the user experience.

Preloading resources and having browsers apply some intelligent prioritization is something that was actually started way back in 2009 by IE8 with something called the <a hreflang="en" href="https://speedcurve.com/blog/load-scripts-async/">preloader</a>. In addition to the HTML parser, IE8 had a lightweight look-ahead preloader that scanned for tags that could initiate network requests (`<script>`, `<link>`, and `<img>`).

Over the following years, browser vendors did more and more of the heavy lifting, each adding their own special sauce for how to prioritize resources. But it's important to understand that the browser alone has some limitations. As developers however, we can overcome these limits by making good use of resource hints and help decide how to prioritize resources, determining which should be fetched or preprocessed to further boost page performance.

In particular we can mention a few of the victories resource hints achieved/made in the last year:
- <a hreflang="en" href="https://www.zachleat.com/web/css-tricks-web-fonts/">CSS-Tricks</a> web fonts showing up faster on a 3G first render.
- <a hreflang="en" href="https://www.youtube.com/watch?v=4QqlGgF8Y2I&t=1469">Wix.com</a> using resource hints got 10% improvement for FCP.
- <a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">Ironmongerydirect.co.uk</a> used preconnect to improve product image loading by 400ms at the median and greater than 1s at the 95th percentile.
- <a hreflang="en" href="https://engineering.fb.com/2020/05/08/web/facebook-redesign/">Facebook.com</a> used preload for faster navigation.

Let's take a look at most predominant resource hints supported by most browsers today: `dns-prefetch`, `preconnect`, `preload`, `prefetch`, and native lazy loading.

When working with each individual hint we advise to always measure the impact before and after in the field, by using libraries like <a hreflang="en" href="https://github.com/GoogleChrome/web-vitals">WebVitals</a>, <a hreflang="en" href="https://github.com/zizzamia/perfume.js">Perfume.js</a>, or any other utility that supports the Web Vitals metrics.

### `dns-prefetch`

<a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/">`dns-prefetch`</a> helps resolve the IP address for a given domain ahead of time. As the <a hreflang="en" href="https://caniuse.com/link-rel-dns-prefetch">oldest</a> resource hint available, it uses minimal CPU and network resources compared to `preconnect`, and helps the browser to avoid experiencing the "worst-case" delay for DNS resolution, which can be <a hreflang="en" href="https://www.chromium.org/developers/design-documents/dns-prefetching">over 1 second</a>.

```html
<link rel="dns-prefetch" href="https://www.googletagmanager.com/">
```

Be mindful when using `dns-prefetch` as even if they are lightweight to do it's easy to exhaust browser limits for the number of concurrent in-flight DNS requests allowed (Chrome still has a <a hreflang="en" href="https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353">limit of 6</a>).

### `preconnect`

<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">`preconnect`</a> helps resolve the IP address and open a TCP/TLS connection for a given domain ahead of time. Similar to `dns-prefetch` it is used for any cross-origin domain and helps the browser to warm up any resources used during the initial page load.

```html
<link rel="preconnect" href="https://www.googletagmanager.com/">
```

Be mindful when you use `preconnect`:

- Only warm up the most frequent and significant resources.
- Avoid warming up origins used too late in the initial load.
- Use it for no more than three origins because it can have CPU and battery cost.

Lastly, `preconnect` is not available for <a hreflang="en" href="https://caniuse.com/?search=preconnect">Internet Explorer or Firefox</a>, and <a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/#resolve-domain-name-early-with-reldns-prefetch">using `dns-prefetch` as a fallback</a> is highly advised.

### `preload`

The <a hreflang="en" href="https://web.dev/uses-rel-preload/">`preload`</a> hint initiates an early request. This is useful for loading important resources that would otherwise be discovered late by the parser.

```html
<link rel="preload" href="style.css" as="style">
<link rel="preload" href="main.js" as="script">
```

Be mindful of what you are going to `preload`, because it can delay the download of other resources, so use it only for what is most critical to help you improve the Largest Contentful Paint (<a hreflang="en" href="https://web.dev/lcp/">LCP</a>). Also, when used on Chrome, it tends to over-prioritize `preload` resources and potentially dispatches preloads before other critical resources.

Lastly, if used in a HTTP response header, some CDN's will also automatically turn a `preload` into a [HTTP/2 push](#http2-push) which can over-push cached resources.

### `prefetch`

The <a hreflang="en" href="https://web.dev/link-prefetch/">`prefetch`</a> hint allows us to initiate low-priority requests we expect to be used on the next navigation. The hint will download the resources and drop it into the HTTP cache for later usage. Important to notice, `prefetch` will not execute or otherwise process the resource, and to execute it the page will still need to call the resource by the `<script>` tag.

```html
<link rel="prefetch" as="script" href="next-page.bundle.js">
```

There are a variety of ways to implement a resource's prediction logic, it could be based on signals like user mouse movement, common user flows/journeys, or even based on a combination of both on top of machine learning.

Be mindful, depending on the <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues#current-status">quality</a> of HTTP/2 prioritization of the CDN used, `prefetch` prioritization could either improve performance or make it slower, by over prioritizing `prefetch` requests and taking away important bandwidth for the initial load. Make sure to double check the CDN you are using and adapt to take into consideration some of the best practices shared in <a hreflang="en" href="https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/">Andy Davies's</a> article.

### Native lazy loading

The <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">native lazy loading</a> hint is a native browser API for deferring the load of offscreen images and iframes. By using it, assets that are not needed during the initial page load will not initiate a network request, this will reduce data consumption and improve page performance.

```html
<img src="image.png" loading="lazy" alt="…" width="200" height="200">
```

Be mindful Chromium's implementation of lazy-loading thresholds logic historically has been quite <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds">conservative</a>, keeping the offscreen limit to 3000px. During the last year the limit has been actively tested and improved on to better align developer expectations, and ultimately moving the thresholds to 1250px. Also, there is <a hreflang="en" href="https://github.com/whatwg/html/issues/5408">no standard across the browsers</a> and no ability for web developers to override the default thresholds provided by the browsers, yet.

## Resource hints

Based on the HTTP Archive, let's jump into analyzing the 2020 trends, and compare the data with the previous 2019 dataset.

### Hints adoption

More and more web pages are using the main resource hints, and in 2020 we are seeing the adoption remains consistent between desktop & mobile.

{{ figure_markup(
  image="adoption-of-resource-hints.png",
  caption="Adoption of resource hints.",
  description="A bar chart of the rate of resource hint adoption broken down by hint type and form factor. For desktop, 33% of pages use the `dns-prefetch` resource hint, 18% use `preload`, 8% use `preconnect`, 3% use `prefetch`, and less than 1% use `prerender`. Mobile is similar, except that `dns-prefetch` has 34% usage (1% higher), and `preconnect` has 9% (1% higher).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1550112064&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

The relative popularity of `dns-prefetch` with 33% adoption compared with other resource hints is unsurprising as it first appeared in 2009, and has the widest support out of all major resource hints.

Compared to [2019](../2019/resource-hints#resource-hints) the `dns-prefetch` had a 4% increase in Desktop adoption. We saw a similar increase for `preconnect` as well. One key reason this was the largest growth between all hints, is the clear and useful advice the <a hreflang="en" href="https://web.dev/uses-rel-preconnect/">Lighthouse audit</a> is giving on this matter. Starting from this year's report we also introduce how the latest dataset performs against Lighthouse recommendations.

{{ figure_markup(
  image="resource-hint-adoption-2019-vs-2020.png",
  caption="Adoption of resource hints 2019 vs 2020.",
  description="A bar chart comparing the rate of resource hint adoption in mobile between 2019 and 2020, broken down by hint type. It shows an increase in usage in almost every resource hint type. `dns-prefetch` increased 5%, from 29% to 34%. `preload` increased 2%, from 16% to 18%. `preconnect` increased 5%, from 4% to 9%. `prefetch` remained flat at 3% usage. `prerender` also remained flat at less than 1% usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1494186122&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

`preload` usage has had a slower growth with only a 2% increase from 2019. This could be in part because it requires a bit more specification. While you only need the domain to use `dns-prefetch` and `preconnect`, you must specify the resource to use `preload`. While `dns-prefetch` and `preconnect` are reasonably low risk, though still can be abused, `preload` has a much greater potential to actually damage performance if used incorrectly.

`prefetch` is used by 3% of sites on Desktop, making it the least widely used resource hint. This low usage may be explained by the fact that `prefetch` is useful for improving subsequent, rather than current, page loads. Thus, it will be overlooked if a site is only focused on improving its landing page, or the performance of the first page viewed. In the coming years with a more clear definition on what to measure for improving subsequent page experience, it could help teams prioritize `prefetch` adoption with clear performance quality goals to reach.

### Hints per page

Across the board developers are learning how to better use resource hints, and compared to [2019](../2019/resource-hints#resource-hints) we've seen an improved use of `preload`, `prefetch`, and `preconnect`. For expensive operations like preload and preconnect the median usage on desktop decreased from 2 to 1. We have seen the opposite for loading future resources with a lower priority with `prefetch`, with an increase from 1 to 2 in median per page.

{{ figure_markup(
  image="median-number-of-hints-per-page.png",
  caption="Median number of hints per page.",
  description="A bar chart showing the median number of resource hints present per page broken down by resource hint type and form factor. `preload` and `prerender` both have (median) one hint per page on both mobile and desktop. `prefetch` and `dns-prefetch` both have (median) two hints per page on both mobile and desktop. `preconnect` has (median) one hint per page on desktop, and (median) two hints per page on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=320451644&format=interactive",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

Resource hints are most effective when they're used selectively ("when everything is important, nothing is"). Having a more clear definition of what resources help improve critical rendering, versus future navigation optimizations, can move the focus away from using `preconnect` and more towards `prefetch` by shifting some of the resource prioritization and freeing up bandwidth for what most helps the user at first.

However, this hasn't stopped some misuse of the `preload` hint, since in one instance we discovered a page dynamically adding the hint and causing an infinite loop that created over 20k new preloads.

{{ figure_markup(
  caption="The most preload hints on a single page.",
  content="20,931",
  classes="big-number",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

As we create more and more automation with resource hints, be cautious when dynamically injecting preload hints - or any elements for that matter!

### The `as` attribute

With `preload` and `prefetch`, it's crucial to use the `as` attribute to help the browser prioritize the resource more accurately. Doing so allows for proper storage in the cache for future requests, applying the correct Content Security Policy ([CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)), and setting the correct `Accept` request headers.

With `preload` many different content-types can be preloaded and the [full list](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#Attributes) follows the recommendations made in the Fetch <a hreflang="en" href="https://fetch.spec.whatwg.org/#concept-request-destination">spec</a>. The most popular is the `script` type with 64% usage. This is likely related to a large group of sites built as Single Page Apps that need the main bundle as soon as possible to start downloading the rest of their JS dependencies. Subsequent usage comes from font at 8%, style at 5%, image at 1%, and fetch at 1%.

{{ figure_markup(
  image="mobile-as-attribute-values-by-year.png",
  caption="Mobile `as` attribute values by year.",
  description="A bar chart comparing the rate of `as` attribute values on mobile pages from 2019 and 2020, broken down by `as` attribute value. The majority of `as` values are `script` with 81% usage in 2019 and 64% usage in 2020. `script` usage fell 17% year over year, while all other values increased in usage. `not set` increased 8%, `font` increased 5%, `style` increased 2%, the rest of the notable values are 1% or less for both years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=903180926&format=interactive",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

Compared to the trend in [2019](../2019/resource-hints#the-as-attribute), we've seen rapid growth in font and style usage with the `as` attribute. This is likely related to developers increasing the priority of critical CSS and also combining `preload` fonts with `display:optional` to <a hreflang="en" href="https://web.dev/optimize-cls/#web-fonts-causing-foutfoit">improve</a> Cumulative Layout Shift (<a hreflang="en" href="https://web.dev/cls/">CLS</a>).

Be mindful that omitting the `as` attribute, or having an invalid value will make it harder for the browser to determine the correct priority and in some cases, such as scripts, can even cause the resource to be fetched twice.

### The `crossorigin` attribute

With `preload` and `preconnect` resources that have CORS enabled, such as fonts, it's important to include the `crossorigin` attribute, in order for the resource to be properly used. If the `crossorigin` attribute is absent, the request will follow the single-origin policy thereby making the use of preload useless.

{{ figure_markup(
  caption="The percent of elements with `preload` that use `crossorigin`.",
  content="16.96%",
  classes="big-number",
  sheets_gid="1185042785",
  sql_file="attribute_usage.sql"
) }}

The latest trends show that 16.96% of elements that `preload` also set `crossorigin` and load in anonymous (or equivalent) modes, and only 0.02% utilize the `use-credentials` case. This rate has increased in conjunction with the increase in font-preloading, as mentioned earlier.

```html
<link rel="preload" href="ComicSans.woff2" as="font" type="font/woff2" crossorigin>
```

Be mindful that fonts preloaded without the `crossorigin` attribute will be fetched <a hreflang="en" href="https://web.dev/preload-critical-assets/#how-to-implement-relpreload">twice</a>!

### The `media` attribute

When it's time to choose a resource for use with different screen sizes, reach for the `media` attribute with `preload` to optimize your media queries.

```html
<link rel="preload" href="a.css" as="style" media="only screen and (min-width: 768px)">
<link rel="preload" href="b.css" as="style" media="screen and (max-width: 430px)">
```

Seeing over 2,100 different combinations of media queries in the 2020 dataset encourages us to consider how wide the variance is between concept and implementation of responsive design from site to site. The ever popular `767px/768px` breakpoints (as popularized by Bootstrap amongst others) can be seen in the data.

### Best practices

Using resource hints can be confusing at times, so let's go over some quick best practices to follow based on Lighthouse's automated audit.

To safely implement `dns-prefetch` and `preconnect` make sure to have them in separate links tags.

```html
<link rel="preconnect" href="http://example.com">
<link rel="dns-prefetch" href="http://example.com">
```

Implementing a `dns-prefetch` fallback in the same `<link>` tag causes a <a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=197010">bug</a> in Safari that cancels the `preconnect` request. Close to 2% of pages (~40k) reported the issue of both `preconnect` & `dns-prefetch` in a single resource.

In the case of "<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">Preconnect to required origins</a>" audit, we saw only 19.67% of pages passing the test, creating a large opportunity for thousands of websites to start using `preconnect` or `dns-prefetch` to establish early connections to important third-party origins.

{{ figure_markup(
  caption="The percent of pages that pass the `preconnect` Lighthouse audit.",
  content="19.67%",
  classes="big-number",
  sheets_gid="152449420",
  sql_file="lighthouse_preconnect.sql"
) }}

Lastly, running Lighthouse's "<a hreflang="en" href="https://web.dev/uses-rel-preload/">Preload key requests</a>" audit resulted in 84.6% of pages passing the test. If you are looking to use `preload` for the first time, remember, fonts and critical scripts are a good place to start.

### Native Lazy Loading

Now let's celebrate the first year of the <a hreflang="en" href="https://addyosmani.com/blog/lazy-loading/">Native Lazy Loading</a> API, which at the time of publishing already has over <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">72%</a> browser support. This new API can be used to defer the load of below-the-fold iframes and images on the page until the user scrolls near them. This can reduce data usage, memory usage, and helps speed up above-the-fold content. Opting-in to lazy load is as simple as adding `loading=lazy`  on `<iframe>` or `<img>` elements.

{{ figure_markup(
  caption="The percent of pages using native lazy loading.",
  content="4.02%",
  classes="big-number",
  sheets_gid="2039808014",
  sql_file="native_lazy_loading_attrs.sql"
) }}

Adoption is still in its early days, especially with the official thresholds earlier this year being too conservative, and only <a hreflang="en" href="https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/">recently</a> aligning with developer expectations. With almost 72% of browsers supporting native image/source lazy loading, this is another area of opportunity especially for pages looking to improve data usage and performance on low-end devices.

Running Lighthouse's "<a hreflang="en" href="https://web.dev/offscreen-images/">Defer offscreen images</a>" audit resulted in 68.65% of pages passing the test. For those pages there is an opportunity to lazy-load images after all critical resources have finished loading.

Be mindful to run the audit on both desktop and mobile as images may move off screen when the viewport changes.

## Predictive prefetching

Combining `prefetch` with machine learning can help improve the performance of subsequent page(s). One solution is <a hreflang="en" href="https://github.com/guess-js/guess">Guess.js</a> which made the initial breakthrough in predictive-prefetching, with over a dozen websites already using it in production.

<a hreflang="en" href="https://web.dev/predictive-prefetching/">Predictive prefetching</a> is a technique that uses methods from data analytics and machine learning to provide a data-driven approach to prefetching. Guess.js is a library that has predictive prefetching support for popular frameworks (Angular, Nuxt.js, Gatsby, and Next.js) and you can take advantage of it today. It ranks the possible navigations from a page and prefetches only the JavaScript that is likely to be needed next.

Depending on the training set, the prefetching of Guess.js comes with over 90% accuracy.

Overall, predictive prefetching is still uncharted territory, but combined with prefetching on mouse over and Service Worker prefetching, it has great potential to provide instant experiences for all users of the website, while saving their data.

## HTTP/2 Push

[HTTP/2](./http) has a feature called "server push" that can potentially improve page performance when your product experiences long Round Trip Times([RTTs](https://developer.mozilla.org/en-US/docs/Glossary/Round_Trip_Time_(RTT))) or server processing. In brief, rather than waiting for the client to send a request, the server preemptively pushes a resource that it predicts the client will request soon afterwards.

{{ figure_markup(
  caption="The percent of HTTP/2 Push pages using `preload`/`nopush`.",
  content="75.36%",
  classes="big-number",
  sheets_gid="308166349",
  sql_file="h2_preload_nopush.sql"
) }}

HTTP/2 Push is often initiated through the `preload` link header. In the 2020 dataset we have seen 1% of mobile pages using HTTP/2 Push, and of those 75% of preload header links use the `nopush` option in the page request. This means that even though a website is using the `preload` resource hint, the majority prefer to use just this and disable HTTP/2 pushing of that resource.

It's important to mention that HTTP/2 Push can also damage performance if not used correctly which probably explains why it is often disabled.

One solution to this, is to use the <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL Pattern</a> which stands for **Push** (or preload) the critical resources, **Render** the initial route as soon as possible, **Pre-cache** remaining assets, and **Lazy-load** other routes and non-critical assets. This is possible only if your website is a Progressive Web App and uses a Service Worker to improve the caching strategy. By doing this, all subsequent requests never even go out to the network and so there's no need to push all the time and we still get the best of both worlds.

## Service Workers

For both `preload` and `prefetch` we've had an increase in adoption when the page is controlled by a <a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers">Service Worker</a>. This is because of the potential to both improve the resource prioritization by preloading when the Service Worker is not active yet and intelligently prefetching future resources while letting the Service Worker cache them before they're needed by the user.

{{ figure_markup(
  image="resource-hint-adoption-onservice-worker-pages.png",
  caption="Resource hint adoption on Service Worker pages.",
  description="A bar chart of the rate of resource hint adoption on Service Worker pages broken down by hint type and form factor. For desktop, 29% of pages use the `dns-prefetch` resource hint, 47% use `preload`, 34% use `preconnect`, 10% use `prefetch`, and less than 1% use `prerender`. Mobile is similar, except that `dns-prefetch` has 30% usage (1% higher), and `preconnect` has 34% (13% lower).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=252958553&format=interactive",
  sheets_gid="691299508",
  sql_file="adoption_service_workers.sql"
) }}

For `preload` on desktop we have an outstanding 47% rate of adoption and `prefetch` a 10% rate of adoption. In both cases the data is much higher compared to average adoption without a Service Worker.

As mentioned earlier, the <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL Pattern</a> will play a significant role in the coming years in how we combine resource hints with the Service Worker caching strategy.

## Future

Let's dive into a couple of experimental hints. Very close to release we have Priority Hints, which is actively experimented with in the web community. We also have the 103 Early Hints in HTTP/2, which is still in early inception and there are a few players like <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">Chrome and Fastly collaborating for upcoming test trials</a>.

### Priority hints

<a hreflang="en" href="https://developers.google.com/web/updates/2019/02/priority-hints">Priority hints</a> are an API for expressing the fetch priority of a resource: high, low, or auto. They can be used to help deprioritize images (e.g. inside a Carousel), re-prioritize scripts, and even help de-prioritize fetches.

This new hint can be used either as an HTML tag or by changing the priority of fetch requests via the `importance` option, which takes the same values as the HTML attribute.

```html
<!-- We want to initiate an early fetch for a resource, but also deprioritize it -->
<link rel="preload" href="/js/script.js" as="script" importance="low">

<!-- An image the browser assigns "High" priority, but we don't actually want that. -->
<img src="/img/in_view_but_not_important.svg" importance="low" alt="I'm not important!">
```

With `preload` and `prefetch`, the priority is set by the browser depending on the type of resource. By using Priority Hints we can force the browser to change the default option.

{{ figure_markup(
  caption="The percent of Priority Hint adoption on mobile.",
  content="0.77%",
  classes="big-number",
  sheets_gid="1596669035",
  sql_file="priority_hints.sql"
) }}

So far only 0.77% websites adopted this new hint as Chrome is still <a hreflang="en" href="https://www.chromestatus.com/features/5273474901737472">actively</a> experimenting, and at the time of this article's release the feature is on-hold.

The largest use is with script elements, which is unsurprising as the number of JS primary and third-party files continues to grow.

{{ figure_markup(
  caption="The percent of mobile resources with a hint that use the `low` priority.",
  content="16%",
  classes="big-number",
  sheets_gid="1098063134",
  sql_file="priority_hints_by_importance.sql"
) }}

The data shows us that 83% of resources using Priority Hints use a "high" priority on mobile, but something we should pay even more attention to is the 16% of resources with "low" priority.

Priority hints have a clear advantage as a tool to prevent wasteful loading via the "low" priority by helping the browser decide what to de-prioritize and giving back significant CPU and bandwidth to complete critical requests first, rather than as a tactic to try to get resources loaded more quickly with the "high" priority.

### 103 Early Hints in HTTP/2
Previously we mentioned that HTTP/2 Push could actually cause regression in cases where assets being pushed were already in the browser cache. The <a hreflang="en" href="https://tools.ietf.org/html/rfc8297">103 Early Hints</a> proposal aims to provide similar benefits promised by HTTP/2 push. With an architecture that is potentially 10x simpler, it addresses the long RTT's or server processing without suffering from the known worst-case issue of unnecessary round trips with server push.

As of right now you can follow the conversation on Chromium with issues <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=671310">671310</a>, <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1093693">1093693</a>, and <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1096414">1096414</a>.

## Conclusion

During the past year resource hints increased in adoption, and they have become essential APIs for developers to have more granular control over many aspects of resource prioritizations and ultimately, user experience. But let's not forget that these are hints, not instructions and unfortunately the Browser and the network will always have the final say.

Sure, you can slap them on a bunch of elements, and the browser may do what you're asking it to. Or it may ignore some hints and decide the default priority is the best choice for the given situation. In any case, make sure to have a playbook for how to best use these hints:

- Identify key pages for the user experience.
- Analyze the most important resources to optimize.
- Adopt the <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL Pattern</a> when possible.
- Measure the performance experience before and after each implementation.

As a final note, let's remember that the web is for everyone. We must continue to protect it and stay focused on building experiences that are easy and frictionless.

We are thrilled to see that year after year we get incrementally closer to offering all the APIs required to simplify building a great web experience for everyone, and we can't wait to see what comes next.
