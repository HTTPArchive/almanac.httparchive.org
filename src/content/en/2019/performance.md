---
part_number: II
chapter_number: 7
title: Performance
authors: [rviscomi]
reviewers: [JMPerez, obto, sergeychernyshev, zeman]
---

## Intro

Performance is a visceral part of the user experience. For [many websites](https://wpostats.com/), an improvement to the user experience by speeding up the page load time aligns with an improvement to conversion rates. Conversely, when performance is poor, users don't convert as often and have even been observed [rage clicking](https://blog.fullstory.com/rage-clicks-turn-analytics-into-actionable-insights/) on the page in frustration.

There are many ways to quantify web performance. The most important thing is to measure what actually matters to users. Events like `onload` or `DOM content loaded` may not necessarily reflect what users experience visually. For example, an email client might have a very fast onload event but the only thing loaded is the interstitial progress bar, meanwhile the inbox contents are loading asynchronously. The loading metric that matters for this web app is the "time to inbox", and focusing on the `onload` event may be misleading. For that reason this chapter will look at more modern and universally applicable paint, load, and interactivity metrics to try to capture how users are actually experiencing the page.

There are two kinds of performance data: lab and field. You may have heard these referred to as synthetic and real-user measurement (or RUM). Measuring performance in the lab ensures that each website is tested under common conditions like browser, connection speed, physical location, cache state, etc. This guarantee of consistency makes each website comparable with one another. On the other hand, measuring performance in the field represents how users actually experience the web in all of the infinite combinations of conditions that we could never capture in the lab. For the purposes of this chapter and understanding real-world user experiences, we'll look at field data.

## The state of performance

Almost all of the other chapters in the Web Almanac are based on data from the [HTTP Archive](https://httparchive.org/). In order to capture how real users experience the web, we need a different dataset. In this section we're using the [Chrome UX Report](http://bit.ly/chrome-ux-report) (CrUX), a public dataset from Google that consists of all the same websites as the HTTP Archive and aggregates how Chrome users actually experience them. Experiences are categorized by:

- the form factor of the users' devices
  - desktop
  - phone
  - tablet
- users' effective connection type (ECT) in mobile terms
  - offline
  - slow 2G
  - 2G
  - 3G
  - 4G
- users' geographic location

Experiences are measured monthly including paint, load, and interactivity metrics. The first metric we'll look at is [First Contentful Paint](https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics#first_paint_and_first_contentful_paint) (FCP). This is the time users spend waiting for the page to display something useful to the screen, like an image or text. Next, we'll look at look at a loading metric, [Time to First Byte](https://csswizardry.com/2019/08/time-to-first-byte-what-it-is-and-why-it-matters/) (TTFB). This is a measure of how long the web page took from the time of the user's navigation until they received the first byte of the response. And finally, the last field metric we'll look at is [First Input Delay](https://developers.google.com/web/updates/2018/05/first-input-delay) (FID). This is a relatively new metric and one that represents parts of the UX other than loading performance. It measures the time from a user's first interaction with a page's UI until the time the browser's main thread is ready to process the event.

So let's dive in and see what kind of insights we can find.

### FCP

<figure>
// Chart: flame distribution of 07_01
<figcaption>Figure 1. Distribution of websites' fast, average, and slow FCP performance.</figcaption>
</figure>

In Figure 1 above you can see how FCP experiences are distributed across the web. Out of the millions of websites in the CrUX dataset, this chart compresses the distribution down to 1,000 websites where each vertical slice represents a single website. The chart is sorted by the percent of fast FCP experiences, which are those occurring in less than 1 second. Slow experiences occur in 2.5 seconds or more, and average experiences are everything in between. At the extremes of the chart, there are some websites with almost 100% fast experiences and some websites with almost 100% slow experiences. In between, websites have a combination of fast, average, and slow performance that seems to lean more towards fast or average than slow, which is good.

<aside>Note that when a user experiences slow performance, it's hard to say what the reason might be. It could be that the website itself was built poorly and inefficiently. Or there could be other environmental factors like the user's slow connection, empty cache, etc. So when looking at this field data we prefer to say that the user experiences themselves are slow and not necessarily the websites.</aside>

In order to categorize whether a website is sufficiently **fast** we will use the [PageSpeed Insights](https://developers.google.com/speed/docs/insights/v5/about#categories) (PSI) methodology where at least 90% of the website's FCP experiences must be faster than 1 second. Similarly a sufficiently **slow** website has 10% or more FCP experiences slower than 2.5 seconds. We say a website has **average** performance when it doesn't meet either of these conditions.

<figure>
// Chart: Bar distribution of 07_03
<figcaption>Figure 2. Distribution of websites labelled as having fast, average, or slow FCP.</figcaption>
</figure>

<figure>

Fast FCP | Average FCP | Slow FCP
-- | -- | --
2.17% | 37.55% | 60.28%

<figcaption>Figure 3. Table of the percent of websites labelled as having fast, average, or slow FCP.</figcaption>
</figure>

In Figures 2 and 3, the results show that only 2.17% of websites are considered fast while 60.28% of websites are considered slow. To help us understand how users experience FCP across different devices, let's segment by form factor.

#### FCP by device

<figure>
// Chart: Flame distribution of 07_01b
<figcaption>Figure 4. Distribution of _desktop_ websites' fast, average, and slow FCP performance.</figcaption>
</figure>

<figure>
// Chart: Flame distribution of 07_01c
<figcaption>Figure 5. Distribution of _phone_ websites' fast, average, and slow FCP performance.</figcaption>
</figure>

In Figures 4 and 5 above, the FCP distributions of 1,000 sample websites are broken down by desktop and phone. It's subtle, but the torso of the desktop fast FCP distribution appears to be more convex than the distribution for phone users. This visual approximation suggests that desktop users experience a higher overall proportion of fast FCP. To verify this we can apply the PSI methodology to each distribution.

<figure>
// Chart: Bar distributions of 07_03b
<figcaption>Figure 6. Distribution of websites labelled as having fast, average, or slow FCP, broken down by device type.</figcaption>
</figure>

<figure>

Device | Fast FCP | Average FCP | Slow FCP
-- | -- | -- | --
desktop | 2.80% | 39.40% | 57.80%
phone | 1.76% | 35.62% | 62.62%

<figcaption>Figure 7. Table of websites labelled as having fast, average, or slow FCP, broken down by device type.</figcaption>
</figure>

According to PSI's classification, 2.80% of websites have fast FCP experiences overall for desktop users, compared to 1.76% for mobile users. The entire distribution is skewed slightly faster for desktop experiences, with fewer slow websites and more in the fast and average category.

#### FCP by ECT

<figure>
// Chart: Bar distribution of 07_03c
<figcaption>Figure 8. Distribution of websites labelled as having fast, average, or slow FCP, broken down by <abbr title="effective connection type">ECT</abbr>.</figcaption>
</figure>

<figure>

Speed | Fast FCP | Average FCP | Slow FCP
-- | -- | -- | --
4G | 2.31 | 40.10 | 57.59
3G | 0.04 | 3.48 | 96.49
2G | 0.03 | 0.30 | 99.68
slow-2G | 0.03 | 0.08 | 99.89

<figcaption>Figure 9. Table of the percent of websites labelled as having fast, average, or slow FCP, broken down by <abbr title="effective connection type">ECT</abbr>.</figcaption>
</figure>

In Figures 8 and 9 above, FCP experiences are grouped by the ECT of the user experience. Interestingly, there is a correlation between ECT speed and the percent of websites serving fast FCP. As the ECT speeds decrease, the proportion of fast experiences approaches zero. 8.44% of websites serve fast FCP to users with 4G ECT while 57.59% of those websites serve slow FCP. 96.49% of websites serve slow FCP to users with 3G ECT, 99.68% to 2G ECT, and 99.89% to slow-2G ECT. These results suggest that websites almost never serve fast FCP consistently to users on slow connections.

#### FCP by geo

<figure>
// Chart: Bar distribution of 07_03d
<figcaption>Figure 10. Distribution of websites labelled as having fast, average, or slow FCP, broken down by geo.</figcaption>
</figure>

Finally, we can slice FCP by users' geography (geo). The chart above shows the top 23 geos having the highest number of distinct websites, an indicator of overall popularity of the open web. The geos are sorted by their percent of websites having sufficiently fast FCP experiences. At the top of the list are three [Asia-Pacific](https://en.wikipedia.org/wiki/Asia-Pacific) (APAC) geos: Korea, Taiwan, and Japan. This could be explained by the availability of extremely [fast network connection speeds in these regions](https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds). Korea has 11.10% of websites meeting the fast FCP bar and only 28.00% rated as slow FCP. Recall that the global distribution of fast/average/slow websites is approximately 2/38/60, making Korea a significantly positive outlier.

Other APAC geos tell a different story. Thailand, Vietnam, Indonesia, and India all have fewer than 1% of fast websites. These geos also have more than double the proportion of slow websites than Korea.

### TTFB

[Time to First Byte](https://web.dev/time-to-first-byte) (TTFB) is a measure of how long the web page took from the time of the user's navigation until they received the first byte of the response.

<figure>
![Navigation Timing API diagram of the events in a page navigation](/static/images/2019/07_Performance/nav-timing.png)
<figcaption>Figure 11. Navigation Timing API diagram of the events in a page navigation.</figcaption>
</figure>

To help explain TTFB and the many factors that affect it, let's borrow a diagram from the Navigation Timing API spec. In Figure 11 above, TTFB is the duration from `startTime` to `responseStart`, including everything in between: `unload`, `redirects`, `AppCache`, `DNS`, `SSL`, `TCP`, and the time the server spends handling the request. Given that context, let's see how users are experiencing this metric.

<figure>
// Chart: Flame distribution of 07_07
<figcaption>Figure 12. Distribution of websites' fast, average, and slow TTFB performance.</figcaption>
</figure>

Similar to the previous FCP chart, this is a view of 1,000 representative samples ordered by fast TTFB. A [fast TTFB](https://developers.google.com/speed/docs/insights/Server#recommendations) is one that happens in under 0.2 seconds (200 ms), a slow TTFB happens in 1 second or more, and everything in between is average.

Looking at the curve of the fast proportions, the shape is quite different from that of FCP. There are very few websites that have a fast TTFB greater than 75%, while more than half are below 25%.

Let's apply a TTFB speed label to each website, similar to the PSI methodology used above for FCP. If a website serves fast TTFB to 90% or more user experiences, it's labelled as **fast**. Otherwise if it serves **slow** TTFB to 10% or more user experiences, it's slow. If neither of those conditions apply, it's **average**.

<figure>
// Chart: Bar distribution of 07_08
<figcaption>Figure 13. Distribution of websites labelled as having fast, average, or slow TTFB.</figcaption>
</figure>

<figure>

Fast TTFB | Average TTFB | Slow TTFB
-- | -- | --
0.13% | 30.67% | 69.20%

<figcaption>Figure 14. Table of the percent of websites labelled as having fast, average, or slow TTFB.</figcaption>
</figure>

69.20% of websites have slow TTFB. This is significant because TTFB is a blocker for all other performance metrics to follow. A user cannot possibly experience a fast FCP if the TTFB takes more than 1 second. Recall from the previous FCP section that about 98% of websites do not have fast FCP. Therefore the ~70% of websites that have slow TTFB are completely ineligible to be considered as having fast FCP.

#### TTFB by geo

<figure>
// Chart: Bar distribution of 07_08d
<figcaption>Figure 15. Distribution of websites labelled as having fast, average, or slow TTFB, broken down by geo.</figcaption>
</figure>

Now let's look at the percent of websites serving fast TTFB to users in different geos. APAC geos like Korea, Taiwan, and Japan are still outperforming users from the rest of the world. But no geo has more than 3% of websites with fast TTFB.

### FID

The last field metric we'll look at is [First Input Delay](https://developers.google.com/web/updates/2018/05/first-input-delay) (FID). This metric represents the time from a user's first interaction with a page's UI until the time the browser's main thread is ready to process the event. Note that this doesn't include the time applications spend actually handling the input. At worst, slow FID results in a page that appears unresponsive and a frustrating user experience.

Let's start by defining some thresholds. According to the [PSI methodology](https://developers.google.com/speed/docs/insights/v5/about#categories), a **fast** FID is one that happens in less than 50 ms. This gives the application enough time to handle the input event and provide feedback to the user in a time that feels instantaneous. A **slow** FID is one that happens in 250 ms or more. Everything in between is **average**.

<figure>
// Chart: Flame distribution of 07_02
<figcaption>Figure 16. Distribution of websites' fast, average, and slow FID performance.</figcaption>
</figure>

You know the drill by now. This chart shows the distribution of 1,000 websites' fast, average, and slow FID. This is a dramatically different chart from the ones for FCP and TTFB. The curve of fast FID very slowly descends from 100% to 75% then takes a nosedive. The overwhelming majority of FID experiences are fast for most websites.

<figure>
// Chart: Bar distribution of 07_04
<figcaption>Figure 17. Distribution of websites labelled as having fast, average, or slow TTFB.</figcaption>
</figure>

<figure>

Fast FID | Average FID | Slow FID
-- | -- | --
26.61% | 42.03% | 31.35%

<figcaption>Figure 18. Table of the percent of websites labelled as having fast, average, or slow FID.</figcaption>
</figure>

The PSI methodology for labelling a website as having sufficiently fast or slow FID is slightly different than that of FCP. For a site to be fast, 95% of its FID experiences must be fast. A site is slow if 5% of its FID experiences are slow.

The distribution of fast, average, and slow websites appears to be more balanced, with 26.61% of websites qualifying as fast and 31.35% as slow.

#### FID by device

<figure>
// Chart: Flame distribution of 07_02b
<figcaption>Figure 19. Distribution of _desktop_ websites' fast, average, and slow FID performance.</figcaption>
</figure>

<figure>
// Chart: Flame distribution of 07_02c
<figcaption>Figure 20. Distribution of _phone_ websites' fast, average, and slow FID performance.</figcaption>
</figure>

Breaking FID down by device, it becomes clear that there are two very different stories. Desktop users enjoy fast FID almost all the time. Sure there are some websites that throw out a slow experience now and then, but the results are predominantly fast. Mobile users, on the other hand, have what seem to be one of two experiences: pretty fast (but not quite as often as desktop) and almost never fast. The latter is experienced by users on only the tail ~10% of websites, but this is still a substantial difference.

<figure>
// Chart: Bar distributions of 07_04b
<figcaption>Figure 21. Distribution of websites labelled as having fast, average, or slow FID, broken down by device type.</figcaption>
</figure>

<figure>

Device | Fast FID | Average FID | Slow FID
-- | -- | -- | --
desktop | 70.32% | 23.20% | 6.48%
phone | 13.76% | 43.21% | 43.03%

<figcaption>Figure 22. Table of websites labelled as having fast, average, or slow FID, broken down by device type.</figcaption>
</figure>

When we apply the PSI labelling to desktop and phone experiences, the distinction becomes crystal clear. 70.32% of websites' FID experienced by desktop users are fast compared to 6.48% slow. For mobile experiences, 13.76% of websites are fast while 43.03% are slow.

#### FID by ECT

<figure>
// Chart: Bar distribution of 07_04c
<figcaption>Figure 23. Distribution of websites labelled as having fast, average, or slow FID, broken down by <abbr title="effective connection type">ECT</abbr>.</figcaption>
</figure>

On its face, FID seems like it would be driven primarily by CPU speed. It'd be reasonable to assume that the slower the device itself is, the higher the likelihood that it will be busy when the user attempts to interact with a web page, right?

The ECT results above seem to suggest a correlation between connection speed and FID performance. As users' effective connection speed decreases, the percent of websites on which they experience fast FID also decreases and slow FID increases. Interestingly, the percent of websites with average FID is about the same across ECTs.

#### FID by geo

<figure>
// Chart: Bar distribution of 07_04d
<figcaption>Figure 24. Distribution of websites labelled as having fast, average, or slow FID, broken down by geo.</figcaption>
</figure>

In this breakdown of FID by geographic location, Korea is out in front of everyone else again. But the top geos have some new faces: the US, Australia, and Canada are next with 35-40% of websites having fast FID.

As with the other geo-specific results, there are so many possible factors that could be contributing to the user experience. For example, perhaps wealthier geos are more privileged to be able to spend more money on better network infrastructure and its residents have more money to spend on desktops and/or high-end mobile phones.

## Conclusion

Quantifying how fast a web page loads is an imperfect science that can't be represented by a single metric. Conventional metrics like `onload` can miss the mark entirely by measuring irrelevant or imperceptible parts of the user experience. User-perceived metrics like FCP and FID more faithfully convey what users see and feel. Even still, neither metric can be looked at in isolation to draw conclusions about whether the overall page load experience was fast or slow. Only by looking at many metrics holistically can we start to understand the performance for an individual website and the state of the web.

The data presented in this chapter showed that there is still a lot of work to do to meet the goals set for fast websites. Certain form factors, effective connection types, and geos do correlate with better user experiences, but we can't forget about the combinations of demographics with poor performance. In many cases, the web platform is used for business; making more money from improving conversion rates can be a huge motivator for speeding up a website. Ultimately, for all websites, performance is about delivering positive experiences to users in a way that doesn't impede, frustrate, or enrage them.

As the web gets another year older and our ability to measure how users experience it improves incrementally, I'm looking forward to developers having access to metrics that capture more of the holistic experience. FCP is very early on the timeline of showing useful content to users and newer metrics like [Largest Contentful Paint](https://web.dev/largest-contentful-paint) (LCP) are emerging to improve our visibility into how page loads are perceived. The [Layout Instability API](https://web.dev/layout-instability-api) has also given us a novel glimpse into the frustration users experience beyond page load. Equipped with these new metrics, the web in 2020 will become even more transparent, better understood, and give developers an advantage to make more meaningful progress to improve performance and contribute to positive user experiences.