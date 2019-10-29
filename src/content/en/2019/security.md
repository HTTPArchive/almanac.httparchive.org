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
The Security chapter of the Web Almanac looks at the current status of security on the Web. With security and privacy becoming increasingly more important online there has been an increase in the availability of features to protect site operators and users. We're going to look at the adoption of these new features across the Web.

## TLS
Perhaps the largest push to increasing security and privacy online we're seeing at present is the widespread adoption of Transport Layer Security. TLS (or the older version SSL) is the protocol that gives us the 'S' in HTTPS and allows secure and private browsing of websites. Not only are we seeing a great increase in the use of HTTPS across the Web, but also an increase in more modern versions of TLS like TLSv1.2 and TLSv1.3, which is also important.  

<br/>

| Client  | HTTP vs HTTPS | Sites using this scheme (%) |
|---------|---------------|-----------------------------|
| desktop | HTTPS         | 60.25%                      |
| mobile  | HTTPS         | 54.33%                      |
| desktop | HTTP          | 39.75%                      |
| mobile  | HTTP          | 45.67%                      |

<br/>

<insert pie chart of 08_01b - http vs https for both >

<br/>

### Protocol Versions
Looking at the support for various protocol versions we can see that the use of legacy TLS versions like TLSv1.0 and TLSv1.1 is minimal and almost all support is for the newer TLSv1.2 and TLSv1.3 versions of the protocol. Not only that but even though TLSv1.3 is still very young as a standard (TLSv1.3 was only formally approved in [August 2018](https://tools.ietf.org/html/rfc8446)), over 40% of requests using TLS are using the latest version!

<br/>

| Client  | TLS Version | Requests using this version (%) |
|---------|-------------|---------------------------------|
| mobile  | TLSv1.2     | 57.53%                          |
| desktop | TLSv1.2     | 58.32%                          |
| mobile  | TLSv1.3     | 41.77%                          |
| desktop | TLSv1.3     | 40.9%                           |
| mobile  | TLSv1.0     | 0.69%                           |
| desktop | TLSv1.0     | 0.78%                           |
| mobile  | TLSv1.1     | 0.01%                           |
| desktop | TLSv1.1     | 0.01%                           |

<br/>

<insert bar chart of 08_01>

<br/>

### Certificate Authorities 
Of course, if we want to use HTTPS on our website then we need a certificate from a Certificate Authority. With the increase in the use of HTTPS comes the increase in use of CAs and their products/services. Here are the top 10 certificate issuers based on the volume of TLS requests that use their certificate.

<br/>

| Client  | Issuing Certificate Authority          | Certificates issued by this CA (%)   |
|---------|----------------------------------------|--------------------------------------|
| mobile  | Google Internet Authority G3           | 19.68%                               |
| desktop | Google Internet Authority G3           | 19.26%                               |
| desktop | Let's Encrypt Authority X3             | 10.2%                                |
| desktop | DigiCert SHA2 High Assurance Server CA | 9.83%                                |
| mobile  | DigiCert SHA2 High Assurance Server CA | 9.26%                                |
| mobile  | Let's Encrypt Authority X3             | 9.19%                                |
| mobile  | DigiCert SHA2 Secure Server CA         | 8.72%                                |
| mobile  | GTS CA 1O1                             | 8.43%                                |
| desktop | GTS CA 1O1                             | 7.87%                                |
| desktop | DigiCert SHA2 Secure Server CA         | 7.55%                                |

<br/>

The rise of Let's Encrypt has been meteoric after their launch in early 2016, since then they've become one of the top certificate issuers in the world. The availability of free certificates and automated tooling has been critically important to the adoption of HTTPS on the Web and Let's Encrypt certainly had a significant part to play in both of those.

### Authentication key type
Alongside the important requirement to use HTTPS is the requirement to also use a good configuration. With so many configuration options and choices to make, this is a careful balance. Looking first of all at the keys used for authentication purposes, we still see a large % of the Web using RSA.

<br/>

| Client  | ECDA Keys (%) | RSA Keys (%) |
|---------|---------------|--------------|
| mobile  | 26.41%        | 58.8%        |
| desktop | 21.47%        | 48.67%       |

<br/>

Whilst ECDSA keys are stronger, which allows the use of smaller keys, and demonstrate better performance than their RSA counterparts, concerns around backwards compatibility, and complications in supporting both in the meantime, do prevent some website operators from migrating. 

### Forward Secrecy
Forward Secrecy is a property of some key exchange mechanisms that secures the connection in such a way that it prevents each connection to a server from being exposed even in case of a future compromise of the server's private key. This is well understood within the security community as desirable on all TLS connections to safeguard the security of those connections. It was introduced as an optional configuration in 2008 with TLSv1.2 and has become mandatory in 2018 with TLSv1.3 requiring the use of Forward Secrecy.

<br/>

| Client  | Requests using Forward Secrecy (%) |
|---------|------------------------------------|
| desktop | 96.92%                             |
| mobile  | 96.49%                             |

<br/>

Looking at the % of TLS requests that provide Forward Secrecy, we can see that support is tremendous. We'd expect that the continuing increase in the adoption of TLSv1.3 will further increase these numbers.

### Cipher Suites
With the simplification of the available cipher suites in TLSv1.3, and the drive to use better cipher suites created by sites like [SSL Labs](https://www.ssllabs.com/), we can see that the majority of cipher suites negotiated for TLS requests were indeed excellent.

<br/>

| Client  | Cipher Suite      | Requests using this Cipher Suite (%) |
|---------|-------------------|--------------------------------------|
| mobile  | AES_128_GCM       | 76.71%                               |
| desktop | AES_128_GCM       | 75.87%                               |
| mobile  | AES_256_GCM       | 18.49%                               |
| desktop | AES_256_GCM       | 19.73%                               |
| mobile  | AES_256_CBC       | 2.26%                                |
| mobile  | AES_128_CBC       | 1.72%                                |
| desktop | AES_256_CBC       | 2.22%                                |
| desktop | AES_128_CBC       | 1.43%                                |
| mobile  | CHACHA20_POLY1305 | 0.79%                                |
| desktop | CHACHA20_POLY1305 | 0.69%                                |
| desktop | 3DES_EDE_CBC      | 0.06%                                |
| mobile  | 3DES_EDE_CBC      | 0.04%                                |

<br/>

## Mixed Content
Most sites on the Web originally existed as HTTP websites and have had to migrate their site to HTTPS. This 'lift and shift' operation can be difficult and sometimes things get missed or left behind. This results in sites having Mixed Content, where their pages load over HTTPS but something on the page, perhaps an image or a style, is loaded over HTTP. Mixed Content is bad for security and privacy, and can be difficult to find and fix.

<br/>

| Client  | Pages with Mixed Content (%) | Pages with Active Mixed Content (%) |
|---------|------------------------------|-------------------------------------|
| desktop | 16.27%                       | 3.99%                               |
| mobile  | 15.37%                       | 4.13%                               |

<br/>

We can see that around 20% of sites across mobile and desktop present some form of mixed content. Whilst passive mixed content, something like an image, is less dangerous, we can still see that almost a quarter of sites with mixed content have active mixed content. Active mixed content, like javascript, is more dangerous as an attacker can insert their own hostile code into a page easily.

In the past web browsers have allowed passive mixed content and flagged it with a warning, but blocked active mixed content. More recently however, Chrome [announced](https://blog.chromium.org/2019/10/no-more-mixed-messages-about-https.html) it intends to improve here and as HTTPS becomes the norm it will block all mixed content instead.

## Security Headers
Many new and recent features for site operators to better protect their users have come in the form of new HTTP response headers that can configure and control security protections built into the browser. Some of these features are easy to enable and provide a huge level of protection whilst others require a little more work from site operators. If you wish to check if a site is using these headers and has them correctly configured, you can use the [Security Headers](https://securityheaders.com/) tool to scan it.

### HTTP Strict Transport Security
The [HSTS](https://tools.ietf.org/html/rfc6797) header allows a website to instruct a browser that it should only ever communicate with the site over a secure HTTPS connection. This means that any attempts to use a http:// URL will automatically be converted to https:// before a request is made. Given that over 40% of requests were capable of using TLS, we see a much lower % of requests instructing the browser to require it.

<br/>

| Client  | HSTS Directive    | Pages with this directive in their policy (%) |
|---------|-------------------|-----------------------------------------------|
| desktop | max-age           | 14.8%                                         |
| mobile  | max-age           | 12.81%                                         |
| desktop | includeSubDomains | 3.86%                                          |
| mobile  | includeSubDomains | 3.29%                                          |
| desktop | preload           | 2.27%                                          |
| mobile  | preload           | 1.99%                                          |

<br/>

Less than 15% of mobile and desktop pages are issuing a HSTS with the minimum requirement of a max-age directive. Fewer still are including subdomains in their policy with the includeSubDomains directive and even fewer still are HSTS preloading. Looking at the median value for a HSTS max-age we can see that on both desktop and mobile it is 15768000, a strong configuration.

<br/>

| Percentile | Client  | max_age value (s)  |
|------------|---------|--------------------|
| 10         | desktop | 300                |
| 10         | mobile  | 300                |
| 25         | desktop | 7889238            |
| 25         | mobile  | 7889238            |
| 50         | desktop | 15768000           |
| 50         | mobile  | 15768000           |
| 75         | desktop | 31536000           |
| 75         | mobile  | 31536000           |
| 90         | desktop | 63072000           |
| 90         | mobile  | 63072000           |

<br/>

#### HSTS Preloading
With the HSTS policy delivered via a HTTP Response Header, when visiting a site for the first time a browser will not know whether a policy is configured. To avoid this Trust On First Use problem, a site operator can have the policy preloaded into the browser.

<br/>

| Client  | Sites eligible for HSTS Preloading (%) |
|---------|----------------------------------------|
| desktop | 0.31%                                  |
| mobile  | 0.26%                                  |

<br/>

The requirements to do so are outlined on the [HSTS Preload](https://hstspreload.org/) site but we can see that only a small number of sites are eligible according to current criteria.

### Content Security Policy
Web applications face frequent attacks where hostile content finds its way into a page. The most worrisome form of content is JavaScript and when an attacker finds a way to insert JavaScript into a page, they can launch damaging attacks. These attacks are known as Cross-Site Scripting (XSS) and [CSP](https://www.w3.org/TR/CSP2/) provides an effective defence against these attacks. Alongside XSS protection, CSP also offers several other key benefits.

Despite the many benefits of CSP we find that only 5.51% of desktop pages include a CSP and only 4.73% of mobile pages include a CSP.

#### Hash/Nonce
A common approach to CSP is to create a whitelist of 3rd party domains that are permitted to load content, such as JavaScript, into your pages. Creating and managing these whitelists can be difficult so [Hashes](https://www.w3.org/TR/CSP2/#source-list-valid-hashes) and [Nonces](https://www.w3.org/TR/CSP2/#source-list-valid-nonces) were introduced as an alternative approach. Of the sites surveyed only 0.09% of desktop pages use a Nonce source and only 0.02% of desktop pages use a Hash source. The number of mobile pages use a Nonce source is interestingly higher at 0.13% but the use of Hash sources is lower on mobile pages at 0.01%.

#### strict-dynamic
The introduction of [Strict-Dynamic](https://www.w3.org/TR/CSP3/#strict-dynamic-usage) further reduced the burden on site operators for using CSP by allowing a whitelisted script to load further script dependencies. Despite the introduction of this feature, only 0.03% of desktop pages and 0.1% of mobile pages include it in their policy.  

#### trusted-types
XSS attacks come in various forms and [Trusted-Types](https://github.com/w3c/webappsec-trusted-types) was created to help specifically with DOM-XSS. Despite being an effective mechanism, our data shows that only 2 mobile and desktop pages use the Trusted-Types directive.

#### Unsafe inline/eval
When a CSP is deployed on a page, certain unsafe features like inline script or the use of `eval()` are disabled. A page can depend on these features and in place of enabling them in a safe fashion, perhaps with a Nonce or Hash source, site operators can enable these unsafe features with Unsafe-Inline or Unsafe-Eval in their CSP. Of the 5.51% of desktop pages that include a CSP, 33.94% of them include Unsafe-Inline and 31.03% of them include Unsafe Eval. On mobile pages we find that of the 4.73% that contain a CSP, 34.04% use Unsafe-Inline and 31.71% use Unsafe-Eval.

#### upgrade-insecure-requests
A common problem that site operators face in their migration from HTTP to HTTPS is that some content can still be accidentally loaded over HTTP on their HTTPS page. This problem is known as Mixed Content and CSP provides an effective way to solve this problem. The Upgrade-Insecure-Requests directive instructs a browser to load all subresources on a page over a secure connection, automatically upgrading HTTP requests to HTTPS requests as an example.

Of the HTTPS pages surveyed on the desktop, 16.27% of them loaded mixed-content with 3.99% of pages loading active mixed-content like JS/CSS/fonts. On mobile pages we see 15.37% of HTTPS pages loading mixed-content with 4.13% loading active mixed-content. By loading active content such as JavaSript over HTTP an attacker can easily inject hostile code into the page to launch an attack. This is what the UIR directive in CSP protects against.

The UIR directive is found in the CSP of 3.24% of desktop pages and 2.84% of mobile pages, indicating that an increase in adoption would provide substantial benefits.

#### frame-ancestors
Another common attack known as ClickJacking is conducted by an attacker who will place a target website inside an iframe on a hostile webiste. Whilst the X-Frame-Options header (discussed below) originally set out to control framing, it wasn't flexible and Frame-Ancestors in CSP stepped in to provide a more flexible solution. Site operators can now specify a list of hosts that are permitted to frame them and any other hosts attempting to frame them will be prevented.

Of the pages surveyed, 2.85% of desktop pages include the Frame-Ancestors directive in CSP with 0.74% of desktop pages setting Frame-Ancestors to `'none'`, preventing any framing, and 0.47% of pages setting Frame-Ancestors to `'self'`, allowing only their own site to frame itself. On mobile we see 2.52% of pages using Frame-Ancestors with 0.71% setting the value of `'none'` and 0.41% setting the value to `'self'`.

### Referrer Policy
The [Referrer Policy](https://www.w3.org/TR/referrer-policy/) header allows a site to control what information will be sent in the Referer header when a user navigates away from the current page. By controlling what information is sent in the Referer header, ideally limiting it, a site can protect the privacy of their visitors by reducing the information sent to 3rd parties.

A total of 3.25% of desktop pages and 2.95% of mobile pages issue a Referrer Policy header and below we can see the configurations those pages used.

<br/>

| Client  | Configuration                   | Policies set to this configuration (%) |
|---------|---------------------------------|----------------------------------------|
| mobile  | no-referrer-when-downgrade      | 41.52%                                 |
| desktop | no-referrer-when-downgrade      | 39.16%                                 |
| desktop | strict-origin-when-cross-origin | 23.46%                                 |
| mobile  | strict-origin-when-cross-origin | 22.17%                                 |
| mobile  | unsafe-url                      | 9.69%                                  |
| desktop | unsafe-url                      | 8.77%                                  |
| desktop | same-origin                     | 7.97%                                  |
| mobile  | same-origin                     | 7.21%                                  |
| desktop | origin-when-cross-origin        | 6.76%                                  |
| mobile  | origin-when-cross-origin        | 6.44%                                  |
| desktop | no-referrer                     | 5.65%                                  |
| mobile  | no-referrer                     | 5.38%                                  |
| desktop | strict-origin                   | 4.35%                                  |
| mobile  | strict-origin                   | 4.14%                                  |
| desktop | origin                          | 3.63%                                  |
| mobile  | origin                          | 3.23%                                  |

<br/>

This table shows the valid values set by pages and that 99.75% of desktop pages and 96.55% of mobile pages are setting a valid policy. The most popular choice of configuration is `no-referrer-when-downgrade` which will prevent the Referer header being sent when a user navigates from a HTTPS page to a HTTP page. The second most popular choice is `strict-origin-when-cross-origin` which prevents any information being sent on a scheme downgrade (HTTPS to HTTP navigation) and when information is sent in the Referer it will only contain the origin of the soruce and not the full URL. Details on the other valid configurations can be found in the [Referrer Policy specification](https://www.w3.org/TR/referrer-policy/#referrer-policies). 

### Feature Policy
As the web platform becomes more powerful and feature rich, attackers can these new APIs in interesting ways. In order to limit abuse of powerful APIs, a site operator can issue a [Feature Policy](https://w3c.github.io/webappsec-feature-policy/) header to disable features that are not required, preventing them from being abused.

Here are the 5 most popular features that are controlled with a Feature Policy.

<br/>

| Client  | Feature     | Policies that control this feature (%) |
|---------|-------------|----------------------------------------|
| mobile  | microphone  | 10.98%                                 |
| desktop | microphone  | 10.78%                                 |
| mobile  | camera      | 10.19%                                 |
| desktop | camera      | 9.95%                                  |
| desktop | payment     | 9.54%                                  |
| mobile  | payment     | 9.54%                                  |
| mobile  | geolocation | 9.41%                                  |
| desktop | geolocation | 9.38%                                  |
| desktop | gyroscope   | 7.92%                                  |
| mobile  | gyroscope   | 7.9%                                   |

<br/>

We can see that the most popular feature to take control of is the microphone, with almost 11% of desktop and mobile pages issuing a policy that includes it. Delving deeper into the data we can look at what those pages are allowing or blocking.

<br/>

| Feature    | Configuration | Policies that set this configuration (%) |
|------------|---------------|------------------------------------------|
| microphone | none          | 9.09%                                    |
| microphone | none          | 8.97%                                    |
| microphone | self          | 0.86%                                    |
| microphone | self          | 0.85%                                    |
| microphone | *             | 0.64%                                    |
| microphone | *             | 0.53%                                    |

<br/>

By far the most common approach here is to block use of the microphone altogether, with ~9% of pages taking that approach. A small number of pages do allow the use of the microphone by their own origin and interestingly, a small selection of pages intentionally allow use of the microphone by any origin loading content in their page. 

### X-Frame-Options
The [X-Frame-Options](https://tools.ietf.org/html/rfc7034) header allows a page to control whether or not it can be placed in an iframe by another page. Whilst lacking the flexibility of `frame-ancestors` in CSP, mentioned above, it was effective if you didn't require fine grained control of framing.

<br/>

| Client  | Homepages that use XFO (%) |
|---------|----------------------------|
| desktop | 16.99%                     |
| mobile  | 14.77%                     |

<br/>

We see that the usage of the XFO header is quite high on both desktop and mobile and can also look more closely at the specific configurations used.

<br/>

| Client  | XFO configuration | Policies that use this configuration (%) |
|---------|-------------------|------------------------------------------|
| desktop | sameorigin        | 84.92%                                   |
| mobile  | sameorigin        | 83.86%                                   |
| mobile  | deny              | 14.5%                                    |
| desktop | deny              | 13.54%                                   |
| mobile  | allow-from        | 1.64%                                    |
| desktop | allow-from        | 1.53%                                    |

<br/>

It seems that the vast majority of pages restrict framing to only their own origin and the next significant approach is to prevent framing altogether. This is similar to `frame-ancestors` in CSP where these 2 approaches are also the most common.

### X-Content-Type-Options
The [XCTO](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options) header is the most widely deployed Security Header and is also the most simple, with only one possible configuration value `nosniff`.

<br/>

| Client  | Homepages that use XCTO (%) |
|---------|-----------------------------|
| desktop | 17.61%                      |
| mobile  | 17.61%                      |

<br/>

Interestingly, we find that an identical % of pages on both mobile and desktop issue the XCTO header which prevents a browser from MIME sniffing. When this header is issued a browser must treat a piece of content as the MIME Type declared in the `Content-Type` header and not try to change the advertised value.

### X-Xss-Protection
The [XXP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) header allows a site to control the XSS Auditor or XSS Filter built into a browser but is no largely useless. Edge retired their XSS Filter, Chrome deprecated their XSS Auditor and Firefox never implemented support for the feature, yet we still see widespread use of the header.

<br/>

| Client  | Homepages that use XXP (%) |
|---------|----------------------------|
| desktop | 14.69%                     |
| mobile  | 15.2%                      |

<br/>

Digging into the data we can see what the intention for most site operators was.

<br/>

| Client  | XXP Configuration | Policies that use this configuration (%) |
|---------|-------------------|------------------------------------------|
| desktop | 1;mode=block      | 91.77%                                   |
| mobile  | 1;mode=block      | 91.46%                                   |
| desktop | 1                 | 5.54%                                    |
| mobile  | 1                 | 5.35%                                    |
| mobile  | 0                 | 3.11%                                    |
| desktop | 0                 | 2.58%                                    |
| desktop | 1;report=         | 0.12%                                    |
| mobile  | 1;report=         | 0.09%                                    |

<br/>

The value `1` enables the filter/auditor and `mode=block` sets the protection to the strongest setting where any suspected XSS attack would cause the page to not be rendered. The second most common configuration was to simply ensure the auditor/filter was turned on, by presenting a value of `1` and then the 3rd most popular configuration is quite interesting.

Setting a value of `0` in the header instructs the browser to disable any XSS auditor/filter that it may have. Some historic attacks demonstrated how the auditor or filter could be tricked into assisting an attacker rather than protecting the user so some site operators could disable it if they were confident they have adequate protection against XSS in place.

### Report-To
The [Reporting API](https://www.w3.org/TR/reporting/) was introduced to allow site operators to gather various pieces of telemetry from the browser. Many errors or problems on a site can result in a poor experience for the user yet a site operator can only find out if the user contacts them. The Reporting API provides a mechanism for a browser to automatically report these problems without any user interaction or interruption. The Reporting API is configured by delivering the Report-To header.

<br/>

| Client  | Homepages that use Report-To (%) |
|---------|----------------------------------|
| desktop | 1.7%                             |
| mobile  | 1.57%                            |

<br/>

By specifying the header, which contains a location where the telemetry should be sent, a browser will automatically begin sending the data and you can use a 3rd party service like [Report URI](https://report-uri.com/) to collect the reports or collect them yourself! Given the ease of deployment and configuration, we can see that only a small fraction of desktop and mobile sites currently enable this feature. To see the kind of telemetry you can collect, refer to the [Reporting API specification](https://www.w3.org/TR/reporting/).

### Network Error Logging
Network Error Logging provides detailed information about various failures in the browser that can result in a site being inoperative. By issuing the NEL header to the browser, the browser will report these failures via the Reporting API mentioned above.

<br/>

| Client  | Homepages that use NEL (%) |
|---------|----------------------------|
| desktop | 1.7%                       |
| mobile  | 1.57%                      |

<br/>

Of course, with NEL depending on the Reporting API, we shouldn't see the usage of NEL exceed that of the Reporting API so we see similarly low numbers here too. NEL provides incredibly valuable information and you can read more about the type of information in the [Network Error Logging specification](https://w3c.github.io/network-error-logging/#predefined-network-error-types).  

### Clear Site Data
With the increasing ability to store data locally on a user's device, via cookies, caches and local storage to name but a few, site operators needed a reliable way to manage this data. The Clear Site Data header provides a reliable means to ensure that all data of a particular type is removed from the device.

<br/>

| Client  | Homepages that use CSD (%) | Homepages that use CSD (total) |
|---------|----------------------------|--------------------------------|
| mobile  | 0                          | 7                              |
| desktop | 0                          | 9                              |

<br/>

Given the nature of the header, it's unsurprising to see almost no usage reported. With our data only looking at the homepage of a site, we're unlikely to see the most common use of the header which would be on a logout endpoint. Upon logging out of a site, the site operator would return the Clear Site Data header and the browser would remove all data of the indicated types. This is unlikely to take place on the homepage of a site.  

## Cookies
Cookies have many security protections available and whilst some of those are long standing, having been available for years, some of them are really quite new have been introduced only in the last couple of years.

### Secure
The `Secure` flag on a cookie instructs a browser to only send the cookie over a secure (HTTPS) connection and we find a small % of sites issuing a cookie with the Secure flag set on their homepage.

<br/>

| Client  | Homepages with Secure flag on cookies (%) |
|---------|-------------------------------------------|
| desktop | 4.22%                                     |
| mobile  | 3.68%                                     |

<br/>

### HttpOnly
The `HttpOnly` flag on a cookie instructs the browser to prevent JavaScript in the page from accessing the cookie and is a great protection against XSS attacks stealing the cookie. We find that a much larger % of sites issuing a cookie with this flag on their homepage.

<br/>

| Client  | Homepages with HttpOnly flag on cookies (%) |
|---------|---------------------------------------------|
| desktop | 24.24%                                      |
| mobile  | 22.23%                                      |

<br/>

### SameSite
As a much more recent addition to cookie protections, the `Same-Site` flag is a powerful protection against Cross-Site Request Forgery (CSRF) attacks.

<br/>

| Client  | Homepages with Same-Site flag on cookies (%) |
|---------|----------------------------------------------|
| desktop | 0.11%                                        |
| mobile  | 0.1%                                         |

<br/>

Being a recently introduced mechanism, the usage of Same-Site cookies is much lower as we would expect. Because it provides much needed protection against a dangerous attack, there are currently indications that leading browsers could implement this feature by default and enable it on cookies even though the value is not set. If this were to happen the SameSite protection would be enabled in its weaker setting of Lax mode and not Strict mode.

<br/>

| Client  | SameSite configuration value | Cookies with SameSite using this value (%) |
|---------|------------------------------|--------------------------------------------|
| desktop | strict                       | 53.14%                                     |
| mobile  | strict                       | 50.64%                                     |
| mobile  | lax                          | 47.42%                                     |
| desktop | lax                          | 45.85%                                     |
| desktop | none                         | 0.51%                                      |
| mobile  | none                         | 0.41%                                      |

<br/>

We can see that of those pages already using Same-Site cookies, more than half of them are using it in Strict mode. This is closely followed by sites using Same-Site in Lax mode and then a small selection of sites using the value `none`. This last value is used to opt-out of the upcoming change where browser vendors may implement Lax mode by default.

### Prefixes
Another recent addition to cookies are Cookie Prefixes. These small changes to the name of your cookie to add one of two defined prefixes offer further protections to those already covered.

<br/>

| Client  | Cookie prefix value | Number of homepages with this value | Homepages with this value (%) |
|---------|---------------------|-------------------------------------|-------------------------------|
| desktop | __Secure-           | 640                                 | 0.01%                         |
| mobile  | __Secure-           | 628                                 | 0.01%                         |
| desktop | __Host-             | 154                                 | 0%                            |
| mobile  | __Host-             | 157                                 | 0%                            |

<br/>

The name of your cookie can be prefixed with either `__Secure-` or `__Host-`, with both offering slightly different things. As the figures show, the use of either prefix is incredibly low but as the more relaxed of the two, the `__Secure-` prefix does see more utilisation already. 

## Subresource Integrity
Another problem that has been on the rise recently is the security of 3rd party dependenices. When loading a script file from a 3rd party, we hope that the script file is always the library that we wanted, perhaps a particular version of jQuery. If a CDN or 3rd party hosting service is compromised, the script files they are hosting could be altered. In this scenario your application would now be loading malicious JavaScript that could harm your visitors. This is what Subresource integrity protets against.

By adding an integrity attribute to a script or link tag, a browser can integrity check the 3rd party resource and reject it if it has been altered.

<br/>

| Client  | Pages using SRI (%) |
|---------|---------------------|
| desktop | 0.06%               |
| mobile  | 0.05%               |

<br/>

With only 0.06% of desktop pages and 0.05% of mobile pages containing link or script tags with the integrity attribute set, there's room for a lot of improvement in the use of SRI. With many CDNs now providing code samples tha tinclude the SRI integrity attribute we should see a steady increase in the use of SRI. 

## Vulnerable JS Libraries
