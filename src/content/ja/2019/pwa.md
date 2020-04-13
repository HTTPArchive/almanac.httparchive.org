---
part_number: II
chapter_number: 11
title: PWA
description: Service Worker（登録、インストール可能性、イベント、およびファイルサイズ）、Webアプリマニフェストプロパティ、およびWorkboxを対象とする2019 Web AlmanacのPWAの章。
authors: [tomayac, jeffposnick]
reviewers: [hyperpress, ahmadawais]
translators: [ksakae]
discuss: 1766
results: https://docs.google.com/spreadsheets/d/19BI3RQc_vR9bUPPZfVsF_4gpFWLNT6P0pLcAdL-A56c/
queries: 11_PWA
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-23T00:00:00.000Z
---

## 導入

プログレッシブWebアプリ（PWA）は、[Service Worker API](https://developer.mozilla.org/en/docs/Web/API/Service_Worker_API)などのプラットフォームプリミティブ上に構築される新しいクラスのWebアプリケーションです。Service Workerは、ネットワークプロキシとして機能し、Webアプリの発信要求をインターセプトしプログラムまたはキャッシュされた内容で応答することによりアプリがネットワークに依存しない読み込みをサポートできるようにします。Service Workerは、プッシュ通知を受信し、対応するアプリが実行されていなくてもバックグラウンドでデータを同期できます。さらに、Service Workerは、[Webアプリマニフェスト](https://developer.mozilla.org/en-US/docs/Web/Manifest)と共にユーザーがデバイスのホーム画面にPWAをインストールできるようにします。

Service Workerは2014年12月に[Chrome 40で初めて実装](https://blog.chromium.org/2014/12/chrome-40-beta-powerful-offline-and.html)され、プログレッシブWebアプリという用語は2015年に[Frances BerrimanとAlex Russellによって作られました](https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/)。Service Workerはすべての主要なブラウザでようやく実装されたため、この章の目標は実際に存在するPWAの数と、これらの新しいテクノロジーをどのように利用するかを決定します。[バックグラウンド同期](https://caniuse.com/#feat=background-sync)のような特定の高度なAPIは、現在もChromiumベースのブラウザでのみ利用できるため、追加の質問として、これらのPWAが実際に使用する機能を調べました。

## Service Worker

### Service Workerの登録とインストール可能性

<figure>
  <div class="big-number">0.44%</div>
  <figcaption>図1. Service Workerを登録するデスクトップページの割合。</figcaption>
</figure>

最初に検討する指標は、Service Workerのインストールです。 HTTPアーカイブの機能カウンターを介して公開されたデータを見ると、すべてのデスクトップの0.44％とすべてのモバイルページの0.37％がService Workerを登録しており、時間の経過に伴う両方の曲線が急成長しています。

<figure>
  <a href="/static/images/2019/pwa/fig2.png" class="fig-mobile">
    <img src="/static/images/2019/pwa/fig2.png" alt="図2.デスクトップおよびモバイルのService Workerの経時的なインストール。" aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=251442414&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">Service Workerのインストールの時系列チャート。 2017年1月以降、デスクトップとモバイルは約0.0％から約0.4％に着実に増加しています。</div>
  <figcaption id="fig2-caption">図2.デスクトップおよびモバイルのService Workerの経時的なインストール。</figcaption>
</figure>

これはあまり印象的でないかもしれませんが、Chromeプラットフォームステータスからのトラフィックデータを考慮すると、Service Workerが[すべてのページロードの約15％](https://www.chromestatus.com/metrics/feature/timeline/popularity/990)を制御していることがわかります。トラフィックの多いサイトがますますService Workerを受け入れ始めています。

<figure>
  <div class="big-number">15%</div>
  <figcaption>図3.Service Workerを登録するページのページビューの割合。 （出典：Chromeプラットフォームステータス） (出典: <a href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">Chromeプラットフォームステータス</a>)</figcaption>
</figure>

[Lighthouse](./methodology#lighthouse)は、ページが[インストールプロンプト](https://developers.google.com/web/tools/lighthouse/audits/install-prompt)の対象かどうかを確認します。モバイルページの1.56％に[インストール可能なマニフェスト](https://web.dev/installable-manifest/)があります。

インストール体験をコントロールするために、全デスクトップの0.82％と全モバイルページの0.94％が[`OnBeforeInstallPrompt`インターフェイス](https://w3c.github.io/manifest/#beforeinstallpromptevent-interface)を使用します。現在、[サポートはChromiumベースのブラウザに限定されています](https://caniuse.com/#feat=web-app-manifest)。

### Service Workerイベント

Service Workerでは、[いくつかのイベントをリッスンできます](https://developers.google.com/web/fundamentals/primers/service-workers/lifecycle)。

- `install`, Service Workerのインストール時に発生します。
- `activate`, Service Workerのアクティベーション時に発生します。
- `fetch`, リソースがフェッチされるたびに発生します。
- `push`, プッシュ通知が到着したときに発生します。
- `notificationclick`, 通知がクリックされたときに発生します。
- `notificationclose`, 通知が閉じられたときに発生します。
- `message`, `postMessage()`を介して送信されたメッセージが到着したときに発生します。
- `sync`, バックグラウンド同期イベントが発生すると発生します。

<figure>
  <a href="/static/images/2019/pwa/fig4.png">
    <img src="/static/images/2019/pwa/fig4.png" alt="図4. Service Workerイベントの人気。" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2110574556&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">さまざまなService Workerイベントの人気を示す棒グラフ。 Fetchは、モバイルService Workerの73％、インストール71％、アクティブ化56％、通知クリック10％、プッシュ8％、メッセージ5％、通知クローズ2％、同期1％で使用されます。デスクトップService Workerの使用方法は似ていますが、取得、インストール、およびアクティブ化の場合は若干低くなります。</div>
  <figcaption id="fig4-caption">図4. Service Workerイベントの人気。</figcaption>
</figure>

HTTPアーカイブで見つけることのできるService Workerがこれらのイベントのどれをリッスンしているかを調べました。モバイルとデスクトップの結果は非常によく似ており、`fetch`、`install`、および`activate`が3つの最も人気のあるイベントであり、それに続いて`notificationclick`と`push`が行われます。これらの結果を解釈すると、Service Workerが有効にするオフラインユースケースは、プッシュ通知よりもはるかに先のアプリ開発者にとって最も魅力的な機能です。可用性が限られているため、あまり一般的ではないユースケースのため、現時点ではバックグラウンド同期は重要な役割を果たしていません。

### Service Workerのファイルサイズ

一般に、ファイルサイズまたはコード行は、手元のタスクの複雑さの悪いプロキシです。ただし、この場合、モバイルとデスクトップのService Workerの（圧縮された）ファイルサイズを比較することは間違いなく興味深いです。

<figure>
  <a href="/static/images/2019/pwa/fig5.png">
    <img src="/static/images/2019/pwa/fig5.png" alt="図5. Service Workerの転送サイズの分布。" aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=345926232&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Service Workerの転送サイズの分布を示す棒グラフ。デスクトップService Worker転送サイズの10、25、50、75、および90パーセンタイルは、176、350、895、2,010、および4,138バイトです。デスクトップService Workerは、90パーセンタイルの1,000バイトから、パーセンタイルごとに大きくなります。</div>
  <figcaption id="fig5-caption">図5. Service Workerの転送サイズの分布。</figcaption>
</figure>

デスクトップのService Workerファイルの中央値は895バイトですが、モバイルでは694バイトです。すべてのパーセンタイルを通じて、デスクトップService WorkerはモバイルService Workerよりも大きくなっています。これらの統計は、[`importScripts()`](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts)メソッドを使用して動的にインポートされたスクリプトを考慮しないため、結果は大きく歪む可能性が高いことに注意してください。

## Webアプリマニフェスト

### Webアプリマニフェストのプロパティ

Webアプリマニフェストは、ブラウザーにWebアプリケーションと、ユーザーのモバイルデバイスまたはデスクトップにインストールされたときの動作を通知する単純なJSONファイルです。典型的なマニフェストファイルには、アプリ名、使用するアイコン、起動時に開く開始URLなどに関する情報が含まれています。検出されたすべてのマニフェストの1.54％のみが無効なJSONであり、残りは正しく解析されました。

[Web App Manifest仕様](https://w3c.github.io/manifest/#webappmanifest-dictionary)で定義されているさまざまなプロパティを調べ、非標準の独自プロパティも検討しました。仕様によると、次のプロパティが許可されています。

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

<figure>
  <a href="/static/images/2019/pwa/fig6.png">
    <img src="/static/images/2019/pwa/fig6.png" alt="図6. Webアプリマニフェストプロパティの人気。" aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="452" data-width="600" data-height="452" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1904325089&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">デスクトップおよびモバイル向けのWebアプリマニフェストプロパティの人気を示す棒グラフ。デスクトップWebアプリマニフェストの88％には、名前プロパティ、82％はアイコン、61％はディスプレイ、55％はテーマカラー、49％は背景色、45％はショートネーム、36％は開始URL、19％はGCM送信者ID、9％はGCMユーザーのみ表示、9％はオリエンテーション、説明7％、範囲5％、言語4％。モバイルWebアプリマニフェストでのプロパティの人気は似ており、プラスまたはマイナス2パーセントポイントです。</div>
  <figcaption id="fig6-caption">図6. Webアプリマニフェストプロパティの人気。</figcaption>
</figure>

頻繁に遭遇した独自のプロパティは、従来のGoogle Cloud Messaging（GCM）サービスの`gcm_sender_id`と`gcm_user_visible_only`でした。興味深いことに、モバイルとデスクトップにはほとんど違いがありません。ただし、両方のプラットフォームで、ブラウザーによって解釈されないプロパティの長いテールがありますが、`作成者`や`バージョン`などの潜在的に有用なメタデータが含まれています。また、重要なタイプミスのプロパティもありました。私たちのお気に入りは、`short_name`ではなく`shot_name`です。興味深い外れ値は`serviceworker`プロパティです。これは標準ですが、ブラウザベンダーによって実装されていません。それでも、モバイルおよびデスクトップページで使用されるすべてのWebアプリマニフェストの0.09％で見つかりました。

### 値を表示する

開発者が`display`プロパティに設定した値を見ると、PWAがWebテクノロジーの起源を明かさない「適切な」アプリとして認識されることを望んでいることがすぐに明らかになります。

<figure>
  <a href="/static/images/2019/pwa/fig7.png">
    <img src="/static/images/2019/pwa/fig7.png" alt="図7. Webアプリマニフェストのdisplayプロパティの使用法。" aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1514793237&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Webアプリマニフェストの表示プロパティがデスクトップおよびモバイルWebサイトでどのように使用されるかを示す棒グラフ。どちらの場合も、57％の時間で「standalone」値が使用されます。マニフェストの38％でプロパティがまったく設定されていません。 「minimal UI」、「browser」、および「fullscreen」の各値は、使用量の1〜2％のみを占めています。</div>
  <figcaption id="fig7-caption">図7. Webアプリマニフェストの<code>display</code>プロパティの使用法。</figcaption>
</figure>

`standalone`を選択することで、エンドユーザーにブラウザUIが表示されないようにします。これは、`prefers_related_applications`プロパティを使用するアプリの大部分に反映されています。モバイルアプリケーションとデスクトップアプリケーションの両方の97％がネイティブアプリケーションを優先していません。

### Category値

`categories`プロパティは、Webアプリケーションが属する予想されるアプリケーションカテゴリを記述します。これは、Webアプリケーションをリストするカタログまたはアプリストアへのヒントとしてのみ意図されており、Webサイトは1つ以上の適切なカテゴリに自分自身をリストするために最善を尽くすことが期待されます。

<figure>
  <a href="/static/images/2019/pwa/fig8.png">
    <img src="/static/images/2019/pwa/fig8.png" alt="図8.上位のWebアプリマニフェストカテゴリ。" aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1609487902&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">上位のWebアプリマニフェストカテゴリを示す棒グラフ。 60個のモバイルマニフェストは「ショッピング」カテゴリ、15個は「ビジネス」、9個は「ウェブ」、9個は「テクノロジー」、8個は「ゲーム」、8個は「エンターテイメント」、7個は「ソーシャル」などです。 「ショッピング」の場合、デスクトップマニフェストは1つだけです。</div>
  <figcaption id="fig8-caption">図8.上位のWebアプリマニフェストカテゴリ。</figcaption>
</figure>

このプロパティを利用したマニフェストはあまり多くありませんでしたが、モバイルで最も人気のあるカテゴリである「ショッピング」から「ビジネス」「テクノロジー」、そして最初の場所を均等に共有するデスクトップ上の「ウェブ」（それが意味するものは何でも）。

### アイコンのサイズ

Lighthouseには少なくとも192X192ピクセルのサイズのアイコンが[必要](https://developers.google.com/web/tools/lighthouse/audits/manifest-contains-192px-icon)ですが、一般的なファビコン生成ツールは他のサイズのアイコンも大量に作成します。

<figure>
  <a href="/static/images/2019/pwa/fig9.png">
    <img src="/static/images/2019/pwa/fig9.png" alt="図9.上位のWebアプリマニフェストアイコンのサイズ。" aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1369881840&amp;format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">上位のWebアプリマニフェストアイコンサイズプロパティ値の使用状況を示す棒グラフ。すべての値は高さと幅のピクセルで指定されます。たとえば、マニフェストの23％のトップ値は192X192ピクセルです。次に人気のあるサイズは、11％で144、11％で96、10％で72、10％で48、9％で512、9％で36％、5％で256、2％で384、1%で128、そして1％で152です。デスクトップとモバイルの使用パターンは同じです。</div>
  <figcaption id="fig9-caption">図9.上位のWebアプリマニフェストアイコンのサイズ。</figcaption>
</figure>

Lighthouseのルールが、おそらくアイコンサイズ選択の犯人で、192ピクセルがデスクトップとモバイルの両方で最も人気があります。[Googleのドキュメント](https://developers.google.com/web/fundamentals/web-app-manifest#icons)で512X512を明示的に推奨していますが、これは特に目立つオプションとしては表示されてません。

### Orientation値

`orientation`プロパティの有効な値は、[画面方向API仕様](https://www.w3.org/TR/screen-orientation/#dom-orientationlocktype)で定義されています。現在、それらは次のとおりです。

- `"any"`
- `"natural"`
- `"landscape"`
- `"portrait"`
- `"portrait-primary"`
- `"portrait-secondary"`
- `"landscape-primary"`
- `"landscape-secondary"`

<figure>
  <a href="/static/images/2019/pwa/fig10.png">
    <img src="/static/images/2019/pwa/fig10.png" alt="図10.上位のWebアプリマニフェストのOrientation値。" aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2065142361&amp;format=interactive">
  </a>
  <div id="fig10-description" class="visually-hidden">上位のWebアプリマニフェストの方向の値を示す棒グラフ。 「Portrait」はデスクトップマニフェストの6％に設定され、2％に「any」が続き、マニフェストの1％未満に他のすべてが設定されます。これはモバイルマニフェストでの使用に似ていますが、マニフェストの8％で「portrait」が設定され、1％で「portrait-primary」が設定されます。</div>
  <figcaption id="fig10-caption">図10.上位のWebアプリマニフェストのOrientation値。</figcaption>
</figure>

`「portrait」`オリエンテーションは両方のプラットフォームで明確な勝者であり、`「any」`オリエンテーションがそれに続きます。

## Workbox

[Workbox](https://developers.google.com/web/tools/workbox)は、一般的なService Workerのユースケースを支援する一連のライブラリです。たとえばWorkboxには、ビルドプロセスにプラグインしてファイルのマニフェストを生成できるツールがあり、Service Workerによって事前にキャッシュされます。 Workboxには、ランタイムキャッシング、リクエストルーティング、キャッシュの有効期限、バックグラウンド同期などを処理するライブラリが含まれています。

Service Worker APIの低レベルの性質を考慮すると、多くの開発者は、Service Workerロジックをより高レベルで再利用可能なコードの塊に構造化する方法としてWorkboxに注目しています。 Workboxの採用は、[`create-react-app`](https://create-react-app.dev/)や[VueのPWAプラグイン](https://www.npmjs.com/package/@vue/cli-plugin-pwa)など、多くの一般的なJavaScriptフレームワークスターターキットの機能として含まれることによっても促進されます。

HTTPアーカイブは、Service Workerを登録するWebサイトの12.71％が少なくとも1つのWorkboxライブラリを使用していることを示しています。この割合は、デスクトップ（14.36％）と比較してモバイルではわずかに低い割合（11.46％）で、デスクトップとモバイルでほぼ一貫しています。

## 結論

この章の統計は、PWAがまだごく一部のサイトでしか使用されていないことを示しています。ただし、この比較的少ない使用量はトラフィックのシェアがはるかに大きい人気のあるサイトによってもたらされ、ホームページ以外のページはこれをさらに使用する可能性があります。ページのロードの15％がService Workerを使用することがわかりました。特に[モバイル](./mobile-web)向けの[パフォーマンス](./performance)と[キャッシング](./caching)のより優れた制御に与える利点は、使用が増え続けることを意味するはずです。

PWAは、Chrome主導のテクノロジーと見なされることがよくあります。一部のプラットフォームでは一流のインストール可能性が遅れているものの、他のブラウザは、基盤となるテクノロジーのほとんどを実装するために最近大きく進歩しました。サポートがさらに普及するのを前向きに見る事ができます。 [Maximiliano Firtman](https://twitter.com/firt)は、[Safari PWAサポートの説明](https://medium.com/@firt/iphone-11-ipados-and-ios-13-for-pwas-and-web-development-5d5d9071cc49)など、iOSでこれを追跡する素晴らしい仕事をしています。 AppleはPWAという用語をあまり使用せず、[HTML5アプリはApp Storeの外部に最適配信されると明示的に述べています](https://developer.apple.com/news/?id=09062019b)。Microsoftは逆の方向に進み、[アプリストアでPWAを奨励するだけでなく、Bing Webクローラーを介して検出されたPWAを自動的にショートリストに追加しました](https://docs.microsoft.com/en-us/microsoft-edge/progressive-web-apps/microsoft-store)。 Googleは、[信頼できるWebアクティビティ](https://developers.google.com/web/updates/2019/02/using-twa)を介して、Google PlayストアにWebアプリをリストする方法も提供しています。

PWAは、ネイティブプラットフォームやアプリストアではなくWeb上でビルドおよびリリースすることを希望する開発者に道を提供します。すべてのOSとブラウザがネイティブソフトウェアと完全に同等であるとは限りませんが、改善は継続され、おそらく2020年は展開が爆発的に増加する年になるでしょうか？
