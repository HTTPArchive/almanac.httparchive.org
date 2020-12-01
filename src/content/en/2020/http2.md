---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: IV
chapter_number: 22
title: HTTP/2
description: HTTP/2 chapter of the 2020 Web Almanac covering adoption and impact of HTTP/2, HTTP/2 Push, HTTP/2 Issues, and HTTP/3.
authors: [dotjs, rmarx, MikeBishop]
reviewers: [LPardue, bazzadp, ibnesayeed]
analysts: [gregorywolf]
translators: []
dotjs_bio: Andrew works at <a href="https://www.cloudflare.com/">Cloudflare</a> helping to make the web faster and more secure. He spends his time deploying, measuring and improving new protocols and asset delivery to improve end-user web site performance.
rmarx_bio: Robin is a web protocol and performance researcher at <a href="https://www.uhasselt.be/edm">Hasselt University, Belgium</a>. He has been working on getting QUIC and HTTP/3 ready to use by creating tools like <a href="https://github.com/quiclog">qlog and qvis</a>.
#MikeBishop_bio: TODO
discuss: 2058
results: https://docs.google.com/spreadsheets/d/1M1tijxf04wSN3KU0ZUunjPYCrVsaJfxzuRCXUeRQ-YU/
queries: 22_HTTP_2
featured_quote: This chapter reviews the current state of HTTP/2 and gQUIC deployment, to establish how well some of the newer features of the protocol, such as prioritization and server push, have been adopted. We then look at the motivations for HTTP/3, describe the major differences between the protocol versions and discuss the potential challenges in upgrading to a UDP-based transport protocol with QUIC.
featured_stat_1: 64%
featured_stat_label_1: Requests served over HTTP/2
featured_stat_2: 31.7%
featured_stat_label_2: CDN Requests with incorrect HTTP/2 prioritiztion
featured_stat_3: 80%
featured_stat_label_3: Pages served over HTTP/2 if a CDN is used, 30% if CDN not used
unedited: true
---

## Introduction

HTTP is an application layer protocol designed to transfer information between networked devices and runs on top of other layers of the network protocol stack. After HTTP/1 was released it took over 20 years until the first major update, HTTP/2, was made a standard in 2015.

It didn’t stop there however: over the last four years, HTTP/3 and QUIC (a new latency reducing, reliable, and secure transport protocol) have been under standards development in the IETF QUIC working group. There are actually two protocols that share the same name: “Google QUIC” (“gQUIC” for short), the original protocol that was designed and used by Google, and the newer IETF standardized version (IETF QUIC/QUIC). IETF QUIC was based on gQUIC, but has grown to be quite different in design and implementation. On October 21, draft 32 of IETF QUIC reached a significant milestone when it moved to [Last Call](https://mailarchive.ietf.org/arch/msg/quic/ye1LeRl7oEz898RxjE6D3koWhn0/). This is the part of the standardisation process when the working group believes they are almost finished and requests a final review from the wider IETF community.

This chapter reviews the current state of HTTP/2 and gQUIC deployment, to establish how well some of the newer features of the protocol, such as prioritization and server push, have been adopted. We then look at the motivations for HTTP/3, describe the major differences between the protocol versions and discuss the potential challenges in upgrading to a UDP-based transport protocol with QUIC.

### HTTP/1.0 to HTTP/2

As the HTTP protocol has evolved the semantics of HTTP have stayed the same, with no changes to the HTTP methods (such as GET or POST), status codes (200, or the dreaded 404), URIs, or header fields. The differences have been the wire-encoding and use of features of  the underlying transport.

HTTP/1.0, published in 1996, defined the text-based application protocol, allowing clients and servers to exchange messages in order to request resources.
A new TCP connection was required for each request/response which introduced overhead. TCP connections use a congestion control algorithm to maximise how much data can be in-flight. This process takes time for each new connection. This "slow-start" means that not all the available bandwidth is used immediately.

In 1997, HTTP/1.1 was introduced to allow TCP connection reuse by adding 'keep-alives', aimed at reducing the total cost of connection start-ups. Over time, increasing website performance expectations led to the need for concurrency of requests. HTTP/1.1 could only request another resource after the previous response had completed. Therefore additional TCP connections had to be established, reducing the impact of the keep-alive connections and further increasing overhead.

HTTP/2, published in 2015, is a binary-based protocol that introduced the concept of bidirectional streams between client and server. Using these streams, a browser can make optimal use of a single TCP connection to **multiplex** multiple HTTP requests/responses concurrently. HTTP/2 also introduced a prioritization scheme to steer this multiplexing; clients can signal a request priority that allows more important resources to be sent ahead of others.

## HTTP/2 Adoption and Impact

The data used in this chapter is sourced from the HTTP Archive and tests over 7 million websites with a Chrome browser.  As with other chapters, the analysis is split by mobile and desktop websites. You can find more details on the [methodology](./methodology). page. When reviewing this data, please bear in mind that each website will receive equal weight regardless of the number of requests. I suggest you think of this more as investigating the trends across a broad range of active websites.

{{ figure_markup(
  image="http2-h2-usage.png",
  alt="HTTP/2 usage by request.",
  link="https://httparchive.org/reports/state-of-the-web#h2",
  caption='HTTP/2 usage by request. (Source: <a href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="Timeseries chart of HTTP/2 usage showing adoption at 64% for both desktop and mobile as of July 2019. The trend is growing steadily at about 15 points per year.",
  width=600,
  height=321
  )
}}

Last year’s analysis of HTTP Archive data showed that HTTP/2 was used for over 50% of requests and, as can be seen, linear growth has continued in 2020; now in excess of 60% of requests are served over HTTP/2.

{{ figure_markup(
  caption="The percentage of requests that use HTTP/2.",
  content="64%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

When comparing Figure 22.3 with last year’s results, there has been a **10% increase in HTTP/2 requests** and a corresponding 10% decrease in HTTP/1 requests. This is the first year that gQUIC can be seen in the dataset.

<figure markdown>
| Protocol | Desktop | Mobile |
| -------- | ------- | ------ |
| HTTP/1.1 | 34.47%** | 34.11% |
| HTTP/2   | 63.70%  | 63.80% |
| gQUIC    | 1.72%   | 1.71%  |

<figcaption>{{ figure_link(caption="HTTP version usage by request.", sheets_gid="2122693316", sql_file="adoption_of_http_2_by_site_and_requests.sql") }}</figcaption>
</figure>

<p class="note">As with last year's crawl, around 4% of desktop requests did not report a protocol version. Analysis shows these to mostly be HTTP/1.1 and we worked to fix this gap in our statistics for future crawls and analysis. Although we base the data on the August 2020 crawl, we confirmed the fix in the October 2020 data set before publication which did indeed show these were HTTP/1.1 requests and so have added them to that statistic in above table.</note>

When reviewing the total number of web site requests, there will be a bias towards common third-party domains. To get a better understanding of the HTTP/2 adoption by server install we will look instead at the protocol used to serve the HTML from the home page of a site.

Last year around 37% of home pages were served over HTTP/2 and 63% over HTTP/1. This year, combining mobile and desktop, it is an equal 50% split with slightly more desktop sites being served over HTTP/2 for the first time, as shown in Figure 22.4.

 <figure markdown>
| Protocol | Desktop | Mobile |
| -------- | ------- | ------ |
| HTTP/1.0 |  0.06%  |  0.05% |
| HTTP/1.1 | 49.22%  | 50.05% |
| HTTP/2   | 49.97%  | 49.28% |

<figcaption>{{ figure_link(caption="HTTP version usage for home pages.", sheets_gid="1447413141", sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql") }}</figcaption>
</figure>

gQUIC is not seen in the home page data for two reasons. To measure a website over gQUIC the HTTP Archive crawl would have to perform protocol negotiation via the [alternative services](#alternative-services) header and then use this endpoint to load the site over gQUIC. This is not supported this year - expect it to be available in next year’s almanac. Also, gQUIC is predominantly used for third-party Google tools rather than serving home pages.

The drive to increase security and privacy on the web has seen requests over TLS increase by over 150% in the last 4 years. Today, over 86% of all requests on mobile and desktop are encrypted. Looking just at web site home pages, the numbers are still an impressive, 78.1% of desktop and 74.7% of mobile. This is important because HTTP/2 is only supported by browsers over TLS. The proportion served over HTTP/2, as shown in Figure 22.5, has also increased 10% from last year, from 55% to 65%.

<figure markdown>
| Protocol | Desktop | Mobile |
| -------- | ------- | ------ |
| HTTP/1.1 | 36.05%  | 34.04% |
| HTTP/2   | 63.95%  | 65.96% |

<figcaption>{{ figure_link(caption="HTTP version usage for TLS home pages.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

With over 60% of web sites being served over HTTP/2 or gQUIC, let’s look a little deeper into the pattern of protocol distribution for all requests made across individual sites.

{{ figure_markup(
  image="http2-h2-or-gquic-requests-per-page.png",
  caption="Compare the distribution of fraction of HTTP/2 requests per page in 2020 with 2019.",
  description="A bar chart of the fraction of HTTP/2 requests by page percentile. The median percentage of HTTP/2 or gQUIC requests per page has increased to 76% in 2020 from 46% in 2019. At the 10, 25, 75, and 90th percentiles, the fraction of HTTP/2 or gQUIC requests per page in 2020 is 5%, 24%, 98% and 100% compared to 3%, 15%, 93% and 100% in 2019.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1328744214&format=interactive",
  sheets_gid="152400778",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

Figure 22.6 shows the fraction of HTTP/2 or gQUIC requests per page, ordered by percentile, for this year compared to last year. The most noticeable change is that over half of sites now have 75% or more of their requests served over HTTP/2 or gQUIC compared to 46% last year. Less than 7% of sites make no HTTP/2 or gQUIC requests, while (only) 10% of sites are entirely HTTP/2 or gQUIC requests.

What about the breakdown of the page itself? We typically talk about the difference between first-party and third-party content. Third-party is defined as content not within the direct control of the site owner; providing functionality such as advertising, marketing or analytics. The definition of known third parties is taken from the [third party web](https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5) repository.

Figure 22.7 orders every web site by the fraction of HTTP/2 requests for known third parties or first party requests compared to other requests. There is a noticeable difference as over 40% of all sites have no first-party HTTP/2 or gQUIC requests at all. By contrast, even the lowest 5% of pages have 30% of third-party content served over HTTP/2. This indicates that a large part of HTTP/2’s broad adoption is driven by the third parties.

{{ figure_markup(
  image="http2-first-and-third-party-http2-usage.png",
  caption="The distribution of the fraction of third-party and first-party HTTP/2 requests per page.",
  description="A line chart comparing the fraction of first-party HTTP/2 requests with third-party HTTP/2 or gQUIC requests. The chart orders he web sites by fraction of HTTP/2 requests. 45% of web sites have no HTTP/2 first-party requests. Over half of web sites serve third-party requests only over HTTP/2 or gQUIC. 80% of web sites have 76% or more third-party HTTP/2 or gQUIC requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1409316276&format=interactive",
  sql_file="http2_%_1st_party_vs_3rd_party.sql",
  sheets_gid="733872185"
)
}}

Figure 22.8 shows the distribution of known third-party HTTP/2 or gQUIC requests by content-type. For example 90% of websites serve 100% of third party fonts and audio over HTTP/2 or gQUIC, only 5% over HTTP/1 and 5% are a mix. The majority of third-party assets are either scripts or images, and are solely served over HTTP/2 or gQUIC on 60% and 70% of web sites respectively.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-content-type.png",
  caption="The fraction of known third-party HTTP/2 or gQUIC requests by content-type per web site.",
  description="A bar chart comparing the fraction of third-party HTTP/2 requests by content-type. All third-party requests are served over HTTP/2 or gQUIC for 90% of audio and fonts, 80% of css and video, 70% of html, image and text and 60% of scripts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1264128523&format=interactive",
  sheets_gid="419557288",
  sql_file="http2_%_1st_party_vs_3rd_party_by_type.sql"
)
}}

Figure 22.9 looks at protocol usage by the third party category. Ads, analytics, Content Delivery Network resources (CDN), and tag-managers are predominantly served over HTTP/2 or gQUIC. Customer-success and marketing content is more likely to be served over HTTP/1.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-category.png",
  caption="The fraction of known third-party HTTP/2 or gQUIC requests by category per web site.",
  description="A bar chart comparing the fraction of third-party HTTP/2 or gQUIC requests by category. All third-party requests for all web sites are served over HTTP/2 or gQUIC for 95% of tag managers, 90% of analytics and CDN, 80% of ads, social, hosting and utility, 40% of marketing and 30% of customer-success.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1419102835&format=interactive",
  sheets_gid="1059610651",
  sql_file="http2_3rd_party_by_types.sql"
)
}}

### HTTP/2 Server support

Browser auto-update mechanisms are a driving factor for client-side adoption of new Web standards. It’s [estimated](https://caniuse.com/http2) that over 97% of global users support HTTP/2, up slightly from 95% measured last year.

Unfortunately, the upgrade path for servers is more difficult, especially with the requirement to support TLS. For mobile and desktop, Figure 22.10 shows the breakdown of HTTP server headers returned for sites that support HTTP/2 and HTTP/1.

{{ figure_markup(
  image="http2-server-protocol-usage.png",
  caption="Server usage by HTTP protocol on mobile",
  description="A bar chart showinging the number of web sites served by either HTTP/1 or HTTP/2 for the most popular servers to mobile clients. Nginx serves 727,181 HTTP/1 and 727,181 HTTP/2 sites. Cloudflare 59,981 HTTP/1 and 679,616 HTTP/2. Apache 1,521,753 HTTP/1 and 585,096 HTTP/2. Litespeed 50,502 HTTP/1 and 166,721 HTTP/2. Microsoft-IIS 284,047 HTTP/1 and 81,490 HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=718663369&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
)
}}

The majority of HTTP/2 sites are served by nginx, Cloudflare, and Apache. Almost half of the HTTP/1.1 sites are served by Apache.

How has HTTP/2 adoption changed in the last year for each server. Figuure 22.11 shows the percentage of server installs that use HTTP/2 in 2019 and 2020. We see a general adoption increase of around 10% across all servers. Apache and IIS are still under 25% HTTP/2. This suggests that either new servers tend to be nginx or it is seen as too difficult or not worthwhile to upgrade Apache or IIS to HTTP/2 and/or TLS.

{{ figure_markup(
  image="http2-h2-usage-by-server.png",
  caption="Percentage of pages served over HTTP/2 by sever",
  description="A bar chart comparing the percentge of web sites served over HTTP/2 between 2019 and 2020. Cloudflare increased to 93.08% from 85.40%. Litespeed increased to 81.91% from 70.80%. Openresty increased to 66.24% from 51.40%. Nginx increased to 60.84% from 49.20%. Apache increased to 27.19% from 18.10% and MIcorsoft-IIS increased to 22.82% from 14.10%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=936321266&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

A long-term recommendation to improve website performance has been to use a Content Delivery Network (CDN). The benefits are a reduction in latency by both serving content and terminating connections closer to the end user. This helps mitigate the rapid evolution in protocol deployment and the additional complexities in tuning servers and operating systems (see the prioritization section for more details for HTTP/2). To utilise the new protocols effectively, using a CDN can be seen as the recommended approach.

CDNs can be classed in two broad categories. The first category directly serves the home page and/or asset subdomains. Examples are the larger generic CDNs (such as Cloudflare, Akamai, or Fastly) and the more specific (such as Wordpress or Netlify). Looking at the difference in HTTP/2 adoption rates for home pages served with or without a CDN, we see:

- **80%** of mobile home pages are served over HTTP/2 if a CDN is used
- **30%** of mobile home pages are served over HTTP/2 if a CDN is not used

Figure 22.12 shows the percentage of HTTP/2 requests served by the first-party CDNs over mobile.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="colgroup" class="no-wrap">HTTP/2 (%)</th>
        <th scope="colgroup">CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>100%</td>
        <td>Bison Grid, CDNsun, LeaseWeb CDN, NYI FTW, QUIC.cloud, Roast.io, Sirv CDN, Twitter, Zycada Networks</td>
      </tr>
      <tr>
        <td>90 - 99%</td>
        <td>Automattic, Azion, BitGravity, Facebook, KeyCDN, Microsoft Azure, NGENIX, Netlify, Yahoo, section.io, Airee, BunnyCDN, Cloudflare, GoCache, NetDNA, SFR, Sucuri Firewall</td>
      </tr>
      <tr>
        <td>70 - 89%</td>
        <td>Amazon CloudFront, BelugaCDN, CDN, CDN77, Erstream, Fastly, Highwinds, OVH CDN, Yottaa, Edgecast, Myra Security CDN, StackPath, XLabs Security</td>
      </tr>
      <tr>
        <td>20 - 69%</td>
        <td>Akamai, Aryaka, Google, Limelight, Rackspace, Incapsula, Level 3, Medianova, OnApp, Singular CDN, Vercel, Cachefly, Cedexis, Reflected Networks, Universal CDN, Yunjiasu, CDNetworks</td>
      </tr>
      <tr>
        <td> < 20%</td>
        <td>Rocket CDN, BO.LT, ChinaCache, KINX CDN, Zenedge, ChinaNetCenter </td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Percentage of HTTP/2 requests served by the first-party CDNs over mobile.", sheets_gid="781660433", sql_file="cdn_detail_by_cdn.sql") }}</figcaption>
</figure>

The second category are CDNs which are mainly used to serve third-party content. This content is typically shared resources (JavaScript or font CDNs), advertisements, or analytics. In all these cases, using a CDN will improve the performance and offload for the various SaaS solutions.

{{ figure_markup(
  image="http2-cdn-http2-usage.png",
  caption="Comparsion of HTTP/2 and gQUIC usage for websites using a CDN.",
  description="A line chart comparing the fraction of reqests served using HTTP/2 or gQUIC for web sites that use a CDN compared to sites that do not. The x-axis show the percentiles of web page ordered by percentage of requests. 23% of web sites that do not use a CDN have no HTTP/2 or gQUIC usage. In comparision the 60% of web sites using a CDN have all HTTP/2 or gQUIC usage. 93% of web sites that use a CDN and 47% of non-CDN sites have 50% or more HTTP/2 or gQUIC usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1779365083&format=interactive",
  sheets_gid="1457263817",
  sql_file="cdn_summary.sql"
)
}}

Figure 22.13 shows the difference in HTTP/2 and gQUIC adoption when a web site is using a CDN. 70% of pages use HTTP/2 for all 3rd party requests when a CDN is used. Without a CDN, only 25% of pages use HTTP/2 for all third party requests.

Figure 22.14 shows the breakdown of HTTP/2 responses for 3rd party CDNs for mobile requests.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="colgroup" class="no-wrap">HTTP/2 and gQUIC (%)</th>
        <th scope="colgroup">Third-party resource CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>100%</td>
        <td>Bison Grid, Hosting4CDN, MediaCloud, NYI FTW, PageCDN, Pressable CDN, QUIC.cloud, Roast.io, SwiftyCDN, Zycada Networks</td>
      </tr>
      <tr>
        <td>90 - 99%</td>
        <td>Advanced Hosters CDN, Azion, CDN77, Facebook, GoCache, ImageEngine, KeyCDN, Microsoft Azure, NetDNA, Netlify, Nexcess CDN, Reapleaf, Sirv CDN, Twitter, jsDelivr, section.io, Airee, BunnyCDN, Cloudflare, Erstream, Internap, LeaseWeb CDN, Medianova, Myra Security CDN, NGENIX, OnApp, SFR, StackPath, Sucuri Firewall, TRBCDN, VegaCDN, Yottaa</td>
      </tr>
      <tr>
        <td>70 - 89%</td>
        <td>Amazon CloudFront, BelugaCDN, CDN, CDN77, Erstream, Fastly, Highwinds, OVH CDN, Yottaa, Edgecast, Myra Security CDN, StackPath, XLabs Security</td>
      </tr>
      <tr>
        <td>20 - 69%</td>
        <td>Akamai, Aryaka, Google, Limelight, Rackspace, Incapsula, Level 3, Medianova, OnApp, Singular CDN, Vercel, Cachefly, Cedexis, Reflected Networks, Universal CDN, Yunjiasu, CDNetworks</td>
      </tr>
      <tr>
        <td> < 20%</td>
        <td>Rocket CDN, BO.LT, ChinaCache, KINX CDN, Zenedge, ChinaNetCenter </td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Percentage of HTTP/2 requests served by the third-party resouce CDNs over mobile", sheets_gid="781660433", sql_file="cdn_detail_by_cdn.sql") }}</figcaption>
</figure>

## How is HTTP/2 performing ?

{# TODO add intro to avoid empty header #}

### Reducing connectons

As discussed earlier, HTTP/1.1 only allowed a single request at a time over a TCP connection. Most browsers got around this by allowing 6 parallel connections per host. The major improvement with HTTP/2 is that multiple requests can be multiplexed over a single TCP connection.  This should reduce the total number of connections, and the associated time and resources required, to load a page.

{{ figure_markup(
  image="http2-total-number-of-connections-per-page.png",
  caption="Distriution of total number of connections per page",
  description="A percentile chart of total connections, comparing 2016 with 2020. The median number of connections in 2016 is 23, in 2020 it is 13. At the 10th percentile, 6 connections in 2016, 5 in 2020. At the 25th percentile, 12 connections in 2016, 8 in 2020. At 75th percentile - 43 connections in 2016, 20 in 2020. At 90th percentile 76 connections in 2016 and 33 in 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=17394219&format=interactive",
  sheets_gid="1432183252",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
)
}}

Figure 22.15 shows a percentile distribution of the number of TCP connections per page in 2020 compared with 2016. Half of all websites now use 13 or fewer TCP connections in 2020 compared with 23 connections in 2016; a 44% decrease. In the same time period the number of requests has only dropped from 74 to 73. The median number of requests per TCP connection has increased from 3.2 to 5.6.

TCP was designed to maintain an average data flow which is both efficient and fair.
Think of a flow control process, where each flow exerts pressure on the other flows to signal to provide a fair share of the network and be responsive to the pressure from all other flows.  In a fair protocol every TCP session does not crowd out any other session and over time will take 1/N of the path capacity.

The majority of websites still open over 15 TCP connections. In HTTP/1.1, the 6 connections a browser could open to a domain can over time claim six times as much bandwidth as a single HTTP/2 connection. Over low capacity networks this can slow down the delivery of content from the primary asset domains as the number of contending connections increases and takes bandwidth away from the important requests. This favours websites with a small number of third-party domains.

HTTP/2 does allow for connection reuse ([Section 9.1.1](https://tools.ietf.org/html/rfc7540#section-9.1)) across different, but related, domains. For a TLS resource, it requires a certificate that is valid for the host in the URI. This can be used to reduce the number of connections required for domains under the control of the site author.

### HTTP/2 prioritization

As HTTP/2 responses can be split into many individual frames, and as frames from multiple streams can be multiplexed, the order in which the frames are interleaved and delivered by the server becomes a critical performance consideration. A typical website consists of many different types of resources: the visible content (HTML, CSS, images), the application logic (JavaScript), ads, analytics for tracking site usage, and marketing tracking beacons. With knowledge of how a browser works, an optimal ordering of the resources can be defined that will result in the fastest user experience (and the difference between optimal and non-optimal can be significant - as much as a 50% improvement or more).

HTTP/2 introduced the concept of prioritization to help the client communicate to the server how it thinks the multiplexing should be done. Every stream is assigned a weight (how much of the available bandwidth the stream should be allocated) and possibly a parent (another stream which should be delivered first). With the flexibility of HTTP/2’s prioritization model, it is not altogether surprising that all of the current browser engines implemented [different prioritization strategies](https://calendar.perfplanet.com/2018/http2-prioritization/), none of which are [optimal](https://www.youtube.com/watch?v=nH4iRpFnf1c).

There are also problems on the server side, leading to many servers either implementing prioritization poorly or not at all.  In the case of HTTP/1.x, tuning the server-side send buffers to be as big as possible has no downside other than the increase in memory use (trading off memory for CPU) and is an effective way to increase the throughput of a web server. This is not true for HTTP/2, as data in the TCP send buffer cannot be re-prioritized if a request for a new, more important resource comes in.  For an HTTP/2 server, the optimal send buffer size is thus the minimum amount of data required to fully utilize the available bandwidth. This allows the server to respond immediately if a higher-priority request is received.

This problem of large buffers messing with (re-)prioritization also exists in the network where it goes by the name “bufferbloat”.  Network equipment would rather buffer packets than drop them when there’s a short burst.  However, if the server sends more data than the path to the client can consume, these buffers fill to capacity. These bytes already “stored” on the network limit the server’s ability to send a higher-priority response earlier, just as a large send buffer does. To minimize the amount of data held in buffers, [a recent congestion control algorithm such as BBR should be used](https://blog.cloudflare.com/http-2-prioritization-with-nginx/).

This [test suite](https://github.com/andydavies/http2-prioritization-issues) measures and reports how various CDN/Cloud Hosting services perform. The bad news is that only 9 of the 36 prioritize correctly. Figure 22.16 shows that for sites using a CDN, around 31.7% do not prioritize correctly. This is up from 26.82% last year, mainly due to the increase in Google CDN usage. Rather than relying on the browser-sent priorities, there are some servers that implement a [server side prioritization](https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/) scheme instead, improving upon the browser’s hints with additional logic.

<figure markdown>
| CDN               | Prioritize correctly | Desktop | Mobile |
|-------------------|---------|--------|--------|
| Not using CDN     | Unknown | 59.47% | 60.85% |
| Cloudflare        | Pass    | 22.03% | 21.32% |
| Google            | Fail    | 8.26%  | 8.94%  |
| Amazon CloudFront | Fail    | 2.64%  | 2.27%  |
| Fastly            | Pass    | 2.34%  | 1.78%  |
| Akamai            | Pass    | 1.31%  | 1.19%  |
| Automattic        | Pass    | 0.93%  | 1.05%  |
| Sucuri Firewall   | Fail    | 0.77%  | 0.63%  |
| Incapsula         | Fail    | 0.42%  | 0.34%  |
| Netlify           | Fail    | 0.27%  | 0.20%  |

<figcaption>{{ figure_link(caption="HTTP/2 prioritization support in common CDNs.", sheets_gid="1152953475", sql_file="percentage_of_h2_and_h3_sites_affected_by_cdn_prioritization.sql") }}</figcaption>
</figure>

For non-CDN usage, I expect the number of servers that correctly apply HTTP/2 prioritization to be considerably smaller. For example, [NodeJS’s HTTP/2 implementation does not even support prioritization](https://twitter.com/jasnell/status/1245410283582918657).

{# TODO consider rewording to come across as less of a dig. Or at least removing the word "even" #}

### Goodbye Server push?

Server Push was one of the additional features of HTTP/2 that caused some confusion and  complexity to implement in practice. Push seeks to avoid waiting for a browser/client to download a HTML page, parse that page, and only then discover that it requires additional resources (such as a stylesheet), which in turn have to be fetched and parsed to discover even more dependencies (such as fonts). All that work and round trips takes time.  With server push, in theory, the server can just send multiple responses at once, avoiding the extra round trips.

Unfortunately, with TCP congestion control in play, the data transfer starts off so slowly that [not all the assets can be pushed until multiple round trips have increased the transfer rate sufficiently](https://calendar.perfplanet.com/2016/http2-push-the-details/). There are also [implementation differences](https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/) between browsers as the client processing model had not been fully agreed. For example, each browser has a different implementation of a ‘push cache’.

Another issue is that the server is not aware of resources the browser has already cached. When a server tries to push something that is unwanted, the client can send a RST_STREAM frame but by the time this has happened, the server may well have already sent all the data.  This wastes bandwidth, and the server has lost the opportunity of immediately sending something that the browser actually did require. There were [proposals](https://tools.ietf.org/html/draft-ietf-httpbis-cache-digest-05) to allow clients to inform the server of their cache status, but these suffered from privacy concerns.

As can be seen from the FIgure 20.17 below, a very small percentage of sites use server push.

<figure markdown>
 Client  | HTTP/2 pages | HTTP/2 (%) | gQUIC pages | gQUIC (%) |
| ------- | ----------------------- | --------------------------- | ----------------------- | --------------------------- |
| Desktop |  44,257                 | 0.85%                       | 204                 | 0.04%                       |
| Mobile  |  62,849                 | 1.06%                       | 326                 | 0.06%                       |

<figcaption>{{ figure_link(caption="Pages using HTTP/2 or gQUIC server push.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_avg_bytes.sql") }}</figcaption>
</figure>

Looking further at the distributions for pushed assets in Figures 22.18 and 22.19, half of the sites push 4 or fewer resources with a total size of 140 KB on desktop and 3 or less resources with a size of 184 KB on mobile. For gQUIC, desktop is 7 or fewer and mobile 2. The worst offending page pushes 41 assets over gQUIC on desktop.

<figure markdown>
| Percentile |  HTTP/2 | Size (KB)  | gQUIC | Size (KB) |
|------------|--------------------|----------------------| ------------------ | --------------------- |
| 10         | 1                  | 3.95                 | 1                  | 15.83                |
| 25         | 2                  | 36.32                | 3                  | 35.93                |
| 50         | 4                  | 139.58               | 7                  | 111.96               |
| 75         | 8                  | 346.70               | 21                 | 203.59               |
| 90         | 17                 | 440.08               | 41                 | 390.91               |

<figcaption>{{ figure_link(caption="Distribtion of pushed assets on desktop.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_avg_bytes.sql") }}</figcaption>
</figure>

<figure markdown>
| Percentile |  HTTP/2 | Size (KB)  | gQUIC | Size (KB) |
|------------|--------------------|----------------------|------------------------|----------------------|
| 10         | 1                  | 15.48                | 1                      | 0.06                 |
| 25         | 1                  | 36.34                | 1                      | 0.06                 |
| 50         | 3                  | 183.83               | 2                      | 24.06                |
| 75         | 10                 | 225.41               | 5                      | 204.65               |
| 90         | 12                 | 351.05               | 18                     | 453.57               |

<figcaption>{{ figure_link(caption="Distribtion of pushed assets on mobile.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_avg_bytes.sql") }}</figcaption>
</figure>


Looking at the frequency of push by content type in Figure 22.20, we see 89% of pages push scripts and 68% push CSS. This makes sense, as these can be small files typically on the critical path to render a page.

{{ figure_markup(
  image="http2-pushed-content-types.png",
  caption="Percentage of pages pushing specific content types",
  description="A bar chart showing for pages that push resourcs 89.1% push scripts, 67.9 css, 6.1% images, 1.3% fonts, 0.7% other and 0.7% html.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1708672642&format=interactive",
  sheets_gid="238923402",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql"
)
}}

Figures 22.21 and 22.22 show how the number of pushed resources and their size varies by content type. At the top end, there are examples of 20+ images and around 30 CSS and font files being pushed over mobile.

<figure markdown>
| Percentile | css | font | html | image | script | video |
| ---------- | --- | ---- | ---- | ----- | ------ | ----- |
| 10         | 2   | 11   | 2    | 2     | 2      | 1     |
| 25         | 2   | 12   | 3    | 2     | 2      | 1     |
| 50         | 4   | 14   | 4    | 4     | 4      | 1     |
| 75         | 16  | 20   | 4    | 11    | 8      | 1     |
| 90         | 29  | 32   | 4    | 24    | 23     | 1     |

<figcaption>{{ figure_link(caption="Distribtion of number pushed asset by content type on mobile.", sheets_gid="238923402", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql") }}</figcaption>
</figure>

Pushing of video dominates the higher percentiles of bandwidth use. This can however really negatively impact page performance by contending with the other resources required to render the page.

<figure markdown>
|  Percentile   | css   | font   | html | image  | script | video  |
| ------------- | ----- | ------ | ---- | ------ | ------ | ------ |
| 10            | 21.1  | 784.7  | 1.5  | 4.1    | 4.0    | 3444.3 |
| 25            | 51.0  | 811.6  | 23.0 | 9.7    | 36.4   | 3444.3 |
| 50            | 105.7 | 916.0  | 78.2 | 61.3   | 165.5  | 3444.3 |
| 75            | 204.2 | 983.6  | 81.1 | 501.2  | 344.8  | 3444.3 |
| 100           | 316.3 | 1237.6 | 83.3 | 2770.7 | 603.0  | 3444.3 |

<figcaption>{{ figure_link(caption="Distribtion of pushed asset sizes (KB) by content type on mobile.", sheets_gid="238923402", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql") }}</figcaption>
</figure>

Given the low adoption and after measuring how few of the pushed resources are actually useful (match a request that is not already cached), Google has announced the [intent to remove push support from Chrome]( https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ) for both HTTP/2 and gQUIC. Chrome have also not implemented push for HTTP/3.

Despite all these problems, there are circumstances where server push can provide an improvement. The ideal use case is to be able to send a push promise much earlier than the HTML response itself. A scenario where this can benefit is [when a CDN is in use](https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317). The 'dead-time' between the CDN receiving the request and receiving a response from the origin can be used intelligently to warm up the TCP connection and push assets already cached at the CDN.

There was however no standardized method for how to signal to a CDN edge server that an asset should be pushed. Implementations instead reused the preload HTTP link header to indicate this.  This simple approach appears elegant but does not utilise the ‘dead time’ before the HTML is generated unless the headers are sent before the actual content is ready. It triggers the edge to push resources as the HTML is received at the edge which will contend with the  delivery of the HTML.

An alternative proposal being tested is [RFC 8297](https://tools.ietf.org/html/rfc8297) which defines an informative HTTP 103 Early Hints response.  This permits headers to be sent immediately, without having to wait for the server to generate the full response headers.  This can be used by an origin to suggest pushed resources to a CDN, or by a CDN to alert the client to resources that need to be fetched. However, at present, support of this from both a client and server perspective is very low, [but growing](https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code).

## Getting to a better protocol

Let’s say a client and server support both HTTP/1.1 and HTTP/2. How do they choose which one to use? The most common method is TLS Application Layer Protocol Negotiation (ALPN), where clients send a list of protocols they support to the server and it picks the one it prefers to use for that connection.  Because the browser needs to negotiate the TLS parameters as part of setting up an HTTPS connection, it can also negotiate the HTTP version at the same time. Since both HTTP/2 and HTTP/1.1 can be served from the same TCP port (443), browsers don’t need to make this selection before opening a connection.

This doesn’t work if the protocols aren’t on the same port, use a different transport protocol (TCP vs QUIC), or if you’re not using TLS. For those scenarios, you start with whatever is available on the first port you connect to, then discover other options.  HTTP defines two mechanisms to change protocols for an origin after connecting.

### Upgrade

The Upgrade header has been part of HTTP for a long time.  In HTTP/1.x, Upgrade allows a client to make a request using one protocol, but indicate its support for another protocol (like HTTP/2).  If the server also supports the offered protocol, it responds with a status 101 (Switching Protocols) and proceeds to answer the request in the new protocol.  If not, the server answers the request in HTTP/1.x.  Servers can advertise their support of a different protocol using an Upgrade header on a response.

The most common application of Upgrade is Websockets.  HTTP/2 also defines an Upgrade path, for use with its unencrypted cleartext mode.  There is no support for this capability in web browsers however.  Therefore, it’s not surprising that less than 3% of HTTP/1.1 requests in our dataset received an Upgrade header in the response.  A very small number (0.0011% of HTTP/2, 0.064% of HTTP/1.1) of requests using TLS also received Upgrade headers in response; these are likely cleartext HTTP/1.1 servers behind intermediaries which speak HTTP/2 and/or terminate TLS, but don’t properly remove Upgrade headers.

### Alternative Services

Alternative Services (Alt-Svc) enables an HTTP origin to indicate other endpoints which serve the same content, possibly over different protocols.  Although uncommon, HTTP/2 might be located at a different port or different host from a site’s HTTP/1.1 service.  More importantly, since HTTP/3 uses QUIC (hence UDP) where prior versions of HTTP use TCP, HTTP/3 will always be at a different endpoint from the HTTP/1.x and HTTP/2 service.

When using Alt-Svc, a client makes requests to the origin as normal.  However, if the server includes a header (or sends a frame) containing a list of alternatives, the client can make a new connection to the other endpoint and use it for future requests to that origin.

Unsurprisingly, Alt-Svc usage is found almost entirely from services using advanced HTTP versions:  12.0% of HTTP/2 requests and 60.1% of gQUIC requests received an Alt-Svc header in response, as compared to 0.055% of HTTP/1.x requests. Note that our methodology here only captures Alt-Svc headers, not ALTSVC frames, so reality might be slightly understated.

While Alt-Svc can point to an entirely different host, support for this capability varies among browsers. Only 4.71% of Alt-Svc headers advertised an endpoint on a different hostname; these were almost universally (99.5%) advertising gQUIC and HTTP/3 support on Google Ads.  Google Chrome ignores cross-host Alt-Svc advertisements for HTTP/2, so many of the other instances would have been ignored.

Given the rarity of support for cross-host HTTP/2, it’s not surprising that there were virtually no (0.007%) advertisements for HTTP/2 endpoints using Alt-Svc.  Alt-Svc was typically used to indicate support for HTTP/3 (74.6% of Alt-Svc headers) or gQUIC (38.7% of Alt-Svc headers).

## Looking Toward the Future:  HTTP/3

As discussed above, HTTP/2 is a powerful protocol which has found considerable adoption in just a few years. However, HTTP/3 over QUIC is already peeking around the corner! Over 4 years in the making, this next version of HTTP is almost standardized at the IETF (expected in the first half of 2021). At this time, there are already [many QUIC and HTTP/3 implementations available](https://github.com/quicwg/base-drafts/wiki/Implementations), both for servers and browsers. While these are relatively mature, they can still be said to be in an experimental state.

This is reflected by the usage numbers in the HTTP Archive data, where no HTTP/3 requests were identified at all. This might seem a bit strange, since [Cloudflare](https://blog.cloudflare.com/experiment-with-http-3-using-nginx-and-quiche/) has had experimental HTTP/3 support for some time, as have Google and Facebook. This is mainly because Chrome hadn’t enabled the protocol by default when the data was collected.

However, even the numbers for the older gQUIC are relatively modest, accounting for less than 2% of requests overall. This is expected, since gQUIC was mostly deployed by Google and Akamai; other parties were waiting for IETF QUIC. As such, gQUIC is expected to be replaced entirely by HTTP/3 soon.

{{ figure_markup(
  caption="The percentage of requests that use gQUIC on desktop and mobile",
  content="1.72%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

It’s important to note that this low adoption only reflects gQUIC and HTTP/3 usage for loading Web pages. For several years already, Facebook has had a much more extensive deployment of IETF QUIC and HTTP/3 for loading data inside of its native applications. [QUIC and HTTP/3 already make up over 75% of their total internet traffic](https://engineering.fb.com/2020/10/21/networking-traffic/how-facebook-is-bringing-quic-to-billions/). It is clear that HTTP/3 is only just getting started!

Now you might wonder: if not everyone is already using HTTP/2, why would we need HTTP/3 so soon? What benefits can we expect in practice? Let’s take a closer look at its internal mechanisms.

### Why do we need QUIC and HTTP/3?

Past attempts to deploy new transport protocols on the internet have proven difficult, see SCTP for an example. QUIC is a new transport protocol that runs on top of UDP. It provides similar features to TCP such as reliable in-order delivery, and congestion control to prevent flooding the network.

We’ve discussed above that HTTP/2 **multiplexes** multiple different streams on top of one connection. TCP itself is woefully unaware of this fact, leading to inefficiencies or performance impact when packet loss or delays occur. More detail on this Head-of-Line blocking problem [can be found here](https://github.com/rmarx/holblocking-blogpost).

QUIC solves the “TCP **Head-of-Line blocking** problem” (HOL blocking) by bringing HTTP/2’s streams down into the transport layer and performing per-stream loss detection and retransmission. So then we just put HTTP/2 over QUIC right? Well we've already mentioned some of the difficulties arising from having flow control in TCP and HTTP/2. Running two separate and competing streaming systems on top of eachother would be an additional problem. Furthermore, because the QUIC streams are independent, it would mess with the strict ordering requirements HTTP/2 requires for several of its systems.

In the end, it was deemed easier to define a new HTTP version that uses QUIC directly and thus, HTTP/3 was born. **Its high-level features are very similar to those we know from HTTP/2, but internal implementation mechanisms are quite different**. HPACK header compression is replaced with QPACK, which allows [manual tuning of the compression efficiency vs HOL blocking risk tradeoff](https://blog.litespeedtech.com/tag/quic-header-compression-design-team/), and the prioritization system is being [replaced by a simpler one](https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/). The latter could also be back-ported to HTTP/2, possibly helping resolve the prioritization issues discussed earlier in this article. HTTP/3 continues to provide a server push mechanism but, as already mentioned, Chrome for example does not implement it.

Another benefit of QUIC is that it is able to **“migrate” connections** and keep them alive even when the underlying network changes. A typical example is the so-called “parking lot problem”. Imagine your smartphone is connected to the workplace Wi-Fi network and you’ve just started downloading a large file. As you leave Wi-Fi range your phone automatically switches to the fancy new 5G cellular network. With plain old TCP, the connection would break and cause an interruption. But QUIC is smarter, it uses a “Connection ID” which is more robust to network changes and provides an active Connection Migration feature for clients to switch without interruption.

Finally, TLS (the Transport Layer Security protocol) is already used to protect HTTP/1.1 and HTTP/2.  QUIC, however, has a **deep integration of TLS 1.3**, protecting both HTTP/3 data and QUIC packet metadata such as packet numbers. Using TLS in this way improves end-user privacy and security and makes continued protocol evolution easier. Combining the transport and cryptographic handshakes means that connection setup takes just a single RTT, compared to TCP’s minimum of 2 and worst case of 4. In some cases, QUIC can even go one step further and send HTTP data along with its very first message, which is called “**0-RTT**”. These fast connection setup times are expected to really help HTTP/3 outperform HTTP/2. We discuss this in more detail below.

#### So will HTTP/3 help?

In conclusion, on the surface HTTP/3 is not really all that different from HTTP/2. It doesn’t really add major new features, but mainly changes how the existing ones work under the surface. The real improvements come from QUIC, which offers faster connection setups, increased robustness and resilience to packet loss. As such, HTTP/3 is expected to do better than HTTP/2 on worse networks, while offering very similar performance on faster systems. However, that is if we can get HTTP/3 working, which can be challenging in practice.

### Deploying and discovering QUIC and HTTP/3

Since QUIC and HTTP/3 run over UDP things aren't as simple as with HTTP/1.1 or HTTP/2. Typically an HTTP/3 client has to first discover that QUIC is available at the server. The recommended method for this is HTTP Alternative Services, as described earlier. On its first visit to a website, a client connects to a server using TCP. It then discovers via Alt-Svc that HTTP/3 is available, and can set up a new QUIC connection. The Alt-Svc entry can be cached, allowing subsequent visits to avoid the TCP step, but the entry will eventually become stale and need revalidation. This likely will have to be done for each domain separately, which will probably lead to most page loads using a mix of HTTP/1, HTTP/2 and HTTP/3.

However, even if it is known that a server supports QUIC and HTTP/3, the network in-between might block it. UDP traffic is commonly used in DDoS attacks and blocked by default in for example many company networks. While exceptions could be made for QUIC, its encryption makes it difficult for firewalls to assess the traffic. There are potential solutions to these issues but in the meantime it is expected that QUIC is most likely to succeed on well-known ports like 443. And it is entirely possible that it is blocked QUIC altogether. In practice, clients will likely use sophisticated mechanisms to fall back to TCP if QUIC fails. One option there is to “race” both a TCP and QUIC connection and use the one that completes first.

There is ongoing work to define ways to discover HTTP/3 without needing the TCP step. This should be considered an optimization though, as the UDP blocking issues are likely to mean that TCP-based HTTP sticks around. The [HTTPS DNS record](https://tools.ietf.org/html/draft-ietf-dnsop-svcb-https), is similar to HTTP Alternative Services and some CDNs are already [experimenting with these records](https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/).  In the long run, when most servers offer HTTP/3, browsers might switch to attempting that by default. But that will take a long time.

QUIC is dependent on TLS1.3, which is used for around 41% of requests, which means the other 60% of requests will need to update their TLS stack to support HTTP/3.

#### Dual stack deployment implications

From the discussion above, we expect QUIC and TCP to continue running in parallel for some time. We expect servers (e.g., nginx/apache/nodejs) to offer easy ways to do so, but this is still likely to complicate localhost test setups. Furthermore, there's probably a longer term impact on the HTTP Archive and WebPageTest projects.  The amount of pages crawled will increase substantially if we want to crawl both the HTTP/3 and H2/H1 versions, or the runtimes will increase if we want to prioritize HTTP/3.

Currently, some browsers provide (temporary) command line arguments to force QUIC on a certain origin to make this easier, but this is not the most user-friendly option of course. Over time, this will probably become easier to configure. For example, this command will force Chrome to try a QUIC connection to localhost immediately without having to discover it via alternative services :

`chrome --enable-quic --quic-version=h3-29 --origin-to-force-quic-on=localhost:6121 https://localhost:6121/`

### Not everything is implemented

So when can we start using HTTP/3 and QUIC for real? Not quite yet, but hopefully soon. There's a [large number of mature open source implementations](https://github.com/quicwg/base-drafts/wiki/Implementations) and the major browsers have experimental support. However, most of the typical servers have suffered some delays: nginx is a bit behind other stacks, apache hasn’t announced official support, and NodeJS relies on OpenSSL, which [won’t add QUIC support anytime soon](https://github.com/openssl/openssl/pull/8797). Next to this, some features like connection migration, HTTP/3's new prioritization scheme, or 0-RTT support aren’t widespread yet.

As such, you yourself can start experimenting with HTTP/3 today, but be careful with drawing too general conclusions from the performance that you’re seeing today!

## Conclusion

{# TODO This Conclusion seems like a conclusion to HTTP/3 rather than to the whole chapter. Should we add a paragraph concluding HTTP/2's usage on top of this? #}

In conclusion, we can say that HTTP/3 and QUIC are nearly here, and we will start seeing their deployments rise throughout 2021. They are highly advanced protocols with powerful performance and security features, such as a new HTTP prioritization system, HOL blocking removal, and 0-RTT connection establishment.

Sadly, this sophistication also makes them difficult to deploy and use correctly, as has turned out to be the case for HTTP/2. As such, we can predict (and recommend) that early deployments will mainly be done via the early adopting CDNs such as Cloudflare, Fastly and Akamai. This will probably mean that a large part of HTTP/2 traffic can and will be upgraded to HTTP/3 automatically in 2021, giving the new protocol a large traffic share almost out of the box. When and if smaller or individual deployments will follow suit is however more difficult to answer. Most likely, we will continue to see a healthy mix of HTTP/3, HTTP/2 and even HTTP/1.1 on the web for years to come. It will be interesting to see the numbers in next year's Web Almanac!
