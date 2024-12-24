---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: Page Weight chapter of the 2024 Web Almanac covering why page weight matters, bandwidth, complex pages, page weight over time, page requests, and file formats.
hero_alt: Hero image of Web Almanac characters using a set of scales to weigh a web page against variuos boxes labelled with various different kilobytes.
authors: [dwsmart, fellowhuman1101]
reviewers: [ines-akrap]
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

When analyzing only homepages for data congruity, total requests were slightly down in 2024 but consistent with 2022 rates. The median desktop homepage requested 76 resources in 2022 and now requests 74. The mobile median remains unchanged.

### Images

Images are static files that are essential for constructing and displaying web pages. As the web becomes increasingly visual, they exemplify the need to balance performance-enhancing technologies with asset byte size.

{{ figure_markup(
  image="Distribution-of-image-requests-by-device-type.png",
  caption="Distribution of image requests by device type.",
  description="Bar chart showing the distribution of image requests for homepages by device type and percentile. The 10th percentile desktop page loads 5 images & mobile 4, the 25th 9 images on desktop & mobile 8, the 50th 18 images on desktop & 16 on mobile, the 75th 33 images on desktop, 30 on mobile, and the 90th 60 images on desktop, 55 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1033192122&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-image-requests-by-page-type.png",
  caption="Distribution of image requests by page type.",
  description="Bar chart showing the distribution of image requests by device type and percentile. The 10th percentile homepages page loads 5 images & inner pages 4, the 25th 10 images on homepages & inner pages 7 , the 50th 20 images on homepages & 14 on inner pages, the 75th 36 images on homepages, 26 on inner pages, and the 90th 65 images on homepages, 50 on inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=2009344757&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

2024 is the first year that image fell from being the dominant file type. In 2022, we saw the median page request 25 images for desktop and 22 for mobile pages. This is down to 18 for desktop and 16 for mobile.

Decreased image file types does not mean that the web has become less visual. Instead, sites may be switching to CSS effects (such as [shadows](https://www.w3schools.com/css/css3_shadows.asp) or [gradients](https://developer.mozilla.org/en-US/docs/Web/CSS/gradient)) and [CSS animations](https://web.dev/articles/animations-guide). These assets can be used to produce resolution-independent assets that always look sharp at every resolution and zoom level, often at a fraction of the bytes required by an image file.

Desktop pages consistently call for more image file types across with the gap between desktop and mobile growing steadily and consistently across percentiles. The difference between homepage and inner pages was striking in comparison. Where device type saw relatively consistent numbers, the median homepage called for 20 images compared to just 14 for inner pages.

{{ figure_markup(
  caption="Image requests made on desktop pages at the 100th percentile.",
  content="14,974",
  classes="big-number",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
)
}}

### CSS

[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS), or Cascading Style Sheets, is a style sheet language used to describe the presentation of a document written in a markup language like HTML. In other words, CSS is responsible for the visual styling and layout of web pages.

It allows developers to control the color, font, size, spacing, and many other visual aspects of HTML elements. CSS works in conjunction with HTML, providing a separation of content and presentation.

This separation makes web pages more maintainable, flexible, responsive, and can be used to make a site more performant but substituting byte-heavy image assets with CSS effects and animations.

{{ figure_markup(
  image="distribution-of-css-file-requests-by-device-type.png",
  caption="Distribution of CSS file requests by device type.",
  description="Bar chart showing the distribution of CSS file requests by device type and percentile. The 10th percentile desktop page loads 2 CSS files and mobile also 2, the 25th 4 CSS files on desktop and mobile also 4, the 50th 8 CSS files on desktop and 8 on mobile, the 75th 16 CSS files on desktop, 15 on mobile, and the 90th 26 CSS files on desktop, 26 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1092434902&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-css-file-requests-by-page-type.png",
  caption="Distribution of CSS file requests by page type.",
  description="Bar chart showing the distribution of CSS file requests by page type and percentile. The 10th percentile homepages page loads 1 CSS files and inner pages 2, the 25th 3 CSS files on homepages and inner pages 4, the 50th 7 CSS files on homepages and 8 on inner pages, the 75th 15 CSS files on homepages, 16 on inner pages, and the 90th 26 CSS files on homepages, 26 on inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=451662692&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

CSS is an essential tool in the web developer's toolkit across devices and page types. The median desktop and mobile page both called for 8 CSS assets. Percentiles were identical except for a nominal variance at the 75th.

In comparing homepages to inner pages, we saw that homepages consistently called one fewer cascading style sheets until the 90th percentile. At the 100th percentile, we saw inner pages deviate with a spike of 4,879 requests compared to 3,346 on inner pages. While both are high, inner pages are 46% higher.

For more information about how CSS was used on the web 2024, please see the [CSS chapter](https://almanac.httparchive.org/en/2024/css).

### JavaScript

JavaScript is a high-level, dynamic and interpreted programming language. It is one of the core technologies of the web, enabling interactive web pages and web applications. JavaScript allows developers to add interactivity, animations, and effects to web pages. This includes features such as drop-down menus, image sliders, personalized content, and analytics tracking. It is used as a client-side programming language by [98.9% of all websites](https://w3techs.com/technologies/details/cp-javascript).

{{ figure_markup(
  image="javascript-request-distribution-by-device-type.png",
  caption="JavaScript request distribution by device type.",
  description="Bar chart showing the distribution of JavaScript file requests by device type and percentile. The 10th percentile desktop page loads 5 JavaScript files and mobile 5, the 25th 12 JavaScript files on desktop and mobile 11 , the 50th 24 JavaScript files on desktop and 22 on mobile, the 75th 43 JavaScript files on desktop, 41 on mobile, and the 90th 12 JavaScript files on desktop, 69 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1888491876&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

2024 saw JavaScript overtake images as the dominant file type. The median page requested 24 JS files for desktop and 22 for mobile pages. This is up 8% for desktop and 4.5% for mobile when compared to 2022\. The number of JavaScript requests was consistent between inner and homepages through the 90th percentile.

At the 100th percentile, desktop pages and homepages broke away from their counterparts in the number of requests. Desktop pages made 33% more requests; homepages made 31% more. Desktop homepages made requests for 12,676 JavaScript resources. We attempted to reach the page for comment, but the request was still loading at time of publication.

For more information on how JavaScript is being used in 2024, take a look at the [JavaScript chapter](https://almanac.httparchive.org/en/2024/javascript).

### Third-party services

Third-party resources are external assets or services that are integrated into a web page or application, but are hosted and maintained by a different provider. These resources can include things like JavaScript, CSS, fonts, and analytics tools, to name a few. According to the Third Parties chapter, [92% of pages had one or more third party resources](https://almanac.httparchive.org/en/2024/third-parties#prevalence).The most called third party resources were scripts, making up 30.5% of requests by content type. The authors also noted a considerable decrease in the number of third parties for lower-ranked websites.

For more insights, refer to the [Third Parties chapter](https://almanac.httparchive.org/en/2024/third-parties).

### Other Assets

Web pages can utilize a variety of other assets and resources beyond just code, styles, and images. These additional assets contribute to the overall functionality, interactivity, and visual appeal of a web page, working in harmony with the HTML, CSS, and JavaScript to create a complete user experience.

#### HTML

HTML, or Hypertext Markup Language, is the standard markup language used to create and structure web pages. It provides the foundation for the content and layout of websites, defining elements like headings, paragraphs, lists, links, images, and more. HTML uses a series of tags and attributes to describe the semantic meaning and visual presentation of web page content.

There are several reasons why a page may include more than one HTML request for a single web page, including:

1. Embedded Resources: A web page typically loads not just the HTML document, but also additional resources like images, CSS files, JavaScript files, fonts, etc. Each of these external resources will trigger a separate HTTP request to the server to fetch that content.
2. Dynamically Loaded Content: Some web pages use JavaScript to dynamically load additional content or data after the initial page load. This could be things like infinite scrolling, AJAX-powered content updates, or lazy-loading of elements. These dynamic requests are in addition to the initial HTML document request.
3. Preloading/Prefetching: Web developers may include `<link>` tags with `rel="preload"` or `rel="prefetch"` to instruct the browser to proactively fetch certain resources in advance before they are actually needed. This can improve perceived performance.
4. Error Handling: If there are any network errors or server issues when loading a resource, the browser will retry the request, leading to multiple requests for the same content.

{{ figure_markup(
  image="html-requests-distribution-by-percentile.png",
  caption="HTML requests distribution by percentile.",
  description="A bar chart showing the distribution of HTML requests by device type. At the 10th and 25th percentiles, mobile and desktop made one request. The median page made two HTML requests for both devices. At the 75th percentile, desktop made six, and mobile made seven. At the 90th percentile, both made 12 HTML requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=594681881&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

The median page made two HTML requests., which was consistent across devices and page types. At the 90th percentile, we saw 12 HTML requests. The number spiked dramatically at the 100th percentile, where desktop homepages made 13,389 requests.

#### Font

{{ figure_markup(
  image="font-requests-distribution-by-percentile.png",
  caption="Font requests distribution by percentile.",
  description="A bar chart showing the distribution of font file requests by device type. At the 10th percentile, no font files were requested on mobile and desktop. The 25th percentile, desktop made 2 and mobile made 1request. The median page made 4 font file requests on desktop 3 on mobile. At the 75th percentile, desktop made 7, and mobile made 6. At the 90th percentile, desktop made 11 and mobile made 9 font file requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=378448165&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

The median page requested four font files. Through the 90th percentile, font requests remained fairly low and consistent across device and page types. At the 100th percentile, we saw desktop homepages request 3,038 fonts. With that volume of font requests, we speculate this site to be a font repository or a ransom note generator.

### Request bytes

Comparing the median page weight over time shows that unfortunately it continues to grow, almost at the same rate.The median page weight is still increasing at almost the same rate, as shown by a comparison over time.

{{ figure_markup(
  image="median-page-weight-over-time.png",
  caption="Median page weight over time.",
  description="Line chart showing the median page weight over time. The chart shows page weight growing over time, from 1,208 KB on desktop, 505 KB on mobile on Oct 2014, to 2,652 KB on desktop, 2,311 KB on mobile Oct 2024.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1318848334&format=interactive",
  sheets_gid="1332718864",
  sql_file="page_weight_trend.sql"
  )
}}

The median page weight for a desktop page, as measured in October 2024 is 2,652 KB, for mobile it's a slightly lower, but still weighty 2,311 KB.

Compared to 2022's chapter, both figures are higher, with the median desktop page being 2,312 KB and for mobile it was 2,037 KB. 2024's Mobile page is just 1 KB lighter than 2022's desktop page.In October 2024, the median page weight for a desktop page was 2,652 KB, while the median page weight for a mobile page was 2,311 KB.

Both of these figures are higher than those from 2022\. In 2022, the median page weight for a desktop page was 2,312 KB, and the median page weight for a mobile page was 2,037 KB. Notably, 2024's mobile page weight is only 1 KB lighter than 2022's desktop page weight.

{{ figure_markup(
  caption="How much larger the median mobile page weight has grown in 10 years.",
  content="1.8 MB",
  classes="big-number",
  sheets_gid="1332718864",
  sql_file="page_weight_trend.sql"
)
}}

When we compare year to year, desktop grew 8.6%	, or 210 KB from Oct 2023 to Oct 2024, and mobile grew 6.4%, or 140 KB.

Looking back over 10 years, we've added 120%, or 1.4 MB to the median desktop page, and a much more concerning 357% to mobile pages, which is an increase of 1.8 MB. To put that into perspective, we've *added* more than a 3.5" floppy disk held.

The median desktop page has increased by 120%, or 1.4 MB, over the past 10 years. The median mobile page has seen a more significant increase of 357%, or 1.8 MB, during the same period. This equates to adding more than a 3.5" floppy disk's worth of data to mobile pages.

Year-over-year, from October 2023 to October 2024, the desktop grew by 8.6%, or 210 KB, and mobile grew by 6.4%, or 140 KB.

According to [What Does My Site Cost?](https://whatdoesmysitecost.com/#usdCost) a web based tool for calculating the cost of web data to end users, the median desktop page could cost a user up to $0.32 USD, or in some regions up to 1.7% of their Gross National Income.

#### Content type and file formats

{{ figure_markup(
  image="median-homepage-weight-by-content-and-device-type.png",
  caption="Median homepage weight by content and device type.",
  description="Bar chart showing the median page weight of resources, by type. The median desktop page loads 18 KB of HTML, 78 KB of CSS, 131 KB of fonts, 613 KB of JavaScript and 1,054 KB of Images. For mobile homepages it was 18 KB, 73 KB, 111 KB, 558 KB and 900 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1854561083&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

The predominant resource type for homepages, excluding video, is images. The median desktop page requests 1,054 KB, while mobile pages request 900 KB. This shows a small increase from 2022, where desktop pages requested 1,026 KB and mobile pages requested 900 KB.

JavaScript was the second largest contributor to page weight, with the median desktop page serving 613 KB, on mobile pages it's 558 KB. Like images, these both represent growth from 2022's chapter, where it was 509 KB on desktop pages and 461 KB on mobile pages.

{{ figure_markup(
  image="median-desktop-page-weight-by-page-and-content-type.png",
  caption="Median desktop page weight by page and content type.",
  description="Bar chart showing the median page weight of resources, by page type and content type. The median desktop homepage loads 18 KB of HTML, 78 KB of CSS, 131 KB of fonts, 613 KB of JavaScript and 1,054 KB of Images. For desktop inner pages it was 18 KB, 73 KB, 131 KB, 627 KB and 442 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1972138072&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="median-mobile-page-weight-by-page-and-content-type.png",
  caption="Median mobile page weight by page and content type.",
  description="Bar chart showing the median page weight of resources, by page type and content type. The median mobile homepage loads 18 KB of HTML, 73 KB of CSS, 111 KB of fonts, 558 KB of JavaScript and 900 KB of Images. For mobile inner pages it was 17 KB, 77 KB, 108 KB, 582 KB and 348 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=941541885&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

For both mobile and desktop pages, inner pages tend to have less bytes of images, and slightly more bytes of JavaScript.

This new analysis also shows that images are not always the biggest component of page weight, as previously thought, and that for inner pages JavaScript took that dubious honor instead.

{{ figure_markup(
  image="distribution-of-response-sizes-by-content-type.png",
  caption="Distribution of response sizes by content type.",
  description="Box plot of the distribution of resource sizes by type for desktop pages. Video is the largest resource type by far, reaching 8,614 KB at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=124632855&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

Images might be the biggest contributors to page weight in all in all, however when looking at the size per request, that switches to Video leading the way, followed by fonts, and [WebAssembly (wasm)](https://web.dev/explore/webassembly) files (which weren't detected in 2022). In 2022's analysis, audio was the second most weighty, but it slipped to fourth place, behind images this year.

#### JavaScript Bytes

Increased weight of JavaScript files carries an additional penalty to performance, as not only is the pure size a consideration, a browser needs to parse and execute the JavaScript, which can be a costly process, especially on lower powered devices.

{{ figure_markup(
  image="distribution-of-javascript-response-sizes-by-device-type.png",
  caption="Distribution of JavaScript response sizes by device type.",
  description="Bar chart of the distribution of JavaScript resource sizes by device type, across home and inner pages. At the 10th percentile, it is 101 KB for desktop and 89 KB for mobile, at the 25th percentile it is 270 KB for desktop and 244 KB for mobile, at the 50th percentile, it is 620 KB for desktop URLs, 570 KB for mobile URLs, at the 75th percentile it's 1,172 KB for desktop, 1,103 KB for mobile, and the 90th percentile it's 1,834 KB for desktop and 1,732 KB for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1609680901&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

Although the trend is that a desktop page requests more bytes of JavaScript than a mobile page, with the median desktop page requesting 620 KB of JavaScript, and a mobile one 570 KB, the differences aren't huge.

According to Alex Russell's [The Performance Inequality Gap, 2024](https://infrequently.org/2024/01/performance-inequality-gap-2024/) study, these are however far above the proposed target of a page load of under 3 seconds at the 75th percentile, which is 365 KB.

At the 75th percentile, both mobile and desktop blast past the proposed 650 KB budget to achieve 5 seconds by, and that is assuming it's a JavaScript heavy page, and markup is accordingly smaller.

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-page-type.png",
  caption="Distribution of JavaScript response sizes by page type.",
  description="Bar chart of the distribution of JavaScript resource sizes by page type, across device types. At the 10th percentile, it is 86 KB for homepages and 104 KB for inner pages, at the 25th percentile it is 248 KB for homepages and 267 KB for inner pages, at the 50th percentile, it is 585 KB for homepages URLs, 604 KB for inner pages URLs, at the 75th percentile it's 1,151 KB for homepages, 1,120 KB for inner pages, and the 90th percentile it's 1,1822 KB for homepages and 1,744 KB for inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=989064677&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

There is not a huge difference between homepage and inner page JavaScript file response sizes. Inner pages have a little more JavaScript up to the 50th percentile, above that the trend is for homepages to have more.

This could point to there being opportunities for developers loading all, or most, JavaScript resources on all pages and represent an opportunity to reduce JavaScript needed overall by [tree shaking](https://en.wikipedia.org/wiki/Tree_shaking), which is a method of splitting JavaScript files up into more specific ones and only loading them when needed, therefore reducing the wasted JavaScript bytes being downloaded.

#### CSS bytes

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-device-type.png",
  caption="Distribution of CSS response sizes by device type.",
  description=""Bar chart of the distribution of CSS resource sizes by device type, across home and inner pages. At the 10th percentile, it is 10 KB for desktop and 8 KB for mobile, at the 25th percentile it is 36 KB for desktop and 32 KB for mobile, at the 50th percentile, it is 80 KB for desktop URLs, 75 KB for mobile URLs, at the 75th percentile it's 152 KB for desktop, 146 for mobile, and the 90th percentile it's 269 KB for desktop and 260 KB for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=724413424&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-page-type.png",
  caption="Distribution of CSS response sizes by page type.",
  description=""Bar chart of the distribution of CSS resource sizes by page type, across mobile and desktop devices. At the 10th percentile, it is 7 KB for homepages and 11 KB for inner pages, at the 25th percentile it is 32 KB for homepages and 36 KB for inner pages, at the 50th percentile, it is 76 KB for homepages and 79 KB for inner pages, at the 75th percentile it's 149 KB for homepages and inner pages, and the 90th percentile it's 266 KB for homepages and 263 KB for inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=928222763&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

CSS sizes were slightly larger on desktop than on mobile across all percentiles, and there was very little difference between homepages and inner pages.

This points to the generally adopted method is one set of CSS for all devices and page types. This does potentially point to a missed opportunity to reduce CSS needed overall by tree shaking, as with JavaScript above, but it's always a more nuanced thing with CSS where you are balancing caching and the capabilities of build tools.

Overall, the 76KB of CSS files seems both a little larger than you would hope, but not excessively huge, but keep in mind the best size for a CSS file is as small as it can possibly be. Hopefully that doesn't mean folks are just stuffing it all inline in the head instead.

#### Image bytes

In past page weight chapters, images have always been the largest contributor to page weight overall, and even though 2024's new inner page data shows that's a trend specific to homepages, it still represents a large component overall.

{{ figure_markup(
  image="distribution-of-image-response-sizes-by-device-type.png",
  caption="Distribution of image response sizes by device type",
  description=""Bar chart of the distribution of image resource sizes by device type. At the 10th percentile, it is 84 KB for desktop and 62 KB for mobile, at the 25th percentile it is 322 KB for desktop and 263 KB for mobile, at the 50th percentile, it is 1,054 KB for desktop and 900 KB for mobile, at the 75th percentile it's 2,822 KB for desktop 2,517 KB for mobile, and the 90th percentile it's 6,526 KB for desktop and 5,905 KB for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1690867892&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

The median desktop homepage is loading 1,054 KB of images, and mobile ones a little less weighty 900 KB. As noted earlier that's still an increase over 2022 where it was 1,026 KB for desktop pages, 900 KB for mobile. Things soon balloon once you get to the 75th percentile, with 2,822 KB of images for desktop, and 2,517 KB of images for mobile.

In fact, at the median and above, all percentiles were bigger than in [2022's chapter](https://almanac.httparchive.org/en/2022/page-weight#image-bytes), however the more positive findings are that at the 10th and 25th, image bytes were either pretty much stable or down from the previous chapter, pointing to the fact that developers who were already optimising for image file sizes have continued to do so, and might be getting slightly better at it.

It is also pleasing to see that where developers seem to be concentrating on reducing the impact on page weight the most is for mobile users, where page weight can carry the highest penalties. This could be due to folks using [responsive image](https://web.dev/articles/serve-responsive-images) serving.

{{ figure_markup(
  image="distribution-of-desktop-image-response-sizes-by-page-type.png",
  caption="Distribution of desktop image response sizes by page type",
  description="Bar chart of the distribution of image resource sizes on desktop clients, by page type. At the 10th percentile, it is 84 KB for homepages and 36 KB for inner pages, at the 25th percentile it is 342 KB for homepages and 142 KB for inner pages, at the 50th percentile, it is 1,054 KB for homepages and 442 KB for inner pages, at the 75th percentile it's 2,8722 KB for homepages 1,253 KB for inner pages, and the 90th percentile it's 6,526 KB for homepages and 3,295 KB for inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=2019094499&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-mobile-image-response-sizes-by-page-type.png",
  caption="Distribution of mobile image response sizes by page type.",
  description="Bar chart of the distribution of image resource sizes on desktop clients, by page type. At the 10th percentile, it is 62 KB for homepages and 24 KB for inner pages, at the 25th percentile it is 263 KB for homepages and 97 KB for inner pages, at the 50th percentile, it is 900 KB for homepages and 348 KB for inner pages, at the 75th percentile it's 2,517 KB for homepages 1,098 KB for inner pages, and the 90th percentile it's 5,905 KB for homepages and 2,986 KB for inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1851191068&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

Looking at home and inner pages, there is a clear trend for both desktop and mobile for the homepage to have more image bytes, with the median desktop page having 1,054 KB for homepages and 442 KB for inner pages, and on mobile it is 900 KB for homepages and 348 KB. For both desktop and mobile the median inner page carries less than half the image bytes than the homepage.

{{ figure_markup(
  image="distribution-of-desktop-image-sizes-by-format.png",
  caption="Distribution of desktop image sizes by format.",
  description="Box chart showing the distribution of desktop images by size. JPG is the largest format by far, with the 90th percentile at 274 KB, followed by PNG at 196 KB, WebP at 116 KB, and AVIF at 45 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=226775276&format=interactive",
  sheets_gid="397148495",
  sql_file="../media/media_formats.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-mobile-image-sizes-by-format.png",
  caption="Distribution of mobile image sizes by format.",
  description="Box chart showing the distribution of desktop images by size. JPG is the largest format by far, with the 90th percentile at 266 KB, followed by PNG at 207 KB, WebP at 107 KB, and AVIF at 46 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=226775276&format=interactive",
  sheets_gid="397148495",
  sql_file="../media/media_formats.sql"
  )
}}

JPG, WebP, and PNG file formats retain their 2022 status as top sources of image weight, for more insights into image format use on the web, visit the [Media chapter](https://almanac.httparchive.org/en/2024/media).

#### Video bytes

Videos carry a lot of data, for each second of video, there's many images, or frames, and often audio as well. As such, they can significantly add to the weight of a page.

Modern formats help compress and shrink this down, but at some point there is a trade off to be made with file size and quality.

Getting that trade off right and combining with other techniques, like using a facade, can reduce the impact as much as possible.

{{ figure_markup(
  image="distribution-of-video-response-sizes-by-device-type.png",
  caption="Distribution of video response sizes by device type.",
  description="Bar chart of the distribution of video resource sizes on desktop and mobile. For desktop it is 3 KB at the 10th percentile, 34 KB at the 25th percentile, 194 KB at the median, 875 KB at the 75th percentile and 2,835 KB at the 90th percentile. For mobile it was 3 KB, 43 KB, 299 KB, 1,169KB and 3,432 KB respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=898316028&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

The median page requests 194 KB of video for desktop users, and surprisingly a larger 299 KB for mobile users. In fact that trend was present from the 25th percentile onwards, which is a disappointing trend, given that mobile devices are likely to be the ones to benefit the most from reduced page weight.

{{ figure_markup(
  image="desktop-video-response-size-distribution-by-page-type.png",
  caption="Desktop video response size distribution by page type.",
  description="Bar chart of the distribution of desktop video resource sizes on home and inner pages. For homepages it is 5 KB at the 10th percentile, 44 KB at the 25th percentile, 243 KB at the median, 1,257 KB at the 75th percentile and 3,910 KB at the 90th percentile. For inner pages it was 1 KB, 24 KB, 144 KB, 493 KB and 1,760 KB respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1089264171&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

{{ figure_markup(
  image="mobile-video-response-size-distribution-by-page-type.png",
  caption="Mobile video response size distribution by page type.",
  description="Bar chart of the distribution of mobile video resource sizes on home and inner pages. For homepages it is 5 KB at the 10th percentile, 62 KB at the 25th percentile, 410 KB at the median, 1,563 KB at the 75th percentile and 4,704 KB at the 90th percentile. For inner pages it was 1 KB, 24 KB, 188 KB, 775 KB, 2,159 KB respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=847216939&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

Homepages are found to have a larger payload of video resources than inner pages, with the median homepage requesting 243 KB of video resources  for desktops and 410 KB for mobile devices. Inner pages were lower at 144 KB for desktop and 188 KB for mobile devices.

This could point to developers favour using video "hero" sections, or otherwise embedding video on homepages, which tend to focus on the site or business as a whole, rather than adding them into inner pages, which are likely to be more focused pages, perhaps categories and listing pages, or individual articles or products.

## Adoption rates of byte-saving technologies

There are a number of things that can be done to reduce page weight. The first one is not so much a technology as an approach, and is on the surface quite simple. Don't send stuff you don't need to.

This means that you should be mindful of what is added to pages, and what is shipped, in short you should be looking to see if what you are adding is really adding value to the user of the page and the business case the page might need to fulfill.

But the aim isn't to remove all features, rather, make sure that what you are adding adds value.

Let's take a look at some of these patterns and approaches to help you deliver your valuable content in more efficient ways, and how often they are being implemented.

### Facades for videos & other embeds

Third-party embeds, such as videos, social media posts and other interactive embeds can massively increase page weight. It's simple to click that share button on a video or post and paste the code into your pages without fully being aware of the huge payloads that can come along with it.

Videos you might expect to have a significant number of bytes, but even things like embedding a live chat widget, or even a social media post like a tweet can come with significant overhead, loading a surprising amount of JavaScript to enable interactivity, like clicking the like button or resharing it.

One design pattern that can be a good compromise is using a facade. The fundamental principle of this is to use a graphical, or simple, non-interactive representation of the embed, which then becomes the interactive, full embed when and if a user clicks on it.

For video, that's often displaying the poster image, which when clicked loads in the full embed. For a social media post, it could be either styled html, or like the video solution, an image that loads the full interactivity when the user clicks on the post.

Whilst ultimately, if a user interacts, the larger payload does still need to be loaded, the savings come when many users don't want to interact, watch the video or start a live chat with customer services or sales. The users that do pay that cost are the ones that proactively want to use the feature.

There can be some drawbacks to using facades, these are covered well in the [third-party facades article on web.dev](https://developer.chrome.com/docs/lighthouse/performance/third-party-facades#live_chat_intercom_drift_help_scout_facebook_messenger). But ultimately, this approach can help save a significant amount of overall page weight.

To look at adoption of facades, we can turn to lighthouse, which offers a [lazy load third-party resources with facades](https://developer.chrome.com/docs/lighthouse/performance/third-party-facades) audit to see if there are some identifiable resources embedded in the page that might represent an opportunity to use a facade.

Judging adoption is, overall, hard, as we can't reliably test for sites that are implementing facades, because the solution involves the page no longer loading the resources we'd be looking for, so looking at sites that could potentially benefit is more meaningful.

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