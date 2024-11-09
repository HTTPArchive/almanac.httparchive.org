---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: 2021年版Web AlmanacのCDNの章では、CDNの採用、トップCDNプレーヤー、CDNがTLS、HTTP/2+、Brotliの採用に与える影響について解説しています。
authors: [Navaneeth-akam]
reviewers: [jzyang, boosef]
analysts: [paulcalvano]
editors: [jzyang, shantsis]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1DL7Pn1vbBwYmQZ5JPAjD69oCOvUidbuoNvdrw%2D%2Dj00U/
Navaneeth-akam_bio: Navaneeth Krishna は、大手 CDN プロバイダーである <a hreflang="en" href="https://www.akamai.com/">Akamai</a> でウェブパフォーマンス・アーキテクトを務めています。CDN 業界で 10 年以上の経験を持つ同氏は、CDN が今後数年間のインターネットの成長に不可欠な要素になり、注目すべき空間になると確信しています。彼のツイートは[@Navanee55755217](https://x.com/Navanee55755217)で見ることができます。
featured_quote: CDNは20年以上前から存在しています。オンラインビデオの消費、オンラインショッピング、COVID-19によるビデオ会議の増加などにより、インターネットトラフィックが急激に増加しているため、CDNは以前にも増して必要とされています。
featured_stat_1: 62.3%
featured_stat_label_1: CDNを利用している人気サイト上位1,000件
featured_stat_2: 3x
featured_stat_label_2: p90でのCDNとのTLSネゴシエーションの高速化
featured_stat_3: 42.5%
featured_stat_label_3: CDNでBrotliを使用するドメイン
---

## 序章

_コンテンツ配信ネットワーク_（CDN）は、データセンターに設置されたプロキシサーバーの地理的な分散ネットワークです。CDNの目的は、ウェブコンテンツに高い可用性とパフォーマンスを提供することです。CDNは、コンテンツをエンドユーザーの近くに配信することで、これを実現します。

CDNは20年以上前から存在しています。オンラインビデオの消費、オンラインショッピング、COVID-19によるビデオ会議の増加により、インターネットトラフィックが急激に増加しているため、CDNは以前にも増して必要とされています。CDNは、このようなインターネットトラフィックの増加にもかかわらず、高い可用性と優れたウェブパフォーマンスを保証しています。

初期の頃は、CDNはプロキシサーバーの単純なネットワークでした。

1. コンテンツ（HTML、画像、スタイルシート、JavaScript、動画など）をキャッシュする。
2. エンドユーザーがコンテンツにアクセスする際のネットワークホップを減らすことができる
3. ウェブプロパティをホストするデータセンターからTCPコネクションの終了をオフロードする

主にウェブ所有者がページのロード時間を改善し、これらのウェブプロパティをホストするインフラからトラフィックをオフロードするのに役立っています。

時を経て、CDNプロバイダーが提供するサービスは、キャッシュや帯域/接続のオフロードにとどまらず、進化を遂げています。現在、彼らは以下のような追加サービスを提供しています。

* クラウドホスティング型Webアプリケーションファイアウォール
* ボットマネジメントソリューション
* クリーンパイプソリューション（データセンターのスクラビング）
* サーバーレス・コンピューティングの提供
* 画像・映像管理ソリューションなど

このように、最近のウェブオーナーは、多くの選択肢の中から選ぶことができるのです。CDNが提供する新しいサービスは、アプリケーションの延長線上にあり、アプリケーション開発のライフサイクルと密接に統合する必要があるため、これは圧倒的で複雑なものとなり得ます。

Webアプリケーションのロジックやワークフローをエンドユーザーに近づけることは、Webオーナーにとってメリットがあります。これにより、HTTP/HTTPSリクエストにかかる往復の時間と帯域幅が不要になります。また、オリジンのスケーラビリティ要件も、ほぼ瞬時に処理できます。この副次的効果として、インターネットサービスプロバイダー（ISP）もスケーラビリティ管理の恩恵を受け、インフラストラクチャーの能力を向上させることができます。

このリクエストの減少により、インターネットのバックボーンへの負荷が軽減されます（[インターネットのミドルマイルを読む](https://en.wikipedia.org/wiki/Middle_mile)）。また、インターネットのラストワンマイル内のインターネット負荷のより多くを管理するのに役立ちます。このように、CDNは、ウェブ所有者がコンテンツ配信のパフォーマンス、信頼性、スケーラビリティを向上させることができるため、インターネットの状況において多面的な役割を担っているのです。

### 注意事項・免責事項

観察研究と同様、測定可能な範囲と影響には限界があります。Web Almanacのために収集したCDNの使用に関する統計は、使用中の適用可能なテクノロジーに重点を置いており、特定のCDNベンダーのパフォーマンスや有効性を測定することを意図したものではありません。このため、どのCDNベンダーにも偏ることはありませんが、より一般的な結果であることを意味します。

これらは、私たちのテスト[方法論](./methodology)の限界です。

- **ネットワーク遅延のシミュレーション:** トラフィックを合成的に形成する専用のネットワーク接続を使用しています。

- **単一の地理的な場所:** テストは単一のデータセンターから実行され、多くのCDNベンダーの地理的分散をテストすることはできません。

- **キャッシュの有効性:** 各CDNは独自の技術を使用しており、セキュリティ上の理由からキャッシュの性能を公開していないものが多くあります。

- **ローカライゼーションと国際化:** 地理的分布と同様に、言語や地域固有のドメインの影響も、これらのテストでは不透明です。

- **CDN検出:** これは主にDNSの解決とHTTPヘッダーによって行われます。ほとんどのCDNは、ユーザーを最適なデータセンターにマッピングするためDNS CNAMEを使用します。しかし、一部のCDNはエニーキャストIPを使用したり、DNSチェーンを隠す委任ドメインから直接A+AAAA応答を使用したりします。また、ウェブサイトが複数のCDNを使用してベンダー間のバランスを取っている場合もあり、この場合はクローラーのシングルリクエスト・パスからは見えません。

これらはすべて、私たちの測定に影響を与えるものです。

もっとも重要なことは、これらの結果はサイトごとの特定の機能（たとえば、TLS、HTTP/2など）の利用状況を反映していますが、実際のトラフィック利用状況を反映していないことです。YouTubeは "www.example.com "よりも人気がありますが、利用率を比較すると、どちらも同じ値として表示されます。

これを踏まえて、CDNの文脈では意図的に測定していない統計データをいくつか紹介します。

1. 先頭バイトまでの時間 (TTFB)
2. CDN往復時間
3. コアウェブ・バイタル
4. キャッシュヒットとキャッシュミスのパフォーマンスなど。

これらのうちいくつかはHTTP Archiveデータセットで、その他はCrUXデータセットで測定できますが我々の方法論の限界と、いくつかのサイトが複数のCDNを使用していることから測定が困難で、その結果誤った帰属をする可能性があります。これらの理由から、この章ではこれらの統計を測定しないことにしました。

## CDN採用

Webページのコンテンツは、大きく3つに分けられます。

1. ベースとなるHTMLページ (たとえば、`www.example.com`)
2. サブドメインに埋め込まれたファーストパーティコンテンツ（たとえば、`images.example.com`、`css.example.com`など。）
3. サーとパーティーコンテンツ（Google Analytics、広告など。）

CDNは、設立当初から、画像、スタイルシート、JavaScript、フォントなどの埋め込みコンテンツを配信するための最適なソリューションとして利用されてきました。この種のコンテンツは頻繁に変更されないので、CDNのプロキシサーバーへキャッシュするのに適しています。

CDN技術の進化に伴い、インターネット上に非キャッシュ資産のための高速道路が設置されました。これにより、オリジンへのTCP接続に比べ、メインのWebページやAPIを確実かつ高速に、配信できるようになりました。

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="CDNの使用とホスティングされたリソースの比較。",
  description="CDNの使用量とホストされたリソースのオリジンおよびCDNによる分割の棒グラフ。HTMLコンテンツでは、リクエストの73.1%がオリジンから、26.9%がCDNからとなっています。サブドメインコンテンツの場合、62.4%がオリジン、37.6%がCDNです。また、サードパーティーコンテンツでは、オリジンが37.2％、CDNが62.8％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=2109227821&format=interactive",
  sheets_gid="1173657471",
  sql_file="top_cdns.sql"
  )
}}

その影響は、[2019年版](../2019/cdn)の同データと比較すると、上のグラフのようにわかります（注、2020年版Web AlmanacにはCDNの章がありませんでした）。CDNを利用しているサイトの傾向が、2019年から2021年にかけて7％改善されたのは良いことです。これは、より多くの業界がCDNを活用して、安定したコンテンツ配信時間の恩恵を受け、インターネット上の混雑の影響を最小限に抑えていることを示しています。

サードパーティコンテンツを見ると、CDN採用がマイナス成長となっています。[2019年の章](../2019/cdn)と比較すると、CDNを利用しているドメインが3％減少していることが分かります。サードパーティドメインは、SaaSベンダーが分析、広告、レスポンシブページなどのために使用しています。SaaSベンダーのサービスにCDNを利用することは、SaaSベンダーにとって利益となります。SaaSベンダーのコンテンツは複数のウェブ所有者によって利用され、そのコンテンツは地域を超えてエンドユーザーによってアクセスされるため、ビジネスとパフォーマンスの両方の観点からCDNが必要なのです。このことは、サードパーティのコンテンツがCDNをもっとも高く採用していることが明らかなグラフに表れています。

しかし、なぜサードパーティドメインのCDN Adoptionがこのようにネガティブな成長を見せるのでしょうか。

その理由として考えられるのは、以下の通りです。

* HTTP/2プロトコルは、最適なパフォーマンスを得るために、ウェブオーナーが複数のドメインを使用するのではなく、ドメインを統合することを要求している
* サードパーティーのコンテンツがページの総重量に占める割合も年々増加しており（詳細は[サードパーティー](./third-parties)の章を参照）、ウェブオーナーのページロード時間に対する懸念が高まっている。
* ウェブオーナーの要求に合わせたサードパーティ製スクリプトのカスタマイズ/パーソナライズ

このような変化により、SaaSベンダーはウェブオーナーに「セルフホスティング」オプションを提供するようになりました。これにより、ベンダーのドメインではなく、ファーストパーティのドメイン上で配信されるコンテンツが増えることになります。この場合、CDNを経由してコンテンツを配信するか、ホスティングインフラから直接配信するかは、ウェブオーナー次第です。

さまざまな種類のコンテンツでCDN導入を観測していますが、以下ではこのデータを別の視点から見ていきます。

{{ figure_markup(
  image="cdn-usage-ranking-desktop.png",
  caption="サイトの人気度によるCDN利用状況（デスクトップ）。",
  description="この棒グラフは、Google CRUXのデータに基づき、デスクトップサイトのCDN利用率を上位1,000、10,000、100万、およびすべての人気サイトに分類して表示したものです。上位1,000サイトのCDN利用率は62.3％、上位10,000サイトは56.7％、上位10万サイトは45.5％、上位100万サイトは32.8％、全サイトは27.1％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=956770395&format=interactive",
  sheets_gid="414030881",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

{{ figure_markup(
  image="cdn-usage-ranking-mobile.png",
  caption="サイトの人気度別のCDN利用状況（モバイル）。",
  description="この棒グラフは、Google CRUXのデータに基づき、モバイルサイトのCDN利用率を上位1,000、10,000、100万、およびすべての人気サイトに分類して表示したものです。上位1,000サイトのCDN利用率は61.1％、上位10,000サイトは57.1％、上位10万サイトは46.3％、上位100万サイトは33.7％、全サイトは26.9％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1707360768&format=interactive",
  sheets_gid="414030881",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

Webサイトのウェブ上での人気度に基づいてランキング（Googleの[Chrome UX Report](./methodology#chrome-ux-report)から引用）し、CDNの利用状況を調べたところ、上位1,000位までのサイトはもっともCDNの利用率が、高いことがわかりました。上位のウェブサイトは、GoogleやAmazonのような大企業が所有しており、今日我々が目にするインターネットトラフィックの多くに貢献しています。したがって、これらの名前が次のセクションの[トップCDNプロバイダー](#トップcdnプロバイダー)のリストに掲載されているのは当然のことなのです。これは、CDNが大規模に運用され、必要に応じてさらに拡張できる能力を持つことでもたらされる利点についての事実も裏付けています。

{{ figure_markup(
  caption="モバイルサイト上位1,000サイトのうち、CDNを利用している割合。",
  content="61.1%",
  classes="big-number",
  sheets_gid="414030881",
  sql_file="cdn_usage_by_site_rank.sql"
)
}}

CDN採用率は、上位10万サイトを見ると50%を切りますが、それ以上では減少率が鈍化します。全データセット（デスクトップで620万サイト、モバイルで750万サイト）では、これらのウェブサイトの27%がCDNを使用しています。この割合を実際の数字に置き換えると、200万ものモバイルサイトがCDNを利用していることになります。このように考えてみると、それほど小さな数字ではありません。

しかし、CDNの利点（キャッシュやTCP接続のオフロードなど）がウェブプロパティのエンドユーザー数とともに増加することを考えると、人気のないウェブサイトエンドでのCDN採用の割合が減少することは理にかなっていると言えるでしょう。ウェブプロパティのエンドユーザーのトラフィックが一定規模以下になると、CDNの費用対効果の計算がうまくいかなくなり、ウェブコンテンツをオリジンから直接配信したほうが、よくなる可能性があるのです。

## トップCDNプロバイダー

CDNプロバイダーは、大きく2つのセグメントに分類されます。

1. 汎用CDN（Akamai、Cloudflare、Fastlyなど）。
2. 目的別CDN（Netlify、WordPressなど）

Generic CDNは、マスマーケットの要求に応えます。その提供するものは以下の通りです。

* Webサイト配信
* モバイルアプリAPI配信
* ビデオストリーミング
* サーバーレスコンピュートの提供
* Webセキュリティの提供など

これは、より多くの業界にアピールするものであり、データにも反映されています。HTMLとファーストパーティサブドメインのトラフィックは、ジェネリックCDNが大部分を占めています。

{{ figure_markup(
  image="top-cdns.png",
  caption="HTMLリクエストのトップCDN。",
  description="HTMLリクエストに対応するCDNプロバイダーの上位を示すボックスプロット。CloudflareがHTMLリクエストの50.1%を配信してトップとなり、Googleが24.8%、Fastly 8.5%、CloudFront 5.9%、Akamai 3.1%で続いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1907738479&format=interactive",
  sheets_gid="1173657471",
  sql_file="top_cdns.sql"
  )
}}

Cloudflare、Fastly、Akamai、LimelightなどのCDNプロバイダーがこのGeneric CDN providersのリストに表示されます。また、GoogleやAWSのようなプロバイダーも含まれています。これらのプロバイダーは、クラウドホスティングサービスにバンドルされたCDNサービスを提供しているため、このリストに掲載されています。これらのバンドルは、ホスティングインフラの負荷を軽減し、ウェブパフォーマンスを向上させるのに役立つ。

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="サブドメインリクエストの上位CDN。",
  description="サブドメインリクエストに対応するCDNプロバイダーの上位を示すボックスプロット。Cloudflareがサブドメインリクエストの42.9%を配信してトップとなり、CloudFrontが19.4%、Automattic 8.7%、Akamai 6.4%、Google 4.3%と続いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1727439047&format=interactive",
  sheets_gid="1173657471",
  sql_file="top_cdns.sql"
  )
}}

以下のサードパーティードメインを見ると、トップCDNプロバイダーの傾向が異なっていることがわかります。一般的なCDNプロバイダーの前にGoogleがトップになっているのがわかります。また、このリストでは、Facebookも目立っています。これは、多くのサードパーティードメインの所有者が、他の業界よりもCDNを必要としているという事実に裏打ちされています。そのため、彼らは専用のCDNを構築するために投資する必要があるのです。目的別CDNとは、特定のコンテンツ配信ワークフローに最適化されたCDNのことです。

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="サードパーティからのリクエストに対応するトップCDN。",
  description="サードパーティのリクエストに対応するCDNプロバイダーの上位を示すボックスプロット。Googleがサードパーティリクエストの48.0%を配信してトップとなり、CloudFrontが11.2%、Cloudflare 10.1%、Fastly 7.8%、Facebook 7.1%と続いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1676004971&format=interactive",
  sheets_gid="1173657471",
  sql_file="top_cdns.sql"
  )
}}

たとえば、広告配信に特化して構築されたCDNは、最適化されます。

- 高い入出力（I/O）動作
- [ロングテール](https://ja.wikipedia.org/wiki/%E3%83%AD%E3%83%B3%E3%82%B0%E3%83%86%E3%83%BC%E3%83%AB) コンテンツの効果的な管理方法
- サービスを必要とする企業との地理的な近さ

つまり、汎用CDNソリューションとは対照的に、専用CDNは特定の市場セグメントの要件を正確に満たしているのです。汎用的なソリューションは、より広範な要件を満たすことができますが、特定の業界や市場向けに最適化されているわけではありません。

## TLS採用の影響

リクエスト・レスポンス型のワークフローでCDNをセットアップすると、エンドユーザーのTLS接続はCDNで終了します。一方、CDNは2つ目の独立したTLS接続をセットアップし、この接続はCDNからオリジンホストに送られます。CDNワークフローにおけるこのブレークにより、CDNはエンドユーザーのTLSパラメーターを定義できます。CDNはまた、インターネットプロトコルの自動更新を提供する傾向があります。これにより、ウェブオーナーはオリジンに変更を加えることなく、これらの利点を享受できます。

{{ figure_markup(
  image="tls-version-desktop.png",
  caption="HTML（デスクトップ）用TLSバージョンの配布。",
  description="CDNとオリジンが提供したデスクトップリクエストにおけるTLSバージョンの使用率の棒グラフ。CDNは、TLS 1.3を使用したリクエストの82.3%、TLS 1.2のリクエストの17.7%を配信しました。一方、OriginはTLS 1.3を使用したリクエストの33.3%、TLS 1.2を使用したリクエストの66.3%を配信しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1914791224&format=interactive",
  sheets_gid="1492712705",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="HTML（モバイル）用TLSバージョンの配布。",
  description="CDNとオリジンが提供するモバイルリクエストにおけるTLSバージョンの使用率の棒グラフ。CDNはTLS 1.3を使用したリクエストの83.8%、TLS 1.2を使用したリクエストの16.2%を配信しています。一方、オリジンでは、TLS 1.3を使用したリクエストの36.0%、TLS 1.2を使用したリクエストの63.7%が提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=586006642&format=interactive",
  sheets_gid="1492712705",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

上のデータを見ると、オリジンでは33-36%であるのに対し、CDNでは83%のウェブサイトがTLS 1.3を使用していることがわかります。これは、CDNを利用する大きなメリットです。また、これらのプロトコルのアップグレードは、ウェブオーナーにとって最小限の労力で行うことができます。この傾向は、モバイルおよびデスクトップのWebサイトでも同じです。

同様の傾向は、以下のサードパーティードメインでも観察されます。CDNを持つこれらのウェブサービスは、同じ理由で、持たないものに比べてTLS 1.3の採用率が高いです。

{{ figure_markup(
  image="tls-version-desktop-3p.png",
  caption="サードパーティからの要求に対するTLSバージョンの配布（デスクトップ）。",
  description="デスクトップ上のサードパーティリクエストにおけるTLSバージョン使用率の棒グラフ（CDNとオリジンによって提供）。CDNはTLS 1.3を使用したサードパーティリクエストの88.1%、TLS 1.2のリクエストの11.9%を配信しています。一方、OriginはTLS 1.3を使用したリクエストの40.3%、TLS 1.2を使用したリクエストの59.5%を配信しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1414975613&format=interactive",
  sheets_gid="1492712705",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="サードパーティリクエスト用TLSバージョンの配布（モバイル）。",
  description="モバイルでのサードパーティリクエストにおけるTLSバージョン使用率の棒グラフ（CDNとオリジンによる提供）。CDNはTLS 1.3を使ったサードパーティリクエストの88.5%、TLS 1.2を使ったリクエストの11.5%を配信しています。一方、オリジンは、TLS 1.3を使用したリクエストの39.4%、TLS 1.2を使用したリクエストの60.4%を配信しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=647850030&format=interactive",
  sheets_gid="1492712705",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

サードパーティのドメインは、セキュリティ上の理由から、最新のTLSバージョンであることが重要です。ウェブ攻撃の増加に伴い、ウェブ所有者はサードパーティドメインへの安全でない接続で悪用される可能性のある抜け穴に気づいています。そのため、Webサイトのセキュリティとパフォーマンスの要件を満たす、安全なTLS接続を期待するようになります。このような期待から、CDNがもたらすメリットはますます大きくなっています。

## TLSのパフォーマンスへの影響

一般的な論理で、HTTPSのリクエストとレスポンスは通過するホップ数が少なければ少ないほど、ラウンドトリップが速くなると考えられています。では、TLS接続の終端がエンドユーザーの近くにある場合、正確にはどのくらい速くなるのだろうか？答えは、「3倍」です。なんと3倍も速くなるのです

{{ figure_markup(
  image="tls-negotiation.png",
  caption="HTML TLSネゴシエーション - CDN vs. オリジン。",
  description="この棒グラフは、CDNとオリジンの10、25、50、75、90パーセンタイルのTLS接続時間（ミリ秒単位）を示しています。CDNでは、TLS接続時間は54ms、58ms、63ms、76ms、142msであり、オリジンのTLS接続時間はこれらのパーセンタイルでそれぞれ83ms、125ms、183ms、237ms、370msとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1928148559&format=interactive",
  sheets_gid="603895236",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

CDNはTLSの接続時間を短縮するのに役立っています。これは、エンドユーザーとの距離が近いことと、TLSネゴシエーションを最適化する新しいTLSプロトコルを採用していることが要因です。CDNは、すべてのパーセンタイルでオリジンより優位に立っています。P10とP25では、CDNはTLSセットアップ時間においてオリジンより1.5倍から2倍近くも高速です。中央値以上になるとさらに差が広がり、CDNは3倍近く速くなります。CDNを利用する90パーセンタイルのユーザーは、オリジンとの直接接続を利用する50パーセンタイルのユーザーよりも優れたパフォーマンスを発揮できます。

最近、すべてのサイトがTLSを使用しなければならないことを考えると、これは非常に重要です。このレイヤーでの最適なパフォーマンスは、TLS接続に続く他のステップに不可欠です。この点で、CDNは直接オリジン接続と比較して、より多くのユーザーを低いパーセンタイルブラケットに移動させることが可能です。

## HTTP/2+（HTTP/2以上）の採用

HTTP/2は、多くの誇大広告と期待とともに導入されました。アプリケーション層のプロトコルは、1997年のHTTP 1.1以来、更新されていなかったからです。それ以来、ウェブのトラフィック傾向、コンテンツタイプ、コンテンツサイズ、ウェブサイトデザイン、プラットフォーム、モバイルアプリなどが大きく進化してきました。そこで、現代のWebトラフィックの要求に応えられるプロトコルが必要となり、HTTP/2で実現し、さらに最新のHTTP/3で改良されました。

しかし、HTTP/2の実装上の課題により、採用が見送られました。さらに、これらの変更で期待できる正味の性能向上も明確ではありませんでした。この課題は、HTTP/3の導入でも繰り返されました。

そこで、CDNが仲介することで、ウェブオーナーのHTTP/2実装の課題を解決することができるのです。HTTP/2接続はCDNレベルで終了するため、ウェブ所有者は、それをサポートするためにインフラをアップグレードする必要なく、HTTP/2でウェブサイトとサブドメインを配信する能力を提供します - 新しいTLSバージョンで見たのとまったく同じ理由と利点があります。

CDNはホスト名を統合するレイヤーを提供し、ホスティングインフラへの変更を最小限に抑えながら、トラフィックを関連するエンドポイントにルーティングすることで、ギャップを埋めるプロキシとして機能する。キュー内のコンテンツの優先順位付けやサーバープッシュなどの機能はCDN側で管理することができ、いくつかのCDNはウェブサイトの所有者からの入力なしにこれらの機能を実行する、手動の自動ソリューションさえ提供しており、したがってHTTP/2の採用を後押ししています。

この傾向は、以下のグラフが示すもの以上に明確なものではありません。CDNを利用しているドメインでは、利用していないドメインと比較して、高いHTTP/2+の採用率が見られます。

<p class="note">HTTP/3の動作方法(より多くの情報のための[HTTP](./http)の章を参照)のために、HTTP/3はしばしば最初の接続に使われないので、それらのHTTP/2接続の多くが実際にリピート訪問者のためのHTTP/3であるかもしれないので、我々は代わりに「HTTP/2＋」を測定していることに注意します(我々は、HTTP/3を実装しないサーバーがないと仮定しました。).</p>

{{ figure_markup(
  image="http-versions-desktop.png",
  caption="HTML（デスクトップ）用HTTPバージョンの配布。",
  description="この棒グラフは、デスクトップHTMLリクエストにおけるCDNとオリジンでのHTTPバージョン採用率を示しています。CDNから提供されたデスクトップHTMLリクエストでは、86.1%がHTTP/2以上のプロトコルで提供され、オリジンから提供されたリクエストでは39.2%のリクエストがHTTP/2以上のプロトコルで提供されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=707070598&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="http-versions-mobile.png",
  caption="HTML（モバイル）用HTTPバージョンの配布。",
  description="この棒グラフは、モバイルHTMLリクエストにおけるCDNとオリジンでのHTTPバージョン採用率を示しています。CDNから提供されたモバイルHTMLリクエストでは、81.7%がHTTP/2またはより良いプロトコルで提供され、オリジンから提供されたリクエストでは39.8%がHTTP/2またはより良いプロトコルで提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=825211868&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

2019年当時、HTTP/2の採用率はオリジンドメインが27%だったのに対し、CDN上のドメインは71%でした。デスクトップサイトでは、2021年にHTTP/2+をサポートするオリジンが約14%増加していることがわかりますが、CDN上のドメインは15%増加し、そのリードを維持しています。この差はモバイルサイトを見ると、CDNを利用しているドメインは、デスクトップサイトと比較して、HTTP/2+の採用率が若干低くなっていることがわかります。

{{ figure_markup(
  image="http-versions-desktop-3p.png",
  caption="サードパーティリクエスト用HTTPバージョンの配布（デスクトップ）。",
  description="この棒グラフは、デスクトップ上のサードパーティーのリクエストに対する、CDNとオリジンでのHTTPバージョン採用を示しています。CDNから提供されたこれらのサードパーティーのリクエストでは、90.0%がHTTP/2またはより良いプロトコルで提供され、オリジンから提供されたリクエストでは48.5%がHTTP/2またはより良いプロトコルで提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=315993105&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="http-versions-mobile-3p.png",
  caption="サードパーティからのリクエストに対応したHTTPバージョンの配布（モバイル）。",
  description="この棒グラフは、モバイルでのサードパーティーのリクエストに対するCDNとオリジンでのHTTPバージョン採用率を示しています。CDNから提供されたこれらのサードパーティーのリクエストの90.4%はHTTP/2またはより良いプロトコルで提供され、オリジンから提供されたリクエストは43.7%がHTTP/2またはより良いプロトコルで提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=351977017&format=interactive",
  sheets_gid="1197207175",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

新しいプロトコルをサポートするサードパーティのドメインを見ると、ファーストパーティのドメインと比較して、HTTP/2+プロトコルの採用率が高いという興味深い傾向が見受けられます。これは、上位のサードパーティードメインのほとんどが専用のCDNを使用しているため、コンテンツの開発とコンテンツ配信をよりコントロールできるという事実を考慮すると、理にかなっていると言えます。さらにサードパーティードメインは、あらゆるネットワーク状況下で一貫したパフォーマンスを発揮する必要があり、そこでHTTP/2+は、従来のTCP接続に加えてUDP（HTTP/3で使用）などの他のプロトコルを混ぜることで価値を高めているのです。

2019年のことですが、UberはTCP（HTTP/3のトランスポート層であるQUIC）とともにUDPがどのように安定したパフォーマンスでコンテンツを配信し、混雑度の高いモバイルネットワークでのパケットロスを克服できるかを理解するための実験を行いました。<a hreflang="en" href="https://eng.uber.com/employing-quic-protocol/">このブログ</a>で文書化されているこの実験の結果は、HTTP/3が役立つ層について貴重な洞察を投げかけています。このトレンドは時間とともに浸透し、とくにモバイルネットワークのトラフィックがインターネットトラフィック全体に占める割合が高くなっていることから、ウェブオーナーがHTTP/3を採用するようになるはずです。

## Brotli採用

インターネット上で配信されるコンテンツは、ペイロードサイズを小さくするために圧縮を採用しています。ペイロードが小さくなれば、サーバーからエンドユーザーへのコンテンツ配信がより速く行えるようになります。これにより、Webサイトの読み込みが速くなり、より良いエンドユーザー体験を提供できます。画像の場合、この圧縮はJPEG、WEBP、AVIFなどの画像ファイル形式によって処理されます（これについては、[メディア](./media)の章を参照してください）。テキスト形式のWeb資産（HTML、JavaScript、スタイルシートなど）の圧縮は、従来は[_Gzip_](https://ja.wikipedia.org/wiki/Gzip)というファイル形式で処理されていた。Gzipは1992年から存在しています。それはテキスト資産のペイロードを小さくするのに良い仕事をしましたが、新しいテキスト資産圧縮はGzipより良いことができます: [_Brotli_](https://ja.wikipedia.org/wiki/Brotli)（詳細は[圧縮](./compression)の章を参照してください）。

TLSやHTTP/2の採用と同様に、Brotliもウェブプラットフォーム全体で徐々に採用される段階を経ました。この記事の執筆時点で、Brotliは<a hreflang="en" href="https://caniuse.com/brotli">世界中の96%</a>のウェブブラウザでサポートされています。しかし、すべてのWebサイトがBrotli形式でテキスト資産を圧縮しているわけではありません。これは、サポートが十分でないことと、Gzip圧縮に比べてBrotli形式でテキストアセットを圧縮するのに必要な時間が長いことの両方が理由です。また、ホスティングインフラストラクチャーは、Brotli形式をサポートしていない古いプラットフォーム向けにGzip圧縮されたアセットを提供するために下位互換性を持つ必要があり、複雑さを増す可能性があります。

この影響は、CDNを利用しているWebサイトと利用していないWebサイトを比較した場合に確認できます。

{{ figure_markup(
  image="compression-desktop.png",
  caption="圧縮タイプの分布（デスクトップ）。",
  description="この棒グラフは、デスクトップリクエストにおけるCDNとオリジンでのBrotliの採用率を示しています。CDNは、42.5%のリクエストをBrotli圧縮形式で、57.5%のリクエストをgzip圧縮形式で処理しました。一方、オリジンでは、20.7%のリクエストをBrotli圧縮形式で、79.3%のリクエストをgzip圧縮形式で配信しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=914242768&format=interactive",
  sheets_gid="1196940164",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="compression-mobile.png",
  caption="圧縮タイプの分布（モバイル）。",
  description="この棒グラフは、モバイルリクエストにおけるCDNとオリジン間のBrotliの採用率を示しています。CDNは、42.6%のリクエストをBrotli圧縮形式で、57.3%のリクエストをgzip圧縮形式で配信しています。一方、オリジンでは、21.2%のリクエストをBrotli圧縮形式で、78.7%のリクエストをgzip圧縮形式で配信しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzfIy4p9ujiLHb9T6GpyDE9j7Pni5vBirHhsD53y5my_U4grve1zE4jTWdqGmmXtZahnBOzFeoil52/pubchart?oid=1852382089&format=interactive",
  sheets_gid="1196940164",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

デスクトップとモバイルの両プラットフォームにおいて、オリジンから配信されるドメインと比較して、CDNはBrotliで2倍のテキストアセットを配信していることがわかります。先ほど取り上げた[CDN採用](#cdn採用)のセクションから、サイトを配信するドメインの73%はCDNであり、これらはすべてBrotli圧縮の恩恵を受けることができます。Brotli形式のテキスト資産を圧縮するための計算負荷をCDNにオフロードすることで、ウェブサイトの所有者はホスティングインフラのためのリソースを投資する必要がありません。

しかし、CDNでBrotli圧縮を使用するかどうかは、ウェブプロパティの所有者の裁量に任されています。全世界のウェブブラウザの95％がBrotli圧縮をサポートしているのに比べ、CDNを導入していてもBrotli形式で配信されているテキスト資産は全体の半分以下であり、この採用率は明らかに改善する余地があります。

## 結論

CDNを裏で動かしている秘密のソースを知ることは難しいため、外部からCDNについて推論できる洞察には限界があります。しかし、私たちはドメインをクロールし、CDNを利用しているものとそうでないものを比較しました。CDNは、ネットワーク層からアプリケーション層まで、Webサイトが新しいWebプロトコルを採用することを可能にするものであったことがわかります。

この影響は普遍的で、モバイルとデスクトップで同様の採用率となっています。最新のTLSバージョンの使用から、最新のHTTPバージョン（HTTP/2やHTTP/3など）へのアップグレード、Brotli圧縮の使用まで、多岐にわたります。注目すべきは、このインパクトの大きさと、CDNドメインが非CDNドメインに対して築いてきた大きなリードです。

CDNのこのような役割は非常に価値があり、今後もこの傾向は続くと思われます。CDNプロバイダーは、<a hreflang="en" href="https://www.ietf.org/">インターネット技術委員会</a> の重要な一員でもあり、インターネットの未来を形作る手助けをしています。今後も、インターネットを活用した産業の円滑な運営を、確実かつ迅速に支援する重要な役割を担っていくことでしょう。
