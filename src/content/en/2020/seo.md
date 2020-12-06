---
part_number: II
chapter_number: 7
title: SEO
description: SEO chapter of the 2020 Web Almanac covering content, meta tags, indexability, linking, speed, structured data, internationalization, SPAs, AMP and security.
authors: [aleyda, ipullrank, fellowhuman1101]
reviewers: [natedame, catalinred, dsottimano, dwsmart, en3r0, ibnesayeed, bazzadp]
analysts: [Tiggerito, antoineeripret]
translators: []
aleyda_bio: SEO consultant, author, speaker and entrepreneur. Founder of <a href="https://www.orainti.com/">Orainti</a> (a boutique SEO consultancy working with some of the top Web properties and brands, from SaaS to marketplaces) and co-founder of <a href="https://remoters.net/">Remoters.net</a> (a free remote work hub, featuring remote jobs, tools, events, guides, and more to facilitate remote work). Aleyda enjoys sharing about SEO through her <a href="https://www.aleydasolis.com/en/blog/">blog</a>, the <a href="https://www.aleydasolis.com/en/seo-tips/">#SEOFOMO newsletter</a>, the <a href="https://www.aleydasolis.com/en/crawling-mondays-videos/">Crawling Mondays</a> video and podcast series and over <a href="https://twitter.com/aleyda">Twitter</a>.
ipullrank_bio: An artist and a technologist, all rolled into one, Michael King is the founder of enterprise digital marketing agency, <a href="https://ipullrank.com">iPullRank</a> and founder of Natural Language Generation app <a href="https://www.copyscience.io">CopyScience</a>. Effortlessly leaning on his background as an independent hip-hop musician, Mr. King is a compelling content creator and an award-winning dynamic speaker who is called upon to contribute to technology and marketing conferences and blogs all over the world. You can find Mike talking trash on <a href="https://twitter.com/ipullrank">Twitter</a>
fellowhuman1101_bio: 100% human & totally not a robot, Jamie Indigo untangles technologies to help humans access useful information and businesses provide valuable digital experiences. She founded <a href="https://not-a-robot.com">Not a Robot</a> to consult with a focus on the human aspects of technical SEO including ethics & inclusion in technology and the search industry.  She can found be learning in public on <a href="https://twitter.com/Jammer_Volts">Twitter</a>.
discuss: 2043
results: https://docs.google.com/spreadsheets/d/1ram47FshAjzvbQVJbAQPgxZN7PPOPCKIK67VJZCo92c/
queries: 07_SEO
featured_quote: Despite the growing use of mobile devices and Google's move to a Mobile first index, non-trivial disparities were found across mobile vs. desktop pages, like the one between mobile and desktop links.
featured_stat_1: 10.84%
featured_stat_label_1: Mobile pages are not including the viewport tag
featured_stat_2: 19.96%
featured_stat_label_2: Mobile websites scored 'Good' Core Web Vitals
featured_stat_3: 11.5%
featured_stat_label_3: More words are displayed in the rendered than the raw HTML of the median mobile site
unedited: true
---

## Introduction

Search Engine Optimization (SEO) is the practice of optimizing websites' technical configuration, content relevance, and link popularity to make their information easily findable and more relevant to fulfill users' search needs. As a consequence, websites improve their visibility in search engines' results for relevant user queries regarding their content and business, growing their traffic, conversions, and profits.

Despite its complex multidisciplinary nature, in recent years SEO has evolved to become one of the most popular digital marketing strategies and channels.

{{ figure_markup(
  image="seo-google-trends.png",
  caption="Google Trends comparison of SEO versus pay-per-click and social media marketing.",
  description="Screenshot from Google Trends showing the change in time for three three digital marketing related terms: Search Engine Optimization starts at 25% but shows an increasing importance over time to 75% now. Pay-per-click similarly starts at 25% but started falling in 2009 and looks to be less than 10% now. Social-media marketing starts very small (approximately 5%) and shows some slight growth over time ending up slightly above pay-per-click around the 10% mark.",
  width=1600,
  height=844
  )
}}

The goal of the Web Almanac's SEO chapter is to identify and assess main elements and configurations that play a role in a website's organic search optimization. By identifying these elements, we hope that websites can leverage our findings to improve their ability to be crawled, indexed, and ranked by search engines. In this chapter, we provide a snapshot of their status in 2020 and a summary of what has changed [since 2019](../2019/seo).

It is important to note that this chapter is based on analysis from [Lighthouse](https://developers.google.com/web/tools/lighthouse/), the [Chrome UX Report](https://developers.google.com/web/tools/chrome-user-experience-report), as well as raw and rendered HTML elements from the [HTTP Archive](https://httparchive.org/) crawl. In the case of the HTTP Archive and Lighthouse, it is limited to the data identified from websites' home pages only, not site-wide crawls. We have taken this into consideration when doing assessments. Keeping this distinction in mind is important when drawing conclusions from our results. You can learn more about it on our [Methodology](./methodology) page.

Let's go through this year's organic search optimization main findings.

## Fundamentals

This section features the optimization-related findings of the web configurations and elements that make up the foundation for search engines to correctly crawl, index, and rank websites to provide users the best results for their queries.

### Crawlability and indexability

Search engines use web crawlers (also called spiders) to discover new or updated content from websites, browsing the web by following links between pages. Crawling is the process of looking for new or updated web content (whether web pages, images, videos, etc.).

Search crawlers discover content by following links between URLs, as well as using additional sources that website owners can provide, like the generation of XML sitemaps, which are lists of URLs that a website's owner wants search engines to index, or through direct crawl requests via search engines tools, like Google's Search Console.

Once search engines access web content they need to _render_—similar to what web browsers do—and index it. Search engines will then analyze and catalog the identified information, trying to understand it as users do, to ultimately store it in its _index_, or web database.

When users enter a query, search engines search their index to find the best content to display on the search results pages to answer their queries, using a variety of factors to determine which pages are shown before others.

For websites looking to optimize their visibility in search results, it is important to follow certain crawlability and indexability best practices: correctly configuring `robots.txt`, robots `meta` tags, `X-Robots-Tag` HTTP headers, and canonical tags, among others. These best practices help search engines in accessing web content more easily and indexing them more accurately. A thorough analysis of these configurations is provided in the following sections.

#### `robots.txt`

Located at the root of a site, a `robots.txt` file is an effective tool in controlling which pages a search engine crawler should interact with, how quickly to crawl them, and what to do with the discovered content.

Google formally proposed making `robots.txt` an official internet standard in 2019. The [June 2020 draft](https://tools.ietf.org/html/draft-koster-rep-02) includes clear documentation on technical requirements for the `robots.txt` file. This has prompted more detailed information about how search engine crawlers should respond to non-standard content.

A `robots.txt` file must be plain text, encoded in UTF-8, and respond to requests with a 200 HTTP status code. A malformed `robots.txt`, a 4XX (client error) response, or more than five redirects are interpreted by search engine crawlers as a _full allow_, meaning all content may be crawled. A 5XX (server error) response is understood as a _full disallow_, meaning no content may be crawled. If the `robots.txt` is unreachable for more than 30 days, Google will use the last cached copy of it, as described in [their specifications](https://developers.google.com/search/reference/robots_txt#handling-http-result-codes).

Overall, 80.05% of sites responded to `robots.txt` with a 2XX response. Of the 9,640,246 requests revolving with a 2XX response, 25.09% of these `robots.txt` files were not recognized as valid. This has slightly improved over 2019, when it was found that [72.16% of mobile sites had a valid `robots.txt`](../2019/seo#robotstxt).

The data source for testing `robots.txt` validity, Lighthouse, introduced a [robots.txt audit](https://web.dev/robots-txt/) as part of the v6 update. This inclusion highlights that a successfully resolved request does not mean that the cornerstone file will be able to provide the necessary directives to web crawlers.

{# TODO(analysts, authors): Note that mobile and desktop can't be combined into "all devices" since they are overlapping datasets and most websites would be double-counted. When citing stats throughout the chapter, you need to specify which client you're referring to or include a disclaimer in the intro that stats are mobile unless specified otherwise. #}
<figure markdown>
Response Code | All Devices | Mobile | Desktop
-- | -- | -- | --
2XX | 80.05% | 80.46% | 79.59%
3XX | 0.01% | 0.01% | 0.01%
4XX | 18.12% | 17.67% | 18.64%
5XX | 0.14% | 0.15% | 0.12%
6XX | 0.00% | 0.00% | 0.00%
7XX | 0.00% | 0.15% | 0.12%

<figcaption>
  {{ figure_link(
    caption="<code>robots.txt</code> response codes.",
    sheets_gid="769973954",
    sql_file="pages_robots_txt_by_device_and_status.sql"
  ) }}
</figcaption>
</figure>

In addition to similar status code behavior, `Disallow` statement use was consistent between mobile and desktop versions of `robots.txt` files.

The most prevalent `User-agent` declaration statement was the wildcard, `User-agent: *`, appearing on 74.40% of mobile and 73.16% of desktop `robots.txt` requests. The second most prevalent declaration was `adsbot-google`, appearing in 5.63% of mobile and 5.68% of desktop `robots.txt` requests. Google AdsBot disregards wildcard statements and must be specifically named as the bot checks web page and app ad quality across devices.

The most frequently used directives focused on search engines and their paid marketing counterparts. SEO tools Ahref and Majestic were in the top five `Disallow` statements for both devices.

<figure>
  <table>
    <thead>
      <tr>
          <th></th>
          <th colspan="2">% of <code>robots.txt</code></th>
      </tr>
      <tr>
        <th><code>User-agent</code></th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">74.40%</td>
        <td class="numeric">73.16%</td>
      </tr>
      <tr>
        <td>adsbot-google</td>
        <td class="numeric">5.63%</td>
        <td class="numeric">5.68%</td>
      </tr>
      <tr>
        <td>mediapartners-google</td>
        <td class="numeric">5.55%</td>
        <td class="numeric">3.83%</td>
      </tr>
      <tr>
        <td>mj12bot</td>
        <td class="numeric">5.49%</td>
        <td class="numeric">5.30%</td>
      </tr>
      <tr>
        <td>ahrefsbot</td>
        <td class="numeric">4.80%</td>
        <td class="numeric">4.66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="<code>robots.txt User-agent</code> directives.",
      sheets_gid="243594173",
      sql_file="pages_robots_txt_by_device_and_useragent.sql"
    ) }}
  </figcaption>
</figure>

When analyzing the usage of the `Disallow` statement in `robots.txt` by using Lighthouse-powered data of over 6 million sites, it was found that 97.84% of them were completely crawlable, with only 1.05% using a `Disallow` statement.

An analysis of the `robots.txt` `Disallow` statement usage along the [meta robots](https://developers.google.com/search/reference/robots_meta_tag) _indexability_ directives was also done, finding 1.02% of the sites including a `Disallow` statement along indexable pages featuring a meta robots `index` directive, with only 0.03% of sites using the `Disallow` statement in `robots.txt` along _noindexed_ pages via the meta robots `noindex` directive.

This is notable as [Google documentation](https://developers.google.com/search/docs/advanced/robots/intro) states that site owners should not use `robots.txt` as a means to hide web pages from Google Search, as internal linking with descriptive text could result in the page being indexed without a crawler visiting the page. Instead, site owners should use other methods, like a `noindex` directive via meta robots.
{# TODO(authors): Tie this notable fact back to the data: is it notable because the disallow numbers are so low? What does that say about site owners following Google's guidance? #}

#### Meta robots

The `robots` meta tag and `X-Robots-Tag` HTTP header are an extension of the proposed [Robots Exclusion Protocol](https://webmasters.googleblog.com/2019/07/rep-id.html) (REP), which allows directives to be configured at a more granular level. Directive support varies by search engine as REP is not yet an official internet standard.

Meta tags were the dominant method of granular execution with 27.70% of desktop and 27.96% of mobile pages using the tag. `X-Robots-Tag` directives were found on 0.27% and 0.40% of desktop and mobile, respectively.

{# TODO(analysts): Should "X-Robots" be "X-Robots-Tag" here? #}
{{ figure_markup(
  image="seo-robots-directive-use.png",
  caption="Usage of meta robots and <code>X-Robots-Tag</code> directives.",
  description="Bar chart showing robots usage. Meta robots is 27.70% for desktop and 27.96% for mobile, X-Robots-Tag barely registers on the chart with a mere 0.27% of pages on desktop and 0.40% on mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=99993402&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

When analyzing the usage of the meta robots tag in Lighthouse tests, 0.47% of crawlable pages were found to be _noindexed_. 0.44% of these pages used a `noindex` directive and did not disallow crawling of the page in the `robots.txt`.

The combination of `Disallow` within `robots.txt` and `noindex` directive in meta robots were found on only 0.03% of pages. While this method offers _belt and suspenders_ redundancy, a page must not be blocked by a `robots.txt` file in order for an on-page `noindex` directive to be effective.

Interestingly, rendering changed the meta robots tag in 0.16% of pages. While there is no inherent issue with using JavaScript to add a meta robots tag to a page or change its content, SEOs should be judicious in execution. If a page loads with a `noindex` directive in the meta robots tag before rendering, [search engines won't run the JavaScript](https://developers.google.com/search/docs/guides/javascript-seo-basics#use-meta-robots-tags-carefully) that changes the tag value or index the page.

#### Canonicalization

[Canonical tags](https://developers.google.com/search/docs/advanced/crawling/consolidate-duplicate-urls), as described by Google, are used to specify to search engines which is the preferred canonical URL version to index and rank for a page—the one that is considered to be better representative of it—when there are many URLs featuring the same or very similar content. It is important to note that:

- The canonical tag configuration is used along with other signals to select the canonical URL of a page; it is not the only one.
- Although self-referencing canonical tags are sometimes used, these aren't a requirement.

{# TODO(authors): The intro disclaims upfront that the dataset is limited to home pages. Consider generalizing to "mobile/desktop pages" throughout the rest of the chapter. #}
[In last year's chapter](../2019/seo#canonicalization), it was identified that 48.34% of mobile pages were using a canonical tag. This year the number of mobile  pages featuring a canonical tag has grown to 53.61%.

{# TODO(analysts): It's not clear that B and C add up to A in this chart. It took me a while to realize that they weren't each different types of tags. If the total of 53.61% is significant, I'd recommend a "big number" figure to call attention to it, and only include B and C in this chart. #}
{{ figure_markup(
  image="seo-presence-of-canonical-tag.png",
  caption="Usage of canonical tags.",
  description="Bar chart showing presence of canonical tags. The majority of web pages include a canonical tag, the main part being self-referential (47.88% for desktop and 45.31% for mobile). The percentage of canonicalized web pages is higher on mobile (8.45%) than on desktop (4.1%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1777344456&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

When analyzing this year's mobile pages canonical tag configuration, it was detected that 45.31% of them were self-referential and 8.45% were pointing to different URLs as the canonical ones.

{# TODO(authors): Consider omitting desktop-specific interpretations unless they're particularly interesting to note beyond the mobile stats. #}
On the other hand, 51.85% of the desktop pages were found to be featuring a canonical tag this year, with 47.88% being self-referential and 4.10% pointing to a different URL.

Not only do mobile pages include more canonical tags than desktop ones (53.61% vs. 51.85%), there are relatively more mobile homes pages canonicalizing to other URLs than their desktop counterparts (8.45% vs. 4.10%). This could be explained by the usage of an independent (or separate) mobile web version by some sites that need to canonicalize to their desktop URLs alternates.

Canonical URLs can be specified through different methods: by using the canonical link via the HTTP headers or the HTML `head` of a page, or by submitting them in XML sitemaps. When analyzing which is the most popular canonical link implementation method, it was found that only 1.03% of desktop pages and 0.88% of mobile ones are relying on the HTTP headers for their implementation, meaning that canonical tags are prominently implemented via the HTML `head` of a page.

{# TODO(analysts): Should "HTTP Head" be "HTTP Header" to distinguish it from HTML head? #}
{{ figure_markup(
  image="seo-canonical-implementation-method.png",
  caption="Usage of HTTP header and HTML <code>head</code> canonicalization methods.",
  description="Bar chart showing the canonical tag implementation method. We observed that only 1.03% of desktop pages and 0.88% of mobile ones are relying on the HTTP headers for their implementation, meaning that canonical tags are prominently implemented via the HTML head of a page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=542127514&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

When analyzing the canonical tag implemented in the raw HTML versus those relying on client-side JavaScript rendering, we identified that 0.68% of the mobile pages and 0.54% of the desktop ones include a canonical tag in the rendered but not the raw HTML. This means that there's only a very small number of pages that are relying on JavaScript to implement canonical tags.

On the other hand, in 0.93% of the mobile pages and 0.76% of the desktop ones, we saw canonical tags implemented via both the raw and the rendered HTML with a conflict happening between the URL specified in the raw versus the rendered HTML of the same pages. This can generate indexability issues as mixed information is sent to search engines about which is the canonical URL for the same page. 

A similar conflict can be found with the different implementation methods, with 0.15% of the mobile pages and 0.17% of the desktop ones showing conflicts between the canonical tags implemented via their HTTP headers and HTML `head`.

### Content

The primary purpose that both search engines and Search Engine Optimization serve is to give visibility to content that users need. Search engines extract features from pages to determine what the content is about. In that way, the two are symbiotic. The features extracted align with signals that indicate relevance and inform ranking.

To understand what search engines are able to effectively extract, we have broken out the components of that content and examined the incidence rate of those features between the mobile and desktop contexts. We also reviewed the disparity between mobile and desktop content. The mobile and desktop disparity is especially valuable because Google has moved to [_mobile-first indexing_](https://developers.google.com/search/blog/2020/03/announcing-mobile-first-indexing-for) (MFI) for all new sites and, as of March of 2021, will move to a _mobile-only index_ wherein content that does not appear within the mobile context will not be evaluated for ranking.


#### Rendered versus non-rendered text content
{# TODO(editors): Update link to 2020 JS technologies section. #}
The usage of Single Page Application (SPA) [JavaScript](../javascript) technologies has exploded with the growth of the web. This design pattern introduces difficulties for search engine spiders because both the execution of JavaScript transformations at runtime and user interactions with the page after load can cause additional content to appear or be rendered.

Search engines encounter pages through its crawling activity, but may or may not choose to implement a second step of rendering a page. As a result, there may be disparities between the content that a user sees and the content that a search engine indexes and considers for rankings.

We assessed word count as a heuristic of that disparity.

{{ figure_markup(
  image="seo-visible-words-per-page-raw.png",
  caption="Distribution of the number of raw words per page.",
  description="Bar chart showing the number of words per page (in raw response) per percentile (10, 25, 50, 75, and 90). The median mobile site displays 13.33% less text content than its desktop counterpart.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=831714745&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

{# TODO(authors, analysts): These charts convey the absolute counts of words, but the written interpretations discuss the relative differences between raw/rendered and desktop/mobile. Is it worth having charts depict these relative differences directly? A reader might be thinking "where did these numbers come from". #}
We found that the median desktop site features 13.46% more words when rendered than it does on an initial crawl of its raw HTML. We also found that the median mobile site displays 13.33% less text content than its desktop counterpart.

{{ figure_markup(
  image="seo-visible-words-per-page-rendered.png",
  caption="Distribution of the number of rendered words per page.",
  description="Bar chart showing the number of visible words per page (in rendered response) per percentile (10, 25, 50, 75, and 90). The median mobile site displays 11.5% more words when rendered than its raw HTML counterpart.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=961460345&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

The median mobile site also displays 11.5% more words when rendered than its raw HTML counterpart.

Across our sample set, there are disparities across the combination of mobile/desktop and rendered/non-rendered. This suggests that although search engines are continually improving in this area, most sites across the web are missing out on opportunities to improve their organic search visibility through a stronger focus on ensuring their content is available and indexable. This is also a concern because the lion's share of available SEO tools do not crawl in the above combination of contexts and automatically identify this as an issue.

This year, the median desktop page was found to have 402 words and the mobile page had 348 words. While [last year](../2019/seo#word-count), the median desktop page had 346 words, and the median mobile page had a slightly lower word count at 306 words. This represents 16.2% and 13.7% growth respectively.

#### Headings

Heading elements (`H1`-`H6`) act as a mechanism to visually indicate structure in a page's content. Although these HTML elements don't carry the weight they used to in search rankings, they still act as a valuable way to structure pages and signal other elements in the search engine results pages (SERPs) like _featured snippets_ or other extraction methods that align with [Google's new passage indexing](https://www.blog.google/products/search/search-on/).

{# TODO(analysts, authors): Nit: replace "This includes empty ones" with "Heading levels" and clarify including empty headings in the prose. #}
{{ figure_markup(
  image="seo-presence-of-h-elements.png",
  caption="Usage of heading levels 1 through 4, including empty headings.",
  description="Bar chart showing the percent of pages with a heading element (level 1,2,3 and 4). Over 60% of pages feature H1 elements in both the mobile and desktop contexts. These numbers hover around 60%+ through H2 and H3 and around 40% for H4.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=2103713054&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

Over 60% of pages feature `H1` elements (including empty ones) in both the mobile and desktop contexts. 

These numbers hover around 60%+ through `H2` and `H3`. The incidence rate of `H4` elements is lower than 4%, suggesting that the level of specificity is not required for most pages or the developers style other headings elements differently to support the visual structure of the content.

The prevalence of more `H2` elements than `H1`s suggests that fewer pages are using multiple `H1`s.

{{ figure_markup(
  image="seo-presence-of-non-empty-h-elements.png",
  caption="Usage of heading levels 1 through 4, excluding empty headings.",
  description="Bar chart showing the percent of pages with non empty heading elements (level 1,2,3 and 4). We observed that 7.55% of H1s, 1.4% of H2s, 1.5% of H3s, and 1.1% of H4 elements feature no text",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=833166653&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

In reviewing the adoption of non-empty heading elements, we found that 7.55% of `H1`, 1.4% of `H2`, 1.5% of `H3`, and 1.1% of `H4` elements feature no text. One possible explanation for these low results is that those portions are used for styling the page or are the result of coding mistakes.

You can learn more about the usage of headings in the [Markup chapter](./markup#headings), including the misuse of non-standard `H7` and `H8` elements.

#### Structured data

Over the course of the past decade, search engines, particularly Google, have continued to push towards becoming the presentation layer of the web. These advancements are partially driven by their improved ability to extract information from unstructured content (e.g., [passage indexing](https://blog.google/products/search/search-on/)) and the adoption of semantic markup in the form of _structured data_. Search engines have encouraged content creators and developers to implement structured data to give more visibility to their content within components of search results.

In a move from ["strings to things"](https://blog.google/products/search/introducing-knowledge-graph-things-not/), search engines have agreed upon a broad vocabulary of objects in support of marking up a variety of people, places, and things within web content. However, only a subset of that vocabulary triggers inclusion within search results components. Google specifies those that they support and how they're displayed in their [search gallery](https://developers.google.com/search/docs/guides/search-gallery), and provides [a tool](https://search.google.com/test/rich-results) to validate their support and implementation. 

As search engines evolve to reflect more of these elements in search results, the incidence rates of the different vocabularies change across the web.

As part of our examination, we took a look at the incidence rates of different types of structured markup. The available vocabularies include [RDFa](https://www.w3.org/TR/rdfa-primer/) and [schema.org](https://schema.org/), which come in both the microformats and [JSON-LD](https://www.w3.org/TR/json-ld11/) flavors. Google has recently [dropped the support for data-vocabulary](https://developers.google.com/search/blog/2020/01/data-vocabulary), which was primarily used to implement breadcrumbs. 

{# TODO(analysts, authors): Consider adding a "big number" figure here for the mobile JSON-LD stat, or a bar chart containing each format. #}
JSON-LD is generally considered to be the more portable and easier to manage implementation and so it has become the preferred format. As a result, we see that JSON-LD appears on 29.78% of mobile pages and 30.60% of desktop pages.

<figure>
  <table>
    <thead>
      <tr>
        <th>Format</th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>JSON-LD</td>
        <td class="numeric">29.78%</td>
        <td class="numeric">30.60%</td>
      </tr>
      <tr>
        <td>Microdata</td>
        <td class="numeric">19.55%</td>
        <td class="numeric">17.94%</td>
      </tr>
      <tr>
        <td>RDFa</td>
        <td class="numeric">1.42%</td>
        <td class="numeric">1.63%</td>
      </tr>
      <tr>
        <td>Microformats2</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.10%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Usage of each structured data format.",
      sheets_gid="TODO",
      sql_file="TODO.sql"
    ) }}
  </figcaption>
</figure>

We find that the disparity between mobile and desktop continues with this type of data. Microdata appeared on 19.55% of mobile pages and 17.94% of desktop pages. RDFa appeared on 1.42% of mobile pages and 1.63% of desktop pages.

##### Rendered versus non-rendered structured data

We found that 38.61% of desktop pages and 39.26% of mobile pages feature JSON-LD or microformat structured data in the raw HTML, while 40.09% of desktop pages and 40.97% of mobile pages feature structured data in the rendered DOM. 

When reviewing this in more detail, we found that 1.49% of desktop pages and 1.77% of mobile pages only featured this type of structured data in the rendered DOM due to JavaScript transformations, relying in search engines JavaScript execution capabilities. 

Finally, we found that 4.46% of desktop pages and 4.62% of mobile pages feature structured data that appears in the raw HTML and is subsequently changed by JavaScript transformations in the rendered DOM. Depending on the type of changes applied to the structured data configuration, this could generate mixed signals for search engines when rendering them.

##### Most prevalent structured data objects

[As seen last year](https://almanac.httparchive.org/en/2019/seo#structured-data), the most prevalent structured data objects remain to be `WebSite`, `SearchAction`, `WebPage`, `Organization`, and `ImageObject`, and their usage has continued to grow:

* `WebSite` has grown 9.37% on desktop and 10.5% on mobile 
* `SearchAction` has grown 7.64% on both desktop and mobile
* `WebPage` has grown on desktop 6.83% and 7.09% on mobile
* `Organization` has grown on desktop 4.75% and 4.98% on mobile 
* `ImageObject` has grown 6.39% on desktop and 6.13% on mobile 

It should be noted that `WebSite`, `SearchAction` and `Organization` are all typically associated with home pages, so this highlights the bias of the dataset and does not reflect the bulk of structured data implemented on the web.

In contrast, despite the fact that reviews are not supposed to be associated with home pages, the data indicates that `AggregateRating` is used on 23.9% on mobile and 23.7% on desktop. 

It's also interesting to see the growth of the [`VideoObject`](https://developers.google.com/search/docs/data-types/video) to annotate videos. Although [YouTube videos dominate video search results in Google](https://moz.com/blog/youtube-dominates-google-video-results-in-2020), the usage of `VideoObject` grew 30.11% on desktop and 27.7% on mobile.

The growth of these objects is a general indication of increased adoption of structured data. There's also an indication of what Google gives visibility within search features increases the incidence rates of lesser used objects. Google announced the [`FAQPage`](https://developers.google.com/search/docs/data-types/faqpage), [`HowTo`](https://developers.google.com/search/docs/data-types/how-to), and [`QAPage`](https://developers.google.com/search/docs/data-types/qapage) objects as visibility opportunities in 2019 and they sustained significant year-over-year growth: 

* `FAQPage` markup grew 3,261% on desktop and 3,000% on mobile.
* `HowTo` markup grew 605% on desktop and 623% on mobile.
* `QAPage` markup grew 166.7% on desktop and 192.1% on mobile.

<p class="note">
  Again, it's important to note that this data might not be representative of their actual level of growth, since these objects are usually placed on internal pages.
</p>

The adoption of structured data is a boon for the web as extracting data is valuable to a wealth of use cases. We expect this to continue to grow as search engines expand their usage and as it begins to power applications beyond web search.

#### Metadata

Metadata is an opportunity to describe and explain the value of the content on the other side of the click. While page titles are believed to be weighed directly in search rankings, meta descriptions are not. Both elements can encourage or discourage a user to click or not click based on their contents.

We examined these features to see how pages are quantitatively aligning with best practices to drive traffic from organic search.

##### Titles

The page title is shown as the anchor text in search engine results and is generally considered one of the most valuable on-page elements that impacts a page's ability to rank.

When analyzing the usage of the `title` tag, we found that 99% of desktop and mobile pages have one. This represents a slight improvement since [last year](../2019/seo#page-titles), when 97% of mobile pages had a `title` tag.

The median page features a page title that is six words long. There is no difference in the word count between the mobile and desktop contexts within our dataset. This suggests that the page title element is an element that is not modified between different page template types.

{{ figure_markup(
  image="seo-title-word-count.png",
  caption="Distribution of the number of words per page title.",
  description="Bar chart showing the number of words in the title tag per percentile (10, 25, 50, 75, and 90). The median page features a page title that is six words long. There is no difference in the word count between the mobile and desktop contexts within our dataset",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=2028212539&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

The median page title character count is 38 characters on both mobile and desktop. Interestingly, this is up from 20 characters on desktop and 21 characters on mobile from [last year's analysis](../2019/seo#page-titles). The disparity between the contexts has disappeared year-over-year except within the 90th percentile wherein there is a one character difference.

{# TODO(analysts): The y-axis label should be "Number of characters". #}
{{ figure_markup(
  image="seo-title-character-count.png",
  caption="Distribution of the number of characters per page title.",
  description="Bar chart showing the number of characters in the title tag per percentile (10, 25, 50, 75, and 90). The median page title character count is 38 characters on both mobile and desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1040977563&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

##### Meta descriptions

The meta description acts as the advertising tagline for a web page. Although [a recent study](https://www.searchenginejournal.com/google-rewrites-meta-descriptions-over-70-of-the-time/382140/) suggests that this tag is ignored and rewritten by Google 70% of the time, it is an element that is prepared with the goal of enticing a user to click through.

When analyzing the usage of meta descriptions, we found that 68.62% of desktop pages and 68.22% of mobile pages have one. Although this may be surprisingly low, it is a slight improvement from [last year](../2019/seo#meta-descriptions), when only 64.02% of mobile pages had a meta description.

{{ figure_markup(
  image="seo-meta-description-word-length.png",
  caption="Distribution of the number of words per meta description.",
  description="Bar chart showing the number of words in the meta description tag per percentile (10, 25, 50, 75, and 90). The median length of the meta description in our dataset is 19 words.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=156955276&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

The median length of the meta description is 19 words. The only disparity in word count takes place in the 90th percentile where the desktop content has one more word than mobile.

{{ figure_markup(
  image="seo-meta-description-character-length.png",
  caption="Distribution of the number of characters per meta description.",
  description="Bar chart showing the number of characters in the meta description tag per percentile (10, 25, 50, 75, and 90). The median character count for the meta description is 138 characters on desktop pages and 136 characters on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1293879233&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

The median character count for the meta description is 138 characters on desktop pages and 136 characters on mobile pages. Aside from the 75th percentile, there is a small disparity between mobile and desktop meta description lengths distributed across the dataset. SEO best practices suggest limiting the specified meta description to up to 160 characters, but Google, inconsistently, may display upwards of 300 characters in its snippets.

With meta descriptions continuing to power other snippets such as social and news feed snippets, and given that Google continually rewrites them and does not consider them a direct ranking factor, it is reasonable to expect that meta descriptions will continue to grow beyond the 160 character limitation.

#### Images

The usage of images, particularly using `img` tags, within a page often suggests a focus on visual presentation of content. Although search engine capabilities regarding computer vision have continued to improve, we have no indication that this technology is being used in the ranking of pages. `alt` attributes remain the primary way to explain an image in lieu of a search engine's ability to "see" it. `alt` attributes also support accessibility and clarify the elements on the page for users that are visually impaired.

{# TODO(authors): Why are the growth of bandwidth and ubiquity of smartphones contributors to image heaviness? #}
The median desktop page includes 21 `img` tags and the median mobile page has 19 `img` tags. The web continues to trend toward image-heaviness with the growth of bandwidth and the ubiquity of smartphones. However, this comes at a cost of performance.

{{ figure_markup(
  image="seo-img-elements-per-page.png",
  alt="img elements per page",
  caption="Distribution of the number of `<img>` elements per page.",
  description="Bar chart showing the number of `<img>` elements per page per percentile (10, 25, 50, 75, and 90). The median desktop page features 21 `<img>` elements and the median mobile page features 19 `<<img>` tags..",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=923860709&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
) }}

{# TODO(authors): Add your interpretation of these results. What do you hope readers get from it? Also consider linking to the Accessibility chapter here if that ties in. #}
The median web page is missing 2.99% of `alt` attributes on desktop and 2.44% of `alt` attributes on mobile.

{# TODO(analysts): Does this caption sound accurate? I wanted to clarify what it was a percent of. #}
{{ figure_markup(
  image="seo-percentage-of-missing-img-alt-attribute.png",
  alt="Percent of missing image alt attributes",
  caption="Distribution of the percent of `<img>` elements missing image `alt` attributes per page.",
  description="Bar chart showing the percent of missing `alt` attributes per percentile (10, 25, 50, 75, and 90). The median web page is missing 2.99% `alt` attributes on desktop and 2.44% of `alt` attributes on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=862590664&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
  )
}}

{# TODO(authors, analysts): I don't think the interpretation of these stats was correct, so I edited out anything that I didn't think was accurate. Please double check my edit and feel free to expand on it. Note that this is incompatible with last year's stat because that was a Lighthouse audit checking that all images have alt attributes, while this data was calculated directly from the markup. There's something off if 40+% of pages have perfect alt coverage, but this chart has less than perfect coverage at the 75th percentile. Either coverage got much _worse_ this year or they're measuring different things. For example Lighthouse may be more lenient about which images should have alt attributes. Do you have those audit results based on 2020 data here for better comparison? #}
We found that the median page contains `alt` attributes on only 51.22% of their images.

{{ figure_markup(
  image="seo-percentage-of-img-alt-attributes-present.png",
  alt="Distribution of the percent of images having alt attributes per page",
  caption="Distribution of the percent of images having `alt` attributes per page.",
  description="Bar chart showing the percentage of `alt` attributes present per percentile (10, 25, 50, 75, and 90). It was found that only 53.86% of desktop and 51.22% of mobile pages featured image `alt` attributes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=827771545&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
) }}

The median web page has 10.00% of images with blank `alt` attributes on desktop and 11.11% on mobile.

{{ figure_markup(
  image="seo-percentage-of-blank-img-alt-attributes.png",
  alt="Distribution of the percent of images having blank alt attributes per page.",
  caption="Distribution of the percent of images having blank `alt` attributes per page.",
  description="Bar chart showing the percent of featured `alt` blank attributes per percentile (10, 25, 50, 75, and 90). The median web page features 10% blank `alt` attributes on desktop and 11.11% blank `alt` attributes on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=378651979&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
) }}

### Links

Modern search engines use hyperlinks between pages for the discovery of new content for indexing and as an indication of authority for ranking. The link graph is something that search engines actively police both algorithmically and through manual review. Web pages pass link equity through their sites and to other sites through these hyperlinks, therefore it is important to ensure that there is a wealth of links throughout any given page.

#### Outgoing links

The median desktop page includes 76 outgoing links while the median mobile page has 67. Historically, the direction from Google suggested that links be limited to 100 per page. While that recommendation is outdated on the modern web, the median page in our dataset adheres to it.

{{ figure_markup(
  image="seo-outgoing-links.png",
  caption="Distribution of the number of outgoing links per page.",
  description="Bar chart showing the number of outgoing links per percentile (10, 25, 50, 75, and 90). The median desktop page features 76 outgoing links while the median mobile page features 67.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=284216213&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

The median page has 61 outgoing internal links (those links going to other pages of the same site) on desktop and 54 on mobile. This is down 12.8% and 10% respectively from [last year's analysis](../2019/seo#linking). This suggests that sites are not maximizing the ability to improve the crawlability and link equity flow through their pages in the way they did the year before.

{{ figure_markup(
  image="seo-outgoing-links-internal.png",
  caption="Distribution of the number of outgoing internal links per page.",
  description="Bar chart showing the number of internal outgoing links per percentile (10, 25, 50, 75, and 90). The median desktop page features 61 outgoing internal links while the median mobile page features 54 outgoing internal links.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=739265254&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

{# TODO(authors): Add your interpretation of these results. What do you hope readers will get out of it? If there's not much to say, would anyone miss it if it was dropped? Also, please clarify the redundancy of outgoing and external for a non-SEO like myself :) #}
The median page is linking to external sites 7 times on desktop and 6 times on mobile. This is a decrease from last year, when it was found that the median number of external links per page were 10 in desktop and 8 on mobile. This decrease in outgoing external links could suggest that websites are now being more careful when linking to other sites, whether to avoid passing link popularity or referring users to them. 


{{ figure_markup(
  image="seo-outgoing-links-external.png",
  caption="Distribution of the number of outgoing expernal links per page.",
  description="Bar chart showing the number of external outgoing links per percentile (10, 25, 50, 75, and 90). The median page is linking to external sites 7 times on desktop and 6 times on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=391564643&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

#### Mobile versus desktop links

There is a disparity in the links between mobile and desktop that will negatively impact sites as Google becomes more committed to mobile-only indexing rather than just mobile-first indexing. This is illustrated in the 62 links on mobile versus the 68 links on desktop for the median web page.

{# TODO(authors): What is a text link and how is that different from all the other links we've been talking about? At least to a non-SEO these all seem non-descript. #}
{{ figure_markup(
  image="seo-text-links.png",
  caption="Distribution of the number of text links per page.",
  description="Bar chart showing the number of text links per percentile (19, 25, 50, 75, and 90). There is a disparity in the links between mobile and desktop (62 links on mobile versus 68 links on desktop).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1588324966&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
  )
}}

#### `rel=nofollow`, `ugc`, and `sponsored` attributes usage

In September of 2019, [Google introduced attributes](https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html) that allow publishers to classify links as being sponsored or user generated content. These attributes are in addition to `rel=nofollow` which was previously [introduced in 2005](https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html). The new attributes, `rel=ugc` and `rel=sponsored`, are meant to clarify or qualify the reason as to why these links are appearing on a given web page.

Our review of pages indicates that 28.58% of pages include `rel=nofollow` attributes on desktop and 30.74% on mobile. However, `rel=ugc` and `rel=sponsored` adoption is quite low with less than 0.3% of pages (about 20,000) having either. Since these attributes don't add any more value to a publisher than `rel=nofollow`, it is reasonable to expect that the rate of adoption will continue to be slow.

{# TODO(analysts): This chart is unusual in that desktop/mobile are the x-axis values. Can you swap it to be like the other charts where nofollow, sponsored, and ugc are on the x-axis and there are two bars for each? #}
{{ figure_markup(
  image="seo-nofollow-ugc-sponsored-attributes.png",
  alt="Percent of pages having rel=nofollow, rel=ugc, and rel=sponsored attributes.",
  caption="Percent of pages having `rel=nofollow`, `rel=ugc`, and `rel=sponsored` attributes.",
  description="Bar chart showing the usage (in percent) of `rel` attributes on desktop and mobile. Our review indicates that 28.58% of pages feature `nofollow` attributes on their desktop versions and 30.74% on mobile. However, `ugc` and `sponsored` adoption is quite low with less than 0.3% pages featuring either. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1177251312&format=interactive",
  sheets_gid="1271677392",
  sql_file="pages_robots_txt_by_device_and_status.sql"
) }}

#### Text versus image links

The median web page uses an image as anchor text to link in 9.80% of desktop and 9.82% of mobile pages. These links represent lost opportunities to implement keyword-relevant anchor text. This only becomes a significant issue at the 90th percentile of pages.

{{ figure_markup(
  image="seo-image-links.png",
  caption="Distribution of the percent of links containing images per page.",
  description="Bar chart showing the percentage of image links per percentile (10, 25, 50, 75, and 90). The median web page features 9.80% image links on desktop and 9.82% image links on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1292929825&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

## Advanced

This section explores the opportunities for optimization related to web configurations and elements that may not directly affect a site's crawlability or indexability, but have either been confirmed by search engines to be used as ranking signals or will affect the capacity of websites to leverage search features.

### Mobile friendliness

With the increasing popularity of mobile devices to browse and search across the web, search engines have been taking mobile friendliness into consideration as a [ranking factor for several years](https://developers.google.com/search/blog/2015/02/finding-more-mobile-friendly-search).

Also, as mentioned before, [since 2016](https://developers.google.com/search/blog/2016/11/mobile-first-indexing) Google has been moving to a mobile-first index, meaning that the content that is crawled, indexed, and ranked is the one accessible to mobile users and the [Smartphone Googlebot](https://developers.google.com/search/docs/advanced/crawling/googlebot?hl=en).

Additionally, [since July 2019](https://developers.google.com/search/blog/2019/05/mobile-first-indexing-by-default-for) Google is using the mobile-first index for all new websites and earlier in March, it announced that [70% of pages shown in their search results have already shifted over](https://webmasters.googleblog.com/2020/03/announcing-mobile-first-indexing-for.html_). It is now expected that Google [fully switches to a mobile-first index in March 2021](https://webmasters.googleblog.com/2020/07/prepare-for-mobile-first-indexing-with.html).

Mobile friendliness should be fundamental for any website looking to provide a good search experience—and as a consequence, grow in search results.

A mobile-friendly website can be implemented through different configurations: by using a responsive web design, with dynamic serving, or via a separate mobile web version. However, maintaining a separate mobile web version is not recommended anymore by Google, who endorse responsive web design instead.

#### Viewport meta tag

The browser's viewport is the visible area of a page content, which changes depending on the used device. The `<meta name="viewport">` tag (or viewport meta tag) allows you to specify to browsers the width and scaling of the viewport, so that it is correctly sized across different devices. Responsive websites use the viewport meta tag as well as CSS media queries to deliver a mobile friendly experience.

42.98% of mobile pages and 43.2% desktop ones are have a viewport meta tag with the `content=initial-scale=1,width=device-width` attribute. However, 10.84% of mobile pages and 16.18% of desktop ones are not including the tag at all, suggesting that they are not yet mobile friendly.

<figure>
  <table>
    <thead>
      <tr>
        <th>Viewport</th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>initial-scale=1,width=device-width</code></td>
        <td class="numeric">42.98%</td>
        <td class="numeric">43.20%</td>
      </tr>
      <tr>
        <td><em>not-set</em></td>
        <td class="numeric">10.84%</td>
        <td class="numeric">16.18%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,width=device-width</code></td>
        <td class="numeric">5.88%</td>
        <td class="numeric">5.72%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width</code></td>
        <td class="numeric">5.56%</td>
        <td class="numeric">4.81%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width</code></td>
        <td class="numeric">3.93%</td>
        <td class="numeric">3.73%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Percent of pages having each viewport meta tag <code>content</code> attribute value.",
      sheets_gid="479500659",
      sql_file="../03_Markup/summary_pages_by_device_and_viewport.sql"
    ) }}
  </figcaption>
</figure>

#### CSS media queries

Media queries are a CSS3 feature that play a fundamental role in responsive web design, as they allow you to specify conditions to apply styling only when the browser and device match certain rules. This allows you to create different layouts for the same HTML depending on the viewport size.

We found that 80.29% of desktop pages and 82.92% of the mobile ones are using either a `height`, `width`, or `aspect-ratio` CSS feature, meaning that a high percentage of pages have responsive features. The most popularly used features can be seen in the table below.

<figure>
  <table>
    <thead>
      <tr>
        <th>Feature</th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>max-width</code></td>
        <td>78.98%</td>
        <td>78.33%</td>
      </tr>
      <tr>
        <td><code>min-width</code></td>
        <td>75.04%</td>
        <td>73.75%</td>
      </tr>
      <tr>
        <td><code>-webkit-min-device-pixel-ratio</code></td>
        <td>44.63%</td>
        <td>38.78%</td>
      </tr>
      <tr>
        <td><code>orientation</code></td>
        <td>33.48%</td>
        <td>33.49%</td>
      </tr>
      <tr>
        <td><code>max-device-width</code></td>
        <td>26.23%</td>
        <td>28.15%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Percent of pages that include each media query feature.",
      sheets_gid="1141218471",
      sql_file="TODO..sql"
    ) }}
  </figcaption>
</figure>

#### Vary User-Agent in HTTP Header

When implementing a mobile friendly website with a dynamic serving configuration -in which you show different HTMLs of the same page based on the used device- it is recommended to add a Vary "User-Agent" HTTP header to help search engines discover the mobile content when crawling the website, as it informs that the response varies depending on the user agent.

Only 13.48% of the mobile pages and 12.6% of the desktop ones were found to specify a Vary "User-Agent" in their HTTP headers.

```html
<link rel="alternate" media="only screen and (max-width: 640px)">
```

Separate mobile websites are recommended to include the "rel="alternate" media="only screen and (max-width: 640px)"" tag in the head of the HTML of their desktop pages to refer to their mobile versions.

Only 0.64% of the analyzed desktop pages were found to be including the tag with the specified `media` attribute value.

### Web Performance

Having a fast loading website is fundamental to provide a great user search experience. Because of its importance it has been taken into consideration as a ranking factor by search engines since many years ago. Google initially announced using site speed as a [ranking factor since 2010](https://webmasters.googleblog.com/2010/04/using-site-speed-in-web-search-ranking.html), and then [in 2018 did the same for mobile searches](https://webmasters.googleblog.com/2018/01/using-page-speed-in-mobile-search.html).

As of November 2020, 3 performance metrics known as [Core Web Vital](https://webmasters.googleblog.com/2020/05/evaluating-page-experience.html) are roadmapped to be a ranking factor as part of the "page experience" signals since May 2021. Sites should expect Googlebot to crawl using its [mobile user-agent](https://support.google.com/webmasters/answer/1061943) with the [Chromium](https://webmasters.googleblog.com/2019/10/updating-user-agent-of-googlebot.html) version details updating as the web Rendering Service updates with new Chromium releases.

#### Lighthouse v6 and Web Core Vitals


For SEOs, performance disambiguated from "speed" with changes to Lighthouse's core measurement methodology in update to version 6.  Lighthouse is the scoring tool that populates key SEO performance tools such as web.dev, Chrome DevTools, and PageSpeed Insights.
Previously, performance scores and methods of measurement varied by tool.  Google announced a set of unified performance metrics called [Core Web Vitals](https://developers.google.com/search/blog/2020/05/evaluating-page-experience) in May 2020.

Each of the metrics aligns to a phase in a user's experience.  The data source is the [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report/) (Crux).  This field data is aggregated from users who have opted-in to syncing their browsing history, have not set up a Sync passphrase, and have usage statistic reporting enabled.

Core Web Vitals consist of:


**[Largest Contentful Paint](https://web.dev/lcp/) (LCP)**
- Represents: Perceived loading experience
- Measurement: the point in the page load timeline when the page's largest image or text block is visible within the viewport.
- Goal: <2.5 seconds
- Lighthouse v6 Performance Score Weight: 25%

**[First Input Delay](https://web.dev/fid/) (FID)**
- Represents: Responsiveness to user input
- Measurement: the time from when a user first interacts with a page to the time when the browser is actually able to begin processing event handlers in response to that interaction.
- Noteworthy: [Total Blocking Time](https://web.dev/tbt/) (TBT) is the lab data counterpart for First Input Delay (FID)
- Goal: <300 milliseconds
- Lighthouse v6 Performance Score Weight: 25% (as Total Blocking Time)

**[Cumulative Layout Shift](https://web.dev/cls/) (CLS)**
- Represents: Visual stability
- Measurement: a calculation based on the number of frames in which element(s) visually moves and the total distance in pixels the element(s) moved.
- Goal: >0.10
- Lighthouse v6 Performance Score Weight: 5%

In light of COVID-19, Google clarified in their official post that no immediate action is required.  Search Console now includes a [Core Web Vitals report](https://search.google.com/search-console/not-verified?original_url=/search-console/core-web-vitals) to help sites improve performance.  The report includes URL specific data grouped together by status, metric type, and URL group (groups of similar web pages).  In order to anonymize user data, a  minimum data threshold is in place.  If a URL does not have enough data from the Crux report, it is omitted.

In the announcement of updates to core measurement, Lighthouse shared their analysis of performance scoring differences between versions 5 and 6. The [limited data set](https://docs.google.com/spreadsheets/d/1BZFh7AyyaLHCj5LGAbrn3m72ysu4yv8okyHG-f3MoXI/edit#gid=1984498811) saw ~18.67% of sites improve, 33.33% with no change, and 48.00% score lower.

Analysts for the Web Almanac saw marked different performance distribution scores between the versions.  Refer to the Performance Chapter of the Web Almanac for an in depth comparison between versions 5 and 6.

In tests using v5 of Lighthouse, 15.44% of pages tested scored at or above the 'passing' 85% score. Tests using Version 6 saw only 8.39% of tests achieve a passing score.

<figure markdown>
  | Percentage of v5 Tests | Percentage of v6 Tests
-- | -- | --
Good | 15.44% | 8.39%
Average | 25.49% | 20.19%
Poor | 59.06% | 71.42%

<figcaption>{{ figure_link(caption="Good, Average and Poor ratios of Lighthouse v5 versus v6", sheets_gid="692150551", sql_file="TODO..sql") }}</figcaption>
</figure>

It is important to note that two of the three new metrics in v6 make up 50% of the weighted performance score. This change in focus sets new, more refined goals. Overall, most pages saw minimal impact with 83.32% of tests shifting ten points or less on the shift to v6.

{{ figure_markup(
  image="seo-lighthouse-v5-vs-v6.png",
  caption="Lighthouse Performance score difference between versions 5 and 6",
  description="Horizontal bar chart showing the score difference between Lighthouse V5 and V6. In tests using v5 of Lighthouse, 15.44% of pages tested scored at or above the 'passing' 85% score. Tests using Version 6 saw only 8.39% of tests achieve a passing score.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=976167005&format=interactive",
  sheets_gid="1909295182",
  sql_file="lighthouse.sql"
  )
}}

Lighthouse v6 and with it the integration of Core Web Vitals rolled out across Google products with the release of Chrome 84 in July 2020. Chrome DevTools Audits panel was renamed to Lighthouse. Pagespeed insights and Google Search Console also reference these unified metrics.

More information on the Lighthouse performance testing results and score details is available in the Performance section.

#### Web vitals and other CrUX Metrics per Device

Desktop continues to be the more performant platform for users despite more users on mobile devices. 33.13% of websites scored 'Good' Core Web Vitals for desktop while only 19.96% of their mobile counterparts passed the Core Web Vitals assessment.

{{ figure_markup(
  image="seo-good-core-web-vitals-score-per-device.png",
  caption="Good Core Web Vitals score per device",
  description="Bar chart showing the percent of websites with a good core web vitals score per device. 33.13% of websites scored 'Good' Core Web Vitals for desktop while only 19.96% of their mobile counterparts passed the Core Web Vitals assessment.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1601210449&format=interactive",
  sheets_gid="996380787",
  sql_file="lighthouse.sql"
  )
}}

#### Web vitals and other CrUX Metrics per Country

A user's physical location impacts performance perception as their locally available telecom infrastructure, network bandwidth capacity, and the cost of data create unique loading conditions.

Users located in the United States recorded the largest number of websites with 'Good' Core Web Vitals experiences but these 'Good' accounted for only 31.88% of all websites. At 56.63%, China recorded the highest percentage of 'Good' Core Web Vital experiences. The portion of websites each country represents in the Chrome User Experience Report data set is worth noting as 1,622,765 total origin records generated from users in the United States dwarfs the 21,270 origins requested from users in China.

{{ figure_markup(
  image="seo-aggregate-cwv-performance-by-country.png",
  caption="Aggregate CWV performance by country",
  description="Horizontal bar chart showing the aggregate core web vitals performance by country.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=2077593128&format=interactive",
  sheets_gid="220428774",
  sql_file="lighthouse.sql",
  width=645,
  height=792
  )
}}

Additional analysis on Core Web Vitals performance by dimensions such as connection type and metric-specific details are available in the [Performance chapter](./performance).

### Internationalization

Internationalization covers the configurations that multilingual or multi-country websites can use to inform search engines about their different language and/or country versions, specifying which are the relevant pages to show users in each case, avoiding targeting issues.

The two international configurations that have been analyzed are the "content-language" meta tag and the `hreflang` attributes, that can be used to specify the language and the content of each page. Additionally, `hreflang` annotations allow you to specify the alternate language or country versions of each page, besides itself.

Search engines like [Google](https://support.google.com/webmasters/answer/189077?hl=en) and [Yandex](https://yandex.com/support/webmaster/yandex-indexing/locale-pages.html) use `hreflang` attributes as a signal to determine the page's language and country target, and although Google doesn't use the HTML lang or the `content-language` meta tag, this last tag is used by Bing.

#### Hreflang

When looking into the `hreflang` attribute usage, it was identified that 8.1% of the analyzed desktop sites are featuring one vs. 7.48% of the mobile ones, which although it might seem a low percentage, it is natural as these are only used by multilingual or multi-country websites.

When analyzing the implementation methods, it was found that only 0.09% of the desktop websites and 0.07% of the mobile ones implement hreflang via their HTTP headers, and that most rely on the HTML head implementation.

On the other hand, it was also identified that although not many, there are some of the sites that are relying on JavaScript to render hreflang annotations: 0.12% desktop and mobile sites are showing hreflang in the rendered but not in the raw HTML.

From a language and country value perspective, when analyzing the implementation via the HTML head, it was found that English (`en`) is the most popular used value, with 4.11% of the mobile and 4.64% of the desktop sites featuring it. After English, the second most popular value is `x-default` (used when defining a "default" or "fallback" version for users of non-targeted languages or countries), with 2.07% of mobile and 2.2% of the desktop sites including it.

The third, fourth and fifth most popular are German (`de`), French (`fr`) and Spanish (`es`), followed by Italian (`it`) and English for the US (`en-us`), as can be seen in the table below with the rest of the values implemented via the HTML head.

<figure markdown>
Values | Mobile | Desktop
-- | -- | --
`en` | 4.11% | 4.64%
`x-default` | 2.07% | 2.20%
`de` | 1.76% | 1.88%
`fr` | 1.74% | 1.87%
`es` | 1.74% | 1.84%
`it` | 1.27% | 1.33%
`en-us` | 1.15% | 1.31%
`ru` | 1.12% | 1.13%
`en-gb` | 0.87% | 0.98%
`pt` | 0.87% | 0.87%
`nl` | 0.83% | 0.94%
`ja` | 0.73% | 0.81%
`pl` | 0.72% | 0.75%
`de-de` | 0.69% | 0.78%
`tr` | 0.69% | 0.66%

<figcaption>{{ figure_link(caption="Top Hreflang Values in HTML Head.", sheets_gid="1272459525", sql_file="pages_wpt_bodies_hreflang_by_device_and_link_tag_value.sql") }}</figcaption>
</figure>

Something slightly different was found in top hreflang language and country values implemented via the HTTP headers, with English (`en`) being again the most popular one, although in this case followed by French (`fr`), German (`de`), Spanish (`es`) and Dutch (`nl`) as the top values.

<figure markdown>
Values | Mobile | Desktop
-- | -- | --
`en` | 0.05% | 0.06%
`fr` | 0.02% | 0.02%
`de` | 0.01% | 0.02%
`es` | 0.01% | 0.01%
`nl` | 0.01% | 0.01%

<figcaption>{{ figure_link(caption="Top Hreflang Values in HTTP Headers.", sheets_gid="1726610181", sql_file="pages_wpt_bodies_hreflang_by_device_and_http_header_value.sql") }}</figcaption>
</figure>

#### Content-Language Meta Tag and HTTP Headers

When analyzing the `content-language` usage and values, whether by implementing it as a meta tag in the HTML head or in the HTTP headers it was found that only 8.5% of the mobile pages and 9.05% of the desktop ones were specifying it in the HTTP headers. Even fewer websites are specifying their language or country with the `content-language` tag in the HTML head, with only 3.63% of mobile pages and 3.59% of desktop ones featuring the tag.

From a language and country value perspective, it was found that the most popular ones are English (en) and English for the US (`en-us`) that are the ones being specified the most both in the content-language meta-tag and in the HTTP headers.

In the case of English (`en`) it was identified that 4.34% of the desktop and 3.69% of the mobile pages were specifying it in the HTTP headers and 0.55% of the desktop and 0.48% of the mobile pages were doing it so via the "content-language" meta tag in the HTML head.

For English for the US (`en-us`), the second most popular value, it was found that only 1.77% of mobile pages and 1.7% of desktop ones were specifying it in the HTTP headers and 0.3% of the mobile pages and 0.36% desktop ones were doing it so in the HTML.

The rest of the most popular language and country values can be seen in the tables below.

<figure markdown>
Values | Mobile | Desktop
-- | -- | --
`en` | 3.69% | 4.34%
`en-us` | 1.77% | 1.70%
`de` | 0.50% | 0.44%
`es` | 0.34% | 0.33%
`fr` | 0.31% | 0.34%
`ru` | 0.18% | 0.16%
`pt-br` | 0.15% | 0.16%
`nl` | 0.13% | 0.15%
`it` | 0.13% | 0.13%
`ja` | 0.08% | 0.10%

<figcaption>{{ figure_link(caption="Top content-language Values in HTTP Headers.", sheets_gid="962106511", sql_file="summary_requests_by_device_and_http_content_language.sql") }}</figcaption>
</figure>

<figure markdown>
Values | Mobile | Desktop
-- | -- | --
`en` | 0.48% | 0.55%
`en-us` | 0.30% | 0.36%
`pt-br` | 0.24% | 0.24%
`ja` | 0.19% | 0.26%
`fr` | 0.18% | 0.19%
`tr` | 0.17% | 0.13%
`es` | 0.16% | 0.15%
`de` | 0.15% | 0.11%
`cs` | 0.12% | 0.12%
`pl` | 0.11% | 0.09%

<figcaption>{{ figure_link(caption="Top content-language Values in HTML Meta Tag.", sheets_gid="1056888726", sql_file="pages_almanac_by_device_and_content_language.sql") }}</figcaption>
</figure>

### Security

Google places a specific focus on security in all respects. The search engine maintains lists of sites that have shown suspicious activity or have been hacked. Search Console surfaces these issues and Chrome users are presented with warnings before visiting sites with these problems. Additionally, Google provides an [algorithmic boost](https://developers.google.com/search/blog/2014/08/https-as-ranking-signal) to pages that are served over the [HTTPS (Hypertext Transfer Protocol Secure)](https://developers.google.com/search/docs/advanced/security/https).

#### HTTPS Usage

We found that 77.44% of desktop pages and 73.22% of mobile pages have adopted HTTPS. This is up 10.38% from last year. It is important to note that browsers have become more aggressive in pushing HTTPS by signaling that pages are insecure when you visit them without HTTPS. Also, HTTPS is currently a requirement to capitalize on higher performing protocols such as HTTP/2 and HTTP/3 (also known as HTTP over QUIC).

All of these things have likely contributed to the higher adoption rate year over year.

{{ figure_markup(
  image="seo-percentage-of-https.png",
  caption="Percent of HTTPS",
  description="Bar chart showing the percent of pages using HTTPS protocol by device. We found that 77.44% of desktop pages and 73.22% of mobile pages have adopted HTTPS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=422955435&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
  )
}}

### AMP

[AMP](https://amp.dev/) (previously called Accelerated Mobile Pages) is an open source HTML framework that was launched by Google in 2015 as a way to help pages to give a faster loading speed, especially on mobile devices. AMP can be implemented as an alternate version of existing web pages or can be used to develop your pages using the AMP framework from scratch.

When there's an AMP version available for a page, it will be shown by Google in Mobile search results, along the AMP logo.

It is also important to note that while AMP usage is not a ranking factor for Google (or any other search engine), web speed is a ranking factor.

Additionally, AMP is at the moment a requirement to be featured in Google's Top Stories carousel in mobile search results–which is an important feature for news related publications. However, this will change in May next year, when non-AMP content will become eligible as long as it meets the [Google News content policies](https://support.google.com/news/publisher-center/answer/6204050) and provides a great [page experience](https://developers.google.com/search/docs/guides/page-experience) as [announced by Google in November this year](https://developers.google.com/search/blog/2020/11/timing-for-page-experience).

When checking the usage of AMP as an alternate version of a non-AMP based page, it was found that 0.69% of mobile web pages and 0.81% of desktop ones were including an "amphtml" tag pointing to an AMP version. Although the adoption is still very low, this is a slight improvement from [last year's AMP related Web Almanac data findings](../2019/seo#amp), in which only 0.62% of mobile pages contained a link to an AMP version.

On the other hand, when assessing the usage of AMP as a framework to develop websites, it was found that only 0.18% of mobile pages and 0.07% of desktop ones were featuring an HTML AMP or emoji attribute, which are used to specify AMP based pages.

### Single Page Applications (SPAs)

Single Page Applications (SPAs) enable browsers to retain and update  a single page load even as the on-page content updates to match a user request. Multiple technologies such as JavaScript frameworks, AJAX, Websockets are used to accomplish lightweight subsequent page loads.

These frameworks required special SEO considerations though Google has worked to mitigate the issues caused by Client Side Rendering with aggressive caching strategies. In a video from [Google Webmaster's 2019 conference](https://youtu.be/rq8sFkl0KnI), Software Engineer Erik Hendriks shared that Google no longer relies on cache-control headers and instead looks for ETag or Last-Modified headers to see if the content of the file has changed.

Single page applications should utilize the [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) for granular control of caching. The API allows for the passing of Request objects with specific cache overrides set and can be used to set the necessary `if-modified` and `etag` headers.

Undiscoverable resources are still the primary concern of search engines as their web crawlers. Search crawlers look for the `href`  attributes in `<a>` tags  to find linked pages. Without these, the page is seen as isolated without internal linking. 5.59% of desktop pages studied contained no internal links as well as 6.04% of mobile-rendered pages. This is a marker that the page is part of a JavaScript framework SPA and missing the necessary `<a>` tag with valid `href` attributes required for their internal linking to be discovered.

The discoverability of links in popular JS frameworks used for SPAs increased dramatically in 2020 over [the previous year](../2019/seo#spa-crawlability). In 2019, 13.08% of mobile navigation links on React sites used deprecated hash URLs. For 2020, only 6.12% of the tested React links were hashed.

Similarly, Vue.js saw a drop to 3.45% from the previous year's 8.15%. Angular was the least likely to use uncrawlable hashed mobile navigation links in 2019 with only 2.37% of mobile pages using them. For 2020, that number plummeted to 0.21%.

## Conclusion

Consistent with what was found and [concluded last year](../2019/seo#conclusion), most sites have crawlable and indexable desktop and mobile pages, and are making use of the fundamental SEO related configurations.

It is important to highlight how the link discoverability for major JS frameworks used for SPAs increased dramatically compared to 2019. By testing mobile navigation links for hashed URLs, we saw -53%  instances of uncrawlable links from sites using React, -58% fewer from Vue.js powered sites, and a -91% reduction from Angular SPAs.

Additionally, it was also identified that there has been a slight improvement from last year's findings across many of the analyzed areas:

- **Robots.txt**: Last year 72.16% of mobile sites had a valid `robots.txt` vs. 74.91%  this year.
- **Canonical tag**: Last year it was identified that 48.34% of mobile pages were using a canonical tag vs. 53.61% this year.
- **Title element**: This year it was found that 98.75% of the desktop pages are featuring one, while 98.7% of mobile pages are also including it. Last year it was found that 97.1% of mobile pages were featuring a title tag.
- **Meta Description**: This year, 68.62% of desktop pages and 68.22% of mobile ones were found to be featuring a meta description, an improvement from last year when it was found that 64.02% of mobile pages had one.
- **Structured Data**: Despite the fact that reviews are not supposed to be associated with home pages the data indicates that `AggregateRating` is up 23.9% on mobile and 23.7% on desktop.
- **Images' `alt` attribute**: This year, 53.86% of desktop and 51.22% of mobile pages featured image `alt` attributes. Although this might seem low, it is an improvement from last year when it was found that 46.71% of mobile pages used `alt` attributes on all of their images.
- **HTTPS usage**: 77.44% of desktop pages and 73.22% of mobile pages have adopted HTTPS. This is up 10.38% from last year.

However, not everything has improved vs. last year configurations.

This year, the median desktop page features 61 outgoing internal links while the median mobile page features 54 outgoing internal links. This is down 12.8% and 10% respectively from [last year's analysis](../2019/seo#linking), suggesting that sites are not maximizing the ability to improve the crawlability and link equity flow through their pages.

It is also important to note how there's still an important opportunity for improvement across many critical SEO related areas and configurations.

Despite the growing use of mobile devices and Google's move to a Mobile first index:

 - 10.84% of mobile pages and 16.18% of desktop ones are not including the viewport tag at all, suggesting that they are not yet mobile friendly.
 - Non-trivial disparities were found across mobile vs. desktop pages, like the one between mobile and desktop links, illustrated in the 62 links on mobile versus the 68 links on desktop for the median web page.
 - 33.13% of websites scored 'Good' Core Web Vitals for desktop while only 19.96% of their mobile counterparts passed the Core Web Vitals assessment, meaning that desktop continues to be the more performant platform for users.

This could negatively impact sites as Google completely migrates to a [mobile-first index in March 2021](https://webmasters.googleblog.com/2020/07/prepare-for-mobile-first-indexing-with.html).

Disparities were found across rendered vs non-rendered HTML. For example the median mobile site displays 11.5% more words when rendered than its raw HTML, showing a reliance on client side JavaScript to show web pages content.

Search crawlers look for the `href`  attributes in `<a>` tags  to find linked pages. Without these, the page is seen as isolated without internal linking. 5.59% of desktop pages studied contained no internal links as well as 6.04% of mobile-rendered pages.

These findings suggest that search engines are continually evolving in their capacity to effectively crawl, index and rank websites, and some of the most important SEO configurations are now also better taken into consideration.

However, many sites across the web are still missing out on important search visibility and growth opportunities, which also shows the persisting need of SEO evangelization and best practices adoption across organizations.
