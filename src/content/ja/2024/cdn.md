---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: 2024年版Web AlmanacのCDNの章では、CDNの採用、トップCDNプレーヤー、CDNがTLS、HTTP/2+、Zstandard、Brotli、Early Hints、Client Hintsの採用に与える影響について解説します。
hero_alt: Web Almanacのキャラクターが雲からウェブページにプラグを差し込んでいるヒーローイメージ。
authors: [joeviggiano, pgjaiganesh, AlexMoening]
reviewers: [carolinescholles]
editors: [carolinescholles]
analysts: [pgjaiganesh, AlexMoening]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/15YXQQjyoQ0Bnfw9KNSz_YuGDiCfW978_WKEHvDXjdm4/
joeviggiano_bio: Joe Viggianoは、Amazon Web Servicesのプリンシパルソリューションアーキテクトで、メディア＆エンターテイメントの顧客が大規模にメディアコンテンツを配信するのを支援しています。
pgjaiganesh_bio: Jaiganesh Girinathanは、Amazon Web Servicesのプリンシパルソリューションアーキテクトで、顧客が高速で安全なデジタル体験を提供できるよう支援することを使命としています。
AlexMoening_bio: Alex Moeningは、Amazon Web Servicesのシニアエッジソリューションアーキテクトです。
featured_quote: CDNを利用するメリットは、単純なパフォーマンス向上だけにとどまりません。2024年、CDNはグローバルなスケーラビリティの実現、セキュリティ体制の強化、そして複雑な分散アプリケーションの展開を促進する上で、きわめて重要な役割を担っています。より多くのロジックをエッジにプッシュすることで、企業はオリジンサーバーの負荷を軽減しつつ、より応答性が高くパーソナライズされたユーザー体験を創出できます。
featured_stat_1: 70%
featured_stat_label_1: 上位1,000サイトのうちCDNを利用しているサイト
featured_stat_2: 3倍
featured_stat_label_2: p90でCDNを利用した場合のTLSネゴシエーションの高速化
featured_stat_3: 56%
featured_stat_label_3: CDN経由でBrotliを使用しているドメイン
doi: 10.5281/zenodo.14065633
---

## 導入

この章では、進化し続けるコンテンツデリバリーネットワーク（CDN）の状況と、今日のデジタルエコシステムにおけるその重要な役割について考察します。前回のCDNの章がまとまった2022年から2024年にかけて、CDNは大規模な事業だけでなく、小規模なサイトやアプリケーションにもその範囲を広げ、世界中にコンテンツを配信する上で基礎的な存在であり続けています。静的なコンテンツだけでなく、動的なパーソナライズされた体験、サードパーティの統合、エッジコンピューティングの配信を促進する上で、その重要性は増しています。

この章の重要な焦点は、HTTP/3やQuick UDP Internet Connections（QUIC）プロトコルのようなウェブ標準、プロトコル、そして新興技術の採用を推進する上でCDNが果たす極めて重要な役割です。また、CDNがどのようにパフォーマンス最適化技術の実装と普及の最前線にいるのかも探ります。

2024年においても、CDNはパフォーマンスの高いコンテンツ配信を促進するだけでなく、ファーストパーティおよびサードパーティのセキュリティソリューションを統合する包括的なプラットフォームとしても機能し続けると確信しています。

## CDNとは？

_コンテンツデリバリーネットワーク_ （CDN）は、ウェブコンテンツやアプリケーションに高い可用性、強化されたパフォーマンス、そして改善されたセキュリティを提供するために設計された、地理的に分散したサーバーのネットワークです。CDNの主な目標は、エンドユーザーに近い場所からデータを提供することで、遅延を最小限に抑え、コンテンツ配信を最適化することです。

ウェブアプリケーションの複雑化、ストリーミングサービスの成長、そしてeコマースやデジタルビジネスの需要の高まりによって、近年CDNの役割は大幅に拡大しました。2024年、CDNは幅広いオンライン活動とウェブアプリケーションの高度化を支える重要なインフラとなっています。

CDNは、単なるプロキシサーバーという本来の機能から大きく進化しました。今日のCDNが提供するサービスには、通常、次のようなものがあります。

* さまざまな種類のメディアに対するキャッシングとコンテンツの最適化
* ネットワークホップを最小限に抑え、パフォーマンスを最適化するインテリジェントなルーティングとロードバランシング
* ほぼリアルタイムの処理とパーソナライズを可能にするエッジコンピューティング機能
* 幅広いサイバー脅威から保護するための堅牢なセキュリティ機能
* ビジネスがウェブパフォーマンスを理解し、最適化するのに役立つ分析と洞察

CDNを利用するメリットは、単純なパフォーマンス向上だけにとどまりません。2024年、CDNはグローバルなスケーラビリティの実現、セキュリティ体制の強化、そして複雑な分散アプリケーションの展開を促進する上で、きわめて重要な役割を担っています。より多くのロジックをエッジにプッシュすることで、企業はオリジンサーバーの負荷を軽減しつつ、より応答性が高くパーソナライズされたユーザー体験を創出できます。

最後に、見過ごされがちな利点として、CDNがコンテンツをエンドユーザーの近くにキャッシュし、ビデオや画像などのファイルのサイズを最適化することで、持続可能性に貢献している点が挙げられます。これは、エネルギー消費量の削減と、コンテンツ配信に伴う二酸化炭素排出量の削減につながります。

### 注意事項と免責事項

他の観察研究と同様に、測定できる範囲と影響には限界があります。Web Almanacのために収集されたCDN利用に関する統計は、利用されている適用可能な技術に焦点を当てており、特定のCDNベンダーのパフォーマンスや有効性を測定することを意図したものではありません。これにより、どのCDNベンダーに対しても偏りがないことが保証されますが、同時に、これらがより一般化された結果であることも意味します。

以下は、私たちのテスト方法論の限界です。

- **シミュレートされたネットワーク遅延:** 私たちは、トラフィックを総合的に形成する専用のネットワーク接続を使用します。
- **単一の地理的な場所:** テストは単一のデータセンターから実行され、多くのCDNベンダーの地理的な分散をテストすることはできません。
- **キャッシュの有効性:** 各CDNは独自の技術を使用しており、多くはセキュリティ上の理由から、キャッシュのパフォーマンスや深さを公開していません。
- **ローカリゼーションと国際化:** 地理的な分散と同様に、言語や地域固有のドメインの影響も、これらのテストでは不透明です。
- **CDNの検出:** これは主にDNS解決とHTTPヘッダーを介して行われます。ほとんどのCDNはDNS CNAMEを使用してユーザーを最適なデータセンターにマッピングします。しかし、一部のCDNはAnycast IPまたは委任されたドメインからの直接のA+AAAA応答を使用しており、DNSチェーンを隠しています。他のケースでは、ウェブサイトは複数のCDNを使用してベンダー間でバランスを取っており、これはクローラーの単一リクエストパスからは隠されています。
- **IPv6の検出:** CDNがIPv6を使用するように設定されているかどうかは、ドメイン名のDNSエントリにAAAAエントリが含まれ、IPv6経由の接続を受け入れるかどうかで推測できます。2024年のテスト実行にはこの機能は含まれていませんでしたが、2025年のWeb Almanacではこのデータを収集できるようにしました。

これらすべてが、私たちの測定に影響を与えます。これらの結果は、サイトごとの特定の機能（たとえばTLSv1.3、HTTP/2+、Zstandard）のサポートを反映していますが、実際のトラフィック使用量を反映しているわけではありません。

これを念頭に置いて、CDNの文脈では意図的に測定されなかったいくつかの統計を以下に示します。

* Time To First Byte (TTFB)
* Time To Last Byte (TTLB)
* CDN Round Trip Time
* Core Web Vitals
* "Cache hit" versus "cache miss" performance

これらのうちのいくつかはHTTP Archiveデータセットで測定でき、その他はCrUXデータセットを使用することで測定できますが、我々の方法論の限界と一部のサイトで複数のCDNが使用されているため、測定が困難であり、誤って帰属される可能性があります。これらの理由から、この章ではこれらの統計を測定しないことにしました。

## CDNの導入

ウェブページは、以下の主要なコンポーネントで構成されています。

1. ベースHTMLページ（たとえば、`www.example.com/index.html`—しばしば`www.example.com`のような、より親しみやすい名前で利用できます）。
2. メインドメイン（`www.example.com`）およびサブドメイン（たとえば、`images.example.com`、または`assets.example.com`）上の画像、css、フォント、javascriptファイルなどの埋め込みファーストパーティコンテンツ。
3. サードパーティドメインから配信されるサードパーティコンテンツ（たとえば、Google Analytics、広告）。

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="モバイルにおけるCDN利用とホストされているリソースの比較",
  description="オリジンとCDNで分割されたCDN利用とホストされているリソースの棒グラフ。HTMLコンテンツでは、リクエストの67%がオリジンから、33%がCDNからです。サブドメインコンテンツでは、52%がオリジン、48%がCDNです。そしてサードパーティコンテンツでは、25%がオリジン、75%がCDNです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1624864055&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

上のグラフは、さまざまな種類のコンテンツ（HTML、サブドメイン、サードパーティ）に対するリクエストの内訳を示しており、モバイルデバイスでCDNとオリジンから提供されるコンテンツの割合を示しています（デスクトップでも同様の数値が観測されています）。

CDNは、フォント、画像ファイル、スタイルシート、JavaScriptなどの静的コンテンツの配信によく利用されます。この種のコンテンツは頻繁に変更されないため、CDNのプロキシサーバーにキャッシュするのに適しています。依然として、この種のリソース、とくにサードパーティのコンテンツではCDNがより頻繁に使用されており、75%がCDN経由で配信されています。

CDNは、ルートを最適化し、もっとも効率的な転送メカニズムを使用することが多いため、非静的コンテンツの配信においても優れたパフォーマンスを提供できます。しかし、HTMLの配信にCDNを使用する割合は、他の2種類のコンテンツに比べて依然としてかなり低く、CDN経由はわずか33%で、77%が依然としてオリジンから配信されています。

{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="モバイル向けにCDNから配信されるコンテンツのトレンド",
  description="このグラフは、過去数年間にCDNから配信されたコンテンツのトレンドを示しています。全体的な傾向として、CDNの利用は増加しています。サブドメインから配信されるコンテンツでは、より大きな増加が見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=776498107&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

上の図は、長年にわたるさまざまなコンテンツタイプのCDNからの配信の進化を示しています。

ベースとなるHTMLページ、サブドメイン、サードパーティのいずれにおいても、2024年は前年と比較して採用が増加しました。もっとも速いペースだったのはサードパーティで、2022年の67%から2024年には75%へと8%増加しました。

この継続的な軌跡の背景には、次のような理由が考えられます。

* リモートおよびハイブリッドな働き方の継続が、地理的に分散したユーザーベースへのコンテンツの一貫した配信の必要性を引き続き推進しています。
* 増大するセキュリティの脅威により、より多くの企業がCDNに組み込まれたDDoS緩和やWAF機能などのスケーラブルな保護を評価するようになりました。
* エッジコンピューティングの改善により、インフラのコンピューティングコストを削減しながら、よりリッチでパーソナライズされた体験が可能になりました。

{{ figure_markup(
  image="cdn-usage-ranking-mobile.png",
  caption="サイトの人気度別CDN利用率（モバイル）",
  description="この棒グラフは、Google CRUXのデータによるランキングを使用して、上位1,000、10,000、100,000、100万、1,000万の人気サイトおよび全サイトについて、モバイルサイトのCDN利用状況を分類して示しています。上位1,000および10,000サイトでは、CDNの採用率は60%を超えています。人気が低いサイトほど、採用率は低下する傾向にあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1083160290&format=interactive",
  sheets_gid="217214696",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

CDNの利用率は年々増加しており、とくにGoogle ChromeのUXレポート（CrUX）の分類によるもっとも人気のあるウェブサイトの間で顕著です。グラフが示すように、上位1,000のウェブサイトが70%でもっともCDN利用率が高く、次いで上位10,000サイトが69%、上位100,000サイトが60%となっています。最新の結果と比較すると、上位1,000から10,000のもっとも人気のあるウェブサイトのCDN利用率は6%増加し、上位100,000のウェブサイトのCDN利用率は8%上昇しました。

以前の版で述べたように、小規模サイトにおけるCDN利用の増加は、無料または手頃な価格のCDNオプションの台頭に起因すると考えられます。さらに、多くのホスティングソリューションが現在、サービスにCDNをバンドルしており、ウェブサイトがこの技術をより簡単かつ費用対効果の高い方法で活用できるようになっています。

## CDNプロバイダー

CDNプロバイダーは、一般的に2つのセグメントに分類できます。
1. **汎用CDN** – Akamai、Cloudflare、CloudFront、Fastlyなど、さまざまなユースケースに対応する幅広いコンテンツ配信サービスを提供するプロバイダー。
2. **専用CDN** – NetlifyやWordPressなど、特定のプラットフォームやユースケースに合わせて調整されたプロバイダー。

汎用CDNは、以下のような幅広い市場のニーズに対応しています。
* ウェブサイト配信
* モバイルアプリAPI配信
* ビデオストリーミング
* エッジコンピューティングサービス
* ウェブセキュリティサービス

これらの機能は幅広い業界にアピールしており、それはデータにも反映されています。

{{ figure_markup(
  image="top-cdns-html.png",
  caption="HTMLリクエストのトップCDN（モバイル）",
  description="HTMLリクエストを配信している上位CDNプロバイダーを示す箱ひげ図。CloudflareがHTMLリクエストの55%を配信してトップに立ち、次いでGoogleが23%、CloudFrontが6%、Fastlyが5%、Akamaiが2%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1061770688&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

上の図は、ベースHTMLリクエストのトップCDNプロバイダーを示しています。このカテゴリの主要ベンダーは、Cloudflareが55%のシェアを占め、次いでGoogle（23%）、Amazon CloudFront（6%）、Fastly（6%）、Akamai（2%）、そしてAutomatticとVercelがそれぞれ1%のシェアを占めています。

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="サブドメインリクエストのトップCDN（モバイル）",
  description="サブドメインリクエストを配信している上位CDNプロバイダーを示す箱ひげ図。Cloudflareがサブドメインリクエストの43%を配信してトップに立ち、次いでCloudFrontが27%、Googleが8%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=316214799&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

サブドメインリクエストについては、Amazon Cloudfrontのシェアが増加しました（19%から27%へ）。

これは、多くのユーザーがCDNサービスを提供するクラウドサービスプロバイダーにコンテンツを置いていることが要因です。クラウドサービスプロバイダーのCDNと並行してコンピューティングやその他のサービスを利用することで、ユーザーはアプリケーションを拡張し、エンドユーザーへのサービス提供のパフォーマンスを向上させることができます。

このカテゴリの主要ベンダーは、Cloudflare（43%）、Amazon CloudFront（27%）、Google（8%）、Akamai（3%）です。

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="サードパーティリクエストのトップCDN（モバイル）",
  description="サードパーティリクエストを配信している上位CDNプロバイダーを示す箱ひげ図。Googleがサードパーティリクエストの54%を配信してトップに立ち、次いでCloudflareが14%、CloudFrontが10%、Akamaiが5%、Fastlyが4%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=418936134&format=interactive",
  sheets_gid="551654600",
  sql_file="top_cdns.sql"
  )
}}

上の図は、サードパーティドメインの利用状況を浮き彫りにしており、Googleが54%の市場シェアでトップに立ち、次いでCloudflare（14%）、Amazon CloudFront（10%）、Akamai（5%）、Fastly（4%）といった有名なCDNプロバイダーが続いています。注目すべきは、Facebookもランキングで目立っており、4%のシェアを占めていることです。

これらのCDNは、特定のコンテンツ配信ワークフローを最適化するために専用に構築された機能を備えていますが、多くはクラウドサービス、セキュリティ、エッジコンピューティングなどのより大きなサービス提供にも付随しています。これらのサービスは、しばしばCDN自体と統合されて提供されるため、より広範なサービスエコシステムの一部として採用がさらに促進されます。

GoogleやFacebookのようなサードパーティプロバイダーは、広告配信やビーコンキャプチャの高いスループットレートを処理するために、CDNを完全に最適化し、専用に構築している場合があります。一方、CloudflareやAmazon CloudFrontのような他のプロバイダーは、機能のサブセットを最適化する場合があります。これらのより汎用的なCDNは、これらの機能を利用してマネージドサービスに統合し、たとえばグローバルなユーザーベースにマネージドAPIサービスを提供したり、ウェブセキュリティ目的でデバイスのクライアントサイド検査を実行するためにJavaScriptを動的に注入したりします。

## HTTP/3 (HTTP/2+) の採用

2022年6月にIETFによって公開された <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9114">HTTP/3</a> は、HTTP/2に続くHTTPネットワークプロトコルのメジャーリビジョンです。

HTTP/3のもっとも注目すべき違いは、従来のTCPの代わりにQUIC over UDPというプロトコルを使用することです。この変更により、とくにパケット損失やネットワークの混雑が多い環境で、遅延を削減し、より高速なデータ転送を可能にすることで、パフォーマンスが向上します。TLS v1.3は、クライアントからサーバーへのTCP + TLSネットワークプロトコルのハンドシェイクとラウンドトリップの数を減らす点で改善されましたが、QUICはセキュリティを犠牲にすることなく、これをさらに削減します。もう1つの重要な改善点は、ヘッドオブラインブロッキングの排除です。つまり、1つのリソースで配信の問題が発生しても、他のリソースは独立して読み込みを続けることができます。この強化された多重化と堅牢な暗号化により、QUICはより安全で効率的なブラウジング体験に貢献します。

ウェブサイト運営者にとって、CDNは複雑な実装の詳細をすべて処理し、必要に応じてHTTP/2への自動フォールバックを提供します。CDNによって可能になるこの体験は、運営者側で大きな技術的投資を必要とせずに、簡単な設定変更で実現できます。

HTTP/3の仕組み（詳細は[HTTP](./http)の章を参照）により、HTTP/3は最初の接続では使用されないことが多いため、代わりに「HTTP/2+」を測定しています。これらのHTTP/2接続の多くは、リピート訪問者にとっては実際にはHTTP/3である可能性があるためです（HTTP/3を実装しているサーバーはHTTP/2なしでは実装していないと仮定しています）。

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="HTMLのHTTPバージョン分布（モバイル）",
  description="この棒グラフは、モバイルHTMLリクエストにおけるCDNとオリジンでのHTTPバージョンの採用状況を示しています。CDNから配信されるモバイルHTMLリクエストでは、98%がHTTP/2以上のプロトコルで配信されたのに対し、オリジンから配信されるリクエストでは71%がHTTP/2以上のプロトコルで配信されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1385171364&format=interactive",
  sheets_gid="456632996",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

2022年には、CDNサーバーとオリジンサーバーの間でHTTP/2+の利用に著しい対照が見られました。CDNでのHTTP/2+の利用率が98%であるのに対し、オリジンでは71%と、依然として差はありますが、オリジンでのHTTP/2+の利用は2022年の42%から2024年には71%へと、採用が拡大し続けていることがわかります。

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="サードパーティリクエストのHTTPバージョン分布（モバイル）",
  description="この棒グラフは、モバイルでのサードパーティリクエストにおけるCDNとオリジンでのHTTPバージョンの採用状況を示しています。CDNから配信されるこれらのサードパーティリクエストでは、96%がHTTP/2以上のプロトコルで配信されたのに対し、オリジンから配信されるリクエストでは71%がHTTP/2以上のプロトコルで配信されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1384687606&format=interactive",
  sheets_gid="456632996",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

サードパーティドメインにおけるHTTP/2+の採用傾向は、上記のHTMLと同様です。2022年と比較して、HTTP/2+のCDN利用率は88%から96%に増加し、オリジンは47%から71%に増加しました。

全体として、過去数年間と比較して、CDNが新しいHTTPバージョンの採用をリードし続けている一方で、2024年にはオリジンサーバーが追いつき始めています。これは、CDNトラフィックのクリティカルマスがすでにHTTP/2+を使用している結果かもしれませんが、今後の章でこれらのトレンドが展開するにつれて、より深く掘り下げていくことを楽しみにしています。

## 圧縮

圧縮は、ウェブコンテンツ配信の基本的な側面であり続け、ユーザー体験とウェブサイトのパフォーマンスを最適化する上で重要な役割を果たしています。ネットワークを介して送信されるファイルのサイズを削減することで、圧縮はページの読み込み時間の短縮、帯域幅消費の削減、そして全体的なウェブブラウジング効率の向上に貢献します。ネットワーク速度の向上と多様な接続オプションの普及にもかかわらず、圧縮はあらゆる種類の接続においてインターネット体験を向上させる重要な要素であり続けています。

ウェブエコシステム内では、一般的に使用されるいくつかの圧縮アルゴリズムが観察されました。

* Gzip
* Brotli
* Zstandard (Zstd)

JPEG画像などのメディアファイルはすでに圧縮されていますが、HTML、スタイルシート、JavaScript、マニフェストファイルなどのテキストアセットは、パフォーマンスを最適化するために圧縮できます。1992年に作成された[Gzip](https://ja.wikipedia.org/wiki/Gzip)は、もっとも長く広く使用されている圧縮ですが、この章で見るように、[Brotli](https://ja.wikipedia.org/wiki/Brotli)はウェブエコシステム全体でテキストデータを圧縮するための事実上のアルゴリズムとなっています。2024年には、Facebookによって開発されたZstandardの出現も見られます。これらの各アルゴリズムにはそれぞれの長所とユースケースがあり、ウェブ全体での採用率は異なります。

以下は、Web Almanac 2024におけるCDNとオリジンサーバーで使用される圧縮タイプの分析で、ウェブコンテンツが配信のためにどのように最適化されているかの傾向を明らかにします。

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="圧縮タイプの分布（モバイル）",
  description="この棒グラフは、モバイルリクエストにおけるCDNとオリジンでのBrotliの採用状況を示しています。CDNはリクエストの55.89%をBrotli圧縮形式で、41.38%をgzip圧縮形式で配信しました。一方、オリジンはリクエストの41.83%をBrotli圧縮形式で、57.40%をgzip圧縮形式で配信しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1837507742&format=interactive",
  sheets_gid="1383966713",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

CDNはBrotliの採用をリードしており、CDNで配信されるコンテンツの55%以上がBrotli圧縮を使用しており、2022年の47%から増加しています。対照的に、オリジンサーバーから直接配信されるコンテンツの42%未満しかBrotliを使用していませんが、これは2022年の25%から増加しています。Gzipは依然としてオリジンサーバーで使用される主要な圧縮アルゴリズムですが、Brotliはその上昇傾向を続けています。

### Zstandard (Zstd) の採用

Zstandard（Zstd）は、Facebookによって開発され、2016年にリリースされた圧縮アルゴリズムです。圧縮率と速度のバランスが良いことを目指しており、ウェブコンテンツ配信シナリオにおいて、GzipやBrotliといった確立されたアルゴリズムの代替となる可能性があります。

2024年現在、ウェブコンテンツ配信におけるZstandardのブラウザサポートは大幅に改善されています。

* **Chrome:** バージョン121（2024年1月リリース）からデフォルトでサポート
* **Edge:** バージョン121（2024年1月リリース）からデフォルトでサポート
* **Firefox:** バージョン123（2024年3月リリース）からフラグ付きでサポート
* **Safari:** 最新バージョンではネイティブサポートなし
* **Opera:** バージョン108（2024年1月リリース）からデフォルトでサポート

これは、Zstandardがウェブコンテンツ配信で利用可能になる上で大きな変化を表しており、主要なChromiumベースのブラウザがネイティブサポートを提供するようになりました。

ブラウザサポートの最近の改善とZstdの技術的な能力にもかかわらず、我々のデータによると、ウェブコンテンツ配信におけるZstandardの採用は、GzipやBrotliと比較して依然として限定的です。CDNはZstandardの採用率がわずか2.72%であり、オリジンサーバーは0.70%です。

Zstdは利点を提供しますが、ウェブシナリオにおけるBrotliに対する実世界でのパフォーマンス向上は、まだ完全には確立されていないか、すべてのユースケースで急速な採用を促進するほど重要ではない可能性があります。Zstdの圧縮レベルと辞書圧縮の柔軟性は、特定の種類のコンテンツや配信シナリオにとってとくに有益である可能性があり、それが的を絞った採用につながる可能性があります。今後の章でこのデータをさらに探求することを楽しみにしています。

### 圧縮タイプの分布

{{ figure_markup(
  image="cdn-types-compression-mobile.png",
  caption="CDN間の圧縮の分布（モバイル）",
  description="Brotliの使用はCloudflareとGoogleのCDNで普及していますが、GzipはAkamai、Amazon CloudFront、Fastlyでは依然として大多数を占めています。しかし、2022年と比較すると、Brotliはより大規模なCDNプロバイダーでの採用に向けて広範なトレンドを続けています。我々のデータセットにおける例外はFacebookで、Zstandardの採用率が60%を超えていました。Facebookの戦略は、独自の圧縮アルゴリズムを使用してコンテンツ配信を最適化することであったため、この結果は予想通りです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=168908770&format=interactive",
  sheets_gid="1455879080",
  sql_file="distribution_of_compression_types_by_cdn.sql"
  )
}}

Brotliの使用はCloudflareとGoogleのCDNで普及していますが、GzipはAkamai、Amazon CloudFront、Fastlyでは依然として大多数を占めています。しかし、2022年と比較すると、Brotliはより大規模なCDNプロバイダーでの採用に向けて広範なトレンドを続けています。我々のデータセットにおける例外はFacebookで、Zstandardの採用率が60%を超えていました。Facebookの戦略は、独自の圧縮アルゴリズムを使用してコンテンツ配信を最適化することであったため、この結果は予想通りです。

## TLSの利用

### TLS 1.3の採用

CDNとオリジンの両方のリクエストが、古くて安全性の低いTLSバージョン1.0および1.1の提供から大部分が移行したことは朗報です。これは、クライアントがより近代的で安全なプロトコルを使用していることを意味します。

CDNはTLS 1.3を採用しており、リクエストの98%がこの最新バージョンを使用しています。TLS 1.3は安全な接続をより速く確立できるため、ウェブサイトの読み込みが速くなり、開発者にとっては素晴らしいことです。CDNは、コンテンツ配信とセキュリティを最適化するための新しい技術を採用する最前線にあり、アプリケーションをCDNでフロントに置くことで、最小限の労力で自動的にその恩恵を受けることができます。

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="HTMLのTLSバージョン分布（モバイル）",
  description="CDNとオリジンによって配信されるモバイルリクエストにおけるTLSバージョンの使用状況の棒グラフ。モバイルとデスクトップの両方で、CDNを介したTLS 1.3の採用率が98%であるという同じ結果が見つかりました。オリジンサーバーに直接接続する場合のモバイルとデスクトップもほぼ同じで、モバイルが73%、デスクトップが71%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=121226278&format=interactive",
  sheets_gid="1400986662",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

TLSがさまざまなデバイスタイプ（モバイル対デスクトップ）でどのように使用されているかを詳しく見ると、モバイルとデスクトップの両方でCDNを介したTLS 1.3の採用率が98%であるという同じ結果が見つかりました。オリジンサーバーに直接接続する場合のモバイルとデスクトップもほぼ同じで、モバイルが73%、デスクトップが71%でした。これは、2022年と比較してTLS 1.3の採用が大幅に増加したことを示しています。モバイルCDNのTLS 1.3トラフィックは2022年には87%でしたが、2024年には98%になり、オリジンサーバー経由では42%から73%になりました。

オリジンサーバーはTLS 1.3の採用に追いつき始めていますが、これは、ウェブサーバーのオペレーターが同じ新機能のためにソフトウェアとハ​​ードウェアのアップグレードを実行する必要がある場合よりも、CDNが新しい機能をより迅速に推進する方法をさらに示しています。

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="サードパーティリクエストのTLSバージョン分布（モバイル）",
  description="デスクトップ上のサードパーティリクエストにおけるTLSバージョンの使用状況を、CDNとオリジン別に示した棒グラフ。CDNはサードパーティリクエストの93%をTLS 1.3で、7%をTLS 1.2で配信しています。一方、オリジンはリクエストの68%をTLS 1.3で、32%をTLS 1.2で配信しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=125141741&format=interactive",
  sheets_gid="1400986662",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

サードパーティのTLS 1.3採用でも同様の話が見られ、CDNが93%、オリジンが68%です。2022年からCDNのTLS 1.3は88%から93%へとわずかに増加しましたが、他の結果と同様に、オリジンサーバーは2022年の26%から68%へと大幅に増加しました。

### TLSのパフォーマンスへの影響

TLSネゴシエーション時間は、CDNサーバーとオリジンサーバーの間、およびデスクトップデバイスとモバイルデバイスの間で大きな違いを明らかにします。

デスクトップユーザーの場合、CDNのパフォーマンスはすべてのパーセンタイルでオリジンサーバーよりも著しく高速です。CDNのTLSネゴシエーション時間の中央値（p50）は70ミリ秒ですが、オリジンサーバーでは183ミリ秒です。この傾向は他のパーセンタイルでも一貫しており、CDNはすべてのレベルでオリジンを上回っています。たとえば、90パーセンタイル（p90）では、CDNのネゴシエーション時間は108ミリ秒ですが、オリジンサーバーは289ミリ秒かかり、2.5倍以上長くなります。

{{ figure_markup(
  image="tls-negotiation-desktop.png",
  caption="HTML TLSネゴシエーション - CDN対オリジン（デスクトップ）",
  description="この棒グラフは、CDNとオリジンの10、25、50、75、90パーセンタイルにおけるTLS接続時間（ミリ秒）に関する洞察を提供します。グラフからわかるように、TLSネゴシエーション時間は一般的にCDNの方が高速です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1820997303&format=interactive",
  sheets_gid="846467421",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

モバイルデバイスも同様のパターンを示し、CDNはオリジンサーバーよりもパフォーマンスが優れていますが、全体的なネゴシエーション時間はデスクトップと比較して長くなっています。モバイルCDNのTLSネゴシエーション時間の中央値は196ミリ秒ですが、オリジンサーバーでは316ミリ秒です。90パーセンタイルでは、モバイルCDNは256ミリ秒かかりますが、オリジンサーバーは451ミリ秒を必要とします。

{{ figure_markup(
  image="tls-negotiation-mobile.png",
  caption="HTML TLSネゴシエーション - CDN対オリジン（モバイル）",
  description="この棒グラフは、CDNとオリジンの10、25、50、75、90パーセンタイルにおけるTLS接続時間（ミリ秒）に関する洞察を提供します。グラフからわかるように、TLSネゴシエーション時間は一般的にCDNの方が高速です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=899797304&format=interactive",
  sheets_gid="846467421",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

デスクトップとモバイルのTLSネゴシエーション時間を比較すると、リクエストがCDNから配信されるかオリジンサーバーから配信されるかに関係なく、モバイルデバイスの方が一貫してTLSネゴシエーション時間が長いことがわかります。たとえば、モバイルCDNのネゴシエーション時間の中央値（196ミリ秒）は、デスクトップCDN（70ミリ秒）のほぼ3倍です。この差はオリジンサーバーではそれほど顕著ではありませんが、それでも重要であり、モバイルの中央値時間（316ミリ秒）はデスクトップ（183ミリ秒）の約1.7倍です。

デスクトップとモバイルのパフォーマンスの差は、モバイルデバイスの処理能力が一般的に低く、ネットワーク接続が不安定である可能性があるためと考えられます。CDNがオリジンサーバーよりも優れたパフォーマンスを発揮するのは、CDNの分散型の性質によるもので、コンテンツをエンドユーザーに近づけ、より高速な接続のために最適化します。

## 画像フォーマットと最適化

画像フォーマットは、コンテンツデリバリーネットワーク（CDN）において重要な役割を果たし、ウェブサイトのパフォーマンス、ユーザー体験、および全体的な効率に大きな影響を与える可能性があります。WebPやAVIFのような最新の画像ファイルフォーマットは、JPEGやPNGのような従来のフォーマットと比較して優れた圧縮を提供します。これにより、ファイルサイズが小さくなり、ページの読み込み時間が短縮され、帯域幅の使用量が削減され、ユーザー体験が向上します。

ほとんどのCDNは、ユーザーのブラウザの機能を自動的に検出し、もっとも適切な画像フォーマットを提供できます。たとえば、ChromeブラウザにはAVIF、EdgeブラウザにはWebP、古いブラウザにはJPEGなどです。さらに、レスポンシブデザインの要件に対応するために、画像をその場でリサイズしてキャッシュすることもできます。これにより、サイト運営者は単一の高解像度画像をアップロードするだけで済み、サイトのレイアウトが進化してもすべてのバリエーションを維持する必要がありません。

{{ figure_markup(
  image="cdn-image-formats-mobile.png",
  caption="画像フォーマットの分布（モバイル）",
  description="この円グラフは、モバイルデバイス全体で観察された画像フォーマットの内訳を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=247539166&format=interactive",
  sheets_gid="918737048",
    sql_file="image_formats.sql"
  )
}}

2024年現在、データによると、JPEGやPNGのような従来のフォーマットが依然として主流である一方で、WebPやSVGのようなより効率的でモバイルフレンドリーなフォーマットを採用する明確な傾向があります。モバイルエコシステムは、一般的にほとんどのフォーマットでより高い数値を示しており、モバイルウェブ利用の重要性が高まっていることを反映しています。AVIFのような新しいフォーマットの存在は、すべてのデバイスでウェブパフォーマンスとユーザー体験を向上させるために不可欠な、より効率的な画像配信への業界の推進を示唆しています。

## Client Hints

最初にUser-Agent文字列からの情報を削減する方法として提案されたClient Hintsは、ウェブサーバーがクライアントから積極的にデータを要求することを可能にし、HTTPヘッダーの一部として送信されます。Client Hintsは、デバイス、ユーザーエージェントの好み、ユーザーの好みのメディア機能、およびネットワーキングの4つのカテゴリに分類されます。これはさらに、高エントロピーヒントと低エントロピーヒントに分類されます。高エントロピーヒントは、CDNや他のエンティティがフィンガープリントを作成する能力を提供する可能性があるため、通常はユーザーの許可やブラウザによって駆動される他のポリシーによってゲートされます。低エントロピーヒントは、クライアントがフィンガープリントされる能力を提供する可能性が低いです。低エントロピーヒントは、ユーザーまたはブラウザの設定に応じてデフォルトで提供される場合があります。

提供された情報に基づいて、サーバーは要求元のクライアントに応答するためのもっとも最適なリソースを決定できます。当初はGoogle Chromeブラウザ用に開発されましたが、他のChromiumベースのブラウザも採用していますが、他の人気のあるブラウザではClient Hintsのサポートが限定的またはまったくない状況が続いています。

CDN、オリジンサーバー、およびクライアントブラウザはすべて、Client Hintsを適切に利用するためにサポートする必要があります。フローの一部として、CDNはAccept-CH HTTPヘッダーをクライアントに提示して、クライアントが後続のリクエストに含めるべきClient Hintsを要求できます。我々は、CDNがこのヘッダーをリクエスト内で提供し、テストの一環として記録されたすべてのCDNリクエストでそれを測定したクライアントの応答を測定しました。

{{ figure_markup(
  image="cdn-client-hints-mobile.png",
  caption="Client Hintsの比較（モバイル）",
  description="この棒グラフは、CDNにおけるClient Hintsの使用状況を示しています。現在、リクエストのわずか4%しかClient Hintsがありません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=1795720470&format=interactive",
  sheets_gid="2034431888",
  sql_file="client_hints_cdn_vs_origin.sql"
  )
}}

2022年、Client Hintsの採用率はモバイルリクエストで1%未満でした。2024年の結果は、モバイルデバイスのリクエストの4%未満がClient Hintsの存在を示しており、増加はしましたが、観測されたリクエストの総量に対して、この機能の採用は依然として低いままです。今年の章では探求しませんでしたが、Client Hintsの採用が成長し続ける場合、将来の章では、CDNがキャッシング目的やよりパーソナライズされた体験のためにAccept-CHヘッダーをどのように使用しているかを測定するかもしれません。

## Early Hints

Early Hintsは、[HTTP 103ステータスコード](https://datatracker.ietf.org/doc/html/rfc8297#section-2)であり、サーバーがメインの応答が準備できる前に、予備のHTTPヘッダーをブラウザに送信できるようにします。これは、スタイルシート、JavaScript、フォントなどの重要なリソースをプリロードするのにとくに価値があります。

主要なブラウザはEarly Hintsをサポートしていますが、データセット全体で採用はほとんど見られませんでした。しかし、TLSv1.3などの他の新興機能と同様に、CDNはウェブサーバーへの直接サポートと比較して、採用を推進する上で引き続き先頭に立っています。それでも、CDNコミュニティの他の部分と比較して、CloudFlareとFastlyだけがEarly Hintsをある程度有意な数でサポートしているのを観測しました。

{{ figure_markup(
  image="cdn-early-hints-mobile.png",
  caption="Early Hintsの比較（モバイル）",
  description="この棒グラフは、CDNにおけるEarly Hintsの使用状況を示しています。現在、リクエストのわずか0.01%しかEarly Hintsがありません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRaKSyCfdyk5Qva05DCIxB4NPUI6VZASRpDfEIV9QsihS0nuKSEzWGh569LoaOnTW5NgHKTufv8ydlL/pubchart?oid=609256029&format=interactive",
  sheets_gid="954411290",
  sql_file="early_hints_cdn_vs_origin.sql"
  )
}}

Early Hintsの採用が増えるにつれて、ヒントが提供する可能性のあるパフォーマンスへの影響をさらに探求することを楽しみにしています。将来の章では、より多くのCDNがEarly Hintsを実装し、より詳細な統計を示すことができるようになることを期待しています。

## まとめ

2022年、私たちはCDNがHTTP/3などの新興技術の採用の原動力であることを観測しましたが、2024年もこの傾向は続きました。BrotliやZStandardのような圧縮タイプ、あるいは暗号化プロトコルTLS 1.3を見ても、CDNはウェブサーバー、ロードバランサー、その他のネットワークデバイスのフリートをアップグレードするのではなく、簡単な設定変更で実装の重労働を軽減します。

今年はEarly HintsとZStandard圧縮という新しいメトリクスを調査しました。2022年に追加されたClient Hintsと画像フォーマットを再検討しました。2025年には、HTTP/3のより詳細な情報を追加し、CDNがIPv6の採用にどのように影響を与えているかを掘り下げる予定です。

すべてのCDNは、キャッシュやネットワークおよびパブリックインターネットを介したビットの移動を最適化するために、カスタム開発または変更されたオープンソース技術を使用しています。このため、外部からCDNについて推測できる洞察には限界があります。しかし、私たちはドメインをクロールし、CDN上のドメインとそうでないドメインを比較しました。CDNが、ネットワーク層からアプリケーション層まで、ウェブサイトが新しいウェブプロトコルを採用するためのイネーブラーであったことがわかります。

コンテンツデリバリーネットワークは、インターネットのインフラストラクチャにとってますます不可欠になっており、その重要性が衰える兆しはありません。その技術は、インターネットに依存するビジネスにとって不可欠であり続け、スピード、信頼性、セキュリティを最前線に置いてシームレスな運用を保証します。

読者の皆様には、2024年版Web Almanacの[HTTP](./http)の章と[セキュリティ](./security)の章をご覧になることをオススメします。そこでは、この章のいくつかのトピックが拡張され、異なるレンズを通してデータが提供されています。

2025年に再び私たちと一緒に、より多くのデータを収集・分析し、読者の皆様と共有できる新しい洞察を見つけましょう。
