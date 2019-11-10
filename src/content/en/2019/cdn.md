---
part_number: IV
chapter_number: 17
title: CDN
description: CDN chapter of the 2019 Web Almanac covering CDN adoption and usage, RTT & TLS management, HTTP/2 adoption, caching and common library and content CDNs.
authors: [andydavies, colinbendell]
reviewers: [yoavweiss, paulcalvano, pmeenan, enygren]
discuss: 1772
published: 2019-11-11T00:00:00.000Z
published: 2019-11-11T00:00:00.000Z
---

## Introduction

"Use a Content Delivery Network" was one of [Steve Souders original recommendations](http://stevesouders.com/hpws/rules.php) for making web sites load faster. It’s advice that remains valid today, and in this chapter of the WebAlmanac we’re going to explore how widely Steve’s recommendation has been adopted, how sites are using Content Delivery Networks (CDNs) and some of the features they’re using. 

Fundamentally, CDNs reduce latency – the time it takes for packets to travel between two points on a network, say from a visitor’s device to a server – and latency is a key factor in how quickly pages load. 

A CDN reduces latency in two ways: by serving content from locations that are closer to the user and second, by terminating the TCP connection closer to the end user.

Historically CDNs were used to cache, or copy, bytes so that the logical path from the user to the bytes becomes shorter. A file that is requested by many people can be retrieved once from the origin (your server) and then stored on a server closer to the user, thus saving transfer time. 
CDNs also help with TCP Latency. The latency of TCP determines how long it takes to establish a connection between a browser and a server, how long it takes to secure that connection, and ultimately how quickly content downloads. At best, network packets travel at roughly 2/3rds of the speed of light, so how long that round trip takes depends on how far apart the two ends of the conversation are, and what’s in between – congested networks, overburdened equipment, and the type of network will all add further delays. Using a CDN to move the server end of the connection closer to the visitor reduces this latency penalty, shortening connection times, TLS negotiation times, and improving content download speeds.

Although CDNs are often thought of as just caches that store and serve static content close to the visitor, they are capable of so much more! CDNs aren’t limited to just helping overcome the latency penalty, and increasingly they offer other features that help improve performance and security.

* Using a CDN to proxy dynamic content – base HTML page, API responses etc. – can take advantage of both the reduced latency between the browser and the CDN’s own network back to the origin. 
* Some CDNs offer transformations that optimise pages so they download, and render more quickly, or optimise images so they’re the appropriate size (both dimensions and file size) for the device they’re going to be viewed on.
* From a security perspective malicious traffic and ‘bots’ can be filtered out by a CDN before the requests even reach the origin, and their wide customer base means CDNs can often see and react to new threats sooner.
* The rise of ‘[edge computing](https://en.wikipedia.org/wiki/Edge_computing)’ allows sites to run their own code close to their visitors, both improving performance and reducing the load on the origin.

Finally, CDNs also help sites to adopt new technologies without requiring changes at the origin, for example HTTP/2, TLS 1.3, and/or IPv6 can be enabled from the edge to the browser, even if the origin servers doesn’t support it yet.

### Caveats and Disclaimers

As with any observational study, there are limits to the scope and impact that can be measured. The statistics gathered on CDN usage for the the WebAlmanac does not imply performance, nor effectiveness of a specific CDN vendor.

There are many limits to the testing methodology used for the WebAlmanac. These include:
* Simulated network latency - the WebAlmanac uses a dedicated network connection that [synthetically shapes traffic](https://TODO.dev).
* Single geographic location - tests are run from [a single datacenter](https://httparchive.org/faq#how-is-the-data-gathered) and cannot test the geographic distribution of many CDN vendors 
* Cache effectiveness - each CDN uses proprietary technology and many, for security reasons, do not expose cache performance
* Localisation and Internationalisation - just like geographic distribution, the effects of language and geo specific domains are also opaque to the testing.
* [CDN Detection](https://github.com/WPO-Foundation/wptagent/blob/master/internal/optimization_checks.py#L51) is primarily done through DNS resolution and HTTP Headers. Most CDNs use a DNS CNAME to map a user to an optimal datacenter. However, some CDNs use AnyCast IPs or direct A+AAAA responses from a delegated domain which hide the DNS chain. In other cases, websites use multiple CDNs to balance between vendors which is hidden from the single-request pass of WebPageTest. All of this limits the effectiveness in the measurements. 

Most importantly, these results reflect a potential utilization but do not reflect actual impact. YouTube is more popular than ShoesByColin yet both will appear as equal value when comparing utilization. 

With this in mind, there are a few intentional statistics that were not measured with the context of a CDN:
* TTFB - Measuring the Time-To-First-Byte by CDN would be intellectually dishonest without proper knowledge about cacheability and cache effectiveness. If one site uses a CDN for RTT management but not for caching, this would create a disadvantage when comparing another site that uses a different CDN vendor but does also caches the content. 
* Cache Hit vs. Cache Miss performance - As mentioned previously, this is opaque to the testing apparatus and therefore repeat tests to test page performance with a cold cache vs. a hot cache are unreliable.

### Further Stats

In future versions of the WebAlmanac, we would expect to look more closely at the TLS & RTT management between CDN vendors. Of interest would the impact of OCSP stapling, differences in TLS Cipher performance. CWND (TCP Congestion Window) growth rate and specifically the adoption of BBR v1, v2 and traditional TCP Cubic. 

## CDN Adoption and Usage

For website performance a CDN can improve performance for the primary domain (www.shoesbycolin.com), subdomains or sibling domains (images.shoesbycolin.com or checkout.shoesbycolin.com) and finally third parties (google analytics, etc). Using a CDN for each of these use cases improves performance in different ways. 

Historically, CDNs were used exclusively for static resources like CSS, JavaScript and images. These resources would likely be versioned (include a unique number in the path) and cached long term. In this way we should expect to see higher adoption of CDNs on subdomains or sibling domains compared to the base HTML domains. The traditional design pattern would expect that www.shoesbycolin.com would serve HTML directly from a datacenter (or ORIGIN) while static.shoesbycolin.com would use a CDN.


<figure id="fig1">
  <iframe aria-labelledby="fig1-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=777938536&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig1.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig1.png" aria-labelledby="fig1-caption" width="600">
  </a>
  <div id="fig1-caption" class="visually-hidden">Split of requests between origin and CDN, broken down by HTML, sub-resources and third-party content</div>
  <figcaption>Figure 1. CDN Usage vs. Origin Hosted Resources</figcaption>
</figure>

Indeed, this traditional pattern is what we observe on the majority of websites crawled. The majority of webpages (80%) serve the base HTML from ORIGIN. This breakdown is nearly identical between mobile and desktop with only 0.4% lower usage of CDNs on desktop. This slight variance is likely do to the small continued use of mobile specific webpages (mDot) which more frequently use a CDN.

Likewise, resources served from subdomains are more likely to utilize a CDN at 40% of subdomain resources. Subdomains are used either to partition resources like images and CSS or they are used to reflect organization teams such as checkout or apis.

Despite first party resources still largely being served direct from ORIGIN, third-party resources have a substantially higher adoption of CDNs. Nearly 66% of all third-party resources are served from a CDN. Since 3rd party domains are more likely a SaaS integration the use of CDNs are more likely core to these business offerings. Most third-party content breaks down to shared resources (JavaScript/font CDNs), augmented content (advertisements) or statistics. In all these cases, using a CDN will improve the performance and offload for these SaaS solutions.

## Top Utilized CDN Providers
There are two categories of CDN providers: the generic and the purpose-fit CDN. The generic CDN providers offer customization and flexibility to serve all kinds of content for many industries. In contrast the purpose-fit CDN provider offers similar content distribution capabilities but are narrowly focused on a specific solution.

This is clearly represented when looking at the top CDNs found serving the base HTML content. The most frequent CDNs serving HTML are generic CDNs (eg: Cloudflare, Akamai, Fastly) and cloud solution providers who offer a bundled CDN (eg: Google, Amazon) as part of the platform service offerings. In contrast, there are only a few purpose-fit CDN providers, such as Wordpress and Netlify, that deliver base HTML markup.

(NB: this does not reflect traffic or usage, only the number of sites using them)

<figure id="fig2">
  <a href="/static/images/2019/17_CDN/html_cdn_usage.png">
    <img alt="Most popular CDNs used to serve base HTML pages" src="/static/images/2019/17_CDN/html_cdn_usage.png">
  </a>
  <figcaption>Figure 2: HTML CDN Usage</figcaption>
</figure>

*Top 25 CDNs for HTML by Site*

|||
|--- |--- |
||HTML CDN Usage (%)|
|ORIGIN|80.39|
|Cloudflare|9.61|
|Google|5.54|
|Amazon CloudFront|1.08|
|Akamai|1.05|
|Fastly|0.79|
|WordPress|0.37|
|Sucuri Firewall|0.31|
|Incapsula|0.28|
|Myra Security CDN|0.1|
|OVH CDN|0.08|
|Netlify|0.06|
|Edgecast|0.04|
|GoCache|0.03|
|Highwinds|0.03|
|CDNetworks|0.02|
|Limelight|0.01|
|Level 3|0.01|
|NetDNA|0.01|
|StackPath|0.01|
|Instart Logic|0.01|
|Azion|0.01|
|Yunjiasu|0.01|
|section.io|0.01|
|Microsoft Azure|0.01|

SubDomain requests have a very similar composition. Since many websites use subdomains for static content, we see a shift to a higher CDN usage. Like the base page requests, the resources served from these sub-domains utilize generic CDN offerings.

<figure id="fig3">
  <a href="/static/images/2019/17_CDN/subdomain_resource_cdn_usage.png">
    <img alt="Most popular CDNs used for resources served from a sub-domain" src="/static/images/2019/17_CDN/subdomain_resource_cdn_usage.png">
  </a>
  <figcaption>Figure 3. Sub-Domain Resource CDN Usage</figcaption>
</figure>


*Top 25 Resource CDNs for Sub-Domain Requests*

|||
|--- |--- |
||Sub-Domain CDN Usage (%)|
|ORIGIN|60.56|
|Cloudflare|10.06|
|Google|8.86|
|Amazon CloudFront|6.24|
|Akamai|3.5|
|Edgecast|1.97|
|WordPress|1.69|
|Highwinds|1.24|
|Limelight|1.18|
|Fastly|0.8|
|CDN77|0.43|
|KeyCDN|0.41|
|NetDNA|0.37|
|CDNetworks|0.36|
|Incapsula|0.29|
|Microsoft Azure|0.28|
|Reflected Networks|0.28|
|Sucuri Firewall|0.16|
|BunnyCDN|0.13|
|OVH CDN|0.12|
|Advanced Hosters CDN|0.1|
|Myra Security CDN|0.07|
|CDNvideo|0.07|
|Level 3|0.06|
|StackPath|0.06|

The composition of top CDN providers dramatically shifts for third party resources. Not only are CDNs more frequently observed hosting third party resources, there is also an increase in purpose-fit CDN providers such as Facebook, Twitter and Google.

<figure id="fig4">
  <a href="/static/images/2019/17_CDN/thirdparty_resource_cdn_usage.png">
    <img alt="Most popular CDNs used by third-party resources" src="/static/images/2019/17_CDN/thirdparty_resource_cdn_usage.png">
  </a>
  <figcaption>Figure 4. Third-Party Resource CDN Usage</figcaption>
</figure>

*Top 25 Resource CDNs for 3rd Party Requests*

|||
|--- |--- |
||Third Party CDN Usage (%)|
|ORIGIN|34.27|
|Google|29.61|
|Facebook|8.47|
|Akamai|5.25|
|Fastly|5.14|
|Cloudflare|4.21|
|Amazon CloudFront|3.87|
|WordPress|2.06|
|Edgecast|1.45|
|Twitter|1.27|
|Highwinds|0.94|
|NetDNA|0.77|
|Cedexis|0.3|
|CDNetworks|0.22|
|section.io|0.22|
|jsDelivr|0.2|
|Microsoft Azure|0.18|
|Yahoo|0.18|
|BunnyCDN|0.17|
|CDNvideo|0.16|
|Reapleaf|0.15|
|CDN77|0.14|
|KeyCDN|0.13|
|Azion|0.09|
|StackPath|0.09|

## RTT & TLS Management

CDNs can offer more than simple caching for website performance. Many CDNs also support a pass-through mode for dynamic or personalized content when an organization has a legal or other business requirement prohibiting the content to be cached. Utilizing a CDNs physical distribution enables increased performance for TCP round-trip-time for end user. As [others have noted](https://www.igvita.com/2012/07/19/latency-the-new-web-performance-bottleneck/), [reducing RTT is the most effective means to improve webpage performance](https://hpbn.co/primer-on-latency-and-bandwidth/) compared to increasing bandwidth. 

Using a CDN in this way can improve page performance in two ways:

1. Reduce RTT for TCP and TLS negotiation. The speed of light is only so fast and CDNs offer a highly distributed set of datacenters that are closer to the end users. In this way the logical (and physical) distance that packets must traverse to negotiate a TCP connection and perform TLS handshake can be greatly reduced.  \
 \
Reducing RTT has three immediate benefits. First is it improves the time for the user to receive data (because TCP+TLS connection time are RTT bound). Secondly, this will improve the time it takes to grow the congestion window and utilize the full amount of bandwidth the user has available. Finally, it reduces the probability of packet loss. When the RTT is high, network interfaces will time out requests and resend packets. This can result in double packets being delivered. 
2. CDNs can utilize pre-warmed TCP connections to the back-end origin. Just as terminating the connection closer to the user will improve the time it takes to grow the congestion window, the CDN can relay the request to the origin on pre-established TCP connections that have already maximized congestion windows. In this way the origin can return the dynamic content in fewer TCP round trips and the content can be more effectively ready to deliver to the waiting user. 

## TLS Negotiation Time: Origin ~3x slower than CDNs

Since TLS negotiations requires multiple TCP round trips before data can be sent from a server, simply improving the RTT can significantly improve the page performance. For example, looking at the base html page, the median TLS negotiation time for origin requests is 207ms for desktop WebPageTest. This alone accounts for 10% of a 2s performance budget and this is under an ideal network conditions where there is no latency applied on the request. 

In contrast, the median TLS negotiation for the majority of CDN providers is between 60 and 70ms. Origin requests for HTML pages take almost 3x longer to complete TLS negotiation than those web pages that use a CDN. Even at the 90th percentile, this disparity perpetuates with Origin TLS negotiation rates of 427ms compared to most CDNs which complete under 140ms! 

_A word of caution when interpreting these charts: it is important to focus on orders of magnitude when comparing vendors as there are many factors that impact the actual TLS negotiation performance. These tests were completed from a single datacenter under controlled conditions and do not reflect the variability of the internet and user experiences._

<figure id="fig5">
  <a href="/static/images/2019/17_CDN/html_tls_negotiation_time.png">
    <img alt="Distribution of TLS negotiation time for intial HTML request broken down by CDN" src="/static/images/2019/17_CDN/html_tls_negotiation_time.png">
  </a>
  <figcaption>Figure 5. HTML TLS Negotiation Time</figcaption>
</figure>

*HTML TLS Connection Time (ms)*

|||||||
|--- |--- |--- |--- |--- |--- |
||p10|p25|p50|p75|p90|
|Highwinds|58|58|60|66|94|
|Fastly|56|59|63|69|75|
|WordPress|58|62|76|77|80|
|Sucuri Firewall|63|66|77|80|86|
|Amazon CloudFront|59|61|62|83|128|
|Cloudflare|62|68|80|92|103|
|Akamai|57|59|72|93|134|
|Microsoft Azure|62|93|97|98|101|
|Edgecast|94|97|100|110|221|
|Google|47|53|79|119|184|
|OVH CDN|114|115|118|120|122|
|section.io|105|108|112|120|210|
|Incapsula|96|100|111|139|243|
|Netlify|53|64|73|145|166|
|Myra Security CDN|95|106|118|226|365|
|GoCache|217|219|223|234|260|
|*ORIGIN*|*100*|*138*|*207*|*342*|*427*|
|CDNetworks|85|143|229|369|452|

For resource requests (including same domain and third party), the TLS negotiation time takes longer and the variance increases. This is expected because of network saturation and network congestion. By the time that a third party connection is established - by way of a resource hint or a resource request - the browser is busy rendering and making other parallel requests. This creates contention on the network. Despite this disadvantage, there is still a clear advantage for third party resources that utilize a CDN over using an origin solution.  

<figure id="fig6">
  <a href="/static/images/2019/17_CDN/resource_tls_negotiation_time.png">
    <img alt="Distribution of TLS negotiation time for site resources broken down by CDN" src="/static/images/2019/17_CDN/resource_tls_negotiation_time.png">
  </a>
  <figcaption>Figure 6. Resource TLS Negotiation Time</figcaption>
</figure>

TLS handshake performance is impacted by a number of factors. These include RTT, TLS Record size and TLS certificate size. While RTT has the biggest impact of TLS handshake, the second largest driver for TLS performance is the TLS certificate size. 

During the first round trip of the [TLS handshake](https://hpbn.co/transport-layer-security-tls/#tls-handshake), the server attaches its certificate. This certificate is then verified by the client before proceeding. In this certificate exchange, the server might include the certificate chain by which it can be verified. After this certificate exchange, additional keys are established to encrypt the communication. However, the length and size of the certificate can negatively impact the TLS negotiation performance and in some cases, crash client libraries. 

The certificate exchange is at the foundation of the TLS handshake and is usually handled by isolated code paths so as to minimize the attack surface for exploits. Because of it’s low level nature, buffers are usually not dynamically allocated but fixed. In this way, we cannot simply assume that the client can handle an unlimited sized certificate. For example, Openssl CLI tools and Safari can successfully negotiate against [https://10000-sans.badssl.com](https://10000-sans.badssl.com). Yet, Chrome and Firefox fail because of the size of the certificate. 

While extreme sizes of certificate can cause failures, sending moderately large certificates also has a performance impact. A certificate can be valid for one or more hostnames which are are listed in the Subject-Alternative-Name (SAN). The more SANs, the larger the certificate. It is the processing of these SANs during verification that causes performance to degrade. To be clear, performance of certificate size is not about TCP overhead, rather it is about processing performance of the client.  

> Technically TCP slow start can impact this negotiation but it is very improbable. TLS record length is limited to 16KB which fits into a typical initial congestion window of 10. While some ISPs might employ packet splicers and other tools fragment congestion windows to artificially throttle bandwidth, this isn't something that a website owner can change or manipulate. 

Many CDNs, however, depend on shared TLS certificates and will list many customers in the SAN of a certificate. This is often necessary because of the scarcity of IPv4 addresses. Prior to the adoption of SNI (Server-Name-Indicator) by end users, the client would connect to a server and only after inspecting the certificate, would the client hint which hostname the user user was looking for (using the Host: header in HTTP). This then results in a 1:1 association of an IP address and a certificate. If you are a CDN with many physical locations, each location may require a dedicated IP, further aggravating the exhaustion of IPv4 addresses. Therefore, the simplest and most efficient way for CDNs to offer TLS certificates for websites that still have users that don’t support SNI is to offer a shared certificate. 

According to Akamai, the adoption of SNI is [still not 100% globally](https://datatracker.ietf.org/meeting/101/materials/slides-101-maprg-update-on-tls-sni-and-ipv6-client-adoption-00). Fortunately there has been a rapid shift in recent years. The biggest culprits are no longer Windows XP and Vista, but now Android apps, bots, and corporate applications. Even at 99% adoption, the remaining 1% of 3.5 billion users on the internet can create a very compelling motivation for website owners to require a non-SNI certificate. Put another way, a pure play website can enjoy a virtually 100% SNI adoption among standard Web Browser. Yet, if the website is also used to support APIs or WebViews in Apps, particularly Android Apps, this distribution can drop rapidly.

Most CDNs balance the need for shared certificates and performance. Most cap the number of SANs between 100-150. This limit often derives from the certificate providers. For example, [LetsEncrypt](https://letsencrypt.org/docs/rate-limits/), [DigiCert](https://www.websecurity.digicert.com/security-topics/san-ssl-certificates) and [GoDaddy](https://www.godaddy.com/web-security/multi-domain-san-ssl-certificate) all limit SAN certificates to 100 hostnames while [Comodo](https://comodosslstore.com/comodo-mdc-ssl.aspx)'s limit is 2000. This, in turn, allows some CDNs push this limit cresting over 800 SANs on a single certificate. There is a strong negative correlation of TLS performance and the number of SANs on a certificate.


<figure id="fig7">
  <iframe aria-labelledby="fig7-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=753130748&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig7.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig7.png" aria-labelledby="fig7-caption" width="600">
  </a>
  <div id="fig7-caption" class="visually-hidden">Distribution showing the number of Subject-Alternative-Names per certificate for initial HTML request, broken down by CDN</div>
  <figcaption>Figure 7. TLS SAN Count for HTML</figcaption>
</figure>


* TLS SAN Count for HTML *

|||||||
|--- |--- |--- |--- |--- |--- |
||p10|p25|p50|p75|p90|
|section.io|1|1|1|1|2|
|ORIGIN|1|2|2|2|7|
|Amazon CloudFront|1|2|2|2|8|
|WordPress|2|2|2|2|2|
|Sucuri Firewall|2|2|2|2|2|
|Netlify|1|2|2|2|3|
|Highwinds|1|2|2|2|2|
|GoCache|1|1|2|2|4|
|Google|1|1|2|3|53|
|OVH CDN|2|2|3|8|19|
|Cloudflare|1|1|3|39|59|
|Microsoft Azure|2|2|2|43|47|
|Edgecast|2|4|46|56|130|
|Incapsula|2|2|11|78|140|
|Akamai|2|18|57|85|95|
|Fastly|1|2|77|100|100|
|Myra Security CDN|2|2|18|139|145|
|CDNetworks|2|7|100|360|818|

<figure id="fig8">
  <iframe aria-labelledby="fig8-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=528008536&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig8.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig8.png" aria-labelledby="fig8-caption" width="600">
  </a>
  <div id="fig8-caption" class="visually-hidden">Median number of Subject-Alternative-Names for sub-resource requests, broken down by CDN</div>
  <figcaption>Figure 8. Resource SAN Count (p50)</figcaption>
</figure>


|||||||
|--- |--- |--- |--- |--- |--- |
||p10|p25|p50|p75|p90|
|section.io|1|1|1|1|1|
|ORIGIN|1|2|2|3|10|
|Amazon CloudFront|1|1|2|2|6|
|Highwinds|2|2|2|3|79|
|WordPress|2|2|2|2|2|
|NetDNA|2|2|2|2|2|
|CDN77|2|2|2|2|10|
|Cloudflare|2|3|3|3|35|
|Edgecast|2|4|4|4|4|
|Twitter|2|4|4|4|4|
|Akamai|2|2|5|20|54|
|Google|1|10|11|55|68|
|Facebook|13|13|13|13|13|
|Fastly|2|4|16|98|128|
|Yahoo|6|6|79|79|79|
|Cedexis|2|2|98|98|98|
|Microsoft Azure|2|43|99|99|99|
|jsDelivr|2|116|116|116|116|
|CDNetworks|132|178|397|398|645|

## TLS Adoption

In addition to using a CDN for TLS & RTT Performance, CDNs are often used to ensure patching and adoption of TLS ciphers and TLS versions. In general, the adoption of TLS on the main HTML page is much higher for websites that use a CDN. Over 76% of HTML pages are served with TLS compared to the 62% from Origin hosted pages. 

<figure id="fig9">
  <iframe aria-labelledby="fig9-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=528008536&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig9.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig9.png" aria-labelledby="fig9-caption" width="600">
  </a>
  <div id="fig9-caption" class="visually-hidden">Break down of TLS version used to establish secure connection for the initial HTML request but origin and CDN requests</div>
  <figcaption>Figure 9. HTML TLS Version Adoption (CDN v. Origin)</figcaption>
</figure>

Each CDN offers different rates of adoption for both TLS and the relative ciphers and versions offered. Some CDNs are more aggressive and roll out these changes to all customers whereas other CDNs require website owners to opt-in to the latest changes and offer change-management to facilitate these ciphers and versions.

<figure id="fig10">
  <iframe aria-labelledby="fig10-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=659795773&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig10.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig10.png" aria-labelledby="fig10-caption" width="600">
  </a>
  <div id="fig10-caption" class="visually-hidden">Division of secure vs non-secure connections established for initial HTML request broken down by CDN</div>
  <figcaption>Figure 10. HTML TLS Adoption by CDN</figcaption>
</figure>

<figure id="fig11">
  <iframe aria-labelledby="fig11-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=991037479&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig11.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig11.png" aria-labelledby="fig11-caption" width="600">
  </a>
  <div id="fig11-caption" class="visually-hidden">Division of secure vs non-secure connections established for third-party requests broken down by CDN</div>
  <figcaption>Figure 11. Third-Party TLS Adoption by CDN</figcaption>
</figure>


Along with this general adoption of TLS, CDN use also sees higher adoption of emerging TLS Versions like TLS 1.3. 

In general the use of a CDN is highly correlated with a more rapid adoption of stronger ciphers and stronger TLS versions compared to Origin hosted services where there is a higher user of very old and compromised TLS Versions like TLS 1.0. 

> It is important to emphasise that Chrome used in the Web Almanac will bias to the latest TLS versions and ciphers offered by the host. Also, these web pages were crawled in July 2019 and reflect the adoption of websites that have enabled the newer versions. 

<figure id="fig12">
  <iframe aria-labelledby="fig12-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=659795773&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig12.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig12.png" aria-labelledby="fig12-caption" width="600">
  </a>
  <div id="fig12-caption" class="visually-hidden">Version of TLS used to establish connection for initial HTML request broken down by CDN</div>
  <figcaption>Figure 12. HTML TLS Negotiation by CDN</figcaption>
</figure>


More discussion of the TLS Versions and ciphers can be found In the [Security](https://todo.dev) and [HTTP/2](https://todo.dev) chapters, 

## HTTP/2 Adoption
Along with RTT Management and improving TLS performance, CDNs also enable new standards like HTTP/2 and IPv6. While most CDNs offer support for HTTP/2 and many have signaled early support of the still-under-standards-development HTTP/3, adoption still depends on website owners to enable these new features. Despite the change management overhead, the majority of the HTML served from CDNs has HTTP/2 enabled. 

The top 10 CDNs have over 80% of the websites covered by WebPageTest have HTTP/2 enabled compared to the nearly 27% of ORIGIN pages. Similarly, sub domain and third party resources on CDNs see an even higher adoption of HTTP/2 at 90% or higher while third party resources served from origin infrastructure only has 31% adoption. The performance gains and other features of HTTP/2 are further covered in the [HTTP/2 chapter](https://TODO.dev). 

> NB: All requests were made with the latest version of Chrome which supports HTTP/2. When only HTTP/1.1 is reported this would indicate either unencrypted (non TLS) servers or servers that don’t support HTTP/2.

<figure id="fig13">
  <iframe aria-labelledby="fig13-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1166990011&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig13.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig13.png" aria-labelledby="fig13-caption" width="600">
  </a>
  <div id="fig13-caption" class="visually-hidden">Comparison of HTTP/2 usage between requests via CDN, and site origins</div>
  <figcaption>Figure 13. HTTP/2 Adoption CDN vs Origin</figcaption>
</figure>

<figure id="fig14">
  <iframe aria-labelledby="fig14-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1896876288&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig14.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig14.png" aria-labelledby="fig14-caption" width="600">
  </a>
  <div id="fig14-caption" class="visually-hidden">Comparison of HTTP/2 usage between requests from intial HTML via CDN, and site origins</div>
  <figcaption>Figure 14. HTML Adoption of HTTP/2</figcaption>
</figure>


*HTML Adoption of HTTP/2*

||||||
|--- |--- |--- |--- |--- |
||HTTP/0.9|HTTP/1.0|HTTP/1.1|HTTP/2|
|WordPress|0|0|0.38|100|
|Netlify|0|0|1.07|99|
|section.io|0|0|1.56|98|
|GoCache|0|0|7.97|92|
|NetDNA|0|0|12.03|88|
|Instart Logic|0|0|12.36|88|
|Microsoft Azure|0|0|14.06|86|
|Sucuri Firewall|0|0|15.65|84|
|Fastly|0|0|16.34|84|
|Cloudflare|0|0|16.43|84|
|Highwinds|0|0|17.34|83|
|Amazon CloudFront|0|0|18.19|82|
|OVH CDN|0|0|25.53|74|
|Limelight|0|0|33.16|67|
|Edgecast|0|0|37.04|63|
|Cedexis|0|0|43.44|57|
|Akamai|0|0|47.17|53|
|Myra Security CDN|0|0.06|50.05|50|
|Google|0|0|52.45|48|
|Incapsula|0|0.01|55.41|45|
|Yunjiasu|0|0|70.96|29|
|ORIGIN|0|0.1|72.81|27|
|Zenedge|0|0|87.54|12|
|CDNetworks|0|0|88.21|12|
|ChinaNetCenter|0|0|94.49|6|


figure id="fig15">
  <iframe aria-labelledby="fig15-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=397209603&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig15.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig15.png" aria-labelledby="fig15-caption" width="600">
  </a>
  <div id="fig15-caption" class="visually-hidden">Comparison of HTTP/2 usage between requests from intial HTML via CDN, and site origins</div>
  <figcaption>Figure 15. HTML/2 Adoption: Third Party Resources</figcaption>
</figure>


*HTML/2 Adoption: Third Party Resources*

||||||
|--- |--- |--- |--- |--- |
|cdn|HTTP/0.9|HTTP/1.0|HTTP/1.1|HTTP/2|
|jsDelivr|0|0|0|100|
|Facebook|0|0|0|100|
|Twitter|0|0|1|99|
|section.io|0|0|2|98|
|BunnyCDN|0|0|2|98|
|KeyCDN|0|0|4|96|
|Microsoft Azure|0|0|6|94|
|WordPress|0|0|7|93|
|CDN77|0|0|7|93|
|NetDNA|0|0|7|93|
|Google|0|0|8|92|
|Fastly|0|0|10|90|
|Sucuri Firewall|0|0|14|86|
|Cloudflare|0|0|16|84|
|Yahoo|0|0|17|83|
|OVH CDN|0|0|26|75|
|Amazon CloudFront|0|0|26|74|
|Cedexis|0|0|27|73|
|CDNetworks|0|0|30|70|
|Edgecast|0|0|42|58|
|Highwinds|0|0|43|57|
|Akamai|0|0.01|47|53|
|Incapsula|0|0|56|44|
|CDNvideo|0|0|68|31|
|ORIGIN|0|0.07|69|31|

A more in depth discussion of HTTP/2 is covered in [Chapter 20](https://todo.dev)

## Controlling CDN Caching Behavior

### Vary

A website can control many the caching behavior of browsers and CDNs with the use of different HTTP headers. The most common is the Cache-Control header which specifically determines how long something can be cached before returning to the origin to ensure it is up-to-date. 

Another useful tool is the use of the Vary HTTP Header. This header instructs both CDNs and Browsers how to fragment a cache. The Vary Header allows an origin to indicate there are multiple representations of a resource, and the CDN should cache each variation separately. The most common example is compression as discussed in [Chapter 16](http://todo.dev). Declaring a resource as `Vary: Accept-Encoding` allows the CDN to cache the same content but in different forms like uncompressed, with gzip or Brotli. Some CDNs even do this compression on the fly so as to keep only one copy available. This Vary header likewise also instructs the browser how to cache the content and when to request new content. 

<figure id="fig16">
  <a href="/static/images/2019/17_CDN/use_of_vary_on_cdn.png">
    <img alt="Breakdown of Vary header values for HTML content served from a CDN" src="/static/images/2019/17_CDN/use_of_vary_on_cdn.png">
  </a>
  <figcaption>Figure 16. Usage of Vary for HTML served from CDNs</figcaption>
</figure>

While the main use of `Vary` is to coordinate `Content-Encoding`, there are other important variations that web sites signal cache fragmentation. Using Vary also instructs SEO Bots like DuckDuckGo, Google and BingBot that alternate content would be returned under different conditions. This has been important to avoid SEO penalties for ‘ghosting’ (sending SEO specific content in order to game the rankings).

For HTML pages, the most common use of Vary is to signal that the content will change based on the User-Agent. This is short-hand to indicate that the website will return different content for Desktops, Phones, Tablets and Link Unfurling engines (like Slack, iMessage and Whatsapp). The use of `Vary: User-Agent` is also a vestigate of the early mobile era where content was split between mDot servers and "regular" servers in the back end. While the adoption for Responsive Web has gained wide popularity, this Vary form remains.

In a similar way, `Vary: Cookie` usually indicates content that will change based on the logged in state of the user or other personalization. 

<figure id="fig17">
  <a href="/static/images/2019/17_CDN/use_of_vary.png">
    <img alt="Comparison of Vary header values for HTML and Resouces, divided by Orign and CDN" src="/static/images/2019/17_CDN/use_of_vary.png">
  </a>
  <figcaption>Figure 17. Comparison of Vary usage for HTML and Resources served from Origin and CDN</figcaption>
</figure>

Resources, in contrast, don’t `Vary: Cookie` as much as the HTML resources. Instead these resources are more likely to adapt based on the Accept, Origin or Referer. Most media, for example, will use `Vary: Accept` to indicate that an image could be a JPEG, WebP, JPEG 2000, or JPEG XR depending on the Browser’s offered `Accept` header.  In a similar way, third party shared resources signal that an XHR API will differ depending on which website it is embedded. This way a call to an ad server API will return different content depending on the parent website that called the API.

The Vary header also contains evidence of CDN chains, these can be seen in Vary headers such as "Accept-Encoding, Accept-Encoding" or even "Accept-Encoding, Accept-Encoding". Further analysis of these chains and Via header entries might reveal interesting data, for example how many sites are proxying third-party tags. 

Many of the uses of the `Vary` are extraneous. With most browsers adopting double-key caching, the use of `Vary: Origin` is redundant. As is `Vary: Range` or `Vary: Host` or `Vary: *`. The wild and variable use of `Vary` is demonstrable proof that the internet is weird. 

### Surrogate-Control, s-maxage and Pre-Check

There are other HTTP headers that specifically target CDNs, or other proxy caches, such as the Surrogate-Control, the s-maxage, pre-check, and post-check values in the Cache-Control header etc., and in general usage of these headers is low.

Surrogate-Control allows origins to specify caching rules just for CDNs, and as CDNs are likely to strip the header before serving responses it’s low visible usage isn’t a surprise, in fact it’s surprising that it’s actually in any responses at all (it was even seen from some CDNs that state they strip it)

Some CDNs support post-check as a method to allow a resource to refreshed when it goes stale, and pre-check as a maxage equivalent. For most CDNs usage of pre-check and post-check was below 1%, Yahoo was the exception to this and ~15% of requests had pre-check=0, post-check=0 – unfortunately this seems to be the remnant of an old Internet Explorer pattern rather than active usage. More discussion on this can be found in the [Caching Chapter](https://todo.dev)

The s-maxage directive informs proxies how long they may cache a response for. Across the Web Almanac dataset, jsDelivr is the only CDN where a high level of usage was seen across multiple resources – this isn’t surprising given jsDelivr’s role as public CDN for libraries. Usage across other CDNs seems to be driven by individual customers e.g. 3rd-party scripts, or SaaS providers using that particular CDN.

<figure id="fig18">
  <iframe aria-labelledby="fig18-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1215102767&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig18.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig18.png" aria-labelledby="fig18-caption" width="600">
  </a>
  <div id="fig18-caption" class="visually-hidden">Comparison of s-maxage adoption across CDNs</div>
  <figcaption>Figure 18. Adoption of s-maxage across CDN responses</figcaption>
</figure>

With 40% of sites using a CDN for resources, and presuming these resources are static and cacheable, the usage of s-maxage seems low.

Future research might explore cache lifetimes versus the age of the resources, and the usage of s-maxage versus other validation directives such as stale-while-revalidate.

## CDNs for Common Libraries and Content

So far this chapter has explored the use of commercials CDNs which the site may be using using the CDN to host its own content, or perhaps used by a third-party tag that’s included on the site.

Common libraries – jQuery, Bootstrap etc. – are also available from public CDNs hosted by Google, Cloudflare, Microsoft, etc.

Using content from one of the public CDNs instead of a self-hosting the content is a tradeoff – even though the content is hosted on a CDN, creating a new connection, and growing the congestion window may negate the low latency of using a CDN.

Google Fonts is the most popular of the content CDNs and is used by 55% of the sites in the Almanac dataset. For non-font content Google API, Cloudflare’s JS CDN, and the Bootstrap’s CDN are the next most popular. 

<figure id="fig19">
  <iframe aria-labelledby="fig19-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=123086113&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig19.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig19.png" aria-labelledby="fig19-caption" width="600">
  </a>
  <div id="fig19-caption" class="visually-hidden">Most popular content CDNs</div>
  <figcaption>Figure 19. Usage of public content CDNs</figcaption>
</figure>

As more browsers implement partitioned caches, the effectiveness of public CDNs for hosting common libraries will decrease  and it will be interesting to see whether they are less popular in future iterations of this research.

## Conclusions

The reduction in latency CDNs deliver, along with their ability to store content close to visitors enables sites to deliver faster experiences while reducing the load on the origin.

Steve Souders’ recommendation to use a CDN remains as valid today as it was 12 years ago, but yet only 20% of sites serve their HTML content via a CDN, and only 40% are using a CDN for resources so there’s plenty of opportunity for their usage to grow further.

There are some aspects of CDN adoption that aren't included in this analysis, sometimes 
this was due to the limitations of the dataset and how it's collected, in other cases new research questions emerged during the analysis.

As the web continues to evolve, CDN vendors innovate, and sites use new practices CDN adoption remains an area rich for further research in future editions of the Web Almanac.

