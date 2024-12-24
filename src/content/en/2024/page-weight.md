---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: Page Weight chapter of the 2024 Web Almanac covering why page weight matters, bandwidth, complex pages, page weight over time, page requests, and file formats.
hero_alt: Hero image of Web Almanac characters using a set of scales to weigh a web page against variuos boxes labelled with various different kilobytes.
authors: [dwsmart, fellowhuman1101]
reviewers: []
editors: [montsec]
analysts: [burakguneli]
translators: []
results: https://docs.google.com/spreadsheets/d/1GHTFwsjJokf1U5dZmDg-7bBlH_Lu-rlOHVmmzTj0D98/
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

The internet is growing at a rapid pace. Each new page brings with it a bespoke set of resources necessary to render its content, which is expensive as more computing resources are required. These bandwidth requests are competing with the computing resources of generative AI initiatives.

In the United States, the rapidly growing AI demand is poised to drive data center energy consumption to about [6% of the nation's total electricity usage in 2026](https://hbr.org/2024/07/the-uneven-distribution-of-ais-environmental-impacts), adding further pressure on grid infrastructures and highlighting the urgent need for sustainable solutions to support continued AI advancement.

These generative AI initiatives will in turn rapidly increase the size of the web. [Statista estimates 149 zettabytes](https://www.statista.com/statistics/871513/worldwide-data-created/) of internet content were created in 2024\. In comparison, the years from 2010 to 2018 produced a combined 127.5 zettabytes.

In short, resources are becoming increasingly scare and expensive.With Google now prioritising on-page elements, addressing the issue of page weight has become important. Reducing unnecessary bloat in websites not only enhances user experience and boosts conversions, but also supports sustainability efforts.

As highlighted in discussions about web performance in 2024, heavy websites contribute to inequalities in user access and responsiveness, particularly on lower-end devices, widening the "performance inequality gap."

Alex Russel's series, [The Performance Inequality Gap](https://infrequently.org/2024/01/performance-inequality-gap-2024/) bring into sharp focus that some of the assumptions that are made on current device performance and capabilities may not be true, and that whilst that devices might be getting more and more powerful, that's not true for everyone, and there's a long tail of users who are negatively impacted by web pages with large payloads.

This growing disparity emphasizes the importance of lightweight, efficient web design to ensure equitable access and engagement for all users.

Page weight matters, whether you're experiencing a weak network connection at an inopportune moment or live in a market where access to the internet is charged by the megabyte, inflated page weight decreases the availability of information.

## What is page weight?

Page weight is the byte size of a web page. The web has evolved massively since its birth, and page weight in 2024 isn't just the HTML from the URL you arrive at. In nearly all cases, it involves the assets needed to load and display that page. Those assets include the following:

- The [HTML](https://almanac.httparchive.org/en/2024/markup) that comes in the initial response from a server.
- [Images and other media (video, audio, etc)](https://almanac.httparchive.org/en/2024/media) that are embedded into the page.
- [Cascading Style Sheets (CSS)](https://almanac.httparchive.org/en/2024/css) for styling the page.
- [JavaScript](https://almanac.httparchive.org/en/2022/javascript) to provide interactivity and functionality.
- [Third-Party resources](https://almanac.httparchive.org/en/2024/third-parties), which can be one or more of the above, from other providers.

Every extra thing added to a web page increases the overall page weight, and every bit ultimately means more work and overhead for the browser in transmitting it across the network, processing, parsing and ultimately rendering and painting it on the screen for the user to consume and interact with.

Some forms of resources carry even greater overheads, especially JavaScript, which also needs to be compiled and executed. This also has a knock on effect on both sustainability and conversion rates. The heavier a page is, the more carbon emissions and the least possibility of conversions on that page.

The larger the page weight, the higher the impact it can have on carbon emissions, something covered in the [Sustainability chapter](https://almanac.httparchive.org/en/2024/sustainability).

There are various mitigations available to help manage page weight, and its overall effect on load times, but the stark reality is that more weight is always going to involve more work.

The weight effects can be divided into three main categories: storage, transmission, and rendering.

### Storage

Every byte of a web page needs to be stored somewhere, and with the nature of how the web works, that usually means being stored in multiple locations

It starts with the web server itself. Pure storage space remains relatively small in cost per Gigabyte, depending on the type of storage. For example, Google's cloud storage is somewhere between [$0.02 & $0.03 per month in North America](https://cloud.google.com/storage/pricing#north-america) or $0.006 and $0.025 in Europe.

Resources stored in memory on a webserver versus on disk for faster access will ramp up in cost far faster than one that lives on disk.

There can be multiple copies of the same resource too, spread across a number of intermediate caches, and even spread across multiple data centers if a CDN when edge caching is employed.

The second part of the equation is these resources also need to be stored on the user's device when they access a page. Lower-end devices, particularly mobile ones, may be far more restricted as to how much they can hold. Pushing large payloads can overwhelm storage capacity, pushing other valuable resources to be purged from the cache. This can lead to additional costs and performance hits when navigating to a new page that would have reused those resources.

The best way to optimize the transmission of resources is serving small resources. In case that is difficult to achieve, using preconnect, preload and Priority Hints can help with managing the order resources are loaded on page.

### Transmission

The first time you visit a site, all the resources need to be delivered across the internet to your device. Subsequent visits to the same URL, or even other URLs on the same site, might mean that some of the resources can be used from cache, but a significant amount might still need to be retrieved again across the network.

Not all network connections are equal everywhere, it could be a super-fast broadband connection with generous data limits, or it could be a metered, capped slow mobile connection.

So, it is best to think strategically. The bigger the page weight, the longer the transmission of resources will take, and those with slower mobile connections or low data limits will be hit the hardest, which may also affect business.

### Rendering

Before a browser can paint the URL requested onto someone's screen, it needs to gather and process those resources.

The greater the page weight, the longer it will take a browser to get and process all the parts needed, delaying the point where users can read and interact with the page.

Even after loading, excessive page weight can make a page slow to respond to interaction, as the browser is bogged down shuffling large resources.

### Page weight is an accessibility issue

Large page weight disproportionately affects users who cannot afford top end devices, and fast, high data usage cap connections.

Bloated pages mean that people without access to these have a more expensive, less performant experience of the web, and in extreme cases might even make a page practically unusable.

## Page weight by the numbers

The internet blossomed from a place of bare text to the rich, interactive landscape we know today by introducing new content types. Images introduced visual depth, Javascript enabled interactivity, and videos introduced new ways of storytelling.

Each of these technologies also brought more weight to their pages. Before the introduction of HTML 2.0 in 1995, the only asset to weight was HTML, Page weight dramatically increased when [RFC 1866](https://www.rfc-editor.org/rfc/rfc1866) introduced the `<img>` tag, In 1996, JavaScript stepped on the scale followed by libraries like JQuery a decade later, The first widely recognized single-application framework emerged in 2010 opening the door for JavaScript frameworks like Angular, React, Vue and others to come to market.

Each evolution of page functionality brings with it more weight and file types intended to improve performance while retaining functionality.

We have analyzed common file types, their occurrence and response size to better understand their application. This includes comparisons by device and page type.

### File type requests for the median page

To understand the file types associated with page weight, we should look at file type requests for the 50th percentile of pages. This provides a baseline for the impact of each file type overall.

{{ figure_markup(
  image="number-of-requests-by-content-and-device-type.png",
  caption="Median number of requests by content type and device type.",
  description="Bar chart showing the median number of requests by content type and device type. The median desktop page loads 2 HTML files, 4 font files, 8 CSS files, 18 images and 24 JavaScript files, and 71 in total. The median mobile page loads 2 HTML files, 3 font files, 8 CSS files, 16 images, 22 JavaScript files and 66 requests in total.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1656379757&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

The total number of requests for desktop pages decreased by 9%, down to 71 from 2022's 76 requests per page. Similarly, mobile decreased from 70 to 66 requests. The count of image file types decreased by 43% in 2024

Desktop pages requested 18 in 2024 compared to 25 in 2024.

Javascript overtook images as the most requested file type. The median page requested 24 Javascript resources on desktop pages. Mobile saw 22 requests.

{{ figure_markup(
  image="number-of-requests-by-content-and-page-type.png",
  caption="Median number of requests by content type and page type.",
  description="Bar chart showing the median number of requests by content type and page type. The median homepage loads 2 HTML files, 4 font files, 7 CSS files, 20 images and 23 JavaScript files. The median inner page loads 2 HTML files, 4 font files, 8 CSS files, 14 images and 22 JavaScript files.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=513546724&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

As we begin dissecting behavior patterns for page weight, it is important to note the impact of inner pages. Throughout this chapter, you will find strong variances that are only visible when homepages are compared to inner pages.

This is noteworthy as our new data will change device type comparisons due to the significant variances. With this in mind, we have also included comparisons filtered to homepages for a more accurate measure to 2022's data set.

### Requests volume

Each request a page makes is a component needed to create the intended experience and content it provides. The total number of requests, the number of pieces needed to complete the build, impacts page performance.

Modern browsers are multi-threaded and multi-process. This means they can utilize multiple threads and processes to handle different tasks, including network requests. Each request requires resources to execute, and due to their technical limitations, only a limited number of requests can be completed simultaneously. Like humans, browsers can only do a limited number of things at once.

With this knowledge, the number of requests impacts both page weight and perceived performance.

{{ figure_markup(
  image="distribution-of-requests-by-device-type.png",
  caption="Distribution of requests by device type.",
  description="Bar chart showing the distribution of requests by device type and percentile. The 10th percentile desktop page loads 24 requests & mobile 22, the 25th 42 requests on desktop & mobile 39, the 50th 71 requests on desktop & 66 on mobile, the 75th 115 requests on desktop, 109 on mobile, and the 90th 176 requests on desktop, 170 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1595667871&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

The median page makes 71 requests on desktop and 66 on mobile. These numbers include both home and inner pages. When compared to the 2022 distribution, all percentiles show a decrease in the total number of files.

{{ figure_markup(
  image="distribution-of-requests-by-page-type.png",
  caption="Distribution of requests by page type.",
  description="Bar chart showing the distribution of requests by page type and percentile. At the 10th percentile homepages page load 22 requests & inner pages 23, at the 25th 42 requests for homepages & inner pages 39, the 50th 72 requests on homepages & 65 on inner pages, the 75th 117 requests on homepages, 107 on inner pages, and the 90th 180 requests on homepages, 166 on inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1854762675&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

The lower all over numbers are impacted by the consistently lower number of requests made by inner pages when compared to homepages. The median homepage calls 72 resources while its inner counterpart requires only 65.

{{ figure_markup(
  image="distribution-of-requests-by-homepages-by-device-type.png",
  caption="Distribution of requests by homepages by device type.",
  description="Bar chart showing the distribution of requests for homepages by device type and percentile. The 10th percentile desktop page loads 23 requests & mobile 21, the 25th 43 requests on desktop & mobile 40, the 50th 74 requests on desktop & 70 on mobile, the 75th 120 requests on desktop, 114 on mobile, and the 90th 182 requests on desktop, 177 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=728818282&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

## Page weight and Core Web Vitals

To gather data, we had to rely on lighthouse's lab testing audits, which capture LCP and CLS, but not the interaction based metrics of INP or FID. Lab testing does have draw backs, and real user metrics should always be used to truly assess performance, as detailed in web.dev's [Why lab and field data can be different (and what to do about it)](https://web.dev/articles/lab-and-field-data-differences).

We used data from June 2024, the page weights for each percentile and device type are as follows:

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Desktop Page Weight</th>
        <th>Mobile Page Weight</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10th</td>
        <td class="numeric">549 KB</td>
        <td class="numeric">471 KB</td>
      </tr>
      <tr>
        <td>25th</td>
        <td class="numeric">1,138 KB</td>
        <td class="numeric">995 KB</td>
      </tr>
      <tr>
        <td>50th</td>
        <td class="numeric">2,157 KB</td>
        <td class="numeric">1,938 KB</td>
      </tr>
      <tr>
        <td>75th</td>
        <td class="numeric">4,169 KB</td>
        <td class="numeric">3,766 KB</td>
      </tr>
      <tr>
        <td>90th</td>
        <td class="numeric">8,375 KB</td>
        <td class="numeric">7,680 KB</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Pecentile page weight by device from Lighthouse tests.",
      sheets_gid="2030864989",
      sql_file="page_weight_trend.sql",
    ) }}
  </figcaption>
</figure>

### Largest Contentful Paint (LCP)

A good score for largest contentful paint is 2.5 seconds or less. LCP over 4 seconds is considered poor.

{{ figure_markup(
  image="lcp-distribution-by-page-weight.png",
  caption="Distribution of LCP scores by device type and page weight",
  description="Column chart of the distribution of LCP scores by percentile. For desktop it is 1.1 second at the 10th percentile, 1.6 s at the 25th percentile, 12.5 s at the median, 3.9 s at the 75th percentile and 6.4 s at the 90th percentile. For mobile it was 2.7 s, 3/9 s, 6 s, 10.5 s and 18 s respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=73621248&format=interactive",
  sheets_gid="2030864989",
  sql_file="page_weight_trend.sql"
  )
}}

There is a clear correlation between the page weight and largest contentful paint, the higher the page weight, the longer the time to LCP. This is especially true for mobile devices with a much steeper curve.

### Cumulative Layout Shift (CLS)

A good score for cumulative layout shift is 0.1 or less. CLS over 0.25 is considered poor. On consideration to keep in mind when looking at this particular metric is it is especially affected by differences in lab and field data, as CLS is effectively measured across the whole life of a page, including interactions and scrolling, where lab tests can only capture the initial load.

{{ figure_markup(
  image="cls-distribution-by-page-weight.png",
  caption="Distribution of CLS scores by device type and page weight",
  description="Column chart of the distribution of CLSscores by percentile. For desktop it is 0 at the 10th percentile, 0 at the 25th percentile, 0.01 at the median,0.06 at the 75th percentile and 0.23 s at the 90th percentile. For mobile it was 0, 0, 0.02, 0.11 and 0.31 respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=822364055&format=interactive",
  sheets_gid="2030864989",
  sql_file="page_weight_trend.sql"
  )
}}