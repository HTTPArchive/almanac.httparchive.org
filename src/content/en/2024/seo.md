---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: SEO chapter of the 2024 Web Almanac covering crawlability, indexability, page experience, on-page SEO, links, AMP, internationalization, and more.
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [fellowhuman1101, mikaelaraujo, dwsmart]
reviewers: []
editors: [MichaelLewittes]
analysts: [henryp25, cnichols013]
translators: []
results: https://docs.google.com/spreadsheets/d/1lAQKcOF7l6xz9v7yvnI9I1F8yiSqcz3Xx6u-5ady1DQ/
fellowhuman1101_bio: Jamie Indigo isn't a robot, but speaks bot. As director of technical SEO at <a hreflang="en" href="https://www.coxautoinc.com/">Cox Automotive</a>, they study how search engines crawl, render, and index the web. Jamie loves to tame wild JavaScript and optimize rendering strategies. When not working, they like horror movies, graphic novels, and terrorizing lawful good paladins in Dungeons & Dragons.
dwsmart_bio: Dave Smart is a developer and technical search engine consultant at <a hreflang="en" href="https://tamethebots.com">Tame the Bots</a>. They love building tools and experimenting with the modern web, and can often be found at the front in a gig or two.
featured_quote:
featured_stat_1:
featured_stat_label_1:
featured_stat_2:
featured_stat_label_2:
featured_stat_3:
featured_stat_label_3:
---
 
## Introduction

Search Engine Optimization (SEO) is the practice of improving a website's technical setup, content, and authority to boost its visibility in search results. It helps businesses attract organic traffic by aligning website content with user search intent.

The Web Almanac's SEO chapter focuses on the critical elements and configurations influencing a website's organic search visibility. The primary goal is to provide actionable insights that empower website owners to enhance their sites' crawlability, indexability, and overall search engine rankings. By conducting a comprehensive analysis of prevalent SEO factors, we hope that websites can uncover the most impactful strategies and techniques for optimizing a website's presence in search results. 

This chapter combines data from <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>, [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/), [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report), and custom metrics to document the state of SEO and its context in the digital landscape.


## Crawlability and indexability 

For a page to appear in a search engine results page (SERP), the page must first be crawled and indexed. This process is a critical foundation of SEO.

Search engines may discover pages in several ways, including external links, sitemaps, or by being directly submitted to the search engine using webmaster tools. In 2022, Bing shared that its crawler discovered nearly [70 billion new pages *daily*](https://x.com/patrickstox/status/1630582277057986560?s=20). During this year's antitrust suit against Google, it was revealed that its *index* is only around [400 billion documents](https://zyppy.com/seo/google-index-size/#:~:text=But%20recently%2C%20during%20testimony%20in,Google's%20index%20size%20in%202020.). That means far more pages are crawled than indexed.

This section addresses the state of the web, as it relates to how search engines crawl and index content, as well as the directives and signals SEOs can provide so that crawlers interact and retain versions of their content.

### Robots.txt

As search engines explore the web, they stop at the robots.txt file, which one can think of as a visitors' center for each site. The robots.txt file sits at the root of an origin and allows site owners to implement the [Robots Exclusion Protocol](https://en.wikipedia.org/wiki/Robots.txt). It’s designed to signal or instruct bots which URLs a search engine can or cannot crawl.

It is not a hard, technical directive. Rather, it's up to the bot to honor these instructions. Since the major search engines respect this protocol, it's relevant for our SEO analysis.

While the robot.txt file has been used since 1994 to control how a site is crawled, it only became formally standardized with the Internet Engineering Task Force in September 2022\. The formalization of the [RFC 9390](https://datatracker.ietf.org/doc/html/rfc9309) protocol in 2022 occurred after the previous year’s edition of the Web Almanac was published and led to stricter enforcement of technical standards. 

For the measurements for this year’s Web Almanac, we ran Lighthouse, an open-source, automated tool for improving the quality of web pages in tandem with our own data collection. These audits showed that 8.43% of desktop pages and 7.40% of mobile pages failed the tool's check for [valid robots.txt files](https://developer.chrome.com/docs/lighthouse/seo/invalid-robots-txt).

#### Robots.txt status codes

{{ figure_markup(
  image="robots-txt-status-codes.png",
  caption="robots.txt Status Codes",
  description="Bar chart showing percent of pages with a valid robots.txt file. A total of 83.9% of mobile sites returned a 200 status code, while 14.1% returned a 404. No response was received for 1.5% of mobile requests to the file. Just 0.3% and 0.1% of mobile requests received a forbidden (403) or server error response. Response distribution on desktop behaved similarly with 83.5% returning a 200 status code, while 14.3% returned a 404. No response was received for 1.7% of mobile requests to the file. Just 0.3%, and 0.1% of mobile requests received a forbidden (403) or server error response.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1570550482&format=interactive",
  sheets_gid="1390313757",
  sql_file="robots-txt-status-codes-2024.sql"
  )
}}

Since 2022, there has been a nominal increase in the percentage of sites whose robots.txt files return a 200 status code. In 2024, 83.9% of robots.txt files for mobile sites returned a 200 status code, while 83.5% of desktop sites returned a 200 status code. That’s up from 2022 when mobile and desktop sites returned 200 status codes of 82.4% and desktop 81.5%, respectively.

This small increase signals that, despite the standard’s relatively recent formalization, its previous three-decade history had already led to wide-scale adoption.

Additionally, the difference between mobile and desktop sites returning a 200 status code has now narrowed to just a 0.4% difference, compared to the 1.1% gap in 2022. While one cannot draw a definitive conclusion for the percentage decrease, one possible explanation can be the greater adoption of mobile responsive design principles versus the previous prevalence of separate mobile sites.

HTTP status codes significantly impact how a robots.txt file functions. When the file returns a 4XX response code, it is assumed there are no crawling restrictions. Awareness of this behavior has continued to increase as we see a continuing trend of fewer 404 responses to robots.txt files. 

In 2022, 15.8% of mobile sites’ robots.txt files returned a 404 status code and 16.5% of desktop sites. Now in 2024, it’s down to 14.1% for mobile site visits and 14.3% for desktop. The drops are fairly consistent with the growth of robots.txt returning 200 status codes, suggesting more sites have decided to implement a robots.txt file.

Only 1.7% of mobile and 1.5% of desktop crawls in 2024 received no response. Google interprets these as an error caused by the server.

For 0.1% of both mobile and desktop requests tested, we received an error code in the 5xx range. While these error codes represent a tiny percentage, it’s worth noting that for Google this would mean the search engine would consider the whole site blocked from crawling for 30 days. After 30 days, the search engine would revert to using a previously fetched version of the file. If a prior cached version isn't available, it is assumed the search engine crawled all of the content hosted on the site.

The nominal error rate suggests that simple text files in most cases -- or handled automatically by many popular CMS systems that provide a robots.txt directive -- are not a large challenge.

_Note_: The above data does not indicate whether the robots.txt files returning a 200 status code are beneficial for a site or if they allow or block aspects that they should not.

#### Robots.txt size

{{ figure_markup(
  image="robots-txt-size.png",
  caption="robots.txt Size",
  description="A distribution chart showing differences in robots.txt sizes in 100 kilobyte increments. For mobile, 96.47% are in 0-100 KB range, 0.31% in 100-200 KB, 0.10% in 200-300 KB, 0.06% in 300-400 KB, 0.03% in 400-500 KB, 0.06% are larger than 500 KB, and finally 1.89% are missing. For desktop, 96.24% are in 0-100 KB range, 0.30% in 100-200 KB, 0.09% in 200-300 KB, 0.05% in 300-400 KB, 0.02% in 400-500 KB, 0.05% are larger than 500 KB, and finally 2.28% are missing.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1259588862&format=interactive",
  sheets_gid="1616323575",
  sql_file="robots-txt-size-2024.sql"
  )
}}

The vast majority of robots.txt files -- 96.47% of mobile crawls and 96.24% of desktop crawls -- were no larger than 100KB.
 
According to RFC 9309 standards, crawlers should limit the size of robots.txt files they look at, and the parsing limit must be at least [500 kiB](https://www.rfc-editor.org/rfc/rfc9309.html#name-limit). A robots.txt file under that size should be fully parsed. Google, for example, [enforces the max limit at 500 kiB](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#file-format). Only a tiny number of sites (just 0.06%) had robots.txt files over this limit. Directives found beyond that limit are ignored by the search engine.

#### Robots.txt user-agent usage

{{ figure_markup(
  image="robots-txt-user-agent-usage.png",
  caption="Robots.txt user-agent usage",
  description="A bar chart showing the most common user agent targets in robots.txt files. For desktop * is 76.6%, AdsBot-Google is 9.1%, AhrefsBot is 8.6%, MJ12Bot is 6.7%, Googlebot is 5.9%, AdsBot-Google-Mobile is 4.6%, Dotbot is 4.4%, Nutch is 4.5%, Pinterestbot is 4.1%, AhrefsSiteAudit is 4.0%, PetalBot is 3.4%, GPTBot is 2.9%, Mediapartners-Google is 2.3%, Bingbot is 2.6%, and lastly the CCBot is 2.7%. Mobile is consistent with desktop at 76.9%, 8.9%, 8.8%, 6.6%, 6.4%, 4.6%, 4.9%, 4.3%, 3.9%, 3.7%, 3.8%, 2.6%, 3.0%, 2.6%, and 2.4%, respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1672540926&format=interactive",
  sheets_gid="1705238622",
  sql_file="robots-txt-user-agent-usage-2024",
  width=600,
  height=594
  )
}}

##### The \* User Agent

A full 76.85% of robots.txt files encountered by the mobile crawl and 76.63% of those found in the desktop crawl specify rules for the catch-all user-agent of \*. This represents a small uptick over the data from 2022 in which it was 74.9% for desktop and 76.1% for mobile crawls. A possible explanation could be the slight overall increase in robots.txt availability.

The \* user-agent denotes the rules a crawler should follow unless there's another set of rules that specifically target the crawler's user-agent. There are notable exceptions that don't respect the \* user-agent, including Google's [Adsbot crawler](https://developers.google.com/search/docs/crawling-indexing/google-special-case-crawlers#adsbot-mobile-web). Other crawlers will try another common user-agent before falling back to \*, such as Apple's Applebot, which uses Googlebot’s rules if they are specified and Applebot if not specified. We recommend checking the support documentation for any crawlers you are targeting to ensure that behavior is as expected when relying on fallback.

##### Bingbot

Much like in 2022, Bingbot again was not in the top 10 most specified user-agents. Only 2.67% of mobile and 2.63% of desktop robots.txt files specified that user-agent, relegating it down to 14th place.

##### SEO Tools

The data shows there has been an increase in sites specifying rules for the popular SEO tools. AhrefsBot, for instance, has now been detected in 8.8% of mobile crawls, up from 5.3% in 2022. It has overtaken Majestic's MJ12Bot, which itself increased to 6.6% from 6.0% in 2022 and had previously been the second most popular specifically targeted user-agent.

##### AI Crawlers

{{ figure_markup(
  image="robots-txt-ai-user-agents.png",
  caption="robots.txt AI User-agents",
  description="A bar chart showing the most common AI user agent targets in robots.txt files. For desktop, GPTBot is 2.93%, CCBot is 2.71%, Google-Extended is 2.53%, Anthropic-Ai is 2.05%, ChatGPT-User is 2.00%, Claude-Web is 1.86%, and PerplexityBot is 0.22%. The numbers for mobile are slightly slower than desktop at 2.56%, 2.41%, 2.20%,1.72%, 1.69%, 1.57%, and 0.22%, respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=802856810&format=interactive",
  sheets_gid="1705238622",
  sql_file="robots-txt-user-agent-usage-2024"
  )
}}

Over the past two years, large language models (LLMs) and other generative systems have gained traction in both awareness and usage. It appears people are increasingly specifying rules for the crawlers they use in order to gather data for training and other purposes.

Of these, GPTBot is the most commonly specified and found in 2.7% of mobile crawls. The next most common is CCBot, which is Common Crawl's agent [https://commoncrawl.org/ccbot](https://commoncrawl.org/ccbot). While CCBot isn't related only to AI, a number of popular vendors use or have used data gathered from this crawler to train their models.

In Summary

* The formalization of the robots.txt protocol in RFC 9309 has led to better adherence to technical standards.  
* Analysis shows an increase in successful robots.txt responses and a decrease in errors, indicating improved implementation.  
* Most robots.txt files are within the recommended size limit.  
* The \* user-agent remains dominant, but AI crawlers like GPTBot are on the rise.  
* These insights are valuable for understanding the current state of robots.txt usage and its implications for SEO.

### Robots directives

A [robots directive](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag) is a granular, page-specific approach to controlling how an individual HTML page should be indexed and served. Robots directives are similar to, but distinct from, robots.txt files since the former affect indexing and serving while robots.txt affects crawling. In order for directives to be followed, the crawler must be allowed to access the page. Directives on pages that are disallowed in a robots.txt file may not be read and followed.

#### Robots directive implementation

Robots directives tags are critical for curating which pages are available to return in search results and how they should be displayed. Robots directives may be implemented in two ways:

1. Placing a robots meta tag in the `<head>` of a page (i.e. `<meta name="robots" content="noindex">`)  
2. Placing the X-Robots-Tag HTTP header in the HTTP header response

{{ figure_markup(
  image="robots-directive-implementation.png",
  caption="Robots directive implementation",
  description="A bar chart showing the distribution of robots directives implementation methods. For desktop, 45.5% of pages use the meta tag, while 0.6% use the HTTP header. 0.4% use both. For mobile, 46/2% of pages use the meta tag, while 0.7% use the HTTP header. and 0.3% use both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=368535821&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

Either implementation method is valid and can be used in tandem. The meta tag implementation is the most widely adopted, representing 45.5% of desktop and 46.2% of mobile pages. The[X-robots HTTP header](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag#xrobotstag) is applied to fewer than 1% of pages. A small number of sites used both tags in tandem. They represented 0.4% of desktop pages and 0.3% of mobile pages..  

In 2024:

* 0.4% of desktop and 0.3% of mobile pages saw the directives' values changed by rendering.  
* Secondary pages were more likely to have robots directives. And 48% of secondary pages contained a meta robots tag compared to 43.9% of homepages.   
* Rendering was more likely to change the robots directive of a homepage (0.4%) than that of a secondary page (0.3%).

#### Robots directive rules

In 2024, there were [24 valid values](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag#directives) \-- known as rules \-- that could be asserted in a directive to control the indexing and serving of a snippet. Multiple rules can be combined via separate meta tags or combined in a comma separated-list for both meta tags and `X-robots` HTTP header tags. 

For our study of directive rules, we relied on the rendered HTML.  

{{ figure_markup(
  image="robots-directive-rules.png",
  caption="Robots directive rules",
  description="A bar chart comparing the use of robots directive rules as seen in the rendered HTML of desktop and mobile pages. For desktop, 54.7% used `follow`, 53.4% used `index`, 4.7% used `nonindex`, 2.5% used `nofollow`, 1.6% used `max-image-preview`, 1.6% used `max-snippet`, 1.2% used `max-video-preview`, 0.5% used `noarchive`, 0.2% used `nosnippet`, 0.01% used `notranslate`, and 0.09% used `noimageindex`. Mobile rates were similar at 56.0%, 53.9%, 3.9%, 2.2%, 1.8%, 1.3%, 1.1%, 0.6%, 0.3%, 0.10%, and 0.01% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=2136589874&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql",
  width=600,
  height=690
  )
}}

The most prominent rules in 2024 were `follow` (54.7% desktop; 56.0% mobile), `index` (53.4%; 53.9%), `noindex (4.7%; 3.9%), and `nofollow` (2.5%; 2.2%).

The `name` value of the robots `meta` tag specifies to which crawler(s) the rule applies. For example,` meta name="robots"` applies to all bots whereas `meta name="googlebot"` applies to only to Google. To analyze the application of name attributes, we looked at rates which values were stated for the `follow` tag, as it is the most prevalent robots `meta` rule.

{{ figure_markup(
  image="name-attributes-in-follow-robots-meta-tag.png",
  caption="Name attributes in `follow` robots meta tag.",
  description="A bar chart comparing the most desktop and mobile name attributes in the `follow` robots `meta` tag. On mobile, the attribute named Googlebot-News on 62.3%, msnbot on 64.3%, robots on 60.2%, Googlebot on 50.9%, and bingbot on 34.6% of applicable pages.  Desktop was similar at 65.5%, 61.8%, 60.9%, 47.9%, and 18.2% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1651546987&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql"
  )
}}

The five most named crawlers in robots directives were the generic robots value, googlebot, Googlebot-News, msnbot, and bingbot. The name attributes used in `follow` robots `meta` tag show that sites with the tags are apt to tailor the rules to specific bots. The slight variance by devices is disrupted for bingbot who saw significantly more `follow` directives on mobile pages (34.6%) compared to desktop (18.2%).

{{ figure_markup(
  image="robots-directive-rules-by-name.png",
  caption="Robots rules by name attribute values.",
  description="A bar chart comparing robots directive rules by crawler named in robots directives for mobile pages.  The named bots are MSNBot, Googlebot-News, robots, Googlebot, and Bingbot.  The values were applied as follows: `follow`: 64.3%, 62.3%, ,  60.2%, 50.9%, and  34.6%. Index: 55.3%, 63.2%, 59%, 51.6% 33.7%. `index`: 0.5%, 21.2%, 4.6%, 3.9%, and 12.8%. `nofollow`: 0.5%, 6.1%, 1.8%, 2.2%, and 5.4%. `nosnippet`: 0.0%, 12.0%, 0.1%, 1.4%, and 0.7%. `max-snippet`: 0.0%, 0.4%, 39.9%, 2.3%, and 16.3%. `max-video-preview`: 0.0%, 0.1%, 39.9%, 2.1%, and 16.1%. `max-image-preview`: 0.0%, 1.2%, 69.2%, 2.3%, and 16.5%. `noarchive`: 0.4%, 0.0%, 0.8%, 18.7%, and 35.9%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=240042110&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql",
  width=600,
  height=548
  )
}}

When robots directive rules are viewed by their name attributes, we can see varied application rates whiching that the curation of directives by botname is readily adopted by SEOs.
 
Noteworthy takeaways from analysis of rules by bot name include:
The `noarchve` rule was applied overwhelmingly to bingbot at 35.9%.  This is likely due to the tags ability to [keep content out Bing chat answers](https://blogs.bing.com/webmaster/september-2023/Announcing-new-options-for-webmasters-to-control-usage-of-their-content-in-Bing-Chat).
`​​max-snippet`, `max-video-preview`, and  `max-image-preview` are prominently stated for all robots at rates of 39.9%	, 39.9%, and 69.2% respectively.
Googlebot-News was the most named for `index` (63.2%) and `nosnippet` (12.0%)
MSNBot was the least likely to be given a `noindex` directive (0.5%). In comparison, the most likely was Googlebot-News at 21.2%.
0.01% of sites provided a `noindex` rule but used the invalid crawler name: google.  Google has two valid crawler names for recognized in robots `meta` tags: googlebot and Googlebot-News.

### `IndexIfEmbedded` tag
In January 2022, Google introduced a [new robots tag](https://developers.google.com/search/blog/2022/01/robots-meta-tag-indexifembedded), `indexifembedded`. The tag is placed in the HTTP header and offers indexing control for resources used to build a page. A common use case for this tag is for controlling indexation when content is in an iframe on a page, even when a noindex tag has been applied.  

The presence of an `<iframe>` provides a baseline for cases where the `indexifembedded` robots directive might be applicable. In 2024, 7.6% of mobile pages contained an `<iframe>` element. This is a noteworthy 85% increase from 2022's rate of 4.1%.

{{ figure_markup(
  image="pages-with-iframe.png",
  caption="Mobile pages with `<iframe>`.",
  description="A pie chart showing 7.6% of mobile pages utilized an iframe within the analyzed content, and 92.4% did not use an iframe.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=8221104&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql"
  )
}}

Nearly all sites employing iframes also use the `indexifembedded` directive. When iframe headers from mobile pages were examined, 99.9% used `noindex` directives and 97.8% used `indexifembedded`.

{{ figure_markup(
  image="indexifembedded-user-agents.png",
  caption="Indexifembedded user agents.",
  description="A bar chart showing the majority of indexifembedded implementations use a robots header at 98.1% and target the Googlebot user agent.The generic robots user agent was stated 0.2%. The other three user agents (Googlebot-News, and Bingbot) show 0% usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1844266050&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql"
  )
}}

As we saw in 2022, `indexifembedded` directives continued to be almost exclusively used for Googlebot. Robots header use decreased slightly in 2022 from 98.3% to 97.2%, while adoption of the robots tag increased significantly from 66.3% to 98.2%.

### Invalid head elements