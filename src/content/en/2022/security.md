---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Security
#TODO - Review and update chapter description
description: Security chapter of the 2022 Web Almanac covering Transport Layer Security, content inclusion (CSP, Feature Policy, SRI), web defense mechanisms (tackling XSS, XS-Leaks), and drivers of security mechanism adoptions.
authors: [SaptakS, feross, lirantal]
reviewers: [kushaldas, tomvangoethem, nrllh, clarkio]
analysts: [VictorLeP, vikvanderlinden, GJFR]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1cwJ43NL2IN2PxJa5oiOoJCRkSh566XE_k9uHnGJdWeg/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
unedited: true
---

## Introduction

As people's personal details continue to become more digital, security and privacy are becoming extremely crucial across the internet. It's the website owner's responsibility that they can secure the data they are taking from the user. Hence, it is essential for them to adopt all the security best practices to ensure protection of the user against vulnerabilities that malwares can exploit to get sensitive information.

Like previous years, we have analyzed the adoption and usage of security methods and best practices by the web community. We have analyzed metrics related to the bare essential security measures that every website should adopt such as transport security and proper cookie management. We have also discussed the data related to the adoption of different security headers and how they help in content inclusion and preventing various malicious attacks.

We looked at correlations for adoption of security measures with the location, technological stack and website popularity. We hope that such correlations encourage all technological stacks to aim for better security measures by default. We also discuss some well-known URIs that help towards vulnerability disclosure and other security related settings based on Web Application Security Working Group's standards and drafts.

## Transport security

Transport Layer Security ensures secure communication of data and resources between the user and the websites. HTTPS uses TLS to encrypt all communication between the client and the server.

{{ figure_markup(
  content="94%",
  caption="Requests that use HTTPS on desktop.",
  classes="big-number",
  sheets_gid="1093490384",
  sql_file="https_request_over_time.sql",
) }}

94% of total requests in desktop and 93% of total requests in mobile are made over HTTPS. All major browsers now have an HTTPS-only mode to show warning if a website uses HTTP instead of HTTPS.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The percentage of homepages that are served over HTTPS continues to be lower compared to the total requests because a lot of the requests to a website are dominated by third-party services like fonts, CDN, etc. which have a higher HTTPS adoption. We do see a slight increase from last year in the percentage. 89.3% of homepages are now served over HTTPS on desktop compared to 84.3% last year. Similarly, in our mobile dataset, 85.5% of homepages are served over HTTPS compared to 81.2% last year.

### Protocol versions

It's important, not only to use HTTPS, but also to use an up-to-date TLS version. The <a hreflang="en" href="https://datatracker.ietf.org/doc/rfc8996/">TLS working group</a> has deprecated TLS v1.0 and v1.1 since they had multiple weaknesses. Since the last year's chapter, Firefox has <a hreflang="en" href="https://support.mozilla.org/en-US/kb/secure-connection-failed-firefox-did-not-connect#w_tls-version-unsupported">now updated it's UI</a> and the option to enable TLS 1.0 and 1.1 has been removed from the error page in Firefox version 97. Chrome has also <a hreflang="en" href="https://chromestatus.com/feature/5759116003770368">stopped allowing bypassing</a> the error page which is shown for TLS 1.0 and 1.1 since version 98.

TLS v1.3 is the latest and was released in August 2018 by IETF. It's <a hreflang="en" href="https://www.cloudflare.com/en-in/learning/ssl/why-use-tls-1.3/">much faster and is more secure</a> than TLS v1.2. Many of the major vulnerabilities in TLS v1.2 had to do with older cryptographic algorithms which TLS v1.3 removes.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

In the above graph, we see that 70% of homepages in mobile and 67% of homepages in desktop are served over TLSv1.3 which is approximately 7% more than last year. So, we are seeing some constant shift from use of TLS v1.2 to TLS v1.3

### Cipher suites

A cipher suite is a set of cryptographic algorithms that the client and server must agree on before they can begin communicating securely using TLS.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

Modern [Galois/Counter Mode (GCM)](https://en.wikipedia.org/wiki/Galois/Counter_Mode) cipher modes are considered to be much more secure since they are not vulnerable to <a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">padding attacks</a>. TLS v1.3 <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">only supports GCM and other modern block cipher modes</a> making it more secure. Another factor that determines the usage of a cipher suite is the key size for the encryption and decryption. We still see 128-bit key size being widely used. Hence, we don't see much difference from last year's graph with  `AES_128_GCM` continuing to be the most used cipher suite with 79% usage.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

TLS v1.3 also makes [forward secrecy](https://en.wikipedia.org/wiki/Forward_secrecy) compulsory. We see 97% of requests in both mobile and desktop using forward secrecy.

### Certificate Authority

A Certificate Authority or CA is a company or organization that issues the TLS certificate to the websites that can be recognized by browsers and then establish a secure communication channel with the website.

<figure>
  <table>
    <thead>
      <tr>
        <th>Issuer</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>R3</td>
        <td class="numeric">48%</td>
        <td class="numeric">52%</td>
      </tr>
      <tr>
        <td>Cloudflare Inc ECC CA-3</td>
        <td class="numeric">13%</td>
        <td class="numeric">12%</td>
      </tr>
      <tr>
        <td>Sectigo RSA Domain Validation Secure Server CA</td>
        <td class="numeric">7%</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>cPanel, Inc. Certification Authority</td>
        <td class="numeric">5%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td>Amazon</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">3%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>DigiCert TLS RSA SHA256 2020 CA1</td>
        <td class="numeric">2%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>E1</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Must used Certificate Authorities.",
      sheets_gid="1306037372",
      sql_file="security_headers_prevalence.sql",
    ) }}
  </figcaption>
</figure>

Let's Encrypt (or R3) continues to lead the charts with 48% of websites in desktop and 52% of websites in mobile using certificates issued by them. Let's Encrypt being a non-profit organization has played an important role in the adoption of HTTPS and they continue to issue an <a hreflang="en" href="https://letsencrypt.org/stats/#daily-issuance">increasing number of certificates</a>. We would also like to take a moment to recognise one of its founders, Peter Eckersly, who unfortunately passed away recently.

Cloudflare continues to be in second position with its similarly free certificates for its customers. Cloudflare CDNs increase the usage of Elliptic Curve Cryptography (ECC) certificates which are smaller and more efficient than RSA certificates but are often difficult to deploy, due to the need to also continue to serve non-ECC certificates to older clients. We see as Let's Encrypt and Cloudflare's percentage continues to increase, the percentage for usage of other CAs are decreasing a little.

### HTTP Strict Transport Security

HTTP Strict Transport Security (HSTS) is a response header that informs the browser to automatically convert all attempts to access a site using HTTP to HTTPS requests instead.

{{ figure_markup(
  content="25%",
  caption="Mobile requests that have HSTS header.",
  classes="big-number",
  sheets_gid="822440544",
  sql_file="hsts_attributes.sql",
) }}

26% of the mobile responses and 28% of desktop responses have an HSTS header.

HSTS is set using the `Strict-Transport-Security` header that can have three different directives: `max-age`, `includeSubDomains`, and `preload`. `max-age` helps denote the time, in seconds, that the browser should remember to access the site only using HTTPS. `max-age` is a compulsory directive for the header.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

We see 94% of sites in desktop and 95% of sites in mobile have a non-zero, non-empty `max-age`.

34% of request responses for mobile, and 37% for desktop include `includeSubdomain` in the HSTS settings. The number of responses with the `preload` directive, which is [not part of the HSTS specification](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security) is lower. It needs a minimum `max-age` of 31,536,000 seconds (or 1 year) and also the `includeSubdomain` directive to be present.

The median value for `max-age` attribute in HSTS headers over all requests is 365 days in both mobile and desktop. https://hstspreload.org/ recommends a `max-age` of 2 years once the HSTS header is set up properly and verified to not cause any issues.

## Cookies

An HTTP cookie is a set of data about the user that the server sends to the browser. A cookie can be used for things like session management, personalization, tracking and other stateful information related to the user over different requests.

If a cookie is not set properly, it can be susceptible to many different forms of attacks such as session hijacking, Cross-Site Request Forgery (CSRF), Cross-Site Script Inclusion (XSSI) and various other Cross-Site Leak vulnerabilities.

### Attributes

To defend against the above mentioned threats, developers can use 3 different attributes in a cookie: `HttpOnly`, `Secure` and `SameSite`. The `Secure` attribute is similar to the `HSTS` header as it also ensures that the cookies are always sent over HTTPS, preventing Man in the Middle attacks. `HttpOnly` ensures that a cookie is not accessible from any JavaScript code, preventing Cross-Site Scripting Attacks.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

There are 2 different kinds of cookies—First Party and Third Party. First-party cookies are usually set by the direct server that you are visiting. Third-party cookies are created by third-party services and are often used for tracking and ad-serving. 37% of the first-party cookies on the desktop have `Secure` and 36% of them have `HttpOnly`. However, in the third party cookies we see that 90% of cookies have `Secure` and 21% of cookies have `HttpOnly`. The percentage of `HttpOnly` is less in third party cookies, because they mostly do want to allow access to them by JavaScript code.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The `SameSite` attribute can be used to prevent CSRF attacks by telling the browser whether to send the cookie to cross-site requests. `Strict` value allows the cookie to be sent only to the site where it originated while `Lax` value allows cookies to be sent to cross-site requests only if a user is navigating to the origin site by following a link. For `None` value, cookies are sent to both originating and cross-site requests. If `SameSite=None` is set, the cookie's `Secure` attribute must also be set (or the cookie will be blocked). We see that 61% of first-party cookies with the `SameSite` attribute have the value `Lax`. Most browsers default to `SameSite=Lax` if no `SameSite` attribute is present for the cookie hence we see that it continues to dominate the charts. In third party cookies, `SameSite=None` still continues to be super high with 98% cookies in desktop, because third-party cookies do want to be sent across cross-site requests.

### Cookie age

There are two different ways to set the time when a cookie is deleted: `Max-Age` and `Expires`. `Expires` uses a specific date (relative to the client) to determine when the cookie is deleted whereas `Max-Age` uses a duration in seconds.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

Unlike last year, where we saw that the median for `Max-Age` was 365 days but the median for `Expires` was 180 days, this year it's around 365 days for both. Hence the median for real maximum age has gone up from 180 days to 365 days this year. Even though the `Max-Age` is 729 days and `Expires` is 730 days in the 90th percentile, Chrome has been planning to put a cap of 400 days for both `Max-Age` and `Expires`.

<figure>
  <table>
    <thead>
      <tr>
        <th>%</th>
        <th>Expires</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1.8%</td>
        <td>"Thu, 01-Jan-1970 00:00:00 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">1.2%</td>
        <td>"Fri, 01-Aug-2008 22:45:55 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.7%</td>
        <td>"Mon, 01-Mar-2004 00:00:00 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.7%</td>
        <td>"Thu, 01-Jan-1970 00:00:01 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.3%</td>
        <td>"Thu, 01 Jan 1970 00:00:00 GMT"</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most common cookie expiry values on desktop.",
      sheets_gid="707972861",
      sql_file="cookie_max_age_expires_top_values.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>%</th>
        <th>Expires</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1.2%</td>
        <td>"Fri, 01-Aug-2008 22:45:55 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.9%</td>
        <td>"Thu, 01-Jan-1970 00:00:00 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.7%</td>
        <td>"Mon, 01-Mar-2004 00:00:00 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.6%</td>
        <td>"Thu, 01-Jan-1970 00:00:01 GMT"</td>
      </tr>
      <tr>
        <td class="numeric">0.2%</td>
        <td>"Thu, 31-Dec-37 23:55:55 GMT"</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most common cookie expiry values on mobile.",
      sheets_gid="707972861",
      sql_file="cookie_max_age_expires_top_values.sql",
    ) }}
  </figcaption>
</figure>

The most prevalent `Expires` has some interesting values. We see that the most used `Expires` value in Desktop is `January 1, 1970 00:00:00 GMT`. When cookies `Expires` value is set to a past date, they are deleted from the browser. January 1, 1970 00:00:00 GMT is the unix epoch time and hence it's often commonly used to expire or delete a cookie.

## Content inclusion

A website's content often takes many shapes and requires resources such as CSS, JavaScript, or other media assets like fonts and images. These are frequently loaded from external service providers of the likes of remote storage services of cloud-native infrastructure, or from content delivery networks (CDNs) with the aim of reducing worldwide networking round-trips just to serve the content.

However, ensuring that the content we include on the website hasn't been tampered with is of high stakes, and the impact of which can be devastating. Content inclusion is of even higher importance these days given the recent rise of awareness to supply chain security, and growing incidents of Magecart attacks that target website content systems to inject persistent malware through means of cross-site scripting (XSS) vulnerabilities and others.

### Content Security Policy

One effective measure you can deploy to mitigate security risks around content inclusion is by employing a Content Security Policy (CSP). It is a security standard that adds a defense-in-depth layer in order to mitigate attacks such as code injection via cross-site scripting, or clickjacking, to name a few.

It works by ensuring that a predefined trusted set of content rules is upheld and any attempts to bypass or include restricted content are rejected. For example, a content security policy that would allow JavaScript code to run in the browser only from the same origin it was served, and from that of Google Analytics would be defined as `script-src 'self' www.google-analytics.com;`. Any attempts of cross-site scripting injections that add inline JavaScript code such as `<a img=x onError=alert(1)>` would be rejected by the browser enforcing the set policy.


{{ figure_markup(
  content="14%",
  caption="Relative increase in adoption for Content Security Policy header from 2021.",
  classes="big-number",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql",
) }}

We're seeing a 14% relative increase in adoption for `Content-Security-Policy` header from 2021's data of 12.8% to 2022's data of 14.6% which demonstrates a growing trend of adoption across developers and the web security community. This is positive, though it's still a minority of sites using this more advanced feature.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

CSP is most useful, when served on the HTML response itself and here we're seeing consistent growing adoption in mobile requests serving a CSP header with 7.2% two years ago, 9.3% last year, and this year a total of 11.2% of mobile homepages.

The top three CSP directives that we're seeing serving more than a quarter of the HTTP requests for both desktop and mobile are `upgrade-insecure-requests` at a 54%, `frame-ancestors` at 54%, and the `block-all-mixed-content` policy at 27%. Trailing policies are `default-src`, `script-src`, `style-src`, and `img-src` to name a few.

The `upgrade-insecure-requests` policy's high adoption rate could perhaps be attributed to the high adoption of TLS requests as a de-facto standard. However, despite `block-all-mixed-content` being considered deprecated as of this date, it's showing a high adoption rate. This perhaps speaks to the fast rate at which the CSP specification is advancing and users having a hard time keeping up to date.

More to do with mitigating cross-site scripting attacks is Google's security initiative for Trusted Types, which requires native browser API support to employ a technique which helps prevent DOM-injection class of vulnerabilities. It is actively advocated by Google engineers yet is still in draft proposal mode for the W3C. Nonetheless, we record its CSP related security headers `require-trusted-types-for` and `trusted-types` at 0.1% of requests which is not a lot, but perhaps speaks to a growing trend of adoption.

To assess whether a CSP violation from the pre-defined set of rules is occurring, websites can set the `report-uri` directive that the browser will send JSON formatted data as an HTTP POST request. Although `report-uri` requests account for 4.3% of all desktop traffic, it is to date a deprecated directive and has been replaced with `report-to` which accounts for 1.8% of desktop requests.

One of the biggest contributors to the challenge of implementing a tight content security policy is the existence of inline JavaScript code that's commonly set as event handlers or at other parts of the DOM. To allow teams a progressive adoption of the CSP security standard, a policy may set `unsafe-inline` or `unsafe-eval` as keyword values for its `script-src` directive. Doing so, fails to prevent some cross-site scripting attack vectors and is counter-productive to the preventative measure of a policy.

Teams can utilize a more secure posture of inline JavaScript code by signing them with a nonce or a SHA256 hash. This would look like something along the lines of:

```
Content-Security-Policy: script-src 'nonce-4891cc7b20c'
```

And then referencing that in the HTML:

```html
<script nonce="nonce-4891cc7b20c">
  …
</script>
```

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The statistics collected for all desktop HTTP requests show that `unsafe-inline` is present on  for 94%, and `unsafe-eval`on 80% of all `script-src` values. This demonstrates the real challenges in locking down a website's application code to avoid inline JavaScript code. Furthermore, Only 14% of all above described requests employ a `nonce-` directive which assists in securing the use of unsafe inline JavaScript code.

Perhaps speaking to the high complexity of defining a content security policy is the statistics we observe for CSP header length.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

At a median ranking, 50% of requests are only up to 70 bytes in size for desktop requests. This is a slight drop from last year's report which showed both desktop and mobile requests at 75 bytes in size. The 90th percentile of requests and above has grown from last year's 389 bytes for desktop requests, to 494 bytes this year. This demonstrates a slight progress towards more complex and complete security policies.

Observing the complete definitions for a content security policy, we can see that single directives still make up a large proportion of all requests. 19% of all desktop requests are set only to `upgrade-insecure-requests`. 8% of all desktop requests are set to `frame-ancestors 'self'` and 23% of all desktop requests are set to the value of `block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;` which mixes together the top 3 most common CSP directives.

The content security policy often has to allow content from other origins than its own in order to support loading of media such as fonts, ad related scripts, and general content delivery network usage. As such, the top 10 origins across requests are as follows:

<figure>
  <table>
    <thead>
      <tr>
        <th>Host</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a href="https://www.google-analytics.com" rel="nofollow">https://www.google-analytics.com</a></td>
        <td class="numeric">0.39%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><a href="https://www.googletagmanager.com" rel="nofollow">https://www.googletagmanager.com</a></td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.25%</td>
      </tr>
      <tr>
        <td><a href="https://fonts.gstatic.com" rel="nofollow">https://fonts.gstatic.com</a></td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td><a href="https://fonts.googleapis.com" rel="nofollow">https://fonts.googleapis.com</a></td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.18%</td>
      </tr>
      <tr>
        <td><a href="https://www.google.com" rel="nofollow">https://www.google.com</a></td>
        <td class="numeric">0.24%</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td><a href="https://www.youtube.com" rel="nofollow">https://www.youtube.com</a></td>
        <td class="numeric">0.21%</td>
        <td class="numeric">0.15%</td>
      </tr>
      <tr>
        <td><a href="https://stats.g.doubleclick.net" rel="nofollow">https://stats.g.doubleclick.net</a></td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td><a href="https://connect.facebook.net" rel="nofollow">https://connect.facebook.net</a></td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td><a href="https://www.gstatic.com" rel="nofollow">https://www.gstatic.com</a></td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td><a href="https://cdnjs.cloudflare.com" rel="nofollow">https://cdnjs.cloudflare.com</a></td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.11%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most common allowed hosts in CSPs.",
      sheets_gid="106248959",
      sql_file="csp_allowed_host_frequency.sql",
    ) }}
  </figcaption>
</figure>

The above hosts account for roughly the same positioning in rank as was reported last year, but the usage is up slightly.

The CSP security standard is widely supported both by web browsers, as well as content delivery networks and content management systems and is a highly recommended tool for websites and web applications in defense of web security vulnerabilities.

### Subresource Integrity

Another defense-in-depth tool is Subresource Integrity which provides a web security defensive layer against content tampering. Whereas a Content Security Policy defines which types and source of content are allowed, a Subresource Integrity mechanism ensures that said content hasn't been modified for malicious intents.

A reference use-case for using Subresource Integrity is when loading JavaScript content from third-party package managers which also act as a CDN. Some examples of these are unpkg.com or cdnjs.com, both of which serve the content source for JavaScript libraries.

If a third-party library could be compromised due to a hosting issue by the CDN provider, or by one of the project's contributors or maintainers then you are effectively loading someone else's code into your website.

Similar to CSP's use of a `nonce-`, Subresource Integrity (also known as SRI) allows browsers to validate the content that is served matches a cryptographically signed hash and prevents tampering with the content, whether over the wire or at its source.

{{ figure_markup(
  content="20%",
  caption="Desktop sites using SRI.",
  classes="big-number",
  sheets_gid="953586778",
  sql_file="sri_usage.sql",
) }}

Just about one of every fifth website (20%) adopts a subresource integrity in one of its webpage elements on desktop. Out of these, 83% were specifically used in `<script>` type elements on desktop, and 17% were used in `<link>` type  elements in desktop requests.

At a per page coverage, adoption rate for the SRI security feature is still considerably low. Last year, the median percentage for both mobile and desktop was 3.3% and this year it decreased by 2% to 3.23%.

Subresource integrity is specified as a base64 string of a computed hash of one of SHA256, SHA384 or SHA512 cryptographic functions. As a use-case reference, developers can implement them as follows:

```html
<script src="https://example.com/example-framework.js"
  integrity="sha384-oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
        crossorigin="anonymous"></script>
```

Consistent with last year's report, SHA384 continues to demonstrate the majority of SRI hash types observed between all available hash functions.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

CDNs are no strangers to Subresource Integrity and provide secure defaults to their consumers by including a Subresource Integrity value as part of their URL references for content to be served on the page.

The following list shows the top 10 most common hosts for which a subresource integrity value has been observed. Notable changes from last year are the Cloudflare hosts jumping from position 4 to position 3, and jsDelivr jumping from position 7 to position 6 in ranking, surpassing Bootstrap's hosts rankings.

<figure>
  <table>
    <thead>
      <tr>
        <th>Host</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`www.gstatic.com`</td>
        <td class="numeric">39%</td>
        <td class="numeric">40%</td>
      </tr>
      <tr>
        <td>`cdn.shopify.com`</td>
        <td class="numeric">22%</td>
        <td class="numeric">23%</td>
      </tr>
      <tr>
        <td>`cdnjs.cloudflare.com`</td>
        <td class="numeric">8%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>`code.jquery.com`</td>
        <td class="numeric">7%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>`static.cloudflareinsights.com`</td>
        <td class="numeric">5%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td>`cdn.jsdelivr.net`</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>`t1.daumcdn.net`</td>
        <td class="numeric">3%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>`stackpath.bootstrapcdn.com`</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>`maxcdn.bootstrapcdn.com`</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most popular hosts using SRI.",
      sheets_gid="998292064",
      sql_file="sri_popular_hosts.sql",
    ) }}
  </figcaption>
</figure>

### Permissions Policy

Browsers are becoming more and more powerful with time, adding more native APIs to access and control different sorts of hardware and feature sets that are made available to websites. These also introduce potential security risks to users through misuse of said features, such as malicious scripts turning on a microphone and collecting data, or fingerprinting geolocation of a device to collect location information.

Previously known as `Feature-Policy`, and now named `Permissions-Policy`, this is an experimental browser API that enables control to an allowlist and a denylist of a wide array of capabilities a browser is able to access.

We've noticed a high correlation of usage for the `Permissions-Policy` with HTTPS-enabled connections (97%), with `X-Content-Type-Options` (82%), and `X-Frame-Options` (78%). All correlations are across desktop requests. Another high correlation is within the specific technology intersection, observed for Google My Business mobile pages (99%), and the next closest is Acquia's Cloud Platform (67%). All correlations are across mobile requests.

{{ figure_markup(
  content="+85%",
  caption="Increase in adoption of `Permissions-Policy` on mobile sites.",
  classes="big-number",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql",
) }}

We're seeing an 85% relative increase in adoption for `Permissions-Policy` from 2021's data (1.3%) to 2022's data (2.4%) for mobile requests and similar trend for desktop requests too. The deprecated `Feature-Policy` shows a minuscule increase of 1 percentage point between last year's data and this year's which demonstrates that users are keeping pace with web browsers' specification changes.

Besides being used as an HTTP header, this feature can be used within `<iframe>` elements as follows:

```html
  <iframe src="https://example.com" allow="geolocation 'src' https://example.com'; camera *"></iframe>
```

18.9% of 11.5 million frames in mobile contained the `allow` attribute to enable permission or feature policies.

The following is a list of the top 10 `allow` directives that were detected in frames:

<figure>
  <table>
    <thead>
      <tr>
        <th>Directive</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`encrypted-media`</td>
        <td class="numeric">75%</td>
        <td class="numeric">75%</td>
      </tr>
      <tr>
        <td>`autoplay`</td>
        <td class="numeric">48%</td>
        <td class="numeric">49%</td>
      </tr>
      <tr>
        <td>`picture-in-picture`</td>
        <td class="numeric">31%</td>
        <td class="numeric">31%</td>
      </tr>
      <tr>
        <td>`accelerometer`</td>
        <td class="numeric">26%</td>
        <td class="numeric">27%</td>
      </tr>
      <tr>
        <td>`gyroscope`</td>
        <td class="numeric">26%</td>
        <td class="numeric">27%</td>
      </tr>
      <tr>
        <td>`clipboard-write`</td>
        <td class="numeric">21%</td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td>`microphone`</td>
        <td class="numeric">9%</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>`fullscreen`</td>
        <td class="numeric">8%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>`camera`</td>
        <td class="numeric">6%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>`geolocation`</td>
        <td class="numeric">5%</td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top 10 `allow` directives in iframes.",
      sheets_gid="1848560369",
      sql_file="iframe_allow_directives.sql",
    ) }}
  </figcaption>
</figure>

Interesting to point out are places 11th, 12th and 13th allow directives for mobile that didn't make it into the above list and they are `vr` with 6%, `payment` with 2%, and `web-share` with 1%. They perhaps speak of growing trends we're seeing in the industry around virtual reality (and the metaverse, if you will), online payments and the fintech industry. Lastly, it seems to indicate better support for web-based sharing which is presumably due to the rise of work-from-home habits in the last couple of years.

### Iframe Sandbox

Using iframe elements in websites has been a long-time practice for developers in order to easily embed third-party content such as rich media, cross-application components, or even ads. Some may even assume that iframe elements form a security boundary between the website embedding them to the sourced website, however that's not exactly the case.

HTML `<iframe>` elements by default have access to top-level page capabilities such as pop-ups or direct interaction with the top-page browser navigation. For example, the following code could be embedded in the source of an iframe element which makes use of active user gestures and results in the hosting website of the iframe to  navigate to a new URL at `https://example.com`:

```js
function clickToGo() {
  window.open('https://example.com')
}
```

This is largely known as a clickjacking attack and is one of many other security risks that are embedded within iframes (pun intended).

To mitigate these concerns the HTML specification (version 5) introduced the `sandbox` attribute that may be applied to iframe elements. It acts as an allowlist and if kept empty it essentially does not enable any capabilities within the iframe element. This results in no access to page interactivity like pop-ups, no permissions to run JavaScript code, and no access to cookies.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The above chart of the 2022 data shows that more than 99% of websites with a `sandbox` attribute enable the `allow-scripts` and `allow-same-origin` permissions.

Of desktop websites that embed an iframe, 35.2% also include the `sandbox` attribute.

We find that `Content-Security-Policy` headers which include a `sandbox` directive are at a mere 0.3% usage for mobile (desktop is similar at 0.4%) which may speak to the fact that this attribute is only applied on a per-case basis for the practice of embedding iframe content within pages, rather than ahead-of-time planning through a content security policy definition.

## Attack preventions

There are many different attacks that can exploit a website, and it's almost never possible to fully secure your website. However, there are many steps that a web developer can take to prevent most of these attacks, or to limit the effects of them on the users.

### Security header adoptions

Security headers are one of the most common ways of preventing attacks by restricting the kind of traffic and data flow. But most of these security headers have to be set manually by website developers. Thus, the presence of security headers are often a good indication of the security hygiene that the developers of the website follow.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The most widely used security mechanism is still the X-Content-Type-Options header, which is used on 40% of the websites we crawled on mobile, to protect against MIME-sniffing attacks. This header is followed by the X-Frame-Options header, which is enabled on 30% of all sites. We don't see much difference from last year's data with a gradual increase in adoption of all the security headers but the ranking of security headers by percentage usage is the same.

### Preventing attacks using CSP

The main use of Content Security Policy (CSP) is to determine the trusted sources from which content can be loaded safely. This makes CSP a really useful security header in preventing various kinds of attacks such as clickjacking, cross-site scripting attacks, mixed-content inclusion and many more.


{{ figure_markup(
  content="53%",
  caption="Mobile websites with CSP containing a `frame-ancestors` directive.",
  classes="big-number",
  sheets_gid="1303493233",
  sql_file="csp_directives_usage.sql",
) }}

One of the common ways to prevent clickjacking attacks is to prevent the browser from loading the website in a frame. One can use the [`frame-ancestors`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/frame-ancestors) directive in a CSP Header to restrict other domains from including the page content in a frame. We found 53% of the websites in mobile that have CSP have a `frame-ancestor` directive. It's the second most used CSP directive, which is good for prevention of clickjacking attacks. Setting the value of `frame-ancestors` directive to `none` or `self` is the safest. `none` doesn't allow any domain to frame the content, while `self` allows only the origin domain to frame the contents. We found that 8% of websites in mobile which have a CSP header have only `frame-ancestors 'self'` and is the third most common value of CSP header.

<figure>
  <table>
    <thead>
      <tr>
        <th>Keyword</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`nonce-`</td>
        <td class="numeric">12%</td>
        <td class="numeric">14%</td>
      </tr>
      <tr>
        <td>`unsafe-inline`</td>
        <td class="numeric">94%</td>
        <td class="numeric">95%</td>
      </tr>
      <tr>
        <td>`unsafe-eval`</td>
        <td class="numeric">80%</td>
        <td class="numeric">78%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="CSP script-src attribute usage.",
      sheets_gid="323360740",
      sql_file="csp_script_source_list_keywords.sql",
    ) }}
  </figcaption>
</figure>

One of the mechanisms to defend against XSS attacks is by setting a restrictive `script-src` directive for the website. This ensures that JavaScript is loaded only from a trusted source and the attacker cannot inject some malicious code. `strict-dynamic` is gradually gaining more adoption across websites with 6% websites in desktop using it compared to 5% of websites last year. `strict-dynamic` is helpful if you have a root script in your HTML that dynamically loads or injects other script files. It makes use of nonce or hash on the root script and ignores other allowlists like `unsafe-inline` or individual links. It's supported in all modern browsers apart from IE. Also, we see that `unsafe-inline` and `unsafe-eval` usage has decreased by approximately 2% from last year. This is a step in the right direction.

### Preventing attacks using Cross-Origin policies

Cross Origin policies are one of the main mechanisms used to defend against micro-architectural attacks like Cross Site leaks. XS-Leaks are kind of similar to Cross Site Request Forgery, however they infer small pieces of information about the user which are exposed during interactions between websites.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

`Cross-Origin-Resource-Policy` is present on 114,111(1.46%) websites in mobile and is the most used cross origin policy. It is used to indicate to the browser whether a resource should be included from cross-origin or not. `Cross-Origin-Embedder-Policy` is now present in 2,559 websites compared to 911 websites last year. We see a similar growth in the adoption of `Cross-Origin-Opener-Policy` as well with 34,968 websites in mobile now having the header compared to 15,727 sites last year. So there is a steady growth in the adoption of all the cross-origin policies, which is great because they can be really helpful in preventing XS-Leak attacks.

### Preventing attacks using Clear-Site-Data

Clear-Site-Data provides web developers more control over clearing of user data related to their website. For example, a web developer can now make decisions such that when a user signs out of their web site, then all related cookie, cache, storage information about the user can be removed. This helps in limiting the consequences of an attack by having a restricted amount of data stored in the browser when not needed. This is a comparatively new header which is restricted only for sites served over HTTPS and only some of the features are supported by browsers. There were only 75 sites in mobile which had `Clear-Site-Data` header in 2021 and it has increased to 428 this year.

<figure>
  <table>
    <thead>
      <tr>
        <th>csd_header</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>cache</td>
        <td class="numeric">65%</td>
        <td class="numeric">63%</td>
      </tr>
      <tr>
        <td><code class="notranslate">*</code></td>
        <td class="numeric">9%</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>"cache"</td>
        <td class="numeric">7%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>cookies</td>
        <td class="numeric">3%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>"storage"</td>
        <td class="numeric">2%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>cache,cookies,storage</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>"cache", "storage"</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>*</td>
        <td class="numeric">1%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>"cache", "cookies"</td>
        <td class="numeric">1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>"cookies"</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most common Clear Site Data directives.",
      sheets_gid="1206925009",
      sql_file="clear-site-data_value_prevalence.sql",
    ) }}
  </figcaption>
</figure>

`cache` is the most prevalent directive (63% websites in mobile) for Clear-Site-Data which could mean that many developers are using this security header more for clearing cache to probably load newer static files, than for privacy and security of the user. But directives are supposed to follow quoted-string grammar and hence this directive is invalid. It is great to see that 9% of mobile websites using this header use "*" which means that they indicate the browser to clear all user data stored. Third most used directive is again `"cache"`, but used properly this time.

### Preventing attacks using `<meta>`

A `Content-Security-Policy` and `Referrer-Policy` can be set using a `<meta>` tag in the HTML code itself for a website. For example, one can set `Content-Security-Policy` using the code: `<meta http-equiv="Content-Security-Policy" content="default-src 'self'">`. We found that 0.47% and 2.60% of the websites in mobile enabled CSP and Referrer-Policy this way.

<figure>
  <table>
    <thead>
      <tr>
        <th>&nbsp;</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>include Referrer-policy</td>
        <td class="numeric">3.11%</td>
        <td class="numeric">2.60%</td>
      </tr>
      <tr>
        <td>include CSP</td>
        <td class="numeric">0.55%</td>
        <td class="numeric">0.47%</td>
      </tr>
      <tr>
        <td>include not-allowed policy</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="`<meta>` security feature usage.",
      sheets_gid="2049304175",
      sql_file="meta_policies_allowed_vs_disallowed.sql",
    ) }}
  </figcaption>
</figure>

The issue with preventing attacks using `<meta>` tag is if you set any other security headers using it, then the browser will ignore that security header. For example, 2,815 sites had `X-Frame-Options` in the `<meta>` tag. So the developer might be expecting the website to be secure against certain attacks since they added the `<meta>` tag when in reality, that security header never gets added. However, this number has gone down from 3,410 sites last year, so maybe websites are fixing this misuse of the `<meta>` tag.

### Web Cryptography API

Web Cryptography API is a JavaScript API for performing basic cryptographic operations on a website such as random number generation, hashing, signing, encryption and decryption.

<figure>
  <table>
    <thead>
      <tr>
        <th>Feature</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`CryptoGetRandomValues`</td>
        <td class="numeric">69.6%</td>
        <td class="numeric">65.5%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoDigest`</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmSha256`</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoImportKey`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoGenerateKey`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoEncrypt`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoExportKey`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmAesGcm`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Web Cryptography API usage.",
      sheets_gid="971581635",
      sql_file="web_cryptography_api.sql",
    ) }}
  </figcaption>
</figure>

There is not much change in the data from last year. `CryptoGetRandomValues` continues to be the most adopted feature (even though its usage has dropped by approximately 1% since last year) because of its use in generating strong pseudo-random numbers. Its high usage is attributable to being used in common services such as Google Analytics.

### Bot protection services

The internet today is filled with bots, and hence there is a constant rise in bad bot attacks. According to <a hreflang="en" href="https://www.imperva.com/resources/reports/2022-Imperva-Bad-Bot-Report.pdf">2022 Bad Bot Report</a> by Imperva, 27.7% of all internet traffic was by bad bots. Bad bots are the ones which try to scrape data and exploit it. According to the report, the end of 2021 saw a surge in bad bot attacks probably because of the log4j vulnerability which is exploitable by bots.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

Our analysis shows that 29% of desktop websites and 26% of mobile websites use a mechanism to fight malicious bots which is a significant increase from last year (11% and 10% respectively). This increase could be because of Cloudflare Bot Management which is a captcha-free solution for protection against bad bots. Last year's data crawl didn't track this, but identifying this was added this year and we see 6% of websites on mobile using it. Usage of reCaptcha has also increased from last year on both desktop and mobile by approximately 9%.

## Drivers of security mechanism adoption

There are multiple driving factors for a website to adopt more security practices. The three primary ones ares:
Societal: more security-oriented education in certain countries, or laws that take more punitive measures in case of a data breach
Technological: it might be easier to adopt security features in certain technology stacks, or certain vendors might enable security features by default
Popularity: widely popular websites may face more targeted attacks than a website that is little known

### Location of website

Location of the website, where the website developers are based or where the website is hosted can often have impacts on adoption of security features. This can be because of the awareness among developers being different, but can also be because of the laws of the country mandating adoption of certain security practices.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

We see a lot of new countries like Nigeria, Norway and Denmark quickly rise to the top in the adoption of HTTPS. It's a good sign to see new countries also adopting widespread security practices because that can be an indication of rising awareness everywhere. Also, the difference between the least adoption and most adoption of HTTPS is reducing, which shows that almost all countries at least strive to have HTTPS by default on their websites.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The adoption of CSP and X-Frame-Options (XFO) is very similar to last year. Surprisingly, we see websites in Indonesia have started adopting CSP a lot, even though their adoption of HTTPS continues to be low. The adoption of CSP still seems to be very varied across countries but the gap between adoption of XFO is gradually decreasing. More countries need to increase the adoption of CSP since it is a very important security feature that protects against a varied number of attacks.

### Technology stack

Another factor that can strongly influence the adoption of certain security mechanisms is the technology stack that's being used to build a website. In some cases, security features may be enabled by default, for example, in content management systems.

<figure>
  <table>
    <thead>
      <tr>
        <th>Technology</th>
        <th>Security features</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Blogger</td>
        <td>Content-Security-Policy(99%)<br>X-Content-Type-Options(99%)<br>X-Frame-Options(99%)<br>X-XSS-Protection(99%)</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td>Strict-Transport-Security(99%)<br>X-Content-Type-Options(99%)</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td>X-Content-Type-Options(77%)<br>X-Frame-Options(77%)</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td>Strict-Transport-Security(91%)<br>X-Content-Type-Options(98%)</td>
      </tr>
      <tr>
        <td>Google Sites</td>
        <td>Content-Security-Policy(96%)<br>Cross-Origin-Opener-Policy(96%)<br>Referrer-Policy(96%)<br>X-Content-Type-Options (97%)<br>X-Frame-Options(97%)<br>X-XSS-Protection(97%)</td>
      </tr>
      <tr>
        <td>Plone</td>
        <td>X-Frame-Options(60%)</td>
      </tr>
      <tr>
        <td>Wagtail</td>
        <td>X-Content-Type-Options(51%)<br>X-Frame-Options(72%)</td>
      </tr>
      <tr>
        <td>Medium</td>
        <td>Content-Security-Policy(75%), Expect-CT(83%)<br>Strict-Transport-Security(84%)<br>X-Content-Type-Options(83%)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Security feature adoption by technology.",
      sheets_gid="2004939103",
      sql_file="feature_adoption_by_technology.sql",
    ) }}
  </figcaption>
</figure>

Above we see some of the common CMS and blogging sites. A common pattern that we see with sites that provide very little customization and focus more on content editing, like Wix, Squarespace and Medium, is they have basic security features by default such as `Strict-Transport-Security`. Content management systems like Wagtail, Plone and Drupal have very bare minimum security features, since they are often used by developers to set up the website and hence the responsibility to add security features are more on developers. We also see that websites using Google Sites have many security features by default.

### Website popularity

Websites that have many visitors may be more prone to targeted attacks given that there are more users with potentially sensitive data to attract attackers. Therefore, it can be expected that widely visited websites invest more in security in order to safeguard their users.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

We found that `Strict-Transport-Security`, `X-Frame-Options`, and `X-Content-Type-Options` always have more adoption for websites which are more popular. 56.8% of the top 1000 websites in mobile have Strict-Transport-Security, which means these websites care more about serving their content and data only via HTTPS. The less popular websites might have HTTPS enabled, but often seem to not add a `Strict-Transport-Security` header to ensure that their website is always served over HTTPS. The numbers this year are pretty consistent with last year's findings.

## Malpractices on the web

Cryptocurrencies continued to grow in popularity this year with more types available for various use cases. With that continued growth and existing economic incentive, cybercriminals have consistently leveraged this to their advantage via [cryptojacking](https://en.wikipedia.org/wiki/Cryptojacking). However the use of crypto miners has overall trended downward since last year. What seems to occur is certain vulnerability events that enable attackers to inject crypto miners into systems on both desktop and mobile triggers a spike in their usage:

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

As an example, around July and August of 2021, there were reports of several cryptojacking campaigns and vulnerabilities1,2,3 which could be the cause for the spikes in cryptominers found in websites around that time. More recently, in April of 2022 hackers attempted to leverage the SpringShell vulnerability to set up and run crypto miners.

Getting into the specifics of the cryptominers found in use among websites on both desktop and mobile we found that the share among miners has spread from last year. For example, Coinimp's share has shrunk since last year by about 24% while Minero.cc has grown by about 11%.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

These results suggest that cryptojacking continues to be a serious attack vector each year with usage spikes based on newly emerged vulnerabilities that enable them. Therefore proper diligence is still required in order to mitigate risks in this space.

Note that not all of these websites are infected. Website operators may also deploy this technique (instead of showing ads) to finance their website. But the use of this technique is also heavily discussed technically, legally, and ethically.

Please also note that our results may not show the actual state of the websites infected with cryptojacking. Since we run our crawler once a month, not all websites that run a cryptominer can be discovered. This is the case, for example, if a website remains infected for only X days and not on the day our crawler ran.

## Well-known URIs

Well-known URIs are used to designate specific locations to data or services related to the overall website. A well-known URI is a URI whose path component begins with the characters "/.well-known/"

### `security.txt`

`security.txt` is a file format for websites to provide a standard for vulnerability reporting. Website providers can provide contact details, PGP key, policy, and other information in this file. White hat hackers and penetration testers can use this information to conduct security analyses on these websites and report a vulnerability.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The percentage of `security.txt` URIs with the `expires` property has increased from 0.7% to 2.3% this year. The `expires` property is a required property based on the standard, so it is good to see more websites adhering to the standard. `policy` continues to be the most popular property in a `security.txt` URI. `policy` is very essential in a `security.txt` URI since it describes the steps to be followed by a security researcher to report a vulnerability.

### `change-password`

The `change-password` well-known URI is a specification under the webappsec working group of W3C which is in editor's draft state right now. This specific well-known URI was suggested as a way for users and softwares to easily identify the link to be used for changing passwords.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

The adoption of this well-known URI is still pretty low. The specification is still work-in-progress so it's understandable that not many websites have started adopting it. Also, not all websites will have a change-password form, especially if they don't have a sign-in system for their website.

### Detecting Status Code Reliability

This particular `well-known` URI determines the reliability of a website's HTTP response status code. This URI is also still in editor's draft state and may change in the future. The idea behind this `well-known` URI is that it should never exist in any website. So this `well-known` URI should never respond with an `ok-status`. If it redirects and returns an "ok-status", that means the website's status codes are not reliable.

{{ figure_markup(
  image="TODO.png",
  caption="TODO.",
  description="TODO.",
  chart_url="TODO",
  sheets_gid="TODO",
  sql_file="TODOsql",
) }}

We found that 84% of websites in both mobile and desktop respond with a not-ok status for this well-known URI. The good thing about this specification is if websites are correctly configured, this specification should automatically work and won't need website developers to make any specific changes.

## Conclusion

Our analysis this year shows that websites are continuing to make improvements in their security features like we have seen over the past years. It's also exciting to see that many countries who were behind on web security adoptions are increasing their usage. This could mean that awareness around web security in general is increasing.

We found that web developers are also slowly adopting new standards and replacing the old ones. This is definitely a step in the right direction. The importance of security and privacy on the internet is growing everyday. The web keeps becoming an integral part of life for many people and hence, web developers should continue to increase the usage of web security features.

There's still a lot of progress that we need to do in setting stricter Content Security Policy. Cross-site scripting continues to be in OWASP Top 10. There needs to be wider adoption of stricter `script-src` directives to prevent such attacks. Also, more developers can look into taking advantage of Web Cryptography API. Similar efforts need to be made in adopting well-known URIs like security.txt. Not only does it provide a way for security professionals to report vulnerabilities in the website, but it also shows that the developers care about the website's security and are open to making improvements.

It's encouraging to observe the continuous progress in usage of web security over the past years, but the web community needs to continue researching and adopting more security features since the web continues to grow and security becomes more crucial.

