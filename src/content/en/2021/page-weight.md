---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: TODO
authors: [logicalphase]
reviewers: [siakaramalegos]
analysts: [jessthebp]
editors: [RMHolmlund]
translators: []
results: https://docs.google.com/spreadsheets/d/1XApPAC8m2jLJR3Ok1yAoc9PzAFtq-Z41LoakXHUVeag/
logicalphase_bio: John currently works as a [Google Cloud Platform](https://cloud.google.com) senior developer and architect. He started his technology journey as a web developer focused on web performance and leveraging browser standards. He applied those principles as a freelance [WordPress](https://wordpress.org) developer, and as an architect and engineer for several managed hosting providers. He is a firm believer in open web standards and sustainable web best practices. To that end, John has worked on several open source projects, including Google's [Lit](https://lit.dev/) project, and is a strong advocate for [Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components).
featured_quote: It's critically important to stop optimizing web pages for $1200.00 smartphones with ultra-fast internet connections because the vast majority of internet users don't live in that world, and the energy required to power that world is unsustainable.
featured_stat_1: 1,915
featured_stat_label_1: The median number of mobile page bytes
featured_stat_2: 916
featured_stat_label_2: The median number of mobile page image bytes
featured_stat_3: 70
featured_stat_label_3: The median number of mobile page requests

---

## TODO
- finish Looking ahead and Conclusion
- Get help formatting the figures (I left last years in as example - I'll need to update descriptions.

## Introduction

Unless you're a web performance junkie like me the weight of a web page is about as exciting as licking stamps. But, I'm going to try my best to convince you as to why page weight is not only important but arguably **the** most important factor effecting creators, hosting providers, and consumers. To that end, we'll use real data to show how the weight of a page influences the performance of the website or web application, how page weight can impact user experience, and some ways we can reduce the weight of our web pages.

In just the past decade, [average web page weight](https://httparchive.org/reports/page-weight) has grown a whopping 356 percent, from an average of about 484 kilobytes to 2,205 kilobytes. That increase can be explained as a function of supply and demand.  Faster computer processing, data transmission, and how data is stored and made available have all advanced to deal with web sites and applications increased use of images, video, audio, fonts, data collection and processing, and connected services like analytics, monitoring, and alerting functionality.

All seems well, if you are fortunate enough to own a high end smartphone, desktop and/or laptop computers costing thousands of dollars, and you're connected to high speed internet or expensive 5G data plans. But the pleasure of belonging to that class of internet user starts to break down when you are relegated to using a 3G or slow 4G data plan with unpredictably available internet connectivity. For that large segment of internet users, waiting for a page that may never fully load breaks the promise of the internet even to the point of costing lives during emergencies.

How much energy can we afford to use to power the transmission of large complex files and streaming data that make up a significant proportion of today's web pages? To understand how controversial web page weight has become, one need only spend ten minutes on Twitter or Reddit. The arguments over the importance of keeping web page weight low and agile are too numerous to list. However, Google recently announced that there would be penalties in search results for not following best practices when it comes to page weight, and I strongly urge you to follow them. You can test your site(s) using Google [PageSpeed](https://developers.google.com/speed/pagespeed/insights/) and Google [Measure](https://web.dev/measure/). Both provide valuable insights into how to solve performance and user experience problems.

In order to understand and find opportunities to keep web pages lighter and faster loading, it's instructive to examine what page weight actually means.

##  What is page weight?

Page weight describes the total number of bytes (a measurement of data that contains eight bits) of a particular web page. A web page is comprised of specific elements and assets that can be rendered and viewed in a web browser, including:

 - [HTML](https://almanac.httparchive.org/en/2021/markup) textual content
 - [Images](https://almanac.httparchive.org/en/2021/media)
 - [Media](https://almanac.httparchive.org/en/2021/media) (embedded video, audio, etc)
 - [Cascading Style Sheets (CSS)](https://almanac.httparchive.org/en/2021/css)
 - [JavaScript](https://almanac.httparchive.org/en/2020/javascript)
 - [Third Party](https://almanac.httparchive.org/en/2021/third-parties) resources

Each of those items exact a cost in weight (byte size), but some are much more costly in terms of weight than others, and some require more computational resources to process and render in a web browser than others. And the process of managing web page resources for use when requested have changed over the past decades. Part of those changes were predicated on making web page resources more efficient and more quickly transmitted when requested. Let's quickly examine three states of a web page (although this is a simplification of the entire process) to clarify a few things:

### Storage
Some page resources/assets, in one form or another, are stored for retrieval and usage when requested. Images, video files, CSS and JavaScript files, and font files (assets) on disks. Each file type has it's own size in bytes, and they can range from a few bytes to many megabytes in size. When reviewing today's web sites, I routinely see images that exceed four megabytes in size, and embedded video files that are many times that value.

Most site owners, and far too many web developers and designers simply don't understand the negative impact those types of assets have on page loading performance. One thing is certain, these files have to be stored and there's a cost for that storage. Fortunately there are options and optimizations that can be done that can significantly lower the size of files stored at rest, which are covered in the [Compression](https://almanac.httparchive.org/en/2021/compression), [HTTP/2](https://almanac.httparchive.org/en/2021/http), and [CDN](https://almanac.httparchive.org/en/2021/cdn) chapters. I highly recommend reviewing those as they provide a wealth of information on how to lighten the weight of a web page at very little cost.

### Rendering
Most of you may know that the web browser is software that send requests to a remote source (or local disk) and takes the results of those requests both dynamic and static and uses it's rendering engine to recreate the web page you asked for. It's not hard to deduce that the larger the total amount of page weight in bytes the browser engine must process and render to the browser screen, the longer it's going to take.

Too many files, especially large media and large complex scripts that must get read, processed, and executed by the browser, the more chance there is for pages to take so long to load that users will abandon them, or the large payloads overwhelm the amount of client side resources on the users machine causing the machine to stall, or fail to load the page at all. Users who have the good fortune to subscribe to high speed cable internet services, or 5G data plans will probably never experience these problems, but again, the majority of internet users don't have access to those levels of internet services.

### Transmission
There are several factors during the transmission of web page assets and connected services that are important. Transmission is basically  the process of transferring a web file from one computer to another through one of several communication methods or channels. When a user requests a web page via HTTP(S), all files needed to render the page are requested. This means locating the file and using a transport protocol to send a copy of the file to the users browser. Page weight becomes important during this process because the size of the file determines how long it will take to complete the transfer.

If a web page requests a large number of files, it's going to take longer to transport them all. Usually there is increased latency (the time it takes for the request to connect to and begin the transportation of the requested file) if bunches of files are required, and no matter the technology there is a limit on how much can be transferred at one time. I've audited WordPress sites that request as high as 170 files or more, which ensures terrible page loading performance.

There are certainly optimizations that can be done such as compressing and combining certain file requests, using HTTP/2 or the newer HTTP/3 protocols, and using modern browsers ability to preconnect and preload certain files to speed the process up.

## Assets
As explained in last years chapter, there's been little change in most assets in terms of technology, but there are some notable exceptions.

### Static
Image file formats have been developed specifically for web page rendering, such as WebP, which offers excellent compression, much better than PNG or JPEG and are supported by all major browsers. Some image types that are very good for the web lack full cross browser support.

There are also ways to take advantage of browser features to have a request look for a the best choice for the browser requesting the image, and defaulting back to a fully supported image if one is not available. The main point about images is to make sure they are optimized for the web, the [Media](https://almanac.httparchive.org/en/2021/media) chapter covers this in much more detail.

**Note**: If you want an online service that will optimize your images there is no better source I've found than check out Google's [Squoosh](https://squoosh.app/) application, and Jake Archibald's [SVGOMG](https://jakearchibald.github.io/svgomg/) for optimizing your SVG's.

### Dynamic
Dynamically generated assets get normally are created by web programming languages like PHP, JavaScript, etc. They send requests to get the results of the scripts that executed and then send that payload back to the user's browser for rendering. Generally, dynamic scripting in modern web developed sites are very fast loading, and the results can be cached for even faster use in future requests. But, poorly scripted dynamic assets can cause increases in page weight and must be optimized for best use.

### Connected
Page weight can also be effected by external services that are attached to web page. Some of those services include CDN's, Analytics, Chat bots, and other data collection methods. I find this to be one of the fastest growing problems with bloating page weight. Many of these third party services use outdated JavaScript and querying techniques that take much longer to execute than they should, and the site owner has little control over how that third party impacts the loading of a page.

### Cached
[Caching](https://almanac.httparchive.org/en/2021/caching), are special services that make copies of previously requested optimized assets that get stored on remote server disks, or in in the client browser, until needed again. Caching servers dramatically speed up making files and dynamic results available without having to process a full dynamic request for the asset again.

#### A word about rampant increases in the use of JavaScript
JavaScript can be a wonderful tool to use for a website, but using it unchecked can create serious performance problems and a horrible experience for the user. There has been a proliferation in the use of complex JavaScript frameworks over the past decade. Some of them cause build sizes of a site to skyrocket causing performance bottlenecks so bad that a site can become unusable. Blocking scripts, defined as a request of a script that must be transmitted and processed before the user can begin interacting with the site often will block the further loading of the page until it finished executing causing confusion and frustration.

Example: You navigate to a e-commerce site on your nifty smartphone on slow 4G internet connection, but the site is taking forever to load. It even throws a warning that the page is taking too long to load and asks if you want to continue waiting. Your phone stalls and has to be rebooted. Nine times out of ten you just ran into a blocking JavaScript that is causing your smartphone to run out of processing power or memory. The judicious or expert use of JavaScript can create great user experiences. **But remember this**: *JavaScript is executed on the client side. It's using the client computers resources to process and execute the script, and there is a finite amount of resources on every device*.

The [JavaScript](https://almanac.httparchive.org/en/2021/javascript) chapter contains a wealth of information about this issue and how to avoid it.

## Analysis

As we post and parse the statistical results, the data is often based on transfer sizes. However, we are employing decompressed sizes in this analysis when possible. Please note that many of the results listed below are similar or the same as those queries used in 2020.

### Page weight by the numbers

Looking at the page weight on both desktop and mobile devices, the deltas are due to a small difference in the amount of transferred resources on the mobile device, but the difference is pretty insignificant between the two.

{{ figure_markup(
  image="bytes-distribution.png",
  caption="Distribution of total bytes per page.",
  description="Bar chart showing the distribution of the total bytes per page. Desktop pages tend to have more bytes throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: ~~369~~, X, X, X, and X KB per page.",
  chart_url="",
  sheets_gid="",
  sql_file="bytes_per_type_2021.sql"
) }}

The key data here shows we are closing in on X MB of page weight on mobile and X MB on desktop at the 90th percentile. The data is following an old and consistent trend: growth in page weight is on the upward trajectory continues from the previous year.

{{ figure_markup(
  image="bytes-distribution-content-type.png",
  caption="Median bytes per page by content type.",
  description="Bar chart showing the median number of bytes per page for images, JavaScript, CSS, and HTML. The median desktop page tends to have more bytes. The median mobile page has ~~916~~ KB of images, ~~411~~ KB of JS, ~~62~~ KB of CSS, and ~~25~~ KB of HTML.",
  chart_url="",
  sheets_gid="",
  sql_file="bytes_per_type_2021.sql"
) }}

A closer inspection shows that the media and average for each resource, and following the trend from years previous to this one, images remain the largest resource with JavaScript following.

### Requests

We have an old adage: the quickest request is the one never made. Dare we then say: the smallest resource is one never requested. At the request level, much is the same. The weightiest resources are making the most requests.

{{ figure_markup(
  image="requests-distribution.png",
  caption="Distribution of requests per page.",
  description="Bar chart showing the distribution of requests per page. Desktop pages tend to load more requests. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: ~~23, 42, 70, 114, and 174~~ requests per page.",
  chart_url="",
  sheets_gid="",
  sql_file="request_type_distribution_2021.sql"
) }}

The request distribution shows that the difference between desktop and mobile is not so significant, with desktop leading the way. Something worth noting: the median request on desktop at this time is the same [as last year](../2019/page-weight#page-requests) (74), yet the page weight has ticked up (+~~122~~kb). A simple observation, but one which confirms the trajectory we've seen over the years.

{{ figure_markup(
  image="requests-content-type.png",
  caption="Median number of requests per mobile page by content type.",
  description="Bar chart showing the median number of requests per mobile page by content type. The median number of image requests per page is ~~27, 19~~ for JS, ~~7~~ for CSS, and ~~3~~ for HTML. Desktop and mobile tend to be equal except desktop pages load slightly more image and JS requests.",
  chart_url="",
  sheets_gid="",
  sql_file="request_type_distribution_2021.sql"
) }}

Images again make up the largest number of requests, though JavaScript is closing in as the gap has narrowed slightly in the last year.

### File formats

{{ figure_markup(
  image="response-distribution-format.png",
  caption="Distribution of image sizes by format.",
  description="Box plot of the distribution of image sizes by format: gif, ico, jpg, png, svg, and webp. Jpg sticks out as having the highest distribution with a 90th percentile exceeding 150 KB per image. Png is second highest at about 100 KB at the 90th percentile. While WebP has a smaller 90th percentile than png, its 75th percentile is higher. gif, ico, and svg all have relatively small distributions near 0 KB.",
  chart_url="",
  sheets_gid="",
  sql_file="requests_format_distribution.sql"
) }}

We know that images are a great source of page weight. This graphic above shows us the top sources of image weight and the weight distribution. Top 3: JPG, PNG and WebP. So not only is the JPG the most popular image format, it also tends to be the largest by size as well - even larger than a lossless format like the PNG. But as we [noted last year](../2020/page-weight#file-size-by-image-format-for-images--1024-bytes), that has to do with the predominant use case for the PNG, which seems to be icons and logos.

### Image bytes

{{ figure_markup(
  image="response-distribution-images.png",
  caption="Distribution of image response sizes per page.",
  description="Bar chart showing the distribution of image bytes per page. Desktop pages tend to load more image bytes per page throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: ~~67, 284, 928, 2,365, and 4,975~~ KB of images per page.",
  chart_url="",
  sheets_gid="",
  sql_file="request_type_distribution_2021.sql"
) }}

Looking at total image bytes, we see the same trend upwards, as noted previously on overall page weight.

## Looking ahead

Still needs to be written

## Conclusion

Still needs to be written
