---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Security
description: Security chapter of the 2021 Web Almanac covering Transport Layer Security, content inclusion (CSP, Feature Policy, SRI), web defense mechanisms (tackling XSS, XS-Leaks), and drivers of security mechanism adoptions.
authors: [saptaks, tomvangoethem, nrllh]
reviewers: [cqueern, edmondwwchan, awareseven]
analysts: [gjfr]
editors: [tunetheweb]
translators: []
saptaks_bio: Saptak S is a human rights centered web developer, focusing on usability, security, privacy and accessibility topics in web development. He is a contributor and maintainer of various different open source projects like <a hreflang="en" href="https://www.a11yproject.com">The A11Y Project</a>, <a hreflang="en" href="https://onionshare.org/">OnionShare</a> and <a hreflang="en" href="https://wagtail.io/">Wagtail</a>. You can find him blogging at <a hreflang="en" href="https://saptaks.blog">saptaks.blog</a>.
tomvangoethem_bio: Tom Van Goethem is a researcher at the <a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet group</a> of the university of Leuven, Belgium. His research is focused on discovering new side-channel attacks on the web that lead to security or privacy issues and figuring out how to patch the leaks that cause them.
nrllh_bio: Nurullah Demir is a security researcher and PhD Student at <a hreflang="en" href="https://www.internet-sicherheit.de/en/">Institute for Internet Security</a>. His research focuses on robust web security mechanisms and adversarial machine learning.
results: https://docs.google.com/spreadsheets/d/1kwjKoa8tV87XzlF6eetf2sfcMDFqVVaT25w_gm_SRwA/
featured_quote: Our analysis clearly shows that the situation of web security concerning the provider side has improved compared to previous years. However, our observation also indicates that the web community should do more to ensure better security.
featured_stat_1: 91.1%
featured_stat_label_1: Requests that use HTTPS on mobile
featured_stat_2: 22.2%
featured_stat_label_2: Percentage of top 1000 sites that use CSP
featured_stat_3: 10.7%
featured_stat_label_3: Websites on desktop that use a mechanism to fight malicious bots
---

## Introduction

We are becoming more and more digital today. We are not only digitizing our business but also our private life. We contact people online, send messages, share moments with friends, do our business, and organize our daily routine. At the same time, this shift means that more and more critical data is being digitized and processed privately and commercially. In this context, cybersecurity is also becoming more and more important as its goal is to safeguard users by offering availability, integrity and confidentiality of user data. When we look at today's technology, we see that web resources are increasingly used to provide digitally delivered solutions. It also means that there is a strong link between our modern life and the security of web applications due to their widespread use.

This chapter analyzes the current state of security on the web and gives an overview of methods that the web community uses (and misses) to protect their environment. More specifically, in this report, we analyze different metrics on [Transport Layer Security](#transport-security) (HTTPS), such as general implementation, protocol versions, and cipher suites. We also give an overview of the techniques used to protect [cookies](#cookies). You will then find a comprehensive analysis on the topic of [content inclusion](#content-inclusion) and methods for [thwarting attacks](#thwarting-attacks) (e.g., use of specific security headers). We also look at how the [security mechanisms](#drivers-of-security-meachnism-adoption) are adopted (e.g., by country or specific technology). We also discuss [malpractices on the web](#malpractices-on-the-web), such as Cryptojacking and, finally we look at usage of [`security.txt` URLs](#securitytxt).

We crawl the analyzed pages in both desktop and mobile mode, but for a lot of the data they give similar results, so unless otherwise noted, stats presented in this chapter refer to the set of mobile pages. For more information on how the data has been collected, refer to the [Methodology](./methodology) page.

## Transport security

Following the recent trend, we see continuous growth in the number of websites adopting HTTPS this year as well. Transport Layer Security is important to allow secure browsing of websites by ensuring that the resources being served to you and the data sent to the website are untampered in the transit. Almost all major browsers now come with a HTTPS-only setting and increasing warnings are shown to users when HTTP is used by a website instead of HTTPS, thus pushing broader adoption forward.

{{ figure_markup(
  caption="The percentage of requests that use HTTPS on mobile.",
  content="91.1%",
  classes="big-number",
  sheets_gid="547694791",
  sql_file="https_request_over_time.sql"
)
}}

Currently, we see that 91.9% of total requests for websites on desktop and 91.1% for mobile are being served using HTTPS. We see an <a hreflang="en" href="https://letsencrypt.org/stats/#daily-issuance">increasing number of certificates</a> being issued every day thanks to non-profit certificate authorities like Let's Encrypt.

{{ figure_markup(
  image="security-https-usage-by-site.png",
  caption="HTTPS usage for sites.",
  description="Bar chart showing 84.3% of desktop sites are using HTTPS, with the remaining 15.7% using HTTP, while 81.2% of mobile sites are using HTTPS and the remaining 18.8% using HTTP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=111383569&format=interactive",
  sheets_gid="8055510",
  sql_file="home_page_https_usage.sql"
  )
}}

Currently, 84.3% of website homepages in desktop and 81.2% of website homepages in mobile are served over HTTPS so we still see a gap between websites using HTTPS and requests using HTTPS. This is because a lot of the impressive percentage of HTTPS requests are often dominated by [third-party](./third-parties) services like fonts, analytics, [CDNs](./cdn), and not the initial web page itself.

We do see a continuous improvement in sites using HTTPS (approximately 7-8% increase since [last year](../2020/security#fig-3)), but soon a lot of unmaintained websites might start seeing warnings once <a hreflang="en" href="https://blog.mozilla.org/security/2021/08/10/firefox-91-introduces-https-by-default-in-private-browsing/">browsers start adopting HTTPS-only mode by default</a>.

### Protocol versions

_Transport Layer Security_ (TLS)) is the protocol that helps make HTTP requests secure and private. With time, new vulnerabilities are discovered and fixed in TLS. Hence, it's not just important to serve a website over HTTPS but also to ensure that modern, up-to-date TLS configuration is being used to avoid such vulnerabilities.

As part of this effort to improve security and reliability by adopting modern versions, TLS 1.0 and 1.1 have been <a hreflang="en" href="https://datatracker.ietf.org/doc/rfc8996/">deprecated by the Internet Engineering Task Force (IETF)</a> as of March 25, 2021. All upstream browsers have also either completely removed support or deprecated TLS 1.0 and 1.1. For example, Firefox has deprecated TLS 1.0 and 1.1 but has <a hreflang="en" href="https://www.ghacks.net/2020/03/21/mozilla-re-enables-tls-1-0-and-1-1-because-of-coronavirus-and-google/">not completely removed it</a> because during the pandemic, users might need to access government websites that often still run on TLS 1.0. The user may still decide to change `security.tls.version.min` in browser config to decide the lowest TLS version they want the browser to allow.

{{ figure_markup(
  image="security-tls-version-by-site.png",
  caption="TLS versions usage for sites.",
  description="Bar chart showing that on desktop 60.4% of sites use TLSv1.3, while 39.6% use TLSv1.2. On mobile the figures are 62.1% and 37.8% respectively. TLSv1.0, TLSv1.1 barely register though there is a very small amount of QUIC usage (less than 0.1% on desktop and mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1868638312&format=interactive",
  sheets_gid="1012588329",
  sql_file="tls_versions_pages.sql"
  )
}}

60.4% of pages in desktop and 62.1% of pages in mobile are now using TLSv1.3, making it the majority protocol version over TLSv1.2. The number of pages using TLSv1.3 has increased approximately 20% since [last year](../2020/security#protocol-versions) when we saw 43.2% and 45.4% respectively.

### Cipher suites

Cipher suites are a set of algorithms that are used with TLS to help make secure connections. Modern [Galois/Counter Mode](https://en.wikipedia.org/wiki/Galois/Counter_Mode) (GCM) cipher modes are considered to be much more secure compared to the older [Cipher Block Chaining Mode](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_block_chaining_(CBC)) (CBC) ciphers which have shown to be <a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">vulnerable to padding attacks</a>. While TLSv1.2 did support use of both newer and older cipher suites, <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">TLSv1.3 does not support any of the older cipher suites</a>. This is one reason TLSv1.3 is the more secure option for connections.

{{ figure_markup(
  caption="Mobile sites using forward secrecy.",
  content="96.8%",
  classes="big-number",
  sheets_gid="993983713",
  sql_file="tls_forward_secrecy.sql"
)
}}

Almost all modern cipher suites support [_Forward Secrecy_](https://en.wikipedia.org/wiki/Forward_secrecy) key exchange, meaning in the case that the server's keys are compromised, old traffic that used those keys cannot be decrypted. 96.6% in desktop and 96.8% in mobile use forward secrecy. TLSv1.3 has made forward secrecy compulsory though it is optional in TLSv1.2—yet another reason it is more secure.

The other consideration apart from the cipher mode is the key size of the <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc5116#section-2">Authenticated Encryption and Authenticated Decryption</a> algorithm. A larger key size will take a lot longer to compromise and the intensive computations for encryption and decryption of the connection impose little to no perceptible impact to site performance

{{ figure_markup(
  image="security-distribution-of-cipher-suites.png",
  caption="Distribution of cipher suites.",
  description="Bar chart showing the cipher suites used by device, with `AES_128_GCM` being the most common and used by 79.4% of desktop and 78.9% of mobile sites, `AES_256_GCM` is used by 18.6% of desktop and 19.0% of mobile sites, `AES_256_CBC` used by 1.1% of desktop sites and 1.2% of mobile sites, CHACHA20_POLY1305 is used by 0.6% and 0.7% of sites respectively, `AES_128_CBC` is used by 0.3% and 0.2% respectively, and `3DES_EDE_CBC` is used by so few sites it appears as 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=47980777&format=interactive",
  sheets_gid="172961549",
  sql_file="tls_cipher_suite.sql"
  )
}}

`AES_128_GCM` is still the most widely used cipher suite, by a long way, with 79.4% in desktop and 78.9% in mobile usage. `AES_128_GCM` indicates that it uses GCM cipher mode with _Advanced Encryption Standard_ (AES) of key size 128-bit for encryption and decryption. 128-bit key size is still considered secured, but 256-bit size is slowly becoming the industry standard to better resist brute force attacks for a longer time.

### Certificate Authorities

A _Certificate Authority_ is a company or organization that issues digital certificates which helps validate the ownership and identity of entities on the web, like websites. A Certificate Authority is needed to issue a TLS certificate recognized by browsers so that the website can be served over HTTPS. Like the previous year, we will again look into the CAs used by websites themselves rather than third-party services and resources.

<figure>
  <table>
    <thead>
      <tr>
        <th>Issuer</th>
        <th>Algorithm</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a hreflang="en" href="https://letsencrypt.org/certificates/">R3</a></td>
        <td>RSA</td>
        <td class="number">46.9%</td>
        <td class="number">49.2%</td>
      </tr>
      <tr>
        <td>Cloudflare Inc ECC CA-3</td>
        <td>ECDSA</td>
        <td class="number">11.7%</td>
        <td class="number">11.5%</td>
      </tr>
      <tr>
        <td>
          <a hreflang="en" href="https://sectigo.com/knowledge-base/detail/Sectigo-Intermediate-Certificates/kA01N000000rfBO">
            Sectigo RSA Domain Validation Secure Server CA
          </a>
        </td>
        <td>RSA</td>
        <td class="number">8.3%</td>
        <td class="number">8.2%</td>
      </tr>
      <tr>
        <td>cPanel, Inc. Certification Authority</td>
        <td>RSA</td>
        <td class="number">5.0%</td>
        <td class="number">5.5%</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://certs.godaddy.com/repository">Go Daddy Secure Certificate Authority - G2</a></td>
        <td>RSA</td>
        <td class="number">3.6%</td>
        <td class="number">3.0%</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.amazontrust.com/repository/">Amazon</a></td>
        <td>RSA</td>
        <td class="number">3.4%</td>
        <td class="number">3.0%</td>
      </tr>
      <tr>
        <td>
          <a hreflang="en" href="https://www.digicert.com/kb/digicert-root-certificates.htm">Encryption Everywhere DV TLS CA - G1</a></td>
        <td>RSA</td>
        <td class="number">1.3%</td>
        <td class="number">1.6%</td>
      </tr>
      <tr>
        <td>
          <a hreflang="en" href="https://support.globalsign.com/ca-certificates/intermediate-certificates/alphassl-intermediate-certificates">AlphaSSL CA - SHA256 - G2</a></td>
        <td>RSA</td>
        <td class="number">1.2%</td>
        <td class="number">1.2%</td>
      </tr>
      <tr>
        <td>
          <a hreflang="en" href="https://www.digicert.com/kb/digicert-root-certificates.htm">
            RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1
          </a></td>
        <td>RSA</td>
        <td class="number">1.2%</td>
        <td class="number">1.1%</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.digicert.com/kb/digicert-root-certificates.htm">DigiCert SHA2 Secure Server CA</a></td>
        <td>RSA</td>
        <td class="number">1.1%</td>
        <td class="number">0.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 10 certificate issuers for websites.", sheets_gid="1291345416", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

Let's Encrypt has <a hreflang="en" href="https://letsencrypt.org/2020/09/17/new-root-and-intermediates.html#why-we-issued-an-ecdsa-root-and-intermediates">changed their subject common name</a> from "Let's Encrypt Authority X3" to just "R3" to save bytes in new certificates. So, any SSL certificates signed by R3 are issued by <a hreflang="en" href="https://letsencrypt.org/certificates/">Let's Encrypt</a>. Thus, like previous years, we see Let's Encrypt continue to lead the charts with 46.9% of desktop websites and 49.2% of mobile sites using certificates issued by them. This is up 2-3% from last year. Its free, automated certificate generation has played a game-changing role in making it easier for everyone to serve their websites over HTTPS.

Cloudflare continues to be in second position with its similarly free certificates for its customers. Also, Cloudflare CDNs increase the usage of <a hreflang="en" href="https://www.digicert.com/faq/ecc.htm">_Elliptic Curve Cryptography_</a> (ECC) certificates which are smaller and more efficient than RSA certificates but are often difficult to deploy, due to the need to also continue to serve non-ECC certificates to older clients. Using a CDN like Cloudflare takes care of that complexity for you. All the <a hreflang="en" href="https://developers.cloudflare.com/ssl/ssl-tls/browser-compatibility">latest browsers</a> are compatible with ECC certificates, though some browsers like Chrome depend on the OS. So, if someone uses Chrome in an old OS like Windows XP, then they need to fall back to non-ECC certificates.

### HTTP Strict Transport Security

[_HTTP Strict Transport Security_](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) (HSTS) is a response header that tells the browser that it should _always_ use secure HTTPS connections to communicate with the website.

{{ figure_markup(
  caption="The percentage of requests that have HSTS header on mobile.",
  content="22.2%",
  classes="big-number",
  sheets_gid="1612539726"
)
}}

The `Strict-Transport-Security` header helps convert a `http://` URL to a `https://` URL before a request is made for that site. 22.2% of the mobile responses and 23.9% of desktop responses have a HSTS header.

<figure>
  <table>
    <thead>
      <tr>
        <th>HSTS Directive</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Valid `max-age`</td>
        <td class="number">92.7%</td>
        <td class="number">93.4%</td>
      </tr>
      <tr>
        <td>`includeSubdomains`</td>
        <td class="number">34.5%</td>
        <td class="number">33.3%</td>
      </tr>
      <tr>
        <td>`preload`</td>
        <td class="number">17.6%</td>
        <td class="number">18.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Usage of HSTS directives.", sheets_gid="1612539726", sql_file="hsts_attributes.sql") }}</figcaption>
</figure>

Out of the sites with HSTS header, 92.7% in desktop and 93.4% in mobile have a valid `max-age` (that is, the value is non-zero and non-empty) which determines how many seconds the browser should only visit the website over HTTPS.

33.3% of request responses for mobile, and 34.5% for desktop include `includeSubdomain` in the HSTS settings.  The number of responses with the `preload` directive is lower because it is [not part of the HSTS specification](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security) and needs a minimum `max-age` of 31,536,000 seconds (or 1 year) and also the `includeSubdomain` directive to be present.

{{ figure_markup(
  image="security-hsts-max-age-values-in-days.png",
  caption="HSTS `max-age` values for all requests (in days).",
  description="Bar chart of percentiles of values in the `max-age` attribute, converted to days. In the 10th percentile both desktop and mobile are 30 days, in the 25th percentile both are 182 days, in the 50th percentile both are 365 days, the 75th percentile is the same at 365 days for both and the 90th percentile has 730 days for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1583549091&format=interactive",
  sheets_gid="1297999193",
  sql_file="hsts_max_age_percentiles.sql"
) }}

The median value for `max-age` attribute in HSTS headers over all requests is 365 days in both mobile and desktop. <a hreflang="en" href="https://hstspreload.org/">https://hstspreload.org/</a> recommends a `max-age` of 2 years once the HSTS header is set up properly and verified to not cause any issues.

## Cookies

An _HTTP cookie_ is a small piece of information about the user accessing the website that the server sends to the web browser. Browsers store this information and send it back with subsequent requests to the server. Cookies help in session management to maintain state information of the user, such as if the user is currently logged in.

Without properly securing cookies, an attacker can hijack a session and send unwanted changes to the server by impersonating the user. It can also lead to <a hreflang="en" href="https://owasp.org/www-community/attacks/csrf">_Cross-Site Request Forgery_</a> attacks, whereby the user's browser inadvertently sends a request, including the cookies, unbeknownst to the user.

Several other types of attacks rely on the inclusion of cookies in cross-site requests, such as <a hreflang="en" href="https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-lekies.pdf">_Cross-Site Script Inclusion_</a> (XSSI) and various techniques in the <a hreflang="en" href="https://xsleaks.dev/">_XS-Leaks_</a> vulnerability class.

You can ensure that cookies are sent securely and aren't accessed by unintended parties or scripts by adding certain attributes or prefixes.

{{ figure_markup(
  image="security-httponly-secure-samesite-cookie-usage.png",
  caption="Cookie attributes (desktop).",
  description="Bar chart of cookie attributes used on desktop sites divided by first and third-party cookies. For first-party `HttpOnly` is used by 32.7%, `Secure` by 31.0%, and `SameSite` by 34.1%, while for third-party `HttpOnly` is used by 20.0%, `Secure` by 67.0%, and `SameSite` by 64.9%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=546317907&format=interactive",
  sheets_gid="1757682198",
  sql_file="cookie_attributes.sql"
) }}

### `Secure`

Cookies that have the `Secure` attribute set will only be sent over a secure HTTPS connection, preventing them from being stolen in a <a hreflang="en" href="https://owasp.org/www-community/attacks/Manipulator-in-the-middle_attack">_Manipulator-in-the-middle_</a> attack. Similar to HSTS, this also helps enhance the security provided by TLS protocols. For first-party cookies, just over 30% of the cookies in both desktop and mobile have the `Secure` attribute set. However, we do see a significant increase in the percentage of third-party cookies in desktop having the `Secure` attribute from 35.2% [last year](../2020/security#cookies) to 67.0% this year. This increase is likely due to the [`Secure` attribute being a requirement](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie/SameSite#none) for `SameSite=none` cookies, that we will discuss below.

### `HttpOnly`

A cookie that has the `HttpOnly` attribute set cannot be accessed through the `document.cookie` API in JavaScript. Such cookies can only be sent to the server and helps in mitigating client-side _Cross-Site Scripting_ (XSS) attacks that misuse the cookie. It's used for cookies that are only needed for server-side sessions. The percentage of cookies with `HttpOnly` attribute has a smaller difference between first-party cookies and third-party compared to the other cookie attributes being used by 32.7% and 20.0% respectively.

### `SameSite`

The `SameSite` attribute in cookies allows the websites to inform the browser when and whether to send a cookie with cross-site requests. This is used to prevent cross-site request forgery attacks. `SameSite=Strict` allows the cookie to be sent only to the site where it originated. With `SameSite=Lax`, cookies are not sent to cross-site requests unless a user is navigating to the origin site by following a link. `SameSite=None` means cookies are sent in both originating and cross-site requests.

{{ figure_markup(
  image="security-samesite-cookie-attributes.png",
  caption="Same site cookie attributes.",
  description="Bar chart of SameSite cookie attributes divided by first and third-party. For first-party `SameSite=lax` is used by 58.5%, `SameSite=strict` by 2.5%, and `SameSite=none` by 39.1%, while for third-party `SameSite=lax` is used by 1.5%, `SameSite=strict` by 0.1%, and `SameSite=none` by 98.3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=672211543&format=interactive",
  sheets_gid="1757682198",
  sql_file="cookie_attributes.sql"
) }}

We see that 58.5% of all first-party cookies with a `SameSite` attribute have the attribute set to `Lax` while there is still a pretty daunting 39.1% cookies where `SameSite` attribute is set to `none`—although the number is steadily decreasing. Almost all current browsers now default to `SameSite=Lax` if no `SameSite` attribute is set. Approximately 65% of overall first-party cookies have no `SameSite` attribute.

### Prefixes

Cookie prefixes `__Host-` and `__Secure-` help mitigate attacks to override the session cookie information for a <a hreflang="en" href="https://owasp.org/www-community/attacks/Session_fixation">session fixation attack</a>. `__Host-` helps in domain locking a cookie by requiring the cookie to also have `Secure` attribute, `Path` attribute set to `/`, not have `Domain` attribute and to be sent from a secure origin. `__Secure-` on the other hand requires the cookie to only have `Secure` attribute and to be sent from a secure origin.

​<figure>
  <table>
    <thead>
      <tr>
        <th>Type of cookie</th>
        <th>`__Secure`</th>
        <th>`__Host`</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>First-party</td>
        <td class="number">0.02%</td>
        <td class="number">0.01%</td>
      </tr>
      <tr>
        <td>Third-party</td>
        <td class="number">< 0.01%</td>
        <td class="number">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Usage of `__Secure` and `__Host` cookie prefixes in mobile.", sheets_gid="1757682198", sql_file="cookie_attributes.sql") }}</figcaption>
</figure>

Though both the prefixes are used in a significantly lower percentage of cookies, `__Secure-` is more commonly found in first-party cookies due to its lower prerequisites.

### Cookie age

Permanent cookies are deleted at a date specified by the `Expires` attribute, or after a period of time specified by the `Max-Age` attribute. If both `Expires` and `Max-Age` are set, `Max-Age` has precedence.

{{ figure_markup(
  image="security-cookie-age-usage-by-site-in-mobile-in-days.png",
  caption="Cookie age usage in days (mobile).",
  description="Bar chart the use of cookie ages in days at various percentiles. At the 10th percentile, a `Max-Age` of 0, and an `Expires` of 0, means the real max age is still 0. At the 10th percentile a value of 30 days and 14 days for the two values, means the real age is 14 days set by the ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1433212880&format=interactive",
  sheets_gid="237010912",
  sql_file="cookie_age_percentiles.sql"
  )
}}

We see that the median `Max-Age` is 365 days, as we see about 20.5% of the cookies with `Max-Age` have the value 31,536,000. However, 64.2% of the first-party cookies have `Expires` and 23.3% have `Max-Age`. Since `Expires` is much more dominant among cookies, the median for real maximum age is the same as `Expires` (180 days) instead of `Max-Age` as you would expect.

## Content inclusion

Most websites have quite a lot of media and CSS or JavaScript libraries that more often than not are loaded from various different external sources, CDNs or cloud storage services. It's important for the security of the website as well as the security of the users of a website to ensure which source of content can be trusted. Otherwise, the website is vulnerable to cross-site scripting attacks if untrusted content gets loaded.

### Content Security Policy

[_Content Security Policy_](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) (CSP) is the predominant method used to mitigate cross-site scripting and data injection attacks by restricting the origins allowed to load various content. There are numerous directives that can be used by the website to specify sources for different kinds of content. For instance, `script-src` is used to specify origins or domains from which scripts can be loaded. It also has other values to define if inline scripts and `eval()` functions are allowed.

{{ figure_markup(
  image="security-csp-directives-usage.png",
  caption="Most common directives used in CSP.",
  description="Bar chart showing usage of most common CSP directives. `upgrade-insecure-requests` is the most common with 57.6% in desktop and 57.1% in mobile, followed by `frame-ancestors` which is 54.4% in desktop and 55.8% in mobile. `block-all-mixed-content` is 29.9% in desktop and 30.7% in mobile, `default-src` is 18.4% in desktop and 16.8% in mobile, `script-src` is 17.2% in desktop and 16.7% in mobile, `style-src` is 13.8% in desktop and 12.0% in mobile, `img-src` is 11.8% in desktop and 10.4% in mobile, `font-src` is 9.8% in desktop and 8.2% in desktop, `object-src` is 8.3% in desktop and 8.9% in mobile, `connect-src` is 8.5% in desktop and 7.2% in mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1763321291&format=interactive",
  sheets_gid="50437608",
  sql_file="csp_directives_usage.sql",
  width=600,
  height=425
  )
}}

We see more and more websites starting to use CSP with 9.3% homepages on mobile using CSP now compared to 7.2% last year. `upgrade-insecure-requests` continues to be the most frequent CSP used. The high adoption rate for this policy is likely because of the same reasons mentioned [last year](../2020/security#content-security-policy); it is an easy, low-risk, policy that helps in upgrading all HTTP requests to HTTPS and also helps with to block mixed content being used on the page. `frame-ancestors` is a close second, which helps one define valid parents that may embed a page.

The adoption of policies defining the sources from which content can be loaded continues to be low. Most of these policies are more difficult to implement, as they can cause breakages. They require effort to implement to define `nonce`, hashes or domains for allowing external content.

While a strict CSP is a strong defense against attacks, they can lead to undesirable effects and prevent valid content from loading, if the policy is incorrectly defined. Different libraries and APIs loading further content makes this even more difficult.

<a hreflang="en" href="https://web.dev/csp-xss/">Lighthouse</a> recently started flagging severity warnings when such directives are missing from CSP, encouraging people to adopt a stricter CSP to prevent XSS attacks. We will discuss more about how CSP helps in stopping XSS attacks in the [thwarting attacks](#stopping-xss-attacks-via-csp) section of this chapter.

To allow web developers to evaluate the correctness of their CSP policy, there is also a non-enforcing alternative, which can be enabled by defining the policy in the `Content-Security-Policy-Report-Only` response header. The prevalence of this header is still fairly small: 0.9% in mobile. However, most of the time this header is added in the testing phase and later is replaced by the enforcing CSP, so the low usage is not unexpected.

Sites can also use the `report-uri` directive to report any CSP violations to a particular link that is able to parse the CSP errors. These can help after a CSP directive has been added to check if any valid content is accidentally being blocked by the new directive. The drawback of this powerful feedback mechanism is that CSP reporting can be noisy due to browser extensions and other technology outside of the website owner's control.

{{ figure_markup(
  image="security-csp-header-length.png",
  caption="CSP header length.",
  description="Bar chart showing percentiles of the length of the CSP header in bytes. At 10th percentile both desktop and mobile are 23 bytes, at 25th percentile both are 25 bytes, at 50th percentile both are 75 bytes, at 75th percentile also both are 75 bytes and at 90th percentile desktop is 389 bytes and mobile is 305 bytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1605401039&format=interactive",
  sheets_gid="1485136639",
  sql_file="csp_number_of_allowed_hosts.sql"
) }}

The median length of CSP headers continue to be pretty low: 75 bytes. Most websites still use single directives for specific purposes, instead of long strict CSPs. For instance, 24.2% of websites only have `upgrade-insecure-requests` directives.

{{ figure_markup(
  caption="Bytes in the longest CSP observed.",
  content="43,488",
  classes="big-number",
  sheets_gid="150007358",
  sql_file="csp_number_of_allowed_hosts.sql"
)
}}

On the other side of the spectrum, the longest CSP header is almost twice as long as last year's longest CSP header: 43,488 bytes.

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
        <td class="numeric">1.4%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>https://www.googletagmanager.com</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>https://fonts.googleapis.com</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>https://fonts.gstatic.com</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>https://www.google.com</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>https://www.youtube.com</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>https://connect.facebook.net</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>https://stats.g.doubleclick.net</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>https://www.gstatic.com</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>https://cdnjs.cloudflare.com</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most frequently allowed hosts in CSP policies.", sheets_gid="1000160612", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>

The most common origins used in `*-src` directives continue to be heavily dominated by Google (fonts, ads, analytics). We also see Cloudflare's popular library CDN showing up in the 10th position this year.

### Subresource Integrity

A lot of websites, load JavaScript libraries and CSS libraries from external CDNs. This can have certain security implications if the CDN is compromised, or an attacker finds some other way to replace the frequently used libraries. _Subresource Integrity_ (SRI) helps in avoiding such consequences, though it introduces other risks if the website may not function without that resource for a non-malicious change. Self-hosting instead of loading from a third party is usually a safer option where possible.

{{ figure_markup(
  caption="Usage of SHA384 hash function for SRI in mobile.",
  content="66.2%",
  classes="big-number",
  sheets_gid="1707924242",
  sql_file="sri_hash_functions.sql"
)
}}

Web developers can add the `integrity` attribute to `<script>` and `<link>` tags which are used to include JavaScript and CSS code to the website. The `integrity` attribute consists of a hash of the expected content of the resource. The browser can then compare the hash of the fetched content and hash mentioned in the `integrity` attribute to check its validity and only render the resource if they match.

```html

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>

```

The hash can be computed with three different algorithms: `SHA256`, `SHA384`, and `SHA512`. `SHA384` (66.2% in mobile) is currently the most used, followed by `SHA256` (31.1% in mobile). Currently, all three hashing algorithms are considered safe to use.

{{ figure_markup(
  caption="Percentage of SRI in `<script>` elements for mobile.",
  content="82.6%",
  classes="big-number",
  sheets_gid="1477693041",
  sql_file="sri_usage.sql"
)
}}

There has been some increase in the usage of SRI over the past couple of years, with 17.5% elements in desktop and 16.1% elements in mobile containing the integrity attribute. 82.6% of those were in the `<script>` element for mobile.

{{ figure_markup(
  image="security-subresource-integrity-coverage-per-page.png",
  caption="Subresource integrity: coverage per page.",
  description="Bar chart showing percentiles of what percentage of scripts on a page are protected with SRI. At the 10th percentile it is 1.4% of requests for desktop and 1.4% for mobile, at the 25th percentile it is 2.1% and 2.2% respectively, at the 50th percentile it is 3.3% for both, at the 75th percentile it is 5.6% for both, and at the 90th percentile it is 10.0% for both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1691901696&format=interactive",
  sheets_gid="247865608",
  sql_file="sri_coverage_per_page.sql"
) }}

However, it still is a minority option for `<script>` elements. The median percentage of `<script>` elements on websites which have an `integrity` attribute is 3.3%.

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
        <td>www.gstatic.com</td>
        <td class="numeric">44.3%</td>
        <td class="numeric">44.1%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">23.4%</td>
        <td class="numeric">23.9%</td>
      </tr>
      <tr>
        <td>code.jquery.com</td>
        <td class="numeric">7.5%</td>
        <td class="numeric">7.5%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">7.2%</td>
        <td class="numeric">6.9%</td>
      </tr>
      <tr>
        <td>stackpath.bootstrapcdn.com</td>
        <td class="numeric">2.7%</td>
        <td class="numeric">2.7%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most common hosts from which SRI-protected scripts are included.", sheets_gid="303199583", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

Among the common hosts from which SRI-protected scripts are included, we see most of them are made up of CDNs. We see that there are three very common CDNs that are used by multiple websites when using different libraries: <a hreflang="en" href="https://code.jquery.com/">jQuery</a>, <a hreflang="en" href="https://cdnjs.com/">cdnjs</a>, and <a hreflang="en" href="https://www.bootstrapcdn.com/">Bootstrap</a>. It is probably not coincidental that all three of these CDNs have the integrity attribute in their example HTML code, so when developers use the examples to embed these libraries, they are ensuring that SRI-protected scripts are being loaded.

### Permissions Policy

All browsers these days provide a myriad of APIs and functionalities, which can be used for tracking and malicious purposes, thus proving detrimental to the privacy of the users. <a hreflang="en" href="https://www.w3.org/TR/permissions-policy-1/">_Permissions Policy_</a> is a web platform API that gives a website the ability to allow or block the use of browser features in its own frame or in iframes that it embeds.

The `Permissions-Policy` response header allows websites to decide which features they want to use and also which powerful features they want to disallow on the website to limit misuse. A Permissions Policy can be used to control APIs like Geolocation, User media, Video autoplay, Encrypted media decoding and many more. While some of these APIs do require browser permission from the user—a malicious script can't turn on the microphone without the user getting a permission pop up—it's still good practice to use Permission Policy to restrict usage of certain features completely if they are not required by the website.

This API specification was previously known as _Feature Policy_ but as well as the rename there have been many other updates. Though the `Feature-Policy` response header is still in use, it is pretty low with only 0.6% of websites in mobile using it. The `Permissions-Policy` response headers contains an allow list for different APIs. For example, `Permissions-Policy: geolocation=(self "https://example.com")` means that the website disallows the use of Geolocation API except for its own origin and those whose origin is "`https://example.com`". One can disable the use of an API entirely in a website by specifying an empty list, e.g., `Permissions-Policy: geolocation=()`.

We see 1.3% of websites on the mobile using the `Permissions-Policy` already. A possible reason for this higher than expected usage of this new header, could be some website admins choosing to opt-out of Federated Learning of Cohorts or <a hreflang="en" href="https://privacysandbox.com/proposals/floc">FLoC</a> (which was experimentally implemented in Chrome) to protect user's privacy. The [privacy chapter](./privacy#floc) has a detailed analysis of this.

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
        <td class="numeric">46.8%</td>
        <td class="numeric">45.0%</td>
      </tr>
      <tr>
        <td>`conversion-measurement`</td>
        <td class="numeric">39.5%</td>
        <td class="numeric">36.1%</td>
      </tr>
      <tr>
        <td>`autoplay`</td>
        <td class="numeric">30.5%</td>
        <td class="numeric">30.1%</td>
      </tr>
      <tr>
        <td>`picture-in-picture`</td>
        <td class="numeric">17.8%</td>
        <td class="numeric">17.2%</td>
      </tr>
      <tr>
        <td>`accelerometer`</td>
        <td class="numeric">16.4%</td>
        <td class="numeric">16.0%</td>
      </tr>
      <tr>
        <td>`gyroscope`</td>
        <td class="numeric">16.4%</td>
        <td class="numeric">16.0%</td>
      </tr>
      <tr>
        <td>`clipboard-write`</td>
        <td class="numeric">11.2%</td>
        <td class="numeric">10.9%</td>
      </tr>
      <tr>
        <td>`microphone`</td>
        <td class="numeric">4.3%</td>
        <td class="numeric">4.5%</td>
      </tr>
      <tr>
        <td>`camera`</td>
        <td class="numeric">4.2%</td>
        <td class="numeric">4.4%</td>
      </tr>
      <tr>
        <td>`geolocation`</td>
        <td class="numeric">4.0%</td>
        <td class="numeric">4.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of `allow` directives on frames.", sheets_gid="623004240", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

One can also use the `allow` attribute in `<iframe>` elements to enable or disable features allowed to be used in the embedded frame. 28.4% of 10.8 million frames in mobile contained the `allow` attribute to enable permission or feature policies.

As in previous years, the most used directives in `allow` attributes on iframes are still related to controls for embedded videos and media. The most used directive continues to be `encrypted-media` which is used to control access to the Encrypted Media Extensions API.

### Iframe sandbox

An untrusted third-party in an iframe could launch a number of attacks on the page. For instance, it could navigate the top page to a phishing page, launch popups with fake anti-virus advertisements and other cross-frame scripting attacks.

The `sandbox` attribute on iframes applies restrictions to the content, and therefore reduces the opportunities for launching attacks from the embedded web page. The value of the attribute can either be empty to apply all restrictions (the embedded page cannot execute any JavaScript code, no forms can be submitted, and no popups can be created, to name a few restrictions), or space-separated tokens to lift particular restrictions. As embedding third-party content such as advertisements or videos via iframes is common practice on the web, it is not surprising that many of these are restricted via the `sandbox` attribute: 32.6% of the iframes on desktop pages have a `sandbox` attribute while on mobile pages this is 32.6%.

{{ figure_markup(
  image="security-prevalence-of-sandbox-directives-on-frames.png",
  caption="Prevalence of sandbox directives on frames.",
  description="Bar chart showing prevalence of sandbox directives in frames. `allow-scrips` and `allow-same-origin` are the most used directive with almost 100% of iframes having `sandbox` attributes using these directives. `allow-popups` is found in 83% frames in desktop and 87% frames in mobile, `allow-forms` is found in 81% frames in desktop and 85% frames in mobile, `allow-popups-to-escape-sandbox` is found in 80% frames in desktop and 84% frames in mobile, `allow-top-navigation-by-user-activation` is found in 57% frames in desktop and 62% frames in mobile, `allow-top-navigation` is found in 22% frames in desktop and 20% frames in mobile, and `allow-modals` is found in 21% frames in desktop and 20% frames in mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1054574782&format=interactive",
  sheets_gid="1104685300",
  sql_file="iframe_sandbox_directives.sql",
  width=600,
  height=425
  )
}}

The most commonly used directive, `allow-scripts`, which is present in 99.98% of all sandbox policies on desktop pages, allows the embedded page to execute JavaScript code. The other directive that is present on virtually all sandbox policies, `allow-same-origin`, allows the embedded page to retain its origin and, for example, access cookies that were set on that origin.

## Thwarting attacks

Web applications can be vulnerable to multiple attacks. Fortunately, there exist several mechanisms that can either prevent certain classes of vulnerabilities (e.g., framing protection through `X-Frame-Options` or CSP's `frame-ancestors` directive is necessary to <a hreflang="en" href="https://pragmaticwebsecurity.com/articles/securitypolicies/preventing-framing-with-policies.html">combat clickjacking attacks</a>), or limit the consequences of an attack. As most of these protections are opt-in, they still need to be enabled by the web developers—typically by setting the correct response header. At large scale, the presence of the headers can tell us something about the security hygiene of websites and the incentives of the developers to protect their users.

### Security feature adoption

{{ figure_markup(
  image="security-adoption-of-security-headers.png",
  caption="Adoption of security headers for site requests in mobile pages.",
  description="Bar chart showing the prevalence of different security headers, for any requests under the same domain in mobile pages in 2021 and 2020. `X-Content-Type-Options` was 30.0% in 2020 and is 36.6% in 2021, `X-Frame-Options` was 27.0% in 2020 and is 29.4% in 2021, `Strict-Transport-Security` was 17.4% in 2020 and is 22.9% in 2021, `X-XSS-Protection` was 18.4% in 2020 and is 20.0% in 2021, `Expect-CT` was 11.1% in 2020 and are 13.4% in 2021, `Content-Security-Policy` was 10.9% in 2020 and 12.8% in 2021, `Report-To` was 2.5% in 2020 and is 11.9% in 2021, `Referrer-Policy` was 7.3% in 2020 and is 10.0% in 2021, `Feature-Policy` was 0.5% in 2020 and is 0.6% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1380470049&format=interactive",
  sheets_gid="285299680",
  sql_file="security_headers_prevalence.sql",
  width=600,
  height=497
) }}

Perhaps the most promising and uplifting finding of this chapter is that the general adoption of security mechanisms continues to grow. Not only does this mean that attackers will have a more difficult time exploiting certain websites, but it is also indicative that more and more developers value the security of the web products they build. Overall, we can see a relative increase in the adoption of security features of 10-30% compared to last year. The security-related mechanism with the most uptake is the `Report-To` header of <a hreflang="en" href="https://developers.google.com/web/updates/2018/09/reportingapi">the Reporting API</a>, with almost a 4x increased adoption rate, from 2.6% to 12.2%.

Although this continued increase in the adoption rate of security mechanisms is certainly outstanding, there still remains quite some room for improvement. The most widely used security mechanism is still the `X-Content-Type-Options` header, which is used on 36.6% of the websites we crawled on mobile, to protect against MIME-sniffing attacks. This header is followed by the `X-Frame-Options` header, which is enabled on 29.4% of all sites. Interestingly, only 5.6% of websites use the more flexible `frame-ancestors` directive of CSP.

Another interesting evolution is that of the [`X-XSS-Protection`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) header. The feature is used to control the XSS filter of legacy browsers: <a hreflang="en" href="https://blogs.windows.com/windows-insider/2018/07/25/announcing-windows-10-insider-preview-build-17723-and-build-18204/">Edge</a> and <a hreflang="en" href="https://www.chromium.org/developers/design-documents/xss-auditor">Chrome</a> retired their XSS filter in July 2018 and August 2019 respectively as it could introduce new unintended vulnerabilities. Yet, we found that the `X-XSS-Protection` header was 8.5% more prevalent than last year.

### Features enabled in `<meta>` element

In addition to sending a response header, some security features can be enabled in the HTML response body by including a `<meta>` element with the `name` attribute set to `http-equiv`. For security purposes, only a limited number of policies can be enabled this way. More precisely, only a Content Security Policy and Referrer Policy can be set via the `<meta>` tag. Respectively we found that 0.4% and 2.6% of the mobile sites enabled the mechanism this way.

{{ figure_markup(
  caption="Number of sites with `X-Frame-Options` in the `<meta>` tag, which is actually ignored by the browser.",
  content="3,410",
  classes="big-number",
  sheets_gid="1578698638",
  sql_file="meta_policies_allowed_vs_disallowed.sql"
)
}}

When any of the other security mechanisms are set via the `<meta>` tag, the browser will actually ignore this. Interestingly, we found 3,410 sites that tried to enable `X-Frame-Options` via a `<meta>` tag, and thus were wrongly under the impression that they were protected from clickjacking attacks. Similarly, several hundred websites failed to deploy a security feature by placing it in a `<meta>` tag instead of a response header (`X-Content-Type-Options`: 357, `X-XSS-Protection`: 331, `Strict-Transport-Security`: 183).

### Stopping XSS attacks via CSP

CSP can be used to protect against a multitude of things: clickjacking attacks, preventing mixed-content inclusion and determining the trusted sources from which content may be included (as discussed [above](#content-security-policy)).

Additionally, it is an essential mechanism to defend against XSS attacks. For instance, by setting a restrictive `script-src` directive, a web developer can ensure that only the application's JavaScript code is executed (and not the attacker's). Moreover, to defend against DOM-based cross-site scripting, it is possible to use <a hreflang="en" href="https://web.dev/trusted-types/">_Trusted Types_</a>, which can be enabled by using CSP's [`require-trusted-types-for`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/require-trusted-types-for) directive.

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
        <td>`strict-dynamic`</td>
        <td class="numeric">5.2%</td>
        <td class="numeric">4.5%</td>
      </tr>
      <tr>
        <td>`nonce-`</td>
        <td class="numeric">12.1%</td>
        <td class="numeric">17.6%</td>
      </tr>
      <tr>
        <td>`unsafe-inline`</td>
        <td class="numeric">96.2%</td>
        <td class="numeric">96.5%</td>
      </tr>
      <tr>
        <td>`unsafe-eval`</td>
        <td class="numeric">82.9%</td>
        <td class="numeric">77.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of CSP keywords based on policies that define a `default-src` or `script-src` directive.", sheets_gid="948114503", sql_file="csp_script_source_list_keywords.sql") }}</figcaption>
</figure>

Although we saw an overall moderate increase (17%) in the adoption of CSP, what is perhaps even more exciting is that the usage of the `strict-dynamic` and nonces is either keeping the same trend or is slightly increasing. For instance, for desktop sites the use of `strict-dynamic` grew from 2.4% [last year](../2020/security#preventing-xss-attacks-through-csp), to 5.2% this year. Similarly, the use of nonces grew from 8.7% to 12.1%.

On the other hand, we find that the usage of the troubling directives `unsafe-inline` and `unsafe-eval` is still fairly high. However, it should be noted that if these are used in conjunction with `strict-dynamic`, modern browsers will ignore these values, while older browsers without `strict-dynamic` support can still continue to use the website.

### Defending against XS-Leaks

Various new security features have been introduced to allow web developers to defend their websites against micro-architectural attacks, such as [Spectre](https://en.wikipedia.org/wiki/Spectre_(security_vulnerability)), and other attacks that are typically referred to as <a hreflang="en" href="https://xsleaks.dev">XS-Leaks</a>. Given that many of these attacks were only discovered in the last few years, the mechanisms used to tackle them obviously are very recent as well, which might explain the relatively low adoption rate. Nevertheless, compared to [last year](../2020/security#defending-against-xs-leaks-with-cross-origin-policies), the cross-origin policies have significantly increased in adoption.

The [`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cross-Origin_Resource_Policy_(CORP)), which is used to indicate to the browser how a resource should be included (cross-origin, same-site or same-origin), is now present on 106,443 (1.5%) sites, up from 1,712 sites [last year](../2020/security#defending-against-xs-leaks-with-cross-origin-policies). The most likely explanation for this is that <a hreflang="en" href="https://web.dev/cross-origin-isolation-guide/">cross-origin isolation</a> is a requirement for using features such as `SharedArrayBuffer` and high-resolution timers and that requires setting the site's [`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy) to `require-corp`. In essence, this requires all loaded subresources to set the `Cross-Origin-Resource-Policy` response header for those sites wishing to use those features.

Consequently, <a hreflang="en" href="https://github.com/cdnjs/cdnjs/issues/13782">several</a> <a hreflang="en" href="https://github.com/jsdelivr/bootstrapcdn/issues/1495">CDNs</a> now set the header with a value of `cross-origin` (as CDN resources are typically meant to be included in a cross-site context). We can see that this is indeed the case, as 96.8% of sites set the CORP header value to `cross-origin`, compared to 2.9% that set it to `same-site` and 0.3% that use the more restrictive `same-origin`.

With this change, it is no surprise that the adoption of `Cross-Origin-Embedder-Policy` is also steadily increasing: in 2021, 911 sites enabled this header—significantly more than the 6 sites of last year. It will be interesting to see how this will further develop next year!

Finally, another anti-XS-Leak header, [`Cross-Origin-Opener-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy), has also seen a significant boost compared to last year. We found 15,727 sites that now enable this security mechanism, which is a significant increase compared to last year when only 31 sites were protected from certain XS-Leak attacks.

### Web Cryptography API

Security has become one of the central issues in web development. The <a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a> W3C recommendation was introduced in 2017 to perform basic cryptographic operations (e.g., hashing, signature generation and verification, and encryption and decryption) on the client-side, without any third-party library. We analyzed the usage of this JavaScript API.

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
        <td>`CryptoGetRandomValues`</td>
        <td class="numeric">70.4%</td>
        <td class="numeric">67.4%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoDigest`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoEncrypt`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmSha256`</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoGenerateKey`</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmAesGcm`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`SubtleCryptoImportKey`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmAesCtr`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">< 0.1%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmSha1`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmSha384`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top used cryptography APIs.", sheets_gid="749853824", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

The popularity of the functions remains almost the same as the previous year: we record only a slight increase of 0.7% (from 71.8% to 72.5%). Again, this year `Cypto.getRandomValues` is the most popular cryptography API. It allows developers to generate strong pseudo-random numbers. We still believe that Google Analytics has a major effect on its popularity since the Google Analytics script utilizes this function.

It should be noted that since we perform passive crawling, our results in this section will be limited by not being able to identify cases where any interaction is required before the functions are executed.

### Utilizing bot protection services

Many cyberattacks are based on automated bot attacks and interest in it seems to have increased. According to the <a hreflang="en" href="https://www.imperva.com/blog/bad-bot-report-2021-the-pandemic-of-the-internet/">Bad Bot Report 2021</a> by Imperva, the number of bad bots has increased this year by 25.6%. Note that the increase from 2019 to 2020 was 24.1%—according to <a hreflang="en" href="https://www.imperva.com/blog/bad-bot-report-2020-bad-bots-strike-back/">the previous report</a>. In the following table, we present our results on using measures by websites to protect themselves from malicious bots.

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
        <td class="numeric">10.2%</td>
        <td class="numeric">9.4%</td>
      </tr>
      <tr>
        <td>Imperva</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Sift</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Signifyd</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>hCaptcha</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Forter</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>TruValidate</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Akamai Web Application Protector</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Kount</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Konduto</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>PerimeterX</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>Tencent Waterproof Wall</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>Others</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.04%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Usage of bot protection services by provider.", sheets_gid="798151334", sql_file="bot_detection.sql") }}</figcaption>
</figure>

Our analysis shows that under 10.7% of desktop websites, and 9.9% of mobile websites use a mechanism to fight malicious bots. Last year those numbers were 8.3% and 7.3%, so this is approximately a 30% increase compared to the previous year. This year, too, we identified more bot protection mechanisms for desktop versions than mobile versions (10.8% vs. 9.9%)

We also see new popular players as bot protection providers in our dataset (e.g., hCaptcha).

## Drivers of security mechanism adoption

There are many different influences that might cause a website to invest more in their security posture. Examples of such factors are societal (e.g., more security-oriented education in certain countries, or laws that take more punitive measures in case of a data breach), technological (e.g., it might be easier to adopt security features in certain technology stacks, or certain vendors might enable security features by default), or threat-based (e.g., widely popular websites may face more targeted attacks than a website that is little known). In this section, we try to assess to what extent these factors influence the adoption of security features.

### Where website's visitors connect from

{{ figure_markup(
  image="security-adoption-of-https-per-country.png",
  caption="Adoption of HTTPS per country.",
  description="Bar chart showing percentage of sites with HTTPS enabled, for sites related to different countries. Switzerland, New Zealand, Ireland, Australia, Netherlands, Austria, Belgium, United Kingdom, South Africa and Sweden are the top in order at 97% to 94%. At the other end Malaysia, Turkey, Iran, Brazil, Indonesia, Vietnam, Thailand, Taiwan, South Korea and Japan are at 76% to 72%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1261041561&format=interactive",
  sheets_gid="269550966",
  sql_file="feature_adoption_by_country.sql",
  width="600",
  height="617"
) }}

Although we can see that the adoption of HTTPS-by-default is generally increasing, there is still a discrepancy in adoption rate between sites depending on the country most of the visitors originate from.

We find that [compared to last year](../2020/security#country-of-a-websites-visitors), the Netherlands has now made it into the top 5, which means that the Dutch are relatively more protected against transport layer attacks: 95.1% of the sites frequently visited by people in the Netherlands has HTTPS enabled (compared to 93.0% last year). In fact, not only the Netherlands improved in the adoption of HTTPS; we find that virtually every country improved in that regard.

It is also very encouraging to see that several of the countries that performed worst last year, made a big leap. For instance, 13.4% more sites visited by people from Iran (the strongest riser with regards to HTTPS adoption) are now HTTPS-enabled compared to last year (from 74.3% to 84.3%). Although the gap between the best-performing and least-performing countries is becoming smaller, there are still significant efforts to be made.

{{ figure_markup(
  image="security-adoption-of-csp-and-xfo-per-country.png",
  caption="Adoption of CSP and XFO per country.",
  description="Bar chart showing New Zealand has 21.2% of sites using CSP and 39.6% using XFO, Australia has 20.5% for CSP and 37.9% for XFO, Ireland has 19.4% for CSP and 39.8% for XFO, Canada has 18.7% for CSP and 33.5% for XFO, and USA has 17.5% for CSP and 30.4% for XFO. At the bottom end Kazakhstan has 6.4% for CSP and 21.4% for XFO, Belarus has 5.5% for CSP and 20.8% for XFO, Ukraine has 5.0% for CSP and 18.2% for XFO, Russia has 4.7% for CSP and 19.8% for XFO, and Japan has 3.6% for CSP and 17.2% for XFO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=2039992568&format=interactive",
  sheets_gid="269550966",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=598
) }}

When looking at the adoption of certain security features such as CSP and `X-Frame-Options`, we can see an even more pronounced difference between the different countries, where the sites from top-scoring countries are 2-4 times more likely to adopt these security features compared to the least-performing countries. We also find that countries that perform well on HTTPS adoption tend to also perform well on the adoption of other security mechanisms. This is indicative that security is often thought of holistically, where all different angles need to be covered. And rightfully so: an attacker just needs to find a single exploitable vulnerability whereas developers need to ensure that every aspect is tightly protected.

### Technology stack

<figure>
  <table>
    <thead>
      <tr>
        <th>Technology</th>
        <th>Security features enabled by default</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Automattic (PaaS)</td>
        <td>Strict-Transport-Security (97.8%)</td>
      </tr>
      <tr>
        <td>Blogger (Blogs)</td>
        <td>
          X-Content-Type-Options (99.6%),<br/>
          X-XSS-Protection (99.6%)
        </td>
      </tr>
      <tr>
        <td>Cloudflare (CDN)</td>
        <td>Expect-CT (93.1%), Report-To (84.1%)</td>
      </tr>
      <tr>
        <td>Drupal (CMS)</td>
        <td>
          X-Content-Type-Options (77.9%),
          <br />
          X-Frame-Options (83.1%)
        </td>
      </tr>
      <tr>
        <td>Magento (E-commerce)</td>
        <td>X-Frame-Options (85.4%)</td>
      </tr>
      <tr>
        <td>Shopify (E-commerce)</td>
        <td>
          Content-Security-Policy (96.4%),<br/>
          Expect-CT (95.5%),<br/>
          Report-To (95.5%),<br/>
          Strict-Transport-Security (98.2%),<br/>
          X-Content-Type-Options (98.3%),<br/>
          X-Frame-Options (95.2%),<br/>
          X-XSS-Protection (98.2%)
        </td>
      </tr>
      <tr>
        <td>Squarespace (CMS)</td>
        <td>
          Strict-Transport-Security (87.9%),<br/>
          X-Content-Type-Options (98.7%)
        </td>
      </tr>
      <tr>
        <td>Sucuri (CDN)</td>
        <td>
          Content-Security-Policy (84.0%),<br/>
          X-Content-Type-Options (88.8%),<br/>
          X-Frame-Options (88.8%),<br/>
          X-XSS-Protection (88.7%)
        </td>
      </tr>
      <tr>
        <td>Wix (Blogs)</td>
        <td>
          Strict-Transport-Security (98.8%),<br/>
          X-Content-Type-Options (99.4%)
        </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Security features adoption by various technology.", sheets_gid="1386880960", sql_file="feature_adoption_by_technology.sql") }}</figcaption>
</figure>

Another factor that can strongly influence the adoption of certain security mechanisms is the technology stack that's being used to build a website. In some cases, security features may be enabled by default, or for some blogging systems the control over the response headers may be out of the hands of the website owner and a platform-wide security setting may be in place.

Alternatively, CDNs may add additional security features, especially when these concern the transport security. In the above table, we've listed the nine technologies that are used by at least 25,000 sites, and that have a significantly higher adoption rate of specific security mechanisms. For instance, we can see that sites that are built with the Shopify e-commerce system have a very high (over 95%) adoption rate for seven security-relevant headers: `Content-Security-Policy`, `Expect-CT`, `Report-To`, `Strict-Transport-Security`, `X-Content-Type-Options`, `X-Frame-Options`, and `X-XSS-Protection`.

{{ figure_markup(
  caption="The number of security features with over 95% adoption rate on Shopify sites.",
  content="7",
  classes="big-number",
  sheets_gid="1386880960",
  sql_file="feature_adoption_by_technology.sql"
)
}}

It is great to see that despite the variability in these content that use these technologies, it is still possible to uniformly adopt these security mechanisms.

{{ figure_markup(
  caption="The percentage of Drupal sites that keep the default XFO header.",
  content="83.1%",
  classes="big-number",
  sheets_gid="1386880960",
  sql_file="feature_adoption_by_technology.sql"
)
}}

Another interesting entry in this list is Drupal, whose websites have an adoption rate of 83.1% for the `X-Frame-Options` header (a slight improvement compared to last year's 81.8%). As this header is <a hreflang="en" href="https://www.drupal.org/node/2735873">enabled by default</a>, it is clear that the majority of Drupal sites stick with it, protecting them from clickjacking attacks. Note that, while it makes sense to keep the `X-Frame-Options` header for compatibility with older browsers in the near term, site owners should consider transitioning to the recommended `Content-Security-Policy` header directive `frame ancestors` for the same functionality.

An important aspect to explore in the context of the adoption of security features, is the diversity. For instance, as Cloudflare is the largest CDN provider, powering millions of websites (see the [CDN](./cdn) chapter for further analysis on this). Any feature that Cloudflare enables by default will result in a large overall adoption rate. In fact, 98.2% of the sites that employ the `Expect-CT` feature are powered by Cloudflare, indicating a fairly limited distribution in the adoption of this mechanism.

However, overall, we find that this phenomenon of a single actor like a Drupal or Cloudflare being a top technological driver of a security feature's adoption is an outlier and appears less common over time. This means that an increasingly diverse set of websites is adopting security mechanisms, and that more and more web developers are becoming aware of their benefits. For example, last year 44.3% of the sites that set a Content Security Policy were powered by Shopify, whereas this year, Shopify is only responsible for 32.9% of all sites that enable CSP. Combined with the generally growing adoption rate, this is great news!

### Website popularity

Websites that have many visitors may be more prone to targeted attacks given that there are more users with potentially sensitive data to attract attackers. Therefore, it can be expected that widely visited websites invest more in security in order to safeguard their users. To evaluate whether this hypothesis is valid, we used the ranking provided by the [Chrome User Experience Report](./methodology#chrome-ux-report), which uses real-world user data to determine which websites are visited the most (ranked by top 1k, 10k, 100k, 1M and all sites in our dataset).

{{ figure_markup(
  image="security-prevalence-of-headers-in-sites-by-rank.png",
  caption="Prevalence of security headers set in a first-party context by rank.",
  description="Bar chart showing in top 1,000 sites, 54.8% have XFO, 50.7% have HSTS and 22.2% have CSP headers. In top 10,000, 48.3% have XFO, 41.0% have HSTS and 17.9% have CSP headers. In top 100,000, 44.3% have XFO, 34.5% have HSTS and 14.2% have CSP headers. In top 1,000,000, 38.8% have XFO, 27.8% have HSTS and 13.4% have CSP headers. Among all sites, 29.4% have XFO, 22.9% have HSTS and 12.8% have CSP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1353621848&format=interactive",
  sheets_gid="1156119511",
  sql_file="security_adoption_by_rank.sql"
  )
}}

We can see that the adoption of certain security features, X-Frame-Options (XFO), Content Security Policy (CSP), and Strict Transport Security (HSTS), is highly related to the ranking of sites. For instance, the 1,000 top visited sites are almost twice as likely to adopt a certain security header compared to the overall adoption. We can also see that the adoption rate for each feature is higher for higher-ranked websites.

We can draw two conclusions from this: on the one hand, having better "security hygiene" on sites that attract more visitors benefits a larger fraction of users (who might be more inclined to share their personal data with well-known trusted sites). On the other hand, the lower adoption rate of security features on less-visited sites could be indicative that it still requires a substantial investment to (correctly) implement these features. This investment may not always be feasible for smaller websites. Hopefully, we will see a further increase in security features that are enabled by default in certain technology stacks, which could further enhance the security of many sites without requiring too much effort from web developers.

## Malpractices on the web

Cryptocurrencies have become an increasingly familiar part of our modern community. Global cryptocurrency adoption has been <a hreflang="en" href="https://blog.chainalysis.com/reports/2021-global-crypto-adoption-index">skyrocketing</a> since the beginning of the pandemic. Due to its economic efficiency, cybercriminals have also become more interested in cryptocurrencies. That has led to the creation of a new attack vector: [cryptojacking] (https://en.wikipedia.org/wiki/Cryptojacking). Attackers have discovered the power of [WebAssembly](./webassembly) and exploited it to mine cryptocurrencies while website visitors surf on a website.

We now show our findings in the following figure regarding cryptominer usage on the web.

{{ figure_markup(
  image="security-cryptominer-usage.png",
  caption="Cryptominer usage.",
  description="Time series chart showing the evolution of the number of sites with cryptojacking scripts from January 2020 until August 2021. There is an upward trend from 500 desktop sites and 606 mobile sites at the beginning to 827 sites on desktop and 983 sites on mobile at the end, with a dip around February 2021 to May 2021 when it goes lowest to 76 sites on desktop and 124 sites on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1998879220&format=interactive",
  sheets_gid="1719897363",
  sql_file="cryptominer_usage.sql"
) }}

According to our dataset, until recently, we found a very stable decrease in the number of websites with Cryptominer. However, we are now seeing that the number of such websites has increased more than tenfold in the past two months. Such picks are very typical, for example, when widespread cryptojacking attacks take place or when a popular JS library has been infected.

We now turn to cryptominer market share in the following figure.

{{ figure_markup(
  image="security-cryptominer-market-share.png",
  caption="Cryptominer market share (mobile).",
  description="Pie chart showing CoinImp has 84.9% of market share, Coinhive has 9.0%, JSEcoin has 3.1%, Minero.cc has 1.5% and others have approximately 1.5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1688060716&format=interactive",
  sheets_gid="1998142066",
  sql_file="cryptominer_share.sql"
) }}

We see that [Coinhive](https://en.wikipedia.org/wiki/Monero#Mining_malware) has been surpassed by CoinImp as the dominant cryptomining service. One of the main reasons for this <a hreflang="en" href="https://www.zdnet.com/article/coinhive-cryptojacking-service-to-shut-down-in-march-2019/">was that Coinhive was shutdown in March 2019</a>. Interestingly, the domain is now <a hreflang="en" href="https://www.troyhunt.com/i-now-own-the-coinhive-domain-heres-how-im-fighting-cryptojacking-and-doing-good-things-with-content-security-policies/">owned by Troy Hunt</a> who is now displaying aggressive banners on the website in an effort to make those sites still hosting the Coinhive script (Desktop: 5.7%, mobile: 9.0%) aware that they are—often without their knowledge. This reflects both the prevalence of Coinhive scripts even over two years after ceasing to operate, and the risks of hosting third-party resources that can be taken over should that third party cease to operate. With Coinhive's demise, CoinImp has clearly become the market leader (84.9% share).

Our results suggest that cryptojacking is still a serious attack vector, and necessary measures should be used for it.

Note that not all of these websites are infected. Website operators may also deploy this technique (instead of showing ads) to finance their website. But the use of this technique is also heavily discussed technically, legally, and ethically.

Please also note that our results may not show the actual state of the websites infected with cryptojacking. Since we run our crawler once a month, not all websites that run cryptominer can be discovered. This is the case, for example, if a website remains infected for only X days and not on the day our crawler ran.

## `security.txt`

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-foudil-securitytxt-12">`security.txt`</a> is a file format for websites to provide a standard for vulnerability reporting. Website providers can provide contact details, PGP key, policy, and other information in this file. White hat hackers can then use this information to conduct security analyses on these websites or report a vulnerability.

{{ figure_markup(
  image="security-usage-of-well-known-security.png",
  caption="Use of `security.txt`.",
  description="Bar chart showing 4.9% of websites in desktop and 4.9% of websites in mobile have `security.txt` endpoint.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1958147881&format=interactive",
  sheets_gid="399976976",
  sql_file="well-known_security.sql"
  )
}}

We see that just under 5% of the websites return a response when asking for the `/.well-known/security.txt` URL. However investigating many of these show they are basically 404 pages that are incorrectly returning a 200 status code so usage is likely much lower.

{{ figure_markup(
  image="security-usage-of-properties-in-well-known-security.png",
  caption="Use of security.txt properties.",
  description="Bar chart showing use of different properties in `security.txt`.  0.4% of desktop and 0.3% of mobile `security.txt` files are signed, `Canonical` is used in for 2.8% in desktop and 2.7% in mobile, `Encryption` is 2.6% in desktop and 2.1% in mobile, `Expires` is 0.9% in desktop and 0.7% in mobile, `Policy` is 6.5% in desktop and 6.4% in mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=644563241&format=interactive",
  sheets_gid="399976976",
  sql_file="well-known_security.sql"
  )
}}

We see that `Policy` is the most used property in the `security.txt` files, but even then it's only used in 6.4% of sites with a `security.txt` URL. This property includes a link to the vulnerability disclosure policy for the website that helps researchers understand the reporting practices they need to follow. This is therefore likely a better indicator of the real usage of `security.txt` since most file are expected to have a `Policy` value, meaning likely closer to 0.3% of all sites have a "real" `security.txt` file, rather than the 5% measured above.

Another interesting point is that when we look at just this subset of "real" security.txt URLs, Tumblr makes up 63%-65% of the usage. It looks like this is set by default for these domains to the Tumblr contact details. This is great on one hand to show how a single platform can drive adoption of these new security features, but on the other hand indicates a further reduction in actual site usage.

The other most used properties include `Canonical` and `Encryption`. `Canonical` is used to indicate where the `security.txt` file is located. If the URI used to retrieve the `security.txt` file doesn't match the list URIs in the `Canonical` fields, then the contents of the file should not be trusted. `Encryption` provides the security researchers with an encryption key that they can use for encrypted communication.

## Conclusion

Our analysis shows that the situation of web security concerning the provider side is improving compared to previous years. For example, we see that the use of HTTPS has increased by almost 10% in the last 12 months. We also find an increase in the protection of cookies and the use of security headers.

These increases indicate we are moving safer web environment, but they do not mean our web is secure enough today. We still have to improve our situation. For example, we believe that the web community should value security headers more. These are very effective extensions to protect web environments and web users from possible attacks.

The bot protection mechanisms can also be adopted more to protect the platforms from malicious bots. Furthermore, our analysis from [last year](../2020/security#software-update-practices) and another study using the HTTP Archive dataset about the <a hreflang="en" href="https://www.researchgate.net/publication/349027860_Our_inSecure_Web_Understanding_Update_Behavior_of_Websites_and_Its_Impact_on_Security">update behavior of websites</a> showed that the website components are not diligently maintained, which increases the attack surface on web environments.

We should not forget that attackers are also working diligently to develop new techniques to bypass the security mechanisms we adopt.

With our analysis, we have tried to crystallize an overview of the security of our web. As extensive as our investigation is, our methodology only allows us to see a subset of all aspects of modern web security. For example, we do not know what additional measures a site may employ to mitigate or prevent attacks such as _Cross-Site-Request-Forgery_ (CSRF) or certain types of _Cross-Site-Scripting_ (XSS). As such, the picture portrayed in this chapter is incomplete yet a solid directional signal of the status of web security today.

The takeaway from our analysis is that we, the web community, must continue to invest more interest and resources in making our web environments much safer—in the hope of better and safer tomorrow for all.
