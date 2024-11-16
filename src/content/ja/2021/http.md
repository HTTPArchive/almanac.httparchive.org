---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: 2021年版Web AlmanacのHTTPの章では、Web上で使用されているHTTPの歴史的バージョンや、HTTP/2やHTTP/3を含む新バージョンの増加に関するデータ、およびHTTPライフサイクルの一部である主要メトリクスを検証しています。
hero_alt: Hero image of Web Almanac chracters driving vehicles in various lanes carrying script and images resources.
authors: [dominiclovell]
reviewers: [tunetheweb, rmarx]
analysts: [tunetheweb]
editors: [shantsis]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1pCdpndXTXexSIZLmVc-aUbp5PcHhZ83hbEEfmDyfD0U/
dominiclovell_bio: Dominic Lovell は現在 Akamai Technologies のソリューション・エンジニアリング・マネージャーで、ウェブ上でのサイトのパフォーマンスと安全性を高めることに長年取り組んでいます。ツイッターでは[@dominiclovell](https://x.com/dominiclovell)、または<a hreflang="en" href="https://www.linkedin.com/in/dominiclovell/">LinkedIn</a>で彼とつながることができます。
featured_quote: 70%以上のリクエストがHTTP/2以上で処理されており、HTTP/2とHTTP/3がWebの支配的なプロトコルバージョンであることを示唆しています。
featured_stat_1: 25%
featured_stat_label_1: 2020年から2021年にかけてのHTTP/1.1リクエストの減少について
featured_stat_2: 82%
featured_stat_label_2: HTTP/2を有効にしている上位1,000サイト
featured_stat_3: 1.25%
featured_stat_label_3:  HTTP/2プッシュを使用しているサイト
---

## 序章

HTTPプロトコルは、Webを構成する重要な要素の1つです。HTTP自体は、1997年にHTTP/1.1が導入されて以来、20年近く変更されることはありませんでした。HTTPの実装方法に大きな設計変更があったのは、HTTP/2の導入が行われた2015年まででした。HTTP/2は、主にプロトコルのトランスポートレベルで変更を導入するよう設計されていました。これらのプロトコルの変更は、その動作が重要である一方で、バージョン間の後方互換性をまだ可能にしていました。

今年もまた、HTTP/2を詳しく見て、その主要な機能のいくつかを議論します。そして、HTTP/2の利点のいくつかと、なぜそれがウェブパフォーマンスコミュニティ全体で大きく採用されているのかを見ていきます。HTTP/2は接続制限、より優れたヘッダー圧縮、より優れたペイロードのカプセル化を可能にするバイナリサポートなどHTTPの多くの問題の解決を目指したが、提示されたすべての機能がその設計で成功したわけではなかった。

HTTP/2が野放しになって数年、HTTP/2の意図のいくつかはまだ実現されていない。たとえば、昨年、私たちは、HTTP/2プッシュに別れを告げるかどうかという問いを提起しました。今年は、2021年のデータを見ることで、より確信を持ってこの問いに答えることを目指しています。これらの欠点が明らかになるにつれて、HTTPの次のイテレーションであるHTTP/3で対処されたり省略されたりしています。

過去1年間のHTTP/3のサポートの増加は、ウェブでのHTTP/3の採用について内省することを可能にしました。この章では、HTTP/3のコア機能のいくつかと、それぞれの利点を詳しく見ていきます。また、HTTP/3の進化をサポートしている主要なベンダーと、HTTP/3の継続的な批評のいくつかを検証します。

Web AlmanacがHTTPの章を通して回答しようとするデータポイントには、HTTPバージョン間の採用状況、主要ソフトウェアベンダーやCDN企業のサポート、ファーストパーティとサードパーティのこの分布が採用にどのように影響するかが含まれます。また、接続、サーバープッシュ、レスポンスデータサイズなどのHTTP属性に関する指標を含め、ウェブ上のトップランカーサイトにおける使用状況も見ています。

これらのデータは、2021年のウェブ上でのHTTPの使用状況や、主要なバージョン間でのプロトコルの進化についてのスナップショットを提供します。そして、今後数年間の主要な機能の採用について洞察を提供します。

### HTTPの進化

<a hreflang="en" href="https://www.ietf.org/">インターネット技術特別調査委員会 (IETF)</a> が <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7540">HTTP/2</a>を紹介して以来6年が経ちますが、そもそもHTTP/2に至った経緯について理解する価値があるでしょう。30年前（1991年）、私たちははじめてHTTP 0.9を紹介されました。HTTPは、機能が制限されていた0.9からは大きく進歩しました。0.9は、GETメソッドのみをサポートし、ヘッダーやステータスコードをサポートしない、1行のプロトコル転送に使用されていました。回答はハイパーテキストで提供されるだけだった。5年後、これはHTTP/1.0で強化されました。1.0バージョンには、レスポンスヘッダー、ステータスコード、 `GET`、`HEAD`、`POST` メソッドなど、現在私たちが知っているほとんどのプロトコルが含まれています。

1.0で対処できなかった問題は、応答を受け取った後すぐに接続が終了してしまうことでした。つまり、リクエストごとに新しいコネクションを開き、TCPハンドシェイクを行い、データを受け取った後にコネクションを閉じる必要があったのです。この大きな非効率性から、わずか1年後の1997年にHTTP/1.1が導入され、一度開いたコネクションを再利用できる持続的なコネクションが可能になりました。このバージョンは、2015年まで何の変更も加えられることなく、18年間その目的を果たしました。この間、Googleは <a hreflang="en" href="https://ja.wikipedia.org/wiki/SPDY">SPDY</a> という、HTTPメッセージの送信方法を完全に作り直す実験を行いました。これは最終的にHTTP/2で正式化されました。

HTTP/2は、Web開発者がパフォーマンスの向上を図る際に直面していた問題の多くに対処することを目的としています。HTTP/1.1の非効率性を回避するためには、ドメインシャード、アセットスプリング、ファイルの連結といった複雑な処理が必要でした。リソースの多重化、優先順位付け、ヘッダー圧縮を導入することで、HTTP/2はプロトコルレベルでネットワークの最適化を提供するように設計されています。既知のパフォーマンス問題に対処するだけでなく、HTTP/2は _HTTP/2 プッシュ_ のような機能によって、新しいパフォーマンスの最適化の可能性を導入しました。

## HTTP/2の採用

{{ figure_markup(
  image="http-versions-main-page.png",
  caption="ページロードで使用されるHTTPのバージョン。",
  description="ページロードで使用されるHTTPバージョンを示す棒グラフ。デスクトップサイトの59.5％がHTTP/2+を、モバイルサイトの59.4％がHTTP/2+を使用しています。それぞれ39.6%、39.8%がHTTP/1.1を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=164555214&format=interactive",
  sheets_gid="1870188510",
  sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql"
  )
}}

HTTPバージョン0.9から30年の間に、プロトコルの採用状況に変化がありました。600万以上のウェブページを分析した結果、HTTP Archiveは最初のページリクエストにHTTP 0.9を使用した例は1つだけで、1.0を使用しているページはわずか数千件であることを発見しました。しかし、ほぼ40%のページがバージョン1.1を使用しており、残りの60%はHTTP/2以上を使用しています。このように、HTTP/2の採用率は、2020年に同じ分析を行ったときよりも10%増加しています。

<p class="note">注: 後述するように、HTTP/3の動作方法と、毎回新鮮なインスタンスでクロールが動作する方法のため、HTTP/3は最初のページリクエスト、あるいはその後のリクエストに使用される可能性は低いです。そのため、本章ではいくつかの統計情報を「HTTP/2+」として報告し、現実世界でHTTP/2またはHTTP/3が使用される可能性があることを示す。私たちは、この章の後半で、（私たちのクロールで使用されていないとしても）実際にどの程度HTTP/3がサポートされているのかを調査します。</p>

### リクエストによる採用

最初のページへのリクエストは、他の多くのリクエストによって補完されます。多くの場合、サードパーティによって提供され、異なる、あるいはより優れたプロトコルサポートを持っているかもしれません。このため、最初のページだけでなく、リクエストのレベルで見ると、使用率が非常に高くなることが過去数年間わかっており、今年もその傾向が見られます。

{{ figure_markup(
  image="http-version-requests.png",
  caption="リクエストで使用されたHTTPのバージョン。",
  description="リクエストで使用されたHTTPバージョンを示す棒グラフ。モバイルのリクエストの73.2%がHTTP/2を使用しているのに対し、26.5%はまだHTTP/1.1を使用しており、0.3%が未知、HTTP/0.9とHTTP/1.0はどちらも小さいため0%としてグラフ化されています。デスクトップの使用率は同じようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=2104913686&format=interactive",
  sheets_gid="2077755325",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
  )
}}

2021年、HTTP Archiveのデータは、HTTP/0.9とHTTP/1.0が事実上すべて消滅したことを示唆しています。0.9には数百のリクエストが存在しましたが、データセット全体で集計するとゼロに切り捨てられます。HTTP/1.0は数千のリクエストがありますが、これも全体の0.02%に過ぎません。

{{ figure_markup(
  caption="昨年度のHTTP/1.1リクエストの減少。",
  content="25%",
  classes="big-number",
  sheets_gid="2077755325",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

興味深いことに、4分の1以上のリクエストは依然としてHTTP/1.1経由で提供されています。2020年と比較すると、これは25%減少していることになります。70%以上のリクエストがHTTP/2以上で処理されており、HTTP/2とHTTP/3がWebの支配的なプロトコルバージョンであることを示唆しています。

ページごとに使用されているプロトコルを見ると、やはりHTTP/2以上の優位性がプロットされます。

{{ figure_markup(
  image="http2-and-above-resources-by-percentile.png",
  caption="HTTP/2+リソースのパーセンタイル別利用状況。",
  description="HTTP/2+リソースの使用率をパーセンタイルで示した折れ線グラフ。75パーセンタイルを超えると、100% のサイトがすべてのリソースでHTTP/2+ を使用します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1207400014&format=interactive",
  sheets_gid="871426393",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

50パーセンタイル以上のページでは、リソースの92%以上がHTTP/2+ で提供されています。そして70パーセンタイル以上では、100% のサイトのリソースがHTTP/2以上で読み込まれています。別の言い方をすれば、30%のサイトがHTTP/1.1のリソースをまったく使用していないことになります。

### 第三者による採用

{{ figure_markup(
  image="http2-and-above-third-party-resources-by-percentile.png",
  caption="サードパーティのリソースにHTTP/2+を使用する。",
  description="サードパーティリソースのHTTP/2+の利用状況を示す棒グラフ。40パーセンタイルを超えると、100%のリソースがHTTP/2+を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1806404234&format=interactive",
  sheets_gid="1768565957",
  sql_file="http2_1st_party_vs_3rd_party.sql"
  )
}}

サードパーティコンテンツによるHTTP/2の採用は非常に偏っており、サードパーティのリクエストの40パーセンタイルを超えると、100%のトラフィックがHTTP/2で提供されるようになります。実際、10パーセンタイルでも、66%以上のリクエストがHTTP/2を活用しています。このことから、導入の大半はまだ[サードパーティコンテンツ](./third-party)と[CDN](./cdn)を活用したドメインが提供するコンテンツに影響されていることがわかります。

### サーバーでの採用

<a hreflang="en" href="https://caniuse.com/http2">caniuse.com</a> によると、全世界で97%のブラウザがHTTP/2をサポートしているとのことです。HTTPSは、HTTP/2対応のためにブラウザが要求しているもので、従来はブロックされていた可能性があります。しかし、<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">デスクトップで93%、モバイルでは91%のサイトがHTTPSに対応しています</a>。これは、2020年に昨年より5％増加し、2019年から2020年にかけては前年比6％増加しました。HTTPSの導入はもはやブロッカーではない。

ブラウザ間での高い普及率とHTTPSの高い普及率から、HTTP/2のさらなる普及を制限する要因は、まだサーバーの実装に大きく左右されることを理解することが重要です。HTTP/2の利用が急速に増加しているにもかかわらず、ウェブサーバ別に分けた場合、採用の数値はより断片的なストーリーを示しています。

{{ figure_markup(
  image="server-http2-or-above-usage.png",
  caption="上位サーバーとHTTP/2+で提供されたページの割合。",
  description="上位サーバーとHTTP/2+で提供されたページの割合を示す積み上げ棒グラフ。HTTP/2+を利用しているサイトの割合は、Nginxが64.7%、Cloudflare 93.0%、Apacheのみ36.8%、Lifespeedが83.3%、未設定は53.0%、pepyakaが99.8%、gse 49.1%、openresty 68.3%、Micorosft IIS 29.9%、そしてSquarespaceは89.1％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=416927136&format=interactive",
  sheets_gid="2024977755",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

Apache HTTPサーバーを使用しているサイトでは、HTTP/2にアップグレードしている可能性は低く、新しいプロトコルを活用しているApacheサーバーはわずか3分の1に過ぎません。Nginxは、全サーバーの3分の2がHTTP/2にアップグレードしており、より有望な数字を示しています。CDNとクラウドサーバーは、Cloudfront、Cloudflare、Netlify、S3、Flywheel、Vercelなどのサービスから、いずれも高い採用率を誇っています。CaddyやIstio-Envoyのようなニッチなサーバ実装も、高い採用率を示しています。一方、IIS、Gunicorn、Passenger、Lighthttpd、Apache Traffic Server（ATS）などの実装はいずれも採用率が低く、Scuriも採用率はほぼゼロと報告されています。

{{ figure_markup(
  image="server-software-not-using-http2-or-above.png",
  caption="HTTP/2+を使用していないサイトが使用するサーバーソフト。",
  description="HTTP/2+を利用していないサイトが利用しているサーバーソフトを棒グラフで示したもの。モバイルサイトではHTTP/2+を利用していないのはApacheが18.8%ともっとも高く、次いでnginx（9.1%）、Micosoft IIS（3.4%）、サーバー名なし（2.9%）、GSE（1.6%）、Cloudflare OpenrestyとLifespeed（いずれも0.7%）、最後にApache CoyoteとSquaresapceは0.1%となります。デスクトップ利用も似たような感じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1494809703&format=interactive",
  sheets_gid="641704944",
  sql_file="count_of_non_h2_and_h3_sites_grouped_by_server.sql",
  width=600,
  height=614
  )
}}

実際、HTTP/1.1レスポンスを報告している全サーバーのうち、もっとも多いのはApacheサーバーで20%でした。Apacheはウェブ上でもっとも普及しているウェブサーバーの1つであるため、古いApacheによってウェブが新しいプロトコルを全面的に採用するのを妨げている可能性があることを示唆しています。

### CDNによる採用

CDNは、HTTP/2のような新しいプロトコルの採用を推進する上で極めて重要な役割を果たすことが多く、統計データを見れば、このことが証明されます。

{{ figure_markup(
  image="top-cdns-and-http2-or-above-usage.png",
  caption="上位CDNとHTTP/2+で提供されるページの割合。",
  description="CDNによるHTTP/2+とHTTP/1.1の採用状況を示す棒グラフ。CDNがない場合、HTTP/2+を使用するサイトは49%にとどまります。CDNについては、採用率はまちまちですが、すべてCDNなしの値を上回っています。Cloudflare (94.7%), Google (68.7%), Fastly (97.1%), Amazon CloudFront (91.6%), Akamai (81.4%), Automattic (100.0%), Sucuri Firewall (95.5%), Incapsula (59.6%), Netlify (99.7%), CDN (97.1%), Highwinds (89.8%), Vercel (86.4%), OVH CDN (88.8%), Microsoft Azure (96.6%)です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1877391271&format=interactive",
  sheets_gid="1902992488",
  sql_file="http2_3_support_by_cdn_per_page_and_request.sql",
  width=600,
  height=592
  )
}}

大多数のCDNは、HTTP/2搭載サイトの採用率が70%以上であり、非CDNトラフィックの49.1%よりはるかに高い。Yottaa、WP Compress、jsDeliverなどの一部のCDNは、すべてHTTP/2の採用率が100%となっています!

採用率の高いサービスは、広告ネットワーク、分析、コンテンツプロバイダー、タグマネージャー、ソーシャルメディアサービスなどの周辺サービスが典型的です。これらのサービスにおけるHTTP/2の採用率の高さは、少なくとも50%がHTTP/2を有効にしている5％台以上でも明らかです。中央値では、これらのサービスの95%がHTTP/2を使用することになります。

### ランク別採用状況

{{ figure_markup(
  image="http2-or-above-usage-by-ranking.png",
  caption="ランキング別のトップページでのHTTP/2+の利用状況。",
  description="ランキング別のトップページでのHTTP/2+の利用状況を示す棒グラフ。モバイルの上位1,000サイトの82.3%がHTTP/2+を使用しており、上位10,000サイトでは76.8%、上位10万サイトは67.0%、上位100万サイトでは61.5%、すべてのサイトでは59.4%となっていることがわかります。デスクトップの数字も似たようなものです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1651314530&format=interactive",
  sheets_gid="366623986",
  sql_file="http2_http3_usage_by_rank.sql"
  )
}}

また、HTTP ArchiveにおけるサイトのページランクとHTTP/2への対応には直接的な相関があります。トップ1,000に掲載されているサイトの82%がHTTP/2を有効にしています。上位1万サイトでは76%以上、次いで上位10万サイトで66%、そして上位100万サイトは少なくとも60%がHTTP/2を有効にしていることになります。このことは、ランキング上位のサイトが、提供されるセキュリティとパフォーマンスの利点を求めてHTTP/2を有効にしていることを示唆しています。ランキング上位のサイトほど、HTTP/2を有効にしている可能性が高くなります。


## HTTP/2をもう少し深く掘り下げる

HTTP/2の主な利点の1つは、テキストベースのプロトコルの代わりにバイナリであることです。ストリームで送信されるリクエストは、1つまたは複数の _フレーム_ で構成されることがあります。これは、クライアントとサーバーの間の仕組みを変えます。

メッセージをフレームにチャンキングし、それらのフレームをワイヤ上でインターリーブすることで、1つのTCPコネクションで複数のメッセージを送受信できます。これにより、ドメインハックやその他のHTTP/1.1パフォーマンスの回避策が不要になります。

しかし、このまったく新しいHTTPトラフィックの送信方法は、HTTP/2が以前のバージョンと互換性がないことを意味するため、クライアントとサーバーはそれぞれHTTP/2を話していることを知る必要があります。HTTPSは、HTTP/2のデファクトスタンダードとして採用されています。HTTP/2はHTTPSなしでも実装できますが、すべての主要なブラウザベンダーは、HTTP/2がHTTPS上で使用されることを保証しています。また、HTTP/2は<a hreflang="en" href="https://ja.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation">ALPN</a>を使用しており、最初の接続時にプロトコルを特定できるため、より高速な暗号化接続が可能になります。

### プロトコル間の切り替え

HTTPSの使用は、HTTP/1.1とより新しいHTTP/2のどちらを「話す」かを決めるのに役立ちますが、より新しいプロトコルに切り替える方法は他にもあります。HTTP/2のサポートはHTTP/1.1接続で `upgrade` HTTPヘッダーによって告知され、クライアントは101 (Switching Protocols) 応答ステータスコードを使って切り替えを行うことが可能です。HTTP/2からHTTP/3へは、同様の `alt-svc` (Alternative Service) ヘッダーが使用されますが、これについては本章で後ほど説明します。

HTTP Archiveのデータによると、`Upgrade`ヘッダーの使用は、しばしば誤用されたり、正しく設定されなかったりすることがあるようです。この機能は、実際、HTTP/2の次のバージョンから <a hreflang="en" href="https://github.com/httpwg/http2-spec/issues/772">削除</a> される予定です。`Upgrade`ヘッダーを提供しているサイトはごく一部です。もっとも多く報告されているヘッダーは、HTTP/2オプション、またはHTTP/2 over cleartextの詳細を示す `h2,h2c` で、デスクトップサイトの0.09% とモバイルサイトの0.16% がこのヘッダーを報告しています。

同様の割合で `websockets` も `Upgrade` オプションとして提供しているサイトがあり、0.08%となっています。`Upgrade`は、リクエストが行われた既存のHTTP/1.1接続以外の、互換性のない、またはより適切なプロトコルを通知するために使用されるべきものだからです。0.04% のサイトが、この接続がすでにHTTP/2であるにもかかわらず、H2を `Upgrade` オプションとして不正確に報告しています。

{{ figure_markup(
  image="upgrade-headers-sent-over-http2.png",
  caption="HTTP/2コネクションで送信されるヘッダーをアップグレードする。",
  description="HTTP/2接続で送信されたアップグレードヘッダーを示す棒グラフ。`h2,h2c`がもっとも多く、デスクトップでは2,18、モバイルでは2,595となっています。`h2`はそれぞれ1,319 1,373、`h2c`は148のデスクトップサイトでモバイルサイトはない。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1528853201&format=interactive",
  sheets_gid="1528853201",
  sql_file="detailed_upgrade_headers.sql"
  )
}}

さらに心配なのは、HTTP/2接続をHTTP/2に「アップグレード」することを提案するサイトの数です。これは明らかなエラーであり、HTTP/2の初期にはブラウザを混乱させるために使用されました。

また、約12万件のモバイルサイトがHTTPで発見されましたが、HTTP/2への`Upgrade`ヘッダーが報告されています。より良い方法は、HTTPからHTTPSへのリダイレクトを発行し、安全な接続で直接HTTP/2を活用することです。

{{ figure_markup(
  caption="モバイルサイトがHTTP/2をサポートしていないにもかかわらず、サポートしていると主張すること。",
  content="26,000",
  classes="big-number",
  sheets_gid="2104508007",
  sql_file="number_of_https_requests_not_using_h2_or_h3_returning_upgrade_http_upgrade_header_containing_h2.sql"
)
}}

また、デスクトップとモバイルでそれぞれ22,000と26,000のWebページがHTTPSでありながらHTTP/2をサポートしていないことが判明しました。同様に、数百のウェブページで、接続自体がすでにHTTP/2であるにもかかわらず、HTTP/2にアップグレードするよう誤ったシグナルが表示されていました。

### 接続台数

HTTP/2の導入以降、1ページあたりのTCP接続数の中央値は着実に減少しています。

{{ figure_markup(
  image="tcp-connections-by-home-page-http-version.png",
  caption="ホームページのHTTPバージョン別のTCPコネクション。",
  description="ホームページのHTTPバージョン別のTCP接続を示す棒グラフ。HTTP.1.1ではデスクトップとモバイルで16、HTTPS/2+ではデスクトップとモバイルで13と12。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=567187980&format=interactive",
  sheets_gid="1213076952",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
  )
}}

本稿執筆時点では、デスクトップ接続数は12か月間で44%減の16接続（中央値）。モバイルは7%減で、接続数の中央値は12です。これは、2020年以降にHTTP/2の採用が急増したため、時間の経過とともに接続数が減少していることを表しています。

{{ figure_markup(
  image="tcp-connections-per-http-version-by-percentile.png",
  caption="HTTPバージョンごとのTCPコネクション数（パーセンタイル別）。",
  description="HTTPバージョンごとのTCP接続数をパーセンタイルで示した棒グラフ。10パーセンタイルではHTTP/1.1が6、HTTP/2+が4、25パーセンタイルでは10と7、50パーセンタイルでは16と12、7番目では24と20、90パーセンタイルでは40と33になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=993526405&format=interactive",
  sheets_gid="1213076952",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
  )
}}

収集したHTTP Archiveのデータによると、HTTP/1.1サイトの中央値は、1ページあたり16コネクションになります。75パーセンタイルでは24コネクションになります。モバイルとデスクトップでは、90パーセンタイルで40と2倍以上になります。一方、HTTP/2サイトでは、中央値で12、75パーセンタイルで21、90パーセンタイルで33の接続が発生します。トップエンドでも、ウェブサイト全体で使用される接続数が21%減少していることになります。

TLSはパフォーマンスに若干のオーバーヘッドを追加し、HTTPS上のHTTP/2の事実上の実装では、使用するTLSのバージョンによってパフォーマンスの考慮が必要であることを意味します。<a hreflang="en" href="https://blogs.windows.com/msedgedev/2016/06/15/building-a-faster-and-more-secure-web-with-tcp-fast-open-tls-false-start-and-tls-1-3/">TLS1.3</a> が導入されて以来、<a hreflang="en" href="https://blogs.windows.com/msedgedev/2016/06/15/building-a-faster-and-more-secure-web-with-tcp-fast-open-tls-false-start-and-tls-1-3/">TLS false starts</a> など、パフォーマンスへの配慮が追加され、クライアントが最初のTLSラウンドトリップ後に直ちに暗号化データの送信を開始できるような仕組みが導入されています。同様に、TLSハンドシェイクを改善するためにゼロラウンドトリップタイム（<a hreflang="en" href="https://blog.cloudflare.com/introducing-0-rtt/">0-RTT</a>）を実現しました。TLS 1.2ではTLSハンドシェイクを完了するために2回のラウンドトリップが必要ですが、1.3では1回で済むため、暗号化の待ち時間が半分に短縮されます。

{{ figure_markup(
  image="tls-version-by-http-version.png",
  caption="ページのHTTPバージョンで使用されるTLSバージョン。",
  description="ページのHTTPバージョン別に使用されるTLSバージョンを示す棒グラフ。HTTP/2はTLSv1.3をもっとも多く使用しており、全ページの48.51%に及んでいます。HTTP 1.1では、全ページの16.69%で依然としてTLS 1.2への依存がもっとも多い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1143806427&format=interactive",
  sheets_gid="135993893",
  sql_file="tls_adoption_by_http_version.sql"
  )
}}

HTTP Archiveのデータによると、デスクトップページの34%がTLS 1.2を、56%がTLS 1.3を使用しており、残りの10%は不明（接続に失敗したHTTPSサイトなど）です。モバイルではやや低く、36%がTLS 1.2、55%がTLS 1.3、9%が不明となっています。大半のサイトがTLS1.3を使用していますが、Webサイトの3分の1はアップグレードすることで、これらのパフォーマン スを向上させることができます。

### ヘッダーの削減

HTTP/2で提唱されたもう1つの機能は、ヘッダーの圧縮です。HTTP/1.1は、多くの重複した、または繰り返されるHTTPヘッダーが電線で送信されていることを証明しました。これらのヘッダーは、クッキーを扱うときにとくに大きくなることがあります。このオーバーヘッドを減らすために、HTTP/2は<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7541">HPACK圧縮形式</a>を利用して、送受信するヘッダーのサイズを小さくしています。クライアントとサーバーの両方が、よく使われるヘッダーや以前に転送したヘッダーのインデックスをルックアップテーブルに保持し、個々の値を前後に送信するのではなく、テーブル内のそれらの値のインデックスを参照できます。これにより、電線で送信されるバイト数を節約できます。

{{ figure_markup(
  image="most-popular-http-response-headers.png",
  caption="もっとも普及しているHTTPレスポンスヘッダー。",
  description="もっとも普及しているHTTPレスポンスヘッダーを示す棒グラフです。`Date`、`Content-Type`、`Server`はもっとも普及しているヘッダーです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1202666187&format=interactive",
  sheets_gid="160135371",
  sql_file="response_headers_type_usage.sql",
  width=600,
  height=605
  )
}}

受信したレスポンスヘッダーの中で、もっとも多いヘッダーは上位5つです。それぞれ、 `date`, `content-type`, `server`, `cache-control`, `content-length` です。もっとも一般的な非標準ヘッダーはCloudflareの `cf-ray` で、Amazonの `x-amz-cf-pop` と `X-amz-cf-id` がそれに続いています。コンテンツ情報 (`length`, `type`, `encoding`) 以外では、キャッシュポリシー (`expires`, `etag`, `last-modified`) やオリジンポリシー (STS,  [CORS](https://developer.mozilla.org/docs/Web/HTTP/Headers/Access-Control-Allow-Origin)), [`expect-ct`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Expect-CT) レポート証明書の透明性やCSP [`report-to`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy/report-to) ヘッダーはもっともよく使われるヘッダーとなります。

これらのヘッダーの一部 (たとえば `date` や `content-length`) はリクエストごとに変わるかもしれませんが、大部分はリクエストごとに同じか、限られた数のバリエーションを送信します。同様にリクエストヘッダーも、リクエストごとに同じデータ（長い `user-agent` ヘッダーなど）を何度も送信することがよくあります。したがって、影響を考慮するためには、ページが行っているリクエストの数に注目する必要があります。

{{ figure_markup(
  image="number-of-http-requests-by-percentile.png",
  caption="パーセンタイル毎のHTTPリクエスト数。",
  description="パーセンタイル毎のHTTPリクエスト数を示す棒グラフ。90%パーセンタイルでは、デスクトップが178、モバイルが171となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=770966381&format=interactive",
  sheets_gid="2107067784",
  sql_file="response_number_and_size.sql"
  )
}}

デスクトップ用サイトの中央値は74リクエスト、モバイル用サイトの中央値は69リクエストです。1ページあたりのリクエスト数が数千を超えるサイトも何百とありました。もっとも高かったのは、合計17,923リクエストで、次いで10,224リクエストとなっています。HTTP/2は、以前のリクエストで送信されたヘッダーを圧縮して再利用することで、繰り返されるリクエストの影響を軽減しています。

この分析では、ブラウザのネットワークスタックの奥深くに埋もれているため、ヘッダー圧縮の正確な影響を測定することはできませんが、圧縮されていないヘッダーサイズを見ることで、潜在的なメリットの指標を示すことはできます。

{{ figure_markup(
  image="http-response-header-sizes.png",
  caption="HTTPレスポンスヘッダーサイズ。",
  description="HTTPレスポンスヘッダーサイズを示す棒グラフ。デスクトップのヘッダーサイズは、モバイルよりも若干大きくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=845576315&format=interactive",
  sheets_gid="2107067784",
  sql_file="response_number_and_size.sql"
  )
}}

ウェブページの中央値では、デスクトップで34KB、モバイルで31KB相当のヘッダーが返されます。90パーセンタイルでは、デスクトップで98KB、モバイルで94KBに増加します。しかし、レスポンスヘッダーの最大のインスタンスは5.38MB以上でした。多くのサイトで、1MBを超えるレスポンスヘッダーが発見されました。一般的に、これらの大きなレスポンスヘッダーは、オーバーウェイトの `CSP` または `P3P` ヘッダーが原因であり、ウェブサイト間でこれらのヘッダーの複雑さや誤った管理を示唆しています。他の極端な例では、複数の `Set-Cookies` や `Cache-Control` の設定を重複させるアプリケーションの設定ミスやエラーが原因で、ヘッダーが過大になっています。

### 優先順位付け

また、あるストリームを別のストリームに依存させることでストリームをリンクさせたり、1〜256の整数を割り当てて重み付けをしたりすることもできます。これらの依存関係や重み付けによって、サーバーは特定のキーストリームを優先し、他のストリームよりも先に応答データを送信できます。

HTTP/2が導入されて以来、優先順位付けはウェブのさまざまな部分で矛盾なく実装されています。[Andy Davis](https://x.com/AndyDavies)は、この矛盾が、ウェブ上のユーザーに最適とはいえない体験をもたらす可能性があることを発見しました。これは、サーバーが優先順位付けを無視して、先着順でサービスを提供することが多いからです。実際、<a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">Andyの研究</a>は、主要なCDNの多くがHTTP/2の優先順位付けを正しく実装していないことを強調しています。これには、人気のあるクラウドロードバランサーも多数含まれています。2021年のデータでは、優先順位付けを正しく実装しているCDNはわずか6社で、例年と同様の調査結果となっています。これには、Akamai、Fastly、Cloudflare、Automattic、section.io、Facebook独自のCDNが含まれています。

[Patrick Meehan](https://x.com/patmeenan)は、優先順位付けを正しく実装しているCDNを使っていない場合、BBRや `tcp_notsent_lowat` を含む多くの <a hreflang="en" href="https://blog.cloudflare.com/http-2-prioritization-with-nginx/">TCP最適化</a> があり、サーバー側での優先順位付けを改善できるだろうと提案しています。

この不整合はクライアントレベルでも存在し、ブラウザベンダーによってこの動作の実装が異なります。Safariは、アセットタイプに応じて優先順位付けを行う静的なアプローチを実装しており、依存関係をマッピングしません。Chrome、Edge、Firefoxは、ストリーム全体の論理的な依存関係を構築する、より高度なアプローチを持っており、発見された優先順位に基づいてストリーム上の要求されたアセットの優先順位を変更できます。

{{ figure_markup(
  image="webpagetest-waterfall-example.png",
  caption="WebPageTestのウォーターフォール例。",
  description="WebPageTestのリソースを示すスクリーンショット。優先順位の高いリソースが早期に読み込みを終了している。",
  width=938,
  height=715
  )
}}

HTTP/2からは、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-priority">HTTPの拡張可能な優先順位付けスキーム</a> という提案で、優先順位付けに対する最新の提案がなされています。これには、レスポンスに `priority` ヘッダーを追加することと、HTTP/2用の新しい `PRIORITY_UPDATE` フレームを追加することが含まれます。この `PRIORITY_UPDATE` フレームは、HTTP/3においても提案されています。これはまだウェブ全体に完全に採用されていませんが、<a hreflang="en" href="https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/">Cloudflare</a>が<a hreflang="en" href="https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/">優先順位付け</a> の基本動作を改善する取り組みとして注目されています。

### HTTP/2プッシュの死？

もう1つの大きな特徴は、サーバープッシュの仕組みが導入されたことです。HTTP/2のサーバープッシュでは、サーバーがクライアントのリクエストに応答して複数のリソースを送信できます。このため、クライアントがその存在を気づく前に、サーバーはクライアントが必要とする可能性のあるアセットを通知する。一般的な使用例としては、ブラウザがベースHTMLを解析してそれらの重要な資産を特定し、その後自ら要求する前に、JavaScriptやCSSなどの重要な資産をクライアントにプッシュすることが挙げられます。クライアントには、プッシュメッセージを拒否するオプションもあります。

ゼロ・ラウンドトリップ、先制的な重要資産、パフォーマンス向上の可能性などの約束にもかかわらず、HTTP/2プッシュは誇大広告に見合うものではありません。

{{ figure_markup(
  caption="HTTP/2プッシュを使用しているサイト。",
  content="1.25%",
  classes="big-number",
  sheets_gid="1872576847",
  sql_file="count_of_h2_and_h3_sites_using_push.sql"
)
}}

2019年に分析したところ、HTTP/2はほとんど採用されておらず、平均0.5%程度でした。翌2020年には、デスクトップで0.85%、モバイルでは1.06%の採用率に増加しました。今年2021年はデスクトップで1.03％、モバイルで1.25％とわずかに増加しています。相対的にモバイルは前年比で大幅に増加していますが、HTTP/2の採用率は全体で1.25%と、まだ無視できるレベルです。ページレベルでは、デスクトップが64kリクエスト、モバイルが93kリクエストとなっています。

{{ figure_markup(
  image="preload-link-nopush-header-usage.png",
  caption="HTTPのプリロードリンクヘッダーは `nopush` を使用します。",
  description="HTTPプリロードリンクヘッダー を `nopush` で表示した棒グラフ。モバイルで13.4%、デスクトップでは12.5%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1245853&format=interactive",
  sheets_gid="1461224598",
  sql_file="count_of_preload_http_headers_with_nopush_attribute_set.sql"
  )
}}

多くのHTTP/2の実装では、`preload` [resource hint](./resource-hints) をプッシュするためのシグナルとして再利用していました。しかし、場合によっては、開発者がアセットをプリロードしたいが、HTTP/2プッシュメカニズムで配信されるのは嫌だと判断することがあります。CDNや他の下流のサーバーに、<a hreflang="en" href="https://www.w3.org/TR/preload/#server-push-http-2">`nopush`</a> ディレクティブを使って、プッシュを試みないように合図したいかもしれません。今年のデータでは、20万件以上のプリロードヘッダーが使用され、そのうちの平均12％が`nopush`属性で発行されたことが分かっています。

課題の1つは<a hreflang="en" href="https://www.nginx.com/blog/nginx-1-13-9-http2-server-push/">Nginx</a> や <a hreflang="en" href="https://httpd.apache.org/docs/2.4/howto/http2.html#push">Apache</a> 設定でグローバルに定義されているような、サイト全体に一様に適用する一連のプッシュに対して、現在のページとそのページの重要な資産に基づいて形成される、ページ レベルでの動的プッシュ ディレクティブを導入することです。<a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317">Akamai</a> や <a hreflang="en" href="https://github.com/guess-js/guess/">Google</a> が実際のユーザー データと分析を使ってこの動的プッシュの設定を決定する実装例を示しているものの、ウェブ全体での実装が限定されていることがデータからうかがえます。<a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317">Akamai</a> の研究によると、正しく適用すればHTTP/2プッシュはウェブパフォーマンスに明確な利益をもたらすことが示唆されています。

しかし、他のCDNプロバイダーやサーバー実装からの投資は、HTTP/2プッシュのための設計が困難であることを証明しています。実際に[Jake Archibald](https://x.com/jaffathecake)は、2017年の時点で<a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">これらの課題</a>のいくつかを説明しています。これらは、プッシュキャッシュの問題、ブラウザの不整合、クライアントがプッシュを必要としないと判断した場合にサーバーから送信される余分なバイトに焦点を当てたものです。<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-cache-digest#appendix-A">いくつか</a>の<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-vkrasnov-h2-compression-dictionaries-03">これらの</a> issuesを解決しようとする試みは、キャッシュ ダイジェストがユーザーの特定に使われるかもしれないプライバシーとセキュリティの懸念に関する問題から、主に放棄されました。

Patrick Meehan氏は、代替案に関するこの投稿<a hreflang="en" href="https://blog.cloudflare.com/early-hints/#:~:text=summarized%20server%20push%E2%80%99s%20gotchas">103 Early Hintsで、問題点のいくつかを取り上げています</a>。その投稿では、Pushは通常、HTMLやその他のレンダーブロッキングアセットを遅延させる結果になると詳しく説明しています。

#### プッシュされたアセット

{{ figure_markup(
  image="http2-push-size.png",
  caption="HTTP/2 pushed kilobytes.",
  description="さまざまなパーセンタイルでモバイルとデスクトップにプッシュされたキロバイト数を示す棒グラフ。10パーセンタイルではデスクトップとモバイルの両方で0バイト、25パーセンタイルではデスクトップで19バイト、モバイルで0バイト、50パーセンタイルではそれぞれ146と48、75パーセンタイルでは295と222、そして最後に90パーセンタイルではデスクトップで373バイト、モバイルで323バイトがプッシュされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=971663204&format=interactive",
  sheets_gid="138914513",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql"
  )
}}

アイテムがプッシュされた場合のバイトサイズの中央値は、デスクトップで145KB、モバイルで48KBでした。これが75パーセンタイルになると、デスクトップでは294KBとほぼ倍増し、モバイルでは221KBと4倍以上になっています。トップエンドでは、90パーセンタイルで372KB、モバイルでは323KBがプッシュされていることがわかります。

この90％台の数字は問題ないように見えますが、プッシュ回数を見直すようになると、プッシュ機能の誤用が浮き彫りになってくるのです。

{{ figure_markup(
  image="http2-push-number.png",
  caption="HTTP/2はキロバイトをプッシュしています。",
  description="さまざまなパーセンタイルでモバイルとデスクトップにプッシュされたアセットの数を示す棒グラフ。10パーセンタイルではデスクトップとモバイルの両方で1つのリソースがプッシュされ、25パーセンタイルではそれぞれ2と1、50パーセンタイルでは4と3、75パーセンタイルでは8と8、90パーセンタイルでは21と16になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1039731009&format=interactive",
  sheets_gid="138914513",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql"
  )
}}

プッシュ回数の中央値は、デスクトップとモバイルでそれぞれ4回と3回です。75パーセンタイルでは8回、90パーセンタイルでは21回と16回に跳ね上がります。100パーセンタイルでは、517回と630回という驚くべきプッシュが一部のサイトで行われており、とくにプッシュが本来リクエストの初期に少数の重要なアセットを提供するために設計されたことを考えると、この機能の危険性が浮き彫りになっています。

{{ figure_markup(
  image="http2-push-counts.png",
  caption="HTTP/2のプッシュ回数。",
  description="さまざまなパーセンタイルでモバイルとデスクトップにプッシュされたアセットの数を示す棒グラフ。10パーセンタイルではデスクトップとモバイルの両方で1つのリソースがプッシュされ、25パーセンタイルではそれぞれ2と1、50パーセンタイルでは4と3、75パーセンタイルでは8と8、90パーセンタイルでは21と16になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=1039731009&format=interactive",
  sheets_gid="138914513",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql"
  )
}}

コンテンツの種類別に分析すると、フォントがもっとも多く、次いで画像、CSS、スクリプト、動画の順になっています。この数字は、アセットタイプのサイズを見ると、異なるストーリーを描いています。フォントは依然としてもっとも多く利用されているアセットですが、スクリプトも遠く及ばない程度に利用されています。次いで、画像、動画、CSSの順です。したがって、より多くのCSSファイルがプッシュされているにもかかわらず、そのサイズは小さいということになります。スクリプトは、フォント、画像、CSSほど頻繁にプッシュされていませんが、プッシュされたデータの中ではより大きなボリュームを占めています。

上記の数字が示すように、また以前の記事でも紹介したように、HTTPプッシュは十分に活用されていません。利用されていても、誤用されたり、意図したとおりに使われなかったりすることが多く、エンドユーザーにとってパフォーマンスの障害となる可能性が高いのです。

Googleは、Chromeからプッシュを削除する意向を表明しています。しかし、2021年を通じて、HTTP/2 Pushの有効性については、まだ<a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">継続的な議論</a>が続いていました。この削除はまだ実現しておらず、Pushを正しく実装しているCDNを通じて活用できることが大きく示唆されています。Googleは、Pushの代替手段として `<link rel="preload">` ディレクティブの活用を推奨していますが、それでも1RTTが発生するため、Pushが解決しようとすることは同じです。GoogleもHTTP/3にPushを実装していないと<a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">報告</a>しており、Cloudflareのような他の企業も同様です。

#### プッシュの代替

Pushの代わりによく提案されるのが、<a hreflang="en" href="https://github.com/bashi/early-hints-explainer/blob/main/explainer.md">_アーリーヒント_</a>を使うことです。これは、サーバーに `103` ステータスコード応答メッセージを報告させ、Linkヘッダーに `preload` ヒントを含めることで動作します。アーリーヒントにより、サーバはページのHTMLを取得する前にクライアントが `preload` すべきアセットを報告できます。

```
HTTP/1.1 103 Early Hints
Link: <style.css>; rel="preload"; as="style"
```

<a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">Fastly</a>や<a hreflang="en" href="https://blog.cloudflare.com/early-hints/">Cloudflare</a>などのCDNは、アーリーヒントヒントの実験を行っていますが、アーリーヒントヒントはまだ日が浅いです。この記事を書いている時点ではChrome内のHTTP/2におけるアーリーヒントのサポートはまだ <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=671310">作業中</a> であり、他のブラウザベンダーはアーリーヒントのサポートを発表し、Cloudflareは野放し状態でサポートを導入していますが、他の多くのベンダーはまだ具体的に実装していない状態です。

HTTP/2プッシュの採用が年々増えているにもかかわらず、Googleや他のブラウザベンダーはプッシュのサポートを放棄し、アーリーヒントのような代替手段を選ぶと思われる。CDNからのサポートと相まって、アーリーヒントがその代替となる可能性が高い。昨年、私たちはHTTP/2プッシュに別れを告げるかどうかという問題を提案しました。今年は、少なくともウェブブラウジングのユースケースでは、HTTP/2のメインストリーム利用は死んだと提案します。

## HTTP/3

HTTP/3は、HTTP/2の次の進化であり、その基礎の上に、プロトコル全体にさらなる変更を加えて構築されています。最大の変化は、TCPからQUICと呼ばれるUDPベースのトランスポートプロトコルに移行したことです。これにより、インターネット全体に浸透しているTCPの実装がサポートされるのを待つことなく、HTTPの迅速な進歩が可能になりました。たとえば、HTTP/2は独立したストリームの概念を導入しましたが、TCPレベルではこれらはまだ1つのTCPストリームの一部であり、本当の意味で独立したものではありません。これをサポートするためにTCPを変更することは、安全に使用できるほど広くサポートされるようになるまで、かなりの時間を要するでしょう。そのため、HTTP/3は代替のトランスポートプロトコルに切り替えています。QUICは多くの点でTCPに似ており、基本的にTCPの多くの便利な機能をすべて再構築し、新しい機能を追加しています。QUICは暗号化され、よくサポートされている軽量のUDPトランスポートプロトコルで配信されます。

### HTTP/3の採用

{{ figure_markup(
  image="http3-support-by-ranking.png",
  caption="ランキングによるトップページのHTTP/3対応。",
  description="ランキング別のトップページのHTTP/3対応状況を示す棒グラフ。上位1,000サイトでは13.3%、上位1万サイトで17.4%、上位10万サイトでは19.5%、上位100万サイトは19.2%がHTTP/3を利用しており、全体では15.0%となっています。デスクトップの数字も非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR8JQZybG-hShF-c20MeEPyPBeMbdjcYNWzm4juwcsvtubVk3kKT8KH26D1eEuFpvHbvRXEHZorS0ee/pubchart?oid=197871310&format=interactive",
  sheets_gid="2116042894",
  sql_file="http3_support_by_rank.sql"
  )
}}

この章の前半で、上位にランクされたサイトほどHTTP/2の採用率が、高いことがわかりました。意外なことに、HTTP/3ではその逆が当てはまります。上位1000サイトのサポートは上位100万サイトよりも少なく、モバイルサイトでのサポートがわずかに多く実装されていることがわかります。

上位10万サイトと上位100万サイトでの分布は、デスクトップが18%、モバイルは19%。上位1万サイトでは、16%と17%に低下しています。上位1,000サイトでは、デスクトップとモバイルでそれぞれ11%と13%となっています。上位100万サイトを超えるサイトでは、ホームページへの導入率は15%程度です。全体として、これは非常に強力な採用であり、おそらくいくつかの主要なCDNからのサポートが先導しているのでしょう。このことは、上位のウェブサイトがHTTP/2を主流として採用している一方で、多くのウェブサイトがHTTP/3をまだ探求していないことを示唆しています。

### HTTP/3対応

HTTP/3へのWebサーバーの対応は、まだ市場でも限られています。Nginxはウェブ上でもっとも一般的なHTTPサーバーであり、HTTP/2サイトの約3分の2がNginxのバージョンを使用しています。NginxはHTTP/3のサポートを公に表明しており、<a hreflang="en" href="https://www.nginx.com/blog/our-roadmap-quic-http-3-support-nginx/">ロードマップの議論</a> で完全サポートを展開し、2021年末までに完全サポートを実現することを目指しています。それに比べ、Apacheサーバーは、HTTP/3がいつサポートされるのか、まだ何のガイダンスも出していない。Microsoftは、新しい <a hreflang="en" href="https://blog.workinghardinit.work/2021/10/11/iis-and-http-3-quic-tls-1-3-in-windows-server-2022/">Windows Server 2022</a> でHTTP/3をサポートすることを発表しました。LiteSpeed Webサーバーのような他の代替品は、HTTP/3のサポートに<a hreflang="en" href="https://docs.litespeedtech.com/cp/cpanel/quic-http3/">傾いています</a>が、CaddyはHTTP/3のサポートを <a hreflang="en" href="https://caddyserver.com/docs/caddyfile/options">実験機能</a> として利用できるようにしました。 Node.jsのサポートは、OpenSSLのサポートがないため、<a hreflang="en" href="https://github.com/nodejs/node/pull/37067">保留</a>されています。

また、多くのCDNがHTTP/3のサポートを表明しています。Cloudflareは、<a hreflang="en" href="https://blog.cloudflare.com/http3-the-past-present-and-future/">2019年から</a>HTTP/3の実験を行っており、その中で多くの事例でパフォーマンスが向上していることを報告しています。Cloudflareは、エッジネットワークでのHTTP/3展開を強化する <a hreflang="en" href="https://github.com/cloudflare/quiche">quiche</a>ライブラリも公開しています。Fastlyは、HTTP/3のサポートについても<a hreflang="en" href="https://www.fastly.com/blog/why-fastly-loves-quic-http3">議論しており</a>、<a hreflang="en" href="https://www.fastly.com/blog/modernizing-the-internet-with-http3-and-quic">BETAサービス</a>として利用できるようにしています。Fastlyは、<a hreflang="en" href="https://github.com/h2o/quicly">quicly</a>という独自の実装もオープンソース化しており、Fastlyがエッジネットワークで使用している<a hreflang="en" href="https://h2o.examp1e.net/">H2O HTTP</a>サーバ用に設計されています。Akamaiはまた、HTTP/3とQUICの<a hreflang="en" href="https://www.akamai.com/blog/performance/http3-and-quic-past-present-and-future">継続的なサポート</a>を表明し、マイクロソフト社と協力して <a hreflang="en" href="https://github.com/quictls/openssl">QUICによるOpenSSL</a> のバージョンをフォークし、サポートの<a hreflang="en" href="https://daniel.haxx.se/blog/2021/10/25/the-quic-api-openssl-will-not-provide/">前進</a> を支援しました。

HTTP/3のブラウザサポートは、現在も進化を続けています。2021年10月現在、Microsoft Edge、Firefox、Google Chrome、Operaの最新バージョンでサポートされており、一部のAndroidの亜種とOpera mobileについてはモバイル全体で部分的に利用可能です。SafariからのサポートはmacOS 11 Big Surに限定されており、「実験的機能」を介して有効にする必要があります、iOSのサポートもフラグの後ろにある実験的機能としてのみ利用可能です。

### HTTP/3のネゴシエーション

HTTP/3は従来のTCPベースのHTTPと完全に、異なるトランスポート層にあるので、HTTPSネゴシエーションを通じてHTTP/2で起こるような、接続設定の一部としてHTTP/3をネゴシエートすることはできません。この段階で、あなたはすでにトランスポートプロトコルを選んでいます!

HTTP/3は代わりに`alt-svc`ヘッダーを必要とします。TCPベースのHTTP接続 (クライアントがHTTP/3をサポートするほど高度であれば、おそらくHTTP/2) で開始し、サーバーはリクエストに対するレスポンスで `alt-svc` ヘッダーを通して、このサーバーはUDPとQUIC上のHTTP/3もサポートしていると通知できます。ブラウザはそれを使って接続を試みることを決定できます。HTTP/3のいくつかの繰り返しのために、このヘッダーは、クライアントとサーバーがどのバージョンのHTTP/3に決定することができるかということでもあります。

そのため、最初のケースでは、最初のリクエストでHTTP/2が使用されます。いったんブラウザが `alt-svc` ヘッダーを検出すると、プロトコルを切り替えてHTTP/3を使用し始めることができます。将来のケースでは、ブラウザは `alt-svc` ヘッダーをキャッシュし、次回はHTTP/3を試すために直接ジャンプできます。

{{ figure_markup(
  image="webpagetest-h2-h3-example.jpeg",
  caption="ページロード中にHTTP2からHTTP3に切り替わる様子を示すWebPageTestの例。",
  description="WebPageTestのスクリーンショット。最初のページロードはHTTP2を使用し、`alt-svc` が検出された後、HTTP3に切り替わります。",
  width=1974,
  height=892
  )
}}

また、コネクション合体（コネクションの再利用）により、2つのホスト名がDNS上で同じIPに解決し、同じTLS証明書とバージョンを使用する場合、クライアントは両方のホスト名で同じコネクションを再利用できる場合があります。したがって、使用するホストとTLS証明書の数に応じて、HTTP/2とHTTP/3の両方が混在するウォーターフォール リクエストを目にすることは珍しくありません。

ページレベルでは、リクエストの約15%が `alt-svc` ヘッダーを提供します。これらはQUICを提供する構文、さまざまなH3プレリリースバージョンの1つ（公式にはHTTP/3は執筆時点で標準化されていませんが、非常に最終段階にあります）間で異なります。いくつかのサイトは `quic=":443"; ma=2592000; v="39,43,46,50"` のように複数のバージョンのQUICのサポートを宣伝していますが、中には1つのバージョンしか提供しないサイトもあります。もっとも一般的な `alt-svc` のアドバタイズは `"h3-27=":443"; ma=86400, h3-28=":443"; ma=86400, h3-29=":443"; ma=86400, h3=":443"; ma=86400"` で、すべての `alt-svc` 応答に対して11%に及んでいます。このヘッダーは、HTTP/33バージョン27、28、29をサポートし、 `max-age` が24時間であることをクライアントに指示します。

`alt-svc`がある場合、ほとんどのサイトは新しいプロトコルのバージョンをサポートするようにバージョン番号を追加していますが、[`clear`](https://developer.mozilla.org/docs/Web/HTTP/Headers/alt-svc)ディレクティブを使って以前に宣伝したサポートを無効にしているケースも多く見られました。

この記事の執筆時点では、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-quic-http-34">HTTP/3仕様</a>の最新バージョンは34です。しかし、この最新バージョンを報告している回答は、わずか0.01%です。リクエストレベルで `alt-svc` の詳細を見る場合、レスポンスヘッダーでもっともよく要求されるバージョンは27であす。サーバーは左から右の順に優先されるバージョンを表示します。6%のリクエストでは、最初に `h3-27` が優先され、同じレスポンスで28と29が代替バージョンとして提供されると報告されます。2%のレスポンスは `h3-29` をアップグレードのための唯一の優先バージョンとして提供します。QUICは優先的に更新されるプロトコルですが、わずか0.11% しか受信していません。実際には `h3-29` 以降は技術的にほとんど違いがなく、ほとんどの実装は `h3` の正式リリースを待ってバージョンを凍結していました。

ほとんどの `alt-svc` は `max-age` が24時間しかないと報告しています。これは、指定しない場合のデフォルトです。もっとも長い `alt-svc` の `max-age` は30日または2592000秒でした。

{{ figure_markup(
  image="webpagetest-alt-svc-example.png",
  caption="WebPageTestの `alt-svc` の例。",
  description="WebPageTestのスクリーンショットで、たとえばリクエストから `alt-svc` レスポンスヘッダーを表示しています。",
  width=1032,
  height=552
  )
}}

### HTTP/3に関する考察と懸念

HTTP/3の長所が多く語られる一方で、懸念や批判も指摘されている。多くの開発者は、HTTP/1.1からの制限を克服するために多くのウェブパフォーマンスの回避策をロールバックしなければならず、それらの回避策が後にHTTP/2で <a hreflang="en" href="https://docs.google.com/presentation/d/1r7QXGYOLCh4fcUq0jDdDwKJWNqWK1o4xMtYpKZCJYjM/present?slide=id.p19">アンチパターン</a> となったため、今ようやくHTTP/2から導入した変更に慣れてきたというところです。

場合によっては、開発者とサイトオーナーは、HTTP/3による増分の利益は、ウェブサーバーの大規模なアップグレードに見合わないかもしれないと主張するかもしれません。とくに、HTTP/3が、優先順位付けやサーバープッシュの効果的な使用など、HTTP/2で特定された問題をすべて解決していない場合はなおさらです。そのため、採用はウェブアプリケーション内ではなく、CDNレベルで推進されるかもしれません。これは、いくつかのサーバーがHTTP/3をサポートしないか、OpenSSLのサポート不足によってブロックされる場合、とくにそうなる可能性があります。

この章を通して説明したように、QUICはUDPプロトコルに依存しています。HTTP/3の導入に伴い、UDPのトラフィックはウェブ全体で増加する予定です。しかし、現状ではUDPは<a hreflang="en" href="https://blog.cloudflare.com/reflections-on-reflections/">リフレクション攻撃</a>などの攻撃ベクトルとしてよく利用されています。QUICはいくつかの<a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-quic-transport-27#section-8.1">保護メカニズム</a>を備えていますが、これは、ウェブ上でのUDPの扱いの変更と、あるネットワークとファイアウォールで許可されるUDPトラフィックの量の変更を意味するかもしれません。同じ例で、TCPヘッダーとパケットの非暗号化部分がファイアウォールやウェブ上の他の<a hreflang="en" href="https://ja.wikipedia.org/wiki/Middlebox">ミドルボックス</a>で使用されている場合、採用の後押しがあるかもしれません。QUICはパケットの多くの部分を暗号化するため、パケットに関する検査の可視性が低くなり、追加のセキュリティチェックを行う能力など、これらのミドルボックスの動作が、制限される可能性があります。

また、QUICはサーバー側でパフォーマンスの問題が、発生することが懸念されています。これは、UDPを扱う際に必要となるCPU要件が高くなるためです。HTTP/2と比較した場合、2倍のCPUが必要になるとの試算もあります。とはいえ、<a hreflang="en" href="https://conferences.sigcomm.org/sigcomm/2020/files/slides/epiq/0%20QUIC%20and%20HTTP_3%20CPU%20Performance.pdf">QUIC CPUパフォーマンス</a>を最適化する試みは現在進行形で数多く行われています。

このような懸念はあるものの、本当のメリットはウェブのエンドユーザーから受けることになります。QUICは、ネットワーク接続を切り替えても接続を維持できるため、モバイルファーストの世界でもモバイルファーストの体験を可能にします。ヘッドオブラインブロッキングの改善により、ページロードがより向上し、<a hreflang="en" href="https://ai.googleblog.com/2009/06/speed-matters.html">1ミリ秒</a>が重要であることを私たちは知っています。また、QUICが導入する強化された暗号化により、より安全でセキュアなWebを実現できます。また、HTTP/3では0-RTTが可能であるため、パフォーマンスの向上も期待できます。

## 結論

本章を通じて、私たちはHTTP/2の採用が増加していることと、より新しいバージョンのプロトコルが提供する利点に主な焦点を当てながら、HTTPの進化を見てきました。続いて、HTTP/3について詳しく見ていき、バージョン3がウェブ上で数年間HTTP/2が使用された後に特定された懸念の多くをどのように解決することを目指しているかを見てきました。

HTTP Archiveのデータによると、今年はHTTP/2の採用が大きく進み、リクエストの72%がHTTP/2を使用し、ベースとなるHTMLページの59%がHTTP/2を使用していることがわかります。この採用は、CDNプロバイダーによる採用の増加が主な要因となっています。HTTP/1.1はウェブ上で少数派となっています。

HTTP/2の普及にもかかわらずHTTP/2のプッシュ機能は、実装の複雑さのために十分に活用されていないままであり、私たちは、プッシュは実際に到着時に死んでいる可能性があることを示唆しています。同時に、リソースの優先順位付けに関する継続的な懸念や、主要なCDNベンダー以外の不正な実装が見られます。優先順位付けの複雑さは、HTTP/3仕様から削除されるほど、依然として広まっています。

2021年は、HTTP/3の採用に関しても詳しく検証することができました。GoogleやFacebookなどの主要プレイヤーは、数年前からHTTP/3のサポートを独自に展開しています。HTTP/3のより広い採用は、ウェブの他の部分に対するHTTP/3のサポートへ公に取り組んできたAkamai、Cloudflare、Fastlyによって影響されています。

HTTP/3はTCPに課せられたヘッドオブラインブロッキングなど、HTTP/2の改善点をベースにしつつ、QUICのTLS 1.3のより厳密なカプセル化により、プロトコルスタックのより多くの部分の安全性を確保することを目的としています。しかし、HTTP/3はまだ初期段階です。私たちは2022年にHTTP/3の採用を測定することを楽しみにしており、HTTP/2のサポートが主流になり、人々が現在の展開よりもさらなる改善を得たいと考えるようになるにつれて、さらに牽引される可能性が高いと信じています。

HTTP/3にはいくつかの懸念が示されていますが、これらの懸念のいずれもが、エンドユーザーへ得られるパフォーマンスによって打ち消されるはずです。HTTP/3の採用は、HTTP/2で見られたように、CDNが独自の実装に向けて取り組むことで、CDNのロールアウトによって促進される可能性もあります。とくに、主要なウェブフレームワークでの実装はまだ確認されていません。また、今後数年間は、HTTP/2とHTTP/3が混在することになると思われます。
