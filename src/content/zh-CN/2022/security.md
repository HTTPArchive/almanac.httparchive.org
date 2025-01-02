---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 安全
description: 2022年 Web 年鉴的安全章节，涵盖了传输层安全、内容包含（CSP、Feature Policy、SRI）、Web 防御机制（解决 XSS、XS-Leaks）以及安全机制采用的驱动因素。
hero_alt: Hero image of Web Almanac characters padlocking a web page, while other Web Almanac characters subdue a masked thief who has a set of bolt cutters.
authors: [SaptakS, lirantal, clarkio]
reviewers: [kushaldas, tunetheweb]
analysts: [VictorLeP, vikvanderlinden, GJFR]
editors: [tunetheweb]
translators: [Levix]
SaptakS_bio:  Saptak S 是一名以人权为中心的 Web 开发者，专注于 Web 开发中的可用性、安全性、隐私和无障碍性主题。他是各种不同开源项目的贡献者和维护者，如 <a hreflang="en" href="https://www.a11yproject.com">A11Y 项目</a>, <a hreflang="en" href="https://onionshare.org/">OnionShare</a> 和 <a hreflang="en" href="https://wagtail.org/">Wagtail</a>。你可以在 <a hreflang="en" href="https://saptaks.blog">saptaks.blog</a> 找到他的博客。
lirantal_bio: <a hreflang="en" href="https://www.lirantal.com/">Liran Tal</a> 因其开源和 JavaScript 安全倡议而闻名，并在 Node.js 安全方面的工作获得了OpenJS 基金会的安全探路者奖项，是国际公认的 <a hreflang="en" href="https://stars.github.com/profiles/lirantal/">GitHub Star</a>，他是 JavaScript 社区获奖的软件开发人员、安全研究员和开源倡导者。他对开发者安全教育的贡献包括领导 OWASP 项目，建立供应链安全工具，参与 CNCF 和 OpenSSF 计划，并撰写了 O'Reilly 的 《Serverless Security》 等书籍，他领导着 Snyk.io 开发者宣传团队，并以赋予开发者更好的应用安全技能为使命。
clarkio_bio: Brian 是一位在应用安全方面有深入经验的 Web 开发者，通过在 Snyk.io 担任开发者大使的工作，帮助开发者构建安全的 Web 应用。虽然他有全栈项目的工作经验，但他的重点是后端服务、API 和开发者工具。Brian 喜欢向开发人员传授他从整个职业生涯的成功和失败中学到的东西。你可以在他<a hreflang="en" href="https://clarkio.live">每周的直播</a>中或在他的 <a hreflang="en" href="https://www.pluralsight.com/authors/brian-clark">Pluralsight 课程</a>中找到他正在做的事情。
results: https://docs.google.com/spreadsheets/d/1cwJ43NL2IN2PxJa5oiOoJCRkSh566XE_k9uHnGJdWeg/
featured_quote: 人们的个人信息以及生活的各个方面每天都在变得越来越数字化，这使得安全和隐私变得极为重要，网站有责任采用最佳的安全实践来确保其用户隐私受到保护。
featured_stat_1: +14%
featured_stat_label_1: 内容安全策略（CSP）的采用率增加
featured_stat_2: 428
featured_stat_label_2: 使用 `Clear-Site-Data` 标头的网站
featured_stat_3: +85%
featured_stat_label_3: 权限策略（Permissions Policy）的采用率增加
---

## 介绍

随着人们的个人信息越来越数字化，安全和隐私在互联网上变得极其重要，网站所有者有责任确保他们从用户那里获取数据的安全性。因此，必须采用所有的安全最佳实践，以确保用户免受恶意软件利用漏洞获取敏感信息的影响。

与[往年](../2021/security)一样，我们分析了 Web 社区对安全方法和最佳实践的采用和使用情况。我们分析了与每个网站应该采取的最基本安全措施有关的指标，如[传输安全](#传输安全（transport-security）)和[适当的 cookie 管理](#cookies)。我们还讨论了与采用不同安全头（security headers）有关的数据，以及它们如何帮助 [content inclusion](#内容包含（content-inclusion）) 和[防止各种恶意攻击](#预防攻击)。 <!-- markdownlint-disable-line MD051 -->

我们研究了[安全措施的采用](#采用安全机制的驱动因素)与地点、技术栈和网站受欢迎程度的相关性，我们希望通过这种相关性鼓励所有的技术栈在默认情况下采取更好的安全措施。我们还讨论了一些 [well-known URIs](#well-known-uris)，它们有助于基于 Web 应用程序安全工作组的标准和草案进行漏洞披露和其他与安全相关的设置。

## 传输安全（Transport security）

传输层安全保证用户与网站之间的数据和资源的安全通信，[HTTPS](https://developer.mozilla.org/docs/Glossary/https) 使用 <a hreflang="en" href="https://www.cloudflare.com/en-gb/learning/ssl/transport-layer-security-tls/">TLS</a> 来加密客户端和服务器之间的所有通信。

{{ figure_markup(
  content="94%",
  caption="桌面端使用 HTTPS 的请求占比",
  classes="big-number",
  sheets_gid="1093490384",
  sql_file="https_request_over_time.sql",
) }}

桌面端 94% 的请求和移动端 93% 的请求都是通过 HTTPS 发送的，所有主流浏览器现在都有一个 <a hreflang="en" href="https://support.mozilla.org/en-US/kb/https-only-prefs">HTTPS-only 模式</a>，如果一个网站使用 HTTP 而非 HTTPS，则会显示警告。

{{ figure_markup(
  image="https-usage-by-site.png",
  caption="网站的 HTTPS 使用率",
  description="条形图显示 89% 的桌面端站点使用 HTTPS，剩下的 11% 使用 HTTP，而 85% 的移动端站点使用 HTTPS，剩下的 15% 使用 HTTP。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1343950152&format=interactive",
  sheets_gid="1806760937",
  sql_file="home_page_https_usage.sql"
  )
}}

与总请求（接口）相比，通过 HTTPS 提供服务的主页比例仍然较低，因为很多对网站的请求都是由[第三方](./third-parties)服务主导的，如字体、CDN 等，这些服务 的 HTTPS 采用率较高。我们看到这个百分比确实比去年略有上升，现在 89.3% 的主页面在桌面端通过 HTTPS 提供服务，而去年这一比例为 84.3%。同样在我们的移动数据统计中 85.5% 的主页面通过 HTTPS 提供服务，而去年为81.2%。

### 协议版本

重要的是，不仅要使用 HTTPS，而且要使用最新的 TLS 版本，<a hreflang="en" href="https://datatracker.ietf.org/doc/rfc8996/">TLS 工作组</a>已经废弃了 TLS v1.0 和 v1.1，因为它们存在多个缺陷。自从去年的章节以来，Firefox <a hreflang="en" href="https://support.mozilla.org/en-US/kb/secure-connection-failed-firefox-did-not-connect#w_tls-version-unsupported">现在已经更新了它的用户界面</a>，在 Firefox 97 版的错误页面中，启用 TLS 1.0 和 1.1 的选项已经被删除。Chrome 也从 98 版本开始<a hreflang="en" href="https://chromestatus.com/feature/5759116003770368">不再允许绕过</a> TLS 1.0 和 1.1 所显示的错误页面。

IETF 于 2018 年 8 月发布的 TLS v1.3 是最新版本，相较于 TLS v1.2 版本它<a hreflang="en" href="https://www.cloudflare.com/en-in/learning/ssl/why-use-tls-1.3/">更快而且更安全</a>，TLS v1.2 中的许多主要漏洞都与旧加密算法有关，而 TLS v1.3 删除了这些算法。

{{ figure_markup(
  image="tls-version-by-site.png",
  caption="网站的 TLS 版本使用分布",
  description="条形图显示桌面端 67% 的站点采用 TLSv1.3, 33% 的站点采用 TLSv1.2 版本。在移动端上，这一数字分别为 70% 和 30%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1390978067&format=interactive",
  sheets_gid="1385583211",
  sql_file="tls_versions_pages.sql"
  )
}}

在上图中，我们看到 70% 的移动网页和 67% 的桌面网页是通过 TLSv1.3 提供的，这比去年增加了约 7%。因此，我们看到一些从使用 TLS v1.2 到 TLS v1.3 的持续转变。

### 密码套件（Cipher suites）

<a hreflang="en" href="https://learn.microsoft.com/en-au/windows/win32/secauthn/cipher-suites-in-schannel">密码套件</a>是一组加密算法，客户和服务器在开始使用 TLS 进行安全通信之前必须达成一致。

{{ figure_markup(
  image="distribution-of-cipher-suites.png",
  caption="密码套件的分布",
  description="条形图显示了各设备使用的密码套件，`AES_128_GCM` 是最常见的，被 79% 的桌面端网站和 79% 的移动端网站使用，`AES_256_GCM` 被 19% 的桌面端网站和 18% 的移动端网站使用，`AES_256_CBC` 被 2% 的桌面端网站和 1% 的移动端网站使用，`CHACHA20_POLY1305` 分别被 1% 和 1% 的网站使用，`AES_128_CBC` 分别被 0% 和 0% 使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1789949340&format=interactive",
  sheets_gid="711514835",
  sql_file="tls_cipher_suite.sql"
  )
}}

现代 [Galois/Counter Mode (GCM)](https://en.wikipedia.org/wiki/Galois/Counter_Mode) 密码模式被认为是更安全的，因为它们不容易受到<a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">填充攻击（padding attacks）</a>。TLS v1.3 <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">只支持 GCM 和其他现代分组密码模式</a>，使其更加安全，它还消除了<a hreflang="en" href="https://go.dev/blog/tls-cipher-suites">密码套件排序</a>的麻烦。决定密码套件使用情况的另一个因素是用于加密和解密的密钥大小，我们看到 128 位的密钥仍然被广泛使用，因此，我们看到与去年的图表对比没有什么不同，`AES_128_GCM` 仍然是使用最多的密码套件，使用率为 79%。

{{ figure_markup(
  image="forward-secrecy-support.png",
  caption="前向保密（Forward secrecy）的使用情况",
  description="条形图显示，97% 的移动端和桌面端请求都使用了前向保密。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=298331860&format=interactive",
  sheets_gid="1454804483",
  sql_file="tls_forward_secrecy.sql"
  )
}}

TLS v1.3还强制要求[前向保密](https://en.wikipedia.org/wiki/Forward_secrecy)，我们看到 97% 的移动和桌面端请求都使用了它。

### 证书颁发机构（CA 认证）

<a hreflang="en" href="https://www.ssl.com/faqs/what-is-a-certificate-authority/">认证机构</a>或 CA 是一个公司或组织，它向网站颁发可被浏览器识别的 TLS 证书，然后与网站建立一个安全的通信通道。

<figure>
  <table>
    <thead>
      <tr>
        <th>发行机构</th>
        <th>桌面端</th>
        <th>移动端</th>
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
        <td>DigiCert SHA2 Secure Server CA</td>
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
  <figcaption>{{ figure_link(caption="十大证书颁发机构", sheets_gid="1306037372", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

<a hreflang="en" href="https://letsencrypt.org/">Let's Encrypt</a>（或 R3）继续领先，48% 的桌面端网站和 52% 的移动端网站使用他们颁发的证书，Let's Encrypt 作为一个非营利性组织在采用HTTPS 方面发挥了重要作用，他们继续发放<a hreflang="en" href="https://letsencrypt.org/stats/#daily-issuance">越来越多的证书</a>。我们还想花一点时间来纪念它的创始人之一 —— <a hreflang="en" href="https://community.letsencrypt.org/t/peter-eckersley-may-his-memory-be-a-blessing/183854">Peter Eckersly</a>，他最近不幸去世了。

<a hreflang="en" href="https://developers.cloudflare.com/ssl/ssl-tls/certificate-authorities/">Cloudflare</a> 以其为客户提供类似的免费证书而继续处于第二位，Cloudflare CDNs 增加了<a hreflang="en" href="https://www.digicert.com/faq/ecc.htm">椭圆曲线加密法（ECC）</a>证书的使用，该证书比 RSA 证书更小、更有效，但由于需要继续向老客户端提供非 ECC 证书，因此比较难部署。我们看到，随着 Let's Encrypt 和 Cloudflare 的比例不断增加，其他 CA 的使用比例正在一点点减少。

### HTTP 严格传输安全（HSTS）

[HTTP 严格传输安全（HSTS）](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security)是一个标头，它通知浏览器自动将所有使用 HTTP 访问网站的尝试转换为 HTTPS 请求。

{{ figure_markup(
  content="25%",
  caption="具有 HSTS 头的移动端请求",
  classes="big-number",
  sheets_gid="822440544",
  sql_file="hsts_attributes.sql",
) }}

25% 的移动端响应和 28% 的桌面响应携带 HSTS 头。

HSTS 是使用 `Strict-Transport-Security` 请求头来设置的，它可以有三种不同的指令：`max-age`、`includeSubDomains` 和 `preload`。 `max-age` 表示浏览器应该记住只使用 HTTPS 访问网站的时间，以秒为单位，是该请求头的一个强制性指令。

{{ figure_markup(
  image="hsts-directives-usage.png",
  caption="不同 HSTS 指令的使用情况",
  description="不同 HSTS 指令使用情况百分比柱状图。19% 的网站在移动和桌面端都使用了 `preload`，`includeSubdomain` 在 37% 的桌面网站和 34% 的移动网站中被使用，6% 的桌面端网站和 5% 的移动端网站使用了 max-age 为 0，94% 的桌面网站和 95% 的移动网站设置了有效的 `max-age`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=683864207&format=interactive",
  sheets_gid="822440544",
  sql_file="hsts_attributes.sql"
) }}

我们看到 94% 的桌面端站点和 95% 的移动端站点都设置了一个非零、非空的 `max-age`。

34% 的移动端请求响应，37%的桌面端请求响应在 HSTS 设置中包含了 `includeSubdomain`，而带有 `preload` 指令的响应数量较少，该指令[不属于 HSTS 标准中的一部分](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security)，它需要设置最小的 `max-age` 为 31,536,000 秒（或1年），且 `includeSubdomain` 指令也要同时存在。

{{ figure_markup(
  image="hsts-max-age-values-in-days.png",
  caption="所有请求的 HSTS `max-age` 值（以天为单位）",
  description="`max-age` 属性中数值的百分比柱状图，转换为天数。在第 10 个百分点中，桌面端是 30 天，移动端是 73 天；在第 25 个百分点中，两者都是 180 天；在第 50 个百分点中，两者都是 365 天；第 75 个百分点中，两者都是 365 天；第 90 个百分点中，两者都是 730 天。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=154290094&format=interactive",
  sheets_gid="1179482269",
  sql_file="hsts_max_age_percentiles.sql"
) }}

在所有请求中，HSTS 请求头中 `max-age` 属性的中间值是 365 天，在移动和桌面端上都是如此。https://hstspreload.org/ 认为一旦 HSTS 头被正确设置并被验证不会引起任何问题，建议设置 `max-age` 为 2 年。

## Cookies

[HTTP cookie](https://developer.mozilla.org/docs/Web/HTTP/Cookies) 是服务器发送给浏览器关于用户的一组数据，cookie 可用于会话管理、个性化、跟踪和其他与用户在不同请求中的状态信息。

如果 cookie 设置不当，可能容易遭受许多不同形式的攻击，例如<a hreflang="en" href="https://owasp.org/www-community/attacks/Session_hijacking_attack">会话劫持</a>、<a hreflang="en" href="https://owasp.org/www-community/attacks/csrf">跨站请求伪造（CSRF）</a>、<a hreflang="en" href="https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/11-Client_Side_Testing/13-Testing_for_Cross_Site_Script_Inclusion">跨站脚本包含（XSSI）</a>和其他各种<a hreflang="en" href="https://xsleaks.dev/">跨站泄漏</a>漏洞。

### Cookie 属性

为了防御上述威胁，开发人员可以在 cookie 中使用 3 个不同的属性：`HttpOnly`、`Secure` 和 `SameSite`。`Secure` 属性类似于 `HSTS` 标头，因为它也确保 cookie 必须通过 HTTPS 发送，防止<a hreflang="en" href="https://owasp.org/www-community/attacks/Manipulator-in-the-middle_attack">中间人攻击</a>。`HttpOnly` 确保 cookie 不能被任何 JavaScript 代码访问，防止<a hreflang="en" href="https://owasp.org/www-community/attacks/xss/">跨站脚本</a>攻击。

{{ figure_markup(
  image="httponly-secure-samesite-cookie-usage.png",
  caption="Cookie 属性 (桌面端)",
  description="桌面端网站上使用 cookie 属性柱状图，按第一方和第三方 cookie 划分。第一方 cookie 使用 `HttpOnly` 的比例为 36%，`Secure` 的比例为 37%，`SameSite` 的比例为 45%，而第三方 cookie 使用`HttpOnly` 的比例为 21%，`Secure` 的比例为 90%，`SameSite` 的比例为 88%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=528777115&format=interactive",
  sheets_gid="168091712",
  sql_file="cookie_attributes.sql"
) }}

存在 2 种不同的 cookies：第一方（first-party）和第三方（third-party）。第一方 cookie 通常由你正在访问的直接服务器设置，而第三方 cookie 是由第三方服务创建的，通常用于跟踪和广告服务。桌面端 37% 的第一方 cookie 设置了 `Secure` 字段，36% 设置了 `HttpOnly` 字段，然而，在第三方 cookie 中，我们看到 90% 的 cookie 设置了 `Secure`，21% 设置了 `HttpOnly`。在第三方 cookie 中，`HttpOnly` 的比例较小，因为他们大多数希望允许通过 JavaScript 代码访问它们（跟踪和广告服务）。

{{ figure_markup(
  image="samesite-cookie-attributes.png",
  caption="同站（Same site） cookie 属性",
  description="按第一方和第三方划分的 SameSite cookie 属性条形图。对于第一方来说，61% 的用户使用 `SameSite=lax`，2% 的用户使用 `SameSite=strict`，37% 的用户使用 `SameSite=none`，而对于第三方来说，1% 的用户使用 `SameSite=lax`，1% 的用户使用 `SameSite=strict`，98% 的用户使用 `SameSite=none`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1714102327&format=interactive",
  sheets_gid="168091712",
  sql_file="cookie_attributes.sql"
) }}

`SameSite` 属性可用于防止 CSRF 攻击，它告诉浏览器是否向跨站点请求发送 cookie。`Strict` 属性值只允许将 cookie 发送到它的来源网站，而 `Lax` 值只允许在用户通过链接导航到来源网站时将 cookie 发送到跨网站请求。对于 `None` 值，cookie 将被发送到源站点和跨站点的请求。如果 `SameSite=None` 被设置，cookie 的 `Secure` 属性也必须被设置（否则 cookie 将被阻止）。我们看到 61% 的第一方 cookie 的 `SameSite` 属性值设置为 `Lax`。如果 cookie 没有设置 `SameSite` 属性，大多数浏览器默认设置为 `SameSite=Lax`，因此我们看到它继续在图表中占主导地位。在第三方cookie中，`SameSite=None` 仍然是超高的，在桌面端上有 98% 的 cookie 设置了它，因为第三方 cookie 确实想在跨站请求中发送。

### Cookie age

有两种不同的方式来设置 cookie 的过期时间：`Max-Age` 和 `Expires`。`Expires` 使用一个特定的日期（相对于客户端而言）来决定何时删除 cookie，而 `Max-Age` 使用一个以秒为单位的持续时间。

{{ figure_markup(
  image="cookie-age-usage-by-site-in-desktop-in-days.png",
  caption="Cookie age 的使用，以天为单位（桌面端）",
  description="柱状图显示了在不同百分位数上使用 cookie age 的情况。在第 10 个百分位数，`Max-Age` 为 1，`Expires` 为10，实际最大 age 为 7。在第 25 百分位，`Max-Age` 和`Expires` 的值分别为 90 天和 60 天，实际的 age 值是 60 天。在第 50 百分位，`Max-Age`、`Expires` 和真实 age 值为 365 天。在第 75 百分位，`Max-Age`、`Expires` 和真实 age 值为 365 天。在第 90 个百分位数中，`Max-Age`、`Expires` 和实际 age 值为 730 天。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=2015811517&format=interactive",
  sheets_gid="1811539513",
  sql_file="cookie_age_percentiles.sql"
  )
}}

与去年不同的是，去年 `Max-Age` 的中位数是 365 天，而 `Expires` 的中位数是 180 天，今年两者都设置在 365 天左右。因此，今年实际 `Max-Age` 的中位数已经从 180 天上升到 365 天，即使 90% 设置了 `Max-Age` 为 729 天，`Expires` 为 730 天。Chrome 浏览器一直计划将 `Max-Age` 和 `Expires` 的上限设定为 400 天。

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
      caption="桌面端最常见的 cookie 过期值",
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
      caption="移动端最常见的 cookie 过期值",
      sheets_gid="707972861",
      sql_file="cookie_max_age_expires_top_values.sql",
    ) }}
  </figcaption>
</figure>

最普遍的 `Expires` 有一些有趣的值。我们看到，在桌面端使用最多的 `Expires` 值是 `January 1, 1970 00:00:00 GMT`，当 cookies 的 `Expires` 值被设置为过去的日期时，它们会被从浏览器中删除。1970 年 1 月 1 日 00:00:00 GMT 是 Unix 纪元时间，因此它经常被用于设置过期时间或删除一个 cookie。

## 内容包含（Content inclusion）

一个网站内容通常有很多形式，需要 CSS、JavaScript 或其他媒体资源（如字体和图片）等资源，这些资源经常从外部服务提供商那里加载，如云原生基础设施的远程存储服务，或从内容交付网络（CDNs）加载，目的是为了减少全球范围内的网络往返延迟，以提供内容。

然而，确保我们在网站上的内容没有被篡改是非常关键的，其影响可能是毁灭性的，随着人们对供应链安全意识的提高，Content inclusion 变得更加重要，<a hreflang="en" href="https://www.imperva.com/learn/application-security/magecart/">Magecart</a> 攻击的事件越来越多，针对网站内容系统，该攻击针对网站内容系统，通过跨站脚本（XSS）漏洞和其它手段注入持久性恶意软件。

### 内容安全策略（Content Security Policy，简称 CSP）

你可以部署一套有效措施来降低围绕内容包含（Content inclusion）的安全风险，即采用内容安全策略（CSP），它是一种安全标准，添加了一个深度防御层，以减轻通过跨站脚本编写代码注入或点击劫持等攻击。

它的工作原理是确保预先定义的受信任内容规则集得到维护，并拒绝任何绕过或包括受限制内容的尝试。例如，内容安全策略允许 JavaScript 代码仅在其提供的同源站点和 Google Analytics 的浏览器中运行，该策略将被定义为 `script-src 'self' www.google-analytics.com;`。任何跨站脚本注入的尝试，如 `<a img=x onError=alert(1)>`，都会被执行设定策略（CSP）的浏览器拒绝。

{{ figure_markup(
  caption="相比于 2021 年，内容安全策略标头的采用率相对增加",
  content="+14%",
  classes="big-number",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql"
)
}}

我们看到，从 2021 年 12.8% 的数据到 2022 年 14.6% 的数据，这表明在开发人员和 web 安全社区中采用 `Content-Security-Policy` 标头的趋势在不断增长，这是积极的，尽管使用这种更高级功能的网站仍然是少数。

当 CSP 被用于 HTML 响应本身时，它是最有用的。在这里，我们看到使用 CSP 标头的移动端请求使用率持续增长，两年前为 7.2%，去年为 9.3%，今年为 11.2%。

{{ figure_markup(
  image="csp-directives-usage.png",
  caption="CSP中最常用的指令",
  description="条形图显示了最常见的 CSP 指令使用情况。`upgrade-insecure-requests` 是最常见的，在桌面端占 54%，在移动端占 56%；其次是 `frame-ancestors`，在桌面端占54%，在移动端占 53%；`block-all-mixed-content` 在桌面端占 26%，在移动端占 38%；`default-src` 在桌面端占 19%，在移动端占 16%；`script-src` 在桌面端占 17%，在移动端占 15%；`style-src` 在桌面端占 14%，在移动端占 12%；`img-src` 在桌面端占 13%，在移动端占 11%；`font-src` 在桌面端占 11%，在移动端占 9%，`connect-src` 在桌面端占 10%，在移动端占 8%，`frame-src` 在桌面端占 10%，在移动端占 7%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=417279434&format=interactive",
  sheets_gid="1303493233",
  sql_file="csp_directives_usage.sql"
  )
}}

我们看到，在桌面端和移动端的 HTTP 请求中，排在前三位的 CSP 指令是 `upgrade-insecure-requests`（占 54%）、`frame-ancestors`（占 54%）、`block-all-mixed-content`（占 27%）策略，排名靠后的策略有 `default-src`、`script-src`、`style-src` 和 `img-src` 等等。

`upgrade-insecure-requests` 策略的高采用率也许归功于 TLS 请求作为业界标准（de-facto standard）的高采用率。然而，尽管 `block-all-mixed-content` 被认为已经过时，但它的采用率依旧很高，这也许说明了 CSP 规范的发展速度之快，用户很难跟上时代的步伐。

在减少跨站脚本攻击方面，谷歌针对[Trusted Types](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy/trusted-types)的安全倡议做得更多，它需要本地浏览器 API 支持，以帮助防止 DOM 注入类漏洞，它是由谷歌工程师积极倡导的，但仍处于 W3C 的<a hreflang="en" href="https://w3c.github.io/trusted-types/dist/spec/">建议草案阶段</a>，尽管如此，我们将其 CSP 相关的安全头 `require-trusted-types-for` 和 `trusted-types` 记录在 0.1% 的请求中，这并不多，但也许说明采用这种方法的趋势正在增长。

为了评估是否发生了违反预先定义规则集的 CSP 行为，网站可以设置 `report-uri` 指令，让浏览器将 JSON 格式数据作为 HTTP POST 请求发送。尽管 `report-uri` 请求占所有带有 CSP 标头桌面流量的 4.3%，但到目前为止，它已被废弃，被 `report-to` 取代，它占桌面请求的 1.8%。

实施严格的内容安全策略的最大挑战之一是内联 JavaScript 代码的存在，这些代码通常被设置为事件处理程序或在 DOM 的其他部分。为了允许团队逐步采用 CSP 安全标准，策略可以将 `unsafe-inline` 或 `unsafe-eval` 作为其 `script-src` 指令的关键值，这样做，不能防止一些跨站脚本攻击载体，并且对策略的预防措施产生反作用。

团队可以通过使用 nonce 或 SHA256 哈希对内联 JavaScript 代码进行签名，从而使其更安全。看起来就像这样：

```
Content-Security-Policy: script-src 'nonce-4891cc7b20c'
```

然后在HTML中引用它：

```html
<script nonce="nonce-4891cc7b20c">
  …
</script>
```

{{ figure_markup(
  image="csp-script-src-attribute-usage.png",
  caption="CSP `script-src` 属性的使用情况",
  description="柱状图显示了在 CSP `script-src` 指令中 nonce、`unsafe-inline` 和 `unsafe-eval` 的使用情况。`nonce-` 被用于 12% 带有 CSP 标头的移动网站和 14% 的桌面网站；`unsafe-inline` 在移动端有 94% 的网站使用，在桌面端有 95%；`unsafe-eval` 在这类网站中的使用，移动端占 80%，桌面端占 78%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=310998764&format=interactive",
  sheets_gid="323360740",
  sql_file="csp_script_source_list_keywords.sql"
  )
}}

对所有桌面端 HTTP 请求进行的统计显示，94% 的（页面）设置了 `unsafe-inline`，80% 的（页面） `script-src` 值设置为 `unsafe-eval`，这表明在锁定网站的应用代码以避免内联 JavaScript 代码方面存在真正的挑战。此外，只有 14% 的上述请求采用了 `nonce-` 指令，这有助于确保不安全的内联 JavaScript 代码的使用。

我们观察到 CSP 标头长度的统计数据也许说明了定义内容安全策略的高度复杂性。

{{ figure_markup(
  image="csp-header-length.png",
  caption="CSP 标头长度",
  description="柱状图显示了以字节为单位的 CSP 标头长度百分比数据。在第 10 个百分点，桌面端和移动端都是 22 个字节，在第 25 个百分点，都是 25 个字节，在第 50 个百分点，桌面端是 64 个字节，移动端是 70 个字节，在第 75 个百分点都是 75 个字节，在第 90 个百分点，桌面端是 494 个字节，移动端是 334 个字节。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=311379301&format=interactive",
  sheets_gid="54898794",
  sql_file="csp_number_of_allowed_hosts.sql"
) }}

在中位数的排名中，50% 的桌面端请求中大小只达到 70 个字节，这比去年的数据略有下降，去年的报告显示桌面端和移动端请求的大小都是 75 个字节。90% 以上的请求从去年的 389 个字节增长到了今年的 494 个字节，这表明朝着更加复杂和完整的安全策略方向取得了微小的进展。

观察内容安全策略的完整定义，我们可以看到单个指令仍然占所有请求的很大比例。19% 的桌面端请求被设置为 `upgrade-insecure-requests`，8% 的桌面端请求被设置为 `frame-ancestors 'self'`，23% 的桌面端请求被设置为 `block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;`，它混合了最常见的 3 个 CSP 指令。

内容安全策略通常必须允许来自其他源的内容，而不是自己的内容，以支持加载媒体，如字体、广告相关脚本和一般内容交付网络的使用，因此，整个请求的前 10 个来源如下：

<figure>
  <table>
    <thead>
      <tr>
        <th>Origin</th>
        <th>桌面端</th>
        <th>移动端</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>https://www.google-analytics.com</td>
        <td class="numeric">0.39%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td>https://www.googletagmanager.com</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.25%</td>
      </tr>
      <tr>
        <td>https://fonts.gstatic.com</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td>https://fonts.googleapis.com</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.18%</td>
      </tr>
      <tr>
        <td>https://www.google.com</td>
        <td class="numeric">0.24%</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td>https://www.youtube.com</td>
        <td class="numeric">0.21%</td>
        <td class="numeric">0.15%</td>
      </tr>
      <tr>
        <td>https://stats.g.doubleclick.net</td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>https://connect.facebook.net</td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>https://www.gstatic.com</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>https://cdnjs.cloudflare.com</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.11%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="CSP 策略中最常被允许的提供商",
      sheets_gid="106248959",
      sql_file="csp_allowed_host_frequency.sql"
    ) }}
  </figcaption>
</figure>

上述提供商的排名与去年报告的大致相同，但使用量略有上升。

CSP 安全标准得到了 Web 浏览器以及内容传输网络和内容管理系统的广泛支持，是网站和 web 应用防御 web 安全漏洞的一个强烈推荐工具。

### 子资源完整性（Subresource Integrity，简称 SRI）

另一个深度防御工具是子资源完整性，它提供了一个 Web 安全防御层，防止内容被篡改，内容安全策略定义了允许的内容类型和来源，而子资源完整性机制确保上述内容没有被恶意修改。

使用子资源完整性的一个参考用例是当从第三方包管理器加载 JavaScript 内容时，第三方包管理器也充当 CDN，例如 unpkg.com 或 cdnjs.com，它们都为 JavaScript 库的内容资源提供服务。

如果第三方库可能因为 CDN 提供商的托管问题，或项目贡献者或维护者的问题而被破坏，那么你实际上是在把别人的代码加载到你的网站上。

与 CSP 使用 `nonce-` 类似，子资源完整性（也称为 SRI）允许浏览器验证所提供的内容是否与加密签名的哈希值相符，并防止内容被篡改，无论是通过网络还是在其源头。

{{ figure_markup(
  content="20%",
  caption="使用 SRI 的桌面站点",
  classes="big-number",
  sheets_gid="953586778",
  sql_file="sri_usage.sql",
) }}

大约每 5 个网站中就有一个（20%）在桌面端网页元素中设置了子资源完整性，其中，83% 专门用于桌面端的 `<script>` 类型元素，17% 用于桌面端请求中的 `<link>` 类型元素。

从每页的覆盖率来看，SRI 安全功特性的采用率仍然相当低，去年，移动端和桌面端的平均比例为 3.3%，今年下降了 2%，为 3.23%。

子资源完整性被指定采用 SHA256、SHA384 或 SHA512 中的其中一种加密函数来计算其哈希值的 base64 字符串，作为[用例参考](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity)，开发者可以按照以下方式实现它们：

```html
<script src="https://example.com/example-framework.js"
  integrity="sha384-oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
        crossorigin="anonymous"></script>
```

{{ figure_markup(
  image="sri-hash-function-usage.png",
  caption="SRI 哈希函数",
  description="条形图显示使用各种哈希函数的 SRI 元素百分比。桌面端网站中 58.4% 的 SRI 元素和移动端网站中 60.7% 的 SRI 元素使用了 SHA-384；桌面端网站中 32.4% 的 SRI 元素和移动端网站中 30.8% 的 SRI 元素使用了 SHA-256；桌面端网站中 10.9% 的 SRI 元素和移动端网站中 9.9% 的 SRI 元素使用了 SHA-512。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=699960446&format=interactive",
  sheets_gid="1419400151",
  sql_file="sri_hash_functions.sql"
) }}

与去年的报告一致，SHA384 继续展示了在所有可用的哈希函数中被使用最多的 SRI 哈希类型。

CDNs 对子资源完整性并不陌生，通过在页面内容的 URL 引用中包含子资源完整性值，向其调用者提供安全的默认值。

<figure>
  <table>
    <thead>
      <tr>
        <th>Host</th>
        <th>桌面端</th>
        <th>移动端</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>www.gstatic.com</td>
        <td class="numeric">39%</td>
        <td class="numeric">40%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">22%</td>
        <td class="numeric">23%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">8%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>code.jquery.com</td>
        <td class="numeric">7%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>static.cloudflareinsights.com</td>
        <td class="numeric">5%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>t1.daumcdn.net</td>
        <td class="numeric">3%</td>
        <td class="numeric">1%</td>
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
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="包括 SRI 保护脚本的大多数常见提供商", sheets_gid="998292064", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

上述列表显示了已观察到子资源完整性值的前 10 个最常见的提供商，与去年相比，值得注意的变化是 Cloudflare 提供商从第 4 位跃升至第 3 位，jsDelivr 的排名从第 7 位跳到第 6 位，超过了 Bootstrap 提供商排名。

### 权限策略（Permissions Policy）

随着时间的推移，浏览器变得越来越强大，添加了更多的原生 API 来访问和控制不同种类的硬件和网站提供的功能集。通过滥用上述功能，也会给用户带来潜在的安全风险，例如恶意脚本打开麦克风并收集数据，或通过指纹识别设备的地理位置来收集位置信息。

以前被称为 `Feature-Policy`，现在被命名为 `Permissions-Policy`，这是一个实验性的浏览器 API，能够控制浏览器访问一系列功能的白名单列表和黑名单列表。

我们注意到 `Permissions-Policy` 的使用与启用 HTTPS 连接（97%）、`X-Content-Type-Options`（82%）以及 `X-Frame-Options`（78%）高度相关，所有的相关性都是跨桌面端请求。另一个高相关性是在特定的技术交叉点，观察到的是 Google My Business 移动端页面（99%），其次是 Acquia 的云平台（67%）。所有的相关性都是跨移动端请求。

{{ figure_markup(
  caption="从2021年开始， `Permissions-Policy` 的采用率相对增加",
  content="+85%",
  classes="big-number",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql"
)
}}

我们看到，从 2021 年的数据（1.3%）到 2022 年的数据（2.4%），移动端请求对 `Permissions-Policy` 的采用率相对增加了 85%，桌面端请求也有类似的趋势。被废弃的 `Feature-Policy` 在去年和今年的数据之间出现了 1% 的微弱增长，这表明用户正在跟上 Web 浏览器规范的变化。

除了作为 HTTP 标头之外，该特性还可以在 `<iframe>` 元素中使用，如下所示：

```html
  <iframe src="https://example.com" allow="geolocation 'src' https://example.com'; camera *"></iframe>
```

在移动端的 1740 万个框架中，有 12.6% 包含 `allow` 属性，以启用权限或特性策略。

<aside class="note">本章的早期版本报告了总帧数和具有 `allow` 属性的帧百分比的错误值。更多信息可在此 <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/3912">GitHub PR</a> 中找到。</aside>

以下是在框架中检测到的前 10 条 `allow` 指令列表：

<figure>
  <table>
    <thead>
      <tr>
        <th>指令</th>
        <th>桌面端</th>
        <th>移动端</th>
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
      caption="iframes 上 `allow` 指令的普遍性",
      sheets_gid="1848560369",
      sql_file="iframe_allow_directives.sql"
    ) }}
  </figcaption>
</figure>

有趣的是，第 11、12 和 13 位的移动端指令没有进入到上述名单，它们是 `vr`（占 6%），`payment`（占 2%），`web-share`（占 1%），它们也许说明了我们在虚拟现实（以及元宇宙，如果你愿意的话）、在线支付和金融科技行业中看到的日益增长的趋势。最后，这似乎表明了基于 web 共享得到了更好的支持，这可能是由于过去几年在家办公（指新冠疫情期间）的兴起。

### Iframe 沙盒（Iframe Sandbox）

在网站中使用 iframe 元素是开发人员长期以来的做法，以便轻松嵌入第三方内容，如富媒体、跨应用组件，甚至是广告，有些人甚至会认为 iframe 元素在嵌入它们的网站和源网站之间形成了一个安全边界，但事实并非如此。

HTML `<iframe>` 元素默认可以访问顶层页面的功能，如弹出窗口可以与顶层浏览器导航直接进行交互，例如，下面的代码可以嵌入到一个 iframe 元素的源代码中，它利用用户的主动触发，导致 iframe 的托管网站导航到一个新的 URL `https://example.com`：

```js
function clickToGo() {
  window.open('https://example.com')
}
```

这在很大程度上被称为点击劫持攻击，是嵌入在 iframe 中的许多其他安全风险之一（双关语）。

为了减轻这些担忧，HTML 规范（第 5 版）引入了 `sandbox` 属性，可以应用于 iframe 元素，它充当一个白名单列表，如果保持为空，它基本上不启用 iframe 元素中的任何功能，这将导致无法访问弹出窗口等页面交互功能，没有运行 JavaScript 代码的权限，也无法访问 cookies。

{{ figure_markup(
  image="prevalence-of-sandbox-directives-on-frames.png",
  caption="框架上 sandbox 指令的普遍性",
  description="条形图显示 iframes 中 sandbox 指令的流行程度。`allow-scrips` 和 `allow-same-origin` 是使用最多的指令，几乎 100% 具有 `sandbox` 属性的 iframes 都使用了这些指令。`allow-popups` 出现在 82% 的桌面端和 85% 的移动端框架中；`allow-forms` 出现在 81% 的桌面端和 84% 的移动端框架中；`allow-popups-to-escape-sandbox` 出现在 80% 的桌面端和 83% 的移动端框架中； `allow-top-navigation-by-user-activation` 出现在 59% 的桌面端和 61% 的移动端框架中；`allow-top-navigation` 出现在 21% 的桌面端和 22% 的移动端框架中，`allow-modals` 在桌面端占 20%，在移动端占 21%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1144896878&format=interactive",
  sheets_gid="245152438",
  sql_file="iframe_sandbox_directives.sql"
  )
}}

上述 2022 年的数据图表显示，超过 99% 的具有 `sandbox` 属性的网站都启用了 `allow-scripts` 和 `allow-same-origin` 权限。

对于桌面网站上的所有 iframe，21.08％ 具有 `sandbox` 属性。

<aside class="note">本章的早期版本报告了具有 `sandbox` 属性的帧百分比不正确。更多信息可在此 <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/3912">GitHub PR</a> 中找到。</aside>

我们发现包含 `sandbox` 指令的 `Content-Security-Policy` 标头在移动端仅占 0.3% 的使用率（桌面端为 0.4%），这可能说明了这样一个事实，即该属性仅适用于在页面中嵌入 iframe 内容的实践，而不是通过内容安全策略定义进行预先规划。

## 预防攻击

有许多不同的攻击可以利用一个网站，要完全保护你的网站（不受攻击）几乎不现实，然而，web 开发人员可以采取许多措施来防止大多数此类攻击，或限制它们对用户的影响。

### 采用安全标头

安全标头是通过限制流量和数据流类型来防止攻击的最常用方法之一，但大多数安全标头都需要网站开发人员手动设置，因此，安全标头的出现通常是网站开发人员所遵循安全保障的良好指示。

{{ figure_markup(
  image="adoption-of-security-headers.png",
  caption="在移动端页面的网站请求中采用安全标头",
  description="柱状图显示了 2022 年和 2021 年移动端页面中相同域下任何请求的不同安全标头的流行程度。`X-Content-Type-Options` 在 2021 年是 37%，在 2022 年是 40%；`X-Frame-Options` 在 2021 年是 29%，在 2022 年是 31%；`Strict-Transport-Security` 在 2021 年是 23%，在 2022 年是 26%；`X-XSS-Protection` 在 2021 年是 20%，在 2022 年是 21%；`Expect-CT` 在 2021 年为 13%，2022 年为 15%；`Content-Security-Policy` 在 2021 年为 13%，2022 年为 15%；`Report-To` 在 2021 年为 12%，2022 年为 11%；`Referrer-Policy` 在 2021 年为 10%，2022 年为 12%；`Permissions-Policy` 在 2021 年为 1%，2022 年为 2%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=479752873&format=interactive",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql",
  width=600,
  height=496
) }}

使用最广泛的安全机制仍然是 X-Content-Type-Options 标头，我们在移动端抓取的网站中，有 40% 使用该标头，以防止 MIME 嗅探攻击。紧随其后的是 X-Frame-Options 标头，30% 的网站都启用了该标头。与去年的数据相比，我们没有看到太大的差别，所有安全标头的采用率都在逐渐增加，但标头的使用百分比排名是相同的。

### 使用 CSP 预防攻击

内容安全策略（CSP）的主要用途是确定可以安全地从哪些可信源加载内容，这使得 CSP 成为一个非常有用的安全标头，可以防止各种攻击，如点击劫持、跨站脚本攻击、混合内容包含（mixed-content inclusion）等等。

{{ figure_markup(
  caption="使用 CSP 的移动端网站中，有 frame-ancestors 指令的百分比",
  content="53%",
  classes="big-number",
  sheets_gid="1303493233",
  sql_file="csp_directives_usage.sql"
)
}}

防止点击劫持攻击的常见方法之一是防止浏览器在框架中加载网站，人们可以在 CSP 标头中使用 [`frame-ancestors`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy/frame-ancestors) 指令来限制其他域将页面内容嵌入框架中。我们发现 53% 设置了 CSP 的 移动网站都有 `frame-ancestor` 指令，这是第二大使用的 CSP 指令，这有助于防止点击劫持攻击。将 `frame-ancestors` 指令的值设置为 `none` 或 `self` 是最安全的，`none` 不允许任何域名框住内容，而 `self` 只允许原始域名框住内容。我们发现，在有 CSP 标头的移动端网站中，有 8% 的网站只设置了 `frame-ancestors 'self'`，是 CSP 标头的第三大常见值。

<figure>
  <table>
    <thead>
      <tr>
        <th>关键字</th>
        <th>桌面端</th>
        <th>移动端</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`strict-dynamic`</td>
        <td class="numeric">6%</td>
        <td class="numeric">5%</td>
      </tr>
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
      caption="CSP 关键字的普遍性，基于定义了 `default-src` 或 `script-src` 指令",
      sheets_gid="323360740",
      sql_file="csp_script_source_list_keywords.sql"
    ) }}
  </figcaption>
</figure>

防御 XSS 攻击的一种机制是为网站设置限制性的 `script-src` 指令，它确保了 JavaScript 只从一个受信任的源加载，攻击者无法注入恶意代码。<a hreflang="en" href="https://content-security-policy.com/strict-dynamic/">`strict-dynamic`</a> 正逐渐被更多的网站采用，桌面端有 6% 的网站在使用它，而去年只有 5% 的网站在使用。如果你的 HTML 中有一个动态加载或注入其他脚本文件的根脚本，`strict-dynamic` 就很有用，它在根脚本上使用 nonce 或 hash，并忽略其他允许列表，如 `unsafe-inline` 或个别链接，除了IE之外，所有现代浏览器都支持它。此外，我们看到`unsafe-inline` 和 `unsafe-eval` 的使用量比去年减少了大约 2%，这是朝着正确方向迈出的一步。

### 使用 Cross-Origin 策略预防攻击

Cross Origin 策略是用于防御像 Cross Site 泄漏等微架构攻击的主要机制之一。XS-Leaks 有点类似于跨站点请求伪造（Cross Site Request Forgery），但是它们推断出在网站之间的交互过程中暴露出关于用户的小块信息。

{{ figure_markup(
  image="percentage-of-cross-origin-headers.png",
  caption="Cross Origin 标头的百分比",
  description="柱状图显示了 Cross Origin 标头的流行程度。在0.86% 的桌面端网站和 1.46% 的移动端网站中存在 `Cross-Origin-Resource-Policy`；在 0.04% 的桌面端网站和 0.03% 的移动端网站中存在 `Cross-Origin-Embedder-Policy`；在 0.23% 的桌面端网站和 0.45% 的移动端网站存在 `Cross-Origin-Opener-Policy`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=976367634&format=interactive",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql"
) }}

[`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Resource-Policy) 存在于 114,111(1.46%) 个移动端网站中，是最常用的跨源策略，它用于向浏览器表明是否允许来自跨源的资源。[`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy) 出现在 2559 个网站中，而去年是 911 个。我们看到 [`Cross-Origin-Opener-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy) 的采用也有类似的增长，现在有 34,968 家移动端网站设置了该标头，而去年只有 15,727 家。因此，所有跨源政策的采用都在稳步增长，这很好，因为它们对防止 XS-Leak 攻击非常有帮助。

### 使用 Clear-Site-Data 预防攻击

[Clear-Site-Data](https://developer.mozilla.org/docs/Web/HTTP/Headers/Clear-Site-Data) 为 web 开发人员提供了更多的控制，用于清除与他们网站相关的用户数据。例如，web 开发人员现在可以做出这样的决定：当用户退出他们的网站时，所有与该用户相关的 cookie、缓存和存储信息都可以删除，这有助于限制攻击的后果，因为在不需要时浏览器中存储的数据量是有限的。这是一个相对较新的标头，只限于通过 HTTPS 提供服务的网站，而且只有部分功能被[浏览器支持](https://developer.mozilla.org/docs/Web/HTTP/Headers/Clear-Site-Data#browser_compatibility)。

<figure>
  <table>
    <thead>
      <tr>
        <th>CSD 标头</th>
        <th>桌面端</th>
        <th>移动端</th>
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
        <td>`"*"`</td>
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
      caption="`Clear-Site-Data` 标头的流行度",
      sheets_gid="1206925009",
      sql_file="clear-site-data_value_prevalence.sql"
    ) }}
  </figcaption>
</figure>

`cache` 是 Clear-Site-Data 最普遍的指令（63% 的移动端网站在使用），这可能意味着许多开发者使用这个安全标头更多是为了清除缓存，便于加载更新的静态文件，而不是为了用户的隐私和安全，但是指令应该遵循 <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7230#section-3.2.6">quoted-string 语法</a>，因此这个指令是无效的。很高兴看到 9% 的移动端网站设置了 "*"，这意味着他们指示浏览器要清除所有存储的用户数据。第三个最常用的指令仍然是 `"cache"`，但这次使用正确。

### 使用 `<meta>` 预防攻击

网站的 `Content-Security-Policy` 和 `Referrer-Policy` 可以通过 HTML 代码中的 `<meta>` 标签来设置。例如，可以使用代码来设置 `Content-Security-Policy`：`<meta http-equiv="Content-Security-Policy" content="default-src 'self'">`。我们发现，在移动端领域有 0.47% 和 2.60% 的网站以这种方式启用了 CSP 和 Referrer-Policy。

<figure>
  <table>
    <thead>
      <tr>
        <th>Meta 标签值</th>
        <th>桌面端</th>
        <th>移动端</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>包含 Referrer-Policy</td>
        <td class="numeric">3.11%</td>
        <td class="numeric">2.60%</td>
      </tr>
      <tr>
        <td>包含 CSP</td>
        <td class="numeric">0.55%</td>
        <td class="numeric">0.47%</td>
      </tr>
      <tr>
        <td>包含 note-allowed headers</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="`<meta>` 标签中使用的安全标头",
      sheets_gid="2049304175",
      sql_file="meta_policies_allowed_vs_disallowed.sql"
    ) }}
  </figcaption>
</figure>

使用 `<meta>` 标签防止攻击的问题是，如果你使用它设置任何其他安全头，那么浏览器将忽略该安全头。例如，2815 个网站在 `<meta>` 标签中设置了 `X-Frame-Options`，因此，开发人员可能期望网站能够安全地应对某些攻击，因为他们添加了 `<meta>` 标签，但实际上该安全头从未生效。然而，这个数字已经从去年的 3410 个网站下降了，所以也许网站正在修复这种对 `<meta>` 标签的错误使用。

### Web Cryptography API

<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a> 是一个 JavaScript API，用于在网站上执行基本的加密操作，如随机数生成、哈希、签名、加密和解密。

<figure>
  <table>
    <thead>
      <tr>
        <th>Feature</th>
        <th>桌面端</th>
        <th>移动端</th>
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
      <tr>
        <td>`SubtleCryptoSign`</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`CryptoAlgorithmAesCtr`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">< 0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="最常用的加密 APIs",
      sheets_gid="971581635",
      sql_file="web_cryptography_api.sql"
    ) }}
  </figcaption>
</figure>

与去年相比，数据没有太大变化。`CryptoGetRandomValues` 仍然是采用最多的特性（尽管自去年以来它的使用量下降了大约 1%），因为它用于生成强伪随机数，它的高使用率是由于在诸如谷歌 Analytics 等常见服务中被使用。

### 机器人保护服务（Bot protection services）

今天的互联网充满了机器人，因此恶意机器人攻击不断上升。根据 Imperva <a hreflang="en" href="https://www.imperva.com/resources/reports/2022-Imperva-Bad-Bot-Report.pdf">2022 年恶意机器人报告</a>， 27.7% 的互联网流量是由恶意机器人造成的。恶意机器人是那些试图抓取数据并利用它的机器人，根据该报告，2021 年底恶意机器人攻击激增，可能是因为 log4j 漏洞可被机器人利用。

{{ figure_markup(
  image="bot-protection-service-usage.png",
  caption="供应商使用机器人保护服务的情况",
  description="条形图显示了机器人保护服务的使用情况。19.9% 的桌面端网站和 18.4% 的移动端网站使用 reCaptcha；7.9% 的桌面端网站和 6.1% 的移动端网站使用 Cloudflare 机器人管理；有 0.6% 的桌面端网站和 0.5% 的移动端网站使用 Akamai Bot Manager；有 0.4% 的桌面端网站和 0.3% 的移动端网站使用了 Imperva；其他机器人保护服务有 0.4% 的网站在桌面端使用，0.3% 的网站在移动端使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1782263355&format=interactive",
  sheets_gid="1592374295",
  sql_file="bot_detection.sql"
) }}

我们的分析显示 29% 的桌面端网站和 26% 的移动端网站使用了对抗恶意机器人的机制，这比去年（分别为 11% 和 10%）有了明显的增长，这一增长可能是因为 <a hreflang="en" href="https://www.cloudflare.com/en-gb/products/bot-management/">Cloudflare Bot Management</a>，它是一种保护免受恶意机器人攻击的免验证码解决方案。去年的数据抓取没有追踪到这一点，但今年增加了这一点，我们看到 6% 的移动端网站使用了它。reCaptcha 在桌面和移动端的使用率也比去年增长了约 9%。

## 采用安全机制的驱动因素

网站采用更多的安全措施有多种驱动因素，主要包括以下三种：
- 社会方面：在某些国家进行更多的安全教育，或在发生数据泄露时采取更多基于法律的惩罚措施
- 技术层面：在某些技术栈中采用安全特性可能更容易，或者某些供应商可能在默认情况下启用安全特性
- 知名度：广受欢迎的网站可能比鲜为人知的网站面临更多有针对性的攻击

### 网站地理位置

网站地理位置、网站开发人员的所在地或网站的托管地往往会对安全功能的采用产生影响，这可能是因为开发人员之间的意识不同，但也可能是因为国家的法律强制采用某些安全实践。

{{ figure_markup(
  image="adoption-of-https-per-country.png",
  caption="每个国家或地区启用 HTTPS 的情况",
  description="条形图显示了与不同国家或地区有关的网站启用 HTTPS 的百分比。新西兰、尼日利亚、澳大利亚、挪威、瑞士、丹麦、爱尔兰、南非、荷兰和加拿大依次为 95% 至 93%。在另一端，越南、塞尔维亚、俄罗斯联邦、波兰、伊朗、印度尼西亚、台湾、泰国、韩国和日本为 85% 至 81%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1218814034&format=interactive",
  sheets_gid="1838772734",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=617
) }}

我们看到许多新国家，如尼日利亚、挪威和丹麦，在启用 HTTPS 方面迅速上升到前列，看到新的国家也采取广泛的安全措施是一个好迹象，因为这可能表明各地的安全意识都在提高。另外，启用 HTTPS 最少的国家和启用 HTTPS 最多的国家之间的差距正在缩小，这表明几乎所有国家都在努力将 HTTPS 作为其网站的默认设置。

{{ figure_markup(
  image="adoption-of-csp-and-xfo-per-country.png",
  caption="每个国家启用 CSP 和 XFO 的情况",
  description="条形图显示，新西兰有 22% 的站点使用 CSP，38% 使用 XFO；澳大利亚有 21% 使用 CSP，35% 使用 XFO；印度尼西亚有 21% 使用 CSP，32% 使用 XFO；美国有 20% 使用CSP，31% 使用 XFO；爱尔兰有 20% 使用 CSP，36% 使用 XFO；乌克兰有 7% 的 CSP和 21% 的 XFO 占比；日本有 7% 的 CSP 和 17% 的 XFO 占比；哈萨克斯坦有 6% 的 CSP 和 21% 的 XFO 占比，白俄罗斯有 5% 的 CSP 和 20% 的 XFO 占比，而俄罗斯有 5% 的 CSP 和 20% 的 XFO 占比。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=651643593&format=interactive",
  sheets_gid="1838772734",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=598
) }}

CSP 和 `X-Frame-Options`（XFO）的启用与去年非常相似，令人惊讶的是，我们看到印尼的网站已经开始大量使用 CSP，尽管他们对 HTTPS 的启用仍然很低。各国对 CSP 的采用似乎仍有很大差异，但对 XFO 的采用之间的差距正在逐渐缩小。更多的国家需要增加对 CSP 的采用，因为它是一个非常重要的安全特性，可以抵御各种各样的攻击。

### 技术栈

另一个可以强烈影响某些安全机制采用的因素是用于构建网站的技术栈，在某些情况下，例如在内容管理系统中，安全特性可能是默认启用的。

<figure>
  <table>
    <thead>
      <tr>
        <th>Technology</th>
        <th>安全特性</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Blogger</td>
        <td>
          <code>Content-Security-Policy</code> (99%),<br>
          <code>X-Content-Type-Options</code> (99%),<br>
          <code>X-Frame-Options</code> (99%),<br>
          <code>X-XSS-Protection</code> (99%)
        </td>
      </tr>
      <tr>
        <td>Wix</td>
        <td>
          <code>Strict-Transport-Security</code> (99%),<br>
          <code>X-Content-Type-Options</code> (99%)
        </td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td>
          <code>X-Content-Type-Options</code> (77%),<br>
          <code>X-Frame-Options</code> (77%)
        </td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td>
          <code>Strict-Transport-Security</code> (91%),<br>
          <code>X-Content-Type-Options</code> (98%)
        </td>
      </tr>
      <tr>
        <td>Google Sites</td>
        <td>
          <code>Content-Security-Policy</code> (96%),<br>
          <code>Cross-Origin-Opener-Policy</code> (96%),<br>
          <code>Referrer-Policy</code> (96%),<br>
          <code>X-Content-Type-Options</code> (97%),<br>
          <code>X-Frame-Options</code> (97%),<br>
          <code>X-XSS-Protection</code> (97%)
        </td>
      </tr>
      <tr>
        <td>Plone</td>
        <td><code>X-Frame-Options</code> (60%)</td>
      </tr>
      <tr>
        <td>Wagtail</td>
        <td>
          <code>X-Content-Type-Options</code> (51%),<br>
          <code>X-Frame-Options</code> (72%)
        </td>
      </tr>
      <tr>
        <td>Medium</td>
        <td>
          <code>Content-Security-Policy</code> (75%),<br>
          <code>Expect-CT</code> (83%),<br>
          <code>Strict-Transport-Security</code> (84%),<br>
          <code>X-Content-Type-Options</code> (83%)
        </td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="各类技术（网站等）所采用的安全特性",
      sheets_gid="1386880960",
      sql_file="feature_adoption_by_technology.sql"
    ) }}
  </figcaption>
</figure>

上面我们看到一些常见的 CMS 和博客网站，我们看到的一个共同模式是，像 Wix、Squarespace 和 Medium 这样很少提供定制服务，更注重内容编辑的网站，它们默认有基本的安全功能，如 `Strict-Transport-Security`。像 Wagtail、Plone 和 Drupal 这样的内容管理系统只采用了非常少的安全功能，因为它们经常被开发人员用来建立网站，因此增加安全功能的责任更多地落在了开发人员身上。我们还看到，使用谷歌站点的网站在默认情况下具有许多安全特性。

### 网站知名度

访问者多的网站可能更容易受到有针对性的攻击，因为有更多的用户拥有潜在的敏感数据来吸引攻击者。因此，可以预期的是浏览量大的网站为了保护用户，会在安全方面投入更多资金。

{{ figure_markup(
  image="prevalence-of-headers-in-sites-by-rank.png",
  caption="第一方环境中按等级设置安全标头的流行度",
  description="柱状图显示，在排名前 1000 位的网站中，55.9% 设置了 XFO，56.8% 设置了 HSTS，27% 设置了 CSP 标头；在排名前 10,000 的网站中，51.3% 设置了 XFO，44.5% 设置了 HSTS，20.6% 设置了 CSP 标头；在前 100,000 名中，48.1% 设置了 XFO，38% 设置了 HSTS，17.8% 设置了 CSP 标头；在排名前 100 万的网站中，41.9% 设置了 XFO，31.1% 设置了 HSTS，16.4% 设置了 CSP 标头；在所有网站中，31% 设置了 XFO，25.7% 设置了 HSTS，14.6% 设置了 CSP。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1055039456&format=interactive",
  sheets_gid="1909836848",
  sql_file="security_adoption_by_rank.sql"
  )
}}

我们发现，`Strict-Transport-Security`、`X-Frame-Options` 和 `X-Content-Type-Options` 总是被更受欢迎的网站采用。在移动端领域排名前 1000 的网站中，56.8% 的网站设置了 Strict-Transport-Security，这意味着这些网站更关心只通过 HTTPS 提供内容和数据。不太受欢迎的网站可能启用了 HTTPS，但往往可能没有添加一个 `Strict-Transport-Security` 标头，以确保他们的网站总是通过 HTTPS 服务，今年的数字与去年的调查结果相当一致。

## 网络上的不良行为

今年加密货币的受欢迎程度继续增长，有更多的类型可用于各种使用情况，随着这种持续增长和现有的经济激励，网络犯罪分子通过[加密货币劫持](https://en.wikipedia.org/wiki/Cryptojacking)这一点为他们获得好处。然而，自去年以来，加密货币矿工的使用总体呈下降趋势，似乎是因为某些漏洞事件，使攻击者能够将加密货币矿工注入到桌面和移动端系统中，从而引发其使用量的激增。

{{ figure_markup(
  image="cryptominer-usage.png",
  caption="Cryptominer 的使用",
  description="时间序列图显示了从 2020 年 1 月到 2022 年 7 月带有加密劫持脚本网站数量的演变。从最初的 500 个桌面端站点和 606 个移动端站点到 2021 年 8 月的 827 个桌面端站点和 983 个移动端站点，呈上升趋势，然后在 2022 年 7 月呈下降趋势，桌面端站点为 61 个，移动端站点为 127 个。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1621924056&format=interactive",
  sheets_gid="367286091",
  sql_file="cryptominer_usage.sql"
) }}

例如，在 2021 年 7 月和 8 月左右，出现了几次加密劫持活动和漏洞 1、2、3 的报告，这可能是当时在网站上发现加密矿机激增的原因。最近，在 2022 年 4 月，黑客试图利用 <a hreflang="en" href="https://arstechnica.com/information-technology/2022/04/hackers-hammer-springshell-vulnerability-in-attempt-to-install-cryptominers/">SpringShell 漏洞来建立和运行加密货币矿机</a>。

深入了解在桌面和移动端网站中发现加密货币的具体情况，我们发现，矿工中的份额比去年有所扩散，例如，Coinimp 的份额自去年以来缩减了约 24%，而 Minero.cc 则增长了约 11%。

{{ figure_markup(
  image="cryptominer-market-share.png",
  caption="加密货币市场份额（移动端）",
  description="饼状图显示 CoinImp 占 60.4% 的市场份额，Coinhive 占 15.6%，Minero 占 12.4%，JSECoin 占 6.8%，其他约占 4.8%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1570078079&format=interactive",
  sheets_gid="280179954",
  sql_file="cryptominer_share.sql"
) }}

这些结果表明，加密劫持仍然是一个严重的攻击载体，每年根据新出现的漏洞使其使用量激增。因此，为了减轻这一领域的风险，仍然需要适当的努力。

注意，并非所有这些网站都受到了感染，网站运营商也可能部署这种技术（而不是展示广告）来资助他们的网站，但这种技术的使用也在技术上、法律上和伦理上被大量讨论。

请注意，我们的结果可能不会显示受加密劫持感染网站的实际状态。由于我们每个月运行一次爬虫程序，并不是所有运行加密程序的网站都能被发现，例如，如果一个网站只受感染 X 天，但不在我们的爬虫运行的那天，情况就是这样。

## Well-known URIs

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8615">Well-known URIs</a> 用于指定与整个网站有关的数据或服务的特定位置。well-known URI 是一个 <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc3986">URI</a>，其路径组件以 `/.well-known/` 字符开头。

### `security.txt`

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-foudil-securitytxt-12">`security.txt`</a> 是网站提供漏洞报告标准的文件格式，网站提供者可以在这个文件中提供详细的联系方式、PGP 密钥、策略和其他信息。白帽黑客和渗透测试人员可以利用这些信息对这些网站进行安全分析并报告漏洞。

{{ figure_markup(
  image="usage-of-properties-in-well-known-security.png",
  caption="security.txt 属性的使用",
  description="柱状图显示了 `security.txt` 中不同属性的使用。0.6% 的桌面端和 0.4% 的移动端设备使用 `security.txt` 文件签名，4.2% 的桌面端和 3.5% 的移动端设备使用 `Canonical`，3.0% 的桌面端和 2.4% 的移动端设备使用 `Encryption`，3.0% 的桌面端和 2.3% 的移动端设备使用 `Expires`，7.3% 的桌面端和 6.8% 的移动端设备使用 `Policy`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=446092062&format=interactive",
  sheets_gid="337263220",
  sql_file="well-known_security.sql"
  )
}}

今年，带有 `expires` 属性的 `security.txt` URI 百分比从 0.7% 增加到 2.3%，`expires` 属于该标准的必需属性，所以看到更多的网站遵守该标准是件好事。`policy` 仍然是 `security.txt` URI中最受欢迎的属性，`policy` 在 `security.txt` URI 中非常重要，因为它描述了安全研究人员报告漏洞时应遵循的步骤。

### `change-password`

The <a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/">`change-password`</a> well-known URI 是 W3C Web 应用程序安全工作组的一个规范，目前处于编辑草案状态。这个特定的 well-known URI 被建议作为一种方式，让用户和软件能够轻松识别用于更改密码的链接。

{{ figure_markup(
  image="usage-of-change-password.png",
  caption="使用 change-password 端点",
  description="柱状图显示 0.28% 的桌面端网站和 0.26% 的移动端网站使用 change-password 端点。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1340997331&format=interactive",
  sheets_gid="168419039",
  sql_file="well-known_change-password.sql"
  )
}}

这个 well-known URI 的采用率仍然相当低，该规范仍在进行中，所以没有多少网站开始采用它是可以理解的。另外，并不是所有的网站都会有一个 change-password 的表格，特别是如果他们的网站没有登录系统。

### 检测状态码可靠性

这个 well-known URI 决定了网站 HTTP 响应状态码的可靠性，此 URI 也仍然处于<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html">编辑草案</a>状态，将来可能会更改。这个 well-known URI 背后的理念是，它不应该存在于任何网站中，因此这个 well-known URI 不应该响应 <a hreflang="en" href="https://fetch.spec.whatwg.org/#ok-status">ok-status</a>，如果它重定向并返回一个 "ok-status"，这意味着该网站的状态码不可靠。

{{ figure_markup(
  image="detecting-status-code-reliability.png",
  caption="resource-that-should-not-exist-whose-status-code-should-not-be-200 端点的状态",
  description="条形图显示由 `resource-that-should-not-exist-whose-status-code-should-not-200` 端点返回的响应状态。在桌面端网站中，10% 返回 200，84% 返回 not-ok 状态，6% 返回 201-299 状态码。在移动端网站中，9% 返回 200，84% 返回 not-ok 状态，7% 返回 201-299 状态码。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1477977449&format=interactive",
  sheets_gid="1163882629",
  sql_file="well-known_resource-not-be-200.sql"
  )
}}

我们发现，84% 的网站在移动端和桌面端都对这一 well-known URI 做出了 not-ok 的回应，这个规范的好处是，如果网站配置正确，这个规范应该自动工作，不需要网站开发人员做任何具体的修改。

## 总结

我们今年的分析显示，各网站正在继续对其安全功能进行加固，就像我们在过去几年中看到的那样。同样令人兴奋的是，许多在网络安全采用方面落后的国家正在增加其使用量，这可能意味着人们对网络安全的意识正在普遍提高。

我们发现，web 开发人员也在慢慢采用新的标准，取代旧的标准，这绝对是朝着正确的方向迈出的一步，网络安全和隐私的重要性与日俱增。网络已经成为许多人生活中不可分割的一部分，因此网络开发人员应该继续增加网络安全功能的使用。

在制定更严格的内容安全政策方面，我们还有很多工作要做。跨站脚本继续在 <a hreflang="en" href="https://owasp.org/Top10/">OWASP 前十名</a>，需要更广泛地采用更严格的 `script-src` 指令，来防止此类攻击。此外，更多的开发人员可以考虑利用 Web Cryptography API，在采用 well-known URIs（如 security.txt）时也需要做出类似的努力，它不仅为安全专家提供了一种报告网站漏洞的方法，而且还表明开发人员关心网站的安全，并愿意进行改进。

在过去的几年里网络安全的使用不断进步是令人鼓舞的，但网络社区需要继续研究和采用更多的安全特性，因为 web 在不断增长，安全变得更加重要。
