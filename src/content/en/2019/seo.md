---
part_number: I
chapter_number: 10
title: SEO
description: State of SEO 2019
hero_image: ''
authors: [ymschaap, rachellcostello, AVGP]
reviewers: [clarkeclark, andylimn, voltek62, AymenLoukil, catalinred]
translaters: []
---
# Chapter 10: SEO

## Intro

The SEO (Search Engine Optimization) chapter of the Web Almanac analyses onsite elements of the web that impact the crawling and indexing of content for search engines. Our analysis includes data from the Lighthouse Audit tool, HTML element analysis and the [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report).

We focus on SEO fundamentals like <title> elements, type of on-page links, content and loading speed, but also the more technical aspects of SEO, including structured data, internationalisation and AMP.

Our custom metrics provide insights that, up until now, have not been exposed before. We are now able to make claims about the adoption and implementation of the hreflang tag, rich results eligibility, heading tag usage and even anchor-based navigation for single page apps.

It must be noted that our data is limited to analysing the homepage only, and has not been gathered from site-wide crawls. This will impact many metrics we’ll discuss, so we’ve added any relevant limitations in this case whenever we mention a specific metric.

Read on to find out more about the current state of the web and its search engine friendliness.


## Fundamentals

Fundamental to SEO is for content that lives on the web to be found, indexed and understood by the search engines. To support this, search engine crawlers must be able to reach a page, they must be permitted to access and index that page, understand the page’s contents, and to continue crawling the website using links found on that page.


#### Content

Core for search engines to answer queries with search results, is that they are able to index the web’s content. But what content does it find? To analyze this we created two custom metrics that have been applied to all 5M+ homepages.


##### Words

We analysed the content on the pages by looking for groups of at least 3 words and counting them. We found 2.73% desktop pages without any word groups. The median desktop homepage has **346** words, and the median mobile homepage has a slightly lower word count at **306** words. This shows mobile sites do serve a bit less content to their users, but at over 300 words still a healthy amount to read. Overall the distribution of words is broad, with between 22 words at the 10th percentile up to 1361 at the 90th percentile.

<graph histogram number of words. Source: 10.09, column C, desktop & mobile>

##### Headings

We also looked at whether the web provides the right context to content. Key is using headings which, similar to for example books make content easier to read and parse. 10.67% of the pages have no heading tags at all.

<graph histogram number of heading elements. Source: 10.09a, column F>

The median heading (h1, h2, h3, h4) element count on the web’s homepage is **10**. With 30 (mobile) and 32 (desktop) words used in headings. This implies that from the websites that utilise headings, put significant effort in making sure a website is properly readable and good for outlining the page structure to search engine bots.

The H1 is one fundamental SEO element to improve on-page relevance for a keyword. Although Google [recently emphasized](https://twitter.com/googlewmc/status/1179803329247039488) it can index and rank pages fine without h1 tags.

In terms of specific heading length, the median length of the first H1 element found on desktop is **19** characters.

Same as this line.

<graph histogram h1 tag source: 10.16, column C, desktop & mobile>


##### Images

Considering the importance of alt text for SEO, screen readers and accessibility, it is far from ideal to see that only **46.71%** of mobile pages use alt attributes on all of their images. This means that there are still improvements to be made with making images across the web more accessible to users and understandable for search engines. More about accessibility in this <chapter link placeholder a11y>.


#### Markup


##### <title>

Page titles are an important way of communicating the purpose of a page to a user or search engine, so it’s no surprise to see that **97.1%** of mobile pages have a document title. <title> tags are also used as headings in the search engine results and as title for the browser when visiting a page. This visibility might explain the high adoption.

Even though [Google usually displays the first 50-60 characters of a page title](https://moz.com/learn/seo/title-tag) within a SERP (Search Engine Results Page), the median length of the <title> tag was only **21 characters** for mobile pages and **20 characters** for desktop pages. Even the 75th percentile is still below the cutoff length. This suggests that some SEOs and content writers aren’t making the most of the space allocated to them by search engines for describing their homepages in the SERPs.

<graph histogram length <title> Source: 10.07b, column C, desktop & mobile>

##### <meta=description>

Compared to the <title> fewer pages were detected to have a meta description, as only **64.02%** of mobile pages have this meta tag. Considering that Google often rewrites meta descriptions in the SERPs in response to the searcher's query, perhaps website owners place less importance on including a meta description at all.

The median meta description length was also lower than the [recommended length of 155-160 characters](https://moz.com/learn/seo/meta-description), with desktop pages having descriptions of **123 characters**. Interestingly, meta descriptions were consistently longer on mobile than on desktop, despite mobile SERPs traditionally having a shorter pixel limit. This has been extended only recently, so perhaps more website owners have been testing the impact of having longer, more descriptive meta descriptions.

<graph histogram length <meta description> Source: 10.07c, column C, desktop & mobile>


#### Indexability

The majority of pages tested were available for search engines, with **87.03%** of initial HTML requests on desktop returning a 200 status code. The results were slightly lower for mobile pages, with only **82.95%** of pages returning a 200 status code.

The next most commonly found status code on mobile was 302, a temporary redirect, which was found on **10.45%** of mobile pages. This was higher than on desktop, with only **6.71%** desktop home pages returning a 302 status code. This could be due to the fact that the [mobile homepages are alternates](https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls) to an equivalent desktop page, such as on non-responsive sites that have separate versions for each device.

**96.93%** of mobile pages passed the [Lighthouse indexing audit](https://developers.google.com/web/tools/lighthouse/audits/indexing), meaning that these pages didn’t contain a noindex tag in the <head> or in the HTTP header. However, this means that **3.07%** of mobile homepages _did_ have a noindex tag, which is cause for concern. These pages prevent search engines from indexing the page.

<rick: add technical note about CRuX & HTPP Archive datasets skewing this metric>

**48.34%** of mobile pages were [detected](https://developers.google.com/web/tools/lighthouse/audits/canonical) to have a canonical tag. Canonical tags provide hints to the search engine what URL to use for indexing and ranking. Especially useful for preventing duplicate content or other crawling and indexing issues.

One of the most effective methods for controlling search engine crawling is the [robots.txt file](https://www.deepcrawl.com/knowledge/technical-seo-library/robots-txt/), however, only **72.16%** of mobile sites have a valid robots.txt, [according to Lighthouse](https://developers.google.com/web/tools/lighthouse/audits/robots). The key issues are split between 22% having no robots.txt file at all, and ~6% serving an invalid robots.txt file, and thus failing the audit. While there are many valid reasons to not have a robots.txt file, having an invalid robots.txt could be concerning. Think of sensitive content getting indexed that should’ve been prevented by the robots.txt.


#### Linking

The most important attribute of a webpage, are links. Links point to relevant urls. 96% of the webpages in our data contain at least one internal link, and 93% contain at least one link to another domain.

The number of internal and external links included on desktop pages were consistently higher than the number found on mobile pages. Often a limited space on a smaller viewport causes fewer links to be included in the design of a mobile page compared to desktop.

But less internal links on the mobile version of the page [might cause an issue](https://moz.com/blog/internal-linking-mobile-first-crawl-paths) for your website. With mobile-first indexing - which for new websites is the default for Google - if a page is only linked from the desktop version and not present on the mobile version, search engines will have a much harder time discovering and ranking them.

<graph histogram count of links by type Source: 10.10, column C desktop only>

<graph histogram count of links by type Source: 10.10, column D, E, desktop only>


The median desktop page includes **70** internal (same-site) links, whereas the median mobile page has **60** internal links. The median number of external links per page followed a similar trend, with desktop pages including **10** external links, and mobile pages including **8**.

Anchor links, which link to a certain scroll position on the same page, are not very popular. Over 65% have no page anchor and the data’s median count is 0. This might imply websites prefer to split up long-form content into multiple pages.

Good news comes from the metric descriptive link text. **89.94%** of mobile pages pass the descriptive link text [Lighthouse audit](https://developers.google.com/web/tools/lighthouse/audits/descriptive-link-text). These sites don’t have generic ‘click here’, ‘go’, ‘here’ or ‘learn more’ links but use more meaningful link text.


## Advanced

Several more technically complex aspects have been gaining importance on successfully indexing and ranking websites in the search engine. Two key pillars are _security_ and _speed_. Mobile loading speed as ranking factor was first [announced](https://webmasters.googleblog.com/2018/01/using-page-speed-in-mobile-search.html) by Google in 2018, and HTTPS already back since in [2014](https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html).


#### Speed

A fast loading website is key to a good user experience. Users that have to wait too long for a site to load, have the tendency to move on. For SEO that means that the chance that the user clicks back, and tries another search results, increases.

Our metric is based on the Chrome User Experience Report (CrUX) which collects data from real-world Chrome users. This data shows that **63.47%** of the web is labelled as **slow**. Split by device, this picture is even bleaker for tablet (82%) and phone (77,61%). Slow is defined as the First Contentful Paint having to take over 2500ms and First Input Delay over 250ms.

<graph data 10.15b: CruX image similar to [IMG](https://developers.google.com/web/updates/images/2018/08/crux-dash-fcp.png) per device + speed label>


Although the numbers are bleak for the speed of the web, the good news is that SEO-experts and tools have been focusing more and more on these technical challenges of speeding up websites. Read more in the Performance chapter

<chapter link placeholder performance>.


#### Structured data

Structured data allows website owners to add additional semantic data to their web pages, for example by adding [JSON-LD](https://en.wikipedia.org/wiki/JSON-LD) snippets or [Microdata](https://developer.mozilla.org/en-US/docs/Web/HTML/Microdata). Search engines then parse this data to better understand these pages and may display additional relevant information in search results. Most commonly found is [reviews](https://developers.google.com/search/docs/data-types/review-snippet) of [products](https://developers.google.com/search/docs/data-types/product), [businesses](https://developers.google.com/search/docs/data-types/local-business), [movies](https://developers.google.com/search/docs/data-types/movie) or [a bunch of other things](https://developers.google.com/search/docs/guides/search-gallery). This [extra visibility](https://developers.google.com/search/docs/guides/enhance-site) is interesting for site owners, given it might provide more opportunities for traffic. E.g. the relative new [FAQ schema](https://developers.google.com/search/docs/data-types/faqpage) attached to your search result doubles the size of your search snippet.

By far the most popular data type that triggers a search engine feature is the SearchAction, which powers the [sitelinks searchbox](https://developers.google.com/search/docs/data-types/sitelinks-searchbox).

We found that **14.67%** of sites have structured data eligible for rich results on mobile. Interestingly, desktop sites are slightly lower at **12.46%**. We think this is positive news, because structured data provide more control to websites on what is shown in the search engines.

Among the sites with structured data markup, the five most prevalent types are:



1. WebSite (16.02%)
2. SearchAction (14.35%)
3. Organization (12.89%)
4. WebPage (11.58%)
5. ImageObject (5.35%)

It's noteworthy that for the analysis, we only looked at the homepages, so this might look very different if we were to consider interior pages, too.

Interesting note is that the top 5 markup types all lead to more visibility in Google’s search results, which might be the fuel for widespread adoption of structured data.

Review stars are on 1.09% of the web’s homepages (via [AggregateRating](https://schema.org/AggregateRating)). Newly introduced [QAPage](https://schema.org/QAPage) appeared only in 48 instances, and [FAQPage](https://schema.org/FAQPage) only 218 times. These last two counts are expected to increase in future crawls/almanac analysis.


#### Internationalization

Internationalization (I18n) might be one of the most complex aspects of SEO, even according to some Google search [employees](https://twitter.com/JohnMu/status/965507331369984002). Internationalization in SEO focuses on serving the right content targeted for language and / or location of the user.

While **38.4%** (33.79% on mobile) of the sites have the HTML lang attribute set to English, only **7.43%** (6.79% on mobile) of the sites also contain an hreflang link to another language version.

<graph 10.04b - [do we want to chart this data, e.g. what does it really mean for SEO?]>


Next to English, the most common languages are French, Spanish and German. Followed by languages targeted towards specific geographics like English for Americans (en-us) or more obscure combinations like Spanish for the Irish (es-ie).

The analysis did not check for correct implementation (the different language versions need to properly link to each other, for example), but looking at the low adoption of [having an x-default version as is recommended](https://www.google.com/url?q=https://support.google.com/webmasters/answer/189077?hl%3Den&sa=D&ust=1570627963630000&usg=AFQjCNFwzwglsbysT9au_I-7ZQkwa-QvrA) (only 3.77% on desktop and 1.3% on mobile) is an indicator that this topic is complex and not always easy to get right.


#### SPA crawlability

Single-page-apps like React and Vue bring their own SEO complexity. Especially hash-based navigation which makes it hard for search engines to crawl and index a website. For example, Google had an "AJAX crawling scheme" workaround that turned out to be complex for search engines as well as developers and [was deprecated in 2015](https://webmasters.googleblog.com/2015/10/deprecating-our-ajax-crawling-scheme.html).

The number of SPAs that were tested had a relatively low number of links served via hash URLs, with **13.08%** of React mobile pages using hash URLs for navigation, **8.15%** of mobile Vue.js pages using them, and **2.37%** of mobile Angular pages using them. These results were very similar for desktop pages too. The high number of hash URLs in React pages is surprising - especially in contrast to a lower number of hash URLs in Angular pages. Both frameworks promote adopting routing packages where the [History API](https://developer.mozilla.org/en-US/docs/Web/API/History) is the default for links, instead of relying on hash URLs. Vue is [considering moving to using the History API as the default](https://github.com/vuejs/rfcs/pull/40) as well in version 3 of their vue-router package.


#### AMP

AMP (previously ‘Accelerated Mobile Pages’) was first introduced in 2015 by Google as an open source HTML framework. It provides components and infrastructure for websites to provide a faster experience for users, especially on mobile, by using optimisations such as lazy-loading and optimised images. Especially Google adopted this for their search engine, where AMP pages are also served from their own CDN. This feature later became a standards proposal under the name [Signed HTTP Exchanges](https://wicg.github.io/webpackage/draft-yasskin-http-origin-signed-responses.html).

0.74% of desktop websites (0.62% for mobile websites) contain a link to an AMP version. Given the visibility this project has had, this could be seen as having a relatively low adoption.


#### Secure

A strong online shift has been for the web to move to HTTPS by default. HTTPS prevents website traffic from being intercepted on for example public WIFI networks, especially user input data is then transmitted unsecure (for more about why sites should adopt https, please see [Why HTTPS Matters](https://developers.google.com/web/fundamentals/security/encrypt-in-transit/why-https)). Google with its browser and search engine have been pushing for sites to adopt HTTPS by clearly stating that [HTTPS is a ranking signal](https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html) and by labelling the non-HTTPS pages as ‘[not secure](https://www.blog.google/products/chrome/milestone-chrome-security-marking-http-not-secure/)’.

We found that now 67.06% of websites on desktop are served over HTTPS. The Google [Transparancy Report](https://transparencyreport.google.com/https/overview) reports 90% adoption for the top 100 non-Google domains (representing 25% of all website traffic worldwide). The difference could be explained by that relatively smaller sites (our dataset has 5M websites), are adopting HTTPS on a slower rate.


## Conclusion

Through our analysis, we (as authors) observed that the majority of websites are getting the fundamentals right, in that their homepages are crawlable, indexable and include the key content required to rank in Google’s SERPs. Not every person who owns a website will be aware of SEO at all, let alone best practice guidelines, so it is promising to see that so many sites have got the basics covered.

However, more sites are missing the mark than expected when it comes to some of the more advanced aspects of SEO and accessibility. Site speed is one of these factors that many websites are struggling with, especially on mobile. This is a significant problem as speed is one of the biggest contributors to UX, which is something that can impact rankings.

We were surprised to find the large adoption of Structured Data. This shows websites do make the investment to stand out in the search results by adding structured data for users to get easy access to their site search or displaying up-to-date company details.
