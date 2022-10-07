---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: CDN chapter of the 2021 Web Almanac covering adoption of CDNs, top CDN players, the impact of CDNs on TLS, HTTP/2+, and Brotli adoption
authors: [harendra, joeviggiano]
reviewers: [ytkoka]
analysts: [harendra, ]
editors: [harendra]
translators: []
results: https://docs.google.com/spreadsheets/d/1DL7Pn1vbBwYmQZ5JPAjD69oCOvUidbuoNvdrw%2D%2Dj00U/
harendra_bio: Haren Bhandari is a Solutions Architect at Amazon Web Services. Before joining Amazon Web Services, Haren used to work at Akamai Technologies and has deep experience with CDNs.
joeviggiano_bio: Joe Viggiano is a Media & Entertainment Solutions Architect at Amazon Web Services helping customers deliver media content at scale.
featured_quote: CDNs have been in existence for over two decades. With the exponential rise in internet traffic, contributed by online video consumption, online shopping, and increased video conferencing due to COVID-19, CDNs are required more than ever before.
featured_stat_1: 62.3%
featured_stat_label_1: Top 1,000 popular sites using a CDN
featured_stat_2: 3x
featured_stat_label_2: Faster TLS negotiation with CDN at p90
featured_stat_3: 42.5%
featured_stat_label_3: Domains using Brotli on CDN
---

## Introduction

This chapter provides the insights regarding the current state of CDN usage. CDNs are increasingly playing important roles even for the smaller sites to deliver content to the user anywhere in the globe and facilitate the delivery of third party content 
such as Javascript libraries, Fonts and other content.
We have looked at the usage of CDNs over the past few years gaining very useful insights. This year we have expanded our dataset to include top 10 million sites to provide a much bigger picture regarding CDN usage.
We think that CDNs will play a vital role in the future not just for content delivery but for the content security as well. 
We recommend the users to look at CDNs from both performance and security viewpoint.


## What is a CDN?

A _Content Delivery Network_ (CDN) is a geographically distributed network of proxy servers in data-centers. The goal of a CDN is to provide high availability and performance for web content. It does this by distributing content closer to the end users.

CDNs have been in existence for over two decades. With the exponential rise in internet traffic contributed by online video consumption, online shopping, and increased video conferencing due to COVID-19, CDNs are required more than ever before. They ensure high availability and good web performance despite this growth in internet traffic.

During the early days, a CDN was a simple network of proxy servers which would:

1. Cache content (like HTML, images, stylesheets, JavaScript, videos, etc.)
2. Reduce network hops for end users to access content
3. Offload TCP connection termination away from the data centers hosting the web properties

They primarily helped web owners to improve the page load times and to offload traffic from the infrastructure hosting these web properties.

Over time, the services offered by CDN providers have evolved beyond caching and offloading bandwidth/connections. Now they offer additional services such as:

* Cloud-hosted Web Application Firewalls
* Bot Management solutions
* Clean pipe solutions (Scrubbing Data-centers)
* Serverless Computing offerings
* Image and Video Management solutions etc.,

Thus, a web owner these days has a lot of options to choose from. This can be overwhelming and complex since these new offerings from CDNs make them an extension of your application and require closer integration with application development life-cycles.

There are benefits to web owners in pushing web application logic and workflows closer to the end user. This eliminates the round trip and bandwidth that a HTTP/HTTPS request would take. It also handles near-instant scalability requirements for the origin. A side-effect of this is that Internet Service Providers (ISPs) benefit from the scalability management as well, which improves their infrastructure capacities.

This reduction in requests reduces the load on the internet backbone, ([read Middle-Mile of the Internet](https://en.wikipedia.org/wiki/Middle_mile)). It also helps manage more of the internet load within the last mile of the internet. Thus, a CDN plays a multifaceted role in the Internet landscape as it allows web owners to improve the performance, reliability and scalability of content delivery.

### Caveats and disclaimers

As with any observational study, there are limits to the scope and impact that can be measured. The statistics gathered on CDN usage for the Web Almanac are focused more on applicable technologies in use and not intended to measure performance or effectiveness of a specific CDN vendor. While this ensures that we are not biased towards any CDN vendor, it also means that these are more generalized results.

These are the limits to our testing [methodology](./methodology):

- **Simulated network latency:** We use a dedicated network connection that synthetically shapes traffic.

- **Single geographic location:** Tests are run from a single datacenter and cannot test the geographic distribution of many CDN vendors.

- **Cache effectiveness:** Each CDN uses proprietary technology and many, for security reasons, do not expose cache performance.

- **Localization and internationalization:** Just like geographic distribution, the effects of language and geo-specific domains are also opaque to these tests.

- **CDN detection:** This is primarily done through DNS resolution and HTTP headers. Most CDNs use a DNS CNAME to map a user to an optimal datacenter. However, some CDNs use Anycast IPs or direct A+AAAA responses from a delegated domain which hide the DNS chain. In other cases, websites use multiple CDNs to balance between vendors, which is hidden from the single-request pass of our crawler.

All of this influences our measurements.

Most importantly, these results reflect the utilization of specific features (Example: TLS, HTTP/2 etc.,) per site, but do not reflect actual traffic usage. YouTube is more popular than "www.example.com" yet both will appear as equal value when comparing utilization.

With this in mind, here are a few statistics that were intentionally not measured in the context of a CDN:

1. Time To First Byte (TTFB)
2. CDN Round Trip Time
3. Core Web Vitals
4. Cache Hit versus Cache Miss performance etc.

While some of these could be measured with HTTP Archive dataset, and others by using the CrUX dataset, the limitations of our methodology and the use of multiple CDNs by some sites, will be difficult to measure and so could be incorrectly attributed. For these reasons, we have decided not to measure these statistics in this chapter.

## CDN adoption

A web page is composed of following key components:

1. Base HTML page (e.g., www.example.com)
2. Embedded first-party content such as images, css, fonts and javascript files on the main domain (www.example.com) and the subdomains and main  (e.g., images.example.com, css.example.com etc.)
3. Third-party content (e.g., Google Analytics, Advertisements etc.) served from third party domains



CDNs are utilized for delivering static content such as images, stylesheets, JavaScript, and fonts. This kind of content doesn’t change frequently, making it a good candidate for caching on a CDN’s proxy servers. CDNs provide better performance for delivering non static content as well as they often optimize the routes and use most efficient transport mechanisms.

Compared to the year 2021(Figure 2) we found that the usage of CDN has been steadily increasing. There was a large bump in CDN usage for the content served from sub-domains (Figure 1, increase of almost 10%). These are some of the potential reasons that can be attributed to his rise.


{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="CDN usage vs hosted resources.",
  description="Bar chart of CDN usage versus hosted resource split by origin and CDN. For HTML content, 70.5% of requests are from the origin and 29.5% from CDNs. For sub-domain content, 53.2% origin and 46.8% CDN. And for third-party content, 33.1% origin and 66.9% CDN.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=152072762&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}


{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="Trends for content served from CDN",
  description="This chart shows the trends for content served from CDN for last few years. The general trend is that the CDN usage is increasing. For the contents served from sub-domains we see bigger increase.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=2108054043&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}

The trend has been similar for both Mobile and Desktop applications (Figure 3, Figure 4), there is no discernible difference between Mobile and Desktop applications regarding CDN usage.

{{ figure_markup(
  image="cdn-usage-hosted-mobile.png",
  caption="CDN usage vs hosted resources.",
  description="Bar chart of CDN usage versus hosted resource split by origin and CDN for Mobile applications. For HTML content, 71% of requests are from the origin and 29% from CDNs. For sub-domain content, 53% origin and 47% CDN. And for third-party content, 33% origin and 67% CDN.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=97754567&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="CDN usage vs hosted resources.",
  description="Bar chart of CDN usage versus hosted resource split by origin and CDN. For HTML content, 69.6% of requests are from the origin and 30.4% from CDNs. For sub-domain content, 53.2% origin and 46.8% CDN. And for third-party content, 33% origin and 67% CDN.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1728563444&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}

While we observed CDN adoption across different types of content, we will look at this data from a different point of view below. Figure below (Figure 5 and Figure 6) show the adoption of CDNs by the sites based on their popularity.

{{ figure_markup(
  image="cdn-usage-ranking-desktop.png",
  caption="CDN usage by site popularity (desktop).",
  description="This bar chart provides a view of CDN usage for desktop sites broken up for top 1,000, 10,000, 100,000, 1 million and 10 million popular sites as per Google CRUX data. For Top 1000, 10,000 sites the CDN adoption is over 60%. The adoption shows decline for lower popularity sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=41276014&format=interactive",
  sheets_gid="1207165933",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

{{ figure_markup(
  image="cdn-usage-ranking-desktop.png",
  caption="CDN usage by site popularity (desktop).",
  description="This bar chart provides a view of CDN usage for mobile sites broken up for top 1,000, 10,000, 100,000, 1 million and 10 million popular sites as per Google CRUX data. For Top 1000, 10,000 sites the CDN adoption is over 60%. The adoption shows decline for lower popularity sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1175849008&format=interactive",
  sheets_gid="1207165933",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

Ranking the websites based on their popularity (sourced from Google’s Chrome UX Report) in the web and then checking for their CDN usage, the top 1,000-10000 contribute to the highest usage of CDN. For the high ranked sites, it is understandable that the owner companies are investing in CDN for performance and other benefits but even for the top 1,000,000 sites, there has been about a 7% increase in the amount of content delivered through CDNs compared to 2021. This increase in CDN usage for lower popularity sites can be attributed to the fact that there has been an increase in free and affordable options for CDNs and many hosting solutions have CDNs bundled with the services.


## Top CDN providers

CDN providers can be broadly classified into 2 segments:

1. Generic CDN (Akamai, Cloudflare, Cloudfront, Fastly etc.)
2. Purpose-built CDN (Netlify, WordPress etc.)

Generic CDN addresses the mass market requirements. Their offerings include:

* Web site delivery
* mobile app API delivery
* Video streaming
* Serverless compute offerings
* Web security offerings, etc.

This appeals to a larger set of industries and is reflected in the data. Generic CDNs hold the lion's share of the HTML and First party subdomain traffic:

{{ figure_markup(
  image="top-cdns.png",
  caption="Top CDNs for HTML requests.",
  description="Box plot showing the top CDN providers serving HTML requests. Cloudflare tops the list by serving 54% of the HTML requests followed by Google at 20%, Fastly at 8%, CloudFront at 7% and Akamai at 3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=191918239&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}

Figure 7 shows the top CDN providers for base HTML requests. The top vendors in this category are Cloudflare, Google, Fastly Amazon CloudFront and Akamai. 

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="Top CDNs for sub-domain requests.",
  description="Box plot showing the top CDN providers serving sub-domain requests. Cloudflare tops the list by serving 35% of the sub-domain requests followed by CloudFront at 20%, Google at 14%, Automattic at 7%, Akamai at 6% and Fastly at 3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1727439047&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}

For the sub-domain requests we can see the providers like Amazon and Google at the top. This is because many users have their content hosted in the cloud services they provide and the users utilize CDN offerings along with their cloud services. This helps the users to scale their applications and increase the performance of their application. 

Looking at third-party domains below, a different trend in top CDN providers is seen. We see Google top the list before the generic CDN providers. The list also brings Facebook into prominence. This is backed by the fact that a lot of third-party domain owners require CDNs more than other industries. This necessitates them to invest in building a purpose-built CDN. A purpose-built CDN is one which is optimized for a particular content delivery workflow.


{{ figure_markup(
  image="top-cdns-3p.png",
  caption="Top CDNs for third-party requests.",
  description="Box plot showing the top CDN providers serving third-party requests. Google tops the list by serving 47.0% of the third-party requests followed by Cloudlare at 15%, CloudFront at 12%, Facebook at 5% and Fastly at 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=2000521049&format=interactive",
  sheets_gid="548584500",
  sql_file="top_cdns.sql"
  )
}}

For example, a CDN built specifically to deliver advertisements will be optimized for:

- High input-output (I/O) operations
- Effective management of [long tail](https://en.wikipedia.org/wiki/Long_tail) content
- Geographical closeness to businesses requiring their services

This means purpose-built CDNs meet the exact requirements of a particular market segment as opposed to a generic CDN solution. Generic solutions can meet a broader set of requirements but are not optimized for any particular industry or market.

## TLS adoption impact

With CDNs set up in the request-response workflows, the end-user's TLS connection terminates at the CDN. In turn, the CDN sets up a second independent TLS connection and this connection goes from the CDN to the origin host. This break in the CDN workflow allows the CDN to define the end-user's TLS parameters. CDNs tend to also provide automatic updates to internet protocols. This allows web owners to receive these benefits without making changes to their origin.

The charts below show that the adoption of the latest version of TLS has been much higher for the content served from CDN compared to origin

{{ figure_markup(
  image="tls-version-desktop.png",
  caption="Distribution of TLS version for HTML (desktop).",
  description="Bar chart of TLS version usage in desktop requests served by CDN and origin. CDN's have served 85% of the requests using TLS 1.3 and 15% of the requests in TLS 1.2. Origin on the other served 38% of the requests over TLS 1.3 and 62% of the requests on TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1274487634&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

Compared to the year 2021, for desktop HTML content the adoption of TLS v1.3 has increased by 2% while for the content served from origin the TLS v1.3 adoption has increased by 10%

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="Distribution of TLS version for HTML (mobile).",
  description="Bar chart of TLS version usage in mobile requests served by CDN and origin. CDN's have served 87% of the requests using TLS 1.3 and 13% of the requests in TLS 1.2. Origin on the other served 42% of the requests over TLS 1.3 and 58% of the requests on TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=586006642&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

Compared to the year 2021, for mobile HTML content the adoption of TLS v1.3 has increased by 5% while for the content served from origin the TLS v1.3 adoption has increased by 10%.

{{ figure_markup(
  image="tls-version-desktop-3p.png",
  caption="Distribution of TLS version for third-party requests (desktop).",
  description="Bar chart of TLS version usage in third-party requests on desktop, served by CDN and origin. CDN's have served 88% of the third-party requests using TLS 1.3 and 12% of the requests in TLS 1.2. Origin on the other served 26% of the requests over TLS 1.3 and 74% of the requests on TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=2003064403&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="Distribution of TLS version for third-party requests (mobile).",
  description="Bar chart of TLS version usage in third-party requests on desktop, served by CDN and origin. CDN's have served 88% of the third-party requests using TLS 1.3 and 12% of the requests in TLS 1.2. Origin on the other served 26% of the requests over TLS 1.3 and 74% of the requests on TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1995157146&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

Compared to 2021 we can see that the higher percentage of sites are serving third party content from origin on TLS 1.1. This can be attributed to the fact that this year the data sample size is 10 times bigger than the last year, we are seeing the bigger picture.

In the current security landscape it is important for the content to be delivered via the latest TLS version. It can be seen from the data above that the move to TLS v1.3 was much faster for CDNs compared to the origin. This shows the added security benefit of using CDNs for content delivery.

## TLS performance impact

Common logic dictates that the fewer hops it takes for a HTTPS request-response to traverse, the faster the round trip would be. So exactly how much quicker can it be if the TLS connection terminates closer to the end user? The answer: As much as 3 times faster!

{{ figure_markup(
  image="tls-negotiation.png",
  caption="HTML TLS negotiation - CDN vs origin.",
  description="This bar chart provides insight into TLS connection time (in milliseconds) across 10th, 25th, 50th, 75th and 90th percentile for CDN and origin. As it can be seen from the chart the TLS negotiation time is generally faster for CDNs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1577806460&format=interactive",
  sheets_gid="1644442668",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

CDNs have helped slash the TLS connection times. This is due to their proximity to the end user and adoption of newer TLS protocols that optimize the TLS negotiation. CDNs hold the edge over origin at all percentiles here. At P10 and P25, CDNs are nearly 1.5x faster than origin in TLS set up time. The gap increases even more once we hit the median and above, where CDNs are nearly 2x faster. 90th percentile users using a CDN will have better performance than 50th percentile users on direct origin connections.

This is quite important when you consider that all sites will have to be on TLS these days. Optimal performance at this layer is essential for other steps that follow TLS connection. In this regard, CDNs are able to move more users to lower percentile brackets compared to direct origin connections.

## HTTP/2+ (HTTP/2 or better) adoption

HTTP/2 was introduced with a lot of hype and expectation. This was because the application layer protocol had not been updated since HTTP 1.1 in 1997. Since then, the web traffic trend, content-type, content size, website design, platforms, mobile apps and more have evolved significantly. Thus, there was a need to have a protocol which can meet the requirements of the modern-day web traffic and that protocol was realized with HTTP/2, and then further improved with the more recent HTTP/3.

However, the implementation challenges of HTTP/2 discouraged adoption. In addition, the net performance gains which can be expected with these changes was also not clear. Challenges repeated with the introduction of HTTP/3.

This was where the CDNs being the intermediary can help in bridging the challenge of HTTP/2 implementation for web owners. An HTTP/2 connection terminates at the CDN level, and this provides web owners the ability to deliver their website and subdomains over HTTP/2 without the need to upgrade their infrastructure to support it—the exact same reasons and benefits we saw for newer TLS versions.

CDNs act as the proxy to bridge the gap by providing a layer to consolidate hostnames and route traffic to relevant endpoints with minimal change to their hosting infrastructure. Features like prioritizing content in the queue and server push can be managed from the CDN's side and a few CDN's even provide hands-off automated solutions to run these features without any inputs from website owners, thus providing a boost to HTTP/2 adoption.

The trend cannot be clearer than what the graph shows below. There is high HTTP/2+ adoption by domains on CDNs compared to the ones not using a CDN.

<p class="note">Note that due to the way HTTP/3 works (see the [HTTP](./http) chapter for more information), HTTP/3 is often not used for first connections which is why we are instead measuring "HTTP/2+", since many of those HTTP/2 connections may actually be HTTP/3 for repeat visitors (we have assumed that no servers implement HTTP/3 without HTTP/3).</p>

{{ figure_markup(
  image="http-versions-desktop.png",
  caption="Distribution of HTTP versions for HTML (desktop).",
  description="This bar chart shows the HTTP version adoption across CDN and origin in desktop HTML requests. For desktop HTML requests served from CDN, 86.1% were served on HTTP/2 or better protocol while requests served from origin had 39.2% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=707070598&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="http-versions-mobile.png",
  caption="Distribution of HTTP versions for HTML (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin in mobile HTML requests. For mobile HTML requests served from CDN, 81.7% were served on HTTP/2 or better protocol while requests served from origin had 39.8% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=825211868&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

Back in 2019, the origin domains had 27% adoption of HTTP/2 compared to 71% adoption on CDN. While we see in desktop sites that there is about a 14% increase in origins supporting HTTP/2+ in 2021, domains on CDNs have maintained that lead with a 15% increase. This gap is a bit less when we look at mobile sites, where domains using a CDN have a slightly lower HTTP/2+ adoption compared to desktop sites.

{{ figure_markup(
  image="http-versions-desktop-3p.png",
  caption="Distribution of HTTP versions for third-party requests (desktop).",
  description="This bar chart shows the HTTP version adoption across CDN and origin for third-party requests on desktop. For these third-party requests served from CDN, 90.0% were served on HTTP/2 or better protocol while requests served from origin had 48.5% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=315993105&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="http-versions-mobile-3p.png",
  caption="Distribution of HTTP versions for third-party requests (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin for third-party requests on mobile. For these third-party requests served from CDN, 90.4% were served on HTTP/2 or better protocol while requests served from origin had 43.7% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=351977017&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

Looking at third-party domains supporting newer protocols, we see an interesting trend of higher adoption of HTTP/2+protocols compared to first-party domains. This makes sense, considering the fact that most of the top third-party domains use purpose-built CDNs and thus have more control on the content development and content delivery. Additionally, third-party domains need to have consistent performance across all network conditions, and this is where HTTP/2+ adds value by mixing in other protocols like UDP (used by HTTP/3) along with traditional TCP connections.

Back in 2019, Uber did an experiment to understand how UDP along with TCP (aka QUIC, the transport layer of HTTP/3) can help deliver content with consistent performance and overcome packet loss in highly congested mobile networks. The results of this experiment documented in <a hreflang="en" href="https://eng.uber.com/employing-quic-protocol/">this blog post</a> throws valuable insights into the demographic where HTTP/3 can help. Over time, this trend will trickle down and we should see web owners adopting HTTP/3, especially with mobile network traffic having a higher contribution to the total internet traffic.

## Brotli adoption

Content delivered over the internet employs compression to reduce the payload size. A smaller payload means it's faster to deliver the content from server to end user. This makes websites load faster and provide a better end-user experience. For images, this compression is handled by image file formats like JPEG, WEBP, AVIF, etc. (refer to the [Media](./media) chapter for more on this). For textual web assets (such as HTML, JavaScript, and stylesheets) compression was traditionally handled by a file format called [_Gzip_](https://en.wikipedia.org/wiki/Gzip). Gzip has been in existence since 1992. It did a good job of making text asset payloads smaller, but a new text asset compression can do better than Gzip: [_Brotli_](https://en.wikipedia.org/wiki/Brotli) (refer to the [Compression](./compression) chapter for more information).

Similar to TLS and HTTP/2 adoption, Brotli went through a phase of gradual adoption across web platforms. At the time of this writing, Brotli is <a hreflang="en" href="https://caniuse.com/brotli">supported by 96%</a> of the web browsers globally. However, not all websites compress text assets in Brotli format. This is because of both lack of support and of the longer time required to compress a text asset in Brotli format compared to Gzip compression. Also, the hosting infrastructure needs to have backward compatibility to serve Gzip compressed assets for older platforms which do not support the Brotli format, which can add complexity.

The impact of this is observed when we compare websites which are using CDN against the ones not using CDN.

{{ figure_markup(
  image="compression-desktop.png",
  caption="Distribution of compression types (desktop).",
  description="This bar chart shows the Brotli adoption across CDN and origin on desktop requests. CDN's served 42.5% of requests in Brotli compressed format and 57.5% of requests in gzip compressed format. Origin on the other hand served 20.7% of requests in Brotli compressed format and 79.3% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=914242768&format=interactive",
  sheets_gid="1196940164",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="compression-mobile.png",
  caption="Distribution of compression types (mobile).",
  description="This bar chart shows the Brotli adoption across CDN and origin on mobile requests. CDN's served 42.6% of requests in Brotli compressed format and 57.3% of requests in gzip compressed format. Origin on the other hand served 21.2% of requests in Brotli compressed format and 78.7% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1852382089&format=interactive",
  sheets_gid="1196940164",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

On both desktop and mobile platforms, we see that CDNs are delivering twice as many text assets in Brotli, compared to domains delivered from origin. From the [CDN adoption](#cdn-adoption) section covered earlier, 73% of the domains serving sites are on CDNs and these can all benefit from the Brotli compression. By offloading the computational load of compressing a text asset in the Brotli format to CDNs, website owners need not invest resources for hosting infrastructure.

However, it is at the web property owner's discretion whether to use Brotli compression on their CDNs or not. Compared to 95% of the web browsers globally which support Brotli compression, even with CDNs in place, less than half of all the text assets are delivered in Brotli format—so there is clearly space for this adoption to improve.

## Conclusion

There are limitations to the insights we can deduce about CDNs from the outside, since it is hard to know the secret sauce powering them behind the scenes. However, we have crawled the domains and compared the ones on CDNs against those who are not. We can see that CDNs have been an enabler for websites to adopt new web protocols, from the network layer to the application layer.

This impact is universal, with similar adoption rates across mobile and desktop: from using the latest TLS versions to upgrading to the newest HTTP versions (like HTTP/2, HTTP/3) to using the Brotli compression. What stands out is the depth of this impact and the sizable lead the CDN domains have built relative to non-CDN domains.

This role of CDNs is highly valuable and this will continue to be the case. CDN providers are also a key part of the <a hreflang="en" href="https://www.ietf.org/">Internet Engineering Task Force</a>, where they help shape the future of the internet. They will continue to play a key role aiding the internet-enabled industries to operate smoothly, reliably and quickly.
