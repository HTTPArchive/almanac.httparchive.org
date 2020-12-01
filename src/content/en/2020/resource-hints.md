---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: IV
chapter_number: 21
title: Resource Hints
description: Resource Hints chapter of the 2020 Web Almanac covering usage of dns-prefetch, preconnect, preload, prefetch, priority hints, and native lazy loading.
authors: [Zizzamia]
reviewers: [jessnicolet, pmeenan, giopunt, mgechev, notwillk]
analysts: [khempenius]
translators: []
zizzamia_bio: Staff Software Engineer, Retail Growth at <a href="https://www.coinbase.com/">Coinbase</a>
discuss: 2057
results: https://docs.google.com/spreadsheets/d/1lXjd8ogB7kYfG09eUdGYXUlrMjs4mq1Z7nNldQnvkVA/
queries: 21_Resource_Hints
#featured_quote: TODO @zizzamia
#featured_stat_1: TODO @zizzamia
#featured_stat_label_1: TODO @zizzamia
#featured_stat_2: TODO @zizzamia
#featured_stat_label_2: TODO @zizzamia
#featured_stat_3: TODO @zizzamia
#featured_stat_label_3: TODO @zizzamia
unedited: true
---

## Introduction

Over the past decade [resource hints](https://www.w3.org/TR/resource-hints/) have become essential primitives that allow developers to improve page performance and therefore the user experience. 

Preloading resources and having browsers apply some intelligent prioritization is something that was actually started way back in 2009 by IE8 with something called the [preloader](https://speedcurve.com/blog/load-scripts-async/). In addition to the HTML parser, IE8 had a lightweight look-ahead preloader that scanned for tags that could initiate network requests (`<script>`, `<link>`, and `<img>`).

Over the following years, browser vendors did more and more of the heavy lifting, each adding their own special sauce for how to prioritize resources. But it’s important to understand that the browser alone has some limitations. As developers however, we can overcome these limits by making good use of Resource Hints and help decide how to prioritize resources, determining which should be fetched or preprocessed to further boost page performance.

In particular we can mention a few of the victories Resource Hints achieved/made in the last year:
- [CSS-Tricks](https://www.zachleat.com/web/css-tricks-web-fonts/) web fonts showing up faster on a 3G first render
- [wix.com](https://www.youtube.com/watch?v=4QqlGgF8Y2I&t=1469) using resource hints got 10% improvement for FCP
- [Ironmongerydirect.co.uk](https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/) by using preconnect improved product image loading by 400ms at the median and greater than 1s at 95th percentile
- [Facebook.com](https://engineering.fb.com/2020/05/08/web/facebook-redesign/) used preload for faster navigation

Let’s take a look at most predominant Resource Hints supported by most browsers today: `dns-prefetch`, `preconnect`, `preload`,  `prefetch` and native lazy loading. 

When used with each individual hint we advise to always measure the impact before and after in the field, by using libraries like [WebVitals](https://github.com/GoogleChrome/web-vitals), [Perfume.js](https://github.com/zizzamia/perfume.js) or any other utility that supports the Web Vitals metrics. 

### dns-prefetch

[dns-prefetch](https://web.dev/preconnect-and-dns-prefetch/) helps resolve the IP address for a given domain ahead of time. As the [oldest](https://caniuse.com/link-rel-dns-prefetch) resource hint available, it uses minimal CPU and network resources compared to `preconnect`, and helps the browser to avoid experiencing the "worst-case" delay for DNS resolution, which can be [over 1 second](https://www.chromium.org/developers/design-documents/dns-prefetching).

Be mindful when using `dns-prefetch` as even if they are lightweight to do it's easy to exhaust browser limits for the number of concurrent in-flight DNS requests allowed (Chrome still has a [limit of 6](https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353)).

### `preconnect`

[preconnect](https://web.dev/uses-rel-preconnect/) helps resolve the IP address and open a TCP/TLS connection for a given domain ahead of time. Similar to `dns-prefetch` it is used for any cross-origin domain and helps the browser to warm up any resources used during the initial page load.

Be mindful when you use `preconnect`:

- Only warm up the most frequent and significant resources.
- Avoid warm up origins used too late in the initial load.
- Use it for no more than three origins because it can have CPU and battery cost.

Lastly, `preconnect` is not available for [Internet Explorer or Firefox](https://caniuse.com/?search=preconnect), and [using `dns-prefetch` as a fallback](https://web.dev/preconnect-and-dns-prefetch/#resolve-domain-name-early-with-reldns-prefetch) is highly advised.

### preload

The [preload](https://web.dev/uses-rel-preload/) hint initiates an early request. This is useful for loading important resources that would otherwise be discovered late by the parser.

Be mindful of what you are going to `preload`, because it can delay the download of other resources, so use it only for what is most critical to help you improve the Largest Contentful Paint ([LCP](https://web.dev/lcp/)). Also, when used on Chrome, it tends to over-prioritize `preload` resources and potentially dispatches preloads before other critical resources.

Lastly, if used in a HTTP response header, some CDN's will also automatically turn a preload into a HTTP/2 push which can over-push cached resources.

### prefetch

The [prefetch](https://web.dev/link-prefetch/) hint allows us to initiate low-priority requests we expect to be used on the next navigation. The Hint will download the resources and drop it into the HTTP cache for later usage. Important to notice, `prefetch` will not execute or otherwise process the resource, and to execute it the page will still need to call the resource by the `<script>` tag.

There are a variety of ways to implement the resources predictions logic, could be based on signals like user mouse movement, common user flows/journeys or even based on a combination of both on top of Machine Learning.

Be mindful, depending on the [quality](https://github.com/andydavies/http2-prioritization-issues#current-status) of HTTP/2 prioritization of the CDN used, `prefetch` prioritization could either improve performance or make it slower, by over prioritizing `prefetch` requests and taking away important bandwidth for the initial load. Make sure to double check the CDN you are using and adapt to take into consideration some of the best practices shared in [Andy Davies's](https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/) article.

### Native Lazy loading

The [native lazy loading](https://web.dev/browser-level-image-lazy-loading/) hint is a native browser API for deferring the load of offscreen images and iframes. By using it, assets that are not needed during the initial page load will not initiate a network request, this will reduce data consumption and improve page performance.

Be mindful Chromium's implementation of lazy-loading thresholds logic historically has been quite [conservative](https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds), keeping the offscreen limit to 3000px. During the last year the limit has been actively tested and improved on to better align developer expectations, and ultimately moving the thresholds to 1250px.

## Resource Hints

Based on the HTTP Archive, let's jump into analyzing the 2020 trends, and compare the data with the previous 2019 dataset.

### Hints adoption

More and more web pages are using the main Resource Hints, and in 2020 we are seeing the adoption remains consistent between desktop & mobile.

{{ figure_markup(
  image="TODO",
  caption="TODO",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1550112064&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

This is a great representation of how year over year we continue to focus on improving not only for desktop but also for mobile experiences. One take we will probably analyze even further next year is how HighEnd vs LowEnd devices will diverge in hints usage.

{{ figure_markup(
  caption="The percentage of desktop pages using DNS prefetching compared with other resource hints.",
  content="33%",
  classes="big-number",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

The relative popularity of `dns-prefetch` is unsurprising as it first appeared in 2009, and has the widest support out of all major Resource Hints. It had a 4% increase in Desktop adoption, compared to [2019](https://almanac.httparchive.org/en/2019/resource-hints#resource-hints). We saw a similar increase for `preconnect` as well. One key reason this was the largest growth between all hints, is the clear and useful advice pthe Lighthouse audit is giving on this matter](https://web.dev/uses-rel-preconnect/). Starting from this year's report we also introduce how the latest dataset performs against Lighthouse recommendations.

`preload` usage has had a slower growth with only a 2% increase from 2019. This could be in part because it requires a bit more attention. While you only need the domain to use `dns-prefetch` and `preconnect`, you must specify the resource to use `preload`. While `dns-prefetch` and `preconnect` are reasonably low risk–though still can be abused– `preload` has a much greater potential to actually damage performance if used incorrectly.

`prefetch` is used by 3% of sites on Desktop, making it the least widely used resource hint. This low usage may be explained by the fact that `prefetch` is useful for improving subsequent—rather than current—page loads. Thus, it will be overlooked if a site is only focused on improving its landing page, or the performance of the first page viewed. In the coming years with a more clear definition on what to measure for improving subsequent page experience, it could help teams prioritize `prefetch` adoption with clear performance quality goals to reach.

### Hints per page

Across the board developers are learning how to better use Resource Hints, and compared to [2019](../2019/resource-hints#resource-hints) we've seen an improved use of `preload`, `prefetch` and `preconnect`. For expensive operations like preload and preconnect the median usage on desktop decreased from 2 to 1. We have seen the opposite for loading future resources with a lower priority with `prefetch`, with an increase from 1 to 2 in median per page.

{{ figure_markup(
  image="TODO",
  caption="TODO",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=320451644&format=interactive",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

Resource hints are most effective when they're used selectively ("when everything is important, nothing is"). Having a more clear definition of what resources help improve Largest Contentful Paint moved the focus away from using `preconnect` and more towards `prefetch` by shifting some of the resource prioritization and freeing up bandwidth for what most helps the user at first.

However, this hasn't stopped some misuse of the `preload` hint, since in one instance we discovered a page dynamically adding the hint and causing an infinite loop that created over 20k new preloads.

{{ figure_markup(
  caption="The most preload hints per page 🤯",
  content="20,931",
  classes="big-number",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

As we create more and more automation with Resource Hints, be cautious when dynamically injecting preload hints - or any elements for that matter!

### The `as` attribute

With `preload` and `prefetch`, it's crucial to use the as attribute to help the browser prioritize the resource more accurately. Doing so allows for proper storage in the cache for future requests, applying the correct Content Security Policy ([CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)), and setting the correct `Accept` request headers.

With `preload` many different content-types can be preloaded and the[full list](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#Attributes) follows the recommendations made in the Fetch [spec](https://fetch.spec.whatwg.org/#concept-request-destination). The most popular is the script `type` with 64% usage.

{{ figure_markup(
  caption="The percent of preload hints on mobile using the scripts type.",
  content="64%",
  classes="big-number",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

This is likely related to a large group of sites built as Single Page Apps that need the main bundle as soon as possible to start downloading the rest of their JS dependencies. Subsequent usage comes from font at 8%, style at 5%, image at 1%, and fetch at 1%.

{{ figure_markup(
  image="TODO",
  caption="TODO",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=903180926&format=interactive",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

Compared to the trend in 2019, we've seen rapid growth in font and style usage with the `as` attribute. This is likely related to both developers increasing the priority of critical CSS and also combining `preload` fonts with `display:optional` to [improve](https://web.dev/optimize-cls/#web-fonts-causing-foutfoit) Cumulative Layout Shift ([CLS](https://web.dev/cls/)).

Be mindful that omitting the as attribute, or having an invalid value will make it harder for the browser to determine the correct priority and in some cases, such as scripts, can even cause the resource to be fetched twice.

### The `crossorigin` attribute

With `preload` and `preconnect` resources that have CORS enabled, such as fonts or images, it's important to include the `crossorigin` attribute, in order for the resource to be properly used. If the crossorigin attribute is absent, the request will follow the single-origin policy thereby making the use of preload useless.

The latest trend indicates that by using `preload` with the `crossorigin` attribute we have 34% anonymous (or equivalent) cases, and 0.43% use-credentials cases. This has evolved in conjunction with the increase in font-preloading mentioned earlier.

```html
<link rel="preload" href="ComicSans.woff2" as="font" type="font/woff2" crossorigin>
```

Be mindful that fonts preloaded without the `crossorigin` attribute will be fetched [twice](https://web.dev/preload-critical-assets/#how-to-implement-relpreload)!

### The `media` attribute

When it's time to choose a resource for use with different screen sizes, reach for the `media` attribute with `preload` to optimize your media queries.

```html
<link rel="preload" href="desktop.css" as="style" media=”only screen and (max-width: 768px)”>
<link rel="preload" href="mobile.css" as="style" media=”~~~”>
```

The most popular media value used with `preload` is a combination of `only screen and (max-width: 768px)` and `screen and (min-width: 767px)`. Seeing over 2,100 different combinations of media queries in the 2020 dataset encourages us to consider how wide the variance is between concept and implementation of responsive design from site to site.

### Best practices

Using Resource Hints can be confusing at times, so let's go over some quick best practices to follow based on Lighthouse's automated audit.

To safely implement `dns-prefetch` and `preconnect` make sure to have them in separate links tags.

```html
<link rel="preconnect" href="http://example.com">
<link rel="dns-prefetch" href="http://example.com">
```

Implementing a `dns-prefetch` fallback in the same `<link>` tag causes a [bug](https://bugs.webkit.org/show_bug.cgi?id=197010) in Safari that cancels the `preconnect` request.


{{ figure_markup(
  caption="Resource hints on desktop that use either preconnect or dns-prefetch use both in the same hint.",
  content="1.93%",
  classes="big-number",
  sheets_gid="281984550",
  sql_file="preconnect_and_dnsprefetch_relative.sql"
) }}

Close to 2% of pages (~40k) reported the issue of both `preconnect` & `dns-prefetch` in a single resource.

{{ figure_markup(
  caption="Pages that pass the preconnect Lighthouse audit",
  content="19.67%",
  classes="big-number",
  sheets_gid="152449420",
  sql_file="lighthouse_preconnect.sql"
) }}

We saw only 19.67% of pages passing Lighthouse’s "[Preconnect to required origins](https://web.dev/uses-rel-preconnect/)" audit, creating a large opportunity for thousands of websites to start using `preconnect` or `dns-prefetch` to establish early connections to important third-party origins.

{{ figure_markup(
  caption="Pages that pass the preload Lighthouse audit",
  content="84.6%",
  classes="big-number",
  sheets_gid="1047875076",
  sql_file="lighthouse_preload.sql"
) }}

Running Lighthouse’s "[Preload key requests](https://web.dev/uses-rel-preload/)" audit resulted in 84.6% of pages passing the test, which is an astonishing result. If you are looking to use `preload` for the first time, remember, fonts and critical scripts are a good place to start.

### Native Lazy Loading

Now let’s celebrate the first year of the [Native Lazy Loading](https://addyosmani.com/blog/lazy-loading/) API, which at the time of publishing already has over [72%](https://caniuse.com/loading-lazy-attr) browser support. This new API can be used to defer the load of below-the-fold iframes and images on the page until the user scrolls near them. This can reduce data usage, memory usage, and helps speed up above-the-fold content. Opting-in to lazy load is as simple as adding `loading=lazy`  on `<iframe>` or `<img>` elements.

{{ figure_markup(
  caption="Percentage of pages using native lazy loading set to “lazy”",
  content="3.87%",
  classes="big-number",
  sheets_gid="2039808014",
  sql_file="native_lazy_loading_attrs.sql"
) }}

Adoption is still in its early days, especially with the official thresholds earlier this year being too conservative, and only [recently](https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/) aligning with developer expectations. With almost 72% of browsers supporting native image/source lazy loading, this is another area of opportunity especially for pages looking to improve data usage and performance on low-end devices. 

{{ figure_markup(
  caption="Percentage of pages passing the offscreen images Lighthouse audit",
  content="68.65%",
  classes="big-number",
  sheets_gid="1357389632",
  sql_file="lighthouse_offscreen_images.sql"
) }}

Running Lighthouse's "[Defer offscreen images](https://web.dev/offscreen-images/)" audit resulted in 68.65% of pages passing the test. For those pages there is an opportunity to lazy-load images after all critical resources have finished loading.

Be mindful to run the audit on both desktop and mobile as images may move off screen when the viewport changes.

## Machine Learning

Combining `prefetch` with Machine Learning can help with performance improvement of the subsequent page(s). One solution is [Guess.js](https://github.com/guess-js/guess) which made the initial breakthrough in predictive-prefetching, with over a dozen websites already using it in production.

[Predictive prefetching](https://web.dev/predictive-prefetching/) is a technique that uses methods from data analytics and machine learning to provide a data-driven approach. Guess.js is a library that has predictive prefetching support for popular frameworks (Angular, Nuxt.js, Gatsby, and Next.js) and you can take advantage of it today. It ranks the possible navigations from a page and prefetches only the JavaScript that is likely to be needed next.

Depending on the training set, the prefetching of Guess.js comes with over 90% accuracy.

Overall, predictive prefetching is still uncharted territory but combined with prefetching on mouse over and even a Service Worker strategy, it has great potential to provide instant experiences for all users of the website, while saving their data.

## HTTP/2 Push

HTTP/2 has a feature called server push that can potentially improve page performance when your product experiences long [RTTs](https://developer.mozilla.org/en-US/docs/Glossary/Round_Trip_Time_(RTT)) or server processing. In brief, rather than waiting for the client to send a request, the server preemptively pushes a resource that it predicts the client will request soon afterwards.

{{ figure_markup(
  caption="Percentage of HTTP/2 Push pages using preload/nopush",
  content="75.36%",
  classes="big-number",
  sheets_gid="308166349",
  sql_file="h2_preload_nopush.sql"
) }}

In the 2020 dataset we have seen 1% of mobile pages using HTTP/2 Push, and of those 75% of preload header links use the nopush option in the firstHtml request. This means that even though a website is using preload, the majority of requests prefer to disable the push option.

It's important to mention that HTTP/2 Push can also damage performance if not used correctly.

One solution to this, is to use the [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) which stands for **Push** (or preload) the critical resources, **Render** the initial route as soon as possible, **Pre-cache** remaining assets, and **Lazy-load** other routes and non-critical assets. This is possible only if your website is a Progressive Web App and uses a Service Worker to improve the caching strategy. By doing this all subsequent requests never even go out to the network, and so there's no need to push all the time and we still get the best of both worlds.

## Service Workers

For both `preload` and `prefetch` we've had an increase in adoption when the page is controlled by a [Service Worker](https://developers.google.com/web/fundamentals/primers/service-workers). This is because of the potential to both improve the resource prioritization by preloading when the Service Worker is not active yet and intelligently prefetching future resources while letting the Service Worker cache them before they're needed by the user.

{{ figure_markup(
  image="TODO",
  caption="TODO",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=252958553&format=interactive",
  sheets_gid="691299508",
  sql_file="adoption_service_workers.sql"
) }}

For `preload` on desktop we have an outstanding 47% rate of adoption and `prefetch` a 10% rate of adoption. In both cases the data is much higher compared to average adoption without a Service Worker.

As mentioned earlier, the [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) will play a significant role in the coming years in how we combine Resource Hints with the Service Worker caching strategy.

## Future

Let's dive into a couple of experimental hints. Very close to release we have Priority Hints, at the moment actively experimented with the web community. Lastly we have the 103 Early Hints in HTTP/2, which is still in early inception and there are a few players like Chrome and Fastly collaborating for upcoming test trials.

### Priority Hints

[Priority hints](https://developers.google.com/web/updates/2019/02/priority-hints) are an API for expressing the fetch priority of a resource: high, low, or auto. They can be used to help deprioritize images (e.g. inside a Carousel), re-prioritize scripts and even help de-prioritize fetches.

This new hint can be used either as an HTML tag or by changing the priority of fetch requests via the `importance` option, which takes the same values as the HTML attribute.

With `preload` and `prefetch`, the priority is set by the browser depending on the type of resource. By using Priority Hints we can force the browser to change the default option.

{{ figure_markup(
  caption="The rate of priority hint adoption on mobile",
  content="0.77%",
  classes="big-number",
  sheets_gid="1596669035",
  sql_file="priority_hints.sql"
) }}

So far only 0.77% websites adopted this new hint as Chrome is still [actively](https://www.chromestatus.com/features/5273474901737472) experimenting, and at the time of this article's release the feature is on-hold.

{{ figure_markup(
  caption="Priority hints on mobile are on script elements",
  content="80%",
  classes="big-number",
  sheets_gid="800402946",
  sql_file="priority_hints_by_element.sql"
) }}

The largest use is with script elements, which is unsurprising as the number of JS primary and third-party files continues to grow.

{{ figure_markup(
  caption="Priority hints on mobile have \"low\" importance",
  content="16.11%",
  classes="big-number",
  sheets_gid="1098063134",
  sql_file="priority_hints_by_element_and_importance.sql"
) }}

There are over 79% of resources with "high" priority, but something we should pay even more attention to is the 16% of resources with "low" priority. Priority Hints have a clear advantage as a defense mechanism rather than an offense, by helping the browser decide what to de-prioritize and giving back significant CPU and Bandwidth to complete critical requests first.


### 103 Early Hints in HTTP/2
Previously we mentioned that HTTP/2 Push could actually cause regression in cases where assets being pushed were already in the browser cache. The [103 Early Hints](https://tools.ietf.org/html/rfc8297) proposal aims to provide similar benefits promised by HTTP/2 push. With an architecture that is potentially 10x simpler, it addresses the long RTT’s or server processing without suffering from the known worst-case issue of unnecessary round trips with server push.

As of right now you can follow the conversation on Chromium with issues [671310](https://bugs.chromium.org/p/chromium/issues/detail?id=671310), [1093693](https://bugs.chromium.org/p/chromium/issues/detail?id=1093693) and [1096414](https://bugs.chromium.org/p/chromium/issues/detail?id=1096414). 

## Conclusion

During the past year Resource Hints increased in adoption, and they have become essential APIs for developers to have more granular control over many aspects of resource prioritizations and ultimately, user experience. But let’s not forget that these are hints, not instructions and unfortunately the Browser and the network will always have the final say. 

Sure, you can slap them on a bunch of elements, and the browser may do what you're asking it to. Or it may ignore some hints and decide the default priority is the best choice for the given situation. In any case, make sure to have a playbook for how to best use these hints:

- Identify key pages for the user experience.
- Analyze the most important resources to optimize.
- Adopt the [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) when possible.
- Measure the performance experience before and after each implementation.

As a final note, let’s remember that the web is for everyone. We must continue to protect it and stay focused on building experiences that are easy and frictionless. 

We are thrilled to see that year after year we get incrementally closer to offering all the APIs required to simplify building a great web experience for everyone, and we can’t wait to see what comes next.
