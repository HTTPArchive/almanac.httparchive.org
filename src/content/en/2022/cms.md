---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: CMS chapter of the 2022 Web Almanac covering CMS adoption, user experience of websites running on CMS platforms, and CMS resource weights.
hero_alt: Hero image of Web Almanac charactes on a type writer writing a web page.
authors: [sirjonathan]
reviewers: [alexdenning, alonkochba, dknauss]
analysts: [csliva]
editors: [dknauss]
translators: []
results: https://docs.google.com/spreadsheets/d/1HvTcCEw9LeMNX-fI_yOy0HemKFYKaQAHBxtB0etakqY/
sirjonathan_bio: Jonathan Wold is an Open Web advocate with more than 17 years focused on the WordPress ecosystem. Beyond his love for WordPress, he enjoys reading widely, playing strategy games, acting, rock climbing, and occasionally writing in third-person.
featured_quote: Comparing year-over-year, Drupal and Joomla continue to decline in market share, while Squarespace remains steady and Wix grows. WordPress continues its ascent, increasing 1.4% over 2021 on mobile, and 0.2% over 2021 on desktop.
featured_stat_1: 45%
featured_stat_label_1: Percentage of websites within the desktop dataset attributed to a known CMS
featured_stat_2: 7%
featured_stat_label_2: Percentage of top 1,000 websites attributed to a known CMS
featured_stat_3: 34%
featured_stat_label_3: WordPress sites attributed to using a page builder
---

## Introduction

In this chapter, we work to understand the current state of Content Management System (CMS) ecosystems and the growing role they play in shaping users' perception of how content can be experienced on the web. Our goal is to explore the CMS landscape in general and the characteristics of web pages created by these systems.

We believe that the CMS plays a key role in the success of our collective efforts to build a fast and resilient web. Understanding the current state, asking questions, and posing lines of inquiry for future work is our path to achieving this goal.

As a team, we've approached this year's data with curiosity, and we've combined that curiosity with personal expertise with several of the most popular CMSs. We recommend that you read our analysis in light of the variability between CMSs and types of content on them.

## What is a CMS?

The term Content Management System (CMS) refers to systems enabling individuals and organizations to create, manage, and publish content. A CMS for web content, specifically, is a system aimed at creating, managing, and publishing content to be experienced on the web.

Each CMS implements a range of content management capabilities and corresponding mechanisms for users to build websites around their content. CMSs also provide administrative capabilities to facilitate the addition and management of content.

CMSs differ widely in the approaches they offer for building sites. Some provide ready-to-use templates which are supplemented with user content, and others require user involvement for designing and constructing the site structure.

In this chapter of the Web Almanac, we tried to account for all the things that form an ecosystem around a CMS platform, including hosting providers, extension developers, development agencies, site builders, etc. For this reason, when we refer to a CMS, we usually intend both the platform itself and its surrounding ecosystem.

Our dataset, based on <a hreflang="en" href="https://www.wappalyzer.com/technologies/cms">Wappalyzer's definition</a> of a CMS, identified over 270 individual CMSs. Know a CMS that's missing? <a hreflang="en" href="https://github.com/wappalyzer/wappalyzer/blob/7ac625c34432cb35d01abd683f88d3bfadca4cca/CONTRIBUTING.md">Contribute to Wappalyzer</a>.

Some CMSs in the dataset are open source (e.g., WordPress and Joomla), and some of them are proprietary (e.g., Wix and Squarespace). Some CMSs can be used on "free" hosted or self-hosted plans, and there are also options for using these platforms on higher-tier plans up to the enterprise level.

The CMS space as a whole is a complex, federated universe of discrete but also interrelated CMS ecosystems.

## CMS adoption

Our analysis throughout this work included desktop and mobile websites. The vast majority of URLs we looked at are in both datasets, but some URLs are only accessed by desktop or mobile devices. This can cause divergences in the data, so we considered desktop and mobile results separately.

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMS adoption.",
  description="Column chart showing the adoption of CMSs over the past 3 years. 45% of desktop websites and 47% of mobile websites are built using a CMS in 2022. For 2021, desktop is 45% and mobile is approximately 46%, while in 2020 they were both 42%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=386824637&format=interactive",
  sheets_gid="643278583",
  sql_file="cms_adoption.sql"
  )
}}

As of June 2022, 45% of the websites in the Web Almanac's desktop dataset were powered by a CMS, indicating similar usage [to 2021](../2021/cms#cms-adoption). The mobile dataset shows an increase from 46% [in 2021](../2021/cms#cms-adoption) to 47% here in 2022. Looking closer at the desktop raw figures we actually see a slight drop in both absolute and percentage terms, but the drop is more likely an artifact of minor variances in attribution than an indicator of a downward trend in CMS usage. It should be noted that the number of desktop sites tracked by HTTP Archive (and the source CrUX dataset) has fallen considerably from 6.4 million sites to 5.4 million sites, while the number of mobile sites has grown by about 400,000 sites from 7.5 million to 7.9 million sites. We take this increase to reflect continued growth in mobile device usage at the expense of the desktop.

It is instructive to compare these numbers with another commonly used dataset, such as <a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management/all/q">W3Techs</a>. W3Techs reported that as of June 2021, 64.6% of websites are created using a CMS. This is up from 59.2% in June 2020–an increase of over 9%.

The deviation between our analysis and W3Techs' analysis can be explained by differences in research methodologies and definitions of a CMS.

W3Techs' definition is as follows: "_Content Management Systems are applications for creating and managing the content of a website. We include all such systems in this category, also systems that are often classified as wikis, blog engines, discussion boards, static site generators, website editors or any type of software that provides website content_."

As we mentioned previously, Wappalyzer has a stricter definition of a CMS than we do. Wappalyzer excludes some major CMSs that appear in W3Techs reports. You can read more about our definition of a CMS on the [Methodology](./methodology) page.

### CMS adoption by geography

CMSs are used around the world, with some variance by country.

{{ figure_markup(
  image="cms-adoption-geo.png",
  caption="CMS adoption by geography.",
  description="Bar chart showcasing the adoption of CMSs by location in the 10 countries with the largest number of websites. In the US, 39% of mobile websites within the dataset are built using a CMS and so are 43% of desktop websites. In Japan it is 38% and 32% respectively, in the UK 39% and 39%, in Germany 36% and 39%, in India 35% and 35%, in Brazil 34% and 31%, in France 38% and 35%, in the Russian Federation 40% and 35%, in Italy 42% and 40%, and in Spain 42% on desktop and 41% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1831148760&format=interactive",
  sheets_gid="353349768",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=538
  )
}}

Among the countries with the highest number of websites, CMS adoption is highest in Italy and Spain where 40%–41% of mobile sites are built with a CMS. Brazil and Japan have the lowest adoption with only 31% and 32% respectively.

Of particular interest is the decrease across the board compared to our [2021 dataset](../2021/cms#cms-adoption-by-geography) when individual countries are considered. Comparing year-over-year for mobile results, all countries except India appear to show a drop, ranging from a 4% decrease for the UK and Germany to an 8% decrease for the US and Italy.  Given the consistency of the decreases across geographies, it seems more plausible to be a variance in attribution than a wholesale drop in CMS adoption. We recommend evaluating this further in next year's analysis.


### CMS adoption by rank

We examined CMS adoption by the estimated rank of the sites included within the dataset.

{{ figure_markup(
  image="cms-adoption-rank.png",
  caption="CMS adoption by rank.",
  description="Column chart showing the adoption of CMSs split by the rank of the websites. For the top 1,000 sites it is 7% on both desktop and mobile. For the top 10,000 it is 15% and 16% respectively. For the top 100,000 it is 21% and 21%. For the top 1,000,000 it is 29% and 29%. For all sites it is 39% and 43%. Higher ranking sites are less likely to have a CMS attributed, while a larger percentage of lower ranking sites have a clearly attributed CMS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=898515378&format=interactive",
  sheets_gid="1599740178",
  sql_file="cms_adoption_by_rank.sql"
  )
}}

According to the dataset, CMSs are used by fewer than 7% of the top 1,000 websites for both desktop and mobile even though 47% of all mobile sites in the dataset use a CMS. A possible explanation for this apparent discrepancy, and the one we offered last year, is that smaller businesses with websites tend to use a popular CMS for their ease of use, and those CMSs are easily identified. However, larger businesses with higher ranked websites tend to have custom-built CMS solutions that we can't identify.

Another explanation is that higher ranking sites with more resources allocated to their development are more likely to obfuscate the identity of their CMS for security reasons. It is improbable that more than 90% of the top 1,000 would forgo a CMS entirely and more likely that they just don't show up in our dataset.

A potentially correlated trend is the adoption of "headless" CMSs and the move to separate content—and the CMS that powers it—from the frontend experience offered to end-users.

While our confidence in the overall dataset remains high, we're interested in investigating the adoption-by-rank dataset further in future editions of this report to see if more can be done to detect and identify a greater number of CMSs to improve the overall accuracy of our results.

## Most popular CMSs

Among all websites that use an identifiable CMS, WordPress sites account for the majority of the relative market share—with over 35% adoption on mobile—followed by Wix (2%), Joomla (1.8%), Drupal (1.6%), and Squarespace (1.0%).

{{ figure_markup(
  image="top-5-cms-yoy.png",
  caption="Top five CMSs year-over-year.",
  description="Column chart depicting the percent of websites built on each of the top five CMSs in the past 3 years. WordPress is 31.4% in 2020, 33.6% in 2021, and 35.0% in 2022. Joomla is 2.1%, 1.9%, and 1.8%, respectively, across the same years. Drupal is 2.0%, 1.8%, and 1.6%. Wix is 1.2%, 1.6%, and 2.0%. Squarespace is 0.9% for 2020, 1.0%, for 2021, and 1.0% for 2022. WordPress, Wix, and Squarespace are growing in adoption year-over-year, while Drupal and Joomla are declining.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=714516300&format=interactive",
  sheets_gid="1396671791",
  sql_file="top_cms.sql"
  )
}}

Comparing year-over-year, Drupal and Joomla continue to decline in market share, while Squarespace remains steady and Wix grows. WordPress continues its ascent, increasing 1.4% over 2021 on mobile, and 0.2% over 2021 on desktop.

{{ figure_markup(
  image="wordpress-page-builders.png",
  caption="WordPress page builder adoption.",
  description="Column chart depicting the top five page builders for WordPress. Elementor is 40% of desktop WordPress sites, and 43% of mobile. wpBakery is 34%, and 33% respectively, Divi is 16%, and 15%, SiteOrigin Page Builder is 3% and 3%, and Oxygen is 1% on both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=184382453&format=interactive",
  sheets_gid="2087504589",
  sql_file="wordpress_page_builders.sql"
  )
}}

Within WordPress, users often make use of a "page builder" that provides an interface for content management. This year, with Wappalyzer's detection methods improving, we looked at page builder adoption. We discovered that of the WordPress sites attributed to a page builder (approximately 34% of all WordPress sites in our dataset), Elementor and WP Bakery are the clear winners, with Divi, SiteOrigin, and Oxygen trailing behind.

As we see it today, page builders exert significant influence on the performance of a site. Historically, page builders have been anecdotal indicators of poor performance. As one example, our dataset indicates that it's not uncommon for websites to have multiple page builders installed, adding a significant increase to the resources loaded by a site.

Now that we're tracking page builder data, we'll have the opportunity in future editions to evaluate year-over-year changes in page builder adoption and look for correlations in those changes to the overall performance of WordPress as a CMS.

## CMS user experience

An important feature of CMSs is the user experience they provide for users visiting sites built on these platforms. We attempt to examine these experiences through Real User Measurements (RUM) via the <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report</a> (CrUX), and synthetic testing using [Lighthouse](./methodology#lighthouse).

### Core Web Vitals

The <a hreflang="en" href="https://httparchive.org/reports/cwv-tech">Core Web Vitals Technology Report</a> can be used to drill down into the available data and view the progress of evaluated platforms updated on a monthly basis.

In this section we focus on data from June 2022 to provide a consistent timeframe for data presented across the Web Almanac. We examine three important metrics provided by the [Chrome User Experience Report](../2021/methodology#chrome-ux-report) which can shed light on our understanding of how users are experiencing CMS-powered web pages in the wild:

* <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP)
* <a hreflang="en" href="https://web.dev/articles/fid">First Input Delay</a> (FID)
* <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a> (CLS)

These metrics aim to cover the technical fundamentals of a great web user experience. The [Performance](./performance) chapter covers these metrics in greater detail, but here we are interested in looking at them specifically in terms of CMSs.

Initially, let's review the 10 CMS platforms with the highest number of origins and examine the percentage of sites on each platform that have a "passing" grade. A passing grade means that each of the above metrics must be in the "good" (green) range for each site: an LCP of 2.5 seconds or less, a FID of 100ms or less, and a CLS of 0.1 or less.

{{ figure_markup(
  image="top-cwv-performance.png",
  caption="Core web vitals performance by CMS.",
  description="Bar chart showcasing the percentage of sites with good Core Web Vitals for each of the 10 most adopted CMSs. For WordPress, 30% of sites pass on desktop and mobile. For Wix, it is 41% on desktop and 39% on mobile. For Joomla, it's 40% and 38%, respectively. For Drupal, it's 49% and 50%. For Squarespace, it's 47% and 34%. For 1C-Bitrix, it's 54% and 40%. For TYPO3 CMS, it's 57% and 62%. For Duda, it's 68% and 67%. For Weebly 36% and 43%. For Jimdo it's 54% on desktop and 61% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1221898999&format=interactive",
  sheets_gid="445373655",
  sql_file="core_web_vitals.sql",
  width=600,
  height=559
  )
}}

We can see that desktop visitors generally score better than mobile. This can be explained by resource limitations on mobile devices and poorer connections. The large difference between mobile and desktop performance on some platforms also suggests that very different pages are served to users depending on the device they use.

In June, for mobile devices, Duda had the largest percentage of passing sites, with 67% of mobile sites passing all three CWVs. WordPress trailed farthest behind, with 30% of its sites passing. Nevertheless, this indicates a significant increase over our 2021 data, where only 19% of WordPress sites passed.

Desktop device experience was better for most CMSs. Duda had the largest CWV passing rate at 68%. WordPress had the lowest ratio of passing sites: 30%.

We can also evaluate the progress of these CMS platforms' performance on mobile devices by looking at last year's data:

{{ figure_markup(
  image="top-cwv-yoy.png",
  caption="Core web vitals mobile year-over-year.",
  description="Bar chart showing the change in the percentage of mobile sites passing Core Web Vitals year-over-year, for each of the 10 most adopted CMSs, sorted by percentage. For WordPress, it's 15% in 2020, 19% in 2021, and 30% in 2022. For Joomla, it's 20%, 26%, and 38%, respectively. For Drupal, it's 28%, 34%, and 50%. For Wix, it's 4%, 29%, and 39%. For Squarespace, it's 5%, 17%, and 34%. For 1C-Bitrix, it's 23%, 30%, and 40%. For TYPO3 CMS, it's 41%, 46%, and 62%. For Duda, it's 21%, 30%, and 67%. For Weebly, it's 28%, 32%, and 43%. For Adobe Experience Manager ,it's 11% for 2020, 14% for 2021, and 23% for 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=144597470&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

All of these CMSs showed an improvement in the percentage of origins with good CWVs since June 2021.

Let's drill into the three Core Web Vitals to see where each platform has room to improve and which metrics improved the most since last year:

#### Largest Contentful Paint (LCP)

Largest Contentful Paint (LCP) measures the point in time when the page's main content has likely loaded and thus the page is useful to the user. LCP is assessed by measuring the render time of the largest image or text block visible within the viewport.

A "good" LCP is regarded as being under 2.5 seconds.

{{ figure_markup(
  image="lcp-cwv-performance.png",
  caption="Percentage of sites with good LCP by CMS.",
  description="Bar chart showcasing the percentage of sites with good LCP for each of the 10 most adopted CMSs. For WordPress, it's 45% on desktop and 37% on mobile. For Wix, it's 48% and 43% respectively. For Joomla, it's 62% and 55%. For Drupal, it's 73% and 60%. For Squarespace, it's 66% and 40%. For 1C-Bitrix ,it's 72% and 50%. For TYPO3 CMS, it's 82% and 79%. For Duda it's 85% and 79%. For Weebly, it's 59% and 49%. Finally, for Jimdo, it's 69% on desktop and 74% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1306847805&format=interactive",
  sheets_gid="445373655",
  sql_file="core_web_vitals.sql",
  width=600,
  height=559
  )
}}

TYPO3 and Duda had the best LCP scores with 79% of origins having a "good" LCP experience. WordPress and Squarespace have the worst LCP scores with 37% and 40% of origins having good LCP scores, respectively.

{{ figure_markup(
  image="lcp-cwv-yoy.png",
  caption="LCP mobile year-over-year.",
  description="Bar chart showing the change in the percentage of good LCP mobile sites year-over-year for each of the 10 most adopted CMSs sorted by percentage. For WordPress, it's 28% in 2021 and 37% in 2022. For Joomla, it's 42% and 55% respectively. For Drupal, it's 50% and 60%. For Wix, it's 33% and 43%. For Squarespace, it's 30% and 40%. For 1C-Bitrix, it's 45% and 50%. For TYPO3 CMS, it's 69% and 79%. For Duda, it's 52% and 79%. For Weebly, it's 42% and 49%. For Adobe Experience Manager, it's 28% for 2021 and 34% for 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=964886559&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

Compared to the 2021 dataset, all CMSs showed improvements in LCP. Joomla improved by 13%. Drupal, Squarespace, and TYPO3 improved by 10%. WordPress improved by 9%.

These improvements are a positive sign even though the numbers still are low for most CMSs. The difficulty in achieving a good LCP score probably relates to the fact that the LCP is dependent on the download of image/font/CSS and then displaying the appropriate HTML elements. Achieving this in under 2.5 seconds for all device types and connection speeds can be challenging. Improving LCP scores usually involves the correct use of caching, pre-loading, resource prioritization, and lazy loading of other competing resources.

#### First Input Delay (FID)

First Input Delay (FID) measures the time from when a user first interacts with the page (i.e., when they click a link, tap on a button, or use a custom, JavaScript-powered control) to the time when the browser is able to process that interaction. A "fast" FID from a user's perspective would be almost immediate feedback from their actions rather than a stalled experience.

Any delay is a pain point and could correlate with interference from other parts of the site loading while the user tries to interact with the site. A "good" FID is regarded as being under 100 milliseconds.

In 2021's report, the fact that almost all platforms manage to deliver a good FID raised questions about the strictness of this metric. The Chrome team <a hreflang="en" href="https://web.dev/responsiveness/">published an article</a> that was updated in May of 2022 to include a reference to a new metric, <a hreflang="en" href="https://web.dev/articles/inp">Interaction to Next Paint (INP)</a> . Given its beta nature at the time of this writing, we're limiting its inclusion to this reference in anticipation of a possible expansion in next year's report.

{{ figure_markup(
  image="fid-cwv-yoy.png",
  caption="FID mobile year-over-year.",
  description="Bar chart showing the change in the percentage of good FID scores on mobile sites year-over-year for each of the 10 most adopted CMSs sorted by percentage. For WordPress, it's 96% in both 2021 and 2022. For Joomla, it's 85% for 2021 and 89% on 2022. For Drupal, it's 90% and 95%, respectively. For Wix, it's 94% and 92%. For Squarespace, it's 98% and 98%. For 1C-Bitrix, it's 83% and 94%. For TYPO3 CMS, it's 93% and 95%. For Duda, it's 92% and 95%. For Weebly, it's 96% and 90%. Finally, for Adobe Experience Manager, it's 94% for 2021 and 95% for 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=242914394&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

Yearly data shows that most CMSs managed to improve their FID over the past year. Wix and Weebly both regressed by several percentage points over the previous year's data.

#### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS) measures the visual stability of content on a web page, measuring the largest burst of layout shift scores for every unexpected layout shift that occurs during the entire lifespan of a page that was not caused by direct user interactions.

A layout shift occurs any time a visible element changes its position from one rendered frame to the next. The <a hreflang="en" href="https://web.dev/evolving-cls/">CLS metric evolved in 2021</a>, mainly introducing the concept of Session Windows, to be fairer to long-lived pages and Single Page Apps (SPAs).

A score of 0.1 or below is measured as "good," over 0.25 as "poor," and anything in between "needs improvement."

{{ figure_markup(
  image="cls-cwv-yoy.png",
  caption="CLS mobile year-over-year.",
  description="Bar chart showing the change in the percentage of good CLS mobile sites year-over-year, for each of the 10 most adopted CMSs, sorted by percentage. For WordPress, it's 61% in 2021 versus 75% in 2022. For Joomla, it's 62% and 72% respectively. For Drupal, it's 69% and 81%. For Wix, it's 81% and 89%. For Squarespace, it's 54% and 76%. For 1C-Bitrix, it's 66% and 76%. For TYPO3 CMS, it's 69% and 81%. For Duda, it's 55% and 86%. For Weebly, it's 56% and 69%. Finally, for Adobe Experience Manager it's 44% in 2021 and 59% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=2127088376&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

Comparing yearly data, we can see that all CMSs made progress. WordPress, Squarespace, Duda, and Adobe Experience Manager in particular show significant gains.

### Lighthouse

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a> is an open-source, automated tool for improving the quality of web pages. One key aspect of the tool is that it provides a set of audits to assess the status of a website in terms of performance, accessibility, SEO, best practices, and more. Lighthouse reports provide lab data, a way developers can get suggestions on how to improve website performance, but the Lighthouse score has no direct implications on the actual field data collected by <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">CrUX</a>. You can read more on Lighthouse and the correlation between its <a hreflang="en" href="https://web.dev/lab-and-field-data-differences/">lab scores and field data</a>.

HTTP Archive runs Lighthouse on its mobile web pages, which are also [throttled to emulate a slow 4G connection with a CPU slowdown](./methodology#lighthouse), and also this year they started running on Desktop as well.

We can analyze this data to provide another perspective on CMS performance, using the results of these synthetic tests, which also include metrics that are not tracked in CrUX.

#### Performance score

The Lighthouse <a hreflang="en" href="https://web.dev/performance-scoring/">performance score</a> is a weighted average of several scored metrics.

{{ figure_markup(
  image="median-lighthouse-performance.png",
  caption="Median lighthouse performance scores.",
  description="Bar chart showcasing the median Lighthouse performance scores for each of the top 10 most adopted CMSs. For WordPress, it's 43 for desktop and 26 for mobile. For Drupal, it's 45 and 29, respectively. For Joomla, it's 44 and 27. For Wix, it's 45 and 29. For Squarespace, it's 40 and 19. For 1C-Bitrix, it's 37 and 22. For TYPO3 CMS, it's 46 and 35. For Duda, it's 53 and 47. For Weebly, it's 45 and 25. For Adobe Experience Manager, it's 36 and 17.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=2275923&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

We can see that the median performance scores for most platforms on mobile are low and range from about 19 to 35. Duda at 47 is the exception. As Philip Walton noted in 2021, <a hreflang="en" href="https://philipwalton.com/articles/my-challenge-to-the-web-performance-community/">this does not directly imply bad results</a> in mobile field data, but it does imply that all platforms have room for improvement, especially on low-end devices with network connections similar to those Lighthouse attempts to emulate.

WordPress, Joomla, Drupal, and 1C-Bitrix showed no change from last year's results. Wix dropped from 30% to 29% while the rest showed improvement.

Desktop scores were good across the board with all CMSs seeing 10-20 point improvements. This isn't surprising, given the faster CPUs and networks available to the desktop.

#### SEO score

Search Engine Optimization (or SEO) is the practice of improving a website to make it more easily found in search engines. This is covered more in-depth in our [SEO](./seo) chapter, but it relates to CMSs as well. A CMS and content on it is generally set up to serve as much information to search engine crawlers as possible to make it as easy as possible for them to index site content appropriately in search engine results. Compared to a custom-built website, one might expect a CMS to provide good SEO capabilities, and the Lighthouse scores in this category are appropriately high.

{{ figure_markup(
  image="median-lighthouse-seo.png",
  caption="Median lighthouse SEO scores.",
  description="Bar chart showcasing the median Lighthouse SEO scores for each of the top 10 most adopted CMSs. For WordPress it's 91 for desktop and 89 for mobile. For Drupal, it's 83 and 83. For Joomla, it's 83 and 86, respectively. For Wix, it's 92 and 91. For Squarespace, it's 92 and 92. For 1C-Bitrix, it's 83 and 85. For TYPO3 CMS, it's 83 and 86. For Duda, it's 83 and 86. For Weebly, it's 82 and 85. For Adobe Experience Manager, it's 83 and 85.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1901746915&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

The median SEO scores in all of the top 10 platforms range from 83-92, a [slight reduction from 84-95 in 2021](../2021/cms#seo-score). Desktop scores are similar—slightly better in some cases, slightly worse in others.

#### Accessibility score

An accessible website is a site designed and developed so that people with disabilities can use them. Web accessibility also benefits people without disabilities, such as those on slow internet connections. Read more in our [Accessibility](./accessibility) chapter.

Lighthouse provides a set of accessibility audits, and it returns a weighted average of all of them. See <a hreflang="en" href="https://web.dev/accessibility-scoring/">Scoring Details</a> for a full list of how each audit is weighted.

Each accessibility audit is either a pass or a fail, but unlike other Lighthouse audits, a page doesn't get points for partially passing an accessibility audit. For example, if some elements have screen reader-friendly names, but others don't, that page gets a zero for the screen reader-friendly-names audit.

{{ figure_markup(
  image="median-lighthouse-accessibility.png",
  caption="Media Lighthouse accessibility scores.",
  description="Bar chart showcasing the median Lighthouse SEO score for each of the top 10 most adopted CMSs. For WordPress it's 86 for desktop and 86 for mobile. For Drupal, it's 86 and 86. For Joomla, it's 83 and 83 respectively. For Wix, it's 88 and 88. For Squarespace, it's 93 and 91. For 1C-Bitrix, it's 77 and 77. For TYPO3 CMS, it's 84 and 85. For Duda, it's 78 and 79. For Weebly, it's 83 and 84. For Adobe Experience Manager, it's 86 and 86.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=201542197&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

The median Lighthouse accessibility score for the top 10 CMSs ranges between 77 and 91. Squarespace had the highest score of 91, while 1C-Bitrix had the lowest accessibility scores. The desktop scores are almost identical to mobile, perhaps reflecting that the same sites are delivered to both desktop and mobile devices.

#### Best practices

The Lighthouse <a hreflang="en" href="https://web.dev/lighthouse-best-practices/">best practices</a> try to ensure that web pages are following best practices for the web for a variety of different metrics such as supporting HTTPS, no errors logged in the console, and more.

{{ figure_markup(
  image="median-lighthouse-best-practices.png",
  caption="Media Lighthouse best practices scores.",
  description="Bar chart showcasing the median Lighthouse best practices score for each of the top 10 most adopted CMSs. For WordPress, it's 92 for desktop and 83 for mobile. For Drupal, it's 83 and 83. For Joomla, it's 83 and 75 respectively. For Wix, it's 92 and 100. For Squarespace, it's 92 and 92. For 1C-Bitrix, it's 83 and 75. For TYPO3 CMS, it's 92 and 83. For Duda, it's 83 and 75. For Weebly, it's 75 and 75. For Adobe Experience Manager, it's 83 and 75.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1066307789&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

Wix had the highest median best practices score of 100, while many of the other top 10 platforms share the lowest score of 75. Again, desktop results are very similar though larger in some cases. This may reflect incorrect image aspect ratios on mobile pages since most of the other audits in this category are platform-based.

## Resource weights

We also used HTTP Archive data to analyze the weight of resources used across different platforms. We did this to highlight possible opportunities for performance improvement. Page loading performance does not depend exclusively on the number of downloaded bytes, but fewer bytes necessary to load a page results in reduced costs, fewer carbon emissions, and potentially faster performance—especially for slower connections.

{{ figure_markup(
  image="median-cms-page-weight.png",
  caption="Media resource weights by CMS.",
  description="Column chart showing the median total page weight of each of the top five most adopted CMSs for each device category. For WordPress, it's 2,559 KB on desktop and 2,314 KB on mobile. For Drupal, it's 2,351 KB and 2,146 KB respectively. For Joomla, it's 2,799 KB and 2,495 KB. For Wix, it's 3,172 KB and 2,158 KB. For Squarespace, it's 3,462 KB and 3,577 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1764509612&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Most of the top five CMSs deliver a median page weight of around ~2 MB, except Squarespace which delivers a larger ~3.5 MB. All except Joomla showed [increases in page weight over 2021 data](../2021/cms#page-weight-breakdown).

{{ figure_markup(
  image="distribution-cms-page-weight.png",
  caption="Mobile page weight distribution by CMS.",
  description="Distribution showing the percentile distribution of total mobile page weight among each of the top five most adopted CMSs. WordPress it's 673 KB at 10th percentile, 1,229 KB at 25th, 2,314 KB at 50th, 4,479 at 75th, and 8,558 at 90th percentile. For Wix it's 1,048, 1,455, 2,158, 3,586, and 6,843 KB respectively. For Joomla it's 685, 1,268, 2,495, 4,892, and 9,473 KB. For Drupal it's 618, 1,130, 2,146, 4,193, and 8,229 KB. And finally for Squarespace it's 1,496 KB at the 10th percentile, 2,123 KB at 25th, 3,577 KB  at 50th, 6,539 KB at 75th, and 11,434 KB at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1236078412&format=interactive",
  sheets_gid="859067552",
  sql_file="page_weight_distribution.sql"
  )
}}

The distribution of page weight in each platform's percentiles is substantial. Page weight is probably related to the differences in user content across web pages, the number of images used, plugins installed, etc. The smallest pages delivered per platform come from WordPress, a marked improvement over last year's data. This year, WordPress only sends 673 KB for their 10th percentile of visits. The largest pages come from Squarespace, with ~11.4 MB delivered for their 90th percentile of visits, a ~2 MB increase over last year's data.

### Page weight breakdown

Page weight is the sum in kilobytes of resources used on a page. We can attempt to evaluate these different resource sizes across different CMSs.

#### Images

Images, which are usually the heaviest resource loaded on a web page, account for a large portion of the resource weight.

{{ figure_markup(
  image="median-cms-image-size.png",
  caption="Median image size by CMS.",
  description="Column chart showing the median weight of image resources downloaded in each of the top five most adopted CMSs, for each device. For WordPress it's 1,202 KB on desktop and 1,100 KB on mobile, for Drupal it's 1,279 KB on desktop and 1,158 KB on mobile, for Joomla it's 1,690 KB and 1,504 KB, for Wix it's 647 KB on desktop and 290 KB on mobile, and finally for Squarespace it's 1,623 KB for desktop and 1,790 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1491116500&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Wix delivers substantially fewer image bytes, with only 290 KB delivered for the median of mobile views. This suggests good use of image compression and lazy image loading. All of the other top five platforms deliver over 1 MB of images, with Squarespace delivering the largest ~1.7 MB.

Advanced image formats provide a considerable improvement in compression, enabling resource savings and faster site loading. WebP is commonly supported in all major browsers today, with over <a hreflang="en" href="https://caniuse.com/webp">95% support</a>. In addition, there are several newer image formats gaining popularity and adoption, namely <a hreflang="en" href="https://caniuse.com/avif">AVIF</a>, and <a hreflang="en" href="https://jpegxl.info">JPEG-XL</a>.

We can examine the usage of the different image formats across the top CMSs:

{{ figure_markup(
  image="image-format-popularity.png",
  caption="Image format popularity by CMS.",
  description="Bar chart showcasing the relative popularity of each image format, among the top 15 most adopted CMSs. For WordPress, it's 39% jpg, 30% png, 20% gif, 7% webp, 4% svg, 1% ico and 0% avif. For Wix, it's 11%, 5%, 6%, 75%, 0%, 1%, and 0% respectively. For Joomla, it's 48%, 36%, 10%, 2%, 2%, 3%, and 0%. For Drupal, it's 41%, 35%, 13%, 2%, 6%, 2% and 0%. FOr Squarespace, it's 53%, 30%, 12%, 0%, 3%, 2% and 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1668189558&format=interactive",
  sheets_gid="710966440",
  sql_file="image_format_popularity.sql",
  width=600,
  height=556
  )
}}

Wix and Duda make the most use of WebP, at ~75% and 42% adoption respectively, while the rest show minor increases.

With the <a hreflang="en" href="https://caniuse.com/webp">growing support of WebP</a>, it seems all platforms have work to do to reduce the usage of the older JPEG and PNG formats without compromising on image quality.

WordPress introduced support for WebP in WordPress 5.8, which was released in June of 2021. WebP support was <a hreflang="en" href="https://make.wordpress.org/core/2022/06/30/plan-for-adding-webp-multiple-mime-support-for-images/">planned to be included by default</a> in WordPress 6.1. However, this decision has been delayed. Eventually, we expect a significant increase in WebP adoption via WordPress which may be apparent in the 2023 results.

#### JavaScript

{{ figure_markup(
  image="median-size-js.png",
  caption="Median JavaScript resources by CMS.",
  description="Column chart showing the median weight of JavaScript resources downloaded in each of the top five most adopted CMSs, for each device. In all cases the desktop and mobile sizes are identical. For WordPress, it's 521 KB on both desktop and mobile. For Drupal, it's 416 KB for both. For Joomla, it's 452 KB. For Wix, it's 1,318 KB. For Squarespace it's 997 KB for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1169405351&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

The top five CMSs all deliver pages that rely on JavaScript, with Drupal delivering the fewest JavaScript bytes: 416 KB on mobile. Wix delivers the most JavaScript bytes—over 1.3 MB.

#### HTML document

{{ figure_markup(
  image="median-size-html.png",
  caption="Median HTML size by CMS.",
  description="Column chart showing the median weight of the HTML resource downloaded in each of the top five most adopted CMSs, for each device. In most cases the desktop and mobile sizes are very similar. For WordPress, it's 40 KB on desktop and 37 KB on mobile. For Drupal, it's 23 KB for both. For Joomla, it's 26 KB and 22 KB. For Wix, it's 123 KB on desktop and 118 KB on mobile. For Squarespace, it's 27 KB for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1713320070&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Examining the HTML document sizes, we can see that most of the top CMSs deliver a median HTML size of ~22 KB–37 KB. The only exception is Wix which delivers ~118 KB, a minor improvement over 2021's results. This may suggest extensive use of inlined resources and shows an area that can be further improved.

#### CSS

{{ figure_markup(
  image="median-size-css.png",
  caption="Median CSS size by CMS.",
  description="Column chart showing the median weight of CSS resources downloaded in each of the top five most adopted CMSs for each device. In most cases (apart from Wix) the desktop and mobile sizes are very similar. For WordPress, it's 117 KB on desktop and 115 KB on mobile. For Drupal, it's 68 KB and 66 KB, respectively. For Joomla, it's 86 KB and 83 KB. For, Wix it's 18 KB on desktop but only 9 KB on mobile. For Squarespace, it's 89 KB for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=176229983&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Next, we examine the use of explicit CSS resources that are downloaded. Here we can see a different distribution between platforms that strengthens the case for inlining CSS. Wix delivers the fewest CSS resources, with only ~9 KB sent on mobile views. WordPress delivers the most with ~115 KB.

#### Fonts

{{ figure_markup(
  image="median-size-font.png",
  caption="Median font size by CMS.",
  description="Column chart showing the median weight of fonts resources downloaded in each of the top five most adopted CMSs, for each device. In all cases the desktop and mobile sizes are the same. For WordPress, it's 137 KB. For Drupal, it's 92 KB. For Joomla, it's 82 KB. For Wix, it's 148 KB. For Squarespace, it's 202 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1008146261&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

To display text, web developers often choose to use a variety of fonts. Joomla delivers the fewest font bytes, with 82 KB on mobile views. Squarespace delivers the most with 202 KB.

## WordPress in 2022

WordPress is the most commonly used CMS today. Almost three out of four sites built with a CMS are using WordPress, which merits further discussion.

WordPress is an open-source project, which has been around since 2003. Many sites built on WordPress use a variety of themes and plugins, sometimes through page builders such as Elementor, WP Bakery, or Divi.

The WordPress ecosystem maintains the CMS and services required for additional functionality through custom services and products (themes and plugins). This community has an outsized impact, with a relatively small number of people maintaining both the CMS itself and providing the additional functionality which makes WordPress sufficiently powerful and flexible that it can serve most kinds of websites. This flexibility is important when explaining the market share, but it also complicates the discussion around WordPress-based site performance.

In 2021, contributors from the WordPress community acknowledged the current state of performance, in this <a hreflang="en" href="https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/">proposal</a> to create a performance-dedicated core team, which we hope will improve the performance of the average WordPress site.

This year, we compared our results against last year, focusing on adoption by geography and passing Core Web Vitals by geography along with a look at average resource usage.

### Adoption by geography

First, we examined WordPress adoption by geography across all sites in our dataset in comparison to our 2021 results.

{{ figure_markup(
  image="wordpress-adoption-geo-yoy.png",
  caption="WordPress adoption by geography year-over-year on mobile.",
  description="Bar chart depicting the adoption of WordPress in each of the 10 geographies with the most websites. For all countries, it's 32% on 2021 and 34% on 2022. For the United States, it's 32% for both. For Japan, it's 35% and 38%, respectively. For Brazil, it's 29% and 31%. For Germany, it's 27% and 29%. For the United Kingdom of Great Britain and Northern Ireland, it's 31% and 32%. For Spain, it's 37% and 39%. For Italy, it's 36% and 38%. For India, it's 28% and 30%. For France, it's also 28% and 30%. For Canada, it's 32% in 2021 and 33% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=442489769&format=interactive",
  sheets_gid="694875761",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=579
  )
}}

According to our dataset, WordPress adoption is growing significantly in all the top geographies.

### Passing CWVs by geography

Next, we looked at the number of WordPress origins with passing scores for Core Web Vitals, but this time we broke them down by geography, mobile device usage, and in comparison with our 2021 results.

{{ figure_markup(
  image="wordpress-cwv-yoy.png",
  caption="WordPress core web vitals by geography year-over-year.",
  description="Bar chart depicting the adoption of WordPress in each of the 10 geographies with the most websites. For United States of America, it's 28% for 2021 and 40% for 2022. For Japan, it's 38% and 52% respectively. For India, it's 8% and 15%. For Brazil, it's 5% and 10%. For the United Kingdom of Great Britain and Northern Ireland, it's 33% and 44%. For Germany, it's 35% and 48%. For Spain, it's 21% and 33%. For Italy, it's 19% and 29%. For France, it's 26% and 39%. For Canada, it's 36% for 2021 and 49% for 2022. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1279742547&format=interactive",
  sheets_gid="1742929367",
  sql_file="core_web_vitals_by_geo.sql",
  width=600,
  height=579
  )
}}

All geographies showed improvements, ranging from a 5% overall gain in Brazil to 14% in Japan. Also worth noting is the large disparity across geographies, with Brazil at 10% total compared to Japan at 52%. Brazil on the low end is growing, though, improving 100% year-over-year. As we evaluate next year's dataset, it may be worth investigating the low end performers further to identify potential causes and opportunities for improvement.

### Plugins

We explored how WordPress sites use external resources and separated them into resources that are included in plugins, themes, and shipped in WordPress core (wp-includes) with comparison to our 2021 results.

{{ figure_markup(
  image="median-wordpress-resources.png",
  caption="WordPress resources year-over-year.",
  description="Column chart showing the median resources used for WordPress websites. The number of resources are the same for desktop and mobile: 24 Plugins, 18 themes, and 12 wp-includes at the median.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=660449132&format=interactive",
  sheets_gid="1922458949"
  )
}}

We can see no noticeable change in the number of resources used year on year. We'll revisit again next year, perhaps looking more closely at the implied performance impact of popular themes and plugins.

## Conclusion

CMS platforms continue to grow and are becoming more ubiquitous year by year. They are essential for creating and consuming content on the internet, especially as more people and businesses establish an online presence.

The introduction of Core Web Vitals, along with the advancements in performance data visibility, has made web performance a priority everywhere CMSs are used. We hope the insights in this chapter will help us all form a better understanding of the current state of the web, ultimately making the web a better place.

CMSs are doing great work and have opportunity to further improve user experiences on the web at scale by striving to enhance their infrastructure, experiment and integrate with new standards as they evolve, and follow best practices.

On the other hand, Core Web Vitals as standards still have some evolving to do. We mentioned some ideas for a <a hreflang="en" href="https://web.dev/responsiveness/">better responsiveness metric</a> above. In addition, navigation between pages in a site should be better tracked and take into account the architectural differences between <a hreflang="en" href="https://web.dev/articles/vitals-spa-faq">Single-Page Applications (SPAs) and Multi-Page Applications (MPAs)</a> architectures.

We look forward to next year's results and hope to both expand our datasets and improve our methodologies. In the meantime, onward and upward, let's keep making the web better.
