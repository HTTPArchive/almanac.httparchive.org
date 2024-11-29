---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: The HTTP chapter of the 2024 Web Almanac covers data on historical versions of HTTP used across the web, as well as the uptick in adoption of HTTP/2 and HTTP/3. Additionally, it looks at higher level features that impact HTTP behaviour, such as resource hints, 103 Early Hints and FetchPriority.
hero_alt: Hero image of Web Almanac characters driving vehicles in various lanes carrying script and images
authors: [rmarx]
reviewers: [tunetheweb,ChrisBeeti]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: []
rmarx_bio: TODO
results: https://docs.google.com/spreadsheets/d/1PfTZkbmgyLA3NmEICeCyxpMWgP7cKY7EsZl9RciE5S4/
featured_quote: TODO
featured_stat_1: 77%
featured_stat_label_1: TODO
featured_stat_2: 1.5%
featured_stat_label_2: TODO
featured_stat_3: 50%
featured_stat_label_3: TODO
doi: 10.5281/zenodo.14065825
---

## Introduction

HTTP remains the cornerstone of the web ecosystem, providing the foundation for exchanging data and enabling various types of internet services. It is an actively developed protocol, with the latest version <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9114">HTTP/3</a> being standardized a little over two years ago, and new options to enable it being introduced recently, such as the new [DNS HTTPS records](https://developer.mozilla.org/docs/Glossary/HTTPS_RR). At the same time, the Web platform has been exposing more and more higher-level features that Web developers can use to influence when and how resources are requested and downloaded over HTTP. This includes options like [Resource Hints](https://web.dev/learn/performance/resource-hints) (for example preload and preconnect), [103 Early Hints](https://developer.mozilla.org/docs/Web/HTTP/Status/103) and the [Fetch Priority API](https://web.dev/articles/fetch-priority).

In this chapter, we will first look at the current state of HTTP/1.1, HTTP/2 and HTTP/3 adoption, and how their usage has evolved over time. We then consider the new Web platform features, to get an idea of how well they're supported and how people are using them in practice.

## HTTP version adoption

Conceptually, getting an idea of how widespread the adoption of HTTP/2 and HTTP/3 is should be easy: just report how often each of the protocol versions was used to load the observed websites' home pages. This is exactly what we've done in the graph below:

{{ figure_markup(
  image="http-version-per-website.png",
  caption="Adoption of HTTP versions as a percentage of website home pages.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=543150104&format=interactive",
  sheets_gid="1647649629",
  sql_file="h2_adoption_pages_reqs.sql"
) }}

While these results might look sensible at first glance, they are actually quite misleading. Indeed, as we'll see later, in reality HTTP/3 support across the Web is closer to 30% instead of the 7-9% reported above. This discrepancy is due to the fact that HTTP/3 has to be discovered before being used, while [the methodology used](./methodology) for the Web Almanac doesn't really lend itself well to the main discovery option (`alt-svc`). This causes a lot of HTTP/3-capable sites still being loaded over HTTP/2 and thus HTTP/3 is getting underreported. We will discuss this in more detail below, but for now we will group HTTP/2 and HTTP/3 together into a single label of **HTTP/2+** to at least compare them to HTTP/1.1.

As such, we see that only 21-22% of home pages are loaded over HTTP/1.1 in 2024, a marked difference from 2022 [where it was still 34%](../2022/http#http2-adoption) and especially 2020 where there was [basically a 50/50 split](../2020/http#http2-adoption) between HTTP/1.1 and H2+.

Now, this is just looking at how the main document (the HTML) of the page is loaded. Another way of looking at HTTP adoption is by looking at the version used for all requests (including subresources and third-parties), which skews the results even more towards HTTP/2+:

{{ figure_markup(
  image="http2-per-request.png",
  caption="Adoption of HTTP/2 and above as a percentage of requests.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=1786964395&format=interactive",
  sheets_gid="530915869",
  sql_file="h2_adoption_pages_reqs.sql"
) }}

This is because many websites will load additional resources from a variety of third-party domains (for example analytics, plugins/tags, social media integrations, etc.). Due to their scale, these external services often either provide support for HTTP/2+ themselves or make use of a so-called CDN or Content Delivery Network (for example Akamai, Cloudflare or Fastly) that does it for them. In fact, CDNs are used very heavily on the observed websites, with a whopping 54% of over 1.3 billion requests in our dataset being served from a CDN!

{{ figure_markup(
  caption="The percentage of over 1.3 billion requests in the Web Almanac dataset that use a CDN.",
  content="54%",
  classes="big-number",
  sheets_gid="530915869",
  sql_file="h2_adoption_by_cdn_pct.sql"
) }}

These companies are typically at the forefront of implementing new standards and protocols. When they enable a new feature, it becomes available to all their customers, usually causing a fast increase in global adoption. As such, we can see that CDNs are still one of the main drivers of HTTP/2+ adoption, with less than 4% of all CDN requests happening over HTTP/1.1. This is again in stark contrast to requests not served from a CDN node, of which up to 29% still use HTTP/1.1.

{{ figure_markup(
  image="http2-for-cdn.png",
  caption="Almost all traffic from CDNs is delivered over HTTP/2+.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=1286609498&format=interactive",
  sheets_gid="687276140"
) }}

Combined, these results show that while overall adoption of newer HTTP versions is higher than ever, there are still plenty of sites that are in danger of "being left behind". These are mostly the (likely smaller) projects that can't or won't engage a CDN, but also don't have the technical know-how or motivation to enable HTTP/2+ themselves at their origins. Conceptually, this makes sense, as the newer versions do have some costs associated with them, both in terms of complexity and, especially for HTTP/3, in terms of CPU usage. And while HTTP/1.1 of course still functions perfectly fine, there might be some performance/efficiency downsides, as only HTTP/2+ allows multiplexing of multiple resources onto one connection, as well as additional features like resource prioritization and header compression.

Still, personally I feel it's good to have freedom of choice on the web, not just in terms of content, but also the tech stacks that are used, and that includes the protocol. Similarly, the current (over)reliance on CDNs (for performance and security) also has its own downsides, with some people <a hreflang="en" href="https://www.mnot.net/blog/2023/12/19/standards-and-centralization">fearing a "centralization" of the Web</a> around a few large companies. I don't think we're quite there yet, but <a hreflang="en" href="https://pulse.internetsociety.org/blog/the-challenges-ahead-for-http-3">I have written previously</a> about the worrying fact that it is increasingly only the CDNs/large companies that have the technical know-how to deploy the newer protocols at scale. I don't know the right answer here, but feel it's good to highlight both sides!

However, let's move away from the philisophical back into the (deeply) technical now, and explore why exactly the Web Almanac dataset is only seeing low percentages of HTTP/3 being used!

## Discovering HTTP/3 support

Measuring HTTP/3 adoption can be challenging because most modern browsers and clients will not try HTTP/3 the first time they load a page from a domain they haven't seen before. The reasons why are complex and were explained in detail in previous Web Almanacs ([2020](../2020/http#deploying-and-discovering-http3) and [2021](../2021/http#negotiating-http3)). The short version is that it could take the browser a (very) long time to fall back to HTTP/2 (or HTTP/1.1) if HTTP/3 is not available for the target domain—for example the server doesn't support it yet, or the network is blocking the protocol.

This is less of a problem for HTTP/2 and HTTP/1.1, as they both run over the TCP protocol. If the server doesn't support HTTP/2, it can just continue with HTTP/1.1 over the existing TCP connection the browser set up, getting an "instant fallback". HTTP/3 however is different, as it replaces TCP with <a hreflang="en" href="https://www.smashingmagazine.com/2021/08/http3-core-concepts-part1/">a new transport protocol called QUIC</a> which in turn runs over the UDP protocol. If the browser _only_ opens a QUIC+HTTP/3 connection to a server that doesn't support it, that server wouldn't be able to fall back to HTTP/2 or HTTP/1.1, since that's only possible over TCP, not QUIC/UDP. It would have to wait for the HTTP/3 connection to timeout (which can take several seconds) and only then open a new TCP connection for HTTP/2 or HTTP/1.1, which would be very noticeable for the end users.

To prevent users suffering this potential delay, the browser will in practice only try HTTP/3 if it's 100% sure the server will support it. But how can it be 100% sure? Well, if the server/deployment explicitly tells the browser it supports HTTP/3, of course!

There are two main ways of doing this:

1. **The `alt-svc` HTTP response header**: the HTTP server advertises HTTP/3 support when a resource is requested over HTTP/2 or HTTP/1.1
2. **The DNS HTTPS resource record**: the DNS server indicates HTTP/3 support during name resolution, before connection establishment

The first option is by far the most popular, but has the downside that it first needs a "bootstrapping" connection over HTTP/2 or HTTP/1.1 to discover HTTP/3 support. The second option removes this downside by putting the information directly in DNS, which resolves before the first HTTP connection is even made. It is however much newer and thus less supported at the moment of writing.

To get a good idea of real HTTP/3 support in the Web Almanac dataset, we need to consider both separately, as they will give conflicting results.

### HTTP/3 via `alt-svc`

As discussed above, if the browser hasn't connected to a domain before, it will only try HTTP/2 or HTTP/1.1 over TCP, as those are most likely to be supported. For each HTTP/2 or HTTP/1.1 response, the server can then send along a special `alt-svc` HTTP response header, indicating it is guaranteed to support HTTP/3 as well—at least for a specified timeframe: the `ma` (max-age) parameter.

{{ figure_markup(
  image="alt-svc-example.jpg",
  caption="`alt-svc` response header example.",
  description="Screenshot showing the `alt-svc` HTTP response header supporting HTTP/3 on UDP port 443 with ALPN value `h3` and `max-age` of 26 hours for `www.akamai.com`",
  width=716,
  height=419
  )
}}

`alt-svc` **Alternative Services**: you're currently using the HTTP/2 service, and there's also an HTTP/3 service available (usually at UDP port 443). From then on, when the browser needs a new connection to the server, it can try to establish it over HTTP/3 as well!

Using this mechanism means that HTTP/3 is typically only used from the second page load of a site onward, as the first load will happen over H2 or HTTP/1.1, even if the server supports HTTP/3. And that is the crux of the issue, as the Web Almanac only measures the first page load by design.

In order to make results comparable and fair across websites, we want to load each page with a fresh browser profile and nothing in the HTTP/file/DNS/alt-svc/... caches. As such, the `alt-svc` mechanism is conceptually useless in our methodology, as we'd only use the initial HTTP/2 connection and never get to HTTP/3. This is why measuring HTTP/3 adoption directly by protocol used in our dataset (as we did in the first image above) is misleading, with HTTP/3 getting underreported.

<p class="note">
  Note: at this point, you might wonder how we're even seeing HTTP/3 page loads at all since with just <code>alt-svc</code> we should be seeing 0% HTTP/3. This is of course mainly due to the use of the 2nd discovery method via DNS, which we'll discuss later.
</p>

Let's now look purely at how HTTP/3 support is being announced via `alt-svc` to get an idea of how much support sites claim to have, even if it doesn't actually show up in our dataset:

{{ figure_markup(
  image="http3-support-per-origin.png",
  caption="HTTP/3 support (via `alt-svc`) has increased steadily since 2022.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=458096579&format=interactive",
  sheets_gid="1569509568",
  sql_file="h3_usage_site.sql"
) }}

When we [last looked at HTTP/3 support](../2022/http#http3-support) in June 2022, the protocol wasn't even fully standardized yet. Still, due to early deployments from some large players, around 18% of sites in the HTTP Archive dataset indicated they had support for HTTP/3. Now, two years later, we can see that support for the new protocol has steadily risen, up to 26% (desktop) to 28% (mobile), a near 10% overall increase. If that still seems low, it's actually quite similar to HTTP/2's evolution, which equally saw <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">around 30% uptake in its second year</a> after standardization (2017).

It is somewhat interesting to see that mobile home pages advertise a little better support for HTTP/3 than their desktop counterparts. This can potentially be explained by the fact that HTTP/3 will mainly deliver benefits over mobile/cellular networks (and so site owners might want to mainly enable it for that) and because some corporate environments still tend to block HTTP/3 on their networks (making it less interesting to enable for desktop clients).

{{ figure_markup(
  image="http3-support-by-cdn-use.png",
  caption="HTTP/3 support is driven mainly by CDNs.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=340546380&format=interactive",
  sheets_gid="880813564",
  sql_file="h3_support_from_cdn.sql"
) }}

Similar to HTTP/2+ above, the support for HTTP/3 comes mainly from the CDNs, but in an quite extreme form in my opinion: around 85% of all HTTP/3 responses seen in our dataset came from a CDN. This compares to around 55% of all HTTP/2+ requests. This indicates that today very few website owners are self-deploying HTTP/3 at their origin and re-emphasizes my point from above that fast adoption of new technologies might (sadly) become a large-company-only thing. This is not entirely unexpected however; a lot of the popular "off the shelf" web servers do not have stable, mature, on-by-default HTTP/3 support yet including projects like NodeJS, Apache and nginx. Running a scalable HTTP/3 deployment that uses some of the protocol's advanced features—like connection migration and 0-RTT—is far from easy. Still, I hope to see more people self-hosting HTTP/3 in the (near) future.

One important remark to make here is that not all CDNs show equally high HTTP/3 support:

<figure>
  <table>
    <thead>
      <tr>
        <th class="no-wrap">HTTP/3 <code>alt-svc</code></th>
        <th>CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>&gt; 90%</td>
        <td>Facebook, Automattic, jsDelivr</td>
      </tr>
      <tr>
        <td>50% - 90%</td>
        <td>Cloudflare, Cedexis</td>
      </tr>
      <tr>
        <td>10% - 50%</td>
        <td>Google, Amazon Cloudfront, Fastly, Microsoft Azure, BunnyCDN, Alibaba, CDN 77</td>
      </tr>
      <tr>
        <td>1% - 10%</td>
        <td>Akamai, Sucuri Firewall, Azion, KeyCDN</td>
      </tr>
      <tr>
        <td>&lt; 1%</td>
        <td>Twitter, Vercel, Netlify, OVH CDN, EdgeCast, G-Core CDN, Incapsula</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentage of HTTP/3 `alt-svc` responses for all requests served by first-party CDNs (with considerable traffic share).", sheets_gid="1667058296", sql_file="h3_support_each_cdn_breakdown.sql") }}</figcaption>
</figure>

Firstly, we see that some companies go all-in on HTTP/3, with for example Facebook indicating HTTP/3 support on 99.86% of responses! This is in stark contrast to other large companies like Twitter/X, that don't send `alt-svc` at all. Secondly, even CDNs that clearly support HTTP/3 rarely reach high percentages, with Cloudflare leading the pack at 78% and Akamai tagging along at just 7%. This most likely has to do with how exactly the CDNs enable the new protocol. For example, Cloudflare has enabled it by default for their free plans, leading to high (though not universal) use. In contrast, Akamai requires its customers to manually enable the feature in their configuration, which many seem slow/unwilling to do. As such, the amount of HTTP/3 support on the Web _could_ be much higher than around 28% if all CDN customers would allow it. Finally, it is somewhat surprising that some more specialized deployments, like Automattic, heavily lean into HTTP/3 (99.92%) while others like Vercel and Netlify show near-zero HTTP/3 support. I can only speculate on the reasons for the latter, but assume it is mostly due to the complexity of setting up and maintaining the new protocol at scale, while these newer up-and-coming companies prefer to focus on other parts of their stacks first.

<p class="note">
  Note: These results might not give a 100% accurate impression of what CDNs are actually doing, as firstly <a hreflang="en" href="https://github.com/HTTPArchive/wptagent/blob/5ef2c870a90a3492cd6170893812270d627df107/internal/optimization_checks.py#L67">the CDN detection logic</a> might be inaccurate/incomplete (for example, Shopify is not tracked separately yet), and secondly a lot of the tracked requests are for analytics/trackers, which might not be indicative of HTTP/3 support for normal page/resource loads.
</p>

In conclusion, we see that currently around 27% of all websites in the Web Almanac dataset announce HTTP/3 support through `alt-svc`. This number could potentially be much higher, if all websites that use a compatible CDN would enable it. At the same time however, the actual number of HTTP/3 requests we've seen in the dataset is much lower, between 7-9%. As we've explained this is due to the used methodology and most of those 7-9% will come from another HTTP/3 discovery method using DNS records, so let's look at those next.

### HTTP/3 via DNS

As we've discussed, announcing HTTP/3 support via an `alt-svc` HTTP response headers has some downsides, leading to the newer protocol only being used from the second connection to a server onwards. To get rid of this inefficiency, the browser would have to discover HTTP/3 support before it even opened the first connection to the server. Luckily, there is still one thing that happens before a connection can be setup and that is DNS resolution.

The Domain Name System (DNS) is often described as a large phone book, which allows you to translate a hostname (for example, `www.example.org`) into one or more IP addresses (with `A` and `AAAA` queries returning IPv4 and IPv6 results respectively). However, in essence, the DNS can also be thought of as just a very large, distributed Key-Value store that can hold other things besides IP addresses (and associated metadata like `CNAME`s) as well. Some examples include listing email details with `MX` records, and using `TXT` records to prove ownership of a domain (for example for <a hreflang="en" href="https://letsencrypt.org/docs/challenge-types/#dns-01-challenge">Let's Encrypt</a>).

The past few years, work has been ongoing to also add other information to the DNS, in particular with the new concept of <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9460.html#name-goals">Service Binding (SVCB) and HTTPS records</a>. These new records provide the client with a lot more information about a service/origin than just its IP addresses: whether it's HTTPS capable, whether it can use the new [Encrypted Client Hello](https://support.mozilla.org/en-US/kb/understand-encrypted-client-hello) for extra privacy, or for our purposes, which protocols it supports and on which ports. This is intended to make initial connection setup/service discovery a bit more efficient, as currently this is often done through slower methods like a chain of redirects or the above `alt-svc`, or requires out-of-band methods like [HSTS preload](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security). They are also intended to help with complex load balancing setups (for example when combining multiple CDNs).

A full discussion on SVCB would take too much time here however, so we will focus only on how we can announce HTTP/3 support through the new HTTPS record as there are <a hreflang="en" href="https://www.domaintools.com/resources/blog/the-use-cases-and-benefits-of-svcb-and-https-dns-record-types/">plenty of other</a> <a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">blog posts</a> and <a hreflang="en" href="https://www.isc.org/docs/2022-webinar-dns-scvb.pdf">documents</a> with <a hreflang="en" href="https://www.netmeister.org/blog/https-rrs.html">more details</a> on the wider applications. Let's look at an example of the HTTPS record in the wild:

{{ figure_markup(
  image="dns-https-example.jpg",
  caption="DNS HTTPS resource record example.",
  description="Screenshot showing a DNS HTTPS record listing alpns HTTP/3 and h2, and providing both an ipv4hint and ipv6hint for blog.cloudflare.com",
  width=1415,
  height=62
  )
}}

As we can see, `blog.cloudflare.com` indicates support for both HTTP/3 and HTTP/2 (in order of preference!) via the `alpn="h3,h2"` part of the response. ALPN stands for [Application Layer Protocol Negotiation](https://developer.mozilla.org/docs/Glossary/ALPN) which was/is originally a TLS (Transport Layer Security protocol) extension to indicate which application protocols and versions a server supports, to for example allow the graceful fallback from HTTP/2 to HTTP/1.1 discussed above. The general approach (and name) is reused for the DNS HTTPS record as well. Additionally, the example shows the optional `ipv4hint` and `ipv6hint` entries, which allow steering of users to specific endpoints for specific services—for example if not every single machine in the deployment actually supports HTTP/3 yet, say in a multi-CDN setup. In conclusion, if a browser queries the DNS for the HTTPS records (which is typically done in parallel or even before A and AAAA queries), and subsequently sees `h3` in the ALPN list, it is allowed/encouraged to also try HTTP/3 for its first connection to the server, bypassing the `alt-svc` overhead.

Let's now take a look at how much we've seen the new DNS records being used in the wild in the Web Almanac dataset. Looking at the general use, we see that around 12% of both mobile and desktop pages have an HTTPS record of some kind defined. Not all of those include the `h3` option in their `alpn` section however: that's slightly lower at 9% (desktop) and 10% (mobile):

{{ figure_markup(
  image="dns-https-alpn-h3.png",
  caption="HTTP/3 support is regularly being announced through DNS HTTPS records",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=340546380&format=interactive",
  sheets_gid="653397334",
  sql_file="dns_https_svcb_usage.sql"
) }}

This means that 9-10% of all considered pages (over 20 million) in our dataset indicate HTTP/3 support through DNS. However, this does not automatically mean that HTTP/3 is also actually used by the browser. As we showed in the first image of this chapter, only about 7% (desktop) to 9% (mobile) of pages were actually loaded over HTTP/3. This is definitely in the same order of magnitude as the DNS HTTPS adoption, but not quite the same. This can have many different reasons, including networks blocking the newer protocol, HTTP/3 somehow losing the "race" to the HTTP/2 connection, the DNS HTTPS record being misconfigured, the DNS response for the record being delayed, the HTTP/2 connection being reused due to <a hreflang="en" href="https://blog.cloudflare.com/connection-coalescing-with-origin-frames-fewer-dns-queries-fewer-connections/">connection coalescing</a>, etc. Still, it shows that this newer/alternative method of indicating HTTP/3 support early in the page loading process has strong potential to improve upon the `alt-svc` approach—and not just for the Web Almanac methodology.

It is also interesting to compare this to <a hreflang="en" href="https://www.netmeister.org/blog/https-rrs.html#current-use">similar research done by Jan Schaumann in October 2023</a>, who found that for over 100 million tested domains, only about 4% provided HTTPS records, which increased to a whopping 25%+ for the top 1 million domains on the Tranco list. He <a hreflang="en" href="https://www.netmeister.org/blog/https-rrs.html#iphints">concluded</a> that DNS HTTPS record adoption is "effectively driven by Cloudflare setting the records by default on all of their domains". This would be in-line with our previous findings that it is the big CDNs that drive new feature adoption, so let's see what our data says:

<figure>
  <table>
    <thead>
      <tr>
        <th class="no-wrap"><code>h3</code> DNS records</th>
        <th>CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>&gt; 60%</td>
        <td>None (yet!)</td>
      </tr>
      <tr>
        <td>50% - 60%</td>
        <td>Cloudflare</td>
      </tr>
      <tr>
        <td>2% - 50%</td>
        <td>BunnyCDN, Alibaba</td>
      </tr>
      <tr>
        <td>&lt; 2%</td>
        <td>Akamai, Amazon Cloudfront, Microsoft Azure, Fastly, Netlify, Google, Incapsula, Azion, Sucuri Firewall, Vercell</td>
      </tr>
      <tr>
        <td>&lt; 0.05%</td>
        <td>Automattic, OVH </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentage of DNS HTTPS responses with HTTP/3 support for all home pages served by first-party CDNs (with considerable traffic share)", sheets_gid="1008841718", sql_file="dns_https_svcb_usage_cdn.sql") }}</figcaption>
</figure>

We can indeed see that Cloudflare is clearly the leader of the pack here, setting `h3` in the HTTPS DNS record for over 50% of its hosted sites. Most of the other large CDNs do seem to have some support and are testing the feature, but they rarely get above 2%. An interesting outlier here is Automattic, which had near universal HTTP/3 support via `alt-svc`, but only 0.04% for DNS HTTPS records. Outside this, of the 8.5 million pages not loaded via a CDN, only 0.46% had a DNS HTTPS record configured for HTTP/3 support, again reinforcing our conclusion that (for better or worse) CDNs are the ones driving adoption of cutting edge features at scale.

It will be interesting to track the use of DNS HTTPS and SVCB records in the coming years of the Web Almanac to both see how their adoption evolves, and how that will map to actual HTTP/3 use in the dataset.

### Happy eyeballs, connection coalescing and agressive switching

_TODO: don't know if we want to go too deep into the details without actual results here. If Barry can get some results for how often chrome actually switches from H2 to HTTP/3 DURING a page load, we might want to keep this section in. Otherwise, it might bog the text down too much imo._

In practice, the browser won't open just the HTTP/3 connection. After all, even if the server supports it, the network might still block the newer protocol and we'd still get a slow fallback. To get around this, the browser actually opens both an HTTP/2 and HTTP/3 connection in parallel, racing them against each other. Whichever connection is established first—with a small head start of about 200ms for HTTP/3—will get used and the other abandoned. This process, amusingly called [happy eyeballs](https://wikipedia.org/wiki/Happy_Eyeballs) (for real!), makes sure we get the fastest possible performance, and also that we automatically fall back to HTTP/2 if the network blocks HTTP/3.

_TODO: Discuss connection coalescing also being a factor in seeing less HTTP/3 than otherwise possible (existing H2 connections are reused)._

_TODO: Discuss browsers switching protocols DURING a page load and how that can skew performance measurements (you get hybrid H2/HTTP/3 loads), both synthetic and RUM._

### Conclusion

_TODO: depends on if we add the previous section or not_

Generally: we see HTTP/3 adoption evolve steadily over time, at a similar pace to HTTP/2. Like H2 though, probably will be a long time before it has huge adoption across the board for reasons XYZ. CDNs are both good and not-so-good (probably). New things are complex to deploy yourself; we need more documentation (like this post).

Difficult to measure perf benefits of HTTP/3 vs H2 in this dataset due to the methodology, and you should take care to do it correctly yourself as well!
 

## Resource Hints

As we've seen in the first part of this chapter, the adoption of HTTP/2 and HTTP/3 are on the rise, and that's a good thing. These new protocols implement a lot of performance and security best practices that have tangible benefits for end users. For developers however, the protocols and their features often remain a black box, as there are very few ways to tune them directly. You basically just tick a box on your CDN or server configuration, and hope the browser and server get it right. 

However, there are a few higher-level features (such as image lazy loading, async/defer javascript, resource hints, fetchpriority, etc.), that allow us to influence what happens on the network to an extent. Even though these are not technically always directly tied to HTTP as a protocol, they can have a major impact on how some protocol features (such as connection establishment and resource multiplexing) are used in practice, so we discuss some of them in this chapter. 

Firstly, there are the "[Resource Hints](https://web.dev/learn/performance/resource-hints)", a group of directives that can be used to guide the browser in various network-related operations, from setting up (parts of) a network connection, over loading a single resource, to doing fetches of entire pages ahead of time. The main ones are `dns-prefetch`, `preconnect`, `preload`, `prefetch`, and `modulepreload` (with the original `prerender` having a bit of a hard time finding its place in the ecosystem, with that use case now moving mostly to the new [Speculation Rules API](https://developer.chrome.com/docs/web-platform/prerender-pages)). 

{{ figure_markup(
  image="resource_hint_usage.png",
  caption="Resource Hint usage is quite high in our dataset, especially for dns-prefetch and preconnect.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=1911615919&format=interactive",
  sheets_gid="1668151954",
  sql_file="resource_hint_usage.sql"
) }}

These directives have found an impressive uptake over the years, with over 30% of all pages in our dataset using `dns-prefetch`, 28% utilizing `preconnect` and `preload` closing in on 20%. Personally, I find the high usage of `dns-prefetch` somewhat surprising, as in my opinion you should almost always use `preconnect` instead, as it does more (establishing the full connection including TCP+TLS or QUIC handshakes) with negligent overhead, and is also [very well supported](https://caniuse.com/link-rel-preconnect). Furthermore (though purely anecdotally), I often see developers use both `dns-prefetch` and `preconnect` right after each other for the same domain, which is completely useless, as `preconnect` automatically includes a DNS lookup as well. Still, a high use of these directives is good for overall performance, as it helps hide connection setup latency to subdomains or 3rd party domains that might host important assets, such as images or fonts. 

Some (at least to me) unexpected yet good news is that very few pages seem to overuse these hints. In general, you should rely on the browser to get things right itself (through features like the [preload scanner](https://web.dev/articles/preload-scanner)) and only use the Resource Hints sparingly for those cases where you know the browser doesn't have enough information (for example when the 3rd party domain/resource is not mentioned in the HTML directly but only in a CSS/JS file). And this is exactly what most people have been doing (yay!): even at the 90th percentile, pages will only use 3 `dns-prefetch`, 2 `preconnect` and 2 `preload` directives, which is great! Specifically for `preload`, we also looked at how many resources are preloaded in vain (i.e., not actually used on the page), and the results were again very encouraging: less than 4% of desktop pages uselessly preload 1 or 2 resources, and less than 2% have 3 or more unused preloads!

{{ figure_markup(
  caption="The percentage of pages that preload 1 or 2 resources without actually using them.",
  content="&lt;4%",
  classes="big-number",
  sheets_gid="1786847725",
  sql_file="unused_preloads.sql"
) }}

Still, even though most pages seem to get it right, it's always fun to look at some of the worst offenders, as there will always be pages that include way to many hints, usually either due to misconfiguration or a misunderstanding of what the features are supposed to do. For example, one page had a whopping 3215 preloads! Looking more closely however, it was clear that they are preloading the exact same image over and over again, most likely due to a misconfiguration of their framework/bug in their code. The second worst offender took it easy with "just" 2583 preloads, all of different versions/subsets of various asian fonts from Google Fonts. Finally, one page preloads an amazing 1259 images, turning them into a "smooth" scrolling background animation; arguably, you could say here preload is actually used in a good way to improve the intended effect, though I wouldn't recommend it in general! Luckily as well, some of the worst problem cases in our dataset have been fixed since our June 2024 crawl, such as a "Sexy Pirate Poker" site going from 2095 to just 14 preloads (steady as she goes, mateys!). A final silver lining is that no pages had more than 1000 `dns-prefetch` or `preconnect` directives (the worst ones utilized a measly 590 and 441 domains respectively).

### preload

Let's take a deeper look at `preload` specifically, as it is one of the more powerful hints that is [widely supported](https://caniuse.com/link-rel-preload), and it can have a large impact on performance, both positively and negatively (if used incorrectly). Generally speaking, `preload` should mainly be used to inform the browser of resources that are not linked directly in the main HTML document (such as things loaded dynamically with JS `fetch()` or CSS `@import` and `url()`), but that you as a developer know will be important/needed later. Preloading them allows the browser to request them earlier from the server, which may improve performance (but also degrade it, if you try to preload too much). Good concrete examples include fonts (which are typically loaded via CSS _and_ only requested by the browser when it actually needs them to render text), JS submodules or components imported dynamically, and (Largest Contentful Paint) images that are loaded via CSS or JS (which you probably shouldn't do in the first place, but sometimes there's no other option).

As we saw above, about 20% of all pages utilizes `preload`, and because you have to explicitly indicate which type of resource you're trying to preload with the `as` attribute, we can get some more information on how exactly people are using it.

{{ figure_markup(
  image="preload_as_values.png",
  caption="Preload is typically used for fonts, stylesheets and scripts.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQhHn7aWiJiMSVu3o872Lxr45NNZkG7jKa_MyL7aPwdga8gul19txh36PL2Ep4GRcaSYzpvLc-oc_xg/pubchart?oid=1325658118&format=interactive",
  sheets_gid="36366381",
  sql_file="preload_as_values.sql"
) }}

As expected, fonts are the most popular target for preloads, occurring on about 8.6% of pages. Somewhat unexpected however was the high use of preload for stylesheets and scripts. While these could be useful (though that would mean over 7.5% of pages should [reduce their critical path depth](https://www.debugbear.com/blog/avoid-chaining-critical-requests)), in practice people often misuse the feature by preloading resources right before they're mentioned in the HTML; say by having a `<link rel=preload>` for `style.css` the line above the `<link rel=stylesheet>` for the same file, which doesn't really do anything. A worse problem I've seen is that people `preload` their `async` and `defer` JS files, often those that are loaded via a `<script>` tag at the bottom of the `<body>`. This is not as harmless as it might seem, as these preloads can end up actively delaying other resources (such as actual render blocking JS and important images). This is because the browser doesn't know these scripts will be tagged as async/defer when they're actually loaded, so [it defaults to loading them _as if they're render blocking scripts_ with a high priority!](https://youtu.be/MV034VqHv5Q?t=838). We didn't run the queries to see how many of the 7.5% of pages misuse `preload` like this, but from my personal experience, it's pretty widespread. 

A positive note is that fewer than 4% of pages preload an image, which I had expected to be a lot higher. Similar to CSS and JS, preloading a dynamically loaded image (especially if it's the LCP element), can conceptually be a good thing. However, in my job I have come across many cases where pages unnecessarily preloaded the LCP image even if it was just present in the HTML directly (for example as an `img` or `picture` tag). This is somewhat of an anti-pattern, as firstly (like the CSS above) the browser typically discovers the image early enough even without preload (so it doesn't actually help). Secondly (like the async/defer JS case above), preloading images has enough rough edges that [it can become an easy footgun](https://youtu.be/p0lFyPuH8Zs?t=2038) causing other important resources to get delayed; nowadays, you're better off to just have your LCP in the HTML with `fetchpriority=high`, see below. Luckily, it seems like this anti-pattern was over-represented in the projects I encountered, and most pages in the wild rely on the normal browser heuristics to discover images. 

As with the general resource hints, it's also interesting to look at outliers and obvious mistakes. For `preload` to function, you MUST set the `as` attribute, and it [can only be set to a select few types](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel/preload): `fetch, font, image, script, style, track`. Anything else will cause the preload to be in vain. As such, it's interesting to see over 17000 pages (about 0.11% overall) use an empty value, with 0.03% - 0.01% utilizing values like stylesheet, document, or video. Other (luckily much less frequent) values include: the fancy "Cormorant Garamond Bold", the cool "slick", the spicy "habanero" and the supercalifragilisticexpialidocious "Poppins". 

Finally, it's worth mentioning that you need a special flavor of `preload` for the newer style JavaScript modules (`<script type=module>`), which is (predictably) called `modulepreload`. The reasons for this are [related to CORS](https://web.dev/articles/modulepreload) (yes that thing again) and not really worth getting into here. However, it's interesting that even though about 9.6% of all desktop pages already use JS modules (which I found impressively high), only about 13% of them (1.24% of all pages) also use `modulepreload`. I would have expected this to be a bit higher, since the JS modules mechanism has [extensive support for dynamically loading code](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules#dynamic_module_loading), which could work well together with clever `modulepreload` usage to improve performance. 


<!-- Total pages with js type=module: [9.63%](https://docs.google.com/spreadsheets/d/16isMe5_rvmRmJHtK5Je66AhwO8SowGgq0EFqXyjEXw8/edit?gid=805470577#gid=805470577).
  desktop had 2,326,372 out of 24,168,022 pages with module, which is 9.63%
  for the HTTP data https://docs.google.com/spreadsheets/d/1PfTZkbmgyLA3NmEICeCyxpMWgP7cKY7EsZl9RciE5S4/edit?gid=1668151954#gid=1668151954,
  we had a total of 137,228 + 162,835 = 300,063 of pages with modulepreload, which is 1.24% of total,
  and 300,063 / 2,326,372 = 13% of all pages with type=module use modulepreload
-->


### 103 Early Hints

_discuss that resource hints can be in HTML, but also as HTTP headers! Used very sparingly on HTML response headers though (just 5500 desktop sites, about 0.04% of our total dataset), BUT new feature 103 Early Hints allows you to send them earlier!_

_EH usage also still very low, with just shopify taking the majority here. Somewhat surprising, since free feature on Cloudflare, BUT it does require manual configuration on the origin (which only Shopify seems to have taken much effort to do) + [has been disabled a few times](https://community.cloudflare.com/t/early-hints-and-encrypted-client-hello-ech-are-currently-disabled-globally/567730). Also: due to this done in June, before other big deployments like Akamai released them, difficult to estimate actual usage of Early Hints in November 2024. Would expect this to rise quite a bit for next year._

_not much to tell for these low results, but preconnect is about 2 from p10 to p90 (preconnecting to https://cdn.shopify.com twice, once with and once without crossorigin), while preload is 1 at p75 and 2 at p90_
_preload is mostly fonts with a little bit of script and style (see Early Hints usage "as" percentile), as you'd expect, BUT are also some images in there. Possible, but reminder that responsive images cannot be early hinted, see blogpost info, so you should only early hint images if they're not responsive!_

## The Fetch Priority API

_One of the main reasons to switch from HTTP/1.1 to HTTP/2 and HTTP/3 is because you need fewer connections: stuff gets multiplexed on a single connection, while on HTTP/1.1 you'd open multiple parallel connections. While difference now is less stark than a few years ago (TODO: image? + link to few years ago), it's still impactful._

_INSERT IMAGE HERE_

_Still, resources sharing a connection means we need to somehow decided what needs to be downloaded first, as we dont' have enough bandwidth to just download everthing in one big parallel flow. This is governed by the prioritization mechanism. Too complex to discuss in detail here, see blogpost + talks + paper + web.dev. In short: browsers indicate to the server which resources are most important (e.g., HTML, CSS in the <head>) and which are less critical (images in the <body>, javascript tagged as async/defer). The server then sends back resources in priority order (high to low)_ 

_Browsers use heuristics to determine these priorities, but sometimes get it wrong. Additionally, browsers don't always know which individual resources will be most important. Good example is LCP image: impossible to know until it's loaded, and that's of course too late. For these reasons, we have the Fetch Priority API! Lets us tweak the browser heuristics with high(er) and low(er) values. Works on images, but also preload, script, style... quite powerful!_

_So let's see what adoption has been like for this new powerful feature!_


### preload again

_fetchpriority: see below, basically: can use high and low to influence how the preload works (see WLS talk)._
_TODO: discuss results from preload as values with fetchpriority -> lots of scripts with low, lots of images with high_


## Conclusion





Resource Hints and the FetchPriority API
Introduction
Preload 
Overall adoption 2022 + average amount of preloads per page NEW
Resource types NEW (grouped by “as” is probably enough? Maybe also include type and crossorigin?)
Use of fetchpriority NEW (ideally also grouped by “as” to see if it’s mostly images or not. Also ideally split between high vs low)
Amount of unused preloads NEW (both total amount seen in the entire dataset, as the “top 5 worst cases”. Like: 1 site had 200 preloads of which 170 were not used)
Amount of preloaded LCP images NEW (if HTTP Archive tracks which image was eventually the LCP, we can see how many pages preload the LCP image. Would also be interesting to see how many pages use preloads but do NOT preload the LCP image)
Preconnect
Overall adoption NEW + average amount of preconnects per page NEW
Amount of unused preconnects NEW (similar to above, though potentially harder to track? Not sure if chrome gives warning if preconnected domain isn’t used like with unused preloads?)
FetchPriority
Note: only as direct attribute on resource tags (not preload, tracked above)
Overall adoption 2022
Show how many resources change priority during page load (e.g., images being promoted from low/medium to high)  NEW (ideally split by resource type, should be mostly/only images?)
Not sure if HTTP Archive tracks which image is eventually identified as LCP, but ideally we’d also extract how many LCP images are loaded as low vs medium vs high (with fetchprio) to get an idea of the “window of opportunity”)
Show how many images were erroneously tagged with both loading=lazy and fetchpriority=high  NEW
103 Early Hints 
NOTE: i’ve for now split up Resource Hints and 103 Early Hints because I want to emphasize 103 as something new. Arguably though, you could put a “103 subsection” with each of the parts above as well and treat it like that… I like the separation more for now. 
Introduction
Overall adoption 2022 + amount of preloads/preconnects that are being sent NEW 
Resource types in preload NEW (grouped by “as” is probably enough? Maybe also include type and crossorigin?)
Overlap of preloaded resources with actual <head>/waterfall NEW (103 early hint preloads should ideally be for high priority resources that are needed at the start of the page load. We should give an indication of how early in the loading process the early hints were actually needed/used. Though this needs a bit more thinking on how exactly to approach… potentially just used vs unused like above?)
Get an estimate of actual benefits gained/size of window of opportunity NEW (I want to get an idea of how much time we actually gain from 103 Early hints, at least from the WPT test vantage point. The simplest form is to look at time between when the Early Hints headers arrive and the time when the first bytes of the HTML arrive (that’s how much time you had on the network to download extra stuff). The more complex form would be to see how many KB you actually downloaded during that time as well (not sure how WPT surfaces that though…)


