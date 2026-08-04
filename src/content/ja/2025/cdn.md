---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: 2025年版Web AlmanacのCDNチャプターでは、CDNの採用状況、主要CDNプレーヤー、TLS、HTTP/2+、Zstandard、Brotli、Early Hints、Client HintsへのCDNの影響を取り上げます。
hero_alt: Web Almanacのキャラクターがクラウドからウェブページにプラグを差し込んでいるヒーロー画像。
authors: [joeviggiano, AlexMoening, nick-mccord]
reviewers: [carolinescholles]
editors: [carolinescholles]
analysts: [AlexMoening, nick-mccord, joeviggiano]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1xc7EkFIIA5Lon9Ao9ksmiIq-0j0qc1TbhreKJgc5DBE/edit
joeviggiano_bio: Joe ViggianoはAmazon Web Servicesのプリンシパルソリューションアーキテクトで、メディア＆エンターテインメント顧客が大規模にメディアコンテンツを配信できるよう支援しています。
nick-mccord_bio: Nick McCordはAmazon Web Servicesのソリューションアーキテクトで、スタートアップとエッジサービスに注力しています。
AlexMoening_bio: Alex MoeningはAmazon Web Servicesのシニアエッジソリューションアーキテクトです。
featured_quote: CDNはウェブプロトコル進化の先陣を切っており、主要プロバイダーはHTTP/3採用率69%を達成しているのに対し、オリジンサーバーは5%未満にとどまっています。これはエッジインフラが次世代ウェブ標準の採用を牽引していることを示しています。
featured_stat_1: 49.9%
featured_stat_label_1: 業界をリードするCloudflareのドキュメントにおけるHTTP/3採用率
featured_stat_2: 98.6%
featured_stat_label_2: セキュリティ強化のためTLS 1.3を使用するCDNリクエストの割合
featured_stat_3: 97.4%
featured_stat_label_3: AuttoMatticのBrotli圧縮採用率
doi: 10.5281/zenodo.18259078
---

## はじめに

本章では、2025年のコンテンツデリバリーネットワーク（CDN）の急速に進化する状況を検証し、HTTPプロトコル最適化における役割に焦点を当てています。CDNは根本的に、HTTP/2多重化によるTCP接続オーバーヘッドの削減からHTTP/3のQUICトランスポートによるヘッドオブラインブロッキングの排除まで、大規模なHTTP配信の課題を解決するために存在しています。HTTPプロトコルがHTTP/1.1の接続制限からHTTP/3の高度な機能へと進化するにつれ、CDNはオリジンサーバーが採用する数年前にこれらのプロトコルを実装する主要な展開手段として機能してきました。

現代のCDNはウェブコンテンツの全スペクトルにわたって配信を最適化しています。高度にキャッシュ可能なリソース（静的アセット、パブリックAPIレスポンス、共有コンテンツ）に対して、CDNは高度な圧縮と最新フォーマット配信によって強化された従来のキャッシュメリットを提供します。キャッシュ可能性が限られたコンテンツ（ユーザー固有のデータ、頻繁に更新されるAPI、パーソナライズされた体験）に対しても、CDNはコンテンツがキャッシュできない場合でも、接続最適化、インテリジェントルーティング、エッジ処理を通じてレイテンシを削減するパフォーマンス改善を提供します。

2024年の包括的な分析を基に、2025年の分析ではプロトコル採用と最適化戦略のシフトが明らかになりました。本章の重要な焦点は、HTTP/3採用の成熟、Server-Timingの透明性などの現代的な最適化技術の台頭、そしてCDNがパフォーマンス、セキュリティ、ユーザーエクスペリエンスに対して取っている洗練された多層的アプローチです。

## CDNとは？

コンテンツデリバリーネットワーク（CDN）は、ウェブコンテンツとアプリケーションに高可用性、強化されたパフォーマンス、改善されたセキュリティを提供するために設計された、地理的に分散したサーバーのネットワークです。CDNの主な目標は、エンドユーザーに近い場所からデータを提供することでレイテンシを最小化し、コンテンツ配信を最適化することです。

CDNはエンドユーザーとオリジンサーバー間の中間インフラとして機能し、ウェブリクエストをインターセプトして配信プロセス全体を最適化します。CDNがウェブパフォーマンスをどのように向上させるかを理解するために、ユーザーがブラウザにホスト名を入力する際の従来のウェブインタラクションと、異なるCDNが各ステップをどのように改善するかを考えてみましょう：

- **DNS解決**
  - **従来**: ブラウザがオリジンサーバーのIPのDNSを照会し、解決時間が遅くなることが多い
  - **CDN処理**: CDNのDNSインフラは、様々なルーティング戦略（エニーキャストまたはユニキャスト）を使用してユーザーを最適なエッジサーバーに誘導する場合があります。一部のCDNはHTTPSやSVCB（Service Binding）レコードなどの最新のDNSレコードをサポートしており、DNSレスポンスに直接プロトコル機能をアドバタイズできますが、採用はプロバイダーによって異なります

- **接続確立**
  - **従来**: ブラウザが遠くのオリジンサーバーへの新しいTCP接続を完全なハンドシェイクオーバーヘッドで確立する
  - **CDN処理**: TCP（HTTP/1.1とHTTP/2の場合）またはQUIC付きUDP（HTTP/3の場合）で近くのエッジサーバーに接続。CDNはリピート訪問者向けにHTTP/3の0-RTT接続再開をサポートする場合がありますが、すべてのCDNがこれらの新しい接続最適化機能を実装しているわけではありません

- **プロトコルネゴシエーション**
  - **従来**: オリジンサーバーのプロトコル機能に制限され、多くの場合古いHTTPバージョン
  - **CDN処理**: 多くのCDNは `Alt-Svc`（代替サービス）HTTPヘッダーを通じて、ブラウザに代替プロトコルを通知する最新プロトコルの利用可能性をアドバタイズできます。CDNは通常、オリジンサーバーの機能に関わらず、ブラウザからの新しいプロトコルを受け入れながらオリジンへの接続を維持するプロトコル変換のメリットを提供します

- **リクエスト処理と最適化**
  - **従来**: 最小限の処理による基本的なリクエスト転送
  - **CDN処理**: CDNによっては、ヘッダー正規化、インテリジェントなルーティング決定、サーバーサイドのパフォーマンスメトリクスを提供するServer-Timingなどのパフォーマンスヘッダーの追加、セキュリティヘッダー、コンテンツタイプとユーザーの地理的位置に基づくリクエスト最適化が含まれる場合があります

- **レスポンス処理**
  - **従来**: オリジンサーバーのHTTPサーバー機能に制限された直接レスポンス
  - **CDN処理**: CDNは高度なキャッシュ戦略、キャッシュ検証、Content-Encodingの最適化（BrotliやGzip圧縮など）、条件付きリクエストサポート（帯域幅を節約する304 Not Modifiedレスポンスなど）、レスポンス変換を実装する場合がありますが、具体的な機能はプロバイダーによって異なります

- **接続管理**
  - **従来**: リクエストごとの単一接続またはオリジンへの基本的なキープアライブ
  - **CDN処理**: 多くのCDNは二重接続最適化を実装し、クライアントへの永続的な接続を維持しながら、オリジンサーバーへのインテリジェントな接続プーリングを使用して、両端のオーバーヘッドを削減します

CDNは新興ウェブ標準の展開プラットフォームとして機能し、オリジンサーバーに広く採用される前に、新しいHTTPヘッダー、圧縮アルゴリズム、セキュリティ機能を大規模に実装します。これによりCDNはウェブ技術進化の重要なインフラとして位置づけられますが、利用可能な具体的な機能と最適化はCDNプロバイダーとその技術採用タイムラインに大きく依存します。

### 注意事項と免責事項

2025年の分析は前年に確立された方法論を基に、新しいメトリクスとより深いパフォーマンス分析を取り入れています。収集された統計は、ベンダー固有のパフォーマンス比較よりも、適用可能な技術と最適化パターンに焦点を当てています。

**測定に関する重要事項**: この分析におけるすべてのTLSネゴシエーション時間、DNS解決時間、パフォーマンスメトリクスは、制御されたインフラ上でChromeを使用したHTTP Archiveのシミュレートされたブラウザ接続から測定されています。これらの測定値は以下を表しています：
- 一貫したネットワーク条件（制御されたデータセンター接続）
- ChromeブラウザのTLS実装
- セッション再開なしの初回接続
- すべてのCDNにわたる標準化された測定方法論

実際のパフォーマンスは、CDNエッジサーバーへの地理的近接性、ネットワーク条件、TLSセッション再開機能、クライアントデバイスの特性によって異なる場合があります。

テスト方法論の主な制限：

- **シミュレートされたネットワーク条件:** テストは制御されたネットワーク環境を使用
- **単一の地理的視点:** 限られたデータセンターの場所からの分析
- **キャッシュの有効性:** 各CDNは独自の技術を使用しており、多くはセキュリティ上の理由からキャッシュパフォーマンスやキャッシュの深さを公開していません
- **ローカライゼーションと国際化:** 地理的分布と同様に、言語と地理的な特定ドメインの影響もこれらのテストでは不透明です
- **CDN検出:** これは主にDNS解決とHTTPヘッダーを通じて行われます。ほとんどのCDNはDNS CNAMEを使用してユーザーを最適なデータセンターにマッピングしています。ただし、一部のCDNはエニーキャストIPまたは委任されたドメインからの直接A+AAAAレスポンスを使用してDNSチェーンを隠しています。それ以外の場合、ウェブサイトはベンダー間でバランスを取るために複数のCDNを使用しており、クローラーの単一リクエストパスからは隠されています
- **サンプリングバイアス:** HTTP Archiveのデータは人気のあるウェブサイトを反映しており、特定のCDNプロバイダーが過大に代表されている可能性があります
- **市場シェアの解釈:** データはクロールされたサイトにおけるCDN使用パターンを示しており、真の市場分布ではありません

## CDNの導入

ウェブページは以下の主要コンポーネントで構成されています：

1. ベースHTMLページ（例：`www.example.com/index.html`—多くの場合 `www.example.com` のようなより親しみやすい名前でアクセス可能）。
2. メインドメイン（`www.example.com`）とサブドメイン（例：`images.example.com`、`assets.example.com`）の画像、CSS、フォント、JavaScriptファイルなどの埋め込みファーストパーティコンテンツ。
3. サードパーティドメインから提供されるサードパーティコンテンツ（例：Google Analytics、広告）。

CDN採用パターンの進化は、ウェブアーキテクチャの変化する性質と現代ウェブアプリケーションの複雑さの増大を反映しています。CDNはさまざまなコンテンツタイプにわたってその価値を証明し続けており、異なるユースケースへの適合性を反映したさまざまな採用率を示しています。

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="モバイルにおけるCDN使用率とホストリソースの比較。",
  description="2025年のモバイルウェブリクエストのCDN使用統計。サードパーティリソースが71%でCDN採用をリードし、次いでサブドメインリクエストが52%、HTMLコンテンツは35%で最低のCDN使用率を示しています。Web Almanac 2025 CDN分析のデータ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1479730898&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

このグラフは、異なるコンテンツタイプ（HTML、サブドメイン、サードパーティ）のリクエストの内訳を示し、モバイルデバイスでCDNとオリジンが提供するコンテンツのシェアを表しています。

CDNはフォント、画像ファイル、スタイルシート、JavaScriptなどの静的コンテンツの配信によく使用されます。この種のコンテンツは頻繁に変更されないため、CDNプロキシサーバーでのキャッシュに適しています。特にサードパーティコンテンツでは71%がCDN経由で配信されるなど、このタイプのリソースにCDNがより頻繁に使用されているのが依然として見られます。サブドメインリソースは52%で中程度のCDN採用を示していますが、HTMLコンテンツはオリジンサーバーから直接配信されることが多いため、35%で最もCDN使用率が低くなっています。

{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="モバイルにおけるCDNから配信されるコンテンツのトレンド。",
  description="このグラフは2021年から2025年にかけて、さまざまなコンテンツタイプにわたるCDNから配信されるコンテンツのトレンドを示しています。全般的なトレンドとして、CDN使用率は緩やかに増加していますが、サードパーティコンテンツでは顕著な減少が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=826488129&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

2024年から2025年にかけて、コンテンツタイプにわたってまちまちのトレンドが見られます。HTMLコンテンツは上昇トレンドを続け、33%から35%に増加しました。サブドメインコンテンツは両年で52%と安定していました。しかし、サードパーティコンテンツは2024年の75%から2025年の71%へと顕著に減少し、長年の継続的な成長の後、4パーセントポイントの低下を示しました。

{{ figure_markup(
  image="cdn-usage-ranking-mobile.png",
  caption="モバイルにおけるサイト人気度別CDN使用率。",
  description="このグラフは、Google CrUXデータを使用した人気ランキング別のモバイルサイトのCDN使用率を示しています。上位1,000サイトは71%のCDN採用率、上位10,000サイトは70%、上位100,000サイトでは62%に低下し、上位100万サイトは49%、上位1,000万サイトは35%となっています。サイトの人気が低下するにつれてCDN採用率が明らかに低下しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=363845861&format=interactive",
  sheets_gid="347054981",
  sql_file="top_cdns_by_rank.sql"
  )
}}

CDN使用率のシェアは年々増加しており、特にGoogle ChromeのUXレポート（CrUX）分類による最も人気のあるウェブサイトで顕著です。グラフに示されるように、上位1,000ウェブサイトは71%で最も高いCDN使用率を持ち、次いで上位10,000が70%、上位100,000が62%となっています。2024年と比較して、人気ランクに関わらずCDN採用率が増加しています。

過去のエディションで述べたように、小規模サイトにおけるCDN使用率が2024年の33%から2025年の35%に増加したことは、無料またはフラット料金プランや手頃なCDNオプションの台頭に起因していると考えられます。さらに、多くのホスティングソリューションがサービスにCDNをバンドルするようになっており、ウェブサイトがこの技術を活用しやすく、コスト効率の高いものにしています。

## CDNプロバイダー

CDNプロバイダーは一般的に2つのセグメントに分類できます：
1. **汎用CDN**: Akamai、Cloudflare、Amazon CloudFront、Fastlyなど、さまざまなユースケースに対応した幅広いコンテンツ配信サービスを提供するプロバイダー。
2. **専用CDN**: NetlifyやWordPressなど、特定のプラットフォームやユースケースに特化したプロバイダー。

汎用CDNは以下を含む広範な市場ニーズに対応しています：
* ウェブサイト配信
* ウェブアプリケーションAPI配信
* 動画ストリーミング
* エッジコンピューティングサービス
* ウェブセキュリティサービス

これらの機能は幅広い業界から支持されており、データにもその傾向が現れています。

{{ figure_markup(
  image="top-cdns-html.png",
  caption="モバイルにおけるHTMLリクエストのトップCDN。",
  description="HTMLリクエストを処理する上位CDNプロバイダーを示すボックスプロット。CloudflareがHTMLリクエストの58%を処理してリストのトップを占め、次いでGoogleが21%、CloudFrontが7%、Fastlyが5%、Vercelが2%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=419170909&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

ベースHTMLリクエストの処理において、Cloudflareが58%のシェアでトップを占め、次いでGoogle（21%）、Amazon CloudFront（7%）、Fastly（5%）、AkamaiとVercelがそれぞれ2%となっています。

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="モバイルにおけるサブドメインリクエストのトップCDN。",
  description="サブドメインリクエストを処理する上位CDNプロバイダーを示すボックスプロット。Cloudflareがサブドメインリクエストの46%を処理してリストのトップを占め、次いでCloudFrontが28%、Googleが5%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=923125707&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

2024年からわずかな変化はあるものの、このカテゴリのトップベンダーはCloudflare（46%）、Amazon CloudFront（28%）、Google（5%）、Akamai（4%）となっています。

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="モバイルにおけるサードパーティリクエストのトップCDN。",
  description="サードパーティリクエストを処理する上位CDNプロバイダーを示すボックスプロット。Googleがサードパーティリクエストの53%を処理してリストのトップを占め、次いでCloudflareが17%、CloudFrontが11%、Fastlyが5%、Akamaiが4%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1443211673&format=interactive",
  sheets_gid="366354739",
  sql_file="top_cdns.sql"
  )
}}

Googleがサードパーティドメイン使用において53%の市場シェアでリストをリードし、次いでCloudflare（17%）、Amazon CloudFront（11%）、Fastly（5%）、AkamaiとFacebook（4%）などの有名なCDNプロバイダーが続いています。

多くのCDNはコンテンツ配信に特化した機能を提供していますが、これらはますます大規模なサービスエコシステムの一部として存在するようになっています。これらのCDNはクラウドインフラ、セキュリティソリューション、エッジコンピューティングプラットフォームと緊密に統合されており、これらの隣接サービスはCDN自体を通じて、またはCDNと並行して提供されています。

異なるCDNプロバイダーは最適化と専門化に対して異なるアプローチを取っています。GoogleやFacebookなどのサードパーティプラットフォームは、自社のニーズに特化して設計された高度に専門化されたCDNを構築し、広告配信のための大規模なスループットを処理し、大規模にアナリティクスビーコンをキャプチャしています。これに対し、CloudflareやAmazon CloudFrontなどの汎用CDNは、より広い適用性を維持しながら特定の機能セットを最適化しています。これらのプラットフォームはCDN機能をマネージドサービスの基盤として活用し、グローバル分散APIゲートウェイやクライアントサイドのデバイスフィンガープリンティングとセキュリティ検査のためのリアルタイムJavaScript注入などのユースケースを可能にしています。

## HTTP/3の採用

IETFが2022年6月に発行した <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9114">HTTP/3</a> はHTTP/2に続くHTTPネットワークプロトコルの大幅な改訂版です。HTTP/3への移行はウェブの歴史上、最も重要なプロトコルアップグレードの1つを表しています。QUICトランスポート上に構築されたHTTP/3は、ヘッドオブラインブロッキングを排除し、接続確立のオーバーヘッドを削減します。2025年の分析では、特にCDNプロバイダーにおける採用パターンの劇的な変化が明らかになりました。

HTTP/3のパフォーマンス改善は、CDNがグローバルスケールで活用するのに独自の立場にある根本的なプロトコル設計の変更から生まれています。HTTP/2がTCPに依存しているのとは異なり、HTTP/3はUDP上のQUICを使用し、TCPのヘッドオブラインブロッキングを排除しています。1つのHTTP/2ストリームがパケットロスに遭遇すると、そのTCP接続上のすべての多重化ストリームが停止します。HTTP/3を実装したCDNは、QUICの独立したストリーム回復を通じて影響を受けないリクエストのパフォーマンスを維持できます。これは、低速の画像読み込みが重要なCSSやJavaScriptの配信をブロックしない、混合コンテンツを提供するCDNにとって特に価値があります。

HTTP/3は、QUICの統合された暗号ハンドシェイクを通じて、HTTP/2の3 RTT（TCPハンドシェイク、TLSハンドシェイク、HTTPネゴシエーション）から1 RTTへ接続確立を削減します。CDNは地理的近接性を通じてこの利点を増幅させ、近隣のCDNエッジサーバーに接続するユーザーは接続時間の短縮を体験します。リピーターのユーザーに対して、一部のCDNは0-RTT接続再開を実装しており、同じエッジサーバーへの再接続時にハンドシェイクのオーバーヘッドを完全に排除します。

現代のCDNは、DNSレスポンスがHTTP/3の可用性と接続パラメータを直接広告できるService Binding（SVCB）/ HTTPSレコードの一種であるHTTPS DNSレコードを実装し始めています。ブラウザがCDN対応ドメインのDNSをクエリすると、HTTPSレコードは特定のQUICパラメータとともにポート443でのHTTP/3サポートを示すことができ、従来のHTTP/2からHTTP/3へのアップグレードプロセスなしに即時HTTP/3接続を可能にします。このDNSレベルの最適化は、プロトコルアップグレードのネゴシエーションを排除し接続確立時間を短縮できるため、複数のドメインとサービスを管理するCDNにとって特に強力です。ただし、HTTPSレコードの実装はCDNプロバイダーによって大きく異なり、先行実装しているものとまだサポートを実装していないものがあります。

### 方法論に関する重要な考慮事項

**HTTP/3採用率の測定はHTTP Archiveの方法論の特定の特性を反映しており、インターネットトラフィック全体の代表値として解釈すべきではありません：**

- **サイト選定**: 分析は現代のプロトコルを実装する可能性が高い人気ウェブサイト（上位1,000万）に焦点を当てています
- **リソースタイプへの焦点**: 測定は主にメインドキュメントの読み込みではなく、CDNが提供する静的リソース（CSS、JS、画像）を反映しています
- **地理的範囲**: 限られたデータセンターロケーションからのテストはグローバルなユーザー体験を反映しない可能性があります
- **外部バリデーション**: Cloudflare自身の2025年データはグローバルでHTTP/3採用率を約21%と報告しており、私たちのデータセットでCloudflareリソースに観察された69%よりも大幅に低くなっています

これらの測定は主要なウェブプロパティとCDN提供リソースにおけるプロトコル採用を理解するために価値がありますが、一般的なインターネット使用パターンを代表するものとして外挿すべきではありません。

### CDNプロバイダーにおけるHTTP/3の採用

2025年に、過去年度と一貫した方法論を使用し、CDN提供リソースにおける有意なHTTP/3採用が観察されました。これらの数値は私たちのデータセットのサイトとリソースの特定のサブセットを反映していますが、CDNプロトコル展開における明確なパターンを示しています：

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="HTMLのHTTPバージョン分布（モバイル）。",
  description="このグラフはモバイルHTMLリクエストにおけるCDNとオリジンのHTTPバージョン採用を示しています。CDNから提供されたモバイルHTMLリクエストのうち、29%がHTTP/3、69%がHTTP/2、わずか2%がHTTP/1.1で提供されました。一方、オリジンリクエストではHTTP/3が0%でHTTP/2が79%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1323331086&format=interactive",
  sheets_gid="1482788843",
  sql_file="h3_adoption_by_cdn_vs_origin.sql"
  )
}}

私たちのデータセット内では、データは人気ウェブサイトと静的リソースにおける新しいプロトコルの採用を推進するCDNの役割を裏付けています。CDNはHTTP/3のトラフィックが29%を占め、オリジントラフィックでは実質的に0%でした。2024年と比較して、2025年はCDNでのHTTP/1.1使用が大幅に減少しました。

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="サードパーティリクエストのHTTPバージョン分布（モバイル）。",
  description="このグラフはモバイルのサードパーティリクエストにおけるCDNとオリジンのHTTPバージョン採用を示しています。CDNから提供されたサードパーティリクエストの45%がHTTP/3プロトコルで提供された一方、オリジンから提供されたリクエストではHTTP/3が7%にとどまりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=642743139&format=interactive",
  sheets_gid="1482788843",
  sql_file="h3_adoption_by_cdn_vs_origin.sql"
  )
}}

過去数年間、CDNでのHTTP/1.1使用は継続的に減少しているが、2025年にはCDNでのHTTP/1.1使用が2024年のHTMLリクエストの16%からわずか2%へと大幅に減少しました。この減少はオリジンリクエストでさらに顕著で、2024年の56%のHTTP/1.1リクエストから2025年の21%へと低下しました。

ドキュメント（多くの場合、最初のリクエスト）における個々のCDNのHTTP/3サポートを見ると、以下のようになります：

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">44.0%</td>
        <td class="numeric">49.9%</td>
      </tr>
      <tr>
        <td>CDN</td>
        <td class="numeric">6.2%</td>
        <td class="numeric">5.0%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">3.2%</td>
        <td class="numeric">3.8%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>QUIC.cloud</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTTP/3で提供されたドキュメントリクエストのトップ率。", sheets_gid="1928910266", sql_file="h3_adoption_by_cdn_provider.sql") }}</figcaption>
</figure>

ここで業界をリードしているCloudflareを特に称えたいと思います。

サブリソースリクエストは、後続リクエストがHTTP/3で行われる可能性が高い複数のリクエストに使用されることが多いため、採用率がはるかに高くなっています：

<figure>
  <table>
    <thead>
      <tr>
      <th>CDN</th>
      <th>デスクトップ</th>
      <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Facebook</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">99.9%</td>
      </tr>
      <tr>
        <td>Nexcess CDN</td>
        <td class="numeric">97.7%</td>
        <td class="numeric">99.6%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">71.2%</td>
        <td class="numeric">68.4%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">68.6%</td>
        <td class="numeric">69.5%</td>
      </tr>
      <tr>
        <td>Reapleaf</td>
        <td class="numeric">59.5%</td>
        <td class="numeric">59.1%</td>
      </tr>
      <tr>
        <td>Erstream</td>
        <td class="numeric">31.5%</td>
        <td class="numeric">77.4%</td>
      </tr>
      <tr>
        <td>QUIC.cloud</td>
        <td class="numeric">48.8%</td>
        <td class="numeric">47.3%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">39.6%</td>
        <td class="numeric">42.2%</td>
      </tr>
      <tr>
        <td>Pressable CDN</td>
        <td class="numeric">40.1%</td>
        <td class="numeric">40.8%</td>
      </tr>
      <tr>
        <td>Automattic</td>
        <td class="numeric">25.6%</td>
        <td class="numeric">29.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTTP/3で提供されたドキュメントリクエストのトップ率。", sheets_gid="1928910266", sql_file="h3_adoption_by_cdn_provider.sql") }}</figcaption>
</figure>

## CDNのパフォーマンス

CDNのパフォーマンスは単にコンテンツをユーザーに近い場所にキャッシュすることを超えています。CDNはブラウザが接続を確立してデータを受信する速さを決定する基礎的なプロトコルと接続メカニズムを積極的に最適化し、現代のウェブアプリケーションのボトルネックを理解するための透明なメトリクスを提供します。パフォーマンス最適化技術には接続プーリング、プロトコル変換、インテリジェントルーティングが含まれ、これらすべてがレイテンシの削減とユーザー体験の向上に貢献します。

### HTTP/3 TTFBパフォーマンス

以下は主要CDNにわたるHTTP/3、HTTP/2、HTTP/1.1のレイテンシの中央値パーセンタイル分布です。これらの測定はシミュレートされたブラウザ接続を反映しており、実際のパフォーマンスとは異なる場合があります。

{{ figure_markup(
  image="cdn-http-ttfb-protocol-mobile.png",
  caption="最初のバイトまでの時間（TTFB）の分布（モバイル）。",
  description="このグラフは主要CDNにわたるHTTP/3、HTTP/2、HTTP/1.1のレイテンシの中央値パーセンタイルを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1012878998&format=interactive",
  sheets_gid="1049435713",
  sql_file="h3_adoption_by_cdn_vs_origin.sql"
  )
}}

以前のHTTPプロトコルバージョンと比較したHTTP/3のTTFBパフォーマンスはCDNプロバイダーによって異なり、Amazon CloudFrontとFastlyの両方が改善されたTTFBレイテンシを示しています。これらはCDN間で均一なテストではなく、ウェブサイトオーナーは独自の管理されたパフォーマンステストを実施すべきです。

### DNSパフォーマンス

DNS解決はあらゆるウェブリクエストの重要な最初のステップです。2025年のデータは、オリジンサーバーに対するCDNの大幅なパフォーマンス優位性を示しています：

**DNS解決パフォーマンス（中央値）：**
- **CDN（モバイル）**: 176ms
- **オリジン（モバイル）**: 217ms
- **CDNの優位性**: 19%高速

- **CDN（デスクトップ）**: 52ms
- **オリジン（デスクトップ）**: 129ms
- **CDNの優位性**: 60%高速

デスクトップのパフォーマンス優位性は特に顕著で、CDNはオリジンサーバーより2.5倍高速にDNSレスポンスを提供します。この改善はCDNのエニーキャストルーティング、広範なエッジネットワーク、最適化されたDNSインフラの使用から生まれています。

### Alt-Svc

<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc7838#section-3">Alt-Svc</a>（代替サービス）HTTPレスポンスヘッダーは、同じリソースにアクセスするために使用できる代替プロトコルやサーバーについてブラウザに通知します。最も一般的なユースケースはHTTP/3サポートのアドバタイズです。ブラウザが最初にHTTP/1.1またはHTTP/2を使用してサーバーに接続すると、サーバーは次のようなAlt-Svcヘッダーを含めることができます：`Alt-Svc: h3=":443"; ma=86400`

これはブラウザに、ポート443でHTTP/3を使用して同じサービスにアクセスできること、およびこの情報が86400秒（24時間）有効であることを通知します。ブラウザがこのヘッダーを受信すると、HTTP/2から始めてアップグレードをネゴシエートするのではなく、HTTP/3を直接使用して将来の接続を確立できます。

2025年のデータでは：
- **Google HTTP/2 → H3アドバタイズ**: 99.2%（HTTP/3をアドバタイズする4,400万のHTTP/2リクエスト）
- **Cloudflare HTTP/2 → H3アドバタイズ**: 100%（HTTP/3をアドバタイズする4,400万のHTTP/2リクエスト）
- **Amazon CloudFront HTTP/2 → H3アドバタイズ**: 100%（HTTP/3をアドバタイズする2,800万のHTTP/2リクエスト）
- **オリジンサーバー HTTP/2 → H3アドバタイズ**: 99.89%（HTTP/3をアドバタイズする5,400万のHTTP/2リクエスト）

このデータは、HTTP/2を使用するCDNがAlt-SvcヘッダーでHTTP/3の可用性をほぼ普遍的にアドバタイズし、ブラウザが後続リクエストでHTTP/3にアップグレードできることを示しています。この広範なプロトコルアドバタイジングは、ウェブ全体でHTTP/3のより広い採用を促進するのに役立ちます。

### Server-Timing

W3C Server-Timing仕様で定義された `Server-Timing` HTTPヘッダーは、サーバーがリクエスト処理に関するパフォーマンスメトリクスをブラウザに通知できるようにします。このヘッダーはパフォーマンスメトリクスを直接通信し、不透明なサーバー処理を観察可能でデバッグ可能なデータに変換します。CDNに特有のこととして、`Server-Timing`ヘッダーは追加の監視インフラを必要とせずに、CDNエッジ処理時間、オリジンフェッチ時間、またはキャッシュステータスへの透明性を提供するのに役立ちます。

{{ figure_markup(
  image="cdn-http-server-timing-headers-mobile.png",
  caption="サーバータイミングヘッダーの分布割合（モバイル）。",
  description="このグラフは主要CDNプロバイダーごとのサーバータイミングヘッダーを含むリクエストの割合を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=367855700&format=interactive",
  sheets_gid="139841583",
  sql_file="server_timing_adoption.sql"
  )
}}

`Server-Timing`ヘッダーの採用はCDN間で異なります。PressableとNexcess CDNはデフォルト設定によりリクエスト全体で100%の採用率を示しています。Akamai、Amazon CloudFront、Fastlyなどのような CDNはデフォルト以外の設定が必要で、採用率が低くなる可能性があります。ただし、セキュリティ、プライバシー、パフォーマンスに関するエンタープライズの懸念がこのオプトインアプローチを推進している可能性があります。

## CDNセキュリティヘッダー

CDNは、一般的な攻撃からユーザーを保護するセキュリティヘッダーを実装・適用することで、ウェブセキュリティにおいて重要な役割を果たしています。HTTP Strict Transport Security（HSTS）、X-Frame-Options（XFO）、Content Security Policy（CSP）などのセキュリティヘッダーは、中間者攻撃からクリックジャッキング、クロスサイトスクリプティングまであらゆる脅威を防ぐのに役立ちます。CDNはユーザーとオリジンサーバーの間に位置するため、オリジンが提供するものに関係なくこれらのヘッダーを挿入または変更でき、サイト運営者がセキュリティのベストプラクティスを展開しやすくします。

セキュリティの実装はCDNプロバイダーによって大きく異なり、デフォルト設定と設定可能性に関する異なる哲学を反映しています。一部のプロバイダーはセキュリティヘッダーを自動的に注入しますが、他のプロバイダーは明示的な設定を必要とし、セキュリティと柔軟性のバランスを取っています。

{{ figure_markup(
  image="cdn-http-avg-sec-headers-mobile.png",
  caption="HTTPセキュリティヘッダー数の分布（モバイル）。",
  description="このグラフは主要エンタープライズCDNプロバイダーごとのリクエストあたりの平均セキュリティヘッダー数を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=366378643&format=interactive",
  sheets_gid="1319551791",
  sql_file="security_headers_by_cdn.sql"
  )
}}

CloudflareとAmazon CloudFrontはどちらもセキュリティヘッダーの平均数が少なく、以下に示すように特定のヘッダーをより詳細に見てもこのトレンドは続いています。ヘッダー数はセキュリティ態勢の直接的な代理指標ではなく、CDNが自動注入する量と明示的な設定が必要な量を反映していることが多いです。

{{ figure_markup(
  image="cdn-http-sec-headers-mobile.png",
  caption="HTTPセキュリティヘッダーの分布（モバイル）。",
  description="このグラフは主要エンタープライズCDNプロバイダーごとのリクエストあたりの平均セキュリティヘッダー数を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=2063660063&format=interactive",
  sheets_gid="1319551791",
  sql_file="security_headers_by_cdn.sql"
  )
}}

FastlyとAkamaiは基本機能が有効化された際にセキュリティヘッダーのより安全なデフォルトを持っており、セキュリティヘッダーの高い採用率を促進しています。Amazon CloudFrontとCloudflareはセキュリティヘッダーを注入・適用するためにより多くのデフォルト以外の設定が必要で、採用率が低くなっています。

## 圧縮

圧縮はウェブコンテンツ配信に不可欠であり続け、ウェブサイトで利用可能な最も手軽なパフォーマンス最適化の1つを代表しています。ファイルサイズが小さくなることは、ページの読み込みが速くなり、帯域幅コストが低下し、ユーザーにとってより良い体験となることを意味します。ネットワーク速度が向上し接続オプションが拡大しても、圧縮はすべての種類のインターネット接続のパフォーマンス最適化において重要であり続けます。

現代の圧縮アルゴリズムは従来の方法に比べて大幅な改善を提供しており、CDNがこれらの高度な技術の採用をリードしています。圧縮アルゴリズムの選択は、圧縮率、CPU使用量、互換性要件のトレードオフを伴います。

2025年のデータセットから、一般的に使用されるいくつかの圧縮アルゴリズムが観察されました：

- **Gzip**: レガシースタンダード。広く互換性があるが効率は低い
- **Brotli**: Gzipより20〜26%優れた圧縮を提供する現代的アルゴリズム
- **Zstandard（Zstd）**: 優れた圧縮率と速度を持つ新興スタンダード

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="圧縮タイプの分布（モバイル）。",
  description="このグラフはモバイルリクエストにおけるCDNとオリジンのBrotli採用を示しています。CDNはリクエストの46%をBrotli圧縮形式で、42%をgzip圧縮形式で、12%をZstandardで提供しました。一方、オリジンはリクエストの39%をBrotli圧縮形式で、61%をgzip圧縮形式で提供しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=573344627&format=interactive",
  sheets_gid="950988863",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

CDNはBrotliとZstandard圧縮の採用をリードしています。2024年と比較して、Zstandardは2025年に3%から12%へと大幅な増加を見せました。しかし、2024年と同様にGzipはオリジンサーバーで使用される最大多数の圧縮アルゴリズムであり続けています（61% Gzip対39% Brotli）。

{{ figure_markup(
  image="cdn-types-compression-mobile.png",
  caption="CDN全体の圧縮分布（モバイル）。",
  description="CloudflareとGoogle CDNではBrotliの使用が普及している一方、Akamai、Amazon CloudFront、FastlyではGzipが多数を占めています。しかし、2024年と比較してBrotliとZstandardは大手CDNプロバイダーでの採用に向けた広範なトレンドを継続しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=2098646827&format=interactive",
  sheets_gid="1165034437",
  sql_file="distribution_of_compression_types_by_cdn.sql"
  )
}}

対象リソースの98%をBrotliで提供しているAutomatticを特に称えます！

採用率では依然として3位ですが、Zstandardは2024年に比べて2025年に進展を見せました。2024年にはFacebookのCDNだけがZstandardの統計的に測定可能な使用を示していたのに対し、2025年にはCloudflare（15%）とGoogle CDN（10%）の両方が測定可能な採用を示しました。Cloudflareの新しい圧縮デフォルトと設定オプションが観察されたデータを説明する可能性があります。データセットの例外はAmazon CloudFrontとAutomatticで、現在ネイティブでZstandard圧縮をサポートしていません。しかし、観察されたデータはCloudFrontがZstandardを使用してオリジンからすでに圧縮されたデータをパススルーしていることを示しました。これは、すべての主要CDNプロバイダーがサポートしていないにもかかわらず、コンテンツオーナーがZstandardを使用したいという要望を示しています。

### 今後の圧縮トレンド

将来を見据えて、業界は[辞書圧縮（Shared Brotli）](https://developer.mozilla.org/docs/Web/HTTP/Guides/Compression_dictionary_transport)を探求しており、以下のことが期待されています：
- 繰り返しコンテンツパターンに対して20〜40%優れた圧縮
- 関連リソース間での共有辞書
- 2024年にChromeオリジントライアルを開始
- 2025〜2026年にCDNサポートの展開が予定

これは圧縮最適化の次のフロンティアを表しており、Brotliの成功を基盤として構築されており、Web Almanacの将来のエディションで注目すべきものです。

## TLSの利用

Transport Layer Security（TLS）は安全なウェブ通信の基盤を形成しています。CDNは一貫して新しいTLSバージョンの採用をリードし、インフラのアップグレードを必要とせずにウェブサイトにセキュリティとパフォーマンスの向上をもたらしています。

### TLS 1.3の採用

TLS 1.3は、既知の脆弱性を持つ弱い暗号アルゴリズムを含む以前のバージョンと比較して、ウェブトラフィックの全体的なセキュリティを改善します。このプロトコルは最適化された設計によりハンドシェイクレイテンシも削減します。

**TLS 1.0と1.1の不在に関する注記**: 私たちの測定では、すべてのリクエストにわたってTLS 1.0と1.1の使用がゼロでした。これは、HTTP Archiveが測定に現代のChromeブラウザを使用しており、2020年7月（Chrome 84）にこれらの廃止されたプロトコルのサポートを完全に削除したためです。TLS 1.0または1.1のみをサポートするサーバーは、成功したリクエストではなく接続障害をもたらし、データに表示されません。これらのレガシープロトコルは一部のエンタープライズ環境やIoTデバイスにまだ存在する可能性がありますが、現代のブラウザがアクセスする公開ウェブサービスには使用できなくなっています。

ほぼすべてのCDNトラフィックがTLS 1.3を使用するようになり、99%のリクエストが最新プロトコルバージョンを活用しています。これにより接続確立時間が短縮され、ページの読み込み速度が直接的に改善されます。CDNプロバイダーは新しいウェブ技術の早期採用者であり続けており、CDNを使用するアプリケーションはほとんど追加の労力なしにこれらのパフォーマンスとセキュリティの向上を得ることができます。

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="HTMLのTLSバージョン分布（モバイル）。",
  description="CDNとオリジンから提供されるモバイルリクエストにおけるTLSバージョン使用状況のグラフ。モバイルとデスクトップの両方でCDN経由のTLS 1.3採用率が99%という同一の結果が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=464425722&format=interactive",
  sheets_gid="1943404486",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

オリジンサーバーのTLS 1.3採用は改善していますが、CDNは依然として自社のソフトウェアとハードウェアのアップグレードを管理する組織と比較して、新しい機能を展開する上での明確な優位性を示しています。

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="サードパーティリクエストのTLSバージョン分布（モバイル）。",
  description="CDNとオリジンから提供されるモバイルのサードパーティリクエストにおけるTLSバージョン使用状況のグラフ。CDNはサードパーティリクエストの96%をTLS 1.3で、4%をTLS 1.2で提供しました。一方、オリジンはリクエストの78%をTLS 1.3で、22%をTLS 1.2で提供しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1192406076&format=interactive",
  sheets_gid="1943404486",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

サードパーティコンテンツも同様のパターンを示しており、CDNリクエストの96%がTLS 1.3を使用しているのに対し、オリジンサーバーでは78%となっています。CDNの採用率は2024年の93%から2025年の96%へとわずかに増加した一方、オリジンサーバーは同期間に68%から78%へとより大きな増加を示しました。

### TLSパフォーマンスへの影響

**重要な測定コンテキスト**: 以下のTLSネゴシエーション時間は、管理されたデータセンター条件でChromeを使用したHTTP Archiveのシミュレートされたブラウザ接続から測定されています。これらの測定は最適なネットワーク条件とChromeのTLS実装を表しており、クライアント機能、ネットワーク品質、地理的分布の実世界のばらつきを反映しない可能性があります。さらに、ChromeはTLS 1.0/1.1をサポートしなくなったため、これらの測定はTLS 1.2と1.3のパフォーマンス特性のみをキャプチャしています。

TLSネゴシエーション時間は、CDNとオリジンサーバーの間の明確なパフォーマンス差を示しており、デスクトップとモバイル接続の間に追加のばらつきがあります。

デスクトップユーザーはすべてのパフォーマンスレベルで、オリジンサーバーに比べてCDNとのTLSネゴシエーションが大幅に速くなっています。CDNの中央値ネゴシエーション時間は57ミリ秒に対し、オリジンは177ミリ秒と3倍以上速くなっています。このパフォーマンスギャップは分布全体で持続しています。90パーセンタイルでは、CDNが89ミリ秒でネゴシエーションを完了するのに対し、オリジンは277ミリ秒を必要とします。

{{ figure_markup(
  image="tls-negotiation-desktop.png",
  caption="HTML TLSネゴシエーション - CDN対オリジン（デスクトップ）。",
  description="このグラフはCDNとオリジンの10、25、50、75、90パーセンタイルにわたるTLS接続時間（ミリ秒）の洞察を提供します。グラフから、TLSネゴシエーション時間はCDNで一般的に速いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1982994974&format=interactive",
  sheets_gid="1102115518",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

モバイルデバイスも同様のパターンを示しており、CDNがオリジンサーバーよりも優れたパフォーマンスを発揮していますが、全体のネゴシエーション時間はデスクトップと比較して高くなっています。モバイルCDNの中央値TLSネゴシエーション時間は183ミリ秒、オリジンサーバーは302ミリ秒です。90パーセンタイルでは、モバイルCDNが216ミリ秒かかるのに対し、オリジンサーバーは416ミリ秒を必要とします。

{{ figure_markup(
  image="tls-negotiation-mobile.png",
  caption="HTML TLSネゴシエーション - CDN対オリジン（モバイル）。",
  description="このグラフはCDNとオリジンの10、25、50、75、90パーセンタイルにわたるTLS接続時間（ミリ秒）の洞察を提供します。グラフから、TLSネゴシエーション時間はCDNで一般的に速いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=1994649079&format=interactive",
  sheets_gid="1102115518",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

モバイルデバイスは一般的に処理能力が限られており、ネットワーク条件が不安定なことが多いため、デスクトップよりも遅いパフォーマンスを示します。CDNがオリジンサーバーよりも優れたパフォーマンスを発揮するのは、主にその分散アーキテクチャのためであり、コンテンツをユーザーに地理的に近い場所に配置し、レイテンシを削減するために接続経路を最適化しています。

## 画像フォーマットと最適化

画像フォーマットはCDNにおいて引き続き重要な役割を果たし、ウェブサイトのパフォーマンス、帯域幅コスト、全体的なユーザー体験に直接影響を与えています。WebP、AVIF、SVGなどの現代的なフォーマットは、JPEGやPNGなどのレガシーフォーマットと比較して改善された圧縮率と視覚的な忠実度を提供し、最も効率的なオプションであり続けています。これらの効率性は、特にモバイルユーザーや高トラフィックサイトにとって重要な、より速いページ読み込みと低いデータ転送量へと変換されます。

現在、ほとんどのCDNはブラウザの機能を自動的に検出し、利用可能な最も最適化されたフォーマットを提供しています。例えば、ChromeにはAVIF、EdgeにはWebP、レガシーブラウザにはJPEGフォールバックです。アダプティブリサイズ、キャッシング、オンザフライ変換により、デバイスタイプや解像度にわたって静的画像バリアントを維持する必要性は大幅に排除されました。

{{ figure_markup(
  image="cdn-image-formats.png",
  caption="画像フォーマットの分布。",
  description="このグラフはモバイルデバイスで観察された画像フォーマットの内訳を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=985237215&format=interactive",
  sheets_gid="1565771127",
    sql_file="image_formats.sql"
  )
}}

2025年時点で、データは効率性重視のフォーマットへの継続的なシフトを反映しています。JPEGは依然として最もリクエストされるフォーマットですが、2022年と比較して全体で約10%減少し、モバイルではさらに急激な10.5%の減少が見られました。一方、WebP（+5%）、SVG（+2.5%）、AVIF（+3.1%）はすべて2022年以降着実に成長しています。これは業界サポートの逆転ではなく、サイト構成、画像パイプラインのデフォルト、またはフォールバック動作のシフトを反映している可能性があります。

GIFフォーマットは特にモバイルで（デスクトップより+0.5%高く）2.3%の緩やかな増加を示しており、アプリ駆動のウェブトラフィックで一般的なショートループアニメーションとUI要素によって推進されている可能性があります。一方、PNG使用量はわずかな減少（-0.8%）を示しており、デザイナーと開発者がベクターとラスターアセットの両方においてより軽量なフォーマットを優先し続けていることを示しています。

2024年と2025年の間で、AVIF（-1.9%）、SVG（-1.1%）、WebP（-1.8%）でわずかな後退があり、GIF（+2.3%）とJPEG（+2.2%）のわずかな回復で相殺されており、最適化が不十分な配信スタックにおけるフォールバックシナリオや互換性デフォルトの可能性を示しています。

2025年のデータは明確な軌跡を裏付けています：JPEGのようなレガシーフォーマットは依然としてリクエスト総数を支配していますが、より新しく効率的なフォーマットに徐々にシェアを譲っています。WebP、SVG、AVIFは、レイテンシと帯域幅効率が重要なモバイルファーストのエコシステムで特に、高パフォーマンスコンテンツ配信の新しいベースラインになりつつあります。

## クライアントヒント

クライアントヒントはUser-Agent文字列の代替として導入され、ウェブサーバーがHTTPヘッダーを通じてブラウザから特定の情報をリクエストできるようにします。デバイス情報、ユーザーエージェントの設定、ユーザー設定のメディア機能、ネットワーク詳細の4つの主要カテゴリに分類されます。これらのヒントはさらに高エントロピーと低エントロピーのタイプに分かれています。高エントロピーのヒントはフィンガープリンティングに使用される可能性があるため、ブラウザは通常、共有前にユーザーの許可を求めるか他のポリシーを適用します。低エントロピーのヒントはフィンガープリンティングへの有用性が低く、ブラウザまたはユーザーの設定に基づいてデフォルトで送信される場合があります。

2025年も、2024年に確立された同じ方法論を使用してクライアントヒントの測定を継続しました。レスポンスの `Accept-CH` ヘッダーを検出しています。

{{ figure_markup(
  image="cdn-client-hints-mobile.png",
  caption="クライアントヒントの比較（モバイル）。",
  description="このグラフはCDNにおけるクライアントヒントの使用率を示しています。現在、リクエストのわずか4%のみがクライアントヒントを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=185016365&format=interactive",
  sheets_gid="1035445628",
  sql_file="client_hints_cdn_vs_origin.sql"
  )
}}

クライアントヒントはCDNが採用をリードするという通常のパターンに反しています。CDN使用量は前年比横ばいだった一方、オリジンリクエストは2025年に約5%まで増加しました。可能性の高い要因は、エッジでのキャッシュキーの爆発であり、クライアントヒントを慎重なバケット管理なしに組み込むとキャッシュヒット率が低下する可能性があります。この課題が、テクノロジーの潜在的な利点にもかかわらず採用率が低いままである理由を説明している可能性があります。

## Early Hints

Early Hintsは <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8297#section-2">HTTP 103ステータスコード</a> を使用して、メインレスポンスの準備中にサーバーがブラウザに最初のヘッダーを送信できるようにします。これは、ページ全体の準備が整う前にスタイルシート、JavaScriptファイル、フォントなどの重要なリソースをプリロードするのに特に役立ちます。パフォーマンス向上の可能性があるにもかかわらず、採用は依然として最小限にとどまっています。

{{ figure_markup(
  image="cdn-early-hints-mobile.png",
  caption="Early Hintsの比較（モバイル）。",
  description="このグラフはCDNにおけるEarly Hintsの使用率を示しています。現在、リクエストのわずか0.012%のみがEarly Hintsを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS1h8gr-lNGf8NUYbAeY1_PJ75J5WJXTJDIpZ36oZkxXze64PaDkknKT2ALLUe0iU4VkQQhXpJAiQI8/pubchart?oid=698100070&format=interactive",
  sheets_gid="2050224779",
  sql_file="early_hints_cdn_vs_origin.sql"
  )
}}

Early Hintsへのブラウザサポートは広まっていますが、データセットではCDNリクエストのわずか0.012%という最小限の使用しか見られませんでした。これは2024年から2025年にかけてわずか0.002%の増加を示しています。Vercelは1%以上の採用（2.84%）をサポートした唯一のCDNで、CloudflareとFastlyは1%未満でした。

より多くのサイトがEarly Hintsを使用し始めるにつれて、パフォーマンスにどのような影響を与えるかを見ることに関心があります。来年のWeb Almanacまでに、より多くのCDNプロバイダーがこの機能を実装し、その影響に関する詳細な統計を共有できるだけのデータが集まることを期待しています。

## 結論

2024年にはCDNがHTTP/3などの新興技術の採用で先頭に立ち、そのパターンは2025年にも続いています。BrotliやZstandard圧縮、TLS 1.3暗号化などの機能を見ると、CDNはサーバー、ロードバランサー、ネットワーク機器の全フリートを刷新するのではなく、シンプルな設定変更でサイトがこれらの改善を実装しやすくしています。

2025年の分析では、CDNがウェブプロトコル進化の先陣を切っていることが明らかになりました。Cloudflareなどの主要プロバイダーはHTTP/3採用率69%を達成しているのに対し、オリジンサーバーは5%未満にとどまっています。この10〜15倍の差は、エッジインフラが次世代ウェブ標準の採用をどのように推進しているかを示しています。

2025年分析の主な発見：
- **プロトコルリーダーシップ**: CDNはHTTP/3採用率29〜45%に対し、オリジンは7%未満
- **セキュリティの優秀性**: CDNトラフィックの95.6%がTLS 1.3を使用、オリジンサーバーの77.7%と比較
- **圧縮革新**: Automatticなどのリーダーは97.5%のBrotli採用を達成し、Zstandardは前年比3%から12%へ成長
- **パフォーマンス優位性**: CDNはモバイルで19%高速、デスクトップでは60%高速なDNSレスポンスを提供

今年はHTTP/3をより深く調査し、2024年に初めて検討したEarly Hintsを再訪しました。初めてCDNのパフォーマンスとセキュリティを切り分け、2026年には両トピック間のトレードオフについてより深く掘り下げる予定です。当初はIPv6分析を含める予定でしたが、データが有意な結論を引き出すのに十分な信頼性を持っていませんでした。より堅牢な測定ができ次第、2026年のチャプターでIPv6の採用に取り組む予定です。

2025年のCDN環境は、これらのプラットフォームが単純なコンテンツ配信を大幅に超えて進化し、現代ウェブの必須インフラである包括的な最適化およびセキュリティプラットフォームとなっていることを示しています。

このチャプターのいくつかのトピックが拡張され、異なる視点からデータを提供している2025年版Web Almanacの[Security](./security)チャプターも読者に訪問することをお勧めします。

2026年も再びご参加ください。さらなるデータを収集・分析して、読者の皆さんと新しい洞察を共有できることを楽しみにしています。
