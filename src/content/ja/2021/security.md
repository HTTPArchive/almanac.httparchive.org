---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: セキュリティ
description: 2021年版Web Almanacのセキュリティの章では、トランスポートレイヤーセキュリティ、コンテンツインクルージョン（CSP、フィーチャーポリシー、SRI）、Web防御機構（XSS、XS-Leaksへの取り組み）、セキュリティ機構採用の促進要因について解説しています。
authors: [saptaks, tomvangoethem, nrllh]
reviewers: [cqueern, edmondwwchan, awareseven]
analysts: [gjfr]
editors: [tunetheweb]
translators: [ksakae1216]
saptaks_bio: Saptak Sは人権を中心としたウェブ開発者であり、ウェブ開発におけるユーザビリティ、セキュリティ、プライバシー、アクセシビリティのトピックに焦点を当てています。<a hreflang="en" href="https://www.a11yproject.com">A11Y Project</a>、<a hreflang="en" href="https://onionshare.org/">OnionShare</a> 、<a hreflang="en" href="https://wagtail.io/">Wagtail</a> など様々なオープンソースプロジェクトの貢献者、メンテナである。ブログは<a hreflang="en" href="https://saptaks.blog">saptaks.blog</a>でご覧いただけます。
tomvangoethem_bio: Tom Van Goethemは、ベルギーのルーヴェン大学<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet group</a>の研究者です。彼の研究は、セキュリティやプライバシーの問題につながるウェブ上の新しいサイドチャネル攻撃を発見し、その原因となるリークを修正する方法を見つけ出すことに重点を置いています。
nrllh_bio: Nurullah Demirは、<a hreflang="en" href="https://www.internet-sicherheit.de/en/">インターネットセキュリティ研究所</a>のセキュリティ研究者であり、博士課程に在籍しています。研究テーマは、堅牢なWebセキュリティ機構と敵対的機械学習です。
results: https://docs.google.com/spreadsheets/d/1kwjKoa8tV87XzlF6eetf2sfcMDFqVVaT25w_gm_SRwA/
featured_quote: 今回の分析では、プロバイダー側に関するWebセキュリティの状況は、以前に比べて改善されていることが明確に示されました。しかし、私たちの観察は、より良いセキュリティを確保するために、ウェブコミュニティがもっと努力すべきことも示しています。
featured_stat_1: 91.1%
featured_stat_label_1: モバイルでHTTPSを使用するリクエスト
featured_stat_2: 22.2%
featured_stat_label_2: 上位1000サイトのうち、CSPを利用している割合
featured_stat_3: 10.7%
featured_stat_label_3: 悪意のあるボットに対抗するための仕組みを利用したデスクトップ上のWebサイト
---

## 序章

現代はどんどんデジタル化が進んでいます。ビジネスだけでなく、私生活もデジタル化されています。私たちはオンラインで人と連絡を取り、メッセージを送り、友人と瞬間を共有し、ビジネスを行い日常生活を整理しています。同時に、この変化は、より多くの重要なデータがデジタル化され、私的、商業的にも処理されるようになったことを意味します。このような状況において、ユーザーデータの可用性、完全性、機密性を提供することでユーザーを保護することを目的とするサイバーセキュリティの重要性も増してきています。今日の技術に目を向けると、デジタルで提供されるソリューションを提供するために、ウェブリソースがますます利用されていることがわかります。それはまた、その普及により、私たちの現代生活とWebアプリケーションのセキュリティとの間に強い結びつきがあることを意味します。

この章では、Web上のセキュリティの現状を分析し、Webコミュニティが自分たちの環境を守るために使っている（そして見逃している）手法の概要を説明します。具体的には、このレポートでは、一般的な実装、プロトコルのバージョン、暗号スイートなどの [トランスポートレイヤーセキュリティ](#transport-security) (HTTPS) に関するさまざまな指標を分析しています。また、[クッキー](#cookies)を保護するための技術についても概観しています。そして、[コンテンツ・インクルージョン](#content-inclusion)の話題と[攻撃を阻止する](#thwarting-attacks)ための方法（例：特定のセキュリティヘッダーの使用）についての包括的な分析が掲載されています。また、[セキュリティメカニズム](#drivers-of-security-meachnism-adoption)がどのように採用されているか（国別や特定の技術別など）についても見ています。また、Cryptojackingのような[ウェブ上の不正行為](#malpractices-on-the-web)について議論し、最後に[`security.txt` URL](#securitytxt) の使用について見ています。

分析対象ページをデスクトップとモバイルの両方でクロールしていますが、多くのデータで同様の結果が得られているため、本章で紹介する統計情報は、とくに断りのない限り、モバイルページのセットを参照しています。データの収集方法の詳細については、[方法論](./methodology) ページを参照してください。

## トランスポートセキュリティ

最近の傾向として、今年もHTTPSを採用するWebサイトの数が継続的に増加していると思われます。トランスポート・レイヤー・セキュリティは、Webサイトの安全な閲覧を可能にするため重要であり、利用者に提供されるリソースやWebサイトに送信されるデータが転送中に改ざんされないことを保証するものです。現在、主要なブラウザのほとんどにHTTPS専用の設定があり、ウェブサイトがHTTPSではなくHTTPを使用している場合は、ユーザーに警告が表示されるようになっているため、より広範な導入が進んでいます。

{{ figure_markup(
  caption="モバイルでHTTPSを使用するリクエストの割合です。",
  content="91.1%",
  classes="big-number",
  sheets_gid="547694791",
  sql_file="https_request_over_time.sql"
)
}}

現在、デスクトップではウェブサイトへの総リクエストの91.9%、モバイルでは91.1%がHTTPSで提供されていることがわかります。Let's Encryptのような非営利の認証局のおかげで、<a hreflang="en" href="https://letsencrypt.org/stats/#daily-issuance">増え続ける証明書</a>が日々発行されているのを目にします。

{{ figure_markup(
  image="security-https-usage-by-site.png",
  caption="サイトのHTTPS利用状況。",
  description="棒グラフはデスクトップサイトの84.3%がHTTPSを使用し、残りの15.7%がHTTPを使用していることを示し、モバイルサイトの81.2%がHTTPSを使用し、残りの18.8%がHTTPを使用していることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=111383569&format=interactive",
  sheets_gid="8055510",
  sql_file="home_page_https_usage.sql"
  )
}}

現在、デスクトップで84.3%、モバイルでは81.2%のWebサイトのホームページがHTTPSで提供されているため、HTTPSを利用しているWebサイトとHTTPSを利用しているリクエストの間にはまだギャップがあると考えられます。これは、HTTPSリクエストの印象的な割合の多くは、フォント、分析、[CDN](./cdn)などの[サードパーティ](./third-parties)サービスによって占められており、最初のウェブページ自体ではないことが多いからです。

HTTPSを使用しているサイトは継続的に改善しています（[昨年](../2020/security#fig-3)から約7-8% の増加）。しかし、<a hreflang="en" href="https://blog.mozilla.org/security/2021/08/10/firefox-91-introduces-https-by-default-in-private-browsing/">ブラウザがデフォルトでHTTPS専用モード</a>を採用し始めると、まもなく多くのメンテナンスされていないウェブサイトが警告を表示し始めるかもしれません。

### プロトコルのバージョン

_トランスポートレイヤーセキュリティ_（TLS）とは、HTTPリクエストを安全かつプライベートにするためのプロトコルです。時代とともに、TLSには新たな脆弱性が発見され、修正されています。したがって、ウェブサイトをHTTPSで提供するだけでなく、そのような脆弱性を回避するために最新のTLS設定が使用されていることを確認することが重要です。

その一環として、最新バージョンの採用によるセキュリティと信頼性の向上を目指し、2021年3月25日をもってTLS 1.0および1.1が<a hreflang="en" href="https://datatracker.ietf.org/doc/rfc8996/">インターネット技術タスクフォース（IETF）</a>により非推奨とされました。また、すべてのアップストリームブラウザは、TLS 1.0および1.1のサポートを完全に削除するか、非推奨としています。たとえば、FirefoxはTLS1.0と1.1を非推奨としていますが、<a hreflang="en" href="https://www.ghacks.net/2020/03/21/mozilla-re-enables-tls-1-0-and-1-1-because-of-coronavirus-and-google/">完全に削除していません</a>。これは、パンデミックの間、ユーザーが、しばしばまだTLS1.0で動いている政府のウェブサイトにアクセスする可能性があるからです。ユーザーは、ブラウザの設定で `security.tls.version.min` を変更し、ブラウザが許可するもっとも低いTLSバージョンを決定することもできます。

{{ figure_markup(
  image="security-tls-version-by-site.png",
  caption="サイトでのTLSバージョン使用状況。",
  description="デスクトップでは、60.4%のサイトがTLSv1.3を使用し、39.6%がTLSv1.2を使用していることが棒グラフで示されています。モバイルでは、それぞれ62.1%、37.8%となっています。TLSv1.0、TLSv1.1はほとんど登録されていませんが、QUICの利用はごくわずかです（デスクトップとモバイルで0.1％未満）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1868638312&format=interactive",
  sheets_gid="1012588329",
  sql_file="tls_versions_pages.sql"
  )
}}

デスクトップで60.4%、モバイルでは62.1%のページがTLSv1.3を使用しており、TLSv1.2を超えるプロトコルバージョンが主流となっています。TLSv1.3を使用しているページ数は、それぞれ43.2%、45.4%であった[昨年](../2020/security#protocol-versions)から約20%増加しました。

### 暗号スイート

暗号スイートは、TLSで使用されるアルゴリズムのセットで、安全な接続を行うために使用されます。現代の [ガロアカウンターモード](https://ja.wikipedia.org/wiki/Galois/Counter_Mode) (GCM) 暗号モードは、古い [Cipher Block Chaining Mode](https://ja.wikipedia.org/wiki/%E6%9A%97%E5%8F%B7%E5%88%A9%E7%94%A8%E3%83%A2%E3%83%BC%E3%83%89#Cipher_Block_Chaining_(CBC)) (CBC) と比較して、はるかに安全であると考えられています。暗号は、<a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">パディング攻撃</a>に対して脆弱であることが示されています</a>。TLSv1.2は新しい暗号スイートと古い暗号スイートの両方をサポートしていましたが、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">TLSv1.3は古い暗号スイートを一切サポートしていません</a>。これが、TLSv1.3がより安全な接続オプションである理由の1つです。

{{ figure_markup(
  caption="フォワードセキュリティーを利用したモバイルサイト。",
  content="96.8%",
  classes="big-number",
  sheets_gid="993983713",
  sql_file="tls_forward_secrecy.sql"
)
}}

最近の暗号スイートはほとんどすべて[_フォワードセキュリティー_](https://ja.wikipedia.org/wiki/Forward_secrecy)鍵交換をサポートしています。つまり、サーバーの鍵が漏洩した場合、その鍵を使った古いトラフィックは復号化できないのです。デスクトップで96.6%、モバイルでは96.8%が前方秘匿を使用しています。TLSv1.2ではオプションだったフォワードセキュリティーが、TLSv1.3では必須となったことも、より安全である理由の1つです。

暗号モードとは別に考慮すべきは、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc5116#section-2">認証された暗号化および認証された復号化</a> アルゴリズムの鍵のサイズです。鍵のサイズが大きいと、暗号化するのに時間がかかり、接続の暗号化と復号化のための集中的な計算が、サイトのパフォーマンスにほとんど影響を与えません。

{{ figure_markup(
  image="security-distribution-of-cipher-suites.png",
  caption="暗号スイートの配布。",
  description="デバイス別に使用されている暗号スイートの棒グラフ。もっとも一般的な暗号スイートは `AES_128_GCM` で、デスクトップサイトの79.4%とモバイルサイトの78.9%で使用されており、`AES_256_GCM` はデスクトップサイトの18.6% とモバイルサイトの19.0% 、`AES_256_CBC`は1.1%、モバイル用サイトの1.2%、`CHACHA20_POLY1305`はそれぞれ0.6%、0.7%、`AES_128_CBC`がそれぞれ0.3%、0.2%、`3DES_EDE_CBC`は非常に少数のサイトで使われているため0%と表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=47980777&format=interactive",
  sheets_gid="172961549",
  sql_file="tls_cipher_suite.sql"
  )
}}

`AES_128_GCM`は、デスクトップで79.4％、モバイルで78.9％と、依然としてもっとも広く利用されている暗号スイートです。`AES_128_GCM`は、暗号化と復号化にキーサイズ128ビットの_Advanced Encryption Standard_ (AES) とGCM暗号モードを使用することを表しています。128ビットの鍵はまだ安全だと考えられていますが、ブルートフォース攻撃により長く耐えられるように、256ビットの鍵が徐々に業界標準になりつつあります。

### 認証局

_認証局_とは、デジタル証明書を発行する企業や組織のことで、WebサイトなどWeb上のエンティティの所有権や身元を検証するのに役立っています。認証局は、ブラウザが認識するTLS証明書を発行し、ウェブサイトがHTTPSで提供できるようにするため必要です。昨年と同様に、サードパーティのサービスやリソースではなく、Webサイト自身が使用する認証局について再び調べます。

<figure>
  <table>
    <thead>
      <tr>
        <th>発行者</th>
        <th>アルゴリズム</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="Webサイト向け証明書発行会社トップ10", sheets_gid="1291345416", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

Let's Encryptは、新しい証明書のバイト数を節約するために、<a hreflang="en" href="https://letsencrypt.org/2020/09/17/new-root-and-intermediates.html#why-we-issued-an-ecdsa-root-and-intermediates">その主題のコモンネーム</a>を "Let's Encrypt Authority X3" から単に "R3" に変更しました。つまり、R3が署名したSSL証明書は、<a hreflang="en" href="https://letsencrypt.org/certificates/">Let's Encrypt</a>が発行していることになるのです。このように、Let's Encryptが発行する証明書を使用しているデスクトップWebサイトは46.9%、モバイルサイトでは49.2%と、例年通りLet's Encryptがチャートをリードしていることがわかります。これは昨年より2〜3％増加している。Let's Encryptの無料証明書自動生成機能は、誰もが簡単にHTTPSでウェブサイトを提供できるようにする上で、画期的な役割を果たしています。

Cloudflareは、同様に顧客向けに無料の証明書を提供しており、引き続き2位を維持しています。また、Cloudflare CDNは、<a hreflang="en" href="https://www.digicert.com/faq/ecc.htm">_Elliptic Curve Cryptography_</a>（ECC）証明書の利用を増やしています。RSA証明書よりも小型で効率的ですが、古いクライアントに対して非ECC証明書も提供し続ける必要があり、しばしば導入が困難となります。CloudflareのようなCDNを利用することで、その複雑さを解消できます。<a hreflang="en" href="https://developers.cloudflare.com/ssl/ssl-tls/browser-compatibility">最新のブラウザ</a>はすべてECC証明書に対応していますが、Chromeなど一部のブラウザはOSに依存しています。そのため、Windows XPなどの古いOSでChromeを使う人は、ECC以外の証明書にフォールバックする必要があるのです。

### HTTPストリクトトランスポートセキュリティ

[_HTTPストリクトトランスポートセキュリティ_](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security) (HSTS)は、ウェブサイトとの通信に安全なHTTPS接続を_常に_使用するようブラウザに指示する応答ヘッダーです。

{{ figure_markup(
  caption="モバイルでHSTSヘッダーを持つリクエストの割合です。",
  content="22.2%",
  classes="big-number",
  sheets_gid="1612539726"
)
}}

`Strict-Transport-Security` ヘッダーは、そのサイトへのリクエストが行われる前に、`http://` URLを `https://` URLへ変換するのに役立つものです。モバイル用レスポンスの22.2%、デスクトップ用レスポンスの23.9%にHSTSヘッダーがあります。

<figure>
  <table>
    <thead>
      <tr>
        <th>HSTSディレクティブ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="HSTSディレクティブの使用方法。", sheets_gid="1612539726", sql_file="hsts_attributes.sql") }}</figcaption>
</figure>

HSTSヘッダーを持つサイトのうち、デスクトップで92.7%、モバイルでは93.4%が有効な`max-age`（つまり、値がゼロでなく、空でないこと）を持ち、ブラウザは何秒間だけHTTPSでウェブサイトにアクセスすべきか判断しています。

モバイルで33.3%、デスクトップでは34.5%のリクエストレスポンスがHSTS設定に`includeSubdomain`を含んでいます。`preload` ディレクティブは [HSTS仕様の一部ではない](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security) ため、レスポンス数が少なくなっています。また、最低でも `max-age` が31,536,000秒（または1年）で、さらに `includeSubdomain` ディレクティブも必要なため、このディレクティブは存在します。

{{ figure_markup(
  image="security-hsts-max-age-values-in-days.png",
  caption="すべてのリクエストに対するHSTS `max-age` の値（日数単位）。",
  description="`max-age`属性の値のパーセンタイルを日数に換算した棒グラフです。10パーセンタイルではデスクトップ、モバイルともに30日、25パーセンタイルではともに182日、50パーセンタイルではともに365日、75パーセンタイルはともに365日で同じ、90パーセンタイルはともに730日となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1583549091&format=interactive",
  sheets_gid="1297999193",
  sql_file="hsts_max_age_percentiles.sql"
) }}

HSTSヘッダーの`max-age`属性の中央値は、モバイルとデスクトップの両方で365日であることがわかりました。<a hreflang="en" href="https://hstspreload.org/">https://hstspreload.org/</a> では、HSTSヘッダーが適切に設定され問題が、発生しないことが確認された場合、`max-age`を2年間とすることを推奨しています。

## クッキー

HTTPクッキーとは、サーバーがウェブブラウザに送信する、ウェブサイトにアクセスするユーザーに関する小さな情報のことです。ブラウザはこの情報を保存し、その後のサーバーへのリクエストで送り返します。クッキーは、セッション管理に役立ち、ユーザーが現在ログインしているかどうかなど、ユーザーの状態情報を維持します。

Cookieを適切に保護しないと、攻撃者はセッションを乗っ取り、ユーザーになりすましてサーバーに不要な変更を送ることができます。また、<a hreflang="en" href="https://owasp.org/www-community/attacks/csrf">_クロスサイトリクエストフォージェリ_</a> という攻撃にもつながり、ユーザーのブラウザがユーザーに気づかれないように、クッキーを含むリクエストを不用意に送信してしまうことがあるのです。

他にも、<a hreflang="en" href="https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-lekies.pdf">_クロスサイトスクリプトインクルージョン_</a> (XSSI) や <a hreflang="en" href="https://xsleaks.dev/">_XS-リークス_</a> の脆弱性クラスのさまざまなテクニックなど、クロスサイトのリクエストにクッキーを含めることに依存しているタイプの攻撃もいくつか存在します。

特定の属性や接頭辞を追加することで、クッキーが安全に送信され、意図しない相手やスクリプトによってアクセスされないようにできます。

{{ figure_markup(
  image="security-httponly-secure-samesite-cookie-usage.png",
  caption="Cookieの属性（デスクトップ）。",
  description="デスクトップサイトで使用されているCookieの属性をファーストクッキーとサードパーティーに分けた棒グラフ。ファーストパーティでは、`HttpOnly`が32.7%、`Secure`31.0%、`SameSite`34.1%で、サードパーティでは、`HttpOnly`が20.0%、`Secure`67.0%、`SameSite`64.9%で使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=546317907&format=interactive",
  sheets_gid="1757682198",
  sql_file="cookie_attributes.sql"
) }}

### `Secure`

`Secure` 属性が設定されたクッキーは、安全なHTTPS接続でのみ送信され、<a hreflang="en" href="https://owasp.org/www-community/attacks/Manipulator-in-the-middle_attack">_Manipulator-in-the-middle_</a> 攻撃で盗まれないようにします。HSTSと同様に、TLSプロトコルが提供するセキュリティの強化にも貢献します。ファーストパーティのクッキーについては、デスクトップとモバイルの両方で、30%強のクッキーに `Secure` 属性が設定されています。しかし、デスクトップにおけるサードパーティ製クッキーのうち、`Secure`属性を持つものの割合が、[昨年](../2020/security#cookies)の35.2％から今年は67.0％に大きく増加していることがわかります。この増加は、後述する `SameSite=none` のクッキーに対して [`Secure` 属性が必須である](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Set-Cookie/SameSite#none) ことに起因すると思われます。

### `HttpOnly`

`HttpOnly` 属性が設定されたクッキーは、JavaScriptの `document.cookie` APIを使ってアクセスすることができません。このようなクッキーはサーバにのみ送ることができ、クッキーを悪用したクライアントサイドの _クロスサイトスクリプティング_ (XSS) 攻撃を緩和するのに役立ちます。サーバーサイドのセッションにのみ必要なクッキーに使用されます。`HttpOnly`属性を持つクッキーの割合は、他のクッキー属性がそれぞれ32.7%と20.0%で使用されているのに比べ、ファーストパーティークッキーとサードパーティーの差はより小さくなっています。

### `SameSite`

クッキーの `SameSite` 属性により、ウェブサイトはクロスサイトリクエストでクッキーを送信するタイミングとその有無をブラウザに通知できます。これはクロスサイトリクエストフォージェリ攻撃を防ぐために使用されます。`SameSite=Strict`はクッキーをそれが発生したサイトのみに送信することを可能にします。`SameSite=Lax`では、ユーザーがリンクをたどって元のサイトに移動していない限り、クッキーはクロスサイトリクエストに送られません。`SameSite=None`では、クッキーはオリジンサイトとクロスサイトリクエストの両方で送信されます。

{{ figure_markup(
  image="security-samesite-cookie-attributes.png",
  caption="同一サイトのCookie属性。",
  description="SameSiteのクッキー属性をファーストパーティとサードパーティに分けた棒グラフ。ファーストパーティでは、`SameSite=lax`が58.5%、`SameSite=strict`2.5%、`SameSite=none`39.1%、サードパーティでは`SameSite=lax`が1.5%、`SameSite=strict`0.1%、`SameSite=none`は98.3%で使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=672211543&format=interactive",
  sheets_gid="1757682198",
  sql_file="cookie_attributes.sql"
) }}

`SameSite` 属性を持つファーストパーティークッキーの58.5%が `Lax` に設定されていることがわかります。一方、`SameSite` 属性が `none` に設定されているクッキーがまだ39.1% あり、かなり大変ですが、数は着実に減少しています。現在のほぼすべてのブラウザは、`SameSite`属性が設定されていない場合、`SameSite=Lax`をデフォルトとしています。ファーストパーティークッキー全体の約65%は `SameSite` 属性を持っていません。

### プレフィックス

クッキープレフィックス `__Host-` と `__Secure-` は、<a hreflang="en" href="https://owasp.org/www-community/attacks/Session_fixation">セッションフィクスチャ攻撃</a> のためにセッションクッキーの情報を上書きする攻撃を軽減するのに役立ちます。`__Host-` はクッキーをドメインロックするのに役立ちます。クッキーは `Secure` 属性と `Path` 属性を `/` に設定し、 `Domain` 属性を持たず、安全な場所から送信される必要があります。一方、`__Secure-`はクッキーが `Secure` 属性のみを持ち、安全な場所から送信されることを要求します。

​<figure>
  <table>
    <thead>
      <tr>
        <th>クッキーの種類</th>
        <th>`__Secure`</th>
        <th>`__Host`</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ファーストパーティ</td>
        <td class="number">0.02%</td>
        <td class="number">0.01%</td>
      </tr>
      <tr>
        <td>サードパーティ</td>
        <td class="number">< 0.01%</td>
        <td class="number">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルでの `__Secure` と `__Host` の Cookieプレフィックスの使用について。", sheets_gid="1757682198", sql_file="cookie_attributes.sql") }}</figcaption>
</figure>

どちらの接頭辞もクッキーのかなり低い割合で使われていますが、`__Secure-`は前提条件が低いため、ファーストパーティークッキーでより一般的に見られます。

### クッキー寿命

永続的なクッキーは、`Expires`属性で指定された日付、または`Max-Age`属性で指定された期間の経過後に削除されます。`Expires` と `Max-Age` の両方が設定されている場合、 `Max-Age` が優先されます。

{{ figure_markup(
  image="security-cookie-age-usage-by-site-in-mobile-in-days.png",
  caption="クッキー使用日数（モバイル）。",
  description="さまざまなパーセンタイルで、クッキーの使用期間を日数で棒グラフにしました。10パーセンタイルでは、`Max-Age`が0で、`Expires`が0の場合、実際の最大寿命は0のままです。 10パーセンタイルでは、2つの値で30日と14日という値は、実際の寿命が ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1433212880&format=interactive",
  sheets_gid="237010912",
  sql_file="cookie_age_percentiles.sql"
  )
}}

`Max-Age` を持つクッキーの約20.5%が31,536,000という値を持っていることから、中央値の `Max-Age` は365日であることがわかります。しかし、ファーストパーティークッキーの64.2%は `Expires`を持ち、23.3%は `Max-Age` を持ちます。クッキーの間では`Expires`がずっと優勢なので、実際の最大寿命の中央値は、期待されるように`Max-Age`ではなく`Expires`（180日）と同じになっています。

## コンテンツ搭載

ほとんどのWebサイトでは、多くのメディアやCSS、JavaScriptライブラリが、さまざまな外部ソース、CDN、クラウドストレージサービスから読み込まれています。どのソースのコンテンツが信頼できるかを確認することは、Webサイトのセキュリティだけでなく、Webサイトのユーザーのセキュリティにとっても重要です。そうでなければ、信頼できないコンテンツが読み込まれた場合、ウェブサイトはクロスサイトスクリプティング攻撃にさらされる可能性があります。

### コンテンツセキュリティポリシー

[_コンテンツセキュリティポリシー_](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP) (CSP) は、さまざまなコンテンツの読み込みを許可するオリジンを制限することにより、クロスサイトスクリプティングやデータインジェクション攻撃を緩和するために使用される主要な方法です。ウェブサイトには、さまざまな種類のコンテンツのソースを指定するために使用できる数多くのディレクティブがあります。たとえば、`script-src` はスクリプトを読み込むことができるオリジンやドメインを指定するために使用されます。また、インラインスクリプトと `eval()` 関数が許可されているかどうかを定義するための値も持っています。

{{ figure_markup(
  image="security-csp-directives-usage.png",
  caption="CSPで使用されるもっとも一般的なディレクティブ。",
  description="もっとも一般的なCSPディレクティブの使用状況を示す棒グラフ。`upgrade-insecure-requests`がデスクトップで57.6%、モバイルでは57.1%ともっとも多く、次いで`frame-ancestors`がデスクトップで54.4%、モバイルでは55.8%となっています。`block-all-mixed-content`はデスクトップで29.9%、モバイルでは30.7%、`default-src`はデスクトップで18.4%、モバイルでは16.8%、 `script-src` はデスクトップで17.2%、モバイルでは16.7%、 `style-src` はデスクトップで13.8% 、モバイルで12.7%です。 また、 `img-src` はデスクトップで11.8%、モバイルでは10.4% 、 `font-src` はデスクトップで9.8%、モバイルでは8.2%、 `object-src` はデスクトップで8.3%、モバイルでは8.9%、 `connect-src` はデスクトップで8.5%、モバイルでは7.2% です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1763321291&format=interactive",
  sheets_gid="50437608",
  sql_file="csp_directives_usage.sql",
  width=600,
  height=425
  )
}}

モバイル向けホームページでは、昨年の7.2%から9.3%がCSPを使用しており、ますます多くのウェブサイトがCSPを使用し始めていることがわかります。`upgrade-insecure-requests`は、引き続きもっとも頻繁に使用されているCSPです。このポリシーの採用率が高いのは、[昨年](../2020/security#content-security-policy)と同じ理由によるものと思われます。これは簡単でリスクの少ないポリシーで、すべてのHTTPリクエストをHTTPSへアップグレードするのに役立ち、またページで使用されている混合コンテンツをブロックするのにも役に立ちます。`frame-ancestors`は、ページを埋め込むことができる有効な親を定義するのを助ける、僅差で2番目のものです。

コンテンツの読み込み元を定義するポリシーの採用は、依然として低い水準にとどまっています。これらのポリシーのほとんどは、破損を引き起こす可能性があるため、実装がより困難になっています。外部コンテンツを許可するための`nonce`、ハッシュ、ドメインなどを定義するために、実装に労力を要するのです。

厳格なCSPは攻撃に対する強力な防御となりますが、ポリシーの定義が正しくない場合、望ましくない効果をもたらし有効なコンテンツが、ロードされなくなることがあります。異なるライブラリやAPIがさらにコンテンツを読み込むと、これはさらに難しくなります。

<a hreflang="en" href="https://web.dev/csp-xss/">Lighthouse</a> は最近、CSPにそのようなディレクティブがない場合に重大度警告のフラグを立て、XSS攻撃を防ぐためにより厳しいCSPを採用するよう奨励するようになりました。CSPがXSS攻撃の阻止にどのように役立つかは、この章の[攻撃の阻止](#CSPによるXSS攻撃の阻止) のセクションで詳しく説明します。

ウェブ開発者がCSPポリシーの正しさを評価できるように、非強化の代替案もあります。これは、`Content-Security-Policy-Report-Only`応答ヘッダーでポリシーを定義することによって有効になります。このヘッダーの普及率はまだかなり低く、モバイルでは0.9%です。しかし、ほとんどの場合、このヘッダーはテスト段階で追加され、後に強制CSPへ置き換えられるので使用率の低さは予想外ではありません。

サイトは `report-uri` ディレクティブを使用して、CSPエラーを解析できる特定のリンクにCSP違反を報告することもできます。これらは、CSPディレクティブが追加された後に、有効なコンテンツが新しいディレクティブによって偶然にブロックされていないかどうかをチェックするのに役に立ちます。この強力なフィードバック・メカニズムの欠点は、ブラウザの拡張機能や、ウェブサイト所有者がコントロールできないその他の技術によって、CSP報告がノイズになる可能性があることです。

{{ figure_markup(
  image="security-csp-header-length.png",
  caption="CSPヘッダーの長さ。",
  description="CSPヘッダーの長さをバイト単位でパーセンタイル表示した棒グラフ。10パーセンタイルではデスクトップとモバイルともに23バイト、25パーセンタイルではともに25バイト、50パーセンタイルではともに75バイト、75パーセンタイルではともに75バイト、90パーセンタイルではデスクトップが389バイト、モバイルが305バイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1605401039&format=interactive",
  sheets_gid="1485136639",
  sql_file="csp_number_of_allowed_hosts.sql"
) }}

CSPヘッダーの長さの中央値は75バイトと、かなり短い状態が続いています。ほとんどのWebサイトでは、長い厳密なCSPの代わりに、特定の目的のために単一のディレクティブがまだ使用されています。たとえば、24.2%のウェブサイトは `upgrade-insecure-requests` ディレクティブのみを持っています。

{{ figure_markup(
  caption="観測された最長のCSPのバイト数。",
  content="43,488",
  classes="big-number",
  sheets_gid="150007358",
  sql_file="csp_number_of_allowed_hosts.sql"
)
}}

一方、最長のCSPヘッダーは、昨年の2倍近い長さになっています。43,488バイトです。

<figure>
  <table>
    <thead>
      <tr>
        <th>オリジン</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="CSP ポリシーでもっとも頻繁に許可されるホスト。", sheets_gid="1000160612", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>

`*-src` ディレクティブでもっともよく使われるオリジンは、引き続きGoogleが大きく占めています（フォント、広告、分析）。また、今年はCloudflareの人気ライブラリCDNが10位に表示されています。

### サブリソースの整合性

多くのWebサイトでは、JavaScriptライブラリやCSSライブラリを外部のCDNから読み込んでいます。これは、CDNが侵害されたり、攻撃者が頻繁に使用されるライブラリを置き換える他の方法を見つけたりした場合、特定のセキュリティ上の意味を持つことがあります。_サブリソースの整合性_（SRI）は、そのような結果を回避するのに役立ちますが、悪意のない変更でそのリソースがないとウェブサイトが、機能しない可能性がある場合は他のリスクが発生します。可能であれば、サードパーティからロードするのではなく、セルフホスティングすることが、より安全な選択肢となります。

{{ figure_markup(
  caption="携帯電話のSRIにSHA384ハッシュ関数を使用。",
  content="66.2%",
  classes="big-number",
  sheets_gid="1707924242",
  sql_file="sri_hash_functions.sql"
)
}}

ウェブ開発者は、ウェブサイトにJavaScriptやCSSのコードを含めるために使われる `<script>` と `<link>` タグに `integrity` 属性を追加できます。`integrity` 属性は、リソースの期待される内容のハッシュ値からなる。ブラウザは取得したコンテンツのハッシュと `integrity` 属性に記述されたハッシュを比較してその妥当性を確認し、一致した場合にのみリソースをレンダリングできます。

```html

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>

```

ハッシュは `SHA256`、`SHA384`、`SHA512` の3種類のアルゴリズムで計算される。現在、もっとも利用されているのは `SHA384` (モバイルでは66.2%) であり、次いで `SHA256` (モバイルでは31.1%) となっています。現在、この3つのハッシュアルゴリズムはすべて安全に使用できると考えられています。

{{ figure_markup(
  caption="モバイル向け`<script>`要素に含まれるSRIの割合。",
  content="82.6%",
  classes="big-number",
  sheets_gid="1477693041",
  sql_file="sri_usage.sql"
)
}}

ここ数年、SRIの利用がやや増加しており、デスクトップで17.5%、モバイルでは16.1%の要素にintegrity属性が含まれています。そのうち82.6%は、モバイルの `<script>` 要素に含まれています。

{{ figure_markup(
  image="security-subresource-integrity-coverage-per-page.png",
  caption="サブリソースの整合性：1ページあたりのカバー率。",
  description="ページ上のスクリプトの何パーセントがSRIで保護されているかをパーセンテージで示した棒グラフです。10パーセンタイルではデスクトップとモバイルのリクエストの1.4%、25パーセンタイルではそれぞれ2.1%と2.2%、50パーセンタイルではどちらも3.3%、75パーセンタイルではどちらも5.6%、90パーセンタイルではどちらも10.0%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1691901696&format=interactive",
  sheets_gid="247865608",
  sql_file="sri_coverage_per_page.sql"
) }}

しかし、`<script>`要素については、まだ少数派の選択肢です。ウェブサイト上の `<script>` 要素で `integrity` 属性を持つものの割合の中央値は、3.3%です。

<figure>
  <table>
    <thead>
      <tr>
        <th>ホスト</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="SRIで保護されたスクリプトが含まれるもっとも一般的なホスト。", sheets_gid="303199583", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

SRIで保護されたスクリプトが含まれる一般的なホストのうち、そのほとんどがCDNで構成されていることがわかります。異なるライブラリを使用する場合、複数のウェブサイトで使用される非常に一般的なCDNが3つあります。<a hreflang="en" href="https://code.jquery.com/">jQuery</a>、<a hreflang="en" href="https://cdnjs.com/">cdnjs</a>と<a hreflang="en" href="https://www.bootstrapcdn.com/">Bootstrap</a>。これら3つのCDNが、サンプルのHTMLコードにintegrity属性を備えているのは、おそらく偶然ではないでしょう。開発者がサンプルを使ってこれらのライブラリを埋め込むとき、SRIで保護されたスクリプトが読み込まれていることを確認することになります。

### パーミッションポリシー

最近のブラウザは、トラッキングや悪意のある目的に使用できる無数のAPIや機能を提供しており、ユーザーのプライバシーに悪影響を与えることが判明しています。<a hreflang="en" href="https://www.w3.org/TR/permissions-policy-1/">_パーミッションポリシー_</a> は、ウェブサイトが自身のフレームや埋め込んだiframe内のブラウザ機能の使用を許可またはブロックする機能を提供するウェブプラットフォームAPIです。

`Permissions-Policy`レスポンスヘッダーにより、ウェブサイトはどの機能を使用したいか、また悪用を制限するためにウェブサイト上でどの強力な機能を禁止したいかを決定できます。パーミッションポリシーは、ジオロケーション、ユーザーメディア、ビデオ自動再生、暗号化メディアデコードなどのAPIを制御するために使用できます。これらのAPIのいくつかは、ユーザーからのブラウザの許可を必要としますが、悪意のあるスクリプトはユーザーが許可のポップアップを取得せずにマイクをオンにすることはできません、ウェブサイトが必要としない場合、特定の機能の使用を完全に制限するために許可ポリシーを使用することは依然として良い習慣です。

このAPI仕様は、以前は_フィーチャーポリシー_として知られていましたが、名称が変更されただけでなく、他にも多くの更新が行われています。この`Feature-Policy`レスポンスヘッダーはまだ使用されていますが、モバイル向けウェブサイトの0.6%しか使用していません。`Permissions-Policy` レスポンスヘッダーには、異なるAPIに対する許可リストが含まれています。たとえば、`Permissions-Policy: geolocation=(self "https://example.com")` は、自身のオリジンと "`https://example.com`"オリジン以外のGeolocation APIの利用を許可しないことを意味します。たとえば、`Permissions-Policy: geolocation=()`のように、空のリストを指定することで、ウェブサイトでのAPIの使用を完全に無効にすることができる。

モバイルサイトでは、すでに1.3%のサイトが`Permissions-Policy`を使用していることが確認されています。この新しいヘッダーの使用率が予想以上に高い理由として、一部のウェブサイトの管理者が、ユーザーのプライバシーを保護するためにコホートのフェデレート学習または <a hreflang="en" href="https://privacysandbox.com/proposals/floc">FLoC</a>（Chromeで実験的に実装）のオプトアウトを選択している可能性が挙げられます。[プライバシーの章](./privacy#floc)に詳しい分析が載っています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ディレクティブ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="フレームにおける `allow` 指令の普及率。", sheets_gid="623004240", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

また、`<iframe>` 要素の `allow` 属性を使用すると、埋め込みフレームで使用することを許可されている機能を有効または無効にできます。モバイルの1080万フレームの28.4%が、許可や機能のポリシーを有効にするため`allow`属性を含んでいます。

例年通り、iframeの`allow` 属性でもっとも使用されているディレクティブは、埋め込みビデオやメディアのコントロールに関連するものです。もっともよく使われるディレクティブは、引き続き `encrypted-media` で、これは暗号化メディア拡張APIへのアクセスを制御するために使用されます。

### Iframeサンドボックス

iframe内に信頼できない第三者が存在すると、そのページに対してさまざまな攻撃を仕掛けることができます。たとえば、トップページをフィッシングページに誘導したり、偽のアンチウイルス広告を表示するポップアップを起動したり、その他のクロスフレームスクリプティング攻撃を行うことができます。

iframeの`sandbox`属性は、コンテンツに制限をかけるため、埋め込まれたWebページから攻撃を仕掛ける機会を減らすことができます。属性の値は、すべての制限を適用する場合は空、特定の制限を解除する場合はスペースで区切られたトークンのいずれかになります（いくつかの制限を挙げると埋め込みページはJavaScriptコードを実行できず、フォームは送信できず、ポップアップを作成できません）。広告やビデオなどのサードパーティーコンテンツをiframeで埋め込むことは、ウェブ上では一般的な行為であり、その多くが`sandbox`属性によって制限されていることは驚くことでありません。デスクトップ用ページのiframeの32.6%が `sandbox` 属性を持っており、モバイル用ページでは32.6%となっています。

{{ figure_markup(
  image="security-prevalence-of-sandbox-directives-on-frames.png",
  caption="フレームに対するサンドボックスディレクティブの普及率。",
  description="フレーム内のサンドボックスディレクティブの普及率を示す棒グラフ。`allow-scrips` と `allow-same-origin` がもっともよく使われるディレクティブで、 `sandbox` 属性を持つiframeのほぼ100%がこれらのディレクティブを使用しています。`allow-popups` はデスクトップの83%、モバイルの87%のフレームで見つかり、 `allow-forms` はデスクトップの81%、モバイルの85%のフレームで見つかり、 `allow-popups-to-escape-sandbox` はデスクトップの80%、モバイルの84%のフレームで見つかっています。`allow-top-navigation-by-user-activation` はデスクトップで57%、モバイルでは62%、 `allow-top-navigation` はデスクトップで22%、モバイルでは20%、 `allow-modals` はデスクトップで21%、モバイルでは20%のフレームが検出されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1054574782&format=interactive",
  sheets_gid="1104685300",
  sql_file="iframe_sandbox_directives.sql",
  width=600,
  height=425
  )
}}

もっともよく使われるディレクティブは `allow-scripts` で、デスクトップページのすべてのサンドボックスポリシーの99.98%に存在し、埋め込みページがJavaScriptコードを実行することを許可しています。もう1つのディレクティブは事実上すべてのサンドボックスポリシーに存在する `allow-same-origin` で、埋め込みページがそのオリジンを保持し、たとえば、そのオリジンに設定されたクッキーへアクセスすることを許可します。

## 攻撃を阻止する

ウェブアプリケーションは、複数の攻撃に対して脆弱である可能性があります。幸いある種の脆弱性を防ぐメカニズムがいくつか存在します（たとえば、<a hreflang="en" href="https://pragmaticwebsecurity.com/articles/securitypolicies/preventing-framing-with-policies.html">クリックジャッキング攻撃に対抗する</a> には`X-Frame-Options`や、CSPの`frame-ancestors`ディレクティブによるフレーム保護が必要です）、あるいは攻撃の結果を制限することが可能です。これらの保護機能のほとんどはオプトイン方式であるため、ウェブ開発者が適切なレスポンスヘッダーを設定することで有効化する必要があります。大規模な場合、ヘッダーの存在は、ウェブサイトのセキュリティ衛生状態や、開発者がユーザーを保護するインセンティブについて、何かを教えてくれるかもしれません。

### セキュリティ機能の採用

{{ figure_markup(
  image="security-adoption-of-security-headers.png",
  caption="モバイルページにおけるサイトリクエストのセキュリティヘッダーの採用。",
  description="2021年と2020年のモバイルページにおける、同一ドメイン下でのあらゆるリクエストに対する、さまざまなセキュリティヘッダーの普及率を示す棒グラフです。`X-Content-Type-Options` 2020年で30.0%、2021年では36.6%、 `X-Frame-Options` 2020年で27.0%、2021年では29.4%、 `Strict-Transport-Security` 2020年で17.4%、2021年では22.9%、 `X-XSS-Protection` 2020年で18.4%、2021年では20.0%、 `Expect-CT` 2020年で11.1%、2021年では13.4%、`Content-Security-Policy` 2020年で10.9%、2021年では12.8%、`Report-To` 2020年で2.5%、2021年では11.9%、`Referrer-Policy` 2020年で7.3%、2021年では10.0%、`Feature-Policy` 2020年で0.5%、2021年では0.6%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1380470049&format=interactive",
  sheets_gid="285299680",
  sql_file="security_headers_prevalence.sql",
  width=600,
  height=497
) }}

本章でもっとも有望かつ明るい発見は、おそらく、セキュリティ機構の一般的な採用が増え続けていることです。これは、攻撃者が特定のウェブサイトを悪用するのがより困難になることを意味するだけでなく、より多くの開発者が、自分たちが構築するウェブ製品のセキュリティを重視していることを示すものです。全体として、昨年と比較して、セキュリティ機能の採用が10～30%相対的に増加していることがわかります。セキュリティ関連の仕組みでもっとも導入が進んでいるのは、<a hreflang="en" href="https://developers.google.com/web/updates/2018/09/reportingapi">the Reporting API</a> の `Report-To` ヘッダーで、導入率は2.6%から12.2%と、ほぼ4倍に増加しています。

このように、セキュリティ機構の採用率が上昇し続けていることは注目に値しますが、まだまだ改善の余地は残されています。もっとも広く利用されているセキュリティメカニズムは、依然として `X-Content-Type-Options` ヘッダーであり、モバイルでクロールしたウェブサイトの36.6% でMIMEスニッフィング攻撃から保護するために利用されています。このヘッダーに続くのは、`X-Frame-Options`ヘッダーで、全サイトの29.4%で有効になっています。興味深いことに、CSPのより柔軟な`frame-ancestors`ディレクティブを使用しているウェブサイトは、わずか5.6%に過ぎません。

もう1つの興味深いのは、[`X-XSS-Protection`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/X-XSS-Protection)ヘッダーの進化です。この機能は、レガシーブラウザのXSSフィルターを制御するために使用されます。<a hreflang="en" href="https://blogs.windows.com/windows-insider/2018/07/25/announcing-windows-10-insider-preview-build-17723-and-build-18204/">Edge</a>と<a hreflang="en" href="https://www.chromium.org/developers/design-documents/xss-auditor">Chrome</a>は意図しない新たな脆弱性をもたらす恐れがあるとして、XSSフィルターをそれぞれ2018年7月、2019年8月に引退させたそうです。しかし、`X-XSS-Protection`ヘッダーは昨年より8.5%も多いことがわかりました。

### `<meta>` 要素で有効な機能

レスポンスヘッダーを送信することに加えて、いくつかのセキュリティ機能は `<meta>` 要素に `name` 属性を `http-equiv` に設定するとHTMLレスポンスボディで有効にできます。セキュリティ上の理由から、この方法で有効にできるポリシーは限られています。より正確には、コンテンツセキュリティポリシーとリファラーポリシーのみが `<meta>` タグで設定できます。それぞれ、0.4%と2.6%のモバイルサイトがこの方法でメカニズムを有効にしていることがわかりました。

{{ figure_markup(
  caption="`X-Frame-Options`を`<meta>`タグに記述しているが、実際にはブラウザに無視されているサイトの数。",
  content="3,410",
  classes="big-number",
  sheets_gid="1578698638",
  sql_file="meta_policies_allowed_vs_disallowed.sql"
)
}}

他のセキュリティ機構が`<meta>`タグで設定されている場合、ブラウザはこれを実際に無視します。興味深いことに、3,410のサイトが `<meta>` タグを使って `X-Frame-Options` を有効にしようとしており、その結果、クリックジャック攻撃から守られているという誤った認識を抱いていたことがわかりました。同様に、数百のウェブサイトが、セキュリティ機能をレスポンスヘッダーの代わりに`<meta>`タグへ記述することで導入に失敗しました（`X-Content-Type-Options`: 357, `X-XSS-Protection`: 331, `Strict-Transport-Security`: 183）。

### CSPによるXSS攻撃の阻止

CSPは、クリックジャック攻撃、混合コンテンツの取り込みの防止、コンテンツを取り込む信頼できるソースの決定（[上](#コンテンツセキュリティポリシー)で述べたとおり）など、多数のものから守るために使用できます。

さらに、XSS攻撃から身を守るために必要不可欠な仕組みです。たとえば、制限的な `script-src` ディレクティブを設定することで、ウェブ開発者はアプリケーションのJavaScriptコードだけが実行されるようにできます（攻撃者のコードは実行されません）。さらに、DOMベースのクロスサイトスクリプティングを防御するために、<a hreflang="ja" href="https://web.dev/i18n/ja/trusted-types/">_信頼できるタイプ_</a> を使うことができます。これは、CSPの[`require-trusted-types-for`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/require-trusted-types-for) ディレクティブを使って有効にすることが可能です。

<figure>
  <table>
    <thead>
      <tr>
        <th>キーワード</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="`default-src` または `script-src` ディレクティブを定義するポリシーに基づく CSP キーワードの普及率です。", sheets_gid="948114503", sql_file="csp_script_source_list_keywords.sql") }}</figcaption>
</figure>

CSPの採用は全体的に緩やかな増加（17％）ですが、それ以上に興味深いのは、`strict-dynamic`とnoncesの利用が同じ傾向を維持しているか、わずかに増加していることです。たとえば、デスクトップサイトでは、`strict-dynamic`の使用率が2.4%[昨年](../2020/security#CSPによるXSS攻撃の防止)から、今年は5.2%に増加しました。同様に、noncesの使用率も8.7%から12.1%に増加しています。

一方、問題の多いディレクティブである `unsafe-inline` と `unsafe-eval` の使用率は、まだかなり高いことがわかります。しかし、これらが `strict-dynamic` と共に使用されている場合、モダンブラウザはこれらの値を無視し、 `strict-dynamic` をサポートしていない古いブラウザは引き続きウェブサイトを使用することができることに留意すべきです。

### XS-Leaksに対する防御

Web開発者が[Spectre](https://ja.wikipedia.org/wiki/Spectre)のような攻撃などのマイクロアーキテクチャ攻撃や、一般に <a hreflang="en" href="https://xsleaks.dev">XS-Leaks</a> と呼ばれる攻撃からWebサイトを防御できるように、さまざまな新しいセキュリティ機能を導入しています。これらの攻撃の多くがここ数年で発見されたものであることを考えると、それらに対処するためのメカニズムも明らかにごく最近のものであり、これが比較的低い普及率の理由かもしれません。とはいえ、[昨年](../2020/security#defending-against-xs-leaks-with-cross-origin-policies)と比較すると、クロスオリジンポリシーの採用が大幅に増えています。

リソースをどのように含めるか（クロスオリジン、同一サイト、同一オリジン）をブラウザへ示すために使用される[`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cross-Origin_Resource_Policy_(CORP)) は、 [昨年](../2020/security#defending-against-xs-leaks-with-cross-origin-policies)1,712サイトから106,443サイト (1.5%)で存在することがわかりました。この理由としてもっとも考えられるのは、<a hreflang="ja" href="https://web.dev/i18n/ja/cross-origin-isolation-guide/">クロスオリジンの分離</a>が `SharedArrayBuffer` やハイレゾタイマーなどの機能を使うために必要で、それにはサイトの [`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy)を`require-corp`に設定する必要があるからだと思われます。要するに、これらの機能を使いたいサイトのために、ロードされたすべてのサブリソースに `Cross-Origin-Resource-Policy` レスポンスヘッダーを設定することを要求しているのです。

その結果、<a hreflang="en" href="https://github.com/cdnjs/cdnjs/issues/13782">several</a> <a hreflang="en" href="https://github.com/jsdelivr/bootstrapcdn/issues/1495">CDN</a> は現在、ヘッダーの値を `cross-origin` に設定します（CDNのリソースは通常クロスサイトのコンテキストに含まれるべきものだからです）。CORPヘッダーの値を`cross-origin`に設定しているサイトは96.8%であるのに対し、`same-site`に設定しているサイトは2.9%、より限定的な`same-origin`を使用しているサイトは0.3%であり、これは実際にそうであるということがわかります。

この変化に伴い、`Cross-Origin-Embedder-Policy`の採用が着実に増えているのは当然のことです。2021年には、911サイトがこのヘッダーを有効にし、昨年の6サイトを大幅に上回りました。来年、これがさらにどのように発展していくのか、興味深いところです。

最後に、もう1つのXS-Leak対策ヘッダーである[`Cross-Origin-Opener-Policy`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy)も昨年と比較して大幅に増加しています。現在、このセキュリティ機構を有効にしているサイトは15,727件で、特定のXS-Leak攻撃から保護されているサイトが31件しかなかった昨年と比較すると、大幅に増加していることがわかりました。

### ウェブ暗号化API

Web開発において、セキュリティは中心的な課題の1つとなっています。<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">ウェブ暗号化API</a> W3C勧告は2017年に導入され、クライアントサイドでサードパーティのライブラリなしで基本的な暗号操作（ハッシュ、署名生成・検証、暗号化・復号化など）を実行できるようになりました。このJavaScript APIの利用状況を分析しました。

<figure>
  <table>
    <thead>
      <tr>
        <th>暗号化API</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="よく使われる暗号API", sheets_gid="749853824", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

機能の人気は前年とほぼ同じで71.8％から72.5％へと0.7％の微増にとどまっています。今年も `Cypto.getRandomValues` がもっとも人気のある暗号化APIです。開発者は強力な擬似乱数を生成することができる。Google Analyticsのスクリプトがこの機能を利用しているため、やはりGoogle Analyticsの影響が大きいと思われます。

なお、受動的なクローリングを行っているため、機能実行前に何らかのインタラクションが必要なケースを特定できず、本節の結果は限定的なものとなっています。

### ボット対策サービスの活用

多くのサイバー攻撃は自動化されたボット攻撃に基づいており、それに対する関心も高まっているようです。Imperva社の<a hreflang="en" href="https://www.imperva.com/blog/bad-bot-report-2021-the-pandemic-of-the-internet/">2021年の悪意のあるBotレポート</a>によると、今年に入ってから悪質ボットの数が25.6%増加したとのことです。なお、2019年から2020年の増加率は、<a hreflang="en" href="https://www.imperva.com/blog/bad-bot-report-2020-bad-bots-strike-back/">前回のレポート</a>によると24.1%となっています。以下の表では、悪意あるボットからの防御のために、ウェブサイトがどのような対策をとっているかについての結果を示しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>サービスプロバイダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="ボット対策サービスのプロバイダー別利用状況。", sheets_gid="798151334", sql_file="bot_detection.sql") }}</figcaption>
</figure>

当社の分析によると、悪意のあるボットと戦うためのメカニズムを使用しているのは、デスクトップWebサイトの10.7％未満、モバイルWebサイトの9.9％未満であることがわかりました。昨年は8.3%、7.3%でしたので、前年比で約30%増加しています。今年も、モバイル版よりもデスクトップ版の方がボット対策の仕組みが多く確認されています（10.8％対9.9％）。

また、我々のデータセットでは、ボット保護プロバイダーとして新たに人気のあるプレーヤーが見られます（例：hCaptcha）。

## セキュリティメカニズム採用のドライバー

Webサイトがセキュリティ対策に投資する背景には、さまざまな影響が考えられます。そのような要因の例としては社会的なもの（例：特定の国でよりセキュリティ志向の教育が行われている、またはデータ侵害の場合により懲罰的な措置を取る法律）、技術的なもの（例：特定の技術スタックでセキュリティ機能を採用することが容易または特定のベンダーがデフォルトでセキュリティ機能を有効にする）、または脅威ベースのもの（例：広く普及しているウェブサイトは、知名度が低いウェブサイトより標的型攻撃に直面するかもしれない）などがあります。このセクションでは、これらの要因がセキュリティ機能の採用にどの程度影響するかを評価しようとします。

### ウェブサイトの訪問者はどこから来るか

{{ figure_markup(
  image="security-adoption-of-https-per-country.png",
  caption="国ごとのHTTPSの採用状況。",
  description="各国の関連サイトを対象に、HTTPSを有効にしているサイトの割合を示した棒グラフです。スイス、ニュージーランド、アイルランド、オーストラリア、オランダ、オーストリア、ベルギー、イギリス、南アフリカ、スウェーデンの順で、97%から94%となっています。一方、マレーシア、トルコ、イラン、ブラジル、インドネシア、ベトナム、タイ、台湾、韓国、日本は76%から72%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1261041561&format=interactive",
  sheets_gid="269550966",
  sql_file="feature_adoption_by_country.sql",
  width="600",
  height="617"
) }}

デフォルトでHTTPSを採用するのが全般的に進んでいることがわかりますが、訪問者の出身国によって、サイト間の採用率にばらつきがあります。

[昨年と比較して](../2020/security#サイトの訪問者の国)、オランダがトップ5に入ったことがわかり、オランダ人はトランスポート層攻撃に対して比較的保護されていることがわかります。オランダの人々が頻繁に訪れるサイトの95.1％がHTTPSを有効にしています（昨年は93.0％）。実際、オランダだけでなく、ほぼすべての国でHTTPSの導入が進んでいることがわかります。

また、昨年は最悪の結果だったいくつかの国が大きく躍進したことは、非常に心強いことです。たとえば、イラン（HTTPSの普及率がもっとも高かった国）の人々が訪問したサイトは、昨年と比較して13.4%も多くHTTPSに対応しています（74.3%から84.3%）。もっとも導入が進んでいる国ともっとも進んでいない国の差は小さくなってきていますが、まだ大きな努力が必要です。

{{ figure_markup(
  image="security-adoption-of-csp-and-xfo-per-country.png",
  caption="国ごとのCSPとXFOの採用状況。",
  description="棒グラフは、ニュージーランドがCSP21.2%、XFO39.6%、オーストラリアCSP20.5%、XFO37.9%、アイルランドCSP19.4%、XFO39.8%、カナダCSP18.7%、XFO33.5%、米国CSP17.5%、XFO30.4%です。下はカザフスタンがCSP6.4%、XFO21.4%、ベラルーシCSP5.5%、XFO20.8%、ウクライナCSP5.0%、XFO18.2%、ロシアCSP4.7%、XFO19.8%、そして日本CSP3.6%、XFO17.2%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=2039992568&format=interactive",
  sheets_gid="269550966",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=598
) }}

CSPや `X-Frame-Options` などの特定のセキュリティ機能の採用状況を見ると、国によってさらに顕著な違いがあり、成績上位の国のサイトは成績下位の国に比べて、これらのセキュリティ機能を採用する傾向が2～4倍も高いことが分かっています。また、HTTPSの採用率が高い国は、他のセキュリティメカニズムの採用率も高い傾向にあることがわかります。これは、セキュリティはしばしば全体的に考えられ、さまざまな角度からカバーする必要があることを示しています。攻撃者は、悪用可能な脆弱性を1つ見つけるだけでよいのに対して、開発者は、あらゆる側面が確実に保護されていることを確認する必要があります。

### Technology stack

<figure>
  <table>
    <thead>
      <tr>
        <th>技術紹介</th>
        <th>デフォルトで有効なセキュリティ機能</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>オートマティック (PaaS)</td>
        <td>Strict-Transport-Security (97.8%)</td>
      </tr>
      <tr>
        <td>ブロガー（ブログ）</td>
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
  <figcaption>{{ figure_link(caption="さまざまな技術によるセキュリティ機能の採用。", sheets_gid="1386880960", sql_file="feature_adoption_by_technology.sql") }}</figcaption>
</figure>

特定のセキュリティメカニズムの採用に強く影響するもう1つの要因は、ウェブサイトを構築するために使用されている技術スタックです。場合によってはセキュリティ機能がデフォルトで有効になっていたり、ブログシステムによっては、レスポンスヘッダーに対する制御がウェブサイト所有者の手を離れ、プラットフォーム全体のセキュリティ設定が行われていたりすることがあります。

また、CDNは、とくにトランスポートのセキュリティに関わる場合、追加のセキュリティ機能を追加することがあります。上の表では、少なくとも25,000のサイトで使用され、特定のセキュリティメカニズムの採用率が著しく高い9つのテクノロジーをリストアップしました。たとえば、Shopifyのeコマースシステムで構築されたサイトでは、7つのセキュリティ関連ヘッダー（`Content-Security-Policy`, `Expect-CT`, `Report-To`, `Strict-Transport-Security`, `X-Content-Type-Options`, `X-Frame-Options` と`X-XSS-Protection`）の適用率が非常に高く（95%以上）なっていることが見て取れるでしょう。

{{ figure_markup(
  caption="Shopifyサイトでの採用率が95％を超えるセキュリティ機能の数々。",
  content="7",
  classes="big-number",
  sheets_gid="1386880960",
  sql_file="feature_adoption_by_technology.sql"
)
}}

これらの技術を使用するコンテンツにばらつきがあるにもかかわらず、これらのセキュリティ機構を統一的に採用することが可能であることは、素晴らしいことだと思います。

{{ figure_markup(
  caption="DrupalサイトがデフォルトのXFOヘッダーを保持している割合です。",
  content="83.1%",
  classes="big-number",
  sheets_gid="1386880960",
  sql_file="feature_adoption_by_technology.sql"
)
}}

このリストのもう1つの興味深い項目はDrupalで、そのウェブサイトでは`X-Frame-Options`ヘッダーの採用率が83.1%でした（昨年の81.8%と比較して若干改善されています）。このヘッダーは<a hreflang="en" href="https://www.drupal.org/node/2735873">デフォルトで有効</a>なので、Drupalサイトの大多数がこれを使用し、クリックジャック攻撃から守っていることは明らかです。近い将来、古いブラウザとの互換性のために `X-Frame-Options` ヘッダーを残すことは理にかなっていますが、サイトオーナーは同じ機能を持つ推奨の `Content-Security-Policy` ヘッダーディレクティブ `frame ancestors` への移行を検討すべきことに留意してください。

セキュリティ機能の採用の文脈で探るべき重要な点は、多様性です。たとえば、Cloudflareは最大のCDNプロバイダーであり、何百万ものウェブサイトを支えています（これに関するさらなる分析については、[CDN](./cdn)の章を参照してください）。Cloudflareがデフォルトで有効にする機能は、全体として大きな採用率になります。実際、`Expect-CT`機能を採用しているサイトの98.2%はCloudflareによって提供されており、このメカニズムの採用がかなり限定的な分布であることを示しています。

しかし、全体的に見ると、DrupalやCloudflareのような単一のアクターがセキュリティ機能の採用を技術的に牽引するという現象は異常値であり、時間の経過とともに少なくなっているように見受けられます。これは、ますます多様化するウェブサイトがセキュリティ機構を採用し、より多くのウェブ開発者がその利点を認識するようになっていることを意味します。たとえば、昨年はコンテンツセキュリティポリシーを設定したサイトの44.3%がShopifyによるものでしたが、今年はCSPを有効にしたサイト全体の32.9%がShopifyによるものにとどまっています。一般的に普及率が高まっていることと合わせると、これは素晴らしいニュースです。

### ウェブサイトの人気度

多くの人が訪れるWebサイトでは、潜在的な機密情報を持つユーザーが多く、攻撃者が集まりやすいため、標的型攻撃に遭いやすいと考えられます。したがって、多くの人が訪れるウェブサイトは、ユーザーを保護するために、より多くのセキュリティ投資を行うことが予想されます。この仮説が成り立つかどうかを評価するために、実際のユーザーデータを使って、どのウェブサイトがもっとも訪問されているかを調べる[Chromeユーザー体験レポート](./methodology#chrome-ux-report) が提供するランキング（上位1000、1万、10万、100万とデータセット内の全サイトでランキング）を使用しました。

{{ figure_markup(
  image="security-prevalence-of-headers-in-sites-by-rank.png",
  caption="ファーストパーティコンテキストに設定されたセキュリティヘッダーのランク別普及率。",
  description="棒グラフは、上位1,000サイトのうち、54.8%がXFO、50.7%がHSTS、22.2%がCSPヘッダーであることを示しています。上位10,000サイトでは、XFOが48.3%、HSTS41.0%、CSPヘッダー17.9%となっています。10万位以内では、XFOが44.3%、HSTS34.5%、CSPヘッダー14.2%。100万位以内では、38.8%がXFO、27.8%がHSTS、13.4%がCSPヘッダーを採用している。全サイトでは、XFOが29.4%、HSTS22.9%、CSP12.8%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1353621848&format=interactive",
  sheets_gid="1156119511",
  sql_file="security_adoption_by_rank.sql"
  )
}}

X-Frame-Options (XFO)、Content Security Policy (CSP)、Strict Transport Security (HSTS) という特定のセキュリティ機能の採用が、サイトのランキングに大きく関係していることがわかります。たとえば、アクセス数の多い1,000のサイトでは、全体の採用率と比較して、あるセキュリティヘッダーを採用する割合が約2倍になっています。また、各機能の採用率は、ランキング上位のサイトほど高いことがわかります。

一方では、より多くの訪問者を集めるサイトでより優れた「セキュリティ衛生」を実現すれば、より多くのユーザー（よく知られた信頼できるサイトと個人データを共有する傾向がある）の利益につながるということです。一方、訪問者の少ないサイトでのセキュリティ機能の採用率が低いのは、これらの機能を（正しく）実装するためには、まだかなりの投資が必要であることを示しているのかもしれません。小規模なWebサイトでは、この投資が必ずしも有効であるとは限りません。願わくは、特定のテクノロジースタックで、デフォルトで有効になっているセキュリティ機能がさらに増え、ウェブ開発者がそれほど努力しなくても多くのサイトのセキュリティがさらに強化されることを期待します。

## ウェブ上での不正行為

暗号通貨は、現代の社会でますます身近な存在になっています。世界的な暗号通貨の普及は、パンデミック発生当初から<a hreflang="en" href="https://blog.chainalysis.com/reports/2021-global-crypto-adoption-index">急増しています</a>。その経済的な効率性から、サイバー犯罪者も暗号通貨に関心を持つようになりました。そのため、新たな攻撃ベクトルが生まれたのです。[クリプトジャッキング](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%B8%E3%83%A3%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0)です。攻撃者は、[WebAssembly](./webassembly)の力を発見し、ウェブサイト訪問者がウェブサイト上でサーフィンしている間に暗号通貨をマイニングするために悪用されています。

そこで、Web上でのクリプトマイナーの利用状況について、次の図に示すような調査結果を得た。

{{ figure_markup(
  image="security-cryptominer-usage.png",
  caption="クリプトマイナーの使用方法。",
  description="2020年1月から2021年8月までのクリプトジャッキングスクリプト搭載サイト数の推移を示す時系列チャート。当初はデスクトップ500サイト、モバイル606サイトだったのが、最終的にはデスクトップ827サイト、モバイル983サイトと増加傾向にあり、2021年2月頃から2021年5月頃にはデスクトップ76サイト、モバイル124サイトともっとも低くなる。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1998879220&format=interactive",
  sheets_gid="1719897363",
  sql_file="cryptominer_usage.sql"
) }}

私たちのデータセットによると、最近まで、クリプトマイナーを使用したウェブサイトの数は非常に安定して減少していました。しかし、現在では、そのようなウェブサイトの数が過去2カ月間で10倍以上に増加していることが確認されています。このようなピックは、たとえば、広範なクリプトジャック攻撃が行われたときや、人気のあるJSライブラリが感染したときなど非常に典型的なものです。

次に、クリプトマイナーの市場シェアについて、次の図に示す。

{{ figure_markup(
  image="security-cryptominer-market-share.png",
  caption="クリプトマイナーの市場シェア（モバイル）。",
  description="円グラフでは、CoinImpが84.9%、Coinhive9.0%、JSEcoin3.1%、Minero.cc1.5%、その他は約1.5%のシェアを獲得していることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1688060716&format=interactive",
  sheets_gid="1998142066",
  sql_file="cryptominer_share.sql"
) }}

[Coinhive](https://en.wikipedia.org/wiki/Monero#Mining_malware)は、CoinImpに抜かれ、クリプトマイニングサービスの主流となったことがわかります。その大きな理由のひとつが、<a hreflang="en" href="https://www.zdnet.com/article/coinhive-cryptojacking-service-to-shut-down-in-march-2019/">2019年3月にCoinhiveが閉鎖されたこと</a>です。興味深いことに、このドメインは現在<a hreflang="en" href="https://www.troyhunt.com/i-now-own-the-coinhive-domain-heres-how-im-fighting-cryptojacking-and-doing-good-things-with-content-security-policies/">Troy Hunt</a>によって所有されており、Coinhiveスクリプトをまだホストしているサイト（デスクトップ: 5.7%, モバイル: 9.0%）に、しばしば彼らの知らないところでホストしていることを意識させようとウェブサイトに積極的にバナーを表示させているのだそうです。これは、Coinhiveのスクリプトが運営停止から2年以上経過しても普及していることと、サードパーティーのリソースが運営停止になった場合、引き継がれる可能性があることを反映しています。Coinhiveの消滅により、CoinImpは明らかに市場リーダー（シェア84.9%）となった。

この結果は、クリプトジャッキングが依然として深刻な攻撃ベクトルであることを示唆しており、必要な対策を講じる必要があることを示しています。

なお、これらのWebサイトのすべてが感染しているわけではありません。ウェブサイト運営者は、ウェブサイトの資金調達のために、（広告を表示する代わりに）この技術を展開することもあります。しかし、この手法の使用については、技術的、法的、倫理的にも大きく議論されています。

また、今回の結果は、クリプトジャッキングに感染したウェブサイトの実態を表していない可能性があることをご了承ください。クローラーの実行は月に1回であるため、クリプトマイナーを実行しているすべてのWebサイトを発見できるわけではありません。たとえば、あるWebサイトがX日間だけ感染したままで、私たちのクローラーが走った日には感染していない場合などがこれにあたります。

## `security.txt`

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-foudil-securitytxt-12">`security.txt`</a> は、ウェブサイトが脆弱性報告の基準を提供するためのファイル形式です。ウェブサイト提供者は、このファイルに連絡先、PGPキー、ポリシーなどの情報を記載できます。ホワイトハットハッカーは、この情報を利用して、これらのウェブサイトのセキュリティ分析を行ったり、脆弱性を報告したりできます。

{{ figure_markup(
  image="security-usage-of-well-known-security.png",
  caption="Use of `security.txt`.",
  description="デスクトップで4.9%、モバイルでは4.9%のWebサイトが`security.txt`エンドポイントを持っていることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=1958147881&format=interactive",
  sheets_gid="399976976",
  sql_file="well-known_security.sql"
  )
}}

その結果、`/.well-known/security.txt`のURLを要求したところ、5％弱のウェブサイトが応答を返していることがわかりました。しかし、これらの多くは基本的に404ページであり、ステータスコード200を誤って返しているため、使用率はもっと低いと思われます。

{{ figure_markup(
  image="security-usage-of-properties-in-well-known-security.png",
  caption="security.txtのプロパティを使用する。",
  description="バーチャートは、`security.txt`のさまざまなプロパティの使用を示しています。 デスクトップで0.4%、モバイルでは0.3%の `security.txt` ファイルが署名されており、`Canonical` はデスクトップで2.8%、モバイルでは2.7%、`Encryption` はデスクトップで2.6%、モバイルでは2.1%、`Expires` はデスクトップで0.9%、モバイルでは0.7%、`Policy` はデスクトップで6.5% 、モバイルでは6.4% で使用されていることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR38ZfiZXxdGuzG4ywCEPKIU1Wl6E2bZwcQPyALavGq5q948gmWb8sT-Xo5T6K5z8smKPg6EKxV0JUI/pubchart?oid=644563241&format=interactive",
  sheets_gid="399976976",
  sql_file="well-known_security.sql"
  )
}}

`Policy` は `security.txt` ファイルでもっとも使用されているプロパティですが、それでも `security.txt` のURLを持つサイトの6.4%でしか使用されていないことがわかります。このプロパティには、ウェブサイトの脆弱性開示ポリシーへのリンクが含まれており、研究者が従うべき報告慣習を理解するのに役立ちます。ほとんどのファイルが `Policy` 値を持つことが予想されるため、このプロパティは `security.txt` の実際の使用状況のより良い指標となるでしょう。つまり、すべてのサイトのうち、上記の5％ではなく、0.3％に近い数の「本物の」`security.txt` ファイルが、存在する可能性があるということです。

もう1つの興味深い点は、この「本物の」security.txt URLのサブセットだけを見ると、Tumblrが63%～65%の使用率を占めていることです。これらのドメインでは、デフォルトでTumblrの連絡先情報に設定されているようです。これは、単一のプラットフォームがこれらの新しいセキュリティ機能の採用を促進できることを示す一方で、実際のサイト利用がさらに減少していることを示す素晴らしいことです。

その他によく使われるプロパティは `Canonical` と `Encryption` です。`Canonical` は `security.txt` ファイルがどこにあるのかを示すために使用されます。もし `security.txt` ファイルを取得するために使用したURIが `Canonical` フィールドのリストURIと一致しない場合は、ファイルの内容を信頼すべきではありません。`Encryption`はセキュリティ研究者へ暗号化された通信に使用するための暗号鍵を提供します。

## 結論

当社の分析によると、プロバイダー側に関するWebセキュリティの状況は、以前と比較して改善されていることがわかります。たとえば、HTTPSの利用は、過去12か月で10％近く増加していることがわかります。また、クッキーの保護やセキュリティヘッダーの使用も増えていることがわかります。

これらの増加は、私たちがより安全なウェブ環境に移行していることを示していますが、今日の私たちのウェブが十分に安全であることを意味するものではありません。まだまだ改善しなければならないことがあります。たとえば、私たちは、ウェブコミュニティがセキュリティヘッダーをもっと重視すべきであると考えています。これらは、ウェブ環境やユーザーを攻撃から守るために非常に有効な拡張機能です。

また、悪意のあるボットからプラットフォームを保護するために、ボット保護機構をより多く採用できます。さらに[昨年](../2020/security#ソフトウェアアップデートの実践) の私たちの分析や、HTTP Archiveデータセットを用いた<a hreflang="en" href="https://www.researchgate.net/publication/349027860_Our_inSecure_Web_Understanding_Update_Behavior_of_Websites_and_Its_Impact_on_Security">update behavior of websites</a> に関する別の研究では、ウェブサイトのコンポーネントが熱心にメンテナンスされておらず、ウェブ環境の攻撃表面を増大させていることが示されました。

また、攻撃者は、私たちが採用しているセキュリティの仕組みを回避するために、新しい技術の開発に熱心に取り組んでいることも忘れてはならない。

この分析によって、私たちのウェブのセキュリティの概要を結晶化することを試みました。私たちの調査は広範囲におよびますが、私たちの方法論では、現代のウェブセキュリティのすべての側面のサブセットを見ることができるだけです。たとえば、_クロスサイトリクエストフォージェリ_（CSRF）や_クロスサイトスクリプティング_（XSS）のような攻撃を軽減・防止するためにサイトが採用している追加措置についてはわかりません。このように、この章で描かれた絵は不完全なものですが、今日のWebセキュリティの状況を示す確かな方向性を示しています。

この分析から得られることは、私たちウェブコミュニティはより良くより安全な明日のために、ウェブ環境をより安全にするため、より多くの関心と資源を投資し続けなければならないということです。
