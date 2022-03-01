---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: セキュリティ
description: 2020年版Web Almanacのセキュリティの章では、トランスポート層のセキュリティ、コンテンツセキュリティ（CSP、機能ポリシー、SRI）、Web防御メカニズム（XSS、XS-Leaksへの取り組み）、広く使用されている技術の更新方法をカバーしています。
authors: [tomvangoethem, nrllh, tunetheweb]
reviewers: [cqueern, edmondwwchan]
analysts: [tomvangoethem, nrllh]
editors: [tunetheweb]
translators: [ksakae1216]
tomvangoethem_bio: Tom Van Goethemは、ベルギーのルーベン大学の<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNetグループ</a> の研究者です。彼の研究は、セキュリティやプライバシーの問題につながるウェブ上の新たなサイドチャネル攻撃を発見し、その原因となる漏洩をパッチで修正する方法を見出すことに重点を置いています。
nrllh_bio: Nurulullah Demirは、<a hreflang="en" href="https://www.internet-sicherheit.de/en/">Institute for Internet Security</a>のセキュリティ研究者であり、博士課程の学生です。彼の研究は、屈強なWebセキュリティメカニズムと敵対的な機械学習に焦点を当てています。
tunetheweb_bio: Barry Pollardはソフトウェア開発者であり、Manningの本<a hreflang="en" href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a> の著者でもあります。彼はウェブは素晴らしいと思っていますが、それをもっと良くしたいと思っています。<a href="https://twitter.com/tunetheweb">@tunetheweb</a> でつぶやき、<a hreflang="en" href="https://www.tunetheweb.com">www.tunetheweb.com</a> でブログを書いています。
discuss: 2047
results: https://docs.google.com/spreadsheets/d/1T7sxPP5BV3uwv-sXhBEZraVk-obd0tDfFrLiD49nZC0/
featured_quote: 本章では、ウェブ上のセキュリティの現状を探ります。様々なセキュリティ機能の採用を詳細かつ大規模に分析することで、ユーザーを守りたいという動機から、ウェブサイトの所有者がこれらのセキュリティメカニズムを適用する様々な方法についての洞察を得ます。
featured_stat_1: 86.90%
featured_stat_label_1: モバイルでHTTPSを使用するリクエスト。
featured_stat_2: 22,333
featured_stat_label_2: 観測された最長のCSPのバイト数。
featured_stat_3: 9.03%
featured_stat_label_3: reCAPTCHAの使い方
---

## 序章

様々な意味で、2020年はとんでもない年になりました。世界的な大流行の結果、私たちの日常生活は大きく変化しました。友人や家族と直接会う代わりに、多くの人が連絡を取り合うためソーシャルメディアに頼らざるを得なくなった。これは、ユーザーがオンラインで過ごす時間が増えた結果、<a hreflang="en" href="https://arxiv.org/pdf/2008.10959.pdf">多くの異なるアプリケーション</a>のトラフィック量が大幅に<a hreflang="en" href="https://dl.acm.org/doi/pdf/10.1145/3419394.3423621">増加</a>したことを意味します。これはまた、様々なプラットフォーム上でオンラインで共有する情報を安全に保つために、セキュリティがこれまで以上に重要になっていることを意味しています。

私たちが日常的に利用しているプラットフォームやサービスの多くは、クラウドベースのAPI、マイクロサービス、そして最も重要なのはWebアプリケーションに至るまで、Webリソースに強く依存しています。これらのシステムの安全性を維持することは容易なことではありません。幸いなことに、過去10年間、Webセキュリティの研究は継続的に進歩してきました。一方で、研究者は新しいタイプの攻撃を発見し、その結果をより広いコミュニティと共有して意識を高めています。一方で、多くのエンジニアや開発者は、攻撃の結果を防止または最小化するため使用できる適切なツールやメカニズムのセットをウェブサイト運営者に提供するために、たゆまぬ努力を続けています。

本章では、ウェブ上のセキュリティの現状を探ります。様々なセキュリティ機能の採用を詳細かつ大規模に分析することで、ユーザーを守りたいという動機から、ウェブサイトの所有者がこれらのセキュリティメカニズムを適用する様々な方法についての洞察を得ます。

私たちは、個々のウェブサイトにおけるセキュリティメカニズムの採用だけではありません。ウェブサイトを構築するために使用される技術スタックなどのさまざまな要因が、セキュリティヘッダーの普及にどのように影響を与え、全体的なセキュリティを向上させるかを分析しています。さらに、ウェブサイトのセキュリティを確保するためには、多くの異なる側面をカバーする全体的なアプローチが必要であると言ってもよいでしょう。そのため、我々は、広く使われている様々なウェブ技術のパッチ適用方法など、他の側面も評価しています。

### 方法論

本章では、ウェブ上での様々なセキュリティメカニズムの採用状況を報告します。この分析は、560万のデスクトップドメインと630万のモバイルドメインのホームページについて収集したデータに基づいています。特に明記されていない限り、報告されている数字はモバイルのデータセットの方がサイズが大きいため、モバイルのデータセットに基づいています。ほとんどのウェブサイトが両方のデータセットに含まれているため、結果として得られる測定値はほぼ同じです。2つのデータセットの間に有意な差がある場合は、本文中で報告するか、または図から明らかになるようにしています。データがどのように収集されたかについての詳細は、[方法論](./methodology)を参照してください。

## トランスポートのセキュリティ

昨年は、WebサイトでのHTTPSの普及が続いています。トランスポート層の安全性を確保することは、Webセキュリティの最も重要な部分の1つです。Webサイト用にダウンロードしたリソースが転送中に変更されていないこと、また自分が思っているWebサイトとの間でデータを転送していることを確信できなければ、Webサイトのセキュリティについての確信は事実上無効となります。

WebトラフィックをHTTPSに移行し、最終的には<a hreflang="en" href="https://www.chromium.org/Home/chromium-security/marking-http-as-non-secure">HTTPを非セキュアなものとしてマーク</a> するようになったのは、ブラウザが[セキュアなコンテキストへの強力な新機能](https://developer.mozilla.org/ja/docs/Web/Security/Secure_Contexts/features_restricted_to_secure_contexts)（人参）を制限する一方で、暗号化されていない接続が使用された場合にユーザーに表示される警告を増加させるためです（棒）。

{{ figure_markup(
  caption="モバイルでHTTPSを利用するリクエストの割合。",
  content="86.90%",
  classes="big-number",
  sheets_gid="1558058913"
)
}}

この努力が実を結び、現在ではデスクトップでのリクエストの87.70％、モバイルでのリクエストの86.90％がHTTPSで提供されています。

{{ figure_markup(
  image="security-https-request-growth.png",
  caption='HTTPSを使用したリクエストの割合<br>(出典。<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">HTTP Archive</a>)',
  description="2017年1月1日から2020年8月1日までのHTTPSリクエストの時系列図。モバイルとデスクトップの利用状況はほぼ同じで、デスクトップが35.70％、モバイルが35.20％のリクエストから始まり、最後は少し尾を引いてデスクトップが87.70％、モバイルが86.90％までずっと増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1353660053&format=interactive",
  sheets_gid="1558058913"
  )
}}

この目標の最後に到達したとき懸念されるのは、ここ数年の印象的な成長の「平準化」が顕著になっていることです。残念ながらインターネットのロングテールは、古いレガシーサイトが維持管理されておらず、HTTPSでの運用ができない可能性があることを意味しています。

{{ figure_markup(
  image="security-https-usage-by-site.png",
  caption="サイトのHTTPS使用量",
  description="デスクトップサイトの77.44%がHTTPSを使用しており、残りの22.56%がHTTPを使用していることを示す棒グラフと、モバイルサイトの73.22%がHTTPSを使用しており、残りの26.78%がHTTPを使用していることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=103775737&format=interactive",
  sheets_gid="1558058913",
  sql_file="home_page_https_usage.sql"
  )
}}

リクエストの量が多いことは励みになりますが、これらのリクエストは、[サードパーティ](./third-parties)リクエストやGoogleアナリティクス、フォント、または広告などのサービスに支配されていることがよくあります。ウェブサイト自体が遅れていることもありますが、現在では73%から77%のサイトがHTTPSで提供されており、使用率が向上していることがわかります。

### プロトコルのバージョン

HTTPSが現在では完全に標準となっているため、課題はHTTPSの種類を問わず、基礎となるTLS(Transport Layer Security)プロトコルの安全なバージョンを確実に使用することに移ってきています。TLSのバージョンが古くなったり、脆弱性が発見されたり、計算能力が向上して攻撃が可能になったりすると、TLSのメンテナンスが必要になります。

{{ figure_markup(
  image="security-tls-version-by-site.png",
  caption="サイトのTLSバージョンの使用状況",
  description="デスクトップでは55.98%のサイトがTLSv1.2を使用しており、43.23%のサイトがTLSv1.3を使用していることを示す棒グラフ。モバイルでは、それぞれ53.82%と45.37%となっています。TLSv1.0、TLSv1.1は、QUICの利用はごくわずかですが（デスクトップで0.62%、モバイルで0.67%）、ほとんど登録されていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=840326541&format=interactive",
  sheets_gid="1486844039",
  sql_file="tls_versions_pages.sql"
  )
}}

TLSv1.0の使用率はすでに基本的にはゼロであり、パブリックウェブがより安全なプロトコルを採用していることを励みに見えるかもしれませんが、私たちのクロールがベースになっているChromeを含むすべての主流のブラウザは、これを説明するための大きな方法を行くデフォルトでこれをブロックすることに注意する必要があります。

これらの数字は[昨年のプロトコル分析](../2019/security#protocol-versions)に比べてわずかに改善されており、TLSv1.3の使用率は約5%増加し、それに対応するTLSv1.2は減少しています。これは小さな増加のようで、昨年指摘された比較的新しいTLSv1.3の使用率が高かったのは、大規模なCDNからの初期サポートが原因である可能性が高いと思われます。従ってTLSv1.3の採用にもっと大きな進展があるとすれば、まだTLSv1.2を使用している人は自分自身で管理しているか、まだサポートしていないホスティングプロバイダーで管理している可能性があるため、長い時間が必要になるでしょう。

### 暗号スイート

TLSの中には、さまざまなレベルのセキュリティで使用できるいくつかの暗号スイートがあります。最高の暗号化方式は[forward secrecy](https://ja.wikipedia.org/wiki/Forward_secrecy)鍵交換をサポートしています。これはサーバの鍵が漏洩しても、その鍵を使った古いトラフィックは復号化できないことを意味します。

過去にはTLSの新しいバージョンでは、より新しい暗号のサポートが追加されていましたが、古いバージョンを削除することはほとんどありませんでした。これがTLSv1.3がより安全である理由の1つです。人気のあるOpenSSLライブラリは、このバージョンでは5つの安全な暗号のみをサポートしていますが、そのすべてが前方秘匿をサポートしています。これにより、安全性の低い暗号を強制的に使用されるダウングレード攻撃を防ぐことができます。

{{ figure_markup(
  caption="Forward secrecyを利用したモバイルサイト",
  content="98.03%",
  classes="big-number",
  sheets_gid="1643542759",
  sql_file="tls_forward_secrecy.sql"
)
}}

すべてのサイトは本当にforward secrecyを使用すべきであり、デスクトップサイトの98.14％、モバイルサイトの98.03％が前方秘匿暗号を使用しているのは良いことです。

forward secrecyを前提とした場合、暗号化レベルの選択は、鍵サイズが大きいほど破られるまでに時間がかかりますが、その代償として、特に初期接続時の暗号化・復号化にかかる計算量が多くなります。[ブロック暗号モード](https://ja.wikipedia.org/wiki/%E6%9A%97%E5%8F%B7%E5%88%A9%E7%94%A8%E3%83%A2%E3%83%BC%E3%83%89)ではGCMを使用し、<a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">CBCはパディング攻撃に弱いとされています</a>。

広く使われているAES(Advanced Encryption Standard)では、128ビットと256ビットの暗号化キーサイズが一般的です。ほとんどのサイトでは128ビットで十分ですが、256ビットの方が望ましいでしょう。

{{ figure_markup(
  image="security-distribution-of-cipher-suites.png",
  caption="暗号スイートの分布",
  description="デバイス別に使用されている暗号スイートを棒グラフで示したもの、デスクトップサイトとモバイルサイトの78.4%がAES_128_GCMを使用しており、デスクトップサイトの19.1%、モバイルサイトの18.5%がAES_256_GCMを使用しており、AES_256_CBCはデスクトップサイトの44%、モバイルサイトの1.86%が使用している。 デスクトップサイトの1.44%、モバイルサイトの1.86%、CHACHA20_POLY1305の利用率はそれぞれ0.66%、0.72%、AES_128_CBCの利用率はそれぞれ0.43%、0.44%、3DES_EDE_CBCの利用率はデスクトップの0.01%、モバイルの約0.0%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1464905386&format=interactive",
  sheets_gid="1919501829",
  sql_file="tls_cipher_suite.sql"
  )
}}

上記のチャートから、AES_128_GCMが最も一般的で、デスクトップサイトとモバイルサイトの78.4%が使用していることがわかります。AES_256_GCMはデスクトップサイトの19.1%、モバイルサイトの18.5%が使用しており、その他のサイトは古いプロトコルや暗号スイートを使用しているサイトである可能性が高いです。

注意すべき重要な点の1つは、私たちのデータはサイトに接続するためにChromeを実行していることに基づいており、接続には単一のプロトコル暗号を使用するということです。私たちの[方法論](./methodology)では、サポートされているプロトコルや暗号スイートの全範囲を見ることはできず、その接続に実際使用されたものだけを見ることができます。この情報については、<a hreflang="en" href="https://www.ssllabs.com/ssl-pulse/">SSL Pulse from SSL Labs</a>のような他の情報源を見る必要がありますが、現在ほとんどの最新ブラウザが同様のTLS機能をサポートしているため、上記のデータは大多数のユーザーが使用すると予想されるものです。

### 証明書発行機関

次に、クロールしたサイトが使用しているTLS証明書を発行している認証局(CA)について見ていきます。[昨年の章](../2019/security#certificate-authorities)では、このデータに対するリクエストを見ましたが、それはGoogleのような人気のあるサードパーティによって支配されるでしょう（そのメトリックから今年も支配されている）ので、今年はウェブサイトがロードする他のすべてのリクエストではなく、ウェブサイト自体によって使用されるCAを提示するつもりです。

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
        <td>Cloudflare Inc ECC CA-2</td>
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
  <figcaption>{{ figure_link(caption="ウェブサイト用の証明書発行会社トップ10", sheets_gid="1486167130", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

Let's Encryptが首位に立っているのを見ても不思議ではありません。無料の証明書と自動化された証明書の組み合わせは、個々のウェブサイトの所有者とプラットフォームの両方で勝者を証明しています。Cloudflareは同様に、2番目と9番目の位置を取っている顧客のための無料の証明書を提供しています。さらに興味深いのは、使用されているECC Cloudflareの発行者です。ECC証明書はRSA証明書よりも小さいので効率的ですが、サポートが万能ではなく、両方の証明書を管理するには余分な労力を必要とすることが多いため、導入が複雑になることがあります。これは、Cloudflareがここで行っているように、CDNまたはホストされているプロバイダーがこれを管理できる場合のメリットです。ECCをサポートしているブラウザ（クロールで使用しているChromeブラウザのようなもの）はECCを使用し、古いブラウザはRSAを使用します。

### ブラウザの強制

暗号攻撃から身を守るためには安全なTLS構成を持つことが最も重要ですが、ネットワーク上の攻撃者からウェブユーザを保護するためには、さらなる保護が必要です。例えば、ユーザーがHTTP上の任意のウェブサイトをロードするとすぐに、攻撃者は悪意のあるコンテンツを注入して、例えば他のサイトへのリクエストを行うことができます。

サイトが最も強力な暗号や最新のプロトコルを使用している場合でも、攻撃者はSSLストリッピング攻撃を使用して、被害者のブラウザを騙してHTTPSではなくHTTPで接続していると思わせることができます。さらに適切な保護が施されていないと、ユーザのCookieが最初のプレーンテキストHTTPリクエストに添付され、攻撃者はネットワーク上でCookieをキャプチャできます。

これらの問題を克服するために、ブラウザはこれを防ぐため有効にできる追加機能を提供しています。

#### HTTPの厳格なトランスポートセキュリティ

1つ目はHTTP Strict Transport Security(HSTS)で、いくつかの属性からなるレスポンスヘッダーを設定することで簡単に有効化できます。このヘッダーについては、モバイルホームページ内での採用率が16.88%となっています。HSTSを有効にしているサイトのうち、92.82%が有効にしています。つまり、max-age属性（ブラウザがHTTPS上のウェブサイトを何秒で*訪問*するかを決定する）の値が0よりも大きくなっています。

{{ figure_markup(
  image="security-hsts-max-age-values-in-days.png",
  caption="HSTSの`max-age`の値（日）。",
  description="`max-age`属性の値のパーセンタイルを日数に換算した棒グラフです。パーセンタイルではデスクトップが30日、モバイルが91日、25パーセンタイルではどちらも182日、50パーセンタイルではどちらも365日、75パーセンタイルではどちらも同じ365日、90パーセンタイルではどちらも730日となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1208109634&format=interactive",
  sheets_gid="236117763",
  sql_file="hsts_max_age_percentiles.sql"
) }}

この属性の異なる値を見てみると、大多数のWebサイトがかなりの将来にHTTPSを利用することになると確信していることがよくわかります： 半数以上のWebサイトが少なくとも1年間はHTTPSを利用するようブラウザに要求しています。

{{ figure_markup(
  caption="知られている最大のHSTSのmax-age。",
  content="1,000,000,000,000,000 years",
  classes="medium-number",
  sheets_gid="560555207",
  sql_file="hsts_attributes.sql"
)
}}

あるウェブサイトでは、自分のサイトがHTTPSで利用できるようになるまでの期間について少し熱心に考えすぎて、1,000,000,000,000,000,000,000,000年に翻訳される`max-age`属性値を設定してしまったかもしれません。皮肉なことに、一部のブラウザはこのような大きな値をうまく扱えず、実際にはそのサイトのHSTSを無効にしてしまうのです。

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
        <td><code>max-age</code>有効</td>
        <td class="numeric">92.21%</td>
        <td class="numeric">92.82%</td>
      </tr>
      <tr>
        <td><code>includeSubdomains</code></td>
        <td class="numeric">32.97%</td>
        <td class="numeric">32.14%</td>
      </tr>
      <tr>
        <td><code>preload</code></td>
        <td class="numeric">16.02%</td>
        <td class="numeric">16.56%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="HSTSディレクティブの使用法。", sheets_gid="560555207", sql_file="hsts_attributes.sql") }}</figcaption>
</figure>

昨年](../2019/security#http-strict-transport-security)と比較して、他の属性の採用が増加していることは心強いことです。HSTSポリシーのうち、`includeSubdomains`が32.14%、`preload`が16.56%となっています。

## Cookies

セキュリティの観点から見ると、クロスサイトリクエストにCookieを自動的に含めることは、いくつかのクラスの脆弱性の主犯と見ることができます。もしウェブサイトが適切な保護機能を持っていない場合（例えば、状態を変更するリクエストに固有のトークンを要求するなど）、<a hreflang="en" href="https://owasp.org/www-community/attacks/csrf">Cross-Site Request Forgery</a> (CSRF)攻撃にさらされる可能性があります。例えば攻撃者はユーザーが気づかないうちに、訪問者のパスワードを変更するために、バックグラウンドでPOSTリクエストを発行するかもしれません。ユーザーがログインしている場合、ブラウザは通常、このようなリクエストに自動的にCookieを含めます。

他にも、<a hreflang="en" href="https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-lekies.pdf">Cross-Site Script Inclusion</a>のように、クロスサイトリクエストにCookieを含めることに依存する攻撃がいくつかあります。(XSSI)や、<a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a>の脆弱性クラスの様々な手法を利用することができます。さらに、ユーザの認証はCookieを介してのみ行われることが多いため、攻撃者はCookieを取得することでユーザになりすますことができます。これは中間者攻撃(MITM)で、ユーザを騙して安全ではないチャネルで認証を行うことができます。あるいは、クロスサイトスクリプティング(XSS)の脆弱性を悪用することで、攻撃者はDOMを通じて`document.cookie`にアクセスすることでCookieを漏洩させることができます。

Cookieがもたらす脅威から身を守るために、ウェブサイトの開発者は、[Cookie](https://developer.mozilla.org/ja/docs/Web/HTTP/Cookies)に設定できる3つの属性、`HttpOnly`、`Secure`、および<a hreflang="ja" href="https://web.dev/i18n/ja/samesite-cookies-explained/">`SameSite`</a>を利用できます。1つ目はJavaScriptからのアクセスを防ぐもので、攻撃者がXSS攻撃でCookieを盗むことを防ぐことができます。`Secure`属性が設定されているCookieは、安全なHTTPS接続でのみ送信され、MITM攻撃での盗用を防げます。

最近導入された`SameSite`属性は、クロスサイトコンテキストでのCookieの送信方法を制限するために使用できます。属性には3つの値があります。`None`, `Lax`, `Strict` です。`SameSite=None`のCookieはすべてのクロスサイトリクエストに送信され、`Lax`のCookieはユーザーがリンクをクリックして新しいページに移動したときなどのナビゲートリクエストにのみ送信されます。最後に、`SameSite=Strict`属性を持つCookieはファーストパーティのコンテキストでのみ送信されます。

{{ figure_markup(
  image="security-httponly-secure-samesite-cookie-usage.png",
  caption="Cookie属性。",
  description="Cookieの属性をファーストパーティとサードパーティ別に分けた棒グラフ。ファーストパーティでは`HttpOnly`が30.5%、`Secure`が22.2%、`SameSite`が13.7%で、サードパーティでは`HttpOnly`が26.3%、`Secure`が68.0%、`SameSite`が53.2%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1113791085&format=interactive",
  sheets_gid="253049761",
  sql_file="cookie_attributes.sql"
) }}

2,500万枚のファーストサイトCookieと1億1,500万枚のサードパーティCookieに基づいた結果から、Cookie属性の使用は設定されたコンテキストに強く依存することがわかります。Cookieの`HttpOnly`属性の使い方は、ファーストパーティのCookie(30.5%)とサードパーティのCookie(26.3%)の両方で同様であることがわかる。

しかし、`Secure`属性と`SameSite`属性では大きな違いが見られます。ファーストパーティのコンテキストで設定されたすべてのCookieの22.2%に`Secure`属性が存在するのに対し、モバイルホームページのサードパーティのリクエストで設定されたすべてのCookieの68.0%がこのCookie属性を持っています。興味深いことに、デスクトップページでは、サードパーティのCookieの35.2%しかこの属性を持っていませんでした。

`SameSite`属性については、昨年(../2019/security#samesite)の時点では0.1%しかこの属性が設定されていなかったのに対し、利用率が大幅に増加していることがわかります。2020年8月時点では、ファーストパーティCookieの13.7%、サードパーティCookieの53.2%に`SameSite`属性が設定されていることが確認されています。

おそらく、この採用率の大きな変化は、Chromeがデフォルトオプションとして`SameSite=Lax`を設定したことに関連していると思われます。このことは、SameSite属性に設定されている値をより詳細に見ることで確認できます。ファーストパーティのクッキーの場合、その割合は48.0%と低くなっていますが、それでも重要な意味があります。クローラーはウェブサイトにログインしないため、ユーザーの認証に使用されるクッキーが異なる可能性があることに注意が必要です。

{{ figure_markup(
  image="security-samesite-cookie-attributes.png",
  caption="同じサイトのCookie属性。",
  description="SameSiteのCookie属性をファーストパーティとサードパーティ別に分けた棒グラフ。ファーストパーティでは`SameSite=lax`が50.06%、`SameSite=strict`が2.03%、`SameSite=none`が47.96%、サードパーティでは`SameSite=lax`が23.40%、`SameSite=strict`が0.10%、`SameSite=none`が76.50%の割合で利用されている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=24669187&format=interactive",
  sheets_gid="253049761",
  sql_file="cookie_attributes.sql"
) }}

Cookieを保護するために使用できる追加の仕組みとして、Cookieの名前の前に`__Secure-`または`__Host-`を付けることがあります。これら2つの接頭辞を持つCookieは`Secure`属性が設定されている場合にのみブラウザに保存されます。後者は追加の制限を課しており、`Path`属性を`/`に設定する必要があり、`Domain`属性の使用ができません。これは攻撃者がセッション固定攻撃を実行しようとしてCookieを他の値で上書きすることを防いでいます。

これらの接頭辞の使用量は比較的少なく、`__Secure-`接頭辞を使用して設定されたファーストパーティCookieは合計で4,433個（0.02%）、`__Host-`接頭辞を使用して設定されたファーストパーティCookieは1,502個（0.01%）でした。サードパーティのコンテキストで設定されたCookieの場合、プレフィックス付きCookieの相対的な数と似ています。

## コンテンツに含まれる

最近のウェブアプリケーションには、[JavaScript](./javascript)ライブラリからビデオプレイヤー、外部プラグインに至るまで、様々なサードパーティ製コンポーネントが含まれています。セキュリティの観点から信頼されていない可能性のあるコンテンツをウェブページに含めることは、悪意のあるJavaScriptが含まれている場合のクロスサイトスクリプティングなど、さまざまな脅威をもたらす可能性があります。このような脅威から身を守るために、ブラウザにはコンテンツが含まれるソースを制限したり、含まれるコンテンツに制限を課したりするためのメカニズムがいくつかあります。

### コンテンツセキュリティポリシー

どのオリジンがコンテンツの読み込みを許可しているかをブラウザに示すための主要なメカニズムの1つが、[`Content-Security-Policy` (CSP)](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)レスポンスヘッダーです。数多くのディレクティブを通して、ウェブサイト管理者はコンテンツをどのように含めるかを細かく制御できます。例えば、`script-src`ディレクティブは、どのオリジンからスクリプトをロードできるかを示します。全体では、CSPヘッダーが全ページの7.23%に存在していることがわかりましたが、モバイルページでCSPの採用率が4.73%であった昨年から53%も増加しています。

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
        <td class="numeric">61.61%</td>
        <td class="numeric">61.00%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors</code></td>
        <td class="numeric">55.64%</td>
        <td class="numeric">56.92%</td>
      </tr>
      <tr>
        <td><code>block-all-mixed-content</code></td>
        <td class="numeric">34.19%</td>
        <td class="numeric">35.61%</td>
      </tr>
      <tr>
        <td><code>default-src</code></td>
        <td class="numeric">18.51%</td>
        <td class="numeric">16.12%</td>
      </tr>
      <tr>
        <td><code>script-src</code></td>
        <td class="numeric">16.99%</td>
        <td class="numeric">16.63%</td>
      </tr>
      <tr>
        <td><code>style-src</code></td>
        <td class="numeric">14.17%</td>
        <td class="numeric">11.94%</td>
      </tr>
      <tr>
        <td><code>img-src</code></td>
        <td class="numeric">11.85%</td>
        <td class="numeric">10.33%</td>
      </tr>
      <tr>
        <td><code>font-src</code></td>
        <td class="numeric">9.75%</td>
        <td class="numeric">8.40%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CSPポリシーで使用される最も一般的なディレクティブ。", sheets_gid="491950531", sql_file="csp_directives_usage.sql") }}</figcaption>
</figure>

興味深いことにCSPポリシーで最も一般的に使用されているディレクティブを見ると、最も一般的なディレクティブは<a hreflang="en" href="https://www.w3.org/TR/upgrade-insecure-requests/">`upgrade-insecure-requests`</a>であり、安全でないスキームに含まれるコンテンツは、同じホストへの安全なHTTPS接続を介してアクセスすべきであることをブラウザへ知らせるために使用されています。

例えば、`<img src="http://example.com/foo.png">`は通常、安全ではない接続で画像を取得しますが、`upgrade-insecure-requests`ディレクティブがあると、自動的にHTTPS(`https://example.com/foo.png`)で取得します。

これは、ブラウザが混在するコンテンツをブロックする際に特に役立ちます。HTTPSで読み込まれるページでは、`upgrade-insecure-requests`ディレクティブがないと、HTTPからのコンテンツがブロックされてしまいます。このディレクティブはコンテンツを壊す可能性が低く実装が簡単なので、コンテンツセキュリティポリシーの良い出発点となりで、他のディレクティブに比べてこのディレクティブの採用率はかなり高くなるでしょう。

どのソースからコンテンツを含めることができるかを示すCSPディレクティブ（`*-src`ディレクティブ）は、採用率がかなり低くなっています: デスクトップページで提供されたCSPポリシーの18.51%とモバイルページで提供された16.12%に過ぎません。この理由の1つは、Web開発者が[CSPの採用における多くの課題に直面していることにあります](https://wkr.io/publication/raid-2014-content_security_policy.pdf)。厳格なCSPポリシーは、XSS攻撃を阻止する以上の大きなセキュリティ上の利点を提供できますが、不明確に定義されたポリシーは特定の有効なコンテンツの読み込みを妨げる可能性があります。

ウェブ開発者がCSPポリシーの正しさを評価できるようにするため、非強制的な代替手段も存在し、`Content-Security-Policy-Report-Only`応答ヘッダーでポリシーを定義することで有効にできます。このヘッダーの普及率はかなり低く、デスクトップおよびモバイルページの0.85%です。しかし、これはしばしば移行用のヘッダーであることに注意すべきです。そのため、この割合はCSPの使用への移行を意図しており、限られた時間だけReport-Onlyヘッダーを使用しているサイトを示している可能性が高い。

{{ figure_markup(
  image="security-csp-header-length.png",
  caption="CSPヘッダーの長さ。",
  description="CSPヘッダーの長さのバイト数のパーセンタイルを示す棒グラフ。10パーセンタイルではデスクトップが23バイト、モバイルが24バイト、25パーセンタイルではどちらも25バイト、50パーセンタイルではどちらも75バイト、75パーセンタイルではデスクトップが78バイト、モバイルが81バイト、90パーセンタイルではデスクトップが365バイト、モバイルが316バイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1825551550&format=interactive",
  sheets_gid="150007358",
  sql_file="csp_number_of_allowed_hosts.sql"
) }}

全体的に、`Content-Security-Policy`応答ヘッダーの長さは非常に限られている: ヘッダーの値の長さの中央値は75バイトである。これは主に、頻繁に使用される短い単一目的のCSPポリシーによるものである。例えば、デスクトップページで定義されているポリシーの24.64%は、`upgrade-insecure-requests`ディレクティブのみを持っている。

最も一般的なヘッダー値は、デスクトップページで定義された全ポリシーの29.44%を占め、`block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;`となっています。このポリシーはページがフレーム化されるのを防ぎ、セキュアプロトコルへのアップグレード要求を試み、失敗した場合はコンテンツをブロックします。

{{ figure_markup(
  caption="観測された最長のCSPのバイト数。",
  content="22,333",
  classes="big-number",
  sheets_gid="150007358",
  sql_file="csp_number_of_allowed_hosts.sql"
)
}}

その反対側では、観測された最長のCSPポリシーは22,333バイトでした。

<figure>
  <table>
    <thead>
      <tr>
        <th>Origin</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
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
<figcaption>{{ figure_link(caption="CSPポリシーで最も頻繁に許可されるホスト。", sheets_gid="1634036486", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>

コンテンツの読み込みが許可される外部のオリジンは、意外にも、[サードパーティコンテンツ](./third-parties#third-party-domains)が最も頻繁に含まれるオリジンと一致しています。CSPポリシーの`*-src`属性で定義されている最も一般的な10のオリジンは、すべてGoogle（アナリティクス、フォント、広告）とFacebookにリンクできます。

{{ figure_markup(
  caption="CSPで観測された許可されたホストの最大数。",
  content="403",
  classes="big-number",
  sheets_gid="1634036486",
  sql_file="csp_allowed_host_frequency.sql"
)
}}

あるサイトでは、含まれているすべてのコンテンツがCSPによって許可されることを保証するために、そのポリシーで403の異なるホストを許可することにしました。もちろん、これはセキュリティ上の利点をせいぜい限界にします。特定のホストが<a hreflang="en" href="https://webappsec.dev/assets/pub/csp_acm16.pdf">CSP bypasses</a>を許可するかもしれないからです。

### サブリソースの完全性

多くのJavaScriptライブラリやスタイルシートはCDNから含まれています。その結果、CDNが侵害されたり、攻撃者が頻繁に含まれているライブラリを置き換える別の方法を見つけたりすると、悲惨な結果になる可能性があります。

漏洩したCDNの影響を制限するために、ウェブ開発者はサブリソース整合性(SRI)メカニズムを利用できます。期待される内容のハッシュからなる`integrity`属性を`<script>`と`<link>`要素に定義できます。ブラウザは、取得したスクリプトやスタイルシートのハッシュを属性で定義されたハッシュと比較し、 一致するものがある場合にのみコンテンツを読み込みます。

ハッシュは3つの異なるアルゴリズムで計算できます。SHA256、SHA384、SHA512です。最初の2つが最も頻繁に使用されています。モバイルページではそれぞれ50.90%と45.92%です（デスクトップページでも同様です）。現在のところ、3つのハッシュアルゴリズムはすべて安全に使用できると考えられています。

{{ figure_markup(
  image="security-subresource-integrity-coverage-per-page.png",
  caption="サブリソースの完全性：ページごとのカバレッジ。",
  description="ページ上のスクリプトの何パーセントがSRIで保護されているかのパーセンタイルを示す棒グラフ。10パーセンタイルではデスクトップとモバイルの両方で2.0%、25パーセンタイルでは両方で2.9%、50パーセンタイルでは両方で4.2%、75パーセンタイルではデスクトップで7.1%、モバイルで6.9%、90パーセンタイルでは両方で15.8%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1581504207&format=interactive",
  sheets_gid="599225326",
  sql_file="sri_coverage_per_page.sql"
) }}

デスクトップページの7.79%では、少なくとも1つの要素にintegrity属性が含まれており、モバイルページでは7.24%となっています。この属性は主に`<script>`要素で使用されます。整合性属性を持つ全ての要素の72.77%はscript要素に含まれていました。

少なくとも1つのスクリプトがSRIで保護されているページをさらに詳しく見ると、これらのページのスクリプトの大部分が完全性属性を持っていないことがわかります。ほとんどのサイトでSRIで保護されているスクリプトは20個中1個以下でした。

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
<figcaption>{{ figure_link(caption="SRIで保護されたスクリプトが含まれる最も一般的なホスト。", sheets_gid="2132259293", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

SRIで保護されたスクリプトが含まれている最も人気のあるホストを見ると、その採用を後押ししているいくつかの要因が見えてきます。例えば、サブリソースの完全性で保護されているスクリプトのほぼ半分は`cdn.shopify.com`からのもので、これはShopify SaaSが顧客のためにデフォルトで有効にしているためである可能性が高い。

SRIで保護されたスクリプトが含まれている上位5ホストの残りは、3つのCDNで構成されています。<a hreflang="en" href="https://code.jquery.com/">jQuery</a>、<a hreflang="en" href="https://cdnjs.com/">cdnjs</a>、<a hreflang="en" href="https://www.bootstrapcdn.com/">Bootstrap</a>です。これら3つのCDNのすべてが、例のHTMLコードにIntegrity属性を持っているのは、おそらく偶然ではありません。

### 特徴的なポリシー

ブラウザは無数のAPIや機能を提供しているが、その中にはユーザの体験やプライバシーを損なうものもある。レスポンスヘッダー`Feature-Policy`を通して、ウェブサイトはどの機能を使いたいか、あるいはもっと重要なことにどの機能を使いたくないかを示すことができます。

同様に、`<iframe>`要素に`allow`属性を定義することで、埋め込まれたフレームが使用を許可する機能を決定することもできます。例えば、`autoplay`ディレクティブを使って、ウェブサイトはページが読み込まれたときにフレーム内の動画の再生を自動的に開始するかどうかを指定できます。

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
        <td><code>encrypted-media</code></td>
        <td class="numeric">78.83%</td>
        <td class="numeric">78.06%</td>
      </tr>
      <tr>
        <td><code>autoplay</code></td>
        <td class="numeric">47.14%</td>
        <td class="numeric">48.02%</td>
      </tr>
      <tr>
        <td><code>picture-in-picture</code></td>
        <td class="numeric">23.12%</td>
        <td class="numeric">23.28%</td>
      </tr>
      <tr>
        <td><code>accelerometer</code></td>
        <td class="numeric">23.10%</td>
        <td class="numeric">23.22%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">23.05%</td>
        <td class="numeric">23.20%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td class="numeric">8.57%</td>
        <td class="numeric">8.70%</td>
      </tr>
      <tr>
        <td><code>camera</code></td>
        <td class="numeric">8.48%</td>
        <td class="numeric">8.62%</td>
      </tr>
      <tr>
        <td><code>geolocation</code></td>
        <td class="numeric">8.09%</td>
        <td class="numeric">8.40%</td>
      </tr>
      <tr>
        <td><code>vr</code></td>
        <td class="numeric">7.74%</td>
        <td class="numeric">8.02%</td>
      </tr>
      <tr>
        <td><code>fullscreen</code></td>
        <td class="numeric">4.85%</td>
        <td class="numeric">4.82%</td>
      </tr>
      <tr>
        <td><code>sync-xhr</code></td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.21%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="フレーム上のフィーチャーポリシーディレクティブの普及率。", sheets_gid="547110187", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

レスポンスヘッダー`Feature-Policy`の採用率は、デスクトップページでは0.60%、モバイルページでは0.51%とかなり低い。一方、デスクトップページでは、800万フレームのうち19.5%でFeature Policyが有効になっていました。モバイルページでは、920万フレームのうち16.4%が`allow`属性を含んでいました。

iframeの機能ポリシーで最もよく使われているディレクティブを見ると、これらは主にフレームが動画を再生する方法を制御するために使われていることがわかります。例えば、最も一般的なディレクティブである`encrypted-media`は、DRMで保護された動画を再生するために必要なEncrypted Media Extensions APIへのアクセスを制御するために使用されます。フィーチャーポリシーを持つフレームの起源として最も多いのは `https://www.facebook.com`と`https://www.youtube.com`でした (デスクトップページのフィーチャーポリシーを持つフレームの49.87%と26.18%でした)。

### Iframeサンドボックス

信頼できないサードパーティをiframeに含めることで、そのサードパーティはページ上で様々な攻撃を試みることができます。例えば、トップページをフィッシングページに誘導したり、偽のアンチウイルス広告を表示したポップアップを起動したりできます。

iframeの`sandbox`属性は、埋め込まれたウェブページの機能を制限し、その結果、攻撃を開始する機会を制限するために使用することができます。広告や動画などのサードパーティコンテンツを埋め込むことはウェブ上では一般的なことなので、これらの多くが`sandbox`属性によって制限されていることは驚くべきことではありません。デスクトップページのiframeの30.29%が`sandbox`属性を持っているのに対し、モバイルページでは33.16%となっています。

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
        <td><code>allow-scripts</code></td>
        <td class="numeric">99.97%</td>
        <td class="numeric">99.98%</td>
      </tr>
      <tr>
        <td><code>allow-same-origin</code></td>
        <td class="numeric">99.64%</td>
        <td class="numeric">99.70%</td>
      </tr>
      <tr>
        <td><code>allow-popups</code></td>
        <td class="numeric">83.66%</td>
        <td class="numeric">89.41%</td>
      </tr>
      <tr>
        <td><code>allow-forms</code></td>
        <td class="numeric">83.43%</td>
        <td class="numeric">89.22%</td>
      </tr>
      <tr>
        <td><code>allow-popups-to-escape-sandbox</code></td>
        <td class="numeric">81.99%</td>
        <td class="numeric">87.22%</td>
      </tr>
      <tr>
        <td><code>allow-top-navigation-by-user-activation</code></td>
        <td class="numeric">59.64%</td>
        <td class="numeric">69.45%</td>
      </tr>
      <tr>
        <td><code>allow-pointer-lock</code></td>
        <td class="numeric">58.14%</td>
        <td class="numeric">67.65%</td>
      </tr>
      <tr>
        <td><code>allow-top-navigation</code></td>
        <td class="numeric">21.38%</td>
        <td class="numeric">17.31%</td>
      </tr>
      <tr>
        <td><code>allow-modals</code></td>
        <td class="numeric">20.95%</td>
        <td class="numeric">17.07%</td>
      </tr>
      <tr>
        <td><code>allow-presentation</code></td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="フレーム上のサンドボックスディレクティブの出現率。", sheets_gid="402256187", sql_file="iframe_sandbox_directives.sql") }}</figcaption>
</figure>

iframeの`sandbox`属性が空の値を持つ場合、これは最も制限の多いポリシーになります：埋め込まれたページはJavaScriptコードを実行できず、フォームを送信できず、ポップアップも作成できません。

このデフォルトのポリシーは、さまざまなディレクティブを使って細かく緩和することができます。最もよく使われるディレクティブである`allow-scripts`は、デスクトップページ上のすべてのサンドボックスポリシーの99.97%に存在し、埋め込まれたページがJavaScriptコードを実行できるようにします。もう1つは、事実上すべてのサンドボックスポリシーに存在する`allow-same-origin`というディレクティブで、埋め込みページがその起源を保持し、例えば、その起源で設定されたCookieにアクセスすることを許可します。

興味深いことに、Feature Policyとiframe sandboxは両方ともかなり高い採用率を持っていますが、それらが同時に発生することはほとんどありません：iframeの0.04%だけが`allow`と`sandbox`の両方の属性を持っています。おそらくこれは、iframeがサードパーティのスクリプトによって作成されているからだと思われます。フィーチャーポリシーは主にサードパーティの動画を含むiframeに追加されますが、`sandbox`属性は主に広告の機能を制限するために使用されます。デスクトップページの`sandbox`属性を持つiframeの56.40%は`https://googleads.g.doubleclick.net`を元にしています。

## 攻撃の阻止

現代のウェブアプリケーションは、さまざまなセキュリティ上の脅威に直面しています。例えば、ユーザの入力を不適切にエンコードしたり、サニタイズしたりすると、クロスサイトスクリプティング（XSS）の脆弱性が発生する可能性があり、これは10年以上も前からウェブ開発者を悩ませてきた問題です。ウェブアプリケーションがますます複雑になり、新しいタイプの攻撃が発見されるにつれ、さらに多くの脅威が迫ってきています。例えば、<a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a> は、ウェブアプリケーションが返すユーザ固有の動的なレスポンスを利用することを目的とした新しい攻撃のクラスです。

例えば、ウェブメールクライアントが検索機能を提供している場合、攻撃者は様々なキーワードへのリクエストをトリガーにして、その後、様々なサイドチャネルを通じて、これらのキーワードのどれかが結果をもたらしたかどうかを判断できます。これにより、攻撃者は、攻撃者のウェブサイトの知らない訪問者のメールボックス内で検索機能を効果的に利用できるようになります。

幸いなことにブラウザは、潜在的な攻撃の結果を制限することに対して非常に効果的なセキュリティメカニズムの大規模なセットも提供します。 CSPの`script-src`ディレクティブを介して、XSSの脆弱性を悪用することが非常に困難または不可能になる可能性があります。

[クリックジャッキング](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AA%E3%83%83%E3%82%AF%E3%82%B8%E3%83%A3%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0)攻撃を防ぐためには、`X-Frame-Options`ヘッダーが存在しなければならないか、CSPの`frame-ancestors`ディレクティブを使用して、現在の文書を埋め込むことができる信頼されたパーティを示すことができます。

{{ figure_markup(
  image="security-adoption-of-security-headers.png",
  caption="セキュリティヘッダーの採用",
  description="2019年と2020年のモバイルページのセキュリティヘッダーの普及率を示す棒グラフ。`Content-Security-Policy`はデスクトップで5%とモバイルで11%、`Expect-CT`はデスクトップで8%とモバイルで11%、`Feature-Policy`はデスクトップで0%とモバイルで1%、`Referrer-Policy`はデスクトップで6%とモバイルで7%、`Report-To`はデスクトップで2%、モバイルで3%となっている。`Strict-Transport-Security`はデスクトップで13%、モバイルで17%、`X-Content-Type-Options`はデスクトップで26%、モバイルで30%、`X-Frame-Options`はデスクトップで24%、モバイルで27%、`X-XSS-Protection`はデスクトップで16%、モバイルで18%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1262077475&format=interactive",
  sheets_gid="1613840789",
  sql_file="security_headers_prevalence.sql"
) }}

### セキュリティメカニズムの採用

ウェブ上で最も一般的なセキュリティ応答ヘッダーは[`X-Content-Type-Options`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/X-Content-Type-Options)であり、これはブラウザに広告されたコンテンツタイプを信頼するように指示し、応答内容に基づいてそれを盗聴しないようにします。これは例えば、攻撃者がクロスサイトスクリプティング攻撃を実行するためにHTMLコードとして解釈されるJSONPエンドポイントを悪用することを防ぐなど、MIMEタイプの混乱攻撃を効果的に防ぎます。

リストの次は、[`X-Frame-Options`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/X-Frame-Options)(XFO)応答ヘッダーであり、ページの約27%で有効になっています。このヘッダーは、CSPの`frame-ancestors`ディレクティブとともに、クリックジャッキング攻撃に対抗するために使用できる唯一の効果的なメカニズムです。しかし、XFOはクリックジャッキングに対して有用なだけでなく、<a hreflang="en" href="https://cure53.de/xfo-clickjacking.pdf">他の様々なタイプの攻撃</a>に対しても悪用を著しく困難にしています。Internet Explorerなどのレガシーブラウザでは、XFOは現在でもクリックジャッキング攻撃を防御する唯一のメカニズムですが、<a hreflang="en" href="https://www.usenix.org/system/files/sec20fall_calzavara_prepub.pdf">ダブルフレーミング攻撃</a>の影響を受けています。この問題は`frame-ancestors`CSPディレクティブで緩和されています。そのため、ユーザに可能な限りの最善の防御を与えるためには、両方のヘッダーを採用することが最善の方法と考えられます。

現在18.39%のWebサイトで採用されている[`X-XSS-Protection`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/X-XSS-Protection)ヘッダーは、ブラウザに内蔵されている反射型クロスサイトスクリプティングの検出機構を制御するために使用されていました。しかし、Chromeバージョン78では、ブラウザに内蔵されていたXSS検出機能が<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=968591">非推奨・削除</a>されています。これは、様々な迂回経路が存在し、攻撃者に悪用される可能性のある新たな<a hreflang="en" href="https://frederik-braun.com/xssauditor-bad.html">脆弱性や情報漏洩</a>を導入していたためです。他のブラウザベンダーは同様のメカニズムを実装していないため、`X-XSS-Protection`ヘッダーは最近のブラウザには効果がなく、安全に削除できます。それにもかかわらず、このヘッダーの採用率は昨年の15.50%から18.39%へとわずかに増加しています。

最も広く採用されている上位5つのヘッダーの残りの部分は、ウェブサイトのTLS実装に関連する2つのヘッダーで完結しています。[Strict-Transport-Security`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security)ヘッダーは、`max-age`属性で定義された期間だけHTTPS接続でウェブサイトを訪問するようブラウザに指示するため使用されます。このヘッダーの設定については、この章で詳しく説明している[この章の前半](#transport-security)。`Expect-CT`ヘッダーは、現在のWebサイトに発行された証明書が公開されている[Certificate Transparency](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Expect-CT)ログに表示される必要があるかどうかを確認するようブラウザに指示します。

全体的に見ると、昨年はセキュリティヘッダーの採用が増加していることがわかります。最も広く使用されているセキュリティヘッダーは、相対的に15～35パーセントの増加を示しています。最近導入された`Report-To`ヘッダーや`Feature-Policy`ヘッダーのような機能の採用が増加していることも注目に値します（後者は昨年の3倍以上に増加しています）。最も強い絶対的な成長はCSPヘッダーで、採用率は4.94%から10.93%に増加しています。

### CSPによるXSS攻撃の防止

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
        <td><code>strict-dynamic</code></td>
        <td class="numeric">2.40%</td>
        <td class="numeric">14.68%</td>
      </tr>
      <tr>
        <td><code>nonce-</code></td>
        <td class="numeric">8.72%</td>
        <td class="numeric">17.40%</td>
      </tr>
      <tr>
        <td><code>unsafe-inline</code></td>
        <td class="numeric">89.83%</td>
        <td class="numeric">92.28%</td>
      </tr>
      <tr>
        <td><code>unsafe-eval</code></td>
        <td class="numeric">84.03%</td>
        <td class="numeric">77.48%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="default-srcまたはscript-src指令を定義するポリシーに基づくCSPキーワードの普及率。", sheets_gid="876947926", sql_file="csp_script_source_list_keywords.sql") }}</figcaption>
</figure>

XSS攻撃を防ぐのに役立つ厳格なCSPを実装することは容易なことではありません。導入を容易にするために、CSPの最後のバージョン（バージョン3）では、`default-src`や `script-src`ディレクティブで使用できる新しいキーワードが提供されています。例えば、<a hreflang="en" href="https://content-security-policy.com/strict-dynamic/">`strict-dynamic`</a>キーワードは、既に信頼されているスクリプトによって動的に追加されたスクリプト、例えば、そのスクリプトが新しい`<script>`要素を作成したときなどを許可します。`default-src`または`script-src`ディレクティブを含むポリシー（全CSPの21.17%）では、この比較的新しいキーワードの採用率は14.68%となっています。興味深いことに、デスクトップページでは、このメカニズムの採用率は2.40%と大幅に低くなっています。

CSPの採用を容易にするもう1つのメカニズムはnoncesの使用です。CSPの`script-src`ディレクティブで、ページはキーワード`nonce-`の後にランダムな文字列を入力できます。ヘッダーで定義されたランダム文字列と同じ`nonce`属性が設定されているスクリプト（インラインでもリモートでも）はすべて実行が許可されます。このように、この仕組みを使えば、どのスクリプトが含まれているかを事前にすべての異なる起源を決定する必要はありません。nonceメカニズムは、`script-src`または`default-src`ディレクティブを定義したポリシーの17.40%で使用されていることがわかりました。また、デスクトップページでの採用率は8.72%と低かった。この大きな違いを説明することはできませんでしたが、[何か提案があれば聞いてください] (https://discuss.httparchive.org/t/2047)！

他の2つのキーワード、`unsafe-inline`と`unsafe-eval`は、それぞれ97.28%、77.79%と大多数のCSPに存在しています。このことは、XSS攻撃を阻止するポリシーを実装することの難しさを思い知らされます。しかし、`strict-dynamic`キーワードが存在する場合、`unsafe-inline`や`unsafe-eval`キーワードは事実上無視されてしまいます。古いブラウザでは`strict-dynamic`キーワードはサポートされていない可能性があるため、すべてのブラウザのバージョンとの互換性を維持するため、他の2つの安全でないキーワードを含めることが最善の方法と考えられています。

`strict-dynamic`や`nonce-`キーワードは、反映された持続的なXSS攻撃を防御するために使用できますが、保護されたページはDOMベースのXSS脆弱性に対して脆弱性を持っている可能性があります。このクラスの攻撃を防御するために、ウェブサイト開発者は<a hreflang="ja" href="https://web.dev/i18n/ja/trusted-types/">Trusted Types</a>を利用できます。これはかなり新しいメカニズムで、現在Chromiumベースのブラウザでのみサポートされています。Trusted Typesの採用には困難が伴う可能性があるにもかかわらず（ウェブサイトはポリシーを作成し、このポリシーに準拠するためJavaScriptコードを調整する必要があります）、また新しいメカニズムであることを考えると、11のホームページがCSPの`require-trusted-types-for`ディレクティブを通じてTrusted Typesをすでに採用していることは心強いことです。

### クロスオリジンポリシーによるXSリークの防御

<a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a>と呼ばれる新しいクラスの攻撃から身を守るために、最近、様々な新しいセキュリティメカニズムが導入されました（いくつかはまだ開発中です）。一般的に、これらのセキュリティメカニズムは、他のサイトが自分のサイトとどのように相互作用するかをウェブサイトの管理者がコントロールできるようにしています。例えば、[`Cross-Origin-Openener-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy) (COOP) レスポンスヘッダーは、ページを他の悪意のある可能性のあるブラウザコンテキストから分離処理すべきであることをブラウザに指示するために使用できます。そのため、敵対者はページのグローバルオブジェクトへの参照を取得することができません。その結果、<a hreflang="en" href="https://xsleaks.dev/docs/attacks/frame-counting/">frame counting</a>のような攻撃は、このメカニズムで防ぐことができます。データ収集が始まる数日前にChrome、Edge、Firefoxでしかサポートされていなかったこのメカニズムのアーリーアダプターが31件見つかりました。

[`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/ja/docs/Web/HTTP/Cross-Origin_Resource_Policy_(CORP))(CORP)ヘッダーは、Chrome、Firefox、Edgeでサポートされていますが、すでに1,712ページで採用されています（CORPはドキュメントだけでなく、すべてのリソースタイプで有効にできます/すべきであることに注意してください、したがってこの数は過小評価かもしれません）。ヘッダーは、ウェブリソースがどのように含まれることが予想されるかをブラウザに指示するために使用されます: 同一オリジン、同一サイト、クロスオリジン（制限が多いものから少ないものへ）。ブラウザは、CORPに違反する方法で含まれるリソースの読み込みを阻止します。このように、この応答ヘッダーで保護された機密リソースは、<a hreflang="en" href="https://spectreattack.com/spectre.pdf">Spectre攻撃</a>や様々な<a hreflang="en" href="https://xsleaks.dev/docs/defenses/opt-in/corp/">XS-Leaks攻撃</a>から保護されています。<a hreflang="en" href="https://fetch.spec.whatwg.org/#corb">Cross-Origin Read Blocking</a>(CORB)メカニズムも同様の保護を提供しますが、ブラウザではデフォルトで有効になっています（現在はChromiumベースのブラウザのみ）。

CORPに関連しているのは [`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy)(COEP)レスポンスヘッダーで、ページに読み込まれたリソースはすべてCORPヘッダーを持つべきであることをブラウザに指示するためにドキュメントで使用できます。さらに、Cross-Origin Resource Sharing(CORS)メカニズム（`Access-Control-Allow-Origin` ヘッダーなど）を通して読み込まれるリソースも許可されます。COOPと一緒にこのヘッダーを有効にすることで、ページは高精度タイマーや`SharedArrayBuffer`のような、潜在的にセンシティブなAPIへのアクセスを得ることができ、非常に正確なタイマーを構築するために使用することもできます。COEPを有効にしているページが6つ見つかりましたが、ヘッダーのサポートはデータ収集の数日前にブラウザへ追加されただけでした。

クロスオリジンポリシーのほとんどは、ウェブ上での利用が限られている（例えば、新しく開いたウィンドウへの参照を保持するなど）いくつかのブラウザ機能の潜在的に悪質な結果を無効にしたり、緩和したりすることを目的としています。そのため、COOPやCORPのようなセキュリティ機能を有効にすることは、ほとんどの場合、機能を壊すことなく行うことができます。したがって、これらのクロスオリジンポリシーの採用は、今後数ヶ月、数年の間に大幅に増加すると予想されます。

### ウェブ暗号API

<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a>は、外部ライブラリを必要とせず、少ない労力でクライアント側で安全に暗号処理を実行できる、開発者向けの優れたJavaScript機能を提供します。このJavaScript APIは、基本的な暗号演算を提供するだけでなく、暗号的に強い乱数値の生成、ハッシュ化、署名の生成と検証、暗号化と復号化を行うことができます。また、本APIの助けを借りて、ユーザーの認証や文書への署名、通信の機密性や完全性を安全に保護するためのアルゴリズムを実装できます。その結果このAPIを利用することで、エンドツーエンド暗号化の分野で、より安全でデータ保護に準拠したユースケースが可能になります。このように、Web Cryptography APIはエンドツーエンド暗号化に貢献しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>暗号API</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>CryptoGetRandomValues</code></td>
        <td class="numeric">70.32%</td>
        <td class="numeric">67.94%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoGenerateKey</code></td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoEncrypt</code></td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoDigest</code></td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha256</code></td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="よく使われている暗号API", sheets_gid="1256054098", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

我々の結果によると、（安全で暗号化された方法で）乱数を生成できる`Cypto.getRandomValues`関数が最も広く利用されていることがわかりました(デスクトップ: 70%、モバイル: 68%)。Google Analyticでは、この機能を利用していることが利用状況の測定に大きく影響していると考えています。一般的に、モバイルブラウザはこのAPIを[完全にサポート](https://developer.mozilla.org/ja/docs/Web/API/Web_Crypto_API#Browser_compatibility)していますが、モバイルサイトでは暗号化処理の実行数がわずかに少なくなっていることがわかります。

<p class="note">注意すべき点は、受動的なクロールを行っているため、このセクションでの結果はこれによって制限されることです。関数が実行される前に何らかのインタラクションが必要なケースを特定することはできません。</p>

### ボット保護サービスの活用

<a hreflang="en" href="https://www.imperva.com/blog/bad-bot-report-2020-bad-bots-strike-back">Imperva</a>によると、ウェブトラフィック全体の深刻な割合(37%)は自動化されたプログラム（いわゆる「ボット」）に属しており、そのほとんどは悪意のあるもの(24%)です。ボットは、フィッシング、情報収集、脆弱性の悪用、DDoS、その他多くの目的で利用されています。ボットを利用することは、攻撃者にとって非常に興味深い手法であり、特に大規模攻撃の成功率を高めます。そのため、悪意のあるボットからの防御は、大規模な自動化攻撃からの防御に役立ちます。次の図は、悪意のあるボットに対するサードパーティの保護サービスの利用状況を示しています。

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
  <figcaption>{{ figure_link(caption="プロバイダによるボット対策サービスの利用状況", sheets_gid="1787091453", sql_file="bot_detection.sql") }}</figcaption>
</figure>

上の図は、弊社のデータセットに基づくボットプロテクションの利用状況と市場シェアを示しています。デスクトップページの約10％、モバイルページの約9％がこのようなサービスを利用していることがわかります。

## セキュリティヘッダーの採用と様々な要因との関係

前のセクションでは、レスポンスヘッダーを介してウェブページで有効にする必要があるさまざまなブラウザのセキュリティメカニズムの採用率を調査しました。次に国レベルのポリシーや規制に関連しているのか、顧客の安全を確保したいという一般的な関心なのか、あるいはウェブサイトを構築するために使用される技術スタックに牽引されているのかなど、ウェブサイトがセキュリティ機能を採用する要因を探っていきます。

### サイトの訪問者の国

国レベルでのセキュリティに影響を与える要因はさまざまです。政府が主導するサイバーセキュリティのプログラムによって、優れたセキュリティ対策に対する意識が高まるかもしれませんし、高等教育においてセキュリティに重点を置くことで、より多くの知識を持った開発者が生まれるかもしれませんし、特定の規制によって企業や組織がベストプラクティスを遵守することを要求されるかもしれません。国ごとの違いを評価するために、Chromeユーザー体験レポート（CrUX）に基づいたデータセットで、少なくとも10万件のホームページが利用可能な国を分析しました。これらのページは、その国のユーザーが最も頻繁に訪問したページで構成されており、広く人気のある国際的なウェブサイトも含まれています。

{{ figure_markup(
  image="security-adoption-of-https-per-country.png",
  caption="国別のHTTPSの採用状況",
  description="HTTPSを有効にしているサイトの割合を、さまざまな国に関連するサイトについて示した棒グラフ。 スイス、ニュージーランド、アイルランド、ナイジェリア、オーストラリアが95%から94%の順に上位5位となっています。一方、タイ、イラン、韓国、台湾、日本は76%から72%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=286219881&format=interactive",
  sheets_gid="446153579",
  sql_file="feature_adoption_by_country.sql"
) }}

HTTPSで訪問されたホームページの割合を見ると、すでに大きな違いが見られます。最下位5カ国では、HTTPSの採用率は71%から76%と、かなり低くなっています。他のセキュリティメカニズムに目を向けると、成績上位の国と採用率の低い国との間には、さらに明らかな違いが見られます。CSPの採用率によると、上位5カ国では14%から16%のスコアが得られているのに対し、下位5カ国では2.5%から5%のスコアが得られています。興味深いことに、1つの安全保障メカニズムで良い成績を収めている国と悪い成績を収めている国は、他のメカニズムでも同じような成績を収めています。例えば、ニュージーランド、アイルランド、オーストラリアは常にトップ5にランクインしていますが、日本はほとんどすべてのセキュリティメカニズムでワーストのスコアを記録しています。

{{ figure_markup(
  image="security-adoption-of-csp-and-xfo-per-country.png",
  caption="国ごとのCSPとXFOの採用。",
  description="棒グラフを見ると、ニュージーランドではCSPを使用しているサイトが16％、XFOを使用しているサイトが37％となっています。 オーストラリアはCSPが16％、XFOが35％、アイルランドはCSPが15％、XFOが38％。 カナダはCSPが15％、XFOが30％、米国はCSPが14％、XFOが27％である。ボトムエンドのベラルーシはCSPが5%、XFOが21%、ベトナムはCSPが5%、XFOが21%、ウクライナはCSPが4%、XFOが17%、ロシアはCSPが3%、XFOが18%、日本はCSPが3%、XFOが 16%となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=874462374&format=interactive",
  sheets_gid="446153579",
  sql_file="feature_adoption_by_country.sql"
) }}

### 技術スタック

国レベルのインセンティブは、セキュリティメカニズムの採用をある程度促進することができますが、おそらくもっと重要なのは、ウェブサイトを構築する際にウェブサイト開発者が使用する技術スタックです。フレームワークは、特定の機能を有効にすることを容易にしているのか、それともアプリケーションの完全なオーバーホールを必要とする骨の折れるプロセスなのか。開発者は、最初から強力なセキュリティのデフォルトが設定されている、すでに安全な環境から始めた方が良いでしょう。このセクションでは、特定の機能の採用率が著しく高い（したがって、広く採用されるための原動力となる）プログラミング言語、SaaS、CMS、eコマース、CDNテクノロジを探っていきます。簡潔にするために、ここでは最も広く普及している技術に焦点を当てていますが、ユーザーにより良いセキュリティを提供することを目的とした、より小規模な技術製品が数多く存在することに注意することが重要です。

トランスポートセキュリティに関連したセキュリティ機能については、顧客サイトの少なくとも90%で`Strict-Transport-Security`ヘッダーを有効にしている12のテクノロジー製品（主にeコマースプラットフォームやCMS）があることがわかりました。上位3社（市場シェアによるとShopify、Squarespace、Automattic）が運営するウェブサイトでは、Strict Transport Securityを有効にしているホームページの30.32%を占めています。興味深いことに、`Expect-CT`ヘッダーの採用は、主に単一のテクノロジーであるCloudflareによって推進されており、CloudflareはHTTPSを有効にしているすべての顧客でヘッダーを有効にしている。その結果、`Expect-CT`ヘッダーの99.06%がCloudflareに関連していることがわかった。

コンテンツの包含を確保するセキュリティヘッダーや攻撃を阻止することを目的としたセキュリティヘッダーに関しては、いくつかの当事者がすべての顧客に対してセキュリティヘッダーを有効にしており、それによってその採用が促進されるという同様の現象が見られます。例えば、6つのテクノロジー製品は、80%以上の顧客に対して `Content-Security-Policy`ヘッダーを有効にしています。このように、上位3社（Shopify、Sucuri、Tumblr）は、このヘッダーを持つホームページの52.53%を占めている。同様に、`X-Frame-Options`についても、上位3社（Shopify、Drupal、Magento）がXFOヘッダーの世界的な普及率の34.96%に貢献していることがわかります。特にDrupalはオープンソースのCMSであり、ウェブサイトの所有者自身が設定することが多いので、これは興味深いことです。<a hreflang="en" href="https://www.drupal.org/node/2735873">`X-Frame-Options: SAMEORIGIN`をデフォルトで有効にする決定</a>が、クリックジャッキング攻撃から多くのユーザーを守っていることは明らかです。Drupalを搭載したウェブサイトの81.81%がXFOメカニズムを有効にしています。

### 他のセキュリティヘッダーとの重複

{{ figure_markup(
  image="security-headers-as-drivers-of-adoption-of-other-headers.png",
  caption="他のヘッダーを採用する際のドライバーとしてのセキュリティヘッダー",
  description="異なるセキュリティヘッダーの存在に基づくセキュリティメカニズムの相対的な採用率を示す棒グラフです。`Content-Security-Policy`はデスクトップで357%、モバイルで368%、`Expect-CT`はそれぞれ224%と235%、`Referrerer-Policy`は265%と265%、`Strict-Transport-Security`は275%と284%、`X-Content-Type-Options`は309%と305%、`X-Frame-Options`はデスクトップで286%、モバイルで299%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1444988925&format=interactive",
  sheets_gid="1707889711",
  sql_file="feature_adoption_by_other_features.sql"
) }}

セキュリティの「ゲーム」は非常にバランスが悪く、攻撃者に有利なものとなっています。このように単一のセキュリティメカニズムを採用することは、特定の攻撃を防御する上で非常に有用であるのに対し、ウェブサイトはすべての可能性のある攻撃から防御するために複数のセキュリティ機能を必要とします。セキュリティヘッダーが単発的に採用されているのか、それとも可能な限り多くの攻撃に対してより綿密な防御を提供するために厳格な方法で採用されているのかを判断するために、セキュリティヘッダーの共起性に注目します。より正確には、あるセキュリティヘッダーの採用が他のヘッダーの採用にどのような影響を与えるかを見ています。興味深いことに、単一のセキュリティヘッダーを採用しているウェブサイトは、他のセキュリティヘッダーも採用する可能性が高いことがわかります。例えばCSPヘッダーを含むモバイルホームページでは、他のヘッダー(`Expect-CT`、`Referrerer-Policy`、`Strict-Transport-Security`、`X-Content-Type-Options`、`X-Frame-Options`)の採用率は、これらのヘッダーの全体的な採用率と比較して平均368%も高くなっています。

一般的に、特定のセキュリティヘッダーを採用しているウェブサイトは、他のセキュリティヘッダーも同様に採用する可能性が2～3倍高くなります。これは特にCSPの場合に顕著で、他のセキュリティヘッダーの採用を最も促進します。これはCSPがより広範なセキュリティヘッダーの1つであり、採用にはかなりの労力を必要とするため、ポリシーを定義しているWebサイトは、Webサイトのセキュリティに投資する可能性が高いためと説明できます。一方で、CSPヘッダーの44.31%がShopifyを搭載したホームページ上に存在しています。このSaaS製品は、他にもいくつかのセキュリティヘッダー（`Strict-Transport-Security`、`X-Content-Type-Options`、`X-Frame-Options`）を事実上すべての顧客のデフォルトとして有効にしています。

## ソフトウェアアップデートの実践

ウェブの非常に大きな部分は、技術スタックの異なる層にあるサードパーティのコンポーネントによって構築されています。これらのコンポーネントは、より良いユーザー体験を提供するために使用されるJavaScriptライブラリ、ウェブサイトのバックボーンを形成するコンテンツ管理システムやウェブアプリケーションのフレームワーク、訪問者からのリクエストに応答するために使用されるウェブサーバで構成されています。脆弱性は、これらのコンポーネントのいずれかで検出されることがよくあります。最良のケースでは脆弱性はセキュリティ研究者によって検出され、責任を持って影響を受けるベンダーに開示し、脆弱性にパッチを当ててソフトウェアのアップデートをリリースするように促します。この時点では、脆弱性の詳細が公表されている可能性が高く、攻撃者はその脆弱性を利用した悪用法の作成に熱心に取り組んでいます。そのため、ウェブサイトの所有者は、これらの<a hreflang="en" href="https://www.darkreading.com/vulnerabilities---threats/the-overlooked-problem-of-n-day-vulnerabilities/a/d-id/1331348">n-day exploits</a>から身を守るために、影響を受けたソフトウェアをできるだけ早くアップデートすることが重要です。このセクションでは、最も広く使用されているソフトウェアがどの程度最新の状態に保たれているかを探ります。

### WordPress

{{ figure_markup(
  image="security-wordpress-version-evolution.png",
  caption="WordPressのバージョンアップ。",
  description="2019年11月から2020年8月まで、アクティブにメンテナンスされているWordPressのブランチ（4.9、5.1、5.2、5.3、5.4、5.5）について、2019年11月から2020年8月までのWordPressインストールのバージョンの進化を示す積み上げ棒グラフです。一般的にこのチャートを見ると、ほとんどのインストール（約75%）が1年を通してアップデートを続けており、現在は最新バージョンになっていることがわかります",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=2139119698&format=interactive",
  sheets_gid="640505800",
  sql_file="feature_adoption_by_technology.sql",
  width="600",
  height="575"
) }}

最も人気のある[コンテンツ管理システム](./cms)の1つであるWordPressは、攻撃者にとって魅力的なターゲットとなっています。そのため、ウェブサイト管理者はインストールを常に最新の状態に保つことが重要です。デフォルトでは、<a hreflang="en" href="https://wordpress.org/support/article/configuring-automatic-background-updates/">WordPress の更新は自動的に行われます</a>が、この機能を無効にすることも可能です。展開されているWordPressのバージョンの変遷は上図のように、<a hreflang="en" href="https://wordpress.org/download/releases/">「現在も積極的にメンテナンスが行われている最新の主要バージョン」</a>（5.5：紫、5.4：青、5.3：赤、5.2：緑、4.9：オレンジ）を表示しています。普及率が4%未満のバージョンは「その他」の下にまとめられています。最初に興味深い観察ができるのは、2020年8月の時点でモバイルホームページにインストールされているWordPressの74.89％が、そのブランチ内で最新バージョンを実行しているということです。また、ウェブサイトの所有者が徐々に新しいメジャーバージョンにアップグレードしていることがわかります。例えば、2020年8月11日にリリースされたWordPressのバージョン5.5は、8月のクロールで観測されたWordPressインストールの10.22%を既に構成していました。

{{ figure_markup(
  image="security-evolution-of-wordpress-5-3and5-4-after-update.png",
  caption="アップデート後のWordPress 5.3と5.4の進化",
  description="WordPressのバージョン5.3.2、5.3.3、5.4、5.4.1の進化を示す重ね棒グラフ。2020年3月から時系列で見ると、5.3.2が唯一使われているバージョンで50.08％、4月には5.4が登場し、これらのバージョンの3分の3を占め、5月には54.23％にまで増加しています。 1が登場し、3つのバージョンが混在して使用されており、合計で58.78%となっています。6月には約半分の32.76%に減少し、残りの使用率のほとんどは5.4.1となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=503316556&format=interactive",
  sheets_gid="155582197",
  width="600",
  height="450",
  sql_file="feature_adoption_by_technology.sql"
) }}

グラフから推測できるもう1つの興味深い側面は、1ヶ月以内にそれまで最新の状態にあったWordPressサイトの大部分が新しいバージョンに更新されているということです。これは、特に最新のブランチにインストールされているWordPressに当てはまるようです。クロール開始2日前の2020年4月29日、WordPressはすべてのブランチのアップデートをリリースしました。5.4 → 5.4.1、5.3.2 → 5.3.3、などです。このデータをもとに、バージョン5.4を実行していたWordPressインストールのシェアは、2020年4月のクロール時の23.08%から、2020年5月には2.66%まで減少し、2020年6月には1.12%までさらに減少し、その後は1%以下に落ち込んでいることがわかります。新バージョン5.4.1は、2020年5月時点で35.70％のWordPressインストールで稼働しており、多くのWebサイト運営者が（5.4や他のブランチから）WordPressのインストールを（自動的に）更新した結果となっています。大多数のウェブサイト運営者は、自動的に、または新しいバージョンがリリースされた後に非常に迅速にWordPressを更新していますが、古いバージョンに固執し続けているサイトはまだ少数派です：2020年8月の時点で、全WordPressインストールの3.59％が古い5.3または5.4バージョンを実行していました。

### jQuery

{{ figure_markup(
  image="security-jquery-version-evolution.png",
  caption="jQueryのバージョンアップ。",
  description="2019年11月から2020年8月までのインクルードされたjQueryのバージョンの進化を示すスタックバーチャートです。このチャートの以前のWordPressバージョンとは異なり、Otherが26.58%から31.04%、1.10.2が平均4.01%、1.11.0が平均3.52%、1.11.1が平均4.58%、1.11.3が平均4.12%、1.12.4が平均35.19%、1. 11.3平均4.12％、1.12.4平均35.19％、1.7.2平均3.12％、1.8.3平均3.24％、1.9.1平均3.16％、2.2.4平均3.23％、3.2.1平均3.47％、3.3.1平均4.62％、3.4.1平均3.96％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=598537336&format=interactive",
  sheets_gid="1175693258",
  width="600",
  height="450",
  sql_file="feature_adoption_by_technology.sql"
) }}

最も広く使われているJavaScriptライブラリの一つにjQueryがありますが、これには大きく分けて3つのバージョンがあります。モバイルホームページで使用されているjQueryのバージョンの進化からも明らかなように、全体的な分布は時間の経過とともに非常に静的になっています。驚くべきことに、かなりの割合（2020年8月時点で18.21％）のWebサイトでは、まだ古いバージョンの1.xのjQueryが実行されています。この割合は一貫して減少しており（2019年11月時点の33.39％から）、2016年5月に<a hreflang="en" href="https://blog.jquery.com/2016/05/20/jquery-1-12-4-and-2-2-4-released/">リリース</a>されたバージョン1.12.4を好んで使用しており、残念ながら<a hreflang="en" href="https://snyk.io/test/npm/jquery/1.12.4">様々な中程度のセキュリティ問題</a>を抱えています。

### nginx

{{ figure_markup(
  image="security-nginx-version-evolution.png",
  caption="nginxのバージョンアップ。",
  description="2019年11月から2020年8月までのnginxサーバーのバージョンの進化は、その間の使用状況がかなり静的であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=700290827&format=interactive",
  sheets_gid="1494766656",
  sql_file="feature_adoption_by_technology.sql"
) }}

最も広く利用されているウェブサーバーの一つであるnginxについては、時間の経過とともに異なるバージョンが採用されているという点で、非常に静的で多様な状況が見られます。すべてのnginxサーバーの中で、どのnginx(マイナー)バージョンが占める割合が最も大きかったのは約20%でした。さらに、バージョンの分布は時間の経過とともにかなり静的なままであることがわかります。おそらくこれは、2014年以降、nginxには[メジャーなセキュリティ脆弱性が発見されていない](http://nginx.org/en/security_advisories.html)という事実と関係していると思われます（1.5.11までのバージョンに影響を与えます）。中程度の影響力を持つ最後の3つの脆弱性（<a hreflang="en" href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9511">CVE-2019-9511</a>、<a hreflang="en" href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9513">CVE-2019-9513</a>、<a hreflang="en" href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9516">CVE-2019-9516</a>）の日付は2019年3月からで、バージョン1.17.2までのHTTP/2対応nginxサーバで過度に高いCPU使用率を引き起こす可能性があります。報告されているバージョン数によると、半数以上のサーバがこの脆弱性の影響を受ける可能性があるとのことです（HTTP/2を有効にしている場合）。ウェブサーバソフトウェアは頻繁に更新されていないため、この数字は今後数ヶ月の間、かなり高い水準で推移する可能性があります。

## ウェブ上の不正行為

現在では、使用される技術の性能が特に重要な役割を果たしています。そのために、技術は常にさらに開発され、最適化され、新しい技術が発表されています。これらの新しい技術の1つがWebAssemblyであり、2019年末時点で<a hreflang="en" href="https://www.w3.org/2019/12/pressrelease-wasm-rec.html.en">W3C勧告</a>となっています。WebAssemblyを利用することで強力なWebアプリケーションを開発でき、ブラウザでほぼネイティブな高性能コンピューティングを実行することが可能になりました。しかし、攻撃者がこの技術を利用してきたため、とげのないバラはありませんでしたが、これが新たな攻撃ベクトル<a hreflang="en" href="https://www.malwarebytes.com/cryptojacking/">cryptojacking</a>の登場です。攻撃者はこの技術を利用して、訪問者のコンピューターの力を利用してブラウザ上の暗号通貨を採掘します（悪意のある暗号採掘）。これは攻撃者にとって非常に魅力的な技術です - ウェブページに数行のJavaScriptコードを注入し、すべての訪問者にあなたのために採掘させます。一部のウェブサイトでは、ウェブ上で善意のクリプトマイニングを提供している場合もあるため、クリプトマイニングを行っているすべてのウェブサイトが実際にクリプトジャッキングを行っていると一般化することはできません。しかしほとんどの場合、ウェブサイトのオペレーターは訪問者のためのオプトインの代替手段を提供していないと、訪問者は彼らのリソースがウェブサイトを閲覧しながら使用されているかどうかについては、まだ無知のままです。

{{ figure_markup(
  image="security-cryptominer-usage.png",
  caption="クリプトマイナーの使い方。",
  description="2019年1月から2020年8月までのcryptojackingスクリプトを搭載したサイト数の推移を示す時系列図。開始時のデスクトップサイト1094サイト、モバイルサイト1221サイトから、終了時にはデスクトップサイト475サイト、モバイルサイト659サイトへと減少傾向が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1746732299&format=interactive",
  sheets_gid="340445160",
  sql_file="cryptominer_usage.sql"
) }}

上の図は、過去2年間のクリプトマイニングを活用したウェブサイトの数を示しています。2019年に入ってから、クリプトマイニングへの関心が低くなっていることがわかります。前回の測定では、クリプトマイニングスクリプトを含むウェブサイトが合計348件ありました。

次の図では、8月のデータセットをもとに、ウェブ上のクリプトマイナーの市場シェアを示しています。Coinimpが45.2%の市場シェアを持ち、最も人気のあるプロバイダーとなっています。最も人気のあるクリプトマイナーはすべてWebAssemblyをベースにしていることがわかりました。Web上で採掘するためのJavaScriptライブラリもありますが、WebAssemblyをベースにしたソリューションほど強力ではないことに注意してください。私たちの別の結果によると、クリプトマイニングを含むウェブサイトの半分は、廃止されたサービスプロバイダーのクリプトマイニングコンポーネントを利用していることがわかりました（<a hreflang="en" href="https://blog.avast.com/coinhive-shuts-down">CoinHive</a>や[JSEcoin](https://twitter.com/jsecoin/status/1247436272869814272)のようなもの）。

{{ figure_markup(
  image="security-cryptominer-market-share.png",
  caption="クリプトマイナーの市場シェア（モバイル）。",
  description="円グラフを見ると、Coinimpが45.2.3％、CoinHiveが41.4％、JSEcoinが6.9％、Minero.ccが3.0％、その他が3.55％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=691707301&format=interactive",
  sheets_gid="445442267",
  sql_file="cryptominer_share.sql"
) }}

## 結論

昨年のウェブセキュリティに関する最も顕著な進展の1つは、ウェブの（ロングテールの）セキュリティヘッダーの採用が増加したことです。これは全体的なユーザの保護が向上したことを意味するだけでなく、より重要なことはウェブサイト管理者のセキュリティに対するインセンティブが一般的に高まったことを示しています。この使用率の増加は、CSPのような実装が困難なものであっても、すべての異なるセキュリティヘッダーで見ることができます。もう1つの興味深い観察として、あるセキュリティヘッダーを採用しているウェブサイトでは、他のセキュリティメカニズムを採用する可能性が高いことがわかりました。このことは、ウェブセキュリティが単なる余計なものとして考えられているのではなく、開発者がすべての可能性のある脅威から守ることを目的とした全体的なアプローチであることを示しています。

世界的な規模では、まだ長い道のりがあります。例えば、クリックジャッキング攻撃に対する適切な保護機能を備えているサイトは全サイトの3分の1以下であり、多くのサイトではCookieの`SameSite`属性を`None`に設定することで様々なクロスサイト攻撃に対する保護機能(特定のブラウザではデフォルトで有効になっています)をオプトアウトしています。それにもかかわらず、より積極的な進化も見られます。テクノロジースタック上の様々なソフトウェアがデフォルトでセキュリティ機能を有効にしています。このソフトウェアを使ってウェブサイトを構築する開発者は、すでに安全な環境からスタートし、必要に応じて強制的に保護機能を無効にしなければなりません。これは、レガシーアプリケーションで見られるものとは大きく異なり、機能を壊す可能性があるため、セキュリティの強化がより困難になる可能性があります。

今後の見通しとして、私たちが知っている1つの予測は、セキュリティの状況が行き詰まることはないだろうということです。新たな攻撃手法が表面化し、それを防御するための追加のセキュリティメカニズムが必要になる可能性があります。最近採用されたばかりの他のセキュリティ機能を見てきたように、これには時間がかかるでしょうが、徐々に一歩一歩より安全なウェブへと移行します。
