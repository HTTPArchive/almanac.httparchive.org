---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Performance
#TODO - Review and update chapter description
description: Performance chapter of the 2022 Web Almanac covering Core Web Vitals, with deep dives into the Largest Contentful Paint, Cumulative Layout Shift, and First Input Delay metrics and their diagnostics.
authors: [mel-ada, rviscomi]
reviewers: [tunetheweb, 25prathamesh, estelle, konfirmed]
analysts: [rviscomi, 25prathamesh, siakaramalegos, konfirmed]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1TPA_4xRTBB2fQZaBPZHVFvD0ikrR-4sNkfJfUEpjibs/
mel-ada_bio: Mel Ada is a software engineer on the Web Performance team at Etsy. Her current involvement in the community includes co-organizing the NY Web Performance Meetup and occaisonally doing some speaking of her own.
rviscomi_bio: Rick Viscomi is a DevRel engineer at Google, focusing on web performance. He is the co-author of <a hreflang="en" href="https://usingwpt.com/">Using WebPageTest</a>, a book about web performance testing. He also co-maintains HTTP Archive and is the Editor-in-Chief of the Web Almanac.
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
unedited: true
---

## Introduction

Web performance is crucial to user experience and accessibility. We've all bounced from a site before due to slow load times, or worse, have not been able to access important information. Additionally, numerous <a hreflang="en" href="https://wpostats.com/">case studies</a> have demonstrated that an improvement in web performance results in an improvement in conversion and engagement for businesses.

However, the industry spotlight is quite elusive for web performance—why is this? This chapter focuses on Google's solution to the problem: Core Web Vitals (CWV), web performance metrics made a variable in search ranking during 2021. Since the search ranking influence was effective almost exactly one year ago, this year's data gives us insights on how the web is adjusting to the metrics and where room for opportunity might still exist.

Although the spotlight of this chapter, it's important to note CWV are relatively new to the field and not the only way to measure web performance. There's no way to fit the entire history of the industry or all the different ways to evaluate performance in one chapter.  However before we jump in, it helps to briefly define what web performance even means and how it is measured.

The term _performance_ tends to be thrown around a lot as this generic idea that we all agree is good, but it's often hard to pin down. This is a theme among beginners and experts alike. It seems we mostly agree that performance is about measuring if the user is having a good time on a site.  A little generic, but let's go with it for now. So how would we measure this? As [Sergey Chernyshev](https://twitter.com/sergeyche), creator of <a hreflang="en" href="https://github.com/ux-capture/ux-capture">UX Capture</a>, says, "_The best way to measure performance is to be embedded into the user's brain to understand exactly what they're thinking as they use the site_".  We can't—and shouldn't in case that was unclear—do this, so what are our options?

Thankfully, there is a way to measure page load speed automatically! We know the browser is in charge of loading a page, and it goes through a checklist of steps each time. Depending on which step the browser is on, we can tell how far along the site is in the page load process. Conveniently, a [number of performance timeline APIs](https://developer.mozilla.org/en-US/docs/Web/API/Performance) are used to fire off timestamps when the browser gets to certain page load steps. One such API, the [User Timing API](https://developer.mozilla.org/en-US/docs/Web/API/User_Timing_API), even allows engineers to add custom timestamps for their specific needs. These timestamps become the metrics used across the industry to decipher how performant a page is.

However, these metrics are only our best guess at how to gauge user experience. For example, just because the browser fired an event that an element has been painted onto the screen, does that always mean it was visible to the user at that time? Additionally, as the industry grew, more and more metrics showed up while some became deprecated. It can be complicated to know where to start and understand what performance metrics are telling us about our users, especially for folks newer to the field.

Enter <a hreflang="en" href="https://web.dev/vitals/">CWV</a>, three metrics to indicate overall performance health. Each metric covers an important area of user experience: loading, interactivity, and visual stability. The public <a hreflang="en" href="https://developer.chrome.com/docs/crux/">Chrome UX Report</a> (CrUX) dataset is Chrome's view of how millions of websites are performing on CWV. There's zero setup on the developer's part; Chrome automatically collects and publishes data from <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology/#eligibility">eligible</a> users and websites. Using CrUX data, we're able to get insights into the web's performance and even track historical data.

CWV offers a clearly defined approach to measuring how user's actually experience performance—a first for the industry. Are CWV the answer to helping the web become more performant? It's been a little over two years since launch, so this chapter examines where the web is currently with CWV and a look into the future.

## Core Web Vitals

CWV have been a part of Google Search ranking for a little over a year now, so we've had time to see how the program may have influenced user experiences on the web.

{{ figure_markup(
  image="good-core-web-vitals-by-device.png",
  caption="The percent of websites having good CWV, segmented by device and year.",
  description="Bar chart showing that in 2020 34% of websites used on desktop had good Core Web Vitals, versus 24% on phone. In 2021 that increased to 41% and 29% respectively, and in  2022 that further increased to 44% of desktop sites and 39% of phone sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1239858329&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

In 2021, 29% of websites were assessed as having good CWV for mobile users. This was a significant step up from 2020, representing a 5 percentage point increase. However, the progress in 2022 was an even bigger leap forward, now with 39% of websites having good CWV on mobile, representing a further 10 point increase!

44% of websites have good CWV on desktop. While this is better than mobile, the rate of improvement for desktop experiences is not as rapid as mobile, so the gap is closing.

There are a few possible explanations for why mobile experiences tend to be worse than desktop. While the portability of a pocket-sized computer is a great convenience, it may have adverse effects on the user experience. As described in the [Mobile Web](./mobile-web#mobile-performance) chapter, the smaller form factor has an impact on the amount of processing power that can be packed in, which is further constrained by the high cost to own more powerful phones. Devices with poorer processing capabilities take longer to perform the computations needed to render a web page.  The portability of these devices also means that they can be taken into areas with poor connectivity, which hinders websites' loading speeds. One final consideration is the way that developers decide how to build websites. Rather than creating a mobile-friendly version of the page, some websites may be serving desktop-sized images or unnecessary amounts of scripting functionality. All of these things put mobile users at a disadvantage compared to desktop users and may help to explain why their CWV performance is lower.

Many more websites were assessed as having good CWV in 2022 relative to 2021. But how evenly distributed was that improvement across the web?

{{ figure_markup(
  image="good-cwv-performance-by-rank-and-year.png",
  caption="The percent of websites having good CWV, segmented by rank and year.",
  description="Bar chart showing the split of Good Core Web Vitals by rank over 2021 and 2022. For 2021 it was 37% for the top 1,000 websites, 31% for top 10,000, 29% for top 100,000, 30% for top million, and 32% overall. For 2022 it was 53% for the for the top 1,000 websites, 44% for top 10,000, 40% for top 100,000, 40% for top million, and 42% overall.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=737356809&format=interactive",
  sheets_gid="863235163",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

We segmented sites by their relative popularity (rank) and year, without distinguishing between desktop and mobile. What's interesting is that it seems websites across the board generally got faster this year, regardless of their popularity. The top 1,000 most popular websites improved most significantly, a 16 percentage point increase to 53%, with all ranks improving by 10 points or more. The most popular websites also tend to have the best CWV experience, which is not too surprising if we assume that they have bigger engineering teams and budgets.

To better understand why mobile experiences have gotten so much better this year, let's dive deeper into each individual CWV metric.

## Largest Contentful Paint (LCP)

<a hreflang="en" href="https://web.dev/lcp/">Largest Contentful Paint</a> (LCP) is the time from the start of the navigation until the largest block of content is visible in the viewport. This metric represents how quickly users are able to see meaningful content.

We say that a website has good LCP if at least 75 percent of all page views are faster than 2,500 ms. Of the three CWV metrics, LCP pass rates are the lowest, often making it the bottleneck to achieving good CWV assessments.

{{ figure_markup(
  image="good-lcp-by-device.png",
  caption="The percent of websites having good LCP, segmented by device and year.",
  description="Bar chart showing the number of websites with good LCP increased from 53% in 2020 to 60% in 2021 to 63% in 2022. For sites visited on phones the increase was from 43% in 2020 to 45% in 2021 and then to 51% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1542261080&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

This year, 51% of websites have good LCP experiences on mobile and 63% on desktop. LCP appears to be one of the major reasons why websites' mobile experiences have gotten so much better in 2022, having a 6 percentage point improvement this year.

Why did LCP improve so much this year? To help answer that, let's explore a couple of loading performance diagnostic metrics: TTFB and FCP.

### Time to First Byte (TTFB)

<a hreflang="en" href="https://web.dev/ttfb/">Time to First Byte</a> (TTFB) is the time from the start of the navigation to the first byte of data returned to the client. It's our first step in the web performance checklist, representing the backend component of LCP performance, particularly network connection speeds and server response times.

{{ figure_markup(
  image="good-ttfb-by-device.png",
  caption="The percent of websites having good TTFB, segmented by device and year.",
  description="Bar chart showing the number of websites with good TTFB increased from 47% in 2020 to 51% in 2021 to 52% in 2022. For sites visited on phones the it was fairly stable with 41% of sites achieveing good TTFB in 2020, 39% in 2021 and 40% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=628253519&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

As an aside, note that earlier this year Chrome <a hreflang="en" href="https://developer.chrome.com/docs/crux/release-notes/#202204">changed</a> the threshold for "good" TTFB from 500 ms to 800 ms. In the chart above, all historical data is using this new threshold for comparison purposes.

With that in mind, the percentage of websites having good TTFB has not actually improved very much. In the past year, websites' desktop and mobile experiences have gotten one percentage point better, which is nice but doesn't account for the gains observed to LCP.

Another complication is that TTFB is still considered to be an experimental metric. According to the CrUX documentation, it's technically still an <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology/#experimental-metrics">experimental</a> metric and so it _does not_ factor in more advanced navigation types like pre-rendered and back/forward navigations. This is somewhat of a blind spot, so if there were improvements in these areas, they wouldn't necessarily affect the TTFB results.

### First Contentful Paint (FCP)

<a hreflang="en" href="https://web.dev/fcp/">First Contentful Paint</a> (FCP) is the time from the start of the request to the first meaningful content painted to the screen. In addition to TTFB, this metric can be affected by render-blocking content. The threshold for "good" FCP is 1,800 ms.

{{ figure_markup(
  image="good-fcp-by-device.png",
  caption="The percent of websites having good FCP, segmented by device and year.",
  description="Bar chart showing the number of websites with good FCP increased from 53% in 2020 to 60% in 2021 to 64% in 2022. For sites visited on phones the it was 38% of sites achieving good FCP in 2020, and the same 2021, increasing to 49% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=831105883&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

FCP improved dramatically this year, with 49% of websites having good mobile experiences and 64% for desktop. This represents an 11 and 4 percentage point increase for mobile and desktop, respectively.

In the absence of TTFB data to the contrary, this indicates that there were major improvements to frontend optimizations, like eliminating render-blocking resources or more advanced resource prioritization.

### LCP metadata and best practices

These performance improvements may not actually be due to changes to the websites themselves. Changes to network infrastructure, operating systems, or browsers could also impact LCP performance at web-scale like this, so let's dig into some heuristics.

#### Render-blocking resources

A page is considered to have render-blocking resources if resources hold up the initial paint (or render) of the page. This is particularly likely for critical scripts and styles that are loaded over the networkits critical scripts and styles are loaded over the network. Lighthouse includes an <a hreflang="en" href="https://web.dev/render-blocking-resources/">audit</a> that checks for these resources, which we've run on the home page of each website in CrUX. You can learn more about how we test these pages in our [Methodology](./methodology).

{{ figure_markup(
  image="pages-passing-render-blocking-resources-audit.png",
  caption="The percent of pages that pass the render-blocking Lighthouse audit , segmented by device and year.",
  description='Bar chart showing 19% of mobile pages passed the "render-blocking resources" audit in 2021. In 2022 this increased slighly to 20%, and we also added the desktop equivalent which was 14%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1619115021&format=interactive",
  sheets_gid="1317344415",
  sql_file="render_blocking_resources.sql"
  )
}}

Surprisingly, there was no dramatic improvement in the percent of pages that have render-blocking resources.  Only 20% of mobile pages pass the audit, which is a mere 1 percentage point increase over last year.

2022 is the first year in which we have Lighthouse data for desktop. So while we're unable to compare it against previous years, it's still interesting to see that many fewer desktop pages pass the audit relative to mobile, in spite of the trend of desktop pages tending to have better LCP and FCP performance.

#### LCP prioritization

There are two factors that affect how soon a LCP resource starts to download after the page itself is downloaded: discoverability and prioritization. We'll explore [LCP discoverability](#lcp-static-discoverability) later, but first let's look at how LCP images are prioritized.

Images are not loaded at high priority by default, but thanks to the new <a hreflang="en" href="https://web.dev/priority-hints/">Priority Hints</a> API, developers can explicitly set their LCP images to load at high priority to take precedence over non-essential resources.

{{ figure_markup(
  content="0.03%",
  caption="The percent of pages that use `fetchpriority=high` on their LCP element.",
  classes="big-number",
  sheets_gid="600760184",
  sql_file="lcp_element_data_2.sql",
  )
}}

0.03% of pages use `fetchpriority=high` on their LCP elements. Counterproductively, a handful of pages actually _lower_ the priority over their LCP images: 77 pages on mobile and 104 on desktop.

`fetchpriority` is still very new and not supported everywhere, but there's little to no reason why every developer shouldn't be using it. Patrick Meenan, who helped develop the API, [describes it](https://twitter.com/patmeenan/status/1460276602479251457) as a "_cheat code"_ given how easy it is to implement relative to the potential improvements.

#### LCP content types

Prioritization techniques like `fetchpriority` apply primarily to LCP content that is an image. However, the LCP element can be anything like an image, a heading, or a paragraph of text.

{{ figure_markup(
  image="top-lcp-element-types.png",
  caption="The percent of pages that have a given element as its LCP.",
  description="Bar chart showing `IMG` is the LCP element on 47% of desktop pages and 42% of mobile pages, `DIV` on 28% and 26% respectively, `P` on 6% and 9%, `H1` on 3% and 5%, `undetected` on 3% and 3%, `SECTION` on 3% and 3%, `H2` on 1% and 2%, `A` on 1% and 2%, `SPAN` on 1% and 1%, `H3` on 0% and 1%, `HEADER` on 1% and 1%, `LI` on 1% and 1%, `RS-SBG` on 1% and 1%, `TD` on 1% and 1%, `VIDEO` on 0% and 0%, and finally `H4` is the LCP element type on 0% of both desktop and mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=932136285&format=interactive",
  sheets_gid="1174093943",
  sql_file="lcp_element_data.sql",
  width=600,
  height=702
  )
}}

It's clear that images are the most common type of LCP content, with the `img` element representing the LCP on 42% of mobile pages. Mobile pages are slightly more likely to have heading and paragraph elements be the LCP than desktop pages, while desktop pages are more likely to have image elements as the LCP. One possible explanation is the way that mobile layouts—especially in portrait orientation—make unresponsive images appear smaller, giving way to large blocks of text like headings and paragraphs to become the LCP elements.

The second most popular LCP element type is `div`. This is a generic HTML container that could be used for text or styling background images. To help disambiguate how often these elements contain images or text, we can evaluate the `url` property of the [LCP API](https://developer.mozilla.org/en-US/docs/Web/API/LargestContentfulPaint).  According to the <a hreflang="en" href="https://www.w3.org/TR/largest-contentful-paint/#dom-largestcontentfulpaint-url">specification</a>, when this property is set, the LCP content must be an image.

{{ figure_markup(
  image="top-lcp-content-types.png",
  caption="The percent of pages that use each type of LCP content.",
  description="Bar chart showing an image is the LCP content type on 82% of desktop pages and 72% of mobile pages, it is text on 17% and 26% respectively, and an inline image on 2% of desktop and 1% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1619115021&format=interactive",
  sheets_gid="872701281",
  sql_file="lcp_resource_type.sql"
  )
}}

We see that 72% of mobile pages and 82% of desktop pages have images as their LCP. For example, these images may be traditional `img` elements or CSS background images. 26% of mobile pages and 17% of desktop pages have text-based content as their LCP.

1% of pages actually use inline images as their LCP content. This is often a bad idea for a number of reasons, mostly around caching and complexity.

#### LCP static discoverability

Earlier we looked at [prioritization](#lcp-prioritization) as a way to improve LCP performance by outcompeting other concurrently loading resources. Discoverability, on the other hand, determines when the LCP image can even begin to load.

An LCP image is considered to be _statically discoverable_ if its source URL can be parsed directly from the markup sent by the server. This helps to ensure that the LCP resource can be loaded as soon as possible. Text-based LCP content is statically discoverable by definition.

```html
<img data-src="kitten.jpg" class="lazyload">
```

Custom lazy-loading techniques like the example above are one way that images are prevented from being statically discoverable, since they rely on JavaScript to update the `src` attribute.

{{ figure_markup(
  content="39%",
  caption="The percent of mobile pages on which the LCP element was not statically discoverable.",
  classes="big-number",
  sheets_gid="1465687616",
  sql_file="lcp_preload_discoverable.sql",
  )
}}

39% of mobile pages have LCP elements that are not statically discoverable. This figure is even worse on desktop at 44% of pages, potentially as a consequence of the previous section's finding that LCP content is more likely to be an image on desktop pages.

This is the first year that we're looking at this metric, so we don't have historical data for comparison, but these results hint at a big opportunity to improve the load delay of LCP resources.

#### LCP preloading

When the LCP image is not statically discoverable, <a hreflang="en" href="https://web.dev/preload-critical-assets/">preloading</a> can be an effective way to minimize the load delay. Of course, it would be better if the resource was statically discoverable to begin with, but addressing that may require rearchitecting the way the page loads. Preloading is somewhat of a quick fix by comparison, as it can be implemented with a single HTTP header or `meta` tag.

{{ figure_markup(
  content="0.56%",
  caption="The percent of mobile pages that preload their LCP images.",
  classes="big-number",
  sheets_gid="1465687616",
  sql_file="lcp_preload_discoverable.sql",
  )
}}

Only about 1 in 200 mobile pages preload their LCP images. This figure falls to about 1 in 400 (0.25%) when we only consider pages whose LCP images are not statically discoverable. Otherwise, preloading statically discoverable images can be overkill as the browser already knows about the image thanks to its <a hreflang="en" href="https://web.dev/preload-scanner/">preload scanner</a>.

These results show that the overwhelming majority of the web could benefit from making their LCP images more discoverable. Loading LCP images sooner, either by making them statically discoverable or preloading them, can go a long way to improving LCP performance.

#### LCP initiator

When an LCP resource is not statically discoverable, there must be some other, more indirect process by which it gets added to the page.

{{ figure_markup(
  image="top-lcp-initiators-among-pages-whose-lcp-is-not-statically-discoverable.png",
  caption="The percent of pages whose LCP is not statically discoverable and initiated from a given resource.",
  description="Bar chart showing that `html` is the initiator on 29% of desktop and 28% of mobile pages, `css` on 11% and 9% respectively, `unknown` on 5% and 4%, and finally `other` si the initiator on 0% of both desktop and mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1835555974&format=interactive",
  sheets_gid="1866346503",
  sql_file="lcp_initiator_type_undiscoverable.sql"
  )
}}

9% of mobile pages depend on an external stylesheet for their LCP resource, for example using the `background-image` property. 28% of mobile pages have an LCP image that is discovered late in the HTML. Both of these situations are bad for performance, and their effects can be mitigated with preloading.

#### LCP lazy-loading

Lazy-loading is an effective performance technique to delay when non-critical resources start loading, usually until they're in or near the viewport. With precious bandwidth and rendering power freed up, the browser can load critical content earlier in the page load. A problem arises when lazy-loading is applied to the LCP image itself, because that prevents the browser from loading it until much later.

{{ figure_markup(
  content="9.8%",
  caption="The percent of mobile pages that set `loading=lazy` on their LCP image.",
  classes="big-number",
  sheets_gid="600760184",
  sql_file="lcp_element_data_2.sql",
  )
}}

Nearly 1 in 10 of pages with `img`-based LCP are using the native `loading=lazy` attribute. Technically, these images are statically discoverable, but the browser will need to wait to start loading them until it's laid out the page to know whether they will be in the viewport. LCP images are always in the viewport, by definition, so in reality none of these images should have been lazy-loaded.

Note that the percentages in this section are out of only those pages in which the `img` element is the LCP, not all pages. For reference, recall that this accounts for 42% of pages.

{{ figure_markup(
  content="8.8%",
  caption="The percent of mobile pages that use custom lazy-loading on their LCP image.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy.sql",
  )
}}

One way that sites might polyfill the native lazy-loading behavior is to assign the image source to a `data-src` attribute and include an identifier like `lazyload` in the class list. Then, a script will watch the positions of images with this class name relative to the viewport, and swap the `data-src` value for the native `src` value to trigger the image to start loading.

Nearly as many pages are using this kind of custom lazy-loading behavior as native lazy-loading, at 8.8% of pages with `img`-based LCP.

Beyond the adverse performance effects of lazy-loading LCP images, native image lazy-loaded is <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">supported</a> by all major browsers, making custom solutions like these obsolete. Developers should seriously consider removing these polyfills from their code and switch to using native lazy-loading judiciously.

Another benefit to using native lazy-loading is that browsers like Chrome are <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=996963">experimenting</a> with using heuristics to ignore the attribute on probable LCP candidates. If that were to happen, the images would be eagerly loaded thanks to their static discoverability, which is defeated by custom solutions.

{{ figure_markup(
  content="18%",
  caption="The percent of mobile pages that use native or custom lazy-loading on their LCP image.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy.sql",
  )
}}

Looking at pages that use either technique, 18% of pages with `img`-based LCP are unnecessarily delaying the load of their most important images.

Lazy-loading is a good thing when used correctly, but these stats strongly suggest that there's a major opportunity to improve performance by removing this functionality from LCP images in particular.

WordPress was one of the pioneers of native lazy-loading adoption, and between versions 5.5 and 5.9, it didn't actually omit the attribute from LCP candidates. So it's worth exploring the extent to which WordPress is still contributing to this anti-pattern.

{{ figure_markup(
  content="72%",
  caption="The percent of mobile pages using native lazy-loading on their LCP image that also use WordPress.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy_wordpress.sql",
  )
}}

According to the [CMS](./cms) chapter, WordPress is used by 35% of pages. So it's surprising to see that 72% of pages that use native lazy-loading on their LCP image are using WordPress, especially given that a fix has been available since January 2022 in version 5.9. One theory that needs more investigation is that plugins may be circumventing the safeguards built into WordPress core by injecting LCP images onto the page with the lazy-loading behavior.

{{ figure_markup(
  content="54%",
  caption="The percent of mobile pages using custom lazy-loading on their LCP image that also use WordPress.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy_wordpress.sql",
  )
}}

Similarly, a disproportionately high percentage of pages that use custom lazy-loading are built with WordPress at 54%. This hints at a wider issue in the WordPress ecosystem about lazy-loading overuse. Rather than being a fixable bug localized to WordPress core, there may be hundreds or thousands of separate themes and plugins contributing to this antipattern.

#### LCP size

A major factor in the time it takes to load the LCP resource is its size over the wire. Larger resources will naturally take longer to load. So for image-based LCP resources, how large are they?

{{ figure_markup(
  image="lcp-image-size-distribution.png",
  caption="Distribution of the size of image-based LCP resources.",
  description="Bar chart showing that at the 10th percentile the LCP image size is 15 KB on desktop and 12 KB on mobile, at the 25th percentile it's 46 KB and 34 KB, 50th percentile it's 124 KB and 95 KB, at the 75th percentile it's 301 KB and 244 KB, and finally at the 90th percentile it's 666 KB on desktop and 565 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1738717687&format=interactive",
  sheets_gid="916137359",
  sql_file="lcp_bytes_distribution.sql"
  )
}}

The median LCP image on mobile is 95 KB. To be honest, we expected much worse!

Desktop pages tend to have larger LCP images across the distribution, with a median size of 124 KB.

{{ figure_markup(
  content="114,285 KB",
  caption="The size of the largest LCP image.",
  classes="big-number",
  sheets_gid="916137359",
  sql_file="lcp_bytes_distribution.sql",
  )
}}

We also looked at the largest LCP image sizes and found a 68,607 KB image on desktop and 114,285 KB image on mobile. While it can be fun to look at how obscenely large these outliers are, let's keep in mind the unfortunate reality that these are active websites visited by real users. Data isn't always free, and performance problems like these start to become [accessibility](./accessibility) problems for users on metered mobile data plans. These are also [sustainability](./sustainability) problems considering how much energy is wasted loading blatantly oversized images like these.

{{ figure_markup(
  image="lcp-image-size-histogram.png",
  caption="Histogram of image-based LCP sizes.",
  description="Bar chart showing the LCP image size is 0 - 100 KB for 1% of desktop and mobile pages, it's 100 - 200 KB for 43% of desktop and 51% of mobile pages, it's 200 - 300 KB for 20% and 19% respectively, it's 300 - 400 KB for 11% and 9%, it's 400 - 500 KB for 6% and 5%, it's 500 - 600 KB for 4% and 3%, it's 600 - 700 KB for 3% and 2%, it's 700 - 800 KB for 2% and 2%, it's 800 - 900 KB for 2% and 1%, it's 900 - 1000 KB for 1% and 1%, and finally it's over 1000 KB for 7% of desktop and 5% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=664106183&format=interactive",
  sheets_gid="201472151",
  sql_file="lcp_bytes_histogram.sql"
  )
}}

Looking at it a different way, the figure above shows the distribution as a histogram in 100 KB increments. This view makes it clearer to see how LCP image sizes fall predominantly in the sub-200 KB range. We also see that 5% of LCP images on mobile are greater than 1,000 KB in size.

How large an LCP image should _optimally_ be depends on many factors. But the fact that 1 in 20 websites are serving megabyte-sized images to our [360px-wide](./methodology#webpagetest) mobile viewports clearly highlights the need for site owners to embrace [responsive images](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images). For more analysis on this topic, refer to the [Media](./media#srcset) and [Mobile Web](./mobile-web#responsive-images) chapters.

#### LCP format

Choice of LCP image format can have [significant effects](./media#bits-per-pixel-by-format) on its byte size and ultimately its loading performance. WebP and AVIF are two relatively newer formats that are found to be more efficient than traditional formats like JPG and PNG.

{{ figure_markup(
  image="lcp-image-formats.png",
  caption="The percent of pages that use a given format for their LCP images.",
  description="Bar chart showing `jpg` is the LCP image format for 67% of desktop and mobile pages using LCP images, `png` for 26% of both, `webp` for 4% of both, `gif` for 2% of both, `svg` for 1% of both, and `avif`, `ico`, `heic`, and `heif` all show as 0% for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=98443529&format=interactive",
  sheets_gid="1281945683",
  sql_file="lcp_format.sql"
  )
}}

According to the [Media](./media#format-adoption) chapter, the JPG format makes up about 40% of all images loaded on mobile pages. However, JPG makes up 67% of all LCP images on mobile, which is 2.5x more common than PNG at 26%. These results may hint at a tendency for pages to use photographic-quality images as their LCP resource rather than digital artwork, as photographs tend to compress better as JPG compared to PNG, but this is just speculation.

4% of pages with image-based LCP use WebP. This is good news for image efficiency, however less than 1% are using AVIF. While AVIF may compress even better than WebP, it's not supported in all modern browsers, which explains its low adoption. On the other hand, WebP _is_ supported in all modern browsers, so its low adoption represents a major opportunity to optimize LCP images and their performance.

#### LCP host

When the LCP content is an external image, as opposed to an inline image or text, the server from which it loads can have an impact on its performance. Loading LCP images from the same origin as the HTML document tends to be faster because the connection has already been established and is able to be reused. Alternatively, LCP images may be loaded cross-origin, which requires time to set up a new connection.

{{ figure_markup(
  image="cross-hosted-lcp-images.png",
  caption="Cross-hosted LCP images",
  description="Bar chart showing same host is used for the LCP image for 55% of desktop and 48% of mobile pages, cross host for 23% and 21% respectively, and other content is the LCP element for 21% of desktop and 31% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=65223493&format=interactive",
  sheets_gid="139284544",
  sql_file="lcp_host.sql"
  )
}}

One in five mobile pages cross-host their LCP images. The time to set up the connection to these third-party hosts could add unnecessary delays to the LCP time. It's best practice to self-host LCP images on the same origin as the document, whenever possible. [Resource hints](../2021/resource-hints) could be used to preconnect to the LCP origin—or better yet, preload the image itself—but we've seen that adoption of these techniques is very low.

<figure>
  <table>
    <thead>
      <tr>
        <th>Domain</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>shopify.com</td>
        <td class="numeric">11%</td>
        <td class="numeric">11%</td>
      </tr>
      <tr>
        <td>wixstatic.com</td>
        <td class="numeric">3%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>blogspot.com</td>
        <td class="numeric">2%</td>
        <td class="numeric">4%</td>
          </tr>
      <tr>
        <td>cloudfront.net</td>
        <td class="numeric">3%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td>wp.com</td>
        <td class="numeric">4%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td>squarespace-cdn.com</td>
        <td class="numeric">4%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>googleusercontent.com</td>
        <td class="numeric">2%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>amazonaws.com</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>wordpress.com</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>cdn-website.com</td>
        <td></td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top 10 cross-origin LCP hosts.",
      sheets_gid="1432074792",
      sql_file="lcp_host_3p.sql",
    ) }}
  </figcaption>
</figure>

CMSs make up the most common hosts of cross-origin LCP images, which isn't too surprising given their popularity. What's interesting is that Shopify's domain accounts for 11% of all cross-origin images, even though it's only used by about 3% of websites, according to last year's [Ecommerce](../2021/ecommerce) chapter. Other CMSs like Wix, Blogger, WordPress, and Squarespace also appear in the list.

It's promising that these CMSs are in control over where and how LCP images are served, but it could be a major effort to switch to a same-origin solution. Cross-origin preloading may be the next best thing.

### LCP conclusions

Taking a step back, LCP performance improved significantly this year. While we don't have a definitive answer for why that happened, the data presented above does give us a few clues.

What we've seen so far is that render-blocking resources are still quite prevalent, very few sites are using advanced prioritization techniques, and more than a third of LCP images are not statically discoverable. If site owners aren't making improvements to these areas _en masse_, perhaps there are changes at the OS or browser level that are responsible for the movement we've seen this year. There are two possible explanations: improved caching in Chrome and improved performance on Android.

The <a hreflang="en" href="https://web.dev/bfcache/">back/forward cache</a>, or _bfcache_, is a browser feature that enables pages to be quickly restored from memory when a user navigates back or forward. By avoiding the network entirely, a bfcache restoration is nearly instantaneous for loading performance.

In late 2021, Chrome <a hreflang="en" href="https://www.smashingmagazine.com/2022/05/performance-game-changer-back-forward-cache/">improved</a> support for bfcache-eligible sites. This meant that users on these sites would start to experience instantaneous LCP performance. We would also expect to see a comparable improvement to TTFB, but this might be a side effect of the way TTFB is measured in CrUX. According to the CrUX documentation, it's technically still an <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology/#experimental-metrics">experimental</a> metric and so it _does not_ account for bfcache and other pre-rendered navigations.

Another hypothesis is that LCP improved across the web due to optimizations to Android. According to a <a hreflang="en" href="https://blog.chromium.org/2022/03/a-new-speed-milestone-for-chrome.html#:~:text=Chrome%20continues%20to%20get%20faster%20on%20Android%20as%20well.%20Loading%20a%20page%20now%20takes%2015%25%20less%20time%2C%20thanks%20to%20prioritizing%20critical%20navigation%20moments%20on%20the%20browser%20user%20interface%20thread">Chromium blog post</a> in March 2022, loading performance on Android improved by 15%. The post doesn't go into too much detail, but it credits the improvement to "_prioritizing critical navigation moments on the browser user interface thread_." 15% is very significant, and it may also help explain why mobile performance outpaced desktop performance in 2022.

The six percentage point improvement to LCP this year can only happen when hundreds of thousands of websites' performance improves. Putting aside the tantalizing question of how that happened, let's take a moment to appreciate that user experiences on the web _are_ getting better. It's hard work, but improvements like these make the ecosystem healthier and we should all be proud.

## First Input Delay (FID)

<a hreflang="en" href="https://web.dev/fid/">First Input Delay</a> (FID) measures the time from the first user interaction like a click or tap to the time at which the browser begins processing the corresponding event handlers.

{{ figure_markup(
  image="good-fid-by-device.png",
  caption="Good FID by device",
  description="Bar chart showing 100% of websites had good FID in 2020, 2021, and 2022. For sites visited on phones this increased from 80% in 2020 to 90% in 2021 and then to 92% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1546220733&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

We say that a website has good FID if at least 75 percent of all navigations across the site are faster than 100 ms. Effectively all websites have "good" FID for desktop users, and this trend has held firm over the years. Mobile FID performance is also exceptionally fast, with 92% of websites having "good" FID, a slight improvement over last year.

While it's great that so many websites have good FID experiences, developers need to be careful not to become too complacent. Google has been <a hreflang="en" href="https://web.dev/better-responsiveness-metric/">experimenting</a> with a new responsiveness metric that could end up replacing FID. This is especially important because sites tend to perform much worse on this metric than FID.

### Interaction to Next Paint (INP)

Interaction to Next Paint (INP) measures the amount of time it takes for the browser to complete the next paint in response to a user interaction. This metric came about after Google <a hreflang="en" href="https://web.dev/responsiveness/">requested feedback</a> on a new responsiveness metric in November 2021.

An interaction in this context refers to a group of events that make up one user operation. Depending on how many interactions a page has, the value of INP is between the 98th and 100th percentile of all interactions.

In contrast, FID currently only looks at a page's first input, and measures the time from user input to when the event handler _starts_ processing. Input means one single event instead of a collection of events to create a user interaction. This doesn't factor in the event handler itself, or how the UI needs to react.

This is an example of how browser-based performance metrics are the best tool we have to understand user experience, but we should always ask if the metric is giving us a meaningful signal about what we are truly trying to measure. INP gives us a more holistic view of responsiveness. One might wonder if FID is actually more about optimizing load performance since it focused on the first input only, when it was really intending to measure interactivity performance. It's true that the upper percentile INP values could still be during page load when the main thread is blocked, but it's exciting to get a better picture of the user's entire page visit.

This is the first year that we have real-user data on INP, so let's break it down in more detail.

#### INP by connection type

A user's effective connection type (ECT) can be described in mobile terms like 4G or 3G according to their actual bandwidth and latency speeds. We can slice the data by this dimension to get a better idea of how network conditions correlate with websites' INP performance.

{{ figure_markup(
  image="inp-by-effective-connection-type.png",
  caption="INP by effective connection type",
  description="Stacked bar chart showing offline connections have 62% of good INP experiences, 28% have needs improvement INP experiences, and 9% have poor INP experiences. For slow-2G it's 26%, 49%, and 25% respectively, for 2G it's 29%, 47%, and 23%, for 3G it's 41%, 46%, and 13%, and finally for 4G it's 66%, 28%, and 6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1646575014&format=interactive",
  sheets_gid="2115992951",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

There's a strong correlation between ECT and INP, likely because a high portion of interactions require data fetching. The fact that offline experiences are closely aligned with those on 4G speeds suggests that there are diminishing returns. Even when every resource in an offline experience is immediately loaded from cache, 38% of websites still fail to meet the bar for "good" INP. This can happen if the client is overburdened with main thread work like DOM construction or JavaScript execution.

#### INP by rank

{{ figure_markup(
  image="inp-performance-by-rank.png",
  caption="INP performance by rank",
  description="Stacked bar chart showing the top 1,000 sites have 37% of good INP experiences, 48% have needs improvement INP experiences, and 16% have poor INP experiences. For the top 10,000 sites it's 33%, 47%, and 20% respectively, for the top 100,000 sites it's 42%, 44%, and 14%, for the top 1,000,000 sites it's 55%, 36%, and 9%, and finally for all sites it's 68% of good, 27% of needs improvement, and 5% of poor experiences.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1730743352&format=interactive",
  sheets_gid="863235163",
  sql_file="web_vitals_by_rank.sql"
  )
}}

One interesting note here is that good INP by rank is almost ascending, and good CWV as a whole is almost in descending order. This might point to two things: users have a higher tolerance for page responsiveness than existing CWV and good INP is less tied to cache hits because it includes I/O.

#### INP vs Long Tasks

{{ figure_markup(
  image="inp-vs-long-tasks-desktop.png",
  caption="INP vs long tasks (desktop)",
  description="Scatter chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=872934514&format=interactive",
  sheets_gid="1958736521",
  sql_file="inp_long_tasks.sql"
  )
}}

{{ figure_markup(
  image="inp-vs-long-tasks-mobile.png",
  caption="INP vs long tasks (mobile)",
  description="Scatter chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=158378876&format=interactive",
  sheets_gid="1958736521",
  sql_file="inp_long_tasks.sql"
  )
}}

Note where the data is but also where the data is not. We really see the hardware constraints and the likelihood of worse network conditions impacting INP on mobile. Additionally, mobile configurations are not made equal. We see the data has a wider distribution here, where desktop is more concentrated around the 50ms INP range.

We also see the consequences of double tap to zoom for mobile: the mandatory 300ms that the browser waits to determine if the interaction was a double or single tap.

### FID metadata and best practices

#### Double Tap to Zoom

{{ figure_markup(
  content="28%",
  caption="The percent of mobile pages that failed the Lighthouse viewport meta tag audit",
  classes="big-number",
  sheets_gid="1839727600",
  sql_file="viewport_meta_zoom_disable.sql",
  )
}}

One lesser known contributor to first input delay on mobile is the double tap to zoom feature. After the first tap from a user, the browser waits an additional 300ms to listen for a second tap in order to perform a zoom action instead of processing an event handler. If there is no second tap, the event handler is processed and 300ms is wasted. The solution is to disable the feature all together, and like much of the web, implementation is dependent on browser. In <a hreflang="en" href="https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/speed/metrics_changelog/2021_05_fid.md">Chrome 91</a>(05/2021), the requirements for automatically disabling double tap to zoom were relaxed to include cases where the meta viewport tag contains one of the following:

- `width=device-width`
- `initial-scale>=1.0` (explicitly or implicitly set)

A <a hreflang="en" href="https://web.dev/viewport/">corresponding lighthouse audit</a> exists, but this only checks for the presence of a `width` or `initial-scale` attribute, it doesn't enforce the value of these attributes. We found that 28% of mobile pages failed the lighthouse audit, which indicates an untapped opportunity to improve FID. For more information on how to disable the feature, see <a hreflang="en" href="https://developer.chrome.com/blog/300ms-tap-delay-gone-away/">300ms tap delay, gone away</a>.

## Cumulative Layout Shift (CLS)

<a hreflang="en" href="https://web.dev/cls/">Cumulative Layout Shift</a> (CLS) is a layout stability metric that represents the amount that content unexpectedly moves around on the screen. We say that a website has good CLS if at least 75 percent of all navigations across the site have a score of 0.1 or less.

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="Good CLS by device",
  description="Bar chart showing the number of websites with good CLS increased from 54% in 2020 to 62% in 2021 to 65% in 2022. For sites visited on phones the it was 60% of sites achieving good CLS in 2020, 62% for 2021, increasing to 74% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=20373607&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

This year, the percentage of websites with "good" CLS improved significantly on mobile devices, going from 62% to 74%. CLS on desktop improved by 3 percentage points to 65%.

While LCP is the bottleneck for most sites to be assessed as having good CWV overall, there's no doubt that the major improvements to mobile CLS this year have had a positive effect on the CWV pass rates.

What might have caused such a steep improvement? Similar to the LCP story, bfcache is a key factor. When pages are restored from memory, the layout doesn't need to be recalculated, so there are few if any layout shifts.

### CLS metadata and best practices

#### Images, iframes, and Videos - No Reserved Space

If all else fails, the browser learns of these elements' dimensions as they load, at which point some amount of the page has likely been rendered. The browser then recalculates page layout with the element's newly discovered dimensions factored in, moving elements that have already rendered around on the screen. There's good news, though: we give these dimensions in advance to the browser by assigning an aspect ratio or width and height to the element.

An open source in browser linter <a hreflang="en" href="https://ausi.github.io/respimagelint/">RespImageLint</a> can help you catch this for images and other performance concerns.

#### Web Font Swap - FOUT

In the page load process, it can take some time for the browser to discover, request, download, and apply a custom web font. While this is all happening, it's possible that text has already rendered on a page. If the custom font isn't yet available, the browser can default to rendering text in a system font. Layout shift happens when the custom font becomes available and existing text, rendered in a system font, switches to the custom font. The amount of layout shift caused depends on how different the fonts are from each other. Below are some strategies to mitigate.

Speed up custom font loading:

- Use preload or priority hints to load font files earlier. You'll want to test this to see what other resources are getting deprioritized so you can weigh the tradeoffs.
- Use WOFF2 format, which offers the most optimized support for compression among all font file formats.
- Review your font caching strategy. Usually, fonts don't change very often so they are a candidate for long term caching.

Reduce font swap layout shift:

- Choose a fallback system font that is similar in size to your custom font
- Style the fallback system font to be as close as possible in size to your custom font using CSS rules like [`ascent-override`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/ascent-override) or [`descent-override`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/descent-override)

Avoid font swap layout shift:

- Don't use a custom font
- Don't swap fonts: use [`font-display: optional`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display) to instruct the browser to only use custom fonts on subsequent pages if any text has rendered in a system font.

#### CSS Animations - Layout Inducing

When implementing CSS animations, use the `transform` CSS rule to move elements around instead of `position`. The former (_transform_) moves elements outside of the document flow, so surrounding elements stay in place. The latter moves elements within the document flow which triggers layout.

#### Banners

Banners like GDPR notices and mailing list invitations can cause layout shift when:

- They are inserted into the document flow after some part of the page has rendered, without reserved space. In this case, we want to use a placeholder element to reserve space before the banner loads.
- They animate onto the page in a way that triggers layout. For the solution here, see the previous section.

## Conclusion

As the industry continues to learn more about CWV, we're seeing steady improvement both in terms of implementation and the metric values themselves. The most visible performance optimization strides are at the browser and framework level where the impact can be felt across many sites at once. Teams like Aurora have set a precedent for collaborating with open source framework owners to introduce sweeping performance improvements. But let's look at the most elusive piece of the performance puzzle: individual site owners.

Google's decision to make CWV part of search ranking catapulted performance to the top of many companies' roadmaps, and we're seeing that reflected in the metrics.  Yet in some cases, developers choose to hack the metrics for SEO's sake rather than actually improve performance. There are as many reasons for this as there are stars in the sky, but one that we cannot ignore is how overwhelming and daunting web performance can be. We've also seen that there are some knowledge gaps to close with common causes of slow performance. The solution? Continue to invest in making web performance accessible. In the years to come, let's emphasize getting web performance knowledge the 'last mile' to the site owner.
