---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: CDN chapter of the 2021 Web Almanac covering adoption of CDNs, top CDN players, the impact of CDNs on TLS, HTTP/2+, and Brotli adoption
authors: [harendra, joeviggiano]
reviewers: [ytkoka]
analysts: [harendra, joeviggiano]
editors: [harendra, joeviggiano]
translators: []
results: https://docs.google.com/spreadsheets/d/1ySETT2IZ9ae5_VUphxUol2ZU3P1RJvcSVjDU5BgnK5A/edit#gid=542001559
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

This chapter provides important insights regarding the current state of CDN usage. CDNs are playing an increasingly important role in delivering content to users around the globe, even for smaller sites by facilitating the delivery of static and third party content such as Javascript libraries, Fonts and other content. Another key aspect of the CDNs that we will discuss in this chapter is the role CDNs play in adoption of new standards such as TLS versions and HTTP versions.

We have looked at the usage of CDNs over the past few years gaining very useful insights. 
This year we have expanded our dataset to include the current top 10 million sites to provide a much bigger picture regarding CDN usage. 

We think that CDNs will play a vital role in the future not just for content delivery but for content security as well. 
We recommend that users look at CDNs from both a performance and a security viewpoint. 


## What is a CDN?

A _Content Delivery Network_ (CDN) is a geographically distributed network of proxy servers in data-centers. The goal of a CDN is to provide high availability and performance for web content. It does this by distributing content closer to the end users. 

Due to the explosion of web content such as videos and images, CDN has been a vital part of many web applications to provide a  smooth user experience. Post COVID-19, the need for CDN has only increased due to many brick and mortar businesses moving online, increase in web conferences, online gaming and video streaming.

During the early days, a CDN was a simple network of proxy servers which would:

1. Cache content (like HTML, images, stylesheets, JavaScript, videos, etc.)
2. Reduce network hops for end users to access content
3. Offload TCP connection termination away from the data centers hosting the web properties

They primarily helped web owners to improve the page load times and to offload traffic from the infrastructure hosting these web properties.

Over time, the services offered by CDN providers have evolved beyond caching and offloading bandwidth/connections. Due to its distributed nature and large distrubuted network capacity CDNs have proved to be extremely efficient at handling large scale DDoS attacks. Edge computing is another service that has gained popularity in the recent years. Many CDN vendors provide compute services at the edge that allows the web owners to run simple code at the Edge.
Other services offered by the CDN vendors include the following.

* Cloud-hosted Web Application Firewalls
* Bot Management solutions
* Clean pipe solutions (Scrubbing Data-centers)
* Serverless Computing offerings
* Image and Video Management solutions etc.,
* Edge computing Services

There are benefits to web owners in pushing web application logic and workflows closer to the end user. This eliminates the round trip and bandwidth that a HTTP/HTTPS request would take. It also handles near-instant scalability requirements for the origin. A side-effect of this is that Internet Service Providers (ISPs) benefit from the scalability management as well, which improves their infrastructure capacities.


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

Compared to the year 2021([2021 chapter](../2021/cdn)) we found that the usage of CDN has been steadily increasing. There was a large bump in CDN usage for the content served from sub-domains. These are some of the potential reasons that can be attributed to this rise.

* Post pandemic, many businesses took a large portion of their physical business online. This put a lot of strain on their servers and found that it was much more efficient to server the static content through CDNs for offloading through caching and faster delivery.
* This increase was not seen in 2021([2021 chapter](../2021/cdn)) as many businesses were still trying to figure out the optimal solution for their problem.

* Sites relied on serving third party content through third party domains instead of their own domains. The fact that the amount of content served from third party domains increased by 3% during this period supports this assumption.

Regarding the base HTML page the traditional pattern has been to serve the base HTML from the origin and this pattern has continued as majority of base pages continue to be served from the origin. However, there has been a 4% increase in the base pages being served from CDNs. The trend of base HTML pages being served from the CDN is on the rise. 
These can be the reason behind the rise
* CDNs can improve load time of  the base HTML page that can be of high importance to improve the customer experience and keep the user engaged.
* It is simpler and faster to load the base page from CDN using the DNS provided by CDN providers.
* It is easier to plan BCP and Disaster Recovery if most of the content including the base HTML page is pushed through CDNs. CDNs often provide a failover functionality to automatically switch to the alternative site once the primary site becomes unstable or unavailable.


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

The trend has been similar for both Mobile and Desktop applications as shown below, there is no discernible difference between Mobile and Desktop applications regarding CDN usage.

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

While we observed CDN adoption across different types of content, we will look at this data from a different point of view below. Figure below show the adoption of CDNs by the sites based on their popularity.

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

The HTTP/2 specification was first introduced in 2015 and saw broad support with most major browsers adopting before the end of the year. The HTTP application layer protocol had not been updated since HTTP 1.1 in 1997 and since then the web traffic trend, content-type, content size, website design, platforms, mobile apps and more have evolved significantly. Thus, there was a need to have a protocol which can meet the requirements of the modern-day web traffic and that protocol was realized with HTTP/2.

Despite the hype of HTTP/2 and the promise of reduced latency and other functionality, adoption relied on server side updates to support the newer application protocol. During this time and for future protocol improvements like HTTP/3, as being an intermediary CDNs can help bridge the challenge of newer implementations for web owners. An HTTP/2 connection terminates at the CDN level, and this provides web owners the ability to deliver their website and subdomains over HTTP/2 without the need to upgrade their infrastructure to support it. Similar benefits were also seen with the adoption of newer TLS versions.

CDNs act as the proxy to bridge the gap by providing a layer to consolidate hostnames and route traffic to relevant endpoints with minimal change to their hosting infrastructure. Features like prioritizing content in the queue and server push can be managed from the CDN's side and a few CDN's even provide hands-off automated solutions to run these features without any inputs from website owners, thus providing a boost to HTTP/2 adoption.

There are stark contrasts in the graphs below with high HTTP/2+ adoption by domains on CDNs compared to the ones not using a CDN.

<p class="note">Note that due to the way HTTP/3 works (see the [HTTP](./http) chapter for more information), HTTP/3 is often not used for first connections which is why we are instead measuring "HTTP/2+", since many of those HTTP/2 connections may actually be HTTP/3 for repeat visitors (we have assumed that no servers implement HTTP/3 without HTTP/3).</p>

{{ figure_markup(
  image="cdn-http-versions-desktop.png",
  caption="Distribution of HTTP versions for HTML (desktop).",
  description="This bar chart shows the HTTP version adoption across CDN and origin in desktop HTML requests. For desktop HTML requests served from CDN, 88% were served on HTTP/2 or better protocol while requests served from origin had 42% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1691162627&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="Distribution of HTTP versions for HTML (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin in mobile HTML requests. For mobile HTML requests served from CDN, 84% were served on HTTP/2 or better protocol while requests served from origin had 43% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1385171364&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

In 2021 39.8% of the content served from origin had HTTP/2 adopted while during the same time 81.7% of the content served from CDNs were served through HTTP/2. For origin this number has grown by 3% points while for the CDN it has grown by 6% points. This shows how CDN was able to allow the web application owners to take advantage of HTTP/2 from very early stage whithout making any changes in the origin.
The trends are very similar for both desktop and mobile sites.

{{ figure_markup(
  image="cdn-http-versions-desktop-3p.png",
  caption="Distribution of HTTP versions for third-party requests (desktop).",
  description="This bar chart shows the HTTP version adoption across CDN and origin for third-party requests on desktop. For these third-party requests served from CDN, 87.0% were served on HTTP/2 or better protocol while requests served from origin had 50% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1387277164&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="Distribution of HTTP versions for third-party requests (mobile).",
  description="This bar chart shows the HTTP version adoption across CDN and origin for third-party requests on mobile. For these third-party requests served from CDN, 88% were served on HTTP/2 or better protocol while requests served from origin had 50% requests served on HTTP/2 or better protocol.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=983285021&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

Third-party domains have been quick to support new protocols as we saw in our previous study. In 2022 we saw decline in the share of HTTP/2 protocol by a small percentage point for the third party domains. We also saw an uptick in other protocols (HTTP/3) share. This can be attributed to the fact that the third-party domains have been quick to adopt newer protocol for more effecient delivery.

Compared to the year 2021 we saw decline in the share of HTTP/2 protocol by a small percentage point for the third party domains. We also saw an uptick in other protocols (HTTP/3) share. This can be attributed to the fact that the third-party domains have been quick to adopt newer protocol for more effecient delivery
Third-party domains need to have consistent performance across all network conditions, and this is where HTTP/2+ adds value by mixing in other protocols like UDP (used by HTTP/3) along with traditional TCP connections.

In June of 2022 the Internet Engineering Task Force (IETF) published the ([HTTP/3 RFC] (https://www.theregister.com/2022/06/07/http3_rfc_9114_published/)) to take the web from TCP to UDP. Many CDN providers have been quick to adopt HTTP/3 support, some before its formal RFC publication, and over time we should see web owners adopting HTTP/3, especially with mobile network traffic having a higher contribution to the total internet traffic. Stay tuned for more insights in 2023.


## Brotli adoption

Content delivered over the internet employs compression to reduce the payload size. A smaller payload means it's faster to deliver the content from server to end user. This makes websites load faster and provide a better end-user experience. For images, this compression is handled by image file formats like JPEG, WEBP, AVIF, etc. (refer to the [Media](./media) chapter for more on this). For textual web assets (such as HTML, JavaScript, and stylesheets) compression was traditionally handled by a file format called [_Gzip_](https://en.wikipedia.org/wiki/Gzip). Gzip has been in existence since 1992. It did a good job of making text asset payloads smaller, but a new text asset compression can do better than Gzip: [_Brotli_](https://en.wikipedia.org/wiki/Brotli) (refer to the [Compression](./compression) chapter for more information).

Similar to TLS and HTTP/2 adoption, Brotli went through a phase of gradual adoption across web platforms. At the time of this writing, Brotli is <a hreflang="en" href="https://caniuse.com/brotli">supported by 96%</a> of the web browsers globally. However, not all websites compress text assets in Brotli format. This is because of both lack of support and of the longer time required to compress a text asset in Brotli format compared to Gzip compression. Also, the hosting infrastructure needs to have backward compatibility to serve Gzip compressed assets for older platforms which do not support the Brotli format, which can add complexity.

The impact of this is observed when we compare websites which are using CDN against the ones not using CDN.

{{ figure_markup(
  image="cdn-compression-desktop.png",
  caption="Distribution of compression types (desktop).",
  description="This bar chart shows the Brotli adoption across CDN and origin on desktop requests. CDN's served 46% of requests in Brotli compressed format and 54% of requests in gzip compressed format. Origin on the other hand served 23% of requests in Brotli compressed format and 77% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=229562009&format=interactive",
  sheets_gid="2043216080",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="Distribution of compression types (mobile).",
  description="This bar chart shows the Brotli adoption across CDN and origin on mobile requests. CDN's served 47% of requests in Brotli compressed format and 57.3% of requests in gzip compressed format. Origin on the other hand served 25% of requests in Brotli compressed format and 77% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1836100530&format=interactive",
  sheets_gid="2043216080",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

Both CDN and Origin have shown an increase in adoption of Brotli compared to the year 2021 [CDN 2021 ](../2021/cdn).
We have seen the adoption of Brotli on CDN grow by 5% points while the Origin grew by 3% points. We will be able to see if this trend will continue in year 2023 or we have reached the saturation point.

## Client Hint Adoption

Client hints allows a web server to proactively request data from the client and are sent as part of the HTTP headers. The client may provide information such as device, user, user-agent preferences and networking. Based on the provided information, the server can determine the most optimal resources to respond with to the requesting client. Client hints was first introduced on the Google Chrome browsers and while other Chromium based browsers have adopted it, other popular browsers have limited or no support for client hints.

The CDN, origin servers and client browser must all support client hints to be utilized properly. As part of the flow, the CDN can present the Accept-CH HTTP header to the client in order to request which client hints a client should include in subsequent requests. We measured clients responses where the CDN provided this header inside the request and measured it across all CDN requests recorded as part of our testing.

For both desktop and mobile clients we saw less than 1% usage of client hints, showing that client hints adoption has a ways to go.

{{ figure_markup(
  image="cdn-client-hints-desktop.png",
  caption="Client Hints Comparison (Desktop).",
  description="This bar chart shows the usage of Client Hints in CDNs. Currently only 0.74% of the requests have client hints",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1855462743&format=interactive",
  sheets_gid="2048261739",
  sql_file="clienthints_response_counts_by_client.sql"
  )
}}

{{ figure_markup(
  image="cdn-client-hints-mobile.png",
  caption="Client Hints ComparisonClient Hints Comparison (mobile).",
  description="This bar chart shows the usage of Client Hints in CDNs. Currently only 0.43% of the requests have client hints",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1567266649&format=interactive",
  sheets_gid="2043216080",
  sql_file="clienthints_response_counts_by_client.sql"
  )
}}


## Image Format Adoption

CDN’s have traditionally been used to cache, compress and deliver static content such as images since their inception. Since then many CDN’s have added the ability to dynamically change images in both format and sizing on the fly to optimize the image for different use cases. This is often performed by sending additional parameters in the query string whereby compute at the edge will interpret and modify the image in the response accordingly.

Across both desktop and mobile the dominant image formats were JPG (JPEG) and PNG. JPG provides a lossly compressed file format optimizing for size. PNG or Portable Graphics Format supports lossless compression meaning no data will be lost when the image is compressed, however the image overall is larger in size than a JPG. For more information on  JPG vs PNG visit [Adobe’s website] (https://www.adobe.com/creativecloud/file-types/image/comparison/jpeg-vs-png.html).

{{ figure_markup(
  image="cdn-image-formats-desktop.png",
  caption="Distribution of Image Formats (Desktop).",
  description="This chart shows the usate of different Image Formats served from CDNs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=963068854&format=interactive",
  sheets_gid="571877353",
  sql_file="image_format_counts_by_client.sql"
  )
}}

{{ figure_markup(
  image="cdn-image-formats-mobile.png",
  caption="Distribution of Image Formats (mobile).",
  description="This bar chart shows the Brotli adoption across CDN and origin on mobile requests. CDN's served 42.6% of requests in Brotli compressed format and 57.3% of requests in gzip compressed format. Origin on the other hand served 21.2% of requests in Brotli compressed format and 78.7% of requests in gzip compressed format.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=293872923&format=interactive",
  sheets_gid="571877353",
  sql_file="image_format_counts_by_client.sql"
  )
}}




## Conclusion

From our continued study in the past years we can see tha the CDNs have not only been vital to the web application owners in order to reliably deliver content from origin to any user across the globe, they have also played a major role in new Security and Web standard adoption.

In general we have seen the rise in the usage of CDNs across the board. This year we significantly increased our sample size to cover most of the use cases out there and the results have been very consistent. We saw that the CDN greatly facilitated the adoption new web security standards such as TLS 1.3 where we saw much higher percentage of traffic using TLS 1.3 came from CDN.

When it comes to the adoption of new web standards and new web technologies such as HTTP/2, Brotli compression we again saw CDNs leading the way. Much higher percentage of the web application served out of CDN saw these new standards being adopted.
From the end user perspective this is very positive development as they will be able use the application securely while getting the optimal user experience.

We are also looking at new metrics like Client Hints and Image Format adoption starting this year. We will be able to get more insights as we collect more data for the next year.

There are limitations to the insights we can deduce about CDNs from the outside, since it is hard to know the secret sauce powering them behind the scenes. However, we have crawled the domains and compared the ones on CDNs against those who are not. We can see that CDNs have been an enabler for websites to adopt new web protocols, from the network layer to the application layer.

This role of CDNs is highly valuable and this will continue to be the case. CDN providers are also a key part of the <a hreflang="en" href="https://www.ietf.org/">Internet Engineering Task Force</a>, where they help shape the future of the internet. They will continue to play a key role aiding the internet-enabled industries to operate smoothly, reliably and quickly.

We look forward to the next year to collect more data and provide useful insights to our readers.
