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
featured_quote: Ultimately there is massive opportunity for improvements here without impacting the user experience at all
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

Websites may be changing their rendering strategies, sometimes prompted by rethinking how websites are accessed and consumed by the growing AI chatbots and other large language model tools. Not all of these changes are aimed at AI crawler accessibility. Some testing has been done to identify the technical requirements for AI crawler accessibility, as these may vary between crawlers. We do know that all key information should be present in the initial raw HTML, since <a hreflang="en" href="https://vercel.com/blog/the-rise-of-the-ai-crawler">AI crawlers do not render JavaScript</a>.

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
  description="Bar chart showing distribution of image file size across percentiles in kilobytes. At the 10th percentile, home page and inner page images are 0 KB. At the 25th percentile, home page images are 1 KB and inner page images are 0 KB. At the 50th percentile (median), home page images are 8 KB and inner page images are 8 KB. At the 75th percentile, home page images are 48 KB and inner pages are 52 KB. At the 90th percentile, home page images are183 KB and inner pages are 186 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1086835098&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

Inner pages had smaller individual image file sizes than home pages with a median size of 4 KB. At the 90th percentile, homepage images were 185 KB while inner images were 123 KB.

{{ figure_markup(
  image="image-size-distribution-by-device.png",
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

Video bytes for the median page increased 28% year over year from 246 KB in 2024 to 315 KB in 2025. Mobile consistently used more video bytes across all percentiles. At the 100th percentile, pages shipped 695 MB of video. To put this in context, if a user on a mobile device attempted to load one of these pages without a data plan in place (leaving them to pay <a hreflang="en" href="https://www.telus.com/en/mobility/prepaid/plans">$0.15 cents per MB</a>), the experience could cost them $104.10 for video bytes alone.

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

{{ figure_markup(
  image="median-number-of-requests-by-content-type-and-device-type.png",
  caption="Median number of requests by content type and device type.",
  description="Bar chart showing the median number of requests by content type and device type. The median desktop page loads 3 HTML files, 4 font files, 8 CSS files, 14 images and 23 JavaScript files, and 73 total files. The median mobile page loads 3 HTML files, 3 font files, 8 CSS files, 12 images, 22 JavaScript files and 68 requests in total.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=634930478&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

The median page makes 77 requests on desktop and 72 on mobile. Overall requests grew 9% year over year on mobile and 8% on desktop. Image file types continued their downward trend in 2025, decreasing 6% year-over-year.

Requests by file type remained largely consistent year over year. The median desktop calls 77 resources while its mobile counterpart requires only 72. The number of HTML files returned increased from 2 to 3 across both page types. Median homepage CSS increased slightly to match the use on inner pages, which remained stable year-over-year. JavaScript remained the most requested file type.

{{ figure_markup(
  image="median-number-of-requests-by-content-type-and-page-type.png",
  caption="Median number of requests by content type and page type.",
  description="Bar chart showing the median number of requests by content type and page type. The median home page loads 3 HTML files, 4 font files, 8 CSS files, 19 images and 22 JavaScript files for 78 files total. The median inner page loads 3 HTML files, 4 font files, 8 CSS files, 13 images, 23 JavaScript files for 71 files total.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1228002945&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

The median home page loads 3 HTML files, 4 font files, 8 CSS files, 19 images and 22 JavaScript files for 78 files total. The median inner page loads 3 HTML files, 4 font files, 8 CSS files, 13 images, 23 JavaScript files for 71 files total.

### Request volume distribution

With our meridian behaviors established, we can step back to look at our data across percentiles. Percentiles provide a clear picture of how data points are spread out, making it easier to interpret patterns.

{{ figure_markup(
  image="distribution-of-request-volume-by-device-type.png",
  caption="Distribution of request volume by device type.",
  description="Bar chart of request volume distribution by device type. At the 10th percentile, desktop made 27 requests and mobile made 25. At the 25th percentile, desktop made 46 and mobile made 42 requests. At the 50th percentile, desktop made 77 and mobile made 72 requests. At the 75th percentile, desktop made 122 and mobile made 116 requests. At the 90th percentile, desktop made 185 and mobile made 179 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=959675191&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

Even the lightest of pages got heavier this year. At the 10th percentile, the most spartan pages added 3 requests this year. In contrast, the 90th percentile requested 9 additional files. This illustrates that mobile and desktop make the same number of requests, as demonstrated by the extremes.

{{ figure_markup(
  image="distribution-of-request-volume-by-page-type.png",
  caption="Distribution of request volume by page type.",
  description="Bar chart of request volume distribution by page type. At the 10th percentile, desktop made 25 and mobile made 26 requests. At the 25th percentile, desktop made 45 and mobile made 43 requests. At the 50th percentile, desktop made 78 and mobile made 71 requests. At the 75th percentile, desktop made 125 and mobile made 113 requests. At the 90th percentile, desktop made 190 and mobile made 174 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=68159977&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

When viewing the data grouped by homepage versus inner page, increases in file requests were consistent across all percentiles. The median page makes 77 requests on desktop and 72 on mobile. The gap between homepages and inner pages increases as the percentile grows.

This is particularly interesting, as we see consistency in the number of requests when viewing the data by mobile vs. desktop, indicating that homepage requests are a key differentiator.

{{ figure_markup(
  image="distribution-of-request-volume-by-device-type.png",
  caption="Distribution of request volume by device type.",
  description="Bar chart of request volume distribution by device type. At the 10th percentile, desktop made 26 and mobile made 24 requests. At the 25th percentile, desktop made 47 and mobile made 43 requests. At the 50th percentile, desktop made 80 and mobile made 75 requests. At the 75th percentile, desktop made 127 and mobile made 122 requests. At the 90th percentile, desktop made 192 and mobile made 187 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=907352762&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

Viewing homepage requests by device type allows deep analysis. Each device requires slightly more requests than when home and inner pages data is blended. The median desktop homepage makes 80 requests while its mobile counterpart makes 75. Behavior remains consistent across devices, with minor variance in percentiles.

### Image Request Volume

Some say the internet was created for cat pictures. While that may be an exaggeration from devoted animal lovers, it highlights the fact that visual content dominates the web.

Images play a vital role in everything from product verification to credible news reporting. Yet, these static files are often among the heaviest digital resources, making them prime candidates for performance optimization and technological innovation.

{{ figure_markup(
  image="distribution-of-image-requests-by-device-type.png",
  caption="Distribution of image requests by device type.",
  description="Bar chart of image request volume distribution by device type. At the 10th percentile, desktop made 5 and mobile made 4 requests. At the 25th percentile, desktop made 9 and mobile made 8 requests. At the 50th percentile, desktop made 17 and mobile made 15 requests. At the 75th percentile, desktop made 32 and mobile made 28 requests. At the 90th percentile, desktop made 56 and mobile made 52 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2111722175&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

At the 50th percentile, desktop made 17 and mobile made 15 images requests. Desktop used more image files consistently across percentiles. This is a slight decrease from 2024 where desktop pages called 18 images and mobile requested 16. At the 100th percentile, desktop pages requested 26,330 images. We can only imagine how magical that page must be.

{{ figure_markup(
  image="distribution-of-image-requests-by-page-type.png",
  caption="Distribution of image requests by page type.",
  description="Bar chart of image request volume distribution by page type. At the 10th percentile, desktop made 5 and mobile made 4 requests. At the 25th percentile, desktop made 10 and mobile made 7 requests. At the 50th percentile, desktop made 19 and mobile made 13 requests. At the 75th percentile, desktop made 35 and mobile made 25 requests. At the 90th percentile, desktop made 62 and mobile made 46 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1855976921&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

When comparing homepages to inner pages, the difference remains consistent: the median homepage loads 19 images versus 13 on an inner page. This pattern holds across the full distribution range and closely mirrors 2024"s data, where homepages averaged 20 image requests and inner pages 14.

Although there"s a slight decrease in image requests, a trend also reflected at the 75th and 90th percentiles, the minimal changes suggest no major shift in how site owners or publishers approach imagery. Instead, it appears to be business as usual in web image usage.

### CSS Request Volume

Cascading Style Sheets (<a hreflang="en" href="https://web.dev/css">CSS</a>) act as the presentation layer of the web. It's a style language that allows developers to define the layout of a document written in a markup language that is visually presented. In the scope of the web almanac, then exclusively html. Occasionally, SVGs might also account for some.

CSS enables the developer to specify elements such as colours, fonts, layout and sizing ,separating presentation from the structural content defined in HTML. It continues to grow increasingly more powerful, offering interesting capabilities for responsive design, touches of animation or sophisticated layouts. Visual effects that once required JavaScript can now be done through CSS, making CSS a basis for modern web design.

{{ figure_markup(
  image="distribution-of-css-requests-by-device-type.png",
  caption="Distribution of CSS file requests by device type.",
  description="Bar chart showing the distribution of CSS file requests for homepages by device type and percentile. The 10th percentile desktop page loads 2 CSS files and mobile 1, the 25th 4 CSS files on desktop and mobile also 4, the 50th 8 CSS files on desktop and 8 on mobile, the 75th 16 CSS files on desktop, 16 on mobile, and the 90th 31 CSS files on desktop, 31 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1968461101&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

Across all both desktop and mobile devices, there was very little difference in the amount of CSS a page requested. At the 50th percentile, both mobile and desktop devices requested 8 CSS resources, there was no more than 1 resource request difference across the whole distribution. This very much matches 2024's pattern, and indeed up to the 90th percentile were more or less stable in the amount of requests, compared year over year

At the 90th percentile, 31 desktop and 30 mobile CSS requests were made this year, a slight increase over 2024's 26 on both desktop and mobile. This suggests that there's been little change to developer approaches to CSS over the preceding 12 months in terms of how many separate assets they are split into, nor the tools they use.

It also points to developers being far more likely serving the same CSS files, regardless of client type.

{{ figure_markup(
  image="distribution-of-css-requests-by-page-type.png",
  caption="Distribution of CSS file requests by page type.",
  description="Bar chart showing the distribution of CSS file requests by page type and percentile. The 10th percentile homepages page loads 1 CSS files and inner pages 2, the 25th 3 CSS files on homepages and inner pages 4, the 50th 8 CSS files on homepages and 8 on inner pages, the 75th 16 CSS files on homepages, 16 on inner pages, and the 90th 31 CSS files on homepages, 30 on inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=633938007&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

The median page made 8 CSS requests. Inner pages made more requests than home pages through the 75th percentile. At the 90th percentile, the home page made 1 more request than the inner pages.

There is very little variation in the number of files requested on home pages compared to inner pages. Whilst we can't tell from this analysis if it's the same files being served, it does point to the fact that developers are shipping one set of CSS resources across the whole site, which could be a missed opportunity to reduce the weight of CSS on individual pages by splitting these, and only sending the CSS needed for the actual page.

### JavaScript Request Volume

While images and videos are static weight, JavaScript is active weight. Its impact is unique because it consumes resources twice: once when it is downloaded (network) and again when it is executed (CPU). When JavaScript is split into a high volume of requests—often due to modular coding practices or third-party plugins—it introduces a "Double Tax" on performance.

Even if the total byte count remains low, a high volume of script requests can paralyze a browser's main thread, leading to a site that looks loaded but remains unresponsive to user input.

{{ figure_markup(
  caption="Pages using JavaScript.",
  content="98.1%",
  classes="big-number",
  sheets_gid="1751156584",
  sql_file="pages_using_javascript.sql"
  )
}}

98.1% of all pages make at least one request for a JS file. This number doesn't include inlined JavaScript which can be found in HTML.

{{ figure_markup(
  image="distribution-of-javascript-requests-by-device-type.png",
  caption="Distribution of JavaScript requests by device type.",
  description="Bar chart of JavaScript request volume distribution by device type. At the 10th percentile, desktop made 5 and mobile made 4 requests. At the 25th percentile, desktop made 11 and mobile made 10 requests. At the 50th percentile, desktop made 23 and mobile made 22 requests. At the 75th percentile, desktop made 40 and mobile made 38 requests. At the 90th percentile, desktop made 67 and mobile made 65 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=414642373&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

The median desktop page made 23 requests for JS on desktop and 22 on mobile. Desktop pages consistently called for more JS files than mobile. Desktop home pages called for the most JavaScript files with 12,676 being requested at the 100th percentile. The Web Almanac crawler earned its annual hibernation this year.

{{ figure_markup(
  image="distribution-of-javascript-request-volume-by-page-type.png",
  caption="Distribution of JavaScript request volume by page type.",
  description="Bar chart of JavaScript request volume distribution by page type. At the 10th percentile, home pages made 4 and inner pages made 5 requests. At the 25th percentile, home pages made 10 and inner pages made 43 requests. At the 50th percentile, home pages made 22 and inner pages made 23 requests. At the 75th percentile, home pages made 38 and inner pages made 39 requests. At the 90th percentile, home pages made 65 and inner pages made 67 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=976800240&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

Inner pages consistently called slightly more JavaScript files than home pages. The median home page requested 22 JS files while its small screened counterpart called 23.

### Fonts Request Volume

Font files allow the website to specify styling for the text parts of the website, typically they consist of all letters from A-Z both upper and lowercase. This allows the browsers to transform text into other styles than just the system installed fonts.

{{ figure_markup(
  image="distribution-of-font-requests-by-device-type.png",
  caption="Distribution of font requests by device type.",
  description="Bar chart of font request volume distribution by device type. At the 10th percentile, desktop and mobile made 0 requests. At the 25th percentile, desktop and mobile made 2 requests. At the 50th percentile, desktop and mobile made 4 requests. At the 75th percentile, desktop made 7 and mobile made 6 requests. At the 90th percentile, desktop made 10 and mobile made 9 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1061546215&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

The bottom 10th percentile do not use extra font requests, relying instead on the system installed fonts for both mobile and desktop. Mobile font requests are lower above the 75th percentile with one fewer request on average.

{{ figure_markup(
  image="distribution-of-font-requests-by-page-type.png",
  caption="Distribution of font request by page type.",
  description="Bar chart of JavaScript request volume distribution by page type. At the 10th percentile, home pages and inner pages made 0 requests. At the 25th percentile, home pages and inner pages made 2 requests. At the 50th percentile, home pages and inner pages made 4 requests. At the 75th percentile, home pages made 7 and inner pages made 6 requests. At the 90th percentile, home pages and inner pages made 10 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1855939241&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

Home pages and inner pages are identical in average requests with the one exception at the 75th percentile. Desktop homepages loaded the most fonts with 3,038 files requested at the 100th percentile. We truly hope the site in question is a font repository with performance optimizations prioritized for Q1.

Broadly it would be expected that different fonts are not used on individual pages but rather as a style across the site. There are exceptions to this, such as for promotional material, but the average indicates that most of the time imported fonts are used across the whole site.

### Other Request Volume

The request volume of "utility" files—including HTML fragments, JSON data, and third-party assets—creates a significant, cumulative "latency tax." In modern web architecture, particularly with the rise of microservices and modular design, a single page load can trigger dozens of requests for small, disparate files. Even if these files are lightweight in terms of bytes, the sheer quantity of requests can overwhelm the browser"s network stack and delay the rendering of the page.

The median page made 2 requests for HTML and 2 other file types. At the 90th percentile, this climbs to 12 HTML and 12 other file types. Still, there are some out there committed to setting new records for innocuous file types. Somewhere out there, there's a desktop inner page requesting 17,065 other file types for a page load. They have achieved the dream of being the 100th percentile. You did it, buddy. Put the JSON down.

## Adoption rates of byte-saving technologies

### Facades for videos & other embeds

Facades, also termed import on interaction, is a design pattern that replaces heavy items, such as video embeds, social media posts or chat widgets with a simple graphical representation that is only replaced by the full, interactive element when users interact.

Think of a simple thumbnail for a video that loads the youtube embed, and all the associated data and resources when users click on it.

This can provide performance improvements as users aren't trying to download these extra resources at page load time, and ultimately save page weight. If users don't want to see that video or open a chat bot session those bytes are never requested.

Detection of sites that are using facades is not really possible. However, Lighthouse, prior to the release of version 13, did have a test for common embeds that do have recognised facade solutions, called <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/performance/third-party-facades">Lazy load third-party resources with facades</a>. The crawl this year was run with version 12, so we had access to this metric.

{{ figure_markup(
  image="sites-that-could-implement-third-party-facades.png",
  caption="Sites that could implement Third-party facades.",
  description="Bar chart showing the percentage of sites that could benefit from third-party facades. 77% of desktop homepages and 74% of desktop inner pages, and 41% of mobile home pages and 46% of mobile inner pages could benefit from third-party facades, as measured by lighthouse.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=39146949&format=interactive",
  sheets_gid="940263948",
  sql_file="facades-usage.sql"
  )
}}

41% of home pages on mobile loads and 77% of home pages loaded with the desktop client were detected as having an opportunity to implement lazy loading with facades. This represents a regression from 2024 for desktop, where 70% were detected, but mobile loads represent an improvement from 45%.

Like 2024, mobile pages seem more likely to implement a facade than desktop pages.

Interestingly inner pages scored better on desktop at 74% and yet worse on mobile at 46%. Perhaps developers are focusing more on home page performance for their mobile visitors?

The figures do show there could be significant opportunities to reduce page weight, but likewise, they aren't without their own issues, with sometimes perceptible delays once a user does interact with the element, and with videos in particular, double clicks or taps needed to start playing.

But it is worth assessing the embeds you have on your page, and see if any could benefit from implementing this approach.

### Compression

Compression involves reducing the size of a resource before it's sent across the network to a device, where it's then decompressed. This process usually leads to faster page loads, especially when the network is the biggest bottleneck.

HTTP compression applied to text based files, like HTML, CSS, JavaScript, JSON, SVG, ico and ttf font files, can offer great over the wire page weight savings. It's worth noting the benefits don't extend to other file types, eg media, where the compression is part of their encoding.

Using <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Glossary/gzip_compression">GZIP</a>, <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Glossary/Brotli_compression">Brotli</a>, or the new kid on the compression block, <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Glossary/Zstandard_compression">Zstandard</a> (zstd) to compress HTTP requests can often significantly reduce the weight of these text-based resources, increasing performance.

It needs to be noted that compression doesn't entirely make page weight issues go away, they do need to be decompressed to their full size, and the process of compressing and decompressing could, if overdone, slow down the overall speed, although that would be a rare occurrence, certainly over the network bytes saved.

{{ figure_markup(
  image="proper-text-compression-usage.png",
  caption="Proper text compression usage.",
  description="Bar chart showing the percentage of sites that use correct text compression. 70% of desktop homepages and 71% of desktop inner pages, and 72% of mobile home pages and 73% percent of mobile inner pages correctly compress text based resources, as measured by Lighthouse.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=884349858&format=interactive",
  sheets_gid="125291842",
  sql_file="compression-usage.sql"
  )
}}

In 2025, 71% of desktop and 72% of mobile home page loads had proper text compression, as measured by [Lighthouse's Enable text compression audit](https://developer.chrome.com/docs/lighthouse/performance/uses-text-compression/).

For inner pages, the pass rates were slightly higher at 72% on desktop and 73% on mobile.

This shows a small improvement compared to 2024, when homepages had a 70% desktop and 71% mobile pass rate, and inner pages reached a 71% desktop and 72% inner page pass rate. In other words, each segment improved by just 1 percentage point year over year.

While any increase is positive, it still is slightly disappointing that over 25% of pages across all devices and page types, still fail to use efficient compression.

### Minification

<a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Glossary/Minification">Minifying</a> text resources removes unnecessary data, such as spaces, comments and can even shorten function and variable names to leave a smaller file.

There is no additional client side overhead in minifying, In other words, a file doesn't need to be *unminified* to work.Any overhead is purely server side if done on the fly.

However, for many resources, such as CSS or JavaScript, minification can be handled upfront as part of the build process. It only needs to be done once.

{{ figure_markup(
  image="minified-css-usage.png",
  caption="Minified CSS proper usage.",
  description="Bar chart showing the percentage of sites that correctly minify CSS resources. 61% of desktop homepages and inner pages, and 62% of mobile homepages and 61% of mobile inner pages correctly minify CSS, as measured by lighthouse.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=833067377&format=interactive",
  sheets_gid="1585520251",
  sql_file="minified_css_usage.sql"
  )
}}

2025's analysis shows that 61% of desktop, 62% of mobile home page loads, and 61% of desktop and mobile inner page loads passed lighthouse's <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/performance/unminified-css/">Minify CSS</a> audit.

This means a slight decline from 2024, with each metric dropping by 1%, a small but unfortunate trend

{{ figure_markup(
  image="minified-javascript-usage.png",
  caption="Minified JavaScript proper usage.",
  description="Bar chart showing the percentage of sites that correctly minify JavaScript resources. 61% of desktop homepages and 61% of inner pages, and 63% of mobile homepages and 61% of mobile inner pages correctly minify JavaScript, as measured by lighthouse.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2109774882&format=interactive",
  sheets_gid="707175110",
  sql_file="minified_js_usage.sql"
  )
}}

In 2025, 62% of desktop and 63% of mobile home page loads passed Lighthouse's <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/performance/unminified-javascript/">Minify JavaScript</a> test.

For inner pages, the result was similar: 61% of desktop and 63% of mobile loads passed.

This represents an improvement from 2024, when 58% of desktop and 57& of mobile home pages passed and 59% of desktop and 58% of mobile inner pages did the same.

Although this year's slight decline in correctly minified CSS is somewhat, it is encouraging to see a bigger increase in JavaScript being minified, even when there still is plenty of room for further adoption.

### Caching

The sensible use of caching rules can help mitigate excessive page weight. When a common resource is cached locally by the browser, it does not need to be downloaded again as visitors navigate that website or even when they return later. This results in fewer network requests and faster page loads.

Naturally, this doesn't entirely mitigate the issue of heavy resources, they still have to be requested and downloaded at least once.

Caching is most effective for static resources, ones that are unlikely to change between requests.

Lighthouse offers a <a hreflang="en" href="https://developer.chrome.com/docs/performance/insights/cache">use efficient cache lifetimes</a> audit, which looks for static resources called by a page that have a cache lifetime of at least 30 days,unless explicitly set to not be cached.

{{ figure_markup(
  image="distribution-of-wasted-kb-on-home-pages-due-to-short-cache-ttl.png",
  caption="Distribution of wasted KB on home pages due to short cache TTL",
  description="Column chart of the distribution of potential wasted resource loads due to low cache time to live settings, across device types. At the 10th percentile, it is 4 KB for desktop and 4 KB for mobile pages, at the 25th percentile it is 74 KB for desktop and 66 KB for mobile, at the 50th percentile, it is 303 KB for desktop, 270 KB for mobile, at the 75th percentile it's 1,379 KB for desktop, 1,176 KB for mobile, and the 90th percentile it's 4,654 KB for desktop and 3,764 KB for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=191142815&format=interactive",
  sheets_gid="1976787459",
  sql_file="use-efficient-cache-lifetimes.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-wasted-kb-on-inner-pages-due-to-short-cache-ttl.png",
  caption="Distribution of wasted KB on inner pages due to short cache TTL",
  description="Column chart of the distribution of potential wasted resource loads due to low cache time to live settings, across device types. At the 10th percentile, it is 4 KB for desktop and 4 KB for mobile pages, at the 25th percentile it is 62 KB for desktop and 56 KB for mobile, at the 50th percentile, it is 220 KB for desktop, 201 KB for mobile, at the 75th percentile it's 794 KB for desktop, 705 KB for mobile, and the 90th percentile it's 2,248 KB for desktop and 1,946 KB for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=385053741&format=interactive",
  sheets_gid="1976787459",
  sql_file="use-efficient-cache-lifetimes.sql"
  )
}}

The data shows that many websites could reduce page weight by making better use of browser caching. For desktop home pages, the median site could save around 303 KB, while mobile home pages could save approximately 270 KB if resources were consistently loaded from cache.

Inner pages perform slightly better, but there"s still room for improvement. The median potential savings are 220 KB on desktop and 201 KB on mobile.

These numbers represent potential savings. They don"t apply to first-time visitors and there"s no guarantee that any given resource will be cached or subsequently retrieved from the browser cache.

However, given the potential savings, it may be worth reviewing your cache strategy. For example, consider looking at cache timings and review the guidance in <a hreflang="en" href="https://web.dev/articles/http-cache">Prevent unnecessary network requests with the HTTP Cache</a> article on eb.dev. Some adjustments may lead to faster experiences for returning users and reduce unnecessary network activity.

### CDNs

Like caching, CDNs are not a definite solution for page weight, as they do not reduce file size by default. Instead, they serve as a mitigation .

CDNs can cache and serve content from a server geographically closer to the user than the origin server. This means that, while resources do not become lighter, the reduced physical distance means faster content delivery and improved perceived performance.

Many CDNs also offer additional features, such as handling compression, re-encoding and resizing of assets like images and video. These features are often automatic or near-automatic,ie, they require minimal development time, and can provide a simple way to reduce actual page weight..

If you are struggling to implement these page weight saving optimisation techniques, it may be worth evaluating what your current CDN service offers, if you already use one, or exploring other CDN providers to see what their built-in tools might offer.
CDNs grow increasingly prevalent and powerful, and we recommend getting more insights in the [CDN Chapter](./cdn).

## Page weight and Core Web Vitals

This year, we were able to include <a hreflang="en" href="https://developers.google.com/search/docs/appearance/core-web-vitals">Core Web Vitals</a> data in our analysis. These new insights come with an important caveat: not all pages have URL-level CrUX data.

To be clear, CrUX or Chrome User Experience data is the data that is collected from opt-in Chrome users as they browse websites. This data reflects how actual users experience a web page, instead of how it performs in a controlled environment.

To be included in the CrUX dataset, a page must drive <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#popularity-eligibility">a minimum number of visitors</a>. As a result, the dataset will be weighted toward more popular sites and doesn't represent the entire crawl corpus.

Despite this limitation, we hope that you find these findings, as they offer a valuable perspective while we work to balance functionality and page weight on the ever-changing web.

{{ figure_markup(
  caption="Mobile pages weighing 2-3 MB pass Core Web Vitals",
  content="45%",
  classes="big-number",
  sheets_gid="131977176",
  sql_file="pass-all-cwv-by-mb-home-inner.sql"
  )
}}

Core Web Vitals are a set of human-centric metrics designed to measure the quality of the human experience when interacting with websites. The focus is on three key areas:

1. Largest Contentful Paint, which measures visual loading
2. Cumulative Layout Shift, which measures visual stability
3. Interaction to Next Time, which measures interactivity

### CrUX data: Core Web Vitals assessment by weight

For a page to pass the Core Web Vitals assessment, it must have CrUX user data showing good LCP and CLS metrics at the 75th percentile, and its INP must either be good at the 75th percentile or be entirely absent. INP measures interactivity, and because not every page drives visits, INP dataset tends to be the most sparse. While page weight is not a part of their calculation, the data shows a clear correlation between total megabytes and pass rates.


{{ figure_markup(
  image="pct-of-home-pages-passing-cwv-by-page-weight.png",
  caption="Percentage of home pages passing core web vitals, by page weight.",
  description="Bar chart showing the percentage of home pages passing all three core web vitals at different page weights. For pages up to 1 MB, 70% of desktop and 57% of mobile pages passed. Between 1 MB and 2 MB, 59% of desktop and 52% of mobile pages passed. Between 2 MB and 3 MB 53% of desktop, 45% of mobile pages passed. Between 3 MB and 4 MB 48% of desktop and 38% of mobile pages passed. Between 4 MB and 5 MB, 44% of desktop and 34% of mobile pages passed. For pages of 5 MB or greater, 38% of desktop and 30% of mobile pages passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1228614280&format=interactive",
  sheets_gid="131977176",
  sql_file="pass-all-cwv-by-mb-home-inner.sql"
  )
}}

70% of desktop home pages under 1 MB passed this assessment. In contrast, only 38% of home pages 5 MB or larger passed, which is nearly half the success rate of their lighter counterparts. Mobile pages show a similar pattern: . 57% of pages under1 MB passed compared to only 30% of those 5 MB or larger. Passing rates decline steadily as home page weight increases with mobile consistently lagging behind desktop across all weight categories.

In 2025, the median home page was 2.9 MB for desktop and 2.6 MB on mobile. Within the 2-3 MB range, 63% of desktop pages passed the Core Web Vitals assessment. Because these figures rely on CrUX field data, they primarily reflect the performance of the most popular sites. For mobile in the same weight range, 53% of pages passed.

{{ figure_markup(
  image="pct-of-inner-pages-passing-cwv-by-page-weight.png",
  caption="Percentage of inner pages passing core web vitals, by page weight.",
  description="Bar chart showing the percentage of inner pages passing all three core web vitals at different page weights. For pages up to 1 MB, 79% of desktop and 68% of mobile pages passed. Between 1 MB and 2 MB, 66% of desktop and 55% of mobile pages passed. Between 2 MB and 3 MB 63% of desktop, 63% of mobile pages passed. Between 3 MB and 4 MB 58% of desktop and 50% of mobile pages passed. Between 4 MB and 5 MB, 56% of desktop and 47% of mobile pages passed. For pages of 5 MB or greater, 50% of desktop and 42% of mobile pages passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=819647158&format=interactive",
  sheets_gid="131977176",
  sql_file="pass-all-cwv-by-mb-home-inner.sql"
  )
}}

As observed above, inner pages tend to be lighter than home pages. In 2025, the median homepage weighted 2.9 MB for desktop and 2.6 MB for mobile. Inner pages were lighter in comparison, with median sizes of 1.8 MB for mobile, and 2 MB for desktop.

The data shows a softened pattern for inner pages than home pages. 79% of desktop inner pages weighing under 1 MB passed the Core Web Vitals assessment. 50% of inner pages 5 MB or larger passed the assessment. Mobile pages are less likely to pass, and passing rates decline gradually with each additional megabyte.

### CrUX data: Largest Contentful Paint by weight

<a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP) measures how long it takes for the largest image, text block or video in the viewport to render, starting when the user starts navigating to the page. A page achieves a passing score when the 75th percentile of user experiences fall under in 2.5 seconds.

{{ figure_markup(
  image="pct-of-home-pages-with-good-lcp-by-page-weight.png",
  caption="Percentage of home pages with good Largest Contentful Paint, by page weight.",
  description="Bar chart showing the percentage of home pages with good Largest Contentful Paint at different page weights. For pages up to 1 MB, 82% of desktop and 72% of mobile pages passed. Between 1 MB and 2 MB, 76% of desktop and 65% of mobile pages passed. Between 2 MB and 3 MB 71% of desktop, 59% of mobile pages passed. Between 3 MB and 4 MB 67% of desktop and 54% of mobile pages passed. Between 4 MB and 5 MB, 64% of desktop and 50% of mobile pages passed. For pages of 5 MB or greater, 57% of desktop and 44% of mobile pages passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1743591811&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

The lightest pages passed LCP, with 82% of desktop and 72% of mobile pages achieving a passing score. Pages in the 2-3 MB range, which represents the median page weight, passed at rates of 71% for desktop and 59% for mobile. The heaviest of pages, ie, those 5 MB or larger, passed rates dropped to 57% for desktop and 44% for mobile.

{{ figure_markup(
  image="home-page-lcp-by-page-weight-crux.png",
  caption="Largest Contentful Paint of home pages in seconds by page weight grouping.",
  description="Bar chart showing the time until Largest Contentful Paint on home pages grouped by different page weight. For pages up to 1 MB, LCP was achieved in 2.1 seconds on desktop and 2.6 seconds on mobile. Between 1 MB and 2 MB, LCP was achieved in 2.5 seconds on desktop and 3.0 seconds on mobile. Between 2 MB and 3 MB, LCP was achieved in 2.7 seconds on desktop and 3.2 seconds on mobile. Between 3 MB and 4 MB, LCP was achieved in 2.8 seconds on desktop and 3.4 seconds on mobile. Between 4 MB and 5 MB, LCP was achieved in 3.0 seconds on desktop and 3.6 seconds on mobile. For pages of 5 MB or greater, LCP was achieved in 3.3 seconds on desktop and 3.8 seconds on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1829796459&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

For home pages in the 2-3 MB range, LCP was achieved in 2.7 seconds on desktop and 3.2 seconds on mobile. Mobile struggled to achieve sub-2.5-second times, even for pages under 1 MB, which recorded 2.6 seconds for LCP. As page weight increases, LCP times rise accordingly, with mobile taking roughly half a second longer to render the largest content element.

{{ figure_markup(
  image="pct-of-inner-pages-with-good-lcp-by-page-weight.png",
  caption="Percentage of inner pages with good Largest Contentful Paint, by page weight.",
  description="Bar chart showing the percentage of inner pages with good Largest Contentful Paint at different page weights. For pages up to 1 MB, 91% of desktop and 86% of mobile pages passed. Between 1 MB and 2 MB, 85% of desktop and 77% of mobile pages passed. Between 2 MB and 3 MB 83% of desktop, 73% of mobile pages passed. Between 3 MB and 4 MB 67% of desktop and 54% of mobile pages passed. Between 4 MB and 5 MB, 64% of desktop and 50% of mobile pages passed. For pages of 5 MB or greater, 57% of desktop and 44% of mobile pages passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=221207967&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

Inner pages show better Largest Contentful Paint performance than home pages. For pages under 1 MB, 91% of desktop and 86% of mobile inner pages passed the metric.

Pages in the 1-2 MB range represent the median mobile inner page size, with 77% of pages in this range achieving a score. At 2 MB, the desktop median inner page sits at the cutover for two ranges, both of which behave similarly. 83% of inner desktop pages passed in the 2-3 MB range.

{{ figure_markup(
  image="largest-contentful-paint-inner-pages-by-page-weight-crux.png",
  caption="Largest Contentful Paint time of inner pages by page weight.",
  description="Bar chart showing the time until Largest Contentful Paint on inner pages grouped by page weight. For pages up to 1 MB, LCP was achieved in 1.6 seconds on desktop and 2.0 seconds on mobile. Between 1 MB and 2 MB, LCP was achieved in 2.0 seconds on desktop and 2.4 seconds on mobile. Between 2 MB and 3 MB, LCP was achieved in 2.1 seconds on desktop and 2.6 seconds on mobile. Between 3 MB and 4 MB, LCP was achieved in 2.3 seconds on desktop and 2.8 seconds on mobile. Between 4 MB and 5 MB, LCP was achieved in 2.3 seconds on desktop and 2.8 seconds on mobile. For pages of 5 MB or greater, LCP was achieved in 2.4 seconds on desktop and 3.0 seconds on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=483912866&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

Inner pages show better LCP performance than home pages overall. Pages up to 2 MB met the LCP passing threshold for the 75th percentile. Desktop pages consistently passed the assessment for all size ranges.

### CrUX data: Cumulative Layout Shift by weight

The second Core Web Vitals metric, <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a> (CLS), measures the visual stability of the page. It calculates how much visible elements unexpectedly move during the first five seconds of page load, factoring in both the size of the element that moves and the distance it travels. These shifts are averaged across the session window to produce the final score.

{{ figure_markup(
  image="pct-of-home-pages-with-good-cls-by-page-weight-crux.png",
  caption="Percentage of inner pages with good Cumulative Layout Shift, by page weight.",
  description="Bar chart showing the percentage of home pages with good Cumulative Layout Shift at different page weights. For pages up to 1 MB, 84% of desktop and 88% of mobile passed. Between 1 MB and 2 MB, 76% of desktop and 82% of mobile passed. Between 2 MB and 3 MB, 72% of desktop, 78% of mobile passed. Between 3 MB and 4 MB, 69% of desktop and 76% of mobile pages. Between 4 MB and 5 MB, 67% of desktop and 74% of mobile passed. For pages of 5 MB or greater, 64% of desktop and 71% of mobile passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1793002028&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

At the 75th percentile, 72% of desktop and 78% of mobile homepages in the 2-3 MB range meet the CLS standard. These pages represent the median page in 2025. CLS saw less drop off between percentiles than LCP. 88% of mobile pages under 1 MB passed. 71% of mobile pages still passed when the page weight exceeded 5 MB.

{{ figure_markup(
  image="cls-home-pages-by-page-weight-crux.png",
  caption="Cumulative Layout Shift of home pages by page weight.",
  description="Bar chart showing the time until Cumulative Layout Shift on home pages grouped by different page weight. For pages up to 1 MB, CLS was 0.05 on desktop and 0.02 on mobile. Between 1 MB and 2 MB, CLS was 0.1 on desktop and 0.05 on mobile. Between 2 MB and 3 MB, CLS was 0.13 on desktop and 0.08 on mobile. Between 3 MB and 4 MB, CLS was 0.14 on desktop and 0.1 on mobile. Between 4 MB and 5 MB, CLS was 0.16 on desktop and 0.11 on mobile. For pages of 5 MB or greater, CLS was 0.19 on desktop and 0.14 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=774306985&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

A passing CLS score is ≤ 0.10. CLS scores were consistently higher on desktop, likely because the larger landscape provides more space for items to shift. Pages below 2 MB passed the assessment on desktop, while pages below 4 MB achieved the desired score on mobile.

{{ figure_markup(
  image="pct-of-inner-pages-with-good-cls-by-page-weight-crux.png",
  caption="Percentage of inner pages with good Cumulative Layout Shift, by page weight.",
  description="Bar chart showing the percentage of inner pages with good Cumulative Layout Shift at different page weights. For pages up to 1 MB, 87% of desktop and 90% of mobile pages passed. Between 1 MB and 2 MB, 78% of desktop and 84% of mobile pages passed. Between 2 MB and 3 MB, 74% of desktop and 77% of mobile pages passed. Between 3 MB and 4 MB, 71% of desktop and 75% of mobile pages passed. Between 4 MB and 5 MB, 69% of desktop and 73% of mobile pages passed. For pages of 5 MB or greater, 65% of desktop and 69% of mobile pages passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1309475261&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

The percentage of inner pages passing CLS was similar to the rates of homepages. While 72% of desktop mobile home pages represent the median 2-3 MB, 74% of their inner page counterparts passed. 77% of mobile inner pages passed compared to 78% of mobile desktop pages.

{{ figure_markup(
  image="cls-inner-pages-by-page-weight-crux.png",
  caption="Cumulative Layout Shift of inner pages by page weight.",
  description="Bar chart showing the time until Cumulative Layout Shift on inner pages grouped by different page weight. For pages up to 1 MB, CLS was 0.04 on desktop and 0.01 on mobile. Between 1 MB and 2 MB, CLS was 0.08 on desktop and 0.04 on mobile. Between 2 MB and 3 MB, CLS was 0.11 on desktop and 0.09 on mobile. Between 3 MB and 4 MB, CLS was 0.13 on desktop and 0.11 on mobile. Between 4 MB and 5 MB, CLS was 0.15 on desktop and 0.12 on mobile. For pages of 5 MB or greater, CLS was 0.17 on desktop and 0.16 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=785004421&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

The impact of page weight on inner page CLS shows a consistent march across the ranges. Desktop pages under 2 MB and mobile pages under 3 MB were able to achieve a score of less than 0.10. Pages over 3 MB consistently scored over the desired threshold.

### CrUX data: Interaction to Next Paint by weight

The third Core Web Vital Metric is <a hreflang="en" href="https://web.dev/articles/inp">Interaction to Next Paint</a> (INP). Designed to represent interactivity throughout a page's lifecycle, INP measures the total latency of an interaction, from the moment a user clicks, taps or presses a key until the next visual update appears. An INP of 200 milliseconds or less indicates good responsiveness.

{{ figure_markup(
  image="pct-of-home-pages-with-good-inp-by-page-weight-crux.png",
  caption="Percentage of home pages with good Interaction to Next Paint, by page weight.",
  description="Bar chart showing the percentage of home pages with good Interaction to Next Paint at different page weights. For pages up to 1 MB, 98% of desktop and 78% of mobile passed. Between 1 MB and 2 MB, 97% of desktop and 80% of mobile passed. Between 2 MB and 3 MB, 97% of desktop and 78% of mobile passed. Between 3 MB and 4 MB, 96% of desktop and 74% of mobile pages. Between 4 MB and 5 MB, 96% of desktop and 72% of mobile passed. For pages of 5 MB or greater, 95% of desktop and 72% of mobile passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=137499164&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

The INP metric shows the highest desktop pass rates of all the Core Web Vitals metrics. For home pages under 1 MB, 98% passed the INP, and even at 5in the 5+ MB range, 95% of desktop home pages still passed the assessment.

Mobile home pages passed at lower score rates, with 78% of pages up to 1 MB passing,while those pages in the 1-2 MB range performed slightly better, with 80% of them achieving INP in under 200 ms.

{{ figure_markup(
  image="inp-home-pages-by-page-weight-crux.png",
  caption="Interaction to Next Paint of home pages by page weight.",
  description="Bar chart showing the time until Interaction to Next Paint on home pages grouped by different page weight. For pages up to 1 MB, INP was 62 ms on desktop and 184 ms on mobile. Between 1 MB and 2 MB, INP was 70 ms on desktop and 177 ms on mobile. Between 2 MB and 3 MB, INP was 73 ms on desktop and 187 ms on mobile. Between 3 MB and 4 MB, INP was 76 ms on desktop and 204 ms on mobile. Between 4 MB and 5 MB, INP was 78 ms on desktop and 215 ms on mobile. For pages of 5 MB or greater, INP was 82 ms on desktop and 217 ms on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1132016626&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

Desktop homepages consistently achieved INP times below the 200ms threshold across all weight categories even in the heaviest range, at 5 MB+, INP for the 75th percentile was just 82ms. Mobile home pages up to 3 MB achieved their INP goal. However, those in the 3-4 MB range, INP at the 75th percentile exceeded 200ms.

{{ figure_markup(
  image="pct-of-inner-pages-with-good-inp-by-page-weight-crux.png",
  caption="Percentage of inner pages with good Interaction to Next Paint, by page weight.",
  description="Bar chart showing the percentage of inner pages with good Interaction to Next Paint at different page weights. For pages up to 1 MB, 99% of desktop and 78% of mobile passed. Between 1 MB and 2 MB, 97% of desktop and 70% of mobile passed. Between 2 MB and 3 MB, 97% of desktop and 74% of mobile passed. Between 3 MB and 4 MB, 96% of desktop and 72% of mobile pages. Between 4 MB and 5 MB, 94% of desktop and 70% of mobile passed. For pages of 5 MB or greater, 92% of desktop and 65% of mobile passed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1518724658&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

Inner pages show a similar gap between mobile and desktop. 99% of pages up to 1 MB achieved a sub-200ms INP compared to only 78% of mobile pages in the same weight range. At 5 MB+, 92% of desktop inner pages passed the interactivity assessment, while 65% of mobile pages achieved the goal.

{{ figure_markup(
  image="inp-inner-pages-by-page-weight-crux.png",
  caption="Interaction to Next Paint of inner pages by page weight.",
  description="Bar chart showing the time until Interaction to Next Paint on inner pages grouped by different page weight. For pages up to 1 MB, INP was 55 ms on desktop and 186 ms on mobile. Between 1 MB and 2 MB, INP was 73 ms on desktop and 227 ms on mobile. Between 2 MB and 3 MB, INP was 82 ms on desktop and 207 ms on mobile. Between 3 MB and 4 MB, INP was 77 ms on desktop and 213 ms on mobile. Between 4 MB and 5 MB, INP was 88 ms on desktop and 222 ms on mobile. For pages of 5 MB or greater, INP was 95 ms on desktop and 254 ms on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1413690208&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

### Lighthouse data: Core Web Vitals assessment by weight

In addition to the newly available CrUX data analyzed above, we've continued our synthetic Core Web Vitals assessments, first introduced in 2024. This data is collected by running Lighthouse during the HTTP Archive crawl that powers this annual report. <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse">Lighthouse</a> is a free, open-source, automated tool developed by Google that evaluates web page quality across multiple areas, including performance, accessibility and SEO. It is frequently used by developers as part of their release process to monitor and mitigate issues in production.

It's essential to distinguish between Lighthouse data as lab or synthetic data. While designed to emulate a real experience, it can't account for all the factors that impact site performance for actual users. It also measures only the initial load of a page, limiting calculations for interactivity to ongoing interactivity and visual stability.

While CrUX is a more accurate representation of real human experience, it also has limitations. Web pages need to receive enough visits to meet data anonymization requirements before they can appear in the dataset, meaning that popular pages and websites are more likely to be represented.

When CrUX data is available for a URL, it should be considered the focus of efforts to create more performant experiences. Field data allows you to solve for real human problems. Lab data, like Lighthouse, provides more metrics to troubleshoot the issues as identified in real user metrics.

### Lighthouse data: Largest Contentful Paint by weight

Largest Contentful Paint can be most accurately captured in synthetic testing of the three core web vitals. The output is only an estimate based on the specific test scenarios it runs (cold load, for its predefined screen size, network throttling, and CPU throttling). Whether those conditions are realistic for a site's particular users will determine how "accurate" the Lighthouse LCP is.

{{ figure_markup(
  image="synthetic-lcp-by-device-type.png",
  caption="Synthetic Largest Contentful Paint in seconds, by device type.",
  description="Bar chart showing the time until Largest Contentful Paint as measured by Lighthouse. At the 10th percentile, LCP was achieved in 1.0 seconds on desktop and 2.1 seconds on mobile. At the 25th percentile, LCP was 1.4 seconds on desktop and 3.0 seconds on mobile. At the 50th percentile, LCP was 2.2 seconds on desktop and 4.7 seconds on mobile. At the 75th percentile, LCP was 3.5 seconds on desktop and 8.5 seconds on mobile. At the 90th percentile, LCP was achieved in 3.0 seconds on desktop and 3.6 seconds on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1412641202&format=interactive",
  sheets_gid="166619293",
  sql_file="lighthouse_cwv_trends.sql"
  )
}}

A good Largest Contentful Paint score is less than 2.5 seconds. In Lighthouse tests, the median desktop page met this threshold, achieving 2.2 seconds. Mobile performance was significantly worse, as the same task took 4.7s to reach LCP. Only the fastest 10th percentile of mobile pages achieved a passing score, with an LCP of 2.1 seconds. In sharp contrast, mobile pages at the 90th percentile, achieved an LCP of 15.1 seconds, roughly six times slower than the recommended target. Desktop pages achieved LCP in under 2.5 seconds up to the 50th percentile.

{{ figure_markup(
  image="crux-lcp-by-device-type.png",
  caption="Real user metrics for Largest Contentful Paint in seconds, measured using CrUX.",
  description="Bar chart showing the time until Largest Contentful Paint as measured by Lighthouse. At the 10th percentile, LCP was achieved in 1.0 seconds on desktop and 2.1 seconds on mobile. At the 25th percentile, LCP was 1.4 seconds on desktop and 3.0 seconds on mobile. At the 50th percentile, LCP was 2.2 seconds on desktop and 4.7 seconds on mobile. At the 75th percentile, LCP was 3.5 seconds on desktop and 8.5 seconds on mobile. At the 90th percentile, LCP was achieved in 3.0 seconds on desktop and 3.6 seconds on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=748997391&format=interactive",
  sheets_gid="1154933839",
  sql_file="crux_cwv_trends.sql"
  )
}}

Real user metrics provided by the Chrome User Experience report paint a much more performant picture of the web. Both mobile and desktop pages achieved LCP in under 2.5 seconds through the 50th percentile. At the 90th percentile, desktop field data was 1.8 seconds faster than lab data. mobile showed an even wider gap, as starting at the 25th percentile, Lighthouse reported LCP values more than double those seen in CrUX, and by the 90th percentile, synthetic results were 328% higher than real-user metrics.

Such significant differences in the data sets may serve to support the cause for the metric's existence. Pages with slower LCP are more likely to be abandoned as users perceive the lack of visual loading as unresponsive. More abandoned page loads reduce the likelihood of achieving enough page views to be eligible for the CrUX data set.

### Lighthouse data: Cumulative Layout Shift by weight

Visual stability can only be measured during initial page load in synthetic testing. This does not accurately reflect the robust nature of the metric. CLS, as measured in the page loads of real users, is not a single measurement but an aggregation of all layout shifts within a "session window." A session window is a 5-second period where multiple layout shifts occur, separated by less than 1 second. The highest-scoring session window is reported as the page's CLS score.

{{ figure_markup(
  image="synthetic-cls-by-device-type.png",
  caption="Synthetic Cumulative Layout Shift, by device type.",
  description="Bar chart showing the time until Largest Contentful Paint as measured by Lighthouse. At the 10th percentile, LCP was achieved in 1.0 seconds on desktop and 2.1 seconds on mobile. At the 25th percentile, LCP was 1.4 seconds on desktop and 3.0 seconds on mobile. At the 50th percentile, LCP was 2.2 seconds on desktop and 4.7 seconds on mobile. At the 75th percentile, LCP was 3.5 seconds on desktop and 8.5 seconds on mobile. At the 90th percentile, LCP was achieved in 3.0 seconds on desktop and 3.6 seconds on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1221443468&format=interactive",
  sheets_gid="166619293",
  sql_file="lighthouse_cwv_trends.sql"
  )
}}

Synthetic data shows pages through the 75th percentile effectively passing CLS as judged by their initial pageload. Mobile and desktop scores were consistent through the 50th percentile. The highest scores were those of mobile pages in the 90th percentile, which scored 0.32.

{{ figure_markup(
  image="crux-cls-by-device-type.png",
  caption="Real user metrics for Cumulative Layout Shift, measured using CrUX.",
  description="Bar chart showing the time until Synthetic Cumulative Layout Shift as measured in CrUX. At the 10th through 25th percentiles, CLS was 0.0 on desktop and mobile. At the 50th percentile, CLS was 0.03 on desktop and 0.0 mobile. At the 75th percentile, CLS was 0.13 on desktop and 0.08 on mobile. At the 90th percentile, CLS was 0.36 on desktop and 0.29 s on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1913589530&format=interactive",
  sheets_gid="1154933839",
  sql_file="crux_cwv_trends.sql"
  )
}}

With CrUX data, we introduce an extended time frame and better accounting for the mechanics of single-page applications (SPAs) and dynamically loaded content. Real user metric calculation for CLS focuses on the largest "burst" of layout shifts that a user is likely to experience.

All users through the 50th percentile experienced CLS of less than 0.10. At the 75th percentile, desktop users saw good CLS while mobile inched over the threshold to a CLS of 0.13. At the 90th percentile, CrUX desktop users experienced higher visual instability (0.36) than mobile users (0.29). CrUX data for mobile users at the 90th percentile was lower than its synthetic counterpart (0.32 in Lighthouse; 0.29 in CrUX).

### Lighthouse data: Total Blocking Time by weight

For CrUX data, interactivity is measured as Interaction to Next Paint (INP), in other words, this metric measures the time between user input and visual feedback throughout the page's lifecycle. Lighthouse can only measure the initial page load and, because of this, uses an alternative metric to estimate interactivity. <a hreflang="en" href="https://web.dev/articles/tbt">Total Blocking Time</a> is a lab metric that measures the total time during page load that the main thread was blocked. TBT serves as a proxy for INP because high TBT often leads to high INP, meaning that fixing TBT is a key way to improve INP.

{{ figure_markup(
  image="synthetic-tbt-by-device-type.png",
  caption="Total Blocking Time in milliseconds, measured using Lighthouse.",
  description="Bar chart showing the time until Total Blocking Time as measured by Lighthouse. At the 10th percentile, TBT was achieved in 0 ms on desktop and 146 ms on mobile. At the 25th percentile, TBT was 1 ms on desktop and 668 ms on mobile. At the 50th percentile, TBT was 78 ms on desktop and 1,835 ms on mobile. At the 75th percentile, TBT was 294 ms on desktop and 3,953 ms on mobile. At the 90th percentile, TBT was achieved in 722 ms on desktop and 7,102 ms on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1804092239&format=interactive",
  sheets_gid="166619293",
  sql_file="lighthouse_cwv_trends.sql"
  )
}}

A page is considered to have good TBT when the main thread is blocked for less than 200 milliseconds. Only the 10th percentile of mobile pages achieved this metric. Desktop pages achieved a TBT of under 200 ms through the 50th percentile. At the 90th percentile, the main thread of mobile devices was blocked for 7.1 seconds.

{{ figure_markup(
  image="crux-cls-by-device-type.png",
  caption="Real user metrics for Interaction to Next Paint in milliseconds, measured using CrUX.",
  description="Bar chart showing the time until Interaction to Next Paint as measured by CrUX. At the 10th percentile, INP was 36 ms on desktop and 97 ms on mobile. At the 25th percentile, INP was 51 ms on desktop and 130 ms on mobile. At the 50th percentile, INP was 76 ms on desktop and 200 ms on mobile. At the 75th percentile, INP was 120 ms on desktop and 320 ms on mobile. At the 90th percentile, INP was 661 ms on desktop and 854 ms on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=495504735&format=interactive",
  sheets_gid="1154933839",
  sql_file="crux_cwv_trends.sql"
  )
}}

INP, the field metric counterpart to TBT, shares the same timing goal of 200 ms. CrUX paints a more responsive picture of mobile experiences. Mobile and desktop pages through the 50th percentile achieved good responsiveness. At the 75th percentile, the differences between devices become more pronounced, with INP of 120 ms for desktop, still considered good responsiveness, and 320 on mobile, meaning users perceive more lag. The 90th percentile of mobile CrUX data calculated at INP at 4X the 200 ms goal. The 90th percentile of synthetic mobile data saw TBT 35X the same goal.

## Conclusion

The simple conclusion is that all pages on the web continue to grow in size year on year. This growth is broadly accelerating increasing demand on user devices and internet connection.

The balance of functionality versus accessibility is continuing to tilt in favour of functionality meaning users on limited connections or devices suffer a worse and less inclusive experience.

Javascript is still a primary driver of this growth with 98.1% of pages making at least one request. Javascript is often inefficiently added to pages, adding weight to the pages but then not being actively used.

Images and their wide use on both homepages and inner pages contribute a significant amount of the weight to pages, the discrepancy between desktop and mobile has shrunk versus last year which implies that optimisation is less of a focus which is troubling given the impact images have on the web experience.

The effect of all this weight can be seen in the high falling rates of Core Web Vitals as the weight increases, including in Chrome User Experience report data, showing the impact is real for the user, not theoretical.

Ultimately there is massive opportunity for improvements here without impacting the user experience at all, lossless compression and only using what is needed for javascript represent significant gains for users and reduced costs for web owners, but currently too many of these opportunities are being ignored.

Page weight continues to be a key issue but currently it seems we are getting further away from a solution.