---
part_number: IV
chapter_number: 17
title: CDN
description: CDN chapter of the 2019 Web Almanac covering CDN adoption and usage
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

### Caveats and disclaimers

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

### Further stats

In future versions of the WebAlmanac, we would expect to look more closely at the TLS & RTT management between CDN vendors. Of interest would the impact of OCSP stapling, differences in TLS Cipher performance. CWND (TCP Congestion Window) growth rate and specifically the adoption of BBR v1, v2 and traditional TCP Cubic. 

## CDN adoption and usage

For website performance a CDN can improve performance for the primary domain (www.shoesbycolin.com), subdomains or sibling domains (images.shoesbycolin.com or checkout.shoesbycolin.com) and finally third parties (google analytics, etc). Using a CDN for each of these use cases improves performance in different ways. 

Historically, CDNs were used exclusively for static resources like CSS, JavaScript and images. These resources would likely be versioned (include a unique number in the path) and cached long term. In this way we should expect to see higher adoption of CDNs on subdomains or sibling domains compared to the base HTML domains. The traditional design pattern would expect that www.shoesbycolin.com would serve HTML directly from a datacenter (or ORIGIN) while static.shoesbycolin.com would use a CDN.


<figure>
  <iframe aria-labelledby="fig1-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=777938536&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig1.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig1.png" aria-labelledby="fig1-caption" width="600">
  </a>
  <div id="fig1-caption" class="visually-hidden">Split of requests between origin and CDN, broken down by HTML, sub-resources and third-party content</div>
  <figcaption>Figure 1. CDN ssage vs. origin-hosted resources.</figcaption>
</figure>

Indeed, this traditional pattern is what we observe on the majority of websites crawled. The majority of webpages (80%) serve the base HTML from ORIGIN. This breakdown is nearly identical between mobile and desktop with only 0.4% lower usage of CDNs on desktop. This slight variance is likely do to the small continued use of mobile specific webpages (mDot) which more frequently use a CDN.

Likewise, resources served from subdomains are more likely to utilize a CDN at 40% of subdomain resources. Subdomains are used either to partition resources like images and CSS or they are used to reflect organization teams such as checkout or apis.

Despite first party resources still largely being served direct from ORIGIN, third-party resources have a substantially higher adoption of CDNs. Nearly 66% of all third-party resources are served from a CDN. Since 3rd party domains are more likely a SaaS integration the use of CDNs are more likely core to these business offerings. Most third-party content breaks down to shared resources (JavaScript/font CDNs), augmented content (advertisements) or statistics. In all these cases, using a CDN will improve the performance and offload for these SaaS solutions.

## Top CDN providers
There are two categories of CDN providers: the generic and the purpose-fit CDN. The generic CDN providers offer customization and flexibility to serve all kinds of content for many industries. In contrast the purpose-fit CDN provider offers similar content distribution capabilities but are narrowly focused on a specific solution.

This is clearly represented when looking at the top CDNs found serving the base HTML content. The most frequent CDNs serving HTML are generic CDNs (eg: Cloudflare, Akamai, Fastly) and cloud solution providers who offer a bundled CDN (eg: Google, Amazon) as part of the platform service offerings. In contrast, there are only a few purpose-fit CDN providers, such as Wordpress and Netlify, that deliver base HTML markup.

(NB: this does not reflect traffic or usage, only the number of sites using them)

<figure>
  <a href="/static/images/2019/17_CDN/html_cdn_usage.png">
    <img alt="Most popular CDNs used to serve base HTML pages" src="/static/images/2019/17_CDN/html_cdn_usage.png" width="600">
  </a>
  <figcaption>Figure 2: HTML CDN usage.</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>HTML CDN Usage (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td>80.39</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>9.61</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>5.54</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>1.08</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>1.05</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>0.79</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>0.37</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>0.31</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>0.28</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td>0.1</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>0.08</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>0.06</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>0.04</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td>0.03</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>0.03</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>0.02</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>Level 3</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>Instart Logic</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>Azion</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>Yunjiasu</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td>0.01</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>0.01</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 3. Top 25 CDNs for HTML by site.</figcaption>
</figure>

Sub-domain requests have a very similar composition. Since many websites use subdomains for static content, we see a shift to a higher CDN usage. Like the base page requests, the resources served from these sub-domains utilize generic CDN offerings.

<figure>
  <a href="/static/images/2019/17_CDN/subdomain_resource_cdn_usage.png">
    <img alt="Most popular CDNs used for resources served from a sub-domain" src="/static/images/2019/17_CDN/subdomain_resource_cdn_usage.png" width="600">
  </a>
  <figcaption>Figure 4. Sub-domain resource CDN usage.</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>Sub-Domain CDN Usage (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td>60.56</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>10.06</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>8.86</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>6.24</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>3.5</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>1.97</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>1.69</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>1.24</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td>1.18</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>0.8</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td>0.43</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td>0.41</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td>0.37</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>0.36</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>0.29</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>0.28</td>
      </tr>
      <tr>
        <td>Reflected Networks</td>
        <td>0.28</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>0.16</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td>0.13</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>0.12</td>
      </tr>
      <tr>
        <td>Advanced Hosters CDN</td>
        <td>0.1</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td>0.07</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td>0.07</td>
      </tr>
      <tr>
        <td>Level 3</td>
        <td>0.06</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td>0.06</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 5. Top 25 resource CDNs for sub-domain requests.</figcaption>
</figure>

The composition of top CDN providers dramatically shifts for third party resources. Not only are CDNs more frequently observed hosting third party resources, there is also an increase in purpose-fit CDN providers such as Facebook, Twitter and Google.

<figure>
  <a href="/static/images/2019/17_CDN/thirdparty_resource_cdn_usage.png">
    <img alt="Most popular CDNs used by third-party resources" src="/static/images/2019/17_CDN/thirdparty_resource_cdn_usage.png" width="600">
  </a>
  <figcaption>Figure 6. Third-party resource CDN usage.</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>Third Party CDN Usage (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td>34.27</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>29.61</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td>8.47</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>5.25</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>5.14</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>4.21</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>3.87</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>2.06</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>1.45</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td>1.27</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>0.94</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td>0.77</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td>0.3</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>0.22</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td>0.22</td>
      </tr>
      <tr>
        <td>jsDelivr</td>
        <td>0.2</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>0.18</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td>0.18</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td>0.17</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td>0.16</td>
      </tr>
      <tr>
        <td>Reapleaf</td>
        <td>0.15</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td>0.14</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td>0.13</td>
      </tr>
      <tr>
        <td>Azion</td>
        <td>0.09</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td>0.09</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 7. Top 25 resource CDNs for third party requests.</figcaption>
</figure>

## RTT and TLS management

CDNs can offer more than simple caching for website performance. Many CDNs also support a pass-through mode for dynamic or personalized content when an organization has a legal or other business requirement prohibiting the content to be cached. Utilizing a CDNs physical distribution enables increased performance for TCP round-trip-time for end user. As [others have noted](https://www.igvita.com/2012/07/19/latency-the-new-web-performance-bottleneck/), [reducing RTT is the most effective means to improve webpage performance](https://hpbn.co/primer-on-latency-and-bandwidth/) compared to increasing bandwidth. 

Using a CDN in this way can improve page performance in two ways:

1. Reduce RTT for TCP and TLS negotiation. The speed of light is only so fast and CDNs offer a highly distributed set of datacenters that are closer to the end users. In this way the logical (and physical) distance that packets must traverse to negotiate a TCP connection and perform TLS handshake can be greatly reduced.

  Reducing RTT has three immediate benefits. First is it improves the time for the user to receive data (because TCP+TLS connection time are RTT bound). Secondly, this will improve the time it takes to grow the congestion window and utilize the full amount of bandwidth the user has available. Finally, it reduces the probability of packet loss. When the RTT is high, network interfaces will time out requests and resend packets. This can result in double packets being delivered.

2. CDNs can utilize pre-warmed TCP connections to the back-end origin. Just as terminating the connection closer to the user will improve the time it takes to grow the congestion window, the CDN can relay the request to the origin on pre-established TCP connections that have already maximized congestion windows. In this way the origin can return the dynamic content in fewer TCP round trips and the content can be more effectively ready to deliver to the waiting user. 

## TLS negotiation time: Origin ~3x slower than CDNs

Since TLS negotiations requires multiple TCP round trips before data can be sent from a server, simply improving the RTT can significantly improve the page performance. For example, looking at the base html page, the median TLS negotiation time for origin requests is 207ms for desktop WebPageTest. This alone accounts for 10% of a 2s performance budget and this is under an ideal network conditions where there is no latency applied on the request. 

In contrast, the median TLS negotiation for the majority of CDN providers is between 60 and 70ms. Origin requests for HTML pages take almost 3x longer to complete TLS negotiation than those web pages that use a CDN. Even at the 90th percentile, this disparity perpetuates with Origin TLS negotiation rates of 427ms compared to most CDNs which complete under 140ms! 

<aside class="note">A word of caution when interpreting these charts: it is important to focus on orders of magnitude when comparing vendors as there are many factors that impact the actual TLS negotiation performance. These tests were completed from a single datacenter under controlled conditions and do not reflect the variability of the internet and user experiences.</aside>

<figure>
  <a href="/static/images/2019/17_CDN/html_tls_negotiation_time.png">
    <img alt="Distribution of TLS negotiation time for intial HTML request broken down by CDN" src="/static/images/2019/17_CDN/html_tls_negotiation_time.png" width="600">
  </a>
  <figcaption>Figure 8. HTML TLS negotiation time.</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>p10</th>
        <th>p25</th>
        <th>p50</th>
        <th>p75</th>
        <th>p90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Highwinds</td>
        <td>58</td>
        <td>58</td>
        <td>60</td>
        <td>66</td>
        <td>94</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>56</td>
        <td>59</td>
        <td>63</td>
        <td>69</td>
        <td>75</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>58</td>
        <td>62</td>
        <td>76</td>
        <td>77</td>
        <td>80</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>63</td>
        <td>66</td>
        <td>77</td>
        <td>80</td>
        <td>86</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>59</td>
        <td>61</td>
        <td>62</td>
        <td>83</td>
        <td>128</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>62</td>
        <td>68</td>
        <td>80</td>
        <td>92</td>
        <td>103</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>57</td>
        <td>59</td>
        <td>72</td>
        <td>93</td>
        <td>134</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>62</td>
        <td>93</td>
        <td>97</td>
        <td>98</td>
        <td>101</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>94</td>
        <td>97</td>
        <td>100</td>
        <td>110</td>
        <td>221</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>47</td>
        <td>53</td>
        <td>79</td>
        <td>119</td>
        <td>184</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>114</td>
        <td>115</td>
        <td>118</td>
        <td>120</td>
        <td>122</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td>105</td>
        <td>108</td>
        <td>112</td>
        <td>120</td>
        <td>210</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>96</td>
        <td>100</td>
        <td>111</td>
        <td>139</td>
        <td>243</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>53</td>
        <td>64</td>
        <td>73</td>
        <td>145</td>
        <td>166</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td>95</td>
        <td>106</td>
        <td>118</td>
        <td>226</td>
        <td>365</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td>217</td>
        <td>219</td>
        <td>223</td>
        <td>234</td>
        <td>260</td>
      </tr>
      <tr>
        <td><em>ORIGIN</em></td>
        <td><em>100</em></td>
        <td><em>138</em></td>
        <td><em>207</em></td>
        <td><em>342</em></td>
        <td><em>427</em></td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>85</td>
        <td>143</td>
        <td>229</td>
        <td>369</td>
        <td>452</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 9. HTML TLS connection time (ms).</figcaption>
</figure>

For resource requests (including same domain and third party), the TLS negotiation time takes longer and the variance increases. This is expected because of network saturation and network congestion. By the time that a third party connection is established - by way of a resource hint or a resource request - the browser is busy rendering and making other parallel requests. This creates contention on the network. Despite this disadvantage, there is still a clear advantage for third party resources that utilize a CDN over using an origin solution.  

<figure>
  <a href="/static/images/2019/17_CDN/resource_tls_negotiation_time.png">
    <img alt="Distribution of TLS negotiation time for site resources broken down by CDN" src="/static/images/2019/17_CDN/resource_tls_negotiation_time.png" width="600">
  </a>
  <figcaption>Figure 10. Resource TLS negotiation time.</figcaption>
</figure>

TLS handshake performance is impacted by a number of factors. These include RTT, TLS Record size and TLS certificate size. While RTT has the biggest impact of TLS handshake, the second largest driver for TLS performance is the TLS certificate size. 

During the first round trip of the [TLS handshake](https://hpbn.co/transport-layer-security-tls/#tls-handshake), the server attaches its certificate. This certificate is then verified by the client before proceeding. In this certificate exchange, the server might include the certificate chain by which it can be verified. After this certificate exchange, additional keys are established to encrypt the communication. However, the length and size of the certificate can negatively impact the TLS negotiation performance and in some cases, crash client libraries. 

The certificate exchange is at the foundation of the TLS handshake and is usually handled by isolated code paths so as to minimize the attack surface for exploits. Because of it’s low level nature, buffers are usually not dynamically allocated but fixed. In this way, we cannot simply assume that the client can handle an unlimited sized certificate. For example, Openssl CLI tools and Safari can successfully negotiate against [https://10000-sans.badssl.com](https://10000-sans.badssl.com). Yet, Chrome and Firefox fail because of the size of the certificate. 

While extreme sizes of certificate can cause failures, sending moderately large certificates also has a performance impact. A certificate can be valid for one or more hostnames which are are listed in the Subject-Alternative-Name (SAN). The more SANs, the larger the certificate. It is the processing of these SANs during verification that causes performance to degrade. To be clear, performance of certificate size is not about TCP overhead, rather it is about processing performance of the client.  

Technically TCP slow start can impact this negotiation but it is very improbable. TLS record length is limited to 16KB which fits into a typical initial congestion window of 10. While some ISPs might employ packet splicers and other tools fragment congestion windows to artificially throttle bandwidth, this isn't something that a website owner can change or manipulate. 

Many CDNs, however, depend on shared TLS certificates and will list many customers in the SAN of a certificate. This is often necessary because of the scarcity of IPv4 addresses. Prior to the adoption of SNI (Server-Name-Indicator) by end users, the client would connect to a server and only after inspecting the certificate, would the client hint which hostname the user user was looking for (using the Host: header in HTTP). This then results in a 1:1 association of an IP address and a certificate. If you are a CDN with many physical locations, each location may require a dedicated IP, further aggravating the exhaustion of IPv4 addresses. Therefore, the simplest and most efficient way for CDNs to offer TLS certificates for websites that still have users that don’t support SNI is to offer a shared certificate. 

According to Akamai, the adoption of SNI is [still not 100% globally](https://datatracker.ietf.org/meeting/101/materials/slides-101-maprg-update-on-tls-sni-and-ipv6-client-adoption-00). Fortunately there has been a rapid shift in recent years. The biggest culprits are no longer Windows XP and Vista, but now Android apps, bots, and corporate applications. Even at 99% adoption, the remaining 1% of 3.5 billion users on the internet can create a very compelling motivation for website owners to require a non-SNI certificate. Put another way, a pure play website can enjoy a virtually 100% SNI adoption among standard Web Browser. Yet, if the website is also used to support APIs or WebViews in Apps, particularly Android Apps, this distribution can drop rapidly.

Most CDNs balance the need for shared certificates and performance. Most cap the number of SANs between 100-150. This limit often derives from the certificate providers. For example, [LetsEncrypt](https://letsencrypt.org/docs/rate-limits/), [DigiCert](https://www.websecurity.digicert.com/security-topics/san-ssl-certificates) and [GoDaddy](https://www.godaddy.com/web-security/multi-domain-san-ssl-certificate) all limit SAN certificates to 100 hostnames while [Comodo](https://comodosslstore.com/comodo-mdc-ssl.aspx)'s limit is 2000. This, in turn, allows some CDNs push this limit cresting over 800 SANs on a single certificate. There is a strong negative correlation of TLS performance and the number of SANs on a certificate.


<figure>
  <iframe aria-labelledby="fig11-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=753130748&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig11.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig11.png" aria-labelledby="fig11-caption" width="600">
  </a>
  <div id="fig11-caption" class="visually-hidden">Distribution showing the number of Subject-Alternative-Names per certificate for initial HTML request, broken down by CDN</div>
  <figcaption>Figure 11. TLS SAN count for HTML.</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>p10</th>
        <th>p25</th>
        <th>p50</th>
        <th>p75</th>
        <th>p90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>section.io</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>2</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>7</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>8</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>3</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td>1</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>4</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>1</td>
        <td>1</td>
        <td>2</td>
        <td>3</td>
        <td>53</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>2</td>
        <td>2</td>
        <td>3</td>
        <td>8</td>
        <td>19</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>1</td>
        <td>1</td>
        <td>3</td>
        <td>39</td>
        <td>59</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>43</td>
        <td>47</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>2</td>
        <td>4</td>
        <td>46</td>
        <td>56</td>
        <td>130</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>2</td>
        <td>2</td>
        <td>11</td>
        <td>78</td>
        <td>140</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>2</td>
        <td>18</td>
        <td>57</td>
        <td>85</td>
        <td>95</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>1</td>
        <td>2</td>
        <td>77</td>
        <td>100</td>
        <td>100</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td>2</td>
        <td>2</td>
        <td>18</td>
        <td>139</td>
        <td>145</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>2</td>
        <td>7</td>
        <td>100</td>
        <td>360</td>
        <td>818</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 12. TLS SAN count for HTML.</figcaption>
</figure>

<figure>
  <iframe aria-labelledby="fig13-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=528008536&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig13.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig13.png" aria-labelledby="fig13-caption" width="600">
  </a>
  <div id="fig13-caption" class="visually-hidden">Median number of Subject-Alternative-Names for sub-resource requests, broken down by CDN</div>
  <figcaption>Figure 13. Resource SAN count (p50).</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>p10</th>
        <th>p25</th>
        <th>p50</th>
        <th>p75</th>
        <th>p90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>section.io</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>3</td>
        <td>10</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>1</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
        <td>6</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>3</td>
        <td>79</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>2</td>
        <td>10</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>2</td>
        <td>3</td>
        <td>3</td>
        <td>3</td>
        <td>35</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>2</td>
        <td>4</td>
        <td>4</td>
        <td>4</td>
        <td>4</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td>2</td>
        <td>4</td>
        <td>4</td>
        <td>4</td>
        <td>4</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>2</td>
        <td>2</td>
        <td>5</td>
        <td>20</td>
        <td>54</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>1</td>
        <td>10</td>
        <td>11</td>
        <td>55</td>
        <td>68</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td>13</td>
        <td>13</td>
        <td>13</td>
        <td>13</td>
        <td>13</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>2</td>
        <td>4</td>
        <td>16</td>
        <td>98</td>
        <td>128</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td>6</td>
        <td>6</td>
        <td>79</td>
        <td>79</td>
        <td>79</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td>2</td>
        <td>2</td>
        <td>98</td>
        <td>98</td>
        <td>98</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>2</td>
        <td>43</td>
        <td>99</td>
        <td>99</td>
        <td>99</td>
      </tr>
      <tr>
        <td>jsDelivr</td>
        <td>2</td>
        <td>116</td>
        <td>116</td>
        <td>116</td>
        <td>116</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>132</td>
        <td>178</td>
        <td>397</td>
        <td>398</td>
        <td>645</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 14. 10th, 25th, 50th, 75th, and 90th percentiles of the distribution of resource SAN count.</figcaption>
</figure>

## TLS adoption

In addition to using a CDN for TLS and RTT performance, CDNs are often used to ensure patching and adoption of TLS ciphers and TLS versions. In general, the adoption of TLS on the main HTML page is much higher for websites that use a CDN. Over 76% of HTML pages are served with TLS compared to the 62% from Origin hosted pages. 

<figure>
  <iframe aria-labelledby="fig15-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=528008536&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig15.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig15.png" aria-labelledby="fig15-caption" width="600">
  </a>
  <div id="fig15-caption" class="visually-hidden">Break down of TLS version used to establish secure connection for the initial HTML request but origin and CDN requests</div>
  <figcaption>Figure 15. HTML TLS version adoption (CDN vs. origin).</figcaption>
</figure>

Each CDN offers different rates of adoption for both TLS and the relative ciphers and versions offered. Some CDNs are more aggressive and roll out these changes to all customers whereas other CDNs require website owners to opt-in to the latest changes and offer change-management to facilitate these ciphers and versions.

<figure>
  <iframe aria-labelledby="fig16-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=659795773&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig16.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig16.png" aria-labelledby="fig16-caption" width="600">
  </a>
  <div id="fig16-caption" class="visually-hidden">Division of secure vs non-secure connections established for initial HTML request broken down by CDN</div>
  <figcaption>Figure 16. HTML TLS adoption by CDN.</figcaption>
</figure>

<figure>
  <iframe aria-labelledby="fig17-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=991037479&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig17.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig17.png" aria-labelledby="fig17-caption" width="600">
  </a>
  <div id="fig17-caption" class="visually-hidden">Division of secure vs non-secure connections established for third-party requests broken down by CDN</div>
  <figcaption>Figure 17. Third-party TLS adoption by CDN.</figcaption>
</figure>

Along with this general adoption of TLS, CDN use also sees higher adoption of emerging TLS Versions like TLS 1.3. 

In general the use of a CDN is highly correlated with a more rapid adoption of stronger ciphers and stronger TLS versions compared to Origin hosted services where there is a higher user of very old and compromised TLS Versions like TLS 1.0. 

<aside class="note">It is important to emphasise that Chrome used in the Web Almanac will bias to the latest TLS versions and ciphers offered by the host. Also, these web pages were crawled in July 2019 and reflect the adoption of websites that have enabled the newer versions.</aside> 

<figure>
  <iframe aria-labelledby="fig18-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=659795773&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig18.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig18.png" aria-labelledby="fig18-caption" width="600">
  </a>
  <div id="fig18-caption" class="visually-hidden">Version of TLS used to establish connection for initial HTML request broken down by CDN</div>
  <figcaption>Figure 18. HTML TLS version by CDN.</figcaption>
</figure>

More discussion of the TLS versions and ciphers can be found In the [Security](./security) and [HTTP/2](./http2) chapters, 

## HTTP/2 adoption

Along with RTT Management and improving TLS performance, CDNs also enable new standards like HTTP/2 and IPv6. While most CDNs offer support for HTTP/2 and many have signaled early support of the still-under-standards-development HTTP/3, adoption still depends on website owners to enable these new features. Despite the change management overhead, the majority of the HTML served from CDNs has HTTP/2 enabled. 

The top 10 CDNs have over 80% of the websites covered by WebPageTest have HTTP/2 enabled compared to the nearly 27% of ORIGIN pages. Similarly, sub domain and third party resources on CDNs see an even higher adoption of HTTP/2 at 90% or higher while third party resources served from origin infrastructure only has 31% adoption. The performance gains and other features of HTTP/2 are further covered in the [HTTP/2](./http2) chapter.

<aside class="note">NB: All requests were made with the latest version of Chrome which supports HTTP/2. When only HTTP/1.1 is reported this would indicate either unencrypted (non TLS) servers or servers that don’t support HTTP/2.</aside>

<figure>
  <iframe aria-labelledby="fig19-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1166990011&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig19.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig19.png" aria-labelledby="fig19-caption" width="600">
  </a>
  <div id="fig19-caption" class="visually-hidden">Comparison of HTTP/2 usage between requests via CDN, and site origins</div>
  <figcaption>Figure 19. HTTP/2 adoption (CDN vs. origin).</figcaption>
</figure>

<figure>
  <iframe aria-labelledby="fig20-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1896876288&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig20.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig20.png" aria-labelledby="fig20-caption" width="600">
  </a>
  <div id="fig20-caption" class="visually-hidden">Comparison of HTTP/2 usage between requests from intial HTML via CDN, and site origins</div>
  <figcaption>Figure 20. HTML adoption of HTTP/2.</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>HTTP/0.9</th>
        <th>HTTP/1.0</th>
        <th>HTTP/1.1</th>
        <th>HTTP/2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td>0</td>
        <td>0</td>
        <td>0.38</td>
        <td>100</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>0</td>
        <td>0</td>
        <td>1.07</td>
        <td>99</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td>0</td>
        <td>0</td>
        <td>1.56</td>
        <td>98</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td>0</td>
        <td>0</td>
        <td>7.97</td>
        <td>92</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td>0</td>
        <td>0</td>
        <td>12.03</td>
        <td>88</td>
      </tr>
      <tr>
        <td>Instart Logic</td>
        <td>0</td>
        <td>0</td>
        <td>12.36</td>
        <td>88</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>0</td>
        <td>0</td>
        <td>14.06</td>
        <td>86</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>0</td>
        <td>0</td>
        <td>15.65</td>
        <td>84</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>0</td>
        <td>0</td>
        <td>16.34</td>
        <td>84</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>0</td>
        <td>0</td>
        <td>16.43</td>
        <td>84</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>0</td>
        <td>0</td>
        <td>17.34</td>
        <td>83</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>0</td>
        <td>0</td>
        <td>18.19</td>
        <td>82</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>0</td>
        <td>0</td>
        <td>25.53</td>
        <td>74</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td>0</td>
        <td>0</td>
        <td>33.16</td>
        <td>67</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>0</td>
        <td>0</td>
        <td>37.04</td>
        <td>63</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td>0</td>
        <td>0</td>
        <td>43.44</td>
        <td>57</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>0</td>
        <td>0</td>
        <td>47.17</td>
        <td>53</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td>0</td>
        <td>0.06</td>
        <td>50.05</td>
        <td>50</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>0</td>
        <td>0</td>
        <td>52.45</td>
        <td>48</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>0</td>
        <td>0.01</td>
        <td>55.41</td>
        <td>45</td>
      </tr>
      <tr>
        <td>Yunjiasu</td>
        <td>0</td>
        <td>0</td>
        <td>70.96</td>
        <td>29</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td>0</td>
        <td>0.1</td>
        <td>72.81</td>
        <td>27</td>
      </tr>
      <tr>
        <td>Zenedge</td>
        <td>0</td>
        <td>0</td>
        <td>87.54</td>
        <td>12</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>0</td>
        <td>0</td>
        <td>88.21</td>
        <td>12</td>
      </tr>
      <tr>
        <td>ChinaNetCenter</td>
        <td>0</td>
        <td>0</td>
        <td>94.49</td>
        <td>6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 21. HTML adoption of HTTP/2 by CDN.</figcaption>
</figure>

<figure>
  <iframe aria-labelledby="fig22-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=397209603&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig22.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig22.png" aria-labelledby="fig22-caption" width="600">
  </a>
  <div id="fig22-caption" class="visually-hidden">Comparison of HTTP/2 usage between requests from intial HTML via CDN, and site origins</div>
  <figcaption>Figure 22. HTML/2 adoption: third party resources.</figcaption>
</figure>

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
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>100</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>100</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td>0</td>
        <td>0</td>
        <td>1</td>
        <td>99</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td>0</td>
        <td>0</td>
        <td>2</td>
        <td>98</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td>0</td>
        <td>0</td>
        <td>2</td>
        <td>98</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td>0</td>
        <td>0</td>
        <td>4</td>
        <td>96</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td>0</td>
        <td>0</td>
        <td>6</td>
        <td>94</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>0</td>
        <td>0</td>
        <td>7</td>
        <td>93</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td>0</td>
        <td>0</td>
        <td>7</td>
        <td>93</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td>0</td>
        <td>0</td>
        <td>7</td>
        <td>93</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>0</td>
        <td>0</td>
        <td>8</td>
        <td>92</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>0</td>
        <td>0</td>
        <td>10</td>
        <td>90</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>0</td>
        <td>0</td>
        <td>14</td>
        <td>86</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>0</td>
        <td>0</td>
        <td>16</td>
        <td>84</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td>0</td>
        <td>0</td>
        <td>17</td>
        <td>83</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>0</td>
        <td>0</td>
        <td>26</td>
        <td>75</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>0</td>
        <td>0</td>
        <td>26</td>
        <td>74</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td>0</td>
        <td>0</td>
        <td>27</td>
        <td>73</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td>0</td>
        <td>0</td>
        <td>30</td>
        <td>70</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td>0</td>
        <td>0</td>
        <td>42</td>
        <td>58</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td>0</td>
        <td>0</td>
        <td>43</td>
        <td>57</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>0</td>
        <td>0.01</td>
        <td>47</td>
        <td>53</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>0</td>
        <td>0</td>
        <td>56</td>
        <td>44</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td>0</td>
        <td>0</td>
        <td>68</td>
        <td>31</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td>0</td>
        <td>0.07</td>
        <td>69</td>
        <td>31</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 23. HTML/2 adoption: third party resources.</figcaption>
</figure>

## Controlling CDN caching behavior

### Vary

A website can control many the caching behavior of browsers and CDNs with the use of different HTTP headers. The most common is the `Cache-Control` header which specifically determines how long something can be cached before returning to the origin to ensure it is up-to-date. 

Another useful tool is the use of the `Vary` HTTP Header. This header instructs both CDNs and Browsers how to fragment a cache. The Vary Header allows an origin to indicate there are multiple representations of a resource, and the CDN should cache each variation separately. The most common example is compression as discussed in [Compression](./compression). Declaring a resource as `Vary: Accept-Encoding` allows the CDN to cache the same content but in different forms like uncompressed, with gzip or Brotli. Some CDNs even do this compression on the fly so as to keep only one copy available. This Vary header likewise also instructs the browser how to cache the content and when to request new content. 

<figure>
  <a href="/static/images/2019/17_CDN/use_of_vary_on_cdn.png">
    <img alt="Breakdown of Vary header values for HTML content served from a CDN" src="/static/images/2019/17_CDN/use_of_vary_on_cdn.png" width="600">
  </a>
  <figcaption>Figure 24. Usage of <code>Vary</code> for HTML served from CDNs.</figcaption>
</figure>

While the main use of `Vary` is to coordinate `Content-Encoding`, there are other important variations that web sites signal cache fragmentation. Using `Vary` also instructs SEO bots like DuckDuckGo, Google, and BingBot that alternate content would be returned under different conditions. This has been important to avoid SEO penalties for ‘ghosting’ (sending SEO specific content in order to game the rankings).

For HTML pages, the most common use of Vary is to signal that the content will change based on the User-Agent. This is short-hand to indicate that the website will return different content for Desktops, Phones, Tablets and Link Unfurling engines (like Slack, iMessage and Whatsapp). The use of `Vary: User-Agent` is also a vestigate of the early mobile era where content was split between mDot servers and "regular" servers in the back end. While the adoption for Responsive Web has gained wide popularity, this Vary form remains.

In a similar way, `Vary: Cookie` usually indicates content that will change based on the logged in state of the user or other personalization. 

<figure>
  <a href="/static/images/2019/17_CDN/use_of_vary.png">
    <img alt="Comparison of Vary header values for HTML and Resouces, divided by Orign and CDN" src="/static/images/2019/17_CDN/use_of_vary.png" width="600">
  </a>
  <figcaption>Figure 25. Comparison of <code>Vary</code> usage for HTML and resources served from origin and CDN.</figcaption>
</figure>

Resources, in contrast, don’t `Vary: Cookie` as much as the HTML resources. Instead these resources are more likely to adapt based on the Accept, Origin or Referer. Most media, for example, will use `Vary: Accept` to indicate that an image could be a JPEG, WebP, JPEG 2000, or JPEG XR depending on the Browser’s offered `Accept` header.  In a similar way, third party shared resources signal that an XHR API will differ depending on which website it is embedded. This way a call to an ad server API will return different content depending on the parent website that called the API.

The Vary header also contains evidence of CDN chains, these can be seen in Vary headers such as "Accept-Encoding, Accept-Encoding" or even "Accept-Encoding, Accept-Encoding". Further analysis of these chains and Via header entries might reveal interesting data, for example how many sites are proxying third-party tags. 

Many of the uses of the `Vary` are extraneous. With most browsers adopting double-key caching, the use of `Vary: Origin` is redundant. As is `Vary: Range` or `Vary: Host` or `Vary: *`. The wild and variable use of `Vary` is demonstrable proof that the internet is weird. 

### Surrogate-Control, s-maxage and Pre-Check

There are other HTTP headers that specifically target CDNs, or other proxy caches, such as the Surrogate-Control, the s-maxage, pre-check, and post-check values in the Cache-Control header etc., and in general usage of these headers is low.

Surrogate-Control allows origins to specify caching rules just for CDNs, and as CDNs are likely to strip the header before serving responses it’s low visible usage isn’t a surprise, in fact it’s surprising that it’s actually in any responses at all (it was even seen from some CDNs that state they strip it)

Some CDNs support post-check as a method to allow a resource to refreshed when it goes stale, and pre-check as a maxage equivalent. For most CDNs usage of pre-check and post-check was below 1%, Yahoo was the exception to this and ~15% of requests had pre-check=0, post-check=0 – unfortunately this seems to be the remnant of an old Internet Explorer pattern rather than active usage. More discussion on this can be found in the [Caching](./caching) chapter.

The s-maxage directive informs proxies how long they may cache a response for. Across the Web Almanac dataset, jsDelivr is the only CDN where a high level of usage was seen across multiple resources – this isn’t surprising given jsDelivr’s role as public CDN for libraries. Usage across other CDNs seems to be driven by individual customers e.g. 3rd-party scripts, or SaaS providers using that particular CDN.

<figure>
  <iframe aria-labelledby="fig18-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1215102767&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig26.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig26.png" aria-labelledby="fig26-caption" width="600">
  </a>
  <div id="fig26-caption" class="visually-hidden">Comparison of s-maxage adoption across CDNs</div>
  <figcaption>Figure 26. Adoption of <code>s-maxage</code> across CDN responses.</figcaption>
</figure>

With 40% of sites using a CDN for resources, and presuming these resources are static and cacheable, the usage of `s-maxage` seems low.

Future research might explore cache lifetimes versus the age of the resources, and the usage of `s-maxage` versus other validation directives such as `stale-while-revalidate`.

## CDNs for common libraries and content

So far this chapter has explored the use of commercials CDNs which the site may be using using the CDN to host its own content, or perhaps used by a third-party tag that’s included on the site.

Common libraries – jQuery, Bootstrap etc. – are also available from public CDNs hosted by Google, Cloudflare, Microsoft, etc.

Using content from one of the public CDNs instead of a self-hosting the content is a tradeoff – even though the content is hosted on a CDN, creating a new connection, and growing the congestion window may negate the low latency of using a CDN.

Google Fonts is the most popular of the content CDNs and is used by 55% of the sites in the Almanac dataset. For non-font content Google API, Cloudflare’s JS CDN, and the Bootstrap’s CDN are the next most popular. 

<figure>
  <iframe aria-labelledby="fig27-caption" width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=123086113&format=interactive"></iframe>
  <a href="/static/images/2019/17_CDN/fig27.png" class="fig-mobile">
    <img src="/static/images/2019/17_CDN/fig27.png" aria-labelledby="fig27-caption" width="600">
  </a>
  <div id="fig27-caption" class="visually-hidden">Most popular content CDNs</div>
  <figcaption>Figure 27. Usage of public content CDNs.</figcaption>
</figure>

As more browsers implement partitioned caches, the effectiveness of public CDNs for hosting common libraries will decrease  and it will be interesting to see whether they are less popular in future iterations of this research.

## Conclusion

The reduction in latency CDNs deliver, along with their ability to store content close to visitors enables sites to deliver faster experiences while reducing the load on the origin.

Steve Souders’ recommendation to use a CDN remains as valid today as it was 12 years ago, but yet only 20% of sites serve their HTML content via a CDN, and only 40% are using a CDN for resources so there’s plenty of opportunity for their usage to grow further.

There are some aspects of CDN adoption that aren't included in this analysis, sometimes 
this was due to the limitations of the dataset and how it's collected, in other cases new research questions emerged during the analysis.

As the web continues to evolve, CDN vendors innovate, and sites use new practices CDN adoption remains an area rich for further research in future editions of the Web Almanac.
