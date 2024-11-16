---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: 2022年のWeb AlmanacのCDN章では、CDNの採用、主要なCDNプレイヤー、CDNがTLS、HTTP/2+、Brotli、およびクライアントヒントの採用に与える影響について説明しています。
hero_alt: Hero image of Web Almanac charactes extending a plug from a cloud into a web page.
authors: [harendra, joeviggiano]
reviewers: [ytkoka]
analysts: [harendra, joeviggiano]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1ySETT2IZ9ae5_VUphxUol2ZU3P1RJvcSVjDU5BgnK5A/
harendra_bio: Haren BhandariはAmazon Web Servicesのソリューションアーキテクトです。Amazon Web Servicesに参加する前、HarenはAkamai Technologiesで働いており、CDNに関する深い経験を持っています。
joeviggiano_bio: Joe ViggianoはAmazon Web Servicesのメディア＆エンターテイメントソリューションアーキテクトで、顧客が大規模にメディアコンテンツを配信するのを支援しています。
featured_quote: CDNは多くのウェブサイトでスムーズなユーザーエクスペリエンスを提供するための重要な部分でした。COVID-19以降、実店舗のビジネスがオンラインに移行し、ウェブ会議、オンラインゲーム、ビデオストリーミングが増加したため、CDNの需要はさらに高まっています。
featured_stat_1: 62%
featured_stat_label_1: トップ1,000のサイトでCDNを使用しているサイト
featured_stat_2: 3x
featured_stat_label_2: 90パーセンタイルでCDNを使用したTLSネゴシエーションの高速化
featured_stat_3: 47%
featured_stat_label_3: CDNを通じてBrotliを使用しているドメイン
---

## 序章

この章では、CDNの現状に関する洞察を提供します。CDNは、JavaScriptライブラリ、フォント、その他のコンテンツなどの静的およびサードパーティのコンテンツの配信を容易にすることで、小規模なサイトを含め、世界中のユーザーにコンテンツを提供する上でますます重要な役割を果たしています。この章で議論するCDNの重要な側面のもう1つは、CDNがTLSやHTTPバージョンなどの新しい標準の採用において果たす役割です。

私たちは、CDNが将来においてもコンテンツの配信だけでなく、コンテンツのセキュリティにおいても重要な役割を果たし続けると考えています。ユーザーには、パフォーマンスとセキュリティの観点からCDNを見ることをオススメします。

## CDNとは何か？

_Content Delivery Network_（CDN）は、地理的に分散されたプロキシサーバーのネットワークです。CDNの目的は、ウェブコンテンツの高可用性とパフォーマンスを提供することです。これは、コンテンツをエンドユーザーに近い場所に配布することと、コンテンツを最適に配信するための先進技術をサポートすることによって達成されます。

ビデオや画像などのウェブコンテンツの爆発的な増加により、CDNは多くのウェブサイトにおいてスムーズなユーザーエクスペリエンスを提供するための重要な部分となっています。COVID-19以降、実店舗のビジネスがオンラインに移行し、ウェブ会議、オンラインゲーム、ビデオストリーミングが増加したため、CDNの必要性はさらに高まっています。

初期の頃、CDNは単なるプロキシサーバーのネットワークであり、以下の機能を果たしていました。

1. コンテンツ（HTML、画像、スタイルシート、JavaScript、ビデオなど）をキャッシュする
2. エンドユーザーがコンテンツにアクセスするためのネットワークホップを減らす
3. TCP接続の終了をウェブプロパティをホスティングしているデータセンターからオフロードする

これらは主に、ウェブ所有者がページのロード時間を改善し、これらのウェブプロパティをホスティングしているインフラからのトラフィックをオフロードするのに役立ちました。

時が経つにつれて、CDNプロバイダーによって提供されるサービスはキャッシングや帯域幅/接続のオフロードを超えて進化しました。その分散性と広範な分散ネットワーク容量により、CDNは大規模な[Distributed Denial-of-Service (DDoS)](https://en.wikipedia.org/wiki/Denial-of-service_attack#Distributed_attack)攻撃を非常に効率的に処理することが証明されました。近年、エッジコンピューティングは別のサービスとして人気を博しています。多くのCDNベンダーは、ウェブ所有者がエッジで単純なコードを実行できるようにするエッジでのコンピュートサービスを提供しています。

CDNベンダーによって提供されるその他のサービスには以下が含まれます。

* クラウドホスト型[Web Application Firewalls (WAF)](https://ja.wikipedia.org/wiki/Web_Application_Firewall)
* ボット管理ソリューション
* クリーンパイプソリューション（データセンターのデータ洗浄）
* 画像およびビデオ管理ソリューション

エンドユーザーに近い場所でウェブアプリケーションのロジックとワークフローを進めることは、ウェブ所有者にとって利点があります。これにより、HTTP/HTTPSリクエストが取るラウンドトリップと帯域幅が削減されます。また、起点の瞬間的なスケーラビリティ要件も処理します。これによる副作用として、インターネットサービスプロバイダー（ISP）もスケーラビリティの管理から恩恵を受けるため、そのインフラ容量が向上します。

### 注意事項と免責事項

あらゆる観察研究と同様に、測定できる範囲と影響には限界があります。Web AlmanacのCDN使用に関する統計は、使用されている適用技術により焦点を当てており、特定のCDNベンダーのパフォーマンスや効果を測定することを目的としていません。これにより、私たちはどのCDNベンダーにも偏らないことを保証しますが、これはより一般化された結果であることも意味します。

こちらが私たちのテスト[方法論](./methodology)の限界です。

- **シミュレートされたネットワーク遅延：** トラフィックを合成的に形成する専用ネットワーク接続を使用します。

- **単一地理的位置：** テストは単一のデータセンターから実行され、多くのCDNベンダーの地理的分散をテストすることはできません。

- **キャッシュの効果：** 各CDNは独自の技術を使用し、多くの場合、セキュリティ上の理由からキャッシュのパフォーマンスを公開しません。

- **ローカリゼーションと国際化：** 地理的分布と同様に、言語と地域固有のドメインの影響もこれらのテストでは不透明です。

- **CDNの検出：** これは主にDNS解決とHTTPヘッダーを通じて行われます。ほとんどのCDNはDNS CNAMEを使用してユーザーを最適なデータセンターにマッピングします。ただし、一部のCDNはAnycast IPを使用するか、デリゲートされたドメインから直接のA+AAAA応答を使用し、DNSチェーンを隠します。その他の場合では、ウェブサイトが複数のCDNを使用してベンダー間でバランスを取ることが、私たちのクローラーの単一リクエストパスからは隠されています。

これらすべてが私たちの測定に影響を与えます。

もっとも重要なことは、これらの結果は特定の機能（たとえばTLSv1.3、HTTP/2）のサイトごとのサポートを反映していますが、実際のトラフィックの使用を反映していないことです。YouTubeは`www.example.com`よりも人気がありますが、どちらも私たちのデータセットでは同等に表示されます。

これを念頭に置いて、CDNの文脈で意図的に測定されなかったいくつかの統計をここに示します。

1. 最初のバイトまでの時間（TTFB）
2. CDNラウンドトリップタイム
3. Core Web Vitals
4. 「キャッシュヒット」対「キャッシュミス」のパフォーマンス

これらの一部はHTTPアーカイブのデータセットで測定可能であり、他はCrUXデータセットを使用して測定可能ですが、方法論の限界と一部のサイトが複数のCDNを使用しているため、測定が困難であり、誤って帰属される可能性があります。これらの理由から、この章ではこれらの統計を測定しないことにしました。

モバイルとデスクトップの間に顕著な違いは見られなかったため、繰り返しを避けるため、この章で提供されるデータはとくに注記がない限り主にモバイルの使用に関するものです。

## CDNの採用

ウェブページは以下の主要なコンポーネントで構成されています。

1. ベースHTMLページ（たとえば、`www.example.com/index.html`は、しばしば`www.example.com`のようなよりフレンドリーな名前で提供されます）。
2. 主ドメイン（`www.example.com`）およびサブドメイン（たとえば、`images.example.com`、`assets.example.com`）にある画像、CSS、フォント、JavaScriptファイルなどの組み込みファーストパーティコンテンツ。
3. サードパーティドメインから提供されるサードパーティコンテンツ（たとえば、Googleアナリティクス、広告）。

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="モバイルでのCDNの使用とホストされたリソース。",
  description="オリジンとCDNによって分割されたCDN使用とホストされたリソースの棒グラフ。HTMLコンテンツの場合、リクエストの71%がオリジンからで29%がCDNからです。サブドメインコンテンツでは、53%がオリジンからで47%がCDNからです。そしてサードパーティコンテンツでは、33%がオリジンからで67%がCDNからです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=41983383&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

上のグラフは、デスクトップでもほぼ同じ数字が見られたため、モバイルの各種リクエストのCDN対ホストリソースの分割を示しています。CDNはしばしば画像、スタイルシート、JavaScript、フォントなどの静的コンテンツの配信に利用されます。この種のコンテンツは頻繁に変更されないため、CDNのプロキシサーバーでキャッシュするのに適しています。とくにサードパーティコンテンツについては、この種のリソースでCDNがより頻繁に使用されています。

CDNは静的でないコンテンツの配信にもパフォーマンスを向上させることができます。CDNはルートを最適化し、もっとも効率的な輸送手段を使用することが多いですが、HTMLの配信の使用は他の2つのタイプに比べてかなり遅れています。

{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="モバイルでのCDNから提供されるコンテンツのトレンド",
  description="CDNから提供されるコンテンツの過去数年のトレンドを示すグラフです。CDNの使用は増加傾向にあります。サブドメインから提供されるコンテンツで大きな増加が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=2141710369&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

[2021年](../2021/cdn)と比較して、CDNの使用が着実に増加していることがわかりました。サブドメインから提供されるコンテンツのCDN使用に大きな増加があり、HTMLの増加は小さく、サードパーティのCDN使用は比較的一定でした。

この増加の背後にある潜在的な理由は次のとおりです。

* パンデミック後、多くのビジネスがその大部分をオンラインに移行しました。これによりサーバーに多くの負担がかかり、静的コンテンツをCDNを通じて提供する方が、キャッシングと高速配信によってオフロードする方がはるかに効率的であることがわかりました。
* この増加は2021年には見られませんでした。多くのビジネスが問題の最適な解決策を見つけ出そうとしていたからです。実際、サブドメインとサードパーティタイプのCDN使用に減少が見られました。
* サイトは自社ドメインの代わりにサードパーティドメインを通じてサードパーティコンテンツを提供することに依存しました。この期間にサードパーティドメインから提供されるコンテンツの量が3%増加したという事実がこの仮説を支持しています。

ベースHTMLページに関しては、伝統的なパターンはベースHTMLをオリジンから提供することで、このパターンはほとんどのベースページが引き続きオリジンから提供されるため続いています。しかし、CDNから提供されるベースページが4%増加しました。ベースHTMLページがCDNから提供される傾向は明らかに上昇しています。

この背後にある可能性のある理由は次のとおりです。
* CDNは、顧客体験を向上させ、ユーザーを引き付ける上で重要なベースHTMLページのロード時間を改善できます。
* CDNプロバイダーによる分散DNSの使用は、よりシンプルで速いです。
* ベースHTMLページを含むほとんどのコンテンツをCDNを通じてプッシュする場合、災害復旧の計画が容易になります。CDNは通常、プライマリサイトが不安定または利用不可能になった場合に自動的に代替サイトに切り替えるフェイルオーバー機能を提供します。

サイトの人気に基づいて、さまざまなタイプのコンテンツでCDNの採用を観察しましたが、以下ではサイトの人気に基づいた異なる視点からこのデータを見ていきます。

{{ figure_markup(
  image="cdn-usage-ranking-desktop.png",
  caption="モバイルでのサイトの人気によるCDNの使用。",
  description="GoogleのChrome UX Reportに基づいて、トップ1,000、10,000、100,000、100万、1000万の人気サイトごとにモバイルサイトのCDN使用を分類した棒グラフです。トップ1000、10,000のサイトでCDNの採用率は60%以上です。人気が低いサイトでは採用率が低下しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1175849008&format=interactive",
  sheets_gid="1207165933",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

GoogleのChrome UX Reportからのデータに基づいてウェブサイトの人気によるCDNの使用を見ると、トップ1,000-10,000がCDNのもっとも高い使用率を示しています。ランクの高いサイトでは、所有者の企業がパフォーマンスとその他の利点のためにCDNに投資していることが理解できますが、トップ1,000,000のサイトでも、CDNを通じて配信されるコンテンツの量が[2021年と比較して](../2021/cdn#fig-3)約7%増加しています。人気の低いサイトでのCDNの使用の増加は、CDNの無料または手頃なオプションの増加と、多くのホスティングソリューションがサービスにCDNを組み込んでいるためと考えられます。

## 主要なCDNプロバイダー

CDNプロバイダーは大きく2つのセグメントに分類できます。

1. 汎用CDN（Akamai、Cloudflare、CloudFront、Fastlyなど）
2. 特定目的用CDN（Netlify、WordPressなど）

汎用CDNは大衆市場の要求に対応しています。その提供内容には以下が含まれます。

- ウェブサイトの配信
- モバイルアプリAPIの配信
- ビデオストリーミング
- エッジコンピューティングサービス
- ウェブセキュリティの提供

これはより多くの業界に訴求し、データに反映されています。

{{ figure_markup(
  image="top-cdns-html.png",
  caption="モバイルでのHTMLリクエストに対する主要CDN。",
  description="HTMLリクエストを提供する主要CDNプロバイダーを示すボックスプロット。Cloudflareがリストのトップで、HTMLリクエストの52％を提供し、次にGoogleが22％、Fastlyが9％、CloudFrontが6％、AkamaiとAutomatticが3％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1688291462&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

上記の図は、ベースHTMLリクエストに対する主要なCDNプロバイダーを示しています。このカテゴリーでトップのベンダーはCloudflare、Google、Fastly、Amazon CloudFront、Akamai、そしてAtomatticです。

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="モバイルでのサブドメインリクエストに対する主要CDN。",
  description="サブドメインリクエストを提供する主要CDNプロバイダーを示すボックスプロット。Cloudflareがリストのトップで、サブドメインリクエストの35％を提供し、次にCloudFrontが18％、Googleが17％、Automatticが9％、Akamaiが5％、Fastlyが3％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1743984972&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

サブドメインリクエストについては、AmazonやGoogleなどのプロバイダーの使用が増えています。これは多くのユーザーが提供されるクラウドサービスでコンテンツをホストしており、クラウドサービスとともにCDNオファリングを利用しているためです。これにより、ユーザーはアプリケーションをスケールし、アプリケーションのパフォーマンスを向上させることができます。

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="モバイルでのサードパーティリクエストに対する主要CDN。",
  description="サードパーティリクエストを提供する主要CDNプロバイダーを示すボックスプロット。Googleがリストのトップで、サードパーティリクエストの48％を提供し、次にCloudlareが15％、CloudFrontが12％、Akamaiが6％、Facebookが5％、Fastlyが4％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1502237125&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

サードパーティドメインを見ると、トップのCDNプロバイダーで異なる傾向が見られます。Googleが汎用CDNプロバイダーの前にリストのトップに立っています。リストにはFacebookも目立っています。これは、多くのサードパーティドメインの所有者が他の業界よりもCDNを必要としているという事実に支えられています。GoogleやFacebookのような大手サードパーティプロバイダーにとっては、特定のコンテンツ配信ワークフローに最適化された特定目的用CDNを構築する必要があります。特定目的用CDNは、特定の市場セグメントの正確な要件に応えるために設計されています。

たとえば、広告を配信するために特別に構築されたCDNは、以下に最適化されます。

- 高い入出力（I/O）操作
- [ロングテール](https://ja.wikipedia.org/wiki/%E3%83%AD%E3%83%B3%E3%82%B0%E3%83%86%E3%83%BC%E3%83%AB)コンテンツの効果的な管理
- サービスを必要とするビジネスに地理的に近い

これは、特定目的用CDNが汎用CDNソリューションとは対照的に、特定の市場セグメントの正確な要件を満たすことを意味します。汎用ソリューションはより広範な要件を満たすことができますが、特定の業界や市場に最適化されているわけではありません。

## TLSの使用

CDNがリクエストレスポンスワークフローに設定されると、エンドユーザーのTLS接続はCDNで終了します。その後、CDNは独立した2つ目のTLS接続を設定し、この接続はCDNからオリジンホストへと続きます。CDNワークフローのこの中断により、CDNはエンドユーザーのTLSパラメーターを定義できます。CDNはインターネットプロトコルの自動更新も提供する傾向があります。これにより、Webオーナーはオリジンを変更することなくこれらの利点を受け取ることができます。

### TLS採用の影響

下記のグラフは、CDNから提供されるコンテンツとオリジンから提供されるコンテンツとを比較した際、最新バージョンのTLSの採用率がCDNの方がはるかに高いことを示しています。

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="HTML（モバイル）のTLSバージョンの分布。",
  description="CDNおよびオリジンによって提供されるモバイルリクエストのTLSバージョンの使用状況の棒グラフ。CDNはリクエストの87%をTLS 1.3で、13%をTLS 1.2で提供しています。一方、オリジンはリクエストの42%をTLS 1.3で、58%をTLS 1.2で提供しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=755535896&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

[2021年のデータ](../2021/cdn#TLS採用の影響)と比較すると、モバイルHTMLコンテンツにおけるTLS v1.3の採用は5%増加していますが、オリジンから提供されるコンテンツの場合はTLS v1.3の採用が10%増加しています。

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="サードパーティリクエスト（モバイル）のTLSバージョンの分布。",
  description="デスクトップのサードパーティリクエストのTLSバージョンの使用状況の棒グラフで、CDNおよびオリジンによって提供されます。CDNはサードパーティのリクエストの88%をTLS 1.3で、12%をTLS 1.2で提供しています。一方、オリジンはリクエストの26%をTLS 1.3で、74%をTLS 1.2で提供しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1995157146&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

現在のセキュリティ環境では、コンテンツが最新のTLSバージョンを介して配信されることが重要です。上記のデータから、CDNを介してTLS v1.3への移行がオリジンに比べてはるかに迅速であったことがわかります。これはCDNを使用してコンテンツを配信する際の付加的なセキュリティ利点を示しています。

### TLSのパフォーマンスへの影響

一般的な論理では、HTTPSリクエストレスポンスが通過するホップの数が少ないほど、往復の時間は速くなるとされています。

{{ figure_markup(
  image="tls-negotiation-desktop.png",
  caption="HTML TLSネゴシエーション - CDN対オリジン（デスクトップ）",
  description="この棒グラフは、CDNとオリジンでの10番目、25番目、50番目、75番目、90番目のパーセンタイルにわたるTLS接続時間（ミリ秒）についての洞察を提供します。グラフからわかるように、TLSネゴシエーション時間は一般にCDNの方が速いです。",
  chart_url="https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1669978107&format=interactive",
  sheets_gid="1644442668",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="tls-negotiation-mobile.png",
  caption="HTML TLSネゴシエーション - CDN対オリジン（モバイル）",
  description="この棒グラフは、CDNとオリジンでの10番目、25番目、50番目、75番目、90番目のパーセンタイルにわたるTLS接続時間（ミリ秒）についての洞察を提供します。グラフからわかるように、TLSネゴシエーション時間は一般にCDNの方が速いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1577806460&format=interactive",
  sheets_gid="1644442668",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

上記の図からわかるように、TLSネゴシエーション時間はCDNを利用する場合に一般にはるかに優れています。これは、デスクトップとモバイルのデータを比較した場合、さらに顕著で、[_Round Trip Time_ (RTT)](./methodology#webpagetest)が使用されるモバイルクローラーの結果、TLSネゴシエーション時間がはるかに長くなります。

CDNはTLS接続時間を大幅に短縮するのに役立っています。これは、エンドユーザーに近いことと、TLSネゴシエーションを最適化する新しいTLSプロトコルを採用しているためです。CDNはすべてのパーセンタイルでオリジンに対して優位性を持っています。P10およびP25では、CDNはオリジンよりもTLS設定時間で約1.5倍速いです。中央値を超えると、CDNはモバイルで約2倍、デスクトップで約3倍速くなります。90番目のパーセンタイルのユーザーは、直接オリジン接続の50番目のパーセンタイルのユーザーよりもパフォーマンスが良いでしょう。

これは、すべてのサイトが現在TLSを使用していることを考慮するととくに重要です。この層での最適なパフォーマンスは、TLS接続に続く他のステップにとって不可欠です。この点で、CDNは直接オリジン接続に比べてより多くのユーザーを低いパーセンタイルブラケットに移動させることができます。

## HTTP/2+ の採用

HTTP/2の仕様は2015年にはじめて導入され、同年の終わりまでにほとんどの主要ブラウザが採用しました。HTTPアプリケーション層プロトコルは1997年のHTTP 1.1以来更新されておらず、それ以降、Webトラフィックの傾向、コンテンツタイプ、コンテンツサイズ、ウェブサイトデザイン、プラットフォーム、モバイルアプリなどが大きく進化しました。したがって、現代のWebトラフィックの要件を満たすことができるプロトコルが必要であり、そのプロトコルはHTTP/2として実現されました。

HTTP/2のハイプと遅延の削減などの機能の約束にもかかわらず、採用は新しいアプリケーションプロトコルをサポートするためにサーバー側の更新に依存していました。CDNは、Webオーナーのために新しい実装の課題を橋渡しする手助けをすることができ、これはさらに新しいHTTP/3プロトコルにも当てはまります。HTTP接続はCDNレベルで終了し、これによりWebオーナーは自身のインフラストラクチャをアップグレードする必要なく、自分のウェブサイトやサブドメインをHTTP/2およびHTTP/3で配信する能力を持つようになります。新しいTLSバージョンの採用においても同様の利点が見られました。

CDNは、ホスト名を一元化し、ホスティングインフラストラクチャに最小限の変更を加えてトラフィックを関連するエンドポイントにルーティングするための層を提供することで、このギャップを埋めるプロキシとして機能します。キュー内のコンテンツの優先順位付けやサーバープッシュなどの機能はCDN側で管理でき、いくつかのCDNはこれらの機能をウェブサイトオーナーからの入力なしに自動的に運用するソリューションを提供しており、HTTP/2の採用を促進しています。

<p class="note">HTTP/3の動作方式により（詳細は[HTTP](./http)章を参照）、HTTP/3は初回接続にはほとんど使用されません。これは、多くのHTTP/2接続が実際にはリピート訪問者のためにHTTP/3である可能性があるため、"HTTP/2+"を測定しているからです（サーバーがHTTP/2なしでHTTP/3を実装することはないと仮定しています）。</p>

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="HTML（モバイル）のHTTPバージョンの分布。",
  description="この棒グラフは、モバイルHTMLリクエストにおけるCDNとオリジンのHTTPバージョンの採用を示しています。CDNから提供されたモバイルHTMLリクエストの84%がHTTP/2またはそれ以上のプロトコルで提供されましたが、オリジンから提供されたリクエストでは43%がHTTP/2またはそれ以上のプロトコルで提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1385171364&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

上のグラフには、CDNを使用しているドメインと使用していないドメインとの間に明確な対照があり、CDNを使用しているドメインのHTTP/2+の採用率が高くなっています。

2021年には、[オリジンから提供されるコンテンツの約40%がHTTP/2を採用していました](../2021/cdn#HTTP/2+（HTTP/2以上）の採用)が、同時期にCDNから提供されるコンテンツの81%がHTTP/2を通じて提供されました。オリジンのこの数値は3ポイント増加しましたが、CDNの場合は6ポイント増加し、すでに存在していたかなりの差がさらに広がりました。これは、CDNがウェブサイトオーナーが初期段階から新しいプロトコルを利用できるようにする方法を示しています。

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="サードパーティリクエスト（モバイル）のHTTPバージョンの分布。",
  description="この棒グラフは、モバイルのサードパーティリクエストにおけるCDNとオリジンのHTTPバージョンの採用を示しています。これらのサードパーティリクエストのCDNから提供されたものの88%がHTTP/2またはそれ以上のプロトコルで提供されましたが、オリジンから提供されたリクエストでは50%がHTTP/2またはそれ以上のプロトコルで提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=983285021&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

サードパーティドメインは新しいプロトコルのサポートにさらに迅速に対応していることが以前の研究で見られました。2022年には、サードパーティドメインのHTTP/1.1のシェアがさらに減少しましたが、今年使用されたプロトコルの大部分を特定できなかったため、さらなる調査が必要です。

サードパーティドメインはすべてのネットワーク条件で一貫したパフォーマンスを必要としており、ここでHTTP/2+が価値を加えます。2022年6月には、インターネットエンジニアリングタスクフォース（IETF）が[HTTP/3 RFC](https://www.theregister.com/2022/06/07/http3_rfc_9114_published/)を公開し、WebをTCPからUDPに移行しました。多くのCDNプロバイダーはHTTP/3のサポートを公式のRFC公開前に迅速に採用しており、時間が経つにつれてウェブオーナーがHTTP/3を採用することが見られるでしょう。とくにモバイルネットワークトラフィックがインターネットトラフィックの大部分を占める場合には、2023年にさらなる洞察をお届けします。

## Brotliの採用

インターネット経由で配信されるコンテンツは、ペイロードサイズを削減するために圧縮を使用します。ペイロードが小さいほど、サーバーからエンドユーザーへのコンテンツの配信が速くなります。これにより、ウェブサイトの読み込みが速くなり、エンドユーザーの体験が向上します。画像については、JPEG、WEBP、AVIFなどの画像ファイルフォーマットによって圧縮が処理されます。これについての詳細は[メディア](./media)章を参照してください。HTML、JavaScript、スタイルシートなどのテキストWebアセットについては、従来[_Gzip_](https://ja.wikipedia.org/wiki/Gzip)ファイルフォーマットによって圧縮が行われていました。Gzipは1992年から存在しており、テキストアセットのペイロードを小さくするのに役立っていましたが、新しいテキストアセット圧縮は、より新しい[_Brotli_](https://ja.wikipedia.org/wiki/Brotli)圧縮フォーマットを使用することでGzipよりも優れた結果をもたらすことができます。

TLSやHTTP/2の採用と同様に、BrotliはWebプラットフォーム全体で段階的に採用されてきました。この記事を書いている時点で、Brotliは<a hreflang="en" href="https://caniuse.com/brotli">世界中のWebブラウザの96%以上でサポートされています</a>。しかし、すべてのウェブサイトがテキストアセットをBrotliフォーマットで圧縮しているわけではありません。これは、サポートが不足していることと、Brotliフォーマットでテキストアセットを圧縮するのに必要な時間がGzip圧縮と比較して長くなることが理由です。また、古いプラットフォームでBrotliフォーマットをサポートしていない場合にGzip圧縮アセットを提供できるように、ホスティングインフラストラクチャには後方互換性が必要であり、これが複雑さを増す原因となります。

この影響は、CDNを使用しているウェブサイトと使用していないウェブサイトを比較するときに観察されます。

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="圧縮タイプの分布（モバイル）。",
  description="この棒グラフは、モバイルリクエストにおけるCDNとオリジンでのBrotliの採用を示しています。CDNはリクエストの47%をBrotli圧縮フォーマットで、57.3%をgzip圧縮フォーマットで提供しました。一方、オリジンはリクエストの25%をBrotli圧縮フォーマットで、77%をgzip圧縮フォーマットで提供しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1836100530&format=interactive",
  sheets_gid="2043216080",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

CDNとオリジンはともに、[前年と比較して](../2021/cdn#Brotli採用)Brotliの採用が増加しています。CDNでのBrotliの採用は5ポイント増加し、オリジンはほぼ4ポイント増加しました。この傾向が2023年に続くか、または飽和点に達したかどうかを確認することができるでしょう。

## クライアントヒントの採用

_Client Hints_ は、Webサーバーがクライアントから積極的にデータをリクエストできるようにし、HTTPヘッダーの一部として送信されます。クライアントは、デバイス、ユーザーエージェントの設定、ネットワーク情報などを提供することがあります。提供された情報に基づいて、サーバーは要求するクライアントに応答するための最適なリソースを決定できます。クライアントヒントは最初にGoogle Chromeブラウザで導入され、他のChromiumベースのブラウザもこれを採用していますが、他の人気ブラウザではクライアントヒントのサポートが限定的であったり、まったくなかったりします。

CDN、オリジンサーバー、クライアントブラウザがすべてクライアントヒントを適切に利用するためには、サポートが必要です。このフローの一部として、CDNはクライアントに `Accept-CH` HTTPヘッダーを提示して、クライアントが後続のリクエストに含めるべきクライアントヒントをリクエストできます。我々は、CDNがこのヘッダーをリクエスト内に提供したクライアントのレスポンスを測定し、テストの一環として記録されたすべてのCDNリクエストでそれを測定しました。

{{ figure_markup(
  image="cdn-client-hints-mobile.png",
  caption="クライアントヒントの比較（モバイル）。",
  description="この棒グラフは、CDNでのクライアントヒントの使用状況を示しています。現在、リクエストの0.43%のみがクライアントヒントを持っています",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1567266649&format=interactive",
  sheets_gid="2048261739",
  sql_file=""
  )
}}

デスクトップとモバイルの両方のクライアントで、クライアントヒントの使用率は1%未満で、クライアントヒントの採用はまだ初期段階にあることを示しています。

## 画像フォーマットの採用

CDNは伝統的に、画像などの静的コンテンツをキャッシュ、圧縮、配信するために使用されてきました。それ以来、多くのCDNは、さまざまな使用例に最適化するために、画像をフォーマットとサイズの両方で動的に変更する能力を追加しています。

これは、ユーザーエージェントやクライアントヒントに基づいて自動的に、クエリ文字列に追加パラメーターを送信することで実行される場合があります。これにより、エッジでの計算が画像を解釈し、応答に応じて画像を変更します。これによりサイト運営者は1つの高解像度画像をアップロードし、サムネイルなど、低品質または低解像度の画像が必要な場合に、画像を動的に変更できます。

{{ figure_markup(
  image="cdn-image-formats-mobile.png",
  caption="画像フォーマットの分布（モバイル）。",
  description="この棒グラフは、モバイルリクエストにおけるCDNとオリジンでのBrotliの採用を示しています。CDNはリクエストの42.6%をBrotli圧縮フォーマットで、57.3%をgzip圧縮フォーマットで提供しました。一方、オリジンはリクエストの21.2%をBrotli圧縮フォーマットで、78.7%をgzip圧縮フォーマットで提供しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=293872923&format=interactive",
  sheets_gid="571877353"
  )
}}

デスクトップとモバイルの両方で、主要な画像フォーマットはJPG（JPEG）とPNGでした。JPGはサイズを最適化するためのロスリ圧縮ファイルフォーマットを提供します。PNGまたはポータブルグラフィックスフォーマットはロスレス圧縮をサポートし、画像が圧縮されてもデータが失われることはありませんが、画像全体のサイズはJPGよりも大きくなります。JPGとPNGの詳細については、[Adobeのウェブサイト](https://www.adobe.com/creativecloud/file-types/image/comparison/jpeg-vs-png.html)を訪れてください。

## 結論

過去数年にわたる我々の継続的な研究から、CDNは、ウェブサイトオーナーがオリジンから世界中のどのユーザーにもコンテンツを確実に配信するために重要な役割を果たしているだけでなく、新しい[セキュリティ](./security)およびWeb標準の採用にも大きな役割を果たしていることがわかります。

一般的に、CDNの使用率は全体的に増加しています。TLS 1.3のような新しいウェブセキュリティ標準の採用においても、CDNはその採用を大いに促進しており、CDNからのトラフィックのほとんどがTLS 1.3を使用していることが確認されています。

HTTP/2やBrotli圧縮など、新しいWeb標準やWeb技術の採用に関しても、CDNがリードしていることが見られました。CDNを利用して提供されるウェブサイトの大部分がこれらの新しい標準を採用していることが確認されました。エンドユーザーの観点から見ると、これらは非常にポジティブな進展であり、彼らは安全にサイトを利用しながら、最適なユーザー体験を得ることができるでしょう。

今年からはクライアントヒントや画像フォーマットの採用など、新しい指標にも注目しています。来年のデータ収集が進むにつれ、より多くの洞察を得ることができるでしょう。

CDNについて外部から得られる洞察には限界があり、その内部で動作する「秘密のソース」を知ることは困難です。しかし、我々はドメインをクロールし、CDNを使用しているサイトとそうでないサイトを比較しました。その結果、CDNがネットワーク層からアプリケーション層に至るまで、新しいWebプロトコルの採用を促進していることがわかりました。

CDNのこの役割は非常に価値があり、今後も続くでしょう。CDNプロバイダーは<a hreflang="en" href="https://www.ietf.org/">インターネットエンジニアリングタスクフォース</a>の重要な一部であり、インターネットの未来を形作る手助けをしています。彼らは今後も、インターネット対応産業がスムーズかつ確実に、そして迅速に運営できるように、重要な役割を果たし続けるでしょう。

来年のデータ収集が進むことを楽しみにしており、読者の皆様に有用な洞察を提供できることを期待しています。
