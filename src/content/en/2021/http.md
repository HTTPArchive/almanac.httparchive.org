---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: TODO
authors: [dominiclovell]
reviewers: [tunetheweb, rmarx]
analysts: [tunetheweb]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1pCdpndXTXexSIZLmVc-aUbp5PcHhZ83hbEEfmDyfD0U/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

The HTTP protocol is one of few key parts of the web. HTTP itself was unchanged for several years after HTTP/1.1 was introduced in 1997. It wasn't until 2015, with the introduction of HTTP/2, that saw a major design change to the way HTTP was implemented. HTTP/2 was designed to introduce changes primarily at the transport level of the protocol. These protocol changes, while introducing changes, still allowed for backward compatibility between versions.

This year we again take a closer look at HTTP/2, discussing some of its major features. We then look at some of the benefits of HTTP/2, and why it has been adopted heavily across the web performance community. While HTTP/2 aimed at solving many problems with HTTP, including connection limits, better header compression, and binary support which allowed for better payload encapsulation, not all features put forward were successful in their design.

After several years of HTTP/2 in the wild, some of the intentions of HTTP/2 are still to be realized, due to the complexity of their design. For example, last year we put forward the question of whether we say goodbye to HTTP/2 push. This year we aim to answer this question with more confidence by looking at the 2021 data. As these shortcomings came to light, they have been addressed or omitted from the next iteration of HTTP, which was initially known as HTTP-over-QUIC, and later renamed to HTTP/3.

Increased support for HTTP/3 over the past year has allowed for introspection on HTTP/3's adoption on the web. This chapter takes a closer look at some of the core features of HTTP/3 and the benefits of each of these. We also examine the major vendors who are supporting HTTP/3 evolution, as well as some of the ongoing critiques of HTTP/3.

Some of the data points the Web Almanac aims to answer across the HTTP chapter include the percentiles of adoption across HTTP versions, support from the key software vendors and CDN companies, and how this distribution between first and third parties influences adoption. We also take a look at usage across the top ranked sites across the web, including metrics on HTTP attributes such as connections, server push and response data size.

These data points provide a snapshot for 2021 on the HTTP usage across the web and how the protocol is evolving across its major versions, to then provide insight into the adoption of major features in the coming years.

## Evolution of HTTP/2

It's been six years since the IETF introduced us to HTTP/2. With this thought, it's worth understanding how we got to HTTP/2 in the first place. It was thirty years ago, in 1991 that we were first introduced to HTTP 0.9. HTTP has come a long way since 0.9, which was limited in capabilities. 0.9 was used for one-line protocol transfers, which only supported the GET method, and had no support for headers nor status codes. Responses were only provided in hypertext. Five years later, we were introduced to HTTP/1.0. The 1.0 version contains most of the protocol we know now, including response headers, status codes, and the GET, HEAD and POST methods.

A problem not addressed in 1.0 was that the connection was terminated immediately after the response was received. This meant each request was required to open a new connection, perform TCP handshakes, and close the connection after the data was received. This major inefficiency saw HTTP/1.1 introduced only a year later in 1997, which allowed for persistent connections to be made, which can be reused once opened. This version served its purpose for 18 years, without any changes introduced until we saw HTTP/2 in 2015. During this time Google continued to experiment with [SPDY](https://en.wikipedia.org/wiki/SPDY) and other features, however the HTTP protocol itself wasn't upgraded until HTTP/2 was formalized.

HTTP/2 aimed to address many of the problems web developers were facing when trying to achieve increased performance. Complicated processes such as domain sharding, asset spriting, and concatenating files were necessary to work around inefficiencies in HTTP/1.1. By introducing resource multiplexing, prioritization, and header compression, HTTP/2 was designed to solve these head-of-line blocking problems and provide some network optimization at the protocol level. As well as addressing the known performance problems, HTTP/2 introduced new potential performance optimisations with features such as PUSH, where the server could preemptively send content to the client before the client would be aware of the asset.

{{ figure_markup(
  image="http-versions-main-page.png",
  caption="HTTP versions used by page load.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=164555214&format=interactive",
  sheets_gid="1870188510",
  sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql"
  )
}}

In the thirty years since HTTP version 0.9, there has been a shift in the protocol's adoption. With over 6 million web pages analyzed, the HTTP archive found only a single instance of HTTP 0.9 being used for the initial page request. Only a couple of thousand pages still use 1.0, which accounts for 0.04%. Almost 40% of pages were still using version 1.1 however, with the remaining 60% using HTTP/2 or above. HTTP/2 adoption is thus up 10% since the same analysis was performed in 2020.

Note: Due to the way HTTP/3 works, as discussed below, and how our crawl works with a fresh instance each time HTTP/3 is unlikely to be used for the initial page request, or even subsequent requests. Therefore we report some statistics in this chapter as “HTTP/2+” to indicate HTTP/2 or HTTP/3 might be used in the real world. We will investigate how much HTTP/3 is actually supported (even if not used) later in the chapter.

{{ figure_markup(
  image="http-version-requests.png",
  caption="HTTP versions used by requests.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=2104913686&format=interactive",
  sheets_gid="2077755325",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
  )
}}

## Adoption of protocol versions

**HTTP versions used per request**

In 2021, the HTTP Archive data suggests that HTTP/0.9 and HTTP/1.0 are all but virtually dead. While 0.9 did have hundreds of requests present, this becomes rounded down to zero when aggregated across the entire dataset. HTTP/1.0 has thousands of requests, but it too only represents 0.02% of the total amount. Interestingly, over a quarter of requests are still served via HTTP/1.1. When compared with 2020, this represents a 25% decline, as 2020 had 50% of requests still leveraging 1.1 across both mobile and desktop. Two thirds of the web are served over HTTP/2 or above, which suggests that HTTP/2 and HTTP/3 are well and truly the dominant protocol versions for  the web.

{{ figure_markup(
  caption="Decline in HTTP/1.1 requests in lst year.",
  content="25%",
  classes="big-number",
  sheets_gid="2077755325",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

**HTTP versions used per page**

When reviewing the initial HTML request, the numbers at a per-page level do not appear as high, with almost 40% of HTML pages being served by HTTP/1.1 and almost 60% of pages leveraging HTTP/2+, which suggests not all web servers have upgraded to HTTP/2.

{{ figure_markup(
  image="median-http-requests-per-site.png",
  caption="Median HTTP requests per site.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1570750419&format=interactive",
  sheets_gid="238475731",
  sql_file="avg_percentage_of_resources_loaded_over_HTTP_by_version_per_site.sql"
  )
}}

That said, beyond the 50th percentile of pages, these pages have 92% or more of their resources being served over HTTP/2+.

{{ figure_markup(
  image="http2-and-above-resources-by-percentile.png",
  caption="Usage HTTP/2+ resources by percentile.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1207400014&format=interactive",
  sheets_gid="871426393",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

HTTP/2 adoption by third party content is so heavily skewed, that beyond the 40th percentile of third party requests, 100% of traffic is being served by HTTP/2. In fact, even at the tenth percentile, over 66% of requests are leveraging HTTP/2.  This suggests the majority of adoption is still being influenced by [third-party content](./third-party), and content being served by domains leveraging a [CDN](./cdn).

According to caniuse.com, 97% of browsers support HTTP/2 globally. However, [93% of sites on desktop and 91% on mobile](https://httparchive.org/reports/state-of-the-web#pctHttps ) all support HTTPS, which is up 5% from last year in 2020, and was up 6% in the year prior between 2019 and 2020. Implementation of HTTPS is no longer a blocker. Therefore, it's important to understand that with such a high adoption across browsers, and high HTTPS adoption, the limiting factor in greater adoption of HTTP/2 is still  largely dictated by the server implementation.

{{ figure_markup(
  image="server-http2-or-above-usage.png",
  caption="Top servers and % of pages served over HTTP/2+.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=416927136&format=interactive",
  sheets_gid="2024977755",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

## A quick look at response

<figure>
  <table>
    <thead>
      <tr>
        <th>Status group</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>0</td>
        <td class="number">0.0%</td>
        <td class="number">0.0%</td>
      </tr>
      <tr>
        <td>1</td>
        <td class="number">0.1%</td>
        <td class="number">0.1%</td>
      </tr>
      <tr>
        <td>2</td>
        <td class="number">92.5%</td>
        <td class="number">91.0%</td>
      </tr>
      <tr>
        <td>3</td>
        <td class="number">6.6%</td>
        <td class="number">7.9%</td>
      </tr>
      <tr>
        <td>4</td>
        <td class="number">0.7%</td>
        <td class="number">0.8%</td>
      </tr>
      <tr>
        <td>5</td>
        <td class="number">0.0%</td>
        <td class="number">0.0%</td>
      </tr>
      <tr>
        <td>6</td>
        <td class="number">0.0%</td>
        <td class="number">0.0%</td>
      </tr>
      <tr>
        <td>7</td>
        <td class="number">0.0%</td>
        <td class="number">0.0%</td>
      </tr>
      <tr>
        <td>9</td>
        <td class="number">0.0%</td>
        <td class="number">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTTP response status codes groups.", sheets_gid="901078696", sql_file="response_status_code_counts.sql") }}</figcaption>
</figure>

Of all the requests made across all assets and pages on the HTTP Archive, 92% of responses fall in the 2XX response code (91% for mobile). 6% fall under the 3XX code, with the majority of these responses reporting a 302 temporary redirect.

{{ figure_markup(
  image="most-used-http-response-status-codes.png",
  caption="HTTP most used response status codes.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1266782054&format=interactive",
  sheets_gid="901078696",
  sql_file="response_status_code_counts.sql"
  )
}}

Only 0.68% are 301 permanent redirects. Juts over half a percent are 404 Not Found responses, with the remaining status codes combined representing less than 1% of the total crawl.

{{ figure_markup(
  image="favicons-that-404.png",
  caption="Percentage of Favicons that 404.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1385607607&format=interactive",
  sheets_gid="1342763581",
  sql_file="favicons_number_404s.sql"
  )
}}

Interestingly, about 20% of all the 404s found in the crawl are due to a missing favicon, suggesting that many site owners do not implement this feature.

{{ figure_markup(
  caption="Percentage of favicons that 404.",
  content="20%",
  classes="big-number",
  sheets_gid="1342763581",
  sql_file="favicons_number_404s.sql"
)
}}

This suggests most websites report a 200 response. Interestingly, 301 represents such a small percentage of responses, despite it being a [signal](https://developers.google.com/search/docs/advanced/crawling/301-redirects) that content has moved to a new location. This might suggest that site owners may not be leveraging 301s effectively. This said, the HTTP archive crawlers only crawl initial homepages, in which case, many redirects may in fact be implemented outside the initial homepage.

## HTTP2 technical details

HTTP/2 was architected in a way that saw most of its changes at the protocol level. Over the 18 years of steady HTTP/1.1 use, the need for many improvements were identified over time.

One of main benefits of HTTP/2 is that it is binary instead of a text-based protocol. This changes the mechanics between client and server. One or more requests are delivered over a stream, which is a bi-directional flow of bytes. A request sent over a stream may be made up of one or more frames. A frame is a logical unit of a request, which may be a header frame or a data frame. A header frame will link a request to its stream.

By chunking messages into frames, and interleaving those frames on the wire, a single TCP connection can be used to send and receive multiple messages in one connection. This helps eliminate the need for domain hacks and other HTTP/1.1 performance workarounds.

Streams can also be linked by having one stream depend on another, and they can be weighted by being assigned an integer between 1 and 256. Through these dependencies and weighting scores, the server can prioritize certain key streams, sending their response data before that of other streams.

Another major feature was the introduction of the server push mechanism. HTTP/2 server push allows the server to send multiple resources in response to a client request. Thus the server informs the client about assets it may need before the client becomes aware they exist. The common use case is to push critical assets such as JS & CSS to the client before the browser has parsed the base HTML and identified those critical assets and subsequently requested them itself. This is typically done at the protocol level via a PUSH_PROMISE frame. The client also has the option to decline the push message.

Another feature put forward in HTTP/2 was header compression. HTTP/1.1 proved that there were many duplicate or repeating HTTP headers being sent over the wire. These headers can be particularly large when dealing with cookies. To reduce this overhead, HTTP/2 leverages the HPACK compression format to reduce the size of headers sent and received. Both client and server maintain an index of often used and previously transferred headers in a lookup table, and can refer to the index of those values in the table, rather than sending the individual values back and forth. This saves in the amount of bytes sent over the wire.

HTTPS has also been adopted as the de facto standard in HTTP/2. While HTTP/2 can be implemented without HTTPS, all major browser vendors ensure HTTP/2 is used over HTTPS. HTTP/2 also uses [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation), which allows for faster-encrypted connections as the protocol can be determined during the initial connection.

## Switching between protocols

When reporting a protocol switch, there are three main ways a server might advertise a switch. The first and most common is a redirect, for example between HTTP and HTTPS. A switch between HTTP/1.1 and HTTP/2 is usually reported via the Upgrade header and reports a 101 (Switching Protocols) response status code. For HTTP/2 to HTTP/3, an `alt-svc` (Alternative Service) header is used, which we will discuss later in this chapter.

{{ figure_markup(
  image="upgrade-headers-sent-over-http2.png",
  caption="Upgrade headers sent over HTTP/2 connections.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1528853201&format=interactive",
  sheets_gid="1528853201",
  sql_file="detailed_upgrade_headers.sql"
  )
}}

The HTTP Archive data suggests that the use of the `Upgrade` header is often misused or configured incorrectly. This feature will in fact be [dropped](https://github.com/httpwg/http2-spec/issues/772) from the next version of HTTP/2. The Upgrade header field is intended to provide a simple mechanism for transition from HTTP/1.1 to some other, incompatible protocol. Only a fraction of sites offer the `Upgrade` header. The most common header reported is the “h2,h2c” detailing the HTTP/2 option, or HTTP/2 over cleartext, with 0.09% of desktop and 0.16% of mobile sites reporting this header. A similar rate of sites also offer websockets as an Upgrade option, with 0.08%. Some sites also offer HTTP/1.1 as an upgrade option incorrectly, as `Upgrade` should be used to signal an incompatible or more appropriate protocol other than the existing HTTP/1.1 connection the request was made on. 0.04% of sites also incorrectly report H2 as an `Upgrade` option, despite having this connection already on HTTP/2.

&lt;Stat figure>

There were also almost 200,000 requests found on HTTP,  while still reporting an `Upgrade` header. A better practice would be to issue a redirect from HTTP to HTTPS, and leverage HTTP/2 on the secure connection directly. 22,000 and 26,000 web pages on desktop and mobile respectively were also found to be on HTTPS but not support HTTP/2. Similarly, hundreds of web pages were incorrectly signaling to upgrade to HTTP/2 despite the connection already on HTTP/2 itself.

## Adoption of HTTP/2

As discussed previously, 2021 saw a 25% increase in HTTP/2 adoption across both first and third party domains. In fact, the vast majority of CDNs have 70% or greater adoption of sites with HTTP/2. This is highlighted with CDNs such as Yottaa, WP Compress and jsDeliver who all have 100% adoption of HTTP/2.

{{ figure_markup(
  image="top-cdns-and-http2-or-above-usage.png",
  caption="Top CDNs and % of pages served over HTTP/2+.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1877391271&format=interactive",
  sheets_gid="1902992488",
  sql_file="http2_3_support_by_cdn_per_page_and_request.sql",
  width=600,
  height=592
  )
}}

On the other hand, some CDNs, including Edgecast, Level 3, CNNetworks, ChinaNetCeneter or Digital Ocean Spaces have little to no adoption of HTTP/2. The high adopters are typically services around ad networks, analytics, content providers, tag managers, and social media services. The higher adoption of HTTP/2 in these services is clear as even at the fifth percentile and above in which at least 50% of them have enabled HTTP/2. At the median, 95% of these services will be using HTTP/2.

{{ figure_markup(
  image="http2-or-above-usage-by-ranking.png",
  caption="HTTP/2+ usage on home page by ranking.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1651314530&format=interactive",
  sheets_gid="366623986",
  sql_file="http2_http3_usage_by_rank.sql"
  )
}}

There is also a direct correlation between a site's page rank in the HTTP archive and its support for HTTP/2. 82% of sites listed in the top 1000 have HTTP/2 enabled. Over 76% in the top 10k websites, followed by 66% of sites in the top 100k, and at least 60% of sites in the top 1 million will have HTTP/2 enabled. This suggests that higher ranking sites have enabled HTTP/2 for the security and performance benefits offered. The higher ranking a site, the more likely it is to have HTTP/2 enabled.

Despite the rapid increase in HTTP/2 usage, split out by web server the adoption figures show a much more fragmented story. If a site uses the Apache HTTP server, it is unlikely to have upgraded to HTTP/2, with only one third of Apache servers leveraging the newer protocol. Nginx shows a more promising number with two thirds of all servers having upgraded to HTTP/2. CDN and cloud servers all promote high adoption rates, from services such as Cloudfront, Cloudflare, Netlify, S3, Flywheel and Vercel. Other niche server implementations such as Caddy or Istio-Envoy also promote good adoption. On the other end of the spectrum, implementations such as IIS, Gunicorn, Passenger, Lighthttpd, and Apache Traffic Server (ATS) all have low adoption rates, with Scuri also reporting almost zero adoption.

{{ figure_markup(
  image="server-software-not-using-http2-or-above.png",
  caption="Server software used by sites not using HTTP/2+.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1494809703&format=interactive",
  sheets_gid="641704944",
  sql_file="count_of_non_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

In fact, of all servers reporting a HTTP/1.1 response, the server with the largest majority at 20%, are Apache servers. As Apache is one of the most popular web servers on the web, it suggests that older installations of Apache may be holding up the web's ability to move forward and adopt the new protocol in full.

## Impact of HTTP/2

Since the introduction of HTTP/2  the median number of TCP connections per page has steadily been decreasing. At the time of this writing desktop connections are down 44% over 12 months to a median value of 16 connections. Mobile is down 7% with a median connection count of 12. This represents a good reduction of connections over time, as the adoption of HTTP/2 has increased sharply since 2020.

{{ figure_markup(
  image="tcp-connections-by-home-page-http-version.png",
  caption="TCP connections by home page HTTP version.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=567187980&format=interactive",
  sheets_gid="1213076952",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
  )
}}

Based on the HTTP Archive data collected, a median HTTP/1.1 site will have 16 connections per page. Then 24 connections at the 75th percentile. This more than doubles to 40 at the 90th percentile for mobile mobile and desktop. By comparison a HTTP/2 site will have 12 connections on average, 21 connections at 75th percentile, and hits 33 connections at the 90th percentile. Even at the top end, this represents a 21% reduction in the number of connections used across websites.

{{ figure_markup(
  image="tcp-connections-per-http-version-by-percentile.png",
  caption="TCP connections per HTTP version by percentile.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=993526405&format=interactive",
  sheets_gid="1213076952",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
  )
}}

TLS adds a slight overhead to performance, and with the de facto implementation of HTTP/2 over HTTPS, there are performance considerations with the versions of TLS used. Since the introduction of [TLS 1.3](https://blogs.windows.com/msedgedev/2016/06/15/building-a-faster-and-more-secure-web-with-tcp-fast-open-tls-false-start-and-tls-1-3/), extra performance considerations have been added, including [TLS false starts](https://blogs.windows.com/msedgedev/2016/06/15/building-a-faster-and-more-secure-web-with-tcp-fast-open-tls-false-start-and-tls-1-3/), which allows the client to start sending encrypted data immediately after the first TLS roundtrip. As well as Zero Round-Trip Time ([0-RTT](https://blog.cloudflare.com/introducing-0-rtt/)) to improve the TLS handshake. TLS 1.2 needs two round-trips to complete TLS handshake, while 1.3 requires only one, which reduces the encryption latency by half. The HTTP Archive data suggests that 34% of desktop clients are using TLS 1.2, while 56% are using TLS 1.3, with the remaining 10% unknown. This is slightly lower on mobile, with 36% using TLS 1.2, 55% using TLS 1.3 and 9% unknown. While the majority of sites use TLS 1.3, a third of sites on the web could leverage an upgrade to receive these performance boosts.

{{ figure_markup(
  image="tls-version-by-http-version.png",
  caption="TLS version used by page HTTP version.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1143806427&format=interactive",
  sheets_gid="135993893",
  sql_file="tls_adoption_by_http_version.sql"
  )
}}

### Reduce headers

Despite the opportunity to compress headers in HTTP/2, the overall number of headers across a website has been increasing.

In terms of the most common response headers received, the top five most common headers are: `date`, `content-type`, `server`, `cache-control` and `content-length` respectively. The most common non-standard header is Cloudflare's `cf-ray`, followed by Amazon's` x-amz-cf-pop `and `X-amz-cf-id`. Outside of content information (length, type, encoding), caching policies (expires, etag,  last-modified) and origin policies (STS, [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin)), <code>[expect-ct](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Expect-CT)</code> reporting certificate transparency and the CSP <code>[report-to](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/report-to)</code> headers are some of the most commonly used headers.

{{ figure_markup(
  image="most-popular-http-response-headers.png",
  caption="Most popular HTTP response headers.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1202666187&format=interactive",
  sheets_gid="160135371",
  sql_file="response_headers_type_usage.sql",
  width=600,
  height=605
  )
}}

The median desktop site has 74 requests and the median mobile site has 69 requests. Hundreds of sites had over thousands of requests per page. The highest in fact reporting 17,923 requests in total, followed by 10,224.

{{ figure_markup(
  image="number-of-http-requests-by-percentile.png",
  caption="Number of HTTP requests by percentile.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=770966381&format=interactive",
  sheets_gid="2107067784",
  sql_file="response_number_and_size.sql"
  )
}}

The median webpage returns 34 KiB worth of headers for desktop and 31KiB for mobile. At the 90th percentile this increases to 98KB and 94KB for desktop and mobile respectively. However, the largest instance of response header was over 5.38MB. Many sites were discovered having over 1MB in response headers. Typically these large response headers are due to overweight `CSP` or `P3P` headers, suggesting the complexities or mismanagement of these headers across websites. In other extreme examples, overweight headers were due to misconfigurations or errors in the application that duplicate multiple `Set-Cookies` or `Cache-Control` settings.

{{ figure_markup(
  image="http-response-header-sizes.png",
  caption="HTTP response header sizes.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=845576315&format=interactive",
  sheets_gid="2107067784",
  sql_file="response_number_and_size.sql"
  )
}}

## Prioritization

Since the introduction of HTTP/2, prioritization has been implemented inconsistently across different parts of the web. Andy Davis has found that this inconsistency may create sub-optimal experiences for users on the web. Often this is because servers will ignore prioritizations and serve based on a first-come first-served behaviour. In fact, [Andy's research highlights](https://github.com/andydavies/http2-prioritization-issues) that many of the major CDNs do not implement HTTP/2 prioritization correctly. This also includes a number of the popular cloud load balancers. The 2021 data suggests similar findings as previous years, with only 6 CDNs implementing prioritization correctly. This includes Akamai, Fastly, Cloudflare, Automattic, section.io and Facebook's own CDN.

Patrick Meehan suggests that outside using one of the CDNs that implement prioritization correctly, there are a number of [TCP optimizations](https://blog.cloudflare.com/http-2-prioritization-with-nginx/), including BBR and tcp_notsent_lowat,  that can be enabled to improve prioritization on the server side.

This inconsistency also exists at the client level, with different browser vendors implementing this behaviour differently. Microsoft's Legacy Edge for example, does not support prioritization. Whereas Safari, implements a static approach to prioritization depending on the asset type, and does not map dependencies. Chrome, Microsoft's Chromium Edge, and Firefox have a more advanced approach to building out logical dependencies across streams and can reprioritize requested assets on the stream based on the discovered prioritization.

{{ figure_markup(
  image="webpagetest-waterfall-example.png",
  caption="WebPageTest waterfall example.",
  description="Screenshot showing...",
  width=938,
  height=715
  )
}}

Since HTTP/2 there has been an updated proposal to priorizations, with the [Extensible Prioritization Scheme for HTTP](https://www.ietf.org/id/draft-ietf-httpbis-priority-07.html) proposal. This includes adding a `priority` header in the response, as well as a new `PRIORITY_UPDATE` frame for HTTP/2. This `PRIORITY_UPDATE` frame is also proposed for HTTP/3. This has yet to be adopted across the web in full, but has received focus from [Cloudflare](https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/) in an effort to improve the underlying behaviour of [prioritization](https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/).


## The death of HTTP/2 Push?

Despite the promises of zero round trips, pre-emptive critical assets and the potential for performance upsides, HTTP/2 push has not lived up to the hype.

{{ figure_markup(
  image="sites-using-http2-push.png",
  caption="Sites using HTTP/2 push.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1819775846&format=interactive",
  sheets_gid="1872576847",
  sql_file="count_of_h2_and_h3_sites_using_push.sql"
  )
}}

When analyzed in 2019 HTTP/2 had little adoption, averaging around 0.5%. The following year in 2020, there was an increase to 0.85% adoption across desktop and 1.06% adoption on mobile. This year in 2021 numbers have slightly increased at 1.03% on desktop, and 1.25% on mobile. Relatively, mobile has seen a significant increase year on year, however at 1.25% overall adoption of HTTP/2 it is still negligible.

{{ figure_markup(
  image="preload-link-nopush=header-usage.png",
  caption="HTTP preload link headers with nopush.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1245853&format=interactive",
  sheets_gid="1461224598",
  sql_file="count_of_preload_http_headers_with_nopush_attribute_set.sql"
  )
}}

At a page level this sits at 64k and 93k for desktop and mobile respectively. In some cases, a developer may want to preload an asset, but decide they do not want to have it delivered via a HTTP/2 push mechanism. They may want to signal to a CDN or other downstream server to not attempt a push, via the <code>[nopush](https://www.w3.org/TR/preload/#server-push-http-2)</code> directive. This year's data shows that over 200,000 preload headers were used, and on average 12% of those were issued with a nopush attribute.

One of the main challenges is to implement dynamic push directives at a page level, where the push messages are formed based on the current page and the critical assets for that page, as opposed to a hardcoded series of pushes that apply as a blanket across the site, such as those that may be defined globally in an [Nginx](https://www.nginx.com/blog/nginx-1-13-9-http2-server-push/) or [Apache](https://httpd.apache.org/docs/2.4/howto/http2.html#push) configuration. Despite implementation examples from [Akamai](https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317) and [Google](https://github.com/guess-js/guess/) that use real user data and analytics to determine this dynamic push configuration, the data shows implementation across the web has been limited. [Akamai](https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317)'s research suggests that when applied correctly, HTTP/2 push provides a clear benefit to web performance.

However, investments made from other CDN providers and server implementations prove that designing for HTTP/2 push is difficult. In fact Jake Archibald described some of [these challenges](https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/) back in 2017. These focus around problems with push cache, browser inconsistencies, and superfluous bytes sent from the server if the client determines the push isn't needed. Attempts to resolve [some](https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-cache-digest#appendix-A) of [these](https://datatracker.ietf.org/doc/html/draft-vkrasnov-h2-compression-dictionaries-03) issues were abandoned, largely due to issues around privacy and security concerns, where cache digests may be used to identify users.

In some cases, servers leverage the `preload` directive as a substitute for HTTP/2 push. In instances where preload is used in the HTML, this still suffers from the overhead of connecting, downloading the base HTML before parsing and seeing the directive. Other examples where preload was used in response headers, often saw too many directives in the one header, which falls victim to the same MTU problems described earlier. Patrick Meehan breaks down some of the [problems](https://blog.cloudflare.com/early-hints/#:~:text=summarized%20server%20push%E2%80%99s%20gotchas) of HTTP/2 push, detailing that PUSH usually ends up delaying HTML and other render blocking assets.

## Pushed assets

In cases where items were pushed, the median size of the bytes that were pushed were 145 KiB for desktop and 48KiB for mobile. This almost doubles to 294KiB for desktop and more than quadruples for mobile at 221KiB for the 75th percentile. At the top end, we see 372KiB pushed and 323KiB for mobile at the 90th percentile.

While these numbers at the 90th percentile appear fine, it's when you start to review the number of pushes, it highlights the misuse of the push feature. The median number of pushes is 4 and 3 across desktop and mobile. This moves to 8 at the 75% percentile, and jumps to 21 and 16 at the 90th percentile. The 100% percentile sees an amazing 517 and 630 pushes being done by some sites, which highlights the misuse of the feature, particularly when considering push was originally designed to advertise a small number of critical assets early in the request.

When analyzing by content type, the data suggests that fonts are the most commonly pushed asset, followed by images, CSS, scripts and video. These numbers paint a different story when looking at the size of the asset types. Fonts are still the largest assets pushed by volume, but scripts come in a close second. This is followed by images, videos and then CSS. Therefore this suggests that despite more CSS files being pushed, they are small in size. Scripts aren't pushed as often as fonts, images and CSS, but represent a larger volume of the push data.

As the numbers above suggest, and as described in previous years, HTTP push is underutilized. When utilized, it is often misused or not used in the intended manner, which is likely to be a performance detriment for the end user.

Google has flagged its intent to remove push from Chrome. However, throughout 2021 there was still [ongoing debate](https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ) around the efficacy of HTTP/2 push. This removal is yet to happen, and it is largely suggested that PUSH can be leveraged through CDNs who implement it correctly. Google recommends leveraging the `&lt;link rel="preload">` directive as an alternative to push, albeit this still incurs a 1 RTT, which is what push aims to solve. Google also [reports](https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ) it has not implemented PUSH in HTTP/3 either, and neither have others such as Cloudflare.

The other commonly suggested alternative is the use of [Early Hints](https://github.com/bashi/early-hints-explainer/blob/main/explainer.md). This works by having the server report a 103 response primarily in the Link header.  Early Hints allows the server to report on assets that the client should preload.


```
HTTP/1.1 103 Early Hints
Link: <style.css>; rel="preload"; as="style"
```

CDNs such as [Fastly](https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code) and [Cloudflare](https://blog.cloudflare.com/early-hints/) have been experimenting with early hints, but it's still early days for Early Hints.  At the time of this writing, Early Hints support in HTTP/2 inside Chrome is still [being worked on](https://bugs.chromium.org/p/chromium/issues/detail?id=671310), and while other browser vendors have announced support for Early Hints, and while Cloudflare has introduced support in the wild, many other vendors have not yet made concrete implementations.

Despite incremental adoption for HTTP/2 push year on year, it is likely that Google and other browser vendors abandon support for push, in favour of alternatives such as Early Hints. Coupled with support from CDNs, Early Hints is likely to be the replacement. Last year, we proposed the question of whether it was a goodbye to HTTP/2 push. This year we suggest that mainstream use of HTTP/2 is dead, at least for the web browsing use case.

## HTTP/3 adoption

Earlier in the chapter we found that sites that were ranked higher had greater adoption of HTTP/2. The opposite is true of HTTP/3. We see less support from the top one thousand sites than we do the top one million, with slightly more support implemented across mobile sites.

{{ figure_markup(
  image="http3-support-by-ranking.png",
  caption="HTTP/3 support on home page by ranking.",
  description="Bar chart showing...",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=197871310&format=interactive",
  sheets_gid="2116042894",
  sql_file="http3_support_by_rank.sql"
  )
}}

Distribution across the top one hundred thousand sites and top one million sites at 18% and 19% for desktop and mobile respectively. This drops to 16% and 17% within the top ten thousand sites. The top one thousand sees 11% and 13% deployment across desktop and mobile. Adoption beyond the top one million sit around 15% for implementation across homepages. Overall this is quite a strong adoption across the board, likely spearheaded by the support from some of the major CDNs. This suggests that while the top websites have adopted HTTP/2 as mainstream, many have yet to explore HTTP/3.

With these numbers in mind, the HTTP/3 landscape is still fragmented. In some cases, HTTP/2 may be used in the initial request, and once the browser discovers the `alt-svc` header, it can then switch protocols and start using HTTP/3. Also, due to connection coalescing (connection reuse), in some instances if two hostnames resolve over DNS to the same IP and use the same TLS certificate and version, then the client could reuse the same connection across both hostnames.  Therefore, it is not uncommon to see a waterfall request with a mix of both HTTP/2 and HTTP/3, depending on the number of hosts and TLS certificates used.

{{ figure_markup(
  image="webpagetest-http2-to-http3-upgrade-example.png",
  caption="WebPageTest waterfall showing HTTP/3 upgrade.",
  description="Screenshot showing...",
  width=1053,
  height=526
  )
}}

{{ figure_markup(
  image="webpagetest-connection-view.png",
  caption="WebPageTest connection view showing HTTP/3 upgrade.",
  description="Screenshot showing...",
  width=959,
  height=237
  )
}}

Protocol negotiation differs in HTTP/3 and requires the `Alt-Svc` header. Due to the several iterations of HTTP/3, this header is also how client and server can decide which version of HTTP/3 they decide on.

At a page level, about 15% of requests will offer an `alt-svc` header. These vary between syntax that offer QUIC, H3 or a H3 version. Some sites will advertise support for multiple versions of QUIC, eg: `quic=":443"; ma=2592000; v="39,43,46,50"`, while some will only offer one version. This style of `alt-svc` is considered the older method, and should not be used. The most common advertisement of the `alt-svc` is `"h3-27=":443"; ma=86400, h3-28=":443"; ma=86400, h3-29=":443"; ma=86400, h3=":443"; ma=86400"`,  across 11% of all `alt-svc` responses. This header instructs clients that it supports H3 versions 27, 28 and 29, with a max-age of 24 hours. In instances where `alt-svc` was present, most sites were appending version numbers as they adopt support for new protocol versions, however there were many cases where sites were using the <code>[clear](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/`alt-svc`)</code> directive to invalidate previously advertised support.

At the time of this writing the most recent version of the [HTTP/3 spec](https://datatracker.ietf.org/doc/html/draft-ietf-quic-http-34) is version 34. However, only 0.01% of responses report this latest version. When viewing details of `alt-svc` at a request level, version 27 is the most commonly requested version in response headers. The server will indicate the preferred versions in order from left to right. 6% of requests will report H3-27 in the first instance preferred, with 28 and 29 as alternate versions offered in the same response.  2% of responses will offer H3-29 as the only preferred version for upgrade. QUIC as the preferred protocol update, receives a mere 0.11%, mostly due to outdated servers reporting this incorrectly.

Most `alt-svc` reported a max-age of only 24 hours, which is the default if not specified. The longest max-age reported for `alt-svc` was 30 days or 2592000 seconds.

{{ figure_markup(
  image="webpagetest-alt-svc-example.png",
  caption="WebPageTest `alt-svc` example.",
  description="Bar chart showing...",
  width=1032,
  height=552
  )
}}

## Support

Web server support for HTTP/3 is still limited in the market. Nginx represents the most common HTTP server on the web, with about two thirds of HTTP/2 sites using a version of Nginx. Nginx has publicly expressed support for HTTP/3, including [discussing their roadmap](https://www.nginx.com/blog/our-roadmap-quic-http-3-support-nginx/) to roll out full support, and aim to have full support by the end of 2021.  The Apache server, by comparison, has yet to provide any guidance on when HTTP/3 will be supported fully. Microsoft has announced support for HTTP/3 in its new [Windows Server 2022](https://blog.workinghardinit.work/2021/10/11/iis-and-http-3-quic-tls-1-3-in-windows-server-2022/). Other alternatives such as the LiteSpeed web server have [leaned into its support](https://docs.litespeedtech.com/cp/cpanel/quic-http3/) for HTTP/3, whereas Caddy has enabled support for HTTP/3 as an [experimental feature](https://caddyserver.com/docs/caddyfile/options) available. Node.js support is [held up](https://github.com/nodejs/node/pull/37067) due to lack of OpenSSL support.

A number of CDNs have also expressed support for HTTP/3. Cloudflare has been experimenting with HTTP/3 [since 2019](https://blog.cloudflare.com/http3-the-past-present-and-future/), in which they report better performance in many examples. Cloudflare have also published their [quiche](https://github.com/cloudflare/quiche) library, which powers their HTTP/3 deployment on the edge network. Fastly has also [discussed its support](https://www.fastly.com/blog/why-fastly-loves-quic-http3) for HTTP/3, and has it available as a [BETA service](https://www.fastly.com/blog/modernizing-the-internet-with-http3-and-quic). Fastly have also open sourced their own implementation known as [quicly](https://github.com/h2o/quicly), designed for the [H2O HTTP](https://h2o.examp1e.net/) server that Fastly uses on their edge network. Akamai has also expressed [continued support](https://www.akamai.com/blog/performance/http3-and-quic-past-present-and-future) for HTTP/3 and QUIC, and has worked with Microsoft to fork a version of [OpenSSL with QUIC](https://github.com/quictls/openssl) to help move support [forward](https://daniel.haxx.se/blog/2021/10/25/the-quic-api-openssl-will-not-provide/).

Browser support for HTTP/3 is still evolving. As of October 2021, support is available in the most recent version of Microsoft Edge, Firefox, Google Chrome, and Opera, and partially across mobile for some Android variants and Opera mobile.  Support from Safari is limited on macOS 11 Big Sur and must be enabled via the "Experimental Features", support for iOS is also only available as an experimental feature behind a flag.

## H3 considerations and concerns

While many of the upsides of HTTP/3 have been discussed, there are also some concerns and criticisms that have been raised. Many developers are only now comfortable with the changes introduced from HTTP/2, after having to roll back many web performance workarounds to overcome the limitations from HTTP/1.1, as those workarounds later became [anti-patterns](http://bit.ly/http2-opt) in HTTP/2.

In some cases, developers and site owners may argue that the incremental gains from HTTP/3 may not be worth major upgrades to their web servers. Particularly when HTTP/3 hasn't solved all the problems identified in HTTP/2, such as prioritization or effective use of server push. As such, adoption may be driven at the CDN level, and not within web applications. This may particularly be the case if some web frameworks may not support HTTP/3, or be blocked by OpenSSL.

As discussed throughout this chapter, QUIC relies on the UDP protocol.  With the introduction of HTTP/3, UDP traffic is due to increase across the web. However, currently UDP is often used as an attack vector, such as those in a [reflection attack](https://blog.cloudflare.com/reflections-on-reflections/). QUIC does have some [protection mechanisms](https://datatracker.ietf.org/doc/html/draft-ietf-quic-transport-27#section-8.1) in place, but this may mean changes to the way UDP is treated across the web, and the amount of UDP traffic allowed on some networks and firewalls. In the same instance, there may be adoption pushback in cases where TCP headers and the unencrypted parts of the packet are used by firewalls and other [middleboxes](https://en.wikipedia.org/wiki/Middlebox) across the web. As QUIC encrypts more parts of the packet, there is less visibility for inspection on the packet, and may limit how these middleboxes operate, including the ability to do additional security checks.

There are also concerns that QUIC may be a performance problem on the server side. This is because of higher CPU requirements needed when dealing with UDP. Some estimates suggest twice as much CPU is needed when compared with HTTP/2. This said, there are a number of attempts to optimize [QUIC CPU performance](https://conferences.sigcomm.org/sigcomm/2020/files/slides/epiq/0%20QUIC%20and%20HTTP_3%20CPU%20Performance.pdf) ongoing.

Despite these concerns, the real benefits will be received from the web's end users. QUIC's ability to maintain connections, when switching network connections, allowing for a mobile-first experience in a mobile-first world. The improvements to head-of-line blocking will also ensure greater gains in page load, where we all now know that [every millisecond](https://ai.googleblog.com/2009/06/speed-matters.html) counts. The enhanced encryption QUIC introduces also allows for a more safe and secure web. As well as the 0-RTT possible with HTTP/3 allows for improved performance.

## Conclusion

Throughout this chapter we have looked at the evolution of HTTP, with a primary focus on the increasing adoption of HTTP/2, and the benefits the newer protocol version offers. This was followed by a closer look at HTTP/3 and how version 3 aims to solve many of the concerns identified after several years of HTTP/2 use across the web.

The HTTP Archive data suggests that this year saw a major uptake in adoption of HTTP/2, with 72% of requests using HTTP/2, and 59% of base HTML pages using HTTP/2. This adoption is largely fueled by increased adoption from CDN providers. HTTP/1.1 is now in the minority across the web.

Despite the uptake on HTTP/2, the push features of HTTP/2 remain underutilized, due to the complexities of implementation, and we suggest that push may be in fact dead on arrival. At the same time we have seen ongoing concerns with resource prioritization, and incorrect implementations outside the major CDN vendors. Complexities with prioritization remain so prevalent that it has been removed from the HTTP/3 specification.

2021 also allowed us to take a closer inspection on the adoption of HTTP/3. Major players such as Google and Facebook have been rolling out their own support for HTTP/3 for a number of years. Wider adoption of HTTP/3 has been influenced by Cloudflare and Fastly who have publicly been working to support HTTP/3 for other parts of the web.

HTTP/3 aims to build upon the improvements of HTTP/2, including the head-of-line blocking imposed by TCP, while also ensuring more parts of the protocol stack are secure with QUIC's tighter encapsulation of TLS 1.3. However, it is still early days for HTTP/3. We look forward to measuring the adoption of HTTP/3 in 2022, and believe it is likely to gain further traction as support for HTTP/2 becomes mainstream and people look to gain further improvements over current deployments.

There are some concerns expressed with HTTP/3, but any of these concerns should be outweighed by performance gained by the end user. It is likely the HTTP/3 adoption will also be fueled by CDN rollouts, as they work towards their own implementations, as we saw with HTTP/2. Particularly we are yet to see implementations across major web frameworks. It is also likely that we will see a mix of HTTP/2 and HTTP/3 over the next several years.
