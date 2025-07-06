---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookie
description: 2024年版Web AlmanacのCookieの章では、ウェブ上でのCookieの普及と構造について解説します。
hero_alt: Web Almanacのキャラクターが大きなクッキーを運んでいるヒーロー画像。別のキャラクターがパンくずを投げ、探偵帽と虫眼鏡を持った別のWeb Almanacキャラクターがクッキーの跡を追っています。
authors: [yohhaan,samdutton,ydimova]
reviewers: [samdutton,rowan-m]
analysts: [yohhaan]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1wDGnUkO0rgcU5_V6hmUrhm1pq60VU2XbeMHgYJEEaSM/
yohhaan_bio: Yohan Beuginは、ウィスコンシン大学マディソン校のコンピューターサイエンス学部の博士課程の学生で、セキュリティとプライバシーの研究グループのメンバーであり、Patrick McDaniel教授の指導を受けています。彼は、より安全で、プライバシーを保護し、信頼できるシステムの構築に関心があります。彼の現在の研究は、これまでのところ、オンライン広告における追跡とプライバシーに焦点を当てています。
samdutton_bio: Sam Duttonは、GoogleのPrivacy Sandboxチームのデベロッパーアドボケイトで、サイトがサードパーティのCookieへの依存から移行するのを支援することに重点を置いています。Samは南オーストラリアで育ち、シドニーの大学に通い、1986年からロンドンに住んでいます。彼は以前、BBC R&DとITNでソフトウェアエンジニアとして、Decca Recordsで植字工として、Picador Booksで研究者として働いていました。
ydimova_bio: Yana Dimovaは、ルーヴェン・カトリック大学のDistriNetの博士課程の学生で、プライバシーに対するユーザーの視点と、ウェブ上でそれをどのように保護できるかに焦点を当てています。彼女の研究対象は、オンライン追跡、個人データの漏洩、プライバシーとデータ保護法です。
featured_quote: 私たちの結果は、ファーストパーティとサードパーティの両方の追跡が一般的であることを示しています。Cookieによるオンライン追跡が、依然としてウェブ上で主流であることを示しています。
featured_stat_1: 61%
featured_stat_label_1: サードパーティであるCookie
featured_stat_2: 11%
featured_stat_label_2: `SameSite=None`を持つファーストパーティのデスクトップCookie
featured_stat_3: 6%
featured_stat_label_3: パーティション化されたサードパーティCookie（CHIPS）
doi: 10.5281/zenodo.14065903
---

## 導入

Web Almanac 2024の次の章は、Cookieに焦点を当てています。Cookieには複数の機能があり、ウェブにとってある程度不可欠です。たとえば、認証、不正防止、セキュリティなどです。しかし、一部のCookieはウェブサイトを横断してユーザーを追跡し、行動プロファイルの構築に利用されることがあります。

この章では、2024年6月のHTTP Archiveクロール中に、主に上位100万のウェブサイトを訪問した際に見られたウェブCookieの普及率と構造を測定します。

さらに、クロスサイト追跡を減らすために<a hreflang="en" href="https://privacysandbox.com/">Privacy Sandbox</a>イニシアチブの一環としてGoogleがChromeに導入した、サードパーティCookieの代替メカニズムの採用について議論し、測定します。

{# TODO findingsをイントロから削除 #}
Cookieの61%がサードパーティのコンテキストで設定されていることがわかりました。一般的に、サードパーティのCookieはオンライン追跡やターゲット広告に使用できます。このため、GoogleはすべてのサードパーティCookieを段階的に廃止し、Privacy Sandboxでその機能を置き換える、よりプライバシーに配慮したオプションを導入することを提案しました。

{# TODO findingsをイントロから削除 #}
一方、すべてのサードパーティCookieがオンライン追跡に使用されるわけではありません。Chromeなどのブラウザには、サードパーティCookieの使用方法を制限する方法がいくつか含まれています。たとえば、パーティション化されたCookie（CHIPS）は、Cookieが最初に設定されたトップレベルサイトとは異なるトップレベルサイトからアクセスできないため、ウェブサイトを横断してユーザーを追跡することは不可能です。それにもかかわらず、もっとも普及しているパーティション化されたCookieは、広告関連のドメインによって設定されていることがわかりました。もう1つの例は`SameSite` Cookie属性で、これにより（ファーストパーティ）Cookieがデフォルトでクロスサイトリクエストに含まれないことが保証されます。トラッカーは、`SameSite`属性の値を明示的に`None`に設定することで、この設定を無効にできます。したがって、実際には、観測されたファーストパーティCookieの11%で`SameSite`が`None`に設定されていることがわかりました。さらに、もっとも広く設定されているサードパーティCookieは広告と分析に使用されており、Googleがもっとも多くのウェブサイトで普及していることがわかります。

{# TODO findingsをイントロから削除 #}
ファーストパーティのCookieも、繰り返し訪れるユーザーを追跡するために使用できます。私たちの分析から、もっとも普及しているファーストパーティのCookieは分析に使用されていると結論付けています。理論的には、同一オリジンポリシーのため、これらのCookieはクロスサイト追跡には使用できません。しかし、Cookie同期やCNAME追跡などの高度な追跡方法を使用することで、トラッカーはこの制限を回避できます。オンライン追跡方法の詳細については、[プライバシー](./privacy)の章を参照してください。

{# TODO findingsをイントロから削除 #}
私たちの結果は、ファーストパーティとサードパーティの両方の追跡が一般的であることを示しています。Cookieによるオンライン追跡が、依然としてウェブ上で主流であることを示しています。

## 定義

まず、この章で使用されるいくつかの用語について共通の理解を得ましょう。

### HTTP Cookie

ユーザーがウェブサイトにアクセスすると、ユーザーのウェブブラウザに[HTTP Cookie](https://developer.mozilla.org/docs/Web/HTTP/Cookies)を設定して保存するように要求できるウェブサーバーと対話します。このCookieは、ユーザーのデバイスにテキスト文字列で保存されたデータに対応し、後続のHTTPリクエストとともにウェブサーバーに送信されます。Cookieは、複数のHTTPリクエストにわたってユーザーに関するステートフルな情報を永続化するために使用され、認証、セッション管理、追跡を可能にします。Cookieには、プライバシーとセキュリティのリスクも伴います。

### ファーストパーティCookieとサードパーティCookie

Cookieはウェブサーバーによって設定され、**ファーストパーティ**と**サードパーティ**の2種類のCookieがあります。ファーストパーティCookieは、ユーザーが訪問しているサイトと同じドメインによって設定されますが、サードパーティCookieは異なるドメインから設定されます。

サードパーティCookieは、サードパーティからのものである場合もあれば、トップレベルサイトと同じ「ファーストパーティ」に属する別のサイトまたはサービスからのものである場合もあります。**サードパーティCookie**は、実際には**クロスサイトCookie**です。

たとえば、ドメイン`example.com`の所有者が`example.net`も所有しており、ユーザーが`https://www.example.com`にアクセスしたときに次のCookieが設定されるとします。

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookie名</th>
        <th>設定者</th>
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
        <td>訪問したウェブサイトと同じドメイン：サブドメインは関係ありません</td>
      </tr>
      <tr>
        <td>`cookie_c`</td>
        <td>`www.example.edu`</td>
        <td>サードパーティ</td>
        <td>訪問したウェブサイトとは異なるドメイン</td>
      </tr>
      <tr>
        <td>`cookie_d`</td>
        <td>`tracking.example.org`</td>
        <td>サードパーティ</td>
        <td>訪問したウェブサイトとは異なるドメイン</td>
      </tr>
      <tr>
        <td>`cookie_e`</td>
        <td>`login.example.net`</td>
        <td>サードパーティ</td>
        <td>この例では同じ所有者が所有していても、訪問したウェブサイトとは異なるドメイン（トップレベルサイトの同じ「ファーストパーティ」からのクロスサイトCookie）</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Cookieのコンテキスト。") }}</figcaption>
</figure>

### プライバシーとセキュリティのリスク

**ウェブ追跡** Cookieは、サードパーティがウェブサイトを横断してユーザーを追跡し、閲覧行動や興味を記録するために使用されます。ターゲット広告では、このデータを利用して、ユーザーの興味に合った広告を表示します。この追跡は通常、次のように行われます。サイトに埋め込まれたサードパーティのコードが、ユーザーを識別するCookieを設定できます。その後、同じサードパーティは、ユーザーが埋め込まれている他のウェブサイトにアクセスしたときにそのCookieを取得することで、ユーザーのアクティビティを記録できます（[プライバシー](./privacy)の章も参照）。ファーストパーティのCookieもオンライン追跡に使用できることに注意してください。Cookie同期などの方法により、サードパーティCookieの制限を回避し、<a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3442381.3449837">異なるウェブサイト間で</a>ユーザーを追跡できます。

**Cookieの盗難とセッションハイジャック** Cookieは、複数のHTTPリクエストにわたる認証目的で、資格情報（セッショントークン）などのセッション情報を保存するために使用されます。しかし、これらのCookieが悪意のある攻撃者によって取得された場合、それらを使用して対応するウェブサーバーに認証できます。Cookieがウェブサーバーによって適切に設定されていない場合、[セッションハイジャック](https://developer.mozilla.org/docs/Glossary/Session_Hijacking)、クロスサイトリクエストフォージェリ（[CSRF](https://developer.mozilla.org/docs/Web/Security/Practical_implementation_guides/CSRF_prevention)）、クロスサイトスクリプトインクルージョン（[XSS](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting)）などのクロスサイトの脆弱性の影響を受けやすくなる可能性があります（[セキュリティ](./security)の章も参照）。

### 注意事項

2024年のWeb AlmanacにHTTP Archiveが適用した方法論の詳細については、[方法論](./methodology)のページで詳しく知ることができます。この方法論には、この章の結果に影響を与える可能性のある制限があります。

- データは、非対話的な方法でウェブサイトを自動的に訪問することによって収集されます。ユーザーの操作は、実際にウェブサイトがCookieを設定および使用する方法を変更する可能性があります。たとえば、HTTP ArchiveのツールはCookieバナー（もしあれば）と対話しないため、これらのバナーとの対話後に設定されるCookieは、私たちの調査では観測されません。
- ウェブサイトは、各独立したウェブサイトへの訪問が開始されるときにCookieが設定されていない米国内のサーバーから訪問されます。これは、ユーザーがウェブを閲覧しながらウェブCookieを蓄積および保存するのとはかなり異なります。訪問が実行される場所は、<a hreflang="en" href="https://gdpr-info.eu/">GDPR</a>などの規制や法律により、Cookieの動作に影響を与える可能性があります。
- 各ウェブサイトについて、ホームページと、同じウェブサイトの別の1ページが訪問されます。
- この章で提示されている結果のほとんどは、2024年6月のHTTP Archiveクロール中に正常に到達した[Chrome User Experience Report (CrUX)](https://developer.chrome.com/docs/crux)によると、もっとも訪問された上位100万のウェブサイトに基づいています。
- この章の分析のために収集されたCookieは、各ウェブサイトページの訪問の最後に、ウェブブラウザがCookieジャーに保存しているすべてのCookieを抽出することによって取得されました。その結果、収集されたデータには、ウェブブラウザによって有効と見なされ、正常に設定されたCookieのみが含まれます。したがって、ウェブサイトが無効なCookie（大きすぎる、属性の不一致など）を設定しようとした場合、それらは私たちの分析から欠落します。

### 注記

この章にプロットされている図は、そのサブタイトルに（a）プロットされたデータのためにウェブサイトにアクセスするために使用されたクライアントデバイスの種類（**デスクトップ**または**モバイル**）と（b）訪問された上位のウェブサイトの数（[CrUXランク](https://developer.chrome.com/blog/crux-rank-magnitude)による）を示しています。情報が指定されていない場合は、グラフの軸のいずれかにある必要があります。

## Cookieの普及と構造

このセクションでは、ウェブ上でのCookieの普及率、その種類、属性について報告します。

### ファーストパーティとサードパーティの普及率

ファーストパーティCookieは、ユーザーが訪問しているウェブサイトと同じドメインによって設定されますが、サードパーティCookieは異なるドメインによって設定されます[定義](#定義)を参照。この分析では、クライアント（デスクトップまたはモバイル）およびCrUXランク全体で、ウェブサイトに設定されたCookieのうち、ファーストパーティおよびサードパーティである割合を調べます。

{{ figure_markup(
  image="first-and-third-party-prevalence.png",
  caption="ファーストパーティとサードパーティの普及率。",
  description="デスクトップおよびモバイルクライアントにおけるファーストパーティおよびサードパーティCookieの普及率を示す棒グラフ。両方のクライアントで同じ分布が見られます。Cookieの39%がファーストパーティで、設定されたCookieの61%がサードパーティです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=627993125&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

もっとも訪問された上位100万のウェブサイトでは、Cookieの約39%がファーストパーティで、61%がサードパーティCookieです。したがって、ウェブ上で設定されるCookieの大部分はサードパーティCookieです。また、これらのウェブサイトがデスクトップまたはモバイルクライアントを介してアクセスされるかどうかにかかわらず、この分布は非常に似ていることもわかります。これは、全体として、使用されるクライアントの種類に基づいて動作の変更がほとんどまたはまったくないことを示しています。ただし、一部のウェブサイトは、クライアントの種類に応じて動作が異なったり、フィンガープリントなどの他の追跡方法を使用したりする場合があります（詳細については、[プライバシー](./privacy)の章を参照）。

{{ figure_markup(
  image="first-and-third-party-prevalence-by-rank-desktop.png",
  caption="デスクトップクライアントにおけるランク別のCookieのファーストパーティおよびサードパーティの普及率。",
  description="ウェブサイトの人気度に応じたデスクトップクライアントにおけるファーストパーティおよびサードパーティCookieの普及率を示す棒グラフ（ウェブサイトの人気度を判断するためにChrome User Experienceレポートを使用しました）。人気のあるウェブサイトほど、サードパーティCookieを大幅に多く設定していることがわかります。デスクトップクライアントで上位1,000の人気ウェブサイトでは、設定されたCookieの77%がサードパーティですが、上位100万のウェブサイトでは、Cookieの61%がサードパーティです。この違いの1つの説明は、人気のあるウェブサイトほど、Cookieを設定するサードパーティコンテンツを多く含む傾向があることです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1327011561&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

{{ figure_markup(
  image="first-and-third-party-prevalence.png-by-rank-mobile.png",
  caption="モバイルクライアントにおけるランク別のCookieのファーストパーティおよびサードパーティの普及率。",
  description="ウェブサイトの人気度に応じたモバイルクライアントにおけるファーストパーティおよびサードパーティCookieの普及率を示す棒グラフ（ウェブサイトの人気度を判断するためにChrome User Experienceレポートを使用しました）。人気のあるウェブサイトほど、サードパーティCookieを大幅に多く設定していることがわかります。デスクトップクライアントで上位1,000の人気ウェブサイトでは、設定されたCookieの77%がサードパーティですが、上位100万のウェブサイトでは、Cookieの61%がサードパーティです。この違いの1つの説明は、人気のあるウェブサイトほど、Cookieを設定するサードパーティコンテンツを多く含む傾向があることです。モバイルとデスクトップの両方のクライアントで同じ結果が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1792338085&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

ウェブサイトのランキング全体でCookieの種類の普及率を見ると、人気のあるウェブサイトほど、訪問頻度の低いウェブサイトよりもサードパーティCookieの割合が高いことがわかります。たとえば、上位100万のウェブサイトで報告された結果と比較して、上位1,000のウェブサイトでは、Cookieの23%と77%がそれぞれファーストパーティとサードパーティです。これは、ユーザーがもっとも訪問するウェブサイトほど、訪問頻度の低いウェブサイトよりも多くのサードパーティコード（それがより多くのサードパーティCookieを設定する）を埋め込んでいるという事実によるものと考えられます。
さらに、ランク全体での各Cookieの種類の普及率は、デスクトップクライアントとモバイルクライアントの間でかなり似ています。上位100万のウェブサイトで以前に述べた注意点は、CrUXランク全体でも当てはまることがわかります。

### Cookieの属性

次に、さまざまなCookie[属性](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie)の分布について説明します。さらに、`SameSite` Cookie属性の使用に焦点を当てます。次の2つの図は、次の属性のいずれかが設定されている各クライアントの上位100万のウェブサイトに設定されたファーストパーティおよびサードパーティCookieの割合を示しています：`Partitioned`、`Session`、`HttpOnly`、`Secure`、`SameSite`。各属性の詳細に入る前に、デスクトップまたはモバイルクライアント間のさまざまな属性の分布の類似性をここで再び観察しましょう。

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  caption="デスクトップクライアントのCookie属性の概要。",
  description="この図は、デスクトップクライアントのファーストパーティおよびサードパーティCookieの両方でCookie属性がどのように使用されるかの概要を示しています。サードパーティCookieの100%に`SameSite`および`Secure`属性が含まれています。ファーストパーティCookieの1%とサードパーティCookieの6%のみが`Partioned`を使用しています。ファーストパーティCookieの16%が`Session`属性を設定していますが、サードパーティCookieではわずか4%です。最後に、ファーストパーティCookieの12%とサードパーティCookieの19%が`HttpOnly`属性を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=69067153&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="モバイルクライアントのCookie属性の概要。",
  description="この図は、モバイルクライアントのファーストパーティおよびサードパーティCookieの両方でCookie属性がどのように使用されるかの概要を示しています。デスクトップクライアントとまったく同じ結果が観測されます。サードパーティCookieの100%に`SameSite`および`Secure`属性が含まれています。ファーストパーティCookieの1%とサードパーティCookieの6%のみが`Partioned`を使用しています。ファーストパーティCookieの16%が`Session`属性を設定していますが、サードパーティCookieではわずか4%です。最後に、ファーストパーティCookieの12%とサードパーティCookieの19%が`HttpOnly`属性を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2109248653&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

#### `Partitioned`

パーティション化されたCookieは、パーティション化されたストレージを使用して[互換性のあるブラウザ](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility)によって保存されます。`Partitioned`属性が設定されたCookieは、同じサードパーティから、かつ最初に作成されたのと同じトップレベルサイトからのみアクセスできます。言い換えれば、パーティション化されたCookieは、ウェブサイトを横断するサードパーティの追跡には使用できず、トップレベルサイトでのサードパーティCookieの正当な使用を可能にします。詳細については、[独立したパーティション化された状態を持つCookie（CHIPS）](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies)を参照してください。

上位100万のウェブサイトを訪問中にデスクトップまたはモバイルで設定されたサードパーティCookieの約6%がパーティション化されていることがわかります。次の図は、上位100万のウェブサイトのサードパーティコンテキストで設定されているもっとも一般的なパーティション化されたCookie（名前とドメイン）を示しています。各クライアント（デスクトップとモバイル）について、表示されているウェブサイトの割合で上位10個のパーティション化されたCookieのみが報告されています。
上位2つのもっとも広く使用されているパーティション化されたCookieは、デスクトップで9.9%、モバイルで8.89%のウェブサイトで`youtube.com`によって設定されています。`YSC` Cookieは、不正行為や乱用を防ぐなどのセキュリティ目的で使用され、ユーザーセッションの終了時に期限切れになりますが、`VISITOR_INFO1_LIV`の主な目的は分析です（<a hreflang="en" href="https://policies.google.com/technologies/cookies/embedded?hl=en-US">Googleのドキュメント</a>を参照）。
グラフにリストされているCookieのほとんどは、`adnxs.com`、`criteo.com`、`doubleclick.net`などの広告ドメインによって設定されています。

{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="サードパーティコンテキストにおける上位のパーティション化されたCookie（CHIPS）。",
  description="パーティション化されたCookieを設定している上位のサードパーティドメインを示すグラフ。上位2つのパーティション化されたCookieはGoogleが所有しています。`YSC`と`VISITOR_INFO1_LIVE`は、デスクトップウェブサイトの9.9%とモバイルウェブサイトの8.9%で`youtube.com`によって設定されています。CHIPSを使用している上位ドメインのほとんどは、広告または分析カテゴリに属しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1075137054&format=interactive",
  sheets_gid="1597405066",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}

おそらく少し驚くべきことですが、上位100万のウェブサイト（デスクトップおよびモバイルクライアント）で設定されているすべてのファーストパーティCookieの1%がパーティション化されています。しかし、ファーストパーティコンテキストでCookieをパーティション化することは、ファーストパーティCookieが定義上、そのトップレベルサイトのそのファーストパーティによってのみアクセス可能であるため、少し冗長に見えます。次の図は、各クライアントのファーストパーティコンテキストで設定された上位10個のパーティション化されたCookieを示しています。`receive-cookie-deprecation`は、ChromeのPrivacy Sandboxの[テストフェーズに参加している](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing)ドメインによって設定されます。`cf_clearance`と`csrf_token`は、ユーザーがボット対策チャレンジを正常に完了したこと、または信頼できるウェブトラフィックを識別することを示すためにCloudflareによって設定されるCookieです。

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="ファーストパーティコンテキストにおける上位のパーティション化されたCookie（CHIPS）。",
  description="上位のファーストパーティのパーティション化されたCookieを示すグラフ。上位のCookie `receive-cookie-deprecation`は、Privacy Sandboxのテストフェーズの一部です。2番目に広く設定されているファーストパーティのパーティション化されたCookieは、デスクトップサイトの4.21%とモバイルページの4.13%でCloudflareによって設定されており、ユーザーがボット検出を正常に完了したことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1330654598&format=interactive",
  sheets_gid="1597405066",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}

#### セッション

セッションCookieは、単一のユーザーセッションに対してのみ有効なCookieです。言い換えれば、セッションCookieは一時的なものであり、ユーザーが設定された対応するウェブサイトを終了するか、ウェブブラウザを閉じるかのいずれか早い方で期限切れになります。ただし、一部のウェブブラウザでは、起動時に以前のセッションを復元できるため、その場合、その以前のセッションで設定されたセッションCookieも復元されることに注意してください。

2024年6月の上位100万のウェブサイトに関する私たちの分析結果によると、ファーストパーティCookieの16%とサードパーティCookieのわずか4%がセッションCookieです（デスクトップとモバイルの両方のクライアントで）。

#### `HttpOnly`

[`HttpOnly`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#httponly)属性は、CookieがJavaScriptコードからアクセスされるのを防ぎ、[クロスサイトスクリプティング（XSS）](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting)攻撃に対するある程度の緩和策を提供します。`HttpOnly`属性を設定しても、JavaScriptから開始された`XMLHttpRequest`または`fetch`リクエストとともにCookieが送信されるのを防ぐことはできません。

ファーストパーティCookieのわずか12%に`HttpOnly`属性が設定されていますが、サードパーティCookieではデスクトップで19%、モバイルで18%に設定されています。

#### `Secure`

[`Secure`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#secure)属性を持つCookieは、HTTPsを介して行われたリクエストにのみ送信されます。これにより、[中間者攻撃](https://developer.mozilla.org/docs/Glossary/MitM)を防ぎます。

ファーストパーティCookieの場合、デスクトップで23%、モバイルで22%に`Secure`属性があり、観測されたすべてのサードパーティCookieに`Secure`属性があります。実際、これらのサードパーティCookieには、`Secure`の設定を必要とする`SameSite=None`属性もあります（次のセクションを参照）。

#### `SameSite`

[`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) Cookie属性により、サイトはCookieがクロスサイトリクエストに含まれるタイミングを指定できます。
- `SameSite=Strict`: Cookieは、Cookieのオリジンと同じサイトからのリクエストに応答してのみ送信されます。
- `SameSite=Lax`: `SameSite=Strict`と同じですが、ブラウザはCookieのオリジンサイトへのナビゲーションでもCookieを送信します。これは`SameSite`のデフォルト値です。
- `SameSite=None`: Cookieは、同一サイトまたはクロスサイトのリクエストで送信されます。
これは、Cookieによるサードパーティの追跡を可能にするには、追跡Cookieの`SameSite`属性を`None`に設定する必要があることを意味します。

`SameSite`属性の詳細については、次のリファレンスを参照してください。
- [`SameSite` Cookieの説明](https://web.dev/articles/samesite-cookies-explained)
- [「同一サイト」と「同一オリジン」](https://web.dev/articles/same-site-same-origin)
- [URLの構成要素とは？](https://web.dev/articles/url-parts)

{{ figure_markup(
  image="same-site-desktop.png",
  caption="デスクトップクライアントのCookieの`SameSite`属性。",
  description="デスクトップクライアントのファーストパーティおよびサードパーティCookieの両方に対する`SameSite`属性とその値の普及率を示しています。ファーストパーティCookieの2.16%が`SameSite`属性を`Strict`に設定し、20.17%が`SameSite=Lax`（デフォルト）を使用し、10.78%が値を`None`に設定し、66.89%が`SameSite`の値を指定していません。サードパーティCookieのほぼ100%が`SameSite`属性を`None`に設定しており、これらのCookieがクロスサイトコンテキストで送信されるようにしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=797398172&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}
{{ figure_markup(
  image="same-site-mobile.png",
  caption="モバイルクライアントのCookieの`SameSite`属性。",
  description="モバイルクライアントのファーストパーティおよびサードパーティCookieの両方に対する`SameSite`属性とその値の普及率を示しています。デスクトップクライアントと非常によく似た結果が見られます。ファーストパーティCookieの2.21%が`SameSite`属性を`Strict`に設定し、20%が`SameSite=Lax`（デフォルト）を使用し、10.63%が値をNoneに設定し、67.16%が`SameSite`の値を指定していません。サードパーティCookieのほぼ100%が`SameSite`属性を`None`に設定しており、これらのCookieがクロスサイトコンテキストで送信されるようにしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2030447900&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

各クライアントで、上位100万のウェブサイトで見られるファーストパーティCookieの約33%と、ほぼ100%のサードパーティCookieに、作成時に明示的に設定された`SameSite`属性があることがわかります（注意：`SameSite`は指定されていない場合、`Lax`がデフォルトです）。上記の2つの棒グラフは、クライアント全体でのファーストパーティおよびサードパーティCookieのこの`SameSite`属性の分布を表しています。クライアント間での結果の違いは、ここでもいくぶん無視できる程度であることがわかります。ほぼ100%のサードパーティCookieが`SameSite=None`であり、したがってクロスサイトリクエストで送信されます。
ファーストパーティCookieの場合、約87%が`SameSite=Lax`です（20%が明示的に属性を設定し、残りの67%は`SameSite`が設定されていない場合のデフォルトの動作に関係します）。11%のCookieは、`SameSite`属性が明示的に`None`の値に設定されています。Cookieが設定される正確な目的を判断するのは難しいですが、これらのCookieの一部がファーストパーティコンテキストでユーザーを追跡するために使用されている可能性があります。`SameSite`が`Strict`に設定されているCookieはわずか2%です。

### Cookieのプレフィックス

2つの[Cookieプレフィックス](https://developer.mozilla.org/docs/Web/HTTP/Cookies#cookie_prefixes) `__Host-`と`__Secure-`は、Cookie名で使用して、安全なHTTPSオリジンによってのみ設定または変更できることを示すことができます。これは、[セッション固定](https://developer.mozilla.org/docs/Web/Security/Types_of_attacks#session_fixation)攻撃から防御するためです。両方のプレフィックスを持つCookieは、安全なHTTPsオリジンによって設定され、`Secure`属性が設定されている必要があります。さらに、`__Host-` Cookieには`Domain`属性を含めてはならず、`Path`が`/`に設定されている必要があります。したがって、`__Host-` Cookieは、設定された正確なホストにのみ送り返され、親ドメインには送り返されません。

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="デスクトップページで観測されたCookieプレフィックス。",
  description="デスクトップページで使用されている観測されたCookieプレフィックスを示しています。ファーストパーティCookieの0.032%とサードパーティCookieのわずか0.001%に`__Host-`が含まれていることがわかります。同様に、ファーストパーティCookieの0.03%とサードパーティCookieの0.001%に`__Secure-`が含まれています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1005258943&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="モバイルページで観測されたCookieプレフィックス。",
  description="モバイルページで使用されている観測されたCookieプレフィックスを示しています。デスクトップページで使用されているCookieプレフィックスと非常によく似た結果が観測されます。ファーストパーティCookieの0.031%とサードパーティCookieのわずか0.001%に`__Host-`が含まれていることがわかります。同様に、ファーストパーティCookieの0.03%とサードパーティCookieの0.001%に`__Secure-`が含まれています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=747475408&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

デスクトップで観測されたファーストパーティCookieの0.032%と0.030%に、それぞれ`__Host-`と`__Secure-`プレフィックスが設定されていることを測定しました。これらの数値は、サードパーティCookieでは0.001%です。これらの結果は、2015年末に最初に<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis#section-4.1.3.1">導入</a>されて以来、これらのプレフィックスと関連する多層防御策の採用が非常に低いことを示しています。

## 上位のファーストパーティおよびサードパーティのCookieとそれらを設定するドメイン

次のセクションでは、各クライアント（デスクトップおよびモバイル）について、上位10個のファーストパーティCookie、サードパーティCookie、およびそれらを設定するドメインを報告します。<a hreflang="en" href="https://cookiepedia.co.uk/">Cookiepedia</a>の結果を使用して、それらのいくつかについてコメントし、興味のある読者には詳細についてこのリソースを参照することをお勧めします。

{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="設定された上位のファーストパーティCookie。",
  description="このグラフは、もっとも広く設定されているファーストパーティCookieを示しています。Google Analyticsは、ウェブサイトの統計と分析レポートに使用される`_ga`および`_gid` Cookieを、モバイルとデスクトップの両方のクライアントで61%以上のウェブサイトに設定しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1305664900&format=interactive",
  sheets_gid="1236728722",
  sql_file="top_20_first_party_cookies.sql"
  )
}}

最初の2つのファーストパーティCookie `_ga`と`_gid`は、<a hreflang="en" href="https://business.safety.google/adscookies/">Google Analytics</a>によって設定され、サイト分析レポートのクライアント識別子と統計を保存するために使用されます。ウェブサイトの大多数がGoogle Analyticsを使用しています（それぞれ60%以上と35%以上）。3番目の`_fbp`はFacebookによって設定され、25%のウェブサイトでターゲット広告に使用されます。

{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="上位のサードパーティCookieとそれらを設定するドメイン。",
  description="このグラフは、もっとも広く設定されているサードパーティCookieを示しています。DoubleClickは、28.9%のウェブサイトと26.7%のモバイルウェブサイトにサードパーティの広告Cookieを設定しています。Microsoftも、デスクトップページの12.4%とモバイルページの11.3%に広告Cookieを設定しています。サードパーティCookieを設定している上位ドメインのほとんどは、追跡と広告に関連しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=219338324&format=interactive",
  sheets_gid="1236728722",
  sql_file="top_20_third_party_cookies.sql"
  )
}}

`IDE`および`test_cookie` Cookieは`doubleclick.net`（Google所有）によって設定され、上位100万のウェブサイトで観測されたもっとも一般的なサードパーティCookieです。これらはターゲット広告に使用されます。DoubleClickは、`test_cookie`を設定しようとすることで、ユーザーのウェブブラウザがサードパーティCookieをサポートしているかどうかを確認します。次にMicrosoftの`MUID`が続き、これもクロスサイト追跡のためにユーザーの一意の識別子を保存するためにターゲット広告で使用されます。

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Cookieを設定している上位の登録可能ドメイン。",
  description="このグラフは、ウェブ上でCookieを設定しているもっとも一般的なドメインを示しています。Googleが所有する広告プラットフォームDoubleClickは、上位100万のウェブサイトの44%以上にCookieを設定していますが、その他は約8%から12%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=418361658&format=interactive",
  sheets_gid="1236728722",
  sql_file="top_20_domains_setting_cookies.sql"
  )
}}

ウェブ上でCookieを設定しているもっとも一般的な10のドメインのうち、検索、ターゲティング、広告サービスに関与しているドメインしか見つかりません。この結果は、一部のサードパーティがウェブをカバーしている範囲を概説しています。たとえば、Googleが所有する広告プラットフォームDoubleClickは、上位100万のウェブサイトの44%以上にCookieを設定していますが、その他は約8%から12%です。

## ウェブサイトによって設定されるCookieの数

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookieの数（デスクトップ上位100万）</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>すべて</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>最小値</td>
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
        <td>中央値</td>
        <td class="numeric">7</td>
        <td class="numeric">5</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">13</td>
        <td class="numeric">17</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">22</td>
        <td class="numeric">66</td>
        <td class="numeric">51</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">46</td>
        <td class="numeric">331</td>
        <td class="numeric">323</td>
      </tr>
      <tr>
        <td>最大値</td>
        <td class="numeric">160</td>
        <td class="numeric">632</td>
        <td class="numeric">662</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デスクトップページに設定されたCookieの数の統計。") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookieの数（モバイル上位100万）</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>すべて</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>最小値</td>
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
        <td>中央値</td>
        <td class="numeric">7</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">12</td>
        <td class="numeric">18</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">21</td>
        <td class="numeric">64</td>
        <td class="numeric">52</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">45</td>
        <td class="numeric">327</td>
        <td class="numeric">316</td>
      </tr>
      <tr>
        <td>最大値</td>
        <td class="numeric">168</td>
        <td class="numeric">604</td>
        <td class="numeric">645</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルページに設定されたCookieの数の統計。") }}</figcaption>
</figure>

ウェブサイトは、全体で中央値9または10個の任意の種類のCookie、7個のファーストパーティCookie、およびモバイルおよびデスクトップクライアントでそれぞれ4または5個のサードパーティCookieを設定します。上記の表は、ウェブサイトごとに観測されたCookieの数に関する他のいくつかの統計を報告しており、以下の図はそれらの累積分布関数（cdf）を表示しています。たとえば、デスクトップでは、ウェブサイトごとに最大160個のファーストパーティCookieと632個のサードパーティCookieが設定されます。

{{ figure_markup(
  image="number-cookies-cdf-desktop.png",
  caption="ウェブサイトごとのCookieの数（cdf）、デスクトップページ用。",
  description="このグラフは、デスクトップページに設定されたCookieの数の累積分布関数を示しています。サードパーティCookieよりも、観測されたファーストパーティCookieの最大値に近い数のファーストパーティCookieを持つウェブサイトが多いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1693604543&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

{{ figure_markup(
  image="number-cookies-cdf-mobile.png",
  caption="ウェブサイトごとのCookieの数（cdf）、モバイルページ用。",
  description="このグラフは、モバイルページに設定されたCookieの数の累積分布関数を示しています。サードパーティCookieよりも、観測されたファーストパーティCookieの最大値に近い数のファーストパーティCookieを持つウェブサイトが多いことがわかります。さらに、デスクトップとモバイルの両方のウェブサイトで非常によく似た結果が観測されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=832068018&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

サードパーティCookieよりも、観測されたファーストパーティCookieの最大値に近い数のファーストパーティCookieを持つウェブサイトが多いことがわかります。

## Cookieのサイズ

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookieのサイズ（デスクトップ上位100万）バイト単位</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>すべて</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>最小値</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">26</td>
        <td class="numeric">22</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>中央値</td>
        <td class="numeric">39</td>
        <td class="numeric">36</td>
        <td class="numeric">37</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">59</td>
        <td class="numeric">58</td>
        <td class="numeric">58</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">148</td>
        <td class="numeric">114</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">380</td>
        <td class="numeric">274</td>
        <td class="numeric">348</td>
      </tr>
      <tr>
        <td>最大値</td>
        <td class="numeric">4087</td>
        <td class="numeric">4094</td>
        <td class="numeric">4094</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デスクトップページに設定されたCookieのサイズの統計。") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookieのサイズ（モバイル上位100万）バイト単位</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>すべて</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>最小値</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">26</td>
        <td class="numeric">22</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>中央値</td>
        <td class="numeric">39</td>
        <td class="numeric">37</td>
        <td class="numeric">38</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">59</td>
        <td class="numeric">59</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">149</td>
        <td class="numeric">114</td>
        <td class="numeric">130</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">382</td>
        <td class="numeric">278</td>
        <td class="numeric">352</td>
      </tr>
      <tr>
        <td>最大値</td>
        <td class="numeric">4086</td>
        <td class="numeric">4093</td>
        <td class="numeric">4093</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルページに設定されたCookieのサイズの統計。") }}</figcaption>
</figure>

このセクションでは、これらのCookieの実際のサイズに焦点を当てます。2024年6月のHTTP Archiveクロール中にデスクトップで観測されたすべてのCookieのサイズの中央値は37バイトであることがわかりました。この中央値は、ファーストパーティおよびサードパーティのCookie、およびクライアント全体で一貫しています。得られた最大サイズは約4Kバイトであり、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc6265#section-6.1">RFC 6265</a>で定義されている制限と一致しています。HTTP Archiveツールの動作方法とCookieの収集方法のため、ウェブサイトが4Kバイトの制限を超えるCookieを設定しようとした場合、この情報は、この章で分析されたデータから欠落することに注意してください。

観測されたもっとも小さいCookieは1バイトのサイズであり、空の`Set-Cookie`ヘッダーによって誤って設定された可能性があります。さらに、各クライアントの上位100万のウェブサイトで見られるすべてのCookieのサイズの累積分布関数（cdf）も報告します。

追跡に使用されるほとんどのCookieのサイズは、<a hreflang="en" href="https://link.springer.com/chapter/10.1007/978-3-319-15509-8_21">35バイト</a>を超えています。この理由は、サイズがCookieの追跡機能に関連しているためです。トラッカーは、ユーザーを再識別できるように、ユーザーにランダムに識別子を割り当てます。したがって、識別子のサイズ（バイト数）が大きいほど、より多くのユニークなユーザーに割り当てることができます。

{{ figure_markup(
  image="size-cookies-cdf-desktop-mobile.png",
  caption="ウェブサイトごとのCookieのサイズ（cdf）、デスクトップおよびモバイルページ用。",
  description="このグラフは、デスクトップおよびモバイルページに設定されたCookieの数の累積分布関数を示しています。デスクトップとモバイルの両方のクライアントで、Cookieのサイズについて非常によく似た分布が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2005425406&format=interactive",
  sheets_gid="1882828646",
  sql_file = 'size_cookies_cdf.sql'
  )
}}

## 永続性（有効期限）
<figure>
  <table>
    <thead>
      <tr>
        <th>Cookieの有効期間（デスクトップ上位100万）日数</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>すべて</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>最小値</td>
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
        <td>中央値</td>
        <td class="numeric">183</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">396</td>
        <td class="numeric">365</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>最大値</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デスクトップページに設定されたCookieの有効期間の統計。") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookieの有効期間（モバイル上位100万）日数</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>すべて</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>最小値</td>
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
        <td>中央値</td>
        <td class="numeric">183</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">396</td>
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
        <td>p95</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>最大値</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルページに設定されたCookieの有効期間の統計。") }}</figcaption>
</figure>

Cookieのサイズを調べた後、次にCookieの有効期間について見ていきましょう。Cookieは作成時に有効期限が設定されます。セッションCookieはセッションが終了するとすぐに期限切れになることを思い出してください（[前のセクション](#セッション)を参照）。ファーストパーティCookieの有効期間の中央値は約183日または約6か月ですが、サードパーティCookieの有効期間の中央値は丸1年です。1日未満および30日後、それぞれファーストパーティCookieの25%とサードパーティCookieの25%が期限切れになります。HTTP Archiveツールの計測と収集で観測できるCookieの最大有効期間は400日であり、これはChromeがCookieの`Expires`および`Max-Age`属性に課す[ハードリミット](https://developer.chrome.com/blog/cookie-max-age-expires)と一致しています。以下は、デスクトップまたはモバイルクライアントであるかどうかにかかわらず、上位100万のウェブサイトに設定されたCookieの有効期間の累積分布関数（cdf）です。

{{ figure_markup(
  image="age-cookies-cdf-desktop-mobile.png",
  caption="ウェブサイトごとのCookieの有効期間（cdf）、デスクトップおよびモバイルページ用。",
  description="このグラフは、デスクトップおよびモバイルページに設定されたCookieの有効期間の累積分布関数を示しています。Cookieの約45%が90日後に期限切れになります。モバイルとデスクトップの両方のクライアントで同じ結果が見つかります。さらに、Cookieの75%の寿命は最大1年ですが、残りの半分は1年以上ブラウザに保存されたままです。デスクトップとモバイルの両方のクライアントで、Cookieのサイズについて非常によく似た分布が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=147680119&format=interactive",
  sheets_gid="135614941",
  sql_file="age_expires_cookies_cdf.sql"
  )
}}

グラフから、Cookieの約45%が90日後に期限切れになると推測できます。モバイルとデスクトップの両方のクライアントで同じ結果が見つかります。さらに、Cookieの75%の寿命は最大1年ですが、残りの半分は1年以上ブラウザに保存されたままです。理論的には、Cookieの寿命が長いほど、繰り返し訪れるユーザーを再識別できる期間が長くなります。このため、ほとんどの追跡Cookieは通常、より長い期間ブラウザに保存されます。

## Privacy Sandboxイニシアチブ

<a hreflang="en" href="https://blog.google/products/chrome/building-a-more-private-web/">2019年</a>、Googleは、歴史的にサードパーティCookieやその他の追跡メカニズムに依存してきた広告やその他のユースケースの有用性を維持しながら、クロスサイト（ウェブ）およびクロスアプリ（Android）の追跡を減らすための<a hreflang="en" href="https://developers.google.com/privacy-sandbox">Privacy Sandbox</a>イニシアチブの立ち上げを発表しました。

### Privacy Sandboxイニシアチブとは？

Privacy Sandboxは、一意の識別子の使用を減らし、秘密の追跡を制限し、スパムや詐欺と戦い、ユーザーに関連する広告を表示し、広告のコンバージョンを測定することを目的とした<a hreflang="en" href="https://privacysandbox.com">20以上の異なる提案</a>で構成されています。

GoogleのPrivacy Sandboxに関する当初の計画の一部は、サードパーティCookieを非推奨にすることでしたが、<a hreflang="en" href="https://privacysandbox.com/news/privacy-sandbox-update">最近の更新</a>で、Googleはもはやそれが意図ではないと発表し、むしろ「人々がウェブブラウジング全体に適用される情報に基づいた選択を行えるようにするChromeの新しい体験」を導入すると述べました。同時に、Googleは「Privacy Sandbox APIを引き続き利用可能にし、プライバシーと有用性をさらに向上させるために投資を続けます」。

私たちは、Web Almanac 2024の[プライバシー](./privacy)の章と提携して、HTTP Archiveクロールによって訪問されたウェブサイトでのPrivacy Sandbox APIの採用を測定し、結果の分析についてはその章に関心のある読者を紹介します。次に、Privacy Sandboxの一部であり、これまでCookieによって提供されていた機能を置き換えることを目的とした提案されたメカニズムの概要を示します。

### Topics API

[Topics API](https://developers.google.com/privacy-sandbox/private-advertising/topics/web)は、サードパーティCookieを使用せずに、興味に基づいた広告を可能にします。このAPIにより、呼び出し元（広告技術プラットフォームなど）は、ユーザーのアクティビティに関する追加情報を明らかにすることなく、ユーザーについて観測した興味のあるトピックにアクセスできます。

Topics APIの採用に関するいくつかの結果については、[プライバシー](./privacy)の章を参照してください。

### Protected Audience

[Protected Audience API](https://developers.google.com/privacy-sandbox/private-advertising/protected-audience)は、クロスサイトのサードパーティ追跡なしで、リマーケティングおよびカスタムオーディエンスを提供するためのデバイス上の広告オークションを可能にします。広告主は、ユーザーがウェブをナビゲートしている間にブラウザによって保存される興味グループにユーザーを追加できます。これにより、広告主は、広告オークションが実行されるウェブサイトにアクセスしたときに、ユーザーが属する利用可能な興味グループに入札することで、リターゲティング広告を実行できます。

Protected Audience APIの採用に関するいくつかの結果については、[プライバシー](./privacy)の章を参照してください。

### Attribution Reporting API

[Attribution Reporting API](https://developers.google.com/privacy-sandbox/private-advertising/attribution-reporting)により、ウェブサイトとサードパーティは広告のコンバージョン、つまり広告の表示またはクリックが後でたとえば購入につながった場合を測定できます。Attribution Reporting APIは、クロスサイトの識別子やCookieを使用せずに広告のコンバージョンを測定できるようにすることを目的としています。

Attribution Reporting APIの採用に関するいくつかの結果については、[プライバシー](./privacy)の章を参照してください。

### CHIPS

[独立したパーティション化された状態を持つCookie（CHIPS）](https://developers.google.com/privacy-sandbox/cookies/chips)により、ウェブ開発者は、設定しているCookieをパーティション化されたストレージ、つまりトップレベルサイトごとに別のCookieジャーに保存したいことを指定できます。CHIPS Cookieは、この章の[パーティション化された](#partitioned)セクションで以前に説明したパーティション化されたCookieに対応します。

### 関連ウェブサイトセット

[関連ウェブサイトセット](https://developers.google.com/privacy-sandbox/cookies/related-website-sets)により、同じ所有者のウェブサイトは互いにCookieを共有できます。関連ウェブサイトセットの作成と送信は、現時点では、Googleの従業員がチェックして有効と見なされた場合にマージする<a hreflang="en" href="https://github.com/GoogleChrome/related-website-sets">GitHubリポジトリ</a>でプルリクエストを開くことによって行われます。同じ関連ウェブサイトセットに属するウェブサイトは、<a hreflang="en" href="https://www.iana.org/assignments/well-known-uris/well-known-uris.xhtml">.well-known URI</a> `/.well-known/related-website-set.json`に対応するファイルを配置することによってもそれを示す必要があります。

{{ figure_markup(
  caption="執筆時点でGoogleによって検証された関連するプライマリウェブサイトセットの数。",
  content= "64",
  classes="big-number",
  sheets_gid="199073475"
)
}}

Chromeには、Chromeチームによって検証された関連ウェブサイトセットを含むプリロードされたファイルが付属しています。執筆時点（バージョン`2024.8.10.0`）では、64の異なる関連ウェブサイトセットがあります。各関連ウェブサイトセットには、プライマリドメインと、次の属性のいずれかの下にあるプライマリドメインに関連する他のドメインのリストが含まれています：`associatedSites`、`servicesSites`、および/または`ccTLDs`。これらの64のプライマリドメインは、それぞれセットの一部としてセカンダリドメインに関連付けられています：60セットには`associatedSites`、11セットには`servicesSites`、7セットには`ccTLDs`が含まれています。次の図では、各セットのセカンダリドメインの数を報告します。プライマリドメインの大多数が5つ以下のセカンダリドメインに関連付けられている場合、`https://journaldesfemmes.com`、`https://ya.ru`、および`https://mercadolibre.com`は、それぞれ8、17、および39のセカンダリドメインにリンクされており、そのうちサードパーティのリクエストはすべてファーストパーティからのものであるかのように処理されます。

{{ figure_markup(
  image="secondary-domains.png",
  caption="プライマリドメインごとのセカンダリドメイン。",
  description="このグラフは、GoogleのPrivacy Sandboxの一部である関連ウェブサイトセットのプライマリドメインに関連付けられたセカンダリドメインを示しています。プライマリドメインの大多数が5つ以下のセカンダリドメインに関連付けられている場合、`https://journaldesfemmes.com`、`https://ya.ru`、および`https://mercadolibre.com`は、それぞれ8、17、および39のセカンダリドメインにリンクされており、そのうちサードパーティのリクエストはすべてファーストパーティからのものであるかのように処理されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=914391662&format=interactive",
  sheets_gid="199073475"
  )
}}

### 証明ファイル

一部のPrivacy Sandbox APIを使用するには、API呼び出し元は、これらのAPIをクロスサイトの再識別のために乱用せず、意図されたユースケースにのみ使用することを宣言するために、[登録](https://developers.google.com/privacy-sandbox/private-advertising/enrollment)プロセスを経る必要があります。このコミットメントが尊重されない場合の法的な影響はかなり不明確ですが、これにより、これらの呼び出し元は、これらのAPIを呼び出すために登録したドメインの`.well-known` URI `/.well-know/privacy-sandbox-attestations.json`に配置する必要がある証明ファイルを取得できます。

Chromeには、証明ファイルが登録されているドメインのリストを含むプリロードされたファイルが付属しています。現在、このリストには、次のAPIを呼び出すために登録した257の異なるドメイン（バージョン`2024.10.7.0`）が含まれています：Attribution Reporting、Protected App Signals（Androidのみ）、Private Aggregation（Chromeのみ）、Protected Audience、Shared Storage（Chromeのみ）、およびTopics。

私たちは、これらの証明ファイルを取得して解析するために、HTTP Archiveツールとは別の<a hreflang="en" href="https://github.com/privacysandstorm/well-known-crawler">カスタムクローラー</a>を使用しました。そのクローラーで232の異なるドメインの証明ファイルを正常に取得しました（一部の証明ファイルは利用可能ですが、たとえばネットワークの問題によりこのクローラーで取得できない場合があります）。次に、ChromeとAndroidの各APIに登録されているドメインの割合を報告します。これらのオリジンの大多数が、証明を必要とする5つのChrome APIのいずれかを呼び出すために登録されているのに対し、Android APIの割合ははるかに少ないことがわかります。

{{ figure_markup(
  image="attestation-files.png",
  caption="Privacy Sandbox API証明ファイルからの登録。",
  description="257のドメインがすでにGoogleのPrivacy Sandboxに登録されており、証明ファイルの一部です。このグラフは、ChromeとAndroidの各APIに登録されているドメインの割合を示しています。これらのオリジンの大多数が、証明を必要とする5つのChrome APIのいずれかを呼び出すために登録されているのに対し、Android APIの割合ははるかに少ないことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1570607827&format=interactive",
  sheets_gid="2119972682"
  )
}}

## まとめ

この章では、ウェブ上でのCookieの使用について報告します。私たちの分析により、複数の質問に答えることができます。

**ウェブサイトによって設定されるCookieの種類は？**

ウェブ上のCookieの大部分（61%）がサードパーティであることがわかりました。さらに、人気のあるウェブサイトほど、一般的にサードパーティのコンテンツを多く含むため、サードパーティのCookieを大幅に多く設定しています。さらに、サードパーティCookieの約6%がパーティション化されている（CHIPS）ことがわかります。パーティション化されたCookieは、ユーザーが訪問する各ウェブサイト（ドメイン）ごとにCookieジャーが別々であるという事実を考えると、サードパーティの追跡には使用できません。しかし、パーティション化されたCookieは、主に広告ドメインによって設定され、分析に使用されていることがわかりました。

**どのCookie属性が設定されていますか？**

設定されているすべてのCookieのうち、ファーストパーティCookieの16%とサードパーティCookieのわずか4%がセッションCookieです。残りのCookieは、ユーザーがブラウザを閉じても削除されないため、より永続的です。一般的に、Cookieの平均寿命（中央値）は、ファーストパーティで6か月、サードパーティで1年です。

さらに、サードパーティCookieの100%で`SameSite`属性が明示的に`None`に設定されており、これによりこれらのCookieがクロスサイトリクエストに含まれ、したがってそれらでユーザーを追跡できます。

**誰がCookieを設定し、何に使用されていますか？**

上位のファーストパーティCookieは、主に分析に使用されます。主な機能がユーザーによるウェブサイトの使用状況を報告すること、つまりファーストパーティ分析であるGoogle Analyticsは、少なくとも60%のウェブサイトで普及しています。Metaもその足跡をたどり、25%のウェブサイトでファーストパーティCookieを設定しています。

サードパーティCookieも主にGoogleによって設定されています。`doubleclick.net`は44%のウェブサイトにCookieを設定しています。他の上位トラッカーは、8〜12%のウェブサイトというかなり小さいリーチを持っています。一般的に、もっとも人気のあるサードパーティCookieは、主にターゲット広告カテゴリに属しています。

この章は、サードパーティCookieを完全に置き換えることを目的としたPrivacy Sandboxの概要で締めくくり、詳細な結果については[プライバシー](./privacy)の章を参照してください。
