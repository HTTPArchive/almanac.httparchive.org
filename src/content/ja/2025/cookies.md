---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookie
description: 2025年版Web AlmanacのCookieチャプターでは、ウェブ上のCookieの普及状況と構造を取り上げます。
hero_alt: Web Almanacのキャラクターが大きなCookieを運んでいるヒーロー画像。別のキャラクターがクズを弾き飛ばし、もう一人のキャラクターが探偵の帽子と虫眼鏡を持ってCookieの跡を追っています。
authors: [yohhaan]
reviewers: [JannisBush, martinakraus]
analysts: [ChrisBeeti]
editors: [bsmth, tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1ZirsnaXgbOMzBmt0X2eMMu3rVJvWCtQgE7pNG7fKcvc/edit
yohhaan_bio: Yohan BeuginはWisconsin大学マディソン校のコンピュータサイエンス学科の博士課程の学生で、セキュリティとプライバシー研究グループのメンバーであり、Patrick McDaniel教授の指導を受けています。より安全で、プライバシーを保護し、信頼できるシステムの構築に関心を持っています。現在の研究はオンライン広告のトラッキングとプライバシー、そしてオープンソースソフトウェアのセキュリティに焦点を当てています。
featured_quote: 全体として、CookieはウェブにとってPrivacyとセキュリティリスクをもたらし続ける基本的なコンポーネントです。ファーストパーティとサードパーティの両方のCookieがトラッキングに使用されており、Brave、Safari、Firefoxなど複数のウェブブラウザがサードパーティCookieを廃止または制限している一方、Googleは2025年にChromeでのサードパーティCookieのサポートを継続し、Privacy Sandboxの提案のほとんどを廃止することを決定しました。
featured_stat_1: 60%
featured_stat_label_1: サードパーティのCookieの割合
featured_stat_2: 11%
featured_stat_label_2: `SameSite=None`を持つファーストパーティのデスクトップCookie
featured_stat_3: 10%
featured_stat_label_3: パーティション化されたサードパーティCookie（CHIPS）
doi: 10.5281/zenodo.18246755
---

## はじめに

[Cookie](https://developer.mozilla.org/docs/Web/HTTP/Cookies)は、ステートレスなプロトコルであるHTTPリクエストにわたって、ウェブサイトがデータを保存し状態情報を維持できるようにします。ウェブアプリケーションは認証、不正防止とセキュリティ、設定やユーザーの選択の記憶など、さまざまな目的でCookieを使用します。しかし、1990年代中頃に登場して以来、Cookieはウェブユーザーのオンライントラッキングでも支配的な役割を果たしてきました。

長年にわたり、Brave、Firefox、SafariなどのブラウザベンダーはサードパーティCookieに対して[制限を課し、パーティション化し、削除](https://developer.mozilla.org/docs/Web/Privacy/Guides/Third-party_cookies#how_do_browsers_handle_third-party_cookies)してきました。Chromeも当初は同様の手順に従うように見え、<a hreflang="en" href="https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html">すべてのサードパーティCookieをブロックする計画</a>を発表しましたが、複数の延期の後、Googleは最終的に<a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">サードパーティCookieの制限を維持せず、ユーザーがChromeで無効にするかどうかを決定できるようにする</a>ことを決定しました。

本チャプターでは、2025年7月のHTTP Archiveクロールによって訪問されたウェブページで遭遇したウェブCookieの普及状況と構造を測定し報告します。特に言及がない限り、これらの結果の大半は、クロール時にHTTP Archiveデータセットに記録されたChrome User Experience report（CrUX）のランクに基づく上位100万（トップミリオン）の人気ウェブサイトに対するものです。デスクトップとモバイルデバイスの両方の結果も示していますが、実際のところ本チャプターでは2種類のデバイス間に有意な差はほとんど見られません。

## 背景

まず、本チャプターで使用されるいくつかの用語について共通の理解を得ましょう。

### HTTP Cookie

ユーザーがウェブサイトを訪問すると、ユーザーのウェブブラウザに[HTTP Cookie](https://developer.mozilla.org/docs/Web/HTTP/Cookies)を設定・保存するよう要求できるウェブサーバーとやり取りします。このCookieはユーザーのデバイスにテキスト文字列として保存されたデータに対応し、以降のHTTPリクエストとともにウェブサーバーに送信されます。Cookieは複数のHTTPリクエストにわたってユーザーのステートフルな情報を維持するために使用されます。これにより認証、セッション管理、トラッキングが可能になります。また、CookieはプライバシーとセキュリティリスクとIも関連しています。

### ファーストパーティCookieとサードパーティCookie

Cookieはウェブサーバーによって設定され、ファーストパーティとサードパーティの2種類があります。ファーストパーティCookieはユーザーが訪問しているサイトと同じドメインによって設定され、サードパーティCookieは異なるドメインから設定されます。

サードパーティCookieはサードパーティからのもの、またはトップレベルサイトと同じ「ファーストパーティ」に属する異なるサイトやサービスからのものである場合があります。サードパーティCookieは実質的にクロスサイトCookieです。

例えば、`example.com`のドメインのオーナーが`example.net`も所有しており、`https://www.example.com`を訪問するユーザーに対して以下のCookieが設定されているとします：

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookie名</th>
        <th>設定元</th>
        <th>Cookieの種類</th>
        <th>理由</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`cookie_a`</td>
        <td>`www.example.com`</td>
        <td>ファーストパーティ</td>
        <td>訪問したウェブサイトと同じドメイン</td>
      </tr>
      <tr>
        <td>`cookie_b`</td>
        <td>`cart.example.com`</td>
        <td>ファーストパーティ</td>
        <td>訪問したウェブサイトと同じドメイン：サブドメインは関係しない</td>
      </tr>
      <tr>
        <td>`cookie_c`</td>
        <td>`www.example.edu`</td>
        <td>サードパーティ</td>
        <td>訪問したウェブサイトと異なるドメイン</td>
      </tr>
      <tr>
        <td>`cookie_d`</td>
        <td>`tracking.example.org`</td>
        <td>サードパーティ</td>
        <td>訪問したウェブサイトと異なるドメイン</td>
      </tr>
      <tr>
        <td>`cookie_e`</td>
        <td>`login.example.net`</td>
        <td>サードパーティ</td>
        <td>この例では同じオーナーが所有していても訪問したウェブサイトとは異なるドメイン（トップレベルサイトの同じ「ファーストパーティ」からのクロスサイトCookie）</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Cookieのコンテキスト。") }}</figcaption>
</figure>

### プライバシーとセキュリティのリスク

Cookieはウェブの機能に欠かせませんが、プライバシーとセキュリティのリスクをもたらします：

- **ウェブトラッキング。** Cookieはサードパーティによってウェブサイトをまたいでユーザーを追跡し、ブラウジング行動と興味を記録するために使用されます。ターゲット広告では、このデータがユーザーの興味に合わせた広告を表示するために活用されます。

  このトラッキングは通常次のように行われます：サイトに埋め込まれたサードパーティコードがユーザーを識別するCookieを設定できます。次に、同じサードパーティは、同じく埋め込まれている他のウェブサイトをユーザーが訪問したときにそのCookieを取得することでユーザーアクティビティを記録できます（[Privacy](./privacy)チャプターも参照）。

  ファーストパーティCookieもオンライントラッキングに使用できることに注意が必要です。Cookie同期などの方法によりサードパーティCookieの制限を回避し、ユーザーを<a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3442381.3449837">異なるウェブサイトにわたって</a>追跡することが可能です。

- **Cookieの盗難とセッションハイジャック。** Cookieは複数のHTTPリクエストにわたる認証のために、認証情報（例えばセッショントークン）などのセッション情報を保存するために使用されます。ただし、これらのCookieが悪意のある攻撃者に入手された場合、対応するウェブサーバーへの認証に使用される可能性があります。

  Cookieがウェブサーバーによって適切に設定されていない場合、[セッションハイジャック](https://developer.mozilla.org/docs/Glossary/Session_Hijacking)、[クロスサイトリクエストフォージェリ（CSRF）](https://developer.mozilla.org/docs/Web/Security/Practical_implementation_guides/CSRF_prevention)、[クロスサイトスクリプトインクルージョン（XSS）](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting)などのクロスサイト脆弱性にさらされる可能性があります（[Security](./security)チャプターも参照）。

## ファーストパーティとサードパーティの普及率

{{ figure_markup(
  image="first-and-third-party-prevalence.png",
  caption="ファーストパーティとサードパーティの普及率。",
  description="デスクトップとモバイルのファーストパーティとサードパーティのCookieの普及率を示すグラフ。デスクトップでは：ファーストパーティ41%、サードパーティ59%。モバイルでは：ファーストパーティ40%、サードパーティ60%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=133146154&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

2025年7月のHTTP Archiveクロールによる上位100万の人気ウェブサイトにおけるファーストパーティとサードパーティCookieの全体的な普及率は、[昨年の分布](../2024/cookies#ファーストパーティとサードパーティの普及率)と同様です。

デスクトップとモバイルデバイスの両方で、Cookieの約40%がファーストパーティ、約60%がサードパーティです。

### ランク別のファーストパーティとサードパーティの普及率

{{ figure_markup(
  image="first-and-third-party-prevalence-by-rank-desktop.png",
  caption="デスクトップにおけるランク別のファーストパーティとサードパーティCookieの普及率。",
  description="ウェブサイトの人気度に応じたデスクトップのファーストパーティとサードパーティのCookieの普及率を示すグラフ。より人気のあるウェブサイトは、サードパーティCookieを大幅に多く設定することがわかります。デスクトップの上位1,000の人気ウェブサイトでは、設定されたCookieの78%がサードパーティであり、上位100万サイトでは59%がサードパーティCookieです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1437171045&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

{{ figure_markup(
  image="first-and-third-party-prevalence.png-by-rank-mobile.png",
  caption="モバイルにおけるランク別のファーストパーティとサードパーティCookieの普及率。",
  description="ウェブサイトの人気度に応じたモバイルのファーストパーティとサードパーティCookieの普及率を示すグラフ。より人気のあるウェブサイトは、サードパーティCookieを大幅に多く設定することがわかります。デスクトップの上位1,000の人気ウェブサイトでは、設定されたCookieの78%がサードパーティであり、上位100万サイトでは60%がサードパーティCookieです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=76250674&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

最も人気のあるウェブサイトが比例してファーストパーティよりもサードパーティCookieを多く設定していることが観察されます：最も訪問される上位1,000サイトではCookieの78%がサードパーティですが、上位1,000万サイトでは50%をわずかに下回ります。これは、より人気のあるウェブサイトもより多くのサードパーティコンテンツとスクリプトを含んでおり、それらがさまざまな機能を有効にするためにサードパーティCookieを設定するという事実によって説明される可能性があります。

## Cookieの属性

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  caption="デスクトップにおけるCookie属性の概要。",
  description="デスクトップのファーストパーティとサードパーティCookieに対するCookie属性の使用状況の概要。ファーストパーティCookieの1%とサードパーティCookieの10%のみが`Partitioned`を使用しています。ファーストパーティCookieの19%が`Session`属性を設定しており、サードパーティCookieではわずか7%のみがそうしています。最後に、ファーストパーティCookieの12%とサードパーティCookieの28%が`HttpOnly`属性を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1053912620&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="モバイルにおけるCookie属性の概要。",
  description="モバイルのファーストパーティとサードパーティCookieに対するCookie属性の使用状況の概要。デスクトップと全く同じ結果が観察されます。ファーストパーティCookieの1%とサードパーティCookieの9%のみが`Partitioned`を使用しています。ファーストパーティCookieの19%が`Session`属性を設定しており、サードパーティCookieではわずか5%のみがそうしています。最後に、ファーストパーティCookieの12%とサードパーティCookieの26%が`HttpOnly`属性を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=435743769&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

データは観察された各種Cookieのさまざまな[Cookie属性](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie)を示しています。それぞれについて詳しく見ていきましょう。

### `Partitioned`（CHIPSプロポーザル）

[対応ブラウザ](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility)では、パーティション化されたCookieは、トップレベルサイトごとにパーティション化されたストレージに配置することで、サードパーティCookieがクロスサイトトラッキングに使用されるのを防ぎます。

{{ figure_markup(
  caption="モバイルページでの`Partition` Cookieの割合。",
  content="8.6%",
  classes="big-number",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
)
}}

2025年7月、上位100万のサードパーティCookieの約9%がパーティション化されています。これは[昨年の結果の6%](../2024/cookies#partitioned)と比較して、この比較的新しい属性の採用がわずかに増加したことを示しています。

{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="サードパーティコンテキストでのトップパーティション化Cookie（CHIPS）。",
  description="パーティション化されたCookieを設定するトップサードパーティドメインを示すグラフ。サードパーティコンテキストでのトップパーティション化Cookieは、Cloudflareが設定する`cf_clearance`でアンチボットチャレンジに使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1834436287&format=interactive",
  sheets_gid="581303793",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}

上記のグラフは、2025年7月のウェブページのサードパーティコンテキストで見つかった最も一般的な10のパーティション化Cookie（名前とドメイン）を示しています。ここで、昨年の分析からの大きな変化が観察されます。実際、2025年のサードパーティパーティション化Cookieの全体的な使用量は非常に低いレベルに急落したようです。

興味深いことに、2024年にある程度主流だったパーティション化Cookie（パーティション化Cookieを持つウェブサイトの約9%）はもはや存在しません。これらのCookieのうち2つはYouTubeによって設定されたものであり、もう1つはChromesのPrivacy Sandbox[テストフェーズに参加](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing)したドメインによって設定された`receive-cookie-deprecation` Cookieでした。代わりに、2025年の最も一般的なパーティション化サードパーティCookieTOP10の全体をCloudflareの`cf_clearance` Cookieが占めています。

したがって、過去1年間でYouTubeは`youtube.com`と他のウェブサイトに埋め込まれたビデオiframeでのこれらのCookieの設定方法を変更したようです。これらの変更を説明できる潜在的な理由には、誤った設定、A/Bテスト、そしてより可能性が高いのは、パーティション化Cookie（CHIPSプロポーザル）のサポートが継続されているにもかかわらず、Privacy Sandbox APIの一時停止とその後の廃止に関するGoogleの発表に続くインフラやポリシーの更新が含まれます。

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="ファーストパーティコンテキストでのトップパーティション化Cookie（CHIPS）。",
  description="トップファーストパーティパーティション化Cookieを示すグラフ。トップCookieの`cf_clearance`はCloudflareによって設定されており、パーティション化Cookieを持つページの約92%に存在し、ボット検出に関連しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1232746047&format=interactive",
  sheets_gid="581303793",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}

2025年においても、ファーストパーティCookieの1%がパーティション化として設定されていることが引き続き観察されます。これはやや意外かもしれません。CHIPSプロポーザルは主にサードパーティCookieのパーティション化に関するものであり、パーティション化されたファーストパーティCookieの<a hreflang="en" href="https://github.com/privacycg/CHIPS?tab=readme-ov-file#first-party-chips">特定のまれなケース</a>を述べていても、<a hreflang="en" href="https://github.com/privacycg/CHIPS/issues/51">動作要件</a>はファーストパーティコンテキストでは不明確です。一つの理由として、一部のCookieが常に同じ方法で設定されており、設定するウェブサーバーが現在ファーストパーティかサードパーティかを区別していない可能性があります。

2025年、これらのファーストパーティパーティション化Cookieの90%以上がボット検出に関連するCloudflareの`cf_clearance` Cookieです。[2024年の分析](/2024/cookies#fig-8)と比較すると、Privacy Sandbox APIテストに参加しているドメインによって設定されたファーストパーティパーティション化Cookie `receive-cookie-deprecation`は、もはやそれほど人気がありません。おそらく、この観察は過去1年間のGoogleの対応する発表によるこれらのAPIの採用の一時停止または減少によって説明できるかもしれません。

### セッション

ファーストパーティCookieの19%とサードパーティCookieの7%はセッションCookieです。これらは単一のユーザーセッションにのみ有効な一時的なCookieで、ユーザーが設定された対応するウェブサイトを終了するか、ウェブブラウザを閉じるか、どちらか早い方が起きると期限切れになります。

### `HttpOnly`

[`HttpOnly`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#httponly) Cookieは、JavaScriptコードからアクセスできないため（ただし、JavaScriptから開始された`XMLHttpRequest`や`fetch`リクエストとともに送信されます）、[クロスサイトスクリプティング（XSS）](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting)に対するある程度の軽減策を提供します。

ファーストパーティCookieの12%とサードパーティCookieの26%強がこの属性を設定しています。

### `Secure`

[`Secure`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#secure) CookieはHTTPSを通じて行われたリクエストにのみ送信されます。[昨年の傾向と同様](../2024/cookies#secure)で、ファーストパーティCookieの24%のみがこの属性を設定しているのに対し、すべてのサードパーティCookieは`SameSite=None`を使用したい場合はこの属性を設定する必要があります（以下を参照）。

### `SameSite`

[`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) Cookie属性は、サイトがクロスサイトリクエストにCookieを含めるタイミングを指定できるようにします：

- `SameSite=Strict`：CookieはCookieのオリジンと同じサイトからのリクエストに応じてのみ送信されます。
- `SameSite=Lax`：ブラウザがCookieのオリジンサイトへのナビゲーション時にもCookieを送信する点を除いて`SameSite=Strict`と同じです。Chromeでは、値が設定されていない場合のデフォルト値が`SameSite=Lax`です。
- `SameSite=None`：CookieはサイトとCookieの同一サイトまたはクロスサイトリクエストで送信されます。
  これはCookieによるサードパーティトラッキングを可能にするために、トラッキングCookieは`SameSite`属性を`None`に設定する必要があることを意味します。

`SameSite`属性の詳細については、以下の参考資料を参照してください：

- [`SameSite` cookies explained](https://web.dev/articles/samesite-cookies-explained)
- ["Same-site" and "same-origin"](https://web.dev/articles/same-site-same-origin)
- [What are the parts of a URL?](https://web.dev/articles/url-parts)

{{ figure_markup(
  image="same-site-desktop.png",
  caption="デスクトップにおけるCookieの`SameSite`属性。",
  description="デスクトップのファーストパーティとサードパーティCookieの`SameSite`属性とその値の普及率を示します。ファーストパーティCookieの3%が`SameSite`属性を`Strict`に設定し、19%が`SameSite=Lax`（Chromeのデフォルト）を使用し、11%が値を`None`に設定し、66%が`SameSite`の値を指定していません。サードパーティCookieのほぼ100%がクロスサイトコンテキストで送信されるために`SameSite`属性を`None`に設定しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=42361140&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="same-site-mobile.png",
  caption="モバイルにおけるCookieの`SameSite`属性。",
  description="モバイルのファーストパーティとサードパーティCookieの`SameSite`属性とその値の普及率を示します。デスクトップとほぼ同様の結果が見られます。ファーストパーティCookieの3%が`SameSite`属性を`Strict`に設定し、19%が`SameSite=Lax`（Chromeのデフォルト）を使用し、11%が値をNoneに設定し、63%が`SameSite`の値を指定していません。サードパーティCookieのほぼ100%がクロスサイトコンテキストで送信されるために`SameSite`属性を`None`に設定しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=413420306&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

クライアントにわたるファーストパーティとサードパーティCookieのこの属性の全体的な分布は[昨年のもの](../2024/cookies#samesite)と同様です。サードパーティCookieのほぼ100%がクロスサイトリクエストで送信され（`SameSite=None`）、これによりクロスサイトトラッキングが可能になります。

ファーストパーティCookieの大半（デスクトップで66%、モバイルで62%）はこの属性を設定しておらず、Chromeはデフォルトの`Lax`動作を割り当てます。これはファーストパーティCookieの他の19%が明示的に選択している動作と同じです。`Strict`設定は3%のみで、残りの11%はサイトとCookieの同一サイトとクロスサイトの両方のリクエストで送信されています（`SameSite=None`）。

## Cookieのプレフィックス

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="デスクトップページで観察されたCookieのプレフィックス。",
  description="デスクトップページで使用される観察されたCookieのプレフィックスを示します。ファーストパーティとサードパーティCookieのいずれも、`__Host-`または`__Secure-`プレフィックスを含むものはほとんどいません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=908965565&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="モバイルページで観察されたCookieのプレフィックス。",
  description="モバイルページで使用される観察されたCookieのプレフィックスを示します。ファーストパーティとサードパーティCookieのいずれも、`__Host-`または`__Secure-`プレフィックスを含むものはほとんどいません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1209286948&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

[Cookieのプレフィックス](https://developer.mozilla.org/docs/Web/HTTP/Cookies#cookie_prefixes) `__Host-`と`__Secure-`はCookie名に使用して、安全なHTTPSオリジンによってのみ設定または変更できることを示すことができます。これは[セッション固定](https://developer.mozilla.org/docs/Web/Security/Types_of_attacks#session_fixation)攻撃から防御するためのものです。

両方のプレフィックスを持つCookieは安全なHTTPSオリジンによって設定され、`Secure`属性が設定されている必要があります。さらに、`__Host-` Cookieは`Domain`属性を含まず、`Path`を`/`に設定する必要があります。そのため、`__Host-` Cookieは設定されたまさにそのホストにのみ送り返され、親ドメインには送られません。

ここでは[昨年](../2024/cookies#cookieのプレフィックス)と同じ結論を導きます。これらのプレフィックスは10年前に導入されて以来、ウェブでの採用率が非常に低く、実際には提供する多層防御の措置は使用されていません。

## 上位のCookieとそれらを設定するドメイン

{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="設定されたトップファーストパーティCookie。",
  description="最も広く設定されたファーストパーティCookieを示すグラフ。Google Analyticsは`_ga`と`_gcl_au` Cookieを設定しており、モバイルとデスクトップの両方のクライアントで、それぞれウェブサイトの約60%と25%で、ウェブサイトの統計、分析レポート、ターゲット広告に使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=219782191&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_first_party_cookies.sql"
  )
}}

上記のグラフは設定されている最も一般的なファーストパーティCookie名トップ10を報告しています。
Google Analyticsはウェブサイトの統計、分析レポート、ターゲット広告に使用される`_ga`と`_gcl_au` Cookieをウェブサイトの約60%と25%で設定しています。
このトップ10に存在する他のCookieはオンライントラッキング、ユーザーのセッションを識別するために使用されるセッションCookie、またはパフォーマンスに関連しています。

{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="トップサードパーティCookieとそれらを設定するドメイン。",
  description="最も広く設定されたサードパーティCookieを示すグラフ。DoubleClickはページの35%強にサードパーティ広告Cookieを設定しています。Microsoftもページの23%に広告Cookieを設定しています。サードパーティCookieを設定するトップドメインはトラッキングと広告に関連しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=232078905&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_third_party_cookies.sql"
  )
}}

同様に、この図は上位100万のウェブサイトで作成されている最も一般的なサードパーティCookieトップ10を示しています。

`IDE`と`test_cookie` Cookieは`doubleclick.net`（Googleが所有）によって設定され、それぞれウェブサイトの35%以上と25%以上に存在します。DoubleClickは`test_cookie`を設定しようとすることで、ユーザーのウェブブラウザがサードパーティCookieをサポートしているかどうかを確認します。

Microsoftの`MUID`が次に来て、ウェブサイトの23%以上に存在し、ターゲット広告とクロスサイトトラッキングにも使用されています。

[`Partitioned` Cookie](#partitionedchipsプロポーザル)セクションですでに指摘したように、今年はトップサードパーティCookieの中にYouTubeの`YSC`と`VISITOR_INFO1_LIVE`が見られなくなりました。これは2024年の分析以降、YouTubeの変更（おそらく[こちら](https://privacysandbox.google.com/blog/privacy-sandbox-next-steps)のようなPrivacy Sandboxプロポーザルに関するGoogleの発表と関連している）によるものと思われます。埋め込みページが読み込まれただけでビデオが再生されていない場合、これらのCookieがもはや設定されていないようです。さらに、[GoogleのPrivacy & Terms](https://policies.google.com/technologies/cookies?hl=en-US)も`VISITOR_INFO1_LIVE`が`__Secure-YNID` Cookieに置き換えられていることを文書化しています。

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Cookieを設定するトップ登録可能ドメイン。",
  description="ウェブでCookieを設定する最も一般的なドメインを示すグラフ。GoogleのDoubleClick広告プラットフォームは上位100万のウェブサイトの33%以上にCookieを設定しており、このトップ10の他のドメインはそれぞれ約5%から15%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=483296297&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_domains_setting_cookies.sql"
  )
}}

以前の結果から予想通り、ウェブでCookieを設定する最も一般的な10のドメインはすべて、検索、ターゲティング、広告サービスに関わっています。

Googleのカバレッジ（`doubleclick.net`、`google.com`、`youtube.com`）はウェブサイトの少なくとも33%に達しており、Microsoftの（`bing.com`、`clarity.ms`、`linkedin.com`）は少なくとも14%です。

## ウェブサイトによって設定されるCookieの数

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全て</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">7</td>
        <td class="numeric">7</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">13</td>
        <td class="numeric">16</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">22</td>
        <td class="numeric">40</td>
        <td class="numeric">44</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">45</td>
        <td class="numeric">399</td>
        <td class="numeric">395</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">178</td>
        <td class="numeric">885</td>
        <td class="numeric">915</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位100万デスクトップページで設定されたCookieの数に関する統計。", sheets_gid="1535389309", sql_file="nb_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全て</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">6</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">12</td>
        <td class="numeric">15</td>
        <td class="numeric">22</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">21</td>
        <td class="numeric">39</td>
        <td class="numeric">43</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">45</td>
        <td class="numeric">400</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">178</td>
        <td class="numeric">801</td>
        <td class="numeric">831</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位100万モバイルページで設定されたCookieの数に関する統計。", sheets_gid="1535389309", sql_file="nb_cookies_quantiles.sql") }}</figcaption>
</figure>

ウェブサイトは全体的にCookieの中央値として9個を設定しており、デスクトップではファーストパーティ7個とサードパーティ7個、モバイルではファーストパーティ6個とサードパーティ4個です。

表はウェブサイトごとに観察されたCookieの数に関するその他のいくつかの統計を報告しており、下のグラフはその累積分布関数（cdf）を示しています。例えば、デスクトップではウェブサイトごとに最大178個のファーストパーティと885個のサードパーティCookieが設定されます：

{{ figure_markup(
  image="number-cookies-cdf-desktop.png",
  caption="デスクトップページにおけるウェブサイトごとのCookieの数（cdf）。",
  description="デスクトップページで設定されたCookieの数の累積分布関数を示すグラフ。より多くのウェブサイトでファーストパーティCookieの数がサードパーティCookieよりも観察された最大値に近いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=160162622&format=interactive",
  sheets_gid="1535389309",
  sql_file="nb_cookies_cdf.sql"
  )
}}

{{ figure_markup(
  image="number-cookies-cdf-mobile.png",
  caption="モバイルページにおけるウェブサイトごとのCookieの数（cdf）。",
  description="モバイルページで設定されたCookieの数の累積分布関数を示すグラフ。より多くのウェブサイトでファーストパーティCookieの数がサードパーティCookieよりも観察された最大値に近いことがわかります。さらに、デスクトップとモバイルウェブサイトの両方でほぼ同様の結果が観察されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=569578852&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

## Cookieのサイズ

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全て</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">29</td>
        <td class="numeric">22</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">41</td>
        <td class="numeric">39</td>
        <td class="numeric">40</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">67</td>
        <td class="numeric">59</td>
        <td class="numeric">64</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">157</td>
        <td class="numeric">145</td>
        <td class="numeric">149</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">414</td>
        <td class="numeric">321</td>
        <td class="numeric">338</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4090</td>
        <td class="numeric">4096</td>
        <td class="numeric">4096</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位100万デスクトップページで設定されたCookieのサイズに関する統計。", sheets_gid="1499552173", sql_file="size_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全て</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">22</td>
        <td class="numeric">29</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">39</td>
        <td class="numeric">41</td>
        <td class="numeric">40</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">62</td>
        <td class="numeric">67</td>
        <td class="numeric">65</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">145</td>
        <td class="numeric">162</td>
        <td class="numeric">150</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">326</td>
        <td class="numeric">414</td>
        <td class="numeric">388</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4096</td>
        <td class="numeric">4081</td>
        <td class="numeric">4096</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位100万モバイルページで設定されたCookieのサイズに関する統計。", sheets_gid="1499552173", sql_file="size_cookies_quantiles.sql") }}</figcaption>
</figure>

観察されたすべてのCookieにわたるCookieのサイズの中央値は40バイトで、最大4KBであり、これは<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc6265#section-6.1">RFC 6265</a>で定義された制限と一致しています。

[昨年](../2024/cookies#cookieのサイズ)と同様に、1バイトのサイズのCookieが観察されます。これらはおそらく空の`Set-Cookie`ヘッダーによってエラーで設定されたものです。

各クライアントの上位100万サイトで見られたすべてのCookieのサイズの累積分布関数（cdf）をグラフ化できます：

{{ figure_markup(
  image="size-cookies-cdf-desktop-mobile.png",
  caption="デスクトップとモバイルページにおけるウェブサイトごとのCookieのサイズ（cdf）。",
  description="デスクトップとモバイルページで設定されたCookieの数の累積分布関数を示すグラフ。デスクトップとモバイルの両クライアントでCookieのサイズの分布が非常に似ていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1496593333&format=interactive",
  sheets_gid="1499552173",
  sql_file = 'size_cookies_cdf.sql'
  )
}}

## 永続性（有効期限）

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全て</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">21</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">365</td>
        <td class="numeric">360</td>
        <td class="numeric">364</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">395</td>
        <td class="numeric">365</td>
        <td class="numeric">390</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位100万デスクトップページで設定されたCookieの有効期間に関する統計。", sheets_gid="718820729", sql_file="age_expire_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全て</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">365</td>
        <td class="numeric">270</td>
        <td class="numeric">360</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">395</td>
        <td class="numeric">365</td>
        <td class="numeric">390</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位100万モバイルページで設定されたCookieの有効期間に関する統計。", sheets_gid="718820729", sql_file="age_expire_cookies_quantiles.sql") }}</figcaption>
</figure>

Cookieは作成時に有効期限が設定されます。セッションCookieがセッション終了直後に期限切れになる（[前のセクション](#セッション)を参照）のに対し、ほとんどのファーストパーティとサードパーティCookieはそうではなく、中央値の有効期間が丸1年となっています。

Cookieの存続期間が長いほど、再識別やクロスサイトトラッキングに使用できる期間が長くなります。これが、ほとんどのトラッキングCookieが通常ブラウザに長期間保存されるよう設定される理由です。

本チャプターのHTTP Archiveツールの計測・収集で観察できるCookieの最大有効期間は400日です。これはChromeがCookieの`Expires`と`Max-Age`属性に課す[ハードリミット](https://developer.chrome.com/blog/cookie-max-age-expires)によるものです。

## 結論

本チャプターの観察は[昨年の分析の結論](../2024/cookies#まとめ)を確認するものです：

- ウェブで遭遇するCookieの大半（60%）はサードパーティCookieであり、人気サイトはそれほど人気でないサイトよりもサードパーティCookieが大幅に多くなっています。
- 最も人気のあるCookieは広告、トラッキング、アナリティクスのユースケースと関連付けられています。
- Cookieは中央値の平均寿命が12ヶ月と長寿命になる傾向があります。
  一時的なセッションCookieはファーストパーティの19%、サードパーティの7%のみを占めます。
- Cookieの機能に対するその他の制限はほとんど使用されないか、まったく使用されません。サードパーティCookieの10%がパーティション化されている（昨年の6%からわずかに増加）一方、サードパーティCookieの100%がクロスサイトリクエストで送信できる`SameSite=None`を持っています。さらに、Cookieプレフィックスの採用はほぼ存在しません。

最後に、プライバシーの懸念から複数のウェブブラウザが[サードパーティCookieを廃止または制限](https://developer.mozilla.org/docs/Web/Privacy/Guides/Third-party_cookies#how_do_browsers_handle_third-party_cookies)している一方、Googleは<a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">Chromeでのサードパーティのサポートを継続する</a>ことを決定しました。Googleはまた、当初 _「ユーザーを尊重し、デフォルトでプライバシーを保護するウェブエコシステムの繁栄を生み出す」_ ために設計されたPrivacy Sandboxイニシアチブのほとんどの技術を段階的に廃止しています。その結果、トラッカーがサードパーティCookieを使用するか、オンラインでユーザーを追跡するために他の技術（ファーストパーティ同期、フィンガープリンティングなど）を開発するかにかかわらず、Cookieはウェブにとってプライバシーとセキュリティリスクをもたらし続ける基本的なコンポーネントであり続けます。
