---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: SEO chapter of the 2021 Web Almanac covering crawlability, indexability, page experience, on-page SEO, links, AMP, internationalization, and more.
authors: [patrickstox, Tomek3c, wrttnwrd]
reviewers: [fili, SeoRobt, fellowhuman1101]
analysts: [jroakes, rvth]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/11hw7zg4dpIY8XbQR5bNp5LvwbaQF0TjV0X5cK0ng8Bg/
patrickstox_bio: Patrick is Product Advisor, Technical SEO, and Brand Ambassador at <a hreflang="en" href="https://ahrefs.com/">Ahrefs</a>. He's an organizer for the <a hreflang="en" href="https://www.meetup.com/RaleighSEO/">Raleigh SEO Meetup</a> (the most successful SEO Meetup in the US), the <a hreflang="en" href="https://www.meetup.com/beerandseo/">Beer and SEO Meetup</a>, and the <a hreflang="en" href="https://raleighseomeetup.org/conference/">Raleigh SEO Conference</a>. He also runs a Technical SEO Slack group and is a moderator for <a hreflang="en" href="https://www.reddit.com/r/TechSEO">/r/TechSEO on Reddit</a>. Patrick also likes to share random SEO knowledge in Twitter threads he calls Uncommon SEO Knowledge. He's a well-known conference speaker, industry blogger (mostly on the <a hreflang="en" href="https://ahrefs.com/blog/">Ahref's blog</a> these days), judge of search awards, and he helped define the role of Search Marketing Strategist for the US Department of Labor.
Tomek3c_bio: Tomek is the Head of Research and Development at <a hreflang="en" href="http://onely.com/">Onely</a>. He's also building <a hreflang="en" href="https://www.ziptie.dev/">ZipTie</a>, a product aiming to help website owners get more content indexed by Google.
In his spare time, he enjoys hiking and playing poker.
wrttnwrd_bio: Ian is a marketing consultant, SEO, speaker, and recovering agency founder. He founded Portent, a digital marketing agency, in 1995, and sold it to Clearlink in 2017. He's now on his own, <a hreflang="en" href="https://www.ianlurie.com/digital-marketing-consulting/">consulting for brands</a> he loves and <a hreflang="en" href="https://www.ianlurie.com/speaking/">speaking at conferences</a> that provide Diet Coke. He's also trying to become a professional Dungeons & Dragons player, but it hasn't panned out.
You can find him pedaling his bike up Seattle's ridiculous hills.
featured_quote: SEO is more popular than ever and has seen huge growth over the last couple years as companies sought new ways to reach customers. SEO's popularity has far outpaced other digital channels.
featured_stat_1: 16.5%
featured_stat_label_1: Websites that don't have a robots.txt file
featured_stat_2: 41.5%
featured_stat_label_2: Mobile pages without a canonical tag
featured_stat_3: 67%
featured_stat_label_3: Mobile websites failing Core Web Vitals checks
---

## Introduction

SEO (Search Engine Optimization) is the practice of optimizing a website or webpage to increase the quantity and quality of its traffic from a search engine's organic results.

SEO is more popular than ever and has seen huge growth over the last couple years as companies sought new ways to reach customers. SEO's popularity has far outpaced other digital channels.

{{ figure_markup(
   image="seo-term-trends.png",
   caption="Google Trends comparison of SEO versus pay-per-click, social media marketing, and email marketing.",
   description="Screenshot showing the interest over time in Google Trends comparing four digital marketing channels; search engine optimization, pay-per-click, social media marketing, and email marketing. SEO remained the most popular digital marketing channel, with interest far outpacing the other channels in recent years. SEO continued to be an evolving field with a growing community around the world.",
   width=1155,
   height=605
   )
}}

The purpose of the SEO chapter of the Web Almanac is to analyze various elements related to optimizing a website. In this chapter, we'll check if websites are providing a great experience for users and search engines.

Many sources of data were used for our analysis including <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>, the <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report (CrUX)</a>, as well as raw and rendered HTML elements from the <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> on mobile and desktop. In the case of the HTTP Archive and Lighthouse, the data is limited to the data identified from websites' homepages only, not site-wide crawls. Keep that in mind when drawing conclusions from our results. You can learn more about the analysis on our [Methodology](./methodology) page.

Read on to find out more about the current state of the web and its search engine friendliness.

## Crawlability and Indexability

To return relevant results to these user queries, search engines have to create an index of the web. The process for that involves:

1. **Crawling** - search engines use web crawlers, or spiders, to visit pages on the internet. They find new pages through sources such as sitemaps or links between pages.
2. **Processing** - in this step search engines may render the content of the pages. They will extract information they need like content and links that they will use to build and update their index, rank pages, and discover new content.
3. **Indexing** - Pages that meet certain indexability requirements around content quality and uniqueness will typically be indexed. These indexed pages are eligible to be returned for user queries.

Let's look at some issues that may impact crawlability and indexability.

### `robots.txt`

`robots.txt` is a file located in the root folder of each subdomain on a website that tells robots such as search engine crawlers where they can and can't go.

81.9% of websites make use of the robots.txt file (mobile). Compared with previous years (72.2% in 2019 and 80.5% in 2020), that's a slight improvement.

Having a `robots.txt` is not a requirement. If it's returning a 404 not found, Google assumes that every page on a website can be crawled. Other search engines may treat this differently.

{{ figure_markup(
   image="robots-txt-status-codes.png",
   caption="Breakdown of robots.txt status codes.",
   description="Bar chart showing percent of pages with a valid robots.txt file. Status code 200 was present on 81.9% of mobile sites, status code 404 was present on 16.5% of mobile sites. The other status codes are barely used, and desktop numbers are almost identical to mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2062029998&format=interactive",
   sheets_gid="91318795",
   sql_file="robots-txt-status-codes.sql"
   )
}}

Using `robots.txt` allows website owners to control search engine robots. However, the data showed that as many as 16.5% of websites have no `robots.txt` file.

Websites may have misconfigured `robots.txt` files. For example, some popular websites were (presumably mistakenly) blocking search engines. Google may keep these websites indexed for a period of time, but eventually their visibility in search results will be lessened.

Another category of errors related to `robots.txt` is accessibility and/or network errors, meaning the `robots.txt` exists but cannot be accessed. If Google requests a `robots.txt` file and gets such an error, the bot may stop requesting pages for a while. The logic behind this is that search engines are unsure if a given page can or cannot be crawled, so it waits until `robots.txt` becomes accessible.

~0.3% of websites in our dataset returned either 403 Forbidden or 5xx. Different bots may handle these errors differently, so we don't know exactly what Googlebot may have seen.

The latest information available <a hreflang="en" href="https://www.youtube.com/watch?v=JvYh1oe5Zx0&amp;t=315s">from Google, from 2019</a> is that as many as 5% of websites were temporarily returning 5xx on robots.txt, while as many as 26% were unreachable.

{{ figure_markup(
   image="robots-usage-presentation.png",
   caption="Breakdown of robots.txt status codes Googlebot encountered.",
   description="Screenshot showing the percentage of robots.txt status codes encountered by Googlebot. Taken from 2019 data, 69% of sites were Good and utilized status code 200 or returned 404 for open access. As many as 5% were Temporarily OK returning 5xx on `robots.txt`. As much as 26% of sites were Unreachable.",
   width=609,
   height=313
   )
}}

Two things may cause the discrepancy between the HTTP Archive and Google data:

1. Google presents data from 2 years back while the HTTP Archive is based on recent information, or

2. The HTTP Archive focuses on websites that are popular enough to be included in the CrUX data, while Google tries to visit all known websites.

### `robots.txt` size

{{ figure_markup(
   image="robots-txt-size-distribution.png",
   caption="`robots.txt` size distribution.",
   description="Bar chart showing robots.txt size distribution. Nearly all robots.txt files are small and weighed between 0-100 kb. We found that 96.72% of robots.txt files on mobile pages weighed between 0-100 kb (similar results for desktop). Virtually no web pages (desktop or mobile) had robots.txt files greater than 100 kb, and 1.58% were missing.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1491943936&format=interactive",
   sheets_gid="1066408164",
   sql_file="robots-text-size.sql"
   )
}}

Most robots.txt files are fairly small, weighing between 0-100 kb. However, we did find over 3,000 domains that have a robots.txt file size over 500 KiB which is beyond Google's max limit. Rules after this size limit will be ignored.

{{ figure_markup(
   image="robots-txt-user-agent.png",
   caption="`robots.txt` user-agent usage.",
   description="Bar chart showing the ten most common robots.txt user-agent usage. Results were nearly identical for desktop and mobile, with 75.2% of domains not indicating a specific user-agent. We found 6.3% for `adsbot-google`, 5.6% for `mj12bot`, 5.0% for `ahrefsbot`, 4.9% for `mediapartners-google`, 3.4% for `googlebot`, 3.3% for `nutch`, 3.1% for `yandex`, 2.9% for `pinterest`, 2.7% for `ahrefssiteaudit`.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1206728832&format=interactive",
   sheets_gid="964313002",
   sql_file="robots-txt-user-agent-usage.sql"
   )
}}

You can declare a rule for all robots or specify a rule for specific robots. Bots usually try to follow the most specific rule for their user-agents. `Disallow: Googlebot` will refer to Googlebot only, while `Disallow: *` will refer to all bots that don't have a more specific rule.

We saw two popular SEO-related robots: `mj12bot` (Majestic) and `ahrefsbot` (Ahrefs) in the top 5 most specified user agents.

### `robots.txt` search engine breakdown

<figure>
  <table>
    <thead>
      <tr>
        <th>User-agent</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Googlebot</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td>Bingbot</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td>Baiduspider</td>
        <td class="numeric">1.9%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>Yandexbot</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`robots.txt` search engine breakdown.", sheets_gid="964313002", sql_file="robots-txt-user-agent-usage.sql") }}</figcaption>
</figure>

When looking at rules applying to particular search engines, Googlebot was the most referenced appearing on 3.3% of crawled websites.

Robots rules related to other search engines, such as Bing, Baidu, and Yandex, are less popular (respectively 2.5%, 1.9%, and 0.5%). We did not look at what rules were applied to these bots.

### Canonical tags

The web is a massive set of documents, some of which are duplicates. To prevent duplicate content issues, webmasters can use canonical tags to tell search engines which version they prefer to be indexed. Canonicals also help to consolidate signals such as links to the ranking page.

{{ figure_markup(
   image="canonical-tag-usage.png",
   caption="Canonical tag usage.",
   description="Bar chart showing canonical tag usage. We found most web pages used canonical tags (58.5% of mobile pages and 56.6% of desktop pages). The percentage of canonicalized web pages was higher on mobile (8.3%) compared to desktop (4.3%).",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=118545040&format=interactive",
   sheets_gid="1066408164",
   sql_file="pages-canonical-stats.sql"
   )
}}

The data shows increased adoption of canonical tags over the years. For example, 2019's edition shows that 48.3% of mobile pages were using a canonical tag. In 2020's edition, the percentage grew to 53.6%, and in 2021 we see 58.5%.

More mobile pages have canonicals set than their desktop counterparts. In addition, 8.3% of mobile pages and 4.3% of desktop pages are canonicalized to another page so that they provide a clear hint to Google and other search engines that the page indicated in the canonical tag is the one that should be indexed.

A higher number of canonicalized pages on mobile seems to be related to websites using <a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">separate mobile URLs</a>. In these cases, Google recommends placing a `rel="canonical"` tag pointing to the corresponding desktop URLs.

Our dataset and analysis are limited to homepages of websites; the data is likely to be different when considering all URLs on the tested websites.

#### Two methods of implementing canonical tags

When implementing canonicals, there are two methods to specify canonical tags:

1. In the HTML's `<head>` section of a page
2. In the HTTP headers (via the `Link` HTTP header)

{{ figure_markup(
   image="canonical-raw-rendered-usage.png",
   caption="Canonical raw versus rendered usage.",
   description="Bar chart showing the presence of raw vs rendered canonical tags (raw, rendered, rendered but not raw, rendering changed, http header changed). Our data found that raw canonical tags were found on 55.9% of desktop and 57.7% of mobile pages. Rendered canonical tags were found on 56.5% of desktop and 58.4% of mobile pages. Other tags were found on less than 1.5% of desktop or mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1288519273&format=interactive",
   sheets_gid="1066408164",
   sql_file="pages-canonical-stats.sql"
   )
}}

Implementing canonical tags in the `<head>` of a HTML page is much more popular than using the `Link` header method. Implementing the tag in the head section is generally considered easier, which is why that usage so much higher.

We also saw a slight change (< 1%) in canonical between the raw HTML delivered, and the rendered HTML after JavaScript has been applied.

#### Conflicting canonical tags

Sometimes pages contain more than one canonical tag. When there are conflicting signals like this, search engines will have to figure it out. One of Google's Search Advocates, [Martin Splitt](https://twitter.com/g33konaut), once said <a hreflang="en" href="https://www.youtube.com/watch?v=bAE3L1E1Fmk&amp;t=772s">it causes undefined behavior</a> on Google's end.

The previous figure shows as many as 1.3% of mobile pages have different canonical tags in the initial HTML and the rendered version.

[Last year's chapter noted that](../2020/seo#canonicalization) "A similar conflict can be found with the different implementation methods, with 0.15% of the mobile pages and 0.17% of the desktop ones showing conflicts between the canonical tags implemented via their HTTP headers and HTML head."

This year's data on that conflict is even more worrisome. Pages are sending conflicting signals in 0.4% of cases on desktop and 0.3% of cases on mobile.

As the Web Almanac data only looks on homepages, there may be additional problems with pages located deeper in the architecture, which are pages more likely to be in need of canonical signals.

## Page Experience

2021 saw an increased focus on user experience. Google launched the <a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">Page Experience Update</a> which included existing signals, such as HTTPS and mobile-friendliness, and new speed metrics called Core Web Vitals.

### HTTPS

{{ figure_markup(
   image="usage-of-https.png",
   caption="Percentage of Desktop and Mobile pages served with HTTPS.",
   description="Bar chart showing the percentage of HTTPS. We found that that 81.2% of mobile pages were HTTPS and 84.3% of desktop pages were HTTPS.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1826599611&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

Adoption of HTTPS is still increasing. HTTPS was the default on 81.2% of mobile pages and 84.3% of desktop pages. That's up nearly 8% on mobile websites and 7% on Desktop websites year over year.

### Mobile-friendliness

There's a slight uptick in mobile-friendliness this year. Responsive design implementations have increased while dynamic serving has remained relatively flat.

Responsive design sends the same code and adjusts how the website is displayed based on the screen size, while dynamic serving will send different code depending on the device. The `viewport` meta tag was used to identify responsive websites vs the `Vary: User-Agent header` to identify websites using dynamic serving.

{{ figure_markup(
  caption="Percent of mobile pages using the `viewport` meta tag—a signal of mobile friendliness.",
  content="91.1%",
  classes="big-number",
  sheets_gid="704656954",
  sql_file="meta-tag-usage-by-name.sql"
)
}}

 91.1% of mobile pages include the `viewport` meta tag, up from 89.2% in 2020. 86.4% of desktop pages also included the viewport meta tag, up from 83.8% in 2020.

{{ figure_markup(
   image="vary-usage-agent-header-usage.png",
   caption="`Vary: User-Agent` header usage.",
   description="Bar chart showing the `vary` header used to identify mobile-friendless. We found that most web pages utilized a response design (87.4% for desktop and 86.6% for mobile), compared to pages that used dynamic serving (12.6% for desktop and 13.4% for mobile).",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1985736287&format=interactive",
   sheets_gid="478009067",
   sql_file="html-response-vary-header-used.sql"
   )
}}

For the `Vary: User-Agent` header, the numbers were pretty much unchanged with 12.6% of desktop pages and 13.4% of mobile pages with this footprint.

{{ figure_markup(
  caption="Percent of mobile pages not using legible font sizes.",
  content="13.5%",
  classes="big-number",
  sheets_gid="1705330480",
  sql_file="lighthouse-seo-stats.sql"
)
}}

One of the biggest reasons for failing mobile-friendliness was that 13.5% of pages did not use a legible font size. Meaning <a hreflang="en" href="https://web.dev/font-size/">60% or more of the text had a font size smaller than 12px</a> which can be hard to read on mobile.

### Core Web Vitals

Core Web Vitals are the new speed metrics that are part of Google's Page Experience signals. The metrics measure visual load with Largest Contentful Paint (LCP), visual stability with Cumulative Layout Shift (CLS), and interactivity with First Input Delay (FID).

The data comes from the Chrome User Experience Report (CrUX), which records real-world data from opted-in Chrome users.

{{ figure_markup(
   image="core-web-vitals-trend.png",
   caption="Core web vitals metrics trend.",
   description="Line chart showing the percentage of good CWV experiences on mobile. In 2021, Good LCP increased from 42% to 45%, Good FID increased from 81% to 90%, Good CLS increased from 55% to 62%, and Good CWV increased from 23% to 29%. Our findings suggest that percentage of mobile websites that offer good CWV experiences will continue to increase each year.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1693723951&format=interactive",
   sheets_gid="460991760",
   sql_file="core-web-vitals.sql"
   )
}}

29% of mobile websites are now passing Core Web Vitals thresholds, up from 20% last year. Most websites are passing FID, but website owners seem to be struggling to improve CLS and LCP. See the [Performance](./performance) chapter for more on this topic.

## On-Page

Search engines look at your page's content to determine whether it's a relevant result for the search query. Other on-page elements may also impact rankings or appearance on the search engines.

### Metadata

Metadata includes `<title>` elements and `<meta name="description">` tags. Metadata can directly and/or indirectly affect SEO performance.

{{ figure_markup(
   image="title-meta-description-usage.png",
   caption="Breakdown of title and meta description usage.",
   description="Bar chart showing the percentage of pages that have metadata. We found that 98.8% of mobile and desktop pages had a `title` element and 71.1% of mobile and desktop pages had a meta description.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=541272297&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

In 2021, 98.8% of desktop and mobile pages had `<title>` elements. 71.1% of desktop and mobile homepages had `<meta name="description">` tags.

#### `<title>` Element

The `<title>` element is an on-page ranking factor that provides a strong hint regarding page relevance and may appear on the Search Engine Results Page (SERP). In August 2021 <a hreflang="en" href="https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles">Google started re-writing more titles in their search results</a>.

{{ figure_markup(
   image="title-word-counts.png",
   caption="Number of words used in title elements.",
   description="Bar chart showing the number of words in the title tag percentile (10, 25, 50, 75, and 90). The median page contained a title that was 6 words, and 50% of all titles contained 3-9 words.  There was no difference in the word count between desktop and mobile within our dataset.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2017837375&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

{{ figure_markup(
   image="title-character-counts.png",
   caption="Number of characters used in title elements.",
   description="Bar chart showing the number of characters in the title tag per percentile (10, 25, 50, 75, and 90). The median page contained a title character count of 39 characters on desktop and 40 on mobile. There was little different in the character count between desktop and mobile in our dataset.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1099454676&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

In 2021:

- The median page `<title>` contained 6 words.
- The median page `<title>` contained 39 and 40 characters on desktop and mobile, respectively.
- 10% of pages had `<title>` elements containing 12 words.
- 10% of desktop and mobile pages had `<title>` elements containing 74 and 75 characters, respectively.

Most of these stats are relatively unchanged since last year. Reminder that these are titles on homepages which tend to be shorter than those used on deeper pages.

#### Meta description tag

The `<meta name="description>` tag does not directly impact rankings. However, it may appear as the page description on the SERP.

{{ figure_markup(
   image="meta-word-counts.png",
   caption="Number of words used in meta descriptions.",
   description="Bar chart showing the number of words in the meta description per percentile (10, 25, 50, 75, and 90). The median page contatined a meta description with 20 words for desktop and 19 words for mobile. There was little different in the character count between desktop and mobile in our dataset.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2013621429&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

{{ figure_markup(
   image="meta-character-counts.png",
   caption="Number of characters used in meta descriptions.",
   description="Bar chart showing the number of characters in the meta description tag per percentile (10, 25, 50, 75, and 90). The median page contained meta description with 138 characters on desktop pages and 137 characters on mobile pages. There was little different in the character count between desktop and mobile in our dataset.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=971210715&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

In 2021:

- The median desktop and mobile page `<meta name="description>` tag contained 20 and 19 words, respectively.
- The median desktop and mobile page `<meta name="description>` tag contained 138 and 127 characters, respectively.
- 10% of desktop and mobile pages had `<meta name="description>` tags containing 35 words.
- 10% of desktop and mobile pages had `<meta name="description>` tags containing 232 and 231 characters, respectively.

These numbers are relatively unchanged from last year.

### Images

{{ figure_markup(
   image="number-of-images-per-page.png",
   caption="Number of images on each page.",
   description="Bar chart showing the number of `<img>` elements per page per percentile (10, 25, 50, 75, and 90). The median desktop page featured 21 `<img>` elements and the median mobile page featured 19 `<img>` elements.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1314615789&format=interactive",
   sheets_gid="1483073708",
   sql_file="image-alt-stats.sql"
   )
}}

Images can directly and indirectly impact SEO as they impact image search rankings and page performance.

- 10% of pages have two or fewer `<img>` tags. That's true of both desktop and mobile.
- The median desktop page has 21 `<img>` tags while the median mobile page has 19 `<img>` tags.
- 10% of desktop pages have 83 or more `<img>` tags. 10% of mobile pages have 73 or more `<img>` tags.

These numbers have changed very little since 2020.

#### Image `alt` attributes

The `alt` attribute on the `<img>` element helps explain image content and impacts <a hreflang="en" href="https://almanac.httparchive.org/en/2021/accessibility">accessibility</a>.

Note that missing `alt` attributes may not indicate a problem. Pages may include extremely small or blank images which don't require an `alt` attribute for SEO (nor accessibility) reasons.

{{ figure_markup(
   image="images-with-alt-attribute.png",
   caption="Percentage of images that contain `alt` attributes.",
   description="Bar chart showing the number of images with `alt` attributes present per percentile (10, 25, 50, 75, and 90). Our data found the median web page contained 54.6% of images with an `alt` attribute on mobile pages and 56.5% on desktop pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1862003290&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

{{ figure_markup(
   image="images-with-blank-alt-attribute.png",
   caption="Percentage of `alt` attributes that were blank.",
   description="Bar chart showing the percent of featured alt blank attributes per percentile (25, 50, 75, and 90). The median web page featured 10.5% blank `alt` attributes on desktop and 11.8% blank `alt` attributes on mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=198831003&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

{{ figure_markup(
   image="images-with-missing-alt-attribute.png",
   caption="Percentage of images missing alt attributes.",
   description="Bar chart showing the percent of images with `alt` attributes missing per percentile (10, 25, 50, 75, and 90). The median web page had 1.4% of images with `alt` attributes missing on desktop on zero `alt` attributes missing on mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=819909313&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

We found that:

- On the median desktop page, 56.5% of `<img>` tags have an `alt` attribute. This is a slight increase versus 2020.
- On the median mobile page, 54.6% of `<img>` tags have an `alt` attribute. This is a slight increase versus 2020.
- However, on the median desktop and mobile pages 10.5% and 11.8% of `<img>` tags have blank `alt` attributes (respectively). This is effectively the same as 2020.
- On the median desktop and mobile pages there are zero or close to zero `<img>` tags missing `alt` attributes. This is an improvement over 2020, when 2-3% of `<img>` tags on median pages were missing `alt` attributes.

#### Image `loading` attributes

The `loading` attribute on `<img>` elements affects how user agents prioritize rendering and display of images on the page. It may impact user experience and page load performance, both of which impact SEO success.

{{ figure_markup(
   image="image-loading-property-usage.png",
   caption="Image loading property usage.",
   description='Bar chart showing percent of pages and image loading property usage (missing, lazy, eager, invalid, auto, and blank). Our data found that 83.3% of desktop and 83.5% of mobile pages were missing an image loading property. We found that 15.6% of desktop and mobile pages use `loading="lazy"` while only .8% of desktop and mobile pages use `loading="eager"`. Other image loading properties such as `loading="invalid"`, `loading="auto"`, and `loading="blank"` were used on less than 1% of desktop or mobile pages.',
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1305654777&format=interactive",
   sheets_gid="55531578",
   sql_file="image-loading-property-usage.sql"
   )
}}

We saw that:

- 85.5% of pages don't use any image `loading` property.
- 15.6% of pages use `loading="lazy"` which delays loading an image until it is close to being in the viewport.
- 0.8% of pages use `loading="eager"` which loads the image as soon as the browser loads the code.
- 0.1% of pages use invalid loading properties.
- 0.1% of pages use `loading="auto"` which uses the default browser loading method.


### Word count

The number of words on a page isn't a ranking factor, but the way pages deliver words can profoundly impact rankings. Words can be in the raw page code or the rendered content.

#### Rendered word count

First, we look at rendered page content. _Rendered_ is the content of the page after the browser has executed all JavaScript and any other code that modifies the DOM or CSSOM.

{{ figure_markup(
   image="visible-rendered-words-percentile.png",
   caption="Visible words rendered by percentile.",
   description="Bar chart showing the number of visible words rendered by percentile (10, 25, 50, 75, 90). The median _rendered_ desktop page contained 425 words and the median mobile page contained 367. Mobile pages contained fewer _rendered_ words at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=833732027&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

- The median _rendered_ desktop page contains 425 words, versus 402 words in 2020.
- The median _rendered_ mobile page contains 367 words, versus 348 words in 2020.
- Rendered mobile pages contain 13.6% fewer words than rendered desktop pages. Note that Google is a mobile-only index. Content not on the mobile version may not get indexed.

#### Raw word count

Next, we look at the raw page content _Raw_ is the content of the page before the browser has executed JavaScript or any other code that modified the DOM or CSSOM. It's the "raw" content delivered and visible in the source code.

{{ figure_markup(
   image="visible-raw-words-percentile.png",
   caption="Visible words raw by percentile.",
   description="Bar chart showing the number of raw visible words by percentile (10, 25, 50, 75, 90). The median raw desktop page contained 369 words and the median mobile page contained 321. Mobile pages contained fewer raw words at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=58186900&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

- The median _raw_ desktop page contains 369 words, versus 360 words in 2020.
- The median _raw_ mobile page contains 321 words, versus 312 words in 2020.
- Raw mobile pages contain 13.1% fewer words than rendered desktop pages. Note that Google is a mobile-only index. Content not on the mobile HTML version may not get indexed.

Overall, 15% of written content on desktop devices is generated by JavaScript and 14.3% on mobile versions.

### Structured Data

Historically, search engines have worked with unstructured data: the piles of words, paragraphs and other content that comprise the text on a page.

Schema markup and other types of structured data provide search engines another way to parse and organize content. Structured data powers many of <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/search-gallery">Google's search features</a>.

Like words on the page, structured data can be modified with JavaScript.

{{ figure_markup(
   image="structured-data-usage.png",
   caption="Structure data usage.",
   description="Bar chart showing the number of pages with raw vs rendered structured data. 41.8% of desktop and 42.5% of mobile of pages had raw structured data. The number of pages that had rendered structure data was 43.2% for desktop and 44.2% for mobile. Few pages had only rendered structure data, 1.4% of desktop pages and 1.7% of mobile pages. Lastly, 4.5% of desktop pages and 4.7% of mobile pages had structured data rendering changes.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1924313131&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

42.5% of mobile pages and 41.8% of desktop pages have structured data in the HTML. JavaScript modifies the structured data on 4.7% of mobile pages and 4.5% of desktop pages.

On 1.7% of mobile pages and 1.4% of desktop pages structured data is added by JavaScript where it didn't exist in the initial HTML response.

#### Most popular structured data formats

{{ figure_markup(
   image="structured-data-formats.png",
   caption="Breakdown of structured data formats.",
   description="Bar chart showing the number of pages with structured data formats (jsonld, microdata, rdfa, microformats 2). The jsonld structured data format was implemented on 62.4% of desktop and 60.5% of mobile sites. The microdata format was implemented on 34.6% of desktop and 36.9% of mobile sites. The rdfa format was implemented on 2.9% of desktop and 2.4% of mobile sites. The microformats2 format was used on only .2% of desktop and mobile sites in our dataset.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1433352391&format=interactive",
   sheets_gid="1113852331",
   sql_file="structured-data-formats.sql"
   )
}}

There are several ways to include structured data on a page: JSON-LD, microdata, RDFa, and microformats2. JSON-LD is the most popular implementation method. Over 60% of desktop and mobile pages that have structured data implement it with JSON-LD.

Among websites implementing structured data, over 36% of desktop and mobile pages use microdata and less than 3% of pages use RDFa or microformats2.

Structured data adoption is up a bit since last year. It's used on 33.2% of pages in 2021 vs 30.6% in 2020.

#### Most popular schema types

{{ figure_markup(
   image="most-popular-schema-types.png",
   caption="Most popular schema types.",
   description="Bar chart showing the most popular schema types found on homepages. Results were nearly identical for desktop and mobile homepages. The most popular schema types were WebSite, SearchAction, WebPage, UnknownType and Organization.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=242663990&format=interactive",
   sheets_gid="1580260783",
   sql_file="structured-data-schema-types.sql",
   width=600,
   height=532
   )
}}

The most popular schema types found on homepages are `WebSite`, `SearchAction`, `WebPage`. `SearchAction` is what powers the <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">Sitelinks Search Box</a>, which Google can choose to show in the Search Results Page.

### `<h>` elements (headings)

Heading elements (`<h1>`, `<h2>`, etc.) are an important structural element. While they don't directly impact rankings, they do help Google to better understand the content on the page.

{{ figure_markup(
   image="heading-element-usage.png",
   caption="Heading element usage.",
   description="Bar chart showing the percent of pages with the presence of H elements by heading tag (level 1, 2, 3, 4). There was little to no difference between desktop and mobile results. `h1` headings were found on 65.4% of pages, `h2`s were found the most frequently on 71.9% of pages, `h3`3s were found on 61.8% of pages and `h4` headings were found on 37.6% of pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1197492338&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

For main headings, more pages (71.9%) have `h2`s than have `h1`s (65.4%). There's no obvious explanation for the discrepancy. 61.4% of desktop and mobile pages use `h3`s and less than 39% use `h4`s.

There was very little difference between desktop and mobile heading usage, nor was there a major change versus 2020.

{{ figure_markup(
   image="non-empty-heading-element-usage.png",
   caption="Non-empty heading element usage.",
   description="Bar chart showing the percent of pages with the presence of non-empty `<h>` elements by heading tag (level 1, 2, 3, 4). There was little to no difference between desktop and mobile results. `h1` headings were found on 58.1% of pages, `h2`s were found the most frequently on 70.5% of pages, `h3`s on 60.3% of pages and `h4` headings were found on 36.5% of pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2102902536&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

However, a lower percentage of pages include _non-empty_`<h>` elements, particularly `h1`. Websites often wrap logo-images in `<h1>` elements on homepages, and this may explain the discrepancy.

## Links

Search engines use links to discover new pages and to pass [_PageRank_](https://en.wikipedia.org/wiki/PageRank) which helps determine the importance of pages.

{{ figure_markup(
  caption="Pages using non-descriptive link texts.",
  content="16.0%",
  classes="big-number",
  sheets_gid="1705330480",
  sql_file="lighthouse-seo-stats.sql"
)
}}

On top of PageRank, the text used as a link anchor helps search engines to understand what a linked page is about. Lighthouse has a test to check if the anchor text used is useful text or if it's generic anchor text like "learn more" or "click here" which aren't very descriptive. 16% of the tested links did not have descriptive anchor text, which is a missed opportunity from an SEO perspective and also bad for accessibility.

### Internal and external links

{{ figure_markup(
   image="outgoing-internal-link.png",
   caption="Internal links from homepages.",
   description="Bar chart showing the number of internal links on homepages by percentile (10, 25, 50, 75, 90). The median desktop homepage had 64 internal links compared to 55 internal links on mobile. There were more internal links on desktop homepages at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1929473622&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

Internal links are links to other pages on the same site. Pages had less links on the mobile versions compared to the desktop versions.

The data shows that the median number of internal links on desktop is 16% higher than mobile, 64 vs 55 respectively. It's likely this is because developers tend to minimize the navigation menus and footers on mobile to make them easier to use on smaller screens.

The most popular websites (the top 1,000 according to CrUX data) have more outgoing internal links than less popular websites. 144 on desktop vs. 110 on mobile, over two times higher than the median! This may be because of the use of mega-menus on larger sites that generally have more pages.

{{ figure_markup(
   image="outgoing-external-links.png",
   caption="External links from homepages.",
   description="Bar chart showing the number of external links on homepages by percentile (10, 25, 50, 75, 90). The median desktop homepage had 7 external links compared to 6 external links on mobile. There were more external links on desktop homepages at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=876769621&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

External links are links from one website to a different site. The data again shows fewer external links on the mobile versions of the pages.

The numbers are nearly identical to 2020. Despite Google rolling out mobile first indexing this year, websites have not brought their mobile versions to parity with their desktop versions.

### Text and image links

{{ figure_markup(
   image="text-links.png",
   caption="Text links from homepages.",
   description="Bar chart showing the number of text links per percentile (10, 25, 50, 75, and 90). The median page contained 69 text links on desktop and 63 text links on mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1700739999&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

{{ figure_markup(
   image="image-links.png",
   caption="Image links from homepages.",
   description="Bar chart showing the number of image links per percentile (10, 25, 50, 75, and 90). The median web page contained 7 image links on desktop and 6 image links on mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1217720785&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

While a significant portion of links on the web are text based, a portion also link images to other pages. 9.2% of links on desktop pages and 8.7% of links on mobile pages are image links. With image links, the `alt` attributes set for the image act as anchor text to provide additional context on what the pages are about.

### Link attributes

In September of 2019, Google <a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">introduced attributes</a> that allow publishers to classify links as being _sponsored_ or _user-generated content_. These attributes are in addition to `rel=nofollow` which was previously <a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">introduced in 2005</a>. The new attributes, `rel=ug`c and `rel=sponsored`, add additional information to the links.

{{ figure_markup(
   image="rel-attibute-usage.png",
   caption="Rel attribute usage.",
   description="Bar chart showing the usage (in percent) of rel attributes on desktop and mobile. Our data found that that 29.2% of homepages featured nofollow attributes on their desktop version and 30.7% on mobile. Rel=noopener was featured on 31.6% of desktop pages and 30.1% on mobile. Rel=noreferrer was featured on 15.8% of desktop pages and 14.8% of mobile. Rel=dofollow, Rel=ugc, Rel=sponsored, and Rel=follow were all featured on fewer than 1% of desktop and mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1672151299&format=interactive",
   sheets_gid="1936997045",
   sql_file="anchor-rel-attribute-usage.sql"
   )
}}

The new attributes are still fairly rare, at least on homepages, with `rel="ugc"` appearing on 0.4% of mobile pages and `rel="sponsored"` appearing on 0.3% of mobile pages. It's likely these attributes are seeing more adoption on pages that aren't homepages.

`rel="follow"` and `rel=dofollow` appear on more pages than `rel="ugc"` and `rel="sponsored"`. While this is not a problem, Google ignores `rel="follow"` and `rel="dofollow"` because they aren't official attributes.

`rel="nofollow"` was found on 30.7% of mobile pages, similar to last year. With the attribute used so much, it's no surprise that Google has changed `nofollow` to a hint—which means they can choose whether or not they respect it.

## Accelerated Mobile Pages (AMP)

2021 saw major changes in the Accelerated Mobile Pages (AMP) ecosystem. AMP is <a hreflang="en" href="https://developers.google.com/search/blog/2021/04/more-details-page-experience#details">no longer required for the Top Pages carousel, no longer required for the Google News app, and Google will no longer show the AMP logo next to AMP results in the SERP</a>.

{{ figure_markup(
   image="amp-markup-types.png",
   caption="AMP attribute usage.",
   description="Bar chart showing the percent of pages with AMP markup types. The Amp attribute was present on 0.09% of desktop and 0.22% of mobile pages. The Amp & Emjoi attribute was present on 0.02% of desktop and 0.04% of mobile pages. The Amp or Emjoi attribute was used on 0.10% of desktop and 0.26% of mobile pages. Lastly, the Rel Amp Tag was used on 0.82% of desktop pages and 0.75% of mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1787667985&format=interactive",
   sheets_gid="718210755",
   sql_file="markup-stats.sql"
   )
}}

However, AMP adoption continued to increase in 2021. 0.09% of desktop pages now include the AMP attribute vs 0.22% for mobile pages. This is up from 0.06% on desktop pages and 0.15% on mobile pages in 2020.

## Internationalization

<figure>
  <blockquote>If you have multiple versions of a page for different languages or regions, tell Google about these different variations. Doing so will help Google Search point users to the most appropriate version of your page by language or region.</blockquote>
  <figcaption>— <cite><a hreflang="en" href="hhttps://developers.google.com/search/docs/advanced/crawling/localized-versions">Google SEO documentation</a></cite></figcaption>
</figure>

To let search engines know about localized versions of your pages, use `hreflang` tags. `hreflang` attributes are also used by <a hreflang="en" href="https://yandex.com/support/webmaster/yandex-indexing/locale-pages.html">Yandex</a> and Bing ([to some extent](https://twitter.com/facan/status/1304120691172601856)).

{{ figure_markup(
   image="hreflang-usage.png",
   caption="Top hreflang tag attributes chart.",
   description="Horizontal bar chart showing hreflang usage. The most popular hreflang attribute was `en` (English version) and hreflang attributes (across all languages) were implemented on less than 5% of desktop and mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1149395895&format=interactive",
   sheets_gid="866829014",
   sql_file="hreflang-link-tag-usage.sql",
   width=600,
   height=546
   )
}}

9.0% of desktop pages and 8.4% of mobile pages use the hreflang attribute.

There are three ways of implementing `hreflang` information: in HTML `<head>` elements, `X-robots` headers, and with XML sitemaps. This data does not include data for XML sitemaps.

The most popular hreflang attribute is `"en"` (English version). 4.75% of mobile homepages use it and 5.32% of desktop homepages.

`x-default` (also called the fallback version) is used in 2.56% of cases on mobile. Other popular languages addressed by `hreflang` attributes are French and Spanish.

For Bing, [`hreflang` is a "far weaker signal" than the `content-language` header](https://twitter.com/facan/status/1304120691172601856).

As with many other SEO parameters, [`content-language`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language) has multiple implementation methods including:

1. HTTP server response
2. HTML tag

{{ figure_markup(
   image="language-usage-html-http.png",
   caption="Language usage (HTML and HTTP header).",
   description="Horizontal bar chart showing percent of pages with language usage (HTML and HTTP header).",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2048466165&format=interactive",
   sheets_gid="933228304",
   sql_file="content-language-usage.sql",
   width=600,
   height=529
   )
}}

Using an HTTP server response is the most popular way of implementing `content-language`. 8.7% of websites use it on desktop while 9.3% on mobile.

Using the HTML tag is less popular, with content-language appearing on just 3.3% of mobile websites.

## Conclusion

Websites are slowly improving from an SEO perspective. Likely due to a combination of websites improving their SEO and the platforms hosting websites also improving. The web is a big and messy place so there's still a lot to do, but it's nice to see consistent progress.
