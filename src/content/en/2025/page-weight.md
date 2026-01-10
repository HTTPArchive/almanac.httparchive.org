---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: Page Weight chapter of the 2025 Web Almanac covering why page weight matters, bandwidth, complex pages, page weight over time, page requests, and file formats.
hero_alt: Hero image of Web Almanac characters using a set of scales to weigh a web page against variuos boxes labelled with various different kilobytes.
authors: [rickb1102, fellowhuman1101]
reviewers: [dwsmart]
analysts: [dwsmart]
editors: [montsec]
translators: []
fellowhuman1101_bio: Jamie Indigo isn't a robot, but speaks bot. As director of technical SEO at <a hreflang="en" href="https://www.coxautoinc.com/">Cox Automotive</a>, they study how search engines crawl, render, and index the web. Jamie loves to tame wild JavaScript and optimize rendering strategies. When not working, they like horror movies, graphic novels, and terrorizing lawful good paladins in Dungeons & Dragons.
results: https://docs.google.com/spreadsheets/d/1xGs0oBVuONgj7uI0jPx-07ww94hWMmo6LrI8vdOOL5w/edit
rickb1102_bio: Richard Barrett is director of professional services and a technical search consultant at <a hreflang="en" href="https://www.lumar.io/">Lumar</a>. They like helping web owners solve awkward problems and love a good puzzle game or two, or three.
featured_quote: ...
featured_stat_1: 202%
featured_stat_label_1: Increase in mobile page weight over the last decade
featured_stat_2: 98.1%
featured_stat_label_2: Pages make at least one request for a JS file
featured_stat_3: 2,164 KB
featured_stat_label_3: The median weight of a mobile homepage in 2025
---

## Introduction

In the early days of the web, every byte was a luxury. Developers spent hours dither-mapping GIFs and hand-optimizing scripts to ensure pages could crawl through 56k modems. Today, in an era of gigabit fiber and 5G dominance, that scarcity mindset has largely vanished. However, as our "bandwidth pipes" have grown wider, the content we push through them has expanded to fill the space.

Page weight—the total volume of bytes transferred to a user's device—remains one of the most critical metrics for understanding the health of the web. While it is tempting to view a few extra megabytes as a negligible cost of modern rich experiences, the reality is far more complex.

## What is page weight?

Page weight (also called page size) is the total volume of data—measured in kilobytes (KB) or megabytes (MB)—that a user must download to view a specific webpage.

When you navigate to a URL, your browser doesn't just download one file; it sends dozens or even hundreds of requests for various assets required to make the page look and function correctly. The sum of all these "shipped" bytes constitutes the page weight.

A modern webpage is an assembly of several different types of resources. Each contributes to the total "heaviness" of the site:

* **Images & Video:** High-resolution photos, background videos, and GIFs can quickly balloon page size.
* **JavaScript:** Files that provide interactivity (like menus, tracking pixels, or animations). While often smaller in KB than images, JavaScript is "heavy" because the browser has to spend significant CPU power parsing and executing it.
* **CSS:** Stylesheets that determine the layout, colors, and fonts of the page.
* **Fonts:** Custom web fonts can add several hundred KB if multiple weights (bold, italic, light) are used.
* **HTML:** The structural code of the page, which is usually the smallest part of the total weight.
* **Third-Party Scripts:** These include ads, analytics, and social media widgets that are fetched from other servers.

Not all bytes are created equally. In this chapter we will explore page weight by bytes and by request volume of file types.

### Why Weight Matters

Page weight is a direct proxy for performance and accessibility. A "heavy" page creates several negative ripple effects:

1. The Performance Gap: Larger payloads can require more CPU cycles and use more device memory to parse and render, often leading to sluggish experiences on low-end devices, regardless of connection speed.
2. The Economic Toll: In many parts of the world, data is a metered commodity. A 5 MB page isn't just a slow experience; it is an exclusive one. If a user cannot afford the data to load your page, your site is, by definition, inaccessible to them.
3. The Accessibility Barrier: If a page is "heavy," it doesn't just load slowly—it becomes physically and cognitively harder to use. Excessive page weight creates significant inequities, heavily penalizing users who rely on less powerful devices or expensive, slow connections with limited data caps. Refer to the [Accessibility](./accessibility) chapter to learn more about how page weight is a silent but significant barrier to entry for millions of users with disabilities.
4. The Environmental Impact: Every megabyte transferred requires energy—from data centers to cooling systems to the device in the user's hand. As the web grows, so does its carbon footprint. You can find out more about how page weight impacts carbon emissions in the [Sustainability](./sustainability) chapter.
5. Speed & SEO: Heavier pages take longer to load, especially on slower connections. Google uses page speed (via Core Web Vitals) in their core algorithm, meaning bloated pages can rank lower in search results.

The weight effects can be divided into three main categories: storage, transmission, and rendering.

### Storage

Storage refers to how assets (images, scripts, HTML) sit on a web server or CDN. At this stage, page weight is about file size on disk.

* Compression at Rest: Developers often store files in highly compressed formats (like WebP for images or Brotli-compressed text). A 1 MB file can be stored as 300 KB.
* The Database Bottleneck: For dynamic sites, the "weight" starts with database queries. If a server has to retrieve 2 MB of raw data from a database to generate one page, the initial response time (TTFB) increases before a single byte is even sent.
* The Cost: Inefficient storage doesn't just affect speed; it increases hosting costs and the carbon footprint of the data center.

### Transmission

Transmission is the process of moving those stored files across the internet. This is where network constraints turn page weight into a performance barrier.

* Transfer Size vs. Actual Size: Thanks to "on-the-fly" compression (like Gzip), the number of bytes sent over the wire is often much smaller than the original file size.
* Latency and Round Trips: It’s not just about how much data is sent, but how many files. Each separate file requires a "round trip" to the server. A page with 50 small images (totaling 1 MB) can actually feel slower than a page with one large 2 MB image because of the transmission overhead of 50 separate requests.
* The Bottleneck: On mobile 4G/5G, signal interference can cause "packet loss." The heavier the page, the more likely a packet will drop, forcing the browser to ask for it again and causing a visible hang.

### Rendering

Rendering is what happens once the data arrives. This is the most misunderstood part of page weight: Once a file is downloaded, it must be "unpacked" and processed by the device.

* Memory Inflation: An image might only take up 200 KB during transmission, but once the browser "renders" it, it must be decoded into raw pixels in the device's RAM. That 200 KB file can easily take up 5 MB of memory.
* The JavaScript Tax: This is the "heaviest" part of rendering. 100 KB of an image is just pixels, but 100 KB of JavaScript is work. The CPU must parse, compile, and execute that code. On a low-end smartphone, this "weight" can freeze the screen for several seconds.
* DOM Complexity: Every HTML tag adds a "node" to the browser's memory. A page with 5,000 nodes (a "heavy" DOM) will make scrolling feel laggy, regardless of how fast the internet connection is.

Websites may be changing their rendering strategies, sometimes prompted by rethinking how websites are accessed and consumed by the growing AI chatbots and other large language model tools. Not all of these changes are aimed at AI crawler accessibility. Some testing has been done to identify the technical requirements for AI crawler accessibility, as these may vary between crawlers. We do know that all key information should be present in the initial raw HTML, since [AI crawlers do not render JavaScript](https://vercel.com/blog/the-rise-of-the-ai-crawler).

Given the growing awareness of these factors, we could expect broader adoption of such strategies, including a reduction in the use of JavaScript files in future editions.

## What are we shipping?

In this chapter, we analyze trillions of bytes across millions of websites to answer a fundamental question: Are we getting more value out of our payloads, or are we simply succumbing to "weight creep"? We will explore the dominance of media—images and video—which continue to claim the lion's share of the transfer budget, and the steady rise of JavaScript, which carries a performance tax far heavier than its file size suggests.

### Request bytes

Median page weight over time shows that page size growth is accelerating, since October 24 there has been a noticeable upward trend, in particular for mobile devices. This is shown on a grander scale with the homepage, which on average is close to 45.8% larger than inner pages.

Homepage page weight has similarly accelerated but earlier, around early 2023/late 2022.

This does have wider implications:

#### Page weight implications for AI

There is an increase in energy consumption and computation costs, heavier pages mean more bandwidth, rendering and CPU load per visit, which all increase the energy footprint of web crawling and indexing.

This results in slower or shallower crawling, as AI-driven crawlers that try to "understand" the web by performing actions such as extracting entities or content summarization, may limit the depth or frequency of crawling to manage their computation budgets.

This could lead to a bias towards lighter-footprint web content with faster loading or more semantically clear sites, as they are easier to parse and therefore model. Sites overloaded with JS and client-side rendering could end up being underrepresented in large-scale training sets since the crawlers AI models employ do not render.
Finally, AI may skip or truncate what they see on slow or very heavy pages as performance becomes more critical.

#### Page weight implications for users

As pages get heavier, more sites will likely fall short on LCP & INP, which could directly reduce their visibility in search results. More importantly, this can make a frustrating user experience, potentially leading to lower conversion rates, as convenience has become an increasingly important factor.

Heavier pages widen the digital divide between users on slower connections or lower-end devices, as they would be disproportionately impacted by these increases. This highlights the importance for search marketers to optimize websites with these users in mind.

Page weight implications for publishers
Slower performance correlates with lower online traffic, conversion rates and ad views. Ad tech and analytics scripts drive additional weight, creating additional friction between user experience and monetisation.

In summary:
AI systems may adapt by scraping less and summarising more, filling gaps with "hallucinations". This could reduce user confidence in brands and lead to lower online traffic and conversions. User behaviour could shift away from traditional page visits toward AI-mediated browsing experiences, as convenience continues to play a key role in how people access online information.

## Page weight over time

Since the inception of the Web Almanac, we've consistently observed two trends:

1. The total volume of requests increases.
2. Desktop page loads result in more requests than mobile page loads.

{{ figure_markup(
 image="median-home-page-weight-over-time.png",
 caption="Median home page weight over time.",
 description="Line chart showing the median home page weight over time. The chart shows page weight growing over time, from 1,208 KB on desktop, 505 KB on mobile in Oct 2014, to 2,862 KB on desktop, 2,559 KB on mobile in July 2025.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=100065523&format=interactive",
 sheets_gid="1902270972",
 sql_file="page_weight_trend.sql"
 )
}}

In July 2015, the median mobile homepage was a meager 845 KB. As of July 2025, the same median page is now 2,362 KB. The page decade brought a 202.8% increase. The median desktop homepage saw a 110.2% increase in the same time frame.

Year over year, the median homepage size grew 7.8% to 2.7 MB. The median mobile homepage is 2.6 MB, growing 8.4% from 2.4 MB in 2024. In 2025, the median desktop page size reached 2.9 MB, up 7.3% from 2024's median of 2.7 MB.

{{ figure_markup(
 image="median-inner-page-weight-over-time.png",
 caption="Median inner page weight over time.",
 description="Line chart showing the median home page weight over time. The chart shows inner page weight growing over time, from 1,574 KB on desktop, 1,366 KB on mobile in May 2022, to 1,963 KB on desktop, 1,769 KB on mobile in July 2025.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=516848694&format=interactive",
 sheets_gid="1902270972",
 sql_file="page_weight_trend.sql"
 )
}}

Inner page weight continued to increase, up 9.5% year over year. Since data for tracking inner page weight began in 2022, the median mobile inner page weight has increased by 27.8% to 1.8 MB, while desktop has grown by 25.2% to reach 2 MB during the same period.

## Page weight in bytes
Every update to page functionality introduces additional weight and file types designed to enhance performance while preserving core features. We've examined common file types, their frequency, and response sizes to gain a clearer understanding of their implementation, including comparisons across different devices and page types.

{{ figure_markup(
 image="page-weight-distribution-by-device.png",
 caption="Page weight distribution by device.",
 description="Bar chart showing distribution of page weight across percentiles in kilobytes. At the 10th percentile, desktop pages are 607 KB and mobile are 516 KB. At the 25th percentile, desktop pages are 1,275 KB and mobile are 1,127 KB. At the 50th percentile (median), desktop pages are 2,412 KB and mobile are 2,164 KB. At the 75th percentile, desktop pages are 4,570 KB and mobile are 4,119 KB. At the 90th percentile, desktop pages are 9,179 KB and mobile are 8,337 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=142491648&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

{{ figure_markup(
 image="page-weight-distribution-by-page-type.png",
 caption="Page weight distribution by page type.",
 description="Bar chart showing distribution of page weight across percentiles in kilobytes. At the 10th percentile, home pages are 589 KB and inner pages are 534 KB. At the 25th percentile, home pages are 1,361 KB and inner pages are 1,041 KB. At the 50th percentile (median), home pages are 2,710 KB and inner pages are 1,866 KB. At the 75th percentile, home pages are 5,422 KB and inner pages are 3,267 KB. At the 90th percentile, home pages are 11,406 KB and inner pages are 6,109 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2023138567&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

### Median page by the bytes

To better understand the web, we can examine the 50th percentile. The median represents the typical value and context to study relative page weights.

{{ figure_markup(
 image="median-mobile-page-weight-by-content-type.png",
 caption="Median mobile page weight by content type.",
 description="Bar chart showing distribution of page weight by resource type in kilobytes for the median mobile page. HTML accounted for 22 KB on home pages and 20 KB on inner pages. CSS accounted for 77 KB on home pages and 80 KB on inner pages. Fonts accounted for 122 KB on home pages and 119 KB on inner pages. JavaScript accounted for 632 KB on home pages and 660 KB on inner pages. Images accounted for 911 KB on home pages and 354 KB on inner pages.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=298835929&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

In 2025, the median mobile homepage used:

* 22 KB of HTML resources
* 77 KB of CSS resources
* 122 KB of fonts
* 632 KB of JavaScript
* 911 KB of images

Inner pages were similar, with the exception of images, which decreased from 911 KB to 354 KB on internal pages.

{{ figure_markup(
 image="median-desktop-page-weight-by-content-type.png",
 caption="Median desktop page weight by content type.",
 description="Bar chart showing distribution of page weight by resource type in kilobytes for the median desktop page. HTML accounted for 22 KB on home pages and 21 KB on inner pages. CSS accounted for 82 KB on home pages and 85 KB on inner pages. Fonts accounted for 139 KB on home pages and 138 KB on inner pages. JavaScript accounted for 697 KB on home pages and 719 KB on inner pages. Images accounted for 1058 KB on home pages and 442 KB on inner pages.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1561526857&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

The median desktop page's weight by resource type matched mobile, though the resources were slightly larger in KB. In 2025, the median desktop homepage used:

* 22 KB of HTML resources
* 82 KB of CSS resources
* 139 KB of fonts
* 697 KB of JavaScript
* 1,058 KB of images

For both device types, images saw the greatest gap in kilobytes with 1.06 MB used on home pages and 442 KB on inner pages.

{{ figure_markup(
 image="median-home-page-weight-by-content-type.png",
 caption="Median home page weight by content type",
 description="Bar chart showing distribution of page weight by resource type in kilobytes for the median home page. HTML accounted for 22 KB on home pages and 22 KB on inner pages. CSS accounted for 82 KB on home pages and 77 KB on inner pages. Fonts accounted for 139 KB on home pages and 122 KB on inner pages. JavaScript accounted for 697 KB on home pages and 632 KB on inner pages. Images accounted for 1,059 KB on home pages and 911 KB on inner pages. In total, desktop pages were 2,862 KB and mobile were 2,559 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1580340306&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

The median homepage in 2025 was 2.86 MB on desktop and 2.56 MB on mobile. Images accounted for the most bytes on both mobile and desktop, followed by JavaScript and fonts.

### Response size by content type

Not all file types are created equally– or equally sized. File types define how data is stored and encoded, telling a program how to open and display a file's contents.

{{ figure_markup(
 image="median-home-page-response-size-by-format.png",
 caption="Median home page response size by format.",
 description="Bar chart showing response size by file format for the median home page. Quicktime accounted for 400 KB on desktop and 976 KB on mobile pages. MPEG accounted for 327 KB on desktop and 640 KB on mobile pages. WebM accounted for 860 KB on desktop and 582 KB on mobile pages. JPG accounted for 43 KB on desktop and 49 KB on mobile pages. WebP video accounted for 33 KB on desktop and 21 KB on mobile pages. WebP accounted for 17 KB on desktop and 20 KB on mobile pages. PNG accounted for 7 KB on desktop and mobile pages. AVIF accounted for 7 KB on desktop and mobile pages. ICO accounted for 3 KB on desktop and 2 KB on mobile pages. SVG accounted for 7 KB on desktop and mobile pages.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=669081712&format=interactive",
 sheets_gid="1891741241",
 sql_file="response_media_file_type_distribution.sql"
 )
}}

Mobile devices are typically more challenging for performant experiences. Their smaller, varied screen sizes and weaker connections mean that content can take longer to load. This is what makes it so strange that mobile home pages also had some of the heaviest files.

The largest file types, QuickTime and MPEG, are used for video. The median mobile homepage used 976 KB of QuickTime, 244% more than desktop's 400 KB. Similarly, the median mobile home page used 196% more MPEG bytes than desktop. The third-largest file type was WebM, a video format optimized for faster loading and lower bandwidth usage. Despite being ideal for mobile connections, more WebM bytes were shipped for desktop.

Upon further investigation, we were surprised to find that video files were particularly susceptible to duplicate downloads where browsers were making multiple requests, often with different range headers. This inflated the bytes for videos, and seemed worse on mobile — perhaps due to slower network downloads? We could find no documentation for this behaviour, but would be interested to hear more if any readers can explain this.

{{ figure_markup(
 image="median-inner-page-response-size-by-format.png",
 caption="Median inner page response size by format",
 description="Bar chart showing response size by file format for the median home page. Quicktime accounted for 353 KB on desktop and 720 KB on mobile pages. WebM accounted for 281 KB on desktop and 424 KB on mobile pages. MPEG accounted for 162 KB on desktop and 189 KB on mobile pages. JPG accounted for 33 KB on desktop and 37 KB on mobile pages. WebP accounted for 13 KB on desktop and 16 KB on mobile pages. WebP video accounted for 21 KB on desktop and 9 KB on mobile pages. AVIF accounted for 5 KB on desktop and 4 KB on mobile pages. PNG accounted for 4 KB on desktop and mobile pages. ICO accounted for 2 KB on desktop and mobile pages. SVG accounted for 1 KB on desktop and mobile pages.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=300581752&format=interactive",
 sheets_gid="1891741241",
 sql_file="response_media_file_type_distribution.sql"
 )
}}

For median inner pages, QuickTime files remained the largest file type in bytes. Mobile saw 720 KB compared, 202% the 352.6 KB found on desktop. WebM surpassed MPEG as the second-largest file type for inner pages, at 423.6 KB on mobile and 280.8 KB on desktop. These were followed by MPEG, with more even distribution between device types (161.6 KB desktop; 188.8 KB mobile) than seen on home pages.

{{ figure_markup(
 image="distribution-of-response-sizes-by-content-type.png",
 caption="Distribution of response sizes by content type.",
 description="Candlestick chart of the distribution of resource sizes by type for desktop pages. Video ranged from 7 KB at the 10th percentile to 11,129 KB at the 90th percentile. Font ranged from 16 KB at the 10th percentile to 158 KB at the 90th percentile. Wasm ranged from 4 KB at the 10th percentile to 775 KB at the 90th percentile. Audio ranged from 6 KB at the 10th percentile to 445 KB at the 90th percentile. Image ranged from 0 KB at the 10th percentile to 369 KB at the 90th percentile. Script ranged from 1 KB at the 10th percentile to 165 KB at the 90th percentile. CSS ranged from 0 KB at the 10th percentile to 50 KB at the 90th percentile. XML ranged from 0 KB at the 10th percentile to 3 KB at the 90th percentile. HTML ranged from 0 KB at the 10th percentile to 59 KB at the 90th percentile. Text ranged from 0 KB at the 10th percentile to 1 KB at the 90th percentile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=736168851&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

Videos, by their very nature, tend to be the largest of files. They also have the largest range in size– from 7k B at the 10th percentile up to 1GB at the 100th. That range is only surpassed by image file types which saw 0 KB on the 10th percentile on 1.2GB at the 100th. XML files saw the smallest range with the 10th to 50th percentiles having 0 KB of the file type and the most extreme desktop pages having 52.1 MB at the 100th.

### Image Bytes

Image bytes refer to the binary data required to render visual elements such as photographs, icons, and illustrations. Unlike text-based files (like HTML), which are highly efficient and easily compressed, image data is inherently dense. The "weight" of these bytes is determined by three primary factors:

1. Resolution: The total pixel count of the asset.
2. Encoding: The mathematical method used to store the data (e.g., JPEG, PNG, or modern formats like WebP and AVIF).
3. Compression: The degree to which redundant data is removed to shrink the file size, often at the cost of visual fidelity.

The accumulation of image bytes creates a "heavy" page, which directly correlates with increased latency and slower Largest Contentful Paint (LCP) scores. For users on mobile devices or limited-bandwidth connections, high image byte counts can lead to prohibitive load times and increased data costs.

{{ figure_markup(
 image="image-response-size-distribution-by-device.png",
 caption="Image response size distribution by device",
 description="Bar chart showing distribution of image file size across percentiles in kilobytes. At the 10th percentile, desktop and mobile images are 0 KB. At the 25th percentile, desktop and mobile images are 1 KB. At the 50th percentile (median), desktop and mobile images are 8 KB. At the 75th percentile, desktop images are 48 KB and mobile are 52 KB. At the 90th percentile, desktop images are183 KB and mobile are 186 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=665449543&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

At the 50th percentile, individual image files were 8 KB on both mobile and desktop. It is worth noting that many sites use small images, known as tracking pixels, as part of their analytics. These tiny, often invisible 1x1 pixel images are embedded in web pages and trigger a server request when loaded. Since these files are not differentiated from standard, user-focused image assets, they may cause the median image size to appear smaller than expected.

{{ figure_markup(
 image="image-response-size-distribution-by-page-type.png",
 caption="Image response size distribution by page type.",
 description="Bar chart showing distribution of image file size across percentiles in kilobytes. At the 10th percentile, home page and inner page images are 0 KB.
At the 25th percentile, home page images are 1 KB and inner page images are 0 KB.
At the 50th percentile (median), home page images are 8 KB and inner page images are 8 KB.
At the 75th percentile, home page images are 48 KB and inner pages are 52 KB.
At the 90th percentile, home page images are183 KB and inner pages are 186 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1086835098&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

Inner pages had smaller individual image file sizes than home pages with a median size of 4 KB. At the 90th percentile, homepage images were 185 KB while inner images were 123 KB.

{{ figure_markup(
 image="image-response-size-distribution-by-device.png",
 caption="Image size distribution by device",
 description="Bar chart showing distribution of image size across percentiles in kilobytes. At the 10th percentile, desktop pages are 74 KB and mobile are 56 KB. At the 25th percentile, desktop pages are 333 KB and mobile are 256 KB. At the 50th percentile (median), desktop pages are 1,058 KB and mobile are 911 KB. At the 75th percentile, desktop pages are 2,896 KB and mobile are 2,617 KB. At the 90th percentile, desktop pages are 6,856 KB and mobile are 6,288 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1892733774&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

A webpage rarely uses a single image. When aggregated together, the median desktop page used 1,059 KB of images. Mobile pages used 911 KB. Desktop pages consistently loaded more total image bytes.

{{ figure_markup(
 image="desktop-image-size-distribution-by-page-type.png",
 caption="Desktop image size distribution by page type.",
 description="Bar chart showing distribution of image size across percentiles in kilobytes. At the 10th percentile, home pages are 74 KB and mobile are 34 KB. At the 25th percentile, home pages are 333 KB and inner pages are 138 KB. At the 50th percentile (median), home pages are 1,058 KB and mobile are 442 KB. At the 75th percentile, home pages are 2,896 KB and mobile are 1,284 KB. At the 90th percentile, desktop pages are 6,856 KB and mobile are 3,431 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=178146605&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

Desktop home pages consistently used more images than their inner page counterparts. The median home page used 239% the image bytes of similar inner pages. At the 90th percentile, home pages used nearly twice the image bytes at 6,856 KB compared to inner pages at 3,431 KB.

{{ figure_markup(
 image="mobile-image-size-distribution-by-device.png",
 caption="Mobile image size distribution by device",
 description="Bar chart showing distribution of image size across percentiles in kilobytes. At the 10th percentile, home pages are 56 KB and inner pages are 23 KB. At the 25th percentile, home pages are 256 KB and inner pages are 95 KB. At the 50th percentile (median), home pages are 911 KB and inner pages are 354 KB. At the 75th percentile, home pages are 2,617 KB and inner pages are 1,134 KB. At the 90th percentile, home pages are 6,288 KB and inner pages are 3,147 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=542788776&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

In narrowing the scope of inner vs home page image use to only mobile devices, the trend continues. Mobile devices often have slower connection speeds and limited computational power when compared to desktop. This doesn't appear to deter mobile home pages from celebrating their topic with image bytes. The median mobile home page used 911 KB of images while inner pages used 354 KB. At the 90th percentile, mobile home pages used 6,288 KB of images, nearly matching their desktop equivalent of 6,856 KB.

{{ figure_markup(
 image="desktop-home-page-image-sizes-by-format.png",
 caption="Distribution of desktop home page image sizes by format.",
 description="Candlestick chart of the distribution of resource sizes by type for desktop pages. JPG ranged from 3 KB at the 10th percentile to 278 KB at the 90th percentile. WebP ranged from 1 KB at the 10th percentile to 97 KB at the 90th percentile. AVIF ranged from 1 KB at the 10th percentile to 37 KB at the 90th percentile. PNG ranged from 0 KB at the 10th percentile to 278 KB at the 90th percentile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2115033325&format=interactive",
 sheets_gid="1891741241",
 sql_file="response_media_file_type_distribution.sql"
 )
}}

The impact of file type on image size comes down to how the digital information is organized and discarded. While every image starts as a grid of raw pixels, the way a file format stores those pixels determines if the file is a few kilobytes or several megabytes.

JPG files are lossy file types. They permanently delete "unnecessary" data to achieve massive size reductions. How much is deleted is at the discretion of the file creator. This is likely why JPG file size spans the largest range, from 3 KB at the 10th percentile to 278 KB at the 90th.

WebP is considered the all-purpose file type for images. Available as both lossy and lossless, these file types spanned from 1 KB at the 10th percentile to 97 KB at the 90th.

AVIF is the newest of the widely adopted image file formats and was introduced in 2019 for its state of the art compression efficiency. This file format can be used for both lossy and lossless compression while producing high quality web images. AVIF ranged from 1 KB at the 10th percentile to 37 KB at the 90th percentile

PNGs are used to create large but perfect image files, making the format ideal for logos and icons. PNG ranged from 0 KB at the 10th percentile to 278 KB at the 90th percentile.

### JavaScript bytes

The growing weight of JavaScript is another significant trade-off as websites continue to lean on JavaScript to provide interactive features. While these scripts enhance user engagement, the consistent rise in payload size poses a challenge to site performance

It's important to note that this data set represents bytes for compressed JavaScript files. Depending on how effective compression was, this can be a significant difference. The larger the transfer (assuming compression) the discrepancy between uncompressed and compressed can be exponential. Additionally, inlined JavaScript in the HTML page is not represented on this data.

{{ figure_markup(
 image="javascript-file-sizes-by-device.png",
 caption="JavaScript file size distribution by device.",
 description="Bar chart showing distribution of JavaScript file size across percentiles in kilobytes. At the 10th percentile, desktop and mobile files are 0.4 KB. At the 25th percentile, desktop and mobile files are 1.2 KB. At the 50th percentile (median), desktop files are 4.6 KB and mobile files are 4.7 KB. At the 75th percentile, desktop files are 21.8 KB and mobile files are 21.6 KB. At the 90th percentile, desktop files are 83.5 KB and mobile files are 80.1 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1984047379&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

Much in the way that no one raindrop believes it caused the flood, the median individual JS file is quite small at 4.6 KB for desktop and 4.7 KB for mobile. Smaller JS files are ideal as they allow for small tasks to be completed without delaying response to user interaction. At the 10th percentile, the daintiest JS files were 0.4 KB for both device types. At the 90th percentile, desktop saw JS files at 83.5 KB and mobile saw 80.1 KB.

{{ figure_markup(
 image="javascript-size-distribution-by-device.png",
 caption="JavaScript size distribution by device.",
 description="Bar chart showing distribution of JavaScript size across percentiles in kilobytes. At the 10th percentile, desktop pages are 106 KB and mobile are 89 KB. At the 25th percentile, desktop pages are 303 KB and mobile are 270 KB. At the 50th percentile (median), desktop pages are 708 KB and mobile are 646 KB. At the 75th percentile, desktop pages are 1,291 KB and mobile are 1,233 KB. At the 90th percentile, desktop pages are 2,003 KB and mobile are 1,910 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1594171970&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

When the relatively small individual JS files are aggregated together, we get a better view of use on pages at large. JS use was relatively consistent between mobile and desktop. At the 10th percentile, desktop used 106 KB and mobile 89 KB. The median desktop page uses 708 KB of JS. This is slightly higher than mobile's 646 KB. These numbers quickly balloon past the median. At the 90th percentile, desktop used just over 2 MB and mobile used 1.9 MB.

Desktop pages at the 100th percentile used 189.9 MB of JavaScript and mobile used 181.1 MB. For perspective, downloading a standard definition 30 minute television show is about 150 MB.

{{ figure_markup(
 image="javascript-size-distribution-by-page-type.png",
 caption="JavaScript size distribution by page type.",
 description="Bar chart showing distribution of JavaScript size across percentiles in kilobytes. At the 10th percentile, home pages are 87 KB and inner pages are 108 KB. At the 25th percentile, home pages are 275 KB and inner pages are 298 KB. At the 50th percentile (median), home pages are 664 KB and inner pages are 690 KB. At the 75th percentile, home pages are 1,265 KB and inner pages are 1,258 KB. At the 90th percentile, home pages are 1,979 KB and inner pages are 1,933 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1867682888&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

Unlike images, JavaScript use was consistent between home pages and inner pages. At the 10th percentile, home pages used 87 KB and mobile used 108 KB of JS. Median home pages used 664 KB, while their inner page counterparts used 690 KB. At the 90th percentile, home and inner pages used 1,979 and 1,933 KB respectively.

#### Unused JavaScript

Unused JavaScript files represent not only a wasted opportunity but also page bloat. Every script called must be downloaded, parsed, compiled, and executed – regardless of whether it contributes to the page.

It's important to note that this data set comes from Lighthouse tests run in tandem with the Web Almanac crawl. Unused is unused javascript after it's been uncompressed. For example, amazon.co.uk downloads 423 KB of JS, but when it's uncompressed that's 1,721 KB.

{{ figure_markup(
 image="distribution-of-unused-javascript-by-device.png",
 caption="Distribution of unused JavaScript by device.",
 description="Bar chart showing distribution of unused JavaScript across percentiles in kilobytes. At the 10th percentile, desktop pages contained 23 KB unused JS and mobile contained 89 KB. At the 25th percentile, desktop pages contained 107 KB and mobile 94 KB. At the 50th percentile (median), desktop pages contained 280 KB and mobile 251 KB. At the 75th percentile, desktop pages contained 578 KB and mobile 530 KB. At the 90th percentile, desktop pages contained 1,004 KB and mobile 931 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=855411300&format=interactive",
 sheets_gid="1940153353",
 sql_file="lighthouse_unused_javascript.sql"
 )
}}

The median page saw a reasonable 280 KB of uncompressed, unused JavaScript on desktop and 251 KB on mobile. At the 100th percentile, desktop pages saw an astonishing 203.2 MB of uncompressed, unused JavaScript.

### Video bytes

While images are often the most numerous assets on a webpage, video bytes are the undisputed heavyweights of digital payload. As the web shifts toward "video-first" experiences—utilizing background "hero" videos, looping product previews, and embedded clips—the sheer volume of data transferred has reached unprecedented levels.

{{ figure_markup(
 image="video-response-size-distribution-by-device.png",
 caption="Video response size distribution by device.",
 description="Bar chart showing distribution of video response size across percentiles in kilobytes. At the 10th percentile, desktop files are 3 KB and mobile are 3 KB. At the 25th percentile, desktop files are 53 KB and mobile are 74 KB. At the 50th percentile (median), desktop video files are 247 KB and mobile are 384 KB. At the 75th percentile, desktop files are 1,383 KB and mobile are 1,871 KB. At the 90th percentile, desktop video files are 3,904 KB and mobile are 4,799 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2117267151&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

Video bytes for the median page increased 28% year over year from 246 KB in 2024 to 315 KB in 2025. Mobile consistently used more video bytes across all percentiles. At the 100th percentile, pages shipped 695 MB of video. To put this in context, if a user on a mobile device attempted to load one of these pages without a data plan in place (leaving them to pay [$0.15 cents per MB](https://www.telus.com/en/mobility/prepaid/plans)), the experience could cost them $104.10 for video bytes alone.

{{ figure_markup(
 image="distribution-of-desktop-video-response-sizes-by-page-type.png",
 caption="Distribution of desktop video response sizes by page type.",
 description="Bar chart of the distribution of desktop video resource sizes on home and inner pages. For home pages it is 2 KB at the 10th percentile, 53 KB at the 25th percentile, 288 KB at the median, 1,934 KB at the 75th percentile and 4,985 KB at the 90th percentile. For inner pages it was 1 KB, 54 KB, 206 KB, 832 KB and 2,823 KB respectively.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1538567564&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

More video bytes were shipped on home than inner pages for desktop. The median homepage saw 288 KB while inner pages came in at 206 KB. The gap between page types is largest in the 75th percentile where home pages come in at 1,934 KB, 232.6% larger than inner pages at 832 KB.

{{ figure_markup(
 image="mobile-video-response-size-distribution-by-page-type.png",
 caption="Mobile video response size distribution by page type.",
 description="Bar chart of the distribution of mobile video resource sizes on home and inner pages. For home pages it is 5 KB at the 10th percentile, 74 KB at the 25th percentile, 512 KB at the median, 2,624 KB at the 75th percentile and 6,144 KB at the 90th percentile. For inner pages it was 1 KB, 74 KB, 256 KB, 1,119 KB, 3,454 KB respectively.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=167542013&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

The pattern of more video bytes on homepages continued for mobile devices as well. The median home page shipped double the bytes (512 KB) compared to inner pages at 256 KB. At the 90th percentile, mobile home pages loaded 6.1 MB of video.

Several technical layers impact a video files size:

* File Formats: The "wrapper" (e.g., MP4, WebM) that holds the video and audio streams. While the container itself is light, the choice of container often dictates which efficient codecs can be used.
* Codecs (Compression/Decompression): The efficiency of the mathematical algorithm used to shrink the video. Legacy codecs like H.264 (AVC) are widely compatible but "heavy," whereas modern codecs like HEVC (H.265) and AV1 offer significantly better visual quality at a fraction of the byte count.
* Chroma Subsampling: A method of reducing file size by implementing lower resolution for color information than for brightness (luma) information, taking advantage of the human eye's higher sensitivity to brightness.

File formats are the most easily observed factor on video bytes. WebM files are designed specifically for the web. Common knowledge expects WebM files to be lighter than MP4s because they are built for the constraints of a browser.

{{ figure_markup(
 image="distribution-of-mobile-home-page-video-sizes-by-format.png",
 caption="Distribution of mobile home page video sizes by format.",
 description="Candlestick chart showing the distribution of mobile home page video by size. Each candlestick represents a video file format. The body indicates the range between 25th and 75th percentile, while the wicks represent the maximum and minimum throughput recorded. Quicktime body starts at 53.6 and ends at 4,627.2 KB. Mpeg body starts at 74.3 and ends at 3,256 KB. WebM body starts at 7.9 and ends at 58.6 KB. WebP Video body starts at 4.4 and ends at 48.2 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1471861495&format=interactive",
 sheets_gid="1891741241",
 sql_file="response_media_file_type_distribution.sql"
 )
}}

For the median percentile of mobile homepage videos, Quicktime files have the highest median response size (976.0 KB), followed by mpeg (639.5 KB) and WebM (581.8 KB). webp Video has a significantly smaller median size of 21.3 KB. WebP Video files are consistently the smallest across all measured percentiles, with a maximum size of 5,743.5 KB and a 90th percentile of 155.6 KB.

The largest home page desktop video files encountered were mpeg, coming at 326 MB for the 100th percentile.

{{ figure_markup(
 image="distribution-of-desktop-home-page-video-sizes-by-format.png",
 caption="Distribution of desktop home page video sizes by format.",
 description="Candlestick chart showing the distribution of desktop home page video by size. Each candlestick represents a video file format. The body indicates the range between 25th and 75th percentile, while the wicks represent the maximum and minimum throughput recorded. WebM body starts at 132.5 and ends at 2,751.4 KB. Quicktime body starts at 42.8 and ends at 2,574.6 KB. Mpeg body starts at 64.6 and ends at 6,124.8 KB. WebP Video body starts at 9.5 and ends at 93.6 KB.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=291934338&format=interactive",
 sheets_gid="1891741241",
 sql_file="response_media_file_type_distribution.sql"
 )
}}

While the high-end sizes are similar, the median (50th percentile) sizes vary, with WebM having the largest median at 860.22, followed by Quicktime (399.97 KB) and mpeg (326.52 KB). This suggests that a 'typical' webm file is larger than its quicktime or mpeg counterparts, despite the largest files being about the same size.

The median response size for webp Video is 32.58 KB, which is 10 to 26 times smaller than the median of the other formats. Even at the 90th percentile, webp Video's size of 228.33 is exceptionally small. This means 90% of webp Video files are smaller than the smallest 90% of the other three formats, where the 90th percentile is over 6,100.

The median size for WebM (860.22) is more than double that of quicktime (399.97) and almost triple that of mpeg (326.52), suggesting that while all formats can handle very large files, the center of the WebM distribution is skewed toward larger sizes.

The largest home page desktop video files encountered were Quicktime, coming at 431 MB for the 100th percentile.

### CSS bytes

Cascading style sheets or CSS have been used to stylise pages on the web for years, they are a relatively lightweight way to create the layout and control the visual elements of a page.

CSS works alongside HTML giving control of font styles, colors, spacing and even visibility of elements providing a more granular level of control but also a separation from other page aspects making it more maintainable. CSS is more lightweight than images and can help improve site performance by replacing large assets with CSS effects and animations.

{{ figure_markup(
 image="distribution-of-css-response-sizes-by-device-type.png",
 caption="Distribution of CSS response sizes by device type.",
 description="Bar chart of the distribution of CSS resource sizes by device type, across home and inner pages. At the 10th percentile, it is 10 KB for desktop and 7 KB for mobile, at the 25th percentile it is 38 KB for desktop and 34 KB for mobile, at the 50th percentile, it is 83 KB for desktop URLs, 79 KB for mobile URLs, at the 75th percentile it's 161 KB for desktop, 156 for mobile, and the 90th percentile it's 274 KB for desktop and 268 KB for mobile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1522118585&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

CSS bytes for mobile have grown in all percentiles except the bottom 10 where we saw a contraction versus last year.

However this growth is mostly modest when compared to other aspects of a page. At the 90th percentile the total file size is just slightly over ¼ of a mb, growing by just 8 KB against last year,

At the 50th percentile it was a growth of 4 KB against last year which is roughly an additional 4000 characters added to CSS files pointing to continued heavy use.

{{ figure_markup(
 image="distribution-of-css-response-sizes-by-page-type.png",
 caption="Distribution of CSS response sizes by page type.",
 description="Bar chart of the distribution of CSS resource sizes by page type, across mobile and desktop devices. At the 10th percentile, it is 7 KB for home pages and 10 KB for inner pages, at the 25th percentile it is 33 KB for home pages and 39 KB for inner pages, at the 50th percentile, it is 79 KB for home pages and 82 KB for inner pages, at the 75th percentile it's 159 KB for home pages and 158 KB for inner pages, and the 90th percentile it's 274 KB for home pages and 268 KB for inner pages.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1708847899&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

Inner pages follow this same trend of growth in all percentiles except the lowest 10th which again saw a 1 KB contraction.
Inner pages feature a slightly higher usage of CSS in the 25th, 50th and 75th percentile.

Notably when we get to the top end of the results, the 75th and 90th percentile, homepages actually have a greater CSS size. This could be due to inefficient use of CSS, i.e. loading the majority of files irrespective of use on the current page or potentially heavier reliance on CSS to provide visuals for all pages.

### HTML bytes

HTML bytes refers to the pure textual weight of all the markup on the page. Typically it will include the document definition and commonly used on page tags such as `<div>` or `<span>`. However it also contains inline elements such as the contents of script tags or styling added to other tags. This can rapidly lead to bloating of the HTML doc.

{{ figure_markup(
 image="distribution-of-html-response-sizes-by-device-type.png",
 caption="Distribution of HTML response sizes by device type.",
 description="Bar chart of the distribution of HTML response sizes by device type, across home and inner pages. At the 10th percentile, it is 6 KB for desktop and mobile. At the 25th percentile it is 14 KB for desktop and mobile. At the 50th percentile, it is 35 KB for desktop URLs and 33 KB for mobile URLs. At the 75th percentile, it's 78 KB for desktop and 76 for mobile. At the 90th percentile it's 152 KB for desktop and 151 KB for mobile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=884629714&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

HTML size remained uniform between device types for the 10th and 25th percentiles. Starting at the 50th percentile, desktop HTML was slightly larger. Not until the 100th percentile is a meaningful difference when desktop reached 401.6 MB and mobile came in at 389.2 MB.

{{ figure_markup(
 image="distribution-of-html-response-sizes-by-page-type.png",
 caption="Distribution of HTML response sizes by page type.",
 description="Bar chart of the distribution of HTML response sizes by device type. At the 10th percentile, it is 5 KB for home pages and 7 KB for inner pages. At the 25th percentile it is 14 KB for home pages and inner pages. At the 50th percentile, it is 34 KB for home pages URLs and 33 KB for inner pages URLs. At the 75th percentile, it's 79 KB for home pages and 76 for inner pages. At the 90th percentile it's 155 KB for home pages and 148 KB for inner pages.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=971853412&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

There is little disparity between inner pages and the home page for HTML size, only really becoming apparent at the 75th and above percentile. At the 100th percentile, the disparity is significant. Inner page HTML reached an astounding 624.4 MB – 375% larger than home page HTML at 166.5 MB.

{{ figure_markup(
 image="distribution-of-home-page-html-response-sizes-by-device-type.png",
 caption="Distribution of home page HTML response sizes by device type.",
 description="Bar chart of the distribution of home page HTML response sizes by device type, across home and inner pages. At the 10th percentile, it is 5 KB for desktop and mobile. At the 25th percentile it is 14 KB for desktop and 13 KB mobile. At the 50th percentile, it is 35 KB for desktop URLs and 33 KB for mobile URLs. At the 75th percentile, it's 80 KB for desktop and 78 for mobile. At the 90th percentile it's 154 KB for desktop and 155 KB for mobile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1083482035&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

The size difference between mobile and desktop is extremely minor, this implies that most websites are serving the same page to both mobile and desktop users.

This approach dramatically reduces the amount of maintenance for developers but does mean that overall page weight is likely to be higher as effectively two versions of the site are deployed into one page.

{{ figure_markup(
 image="distribution-of-inner-page-html-response-sizes-by-device-type.png",
 caption="Distribution of inner page HTML response sizes by device type.",
 description="Bar chart of the distribution of HTML response sizes by device type, across home and inner pages. At the 10th percentile, it is 6 KB for desktop and mobile. At the 25th percentile it is 14 KB for desktop and mobile. At the 50th percentile, it is 35 KB for desktop URLs and 33 KB for mobile URLs. At the 75th percentile, it's 78 KB for desktop and 76 for mobile. At the 90th percentile it's 152 KB for desktop and 151 KB for mobile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=213306109&format=interactive",
 sheets_gid="1861272244",
 sql_file="bytes_per_type.sql"
 )
}}

Inner pages behaved similar to their home page counter parties through the 90th percentile. At the 100th percentile, the largest inner page HTML response was the same for both device types: 624.4 MB. On a standard 10-25 Mbps connection, this would take 30 to 90 seconds to load.

### Font bytes

While images and videos are the most obvious contributors to page bloat, web fonts represent a subtle but significant portion of modern page weight. Often overlooked during the design phase, the transition from system-standard fonts to custom "web fonts" has introduced a new layer of latency. Every unique weight (bold, light, thin) and style (italic) of a typeface requires a separate file download, meaning a single font family can quickly balloon into several hundred kilobytes of additional data.

The "weight" of these fonts is determined by three main factors:

1. Character Support: A font that includes support for multiple languages (Latin, Cyrillic, Greek) contains thousands more "glyphs" (the shapes of the letters) than a basic English-only font.
2. Styles and Weights: Each variation (e.g., Roboto Regular, Roboto Bold, Roboto Bold Italic) is typically a distinct file. Loading a full "family" can be heavier than a large optimized image.
3. Format Efficiency: Older formats like TTF (TrueType) and OTF (OpenType) are uncompressed, whereas modern web-specific formats like WOFF2 use Brotli compression to reduce file sizes by up to 30% without losing quality.

{{ figure_markup(
 image="distribution-of-font-response-sizes-by-device-type.png",
 caption="Distribution of font response sizes by device type.",
 description="Bar chart of the distribution of font response sizes by device type, across home and inner pages. At the 10th percentile, it is 9 KB for desktop and 8 KB for mobile. At the 25th percentile it is 15 KB for desktop and 14 KB for mobile. At the 50th percentile, it is 23 KB for desktop URLs and mobile. At the 75th percentile, it's 47 KB for desktop and 45 KB for mobile. At the 90th percentile it's 79 KB for desktop and 80 KB for mobile.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=145051765&format=interactive",
 sheets_gid="263221798",
 sql_file="response_type_distribution.sql"
 )
}}

The median page shipped 23 KB of fonts. Bytes shipped remained closely matched between devices through the 90th percentile. Home pages and inner pages shipped the exact same amount of bytes across percentiles with 23 KB representing the median.

### Other file types

Ultimately the web is a diverse ecosystem with many file types. Some lesser encountered file types include 15 KB of WASM, 12 KB of audio, on the median page and across device types, audio. JSON, XML, and txt file types saw 0 KB of use on the median page. It's noteworthy that at least one site is shipping 117.6 MB of JSON on mobile pages, landing it the title of largest infrequent file type.

## Page weight in request volume

While the total number of bytes measures the raw volume of data, the volume of requests measures the complexity of the conversation between the browser and the server. Studying page weight through both lenses is essential because a "light" page (in bytes) can still be "slow" if it requires too many individual requests to render. Bytes represent the bandwidth required to download a page. The volume of requests represents the latency overhead inherent in web architecture.

### File type volume for the median page

To understand what file types contribute the most to page weight, we looked at the file type requests by the median page (50th percentile). This approach establishes a baseline for measuring the overall impact of each file type.