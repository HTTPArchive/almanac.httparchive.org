---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Security
description: Security chapter of the 2024 Web Almanac covering Transport Layer Security, content inclusion (CSP, Feature Policy, SRI), web defense mechanisms (tackling XSS, XS-Leaks), and drivers of security mechanism adoptions.
authors: [GJFR, vikvanderlinden]
reviewers: [lord-r3, SaptakS, AlbertoFDR, clarkio]
editors: [cqueern, joeleonjr]
analysts: [JannisBush]
translators: []
GJFR_bio: TODO
vikvanderlinden_bio: TODO
results: https://docs.google.com/spreadsheets/d/1b9IEGbfQjKCEaTBmcv_zyCyWEsq35StCa-dVOe6V1Cs/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

With how much of our lives happen online these days - whether it's staying in touch, following the news, buying, or even selling products online - web security has never been more important. Unfortunately, the more we rely on these online services, the more appealing they become to malicious actors. As we've seen time and time again, even a single weak spot in the systems we depend on can lead to disrupted services, stolen personal data, or worse. The past two years have been no exception, with a rise in <a hreflang="en" href="https://blog.cloudflare.com/ddos-threat-report-for-2024-q2/">Denial-of-Service (DoS) attacks</a>, <a hreflang="en" href="https://www.imperva.com/resources/resource-library/reports/2024-bad-bot-report/">bad bots</a>, and <a hreflang="en" href="https://www.darkreading.com/vulnerabilities-threats/rising-tide-of-software-supply-chain-attacks">supply-chain attacks targeting the Web</a> like never before.

In this chapter, we take a closer look at the current state of web security by analyzing the protections and security practices used by websites today. We explore key areas like Transport Layer Security (TLS), cookie protection mechanisms, and safeguards against third-party content inclusion. We'll discuss how these security measures help prevent attacks, as well as highlight common misconfigurations that can undermine them. Additionally, we examine some of the harmful practices still present on the web, such as the widespread use of cryptominers.

We also investigate the factors driving security practices, analyzing whether elements like country, website category, or technology stack influence the security measures in place. By comparing this year's findings with those from the [2022 Web Almanac](../2022/security), we highlight key changes and assess long-term trends. This allows us to provide a broader perspective on the evolution of web security practices and the progress made over the years.

## Transport security

[HTTPS](https://developer.mozilla.org/docs/Glossary/https) uses Transport Layer Security (<a hreflang="en" href="https://www.cloudflare.com/en-gb/learning/ssl/transport-layer-security-tls/">TLS</a>) to secure the connection between client and server. Over the past years, the number of sites using TLS has increased tremendously. As in previous years, adoption of TLS continued to increase, but that increase is slowing down as it closes in to 100%.

{{ figure_markup(
  content="98%",
  caption="The percentage of requests that use HTTPS.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

The number of requests served using TLS climbed another 4% to 98.12% on mobile since the last Almanac in 2022.

{{ figure_markup(
  image="https-usage.png",
  caption="The percentage of hosts that use HTTPS.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=305355771&format=interactive",
  sheets_gid="715077736",
  sql_file="home_page_https_usage.sql"
  )
}}

The number of homepages served over HTTPS on mobile increased from 89% to 95.6%. This percentage is lower than the number of requests served over HTTPS due to the high number of third-party resources websites load, which are more likely to be served over HTTPS.

### Protocol versions

Over the years, multiple new versions of TLS have been created. In order to remain secure, it is important to use an up to date version of TLS. The latest version is <a hreflang="en" href="https://www.cloudflare.com/en-in/learning/ssl/why-use-tls-1.3/">TLS1.3</a>, which has been the preferred version for a while. Compared to TLS1.2, version 1.3 deprecates some cryptographic protocols still included in 1.2 that were found to have certain flaws and it enforces perfect forward secrecy. Support for older versions of TLS have long been removed by major browser vendors. QUIC (Quick UDP Internet Connections), the protocol underlying HTTP/3 also uses TLS, providing similar security guarantees as TLS1.3.

{{ figure_markup(
  image="tls-versions.png",
  caption="The distribution of TLS versions in use.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1913163011&format=interactive",
  sheets_gid="18287010",
  sql_file="tls_versions_pages.sql"
  )
}}

We find that TLS1.3 is supported and used by 73.03% of web pages. The use of TLS1.3 overall has grown, even though QUIC has gained significant use compared to 2022, moving from 0% to almost 10% of mobile pages. The use of TLS1.2 continues to decrease as expected. Compared to the last Almanac it decreased by more than 12% for mobile pages, while TLS1.3 has increased by a bit over 2%. It is expected that the adoption of QUIC will continue to rise, as the use of TLS1.2 will continue to decrease.

We assume most websites don't move from TLS1.2 directly to QUIC, but rather that most sites using QUIC migrated from TLS1.3 and others moved from TLS1.2 to TLS1.3, thereby giving the appearance of limited growth of TLS1.3.

### Cipher suites

Before client and server can communicate, they have to agree upon the cryptographic algorithms, known as <a hreflang="en" href="https://learn.microsoft.com/en-au/windows/win32/secauthn/cipher-suites-in-schannel">cipher suites</a>, to use. Like last time, over 98% of requests are served using a Galois/Counter Mode (<a hreflang="en" href="https://en.wikipedia.org/wiki/Galois/Counter_Mode">GCM</a>) cipher, which is considered the most secure option, due to them not being vulnerable to <a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">padding attacks</a>. Also unchanged is the almost 79% of requests using a 128-bit key, which is still considered a secure key-length for AES in GCM mode. There are only a handful of suites used on the visited pages. TLS1.3 <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">only supports GCM and other modern block cipher modes</a>, which also simplifies its <a hreflang="en" href="https://go.dev/blog/tls-cipher-suites">cipher suite ordering</a>.

{{ figure_markup(
  image="cipher-suites.png",
  caption="The distribution of cipher suites in use.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=783511328&format=interactive",
  sheets_gid="251336291",
  sql_file="tls_cipher_suite.sql"
  )
}}

TLS1.3 makes <a hreflang="en" href="https://en.wikipedia.org/wiki/Forward_secrecy">forward secrecy</a> required, which means it is highly supported on the web. Forward Secrecy is a feature that assures that in case a key in use is leaked, it cannot be used to decrypt future or past messages sent over a connection. This is important to ensure that adversaries storing long-term traffic cannot decrypt the entire conversation as soon as they are able to leak a key. Interestingly, the use of forward secrecy dropped by almost 2% this year, to 95.38%.

{{ figure_markup(
  image="forward-secrecy.png",
  caption="The percentage of requests supporting forward secrecy.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1563776541&format=interactive",
  sheets_gid="849531701",
  sql_file="tls_forward_secrecy.sql"
  )
}}

### Certificate Authorities

In order to use TLS, servers must first get a certificate they can host, which is created by a <a hreflang="en" href="https://www.ssl.com/faqs/what-is-a-certificate-authority/">Certificate Authority</a> (CA). By retrieving a certificate from one of the trusted CAs, the certificate will be recognized by the browser, thus allowing the user to use the certificate and therefore TLS for their secure communication.

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
        <td class="numeric">44.32%</td>
        <td class="numeric">45.05%</td>
      </tr>
      <tr>
        <td>GTS CA 1P5</td>
        <td class="numeric">6.13%</td>
        <td class="numeric">6.63%</td>
      </tr>
      <tr>
        <td>E1</td>
        <td class="numeric">4.19%</td>
        <td class="numeric">4.26%</td>
      </tr>
      <tr>
        <td>Sectigo RSA Domain Validation Secure Server CA</td>
        <td class="numeric">3.34%</td>
        <td class="numeric">3.09%</td>
      </tr>
      <tr>
        <td>R10</td>
        <td class="numeric">2.59%</td>
        <td class="numeric">2.83%</td>
      </tr>
      <tr>
        <td>R11</td>
        <td class="numeric">2.59%</td>
        <td class="numeric">2.81%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">1.96%</td>
        <td class="numeric">1.74%</td>
      </tr>
      <tr>
        <td>cPanel, Inc. Certification Authority</td>
        <td class="numeric">1.74%</td>
        <td class="numeric">1.78%</td>
      </tr>
      <tr>
        <td>Cloudflare Inc ECC CA-3</td>
        <td class="numeric">1.52%</td>
        <td class="numeric">1.30%</td>
      </tr>
      <tr>
        <td>Amazon RSA 2048 M02</td>
        <td class="numeric">1.39%</td>
        <td class="numeric">1.27%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The percentage of sites using a certificate issued by a specific issuer", sheets_gid="1458082974", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

R3 (an intermediate certificate from <a hreflang="en" href="https://letsencrypt.org/">Let's Encrypt</a>) still leads the charts, although usage dropped compared to last year. Also from Let's Encrypt are the E1, R10 and R11 intermediary certificates that are rising in percentage of websites using them.

<a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html">R3 and E1 were issued in 2020 and are only valid for 5 years</a>, which means it will <a hreflang="en" href="https://crt.sh/?id=3334561879">expire in September 2025</a>. Around a year before the expiry of intermediate certificates, Let's Encrypt issues new intermediates that will gradually take over from the older ones. <a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html">This March, Let's Encrypt issued their new intermediates</a>, which include R10 and R11 that are only valid for 3 years. These latter two certificates will take over from R3 directly, which should be reflected in next year's Almanac.

Along with the rise in the number of Let's Encrypt issued certificates, other current top 10 providers have seen a decrease in their share of certificates issued, except for GTS CA 1P5 that rose from close to 0% to over 6.5% on mobile. Of course it is possible that at the time of our analysis a CA was in the process of switching intermediate certificates, which could mean they serve a larger percentage of sites than reflected.

{{ figure_markup(
  content="56%",
  caption="The percentage of pages that use a Let's Encrypt issued certificate on mobile.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

When we sum together the use of all certificates of Let's Encrypt, we find that they issue over 56% of the certificates currently in use.

### HTTP Strict Transport Security

[HTTP Strict Transport Security (HSTS)](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security) is a response header that a server can use to communicate to the browser that only HTTPS should be used to reach pages hosted on this domain, instead of first reaching out over HTTP and following a redirect.

{{ figure_markup(
  content="30%",
  caption="The percentage of requests that have a HSTS header on mobile.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

Currently, 30% of responses on mobile have a HSTS header, which is a 5% increase compared to 2022. Users of the header can communicate directives to the browser by adding them to the header value. The `max-age` directive is obligated. It indicates to the browser the time it should continue to only visit the page over HTTPS in seconds.

{{ figure_markup(
  image="hsts-directives.png",
  caption="The usage of specified HSTS directives.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1511073784&format=interactive",
  sheets_gid="1943916698",
  sql_file="hsts_attributes.sql"
  )
}}

The share of requests with a valid `max-age` has remained unchanged at 95%. The other , optional, directives (`includeSubdomains` and `preload`) both see a slight increase of 1% compared to 2022 to 35% and 18% on mobile respectively. The `preload` directive, which [is not part of the HSTS specification](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security), requires the `includeSubdomains` to be set and also requires a `max-age` larger than 1 year (or 31,536,000 seconds).

{{ figure_markup(
  image="hsts-max-age.png",
  caption="The distribution of HSTS max-age values by percentile.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=897035311&format=interactive",
  sheets_gid="1216364866",
  sql_file="hsts_max_age_percentiles.sql"
  )
}}

The distribution of valid `max-age` values has remained almost the same as in 2022, with the exception that the 10th percentile on mobile has decreased from 72 to 30 days. The median value of `max-age` remains at 1 year.

## Cookies

Websites can store small pieces of data in a user's browser by setting an HTTP cookie. Depending on the cookie's attributes, it will be sent with every subsequent request to that website. As such, cookies can be used for purposes of implicit authentication, tracking or storing user preferences.

When cookies are used for authenticating users, it is paramount to protect them from abuse. For instance, if an adversary gets ahold of a user's session cookie, they could potentially log into the victim's account.

To protect their user's from attacks like <a hreflang="en" href="https://owasp.org/www-community/attacks/csrf">Cross-Site Request Forgery (CSRF)</a>,<a hreflang="en" href="https://owasp.org/www-community/attacks/Session_hijacking_attack"> session hi-jacking</a>, <a hreflang="en" href="https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/11-Client_Side_Testing/13-Testing_for_Cross_Site_Script_Inclusion">Cross-Site Script Inclusion (XSSI)</a> and <a hreflang="en" href="https://xsleaks.dev/">Cross-Site Leaks</a>, websites are expected to securely configure authentication cookies.

### Cookie attributes

The three cookie attributes outlined below enhance the security of authentication cookies against the attacks mentioned earlier. Ideally, developers should consider using all attributes, as they provide complementary layers of protection.

{{ figure_markup(
  image="cookie-attributes-desktop.png",
  caption="Cookie attributes (desktop).",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=827181104&format=interactive",
  sheets_gid="1849762871",
  sql_file="TODO.sql"
  )
}}

#### `HttpOnly`

By setting this attribute, the cookie is not allowed to be accessed or manipulated through the JavaScript `document.cookie` API. This prevents a <a hreflang="en" href="https://owasp.org/www-community/attacks/xss/">Cross-Site Scripting (XSS)</a> attack from gaining access to cookies containing secret session tokens.

With 42% of cookies having the `HttpOnly` attribute in a first-party context on desktop, the usage has risen by 6% compared to 2022. As for third-party requests, the usage has decreased by 1%.

#### `Secure`

Browsers only transmit cookies with the `Secure` attribute over secure, encrypted channels, such as HTTPS, and not over HTTP. This ensures that man-in-the-middle attackers cannot intercept and read sensitive values stored in cookies.

The use of the `Secure` attribute has been steadily increasing over the years. Since 2022, an additional 7% of cookies in first-party contexts and 6% in third-party contexts have been configured with this attribute. As discussed in previous editions of the Security chapter, the significant difference in adoption between the two contexts is largely due to the requirement that third-party cookies with `SameSite=None` must also be marked as `Secure`. This highlights that additional security prerequisites for enabling desired non-default functionality are an effective driver for the adoption of security features.

#### `SameSite`

The most recently introduced cookie attribute, `SameSite`, allows developers to control whether a cookie is allowed to be included in third-party requests. It is intended as an additional layer of defense against attacks like CSRF.

The attribute can be set to one of three values: `Strict`, `Lax`, or `None`. Cookies with the `Strict` value are completely excluded from cross-site requests. When set to `Lax`, cookies are only included in third-party requests under specific conditions, such as navigational GET requests, but not POST requests. By setting `SameSite=none`, the cookie bypasses the same-site policy and is included in all requests, making it accessible in cross-site contexts.

{{ figure_markup(
  image="same-site-cookie-attributes-desktop.png",
  caption="SameSite cookie attributes (desktop).",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1988555622&format=interactive",
  sheets_gid="1849762871",
  sql_file="TODO.sql"
  )
}}

While the relative number of cookies with a `SameSite` attribute has increased compared to 2022, this rise is largely attributable to cookies being explicitly excluded from the same-site policy by setting `SameSite=None`.

It's important to note that all cookies without a `SameSite` attribute are treated as `SameSite=Lax` by default. Consequently, a total of 75% of cookies set in a first-party context are effectively treated as if they were set to `Lax`.

### Prefixes

<a hreflang="en" href="https://owasp.org/www-community/attacks/Session_fixation">Session fixation</a> attacks can be mitigated by using cookie prefixes like `__Secure-` and `__Host-`. When a cookie name starts with `__Secure-`, the browser requires the cookie to have the `Secure` attribute and to be transmitted over an encrypted connection. For cookies with the `__Host-` prefix, the browser additionally mandates that the cookie includes the `Path` attribute set to `/` and excludes the `Domain` attribute. These requirements help protect cookies from man-in-the-middle attacks and threats from compromised subdomains.

<figure>
  <table>
    <thead>
      <tr>
        <th>Type of cookie</th>
        <th><code>__Secure</code></th>
        <th><code>__Host</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>First-party</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td>Third-party</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.04%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`__Secure-` and `__Host-` prefixes (desktop)", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

The adoption of cookie prefixes remains low, with less than 1% of cookies using these prefixes on both desktop and mobile platforms. This is particularly surprising given the high adoption rate of cookies with the `Secure` attribute, the only prerequisite for cookies prefixed with `__Secure-`. However, changing a cookie's name can require significant refactoring, which is presumably a reason why developers tend to avoid this.

### Cookie age

Websites can control how long browsers store a cookie by setting its lifespan. Browsers will discard cookies when they reach the age specified by the `Max-Age` attribute or when the timestamp defined in the `Expires` attribute is reached. If neither attribute is set, the cookie is considered a session cookie and will be removed when the session ends.

{{ figure_markup(
  image="cookie-age-desktop.png",
  caption="Cookie age in days (desktop).",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=675218634&format=interactive",
  sheets_gid="1897777778",
  sql_file="TODO.sql"
  )
}}

The distribution of cookie ages has remained largely unchanged compared to [lat year](../2022/security#cookie-age). However, since then, the <a hreflang="en" href="https://httpwg.org/http-extensions/draft-ietf-httpbis-rfc6265bis.html#name-cookie-lifetime-limits">cookie standard working draft</a> has been updated, capping the maximum cookie age to 400 days. This change has already been implemented in  <a hreflang="en" href="https://developer.chrome.com/blog/cookie-max-age-expires">Chrome</a> and Safari. Based on the percentiles shown above, in these browsers, more than 10% of all observed cookies have their age capped to this 400-day limit.

## Content inclusion

Content inclusion is a foundational aspect of the Web, allowing resources like CSS, JavaScript, fonts, and images to be shared via CDNs or reused across multiple websites. However, fetching content from external or third-party sources introduces significant risks. By referencing resources outside your control, you are placing trust in those third parties, which could either turn malicious or be compromised. This can lead to so-called supply-chain attacks, like the recent <a hreflang="en" href="https://www.darkreading.com/remote-workforce/polyfillio-supply-chain-attack-smacks-down-100k-websites">polyfill incident where compromised resources affected hundreds of thousands of websites</a>. Therefore, security policies that govern content inclusion are essential for protecting web applications.

### Content Security Policy

Websites can exert greater control over their embedded content by deploying a [Content Security Policy (CSP)](https://developer.mozilla.org/docs/Web/HTTP/CSP) through either the `Content-Security-Policy` response header or by defining the policy in a `<meta>` html tag. The wide range of directives available in CSP allows websites to specify, in a fine-grained manner, which resources can be fetched and from which origins.

In addition to vetting included content, CSP can serve other purposes as well, such as enforcing the use of encrypted channels with the `upgrade-insecure-requests` directive and controlling where the site can be embedded to protect against clickjacking attacks using the `frame-ancestors` directive.

{{ figure_markup(
  content="+27.4%",
  caption="Relative increase in adoption for Content-Security-Policy header from 2022.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

The adoption rate of CSP headers increased from 14.5% of all hosts in 2022 to 18.5% this year. This amounts to a relative increase of 27.4%.  Over these two years, the relative increase was 12.1% between 2022 and 2023, and 13.6% between 2023 and 2024.

Looking back, overall CSP adoption was only at 11.9% of hosts in 2021, so it's encouraging to see that growth has remained steady. If this trend continues, projections suggest that CSP adoption will surpass the 20% mark in next year's Web Almanac.

#### Directives

Most websites utilize CSP for purposes beyond controlling embedded resources, with the `upgrade-insecure-requests` and `frame-ancestors` directives being the most popular.

{{ figure_markup(
  image="csp-directives.png",
  caption="Most common directives used in CSP.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=123403022&format=interactive",
  sheets_gid="1796954328",
  sql_file="TODO.sql"
  )
}}

The `block-all-mixed-content` directive, which has been deprecated in favor of `upgrade-insecure-requests`, is the third most used directive. Although we observed a relative decrease of 12.5% and 13.8% in its usage between 2020 and 2021, the decline has since slowed to an average yearly decrease of 4.4% for desktop and 6.4% for mobile since 2022.

<figure>
  <table>
    <thead>
      <tr>
        <th>Policy</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
      <td>upgrade-insecure-requests;</td>
      <td class="numeric">27.1%</td>
      <td class="numeric">30.0%</td>
      </tr>
      <tr>
      <td>block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;</td>
      <td class="numeric">21.8%</td>
      <td class="numeric">21.9%</td>
      </tr>
      <tr>
      <td>frame-ancestors 'self';</td>
      <td class="numeric">10.8%</td>
      <td class="numeric">10.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent CSP headers", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

The top three directives also make up the building blocks of the most prevalent CSP definitions. The second most commonly used CSP definition includes both `block-all-mixed-content` and `upgrade-insecure-requests`. This suggests that many websites use `block-all-mixed-content` for backward compatibility, as newer browsers will ignore this directive if `upgrade-insecure-requests` is present.

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
        <td>-1.3%</td>
        <td>-0.5%</td>
      </tr>
      <tr>
        <td>frame-ancestors</td>
        <td class="numeric">5.1%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>block-all-mixed-content</td>
        <td>-8.8%</td>
        <td>-12.7%</td>
      </tr>
      <tr>
        <td>default-src</td>
        <td>-9.1%</td>
        <td>-6.3%</td>
      </tr>
      <tr>
        <td>script-src</td>
        <td>-3.0%</td>
        <td>-1.8%</td>
      </tr>
      <tr>
        <td>style-src</td>
        <td>-8.4%</td>
        <td>-2.3%</td>
      </tr>
      <tr>
        <td>img-src</td>
        <td>-2.8%</td>
        <td class="numeric">9.3%</td>
      </tr>
      <tr>
        <td>font-src</td>
        <td>-3.5%</td>
        <td class="numeric">8.1%</td>
      </tr>
      <tr>
        <td>connect-src</td>
        <td class="numeric">3.1%</td>
        <td class="numeric">16.8%</td>
      </tr>
      <tr>
        <td>frame-src</td>
        <td class="numeric">3.9%</td>
        <td class="numeric">16.1%</td>
      </tr>
      <tr>
        <td>object-src</td>
        <td class="numeric">15.9%</td>
        <td class="numeric">16.8%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Relative usage change of CSP directives", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

All other directives shown in the graph above are used for content inclusion control. Overall, usage has remained relatively stable. However, a notable change is the increased use of the `object-src` directive, which has surpassed `connect-src` and `frame-src`. Since 2022, the usage of `object-src` has risen by 15.9% for desktop and 16.8% for mobile.

Among the most notable decreases in usage is `default-src`, the catch-all directive. This decline could be explained by the increasing use of CSP for purposes beyond content inclusion, such as enforcing HTTP upgrades to HTTPS or controlling the embedding of the current page – situations where `default-src` is not applicable, as these directives don't fallback to it. This change in CSP purpose is confirmed by the most prevalent CSP headers listed in Table [TODO 1], which all have seen an increase in usage since 2022. However, directives like `upgrade-insecure-requests` and `block-all-mixed-content`, while part of these most common CSP headers, are being used less overall, as seen in Table [TODO 2].

#### Keywords for `script-src`

One of the most important directives of CSP is `script-src`, as curbing the scripts that can be embedded in the website hinders potential adversaries greatly. This directive can be used with several attribute keywords.

{{ figure_markup(
  image="csp-script-src-keywords.png",
  caption="Prevalence of CSP `script-src` keywords.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1661557245&format=interactive",
  sheets_gid="2075772620",
  sql_file="TODO.sql"
  )
}}

The `unsafe-inline` and `unsafe-eval` directives can significantly reduce the security benefits provided by CSP. The `unsafe-inline` directive permits the execution of inline scripts, while `unsafe-eval` allows the use of the eval JavaScript function. Unfortunately, the use of these insecure practices remains widespread, demonstrating the challenges of avoiding use of inline scripts and use of the `eval` function.

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
        <td>nonce-</td>
        <td class="numeric">61.8%</td>
        <td class="numeric">39.4%</td>
      </tr>
      <tr>
        <td>strict-dynamic</td>
        <td class="numeric">61.3%</td>
        <td class="numeric">88.3%</td>
      </tr>
      <tr>
        <td>unsafe-inline</td>
        <td>-3.2%</td>
        <td>-3.4%</td>
      </tr>
      <tr>
        <td>unsafe-eval</td>
        <td>-2.6%</td>
        <td>-0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Relative usage change of CSP `script-src` keywords", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

However, the increasing adoption of the `nonce-` and `strict-dynamic` keywords is a positive development. By using the `nonce-` keyword, a secret nonce can be defined, allowing only inline scripts with the correct nonce to execute. This approach is a secure alternative to the unsafe-inline directive for permitting inline scripts. When used in combination with the `strict-dynamic` keyword, nonced scripts are permitted to import additional scripts from any origin. This approach simplifies secure script loading for developers, as it allows them to trust a single nonced script, which can then securely load other necessary resources.

#### Allowed hosts

CSP is often regarded as one of the more complex security policies, partly due to the detailed policy language, providing fine-grained control over resource inclusion.

{{ figure_markup(
  image="csp-header-length.png",
  caption="CSP header length.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1260468464&format=interactive",
  sheets_gid="1351027608",
  sql_file="TODO.sql"
  )
}}

Reviewing the observed CSP header lengths, we find that 75% of all headers are 75 bytes or shorter. For context, the longest policy among the [Most Prevalent CSP Definitions] Table is also 75 bytes. At the 90th percentile, desktop policies reach 504 bytes and mobile policies 368 bytes, indicating that many websites find it necessary to implement relatively lengthy Content Security Policies. However, when analyzing the distribution of unique allowed hosts across all policies, the 90th percentile shows just 2 unique hosts.

The highest number of unique allowed hosts in a policy was 1,020, while the longest Content Security Policy header reached 65,535 bytes. However, this latter header is inflated by a large number of repeated `,` characters for unknown reasons. The second longest CSP header, which is valid, spans 33,123 bytes. This unusually large size is due to hundreds of occurrences of the `adservice.google` domain, each with variations in the top-level domain. Excerpt:

```
adservice.google.com adservice.google.ad adservice.google.ae …
```

This suggests that the long tail of excessively large CSP headers is likely caused by computer-generated exhaustive lists of origins. Although this may seem like a specific edge case, it highlights a limitation of CSP: the lack of regex functionality, which could otherwise provide a more efficient and elegant solution to handle such cases. However, depending on the websites implementation, this issue could also be solved by employing the `strict-dynamic`and `nonce-` keyword in the `script-src` directive, which enables the allowed script with nonce to load additional scripts.

The most common HTTPS origins included in CSP headers are used for loading fonts, ads and other media fetched from CDNs:

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
        <td><code>https://www.googletagmanager.com</code></td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.32%</td>
      </tr>
      <tr>
        <td><code>https://fonts.gstatic.com<code></td>
        <td class="numeric">0.34%</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td><code>https://fonts.googleapis.com</code></td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td><code>https://www.google-analytics.com</code></td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>https://www.google.com</code></td>
        <td class="numeric">0.30%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>https://www.youtube.com</code></td>
        <td class="numeric">0.26%</td>
        <td class="numeric">0.23%</td>
      </tr>
      <tr>
        <td><code>https://*.google-analytics.com</code></td>
        <td class="numeric">0.25%</td>
        <td class="numeric">0.23%</td>
      </tr>
      <tr>
        <td><code>https://connect.facebook.net</code></td>
        <td class="numeric">0.20%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td><code>https://*.google.com</code></td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td><code>https://*.googleapis.com</code></td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.19%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most frequently allowed HTTP(S) hosts in CSP policies", sheets_gid="180799456", sql_file="TODO.sql") }}</figcaption>
</figure>

As for WSS origins, used for allowing WebSockets connections to certain origins, the following were found the most common:

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
        <td><code>wss://*.intercom.io</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.08%</td>
      </tr>
      <tr>
        <td><code>wss://*.hotjar.com</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>wss://www.livejournal.com</code></td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>wss://*.quora.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>wss://*.zopim.com</code></td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most frequently allowed WS(S) hosts in CSP policies", sheets_gid="1790517281", sql_file="TODO.sql") }}</figcaption>
</figure>

Two of these origins are related to customer service and ticketing (`intercom.io`, `zopim.com`), one is used for website analytics (`hotjar.com`), and two are associated with social media (`www.livejournal.com`, `quora.com`). For four out of the five websites, we found specific instructions on how to add the origin to the website's content security policy. This is considered good practice, as it discourages website administrators from using wildcards to allow third-party resources, which would reduce security by allowing broader access than necessary.

### Subresource Integrity

While CSP is a powerful tool for ensuring that resources are only loaded from trusted origins, there remains a risk that those resources could be tampered with. For instance, a script might be loaded from a trusted CDN, but if that CDN suffers a security breach and its scripts are compromised, any website using one of those scripts could become vulnerable as well.

[Subresource Integrity (SRI)](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity) provides a safeguard against this risk. By using the `integrity` attribute in `<script>` and `<link>` tags, a website can specify the expected hash of a resource. If the hash of the received resource does not match the expected hash, the browser will refuse to render the resource, thereby protecting the website from potentially compromised content.

{{ figure_markup(
  content="23%",
  caption="Desktop sites using SRI.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

SRI is used by 23.2% and 21.3% of all observed pages for desktop and mobile respectively. This amounts to a relative change in adoption of 13.3% and 18.4% respectively.

{{ figure_markup(
  image="sri-coverage.png",
  caption="SRI coverage per page.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=13429035&format=interactive",
  sheets_gid="359913254",
  sql_file="TODO.sql"
  )
}}

The adoption of Subresource Integrity seems to be stagnating, with the median percentage of scripts checked against a hash remaining at 3.23% for both desktop and mobile. This figure has remained virtually unchanged since 2022.

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
        <td><code>www.gstatic.com</code></td>
        <td class="numeric">35.27%</td>
        <td class="numeric">35.43%</td>
      </tr>
      <tr>
        <td><code>cdnjs.cloudflare.com</code></td>
        <td class="numeric">7.31%</td>
        <td class="numeric">7.35%</td>
      </tr>
      <tr>
        <td><code>cdn.userway.org</code></td>
        <td class="numeric">6.20%</td>
        <td class="numeric">5.69%</td>
      </tr>
      <tr>
        <td><code>static.cloudflareinsights.com</code></td>
        <td class="numeric">6.07%</td>
        <td class="numeric">5.97%</td>
      </tr>
      <tr>
        <td><code>code.jquery.com</code></td>
        <td class="numeric">5.36%</td>
        <td class="numeric">5.58%</td>
      </tr>
      <tr>
        <td><code>cdn.jsdelivr.net</code></td>
        <td class="numeric">3.92%</td>
        <td class="numeric">4.27%</td>
      </tr>
      <tr>
        <td><code>d3e54v103j8qbb.cloudfront.net</code></td>
        <td class="numeric">2.15%</td>
        <td class="numeric">1.88%</td>
      </tr>
      <tr>
        <td><code>t1.daumcdn.net</code></td>
        <td class="numeric">1.82%</td>
        <td class="numeric">1.14%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most common hosts from which SRI-protected scripts are included", sheets_gid="1612151810", sql_file="TODO.sql") }}</figcaption>
</figure>

Most of the hosts from which resources are fetched and protected by SRI are CDNs. A notable difference from 2022's data is the absence of `cdn.shopify.com` from the top hosts list (previously 22% on desktop and 23% on mobile). This is due to Shopify having dropped SRI in favor of similar functionality provided by the `integrity` attribute of `importmap`, which they explain in a <a hreflang="en" href="https://shopify.engineering/shipping-support-for-module-script-integrity-in-chrome-safari#">blogpost</a>.

### Permissions Policy

The [Permissions Policy](https://developer.mozilla.org/docs/Web/HTTP/Permissions_Policy) (formerly known as the Feature Policy) is similar to the Content Security Policy but focuses on controlling access to features rather than resources. Websites can request access to various features from the browser, such as geolocation, webcam, microphone, and more. By employing the Permissions Policy, websites can restrict which features can be accessed by the main site and all embedded `<iframe>` elements, enhancing security and user privacy.

{{ figure_markup(
  content="+1.3%",
  caption="Relative increase in adoption of `Permissions-Policy` from 2022..",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

In 2022, the adoption of the Permissions Policy saw a significant relative increase of 85%. However, from 2022 to this year, the growth rate has drastically slowed to just 1.3%. This is expected, as the Permissions Policy was only introduced in 2021 in Chromium-based browsers under its current name, leading to an initial spike in adoption.

<figure>
  <table>
    <thead>
      <tr>
        <th>Header</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>interest-cohort=()</code></td>
        <td class="numeric">21.28%</td>
        <td class="numeric">21.05%</td>
      </tr>
      <tr>
        <td><code>geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()</code></td>
        <td class="numeric">5.44%</td>
        <td class="numeric">5.54%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), autoplay=(), camera=(), cross-origin-isolated=(), display-capture=(self), encrypted-media=(), fullscreen=*, geolocation=(self), gyroscope=(), keyboard-map=(), magnetometer=(), microphone=(), midi=(), payment=*, picture-in-picture=(), publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=(), usb=(), xr-spatial-tracking=(), gamepad=(), serial=()</code></td>
        <td class="numeric">3.92%</td>
        <td class="numeric">4.01%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(self), autoplay=(self), camera=(self), encrypted-media=(self), fullscreen=(self), geolocation=(self), gyroscope=(self), magnetometer=(self), microphone=(self), midi=(self), payment=(self), usb=(self)</code></td>
        <td class="numeric">2.81%</td>
        <td class="numeric">2.92%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()</code></td>
        <td class="numeric">2.73%</td>
        <td class="numeric">2.55%</td>
      </tr>
      <tr>
        <td><code>browsing-topics=()</code></td>
        <td class="numeric">2.61%</td>
        <td class="numeric">3.40%</td>
      </tr>
      <tr>
        <td><code>geolocation=self</code></td>
        <td class="numeric">2.23%</td>
        <td class="numeric">2.37%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent Permission Policies", sheets_gid="2018859098", sql_file="TODO.sql") }}</figcaption>
</figure>

Only 2.8% of desktop hosts and 2.5% of mobile hosts set the policy using the `Permissions-Policy` response header. The policy is primarily used to exclusively opt out of Google's <a hreflang="en" href="https://privacysandbox.com/intl/en_us/proposals/floc/">Federated Learning of Cohorts (FLoC)</a>; 21.3% of hosts that implement the Permissions Policy set the policy as `interest-cohort=()`. This usage is partly due to the controversy that FLoC sparked during its trial period. Although FLoC was ultimately replaced by the [Topics API](https://developer.mozilla.org/docs/Web/API/Topics_API),  the continued use of the `interest-cohort` directive highlights how specific concerns can shape the adoption of web policies.

All other observed policies with at least 2% of hosts implementing them, are aimed at restricting the permission capabilities of the website itself and/or its embedded `<iframe>` elements. Similar to the Content Security Policy, the Permissions Policy is *"open by default"* instead of *"secure by default"*; absence of the policy entails absence of protection. This approach aims to avoid breaking website functionality when introducing new policies. Notably, 0.28% of sites explicitly use the `*` wildcard policy, allowing the website and all embedded `<iframe>` elements to request any permission - though this is the default behavior when the Permissions Policy is not set.

The Permissions Policy can also be defined individually for each embedded `<iframe>` through its `allow` attribute. For example, an `<iframe>` can be permitted to use the geolocation and camera permissions by setting the attribute as follows:

```html
<iframe src="<a hreflang="en" href="https://example.com">https://example.com</a>" allow="geolocation 'self'; camera *;"></iframe>
```

Out of the 21.4 million `<iframe>` elements observed in the crawl, half included the `allow` attribute. This marks a significant increase compared to **even just the previous month**, when only 21% of `<iframe>` elements had the allow attribute - indicating that its usage has more than doubled in just one month. A plausible explanation for this rapid change is that one or several widely-used third-party services have propagated this update across their `<iframe>` elements. Given the ad-specific directives we now observe (displayed in the table below, row 1 and 3) - none of which were present in 2022 - it is likely that an ad service is responsible for this shift.

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
        <td><code>join-ad-interest-group</code></td>
        <td class="numeric">43.05%</td>
        <td class="numeric">43.57%</td>
      </tr>
      <tr>
        <td><code>attribution-reporting</code></td>
        <td class="numeric">27.51%</td>
        <td class="numeric">28.50%</td>
      </tr>
      <tr>
        <td><code>run-ad-auction</code></td>
        <td class="numeric">24.58%</td>
        <td class="numeric">24.24%</td>
      </tr>
      <tr>
        <td><code>encrypted-media</code></td>
        <td class="numeric">19.26%</td>
        <td class="numeric">18.29%</td>
      </tr>
      <tr>
        <td><code>autoplay</code></td>
        <td class="numeric">17.70%</td>
        <td class="numeric">17.66%</td>
      </tr>
      <tr>
        <td><code>picture-in-picture</code></td>
        <td class="numeric">11.54%</td>
        <td class="numeric">11.52%</td>
      </tr>
      <tr>
        <td><code>clipboard-write</code></td>
        <td class="numeric">10.16%</td>
        <td class="numeric">10.12%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">9.31%</td>
        <td class="numeric">9.89%</td>
      </tr>
      <tr>
        <td><code>accelerometer</code></td>
        <td class="numeric">9.19%</td>
        <td class="numeric">9.78%</td>
      </tr>
      <tr>
        <td><code>web-share</code></td>
        <td class="numeric">6.89%</td>
        <td class="numeric">6.60%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent allow attribute values", sheets_gid="1497012339", sql_file="TODO.sql") }}</figcaption>
</figure>

Compared to 2022, the top 10 most common directives are now led by three newly introduced directives: `join-ad-interest-group`, `attribution-reporting` and `run-ad-auction`. The first and third directives are specific to Google's Privacy Sandbox. All observed `<iframe>` elements with the allow attribute present use these directives without any arguments (e.g., `'none'` or a specific origin), meaning the loaded page is allowed to request the indicated permission regardless of its origin. This permissive setting suggests that the introduction of these directives may have contributed to the increased use of the `allow` attribute in `<iframe>` elements.

### Iframe sandbox

Embedding third-party websites within `<iframe>` elements always carries risks, though it might be necessary to enrich a web application's functionality. Website administrators should be aware that a rogue `<iframe>` can exploit several mechanisms to harm users, such as launching pop-ups or redirecting the top-level page to a malicious domain.

These risks can be curbed by employing the `sandbox` attribute on `<iframe>` elements. Doing this, the content loaded within is restricted to rules defined by the attribute, and can be used to prevent the embedded content from abusing capabilities. When provided with an empty string as value, the policy is strictest. However, this policy can be relaxed by adding specific directives, of which each has their own specific relaxation rules. For example, the following `<iframe>` would allow the embedded webpage to run scripts:

```html
<iframe src="<a hreflang="en" href="https://example.com">https://example.com</a>" sandbox="allow-scripts"></iframe>
```

The `sandbox` attribute was observed in 28.4% and 27.5% of `<iframe>` elements for desktop and mobile respectively, a considerable drop from the 35.2% and 32% reported in 2022. Much like the sudden spike in `allow` attribute usage mentioned in the previous section, this decline could be attributed to a change in the modus operandi of an embedded service, where the `sandbox` attribute was omitted from the template `<iframe>`.

{{ figure_markup(
  image="iframe-sandbox-directives.png",
  caption="Prevalence of sandbox directives on frames.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=22462766&format=interactive",
  sheets_gid="873346022",
  sql_file="TODO.sql"
  )
}}

More than 98% of pages that have the `sandbox` attribute set in an iframe, use it to allow scripts in the embedded webpage, using the `allow-scripts` directive.

## Attack preventions

Web applications can be exploited in numerous ways, and while there are many methods to protect them, it can be difficult to see the full range of options. This challenge is heightened when protections are not enabled by default or require opt-in. In other words, website administrators must be aware of potential attack vectors relevant to their application and how to prevent them. Therefore, evaluating which attack prevention measures are in place is crucial for assessing the overall security of the Web.

### Security header adoption

Most security policies are configured through response headers, which instruct the browser on which policies to enforce. Although not every security policy is relevant for every website, the absence of certain security headers suggests that website administrators may not have considered or prioritized security measures.

{{ figure_markup(
  image="security-headers-desktop.png",
  caption="Adoption of security headers for site requests in desktop pages.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1591831239&format=interactive",
  sheets_gid="238539331",
  sql_file="TODO.sql",
  height=496,
  width=600
  )
}}

Over the past two years, three security headers have seen a decrease in usage. The most notable decline is in the `[Expect-CT](https://developer.mozilla.org/docs/Web/HTTP/Headers/Expect-CT)` header, which was used to opt into [Certificate Transparency](https://developer.mozilla.org/docs/Web/Security/Certificate_Transparency). This header is now deprecated because Certificate Transparency is enabled by default. Similarly, the `Feature-Policy` header has decreased in usage due to its replacement by the `Permissions-Policy` header. Lastly, the `Content-Security-Policy-Report-Only` header has also declined. This header was used primarily for testing and monitoring the impact of a Content Security Policy by sending violation reports to a specified endpoint. It's important to note that the `Report-Only` header does not enforce the Content Security Policy itself, so its decline in usage does not indicate a reduction in security. Since none of these headers impact security, we can safely assume that the overall adoption of security headers continues to grow, reflecting a positive trend in web security.

The strongest absolute risers since 2022 are `Strict-Transport-Security` (+5.3%), `X-Content-Type-Options` (+4.9%) and `Content-Security-Policy` (+4.2%).

### Preventing clickjacking with CSP and `X-Frame-Options`

As discussed in Section [TODO: ref], one of the primary uses of the Content Security Policy (CSP) is to prevent clickjacking attacks. This is achieved through the `frame-ancestors` directive, which allows websites to specify which origins are permitted to embed their pages within a frame. As shown in Table [TODO: ref], this directive is commonly used to either completely prohibit embedding or restrict it to the same origin.

Another measure against clickjacking is the [`X-Frame-Options` (XFO](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Frame-Options)) header, though it provides less granular control compared to CSP. The XFO header can be set to `SAMEORIGIN`, allowing the page to be embedded only by other pages from the same origin, or `DENY`, which completely blocks any embedding of the page. As shown in the table below, most headers are configured to relax the policy by allowing same-origin websites to embed the page.

<figure>
  <table>
    <thead>
      <tr>
        <th>Header</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>SAMEORIGIN</code></td>
        <td class="numeric">73.12%</td>
        <td class="numeric">72.62%</td>
      </tr>
      <tr>
        <td><code>DENY</code></td>
        <td class="numeric">23.42%</td>
        <td class="numeric">23.82%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`X-Frame-Options` header values", sheets_gid="609220671", sql_file="TODO.sql") }}</figcaption>
</figure>

Although deprecated, 0.6% of observed `X-Frame-Options` headers on desktop and 0.7% on mobile still use the `ALLOW-FROM` directive, which functions similarly to the `frame-ancestors` directive by specifying trusted origins that can embed the page. However, since modern browsers ignore `X-Frame-Options` headers containing the `ALLOW-FROM` directive, this could create gaps in the website's clickjacking defenses. However, this practice may be intended for backward compatibility, where the deprecated header is used alongside a supported Content Security Policy that includes the `frame-ancestors` directive.

### Preventing attacks using Cross-Origin policies

One of the core principles of the Web is the reuse and embedding of cross-origin resources. However, our security perspective on this practice has significantly shifted with the emergence of micro-architectural attacks like Spectre and Meltdown, and Cross-Site Leaks (<a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a>) that leverage side-channels to uncover potentially sensitive user information. These threats have created a growing need for mechanisms to control whether and how resources can be rendered by other websites, whilst ensuring better protection against these new exploits.

This demand led to the introduction of several new security headers collectively known as *Cross-Origin* policies: `Cross-Origin-Resource-Policy` (CORP), `Cross-Origin-Embedder-Policy` (COEP) and `Cross-Origin-Opener-Policy` (COOP). These headers provide robust countermeasures against side-channel attacks by controlling how resources are shared and embedded across origins. Adoption of these policies has been steadily increasing, with the use of Cross-Origin-Opener-Policy nearly doubling each year for the past two years.

{{ figure_markup(
  image="cross-origin-headers-trend.png",
  caption="Usage of Cross-Origin headers in 2022, 2023 and 2024.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=114530565&format=interactive",
  sheets_gid="238539331",
  sql_file="TODO.sql",
  width=600,
  height=401
  )
}}

#### Cross Origin Embedder Policy

The [Cross Origin Embedder Policy](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy) restricts the capabilities of websites that embed cross-origin resources. Currently, websites no longer have access to powerful features like `SharedArrayBuffer` and unthrottled timers through the `Performance.now()` API, as these can be exploited to infer sensitive information from cross-origin resources. If a website requires access to these features, it must signal to the browser that it intends to interact only with cross-site resources via credentialless requests (`credentialless`) or with resources that explicitly permit access from other origins using the `Cross-Origin-Resource-Policy` header (`require-corp`).

<figure>
  <table>
    <thead>
      <tr>
        <th>COEP value</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">85.53%</td>
        <td class="numeric">88.30%</td>
      </tr>
      <tr>
        <td><code>require-corp</code></td>
        <td class="numeric">6.54%</td>
        <td class="numeric">4.78%</td>
      </tr>
      <tr>
        <td><code>credentialless</code></td>
        <td class="numeric">2.06%</td>
        <td class="numeric">1.56%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of COEP header values", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

The majority of websites that set the `Cross-Origin-Embedder-Policy` header indicate that they do not require access to the powerful features mentioned above (`unsafe-none`). This behavior is also the default if the COEP header is absent, meaning that websites will automatically operate under restricted access to cross-origin resources unless explicitly configured otherwise.

#### Cross Origin Resource Policy

Conversely, websites that serve resources can use the[ `Cross-Origin-Resource-Policy` response header](https://developer.mozilla.org/docs/Web/HTTP/Cross-Origin_Resource_Policy) to grant explicit permission for other websites to render the served resource. This header can take one of three values: `same-site`, allowing only requests from the same site to receive the resource; `same-origin`, restricting access to requests from the same origin; and `cross-origin`, permitting any origin to access the resource. Beyond mitigating side-channel attacks, CORP can also protect against Cross-Site Script Inclusion (XSSI). For instance, by disallowing a dynamic JavaScript resource from being served to cross-origin websites, CORP helps prevent the leaking of scripts with sensitive info.

<figure>
  <table>
    <thead>
      <tr>
        <th>CORP value</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>cross-origin</code></td>
        <td class="numeric">91.12%</td>
        <td class="numeric">91.43%</td>
      </tr>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">4.99%</td>
        <td class="numeric">4.57%</td>
      </tr>
      <tr>
        <td><code>same-site</code></td>
        <td class="numeric">3.67%</td>
        <td class="numeric">3.81%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of CORP header values", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

The CORP header is primarily used to allow access to the served resource from any origin, with the `cross-origin` value being the most commonly set. In fewer cases, the header restricts access: less than 5% of websites limit resources to the same origin, and less than 4% restrict them to the same site.

#### Cross Origin Opener Policy

[Cross Origin Opener Policy](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy) (COOP) helps control how other web pages can open and reference the protected page. COOP protection can be explicitly disabled with `unsafe-none`, which is also the default behavior in absence of the header. The `same-origin` value allows references from pages with the same origin and `same-origin-allow-popups` additionally allows references with windows or tabs. Similar to the Cross Origin Embedder Policy, features like the `SharedArrayBuffer` and `Performance.now()` are restricted unless COOP is configured as `same-origin`.

<figure>
  <table>
    <thead>
      <tr>
        <th>COOP value</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">49.18%</td>
        <td class="numeric">47.59%</td>
      </tr>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">35.25%</td>
        <td class="numeric">36.91%</td>
      </tr>
      <tr>
        <td><code>same-origin-allow-popups</code></td>
        <td class="numeric">14.19%</td>
        <td class="numeric">14.25%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of COOP header values", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

Nearly half of all observed COOP headers employ the strictest setting, `same-origin`.

### Preventing attacks using Clear-Site-Data

The [`Clear-Site-Data` header](https://developer.mozilla.org/docs/Web/HTTP/Headers/Clear-Site-Data) allows websites to easily clear browsing data associated with them, including cookies, storage, and cache. This is particularly useful as a security measure when a user logs out, ensuring that authentication tokens and other sensitive information are removed and cannot be abused. The header's value specifies what types of data the website requests the browser to clear.

Adoption of the `Clear-Site-Data` header remains limited; our observations indicate that only 2,071 hosts (0.02% of all hosts) use this header. However, this functionality is primarily useful on logout pages, which the crawler does not capture. To investigate logout pages, the crawler would need to be extended to detect and interact with account registration, login, and logout functionality – an undertaking that would require quite some effort. Some progress has already been made in this area by security and privacy researchers, such as automating logins to web pages [ref to <a hreflang="en" href="https://www.ndss-symposium.org/wp-content/uploads/2020/02/23008-paper.pdf">Shepherd: a Generic Approach to Automating Website Login</a>], and automating registering [ref to <a hreflang="en" href="https://dl.acm.org/doi/pdf/10.1145/3589334.3645709">Automating Website Registration for Studying GDPR Compliance</a>].

<figure>
  <table>
    <thead>
      <tr>
        <th>Clear site data value</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>"cache"</code></td>
        <td class="numeric">35.99%</td>
        <td class="numeric">33.69%</td>
      </tr>
      <tr>
        <td><code>cache</code></td>
        <td class="numeric">22.43%</td>
        <td class="numeric">22.98%</td>
      </tr>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">12.41%</td>
        <td class="numeric">13.26%</td>
      </tr>
      <tr>
        <td><code>cookies</code></td>
        <td class="numeric">4.49%</td>
        <td class="numeric">5.56%</td>
      </tr>
      <tr>
        <td><code>"cache", "storage", "executionContexts"</code></td>
        <td class="numeric">2.91%</td>
        <td class="numeric">4.35%</td>
      </tr>
      <tr>
        <td><code>"cookies"</code></td>
        <td class="numeric">1.96%</td>
        <td class="numeric">1.61%</td>
      </tr>
      <tr>
        <td><code>"cache", "cookies", "storage", "executionContexts"</code></td>
        <td class="numeric">1.96%</td>
        <td class="numeric">2.46%</td>
      </tr>
      <tr>
        <td><code>"storage"</code></td>
        <td class="numeric">1.86%</td>
        <td class="numeric">1.57%</td>
      </tr>
      <tr>
        <td><code>"cache", "storage"</code></td>
        <td class="numeric">1.34%</td>
        <td class="numeric">0.99%</td>
      </tr>
      <tr>
        <td><code>cache, cookies, storage</code></td>
        <td class="numeric">1.29%</td>
        <td class="numeric">1.16%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of `Clear-Site-Data` headers", sheets_gid="910609664", sql_file="TODO.sql") }}</figcaption>
</figure>

Current usage data shows that the `Clear-Site-Data header` is predominantly used to clear cache. It's important to note that the values in this header must be enclosed in quotation marks; for instance, `cache` is incorrect and should be written as `"cache"`. Interestingly, there has been significant improvement in adherence to this syntax rule: in 2022, 65% of desktop and 63% of mobile websites were found using the incorrect `cache` value. However, these numbers have now dropped to 22% and 23% for desktop and mobile, respectively.

### Preventing attacks using `<meta>`

Some security mechanisms on the web can be configured through `meta` tags in the source HTML of a web page, for instance the `Content-Security-Policy` and `Referrer-Policy`. This year, 0.61% and 2.53% of mobile websites enable CSP and Referrer-Policy respectively using `meta` tags. This year we find that there is a slight increase in the use of this method for setting the Referrer-Policy yet a slight decrease for setting CSP.

<figure>
  <table>
    <thead>
      <tr>
        <td>Meta tag</td>
        <td>Desktop</td>
        <td>Mobile</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>includes <code>Referrer-policy</code></td>
        <td class="numeric">2.73%</td>
        <td class="numeric">2.53%</td>
      </tr>
      <tr>
        <td>includes CSP</td>
        <td class="numeric">0.56%</td>
        <td class="numeric">0.61%</td>
      </tr>
      <tr>
        <td>includes <code>not-allowed policy</code></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.07%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The percentage of hosts enabling different policies using a meta tag", sheets_gid="1466205888", sql_file="TODO.sql") }}</figcaption>
</figure>

Developers sometimes also try to enable other security features by using the `meta` tag, which is not allowed and will thus be ignored. Using the same example as in 2022, `4976` pages try to set the `X-Frame-Options` using a `meta` tag, which will be ignored by the browser. This is an absolute increase compared to 2022, but only because there were more than twice as many pages included in the data set. Relatively, there is a slight decrease from 0.04% to 0.03% on  mobile pages and 0.05% to 0.03% on desktop pages.

### Web Cryptography API

<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a> is a JavaScript API for performing basic cryptographic operations on a website such as random number generation, hashing, signature generation and verification, and encryption and decryption.

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
        <td>CryptoGetRandomValues</td>
        <td class="numeric">55.92%</td>
        <td class="numeric">53.24%</td>
      </tr>
      <tr>
        <td>SubtleCryptoDigest</td>
        <td class="numeric">1.92%</td>
        <td class="numeric">1.74%</td>
      </tr>
      <tr>
        <td>SubtleCryptoImportKey</td>
        <td class="numeric">1.69%</td>
        <td class="numeric">1.60%</td>
      </tr>
      <tr>
        <td>CryptoAlgorithmSha256</td>
        <td class="numeric">1.58%</td>
        <td class="numeric">1.30%</td>
      </tr>
      <tr>
        <td>CryptoAlgorithmEcdh</td>
        <td class="numeric">1.32%</td>
        <td class="numeric">1.34%</td>
      </tr>
      <tr>
        <td>CryptoAlgorithmSha512</td>
        <td class="numeric">0.24%</td>
        <td class="numeric">0.24%</td>
      </tr>
      <tr>
        <td>CryptoAlgorithmAesCbc</td>
        <td class="numeric">0.23%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>CryptoAlgorithmSha1</td>
        <td class="numeric">0.22%</td>
        <td class="numeric">0.21%</td>
      </tr>
      <tr>
        <td>SubtleCryptoEncrypt</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>SubtleCryptoSign</td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.12%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The usages of features of the Web Cryptography API", sheets_gid="527224984", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

In comparison to the last Almanac, the CryptoGetRandomValues continued to drop and it did so at a much higher rate in the past two years, dropping down to 53%. Despite that drop, it clearly continues to be the most adopted feature, far ahead of the other features. After CryptoGeRandomValues, the next five most used features have become more widely adopted, rising from under 0.7% to adoption rates between 1.3% and 2%.

### Bot protection services

Because bad bots remain a significant issue on the modern web, we see that the adoption of protections against bots has continued to rise. We observe another jump in adoption from 29% of desktop sites and 26% of mobile sites in 2022 to 33% and 32% respectively now. It seems that developers have invested in protecting more mobile websites, bringing the number of protected desktop and mobile sites closer together.

{{ figure_markup(
  image="bot-protection.png",
  caption="The distribution of bot protection services in use.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1013362582&format=interactive",
  sheets_gid="894893633",
  sql_file="bot_detection.sql"
  )
}}

reCAPTCHA remains the largest protection mechanism in use, but has seen a reduction in its use. In comparison, Cloudflare Bot Management has seen an increase in adoption and remains the second largest protection in use.

### HTML sanitization

A new addition to major browsers are the `setHTMLUnsafe` and `ParseHTMLUnsafe` APIs, that allow a developer to <a hreflang="en" href="https://developer.chrome.com/blog/new-in-chrome-124#dsd">use a declarative shadow DOM from JavaScript</a>. When a developer uses custom HTML components from JavaScript that include a definition for a declarative shadow DOM using `<template shadowrootmode="open">...</template>`, using `innerHTML` to place this component on the page will not work as expected. This can be prevented by using the alternative `setHTMLUnsafe` that makes sure the declarative shadow DOM is taken into account.

When using these APIs, developers must be careful to only pass already safe values to these APIs because as the names imply they are unsafe, meaning they will not sanitize input given, which may lead to XSS attacks.

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
        <td><code>ParseHTMLUnsafe</code></td>
        <td class="numeric">6</td>
        <td class="numeric">6</td>
      </tr>
      <tr>
        <td><code>SetHTMLUnsafe</code></td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The number of pages using HTML sanitization APIs", sheets_gid="351726153", sql_file="html_sanitization_usage.sql") }}</figcaption>
</figure>

These APIs are new, so low adoption is to be expected. We found only 6 pages in total using `parseHTMLUnsafe` and 2 using `setHTMLUnsafe`, which is an extremely small number relative to the number of pages visited.

## Drivers of security mechanism adoption

Web developers can have many reasons to adopt more security practices. The three primary ones are:

- Societal: in certain countries there is more security-oriented education, or there may be local laws that take more punitive measures in case of a data breach or other cybersecurity-related incident
- Technological: depending on the technology stack in use, it might be easier to adopt security features. Some features might not be supported and would require additional effort to implement. Adding to that, certain vendors of software might enable security features by default in their products or hosted solutions
- Popularity: widely popular websites may face more targeted attacks than a website that is less known, but may also attract more security researchers or white hat hackers to look at their products, helping the site implement more security features correctly

### Location of website

The location where a website  is hosted or its developers are based can often have impacts on adoption of security features. The security awareness among developers will play a role, as they cannot implement features that they aren't aware of. Additionally, local laws can sometimes mandate the adoption of certain security practices.

{{ figure_markup(
  image="https-by-country.png",
  caption="The adoption of HTTPS per country; top and bottom 10 countries.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1581226643&format=interactive",
  sheets_gid="1565826362",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=617
  )
}}

New Zealand continues to lead in the adoption of HTTPS websites, however, many countries are following the adoption extremely closely as the top 9 countries all reach adoption of over 99%! Also the trailing 10 countries have all seen a rise in HTTPS adoption by 9% to 10%, with all countries now reaching adoption above 90%! This shows that almost all countries continue their efforts in making HTTPS the default mode.

{{ figure_markup(
  image="csp-xfo-by-country.png",
  caption="The adoption of CSP and XFO per country; top and bottom 5 countries.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=970684068&format=interactive",
  sheets_gid="1565826362",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=598
  )
}}

We see that the top 5 countries in terms of CSP adoption have CSP enabled on almost a quarter of their websites. The trailing countries have also seen an increase in the use of CSP, albeit a more moderate one. In general the adoption of both XFO and CSP remains very varied among countries, and the gap between CSP and XFO remains equally large if not larger compared to 2022, reaching up to 15%.

### Technology stack

Many sites on the current web are made using large CMS systems. These may enable security features by default to protect their users.

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
        <td>Wix</td>
        <td>Strict-Transport-Security (99.9%),<br>X-Content-Type-Options (99.9%)</td>
      </tr>
      <tr>
        <td>Blogger</td>
        <td>X-Content-Type-Options (99.8%),<br>X-XSS-Protection (99.8%)</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td>Strict-Transport-Security (98.9%),<br>X-Content-Type-Options (99.1%)</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td>X-Content-Type-Options (90.3%),<br>X-Frame-Options (87.9%)</td>
      </tr>
      <tr>
        <td>Google Sites</td>
        <td>Content-Security-Policy (99.9%),<br>Cross-Origin-Opener-Policy (99.8%),<br>Cross-Origin-Resource-Policy (99.8%),<br>Referrer-Policy (99.8%),<br>X-Content-Type-Options (99.9%),<br>X-Frame-Options (99.9%),<br>X-XSS-Protection (99.9%)</td>
      </tr>
      <tr>
        <td>Medium</td>
        <td>Content-Security-Policy (99.2%),<br>Strict-Transport-Security (96.4%),<br>X-Content-Type-Options (99.1%)</td>
      </tr>
      <tr>
        <td>Substack</td>
        <td>Strict-Transport-Security (100%),<br>X-Frame-Options (100%)</td>
      </tr>
      <tr>
        <td>Wagtail</td>
        <td>Referrer-Policy (55.2%),<br>X-Content-Type-Options (61.7%),<br>X-Frame-Options (72.1%)</td>
      </tr>
      <tr>
        <td>Plone</td>
        <td>Strict-Transport-Security (57.1%),<br>X-Frame-Options (75.2%)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Security features in use by selected CMS systems", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

It's clear that many major CMS's that are hosted by the providing company and where only content is created by users, such as Wix, SquareSpace, Google Sites, Medium and Substack, roll out security protections widely, showing adoption of HSTS, X-Content-Type-Options or X-XSS-Protection in the upper 99% adoption rates. Google sites continues to be the CMS that has the highest number of security features in place.

For CMS's that can be easily self-hosted such as Plone or Wagtail, it is more difficult to control the rollout of features because the CMS creators have no way to influence the update behavior of users. Websites hosted using these CMS's could be online without change in security features for a long time.

### Website popularity

Large websites often have a high number of visitors and registered users, of which they might store highly sensitive data. This means they likely attract more attackers and are thus more prone to targeted attacks. Additionally, when an attack succeeds, these websites could be fined or sued, costing them money and/or reputational damage. Therefore, it can be expected that popular websites invest more in their security to secure their users.

{{ figure_markup(
  image="security-headeers-by-rank.png",
  caption="Security header adoption by website rank according to the April 2024 CrUX.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=256464807&format=interactive",
  sheets_gid="434545590",
  sql_file="header_use_by_rank.sql",
  width=600,
  height=505
  )
}}

We find that most headers, including the most popular ones: `X-Frame-Options`, `Strict-Transport-Security`, `X-Content-Type-Options`, `X-XSS-Protection` and `Content-Security-Policy`, always have higher adoptions for more popular sites on mobile. 64.3% of the top 1000 sites on mobile have HSTS enabled. This means the top 1000 websites are more invested in only sending traffic over HTTPS. Less popular sites can still have HTTPS enabled, but don't add a Strict-Transport-Security header as often, which may lead users to repeatedly visit the site over plain HTTP.

### Website category (<span style="text-decoration:underline;">new analyses</span>)

In some industries, developers might keep more up to date with security features they may be able to use to better secure their sites.

{{ figure_markup(
  image="avg-security-headers-per-site.png",
  caption="The average number of security headers by website category; top and bottom 5 categories.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=139345565&format=interactive",
  sheets_gid="1042348266",
  sql_file="feature_adoption_all_party_by_category.sql",
  width=600,
  height=617
  )
}}

We find that there is a subtle difference in the average number of security headers used depending on the categorization of the website. This number does not directly show the overall security of these sites, but might give an insight into which categories of industry are inclined to implement more security features. We see that shopping and finance lead the list, both industries that deal with sensitive information and high amounts of monetary transactions, which may be reasons to invest in security. At the bottom of the list we see news and travel & transportation. Both are categories in which a lot of sites will host content relating to their respective topics, but may not handle much sensitive data compared to sites in the top categories on the list. In general, this trend seems to be weak.

## Malpractices on the Web [Vik]

Although cryptocurrencies remain popular, the number of cryptominers on the web has continued to decrease over the past two years, with no notable spikes in usage anymore as was described in the 2022 edition of the Web Almanac.

{{ figure_markup(
  image="cryptominers-trend.png",
  caption="The number of cryptominers in use over time; from May 2022 to Jul 2024.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=2077124907&format=interactive",
  sheets_gid="2083415086",
  sql_file="cryptominer_usage.sql"
  )
}}

When looking at the cryptominer share, we see that part of the Coinimp share has been overtaken by JSEcoin, while other miners have remained relatively stable, seeing only minor changes.

{{ figure_markup(
  image="cryptominers-market-share.png",
  caption="The cryptominer market shares.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=686409320&format=interactive",
  sheets_gid="1261018954",
  sql_file="cryptominer_share.sql"
  )
}}

With the low number of cryptominers found on the web, these relative changes are still quite minor.

## Security misconfigurations and oversights

While the presence of security policies suggests that website administrators are actively working to secure their sites, proper configuration of these policies is crucial. In the following section, we will highlight some observed misconfigurations that could compromise security.

### Unsupported policies defined by `<meta>`

It's crucial for developers to understand where specific security policies should be defined. For instance, while a secure policy might be defined through a `<meta>` tag, it could be ignored by the browser if it's not supported there, potentially leaving the application vulnerable to attacks.

Although the Content Security Policy can be defined using a `<meta>` tag, its `frame-ancestors` and `sandbox` directives are not supported in this context. Despite this, our observations show that 1.70% of pages on desktop and 1.26% on mobile incorrectly used the `frame-ancestors` directive in the `<meta>` tag. This is far lower for the disallowed `sandbox` directive, which was defined for less than 0.01%.

### COEP, CORP and COOP confusion

Due to their similar naming and purpose, the COEP, CORP and COOP are sometimes difficult to discern. However, assigning unsupported values to these headers can have a detrimental effect on the website's security.

<figure>
  <table>
    <thead>
      <tr>
        <th>Invalid COEP value</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">3.22%</td>
        <td class="numeric">3.05%</td>
      </tr>
      <tr>
        <td><code>cross-origin</code></td>
        <td class="numeric">0.30%</td>
        <td class="numeric">0.23%</td>
      </tr>
      <tr>
        <td><code>same-site</code></td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.04%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of invalid COEP header values", sheets_gid="TODO", sql_file="TODO.sql") }}</figcaption>
</figure>

For instance, around 3% of observed COEP headers mistakenly use the unsupported value `same-origin`. When this occurs, browsers revert to the default behavior of allowing any cross-origin resource to be embedded, while restricting access to features like `SharedArrayBuffer` and unthrottled use of `Performance.now()`. This fallback does not inherently reduce security unless the site administrator intended to set `same-origin` for CORP or COOP, where it is a valid value.

Additionally, only 0.26% of observed COOP headers were set to `cross-origin` and just 0.02% of CORP headers used the value `unsafe-none`. Even if these values were mistakenly applied to the wrong headers, they represent the most permissive policies available. Therefore, these misconfigurations are not considered to decrease security.

In addition to cases where valid values intended for one header were mistakenly used for another, we identified several minor instances of syntactical errors across various headers. However, each of these errors accounted for less than 1% of the total observed headers, suggesting that while such mistakes exist, they are relatively infrequent.

### Timing-Allow-Origin Wildcards [Vik]

Timing-Allow-Origin is a response header that allows a server to specify a list of origins that are allowed to see values of attributes obtained through features of the [Resource Timing API](https://developer.mozilla.org/docs/Web/API/Performance_API/Resource_timing). This means that an origin listed in this header can access detailed timestamps regarding the connection that is being made to the server, such as the time at the start of the TCP connection, start of the request and start of the response.

When CORS is in effect, many of these timings (including the ones listed above) are returned as 0 to prevent cross-origin leaks. By listing an origin in the Timing-Allow-Origin header this restriction is lifted.

Allowing different origins access to this information should be done with care, because using this information the site loading the resource can potentially execute timing attacks. In our analysis we find that out of all responses with a Timing-Allow-Origin header present, 82.5% percent of Timing-Allow-Origin headers contain the wildcard value, thereby allowing any origin to access the fine grained timing information.

{{ figure_markup(
  content="82.5%",
  caption="The percentage of Timing-Allow-Origin that are set to the wildcard (`*`) value.",
  classes="big-number",
  sheets_gid="TODO",
  sql_file="TODO.sql",
) }}

### Missing suppression of server information headers

While *security by obscurity* is generally considered bad practice, web applications can still benefit from withholding excessive information about the server or framework in use. Although attackers can still fingerprint certain details, minimizing exposure - particularly regarding specific version numbers - can reduce the likelihood of the application being targeted in automated vulnerability scans.

This information is usually reported in headers such as [`Server`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Server), `X-Server`, `X-Backend-Server`, <a hreflang="en" href="https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html#x-powered-by"><code>X-Powered-By</code></a>, `X-Aspnet-Version`.

{{ figure_markup(
  image="server-headers.png",
  caption="Prevalence of headers used to convey information about the server.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1009281320&format=interactive",
  sheets_gid="2032567932",
  sql_file="TODO.sql"
  )
}}

The most commonly exposed header is the `Server` header, which reveals the software running on the server. This is followed by the `X-Powered-By` header, which discloses the technologies used by the server.

<figure>
  <table>
    <thead>
      <tr>
        <th>Header value</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>PHP/7.4.33</code></td>
        <td class="numeric">9.11%</td>
        <td class="numeric">9.45%</td>
      </tr>
      <tr>
        <td><code>PHP/7.3.33</code></td>
        <td class="numeric">4.64%</td>
        <td class="numeric">5.43%</td>
      </tr>
      <tr>
        <td><code>PHP/5.3.3</code></td>
        <td class="numeric">2.65%</td>
        <td class="numeric">2.76%</td>
      </tr>
      <tr>
        <td><code>PHP/5.6.40</code></td>
        <td class="numeric">2.49%</td>
        <td class="numeric">2.64%</td>
      </tr>
      <tr>
        <td><code>PHP/7.4.29</code></td>
        <td class="numeric">1.73%</td>
        <td class="numeric">2.16%</td>
      </tr>
      <tr>
        <td><code>PHP/7.2.34</code></td>
        <td class="numeric">1.65%</td>
        <td class="numeric">1.81%</td>
      </tr>
      <tr>
        <td><code>PHP/8.0.30</code></td>
        <td class="numeric">1.29%</td>
        <td class="numeric">1.40%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.28</code></td>
        <td class="numeric">1.09%</td>
        <td class="numeric">1.09%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.27</code></td>
        <td class="numeric">1.01%</td>
        <td class="numeric">1.15%</td>
      </tr>
      <tr>
        <td><code>PHP/7.1.33</code></td>
        <td class="numeric">0.95%</td>
        <td class="numeric">0.98%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent `X-Powered-By` header values with specific framework version", sheets_gid="895726728", sql_file="TODO.sql") }}</figcaption>
</figure>

Examining the most common values for the `Server` and `X-Powered-By` headers, we found that especially the `X-Powered-By` header specifies versions, with the top 10 values revealing specific PHP versions. For both desktop and mobile, at least 25% of `X-Powered-By` headers contain this information. This header is likely enabled by default on the observed web servers. While it can be useful for analytics, the header's benefits are limited, and thus it warrants to be disabled by default. However, disabling this header alone does not address the security risks of outdated servers; regularly updating the server remains crucial.

### Missing suppression of `Server-Timing header`

The Server-Timing header is defined in a <a hreflang="en" href="https://w3c.github.io/server-timing/">W3C Editor's Draft</a> as a header that can be used to communicate about server performance metrics. A developer can send metrics containing zero or more properties. One of the specified properties is the `dur` property, that can be used to communicate millisecond-accurate timings that contain the duration of a specific action on the server.

We find that server-timing is used by 6.4% of internet hosts. Over 60% of those hosts include at least one `dur` property in their response and over 55% even send more than two. This means that these sites are exposing server-side process durations directly to a client, which can be used for exploiting. Because the server-timing may contain sensitive information, the use is now restricted to the same origin, except when Timing-Allow-Origin is used by the developer as discussed in the previous section. However, timing attacks can still be exploited directly against servers without the need to access cross-origin data.

{{ figure_markup(
  image="server-timing-headers.png",
  caption="The usage of the server-timing header and relative usage of `dur` properties.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=753463357&format=interactive",
  sheets_gid="1339089790",
  sql_file="TODO.sql"
  )
}}

## Well-known URIs

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8615">Well-known URIs</a> are used as a way to designate specific locations to data or services related to the overall website. A well-known URI is a URI whose path component begins with the characters `/.well-known/`.

### Security.txt

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9116"><code>security.txt</code></a> is a file format that can be used by websites to communicate information regarding vulnerability reporting in a standard way. Website developers can provide contact details, PGP key, policy, and other information in this file. White hat hackers and penetration testers can then use this information to report potential vulnerabilities they find during their security analyses. Our analysis shows that 1% of websites currently use a security.txt file, showing that they are actively working on improving their site's security.

{{ figure_markup(
  image="security-text-usage.png",
  caption="The usage of security.txt properties.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=884497197&format=interactive",
  sheets_gid="2060862418",
  sql_file="well-known_security.sql"
  )
}}

Most of the security.txt files include contact information (88.8%) and a preferred language (56.0%). This year, 47.9% of security.txt files define an expiry, which is a giant jump compared to the 2022 2.3%. This can largely be explained by an update to the methodology, as the analysis only includes text files this year instead of simply all responses with code 200, thereby significantly lowering the false positive rate. It does mean that less than half of the sites that use security.txt are following the standard that (among other requirements) defines the expires property as required. Interestingly, only 39% of the security.txt files define a policy, which is the space developers can indicate what steps a white hat hacker that found a vulnerability should take to report the vulnerability.

### Change-password

The <a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/">change-password</a> well-known URI is a W3C specification in the editor's draft state, which is the same state it was in in 2022. This specific well-known URI was suggested as a way for users and softwares to easily identify the link to be used for changing passwords, which means external resources can easily link to that page.

{{ figure_markup(
  image="change-password-usage.png",
  caption="The usages of the change-password .well-known endpoint.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=68129914&format=interactive",
  sheets_gid="512072624",
  sql_file="well-known_change-password.sql"
  )
}}

The adoption remains very low. At 0.27% for both mobile and desktop sites it slightly decreased for desktop sites from 0.28% in 2022. Due to the slow standardization process it is not unexpected that the adoption does not change much. We also repeat that websites without authentication mechanisms have no use for this url, which means it would be useless for them to implement it.

### Detecting status code reliability

In a specification that is also still an <a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html">editor's draft</a>, like in 2022, a particular well-known URI is defined to determine the reliability of a website's HTTP response status code. The idea behind this well-known URI is that it should never exist in any website, which in turn means navigating to this well-known URI should never result in a response with an <a hreflang="en" href="https://fetch.spec.whatwg.org/#ok-status">ok-status</a>. If it redirects and returns an "ok-status", that means the website's status codes are not reliable. This could be the case when a redirect to a specific '404 not found' error page occurs, but that page is served with an ok status.

{{ figure_markup(
  image="well-known-responses.png",
  caption="The distribution of statuses returned for the `.well-known` endpoint to assess status code reliability.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1669404844&format=interactive",
  sheets_gid="210322568",
  sql_file="well-known_resource-not-be-200.sql"
  )
}}

We find a similar distribution as in 2022, where 83.6% of pages respond with a not-ok status, which is the expected outcome. Again, one reason that these figures may not change much is the fact that the standard is stuck in the editor's draft status and the standardization is slow.

### Sensitive endpoints in robots.txt

Finally, we check whether or not robots.txt includes possibly sensitive endpoints. By using this information, hackers may be able to select websites or endpoints to target based on the exclusion in robots.txt.

{{ figure_markup(
  image="robots-text-endpoints.png",
  caption="The percentage of sites including specified endpoints in their robots.txt.",
  description="TODO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1873866251&format=interactive",
  sheets_gid="707878693",
  sql_file="robot-txt_sensitive_disallow.sql"
  )
}}

We see that around 4.3% of websites include at least one `/admin/...` in their robot.txt file.

This may be used to find an admin-only section of the website, which would otherwise be hidden and finding it would rely on attempting to visit specific subpages under that url. `login`, `signin`, `auth`, `sso` and `account` point to the existence of a mechanism where users can log in using an account they created or received. Each of these endpoints are included in the robots.txt of a number of sites (some of which may be overlapping), with `account` being the more popular one at 2.9% of websites.

## Conclusion

Overall, this year's analysis highlights promising trends in web security. HTTPS adoption is nearing 100%, with Let's Encrypt leading the charge by issuing over half of all certificates, making secure connections more accessible. Although the overall adoption of security policies remains limited, it's encouraging to see steady progress with key security headers. Secure-by-default measures, like the `SameSite=Lax` attribute for cookies, are driving website administrators to at least consider important security practices.

However, attention must also be given to poor configurations or even misconfigurations that can weaken these protections. Issues like invalid directives or poorly defined policies can prevent browsers from enforcing security effectively. For instance, 82.5% of all `Timing-Allow-Origin` headers allow any origin to access detailed timing information, which could be abused in timing attacks. Similarly, only 1% of websites enable security issue reporting via `security.txt`, and many still expose their PHP version, an unnecessary risk that can reveal potential vulnerabilities. On the bright side, most of these issues represent low-hanging fruit—addressing them typically requires minimal changes to website implementations.

As the number of security policies grows, it's essential for policymakers to focus on reducing complexity. Reducing implementation friction will make adoption easier and minimize common mistakes. For example, the introduction of cross-origin headers designed to prevent cross-site leaks and microarchitectural attacks has already caused confusion, with directives from one policy mistakenly applied to another.

Although new attacks will undoubtedly emerge in the future, demanding new protections, the openness of the security community plays a crucial role in developing sound solutions. As we've seen, the adoption of new measures may take time, but progress is being made. Each step  forward brings us closer to a more resilient and secure Web for everyone.
