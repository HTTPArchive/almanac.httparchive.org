---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: 2021 Web AlmanacのPWA編では、サービスワーカー（使い方と特徴）、Web Appマニフェスト、Lighthouseインサイト、サービスワーカーライブラリ（Workboxを含む）、Web Push通知と配信について解説しています。
authors: [demianrenzulli]
reviewers: [tunetheweb, webmaxru, jeffposnick, andreban, Schweinepriester, hemanth, thepassle, tropicadri]
analysts: [tunetheweb, demianrenzulli]
editors: [rviscomi]
translators: [ksakae1216]
demianrenzulli_bio: DemianはGoogleのWeb Ecosystems Consultingチームのメンバーで、アルゼンチンのブエノスアイレスに生まれ、現在はニューヨークを拠点に活動しています。Progressive Web AppsとAdvanced Capabilitiesにフォーカスしている。<a hreflang="en" href="https://web.dev/authors/demianrenzulli/">web.dev</a> でよく執筆している。
results: https://docs.google.com/spreadsheets/d/16AkIdDBBkCR5Kgb7kyfYvnNLQBu23Vsh7MUSFHW9RtA
featured_quote: 人気のあるサイトほど、サービスワーカーや高度なケイパビリティといった機能が使われがちです。
featured_stat_1: 8.62%
featured_stat_label_1: 上位1,000サイトにおけるサービスワーカー活用の割合
featured_stat_2: 57.88%
featured_stat_label_2: サービスワーカーキャッシュを利用しているPWAの割合
featured_stat_3: 32.19%
featured_stat_label_3: サービスワーカーがいるモバイルサイトのうち、Workboxライブラリを利用している割合
---

## 序章

[Frances Berriman](https://twitter.com/phae) と [Alex Russell](https://twitter.com/slightlylate) が、ネイティブアプリと同じように没入できるウェブアプリのビジョンを示す <a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">"プログレッシブ・ウェブ・アプリ" (PWA)</a> という言葉を作ってから6年が経ちます。
このような体験が従来のWebサイトと異なる点として、次のような属性が挙げられた。

- レスポンシブ
- サービスワーカーで順次強化
- アプリのようなインタラクションを持つ
- 新鮮
- 安全
- ディスカバブル
- リエンジニアリング可能
- リンク可能

ここ数年、ウェブプラットフォームは進化を続け、ウェブアプリとOS固有の体験との間のギャップを減らし、開発者はより豊かな機能と新しいエンゲージメントの方法をユーザーに提供することができるようになりました。

とはいえ、何がPWAなのかを明確に線引きすることはまだ困難です。専門家の中には、<a hreflang="en" href="https://developers.google.com/web/fundamentals/architecture/app-shell">シェルとコンテンツアプリケーションモデル</a>の特徴である「アプリらしい」体験を生み出すことを重視する人もいれば、サービスワーカーとウェブアプリのマニフェストを持ち、オフライン体験やその他の高機能を提供するなど特定のコンポーネントや動作に重きを置く人もいます。

今年のPWA編では、サービスワーカーとその関連APIの使用、Webアプリのマニフェスト、PWAを構築するためのもっとも人気のあるライブラリやツールなど、PWAの測定可能なすべての側面に焦点を当てます。PWAは、これらの機能のすべてまたは一部を使用できます。ここでは、ウェブエコシステムにおけるこれらの技術の浸透度合いを知るために、各コンポーネントとAPIの採用レベルについて見ていきます。


<p class="note">**注:** この章では、一般的に使われているサービスワーカー関連のAPIに主に焦点を当てます。さらに最先端の API については、<a href="./capabilities">ケイパビリティ</a> の章を必ずご覧ください。</p>

## サービスワーカー

[サービスワーカー](https://developer.mozilla.org/docs/Web/API/Service_Worker_API)（2014年12月導入）は、PWAの中核をなすコンポーネントの1つです。ネットワークプロキシとして機能し、オフライン、プッシュ通知、バックグラウンド処理など、「アプリらしい」体験に特徴的な機能を可能にします。

サービスワーカーが広く採用されるには時間がかかりましたが、現在では <a hreflang="en" href="https://caniuse.com/serviceworkers">ほとんどの主要なブラウザ</a>でサポートされています。しかし、これはすべてのサービスワーカー機能がブラウザ間で動作することを意味するものではありません。たとえば、ネットワーク プロキシなどの中核的な機能のほとんどは利用可能ですが、`Push` などのAPIは<a hreflang="en" href="https://caniuse.com/push-api"> WebKitではまだ利用できません</a>。

### サービスワーカーの利用状況

2021年には、測定方法にもよりますが、1.22%から3.22%のサイトがサービスワーカーを使用していると推測されます。今年は、次に説明する理由から、3.22%にもっとも近い値を採用することにしました。

{{ figure_markup(
  caption="モバイルサイトにおいてサービスワーカーを利用している割合。",
  content="3.22%",
  classes="big-number",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1499608158&format=interactive",
  sheets_gid="398503119",
  sql_file="manifests_and_service_workers.sql"
)
}}

サービスワーカーが使われているかどうかを測定するのは、案外簡単ではありません。たとえば、Lighthouseは1.5% を検出しますが、この定義には  サービス ワーカーの使用だけでなく、<a hreflang="en" href="https://web.dev/service-worker">いくつかの追加チェック</a>が加えられているので下限と見なすことができます。<a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">Chrome自体は、サービス ワーカーを使用しているサイトの割合は1.22%です</a>。これは、私たちが把握できていない理由でLighthouseよりも奇妙なほど少なくなっています。

今年のPWA編では、<a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/pwa.js">新しい測定基準</a>を作成し、測定技術を更新しました。たとえば、[サービスワーカー登録](https://developer.mozilla.org/docs/Web/API/ServiceWorkerRegistration)の呼び出しがあるか、サービスワーカー固有のメソッド、ライブラリ、イベントを使用しているかなど、いくつかのサービスワーカーの特徴をチェックするヒューリスティックを現在使用しています。

収集したデータから、デスクトップサイトの約3.05%、モバイルサイトの約3.22%がサービスワーカー機能を利用していることがわかり、[昨年の章](../2020/pwa#サービスワーカーの利用状況)で計測した値（デスクトップ0.88%、モバイル0.87%）よりサービスワーカーの利用率が高いかもしれないことがわかります。

モバイルとデスクトップでサービスワーカーを登録しているサイトが3％強というのは少ない数字だと思われるかもしれませんが、これがWebトラフィックにどう反映されるのでしょうか。

<a hreflang="en" href="https://www.chromestatus.com/features">Chromeプラットフォームの状況</a> は、Chromeブラウザから取得した使用統計情報を提供します。この統計によると、2021年7月に<a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">ページロードの19.26%</a> を支配するのはサービスワーカーだそうです。<a hreflang="en" href="../2020/pwa#service-worker-usage">昨年の測定値16.6%</a> と比較すると、サービスワーカーが制御するページ負荷は年間12%増加していることになります。

{{ figure_markup(
  caption='サービスワーカーを登録したページのページビューの割合。（提供元：<a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">Chromeプラットフォームの状況</a>）',
  content="19.26%",
  classes="big-number"
)
}}

また、約3％のサイトがWebトラフィックの約19％を占めていることをどう説明すればよいのでしょうか。直感的には、トラフィックが多いサイトほど、サービスワーカーを導入する理由があると考えるかもしれません。ユーザー数が多いということは、ユーザーがさまざまなデバイスやコネクティビティからサイトにアクセスする可能性があるため、パフォーマンス上のメリットや信頼性を提供するAPIを採用するインセンティブが高くなるのです。また、これらの企業はネイティブアプリを持っていることが多いので、サービスワーカーを介して高度な機能を実装し、プラットフォーム間のUXギャップを埋める理由がより多くあります。次のデータは、その仮定を証明するのに役立ちます。

{{ figure_markup(
  image="pwa-service-worker-controlled-pages-by-rank.png",
  caption="サービスワーカーがランク別に管理したページ。",
  description="サービスワーカーの管理するページをランキング形式で示した棒グラフ。デスクトップでは、上位1,000ページの8.55%、上位10,000ページの7.75%、上位10万ページの4.32%、上位100万ページの2.07%、全ページの1.22%が、サービスワーカーによってコントロールされていることがわかります。モバイルの場合、上位1,000ページ8.62%、上位10,000ページ8.05%、上位10万ページ4.61%、上位100万ページ2.17%、そして全ページ1.19%となっています。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=719919882&format=interactive",
  sheets_gid="1703190302",
  sql_file="sw_adoption_over_time_ranking.sql"
  )
}}

上位1,000サイトを計測すると、8.62%のサイトがサービスワーカーを利用しています。分析対象のサイト数を広げると、全体の割合は減少に転じています。これは、人気のあるサイトほど、サービスワーカーや高度な機能といった機能を利用する傾向があることを示しています。

### サービスワーカーの機能

このセクションでは、もっとも一般的なPWAタスク（オフライン、プッシュ通知、バックグラウンド処理など）に対するさまざまなサービスワーカー機能（[イベント](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope#event)、[プロパティ](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope#properties)、[メソッド](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope#methods)）の採用について分析します。

#### サービスワーカーのイベント

[ServiceWorkerGlobalScope](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope) インターフェイスは、サービスワーカーのグローバルな実行コンテキストを表し、異なる [events](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope#event) によって管理されます。イベントリスナーやサービスワーカーのプロパティを介して、2つの方法でそれらをリッスンできます。

たとえば、サービスワーカーで `install` イベントをリスニングする方法を2つ紹介します。

```javascript
// Via event listener:
this.addEventListener('install', function(event) {
  // …
});

// Via properties:
this.oninstall = function(event) {
  // …
};
```

イベントリスナーの実装方法について、両方の方法を計測して組み合わせたところ、以下のような統計が得られました。

{{ figure_markup(
  image="pwa-most-used-service-worker-events.png",
  caption="もっとも使用されるサービスワーカーのイベント。",
  description="もっとも使用されているサービスワーカーイベントの使用率順を示す棒グラフです。デスクトップでは `install` が70.73%のPWAページで使用され、 `activate` が64.85%、 `notificationclick` が45.62%、 `push` が43.88%、 `notificationclose` が5.98%、 `sync` が3.75%、 `periodicsync` が0.04% であった。モバイルでは、`install`が70.40%、`activate`63.00%、`notificationclick`46.62%、`push`45.44%、`notificationclose`6.34%、`sync`3.72%、そして `periodicsync`0.04% のPWAページで使用されています。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1443205721&format=interactive",
  sheets_gid="1329278694",
  sql_file="sw_events.sql"
  )
}}

これらのイベント結果は、3つのサブカテゴリーに分類できます。

- ライフサイクルイベント
- 通知関連イベント
- バックグラウンド処理イベント

##### ライフサイクルイベント

図中の最初の2つのイベントリスナーは、<a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers/lifecycle">ライフサイクルイベント</a>に属しています。これらのイベントリスナーを実装すると、イベントが実行されたときに、オプションで追加のタスクを実行できます。`install` はワーカーが実行されると同時に起動され、サービスワーカーごとに一度だけ呼び出されます。これにより、サービスワーカーが制御を開始する前に必要なものをすべてキャッシュしておくことができます。新しいサービスワーカーがクライアントをコントロールできるようになり、古いサービスワーカーがいなくなると、 `activate` が実行されます。これは、前のサービスワーカーが使っていたがもう必要ない古いキャッシュをクリアするなどのことをする良いタイミングです。

どちらのイベントリスナーも高い採用率を誇っています。モバイルPWAの70.40%とデスクトップPWAの70.73%が `install` イベントリスナーを実装し、モバイルの63.00%とデスクトップの64.85%が `activate` をリッスンしています。これらのイベントの内部で実行できるタスクは、パフォーマンスと信頼性にとって重要であるため、これは予想されることです（たとえば、<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-precaching">プリキャッシング</a>など）。
ライフサイクル イベントをリッスンしない理由としては、サービス ワーカーを通知のみに使用する（キャッシュ戦略なし）、キャッシュ技術をサイトの実行中のリクエストのみに適用する、<a hreflang="en" href="https://web.dev/runtime-caching-with-workbox/">ランタイムキャッシング</a> という技術がありプリキャッシュ技術と組み合わせてよく使われる（ただしこれだけではない）ことなどがあります。

##### 通知関連イベント

<!-- markdownlint-disable-next-line MD051 -->
[図16.4](#fig-4)に示すように、次に人気のあるイベントリスナー群は、<a hreflang="en" href="https://developers.google.com/web/fundamentals/push-notifications">Webプッシュ通知</a>に関連する `push`, `notificationclick`, `notificationclose` です。
もっとも広く採用されているのは `push` で、サーバーから送信されるプッシュイベントを待ち受けることができ、サービスワーカーを持つデスクトップサイトの43.88%とモバイルサイトの45.44%で使用されています。これは、<a hreflang="en" href="https://caniuse.com/push-api">まだすべてのブラウザで利用できない</a>場合でも、PWAでWebプッシュ通知がいかに人気であるかを示しています。

##### バックグラウンド処理イベント

<!-- markdownlint-disable-next-line MD051 -->
[図16.4](#fig-4)の最後のイベントグループは、サービスワーカーの特定のタスクをバックグラウンドで実行できます。たとえば、データの同期や接続に失敗したときのタスクの再試行などです。<a hreflang="en" href="https://developers.google.com/web/updates/2015/12/background-sync">バックグラウンド同期</a>（`sync` イベントリスナーを介して）は、Webアプリがタスクをサービスワーカーに委任し、失敗したり接続がない場合に自動的に再試行できるようにします（その場合サービスワーカーは、接続が回復するのを待ち自動的に再試行する）。<a hreflang="en" href="https://web.dev/periodic-background-sync/">周期的なバックグラウンド同期</a>（`periodicSync` 経由）は、サービスワーカーのタスクを定期的に実行させます（たとえば、毎朝トップニュースを取得してキャッシュします）。<a hreflang="en" href="https://developers.google.com/web/updates/2018/12/background-fetch">バックグランドフェッチ</a> のような他のAPIは、その使用率がまだかなり低いため、グラフには表示されていません。

このように、バックグラウンド同期技術は、他の技術に比べてまだ広く採用されていません。これは、バックグラウンド同期のユースケースが少ないことと、APIがまだすべてのブラウザで利用可能でないことが一因です。また、[Periodic Background Sync](https://developer.mozilla.org/docs/Web/API/Web_Periodic_Background_Synchronization_API)を利用するにはPWAをインストールする必要があるため、[「ホーム画面に追加」](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Add_to_home_screen)機能を提供しないサイトでは利用することができません。

その1つがオフライン分析（<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-google-analytics">Workbox Analyticsはバックグラウンド同期を使用しています</a>）、または接続性の欠如による失敗したクエリの再試行（<a hreflang="en" href="https://web.dev/google-search-sw/">某検索エンジン</a>）などです。

<p class="note">**備考:** 前回とは異なり、`fetch` と `message` イベントはサービスワーカーの外にも現れる可能性があり、誤検出が多くなる可能性があるため、この分析には含めないことにしました。つまり、上記の解析は、サービスワーカー固有のイベントに対するものです。<a hreflang="ja" href="../2020/pwa#サービスワーカーのイベント">2020年のデータでは、`fetch`は`install`とほぼ同じ頻度で使われています。</a></p>

#### その他、人気のあるサービスワーカーの機能

イベントリスナー以外にも、サービスワーカーには重要な機能があり、その有用性と人気を考えると、呼び出すのは興味深いことです。

次の2つのイベントは、かなり人気があり、よく併用されています。

- `ServiceWorkerGlobalScope.skipWaiting()`
- `Clients.claim()`

[`ServiceWorkerGlobalScope.skipWaiting()`](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/skipWaiting) は通常 `install` イベントの最初に呼ばれ、新しくインストールされたサービスワーカーが、他にアクティブなサービスワーカーがあったとしても、すぐに `active` 状態へ移行できるようにするものです。我々の分析では、デスクトップPWAの60.47% とモバイルPWAの59.60% で使用されていることがわかりました。

{{ figure_markup(
  caption="サービスワーカーが`skipWaiting()`を呼び出すモバイルサイトの割合",
  content="59.60%",
  classes="big-number",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=2101442063&format=interactive",
  sheets_gid="1589747311",
  sql_file="sw_methods.sql"
)
}}

[`Clients.claim()`](https://developer.mozilla.org/docs/Web/API/Clients/claim) は `skipWaiting()` と組み合わせてよく使われ、アクティブなサービスワーカーがその範囲内のすべてのクライアントの「コントロールを主張」できるようにします。デスクトップでは48.98％、モバイルでは47.14％のページで表示されます。

{{ figure_markup(
  caption="サービスワーカーが `clients.claim()` を呼び出すモバイルサイトの割合",
  content="47.14%",
  classes="big-number",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=2101442063&format=interactive",
  sheets_gid="1786812377",
  sql_file="sw_objects.sql"
)
}}

前の2つのイベントを組み合わせることで、デフォルトの動作であるアクティブなクライアント（たとえばタブ）が閉じられ、後の時点（たとえば新しいユーザーセッション）で再び開かれるのを待つことなく新しいサービスワーカーがすぐに有効になり、前のものと置き換わることになります。
開発者は、重要なアップデートを即座に実行するため、この手法が有効であると考え、広く採用されているのです。

キャッシュ処理は、サービスワーカーで頻繁に使用され、オフラインなどの機能を有効にし、パフォーマンスの向上に役立つため、PWA体験の中核をなしています。
[`ServiceWorkerGlobalScope.caches`](https://developer.mozilla.org/docs/web/api/caches) プロパティは、異なる [キャッシュ](https://developer.mozilla.org/docs/Web/API/Cache) にアクセスできるサービスワーカーへ関連付けられた [キャッシュストレージオブジェクト](https://developer.mozilla.org/docs/Web/API/CacheStorage) を返すものです。サービスワーカーを使用しているデスクトップでは57.41％、モバイルでは57.88％のサイトで使用されていることがわかりました。

{{ figure_markup(
  caption="サービスワーカーを持つモバイルサイトのうち、サービスワーカーキャッシュを利用している割合",
  content="57.88%",
  classes="big-number",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=107056879&format=interactive",
  sheets_gid="1879897527",
  sql_file="sw_objects_name_only.sql"
)
}}

キャッシュは信頼性とパフォーマンスの高いWebアプリケーションを可能にするため、その高い使用率は予想外ではありません。これは、開発者がPWAに取り組む主な理由の1つであることが多いのです。

最後に、<a hreflang="en" href="https://developers.google.com/web/updates/2017/02/navigation-preload">ナビゲーションプリロード</a> を見てみましょう。これは、サービスワーカーの起動時間と並行してリクエストを行うことで、その状況下でリクエストを遅らせることがないようにするものです。[`NavigationPreloadManager`](https://developer.mozilla.org/docs/Web/API/NavigationPreloadManager) インターフェイスは、この技術を実装するための一連のメソッドを提供します。私たちの分析によると、現在、サービスワーカーを使用しているデスクトップサイトの11.02%とモバイルサイトの9.78%でこの技術が使用されているとのことです。

{{ figure_markup(
  caption="ナビゲーションのプリロードを使用しているモバイルサイトの割合",
  content="9.78%",
  classes="big-number",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1163792530&format=interactive",
  sheets_gid="504745822",
  sql_file="sw_registration_properties_name_only.sql"
)
}}

ナビゲーションのプリロードは、<a hreflang="en" href="https://caniuse.com/?search=navigation%20preload%20manager">まだすべてのブラウザーで利用可能ではない</a>という事実にもかかわらず、適切なレベルで採用されていると言えます。多くの開発者が恩恵を受けることができる技術であり、[プログレッシブエンハンスメント](https://developer.mozilla.org/docs/Glossary/Progressive_Enhancement)として実装することができるのです。

## ウェブアプリマニフェスト

[ウェブアプリマニフェスト](https://developer.mozilla.org/docs/Web/Manifest)は、Webアプリケーションに関するメタデータを含むJSONファイルで、Webアプリのマニフェストを公開することが、ユーザーが端末にWebアプリをインストールする「ホーム画面に追加」機能を提供する前提条件の1つとなるため、PWAの主要コンポーネントの1つとなっています。その他の条件としては、HTTPSでサイトを提供すること、アイコンがあること、一部のブラウザ（ChromeやEdgeなど）ではサービスワーカーがあることなどが挙げられます。
<a hreflang="ja" href="https://web.dev/i18n/ja/installable-manifest/#in-other-browsers">ブラウザによってインストールするための基準が異なる</a>ことを考慮してください。

Web App Manifestsに関する使用統計情報をいくつか紹介します。サービスワーカーと一緒に可視化することで、「インストール可能な」Webアプリケーションの潜在的な割合について知ることができます。

{{ figure_markup(
  image="pwa-service-worker-and-manifest-usage.png",
  caption="サービスワーカーとマニフェストの使用状況。",
  description="サービスワーカーとマニフェストの利用状況をデスクトップとモバイルで棒グラフにしたもの。サービスワーカーはデスクトップで3.05%、モバイルでは3.22%、マニフェストは7.43%、7.26%、Either8.91%、8.76%、Both1.57%、1.71%のページで使用されていることがわかります。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1499608158&format=interactive",
  sheets_gid="398503119",
  sql_file="manifests_and_service_workers.sql"
  )
}}

マニフェストは、サービスワーカーに比べて2倍以上のページで使用されています。その理由のひとつは、一部のプラットフォーム（[CMS](./cms) など）が、サービスワーカーがないサイトでもマニフェストファイルを自動的に生成するためです。

一方、サービス ワーカーはマニフェストなしで使用できます。たとえば、プッシュ通知、キャッシュ、オフライン機能などをサイトに追加したいが、インストール性には興味がなく、マニフェストを作成しない開発者もいるかもしれません。

上の図では、デスクトップ サイトの1.57%とモバイルサイトの1.71%がサービス ワーカーとマニフェストの両方を備えていることがわかります。これは、「インストール可能な」Webサイトの潜在的な割合の第一近似値です。

Webアプリのマニフェストとサービス ワーカーを持つことに加え、マニフェストのコンテンツは、Webアプリケーションがインストール可能であるために、いくつかの追加の <a hreflang="en" href="https://web.dev/installable-manifest/">インストール可能基準</a> を満たす必要があります。次にそれぞれの特性を分析する。

### マニフェストのプロパティ

次の図は、サービス ワーカーを持つサイトのグループにおける <a hreflang="en" href="https://w3c.github.io/manifest/#web-application-manifest">標準マニフェスト プロパティ</a> の使用状況を示しています。

{{ figure_markup(
  image="pwa-top-pwa-manifest-properties.png",
  caption="PWAマニフェストのトッププロパティ。",
  description="デスクトップとモバイルで上位のPWAマニフェストプロパティを示す棒グラフ。`name`はデスクトップPWAマニフェストの94.78%とモバイルの94.61%。`icons`はそれぞれ92.22%と92.18%。`display`は72.77%と74.27%。`theme_color`は70.64%と71.64%。`background_color`は67.87%と69.53%で、`short_name`が64.57%と63.64%、`start_url`が37.27%と42.35%、`description`が11.86%と12.59%、`scope`が10.20%と11.66%、最後に`orientation`が8.71%と12.16%になりました。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=105221079&format=interactive",
  sheets_gid="137691358",
  sql_file="top_manifest_properties.sql"
  )
}}

このグラフは、<a hreflang="ja" href="https://web.dev/i18n/ja/installable-manifest/">Lighthouseのインストール可能なマニフェストの基準</a>と組み合わせると興味深いものになります。<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> はウェブサイトの品質を分析する人気のツールで、<a href="#lighthouse-insights">Lighthouse Insightsセクション</a>で見るように、PWAサイトの61.73% がこれらの基準に基づいてインストール可能なマニフェストを有しています。

次に、Lighthouseのインストール可能な要件を、先ほどの表にしたがって1つずつ分析します。

- `name` または `short_name` です。`name` プロパティは90%のサイトに存在し、`short_name` はデスクトップとモバイルのサイトのそれぞれ83.08%と84.69%に表示されています。これらのプロパティの使用率が高いのは、どちらも重要な属性であるためです。`name`はユーザーのホーム画面に表示されますが、長すぎたり画面内のスペースが小さすぎたりすると、代わりに`short_name`を表示することがあります。
- `icon` です。このプロパティは、デスクトップサイトの84.69%、モバイルサイトの86.11%に表示されています。アイコンは、ホーム画面、OSのタスクスイッチャーなど、さまざまな場所で使用されています。このことからも、その採用率の高さがうかがえます。
- `start_url`。このプロパティは、デスクトップサイトの82.84％、モバイルサイトの84.66％に存在します。これは、ユーザーがウェブアプリケーションを起動したときに、どのURLが開かれるかを示すもので、PWAにとってもう1つの重要なプロパティです。
- `display`です。このプロパティは、デスクトップサイトの86.49%およびモバイルサイトの87.67%で宣言されています。これは、ウェブサイトの表示モードを示すために使用されます。表示されていない場合、デフォルト値は `browser` で、これは従来のブラウザのタブであるため、ほとんどのPWAはこれを宣言して、代わりに `standalone` モードで開くべきであると示しています。スタンドアローンモードで開く機能は、「アプリらしい」体験を生み出すのに役立つものの1つです。
- `prefer_related_applications` です。このプロパティはデスクトップサイトの6.87%、モバイルサイトの7.66%で表示されますが、このリストの他のプロパティと比較すると低い割合のように思われます。この理由は、Lighthouseがこのプロパティの存在を必須としておらず、`true`という値で設定することを推奨しているに過ぎないからです。

次に、一連の値を定義することができるプロパティについて深く掘り下げます。どれがもとも広く使われているのかを理解するために。

### トップマニフェストアイコンサイズ

{{ figure_markup(
  image="pwa-top-pwa-manifest-icon-sizes.png",
  caption="PWAマニフェストのトップアイコンサイズ。",
  description="PWAマニフェストのアイコンのサイズについて、デスクトップとモバイルで上位のものを示した棒グラフです。`192x192` がデスクトップPWAサイトの72.58%、モバイルの74.20%、`512x512`が70.09%と60.36、`144x144`で32.76%と32.59%、`96x96`が23.73%と23%、`48x48`が23.10%と22%、`72x72`が21.03%と21%、`128x128`が16.19%と16.30% 、`152x152`は14.11％と14.52％、`384x384`は12.93％と11.84％、`256x256`は11.73％と11.86％、`16x16`は8.10％と8.32％、`36x36`は7.36%と7.01%、`64x64`は6.18%と6.38%、`32x32`は6.05%と6.37%、そして最後に`120x120`は6.14%と5.61%であった。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1930133957&format=interactive",
  sheets_gid="1450624146",
  sql_file="top_manifest_icon_sizes.sql"
  )
}}

圧倒的に人気のあるアイコンサイズは、以下の通りです。192x192と512x512は、<a hreflang="en" href="https://web.dev/add-manifest/#icons">Lighthouseが推奨するサイズ</a>です。実際には、開発者もさまざまなサイズを用意し、さまざまなデバイスの画面で見栄えがよくなるようにしています。

### トップマニフェストの表示値

{{ figure_markup(
  image="pwa-manifest-display-values.png",
  caption="PWAマニフェストの表示値。",
  description="PWAマニフェストの表示値をデスクトップとモバイル別に示した棒グラフです。`standalone`はデスクトップPWAページの74.83%、モバイルの79.02%、（未設定）はそれぞれ13.51%、12.33%、`minimal-ui`6.89%、4.10%、`fullscreen`3.74%、3.64%、最後に `browser`は0.92%と0.82% で使用されていることがわかります。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=270665105&format=interactive",
  sheets_gid="403639702",
  sql_file="top_manifest_display_values.sql"
  )
}}

displayプロパティは、開発者が好むウェブサイトのモードを決定する。
`standalone`モードは、インストールされたPWAをブラウザのUI要素なしで開き、「アプリのように感じる」ようにするものです。このグラフは、サービスワーカーとマニフェストを持つほとんどのサイトがこの値を使用していることを示しています。デスクトップで74.83%、モバイルでは79.02%です。

### ネイティブを好むマニフェスト

最後に、`prefer_related_applications`を分析します。このプロパティの値が `true` に設定されている場合、ブラウザはウェブアプリの代わりに関連するアプリケーションの1つをインストールするよう提案するかもしれません。

{{ figure_markup(
  image="pwa-manifests-preferring-native-app.png",
  caption="ネイティブアプリを優先するマニフェスト。",
  description="PWAマニフェストがネイティブアプリを好むことを示す棒グラフで、デスクトップPWAページの97.92%、モバイルPWAページの98.03%が`false`に設定されており、`true`に設定されているのはデスクトップページの1.86%、モバイルページの1.79%のみです。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1882009659&format=interactive",
  sheets_gid="1552027039",
  sql_file="manifests_preferring_native_apps.sql"
  )
}}

`prefer_related_applications`は、デスクトップサイトの6.87%、モバイルサイトの7.66%にのみ表示されます。このグラフから、このプロパティを定義したデスクトップサイトの97.92%とモバイルサイトの93.03%が`false`という値を持っていることがわかります。これは、ほとんどのPWA開発者が、ネイティブアプリよりもPWAを提供することを好んでいることを示しています。

PWA開発者の大多数がPWA体験をネイティブアプリケーションに推奨することを好むという事実にもかかわらず、一部の有名なPWA（Twitterなど）は依然としてPWA体験よりもネイティブアプリケーションを推奨することを好むようです。これは、これらの体験を構築するチームの好みによるものか、あるいは特定のビジネスニーズ（ウェブに何らかのAPIがない）によるものかもしれません。

<p class="note">**備考:** 開発者は、設定時にこの決定を静的に行うのではなく、<a hreflang="en" href="https://web.dev/define-install-strategy/">より動的なヒューリスティック</a>を作成して、たとえば、ユーザーの行動やその他の特性 (デバイス、接続、場所など) に基づいて体験を促進することも可能です。</p>

### マニフェストのトップカテゴリー

昨年のPWA章では、<a hreflang="ja" href="../2020/pwa#トップマニフェストのカテゴリー">マニフェストカテゴリ</a> に関するセクションを設け、[マニフェストカテゴリ](https://developer.mozilla.org/docs/Web/Manifest/categories) のプロパティに基づいて業界ごとのPWAのパーセンテージを示しました。

今年は、このプロパティの使用率が非常に低い（このプロパティが設定されているサイトは1％未満）ため、各カテゴリーのPWAの数を決定するために、このプロパティへ依存しないことにしました。

PWAを使用しているカテゴリーや産業に関するデータがないため、外部の情報源に頼っています。Mobstedは最近、独自の<a hreflang="en" href="https://mobsted.com/world_state_of_pwa_2021">PWAの利用状況に関する分析</a>を発表し、業界別のPWAの割合などを分析しています。

{{ figure_markup(
  image="pwa-industry-categories.png",
  caption='PWAの産業カテゴリー（提供元: <a hreflang="en" href="https://mobsted.com/world_state_of_pwa_2021">モブステッドPWA2021レポート</a>）。',
  description="PWAの業種分類を棒グラフで示したもので、業種によって使用率が大きく異なる。アダルト産業のPWA利用率は0.3%、アート＆エンターテイメント10.0%、自動車＆車両2.8%、美容＆フィットネス5.0%、書籍＆文学0.9%、ビジネス＆工業14.4%、コンピューター＆エレクトロニクス2.1%、金融3.2%、フード＆ドリンク5.6%、ゲーム1.2%、健康5.7%、趣味＆レジャー5.6%、ホーム＆ガーデン8.8%、インターネット＆テレコム1.5%、仕事＆教育3.1%、法律＆政府3.3%、ニュース1.1%、オンラインコミュニティ0.8%、人物＆社会6.1%、ペット＆動物0.4%、不動産4.3%、リファレンス0.8%、科学1.5%、センシティブなテーマ0.9%、買い物5.1%、スポーツ2.3%、最後に旅行3.3", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=891344722&format=interactive",
  sheets_gid="1817367668",
  width=590,
  height=600
  )
}}

モブステッドの分析によると、「ビジネス＆インダストリアル」「アート＆エンターテインメント」「ホーム＆ガーデン」が上位を占めています。これは、[昨年のウェブマニフェスト「カテゴリー」プロパティの分析](../2020/pwa#トップマニフェストのカテゴリー)で、「ショッピング」「ビジネス」「エンターテインメント」が上位3つの値だったことと相関があるようです。

## ライトハウスの考察

<a href="#manifest-properties">manifest propertiesセクション</a>で、LighthouseがWebアプリマニフェストファイルに対して持つ <a hreflang="ja" href="https://web.dev/i18n/ja/installable-manifest/">インストール可能要件</a> について述べました。Lighthouseは、PWAを構成する他の側面についてもチェックを提供します。[方法論](./methodology)に記載されているように、HTTP Archiveは現在、モバイルクロールの一部としてのみLighthouseテストを実行していることに留意してください。

以下のグラフは、各基準をクリアしたサイトの割合を示しています。「PWAサイト」にはサービスワーカーとマニフェストを持つサイトの統計が、「全サイト」には全トータルのサイトのデータが含まれています。

{{ figure_markup(
  image="pwa-lighthouse-pwa-audits.png",
  caption="ライトハウスPWA監査。",
  description="ライトハウスPWAオーディットの全ウェブサイトとPWAウェブサイト別の棒グラフです。両方の利用率が高い監査もありますが、多くはPWAサイトのみの利用率が高く、PWAサイトはすべてのカテゴリで全サイトを余裕で上回っています。`viewport`監査は全サイトの91.16%、PWAサイトの99.42%、`redirects-http`はそれぞれ78.01%、98.23%、`content-width`が81.86%、94.70%、 `service-worker`では1.50%、84.86%、 `apple-touch-icon`が39.25%と77.78%、 `themed-omnibox`が4.64%と68.78%、 `splash-screen`が2.28%と63.40%、 `installable-manifest`が1.08%と61.73%、 `maskable-icon`が0.38%と17.46%であることがわかりました。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=991530366&format=interactive",
  sheets_gid="1312576011",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

予想通り、この表からPWAとして特定したサイト群（サービスワーカーとマニフェストを持つサイト）は、Lighthouseの各PWA監査に合格する傾向が、あることがわかります。PWAに特化していない監査（たとえば、ビューポートの設定やHTTPからHTTPSへのリダイレクトなど）は、すべてのサイトで高いスコアを獲得していますがPWAに特化した監査では明確な違いがあり、これらは本当にPWAサイトによってのみ使用されています。

<a hreflang="ja" href="https://web.dev/i18n/ja/maskable-icon/">マスカブル アイコン</a>は、他のPWAオーディションと比較して、PWAサイトでも合格率が低いというのは興味深い点です。マスク可能なアイコンを使用すると、Androidデバイスのアイコンのルック＆フィールを向上させ、割り当てられた形状全体を埋め尽くすようにできます（アイコンのレスポンシブ機能のようなものです）。この機能はオプションで、インストール可能なエクスペリエンスを提供するPWAにとって、ほとんどが興味深いものです。他のPWA機能（オフラインなど）とは異なり、PWAでないサイトが興味を持つことはほとんどないでしょう。

Lighthouseは、これらすべての監査の「合格率」に基づいて、<a hreflang="ja" href="https://web.dev/i18n/ja/lighthouse-pwa/">PWAスコア</a>も提供しています。次のグラフは、先に分析した2つのグループ間で、結果のスコアを比較したものです。

{{ figure_markup(
  image="pwa-lighthouse-pwa-scores.png",
  caption="Lighthouse PWAのスコア。",
  description="全サイトとPWAサイトのLighthouse PWAスコアをパーセンタイルで示した棒グラフ、PWAサイトはすべてのパーセンタイルで全サイトのスコアの約2倍を記録しています。10パーセンタイルは全サイトで25、PWAサイトで50、25パーセンタイルは33と58、50パーセンタイルは42と83、75パーセンタイルは50と92、そして90パーセンタイルは50と100のスコアを示しています。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=2065040053&format=interactive",
  sheets_gid="1466930372",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

以下は、その考察です。

- 中央値は「PWAサイト」が83点であるのに対し、「全サイト」は42点となっています。
- 上位の「PWAサイト」では、少なくとも10%がPWAの最高得点（100点）を獲得していることがわかります。「すべてのサイト」を見ると、75パーセンタイルと90パーセンタイルは、せいぜい50にしか達しません。
- グラフの下端を見ると、「PWAサイト」の90％がLighthouseのPWAスコア50以上を獲得しています（全サイトでは25）。

「PWAサイト」は「すべてのサイト」よりもPWA固有の要件をより多くクリアする傾向が当然あるため、今回も両グループの差は予想通りです。いずれにせよ、PWAサイトの中央値83というスコアは、PWA開発者のかなりの部分がベストプラクティスに沿っていることを示唆しています。

## サービスワーカーライブラリ

サービスワーカーは、ライブラリを使用して、一般的なタスクや機能、ベストプラクティスを実現できます（キャッシュ技術やプッシュ通知の実装など）。もっとも一般的なのは [importScripts()](https://developer.mozilla.org/docs/Web/API/WorkerGlobalScope/importScripts)を使う方法で、これはワーカーにJavaScriptライブラリをインポートする方法です。他のケースでは、ビルドツールがビルド時にライブラリのコードをサービスワーカーに直接注入することもできます。

すべてのライブラリがワーカーのコンテキストで使用できるわけではないことを考慮に入れてください。Workerは[Window](https://developer.mozilla.org/docs/Web/API/Window) 、したがって [Document](https://developer.mozilla.org/docs/Web/API/Document) オブジェクトにアクセスできず、ブラウザAPIへのアクセスも制限されています。そのため、サービスワーカーライブラリは、このような文脈で使用されることをとくに想定して設計されています。

このセクションでは、さまざまなサービスワーカーライブラリの人気度を分析します。

### 人気のインポートスクリプト

以下の表は、`importScripts()`でインポートした各種ライブラリの使用率を示しています。

{{ figure_markup(
  image="pwa-libraries-and-scripts.png",
  caption="人気のPWAライブラリやスクリプトを紹介。",
  description="デスクトップとモバイルで人気のあるPWAライブラリとスクリプトを示す棒グラフ。デスクトップの15.43％とモバイルの16.58％で`workbox`が優勢です。`recaptcha`は5.19%と5.70%、`firebase`は2.45%と2.63%、`OneSignalSDK`は2.53%と2.51%、`sendpulse`は1.83%と1.68%、`pushprofit`は1.42%と1.65%、`quora`は1.28%、そして最後に `sw_toolbox' はデスクトップでは0.51%モバイルは0.36% となりました。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1758350320&format=interactive",
  sheets_gid="645109672",
  sql_file="popular_pwa_libraries.sql"
  )
}}

Workboxは依然としてもっとも人気のあるライブラリで、サービスワーカーがいるデスクトップサイトの15.43% とモバイルサイトの16.58% で使用されていますが、これはWorkbox採用全般の代理と解釈されるかもしれません。次のセクションでは、より全体的で正確なアプローチで採用を測定します。

また、Workboxの前身である`sw_toolbox`は、<a hreflang="ja" href="../2020/pwa#人気のインポートスクリプト"> 昨年の使用率がデスクトップで13.92％、モバイルで12.84％</a>でしたが、今年はそれぞれ0.51％と0.36％に低下しているのも重要な点です。これは、`sw_toolbox`が<a hreflang="en" href="https://github.com/GoogleChromeLabs/sw-toolbox/pull/288">2019年に非推奨</a>となったことが一因であると考えられます。人気のあるフレームワークやビルドツールの中には、このパッケージを削除するのに時間がかかったものもあるかもしれないので、今年はより明確に採用数の減少が見て取れます。また2020年と比較して、サイトを増やすなどして測定方法が変わったため、この指標はさらに減少し、直接の前年比は難しくなっています。

<p class="note">**備考:** [`importScripts()`](https://developer.mozilla.org/docs/Web/API/WorkerGlobalScope/importScripts) は [`WorkerGlobalScope`](https://developer.mozilla.org/docs/Web/API/WorkerGlobalScope) の API で、[Web Workers](https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Using_web_workers) など他のタイプの Worker コンテキストでも使用できることを考慮に入れておいてください。<a hreflang="en" href="https://www.google.com/recaptcha/about/">reCaptcha</a> は、例えば、reCaptcha JavaScript コードを取得する `importScripts()` コールを含むウェブワーカーを使用しているので、2番目に広く使われているライブラリとして表示されているようです。そのため、サービスワーカーのコンテキストで2番目に広く使われているライブラリとして、代わりに <a hreflang="en" href="https://firebase.google.com/docs/web/setup">Firebase</a> を考慮すべきです。
</p>

### Workboxの使用状況

<a hreflang="en" href="https://developers.google.com/web/tools/workbox">Workbox </a>は、PWA構築のための共通タスクとベストプラクティスをパッケージ化したライブラリのセットです。先ほどのグラフによると、Workboxはサービスワーカーでもっとも人気のあるライブラリです。では、実際どのように使われているのか、詳しく見ていきましょう。

<a hreflang="en" href="https://github.com/GoogleChrome/workbox/releases/tag/v5.0.0">Workbox 5</a> から、Workboxチームは開発者へ、<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-sw">`workbox-sw`</a>（ランタイム）のロードに `importScripts()` を使う代わりに、Workboxランタイムのカスタムバンドル作成を推奨しています。Workboxチームは `workbox-sw` のサポートを継続しますが、現在は新しい手法を推奨しています。実際、ビルドツールのデフォルトはこの方法を好むように変更されています。

それを踏まえて、あらゆるタイプのWorkboxの機能を利用しているサイトを計測したところ、サービスワーカーが利用しているサイトは、上記で述べたよりもはるかに多いことがわかりました。デスクトップ用PWAの33.04％、モバイル用PWAの32.19％です。

{{ figure_markup(
  caption="サービスワーカーがいるモバイルサイトのうち、Workboxライブラリを使用している割合。",
  content="32.19%",
  classes="big-number",
  sheets_gid="2116306680",
  sql_file="workbox_usage.sql"
  )
}}

### Workboxのバージョン

{{ figure_markup(
  image="pwa-top-workbox-versions.png",
  caption="Workboxのバージョントップ10。",
  description="デスクトップとモバイルでもっとも人気のある10種類のWorkboxのバージョンを示す棒グラフです。3.0.0はデスクトップPWAサイトの3.45％、モバイルの5.42％で使用されています。3.4.1ではそれぞれ0.54％、0.49％増加しました。3.5.0は0.66%と0.57%、3.6.3は1.54%と1.36%、4.3.1は5.09%と4.63%、5.1.2は0.50%と0.52%、5.1.3は0.95%と0.88%、5.1.4は3.21%と3.04%、6.0.2は0.61%と0.58%、最後に6.1.5は4.71%と5.25% であった。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=554211152&format=interactive",
  sheets_gid="988853150",
  sql_file="workbox_versions.sql"
  )
}}

このグラフから、バージョン <a hreflang="en" href="https://github.com/GoogleChrome/workbox/releases/tag/v6.1.5">6.1.15</a> の採用率が他と比べてもっとも高いことがわかります。そのバージョンは2021年4月13日にリリースされ、2021年7月にクロールした時点では最新版でした。

当時から<a hreflang="en" href="https://github.com/GoogleChrome/workbox/releases">さらなるバージョン</a>がリリースされており、チャートで観察される挙動から、発売後すぐにもっとも広く使われるようになると予想されます。

また、今でも広く採用されている古いバージョンも数えるほどしかありません。その理由は、過去に旧バージョンのWorkboxを採用し、提供を続けている人気ツールがあるからだ、すなわち。

- バージョン4.3.1の使用は、ほとんどが <a hreflang="en" href="https://github.com/facebook/create-react-app/blob/v3.4.4/packages/react-scripts/package.json#L82">create-react-app version 3</a> によってもたらされています。
- バージョン3.0.0も同様に、<a hreflang="en" href="https://github.com/facebook/create-react-app/blob/v2.1.8/packages/react-scripts/package.json#L72">create-react-app version 2</a>に含まれています。

### Workboxパッケージ

Workboxライブラリは、特定の機能を含む <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules"> パッケージまたはモジュールのセット</a>として提供されています。各パッケージは特定のニーズに対応しており、一緒に使用することも、単独で使用することもできます。

次の表は、代表的なパッケージのWorkboxの使用状況を示しています。

{{ figure_markup(
  image="pwa-top-workbox-packages.png",
  caption="Workboxの上位パッケージ。",
  description="デスクトップとモバイルで人気の高いWorkboxパッケージを示す棒グラフです。デスクトップでは `core`が21.96%、モバイルでは23.66%、`routing`は17.88%と20.14%、`strategies`は15.82%と15.70%、`precaching`は14.41%と14.35%、`sw`は8.38%と10.29%、`expiration`は8.30%と8.93% 、`cacheable-response`が5.87%と6.64%、`background-sync`が3.27%と3.21%、`window`が3.36%と3.08%、最後に`google-analytics`が1.91%と1.86% であった。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1408852146&format=interactive",
  sheets_gid="1733966367",
  sql_file="workbox_packages.sql"
  )
}}

上のグラフから、次の4つのパッケージがもっとも多く使われていることがわかります。

- <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-core">Workboxコア</a>: このパッケージには、各Workboxモジュールが依存する共通のコード（たとえば、コンソールと対話するコード、意味のあるエラーを投げるコードなど）が含まれています。そのため、もっとも広く使用されています。
- <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-routing">Workboxルーティング</a>: このパッケージは、リクエストを傍受してさまざまな方法でそれに応答することを可能にします。また、サービスワーカーの内部では非常に一般的なタスクなので、かなり人気があります。
- <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-precaching">Workboxプリキャッシング</a>: このパッケージは、サービスワーカーのインストール中に、サイトがいくつかのファイルをキャッシュに保存することを可能にします。このファイル群は通常、PWAの「バージョン」を構成します（ネイティブアプリのバージョンに似ています）。
- <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies">Workboxストラテジー</a>: サービスワーカーの "インストール" イベントで行われるプリキャッシングとは異なり、このパッケージは `fetch` イベントを受け取った後にサービスワーカーがどのようにレスポンスを生成するかを決定するランタイムキャッシングストラテジーを可能にします。

### Workboxストラテジー

前述のとおり、Workboxはネットワークリクエストに対応するための組み込みストラテジーのセットを提供します。次の図は、もっとも一般的なランタイムキャッシュストラテジーの採用を確認するのに役立ちます。

{{ figure_markup(
  image="pwa-workbox-runtime-caching-strategies.png",
  caption="Workboxのランタイムキャッシュのトップストラテジー。",
  description="デスクトップとモバイルで人気のあるランタイムキャッシュストラテジーパッケージを示す棒グラフ。`NetworkFirst` がデスクトップで31.52%、モバイルでは31.71%、`CacheFirst`が31.72%と30.51% 、`StaleWhileRevalidate`が27.03%と26.74% 、`NetworkOnly`が8.81%と9.66% 、そして最後に `CacheOnly` が0.92%と1.37%でキャッシュストラテジーに選ばれました。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=761410022&format=interactive",
  sheets_gid="1537625006",
  sql_file="workbox_methods.sql"
  )
}}

<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies#network_first_network_falling_back_to_cache">`NetworkFirst`</a>、<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies#cache_first_cache_falling_back_to_network">`CacheFirst`</a>、<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies#stale-while-revalidate">`Stale While Revalidate`</a>が、圧倒的に広く使われています。これらのストラテジーにより、ネットワークとキャッシュをさまざまな方法で組み合わせてリクエストに対応できます。たとえば、もっとも人気のあるランタイムキャッシュストラテジーである `NetworkFirst` は、ネットワークから最新のレスポンスを取得しようとします。もし結果が成功すれば、その結果をキャッシュに格納します。ネットワークが失敗した場合は、キャッシュのレスポンスが使われます。

その他の戦略、たとえば<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies#network_only">`NetworkOnly`</a>や<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies#cache_only">`CacheOnly`</a>は `fetch()` リクエストをネットワークかキャッシュに移動して解決し、この2つのオプションを組み合わせないようにします。そのため、PWAの魅力は半減するかもしれませんが、それでも意味のあるユースケースはあります。たとえば、<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies#using_plugins">プラグイン</a>と組み合わせることで、機能を拡張することが可能です。

## Webプッシュ通知

ウェブプッシュ通知は、ユーザーをPWAに引き留めるためのもっとも強力な方法の1つです。モバイルとデスクトップのユーザーに送ることができ、ウェブアプリがフォアグラウンドにないとき、あるいは（スタンドアロンアプリまたはブラウザタブとして）開いていないときでも受信できます。

ここでは、もっとも人気のある通知関連のAPIについて、使用状況をいくつか紹介します。

ページは [Push API](https://developer.mozilla.org/docs/Web/API/Push_API) の [`PushManager`](https://developer.mozilla.org/docs/Web/API/PushManager) インターフェイス経由で通知を購読します。このインターフェイスは [`ServiceWorkerRegistration`](https://developer.mozilla.org/docs/Web/API/ServiceWorkerRegistration) の `pushManager` プロパティでアクセスします。デスクトップ用PWAの44.14％、モバイル用PWAの45.09％で使用されています。

{{ figure_markup(
  caption="サービスワーカーを持つモバイルサイトのうち、`pushManager`プロパティの何らかのメソッドが使用された割合",
  content="45.09%",
  classes="big-number",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1163792530&format=interactive",
  sheets_gid="504745822",
  sql_file="sw_registration_properties_name_only.sql"
)
}}

<!-- markdownlint-disable-next-line MD051 -->
また、サービスワーカーのイベント関連では、[図16.4](#fig-4)に示すように、プッシュメッセージを受信するための`push`イベントリスナーがデスクトップの43.88％、モバイルの45.44％で使用されています。

<!-- markdownlint-disable-next-line MD051 -->
サービスワーカーインターフェイスは、通知に関するユーザーインタラクションを処理するために、いくつかのイベントをリッスンすることもできます。[図16.4](#fig-4)は、`notificationclick`（通知へのクリックを捕捉）がデスクトップの45.64%、モバイルPWAの46.62%で使われていることを示しています。`notificationclose`は使用頻度が低く、デスクトップPWAの5.98%、モバイルPWAの6.34%です。これは、通知の「クリック」よりも、通知の「閉じる」イベントをリッスンすることが意味のあるユースケースが少ないと予想されます。

<p class="note">**備考:** サービスワーカーの通知イベント（例： `push`、`notificationclick`）には、さらに `pushManager` プロパティが使われているのが興味深いです。このプロパティは、たとえば、Webプッシュ通知の許可を（ `pushManager.subscribe` を通じて）要求するために使用されます。この理由の1つは、いくつかのサイトがウェブプッシュを実装し、ある時点でロールバックすることを決定し、そのために許可を要求するコードを排除し、サービスワーカーのコードは変更しないままにしていることかもしれません。</p>

### Webプッシュ通知の受理率

通知が有用であるためには、<a hreflang="en" href="https://developers.google.com/web/fundamentals/push-notifications">timely, precise, and relevant</a> である必要があります。許可を求めるプロンプトを表示した時点で、ユーザーはそのサービスの価値を理解する必要があります。優れた通知更新は、ユーザーにとって有益で、許可を得た理由に関連するものを提供しなければなりません。

以下の図は、[Chrome UXレポート](./methodology#chrome-ux-report) から引用したもので、通知許可プロンプトの受理率を示しています。

{{ figure_markup(
  image="pwa-notification-acceptance-rates.png",
  caption="通知の受理率。",
  description="デスクトップとモバイルの通知受理率を積み上げ棒グラフで表示。デスクトップでは、`許可`が8.28%、`無視` 51.82%、`拒否` 10.70%、`却下` 29.21%となっています。モバイルでは、`許可`が20.67%、`無視` 14.57%、`拒否` 45.32%、`却下` 19.45%となっています。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=460718116&format=interactive",
  sheets_gid="1537625006",
  sql_file="pwa_notification_acceptance_rates.sql"
  )
}}

モバイルはデスクトップよりも高い承諾率（20.67％対8.28％）を示しています。これは、ユーザーがモバイルの通知をより有用と感じる傾向があることを示唆しています。これには、2つの理由があると考えられます。(1) ユーザーはデスクトップよりも携帯電話の通知に慣れており、モバイルコンテキストでの通知の有用性がより明白であること、 (2) 通知プロンプトのモバイルUIは通常より顕著であることです。

また、モバイルはデスクトップに比べて「拒否」率が高く（45.32%対10.70%）、デスクトップユーザーは通知を「無視」する頻度が高い傾向にあります（モバイル19.45%対デスクトップ29.21%）。この理由は、モバイルの登録UIがデスクトップよりも押し付けがましく、ユーザーが通知を受け入れるか拒否するかの判断をする頻度が高いためと考えられます。またデスクトップでは、ユーザーがプロンプトで表示されたタブから離れると、「無視」と記録される場合がありますが、プロンプトの外側をクリックして「無視」するスペースが非常に大きくなっています。

## 配布方法

PWAの重要な点は、ユーザーがブラウザのURLバーへURLを入力する以上の方法でWebエクスペリエンスへアクセスできるようにすることです。ユーザーは、さまざまな方法でWebアプリをインストールし、ホーム画面のアイコンを使ってアクセスすることもできます。これは、ネイティブアプリのもっとも魅力的な機能の1つであり、PWAもそれを可能にしています。

このインストール可能な体験を配布する方法は、以下の通りです。

- [ホーム画面に追加](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Add_to_home_screen)機能により、ユーザーにPWAのインストールを促す。
- <a hreflang="en" href="https://developer.chrome.com/docs/android/trusted-web-activity">Trusted Web Activity (TWA)</a>（現在、Google PlayやMicrosoft Storeなど、あらゆるAndroidアプリストアで利用可能）でパッケージ化し、PWAをApp Storeにアップロードする。

次に、これらの技術に関連する統計データを紹介し、これらのトレンドの使用率と成長率を把握します。

### ホーム画面に追加する

これまで、ホーム画面に追加するための前提条件として、サービスワーカーやインストール可能なWebアプリのマニフェストを持っていることを分析してきました。

ブラウザで提供されるインストール体験に加え、開発者は独自のカスタムインストールフローをアプリ内で直接提供できます。

`Window` オブジェクトの[`onbeforeinstallprompt`](https://developer.mozilla.org/docs/Web/API/Window/onbeforeinstallprompt) プロパティを使用すると、ユーザーがWebアプリケーションをインストールするように促されようとするときに発生するイベントをドキュメントに取り込むことができます。開発者は、プロンプトを直接表示するか、あるいは、より適切と思われるときに表示するようにプロンプトを延期するかを決定できます。

我々の分析によると、`beforeinstallprompt`は、サービスワーカーとマニフェストを持つデスクトップサイトの0.48%、モバイルサイトの0.63%で使用されていることが判明しました。

{{ figure_markup(
  image="pwa-install-events.png",
  caption="PWAのインストールイベント。",
  description="デスクトップとモバイルのPWAサイトで使用されているインストールイベントを示す積み上げ棒グラフ。`appinstalled` はデスクトップの0.21% とモバイルの0.22% で使用されており、`beforeinstallprompt` はデスクトップの0.48%とモバイルの0.63%で使用されています。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHHnqNdpRUjoeTfsN9_irK57PvZn_Q2X842RLl-RL4ibWmZFvO-S1x35PjVE3-xUlHFS_Zurd22rOq/pubchart?oid=1538269319&format=interactive",
  sheets_gid="840472840",
  sql_file="install_events.sql"
  )
}}

`BeforeInstallPromptEvent`APIは <a hreflang="en" href="https://caniuse.com/mdn-api_beforeinstallpromptevent"> すべてのブラウザーでまだ利用できません</a>ので使用率が、比較的低いことが説明されます。それでは、これが示すトラフィックの割合を見てみましょう。

{{ figure_markup(
  link="https://www.chromestatus.com/metrics/feature/timeline/popularity/1436",
  image='pwa-before-install-prompt-page-loads.png',
  caption='あるページで `beforeinstallprompt` を利用したページビューの割合 (提供元: <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/1436">Chromeプラットフォームの状況</a>)',
  description='2019年1月1日から2021年9月までのページロードの時系列を見ると、1％から4％強の伸びで、2021年1月に大きく伸びていることがわかります。',
  width=1460,
  height=786
  )
}}

<a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/1436">Chrome Platform Status</a> によると、この機能を使用しているページロードの割合は<a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/1436">4%近いので</a> 、一部のトラフィックの多いサイトが、使用している可能性のあることが示唆されます。さらに、昨年と比較して、2.5ポイント採用が伸びていることがわかります。

### App Storeでの配信

これまで開発者は、OS固有の言語（AndroidならJavaやKotlin、iOSならObjective-CやSwift）でアプリを作る代わりに、Webベースのモバイルアプリケーションを作り、App Storeにアップロードしてきました。もっとも一般的なアプローチは、<a hreflang="en" href="https://cordova.apache.org/">Cordova</a> のようなクロスプラットフォームでハイブリッドなソリューションを使用することです。結果として得られるコードは通常、<a hreflang="en" href="https://developer.android.com/reference/android/webkit/WebView">WebView</a>を使用してWebコンテンツをレンダリングしますが、デバイスから機能にアクセスできる一連の非標準APIも提供されています。

WebViewベースのアプリはネイティブアプリと似ているように見えますが、確かにいくつかの注意点があります。WebViewは単なるレンダリングエンジンであるため、ユーザーはフルブラウザとは異なる体験をする可能性があります。最新のブラウザAPIは使用できないかもしれませんし、もっとも重要なのは、WebViewとブラウザの間でCookieを共有できないことです。

TWAを使えば、PWAをネイティブアプリケーションのシェルにパッケージ化し、いくつかのApp Storeにアップロードできます。WebViewベースのソリューションとは異なり、TWAは単なるレンダリングエンジンではなく、フルスクリーンモードで動作する完全なブラウザーとなります。そのため、機能が完全であり、常に最新であり、最新のウェブAPIにアクセスできることを意味します。

開発者はPWAをTWAで直接ネイティブ アプリにパッケージ化し、<a hreflang="en" href="https://developer.chrome.com/docs/android/trusted-web-activity/integration-guide">Android Studioを使用</a> できますが、このタスクをはるかに容易にするツールがいくつかあります。次に、そのうちの2つを分析します。PWA BuilderとBubblewrapです。

#### PWAビルダー

<a hreflang="en" href="https://www.pwabuilder.com/">PWAビルダー</a>は、Web開発者がProgressive Web Appsを構築し、Microsoft StoreやGoogle Play Storeなどのアプリストア向けにパッケージ化することを支援するオープンソースプロジェクトです。提供されたURLを確認し、利用可能なマニフェスト、サービスワーカー、およびSSLをチェックすることから始まります。

[PWA Builderは3ヶ月のタイムスロットで200kのURLをレビューしました](https://twitter.com/pwabuilder/status/1454250060326318082?s=21)と発見されたのです。

- 75%はマニフェストが検出された
- 11.5%にサービス要員が検出された
- 9.6％はブラウザからインストール可能なPWA（マニフェストとSW、https化）

#### Bubblewrap

<a hreflang="en" href="https://github.com/GoogleChromeLabs/bubblewrap">Bubblewrap</a> は、開発者がTWAを使用してPWAを起動するAndroidアプリのプロジェクトを作成、構築、更新できるように設計されたツールおよびライブラリのセットです。

Bubblewrapを使うことで、開発者はAndroidツール（Android Studioなど）周辺の詳細を意識する必要がなく、Web開発者にとっては非常に使い勝手が良いのです。

Bubblewrapの使用統計はありませんが、Bubblewrapに依存していることが知られている注目すべきツールがいくつかあります。たとえば、PWA Builderや<a hreflang="en" href="https://appmaker.xyz/pwa-to-apk">PWA2APK</a>はBubblewrapを搭載しています。

## 結論

「Progressive Web Apps」という言葉が生まれてから6年、そのコアテクノロジーの採用は増え続けている。サービスワーカーは間もなくウェブトラフィックの20%を支配するようになり、サイトは毎年、より多くの機能を追加し続けています。

2021年、開発者はウェブアプリケーションを構築・配布するための多様な選択肢を持ち、もっとも一般的な作業を担うことができるツールや、これらの体験をアプリストアにアップロードする簡単な方法を提供することができるようになります。

ウェブは、これまでOS固有の言語だけで作られていたアプリケーションがウェブ技術で開発できることを年々実証し続け、<a hreflang="en" href="https://www.theverge.com/2021/10/26/22738125/adobe-photoshop-illustrator-web-announced">企業はこれらのアプリ的体験をウェブへもたらすために投資を続け</a>ています。

この分析が、お客様のPWAプロジェクトにおいて、より多くの情報に基づいた意思決定を行うための一助となれば幸いです。2022年にこれらのトレンドがどれだけ成長するのか、楽しみです。
