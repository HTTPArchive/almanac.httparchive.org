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

SEO (Search Engine Optimization) isn't just a hobby or a side project for digital marketers, it is crucial for the success of a website. The primary goal of SEO is to make sure that a website is optimised for the search engine bots that need to crawl and index its pages, as well as for the users that will be navigating the website and consuming its content. SEO impacts everyone working on a website, from the developer who is building it, through to the digital marketer who will need to promote it to new potential customers.

Let's put the importance of SEO in to perspective. Earlier this year, the SEO industry looked on in horror (and fascination) as [ASOS reported an 87% decrease in profits](https://www.bbc.co.uk/news/business-47877688) after a "difficult year". The brand attributed their issues to a drop in search engine rankings which occurred after they launched over 200 microsites and significant changes to their website's navigation, among other technical changes. Yikes.

The SEO chapter of the Web Almanac was created to analyse onsite elements of the web that impact the crawling and indexing of content for search engines, and ultimately, website performance. In this chapter, we'll take a look at how well-equipped the top websites are to provide a great experience for users and search engines, and which ones still have work to do.

Our analysis includes data from the [Lighthouse Audit tool](https://developers.google.com/web/tools/lighthouse), HTML element analysis and the [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report). We focused on SEO fundamentals like <title> elements, the different types of on-page links, content and loading speed, but also the more technical aspects of SEO, including indexability, structured data, internationalisation and AMP across **5 million websites**.

Our custom metrics provide insights that, up until now, have not been exposed before. We are now able to make claims about the adoption and implementation of elements such as the hreflang tag, rich results eligibility, heading tag usage and even anchor-based navigation for single page apps.

Note: Our data is limited to analysing homepages only, and has not been gathered from site-wide crawls. This will impact many metrics we’ll discuss, so we’ve added any relevant limitations in this case whenever we mention a specific metric.

Read on to find out more about the current state of the web and its search engine friendliness.

## Fundamentals

Search engines have a 3-step process: crawling, indexing and ranking. To be search engine-friendly, a page needs to be discoverable, understandable, and contain quality content that would provide value to a user who is browsing the SERPs (search engine results pages).

We wanted to analyze how much of the web is meeting the basic standards of SEO best practices, so we assessed on-page elements such as body content, meta tags and internal linking. Let's take a look at the results.

### Content

To be able to understand what a page is about and decide which searcher queries it provides the most relevant answers for, a search engine must be able to discover and access its content. What content are search engines currently finding, however? To answer this, we created two custom metrics that have been applied to all 5M+ homepages.

#### Word Count

We assessed the content on the pages by looking for groups of at least 3 words and counting how many were found in total. We found **2.73%** of desktop pages which didn't have any word groups, meaning that they have no body content to help search engines understand what the website is about.

The median desktop homepage has **346** words, and the median mobile homepage has a slightly lower word count at **306** words. This shows that mobile sites do serve a bit less content to their users, but at over 300 words, this is still a reasonable amount to read, especially for a homepage which will naturally contain less content than an article page, for example. Overall the distribution of words is broad, with between **22 words at the 10th percentile** up to **1361 at the 90th percentile**.

<graph histogram number of words. Source: 10.09, column C, desktop & mobile>

#### Headings

We also looked at whether pages are structured in a way that provides the right context for the content their contain. Headings are used to format and structure a page and make content easier to read and parse. Despite the importance on headings, **10.67%** of pages have no heading tags at all.

<graph histogram number of heading elements. Source: 10.09a, column F>

The median heading (H1, H2, H3, H4) element count on the web’s homepage is **10**. With **30** (on mobile) and **32** (on desktop) words used in headings. This implies that the websites that utilise headings put significant effort in making sure that their pages are readable, descriptive and clearly outline the page structure and context to search engine bots.

In terms of specific heading length, the median length of the first H1 element found on desktop is **19** characters.

For advice on how to handle H1s and headings for SEO and accessibility, take a look at this [video response by John Mueller](https://www.youtube.com/watch?v=zyqJJXWk0gk) in the Ask Google Webmasters series.

<graph histogram h1 tag source: 10.16, column C, desktop & mobile>

### Meta Tags

Meta tags allow us to give specific instructions and information to search engine bots about the different elements and content on a page. Certain meta tags can convey things like the topical focus of a page, as well as how the page should be crawled and indexed. We wanted to assess whether or not websites were making the most of these opportunities that meta tags provide.

#### Page Titles

Page titles are an important way of communicating the purpose of a page to a user or search engine. <title> tags are also used as headings in the SERPS and as the title for the browser when visiting a page, so it’s no surprise to see that **97.1%** of mobile pages have a document title.

Even though [Google usually displays the first 50-60 characters of a page title](https://moz.com/learn/seo/title-tag) within a SERP, the median length of the <title> tag was only **21 characters** for mobile pages and **20 characters** for desktop pages. Even the 75th percentile is still below the cutoff length. This suggests that some SEOs and content writers aren’t making the most of the space allocated to them by search engines for describing their homepages in the SERPs.

<graph histogram length <title> Source: 10.07b, column C, desktop & mobile>

#### Meta Descriptions

Compared to the <title> tag, fewer pages were detected to have a meta description, as only **64.02%** of mobile homepages have a meta description. Considering that Google often rewrites meta descriptions in the SERPs in response to the searcher's query, perhaps website owners place less importance on including a meta description at all.

The median meta description length was also lower than the [recommended length of 155-160 characters](https://moz.com/learn/seo/meta-description), with desktop pages having descriptions of **123 characters**. Interestingly, meta descriptions were consistently longer on mobile than on desktop, despite mobile SERPs traditionally having a shorter pixel limit. This limit has only been extended recently, so perhaps more website owners have been testing the impact of having longer, more descriptive meta descriptions for mobile results.

<graph histogram length <meta description> Source: 10.07c, column C, desktop & mobile>

#### Image Alt Tags

Considering the importance of alt text for SEO, screen readers and accessibility, it is far from ideal to see that only **46.71%** of mobile pages use alt attributes on all of their images. This means that there are still improvements to be made with regard to making images across the web more accessible to users and understandable for search engines.

Learn more about this in the [Accessibility chapter] <chapter link placeholder a11y> of the Web Almanac.

### Indexability

To show a page's content to users in the SERPs, search engine crawlers must first be permitted to access and index that page. Some of the factors that impact a search engine's ability to crawl and index pages are:

-Status codes
-Noindex tags
-Canonical tags
-The robots.txt file

#### Status Codes

It is recommended to maintain a 200 status code for any important pages that you want search engines to index. The majority of pages tested were available for search engines to access, with **87.03%** of initial HTML requests on desktop returning a 200 status code. The results were slightly lower for mobile pages, with only **82.95%** of pages returning a 200 status code.

The next most commonly found status code on mobile was 302, a temporary redirect, which was found on **10.45%** of mobile pages. This was higher than on desktop, with only **6.71%** desktop homepages returning a 302 status code. This could be due to the fact that the [mobile homepages were alternates](https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls) to an equivalent desktop page, such as on non-responsive sites that have separate versions of the website for each device.

<Note: Our results didn't include 4xx or 5xx status codes.>

#### Noindex

A noindex tag can be served in the HTML <head> or in the HTTP header as an X-robots tag. A noindex tag basically tells a search engine not to include that page in its SERPs, but the page will still be accessible for users when they are navigating through the website. Noindex tags are usually added to duplicate versions of pages that serve the same content, or low quality pages that provide no value to users coming to a website from organic search, such as filtered or faceted pages or internal search pages.

**96.93%** of mobile pages passed the [Lighthouse indexing audit](https://developers.google.com/web/tools/lighthouse/audits/indexing), meaning that these pages didn’t contain a noindex tag in the <head> or in the HTTP header. However, this means that **3.07%** of mobile homepages _did_ have a noindex tag, which is cause for concern, meaning that Google was prevented from indexing these pages.

<rick: add technical note about CRuX & HTPP Archive datasets skewing this metric>

#### Canonicalization

Canonical tags are used to specify duplicate pages and their preferred alternates, so that search engines can consolidate authority which might be spread across multiple pages within the group onto one main page for improved rankings.

**48.34%** of mobile homepages were [detected](https://developers.google.com/web/tools/lighthouse/audits/canonical) to have a canonical tag. Self-referencing canonical tags aren't essential, and canonical tags are usually required for duplicate pages. Homepages are rarely duplicated anywhere else across the site so seeing that less than half of pages have a canonical tag isn't surprising.

#### Robots.txt

One of the most effective methods for controlling search engine crawling is the [robots.txt file](https://www.deepcrawl.com/knowledge/technical-seo-library/robots-txt/). This is a file that sits on the root domain of a website and specifies which URLs and URL paths should be disallowed from being crawled by search engines.

It was interesting to observe that only **72.16%** of mobile sites have a valid robots.txt, [according to Lighthouse](https://developers.google.com/web/tools/lighthouse/audits/robots). The key we found issues are split between **22%** of sites having no robots.txt file at all, and **~6%** serving an invalid robots.txt file, and thus failing the audit. While there are many valid reasons to not have a robots.txt file, such as having a small website that doesn't struggle with [crawl budget issues](https://webmasters.googleblog.com/2017/01/what-crawl-budget-means-for-googlebot.html), having an invalid robots.txt is cause for concern.

### Linking

One of the most important attributes of a webpage is links. Links help search engines discover new, relevant pages to add to their index and navigate through websites. **96%** of the webpages in our data contain at least one internal link, and **93%** contain at least one external link to another domain. The small minority of pages that don't have any internal or external links will be missing out on the immense value that links pass through to target pages.

The number of internal and external links included on desktop pages were consistently higher than the number found on mobile pages. Often a limited space on a smaller viewport causes fewer links to be included in the design of a mobile page compared to desktop.

It's important to bear in mind that fewer internal links on the mobile version of a page [might cause an issue](https://moz.com/blog/internal-linking-mobile-first-crawl-paths) for your website. With [mobile-first indexing](https://www.deepcrawl.com/knowledge/white-papers/mobile-first-index-guide/) - which for new websites is the default for Google - if a page is only linked from the desktop version and not present on the mobile version, search engines will have a much harder time discovering and ranking it.

<graph histogram count of links by type Source: 10.10, column C desktop only>

<graph histogram count of links by type Source: 10.10, column D, E, desktop only>

The median desktop page includes **70** internal (same-site) links, whereas the median mobile page has **60** internal links. The median number of external links per page followed a similar trend, with desktop pages including **10** external links, and mobile pages including **8**.

Anchor links, which link to a certain scroll position on the same page, are not very popular. Over **65%** of homepages have no page anchor and the data’s median count is **0**. This is probably due to the fact that homepages don't usually contain any long-form content.

There is good news from our analysis of the descriptive link text metric. **89.94%** of mobile pages pass the descriptive link text [Lighthouse audit](https://developers.google.com/web/tools/lighthouse/audits/descriptive-link-text). This means that these pages don’t have generic ‘click here’, ‘go’, ‘here’ or ‘learn more’ links, but use more meaningful link text which helps users and search engines better understand the context of pages and how they connect with one another.

## Advanced

Having descriptive, useful content on a page that isn't being blocked from search engines with a noindex tag or robots.txt directive isn't enough for a website to succeed in organic search. Those are just the basics. There is a lot more than can be done to enhance the performance of a website and its appearance in SERPs.

Some of the more technically complex aspects that have been gaining importance in successfully indexing and ranking websites include _speed_, _structured data_, _internationalization_, _security_ and _mobile usability_.

### Speed

Mobile loading speed was first [announced as a ranking factor](https://webmasters.googleblog.com/2018/01/using-page-speed-in-mobile-search.html) by Google in 2018. Speed isn't a new focus for Google though. Back in 2010 it was [revealed that speed had been introduced as a ranking signal](https://webmasters.googleblog.com/2010/04/using-site-speed-in-web-search-ranking.html).

A fast-loading website is also crucial for a good user experience. Users that have to wait even a few seconds for a site to load, have the tendency to bounce and try another result from one of your competitors in the SERPs that loads quickly and meets their expectations of website performance.

The metrics we used for our analysis of load speed across the web is based on the Chrome User Experience Report (CrUX), which collects data from real-world Chrome users. This data shows that an astonishing **63.47%** of the web is labelled as **slow**. Split by device, this picture is even bleaker for tablet (**82%**) and mobile (**77,61%**). In the context of our results, slow is defined as First Contentful Paint taking over 2500ms and First Input Delay measuring over 250ms.

<graph data 10.15b: CruX image similar to [IMG](https://developers.google.com/web/updates/images/2018/08/crux-dash-fcp.png) per device + speed label>

Although the numbers are bleak for the speed of the web, the good news is that SEO experts and tools have been focusing more and more on the technical challenges of speeding up websites. This is something that you will have learned more about in the Performance chapter.

<chapter link placeholder performance>.

### Structured data

Structured data allows website owners to add additional semantic data to their web pages, by adding [JSON-LD](https://en.wikipedia.org/wiki/JSON-LD) snippets or [Microdata](https://developer.mozilla.org/en-US/docs/Web/HTML/Microdata), for example. Search engines parse this data to better understand these pages and sometimes use the markup to display additional relevant information in the search results. The most commonly found types of structured data are [reviews](https://developers.google.com/search/docs/data-types/review-snippet), [products](https://developers.google.com/search/docs/data-types/product), [businesses](https://developers.google.com/search/docs/data-types/local-business), [movies](https://developers.google.com/search/docs/data-types/movie), and [more](https://developers.google.com/search/docs/guides/search-gallery).

The [extra visibility](https://developers.google.com/search/docs/guides/enhance-site) that structured data can provide for websites is interesting for site owners, given that it can help to create more opportunities for traffic. For example, the relatively new [FAQ schema](https://developers.google.com/search/docs/data-types/faqpage) will double the size of your snippet and the real estate of your site in the SERP.

During our research, we found that only **14.67%** of sites have structured data eligible for rich results on mobile. Interestingly, desktop sites are slightly lower at **12.46%**. This suggests that there is a lot more that website owners can be doing to optimize the way their homepages are appearing in search.

Among the sites with structured data markup, the five most prevalent types are:

1. WebSite (16.02%)
2. SearchAction (14.35%)
3. Organization (12.89%)
4. WebPage (11.58%)
5. ImageObject (5.35%)

Interestingly, one of the most popular data types that triggers a search engine feature is the SearchAction, which powers the [sitelinks searchbox](https://developers.google.com/search/docs/data-types/sitelinks-searchbox).

The top 5 markup types all lead to more visibility in Google’s search results, which might be the fuel for more widespread adoption of these types of structured data.

Seeing as we only looked at homepages within this analysis, the results might look very different if we were to consider interior pages, too.

Review stars are only found on **1.09%** of the web’s homepages (via [AggregateRating](https://schema.org/AggregateRating)).

Also, the newly introduced [QAPage](https://schema.org/QAPage) appeared only in **48** instances, and the [FAQPage](https://schema.org/FAQPage) at a slightly higher rate of **218** times. These last two counts are expected to increase in the future as we run more crawls and dive deeper into almanac analysis.

### Internationalization

Internationalization is one of the most complex aspects of SEO, even [according to some Google search employees](https://twitter.com/JohnMu/status/965507331369984002). Internationalization in SEO focuses on serving the right content from a website with multiple language or country versions, and making sure that content is being targeted towards the specific language and / or location of the user.

While **38.4%** (**33.79%** on mobile) of the sites have the HTML lang attribute set to English, only **7.43%** (**6.79%** on mobile) of the sites also contain an hreflang link to another language version. This suggests that the vast majority of websites that we analyzed don't offer separate versions of their homepage that would require language targeting. Unless these separate versions do exist, but haven't been configured correctly...

<graph 10.04b - [do we want to chart this data, e.g. what does it really mean for SEO?]>

<include a chart of the languages and country combinations found, SEOs will want to see this breakdown>

Next to English, the most common languages are French, Spanish and German. These are followed by languages targeted towards specific geographics like English for Americans (en-us) or more obscure combinations like Spanish for the Irish (es-ie).

The analysis did not check for correct implementation, such as whether or not the different language versions properly link to each other, for example. However, from looking at the low adoption of [having an x-default version as is recommended](https://www.google.com/url?q=https://support.google.com/webmasters/answer/189077?hl%3Den&sa=D&ust=1570627963630000&usg=AFQjCNFwzwglsbysT9au_I-7ZQkwa-QvrA) (only **3.77%** on desktop and **1.3%** on mobile), this is an indicator that this element is complex and not always easy to get right.

### SPA Crawlability

Single-page-apps (SPAs) like React and Vue come their own SEO complexity, especially those that use a hash-based navigation which makes it hard for search engines to crawl and index a website. For example, Google had an "AJAX crawling scheme" workaround that turned out to be complex for search engines as well as developers, so it was [deprecated in 2015](https://webmasters.googleblog.com/2015/10/deprecating-our-ajax-crawling-scheme.html).

The number of SPAs that were tested had a relatively low number of links served via hash URLs, with **13.08%** of React mobile pages using hash URLs for navigation, **8.15%** of mobile Vue.js pages using them, and **2.37%** of mobile Angular pages using them. These results were very similar for desktop pages too. This is positive to see from an SEO perspective, considering the impact that hash URLs can have on content discovery.

The higher number of hash URLs in React pages is surprising - especially in contrast to the lower number of hash URLs found on Angular pages. Both frameworks promote the adoption of routing packages where the [History API](https://developer.mozilla.org/en-US/docs/Web/API/History) is the default for links, instead of relying on hash URLs. Vue is [considering moving to using the History API as the default](https://github.com/vuejs/rfcs/pull/40) as well in version 3 of their vue-router package.

### AMP

AMP (Accelerated Mobile Pages) was first introduced in 2015 by Google as an open source HTML framework. It provides components and infrastructure for websites to provide a faster experience for users on mobile, by using optimisations such as caching, lazy-loading and optimised images. Notably Google adopted this for their search engine, where AMP pages are also served from their own CDN. This feature later became a standards proposal under the name [Signed HTTP Exchanges](https://wicg.github.io/webpackage/draft-yasskin-http-origin-signed-responses.html).

Despite this, only **0.62%** of mobile homepages contain a link to an AMP version. Given the visibility this project has had, this suggests that it has had a relatively low adoption. However, AMP can be more useful for serving article pages, so our homepage-focused analysis won't reflect adoption across other page types.

### Security

A strong online shift in recent years has been for the web to move to HTTPS by default. HTTPS prevents website traffic from being intercepted on public WIFI networks, for example, where user input data is then transmitted unsecurely. Google have been pushing for sites to adopt HTTPS, and even made [HTTPS is a ranking signal](https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html). Chrome also supported the move to secure pages by labelling non-HTTPS pages as ‘[not secure](https://www.blog.google/products/chrome/milestone-chrome-security-marking-http-not-secure/)’ in the browser.

For more information and guidance from Google on the importance of HTTPS and how to adopt it, please see [Why HTTPS Matters](https://developers.google.com/web/fundamentals/security/encrypt-in-transit/why-https).

We found that **67.06%** of websites on desktop are now served over HTTPS. Just under half of websites still haven't migrated to HTTPS and are serving non-secure pages to their users. This is a significant number. Migrations can be hard work, so this could be a reason why the adoption rate isn't higher, but an HTTPS migration usually require an SSL certificate and a simple change to the .htaccess file. There's no real reason not to switch to HTTPS.

The Google [Transparancy Report](https://transparencyreport.google.com/https/overview) reports a **90% adoption** of HTTPS for the top 100 non-Google domains (representing 25% of all website traffic worldwide). The difference between this number and ours could be explained by the fact that relatively smaller sites are adopting HTTPS on a slower rate.

## Conclusion

Through our analysis, we observed that the majority of websites are getting the fundamentals right, in that their homepages are crawlable, indexable and include the key content required to rank in Google’s SERPs. Not every person who owns a website will be aware of SEO at all, let alone best practice guidelines, so it is promising to see that so many sites have got the basics covered.

However, more sites are missing the mark than expected when it comes to some of the more advanced aspects of SEO and accessibility. Site speed is one of these factors that many websites are struggling with, especially on mobile. This is a significant problem as speed is one of the biggest contributors to UX, which is something that can impact rankings. The number of websites that aren't yet served over HTTPS was also problematic to see, considering the importance of security and keeping user data safe.

There is a lot more that we can all be doing to learn about SEO best practice and industry developments. This is essential due to the evolving nature of the search industry and the rate at which changes happen. Search engines make thousands of improvements to their algorithms each year, and we need to keep up if we want our websites to reach more visitors in organic search.
