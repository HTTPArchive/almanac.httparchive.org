---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: CDN chapter of the 2024 Web Almanac covering adoption of CDNs, top CDN players, the impact of CDNs on TLS, HTTP/2+, Zstandard, Brotli, Early Hints, and Client Hints adoption
authors: [joeviggiano, pgjaiganesh, AlexMoening]
reviewers: [carolinescholles]
editors: [carolinescholles]
analysts: [pgjaiganesh, AlexMoening]
translators: []
results: https://docs.google.com/spreadsheets/d/15YXQQjyoQ0Bnfw9KNSz_YuGDiCfW978_WKEHvDXjdm4/
joeviggiano_bio: Joe Viggiano is a Principal Solutions Architect at Amazon Web Services helping Media & Entertainment customers deliver media content at scale.
pgjaiganesh_bio: Jaiganesh Girinathan is a Principal Edge Solutions Architect at Amazon Web Services.
AlexMoening_bio: Alex Moening is a Senior Edge Solutions Architect at Amazon Web Services.
featured_quote: The benefits of utilizing CDNs have expanded beyond simple performance improvements. In 2024, CDNs play a crucial role in enabling global scalability, enhancing security postures, and facilitating the deployment of complex, distributed applications. By pushing more logic to the edge, businesses can create more responsive and personalized user experiences while reducing the load on origin servers.
featured_stat_1: 70%
featured_stat_label_1: Sites in top 1,000 using a CDN
featured_stat_2: 3x
featured_stat_label_2: Faster TLS negotiation with CDN at p90
featured_stat_3: 56s%
featured_stat_label_3: Domains using Brotli via CDNs
---

## Introduction

This chapter examines the evolving landscape of Content Delivery Networks (CDNs) and their critical role in today's digital ecosystem. As we move from 2022, when our last CDN chapter came together, and into 2024, CDNs continue to be fundamental in delivering content globally, extending their reach beyond large-scale operations to smaller sites and applications. Their significance has grown in facilitating the delivery of not just static content, but also dynamic and personalized experiences, third-party integrations, and Edge Computing.

A key focus of this chapter is the pivotal role CDNs play in driving the adoption of web standards, protocols, and emerging technologies like HTTP/3 and the Quick UDP Internet Connections (QUIC) protocol. We also explore how CDNs are at the forefront of implementing and popularizing performance optimization techniques.

We believe that in 2024, CDNs continue to not only facilitate performant content delivery, but also serve as comprehensive platforms that integrate first and third-party security solutions.

## What is a CDN?

A _Content Delivery Network_ (CDN) is a geographically distributed network of servers designed to provide high availability, enhanced performance, and improved security for web content and applications. The primary goal of a CDN is to minimize latency and optimize content delivery by serving data from locations closer to the end user.

The role of CDNs has expanded significantly in recent years, driven by the increasing complexity of web applications, the growth of streaming services, and the rising demands of e-commerce and digital businesses. In 2024, CDNs are crucial infrastructure supporting a wide range of online activities and the increasing sophistication of web applications.

CDNs have evolved far beyond their original function as simple proxy servers. Today's CDN offerings typically include:

* Caching and content optimization for various types of media
* Intelligent routing and load balancing to minimize network hops and optimize performance
* Edge Computing capabilities, allowing for near-real-time processing and personalization
* Robust security features to protect against a wide range of cyber threats
* Analytics and insights to help businesses understand and optimize their web performance

The benefits of utilizing CDNs have expanded beyond simple performance improvements. In 2024, CDNs play a crucial role in enabling global scalability, enhancing security postures, and facilitating the deployment of complex, distributed applications. By pushing more logic to the edge, businesses can create more responsive and personalized user experiences while reducing the load on origin servers.

Lastly, an often overlooked benefit is how CDNs contribute to sustainability by caching content closer to end users and optimizing the size of files, such as videos and images. This translates to lower energy consumption and a smaller carbon footprint associated with content delivery.

### Caveats and disclaimers

As with any observational study, there are limits to the scope and impact that can be measured. The statistics gathered on CDN usage for the Web Almanac are focused more on applicable technologies in use and not intended to measure performance or effectiveness of a specific CDN vendor. While this ensures that we are not biased towards any CDN vendor, it also means that these are more generalized results.

These are the limits to our testing methodology:

- **Simulated network latency:** We use a dedicated network connection that synthetically shapes traffic.
- **Single geographic location:** Tests are run from a single datacenter and cannot test the geographic distribution of many CDN vendors.
- **Cache effectiveness:** Each CDN uses proprietary technology and many, for security reasons, do not expose cache performance or depth of cache.
- **Localization and internationalization:** Just like geographic distribution, the effects of language and geo-specific domains are also opaque to these tests.
- **CDN detection:** This is primarily done through DNS resolution and HTTP headers. Most CDNs use a DNS CNAME to map a user to an optimal data center. However, some CDNs use Anycast IPs or direct A+AAAA responses from a delegated domain which hide the DNS chain. In other cases, websites use multiple CDNs to balance between vendors, which is hidden from the single-request pass of our crawler.
- **IPv6 detection:** Whether or not a CDN is configured to use IPv6 can be inferred if the DNS entry for the domain name contains a AAAA entry and accepts a connection over IPv6. The 2024 test run did not include this capability, however we’ve ensured this data can be collected for the 2025 Web Almanac.

All of this influences our measurements. These results reflect the support of specific features (for example TLSv1.3, HTTP/2+, Zstandard) per site, but do not reflect actual traffic usage.

With this in mind, here are a few statistics that were intentionally not measured in the context of a CDN:

* Time To First Byte (TTFB)
* Time To Last Byte (TTLB)
* CDN Round Trip Time
* Core Web Vitals
* “Cache hit” versus “cache miss” performance

While some of these could be measured with HTTP Archive dataset, and others by using the CrUX dataset, the limitations of our methodology and the use of multiple CDNs by some sites, will be difficult to measure and so could be incorrectly attributed. For these reasons, we have decided not to measure these statistics in this chapter.

## CDN adoption

A web page is composed of following key components:

1. Base HTML page (for example, `www.example.com/index.html`—often available at a more friendly name like just `www.example.com`).
2. Embedded first-party content such as images, css, fonts and javascript files on the main domain (`www.example.com`) and the subdomains (for example, `images.example.com`, or `assets.example.com`).
3. Third-party content (for example, Google Analytics, advertisements) served from third-party domains.

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="CDN usage vs hosted resources on mobile.",
  description="Bar chart of CDN usage versus hosted resource split by origin and CDN. For HTML content, 67% of requests are from the origin and 33% from CDNs. For subdomain content, 52% origin and 48% CDN. And for third-party content, 25% origin and 75% CDN.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1624864055&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

The chart above shows the breakdown of requests for different types of content (HTML, Subdomain, and Third-party), showing the share of content served by CDN versus origin on mobile devices (identical figures are observed for desktop).

CDNs are often utilized for delivering static content such as fonts, image files, stylesheet, and Javascript.. This kind of content doesn’t change frequently, making it a good candidate for caching on CDNs proxy servers. We still see CDNs are used more frequently for this type of resource–especially for third-party content, with 75% being served via CDN.

CDNs can provide better performance for delivering non-static content as well as they often optimize the routes and use most efficient transport mechanisms.  However, we see that the usage of CDNs for serving HTML still lags considerably behind the other two types of content, with only 33% served via CDN and 77% still being served from the origin.

{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="Trends for content served from CDN for mobile",
  description="This chart shows the trends for content served from CDN for last few years. The general trend is that the CDN usage is increasing. For the contents served from subdomains we see bigger increase.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=776498107&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

The above figure shows the evolution of different content types served from CDNs over the years.

Whether it be the base HTML pages, sub-domains, or third-parties, 2024 saw increased adoption compared to previous years. The fastest pace was seen in third-party with a 8% increase from 67% in 2022 to 75% in 2024.

These are likely some of the reasons behind this continued trajectory:

* The persistence of remote and hybrid working models continues to drive the need for consistent delivery of content to a geographically dispersed user base.
* Growing security threats led more companies to value CDNs' built-in scalable protections like DDoS mitigation and WAF capabilities.
* Improvements in edge computing enabled more rich personalized experiences while reducing infrastructure compute costs.

{{ figure_markup(
  image="cdn-usage-ranking-mobile.png",
  caption="CDN usage by site popularity on mobile.",
  description="This bar chart provides a view of CDN usage for mobile sites broken up for top 1,000, 10,000, 100,000, 1 million and 10 million popular sites as per Google CRUX data. For Top 1000, 10,000 sites the CDN adoption is over 60%. The adoption shows decline for lower popularity sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1083160290&format=interactive",
  sheets_gid="217214696",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

The share of CDN usage has increased over the years, particularly among the most popular websites according to Google Chrome’s UX Report (CrUX) classification. As the graph shows, the top 1,000 websites have the highest CDN usage at 70%, followed by the top 10,000 at 69%, and the top 100,000 at 60%. Compared to our latest results, CDN usage among the top 1,000 to 10,000 most popular websites increased by 6%, while CDN usage among the top 100,000 websites rose by 8%.

As mentioned in previous editions, the increase in CDN usage among smaller sites can be attributed to the rise of free and affordable CDN options. Additionally, many hosting solutions now bundle CDNs with their services, making it easier and more cost-effective for websites to leverage this technology.

## CDN providers

CDN providers can generally be classified into two segments:
1. **Generic CDNs** – Providers that offer a wide range of content delivery services to suit various use cases, including Akamai, Cloudflare, CloudFront, and Fastly.
2. **Purpose-built CDNs** – Providers tailored to specific platforms or use cases, such as Netlify and WordPress.

Generic CDNs address broad market needs with offerings that include:
* Website delivery
* Mobile app API delivery
* Video streaming
* Edge Computing services
* Web security offerings

These capabilities appeal to a wide range of industries, which is reflected in the data.

{{ figure_markup(
  image="top-cdns-html.png",
  caption="Top CDNs for HTML requests on mobile.",
  description="Box plot showing the top CDN providers serving HTML requests. Cloudflare tops the list by serving 55% of the HTML requests followed by Google at 23%, CloudFront 6% Fastly at 5%, and Akamai at 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1061770688&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

The above figure shows the top CDN providers for base HTML requests. The leading vendors in this category are Cloudflare, with a 55% share, followed by Google (23%), Amazon CloudFront (6%), Fastly (6%), Akamai (2%), and Automattic and Vercel, each with a 1% share.

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="Top CDNs for subdomain requests on mobile.",
  description="Box plot showing the top CDN providers serving subdomain requests. Cloudflare tops the list by serving 43% of the subdomain requests followed by CloudFront at 27%, Google at 8%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=316214799&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

For the subdomain requests, we saw an increase in the share of Amazon Cloudfront (from 19% to 27%).

This is driven by many users having their content on cloud service providers that come with a CDN offering. Utilizing compute and other services alongside the cloud service provider CDN helps users scale their applications and increase performance of delivering services to end users.

The leading vendors in this category are Cloudflare (43%), Amazon CloudFront (27%), Google (8%), and Akamai (3%).

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="Top CDNs for third-party requests on mobile.",
  description="Box plot showing the top CDN providers serving third-party requests. Google tops the list by serving 54% of the third-party requests followed by Cloudlare at 14%, CloudFront at 10%, Akamai at 5%, and Fastly at 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=418936134&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

The above figure highlights third-party domain usage, with Google leading the list at 54% market share, followed by well-known CDN providers such as Cloudflare (14%), Amazon CloudFront (10%), Akamai (5%), and Fastly (4%). Notably, Facebook also appears prominently in the rankings, holding a 4% share.

While these CDNs have purpose built features that optimize for particular sets of content delivery workflows, many are also attached to larger service offerings either with cloud services, security, and/or edge computing. These services are often delivered or integrated with the CDNs themselves which further drives adoption as part of a broader ecosystem of services.

Third-party providers like Google and Facebook might wholly optimize and purpose build their CDNs to handle high throughput rates for ad delivery and beacon capturing. While others such as Cloudflare or Amazon CloudFront may optimize a subset of features. These more general use CDNs take these features to integrate into managed services such as providing managed API services to a global user base or dynamically injecting javascript to perform client side inspection of devices for web security purposes.

## HTTP/3 (HTTP/2+) adoption

Published in June of 2022 by IETF, [HTTP/3](https://datatracker.ietf.org/doc/html/rfc9114) is a major revision of the HTTP network protocol, succeeding HTTP/2.

The most notable difference in HTTP/3 is that it uses a protocol called QUIC over UDP instead of the traditional TCP. This change improves performance by reducing latency, allowing faster data transmission, especially in environments with high packet loss or network congestion. TLS v1.3 was an improvement in reducing the number of TCP + TLS network protocol handshakes and round trips from the client to server, but QUIC reduces this further without sacrificing security. Another key improvement is the elimination of head-of-line blocking, meaning if one resource experiences delivery issues, other resources can still load independently. With this enhanced multiplexing and robust encryption, QUIC contributes to a more secure and efficient browsing experience.

For website operators, CDNs handle all the complex implementation details while providing automatic fallback to HTTP/2 when needed. This experience enabled by CDNs is a simple configuration change without requiring significant technical investment on the operator's part.

Due to the way HTTP/3 works (see the [HTTP](./http) chapter for more information), HTTP/3 is often not used for first connections which is why we are instead measuring “HTTP/2+”, since many of those HTTP/2 connections may actually be HTTP/3 for repeat visitors (we have assumed that no servers implement HTTP/3 without HTTP/3).

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="Distribution of HTTP versions for HTML (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin in mobile HTML requests. For mobile HTML requests served from CDN, 98% were served on HTTP/2 or better protocol while requests served from origin had 71% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1385171364&format=interactive",
  sheets_gid="456632996",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

In 2022, we observed a stark contrast of HTTP/2+ usage between CDN and origin servers. While a gap persists whereby CDN usage of HTTP/2+ is higher 98% compared to 71%, the origin usage of HTTP/2+ continues to grow in adoption which we can see with 42% in 2022 to 71% in 2024.

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="Distribution of HTTP versions for third-party requests (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin for third-party requests on mobile. For these third-party requests served from CDN, 96% were served on HTTP/2 or better protocol while requests served from origin had 71% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1384687606&format=interactive",
  sheets_gid="456632996",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

The trend for HTTP/2+ adoption in third-party domains follows the same as for HTML above. Compared to 2022, HTTP/2+ CDN usage increased from 88% to 96% while origin increased from 47% to 71%.

Overall compared to previous years, while CDNs continue to lead in the adoption of newer HTTP versions, in 2024 origin servers are beginning to catch up. This could be a result of the critical mass of CDN traffic already using HTTP/2+, but we look forward in future chapters to diving deeper into these trends as they unfold.

## Compression

Compression remains a fundamental aspect of web content delivery, playing a crucial role in optimizing user experience and website performance. By reducing the size of files transmitted over networks, compression contributes to faster page load times, decreased bandwidth consumption, and improved overall web browsing efficiency. Despite advancements in network speeds and the proliferation of diverse connectivity options, compression continues to be a key factor in enhancing internet experiences across all types of connections.

Within the web ecosystem we observed several commonly used compression algorithms:

* Gzip
* Brotli
* Zstandard (Zstd)

While media files such as JPEG images are already compressed, textual assets such as HTML, stylesheets, javascript, and manifest files can be compressed to optimize performance. Created in 1992, [Gzip](https://en.wikipedia.org/wiki/Gzip) is the longest standing compression widely used, however as we’ll see in this chapter [Brotli](https://en.wikipedia.org/wiki/Brotli) has become the de facto algorithm for compressing textual data over the web ecosystem. In 2024, we also see the emergence of Zstandard which was developed by Facebook. Each of these algorithms has its strengths and use cases, and their adoption rates vary across the web.

Below is the analysis of compression types used by CDNs and origin servers in the Web Almanac 2024 reveals trends in how web content is optimized for delivery.

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="Distribution of compression types (mobile).",
  description="This bar chart shows the Brotli adoption across CDN and origin on mobile requests. CDNs served 55.89% of requests in Brotli compressed format and 41.38% of requests in gzip compressed format. Origin on the other hand served 41.83% of requests in Brotli compressed format and 57.40% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1837507742&format=interactive",
  sheets_gid="1383966713",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

CDNs are leading in Brotli adoption, with over 55% of CDN served content using Brotli compression up from 47% in 2022. In contrast, less than 42% of content served directly from origin servers uses Brotli, however this is up from 25% from 2022. While Gzip remains the majority compression algorithm used by origin servers, Brotli continues its upward adoption trajectory.

### Zstandard (Zstd) adoption

Zstandard (Zstd) is a compression algorithm developed by Facebook and released in 2016. It aims to provide a good balance between compression ratio and speed, making it a potential alternative to established algorithms like Gzip and Brotli in web content delivery scenarios.

As of 2024, browser support for Zstandard in web content delivery has improved considerably:

* **Chrome:** Supported by default since version 121 (released January 2024)
* **Edge:** Supported by default since version 121 (released January 2024)
* **Firefox:** Supported behind a flag since version 123 (released March 2024)
* **Safari:** No native support as of the latest version
* **Opera:** Supported by default since version 108 (released January 2024)

This represents a significant shift in Zstandard's availability for web content delivery, with major Chromium-based browsers now offering native support.

Despite the recent improvements in browser support and Zstd's technical capabilities, our data shows that Zstandard adoption for web content delivery remains limited compared to Gzip and Brotli. CDNs only show 2.72% adoption rate of Zstandard and origin servers 0.70%.

While Zstd offers benefits, the real-world performance improvements over Brotli in web scenarios may not yet be fully established or significant enough to drive rapid adoption for all use cases. Zstd's flexibility in compression levels and dictionary compression may be particularly beneficial for certain types of content or delivery scenarios, which could lead to targeted adoption. We look forward to exploring this data more in future chapters.

### Distribution of compression types

{{ figure_markup(
  image="cdn-types-compression-mobile.png",
  caption="Distribution of compressions across CDNs (mobile).",
  description="Brotli usage is prevalent on Cloudflare and Google CDNs while Gzip remains the majority across Akamai, Amazon CloudFront, and Fastly. However, when compared to 2022 Brotli continues its broad trend towards more adoption with larger CDN providers. The outlier in our dataset was Facebook which had over 60% adoption of Zstandard. Facebook’s strategy has been to optimize content delivery using their own compression algorithm so this result is expected",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=168908770&format=interactive",
  sheets_gid="1455879080",
  sql_file="distribution_of_compression_types_by_cdn.sql"
  )
}}

Brotli usage is prevalent on Cloudflare and Google CDNs while Gzip remains the majority across Akamai, Amazon CloudFront, and Fastly. However, when compared to 2022 Brotli continues its broad trend towards more adoption with larger CDN providers. The outlier in our dataset was Facebook which had over 60% adoption of Zstandard. Facebook’s strategy has been to optimize content delivery using their own compression algorithm so this result is expected.

## TLS usage

### TLS 1.3 adoption

It's good news that both CDN and origin requests have largely moved away from serving older, less secure TLS versions 1.0 and 1.1. This means that clients are now using more modern and secure protocols.

CDNs have embraced TLS 1.3, with 98% of requests using this latest version. This is great for developers because TLS 1.3 is faster at establishing secure connections, which means websites load more quickly. CDNs are at the forefront of adopting new technologies to  optimize content delivery and security and by fronting your application with a CDN, you automatically reap those benefits with minimal efforts.

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="Distribution of TLS version for HTML (mobile).",
  description="Bar chart of TLS version usage in mobile requests served by CDN and origin. We find identical results where both mobile and desktop have 98% adoption of TLS 1.3 over CDNs. Mobile vs desktop directly to origin servers were nearly identical as well with mobile at 73% and desktop 71%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=121226278&format=interactive",
  sheets_gid="1400986662",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

When we look closely at how TLS is being used by different device types (Mobile vs Desktop), we find identical results where both mobile and desktop have 98% adoption of TLS 1.3 over CDNs. Mobile vs desktop directly to origin servers were nearly identical as well with mobile at 73% and desktop 71%. This represents a significant increase in TLS 1.3 adoption when compared to 2022. Mobile CDN TLS 1.3 traffic represented 87% in 2022 compared to 98% in 2024 and through origin servers from 42% now to 73%.

While origin servers have begun to catch up with adoption of TLS 1.3, this further shows how CDNs drive newer features quicker than when web server operators have to perform software and hardware upgrades for the same new features.

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="Distribution of TLS version for third-party requests (mobile).",
  description="Bar chart of TLS version usage in third-party requests on desktop, served by CDN and origin. CDNs have served 93% of the third-party requests using TLS 1.3 and 7% of the requests in TLS 1.2. Origin on the other served 68% of the requests over TLS 1.3 and 32% of the requests on TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=125141741&format=interactive",
  sheets_gid="1400986662",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

We find a similar story with third-party TLS 1.3 adoption with CDNs at 93% and origins at 68%. There was a small increase from 2022 for CDNs TLS 1.3 from 88% to 93% but as with our other results, the origin server increased significantly with 2022 at 26% to now 68%.

### TLS performance impact

TLS negotiation times reveal significant differences between CDN and Origin servers, as well as between desktop and mobile devices.

For desktop users, CDN performance is notably faster than Origin servers across all percentiles. The median (p50) TLS negotiation time for CDN is 70 milliseconds, compared to 183 milliseconds for Origin server. This trend is consistent across other percentiles, with CDN outperforming Origin at every level. For instance, at the 90th percentile (p90), CDN negotiation times are 108 milliseconds, while Origin servers take 289 milliseconds - more than 2.5 times longer.

{{ figure_markup(
  image="tls-negotiation-desktop.png",
  caption="HTML TLS negotiation - CDN vs origin (desktop)",
  description="This bar chart provides insight into TLS connection time (in milliseconds) across 10th, 25th, 50th, 75th and 90th percentile for CDN and origin. As it can be seen from the chart the TLS negotiation time is generally faster for CDNs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1820997303&format=interactive",
  sheets_gid="846467421",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

Mobile devices show a similar pattern, with CDN performing better than Origin servers, but the overall negotiation times are higher compared to desktop. The median TLS negotiation time for mobile CDN is 196 milliseconds, while for Origin servers it's 316 milliseconds. At the 90th percentile, mobile CDN takes 256 milliseconds, whereas Origin servers require 451 milliseconds.

{{ figure_markup(
  image="tls-negotiation-mobile.png",
  caption="HTML TLS negotiation - CDN vs origin (mobile)",
  description="This bar chart provides insight into TLS connection time (in milliseconds) across 10th, 25th, 50th, 75th and 90th percentile for CDN and origin. As it can be seen from the chart the TLS negotiation time is generally faster for CDNs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=899797304&format=interactive",
  sheets_gid="846467421",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

Comparing desktop and mobile TLS negotiation times, we observe that mobile devices consistently have longer TLS negotiation times regardless of whether request is served from CDN or Origin server. For example, the median negotiation time for mobile CDN (196 ms) is nearly three times that of desktop CDN (70 ms). This difference is less pronounced for Origin servers, but still significant, with mobile median times (316 ms) being about 1.7 times longer than desktop (183 ms).

The disparity between desktop and mobile performance is likely due to the typically lower processing power and potentially less stable network connections of mobile devices. The superior performance of CDN over Origin server can be attributed to the distributed nature of CDNs, which places content closer to end-users and optimizes for faster connections.

## Image formats and optimization

Image formats play a crucial role in Content Delivery Networks (CDNs) and can significantly impact website performance, user experience, and overall efficiency. Modern image file formats like WebP and AVIF offer superior compression compared to traditional formats like JPEG and PNG. This results in smaller file sizes, which leads to faster page load times, reduced bandwidth usage and improved user experience.

Most CDNs can automatically detect the user's browser capabilities and serve the most appropriate image format. For example: AVIF to Chrome browsers, WebP to Edge browsers, JPEG to older browsers. They can further resize and cache images on the fly to handle responsive design requirements. This allows site operators to upload a single high resolution image and not having to maintain all its variations as site layout evolves.

{{ figure_markup(
  image="cdn-image-formats-mobile.png",
  caption="Distribution of Image Formats (mobile).",
  description="This pie chart shows the breakdown of image formats observed across mobile devices.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=247539166&format=interactive",
  sheets_gid="918737048",
    sql_file="image_formats.sql"
  )
}}

As of 2024,  data reveals that while traditional formats like JPEG and PNG still dominate, there's a clear trend towards adopting more efficient and mobile-friendly formats like WebP and SVG. The mobile ecosystem generally shows higher numbers for most formats, reflecting the growing importance of mobile web usage. The presence of newer formats like AVIF suggests an industry push towards more efficient image delivery, which is crucial for improving web performance and user experience across all devices.

## Client hints

First proposed as a way to reduce information from the User-Agent string, Client Hints allows a web server to proactively request data from the client and are sent as part of the HTTP headers. Client Hints are divided into four categories: device, user-agent preferences,  user preference media features, and networking. This further is broken down into high and low entropy hints. High entropy hints may provide the ability for the CDN or other entities to fingerprint and thus are typically gated by user permissions or other policies driven by the browser. Low entropy hints are less likely to be provide the ability for the client to be fingerprinted. Low entropy hints may be provided by default depending on user or browser settings.

Based on the provided information, the server can determine the most optimal resources to respond with to the requesting client. While initially developed for Google Chrome browser, other Chromium based browsers have adopted it, but other popular browsers continue to have limited or no support for Client Hints.

The CDN, origin servers, and client browser must all support Client Hints to be utilized properly. As part of the flow, the CDN can present the Accept-CH HTTP header to the client in order to request which Client Hints a client should include in subsequent requests. We measured clients responses where the CDN provided this header inside the request and measured it across all CDN requests recorded as part of our testing.

{{ figure_markup(
  image="cdn-client-hints-mobile.png",
  caption="Client Hints Comparison (mobile).",
  description="This bar chart shows the usage of Client Hints in CDNs. Currently only 3.8% of the requests have client hints",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1795720470&format=interactive",
  sheets_gid="2034431888",
  sql_file="client_hints_cdn_vs_origin.sql"
  )
}}

In 2022, Client Hints adoption was at less than 1% for mobile requests. While the 2024 result was an increase with less than 4% of the requests for mobile devices indicating the presence of Client Hints, adoption of this capability remains low relative to the overall amount of requests observed. Though not explored in this year's chapter, if Client Hints adoption continues to grow we may in future chapters measure how CDNs are using the Accept-CH header to vary on for caching purposes and a more personalized experience.

## Early hints

Early Hints is the [HTTP 103 status code](https://datatracker.ietf.org/doc/html/rfc8297#section-2) that allows servers to send preliminary HTTP headers to browsers before the main response is ready. This is particularly valuable for preloading critical resources like stylesheet, JavaScript, and fonts.

While major browsers support Early Hints, we found hardly any adoption across the dataset. However, as seen with other newer and emerging features such as TLSv1.3, CDN’s continue to lead the way in driving adoption compared to support going directly to web servers. Even still, we only observed CloudFlare and Fastly support Early Hints in any significant number compared to the rest of the CDN community.

{{ figure_markup(
  image="cdn-early-hints-mobile.png",
  caption="Early Hints Comparison (mobile).",
  description="This bar chart shows the usage of Early Hints in CDNs. Currently only 0.086% of the requests have client hints",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=609256029&format=interactive",
  sheets_gid="954411290",
  sql_file="early_hints_cdn_vs_origin.sql"
  )
}}

As adoption of Early Hints increases we look forward to exploring more the performance implications that hints may provide. In future chapters we hope to observe more CDNs implement Early Hints and be able to show more granular statistics.

## Conclusion

In 2022, we observed CDNs be the driving force behind the adoption of new and emerging technologies such as HTTP/3 and in 2024 this trend continued. Whether we look at compression types like Brotli and ZStandard or encryption protocol TLS 1.3, CDNs reduce the heavy lifting of implementation with a simple configuration change rather than upgrading fleets of web servers, load balancers, and other network devices.

We looked into new metrics this year with Early Hints and ZStandard compression. We revisited Client Hints and Image Formats which were added in 2022. In 2025 we look to add more granular details for HTTP/3 and dive into how CDNs are impacting the adoption of IPv6.

All CDNs use custom developed or modified opensource technologies for caching and optimizing the moving of bits across their networks and the public internet. Due to this there are limitations to the insights we can deduce about CDNs from the outside. However, we have crawled the domains and compared the ones on CDNs against those who are not. We can see that CDNs have been an enabler for websites to adopt new web protocols, from the network layer to the application layer.

Content Delivery Networks are becoming increasingly vital to the internet's infrastructure, and their significance shows no signs of waning. Their technology remains essential for businesses that depend on the internet, ensuring seamless operations with speed, reliability, and security at the forefront.

We recommend readers visit the [HTTP](./http) and [Security](./security) chapters of the 2024 Web Almanac where several topics in this chapter are expanded on and provide data through a different lens.

Join us again in 2025 as we collect and analyze more data to see what new insights we can share with our readers.
