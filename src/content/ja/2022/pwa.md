---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: 2022年のWeb AlmanacのPWA章では、サービスワーカー（使用状況と機能）、Webアプリマニフェスト、Lighthouseの洞察、サービスワーカーのライブラリ（Workboxを含む）、そしてWebプッシュ通知について取り上げています。
authors: [diekus]
reviewers: [aarongustafson, tropicadri, webmaxru, Schweinepriester, beth-panx]
analysts: [beth-panx]
editors: [siwinlo, tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1PbzjhN%2D%2DjU9MGuWobw5L9EsmlVzI9tlbCe3_NKA7giU/
diekus_bio: Diego Gonzalezは、コスタリカ出身のコンピュータエンジニアで、Microsoft EdgeブラウザのPWAプラットフォーム機能のプロジェクトマネージャーとして働いています。
featured_quote: デスクトッププラットフォームとの統合を可能にする機能の増加が、業界の大手企業によるPWAの採用を促進しています。
featured_stat_1: 95%
featured_stat_label_1: デスクトップでJSONとして解析可能なマニフェストファイル
featured_stat_2: 63%
featured_stat_label_2: デスクトップPWAでのサービスワーカーからのインストールイベントの使用
featured_stat_3: 60%
featured_stat_label_3: ある程度Workboxを使用しているPWA
---

## 序章

プログレッシブウェブアプリ（PWA）の初期段階において、現代の高度なウェブアプリケーションの可能性を活用した2つの重要な機能がありました：オフラインサポートとデバイスのホーム画面に直接アイコンを表示すること。

これらの概念は、PWAをインストールした後に有効になり、通常はブラウザのURLバーに表示される「アンビエントバッジ」をタップすることでインストールプロセスが始まります。このバッジはユーザーにウェブサイトをインストールするよう促します。Samsung InternetやMozilla Firefoxなどのモバイルブラウザは、この振る舞いを明確にサポートした最初のブラウザの一部であり、一般的には["ホーム画面に追加"](https://developer.mozilla.org/ja/docs/Web/Progressive_web_apps/Guides/Making_PWAs_installable)として知られています。

5年前、これは画期的なアイデアでした。ウェブサイトがホーム画面から直接起動し、ユーザーがデバイスにインストールした他のアプリケーションと並んでリストされるようになりました。これは、ウェブアプリとOS固有の経験の間のギャップを縮小するための進歩の始まりでした。

A2HSシナリオは、モバイルおよびデスクトップの両方のコンテキストでホストOSに完全にインストールされ、深く統合されるウェブアプリへと進化しました。過去12か月間には、ブラウザがデスクトッププラットフォームとの緊密な統合を確実にするための重要なステップを踏み出しており、今年のアルマナックに追加された多くの新機能がこれらの変更を反映しています。これが2022年のPWAの状況です。

注：PWAはウェブプラットフォームの他の部分と孤立しているわけではありません。[Capabilities](./capabilities)に専用の章がありますが、今年はPWA内で使用されるこれらの新しい高度な機能の交差点を調査しました。

## サービスワーカー

[サービスワーカー](https://developer.mozilla.org/ja/docs/Web/API/Service_Worker_API)はPWAの中核技術の1つであり、オフラインアプリ、プッシュ通知の受信、バックグラウンド処理の実現者です。これらは、アプリケーションから期待されるほとんどの高度な体験の基盤となっています。また、データの更新を定義するためや、[PWA技術に基づくウィジェット](https://github.com/aarongustafson/pwa-widgets#rich-widgets)などの近代的な機能のためにも使用されています。

主要なブラウザ間でサービスワーカーの機能サポートに一貫性はありませんが、Webkitが[プッシュ通知](https://caniuse.com/push-api)のサポートを追加したことは大きな節目でした。今年初めに、Appleがデスクトッププラットフォームで[Push API](https://developer.mozilla.org/ja/docs/Web/API/Push_API)、[Notifications API](https://developer.mozilla.org/ja/docs/Web/API/Notifications_API)の関連部分をサポートし、[サービスワーカー](https://developer.mozilla.org/ja/docs/Web/API/Service_Worker_API)がWebプッシュを有効にする変更を行ったと発表されました。また、この機能が2023年にモバイルプラットフォームにも導入される予定です。

### サービスワーカーの使用

比較のために、昨年と同じクエリを実行して、サービスワーカーの使用の進化を理解しようとしました。昨年の章では、[サービスワーカーの実際の使用状況を見つけることが簡単ではない理由](../2021/pwa#サービスワーカーの利用状況)を説明しましたが、今年も同様です。

2つの指標を見てみましょう：

- Lighthouseは、すべてのウェブサイトの1.6%（モバイル）および1.7%（デスクトップ）がサービスワーカーを使用していることを検出しています。これは、Lighthouseが考慮する[追加チェック](https://web.dev/service-worker)のため、実際の世界の割合よりも低いと予想されます。
- 昨年導入された同じ[メトリックス](https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/pwa.js)にしたがって、ウェブサイトでのサービスワーカーの使用率はデスクトップで1.63%、モバイルで1.81%です。

{{ figure_markup(
  image="sw-controlled-pages-rank.png",
  caption="ランク別のサービスワーカー制御ページ。",
  description="棒グラフは、デスクトップでは上位1,000のウェブサイトの8.3%がサービスワーカーを使用していることを示しています。これは、上位10,000のデスクトップページでは8.0%、上位100,000では4.5%、上位1癎では2.2%、そして私たちの全データセットでは1.4%です。モバイルも同様に8.7%、7.9%、4.7%、2.3%、そして1.4%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1762012854&format=interactive",
  sheets_gid="2067971287",
  sql_file="sw_adoption_over_time_ranking.sql"
  )
}}

上位1,000のサイトにおけるサービスワーカー制御ページに顕著な変化はありませんでした。デスクトップではわずかな減少、モバイルではさらに小さな増加がありましたが、他のすべてのカテゴリでは増加が見られました。昨年の[推論](../2021/pwa#fig-2)に従えば、大きなウェブサイトが先に高度な技術を採用するという仮説、他のカテゴリでの成長を見るのは理にかなっています。より多くのトラフィックを持つ企業からの事例研究や例を共有することで、小さな企業や開発者が技術を学び、採用したと思われます。

### サービスワーカーのイベント

サービスワーカーは、ウェブアプリ、ブラウザ、ネットワークの間に位置するプロキシサーバーとして機能します。サービスワーカーをインストールするには、フェッチして登録する必要があります。これが成功すると、サービスワーカーはメインスレッドから切り離され、DOMへのアクセスがない[特別なワーカーコンテナ](https://developer.mozilla.org/ja/docs/Web/API/ServiceWorkerGlobalScope)で実行されます。この時点でイベントが処理されます。

{{ figure_markup(
  image="most-used-sw-events.png",
  caption="もっとも使用されているサービスワーカーのイベント。",
  description="棒グラフは、デスクトップで63%、モバイルで61%のPWAウェブサイトで`install`が使用されており、`activate`はそれぞれ63%と61%、`notificationclick`は57%と51%、`push`は56%と51%、`fetch`は49%と50%、`notificationclose`は15%と16%、`sync`は6%と5%、そして最後に`periodicsync`は両方で0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1426457626&format=interactive",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
  )
}}

前述のグラフは、もっとも使用されているサービスワーカーのイベントに関する情報を示しています。これらのイベントは以下のカテゴリに分類されます：

- ライフサイクルイベント
- 通知関連イベント
- バックグラウンド処理イベント

#### ライフサイクルイベント

`install`と`activate`はライフサイクルイベントです。インストール時にオフラインでアプリを実行するためのアセットのキャッシュを作成するのが一般的な方法です。アクティベーションは通常、以前のサービスワーカーに関連付けられた古いキャッシュをクリーンアップするために使用されます。

{{ figure_markup(
  caption="モバイルにおける`install`イベントのサービスワーカーイベント。",
  content="61%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

サービスワーカーは、fetchやpushなどのイベントを受け取るためにアクティブである必要があります。これにより、`install`のデスクトップでの使用率63%、モバイルでの使用率61%、そして`activate`も同様に、サービスワーカーの要となります。

サービスワーカーを持つ残りの約40%のサイトは、これらのイベントを積極的に使用していないかもしれません。これは、通知のためにサービスワーカーを使用しているか、またはサイトが稼働しているときにのみリクエストのキャッシュを行う技術、いわゆる[ランタイムキャッシング](https://web.dev/runtime-caching-with-workbox/)を利用している可能性があります。

これらが依然としてもっとも使用されているイベントである一方で、他のタイプのイベントの使用増加は、サービスワーカーが事前キャッシュのためだけに（のみで）使用されているわけではない、という仮説を導くものです。

#### 通知関連イベント

{{ figure_markup(
  caption="デスクトップにおける`notificationclick`イベントのサービスワーカーイベント。",
  content="57%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

プッシュ通知イベントは、もっとも使用されているサービスワーカーメソッドの次に来ます。

- `notificationclick`はデスクトップで57%（昨年のデータから<span class="numeric-good">▲11%</span>）、モバイルで51%（<span class="numeric-good">▲5%</span>）です。
- `push`はデスクトップで56%（<span class="numeric-good">▲12%</span>）、モバイルで50%（<span class="numeric-good">▲5%</span>）です。
- `notificationclose`は現在、デスクトップで15%（<span class="numeric-good">▲9%</span>）、モバイルで16%（<span class="numeric-good">▲10%</span>）です。

ここでのいくつかのポイントは、デスクトップでのPWAの勢いが今年も続いており、プッシュ通知も例外ではないということです。通知に関連するイベントの使用は約11%増加しています。さまざまなプラットフォームで多くの調整と修正が行われ、これらのUXがホストOSと完全に統合されるようになっています。新たに発表された[WebkitにおけるWebプッシュのサポート](https://webkit.org/blog/12945/meet-web-push/)にしたがって、これらの数字が増加し続けることが期待されます。これは多くの開発者から長い間要望されていた機能であり、ついにmacOSでサポートされ、そして間もなくiOSデバイスでもサポートされることが開発者にAPIの使用を促すかもしれません。

#### バックグラウンド処理イベント

{{ figure_markup(
  caption="デスクトップにおける`fetch`イベントのサービスワーカーイベント。",
  content="49%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

チャートの残りのイベントはバックグラウンド処理イベントを表しています：
- `fetch`は、リクエストがサーバーに送信されると発生し、該当のリクエストを傍受してカスタムまたはキャッシュされたアセットで応答することができ、PWAのオフラインサポートを可能にします。Fetchの使用率はデスクトップで49%、モバイルで50%です。
- `sync`は、UAがユーザーが接続を持っていると考えるときに発火し、デスクトップで6%、モバイルで5%の使用率です。
- `periodicsync`は、ウェブアプリケーションが定期的にバックグラウンドでデータを同期することを可能にし、現在、デスクトップとモバイルプラットフォームの両方で0.01%です。`periodicsync`は最大12時間に1回と制限されています。この制限が機能の使用を人為的に抑制している可能性があります。

### その他の人気のあるSW機能

{{ figure_markup(
  image="usage-skip-waiting.png",
  caption="`skipWaiting()`メソッドの使用状況。",
  description="棒グラフは、デスクトップで60%、モバイルで59%のウェブサイトで`skipWaiting()`メソッドが使用されていることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=174072819&format=interactive",
  sheets_gid="58784102",
  sql_file="sw_methods.sql"
  )
}}

昨年の[統計](../2021/pwa#その他、人気のあるサービスワーカーの機能)と同様に、サービスワーカーを直ちにアクティブにするために使用される[`skipWaiting`](https://developer.mozilla.org/ja/docs/Web/API/ServiceWorkerGlobalScope/skipWaiting)メソッドは、依然として開発者の間で非常に人気があり、デスクトップの60%、モバイルのウェブアプリの59%で使用されています。

これらはもっとも使用されているサービスワーカーオブジェクトのトップです：

{{ figure_markup(
  image="most-used-sw-objects.png",
  caption="もっとも使用されているサービスワーカーオブジェクト。",
  description="棒グラフは、`clients`オブジェクトがデスクトップの93%、モバイルの87%のウェブサイトで使用されており、`caches`はそれぞれ45%と44%、`cache`は21%と21%、そして最後に`client`はデスクトップの12%、モバイルのPWAウェブサイトの13%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1869777638&format=interactive",
  sheets_gid="1746822463",
  sql_file="sw_objects.sql"
  )
}}

{# TODO Anything to say about this graph? #}

これらはもっとも使用されているメソッドです：

{{ figure_markup(
  image="most-used-sw-objects-methods.png",
  caption="もっとも使用されているサービスワーカーオブジェクトのメソッド。",
  description="棒グラフは、`clients.matchAll`がデスクトップの61%、モバイルのPWAサイトの55%で使用されており、`clients.claim`はそれぞれ58%と58%、`clients.openWindow`は56%と51%、`caches.open`は44%と43%、`caches.delete`は29%と24%、`caches.match`は25%と28%、`caches.keys`は21%と18%、`cache.put`は12%と14%、`client.url`は10%と11%、そして最後に`cache.add`はデスクトップの8%、モバイルのPWAサイトの7%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1209078963&format=interactive",
  sheets_gid="1969934262",
  sql_file="sw_methods.sql"
  )
}}

{# TODO Anything to say about this graph? #}

## Webアプリマニフェスト

_Webアプリマニフェスト_ ファイルは、アプリケーション自体に関する情報を含むJSONファイルです。マニフェストファイルは、PWAを定義するもう1つの主要なコア技術です。キーと値のペアに含まれるデータには、アプリをホストOSに表示、促進、統合するための関連情報があります。

Webアプリのマニフェストを完全に記述しておくことは、オンラインリポジトリへの高度な発見性を利用したり、アプリケーションストアへの提出、さらには最近ではアプリのシェアターゲットやファイルハンドリングなどの高度な機能にアクセスする方法としても不可欠です。<a hreflang="en" href="https://github.com/aarongustafson/pwa-widgets#how-widgets-are-represented-in-these-apis">PWA技術に基づいたウィジェットを有効にする</a>ための最先端の作業もマニフェストに根ざしており、さらなる高度なプラットフォーム統合のためのファイル自体の多様性を証明しています。

{{ figure_markup(
  caption="デスクトップで解析可能なマニフェストファイルの割合。",
  content="95%",
  classes="big-number",
  sheets_gid="717325565",
  sql_file="manifests_not_json_parsable.sql"
)
}}

ほとんどの場合、デスクトップで95%、モバイルで94%我々が見つけたマニフェストはJSONとして解析可能です。これは、マニフェストを使用するほぼすべてのWebアプリが正しく形成されていることを示しています。

これは、Webアプリのインストールに寄与する特定のフィールドの完全性や最小限の可用性を示すものではありません。実際、マニフェストファイルには現在必要なプロパティがありません。技術的には空のファイルでも有効なマニフェストファイルです。

マニフェストファイルは、ブラウザがインストールを促すための信号を送る上で重要な役割を果たしますが、プロンプトのトリガー方法は<a hreflang="en" href="https://web.dev/installable-manifest/#in-other-browsers">ブラウザによって異なります</a>が、常にマニフェストファイルのサブセットが関与しています。

以下は、マニフェストファイルとサービスワーカーの使用状況の数値です。これら2つが一緒に使用されることは、一般的にインストール可能性を意味します。

{{ figure_markup(
  image="sw-manifest-usage.png",
  caption="サービスワーカーとマニフェストの使用状況。",
  description="Webアプリにおけるサービスワーカー、マニフェストファイル、およびそれらの組み合わせの使用状況を示す棒グラフ。デスクトップではサービスワーカーが1.6%のウェブサイトで、マニフェストが8.4%、いずれかが9.2%、両方が0.8%のWebアプリで使用されています。モバイルでも同様に1.8%、7.7%、8.6%、そして0.8%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=409958839&format=interactive",
  sheets_gid="1885116887",
  sql_file="manifests_and_service_workers.sql"
  )
}}

データからは、Webアプリケーションがマニフェストファイルを持っている可能性がサービスワーカーよりも約5倍高いことがわかります。多くのプラットフォーム、たとえばコンテンツ管理システム（CMS）がウェブサイトのマニフェストファイルを自動生成するため、このような状況が生じています。

デスクトップとモバイルのウェブサイトのわずか0.8%がサービスワーカーとマニフェストファイルの両方を実装しており、これは伝統的なアプリのようにデバイスにインストールできるウェブサイトが1%未満であることを意味します。

この章では、主にサービスワーカーとマニフェストの両方を持つサイトに興味がありますので、とくに注記されていない限り、この章に提示されているマニフェストデータはPWAサイトのものです。

### マニフェストのプロパティ

{{ figure_markup(
  image="top-pwa-manifest-props.png",
  caption="PWAマニフェストの主要なプロパティ。",
  description="棒グラフは、`name`がデスクトップPWAサイトの87%、モバイルPWAサイトの88%で使用されており、`display`はそれぞれ83%と85%、`icons`は81%と83%、`short_name`は78%と81%、`start_url`は77%と81%、`background_color`は78%と80%、`theme_color`は73%と76%、`description`は38%と37%、`lang`は24%と24%、そして最後に`gcm_sender_id`は23%と21%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=314127541&format=interactive",
  sheets_gid="400343770",
  sql_file="top_manifest_properties.sql"
  )
}}

昨年と比較して、マニフェストファイルで使用される主要なプロパティに顕著な変化はありません。

`gcm_sender_id`は標準化されたプロパティではなく、Google Developer Consoleがアプリを識別し、古いバージョンのChromeがGCMサービスに依存するWebプッシュを実装するのに使用されます。

ほとんどのPWAでは、デスクトップで80%、モバイルで79%が優先的な向きを定義していません。設定されている場合、もっとも頻繁に使用される値は「portrait」で、デスクトップで13%、モバイルウェブサイトで15%がその値をマニフェストで定義しています。

#### `display` プロパティ

`display`プロパティをさらに詳しく見ると、以下の値があります：

{{ figure_markup(
  image="display-values.png",
  caption="PWAマニフェストのdisplay値。",
  description="棒グラフは、`standalone`がもっとも一般的なdisplay値で、定義されたdisplayモードを持つウェブサイトの約3/4に該当し、デスクトップで71%、モバイルで73%が使用しています。`minimal-ui`はそれぞれ8%と7%、`fullscreen`は3%と4%、`browser`は1%と1%、そしてデスクトップで17%、モバイルで15%のPWAサイトで設定されていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=463813741&format=interactive",
  sheets_gid="264101844",
  sql_file="top_manifest_display_values.sql"
  )
}}

`display: standalone`モードは、もっとも一般的な表示モードで、表示モードを定義するウェブサイトの約3/4が使用しています。これは、アプリがインストール可能になる表示モードの1つでもあります。

#### `icons` プロパティ

{{ figure_markup(
  image="top-icon-sizes.png",
  caption="PWAマニフェストのアイコンサイズのトップ。",
  description="棒グラフは、`192x192`がデスクトップのPWAサイトの72%、モバイルの74%でマニフェストアイコンサイズとして使用されており、`512x512`はそれぞれ72%と69%、`144x144`は34%と32%、`96x96`は25%と24%、`72x72`は22%と22%、`384x384`は20%と18%、`48x48`は19%と18%、`152x152`は16%と15%、`120x120`は12%と11%、`256x256`は12%と10%、`128x128`は10%と11%、`64x64`は9%と7%、`36x36`は9%と8%、`32x32`は5%と5%、そして最後に`180x180`はデスクトップで4%、モバイルで5%のPWAサイトで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1961814023&format=interactive",
  sheets_gid="1009563515",
  sql_file="top_manifest_icon_sizes.sql"
  )
}}

PWAは、アプリが広告されたり配置されるさまざまな場所に対応するために、異なるアイコンサイズを生成する必要があります。異なるデスクトップおよびモバイル環境に必要な多数のアイコンを生成するための多くのツールが存在します。マニフェストファイルに存在する2つのもっとも一般的なアイコンサイズは`192x192`と`512x512`です。これらのサイズは分析されたマニフェストファイルの約70%に登場します。

#### インストールと発見性のプロパティ

Webアプリマニフェストファイルには、アプリケーションの説明に役立つデータが含まれている場合があります。これらのプロパティは、アプリケーションを促進するためにストアやその他の配布メカニズムによって使用されることがあります。<a hreflang="en" href="https://developer.chrome.com/blog/richer-pwa-installation">より豊かなブラウザベースのインストールダイアログ</a>の成長もこれらのフィールドをより顕著に利用しています。マニフェストファイルのアプリケーション情報サプリメントの一部として見つかる関連フィールドは以下の通りです：

* `description`: このプロパティは、デスクトップの36%とモバイルの34%のWebアプリマニフェストに存在します。説明はアプリケーションの機能を説明するために重要であり、通常はストア向けにアプリに関する情報を提供するために使用されます。現在、インストール可能なPWAの約3分の1がこの情報を提供しています。
* `screenshots`: このプロパティは、アプリストアやブラウザのインストールプロンプトで使用する1つ以上のスクリーンショットのURLを提供します。この機能を利用するマニフェストを持つPWAは、デスクトップで1.12%、モバイルデバイスで1.19%です。
* `categories`: カタログの組織化のためのヒントとして使用されます。
* `iarc_rating_id`: Webアプリの<a hreflang="en" href="https://www.globalratings.com/how-iarc-works.aspx">IARC認証コード</a>を表す文字列です。デスクトップとモバイルアプリの0.05%が、アプリやゲームの評価を広告するためにこのフィールドを利用しています。

#### マニフェストのカテゴリ

カテゴリについてもう少し詳しく見てみましょう。

{{ figure_markup(
  image="top-pwa-manifest-cats.png",
  caption="PWAマニフェストのトップカテゴリ。",
  description="棒グラフは、`shopping`がデスクトップの0.31%、モバイルの0.27%のPWAサイトで設定されたカテゴリで、`news`はそれぞれ0.27%と0.28%、`business`は0.18%と0.16%、`lifestyle`は0.15%と0.15%、`social`は0.12%と0.18%、`education`は0.16%と0.12%、`entertainment`は0.13%と0.14%、`productivity`は0.07%と0.06%、`magazines`は0.06%と0.07%、そして最後に`sports`はデスクトップで0.07%、モバイルで0.06%のPWAサイトで設定されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2026035912&format=interactive",
  sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

また、PWAサイトだけでなく、すべてのウェブサイトについても同じデータを示します。これは私たちが「PWAサイト」として使用しているサービスワーカーを持つウェブサイトの定義です：

{{ figure_markup(
  image="top-manifest-cats.png",
  caption="マニフェストのトップカテゴリ。",
  description="棒グラフは、`news`がデスクトップで0.36%、モバイルで0.37%のサイトで設定されたカテゴリで、`shopping`は0.36%と0.34%、`business`は0.22%と0.20%、`social`は0.16%と0.24%、`entertainment`は0.18%と0.20%、`lifestyle`は0.19%と0.18%、`education`は0.21%と0.16%、`games`は0.09%と0.09%、`productivity`は0.09%と0.08%、`utilities`はデスクトップとモバイルのPWAサイトでそれぞれ0.08%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417728851&format=interactive",
  sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

PWAとウェブサイトのトップカテゴリは同じですが、それぞれがわずかに異なります。トップカテゴリはショッピング、ニュース、ビジネスです。

#### 高度な機能

マニフェストファイルは、最新のプラットフォーム機能の活用も可能にします。これらの機能により、高度なウィンドウ機能やホストOS内での動作の登録が可能になります。これらの機能の多くは最近プラットフォームに導入されたばかりであり、これらの新しいAPIの導入の始まりをこのデータが示していることを期待しています。

これらはあまり使われていない、より高度な機能であるため、[以前のマニフェストプロパティのトップのグラフ](#マニフェストのプロパティ)には表示されませんが、その使用状況を見る価値があります：

* `shortcuts`: デスクトップで6.2%、モバイルで4.3%のPWAがアプリ内の深いリンクへのショートカットを使用しています。
* `file_handlers`: インストールされたPWAが特定のファイル拡張子のハンドラーとして自身を登録することを可能にします。デスクトップで0.01%、モバイルで0.02%が`file_handlers`を使用しています。
* `protocol_handlers`: PWAは、事前定義されたプロトコルまたはカスタムプロトコルのハンドラーとして登録できます。現在の使用率はデスクトップで0%、モバイルウェブサイトで0.01%です。
* `share_target`: デスクトップで5.3%、モバイルで3.1%のPWAが共有データを受信するために自身を登録する能力を持っています。
* <a hreflang="en" href="https://wicg.github.io/window-controls-overlay/">ウィンドウコントロールオーバーレイ</a>: タイトルバーが通常占める領域を解放する機能はデスクトップ専用の機能です。この機能は最近Chromium 105で導入され、デスクトップPWAのマニフェストの0.01%がこれを利用しています。
* `note_taking`: デスクトップの0%とモバイルサイトの0.01%が、クイックノートを取るための便利な方法として特別な統合を利用しています。

#### ネイティブを優先するマニフェスト

{{ figure_markup(
  caption="モバイルの関連アプリケーションフィールドを持つマニフェストファイル",
  content="2.0%",
  classes="big-number",
  sheets_gid="228985826",
  sql_file="manifests_preferring_native_apps.sql"
)
}}

マニフェストには、`related_applications`フィールドにリストされたアプリケーションがウェブアプリケーションよりも優先されるべきかどうかを指定するプロパティがあります。これにより、ユーザーエージェントはウェブアプリの代わりに関連アプリのインストールを提案する可能性があります。分析されたすべてのマニフェストファイルの中で、デスクトップで2.3%、モバイルで2.0%のマニフェストがこのプロパティを設定しています。

## Fugu API

PWAは高度なウェブ機能と密接に関連しています。これらの機能は一般的にプロジェクトFuguの一部であり、これはChromiumプロジェクト内で孵化中の新しいウェブプラットフォーム機能のコレクションのコードネームです。

{{ figure_markup(
  caption="デスクトップでもっとも使用されているFugu API",
  content="8.8%",
  classes="big-number",
  sheets_gid="1110821491",
  sql_file="fugu.sql"
)
}}

ウェブプラットフォームに追加された機能の増加するリストから、ウェブで使用されているトップのAPIは以下の通りで、PWAにとって有用です：

<figure>
  <table>
    <thead>
      <tr>
        <th>API</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Web Share</td>
        <td class="numeric">8.8%</td>
        <td class="numeric">8.4%</td>
      </tr>
      <tr>
        <td>Add to Home Screen</td>
        <td class="numeric">8.6%</td>
        <td class="numeric">7.7%</td>
      </tr>
      <tr>
        <td>Service worker</td>
        <td class="numeric">4.2%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Push</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">1.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="もっとも使用されているFugu API。",
      sheets_gid="1110821491",
      sql_file="fugu.sql",
    ) }}
  </figcaption>
</figure>

これらについては詳しく掘り下げませんが、[Capabilities](./capabilities)の章でそれらをカバーしています。

## LighthouseによるPWAの洞察

<a hreflang="en" href="https://developer.chrome.com/docs/lighthouse">Lighthouse</a>はオープンソースで自動化されたツールで、Webページの品質を向上させるために使用されます。ウェブサイトに対して多数の監査を実行でき、PWA監査の専用カテゴリがあります。利用可能なデータからは、過去12か月間のPWAの状況について興味深い事実が明らかにされています。

### Lighthouse監査

{{ figure_markup(
  image="lighthouse-pwa-audits-desktop.png",
  caption="デスクトップのLighthouse PWA監査。",
  description="棒グラフは、`viewport` Lighthouse監査が全デスクトップウェブサイトの92%、デスクトップPWAサイトの99%で合格しており、`installable-manifest`はそれぞれ9%と90%、`apple-touch-icon`は42%と80%、`service-worker`は2%と69%、`themed-omnibox`は6%と62%、`splash-screen`は3%と51%、そして最後に`maskable-icon`は全デスクトップウェブサイトの1%とデスクトップPWAサイトの21%で合格しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2100711487&format=interactive",
  sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

一般的なWebサイトよりもPWAサイトでPWA監査に合格する頻度がはるかに高いのは驚くことではありませんが、<a hreflang="en" href="https://web.dev/viewport/#how-to-add-a-viewport-meta-tag">viewportメタタグ</a>や<a hreflang="en" href="https://web.dev/apple-touch-icon/#how-the-lighthouse-apple-touch-icon-audit-fails">apple-touch-iconメタタグ</a>の存在など、PWAサイトでなくても適用される（そして使用される）監査も多くあります。

{{ figure_markup(
  image="lighthouse-pwa-audits-mobile.png",
  caption="モバイルのLighthouse PWA監査。",
  description="棒グラフは、`viewport` Lighthouse監査が全モバイルウェブサイトの93%、モバイルPWAサイトの100%で合格しており、`content-width`はそれぞれ83%と95%、`installable-manifest`は8%と93%、`apple-touch-icon`は42%と79%、`service-worker`は2%と75%、`themed-omnibox`は5%と65%、`splash-screen`は3%と53%、そして最後に`maskable-icon`は全モバイルウェブサイトの1%とモバイルPWAサイトの21%で合格しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=51840174&format=interactive",
  sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

モバイルサイトのLighthouseデータを見ると、似たような統計が見られますが、モバイルのみの<a hreflang="ja" href="https://developer.chrome.com/docs/lighthouse/pwacontent-width?hl=ja">content-widthメタタグ</a>もここに表示され、両方によってうれしいことに合格されています。

viewportメタタグの存在は重要であり、ダブルタップでズームインするために300-350msの遅延を取り除くために役立ちます。さらに、モバイルデバイスでの利点として、アプリをデバイスの画面サイズに最適化します。ほぼすべてのウェブサイト（PWAかどうかにかかわらず）がこれを含んでいるのは驚くことではありません。

インストール可能なマニフェストも両方のトップ3リストに登場しています。予想通り、これはPWAサイトにとって非常に高い値を持っており、デスクトップで90.2%、モバイルで95.2%ですが、すべてのウェブサイトでは非常に低い値を持っています。これは、開発者がこれらをインストールすることを意図していないためと思われます。

最後に、`apple-touch-icon`はPWA関連のLighthouse監査で3番目に位置しています。iOS 1.1.3以来、Safari for iOSは開発者がホーム画面でウェブサイトまたはアプリを表す画像を指定する方法をサポートしています。これは主にモバイルデバイスで関連しています。

## Lighthouseスコア

Lighthouseインサイトセクションを締めくくるために、監査に基づいてPWAサイトの全体的なLighthouse PWAスコアを見てみましょう。

{{ figure_markup(
  image="lighthouse-scores-desktop.png",
  caption="デスクトップのLighthouseスコア。",
  description="棒グラフは、デスクトップで、10番目のパーセンタイルで全サイトの中央値のLighthouse PWAスコアは22、PWAサイトは44、25番目のパーセンタイルでは22と67、50番目のパーセンタイルでは22と78、75番目のパーセンタイルでは33と89、そして最後に90番目のパーセンタイルでは全サイトが33、PWAサイトが100です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1918292266&format=interactive",
  sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

{{ figure_markup(
  image="lighthouse-scores-mobile.png",
  caption="モバイルのLighthouseスコア。",
  description="棒グラフは、モバイルで、10番目のパーセンタイルで全サイトの中央値のLighthouse PWAスコアは20、PWAサイトは50、25番目のパーセンタイルでは30と70、50番目のパーセンタイルでは30と80、75番目のパーセンタイルでは40と90、そして最後に90番目のパーセンタイルでは全サイトが40、PWAサイトが100です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1463181209&format=interactive",
  sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

予想通り、PWAサイトはPWA監査のスコアがかなり高くなっています。これらの監査は、<a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/pwa">ドキュメント</a>で詳細に説明されているように、速度、信頼性、インストール可能性、その他のPWA要件を調べます。

また注目すべきは、PWAサイトの監査スコアの範囲（50-100）で、これは存在するPWAの違いを表しています。対照的に、他のウェブの範囲は比較的一貫しており（20-40）、これは以前に議論されたほとんどのサイトに関連する主要な2つの監査（ビューポートとアイコン）を反映しています。

## サービスワーカーのライブラリ

サービスワーカーは非常に強力なツールであり、そのAPIによって開発者は以前は不可能だったアプリ体験を作成できるようになります。たとえば、独自のオフライン体験を作成したり、パフォーマンスを向上させるためにアセットをキャッシュしたりします。しかし、ウェブアプリとネットワークの関係を扱うコードを作成することには複雑さや注意点が伴います。ここでライブラリが開発者の生活をより良くすることができる場所であり、サービスワーカーAPIを取り巻く高レベルの抽象化を提供します。

### Workboxの使用

<a hreflang="en" href="https://developer.chrome.com/workbox/">Workbox</a>は、開発者がサービスワーカーの使用を容易にするために作られたライブラリセットです。基本から他のWorkboxライブラリで再利用される<a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-core">workbox-core</a>まで、キャッシング戦略、バックグラウンド同期、プリキャッシングなど、より具体的なタスクまで幅広いライブラリが含まれています。

{{ figure_markup(
  image="workbox-usage.png",
  caption="PWAページでのWorkboxの使用。",
  description="棒グラフは、PWAページでのWorkboxの使用がデスクトップサイトで33%から59%に、モバイルサイトで32%から54%に増加したことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417225871&format=interactive",
  sheets_gid="1871711300",
  sql_file="workbox_usage.sql"
  )
}}

昨年と比較してWorkboxの使用に大きな増加が見られます。昨年はモバイルで33%だったのに対し、今年は54%に増加しており、デスクトップPWAのほぼ60%が何らかの形でWorkboxを使用しています。

サービスワーカーによって制御されるページ数の増加が最上位1,000のウェブサイトではなく、より詳細なカテゴリで見られたこと、そしてWorkboxの使用の増加から、Workboxの採用はトップのウェブサイトで技術が採用されるのを待っていた企業やウェブサイトの内部で起こっていると推測できます。または、完全にカスタムなサービスワーカーの実装が必要なく、Workboxのテスト済みパターンを最大限に活用できる場合もあります。

### Workboxパッケージ

Workboxは、開発者がサイトのニーズに応じてどの部分をプロジェクトに追加するか選択できるように構成されています。以下に示す使用状況は、現在の開発者がどのPWA機能を実装しているかを文書化するのに役立ちます。

{{ figure_markup(
  image="top-workbox-packages.png",
  caption="トップWorkboxパッケージ。",
  description="棒グラフは、`core`がトップの使用されているWorkboxパッケージで、デスクトップのPWAサイトの36%、モバイルの37%で使用されており、次に`sw`がそれぞれ29%と31%、続いて`routing`が28%と31%、`strategies`が23%と21%、`precaching`が22%と18%、`expiration`が10%と9%、`window`が9%と8%、`background-sync`が5%と4%、`cacheable-response`が4%と4%、そして最後に`navigation-preload`がデスクトップの4%、モバイルの3%のPWAサイトで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=205966463&format=interactive",
  sheets_gid="122135540",
  sql_file="workbox_packages.sql"
  )
}}

ここでも使用率の全体的な増加が見られ、`workbox-core`の基本ライブラリの使用が14%増加しました。`workbox-core`、`workbox-routing`、`workbox-strategies`は、異なるアーティファクトをWebアプリに提供するキャッシング戦略を作成するために使用されます。これらがすべてトップに位置しているのは、サービスワーカーの主要な利点を有効にするためです。

`workbox-precaching`の使用にもかなりのジャンプが見られます。プリキャッシングは、パッケージ化されたアプリが使用するモデルをエミュレートするために使用できます。`workbox-precaching`を使用すると、サービスワーカーのインストール時にキャッシュされるアセットを選択し、その後の訪問でこれらのアセットをより速く読み込むことができます。

驚くべきことに、`workbox-sw`の使用が増えていますが、これは<a hreflang="en" href="https://github.com/GoogleChrome/workbox/releases/tag/v5.0.0">Workbox 5</a>からWorkboxチームが開発者に`importScripts()`を使用して<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-sw">`workbox-sw`</a>（ランタイム）をロードするのではなく、Workboxランタイムのカスタムバンドルを作成することを奨励しているためです。Workboxチームは_workbox-sw_のサポートを続けますが、新しい技術が現在推奨されています。実際に、ビルドツールのデフォルトはその方法を優先するように変更されています。

この増加は、古いバージョンのWorkboxを使用しているライブラリから来ている可能性があります。たとえば、<a hreflang="en" href="https://github.com/facebook/create-react-app/blob/v3.4.4/packages/react-scripts/package.json#L82">`create-react-app`のバージョン3</a>などです。

### Webプッシュ通知

通知は、ユーザーとの再エンゲージメントのための強力な方法です。また、プラットフォーム固有のアプリケーションから期待される特徴の1つでもあります。通知はタイムリーで関連性があり、正確な情報を提供する完璧な方法であり、WebプッシュAPIによって提供されています。

#### Webプッシュ通知の受け入れ率

Web通知の実装が開発者やユーザーにとってもっともスムーズではなかったことを認めることができますが、それがどれほど有用なツールであるかも重要です。カレンダーの通知や購読の更新、ゲームなど、重要なのはユーザーがいつそれらをオンにするかを選択できることです。

通知が有用であるためには、<a hreflang="en" href="https://developers.google.com/web/fundamentals/push-notifications">タイムリーで、正確で、関連性がある必要があります</a>。通知の許可を求めるプロンプトを表示する際には、ユーザーがサービスの価値を理解している必要があります。開発者は、ブラウザの許可ダイアログを表示する前に、ユーザーが特定の通知から得られる利点を共有することで、ユーザーを通知に引き込むチャンスがあります。

{{ figure_markup(
  image="notification-acceptance.png",
  caption="通知の受け入れ率。",
  description="積み上げ棒グラフはデスクトップで通知の6%が受け入れられ、7%が拒否され、70%が無視され、17%が却下されています。モバイルでは通知の19%が受け入れられ、35%が拒否され、34%が無視され、13%が却下されています。モバイルでは受け入れるか拒否する割合がはるかに高く、無視する割合がはるかに低いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=148157045&format=interactive",
  sheets_gid="435156894",
  sql_file="pwa_notification_acceptance_rates.sql"
  )
}}

異なるプラットフォームでのUXの改善と通知サポートの成長にもかかわらず、通知の受け入れに大きな変化はありません。2020年初頭以来、デスクトップでの受け入れ率は約6%、モバイルで20%です。

デスクトップとモバイルの通知受け入れ率は共通の傾向を共有しており、通知を無視する傾向があります。無視の合計は、2020年2月の48%から2022年6月には70%まで上昇しました。モバイルプラットフォームでは、2020年2月の1.88%から今年の6月には34%まで驚異的に増加しました。通知の疲れと、セキュリティ、プライバシー、高度な機能に対するプロンプトの増加が部分的に原因であり、これを解決し、異なるプラットフォームでより良い統一されたUXを提供するための作業が行われています。

## 結論

2022年はPWAにとって素晴らしい年でした。デスクトッププラットフォームとの統合を可能にする機能の増加は、業界の大手企業によるこの技術の採用を推進しました。昨年は、プロトコルハンドラー、ウィンドウコントロールオーバーレイ、OSログイン時の実行などの高度な機能が導入され、PWAをアプリケーション開発の重要な技術として位置づけるようになりました。これは励みになりますが、ウェブプラットフォーム全体を代表するものではありません。サービスワーカーの使用率は、2021年のデータと比較して半分に減少しましたが、PWA技術を使用して構築された大規模なアプリケーションの台頭が見られました。

マニフェストファイルは引き続き健全な状態にあり、昨年からわずかに増加してデスクトップで95%に達しました。これらのファイルの正確さは素晴らしいですが、完全性にはまだ改善の余地が多く残されています。現在、すべてのウェブサイトの約0.8%しかインストール可能と見なされていません。`shortcuts`や`share_target`などの多くの高度な機能が、約5%のPWAで徐々に採用され始めています。`protocol_handlers`やウィンドウコントロールオーバーレイなどの他の機能は新しすぎて、データに影響を与えるには至っていません。今年はこれらのFugu APIの多くについての初期のスナップショットも提供しています。

通知の疲れは理解できることですが、ユーザーは正当な通知の使用例を要求し、評価しています。ブラウザベンダーは、侵入的でない許可リクエストの実験を行っており、Webプッシュ通知はプラットフォーム全体で一貫した体験を提供する利点があり、ユーザーが使用しているデバイスに関係なくリクエストした通知を提供します。

この情報があなたのPWAの旅に光を当て、開発者がAPI採用の現在の技術トレンドを理解するのに役立つことを願っています。
