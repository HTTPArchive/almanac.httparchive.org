---
part_number: IV
chapter_number: 20
title: HTTP/2
authors: [bazzadp]
reviewers: [bagder, rmarx, dotjs]
translators: []
---

![](https://github.com/HTTPArchive/almanac.httparchive.org/raw/master/src/static/images/2019/20_HTTP_2.jpg)

## Introduction
HTTP/2 was the first major update to the main transport protocol of the web in nearly 20 years. It arrived with a wealth of expectations. It promised a free performance boast with no downsides. More than that - we could stop doing all the hacks and work arounds that HTTP/1.1 forced us into to get around it's inefficiences. Bundling, spriting, inline and even sharding domains would all become anti-patterns in an HTTP/2 giving performance by default, meaning even those without the skills and resources to concentrate on web performance would suddenly have performant websites. The reality has been, as ever, a little more nuanced than that. Now over four years since it's formal approval as a [standard in May 2015 as RFC 7540](https://tools.ietf.org/html/rfc7540), is a good time to look over how this relatively new technology has fared in the real world.

## What is HTTP/2?
For those not familar with the technology a bit of background is helpful to make the most of the metrics and findings in this chapter. Up until recently HTTP has always been a text-based protocol. An HTTP client like a web browser opened a TCP connection to a server, and then sent an HTTP command like `GET /index.html` to ask for a resource. This was enhanced in HTTP/1.0 to add *HTTP headers* so various pieces of meta data could be made in addition to the request (what browser it is, formats it understands...etc.). These HTTP headers were also text-based and separated by newline characters. Servers parsed the incoming reqests by reading the requst and any HTTP headers line by line, and then the server responded, with it's own HTTP headers and the actual resource being requested. Being text-based, made the protocol seem simple, but that also meant certain limitations - the main one being that HTTP was basically syncronous: once an HTTP request had been sent, the whole TCP connection was basically off limits for anything else until the response had come back and been read and processed. This was incredibly inefficient and required multiple TCP connections (browsers typically use 6) to allow a limited form of parallelization. That in itself brings it's own issues as TCP connections, especially when using HTTPS that is standard nowadays, take time and resources to set up and get to full efficiency. HTTP/1.1 improved it somewhat allowing reuse of TCP connections for subsequent requests but still did not solve the parallelization issue.
Despite HTTP being text-based, the reality is that it was rarely used to transport text. While it was true that HTTP headers were still text, the paylods themselves often were not. Text files like HTML, JS and CSS are usually [compressed](../compression/) for transport into a binary format using gzip, brotli or similar and non-text files like images, videos..etc. are served in their own formats. On top of that, the whole HTTP message is often wrapped in HTTPS to encrypt the messages for security reasons. So the web had basically moved on from text-based transport a long time ago but HTTP had not. One reasons for this stagnation was because it was so difficult to introduce any breaking changes to such an ubiquitous protocol like HTTP (previous efforts had tried and failed).
In 2009 - over 10 years ago - Google announced they were working on an alternative to the text-based HTTP called SPDY. This would take advantage of the fact that HTTP messages were often encrypted in HTTPS which were then passed along through the internet without being able to be read en route. Google controlled one of the most popular browsers (Chrome) and some of the most popular websites (Google, Youtube, Gmail...etc.) - so both ends of the connection. Google's idea was to pack HTTP messages into a proprietary format, send them across the internet, and then unpacked them on the other side. The proprietary format (SPDY) was binary-based rather than text-based which solved some of the main performance problems with HTTP/1.1. By using SPDY in the real world they were able to prove it was more performant for real users, and not just because some lab-based experiments show them. After rolling SPDY out to all Google websites, other servers and browser started implementing it, and then it was time to standardise this proprietary format into an internet standard and thus HTTP/2 was born.
HTTP/2 has the following main concepts:
* Binary format
* Multiplexing
* Flow Control
* Prioritisation
* Header compression
* Push
*Binary format*, means that HTTP/2 messages are wrapped into *Frames* of a pre-defined format. This means HTTP messages are easier to parse and no longer require scanning for newline characters. It also means HTTP/2 connections can be multiplexed: different *Frames* for different *Streams* can be sent on the same connection without interfering with each other as each Frame includes a Stream Identifier and its length. Multiplexing allows much more efficient use of that TCP connection without having to open other connections.
Having separate *Streams* does introduce some complexities alongs some potential benefits. HTTP/2 needs the concept of *Flow Control* to allow the different streams to send data at different rates, whereas previously, with only one response in flight at any one time, this was controlled at a connection level by TCP flow control. *Prioritization* similarly allows multiple requests to be be sent together but with the most important requests getting more of the bandwidth.
Finally HTTP/2 introduced two new concepts: *Header Compression* allowed those text-based HTTP headers to be sent more efficiently (using a HTTP/2-specific *HPACK* format for security reasons) and *HTTP/2 Push* allowed more than one response to be sent in answer to a request. *Push* was supposed to solve the performance workaround of having to inline resources like CSS and Javascript directly into HTML to prevent holding up the page while those resources were requested. With HTTP/2 the CSS and Javascript could remain as external files, but be pushed along with the initial HTML so they were available immeadiately. Subseuqent page requests would not push these resources, since they would now be cached, and so would not waste bandwidth.
This whistlestop tour of HTTP/2 gives the main history and concepts of the newish protocol. As should be apparent from this expalantion, the main benefit of HTTP/2 is to address performance limitations of the protocol. Other than the web browser packing the HTTP messages into the new binary format, and the web server unpacking it at the other side, the core basics of HTTP itself stayed roughly the same. This means web applications do not need to make any changes to support HTTP/2 as the browser and server take care of the specifics of HTTP/2, and turning it on should be a free performance boast and adoption should be relatively easy. Of course there are ways web developers can optimise for HTTP/2 to take full advantage of how it differs.

## Adoption of HTTP/2
Internet protocols are often difficult to adopt, since they are ingrained into all the various routers, switches that make up the internet. This makes introducing any changes slow and difficult. Ipv6 for example has been around for 20 years but has [struggled to be adopted](https://www.google.com/intl/en/ipv6/statistics.html). HTTP/2 however, was different as it was effectively hidden in HTTPS removing barriers to adoption as long as both the browser and server supported it. [Browser support](https://caniuse.com/#feat=http2) has been very strong for sometime and the advent of auto updating *evergreen* browsers has meant that an estimated 95% of global users support HTTP/2 now. For this Web Almanac we use HTTP Archive which runs a Chrome web crawler on the approximately 5 million top webites (on both Desktop and Mobile with a slightly different set for each). This shows that HTTP/2 usage is now the majority protocol - an impressive feat just 4 short years after formal standardisation:

<Figure 1 - 20.01 - take from here: https://httparchive.org/reports/state-of-the-web#h2 rather than from stats>

Looking at the breakdown of all HTTP versions by request we see the following:

| Protocol | Desktop | Mobile | Both   |
| -------- | ------- | ------ | ------ |
|          |  5.60%  |  0.57% |  2.97% |
| HTTP/0.9 |  0.00%  |  0.00% |  0.00% |
| HTTP/1.0 |  0.08%  |  0.05% |  0.06% |
| HTTP/1.1 | 40.36%  | 45.01% | 42.79% |
| HTTP/2   | 53.96%  | 54.37% | 54.18% |

<Figure 2 - HTTP version usage by request (20.01 pivot table in A25 - C31)>

This shows that HTTP/1.1 and HTTP/2 are the versions used by the vast majority of requests as expected. There are only a very small number on the older HTTP/1.0 and HTTP/0.9 protocols. Annoyingly there is a larger percentage where the protocol was not correctly tracked by the HTTP Archive crawl, particularly on desktop. Digging into this has shown various reasons some of which I can explain and some of what I can't, but they mostly appear to be HTTP/1.1 requests, and assuming these unclassified requests are HTTP/1.1, then desktop and mobile usage is similar. Despite being a little larger percentage of noise than I'd like, it doesn't alter the overall message being conveyed here. Other than that the mobile/desktop similarity is not unexpected - the HTTP Archive data crawls as Chrome for both which supports both. Real world usage may have slightly different stats with some older usage of browsers on both but even then support is widespread so I would not expect a large variation between desktop and mobile.

At present the HTTP Archive does not track HTTP over QUIC (soon to be standardised as HTTP/3) separately, so these are listed under HTTP/2 but we'll look at other ways of measuring that later in this chapter.

Looking at the number of requests will skew the results somewhat based on popular requests. For example, many sites load Google Analytics, which does support HTTP/2, and so would show as an HTTP/2 request even if the site itself does not support HTTP/2. On the other hand, popular websites (that tend to support HTTP/2) are also under represented in above stats as they are only measured once (e.g. google.com and obscuresite.com are given equal weighting). There are lies, damn lies and statstics. However, looking at other sources (for example the [Mozilla telemtry](https://telemetry.mozilla.org/new-pipeline/dist.html#!cumulative=0&measure=HTTP_RESPONSE_VERSION) which looks at real-world usage through the Firefox browser) shows similar statistics.

It is still interesting to look at homes pages only to get a rough figure on the number of sites that support HTTP/2 (at least on their home page). Figure 3 shows less support than overal requests, as expected, at around 36%:

| Protocol | Desktop | Mobile | Both   |
| -------- | ------- | ------ | ------ |
|          |  0.09%  |  0.08% |  0.08% |
| HTTP/1.0 |  0.09%  |  0.08% |  0.09% |
| HTTP/1.1 | 62.36%  | 63.92% | 63.22% |
| HTTP/2   | 37.46%  | 35.92% | 36.61% |

<Figure 3 - HTTP version usage for home pages (20.02 pivot table in K22 - N26)>

HTTP/2 is only supported by browsers over HTTPS, even though officially HTTP/2 can be used over HTTPS or over unencypted non-HTTPS connections. As mentioned previously, hiding the new protocol in encrypted HTTPS connections prevents networking appliances which do not understand this new protocol from interfering in (or rejecting!) it's usage. Additionally the HTTPS handshake allows and easy method of the client and server agreeing to use HTTP/2. Not every site has made the transition to HTTPS, so HTTP/2 will not even be available to them. Looking at just those sites that use HTTPS, we do see a higher percentage support HTTP/2 at around 55% - similar to all requests:

| Protocol | Desktop | Mobile | Both   |
| -------- | ------- | ------ | ------ |
|          |  0.09%  |  0.10% |  0.09% |
| HTTP/1.0 |  0.06%  |  0.06% |  0.06% |
| HTTP/1.1 | 45.81%  | 44.31% | 45.01% |
| HTTP/2   | 54.04%  | 55.53% | 54.83% |

<Figure 4 - HTTP version usage for HTTPS home pages (20.02 pivot table in K30 - N34)>

We have shown that browser support is strong, and there is a safe road to adoption, so why does every site (or at least every HTTPS site) not support HTTP/2? Well here we come to the final item we have not measured yet: server support. This is more problematic than browser support. Unlike modern browsers, servers often do not automatically upgrade to the latest version. Even when the server is regularly maintained and patched they will often just apply security patches rather than new features like HTTP/2. Let us look first at the server HTTP header for those sites that do support HTTP/2:

| Server        | Desktop | Mobile | Both   |
| ------------- | ------- | -------| ------ |
| nginx         |  34.04% | 32.48% | 33.19% |
| cloudflare    |  23.76% | 22.29% | 22.97% |
| Apache        |  17.31% | 19.11% | 18.28% |
|               |   4.56% |  5.13% |  4.87% |
| LiteSpeed     |   4.11% |  4.97% |  4.57% |
| GSE           |   2.16% |  3.73% |  3.01% |
| Microsoft-IIS |   3.09% |  2.66% |  2.86% |
| openresty     |   2.15% |  2.01% |  2.07% |
| ...etc.       |   ...   |  ...   |  ...   |

<Figure 5 - Servers used for HTTP/2 (20.08 pivot table in F2 - I14)>

Nginx provides package repos that allow easy of automatically upgrading to the more recent version so it is no surprise to see it leading the way here. Cloudflare is the [most popular CDN](../cdn/) and enables HTTP/2 by default so again it is also not surpriusing to see this as a large percentage of HTTP/2 sites. After this we see Apache at around 20% of usage, followed by some servers who choose to hide what they are and then the smaller players (Litespeed, IIS, Google Servlet Engine and openresty - which is nginx based).

What is more interesting is those site that that do *not* support HTTP/2:

| Server        | Desktop | Mobile | Both   |
| ------------- | ------- | -------| ------ |
| Apache        |  46.76% | 46.84% | 46.80% |
| nginx         |  21.12% | 21.33% | 21.24% |
| Microsoft-IIS |  11.30% |  9.60% | 10.36% |
|               |   7.96% |  7.59% |  7.75% |
| GSE           |   1.90% |  3.84% |  2.98% |
| cloudflare    |   2.44% |  2.48% |  2.46% |
| LiteSpeed     |   1.02% |  1.63% |  1.36% |
| openresty     |   1.22% |  1.36% |  1.30% |
| ...etc.       |   ...   |  ...   |  ...   |

<Figure 6 - Servers used for HTTP/1.1 or lower (20.09 pivot table in F2 - I14)>

Some of this will be non-HTTPS traffic that would use HTTP/1.1 even if the server supported HTTP/2, but a bigger issue is those that do not support HTTP/2. In these stats we see a much greater share for Apache and IIS which are likely running older versions or for sites that do not yet support HTTPS. Apache in particular is often not easy to add HTTP/2 support as Apache does not provide an official repositary to install this from. This often meeans resorting to compiling from source or trusting a third party repo - neither of which is particularly appealing to many administrators. Only the latest versions of linux distrutions (RHEL and CentOS 8, Ubuntu 18 and Debian 9) come with a version of Apache which supports HTTP/2 and many servers are not running those yet. On the Microsoft side only Windows Server 2016 and above supports HTTP/2 so again those running older versions cannot support this. Merging these two stats together we can see the percentage of installs, of each server, that uses HTTP/2: 

| Server        | Desktop | Mobile |
| ------------- | ------- | -------|
| cloudflare    |  85.40% | 83.46% |
| LiteSpeed     |  70.80% | 63.08% |
| openresty     |  51.41% | 45.24% |
| nginx         |  49.23% | 46.19% |
| GSE           |  40.54% | 35.25% |
|               |  25.57% | 27.49% |
| Apache        |  18.09% | 18.56% |
| Microsoft-IIS |  14.10% | 13.47% |
| ...etc.       |   ...   |  ...   |

<Figure 7 - percentage installs of each server used to provide HTTP/2 (20.08 pivot table in F19 - N28)>

It's clear Apache and IIS fall way behind with 18% and 14% of their installed based supporting HTTP/2, and this has to be at least in part, a consequence of it being more difficult to upgrade them to versions that support HTTP/2 with a full OS upgrade being required for many to get this support. Hopefully this will get easier as new versions of operating systems become the norm. None of this is a comment on the HTTP/2 implementations here ([I happen to think Apache has one of the best implementations](https://twitter.com/tunetheweb/status/988196156697169920?s=20)), but more in the ease of enabling HTTP/2 in each of these servers - or lack there of.

## Impact of HTTP/2
The impact of HTTP/2 is a much more difficult to measure statistic, especially using the HTTP Archive methodology. Ideally sites should be crawled with both HTTP/1.1 and HTTP/2 and the difference measured but that is not possible with the statistics we are investigating here. At the same time measuring whether the average HTTP/2 site is faster than the average HTTP/1.1 site introduces too many other variables that I do not feel this is a good measure.

One impact that can be measured is in the changing use case of HTTP now we are in a HTTP/2 world. Multiple connections were a work around with HTTP/1.1 to allow a limited parallelization, but this is in fact the opposite of what works best with HTTP/2. A single connection reduces the overhead of TCP setup, TCP slow start, HTTPS negotiation and also allows the potential of cross-request prioritization. The HTTP Archive measure the number of TCP connections per page and that is dropping steadying as more sites support HTTP/2 and use it's single connection over 6 separate connections:

<Figure 8 - TCP connections per page (https://httparchive.org/reports/state-of-the-web#tcp)>

Bundling assets into few requests was another HTTP/1.1 workaround that went by many names: bundling, concatenation, packaging, spriting...etc. It is less necessary when using HTTP/2 as there is less overhead with requests in HTTP/2 but it should be noted that requests are not free in HTTP/2 and [those that experimented with removing bundling completely have noticed a loss in performance](https://engineering.khanacademy.org/posts/js-packaging-http2.htm). Looking at the number of requests loaded by page over time, we do see a slight decrease in requests:

<Figure 9 - Total Requests per page (https://httparchive.org/reports/state-of-the-web#reqTotal)>

This is less noticable than the drop in number of connections which can be attributed to the observations that often bundling cannot be removed completely wihtout a negative performance impact, and also that many sites may not be be willing to penalise HTTP/1.1 users by undoing their HTTP/1.1 performance hacks.

Both these statistics are positive though, and against the background of an [ever increasing page weight](../pageweight/) so the fact they are decreasing rather than increasing is attributable to the impact of HTTP/2 in my opinion.

## HTTP/2 Push
HTTP/2 push has a chequered history. It was a much hyped new feature of HTTP/2. The other features were basically under the hood performance improvements, but push was a brand new concept that completely broke the single request to single response nature of HTTP/. It allowed extra responses to be returned: when you asked for the web page, the server could respond with the HTML page as usual, but then also send you the critical CSS and JavaScript thus avoiding any additional round trips for certain resources. It would in theory allow us to stop inlining CSS and JavaScript into our HTML and still get a similar performance boast of doing it. After solving that, it could potentially lead to all sorts of new use cases.

The reality has been... well a bit dissapointing. HTTP/2 push has proved much harder than originally envisaged to use effectively. Some of this has been due to [the complexity of how HTTP/2 push works](https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/), and the implementation issues due to that. A bigger concern is that push can quite easily cause, rather than solve, performance issues. Over pushing is a real problem. Often the browser is in the best place to decide *what* to request, and just as crucially *when* to request it. Pushing resources that a browser already has in it's cache, is a waste of bandwidth (though in my opinion so is inlining CSS but that gets must less of a hard time about that than HTTP/2 push!). [Proposals to inform the server about the status of the browser cache have stalled](https://lists.w3.org/Archives/Public/ietf-http-wg/2019JanMar/0033.html) especially on privacy concerns. Even without that there are other issues - for example pushing large images and therefore holding up the sending of critical CSS and JavaScript will lead to slower websites than if you'd not pushed at all!

There has also been very little evidence to state that push, even when implemented correctly, results in the performance boast it promised. This is an area that the HTTP Archive is not best placed to answer, due to the nature of how it runs (a month crawl of popular sites using Chrome in one state) so we won't delve into it too much here, but suffice to say that the performance gains are far from clear cut and the potential problems are real.

Putting that aside let's look at the usage of HTTP/2 push:

| Client  | Sites Using HTTP/2 Push | Sites Using HTTP/2 Push (%) |
| ------- | ----------------------- | --------------------------- |
| Desktop |  22,581                 | 0.52%                       |
| Mobile  |  31,452                 | 0.59%                       |

<Figure 10 - Sites using HTTP/2 push (20.10)>

It's clear that uptick of HTTP/2 push is very low - most likely because of the issues described previously. However when sites do use push, then tend to use it a lot rather than for one or two assets as shown in Figure 11:

| Client  | Avg Pushed Requests | Avg Kb Pushed |
| ------- | ------------------- | ------------- |
| Desktop |  7.86               | 162.38        |
| Mobile  |  6.35               | 122.78        |

<Figure 11 - How much is pushed when it is used (20.11)>

This is a concern as previous advice has been to be conservative with push and to ["push just enough resources to fill idle network time, and no more"](https://docs.google.com/document/d/1K0NykTXBbbbTlv60t5MyJvXjqKGsCVNYHyLEXIxYMv0/edit). Looking at what is pushed

<Figure 12 - What asset types is pushed used for? (20.12)>

JavaScript and then CSS are the overwhelming majority of pushed items, both by volume and by bytes followed by Imges and then JavaScript. After this there is a rag tag assortment of images, fonts, data...etc. At the tail end we see around 100 sites pushing video - which I would say is definitely not the intented use case of HTTP/2 push, and even one site that decides to push 1.5Mb of PDFs.

One concern raised by some, is when HTTP/2 implementations have repurposed the `preload` HTTP header as a signal to push. One of the most popular uses of the `preload` [resource hint](../resourcehints/) is to inform the browser of late-discovered resources like fonts and images, that the browser will not see until the CSS for example has been requested, downloaded and parsed. If these are now pushed based on that there was a concern that reusing this may result in a lot of unintended push. However the relative low useage of fonts and images may mean that risk is not being seen as much as was feared. Preload meta tags are used in the HTML rather than HTTP headers and the meta tags are not a signal to push. There still are a number of fonts and other assets being pushed, which may be a signal of this. However, on the other hand if an asset is important enough to preload, and the fact that browsers treat a preload hint as a very high priority requests, means arguably these assets should be pushed if possible. Any performance concern is therefore (again arguably) at the over use of preload, rather than the resulting HTTP/2 push that happens because of this.

To get around this unintended push, you can provide the `nopush` attribute in your `preload` header:

    link: </assets/jquery.js>; rel=preload; as=script; nopush

It looks like 5% of preload HTTP headers do make use of this attribute, which is higher than I would have expected as would have considered this a niche optimisation. Then again, so is the use of preload HTTP headers and/or HTTP/2 push itself!


## Issues
HTTP/2 is mostly a seamless upgrade that, once your server supports, you can switch on with no need to change your website or application. There are a couple of gotchas to be aware of however that can impact any upgrade and some sites have found these out the hard way.

HTTP/2 servers can respond with requests with an `upgrade` HTTP header suggesting that it supports a better protocol that the client might wish to use. You might think this would be useful as a way of informing the browser it supports HTTP/2 but since browsers only support HTTP/2 over HTTPS and since use of HTTP/2 can be negotiated through the HTTPS handshake, the use of this `upgrade` header is pretty limited (to browsers at least). Worse that that, is when a server sends an upgrade header in error. This could be because an HTTP/2 supporting backend server is sending the header and then a HTTP/1.1-only edge server is blinding forwarding this. Apache is emits the `upgrade` header when mod_http2 is enabled but HTTP/2 is not, and an nginx instance sitting in front of such and Apache happily forwards this header even when nginx does not support HTTP/2. This false advertising then leads to clients trying and failing to use use HTTP/2 as they are advertised. 108 site use HTTP/2 and yet suggest upgrading to HTTP/2 in this `upgrade` header. A further 102,875 sites on desktop (152,762 on mobile) suggest upgrading a HTTP/1.1 site to HTTP/2 when it's clear this was not available or it would have been used. These are a small minority of the 4.3 million sites crawled on desktp and 5.3 million sites crawled on mobile for these stats but show that this was still an issue affecting 2.35% - 2.88% of sites out there. And this is before we get into sites recommending upgrading to `http1.0`, `http://1.1` or even `-all,+TLSv1.3,+TLSv1.2` (clearly some typos in web server config goign on here!).

Another cause of issues in HTTP/2 is the poor support of HTTP/2 prioritisation. This allows multiple requests in progress to make the appropriate use of the connection. This is especially important since HTTP/2 has removed (or at least massively increased) the number of requests that be running on the same connection. 100 or 128 parallel requests are common. Previously the browser had a max of 6 connections per domain and so used it's skill and judgement to decide how best to use those connections. Now it rarely needs to queue and can send all requests as soon as it knows about them. This then can lead to the badnwidth being "wasted" on lower priority requests while critical requests (and indicently [can also lead to swamping your backend server with more requests than it is used to!](https://www.lucidchart.com/techblog/2019/04/10/why-turning-on-http2-was-a-mistake/)). HTTP/2 has a complex prioritisation model (too complex many say - hence why it is being reconsidered for HTTP/3!) but few servers honor that properly. This can because they their HTTP/2 implementations are not up to scracth or because of so called *bufferbloat* where the responses are already en route before the server realises there is a higher priority request. Due to the varying nature of servers, TCP stacks and locations it is difficult to measure this for most sites, but with CDNs this should be more consistent. [Patrick Meenan](https://twitter.com/patmeenan) created [an example test page](https://github.com/pmeenan/http2priorities/tree/master/stand-alone) which deliberately tries to download a load of low-priority, off-screen, images, before requesting some high priority on-screen images. A good HTTP/2 server should be able to recognise this and send the high priority images shortly after requested, at the expense of the lower priority images. A poor HTTP/2 server will just respond in the order asked. [Andy Davies](https://twitter.com/AndyDavies) has a page tracking status of various CDNs for Pat's test. The HTTP Archive identifies when a CDN is used as part of it's crawl and using that gives us the results shown in Figure 13:

| CDN               | Prioritizes Correctly? | Desktop | Mobile | Both   |
| ----------------- | -----------------------| ------- | ------ | ------ |
| Not using CDN     | Unknown                | 57.81%  | 60.41% | 59.21% |
| Cloudflare        | Pass                   | 23.15%  | 21.77% | 22.40% |
| Google            | Fail                   |  6.67%  |  7.11% |  6.90% |
| Amazon CloudFront | Fail                   |  2.83%  |  2.38% |  2.59% |
| Fastly            | Pass                   |  2.40%  |  1.77% |  2.06% |
| Akamai            | Pass                   |  1.79%  |  1.50% |  1.64% |
|                   | Unknown                |  1.32%  |  1.58% |  1.46% |
| WordPress         | Pass                   |  1.12%  |  0.99% |  1.05% |
| Sucuri Firewall   | Fail                   |  0.88%  |  0.75% |  0.81% |
| Incapsula         | Fail                   |  0.39%  |  0.34% |  0.36% |
| Netlify           | Fail                   |  0.23%  |  0.15% |  0.19% |
| OVH CDN           | Unknown                |  0.19%  |  0.18% |  0.18% |

<Figure 13 - HTTP/2 priortization support in common CDNs>

This shows that a not insignificant portion of traffic is subject to the issue identified. How much of a problem this is, depends on exactly how your page loads and whether high priority resources are discovered late, but it does show another complexity to take into considerations.

There are further implementation issues we could look at. For example HTTP/2 is much more strict about HTTP header names, rejecting the whole request if you respond with spaces, colons or other invalid HTTP header names. The header names are also converted to lowercase which catches some by surprise if their application assumes a certain capitalisation (which was never guaranteed previously as [HTTP/1.1 specifically states the header names are case insensitive](https://tools.ietf.org/html/rfc7230#section-3.2), but still some have depended on this). The HTTP Archive could potentially be used to identify these issues as well, though some of them will not be apparent on the home page so we did not delve into them this year.

## HTTP/3
The world does not stand still and despite HTTP/2 not having even reached it's official 5th birthday, people are already seeing it as old news and getting more excited about it's successor: HTTP/3. HTTP/3 builds on the concepts of HTTP/2 but moves it from working over TCP connections that HTTP has always used to a UDP-based protocol called QUIC. This allows us to fix one edge case where HTTP/2 is slower then HTTP/1.1 (when there is high packet loss) and also allows us to address some TCP and HTTPS inefficiencies such as consolidating on one handshake for both, and supporting many ideas for TCP that have proven hard to implement in real life (TCP fast open, 0-RTT...etc.). HTTP/3 also cleans up some overlap between TPC and HTTP/2 (e.g. Flow Control being implemented in both layers) but conceptually is very similar to HTTP/2. Web developers who understand and have optimised for HTTP/2 should have to make no further changes for HTTP/3. The difference between TCP and QUIC however are much more ground breaking. They will make implementation harder so the roll out of HTTP/3 may take considerably longer than HTTP/2 and initially be limited to those with certain expertise in the field (e.g. CDNs).

QUIC has been implemented by Google for a number of years and it is now undergoing a similar standardisation process that SDPY did on it's way to HTTP/2. At the end of 2018 it was decided to name the HTTP part of QUIC HTTP/3 (in Google/s version of QUIC is was simply known as HTTP/2 even though it was not exactly the same as regular HTTP/2). Just as this chapter was being written, [Cloudflare, Chrome and Firefox all announced HTTP/3 support](https://blog.cloudflare.com/http3-the-past-present-and-future/) despite the fact that HTTP/3 is still not formally complete and approved as a standard yet.

Because HTTP/3 uses QUIC over UDP rather than TCP it makes the discover of HTTP/3 support for a challenge than HTTP/2. With HTTP/2 we can mostly use the HTTPS handshake, but as HTTP/3 is on a completely different connection that is not an option here. HTTP/2 did also use the `upgrade` HTTP header to inform of HTTP/2 support, and although that was not that useful for HTTP/3 a similar mechanism has been put in place for QUIC that is more useful. The Alternative Services HTTP header (`alt-svc`) advertises alternative prococols that can be used on completely different connections (as opposed to alternative protocols that can be used on this connection - which is what the `upgrade` HTTP header is used for). Analysis of this header shows that 7.13% of desktop sites and 7.58% of mobile sites already support QUIC (which roughly represents Google percen tage of traffic unsurprisingly enough), and 0.04% are already supporting `h3` (meaning HTTP/3) in this field. I would imagine by next years Almanac this number will have increased significantly.

## Conclusion
This analysis of the available statistics in HTTP Archive has shown what many of us in the HTTP/2 community were already aware of: HTTP/2 is here and proving very popular. It is already the dominant protocol in terms of number of request but has not quite over taken HTTP/1.1 in terms of number of sites supported. The long tail of the internet means that it often takes an exponentially longer time to make percentage point gains on the less well maintained sites than on the high profile, high volume sites.

We've also talked about how it is (still!) not easy to get HTTP/2 support in some installations and server developers, operating system distributors and end customers all have a part to play in making that easier. Trying software to operating systems always lengthens deployment time - and in fact one of the very reasons for QUIC is to break this barrier with deploying TCP changes. In manny instances there is no reason to tie server versions to operating systems. Apache and Nginx (to use two of the more popular examples) will run with HTTP/2 support in older operating systems but getting them on to the server should not require the expertise or risk it does. Nginx does very well here hosting repositories for the common linux flavors to make installation easier and if Apache (or the O/S vendors) doesn't offer something similar then I can only see it's usage continuing to shrink as it struggles to hold relevance.

Other than that, HTTP/2 has been a relatively easy upgrade path - which is why it has the uptake it has already seen. For the most part, it is a painless switch on and therefore a free performance increase that requires little thought once your server supports it. The devil is in the details though (as always), and small differences between server implementations can result in better HTTP/2 usage and ultimately end user experience. There have also been a number of bugs and [security issues](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-002.md), as is to be expected with any new protocol. Ensuring you are using a strong implementation of any newish protocol like HTTP/2 will ensure you stay on top of these issues. However that can take expertise and managing. The roll out of QUIC and HTTP/3 will likely be even more complicated and require more expertise. Perhaps this is best left to third party service providers like CDNs who have this expertise and can give your site easy access to these features? This is not a sure thing (as the prioritization statistics show), but if you choose your provider wisely and engage with them on what your priorities are, then it should be an easier implementation. And on that note it would be great if the CDNs prioritized the issue hiughlighted above (pun definitely intended!), though I suspect with the advent of a new prioritization method in HTTP/3 many will hold tight.
