---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: SEO chapter of the 2022 Web Almanac covering crawlability, indexability, page experience, on-page SEO, links, AMP, internationalization, and more.
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [SophieBrannon, itamarblauer, mordy-oberstein]
reviewers: [patrickstox, TusharPol, mobeenali97, dwsmart, johnmurch]
analysts: [csliva, jroakes, derekperkins]
editors: [MichaelLewittes]
translators: []
results: https://docs.google.com/spreadsheets/d/1qBQWxNKIAVJNOFwGlslT7AW0VAoK85Mf3nFvtw0QjVU/
SophieBrannon_bio: Sophie is the Client Services Director at UK-based agency Absolute Digital Media and specializes in SEO strategy and content marketing in highly competitive industries such as health and finance. Sophie is a conference speaker and industry blogger, and has proven experience in strategizing and delivering award-winning campaigns on a local, national and international scale.
itamarblauer_bio: Itamar Blauer is an SEO expert based in London. He has a proven track-record of increasing rankings with SEO that is UX-focused, data-backed, and creative.
mordy-oberstein_bio: Mordy Oberstein is the Head of SEO Branding at Wix. He also serves as a consultant for SEMrush and sits behind the mic of multiple SEO podcasts, including the SERP's Up podcast.
featured_quote: The implementation of structured data in the HTML of a page has continually increased. In 2021, 41.8% of desktop pages and 42.5% of mobile pages used structured data. In 2022, it's risen to 44% of desktop pages and 45.1% of mobile pages that have structured data within their HTML.
featured_stat_1: 84.75%
featured_stat_label_1: Sites adopting HTTPS
featured_stat_2: 66%
featured_stat_label_2: Websites that have implemented an H1 tag
featured_stat_3: 20%
featured_stat_label_3: Images using lazy loading image properties
---

## Introduction

Search engine optimization (SEO) is a digital technique used to improve a website or page's visibility so that it organically ranks higher in search  engine results. It often combines technical configuration, content creation, and link acquisition, with the goal of improving relevance for a searcher's query and intent. SEO has continued to grow in popularity and become one of the most popular digital marketing channels.

{{ figure_markup(
  image="seo-term-trends.png",
  caption="Google Trends comparing directional search popularity of topics of SEO versus pay-per-click, social media marketing, and email marketing.",
  description="Screenshot of Google Trends showing the strong topical interest in SEO versus other digital marketing channels; search engine optimization, pay-per-click, social media marketing, and email marketing. In terms of relatives and absolute growth, SEO is in the lead by magnitudes.",
  width=2256,
  height=1492
  )
}}

With custom metrics that expose some new, never-before-seen insights, we have analyzed more than eight million homepages across the web, comparing our findings to those from [2021](../2021/seo) and, in some instances, from [2020](../2020/seo). Note: Our data, particularly from Lighthouse and the HTTP Archive, is limited to just websites' homepages, not site wide crawls. Learn more about these limitations in our [Methodology](./methodology).

Read on for more about how search engine-friendly the web is.


## Crawlability and indexability

Crawling and Indexing are the backbone of what Google and other search engines ultimately display on their search results pages. Without them, ranking simply cannot happen.

The first step in the process is discovering web pages via crawling. While numerous pages are crawled, fewer of them are actually indexed, which is essentially stored and categorized in a search engine's database. Based on a searcher's query, matching indexed pages are then served.

This section deals with the state of the web, as it pertains to bots crawling and indexing websites. What directives are sites giving search engines bots? What are sites doing to ensure Google serves the right page and not a near duplicate in search results?

Let's explore the web and some of its facets that impact crawlability and indexability.

### Robots.txt

The robots.txt file instructs bots, including search engine crawlers, as to where they can and cannot go, meaning what they can or cannot crawl.


#### Robots.txt status codes

{{ figure_markup(
  image="robots-txt-status-codes.png",
  caption="Robots.txt status codes.",
  description="Bar chart showing percent of pages with a valid robots.txt file. 82.4% of mobile sites returned a 200 status code, and 15.8% returned a 404 while a small percentage of 0.2% returned 403 and 0.1% returned 500. For desktop it's very similar with 81.5%, 16.5%, 1.6%, 0.3%, and 0.1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=240883913&format=interactive",
  sheets_gid="258446623",
  sql_file="robots-txt-status-codes.sql"
  )
}}

There has been a nominal increase in the percentage of sites whose robots.txt files return a 200 status code in 2022 compared to 2021. In 2022,  81.5% of robots.txt files for desktop sites returned a 200 status code while 82.4% of mobile sites returned the same. This stands in comparison to 81% and 81.9% of robots.txt files on desktop and mobile sites, respectively, returning a 200 status code in 2021.

Concurrently, there was just a small reduction in the percentage of robots.txt files returning a 404 status code in 2022 compared to 2021. Last year, 17.3% of robots.txt files for desktop sites returned a 404 while 16.5% of mobile sites' robots.txt files returned that status code. In 2022, it's just 16.5% for desktop and 15.8% for mobile sites' robots.txt files that are returning a 404 status code.

Like in 2021, the remaining status codes are associated with a minimal number of robots.txt files.

Note: The above data does not indicate how well optimized a robots.txt file is. Even a file returning a 200 status code can contain directives that are perhaps not in the best interest of a site's overall health.

#### Robots.txt size

{{ figure_markup(
  image="robots-size.png",
  caption="Robots.txt size codes.",
  description="A distribution chart showing differences in robots.txt sizes in 100 kilobyte increments. For desktop, 96.29% are in 0-100 KB range, 0.31% in 100-200 KB, 0.10% in 200-300 KB, 0.04% in 300-400 KB, 0.02% in 400-500 KB, 0.05% are larger than 500 KB, and finally 2.26% are missing. For mobile, 96.48% are in 0-100 KB range, 0.30%  in 100-200 KB, 0.12% in 200-300 KB, 0.04% in 300-400 KB, 0.02% in 400-500 KB, 0.05% are larger than 500 KB, and finally 1.97% are missing.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1600078634&format=interactive",
  sheets_gid="1828205691",
  sql_file="robots-text-size.sql"
  )
}}

As expected, the overwhelming majority of robots.txt files were quite small, weighing between 0-100 KB.

Google's max limit for a robots.txt file is 500 KiB. Any directives found after the file reaches that limit are ignored by the search engine. A very small number of robots.txt files fall into that category. Specifically, just .005% of both desktop and mobile sites contain a robots.txt file that is above Google's max limit (which is consistent with 2021's data). In cases where the file size exceeds limits, <a hreflang="en" href="https://developers.google.com/search/docs/advanced/robots/robots_txt">Google recommends</a> consolidating directives.

#### Robots.txt user-agent usage

{{ figure_markup(
  image="robots-useragents.png",
  caption="Robots.txt user-agent usage.",
  description="A bar chart showing the most common user agent targets in robots.txt files. For desktop `*` is 74.9%, `adsbot-google` is 6.8%, `mj12bot` is 6.0%, `ahrefsbot` is 5.4%, `mediapartners-google` is 3.4%, `nutch` is 3.7%, `googlebot` is 3.3%, `pinterest` is 3.3%, `adsbot-google-mobile` is 2.8%, `ahrefssiteaudit` is 3.2%, `yandex` is 2.9%, `bingbot` is 2.6%, `semrushbot` is 2.2%, `baiduspider` is 1.8%, and finally `dotbot` is 1.5%. Mobile is almost identical at 76.1%, 7.0%, 6.0%, 5.3%, 4.5%, 3.5%, 3.3%, 3.1%, 3.3%, 2.9%, 3.0%, 2.5%, 2.3%, 1.8%, and 1.7%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1197419046&format=interactive",
  sheets_gid="184863489",
  sql_file="robots-txt-user-agent-usage.sql",
  width=600,
  height=499
  )
}}

Most websites today (74.9% desktop and 76.1% mobile) do not indicate a specific user-agent within the robots.txt file, meaning the directives in the file apply to all user-agents. This is consistent with the data from 2020 when 74% of desktop robots.txt files and 75.2% of mobile robots.txt files did not specify a particular user-agent.

Interestingly, Bingbot did not fall into the top 10 most specified user-agents. As for SEO tools, much like in 2021, both Majestic's and Ahrefs' bots were in the top 5 most specified user-agents, while Semrush's bot rounded out the top 15 most specific user-agents.

In terms of search engines, Googlebot leads the pack with 3.3% of robots.txt files specifying the user-agent while Bingbot comes in at 2.5%. Interestingly, there was nearly a full percentage point difference in 2021 between mobile site robots.txt files and desktop files specifying Bingbot. Such is not the case in 2022 where the data is essentially uniform.

Of note, Yandexbot was specified in just 0.5% of robots.txt files in 2021. By 2022 , there was a six-fold increase, with 3% of files specifying Yandexbot.

### `IndexIfEmbedded` tag

In January 2022, Google introduced a new robots tag called _indexifembedded_. The tag offers control over indexation when content is embedded in an iframe on a page, even when a noindex tag has been applied.

Let's start by determining the percentage of pages for which the new tag is possibly applicable.

{{ figure_markup(
  image="pages-with-iframe.png",
  caption="Pages with `<iframe>`.",
  description="A pie chart showing 4.1% of mobile pages utilized in iframe within the analyzed content, and 95.9% did not use an iframe.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1839527748&format=interactive",
  sheets_gid="1009024750",
  sql_file="robots-meta-usage.sql"
  )
}}

A little more than 4% of pages contain an `<iframe>` element.  Of the 4.1% of pages containing that element, 76% of them had the iframe noindexed, making them a potential use case for the new `indexifembedded` tag.

However, a minuscule percentage of sites have adopted the `indexifembedded` robots tag. The tag can be found on just 0.015% of pages surveyed.

Of the pages that have adopted the `indexifembedded` tag, 98.3% of them implemented it in the header while 66.3% are using the HTML.

{{ figure_markup(
  image="indexifembedded-useragents.png",
  caption="`Indexifembedded` user agents.",
  description="A bar chart showing the majority of `indexifembedded` implementations use a robots header at 98.3% and target the `googlebot` user agent. The other three user agents (`google`, `gogglebot-news`, and `robots`) show 0% usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=994494235&format=interactive",
  sheets_gid="1009024750",
  sql_file="robots-meta-usage.sql"
  )
}}

### Invalid head elements

The `<head>` element serves as the container for a page's metadata. From an SEO point of view, a page's title tag and meta description reside within the `<head>` element, as do robots meta tags.

Not all elements, however, belong in the `<head>`. Should Google come across an invalid element in the page's `<head>`, it assumes that it has reached the end of the `<head>` and <a hreflang="en" href="https://developers.google.com/search/docs/advanced/guidelines/valid-html">will not discover the rest of its contents</a>.

Our data from 2022 shows 12.7% of desktop pages and 12.6% of mobile pages contain an invalid element in the `<head>`.

{{ figure_markup(
  image="invalid-head-elements.png",
  caption="Invalid `<head>` elements.",
  description="A column chart showing the percentage of pages with various HTML elements than are invalid in the `<head>`. On Desktop `img` is used in the head on 9.92% of pages, `div` on 3.58%, `a` on 1.73%, `p` on 1.11%, `span` on 1.08%, `iframe` on 0.96%, `br` on 0.94%, `input` on 0.78%, `li` on 0.63%, and finally `ul` 0.63%. Mobile is very similar at 9.77%, 3.91%, 1.93%, 1.32%, 1.30%, 1.13%, 1.12%, 1.05%, 0.90%, and 0.90% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=2061840642&format=interactive",
  sheets_gid="130501136",
  sql_file="invalid-head-elements.sql"
  )
}}

The most misapplied element to the `<head>` by far is the `<img>` element. It is incorrectly placed within the `<head>` on 9.7% of mobile pages and 9.9% of desktop pages.

The `<div>` element is the only other misapplied element to appear within the `<head>` on more than 3% of the pages within the 2022 dataset. It is incorrectly applied to the `<head>` on 3.5% of desktop pages and 3.9% of mobile pages.

## Canonical tags

Canonical tags are traditionally used when defining duplicate content pages and to help search engines prioritize. They are a snippet of HTML code (`rel="canonical"`) that allows webmasters to define to the search engine which page is the "preferred" version. They are not directives, and instead act as a "hint." Therefore, search engines such as Google determine their own canonical version of the page, based on how useful they believe the page is for the user. Canonical tags can also be used to consolidate other signals such as links, as well as to simplify tracking metrics and better manage syndicated content.

{{ figure_markup(
  image="canonical-usage.png",
  caption="Canonical usage.",
  description="A column chart highlighting percentages of pages which have a canonical set or are canonicalized. Canonical adoption is at 58.7% on desktop, and 60.6% on mobile, and is canonicalized is at 4.2% on desktop, and 7.5% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=34038632&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

We see from the data that canonical tags usage has increased over the years. In 2019, 48.3% of mobile pages used canonicals. In 2020, this grew to 53.6%. In 2021, this grew even further to 58.5%. And in 2022, it's increased to 60.6%.

Mobile has a higher percentage of canonical attribution than desktop (60.6% vs. 58.7%), which is likely a direct result of single use URLs on mobile. Since the data set in this chapter is limited to home pages, it's fair to assume that this is the reason for the higher canonical attribution on mobile. According to  <a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">Google's guidelines</a>, having a separate mobile site is not recommended.

### HTML vs. HTTP canonical usage

There are two ways of implementing canonical tags:

1. Within the HTML `<head>`
2. Within the HTTP headers (`Link` HTTP header)

{{ figure_markup(
  image="html-versus-http-canonical.png",
  caption="HTML versus HTTP Canonical usage.",
  description="A column chart comparing canonical implementations between HTML and HTTP headers. HTML canonicals are the primary implementation with 58.6% on desktop and 60.4% on mobile appearing in the page markup, compared with 1.2% and 0.9% in HTTP Headers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1403695913&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

The most common usage across both desktop and mobile is through HTML at 58.6% and 60.4%, respectively. This is likely due to the ease of implementation. While one requires basic HTML knowledge, the other method (through HTTP headers) requires a more technical skillset.

### Raw vs. rendered usage

{{ figure_markup(
  image="raw-vs-rendered-canonical.png",
  caption="Raw vs rendered canonical.",
  description="A bar chart comparing raw, rendered, or http canonical statuses. Raw canonical is set on 57.9% of desktop pages, rendered canonical on 58.6%, rendered but not raw canonical on 0.7%, rendering changed canonical on 2.2%, and the http header changed canonical on 0.4% of desktop. Mobile is almost identical at 59.4%, 60.4%, 1.0%, 1.9%, and 0.3% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=473608668&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

Compared to 2021, where raw canonical usage was 57.7% and rendered canonical usage was 58.4%, in 2022 there was some growth, with raw canonical usage reaching 59.4% and rendered canonical usage rising to 60.4%. This correlates with the growth in overall canonical use.

## Page experience

In this section of the chapter, we're looking at different elements of page experience and how this has evolved since the 2021 Web Almanac.

### HTTPS

In 2021, there was an increased focus on site speed and page experience following Google's introduction of the Core Web Vitals update, which had been publicized and pushed throughout 2020. While evidence of HTTPS being a ranking factor <a hreflang="en" href="https://developers.google.com/search/blog/2014/08/https-as-ranking-signal">dates back to 2014</a>, the overall focus on page experience since the Core Web Vitals announcement likely had an impact on the adoption of HTTPS across the web.

{{ figure_markup(
  image="https-usage.png",
  caption="Percentage of websites supporting HTTPS.",
  description="85% of desktop sites and 85% of mobiles sites use HTTPS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=115976742&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

We see from the data how more sites are using a secure certificate (HTTPS) at the time of the crawl (taking into account expirations of these certificates). In 2021, 84.3% of desktop pages used HTTPs, and it went up to 87.71% in 2022. On mobile, this increased from 81.2% in 2021 to 84.75% in 2022. Since the announcement of the Core Web Vitals update in 2020 to the present there's been an increase of nearly 11% on mobile and 10% on desktop.

### Mobile friendliness

Mobile-friendliness can be determined by looking at responsive design implementation vs. dynamic serving. To identify this, we looked at the use of the viewport meta tag which is commonly used in responsive design  vs. the vary: User-Agent header to determine if a website is using dynamic serving.

### Viewport meta tag

{{ figure_markup(
  caption="Sites supporting a viewport meta tag.",
  content="92%",
  classes="big-number",
  sheets_gid="1858203218",
  sql_file="meta-tag-usage-by-name.sql"
)
}}

We have seen the use of the viewport meta tag grow from 91.1% of mobile pages using viewport meta tag in 2021 to now 92%. In 2020, it was at  89.2%.

### Vary header usage

The vary header is a HTTP header that enables  different content to be served to different users on different devices. This is known as dynamic serving, and is the opposite to responsive design, which serves the exact same content, but to different devices.

{{ figure_markup(
  image="vary-header.png",
  caption="Vary header used.",
  description="A column chart comparing whether vary header is used or not. Vary headers are implemented on 12% of desktop sites, and 13% of mobile sites, and 88% and 87% respectively are not using then.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1832557145&format=interactive",
  sheets_gid="942102950",
  sql_file="html-response-vary-header-used.sql"
  )
}}

Vary header usage has remained relatively unchanged for the past few years. In 2021, 12.6% of desktop and 13.4% of mobile pages used this footprint. In 2022, the data is nearly identical, with 12% for desktop and 13% for mobile.

### Legible font sizes

In 2021, 13.5% of mobile pages were not using a legible font size. Thanks to Google's focus on user experience across all devices, more pages than ever now use a legible font size. Only 11% of mobile pages are still not using a legible font size.

{{ figure_markup(
  caption="Sites not using a legible font size.",
  content="11%",
  classes="big-number",
  sheets_gid="74703616",
  sql_file="lighthouse-seo-stats.sql"
)
}}

### Core Web Vitals (CWV)

Core Web Vitals was a hot topic in SEO throughout 2021 following Google announcing the roll out of its Page Experience update that June. We have seen a continued interest this year, with more sites paying attention to their CWV performance.

Core Web Vitals are a series of standardized metrics that can help developers and SEOs to better understand how a user is experiencing a page. The main metrics are:

* Largest Contentful Paint (LCP) measures how quickly a web page's main content loads
* First Input Delay (FID) measures how long it takes from when a user interacts with a web page (i.e. clicks a button) to when the browser is able to respond
* Cumulative Layout Shift (CLS) measures the  visual stability and whether a page shifts within the viewport

All three of these metrics are critical to user experience and the stability of a web page.

The data for Core Web Vitals is sourced from the Chrome User Experience Report (CrUX). The report comes from a public dataset of real (opted-in) users, and is sourced from millions of websites (as opposed to lab data, which is simulated).

{{ figure_markup(
  image="good-cwv-mobile.png",
  caption="Percent of good CWV experiences on mobile.",
  description="A timeseries chart showing mobile Core Web Vitals improvements over time and all of them have been trending upwards. 39% of mobile sites now fall into the good category of Core Web Vitals. 51% have good LCP, 74% have good CLS, and 92% have good FID.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1140903870&format=interactive",
  sheets_gid="1713598891",
  sql_file="core-web-vitals.sql"
  )
}}

On mobile, 39% of sites now pass CWV, which is up from 29% in 2021 and just 20% in 2020. And while 92% of sites currently pass FID, most site owners are struggling with LCP, which has a pass rate of 51%.

{{ figure_markup(
  image="good-cwv-desktop.png",
  caption="Percent of good CWV experiences on desktop.",
  description="A timeseries chart showing desktop Core Web Vitals improvements over time and all of them are trending upwards except FID which is flat at 100% over the whole time period. 43% of desktop sites are classified as good with Core Web Vitals. 63% have good LCP, 65% have good CLS, and 100% have good FID.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1399758157&format=interactive",
  sheets_gid="1713598891",
  sql_file="core-web-vitals.sql"
  )
}}

On desktop, we see an astounding 100% of sites passing FID, though similarly struggling to pass LCP and CLS. Noteworthy, more sites are passing CWV on desktop (43%) than on mobile (39%).

### `lazy` loading vs. `eager` loading iframes

Lazy loading is a technique that defers the loading of non-critical elements on a web page until the point in which they are needed. This can help with the reduction of page weight, as well as conserve bandwidth and system resources. Eager loading is when related entities are simultaneously loaded and fetched all at once.

{{ figure_markup(
  image="iframe-loading.png",
  caption="`iframe` loading property usage.",
  description="A column chart showing `iframe` loading properties between `lazy`, `auto`, `eager`, or none. It is missing on 95.30% of desktop pages, `lazy` is used on 3.67%, `auto` on 0.74%, `eager` on 0.29%, it is invalid on 0.00%, and blank on 0.00% of pages. Mobile is almost identical on 94.94%, 4.08%, 0.60%, 0.37%, 0.00%, and 0.00% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1451716640&format=interactive",
  sheets_gid="246694365",
  sql_file="iframe-loading-property-usage.sql"
  )
}}

When looking solely at iframes, we see lazy loading is preferred far more to eager loading, with 4.08% of iframes being lazy loaded versus 0.37% of iframes being eager loaded.

This is particularly interesting since <a hreflang="en" href="https://web.dev/iframe-lazy-loading/">browser-level lazy loading for iframes has become standardized in Chrome</a>. The standardization of the `loading` attribute, without specifying lazy or eager, is likely why data shows 94.4% of attributes do not contain lazy or eager.

## On page

When looking for relevancy signals, search engines look at the content on a web page. There are various on-page SEO elements that can affect rankings and/or appearance on the SERPs (Search Engine Results Pages).

### Meta data

{{ figure_markup(
  image="has-title-meta.png",
  caption="Title tag and Meta descriptions.",
  description="A column chart with the percentage of pages containing a title tag and meta description. 98% of pages have a title and 71% of pages have a meta description and it is the same on desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1299529015&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

For the second year in a row, 98.8% of desktop and mobile pages had `<title>` elements. Also in 2022, 71% of desktop and mobile homepages had `<meta name="description">` tags, a 0.1% decrease from last year.

#### `<title>` element

The `<title>` element is an on-page ranking factor that provides a strong hint regarding page relevance and may appear on the SERP. In August 2021, <a hreflang="en" href="https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles">Google started rewriting more websites' titles in their search results</a>.

{{ figure_markup(
  image="title-words-percentile.png",
  caption="Title words by percentile.",
  description="A distribution of word counts within page titles. The median word count in titles is 6 words on both desktop and mobile. At the 10th percentile it's 1 one or desktop and 2 on mobile, at the 25th percentile it's 3 word for both, at the 75th percentile it's 9 words for both, and at the 90th percentile it's 12 words for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1674970307&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="title-characters-percentile.png",
  caption="Title characters by percentile.",
  description="A distribution of character counts within page titles. The median character count for mobile titles is 39 characters on desktop and 40 characters on mobile. At the 10th percentile it's 12 characters for both, at the 25th percentile it's 21 characters for both, at the 75th percentile it's 59 characters for both, and at the 90th percentile it's 74 characters for desktop and 75 for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1110487580&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

In 2022:

* The median page `<title>` contained 6 words.
* The median page `<title>` contained 39 and 40 characters on desktop and mobile, respectively.
* 10% of pages had `<title>` elements containing 12 words.
* 10% of desktop and mobile pages had `<title>` elements containing 74 and 75 characters, respectively.

These stats remain unchanged from last year. Note: These titles on homepages tend to be shorter than those used on deeper pages.

#### Meta description tag

The `<meta name="description>` tag does not directly impact rankings. However, it may appear as the page description on the SERP, and it can influence click-through rate.

{{ figure_markup(
  image="meta-description-words-percentile.png",
  caption="Meta description words by percentile.",
  description="A distribution of word count within meta descriptions on desktop and mobile. They are identical for both. The median word count is 19 words for meta descriptions. At the 10th percentile it's 2 words, at the 25th percentile it's 9 words, at 75th percentile it's 25 words, and at the 90th percentile it's 35 words.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1883941031&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="meta-description-characters-percentile.png",
  caption="Meta description characters by percentile.",
  description="A distribution of character counts within meta descriptions. The median character count is 137 characters on desktop and 136 characters on mobile for meta descriptions. At the 10th percentile it's 33 characters for desktop and 33 for mobile, at the 25th percentile it's 80 and 78 characters respectively, at 75th percentile it's 160 characters for both, and at the 90th percentile it's 232 characters for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1915861678&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

In 2022:

* The median desktop and mobile page `<meta name="description>` tag contained 19 words.
* The median desktop and mobile page `<meta name="description>` tag contained 137 and 136 characters, respectively.
* 10% of desktop and mobile pages had `<meta name="description>` tags containing 35 words.
* 10% of desktop and mobile pages had `<meta name="description>` tags containing 232 characters.

For the most part, these stats are relatively unchanged from last year.

#### Header tags

Heading elements  (`<h1>`, `<h2>`...) are important parts of a page's structure since they help organize the content on the page. Heading elements are not a direct ranking factor, but they  can help Google better understand the content found on the page.

{{ figure_markup(
  image="has-h-elements.png",
  caption="Presence of H elements.",
  description="A column charting showing usage of H1 tags through H4 tags. On desktop 66% of pages have an H1 tag, 73% an H2, 62% an H3, and 38% an H4. The percentages are identical on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=46522676&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

The trends around implementation of headings by type in 2022 closely match those from 2021, with just a few small differences. For example, 71.9% of mobile pages utilized an h2 in 2021 while 73.02% did in 2022.

Another trend that has carried over is the discrepancy in usage between the h1 and h2. While 72.7% of desktop pages implement an h2, only 65.8% use an h1 (with similar numbers reflected on mobile).

Although there is no  definitive explanation for this, one possible reason is that the h1 is often placed above any content. It's not essential for the natural flow of the content. However, without the h2, there could be a long flow of unstructured content.

{{ figure_markup(
  image="nonempty-h-elements.png",
  caption="Presence of non-empty H elements.",
  description="A column charting showing non-empty usage of H1 tags through H4 tags. On desktop 58% of pages have a non-empty H1 tag, 72% a non-empty H2, 61% a non-empty H3, and 37% a non-empty H4. The percentages are very similar on mobile at 59%, 71%, 60%, and 37% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1398855380&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

Overall, much like 2021's stats, there are relatively few empty H elements found on pages. Additionally, there is little discrepancy between the desktop and mobile data.

There is divergence, however, with the h1.  While 65.8% of pages contained an h1 element, 58.5% contained a non-empty h1 element. That's a 7.3 percentage point difference. Contrast that with the h2, which has just a 1.5 percentage point difference.  As noted in the 2021 Web Almanac, this may be a result of the many websites that wrap logo-images in the h1 element on homepages.

### Image attributes

The primary purpose of the alt attribute on the `<img>` element is accessibility. Alt attributes also assist search engines rank specific assets in image search.

{{ figure_markup(
  image="image-alt-present.png",
  caption="Percentage of `img` `alt` attributes present.",
  description="A distribution chart of pages with an img tag implementing alt attributes. The median usage of images with alt attributes is 56% on desktop and 54% on mobile. At the 10th percentile it's 0% for both, at the 25th percentile it's 16% and 14%, at the 75th percentile it's 92% and 91%, and at the 90th percentile it's 100% for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1932752526&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="image-alt-empty.png",
  caption="Percentage of `img` with blank `alt`.",
  description="A distribution chart of pages with an img tag implementing empty alt attributes. As a median, 0% of images on both mobile and desktop have an alt attribute that is empty making it uncommon At the 75th percentile this rises to 24% of images on both devices types, and at the 75th percentile it's 75% on desktop and 79% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1460266248&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="image-alt-missing.png",
  caption="Percentage of `img` missing `alt`.",
  description="A distribution chart of page images missing alt attributes. The median of missing alt attributes on images is 12% on desktop and 13% on mobile sites. At the 10th and 25th percentiles it 0% on both, but above the median at 75th percentile it's 51% on desktop and 53% on mobile. finally, at the 75th percentile, it's 86% of images on desktop and 87% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=986554040&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

What we found:

- On the median desktop page, 56.25% of `<img>` tags have the alt attribute. This is a negligible decrease of just a quarter of a percentage point from 2021's 56.5%.
- On the median mobile page, 54.9% of `<img>` tags have the alt attribute. This is a marginal increase from the 54.6% of tags with the alt attribute in 2021.
- There is a noticeable change in the median desktop and mobile pages containing `<img>` tags that have blank alt attributes compared to 2021. Last year, the median desktop and mobile pages, respectively had 10.5% and 11.8% `<img>` tags with blank `alt` attributes. In 2022, this figure rose to 12.1% and 12.5% on desktop and mobile, respectively.
- The trend towards 0% of median desktop and mobile pages containing `<img>` tags missing the alt attribute continues. On the median desktop page in 2021, 1.4% of the `<img>` tags had blank attributes. It fell to 0% in 2022.

### Image `loading` property usage

How user agents prioritize the rendering and displaying of images is affected by the loading attribute applied to `<img>` elements. This implementation can impact user experience and performance time, with possible effects on both SEO success and conversions.

{{ figure_markup(
  image="image-loading-property.png",
  caption="Image `loading` property usage.",
  description="A column chart showing image-loading property adoption. 20% of images have adopted native lazy loading, 78% do not use the attribute, and 2% set it to `eager`. 0% set it to `auto` of `blank`. The numbers are identical on desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1909677331&format=interactive",
  sheets_gid="166283668",
  sql_file="image-loading-property-usage.sql"
  )
}}

What we found:

- There has been a significant reduction in the number of pages that do not use any image loading property. In 2021, 83.3% of desktop pages and 83.5% of mobile pages didn't utilize any image loading property at all. It's now 78.3% of desktop pages and 77.9% of mobile pages in 2022.
- Conversely, the implementation of loading="lazy" has increased. In 2021, both 15.6% of desktop and mobile pages implemented loading="lazy". This has increased to 19.8% (desktop) and 20.3% (mobile) in 2022.
- The number of pages defaulting to the brower's loading method has fallen in 2022. On desktop, .07% of pages use loading="auto" and .08% on mobile. In 2021, .01% of pages utilized loading="auto".

### Word count

While content length is not a ranking factor, it is still valuable to assess how many words a page contains on average.

#### Rendered word count

Let's begin with the number of words found on the page once it has been rendered.

{{ figure_markup(
  image="visible-words-rendered.png",
  caption="Visible words rendered by percentile.",
  description="A distribution of rendered and visible content word counts. On mobile, the median number of words rendered is 421 words on desktop and 366 words on mobile. There is a similar smaller number of words on mobile at the other percentiles above and below the median: at the 10th percentile it's 88 words on desktop and 77 on mobile, at the 25th percentile it's 209 and 179 respectively, at the 75th percentile it's 763 and 677, and at the 90th percentile it's 1,305 and 1,166.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1348358716&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

The median desktop page in 2022 contains 421 words. This is quite close to the 425 words found in 2021. However, this is still a big leap percentage-wise from what we found back in 2020 when 402 words were found on the median desktop page. Whatever the cause was in 2021 for the uptick in rendered word count, it appears to have remained through 2022.

Similarly, the median number of rendered words on mobile in 2022 contains 366 words, which is also similar percentage-wise to the data in 2021. For context, desktop pages contain more words than mobile pages. The median desktop page contains 15% more words than mobile pages within the 50th percentile. This is significant since Google some years ago adopted a mobile-first index, and content not found on the mobile version of a page runs the risk of not being indexed by the search engine.

#### Raw word count

Let's now examine the number of words contained in a page's source code prior to the browser executing any JavaScript code or other modifications in the DOM or CSSOM.

{{ figure_markup(
  image="visible-words-raw.png",
  caption="Visible words raw by percentile.",
  description="A distribution of raw HTML words received. The median raw number of words is 363 words on desktop and 318 on mobile showing a distinct difference from rendered. There is a similar smaller number of raws words on mobile at the other percentiles above and below the median: at the 10th percentile it's 68 words on desktop and 61 on mobile, at the 25th percentile it's 174 and 151 respectively, at the 75th percentile it's 663 and 594, and at the 90th percentile it's 1,142 and 1,039.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=519228938&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

Much like the rendered word count, there is a minimal difference between the data in 2022 versus what was found in 2021. For example, the median desktop page's raw word count was 369 in 2021 compared to 363 in 2022 and median mobile page's raw word count was 318 which is slightly less than 2021 which saw 321 words as the median.

Here, too, mobile pages contain fewer words than desktop pages across the board. The median mobile page contains a raw word count that is 12.39% less than desktop. As noted above, this is significant because of Google's mobile-first indexing.

## Structured Data

Implementing Structured Data has come into increased focus as rich results on the Google SERP have become more prominent.

{{ figure_markup(
  image="raw-vs-rendered-structured-data.png",
  caption="Raw versus rendered structured data.",
  description="A column chart showing structured data changes based on raw versus rendered. 44% of desktop pages have raw structured data, increasing 2 percentage points to 46% for rendered structure data. 0% of has only rendered structured data, and on 5% of pages rendering changes structured data. for Mobile it's almost identical with 45%, 47%, 0% and 5% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=486315827&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

The implementation of structured data in the HTML of a page has continually increased. In 2021, 42% of desktop pages and 43% of mobile pages used structured data. In 2022, it's risen to 44% of desktop pages and 45% of mobile pages that have structured data within their HTML.

This reflects 2 percentage point increases on both desktop and mobile pages. Two possible explanations for greater adoption could be that a number of Content Management Systems have added automatic structured data markup to their pages, as well as the aforementioned prominence that structured data has played in Google SERPs.

There has also been a great reduction in both mobile and desktop pages that have structured data added via JavaScript where it was not contained within the initial HTML response. In 2021, 1.7% of mobile pages and 1.4% of desktop pages had structured data added via JavaScript where it was not contained within the initial HTML response. It's now just .15% on desktop and .13% on mobile.

### Most popular Structured Data formats

{{ figure_markup(
  image="structured-data-formats.png",
  caption="Structured Data formats.",
  description="A column chart of structured data formats out of those commonly supported. JSON-LD on 64% of desktop pages, microdata on 33%, RDFa on 3%, and microformats2 on 0%. Mobile is almost identical with JSON-LD on 62% of mobile pages, microdata on 35%, RDFa on 2%, and microformats2 on 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1310320311&format=interactive",
  sheets_gid="2048293717",
  sql_file="structured-data-formats.sql"
  )
}}

Structured data can be implemented through various ways on a given page. However, JSON-LD, which aligns with Google's own recommendation for implementation, is by far the most popular format.

Compared to 2021's figures, 2022's data shows a nominal increase in implementation via JSON-LD and a slight decrease when implementing structured data with microdata. These numbers bear out in particular on mobile. In 2021, 60.5% of mobile pages used JSON-LD to implement structured data. The number of mobile pages in 2022 using JSON-LD for adding structured data is up 2.3% to 61.9%. Conversely, 36.9% of mobile pages in 2021 utilized structured data with microdata. That number fell 4.3% in 2022 to 35.3%.

### Most popular schema types

{{ figure_markup(
  image="popular-schemas.png",
  caption="Most popular schema types.",
  description="A bar chart of schema type implementations by popularity. 30% of sites have adopted a website schema from schema.org. `schema.org/WebSite` is used on 31% of desktop pages, `schema.org/SearchAction` on 27%, `schema.org/WebPage` on 23%, `schema.org/-UnknownType-` on 22%, `schema.org/Organization` on 21%, `schema.org/ListItem` on 19%, `schema.org/BreadcrumbList` on 18%, `schema.org/ImageObject` on 16%, `schema.org/ReadAction` on 15%, `schema.org/EntryPoint` on 14%, `schema.org/SiteNavigationElement` on 6%, `schema.org/PostalAddress` on 6%, `schema.org/WPHeader` on 5%, `schema.org/WPFooter` on 5%, and finally `schema.org/Person` on 5% of desktop pages. Mobile is almost identical with 30%, 26%, 23%, 22%, 20%, 18%, 18%, 16%, 14%, 13%, 7%, 6%, 5%, 5%, and 5% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=201128426&format=interactive",
  sheets_gid="432096465",
  sql_file="structured-data-schema-types.sql",
  width=600,
  height=532
  )
}}

There is strong correlation between the most popular types of schema found on homepages in 2021 and 2022.

As noted in previous editions of the Web Almanac,  `WebSite`, `SearchAction`, `WebPage`, `SearchAction` is what powers the <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">Sitelinks Search Box</a> [see chart above].

When comparing 2021 to 2022, there has been a significant increase in the adoption of the most popular schemas across the board. In fact, every noted schema type has experienced an increase in adoption in 2022. Among the most notable are the schema for BreadcrumbsList, which has risen 22.8% since 2021 and ImageObject, which is up 12.3%.

In terms of implementing the most popular schemas, there are relatively tiny differences between the percentages of mobile versus desktop pages.

You can read more about structured data in our dedicated chapter.

## Links

Search engines utilize links to discover new pages and to pass PageRank, which helps determine the importance of pages. Links also act as a reference from one page to another (presumably relevant) page.

### Non-descriptive link text

Anchor text, which is the clickable text used in a link, helps search engines to understand the content of the linked page. Lighthouse has a test to check if the anchor text used is useful and/or contextual, or if it's generic and/or non-descriptive such as "learn more" or "click here." In 2022, 15% and 17% of the tested links on mobile and desktop, respectively, did not have descriptive anchor text, a missed opportunity from an SEO perspective and bad for accessibility.

### Outgoing links

{{ figure_markup(
  image="median-internal-links.png",
  caption="Median links to same site.",
  description="A rank distribution of the median count of internal links. On desktop for the top 1,000 sites it's 137 links, for the top 10,000 sites it's 139, for the top 100,000 sites it's 105, for the top million sites it's 88, for the top 10 million sites it's 63, and for all sites it's 56. For mobile it's slightly lower at 106, 117, 94, 82, 56, 48 respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=2040803708&format=interactive",
  sheets_gid="1325442493",
  sql_file="outgoing_links_by_rank.sql"
  )
}}

Internal links are links to other pages on the same website. Much like last year, 2022's figures suggest pages had fewer links on their mobile versions compared to their desktop counterparts.

The median number of internal links is now 16% higher on desktop than mobile at 56% and 48%, respectively. It's likely a result of developers minimizing the navigation menus and footers on mobile for ease of use on smaller screens.

According to CrUX data, the 1,000 most popular websites have more outgoing internal links than less popular sites, a total of 137 links on desktop versus 106 on mobile. That's more than two times higher than the median. This may be attributed to the use of mega-menus on larger sites that generally have more pages.

{{ figure_markup(
  image="median-external-links.png",
  caption="Median external links.",
  description="A rank distribution of the median count of external links. On desktop for the top 1,000 sites it's 15 external links, for the top 10,000 sites it's 13 for the top 100,000 sites it's 10, for the top millions sites it's 8, for the top 10 million sites it's 7, and for all sites it's 7 external links. Mobile is one or two less at each rank with 12, 11, 9, 7, 6, and 6 respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1367867640&format=interactive",
  sheets_gid="1325442493",
  sql_file="outgoing_links_by_rank.sql"
  )
}}

External links are links to other pages on a different website. The data, which has been consistent for the past few years, points to there being fewer external links on the mobile versions of pages compared to the desktop versions. Despite Google rolling out mobile-first indexing a few years ago, websites have not brought their mobile versions to parity with their desktop counterparts.

### Anchor rel attribute use

In September of 2019, Google <a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">introduced attributes</a> that allow publishers to classify links as being _sponsored_ or _user-generated content_. These attributes are in addition to `rel=nofollow`, which was previously <a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">introduced in 2005</a>. The newer attributes, `rel=ugc` and `rel=sponsored`, add additional information to the links.

{{ figure_markup(
  image="anchor-rel-attr.png",
  caption="Achor `rel` attribute usage.",
  description="A column chart comparing `rel` `noopener`, `nofollow`, `noreferrer`, `dofollow`, `sponsored`, `ugc`, and `follow`. On desktop `noopener` is used on 34.3% of sites, `nofollow` on 28.8%, `noreferrer` on 18.8%, `dofollow` on 0.4%, `sponsored` on 0.5%, `ugc` on 0.4%, and finally `follow` is used on 0.3% of sites. Mobile is almost identical with 32.6%, 29.5%, 17.3%, 0.6%, 0.4%, 0.4%, and 0.3% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=583878647&format=interactive",
  sheets_gid="411053146",
  sql_file="anchor-rel-attribute-usage.sql"
  )
}}


Not much has changed in terms of the adoption of the newer attributes, with `rel=ugc` appearing on 0.4% of desktop and mobile pages, and `rel=sponsored` appearing on 0.5% of desktop and 0.4% of mobile pages in 2022.

`rel="dofollow"` once again appeared on more pages than `rel="ugc"` and `rel="sponsored"`. While this is technically not a problem, Google ignores `rel="follow"` and `rel="dofollow"` because, despite their inclusion, they are not actually official attributes.

`rel="nofollow"`, which is a real attribute, was found in 2022 on 29.5% of mobile pages, which is 1.2% less than last year. Google treats `nofollow` as a hint, meaning the search engine can choose whether or not they respect the attribute.


## AMP

AMP has been a controversial topic since its launch in 2015, with SEOs debating whether or not it had a direct impact on rankings. Google later released this statement (below) in its documentation for additional clarification:

<figure>
  <blockquote>While AMP itself isn't a ranking factor, speed is a ranking factor for Google Search. Google Search applies the same standard to all pages, regardless of the technology used to build the page.</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://developers.google.com/search/docs/advanced/experience/about-amp">Google Search Central</a></cite></figcaption>
</figure>

The future of AMP appears to be changing ever since the launch of Core Web Vitals. A main reason for previously implementing AMP, aside from improving page speed, was that it was necessary for inclusion in Top Carousels. In 2021, Google updated its requirements and outlined that any page is now eligible to appear in Top Carousels with or without AMP.

{{ figure_markup(
  image="amp-markup.png",
  caption="AMP markup types.",
  description="A column chart showing AMP implementations across all pages. AMP adoption is low across the sampled dataset. HTML Amp Attribute is used on 0.07% of desktop pages, and 0.19% of mobile. HTML Amp & Emjoi Attribute is used on 0.01%, and 0.03% respectively, HTML Amp or Emjoi Attribute on 0.09% and 0.22%, and Rel Amp HTML Tag on 0.67% and 0.60%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1100298070&format=interactive",
  sheets_gid="1210998028",
  sql_file="markup-stats.sql"
  )
}}

Desktop usage has dipped in 2022 from 0.09% to 0.07% compared to 2021 while mobile usage is down from 0.22% to 0.19% over the same time period.

## Internationalization

Internationalization in SEO is the process of optimizing a website in line with best practices when targeting multiple countries and multiple languages, to ensure that it can be properly crawled and indexed by search engines.

### Hreflang usage

Hreflang tags help Google and other search engines, such as Bing and Yandex, understand what the main language is on a given page. It is primarily used in international SEO campaigns when several different languages are used across different versions of a website.

{{ figure_markup(
  image="hreflang-usage.png",
  caption="Hreflang usage.",
  description="A bar chart of common hreflang targets. For desktop `en` is used on 5.4% of the pages in our dataset. `x-default` on 4.0%, `fr` on 2.2%, `de` on 2.2%, `es` on 2.1%, `en-us` on 1.6%, `it` on 1.5%, `ru` on 1.3%, `en-gb` on 1.2%, and finally `nl` on 1.0%. For mobile it's almost identical with 4.7%, 3.7%, 2.0%, 2.0%, 2.0%, 1.4%, 1.5%, 1.3%, 1.0%, 1.0% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=561647523&format=interactive",
  sheets_gid="297028820",
  sql_file="hreflang-link-tag-usage.sql",
  width=600,
  height=546
  )
}}

Currently, 9.6% of sites use hreflang tags on desktop while 8.9% use them on mobile. This is a slight increase from 2021 when 9.0% of sites used hreflangs tags on desktop and 8.4% implemented them on mobile.

The most popular hreflang tag in 2022 is `en` [English], which accounts for 5.4% usage on desktop and 4.7% on mobile. Those percentages are approximately the same as the year before.

After x-default, which is the "fallback" version (and the second most common to be adopted), the hreflang tags for French, German and Spanish are the next most frequently used.

The three different ways to implement hreflang tags are via the `<head>`, link headers, or XML sitemaps. Note: As this data is looking solely at homepages, XML sitemaps are not included.

### Content language usage

While Google tends to use hreflang tags, other search engines such as Bing prefer the [`content-language` attribute](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Language). This can be implemented using two methods:

1. HTML
2. HTTP Header

{{ figure_markup(
  image="content-language.png",
  caption="Language usage (HTML and HTTP header).",
  description="A bar chart showing language usage as a percentage of pages. For desktop `en` is used on 4.22% of pages in our dataset, `en-us` on 1.83%, `de` on 0.50%, `fr` on 0.33%, `es` on 0.29%, `pt-br` on 0.12%, `it` on 0.13%, `ru` on 0.12%, `nl` on 0.14%, and finally `ja` on 0.11%. For mobile it's very similar at 3.28%, 2.28%, 0.53%, 0.29%, 0.33%, 0.15%, 0.14%, 0.14%, 0.11%, and 0.10% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1743056980&format=interactive",
  sheets_gid="1291138023",
  sql_file="content-language-usage.sql",
  width=600,
  height=507
  )
}}

In 2022, HTTP server response is the most popular implementation method of content-language, with 8.27% of mobile sites using this and 8.82% of desktop sites. However this has seen a decline in adoption on mobile compared to 2021 when 9.3% of mobile sites used it. Conversely, desktop has seen a slight increase compared to 2021 when 8.7% of sites used it.

HTML, on the other hand, has 2.98% adoption on desktop in 2022 and 3.01% adoption on mobile. But again there's  a decline in mobile usage compared to 2021 when 3.3% of mobile sites used the HTML tag.

## Conclusion

Much like patterns in our data from [2021](../2021/seo), [2020](../2020/seo), and [2019](../2019/seo), the majority of sites analyzed are showing small, yet consistent, improvement when it comes to various fundamentals of SEO, including having indexable and crawlable pages.

We have also seen an increasing focus on performance elements such as Core Web Vitals, with 39% of sites now having passing scores compared to just 20% in 2020 when the update was first announced. This seems to indicate sites are now taking Google's guidance more to heart. Still, more work needs to be done across the web.

Newer introductions, such as the indexifembedded tag, are seeing slow pick-up. This underscores the continuous need for adoption of best practices and how much opportunity for growth there is in SEO, search engine friendliness, and the state of the web in general.
