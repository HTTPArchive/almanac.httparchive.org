---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: CDN chapter of the 2019 Web Almanac covering CDN adoption and usage, RTT and TLS management, HTTP/2 adoption, caching and common library and content CDNs.
authors: [andydavies, colinbendell]
reviewers: [yoavweiss, paulcalvano, pmeenan, enygren]
analysts: [raghuramakrishnan71, rviscomi]
editors: [rviscomi]
translators: []
discuss: 1772
results: https://docs.google.com/spreadsheets/d/1Y7kAxjxUl8puuTToe6rL3kqJLX1ftOb0nCcD8m3lZBw/
andydavies_bio: Andy Davies is a Freelance Web Performance Consultant and has helped some of the UK's leading retailers, newspapers and financial services companies to make their sites faster. He wrote The Pocket Guide to Web Performance, is co-author of Using WebPageTest and also an organizer of the London Web Performance meetup. You can find Andy on Twitter as <a href="https://twitter.com/andydavies">@AndyDavies</a>, and he occasionally blogs at <a hreflang="en" href="https://andydavies.me">https://andydavies.me</a>
colinbendell_bio: Colin is part of the CTO Office at <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a> and co-author of the O'Reilly book <a hreflang="en" href="https://www.oreilly.com/library/view/high-performance-images/9781491925799/">High Performance Images</a>. He spends much of his time at the intersection of high volume data, media, browsers and standards. You can find him on tweeting <a href="https://twitter.com/colinbendell">@colinbendell</a> and at blogging at <a hreflang="en" href="https://bendell.ca/">https://bendell.ca</a>.
featured_quote: "Use a Content Delivery Network" was one of Steve Souders original recommendations for making web sites load faster. It's advice that remains valid today, and in this chapter of the Web Almanac we're going to explore how widely Steve's recommendation has been adopted, how sites are using Content Delivery Networks (CDNs), and some of the features they're using.
featured_stat_1: 20%
featured_stat_label_1: Home pages served by CDN
featured_stat_2: 9.61%
featured_stat_label_2: Homepages served by most popular CDN (Cloudflare)
featured_stat_3: 30%
featured_stat_label_3: 3P CDN requests that use Google
---

## Introduction

"Use a Content Delivery Network" was one of [Steve Souders original recommendations](http://stevesouders.com/examples/rules.php) for making web sites load faster. It's advice that remains valid today, and in this chapter of the Web Almanac we're going to explore how widely Steve's recommendation has been adopted, how sites are using Content Delivery Networks (CDNs), and some of the features they're using.

Fundamentally, CDNs reduce latency—the time it takes for packets to travel between two points on a network, say from a visitor's device to a server—and latency is a key factor in how quickly pages load.

A CDN reduces latency in two ways: by serving content from locations that are closer to the user and second, by terminating the TCP connection closer to the end user.

Historically, CDNs were used to cache, or copy, bytes so that the logical path from the user to the bytes becomes shorter. A file that is requested by many people can be retrieved once from the origin (your server) and then stored on a server closer to the user, thus saving transfer time.

CDNs also help with TCP latency. The latency of TCP determines how long it takes to establish a connection between a browser and a server, how long it takes to secure that connection, and ultimately how quickly content downloads. At best, network packets travel at roughly two-thirds of the speed of light, so how long that round trip takes depends on how far apart the two ends of the conversation are, and what's in between. Congested networks, overburdened equipment, and the type of network will all add further delays. Using a CDN to move the server end of the connection closer to the visitor reduces this latency penalty, shortening connection times, TLS negotiation times, and improving content download speeds.

Although CDNs are often thought of as just caches that store and serve static content close to the visitor, they are capable of so much more! CDNs aren't limited to just helping overcome the latency penalty, and increasingly they offer other features that help improve performance and security.

* Using a CDN to proxy dynamic content (base HTML page, API responses, etc.) can take advantage of both the reduced latency between the browser and the CDN's own network back to the origin.
* Some CDNs offer transformations that optimize pages so they download and render more quickly, or optimize images so they're the appropriate size (both dimensions and file size) for the device on which they're going to be viewed.
* From a [security](./security) perspective, malicious traffic and bots can be filtered out by a CDN before the requests even reach the origin, and their wide customer base means CDNs can often see and react to new threats sooner.
* The rise of [edge computing](https://en.wikipedia.org/wiki/Edge_computing) allows sites to run their own code close to their visitors, both improving performance and reducing the load on the origin.

Finally, CDNs also help sites to adopt new technologies without requiring changes at the origin, for example [HTTP/2](./http), TLS 1.3, and/or IPv6 can be enabled from the edge to the browser, even if the origin servers don't support it yet.

### Caveats and disclaimers

As with any observational study, there are limits to the scope and impact that can be measured. The statistics gathered on CDN usage for the Web Almanac does not imply performance nor effectiveness of a specific CDN vendor.

There are many limits to the testing [methodology](./methodology) used for the Web Almanac. These include:

* **Simulated network latency**: The Web Almanac uses a dedicated network connection that [synthetically shapes traffic](./methodology#webpagetest).
* **Single geographic location**: Tests are run from <a hreflang="en" href="https://httparchive.org/faq#how-is-the-data-gathered">a single datacenter</a> and cannot test the geographic distribution of many CDN vendors.
* **Cache effectiveness**: Each CDN uses proprietary technology and many, for security reasons, do not expose cache performance.
* **Localization and internationalization**: Just like geographic distribution, the effects of language and geo-specific domains are also opaque to the testing.
* <a hreflang="en" href="https://github.com/WPO-Foundation/wptagent/blob/master/internal/optimization_checks.py#L51">CDN detection</a> is primarily done through DNS resolution and HTTP headers. Most CDNs use a DNS CNAME to map a user to an optimal datacenter. However, some CDNs use AnyCast IPs or direct A+AAAA responses from a delegated domain which hide the DNS chain. In other cases, websites use multiple CDNs to balance between vendors which is hidden from the single-request pass of [WebPageTest](./methodology#webpagetest). All of this limits the effectiveness in the measurements.

Most importantly, these results reflect a potential utilization but do not reflect actual impact. YouTube is more popular than "ShoesByColin" yet both will appear as equal value when comparing utilization.

With this in mind, there are a few intentional statistics that were not measured with the context of a CDN:
* **TTFB**: Measuring the Time to first byte _by CDN_ would be intellectually dishonest without proper knowledge about cacheability and cache effectiveness. If one site uses a CDN for **round trip time** (RTT) management but not for caching, this would create a disadvantage when comparing another site that uses a different CDN vendor but does also caches the content.  _(Note: this does not apply to the TTFB analysis in the [Performance](./performance#time-to-first-byte) chapter because it does not draw conclusions about the performance of individual CDNs.)_
* **Cache Hit vs. Cache Miss performance**: As mentioned previously, this is opaque to the testing apparatus and therefore repeat tests to test page performance with a cold cache vs. a hot cache are unreliable.

### Further stats

In future versions of the Web Almanac, we would expect to look more closely at the TLS and RTT management between CDN vendors. Of interest would the impact of OCSP stapling, differences in TLS Cipher performance. CWND (TCP congestion window) growth rate, and specifically the adoption of BBR v1, v2, and traditional TCP Cubic.

## CDN adoption and usage

For websites, a CDN can improve performance for the primary domain (`www.shoesbycolin.com`), sub-domains or sibling domains (`images.shoesbycolin.com` or `checkout.shoesbycolin.com`), and finally third parties (Google Analytics, etc.). Using a CDN for each of these use cases improves performance in different ways.

Historically, CDNs were used exclusively for static resources like [CSS](./css), [JavaScript](./javascript), and [images](./media). These resources would likely be versioned (include a unique number in the path) and cached long-term. In this way we should expect to see higher adoption of CDNs on sub-domains or sibling domains compared to the base HTML domains. The traditional design pattern would expect that `www.shoesbycolin.com` would serve HTML directly from a datacenter (or **origin**) while `static.shoesbycolin.com` would use a CDN.

{{ figure_markup(
  image="fig1.png",
  caption="CDN usage vs. origin-hosted resources.",
  description="Stacked bar chart showing HTML is 80% served from origin, 20% from CDN, Sub-domains are 61%/39%, third-party is 34%/66%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=777938536&format=interactive"
  )
}}

Indeed, this traditional pattern is what we observe on the majority of websites crawled. The majority of web pages (80%) serve the base HTML from origin. This breakdown is nearly identical between mobile and desktop with only 0.4% lower usage of CDNs on desktop. This slight variance is likely due to the small continued use of mobile specific web pages ("mDot"), which more frequently use a CDN.

Likewise, resources served from sub-domains are more likely to utilize a CDN at 40% of sub-domain resources. Sub-domains are used either to partition resources like images and CSS or they are used to reflect organizational teams such as checkout or APIs.

Despite first-party resources still largely being served directly from origin, third-party resources have a substantially higher adoption of CDNs. Nearly 66% of all third-party resources are served from a CDN. Since third-party domains are more likely a SaaS integration, the use of CDNs are more likely core to these business offerings. Most third-party content breaks down to shared resources (JavaScript or font CDNs), augmented content (advertisements), or statistics. In all these cases, using a CDN will improve the performance and offload for these SaaS solutions.

## Top CDN providers
There are two categories of CDN providers: the generic and the purpose-fit CDN. The generic CDN providers offer customization and flexibility to serve all kinds of content for many industries. In contrast, the purpose-fit CDN provider offers similar content distribution capabilities but are narrowly focused on a specific solution.

This is clearly represented when looking at the top CDNs found serving the base HTML content. The most frequent CDNs serving HTML are generic CDNs (Cloudflare, Akamai, Fastly) and cloud solution providers who offer a bundled CDN (Google, Amazon) as part of the platform service offerings. In contrast, there are only a few purpose-fit CDN providers, such as Wordpress and Netlify, that deliver base HTML markup.

<p class="note">Note: This does not reflect traffic or usage, only the number of sites using them.</p>

{{ figure_markup(
  image="html_cdn_usage.png",
  caption="HTML CDN usage.",
  description="Treemap graph showing the data from Table 3."
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">HTML CDN Usage (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">80.39</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">9.61</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">5.54</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">1.08</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">1.05</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0.79</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">0.37</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0.31</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0.28</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">0.1</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0.08</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">0.04</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">0.03</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0.03</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0.02</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Level 3</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Instart Logic</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Azion</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Yunjiasu</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0.01</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 25 CDNs for HTML by site.") }}</figcaption>
</figure>

Sub-domain requests have a very similar composition. Since many websites use sub-domains for static content, we see a shift to a higher CDN usage. Like the base page requests, the resources served from these sub-domains utilize generic CDN offerings.

{{ figure_markup(
  image="subdomain_resource_cdn_usage.png",
  caption="Sub-domain resource CDN usage.",
  description="Treemap graph showing the data from Table 5."
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Sub-Domain CDN Usage (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">60.56</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">10.06</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">8.86</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">6.24</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">3.5</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">1.97</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">1.69</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">1.24</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td class="numeric">1.18</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0.8</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">0.43</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td class="numeric">0.41</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0.37</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0.36</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0.29</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0.28</td>
      </tr>
      <tr>
        <td>Reflected Networks</td>
        <td class="numeric">0.28</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0.16</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td class="numeric">0.13</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0.12</td>
      </tr>
      <tr>
        <td>Advanced Hosters CDN</td>
        <td class="numeric">0.1</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">0.07</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td class="numeric">0.07</td>
      </tr>
      <tr>
        <td>Level 3</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td class="numeric">0.06</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 25 resource CDNs for sub-domain requests.") }}</figcaption>
</figure>

The composition of top CDN providers dramatically shifts for third-party resources. Not only are CDNs more frequently observed hosting third-party resources, there is also an increase in purpose-fit CDN providers such as Facebook, Twitter, and Google.

{{ figure_markup(
  image="thirdparty_resource_cdn_usage.png",
  caption="Third-party resource CDN usage.",
  description="Treemap graph showing the data from Table 7.",
  width=600,
  height=376
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Third-Party CDN Usage (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">34.27</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">29.61</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td class="numeric">8.47</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">5.25</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">5.14</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">4.21</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">3.87</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">2.06</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">1.45</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td class="numeric">1.27</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0.94</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0.77</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">0.3</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>jsDelivr</td>
        <td class="numeric">0.2</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0.18</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td class="numeric">0.18</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td class="numeric">0.17</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td class="numeric">0.16</td>
      </tr>
      <tr>
        <td>Reapleaf</td>
        <td class="numeric">0.15</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">0.14</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td class="numeric">0.13</td>
      </tr>
      <tr>
        <td>Azion</td>
        <td class="numeric">0.09</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td class="numeric">0.09</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 25 resource CDNs for third-party requests.") }}</figcaption>
</figure>

## RTT and TLS management

CDNs can offer more than simple caching for website performance. Many CDNs also support a pass-through mode for dynamic or personalized content when an organization has a legal or other business requirement prohibiting the content from being cached. Utilizing a CDN's physical distribution enables increased performance for TCP RTT for end users. As <a hreflang="en" href="https://www.igvita.com/2012/07/19/latency-the-new-web-performance-bottleneck/">others have noted</a>, <a hreflang="en" href="https://hpbn.co/primer-on-latency-and-bandwidth/">reducing RTT is the most effective means to improve web page performance</a> compared to increasing bandwidth.

Using a CDN in this way can improve page performance in two ways:

1. Reduce RTT for TCP and TLS negotiation. The speed of light is only so fast and CDNs offer a highly distributed set of data centers that are closer to the end users. In this way the logical (and physical) distance that packets must traverse to negotiate a TCP connection and perform the TLS handshake can be greatly reduced.

  Reducing RTT has three immediate benefits. First, it improves the time for the user to receive data, because TCP+TLS connection time are RTT-bound. Secondly, this will improve the time it takes to grow the congestion window and utilize the full amount of bandwidth the user has available. Finally, it reduces the probability of packet loss. When the RTT is high, network interfaces will time-out requests and resend packets. This can result in double packets being delivered.

2. CDNs can utilize pre-warmed TCP connections to the back-end origin. Just as terminating the connection closer to the user will improve the time it takes to grow the congestion window, the CDN can relay the request to the origin on pre-established TCP connections that have already maximized congestion windows. In this way the origin can return the dynamic content in fewer TCP round trips and the content can be more effectively ready to be delivered to the waiting user.

## TLS negotiation time: origin 3x slower than CDNs

Since TLS negotiations require multiple TCP round trips before data can be sent from a server, simply improving the RTT can significantly improve the page performance. For example, looking at the base HTML page, the median TLS negotiation time for origin requests is 207 ms (for desktop WebPageTest). This alone accounts for 10% of a 2 second performance budget, and this is under ideal network conditions where there is no latency applied on the request.

In contrast, the median TLS negotiation for the majority of CDN providers is between 60 and 70 ms. Origin requests for HTML pages take almost 3x longer to complete TLS negotiation than those web pages that use a CDN. Even at the 90th percentile, this disparity perpetuates with origin TLS negotiation rates of 427 ms compared to most CDNs which complete under 140 ms!

<p class="note">A word of caution when interpreting these charts: it is important to focus on orders of magnitude when comparing vendors as there are many factors that impact the actual TLS negotiation performance. These tests were completed from a single datacenter under controlled conditions and do not reflect the variability of the internet and user experiences.</p>

{{ figure_markup(
  image="html_tls_negotiation_time.png",
  caption="HTML TLS negotiation time.",
  description="Graph showing the data from Table 9."
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col"><span class="visually-hidden">10th percentile</span><span aria-hidden="true">p10</span></th>
        <th scope="col"><span class="visually-hidden">25th percentile</span><span aria-hidden="true">p25</span></th>
        <th scope="col"><span class="visually-hidden">50th percentile</span><span aria-hidden="true">p50</span></th>
        <th scope="col"><span class="visually-hidden">75th percentile</span><span aria-hidden="true">p75</span></th>
        <th scope="col"><span class="visually-hidden">90th percentile</span><span aria-hidden="true">p90</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">58</td>
        <td class="numeric">58</td>
        <td class="numeric">60</td>
        <td class="numeric">66</td>
        <td class="numeric">94</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">56</td>
        <td class="numeric">59</td>
        <td class="numeric">63</td>
        <td class="numeric">69</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">58</td>
        <td class="numeric">62</td>
        <td class="numeric">76</td>
        <td class="numeric">77</td>
        <td class="numeric">80</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">63</td>
        <td class="numeric">66</td>
        <td class="numeric">77</td>
        <td class="numeric">80</td>
        <td class="numeric">86</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">59</td>
        <td class="numeric">61</td>
        <td class="numeric">62</td>
        <td class="numeric">83</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">62</td>
        <td class="numeric">68</td>
        <td class="numeric">80</td>
        <td class="numeric">92</td>
        <td class="numeric">103</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">57</td>
        <td class="numeric">59</td>
        <td class="numeric">72</td>
        <td class="numeric">93</td>
        <td class="numeric">134</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">62</td>
        <td class="numeric">93</td>
        <td class="numeric">97</td>
        <td class="numeric">98</td>
        <td class="numeric">101</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">94</td>
        <td class="numeric">97</td>
        <td class="numeric">100</td>
        <td class="numeric">110</td>
        <td class="numeric">221</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">47</td>
        <td class="numeric">53</td>
        <td class="numeric">79</td>
        <td class="numeric">119</td>
        <td class="numeric">184</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">114</td>
        <td class="numeric">115</td>
        <td class="numeric">118</td>
        <td class="numeric">120</td>
        <td class="numeric">122</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">105</td>
        <td class="numeric">108</td>
        <td class="numeric">112</td>
        <td class="numeric">120</td>
        <td class="numeric">210</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">96</td>
        <td class="numeric">100</td>
        <td class="numeric">111</td>
        <td class="numeric">139</td>
        <td class="numeric">243</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">53</td>
        <td class="numeric">64</td>
        <td class="numeric">73</td>
        <td class="numeric">145</td>
        <td class="numeric">166</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">95</td>
        <td class="numeric">106</td>
        <td class="numeric">118</td>
        <td class="numeric">226</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">217</td>
        <td class="numeric">219</td>
        <td class="numeric">223</td>
        <td class="numeric">234</td>
        <td class="numeric">260</td>
      </tr>
      <tr>
        <td><em>ORIGIN</em></td>
        <td class="numeric"><em>100</em></td>
        <td class="numeric"><em>138</em></td>
        <td class="numeric"><em>207</em></td>
        <td class="numeric"><em>342</em></td>
        <td class="numeric"><em>427</em></td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">85</td>
        <td class="numeric">143</td>
        <td class="numeric">229</td>
        <td class="numeric">369</td>
        <td class="numeric">452</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTML TLS connection time (ms).") }}</figcaption>
</figure>

For resource requests (including same-domain and third-party), the TLS negotiation time takes longer and the variance increases. This is expected because of network saturation and network congestion. By the time that a third-party connection is established (by way of a resource hint or a resource request) the browser is busy rendering and making other parallel requests. This creates contention on the network. Despite this disadvantage, there is still a clear advantage for third-party resources that utilize a CDN over using an origin solution.

{{ figure_markup(
  image="resource_tls_negotiation_time.png",
  caption="Resource TLS negotiation time.",
  description="Graph showing most CDNs have a TLS negotiation time of around 80 ms, but some (Microsoft Azure, Yahoo, Edgecast, ORIGIN, and CDNetworks) start to creep out towards 200 ms - especially when going above the 50th percentile."
  )
}}

TLS handshake performance is impacted by a number of factors. These include RTT, TLS record size, and TLS certificate size. While RTT has the biggest impact on the TLS handshake, the second largest driver for TLS performance is the TLS certificate size.

During the first round trip of the <a hreflang="en" href="https://hpbn.co/transport-layer-security-tls/#tls-handshake">TLS handshake</a>, the server attaches its certificate. This certificate is then verified by the client before proceeding. In this certificate exchange, the server might include the certificate chain by which it can be verified. After this certificate exchange, additional keys are established to encrypt the communication. However, the length and size of the certificate can negatively impact the TLS negotiation performance, and in some cases, crash client libraries.

The certificate exchange is at the foundation of the TLS handshake and is usually handled by isolated code paths so as to minimize the attack surface for exploits. Because of its low level nature, buffers are usually not dynamically allocated, but fixed. In this way, we cannot simply assume that the client can handle an unlimited-sized certificate. For example, OpenSSL CLI tools and Safari can successfully negotiate against <a hreflang="en" href="https://10000-sans.badssl.com">`https://10000-sans.badssl.com`</a>. Yet, Chrome and Firefox fail because of the size of the certificate.

While extreme sizes of certificates can cause failures, even sending moderately large certificates has a performance impact. A certificate can be valid for one or more hostnames which are are listed in the `Subject-Alternative-Name` (SAN). The more SANs, the larger the certificate. It is the processing of these SANs during verification that causes performance to degrade. To be clear, performance of certificate size is not about TCP overhead, rather it is about processing performance of the client.

Technically, TCP slow start can impact this negotiation but it is very improbable. TLS record length is limited to 16 KB, which fits into a typical initial congestion window of 10. While some ISPs might employ packet splicers, and other tools fragment congestion windows to artificially throttle bandwidth, this isn't something that a website owner can change or manipulate.

Many CDNs, however, depend on shared TLS certificates and will list many customers in the SAN of a certificate. This is often necessary because of the scarcity of IPv4 addresses. Prior to the adoption of `Server-Name-Indicator` (SNI) by end users, the client would connect to a server, and only after inspecting the certificate, would the client hint which hostname the user user was looking for (using the `Host` header in HTTP). This results in a 1:1 association of an IP address and a certificate. If you are a CDN with many physical locations, each location may require a dedicated IP, further aggravating the exhaustion of IPv4 addresses. Therefore, the simplest and most efficient way for CDNs to offer TLS certificates for websites that still have users that don't support SNI is to offer a shared certificate.

According to Akamai, the adoption of SNI is <a hreflang="en" href="https://datatracker.ietf.org/meeting/101/materials/slides-101-maprg-update-on-tls-sni-and-ipv6-client-adoption-00">still not 100% globally</a>. Fortunately there has been a rapid shift in recent years. The biggest culprits are no longer Windows XP and Vista, but now Android apps, bots, and corporate applications. Even at 99% adoption, the remaining 1% of 3.5 billion users on the internet can create a very compelling motivation for website owners to require a non-SNI certificate. Put another way, a pure play website can enjoy a virtually 100% SNI adoption among standard web browsers. Yet, if the website is also used to support APIs or WebViews in apps, particularly Android apps, this distribution can drop rapidly.

Most CDNs balance the need for shared certificates and performance. Most cap the number of SANs between 100 and 150. This limit often derives from the certificate providers. For example, <a hreflang="en" href="https://letsencrypt.org/docs/rate-limits/">LetsEncrypt</a>, <a hreflang="en" href="https://www.websecurity.digicert.com/security-topics/san-ssl-certificates">DigiCert</a>, and <a hreflang="en" href="https://www.godaddy.com/web-security/multi-domain-san-ssl-certificate">GoDaddy</a> all limit SAN certificates to 100 hostnames while <a hreflang="en" href="https://comodosslstore.com/comodo-mdc-ssl.aspx">Comodo</a>'s limit is 2,000. This, in turn, allows some CDNs to push this limit, cresting over 800 SANs on a single certificate. There is a strong negative correlation of TLS performance and the number of SANs on a certificate.

{{ figure_markup(
  image="fig11.png",
  caption="TLS SAN count for HTML.",
  description="Bar chart showing data from table 12.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=753130748&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col"><span class="visually-hidden">10th percentile</span><span aria-hidden="true">p10</span></th>
        <th scope="col"><span class="visually-hidden">25th percentile</span><span aria-hidden="true">p25</span></th>
        <th scope="col"><span class="visually-hidden">50th percentile</span><span aria-hidden="true">p50</span></th>
        <th scope="col"><span class="visually-hidden">75th percentile</span><span aria-hidden="true">p75</span></th>
        <th scope="col"><span class="visually-hidden">90th percentile</span><span aria-hidden="true">p90</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>section.io</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">7</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">8</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">53</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">8</td>
        <td class="numeric">19</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
        <td class="numeric">39</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">43</td>
        <td class="numeric">47</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">46</td>
        <td class="numeric">56</td>
        <td class="numeric">130</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">11</td>
        <td class="numeric">78</td>
        <td class="numeric">140</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">2</td>
        <td class="numeric">18</td>
        <td class="numeric">57</td>
        <td class="numeric">85</td>
        <td class="numeric">95</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">77</td>
        <td class="numeric">100</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">18</td>
        <td class="numeric">139</td>
        <td class="numeric">145</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">2</td>
        <td class="numeric">7</td>
        <td class="numeric">100</td>
        <td class="numeric">360</td>
        <td class="numeric">818</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="TLS SAN count for HTML.") }}</figcaption>
</figure>

{{ figure_markup(
  image="fig13.png",
  caption="Resource SAN count (50th percentile).",
  description="Bar chart showing the data from Table 14 for the 50th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=528008536&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col"><span class="visually-hidden">10th percentile</span><span aria-hidden="true">p10</span></th>
        <th scope="col"><span class="visually-hidden">25th percentile</span><span aria-hidden="true">p25</span></th>
        <th scope="col"><span class="visually-hidden">50th percentile</span><span aria-hidden="true">p50</span></th>
        <th scope="col"><span class="visually-hidden">75th percentile</span><span aria-hidden="true">p75</span></th>
        <th scope="col"><span class="visually-hidden">90th percentile</span><span aria-hidden="true">p90</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>section.io</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">6</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">3</td>
        <td class="numeric">3</td>
        <td class="numeric">35</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">5</td>
        <td class="numeric">20</td>
        <td class="numeric">54</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">1</td>
        <td class="numeric">10</td>
        <td class="numeric">11</td>
        <td class="numeric">55</td>
        <td class="numeric">68</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">16</td>
        <td class="numeric">98</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td class="numeric">6</td>
        <td class="numeric">6</td>
        <td class="numeric">79</td>
        <td class="numeric">79</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">98</td>
        <td class="numeric">98</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">2</td>
        <td class="numeric">43</td>
        <td class="numeric">99</td>
        <td class="numeric">99</td>
        <td class="numeric">99</td>
      </tr>
      <tr>
        <td>jsDelivr</td>
        <td class="numeric">2</td>
        <td class="numeric">116</td>
        <td class="numeric">116</td>
        <td class="numeric">116</td>
        <td class="numeric">116</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">132</td>
        <td class="numeric">178</td>
        <td class="numeric">397</td>
        <td class="numeric">398</td>
        <td class="numeric">645</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="10th, 25th, 50th, 75th, and 90th percentiles of the distribution of resource SAN count.") }}</figcaption>
</figure>

## TLS adoption

In addition to using a CDN for TLS and RTT performance, CDNs are often used to ensure patching and adoption of TLS ciphers and TLS versions. In general, the adoption of TLS on the main HTML page is much higher for websites that use a CDN. Over 76% of HTML pages are served with TLS compared to the 62% from origin-hosted pages.

{{ figure_markup(
  image="fig15.png",
  caption="HTML TLS version adoption (CDN vs. origin).",
  description="Stacked bar chart showing TLS 1.0 is used 0.86% of the time for origin, TLS 1.2 55% of the time, TLS 1.3 6% of the time, and unencrypted 38% of the time. For CDN this changes to 35% for TLS 1.2, 41% for TLS 1.3, and 24% for unencrypted.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1183502256&format=interactive"
  )
}}

Each CDN offers different rates of adoption for both TLS and the relative ciphers and versions offered. Some CDNs are more aggressive and roll out these changes to all customers whereas other CDNs require website owners to opt-in to the latest changes and offer change-management to facilitate these ciphers and versions.

{{ figure_markup(
  image="fig16.png",
  caption="HTML TLS adoption by CDN.",
  description="Division of secure vs non-secure connections established for initial HTML request broken down by CDN with some  CDNs (e.g. Wordpress) at 100%, most between 80%-100%, and then ORIGIN at 62%, Google at 51%, ChinaNetCenter at 36%, and Yunjiasu at 29%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=2053476423&format=interactive"
  )
}}

{{ figure_markup(
  image="fig17.png",
  caption="Third-party TLS adoption by CDN.",
  description="Stacked bar chart showing the vast majority of CDNs use TLS for over 90% of third-party requests, with a few stragglers in the 75% - 90% range, and ORIGIN lower than them all at 68%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=991037479&format=interactive"
  )
}}

Along with this general adoption of TLS, CDN use also sees higher adoption of emerging TLS versions like TLS 1.3.

In general, the use of a CDN is highly correlated with a more rapid adoption of stronger ciphers and stronger TLS versions compared to origin-hosted services where there is a higher usage of very old and compromised TLS versions like TLS 1.0.

<p class="note">It is important to emphasize that Chrome used in the Web Almanac will bias to the latest TLS versions and ciphers offered by the host. Also, these web pages were crawled in July 2019 and reflect the adoption of websites that have enabled the newer versions.</p>

{{ figure_markup(
  image="fig18.png",
  caption="HTML TLS version by CDN.",
  description="Bar chart showing that TLS 1.3 or TLS 1.2 is used by all CDNs when TLS is used. A few CDNs have adopted TLS 1.3 completely, some partially and a large proportion not at all and only using TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=659795773&format=interactive"
  )
}}

More discussion of TLS versions and ciphers can be found in the [Security](./security) and [HTTP/2](./http) chapters.

## HTTP/2 adoption

Along with RTT management and improving TLS performance, CDNs also enable new standards like HTTP/2 and IPv6. While most CDNs offer support for HTTP/2 and many have signaled early support of the still-under-standards-development HTTP/3, adoption still depends on website owners to enable these new features. Despite the change-management overhead, the majority of the HTML served from CDNs has HTTP/2 enabled.

CDNs have over 70% adoption of HTTP/2, compared to the nearly 27% of origin pages. Similarly, sub-domain and third-party resources on CDNs see an even higher adoption of HTTP/2 at 90% or higher while third-party resources served from origin infrastructure only has 31% adoption. The performance gains and other features of HTTP/2 are further covered in the [HTTP/2](./http) chapter.

<p class="note">Note: All requests were made with the latest version of Chrome which supports HTTP/2. When only HTTP/1.1 is reported, this would indicate either unencrypted (non-TLS) servers or servers that don't support HTTP/2.</p>

{{ figure_markup(
  image="fig19.png",
  caption="HTTP/2 adoption (CDN vs. origin).",
  description="Stacked bar chart showing 73% of Origin connections use HTTP/1.1, and 27% HTTP/2. This compares to CDNs where 29% are using HTTP/1.1 and 71% HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1166990011&format=interactive"
  )
}}

{{ figure_markup(
  image="fig20.png",
  caption="HTML adoption of HTTP/2.",
  description="Bar chart showing the data from Table 21.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1896876288&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">HTTP/0.9</th>
        <th scope="col">HTTP/1.0</th>
        <th scope="col">HTTP/1.1</th>
        <th scope="col">HTTP/2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0.38</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1.07</td>
        <td class="numeric">99</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1.56</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7.97</td>
        <td class="numeric">92</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">12.03</td>
        <td class="numeric">88</td>
      </tr>
      <tr>
        <td>Instart Logic</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">12.36</td>
        <td class="numeric">88</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">14.06</td>
        <td class="numeric">86</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">15.65</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">16.34</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">16.43</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">17.34</td>
        <td class="numeric">83</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">18.19</td>
        <td class="numeric">82</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">25.53</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">33.16</td>
        <td class="numeric">67</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">37.04</td>
        <td class="numeric">63</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">43.44</td>
        <td class="numeric">57</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">47.17</td>
        <td class="numeric">53</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0.06</td>
        <td class="numeric">50.05</td>
        <td class="numeric">50</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">52.45</td>
        <td class="numeric">48</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0</td>
        <td class="numeric">0.01</td>
        <td class="numeric">55.41</td>
        <td class="numeric">45</td>
      </tr>
      <tr>
        <td>Yunjiasu</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">70.96</td>
        <td class="numeric">29</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">0</td>
        <td class="numeric">0.1</td>
        <td class="numeric">72.81</td>
        <td class="numeric">27</td>
      </tr>
      <tr>
        <td>Zenedge</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">87.54</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">88.21</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>ChinaNetCenter</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">94.49</td>
        <td class="numeric">6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTML adoption of HTTP/2 by CDN.") }}</figcaption>
</figure>

{{ figure_markup(
  image="fig22.png",
  caption="HTML/2 adoption: third-party resources.",
  description="Bar chart showing the data from Table 23.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=397209603&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>cdn</th>
        <th>HTTP/0.9</th>
        <th>HTTP/1.0</th>
        <th>HTTP/1.1</th>
        <th>HTTP/2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jsDelivr</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">99</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">2</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">2</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">4</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">6</td>
        <td class="numeric">94</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7</td>
        <td class="numeric">93</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7</td>
        <td class="numeric">93</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7</td>
        <td class="numeric">93</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">8</td>
        <td class="numeric">92</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">10</td>
        <td class="numeric">90</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">14</td>
        <td class="numeric">86</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">16</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">17</td>
        <td class="numeric">83</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">26</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">26</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">27</td>
        <td class="numeric">73</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">30</td>
        <td class="numeric">70</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">42</td>
        <td class="numeric">58</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">43</td>
        <td class="numeric">57</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">0</td>
        <td class="numeric">0.01</td>
        <td class="numeric">47</td>
        <td class="numeric">53</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">56</td>
        <td class="numeric">44</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">68</td>
        <td class="numeric">31</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">0</td>
        <td class="numeric">0.07</td>
        <td class="numeric">69</td>
        <td class="numeric">31</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTML/2 adoption: third-party resources.") }}</figcaption>
</figure>

## Controlling CDN caching behavior

### `Vary`

A website can control the caching behavior of browsers and CDNs with the use of different HTTP headers. The most common is the `Cache-Control` header which specifically determines how long something can be cached before returning to the origin to ensure it is up-to-date.

Another useful tool is the use of the `Vary` HTTP header. This header instructs both CDNs and browsers how to fragment a cache. The `Vary` header allows an origin to indicate that there are multiple representations of a resource, and the CDN should cache each variation separately. The most common example is [compression](./compression). Declaring a resource as `Vary: Accept-Encoding` allows the CDN to cache the same content, but in different forms like uncompressed, with Gzip, or Brotli. Some CDNs even do this compression on the fly so as to keep only one copy available. This `Vary` header likewise also instructs the browser how to cache the content and when to request new content.

{{ figure_markup(
  image="use_of_vary_on_cdn.png",
  caption="Usage of <code>Vary</code> for HTML served from CDNs.",
  description="Treemap graph showing accept-encoding dominates vary usage with 73% of the chart taken up with that. Cookie (13%) and user-agent (8%) having some usage, then a complete mixed of other headers.",
  width=600,
  height=376
  )
}}

While the main use of `Vary` is to coordinate `Content-Encoding`, there are other important variations that websites use to signal cache fragmentation. Using `Vary` also instructs SEO bots like DuckDuckGo, Google, and BingBot that alternate content would be returned under different conditions. This has been important to avoid SEO penalties for "cloaking" (sending SEO specific content in order to game the rankings).

For HTML pages, the most common use of `Vary` is to signal that the content will change based on the `User-Agent`. This is short-hand to indicate that the website will return different content for desktops, phones, tablets, and link-unfurling engines (like Slack, iMessage, and Whatsapp). The use of `Vary: User-Agent` is also a vestige of the early mobile era, where content was split between "mDot" servers and "regular" servers in the back-end. While the adoption for responsive web has gained wide popularity, this `Vary` form remains.

In a similar way, `Vary: Cookie` usually indicates that content that will change based on the logged-in state of the user or other personalization.

{{ figure_markup(
  image="use_of_vary.png",
  caption="Comparison of <code>Vary</code> usage for HTML and resources served from origin and CDN.",
  description="Set of four treemap graphs showing that for CDNs serving home pages the biggest use of Vary is for Cookie, followed by User-agent. For CDNs serving other resources it's origin, followed by accept, user-agent, x-origin and referrer. For Origins and home pages it's user-agent, followed by cookie. Finally for Origins and other resources it's primarily user-agent followed by origin, accept, then range and host."
  )
}}

Resources, in contrast, don't use `Vary: Cookie` as much as the HTML resources. Instead these resources are more likely to adapt based on the `Accept`, `Origin`, or `Referer`. Most media, for example, will use `Vary: Accept` to indicate that an image could be a JPEG, WebP, JPEG 2000, or JPEG XR depending on the browser's offered `Accept` header.  In a similar way, third-party shared resources signal that an XHR API will differ depending on which website it is embedded. This way, a call to an ad server API will return different content depending on the parent website that called the API.

The `Vary` header also contains evidence of CDN chains. These can be seen in `Vary` headers such as `Accept-Encoding, Accept-Encoding` or even `Accept-Encoding, Accept-Encoding, Accept-Encoding`. Further analysis of these chains and `Via` header entries might reveal interesting data, for example how many sites are proxying third-party tags.

Many of the uses of the `Vary` are extraneous. With most browsers adopting double-key caching, the use of `Vary: Origin` is redundant. As is `Vary: Range` or `Vary: Host` or `Vary: *`. The wild and variable use of `Vary` is demonstrable proof that the internet is weird.

### `Surrogate-Control`, `s-maxage`, and `Pre-Check`

There are other HTTP headers that specifically target CDNs, or other proxy caches, such as the `Surrogate-Control`, `s-maxage`, `pre-check`, and `post-check` values in the `Cache-Control` header. In general usage of these headers is low.

`Surrogate-Control` allows origins to specify caching rules just for CDNs, and as CDNs are likely to strip the header before serving responses, its low visible usage isn't a surprise, in fact it's surprising that it's actually in any responses at all! (It was even seen from some CDNs that state they strip it).

Some CDNs support `post-check` as a method to allow a resource to be refreshed when it goes stale, and `pre-check` as a `maxage` equivalent. For most CDNs, usage of `pre-check` and `post-check` was below 1%. Yahoo was the exception to this and about 15% of requests had `pre-check=0, post-check=0`. Unfortunately this seems to be a remnant of an old Internet Explorer pattern rather than active usage. More discussion on this can be found in the [Caching](./caching) chapter.

The `s-maxage` directive informs proxies for how long they may cache a response. Across the Web Almanac dataset, jsDelivr is the only CDN where a high level of usage was seen across multiple resources—this isn't surprising given jsDelivr's role as a public CDN for libraries. Usage across other CDNs seems to be driven by individual customers, for example third-party scripts or SaaS providers using that particular CDN.

{{ figure_markup(
  image="fig26.png",
  caption="Adoption of <code>s-maxage</code> across CDN responses.",
  description="Bar chart showing 82% of jsDelivr serves responses with s-maxage, 14% of Level 3, 6.3% of Amazon CloudFront, 3.3% of Akamai, 3.1% of Fastly, 3% of Highwinds, 2% of Cloudflare, 0.91% of ORIGIN, 0.75% of Edgecast, 0.07% of Google.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1215102767&format=interactive"
  )
}}

With 40% of sites using a CDN for resources, and presuming these resources are static and cacheable, the usage of `s-maxage` seems low.

Future research might explore cache lifetimes versus the age of the resources, and the usage of `s-maxage` versus other validation directives such as `stale-while-revalidate`.

## CDNs for common libraries and content

So far, this chapter has explored the use of commercials CDNs which the site may be using to host its own content, or perhaps used by a third-party resource included on the site.

Common libraries like jQuery and Bootstrap are also available from public CDNs hosted by Google, Cloudflare, Microsoft, etc. Using content from one of the public CDNs instead of a self-hosting the content is a trade-off. Even though the content is hosted on a CDN, creating a new connection and growing the congestion window may negate the low latency of using a CDN.

Google Fonts is the most popular of the content CDNs and is used by 55% of websites. For non-font content, Google API, Cloudflare's JS CDN, and the Bootstrap's CDN are the next most popular.

{{ figure_markup(
  image="fig27.png",
  caption="Usage of public content CDNs.",
  description="Bar chart showing 55.33% of public content CDNs are made to fonts.googleapis.com, 19.86% to ajax.googleapis.com, 10.47% to cdnjs.cloudflare.com, 9.83% to maxcdn.bootstrapcdn.com, 5.95% to code.jquery.com, 4.29% to cdn.jsdelivr.net, 3.22% to use.fontawesome.com, 0.7% to stackpath.bootstrapcdn.com, 0.67% to unpkg.com, and 0.52% to ajax.aspnetcdn.com.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=123086113&format=interactive"
  )
}}

As more browsers implement partitioned caches, the effectiveness of public CDNs for hosting common libraries will decrease and it will be interesting to see whether they are less popular in future iterations of this research.

## Conclusion

The reduction in latency that CDNs deliver along with their ability to store content close to visitors enable sites to deliver faster experiences while reducing the load on the origin.

Steve Souders' recommendation to use a CDN remains as valid today as it was 12 years ago, yet only 20% of sites serve their HTML content via a CDN, and only 40% are using a CDN for resources, so there's plenty of opportunity for their usage to grow further.

There are some aspects of CDN adoption that aren't included in this analysis, sometimes this was due to the limitations of the dataset and how it's collected, in other cases new research questions emerged during the analysis.

As the web continues to evolve, CDN vendors innovate, and sites use new practices CDN adoption remains an area rich for further research in future editions of the Web Almanac.
