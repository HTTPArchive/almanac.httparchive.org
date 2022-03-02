---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: Service Worker（登録、インストール可能性、イベント、およびファイルサイズ）、Webアプリマニフェストプロパティ、およびWorkboxを対象とする2019 Web AlmanacのPWAの章。
authors: [tomayac, jeffposnick]
reviewers: [logicalphase, ahmadawais]
analysts: [jrharalson]
editors: [tunetheweb]
translators: [ksakae1216]
discuss: 1766
results: https://docs.google.com/spreadsheets/d/19BI3RQc_vR9bUPPZfVsF_4gpFWLNT6P0pLcAdL-A56c/
tomayac_bio: Thomas SteinerはGoogle HamburgのWeb Developer Advocateで、標準化、ベストプラクティスの作成と共有、研究を通じた Web のより良い場所づくりに焦点を当てています。彼は <a hreflang="en" href="https://blog.tomayac.com/">blog.tomayac.com</a> でブログを書いており、<a href="https://twitter.com/tomayac">@tomayac</a> としてツイートしています。
jeffposnick_bio: Jeff PosnickはGoogleのWeb Developer Relationsチームのメンバーで、ニューヨークに拠点を置いています。彼の関心事は、<a hreflang="en" href="https://developers.google.com/web/tools/workbox/">Workbox</a>、プログレッシブウェブアプリのためのサービスワーカーライブラリのセットです。<a hreflang="en" href="https://jeffy.info">https://jeffy.info</a> でブログを書いており、<a href="https://twitter.com/jeffposnick">@jeffposnick</a> としてツイートしています。
featured_quote: プログレッシブウェブアプリ（PWA）は、サービスワーカーAPIのようなプラットフォームプリミティブの上に構築された新しいクラスのウェブアプリケーションです。サービスワーカーは、アプリケーションがネットワークプロキシとして動作し、ウェブアプリの送信要求を傍受し、プログラム的な応答またはキャッシュされた応答で応答することで、ネットワークに依存しないロードをサポートすることを可能にします。
featured_stat_1: 0.44%
featured_stat_label_1: サービスワーカーを登録しているサイト
featured_stat_2: 15%
featured_stat_label_2: サービスワーカーを利用したページビュー
featured_stat_3: 57%
featured_stat_label_3: `standalone` `display`プロパティを使用するPWA
---

## 導入

プログレッシブWebアプリ（PWA）は、[Service Worker API](https://developer.mozilla.org/en/docs/Web/API/Service_Worker_API)などのプラットフォームプリミティブ上に構築される新しいクラスのWebアプリケーションです。Service Workerは、ネットワークプロキシとして機能し、Webアプリの発信要求をインターセプトしプログラムまたはキャッシュされた内容で応答することによりアプリがネットワークに依存しない読み込みをサポートできるようにします。Service Workerは、プッシュ通知を受信し、対応するアプリが実行されていなくてもバックグラウンドでデータを同期できます。さらに、Service Workerは、[Webアプリマニフェスト](https://developer.mozilla.org/en-US/docs/Web/Manifest)と共にユーザーがデバイスのホーム画面にPWAをインストールできるようにします。

Service Workerは2014年12月に<a hreflang="en" href="https://blog.chromium.org/2014/12/chrome-40-beta-powerful-offline-and.html">Chrome 40で初めて実装</a>され、プログレッシブWebアプリという用語は2015年に<a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">Frances BerrimanとAlex Russellによって作られました</a>。Service Workerはすべての主要なブラウザでようやく実装されたため、この章の目標は実際に存在するPWAの数と、これらの新しいテクノロジーをどのように利用するかを決定します。<a hreflang="en" href="https://caniuse.com/#feat=background-sync">バックグラウンド同期</a>のような特定の高度なAPIは、現在もChromiumベースのブラウザでのみ利用できるため、追加の質問として、これらのPWAが実際に使用する機能を調べました。

## Service Worker

### Service Workerの登録とインストール可能性

{{ figure_markup(
  caption="Service Workerを登録するデスクトップページの割合。",
  content="0.44%",
  classes="big-number"
)
}}

最初に検討する指標は、Service Workerのインストールです。 HTTP Archiveの機能カウンターを介して公開されたデータを見ると、すべてのデスクトップの0.44％とすべてのモバイルページの0.37％がService Workerを登録しており、時間の経過に伴う両方の曲線が急成長しています。

{{ figure_markup(
  image="fig2.png",
  caption="デスクトップおよびモバイルのService Workerの経時的なインストール。",
  description="Service Workerのインストールの時系列チャート。 2017年1月以降、デスクトップとモバイルは約0.0％から約0.4％に着実に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=251442414&format=interactive"
  )
}}

これはあまり印象的でないかもしれませんが、Chromeプラットフォームステータスからのトラフィックデータを考慮すると、Service Workerが<a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">すべてのページロードの約15％</a>を制御していることがわかります。トラフィックの多いサイトがますますService Workerを受け入れ始めています。

{{ figure_markup(
  caption='Service Workerを登録するページのページビューの割合。 （出典：Chromeプラットフォームステータス） (出典: <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">Chromeプラットフォームステータス</a>)',
  content="15%",
  classes="big-number"
)
}}

[Lighthouse](./methodology#lighthouse)は、ページが<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/install-prompt">インストールプロンプト</a>の対象かどうかを確認します。モバイルページの1.56％に<a hreflang="ja" href="https://web.dev/i18n/ja/installable-manifest/">インストール可能なマニフェスト</a>があります。

インストール体験をコントロールするために、全デスクトップの0.82％と全モバイルページの0.94％が<a hreflang="en" href="https://w3c.github.io/manifest/#beforeinstallpromptevent-interface">`OnBeforeInstallPrompt`インターフェイス</a>を使用します。現在、<a hreflang="en" href="https://caniuse.com/#feat=web-app-manifest">サポートはChromiumベースのブラウザに限定されています</a>。

### Service Workerイベント

Service Workerでは、<a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers/lifecycle">いくつかのイベントをリッスンできます</a>。

- `install`, Service Workerのインストール時に発生します。
- `activate`, Service Workerのアクティベーション時に発生します。
- `fetch`, リソースがフェッチされるたびに発生します。
- `push`, プッシュ通知が到着したときに発生します。
- `notificationclick`, 通知がクリックされたときに発生します。
- `notificationclose`, 通知が閉じられたときに発生します。
- `message`, `postMessage()`を介して送信されたメッセージが到着したときに発生します。
- `sync`, バックグラウンド同期イベントが発生すると発生します。

{{ figure_markup(
  image="fig4.png",
  caption="Service Workerイベントの人気。",
  description="さまざまなService Workerイベントの人気を示す棒グラフ。 Fetchは、モバイルService Workerの73％、インストール71％、アクティブ化56％、通知クリック10％、プッシュ8％、メッセージ5％、通知クローズ2％、同期1％で使用されます。デスクトップService Workerの使用方法は似ていますが、取得、インストール、およびアクティブ化の場合は若干低くなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2110574556&format=interactive"
  )
}}

HTTP Archiveで見つけることのできるService Workerがこれらのイベントのどれをリッスンしているかを調べました。モバイルとデスクトップの結果は非常によく似ており、`fetch`、`install`、および`activate`が3つの最も人気のあるイベントであり、それに続いて`notificationclick`と`push`が行われます。これらの結果を解釈すると、Service Workerが有効にするオフラインユースケースは、プッシュ通知よりもはるかに先のアプリ開発者にとって最も魅力的な機能です。可用性が限られているため、あまり一般的ではないユースケースのため、現時点ではバックグラウンド同期は重要な役割を果たしていません。

### Service Workerのファイルサイズ

一般に、ファイルサイズまたはコード行は、手元のタスクの複雑さの悪いプロキシです。ただし、この場合、モバイルとデスクトップのService Workerの（圧縮された）ファイルサイズを比較することは間違いなく興味深いです。

{{ figure_markup(
  image="fig5.png",
  caption="Service Workerの転送サイズの分布。",
  description="Service Workerの転送サイズの分布を示す棒グラフ。デスクトップService Worker転送サイズの10、25、50、75、および90パーセンタイルは、176、350、895、2,010、および4,138バイトです。デスクトップService Workerは、90パーセンタイルの1,000バイトから、パーセンタイルごとに大きくなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=345926232&format=interactive"
  )
}}

デスクトップのService Workerファイルの中央値は895バイトですが、モバイルでは694バイトです。すべてのパーセンタイルを通じて、デスクトップService WorkerはモバイルService Workerよりも大きくなっています。これらの統計は、[`importScripts()`](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts)メソッドを使用して動的にインポートされたスクリプトを考慮しないため、結果は大きく歪む可能性が高いことに注意してください。

## Webアプリマニフェスト

### Webアプリマニフェストのプロパティ

Webアプリマニフェストは、ブラウザーにWebアプリケーションと、ユーザーのモバイルデバイスまたはデスクトップにインストールされたときの動作を通知する単純なJSONファイルです。典型的なマニフェストファイルには、アプリ名、使用するアイコン、起動時に開く開始URLなどに関する情報が含まれています。検出されたすべてのマニフェストの1.54％のみが無効なJSONであり、残りは正しく解析されました。

<a hreflang="en" href="https://w3c.github.io/manifest/#webappmanifest-dictionary">Web App Manifest仕様</a>で定義されているさまざまなプロパティを調べ、非標準の独自プロパティも検討しました。仕様によると、次のプロパティが許可されています。

- `dir`
- `lang`
- `name`
- `short_name`
- `description`
- `icons`
- `screenshots`
- `categories`
- `iarc_rating_id`
- `start_url`
- `display`
- `orientation`
- `theme_color`
- `background_color`
- `scope`
- `serviceworker`
- `related_applications`
- `prefer_related_applications`

私たちが野生で観察しなかった唯一のプロパティは`iarc_rating_id`でした。これは、Webアプリケーションの国際年齢評価連合（IARC）認定コードを表す文字列です。 Webアプリケーションがどの年齢に適しているかを判断するために使用することを目的としています。

{{ figure_markup(
  image="fig6.png",
  caption="Webアプリマニフェストプロパティの人気。",
  description="デスクトップおよびモバイル向けのWebアプリマニフェストプロパティの人気を示す棒グラフ。デスクトップWebアプリマニフェストの88％には、名前プロパティ、82％はアイコン、61％はディスプレイ、55％はテーマカラー、49％は背景色、45％はショートネーム、36％は開始URL、19％はGCM送信者ID、9％はGCMユーザーのみ表示、9％はオリエンテーション、説明7％、範囲5％、言語4％。モバイルWebアプリマニフェストでのプロパティの人気は似ており、プラスまたはマイナス2パーセントポイントです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1904325089&format=interactive",
  width=600,
  height=452,
  data_width=600,
  data_height=452
  )
}}

頻繁に遭遇した独自のプロパティは、従来のGoogle Cloud Messaging（GCM）サービスの`gcm_sender_id`と`gcm_user_visible_only`でした。興味深いことに、モバイルとデスクトップにはほとんど違いがありません。ただし、両方のプラットフォームで、ブラウザーによって解釈されないプロパティの長いテールがありますが、`作成者`や`バージョン`などの潜在的に有用なメタデータが含まれています。また、重要なタイプミスのプロパティもありました。私たちのお気に入りは、`short_name`ではなく`shot_name`です。興味深い外れ値は`serviceworker`プロパティです。これは標準ですが、ブラウザベンダーによって実装されていません。それでも、モバイルおよびデスクトップページで使用されるすべてのWebアプリマニフェストの0.09％で見つかりました。

### 値を表示する

開発者が`display`プロパティに設定した値を見ると、PWAがWebテクノロジーの起源を明かさない「適切な」アプリとして認識されることを望んでいることがすぐに明らかになります。

{{ figure_markup(
  image="fig7.png",
  caption="Webアプリマニフェストの <code>display</code> プロパティの使用法。",
  description="Webアプリマニフェストの表示プロパティがデスクトップおよびモバイルWebサイトでどのように使用されるかを示す棒グラフ。どちらの場合も、57％の時間で「standalone」値が使用されます。マニフェストの38％でプロパティがまったく設定されていません。 「minimal UI」、「browser」、および「fullscreen」の各値は、使用量の1〜2％のみを占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1514793237&format=interactive"
  )
}}

`standalone`を選択することで、エンドユーザーにブラウザUIが表示されないようにします。これは、`prefers_related_applications`プロパティを使用するアプリの大部分に反映されています。モバイルアプリケーションとデスクトップアプリケーションの両方の97％がネイティブアプリケーションを優先していません。

### Category値

`categories`プロパティは、Webアプリケーションが属する予想されるアプリケーションカテゴリを記述します。これは、Webアプリケーションをリストするカタログまたはアプリストアへのヒントとしてのみ意図されており、Webサイトは1つ以上の適切なカテゴリに自分自身をリストするために最善を尽くすことが期待されます。

{{ figure_markup(
  image="fig8.png",
  caption="上位のWebアプリマニフェストカテゴリ。",
  description="上位のWebアプリマニフェストカテゴリを示す棒グラフ。 60個のモバイルマニフェストは「ショッピング」カテゴリ、15個は「ビジネス」、9個は「ウェブ」、9個は「テクノロジー」、8個は「ゲーム」、8個は「エンターテイメント」、7個は「ソーシャル」などです。 「ショッピング」の場合、デスクトップマニフェストは1つだけです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1609487902&format=interactive"
  )
}}

このプロパティを利用したマニフェストはあまり多くありませんでしたが、モバイルで最も人気のあるカテゴリである「ショッピング」から「ビジネス」「テクノロジー」、そして最初の場所を均等に共有するデスクトップ上の「ウェブ」（それが意味するものは何でも）。

### アイコンのサイズ

Lighthouseには少なくとも192X192ピクセルのサイズのアイコンが<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/manifest-contains-192px-icon">必要</a>ですが、一般的なファビコン生成ツールは他のサイズのアイコンも大量に作成します。

{{ figure_markup(
  image="fig9.png",
  caption="上位のWebアプリマニフェストアイコンのサイズ。",
  description="上位のWebアプリマニフェストアイコンサイズプロパティ値の使用状況を示す棒グラフ。すべての値は高さと幅のピクセルで指定されます。たとえば、マニフェストの23％のトップ値は192X192ピクセルです。次に人気のあるサイズは、11％で144、11％で96、10％で72、10％で48、9％で512、9％で36％、5％で256、2％で384、1%で128、そして1％で152です。デスクトップとモバイルの使用パターンは同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1369881840&format=interactive"
  )
}}

Lighthouseのルールが、おそらくアイコンサイズ選択の犯人で、192ピクセルがデスクトップとモバイルの両方で最も人気があります。<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-app-manifest#icons">Googleのドキュメント</a>で512X512を明示的に推奨していますが、これは特に目立つオプションとしては表示されてません。

### Orientation値

`orientation`プロパティの有効な値は、<a hreflang="en" href="https://www.w3.org/TR/screen-orientation/#dom-orientationlocktype">画面方向API仕様</a>で定義されています。現在、それらは次のとおりです。

- `"any"`
- `"natural"`
- `"landscape"`
- `"portrait"`
- `"portrait-primary"`
- `"portrait-secondary"`
- `"landscape-primary"`
- `"landscape-secondary"`

{{ figure_markup(
  image="fig10.png",
  caption="上位のWebアプリマニフェストのOrientation値。",
  description="上位のWebアプリマニフェストの方向の値を示す棒グラフ。 「Portrait」はデスクトップマニフェストの6％に設定され、2％に「any」が続き、マニフェストの1％未満に他のすべてが設定されます。これはモバイルマニフェストでの使用に似ていますが、マニフェストの8％で「portrait」が設定され、1％で「portrait-primary」が設定されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2065142361&format=interactive"
  )
}}

`「portrait」`オリエンテーションは両方のプラットフォームで明確な勝者であり、`「any」`オリエンテーションがそれに続きます。

## Workbox

<a hreflang="en" href="https://developers.google.com/web/tools/workbox">Workbox</a>は、一般的なService Workerのユースケースを支援する一連のライブラリです。たとえばWorkboxには、ビルドプロセスにプラグインしてファイルのマニフェストを生成できるツールがあり、Service Workerによって事前にキャッシュされます。 Workboxには、ランタイムキャッシング、リクエストルーティング、キャッシュの有効期限、バックグラウンド同期などを処理するライブラリが含まれています。

Service Worker APIの低レベルの性質を考慮すると、多くの開発者は、Service Workerロジックをより高レベルで再利用可能なコードの塊に構造化する方法としてWorkboxに注目しています。 Workboxの採用は、<a hreflang="en" href="https://create-react-app.dev/">`create-react-app`</a>や<a hreflang="en" href="https://www.npmjs.com/package/@vue/cli-plugin-pwa">VueのPWAプラグイン</a>など、多くの一般的なJavaScriptフレームワークスターターキットの機能として含まれることによっても促進されます。

HTTP Archiveは、Service Workerを登録するWebサイトの12.71％が少なくとも1つのWorkboxライブラリを使用していることを示しています。この割合は、デスクトップ（14.36％）と比較してモバイルではわずかに低い割合（11.46％）で、デスクトップとモバイルでほぼ一貫しています。

## 結論

この章の統計は、PWAがまだごく一部のサイトでしか使用されていないことを示しています。ただし、この比較的少ない使用量はトラフィックのシェアがはるかに大きい人気のあるサイトによってもたらされ、ホームページ以外のページはこれをさらに使用する可能性があります。ページのロードの15％がService Workerを使用することがわかりました。特に[モバイル](./mobile-web)向けの[パフォーマンス](./performance)と[キャッシング](./caching)のより優れた制御に与える利点は、使用が増え続けることを意味するはずです。

PWAは、Chrome主導のテクノロジーと見なされることがよくあります。一部のプラットフォームでは一流のインストール可能性が遅れているものの、他のブラウザは、基盤となるテクノロジーのほとんどを実装するために最近大きく進歩しました。サポートがさらに普及するのを前向きに見る事ができます。 [Maximiliano Firtman](https://twitter.com/firt)は、<a hreflang="en" href="https://medium.com/@firt/iphone-11-ipados-and-ios-13-for-pwas-and-web-development-5d5d9071cc49">Safari PWAサポートの説明</a>など、iOSでこれを追跡する素晴らしい仕事をしています。 AppleはPWAという用語をあまり使用せず、<a hreflang="en" href="https://developer.apple.com/news/?id=09062019b">HTML5アプリはApp Storeの外部に最適配信されると明示的に述べています</a>。Microsoftは逆の方向に進み、<a hreflang="en" href="https://web.archive.org/web/20190711051508/https://docs.microsoft.com/en-us/microsoft-edge/progressive-web-apps/microsoft-store">アプリストアでPWAを奨励するだけでなく、Bing Webクローラーを介して検出されたPWAを自動的にショートリストに追加しました</a>。 Googleは、<a hreflang="en" href="https://developers.google.com/web/updates/2019/02/using-twa">信頼できるWebアクティビティ</a>を介して、Google PlayストアにWebアプリをリストする方法も提供しています。

PWAは、ネイティブプラットフォームやアプリストアではなくWeb上でビルドおよびリリースすることを希望する開発者に道を提供します。すべてのOSとブラウザがネイティブソフトウェアと完全に同等であるとは限りませんが、改善は継続され、おそらく2020年は展開が爆発的に増加する年になるでしょうか？
