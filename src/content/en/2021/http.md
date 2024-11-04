---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: The HTTP chapter of the 2021 Web Almanac covers data on historical versions of HTTP used across the web, as well as the uptick in new versions including HTTP/2 and HTTP/3, while also inspecting key metrics a part of the HTTP lifecycle.
authors: [dominiclovell]
reviewers: [tunetheweb, rmarx]
analysts: [tunetheweb]
editors: [shantsis]
translators: []
results: https://docs.google.com/spreadsheets/d/1pCdpndXTXexSIZLmVc-aUbp5PcHhZ83hbEEfmDyfD0U/
dominiclovell_bio: Dominic Lovell is currently a Solutions Engineering Manager at Akamai Technologies, and has been working for a number of years to make sites more performant and safer across the web. You can find him tweeting [@dominiclovell](https://x.com/dominiclovell), or you can connect with him on <a hreflang="en" href="https://www.linkedin.com/in/dominiclovell/">LinkedIn</a>.
featured_quote: Over 70% of requests are served over HTTP/2 or above, which suggests that HTTP/2 and HTTP/3 are well and truly the dominant protocol versions for the web.
featured_stat_1: 25%
featured_stat_label_1: Decline in HTTP/1.1 requests between 2020 and 2021
featured_stat_2: 82%
featured_stat_label_2: Top 1,000 sites that have HTTP/2 enabled
featured_stat_3: 1.25%
featured_stat_label_3:  Sites using HTTP/2 push
---

## Introduction

The HTTP protocol is one of key parts of the web. HTTP itself was unchanged for nearly two decades after HTTP/1.1 was introduced in 1997. It wasn't until 2015 with the introduction of HTTP/2, that saw a major design change to the way HTTP was implemented. HTTP/2 was designed to introduce changes primarily at the transport level of the protocol. These protocol changes, while significant in how they worked, still allowed for backward compatibility between versions.

This year we again take a closer look at HTTP/2, discussing some of its major features. We then look at some of the benefits of HTTP/2, and why it has been adopted heavily across the web performance community. While HTTP/2 aimed at solving many problems with HTTP, including connection limits, better header compression, and binary support which allowed for better payload encapsulation, not all features put forward were successful in their design.

After several years of HTTP/2 in the wild, some of the intentions of HTTP/2 are still to be realized. For example, last year we put forward the question of whether we say goodbye to HTTP/2 push. This year we aim to answer this question with more confidence by looking at the 2021 data. As these shortcomings came to light, they have been addressed or omitted from the next iteration of HTTP: HTTP/3.

Increased support for HTTP/3 over the past year has allowed for introspection on HTTP/3's adoption on the web. This chapter takes a closer look at some of the core features of HTTP/3 and the benefits of each of these. We also examine the major vendors who are supporting HTTP/3 evolution, as well as some of the ongoing critiques of HTTP/3.

Some of the data points the Web Almanac aims to answer across the HTTP chapter include the adoption across HTTP versions, support from the key software vendors and CDN companies, and how this distribution between first and third parties influences adoption. We also take a look at usage across the top ranked sites across the web, including metrics on HTTP attributes such as connections, server push and response data size.

These data points provide a snapshot for 2021 on the HTTP usage across the web and how the protocol is evolving across its major versions. They then provide insight into the adoption of major features in the coming years.

### Evolution of HTTP

It's been six years since the <a hreflang="en" href="https://www.ietf.org/">Internet Engineering Task Force (IETF)</a> introduced us to <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7540">HTTP/2</a>, and it's worth understanding how we got to HTTP/2 in the first place. Thirty years ago (in 1991) we were first introduced to HTTP 0.9. HTTP has come a long way since 0.9, which was limited in capabilities. 0.9 was used for one-line protocol transfers, which only supported the GET method, and had no support for headers nor status codes. Responses were only provided in hypertext. Five years later, this was enhanced with HTTP/1.0. The 1.0 version contains most of the protocol we know now, including response headers, status codes, and the `GET`, `HEAD` and `POST` methods.

A problem not addressed in 1.0 was that the connection was terminated immediately after the response was received. This meant each request was required to open a new connection, perform TCP handshakes, and close the connection after the data was received. This major inefficiency saw HTTP/1.1 introduced only a year later in 1997, which allowed for persistent connections to be made, which can be reused once opened. This version served its purpose for 18 years, without any changes introduced until 2015. During this time Google experimented with <a hreflang="en" href="https://en.wikipedia.org/wiki/SPDY">SPDY</a>—a complete reimagining of how HTTP messages were sent. This was eventually formalized into HTTP/2.

HTTP/2 aimed to address many of the problems web developers were facing when trying to achieve increased performance. Complicated processes such as domain sharding, asset spriting, and concatenating files were necessary to work around inefficiencies in HTTP/1.1. By introducing resource multiplexing, prioritization, and header compression, HTTP/2 was designed to provide network optimization at the protocol level. As well as addressing the known performance problems, HTTP/2 introduced new potential performance optimizations with features such as _HTTP/2 push_, where the server could preemptively send content to the client before the client would be aware of the asset.

## Adoption of HTTP/2

{{ figure_markup(
  image="http-versions-main-page.png",
  caption="HTTP versions used by page load.",
  description="Bar chart showing HTTP versions used by page load. 59.5% of desktop sites use HTTP/2+, and 59.4% of mobile sites. 39.6% and 39.8% respectively use HTTP/1.1",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=164555214&format=interactive",
  sheets_gid="1870188510",
  sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql"
  )
}}

In the thirty years since HTTP version 0.9, there has been a shift in the protocol's adoption. With over 6 million web pages analyzed, the HTTP Archive found only a single instance of HTTP 0.9 being used for the initial page request, only a couple of thousand pages still using 1.0. Almost 40% of pages were still using version 1.1 however, with the remaining 60% using HTTP/2 or above. HTTP/2 adoption is thus up 10% since the same analysis was performed in 2020.

<p class="note">Note: Due to the way HTTP/3 works, as we will discuss below, and how our crawl works with a fresh instance each time, HTTP/3 is unlikely to be used for the initial page request, or even subsequent requests. Therefore, we report some statistics in this chapter as "HTTP/2+" to indicate HTTP/2 or HTTP/3 might be used in the real world. We will investigate how much HTTP/3 is actually supported (even if not used in our crawl) later in the chapter.</p>

### Adoption by request

The initial page request is supplemented by many other requests, often served by third parties, which may have different, often better, protocol support. Due to this we have seen in the past years that when looking at request level, rather than just for the initial page, usage is much higher, and this is again the case this year.

{{ figure_markup(
  image="http-version-requests.png",
  caption="HTTP versions used by requests.",
  description="Bar chart showing HTTP versions used by requests. 73.2% of mobile requests are now via HTTP/2, whereas 26.5% are still using HTTP/1.1, with 0.3% on Unkown and both HTTP/0.9 and HTTP/1.0 so small they are charted as 0.0%. Desktop usage looks the same.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=2104913686&format=interactive",
  sheets_gid="2077755325",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
  )
}}

In 2021, the HTTP Archive data suggests that HTTP/0.9 and HTTP/1.0 are all but virtually dead. While 0.9 did have hundreds of requests present, this becomes rounded down to zero when aggregated across the entire dataset. HTTP/1.0 has thousands of requests, but it too only represents 0.02% of the total amount.

{{ figure_markup(
  caption="Decline in HTTP/1.1 requests in last year.",
  content="25%",
  classes="big-number",
  sheets_gid="2077755325",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

Interestingly, over a quarter of requests are still served via HTTP/1.1. When compared with 2020, this represents a 25% decline, as 2020 had 50% of requests still leveraging 1.1 across both mobile and desktop. Over 70% of requests are served over HTTP/2 or above, which suggests that HTTP/2 and HTTP/3 are well and truly the dominant protocol versions for the web.

Looking at the protocol used by page, we can again plot the dominance of HTTP/2 and above:

{{ figure_markup(
  image="http2-and-above-resources-by-percentile.png",
  caption="Usage HTTP/2+ resources by percentile.",
  description="Line chart showing usage of HTTP/2+ resources by percentile. Beyond the 75th percentile 100% of sites use HTTP/2+ for all their resources",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1207400014&format=interactive",
  sheets_gid="871426393",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

Beyond the 50th percentile of pages, pages have 92% or more of their resources being served over HTTP/2+. And for beyond the 70th percentile 100% of sites resources are loaded over HTTP/2 or better. Put another way, 30% of sites use no HTTP/1.1 resources at all.

### Adoption by third parties

{{ figure_markup(
  image="http2-and-above-third-party-resources-by-percentile.png",
  caption="Usage HTTP/2+ for third-party resources.",
  description="Bar chart showing usage of HTTP/2+ for third-party resources. Beyond the 40th percentile, 100% of resources are using HTTP/2+",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1806404234&format=interactive",
  sheets_gid="1768565957",
  sql_file="http2_1st_party_vs_3rd_party.sql"
  )
}}

HTTP/2 adoption by third-party content is so heavily skewed, that beyond the 40th percentile of third-party requests, 100% of traffic is being served by HTTP/2. In fact, even at the tenth percentile, over 66% of requests are leveraging HTTP/2. This suggests the majority of adoption is still being influenced by [third-party content](./third-party), and content being served by domains leveraging a [CDN](./cdn).

### Adoption by servers

According to <a hreflang="en" href="https://caniuse.com/http2">caniuse.com</a>, 97% of browsers support HTTP/2 globally. HTTPS is required by browsers for HTTP/2 support, which may have been a blocker in the past. However, <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">93% of sites on desktop and 91% on mobile</a> all support HTTPS. This is up 5% from last year in 2020 and was up 6% in the year prior between 2019 and 2020. Implementation of HTTPS is no longer a blocker.

It's important to understand that with such a high adoption across browsers, and high HTTPS adoption, the limiting factor in even greater adoption of HTTP/2 is still largely dictated by the server implementation. Despite the rapid increase in HTTP/2 usage, when you split it out by web server, the adoption figures show a much more fragmented story.

{{ figure_markup(
  image="server-http2-or-above-usage.png",
  caption="Top servers and % of pages served over HTTP/2+.",
  description="Stacked bar chart showing top servers and percentage of pages served over HTTP/2+. Nginx has 64.7% of sites using HTTP/2+, Cloudflare 93.0%, Apache only has 36.8%, Lifespeed has 83.3%, (not set) has 53.0%, pepyaka has 99.8%, gse has 49.1%, openresty has 68.3%, Micorosft IIS has 29.9%, and Squarespace 89.1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=416927136&format=interactive",
  sheets_gid="2024977755",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

If a site uses the Apache HTTP server, it is unlikely to have upgraded to HTTP/2, with only one third of Apache servers leveraging the newer protocol. Nginx shows a more promising number with two-thirds of all servers having upgraded to HTTP/2. CDN and cloud servers all promote high adoption rates, from services such as Cloudfront, Cloudflare, Netlify, S3, Flywheel and Vercel. Other niche server implementations such as Caddy or Istio-Envoy also promote good adoption. On the other end of the spectrum, implementations such as IIS, Gunicorn, Passenger, Lighthttpd, and Apache Traffic Server (ATS) all have low adoption rates, with Scuri also reporting almost zero adoption.

{{ figure_markup(
  image="server-software-not-using-http2-or-above.png",
  caption="Server software used by sites not using HTTP/2+.",
  description="Bar chart showing server software used by sites not using HTTP/2+. Apache has the highest lack of adoption with 18.8% of mobile sites not using HTTP/2+, followed by nginx (9.1%), Micosoft IIS (3.4%), no server name (2.9%), GSE (1.6%), Cloudflare Openresty, and Lifespeed (all on 0.7%), and finally Apache Coyote and Squaresapce have 0.1%. Desktop usage looks similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1494809703&format=interactive",
  sheets_gid="641704944",
  sql_file="count_of_non_h2_and_h3_sites_grouped_by_server.sql",
  width=600,
  height=614
  )
}}

In fact, of all servers reporting a HTTP/1.1 response, the server with the largest majority are Apache servers at 20%. As Apache is one of the most popular web servers on the web, it suggests that older installations of Apache may be holding up the web's ability to move forward and adopt the new protocol in full.

### Adoption by CDNs

CDNs are often pivotal to drive adoption of new protocols like HTTP/2, and looking at the stats proves this.

{{ figure_markup(
  image="top-cdns-and-http2-or-above-usage.png",
  caption="Top CDNs and % of pages served over HTTP/2+.",
  description="Bar chart showing adoption of HTTP/2+ and HTTP/1.1 by CDNs. Without a CDN, only 49% of sites are likely to use HTTP/2+. for the CDNs there is mix adoption but all are above the No CDN value: Cloudflare (94.7%), Google (68.7%), Fastly (97.1%), Amazon CloudFront (91.6%), Akamai (81.4%), Automattic (100.0%), Sucuri Firewall (95.5%), Incapsula (59.6%), Netlify (99.7%), CDN (97.1%), Highwinds (89.8%), Vercel (86.4%), OVH CDN (88.8%), Microsoft Azure (96.6%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1877391271&format=interactive",
  sheets_gid="1902992488",
  sql_file="http2_3_support_by_cdn_per_page_and_request.sql",
  width=600,
  height=592
  )
}}

The vast majority of CDNs have 70% or greater adoption of sites with HTTP/2 - much higher than the 49.1% of non-CDN traffic. Some CDNs such as Yottaa, WP Compress and jsDeliver all have 100% adoption of HTTP/2!

The high adopters are typically services around ad networks, analytics, content providers, tag managers, and social media services. The higher adoption of HTTP/2 in these services is clear as even at the fifth percentile and above in which at least 50% of them have enabled HTTP/2. At the median, 95% of these services will be using HTTP/2.

### Adoption by rank

{{ figure_markup(
  image="http2-or-above-usage-by-ranking.png",
  caption="HTTP/2+ usage on home page by ranking.",
  description="Bar chart showing HTTP/2+ usage on home page by ranking. 82.3% of top 1,000 mobile sites use HTTP/2+ today, for the top 10,000 it's 76.8%, for top 100,000 it's 67.0%, for the top million it's 61.5% and for all sites it's 59.4%. Desktop numbers look similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1651314530&format=interactive",
  sheets_gid="366623986",
  sql_file="http2_http3_usage_by_rank.sql"
  )
}}

There is also a direct correlation between a site's page rank in the HTTP Archive and its support for HTTP/2. 82% of sites listed in the top 1,000 have HTTP/2 enabled. Over 76% in the top 10k websites, followed by 66% of sites in the top 100k, and at least 60% of sites in the top 1 million will have HTTP/2 enabled. This suggests that higher ranking sites have enabled HTTP/2 for the security and performance benefits offered. The higher ranking a site, the more likely it is to have HTTP/2 enabled.


## Digging a little deeper into HTTP/2

One of main benefits of HTTP/2 is that it is binary instead of a text-based protocol. A request sent over a stream may be made up of one or more _frames_. This changes the mechanics between client and server.

By chunking messages into frames, and interleaving those frames on the wire, a single TCP connection can be used to send and receive multiple messages in one connection. This helps eliminate the need for domain hacks and other HTTP/1.1 performance workarounds.

However, this completely new way of sending HTTP traffic means that HTTP/2 is not compatible with previous versions, and so clients and servers must each know they are talking HTTP/2. HTTPS has been adopted as the de facto standard in HTTP/2. While HTTP/2 can be implemented without HTTPS, all major browser vendors ensure HTTP/2 is used over HTTPS. HTTP/2 also uses <a hreflang="en" href="https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation">ALPN</a>, which allows for faster-encrypted connections as the protocol can be determined during the initial connection.

### Switching between protocols

While the use of HTTPS can be used to help decide whether to "speak" HTTP/1.1 or the newer HTTP/2, there are other methods of switching to the newer protocol. HTTP/2 support can be advertised on a HTTP/1.1 connection via the `upgrade` HTTP header, and then the client can use the 101 (Switching Protocols) response status code to make the switch. For HTTP/2 to HTTP/3, a similar `alt-svc` (Alternative Service) header is used, which we will discuss later in this chapter.

The HTTP Archive data suggests that the use of the `Upgrade` header is often misused or configured incorrectly. This feature will in fact be <a hreflang="en" href="https://github.com/httpwg/http2-spec/issues/772">dropped</a> from the next version of HTTP/2. Only a fraction of sites offer the `Upgrade` header at all. The most common header reported is the `h2,h2c` detailing the HTTP/2 option, or HTTP/2 over cleartext, with 0.09% of desktop and 0.16% of mobile sites reporting this header.

A similar rate of sites also offer `websockets` as an `Upgrade` option, with 0.08%. Some sites also offer HTTP/1.1 as an upgrade option incorrectly, as `Upgrade` should be used to signal an incompatible or more appropriate protocol other than the existing HTTP/1.1 connection the request was made on. 0.04% of sites also incorrectly report H2 as an `Upgrade` option, despite having this connection already on HTTP/2.

{{ figure_markup(
  image="upgrade-headers-sent-over-http2.png",
  caption="Upgrade headers sent over HTTP/2 connections.",
  description="Bar chart showing upgrade headers sent over HTTP/2 connections. `h2,h2c` is most common with 2,18 on desktop and 2,595 on mobile. `h2` has 1,319 1,373 respectively and `h2c` has 148 desktop sites and no mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1528853201&format=interactive",
  sheets_gid="1528853201",
  sql_file="detailed_upgrade_headers.sql"
  )
}}

More worrying is the number of sites which offer to "upgrade" a HTTP/2 connection to HTTP/2. This is a clear error and used to confuse browsers in the early days of HTTP/2.

There were also almost 120,000 mobile sites found on HTTP, while still reporting an `Upgrade` header to HTTP/2. A better practice would be to issue a redirect from HTTP to HTTPS, and leverage HTTP/2 on the secure connection directly.

{{ figure_markup(
  caption="Mobile websites claiming to support HTTP/2 when they do not.",
  content="26,000",
  classes="big-number",
  sheets_gid="2104508007",
  sql_file="number_of_https_requests_not_using_h2_or_h3_returning_upgrade_http_upgrade_header_containing_h2.sql"
)
}}

22,000 and 26,000 web pages on desktop and mobile respectively were also found to be on HTTPS but not support HTTP/2. Similarly, hundreds of web pages were incorrectly signaling to upgrade to HTTP/2 despite the connection already on HTTP/2 itself.

### Number of connections

Since the introduction of HTTP/2 the median number of TCP connections per page has steadily been decreasing.

{{ figure_markup(
  image="tcp-connections-by-home-page-http-version.png",
  caption="TCP connections by home page HTTP version.",
  description="Bar chart showing TCP connections by home page HTTP version. 16 on desktop and mobile for HTTP.1.1, and 13 and 12 for desktop and mobile on HTTTP/2+.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=567187980&format=interactive",
  sheets_gid="1213076952",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
  )
}}

At the time of this writing, desktop connections are down 44% over 12 months to a median value of 16 connections. Mobile is down 7% with a median connection count of 12. This represents a good reduction of connections over time, as the adoption of HTTP/2 has increased sharply since 2020.

{{ figure_markup(
  image="tcp-connections-per-http-version-by-percentile.png",
  caption="TCP connections per HTTP version by percentile.",
  description="Bar chart showing TCP connections per HTTP version by percentile. At the 10th percentile it's 6 for HTTP/1.1 and 4 for HTTP/2+, for the 25th it's 10 and 7, at the 50th it's 16 and 12, and the 7th it's 24 and 20, and at the 90th percentile it's 40 and 33.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=993526405&format=interactive",
  sheets_gid="1213076952",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
  )
}}

Based on the HTTP Archive data collected, a median HTTP/1.1 site will have 16 connections per page. Then 24 connections at the 75th percentile. This more than doubles to 40 at the 90th percentile for mobile and desktop. By comparison a HTTP/2 site will have 12 connections on median, 21 connections at 75th percentile, and hits 33 connections at the 90th percentile. Even at the top end, this represents a 21% reduction in the number of connections used across websites.

TLS adds a slight overhead to performance, and with the de facto implementation of HTTP/2 over HTTPS, which means there are performance considerations with the versions of TLS used. Since the introduction of <a hreflang="en" href="https://blogs.windows.com/msedgedev/2016/06/15/building-a-faster-and-more-secure-web-with-tcp-fast-open-tls-false-start-and-tls-1-3/">TLS 1.3</a>, extra performance considerations have been added, including <a hreflang="en" href="https://blogs.windows.com/msedgedev/2016/06/15/building-a-faster-and-more-secure-web-with-tcp-fast-open-tls-false-start-and-tls-1-3/">TLS false starts</a>, which allows the client to start sending encrypted data immediately after the first TLS round trip. As well as zero round trip time (<a hreflang="en" href="https://blog.cloudflare.com/introducing-0-rtt/">0-RTT</a>) to improve the TLS handshake. TLS 1.2 needs two round trips to complete TLS handshake, while 1.3 requires only one, which reduces the encryption latency by half.

{{ figure_markup(
  image="tls-version-by-http-version.png",
  caption="TLS version used by page HTTP version.",
  description="Bar chart showing TLS version used by page HTTP version. HTTP/2 uses TLSv1.3 most often with 48.51% of all pages. HTTP 1.1 still relies most commonly on TLS 1.2 at 16.69% of all pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1143806427&format=interactive",
  sheets_gid="135993893",
  sql_file="tls_adoption_by_http_version.sql"
  )
}}

The HTTP Archive data suggests that 34% of desktop pages are using TLS 1.2, while 56% are using TLS 1.3, with the remaining 10% unknown (HTTPS sites that failed to connect or similar). This is slightly lower on mobile, with 36% using TLS 1.2, 55% using TLS 1.3 and 9% unknown. While the majority of sites use TLS 1.3, a third of sites on the web could leverage an upgrade to receive these performance boosts.

### Reduce headers

Another feature put forward in HTTP/2 was header compression. HTTP/1.1 proved that there were many duplicate or repeating HTTP headers being sent over the wire. These headers can be particularly large when dealing with cookies. To reduce this overhead, HTTP/2 leverages the <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7541">HPACK compression format</a> to reduce the size of headers sent and received. Both client and server maintain an index of often used and previously transferred headers in a lookup table and can refer to the index of those values in the table, rather than sending the individual values back and forth. This saves in the number of bytes sent over the wire.

{{ figure_markup(
  image="most-popular-http-response-headers.png",
  caption="Most popular HTTP response headers.",
  description="Bar chart showing most popular HTTP response headers. `Date`, `Content-Type` and `Server` are among the most popular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1202666187&format=interactive",
  sheets_gid="160135371",
  sql_file="response_headers_type_usage.sql",
  width=600,
  height=605
  )
}}

In terms of the most common response headers received, the top five most common headers are: `date`, `content-type`, `server`, `cache-control` and `content-length` respectively. The most common non-standard header is Cloudflare's `cf-ray`, followed by Amazon's` x-amz-cf-pop `and `X-amz-cf-id`. Outside of content information (`length`, `type`, `encoding`), caching policies (`expires`, `etag`, `last-modified`) and origin policies (STS, [CORS](https://developer.mozilla.org/docs/Web/HTTP/Headers/Access-Control-Allow-Origin)), [`expect-ct`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Expect-CT) reporting certificate transparency and the CSP [`report-to`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy/report-to) headers are some of the most commonly used headers.

While some of these headers (e.g., `date` or `content-length`) may change with every request, the vast majority will send the same, or a limited number of variations for every request and this is where HTTP/2 header compression can provide benefit. Similarly request headers often send the same data (such as the long `user-agent` header) over and over for every request. Therefore, to consider the impact we must look at the number of requests pages are making.

{{ figure_markup(
  image="number-of-http-requests-by-percentile.png",
  caption="Number of HTTP requests by percentile.",
  description="Bar chart showing number of HTTP requests by percentile. At the 90% percentile, desktop is 178 and mobile is 171.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=770966381&format=interactive",
  sheets_gid="2107067784",
  sql_file="response_number_and_size.sql"
  )
}}

The median desktop site has 74 requests, and the median mobile site has 69 requests. Hundreds of sites had over thousands of requests per page. The highest in fact reporting 17,923 requests in total, followed by 10,224. By compressing and reusing the headers sent on previous requests HTTP/2 reduces the impact of repeated requests.

Why our analysis is currently unable to measure the exact impact of Header compression as those details are buried deep in the browser network stack, we can look at the uncompressed header sizes to give some indication of the potential benefit.

{{ figure_markup(
  image="http-response-header-sizes.png",
  caption="HTTP response header sizes.",
  description="Bar chart showing HTTP response header sizes. Desktop header sizes are slightly higher than mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=845576315&format=interactive",
  sheets_gid="2107067784",
  sql_file="response_number_and_size.sql"
  )
}}

The median web page returns 34 KB worth of headers for desktop and 31 KB for mobile. At the 90th percentile this increases to 98 KB and 94 KB for desktop and mobile respectively. However, the largest instance of response header was over 5.38 MB. Many sites were discovered having over 1 MB in response headers. Typically, these large response headers are due to overweight `CSP` or `P3P` headers, suggesting the complexities or mismanagement of these headers across websites. In other extreme examples, overweight headers were due to misconfigurations or errors in the application that duplicate multiple `Set-Cookies` or `Cache-Control` settings.

### Prioritization

Streams can also be linked by having one stream depend on another, and they can be weighted by being assigned an integer between 1 and 256. Through these dependencies and weighting scores, the server can prioritize certain key streams, sending their response data before that of other streams.

Since the introduction of HTTP/2, prioritization has been implemented inconsistently across different parts of the web. [Andy Davis](https://x.com/AndyDavies) has found that this inconsistency may create sub-optimal experiences for users on the web. Often this is because servers will ignore prioritizations and serve based on a first-come first-served behavior. In fact, <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">Andy's research highlights</a> that many of the major CDNs do not implement HTTP/2 prioritization correctly. This also includes a number of the popular cloud load balancers. The 2021 data suggests similar findings as previous years, with only 6 CDNs implementing prioritization correctly. This includes Akamai, Fastly, Cloudflare, Automattic, section.io and Facebook's own CDN.

[Patrick Meehan](https://x.com/patmeenan) suggests that outside using one of the CDNs that implement prioritization correctly, there are a number of <a hreflang="en" href="https://blog.cloudflare.com/http-2-prioritization-with-nginx/">TCP optimizations</a>, including BBR and `tcp_notsent_lowat`, that can be enabled to improve prioritization on the server side.

This inconsistency also exists at the client level, with different browser vendors implementing this behavior differently. Safari implements a static approach to prioritization depending on the asset type and does not map dependencies. Chrome, Edge, and Firefox have a more advanced approach to building out logical dependencies across streams and can reprioritize requested assets on the stream based on the discovered prioritization.

{{ figure_markup(
  image="webpagetest-waterfall-example.png",
  caption="WebPageTest waterfall example.",
  description="Screenshot showing WebPageTest resources, where high priority resources finish loading early.",
  width=938,
  height=715
  )
}}

Since HTTP/2 there has been an updated proposal to prioritizations, with the <a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-priority">Extensible Prioritization Scheme for HTTP</a> proposal. This includes adding a `priority` header in the response, as well as a new `PRIORITY_UPDATE` frame for HTTP/2. This `PRIORITY_UPDATE` frame is also proposed for HTTP/3. This has yet to be adopted across the web in full, but has received focus from <a hreflang="en" href="https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/">Cloudflare</a> in an effort to improve the underlying behavior of <a hreflang="en" href="https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/">prioritization</a>.

### The death of HTTP/2 Push?

Another major feature was the introduction of the server push mechanism. HTTP/2 server push allows the server to send multiple resources in response to a client request. Thus, the server informs the client about assets it may need before the client becomes aware they exist. The common use case is to push critical assets such as JavaScript and CSS to the client before the browser has parsed the base HTML and identified those critical assets and subsequently requested them itself. The client also has the option to decline the push message.

Despite the promises of zero round trips, pre-emptive critical assets and the potential for performance upsides, HTTP/2 push has not lived up to the hype.

{{ figure_markup(
  caption="Sites using HTTP/2 push.",
  content="1.25%",
  classes="big-number",
  sheets_gid="1872576847",
  sql_file="count_of_h2_and_h3_sites_using_push.sql"
)
}}

When analyzed in 2019 HTTP/2 had little adoption, averaging around 0.5%. The following year in 2020, there was an increase to 0.85% adoption across desktop and 1.06% adoption on mobile. This year in 2021 the numbers have slightly increased at 1.03% on desktop, and 1.25% on mobile. Relatively, mobile has seen a significant increase year on year, however at 1.25% overall adoption of HTTP/2 it is still negligible. At the page level, this sits at 64k and 93k requests for desktop and mobile respectively.

{{ figure_markup(
  image="preload-link-nopush-header-usage.png",
  caption="HTTP preload link headers with `nopush`.",
  description="Bar chart showing HTTP preload link headers with `nopush`. 13.4% mobile and 12.5% on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1245853&format=interactive",
  sheets_gid="1461224598",
  sql_file="count_of_preload_http_headers_with_nopush_attribute_set.sql"
  )
}}

Many HTTP/2 implementations reused the `preload` [resource hint](./resource-hints) as a signal to push. However, in some cases, a developer may want to preload an asset, but decide they do not want to have it delivered via a HTTP/2 push mechanism. They may want to signal to a CDN or other downstream server to not attempt a push, via the <a hreflang="en" href="https://www.w3.org/TR/preload/#server-push-http-2">`nopush`</a> directive. This year's data shows that over 200,000 preload headers were used, and on average 12% of those were issued with a `nopush` attribute.

One of the challenges is to implement dynamic push directives at a page level, where the push messages are formed based on the current page and the critical assets for that page, as opposed to a hardcoded series of pushes that apply as a blanket across the site, such as those that may be defined globally in an <a hreflang="en" href="https://www.nginx.com/blog/nginx-1-13-9-http2-server-push/">Nginx</a> or <a hreflang="en" href="https://httpd.apache.org/docs/2.4/howto/http2.html#push">Apache</a> configuration. Despite implementation examples from <a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317">Akamai</a> and <a hreflang="en" href="https://github.com/guess-js/guess/">Google</a> that use real user data and analytics to determine this dynamic push configuration, the data shows implementation across the web has been limited. <a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317">Akamai</a>'s research suggests that when applied correctly, HTTP/2 push provides a clear benefit to web performance.

However, investments made from other CDN providers and server implementations prove that designing for HTTP/2 push is difficult. In fact [Jake Archibald](https://x.com/jaffathecake) described some of <a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">these challenges</a> back in 2017. These focus on problems with push cache, browser inconsistencies, and superfluous bytes sent from the server if the client determines the push isn't needed. Attempts to resolve <a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-cache-digest#appendix-A">some</a> of <a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-vkrasnov-h2-compression-dictionaries-03">these</a> issues were abandoned, largely due to issues around privacy and security concerns, where cache digests may be used to identify users.

Patrick Meehan breaks down some of the problems <a hreflang="en" href="https://blog.cloudflare.com/early-hints/#:~:text=summarized%20server%20push%E2%80%99s%20gotchas">in this post on a possible alternative - 103 Early Hints</a>. In that post he details that Push usually ends up delaying HTML and other render blocking assets.

#### Pushed assets

{{ figure_markup(
  image="http2-push-size.png",
  caption="HTTP/2 pushed kilobytes.",
  description="Bar chart showing the number of kilobytes pushed on mobile and desktop at various percentiles. At the 10th percentile 0 bytes are pushed for both desktop and mobile, at the 25th percentile 19 bytes are pushed on desktop and 0 on mobile, at the 50 it's 146 and 48 respectively, at the 75 it's 295 and 222, and finally at the 90th percentile 373 bytes are pushed for desktop and 323 for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=971663204&format=interactive",
  sheets_gid="138914513",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql"
  )
}}

In cases where items were pushed, the median size of the bytes that were pushed were 145 KB for desktop and 48 KB for mobile. This almost doubles to 294 KB for desktop and more than quadruples for mobile at 221 KB for the 75th percentile. At the top end, we see 372 KB pushed and 323 KB for mobile at the 90th percentile.

While these numbers at the 90th percentile appear fine, it's when you start to review the number of pushes, it highlights the misuse of the push feature:

{{ figure_markup(
  image="http2-push-number.png",
  caption="HTTP/2 pushed kilobytes.",
  description="Bar chart showing the number of assets pushed on mobile and desktop at various percentiles. At the 10th percentile 1 resource is pushed for both desktop and mobile, at the 25th percentile it's 2 and 1 respectively, at the 50th percentile it's 4 and 3 at the 75th percentile it's 8 and 8 at the 90th percentile it's 21 and 16.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1039731009&format=interactive",
  sheets_gid="138914513",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql"
  )
}}

The median number of pushes is 4 and 3 across desktop and mobile respectively. This moves to 8 at the 75% percentile and jumps to 21 and 16 at the 90th percentile. The 100% percentile sees an amazing 517 and 630 pushes being done by some sites, which highlights the dangers of the feature, particularly when considering push was originally designed to advertise a small number of critical assets early in the request.

{{ figure_markup(
  image="http2-push-counts.png",
  caption="HTTP/2 pushed counts.",
  description="Bar chart showing the number of assets pushed on mobile and desktop at various percentiles. At the 10th percentile 1 resource is pushed for both desktop and mobile, at the 25th percentile it's 2 and 1 respectively, at the 50th percentile it's 4 and 3 at the 75th percentile it's 8 and 8 at the 90th percentile it's 21 and 16.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1039731009&format=interactive",
  sheets_gid="138914513",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql"
  )
}}

When analyzing by content type, the data suggests that fonts are the most commonly pushed asset, followed by images, CSS, scripts and video. These numbers paint a different story when looking at the size of the asset types. Fonts are still the largest assets pushed by volume, but scripts are not far behind. This is followed by images, videos and then CSS. Therefore, this suggests that despite more CSS files being pushed, they are small in size. Scripts aren't pushed as often as fonts, images and CSS, but represent a larger volume of the push data.

As the numbers above suggest, and as described in previous years, HTTP push is underutilized. When utilized, it is often misused or not used in the intended manner, which is likely to be a performance detriment for the end user.

Google has flagged its intent to remove push from Chrome. However, throughout 2021 there was still <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">ongoing debate</a> around the efficacy of HTTP/2 Push. This removal is yet to happen, and it is largely suggested that Push can be leveraged through CDNs who implement it correctly. Google recommends leveraging the `<link rel="preload">` directive as an alternative to push, albeit this still incurs a 1 RTT, which is what push aims to solve. Google also <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">reports</a> it has not implemented Push in HTTP/3, and neither have others such as Cloudflare.

#### An alternative to push

The other commonly suggested alternative to Push is the use of <a hreflang="en" href="https://github.com/bashi/early-hints-explainer/blob/main/explainer.md">_Early Hints_</a>. This works by having the server report a `103` status code response message, with `preload` hints in the Link header. Early Hints allows the server to report on assets that the client should `preload` before getting the page HTML back.

```
HTTP/1.1 103 Early Hints
Link: <style.css>; rel="preload"; as="style"
```

CDNs such as <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">Fastly</a> and <a hreflang="en" href="https://blog.cloudflare.com/early-hints/">Cloudflare</a> have been experimenting with early hints, but it's still early days for Early Hints. At the time of this writing, Early Hints support in HTTP/2 inside Chrome is still <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=671310">being worked on</a>, and while other browser vendors have announced support for Early Hints, and while Cloudflare has introduced support in the wild, many other vendors have not yet made concrete implementations.

Despite incremental adoption for HTTP/2 push year on year, it is likely that Google and other browser vendors abandon support for push, in favor of alternatives such as Early Hints. Coupled with support from CDNs, Early Hints is likely to be the replacement. Last year, we proposed the question of whether it was a goodbye to HTTP/2 push. This year we suggest that mainstream use of HTTP/2 is dead, at least for the web browsing use case.

## HTTP/3

HTTP/3 is the next advancement of HTTP/2 and builds upon its foundation with even more changes down throughout the protocol. The biggest change is the move away from TCP to a UDP-based transport protocol called QUIC. This allows quicker advancements in HTTP, without waiting for TCP implementations that are ingrained all across the internet to support them. For example, HTTP/2 introduced the concept of independent streams but, at a TCP level these were still part of one TCP stream, and so not truly independent. Changing TCP to support this would take considerable time before it would be so widely support as to be safe to use. Therefore HTTP/3 switches to an alternative transport protocol. QUIC is similar to TCP in many ways, and basically re-builds all the many useful features of TCP, but with the addition of new features. QUIC is encrypted and delivered over the well-support, lightweight UDP transport protocol.

### HTTP/3 Adoption

{{ figure_markup(
  image="http3-support-by-ranking.png",
  caption="HTTP/3 support on home page by ranking.",
  description="Bar chart showing HTTP/3 support on home page by ranking. The top 1,000 sites have 13.3% of mobile sites supporting HTTP/3, for the top 10,000 it's 17.4%, for the top 100,000 it's 19.5%, for the top 1 million sites have 19.2% using HTTP/3 and for all it's 15.0%. Desktop numbers look very similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=197871310&format=interactive",
  sheets_gid="2116042894",
  sql_file="http3_support_by_rank.sql"
  )
}}

Earlier in the chapter we found that sites that were ranked higher had greater adoption of HTTP/2. Surprisingly, the opposite is true of HTTP/3. We see less support from the top one thousand sites than we do the top one million, with slightly more support implemented across mobile sites.

Distribution across the top one hundred thousand sites and top one million sites at 18% and 19% for desktop and mobile respectively. This drops to 16% and 17% within the top ten thousand sites. The top one thousand sees 11% and 13% deployment across desktop and mobile. Adoption beyond the top one million sit around 15% for implementation across homepages. Overall, this is quite a strong adoption across the board, likely spearheaded by the support from some of the major CDNs. This suggests that while the top websites have adopted HTTP/2 as mainstream, many have yet to explore HTTP/3.

### HTTP/3 Support

Web server support for HTTP/3 is still limited in the market. Nginx represents the most common HTTP server on the web, with about two thirds of HTTP/2 sites using a version of Nginx. Nginx has publicly expressed support for HTTP/3, including <a hreflang="en" href="https://www.nginx.com/blog/our-roadmap-quic-http-3-support-nginx/">discussing their roadmap</a> to roll out full support, and aim to have full support by the end of 2021. The Apache server, by comparison, has yet to provide any guidance on when HTTP/3 will be supported. Microsoft has announced support for HTTP/3 in its new <a hreflang="en" href="https://blog.workinghardinit.work/2021/10/11/iis-and-http-3-quic-tls-1-3-in-windows-server-2022/">Windows Server 2022</a>. Other alternatives such as the LiteSpeed web server have <a hreflang="en" href="https://docs.litespeedtech.com/cp/cpanel/quic-http3/">leaned into its support</a> for HTTP/3, whereas Caddy has enabled support for HTTP/3 as an <a hreflang="en" href="https://caddyserver.com/docs/caddyfile/options">experimental feature</a> available. Node.js support is <a hreflang="en" href="https://github.com/nodejs/node/pull/37067">held up</a> due to lack of OpenSSL support.

A number of CDNs have also expressed support for HTTP/3. Cloudflare has been experimenting with HTTP/3 <a hreflang="en" href="https://blog.cloudflare.com/http3-the-past-present-and-future/">since 2019</a>, in which they report better performance in many examples. Cloudflare have also published their <a hreflang="en" href="https://github.com/cloudflare/quiche">quiche</a> library, which powers their HTTP/3 deployment on the edge network. Fastly has also <a hreflang="en" href="https://www.fastly.com/blog/why-fastly-loves-quic-http3">discussed its support</a> for HTTP/3, and has it available as a <a hreflang="en" href="https://www.fastly.com/blog/modernizing-the-internet-with-http3-and-quic">BETA service</a>. Fastly have also open sourced their own implementation known as <a hreflang="en" href="https://github.com/h2o/quicly">quicly</a>, designed for the <a hreflang="en" href="https://h2o.examp1e.net/">H2O HTTP</a> server that Fastly uses on their edge network. Akamai has also expressed <a hreflang="en" href="https://www.akamai.com/blog/performance/http3-and-quic-past-present-and-future">continued support</a> for HTTP/3 and QUIC, and has worked with Microsoft to fork a version of <a hreflang="en" href="https://github.com/quictls/openssl">OpenSSL with QUIC</a> to help move support <a hreflang="en" href="https://daniel.haxx.se/blog/2021/10/25/the-quic-api-openssl-will-not-provide/">forward</a>.

Browser support for HTTP/3 is still evolving. As of October 2021, support is available in the most recent version of Microsoft Edge, Firefox, Google Chrome, and Opera, and partially across mobile for some Android variants and Opera mobile. Support from Safari is limited on macOS 11 Big Sur and must be enabled via the "Experimental Features", support for iOS is also only available as an experimental feature behind a flag.

### Negotiating HTTP/3

As HTTP/3 is on a completely different transport layer to traditional TCP-based HTTP it is not possible to negotiate HTTP/3 as part of the connection set up—like what happens with HTTP/2 through the HTTPS negotiation. By that stage you have already picked your transport protocol!

HTTP/3 instead requires the `alt-svc` header. You start on a TCP-based HTTP connection (presumably HTTP/2 if the client is advanced enough to support HTTP/3), and then the server can signal though the `alt-svc` header on responses to any requests, that this server also support HTTP/3 over UDP and QUIC. The browser can then decide to try to connect via that. Due to the several iterations of HTTP/3, this header is also how client and server can decide which version of HTTP/3 they decide on.

So, in the very first case, HTTP/2 will be used in the initial request, and once the browser discovers the `alt-svc` header, it can then switch protocols and start using HTTP/3. For future cases the browser can cache the `alt-svc` header, and next time jump straight to trying HTTP/3.

{{ figure_markup(
  image="webpagetest-h2-h3-example.jpeg",
  caption="WebPageTest example showing HTTP2 switching to HTTP3 during page load.",
  description="Screenshot from WebPageTest showing how initial page load will use HTTP2 then switch to HTTP3 after `alt-svc` is discovered.",
  width=1974,
  height=892
  )
}}

Also, due to connection coalescing (connection reuse), in some instances if two hostnames resolve over DNS to the same IP and use the same TLS certificate and version, then the client could reuse the same connection across both hostnames. Therefore, it is not uncommon to see a waterfall request with a mix of both HTTP/2 and HTTP/3, depending on the number of hosts and TLS certificates used.

At a page level, about 15% of requests  offer an `alt-svc` header. These vary between syntax that offer QUIC, one of the various H3 pre-release versions (officially HTTP/3 is not standardized at the time of writing, but it's in the very final stages). Some sites will advertise support for multiple versions of QUIC, for example `quic=":443"; ma=2592000; v="39,43,46,50"`, while some will only offer one version. The most common advertisement of the `alt-svc` is `"h3-27=":443"; ma=86400, h3-28=":443"; ma=86400, h3-29=":443"; ma=86400, h3=":443"; ma=86400"`, across 11% of all `alt-svc` responses. This header instructs clients that it supports HTTP/33 versions 27, 28 and 29, with a `max-age` of 24 hours.

In instances where `alt-svc` was present, most sites were appending version numbers as they adopt support for new protocol versions, however there were many cases where sites were using the [`clear`](https://developer.mozilla.org/docs/Web/HTTP/Headers/alt-svc) directive to invalidate previously advertised support.

At the time of this writing the most recent version of the <a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-quic-http-34">HTTP/3 spec</a> is version 34. However, only 0.01% of responses report this latest version. When viewing details of `alt-svc` at a request level, version 27 is the most commonly requested version in response headers. The server will indicate the preferred versions in order from left to right. 6% of requests will report `h3-27` in the first instance preferred, with 28 and 29 as alternate versions offered in the same response. 2% of responses will offer `h3-29` as the only preferred version for upgrade. QUIC as the preferred protocol update, receives a mere 0.11%, mostly due to outdated servers reporting this incorrectly. In reality there were little differences technically from `h3-29` onwards and most implementations froze versions at that, awaiting the official launch of `h3`.

Most `alt-svc` reported a `max-age` of only 24 hours, which is the default if not specified. The longest `max-age` reported for `alt-svc` was 30 days or 2592000 seconds.

{{ figure_markup(
  image="webpagetest-alt-svc-example.png",
  caption="WebPageTest `alt-svc` example.",
  description="Screenshot from WebPageTest showing the `alt-svc` response header from an example request.",
  width=1032,
  height=552
  )
}}

### HTTP/3 considerations and concerns

While many of the upsides of HTTP/3 have been discussed, there are also some concerns and criticisms that have been raised. Many developers are only now comfortable with the changes introduced from HTTP/2, after having to roll back many web performance workarounds to overcome the limitations from HTTP/1.1, as those workarounds later became <a hreflang="en" href="https://docs.google.com/presentation/d/1r7QXGYOLCh4fcUq0jDdDwKJWNqWK1o4xMtYpKZCJYjM/present?slide=id.p19">anti-patterns</a> in HTTP/2.

In some cases, developers and site owners may argue that the incremental gains from HTTP/3 may not be worth major upgrades to their web servers. Particularly when HTTP/3 hasn't solved all the problems identified in HTTP/2, such as prioritization or effective use of server push. As such, adoption may be driven at the CDN level, and not within web applications. This may particularly be the case if some servers may not support HTTP/3 or be blocked by lack of OpenSSL support.

As discussed throughout this chapter, QUIC relies on the UDP protocol. With the introduction of HTTP/3, UDP traffic is due to increase across the web. However, currently UDP is often used as an attack vector, such as those in a <a hreflang="en" href="https://blog.cloudflare.com/reflections-on-reflections/">reflection attack</a>. QUIC does have some <a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-quic-transport-27#section-8.1">protection mechanisms</a> in place, but this may mean changes to the way UDP is treated across the web, and the amount of UDP traffic allowed on some networks and firewalls. In the same instance, there may be adoption pushback in cases where TCP headers and the unencrypted parts of the packet are used by firewalls and other <a hreflang="en" href="https://en.wikipedia.org/wiki/Middlebox">middleboxes</a> across the web. As QUIC encrypts more parts of the packet, there is less visibility for inspection on the packet, and may limit how these middleboxes operate, including the ability to do additional security checks.

There are also concerns that QUIC may be a performance problem on the server side. This is because of higher CPU requirements needed when dealing with UDP. Some estimates suggest twice as much CPU is needed when compared with HTTP/2. This said, there are a number of attempts to optimize <a hreflang="en" href="https://conferences.sigcomm.org/sigcomm/2020/files/slides/epiq/0%20QUIC%20and%20HTTP_3%20CPU%20Performance.pdf">QUIC CPU performance</a> ongoing.

Despite these concerns, the real benefits will be received from the web's end users. QUIC's ability to maintain connections, when switching network connections, allowing for a mobile-first experience in a mobile-first world. The improvements to head-of-line blocking will also ensure greater gains in page load, where we all now know that <a hreflang="en" href="https://ai.googleblog.com/2009/06/speed-matters.html">every millisecond</a> counts. The enhanced encryption QUIC introduces also allows for a more safe and secure web. As well as the 0-RTT possible with HTTP/3 allows for improved performance.

## Conclusion

Throughout this chapter we have looked at the evolution of HTTP, with a primary focus on the increasing adoption of HTTP/2, and the benefits the newer protocol version offers. This was followed by a closer look at HTTP/3 and how version 3 aims to solve many of the concerns identified after several years of HTTP/2 use across the web.

The HTTP Archive data suggests that this year saw a major uptake in adoption of HTTP/2, with 72% of requests using HTTP/2, and 59% of base HTML pages using HTTP/2. This adoption is largely fueled by increased adoption from CDN providers. HTTP/1.1 is now in the minority across the web.

Despite the uptake on HTTP/2, the push features of HTTP/2 remain underutilized, due to the complexities of implementation, and we suggest that push may be in fact dead on arrival. At the same time, we have seen ongoing concerns with resource prioritization, and incorrect implementations outside the major CDN vendors. Complexities with prioritization remain so prevalent that it has been removed from the HTTP/3 specification.

2021 also allowed us to take a closer inspection on the adoption of HTTP/3. Major players such as Google and Facebook have been rolling out their own support for HTTP/3 for a number of years. Wider adoption of HTTP/3 has been influenced by Akamai, Cloudflare, and Fastly who have publicly been working to support HTTP/3 for other parts of the web.

HTTP/3 aims to build upon the improvements of HTTP/2, including the head-of-line blocking imposed by TCP, while also ensuring more parts of the protocol stack are secure with QUIC's tighter encapsulation of TLS 1.3. However, it is still early days for HTTP/3. We look forward to measuring the adoption of HTTP/3 in 2022, and believe it is likely to gain further traction as support for HTTP/2 becomes mainstream and people look to gain further improvements over current deployments.

There are some concerns expressed with HTTP/3, but any of these concerns should be outweighed by performance gained by the end user. It is likely the HTTP/3 adoption will also be fueled by CDN rollouts, as they work towards their own implementations, as we saw with HTTP/2. Particularly we are yet to see implementations across major web frameworks. It is also likely that we will see a mix of HTTP/2 and HTTP/3 over the next several years.
