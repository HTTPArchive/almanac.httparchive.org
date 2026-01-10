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
featured_stat_1: ...
featured_stat_label_1: ...
featured_stat_2: ...
featured_stat_label_2: ...
featured_stat_3: ...
featured_stat_label_3: ...
doi: ...
---

## Introduction

In the early days of the web, every byte was a luxury. Developers spent hours dither-mapping GIFs and hand-optimizing scripts to ensure pages could crawl through 56k modems. Today, in an era of gigabit fiber and 5G dominance, that scarcity mindset has largely vanished. However, as our "bandwidth pipes" have grown wider, the content we push through them has expanded to fill the space.

Page weight—the total volume of bytes transferred to a user's device—remains one of the most critical metrics for understanding the health of the web. While it is tempting to view a few extra megabytes as a negligible cost of modern rich experiences, the reality is far more complex.

## What is page weight?

Page weight (also called page size) is the total volume of data—measured in kilobytes (KB) or megabytes (MB)—that a user must download to view a specific webpage.

When you navigate to a URL, your browser doesn't just download one file; it sends dozens or even hundreds of requests for various assets required to make the page look and function correctly. The sum of all these "shipped" bytes constitutes the page weight.

### A modern webpage is an assembly of several different types of resources

Each contributes to the total "heaviness" of the site:

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
2. The Economic Toll: In many parts of the world, data is a metered commodity. A 5MB page isn't just a slow experience; it is an exclusive one. If a user cannot afford the data to load your page, your site is, by definition, inaccessible to them. 
3. The Accessibility Barrier: If a page is "heavy," it doesn't just load slowly—it becomes physically and cognitively harder to use. Excessive page weight creates significant inequities, heavily penalizing users who rely on less powerful devices or expensive, slow connections with limited data caps. Refer to the [Accessibility](./accessibility) chapter to learn more about how page weight is a silent but significant barrier to entry for millions of users with disabilities. 
4. The Environmental Impact: Every megabyte transferred requires energy—from data centers to cooling systems to the device in the user's hand. As the web grows, so does its carbon footprint. You can find out more about how page weight impacts carbon emissions in the [Sustainability](./sustainability) chapter. 
5. Speed & SEO: Heavier pages take longer to load, especially on slower connections. Google uses page speed (via Core Web Vitals) in their core algorithm, meaning bloated pages can rank lower in search results.

The weight effects can be divided into three main categories: storage, transmission, and rendering.

### Storage

Storage refers to how assets (images, scripts, HTML) sit on a web server or CDN. At this stage, page weight is about file size on disk.

* Compression at Rest: Developers often store files in highly compressed formats (like WebP for images or Brotli-compressed text). A 1MB file can be stored as 300KB. 
* The Database Bottleneck: For dynamic sites, the "weight" starts with database queries. If a server has to retrieve 2MB of raw data from a database to generate one page, the initial response time (TTFB) increases before a single byte is even sent. 
* The Cost: Inefficient storage doesn't just affect speed; it increases hosting costs and the carbon footprint of the data center.

### Transmission

Transmission is the process of moving those stored files across the internet. This is where network constraints turn page weight into a performance barrier.

* Transfer Size vs. Actual Size: Thanks to "on-the-fly" compression (like Gzip), the number of bytes sent over the wire is often much smaller than the original file size. 
* Latency and Round Trips: It’s not just about how much data is sent, but how many files. Each separate file requires a "round trip" to the server. A page with 50 small images (totaling 1MB) can actually feel slower than a page with one large 2MB image because of the transmission overhead of 50 separate requests. 
* The Bottleneck: On mobile 4G/5G, signal interference can cause "packet loss." The heavier the page, the more likely a packet will drop, forcing the browser to ask for it again and causing a visible hang.

### Rendering

Rendering is what happens once the data arrives. This is the most misunderstood part of page weight: Once a file is downloaded, it must be "unpacked" and processed by the device.

* Memory Inflation: An image might only take up 200KB during transmission, but once the browser "renders" it, it must be decoded into raw pixels in the device's RAM. That 200KB file can easily take up 5MB of memory. 
* The JavaScript Tax: This is the "heaviest" part of rendering. 100KB of an image is just pixels, but 100KB of JavaScript is work. The CPU must parse, compile, and execute that code. On a low-end smartphone, this "weight" can freeze the screen for several seconds. 
* DOM Complexity: Every HTML tag adds a "node" to the browser's memory. A page with 5,000 nodes (a "heavy" DOM) will make scrolling feel laggy, regardless of how fast the internet connection is.

## Page weight over time

Since the inception of the Web Almanac, we've consistently observed two trends:

1. The total volume of requests increases.
2. Desktop page loads result in more requests than mobile page loads.

{{ figure_markup(
 image="median-home-page-weight-over-time.png",
 caption="Median home page weight over time",
 description="Line chart showing the median home page weight over time. The chart shows page weight growing over time, from 1,208 KB on desktop, 505 KB on mobile in Oct 2014, to 2,862 KB on desktop, 2,559 KB on mobile in July 2025.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=100065523&format=interactive",
 sheets_gid="1902270972",
 sql_file="page_weight_trend.sql"
 )
}}