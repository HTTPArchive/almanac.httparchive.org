---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Security
description: Security chapter of the 2025 Web Almanac covering Transport Layer Security, content inclusion (CSP, SRI, Permissions Policy), web defense mechanisms (tackling XSS, XS-Leaks), drivers of security mechanism adoptions and security misconfigurations.
hero_alt: Hero image of Web Almanac characters padlocking a web page, while other Web Almanac characters subdue a masked thief who has a set of bolt cutters.
authors: [vikvanderlinden, GJFR]
reviewers: [anirudhduggal, martinakraus, GJFR, clarkio, JannisBush, securient]
analysts: [vsdaan]
editors: [abhishektiwari]
translators: []
GJFR_bio: Gertjan Franken is a postdoctoral researcher with the <a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet Research Group</a> at KU Leuven. His research spans various aspects of web security and privacy, with a primary focus on the automated analysis of browser security policies. As part of this research, he maintains the open-source tool <a hreflang="en" href="https://github.com/DistriNet/BugHog">BugHog</a> for pinpointing bug lifecycles.
vikvanderlinden_bio: Vik Vanderlinden is a PhD candidate in Computer Science at the <a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet Research Group</a> at KU Leuven. His research focuses on web and network security, primarily focusing on timing leaks in web applications and protocols.
results: https://docs.google.com/spreadsheets/d/1TLYRfNRbFu4fWwWvG4zhcRXkQ8-aZTxszgsEWjYATpA/edit
featured_quote: ...
featured_stat_1: 98.8%
featured_stat_label_1: Percentage of requests that use HTTPS
featured_stat_2: 84%
featured_stat_label_2: Percentage of Timing-Allow-Origin headers set to the wildcard character
featured_stat_3: +50%
featured_stat_label_3: Increase in the adoption of the Permissions Policy
---

## Introduction

While more and more parts of many people's lives have moved online, so does their private data, which makes web security ever more important. Many systems we use on a daily basis remain appealing to attackers trying to steal data or cause disruptions. This year has once more demonstrated the scale complexity of modern threats. The number of DDoS attacks have continued to increase in size and frequency, with the largest attack recorded <a hreflang="en" href="https://blog.cloudflare.com/radar-2025-year-in-review/#hyper-volumetric-ddos-attack-sizes-grew-significantly-throughout-the-year">reaching 31.4 Tbps in November</a>. Supply chain vulnerability grew to unprecedented sizes, with the <a hreflang="en" href="https://www.hackerone.com/blog/shai-hulud-2-npm-worm-supply-chain-attack">Shai-Hulud 2.0 attack</a> reportedly compromising over 1,000 npm packages and infecting over 27,000 GitHub repositories. And a critical vulnerability in React known as <a hreflang="en" href="https://www.microsoft.com/en-us/security/blog/2025/12/15/defending-against-the-cve-2025-55182-react2shell-vulnerability-in-react-server-components/">React2Shell</a> had developers working hard to quickly update their applications.

In this chapter, we analyze the mechanisms that aim to protect the web, and how in some cases they fail to protect the web due to a variety of reasons. We explore core elements of web security such as Transport Layer Security (TLS) and protections against third-party content inclusions. We discuss how the adoption of these security measures evolves, how they help prevent attacks and how misconfigurations can prevent their proper functioning. We further analyze some well-known URIs relating to security.

Beyond measuring adoption, we also explore the drivers behind the adoption of security mechanisms, such as location, technology stack and website industry. By comparing the results to data from previous editions of the Web Almanac, we can notice long-term trends and changes in the state of web security.

## Transport security

[HTTPS](https://developer.mozilla.org/docs/Glossary/https) uses <a hreflang="en" href="https://www.cloudflare.com/en-gb/learning/ssl/transport-layer-security-tls/">Transport Layer Security (TLS)</a> to secure the connection between client and server. Over the years, more and more websites started using HTTPS, thereby better securing their users. This year, the share of all requests sent over HTTPS rose again compared to last year, reaching over 98.8% for mobile connections.

{{ figure_markup(
  content="98.8%",
  caption="The percentage of requests that use HTTPS (mobile).",
  classes="big-number",
  sheets_gid="530740578",
  sql_file="https_request_over_time.sql",
) }}

The share of requests that are being sent using HTTPS rather than using plain HTTP creeps ever closer to 100%, rising by another 0.74% on mobile compared to [the 2024 edition of Web Almanac](../2024/security#fig-1).

{{ figure_markup(
  image="https-usage.png",
  caption="The percentage of homepages using HTTPS.",
  description="Bar chart displaying the adoption rate of secure connections across desktop and mobile devices. Security is near-universal, with 97.5% of desktop sites and 97.3% of mobile sites utilizing HTTPS to protect user data. This indicates a highly secure web landscape where non-encrypted HTTP connections have been relegated to a tiny fraction (less than 3%) of total traffic.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2075189160&format=interactive",
  sheets_gid="479242437",
  sql_file="home_page_https_usage.sql"
  )
}}

Another positive evolution is visible in the number of homepages served over HTTPS. This number rises from 95.6% to 97.3% on mobile. Because many websites send a number of third-party requests to many (often secure) sites, this number tends to be lower than the share of requests sent over HTTPS, but luckily also keeps rising year after year.

It is good to see that the positive trends in these metrics continues and that the share of sites using HTTPS keeps closing in to 100%. Part of these high numbers can be explained by the decision of browser vendors (<a hreflang="en" href="https://blog.chromium.org/2021/07/increasing-https-adoption.html#:~:text=Beginning%20in%20M94%2C%20Chrome%20will%20offer%20HTTPS%2DFirst%20Mode">Chrome</a>, <a hreflang="en" href="https://support.mozilla.org/en-US/kb/https-first">Firefox</a> and <a hreflang="en" href="https://webkit.org/blog/16301/webkit-features-in-safari-18-2/#security-and-privacy">Safari</a>) to try to communicate over HTTPS first before falling back to plain HTTP and often showing a security warning to users, thereby encouraging site owners to adopt TLS.

### Protocol versions

For a few years now, <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8446">TLS1.3</a> has been the recommended protocol version to have the highest security. The latest version has deprecated some <a hreflang="en" href="https://www.cloudflare.com/en-in/learning/ssl/why-use-tls-1.3/#:~:text=A%20number%20of%20outdated%20cryptography%20features%20resulted%20in%20vulnerabilities%20or%20enabled%20specific%20kinds%20of%20cyber%20attacks">algorithms that were found to contain flaws</a> in TLS1.2 and provides some stronger security guarantees like forward secrecy. QUIC uses TLS internally as well, thereby providing <a hreflang="en" href="https://community.cloudflare.com/t/how-is-quic-a-direct-comparison-to-tls-1-3-and-tls-1-2/543349/6#:~:text=TLS%201.2%2C%20TLS%201.3%2C%20and%20QUIC%20share%20similar%20security%20characteristics%20but%20they%20are%20different">similar security guarantees as TLS1.3 does</a>.

{{ figure_markup(
  image="tls-versions.png",
  caption="The distribution of TLS versions in use.",
  description="Bar chart showing the market share of different encryption protocols used to secure web traffic on desktop and mobile devices. TLS 1.3 is the clear standard, powering roughly 76% of all web pages, followed by TLS 1.2, which accounts for approximately 13-15% of the share. Notably, the modern QUIC protocol (often associated with HTTP/3) represents a growing segment of secure traffic, maintaining a slightly higher presence on mobile (10.8%) compared to desktop (9.5%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1659150103&format=interactive",
  sheets_gid="902024133",
  sql_file="tls_versions_pages.sql"
  )
}}

Like in the [2024 edition of the Web Almanac](../2024/security#protocol-versions), we find that both QUIC and TLS1.3 see an increase in use. Again we can assume that some sites using TLS1.2 have moved to TLS1.3 and some sites that were using TLS1.2 or TLS1.3 have moved to QUIC. TLS1.2 decreased by another 4.5% this year. We can see that the adoption of QUIC has slowed down a bit this year, with the share of sites using QUIC only rising by 0.8%. In the future, it can be expected that TLS1.2 will slowly phase out over (a long) time and QUIC will continue rising.

### Cipher suites

To start communicating over an encrypted channel, both parties need to use the same cryptographic algorithm (or <a hreflang="en" href="https://learn.microsoft.com/en-au/windows/win32/secauthn/cipher-suites-in-schannel">cipher suite</a>) to understand each other. In order to do so, they agree upon a cipher suite to use before communication. We can see that most requests happen over a connection using a [Galois Counter Mode (GCM)](https://www.wikipedia.org/wiki/Galois/Counter_Mode) cipher, which is often preferred because of its resilience against <a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">padding attacks</a> and because it provides <a hreflang="en" href="https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=2628d946bda9f3d3b087e5c4846e76ae0fb07b6b">Authenticated Encryption with Associated Data (AEAD)</a>, which is <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8446#:~:text=Those%20that%0A%20%20%20%20%20%20remain%20are%20all%20Authenticated%20Encryption%20with%20Associated%20Data%0A%20%20%20%20%20%20(AEAD)%20algorithms">required in TLS1.3</a>. In addition, we see that the use of 128-bit keys has grown by 4% since last year, instead of the more secure 256-variant. Although the <a hreflang="en" href="https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-131Ar3.ipd.pdf">128-bit cipher suites are considered secure by NIST</a>, 256-bit variants provide even more security guarantees. The dataset of this year's Almanac includes more requests than last year's, so it is possible that this change can be attributed to the growing dataset. The cipher suites in use are not very diverse, in fact there are only five cipher suites that were found to be used in the dataset. This can be the case because TLS1.3 <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">only allows GCM or modern block ciphers</a> to be used.

{{ figure_markup(
  image="cipher-suites.png",
  caption="The distribution of cipher suites in use.",
  description="Bar chart, showing the overwhelming dominance of the AES_128_GCM encryption standard, which secures 82.8% of all HTTPS requests on both desktop and mobile platforms. `AES_256_GCM` serves as the second most common suite, accounting for approximately 16.1% of traffic, while modern alternatives like `CHACHA20_POLY1305` and legacy modes like `AES_256_CBC` represent only a tiny fraction (less than 1%) of web connections.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=220138440&format=interactive",
  sheets_gid="209958900",
  sql_file="tls_cipher_suite.sql"
  )
}}

TLS1.3 only allows the use of algorithms that support [forward secrecy](https://www.wikipedia.org/wiki/Forward_secrecy). Because of the high adoption of TLS1.3, we expect a large share of requests to fulfill the forward secrecy requirement.

{{ figure_markup(
  image="forward-secrecy.png",
  caption="The percentage of requests supporting forward secrecy.",
  description="Bar chart, showing that approximately 75.8% of desktop and 75.1% of mobile HTTPS requests utilize forward secrecy.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1624420318&format=interactive",
  sheets_gid="596349024",
  sql_file="tls_forward_secrecy.sql"
  )
}}

Contrary to our expectations, we see a relatively low number of requests that are sent over connections that are forward secret. There is a 20% decrease in forward secret requests [since the 2024 Web Almanac](../2024/security#fig-5). Currently, it seems our metric only includes the forward secret ciphers in TLS1.2 and TLS1.3, but does not include TLS in QUIC which can explain the decline we observer.

### Certificate Authorities

In order to use TLS, sites must request a certificate from a <a hreflang="en" href="https://www.ssl.com/faqs/what-is-a-certificate-authority/">Certificate (CA)Authority</a>. Because the browser trusts a number of CAs, site's certificate can be identified by the browser as a valid certificate. The certificate can then be used for secure communication between the browser and the site's server going forward.

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
        <td>R11</td>
        <td class="numeric">20.80%</td>
        <td class="numeric">21.86%</td>
      </tr>
      <tr>
        <td>R10</td>
        <td class="numeric">20.75%</td>
        <td class="numeric">21.73%</td>
      </tr>
      <tr>
        <td>WE1</td>
        <td class="numeric">16.35%</td>
        <td class="numeric">17.24%</td>
      </tr>
      <tr>
        <td>E6</td>
        <td class="numeric">4.50%</td>
        <td class="numeric">4.65%</td>
      </tr>
      <tr>
        <td>E5</td>
        <td class="numeric">4.31%</td>
        <td class="numeric">4.42%</td>
      </tr>
      <tr>
        <td>Sectigo RSA Domain Validation Secure Server CA</td>
        <td class="numeric">3.60%</td>
        <td class="numeric">3.52%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">1.77%</td>
        <td class="numeric">1.60%</td>
      </tr>
      <tr>
        <td>WR1</td>
        <td class="numeric">1.16%</td>
        <td class="numeric">1.40%</td>
      </tr>
      <tr>
        <td>Amazon RSA 2048 M02</td>
        <td class="numeric">1.37%</td>
        <td class="numeric">1.33%</td>
      </tr>
      <tr>
        <td>Amazon RSA 2048 M03</td>
        <td class="numeric">1.30%</td>
        <td class="numeric">1.25%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The percentage of certificates issued per issuer (top 10)", sheets_gid="215876282", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

Compared to last year, we can see that the then popular R3 intermediate certificate from <a hreflang="en" href="https://letsencrypt.org/">Let's Encrypt</a> has disappeared as an issuer. This was expected because it has since <a hreflang="en" href="https://crt.sh/?id=3334561879">expired (in September 2025)</a> so even last year the replacement with other intermediates had already started. The <a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html">R10 and R11 intermediate certificates</a> are the new certificates that are taking over from R3. There are now two intermediate RSA certificates (R10 and R11) and two intermediate ECDSA certificates (E5 and E6) with the <a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html#rotating-issuance">explicit goal of trying to prevent intermediate key pinning</a>. The only certificate in the top 5 issuers that is not from Let's Encrypt is WE1, which is part of <a hreflang="en" href="https://pki.goog/">Google Trust Services (GTS)</a>. Also from GTS in the list is WR1. These certificates seem part of the new generation of intermediate certificates from GTS, expiring among others the GTS CA 1P5 issuer seen last year.

{{ figure_markup(
  content="52.6%",
  caption="Percentage of mobile pages that are issued by Let's Encrypt.",
  classes="big-number",
  sheets_gid="215876282",
  sql_file="tls_ca_issuers_pages.sql",
) }}

The total share of sites using a certificate of Let's Encrypt has gone down slightly to 52.6% from 56% in the last edition. One of the contributing factors as can be seen in the data is the larger share of certificates issued by the WE1 certificate from GTS, although the total share by GTS-issued certificates (WE1 and others) has not been calculated.

### HTTP Strict Transport Security

[HTTP Strict Transport Security](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security) is a response header through which servers can instruct browsers to only visit pages on this domain over HTTPS, instead of trying HTTP first and following the redirect to HTTPS.

{{ figure_markup(
  content="36%",
  caption="The percentage of pages using the HSTS header on mobile.",
  classes="big-number",
  sheets_gid="1439302553",
  sql_file="hsts_attributes.sql",
) }}

We see a continuing increase in the number of pages using a HSTS header, with a rise of 6 percentage points [compared to last edition](../2024/security#fig-8), up to 36% of all pages visited on mobile.

Servers can include a number of directives in the header to communicate additional preferences to the browser. The `max-age` directive that tells the browser for how long to continue only using HTTPS is required, the others are optional.

{{ figure_markup(
  image="hsts-directives.png",
  caption="The usage of specified HSTS directives.",
  description="Bar chart, showing the configuration of security headers across desktop and mobile platforms. A near-universal 96% of these websites utilize a valid `max-age` directive to specify how long the browser should enforce secure connections, while only 4% use a zero max-age to disable the policy. Adoption remains significantly lower for advanced security features, with roughly 40% of sites protecting their subdomains and only about 22% utilizing the preload directive to ensure a secure connection from the very first visit.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1721543402&format=interactive",
  sheets_gid="1439302553",
  sql_file="hsts_attributes.sql"
  )
}}

The share of responses with a valid `max-age` has increased slightly to 96%. The `includeSubdomains` and `preload` directives saw an increase of about 4% each, possibly indicating that certain sites started setting both directives together. The [unofficial](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security) `preload` directive requires the `includeSubdirectories` to be set and the `max-age` to have a value of at least 1 year. Using the preload, a site can make sure that a browser will always visit the domain and its subdomains, even when connecting for the first time (which is not necessarily the case when using HSTS without preload).

{{ figure_markup(
  image="hsts-max-age.png",
  caption="The distribution of HSTS `max-age` values by percentile.",
  description="Bar chart showing the distribution of duration settings for HTTP Strict Transport Security (HSTS) across desktop and mobile platforms. The median (50th percentile) value is 365 days for both device types, indicating that most administrators enforce secure connections for exactly one year. At the 90th percentile, this value doubles to 730 days, while the lower end of the spectrum shows a minimum standard of 91 days at the 10th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1532336378&format=interactive",
  sheets_gid="1684013271",
  sql_file="hsts_max_age_percentiles.sql"
  )
}}

The distribution of valid `max-age` values remains largely the same with the exception of the lower percentiles. At the 10th percentile, we see a large increase from 30 days to 91 days, indicating that less sites are setting very low `max-age` values. The median remains at one year or 365 days.

## Cookies

Cookies are a vital part of the web. They allow websites to save information for use over multiple stateless requests. In order to secure sites' cookies, there are many features built into browsers that (among much more) are reported on in the [Cookies chapter](./cookies). We specifically refer to the [Cookie attributes](./cookies#cookie-attributes), [Cookie prefixes](./cookies#cookie-prefixes) and [Persistence (expiration)](./cookies#persistence-expiration) sections.

## Content inclusion

Content inclusion is a core component of the web. Being able to include other pages, CSS or JavaScript from a [Content Distribution Network (CDN)](./cdn) or images from shared sources is one of the building blocks on which the web was built. It does however introduce certain risks: whenever sites include content from third parties, it places trust in those third-party resources. Of course, there is no guarantee that said resource is not malicious or compromised by a malicious actor which can lead to a number of serious attacks such as for instance supply chain attacks. To reduce this risk, it is important to use security policies to control content inclusion.

### Content Security Policy

The [Content Security Policy (CSP)](https://developer.mozilla.org/docs/Web/HTTP/CSP) allows websites to have a fine-grained control over the content that will be loaded on its page. By setting the `Content-Security-Policy` response header or defining it in a `<meta>` html tag, websites can communicate the policy in use to the browser, which will enforce it. The policy has many defined directives that allow a website to define from which sources content can be loaded or not.

CSP can be used to block specific resources from being loaded, which can help reduce the impact of potential XSS attacks. In addition CSP can also serve other purposes, such as enforcing the use of encrypted communication channels by means of the `update-insecure-requests` directive or controlling on which pages the current page can be loaded as a subresource using the `frame-ancestors` directive. This allows websites to defend against clickjacking attacks.

{{ figure_markup(
  content="+18%",
  caption="Relative increase in adoption of the `Content-Security-Policy` header from 2024.",
  classes="big-number",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql",
) }}

The adoption of CSP continued increasing [from 18.5% last year](../2024/security#content-security-policy) to 21.9% this year, an increase of close to 20%. As predicted in the last edition of the Web Almanac, the adoption has now risen above 20%, indicating the adoption is still steadily rising.

#### Directives

{{ figure_markup(
  image="csp-directives.png",
  caption="Most common directives used in CSP.",
  description="Bar chart showing the adoption frequency of various Content Security Policy (CSP) directives on desktop and mobile web pages. The most prevalent directives are `upgrade-insecure-requests` and `frame-ancestors`, both appearing in approximately 50-55% of CSP headers to manage secure connections and prevent clickjacking. While desktop sites generally lead in traditional directive usage, mobile sites show significantly higher adoption for modern security features like `trusted-types` and `report-uri`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=579658502&format=interactive",
  sheets_gid="1683734522",
  sql_file="csp_directives_usage.sql"
  )
}}

Once again, most websites use CSP for the `upgrade-insecure-requests` and `frame-ancestors` directives. The relative share of mobile sites using these directives has decreased slightly, which can be attributed to the higher number of CSP headers scanned, as the absolute number has risen by 400,000 and 800,000 CSP headers on desktop and mobile respectively.

The `block-all-mixed-content` directive which has been replaced by `upgrade-insecure-requests` has continued to slightly decrease like it has been over the last few years. This is good news because the directive is [deprecated](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Content-Security-Policy/block-all-mixed-content).

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
        <td><code>upgrade-insecure-requests</code></td>
        <td class="numeric">21.45%</td>
        <td class="numeric">22.79%</td>
      </tr>
      <tr>
        <td><code>block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;</code></td>
        <td class="numeric">19.92%</td>
        <td class="numeric">18.06%</td>
      </tr>
      <tr>
        <td><code>require-trusted-types-for 'script';report-uri /checkin/_/AndroidCheckinHttp/cspreport</code></td>
        <td class="numeric">2.67%</td>
        <td class="numeric">12.10%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors 'self'</code></td>
        <td class="numeric">7.55%</td>
        <td class="numeric">6.38%</td>
      </tr>
      <tr>
        <td><code>upgrade-insecure-requests;</code></td>
        <td class="numeric">4.92%</td>
        <td class="numeric">4.30%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors 'self';</code></td>
        <td class="numeric">2.53%</td>
        <td class="numeric">2.29%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent CSP headers", sheets_gid="1551197242", sql_file="csp_most_common_header.sql") }}</figcaption>
</figure>

The same header values we saw last year in the top three appear in this year's top four again. The third most common CSP header this year is a new one, however. This change occurs because this year, we sorted the most common headers by mobile usage instead of by desktop usage like last year. We can see a trusted types policy with a specific `report-uri` endpoint relating to Android appear at the third place.

<a hreflang="en" href="https://w3c.github.io/trusted-types/dist/spec/">Trusted types</a> can be used to restrict the parameters passed into injection sinks (like `element.innerHTML`) such that they only allow properly typed values to be passed instead of plain strings. By restricting the values passed to injection sinks, many possible DOM XSS vulnerabilities can be prevented. The trusted types header we observe appears on more than 12% of the mobile pages. We don't have a direct explanation for the high usage of this specific CSP policy value.

In fifth and sixth place we once again see the `upgrade-insecure-requests` and `frame-ancestors 'self'` directives, but this time with a trailing semicolon. A semicolon is used to separate directives but if there is only one directive defined <a hreflang="en" href="https://w3c.github.io/webappsec-csp/#grammardef-serialized-policy">it can be discarded</a>, both header values are therefore valid CSP policies with the same effect.

#### Keywords for `script-src`

One of the most important directives included in the CSP is `script-src`. Through the use of this directive, websites can control which scripts can run on their pages. This can hinder attackers because it can disallow them from running arbitrary scripts. `script-src` has multiple potential keywords.

{{ figure_markup(
  image="csp-script-src-keywords-per-request.png",
  caption="Prevalence of CSP `script-src` keywords per request.",
  description="Bar chart showing the usage of `script-src` attributes. An overwhelming 92% of websites use the `unsafe-inline` attribute on both desktop and mobile, `unsafe-eval` is present in 77% of policies, with nonces used on approximately 20% of sites and `strict-dynamic` only on approximately 10%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=629434819&format=interactive",
  sheets_gid="218451283",
  sql_file="csp_script_source_list_keywords_per_request.sql"
  )
}}

We find that the `unsafe-inline` and `unsafe-eval` keywords are used very often. These keywords significantly reduce the security impact of CSP's `script-src` as they allow any inline script to be executed or allow the use of the `eval`-function in JavaScript respectively.

Compared to [last year](../2024/security#keywords-for-script-src) we barely see any changes to the usage of `script-src` keywords. An important note to make is that the presence of `unsafe-inline` does not necessarily mean that inline scripts can be executed. In some cases and following the <a hreflang="en" href="https://w3c.github.io/webappsec-csp/">CSP specification</a> `unsafe-inline` will be ignored. This is for instance the case when a nonce and `strict-dynamic` keywords are added to the CSP policy.

{{ figure_markup(
  image="csp-script-src-keywords-per-header.png",
  caption="Prevalence of CSP `script-src` keywords per header.",
  description="Bar chart showing the usage of `script-src` attributes per header. An overwhelming 92% of headers use the `unsafe-inline` attribute on both desktop and mobile, `unsafe-eval` is present in 77% of policies, with nonces used on approximately 20% of sites and `strict-dynamic` only on approximately 10%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1711591110&format=interactive",
  sheets_gid="466842166",
  sql_file="csp_script_source_list_keywords_per_header.sql"
  )
}}

We also check the use of keywords per header instead of per page. In CSP, multiple CSP headers can be present in one response and may define different directives. If a directive is defined multiple times, <a hreflang="en" href="https://content-security-policy.com/examples/multiple-csp-headers/">the most restrictive policy will be used by the browser</a>.

We see a very similar distribution compared to the values per request, indicating that either most pages only use one CSP header or only use `script-src` in one of the CSP headers that they set, meaning there are no conflicting `script-src` directives on most pages.

#### Allowed hosts

CSP is a complex security policy to thoroughly understand and correctly use. When looking at the length of the CSP headers in use, we can see a wide variety in policy sizes.

{{ figure_markup(
  image="csp-header-length.png",
  caption="CSP header length.",
  description="Bar char showing the distribution of Content Security Policy header sizes in bytes across various percentiles for both desktop and mobile platforms. The data shows that header lengths remain relatively consistent and small between the 10th and 75th percentiles, ranging from 23 to 86 bytes, with desktop and mobile values being nearly identical. A significant spike occurs at the 90th percentile, where the desktop header length jumps to 583 bytes while the mobile length reaches 354 bytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=43389239&format=interactive",
  sheets_gid="1010084388",
  sql_file="csp_number_of_allowed_hosts.sql"
  )
}}

Out of all observed headers, 75% are 86 bytes or less in length. This is slightly more than last year where this was 75 bytes or less. We can see that there are more longer policies in use and in the 90th percentile, the desktop policies have gotten longer while the mobile policies have gotten slightly shorter, increasing the difference between the policy lengths.

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
        <td class="numeric">0.74%</td>
        <td class="numeric">0.62%</td>
      </tr>
      <tr>
        <td><code>https://fonts.gstatic.com</code></td>
        <td class="numeric">0.61%</td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td><code>https://fonts.googleapis.com</code></td>
        <td class="numeric">0.60%</td>
        <td class="numeric">0.48%</td>
      </tr>
      <tr>
        <td><code>https://www.google.com</code></td>
        <td class="numeric">0.54%</td>
        <td class="numeric">0.46%</td>
      </tr>
      <tr>
        <td><code>https://www.google-analytics.com</code></td>
        <td class="numeric">0.47%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td><code>https://www.youtube.com</code></td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td><code>https://*.google-analytics.com</code></td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td><code>https://*.google.com</code></td>
        <td class="numeric">0.31%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td><code>https://connect.facebook.net</code></td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.29%</td>
      </tr>
      <tr>
        <td><code>https://www.gstatic.com</code></td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.27%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most frequently allowed HTTP(S) hosts in CSP policies", sheets_gid="670924704", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>


The most commonly loaded HTTPS origins included in CSP headers are those used for ads, fonts and other CDN resources.

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
        <td><code>wss://*.hotjar.com</code></td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.15%</td>
      </tr>
      <tr>
        <td><code>wss://*.intercom.io</code></td>
        <td class="numeric">0.07%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>wss://booth.karakuri.ai</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>wss://www.livejournal.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td><code>wss://*.quora.com</code></td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td><code>wss://tsock.us1.twilio.com/v3/wsconnect</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td><code>wss://api.smooch.io</code></td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><code>wss://*.zopim.com</code></td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><code>wss://*.pusher.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><code>wss://cable.gumroad.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most frequently allowed WSS hosts in CSP policies", sheets_gid="2069006969", sql_file="csp_allowed_host_frequency_wss.sql") }}</figcaption>
</figure>

For the secure websocket (`wss://`) origins, we see Hotjar take the first position, doubling in occurrences. Other origins remain low in occurrence.

Hotjar is used for website analytics, indicating a continuing interest in analytical information of websites. Intercom is used for customer services. We also see AI-first companies entering these statistics with karakuri, a Japanese AI company that is closing the top three.

### Subresource Integrity

In order to protect themselves from loading tampered resources, developers can make use of [Subresource Integrity (SRI)](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity). While CSP allows for developers to restrict the sources from which resources are loaded, SRI makes sure those resources contain the content that is expected by the developer. The opposite can be the case when for instance a CDN is compromised and an attacker succeeds in changing a valid script into a malicious one.

By using the `integrity` attribute in `<script>` and `<link>` tags, developers can communicate to the browser the expected hash of the resource. When loading the specified resource, the browser will then check whether the hash of the resource contents corresponds to the provided hash and if not, refuse to load/execute the resource, thereby protecting the website from potentially compromised content.

{{ figure_markup(
  content="23.6%",
  caption="Pages using SRI (mobile).",
  classes="big-number",
  sheets_gid="1788665240",
  sql_file="sri_usage.sql",
) }}

SRI is used on 25.9% and 23.6% of desktop and mobile pages respectively. This is a rise by around 2.5% for both numbers [since last year](../2024/security#subresource-integrity), showing that a growing number of developers are using SRI to protect their pages.

{{ figure_markup(
  image="sri-coverage.png",
  caption="SRI coverage per page.",
  description="Bar chartshowing the adoption of Subresource Integrity (SRI) across various percentiles of web pages for desktop and mobile devices. Adoption remains remarkably low across the board, with the median (50th percentile) site protecting only 2.82% of its scripts using this security feature. Even at the 90th percentile, only 12.50% of a page's scripts are covered by SRI.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1391748685&format=interactive",
  sheets_gid="165579346",
  sql_file="sri_coverage_per_page.sql"
  )
}}

Compared with [last year](../2024/security#fig-25), we see a drop in median subresource coverage per page by 0.41%. It is likely that this drop is caused by the larger number of pages being crawled by the web almanac crawler this year.

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
        <td class="numeric">34.70%</td>
        <td class="numeric">34.55%</td>
      </tr>
      <tr>
        <td><code>static.cloudflareinsights.com</code></td>
        <td class="numeric">8.89%</td>
        <td class="numeric">8.37%</td>
      </tr>
      <tr>
        <td><code>cdnjs.cloudflare.com</code></td>
        <td class="numeric">7.43%</td>
        <td class="numeric">7.20%</td>
      </tr>
      <tr>
        <td><code>cdn.userway.org</code></td>
        <td class="numeric">6.10%</td>
        <td class="numeric">6.60%</td>
      </tr>
      <tr>
        <td><code>code.jquery.com</code></td>
        <td class="numeric">4.96%</td>
        <td class="numeric">4.77%</td>
      </tr>
      <tr>
        <td><code>cdn.shoplineapp.com</code></td>
        <td class="numeric">4.62%</td>
        <td class="numeric">5.22%</td>
      </tr>
      <tr>
        <td><code>cdn.jsdelivr.net</code></td>
        <td class="numeric">4.50%</td>
        <td class="numeric">4.06%</td>
      </tr>
      <tr>
        <td><code>d3e54v103j8qbb.cloudfront.net</code></td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.30%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most common hosts from which SRI-protected scripts are included", sheets_gid="347167013", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

The list of most common hosts from which SRI-protected scripts are loaded has remained largely stable over time, with some entries moving relative positions. The `cloudflareinsights` record for instance has increased in relative occurrence, but only by 2.40%.

Like last year, most of these entries are CDNs, showing that most resources loaded and protected by SRI are loaded from CDNs. This makes sense because these scripts are often not under direct control of the developers. Often, CDNs will host a large number of scripts that can then be included by many developers. This is advantageous for developers because the load on their own servers will go down, but also for the client because it can cache scripts from the CDN instead of loading the same script once for every website that includes it.

The risk of including a script that is hosted on a server not under your own control is higher than when you as developer have full control. If the developer of this external script decides to include malicious content or the server is compromised and the script is swapped with a malicious one, without SRI the developer's users will be loading and executing this malicious content. A good way to protect users against these unexpected changes and to know with certainty which script is allowed to run is to use SRI.

### Permissions Policy

The [Permissions Policy](https://developer.mozilla.org/docs/Web/HTTP/Permissions_Policy) (formerly Feature Policy) is a policy that allows websites to allow or disallow the use of specific features in the browser, such as the camera, microphone, sensors like the accelerometer or geolocation data. Through the `Permissions-Policy` response header, developers can allow or disallow specific feature use by the main page and its embedded content. A specific policy for one embedded resource can be set through the `allow` attribute of the `<iframe>` element.

{{ figure_markup(
  content="+50%",
  caption="Relative increase in adoption of the `Permissions-Policy` header from 2024 (mobile).",
  classes="big-number",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql",
) }}

[Compared to last year](../2024/security#permissions-policy), the use of the `Permissions-Policy` saw a relative increase of almost 60%. Although this is a large relative increase, the absolute percentage of websites using `Permissions-Policy` remains rather small at 3.7% on mobile. The rise in adoption is a good sign for the policy.

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
        <td class="numeric">11.02%</td>
        <td class="numeric">11.56%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), autoplay=(), camera=(), encrypted-media=(), fullscreen=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), midi=(), payment=(), picture-in-picture=(), publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=(), usb=()</code></td>
        <td class="numeric">5.01%</td>
        <td class="numeric">10.00%</td>
      </tr>
      <tr>
        <td><code>geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()</code></td>
        <td class="numeric">4.63%</td>
        <td class="numeric">4.44%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), autoplay=(), camera=(), cross-origin-isolated=(), display-capture=(self), encrypted-media=(), fullscreen=*, geolocation=(self), gyroscope=(), keyboard-map=(), magnetometer=(), microphone=(), midi=(), payment=*, picture-in-picture=*, publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=*, usb=(), xr-spatial-tracking=(), gamepad=(), serial=()</code></td>
        <td class="numeric">3.65%</td>
        <td class="numeric">3.45%</td>
      </tr>
      <tr>
        <td><code>geolocation=(self)</code></td>
        <td class="numeric">2.06%</td>
        <td class="numeric">2.64%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()</code></td>
        <td class="numeric">2.77%</td>
        <td class="numeric">2.38%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(self), autoplay=(self), camera=(self), encrypted-media=(self), fullscreen=(self), geolocation=(self), gyroscope=(self), magnetometer=(self), microphone=(self), midi=(self), payment=(self), usb=(self)</code></td>
        <td class="numeric">2.39%</td>
        <td class="numeric">2.25%</td>
      </tr>
      <tr>
        <td><code>browsing-topics=()</code></td>
        <td class="numeric">1.82%</td>
        <td class="numeric">2.14%</td>
      </tr>
      <tr>
        <td><code>geolocation=(), microphone=(), camera=()</code></td>
        <td class="numeric">2.11%</td>
        <td class="numeric">2.09%</td>
      </tr>
      <tr>
        <td><code>geolocation=self</code></td>
        <td class="numeric">1.87%</td>
        <td class="numeric">1.81%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent `Permission-Policy` headers", sheets_gid="180881517", sql_file="pp_header_prevalence.sql") }}</figcaption>
</figure>

When looking at the top 10 used `Permissions-Policy` values, we find that less developers now use the header to opt out of Google's <a hreflang="en" href="https://privacysandbox.com/intl/en_us/proposals/floc/">Federated Learning of Cohorts (FLoC)</a>, with only 11.5% of `Permissions-Policy` headers contain the `interest-cohort=()` value. We also see that a value to opt out of many features at once became a popular value with 10% of `Permissions-Policy` headers containing this value on mobile. We did not observe a direct cause of this change.

All other observed values in the top 10 are aimed at restricting the permissions of the web page and embedded content. The Permissions Policy is open by default, which means that in order to restrict the use of a feature, it has to explicitly be mentioned in the header. Like last year, 0.27% of `Permissions-Policy` headers on desktop set the `*` wildcard value, thereby explicitly granting all permissions to the page and embedded content that does not define a stricter policy in the `allow` attribute. On mobile, we do not find the wildcard value at all.

As mentioned before, the Permissions Policy can also be defined in the `allow` attribute on a html `<iframe>`. For example an iframe allowing its embedded content to have access to the camera and microphone would look like:

```html
<iframe src="https://example.com/" allow="camera 'self'; microphone 'self'">
```

Out of the total 33.3 million iframes on mobile, we observed that 29.2% include an `allow` attribute. The relative decrease in use of the `allow` attribute can be attributed to the more than 10 million more iframe elements that were found in this year's crawl that included more pages than last year's.

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
        <td><code>encrypted-media</code></td>
        <td class="numeric">60.90%</td>
        <td class="numeric">70.66%</td>
      </tr>
      <tr>
        <td><code>autoplay</code></td>
        <td class="numeric">34.99%</td>
        <td class="numeric">41.83%</td>
      </tr>
      <tr>
        <td><code>picture-in-picture</code></td>
        <td class="numeric">26.10%</td>
        <td class="numeric">36.63%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">23.76%</td>
        <td class="numeric">34.20%</td>
      </tr>
      <tr>
        <td><code>accelerometer</code></td>
        <td class="numeric">23.76%</td>
        <td class="numeric">34.20%</td>
      </tr>
      <tr>
        <td><code>clipboard-write</code></td>
        <td class="numeric">20.39%</td>
        <td class="numeric">26.24%</td>
      </tr>
      <tr>
        <td><code>join-ad-interest-group</code></td>
        <td class="numeric">24.23%</td>
        <td class="numeric">17.35%</td>
      </tr>
      <tr>
        <td><code>web-share</code></td>
        <td class="numeric">12.07%</td>
        <td class="numeric">15.67%</td>
      </tr>
      <tr>
        <td><code>attribution-reporting</code></td>
        <td class="numeric">3.93%</td>
        <td class="numeric">2.35%</td>
      </tr>
      <tr>
        <td><code>run-ad-auction</code></td>
        <td class="numeric">3.84%</td>
        <td class="numeric">2.26%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent `allow` attribute directives", sheets_gid="1876706326", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

Interestingly, the three top `allow` attribute values of last year (`join-ad-interest-group`, `attribution-reporting` and `run-ad-auction`) have extremely low adoption compared to last year. It is possible that the large player that was hypothesized to have added these values to their iframe elements has since reverted that change. The other top 10 values of last year have seen a major increase in inclusion into the `allow` attribute value overall, with absolute changes up to plus 50%.

### Iframe sandbox

By employing the [`sandbox`](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe#sandbox) attribute on `<iframe>` elements, developers can protect their users against several attacks in which a resource embedded in an `<iframe>` is either compromised or malicious. In the `sandbox` attribute's value, developers can specify which restrictions should be put into place for the content loaded and displayed in the `<iframe>`. For example, the following `<iframe>` would allow the embedded webpage to run scripts:

```html
<iframe src="https://example.com/" sandbox="allow-scripts"></iframe>
```

We see the use of the sandbox attribute rise compared to the 2024 edition: The percentage of iframes with a sandbox attribute rose from 20.0% to 22.7%, showing that more and more developers want to protect their users against potential misuse by embedded content.

{{ figure_markup(
  image="iframe-sandbox-directives.png",
  caption="Prevalence of sandbox directives on iframes.",
  description="Bar chart showing the adoption of specific permissions within sandboxed iframes across desktop and mobile platforms. The directives `allow-scripts` and `allow-same-origin` are nearly universal, appearing in approximately 97-98% of sandboxed pages to ensure that embedded content maintains core functionality like JavaScript execution and access to its own storage. Moderately common features include `allow-popups` and `allow-popups-to-escape-sandbox`, which are utilized by about 70-75% of sites, while specialized navigation controls like `allow-top-navigation-by-user-activation` are the least adopted at under 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1050517232&format=interactive",
  sheets_gid="679180424",
  sql_file="iframe_sandbox_directives.sql"
  )
}}

Like [last year](../2024/security#iframe-sandbox), we see that out of all iframes with the `sandbox` attribute, 98.5% (on mobile) use it to allow the embedded webpage to execute scripts by including the `allow-scripts` directive. Following in second place, used in 97.8% on mobile iframes, developers use the `allow-same-origin` to make the loaded resources part of the embedder's origin.

## Emerging security headers

In general we see a rise in most of the existing security features such as TLS, HSTS, CSP policies, SRI and the iframe `sandbox` attribute. Besides these existing features, as time keeps moving, new attacks are crafted and more defenses are being implemented. This section goes over the relatively new Document Policy that is starting to show up more often in the wild.

### Document Policy

<a hreflang="en" href="https://wicg.github.io/document-policy/">Document Policy</a> is a draft community group report last updated in 2022. It was originally created as a response to proposed additions to Permissions Policy that did not fit the Permissions Policy model or added too much complexity.

Document Policy has several advantages over related mechanisms such as Permissions Policy, CSP and sandboxing: It is more fine-grained than Permissions Policy and has a different inheritance model: child resources can overwrite certain parent-chosen policies if they are compatible. It is more general than CSP: It has directives related to the permissions of a resource once it has been loaded instead of only determining from which origins resources can be loaded and it is easier to extend than sandboxing because features that are not mentioned in sandboxing are blocked by default, which makes it very difficult to add new ones.

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
        <td><code>include-js-call-stacks-in-crash-reports</code></td>
        <td class="numeric">68.48%</td>
        <td class="numeric">71.99%</td>
      </tr>
      <tr>
        <td><code>js-profiling</code></td>
        <td class="numeric">12.66%</td>
        <td class="numeric">15.24%</td>
      </tr>
      <tr>
        <td><code>js-profiling; include-js-call-stacks-in-crash-reports</code></td>
        <td class="numeric">17.41%</td>
        <td class="numeric">11.94%</td>
      </tr>
      <tr>
        <td><code>force-load-at-top</code></td>
        <td class="numeric">1.25%</td>
        <td class="numeric">0.65%</td>
      </tr>
      <tr>
        <td><code>no-font-display-late-swap</code></td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most common document policy header values", sheets_gid="1931592953", sql_file="documentpolicy_most_common_header.sql") }}</figcaption>
</figure>

We can see that of the Document Policy headers in use, more than two thirds of them are used to include call stacks in crash reports. Combined with the `js-profiling` directive these two features make up the vast majority of current use-cases. Currently in total we find policy values containing 19 different directives, in general there may be more defined but as of now we are not aware of the total number of directives that are defined.

While we currently only find just over 24,000 and 29,500 pages for desktop and mobile respectively which is 0.10% of the total number of pages visited for both. We expect to see a rise in adoption of Document Policy headers going forward, although future adoption may not happen quickly.

## Attack preventions

While there are many defenses for websites implemented by many browsers, it can be challenging to keep an overview of all the possibilities and best-practices. In addition, when protections are opt-in and therefore not enabled by default, it becomes even more of a challenge. Developers have to remain up to speed with modern attacks and the defenses that exist to protect users against these attacks. This section assesses which attack prevention measures are in use across the web.

### Security header adoption

A multitude of protection mechanisms can be configured through HTTP response headers. Based on the values of these headers the browser will enforce these protections. Not all security mechanisms are relevant for every website, but the absence of all security headers can point to missing urgency towards security.

{{ figure_markup(
  image="security-headers-mobile.png",
  caption="Adoption of security headers for site requests in mobile pages over time.",
  description="Bar chart showing the growth in usage of various security headers on mobile websites from 2023 to 2025. The data reveals a consistent upward trend in adoption for the most common headers, with `X-Content-Type-Options` leading the group at nearly 50 percent adoption by 2025. Other prominent headers like `X-Frame-Options` and `Strict-Transport-Security` follow closely, showing steady increases to approximately 35 percent of sites. Meanwhile, more modern or niche headers such as `Cross-Origin-Opener-Policy` and `Permissions-Policy` remain in the early stages of adoption, staying well below the 10 percent threshold.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=710761597&format=interactive",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql"
  )
}}

[Like last year](../2024/security#security-header-adoption) there are only a few headers for which adoption decreased. The `Feature-Policy` header is deprecated in favor of the `Permissions-Policy`, therefore it's no surprise that the adoption is declining. The other two: `Clear-Site-Data` and `Document-Policy-Report-Only` have such low adoption (0.01% and 0.00001% respectively) that relative changes in adoption may seem large while absolute differences are actually small. This means that the overall adoption of security headers keeps increasing over time, which is a positive sign for web security overall.

The strongest risers since the 2024 edition are `Strict-Transport-Security` (+4.02%), `Content-Security-Policy` (+3.39%) and `X-Content-Type-Options` (+2.30%).

#### Origin-Agent-Cluster

The [`Origin-Agent-Cluster`](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Origin-Agent-Cluster), when correctly set, communicates to the browser a request to share the resources used for the document (like the operating system process) with documents of the same origin. the browser may or may not honor the request and the client can verify using JavaScript whether the request was in fact honored.

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
        <td><code>?1</code></td>
        <td class="numeric">74.11%</td>
        <td class="numeric">90.32%</td>
      </tr>
      <tr>
        <td><code>?0</code></td>
        <td class="numeric">25.79%</td>
        <td class="numeric">9.60%</td>
      </tr>
      <tr>
        <td><code>1</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>0</code></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most common `Origin-Agent-Cluster` header values", sheets_gid="1123976436", sql_file="oac_header_prevalence.sql") }}</figcaption>
</figure>

A boolean is <a hreflang="en" href="https://httpwg.org/specs/rfc8941.html#boolean">defined in the HTML living standard</a> as a string starting with a question mark. This means that values like `1` and `0` are invalid for this header. Luckily the use of these values is limited. The `?1` value is the only valid value for the `Origin-Agent-Cluster` and it's used to communicate that the developer wants to opt into the feature, all other values are ignored. On mobile, more than 90% of headers have the valid `?1` value. Unfortunately, 0.07% of header values are `1`, a value that will be ignored while the developer likely wants to request the use of dedicated resources.

#### Use of `document.domain`

By using [`document.domain`](https://developer.mozilla.org/docs/Web/API/Document/domain), a developer was able to read the domain portion of the current document, as well as set a new domain (only superdomains of the current domain are allowed), after which the browser will use the new domain as origin for the same-origin policy checks. However, the use of this property is now deprecated and browsers may stop supporting the property soon.

<figure>
  <table>
    <thead>
      <tr>
        <th>Blink Feature</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>DocumentSetDomain</code></td>
        <td class="numeric">0.49%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td><code>DocumentDomainSetWithNonDefaultPort</code></td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.14%</td>
      </tr>
      <tr>
        <td><code>DocumentDomainEnabledCrossOriginAccess</code></td>
        <td class="numeric">0.0008%</td>
        <td class="numeric">0.0004%</td>
      </tr>
      <tr>
        <td><code>DocumentDomainBlockedCrossOriginAccess</code></td>
        <td class="numeric">0.0002%</td>
        <td class="numeric">0.0001%</td>
      </tr>
      <tr>
        <td><code>DocumentOpenAliasedOriginDocumentDomain</code></td>
        <td class="numeric">0.00008%</td>
        <td class="numeric">0.00001%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The use of `document.domain` based on specific blink features", sheets_gid="1240446071", sql_file="documentdomain_usage.sql") }}</figcaption>
</figure>

We see that less than 0.5% of websites on desktop and mobile are using the `document.domain` setter to change the origin of a page and even less sites do so with a non-default port. This is a positive trend but still represents a few tens of thousand website, which should update their code.

### Preventing clickjacking with CSP and X-Frame-Options

As previously mentioned, a Content Security Policy (CSP) can be effective against <a hreflang="en" href="https://owasp.org/www-community/attacks/Clickjacking">Clickjacking</a> attacks through the use of the `frame-ancestors` directive. Some of the top CSP header values include a `frame-ancestors` directive with a `'none'` or `'self'` value, thereby blocking embedding of the page overall or restricting the embeddings to pages of the same origin.

Another way of defending against clickjacking attacks is through the [`X-Frame-Options` (XFO)](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Frame-Options) header. By setting the XFO developers can communicate that a document cannot be embedded in other documents ('DENY') or can only be embedded in documents of the same origin (`SAMEORIGIN`).

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
        <td class="numeric">72.48%</td>
        <td class="numeric">72.13%</td>
      </tr>
      <tr>
        <td><code>DENY</code></td>
        <td class="numeric">24.40%</td>
        <td class="numeric">24.64%</td>
      </tr>
      <tr>
        <td><code>ALLOWALL</code></td>
        <td class="numeric">0.68%</td>
        <td class="numeric">0.72%</td>
      </tr>
      <tr>
        <td><code>SAMEORIGIN, SAMEORIGIN</code></td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.28%</td>
      </tr>
      <tr>
        <td><code>allow-from https://s.salla.sa</code></td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.28%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent `X-Frame-Options` header values", sheets_gid="1545864706", sql_file="xfo_header_prevalence.sql") }}</figcaption>
</figure>

We find that there are barely any changes between the data this year [and in 2024](../2024/security#security-header-adoption). The `X-Frame-Options` header is primarily used to allow same-origin websites to embed the page (72.1%). Secondly, it is used to deny any page from embedding its own content (24.6%).

Examples of other values we observe are shown in the third to fifth row of the table. The `ALLOW-FROM` value used to be valid but is now deprecated and ignored by browsers. Instead of using `ALLOW-FROM` in XFO, developers should switch to using the `frame-ancestors` directive in CSP. These out-of-spec values do not show up often, but may have been set by developers expecting protections to be active due to them setting the header.

### Preventing attacks using Cross-Origin policies

Because of the emergence of microarchitectural side-channel attacks like <a hreflang="en" href="https://spectreattack.com/">Spectre and Meltdown</a> and <a hreflang="en" href="https://xsleaks.dev/">Cross-Site Leaks (XS-Leaks)</a>, our security perspective relating to use and embeddings of cross-origin resources has changed. In response to these upcoming threats, new mechanisms to control the rendering of resources on other websites and thereby protect against these new threats were created.

Multiple new security headers, known as the cross-origin policies, were created as a response to these challenges: Cross-Origin-Resource-Policy (CORP), Cross-Origin-Embedder-Policy (COEP) and Cross-Origin-Opener-Policy (COOP). These headers provide mechanisms that protect against side-channel attacks by allowing developers to control how their resources are embedded across different origins. We observe that the adoption of all of these headers keeps growing year after year, with both CORP and COOP reaching over 2% adoption this year.

{{ figure_markup(
  image="cross-origin-headers-trend.png",
  caption="Usage of Cross-Origin headers over time.",
  description="Bar chart showing the usage of three specific security headers between 2023 and 2025. It shows that `Cross-Origin-Resource-Policy` remains the most widely adopted of the three, growing from approximately 1.75% in 2023 to over 2.25% by 2025. `Cross-Origin-Opener-Policy` experienced the most significant relative growth, more than doubling its adoption from under 1.00% to roughly 2.00% over the three-year period. While `Cross-Origin-Embedder-Policy` remains the least common, it demonstrates a steady upward trend, reaching nearly 0.75% adoption by 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=157500281&format=interactive",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql"
  )
}}

#### Cross Origin Embedder Policy

The [Cross-Origin-Embedder-Policy (COEP)](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy) allows a developer to configure which cross-origin resources can be embedded on the current document. By default (when the header is absent) all cross-origin resources can be embedded on the page, which is the same behaviour as when the header is set with the `unsafe-none` value.

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
        <td class="numeric">83.26%</td>
        <td class="numeric">86.52%</td>
      </tr>
      <tr>
        <td><code>require-corp</code></td>
        <td class="numeric">6.68%</td>
        <td class="numeric">4.92%</td>
      </tr>
      <tr>
        <td><code>credentialless</code></td>
        <td class="numeric">2.59%</td>
        <td class="numeric">1.89%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of COEP headers containign a valid varient of the allowed values", sheets_gid="1595978010", sql_file="coep_header_prevalence.sql") }}</figcaption>
</figure>

[Compared to last year](../2024/security#cross-origin-embedder-policy), most developers still set the COEP header to explicitly allow all content to be embedded onto the current document using the `unsafe-none` value. While the percentage of use of this value is still over 86% on mobile, it has dropped by almost 2% since last year, which can indicate that developers are starting to change their use of the header.

The other values `require-corp` and `credentialless` saw a minor increase of 0.2% and 0.3% respectively in adoption since last year. When using `require-corp`, the browser will enforce that only same-origin content or cross-origin content that is allowed to be embedded by CORP can be embedded onto the page.

For `credentialless`, the browser will allow cross-origin requests in `no-cors` mode regardless of CORS policy of the content, but cookies will not be attached to the request.

#### Cross Origin Resource Policy

Related to COEP, the [Cross-Origin-Resource-Policy (CORP)](https://developer.mozilla.org/docs/Web/HTTP/Cross-Origin_Resource_Policy) does not enforce which content can be embedded in the current document, but rather from which documents the current content can be accessed.

The only three possible values are `cross-origin`, `same-origin` and `same-site`. The `cross-origin` value allows any document to access the resource., while the `same-origin` and `same-site` restrict which documents can access the resource to the documents in the same origin or site respectively. Developers should be aware of the [difference between the origin (scheme, host, port) and site (registerable domain)](https://web.dev/articles/url-parts). If the header is present, requests with a mode of `no-cors` will be blocked by the browser.

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
        <td class="numeric">81.36%</td>
        <td class="numeric">80.52%</td>
      </tr>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">14.40%</td>
        <td class="numeric">15.63%</td>
      </tr>
      <tr>
        <td><code>same-site</code></td>
        <td class="numeric">3.80%</td>
        <td class="numeric">3.48%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of CORP header values", sheets_gid="758863059", sql_file="corp_header_prevalence.sql") }}</figcaption>
</figure>

In most cases, the header is used to allow access to any cross-origin resource. We see a big change in this number this year, dropping more than 10% since [last year](../2024/security#cross-origin-resource-policy) and landing on 80.5% on mobile. On the other hand, the use of the `same-origin` value went up around 10%, showing that developers are moving to protect their resources against cross-origin access. The share of use for `same-site` remained approximately the same, showing a slight decrease of less than half a percent.

#### Cross Origin Opener Policy

The final cross-origin policy header, [Cross-Origin-Opener-Policy (COOP)](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy) allows a developer to control how other pages can reference their page when opening it through for instance the `window.open` API.

The default value of `unsafe-none` allows the COOP protection to be disabled, which is also what happens when the header is absent. If a developer uses `window.open` to open a page which uses `unsafe-none`, they can use the returned value to access certain properties of the opened page, which can lead to Cross-Site Leaks.

When `same-origin` is present on both the opener and opened resource, the reference returned by `windows.open` can be used by the opener. The `same-origin-allow-popups` allows a document to open another document with `unsafe-none` while still keeping access to a working reference.

Finally, the `noopener-allow-popups` makes sure the reference is never accessible except for when the opened document also has the same COOP value set.

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
        <td class="numeric">58.22%</td>
        <td class="numeric">61.64%</td>
      </tr>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">28.47%</td>
        <td class="numeric">26.82%</td>
      </tr>
      <tr>
        <td><code>same-origin-allow-popups</code></td>
        <td class="numeric">11.36%</td>
        <td class="numeric">9.95%</td>
      </tr>
      <tr>
        <td><code>noopener-allow-popups</code></td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of COOP headers containing a valid variant of the allowed values", sheets_gid="1357383563", sql_file="coop_header_prevalence.sql") }}</figcaption>
</figure>

The use of the strictest `same-origin` value for COOP has continued to rise from 47.5% to 61.6% on mobile. The `noopener-allow-popups` is a very new value and was not present yet [last year](../2024/security#cross-origin-opener-policy). This year we see a small share of adopters using this value. The use of `unsafe-none` had declined by just over 10%. These changes represent a positive evolution in the use of COOP.

#### Cross-origin isolation

In order to access certain sensitive APIs like `SharedArrayBuffer` or `Performance.now` a site has to be [cross-origin isolated](https://developer.mozilla.org/docs/Web/API/Window/crossOriginIsolated). In order to be cross-origin isolated, the developer has to set a COEP of `same-origin` and CORP of either `require-corp` or `credentialless`. The browser will then allow access to these APIs again. This strengthens the protection against XS Leaks. These days, developers can opt into cross-origin isolation using the <a hreflang="en" href="https://wicg.github.io/document-isolation-policy/">document isolation policy</a> as well.

### Preventing attacks using `Clear-Site-Data`

Using the [`Clear-Site-Data`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Clear-Site-Data) HTTP response header, developers are able to instruct the client to clear browsing data. The value of the header specifies which type or types of data should be cleared. This can be useful when a user logs out of the website, so the developer can be sure that any authentication cookies are most assuredly cleared.

It is difficult to estimate the adoption of `Clear-Site-Data` correctly as its use is usually most valuable when logging out users. The crawler does not log in onto websites and therefore can also not log out to check how many sites use the header after logout. For now, we see 2,024 mobile hosts using the `Clear-Site-Data` header, which is only 0.01% of the total number of hosts crawled.

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
        <td><code>cache</code></td>
        <td class="numeric">30.82%</td>
        <td class="numeric">29.25%</td>
      </tr>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">17.74%</td>
        <td class="numeric">20.61%</td>
      </tr>
      <tr>
        <td><code>cookies</code></td>
        <td class="numeric">7.02%</td>
        <td class="numeric">8.16%</td>
      </tr>
      <tr>
        <td><code>"cache"</code></td>
        <td class="numeric">8.94%</td>
        <td class="numeric">7.19%</td>
      </tr>
      <tr>
        <td><code>"storages"</code></td>
        <td class="numeric">5.66%</td>
        <td class="numeric">6.08%</td>
      </tr>
      <tr>
        <td><code>cache, cookies, storage</code></td>
        <td class="numeric">2.12%</td>
        <td class="numeric">3.23%</td>
      </tr>
      <tr>
        <td><code>"cache", "cookies", "storage", "executionContexts"</code></td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.51%</td>
      </tr>
      <tr>
        <td><code>"cookies"</code></td>
        <td class="numeric">2.78%</td>
        <td class="numeric">2.46%</td>
      </tr>
      <tr>
        <td><code>"storage"</code></td>
        <td class="numeric">2.27%</td>
        <td class="numeric">2.03%</td>
      </tr>
      <tr>
        <td><code>"cache", "storage", "executionContexts"</code></td>
        <td class="numeric">1.36%</td>
        <td class="numeric">1.54%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of `Clear-Site-Data` headers", sheets_gid="301356995", sql_file="clear-site-data_value_prevalence.sql") }}</figcaption>
</figure>

Our data shows that most developers attempt to use the `Clear-Site-Data` header for clearing the cache. The most prevalent value is `cache`, followed by the wildcard character `*` and `cookies`. All values from the top three are invalid according to the specification. The value of this header must be a 'quoted string', which means `"cache"`, `"*"` and `"cookies"` are the equivalent valid values. This is concerning as the top three values combined already represent 58.01% of current header values on mobile.

We see these numbers jump quite a lot year after year, which can likely be explained by the low adoption of the header, where a very small number of hosts can change the relative fraction by a large amount.

### Preventing attacks using `<meta>`

Besides as a response header, some of the security mechanisms of the web can be configured directly within the html document through the use of the `<meta>` tag. Two examples of this are the `Content-Security-Policy` and the `Referrer-Policy`. The use of a meta tag for these mechanisms has remained largely stable from [last year](../2024/security#preventing-attacks-using-meta), at around 0.60% and around 2.50% for the CSP and Referrer-Policy respectively. A very small decrease in CSP and very small increase in Referrer-Policy could be observed, just like last year.

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
        <td><code>includes Referrer-policy</code></td>
        <td class="numeric">2.75%</td>
        <td class="numeric">2.52%</td>
      </tr>
      <tr>
        <td><code>includes CSP</code></td>
        <td class="numeric">0.64%</td>
        <td class="numeric">0.59%</td>
      </tr>
      <tr>
        <td><code>includes not-allowed policy</code></td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.11%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The percentage of hosts enabling different policies using a meta tag", sheets_gid="1717430289", sql_file="meta_policies_allowed_vs_disallowed.sql") }}</figcaption>
</figure>

Other security mechanisms can not be configured through the use of the `<meta>` tag, however every year we see developers still attempt this. This year we even see a rise in policies that are not allowed to be configured using a meta tag from 0.07% to 0.11% on mobile. These values are ignored by the browser, thus potentially leaving users vulnerable if the correct header is not configured. Keeping up with our running example, this year we found 5,564 meta tags that included the `X-Frame-Options` policy. This is almost 600 pages more than last year, which is a worrying evolution.

### Web Cryptography API

The <a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a> is a JavaScript API that provides an interface for performing basic cryptographic operations. Examples of such operations are the creation of random numbers, hashing, signing content, verifying signatures and of course encryption and decryption.

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
        <td><code>CryptoGetRandomValues</code></td>
        <td class="numeric">34.45%</td>
        <td class="numeric">40.95%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoDigest</code></td>
        <td class="numeric">2.65%</td>
        <td class="numeric">2.98%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha256</code></td>
        <td class="numeric">2.36%</td>
        <td class="numeric">2.48%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoImportKey</code></td>
        <td class="numeric">1.29%</td>
        <td class="numeric">1.68%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmEcdh</code></td>
        <td class="numeric">0.97%</td>
        <td class="numeric">1.39%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha512</code></td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.32%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha1</code></td>
        <td class="numeric">0.21%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmAesCbc</code></td>
        <td class="numeric">0.21%</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoSign</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.14%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoEncrypt</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmHmac</code></td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.11%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The usages of features of the Web Cryptography API", sheets_gid="433834892", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

The `CryptoGetRandomValues` remains the most widely used feature of this API, however it is still declining in use, [just like it was last year](../2024/security#web-cryptography-api). Its use on mobile dropped by more than 12% this year, landing just under 41%. The other features continue to rise, with the second most popular feature `SubtleCryptoDigest` growing by 1.2% to just under 3%.

### Bot protection services

Bots have been present on the web for a long time, and malicious bots are a large part of that. Because of these issues, many products have been created by different vendors to protect websites against bots. The use of these products continues to rise year after year, including this year, where we see a jump from 26.5% to 31.1% adoption on mobile, a rise of over 4.5%.

{{ figure_markup(
  image="bot-protection-absolute.png",
  caption="The absolute distribution of bot protection services in use.",
  description="Bar chart showing the market share of various bot mitigation tools on desktop versus mobile platforms. The data shows that reCAPTCHA and Cloudflare Bot Management are the dominant services, collectively protecting approximately 30 percent of websites across both client types. Desktop sites exhibit slightly higher overall adoption of these services at over 34 percent, compared to just above 31 percent for mobile sites. Other services like Cloudflare Turnstile, hCaptcha, and DDoS-Guard represent much smaller fractions of the total market, each appearing on less than 2 percent of surveyed websites",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1081236768&format=interactive",
  sheets_gid="1427912746",
  sql_file="bot_detection.sql"
  )
}}

{{ figure_markup(
  image="bot-protection-relative.png",
  caption="The relative distribution of bot protection services in use.",
  description="Bar chart showing the market share of various bot mitigation tools among the subset of websites that utilize such services. The data illustrates a highly concentrated market where reCAPTCHA and Cloudflare Bot Management collectively account for over 90 percent of the relative usage on both desktop and mobile platforms. Specifically, reCAPTCHA holds the largest share with 50.7 percent on desktop and 52.0 percent on mobile, while Cloudflare Bot Management follows with 40.6 percent and 38.6 percent respectively. Minor providers such as hCaptcha, DDoS-Guard, and Cloudflare Turnstile represent only very small fractions of the total, each comprising less than 2 percent of the relative usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1085355715&format=interactive",
  sheets_gid="1427912746",
  sql_file="bot_detection.sql"
  )
}}

We see that reCAPTCHA remains the largest bot protection service, but Cloudflare Bot Management is growing more rapidly, thereby taking up a larger relative share of websites using bot protection services. In case these trends continue over the next year, we may see Cloudflare Bot Management closing the gap on reCAPTCHA.

### HTML sanitization

With the `SetHTMLUnsafe` and `ParseHTMLUnsafe` APIs, two relatively recent additions to browsers, developers can [use a declarative shadow DOM from JavaScript](https://developer.chrome.com/blog/new-in-chrome-124#dsd).

When a developer attempts to use `innerHTML` to place a custom HTML component that includes a definition for a declarative shadow DOM onto the page (for example `<template shadowrootmode="open">...</template>`), this will not work as expected. By using `SetHTMLUnsafe` or `ParseHTMLUnsafe` the developer can ensure that the declarative shadow DOM is properly instantiated by the browser.

As the name implies, the developer is responsible for making sure that only safe values are passed to these 'unsafe' APIs. In other cases, the developer runs the risk of allowing dangerous content to end up on the page, which can lead to XSS attacks.

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
        <td class="numeric">19869</td>
        <td class="numeric">17147</td>
      </tr>
      <tr>
        <td><code>SetHTMLUnsafe</code></td>
        <td class="numeric">443</td>
        <td class="numeric">449</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="The number of pages using HTML sanitization APIs", sheets_gid="1789171380", sql_file="html_sanitization_usage.sql") }}</figcaption>
</figure>

Since [last year](../2024/security#html-sanitization), we see a big rise in the use of these APIs. On mobile, the number of pages using `SetHTMLUnsafe` rose from 2 to 449 pages and the number using `ParseHTMLUnsafe` rose from 6 to 17,147 this year. The latter still only accounts for 0.06% of the crawled pages, but it is an interesting change and we can expect the adoption to keep rising in the following year, although it is not expected that these APIs will gain widespread adoption anytime soon.

## Drivers of security mechanism adoption

There may be various reasons that web developers choose to adopt more security practices. Some of the most noteworthy are:

- **Geographical**: depending on the region, there may be more security-oriented education or knowledge, or in some cases there can be local laws that mandate stricter security hygiene.
- **Technological**: the technology stack in use can influence the adoption of security mechanisms. Depending on the technology in use, some security features will be enabled out of the box without the developer having to think about enabling them.
- **Popularity**: very popular websites may have larger budgets for security, in part because they are more likely to be the target of certain cyberattacks. In addition, these sites are likely to attract more security professionals and in some cases bug bounty hunters to help them implement security features and strengthen their defenses.

### Location of websites

The location where a website is hosted or where its developers are based can have a big impact on the adoption of certain security features. Security education for developers plays a big role, as developers cannot implement features of which they don't know they exist or which they don't understand. In addition, local laws can sometimes require the adoption of certain security practices.

{{ figure_markup(
  image="https-by-country.png",
  caption="The adoption of HTTPS per country; top and bottom 10 countries by adoption.",
  description="Bar chart showing the percentage of desktop websites using HTTPS across various nations. The data reveals exceptionally high adoption rates globally, with New Zealand leading the list at 99.70%, followed closely by Switzerland and Nigeria at 99.67%. Even the countries at the lower end of this specific ranking, such as Japan and the Republic of Korea, maintain high encryption standards with adoption rates of 94.17% and 95.34% respectively. Overall, the chart illustrates a nearly universal move toward secure web communication, with every listed country surpassing a 94% adoption threshold.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1706573742&format=interactive",
  sheets_gid="1980003998",
  sql_file="feature_adoption_by_country.sql"
  )
}}

HTTPS adoption has been increasing year after year, a trend that luckily continues this year as well. We see even adoption in the top countries continued to increase by a few tenths of a percentage. The bottom countries saw slightly larger rises in HTTPS adoption, with Japan now being the only country with adoption under 95% and only five countries having less than 98% adoption of HTTPS, an extremely good result. In the following years, we can expect the bottom countries to slowly catch up with the rate of adoption of the top countries, although a full 100% adoption seems unlikely in the near future.

{{ figure_markup(
  image="csp-xfo-by-country.png",
  caption="The adoption of CSP and XFO per country; top 5 and bottom 5 countries by CSP adoption.",
  description="Bar chart showing the implementation rates of Content Security Policy and X-Frame-Options on desktop sites across various nations. New Zealand leads the featured countries with the highest adoption for both security measures, reaching 42.25% for XFO and 29.50% for CSP. In contrast, the Republic of Korea exhibits significantly lower levels, with only 14.69% of sites using XFO and 8.89% using CSP. Across all listed countries, the data consistently shows that X-Frame-Options maintains a higher adoption rate than Content Security Policy, suggesting that CSP remains the more complex or less frequently implemented security standard.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1911016277&format=interactive",
  sheets_gid="1980003998",
  sql_file="feature_adoption_by_country.sql"
  )
}}

We see a more varied picture when looking at more complex security mechanisms. With a small rise in adoption for most leading countries, some of the bottom countries saw a decline in adoption of these policies. The leading countries still have CSP configured on just over a quarter of the websites. The gap between CSP and XFO remains large, although it has gone up slightly, reaching only up to 14% instead of 15% [last year](../2024/security#location-of-website).

### Technology stack

A website's security can vary depending on the technology in use. Because frameworks include security features by default and it is in the best interest of large vendors to keep their users secured, using these underlying technologies may boost a website's security.

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
        <td>LiveJournal</td>
        <td><code>Content-Security-Policy</code> (99.99%), <code>Permissions-Policy</code> (99.99%), <code>Referrer-Policy</code> (99.99%)</td>
      </tr>
      <tr>
        <td>Weblium</td>
        <td><code>X-Content-Type-Options</code> (97.31%), <code>X-XSS-Protection</code> (97.31%)</td>
      </tr>
      <tr>
        <td>GoDaddy Website Builder</td>
        <td><code>Strict-Transport-Security</code> (95.97%), <code>Content-Security-Policy</code> (95.97%)</td>
      </tr>
      <tr>
        <td>Sitevision CMS</td>
        <td><code>X-Frame-Options</code> (81.54%)</td>
      </tr>
      <tr>
        <td>Microsoft Sharepoint</td>
        <td><code>X-Content-Type-Options</code> (57.44%)</td>
      </tr>
      <tr>
        <td>Liferay</td>
        <td><code>X-Content-Type-Options</code> (52.65%)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Security features in use by selected CMS systems.", sheets_gid="1417258040", sql_file="feature_adoption_by_technology.sql") }}</figcaption>
</figure>

We see that a number of blogging websites and website builders have some important security mechanisms configured almost throughout all of their systems, with HSTS, CSP and `X-Content-Type-Options` being some of the most popular ones.

### Website popularity

Popular websites with a large user base often have a good reason to protect their users to the best of their abilities so they will not lose users and their trust. Protecting the often sensitive data they store while they likely are the target of more directed attacks requires significant investments in securing their website, but will likely also lead to a more generally security website as a trade-off.

{{ figure_markup(
  image="security-headers-by-rank.png",
  caption="Security header adoption by website rank according to CrUX.",
  description="Bar chart showing how the implementation of various security headers correlates with a website's popularity ranking on mobile. The data shows a clear trend where more popular websites, such as those in the top 1,000, have significantly higher adoption rates for headers like `X-Frame-Options` and `Strict-Transport-Security` compared to the broader web. For instance, `X-Frame-Options` adoption exceeds 60 percent for the top 1,000 sites but drops to approximately 30 percent when looking at all sites combined.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2036748504&format=interactive",
  sheets_gid="775322478",
  sql_file="security_adoption_by_rank.sql"
  )
}}

We find that the most popular security headers like `X-Frame-Options`, `Strict-Transport-Security`, `X-Content-Type-Options` and `Content-Security-Policy` always have a higher adoption among more popular websites on mobile. The most widely adopted header, `X-Frame-Options` is used on 67% of the top 1,000 sites yet only on 30% of all sites visited by the browser. We see the gap between the adoption in more popular sites and less popular sites remains practically identical since [last year](../2024/security#website-popularity).

### Website category

Depending on the industry, more importance may be attributed to keeping a website more secure. We attempt to estimate the efforts in securing websites per industry based on the average number of security headers set by websites. While the number of security headers does not necessarily indicate whether a website is better secured (after all, security mechanisms can be misconfigured), it provides a good estimate for the effort taken to implement security features.

{{ figure_markup(
  image="avg-security-headers-per-site.png",
  caption="The average number of security headers by website category; top 5 and bottom 5 categories.",
  description="Bar chart showing the average number of security headers implemented across different website industries for both mobile and desktop platforms. The \"Internet & Telecom\" and \"Computers & Electronics\" sectors lead significantly, with mobile sites in these categories averaging 4.6 and 4.0 headers respectively. In contrast, many other industries like \"Law & Government\" and \"Travel & Transportation\" show much lower adoption rates, averaging only 1.3 headers per site. Across nearly all listed categories, mobile sites tend to have a higher average number of security headers compared to their desktop counterparts, highlighting a stronger focus on security for mobile users in these specific fields.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1092427119&format=interactive",
  sheets_gid="662895658",
  sql_file="feature_adoption_by_category.sql"
  )
}}

We see a big difference occurring in the average number of security headers since last year. Sites in the _Internet & Telecom_ and _Computers & Electronics_ categories use significantly more security headers. Especially on mobile clients the difference with following categories is clearly visible. While these two categories seem to be outliers in the good sense, the average number of security headers over other industries has remained largely the same, with here or there a very minor change of about 0.1 header per site on average.

The two leading industries in terms of security headers happen to be industries related to the field of internet and computer security. It is possible that due to the relevance of security in these industries, developers of these sites are more aware of the potential risk and therefore more willing to use certain security mechanisms.

## Malpractices on the web

Cryptocurrencies are more popular than they have ever been. Cryptomining has been a large business for a number of years and adversaries have been known to install cryptominers as a form of malware on victim websites. Over the past years, the use of cryptominers on the web has been steadily declining, just like it has been over the past year.

{{ figure_markup(
  image="cryptominers-trend.png",
  caption="The number of cryptominers in use over time; from May 2022 to Sep 2025.",
  description="Line chart showing the number of pages detected with cryptomining scripts from May 2022 to September 2025 for both desktop and mobile platforms. The data shows a significant overall decline in usage over the three-year period, with mobile pages consistently exhibiting higher levels of cryptominer activity than desktop pages. In early 2022, mobile instances peaked at nearly 250 pages, but by late 2025, both platforms had converged to significantly lower levels, with mobile staying under 50 pages and desktop under 25.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2128543496&format=interactive",
  sheets_gid="612990857",
  sql_file="cryptominer_usage.sql"
  )
}}

We see the number of pages with cryptominers decrease to only 37 pages on mobile, a 42% decline [since last year](../2024/security#fig-47). It is also a 83% decline since September 2022, only three years earlier.

{{ figure_markup(
  image="cryptominers-market-share.png",
  caption="The cryptominer market shares.",
  description="Bar chart showiung the specific cryptomining scripts detected across desktop and mobile platforms. The data shows that JSEcoin and Coinimp are the most prevalent services, especially on mobile devices where each was found on 9 pages. On desktop, Coinimp leads with 5 detected pages, followed by JSEcoin with 3. Other minor contributors such as Minero.cc, CoinHive, and Crypto-Loot account for the remaining detections, with overall counts being higher on mobile compared to desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1906348526&format=interactive",
  sheets_gid="1210984012",
  sql_file="cryptominer_share.sql"
  )
}}

Although we find a very low absolute number of cryptominers on the web, we still take a look at the shares that different cryptominers represent. Compared to [last year](../2024/security#fig-48), we see the number of pages with Coinimp has dropped to match the nine pages that have JSEcoin. An interesting note to make is the difference between the number of cryptominers on desktop and mobile pages, with the number of pages on mobile being almost double the number on desktop.

## Security misconfigurations and oversights

While there are many security mechanisms available on the web and in browsers, it is vital to configure these mechanisms correctly and as expected. Misconfigured security mechanisms create a false sense of security for the developer that thinks their users are protected. In this section we highlight the occurrence of several misconfigurations that can compromise a website's security.

### Unsupported policies in `<meta>`

When configuring security policies, it is important that developers understand how they have to define the policy. Some policies can be defined through both a header and the HTML `<meta>` tag. However, many policies can not be defined through `<meta>`. Developers sometimes make the mistake of trying to configure these policies through the `<meta>` tag anyway. Unfortunately browsers will ignore these policies, resulting in inactive security policies.

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
        <td><code>X-Frame-Options</code></td>
        <td class="numeric">4,584</td>
        <td class="numeric">5,564</td>
      </tr>
      <tr>
        <td><code>X-Content-Type-Options</code></td>
        <td class="numeric">2,440</td>
        <td class="numeric">2,854</td>
      </tr>
      <tr>
        <td><code>Permissions-Policy</code></td>
        <td class="numeric">1,983</td>
        <td class="numeric">2,236</td>
      </tr>
      <tr>
        <td><code>X-XSS-Protection</code></td>
        <td class="numeric">1,691</td>
        <td class="numeric">1,702</td>
      </tr>
      <tr>
        <td><code>Referrer-Policy</code></td>
        <td class="numeric">1,630</td>
        <td class="numeric">1,644</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 5 security policies mistakenly configured through `<neta>`", sheets_gid="1717430289", sql_file="meta_policies_allowed_vs_disallowed.sql") }}</figcaption>
</figure>

We find that around 0.11% of mobile sites attempt to set security headers that browsers explicitly do not support via `<meta>` tags. The most frequently attempted policies are `X-Frame-Options`, `X-Content-Type-Options` and `Permissions-Policy`. Compared to 2024, we see that the number of mobile sites setting these policies in `<meta>` rose in absolute numbers by more than 5,000 pages, showing that these misconfigurations are still actively being set by developers.

### Unsupported CSP directives in `<meta>`

While CSP *can* be configured via `<meta>` tags and this behaviour has been observed on 0.59% of mobile pages, certain CSP directives are explicitly disallowed in meta implementations and will be ignored by browsers. These directives can only be set by using the `Content-Security-Policy` response header.

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
        <td><code>frame-ancestors </code></td>
        <td class="numeric">2.37%</td>
        <td class="numeric">2.11%</td>
      </tr>
      <tr>
        <td><code>sandbox </code></td>
        <td class="numeric">0.004%</td>
        <td class="numeric">0.003%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentage of CSP policies defined in `<meta>` with disallowed directives", sheets_gid="1969221363", sql_file="meta_csp_disallowed_directives.sql") }}</figcaption>
</figure>

We find that over 2% of mobile pages setting a CSP policy via a `<meta>` tag include the `frame-ancestors` directive and 0.003% include the `sandbox` directive. The latter boils down to only three pages out of the entire crawled dataset. Compared to last edition the misconfiguration of `frame-ancestors` shows up on 600 more pages, thereby rising by over 0.8%. This represents a slow but negative evolution for these types of misconfigurations.

### COOP/COEP/CORP confusion

Because the cross-origin policies COEP, CORP, and COOP have a similar naming and are related in purpose, they are sometimes confused by developers. Assigning the wrong values to these headers has the effect that the browser will apply the default policy for the header as if no header was supplied at all, thereby disabling additional defenses wanted by the developer.

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
        <td class="numeric">4.43%</td>
        <td class="numeric">4.02%</td>
      </tr>
      <tr>
        <td><code>cross-origin</code></td>
        <td class="numeric">0.55%</td>
        <td class="numeric">0.46%</td>
      </tr>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>(unsafe-none|require-corp); report-to='default'</code></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>: require-corp</code></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalence of invalid COEP header values", sheets_gid="1595978010", sql_file="coep_header_prevalence.sql") }}</figcaption>
</figure>

In total, 5.6% of the observed COEP headers contain an invalid value on mobile. Over 4% of these headers contain the `same-origin` value that is only a valid value for the CORP or COOP headers. Another almost 0.5% contain `cross-origin`, a value destined for the CORP header. Unfortunately, these misconfigurations also saw a rise since [last year](../2024/security#coep-corp-and-coop-confusion), by almost 1% for the `same-origin` value in the COEP header.

In addition to these misconfigurations, we also observed several values with syntactical errors that the browser will not be able to parse and therefore will also revert to the default value for the header. These syntactical errors represent a minority of cases.

### Timing-Allow-Origin Wildcards

The [`Timing-Allow-Origin` (TAO)](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Timing-Allow-Origin) response header allows a server to specify a list of origins that can access values of attributes obtained through features of the [Resource Timing API](https://developer.mozilla.org/docs/Web/API/Performance_API/Resource_timing). Any origin listed in this header can thus access detailed timestamps relating to the connection to the server, such as the time at the start of the TCP connection, start of the request, and start of the response. Granting origins this access should be done with care, as this opens up the possibility for the listed origins to execute timing attacks or other cross-site attacks against the website.

In a case when CORS is configured, many of these types of timing values (including those listed above) are returned as 0 to prevent cross-origin leaks. By listing an origin in the `Timing-Allow-Origin` header, these values retain their original value and are no longer zeroed out.

{{ figure_markup(
  content="84%",
  caption="The percentage of `Timing-Allow-Origin` headers that are set to the wildcard (`*`) value.",
  classes="big-number",
  sheets_gid="788822751",
  sql_file="tao_header_prevalence.sql",
) }}

Besides returning a list of origins, developers can also set the `Timing-Allowed-Origin` header's value to the wildcard character `*` to indicate that any origin may access the timing information. We find that 84.6% of the TAO headers contain the wildcard `*` value, rising by 2% since [last year](../2024/security#timing-allow-origin-wildcards). This indicates that many developers have no problem with universally exposing finegrained timing information to any origin.

### Missing suppression of server information headers

When websites publish excessive information about their infrastructure, such as the server and specific version thereof, they may run a higher risk of being targeted by automatic vulnerability scanners. Hiding this information is a form of security by obscurity which is a tactic that is generally frowned upon because it does not address the core vulnerability of a system, however because it may aid in remaining under the radar of certain attacks we include an analysis.

We track the use of headers that are commonly used to report this type of information, namely: `Server`, `X-Server`, `X-Backend-Server`, `X-Powered-By`, and `X-Aspnet-Version`.

{{ figure_markup(
  image="server-headers.png",
  caption="Prevalence of headers used to convey information about the server.",
  description="Bar chart showing the adoption of various informational headers on mobile websites from 2023 to 2025. The `Server` header remains nearly universal, appearing on 91.52% of sites in 2025, while the `X-Powered-By` header is used by 23.99%. Other specialized headers like `X-Aspnet-Version`, `X-Server`, and `X-Backend-Server` show much lower usage, with all categories demonstrating a slight but consistent downward trend over the three-year period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=347972704&format=interactive",
  sheets_gid="374546324",
  sql_file="server_information_header_prevalence.sql"
  )
}}

Just like the past years, the `Server` header remains the most widely used header by a large margin over `X-Powered-By`. These headers show up on 91.5% and 23.9% of hosts on the web. For each of the headers we see a slight decrease in the amount of hosts they show up on. We don't expect these values to see major changes over time, as many web technologies automatically set some of these headers and developers may not have a lot of interest in removing these headers as the gains in terms of security are small.

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
        <td class="numeric">9.54%</td>
        <td class="numeric">9.98%</td>
      </tr>
      <tr>
        <td><code>PHP/7.3.33</code></td>
        <td class="numeric">3.61%</td>
        <td class="numeric">4.29%</td>
      </tr>
      <tr>
        <td><code>PHP/5.3.3</code></td>
        <td class="numeric">2.10%</td>
        <td class="numeric">2.20%</td>
      </tr>
      <tr>
        <td><code>PHP/5.6.40</code></td>
        <td class="numeric">2.07%</td>
        <td class="numeric">2.12%</td>
      </tr>
      <tr>
        <td><code>PHP/8.0.30</code></td>
        <td class="numeric">1.55%</td>
        <td class="numeric">1.70%</td>
      </tr>
      <tr>
        <td><code>PHP/7.2.34</code></td>
        <td class="numeric">1.34%</td>
        <td class="numeric">1.41%</td>
      </tr>
      <tr>
        <td><code>PHP/8.2.28</code></td>
        <td class="numeric">1.15%</td>
        <td class="numeric">1.31%</td>
      </tr>
      <tr>
        <td><code>PHP/8.3.13</code></td>
        <td class="numeric">1.08%</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.32</code></td>
        <td class="numeric">1.05%</td>
        <td class="numeric">1.09%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.27</code></td>
        <td class="numeric">0.92%</td>
        <td class="numeric">1.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Most prevalent `X-Powered-By` header values with specific framework version", sheets_gid="1997993812", sql_file="server_header_value_prevalence.sql") }}</figcaption>
</figure>

If we look at the most common values within the `Server` and `X-Powered-By` values, we see that PHP has the tendency to expose the exact version running on the server particularly in the `X-Powered-By` header. For both desktop and mobile, we find that over 27% of the `X-Powered-By` headers contain version information. It is likely that the header is automatically returned by the platforms that we observe in our data. Interestingly, we see a slight decrease in the old PHP versions 7.x and lower and a slight increase in the new PHP versions 8.x, which is an indication that at least some developers are updating their servers.

### Missing suppression of `Server-Timing` header

The `Server-Timing` HTTP header is a response header defined in a <a hreflang="en" href="https://w3c.github.io/server-timing/">W3C Editor's Draft</a> which can be used to communicate server performance metrics. Developers can send metrics containing zero or more properties. One of the specified properties is the `dur` property, which can be used to communicate millisecond-accurate timings that contain the duration of specific actions on the server.

{{ figure_markup(
  image="server-timing-header-usage.png",
  caption="The usage of the `Server-Timing` header.",
  description="Bar chart showing the prevalence of this performance-monitoring header across desktop and mobile platforms. The data shows that approximately 27 percent of desktop responses and 26 percent of mobile responses include the `Server-Timing` header. When measured by unique hosts rather than individual responses, the adoption rate is slightly lower, with 21 percent of desktop hosts and 22 percent of mobile hosts utilizing the feature.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1645983336&format=interactive",
  sheets_gid="963438395",
  sql_file="server_timing_usage_values.sql"
  )
}}

The percentage of hosts returning a `server-timing` header has increased by over 15% to being in use by over a fifth of hosts that have been visited by the crawler. This is a very steep increase since [last year](../2024/security#missing-suppression-of-server-timing-header).

{{ figure_markup(
  image="server-timing-header-dur-property.png",
  caption="The relative usage of `dur` properties in `Server-Timing` headers.",
  description="Bar chart showing the prevalence of specific duration metrics within the "Server-Timing" header across desktop and mobile platforms. The data indicates that a significant portion of these headers—43% on desktop and 42% on mobile—include at least one `dur` property. Furthermore, a substantial percentage of hosts (29% desktop, 27% mobile) expose more than two separate duration metrics.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2066582084&format=interactive",
  sql_file="server_timing_usage_values.sql"
  )
}}

Of the `server-timing` headers on the web, we find 42% of them have at least one `dur` property. This is a relative decrease compared to [last year](../2024/security#fig-53), but given the steep incline in header use over the year, the absolute number has risen. This also means that more headers do not include a `dur` property and use the header for other purposes, possibly through the use of the `desc` property that allows developers to set a description for certain metrics.

Because the information included in the `server-timing` header can be sensitive, access to the values is restricted to the same origin and to origins listed in the `Timing-Allow-Origin`. As we have shown above, many websites configure the `Timing-Allow-Origin` with a wildcard character, allowing all origins to access this potentially sensitive information. Even without cross-origin access, timing attacks can still be executed directly against servers exposing sensitive timing information outside of the browser context.

## Well-known URIs

Well-known URIs provide a standardized mechanism for designating specific locations for site-wide metadata and services. Defined by <a hreflang="en" href="https://www.rfc-editor.org/rfc/pdfrfc/rfc8615.txt.pdf">RFC 8615</a>, a well-known URI is identified by a path component that begins with the prefix `/.well-known/`. This allows clients to discover specific resources without needing prior knowledge about a site's URL scheme.

### `security.txt`

The well-known <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8615.txt">`security.txt`</a> file is a standardized file format that websites use to communicate vulnerability reporting information. White hat hackers and penetration testers can use this file to find contact details, PGP keys, policies, and other information for responsible disclosure.

{{ figure_markup(
  image="security-text-property-usage.png",
  caption="The usage of `security.txt` properties.",
  description="Bar chart showing the implementation of various fields within the `security.txt` file on desktop and mobile platforms. The data shows that the mandatory `contact` field is the most widely adopted property, appearing in 94% of files, while the other required field, `expires`, is present in approximately 75% of implementations. Other common optional fields include `preferred_language` at 72% and `hiring` at 37%, while more technical or administrative properties like `encryption` (9%), `signed` (2%), and `csaf` (0%) see significantly lower usage. Overall, adoption rates are nearly identical between desktop and mobile devices.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2020387408&format=interactive",
  sheets_gid="1421232798",
  sql_file="well-known_security.sql"
  )
}}

Adoption has increased to 1.82% of desktop and 1.72% of mobile websites, both up from [1% in 2024](./2024/security#securitytxt), showing growing recognition of standardized security disclosure practices.

Among sites implementing `security.txt`, contact information remains nearly universal at 95% (desktop) and 94% (mobile), up from 92% and 89% in 2024, respectively. Interestingly, 75% now define an expiry date, a significant jump from 51% for desktop and 48% for mobile websites in 2024. Preferred language is specified by 70-72% of implementations, while policy (which defines vulnerability reporting procedures) appears in only 37% desktop and 34% mobile files, down from 39% in 2024. However, the absolute number of `security.txt` files defining a policy has risen by two thirds.

This analysis shows that at least 25% of `security.txt` files are not fully valid, because including an expiry date along with contact information is required, as stipulated in <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9116.txt">RFC 9116</a>.

### `change-password`

The <a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/">`change-password` well-know URI</a> is a W3C specification draft from 2021, which has not been updated since. The purpose of the URI is for users and external resources to quickly find the correct location at which they can change their passwords for the specific site.

{{ figure_markup(
  image="change-password-usage.png",
  caption="The usage of the change-password .well-known endpoint.",
  description="Bar chart showing the percentage of websites that have implemented the standard `/.well-known/change-password` redirect on desktop and mobile platforms. The data reveals very low adoption rates for this feature, with only 0.30% of desktop sites and 0.27% of mobile sites currently utilizing the endpoint.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1701010385&format=interactive",
  sheets_gid="2031721186",
  sql_file="well-known_change-password.sql"
  )
}}

We see a very minor rise to 0.30% in desktop sites (up from 0.27%) and no change for the mobile endpoints, which remain at 0.27%. This slow adoption is not unexpected, especially taking into account that not all websites require authentication mechanisms.

### Detecting status code reliability

The <a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html">specification</a> draft to check on the reliability of a website's HTTP response status code also remains unchanged since 2021. The purpose of this specific well-known endpoint is that it should never exist and thus the response status code should never be an <a hreflang="en" href="https://fetch.spec.whatwg.org/#ok-status">ok status</a>. If a redirect occurs after which the site responds with an ok status, this would be considered as incorrect behavior.

{{ figure_markup(
  image="well-known-responses.png",
  caption="The distribution of statuses returned for the `.well-known` endpoint to assess status code reliability.",
  description="Stacked bar chart showing the success rate of requests to the standardized `.well-known` URI prefix used for consistent metadata discovery across web servers. The data shows that the overwhelming majority of these requests—83% on desktop and 82% on mobile—result in a \"not ok\" status, indicating that the intended resource could not be successfully retrieved or found. In contrast, successful 200 OK responses account for only about 10% of total requests, while status codes in the 201-299 range comprise an additional 8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1650502790&format=interactive",
  sheets_gid="182236208",
  sql_file="well-known_resource-not-be-200.sql"
  )
}}

We find similar results to [2022's](../2022/security#change-password) and [2024's](../2024/security#change-password) edition of the Web Almanac. However, the number of faulty ok status responses has grown slightly, from 84% in 2024 for both desktop and mobile pages to 83% and 84%, respectively. Web developers should continue to make their application use the correct status codes to respond to incoming requests in order to avoid that the status codes lose meaning.

### Sensitive endpoints in `robots.txt`

Finally, we check whether sensitive endpoints are disallowed to be visited by crawlers in the well-known `robots.txt` file. By checking the disallowed endpoints in this file, attackers may find pages to target. This year, 81% of desktop sites and 80% of mobiles sites hosted a `robots.txt` file, which is very similar to [last year's edition of the Web Almanac](../2024/security#sensitive-endpoints-in-robotstxt).

{{ figure_markup(
  image="robots-text-sensitive-endpoints.png",
  caption="The percentage of sites including specified endpoints in their `robots.txt`.",
  description="Bar chart showing the percentage of occurrences where potentially sensitive directories are blocked from web crawlers on desktop and mobile platforms. The data indicates that `admin` is the most frequently disallowed sensitive term, appearing in 4.29% of desktop `robots.txt` files, followed by `account` at 2.96%. Other terms such as `login` (1.73%) and `auth` (0.57%) are also commonly restricted, while `signin` and `sso` represent less than 0.05% of occurrences.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1097990890&format=interactive",
  sheets_gid="1854752678",
  sql_file="robot-txt_sensitive_disallow.sql"
  )
}}

Also the contents of those files remain very similar. The largest increase is recorded for the `auth` endpoint with 0.2% for desktop sites, while the largest decrease was recorded for the `login` endpoint with 0.2% for desktop sites.

## Conclusion

This security chapter shows positive trends in the adoption of web security policies. HTTPS is reaching near-100% adoption overall, and per-country metrics show every country is moving towards the goal of a universal use of HTTPS. We saw growing adoption of many modern security policies aiming to better protect users against modern attacks such as the `Content-Security-Policy` which saw an increase in use by over 18% and the `Permissions-Policy` which was used 50% more than last year. We also see newer policies like the Document Policy appear in the wild, showing that developers are actively working on adoption of new security features.

Despite these positive trends, developers must remain vigilant when adoption security mechanisms. Due to the growing complexity of the many available security mechanisms, we saw growth in the number of misconfigurations on the web. We saw that 0.1% of pages configure security policies in the `<meta>` HTML tag while this is not supported by browsers. Another problem is the confusion between related protections: 5% of values of the COEP header are invalid values that are only valid in the related CORP or COOP header. We also observe a form of developer fatigue where the least strict value of a protection is configured in order to make deployment more manageable or prevent potential problems, such as the wildcard value in the `Timing-Allow-Origin` header showing up in over 84% of these headers. Luckily, developers can easily mitigate these issues once they are aware of the problems.

New attacks in the future will inevitably drive the design of even more protection mechanisms to protect users worldwide. Policy makers will have to focus on reducing complexity in these new mechanisms to avoid developer confusion, but while the adoption of new security features takes time, we see relatively new policies being picked up and getting more adoption over time, thereby creating a more secure web for everyone.
