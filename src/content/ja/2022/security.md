---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: セキュリティ
description: 2022年のWeb Almanacのセキュリティ章は、トランスポート層セキュリティ、コンテンツの組み込み（CSP、Feature Policy、SRI）、Web防衛メカニズム（XSS、XS-Leaksの対策）、およびセキュリティメカニズムの採用を推進する要因について取り上げています。
hero_alt: Hero image of Web Almanac characters padlocking a web page, while other Web Almanac characters subdue a masked thief who has a set of bolt cutters.
authors: [SaptakS, lirantal, clarkio]
reviewers: [kushaldas, tunetheweb]
analysts: [VictorLeP, vikvanderlinden, GJFR]
editors: [tunetheweb]
translators: [ksakae1216]
SaptakS_bio: Saptak Sは、ウェブ開発における使いやすさ、セキュリティ、プライバシー、アクセシビリティを中心に据えた人権重視のウェブデベロッパーです。彼は、<a hreflang="en" href="https://www.a11yproject.com">The A11Y Project</a>、<a hreflang="en" href="https://onionshare.org/">OnionShare</a>、<a hreflang="en" href="https://wagtail.org/">Wagtail</a>など、さまざまなオープンソースプロジェクトの貢献者兼メンテナです。彼のブログは<a hreflang="en" href="https://saptaks.blog">saptaks.blog</a>で読むことができます。
lirantal_bio: オープンソースおよびJavaScriptセキュリティの取り組みで知られる<a hreflang="en" href="https://www.lirantal.com/">Liran Tal</a>は、受賞歴のあるソフトウェア開発者であり、セキュリティ研究者、そしてJavaScriptコミュニティでのオープンソースのチャンピオンです。彼は国際的に認められた<a hreflang="en" href="https://stars.github.com/profiles/lirantal/">GitHub Star</a>であり、オープンソースへの支援で知られ、Node.jsのセキュリティに対する彼の功績でOpenJS Foundationから<a hreflang="en" href="https://openjsf.org/announcement/2022/06/07/first-ever-javascriptlandia-awards-celebrate-community-leaders/">Pathfinder for Security</a>を受賞しています。彼の開発者セキュリティ教育への貢献には、OWASPプロジェクトのリーダーシップ、サプライチェーンセキュリティツールの構築、CNCFおよびOpenSSFイニシアティブへの参加、そして「O'Reilly's Serverless Security」のような書籍の執筆が含まれます。彼はSnyk.ioでデベロッパーアドボカシーチームを率いており、より優れたアプリケーションセキュリティスキルで開発者を支援することを使命としています。
clarkio_bio: Brianはアプリケーションセキュリティに関する深い経験を持つウェブデベロッパーです。彼はSnyk.ioのデベロッパーアドボケートとして、開発者が安全なウェブアプリケーションを構築できるよう支援しています。彼はフルスタックプロジェクト全般にわたる経験がありますが、とくにバックエンドサービス、API、および開発者ツールに焦点を当てています。Brianは、自身のキャリアを通じて得た成功と失敗から学んだことを開発者に教えることに情熱を注いでいます。彼の<a hreflang="en" href="https://clarkio.live">週間ライブストリーム</a>や<a hreflang="en" href="https://www.pluralsight.com/authors/brian-clark">Pluralsightのコース</a>のいずれかで、その活動を見ることができます。
results: https://docs.google.com/spreadsheets/d/1cwJ43NL2IN2PxJa5oiOoJCRkSh566XE_k9uHnGJdWeg/
featured_quote: 人々の個人情報や生活のさまざまな側面が日々デジタル化されているため、セキュリティとプライバシーの重要性はますます高まっています。ウェブサイトは、セキュリティのベストプラクティスを採用することで、ユーザーが保護されるようにする責任があります。
featured_stat_1: +14%
featured_stat_label_1: Content Security Policy の採用増加
featured_stat_2: 428
featured_stat_label_2: `Clear-Site-Data` ヘッダーを使用するウェブサイト
featured_stat_3: +85%
featured_stat_label_3: Permissions Policy の採用増加
---

## 序章

人々の個人情報がさらにデジタル化するにつれて、インターネット全体でセキュリティとプライバシーが非常に重要になっています。ウェブサイトのオーナーには、ユーザーから収集したデータを安全に保つ責任があります。そのため、ユーザーをマルウェアが悪用可能な脆弱性から保護するために、すべてのセキュリティベストプラクティスを採用することが不可欠です。

[過去の年同様](../2021/security)、私たちはウェブコミュニティによるセキュリティ方法とベストプラクティスの採用と使用を分析しました。私たちは、すべてのウェブサイトが採用すべき基本的なセキュリティ対策に関連する指標を分析しました。これには、[トランスポートセキュリティ](#トランスポートセキュリティ)や[適切なクッキー管理](#クッキー)などが含まれます。また、異なるセキュリティヘッダーの採用と、それらが[コンテンツの取り込み](#コンテンツの組み込み)や[さまざまな悪意のある攻撃の防止](#攻撃の予防)にどのように役立つかについても議論しました。

私たちは、[セキュリティ対策の採用](#セキュリティメカニズムの導入要因)を地域、技術スタック、ウェブサイトの人気度との相関関係を調べました。このような相関関係が、すべての技術スタックがデフォルトでより良いセキュリティ対策を目指すことを促進することを願っています。また、Web Application Security Working Groupの標準とドラフトに基づいて、脆弱性開示やその他のセキュリティ関連の設定を支援する[よく知られた URI](#よく知られたuri)についても議論します。

## トランスポートセキュリティ

トランスポート層セキュリティは、ユーザーとウェブサイト間のデータとリソースの安全な通信を保証します。[HTTPS](https://developer.mozilla.org/ja/docs/Glossary/https)は、クライアントとサーバー間のすべての通信を暗号化するために[TLS](https://www.cloudflare.com/ja-jp/learning/ssl/transport-layer-security-tls/)を使用します。

{{ figure_markup(
  content="94%",
  caption="デスクトップでHTTPSを使用するリクエスト。",
  classes="big-number",
  sheets_gid="1093490384",
  sql_file="https_request_over_time.sql",
) }}

デスクトップでの総リクエストの94%、モバイルでの総リクエストの93%がHTTPS経由で行われています。すべての主要ブラウザーには、ウェブサイトがHTTPSではなくHTTPを使用している場合に警告を表示する[HTTPS-only モード](https://support.mozilla.org/ja/kb/https-only-prefs)があります。

{{ figure_markup(
  image="https-usage-by-site.png",
  caption="サイトにおけるHTTPSの使用状況。",
  description="バーチャートで、デスクトップサイトの89%がHTTPSを使用しており、残りの11%がHTTPを使用しています。モバイルサイトでは、85% がHTTPSを使用し、残りの15%がHTTPを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1343950152&format=interactive",
  sheets_gid="1806760937",
  sql_file="home_page_https_usage.sql"
  )
}}

総リクエストに比べてHTTPS経由で提供されるホームページの割合は低いままです。なぜなら、ウェブサイトへの多くのリクエストがフォントやCDNなどの[サードパーティ](./third-parties)サービスによって占められており、これらはHTTPS採用率が高いからです。昨年に比べてHTTPS経由で提供されるホームページの割合はわずかに増加しています。デスクトップでは昨年の84.3%から89.3%に、モバイルでは昨年の81.2%から85.5%に増加しています。

### プロトコルバージョン

HTTPSを使用するだけでなく、最新のTLSバージョンを使用することも重要です。[TLSワーキンググループ](https://datatracker.ietf.org/doc/rfc8996/)は、複数の弱点があったため、TLS v1.0およびv1.1を非推奨としました。昨年の章以降、Firefoxは[UIを更新](https://support.mozilla.org/ja/kb/secure-connection-failed-error-message#w_an-quan-najie-sok-gadekimasendeshita)し、Firefoxバージョン97のエラーページからTLS 1.0と1.1を有効にするオプションが削除されました。Chromeもバージョン98以降、TLS 1.0と1.1のエラーページのバイパスを[許可しなくなりました](https://chromestatus.com/feature/5759116003770368)。

TLS v1.3は最新のバージョンで、2018年8月にIETFによってリリースされました。TLS v1.3は[TLS v1.2よりもはるかに高速で、より安全です](https://www.cloudflare.com/ja-jp/learning/ssl/why-use-tls-1.3/)。TLS v1.2の主要な脆弱性の多くは、古い暗号化アルゴリズムに関連しており、TLS v1.3はこれらを排除します。

{{ figure_markup(
  image="tls-version-by-site.png",
  caption="サイトにおけるTLSバージョンの使用。",
  description="バーチャートで、デスクトップでは67%のサイトがTLSv1.3を使用しており、33%がTLSv1.2を使用しています。モバイルでは、それぞれ70%と30%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1390978067&format=interactive",
  sheets_gid="1385583211",
  sql_file="tls_versions_pages.sql"
  )
}}

上のグラフでは、モバイルのホームページの70%、デスクトップのホームページの67%がTLSv1.3で提供されており、昨年から約7%増加しています。したがって、TLS v1.2からTLS v1.3への一定のシフトが見られます。

### 暗号スイート

[暗号スイート](https://learn.microsoft.com/ja-jp/windows/win32/secauthn/cipher-suites-in-schannel)は、クライアントとサーバーがTLSを使用して安全に通信を開始する前に合意する必要がある暗号化アルゴリズムのセットです。

{{ figure_markup(
  image="distribution-of-cipher-suites.png",
  caption="暗号スイートの分布。",
  description="デバイスごとに使用される暗号スイートを示す積み上げバーチャート。`AES_128_GCM`がもっとも一般的で、デスクトップとモバイルサイトの79%で使用されています。`AES_256_GCM`はデスクトップの19%、モバイルの18%で使用されています。`AES_256_CBC`はデスクトップの2%、モバイルの1%で使用されています。CHACHA20_POLY1305はそれぞれのサイトで1%と1%で使用されています。`AES_128_CBC`はそれぞれ0%と0%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1789949340&format=interactive",
  sheets_gid="711514835",
  sql_file="tls_cipher_suite.sql"
  )
}}

現代の[Galois/Counter Mode (GCM)](https://ja.wikipedia.org/wiki/Galois/Counter_Mode)暗号モードは、[パディング攻撃](https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities)に弱くないため、はるかに安全とされています。TLS v1.3は[モダンなブロック暗号モードのみをサポートしており](https://datatracker.ietf.org/doc/html/rfc8446#page-133)、より安全です。また、[暗号スイートの順序付けの問題も解消しています](https://go.dev/blog/tls-cipher-suites)。暗号と復号に使用される鍵のサイズも暗号スイートの使用を決定する要因の1つです。依然として128ビット鍵サイズが広く使用されているため、昨年のグラフと大きな違いは見られません。`AES_128_GCM`が依然としてもっとも使用されている暗号スイートで、使用率は79%です。

{{ figure_markup(
  image="forward-secrecy-support.png",
  caption="フォワードシークレシーの使用。",
  description="フォワードシークレシーがモバイルとデスクトップのリクエストの97%で使用されていることを示すバーチャート。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=298331860&format=interactive",
  sheets_gid="1454804483",
  sql_file="tls_forward_secrecy.sql"
  )
}}

TLS v1.3は、[フォワードシークレシー](https://ja.wikipedia.org/wiki/Forward_secrecy)を義務付けています。モバイルとデスクトップのリクエストの97%でフォワードシークレシーが使用されています。

### 証明書認証局

[証明書認証局](https://www.ssl.com/faqs/what-is-a-certificate-authority/)（CA）は、ウェブサイトにTLS証明書を発行し、ブラウザに認識され、ウェブサイトとの安全な通信チャネルを確立することができる企業または組織です。

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
  <figcaption>{{ figure_link(caption="ウェブサイトのトップ10証明書発行者。", sheets_gid="1306037372", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

[R3（Let's Encrypt）](https://letsencrypt.org/)は、デスクトップのウェブサイトの48%、モバイルのウェブサイトの52%が彼らによって発行された証明書を使用しており、引き続きチャートをリードしています。非営利組織であるLet's EncryptはHTTPSの採用に重要な役割を果たしており、引き続き[多くの証明書を発行しています](https://letsencrypt.org/stats/#daily-issuance)。また、残念ながら最近亡くなったその創設者の一人、[Peter Eckersly](https://community.letsencrypt.org/t/peter-eckersley-may-his-memory-be-a-blessing/183854)を記念する瞬間を持ちたいと思います。

[Cloudflare](https://developers.cloudflare.com/ssl/ssl-tls/certificate-authorities/)も、顧客に無料で証明書を提供することで2位を維持しています。CloudflareのCDNは、RSA証明書よりも小さく効率的な[楕円曲線暗号（ECC）](https://www.digicert.com/faq/ecc.htm)証明書の使用を増やしていますが、古いクライアントに非ECC証明書も提供する必要があるため、展開が困難なことが多いです。Let's EncryptとCloudflareの割合が増加するにつれて、他のCAの使用率が少し減少しているのが見られます。

### HTTP Strict Transport Security

[HTTP Strict Transport Security (HSTS)](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security)は、ブラウザに対してHTTPを使用してサイトにアクセスしようとするすべての試みをHTTPSリクエストに自動的に変換するように指示するレスポンスヘッダーです。

{{ figure_markup(
  content="25%",
  caption="HSTSヘッダーがあるモバイルリクエスト。",
  classes="big-number",
  sheets_gid="822440544",
  sql_file="hsts_attributes.sql",
) }}

モバイルレスポンスの25%とデスクトップレスポンスの28%にHSTSヘッダーがあります。

HSTSは`Strict-Transport-Security`ヘッダーを使用して設定され、`max-age`、`includeSubDomains`、`preload`の3つの異なるディレクティブを持つことができます。`max-age`はブラウザがサイトにHTTPSを使用してのみアクセスすることを覚えておくべき時間（秒単位）を示すのに役立ちます。`max-age`はヘッダーに必須のディレクティブです。

{{ figure_markup(
  image="hsts-directives-usage.png",
  caption="異なるHSTSディレクティブの使用。",
  description="異なるHSTSディレクティブの使用率を示すバーチャート。`preload`はモバイルとデスクトップの両方でウェブサイトの19%で使用されています。`includeSubdomain`はデスクトップのウェブサイトの37%、モバイルのウェブサイトの34%で使用されています。`max-age`が0のものは、デスクトップのウェブサイトの6%、モバイルのウェブサイトの5%で使用されています。有効な`max-age`は、デスクトップのウェブサイトの94%、モバイルのウェブサイトの95%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=683864207&format=interactive",
  sheets_gid="822440544",
  sql_file="hsts_attributes.sql"
) }}

デスクトップのサイトの94%とモバイルのサイトの95%には、ゼロではなく空ではない`max-age`が設定されています。

モバイルのリクエストレスポンスの34%とデスクトップの37%がHSTS設定に`includeSubdomain`を含んでいます。HSTS仕様の一部ではない[`preload`ディレクティブ](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security)を含むレスポンスは少なく、少なくとも31,536,000秒（または1年）の`max-age`と`includeSubdomain`ディレクティブの存在が必要です。

{{ figure_markup(
  image="hsts-max-age-values-in-days.png",
  caption="すべてのリクエストのHSTS `max-age`値（日数）。",
  description="`max-age`属性の値のパーセンタイルを日数に変換したバーチャート。10パーセンタイルではデスクトップが30日、モバイルが73日、25パーセンタイルでは両方とも180日、50パーセンタイルでは両方とも365日、75パーセンタイルも両方とも365日、90パーセンタイルでは両方とも730日です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=154290094&format=interactive",
  sheets_gid="1179482269",
  sql_file="hsts_max_age_percentiles.sql"
) }}

HSTSヘッダーの`max-age`属性のすべてのリクエストに対する中央値は、モバイルとデスクトップの両方で365日です。[hstspreload.org](https://hstspreload.org/)は、HSTSヘッダーが適切に設定されて問題がないことが確認された場合、`max-age`を2年間に設定することを推奨しています。

## クッキー

[HTTPクッキー](https://developer.mozilla.org/ja/docs/Web/HTTP/Cookies)は、サーバーがブラウザに送信するユーザーに関するデータのセットです。クッキーは、セッション管理、パーソナライゼーション、追跡、その他のユーザーに関連する状態情報を異なるリクエストに渡って使用できます。

クッキーが適切に設定されていない場合、[セッションハイジャック](https://owasp.org/www-community/attacks/Session_hijacking_attack)、[クロスサイトリクエストフォージェリ(CSRF)](https://owasp.org/www-community/attacks/csrf)、[クロスサイトスクリプトインクルージョン(XSSI)](https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/11-Client_Side_Testing/13-Testing_for_Cross_Site_Script_Inclusion)、その他の[クロスサイトリーク](https://xsleaks.dev/)の脆弱性など、多くの異なる形態の攻撃に対して脆弱になる可能性があります。

### Cookie属性

上記の脅威に対抗するために、開発者はクッキーに3つの異なる属性を使用できます：`HttpOnly`、`Secure`、そして`SameSite`です。`Secure`属性は`HSTS`ヘッダーと同様で、クッキーが常にHTTPS経由で送信されることを保証し、[Manipulator in the Middle攻撃](https://owasp.org/www-community/attacks/Manipulator-in-the-middle_attack)を防ぎます。`HttpOnly`は、クッキーがJavaScriptコードからアクセスできないようにすることで、[クロスサイトスクリプティング攻撃](https://owasp.org/www-community/attacks/xss/)を防ぎます。

{{ figure_markup(
  image="httponly-secure-samesite-cookie-usage.png",
  caption="クッキー属性（デスクトップ）。",
  description="デスクトップサイトで使用されるクッキー属性の棒グラフで、ファーストパーティとサードパーティのクッキーに分けて表示されています。ファーストパーティでは、`HttpOnly`が36%、`Secure`が37%、`SameSite`が45%で使用されており、サードパーティでは、`HttpOnly`が21%、`Secure`が90%、`SameSite`が88%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=528777115&format=interactive",
  sheets_gid="168091712",
  sql_file="cookie_attributes.sql"
) }}

クッキーにはファーストパーティとサードパーティの2種類があります。ファーストパーティのクッキーは通常、訪問している直接のサーバーによって設定されます。サードパーティのクッキーはサードパーティのサービスによって作成され、しばしばトラッキングや広告配信に使用されます。デスクトップでのファーストパーティクッキーの37%に`Secure`があり、36%に`HttpOnly`が設定されています。しかし、サードパーティクッキーでは、クッキーの90%に`Secure`があり、21%に`HttpOnly`が設定されています。サードパーティのクッキーでは`HttpOnly`の割合が少ないのは、JavaScriptコードによるアクセスを許可したいためです。

{{ figure_markup(
  image="samesite-cookie-attributes.png",
  caption="Same site cookie属性。",
  description="ファーストパーティとサードパーティで分けたSameSiteクッキー属性の棒グラフ。ファーストパーティでは`SameSite=lax`が61%、`SameSite=strict`が2%、`SameSite=none`が37%で使用されています。サードパーティでは`SameSite=lax`が1%、`SameSite=strict`が1%、`SameSite=none`が98%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1714102327&format=interactive",
  sheets_gid="168091712",
  sql_file="cookie_attributes.sql"
) }}

`SameSite`属性は、ブラウザにクロスサイトリクエストにクッキーを送信するかどうかを指示することで、CSRF攻撃を防ぐために使用できます。`Strict`値はクッキーが元々のサイトからのみ送信されることを許可し、`Lax`値はユーザーがリンクをたどって元のサイトにナビゲートする場合にのみ、クロスサイトリクエストにクッキーを送信することを許可します。`None`値の場合、クッキーは発信元とクロスサイトのリクエストの両方に送信されます。`SameSite=None`が設定されている場合、クッキーの`Secure`属性も設定されている必要があります（そうでない場合、クッキーはブロックされます）。`SameSite`属性を持つファーストパーティクッキーの61%が`Lax`値を持っています。`SameSite`属性がない場合、ほとんどのブラウザはデフォルトで`SameSite=Lax`を使用するため、これがチャートを支配し続けるのを見ています。サードパーティのクッキーでは、`SameSite=None`がデスクトップでのクッキーの98%で非常に高いままです。これは、サードパーティのクッキーがクロスサイトリクエストで送信されたいと考えているためです。

### Cookieの寿命

クッキーが削除されるタイミングを設定するには、`Max-Age`と`Expires`の2つの方法があります。`Expires`はクライアントに関連する特定の日付を使用してクッキーが削除されるタイミングを決定し、`Max-Age`は秒単位の期間を使用します。

{{ figure_markup(
  image="cookie-age-usage-by-site-in-desktop-in-days.png",
  caption="デスクトップでのCookieの寿命の使用（日数）。",
  description="クッキーの寿命を日数で示すパーセンタイルの棒グラフ。10パーセンタイルでは`Max-Age`が1で、`Expires`が10で、実際の最大寿命は7です。25パーセンタイルでは`Max-Age`と`Expires`がそれぞれ90日と60日で、実際の寿命は60日です。50パーセンタイルでは`Max-Age`、`Expires`、実際の寿命が365日です。75パーセンタイルでも同様に365日です。90パーセンタイルでは`Max-Age`、`Expires`、実際の寿命が730日です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=2015811517&format=interactive",
  sheets_gid="1811539513",
  sql_file="cookie_age_percentiles.sql"
  )
}}

昨年と異なり、昨年は`Max-Age`の中央値が365日である一方で、`Expires`の中央値が180日でしたが、今年は両方とも約365日です。したがって、今年は実際の最大寿命の中央値が180日から365日に上がりました。`Max-Age`が729日で`Expires`が730日の90パーセンタイルにもかかわらず、Chromeは`Max-Age`と`Expires`の両方に[400日の上限を設定する予定](https://chromestatus.com/feature/4887741241229312)です。

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
      caption="デスクトップでもっとも一般的なクッキーの有効期限の値。",
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
      caption="モバイルでもっとも一般的なクッキーの有効期限の値。",
      sheets_gid="707972861",
      sql_file="cookie_max_age_expires_top_values.sql",
    ) }}
  </figcaption>
</figure>

もっとも一般的な`Expires`には興味深い値があります。デスクトップでもっとも使用されている`Expires`値は「1970年1月1日00:00:00 GMT」です。クッキーの`Expires`値が過去の日付に設定されると、クッキーはブラウザから削除されます。1970年1月1日00:00:00 GMTはUnixエポックタイムであり、クッキーを期限切れにするか削除するためによく使用されます。

## コンテンツの組み込み

ウェブサイトのコンテンツは多様な形を取り、CSS、JavaScript、フォントや画像などのメディア資産といったリソースが必要とされます。これらは通常、コンテンツ配信を効率化するために、クラウドネイティブインフラのリモートストレージサービスやコンテンツ配信ネットワーク（CDN）からロードされます。

しかし、ウェブサイトに組み込むコンテンツが改ざんされていないことを保証することは非常に重要であり、その影響は壊滅的なものになる可能性があります。とくに最近ではサプライチェーンのセキュリティへの意識が高まり、[Magecart攻撃](https://www.imperva.com/learn/application-security/magecart/)など、ウェブサイトのコンテンツシステムを狙った横断的なマルウェアの注入を通じて、クロスサイトスクリプティング（XSS）の脆弱性などを利用する事例が増加しているため、コンテンツの組み込みはさらに重要になっています。

### コンテンツセキュリティポリシー

コンテンツの組み込みに関連するセキュリティリスクを軽減するための効果的な手段として、コンテンツセキュリティポリシー（CSP）を採用できます。これは、クロスサイトスクリプティングによるコード注入やクリックジャッキングなどの攻撃を軽減するために、防御の深さを増すセキュリティ標準です。

これは、事前に定義された信頼できるコンテンツルールのセットが遵守され、制限されたコンテンツのバイパスや組み込みの試みが拒否されることを保証することで機能します。たとえば、ブラウザで実行されるJavaScriptコードを、それが提供された同一のオリジンとGoogle Analyticsからのみ許可するコンテンツセキュリティポリシーは、`script-src 'self' www.google-analytics.com;`として定義されます。`<a img=x onError=alert(1)>`のようなクロスサイトスクリプティング注入の試みは、設定されたポリシーを強制するブラウザによって拒否されます。

{{ figure_markup(
  caption="2021年からのContent-Security-Policyヘッダーの採用率の相対的な増加。",
  content="+14%",
  classes="big-number",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql"
)
}}

2021年のデータの12.8%から2022年のデータの14.6%へと、`Content-Security-Policy`ヘッダーの採用率が14%相対的に増加しています。これは開発者とウェブセキュリティコミュニティの間で採用傾向が高まっていることを示しています。これはポジティブな兆候ですが、依然としてこのより高度な機能を使用しているサイトは少数派です。

CSPは、HTMLレスポンス自体に提供される場合にもっとも有効です。ここでは、2年前に7.2%、昨年に9.3%、今年にはモバイルホームページの合計11.2%でCSPヘッダーが提供されていることから、採用が着実に増加していることがわかります。

{{ figure_markup(
  image="csp-directives-usage.png",
  caption="CSPでもっとも一般的に使用されるディレクティブ。",
  description="もっとも一般的なCSPディレクティブの使用状況を示す棒グラフ。`upgrade-insecure-requests`がデスクトップで54%、モバイルで56%ともっとも一般的であり、次に`frame-ancestors`がデスクトップで54%、モバイルで53%です。`block-all-mixed-content`はデスクトップで26%、モバイルで38%、`default-src`はデスクトップで19%、モバイルで16%、`script-src`はデスクトップで17%、モバイルで15%、`style-src`はデスクトップで14%、モバイルで12%、`img-src`はデスクトップで13%、モバイルで11%、`font-src`はデスクトップで11%、モバイルで9%、`connect-src`はデスクトップで10%、モバイルで8%、`frame-src`はデスクトップで10%、モバイルで7%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=417279434&format=interactive",
  sheets_gid="1303493233",
  sql_file="csp_directives_usage.sql"
  )
}}

デスクトップとモバイルのHTTPリクエストの四分の一以上で提供されている上位3つのCSPディレクティブは、`upgrade-insecure-requests`が54%、`frame-ancestors`が54%、`block-all-mixed-content`ポリシーが27%です。その他のポリシーには`default-src`、`script-src`、`style-src`、`img-src`などがあります。

`upgrade-insecure-requests`ポリシーの高い採用率は、TLSリクエストの高い採用が事実上の標準となっていることに起因する可能性があります。ただし、この日付時点で`block-all-mixed-content`が非推奨とされているにもかかわらず、高い採用率を示しています。これは、CSP仕様が急速に進化しており、ユーザーが最新の状態に追いつくのが困難であることを示しているかもしれません。

クロスサイトスクリプティング攻撃の軽減に関連して、Googleのセキュリティイニシアチブである[Trusted Types](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Content-Security-Policy/trusted-types)があります。これはDOMインジェクションクラスの脆弱性を防ぐための手法を採用するために、ネイティブブラウザAPIのサポートが必要です。これはGoogleエンジニアによって積極的に提唱されていますが、まだW3Cで[ドラフト提案](https://w3c.github.io/trusted-types/dist/spec/)の段階にあります。それでも、リクエストの0.1%で関連するCSPセキュリティヘッダー`require-trusted-types-for`および`trusted-types`が記録されています、これは多くはありませんが、採用の成長傾向を示しているかもしれません。

定義済みのルールセットからのCSP違反が発生しているかどうかを評価するために、ウェブサイトは`report-uri`ディレクティブを設定できます。このディレクティブでは、ブラウザがJSON形式のデータをHTTP POSTリクエストとして送信します。`report-uri`リクエストはCSPヘッダーを持つすべてのデスクトップトラフィックの4.3%を占めていますが、現在は非推奨のディレクティブであり、`report-to`に置き換えられており、デスクトップリクエストの1.8%を占めています。

厳密なコンテンツセキュリティポリシーを実装する上での最大の課題の1つは、イベントハンドラーやDOMの他の部分に一般的に設定されるインラインJavaScriptコードの存在です。チームがCSPセキュリティ標準を段階的に採用できるようにするために、ポリシーは`unsafe-inline`または`unsafe-eval`を`script-src`ディレクティブのキーワード値として設定することがあります。これにより、一部のクロスサイトスクリプティング攻撃ベクトルを防ぐことができず、ポリシーの予防措置として逆効果になります。

チームは、インラインJavaScriptコードにノンスまたはSHA256ハッシュを使用して署名することで、より安全な態勢を取ることができます。これは次のような形式になります：

```
Content-Security-Policy: script-src 'nonce-4891cc7b20c'
```

そして、HTML内でそれを参照するには：

```html
<script nonce="nonce-4891cc7b20c">
  …
</script>
```

{{ figure_markup(
  image="csp-script-src-attribute-usage.png",
  caption="CSP `script-src` 属性の使用状況",
  description="CSP `script-src` ディレクティブでのnonce、`unsafe-inline`、`unsafe-eval` の使用状況を示す縦棒グラフ。モバイルのCSPヘッダーを持つウェブサイトの12%、デスクトップの14%で `nonce-` が使用されています。`unsafe-inline` はモバイルで94%、デスクトップで95%のウェブサイトで使用されています。`unsafe-eval` はモバイルで80%、デスクトップで78%のウェブサイトで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=310998764&format=interactive",
  sheets_gid="323360740",
  sql_file="csp_script_source_list_keywords.sql"
  )
}}

デスクトップのHTTPリクエストの統計によると、`script-src` 値の94%で `unsafe-inline`、80%で `unsafe-eval` が存在します。これは、ウェブサイトのアプリケーションコードをロックダウンし、インラインJavaScriptコードを避けることの実際の課題を示しています。さらに、上述のリクエストのうち14%だけが、安全でないインラインJavaScriptコードの使用を保護するのに役立つ `nonce-` ディレクティブを採用しています。

コンテンツセキュリティポリシーの定義の高い複雑さを示すかもしれないのが、CSPヘッダーの長さに関する統計です。

{{ figure_markup(
  image="csp-header-length.png",
  caption="CSPヘッダーの長さ",
  description="CSPヘッダーの長さのパーセンタイルを示す縦棒グラフ。10番目のパーセンタイルではデスクトップとモバイルがともに22バイト、25番目のパーセンタイルでは25バイト、50番目のパーセンタイルではデスクトップが64バイト、モバイルが70バイト、75番目のパーセンタイルでは両方とも75バイト、90番目のパーセンタイルではデスクトップが494バイト、モバイルが334バイトです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=311379301&format=interactive",
  sheets_gid="54898794",
  sql_file="csp_number_of_allowed_hosts.sql"
) }}

中央値で見ると、リクエストの50%がデスクトップで70バイトのサイズです。これは昨年のレポートからわずかに減少しており、昨年はデスクトップとモバイルのリクエストが75バイトでした。90番目のパーセンタイル以上のリクエストは、昨年のデスクトップリクエストの389バイトから、今年は494バイトに増加しています。これは、より複雑で完全なセキュリティポリシーへのわずかな進歩を示しています。

コンテンツセキュリティポリシーの完全な定義を観察すると、依然として単一のディレクティブがすべてのリクエストの大部分を占めています。すべてのデスクトップリクエストの19%が `upgrade-insecure-requests` のみに設定されています。8%が `frame-ancestors 'self'` に設定され、23%が `block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;` の値に設定されています。これは、もっとも一般的なCSPディレクティブの上位3つを組み合わせたものです。

コンテンツセキュリティポリシーは、しばしばフォント、広告関連のスクリプト、一般的なコンテンツ配信ネットワークの使用をサポートするために、自身の起源以外のコンテンツを許可する必要があります。そのため、リクエスト全体でもっとも一般的な起源のトップ10は次のとおりです：

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
      caption="CSPポリシーでもっとも頻繁に許可されるホスト。",
      sheets_gid="106248959",
      sql_file="csp_allowed_host_frequency.sql"
    ) }}
  </figcaption>
</figure>

上記のホストは昨年報告されたランクの位置づけとほぼ同じですが、使用率はわずかに上昇しています。

CSP（Content Security Policy）セキュリティ標準は、Webブラウザだけでなく、コンテンツ配信ネットワークやコンテンツ管理システムにも広くサポートされており、Webセキュリティの脆弱性を防御するためのウェブサイトやWebアプリケーションに強く推奨されるツールです。

### サブリソースインテグリティ

もう1つの防御の深さを提供するツールは、サブリソースインテグリティであり、コンテンツの改ざんに対するウェブセキュリティ防御層を提供します。コンテンツセキュリティポリシーがどの種類やソースのコンテンツが許可されるかを定義する一方で、サブリソースインテグリティメカニズムは、そのコンテンツが悪意のある目的で変更されていないことを保証します。

サブリソースインテグリティを使用する参考事例は、サードパーティのパッケージマネージャーからJavaScriptコンテンツをロードする場合です。これらの例には、unpkg.comやcdnjs.comなどがあり、どちらもJavaScriptライブラリのコンテンツソースを提供しています。

CDNプロバイダーによるホスティング問題、またはプロジェクトの貢献者やメンテナンス担当者による問題でサードパーティライブラリが危険にさらされる可能性がある場合、実質的に他人のコードを自分のウェブサイトにロードしていることになります。

CSPの `nonce-` の使用と同様に、サブリソースインテグリティ（SRIとも呼ばれます）は、ブラウザが提供されたコンテンツが暗号学的に署名されたハッシュと一致するかを検証し、コンテンツの改ざんを防ぐために送信中またはそのソースでの改ざんを防ぎます。

{{ figure_markup(
  content="20%",
  caption="デスクトップサイトでのSRIの使用。",
  classes="big-number",
  sheets_gid="953586778",
  sql_file="sri_usage.sql",
) }}

デスクトップのウェブページ要素のうち、約5つに1つ（20％）がサブリソースインテグリティを採用しています。これらのうち、83％がデスクトップの `<script>` タイプ要素で使用され、17％がデスクトップリクエストの `<link>` タイプ要素で使用されています。

ページ単位でのカバレッジでは、SRIセキュリティ機能の採用率は依然としてかなり低いです。昨年、モバイルおよびデスクトップの中央値は3.3％でしたが、今年は2％減の3.23％になりました。

サブリソースインテグリティは、SHA256、SHA384、またはSHA512の暗号関数のいずれかで計算されたハッシュのbase64文字列として指定されます。[使用事例の参照](https://developer.mozilla.org/ja/docs/Web/Security/Subresource_Integrity)として、開発者は以下のようにそれらを実装できます：

```html
<script src="https://example.com/example-framework.js"
  integrity="sha384-oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
        crossorigin="anonymous"></script>
```

{{ figure_markup(
  image="sri-hash-function-usage.png",
  caption="SRIハッシュ機能",
  description="さまざまなハッシュ機能を使用するSRI要素の割合を示す棒グラフ。デスクトップウェブサイトのSRI要素の58.4％およびモバイルウェブサイトのSRI要素の60.7％でSHA-384が使用されています。デスクトップウェブサイトのSRI要素の32.4％およびモバイルウェブサイトのSRI要素の30.8％でSHA-256が使用されています。デスクトップウェブサイトのSRI要素の10.9％およびモバイルウェブサイトのSRI要素の9.9％でSHA-512が使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=699960446&format=interactive",
  sheets_gid="1419400151",
  sql_file="sri_hash_functions.sql"
) }}

昨年の報告と一致して、SHA384は利用可能なすべてのハッシュ関数の中でもっとも多くのSRIハッシュタイプを示しています。

CDNはサブリソースインテグリティに慣れており、ページ上で提供されるコンテンツのURL参照にサブリソースインテグリティ値を含むことで、消費者に安全なデフォルトを提供しています。

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
  <figcaption>{{ figure_link(caption="SRI保護スクリプトが含まれるもっとも一般的なホスト", sheets_gid="998292064", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

上記のリストは、サブリソースインテグリティ値が観察されたトップ10のもっとも一般的なホストを示しています。昨年からの注目すべき変化は、Cloudflareのホストが4位から3位に上昇し、jsDelivrが7位から6位に上昇し、Bootstrapのホストのランキングを上回ったことです。

### パーミッションポリシー

時間とともにブラウザはますます強力になり、ウェブサイトに利用可能なさまざまなハードウェアや機能セットをアクセスして制御するためのより多くのネイティブAPIが追加されています。これらは、マイクをオンにしてデータを収集する悪意のあるスクリプトや、デバイスのジオロケーションを指紋認証して位置情報を収集するなど、特定の機能の悪用を通じてユーザーに潜在的なセキュリティリスクをもたらす可能性があります。

以前は `Feature-Policy` として知られ、現在は `Permissions-Policy` と名付けられているこのAPIは、ブラウザがアクセス可能な多くの機能の許可リストと拒否リストを制御するための実験的なブラウザAPIです。

`Permissions-Policy` の使用とHTTPS対応接続（97%）、`X-Content-Type-Options`（82%）、および `X-Frame-Options`（78%）との間に高い相関関係が見られます。すべての相関関係はデスクトップリクエストにわたっています。もう1つの高い相関関係は、特定の技術の交差点で観察され、Google My Businessモバイルページ（99%）と、次に近いAcquiaのCloud Platform（67%）で見られます。すべての相関関係はモバイルリクエストにわたっています。

{{ figure_markup(
  caption="2021年からの `Permissions-Policy` の採用率の相対的な増加。",
  content="+85%",
  classes="big-number",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql"
)
}}

2021年のデータ（1.3%）から2022年のデータ（2.4%）にかけて、モバイルリクエストにおける `Permissions-Policy` の採用率が85%の相対的な増加を見ています。デスクトップリクエストにおいても同様の傾向があります。廃止された `Feature-Policy` は昨年のデータと今年のデータの間で1パーセントポイントの僅かな増加を示しており、これはユーザーがウェブブラウザの仕様変更に追いついていることを示しています。

HTTPヘッダーとして使用されるだけでなく、この機能は以下のように `<iframe>` 要素内で使用できます：

```html
  <iframe src="https://example.com" allow="geolocation 'src' https://example.com'; camera *"></iframe>
```

モバイルの1,740万フレームのうち12.6%に`allow`属性が含まれており、許可または機能ポリシーを有効にしています。

<aside class="note">この章の以前のバージョンでは、フレームの合計数と `allow` 属性を持つフレームの割合の値が間違っていました。詳細については、この <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/3912">GitHub PR</a> を参照してください。</aside>

以下は、フレームで検出されたトップ10の`allow`ディレクティブのリストです：

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
      caption="iframeの`allow`ディレクティブの普及率。",
      sheets_gid="1848560369",
      sql_file="iframe_allow_directives.sql"
    ) }}
  </figcaption>
</figure>

興味深いことに、上記のリストに入っていない11位、12位、13位のモバイル用`allow`ディレクティブは、それぞれ`vr`（6%）、`payment`（2%）、`web-share`（1%）です。これらは、仮想現実（メタバースとも言われます）、オンライン決済、フィンテック業界を取り巻く業界の成長傾向を示唆しているかもしれません。最後に、これは過去数年の在宅勤務の習慣の増加により、Webベースの共有のサポートが向上していることを示していると考えられます。

### Iframeサンドボックス

ウェブサイトで`iframe`要素を使用することは、リッチメディア、クロスアプリケーションコンポーネント、広告などのサードパーティコンテンツを簡単に埋め込むために、開発者が長年にわたって行ってきた実践です。一部の人々は、`iframe`要素が埋め込んでいるウェブサイトとソースウェブサイトの間にセキュリティ境界を形成すると考えるかもしれませんが、それは正確ではありません。

HTMLの`<iframe>`要素は、デフォルトでトップレベルページの機能（ポップアップやトップページのブラウザナビゲーションとの直接的なやりとり）にアクセスできます。たとえば、以下のコードは`iframe`要素のソースに埋め込まれ、アクティブなユーザーのジェスチャーを利用して、`iframe`をホスティングしているウェブサイトが`https://example.com`に新しいURLへとナビゲートするようにします：

```js
function clickToGo() {
  window.open('https://example.com')
}
```

この問題は一般に「クリックジャッキング攻撃」として知られており、`iframe`に埋め込まれる多くのセキュリティリスクの1つです（言葉遊びを意図）。

これらの懸念を軽減するために、HTML仕様（バージョン5）では`iframe`要素に適用可能な`sandbox`属性を導入しました。これは許可リストとして機能し、空のままであれば、`iframe`要素内の任意の機能を基本的には有効にしません。これにより、ポップアップのようなページの対話性へのアクセス、JavaScriptコードの実行権限、クッキーへのアクセスが一切なくなります。

{{ figure_markup(
  image="prevalence-of-sandbox-directives-on-frames.png",
  caption="フレーム上のsandbox指令の普及率。",
  description="フレーム内のsandbox指令の普及率を示す棒グラフ。`allow-scripts`と`allow-same-origin`がもっとも使用されており、sandbox属性を持つiframeのほぼ100%がこれらの指令を使用しています。デスクトップでは`allow-popups`が82%、モバイルでは85%のフレームで見られ、`allow-forms`はデスクトップで81%、モバイルで84%、`allow-popups-to-escape-sandbox`はデスクトップで80%、モバイルで83%、`allow-top-navigation-by-user-activation`はデスクトップで59%、モバイルで61%、`allow-top-navigation`はデスクトップで21%、モバイルで22%、`allow-modals`はデスクトップで20%、モバイルで21%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1144896878&format=interactive",
  sheets_gid="245152438",
  sql_file="iframe_sandbox_directives.sql"
  )
}}

2022年の上記のグラフは、`sandbox`属性を持つウェブサイトの99%以上が`allow-scripts`と`allow-same-origin`の権限を有効にしていることを示しています。

デスクトップ ウェブサイトにあるすべての iframe のうち、21.08% に `sandbox` 属性が含まれています。

<aside class="note">この章の以前のバージョンでは、`sandbox` 属性を持つフレームの割合が誤って報告されていました。詳細については、この <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/3912">GitHub PR</a> を参照してください。</aside>

モバイルの`Content-Security-Policy`ヘッダーに`sandbox`指令を含むものはわずか0.3%（デスクトップも同様に0.4%）であり、この属性がページ内でiframeコンテンツを埋め込む際にケースバイケースで適用されることが多く、事前のコンテンツセキュリティポリシー定義を通じて計画することは少ないことを示しています。

## 攻撃の予防

ウェブサイトを悪用するさまざまな攻撃があり、ウェブサイトを完全に保護することはほとんど不可能です。しかし、ウェブ開発者はこれらの攻撃の多くを防ぐため、またはユーザーへの影響を限定するために多くの対策を講じることができます。

### セキュリティヘッダーの採用

セキュリティヘッダーは、トラフィックとデータフローの種類を制限することにより攻撃を防ぐもっとも一般的な方法の1つです。ただし、これらのセキュリティヘッダーのほとんどはウェブサイト開発者によって手動で設定されなければなりません。したがって、セキュリティヘッダーの存在は、そのウェブサイトの開発者が従うセキュリティ衛生の良い指標となることがよくあります。

{{ figure_markup(
  image="adoption-of-security-headers.png",
  caption="モバイルページでのサイトリクエストにおけるセキュリティヘッダーの採用。",
  description="2022年と2021年のモバイルページの同じドメインの任意のリクエストに対するさまざまなセキュリティヘッダーの普及率を示す棒グラフ。`X-Content-Type-Options`は2021年が37%、2022年が40%、`X-Frame-Options`は2021年が29%、2022年が31%、`Strict-Transport-Security`は2021年が23%、2022年が26%、`X-XSS-Protection`は2021年が20%、2022年が21%、`Expect-CT`は2021年が13%、2022年が15%、`Content-Security-Policy`は2021年が13%、2022年が15%、`Report-To`は2021年が12%、2022年が11%、`Referrer-Policy`は2021年が10%、2022年が12%、`Permissions-Policy`は2021年が1%、2022年が2%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=479752873&format=interactive",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql",
  width=600,
  height=496
) }}

もっとも広く使用されているセキュリティメカニズムは依然としてX-Content-Type-Optionsヘッダーで、モバイルでクロールしたウェブサイトの40%でMIMEスニッフィング攻撃から保護するために使用されています。このヘッダーの次に多いのはX-Frame-Optionsヘッダーで、すべてのサイトの30%で有効になっています。昨年のデータからは大きな違いは見られず、すべてのセキュリティヘッダーの採用が徐々に増加していますが、使用率のランキングは同じです。

### CSPを使用した攻撃の防止

Content Security Policy（CSP）の主な用途は、安全にコンテンツをロードできる信頼できるソースを決定することです。これにより、CSPはクリックジャッキング、クロスサイトスクリプティング攻撃、ミックスコンテンツの含有など、さまざまな種類の攻撃を防ぐのに非常に役立つセキュリティヘッダーになります。

{{ figure_markup(
  caption="モバイルにおけるCSPを持つウェブサイトの割合で、frame-ancestorsディレクティブが含まれているもの。",
  content="53%",
  classes="big-number",
  sheets_gid="1303493233",
  sql_file="csp_directives_usage.sql"
)
}}

クリックジャッキング攻撃を防ぐ一般的な方法の1つは、ブラウザがウェブサイトをフレーム内でロードするのを防ぐことです。CSPヘッダーの[`frame-ancestors`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Content-Security-Policy/frame-ancestors)ディレクティブを使用して、他のドメインがページコンテンツをフレーム内に含むのを制限できます。モバイルでCSPを持つウェブサイトの53%に`frame-ancestors`ディレクティブが含まれていることがわかりました。これはクリックジャッキング攻撃を防ぐために非常に有効です。`frame-ancestors`ディレクティブの値を`none`または`self`に設定することがもっとも安全です。`none`はどのドメインもコンテンツをフレーム内に含むことを許可せず、`self`は元のドメインのみがコンテンツをフレーム内に含むことを許可します。モバイルでCSPヘッダーを持つウェブサイトの8%が`frame-ancestors 'self'`のみを持っており、これはCSPヘッダーの値としては3番目に一般的です。

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
      caption="CSPキーワードの普及率。`default-src`または`script-src`ディレクティブを定義するポリシーに基づく。",
      sheets_gid="323360740",
      sql_file="csp_script_source_list_keywords.sql"
    ) }}
  </figcaption>
</figure>

ウェブサイトの`script-src`ディレクティブを制限的に設定することにより、XSS攻撃に対する防御メカニズムの1つとなります。これにより、JavaScriptは信頼できるソースからのみロードされ、攻撃者は悪意のあるコードを注入することができなくなります。<a hreflang="en" href="https://content-security-policy.com/strict-dynamic/">`strict-dynamic`</a>は、HTML内のルートスクリプトが他のスクリプトファイルを動的にロードまたは注入する場合に役立ちます。これはルートスクリプトにnonceやhashを使用し、`unsafe-inline`や個々のリンクなどの他の許可リストを無視します。これはIEを除くすべての現代のブラウザでサポートされています。また、昨年と比較して`unsafe-inline`と`unsafe-eval`の使用が約2%減少しています。これは正しい方向への一歩です。

### クロスオリジンポリシーを使用した攻撃の防止

クロスオリジンポリシーは、クロスサイトリークのようなマイクロアーキテクチャ攻撃を防ぐために使用される主要なメカニズムの1つです。XS-Leaksはクロスサイトリクエストフォージェリと似ていますが、ウェブサイト間の相互作用中に露呈されるユーザーに関する小さな情報を推測します。

{{ figure_markup(
  image="percentage-of-cross-origin-headers.png",
  caption="クロスオリジンヘッダーの割合。",
  description="クロスオリジンヘッダーの普及率を示す棒グラフ。`Cross-Origin-Resource-Policy`はデスクトップウェブサイトの0.86%、モバイルウェブサイトの1.46%で見られます。`Cross-Origin-Embedder-Policy`はデスクトップウェブサイトの0.04%、モバイルウェブサイトの0.03%で見られます。`Cross-Origin-Opener-Policy`はデスクトップウェブサイトの0.23%、モバイルウェブサイトの0.45%で見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=976367634&format=interactive",
  sheets_gid="1799124531",
  sql_file="security_headers_prevalence.sql"
) }}

[`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Resource-Policy)はモバイルの114,111(1.46%)のウェブサイトに存在し、もっとも使用されているクロスオリジンポリシーです。これは、リソースがクロスオリジンから含まれるべきかどうかをブラウザに示すために使用されます。[`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy)は、昨年の911ウェブサイトから比較して現在2,559ウェブサイトに存在しています。[`Cross-Origin-Opener-Policy`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy)の採用も同様に成長しており、昨年の15,727サイトから現在モバイルでは34,968サイトがこのヘッダーを持っています。したがって、すべてのクロスオリジンポリシーの採用は安定して成長しており、これはXS-Leak攻撃を防ぐのに非常に役立つため、素晴らしいことです。

### Clear-Site-Dataを使用した攻撃の防止

[Clear-Site-Data](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Clear-Site-Data)は、ウェブ開発者が自分のウェブサイトに関連するユーザーデータのクリアをよりコントロールできるようにします。たとえば、ウェブ開発者は、ユーザーが自分のウェブサイトからサインアウトするときに、そのユーザーに関連するすべてのクッキー、キャッシュ、ストレージ情報を削除できるように決定できます。これにより、必要ないときにブラウザに保存されるデータ量を制限し、攻撃の影響を限定するのに役立ちます。これは比較的新しいヘッダーで、HTTPSで提供されるサイトにのみ制限されており、機能の一部のみが[ブラウザによってサポートされています](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Clear-Site-Data#browser_compatibility)。2021年にはモバイルで`Clear-Site-Data`ヘッダーを持つサイトは75件でしたが、今年は428件に増加しました。ウェブアルマナックのデータでは追跡されていないログアウトページでのみこのヘッダーを使用するウェブサイトが多いことに注意する価値があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>CSDヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
      caption="`Clear-Site-Data`ヘッダーの普及率。",
      sheets_gid="1206925009",
      sql_file="clear-site-data_value_prevalence.sql"
    ) }}
  </figcaption>
</figure>

`cache`はClear-Site-Dataでもっとも普及しているディレクティブで、モバイルウェブサイトの63%で使用されていますが、これは多くの開発者がユーザーのプライバシーやセキュリティよりも、新しい静的ファイルをロードするためにこのセキュリティヘッダーを使用していることを意味するかもしれません。しかし、ディレクティブは<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7230#section-3.2.6">引用文字列文法</a>に従うべきであり、そのためこのディレクティブは無効です。9%のモバイルウェブサイトがこのヘッダーを使用し、"*"を使っているのを見るのは素晴らしいことです。これは、ブラウザに保存されているすべてのユーザーデータをクリアするよう指示しています。3番目に使用されているディレクティブは再び`"cache"`であり、今回は適切に使用されています。

### `<meta>`を使用した攻撃の防止

ウェブサイトのHTMLコード内で`<meta>`タグを使用して`Content-Security-Policy`や`Referrer-Policy`を設定できます。たとえば、`Content-Security-Policy`は以下のコードを使用して設定できます: `<meta http-equiv="Content-Security-Policy" content="default-src 'self'">`。モバイルでこの方法でCSPとReferrer-Policyを有効にしているウェブサイトはそれぞれ0.47％と2.60％であることが分かりました。

<figure>
  <table>
    <thead>
      <tr>
        <th>メタタグの値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>include Referrer-Policy</td>
        <td class="numeric">3.11%</td>
        <td class="numeric">2.60%</td>
      </tr>
      <tr>
        <td>include CSP</td>
        <td class="numeric">0.55%</td>
        <td class="numeric">0.47%</td>
      </tr>
      <tr>
        <td>include note-allowed headers</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="`<meta>`タグで使用されるセキュリティヘッダー。",
      sheets_gid="2049304175",
      sql_file="meta_policies_allowed_vs_disallowed.sql"
    ) }}
  </figcaption>
</figure>

`<meta>`タグを使用して攻撃を防ぐ際の問題点は、他のセキュリティヘッダーを設定した場合、ブラウザはそのセキュリティヘッダーを無視することです。たとえば、2,815のサイトが`<meta>`タグに`X-Frame-Options`を持っていました。開発者は`<meta>`タグを追加したことでウェブサイトが特定の攻撃に対して安全だと期待しているかもしれませんが、実際にはそのセキュリティヘッダーが追加されていないのです。ただし、この数は昨年の3,410サイトから減少しているので、ウェブサイトが`<meta>`タグの誤用を修正している可能性があります。

### Web Cryptography API

<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a>は、ランダム数の生成、ハッシュ化、署名、暗号化、復号など、ウェブサイト上で基本的な暗号操作を行うためのJavaScript APIです。

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
      caption="もっとも使用されている暗号APIトップリスト。",
      sheets_gid="971581635",
      sql_file="web_cryptography_api.sql"
    ) }}
  </figcaption>
</figure>

昨年からのデータにはほとんど変化がありません。`CryptoGetRandomValues`は引き続きもっとも採用されている機能であり（昨年から約1％減少していますが）、強力な擬似乱数を生成するために使用されているためです。その高い使用率は、Google Analyticsなどの一般的なサービスで使用されていることに起因しています。

### ボット保護サービス

現代のインターネットはボットで溢れており、悪質なボット攻撃が常に増加しています。Impervaによる<a hreflang="en" href="https://www.imperva.com/resources/reports/2022-Imperva-Bad-Bot-Report.pdf">2022年の悪質ボットレポート</a>によると、インターネットトラフィックの27.7％が悪質なボットによるものでした。悪質なボットとは、データをスクレイピングして悪用しようとするものです。レポートによると、2021年末にはlog4jの脆弱性を利用したボットによる攻撃が急増したとされています。

{{ figure_markup(
  image="bot-protection-service-usage.png",
  caption="ボット保護サービスのプロバイダー別使用状況。",
  description="ボット保護サービスの使用状況を示す棒グラフ。デスクトップでは19.9％、モバイルでは18.4％のウェブサイトでreCaptchaが使用されています。Cloudflareボット管理は、デスクトップで7.9％、モバイルで6.1％のウェブサイトで使用されています。Akamai Bot Managerは、デスクトップで0.6％、モバイルで0.5％のウェブサイトで使用されています。Impervaは、デスクトップで0.4％、モバイルで0.3％のウェブサイトで使用されています。hCaptchaは、デスクトップとモバイルの両方で0.1％のウェブサイトで使用されています。他のボット保護サービスは、デスクトップで0.4％、モバイルで0.3％のウェブサイトで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1782263355&format=interactive",
  sheets_gid="1592374295",
  sql_file="bot_detection.sql"
) }}

分析によると、デスクトップのウェブサイトの29％、モバイルのウェブサイトの26％が悪質なボットと戦うためのメカニズムを使用しており、昨年（それぞれ11％と10％）から大幅に増加しています。この増加は<a hreflang="en" href="https://www.cloudflare.com/en-gb/products/bot-management/">Cloudflareボット管理</a>などのキャプチャフリーのソリューションが原因かもしれません。昨年のデータクロールではこの点が追跡されていませんでしたが、今年はそれが識別され、モバイルのウェブサイトの6％で使用されていることがわかりました。デスクトップとモバイルの両方でreCaptchaの使用も昨年から約9％増加しています。

## セキュリティメカニズムの導入要因

ウェブサイトがより多くのセキュリティ対策を採用するための主な要因はいくつかあります。もっとも重要な3つは以下の通りです：
- 社会的：一部の国ではセキュリティ指向の教育が進んでいる、またはデータ侵害の場合により厳しい処罰を規定する法律がある
- 技術的：特定の技術スタックでセキュリティ機能を採用することが容易である、または特定のベンダーがデフォルトでセキュリティ機能を有効にしている
- 人気：広く人気のあるウェブサイトは、あまり知られていないウェブサイトよりもターゲットとされる攻撃を多く受ける可能性がある

### ウェブサイトの所在地

ウェブサイトの開発者が拠点を置いている場所やウェブサイトがホストされている場所は、セキュリティ機能の採用に影響を与えることがよくあります。これは開発者の意識が異なるためかもしれませんが、国の法律が特定のセキュリティ対策の採用を義務付けているためかもしれません。

{{ figure_markup(
  image="adoption-of-https-per-country.png",
  caption="国別HTTPSの採用状況。",
  description="関連する国のサイトに対するHTTPSの有効化の割合を示す棒グラフ。ニュージーランド、ナイジェリア、オーストラリア、ノルウェー、スイス、デンマーク、アイルランド、南アフリカ、オランダ、カナダが順に95％から93％でトップです。一方で、ベトナム、セルビア、ロシア連邦、ポーランド、イラン、インドネシア、台湾、タイ、韓国、日本は85％から81％で最低です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1218814034&format=interactive",
  sheets_gid="1838772734",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=617
) }}

ニュージーランド、ノルウェー、デンマークなどの新しい国々がHTTPSの採用で急速にトップに上り詰めています。新しい国々も広範なセキュリティ対策を採用しているのを見るのは良い兆候です。また、HTTPSの最低採用率と最高採用率の差が縮小していることから、ほぼすべての国がデフォルトでウェブサイトにHTTPSを有していることを目指していることがわかります。

{{ figure_markup(
  image="adoption-of-csp-and-xfo-per-country.png",
  caption="国別CSPとXFOの採用状況。",
  description="ニュージーランドがCSPで22％、XFOで38％、オーストラリアがCSPで21％、XFOで35％、インドネシアがCSPで21％、XFOで32％、アメリカがCSPで20％、XFOで31％、アイルランドがCSPで20％、XFOで36％を使用しています。一方で下位にはウクライナがCSPで7％、XFOで21％、日本がCSPで7％、XFOで17％、カザフスタンがCSPで6％、XFOで21％、ベラルーシがCSPで5％、XFOで20％、ロシアがCSPで5％、XFOで20％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=651643593&format=interactive",
  sheets_gid="1838772734",
  sql_file="feature_adoption_by_country.sql",
  width=600,
  height=598
) }}

CSPと`X-Frame-Options`（XFO）の採用は昨年と非常に似ています。驚くべきことに、インドネシアのウェブサイトはCSPの採用が非常に進んでいますが、HTTPSの採用は依然として低いままです。CSPの採用は国によって非常にバラバラですが、XFOの採用差は徐々に縮小しています。CSPは多岐にわたる攻撃から保護する非常に重要なセキュリティ機能であるため、より多くの国がCSPの採用を増やす必要があります。

### テクノロジースタック

ウェブサイトの構築に使用されるテクノロジースタックも、特定のセキュリティ機構の採用に大きな影響を与える要因の1つです。場合によっては、コンテンツ管理システムなどで、セキュリティ機能がデフォルトで有効になっていることもあります。

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
      caption="さまざまなテクノロジーによるセキュリティ機能の採用。",
      sheets_gid="1386880960",
      sql_file="feature_adoption_by_technology.sql"
    ) }}
  </figcaption>
</figure>

上記は一般的なCMSやブログサイトの一部です。Wix、Squarespace、Mediumなど、カスタマイズをあまり提供せず、コンテンツ編集に重点を置いているサイトでは、`Strict-Transport-Security`などの基本的なセキュリティ機能がデフォルトで有効になっている傾向があります。Wagtail、Plone、Drupalなどのコンテンツ管理システムは、開発者がウェブサイトを設定するためによく使用されるため、セキュリティ機能の追加は開発者により大きく依存しています。また、Google Sitesを使用するウェブサイトでは、多くのセキュリティ機能がデフォルトで有効になっていることがわかります。

### ウェブサイトの人気度

多くの訪問者を持つウェブサイトは、潜在的に機密データを持つユーザーが多いため、ターゲットとされる攻撃を受けやすい可能性があります。そのため、広く訪問されるウェブサイトでは、ユーザーを保護するためにセキュリティへの投資がより多くなると考えられます。

{{ figure_markup(
  image="prevalence-of-headers-in-sites-by-rank.png",
  caption="ランク別に設定されているセキュリティヘッダーの普及率。",
  description="トップ1000サイトでは、55.9％がXFOを、56.8％がHSTSを、27％がCSPヘッダーを持っています。トップ10,000では、51.3％がXFOを、44.5％がHSTSを、20.6％がCSPヘッダーを持っています。トップ100,000では、48.1％がXFOを、38％がHSTSを、17.8％がCSPヘッダーを持っています。トップ1,000,000では、41.9％がXFOを、31.1％がHSTSを、16.4％がCSPヘッダーを持っています。すべてのサイトでは、31％がXFOを、25.7％がHSTSを、14.6％がCSPを持っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1055039456&format=interactive",
  sheets_gid="1909836848",
  sql_file="security_adoption_by_rank.sql"
  )
}}

調査によると、`Strict-Transport-Security`、`X-Frame-Options`、および`X-Content-Type-Options`は、人気のあるウェブサイトほど採用率が高いことがわかりました。モバイルのトップ1000ウェブサイトの56.8％がStrict-Transport-Securityを採用しており、これらのウェブサイトはコンテンツとデータをHTTPS経由でのみ提供することを重視しています。人気のないウェブサイトもHTTPSを有効にしているかもしれませんが、ウェブサイトが常にHTTPS経由で提供されるように`Strict-Transport-Security`ヘッダーを追加することはしばしば見られません。今年の数字は昨年の結果とほぼ一致しています。

## ウェブ上の悪用

今年も暗号通貨の人気が高まり、さまざまな用途で利用できる新しいタイプの暗号通貨が増加しました。その継続的な成長と既存の経済的インセンティブを背景に、サイバー犯罪者は[cryptojacking](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%B8%E3%83%A3%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0)を利用して利益を得ています。しかし、昨年から全体的に暗号通貨マイナーの使用は減少しています。攻撃者がデスクトップとモバイルのシステムに暗号通貨マイナーを注入することを可能にする特定の脆弱性イベントが発生すると、その使用が急増する傾向があります：

{{ figure_markup(
  image="cryptominer-usage.png",
  caption="Cryptominerの使用状況。",
  description="2020年1月から2022年7月までのウェブサイトにおける暗号通貨マイニングスクリプトの数の推移を示す時系列チャート。2021年8月にはデスクトップで827サイト、モバイルで983サイトに増加した後、2022年7月にはデスクトップで61サイト、モバイルで127サイトに減少しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1621924056&format=interactive",
  sheets_gid="367286091",
  sql_file="cryptominer_usage.sql"
) }}

例として、2021年の7月と8月には、いくつかの暗号通貨ジャッキングキャンペーンと脆弱性が報告され、その時期にウェブサイトで見つかった暗号通貨マイナーの急増が発生しました。さらに最近の2022年4月には、ハッカーが<a hreflang="en" href="https://arstechnica.com/information-technology/2022/04/hackers-hammer-springshell-vulnerability-in-attempt-to-install-cryptominers/">SpringShell脆弱性を利用して暗号通貨マイナーを設定し実行しようと試みました</a>。

デスクトップとモバイルのウェブサイトで使用されている暗号通貨マイナーの具体的な情報を見ると、マイナー間のシェアが昨年から広がっています。たとえば、Coinimpのシェアは昨年から約24%縮小し、Minero.ccは約11%増加しました。

{{ figure_markup(
  image="cryptominer-market-share.png",
  caption="モバイルにおけるCryptominerの市場シェア。",
  description="パイチャートで、CoinImpが市場シェアの60.4％を持ち、Coinhiveが15.6％、Mineroが12.4％、JSECoinが6.8％、その他が約4.8％を占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1570078079&format=interactive",
  sheets_gid="280179954",
  sql_file="cryptominer_share.sql"
) }}

これらの結果から、cryptojackingは毎年深刻な攻撃手法であり、新たに出現した脆弱性を利用して使用が急増することが示されています。したがって、この分野のリスクを軽減するために適切な注意が依然として必要です。

これらのウェブサイトすべてが感染しているわけではありません。ウェブサイト運営者は広告を表示する代わりにこの技術を使用してウェブサイトを資金調達することがあります。しかし、この技術の使用は技術的、法的、倫理的にも大きく議論されています。

また、私たちの結果がcryptojackingに感染したウェブサイトの実際の状態を示しているとは限らないことにも注意してください。私たちのクローラーは月に一度実行されるため、暗号通貨マイナーを実行しているすべてのウェブサイトを発見することはできません。たとえば、ウェブサイトがX日間だけ感染しており、私たちのクローラーが実行された日には感染していない場合がこれに該当します。

## よく知られたURI

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8615">よく知られたURI</a>は、ウェブサイト全体に関連するデータやサービスを特定の場所に指定するために使用されます。よく知られたURIは、パスコンポーネントが`/.well-known/`という文字で始まる<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc3986">URI</a>です。

### `security.txt`

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-foudil-securitytxt-12">`security.txt`</a>は、ウェブサイトが脆弱性報告の標準を提供するためのファイルフォーマットです。ウェブサイト提供者は、このファイルに連絡先の詳細、PGPキー、ポリシー、その他の情報を提供できます。ホワイトハットハッカーやペネトレーションテスターは、これらの情報を使用してウェブサイトのセキュリティ分析を行い、脆弱性を報告できます。

{{ figure_markup(
  image="usage-of-properties-in-well-known-security.png",
  caption="security.txtプロパティの使用。",
  description="`security.txt`の異なるプロパティの使用を示す棒グラフ。デスクトップでは0.6％、モバイルでは0.4％の`security.txt`ファイルが署名されています。`Canonical`はデスクトップで4.2％、モバイルで3.5％で使用されています。`Encryption`はデスクトップで3.0％、モバイルで2.4％です。`Expires`はデスクトップで3.0％、モバイルで2.3％です。`Policy`はデスクトップで7.3％、モバイルで6.8％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=446092062&format=interactive",
  sheets_gid="337263220",
  sql_file="well-known_security.sql"
  )
}}

今年は`security.txt` URIの`expires`プロパティを持つ割合が0.7％から2.3％に増加しました。`expires`プロパティは標準に基づいて必要なプロパティであるため、より多くのウェブサイトが標準にしたがっているのを見るのは良いことです。`policy`は`security.txt` URIでもっとも人気のあるプロパティのままです。`policy`は、セキュリティ研究者が脆弱性を報告するために従うべき手順を説明しているため、`security.txt` URIにとって非常に重要です。

### `change-password`

<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/">`change-password`</a>は、現在編集ドラフト状態にあるW3CのWebアプリケーションセキュリティ作業グループの仕様です。この特定のよく知られたURIは、ユーザーやソフトウェアがパスワード変更用のリンクを簡単に特定できる方法として提案されました。

{{ figure_markup(
  image="usage-of-change-password.png",
  caption="change-passwordエンドポイントの使用。",
  description="デスクトップでは0.28％のウェブサイト、モバイルでは0.26％のウェブサイトがchange-passwordエンドポイントを使用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1340997331&format=interactive",
  sheets_gid="168419039",
  sql_file="well-known_change-password.sql"
  )
}}

このよく知られたURIの採用率はまだ非常に低いです。仕様はまだ作業中であるため、多くのウェブサイトがこれを採用していないのは理解できます。また、サインインシステムを持たないウェブサイトには、パスワード変更フォームがない場合もあります。

### ステータスコードの信頼性検出

この特定のよく知られたURIは、ウェブサイトのHTTPレスポンスステータスコードの信頼性を決定します。このURIもまだ<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html">編集ドラフト</a>の状態にあり、将来変更される可能性があります。このよく知られたURIの背景にある考え方は、ウェブサイトに存在すべきではないというものです。したがって、このよく知られたURIは<a hreflang="en" href="https://fetch.spec.whatwg.org/#ok-status">ok-status</a>で応答すべきではありません。リダイレクトして"ok-status"を返す場合、そのウェブサイトのステータスコードは信頼できないという意味です。

{{ figure_markup(
  image="detecting-status-code-reliability.png",
  caption="存在しないはずのリソースのステータスコードの検出。",
  description="`resource-that-should-not-exist-whose-status-code-should-not-be-200`エンドポイントによる応答ステータスを示す棒グラフ。デスクトップのウェブサイトの10％が200を返し、84％がnot-okステータスを返し、6％が201-299のステータスコードを返します。モバイルのウェブサイトでは、9％が200を返し、84％がnot-okステータスを返し、7％が201-299のステータスコードを返します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPHK3G2Ir-ys_oTrrhugqxV0aOSj3y5d1lANQ54GdaQtIHrzXIjQQGEpIdT_mQvxTrMtpd0Hn30zhF/pubchart?oid=1477977449&format=interactive",
  sheets_gid="1163882629",
  sql_file="well-known_resource-not-be-200.sql"
  )
}}

このよく知られたURIに対して、モバイルとデスクトップのウェブサイトの84％がnot-okステータスで応答しています。この仕様の良い点は、ウェブサイトが正しく設定されていれば、ウェブサイト開発者が特定の変更を行う必要がなく、自動的に機能することです。

## 結論

今年の分析によると、過去数年にわたって見られたように、ウェブサイトはセキュリティ機能の向上を続けています。また、ウェブセキュリティの採用が遅れていた多くの国々がその使用を増やしていることも、興味深い観察点です。これは、ウェブセキュリティに対する一般的な意識が高まっていることを意味しているかもしれません。

ウェブ開発者が新しい標準を徐々に採用し、古いものを置き換えていることもわかりました。これは間違いなく正しい方向への一歩です。インターネット上でのセキュリティとプライバシーの重要性は日々高まっています。ウェブは多くの人々の生活に不可欠な部分となっており、そのため、ウェブ開発者はウェブセキュリティ機能の使用を続けて増やすべきです。

より厳格なコンテンツセキュリティポリシーを設定する上で、まだ多くの進歩が必要です。クロスサイトスクリプティングは依然として<a hreflang="en" href="https://owasp.org/Top10/">OWASP Top 10</a>に含まれています。このような攻撃を防ぐために、より厳格な`script-src`ディレクティブの広範な採用が必要です。また、より多くの開発者がWeb Cryptography APIを活用することを検討することもできます。security.txtのようなよく知られたURIを採用するためにも同様の努力が必要です。これは、セキュリティ専門家がウェブサイトの脆弱性を報告する方法を提供するだけでなく、開発者がウェブサイトのセキュリティを重視しており、改善に積極的であることを示しています。

過去数年にわたるウェブセキュリティの使用における継続的な進歩を観察することは励みになりますが、ウェブが成長を続け、セキュリティがより重要になるにつれて、ウェブコミュニティはさらに多くのセキュリティ機能の研究と採用を続ける必要があります。
