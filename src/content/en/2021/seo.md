---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: SEO chapter of the 2021 Web Almanac covering crawlability, indexability, page experience, on-page SEO, links, AMP, internationalization, and more.
authors: [patrickstox, Tomek3c, wrttnwrd]
reviewers: [fili, SeoRobt, fellowhuman1101]
analysts: [jroakes, rvth]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/11hw7zg4dpIY8XbQR5bNp5LvwbaQF0TjV0X5cK0ng8Bg/
patrickstox_bio: Patrick is Product Advisor, Technical SEO, and Brand Ambassador at <a hreflang="en" href="https://ahrefs.com/">Ahrefs</a>. He's an organizer for the <a hreflang="en" href="https://www.meetup.com/RaleighSEO/">Raleigh SEO Meetup</a> (the most successful SEO Meetup in the US), the <a hreflang="en" href="https://www.meetup.com/beerandseo/">Beer and SEO Meetup</a>, and the <a hreflang="en" href="https://raleighseomeetup.org/conference/">Raleigh SEO Conference</a>. He also runs a Technical SEO Slack group and is a moderator for <a hreflang="en" href="https://www.reddit.com/r/TechSEO">/r/TechSEO on Reddit</a>. Patrick also likes to share random SEO knowledge in Twitter threads he calls Uncommon SEO Knowledge. He's a well known conference speaker, industry blogger (mostly on the <a hreflang="en" href="https://ahrefs.com/blog/">Ahref's blog</a> these days), judge of search awards, and he helped define the role of Search Marketing Strategist for the US Department of Labor.
Tomek3c_bio: Tomek is the Head of Research and Development at <a hreflang="en" href="http://onely.com/">Onely</a>. He's also building <a hreflang="en" href="https://www.ziptie.dev/">ZipTie</a>, a product aiming to help website owners get more content indexed by Google.
In his spare time, he enjoys hiking and playing poker.
wrttnwrd_bio: Ian founded Portent, a digital marketing agency, in 1995, and sold it to Clearlink in 2017. He's now on his own, consulting for brands he loves and speaking at conferences that provide Diet Coke. He's also trying to become a professional Dungeons & Dragons player, but it hasn't panned out.
You can find him pedaling his bike up Seattle's ridiculous hills.
featured_quote: SEO is more popular than ever and has seen huge growth over the last couple years as companies sought new ways to reach customers. SEO's popularity has far outpaced other digital channels.
featured_stat_1: 16.5%
featured_stat_label_1: Websites that don't have a robots.txt file
featured_stat_2: 41.5%
featured_stat_label_2: Mobile pages without a canonical tag
featured_stat_3: 67%
featured_stat_label_3: Mobile websites failing Core Web Vitals checks
unedited: true
---

## Introduction

SEO (Search Engine Optimization) is the practice of optimizing a website or webpage to increase the quantity and quality of its traffic from a search engine's organic results.

SEO is more popular than ever and has seen huge growth over the last couple years as companies sought new ways to reach customers. SEO's popularity has far outpaced other digital channels.

{{ figure_markup(
   image="seo-term-trends.png",
   caption="Google Trends comparison of SEO versus pay-per-click, social media marketing, and email marketing.",
   description="Screenshot showing...",
   width=1155,
   height=605
   )
}}

The purpose of the SEO chapter of the Web Almanac is to analyze various elements related to optimizing a website. In this chapter, we'll check if websites are providing a great experience for users and search engines.

Many sources of data were used for our analysis including [Lighthouse](https://developers.google.com/web/tools/lighthouse/), the [Chrome User Experience Report (CrUX)](https://developers.google.com/web/tools/chrome-user-experience-report), as well as raw and rendered HTML elements from the [HTTP Archive](https://httparchive.org/) on mobile and desktop. In the case of the HTTP Archive and Lighthouse, it is limited to the data identified from websites' homepages only, not site-wide crawls. Keep that in mind when drawing conclusions from our results. You can learn more about the analysis on our [Methodology](https://almanac.httparchive.org/en/2020/methodology) page.

Read on to find out more about the current state of the web and its search engine friendliness.

## Crawlability and Indexability

To return relevant results to these user queries, search engines have to create an index of the web. The process for that involves:

1. **Crawling** - search engines use web crawlers, or spiders, to visit pages on the internet. They find new pages through sources such as sitemaps or links between pages.
2. **Processing** - in this step search engines may render the content of the pages. They will extract information they need like content and links that they will use to build and update their index, rank pages, and discover new content.
3. **Indexing** - Pages that meet certain indexability requirements around content quality and uniqueness will typically be indexed. These indexed pages are eligible to be returned for user queries.

Let's look at some issues that may impact crawlability and indexability.

### `robots.txt`

`robots.txt` is a file located in the root folder of each subdomain on a website that tells robots such as search engine crawlers where they can and can't go.

81.89% of websites make use of the robots.txt file (mobile). Compared with previous years (72.16% in 2019 and 80.46% in 2020), that's a slight improvement.

Having a robots.txt is not a requirement. If it's returning 404 not found, Google assumes that every page on a website can be crawled. Other search engines may treat this differently.

Using robots.txt allows website owners to control search engine robots. However, the data showed that as much as 16.51% of websites have no robots.txt file (mobile version check).

{{ figure_markup(
   image="robots-txt-status-codes.png",
   caption="Breakdown of robots.txt status codes.",
   description="Bar chart showing percent of pages with a valid robots.txt file. Status code 200 was present on 81.9% of mobile sites, status code 404 was present on 16.5% of mobile sites. The other status codes are barely used and desktop numbers are almost identical to mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2062029998&format=interactive",
   sheets_gid="91318795",
   sql_file="robots-txt-status-codes.sql"
   )
}}

Websites may have misconfigured robots.txt files. For example, some popular websites were mistakenly blocking search engines. Google may keep these websites indexed for a period of time, but eventually their visibility in search results will be lessened.

Another category of errors related to robots.txt is accessibility and/or network errors, meaning the robots.txt exists but cannot be accessed. If Google requests a robots.txt file and gets such an error, the bot may stop requesting pages for a while. The logic behind this is that search engines are unsure if a given page can or can not be crawled, so it waits until robots.txt becomes accessible.

~0.3% of websites in our dataset returned either 403 Forbidden or 5xx. Different bots may see different errors or restrictions, so we don't know exactly what Googlebot may have seen.

The latest information available from Google is from 2019. [According to Google's data](https://www.youtube.com/watch?v=JvYh1oe5Zx0&amp;t=315s), as much as 5% of websites were temporarily returning 5xx on robots.txt, while as much as 26% were unreachable.

{{ figure_markup(
   image="robots-usage-presentation.png",
   caption="Breakdown of robots.txt status codes Googlebot encountered.",
   description="Screenshot showing...",
   width=609,
   height=313
   )
}}

Two things may cause the discrepancy between the HTTP Archive and Google data:

1. Google presents data from 2 years back while the HTTP Archive is based on recent information, or

2. The HTTP Archive focuses on websites that are popular enough to be included in the CrUX data, while Google tries to visit all known websites.

### `robots.txt` size

Most robots.txt files are fairly small, weighing between 0-100 kb. However, we did find over 3,000 domains that have a robots.txt file size over 500 KiB which is beyond Google's max limit. Rules after this size limit will be ignored.

{{ figure_markup(
   image="robots-txt-size-distribution.png",
   caption="`robots.txt` size distribution.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1491943936&format=interactive",
   sheets_gid="1066408164",
   sql_file="robots-text-size.sql"
   )
}}

You can declare a rule for all robots or specify a rule for specific robots. Bots usually try to follow the most specific rule for their user-agents. "Disallow: Googlebot" will refer to Googlebot only, while `Disallow: *` will refer to all bots that don't have a more specific rule.

We saw two popular SEO related robots: mj12bot (Majestic) and ahrefsbot (Ahrefs) in the top 5 most specified user agents.

{{ figure_markup(
   image="robots-txt-user-agent.png",
   caption="`robots.txt` user-agent usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1206728832&format=interactive",
   sheets_gid="964313002",
   sql_file="robots-txt-user-agent-usage.sql"
   )
}}

### `robots.txt` search engine breakdown

When looking at rules applying to particular search engines, Googlebot was the most referenced appearing on 3.27% of crawled websites.

Robots rules related to other search engines, such as Bing, Baidu, and Yandex, are less popular (respectively 2.49%, 1.91%, and 0.51%). We did not look at what rules were applied to these bots.

<figure>
  <table>
    <thead>
      <tr>
        <th><strong>User-agent</strong></th>
        <th><strong>Desktop</strong></th>
        <th><strong>Mobile</strong></th>
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


### Canonical tags

The World Wide Web is a massive set of documents, some of which are duplicates. To prevent duplicate content issues, webmasters can use canonical tags to tell search engines which version they prefer to be indexed. Canonicals also help to [consolidate signals such as links to the ranking page](https://www.example.com/dresses/green/greendress.html).

The data shows increased adoption of canonical tags over the years. For example, 2019's edition shows that 48.34% of mobile pages were using a canonical tag. In 2020's edition, the percentage grew to 53.61%, and in 2021 we see 58.5%.

{{ figure_markup(
   image="canonical-tag-usage.png",
   caption="Canonical tag usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=118545040&format=interactive",
   sheets_gid="1066408164",
   sql_file="pages-canonical-stats.sql"
   )
}}

More mobile pages have canonicals set than their desktop counterparts. In addition, 8.3% of mobile pages and 4.3% of desktop pages are canonicalized to another page so that they provide a clear hint to Google and other search engines that the page indicated in the canonical tag is the one that should be indexed.

A higher number of canonicalized pages on mobile seems to be related to websites using [separate mobile URLs](https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls). In these cases, Google recommends placing a rel="canonical" tag pointing to the corresponding desktop URLs.

Our dataset and analysis is limited to homepages of websites; the data is likely to be different when considering all URLs on the tested websites.

#### Two methods of implementing canonical tags

When implementing canonicals, there are two methods to specify canonical tags:

1. In the HTML's `<head>` section of a page
2. In the HTTP headers (this method is also called: "X-robots-tag")

{{ figure_markup(
   image="canonical-raw-rendered-usage.png",
   caption="Canonical raw versus rendered usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1288519273&format=interactive",
   sheets_gid="1066408164",
   sql_file="pages-canonical-stats.sql"
   )
}}

Implementing canonical tags in the `<head>` of a HTML page is much more popular than using the X-robots tag method. Implementing the tag in the head section is generally considered easier.

#### Conflicting canonical tags

Sometimes pages contain more than one canonical tag. When there are conflicting signals like this, search engines will have to figure it out. One of Google's Search Advocates, [Martin Splitt, once said it causes undefined behavior](https://www.youtube.com/watch?v=bAE3L1E1Fmk&amp;t=772s) on Google's end.

As much as 1.3% of mobile pages have different canonical tags in the initial HTML and the rendered version.

The Web Almanac 2020 Report noted that "A similar conflict can be found with the different implementation methods, with 0.15% of the mobile pages and 0.17% of the desktop ones showing conflicts between the canonical tags implemented via their HTTP headers and HTML head."

This year's data is even more worrisome. Pages are sending conflicting signals in 0.4% of cases.

As the Web Almanac data relies on homepages, there may be additional problems with pages located deeper in the architecture. The data also doesn't include situations where more than one canonical tag appears with a single method.

## Page Experience

2021 saw an increased focus on user experience. Google launched the Page Experience Update which included existing signals, such as HTTPS and mobile friendliness, and new speed metrics called Core Web Vitals.

### HTTPS

Adoption of HTTPS is still increasing. HTTPS was the default on 81.17% of mobile pages and 84.29% of desktop pages. That's up nearly 8% on mobile websites and 7% on Desktop websites year over year.

{{ figure_markup(
   image="usage-of-https.png",
   caption="Percentage of Desktop and Mobile pages served with HTTPS..",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1826599611&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

### Mobile-Friendliness

There's a slight uptick in mobile-friendliness this year. Responsive design implementations have increased while dynamic serving has remained relatively flat.

Responsive design sends the same code and adjusts how the website is displayed based on the screen size, while dynamic serving will send different code depending on the device. The viewport meta tag was used to identify responsive websites vs the Vary: User-Agent header to identify websites using dynamic serving.

 91.06% of mobile pages include the viewport meta tag, up from 89.16% in 2020. 86.44% of desktop pages also included the viewport meta tag, up from 83.82% in 2020.

{{ figure_markup(
   image="vary-usage-agent-header-usage.png",
   caption="`Vary: User-Agent` header usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1985736287&format=interactive",
   sheets_gid="478009067",
   sql_file="html-response-vary-header-used.sql"
   )
}}

For the Vary: User-Agent header, the numbers were pretty much unchanged with 12.6% of desktop pages and 13.4% of mobile pages with this footprint.

One of the biggest reasons for failing mobile-friendliness was that 13.5% of pages did not use a legible font size. Meaning 60% or more of the text had a font size smaller than 12px which can be hard to read on mobile.

### Core Web Vitals

Core Web Vitals are the new speed metrics that are part of Google's Page Experience signals. The metrics measure visual load with Largest Contentful Paint (LCP), visual stability with Cumulative Layout Shift (CLS), and interactivity with First Input Delay (FID).

The data comes from the Chrome User Experience Report (CrUX), which records real-world data from opted-in Chrome users.

33% of mobile websites are now passing Core Web Vitals thresholds, up from 20% last year. Most websites are passing FID but website owners seem to be struggling to improve CLS and LCP.

{{ figure_markup(
   image="core-web-vitals-trend.png",
   caption="Core web vitals metrics trend.",
   description="Line chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1693723951&format=interactive",
   sheets_gid="460991760",
   sql_file="sql.sql"
   )
}}

{# TODO SQL file location #}

See the [Performance](./performance) chapter for more on this topic.

## On-Page

Search engines look at your page's content to determine whether it's a relevant result for the search query. Other on-page elements may also impact rankings or appearance on the search engines.

### Metadata

Metadata includes `<title>` elements and `<meta name="description">` tags. Metadata can directly and/or indirectly affect SEO performance. See the next sections for specifics about each tag.

In 2021, 98.77% of desktop and mobile pages had `<title>` elements. 71.1% of desktop and mobile pages had `<meta name="description">` tags.

{{ figure_markup(
   image="title-meta-description-usage.png",
   caption="Breakdown of title and meta description usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=541272297&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

### `<title>` Element

The `<title>` element is an on-page ranking factor that provides a strong hint regarding page relevance and may appear on the SERP. In August 2021 [Google started re-writing more titles in their search results](https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles).

In 2021:

- The median page `<title>` contained 6 words.
- The median page `<title>` contained 39 and 40 characters on desktop and mobile, respectively.
- 10% of pages had `<title>` elements containing 12 words.
- 10% of desktop and mobile pages had `<title>` elements containing 74 and 75 characters, respectively.

Most of these stats are relatively unchanged since last year.

{{ figure_markup(
   image="title-word-counts.png",
   caption="Number of words used in title elements.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2017837375&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

{{ figure_markup(
   image="title-character-counts.png",
   caption="Number of characters used in title elements.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1099454676&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

### Meta Description Tag

The `<meta name="description>` tag does not directly impact rankings. However, it may appear as the page description on the SERP.

In 2021:

- The median desktop and mobile page `<meta name="description>` tag contained 20 and 19 words, respectively.
- The median desktop and mobile page `<meta name="description>` tag contained 138 and 127 characters, respectively.
- 10% of desktop and mobile pages had `<meta name="description>` tags containing 35 words.
- 10% of desktop and mobile pages had `<meta name="description>` tags containing 232 and 231 characters, respectively.

These numbers are relatively unchanged from last year.

{{ figure_markup(
   image="meta-word-counts.png",
   caption="Number of words used in meta descriptions.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2013621429&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

{{ figure_markup(
   image="meta-character-counts.png",
   caption="Number of characters used in meta descriptions.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=971210715&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

### Images

Images can directly and indirectly impact SEO as they impact image search rankings and page performance.

- 10% of pages have two or fewer `<img>` tags. That's true of both desktop and mobile.
- The median desktop page has 21 `<img>` tags while the median mobile page has 19 `<img>` tags.
- 10% of desktop pages have 83 or more `<img>` tags. 10% of mobile pages have 73 or more `<img>` tags.

These numbers have changed very little since 2020.

{{ figure_markup(
   image="number-of-images-per-page.png",
   caption="Number of images on each page.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1314615789&format=interactive",
   sheets_gid="1483073708",
   sql_file="image-alt-stats.sql"
   )
}}

The `<img>` ALT attribute helps explain image content and impacts [accessibility](https://almanac.httparchive.org/en/2021/accessibility).

Note that missing ALT attributes may not indicate a problem. Pages may include extremely small or blank images which don't require an ALT attribute.

- On the median desktop page, 56.5% of `<img>` tags have an ALT attribute. This is a slight increase versus 2020.
- On the median mobile page, 54.6% of `<img>` tags have an ALT attribute. This is a slight increase versus 2020.
- However, on the median desktop and mobile pages 10.5% and 11.8% of `<img>` tags have blank ALT attributes (respectively). This is effectively the same as 2020.
- On the median desktop and mobile pages there are zero or close to zero `<img>` tags missing ALT attributes. This is an improvement over 2020, when 2-3% of `<img>` tags on median pages were missing ALT attributes.

{{ figure_markup(
   image="images-with-alt-attribute.png",
   caption="Percentage of images that contain `alt` attributes.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1862003290&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

{{ figure_markup(
   image="images-with-blank-alt-attribute.png",
   caption="Percentage of `alt` attributes that were blank.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=198831003&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

{{ figure_markup(
   image="images-with-missing-alt-attribute.png",
   caption="Percentage of images missing alt attributes.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=819909313&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

The image loading property affects how user agents prioritize rendering and display of images on the page. It may impact user experience and page load performance, both of which impact SEO success.

- 5% of pages don't use any image loading property.
- 6% of pages use loading="lazy" which delays loading an image until it is close to being in the viewport.
- 8% of pages use loading="eager" which loads the image as soon as the browser loads the code.
- 1% of pages use invalid loading properties.
- 1% of pages use loading="auto" which uses the default browser loading method.

{{ figure_markup(
   image="image-loading-property-usage.png",
   caption="Image loading property usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1305654777&format=interactive",
   sheets_gid="55531578",
   sql_file="image-loading-property-usage.sql"
   )
}}

### Word Count

The number of words on a page isn't a ranking factor, but the _way_ pages deliver words can profoundly impact rankings. Words can be in the raw page code or the rendered content.

First, rendered page content: "Rendered" is the content of the page after the browser has executed all Javascript and any other code that modified the DOM or CSSOM.

- The median _rendered_ desktop page contains 425 words, versus 402 words in 2020.
- The median _rendered_ mobile page contains 367 words, versus 348 words in 2020.
- Rendered mobile pages contain 13.6% fewer words than rendered desktop pages. Note that Google is a mobile-only index. Content not on the mobile version may not get indexed.

{{ figure_markup(
   image="visible-rendered-words-percentile.png",
   caption="Visible words rendered by percentile.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=833732027&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

Second, raw page content: "Raw" is the content of the page before the browser has executed Javascript or any other code that modified the DOM or CSSOM. It's the "raw" content delivered and visible in the source code.

- The median _raw_ desktop page contains 369 words, versus 360 words in 2020.
- The median _raw_ mobile page contains 321 words, versus 312 words in 2020.
- Raw mobile pages contain 13.1% fewer words than rendered desktop pages. Note that Google is a mobile-only index. Content not on the mobile HTML version may not get indexed.

{{ figure_markup(
   image="visible-raw-words-percentile.png",
   caption="Visible words raw by percentile.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=58186900&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

Overall, 15% of written content on desktop devices is generated by JavaScript and 14.3% on mobile versions.

### Structured Data

Historically, search engines have worked with unstructured data: the piles of words, paragraphs and other content that comprise the text on a page.

Schema markup and other types of structured data provide search engines another way to parse and organize content. Structured data powers many of [Google's search features](https://developers.google.com/search/docs/advanced/structured-data/search-gallery).

Like words on the page, structured data can be modified with JavaScript.

42.5% of mobile pages and 41.8% of desktop pages have structured data in the HTML. JavaScript modifies the structured data on 4.73% of mobile pages and 4.52% of desktop pages.

On 1.73% of mobile pages and 1.42% of desktop pages structured data is added by JavaScript where it didn't exist in the initial HTML response.

{{ figure_markup(
   image="structured-data-usage.png",
   caption="Structure data usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1924313131&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

#### Most popular structured data formats

There are several ways to include structured data on a page: JSON-LD, microdata, RDFa, and microformats2. JSON-LD is the most popular implementation method. Over 60% of desktop and mobile pages that have structured data implement it with JSON-LD.

Among websites implementing structured data, over 36% of desktop and mobile pages use microdata and less than 3% of pages use RDFa or microformats2.

{{ figure_markup(
   image="structured-data-formats.png",
   caption="Breakdown of structured data formats.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1433352391&format=interactive",
   sheets_gid="1113852331",
   sql_file="structured-data-formats.sql"
   )
}}

Structured data adoption is up a bit since last year. It's used on 33.17% of pages in 2021 vs 30.60% in 2020.

#### Most popular schema types

The most popular schema types found on homepages are WebSite, SearchAction, WebPage. SearchAction is what powers the Sitelinks Search Box.

{{ figure_markup(
   image="most-popular-schema-types.png",
   caption="Most popular schema types.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=242663990&format=interactive",
   sheets_gid="1580260783",
   sql_file="structured-data-schema-types.sql",
   width=600,
   height=532
   )
}}

### `<H>` Elements (Headings)

Heading elements - `<h1>`, `<h2>`, etc. - are an important structural element. While they don't strongly impact rankings, Google's comments regarding "[centerpiece annotation](https://youtu.be/BG56C6XI0YM?t=1730)" imply that the "hint" headings provide clarity about the content.

For main headings, more pages (71.9%) have H2s than have H1s (65.4%). There's no obvious explanation for the discrepancy.

61.4% of desktop and mobile pages use H3s. Less than 39% use H4s.

There was very little difference between desktop and mobile heading usage, nor was there a major change versus 2020.

{{ figure_markup(
   image="heading-element-usage.png",
   caption="Heading element usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1197492338&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

However, a lower percentage of pages include _non-empty_`<h>` elements, particularly H1s. Websites often wrap logo-images in `<H1>` elements on homepages, and this may explain the discrepancy.

{{ figure_markup(
   image="non-empty-heading-element-usage.png",
   caption="Non-empty heading element usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2102902536&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

## Links

Search engines use links to discover new pages and to pass PageRank which helps determine the importance of pages.

On top of PageRank, the text used as a link anchor helps search engines to understand what a page is about. Lighthouse has a test to check if the anchor text used is useful text or if it's generic anchor text like "learn more" or "click here" which aren't very descriptive. 16% of the tested links did not have descriptive anchor text.

### Internal and external links

Internal links are links to other pages on the same site. Pages had less links on the mobile versions compared to the desktop versions.

The data shows that the median number of internal links on desktop is 16% higher mobile, 64 vs 55 respectively. It's likely this is because developers tend to minimize the navigation menu on mobile to make it easier to use.

{{ figure_markup(
   image="outgoing-internal-link.png",
   caption="Internal links from homepages.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1929473622&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

The most popular websites (top 1000 according to CrUX data) have more outgoing internal links than less popular websites. 144 on desktop vs. 110 on mobile, over two times higher than the median! This may be because of the use of mega-menus on larger sites that generally have more pages.

External links are links from one website to a different site. The data shows less external links on the mobile versions of the pages.

{{ figure_markup(
   image="outgoing-external-links.png",
   caption="External links from homepages.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=876769621&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

The numbers are nearly identical to 2020. Despite Google rolling out mobile first indexing this year, websites have not brought their mobile versions to parity with their desktop versions.

### Text and image links

While a significant portion of links on the web are text based, a portion also link images to other pages. 9.2% of links on desktop pages and 8.7% of links on mobile pages are image links. With image links, the alt attributes set for the image act as anchor text to provide additional context on what the pages are about.

{{ figure_markup(
   image="text-links.png",
   caption="Text links from homepages.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1700739999&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

{{ figure_markup(
   image="image-links.png",
   caption="Image links from homepages.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1217720785&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

### Link attributes

In September of 2019, Google [introduced attributes](https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html) that allow publishers to classify links as being sponsored or user generated content. These attributes are in addition to rel=nofollow which was previously [introduced in 2005](https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html). The new attributes, rel=ugc and rel=sponsored, add additional information to the links.

The new attributes are still fairly rare, at least on homepages, with rel=ugc appearing on 0.42% of mobile pages and rel=sponsored appearing on 0.32% of mobile pages. It's likely these attributes are seeing more adoption on pages that aren't homepages.

Rel=follow and rel=dofollow appear on more pages than rel=ugc and rel=sponsored. While this is not a problem, Google ignores rel=follow and rel=dofollow because they aren't official attributes.

Rel=nofollow was found on 30.65% of mobile pages, similar to last year. With the attribute used so much, it's no surprise that Google has changed nofollow to a hint which means they can choose whether or not they respect it.

{{ figure_markup(
   image="rel-attibute-usage.png",
   caption="Rel attribute usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1672151299&format=interactive",
   sheets_gid="1936997045",
   sql_file="anchor-rel-attribute-usage.sql"
   )
}}

## Accelerated Mobile Pages (AMP)

2021 saw major changes in the Accelerated Mobile Pages (AMP) ecosystem. AMP is no longer required for the Top Pages carousel, no longer required for the Google News app, and Google will no longer show the AMP logo next to AMP results in the SERP.

However, AMP adoption continued to increase in 2021. 0.09% of desktop pages now include the AMP attribute vs 0.22% for mobile pages. This is up from 0.06% on desktop pages and 0.15% on mobile pages in 2020.

{{ figure_markup(
   image="amp-markup-types.png",
   caption="AMP attribute usage.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1787667985&format=interactive",
   sheets_gid="718210755",
   sql_file="markup-stats.sql"
   )
}}

## Internationalization

[As Google states in their documentation](https://developers.google.com/search/docs/advanced/crawling/localized-versions), "If you have multiple versions of a page for different languages or regions, tell Google about these different variations. Doing so will help Google Search point users to the most appropriate version of your page by language or region."

To let search engines know about localized versions of your pages, use hreflang tags. Hreflang attributes are also used by [Yandex](https://yandex.com/support/webmaster/yandex-indexing/locale-pages.html) and Bing ([to some extent](https://twitter.com/facan/status/1304120691172601856)).

9% of desktop pages and 8.41% of mobile pages use the hreflang attribute.

There are three ways of implementing hreflang tags (HTML head, X-robots, and XML sitemaps). This data does not include data for XML sitemaps.

The most popular hreflang attribute is "en" (English version). 4.75% of mobile homepages use it and 5.32% of desktop homepages.

X-default (also called the fallback version) is used in 2.56% of cases (mobile). Other popular languages addressed by hreflang attributes are French and Spanish.

{{ figure_markup(
   image="hreflang-usage.png",
   caption="Top hreflang tag attributes chart.",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1149395895&format=interactive",
   sheets_gid="866829014",
   sql_file="hreflang-link-tag-usage.sql",
   width=600,
   height=546
   )
}}

[For Bing, hreflang is a "far weaker signal" than the content-language header.](https://twitter.com/facan/status/1304120691172601856)

As with many other SEO parameters, [content-language](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language) has multiple implementation methods including:

1. HTTP server response
2. HTML tag

Using an HTTP server response is the most popular way of implementing "content-language." 8.73% of websites use it on desktop while 9.32% on mobile.

Using the HTML tag is less popular, with content-language appearing on just 3.27% of mobile websites.

{{ figure_markup(
   image="language-usage-html-http.png",
   caption="Language usage (HTML and HTTP header).",
   description="Bar chart showing ...",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2048466165&format=interactive",
   sheets_gid="933228304",
   sql_file="content-language-usage.sql",
   width=600,
   height=529
   )
}}

## Conclusion

Websites are slowly improving from an SEO perspective. Likely due to a combination of websites improving their SEO and the platforms hosting websites also improving. The web is a big and messy place so there's still a lot to do, but it's nice to see consistent progress.
