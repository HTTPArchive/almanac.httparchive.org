---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: CDN chapter of the 2025 Web Almanac covering adoption of CDNs, top CDN players, the impact of CDNs on TLS, HTTP/2+, Zstandard, Brotli, Early Hints, and Client Hints adoption.
hero_alt: Hero image of Web Almanac characters extending a plug from a cloud into a web page.
authors: [joeviggiano, AlexMoening, nick-mccord]
reviewers: [carolinescholles]
editors: [carolinescholles]
analysts: [AlexMoening, nick-mccord, joeviggiano]
translators: []
results: https://docs.google.com/spreadsheets/d/1xc7EkFIIA5Lon9Ao9ksmiIq-0j0qc1TbhreKJgc5DBE/edit
joeviggiano_bio: Joe Viggiano is a Principal Solutions Architect at Amazon Web Services helping Media & Entertainment customers deliver media content at scale.
nick-mccord_bio: Nick McCord is a Solutions Architect at Amazon Web Services focusing on startups and edge services.
AlexMoening_bio: Alex Moening is a Senior Edge Solutions Architect at Amazon Web Services.
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

This chapter examines the rapidly evolving landscape of Content Delivery Networks (CDNs) in 2025, with particular focus on their role as HTTP protocol optimization. CDNs fundamentally exist to solve HTTP delivery challenges at scale, from reducing TCP connection overhead through HTTP/2 multiplexing to eliminating head-of-line blocking via HTTP/3's QUIC transport. As HTTP protocols have evolved from HTTP/1.1's connection limitations to HTTP/3's advanced features, CDNs have served as the primary deployment vehicle, implementing these protocols years before origin servers adopt them.

Modern CDNs optimize delivery across the entire spectrum of web content. For highly cacheable resources (static assets, public API responses, shared content), CDNs provide traditional caching benefits enhanced by advanced compression and modern format delivery. For content with limited cacheability (user-specific data, frequently updated APIs, personalized experiences), CDNs still deliver performance improvements through connection optimization, intelligent routing, and edge processing, reducing latency even when content cannot be cached.

Our 2025 analysis reveals how CDNs are not merely content distributors, but sophisticated HTTP protocol processors that optimize every aspect of the request-response cycle: connection establishment, protocol negotiation, header optimization, response compression, and connection reuse across the full spectrum of web content cacheability.

Building upon our comprehensive analysis from 2024, our 2025 analysis reveals shifts in protocol adoption, optimization strategies, and the emergence of new performance paradigms that are reshaping how content is delivered globally. A key focus of this chapter is the maturation of HTTP/3 adoption, the rise of modern optimization techniques like Server-Timing transparency, and the sophisticated multi-layered approaches CDNs are taking to performance, security, and user experience.

In 2025, we observe that CDNs have evolved beyond simple content delivery to become comprehensive optimization platforms that automatically implement best practices, enabling even smaller websites to benefit from enterprise-grade performance and security features.

## What is a CDN?

A _Content Delivery Network_ (CDN) is a geographically distributed network of servers designed to provide high availability, enhanced performance, and improved security for web content and applications. The primary goal of a CDN is to minimize latency and optimize content delivery by serving data from locations closer to the end user.

CDNs serve as intermediary infrastructure between end users and origin servers, intercepting web requests and optimizing the complete delivery process. To understand how CDNs can enhance web performance, consider the traditional web interaction when a user types a hostname into a browser, and how different CDNs may improve each step:

### **Traditional Web Request Flow vs CDN Processed Flow**

**1. DNS Resolution**
- **Traditional**: Browser queries DNS for origin server IP, often with slow resolution times
- **CDN Processed**: CDN DNS infrastructure may use various routing strategies (anycast or unicast) to direct users to optimal edge servers. Some CDNs support modern DNS records like HTTPS or SVCB (Service Binding) records that can advertise protocol capabilities directly in DNS responses, though adoption varies across providers

**2. Connection Establishment** 
- **Traditional**: Browser establishes new TCP connection to distant origin server with full handshake overhead
- **CDN Processed**: Connection to nearby edge server over TCP (for HTTP/1.1 and HTTP/2) or UDP with QUIC (for HTTP/3). CDNs may support HTTP/3's 0-RTT connection resumption for returning visitors, though not all CDNs have implemented these newer connection optimization features

**3. Protocol Negotiation**
- **Traditional**: Limited to origin server's protocol capabilities, often older HTTP versions
- **CDN Processed**: Many CDNs can advertise modern protocol availability through Alt-Svc (Alternative Service) headers that inform browsers about alternative protocols. CDNs typically provide protocol translation benefits, accepting newer protocols from browsers while maintaining optimized connections to origins, regardless of origin server capabilities

**4. Request Processing & Optimization**
- **Traditional**: Basic request forwarding with minimal processing
- **CDN Processed**: Depending on the CDN, may include header normalization, intelligent routing decisions, addition of performance headers like Server-Timing which provides server-side performance metrics, security headers, and request optimization based on content type and user geographic location

**5. Response Processing**
- **Traditional**: Direct response from origin server, limited by origin's HTTP server capabilities
- **CDN Processed**: CDNs may implement advanced caching strategies, cache validation, Content-Encoding optimization (such as Brotli or Gzip compression), conditional request support (like 304 Not Modified responses that save bandwidth), and response transformation, though specific features vary by provider

**6. Connection Management**
- **Traditional**: Single connection per request or basic keep-alive to origin
- **CDN Processed**: Many CDNs implement dual-sided connection optimization, maintaining persistent connections to clients while using intelligent connection pooling to origin servers, reducing overhead on both ends

CDNs serve as deployment platforms for emerging web standards, implementing new HTTP headers, compression algorithms, and security features at scale before they become widely adopted by origin servers. This positions CDNs as critical infrastructure for web technology evolution, though the specific features and optimizations available depend significantly on the CDN provider and their technology adoption timeline.

### Caveats and disclaimers

Our 2025 analysis builds upon the methodology established in previous years while incorporating new metrics and deeper performance analysis. The statistics gathered focus on applicable technologies and optimization patterns rather than vendor specific performance comparisons.

Key limitations of our testing methodology remain:

- **Simulated network conditions:** Tests use controlled network environmentss
- **Single geographic perspective:** Analysis from limited datacenter locations
- **Cache effectiveness:** Each CDN uses proprietary technology and many, for security reasons, do not expose cache performance or depth of cache.
- **Localization and internationalization:** Just like geographic distribution, the effects of language and geographic specific domains are also opaque to these tests.
- **CDN detection:** This is primarily done through DNS resolution and HTTP headers. Most CDNs use a DNS CNAME to map a user to an optimal data center. However, some CDNs use Anycast IPs or direct A+AAAA responses from a delegated domain which hide the DNS chain. In other cases, websites use multiple CDNs to balance between vendors, which is hidden from the single-request pass of our crawler.
- **Sampling bias:** HTTP Archive data reflects popular websites, potentially overrepresenting certain CDN providers
- **Market share interpretation:** Our data shows CDN usage patterns among crawled sites, not true market distribution

## CDN adoption

A web page is composed of following key components:

1. Base HTML page (for example, `www.example.com/index.html`—often available at a more friendly name like just `www.example.com`).
2. Embedded first-party content such as images, css, fonts and javascript files on the main domain (`www.example.com`) and the subdomains (for example, `images.example.com`, or `assets.example.com`).
3. Third-party content (for example, Google Analytics, advertisements) served from third-party domains.

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="CDN usage vs hosted resources on mobile.",
  description="CDN usage statistics for mobile web requests in 2025, showing that third-party resources lead CDN adoption at 71%, followed by subdomain requests at 52%, while HTML content has the lowest CDN usage at 35%. Data sourced from Web Almanac 2025 CDN analysis.s",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1479730898&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

The chart above shows the breakdown of requests for different types of content (HTML, Subdomain, and Third-party), showing the share of content served by CDN versus origin on mobile devices.

CDNs are often utilized for delivering static content such as fonts, image files, stylesheets, and JavaScript. This kind of content doesn't change frequently, making it a good candidate for caching on CDN proxy servers. We still see CDNs are used more frequently for this type of resource, especially for third-party content, with 71% being served via CDN. Subdomain resources show moderate CDN adoption at 52%, while HTML content has the lowest CDN usage at 35%, as it's more commonly served directly from origin servers.

{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="Trends for content served from CDN for mobile.",
  description="This chart shows the trends for content served from CDN from 2021 to 2025 across different content types. The general trend is that the CDN usage is moderately increasing with a noteable decline in third-party content.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=826488129&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

The above figure shows the evolution of different content types served from CDNs over the years. From 2024 to 2025, we see mixed trends across content types. HTML content continued its upward trajectory, increasing from 33% to 35%. Subdomain content remained stable at 52% in both years. However, third-party content experienced a notable decline from 75% in 2024 to 71% in 2025, representing a 4 percentage point decrease after years of consistent growth.

{{ figure_markup(
  image="cdn-usage-ranking-mobile.png",
  caption="CDN usage by site popularity on mobile.",
  description="This bar chart shows CDN usage for mobile sites by popularity ranking using Google CrUX data. The top 1,000 sites have 71% CDN adoption, top 10,000 sites show 70%, dropping to 62% for top 100,000 sites, 49% for top 1 million, and 35% for top 10 million sites. CDN adoption clearly decreases as site popularity declines.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=363845861&format=interactive",
  sheets_gid="347054981",
  sql_file="top_cdns_by_rank.sql"
  )
}}

The share of CDN usage has increased over the years, particularly among the most popular websites according to Google Chrome's UX Report (CrUX) classification. As the graph shows, the top 1,000 websites have the highest CDN usage at 71%, followed by the top 10,000 at 70%, and the top 100,000 at 62%. Compared to 2024, CDN adoption has increased regardless of popularity rank.

As mentioned in previous editions, the increase in CDN usage of 33% in 2024 to 35% in 2025 among smaller sites can be attributed to the rise of free or flat tiered affordable CDN options. Additionally, many hosting solutions now bundle CDNs with their services, making it easier and more cost-effective for websites to leverage this technology.

## CDN providers

CDN providers can generally be classified into two segments:
1. **Generic CDNs** – Providers that offer a wide range of content delivery services to suit various use cases, including Akamai, Cloudflare, CloudFront, and Fastly.
2. **Purpose-built CDNs** – Providers tailored to specific platforms or use cases, such as Netlify and WordPress.

Generic CDNs address broad market needs with offerings that include:
* Website delivery
* Web application API delivery
* Video streaming
* Edge Computing services
* Web security offerings

These capabilities appeal to a wide range of industries, which is reflected in the data.

{{ figure_markup(
  image="top-cdns-html.png",
  caption="Top CDNs for HTML requests on mobile.",
  description="Box plot showing the top CDN providers serving HTML requests. Cloudflare tops the list by serving 58% of the HTML requests followed by Google at 21%, CloudFront 7% Fastly at 5%, and Vercel at 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=419170909&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

The above figure shows the top CDN providers for base HTML requests. The leading vendors in this category are Cloudflare, with a 58% share, followed by Google (21%), Amazon CloudFront (7%), Fastly (5%), and Akamai and Vercel, each with a 2% share.

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="Top CDNs for subdomain requests on mobile.",
  description="Box plot showing the top CDN providers serving subdomain requests. Cloudflare tops the list by serving 46% of the subdomain requests followed by CloudFront at 28%, Google at 5%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=923125707&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

Marginally changing from 2024, the leading vendors in this category are Cloudflare (46%), Amazon CloudFront (28%), Google (5%), and Akamai (4%).

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="Top CDNs for third-party requests on mobile.",
  description="Box plot showing the top CDN providers serving third-party requests. Google tops the list by serving 53% of the third-party requests followed by Cloudlare at 17%, CloudFront at 11%, Fastly at 5%, and Akamai at 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1443211673&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

The above figure highlights third-party domain usage, with Google leading the list at 53% market share, followed by well-known CDN providers such as Cloudflare (17%), Amazon CloudFront (11%), Fastly (5%), and Akamai and Facebook (4%).

While many CDNs offer purpose built features optimized specifically for content delivery, they increasingly exist as part of larger service ecosystems. These CDNs are often tightly integrated with cloud infrastructure, security solutions, and edge computing platforms, with these adjacent services delivered through or alongside the CDN itself.

Different CDN providers take distinct approaches to optimization and specialization. Third party platforms like Google and Facebook build highly specialized CDNs engineered specifically for their needs, handling massive throughput for ad delivery and capturing analytics beacons at scale. In contrast, general purpose CDNs like Cloudflare and Amazon CloudFront optimize targeted feature sets while maintaining broader applicability. These platforms leverage their CDN capabilities as a foundation for managed services, enabling use cases such as globally distributed API gateways or real time JavaScript injection for client side device fingerprinting and security inspection.

## HTTP/3 adoption

Published in June of 2022 by IETF, <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9114">HTTP/3</a> is a major revision of the HTTP network protocol, succeeding HTTP/2 .

HTTP/3's performance improvements stem from fundamental protocol design changes that CDNs are uniquely positioned to leverage at global scale. Unlike HTTP/2's reliance on TCP, HTTP/3 uses QUIC over UDP, eliminating TCP's head of line blocking. When one HTTP/2 stream encounters packet loss, all multiplexed streams on that TCP connection stall. CDNs implementing HTTP/3 can maintain performance for unaffected requests through QUIC's independent stream recovery. This is particularly valuable for CDNs serving mixed content where a slow loading image won't block critical CSS or JavaScript delivery.

HTTP/3 reduces connection establishment from HTTP/2's 3 RTTs (TCP handshake, TLS handshake, and HTTP negotiation) to 1 RTT through QUIC's integrated cryptographic handshake. CDNs amplify this benefit through geographic proximity, as users connecting to nearby CDN edge servers experience reduced connection time. For returning visitors, some CDNs implement 0 RTT connection resumption, eliminating handshake overhead entirely when reconnecting to the same edge server.

Modern CDNs are beginning to implement HTTPS DNS records, a type of Service Control Binding that allows DNS responses to advertise HTTP/3 availability and connection parameters directly. When a browser queries DNS for a CDN enabled domain, HTTPS records can indicate HTTP/3 support on port 443 with specific QUIC parameters, enabling immediate HTTP/3 connections without the traditional HTTP/2 to HTTP/3 upgrade process. This DNS level optimization is particularly powerful for CDNs managing multiple domains and services, as it eliminates protocol upgrade negotiations and can reduce connection establishment time. However, HTTPS record implementation varies significantly across CDN providers, with some leading adoption while others have not yet implemented support.

In previous years HTTP/3 adoption was difficult to break out due to the nature of many clients connecting over HTTP/2 first and upgrading the protocol to HTTP/3. However, in 2025 we took a different approach with the dataset and were able to more accurately break out the HTTP/3 connections.

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="Distribution of HTTP versions for HTML (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin in mobile HTML requests. For mobile HTML requests served from CDN, 29% were served on HTTP/3, 69% on HTTP/2, and only 2% on HTTP/1.1. While on origin requests served 0% HTTP/3 with 79% on HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1323331086&format=interactive",
  sheets_gid="1482788843",
  sql_file="h3_adoption_by_cdn_vs_origin.sql"
  )
}}

The above further reinforces the role CDNs play in driving the adoption of new protocols. CDNs saw 29% traffic from HTTP/3 while statistically 0% for origin. Compared to 2024, we observed a sharp descrease in CDN usage for HTTP/1.1 in 2025.

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="Distribution of HTTP versions for third-party requests (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin for third-party requests on mobile. For these third-party requests served from CDN, 45% were served on HTTP/3 protocol while requests served from origin had only 7% requests served on HTTP/3 protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=642743139&format=interactive",
  sheets_gid="1482788843",
  sql_file="h3_adoption_by_cdn_vs_origin.sql"
  )
}}

While HTTP/1.1 usage has been on a continued decline with CDNs over the past several years, in 2025 we observed a sharp descrease in CDN usage for HTTP/1.1 going from 16% usage for HTML requests in 2024 to just 2% in 2025. This descrease was even more pronounced for origin requests with 56% HTTP/1.1 requests in 2024 down to 21% in 2025.

## Compression

Compression continues to be essential for web content delivery, representing one of the most accessible performance optimizations available for websites. Smaller file sizes mean faster page loads, lower bandwidth costs, and a better experience for users. Even as network speeds improve and connectivity options expand, compression remains important for optimizing performance across all types of internet connections.

From the 2025 dataset we observed several commonly used compression algorithms:

* Gzip
* Brotli
* Zstandard (Zstd)

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="Distribution of compression types (mobile).",
  description="This bar chart shows the Brotli adoption across CDN and origin on mobile requests. CDNs served 46% of requests in Brotli compressed format, 42% of requests in gzip compressed format, and 12% in Zstandard. Origin on the other hand served 39% of requests in Brotli compressed format and 61% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=573344627&format=interactive",
  sheets_gid="950988863",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

CDNs are leading the adoption of Brotli and Zstandard compression. Compared to 2024, Zstandard saw a significant increase from 3% to 12% in 2025. However, similar to 2024 Gzip remains the majority compression algorithm used by origin servers.

