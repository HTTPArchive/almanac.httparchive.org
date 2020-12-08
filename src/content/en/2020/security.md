---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 11
title: Security
description: Security chapter of the 2020 Web Almanac covering transport layer security, content security (CSP, feature policy, SRI), web defense mechanisms (tackling XSS, XS-Leaks), and update practices of widely used technologies.
authors: [tomvangoethem, nrllh, bazzadp]
reviewers: [cqueern, bazzadp, edmondwwchan]
analysts: [tomvangoethem]
translators: []
#nrllh_bio: TODO
#tomvangoethem_bio: TODO
bazzadp_bio: Barry Pollard is a software developer and author of the Manning book <a href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a>. He thinks the web is amazing but wants to make it even better. You can find him tweeting <a href="https://twitter.com/tunetheweb">@tunetheweb</a> and blogging at <a href="https://www.tunetheweb.com">www.tunetheweb.com</a>.
discuss: 2047
results: https://docs.google.com/spreadsheets/d/1T7sxPP5BV3uwv-sXhBEZraVk-obd0tDfFrLiD49nZC0/
queries: 11_Security
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---
## Introduction

In many ways, 2020 has been an extraordinary year. As a result of the global pandemic, our day-to-day lives have changed drastically: instead of meeting in person with friends and family, many have to rely on social media to keep in touch. This has led to significant [increases in traffic volumes](https://dl.acm.org/doi/pdf/10.1145/3419394.3423621) for [many different applications](https://arxiv.org/pdf/2008.10959.pdf), caused by the increased amount of time that users spend online. This also means that security has never been more important to ensure that the information we share online on various platforms remains secure.

Many of the platforms and services that we use on a daily basis strongly rely on web resources, ranging from cloud-based APIs, microservices and most importantly, web applications. Keeping these systems secure is a non-trivial task. Fortunately, throughout the past decade, web security research has been continuously advancing, on the one hand discovering new types of attacks and sharing the results with the wider community to raise awareness. On the other hand, many engineers and developers have been tirelessly working to provide website operators with the right set of tools and mechanisms that can be used to prevent or minimize the consequences of attacks.

In this chapter, we explore the current state-of-practice for security on the Web. By analyzing the adoption of various security features in depth and at a large scale, we gather insights on the different ways that website owners apply these security mechanisms, driven by the incentive to protect their users. However, we not only look at the adoption of security mechanisms in individual websites. We analyze how different factors, such as the technology stack that is used to build the site, affect the prevalence of security headers, and thus improve overall security. Furthermore, because ensuring that a website is secure requires a holistic approach covering many different facets, we also evaluate other aspects, such as the patching practices for various widely used web technologies. Finally, we report on how security on the web has evolved in the last year and provide an outlook for what is yet to come.

## Transport security

The last year has seen a continuation of the growth of HTTPS on websites. Securing the transport layer is a basic part of web security–unless you can be confident the resources downloads for this website have not been altered in transit, and that you are transporting data to and from the website you think you are, any certainties about the website security are basically rendered null and void.

Moving our web traffic to HTTPS, and eventually [marking HTTP as non-secure](https://www.chromium.org/Home/chromium-security/marking-http-as-non-secure) is being driven by web browsers only allowing [powerful new features to the secure context](https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts/features_restricted_to_secure_contexts) (the carrot)while also increasing warnings dhoen to users when unencrypted connections are used (the stick), whiles at the same time.

The effort is paying off hugely and we are now seeing 87.70% of requests on desktop and 86.90% of requests on mobile being served over HTTPS.

{{ figure_markup(
  caption="The percentage of requests that use HTTPS on mobile.",
  content="86.90%",
  classes="big-number",
  sheets_gid="1558058913"
)
}}

One slight concern as we reach the end of this goal, is a noticeable "leveling off" of the the impressive growth of the last few years. Unfortunately the long tail of the internet means older legacy sites are not maintained and may never be run over HTTPS, meaning they will eventually become inaccessible to most users.

{{ figure_markup(
  image="security-https-request-growth.png",
  alt="Percentage of requests using HTTPS",
  caption='Percentage of requests using HTTPS.<br>(Source: <a href="https://httparchive.org/reports/state-of-the-web#pctHttps">HTTP Archive</a>)',
  description="Time series chart of HTTPS request from 1st January 2017 until the 1st August 2020. Mobile and desktop usage is almost identical and starts at 35.70% of requests for desktop and 35.20% for mobile and increases all the way up to 87.70% for desktop and 86.90% for mobile with a slight tailing off at the end.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1353660053&format=interactive",
  sheets_gid="1558058913"
  )
}}

Whilst the high volume of requests is encouraging, these can often be dominated by [third-party](./third-party) requests and services like Google Analytics, fonts or advertisements. Websites themselves can lag, but again we see encouraging use with between 73% and 77% of sites now being served over HTTPS.

{{ figure_markup(
  image="security-https-usage-by-site.png",
  caption="HTTPS usage for sites",
  description="Bar chart showing 77.44% of desktop sites are using HTTPS, with the remaining 22.56% using HTTP, while 73.22% of mobile sites are using HTTPS while the remaining 26.78% using HTTP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=103775737&format=interactive",
  sheets_gid="1558058913",
  sql_file="TODO.sql"
  )
}}

### Protocol versions

As HTTPS is now well past being the norm, the challenge moves from having any HTTPS, to ensuring that secure versions of the underlying TLS (Transport Layer Security) protocol are being used. TLS needs maintenance as versions become older and vulnerabilities are found.

{{ figure_markup(
  image="security-tls-version-by-site.png",
  caption="TLS versions usage for sites",
  description="Bar chart showing that on desktop 55.98% of sites use TLSv1.2, while 43.23% use TLSv1.3. On mobile the figures are 53.82% and 45.37% respectively. TLSv1.0, TLSv1.1 barely register though there is a very small amount of QUIC usage (0.62% on desktop and 0.67% on mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=840326541&format=interactive",
  sheets_gid="1486844039",
  sql_file="tls_versions_pages.sql"
  )
}}

It's still surprising to us, that TLSv1.0 usage is basically zero and pleasing that the public web at least has embraced more secure protocols so definitely. These figures are a slight improvement on [last year's protocol analysis](../2019/security#protocol-versions)  with an approximately 5% increase in TLSv1.3 usage, and the corresponding drop in TLSv1.2. That seems a small increase and it would seem like the high usage noted last year was likely due to the initial support from large CDNs, and making a significant more progress in TLSv1.3 adoption will likely take a long time as those still using TLSv1.2 are likely managing this themselves or with a basic hosting provider that does not yet support this.

### Cipher suites

Within TLS there are a number of cipher suites that can be used with varying levels of security. The best ciphers support [forward secrecy](https://en.wikipedia.org/wiki/Forward_secrecy) key exchange, meaning even if the servers keys are compromised, old traffic that used those keys cannot be decrypted.

{{ figure_markup(
  caption="Mobile sites using forward secrecy.",
  content="98.03%",
  classes="big-number",
  sheets_gid="1643542759",
  sql_file="tls_forward_secrecy.sql"
)
}}

All sites should be using forward secrecy ciphers and it is pleasing to see 98.14% of desktop sites and 98.03% of mobile sites using ciphers with forward secrecy. In the past, newer versions of TLS added support for newer ciphers but rarely removed older versions. This is one of the reasons TLSv1.3 is more secure as it does a large clear down of older ciphers leaving only five secure ciphers all of which support forward secrecy. This prevents downgrade attacks where a less secure cipher is forced to be used.

After this the main choice is between the level of encryption - higher key sizes will take longer to break, but at the cost of more compute intensive to encrypt and decrypt the connection–particularly for initial connection. For the [block cipher mode](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation) GMC should be used and [CBC is considered weak due to padding attacks](https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities).

For key size 128-bit and 256-bit encryption are common for the widely supported Advanced Encryption Standard (AES), and while 256-bit is more secure, 128-bit is still sufficient for most sites, though 256-bit would be preferred.

{{ figure_markup(
  image="security-distribution-of-cipher-suites.png",
  caption="Distribution of cipher suites",
  description="Bar chart showing the cipher suites used by device, with AES_128_GCM is the most common and is used by 78.4% of desktop and mobile sites, AES_256_GCM is used by 19.1% of desktop and 18.5% of mobile sites, AES_256_CBC used by 1.44% of desktop sites nd 1.86% of mobile sites, CHACHA20_POLY1305 is used by 0.66% and 0.72% of siters respectively, AES_128_CBC is used by 0.43% and 0.44% respectively, and 3DES_EDE_CBC is used by 0.01% of desktop and approximately 0.0% of mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1464905386&format=interactive",
  sheets_gid="1919501829",
  sql_file="tls_cipher_suite.sql"
  )
}}

We can see from the above chart that AES_128_GCM is the most common and is used by 78.4% of desktop and mobile sites. AES_256_GCM is used by 19.1% of desktop and 18.5% of mobile sites with the other sites likely being the ones on older protocols and cipher suites.

One important point to note is that our data is based on running Chrome to connect to a site, and it will use a single protocol cipher to connect. Our [methodology](./methodology) does not allow us to see the full range of protocols and cipher suites supported, and only the one actually used for that connection. For that we need to look at other sources like [SSL Pulse from SSL Labs](https://www.ssllabs.com/ssl-pulse/), but with most modern browsers now supporting similar TLS capabilities the above data is what we would expect the vast majority of users to use.

## Certificate Authorities

Next we will look at the Certificate Authorities (CAs) issuing the TLS certificates used by the sites we have crawled.

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
        <td>Let's Encrypt Authority X3</td>
        <td class="numeric">44.65%</td>
        <td class="numeric">46.42%</td>
      </tr>
      <tr>
        <td>Cloudflare Inc ECC CA-3</td>
        <td class="numeric">8.49%</td>
        <td class="numeric">8.69%</td>
      </tr>
      <tr>
        <td>Sectigo RSA Domain Validation Secure Server CA</td>
        <td class="numeric">8.27%</td>
        <td class="numeric">7.91%</td>
      </tr>
      <tr>
        <td>cPanel, Inc. Certification Authority</td>
        <td class="numeric">4.71%</td>
        <td class="numeric">5.06%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">4.30%</td>
        <td class="numeric">3.66%</td>
      </tr>
      <tr>
        <td>Amazon</td>
        <td class="numeric">3.12%</td>
        <td class="numeric">2.85%</td>
      </tr>
      <tr>
        <td>DigiCert SHA2 Secure Server CA</td>
        <td class="numeric">2.04%</td>
        <td class="numeric">1.78%</td>
      </tr>
      <tr>
        <td>RapidSSL RSA CA 2018</td>
        <td class="numeric">2.01%</td>
        <td class="numeric">1.96%</td>
      </tr>
      <tr>
        <td>CloudFlare Inc ECC CA-2</td>
        <td class="numeric">1.95%</td>
        <td class="numeric">1.70%</td>
      </tr>
      <tr>
        <td>AlphaSSL CA - SHA256 - G2</td>
        <td class="numeric">1.35%</td>
        <td class="numeric">1.30%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 10 certificate issuers for websites.", sheets_gid="1486167130", sql_file="tls_ca_issuers_pages.sql.sql") }}</figcaption>
</figure>

It is no surprise to see Let's Encrypt well in the lead easily taking the top spot improving on its [number two position last year](../2019/security#certificate-authorities). Its combination of free and automated certificates is proving a winner with both individual website owners and platforms. Cloudflare similarly offers free certificates for its customers taking the number two and number nine position. What is more interesting there is that it is the ECC Cloudflare issuer that is being used. ECC certificates are smaller and so more efficient than RSA certificates but can be complicated to deploy as support is universal and managing both certificates often requires extra effort. This is the benefit of a CDN or hosted provider if they can manage this for you like Cloudflare does here. Browsers that supporting ECC (like the Chrome browser we use in our crawl) will use that, and older browsers will use RSA.

{# TODO finish this out:

Browser enforcement
HTTP Strict-Transport-Security
Secure attribute on cookies
__Secure- prefix on cookies
Flawed configurations
Mixed content


#}



## Cookies

From a security point of view, the (automatic) inclusion of cookies in cross-site requests can be seen as the main culprit of several classes of vulnerabilities. If a website does not have the adequate protections is place (e.g. requiring a unique token on state-changing requests), they may be susceptible to [Cross-Site Request Forgery](https://owasp.org/www-community/attacks/csrf) (CSRF) attacks, where an attacker issues a POST request to for instance change the password of an unwitting visitor. Several other types of attacks rely on the inclusion of cookies in third-party, such as [Cross-Site Script Inclusion](https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-lekies.pdf) (XSSI) and various techniques in the [XS-Leaks](https://xsleaks.dev/) vulnerability class. Furthermore, because the authentication of users is often only done through cookies, an attacker could impersonate a user by obtaining their cookies. This could be done in a man-in-the-middle (MitM) attack, tricking the user to make an authenticated over an insecure channel. Alternatively, by exploiting a cross-site scripting (XSS) vulnerability, the attacker could leak the cookies by accessing `document.cookie` through the DOM.

To defend against the threats posed by cookies, website developers can make use of three attributes that can be set on cookies: `HttpOnly`, `Secure` and `SameSite`. The former prevents the cookie from being accessed from JavaScript, preventing an adversary from stealing them in an XSS attack. Cookies that have the `Secure` attribute set will only be sent over a secure channel, preventing them to be stolen in a MitM attack. Finally, the attribute that was introduced most recently, `SameSite`, can be used to restrict how cookies are sent in a cross-site context. The attribute has three possible values: `None`, `Lax`, and `Strict`. Cookies with `SameSite=None` will be sent in all cross-site requests, whereas cookies with the attribute set to `Lax` will only be sent in navigational requests, e.g. when the user clicks a link and navigates to a new page. Finally, cookies with the `SameSite=Strict` attribute will only be sent in a first-party context.

{# TODO Cookie attributes image #}

Our results, which are based on 25M first-site cookies and 115M third-party cookies, shows that the usage of the cookie attributes strongly depends on the context in which they are set. We can observe a similar usage of the HttpOnly attribute on cookies for both first-party (30.5%) and third-party (26.3%) cookies. However, for the `Secure` and `SameSite` attributes we see a significant difference: this attribute is present on 22.2% of all cookies set in a first-party context, whereas 68.0% of all cookies set by third-party requests on mobile homepages have this cookie attribute. Interestingly, for desktop pages, only 35.2% of the third-party cookies had the attribute. For the SameSite attribute, we can see a significant increase in their usage, compared to [last year](https://almanac.httparchive.org/en/2019/security#samesite), when only 0.1% of the cookies had this attribute. As of August 2020, we observed that 13.7% of the first-party cookies and 53.2% of third-party cookies have the SameSite attribute set. Presumably, this significant change in adoption is related to the decision of Chrome to make SameSite=Lax the default option. This is confirmed by looking more closely at the values set in the SameSite attribute: the majority of third-party cookies (76.5%) have the attribute value set to `None`. For first-party cookies, the share is lower, at 48.0%, but still significant. It's important to note that because the crawler does not log in to websites, the cookies used to authenticate users may be different.


{# TODO SameSite cookie attributes image #}

One additional mechanism that can be used to protect cookies is to prefix the name of the cookie with `__Secure-` or `__Host-`. Cookies with any of these two prefixes will only be stored in the browser if they have the `Secure` attribute set. The latter imposes an additional restriction, requiring the `Path` attribute to be set to `/` and preventing the use of the `Domain` attribute. This prevents attackers from overriding the cookie with other values, in an attempt to perform a session fixation attack. The usage of these prefixes is relatively small: in total we found 4,433 (0.02%) first-party cookies that were set with the `__Secure-` prefix and 1,502 (0.01%) with the `__Host-` prefix. For cookies set in a third-party context, the relative number of prefixed cookies is similar.


## Content inclusion

### Content Security Policy

Modern web applications include a large variety of third-party components, ranging from JavaScript libraries, to video players, to external plugins. From a security perspective, including potentially untrusted content in your web page may pose various threats, such as cross-site scripting in case a malicious JavaScript file gets included. To defend against these threats, browsers have several mechanisms that can be used to limit from which sources content can be included, or to impose limitations on the included content.

One of the predominant mechanisms to indicate to the browser which origins are allowed to load content, is the [`Content-Security-Policy` (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) response header. Through numerous directives, a website administrator can have fine-grained control over how content can be included. For instance, the `img-src` directive indicates from which origins images can be loaded. Overall, we found that a CSP header was present on 7.23% of all pages, a notable increase of 53% from last last year, when CSP adoption was at 4.73% for mobile pages.

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
        <td>upgrade-insecure-requests</td>
        <td class="numeric">61.61%</td>
        <td class="numeric">61.00%</td>
      </tr>
      <tr>
        <td>frame-ancestors</td>
        <td class="numeric">55.64%</td>
        <td class="numeric">56.92%</td>
      </tr>
      <tr>
        <td>block-all-mixed-content</td>
        <td class="numeric">34.19%</td>
        <td class="numeric">35.61%</td>
      </tr>
      <tr>
        <td>default-src</td>
        <td class="numeric">18.51%</td>
        <td class="numeric">16.12%</td>
      </tr>
      <tr>
        <td>script-src</td>
        <td class="numeric">16.99%</td>
        <td class="numeric">16.63%</td>
      </tr>
      <tr>
        <td>style-src</td>
        <td class="numeric">14.17%</td>
        <td class="numeric">11.94%</td>
      </tr>
      <tr>
        <td>img-src</td>
        <td class="numeric">11.85%</td>
        <td class="numeric">10.33%</td>
      </tr>
      <tr>
        <td>font-src</td>
        <td class="numeric">9.75%</td>
        <td class="numeric">8.40%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Most common directives used in CSP policies.", sheets_gid="491950531", sql_file="csp_directives_usage.sql") }}</figcaption>
</figure>

Interestingly, when we look at the most commonly used directives in CSP policies, the most common directive is upgrade-insecure-requests, which is used to signal to the browser that any content that is included from an insecure scheme should instead be accessed via a secure HTTPS connection to the same host. For instance, the image that would be fetched over an insecure connection in `<img src="http://example.com/foo.png">` will instead be fetched over HTTPS when the [`upgrade-insecure-requests`](https://www.w3.org/TR/upgrade-insecure-requests/) directive is present. This is particularly helpful as browsers block mixed content: for pages that are loaded over HTTPS, content that is included from HTTP would be blocked without the upgrade-insecure-requests directive. Presumably, the adoption of this directive is relatively much higher than the others as it is a good starting point for a content security policy. The `upgrade-insecure-requests` directive is a good starting point for those beginning to work with CSP as it is unlikely to break content and is easy to implement.

The CSP directives that indicate from which sources content can be included (the original CSP level 1 specification only included these directives), have a much lower adoption: only 18.51% of the CSP policies served on desktop pages (16.12% on mobile pages). The other `*-src` directives have an even lower adoption. One of the reasons for this, is that web developers are facing [many challenges in the adoption of CSP](https://wkr.io/publication/raid-2014-content_security_policy.pdf). Although a strict CSP policy can provide significant security benefits well beyond thwarting XSS attacks, an ill-defined one may prevent certain content from loading. To allow web developers to evaluate the correctness of their CSP policy, there also exists a non-enforcing alternative, which can be enabled by defining the policy in the `Content-Security-Policy-Report-Only` response header. The prevalence of this header is fairly small: 0.85% of desktop and mobile pages. It should be noted though that this percentage likely indicates the sites that intend to transition to using CSP, and only use the Report-Only header for a limited amount of time.

{# TODO CSP header length image #}

Overall, the length of the `Content-Security-Policy` response header is quite limited: the median length for the value of the header is 75 bytes. This is mainly due to the short single-purpose CSP policies that are frequently used. For instance, 24.64% of the policies defined on desktop pages only have the `upgrade-insecure-requests` directive. The most common header value, making up for 29.44% of all policies defined on desktop pages, is `block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;`. This policy will prevent the page from being framed, tries to upgrade requests to the secure protocol, and blocks the content if that fails. On the other side of the spectrum, the longest CSP policy that we observed was 22,333 bytes long.

<figure>
  <table>
    <thead>
      <tr>
        <th>Origin</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>https://www.google-analytics.com</td>
        <td class="numeric">1.50%</td>
        <td class="numeric">1.46%</td>
      </tr>
      <tr>
        <td>https://www.googletagmanager.com</td>
        <td class="numeric">1.04%</td>
        <td class="numeric">1.07%</td>
      </tr>
      <tr>
        <td>https://fonts.googleapis.com</td>
        <td class="numeric">0.99%</td>
        <td class="numeric">0.99%</td>
      </tr>
      <tr>
        <td>https://www.youtube.com</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">0.91%</td>
      </tr>
      <tr>
        <td>https://fonts.gstatic.com</td>
        <td class="numeric">0.95%</td>
        <td class="numeric">0.95%</td>
      </tr>
      <tr>
        <td>https://www.google.com</td>
        <td class="numeric">0.95%</td>
        <td class="numeric">0.94%</td>
      </tr>
      <tr>
        <td>https://connect.facebook.net</td>
        <td class="numeric">0.89%</td>
        <td class="numeric">0.83%</td>
      </tr>
      <tr>
        <td>https://stats.g.doubleclick.net</td>
        <td class="numeric">0.72%</td>
        <td class="numeric">0.70%</td>
      </tr>
      <tr>
        <td>https://www.facebook.com</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.65%</td>
      </tr>
      <tr>
        <td>https://www.gstatic.com</td>
        <td class="numeric">0.54%</td>
        <td class="numeric">0.57%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Most frequently allowed hosts in CSP policies.", sheets_gid="1634036486", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>

The external origins from which content is allowed to be loaded, is generally in line with the origins from which [third-party content](./third-parties) is most frequently included. The 10 most common origins defined in the `*-src` attributes in CSP policies can all be linked to Google (analytics, fonts, ads), and Facebook.
One site went above and beyond to ensure that all of their included content would be allowed by CSP, and allowed 403 different hosts in their policy. Of course this makes the gained security benefit marginal at best, as certain hosts might allow for [CSP bypasses](https://webappsec.dev/assets/pub/csp_acm16.pdf), such as a JSONP endpoint that allows calling arbitrary functions.

### Subresource integrity

Many JavaScript libraries and stylesheets are included from CDNs. As a result, if the CDN would be compromised, or attackers would find another way to replace the often-included libraries, this could have disastrous consequences. To limit the consequences of a compromised CDN, web developers can use the subresource integrity (SRI) mechanism. On `<script>` and `<link>` elements, an `integrity` attribute is defined, which consists of the hash of the expected contents. The browser will compare the hash of the fetched script or stylesheet with the hash defined in the attribute, and only load its contents if there is a match. The hash can be computed with three different algorithms: SHA256, SHA384, and SHA512. The first two are most frequently used: 50.62% and 45.78% respectively for desktop pages (usage is similar on mobile pages). Note that currently, all three hashing algorithms are safe to use.

{# TODO SRI coverage per page image #}

On 7.79% of the desktop pages, at least one element contained the integrity attribute; for mobile pages this is 7.24%. The attribute is mainly used on `<script>` elements: of all the elements with the integrity attribute, 72.77% is on script elements. When looking more closely at the pages that have at least one script protected with SRI, we find that the majority of scripts on these pages do not have the integrity attribute. For the majority of these pages, less than 1 out of 20 scripts were protected with SRI.

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
        <td>cdn.shopify.com</td>
        <td class="numeric">44.95%</td>
        <td class="numeric">45.72%</td>
      </tr>
      <tr>
        <td>code.jquery.com</td>
        <td class="numeric">14.05%</td>
        <td class="numeric">13.38%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">11.45%</td>
        <td class="numeric">10.47%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">5.03%</td>
        <td class="numeric">4.76%</td>
      </tr>
      <tr>
        <td>stackpath.bootstrapcdn.com</td>
        <td class="numeric">4.96%</td>
        <td class="numeric">4.74%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Most common hosts from which SRI-protected scripts are included.", sheets_gid="2132259293", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

Looking at the most popular hosts from which SRI-protected scripts are included, we can see some driving forces that push the adoption. For instance, almost half of all the scripts that are protected with subresource integrity originate from cdn.shopify.com, most likely because the Shopify SaaS enables it by default for their customers. The rest of the top 5 hosts from which SRI-protected scripts are included is made up of three CDNs: [jQuery](https://code.jquery.com/), [cdnjs](https://cdnjs.com/), and [Bootstrap](https://www.bootstrapcdn.com/). It is probably not coincidental that all three of these CDNs have the integrity attribute in the example HTML code.

### Feature policy

Browsers provide a myriad of APIs and functionalities, some of which might be detrimental to the user experience or privacy. Through the `Feature-Policy` response header, websites can indicate which features they want to use, or perhaps more importantly, which they do not want to use. Furthermore, by defining the allow attribute on `<iframe>` elements, it's also possible to determine which features the embedded frames are allowed to use. For instance, via the autoplay directive, websites can indicate that they do not want videos in frames to automatically start playing when the page is loaded.

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
        <td>encrypted-media</td>
        <td class="numeric">78.83%</td>
        <td class="numeric">78.06%</td>
      </tr>
      <tr>
        <td>autoplay</td>
        <td class="numeric">47.14%</td>
        <td class="numeric">48.02%</td>
      </tr>
      <tr>
        <td>picture-in-picture</td>
        <td class="numeric">23.12%</td>
        <td class="numeric">23.28%</td>
      </tr>
      <tr>
        <td>accelerometer</td>
        <td class="numeric">23.10%</td>
        <td class="numeric">23.22%</td>
      </tr>
      <tr>
        <td>gyroscope</td>
        <td class="numeric">23.05%</td>
        <td class="numeric">23.20%</td>
      </tr>
      <tr>
        <td>microphone</td>
        <td class="numeric">8.57%</td>
        <td class="numeric">8.70%</td>
      </tr>
      <tr>
        <td>camera</td>
        <td class="numeric">8.48%</td>
        <td class="numeric">8.62%</td>
      </tr>
      <tr>
        <td>geolocation</td>
        <td class="numeric">8.09%</td>
        <td class="numeric">8.40%</td>
      </tr>
      <tr>
        <td>vr</td>
        <td class="numeric">7.74%</td>
        <td class="numeric">8.02%</td>
      </tr>
      <tr>
        <td>fullscreen</td>
        <td class="numeric">4.85%</td>
        <td class="numeric">4.82%</td>
      </tr>
      <tr>
        <td>sync-xhr</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.21%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Prevalence of Feature Policy directives on frames.", sheets_gid="547110187", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

The `Feature-Policy` response header has a fairly low adoption rate, at 0.60% of the desktop pages and 0.51% of mobile pages. On the other hand, the Feature Policy was enabled on 19.5% of the 8M frames that were found on the desktop pages; on mobile pages, 16.4% of the 9.2M frames contained the allow attribute. Based on the most commonly used directives in the Feature Policy on iframes, we can see that these are mainly used to control how the frames play videos. For instance the most prevalent directive, encrypted-media, is used to control access to the Encrypted Media Extensions API, which is required to play DRM-protected videos. The most common iframe origins with a Feature Policy are `https://www.facebook.com` and `https://www.youtube.com` (49.87% and 26.18% of the frames with a Feature Policy on desktop pages respectively).

### Iframe sandbox

By including an untrusted third-party in an iframe, this third-party can try to launch a number of attacks on the including page. For instance, it could navigate the top page to a phishing page, launch pop-ups with fake anti-virus advertisements, etc. The sandbox attribute on iframes can be used to restrict the capabilities, and therefore also the opportunities for launching attacks, of the embedded web page. As embedding third-party content, such as advertisements or videos, is common practice on the web, it is not surprising that many of these are restricted via the sandbox attribute: 30.29% of the iframes on desktop pages have a sandbox attribute; on mobile pages this is 33.16%.


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
        <td>allow-scripts</td>
        <td class="numeric">99.97%</td>
        <td class="numeric">99.98%</td>
      </tr>
      <tr>
        <td>allow-same-origin</td>
        <td class="numeric">99.64%</td>
        <td class="numeric">99.70%</td>
      </tr>
      <tr>
        <td>allow-popups</td>
        <td class="numeric">83.66%</td>
        <td class="numeric">89.41%</td>
      </tr>
      <tr>
        <td>allow-forms</td>
        <td class="numeric">83.43%</td>
        <td class="numeric">89.22%</td>
      </tr>
      <tr>
        <td>allow-popups-to-escape-sandbox</td>
        <td class="numeric">81.99%</td>
        <td class="numeric">87.22%</td>
      </tr>
      <tr>
        <td>allow-top-navigation-by-user-activation</td>
        <td class="numeric">59.64%</td>
        <td class="numeric">69.45%</td>
      </tr>
      <tr>
        <td>allow-pointer-lock</td>
        <td class="numeric">58.14%</td>
        <td class="numeric">67.65%</td>
      </tr>
      <tr>
        <td>allow-top-navigation</td>
        <td class="numeric">21.38%</td>
        <td class="numeric">17.31%</td>
      </tr>
      <tr>
        <td>allow-modals</td>
        <td class="numeric">20.95%</td>
        <td class="numeric">17.07%</td>
      </tr>
      <tr>
        <td>allow-presentation</td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of sandbox directives on frames.", sheets_gid="402256187", sql_file="iframe_sandbox_directives.sql") }}</figcaption>
</figure>

When the sandbox attribute of an iframe has an empty value, this results in the most restrictive policy: the embedded page can not execute any JavaScript code, no forms can be submitted, no popups can be created, ... This default policy can be relaxed in a fine-grained manner by means of different directives. The most commonly used directive, allow-scripts, which is present in 99.97% of all sandbox policies on desktop pages, allows the embedded page to execute JavaScript code. The other directive that is present on virtually all sandbox policies, allow-same-origin, allows the embedded page to retain its origin, and e.g. access cookies that were set on that origin.

Interestingly, although Feature Policy and iframe sandbox both have a fairly high adoption rate, they rarely occur simultaneously: only 0.04% of the iframes have both the allow and sandbox attribute. Presumably, this is because the iframe is created by a third-party script. A Feature Policy is predominantly added on frames that contain third-party videos, whereas the sandbox attribute is mainly used to limit the capabilities of advertisements: 56.40% of the frames on desktop pages with a sandbox attribute originates from `https://googleads.g.doubleclick.net`.

## Thwarting attacks

Modern web applications are faced with a large variety of security threats. For instance, improperly encoding or sanitizing user input may result in a cross-site scripting (XSS) vulnerability, a class of issues that has pestered web developers for well over a decade. As web applications become more and more complex, and novel types of attacks are being discovered, even more threats are looming. For instance, [XS-Leaks](https://xsleaks.dev/) is a novel class of attacks that aim to leverage the user-specific dynamic responses that web applications return. For example, given a webmail client that provides a search functionality, an attacker can trigger requests for various keywords, and subsequently try to determine, through various side-channels, whether any of these keywords yielded any results. This effectively provides the attacker with a search capability in the mailbox of an unwitting visitor on the attacker's website.

Fortunately, web browsers also provide a large set of security mechanisms that are highly effective against limiting the consequences of a potential attack, e.g. via the script-src directive of CSP an XSS vulnerability may become very difficult or impossible to exploit. Some other security mechanisms are even required to prevent certain types of attacks: to prevent clickjacking attacks, either the X-Frame-Options header should be present, or alternatively the frame-ancestors directive of CSP can be used to indicate trusted parties that can embed the current document.

{# TODO Adoption of security headers image #}

### Security mechanism adoption

The most common security response header on the Web is [`X-Content-Type-Options`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options), which instructs the browser to trust the advertised content type, and thus not sniff it based on the response content. This effectively prevents MIME-type confusion attacks, and e.g. prevents attackers from abusing a JSONP endpoint to be interpreted as HTML code in order to perform a cross-site scripting attack. Next on the list is the [`X-Frame-Options`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) (XFO) response header, which is enabled by approximately 27% of the pages. This header, along with CSP's frame-ancestors directives are the only effective mechanisms that can be used to counter clickjacking attacks. However, XFO is not only useful against clickjacking, but is also necessary or at least makes exploitation significantly more difficult for [various other types of attacks](https://cure53.de/xfo-clickjacking.pdf). Although XFO is currently still the only mechanism to defend against clickjacking attacks in legacy browsers such as Internet Explorer, it is subject to [double framing attacks](https://www.usenix.org/system/files/sec20fall_calzavara_prepub.pdf). This issue is mitigated with the frame-ancestors CSP directive. As such, it is considered best-practice to employ both headers to give users the best possible protection.

The [`X-XSS-Protection`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) header, which is currently adopted by 18.39% of the websites, was used to control the browser's built-in detection mechanism for reflected cross-site scripting. However, as of Chrome version 78, the built-in XSS detector has been [deprecated and removed](https://bugs.chromium.org/p/chromium/issues/detail?id=968591) from the browser because there existed various bypasses and the mechanism introduced new [vulnerabilities](https://frederik-braun.com/xssauditor-bad.html) and information leaks that could be abused by attackers. As the other browser vendors never implemented a similar mechanism, the X-XSS-Protection header effectively has no effect on modern browsers and can thus safely be removed. Nevertheless, we do see a slight increase in the adoption of this header compared to last year, from 15.50% to 18.39%.

The remainder of the top-5 most widely adopted headers is completed by two headers related to a website's TLS implementation. The [`Strict-Transport-Security`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) header is used to instruct the browser that the website should only be visited over an HTTPS connection for the duration defined in the `max-age` attribute. We explored the configuration of this header in more detail [earlier in this chapter](#transport-security). The `Expect-CT` header will instruct the browser to verify that any certificate that is issued for the current website needs to appear in public [Certificate Transparency](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Expect-CT) logs.

Overall, we can see that the adoption of security headers has increased in the last year: the most-widely used security headers show a relative increase of 15 to 35 percent. Interestingly, also the adoption of the features that were introduced more recently, such as the Report-To and Feature-Policy headers, is ramping up. The features are adopted by almost twice as many sites compared to last year. The strongest growth can be seen for the CSP header, with an adoption rate growing from 4.94% to 10.93%.

### Preventing XSS attacks through CSP

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
        <td>strict-dynamic</td>
        <td class="numeric">2.40%</td>
        <td class="numeric">14.68%</td>
      </tr>
      <tr>
        <td>nonce-</td>
        <td class="numeric">8.72%</td>
        <td class="numeric">17.40%</td>
      </tr>
      <tr>
        <td>unsafe-inline</td>
        <td class="numeric">89.83%</td>
        <td class="numeric">92.28%</td>
      </tr>
      <tr>
        <td>unsafe-eval</td>
        <td class="numeric">84.03%</td>
        <td class="numeric">77.48%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Prevalence of CSP keywords based on policies that define a default-src or script-src directive.", sheets_gid="876947926", sql_file="csp_script_source_list_keywords.sql") }}</figcaption>
</figure>

Implementing a strict CSP that is useful in preventing XSS attacks is non-trivial: web developers need to be aware of all the different origins from which scripts are loaded and all inline scripts should be removed. To make adoption easier, the last version of CSP (version 3), provides new keywords that can be used in the default-src or script-src directive. For instance, the [`strict-dynamic`](https://content-security-policy.com/strict-dynamic/) keyword will allow any script that is dynamically added, e.g. by creating a new `<script>` element, by an already-trusted script. From the policies that include either a default-src or script-src directive (21.17% of all CSPs), on mobile homepages we see an adoption of 14.68% of this relatively novel keyword on CSP policies that either had a default-src or script-src directive set. Interestingly, on desktop pages the adoption of this mechanism is significantly lower, at 2.40%.

Another mechanism to make adoption of CSP easier is the use of nonces: in the script-src directive of the CSP, a page can enter the keyword `nonce-`, followed by a random string. Any script (inline or remote) that has the nonce attribute set to the same random string defined in the header will be allowed to execute. As such, through this mechanism it is not required to determine all the different origins from which scripts may be included in advance. We found that the nonce mechanism was used in 17.40% of the policies that defined a `script-src` or `default-src` directive. Again, the adoption for desktop pages was lower, at 8.72%. We have been unable to explain this large difference.

The two other keywords, `unsafe-inline` and `unsafe-eval` are present on the majority of the CSPs: 97.28% and 77.79% respectively. This can be seen as a reminder of the difficulty of implementing a policy that can thwart XSS attacks. However, when the `strict-dynamic` keyword is present, this will effectively ignore the `unsafe-inline` and `unsafe-eval` keywords. Because the `strict-dynamic` keyword may not be supported by older browsers, it is considered best practice to include the two other unsafe keywords to maintain compatibility for all browser versions.

Whereas the `strict-dynamic` and `nonce-` keywords can be used to defend against reflected and persistent XSS attacks, a protected page could still be vulnerable to DOM-based XSS vulnerabilities. To defend against this class of attacks, website developers can make use of [Trusted Types](https://web.dev/trusted-types/), a fairly new mechanism that is currently only supported by Chromium-based browsers. Despite the potential difficulties in adopting Trusted Types (websites would need to create a policy and potentially adjust their JavaScript code to comply with this policy), and given that it is a new mechanism, it is encouraging that 11 pages already adopted Trusted Types through the `require-trusted-types-for` directive in CSP.

### Defending against XS-Leaks with Cross-Origin Policies

To defend against the novel class of attacks called XS-Leaks, various new security mechanisms have been introduced very recently (some are still being developed). Generally, these security mechanisms give website administrators more control over how other sites can interact with their site. For instance, the [`Cross-Origin-Opener-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy) (COOP) response header can be used to instruct browsers that the page should be process-isolated from other, potentially malicious, browser context. As such, an adversary would not be able to obtain a reference to the page's global object. As a result, attacks such as [frame counting](https://xsleaks.dev/docs/attacks/frame-counting/) are prevented with this mechanism. We found 31 early-adopters of this mechanism, which was only supported in Chrome, Edge and Firefox a few days before the data collection started.

The [`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cross-Origin_Resource_Policy_(CORP)) (CORP) header, which has been supported by Chrome, Firefox and Edge only slightly longer, has already been adopted on 1,712 pages (note that CORP can/should be enabled on all resource types, not just documents, hence this number may be an underestimation). The header is used to instruct the browser how the web resource is expected to be included: same-origin, same-site, or cross-origin (going from more to less restrictive). The browser will prevent loading resources that are included in a way that is in violation with CORP. As such, sensitive resources protected with this response header are safeguarded from [Spectre attacks](https://spectreattack.com/spectre.pdf) and various [XS-Leaks attacks](https://xsleaks.dev/docs/defenses/opt-in/corp/). The [Cross-Origin Read Blocking](https://fetch.spec.whatwg.org/#corb) (CORB) mechanism provides a similar protection, but is enabled by default in the browser (currently only in Chromium-based browsers) for "sensitive" resources.

Related to CORP is the [`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy) (COEP) response header, which can be used by documents to instruct the browser that any resource loaded on the page should have a CORP header. Additionally, resources that are loaded through the Cross-Origin Resource Sharing (CORS) mechanism (e.g. through the Access-Control-Allow-Origin header) are also allowed. By enabling this header, along with COOP, the page can get access to APIs that are potentially sensitive, such as high-accuracy timers and SharedArrayBuffer, which can also be used to construct a very accurate timer. We found 6 pages that enabled COEP, although support for the header was only added to browsers a few days before the data collection.

Most of the cross-origin policies aim to disable or mitigate the potentially nefarious consequences of several browser features that have only a limited usage on the web (e.g. retaining a reference to newly opened windows). As such, enabling security features such as COOP and CORP can, in most cases, be done without breaking any functionality. Therefore it can be expected that the adoption of these cross-origin policies will significantly grow in the coming months and years.

### Web Cryptography API

The [Web Cryptography API](https://www.w3.org/TR/WebCryptoAPI/) offers great JavaScript functions for developers with which one can run cryptographic operations on the client-side with little effort - without using external libraries. This JavaScript API provides more than basic cryptographic operations like generating cryptographically strong random values, hashing, signature generation and verification, encryption and decryption. With the help of this API, we can also implement algorithms for authenticating users, signing documents, protecting the confidentiality and integrity of communications securely. Consequently, this API enables more secure and data protection-compliant use-cases in the area of end-to-end encryption. This is how the Web Cryptography API makes its contribution to end-to-end encryption.

<figure>
  <table>
    <thead>
      <tr>
        <th>Cryptography API</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>CryptoGetRandomValues</td>
        <td class="numeric">70.32%</td>
        <td class="numeric">67.94%</td>
      </tr>
      <tr>
        <td>SubtleCryptoGenerateKey</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>SubtleCryptoEncrypt</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>SubtleCryptoDigest</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>CryptoAlgorithmSha256</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Top used cryptography APIs", sheets_gid="1256054098", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

Our results show that the function `Crypto.getRandomValues` which lets generate random-number (in cryptographic meaning) is the most widely used one (desktop: 70%, mobile: 68%). As Google Analytics uses this function, we believe it has an important effect on the value. In general, we see that mobile websites perform fewer cryptographic operations, although mobile browsers [fully support](https://developer.mozilla.org/en-US/docs/Web/API/Web_Crypto_API#Browser_compatibility) this API.
Since we perform passive crawling, our results are in this section limited. We're not able to identify cases where any interaction is required for functions to be executed.


### Utilizing bot protection services

According to [Imperva](http://www.imperva.com/blog/bad-bot-report-2020-bad-bots-strike-back), a serious proportion (37%) of the total web traffic belongs to automated programs (so-called bots), and most of them are malicious (24%).  Bots can be used for phishing, collecting information, exploiting vulnerabilities, DDoS, and many other purposes. Using bots is a very interesting technique for attackers and increases especially the success rate of massive attacks. That's why it's important to take countermeasures to protect the web resources against malicious bots. The following figure shows the use of third-party protection services against malicious bots.

<figure>
  <table>
    <thead>
      <tr>
        <th>Service provider</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>reCAPTCHA</td>
        <td class="numeric">8.30%</td>
        <td class="numeric">9.03%</td>
      </tr>
      <tr>
        <td>Imperva</td>
        <td class="numeric">0.30%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td>hCaptcha</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>Others</td>
        <td class="numeric">&lt;0.01%</td>
        <td class="numeric">&lt;0.01%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Usage of bot protection services by provider", sheets_gid="1787091453", sql_file="bot_detection.sql") }}</figcaption>
</figure>

The figure above shows the use of bot protection and also the market share based on our dataset. We see that nearly 10% of desktop pages and 9% of mobile pages use such services.

## Relationship between the adoption of security headers and various factors

In the previous sections we explored the adoption rate of various browser security mechanisms that need to be enabled by web pages by sending a response header. Next, we explore what drives websites to adopt the security features, whether it is related to country-level policies and regulations, a general interest to keep their customers safe, or whether it is driven by the technology stack that is used to create the website.

### Country of a website's visitors

There can be many different factors that affect security at the level of a country: government-motivated programs of cybersecurity may increase awareness of good security practices, a focus on security in higher education could lead to more well-informed developers, or even certain regulations might require companies and organizations to adhere to best security practices. To evaluate the differences per country, we analyze the different countries for which at least 100,000 homepages were available in our dataset, which is based on the Chrome User Experience Report (CrUX). These pages consist of those that were visited most frequently by the users in that country; as such, these also contain widely popular international websites.

{# TODO adoption of HTTPS per country #}

Looking at the percentage of homepages that were visited over HTTPS, we can already see a significant difference between the top 5 best-performing countries, where 93-95% of the homepages were served over HTTPS. For the bottom 5, we see a much smaller adoption in HTTPS, ranging from 71% to 76%. When we look at other security mechanisms, we can see even more apparent differences between top-performing countries and countries with a low adoption rate. The top-5 countries according to the adoption rate for CSP score between 14% and 16%, whereas the bottom-5 score between 2.5% and 5%. Interestingly, the countries that perform well/poorly for one security mechanism, also do so for other mechanisms. For instance, New Zealand, Ireland and Australia consistently rank among the top-5, whereas Japan scores worse for almost every security mechanism.

{# TODO adoption of CSP & XFO per country #}

### Technology stack

Country-level incentives can drive the adoption of security mechanisms to a certain extent, but perhaps more important is the technology stack that website developers use when creating websites. Do the frameworks easily lend themselves to enabling a certain feature, or is this a painstaking process requiring a complete overhaul of the application? Even better it would be if developers start with an already-secure environment with strong security defaults to begin with. In this section we explore different programming languages, SaaS, CMS, Ecommerce and CDN technologies that have a significantly higher adoption rate for specific features (and thus can be seen as driving factors for widespread adoption). For brevity, we focus on the most widely deployed technologies, but it is important to note that many smaller technology products exist that aim to provide better security for their users.

For security features related to the transport security, we find that there are 12 technology products (mainly Ecommerce platforms and CMSes) that enable the Strict-Transport-Security header on at least 90% of their customer sites. Websites powered by the top 3 (according to their market share, namely Shopify, Squarespace and Automattic), make up for 30.32% of all homepages that have enabled Strict Transport Security. Interestingly, the adoption of the Expect-CT header is mainly driven by a single technology, namely Cloudflare, which enables the header on all of their customers that have HTTPS enabled. As a result, 99.06% of the Expect-CT header presences can be related to Cloudflare.

With regard to security headers that secure content inclusion or that aim to thwart attacks, we see a similar phenomenon where a few parties enable a security header for all their customers, and thus drive its adoption. For instance, six technology products enable the Content-Security-Policy header for more than 80% of their customers. As such, the top 3 (Shopify, Sucuri and Tumblr) represent 52.53% of the homepages that have the header. Similarly, for X-Frame-Options, we see that the top 3 (Shopify, Drupal and Magento) contribute 34.96% of the prevalence of the XFO header. This is particularly interesting for Drupal, as it is an open-source CMS that is often set up by website owners themselves. It is clear that their [decision](https://www.drupal.org/node/2735873) to enable `X-Frame-Options: SAMEORIGIN` by default is keeping many of their users protected against clickjacking attacks: 81.81% of websites powered by Drupal have the XFO mechanism enabled.

### Co-occurrence of other security headers

{# TODO security header as driver of adoption of other headers image #}

The security "game" is highly unbalanced, and much more in the favor of attackers: an adversary only needs to find a single flaw to exploit, whereas the defender needs to prevent all possible vulnerabilities. As such, whereas adopting a single security mechanism can be very useful in defending against a particular attack, websites may need multiple security features in order to defend against all possible attacks. To determine whether security headers are adopted in a one-off manner, or rather in a rigorous way to provide in-depth defenses against as many attacks as possible, we look at the co-occurrence of security headers. More precisely, we look at how the adoption of one security header affects the adoption of other headers. Interestingly, this shows that websites that adopt a single security header, are much more likely to adopt other security headers as well. For instance, for mobile homepages that contain a CSP header, the adoption of the other headers (`Expect-CT`, `Referrer-Policy`, `Strict-Transport-Security`, `X-Content-Type-Options` and `X-Frame-Options`) is on average 368% higher compared to the overall adoption of these headers.

In general, websites that adopt a certain security header are 2 to 3 times more likely to adopt other security headers as well. This is especially the case for CSP, which fosters the adoption of other security headers the most. This can be explained on the one hand because CSP is one of the more extensive security headers that requires considerable effort to adopt, so websites that do define a policy, are more likely to be invested in the security of their website. On the other hand, 44.31% of the CSP headers are on homepages that are powered by Shopify. This SaaS product also enables several other security headers (`Strict-Transport-Security`, `X-Content-Type-Options` and `X-Frame-Options`) as a default for virtually all of their customers.

## Software update practices

A very large part of the Web is built with third-party components, at different layers of the technology stack. These components consist of the JavaScript libraries that are used to provide a better user experience, the content management system or web application framework that forms the backbone of the website, the web server that is used to respond to requests from the visitors, and even the programming language that the website is written in. Every so often, a vulnerability is detected in one of these components. In the best case, it is detected by a whitehat security researcher who responsibly discloses it to the affected vendor, prompting them to patch the vulnerability and release an update of their software. At this point, it is very likely that the details of the vulnerability are publicly known, and that attackers are eagerly working on creating an exploit for it. As such, it is of key importance for website owners to update the affected software as fast as possible to safeguard them from these [n-day exploits](https://www.darkreading.com/vulnerabilities---threats/the-overlooked-problem-of-n-day-vulnerabilities/a/d-id/1331348). In this section we explore how well the most widely used software is kept up-to-date.

### WordPress

{# TODO WordPress version evolution image #}

As one of the most popular content management systems, WordPress is an attractive target for attackers. As such, it is important for website administrators to keep their installation up-to-date. By default, updates are performed [automatically](https://wordpress.org/support/article/configuring-automatic-background-updates/), although it is possible to disable this feature. The evolution of the deployed WordPress versions are displayed in the above figure, showing the latest major versions that are still [actively maintained](https://wordpress.org/download/releases/) (5.5: purple, 5.4: blue, 5.3: red, 5.2: green, 4.9: orange). Versions that have a prevalence of less than 4% are grouped together under "Other". A first interesting observation that can be made is that as of October 2020, 77.19% of the WordPress installations on mobile homepages are running the latest version within their branch. It can also be seen that website owners are gradually upgrading to the new major versions. For instance, WordPress version 5.5, which was released on August 11th 2020, already comprised 10.22% of the WordPress installations that were observed in the crawl for August. In the following months, adoption of the latest version within the 5.5 branch grew to 29.70% in September and 39.11% in October.

{# TODO WordPress 5.3 and 5.4 evolution image #}

Another interesting aspect that can be inferred from the graph is that within a month, the majority of WordPress sites that were previously up-to-date, will have updated to the new version. This appears especially true for WordPress installations on the latest branch. On April 29, 2020, 2 days before the start of the crawl, WordPress released updates for all their branches: 5.4 → 5.4.1, 5.3.2 → 5.3.3, etc. Based on the data, we can see that the share of WordPress installations that were running version 5.4, reduced from 23.08% in the April 2020 crawl, to 2.66% in May 2020, further down to 1.12% in June 2020, and dropping below 1% after that. The new 5.4.1 version was running on 35.70% of the WordPress installations as of May 2020, the result of many website operators (automatically) updating their WordPress install (from 5.4 and other branches). Although the majority of website operators update their WordPress either automatically, or very quickly after a new version is released, there still is a small fraction of sites that keep stuck with an older version: as of September 2020, still 2.93% of all WordPress installations run an outdated 5.3 or 5.4 version.

### jQuery

{# TODO jQuery version evolution image #}

One of the most widely used JavaScript libraries is jQuery, which has three major versions: 1.x, 2.x and 3.x. As is clear from the evolution of jQuery versions that are used on mobile homepages, the overall distribution is very static over time. Surprisingly, a significant fraction of websites (27.71% as of October 2020) is still running an old 1.x version of jQuery. Fortunately, this fraction is consistently decreasing (from 33.39% in November 2019), in favor of version 1.12.4, which was [released](https://blog.jquery.com/2016/05/20/jquery-1-12-4-and-2-2-4-released/) in May 2016.

### nginx

{# TODO nginx version evolution image #}

For nginx, one of the most widely used web servers, we see a very static and diverse landscape in terms of the adoption of different versions over time. The largest share that any nginx (minor) version had among all nginx servers over time was approximately 20%. Furthermore, we can see that the distribution of versions remains fairly static over time: it is relatively unlikely that web servers are updated. Presumably, this is related to the fact that [no "major" security vulnerability](http://nginx.org/en/security_advisories.html) has been found in nginx since 2014 (affecting versions up to 1.5.11). The last 3 vulnerabilities with a medium-ranked impact ([CVE-2019-9511](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9511), [CVE-2019-9513](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9513), [CVE-2019-9516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9516)) date from March 2019 and can cause excessively high CPU usage in HTTP/2-enabled nginx servers up to version 1.17.2. According to the reported version numbers, more than half of the servers could be susceptible to this vulnerability (if they have HTTP/2 enabled). As the web server software is not frequently updated, this number is likely to stay fairly in the coming months.

## Malpractices on the web

Nowadays, the performance of the technologies used  plays a particularly relevant role. To this end, technologies are constantly being further developed, optimized, and new technologies launched. One of these new technologies is WebAssembly, which becomes a [W3C recommendation](https://www.w3.org/2019/12/pressrelease-wasm-rec.html.en) by the end of 2019. WebAssembly achieves the development of powerful web applications and has made it possible to run almost native high-performance computing in web browsers. No rose without a thorn; attackers have taken advantage of this technology, and this is how the new attack vector cryptojacking was found. Attackers used this technology to mine cryptocurrencies on the web browser by using the computer's power of visitors (malicious cryptomining). This is a very attractive technique for attackers – inject a few lines of JavaScript code in the webpage and let all visitors mine for you. Since the technique cryptomining on the web rarely used also by website operators, we can't generalize that all websites with cryptomining have been crypto hijacked. But in most cases, the website operators don't offer an opt-in alternative for visitors, and the visitors remain still uninformed as to whether their resources are being while surfing on the website.

{# TODO cryptominer usage image #}

The figure above shows the number of websites utilizing cryptomining in the last two years. We see that from the beginning of 2019, interest in cryptomining is getting lower. In our last measurement, we had a total of 475 websites utilizing cryptominer.

{# TODO Nurullah: get avg use time. #}

In the next figure, we show the market share of cryptominer on the web based on October's dataset. Coinimp is the most popular provider with a 45.2% market share. We found that all the most popular cryptominers are based on WebAssembly. Note that there are also JavaScript libraries to mine on the web, but they are not powerful like solutions based on WebAssembly. Our other result shows that half of the websites with cryptominer utilize a cryptomining component of discontinued service providers (such as [CoinHive](https://blog.avast.com/coinhive-shuts-down) and [JSEcoin](https://twitter.com/jsecoin/status/1247436272869814272)), which means that mining will be not happening in practice.

{# TODO Cryptomining market share image #}

{# TODO Evolution section #}

{# TODO Conclusion section #}
