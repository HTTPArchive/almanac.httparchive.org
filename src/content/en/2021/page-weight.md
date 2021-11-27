---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: Page Weight chapter of the 2021 Web Almanac covering why page weight matters, bandwidth, complex pages, page weight over time, page requests, and file formats.
authors: [logicalphase]
reviewers: [siakaramalegos]
analysts: [jessthebp]
editors: [RMHolmlund]
translators: []
results: https://docs.google.com/spreadsheets/d/1XApPAC8m2jLJR3Ok1yAoc9PzAFtq-Z41LoakXHUVeag/
logicalphase_bio: John currently works as a [Google Cloud Platform](https://cloud.google.com) senior developer and architect. He started his technology journey as a web developer focused on web performance and leveraging browser standards. He applied those principles as a freelance [WordPress](https://wordpress.org) developer, and as an architect and engineer for several managed hosting providers. He is a firm believer in open web standards and sustainable web best practices. To that end, John has worked on several open source projects, including Google's [Lit](https://lit.dev/) project, and is a strong advocate for emerging web technologies such as [Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components) and other performance based solutions.
featured_quote: It's critically important to stop optimizing web pages for &dollar;1,200.00 smartphones with ultra-fast internet connections because the vast majority of internet users don't live in that world, and the energy required to power that world is unsustainable.
featured_stat_1: 1,923
featured_stat_label_1: The median number of mobile page bytes
featured_stat_2: 877
featured_stat_label_2: The median number of mobile page image bytes
featured_stat_3: 69
featured_stat_label_3: The median number of mobile page requests
unedited: true
---

## Introduction

Unless you're a web performance junkie like me, the weight of a web page is about as exciting as licking stamps. But, I'm going to try my best to convince you as to why page weight is not only important but arguably **the** most important factor affecting creators, hosting providers, and consumers. To that end, we'll use real data to show how the weight of a page influences the performance of the website or web application, how page weight can impact user experience, and some ways we can reduce the weight of our web pages.

In the past decade, [average web page weight](https://httparchive.org/reports/page-weight) has grown a whopping 356 percent, from an average of about 484 kilobytes to 2,205 kilobytes. That increase can be explained as a function of supply and demand. Faster computer processors, data transmission, and how data is stored and made available have all advanced to keep up with increased use of images, video, audio, fonts, data collection and processing, and connected services like analytics, monitoring, and alerting functionality for web sites and web applications.

All seems well, if you're fortunate enough to own a high end smartphone, desktop or laptop computer costing thousands of dollars, and you're connected to an expensive high speed internet provider or 5G data plan. But the pleasure of belonging to that class of internet user starts to break down when you're relegated to using a slow 3G or 4G data plan with unpredictable internet connectivity. For a large segment of internet users, waiting for a page that may never fully load breaks the promise of the internet even to the point of putting lives at risk [during emergencies](https://www.nbcnews.com/tech/tech-news/verizon-admits-throttling-data-calif-firefighters-amid-blaze-n902991).

A lot of energy is used to power data centers and the devices they serve. We can help reduce overall energy demands by keeping our file payloads smaller which also keeps payload transmission faster and more efficient. 

Also, Google now penalizes a website's search ranking for those that fail to achieve good Core Web Vitals. One of their metrics for assessing success or failure is page weight. If you are interested, you can test your site using Google [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) and Google [Measure](https://web.dev/measure/). Both provide valuable insights into how to solve performance and user experience problems caused by heavy web pages.

To understand and find opportunities to keep web pages lighter and faster, it's instructive to examine what page weight actually is. So let's delve deeper.

## What is page weight?

Page weight describes the total number of bytes (a measurement of data that contains eight bits) of a particular web page. A web page is comprised of specific elements and assets that can be rendered and viewed in a web browser, including:

 - [HTML](https://almanac.httparchive.org/en/2021/markup) textual content
 - [Images](https://almanac.httparchive.org/en/2021/media)
 - [Media](https://almanac.httparchive.org/en/2021/media) (embedded video, audio, etc)
 - [Cascading Style Sheets (CSS)](https://almanac.httparchive.org/en/2021/css)
 - [JavaScript](https://almanac.httparchive.org/en/2020/javascript)
 - [Third Party](https://almanac.httparchive.org/en/2021/third-parties) resources

Each of those items exact a cost in weight (byte size), and some being more more costly in terms of weight than others, and some requiring more computational resources to transmit, process and render in a web browser than others. The process of managing web page resources for use when requested have rapidly changed over the past decades. Part of those changes were predicated on making web page resources more efficient and more quickly transmittable when requested. Let's examine three [states](https://en.wikipedia.org/wiki/State_(computer_science)) of a web page (although this is a simplification of the entire process) to clarify a few things:

### Storage
Page resources are stored then retrieved when requested. Image, video, CSS, JavaScript, and font files (what we refer to as assets) are stored on disks. Each file can range from a few bytes to many megabytes in size. When reviewing today's websites, I routinely discover images that exceed four megabytes in size, and embedded video files that are many times that value.

Many site owners, and far too many web developers and designers, don't understand, or pay little attention to, the negative impact those types of unoptimized assets have on page loading performance. One thing is certain, these files have to be stored somewhere and there are costs associated with that storage. Fortunately there are also options and optimizations that can be applied that can significantly lower the size of files stored at rest. Some of these are covered in the [Compression](https://almanac.httparchive.org/en/2021/compression), [HTTP/2](https://almanac.httparchive.org/en/2021/http), and [CDN](https://almanac.httparchive.org/en/2021/cdn) chapters. I highly recommend reviewing them as they provide a wealth of information on how to lighten the weight of a web page, often at little to no cost.

### Rendering
Most of you probably know that the web browser is software that send requests to a remote source (or local disk). The results (payload) of those requests are handed off to the browser's rendering engine to process and then recreate the web page you asked for. It's not hard to deduce that the larger the total amount of page weight in bytes the browser engine must process and render to the browser screen, the longer it's going to take.

Too many files, especially large media and large complex scripts must get retrieved, read, processed, and rendered by the browser, increase the chance that pages will take so long to load that users will abandon them. Large payloads can also overwhelm the amount of client side resources available on the users smartphone or computer causing it to stall and even crash the device. Users who have the good fortune to subscribe to high speed cable internet services, or 5G data plans will seldom experience these problems. But again, a large percentage of internet users don't have access to those levels of internet services and devices.

### Transmission
Transmission is basically the process of transferring a file from one computer to another through one of several communication methods or channels. When a user requests a web page via HTTP(S), all files needed to render the page are requested. Files are located and sent back to the requesting device using a transport protocol and, if all goes well, the requester's browser will take the payload, and process and render it as part of the larger web page on the requesting user's screen. Page weight becomes important during the transmission process because the size of the file determines how long it will take to complete the transfer, and how long and how many resources will be needed to render the results.

Another negative side effect of large page weight is increased [latency](https://developer.mozilla.org/en-US/docs/Web/Performance/Understanding_latency) (the time it takes for the request to connect to the server storing the files and begin the process of transporting those files). If bunches of files are requested, no matter the technology, there is a limit on how much can be processed and transferred in any given period. I've audited WordPress sites that request as many as 170 files or more, which ensures terrible page loading performance starting with high latency periods.

There are certainly optimizations that can be done, such as compressing and combining certain file requests, using HTTP/2 or the newer HTTP/3 protocols, and using a modern browser's ability to preconnect to and preload certain files to speed the the whole process process up. The [Performance chapter](https://almanac.httparchive.org/en/2021/performance) covers a wide range of factors that effect page loading performance.

## Assets
As explained in last years chapter, there's been little change in most assets in terms of technology, but there are some notable exceptions.

### Static
Static files reside by themselves and are used as resources to help build out and render web pages like video and audio files, and font files are all examples of static assets. [Images](https://almanac.httparchive.org/en/2021/media), which make a large percentage of the average web page's weight, are also a type of static asset file. So, let's use images for our example.

Image file formats like PNG and JPEG are supported by browser vendors for rendering in web pages. More recent image formats, such as WebP, offer high quality, excellent compression (much better than PNG or JPG), and are supported by all major browsers have gained popularity. Some image types that are very good for the web lack full cross browser support so researching what image format will work with what browser is essential. Moreover, the latest browser features can look for the best choice for the browser requesting that image and defaulting back to a fully supported image if one is not available. The main point about images is to make sure they are optimized for the web, the [Media](https://almanac.httparchive.org/en/2021/media) chapter covers this in much more detail. Failing to properly size and compress images for your site will exact a high price on performance.

**Note**: If you need an online service that will optimize your images, there is no better source I've found than Google's [Squoosh](https://squoosh.app/) application, and Jake Archibald's [SVGOMG](https://jakearchibald.github.io/svgomg/) for optimizing SVG's.

#### A word about the proliferation in the use of JavaScript
JavaScript can be a wonderful tool to use for creating a dynamic website, but using it unchecked can create serious performance problems and a horrible experience for the user. There's been a proliferation in the use of complex JavaScript web frameworks and libraries over the past decades. Some of them can cause build sizes for a site to skyrocket leading to serious performance bottlenecks. Some so bad that a site can become unstable or even unusable. Blocking scripts, defined as a request of a script that must be transmitted, processed, and executed before the page can finish rendering enough page assets for users to interact with it. That can cause confusion, frustration, and abandonment by the user.

Example: You navigate to a e-commerce site on your nifty smartphone on slow 4G internet connection, but the site is taking forever to load. It even throws a warning that the page is taking too long to load and asks if you want to continue waiting. Your smartphone or computer stalls and may even need to be restarted. Nine times out of ten a blocking JavaScript that is causing your smartphone to run out of processing resources or memory is to blame. The judicious, expert use of JavaScript can create great user experiences. **But remember this**: *JavaScript is executed on the client side. It's using the client computers resources to process and execute the script, and there is a finite amount of resources on every device*. Once again, not everyone is glued to the newest Google Pixel or Apple smartphone. The [JavaScript](https://almanac.httparchive.org/en/2021/javascript) chapter contains a wealth of information about this issue.

### Dynamic
Dynamically generated assets normally are produced by web programming languages like PHP, JavaScript, etc. Like other files, a requests is sent to locate, process, and retrieve the results of the scripts. The payload is returned to the user's browser for rendering. Generally, dynamic scripting in modern web sites execute extremely fast, and their results can also be cached for even faster use in future requests. But poorly scripted dynamic assets can have the opposite affect, increasing page weight. So, for best results, use best practices and and apply optimizations.

### Connected
Page weight can also be effected by external services that are connected to the web page. Some of those services include CDN's, analytics, chat bots, forms, and other data collection and processing methods. I find this to be one of the fastest growing problem areas that result in bloated page weight. Many of these third party services use outdated, poorly written JavaScript and querying techniques that take much longer to execute than they should, and the site owner has little control over how that third party impacts the loading of a page. Suffice it to say that inquiring about how a service will affect your page loading performance is very important. So is testing their impact.

### Caching
[Caching](https://almanac.httparchive.org/en/2021/caching), are special services/processes that create copies of previously requested optimized assets and store them on remote server or on the client's browser/disk until needed again. Caching of optimized assets dramatically lowers page weight and page loading time because the asset is immediately available, removing the need to execute and entire request process.

## Analysis

As we post and parse statistical results, the data is often based on transfer sizes. However, we are employing decompressed sizes in this analysis whenever possible. Please note that many of the results listed below are similar or the same as those queries used in 2020.

### Page weight by the numbers

Looking at the page weight on both desktop and mobile devices, the deltas are due to the difference in the amount of transferred resources on the mobile device, the difference is generally small between them.

{{ figure_markup(
  image="bytes-distribution.png",
  caption="Distribution of total bytes per page.",
  description="Bar chart showing the distribution of the total bytes per page. Desktop pages tend to have more bytes throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: 409, 928, 1,923, 3,749, and 6,890 KB per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vThwYNAo2K8eVJVNH_4TuA7IZpG534jXn5vFWphLLuHUo_VNGehDMKoIFWf0GquINRKWNHX66MXUmn9/pubchart?oid=8302830&format=interactive",
  sheets_gid="895329225",
  sql_file="bytes_per_type_2021.sql"
) }}

The key data here shows we are closing in on 6.9 MB of page weight on mobile and 8.1 MB on desktop at the 90th percentile. The data is following an old and consistent trend: growth in page weight is on the upward trajectory that continues from the previous year.

{{ figure_markup(
  image="bytes-distribution-content-type.png",
  caption="Median bytes per page by content type.",
  description="Bar chart showing the median number of bytes per page for images, JavaScript, CSS, and HTML. The median desktop page tends to have more bytes. The median mobile page has 877 KB of images, 470 KB of JS, 66 KB of CSS, and 27 KB of HTML.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vThwYNAo2K8eVJVNH_4TuA7IZpG534jXn5vFWphLLuHUo_VNGehDMKoIFWf0GquINRKWNHX66MXUmn9/pubchart?oid=263743460&format=interactive",
  sheets_gid="895329225",
  sql_file="bytes_per_type_2021.sql"
) }}

A closer inspection shows that the media and average for each resource, and following the trend from years previous to this one, images remain the largest resource followed by JavaScript.

### Requests

As previously explained in this chapter, the number of requests and the type of resource requested has a direct influence on total page weight and page loading performance. The difference between current results for this year and last are notable because it actually shows a tiny decrease in the average number of GET requests. Let's hope that trend continues downward.

{{ figure_markup(
  image="requests-distribution.png",
  caption="Distribution of requests per page.",
  description="Bar chart showing the distribution of requests per page. Desktop pages tend to load more requests. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: 23, 41, 69, 110, and 170 requests per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vThwYNAo2K8eVJVNH_4TuA7IZpG534jXn5vFWphLLuHUo_VNGehDMKoIFWf0GquINRKWNHX66MXUmn9/pubchart?oid=356516185&format=interactive",
  sheets_gid="2090334936",
  sql_file="request_type_distribution_2021.sql"
) }}

The request distribution shows that the difference between desktop and mobile is not significant, with desktop leading the way. Something worth noting: the median request on desktop at this time is the same [as last year](../2020/page-weight#page-requests) (74), yet the page weight has ticked up (141 kb), which is consistent with the latest trajectory.

{{ figure_markup(
  image="requests-content-type.png",
  caption="Median number of requests per mobile page by content type.",
  description="Bar chart showing the median number of requests per mobile page by content type. The median number of image requests per page is 23, 20 for JS, 7 for CSS, and 2 for HTML. Desktop and mobile tend to be equal except desktop pages load slightly more image and JS requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vThwYNAo2K8eVJVNH_4TuA7IZpG534jXn5vFWphLLuHUo_VNGehDMKoIFWf0GquINRKWNHX66MXUmn9/pubchart?oid=568469823&format=interactive",
  sheets_gid="2090334936",
  sql_file="request_type_distribution_2021.sql"
) }}

Images again make up the largest number of requests, though JavaScript is closing in as the gap has narrowed slightly in the last year.

### File formats

{{ figure_markup(
  image="response-distribution-format.png",
  caption="Distribution of image sizes by format.",
  description="Box plot of the distribution of image sizes by format: gif, ico, jpg, png, svg, and webp. JPG sticks out as having the highest distribution with a 90th percentile exceeding 190 KB per image, up from the previous year. WebP has overtaken PNG as second highest at about 93 KB at the 90th percentile. PNG is now third with smaller 90th percentile than WebP, its 75th percentile is higher. gif, ico, and svg all have relatively tiny distributions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vThwYNAo2K8eVJVNH_4TuA7IZpG534jXn5vFWphLLuHUo_VNGehDMKoIFWf0GquINRKWNHX66MXUmn9/pubchart?oid=1911661099&format=interactive",
  sheets_gid="38001790",
  sql_file="requests_format_distribution.sql"
) }}

We know that images responsible for a large percentage of web page weight. The above graphic shows the top sources of image weight and the weight distribution. Top 3: JPG, WebP and PNG. So not only is the JPG the most popular image format, it also tends to be the largest by size as well - even larger than a lossless format like the PNG. Likely, the rise in popularity for WebP is due to all major browsers finally supporting the file format. PNG remains popular for use cases such as icons and logos.

### Image bytes

{{ figure_markup(
  image="response-distribution-images.png",
  caption="Distribution of image response sizes per page.",
  description="Bar chart showing the distribution of image bytes per page. Desktop pages tend to load more image bytes per page throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: 62, 257, 877, 2,324, and 4,992 KB of images per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vThwYNAo2K8eVJVNH_4TuA7IZpG534jXn5vFWphLLuHUo_VNGehDMKoIFWf0GquINRKWNHX66MXUmn9/pubchart?oid=1440589973&format=interactive",
  sheets_gid="895329225",
  sql_file="request_type_distribution_2021.sql"
) }}

Looking at total image bytes shows us that this metric has remained virtually unchanged from the previous year. This is likely due more and more images being served by content distribution networks (CDN), which apply strong optimizations to images as they are uploaded to their servers for use on future requests.

## Conclusion

The overall trend moving forward will likely continue to grow for desktop rendered pages and remain mostly unchanged for mobile. Just as they did, along with other browser vendors, for effort to move sites to HTTPS, Google has applied pressure on site owners to put their web pages on a diet, especially for mobile. Google's strategy has been solitified into a program where certain metrics (now called Core Web Vitals) that significantly impact the user experience reward web sites with smaller, faster loading pages by raising their rankings in search results. Conversely, site owners who continue to build heavy pages will be penalized in search results. In a world where small changes in search rankings can have a big impact on the success or failure of a site and their owner's, we should see greater emphasis on creating lighter web pages from design to hosted services that continue to find technological solutions to help keep page assets small and transported in a much faster way.

But will the pressure to lighten the page load, so to speak, cross all web boundaries? What about web titans like Amazon will they follow suit? The answer is unclear. Predicting how the web will be shaped is difficult at best. But there is reason to be optimistic that both kings and subjects in the web world all have good reasons to to make lighter page weights a priority, even if the reasons for doing so differ. A small publisher on the web may be motivated to create ligher pages to compete in search ranking, increase the enjoyment of their users, and doing there part to reduce the amount of energy needed to store, transmit, and render those pages. The Amazon's may want to take advantage of reducing the size of page assets and services to reduce the spend required to serve those pages, and to move into newly emerging markets where users may not be able to buy super fast smartphones or have access to 5G data networks or high speed cable providers. Time will tell.

What is clear is that the upside of lighter, faster loading web pages provide a strong incentive to commit to take advantage of emerging technologies, design and development techniques, and other solutions to stay ahead of the pack.
