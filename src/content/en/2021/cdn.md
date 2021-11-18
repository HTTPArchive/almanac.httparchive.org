---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: TODO
authors: [Navaneeth-akam]
reviewers: [jzyang, boosef]
analysts: [paulcalvano]
editors: [jzyang]
translators: []
results: https://docs.google.com/spreadsheets/d/1DL7Pn1vbBwYmQZ5JPAjD69oCOvUidbuoNvdrw--j00U/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

**What is a CDN?**

A CDN or Content Delivery Network is a geographically distributed network of proxy servers in data-centers. The goal of a CDN is to provide high availability and performance for web content.  It does this by distributing content closer to the end users.

CDNs have been in existence for over two decades. With the exponential rise in internet traffic, contributed by online video consumption, online shopping, and increased video conferencing due to COVID-19, CDNs are required more than ever before.  They ensure high availability and good web performance despite this growth in internet traffic. 

During the early days, a CDN was a simple network of proxy servers which would



1. Cache content (like HTML, images, stylesheets, Javascripts, videos, etc),
2. Reduce network hops for end users to access content, and
3. Offload TCP connection termination away from the data centers hosting the web properties.

They primarily helped web owners to improve the page load times and to offload traffic from the infrastructure hosting these web properties.

Over time, the services offered by CDN providers have evolved beyond caching and offloading bandwidth/connections.  Now they offer services like



* Cloud-hosted Web Application Firewalls
* Bot Management solutions
* Clean pipe solutions (Scrubbing Data-centers)
* Serverless Computing offerings
* Image and Video Management solutions etc., 

Thus, a web owner these days has a lot of options to choose from. This can be overwhelming and complex since these new offerings from CDNs make them an extension of your application and require closer integration with application development life-cycle. 

There are benefits to web owners such as pushing web application logic and workflows closer to the end user. This eliminates the round trip and bandwidth that a HTTP/HTTPS request would take.  It also handles instant scalability requirements for the origin.  A side-effect of this is that Internet Service Providers (ISPs) benefit from the scalability management as well, which improves their infrastructure capacities.

This reduction in requests reduces the load on the internet backbone ([read Middle-Mile of the Internet](https://en.wikipedia.org/wiki/Middle_mile)).  It also helps manage more of the internet load within the last mile of the internet.  Thus, a CDN plays a multifaceted role in the Internet landscape as it allows web owners to improve the performance, reliability and scalability of content delivery.

**Caveats and Disclaimers**

As with any observational study, there are limits to the scope and impact that can be measured. The statistics gathered on CDN usage for the Web Almanac are focused more on applicable technologies in use and not intended to measure performance or effectiveness of a specific CDN vendor. While this ensures that we are not biased towards any CDN vendor, it also means that these are more generalized results.

These are the limits to our testing methodology:

**Simulated network latency:** We use a dedicated network connection that synthetically shapes traffic.

**Single geographic location:** Tests are run from a single datacenter and cannot test the geographic distribution of many CDN vendors.

**Cache effectiveness:** Each CDN uses proprietary technology and many, for security reasons, do not expose cache performance.

**Localization and internationalization: **Just like geographic distribution, the effects of language and geo-specific domains are also opaque to these tests.

**CDN detection:** This is primarily done through DNS resolution and HTTP headers. Most CDNs use a DNS CNAME to map a user to an optimal datacenter. However, some CDNs use AnyCast IPs or direct A+AAAA responses from a delegated domain which hide the DNS chain. In other cases, websites use multiple CDNs to balance between vendors, which is hidden from the single-request pass of WebPageTest. 

All of this limits the effectiveness in the measurements.

Most importantly, these results reflect the utilization of specific features (Example: TLS, HTTP/2 etc.,) but do not reflect actual impact. YouTube is more popular than “www.example.com” yet both will appear as equal value when comparing utilization.

With this in mind, here are a few statistics that were intentionally not measured in the context of a CDN:



1. Time To First Byte(TTFB)
2. CDN Round Trip Time
3. Core Web Vitals
4. Cache Hit v/s Cache Miss performance etc.,

**CDN Adoption**

The contents in a web page can be divided into 3 parts, namely:



1. Base HTML Page (Ex: [www.example.com](www.example.com))
2. Embedded First Party Content (Ex: images.example.com, css.example.com etc.,)
3. 3rd Party Content (Ex: Google Analytics, Advertisements etc.,)

From their inception, CDNs have been the go-to solution for delivering embedded content like: images, stylesheets, javascripts, fonts, etc.  This kind of  content doesn't change frequently, making it a good candidate for caching on a CDN’s proxy servers.

With the evolution of CDN technology an expressway was set up on the internet for non-cacheable assets.  This means HTMLs and APIs can now be delivered reliably and faster, compared to the standard TCP connection.



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


The impact of this can be seen in the above chart when we compare this against the same data in [Web Almanac 2019 - CDN Chapter](https://almanac.httparchive.org/en/2019/cdn) (there was no CDN Chapter in Web Almanac 2020). It's good to see the trend of HTMLs using CDN has improved by 7% between 2019 and 2021.  This shows that more of the industry is leveraging CDNs to take benefit of consistent content delivery times and minimize the impact of congestion on Internet

Looking at third party content, there is negative growth for CDN adoption. Compared to [Web Almanac 2019 - CDN Chapter](https://almanac.httparchive.org/en/2019/cdn), we see 3% reduction in domains using CDNs. Third party domains are used by SaaS vendors for analytics, advertisements, responsive pages, etc. It is in the SaaS vendor’s interest to use CDNs for their services. Their content is used by multiple web owners and this content gets accessed by end users across geographies, making CDNs necessary from both a business and performance standpoint. This is evident in the charts where it's clear that third party content has the highest adoption of CDN.

But why do we see this negative growth in CDN Adoption for third party domains?

The probable reasons for this may include:



* The HTTP/2 protocol requires web owners to consolidate the domains instead of using multiple domains for optimal performance.
* Contribution of third party content to total page weight has also increased over the years (refer to the [Third Parties](./third-parties) chapter for more details) leading to increased page load time concerns for web owners.
* Customization/personalization of third party scripts to suit the requirements of web owners.

These changes have led to the SaaS vendors offering “self-hosting” options to web owners. This leads to more content being delivered over the first party domain instead of the vendor’s domain. When this happens, it’s up to the web owner to either deliver the content over a CDN or directly from their hosting infrastructure.

While we observed CDN adoption across different types of content, we will not look at this data a bit different below



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")




<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


Ranking the domains based on their popularity (at the time of this writing sourced from Google CRUX data) in the web and then checking for their CDN usage, the top 1000 websites contribute to the highest usage of CDN. The top websites include domains owned by names like Google, Amazon who contribute to much of the internet traffic we see today and it’s no surprise that these names make it to the list of “Top CDN Providers” in the next section. This also backs the fact about the benefits CDN’s bring to the table when operating at scale and having the ability to scale further if needed.

The CDN adoption rate falls below 50% when we look at the top 100,000 websites but the rate of reduction slows down beyond this. At the top 10 million website mark (which is 100x more websites than at top 100,000), 25.88% of these websites use CDN. When you translate that percentage into real number, that’s 

2.588 million websites using CDN! That is not a small number when you look at it this way.

But the decreasing percentage of CDN adoption in the low popularity website end does make sense considering the benefits of CDN (like caching, TCP connection offload etc.,) increases with increased end users on the web property. Below a certain scale of end user traffic on a web property, the cost-to-benefit math of a CDN may not work in web property owner’s favor and they might be better off delivering the web content directly from origin.

**Top CDN Providers**

CDN providers can be broadly classified into 2 segments:



1. Generic CDN (Akamai, Cloudflare, Fastly etc.,)
2. Purpose-built CDN (Netlify, Wordpress etc.,)

Generic CDN addresses the mass market requirements. Their offerings include: 



* Web site delivery, 
* Mobile app API delivery, 
* Video streaming, 
* Serverless compute offerings, 
* Web security offerings, etc. 

This appeals to a  larger set of industries and is reflected in the data.  Generic CDNs hold the lion's share of the HTML and First party subdomain traffic: 



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


CDN providers like: 



* Cloudflare 
* Fastly
* Akamai
* Limelight

They appear in this list of Generic CDN providers.

We also see providers like: 



* Google,
* AWS 

They appear in this list since they offer bundled CDN offerings along with their Cloud hosting services.  These bundles help reduce load on the hosting infrastructure and also improves web performance.



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


Looking at third party domains below, you see a different trend in top CDN Providers.  We see Google top the list followed by generic CDN providers. The list also brings Facebook into prominence. This is backed by the fact that a lot of third-party domain owners require CDNs more than other industries. This necessitates them to invest in building a purpose-built CDN. A purpose-built CDN is one which is optimized for a particular content delivery workflow.

For example, a CDN built specifically to deliver advertisements will be optimized for:



1. High input-output (I/O) operations,
2. Effective management of [long tail](https://en.wikipedia.org/wiki/Long_tail) content, and
3. Geographical closeness to businesses requiring their services. 

This means, purpose-built CDNs meet the exact requirements of a particular market segment as opposed to a generic CDN solution.  Generic solutions can meet a broader set of requirements, but it is not optimized for any particular industry or market.

 

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


**TLS Adoption Impact**

With CDNs set up in the request-response workflows, the end user’s TLS connection terminates at the CDN. In turn, the CDN sets up a second independent TLS connection and this connection goes from the CDN to the origin host. This break in the CDN workflow allows the CDN to define the end user's TLS parameters. CDNs tend to also provide automatic updates to internet protocols.  This allows web owners to receive these benefits without making changes to their origin.



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")




<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


We see in the data above that 83% of the web properties on CDNs use TLS 1.3 compared to 33-35% on the origin. That's a huge benefit of using a CDN.  These protocol upgrades also come with minimal to no-effort for web owners. The trend is identical for Mobile and Desktop HTMLs.

Similar trend is observed for the third party domains below. These web services with CDNs have better adoption of TLS 1.3 than the ones without for the same reasons.



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")




<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


It is important for third party domains to be on the latest TLS version for security reasons. With the increase in web attacks, web owners are aware of loopholes that can be exploited with unsecure connections to third party domains. They will expect equally secure TLS connections which meet the security and performance requirements of their web sites. These expectations enhance the benefits CDNs bring to the table.

**TLS Performance Impact**

Common logic dictates that the fewer hops it takes for a HTTPS request-response to traverse, the faster the round trip would be. So exactly how much quicker can it be if the TLS connection terminates closer to the end user?  The answer: As much as 3x faster!



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


CDNs have helped slash the TLS connection times.  This is due to their proximity to the end user and adoption of newer TLS protocols that optimize the TLS negotiation. CDNs hold the edge over Origin at all percentiles here. At P10 and P25, CDNs are nearly 1.5x to 2x faster than Origin in TLS set up time.  The gap increases even more once we hit the median and above, where CDNs are nearly 3x faster. A user at P90 using a CDN will have better performance than a user at P50 of Origin.

This is quite important when you look at the fact that all sites will have to be on TLS these days.  Optimal performance at this layer is essential for other steps that follow TLS connection. In this regard, CDNs are able to move more users to lower percentile brackets compared to Origin.

**HTTP/2+ (HTTP/2 or better) Adoption**

HTTP/2 was introduced with a lot of hype and expectation. This was because the application layer protocol has not been updated since HTTP 1.1 in 1997. Since then, the web traffic trend, content-type, content size, website design, platforms, mobile apps etc., have evolved significantly. Thus, there was a need to have a protocol which can meet the requirements of the modern day web traffic and that protocol was going to be HTTP/2.

However, the implementation challenges of HTTP/2 features discouraged adoption. In addition, the net performance gains which can be expected with these changes was also not clear.

This was where the CDNs became an intermediary in bridging the challenge of HTTP/2 implementation for web owners. Similar to TLS, an HTTP/2 connection terminates at the CDN level and this provides web owners the ability to deliver their website and subdomains over HTTP/2 without the need to upgrade their infrastructure to support it. 

CDNs acted as the proxy to bridge the gap by providing a layer to consolidate hostnames and route traffic to relevant endpoints with minimal change to their hosting infrastructure. Features like prioritizing content in the queue, server push could be managed from the CDN’s side and a few CDN’s even provided hands-off automated solutions to run these features without any inputs from website owners, thus providing a push to HTTP/2 adoption (no pun intended ;)).

The trend cannot be clearer than what the graph shows below. There is high HTTP/2+ adoption by domains on CDNs compared to the ones not using a CDN.



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")




<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


Back in 2019, the Origin domains had 27% adoption of HTTP/2 compared to 71% adoption on CDN. While we see in Desktop HTMLs that there is about a 14% increase in origins supporting HTTP/2+ in 2021, domains on CDNs have maintained that lead with a 15% increase. This gap is a bit less when we look at Mobile HTMLs, where domains using a CDN have a slightly lower HTTP/2+ adoption compared to Desktop HTML’s.



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")




<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


Looking at third party domains supporting newer protocols, we see an interesting trend of higher adoption of HTTP/2+protocols compared to first party domains. This makes sense, considering the fact that most of the top third party domains use purpose-built CDNs and thus have more control on the content development and content delivery. Additionally, third party domains need to have consistent performance across all network conditions and this is where HTTP/2+ adds value by mixing in other protocols like UDP along with TCP connections. Back in 2019, Uber did an experiment to understand how UDP along with TCP (aka QUIC, the precursor to HTTP/3) can help deliver content with consistent performance and overcome packet loss in highly congested mobile networks. The results of this experiment documented in [this blog post](https://eng.uber.com/employing-quic-protocol/) throws valuable insights into the demographic where HTTP/3 can help. Over time, this trend will trickle down and we should see web owners adopting HTTP/3, especially with mobile network traffic having a higher contribution to the total internet traffic.

**Brotli Adoption**

Content delivered over the internet employs compression to reduce the payload size. A smaller payload means it’s faster to deliver the content from server to end user. This makes websites load faster and provide a better end user experience. For images, this compression is handled by image file formats like JPEG, WEBP, AVIF, etc. (refer to [Media](./media) chapter for more on this). For textual web assets (like HTML, Javascripts, stylesheets, etc.) compression is handled by a file format called “[GZIP](https://en.wikipedia.org/wiki/Gzip)”. GZIP has been in existence since 1992.  It did a good job of making text asset payloads smaller,but it is time for a new text asset compression to do better than GZIP:[Brotli](https://en.wikipedia.org/wiki/Brotli) (refer to the [Compression](./compression) chapter for more on this). 

Similar to TLS and HTTP/2 adoption, Brotli went through a phase of gradual adoption across web platforms. At the time of this writing, Brotli is supported by 95% of the web platforms globally. However, not all websites compress text assets in Brotli format. This is because of the longer time required to compress a text asset in Brotli format compared to GZIP compression. Also, the hosting infrastructure needs to have backward compatibility to serve GZIP compressed assets for older platforms which do not support the Brotli format.

The impact of this is observed when we compare websites which are using CDN against the ones not using CDN.



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")




<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")


On both Desktop and Mobile platforms, we see that CDNs are delivering twice as many text assets in Brotli, unlike domains delivered from origin.  From the “CDN Adoption” section covered earlier, 73% of the domains serving HTMLs are on CDNs and these all  benefit from the Brotli compression. By offloading the computational load of compressing a text asset in the Brotli format to CDNs, website owners need not invest resources for hosting infrastructure.

However, it is at the web property owner’s discretion whether to use Brotli compression on their CDNs or not. Compared to 95% of the web platforms globally which support Brotli compression, even with CDNs in place, less than half of all the text assets are delivered in Brotli format. Thus there is space for this adoption to improve. 

**Conclusion**

There are limitations to the insights we can deduce about CDNs since it is hard to know the secret sauce powering them behind the scenes. However, we have crawled the domains and  compared the ones on CDNs against those who are not.   We can see that CDNs have been an enabler for websites to adopt new web protocols, from the network layer to the application layer.

This impact is universal, with similar adoption rates across mobile and desktop: from using the latest TLS versions to upgrading to the newest HTTP versions (like HTTP/2, HTTP/3) to using the Brotli compression. What stands out is the depth of this impact and the sizable lead the CDN domains have built relative to non-CDN domains.

This role of CDNs is highly valuable and this will continue to be the case. CDN providers are a part of the Internet Task Force, where they help shape the future of the internet. They will continue to play a key role aiding the Internet-enabled industries to operate smoothly, reliably and quickly.

   

