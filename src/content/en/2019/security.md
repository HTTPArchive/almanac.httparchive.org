---
part_number: II
chapter_number: 8
title: Security
description: State of Security 2019
hero_image: ''
authors: [scotthelme]
reviewers: [paulcalvano, bazzadp, ghedo, ndrnmnn]
translaters: []
---

# Chapter 8: Security

## Intro
The Security chapter of the Web Almanac looks at the progress made in securing the web. With security and privacy becoming increasingly more important online there has been an increase in the availability of features to protect site operators and users. We're going to look at the adoption of these new features across the Web.

## TLS
Perhaps the largest push to increasing security and privacy online we're seeing at present is the widespread adoption of Transport Layer Security. TLS is the protocol that gives us the 'S' in HTTPS and allows secure and private browsing of websites. Not only are we seeing a great increase in the use of HTTPS across the Web, but also an increase in more modern versions of TLS like TLSv1.2 and TLSv1.3, which is also important.  

### Protocol Versions
Looking at the support for various protocol versions we can see that the use of legacy TLS versions like TLSv1.0 and TLSv1.1 is minimal and almost all support is for the newer TLSv1.2 and TLSv1.3 versions of the protocol. Not only that but even though TLSv1.3 is still very young as a standard, over 40% of requests using TLS are using the latest version!

<br/>

| client  | tls_version | requests | total    | pct   |
|---------|-------------|----------|----------|-------|
| mobile  | TLS 1.2     | 51909891 | 90232813 | 57.53 |
| desktop | TLS 1.2     | 46414404 | 79586221 | 58.32 |
| mobile  | TLS 1.3     | 37689500 | 90232813 | 41.77 |
| desktop | TLS 1.3     | 32547410 | 79586221 | 40.9  |
| mobile  | TLS 1.0     | 623695   | 90232813 | 0.69  |
| desktop | TLS 1.0     | 616926   | 79586221 | 0.78  |
| mobile  | TLS 1.1     | 9727     | 90232813 | 0.01  |
| desktop | TLS 1.1     | 7481     | 79586221 | 0.01  |

### Certificate Authorities 
Of course, if we want to use HTTPS on our website then we need a certificate from a Certificate Authority. With the increase in the use of HTTPS comes the increase in use of CAs and their products/services. Here are the top 10 certificate issuers based on the volume of TLS requests that use their certificate.

<br/>

| client  | issuer                                 | requests | total    | pct   |
|---------|----------------------------------------|----------|----------|-------|
| mobile  | Google Internet Authority G3           | 15177834 | 77109521 | 19.68 |
| desktop | Google Internet Authority G3           | 10760946 | 55866534 | 19.26 |
| desktop | Let's Encrypt Authority X3             | 5698524  | 55866534 | 10.2  |
| desktop | DigiCert SHA2 High Assurance Server CA | 5491199  | 55866534 | 9.83  |
| mobile  | DigiCert SHA2 High Assurance Server CA | 7141087  | 77109521 | 9.26  |
| mobile  | Let's Encrypt Authority X3             | 7085319  | 77109521 | 9.19  |
| mobile  | DigiCert SHA2 Secure Server CA         | 6727708  | 77109521 | 8.72  |
| mobile  | GTS CA 1O1                             | 6497589  | 77109521 | 8.43  |
| desktop | GTS CA 1O1                             | 4395585  | 55866534 | 7.87  |
| desktop | DigiCert SHA2 Secure Server CA         | 4217289  | 55866534 | 7.55  |

<br/>

The rise of Let's Encrypt has been meteoric after their launch in early 2016, since then they've become one of the top certificate issuers in the world. The availability of free certificates and automated tooling has been critically important to the adoption of HTTPS on the Web and Let's Encrypt certainly had a significant part to play in both of those.

### Authentication key type
Alongside the important requirement to use HTTPS is the requirement to also use a good configuration. With so many configuration options and choices to make, this is a careful balance. Looking first of all at the keys used for authentication purposes, we still see a large % of the Web using RSA.

<br/>

| client  | is_ecdsa | is_rsa   | total    | pct_ecdsa | pct_rsa |
|---------|----------|----------|----------|-----------|---------|
| mobile  | 23832006 | 53056268 | 90232714 | 26.41     | 58.8    |
| desktop | 17090634 | 38734846 | 79586141 | 21.47     | 48.67   |

<br/>

Whilst ECDSA keys are stronger, which allows the use of smaller keys, and demonstrate better performance than their RSA counterparts, concerns around backwards compatibility do prevent some website operators from migrating. 

### Forward Secrecy
The importance of Forward Secrecy, a property of some key exchange algorithms that prevents each connection to a server from being exposed in case of a compromise of the server certificate's private key, is now well understood. It was introduced as an optional configuration in 2008 with TLSv1.2 and has become mandatory in 2018 with TLSv1.3 requiring it.

<br/>

| client  | forward_secrecy_count | total    | pct   |
|---------|-----------------------|----------|-------|
| desktop | 54148540              | 55866534 | 96.92 |
| mobile  | 74405592              | 77109521 | 96.49 |

<br/>

Looking at the % of TLS requests that provide Forward Secrecy, we can see that support is tremendous. We'd expect that the continuing increase in the adoption of TLSv1.3 will further increase these numbers.

### Cipher Suites
With the simplification of the available cipher suites in TLSv1.3, and the drive to use better cipher suites created by sites like [SSL Labs](https://www.ssllabs.com/), we can see that the majority of cipher suites negotiated for TLS requests were indeed excellent.

<br/>

| client  | cipher            | cipher_count | total    | pct   |
|---------|-------------------|--------------|----------|-------|
| mobile  | AES_128_GCM       | 59148056     | 77109521 | 76.71 |
| desktop | AES_128_GCM       | 42385458     | 55866534 | 75.87 |
| mobile  | AES_256_GCM       | 14258912     | 77109521 | 18.49 |
| desktop | AES_256_GCM       | 11022581     | 55866534 | 19.73 |
| mobile  | AES_256_CBC       | 1741346      | 77109521 | 2.26  |
| mobile  | AES_128_CBC       | 1324594      | 77109521 | 1.72  |
| desktop | AES_256_CBC       | 1238047      | 55866534 | 2.22  |
| desktop | AES_128_CBC       | 801139       | 55866534 | 1.43  |
| mobile  | CHACHA20_POLY1305 | 608567       | 77109521 | 0.79  |
| desktop | CHACHA20_POLY1305 | 386219       | 55866534 | 0.69  |
| desktop | 3DES_EDE_CBC      | 33090        | 55866534 | 0.06  |
| mobile  | 3DES_EDE_CBC      | 28046        | 77109521 | 0.04  |

## Mixed Content
Most sites on the Web originally existed as HTTP websites and have had to migrate their site to HTTPS. This 'lift and shift' operation can be difficult and sometimes things get missed or left behind. This results in sites having Mixed Content, where their pages load over HTTPS but something on the page, perhaps an image or a style, is loaded over HTTP. Mixed Content is bad for security and privacy, and can be difficult to find and fix.

<br/>

| client  | mixed_content_sites | active_mixed_content_sites | total   | pct_mixed | pct_active_mixed |
|---------|---------------------|----------------------------|---------|-----------|------------------|
| desktop | 476965              | 117107                     | 2931828 | 16.27     | 3.99             |
| mobile  | 508724              | 136761                     | 3309605 | 15.37     | 4.13             |

<br/>

We can see that almost 20% of sites across mobile and desktop present some form of mixed content. Whilst passive mixed content, something like an image, is less dangerous, we can still see that almost a quarter of sites with mixed content have active mixed content. Active mixed content, like javascript, is more dangerous as an attacker can insert their own hostile code into a page easily.

## Security Headers
Many new and recent features for site operators to better protect their users have come in the form of new HTTP response headers that can configure and control security protections built into the browser. Some of these features are easy to enable and provide a huge level of protection whilst others require a little more work from site operators.

### HTTP Strict Transport Security
The HSTS header allows a website to instruct a User Agent that it should only ever communicate with the site over a secure HTTPS connection. Given that over 40% of requests were capable of using TLS, we see a much lower % of requests instructing the UA to require it.

<br/>

| client  | directive         | freq   | total   | pct   |
|---------|-------------------|--------|---------|-------|
| desktop | max-age           | 647149 | 4371973 | 14.8  |
| mobile  | max-age           | 678566 | 5297442 | 12.81 |
| desktop | includeSubDomains | 168909 | 4371973 | 3.86  |
| mobile  | includeSubDomains | 174295 | 5297442 | 3.29  |
| desktop | preload           | 99335  | 4371973 | 2.27  |
| mobile  | preload           | 105648 | 5297442 | 1.99  |

<br/>

Less than 15% of mobile and desktop page are issuing a HSTS with the minimum requirement of a max-age directive. Fewer still are including subdomains in their policy with the includeSubDomains directive and even fewer still are HSTS preloading. Looking at the median value for a HSTS max-age we can see that on both desktop and mobile it is 15768000, a strong configuration.

<br/>

| percentile | client  | max_age  |
|------------|---------|----------|
| 10         | desktop | 300      |
| 10         | mobile  | 300      |
| 25         | desktop | 7889238  |
| 25         | mobile  | 7889238  |
| 50         | desktop | 15768000 |
| 50         | mobile  | 15768000 |
| 75         | desktop | 31536000 |
| 75         | mobile  | 31536000 |
| 90         | desktop | 63072000 |
| 90         | mobile  | 63072000 |

#### HSTS Preloading
With the HSTS policy delivered via a HTTP Response Header, when visiting a site for the first time a UA will not know whether a policy is configured. To avoid this Trust On First Use problem, a site operator can have the policy prelaoded into the UA.

<br/>

| client  | freq  | total   | pct  |
|---------|-------|---------|------|
| desktop | 13345 | 4371973 | 0.31 |
| mobile  | 13707 | 5297442 | 0.26 |

<br/>

The requirements to do so are outlined on the [HSTS Preload](https://hstspreload.org/) site but we can see that only a small number of sites are eligible according to current criteria.

### Content Security Policy
Web applications face frequent attacks where hostile content finds its way into a page. The most worrisome form of content is JavaScript and when an attacker finds a way to insert JavaScript into a page, they can launch damaging attacks. These attacks are known as Cross-Site Scripting (XSS) and CSP provides an effective defence against these attacks. Alongside XSS protection, CSP also offers several other key benefits.

Despite the many benefits of CSP we find that only 5.51% of desktop pages include a CSP and only 4.73% of mobile pages include a CSP.

#### Hash/Nonce
A common approach to CSP is to create a whitelist of 3rd party domains that are permitted to load content, such as JavaScript, into your pages. Creating and managing these whitelists can be difficult so Hashes and Nonces were introduced as an alternative approach. Of the sites surveyed only 0.09% of desktop pages use a Nonce source and only 0.02% of desktop pages use a Hash source. The number of mobile pages use a Nonce source is interestingly higher at 0.13% but the use of Hash sources is lower on mobile pages at 0.01%.

#### strict-dynamic
The introduction of Strict-Dynamic further reduced the burden on site operators for using CSP by allowing a whitelisted script to load further script dependencies. Despite the introduction of this feature, only 0.03% of desktop pages and 0.1% of mobile pages include it in their policy.  

#### trusted-types
XSS attacks come in various forms and Trusted-Types was created to help specifically with DOM-XSS. Despite being an effective mechanism, our data shows that only 2 mobile and desktop pages use the Trusted-Types directive.

#### Unsafe inline/eval
When a CSP is deployed on a page, certain unsafe features like inline script or the use of `eval()` are disabled. A page can depend on these features and in place of enabling them in a safe fashion, perhaps with a Nonce or Hash source, site operators can enable these unsafe features with Unsafe-Inline or Unsafe-Eval in their CSP. Of the 5.51% of desktop pages that include a CSP, 33.94% of them include Unsafe-Inline and 31.03% of them include Unsafe Eval. On mobile pages we find that of the 4.73% that contain a CSP, 34.04% use Unsafe-Inline and 31.71% use Unsafe-Eval.

#### upgrade-insecure-requests
A common problem that site operators face in their migration from HTTP to HTTPS is that some content can still be accidentally loaded over HTTP on their HTTPS page. This problem is known as Mixed Content and CSP provides an effective way to solve this problem. The Upgrade-Insecure-Requests directive instructs a UA to load all subresources on a page over a secure connection, automatically upgrading HTTP requests to HTTPS requests as an example.

Of the HTTPS pages surveyed on the desktop, 16.27% of them loaded mixed-content with 3.99% of pages loading active mixed-content like JS/CSS/fonts. On mobile pages we see 15.37% of HTTPS pages loading mixed-content with 4.13% loading active mixed-content. By loading active content such as JavaSript over HTTP an attacker can easily inject hostile code into the page to launch an attack. This is what the UIR directive in CSP protects against.

The UIR directive is found in the CSP of 3.24% of desktop pages and 2.84% of mobile pages, indicating that an increase in adoption would provide substantial benefits.

#### frame-ancestors
Another common attack known as ClickJacking is conducted by an attacker who will place a target website inside an iframe on a hostile webiste. Whilst the X-Frame-Options header (discussed below) originally set out to control framing, it wasn't flexible and Frame-Ancestors in CSP stepped in to provide a more flexible solution. Site operators can now specify a list of hosts that are permited to frame them and any other hosts attempting to frame them will be prevented.

Of the pages surveyed, 2.85% of desktop pages include the Frame-Ancestors directive in CSP with 0.74% of desktop pages setting Frame-Ancestors to `'none'`, preventing any framing, and 0.47% of pages setting Frame-Ancestors to `'self'`, allowing only their own site to frame itself. On mobile we see 2.52% of pages using Frame-Ancestors with 0.71% setting the value of `'none'` and 0.41% setting the value to `'self'`.

### Referrer Policy
The Referrer Policy header allows a site to control what information will be sent in the Referer header when a user navigates away from the current page. By controlling what information is sent in the Referer header, ideally limiting it, a site can protect the privacy of their visitors by reducing the information sent to 3rd parties.

A total of 3.25% of desktop pages and 2.95% of mobile pages issue a Referrer Policy header and below we can see the configurations those pages used.

<br/>

| client  | policy                          | freq  | total  | pct   |
|---------|---------------------------------|-------|--------|-------|
| mobile  | no-referrer-when-downgrade      | 41597 | 100183 | 41.52 |
| desktop | no-referrer-when-downgrade      | 37021 | 94543  | 39.16 |
| desktop | strict-origin-when-cross-origin | 22178 | 94543  | 23.46 |
| mobile  | strict-origin-when-cross-origin | 22209 | 100183 | 22.17 |
| mobile  | unsafe-url                      | 9704  | 100183 | 9.69  |
| desktop | unsafe-url                      | 8293  | 94543  | 8.77  |
| desktop | same-origin                     | 7531  | 94543  | 7.97  |
| mobile  | same-origin                     | 7221  | 100183 | 7.21  |
| desktop | origin-when-cross-origin        | 6395  | 94543  | 6.76  |
| mobile  | origin-when-cross-origin        | 6447  | 100183 | 6.44  |
| desktop | no-referrer                     | 5343  | 94543  | 5.65  |
| mobile  | no-referrer                     | 5390  | 100183 | 5.38  |
| desktop | strict-origin                   | 4115  | 94543  | 4.35  |
| mobile  | strict-origin                   | 4149  | 100183 | 4.14  |
| desktop | origin                          | 3430  | 94543  | 3.63  |
| mobile  | origin                          | 3233  | 100183 | 3.23  |

<br/>

This table shows the valid values set by pages and that 99.75% of desktop pages and 96.55% of mobile pages are setting a valid policy. The most popular choice of configuration is `no-referrer-when-downgrade` which will prevent the Referer header being sent when a user navigates from a HTTPS page to a HTTP page. The second most popular choice is `strict-origin-when-cross-origin` which prevents any information being sent on a scheme downgrade (HTTPS to HTTP navigation) and when information is sent in the Referer it will only contain the origin of the soruce and not the full URL. Details on the other valid configurations can be found in the [Referrer Policy specification](https://www.w3.org/TR/referrer-policy/#referrer-policies). 

### Feature Policy
As the web platform becomes more powerful and feature rich, attackers can these new APIs in interesting ways. In order to limit abuse of powerful APIs, a site operator can issue a Feature Policy header to disable features that are not required, preventing them from being abused.

Here are the 5 most popular features that are controlled with a Feature Policy.

<br/>

| client  | feature     | freq | total | pct   |
|---------|-------------|------|-------|-------|
| mobile  | microphone  | 5865 | 53397 | 10.98 |
| desktop | microphone  | 5651 | 52427 | 10.78 |
| mobile  | camera      | 5443 | 53397 | 10.19 |
| desktop | camera      | 5215 | 52427 | 9.95  |
| desktop | payment     | 5004 | 52427 | 9.54  |
| mobile  | payment     | 5092 | 53397 | 9.54  |
| mobile  | geolocation | 5026 | 53397 | 9.41  |
| desktop | geolocation | 4919 | 52427 | 9.38  |
| desktop | gyroscope   | 4154 | 52427 | 7.92  |
| mobile  | gyroscope   | 4219 | 53397 | 7.9   |

<br/>

We can see that the most popular feature to take control of is the microphone, with almost 11% of desktop and mobile pages issuing a policy that includes it. Delving deeper into the data we can look at what those pages are allowing or blocking.

<br/>

| feature    | rule | freq | total | pct  |
|------------|------|------|-------|------|
| microphone | none | 4854 | 53397 | 9.09 |
| microphone | none | 4701 | 52427 | 8.97 |
| microphone | self | 451  | 52427 | 0.86 |
| microphone | self | 453  | 53397 | 0.85 |
| microphone | *    | 343  | 53397 | 0.64 |
| microphone | *    | 280  | 52427 | 0.53 |

<br/>

By far the most common approach here is to block use of the microphone altogether, with ~9% of pages taking that approach. A small number of pages do allow the use of the microphone by their own origin and interestingly, a small selection of pages intentionally allow use of the microphone by any origin loading content in their page. 

### X-Frame-Options
The X-Frame-Options header allows a page to control whether or not it can be placed in an iframe by another page. Whilst lacking the flexibility of `frame-ancestors` in CSP, mentioned above, it was effective if you didn't require fine grained control of framing.

<br/>

| client  | header          | freq   | total   | pct   |
|---------|-----------------|--------|---------|-------|
| desktop | x-frame-options | 743015 | 4371973 | 16.99 |
| mobile  | x-frame-options | 782589 | 5297442 | 14.77 |

<br/>

We see that the usage of the XFO header is quite high on both desktop and mobile and can also look more closely at the specific configurations used.

<br/>

| client  | policy     | freq   | total  | pct   |
|---------|------------|--------|--------|-------|
| desktop | sameorigin | 644678 | 759134 | 84.92 |
| mobile  | sameorigin | 668206 | 796822 | 83.86 |
| mobile  | deny       | 115554 | 796822 | 14.5  |
| desktop | deny       | 102822 | 759134 | 13.54 |
| mobile  | allow-from | 13062  | 796822 | 1.64  |
| desktop | allow-from | 11634  | 759134 | 1.53  |

<br/>

It seems that the vast majority of pages restrict framing to only their own origin and the next significant approach is to prevent framing altogether. This is similar to `frame-ancestors` in CSP where these 2 approaches are also the most common.

### X-Content-Type-Options
The XCTO header is the most widely deployed Security Header and is also the simplest, with only one possible configuration value `nosniff`.

<br/>

| client  | header                 | freq   | total   | pct   |
|---------|------------------------|--------|---------|-------|
| desktop | x-content-type-options | 769961 | 4371973 | 17.61 |
| mobile  | x-content-type-options | 932768 | 5297442 | 17.61 |

<br/>

Interestingly, we find that an identical % of pages on both mobile and desktop issue the XCTO header which prevents a UA from MIME sniffing. When this header is issued a UA must treat a piece of content as the MIME Type declared in the `Content-Type` header and not try to change the advertised value.

### X-Xss-Protection
The XXP header allows a site to control the XSS Auditor or XSS Filter built into a UA but is no largely useless. Edge retired their XSS Filter, Chrome deprecated their XSS Auditor and Firefox never implemented support for the feature, yet we still see widespread use of the header.

<br/>

| client  | header           | freq   | total   | pct   |
|---------|------------------|--------|---------|-------|
| desktop | x-xss-protection | 642455 | 4371973 | 14.69 |
| mobile  | x-xss-protection | 805450 | 5297442 | 15.2  |

<br/>

Digging into the data we can see what the intention for most site operators was.

<br/>

| client  | policy       | freq   | total  | pct   |
|---------|--------------|--------|--------|-------|
| desktop | 1;mode=block | 595214 | 648617 | 91.77 |
| mobile  | 1;mode=block | 743081 | 812496 | 91.46 |
| desktop | 1            | 35922  | 648617 | 5.54  |
| mobile  | 1            | 43441  | 812496 | 5.35  |
| mobile  | 0            | 25235  | 812496 | 3.11  |
| desktop | 0            | 16715  | 648617 | 2.58  |
| desktop | 1;report=    | 766    | 648617 | 0.12  |
| mobile  | 1;report=    | 739    | 812496 | 0.09  |

<br/>

The value `1` enables the filter/auditor and `mode=block` sets the protection to the strongest setting where any suspected XSS attack would cause the page to not be rendered. The second most common configuration was to simply ensure the auditor/filter was turned on, by presenting a value of `1` and then the 3rd most popular configuration is quite interesting.

Setting a value of `0` in the header instructs the UA to disable any XSS auditor/filter that it may have. Some historic attacks demonstrated how the auditor or filter could be tricked into assisting an attacker rather than protecting the user so some site operators could disable it if they were confident they have adequate protection against XSS in place.

### Report-To
The Reporting API was introduced to allow site operators to gather various pieces of telemetry from the UA. Many errors or problems on a site can result in a poor experience for the user yet a site operator can only find out if the user contacts them. The Reporting API provides a mechanism for a UA to automatically report these problems without any user interaction or interruption. The Reporting API is configured by delivering the Report-To header.

<br/>

| client  | header    | freq  | total   | pct  |
|---------|-----------|-------|---------|------|
| desktop | report-to | 74179 | 4371973 | 1.7  |
| mobile  | report-to | 83036 | 5297442 | 1.57 |

<br/>

By specifying the header, which contains a location where the telemetry should be sent, a UA will automatically begin sending the data. Given the ease of deployment and configuration, we can see that only a small fraction of desktop and mobile sites currently enable this feature. To see the kind of telemetry you can collect, refer to the [Reporting API specification](https://www.w3.org/TR/reporting/).

### Network Error Logging
Network Error Logging provides detailed information about various failures in the UA that can result in a site being inoperative. By issuing the NEL header to the UA, the UA will report these failures via the Reporting API mentioned above.

<br/>

| client  | header | freq  | total   | pct  |
|---------|--------|-------|---------|------|
| desktop | nel    | 74478 | 4371973 | 1.7  |
| mobile  | nel    | 82981 | 5297442 | 1.57 |

<br/>

Of course, with NEL depending on the Reporting API, we can't see the usage of NEL exceed that of the Reporting API so we see similarly low numbers here too. NEL provides incredibly valuable information and you can read more about those in the [Network Error Logging specification](https://w3c.github.io/network-error-logging/#predefined-network-error-types).  

### Clear Site Data
With the increasing ability to store data locally on a user's device, via cookies, caches and local storage to name but a few, site operators needed a reliable way to manage this data. The Clear Site Data header provides a reliable means to ensure that all data of a particular type is removed from the device.

<br/>

| client  | freq | total   | pct |
|---------|------|---------|-----|
| mobile  | 7    | 5447942 | 0   |
| desktop | 9    | 4474762 | 0   |

<br/>

Given the nature of the header, it's unsurprising to see almost no usage reported. With our data only looking at the homepage of a site, we're unlikely to see the most common use of the header which would be on a logout endpoint. Upon logging out of a site, the site operator would return the Clear Site Data header and the UA would remove all data of the indicated types. This is unlikely to take place on the homepage of a site.  

## Cookies
Cookies have many security protections available and whilst some of those are long standing, having been available for years, some of them are really quite new have been introduced only in the last couple of years.

### Secure
The `Secure` flag on a cookie instructs a UA to only send the cookie over a secure (HTTPS) connection and we find a small % of sites issuing a cookie with the Secure flag set on their homepage.

<br/>

| client  | pages  | total   | pct  |
|---------|--------|---------|------|
| desktop | 184481 | 4371973 | 4.22 |
| mobile  | 195031 | 5297442 | 3.68 |

<br/>

### HttpOnly
The `HttpOnly` flag on a cookie instructs the UA to prevent JavaScript in the page from accessing the cookie and is a great protection against XSS attacks stealing the cookie. We find that a much larger % of sites issuing a cookie with this flag on their homepage.

<br/>

| client  | pages   | total   | pct   |
|---------|---------|---------|-------|
| desktop | 1059578 | 4371973 | 24.24 |
| mobile  | 1177596 | 5297442 | 22.23 |

<br/>

### SameSite
As a much more recent addition to cookie protections, the Same-Site flag is a powerful protection against Cross-Site Request Forgery (CSRF) attacks.

<br/>

| client  | pages | total   | pct  |
|---------|-------|---------|------|
| desktop | 4887  | 4371973 | 0.11 |
| mobile  | 5311  | 5297442 | 0.1  |

<br/>

Being a recently introduced mechanism, the usage of Same-Site cookies is much lower as we would expect. Because it provides much needed protection against a dangerous attack, there are currently indications that leading browsers could implement this feature by default and enable it on cookies even though the value is not set. If this were to happen the SameSite protection would be enabled in its weaker setting of Lax mode and not Strict mode.

<br/>

| client  | value  | freq | total | pct   |
|---------|--------|------|-------|-------|
| desktop | strict | 3114 | 5860  | 53.14 |
| mobile  | strict | 3101 | 6124  | 50.64 |
| mobile  | lax    | 2904 | 6124  | 47.42 |
| desktop | lax    | 2687 | 5860  | 45.85 |
| desktop | none   | 30   | 5860  | 0.51  |
| mobile  | none   | 25   | 6124  | 0.41  |

<br/>

We can see that of those pages already using Same-Site cookies, more than half of them are using it in Strict mode. This is closely followed by sites using Same-Site in Lax mode and then a small selection of sites using the value `none`. This last value is used to opt-out of the upcoming change where browser vendors may implement Lax mode by default.

### Prefixes
Another recent addition to cookies are Cookie Prefixes. These small changes to the name of your cookie to add one of two defined prefixes offer further protections to those already covered.

<br/>

| client  | prefix    | pages | total   | pct  |
|---------|-----------|-------|---------|------|
| desktop | __Secure- | 640   | 4371973 | 0.01 |
| mobile  | __Secure- | 628   | 5297442 | 0.01 |
| desktop | __Host-   | 154   | 4371973 | 0    |
| mobile  | __Host-   | 157   | 5297442 | 0    |

<br/>

The name of your cookie can be prefixed with either `__Secure-` or `__Host-`, with both offering slightly different things. As the figures show, the use of either prefix is incredibly low but as the more relaxed of the two, the `__Secure-` prefix does see more utilisation already. 

## Subresource Integrity
Another problem that has been on the rise recently is the security of 3rd party dependenices. When loading a script file from a 3rd party, we hope that the script file is always the library that we wanted, perhaps a particular version of jQuery. If a CDN or 3rd party hosting service is compromised, the script files they are hosting could be altered. In this scenario your application would now be loading malicious JavaScript that could harm your visitors. This is what Subresource integrity protets against.

By adding an integrity attribute to a script or link tag, a UA can integrity check the 3rd party resource and reject it if it has been altered.

<br/>

| client  | freq   | total   | pct  |
|---------|--------|---------|------|
| desktop |	247604 | 4474762 | 0.06 |
| mobile  | 272167 | 5447942 | 0.05 |

<br/>

With only 0.06% of desktop pages and 0.05% of mobile pages containing link or script tags with the integrity attribute set, there's room for a lot of improvement in the use of SRI. With many CDNs now providing code samples tha tinclude the SRI integrity attribute we should see a steady increase in the use of SRI. 

## Vulnerable JS Libraries
