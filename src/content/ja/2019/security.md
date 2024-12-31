---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: セキュリティ
description: トランスポート・レイヤー・セキュリティ(TLS()、混合コンテンツ、セキュリティヘッダ、Cookie、サブリソース完全性を網羅した2019年版Web Almanacのセキュリティの章。
hero_alt: Hero image of Web Almanac characters padlocking a web page, while other Web Almanac characters subdue a masked thief who has a set of bolt cutters.
authors: [ScottHelme, arturjanc]
reviewers: [tunetheweb, ghedo, paulcalvano]
analysts: [dotjs, jrharalson]
editors: [tunetheweb]
translators: [ksakae1216]
discuss: 1763
results: https://docs.google.com/spreadsheets/d/1Zq2tQhPE06YZUcbzryRrBE6rdZgHHlqEp2XcgS37cm8/
ScottHelme_bio: Scott Helmeはセキュリティ研究者であり、<a hreflang="en" href="https://report-uri.com">report-uri.com</a> と <a hreflang="en" href="https://securityheaders.com">securityheaders.com</a> の創設者でもあります。Twitterでは、<a href="https://x.com/Scott_Helme">@Scott_Helme</a>でセキュリティの話をしたり、<a hreflang="en" href="https://scotthelme.co.uk">scotthelme.co.uk</a>でブログを書いたりしています。
arturjanc_bio: Artur Jancは Google の情報セキュリティエンジニアで、GoogleとWeb全体のWebプラットフォームのセキュリティメカニズムの設計と採用に取り組んでいます。<a href="https://x.com/arturjanc">@arturjanc on Twitter</a>として、インターネット上の人々と議論しています。
featured_quote: Webの機能が向上し、より多くの機密データへのアクセスが可能になるにつれ、開発者が自社のアプリケーションを保護するためにWebセキュリティ機能を採用することがますます重要になってきています。この章で紹介するセキュリティ機能は、Webプラットフォーム自体に組み込まれた防御機能であり、すべてのWeb制作者が利用できます。
featured_stat_1: 79%
featured_stat_label_1: HTTPSを使用しているサイト
featured_stat_2: 41%
featured_stat_label_2: TLSv1.3を使用しているサイト
featured_stat_3: 4.43%
featured_stat_label_3: CSPを使用しているサイト
---

## 序章
Web Almanacのこの章では、Web上のセキュリティの現状を見ていきます。オンラインでのセキュリティとプライバシーの重要性がますます高まる中、サイト運営者とユーザーを保護するための機能が増えています。ここでは、ウェブ上でのこれらの新機能の採用状況を見ていきます。

## トランスポートレイヤーセキュリティ
現在、オンラインでのセキュリティとプライバシーを向上させるための最大の後押しは、おそらくトランスポート・レイヤー・セキュリティ（TLS）の普及です。TLS（または古いバージョンのSSL）は、HTTPSの「S」を提供し、安全でプライベートなWebサイトのブラウジングを可能にするプロトコルです。<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">ウェブ上でのHTTPSの使用が大幅に増加している</a>だけでなく、TLSv1.2やTLSv1.3のような最新バージョンのTLSが増加していることも重要です。

{{ figure_markup(
  image="fig1.png",
  caption="HTTPとHTTPS の使用法。",
  description="横棒グラフは、モバイルのHTTPSが79%、HTTPが21%、その下にデスクトップのHTTPSが 80.51%、HTTPが19.49%であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRCG3clMcnkVPrnZSCWFi3qG-EU00Qr8X3XaRFQPWHEXQmYWMxnS_kfmmyMQsPZe2P6ECjzCjG0dVFg/pubchart?oid=933123879&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

### プロトコルのバージョン

{{ figure_markup(
  image="fig2.png",
  caption="TLSプロトコルのバージョン使用状況",
  description="横棒グラフは、デスクトップとモバイルのTLSの使用状況を示しています。TLSv1.2が58%、TLSv1.3が41%、TLSv1.0の使用率はほとんどなく (0.75%)、TLSv1.1の使用率はわずかです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRCG3clMcnkVPrnZSCWFi3qG-EU00Qr8X3XaRFQPWHEXQmYWMxnS_kfmmyMQsPZe2P6ECjzCjG0dVFg/pubchart?oid=1441324762&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

図8.2は、さまざまなプロトコルバージョンのサポートを示しています。TLSv1.0やTLSv1.1のようなレガシーなTLSバージョンの使用は最小限であり、ほとんどすべてのサポートはプロトコルの新しいバージョンであるTLSv1.2やTLSv1.3に対応しています。TLSv1.3はまだ標準としては非常に若いですが（TLSv1.3は<a hreflang="en" href="https://tools.ietf.org/html/rfc8446">2018年8月</a>に正式に承認されたばかりです）、TLSを使用するリクエストの40％以上が最新バージョンを使用しています！　TLSv1.0やTLSv1.1のようなレガシーバージョンの使用はほとんどありません。

これは、多くのサイトが[サードパーティコンテンツ](./third-parties)のために大きなプレイヤーからのリクエストを使用していることが原因であると考えられます。例えば、どのようなサイトでもGoogle Analytics、Google AdWords、またはGoogle FontsをロードしGoogleのような大規模なプレイヤーは通常新しいプロトコルのためのアーリーアダプターです。

ホームページだけを見て、それ以外のサイトのリクエストをすべて見ない場合、TLSの使用率は予想通りかなり高いですが、Wordpressのような[CMS](./cms)サイトや[CDN](./cdn)のようなサイトが原因である可能性は高いです。

{{ figure_markup(
  image="fig3.png",
  caption="ホームページリクエストだけのTLSプロトコルバージョン使用状況。",
  description="横棒グラフは、デスクトップとモバイルの類似したTLSの使用状況を示しています。デスクトップでは47%(モバイルでは43%)がTLSv1.2、デスクトップでは20.2%(モバイルでは19.7%)がTLSv1.3を使用しており、TLSv1.0の使用量はほとんどなく(1.1%～1.2%)、TLSv1.1の使用量はわずかです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRCG3clMcnkVPrnZSCWFi3qG-EU00Qr8X3XaRFQPWHEXQmYWMxnS_kfmmyMQsPZe2P6ECjzCjG0dVFg/pubchart?oid=897771966&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

一方で、Web Almanacが使用している[方法論](./methodology)は、大規模サイトの利用状況を*過小評価*します。なぜなら、大規模サイトはそのサイト自体が現実世界ではより大きなインターネット・トラフィックを形成している可能性が高いにもかかわらず、これらの統計のために一度しかクロールされないからです。

### 証明書発行者
もちろん、ウェブサイトでHTTPSを使用するには、認証局（CA）からの証明書が必要です。HTTPSの使用の増加に伴い、CAとその製品／サービスの使用も増加しています。ここでは、証明書を使用するTLSリクエストの量に基づいて、上位10社の証明書発行者を紹介します。

<figure>
  <table>
    <thead>
      <tr>
        <th>発行証明書発行局</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Internet Authority G3</td>
        <td class="numeric">19.26%</td>
        <td class="numeric">19.68%</td>
      </tr>
      <tr>
        <td>Let's Encrypt Authority X3</td>
        <td class="numeric">10.20%</td>
        <td class="numeric">9.19%</td>
      </tr>
      <tr>
        <td>DigiCert SHA2 High Assurance Server CA</td>
        <td class="numeric">9.83%</td>
        <td class="numeric">9.26%</td>
      </tr>
      <tr>
        <td>DigiCert SHA2 Secure Server CA</td>
        <td class="numeric">7.55%</td>
        <td class="numeric">8.72%</td>
      </tr>
      <tr>
        <td>GTS CA 1O1</td>
        <td class="numeric">7.87%</td>
        <td class="numeric">8.43%</td>
      </tr>
      <tr>
        <td>DigiCert SHA2 Secure Server CA</td>
        <td class="numeric">7.55%</td>
        <td class="numeric">8.72%</td>
      </tr>
      <tr>
        <td>COMODO RSA Domain Validation Secure Server CA</td>
        <td class="numeric">6.29%</td>
        <td class="numeric">5.79%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">4.84%</td>
        <td class="numeric">5.10%</td>
      </tr>
      <tr>
        <td>Amazon</td>
        <td class="numeric">4.71%</td>
        <td class="numeric">4.45%</td>
      </tr>
      <tr>
        <td>COMODO ECC Domain Validation Secure Server CA 2</td>
        <td class="numeric">3.22%</td>
        <td class="numeric">2.75%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" 使用されている認証局トップ10。") }}</figcaption>
</figure>

前述したように、Googleのボリュームは他のサイトでGoogleアナリティクス、Google Adwords、またはGoogle Fontsを繰り返し使用していることを反映している可能性が高い。

<a hreflang="en" href="https://letsencrypt.org/ja/">Let's Encrypt</a>の台頭は2016年初頭の開始後、急成長を遂げ、それ以来世界でもトップレベルの証明書発行局の1つになりました。無料の証明書の可用性と自動化されたツールは、ウェブ上でのHTTPSの採用に決定的に重要な役割を果たしています。Let's Encryptは、これらの両方において重要な役割を果たしています。

コストの削減により、HTTPSへの参入障壁は取り除かれましたが、Let's Encryptが使用する自動化は証明書の寿命を短くできるため、長期的にはより重要であると思われます、<a hreflang="en" href="https://scotthelme.co.uk/why-we-need-to-do-more-to-reduce-certificate-lifetimes/">これは多くのセキュリ ティ上のメリットがあります</a>。

### 認証キーの種類

HTTPSを使用するという重要な要件と並行して、適切な構成を使用するという要件もあります。非常に多くの設定オプションと選択肢があるため、これは慎重にバランスを取る必要があります。

まず、認証に使用される鍵について見ていきましょう。従来、証明書はRSAアルゴリズムを使用した鍵に基づいて発行されてきましたが、より新しく優れたアルゴリズムであるECDSA(Elliptic Curve Digital Signature Algorithm — 楕円曲線DSA) を使用しており、RSAアルゴリズムよりも優れた性能を発揮する小さな鍵の使用を可能にしています。私たちのクロールの結果を見ると、ウェブの大部分がRSAを使用していることがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <th>キーの種類</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>RSA Keys</td>
        <td class="numeric">48.67%</td>
        <td class="numeric">58.8%</td>
      </tr>
      <tr>
        <td>ECDA Keys</td>
        <td class="numeric">21.47%</td>
        <td class="numeric">26.41%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" 使用する認証キーの種類") }}</figcaption>
</figure>

ECDSA鍵はより強力な鍵であるため、より小さな鍵の使用が可能となりRSA鍵よりも優れたパフォーマンスを発揮しますが、下位互換性に関する懸念やその間の両方のサポートの複雑さが一部のウェブサイト運営者の移行を妨げる要因となっています。

### Forward secrecy
[Forward secrecy](https://ja.wikipedia.org/wiki/Forward_secrecy)は将来サーバの秘密鍵が漏洩した場合でも、サーバへの各接続が公開されるのを防ぐような方法で接続を保護するいくつかの鍵交換メカニズムの特性です。これは、接続のセキュリティを保護するために全てのTLS接続で望ましい事として、セキュリティコミュニティ内ではよく理解されています。2008年にTLSv1.2でオプション設定として導入され、2018年にはTLSv1.3でForward Secrecyの使用が必須となりました。

Forward Secrecyを提供するTLSリクエストの割合を見ると、サポートが非常に大きいことがわかります。デスクトップの96.92％、モバイルリクエストの96.49％がForward Secrecyを使用しています。TLSv1.3の採用が継続的に増加していることから、これらの数字はさらに増加すると予想されます。

### 暗号スイート
TLSでは、さまざまな暗号スイートを使用できます。従来、TLSの新しいバージョンは暗号スイートを追加してきましたが、古い暗号スイートを削除することには消極的でした。TLSv1.3はこれを単純化するために、より少ない暗号スイートのセットを提供し、古い安全でない暗号スイートを使用することを許可しません。<a hreflang="en" href="https://www.ssllabs.com/">SSL Labs</a> のようなツールは、ウェブサイトのTLS設定 (サポートされている暗号スイートとその好ましい順序を含む) を簡単に見ることができ、より良い設定を促進するのに役立ちます。TLSリクエストのためにネゴシエートされた暗号化スイートの大部分は確かに優れたものであったことがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <th>暗号スイート</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>AES_128_GCM</code></td>
        <td class="numeric">75.87%</td>
        <td class="numeric">76.71%</td>
      </tr>
      <tr>
        <td><code>AES_256_GCM</code></td>
        <td class="numeric">19.73%</td>
        <td class="numeric">18.49%</td>
      </tr>
      <tr>
        <td><code>AES_256_CBC</code></td>
        <td class="numeric">2.22%</td>
        <td class="numeric">2.26%</td>
      </tr>
      <tr>
        <td><code>AES_128_CBC</code></td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.72%</td>
      </tr>
      <tr>
        <td><code>CHACHA20_POLY1305</code></td>
        <td class="numeric">0.69%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td><code>3DES_EDE_CBC</code></td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.04%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" 使用されている暗号スイートの使用法") }}</figcaption>
</figure>

古いCBC暗号は安全性が低いので、GCM暗号がこのように広く使われるようになったのはポジティブなことです。<a hreflang="en" href="https://blog.cloudflare.com/it-takes-two-to-chacha-poly/">CHACHA20_POLY1305</a>はまだニッチな暗号スイートであり、私たちはまだ[安全でないトリプルDES暗号](https://ja.wikipedia.org/wiki/%E3%83%88%E3%83%AA%E3%83%97%E3%83%ABDES#%E5%AE%89%E5%85%A8%E6%80%A7)をごくわずかしか使っていません。

これらはChromeを使ったクロールに使われた暗号化スイートですが、サイトは古いブラウザでも他の暗号化スイートをサポートしている可能性が高いことに注意してください。例えば<a hreflang="en" href="https://www.ssllabs.com/ssl-pulse/">SSL Pulse</a> などの他の情報源では、サポートされているすべての暗号スイートとプロトコルの範囲についてより詳細な情報を提供しています。

## 混合コンテンツ
ウェブ上のほとんどのサイトは元々HTTPサイトとして存在しており、HTTPSにサイトを移行しなければなりませんでした。この「リフトアンドシフト」作業は難しく、時には見落としたり、取り残されたりすることもあります。その結果、ページはHTTPSで読み込まれているが、ページ上の何か（画像やスタイルなど）はHTTPで読み込まれているような、コンテンツが混在しているサイトが発生します。コンテンツが混在していると、セキュリティやプライバシーに悪影響を及ぼし、発見して修正するのが困難になることがあります。

<figure>
  <table>
    <thead>
      <tr>
        <th>混合コンテンツタイプ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>任意のコンテンツが混在しているページ</td>
        <td class="numeric">16.27%</td>
        <td class="numeric">15.37%</td>
      </tr>
      <tr>
        <td>アクティブな混合コンテンツのページ</td>
        <td class="numeric">3.99%</td>
        <td class="numeric">4.13%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" 混在コンテンツの利用状況。") }}</figcaption>
</figure>

モバイル（645,485サイト）とデスクトップ（594,072サイト）では、約20％のサイトが何らかの形で混合コンテンツを表示していることがわかります。画像のようなパッシブな混合コンテンツの危険性は低いですが、混合コンテンツを持つサイトのほぼ4分の1がアクティブな混合コンテンツを持っていることがわかります。JavaScriptのようなアクティブな混合コンテンツは、攻撃者が自分の敵対的なコードを簡単にページに挿入できるため、より危険です。

これまでのウェブブラウザは、受動的な混合コンテンツを許可して警告を表示していたが、能動的な混合コンテンツはブロックしていた。しかし最近では、Chrome<a hreflang="en" href="https://blog.chromium.org/2019/10/no-more-mixed-messages-about-https.html">発表</a> はこの点を改善し、HTTPSが標準になるにつれて代わりにすべての混合コンテンツをブロックすることを意図しています。

## セキュリティヘッダ
サイト運営者がユーザーをより良く保護するための多くの新しい機能が、ブラウザに組み込まれたセキュリティ保護を設定したり制御したりできる新しいHTTPレスポンスヘッダの形で提供されています。これらの機能の中には、簡単に有効にして大きなレベルの保護を提供するものもあれば、サイト運営者が少し作業を必要とするものもあります。サイトがこれらのヘッダを使用しており、正しく設定されているかどうかを確認したい場合は、<a hreflang="en" href="https://securityheaders.com/">Security Headers</a>ツールを使用してスキャンできます。

{{ figure_markup(
  image="fig8.png",
  caption="セキュリティヘッダの使用法",
  description="デスクトップ、モバイルともに、左から順にセキュリティヘッダリストの使用量が増加していることを縦棒グラフで示しています。左から順に、Cross-origin-resource-policy(両方とも0サイト)、feature policy(デスクトップとモバイルで約8k)、report-to(デスクトップで74k、モバイルで83k)、nel(デスクトップで74k、モバイルで83k)、referrer-policy(デスクトップで142k、モバイルで156k)、content-security-policy(デスクトップで240k)のリストです。252k モバイル）、strict-transport-security（648k デスクトップ、679k モバイル）、x-xss-protection（642k デスクトップ、805k モバイル）、x-frame-options（743k デスクトップ、782k モバイル）、そして最後にx-content-type-options（770k デスクトップ、932k モバイル）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRCG3clMcnkVPrnZSCWFi3qG-EU00Qr8X3XaRFQPWHEXQmYWMxnS_kfmmyMQsPZe2P6ECjzCjG0dVFg/pubchart?oid=2029255231&format=interactive",
  width=760,
  height=450,
  data_width=760,
  data_height=450
  )
}}

### HTTP Strict Transport Security
<a hreflang="en" href="https://tools.ietf.org/html/rfc6797">HSTS</a> ヘッダーは、Webサイトがブラウザに、安全なHTTPS接続でのみサイトと通信するように指示することを可能にします。これは、http:// URLを使用しようとする試みは、リクエストが行われる前に自動的にhttps://に変換されることを意味します。リクエストの40％以上がTLSを使用できることを考えると、要求するようにブラウザに指示しているリクエストの割合はかなり低いと考えられます。

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
        <td><code>max-age</code></td>
        <td class="numeric">14.80%</td>
        <td class="numeric">12.81%</td>
      </tr>
      <tr>
        <td><code>includeSubDomains</code></td>
        <td class="numeric">3.86%</td>
        <td class="numeric">3.29%</td>
      </tr>
      <tr>
        <td><code>preload</code></td>
        <td class="numeric">2.27%</td>
        <td class="numeric">1.99%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" HSTS ディレクティブの使用法") }}</figcaption>
</figure>

モバイルページやデスクトップページの15％未満が`max-age`ディレクティブ付きのHSTSを発行しています。これは有効なポリシーの最低条件です。また、`includeSubDomains`ディレクティブでサブドメインをポリシーに含めているページはさらに少なく、HSTSのプリロードを行っているページはさらに少ないです。HSTSの`max-age`の中央値を見ると、これを使用している場合はデスクトップとモバイルの両方で15768000となっており、半年(60X60X24X365/2)に相当する強力な設定であることがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >クライアント</th>
      </tr>
      <tr>
        <th scope="col">パーセンタイル</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">300</td>
        <td class="numeric">300</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">7889238</td>
        <td class="numeric">7889238</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">15768000</td>
        <td class="numeric">15768000</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">31536000</td>
        <td class="numeric">31536000</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">63072000</td>
        <td class="numeric">63072000</td>
      </tr>
    </tbody>
  </table>

<figcaption>{{ figure_link(caption=" HSTSの`max-age`ポリシーのパーセンタイル別の中値。") }}</figcaption>
</figure>

#### HSTSプリロード
HTTPレスポンスヘッダーを介して配信されるHSTSポリシーでは、初めてサイトを訪れたときに、ブラウザはポリシーが設定されているかどうかを知ることができません。この[初回使用時の信頼](https://en.wikipedia.org/wiki/Trust_on_first_use)の問題を回避するために、サイト運営者はブラウザ(または他のユーザーエージェント)にポリシーをプリロードしておくことができます。

プリロードにはいくつかの要件があり、<a hreflang="en" href="https://hstspreload.org/">HSTSプリロード</a>サイトで概要が説明されています。現在の基準では、デスクトップでは0.31％、モバイルでは0.26％というごく少数のサイトしか対象としていないことがわかる。サイトは、ドメインをプリロードするために送信する前、ドメインの下にあるすべてのサイトをHTTPSに完全に移行させておく必要があります。

### コンテンツセキュリティポリシー
ウェブアプリケーションは、敵対的なコンテンツがページへ挿入される攻撃に頻繁に直面しています。最も心配なコンテンツはJavaScriptであり、攻撃者がJavaScriptをページに挿入する方法を見つけると、有害な攻撃を実行できます。これらの攻撃は[クロスサイトスクリプティング(XSS)](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AD%E3%82%B9%E3%82%B5%E3%82%A4%E3%83%88%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)として知られており、<a hreflang="en" href="https://www.w3.org/TR/CSP2/">コンテンツセキュリティポリシー(CSP)</a> はこれらの攻撃に対する効果的な防御策を提供しています。

CSPとは、ウェブサイトが公開しているHTTPヘッダ(`Content-Security-Policy`)のことで、サイトで許可されているコンテンツに関するルールをブラウザに伝えるものです。セキュリティ上の欠陥のために追加のコンテンツがサイトに注入され、それがポリシーで許可されていない場合、ブラウザはそのコンテンツの使用をブロックします。XSS保護の他にも、CSPは、[HTTPSへの移行を容易にする](#upgrade-insecure-requests)など、いくつかの重要な利点を提供しています。

CSPの多くの利点にもかかわらず、その非常に目的がページ上で許容されるものを制限することであるため、ウェブサイトに実装することは複雑になる可能性があります。ポリシーは必要なすべてのコンテンツやリソースを許可しなければならず、大きく複雑になりがちです。<a hreflang="en" href="https://report-uri.com/">レポートURI</a>のようなツールは、適切なポリシーを分析して構築するのに役立ちます。

デスクトップページのわずか5.51％にCSPが含まれ、モバイルページのわずか4.73％にCSPが含まれていることがわかりましたが、これは展開の複雑さが原因と思われます。

#### ハッシュ/ノンス
CSPの一般的なアプローチは、JavaScriptなどのコンテンツをページにロードすることを許可されているサードパーティドメインのホワイトリストを作成することです。これらのホワイトリストの作成と管理は困難な場合があるため、<a hreflang="en" href="https://www.w3.org/TR/CSP2/#source-list-valid-hashes">ハッシュ</a>と<a hreflang="en" href="https://www.w3.org/TR/CSP2/#source-list-valid-nonces">ノンス</a>が代替的なアプローチとして導入されました。ハッシュはスクリプトの内容に基づいて計算されるので、ウェブサイト運営者が公開しているスクリプトが変更されたり、別のスクリプトが追加されたりするとハッシュと一致せずブロックされてしまいます。ノンスは、CSPによって許可され、スクリプトにタグが付けられているワンタイムコード(ページが読み込まれるたびに変更され推測されるのを防ぐ必要があります)です。このページのノンスの例は、ソースを見てGoogle Tag Managerがどのように読み込まれているかを見ることで見ることができます。

調査対象となったサイトのうち、ノンスソースを使用しているのはデスクトップページで0.09％、ハッシュソースを使用しているのはデスクトップページで0.02％にとどまっている。モバイルページではノンスソースを使用しているサイトは0.13%とやや多いが、ハッシュソースの使用率は0.01%とモバイルページの方が低い。

#### `strict-dynamic`
<a hreflang="en" href="https://www.w3.org/TR/CSP3/">CSP</a>の次のイテレーションにおける<a hreflang="en" href="https://www.w3.org/TR/CSP3/#strict-dynamic-usage">`strict-dynamic`</a>の提案は、ホワイトリスト化されたスクリプトがさらにスクリプトの依存性をロードできるようにすることで、CSPを使用するためのサイト運営者の負担をさらに軽減します。すでに<a hreflang="en" href="https://caniuse.com/#feat=mdn-http_headers_csp_content-security-policy_strict-dynamic">いくつかの最新ブラウザでサポート</a>されているこの機能の導入にもかかわらず、ポリシーにこの機能を含めるのは、デスクトップページの0.03％とモバイルページの0.1％にすぎません。

#### `trusted-types`
XSS攻撃には様々な形がありますが、<a hreflang="en" href="https://github.com/w3c/webappsec-trusted-types">Trusted-Types</a>はDOM-XSSに特化して作られました。効果的なメカニズムであるにもかかわらず、私たちのデータによると、モバイルとデスクトップの2つのページだけがTrusted-Typesディレクティブを使用しています。

#### `unsafe inline`と`unsafe-eval`
CSPがページにデプロイされると、インラインスクリプトや`eval()`の使用のような特定の安全でない機能は無効化されます。ページはこれらの機能に依存し、安全な方法で、おそらくノンスやハッシュソースを使ってこれらの機能を有効にできます。サイト運営者は、`unsafe-inline`や`unsafe-eval`を使って、これらの安全でない機能をCSPで再有効にすることもできますが、その名前が示すようにそうすることでCSPが提供する保護の多くを失うことになります。CSPを含むデスクトップページの5.51％のうち、33.94％が`unsafe-inline`を、31.03％が`unsafe-eval`を含んでいます。モバイルページでは、CSPを含む4.73％のうち、34.04％が`unsafe-inline`を使用し、31.71％が`unsafe-eval`を使用していることがわかります。

#### `upgrade-insecure-requests`
先に、サイト運営者がHTTPからHTTPSへの移行で直面する共通の問題として、一部のコンテンツがHTTPSページのHTTP上に誤って読み込まれてしまう可能性があることを述べました。この問題は混合コンテンツとして知られており、CSPはこの問題を解決する効果的な方法を提供します。upgrade-insecure-requests`ディレクティブは、ブラウザにページ上のすべてのサブリソースを安全な接続で読み込むように指示し、例としてHTTPリクエストをHTTPSリクエストに自動的にアップグレードします。ページ上のサブリソースのためのHSTSのようなものと考えてください。

先に図8.7で示したように、デスクトップで調査したHTTPSページのうち、16.27％のページが混合コンテンツを読み込んでおり、3.99％のページがJS/CSS/fontsなどのアクティブな混合コンテンツを読み込んでいることがわかる。モバイルページでは、HTTPSページの15.37％が混合コンテンツを読み込み、4.13％がアクティブな混合コンテンツを読み込みました。HTTP上でJavaScriptなどのアクティブなコンテンツを読み込むことで、攻撃者は簡単に敵対的なコードをページに注入して攻撃を開始できます。これは、CSPの`upgrade-insecure-requests` ディレクティブが防御しているものです。

`upgrade-insecure-requests`ディレクティブは、デスクトップページの3.24％とモバイルページの2.84％のCSPに含まれており、採用が増えることで大きな利益が得られることを示しています。以下のようなポリシーで、幅広いカテゴリをホワイトリスト化し、`unsafe-inline`や`unsafe-eval`を含めることで、完全にロックダウンされたCSPや複雑さを必要とせずに比較的簡単に導入できます。

```
Content-Security-Policy: upgrade-insecure-requests; default-src https:
```

#### `frame-ancestors`
[クリックジャッキング](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AA%E3%83%83%E3%82%AF%E3%82%B8%E3%83%A3%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0)として知られているもう1つの一般的な攻撃は、敵対するウェブサイトのiframeの中にターゲットのウェブサイトを配置し、自分たちがコントロールしている隠しコントロールやボタンをオーバーレイする攻撃者によって行われます。`X-Frame-Options`ヘッダー(後述)はもともとフレームを制御することを目的としていましたが、柔軟性がなく、CSPの`frame-ancestors`はより柔軟なソリューションを提供するために介入しました。サイト運営者は、フレーム化を許可するホストのリストを指定できるようになり、他のホストがフレーム化しようとするのを防ぐことができるようになりました。

調査したページのうち、デスクトップページの2.85％がCSPで`frame-ancestors`ディレクティブを使用しており、デスクトップページの0.74％がframe-Ancestorsを`'none'`に設定してフレーミングを禁止し、0.47％のページが`frame-ancestors`を`'self'`に設定して自分のサイトのみがフレーミングできるようにしています。モバイルでは2.52％のページが`frame-ancestors`を使用しており、0.71％が`'none'`を設定し、0.41％が`self'`を設定しています。

### 参照元ポリシー
<a hreflang="en" href="https://www.w3.org/TR/referrer-policy/">`Referrer-Policy`</a>ヘッダーは、ユーザーが現在のページから離れた場所へ移動したとき、`Refererer`ヘッダーにどのような情報を送るかをサイトが制御することを可能とします。これは、検索クエリやURLパラメータに含まれるその他のユーザー依存情報など、URLに機密データが含まれている場合、情報漏洩の原因となる可能性があります。`Referer`ヘッダで送信される情報を制御し、理想的には制限することで、サイトはサードパーティに送信される情報を減らすことで訪問者のプライバシーを保護できます。

リファラーポリシーは`Refererer`ヘッダのスペルミス<a hreflang="en" href="https://stackoverflow.com/questions/3087626/was-the-misspelling-of-the-http-field-name-referer-intentional">これはよく知られたエラーとなっています</a>に従っていないことに注意してください。

デスクトップページの3.25％とモバイルページの2.95%が`Referrerer-Policy`ヘッダを発行しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>設定</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>no-referrer-when-downgrade</code></td>
        <td class="numeric">39.16%</td>
        <td class="numeric">41.52%</td>
      </tr>
      <tr>
        <td><code>strict-origin-when-cross-origin</code></td>
        <td class="numeric">39.16%</td>
        <td class="numeric">22.17%</td>
      </tr>
      <tr>
        <td><code>unsafe-url</code></td>
        <td class="numeric">22.17%</td>
        <td class="numeric">22.17%</td>
      </tr>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">7.97%</td>
        <td class="numeric">7.97%</td>
      </tr>
      <tr>
        <td><code>origin-when-cross-origin</code></td>
        <td class="numeric">6.76%</td>
        <td class="numeric">6.44%</td>
      </tr>
      <tr>
        <td><code>no-referrer</code></td>
        <td class="numeric">5.65%</td>
        <td class="numeric">5.38%</td>
      </tr>
      <tr>
        <td><code>strict-origin</code></td>
        <td class="numeric">4.35%</td>
        <td class="numeric">4.14%</td>
      </tr>
      <tr>
        <td><code>origin</code></td>
        <td class="numeric">3.63%</td>
        <td class="numeric">3.23%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" `Referrer-Policy` 設定オプションの使用法。") }}</figcaption>
</figure>

この表はページによって設定された有効な値を示しており、このヘッダーを使用するページのうち、デスクトップでは99.75％、モバイルでは96.55％のページが有効なポリシーを設定していることがわかる。最も人気のある設定は`no-referrer-when-downgrade`で、これはユーザがHTTPSページからHTTPページに移動する際`Refererer`ヘッダが送信されないようにするものです。2番目に人気のある選択は`strict-origin-when-cross-origin`で、これはスキームのダウングレード(HTTPSからHTTPナビゲーション)時に情報が送信されるのを防ぎ、`Refererer`で情報が送信される際にはソースのオリジンのみを含み、完全なURLは含まれません(例えば、`https://www.example.com/page/`ではなく`https://www.example.com`)。その他の有効な設定の詳細は、<a hreflang="en" href="https://www.w3.org/TR/referrer-policy/#referrer-policies">Referrerer Policy specification</a>に記載されています、`unsafe-url`の多用はさらなる調査を必要としますが、アナリティクスや広告ライブラリのような[サードパーティ](./third-parties)コンポーネントである可能性が高いです。

### 機能方針
ウェブプラットフォームがより強力で機能も豊富になるにつれ、攻撃者はこれらの新しいAPIを興味深い方法で悪用できるようになります。強力なAPIの悪用を制限するために、サイト運営者は<a hreflang="en" href="https://w3c.github.io/webappsec-feature-policy/">`Feature-Policy`</a>ヘッダを発行して必要のない機能を無効化し、悪用されるのを防ぐことができます。

ここでは、機能方針で管理されている人気の高い5つの機能をご紹介します。

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
        <td><code>microphone</code></td>
        <td class="numeric">10.78%</td>
        <td class="numeric">10.98%</td>
      </tr>
      <tr>
        <td><code>camera</code></td>
        <td class="numeric">9.95%</td>
        <td class="numeric">10.19%</td>
      </tr>
      <tr>
        <td><code>payment</code></td>
        <td class="numeric">9.54%</td>
        <td class="numeric">9.54%</td>
      </tr>
      <tr>
        <td><code>geolocation</code></td>
        <td class="numeric">9.38%</td>
        <td class="numeric">9.41%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">7.92%</td>
        <td class="numeric">7.90%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" 使用される `Feature-Policy` オプションの上位5つ。") }}</figcaption>
</figure>

コントロールできる最も人気のある機能はマイクで、デスクトップとモバイルページのほぼ11％がマイクを含むポリシーを発行していることがわかります。データを掘り下げていくと、これらのページが何を許可しているか、またはブロックしているかを見ることができます。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>設定</th>
        <th>使用率</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>microphone</code></td>
        <td><code>none</code></td>
        <td class="numeric">9.09%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td><code>none</code></td>
        <td class="numeric">8.97%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td><code>self</code></td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td><code>self</code></td>
        <td class="numeric">0.85%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td><code>*</code></td>
        <td class="numeric">0.64%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td><code>*</code></td>
        <td class="numeric">0.53%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" マイク機能の設定.") }}</figcaption>
</figure>

圧倒的に最も一般的なアプローチは、ここではそのアプローチを取っているページの約9％で、完全にマイクの使用をブロックすることです。少数のページでは、独自のオリジンによるマイクの使用を許可しており、興味深いことにページ内のコンテンツを読み込んでいる任意のオリジンによるマイクの使用を意図的に許可しているページの少数選択があります。

### `X-Frame-Options`
<a hreflang="en" href="https://tools.ietf.org/html/rfc7034">`X-Frame-Options`</a>ヘッダーは、ページが別のページでiframeに配置できるかどうかを制御することを可能にします。上述したCSPの`frame-ancestors`の柔軟性には欠けますが、フレームの細かい制御を必要としない場合には効果的です。

デスクトップ(16.99％)とモバイル(14.77％)の両方で`X-Frame-Options`ヘッダの使用率が非常に高いことがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <th>設定</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>sameorigin</code></td>
        <td class="numeric">84.92%</td>
        <td class="numeric">83.86%</td>
      </tr>
      <tr>
        <td><code>deny</code></td>
        <td class="numeric">13.54%</td>
        <td class="numeric">14.50%</td>
      </tr>
      <tr>
        <td><code>allow-from</code></td>
        <td class="numeric">1.53%</td>
        <td class="numeric">1.64%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" 使用される `X-Frame-Options` の設定。") }}</figcaption>
</figure>

大多数のページでは、そのページのオリジンのみにフレーミングを制限しているようで、次の重要なアプローチはフレーミングを完全に防止することです。これはCSPの`frame-ancestors`と似ており、これら2つのアプローチが最も一般的です。また、`allow-from`オプションは、理論的にはサイト所有者がフレーム化を許可するサードパーティのドメインをリストアップできるようにするものですが、[決して十分にサポートされていないので](https://developer.mozilla.org/docs/Web/HTTP/X-Frame-Options#Browser_compatibility)、非推奨とされています。

### `X-Content-Type-Options`
[`X-Content-Type-Options`](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Content-Type-Options)ヘッダは最も広く展開されているセキュリティヘッダであり、最もシンプルであり、設定可能な値は`nosniff`のみです。このヘッダが発行されると、ブラウザはコンテンツの一部を`Content-Type`ヘッダで宣言されたMIMEタイプとして扱わなければならず、ファイルが異なるタイプのものであることを示唆したときに値を変更しようとはしません。ブラウザが誤ってタイプを嗅ぎ取るように説得された場合、さまざまなセキュリティ上の欠陥が導入される可能性となります。

モバイルとデスクトップの両方で、17.61％のページが`X-Content-Type-Options`ヘッダを発行していることがわかりました。

### `X-XSS-Protection`
[X-XSS-Protection`](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-XSS-Protection)ヘッダーは、サイトがブラウザに組み込まれたXSS AuditorやXSS Filterを制御することを可能にし、理論的には何らかのXSS保護を提供するはずです。

デスクトップリクエストの14.69％とモバイルリクエストの15.2％が`X-XSS-Protection`ヘッダを使用していた。データを掘り下げてみると、ほとんどのサイト運営者がどのような意図を持っているかが図7.13に示されています。

<figure>
  <table>
    <thead>
      <tr>
        <th>設定</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>1;mode=block</code></td>
        <td class="numeric">91.77%</td>
        <td class="numeric">91.46%</td>
      </tr>
      <tr>
        <td><code>1</code></td>
        <td class="numeric">5.54%</td>
        <td class="numeric">5.35%</td>
      </tr>
      <tr>
        <td><code>0</code></td>
        <td class="numeric">2.58%</td>
        <td class="numeric">3.11%</td>
      </tr>
      <tr>
        <td><code>1;report=</code></td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.09%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" `X-XSS-Protection` の利用設定。") }}</figcaption>
</figure>

値`1`はフィルタ/監査を有効にし、`mode=block`は(理論的には)XSS攻撃が疑われる場合にページを表示しないような最も強い保護を設定します。2番目に多かった設定は、単に監査/フィルタがオンになっていることを確認するために`1`という値を提示したもので、3番目に多かった設定は非常に興味深いものでした。

ヘッダーに`0`の値を設定すると、ブラウザが持っている可能性のあるXSSの監査やフィルタを無効にするように指示します。歴史的な攻撃の中には監査やフィルタがユーザーを保護するのではなく、攻撃者を助けるように騙されてしまうことが実証されているものもあるのでサイト運営者の中には、XSSに対する十分な保護があると確信している場合にそれを無効にできるものもあります。

これらの攻撃のため、EdgeはXSSフィルタを引退させ、ChromeはXSS監査を非推奨とし、Firefoxはこの機能のサポートを実装しませんでした。現在ではほとんど役に立たなくなっているにもかかわらず、現在でも全サイトの約15％でヘッダーが広く使われています。

### Report-To
<a hreflang="en" href="https://www.w3.org/TR/reporting/">Reporting API</a> は、サイト運営者が<a hreflang="en" href="https://scotthelme.co.uk/introducing-the-reporting-api-nel-other-major-changes-to-report-uri/">ブラウザからの遠隔測定</a>の様々な情報を収集できるようにするため導入されました。サイト上の多くのエラーや問題は、ユーザーの体験を低下させる可能性がありますが、サイト運営者はユーザーが連絡しなければ知ることができません。Reporting APIは、ユーザーの操作や中断なしに、ブラウザがこれらの問題を自動的に報告するメカニズムを提供します。Reporting APIは`Report-To`ヘッダーを提供することで設定されます。

遠隔測定を送信すべき場所を含むヘッダーを指定することでブラウザは自動的にデータの送信を開始し、<a hreflang="en" href="https://report-uri.com/">Report URI</a>のようなサードパーティのサービスを使用してレポートを収集したり、自分で収集したりできます。導入と設定の容易さを考えると、現在この機能を有効にしているサイトは、デスクトップ（1.70％）とモバイル（1.57％）のごく一部に過ぎないことがわかります。収集できるテレメトリの種類については、<a hreflang="en" href="https://www.w3.org/TR/reporting/">Reporting API仕様</a>を参照してください。

### ネットワークエラーロギング
<a hreflang="en" href="https://www.w3.org/TR/network-error-logging/">ネットワークエラーロギング(NEL)</a>は、サイトが動作不能になる可能性のあるブラウザのさまざまな障害についての詳細な情報を提供します。`Report-To`が読み込まれたページの問題を報告するために使用されるのに対し、`NEL`ヘッダーを使用すると、サイトはブラウザにこのポリシーをキャッシュするように通知し、将来の接続問題が発生したときに上記の`Reporting-To`ヘッダーで設定されたエンドポイントを介して報告できます。したがって、NELはReporting APIの拡張機能とみなすことができます。

もちろん、NELはReporting APIに依存しているので、NELの使用量がReporting APIの使用量を上回ることはありません。これらの数値が同じであるという事実は、これらが一緒にデプロイされていることを示唆しています。

NELは信じられないほど貴重な情報を提供しており、情報の種類については<a hreflang="en" href="https://w3c.github.io/network-error-logging/#predefined-network-error-types">ネットワークエラーロギング仕様</a>で詳しく説明しています。

### クリアサイトデータ
クッキー、キャッシュ、ローカルストレージなどを介してユーザーのデバイスにデータをローカルに保存する機能が増えているため、サイト運営者はこのデータを管理する信頼性の高い方法を必要としていました。Clear Site Dataヘッダーは、特定のタイプのすべてのデータがデバイスから削除されることを確実にする手段を提供しますが、<a hreflang="en" href="https://caniuse.com/#feat=mdn-http_headers_clear-site-data">すべてのブラウザではまだサポートされていません</a>。

このヘッダの性質を考えると、使用量がほとんど報告されていないのは驚くに値しません。デスクトップリクエストが9件、モバイルリクエストが7件だけです。私たちのデータはサイトのホームページしか見ていないので、ログアウトのエンドポイントでヘッダーが最もよく使われているのを見ることはないでしょう。サイトからログアウトすると、サイト運営者はClear Site Dataヘッダを返し、ブラウザは指定されたタイプのすべてのデータを削除します。これはサイトのホームページでは行われないでしょう。

## クッキー
クッキーには利用可能な多くのセキュリティ保護があり、それらのいくつかは長年にわたって利用可能であるが、それらのいくつかは本当に非常に新しいものでありここ数年の間に導入されただけです。

### `Secure`
クッキーの`Secure`フラグは、ブラウザに安全な(HTTPS)接続でのみクッキーを送信するように指示し、ホームページでセキュアフラグが設定されたクッキーを発行しているサイトはごくわずかな割合(デスクトップでは4.22％、モバイルでは3.68％)であることがわかります。この機能が比較的簡単に使用できることを考えると、これは憂慮すべきことです。繰り返しになりますが、HTTPとHTTPSの両方でデータを収集したいと考えている分析や広告[サードパーティ](./third-parties)リクエストの高い使用率がこれらの数字を歪めている可能性が高く、認証クッキーのような他のクッキーでの使用状況を見るのは興味深い調査でしょう。

### `HttpOnly`
クッキーの`HttpOnly`フラグはブラウザにページ上のJavaScriptがクッキーへアクセスできなくすることを指示します。多くのクッキーはサーバによってのみ使用されるので、ページ上のJavaScriptが必要としないため、クッキーへのアクセスを制限することはクッキーを盗むXSS攻撃からの大きな防御となります。デスクトップでは24.24％、モバイルでは22.23％と、ホームページ上でこのフラグを立ててクッキーを発行しているサイトの方がはるかに多いことがわかります。

### `SameSite`
クッキーの保護に追加された最近の追加機能として、`SameSite`フラグは [クロスサイトリクエストフォージェリ(CSRF)](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AD%E3%82%B9%E3%82%B5%E3%82%A4%E3%83%88%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%83%95%E3%82%A9%E3%83%BC%E3%82%B8%E3%82%A7%E3%83%AA)攻撃(XSRFとしてもよく知られています)に対する強力な保護となります。

これらの攻撃は、ブラウザが通常、すべてのリクエストに関連するクッキーを含むという事実を利用して動作します。したがって、ログインしていてクッキーが設定されていて、悪意のあるサイトを訪問した場合、APIを呼び出すことができブラウザは「親切に」クッキーを送信します。クッキーに`SameSite`属性を追加することで、第三者のサイトからの呼び出しがあった場合にクッキーを送信しないようにウェブサイトがブラウザに通知し、攻撃を失敗させることができます。

最近導入されたメカニズムなので、デスクトップとモバイルの両方でリクエストの0.1％と予想されるように、同じサイトのクッキーの使用率ははるかに低くなっています。クッキーがクロスサイトで送信されるべき使用例があります。例えば、シングルサインオンサイトは認証トークンと一緒にクッキーを設定することで暗黙のうちに動作します。

<figure>
  <table>
    <thead>
      <tr>
        <th>設定</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>strict</code></td>
        <td class="numeric">53.14%</td>
        <td class="numeric">50.64%</td>
      </tr>
      <tr>
        <td><code>lax</code></td>
        <td class="numeric">45.85%</td>
        <td class="numeric">47.42%</td>
      </tr>
      <tr>
        <td><code>none</code></td>
        <td class="numeric">0.51%</td>
        <td class="numeric">0.41%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" SameSite設定の使用法。") }}</figcaption>
</figure>

既にSame-Siteのクッキーを利用しているページのうち、半分以上が`strict`モードで利用していることがわかる。これに続いて、`lax`モードでSame-Siteを利用しているサイト、そして少数のサイトでは`none`を利用しているサイトが続いています。この最後の値は、ブラウザベンダーが`lax`モードをデフォルトで実装する可能性があるという今後の変更をオプトアウトするために使用されます。

この機能は危険な攻撃からの保護を提供するため、現在のところ、主要なブラウザが <a hreflang="en" href="https://blog.chromium.org/2019/10/developers-get-ready-for-new.html">デフォルトでこの機能を実装</a>し、値が設定されていなくてもクッキーに対してこの機能を有効にする可能性があると指摘されています。これが実現した場合、SameSiteの保護機能は有効になりますが、`strict`モードではなく`lax`モードの弱い設定では、より多くの破損を引き起こす可能性があるためです。

### プレフィックス
クッキーに最近追加されたもう一つの方法として、クッキープレフィックスがあります。これらはクッキーの名前を使用して、すでにカバーされている保護に加えて、2つのさらなる保護のうちの1つを追加します。上記のフラグはクッキー上で誤って設定を解除される可能性がありますが、名前は変更されませんので、セキュリティ属性を定義するために名前を使用することでより確実にフラグを強制できます。

現在のところ、クッキーの名前の前には`__Secure-`か`__Host-`のどちらかを付けることができ、どちらもクッキーに追加のセキュリティを提供しています。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >ホームページ数</th>
        <th scope="colgroup" colspan="2" >ホームページの割合</th>
      </tr>
      <tr>
        <th scope="col">プレフィックス値</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>__Secure-</code></td>
        <td class="numeric">640</td>
        <td class="numeric">628</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><code>__Host-</code></td>
        <td class="numeric">154</td>
        <td class="numeric">157</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
    </tbody>
  </table>

<figcaption>{{ figure_link(caption=" クッキーのプレフィックスの使用法") }}</figcaption>
</figure>

図が示すように、どちらのプレフィックスの使用率も信じられないほど低いのですが、2つのプレフィックスが緩和されているため`__Secure-`プレフィックスの方がすでに利用率は高いです。

## サブリソースの完全性
最近増えているもう1つの問題は、サードパーティの依存関係のセキュリティです。サードパーティからスクリプトファイルを読み込む際には、スクリプトファイルが常に欲しいライブラリ、おそらく特定のバージョンのjQueryであることを期待します。CDNやサードパーティのホスティングサービスが危殆化した場合、それらをホスティングしているスクリプトファイルを変更される可能性があります。このシナリオでは、アプリケーションは訪問者に危害を加える可能性のある悪意あるJavaScriptを読み込んでいることになります。これが、サブリソースの完全性が保護する機能です。

スクリプトやリンクタグに`integrity`属性を追加することで、ブラウザはサードパーティのリソースの整合性をチェックし、変更された場合は拒否できます。

```html
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
```

整合性属性が設定されたリンクまたはスクリプトタグを含むデスクトップページの0.06％（247,604）とモバイルページの0.05％（272,167）しかないため、SRIの使用には多くの改善の余地があります。現在、多くのCDNがSRIの整合性属性を含むコードサンプルを提供しているため、SRIの使用は着実に増加していると思われます。

## 結論

Webの機能が向上し、より多くの機密データへのアクセスが可能になるにつれ、開発者が自社のアプリケーションを保護するためにWebセキュリティ機能を採用することがますます重要になってきています。本章でレビューするセキュリティ機能は、Webプラットフォーム自体に組み込まれた防御機能であり、すべてのWeb制作者が利用可能です。しかし、本章の研究結果のレビューからもわかるように、いくつかの重要なセキュリティメカニズムはウェブの一部にしか適用されていないため、エコシステムのかなりの部分がセキュリティやプライバシーのバグにさらされたままとなっています。

### 暗号化

ここ数年の間に、転送中データの暗号化については、Webが最も進歩しています。[TLSセクション](#トランスポートレイヤーセキュリティ)で説明したように、ブラウザーベンダー、開発者、Let's Encryptのような認証局の様々な努力のおかげで、HTTPSを使用しているウェブの割合は着実に増加しています。本稿執筆時点では、大多数のサイトがHTTPSで利用可能であり、トラフィックの機密性と完全性が確保されています。重要なことに、HTTPSを有効にしているWebサイトの99％以上では、TLSプロトコルの新しい安全なバージョン（TLSv1.2およびTLSv1.3）が使用されています。GCMモードでのAESなどの強力な[cipher suites](#暗号スイート)の使用率も高く、すべてのプラットフォームで95％以上のリクエストを占めています。

同時に、TLS設定のギャップは依然としてかなり一般的です。15％以上のページが[混合コンテンツ](#混合コンテンツ)の問題に悩まされており、ブラウザに警告が表示され、4％のサイトではセキュリティ上の理由から最新のブラウザにブロックされています。同様に、[HTTP Strict Transport Security](#http-strict-transport-security)の利点は、主要なサイトのごく一部にしか及ばず、大多数のWebサイトでは最も安全なHSTS構成を有効にしておらず、[HSTS プリロード](#hstsプリロード)の対象外となっています。HTTPSの採用が進んでいるにもかかわらず、未だに多くのクッキーが`Secure`フラグなしで設定されており、クッキーを設定しているホームページのうち、暗号化されていないHTTPでの送信を防止しているのはわずか4％に過ぎません。

### 一般的なウェブの脆弱性からの防御

機密データを扱うサイトで作業するウェブ開発者は、[XSS](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AD%E3%82%B9%E3%82%B5%E3%82%A4%E3%83%88%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0wiki/Cross-site_scripting)、[CSRF](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AD%E3%82%B9%E3%82%B5%E3%82%A4%E3%83%88%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%83%95%E3%82%A9%E3%83%BC%E3%82%B8%E3%82%A7%E3%83%AA)、[クリックジャッキング](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AA%E3%83%83%E3%82%AF%E3%82%B8%E3%83%A3%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0)、およびその他の一般的なウェブバグからアプリケーションを保護するために、オプトインウェブセキュリティ機能を有効にしていることがよくあります。これらの問題は、[`X-Frame-Options`](#x-frame-options)、[`X-Content-Type-Options`](#x-content-type-options)、[`コンテンツセキュリティポリシー`](#コンテンツセキュリティポリシー)を含む、多くの標準的で広くサポートされているHTTPレスポンスヘッダを設定することで緩和できます。

セキュリティ機能とウェブアプリケーションの両方共複雑であることが大部分を占めていますが、現在これらの防御機能を利用しているウェブサイトは少数派であり、多くの場合、リファクタリングの努力を必要としないメカニズムのみを有効にしています。最も一般的なオプトインアプリケーションのセキュリティ機能は、`X-Content-Type-Options` (17％のページで有効)、`X-Frame-Options` (16％)、および非推奨の`X-XSS-Protection`ヘッダ(15％)です。最も強力なWebセキュリティメカニズムであるコンテンツセキュリティポリシーは、5％のWebサイトでしか有効になっておらず、そのうちのごく一部(全サイトの約0.1％)だけが[CSP ナンスとハッシュ](#ハッシュノンス)に基づいたより安全な設定を使用しています。関連する [`参照元ポリシー`](#参照元ポリシー)は、`Referer`ヘッダーで第三者に送信される情報量を減らすことを目的としているが、同様に使用しているのは3％のウェブサイトのみです。

### 現代のウェブプラットフォームの防御

近年、ブラウザーは、主要な脆弱性や新たなWeb脅威からの保護を提供する強力な新しいメカニズムを実装しています; これには、[サブリソースの完全性](#サブリソースの完全性)、[同じサイトのクッキー](#samesite)、および[クッキーのプレフィックス](#プレフィックス)が含まれます。

これらの機能は比較的少数のウェブサイトでしか採用されていません。<a hreflang="en" href="https://w3c.github.io/webappsec-trusted-types/dist/spec/">Trusted Types</a>、[オリジン間リソース共有](https://developer.mozilla.org/docs/Web/HTTP/Cross-Origin_Resource_Policy_(CORP))、<a hreflang="en" href="https://www.chromestatus.com/feature/5432089535053824">オリジン間オープナー共有</a>のような、さらに最近のセキュリティメカニズムは、まだ広く採用されていません。

同様に、[Reporting API](#report-to)、[ネットワークエラーロギング](#ネットワークエラーロギング)、[`Clear-Site-Data`](#クリアサイトデータ)ヘッダのような便利な機能もまだ初期段階であり、現在は少数のサイトで利用されています。

## 結びつき

ウェブの規模では、オプトインプラットフォームのセキュリティ機能の全体的なカバー率は、現在のところ比較的低い。最も広く採用されている保護であっても、一般的なセキュリティ問題に対するプラットフォームのセーフガードを持たないウェブの大部分を残して、ウェブサイトの4分の1未満で有効になっています。

しかし、これらのメカニズムの採用は、より機密性の高いユーザーデータを頻繁に扱う大規模なウェブアプリケーションに偏っていることに注意することが重要です。これらのサイトの開発者は、一般的な脆弱性に対する様々な保護を可能にすることを含め、ウェブの防御力を向上させるために投資することが多くなっています。<a hreflang="en" href="https://observatory.mozilla.org/">Mozilla Observatory</a>や<a hreflang="en" href="https://securityheaders.com/">Security Headers</a>などのツールは、ウェブで利用可能なセキュリティ機能の便利なチェックリストを提供してくれます。

ウェブアプリケーションが機密性の高いユーザーデータを扱う場合はユーザーを保護し、ウェブをより安全にするためこのセクションで概説されているセキュリティメカニズムを有効にすることを検討してください。
