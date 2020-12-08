---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 12
title: Mobile Web
description: Mobile Web chapter of the 2020 Web Almanac covering page loading, textual content, zooming and scaling, buttons and links, and ease of filling out forms.
authors: [spanicker, mdiblasio]
reviewers: [malchata, obto, cheneytsai]
analysts: [obto]
translators: []
#spanicker_bio: TODO
#mdiblasio_bio: TODO
discuss: 2048
results: https://docs.google.com/spreadsheets/d/1DGLY7UEWOlDL5_2dtS_j2eqMjiV-Rw5Fe2y6K6-ULvM/
queries: 12_Mobile_Web
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---

# Introduction
We keep hearing that the Mobile Web has grown explosively in the last decade and is now the primary way many people experience the web. In this chapter we explore just how significant the mobile web is, and what kind of experiences visitors are expecting and being served.

2020 has seen a big surge in internet usage, on both mobile and desktop, due to the global pandemic. There has been an uptick in visits to news sites, ecommerce and social media sites -- as people across the globe adjusted to a new lifestyle with stay-at-home orders and social distancing. 2020 has been a significant year in history, for the web and for mobile usage.

## <a name="datasources"></a> A note on our data sources
We’ve used a few different data sources in this chapter: 

* [CrUX](https://almanac.httparchive.org/en/2020/methodology#chrome-ux-report)
* [HTTP archive](https://almanac.httparchive.org/en/2020/methodology#dataset)
* [Lighthouse](https://almanac.httparchive.org/en/2020/methodology#lighthouse)

Please visit the links above to learn more about the methodology and caveats with each data source.
It is worth noting that HTTP Archive and Lighthouse data is limited to the data identified from websites’ home pages only, and not site-wide. 

In addition to the above, we also used a non-public Chrome data source in the section on Page loads in Chrome. For more information on this, read about [Chrome’s data collection API](https://chromium.googlesource.com/chromium/src/+/master/services/metrics/ukm_api.md).

While this data is only collected from a subset of (opted in) Chrome users, it does not suffer from being limited to homepages. It is pseudonymous and consists of histograms and events. 

NOTE: Reporting is enabled if the user has enabled a feature that syncs browser windows, unless they have disabled the "Make searches and browsing better / Sends URLs of pages you visit to Google" setting.

# Mobile web & Desktop traffic trends
How much are users visiting websites on mobile web and desktop? Are there any patterns in the traffic that websites receive from mobile vs. desktop?  In order to examine these questions and what it means for websites, we looked at data from a couple of lenses.

A [report published](https://www.perficient.com/insights/research-hub/mobile-vs-desktop-usage-study) on perficient.com shows mobile vs. desktop traffic trends over several years, using [similarweb](https://www.similarweb.com/) as a data source.
While the majority of visits -- **58%** of site visits -- were from mobile devices, mobile devices made up only 42% of total time spent online. Moreover, the average time spent per visit is roughly twice as much on desktop compared to mobile (11.52 minutes on desktop vs. 5.95 minutes on mobile). 

## Page loads in Chrome (Chrome data source)
Note that this section references stats that have been made available specifically for this chapter from non-public Chrome data source, [see details here](#datasources).
We use this data to assess page loads on Android and Windows -- as a proxy for mobile and desktop respectively. 

NOTE: we may refer to the data in this section as mobile for Android and desktop for Windows.

### Page loads across origins ranked by popularity

We looked at traffic to origins by popularity -- how often are users visiting certain origins, and what does that tell us about the global distribution across the web.

Rick Byers [tweeted](https://twitter.com/RickByers/status/1195342331588706306) this distribution a year ago, we looked at the latest data.
The chart shows us the overall distribution across origins by their popularity, captured by their contribution to % page loads in Chrome.

TODO: Insert chart: Page loads across origins ranked by popularity

Some takeaways:

* Usage of Chrome is roughly evenly divided between the top 200 sites, the next 10,000, and all the rest.
* The web has a **fat head**
  * a small number of origins constitute a large fraction of traffic, for both mobile and desktop
  * the top 30 origins constitute 25% of aggregate traffic on mobile
  * the top 200 origins constitute 33% of aggregate traffic on mobile
* The web has a **broad torso**
 * the top 10k origins constitute roughly two-thirds of traffic: 64% of traffic on mobile
* The web has a **long tail**
 * 3M origins in top 98% on Android vs. 1.8M on Windows.
 * The tail is about twice as long on Android as Windows. This is most likely attributable to the larger number of mobile devices and users, compared to desktop.

### Traffic to a site from mobile vs. desktop (CrUX)
*Could a website reason about their expected mobile vs. desktop traffic distribution?* 
It’s hard to predict, because the distribution between mobile and desktop will vary greatly based on the site Furthermore, it heavily depends on the industry category (eg. entertainment, shopping) and whether the site has native apps, and how aggressively native apps are promoted etc.

We looked at the CrUX dataset to assess Chrome traffic to sites from mobile devices vs desktop.

TODO: Insert chart: mobile traffic distribution

The distribution appears mobile heavy. A reason for that is that there are many (2 million+ in CrUX) sites which, while low in total traffic, only get traffic from mobile.  Mobile has a much longer “tail” as we saw in the previous section.

If we put all the websites with CrUX data, in a bucket and randomly choose one, 50% of the time the website you chose would be receiving 77.61% or more of their traffic from mobile (a slight decrease from 79.93% in 2019). 

Note that while this is an interesting observation, it’s hard to draw conclusions from CrUX about broad trends for mobile vs. desktop because:
* CrUX is Chrome only data, and missing other browsers, including Safari - a major mobile browser.
* even for Chrome, this is a subset from opted-in users, and impacted by opt-in rates and variance across platforms.

### Conclusions
So what did we learn in terms of reasoning about mobile vs. desktop traffic to a website?

Traffic distribution from mobile vs desktop is highly specific to a site and dependent on the industry category, and other factors such as presence of native apps.
However odds are that for site visits in Chrome, a given website has traffic predominantly from mobile web, in spite of users spending more time on desktop. This is due to a much longer tail for mobile Chrome.

While one cannot generalize the expected traffic distribution from mobile vs. desktop for individual websites, it is worth comparing your site’s distribution to that of the industry category ([some data is available here](https://www.perficient.com/insights/research-hub/mobile-vs-desktop-usage-study)).

If your website is substantially different from the industry average, it could be worth digging into the reason, for instance poor loading performance could be one reason.
