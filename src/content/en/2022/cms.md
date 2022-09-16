---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: CMS chapter of the 2022 Web Almanac covering CMS adoption, user experience of websites running on CMS platforms, and CMS resource weights.
authors: [sirjonathan]
reviewers: [alexdenning, dknauss, alonkochba, honzasladek]
analysts: [csliva]
editors: [dknauss]
translators: []
results: https://docs.google.com/spreadsheets/d/1HvTcCEw9LeMNX-fI_yOy0HemKFYKaQAHBxtB0etakqY/
sirjonathan_bio: Jonathon is an expoert in CMS's
featured_quote: Wix delivers substantially fewer image bytes, with only 290 KB delivered on the median of mobile views, suggesting good use of image compression and lazy image loading. All of the other top 5 platforms deliver over 1 MB of images, with Squarespace delivering the largest ~1.7 MB.
featured_stat_1: 43%
featured_stat_label_1: Mobile wordpress pages adopting Elementor
featured_stat_2: 47%
featured_stat_label_2: Website origins discovered to be using a CMS
featured_stat_3: 6.7%
featured_stat_label_3: Percentage of top 1000 webpages using a known CMS
unedited: true
---

## Introduction

In this chapter, we work to understand the current state of Content Management System (CMS) ecosystems and the growing role they play in shaping users’ perception of how content can be experienced on the web. Our goal is to explore the CMS landscape in general and the characteristics of web pages created by these systems.

We believe that the CMS plays a key role in the success of our collective efforts to build a fast and resilient web. Understanding the current state, asking questions, and posing lines of inquiry for future work is our path to achieving this goal.

As a team, we’ve approached this year’s data with curiosity, and we’ve combined that curiosity with personal expertise with several of the most popular CMSs. We recommend that you take the comparisons and our analysis in stride, considering the variability between CMSs, and the differing types of user content that are built on these platforms.

## What is a CMS?

The term Content Management System (CMS) refers to systems enabling individuals and organizations to create, manage, and publish content. A CMS for web content, specifically, is a system aimed at creating, managing, and publishing content to be experienced on the web.

Each CMS implements a range of content management capabilities and the corresponding mechanisms for users to build websites around their content. CMSs also provide administrative capabilities to facilitate the addition and management of content as needed.

CMSs differ widely in the approaches they offer for building sites; some provide ready-to-use templates which are supplemented with user content, and others require user involvement for designing and constructing the site structure.

When we think about CMSs, we try to account for all the parts that form an ecosystem surrounding the CMS platform, including hosting providers, extension developers, development agencies, site builders, etc. Thus, when we talk about a CMS, we usually refer to both the platform itself and its surrounding ecosystem.

Our dataset, based on <a hreflang="en" href="https://www.wappalyzer.com/technologies/cms">Wappalyzer’s definition</a> of a CMS, identified over 270 individual CMSs. Know a CMS that’s missing? <a hreflang="en" href="https://github.com/wappalyzer/wappalyzer/blob/7ac625c34432cb35d01abd683f88d3bfadca4cca/CONTRIBUTING.md">Contribute to Wappalyzer</a>.

Some CMSs in the dataset are open source (e.g., WordPress and Joomla) and some of them are proprietary (e.g., Wix and Squarespace). Some CMSs can be used on “free” hosted or self-hosted plans, and there are also options for using these platforms on higher-tiered plans even at the enterprise level.

The CMS space as a whole is a complex, federated universe of CMS ecosystems, separated and at the same time intertwined.

## CMS adoption

Our analysis throughout this work includes desktop and mobile websites. The vast majority of URLs we looked at are in both datasets, but some URLs are only accessed by desktop or mobile devices. This can cause divergences in the data, and we thus look at desktop and mobile results separately.

{{ figure_markup(
  image="cms-adoption.png",
  caption="47% of mobile sites were flagged as CMS's in 2022.",
  description="Column chart showing the adoption of CMSs over the past 3 years. 45% of desktop websites and 47% of mobile websites are built using a CMS in 20212 For 2021, both desktop and mobile are approximately 45%, while in 2020 they are both 42%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=386824637&format=interactive",
  sheets_gid="643278583",
  sql_file="cms_adoption.sql"
  )
}}

As of June 2022, 45% of websites within the desktop dataset are powered by a CMS, indicating a slight drop of [from 2021](../2021/cms#cms-adoption). The mobile dataset shows an increase from 46% [in 2021](../2021/cms#cms-adoption) to 47% here in 2022. In our estimate, the drop is more likely attributed to minor variances in attribution than an indicator of a downward trend in CMS usage.

It is instructive to compare these numbers with another commonly used dataset, such as <a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management/all/q">W3Techs</a>, which reported that as of June 2021, 64.6% of websites are created using a CMS, up from 59.2% in June 2020, which is an increase of over 9%.

The deviation between our analysis and W3Techs’ analysis can be explained by a difference in research methodologies, and the definition of what is a CMS.

W3Techs definition is the following: “_Content Management Systems are applications for creating and managing the content of a website. We include all such systems in this category, also systems that are often classified as wikis, blog engines, discussion boards, static site generators, website editors or any type of software that provides website content_.”

As mentioned previously, Wappalyzer has a stricter definition of a CMS, which excludes some major CMSs which appear in W3Techs reports. You can read more about our definition on the [Methodology](../methodology) page.

### CMS adoption by geography

CMSs are used around the world, with some variance by country.

{{ figure_markup(
  image="cms-adoption-geo.png",
  caption="Mobile CMS across top 10 countries ranged from 31% to 41%.",
  description="Bar chart showcasing the adoption of CMSs by geography, in the 10 countries with the largest number of websites. In the US, 39% of mobile websites within the dataset are built using a CMS, and 43% of desktop websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1831148760&format=interactive",
  sheets_gid="353349768",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=538
  )
}}

Among the geographies with the highest number of websites, CMS adoption percentage is the highest in Italy, and Spain, where 41%–40% of mobile sites visited by users are built with a CMS. Brazil and Japan have the lowest adoption with only 31% and 32% respectively.

Of particular interest is the decrease across the board from the 2021 dataset. Comparing year over year for mobile results, all countries except India appear to show a drop, ranging from a 4% decrease for the UK and Germany to an 8% decrease for the US and Italy.  Given the consistency of the decreases across geographies, it feels more plausible to be a variance in attribution than a wholesale drop in CMS adoption. We recommend this be evaluated further in next year’s analysis.


### CMS adoption by rank

We examined CMS adoption by the estimated rank of the sites included within the dataset.

{{ figure_markup(
  image="cms-adoption-rank.png",
  caption="Top ranking sites are less likely to use a public-facing CMS at a 6.7% adoption rate.",
  description="Column chart showing the adoption of CMSs split by the rank of the websites. Higher ranking sites are less likely to have a CMS attributed, while a larger percentage of lower ranking sites have a clearly attributed CMS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=898515378&format=interactive",
  sheets_gid="1599740178",
  sql_file="cms_adoption_by_rank.sql"
  )
}}

According to the dataset, CMSs are used by less than 7% of the top 1,000 websites, compared to 47% of the complete dataset of all mobile sites in our analysis. A possible explanation, and the one we offered last year, is that smaller businesses and websites tend to use a CMS due to the ease of use, and the higher ranked websites tend to be built with proprietary solutions by professional web developers.

Another explanation is that for higher ranking sites which tend to have more resources allocated to development, the choice of a CMS is more likely to be obfuscated. It seems improbable that more than 90% of the top 1,000 would forgo a CMS entirely and more likely that they just don’t show up in our dataset.

A potentially correlated trend is the adoption of “headless” and the move towards separating content, and the CMS that powers it, from the frontend experience offered to end-users.

While our confidence in the overall dataset remains high, we’re interested in investigating the adoption by rank dataset further in future editions to see if more can be done to detect CMS usage and improve the overall accuracy of our results.

## Most popular CMSs

Among all websites that are attributed as using a CMS, WordPress sites account for the majority of the relative market share, with over 35% adoption on mobile, followed by Wix (2%), Joomla (1.8%), Drupal (1.6%), and Squarespace (1%).

{{ figure_markup(
  image="top-5-cms-yoy.png",
  caption="Wordpress and Wix experienced steady growth over the past 3 years.",
  description="Column chart depicting the percent of websites built on each of the top 5 CMSs, in the past 3 years. WordPress, Wix and Squarespace are growing in adoption year-over-year, while Drupal and Joomla are dropping.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=714516300&format=interactive",
  sheets_gid="1396671791",
  sql_file="top_cms.sql"
  )
}}

Comparing year over year, Drupal and Joomla continue to decline in market share, while Squarespace remains steady and Wix grows. WordPress continues its assent, increasing 1.4% over 2021 on mobile, and 0.2% over 2021 on desktop.

{{ figure_markup(
  image="wordpress-page-builders.png",
  caption="43% of mobile wordpress page builders adopted elementor.",
  description="Column chart depicting the top 5 page builders for WordPress.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=184382453&format=interactive",
  sheets_gid="2087504589",
  sql_file="wordpress_page_builders.sql"
  )
}}

Within WordPress, users often make use of a “page builder” that sits as a layer on top of WordPress and provides an interface for content management. This year, with Wappalyzer’s detection methods improving, we looked at page builder adoption. We discovered that of the WordPress sites attributed to a page builder (approximately 34% of all WordPress sites in our dataset), Elementor and WP Bakery are the clear winners, with Divi, SiteOrigin, and Oxygen trailing behind.

As we see it today, page builders exert significant influence on the performance of a site and, historically, have been anecdotal indicators of poor performance. As one example, our dataset indicates that it’s not uncommon for websites to have multiple page builders installed, adding a significant increase to the resources loaded by a site.

Now that we’re tracking page builder data, we’ll have the opportunity in future editions to evaluate year of year changes in page builder adoption and look for connections in those changes to the overall performance of WordPress as a CMS.

## CMS user experience

An important aspect of CMSs is the user experience they provide, for users visiting sites built on these platforms. We attempt to examine these experiences through Real User Measurements (RUM), provided by the <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report</a> (CrUX), and synthetic testing using [Lighthouse](../2021/methodology#lighthouse).

### Core Web Vitals

The <a hreflang="en" href="https://httparchive.org/reports/cwv-tech">Core Web Vitals Technology Report</a> can be used to drill into available data and view the progress of evaluated platforms updated on a monthly basis.

In this section we focused on data from June 2022 to provide a consistent timeframe for data presented across the Web Almanac, and examined three important factors provided by the [Chrome User Experience Report](../2021/methodology#chrome-ux-report), which can shed light on our understanding of how users are experiencing CMS-powered web pages in the wild:

* Largest Contentful Paint (LCP)
* First Input Delay (FID)
* Cumulative Layout Shift (CLS)

These metrics aim to cover the core elements which are indicative of a great web user experience. The [Performance](../2021/performance) chapter covers these in more detail, but here we are interested in looking at these metrics specifically in terms of CMSs.

Initially, let’s review the 10 CMS platforms with the highest number of origins, and examine what percentage of sites on each platform have a _passing_ grade, meaning that the 75th percentile of each of the above metrics must be in the “good” (green) range for each site.

{{ figure_markup(
  image="top-cwv-performance.png",
  caption="Out of the top 10 CMSs, Duda pages had a good score on 67% of mobile pages.",
  description="Bar chart showcasing the percentage of sites with good Core Web Vitals, for each of the 10 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1221898999&format=interactive",
  sheets_gid="445373655",
  sql_file="core_web_vitals.sql",
  width=600,
  height=559
  )
}}

We can see that desktop visitors generally score better than mobile, which can be explained by weaker mobile devices and poorer connections. The large difference between mobile and desktop in certain platforms also suggests considerably different pages are served to users on different devices.

In June, for mobile devices, Duda had the largest percentage of passing sites, with 67% of mobile sites passing all three CWVs. WordPress trailed furthest behind, with 30% of its sites passing, though this indicates a significant increase over 2021 data, where only 19% passed.

Desktop device experience was better for most CMSs, with Duda having the largest percentage with 68% of sites passing CWVs. WordPress had the lowest ratio of passing sites, with 30%.

We can also evaluate the progress of these CMS platforms compared to last year’s data, focusing on mobile views:

{{ figure_markup(
  image="top-cwv-yoy.png",
  caption="All CMS's in the top 10 improve year over year, with Duda improving from 30% to 67% since 2021.",
  description="Bar chart showing the change in the percentage of passing Core Web Vitals mobile sites year-over-year, for each of the 10 most adopted CMSs, sorted by percentage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=144597470&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

All of these CMSs showed an improvement in the percentage of origins with good CWVs since June 2021.

Let’s drill into the three Core Web Vitals, to see where each platform has room to improve, and which metrics improved the most since last year:

#### Largest Contentful Paint (LCP)

Largest Contentful Paint (LCP) measures the point in time when the page’s main content has likely loaded and thus the page is useful to the user. It does this by measuring the render time of the largest image or text block visible within the viewport.

A “good” LCP is regarded as being under 2.5 seconds.

{{ figure_markup(
  image="lcp-cwv-performance.png",
  caption="TYPO3 and Duda tied with the most good LCP scores on 79% of origins.",
  description="Bar chart showcasing the percentage of sites with good LCP, for each of the 10 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1306847805&format=interactive",
  sheets_gid="445373655",
  sql_file="core_web_vitals.sql",
  width=600,
  height=559
  )
}}

TYPO3 and Duda had the best LCP scores with 79% of origins having a “good” LCP experience, while WordPress and Squarespace have the worst LCP scores, with 37% and 40% of origins, respectively, having a good LCP score.

{{ figure_markup(
  image="lcp-cwv-yoy.png",
  caption="Joomla had the largest growth of good LCP scoring pages at a 13% increase.",
  description="Bar chart showing the change in the percentage of good LCP mobile sites year-over-year, for each of the 10 most adopted CMSs, sorted by percentage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=964886559&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

Compared to the 2021 dataset, all CMSs showed improvements. Joomla improved by 13%, Drupal, Squarespace, and TYPO3 by 10%, while WordPress improved by 9%.

These improvements are a positive sign, though still on the low end for most CMSs. The difficulty in achieving a good LCP score probably relates to the fact that the LCP is dependent on the download of image/font/CSS and then displaying the appropriate HTML elements. Achieving this in under 2.5 seconds for all device types and connection speeds can be challenging. Improving LCP scores usually involves the correct use of caching, pre-loading, resource prioritization, and lazy loading of other competing resources.

#### First Input Delay (FID)

First Input Delay (FID) measures the time from when a user first interacts with the page (i.e., when they click a link, tap on a button, or use a custom, JavaScript-powered control) to the time when the browser is able to process that interaction. A “fast” FID from a user’s perspective would be almost immediate feedback from their actions on a site rather than a stalled experience.

Any delay is a pain point and could correlate with interference from other aspects of the site loading when the user tries to interact with the site. A “good” FID is regarded as being under 100 milliseconds.

In 2021’s report, the fact that almost all platforms manage to deliver a good FID, raised questions about the strictness of this metric. The Chrome team <a hreflang="en" href="https://web.dev/responsiveness/">published an article</a>, which was updated in May of 2022 to include a reference to a new metric, <a hreflang="en" href="https://web.dev/inp/">Interaction to Next Paint (INP)</a> . Given its beta nature at the time of this writing, we’re limiting its inclusion to this reference, in anticipation of a possible expansion in next year’s report.

{{ figure_markup(
  image="fid-cwv-yoy.png",
  caption="Year over year FID is a tight spread between 89% and 96%.",
  description="Bar chart showing the change in the percentage of good FID mobile sites year-over-year, for each of the 10 most adopted CMSs, sorted by percentage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=242914394&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

Yearly data shows that most CMSs managed to improve their FID over the past year. Wix and Weebly both regressed by several percentage points over previous year’s data.

#### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS) measures the visual stability of content on a web page, measuring the largest burst of layout shift scores for every unexpected layout shift that occurs during the entire lifespan of a page that was not caused by direct user interactions.

A layout shift occurs any time a visible element changes its position from one rendered frame to the next.

The<a hreflang="en" href="https://web.dev/evolving-cls/"> CLS metric evolved in 2021</a>,  mainly introducing the concept of Session Windows, to be fairer to long-lived pages and Single Page Apps (SPAs).

A score of 0.1 or below is measured as “good”, over 0.25 as “poor”, and anything in between as “needs improvement”.

{{ figure_markup(
  image="cls-cwv-yoy.png",
  caption="Wix has the most improved CLS pages with 89% of origins scored as good.",
  description="Bar chart showing the change in the percentage of good CLS mobile sites year-over-year, for each of the 10 most adopted CMSs, sorted by percentage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=2127088376&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

Comparing yearly data, we can see that all CMSs made progress, WordPress, Squarespace, Duda, and Adobe Experience Manager in particular showing significant gains.

### Lighthouse

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a> is an open-source, automated tool for improving the quality of web pages. One key aspect of the tool is that it provides a set of audits to assess the status of a website in terms of performance, accessibility, SEO, best practices, and more. Lighthouse reports provide lab data, a way developers can get suggestions on how to improve website performance, but the Lighthouse score has no direct implications on the actual field data collected by <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">CrUX</a>. You can read more on Lighthouse and the correlation between its <a hreflang="en" href="https://web.dev/lab-and-field-data-differences/">lab scores and field data</a>.

HTTP Archive runs Lighthouse on its mobile web pages, which are also [throttled to emulate a slow 4G connection with a CPU slowdown](../2021/methodology#lighthouse).

We can analyze this data to provide another perspective on CMS performance, using the results of these synthetic tests, which also include metrics that are not tracked in CrUX.

#### Performance score

The Lighthouse <a hreflang="en" href="https://web.dev/performance-scoring/">performance score</a> is a weighted average of several metric scores.

{{ figure_markup(
  image="median-lighthouse.png",
  caption="Median lighthouse performance scores range from 19 to 47 among the top CMSs.",
  description="Bar chart showcasing the median Lighthouse mobile performance score for each of the top 10 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=2275923&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

We can see that the median performance scores for most platforms on mobile are low, ranging from 19 to 35, with Duda at 47 the exception. As Philip Walton cited in 2021, <a hreflang="en" href="https://philipwalton.com/articles/my-challenge-to-the-web-performance-community/">this does not directly imply bad results</a> in mobile field data but does imply that all platforms have room for improvements, especially for low-end devices and network connections similar to those Lighthouse attempts to emulate.

WordPress, Joomla, Drupal, and 1C-Bitrix showed no change from last year’s results. Wix dropped from 30% to 29% while the rest showed improvements.

#### SEO score

Search Engine Optimization (or SEO) is the practice of improving a website to make it more easily found in search engines. This is covered more in-depth in our [SEO](../2022/seo) chapter, but one part involves ensuring the site is coded in such a way to serve as much information to search engine crawlers to make it as easy as possible for them to show a site appropriately in search engine results. Compared to a custom-created website, one might expect a CMS to provide good SEO capabilities, and the Lighthouse scores in this category are appropriately high.

{{ figure_markup(
  image="median-lighthouse-seo.png",
  caption="Most top CMS's score well on SEO metrics with a median spread between 83 and 92.",
  description="Bar chart showcasing the median Lighthouse mobile SEO score for each of the top 10 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1901746915&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

The median SEO score in all of the top 10 platforms is over 83, a reduction from 84 in 2021.

#### Accessibility score

An accessible website is a site designed and developed so that people with disabilities can use them. Web accessibility also benefits people without disabilities, such as those on slow internet connections. Read more in our [Accessibility](../2022/accessibility) chapter.

Lighthouse provides a set of accessibility audits, and it returns a weighted average of all of them (see <a hreflang="en" href="https://web.dev/accessibility-scoring/">Scoring Details</a> for a full list of how each audit is weighted).

Each accessibility audit is either a pass or a fail, but unlike other Lighthouse audits, a page doesn’t get points for partially passing an accessibility audit. For example, if some elements have screen reader-friendly names, but others don’t, that page gets a 0 for the screen reader-friendly-names audit.

{{ figure_markup(
  image="median-lighthouse-accessibility.png",
  caption="Lighthouse accessibility's lowest score is 77 and highest is 91 among top CMS's.",
  description="Bar chart showcasing the median Lighthouse mobile SEO score for each of the top 10 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=201542197&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

The median Lighthouse accessibility score for the top 10 CMSs ranges between 77 and 91. Squarespace had the highest score of 91, while 1C-Bitrix had the lowest accessibility scores.

#### Best practices

The Lighthouse <a hreflang="en" href="https://web.dev/lighthouse-best-practices/">best practices</a> try to ensure that web pages are following best practices for the web, for a variety of different metrics, such as supporting HTTPS, no errors logged in the console, and more.

{{ figure_markup(
  image="median-lighthouse-best-practices.png",
  caption="Wix capped out the best practices score with a median score of 100.",
  description="Bar chart showcasing the median Lighthouse mobile best practices score for each of the top 10 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1066307789&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

Wix had the highest median best practices score of 100, while many of the other top 10 platforms share the lowest score of 75.

## Resource weights

We also use HTTP Archive data to analyze the weight of resources used across different platforms, to highlight possible opportunities. Page loading performance does not exclusively depend on the number of downloaded bytes, but fewer bytes necessary to load a page results in reduced costs, carbon emissions, and potentially faster performance, especially for slower connections.

{{ figure_markup(
  image="median-cms-page-weight.png",
  caption="Squarespace has the largest median page size breaking the 3 megabyte barrier among top 5 CMS's.",
  description="Column chart showing the median total page weight of each of the top 5 most adopted CMSs, for each device.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1764509612&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Most of the top 5 CMSs deliver a median page weight of around ~2 MB, except Squarespace which delivers a larger ~3.5 MB. All except Joomla showed increases in page weight over 2021 data.

{{ figure_markup(
  image="distribution-cms-page-weight.png",
  caption="Wix delivers a competitive median of 3.5mb on the low end of page weight while Squarespace hits 6.5mb as a median size among a larger distribution.",
  description="Distribution showing the percentile distribution of total mobile page weight among each of the top 5 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1236078412&format=interactive",
  sheets_gid="859067552",
  sql_file="page_weight_distribution.sql"
  )
}}

The distribution of page weight in each platform’s percentiles is substantial, probably related to the difference in user content across different web pages, the number of images used, plugins, etc. The smallest pages delivered per platform come from WordPress, a marked improvement over last year’s data, which only sends 673KB for their 10th percentile of visits. The largest pages come from Squarespace, with ~11.4 MB delivered for their 90th percentile of visits, a ~2MB increase over last year’s data.

### Page weight breakdown

Page Weight is a sum of resources used. We can attempt to evaluate these different resource sizes across different CMSs.

#### Images

Images, which are usually the heaviest resource, account for a large portion of the resource weight.

{{ figure_markup(
  image="median-cms-image-size.png",
  caption="Wix keeps images well compressed and optimized with a median size of 290kb.",
  description="Column chart showing the median weight of image resources downloaded in each of the top 5 most adopted CMSs, for each device.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1491116500&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Wix delivers substantially fewer image bytes, with only 290 KB delivered on the median of mobile views, suggesting good use of image compression and lazy image loading. All of the other top 5 platforms deliver over 1 MB of images, with Squarespace delivering the largest ~1.7 MB.

Advanced image formats provide a considerable improvement in compression, enabling resource savings and faster site loading. WebP is commonly supported in all major browsers today, with over <a hreflang="en" href="https://caniuse.com/webp">95% support</a>. In addition, there are several newer image formats gaining popularity and adoption, namely <a hreflang="en" href="https://caniuse.com/avif">AVIF</a>, and <a hreflang="en" href="https://jpegxl.info">JPEG-XL</a>.

We can examine the usage of the different image formats across the top CMSs:

{{ figure_markup(
  image="image-format-popularity.png",
  caption="Webp adoption is an indicator of image size savings.",
  description="Bar chart showcasing the relative popularity of each image format, among the top 15 most adopted CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1668189558&format=interactive",
  sheets_gid="710966440",
  sql_file="image_format_popularity.sql",
  width=600,
  height=556
  )
}}

Wix and Duda make the most use of WebP, with ~75% and 42% adoption respectively, while the rest show minor increases.

With the <a hreflang="en" href="https://caniuse.com/webp">growing support of WebP</a>, it seems all platforms have work to do to reduce the usage of the older JPEG and PNG formats, where it is applicable without compromising on image quality.

WordPress introduced support for WebP in 5.8, released in June of 2021 and is <a hreflang="en" href="https://make.wordpress.org/core/2022/06/30/plan-for-adding-webp-multiple-mime-support-for-images/">planned to be included by default</a> in WordPress 6.1, which we expect to lead to a significant increase in WebP adoption in the 2023 results.

#### JavaScript

{{ figure_markup(
  image="median-size-js.png",
  caption="CMS providers Wix and Squarespace utilize more javascript on average.",
  description="Column chart showing the median weight of JavaScript resources downloaded in each of the top 5 most adopted CMSs, for each device .",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1169405351&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

The largest five CMSs all deliver pages that rely on JavaScript, with Drupal delivering the least amount of JavaScript bytes–416 KB on mobile, while Wix delivers the most JavaScript bytes, over 1.3 MB.

#### HTML document

{{ figure_markup(
  image="median-size-html.png",
  caption="Wix delivers more kilobytes of HTML across the median request than the other 4 sites combined.",
  description="Column chart showing the median weight of the HTML resource downloaded in each of the top 5 most adopted CMSs, for each device.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1713320070&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}


Examining the HTML document sizes, we can see that most of the top CMSs deliver a median HTML size of ~22 KB–37 KB, except Wix which delivers ~118 KB, a minor improvement over 2021’s results. This may suggest extensive use of inlined resources and shows an area that can be further improved.

#### CSS

{{ figure_markup(
  image="median-size-css.png",
  caption="Wordpress uses the largest median CSS payload at 115kb.",
  description="Column chart showing the median weight of CSS resources downloaded in each of the top 5 most adopted CMSs, for each device.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=176229983&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Next, we examine the use of explicit CSS resources that are downloaded. Here we can see a different distribution between platforms, strengthening the differences in inlining approaches. Wix delivers the fewest CSS resources, with only ~9 KB sent on mobile views; WordPress delivers the most with ~115 KB.

#### Fonts

{{ figure_markup(
  image="median-size-font.png",
  caption="Joomla sites are more likely to rely on system fonts making their payloads smaller at 82kb.",
  description="Column chart showing the median weight of fonts resources downloaded in each of the top 5 most adopted CMSs, for each device.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1008146261&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

To display text, web developers often choose to use a variety of fonts. Joomla delivers the fewest font bytes, with 82 KB on mobile views, and Squarespace delivers the most with 202 KB.

## WordPress in 2022

WordPress is the most commonly used CMS today–almost 3 out of 4 sites built with a CMS are using WordPress, thus deserving further discussion.

WordPress is an open-source project, which has been around since 2003. Many sites built on WordPress use various themes and plugins, sometimes through page builders such as Elementor, WP Bakery, or Divi.

The WordPress ecosystem maintains the CMS and services requirements for additional functionality through custom services and products (themes and plugins). This community has an outsized impact, with a relatively small number of people maintaining both the CMS itself and providing the additional functionality which makes WordPress sufficiently powerful and flexible that it can service most types of websites. This flexibility is important when explaining the market share, but also complicates the discussion around WordPress based site performance.

In 2021, contributors from the WordPress community acknowledged the current state of performance, in this <a hreflang="en" href="https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/">proposal</a> to create a performance dedicated core team, which can hopefully improve the current performance of the average WordPress sites.

[Setup this year’s YoY analysis]

### Adoption by geography

First, we examined WordPress adoption by geography, across all sites in our dataset, comparing to 2021 results.

{{ figure_markup(
  image="wordpress-adoption-geo-yoy.png",
  caption="Year over year, less Wordpress sites were discovered across all geographies.",
  description="Bar chart depicting the adoption of WordPress in each of the 10 geographies with the most websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=442489769&format=interactive",
  sheets_gid="694875761",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=579
  )
}}

[Analysis]

### Passing CWVs by geography

Next, let’s look at the amount of WordPress origins with passing Core Web Vitals, but this time, breakdown by geography, for mobile devices and compared to 2021 results.

{{ figure_markup(
  image="wordpress-cwv-yoy.png",
  caption="Geography plays a large role with the spread of passing sites ranging from 10% to 52%.",
  description="Bar chart depicting the adoption of WordPress in each of the 10 geographies with the most websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1279742547&format=interactive",
  sheets_gid="1742929367",
  width=600,
  height=579
  )
}}

[Analysis]

### Plugins

We explored how WordPress sites use external resources and separated them between resources that are included in plugins, themes, and shipped in WordPress core (wp-includes), compared to 2021 results.

{{ figure_markup(
  image="median-wordpress-resources.png",
  caption="Wordpress did not change their resources pattern in form or function.",
  description="Column chart showing the percentile distributions of resources used for WordPress websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=660449132&format=interactive",
  sheets_gid="1922458949"
  )
}}


[Analysis]

## Conclusion

CMS platforms continue to grow and are becoming more ubiquitous year-over-year. They are essential for creating and consuming content on the internet, especially as more people and businesses establish an online presence.

The introduction of Core Web Vitals, along with the advancements in performance data visibility, has generated a focus on web performance across the web, and we hope these insights will help us all get a better understanding of the current state of the web, ultimately making the web a better place.

CMSs are doing great work and have a huge opportunity to further improve user experiences on the web at scale, by striving to enhance their infrastructure, experiment and integrate with new standards as they evolve, and follow best practices.

On the other hand, Core Web Vitals still have some progress and evolving to do.

We mentioned the thoughts towards a <a hreflang="en" href="https://web.dev/responsiveness/">better responsiveness metric</a> above. In addition, navigations between pages in a site should be better tracked and take into account the difference between <a hreflang="en" href="https://web.dev/vitals-spa-faq">Single-Page Applications (SPAs) and Multi-Page Applications (MPAs)</a>architectures.

