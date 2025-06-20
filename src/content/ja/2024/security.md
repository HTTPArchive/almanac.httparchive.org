---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: セキュリティ
description: 2024年版Web Almanacのセキュリティの章です。トランスポート・レイヤー・セキュリティ、コンテンツインクルージョン（CSP、Feature Policy、SRI）、ウェブ防御メカニズム（XSS、XS-Leaksへの対策）、セキュリティメカニズム採用の推進要因について解説します。
hero_alt: Web Almanacのキャラクターがウェブページに南京錠をかけているヒーローイメージ。他のWeb Almanacのキャラクターはボルトカッターを持った覆面の泥棒を取り押さえています。
authors: [GJFR, vikvanderlinden]
reviewers: [lord-r3, AlbertoFDR, clarkio]
analysts: [JannisBush]
editors: [cqueern]
translators: [ksakae1216]
GJFR_bio: Gertjan Frankenは、KU Leuvenの<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet研究グループ</a>の博士研究員です。彼の研究はウェブのセキュリティとプライバシーのさまざまな側面に及び、とくにブラウザのセキュリティポリシーの自動分析に焦点を当てています。この研究の一環として、バグのライフサイクルを特定するためのオープンソースツール<a hreflang="en" href="https://github.com/DistriNet/BugHog">BugHog</a>を維持しています。
vikvanderlinden_bio: Vik Vanderlindenは、KU Leuvenの<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet研究グループ</a>のコンピュータサイエンス博士課程の学生です。彼の研究はウェブとネットワークのセキュリティに焦点を当てており、とくにウェブアプリケーションとプロトコルにおけるタイミングリークに重点を置いています。
results: https://docs.google.com/spreadsheets/d/1b9IEGbfQjKCEaTBmcv_zyCyWEsq35StCa-dVOe6V1Cs/
featured_quote: 将来、新たな攻撃が出現し、新たな保護が求められることは間違いないが、健全な解決策を開発する上で、セキュリティコミュニティのオープン性が重要な役割を果たします。
featured_stat_1: 98%
featured_stat_label_1: HTTPSを使用するリクエストの割合
featured_stat_2: +27%
featured_stat_label_2: Content-Security-Policyヘッダーの採用の増加
featured_stat_3: 23%
featured_stat_label_3: サブリソース完全性を使用しているデスクトップサイトの割合
doi: 10.5281/zenodo.14065805
---

## はじめに

現代の私たちの生活が、連絡を取り合ったり、ニュースを追ったり、オンラインで商品を購入したり、あるいは販売したりと、いかにオンライン上で行われているかを考えると、ウェブセキュリティはかつてないほど重要になっています。残念ながら、私たちがこれらのオンラインサービスに依存すればするほど、悪意のある攻撃者にとって、それらはより魅力的なものになっていきます。これまで何度も見てきたように、私たちが依存するシステムのたった1つの弱点が、サービスの中断や個人データの盗難、あるいはそれ以上の事態を招く可能性があります。過去2年間も例外ではなく、<a hreflang="en" href="https://blog.cloudflare.com/ddos-threat-report-for-2024-q2/">サービス妨害(DoS)攻撃</a>、<a hreflang="en" href="https://www.imperva.com/resources/resource-library/reports/2024-bad-bot-report/">悪意のあるボット</a>、そして<a hreflang="en" href="https://www.darkreading.com/vulnerabilities-threats/rising-tide-of-software-supply-chain-attacks">ウェブを標的としたサプライチェーン攻撃</a>がかつてないほど増加しています。

この章では、今日のウェブサイトで採用されている保護策とセキュリティ慣行を分析することで、ウェブセキュリティの現状を詳しく見ていきます。[トランスポート・レイヤー・セキュリティ(TLS)](#トランスポートセキュリティ)、[クッキー保護の仕組み](#クッキー)、サードパーティの[コンテンツのインクルージョン](#コンテンツのインクルージョン)に対する保護策といった主要な分野を探求します。これらのセキュリティ対策がどのように攻撃を防ぐのに役立つかを議論し、それらを損なう可能性のある[設定ミス](#セキュリティの構成ミスと見落とし)にも焦点を当てます。さらに、有害な[クリプトマイナー](#ウェブ上の不正行為)の蔓延と[`security.txt`](#securitytxt)の利用状況についても調査します。

また、[セキュリティ対策導入の推進要因](#セキュリティメカニズム採用の推進要因)を調査し、国、ウェブサイトのカテゴリ、技術スタックなどの要素が導入されているセキュリティ対策に影響を与えるかどうかを分析します。[2022年版Web Almanac](../2022/security)の調査結果と今年の調査結果を比較することで、主要な変化を浮き彫りにし、長期的な傾向を評価します。これにより、ウェブセキュリティ慣行の進化と長年にわたる進歩について、より広い視野を提供できます。

## トランスポートセキュリティ

[HTTPS](https://developer.mozilla.org/ja/docs/Glossary/HTTPS)は、トランスポート・レイヤー・セキュリティ(<a hreflang="en" href="https://www.cloudflare.com/en-gb/learning/ssl/transport-layer-security-tls/">TLS</a>)を使用して、クライアントとサーバー間の接続を保護します。ここ数年でTLSを使用するサイトの数は飛躍的に増加しました。例年同様、TLSの採用は増加し続けましたが、100%に近づくにつれてその増加は鈍化しています。

{{ figure_markup(
  content="98%",
  caption="HTTPSを使用するリクエストの割合。",
  classes="big-number",
  sheets_gid="1492186909",
  sql_file="https_request_over_time.sql",
) }}

2022年の前回Almanac以降、TLSを使用して提供されるリクエストの数はさらに4%上昇し、モバイルでは98%になりました。

{{ figure_markup(
  image="https-usage.png",
  caption="HTTPSを使用しているホストの割合。",
  description="積み上げ棒グラフは、デスクトップサイトの96%がHTTPSを使用し、残りの4%がHTTPを使用しているのに対し、モバイルサイトの96%がHTTPSを使用し、残りの4%がHTTPを使用していることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=305355771&format=interactive",
  sheets_gid="715077736",
  sql_file="home_page_https_usage.sql"
  )
}}

モバイルでHTTPSを介して配信されるホームページの数は、89%から95.6%に増加しました。この割合がHTTPSで配信されるリクエスト数より低いのは、ウェブサイトが読み込むサードパーティリソースの数が多く、それらがHTTPSで配信される可能性が高いためです。

### プロトコルのバージョン

長年にわたり、TLSの複数の新しいバージョンが作成されてきました。安全を維持するためには、最新バージョンのTLSを使用することが重要です。最新バージョンは<a hreflang="en" href="https://www.cloudflare.com/en-in/learning/ssl/why-use-tls-1.3/">TLS1.3</a>で、しばらくの間、推奨バージョンとなっています。TLS1.2と比較して、バージョン1.3は、1.2に含まれていた特定の欠陥が見つかった一部の暗号プロトコルを廃止し、完全な前方秘匿性を強制します。古いバージョンのTLSのサポートは、主要なブラウザベンダーによってとうの昔に削除されています。HTTP/3の基礎となるプロトコルであるQUIC(Quick UDP Internet Connections)もTLSを使用し、TLS1.3と同様のセキュリティ保証を提供します。

{{ figure_markup(
  image="tls-versions.png",
  caption="使用されているTLSバージョンの分布。",
  description="積み上げ棒グラフは、デスクトップでは73%のサイトが `TLSv1.3` を使用し、19%が `TLSv1.2` を、8%が `QUIC` を使用していることを示しています。モバイルでは、それぞれ72%、18%、10%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1913163011&format=interactive",
  sheets_gid="18287010",
  sql_file="tls_versions_pages.sql"
  )
}}

TLS1.3はウェブページの73%でサポートされ、使用されていることがわかります。QUICが2022年と比較して大幅に利用されるようになり、モバイルページの0%からほぼ10%に移行したにもかかわらず、TLS1.3全体の利用は増加しています。TLS1.2の利用は予想通り減少し続けています。前回のAlmanacと比較すると、モバイルページでは12%以上減少し、TLS1.3は2%強増加しました。TLS1.2の利用が減少し続けるにつれて、QUICの採用は増加し続けると予想されます。

ほとんどのウェブサイトはTLS1.2から直接QUICに移行するのではなく、QUICを使用しているほとんどのサイトはTLS1.3から移行し、他のサイトはTLS1.2からTLS1.3に移行したため、TLS1.3の成長が限定的に見えると想定しています。

### 暗号スイート

クライアントとサーバーが通信する前に、使用する<a hreflang="en" href="https://learn.microsoft.com/en-au/windows/win32/secauthn/cipher-suites-in-schannel">暗号スイート</a>として知られる暗号アルゴリズムについて合意する必要があります。前回同様、98%以上のリクエストは、<a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">パディング攻撃</a>に対して脆弱でないため、もっとも安全なオプションと見なされているガロア/カウンターモード ([GCM](https://ja.wikipedia.org/wiki/Galois/Counter_Mode)) 暗号を使用して提供されています。また、128ビットキーを使用するリクエストが約79%であることも変わりなく、これはGCMモードのAESにとって依然として安全なキー長と見なされています。アクセスしたページで使用されているスイートはほんの一握りです。TLS1.3は<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">GCMやその他の最新のブロック暗号モードのみをサポート</a>しており、<a hreflang="en" href="https://go.dev/blog/tls-cipher-suites">暗号スイートの順序付け</a>も簡素化されています。

{{ figure_markup(
  image="cipher-suites.png",
  caption="使用されている暗号スイートの分布。",
  description="デバイスごとに使用される暗号スイートを示す積み上げ棒グラフ。`AES_128_GCM`がもっとも一般的で、デスクトップサイトの79%、モバイルサイトの79%で使用されています。`AES_256_GCM`はデスクトップサイトの20%、モバイルサイトの20%で使用されています。`AES_256_CBC`はデスクトップサイトの1%、モバイルサイトの1%で使用されています。`CHACHA20_POLY1305`はそれぞれ0%と0%のサイトで使用され、`AES_128_CBC`はそれぞれ0%と0%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=783511328&format=interactive",
  sheets_gid="251336291",
  sql_file="tls_cipher_suite.sql"
  )
}}

TLS1.3は[前方秘匿性](https://ja.wikipedia.org/wiki/Forward_secrecy)を必須としているため、ウェブ上で広くサポートされています。前方秘匿性とは、使用中の鍵が漏洩した場合でも、その鍵を使用して接続上で送受信された将来または過去のメッセージを復号できないことを保証する機能です。これは、長期的なトラフィックを保存している攻撃者が、鍵を漏洩させたとたんに会話全体を復号できないようにするために重要です。興味深いことに、前方秘匿性の使用は今年、約2%低下し、95%になりました。

{{ figure_markup(
  image="forward-secrecy.png",
  caption="前方秘匿性をサポートするリクエストの割合。",
  description="モバイルとデスクトップの両方で95%のリクエストが前方秘匿性を使用していることを示す積み上げ棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1563776541&format=interactive",
  sheets_gid="849531701",
  sql_file="tls_forward_secrecy.sql"
  )
}}

### 認証局

TLSを使用するためには、サーバーはまず、<a hreflang="en" href="https://www.ssl.com/faqs/what-is-a-certificate-authority/">認証局</a>(CA)によって作成された、ホストできる証明書を取得する必要があります。信頼できるCAの1つから証明書を取得することにより、その証明書はブラウザによって認識され、ユーザーは安全な通信のためにその証明書、ひいてはTLSを使用できます。

<figure>
  <table>
    <thead>
      <tr>
        <th>発行者</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>R3</td>
        <td class="numeric">44.3%</td>
        <td class="numeric">45.1%</td>
      </tr>
      <tr>
        <td>GTS CA 1P5</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">6.6%</td>
      </tr>
      <tr>
        <td>E1</td>
        <td class="numeric">4.2%</td>
        <td class="numeric">4.3%</td>
      </tr>
      <tr>
        <td>Sectigo RSA Domain Validation Secure Server CA</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>R10</td>
        <td class="numeric">2.6%</td>
        <td class="numeric">2.8%</td>
      </tr>
      <tr>
        <td>R11</td>
        <td class="numeric">2.6%</td>
        <td class="numeric">2.8%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>cPanel, Inc. Certification Authority</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Cloudflare Inc ECC CA-3</td>
        <td class="numeric">1.5%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Amazon RSA 2048 M02</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">1.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="特定の発行者が発行した証明書を使用しているサイトの割合。", sheets_gid="1458082974", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

R3（<a hreflang="en" href="https://letsencrypt.org/">Let's Encrypt</a>からの中間証明書）は、昨年と比較して使用量が減少したものの、依然として首位を維持しています。また、Let's Encryptからは、E1、R10、R11の中間証明書があり、それらを使用するウェブサイトの割合は増加しています。

<a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html">R3とE1は2020年に発行され、有効期間は5年のみ</a>です。つまり、<a hreflang="en" href="https://crt.sh/?id=3334561879">2025年9月に失効</a>します。中間証明書の失効の約1年前に、Let's Encryptは古い証明書から徐々に引き継ぐ新しい中間証明書を発行します。<a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html">この3月、Let's Encryptは新しい中間証明書を発行しました</a>。これには、有効期間が3年のみのR10とR11が含まれます。後者の2つの証明書はR3から直接引き継がれ、来年のAlmanacに反映されるはずです。

Let's Encryptが発行する証明書の数の増加に伴い、他の現在のトップ10プロバイダーは、モバイルで0%近くから6.5%以上に上昇したGTS CA 1P5を除いて、発行された証明書のシェアが減少しています。もちろん、私たちの分析時にCAが中間証明書の切り替え過程にあった可能性があり、その場合、反映されているよりも多くのサイトにサービスを提供している可能性があります。

{{ figure_markup(
  content="56%",
  caption="モバイルでLet's Encryptが発行した証明書を使用しているページの割合。",
  classes="big-number",
  sheets_gid="1458082974",
  sql_file="tls_ca_issuers_pages.sql",
) }}

Let's Encryptのすべての証明書の使用を合計すると、現在使用されている証明書の56%以上を発行していることがわかります。

### HTTP Strict Transport Security

[HTTP Strict Transport Security (HSTS)](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security)は、サーバーがブラウザに、このドメインでホストされているページにアクセスするにはHTTPSのみを使用すべきであることを伝えるために使用できるレスポンスヘッダーで、最初にHTTPでアクセスしてリダイレクトに従う代わりに使用します。

{{ figure_markup(
  content="30%",
  caption="モバイルでHSTSヘッダーを持つリクエストの割合。",
  classes="big-number",
  sheets_gid="1943916698",
  sql_file="hsts_attributes.sql",
) }}

現在、モバイルのレスポンスの30%がHSTSヘッダーを持っており、これは2022年と比較して5%の増加です。ヘッダーのユーザーは、ヘッダー値にディレクティブを追加することで、ブラウザに指示を伝えることができます。`max-age`ディレクティブは必須です。これはブラウザに、ページをHTTPS経由でのみ訪問し続けるべき時間を秒単位で示します。

{{ figure_markup(
  image="hsts-directives.png",
  caption="指定されたHSTSディレクティブの使用法。",
  description="さまざまなHSTSディレクティブの相対的な使用状況の縦棒グラフ。`Zero max-age`はデスクトップとモバイルの両方でウェブサイトの5%で使用されています。`Valid max-age`はデスクトップとモバイルの両方でウェブサイトの95%で使用されています。`includeSubdomains`はデスクトップでウェブサイトの37%、モバイルでウェブサイトの35%で使用されています。`preload`はモバイルとデスクトップの両方でウェブサイトの18%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1511073784&format=interactive",
  sheets_gid="1943916698",
  sql_file="hsts_attributes.sql"
  )
}}

有効な`max-age`を持つリクエストの割合は95%で変わっていません。他のオプションのディレクティブ（`includeSubdomains`と`preload`）は、2022年と比較してそれぞれ1%わずかに増加し、モバイルでは35%と18%になりました。[HSTS仕様の一部ではない](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security)`preload`ディレクティブは、`includeSubdomains`を設定する必要があり、また1年以上（または31,536,000秒）の`max-age`を必要とします。

{{ figure_markup(
  image="hsts-max-age.png",
  caption="パーセンタイル別のHSTS max-age値の分布。",
  description="max-age属性の値をパーセンタイルで示した棒グラフ（日に変換）。10パーセンタイルではデスクトップとモバイルの両方で30日、25パーセンタイルではデスクトップで183日、モバイルで182日、50パーセンタイルでは両方で365日、75パーセンタイルでは両方で365日、90パーセンタイルでは両方で730日です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=897035311&format=interactive",
  sheets_gid="1216364866",
  sql_file="hsts_max_age_percentiles.sql"
  )
}}

有効な`max-age`値の分布は2022年とほぼ同じままで、例外としてモバイルの10パーセンタイルが72日から30日に減少しました。`max-age`の中央値は1年のままです。

## クッキー

ウェブサイトは、ユーザーのブラウザにHTTPクッキーを設定することで、少量のデータを保存できます。クッキーの属性に応じて、そのウェブサイトへの後続のすべてのリクエストと共に送信されます。そのため、クッキーは暗黙の認証、追跡、またはユーザー設定の保存の目的で使用できます。

クッキーがユーザー認証に使用される場合、不正使用から保護することがもっとも重要です。たとえば、攻撃者がユーザーのセッションクッキーを手に入れると、被害者のアカウントにログインできる可能性があります。

<a hreflang="en" href="https://owasp.org/www-community/attacks/csrf">クロスサイトリクエストフォージェリ(CSRF)</a>、<a hreflang="en" href="https://owasp.org/www-community/attacks/Session_hijacking_attack">セッションハイジャック</a>、<a hreflang="en" href="https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/11-Client_Side_Testing/13-Testing_for_Cross_Site_Script_Inclusion">クロスサイトスクリプトインクルージョン(XSSI)</a>、<a hreflang="en" href="https://xsleaks.dev/">クロスサイトリーク</a>などの攻撃からユーザーを保護するために、ウェブサイトは認証クッキーを安全に設定することが求められます。

### クッキーの属性

以下に概説する3つのクッキー属性は、前述の攻撃に対する認証クッキーのセキュリティを強化します。理想的には、開発者はすべての属性を使用することを検討すべきです。これらは補完的な保護層を提供するためです。

{{ figure_markup(
  image="cookie-attributes-desktop.png",
  caption="クッキー属性（デスクトップ）。",
  description="デスクトップサイトで使用されるクッキー属性をファーストパーティとサードパーティのクッキーで分けた棒グラフ。ファーストパーティでは`HttpOnly`が42%、`Secure`が44%、`SameSite`が59%使用されているのに対し、サードパーティでは`HttpOnly`が20%、`Secure`が96%、`SameSite`が94%使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=827181104&format=interactive",
  sheets_gid="1849762871",
  sql_file="cookie_attributes.sql"
  )
}}

#### `HttpOnly`

この属性を設定することにより、JavaScriptの`document.cookie` APIを介してクッキーにアクセスしたり操作したりすることができなくなります。これにより、<a hreflang="en" href="https://owasp.org/www-community/attacks/xss/">クロスサイトスクリプティング(XSS)</a>攻撃が、秘密のセッショントークンを含むクッキーにアクセスするのを防ぎます。

デスクトップのファーストパーティコンテキストで`HttpOnly`属性を持つクッキーの割合は42%で、2022年と比較して6%増加しました。サードパーティリクエストに関しては、使用率は1%減少しました。

#### `Secure`

ブラウザは`Secure`属性を持つクッキーを、HTTPではなくHTTPSなどの安全な暗号化されたチャネル経由でのみ送信します。これにより、中間者攻撃者がクッキーに保存されている機密性の高い値を傍受して読み取ることができなくなります。

`Secure`属性の使用は、年々着実に増加しています。2022年以降、ファーストパーティコンテキストで7%、サードパーティコンテキストで6%のクッキーがこの属性で設定されています。セキュリティの章の以前の版で議論したように、2つのコンテキスト間の採用の大きな違いは、主に`SameSite=None`を持つサードパーティクッキーも`Secure`としてマークする必要があるという要件によるものです。これは、望ましい非デフォルト機能を有効にするための追加のセキュリティ前提条件が、セキュリティ機能の採用の効果的な推進力であることを浮き彫りにしています。

#### `SameSite`

もっとも最近導入されたクッキー属性`SameSite`は、クッキーがサードパーティリクエストに含まれることを許可するかどうかを開発者が制御できるようにします。これは、CSRFのような攻撃に対する追加の防御層として意図されています。

属性は、`Strict`、`Lax`、`None`の3つの値のいずれかに設定できます。`Strict`値を持つクッキーは、クロスサイトリクエストから完全に除外されます。`Lax`に設定すると、クッキーはナビゲーションGETリクエストなどの特定の条件下でのみサードパーティリクエストに含まれ、POSTリクエストには含まれません。`SameSite=none`を設定すると、クッキーは同一サイトポリシーをバイパスし、すべてのリクエストに含まれるため、クロスサイトコンテキストでアクセス可能になります。

{{ figure_markup(
  image="same-site-cookie-attributes-desktop.png",
  caption="SameSiteクッキー属性（デスクトップ）。",
  description="SameSiteクッキー属性をファーストパーティとサードパーティで分けた棒グラフ。ファーストパーティでは、`SameSite=lax`が34%、`SameSite=strict`が2%、`SameSite=none`が23%使用され、41%にはSameSite属性がありませんでした。一方、サードパーティでは`SameSite=lax`が0.4%、`SameSite=none`が94%使用され、6%にはSameSite属性がありませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1988555622&format=interactive",
  sheets_gid="1849762871",
  sql_file="cookie_attributes.sql"
  )
}}

`SameSite`属性を持つクッキーの相対数は2022年と比較して増加しましたが、この増加は主に`SameSite=None`を設定することでクッキーが同一サイトポリシーから明示的に除外されたことに起因します。

`SameSite`属性のないすべてのクッキーは、デフォルトで`SameSite=Lax`として扱われることに注意することが重要です。その結果、ファーストパーティコンテキストで設定されたクッキーの合計75%が、事実上`Lax`に設定されているかのように扱われます。

### 接頭辞

<a hreflang="en" href="https://owasp.org/www-community/attacks/Session_fixation">セッション固定</a>攻撃は、`__Secure-`や`__Host-`のようなクッキー接頭辞を使用することで軽減できます。クッキー名が`__Secure-`で始まる場合、ブラウザはそのクッキーが`Secure`属性を持ち、暗号化された接続を介して送信されることを要求します。`__Host-`接頭辞を持つクッキーの場合、ブラウザはさらに、クッキーに`Path`属性が`/`に設定されていることと`Domain`属性が含まれていないことを義務付けます。これらの要件は、中間者攻撃や侵害されたサブドメインからの脅威からクッキーを保護するのに役立ちます。

<figure>
  <table>
    <thead>
      <tr>
        <th>クッキーの種類</th>
        <th><code>__Secure</code></th>
        <th><code>__Host</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ファーストパーティ</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td>サードパーティ</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.04%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`__Secure-`と`__Host-`接頭辞（デスクトップ）。", sheets_gid="1849762871", sql_file="cookie_attributes.sql") }}</figcaption>
</figure>

クッキー接頭辞の採用は依然として低く、デスクトップとモバイルプラットフォームの両方でこれらの接頭辞を使用しているクッキーは1%未満です。`__Secure-`接頭辞付きクッキーの唯一の前提条件である`Secure`属性を持つクッキーの採用率が高いことを考えると、これはとくに驚くべきことです。しかし、クッキーの名前を変更するには大幅なリファクタリングが必要になる可能性があり、これが開発者がこれを避ける傾向がある理由であると推測されます。

### クッキーの有効期間

ウェブサイトは、クッキーの寿命を設定することで、ブラウザがクッキーを保存する期間を制御できます。ブラウザは、`Max-Age`属性で指定された期間に達したとき、または`Expires`属性で定義されたタイムスタンプに達したときにクッキーを破棄します。どちらの属性も設定されていない場合、クッキーはセッションクッキーと見なされ、セッションが終了すると削除されます。

{{ figure_markup(
  image="cookie-age-desktop.png",
  caption="クッキーの有効期間（日数）（デスクトップ）。",
  description="さまざまなパーセンタイルでのクッキーの有効期間（日数）の使用状況を示す縦棒グラフ。10パーセンタイルでは、`Max-Age`、`Expires`、実際の有効期間が1日。25パーセンタイルでは、`Max-Age`が90日、`Expires`が60日、実際の有効期間が60日。50パーセンタイルでは、`Max-Age`が365日、`Expires`が365日、実際の有効期間が364日。75パーセンタイルでは、`Max-Age`が365日、`Expires`が365日、実際の有効期間が365日。90パーセンタイルでは、`Max-Age`、`Expires`、実際の有効期間が730日。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=675218634&format=interactive",
  sheets_gid="1897777778",
  sql_file="cookie_age_percentiles.sql"
  )
}}

クッキーの有効期間の分布は、[昨年](../2022/security#クッキーの寿命)と比較してほとんど変わっていません。しかし、それ以来、<a hreflang="en" href="https://httpwg.org/http-extensions/draft-ietf-httpbis-rfc6265bis.html#name-cookie-lifetime-limits">クッキー標準の作業草案</a>が更新され、クッキーの最大有効期間が400日に制限されました。この変更はすでに[Chrome](https://developer.chrome.com/blog/cookie-max-age-expires)とSafariで実装されています。上記のパーセンタイルに基づくと、これらのブラウザでは、観測されたすべてのクッキーの10%以上が、この400日の制限に有効期間が上限付けられています。

## コンテンツのインクルージョン

コンテンツのインクルージョンはウェブの基本的な側面であり、CSS、JavaScript、フォント、画像などのリソースをCDN経由で共有したり、複数のウェブサイトで再利用したりできます。しかし、外部やサードパーティのソースからコンテンツを取得することには、重大なリスクが伴います。管理外のリソースを参照することで、それらのサードパーティを信頼することになり、それらが悪意を持ったり、侵害されたりする可能性があります。これは、最近の<a hreflang="en" href="https://www.darkreading.com/remote-workforce/polyfillio-supply-chain-attack-smacks-down-100k-websites">侵害されたリソースが何十万ものウェブサイトに影響を与えたポリフィルのインシデント</a>のような、いわゆるサプライチェーン攻撃につながる可能性があります。したがって、コンテンツのインクルージョンを管理するセキュリティポリシーは、ウェブアプリケーションを保護するために不可欠です。

### コンテンツセキュリティポリシー

ウェブサイトは、`Content-Security-Policy`レスポンスヘッダーまたは`<meta>`タグでポリシーを定義することにより、[コンテンツセキュリティポリシー(CSP)](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)を展開することで、埋め込みコンテンツをより厳密に制御できます。CSPで利用可能な幅広いディレクティブにより、ウェブサイトは、どのリソースをどのオリジンから取得できるかをきめ細かく指定できます。

含まれるコンテンツの審査に加えて、CSPは他の目的にも役立ちます。たとえば、`upgrade-insecure-requests`ディレクティブで暗号化チャネルの使用を強制したり、`frame-ancestors`ディレクティブを使用してクリックジャッキング攻撃から保護するためにサイトをどこに埋め込むことができるかを制御したりします。

{{ figure_markup(
  content="+27%",
  caption="2022年からのContent-Security-Policyヘッダーの採用の相対的な増加。",
  classes="big-number",
  sheets_gid="238539331",
  sql_file="security_headers_prevalence.sql",
) }}

CSPヘッダーの採用率は、2022年の全ホストの15%から今年は19%に増加しました。これは27%の相対的な増加に相当します。この2年間で、相対的な増加は2022年から2023年にかけて12%、2023年から2024年にかけて14%でした。

振り返ってみると、2021年の全体的なCSP採用率はホストのわずか12%だったので、成長が着実に続いていることは心強いです。この傾向が続けば、来年のWeb AlmanacではCSPの採用率が20%を超えるという予測が示唆されています。

#### ディレクティブ

ほとんどのウェブサイトは、埋め込みリソースの制御以外の目的でCSPを利用しており、`upgrade-insecure-requests`と`frame-ancestors`ディレクティブがもっとも人気があります。

{{ figure_markup(
  image="csp-directives.png",
  caption="CSPで使用されるもっとも一般的なディレクティブ。",
  description="もっとも一般的なCSPディレクティブの使用状況を示す棒グラフ。`frame-ancestors`がもっとも一般的でデスクトップで56%、モバイルで55%、次いで`upgrade-insecure-requests`がデスクトップで54%、モバイルで56%です。`block-all-mixed-content`はデスクトップで24%、モバイルで24%、`default-src`はデスクトップで17%、モバイルで15%、`script-src`はデスクトップで17%、モバイルで15%、`style-src`はデスクトップで13%、モバイルで12%、`img-src`はデスクトップで13%、モバイルで12%、`font-src`はデスクトップで11%、モバイルで10%、`connect-src`はデスクトップで10%、モバイルで9%、`frame-src`はデスクトップで10%、モバイルで9%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=123403022&format=interactive",
  sheets_gid="1796954328",
  sql_file="csp_directives_usage.sql"
  )
}}

`upgrade-insecure-requests`を優先して廃止された`block-all-mixed-content`ディレクティブは、3番目によく使用されるディレクティブです。2020年から2021年にかけて、デスクトップで12.5%、モバイルで13.8%の相対的な使用量の減少が見られましたが、その後、2022年以降、デスクトップで年平均4.4%、モバイルで6.4%の減少に鈍化しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ポリシー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>upgrade-insecure-requests;</code></td>
        <td class="numeric">27%</td>
        <td class="numeric">30%</td>
      </tr>
      <tr>
        <td><code>block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;</code></td>
        <td class="numeric">22%</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors 'self';</code></td>
        <td class="numeric">11%</td>
        <td class="numeric">10%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっとも一般的なCSPヘッダー。", sheets_gid="176994530", sql_file="csp_most_common_header.sql") }}</figcaption>
</figure>

上位3つのディレクティブは、もっとも普及しているCSP定義の構成要素でもあります。2番目によく使用されるCSP定義には、`block-all-mixed-content`と`upgrade-insecure-requests`の両方が含まれています。これは、新しいブラウザは`upgrade-insecure-requests`が存在する場合、このディレクティブを無視するため、多くのウェブサイトが後方互換性のために`block-all-mixed-content`を使用していることを示唆しています。

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
        <td><code>upgrade-insecure-requests</code></td>
        <td class="numeric">-1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors</code></td>
        <td class="numeric">5%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td><code>block-all-mixed-content</code></td>
        <td class="numeric">-9%</td>
        <td class="numeric">-13%</td>
      </tr>
      <tr>
        <td><code>default-src</code></td>
        <td class="numeric">-9%</td>
        <td class="numeric">-6%</td>
      </tr>
      <tr>
        <td><code>script-src</code></td>
        <td class="numeric">-3%</td>
        <td class="numeric">-2%</td>
      </tr>
      <tr>
        <td><code>style-src</code></td>
        <td class="numeric">-8%</td>
        <td class="numeric">-2%</td>
      </tr>
      <tr>
        <td><code>img-src</code></td>
        <td class="numeric">-3%</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td><code>font-src</code></td>
        <td class="numeric">-4%</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td><code>connect-src</code></td>
        <td class="numeric">3%</td>
        <td class="numeric">17%</td>
      </tr>
      <tr>
        <td><code>frame-src</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">16%</td>
      </tr>
      <tr>
        <td><code>object-src</code></td>
        <td class="numeric">16%</td>
        <td class="numeric">17%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CSPディレクティブの相対的な使用量の変化。", sheets_gid="1796954328", sql_file="csp_directives_usage.sql") }}</figcaption>
</figure>

上記の表に示されている他のすべてのディレクティブは、コンテンツインクルージョンの制御に使用されます。全体として、使用法は比較的安定しています。しかし、注目すべき変更点は、`connect-src`や`frame-src`を上回る`object-src`ディレクティブの使用が増加したことです。2022年以降、`object-src`の使用はデスクトップで15.9%、モバイルで16.8%増加しました。

<!-- markdownlint-disable-next-line MD051 -->
もっとも顕著な使用量の減少の1つは、キャッチオールディレクティブである`default-src`です。この減少は、現在のページをHTTPSにHTTPアップグレードを強制したり、埋め込みを制御したりするなど、コンテンツのインクルージョン以外の目的でCSPを使用することが増えていることで説明できます。このような状況では`default-src`は適用されません。これらのディレクティブはフォールバックしないためです。このCSPの目的の変更は、[図17](#fig-17)にリストされているもっとも一般的なCSPヘッダーによって確認されます。これらはすべて2022年以降、使用が増加しています。ただし、`upgrade-insecure-requests`や`block-all-mixed-content`などのディレクティブは、これらのもっとも一般的なCSPヘッダーの一部ですが、[図18](#fig-18)に示すように、全体的には使用が少なくなっています。

#### `script-src`のキーワード

CSPのもっとも重要なディレクティブの1つは`script-src`です。ウェブサイトによって読み込まれるスクリプトを抑制することは、潜在的な攻撃者を大幅に妨害するためです。このディレクティブは、いくつかの属性キーワードとともに使用できます。

{{ figure_markup(
  image="csp-script-src-keywords.png",
  caption="CSP `script-src`キーワードの普及率。",
  description="CSP `script-src`ディレクティブにおける`nonce-`、`strict-dynamic`、`unsafe-inline`、`unsafe-eval`の使用状況を示す縦棒グラフ。`nonce-`はデスクトップとモバイルのCSPを持つウェブサイトの20%で使用されています。`strict-dynamic`はデスクトップのCSPを持つウェブサイトの10%、モバイルの9%で使用されています。`unsafe-inline`はデスクトップのCSPを持つウェブサイトの91%、モバイルの92%で使用されています。`unsafe-eval`はデスクトップとモバイルのCSPを持つウェブサイトの78%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1661557245&format=interactive",
  sheets_gid="2075772620",
  sql_file="csp_script_source_list_keywords.sql"
  )
}}

`unsafe-inline`と`unsafe-eval`ディレクティブは、CSPによって提供されるセキュリティ上の利点を大幅に低下させる可能性があります。`unsafe-inline`ディレクティブはインラインスクリプトの実行を許可し、`unsafe-eval`はeval JavaScript関数の使用を許可します。残念ながら、これらの安全でない慣行の使用は依然として広まっており、インラインスクリプトの使用と`eval`関数の使用を避けることの難しさを示しています。

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
        <td><code>nonce-</code></td>
        <td class="numeric">62%</td>
        <td class="numeric">39%</td>
      </tr>
      <tr>
        <td><code>strict-dynamic</code></td>
        <td class="numeric">61%</td>
        <td class="numeric">88%</td>
      </tr>
      <tr>
        <td><code>unsafe-inline</code></td>
        <td class="numeric">-3%</td>
        <td class="numeric">-3%</td>
      </tr>
      <tr>
        <td><code>unsafe-eval</code></td>
        <td class="numeric">-3%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CSP `script-src`キーワードの相対的な使用量の変化。", sheets_gid="2075772620", sql_file="csp_script_source_list_keywords.sql") }}</figcaption>
</figure>

しかし、`nonce-`と`strict-dynamic`キーワードの採用が増加していることは、前向きな展開です。`nonce-`キーワードを使用すると、秘密のnonceを定義でき、正しいnonceを持つインラインスクリプトのみが実行できるようになります。このアプローチは、インラインスクリプトを許可するための`unsafe-inline`ディレクティブの安全な代替手段です。`strict-dynamic`キーワードと組み合わせて使用すると、nonce付きスクリプトは任意のオリジンから追加のスクリプトをインポートすることが許可されます。このアプローチは、単一のnonce付きスクリプトを信頼できるため、開発者にとって安全なスクリプトの読み込みを簡素化し、その後、他の必要なリソースを安全に読み込むことができます。

#### 許可されたホスト

CSPは、リソースのインクルードをきめ細かく制御する詳細なポリシー言語のため、もっとも複雑なセキュリティポリシーの1つと見なされることがよくあります。

{{ figure_markup(
  image="csp-header-length.png",
  caption="CSPヘッダーの長さ。",
  description="CSPヘッダーの長さをバイト単位でパーセンタイル表示した縦棒グラフ。10パーセンタイルではデスクトップが22バイト、モバイルが23バイト、25パーセンタイルでは両方とも25バイト、50パーセンタイルではデスクトップが55バイト、モバイルが48バイト、75パーセンタイルでは両方とも75バイト、90パーセンタイルではデスクトップが504バイト、モバイルが368バイトです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1260468464&format=interactive",
  sheets_gid="1351027608",
  sql_file="csp_number_of_allowed_hosts.sql"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
観測されたCSPヘッダーの長さを確認すると、全ヘッダーの75%が75バイト以下であることがわかります。参考までに、[図17](#fig-17)に示されているもっとも長いポリシーも75バイトです。90パーセンタイルでは、デスクトップポリシーは504バイト、モバイルポリシーは368バイトに達し、多くのウェブサイトが比較的長いコンテンツセキュリティポリシーを実装する必要があることを示しています。しかし、すべてのポリシーで許可された一意のホストの分布を分析すると、90パーセンタイルでは一意のホストがわずか2つしか表示されません。

ポリシー内で許可された一意のホストの最大数は1,020で、最長のコンテンツセキュリティポリシーヘッダーは65,535バイトに達しました。しかし、後者のヘッダーは、不明な理由で多数の`,`文字が繰り返されているため、膨れ上がっています。2番目に長い有効なCSPヘッダーは33,123バイトに及びます。この異常に大きなサイズは、`adservice.google`ドメインが数百回出現し、それぞれトップレベルドメインが異なるためです。抜粋：

```
adservice.google.com adservice.google.ad adservice.google.ae …
```

これは、過度に大きなCSPヘッダーのロングテールが、コンピューターで生成された網羅的なオリジンリストによって引き起こされている可能性が高いことを示唆しています。これは特定の特殊なケースのように思えるかもしれませんが、CSPの制限を浮き彫りにしています。つまり、正規表現機能がないため、このようなケースを処理するためのより効率的でエレガントなソリューションを提供できません。ただし、ウェブサイトの実装によっては、`script-src`ディレクティブで`strict-dynamic`と`nonce-`キーワードを使用することでこの問題を解決できます。これにより、nonceで許可されたスクリプトが追加のスクリプトを読み込むことができます。

CSPヘッダーに含まれるもっとも一般的なHTTPSオリジンは、CDNから取得されるフォント、広告、その他のメディアを読み込むために使用されます。

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
  <figcaption>{{ figure_link(caption="CSPポリシーでもっとも頻繁に許可されるHTTP(S)ホスト。", sheets_gid="180799456", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>

特定のオリジンへのWebSocket接続を許可するために使用されるWSSオリジンについては、以下がもっとも一般的であることがわかりました。

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
  <figcaption>{{ figure_link(caption="CSPポリシーでもっとも頻繁に許可されるWS(S)ホスト。", sheets_gid="1790517281", sql_file="csp_allowed_host_frequency_wss.sql") }}</figcaption>
</figure>

これらのオリジンのうち2つはカスタマーサービスとチケット発行（`intercom.io`、`zopim.com`）に関連し、1つはウェブサイト分析（`hotjar.com`）に使用され、2つはソーシャルメディア（`www.livejournal.com`、`quora.com`）に関連しています。これらの5つのウェブサイトのうち4つについて、ウェブサイトのコンテンツセキュリティポリシーにオリジンを追加する方法に関する具体的な指示が見つかりました。これは、ウェブサイト管理者がサードパーティリソースを許可するためにワイルドカードを使用することを思いとどまらせるため、良い慣行と見なされます。ワイルドカードを使用すると、必要以上に広範なアクセスが許可され、セキュリティが低下するためです。

### サブリソース完全性

CSPはリソースが信頼できるオリジンからのみ読み込まれるようにするための強力なツールですが、それらのリソースが改ざんされるリスクは依然として残っています。たとえば、スクリプトが信頼できるCDNから読み込まれるかもしれませんが、そのCDNがセキュリティ侵害を受け、そのスクリプトが侵害された場合、それらのスクリプトの1つを使用しているウェブサイトも脆弱になる可能性があります。

[サブリソース完全性(SRI)](https://developer.mozilla.org/ja/docs/Web/Security/Subresource_Integrity)は、このリスクに対する保護策を提供します。`<script>`および`<link>`タグで`integrity`属性を使用することで、ウェブサイトはリソースの期待されるハッシュを指定できます。受信したリソースのハッシュが期待されるハッシュと一致しない場合、ブラウザはリソースのレンダリングを拒否し、それによってウェブサイトを潜在的に侵害されたコンテンツから保護します。

{{ figure_markup(
  content="23%",
  caption="SRIを使用しているデスクトップサイト。",
  classes="big-number",
  sheets_gid="1943101379",
  sql_file="sri_usage.sql",
) }}

SRIは、デスクトップとモバイルでそれぞれ観測された全ページの23.2%と21.3%で使用されています。これは、採用率の相対的な変化がそれぞれ13.3%と18.4%に相当します。

{{ figure_markup(
  image="sri-coverage.png",
  caption="ページごとのSRIカバレッジ。",
  description="ページごとのSRIでカバーされるスクリプトの割合をパーセンタイルで示した縦棒グラフ。10パーセンタイルではデスクトップとモバイルの両方で1.4%、25パーセンタイルではデスクトップが2.0%、モバイルが2.1%、50パーセンタイルではデスクトップとモバイルの両方で3.2%、75パーセンタイルではデスクトップが5.7%、モバイルが5.9%、90パーセンタイルではデスクトップとモバイルの両方で12.5%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=13429035&format=interactive",
  sheets_gid="359913254",
  sql_file="sri_coverage_per_page.sql"
  )
}}

サブリソース完全性の採用は停滞しているように見え、ページあたりのハッシュに対してチェックされるスクリプトの割合の中央値は、デスクトップとモバイルの両方で3.23%のままです。この数値は2022年から事実上変わっていません。

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
        <td><code>www.gstatic.com</code></td>
        <td class="numeric">35%</td>
        <td class="numeric">35%</td>
      </tr>
      <tr>
        <td><code>cdnjs.cloudflare.com</code></td>
        <td class="numeric">7%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td><code>cdn.userway.org</code></td>
        <td class="numeric">6%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td><code>static.cloudflareinsights.com</code></td>
        <td class="numeric">6%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td><code>code.jquery.com</code></td>
        <td class="numeric">5%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td><code>cdn.jsdelivr.net</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td><code>d3e54v103j8qbb.cloudfront.net</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>t1.daumcdn.net</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="SRIで保護されたスクリプトが含まれるもっとも一般的なホスト。", sheets_gid="1612151810", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

リソースが取得され、SRIによって保護されているホストのほとんどはCDNです。2022年のデータとの顕著な違いは、トップホストリストから`cdn.shopify.com`がなくなったことです（以前はデスクトップで22%、モバイルで23%）。これは、Shopifyが<a hreflang="en" href="https://shopify.engineering/shipping-support-for-module-script-integrity-in-chrome-safari#">ブログ投稿</a>で説明しているように、`importmap`の`integrity`属性によって提供される同様の機能のためにSRIを廃止したためです。

### パーミッションポリシー

[パーミッションポリシー](https://developer.mozilla.org/ja/docs/Web/HTTP/Permissions_Policy)（旧称：機能ポリシー）は、ウェブサイトがウェブページでアクセスできるブラウザ機能（位置情報、ウェブカメラ、マイクなど）を制御できるようにする一連のメカニズムです。パーミッションポリシーを使用することで、ウェブサイトはメインサイトと埋め込みコンテンツの両方の機能アクセスを制限し、セキュリティを強化し、ユーザーのプライバシーを保護できます。これは、メインサイトとそのすべての埋め込み`<iframe>`要素の`Permissions-Policy`レスポンスヘッダーを介して構成されます。さらに、ウェブ管理者は、`<iframe>`要素の`allow`属性を使用して、特定の`<iframe>`要素に個別のポリシーを設定できます。

{{ figure_markup(
  content="+1.3%",
  caption="2022年からの`Permissions-Policy`ヘッダーの採用の相対的な増加。",
  classes="big-number",
  sheets_gid="238539331",
  sql_file="security_headers_prevalence.sql",
) }}

2022年、`Permissions-Policy`ヘッダーの採用は85%という大幅な相対的増加を見せました。しかし、2022年から今年にかけて、成長率はわずか1.3%にまで大幅に鈍化しました。これは、機能ポリシーが2020年末にパーミッションポリシーに改名されたため、当初のピークに達したためと予想されます。その後数年間、このヘッダーはChromiumベースのブラウザでのみサポートされているため、成長は非常に低いままでした。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>interest-cohort=()</code></td>
        <td class="numeric">21%</td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td><code>geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()</code></td>
        <td class="numeric">5%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), autoplay=(), camera=(), cross-origin-isolated=(), display-capture=(self), encrypted-media=(), fullscreen=*, geolocation=(self), gyroscope=(), keyboard-map=(), magnetometer=(), microphone=(), midi=(), payment=*, picture-in-picture=(), publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=(), usb=(), xr-spatial-tracking=(), gamepad=(), serial=()</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(self), autoplay=(self), camera=(self), encrypted-media=(self), fullscreen=(self), geolocation=(self), gyroscope=(self), magnetometer=(self), microphone=(self), midi=(self), payment=(self), usb=(self)</code></td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()</code></td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td><code>browsing-topics=()</code></td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td><code>geolocation=self</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっとも普及しているパーミッションポリシー。", sheets_gid="2018859098", sql_file="pp_header_prevalence.sql") }}</figcaption>
</figure>

デスクトップホストの2.8%、モバイルホストの2.5%のみが`Permissions-Policy`レスポンスヘッダーを使用してポリシーを設定しています。このポリシーは、主にGoogleのFederated Learning of Cohorts (FLoC)から排他的にオプトアウトするために使用されます。`Permissions-Policy`ヘッダーを実装するホストの21%が、ポリシーを`interest-cohort=()`に設定しています。この使用は、FLoCが試用期間中に引き起こした論争に一部起因しています。FLoCは最終的にTopics APIに置き換えられましたが、`interest-cohort`ディレクティブの継続的な使用は、特定の懸念がウェブポリシーの採用をどのように形成するかを浮き彫りにしています。

少なくとも2%のホストが実装している他のすべての観測ヘッダーは、ウェブサイト自体および/またはその埋め込み`<iframe>`要素の許可機能を制限することを目的としています。コンテンツセキュリティポリシーと同様に、パーミッションポリシーは「デフォルトで安全」ではなく「デフォルトでオープン」です。ポリシーがないことは保護がないことを意味します。このアプローチは、新しいポリシーを導入する際にウェブサイトの機能を壊さないようにすることを目的としています。注目すべきは、サイトの0.28%が明示的に`*`ワイルドカードポリシーを使用しており、ウェブサイトとすべての埋め込み`<iframe>`要素（より制限的な`allow`属性が存在しない場合）が任意の許可を要求できるようにしていることです。これは、パーミッションポリシーが設定されていない場合のデフォルトの動作です。

パーミッションポリシーは、埋め込まれた各`<iframe>`の`allow`属性を介して個別に定義することもできます。たとえば、`<iframe>`は、属性を次のように設定することで、地理位置情報とカメラのアクセス許可を使用できます。

```html
<iframe src="https://example.com" allow="geolocation 'self'; camera *;"></iframe>
```

デスクトップクロールで観測された3,040万個の`<iframe>`要素のうち、35.2%に`allow`属性が含まれていました。これは、`<iframe>`要素の14.4%しか`allow`属性を持っていなかった**わずか1か月前**と比較して、大幅な増加を示しており、その使用がわずか1か月で2倍以上になったことを示しています。この急速な変化のもっともらしい説明は、1つまたは複数の広く使用されているサードパーティサービスが、この更新を`<iframe>`要素全体に伝播させたことです。現在観測されている広告固有のディレクティブ（下の表、1行目と3行目に表示）を考えると、これらは2022年には存在しなかったため、この変化の原因は広告サービスである可能性が高いです。

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
        <td><code>join-ad-interest-group</code></td>
        <td class="numeric">43%</td>
        <td class="numeric">44%</td>
      </tr>
      <tr>
        <td><code>attribution-reporting</code></td>
        <td class="numeric">28%</td>
        <td class="numeric">280%</td>
      </tr>
      <tr>
        <td><code>run-ad-auction</code></td>
        <td class="numeric">25%</td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td><code>encrypted-media</code></td>
        <td class="numeric">19%</td>
        <td class="numeric">18%</td>
      </tr>
      <tr>
        <td><code>autoplay</code></td>
        <td class="numeric">18%</td>
        <td class="numeric">18%</td>
      </tr>
      <tr>
        <td><code>picture-in-picture</code></td>
        <td class="numeric">12%</td>
        <td class="numeric">12%</td>
      </tr>
      <tr>
        <td><code>clipboard-write</code></td>
        <td class="numeric">10%</td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">9%</td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td><code>accelerometer</code></td>
        <td class="numeric">9%</td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td><code>web-share</code></td>
        <td class="numeric">7%</td>
        <td class="numeric">7%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっとも普及している`allow`属性ディレクティブ。", sheets_gid="1497012339", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

2022年と比較して、もっとも一般的なディレクティブのトップ10は、新たに導入された3つのディレクティブ、`join-ad-interest-group`、`attribution-reporting`、`run-ad-auction`が上位を占めています。最初のディレクティブと3番目のディレクティブは、GoogleのPrivacy Sandboxに固有のものです。トップ10で観測されたすべてのディレクティブについて、オリジンやキーワード（`'src'`、`'self'`、`'none'`など）と組み合わせて使用されたものはほとんどありませんでした。つまり、読み込まれたページは、そのオリジンに関係なく、指定された許可を要求できます。

### Iframeサンドボックス

`<iframe>`要素内にサードパーティのウェブサイトを埋め込むことは、ウェブアプリケーションの機能を充実させるために必要かもしれませんが、常にリスクを伴います。ウェブサイト管理者は、不正な`<iframe>`がポップアップを起動したり、トップレベルページを悪意のあるドメインにリダイレクトしたりするなど、いくつかのメカニズムを悪用してユーザーに損害を与える可能性があることを認識しておく必要があります。

これらのリスクは、`<iframe>`要素で`sandbox`属性を使用することで抑制できます。これを行うと、内部に読み込まれるコンテンツは属性で定義されたルールに制限され、埋め込みコンテンツが機能を悪用するのを防ぐために使用できます。値として空の文字列を指定すると、ポリシーはもっとも厳しくなります。ただし、このポリシーは特定のディレクティブを追加することで緩和でき、それぞれに固有の緩和ルールがあります。たとえば、次の`<iframe>`は、埋め込まれたウェブページがスクリプトを実行できるようにします。

```html
<iframe src="https://example.com" sandbox="allow-scripts"></iframe>
```

`sandbox`属性は、デスクトップとモバイルでそれぞれ`<iframe>`要素の19.9%と19.8%で観測されましたが、2022年に報告された22.1%と21.2%からわずかに減少しました。前のセクションで述べた`allow`属性使用の急増と同様に、この減少は、埋め込みサービスの運用方法の変更に起因する可能性があります。この変更では、テンプレート`<iframe>`から`sandbox`属性が省略されました。

{{ figure_markup(
  image="iframe-sandbox-directives.png",
  caption="iframeでのサンドボックスディレクティブの普及率。",
  description="iframeにおけるサンドボックスディレクティブの普及率を示す棒グラフ。`allow-scripts`はデスクトップでサンドボックス属性を持つiframeの98%、モバイルで99%で見つかりました。`allow-same-origin`はデスクトップで91%、モバイルで91%、`allow-forms`はデスクトップで82%、モバイルで80%、`allow-popups`はデスクトップで75%、モバイルで73%、`allow-popups-to-escape-sandbox`はデスクトップで74%、モバイルで72%、`allow-top-navigation-by-user-activation`はデスクトップで46%、モバイルで45%、`allow-storage-access-by-user-activation`はデスクトップで27%、モバイルで26%、`allow-top-navigation`はデスクトップで27%、モバイルで25.62%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=22462766&format=interactive",
  sheets_gid="873346022",
  sql_file="iframe_sandbox_directives.sql"
  )
}}

iframeに`sandbox`属性が設定されているページの98%以上が、`allow-scripts`ディレクティブを使用して、埋め込みウェブページでスクリプトを許可するために使用しています。

## 攻撃の防止

Webアプリケーションはさまざまな方法で悪用される可能性があります。それらを保護する方法はたくさんありますが、すべての選択肢を把握するのは難しい場合があります。この課題は、保護がデフォルトで有効になっていない、またはオプトインが必要な場合にさらに深刻になります。言い換えれば、ウェブサイト管理者は、自分たちのアプリケーションに関連する潜在的な攻撃ベクトルと、それらを防ぐ方法を認識している必要があります。したがって、どの攻撃防止策が講じられているかを評価することは、Web全体のセキュリティを評価するために不可欠です。

### セキュリティヘッダーの採用

ほとんどのセキュリティポリシーは、どのポリシーを強制するかをブラウザに指示するレスポンスヘッダーを介して設定されます。すべてのセキュリティポリシーがすべてのウェブサイトに関連しているわけではありませんが、特定のセキュリティヘッダーがないことは、ウェブサイト管理者がセキュリティ対策を検討または優先していない可能性を示唆しています。

{{ figure_markup(
  image="security-headers-desktop.png",
  caption="デスクトップページのサイトリクエストにおけるセキュリティヘッダーの採用。",
  description="2022年、2023年、2024年のリクエストにおけるセキュリティヘッダーの普及率を示す縦棒グラフ。`X-Content-Type-Options`はそれぞれ43%、46%、48%で見つかりました。`X-Frame-Options`はそれぞれ35.3%、34%、37%で見つかりました。`Strict-Transport-Security`はそれぞれ28%、31%、34%で見つかりました。`X-XSS-Protection`はそれぞれ23%、23%、23%で見つかりました。`Content-Security-Policy`はそれぞれ14%、16%、19%で見つかりました。`Referrer-Policy`はそれぞれ14%、15%、17%で見つかりました。`Report-To`はそれぞれ11%、13%、14%で見つかりました。`Permissions-Policy`はそれぞれ2.82%、2.45%、2.82%で見つかりました。`Content-Security-Policy-Report-Only`はそれぞれ2.13%、1.58%、1.83%で見つかりました。`Cross-Origin-Resource-Policy`はそれぞれ1.03%、1.31%、1.52%で見つかりました。`Cross-Origin-Opener-Policy`はそれぞれ0.23%、0.68%、1.07%で見つかりました。`Expect-CT`はそれぞれ17%、0.65%、0.71%で見つかりました。`Feature-Policy`はそれぞれ0.77%、0.65%、0.65%で見つかりました。`Cross-Origin-Embedder-Policy`はそれぞれ0.04%、0.22%、0.35%で見つかりました。`Clear-Site-Data`はそれぞれ0.01%、0.01%、0.02%で見つかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1591831239&format=interactive",
  sheets_gid="238539331",
  sql_file="security_headers_prevalence.sql",
  height=496,
  width=600
  )
}}

過去2年間で、3つのセキュリティヘッダーの使用量が減少しました。もっとも顕著な減少は、[証明書の透明性](https://developer.mozilla.org/ja/docs/Web/Security/Certificate_Transparency)にオプトインするために使用されていた[`Expect-CT`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Expect-CT)ヘッダーです。このヘッダーは、証明書の透明性がデフォルトで有効になっているため、現在では非推奨です。同様に、`Feature-Policy`ヘッダーは`Permissions-Policy`ヘッダーに置き換えられたため、使用量が減少しました。最後に、`Content-Security-Policy-Report-Only`ヘッダーも減少しました。このヘッダーは、主に、指定されたエンドポイントに違反レポートを送信することで、コンテンツセキュリティポリシーの影響をテストおよび監視するために使用されていました。`Report-Only`ヘッダーはコンテンツセキュリティポリシー自体を強制しないため、その使用量の減少はセキュリティの低下を示すものではないことに注意することが重要です。これらのヘッダーはいずれもセキュリティに影響を与えないため、セキュリティヘッダーの全体的な採用は成長し続けており、ウェブセキュリティの前向きな傾向を反映していると安全に想定できます。

2022年以降、もっとも強く絶対的に上昇したのは`Strict-Transport-Security`（+5.3%）、`X-Content-Type-Options`（+4.9%）、`Content-Security-Policy`（+4.2%）です。

### CSPと`X-Frame-Options`によるクリックジャッキングの防止

<!-- markdownlint-disable-next-line MD051 -->
前述のとおり、[コンテンツセキュリティポリシー](#コンテンツセキュリティポリシー)の主な用途の1つは、クリックジャッキング攻撃を防ぐことです。これは`frame-ancestors`ディレクティブを介して実現され、ウェブサイトはどのオリジンが自分のページをフレーム内に埋め込むことを許可するかを指定できます。そこで、このディレクティブが埋め込みを完全に禁止するか、同一オリジンに制限するために一般的に使用されていることがわかりました（[図17](#fig-17)）。

クリックジャッキングに対するもう1つの対策は、[`X-Frame-Options` (XFO)](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/X-Frame-Options)ヘッダーですが、CSPと比較してきめ細かい制御は提供されません。XFOヘッダーは`SAMEORIGIN`に設定でき、ページを同じオリジンの他のページからのみ埋め込むことを許可するか、`DENY`に設定でき、ページの埋め込みを完全にブロックします。以下の表に示すように、ほとんどのヘッダーは、同一オリジンのウェブサイトがページを埋め込むことを許可することで、ポリシーを緩和するように設定されています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>SAMEORIGIN</code></td>
        <td class="numeric">73%</td>
        <td class="numeric">73%</td>
      </tr>
      <tr>
        <td><code>DENY</code></td>
        <td class="numeric">23%</td>
        <td class="numeric">24%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`X-Frame-Options`ヘッダーの値。", sheets_gid="609220671", sql_file="xfo_header_prevalence.sql") }}</figcaption>
</figure>

非推奨ですが、観測された`X-Frame-Options`ヘッダーの0.6%（デスクトップ）と0.7%（モバイル）は、依然として`ALLOW-FROM`ディレクティブを使用しています。これは`frame-ancestors`ディレクティブと同様に機能し、ページを埋め込むことができる信頼できるオリジンを指定します。ただし、最新のブラウザは`ALLOW-FROM`ディレクティブを含む`X-Frame-Options`ヘッダーを無視するため、ウェブサイトのクリックジャッキング防御にギャップが生じる可能性があります。ただし、この慣行は、非推奨のヘッダーが`frame-ancestors`ディレクティブを含むサポートされているコンテンツセキュリティポリシーと並行して使用される、下位互換性を目的としている場合があります。

### クロスオリジンポリシーを使用した攻撃の防止

ウェブの基本原則の1つは、クロスオリジンリソースの再利用と埋め込みです。しかし、この慣行に対する私たちのセキュリティの観点は、SpectreやMeltdownのようなマイクロアーキテクチャ攻撃や、サイドチャネルを利用して潜在的に機密性の高いユーザー情報を明らかにするクロスサイトリーク（<a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a>）の出現により、大幅に変化しました。これらの脅威により、他のウェブサイトがリソースをレンダリングできるかどうか、またどのようにレンダリングできるかを制御するメカニズムの必要性が高まっています。同時に、これらの新しい悪用に対するより良い保護を確保する必要もあります。

この需要により、`Cross-Origin-Resource-Policy`（CORP）、`Cross-Origin-Embedder-Policy`（COEP）、`Cross-Origin-Opener-Policy`（COOP）という総称で知られるいくつかの新しいセキュリティヘッダーが導入されました。これらのヘッダーは、オリジン間でリソースがどのように共有および埋め込まれるかを制御することにより、サイドチャネル攻撃に対する堅牢な対策を提供します。これらのポリシーの採用は着実に増加しており、過去2年間でCross-Origin-Opener-Policyの使用は毎年ほぼ倍増しています。

{{ figure_markup(
  image="cross-origin-headers-trend.png",
  caption="2022年、2023年、2024年におけるクロスオリジンヘッダーの使用状況。",
  description="2022年、2023年、2024年のリクエストにおける`Cross-Origin-`ヘッダーの普及率を示す縦棒グラフ。`Cross-Origin-Resource-Policy`はそれぞれ1.03%、1.31%、1.52%でした。`Cross-Origin-Opener-Policy`はそれぞれ0.23%、0.68%、1.07%でした。`Cross-Origin-Embedder-Policy`はそれぞれ0.04%、0.22%、0.35%でした。`Clear-Site-Data`はそれぞれ0.01%、0.01%、0.02%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=114530565&format=interactive",
  sheets_gid="238539331",
  sql_file="security_headers_prevalence.sql",
  width=600,
  height=401
  )
}}

#### クロスオリジンエンベッダーポリシー

[クロスオリジンエンベッダーポリシー](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy)は、クロスオリジンリソースを埋め込むウェブサイトの機能を制限します。現在、ウェブサイトは`SharedArrayBuffer`や`Performance.now()` APIを介したスロットルなしのタイマーなどの強力な機能にアクセスできなくなりました。これらはクロスオリジンリソースから機密情報を推測するために悪用される可能性があるためです。ウェブサイトがこれらの機能へのアクセスを必要とする場合、ブラウザに対して、資格情報なしのリクエスト（`credentialless`）を介してクロスサイトリソースとのみ対話する意図があること、または`Cross-Origin-Resource-Policy`ヘッダー（`require-corp`）を使用して他のオリジンからのアクセスを明示的に許可するリソースとのみ対話する意図があることを通知する必要があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>COEP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">86%</td>
        <td class="numeric">88%</td>
      </tr>
      <tr>
        <td><code>require-corp</code></td>
        <td class="numeric">7%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td><code>credentialless</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="COEPヘッダー値の普及率。", sheets_gid="906872096", sql_file="coep_header_prevalence.sql") }}</figcaption>
</figure>

`Cross-Origin-Embedder-Policy`ヘッダーを設定するウェブサイトの大多数は、上記の強力な機能へのアクセスを必要としないことを示しています（`unsafe-none`）。この動作は、COEPヘッダーがない場合のデフォルトでもあり、ウェブサイトは明示的に設定しない限り、クロスオリジンリソースへのアクセスが制限された状態で自動的に動作することを意味します。

#### クロスオリジンリソースポリシー

逆に、リソースを提供するウェブサイトは、[`Cross-Origin-Resource-Policy`レスポンスヘッダー](https://developer.mozilla.org/ja/docs/Web/HTTP/Cross-Origin_Resource_Policy)を使用して、他のウェブサイトが提供されたリソースをレンダリングするための明示的な許可を与えることができます。このヘッダーは3つの値のいずれかを取ることができます。`same-site`は、同じサイトからのリクエストのみがリソースを受信できるようにします。`same-origin`は、同じオリジンからのリクエストへのアクセスを制限します。`cross-origin`は、任意のオリジンがリソースにアクセスすることを許可します。サイドチャネル攻撃を緩和するだけでなく、CORPはクロスサイトスクリプトインクルージョン（XSSI）からも保護できます。たとえば、動的なJavaScriptリソースがクロスオリジンのウェブサイトに提供されるのを禁止することで、CORPは機密情報を含むスクリプトの漏洩を防ぐのに役立ちます。

<figure>
  <table>
    <thead>
      <tr>
        <th>CORP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>cross-origin</code></td>
        <td class="numeric">91%</td>
        <td class="numeric">91%</td>
      </tr>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">5%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td><code>same-site</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CORPヘッダー値の普及率。", sheets_gid="1177421176", sql_file="corp_header_prevalence.sql") }}</figcaption>
</figure>

CORPヘッダーは、主に任意のオリジンからの提供リソースへのアクセスを許可するために使用され、`cross-origin`値がもっとも一般的に設定されています。より少ないケースでは、ヘッダーはアクセスを制限します。ウェブサイトの5%未満がリソースを同一オリジンに制限し、4%未満が同一サイトに制限しています。

#### クロスオリジンオープナーポリシー

[クロスオリジンオープナーポリシー](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy)（COOP）は、他のウェブページが保護されたページを開いたり参照したりする方法を制御するのに役立ちます。COOP保護は`unsafe-none`で明示的に無効にできますが、これはヘッダーがない場合のデフォルトの動作でもあります。`same-origin`値は、同じオリジンのページからの参照を許可し、`same-origin-allow-popups`は、ウィンドウまたはタブでの参照をさらに許可します。クロスオリジンエンベッダーポリシーと同様に、`SharedArrayBuffer`や`Performance.now()`などの機能は、COOPが`same-origin`として設定されていない限り制限されます。

<figure>
  <table>
    <thead>
      <tr>
        <th>COOP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">49%</td>
        <td class="numeric">48%</td>
      </tr>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">35%</td>
        <td class="numeric">37%</td>
      </tr>
      <tr>
        <td><code>same-origin-allow-popups</code></td>
        <td class="numeric">14%</td>
        <td class="numeric">14%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="COOPヘッダー値の普及率。", sheets_gid="300698248", sql_file="coop_header_prevalence.sql") }}</figcaption>
</figure>

観測されたすべてのCOOPヘッダーのほぼ半分が、もっとも厳しい設定である`same-origin`を採用しています。

### `Clear-Site-Data`を使用した攻撃の防止

[`Clear-Site-Data`ヘッダー](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Clear-Site-Data)を使用すると、ウェブサイトはクッキー、ストレージ、キャッシュなど、関連する閲覧データを簡単に消去できます。これは、ユーザーがログアウトしたときのセキュリティ対策としてとくに便利で、認証トークンやその他の機密情報が削除され、悪用されないようにします。ヘッダーの値は、ウェブサイトがブラウザに消去を要求するデータの種類を指定します。

`Clear-Site-Data`ヘッダーの採用は依然として限られています。私たちの観測によると、このヘッダーを使用しているのは2,071ホスト（全ホストの0.02%）のみです。ただし、この機能は主にログアウトページで役立ちますが、クローラーはそれをキャプチャしません。ログアウトページを調査するには、クローラーを拡張してアカウント登録、ログイン、ログアウト機能を検出して操作する必要があります。これはかなりの労力を要する作業です。この分野では、<a hreflang="en" href="https://www.ndss-symposium.org/wp-content/uploads/2020/02/23008-paper.pdf">ウェブページへのログインを自動化する</a>、<a hreflang="en" href="https://dl.acm.org/doi/pdf/10.1145/3589334.3645709">登録を自動化する</a>など、セキュリティとプライバシーの研究者によってすでにいくつかの進歩が見られます。

<figure>
  <table>
    <thead>
      <tr>
        <th>サイトデータ消去値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>"cache"</code></td>
        <td class="numeric">36%</td>
        <td class="numeric">34%</td>
      </tr>
      <tr>
        <td><code>cache</code></td>
        <td class="numeric">22%</td>
        <td class="numeric">23%</td>
      </tr>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">12%</td>
        <td class="numeric">13%</td>
      </tr>
      <tr>
        <td><code>cookies</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td><code>"cache", "storage", "executionContexts"</code></td>
        <td class="numeric">3%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td><code>"cookies"</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>"cache", "cookies", "storage", "executionContexts"</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>"storage"</code></td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>"cache", "storage"</code></td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td><code>cache, cookies, storage</code></td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="`Clear-Site-Data`ヘッダーの普及率。", sheets_gid="910609664", sql_file="clear-site-data_value_prevalence.sql") }}</figcaption>
</figure>

現在の使用状況データによると、`Clear-Site-Dataヘッダー`は主にキャッシュをクリアするために使用されています。このヘッダーの値は引用符で囲む必要があることに注意することが重要です。たとえば、`cache`は誤りで、`"cache"`と記述する必要があります。興味深いことに、この構文規則の遵守には大幅な改善が見られます。2022年には、デスクトップウェブサイトの65%、モバイルウェブサイトの63%が誤った`cache`値を使用していましたが、現在、これらの数値はデスクトップで22%、モバイルで23%に低下しています。

### `<meta>`を使用した攻撃の防止

ウェブ上の一部のセキュリティメカニズムは、ウェブページのソースHTML内の`meta`タグを介して構成できます。たとえば、`Content-Security-Policy`や`Referrer-Policy`などです。今年は、モバイルウェブサイトの0.61%と2.53%が、それぞれ`meta`タグを使用してCSPとReferrer-Policyを有効にしています。今年は、この方法でReferrer-Policyを設定する使用がわずかに増加し、CSPを設定する使用はわずかに減少していることがわかりました。

<figure>
  <table>
    <thead>
      <tr>
        <td>Metaタグ</td>
        <td>デスクトップ</td>
        <td>モバイル</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>Referrer-policy</code>を含む</td>
        <td class="numeric">2.7%</td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td>CSPを含む</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td><code>not-allowed policy</code>を含む</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="metaタグを使用してさまざまなポリシーを有効にしているホストの割合。", sheets_gid="1466205888", sql_file="meta_policies_allowed_vs_disallowed.sql") }}</figcaption>
</figure>

開発者は、他のセキュリティ機能を`meta`タグを使用して有効にしようとすることもありますが、これは許可されておらず、したがって無視されます。2022年と同じ例を使用すると、`4976`ページが`meta`タグを使用して`X-Frame-Options`を設定しようとしますが、ブラウザによって無視されます。これは2022年と比較して絶対的な増加ですが、データセットに含まれるページが2倍以上になったためです。相対的には、モバイルページでは0.04%から0.03%へ、デスクトップページでは0.05%から0.03%へとわずかに減少しています。

### ウェブ暗号化API

<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">ウェブ暗号化API</a>は、乱数生成、ハッシュ化、署名生成と検証、暗号化と復号化など、ウェブサイトで基本的な暗号化操作を実行するためのJavaScript APIです。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>CryptoGetRandomValues</code></td>
        <td class="numeric">56.9%</td>
        <td class="numeric">53.2%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoDigest</code></td>
        <td class="numeric">1.9%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoImportKey</code></td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha256</code></td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmEcdh</code></td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha512</code></td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmAesCbc</code></td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha1</code></td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoEncrypt</code></td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoSign</code></td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Web Cryptography APIの機能の使用状況。", sheets_gid="527224984", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

前回のAlmanacと比較して、CryptoGetRandomValuesは減少し続け、過去2年間ではるかに高い率で減少し、53%まで低下しました。その低下にもかかわらず、他の機能よりもはるかに先行して、もっとも採用されている機能であり続けていることは明らかです。CryptoGeRandomValuesに続いて、次の5つのもっとも使用されている機能は、0.7%未満から1.3%から2%の採用率に上昇し、より広く採用されるようになりました。

### ボット保護サービス

悪意のあるボットは現代のウェブにおいて依然として重大な問題であるため、ボットに対する保護の採用は増加し続けていることがわかります。2022年のデスクトップサイトの29%、モバイルサイトの26%から、現在はそれぞれ33%、32%へと、採用が再び急増していることがわかります。開発者は、より多くのモバイルウェブサイトを保護するために投資し、保護されたデスクトップサイトとモバイルサイトの数を近づけているようです。

{{ figure_markup(
  image="bot-protection.png",
  caption="使用中のボット保護サービスの分布。",
  description="ボット保護サービスの使用状況を示す積み上げ棒グラフ。reCaptchaはデスクトップでウェブサイトの16.7%、モバイルで15.9%で使用されています。Cloudflareボット管理はデスクトップでウェブサイトの8.9%、モバイルで7.9%で使用されています。Akamai Bot Managerはデスクトップとモバイルの両方でウェブサイトの0.4%で使用されています。DDoS-Guardはデスクトップでウェブサイトの0.3%、モバイルで0.5%で使用されています。Sucuriはデスクトップでウェブサイトの0.4%、モバイルで0.3%で使用されています。その他のボット保護サービスはデスクトップでウェブサイトの1.4%、モバイルで1.3%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1013362582&format=interactive",
  sheets_gid="894893633",
  sql_file="bot_detection.sql"
  )
}}

reCAPTCHAは依然として使用されている最大の保護メカニズムですが、その使用は減少しています。比較すると、Cloudflare Bot Managementは採用が増加しており、依然として2番目に大きな保護メカニズムです。

### HTMLサニタイズ

主要なブラウザへの新しい追加機能は`setHTMLUnsafe`および`ParseHTMLUnsafe` APIで、開発者が[JavaScriptから宣言的なシャドウドームを使用](https://developer.chrome.com/blog/new-in-chrome-124#dsd)できるようにします。開発者が`<template shadowrootmode="open">...</template>`を使用して宣言的なシャドウドームの定義を含むJavaScriptのカスタムHTMLコンポーネントを使用する場合、`innerHTML`を使用してこのコンポーネントをページに配置すると期待どおりに機能しません。これは、宣言的なシャドウドームが考慮されるようにする代替の`setHTMLUnsafe`を使用することで防ぐことができます。

これらのAPIを使用する場合、開発者は、名前が示すように安全でないため、すでに安全な値のみをこれらのAPIに渡すように注意する必要があります。つまり、指定された入力をサニタイズしないため、XSS攻撃につながる可能性があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="HTMLサニタイズAPIを使用しているページの数。", sheets_gid="351726153", sql_file="html_sanitization_usage.sql") }}</figcaption>
</figure>

これらのAPIは新しいため、採用率は低いと予想されます。`parseHTMLUnsafe`を使用しているページは合計で6ページ、`setHTMLUnsafe`を使用しているページは2ページしか見つかりませんでした。これは、訪問したページの数に比べて非常に少ない数です。

## セキュリティメカニズム採用の推進要因

ウェブ開発者がより多くのセキュリティ慣行を採用する理由はたくさんあります。主な3つは次のとおりです。

- 社会的：特定の国では、よりセキュリティ志向の教育が行われている、またはデータ侵害やその他のサイバーセキュリティ関連のインシデントが発生した場合に、より懲罰的な措置を講じる地域の法律がある場合があります。
- 技術的：使用されている技術スタックによっては、セキュリティ機能を導入するのが容易な場合があります。一部の機能はサポートされておらず、実装に追加の労力が必要になる場合があります。さらに、特定のソフトウェアベンダーは、製品またはホストされているソリューションでデフォルトでセキュリティ機能を有効にする場合があります。
- 人気：広く人気のあるウェブサイトは、あまり知られていないウェブサイトよりも標的型攻撃に直面する可能性が高くなりますが、セキュリティ研究者やホワイトハッカーが自社の製品を調査するよう引き付け、サイトがより多くのセキュリティ機能を正しく実装するのに役立つ場合もあります。

### ウェブサイトの場所

ウェブサイトがホストされている場所や開発者が拠点としている場所は、セキュリティ機能の採用に影響を与えることがよくあります。開発者のセキュリティ意識は、彼らが認識していない機能を実装できないため、役割を果たします。さらに、地域の法律によっては、特定のセキュリティ慣行の採用が義務付けられる場合があります。

{{ figure_markup(
  image="https-by-country.png",
  caption="国別のHTTPSの採用率。上位10か国と下位10か国。",
  description="さまざまな国に関連するサイトのHTTPS対応サイトの割合を示す棒グラフ。ニュージーランド、スイス、ケニア、オーストラリア、ノルウェー、ナイジェリア、アラブ首長国連邦、南アフリカ、オランダ、スウェーデンが上位にランクインしており、すべて99%を示しています。もう一方の端では、香港、ベトナム、ベラルーシ、イラン、ロシア、ポーランド、タイ、台湾、韓国、日本が96%から91%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1581226643&format=interactive",
  sheets_gid="1565826362",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=617
  )
}}

ニュージーランドは引き続きHTTPSウェブサイトの採用をリードしていますが、上位9か国はすべて99%以上の採用率に達しており、多くの国が採用を非常に密接に追っています！また、後続の10か国もすべてHTTPS採用率が9%から10%上昇し、すべての国が現在90%以上の採用率に達しています！これは、ほぼすべての国がHTTPSをデフォルトモードにするための努力を続けていることを示しています。

{{ figure_markup(
  image="csp-xfo-by-country.png",
  caption="国別のCSPとXFOの採用率。上位5か国と下位5か国。",
  description="ニュージーランドはCSPを使用しているサイトが28%、XFOを使用しているサイトが43%、オーストラリアはCSPが27%、XFOが40%、米国はCSPが25%、XFOが35%、カナダはCSPが25%、XFOが36%、インドはCSPが24%、XFOが28%であることを示す棒グラフ。下位では、ウクライナはCSPが9%、XFOが25%、韓国はCSPが9%、XFOが19%、日本はCSPが9%、XFOが19%、ベラルーシはCSPが8%、XFOが23%、ロシアはCSPが8%、XFOが25%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=970684068&format=interactive",
  sheets_gid="1565826362",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=598
  )
}}

CSP採用のトップ5か国では、ウェブサイトのほぼ4分の1でCSPが有効になっていることがわかります。後続の国々でもCSPの使用は増加していますが、より緩やかなものです。一般的に、XFOとCSPの両方の採用は国によって非常に異なり、CSPとXFOの間のギャップは2022年と比較して同等かそれ以上に大きく、最大15%に達しています。

### 技術スタック

現在のウェブ上の多くのサイトは、大規模なCMSシステムを使用して作成されています。これらは、ユーザーを保護するためにデフォルトでセキュリティ機能を有効にする場合があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>テクノロジー</th>
        <th>セキュリティ機能</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Wix</td>
        <td><code>Strict-Transport-Security</code> (99.9%),<br><code>X-Content-Type-Options</code> (99.9%)</td>
      </tr>
      <tr>
        <td>Blogger</td>
        <td><code>X-Content-Type-Options</code> (99.8%),<br><code>X-XSS-Protection</code> (99.8%)</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td><code>Strict-Transport-Security</code> (98.9%),<br><code>X-Content-Type-Options</code> (99.1%)</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td><code>X-Content-Type-Options</code> (90.3%),<br><code>X-Frame-Options</code> (87.9%)</td>
      </tr>
      <tr>
        <td>Google Sites</td>
        <td><code>Content-Security-Policy</code> (99.9%),<br><code>Cross-Origin-Opener-Policy</code> (99.8%),<br><code>Cross-Origin-Resource-Policy</code> (99.8%),<br><code>Referrer-Policy</code> (99.8%),<br><code>X-Content-Type-Options</code> (99.9%),<br><code>X-Frame-Options</code> (99.9%),<br><code>X-XSS-Protection</code> (99.9%)</td>
      </tr>
      <tr>
        <td>Medium</td>
        <td><code>Content-Security-Policy</code> (99.2%),<br><code>Strict-Transport-Security</code> (96.4%),<br><code><code>X-Content-Type-Options</code> (99.1%)</td>
      </tr>
      <tr>
        <td>Substack</td>
        <td><code>Strict-Transport-Security (100%),<br><code>X-Frame-Options</code> (100%)</td>
      </tr>
      <tr>
        <td>Wagtail</td>
        <td><code>Referrer-Policy</code> (55.2%),<br><code>X-Content-Type-Options</code> (61.7%),<br><code>X-Frame-Options</code> (72.1%)</td>
      </tr>
      <tr>
        <td>Plone</td>
        <td><code>Strict-Transport-Security</code> (57.1%),<br><code>X-Frame-Options</code> (75.2%)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="選択されたCMSシステムで使用されているセキュリティ機能。", sheets_gid="225805401", sql_file="feature_adoption_by_technology.sql") }}</figcaption>
</figure>

Wix、SquareSpace、Google Sites、Medium、Substackなど、提供会社によってホストされ、コンテンツのみがユーザーによって作成される多くの主要なCMSは、セキュリティ保護を広く展開しており、HSTS、X-Content-Type-Options、またはX-XSS-Protectionの採用率が99%台後半であることを示しています。Google Sitesは、もっとも多くのセキュリティ機能が導入されているCMSであり続けています。

PloneやWagtailなど、簡単に自己ホストできるCMSの場合、CMS作成者がユーザーの更新動作に影響を与える方法がないため、機能の展開を制御するのがより困難です。これらのCMSを使用してホストされているウェブサイトは、セキュリティ機能に変更がなく、長期間オンラインのままになる可能性があります。

### ウェブサイトの人気

大規模なウェブサイトは、訪問者や登録ユーザー数が多く、非常に機密性の高いデータを保存している場合があります。これは、より多くの攻撃者を引き付け、したがって標的型攻撃を受けやすくなることを意味します。さらに、攻撃が成功した場合、これらのウェブサイトは罰金を科されたり、訴えられたりして、金銭的および/または評判上の損害を被る可能性があります。したがって、人気のあるウェブサイトは、ユーザーを保護するためにより多くのセキュリティに投資することが期待されます。

{{ figure_markup(
  image="security-headers-by-rank.png",
  caption="2024年4月のCrUXによるウェブサイトランク別のセキュリティヘッダー採用率。",
  description="上位1,000サイトでは、64%がXFO、60%がHSTS、56%がX-Content-Type-Optionsヘッダーを持っていることを示す棒グラフ。上位10,000サイトでは、54%がXFO、46%がHSTS、54%がX-Content-Type-Optionsヘッダーを持っています。上位100,000サイトでは、51%がXFO、42%がHSTS、50%がX-Content-Type-Optionsヘッダーを持っています。上位1,000,000サイトでは、45%がXFO、36%がHSTS、47%がX-Content-Type-Optionsヘッダーを持っています。すべてのサイトのうち、29%がXFO、31%がHSTS、43%がX-Content-Type-Optionsを持っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=256464807&format=interactive",
  sheets_gid="434545590",
  sql_file="security_adoption_by_rank.sql",
  width=600,
  height=505
  )
}}

`X-Frame-Options`、`Strict-Transport-Security`、`X-Content-Type-Options`、`X-XSS-Protection`、`Content-Security-Policy`など、もっとも人気のあるヘッダーを含むほとんどのヘッダーは、モバイルでより人気のあるサイトで常により高い採用率を示していることがわかります。モバイルの上位1000サイトの64.3%がHSTSを有効にしています。これは、上位1000のウェブサイトがHTTPS経由でのみトラフィックを送信することにより多くの投資をしていることを意味します。人気のないサイトでもHTTPSを有効にすることはできますが、`Strict-Transport-Security`ヘッダーを頻繁に追加しないため、ユーザーがプレーンHTTP経由で繰り返しサイトにアクセスする可能性があります。

### ウェブサイトのカテゴリ

一部の業界では、開発者は、サイトをより適切に保護するために使用できるセキュリティ機能について、より最新の情報を入手している場合があります。

{{ figure_markup(
  image="avg-security-headers-per-site.png",
  caption="ウェブサイトのカテゴリ別の平均セキュリティヘッダー数。上位5カテゴリと下位5カテゴリ。",
  description="カテゴリごとの平均セキュリティヘッダー数の上位5と下位5を示す棒グラフ。ショッピングは平均1.80個のセキュリティヘッダー、金融は1.71個、美容とフィットネスは1.70個、ホーム＆ガーデンは1.66個、コンピューター＆エレクトロニクスは1.65個です。人と社会は平均1.48個のセキュリティヘッダー、書籍と文学は1.45個、不動産は1.40個、ニュースは1.38個、旅行と交通は1.34個です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=139345565&format=interactive",
  sheets_gid="1042348266",
  sql_file="feature_adoption_by_category.sql",
  width=600,
  height=617
  )
}}

ウェブサイトの分類によっては、使用される平均的なセキュリティヘッダーの数に微妙な違いがあることがわかります。この数は、これらのサイトの全体的なセキュリティを直接示すものではありませんが、どの業界のカテゴリがより多くのセキュリティ機能を実装する傾向があるかについての洞察を与える可能性があります。ショッピングと金融がリストのトップにあり、どちらも機密情報や高額な金銭取引を扱う業界であり、セキュリティへの投資の理由となる可能性があります。リストの下部にはニュースと旅行・交通があります。どちらも、それぞれのトピックに関連するコンテンツをホストするサイトが多いカテゴリですが、リストの上位カテゴリのサイトと比較して、多くの機密データを扱わない場合があります。一般的に、この傾向は弱いようです。

## ウェブ上の不正行為

暗号通貨は依然として人気がありますが、ウェブ上の暗号マイナーの数は過去2年間で減少し続けており、2022年版のWeb Almanacで説明されているように、使用量が著しく急増することはありませんでした。

{{ figure_markup(
  image="cryptominers-trend.png",
  caption="使用されている暗号マイナーの数の経時変化。2022年5月から2024年7月まで。",
  description="2022年5月から2024年7月までの暗号ジャックスクリプトを持つサイト数の推移を示す時系列グラフ。2022年7月のデスクトップサイト105件、モバイルサイト249件から2022年8月にはデスクトップサイト61件、モバイルサイト127件へと急激に減少し、その後は減少傾向が続き、2024年7月にはデスクトップサイト31件、モバイルサイト46件となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=2077124907&format=interactive",
  sheets_gid="2083415086",
  sql_file="cryptominer_usage.sql"
  )
}}

暗号マイナーのシェアを見ると、Coinimpのシェアの一部がJSEcoinに追い抜かれている一方で、他のマイナーは比較的安定しており、わずかな変化しか見られません。ウェブ上で見つかる暗号マイナーの数が少ないため、これらの相対的な変化は依然として非常に小さいです。

{{ figure_markup(
  image="cryptominers-market-share.png",
  caption="暗号マイナーの市場シェア。",
  description="CoinImpが37.7%の市場シェア、JSECoinが18.9%、Coinhiveが15.1%、Mineroが11.3%、CoinHive Captchaが9.4%、deepMinerが3.8%、Crypto-Lootが3.8%であることを示す円グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=686409320&format=interactive",
  sheets_gid="1261018954",
  sql_file="cryptominer_share.sql"
  )
}}

ここに示されている結果は、暗号マイナーに感染したウェブサイトの実際の状態を過小評価している可能性があることに注意する必要があります。クローラーは月に1回実行されるため、暗号マイナーを実行しているすべてのウェブサイトが発見できるわけではありません。たとえば、ウェブサイトが数日間しか感染していない場合、検出されない可能性があります。

## セキュリティの構成ミスと見落とし

セキュリティポリシーの存在は、ウェブサイト管理者がサイトのセキュリティ確保に積極的に取り組んでいることを示唆していますが、これらのポリシーの適切な設定が不可欠です。次のセクションでは、セキュリティを損なう可能性のある、観測されたいくつかの構成ミスに焦点を当てます。

### `<meta>`によって定義されたサポートされていないポリシー

開発者にとって、特定のセキュリティポリシーをどこで定義すべきかを理解することが重要です。たとえば、安全なポリシーが`<meta>`タグを介して定義されている場合でも、そこでサポートされていない場合はブラウザに無視され、アプリケーションが攻撃に対して脆弱なままになる可能性があります。

コンテンツセキュリティポリシーは`<meta>`タグを使用して定義できますが、その`frame-ancestors`および`sandbox`ディレクティブはこのコンテキストではサポートされていません。それにもかかわらず、私たちの観察によると、デスクトップで`<meta>`タグのCSPを使用するページの1.70%、モバイルで1.26%が、誤って`<meta>`タグで`frame-ancestors`ディレクティブを使用していました。これは、許可されていない`sandbox`ディレクティブでははるかに低く、0.01%未満で定義されていました。

### COEP、CORP、COOPの混同

COEP、CORP、COOPは、名前と目的が似ているため、区別が難しい場合があります。ただし、これらのヘッダーにサポートされていない値を割り当てると、ウェブサイトのセキュリティに悪影響を及ぼす可能性があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>無効なCOEP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
  <figcaption>{{ figure_link(caption="無効なCOEPヘッダー値の普及率。", sheets_gid="906872096", sql_file="coep_header_prevalence.sql") }}</figcaption>
</figure>

たとえば、観測されたCOEPヘッダーの約3%が、サポートされていない値`same-origin`を誤って使用しています。これが発生すると、ブラウザはクロスオリジンリソースの埋め込みを許可するデフォルトの動作に戻り、`SharedArrayBuffer`や`Performance.now()`の無制限の使用などの機能へのアクセスを制限します。このフォールバックは、サイト管理者がCORPまたはCOOPに`same-origin`を設定することを意図していない限り、本質的にセキュリティを低下させるものではありません。

さらに、観測されたCOOPヘッダーのわずか0.26%が`cross-origin`に設定されており、CORPヘッダーのわずか0.02%が値`unsafe-none`を使用していました。これらの値が誤って間違ったヘッダーに適用されたとしても、それらは利用可能なもっとも寛容なポリシーを表しています。したがって、これらの構成ミスはセキュリティを低下させるとは見なされません。

あるヘッダーを対象とした有効な値が誤って別のヘッダーに使用されたケースに加えて、さまざまなヘッダーで構文エラーのマイナーなインスタンスをいくつか特定しました。ただし、これらのエラーはそれぞれ、観測されたヘッダー全体の1%未満であり、そのような間違いは存在するものの、比較的まれであることを示唆しています。

### `Timing-Allow-Origin`ワイルドカード

Timing-Allow-Originは、サーバーが[リソースタイミングAPI](https://developer.mozilla.org/ja/docs/Web/API/Performance_API/Resource_timing)の機能を通じて取得した属性の値を表示できるオリジンのリストを指定できるレスポンスヘッダーです。これは、このヘッダーにリストされているオリジンが、TCP接続の開始時刻、リクエストの開始、レスポンスの開始など、サーバーへの接続に関する詳細なタイムスタンプにアクセスできることを意味します。

CORSが有効な場合、これらのタイミングの多く（上記のものを含む）は、クロスオリジンの漏洩を防ぐために0として返されます。Timing-Allow-Originヘッダーにオリジンをリストすることで、この制限は解除されます。

この情報へのアクセスをさまざまなオリジンに許可することは、慎重に行う必要があります。この情報を使用すると、リソースを読み込んでいるサイトがタイミング攻撃を実行する可能性があるためです。私たちの分析では、Timing-Allow-Originヘッダーが存在するすべてのレスポンスのうち、83%の`Timing-Allow-Origin`ヘッダーにワイルドカード値が含まれており、それによって任意のオリジンが詳細なタイミング情報にアクセスできるようになっていることがわかりました。

{{ figure_markup(
  content="83%",
  caption="ワイルドカード（`*`）値に設定されている`Timing-Allow-Origin`の割合。",
  classes="big-number",
  sheets_gid="955021492",
  sql_file="tao_header_prevalence.sql",
) }}

### サーバー情報ヘッダーの抑制の欠如

「あいまいさによるセキュリティ」は一般的に悪い慣行と見なされていますが、ウェブアプリケーションは、使用中のサーバーまたはフレームワークに関する過剰な情報を差し控えることで依然として恩恵を受けることができます。攻撃者は依然として特定の詳細をフィンガープリントできますが、とくに特定のバージョン番号に関する露出を最小限に抑えることで、アプリケーションが自動脆弱性スキャンで標的にされる可能性を減らすことができます。

この情報は通常、[`Server`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Server)、`X-Server`、`X-Backend-Server`、<a hreflang="en" href="https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html#x-powered-by">`X-Powered-By`</a>、`X-Aspnet-Version`などのヘッダーで報告されます。

{{ figure_markup(
  image="server-headers.png",
  caption="サーバーに関する情報を伝えるために使用されるヘッダーの普及率。",
  description="3年間にわたって、情報機密性の高いサーバーヘッダーが見つかったホストの普及率を示す縦棒グラフ。`Server`ヘッダーについては、2022年、2023年、2024年にそれぞれ92%、92%、92%です。`X-Powered-By`については、それぞれ25%、25%、24%です。`X-Aspnet-Version`ヘッダーについては、それぞれ3%、2%、2%です。`X-Server`ヘッダーについては、それぞれ0%、0%、0%です。`X-Backend-Server`ヘッダーについては、それぞれ0%、0%、0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1009281320&format=interactive",
  sheets_gid="2032567932",
  sql_file="server_information_header_prevalence.sql"
  )
}}

もっとも一般的に公開されているヘッダーは`Server`ヘッダーで、サーバーで実行されているソフトウェアを明らかにします。これに続くのが`X-Powered-By`ヘッダーで、サーバーが使用するテクノロジーを公開します。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>PHP/7.4.33</code></td>
        <td class="numeric">9.1%</td>
        <td class="numeric">9.4%</td>
      </tr>
      <tr>
        <td><code>PHP/7.3.33</code></td>
        <td class="numeric">4.6%</td>
        <td class="numeric">5.4%</td>
      </tr>
      <tr>
        <td><code>PHP/5.3.3</code></td>
        <td class="numeric">2.6%</td>
        <td class="numeric">2.8%</td>
      </tr>
      <tr>
        <td><code>PHP/5.6.40</code></td>
        <td class="numeric">2.5%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td><code>PHP/7.4.29</code></td>
        <td class="numeric">1.7%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td><code>PHP/7.2.34</code></td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td><code>PHP/8.0.30</code></td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.28</code></td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.27</code></td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td><code>PHP/7.1.33</code></td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっとも普及している`X-Powered-By`ヘッダー値と特定のフレームワークバージョン。", sheets_gid="895726728", sql_file="server_header_value_prevalence.sql") }}</figcaption>
</figure>

`Server`および`X-Powered-By`ヘッダーのもっとも一般的な値を調べたところ、とくに`X-Powered-By`ヘッダーはバージョンを指定しており、上位10の値は特定のPHPバージョンを明らかにしていることがわかりました。デスクトップとモバイルの両方で、`X-Powered-By`ヘッダーの少なくとも25%にこの情報が含まれています。このヘッダーは、観測されたウェブサーバーでデフォルトで有効になっている可能性が高いです。分析には役立ちますが、ヘッダーの利点は限られているため、デフォルトで無効にすることが妥当です。ただし、このヘッダーを無効にするだけでは、古いサーバーのセキュリティリスクに対処することはできません。サーバーを定期的に更新することが引き続き重要です。

### `Server-Timing`ヘッダーの抑制の欠如

Server-Timingヘッダーは、<a hreflang="en" href="https://w3c.github.io/server-timing/">W3C編集者草案</a>で、サーバーのパフォーマンスメトリックについて通信するために使用できるヘッダーとして定義されています。開発者は、0個以上のプロパティを含むメトリックを送信できます。指定されたプロパティの1つは`dur`プロパティで、サーバー上の特定のアクションの期間を含むミリ秒精度のタイミングを通信するために使用できます。

サーバータイミングは、インターネットホストの6.4%で使用されていることがわかります。これらのホストの60%以上が、レスポンスに少なくとも1つの`dur`プロパティを含んでおり、55%以上が2つ以上も送信しています。これは、これらのサイトがサーバー側の処理時間をクライアントに直接公開していることを意味し、悪用される可能性があります。サーバータイミングには機密情報が含まれている可能性があるため、前述のように開発者がTiming-Allow-Originを使用する場合を除き、使用は同一オリジンに制限されています。ただし、タイミング攻撃は、クロスオリジンデータにアクセスする必要なく、サーバーに対して直接悪用される可能性があります。

{{ figure_markup(
  image="server-timing-headers.png",
  caption="server-timingヘッダーの使用状況と`dur`プロパティの相対的な使用状況。",
  description="server-timingヘッダーの使用状況と`dur`プロパティの使用状況を示す縦棒グラフ。server-timingヘッダーを持つレスポンスの割合は、デスクトップで13%、モバイルで12%です。server-timingヘッダーを持つホストの割合は、デスクトップとモバイルの両方で6%です。server-timingヘッダーを持ち、少なくとも1つの`dur`プロパティを持つホストの割合は、デスクトップで65%、モバイルで61%です。server-timingヘッダーを持ち、2つ以上の`dur`プロパティを持つホストの割合は、デスクトップで59%、モバイルで55%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=753463357&format=interactive",
  sheets_gid="1339089790",
  sql_file="server_timing_usage_values.sql"
  )
}}

## `.well-known` URIs

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8615">.well-known URIs</a>は、特定の場所をデータやサービスに関連付けるウェブサイト全体の方法として使用されます。well-known URIは、パスコンポーネントが`.well-known/`で始まるURIです。

### `security.txt`

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9116"><code>security.txt</code></a>は、ウェブサイトが脆弱性報告に関する情報を標準的な方法で伝達するために使用できるファイル形式です。ウェブサイト開発者は、このファイルに連絡先、PGPキー、ポリシー、その他の情報を提供できます。ホワイトハッカーやペネトレーションテスターは、この情報を使用してセキュリティ分析中に見つけた潜在的な脆弱性を報告できます。私たちの分析によると、現在、ウェブサイトの1%がsecurity.txtファイルを使用しており、サイトのセキュリティ向上に積極的に取り組んでいることがわかります。

{{ figure_markup(
  image="security-text-usage.png",
  caption="security.txtプロパティの使用状況。",
  description="security.txtのプロパティの普及率を示す縦棒グラフ。`signed`はデスクトップとモバイルの両方でファイルの4%で使用されています。`contact`はデスクトップで92%、モバイルで89%のファイルで使用されています。`expires`はデスクトップで51%、モバイルで48%のファイルで使用されています。`encryption`はデスクトップで14%、モバイルで13%のファイルで使用されています。`acks`はデスクトップで26%、モバイルで25%のファイルで使用されています。`preferred language`はデスクトップで55%、モバイルで56%のファイルで使用されています。`canonical`はデスクトップで32%、モバイルで30%のファイルで使用されています。`policy`はデスクトップとモバイルの両方で39%のファイルで使用されています。`csaf`はデスクトップとモバイルの両方で0%のファイルで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=884497197&format=interactive",
  sheets_gid="2060862418",
  sql_file="well-known_security.sql"
  )
}}

security.txtファイルのほとんどには、連絡先情報（88.8%）と優先言語（56.0%）が含まれています。今年は、security.txtファイルの47.9%が有効期限を定義しており、2022年の2.3%と比較して大幅に増加しています。これは、今年の分析ではステータスコード200のすべてのレスポンスではなくテキストファイルのみを含めるという方法論の更新によって大部分が説明でき、それによって誤検知率が大幅に低下します。これは、security.txtを使用しているサイトの半分未満しか、（他の要件の中でも）expiresプロパティを必須と定義している標準に従っていないことを意味します。興味深いことに、security.txtファイルの39%しかポリシーを定義していません。これは、脆弱性を見つけたホワイトハッカーが脆弱性を報告するためにどのような手順を踏むべきかを開発者が示すことができるスペースです。

### `change-password`

<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/">`change-password`</a> well-known URIは、2022年と同じく編集者草案の状態にあるW3C仕様です。この特定のwell-known URIは、ユーザーやソフトウェアがパスワード変更に使用するリンクを簡単に特定する方法として提案されました。つまり、外部リンクからそのページに簡単にリンクできるようになります。

{{ figure_markup(
  image="change-password-usage.png",
  caption="change-password .well-knownエンドポイントの使用状況。",
  description="デスクトップで0.27%、モバイルで0.27%のウェブサイトがchange-passwordエンドポイントを使用していることを示す縦棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=68129914&format=interactive",
  sheets_gid="512072624",
  sql_file="well-known_change-password.sql"
  )
}}

採用率は依然として非常に低いです。モバイルとデスクトップの両サイトで0.27%で、2022年の0.28%からデスクトップサイトではわずかに減少しました。標準化プロセスが遅いため、採用率があまり変わらないのは予想外ではありません。また、認証メカニズムのないウェブサイトはこのURLを使用しないため、実装しても無意味であることも繰り返します。

### ステータスコードの信頼性の検出

2022年と同様に、まだ<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html">編集者草案</a>である仕様では、特定のwell-known URIがウェブサイトのHTTPレスポンスステータスコードの信頼性を判断するために定義されています。このwell-known URIの背後にある考え方は、どのウェブサイトにも存在すべきではないということです。つまり、このwell-known URIにナビゲートしても、<a hreflang="en" href="https://fetch.spec.whatwg.org/#ok-status">`ok-status`</a>を持つレスポンスが返されることは決してないはずです。リダイレクトして「ok-status」を返す場合、そのウェブサイトのステータスコードは信頼できないことを意味します。これは、特定の「404 not found」エラーページにリダイレクトが発生し、そのページがokステータスで提供される場合に発生する可能性があります。

{{ figure_markup(
  image="well-known-responses.png",
  caption="ステータスコードの信頼性を評価するために`.well-known`エンドポイントから返されたステータスの分布。",
  description="resource-that-should-not-exist-whose-status-code-should-not-be-200エンドポイントから返されたレスポンスステータスを示す積み上げ棒グラフ。デスクトップとモバイルの両方のウェブサイトのうち、9%が200を返し、84%がnot-okステータスを返し、7%が201-299ステータスコードを返します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1669404844&format=interactive",
  sheets_gid="210322568",
  sql_file="well-known_resource-not-be-200.sql"
  )
}}

2022年と同様の分布が見られ、ページの83.6%がnot-okステータスで応答しており、これは期待される結果です。繰り返しになりますが、これらの数値があまり変わらない理由の1つは、標準が編集者草案のステータスで停滞しており、標準化が遅いことです。

### `robots.txt`の機密エンドポイント

最後に、robots.txtに機密性の高い可能性のあるエンドポイントが含まれているかどうかを確認します。この情報を使用することで、ハッカーはrobots.txtでの除外に基づいて標的とするウェブサイトやエンドポイントを選択できる可能性があります。

{{ figure_markup(
  image="robots-text-endpoints.png",
  caption="robots.txtに指定されたエンドポイントを含むサイトの割合。",
  description="デスクトップでホストの4.7%、モバイルで4.4%の`admin`が拒否ルールで見つかり、デスクトップで2.0%、モバイルで1.9%の`login`、デスクトップとモバイルの両方で0.0%の`signin`、デスクトップとモバイルの両方で0.4%の`auth`、デスクトップで3.2%、モバイルで2.9%の`account`が見つかったことを示す縦棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxTTMlFFSMT3mZgw2awA0wl3F68gzU1OLuyMaZXscSFq-Pa5ev_qTXx8ZaGEOl_ox_aHsraAGMXZ9Y/pubchart?oid=1873866251&format=interactive",
  sheets_gid="707878693",
  sql_file="robot-txt_sensitive_disallow.sql"
  )
}}

約4.3%のウェブサイトが`robots.txt`ファイルに少なくとも1つの`admin`エントリを含んでいることがわかります。

これは、ウェブサイトの管理者専用セクションを見つけるために使用される可能性があり、そうでなければ隠されており、そのURLの下にある特定のサブページにアクセスしようとすることに依存します。`login`、`signin`、`auth`、`sso`、`account`は、ユーザーが作成または受信したアカウントを使用してログインできるメカニズムの存在を示します。これらの各エンドポイントは、多くのサイト（一部は重複している可能性があります）のrobots.txtに含まれており、`account`は2.9%のウェブサイトでより一般的です。

### `ads.txt`の間接的な再販業者

<a hreflang="en" href="https://iabtechlab.com/ads-txt/">`ads.txt`</a>ファイルは、ウェブサイトがプログラマティック広告の複雑な状況の中で、どの企業が自社のデジタル広告スペースを販売または再販することを許可されているかを指定できる標準化された形式です。企業は、直接販売者または間接的な再販業者としてリストアップできます。しかし、間接的な再販業者は、誰が広告スペースを購入するかをあまり制御できないため、ads.txtファイルをホストするサイトであるパブリッシャーを広告詐欺に対してより脆弱にする可能性があります。この脆弱性は、2019年にいわゆる<a hreflang="en" href="https://www.fraud0.com/resources/ads-txt/">404bot詐欺</a>によって悪用され、数百万ドルの収益損失をもたらしました。

{{ figure_markup(
  content="77%",
  caption="間接的な再販業者を完全に回避しているデスクトップ広告パブリッシャーの割合。",
  classes="big-number",
  sheets_gid="741686775",
  sql_file="../privacy/ads_accounts_distribution.sql",
) }}

間接的な販売者をリストアップしないことで、ウェブサイト所有者は不正な再販を防ぎ、広告詐欺を減らし、それによって広告取引のセキュリティと完全性を高めるのに役立ちます。ads.txtファイルをホストするパブリッシャーのうち、デスクトップで77%、モバイルで42.4%が再販業者を完全に回避し、潜在的な詐欺を抑制しています。

## 結論

全体として、今年の分析はウェブセキュリティにおける有望な傾向を浮き彫りにしています。HTTPSの採用は100%に近づいており、Let's Encryptが全証明書の半数以上を発行して先頭を走り、安全な接続をより利用しやすくしています。セキュリティポリシー全体の採用は依然として限定的ですが、主要なセキュリティヘッダーで着実な進歩が見られるのは心強いです。クッキーの`SameSite=Lax`属性のような、デフォルトで安全な対策は、ウェブサイト管理者に少なくとも重要なセキュリティ慣行を検討するよう促しています。

しかし、これらの保護を弱める可能性のある不適切な設定や設定ミスにも注意を払う必要があります。無効なディレクティブや不十分に定義されたポリシーのような問題は、ブラウザが効果的にセキュリティを強制するのを妨げる可能性があります。たとえば、全`Timing-Allow-Origin`ヘッダーの82.5%が、任意のオリジンに詳細なタイミング情報へのアクセスを許可しており、これはタイミング攻撃で悪用される可能性があります。同様に、`security.txt`を介したセキュリティ問題の報告を有効にしているウェブサイトはわずか1%であり、多くは依然としてPHPのバージョンを公開しており、これは潜在的な脆弱性を明らかにする可能性のある不必要なリスクです。明るい面としては、これらの問題のほとんどは簡単に解決できるものであり、通常、ウェブサイトの実装に最小限の変更を加えるだけで対処できます。

セキュリティポリシーの数が増えるにつれて、政策立案者が複雑さの軽減に注力することが不可欠です。実装の摩擦を減らすことで、採用が容易になり、一般的な間違いを最小限に抑えることができます。たとえば、クロスサイトリークやマイクロアーキテクチャ攻撃を防ぐために設計されたクロスオリジンヘッダーの導入は、あるポリシーのディレクティブが誤って別のポリシーに適用されるなど、すでに混乱を引き起こしています。

将来、新たな攻撃が出現し、新たな保護が求められることは間違いないが、健全な解決策を開発する上で、セキュリティコミュニティのオープン性が重要な役割を果たします。これまで見てきたように、新しい対策の採用には時間がかかるかもしれませんが、進歩は見られます。一歩一歩前進することで、私たちは皆にとってより回復力があり安全なウェブに近づいています。
