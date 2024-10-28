---
title: Performance
description: Performance chapter of the 2022 Web Almanac covering Core Web Vitals, with deep dives into the Largest Contentful Paint, Cumulative Layout Shift, and First Input Delay metrics and their diagnostics.
authors: [mel-ada, rviscomi]
reviewers: [tunetheweb, pmeenan, 25prathamesh, estelle, konfirmed]
analysts: [rviscomi, 25prathamesh, siakaramalegos, konfirmed]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1TPA_4xRTBB2fQZaBPZHVFvD0ikrR-4sNkfJfUEpjibs/
mel-ada_bio: Mel Ada is a software engineer on the Web Performance team at Etsy. Her current involvement in the community includes co-organizing the NY Web Performance Meetup and speaking about recent works.
rviscomi_bio: Rick Viscomi is a DevRel engineer at Google, focusing on web performance. He is the co-author of <a hreflang="en" href="https://usingwpt.com/">Using WebPageTest</a>, a book about web performance testing. He also co-maintains HTTP Archive and is the Editor-in-Chief of the Web Almanac.
featured_quote: These results show that sites absolutely do have responsiveness issues, despite the rosy picture painted by FID. Regardless of whether INP becomes a CWV metric, your users will thank you if you start optimizing it now.
featured_stat_1: 39%
featured_stat_label_1: LCP images that are not statically discoverable
featured_stat_2: 22%
featured_stat_label_2: Pages that are ineligible for bfcache due to `no-store`
featured_stat_3: 20%
featured_stat_label_3: Top 1k websites that would have good CWV with INP
---

## Introduction

Web performance is crucial to user experience. We've all bounced from a site due to slow load times, or worse, have not been able to access important information. Additionally, numerous <a hreflang="en" href="https://wpostats.com/">case studies</a> have demonstrated that an improvement in web performance results in an improvement in conversion and engagement for businesses. Surprisingly, the industry spotlight is quite elusive for web performance—why is this? Some may say web performance is tough to define and even more challenging to measure.

How do we measure something that is hard to define in the first place? As [Sergey Chernyshev](https://twitter.com/sergeyche), creator of <a hreflang="en" href="https://github.com/ux-capture/ux-capture">UX Capture</a>, says, "_The best way to measure performance is to be embedded into the user's brain to understand exactly what they're thinking as they use the site_".  We can't—and shouldn't in case that was unclear—do this, so what are our options?

Thankfully, there's a way to measure some aspects of performance automatically! We know the browser is in charge of loading a page, and it goes through a checklist of steps each time. Depending on which step the browser is on, we can tell how far along the site is in the page load process. Conveniently, a [number of performance timeline APIs](https://developer.mozilla.org/docs/Web/API/Performance) are used to fire off timestamps when the browser gets to certain page load steps.

It's important to note that these metrics are only our best guess at how to gauge user experience. For example, just because the browser fired an event that an element has been painted onto the screen, does that always mean it was visible to the user at that time? Additionally, as the industry grew, more and more metrics showed up while some became deprecated. It can be complicated to know where to start and understand what performance metrics are telling us about our users, especially for folks newer to the field.

This chapter focuses on Google's solution to the problem: <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals</a> (CWV), web performance metrics introduced in 2020 and made <a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">a signal in search ranking</a> during 2021. Each of the three metrics covers an important area of user experience: loading, interactivity, and visual stability. The public <a hreflang="en" href="https://developer.chrome.com/docs/crux">Chrome UX Report</a> (CrUX) dataset is Chrome's view of how websites are performing on CWV. There's zero setup on the developer's part; Chrome automatically collects and publishes data from <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#eligibility">eligible websites</a>, for users who have opted in. Using this dataset, we're able to get insights into the web's performance over time.

Although the spotlight of this chapter, it's important to note that CWV are relatively new to the field and not the only way to measure web performance. We chose to focus on these metrics because the search ranking influence was effective almost exactly one year ago, and this year's data gives us insights on how the web is adjusting to this major shift in the industry and where room for opportunity might still exist. CWV are a common baseline that allows performance to be loosely comparable across sites, but it's up to site owners to determine which metrics and strategies are best for their sites. As much as we wish otherwise, there's no way to fit the entire history of the industry or all the different ways to evaluate performance in one chapter.

The CWV program suggests a clearly defined approach to measuring how users actually experience performance—a first for the industry. Are CWV the answer to helping the web become more performant? This chapter examines where the web is currently with CWV and takes a look into the future.

<p class="note">Disclosure: This chapter is coauthored by an employee of Google, which created the Core Web Vitals program. This chapter and its underlying analysis were reviewed and approved by others not affiliated with Google.</p>

## Core Web Vitals

Now that it's been a year since CWV were added as a ranking signal in Google Search, let's see how the program may have influenced user experiences on the web.

{{ figure_markup(
  image="good-core-web-vitals-by-device.png",
  caption="The percent of websites having good CWV, segmented by device and year.",
  description="Bar chart showing that in 2020 34% of websites used on desktop had good Core Web Vitals, versus 24% on phone. In 2021 that increased to 41% and 29% respectively, and in  2022 that further increased to 44% of desktop sites and 39% of phone sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1239858329&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

In 2021, 29% of websites were assessed as having good CWV for mobile users. This was a significant step up from 2020, representing a 5 percentage point increase. However, the progress in 2022 was an even bigger leap forward, now with 39% of websites having good CWV on mobile—representing a further 10 point increase!

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

We segmented sites by their relative popularity (rank) and year, without distinguishing between desktop and mobile. What's interesting is that it seems websites across the board generally got more performant this year, regardless of their popularity. The top 1,000 most popular websites improved most significantly, a 16 percentage point increase to 53%, with all ranks improving by 10 points or more. The most popular websites also tend to have the best CWV experience, which is not too surprising if we assume that they have bigger engineering teams and budgets.

To better understand why mobile experiences have gotten so much better this year, let's dive deeper into each individual CWV metric.

## Largest Contentful Paint (LCP)

<a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP) is the time from the start of the navigation until the largest block of content is visible in the viewport. This metric represents how quickly users are able to see what is likely the most meaningful content.

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

<a hreflang="en" href="https://web.dev/articles/ttfb">Time to First Byte</a> (TTFB) is the time from the start of the navigation to the first byte of data returned to the client. It's our first step in the web performance checklist, representing the backend component of LCP performance, particularly network connection speeds and server response times.

{{ figure_markup(
  image="good-ttfb-by-device.png",
  caption="The percent of websites having good TTFB, segmented by device and year.",
  description="Bar chart showing the number of websites with good TTFB increased from 47% in 2020 to 51% in 2021 to 52% in 2022. For sites visited on phones the it was fairly stable with 41% of sites achieving good TTFB in 2020, 39% in 2021 and 40% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=628253519&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

As an aside, note that earlier this year Chrome <a hreflang="en" href="https://developer.chrome.com/docs/crux/release-notes#202204">changed</a> the threshold for "good" TTFB from 500 ms to 800 ms. In the chart above, all historical data is using this new threshold for comparison purposes.

With that in mind, the percentage of websites having good TTFB has not actually improved very much. In the past year, websites' desktop and mobile experiences have gotten one percentage point better, which is nice but doesn't account for the gains observed to LCP. While this doesn't rule out improvements to the "needs improvement" and "poor" ends of the TTFB distribution, the "good" end is what matters most.

Another complication is that TTFB is still considered to be an <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#experimental-metrics">experimental</a> metric in CrUX. According to the CrUX documentation, TTFB _does not_ factor in more advanced navigation types like pre-rendered and back/forward navigations. This is somewhat of a blind spot, so if there were improvements in these areas, they wouldn't necessarily affect the TTFB results.

### First Contentful Paint (FCP)

<a hreflang="en" href="https://web.dev/articles/fcp">First Contentful Paint</a> (FCP) is the time from the start of the request to the first meaningful content painted to the screen. In addition to TTFB, this metric can be affected by render-blocking content. The threshold for "good" FCP is 1,800 ms.

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

In the absence of TTFB data to the contrary, this indicates that there were major improvements to frontend optimizations, like eliminating render-blocking resources or better resource prioritization. However, as we'll see in the following sections, it seems like there may have been something else entirely to thank for the LCP improvements this year.

### LCP metadata and best practices

These performance improvements may not actually be due to changes to the websites themselves. Changes to network infrastructure, operating systems, or browsers could also impact LCP performance at web-scale like this, so let's dig into some heuristics.

#### Render-blocking resources

A page is considered to have render-blocking resources if resources hold up the initial paint (or render) of the page. This is particularly likely for critical scripts and styles that are loaded over the network. Lighthouse includes an <a hreflang="en" href="https://web.dev/render-blocking-resources/">audit</a> that checks for these resources, which we've run on the home page of each website in CrUX. You can learn more about how we test these pages in our [Methodology](./methodology).

{{ figure_markup(
  image="pages-passing-render-blocking-resources-audit.png",
  caption="The percent of pages that pass the render-blocking Lighthouse audit , segmented by device and year.",
  description='Bar chart showing 19% of mobile pages passed the "render-blocking resources" audit in 2021. In 2022 this increased slightly to 20%, and we also added the desktop equivalent which was 14%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1619115021&format=interactive",
  sheets_gid="1317344415",
  sql_file="render_blocking_resources.sql"
  )
}}

Surprisingly, there was no dramatic improvement in the percent of pages that have render-blocking resources.  Only 20% of mobile pages pass the audit, which is a mere 1 percentage point increase over last year.

2022 is the first year in which we have Lighthouse data for desktop. So while we're unable to compare it against previous years, it's still interesting to see that many fewer desktop pages pass the audit relative to mobile, in spite of the trend of desktop pages tending to have better LCP and FCP performance.

#### LCP content types

The LCP element can be a number of different types of content, like an image, a heading, or a paragraph of text.

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

It's clear that images are the most common type of LCP content, with the `img` element representing the LCP on 42% of mobile pages. Mobile pages are slightly more likely to have heading and paragraph elements be the LCP than desktop pages, while desktop pages are more likely to have image elements as the LCP. One possible explanation is the way that mobile layouts—especially in portrait orientation—make images that are _not_ responsive appear smaller, giving way to large blocks of text like headings and paragraphs to become the LCP elements.

The second most popular LCP element type is `div`. This is a generic HTML container that could be used for text or styling background images. To help disambiguate how often these elements contain images or text, we can evaluate the `url` property of the [LCP API](https://developer.mozilla.org/docs/Web/API/LargestContentfulPaint).  According to the <a hreflang="en" href="https://www.w3.org/TR/largest-contentful-paint/#dom-largestcontentfulpaint-url">specification</a>, when this property is set, the LCP content must be an image.

{{ figure_markup(
  image="top-lcp-content-types.png",
  caption="The percent of pages that use each type of LCP content.",
  description="Bar chart showing an image is the LCP content type on 82% of desktop pages and 72% of mobile pages, it is text on 17% and 26% respectively, and an inline image on 2% of desktop and 1% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=839846485&format=interactive",
  sheets_gid="872701281",
  sql_file="lcp_resource_type.sql"
  )
}}

We see that 72% of mobile pages and 82% of desktop pages have images as their LCP. For example, these images may be traditional `img` elements or CSS background images. This suggests that the vast majority of the `div` elements seen in the previous figure are images as well. 26% of mobile pages and 17% of desktop pages have text-based content as their LCP.

1% of pages actually use inline images as their LCP content. This is almost always a bad idea for a number of reasons, mostly around caching and complexity.

#### LCP prioritization

After the HTML document is loaded, there are two major factors that affect how quickly the LCP resource itself can be loaded: discoverability and prioritization. We'll explore [LCP discoverability](#lcp-static-discoverability) later, but first let's look at how LCP images are prioritized.

Images are not loaded at high priority by default, but thanks to the new <a hreflang="en" href="https://web.dev/articles/fetch-priority">Priority Hints</a> API, developers can explicitly set their LCP images to load at high priority to take precedence over non-essential resources.

{{ figure_markup(
  content="0.03%",
  caption="The percent of pages that use `fetchpriority=high` on their LCP element.",
  classes="big-number",
  sheets_gid="600760184",
  sql_file="lcp_element_data_2.sql"
  )
}}

0.03% of pages use `fetchpriority=high` on their LCP elements. Counterproductively, a handful of pages actually _lower_ the priority over their LCP images: 77 pages on mobile and 104 on desktop.

`fetchpriority` is still very new and not supported everywhere, but there's little to no reason why it shouldn't be in every developer's toolbox. [Patrick Meenan](https://twitter.com/patmeenan), who helped develop the API, [describes it](https://twitter.com/patmeenan/status/1460276602479251457) as a "cheat code" given how easy it is to implement relative to the potential improvements.

#### LCP static discoverability

Ensuring an LCP image is discovered early is key to the browser loading it as soon as possible. Even the [prioritization](#lcp-prioritization) improvements that we discussed above, cannot help if the browser does not know it needs to load the resource until later.

An LCP image is considered to be _statically discoverable_ if its source URL can be parsed directly from the markup sent by the server. This definition includes sources defined within `picture` or `img` elements as well as sources that are explicitly preloaded.

One caveat is that text-based LCP content is always statically discoverable based on this definition. However, text-based content may sometimes depend on client-side rendering or web fonts, so consider these results as lower bounds.

```html
<img data-src="kitten.jpg" class="lazyload">
```

Custom lazy-loading techniques like the example above are one way that images are prevented from being statically discoverable, since they rely on JavaScript to update the `src` attribute. Client-side rendering may also obscure the LCP content.

{{ figure_markup(
  content="39%",
  caption="The percent of mobile pages on which the LCP element was not statically discoverable.",
  classes="big-number",
  sheets_gid="1465687616",
  sql_file="lcp_preload_discoverable.sql"
  )
}}

39% of mobile pages have LCP elements that are not statically discoverable. This figure is even worse on desktop at 44% of pages, potentially as a consequence of the previous section's finding that LCP content is more likely to be an image on desktop pages.

This is the first year that we're looking at this metric, so we don't have historical data for comparison, but these results hint at a big opportunity to improve the load delay of LCP resources.

#### LCP preloading

When the LCP image is not statically discoverable, <a hreflang="en" href="https://web.dev/preload-critical-assets/">preloading</a> can be an effective way to minimize the load delay. Of course, it would be better if the resource was statically discoverable to begin with, but addressing that may require a complex rearchitecture of the way the page loads. Preloading is somewhat of a quick fix by comparison, as it can be implemented with a single HTTP header or `meta` tag.

{{ figure_markup(
  content="0.56%",
  caption="The percent of mobile pages that preload their LCP images.",
  classes="big-number",
  sheets_gid="1465687616",
  sql_file="lcp_preload_discoverable.sql"
  )
}}

Only about 1 in 200 mobile pages preload their LCP images. This figure falls to about 1 in 400 (0.25%) when we only consider pages whose LCP images are not statically discoverable.

Preloading statically discoverable images might be considered overkill, as the browser should already know about the image thanks to its <a hreflang="en" href="https://web.dev/preload-scanner/">preload scanner</a>. However, it can help load critical images earlier above other statically discoverable images that may be earlier in the HTML—for example header images or mega menu images. This is especially true for <a hreflang="en" href="https://caniuse.com/?search=fetchpriority">browsers that do not support `fetchpriority`</a>.

These results show that the overwhelming majority of the web could benefit from making their LCP images more discoverable. Loading LCP images sooner, either by making them statically discoverable or preloading them, can go a long way to improving LCP performance. But as with all things related to performance, always experiment to understand what's best for your specific site.

#### LCP initiator

When an LCP resource is not statically discoverable, there must be some other, more convoluted process by which it gets discovered.

{{ figure_markup(
  image="top-lcp-initiators-among-pages-whose-lcp-is-not-statically-discoverable.png",
  caption="The percent of pages whose LCP is not statically discoverable and initiated from a given resource.",
  description="Bar chart showing that `html` is the initiator on 29% of desktop and 28% of mobile pages, `css` on 11% and 9% respectively, `unknown` on 5% and 4%, and finally `other` is the initiator on 0% of both desktop and mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1835555974&format=interactive",
  sheets_gid="1866346503",
  sql_file="lcp_initiator_type_undiscoverable.sql"
  )
}}

27% of mobile pages have LCP images that are discovered in the HTML _after_ the preload scanner has already run, typically due to script-based lazy-loading or client-side rendering.

8% of mobile pages depend on an external stylesheet for their LCP resource, for example using the `background-image` property. This adds a link in the resource's critical request chain and may further complicate LCP performance if the stylesheet is loaded cross-origin.

4% of mobile pages have an undiscoverable LCP initiator whose type we're unable to detect. These may be a combination of HTML and CSS initiators.

Both script- and style-based discoverability issues are bad for performance, but their effects can be mitigated with preloading.

#### LCP lazy-loading

Lazy-loading is an effective performance technique to delay when non-critical resources start loading, usually until they're in or near the viewport. With precious bandwidth and rendering power freed up, the browser can load critical content earlier in the page load. A problem arises when lazy-loading is applied to the LCP image itself, because that prevents the browser from loading it until much later.

{{ figure_markup(
  content="9.8%",
  caption="The percent of mobile pages having image-based LCP that set `loading=lazy` on it.",
  classes="big-number",
  sheets_gid="600760184",
  sql_file="lcp_element_data_2.sql"
  )
}}

Nearly 1 in 10 of pages with `img`-based LCP are using the native `loading=lazy` attribute. Technically, these images are statically discoverable, but the browser will need to wait to start loading them until it's laid out the page to know whether they will be in the viewport. LCP images are always in the viewport, by definition, so in reality none of these images should have been lazy-loaded. For pages whose LCP varies by viewport size or initial scroll position from deep-linked navigations, it's worth testing whether eagerly loading the LCP candidate results in better overall performance.

Note that the percentages in this section are out of only those pages in which the `img` element is the LCP, not all pages. For reference, recall that this accounts for 42% of pages.

{{ figure_markup(
  content="8.8%",
  caption="The percent of mobile pages having image-based LCP that use custom lazy-loading on it.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy.sql"
  )
}}

As we showed earlier, one way that sites might polyfill the native lazy-loading behavior is to assign the image source to a `data-src` attribute and include an identifier like `lazyload` in the class list. Then, a script will watch the positions of images with this class name relative to the viewport, and swap the `data-src` value for the native `src` value to trigger the image to start loading.

Nearly as many pages are using this kind of custom lazy-loading behavior as native lazy-loading, at 8.8% of pages with `img`-based LCP.

Beyond the adverse performance effects of lazy-loading LCP images, native image lazy-loaded is <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">supported</a> by all major browsers, so custom solutions may be adding unnecessary overhead. In our opinion, while some custom solutions may provide more granular control over when images load, developers should remove these extraneous polyfills and defer to the user agent's native lazy-loading heuristics.

Another benefit to using native lazy-loading is that browsers like Chrome are <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=996963">experimenting with using heuristics to ignore the attribute on probable LCP candidates</a>. This is only possible with native lazy-loading, so custom solutions would not benefit from any improvements in this case.

{{ figure_markup(
  content="18%",
  caption="The percent of mobile pages having image-based LCP that use native or custom lazy-loading on it.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy.sql"
  )
}}

Looking at pages that use either technique, 18% of pages with `img`-based LCP are unnecessarily delaying the load of their most important images.

Lazy-loading is a good thing when used correctly, but these stats strongly suggest that there's a major opportunity to improve performance by removing this functionality from LCP images in particular.

WordPress was one of the pioneers of native lazy-loading adoption, and between versions 5.5 and 5.9, it didn't actually omit the attribute from LCP candidates. So let's explore the extent to which WordPress is still contributing to this anti-pattern.

{{ figure_markup(
  content="72%",
  caption="The percent of mobile pages using native lazy-loading on their LCP image that also use WordPress.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy_wordpress.sql"
  )
}}

According to the [CMS](./cms) chapter, [WordPress is used by 35% of pages](./cms#most-popular-cmss). So it's surprising to see that 72% of pages that use native lazy-loading on their LCP image are using WordPress, given that a fix has been available since January 2022 in version 5.9. One theory that needs more investigation is that plugins may be circumventing the safeguards built into WordPress core by injecting LCP images onto the page with the lazy-loading behavior.

{{ figure_markup(
  content="54%",
  caption="The percent of mobile pages using custom lazy-loading on their LCP image that also use WordPress.",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy_wordpress.sql"
  )
}}

Similarly, a disproportionately high percentage of pages that use custom lazy-loading are built with WordPress at 54%. This hints at a wider issue in the WordPress ecosystem about lazy-loading overuse. Rather than being a fixable bug localized to WordPress core, there may be hundreds or thousands of separate themes and plugins contributing to this anti-pattern.

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
  sql_file="lcp_bytes_distribution.sql"
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

How large an LCP image should _optimally_ be depends on many factors. But the fact that 1 in 20 websites are serving megabyte-sized images to our [360px-wide](./methodology#webpagetest) mobile viewports clearly highlights the need for site owners to embrace [responsive images](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images). For more analysis on this topic, refer to the [Media](./media#srcset) and [Mobile Web](./mobile-web#responsive-images) chapters.

#### LCP format

Choice of LCP image format can have [significant effects](./media#bits-per-pixel-by-format) on its byte size and ultimately its loading performance. WebP and AVIF are two relatively newer formats that are found to be more efficient than traditional formats like JPG (or JPEG) and PNG.

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

#### LCP image optimization

The previous section looked at the popularity of various image formats used by LCP resources. Another way that developers can make their LCP resources smaller and load more quickly is to utilize efficient compression settings. The JPG format can be lossily compressed to eke out unnecessary bytes without losing too much image quality. However, some JPG images may not be compressed enough.

Lighthouse includes an <a hreflang="en" href="https://web.dev/uses-optimized-images/">audit</a> that will measure the byte savings from setting JPGs to compression level 85. If the image is more than 4 KB smaller as a result, the audit fails and it's considered an opportunity for optimization.

{{ figure_markup(
  image="lcp-image-optimization.png",
  caption="Histogram of byte savings for JPG-based LCP images.",
  description="Bar chart showing how many bytes can be saved by optimizing JPG images that are the LCP resource. 68% of mobile pages have 0 kilobytes of savings, 20% have up to 100 KB, 5% 200 KB, 2% 300 KB, 1% 400 KB, and 4% 500 KB or more. Desktop pages have a similar distribution.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=894221089&format=interactive",
  sheets_gid="369396330",
  sql_file="lcp_wasted_bytes.sql"
  )
}}

Of the pages whose LCP images are JPG-based and flagged by Lighthouse, 68% of them do not have opportunities to improve the LCP image via lossy compression alone. These results are somewhat surprising and suggest that the majority of "hero" JPG images use appropriate quality settings. That said, 20% of these pages could save as much as 100 KB and 4% can save 500 KB or more. Recall that the majority of LCP images are under 200 KB, so this is some serious savings!

#### LCP host

In addition to the size and efficiency of the LCP image itself, the server from which it loads can also have an impact on its performance. Loading LCP images from the same origin as the HTML document tends to be faster because the open connection can be reused.

However, LCP images may be loaded from other origins, like asset domains and image CDNs. When this happens, setting up the additional connection can take valuable time away from the LCP allowance.

{{ figure_markup(
  image="cross-hosted-lcp-images.png",
  caption="Cross-hosted LCP images",
  description="Bar chart showing same host is used for the LCP image for 55% of desktop and 48% of mobile pages, cross host for 23% and 21% respectively, and other content is the LCP element for 21% of desktop and 31% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=65223493&format=interactive",
  sheets_gid="139284544",
  sql_file="lcp_host.sql"
  )
}}

One in five mobile pages cross-host their LCP images. The time to set up the connection to these third-party hosts could add unnecessary delays to the LCP time. It's best practice to self-host LCP images on the same origin as the document, whenever possible. [Resource hints](../2021/resource-hints) could be used to preconnect to the LCP origin—or better yet, preload the image itself—but these techniques are not very widely adopted.

### LCP conclusions

LCP performance has improved significantly this year, especially for mobile users. While we don't have a definitive answer for why that happened, the data presented above does give us a few clues.

What we've seen so far is that render-blocking resources are still quite prevalent, very few sites are using advanced prioritization techniques, and more than a third of LCP images are not statically discoverable. Without concrete data to suggest that site owners or large publishing platforms are concertedly optimizing these aspects of their LCP performance, other places to look are optimizations at the OS or browser level.

According to a <a hreflang="en" href="https://blog.chromium.org/2022/03/a-new-speed-milestone-for-chrome.html#:~:text=Chrome%20continues%20to%20get%20faster%20on%20Android%20as%20well.%20Loading%20a%20page%20now%20takes%2015%25%20less%20time%2C%20thanks%20to%20prioritizing%20critical%20navigation%20moments%20on%20the%20browser%20user%20interface%20thread">Chromium blog post</a> in March 2022, loading performance on Android improved by 15%. The post doesn't go into too much detail, but it credits the improvement to "_prioritizing critical navigation moments on the browser user interface thread_." This may help explain why mobile performance outpaced desktop performance in 2022.

The six percentage point improvement to LCP this year can only happen when hundreds of thousands of websites' performance improves. Putting aside the tantalizing question of how that happened, let's take a moment to appreciate that user experiences on the web _are_ getting better. It's hard work, but improvements like these make the ecosystem healthier and are worth celebrating.

## Cumulative Layout Shift (CLS)

<a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a> (CLS) is a layout stability metric that represents the amount that content unexpectedly moves around on the screen. We say that a website has good CLS if at least 75% of all navigations across the site have a score of 0.1 or less.

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

What happened to improve mobile CLS by such a significant margin? One likely explanation is Chrome's new and improved <a hreflang="en" href="https://web.dev/bfcache/">back/forward cache</a> (bfcache), which was released in version 96 in mid-November 2021. This change enabled eligible pages to be pristinely restored from memory during back and forward navigations, rather than having to "start over" by fetching resources from the HTTP cache—or worse, over the network—and reconstructing the page.

{{ figure_markup(
  image="monthly-cls-lcp.png",
  caption="Monthly timeseries of the percent of websites having good mobile LCP and CLS.",
  description="Line chart showing the monthly percent of websites that whose mobile LCP and CLS is rated good. More websites have good CLS than LCP. The CLS line trends upwards starting at 62% in June 2021, bumps up to 67% in September 2021, and another bump to 73% starting in January 2022. LCP is also increasing, but the trend starts in November 2021 at 47% and steadily rises to 54% in May 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1531911610&format=interactive",
  sheets_gid="1879625698",
  sql_file="monthly_cls_lcp.sql"
  )
}}

This chart shows LCP and CLS performance over time at monthly granularity. Over a two month period starting in January 2022, after Chrome released the bfcache update, the percent of websites having good CLS started to climb much more quickly than before.

But how did bfcache improve CLS so much? Due to the way Chrome instantly restores the page from memory, its layout is settled and unaffected by any of the initial instability that typically occurs during loading.

One theory why LCP experiences didn't improve as dramatically is that back/forward navigations were already pretty fast thanks to standard HTTP caching. Remember, the threshold for "good" LCP is 2.5 seconds, which is pretty generous assuming any critical resources would already be in cache, and there are no bonus points for making "good" experiences even faster.

### CLS metadata and best practices

Let's explore how much of the web is adhering to CLS best practices.

#### Explicit dimensions

The most straightforward way to avoid layout shifts is to reserve space for content by setting dimensions, for example using `height` and `width` attributes on images.

{{ figure_markup(
  content="72%",
  caption="The percent of mobile pages that fail to set explicit dimensions on at least one image.",
  classes="big-number",
  sheets_gid="1160188541",
  sql_file="cls_unsized_images.sql"
  )
}}

72% of mobile pages have unsized images. This stat alone doesn't give the full picture, because unsized images don't always result in user-perceived layout shifts, for example if they load outside of the viewport. Still, it's a sign that site owners may not be closely adhering to CLS best practices.

{{ figure_markup(
  image="unsized-images.png",
  caption="Distribution of the number of unsized images per page.",
  description="Bar chart showing the 10, 25, 50, 75, and 90th percentile number of images per page. The values for mobile are 0, 0, 2, 11, and 26 unsized images per page, respectively. Desktop pages have between 1 and 3 more unsized images per page in the 50 to 90th percentiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=449564630&format=interactive",
  sheets_gid="1160188541",
  sql_file="cls_unsized_images.sql"
  )
}}

The median web page has 2 unsized images and 10% of mobile pages have at least 26 unsized images.

Having any unsized images on the page can be a liability for CLS, but perhaps a more important factor is the size of the image. Large images contribute to bigger layout shifts, which make CLS worse.

{{ figure_markup(
  image="unsized-image-height.png",
  caption="Distribution of the heights of unsized images.",
  description="Bar chart showing the 10, 25, 50, 75, and 90th percentile height of unsized images. The values for mobile are 16, 40, 99, 184, and 267px tall, respectively. The values for desktop are much larger: 18, 42, 113, 237, and 410px.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1273679516&format=interactive",
  sheets_gid="309190465",
  sql_file="cls_unsized_image_height.sql"
  )
}}

The median unsized image on mobile has a height of 99px. Given that our [test devices](./methodology#webpagetest) have a mobile viewport height of 512px, that's about 20% of the viewport area that would shift down, assuming full-width content. Depending on where that image is in the viewport when it loads, it could cause a <a hreflang="en" href="https://web.dev/articles/cls#layout-shift-score">layout shift score</a> of at most 0.2, which more than exceeds the 0.1 threshold for "good" CLS.

Desktop pages tend to have larger unsized images. The median unsized image on desktop is 113px tall and the 90th percentile has a height of 410px.

{{ figure_markup(
  content="4,048,234,137,947,990,000px",
  caption="The height of the largest unsized image.",
  classes="really-big-number",
  sheets_gid="309190465",
  sql_file="cls_unsized_image_height.sql"
  )
}}

In what we can only hope is either a measurement error or a seriously mistaken web developer, the largest unsized image that we found is an incredible 4 quintillion pixels tall. That image is so big it could stretch from the Earth to the moon… three million times. Even if that is some kind of one-off mistake, the next biggest unsized image is still 33,554,432 pixels tall. Either way, that's a big layout shift.

#### Animations

Some <a hreflang="en" href="https://web.dev/non-composited-animations/">non-composited</a> CSS animations can affect the layout of the page and contribute to CLS. The <a hreflang="en" href="https://web.dev/articles/optimize-cls#animations-%F0%9F%8F%83%E2%80%8D%E2%99%80%EF%B8%8F">best practice</a> is to use `transform` animations instead.

{{ figure_markup(
  content="38%",
  caption="The percent of mobile pages that have non-composited animations.",
  classes="big-number",
  sheets_gid="309190465",
  sql_file="cls_unsized_image_height.sql"
  )
}}

38% of mobile pages use these layout-altering CSS animations and risk making their CLS worse. Similar to the unused images issue, what matters most for CLS is the degree to which the animations affect the layout relative to the viewport.

{{ figure_markup(
  image="animations.png",
  caption="Distribution of the number of non-composited animations per page.",
  description="Bar chart showing the 10, 25, 50, 75, and 90th percentiles of the number of non-composited animations per page. At the 75th percentile, pages have 2 non-composited animations, and at the 90th percentile they have 10 for mobile and 11 for desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=6443199&format=interactive",
  sheets_gid="603122500",
  sql_file="cls_animations.sql"
  )
}}

The distribution above shows that most pages don't use these types of animations, and the ones that do only use it sparingly. At the 75th percentile, pages use them twice.

#### Fonts

In the page load process, it can take some time for the browser to discover, request, download, and apply a web font. While this is all happening, it's possible that text has already been rendered on a page. If the web font isn't yet available, the browser can default to rendering text in a system font. Layout shifts happen when the web font becomes available and existing text, rendered in a system font, switches to the web font. The amount of layout shift caused depends on how different the fonts are from each other.

{{ figure_markup(
  content="82%",
  caption="The percent of mobile pages that use web fonts.",
  classes="big-number",
  sheets_gid="https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/edit#gid=1517999851",
  sql_file="../fonts/font_usage_over_time.sql"
  )
}}

82% of pages use web fonts, so this section is highly relevant to most site owners.

{{ figure_markup(
  image="font-display-usage.png",
  caption="Adoption of `font-display` values.",
  description="Bar chart showing the percent of pages that use the various `font-display` values. 29% of mobile pages use swap, 17% block, 8% auto, 2% fallback, and less than 1% use optional. The values for desktop are similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1648924039&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/edit#gid=1599822681&range=G11",
  sql_file="../fonts/font_display_usage.sql"
  )
}}

One way to avoid font-induced layout shifts is to use [`font-display: optional`](https://developer.mozilla.org/docs/Web/CSS/@font-face/font-display), which will never swap in a web font after the system text has already been shown. However, as noted by the [Fonts](./fonts#font-display) chapter, less than 1% of pages are taking advantage of this directive.

Even though `optional` is good for CLS, there are UX tradeoffs. Site owners might be willing to have some layout instability or a noticeable flash of unstyled text (FOUT) if it means that their preferred font can be displayed to users.

Rather than hiding the web fonts, another strategy to mitigate CLS is to load them as quickly as possible. Doing so would, if all goes well, display the web font before the system text is rendered.

{{ figure_markup(
  image="fonts-resource-hints.png",
  caption="Adoption of resource hints for font resources.",
  description="Bar chart showing the percent of pages that use each type of resource hint on web fonts. 32% of mobile pages use dns-prefetch, 20% preload, 16% preconnect, and 2% preload. The values for desktop are similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1831399490&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/edit#gid=592046045&range=F11",
  sql_file="../fonts/resource_hints_usage.sql"
  )
}}

According to the [Fonts](./fonts#resource-hints) chapter, 20% of mobile pages are preloading their web fonts. One challenge with preloading the font is that the exact URL may not be known upfront, for example if using a service like Google Fonts. Preconnecting to the font host is the next best option for performance, but only 16% of pages are using that, which is half as many pages that use the less-performant option to prefetch the DNS.

#### bfcache eligibility

We've shown how impactful bfcache can be for CLS, so it's worth considering eligibility as a somewhat indirect best practice.

The best way to tell if a given page is eligible for bfcache is to <a hreflang="en" href="https://web.dev/bfcache/#test-to-ensure-your-pages-are-cacheable">test it in DevTools</a>. Unfortunately, there are over <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1li0po_ETJAIybpaSX5rW_lUN62upQhY0tH4pR5UPt60/edit?usp=sharing">100 eligibility criteria</a>, many of which are hard or impossible to measure in the lab. So rather than looking at bfcache eligibility as a whole, let's look at a few criteria that are more easily measurable to get a sense for the lower bound of eligibility.

{{ figure_markup(
  image="bfcache-unload.png",
  caption="Usage of `unload` by site rank.",
  description="Bar chart showing the percent of pages that are ineligible for bfcache due to setting `unload` handlers, grouped by site popularity rank. 36% of the top 1 thousand mobile pages set this handler, 33% of the top 10 thousand, 27% of the top 100 thousand, 21% of the top million, and 17% of all mobile pages. Desktop pages tend to use the `unload` handler slightly more often by a couple of percentage points across the ranks.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=63175690&format=interactive",
  sheets_gid="996465265",
  sql_file="bfcache_unload.sql"
  )
}}

The [`unload`](https://developer.mozilla.org/docs/Web/API/Window/unload_event) event is a discouraged way to do work when the page is in the process of going away (unloading). Besides there being <a hreflang="en" href="https://web.dev/bfcache/#never-use-the-unload-event">better ways</a> to do that, it's also one way to make your page ineligible for bfcache.

17% of all mobile pages set this event handler, however the situation worsens the more popular the website is. In the top 1k, 36% of mobile pages are ineligible for bfcache for this reason.

{{ figure_markup(
  image="bfcache-nostore.png",
  caption="Usage of `Cache-Control: no-store` by site rank.",
  description="Bar chart showing the percent of pages that are ineligible for bfcache due to setting the `Cache-Control: no-store` header on the main document. 28% of the top 1 thousand mobile pages set this header, 27% of the top 10 thousand, 28% of the top 100 thousand, 27% of the top million, and 22% of all mobile pages. Desktop pages use this header slightly more often by up to 2 percentage points.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1655848232&format=interactive",
  sheets_gid="1063873438",
  sql_file="bfcache_cachecontrol_nostore.sql"
  )
}}

The [`Cache-Control: no-store`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cache-Control#no-store) header tells user agents never to cache a given resource. When set on the main HTML document, this makes the entire page ineligible for bfcache.

22% of all mobile pages set this header, and 28% of mobile pages in the top 1k. This and the `unload` criteria are not mutually exclusive, so combined we can only say that at least 22% of mobile pages are ineligible for bfcache.

To reiterate, it's not that these things cause CLS issues. However, fixing them may make pages eligible for bfcache, which we've been shown to be an indirect yet powerful tool for improving layout stability.

### CLS conclusions

CLS is the CWV metric that improved the most in 2022 and it appears to have had a significant impact on the number of websites that have "good" overall CWV.

The cause of this improvement seems to come down to Chrome's launch of bfcache, which is reflected in the January 2022 CrUX dataset. However, at least a fifth of sites are ineligible for this feature due to aggressive `no-store` caching policies or discouraged use of the `unload` event listener. Correcting these anti-patterns is CLS's "one weird trick" to improve performance.

There are other, more direct ways site owners can improve their CLS. Setting `height` and `width` attributes on images is the most straightforward one. Optimizing how animations are styled and how fonts load are two other—admittedly more complex—approaches to consider.

## First Input Delay (FID)

<a hreflang="en" href="https://web.dev/articles/fid">First Input Delay</a> (FID) measures the time from the first user interaction like a click or tap to the time at which the browser begins processing the corresponding event handlers. A website has "good" FID if at least 75 percent of all navigations across the site are faster than 100 ms.

{{ figure_markup(
  image="good-fid-by-device.png",
  caption="Good FID by device",
  description="Bar chart showing 100% of websites had good FID in 2020, 2021, and 2022. For sites visited on phones this increased from 80% in 2020 to 90% in 2021 and then to 92% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1546220733&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

Effectively all websites have "good" FID for desktop users, and this trend has held firm over the years. Mobile FID performance is also exceptionally fast, with 92% of websites having "good" FID, a slight improvement over last year.

While it's great that so many websites have good FID experiences, developers need to be careful not to become too complacent. Google has been <a hreflang="en" href="https://web.dev/better-responsiveness-metric/">experimenting with a new responsiveness metric</a> that could end up replacing FID, which is especially important because sites tend to perform much worse on [this new metric](./#interaction-to-next-paint-inp) than FID.

### FID metadata and best practices

Let's dig deeper into the ways that responsiveness can be improved across the web.

#### Disabling double-tap to zoom

Some mobile browsers, including Chrome, wait at least 250 ms before handling tap inputs to make sure users aren't attempting to <a hreflang="en" href="https://developer.chrome.com/blog/300ms-tap-delay-gone-away">double-tap to zoom</a>. Given that the threshold for "good" FID is 100 ms, this behavior makes it impossible to pass the assessment.

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

There's an easy fix, though. Including a `meta` viewport tag in the document head like the one above will prompt the browser to render the page as wide at the device width, which makes text content more legible and eliminates the need for double-tap to zoom.

This is one of the quickest, easiest, and least intrusive ways to meaningfully improve responsiveness and all mobile pages should be setting it.

{{ figure_markup(
  content="7.3%",
  caption="The percent of mobile pages that do not set a viewport `meta` tag.",
  classes="big-number",
  sheets_gid="1839727600",
  sql_file="viewport_meta_zoom_disable.sql"
  )
}}

7.3% of mobile pages fail to set the `meta` viewport directive. Recall that about 8% of mobile websites fail to meet the threshold for "good" FID. This is a significant proportion of the web that is needlessly slowing down their sites' responsiveness. Correcting this may very well mean the difference between failing and passing the FID assessment.

#### Total Blocking Time (TBT)

<a hreflang="en" href="https://web.dev/tbt/">Total Blocking Time</a> (TBT) is the time between the <a hreflang="en" href="https://web.dev/articles/fcp">First Contentful Paint</a> (FCP) and <a hreflang="en" href="https://web.dev/tti/">Time to Interactive</a> (TTI), representing the total amount of time that the main thread was blocked and unable to respond to user inputs.

TBT is often used as a lab-based proxy for FID, due to the challenges of realistically simulating user interactions in synthetic tests.

{{ figure_markup(
  image="tbt.png",
  caption="Distribution of lab-based TBT per page.",
  description="Bar chart showing the 10, 25, 50, 75, and 90th percentile of lab-based TBT per page. The values for mobile pages are 0.2, 0.6, 1.7, 3.6, and 6.4 seconds, respectively. The values for desktop pages are much faster, with fewer than 100ms in the top 50 percent, about 250ms in the 75th percentile, and 600ms in the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1459512477&format=interactive",
  sheets_gid="528722499",
  sql_file="fid_tbt.sql"
  )
}}

Note that these results are sourced from the lab-based TBT performance of pages in the HTTP Archive dataset. This is an important distinction because for the most part we've been looking at real-user performance data from the CrUX dataset.

With that in mind, we see that mobile pages have significantly worse TBT than desktop pages. This isn't surprising given that our [Lighthouse](./methodology#lighthouse) mobile environment is intentionally configured to run with a throttled CPU in a way that emulates a low-end mobile device. Nevertheless, the results show that the median mobile page has a TBT of 1.7 seconds, meaning that if this were a real-user experience, no taps within 1.7 seconds of FCP would be responsive. At the 90th percentile, a user would have to wait 6.3 seconds before the page became responsive.

Despite the fact that these results come from synthetic testing, they're based on the actual JavaScript served by real websites. If a real user on similar hardware tried to access one of these sites, their TBT might not be too different. That said, the key difference between TBT and FID is that the latter relies on the user actually interacting with the page, which they can do at any time before, during, or after the TBT window, all leading to vastly different FID values.

#### Long tasks

<a hreflang="en" href="https://web.dev/long-tasks-devtools/">Long tasks</a> are periods of script-induced CPU activity at least 50 ms long that prevent the main thread from responding to input. Any long task is liable to cause responsiveness issues if a user attempts to interact with the page at that time.

Note that, like the TBT analysis above, this section draws from lab-based data. As a result, we're only able to measure long tasks during the page load observation window, which starts when the page is requested and ends after 60 seconds or 3 seconds of network inactivity, whichever comes first. A real user may experience long tasks throughout the entire lifetime of the page.

{{ figure_markup(
  image="long-tasks.png",
  caption="Distribution of lab-based long tasks per page.",
  description="Bar chart showing the 10, 25, 50, 75, and 90th percentiles of the sum of lab-based long tasks per page. The values for mobile are 0.8, 1.7, 3.3, 5.3, and 8.0 seconds of long tasks per page. The values for desktop are much faster at fewer than 100ms in the first 50%, followed by 700ms at the 75th percentile, and 1.4 seconds at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1004723255&format=interactive",
  sheets_gid="1849899474",
  sql_file="fid_long_tasks.sql"
  )
}}

The median mobile web page has 3.3 seconds-worth of long tasks, compared to only 0.4 seconds for desktop pages. Again, this shows the outsized effects of CPU speed on responsiveness heuristics. At the 90th percentile, mobile pages have at least 8.0 seconds of long tasks.

It's also worth noting that these results are significantly higher than the distribution of TBT times. Remember that TBT is bounded by FCP and TTI and FID is dependent on both how busy the CPU is and when the user attempts to interact with the page. These post-TTI long tasks can also create frustrating responsiveness experiences, but unless they occur during the first interaction, they wouldn't be represented by FID. This is one reason why we need a field metric that more comprehensively represents users' experiences throughout the entire page lifetime.

### Interaction to Next Paint (INP)

<a hreflang="en" href="https://web.dev/articles/inp">Interaction to Next Paint</a> (INP) measures the amount of time it takes for the browser to complete the next paint in response to a user interaction. This metric was created after Google <a hreflang="en" href="https://web.dev/responsiveness/">requested feedback</a> on a proposal to improve how we measure responsiveness. Many readers may be hearing about this metric for the first time, so it's worth going into a bit more detail about how it works.

An _interaction_ in this context refers to the user experience of providing an input to a web application and waiting for the next frame of visual feedback to be painted on the screen. The only inputs that are considered for INP are clicks, taps, and key presses. The INP value itself is taken from one of the worst interaction latencies on the page. Refer to the <a hreflang="en" href="https://web.dev/articles/inp#what-is-inp">INP documentation</a> for more info on how it's calculated.

Unlike FID, INP is a measure of all interactions on the page, not just the first one. It also measures the entire time until the next frame is painted, unlike FID which only measures the time until the event handler starts processing. In these ways, INP is a much more representative metric of the holistic user experience on the page.

A website has "good" INP if 75% of its INP experiences are faster than 200 ms. A website has "poor" INP if the 75th percentile is greater than or equal to 500 ms. Otherwise, it's INP is assessed as "needs improvement".

{{ figure_markup(
  image="inp-device.png",
  caption="Distribution of INP performance by device.",
  description="Bar chart showing the percent of websites having good, needs improvement, or poor INP by device. 95% of desktop websites have good INP, 4% need improvement, and 1% are poor. 55% of mobile websites have good INP, 36% need improvement, and 8% are poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=755106375&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

55% of websites have "good" INP on mobile, 36% are rated "needs improvement", and 8% have "poor" INP. The desktop story of INP is more similar to FID in that 95% of websites are rated "good", 4% are rated "needs improvement", and 1% are "poor".

The enormous disparity between desktop and mobile users' INP experiences is much wider than with FID. This illustrates the extent to which mobile devices are struggling to keep up with the overwhelming amount of work websites do, and all signs point to the increasing reliance on <a hreflang="en" href="https://httparchive.org/reports/state-of-javascript?start=earliest&end=latest&view=grid#bytesJs">JavaScript</a> as a major factor.

#### INP by rank

To see how unevenly distributed INP performance is across the web, it's useful to segment websites by their popularity ranking.

{{ figure_markup(
  image="inp-mobile-performance-by-rank.png",
  caption="Mobile INP performance by rank.",
  description="Stacked bar chart showing INP performance on mobile devices segmented by rank. The top 1,000 sites have 27% of good INP experiences, 52% have needs improvement INP experiences, and 20% have poor INP experiences. For the top 10,000 sites it's 25%, 50%, and 24% respectively, for the top 100,000 sites it's 31%, 50%, and 18%, for the top 1,000,000 sites it's 42%, 46%, and 12%, and finally for all sites it's 55% of good, 27% of needs improvement, and 5% of poor experiences.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1034889047&format=interactive",
  sheets_gid="805166525",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

27% of the top 1k most popular websites have good mobile INP. As the site popularity decreases, the percent having good mobile INP does something funny; it worsens at bit at the top 10k rank to 25%, then it improves to 31% at the top 100k, 41% at the top million, and it ultimately lands at 55% for all websites. Except for the top 1k, it seems that INP performance is inversely proportional to site popularity.

{{ figure_markup(
  image="js-bytes-rank.png",
  caption="Median amount of JavaScript loaded per page, by rank.",
  description="Bar chart showing the median kilobytes of JavaScript per page, grouped by device and site rank. The median top 1 thousand mobile page loads 604 KB of JavaScript, 680 in the top 10 thousand, 610 in the top 100 thousand, 583 in the top million, and 462 overall. The values for desktop follow the same trend and are larger by tens of kilobytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1725756250&format=interactive",
  sheets_gid="1423103831",
  sql_file="js_bytes_rank.sql"
  )
}}

When we look at the amount of JavaScript that the median mobile page loads for each of these ranks, it follows the same funny pattern! The median mobile page in the top 1k loads 604 KB of JavaScript, then it increases to 680 KB for the top 10k before dropping all the way down to 462 KB over all websites. These results don't prove that loading—and using—more JavaScript necessarily causes poor INP, but it definitely suggests a correlation exists.

#### INP as a hypothetical CWV metric

INP is not an official CWV metric, but [Annie Sullivan](https://twitter.com/anniesullie), who is the Tech Lead for the CWV program at Google, has [commented](https://twitter.com/anniesullie/status/1535208365374185474) about its intended future, saying "_INP is still experimental! Not a Core Web Vital yet, but we hope it can replace FID._"

This raises an interesting question: hypothetically, if INP were to be a CWV metric today, how different would the pass rates be?

{{ figure_markup(
  image="cwv-fid-inp-device.png",
  caption="Comparison of the percent of websites having good CWV with FID and INP, by device.",
  description="Bar chart showing the percent of websites that would be assessed as having good CWV, with either FID or INP as the responsiveness metric. 44% of desktop websites have good CWV with FID, compared to 43% with INP. 40% of mobile websites have good CWV with FID, compared to 31% with INP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=56387241&format=interactive",
  sheets_gid="805166525",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

For desktop experiences, the situation wouldn't change much. 43% of websites would have good CWV with INP, compared to 44% with FID.

However, the disparity is much more dramatic among websites' mobile experiences, which would fall to 31% having good CWV with INP, from 40% with FID.

{{ figure_markup(
  image="cwv-fid-inp-rank.png",
  caption="Comparison of the percent of mobile websites having good mobile CWV with FID and INP, by rank.",
  description="Bar char showing the percent of mobile websites assessed as having good CWV, with either FID or INP as the responsiveness metric. 52% of the 1 thousand most popular mobile websites would have good CWV with FID, compared to 20% with INP. 42% of the top 10 thousand with FID and 18% with INP. 38% of the top 100 thousand with FID and 20% with INP. 38% of the top million with FID and 25% with INP. 40% of all websites with FID and 31% with INP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=2082509168&format=interactive",
  sheets_gid="805166525",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

The situation gets even starker when we look at mobile experiences by site rank. Rather than 52% of the top 1k websites having good CWV with FID, only 20% of them would have good CWV with INP, a decrease of 32 percentage points. So even though the most popular websites overperform with FID compared to all websites (52% versus 40%), they actually _underperform_ with INP (20% versus 31%).

The story is similar for the top 10k websites, which would decrease by 24 percentage points with INP as a CWV. Websites in this rank would have the lowest rate of good CWV with INP. As we saw in the previous section, this is also the rank with the highest usage of JavaScript. The rate of good CWV converges with FID and INP as the ranks become less popular, with the difference falling to 18, 13, and 9 percentage points respectively.

These results show that the most popular websites have the most work to do to get their INP into shape.

{{ figure_markup(
  image="cwv-inp-tech.png",
  caption="Percent change of websites having good CWV from FID to INP, by technology.",
  description="Bar chart showing the percent of mobile websites that would start failing the CWV assessment switching from FID to INP, grouped by the CMS or JavaScript framework used. In decreasing order of the most popular technologies, the values are: WordPress 6%, React 11%, WooCommerce 3%, Shopify 6%, Vue.js 8%, RequireJS 10%, Wix 15%, Joomla 6%, Drupal 8%, 1C-Bitrix 39%, Squarespace 1%, AMP 10%, PrestaShop 7%, Emotion 10%, Angular 5%, Magento 6%, TYPO3 CMS 6%, Nuxt.js 9%, Duda 14%, Adobe Experience Manager 9%, Gatsby 14%, GoDaddy Website Builder 10%, and Pixnet 86%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=457714899&format=interactive",
  height=632,
  sheets_gid="1104559069",
  sql_file="web_vitals_by_technology.sql"
  )
}}

In this chart we're looking at the percent of a given technology's websites that would no longer be considered as having "good" CWV should FID be replaced with INP.

Two things jump out in this chart: 1C-Bitrix and Pixnet, which are CMSs and would have an enormous proportion of their websites ceasing to pass the CWV assessment with INP. Pixnet stands to lose 86% of its websites, down from 98% to 13%! The passing rate for 1C-Bitrix would fall from 79% to 40%, a difference of 39%.

11% of websites using the React framework would no longer pass CWV. Wix, which is now [the second most popular CMS](./cms#most-popular-cmss), uses React. 15% of its websites would not have "good" CWV. Proportionally though, there would still be more Wix websites passing CWV than React websites overall, at 24% and 19% respectively, but INP would narrow that gap.

WordPress is the most popular technology in the list and 6% of its 2.3 million websites would no longer have "good" CWV. Its passing rate would fall from 30% to 24%.

Squarespace would have the least amount of movement due to this hypothetical change, only losing 1% of its websites' "good" CWV. This suggests that Squarespace websites not only have a fast first interaction but also consistently fast interactions throughout the page experience. Indeed, the <a hreflang="en" href="https://datastudio.google.com/s/sM9D7EUjxU8">CWV Technology Report</a> shows Squarespace significantly outperforming other CMSs at INP, having over 80% of their websites passing the INP threshold.

#### INP and TBT

What actually makes INP a better responsiveness metric than FID? One way to answer that question is to look at the correlation between field-based INP and FID performance and lab-based TBT performance. TBT is a direct measure of how unresponsive a page _can_ be, but it can never be a CWV itself because it doesn't actually measure the <a hreflang="en" href="https://web.dev/user-centric-performance-metrics/">user-perceived experience</a>.

This section draws from Annie Sullivan's <a hreflang="en" href="https://colab.sandbox.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">research</a> using the May 2022 dataset.

{{ figure_markup(
  image="tbt-fid.png",
  alt="",
  caption='Scatterplot visualizing the correlation between FID and TBT. (<a hreflang="en" href="https://colab.sandbox.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">Source</a>)',
  description="Scatterplot visualization showing the correlation of field-based FID and lab-based TBT per page. Most FID values are in the 0-50ms range with TBT values widely ranging from 0-10 seconds. There's a small cluster of FID values around 250ms with a TBT of around 0ms."
  )
}}

This chart shows the relationship between pages' FID and TBT responsiveness. The solid horizontal line at 100 ms represents the threshold for "good" FID, and most pages fall comfortably under this threshold.

The most notable attribute of this chart is the dense area in the bottom left corner, which appears to be smeared out across the TBT axis. The length of this smear represents pages having high TBT and low FID, which illustrates the low degree of correlation between FID and TBT.

There's also a patch of pages that have low TBT and a FID of about 250 ms. This area represents pages that have <a hreflang="en" href="https://developer.chrome.com/blog/300ms-tap-delay-gone-away">tap delay</a> issues due to missing a `<meta name=viewport>` tag. These are outliers that can be safely ignored for this analysis's purposes.

The <a hreflang="en" href="https://en.wikipedia.org/wiki/Kendall_rank_correlation_coefficient">Kendall</a> and <a hreflang="en" href="https://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient">Spearman</a> coefficients of correlation for this distribution are 0.29 and 0.40, respectively.

{{ figure_markup(
  image="tbt-inp.png",
  caption='Scatterplot visualizing the correlation between INP and TBT. (<a hreflang="en" href="https://colab.sandbox.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">Source</a>)',
  description="Scatterplot visualization showing the correlation of field-based INP and lab-based TBT per page. Most INP values are in the 0-750ms range with TBT values ranging from 0-5 seconds."
  )
}}

This is the same chart, but with INP instead of FID. The solid horizontal line here represents the 200 ms threshold for "good" INP. Compared to FID, there are many more pages above this line and not assessed as "good".

Pages in this chart are more densely packed in the bottom left corner, which signifies the higher degree of correlation between FID and TBT. There's still a smear, but it's not as pronounced.

The Kendall and Spearman coefficients of correlation for this distribution are 0.34 and 0.45, respectively.

<figure>
  <blockquote>
  <p>First, is INP correlated with TBT? Is it more correlated with TBT than FID? Yes and yes!</p>
  <p>But they are both correlated with TBT; is INP catching more problems with main thread blocking JavaScript? We can break down the percent of sites meeting the "good" threshold: yes it is!</p>
  </blockquote>
  <figcaption>—Annie Sullivan on <a href="https://twitter.com/anniesullie/status/1525161893450727425">Twitter</a></figcaption>
</figure>

As Annie notes, both metrics are correlated with TBT, but she concludes that INP is more strongly correlated, making it a better responsiveness metric.

### FID conclusions

These results show that sites absolutely do have responsiveness issues, despite the rosy picture painted by FID. Regardless of whether INP becomes a CWV metric, your users will thank you if you start optimizing it now.

Nearly one in ten mobile sites are leaving free performance on the table by failing to disable double-tap to zoom. This is something all sites should be doing; it's only one line of HTML and it benefits both FID and INP. Run Lighthouse on your page and look for the <a hreflang="en" href="https://web.dev/viewport/">viewport</a> audit to be sure.

By taking a hypothetical look at INP as a CWV, we can see just how much work there is to be done just to get back to FID-like levels. The most popular mobile websites would be especially affected by such a change as a consequence of their (over)use of JavaScript. Some CMSs and JavaScript frameworks would be hit harder than others, and it'll take an ecosystem-wide effort to collectively rein in the amount of client-side work that they do.

## Conclusion

As the industry continues to learn more about CWV, we're seeing steady improvement both in terms of implementation and across all top-level metric values themselves. The most visible performance optimization strides are at the platform level, like Android and bfcache improvements, given that their impact can be felt across many sites at once. But let's look at the most elusive piece of the performance puzzle: individual site owners.

Google's decision to make CWV part of search ranking catapulted performance to the top of many companies' roadmaps, especially in the [SEO](./seo#core-web-vitals-cwv) industry. Individual site owners are certainly working hard to improve their performance and played a major role in the CWV improvements over the last year, even if those individual efforts are much harder to spot at this scale.

That said, there's still more work to be done. Our research shows opportunities to improve LCP resources' prioritization and static discoverability. Many sites are still failing to disable double-tap to zoom to avoid artificial interactivity delays. New research into INP has uncovered responsiveness problems that were easy to overlook with FID. Regardless of whether INP becomes a CWV, we should always strive to deliver fast and responsive experiences, and the data shows that we can be doing better.

At the end of the day, there will always be more work to do, which is why the most impactful thing we can do is to continue making web performance more approachable. In the years to come, let's emphasize getting web performance knowledge the "last mile" to site owners.
