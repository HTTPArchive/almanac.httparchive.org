---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
#TODO - Review and update chapter description
description: The HTTP chapter of the 2022 Web Almanac covers data on historical versions of HTTP used across the web, as well as the uptick in new versions including HTTP/2 and HTTP/3, while also inspecting key metrics a part of the HTTP lifecycle.
authors: [paivaspol]
reviewers: [tunetheweb, rmarx, LPardue]
analysts: [paivaspol]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1NJrPOjBoJSDsHV0rAHpcZ9qBUgy6RVG3QtvbTqrj5_o/
featured_quote: This past year was an eventful year for the HTTP protocol especially with HTTP/3 being standardized. We continue to observe high HTTP/2 utilization and see a strong upcoming HTTP/3 support from web servers.
featured_stat_1: 77%
featured_stat_label_1: The percentage of requests served on HTTP/2 or above
featured_stat_2: 1.5%
featured_stat_label_2: The percentage of websites adopting 103 Early Hints
featured_stat_3: 50%
featured_stat_label_3: The increase in percentage of requests that have HTTP/3 support
paivaspol_bio: Vaspol Ruamviboonsuk is a Software Engineer at Microsoft. He completed his PhD from the University of Michigan conducting research on systems to make web pages load faster. You can connect with him on <a hreflang="en" href="https://www.linkedin.com/in/vaspol-ruamviboonsuk-7898b824/">LinkedIn</a>.
---

## Introduction

HTTP is the cornerstone of the web ecosystem, providing the foundation for exchanging data and enabling various types of internet services. It has gone through several evolutions especially in the last few years with the introduction of HTTP/2 and, more recently, HTTP/3. HTTP/2 attempted to address shortcomings of HTTP/1.1 such as the limited number of concurrent  requests. At first glance, HTTP/3 is similar to HTTP/2 as the semantics are the same, but under the hood HTTP/3 is radically different from its predecessors in that it utilizes QUIC as the transport protocol instead of TCP.

As HTTP/2 provides the basis for HTTP/3, we analyze key features of HTTP/2 such as HTTP/2 push, prioritization, and multiplexing to understand how much they are still used. We also present case studies from various deployment experiences of these features. For example, HTTP/2 push allows web servers to preemptively send the response of a resource before the client requests it.

While both push and prioritization should theoretically be beneficial to end users, they can be challenging to use. We discuss new technologies that can potentially be used as alternatives to underperforming HTTP/2 features. For example, 103 early hints responses provides an alternative to HTTP/2 server push that achieves the same performance goal of preemptive resource fetches..

Finally, we dive into HTTP/3 by discussing how it is an improvement over HTTP/2 and by analyzing the current support for HTTP/3, where we observe some increase from 2021. We hope that the data points provided in this chapter will provide some insights on future trends and pointers to new technologies that developers can experiment with to improve user experiences.


## Evolution of HTTP

HTTP is one of the most important Internet protocols because it powers communications for the web. It began as a text-based protocol through the first three versions: 0.9, 1.0, and 1.1. With its extensibility, HTTP/1.1 was the current HTTP version for 15 years until 2015.

HTTP/2 is a major milestone of HTTP as it evolves from a text-based protocol to a binary-based one. Where HTTP/1.1 supports only serial request and response exchanges, HTTP/2 supports concurrency. Clients and servers represent requests and responses as streams of binary frames. Streams have unique identifiers, which allows frames to be multiplexed and interleaved.

The latest version of HTTP is HTTP/3, which was recently [standardized by the IETF in June 2022](https://www.rfc-editor.org/rfc/rfc9114.html). While HTTP/3 implements the same features as HTTP/2, there is a vital difference in how it is transported across the internet. HTTP/3 is built on top of QUIC, a UDP-based protocol, which alleviates some of the performance issues that HTTP/2 can face on a lossy network.


## HTTP/2 adoption

With various HTTP versions introduced over the years, we begin by describing the current state of HTTP version adoption. We measure the HTTP version usage by taking all resources in the 2022 Web Almanac dataset and identify which version of HTTP each resource was served on.

However, with our setup, it is not trivial to accurately count resources delivered on HTTP/3, as clients have to discover HTTP/3 support via [the `alt-svc` HTTP response header](https://almanac.httparchive.org/en/2021/http#negotiating-http3). By the time the client receives the `alt-svc` header however, it has already completed the protocol negotiation for HTTP/1.1 or HTTP/2. Only after this point can the client upgrade the protocol to HTTP/3 on subsequent requests or page loads. As such, our data never captures a full HTTP/3 page load.

With the discovery of HTTP/3 being so delayed via the `alt-svc` HTTP header mechanism, our measurements may undercount resources that would have been delivered on HTTP/3 for normal browsing users. Thus, we group resources delivered on HTTP/2 and HTTP/3 together as HTTP/2+.

{{ figure_markup(
  image="http2-adoption-per-request.png",
  caption="Adoption of HTTP/2 and above as a percentage of requests.",
  description="The adoption of HTTP/2 and above is very high. 77% of requests in June 2022 were served using HTTP/2 and above in both desktop and mobile settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=109625269&format=interactive",
  sheets_gid="1707754058",
  sql_file="h2_adoption_pages_reqs.sql"
  )
}}


First, to understand the status quo, we measure the prevalence of HTTP/2+ adoption. In June 2022, we observed that roughly 77% of requests from our loads use HTTP/2+. This is a [5% increase](https://almanac.httparchive.org/en/2021/http#adoption-by-request) in HTTP/2+ adoption from July, 2021, where we observed that 73% of the requests were on HTTP/2+.


{{ figure_markup(
  image="http2-adoption-per-site.png",
  caption="Adoption of HTTP/2 and above as a percentage of websites.",
  description="66% of websites in June 2022 were served using HTTP/2 or above in both desktop and mobile settings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=328815423&format=interactive",
  sheets_gid="1707754058",
  sql_file="h2_adoption_pages_reqs.sql"
  )
}}


With the _increase_ in HTTP/2+ adoption, we would like to understand the driving forces that enable the increase. First, we analyze the HTTP/2+ adoption at per-website granularity by checking whether the landing page of the website was served on HTTP/2+. We observed that approximately 66% of the websites from our dataset, in both desktop and mobile settings, were served on HTTP/2+, whereas this was only true for [approximately 60% of the websites in our dataset in 2021](https://almanac.httparchive.org/en/2021/http#adoption-of-http2). This increase is a positive trend which suggests that websites are ready and moving towards an up-to-date version of HTTP.


{{ figure_markup(
  image="http2-adoption-per-cdn.png",
  caption="Adoption of HTTP/2 and above as a percentage of requests served from a CDN.",
  description="On both desktop and mobile settings, 95% of the requests that were served from a CDN were served using HTTP/2 or above. This suggests that CDN is the main driver for the increase in HTTP/2 adoption.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=1268139215&format=interactive",
  sheets_gid="427272739",
  sql_file="h2_adoption_by_cdn_pct.sql"
  )
}}


Another factor in enabling HTTP/2+ adoption is resources served from CDN. Similar to the observation in our [2021 analysis](https://almanac.httparchive.org/en/2021/http#adoption-by-cdns), we noticed that most resources served from a CDN were on HTTP/2+. The figure above shows that 95% of the requests served from CDN were delivered on HTTP/2+.


## Benefits of HTTP/2 and HTTP/3

Next, we focus on how features that HTTP/2 introduced are being adopted. We primarily focus on three notable concepts: multiplexing requests over a single network connection, resource prioritization, and push.


### Multiplexing requests over a Connection

An important feature of HTTP/2 is multiplexing requests over a single TCP connection. This is a substantial improvement to earlier versions of HTTP where only one concurrent request is allowed on a TCP connection and, in most cases, only 6 parallel TCP connections are allowed to a hostname. HTTP/2 introduces the concept of a stream; a logical representation of a connection that is used for resource delivery. Multiple HTTP/2 streams can then be multiplexed onto a single TCP connection thereby removing the per-connection concurrency limitations.

An implication of multiplexing requests into one TCP connection is the [reduction of connections](https://almanac.httparchive.org/en/2021/http#number-of-connections) required during page loads. Similar to our findings in 2021, pages with HTTP/2 enabled we observe fewer connections than pages that do not have HTTP/2 enabled.


{{ figure_markup(
  image="connections-comparison-per-page.png",
  caption="Distribution of number of connections established during page load broken down by whether a web page uses HTTP/2+.",
  description="With HTTP/2 enabled, web pages establishes fewer connections during the page load. For example, the median mobile page with HTTP/2 establishes 12 connections, but the median mobile page without HTTP/2 establishes 15 connections.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=461867891&format=interactive",
  sheets_gid="901907129",
  sql_file="connections_per_page_load_dist.sql"
  )
}}


The figure above shows that the median mobile page has 12 connections established during the page load when HTTP/2 is enabled. In contrast, the median page without HTTP/2 has 15 connections established—an overhead of 3 additional connections. However, the overhead worsens at higher percentiles. The page at the 90th percentile with HTTP/2 enabled has 32 connections, whereas the 90th percentile page without HTTP/2 enabled has 38 connections—a 6 additional connection overhead. These trends are the same between desktop and mobile versions of websites.

Given that we observe an increase in HTTP/2 adoption over the year, it is unsurprising that the number of TCP connections overall has been gradually decreasing over the years. [A longitudinal view from HTTP Archive](https://httparchive.org/reports/state-of-the-web#tcp) shows that the median number of connections established decreased by 9 connections, from 22 connections in 2017 to 13 connections in 2022.


### Resource Prioritization

With HTTP/2, clients can [multiplex](https://stackoverflow.com/questions/36517829/what-does-multiplexing-mean-in-http-2/36519379#36519379) multiple requests on the same connection. An implication is that this can negatively impact delivery of render blocking resources if many resources are inflight at the same time. This can lead to poor user experience. In [its original standard](https://www.rfc-editor.org/rfc/rfc7540#page-25), HTTP/2 attempts to address this by proposing a priority tree that clients construct during page load and which web servers can use to prioritize sending more important responses. However, this approach is difficult to use and many web servers and CDNs either [did not correctly implement it or ignored it](https://github.com/andydavies/http2-prioritization-issues). Because of this, it was suggested in a later [iteration of HTTP/2](https://www.rfc-editor.org/rfc/rfc9113.html#section-5.3) that a different scheme should be used.

With the challenges to HTTP/2 priorities, a new prioritization scheme was needed. The [Extensible Prioritization Scheme for HTTP](https://httpwg.org/specs/rfc9218.html) was developed separately from HTTP/3 and was standardized in June 2022. In this scheme, clients can explicitly assign a priority composed of two parameters via the `priority` HTTP header or the `PRIORITY_UPDATE` frame. The first parameter, `urgency`,  tells the server the priority of the requested resource. The second parameter, `incremental`, tells the server whether a resource can be partially used at the client (for example, partially displaying an image as parts of it arrive). Defining the scheme as a HTTP header and as the `PRIORITY_UPDATE` frame makes it extensible as both formats were designed to provide future extensibility. At the time of writing, the scheme has been deployed for HTTP/3 in Safari, Firefox, and Chrome.

While most of the resource priorities are decided by the browser itself, developers can now also use the new [priority hints](https://web.dev/priority-hints/) to tweak the priority of a particular resource. Priority hints can be specified via the `fetchpriority` attribute in the HTML. For example, suppose that a website would like to prioritize a hero image, it can add `fetchpriority` to the image tag: `<img  src=”hero.png” fetchpriority=”high” />`.

{{ figure_markup(
  caption="Mobile pages using Priority Hints.",
  content="1.2%",
  classes="big-number",
  sheets_gid="1067615125",
  sql_file="priority_hints_usage.sql"
)
}}


Priority hints can be very effective in improving user experience. For example, [Etsy conducted an experiment](https://www.etsy.com/codeascraft/priority-hints-what-your-browser-doesnt-know-yet) and observed a 4% improvement in Largest Contentful Paint (LCP) on product listing pages that included priority hints for certain images. While Priority Hints was only recently released at the end of April 2022 as part of Chrome 101, it has a very promising adoption as we observe that approximately 1% of desktop web pages and 1.2% of mobile web pages have already adopted priority hints in August 2022. With its potential to improve user experience with relative ease, it may be a good feature to experiment with.


### Push

HTTP/2 push allows web servers to pre-emptively send a response to a request before that request is even sent by the client. For example, a web site provider can push a resource that will be used during a page load to the end user along with the main HTML.


{{ figure_markup(
  image="h2-push-usage.png",
  caption="Comparison of percentage of websites using HTTP/2 Push between 2021 and 2022 Web Alamnac datasets.",
  description="While HTTP/2 push usage was already very low in the Web Almanac 2021 dataset, we observe lower HTTP/2 push utilization in this year's Web Almanac dataset, where only 0.66% of the mobile web pages utilizes HTTP/2 push.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=1440772038&format=interactive",
  sheets_gid="1278005075",
  sql_file="h2_h3_pushed.sql"
  )
}}


In 2021, as shown in the figure above, the percentage of websites using push was very low at 1.25%. However, in this year’s analysis, the number of websites using push decreases to 0.7% for both desktop and mobile websites. This marks the first decrease in push usage since 2020.

The decrease in websites using push is likely because [it is difficult to use effectively](https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/). For example, websites cannot accurately know whether a resource being pushed already exists in the client’s cache. If it is in the client’s cache, the bandwidth used for pushing the resource is wasteful. With the difficulties, [Chrome decided to deprecate HTTP/2 push](https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/ho4qP49oAwAJ) starting from [Chrome version 106](https://developer.chrome.com/blog/removing-push/). Despite push also still being a part of the HTTP/3 standard, Chrome never implemented it, nor does it plan to, which might further explain the reduction in usage as sites moved to that version and lost the ability to push.


### Alternatives to Push

Given the challenges to using HTTP/2 push, developers can use [Link rel=”preload”](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/preload) as an alternative to pre-emptively request a resource that will be used later in a page load. The Link preload header allows web servers to include additional URLs or important resources, either as part of the HTTP response headers or in the &lt;head> section of the HTML. The client can then issue requests for the provided URLs before the resources are normally discovered during the page load. While not quite as fast as proactively pushing resources, this is a lot safer in allowing the browser to choose whether to fetch those resources or not if, for example, it already has a copy in the cache. We observed a large number of pages in our dataset include a &lt;link rel=”preload”> tag, approximately 25% on both desktop and mobile.

In 2017, the 103 Early Hints status code was standardized; Chrome added support for it this year. Early hints can be used to send interim HTTP responses before the final response of the requested object; they can boost performance by leveraging the fact that web servers often require some time to prepare a response  (especially for the main HTML document if it is dynamically rendered). One use case of Early Hints is to deliver Link rel=”preload” (or “preconnect”) for resources to preemptively fetch, but other headers can conceptually also be conveyed. Early hints can be a better alternative than push because clients retain greater control over how the resources are fetched, but still allow an improvement on just adding preloads and preconnects to the main document request.  Furthermore, early hints can be used for 3rd party resources, which was not possible with push

{{ figure_markup(
  caption="Desktop pages using 103 Early Hints.",
  content="1.6%",
  classes="big-number",
  sheets_gid="187640264",
  sql_file="early_hints_usage.sql"
)
}}

There are studies showing that adopting early hints can improve user experience. For example, [Shopify observed 20-30% LCP improvements](https://blog.cloudflare.com/early-hints-performance/) in their lab study. We observe that approximately 1.6% of web sites in our dataset have adopted early hints and most of the adoption  (1.5%) stems from websites running on Shopify’s platform. With the 25% of websites including &lt;link rel=”preload”> with the page response, there is significant potential to convert such link nodes to early hints.


## HTTP/3

In the remainder of this section, we turn our focus to HTTP/3, as it is the future of HTTP and [was standardized in June 2022](https://www.rfc-editor.org/rfc/rfc9114.html). In particular, we explore the improvements of HTTP/3 over its predecessors and how much support it currently has. For a more detailed explanation on HTTP/3, you can refer to [this excellent series of post](https://www.smashingmagazine.com/2021/08/http3-core-concepts-part1/)s from Robin Marx, who also helped review this chapter.


### Benefits of HTTP/3

While HTTP/2 introduced various improvements over its predecessor, there remain further challenges and opportunities for the protocol. For example, even though multiplexing of requests onto a single TCP connection alleviated head-of-line blocking issues for each request, delivering requests using this method [can still be inefficient](https://calendar.perfplanet.com/2020/head-of-line-blocking-in-quic-and-http-3-the-details/). This is because early lost TCP packets can prevent properly received later TCP packets from being processed until their retransmission arrives.

HTTP/3 aims to improve upon the shortcomings of HTTP/2 and is built on QUIC, a UDP-based transport protocol. QUIC addresses TCP head-of-line blocking by implementing reliable packet delivery on top of UDP at a per-stream granularity.


### HTTP/3 Support

To advertise that HTTP/3 is supported, web servers rely on the `alt-svc` in the HTTP response header. The value of `alt-svc` header contains a list of protocols supported by the server.


{{ figure_markup(
  image="alt-svc-example.png",
  caption="`alt-svc` response header example.",
  description="Screenshot showing `alt-svc` response header supporting HTTP/3 with values `h3`, and `h3-29`.",
  width=417,
  height=267
  )
}}

For example, in September 2022, the `alt-svc` value in the response for [https://www.cloudflare.com](https://www.cloudflare.com) is `h3=":443"; ma=86400, h3-29=":443"; ma=86400` as shown in the  screenshot below. `h3` and `h3-29` tell us that Cloudflare supports HTTP/3 and IETF draft 29 of HTTP/3 over UDP port 443. There is also a proposal to speed up the discovery of HTTP/3 as part of DNS lookup; for more details see [this post from Cloudflare](https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/).


{{ figure_markup(
  image="h3-support-per-request.png",
  caption="Comparison of percentage of requests with HTTP/3 support between 2021 and 2022 Web Almanac datasets.",
  description="HTTP/3 support has increased between July 2021 and June 2022. In June 2022, 15% of the requests have HTTP/3 support, whereas only 10% of the requests in July 2021 has HTTP/3 support.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=971486939&format=interactive",
  sheets_gid="1456324569",
  sql_file="h3_support.sql"
  )
}}


We analyze the HTTP/3 adoption by identifying a resource that was served on HTTP/3 or its response header containing an `alt-svc` header with either `h3` or `h3-29` being one of the protocols advertised. The figure above shows that there is a 5 percentage point increase, from 10% to 15%, in the percentage of requests with HTTP/3 support. The increase was observed in both desktop and mobile requests.


{{ figure_markup(
  image="h3-support-by-cdn-use.png",
  caption="Breakdown of HTTP/3 support for requests served from a CDN.",
  description="Similar to HTTP/2, HTTP/3 support largely stems from CDNs. More than 80% of resources that were served from a CDN have HTTP/3 support for both desktop and mobile web pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=2018898771&format=interactive",
  sheets_gid="151549205",
  sql_file="h3_support_from_cdn.sql"
  )
}}

Similar to HTTP/2+ adoption, most of the HTTP/3 support originates from CDNs. The figure above shows that of the requests with HTTP/3 support more than 80% of them were served from a CDN. For example, 75% of the resources served from Cloudflare and 99% percent of the resources served from Facebook have HTTP/3 support. We expect the support to grow in the future when more CDNs start to support HTTP/3.


## Conclusion

This past year was an eventful year for the HTTP protocol especially with HTTP/3 being standardized. We continue to observe high HTTP/2 utilization and see a strong upcoming HTTP/3 support from web servers.

In addition, we have seen strong growth in the ecosystem for technologies that address some of the critical challenges in HTTP/2. 103 Early Hints provides a safer alternative for Server Push and its client support has taken a large step forward with Chrome now supporting it. A new standard for HTTP Prioritization was finalized; major browsers and some web servers already support it for HTTP/3. Furthermore, Priority Hints was added to the web platform to allow clients to further refine prioritization in both HTTP/2 and HTTP/3 and early experiments yielded promising user experience improvements.

This is an exciting time going forward for the HTTP protocol and the web ecosystem; we are excited to see how these new technologies will get adopted and what effects they will have on user experience.
