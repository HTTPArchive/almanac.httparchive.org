---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 機能
description: 2020年のWeb Almanac「機能」の章では、新しく強力なWebプラットフォームAPIを取り上げます。
hero_alt: Hero image of Web Almanac characters with superhero capes plugging various capabilities into a web page.
authors: [christianliebel]
reviewers: [tomayac]
analysts: [tomayac]
editors: [tunetheweb]
translators: [ksakae1216]
discuss: 2049
results: https://docs.google.com/spreadsheets/d/1N6j1qKv7vc51p1W9z_RrbJX9Se3Pmb-Uersfz4gWqqs/
christianliebel_bio: Christian Liebelは、<a hreflang="en" href="https://thinktecture.com">Thinktecture</a>のコンサルタントであり、ファーストクラスのWebアプリケーションの実装において、様々なビジネス分野のクライアントをサポートしています。Microsoft MVP for Developer Technologies、Google GDE for Web/Capabilities、Angularを担当し、W3C Web Applications Working Groupに参加しています。
featured_quote: 2020年のWeb機能の状態は健全で、強力な新しいAPIがChromiumベースのブラウザの新しいリリースに定期的に提供されています。最初のAPIは、すでに他のブラウザにも導入されています。
featured_stat_1: 0.0006%
featured_stat_label_1: (Chrome) Async クリップボード API を使用してページを読み込む
featured_stat_2: 0.49%
featured_stat_label_2: Storage Manager APIを使用しているサイト
featured_stat_3: 363
featured_stat_label_3: 関連アプリのインストールを許可しているサイト
---

## 序章

<a hreflang="en" href="./pwa">Progressive Web Apps</a>(PWA)はWeb技術をベースにしたクロスプラットフォームのアプリケーションモデルです。サービスワーカーの協力を得て、これらのアプリケーションはユーザーがオフラインの時でも実行されます。[Webアプリマニフェスト](https://developer.mozilla.org/docs/Web/Manifest)を利用すると、ホーム画面やプログラムリストにPWAを追加できます。そこから開くと、PWAはネイティブアプリケーションとして表示されます。ただしPWAはWebプラットフォームAPIを通して公開されている機能のみを使用できます。任意のネイティブインターフェイスを呼び出すことはできず、ネイティブアプリケーションとWebアプリケーションの間にギャップが残ります。

<a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">Capabilities Project</a>は、非公式にはProject Fuguとしても知られていますがGoogle、Microsoft、Intelの3社によるWebとネイティブの間のギャップを埋めるためのクロスカンパニーの取り組みです。これは、プラットフォームとしてのWebの関連性を保つために重要です。そのために、Chromiumの貢献者たちは、ユーザーのセキュリティ、プライバシー、信頼性を維持しながらOSの機能をWebに公開する新しいAPIを実装しています。これらの機能には以下のものが含まれますが、これらに限定されません。

- ローカルファイルシステム上のファイルにアクセスするための<a hreflang="en" href="https://web.dev/file-system-access/">ファイルシステムアクセスAPI</a>
- 特定のファイル拡張子のハンドラーとして登録するための<a hreflang="en" href="https://web.dev/file-handling/">ファイルハンドラーAPI</a>
- ユーザーのクリップボードにアクセスするには、<a hreflang="ja" href="https://web.dev/i18n/ja/async-clipboard/">非同期クリップボードAPI</a>を使用します。
- 他のアプリケーションとファイルを共有するための<a hreflang="ja" href="https://web.dev/i18n/ja/web-share/">Web共有API</a>
- ユーザーのアドレス帳から連絡先にアクセスするには、<a hreflang="ja" href="https://web.dev/i18n/ja/contact-picker/">連絡先ピッカーAPI</a>を使用します。
- 画像中の顔やバーコードを効率的に検出するための<a hreflang="en" href="https://web.dev/shape-detection/">形状検出API</a>
- <a hreflang="en" href="https://web.dev/nfc/">Web NFC</a>、<a hreflang="ja" href="https://web.dev/i18n/ja/serial/">Web Serial</a>、<a hreflang="ja" href="https://web.dev/i18n/ja/usb/">Web USB</a>、<a hreflang="ja" href="https://web.dev/i18n/ja/bluetooth/">Web Bluetooth</a>、およびその他のAPI（全リストについては、<a hreflang="en" href="https://goo.gle/fugu-api-tracker">Fugu API Tracker</a>を参照）

誰でも新しい機能を提案するには、<a hreflang="en" href="https://bit.ly/new-fugu-request">Chromiumバグトラッカーでチケットを作成</a>する必要があります。Chromiumのコントリビューターは提案を検討し、適切な標準化団体を通じて他の開発者やブラウザベンダーとすべてのAPIについて議論します。一方、ふぐチームはChromiumでAPIを実装します。その後、APIは<a hreflang="en" href="https://developer.chrome.com/ja/blog/origin-trials/">オリジントライアル</a>を通じて限られた人たちへ利用可能になります。この段階では開発者は特定のオリジンでAPIをテストするためのトークンにサインアップできます。APIが十分に堅牢であることが判明した場合、APIはChromiumで提供され、ベンダーが決定した場合は他のブラウザでも提供されます。<a hreflang="en" href="https://web.dev/fugu-status/">Capability Status</a>のサイトでは、異なるCapability APIがどこで行われているかを示しています。

ふぐプロジェクト、<span lang="en">Capabilities</a>プロジェクトのコードネームであるふぐは、日本料理にちなんで名付けられたもので、正しく調理されたふぐの肉は特別な味を体験できる。しかし正しく調理されていない場合は、致命的になる可能性があります。ふぐプロジェクトの強力なAPIは、開発者にとって非常にエキサイティングなものです。ユーザーのセキュリティやプライバシーに影響を与える可能性があります。そのため、ふぐチームはこれらの問題に特別な注意を払っています。例えば新しいインターフェイスでは、Webサイトを安全な接続（HTTPS）で送信する必要があります。中には、不正行為を防ぐために、クリックやキーを押すといったユーザーのジェスチャーを必要とするものもあります。その他の機能では、ユーザーによる明示的な許可が必要となります。開発者は、すべてのAPIを段階的な強化として使用できます。APIを機能検出することで、これらの機能をサポートしていないブラウザでアプリケーションが壊れることはありません。APIをサポートしているブラウザでは、ユーザーはより良い体験を得ることができます。このようにしてWebアプリはユーザーの特定のブラウザに応じて<a hreflang="en" href="https://web.dev/progressively-enhance-your-pwa/">段階的に強化</a>します。

本章では、HTTP Archiveと<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity">Chrome Platform Status</a>による利用状況データをもとに、様々な最新のWeb APIの概要と2020年のWeb機能の状況を紹介します。一部のインターフェイスは真新しいものもあるため、（相対的な）利用率は非常に低いです。そのため、他の章とは異なりHTTP Archiveの利用統計は相対的な割合ではなく、絶対的なページ数で表示されます。[技術的な制限](./methodology#metrics)のため、HTTP Archiveには、許可もユーザーのジェスチャーも必要としないAPIのデータしかありません。データがない場合は、代わりに<span lang="en">Chrome Platform Status</span>に従ったGoogle Chromeでのページロードのパーセンテージが表示されます。統計が必ずしも意味のあるものではないほど数値が小さくても、多くの場合はデータから傾向を読み取ることができます。また、これらの統計値は、この章の今後の年次版で、APIがどの程度成熟し、採用率が向上したかを振り返る際のベースラインとしても使用できます。特に断りのない限り、APIはChromiumベースのブラウザでのみ利用可能であり、その仕様は標準化の初期段階にあります。

## 非同期クリップボードAPI

`document.execCommand()`メソッドの助けを借りて、Webサイトはすでにユーザのクリップボードにアクセスできました。しかしAPIは同期的であり（クリップボードの項目を処理するのが難しい）、DOM内の選択されたテキストとしか対話できないため、このアプローチには多少の制限があります。そこで登場するのが <a hreflang="en" href="https://webkit.org/blog/10855/async-clipboard-api/">非同期クリップボードAPI</a>(<a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#async-clipboard-api">W3C草案</a>です。この新しいAPIは非同期であるだけでなく、大きなデータの塊のためにページをブロックしたり、許可が下りるのを待ったりしないという意味でもあります。

### 読み取りアクセス

非同期クリップボードAPIはクリップボードからコンテンツを読み込むための2つのメソッドを提供しています: プレーンテキスト用の短縮メソッドである `navigator.clipboard.readText()` と呼ばれるものと、任意のデータ用のメソッドである `navigator.clipboard.read()` です。現在、ほとんどのブラウザは追加のデータ形式としてHTMLコンテンツとPNG画像のみをサポートしています。クリップボードには機密データが含まれている可能性があるので、クリップボードから読み取るにはユーザの同意が必要です。

{{ figure_markup(
  image="async_clipboard_api.png",
  caption='非同期クリップボードAPIを使用したChromeでのページロードの割合<br>(ソース。<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2369">非同期クリップボード読み取り</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2370">非同期クリップボード書き込み</a>)',
  description="この機能を使用しているChromeのページロードの割合に基づく、非同期クリップボードAPIの使用状況のグラフです。これは読み取りと書き込みの使用状況を比較したもので、2020年の間に書き込みでは指数関数的に増加しているのに対し、読み取りは直線的に増加していることを示しています。2020年10月には、Chromeで全ページロードの0.0003%の間に読み取りが呼び出され、0.0006%の間に書き込みが呼び出されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1740212588&format=interactive",
  sheets_gid="2077755325"
  )
}}

非同期クリップボードAPIは比較的新しいAPIなので、現在のところ利用率はかなり低いです。2020年3月、SafariはSafari 13.1で非同期クリップボードAPIのサポートを追加しました。2020年の間に、`read()` APIの使用量は増加しました。2020年10月には、Google Chromeの全ページロードの0.0003%の間にAPIが呼び出されました。

### 書込みアクセス

読み込み操作とは別に、非同期クリップボードAPIにはクリップボードに内容を書き込むための2つのメソッドがあります。ここでもプレーンテキスト用の短縮メソッド `navigator.clipboard.writeText()` と、任意のデータ用のメソッド `navigator.clipboard.write()` があります。Chromiumベースのブラウザでは、タブがアクティブな状態でクリップボードに書き込むことは許可を必要としません。しかし、Webサイトがバックグラウンドにある時、クリップボードに書き込もうとすると許可が必要になります。この方法はユーザのジェスチャーとパーミッションが必要なので、HTTP Archiveのメトリクスの対象外となります。`read()` メソッドとは対照的に、`write()` メソッドの使用率は指数関数的に増加しており、2020年10月には全ページロードの0.0006%の一部になっています。

ふぐのもう1つの機能である<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=897289">RawクリップボードアクセスAPI</a>は、任意のデータをクリップボードからコピーしたり、クリップボードに貼り付けたりできるようにすることで非同期クリップボードAPIをさらに強化できます。

## ストレージマネージャーAPI

ブラウザは、Cookies、インデックス化されたデータベース（IndexedDB）、サービスワーカーのキャッシュストレージ、またはWebストレージ（ローカルストレージ、セッションストレージ）など、さまざまな方法でユーザーのシステム上にデータを保存できます。最近のブラウザでは、開発者はブラウザに応じて簡単に<a hreflang="ja" href="https://web.dev/i18n/ja/storage-for-the-web/">数百メガバイト、さらにはそれ以上の容量を保存</a>できます。ブラウザが容量を使い果たすと、システムが限界を超えるまでデータをクリアしてしまい、データの損失につながることがあります。

<a hreflang="en" href="https://storage.spec.whatwg.org/#storagemanager">WHATWG Storage Living Standard</a>の一部である<a hreflang="en" href="https://developer.mozilla.org/docs/Web/API/StorageManager">StorageManager API</a>のおかげで、ブラウザはもはやブラックボックスのように振る舞うことはありません。このAPIにより、開発者は残りの空き容量を推定して<a hreflang="en" href="https://web.dev/persistent-storage/">永続ストレージ</a>にオプトインでき、ディスク容量が少なくなってもブラウザがウェブサイトのデータをクリアしないことを意味します。そのため、このAPIでは、現在Chrome、Edge、Firefoxで利用可能な`navigator`オブジェクトに新しい`StorageManager`インターフェイスが導入されています。

### 利用可能なストレージを見積もる

開発者は`navigator.storage.estimated()`を呼び出すことで利用可能なストレージを見積もることができます。このメソッドは2つのプロパティを持つオブジェクトに解決する約束を返す。`use` はアプリケーションが使用したバイト数を示し、`quota` は利用可能な最大バイト数を示します。

{{ figure_markup(
  image="storage_manager_api_estimate.png",
  caption='<span lang="en">StorageManager API</span>の推定方法を利用したページ数の推移',
  description="HTTP Archiveで監視しているページ数をもとに、StorageManager APIの推定方法の利用状況をグラフ化したものです。モバイル デバイスとデスクトップ デバイスでの使用状況を比較しています。デスクトップでは直線的な伸びを示していますが、モバイルではホッケーのような伸びを示しています。10月はモバイルサイトが約34,000件、デスクトップサイトが約27,000件利用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1853644024&format=interactive",
  sheets_gid="1811313356",
  sql_file="durable_storage_estimate_usage.sql"
  )
}}

Storage Manager APIは2016年からChrome、2017年からFirefox、そして新しいChromiumベースのEdgeでサポートされています。HTTP Archiveのデータによると、デスクトップページ27,056ページ（0.49%）とモバイルページ34,042ページ（0.48%）でAPIが使用されています。2020年の間に、Storage Manager APIの使用率は増加の一途をたどっています。このことからも、この章では、このインターフェイスが最もよく使われているAPIとなっています。

### 永続的ストレージへのオプトイン

ウェブストレージには2つのカテゴリーがあります。「ベストエフォート」と「パーシステント」の2種類があり、前者がデフォルトとなっています。デバイスのストレージが少なくなると、ブラウザは自動的にベストエフォートストレージを解放しようとします。例えば、FirefoxとChromiumベースのブラウザは、最近使用されていないものからストレージを削除します。しかし、これは重要なデータを失うリスクがあります。退避を防ぐために、開発者は永続的なストレージを選ぶことができます。この場合、容量が少なくなってもブラウザはストレージをクリアしません。ユーザーは手動でストレージをクリアすることもできます。持続的ストレージを選択するには、開発者は`navigator.storage.persist()`メソッドを呼び出す必要があります。ブラウザとサイトの利用状況によっては、許可のプロンプトが表示されたり、リクエストが自動的に受け入れられたり拒否されたりすることがあります。

{{ figure_markup(
  image="storage_manager_api_persist.png",
  caption='<span lang="en">StorageManager API</span>の<span lang="en">persist</span>メソッドの使用ページ数。',
  description='HTTP Archiveで監視しているページ数をもとに、<span lang="en">StorageManager API</span>の<span lang="en">persist</span>メソッドの使用状況をグラフ化したものです。モバイルデバイスとデスクトップデバイスでの使用状況を比較しています。デスクトップページでは利用状況はほぼ安定していますが、モバイル端末では変動が大きくなっています。2020年10月には、デスクトップページで25ページ、モバイルページで176ページがAPIを利用しています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=644836316&format=interactive",
  sheets_gid="1095648844",
  sql_file="durable_storage_persist_usage.sql"
  )
}}

`persist()`APIは `estimate()`メソッドよりも呼び出される頻度が低い。このAPIを利用しているモバイルページは176ページに過ぎないのに対し、デスクトップのWebサイトは25ページである。デスクトップでの利用はこのように低いレベルにとどまっているようですが、モバイルデバイスでは明確な傾向は見られません。

## 新しい通知API

<span lang="en">Push API</span>と<span lang="en">Notifications API</span>の助けを借りて、Webアプリケーションは以前からプッシュメッセージを受信したり、通知バナーを表示したりすることができるようになっていました。しかし、いくつかの部分が欠けていました。これまではプッシュメッセージはサーバーを経由して送信しなければならず、オフラインでスケジュールを立てることができませんでした。また、システムにインストールされているWebアプリケーションでは、アイコンにバッジを表示することができませんでした。バッジと通知トリガーAPIは、両方のシナリオを可能にします。

### バッジAPI

いくつかのプラットフォームでは、アプリケーションのアイコンに開いているアクションの量を示すバッジを表示するのが一般的です。例えば、バッジは未読のメールや通知、完了すべきTo-Do項目の数を表示できます。<a hreflang="en" href="https://web.dev/badging-api/">バッジAPI</a> (<a hreflang="en" href="https://w3c.github.io/badging/">W3C非公式ドラフト</a>)では、インストールされたWebアプリケーションのアイコンにこのようなバッジを表示できます。開発者は `navigator.setAppBadge()` を呼び出すことでバッジを設定できます。このメソッドはアプリケーションのバッジに表示する番号を指定します。ブラウザはユーザーのデバイスに最も近い表示を行います。番号が指定されない場合は、一般的なバッジが表示されます（例: macOSでは白い点）。`navigator.clearAppBadge()`を呼び出すと、再びバッジが削除される。バッジAPIは、メールクライアントやソーシャルメディアアプリ、メッセンジャーに最適です。Twitter PWAでは、バッジAPIを利用してアプリのバッジに未読通知の数を表示しています。

{{ figure_markup(
  image="badging_api.png",
  caption='ChromeでバッジAPIを使用したページロードの割合<br>(ソース。<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2726">バッジセット</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2727">バッジクリア</a>)',
  description="この機能を使用してChromeでページが読み込まれる割合に基づく、バッジAPIの使用状況のグラフです。セットメソッドとクリアメソッドを比較しています。両メソッドの使用量は時間の経過とともに増加しており、一般的にはセットメソッドの方が呼び出される頻度は高くなっています。2020年10月には、両方のメソッドの使用率が急上昇しており、ピークはセットメソッドがページロードの0.025％、クリアが0.016％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1145004925&format=interactive",
  sheets_gid="1154751352"
  )
}}

2020年4月にはGoogle Chrome 81が新しいバッジAPIを提供し、7月にはMicrosoft Edge 84が続いた。ChromeがAPIを提供した後、利用件数は急増した。2020年10月、Google Chromeの全ページロードの0.025%で`setAppBadge()`メソッドが呼び出される。`clearAppBadge()` メソッドが呼び出される頻度は低く、ページロードの約0.016%の間に呼び出されています。

### 通知トリガーAPI

Push APIでは、ユーザーが通知を受け取るためにはオンラインである必要があります。ゲーム、リマインダーやTo-doアプリ、カレンダー、目覚まし時計など、一部のアプリケーションでは、ローカルで通知の対象日を決定してスケジュールを組むことも可能でした。この機能をサポートするために、Chromeチームは<a hreflang="en" href="https://web.dev/notification-triggers/">通知トリガー</a>（<a hreflang="en" href="https://github.com/beverloo/notification-triggers/blob/master/README.md">の説明者</a>と呼ばれる新しいAPIを使って実験を行っています。このAPIは`options`マップに`showTrigger`という新しいプロパティを追加し、サービスワーカーの登録時に`showNotification()`メソッドへ渡すことができます。このAPIは将来的にさまざまな種類のトリガーに対応できるように設計されていますが、現時点では時間ベースのトリガーのみが実装されています。特定の日時に基づいて通知をスケジューリングするために、開発者は`TimestampTrigger`の新しいインスタンスを作成し、ターゲットのタイムスタンプをそれに渡すことができる。

```js
registration.showNotification('Title', {
  body: 'Message',
  showTrigger: new TimestampTrigger(timestamp),
});
```

{{ figure_markup(
  image="notification_triggers_api.png",
  caption='Notification Triggers APIを使用したChromeでのページ読み込みの割合<br>（出典 <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">通知トリガー</a>）',
  description="この機能を使用しているChromeでのページ読み込みの割合に基づいた通知トリガーAPIの使用状況のグラフです。ページロードの約0.00003%で2020年3月にピークを迎え、2020年10月にはゼロになることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1388597384&format=interactive",
  sheets_gid="1740370570"
  )
}}

ふぐチームは、Chrome 80から83までのオリジントライアルで最初に通知トリガーの実験を行い、その後、開発者からのフィードバックがなかったために開発を一時停止していました。2020年10月にリリースされたChrome 86から、APIは再びオリジントライアルの段階に入っています。これは、2020年3月頃の最初のオリジントライアルでChromeでのページロードの0.000032%で呼び出されるのがピークだった通知トリガーAPIの利用データについても説明しています。

## Screen Wake Lock API

エネルギーを節約するために、モバイルデバイスは画面のバックライトを暗くし、最終的にはデバイスのディスプレイをオフにしますが、これはほとんどの場合で理にかなっています。しかし、例えば料理中にレシピを読んだり、プレゼンテーションを見たりしているときなど、ユーザーがアプリケーションに明示的にディスプレイをオフにしておきたいと思うようなシナリオもあります。<a hreflang="en" href="https://developer.mozilla.org/docs/Web/API/Screen_Wake_Lock_API">Screen Wake Lock API</a>(<a hreflang="en" href="https://www.w3.org/TR/screen-wake-lock/">W3C作業ドラフト</a>)は、画面をオンに保つメカニズムを提供することで、この問題を解決します。

`navigator.wakeLock.request()`メソッドはウェイクロックを作成する。このメソッドは `WakeLockType`パラメーターを取ります。将来的には、Wake Lock APIは画面をオフにしてCPUをオンにしたままにするなど、他のロックタイプを提供できるようになるかもしれません。今のところ、APIはスクリーンロックのみをサポートしているので、デフォルト値が `screen` のオプション引数を1つだけ用意しています。このメソッドは`WakeLockSentinel`オブジェクトに解決するプロミスを返す。開発者はこの参照を保存して`release()`メソッドを呼び出し、後で画面のウェイクロックを解除する必要があります。ブラウザはタブが非アクティブになったり、ユーザがウィンドウを最小化したりすると自動的にロックを解除します。またブラウザは、例えばバッテリー残量が少ないなどの理由で、要求を拒否して約束を拒否することがあります。

{{ figure_markup(
  image="screen_wake_lock_api.png",
  caption='<span lang="en">Screen Wake Lock API</span>を利用しているページ数',
  description='HTTP Archiveで監視しているページ数に基づいて、デスクトップページとモバイルページを比較した<span lang="en">Screen Wake Lock API</span>の利用状況のグラフです。2020年10月時点では、デスクトップ10ページ、モバイル5ページでAPIが利用されています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=718278185&format=interactive",
  sheets_gid="1008442251",
  sql_file="wake_lock_acquire_screen_lock_usage.sql"
  )
}}

米国で人気の料理サイトBettyCrocker.comは、Screen Wake Lock APIの助けを借りて、料理中に画面が暗くなるのを防ぐオプションをユーザーに提供している。<a hreflang="en" href="https://web.dev/betty-crocker/">ケーススタディ</a>では平均セッション時間が通常より3.1倍長くなり、バウンス率が50%減少し、購入意向指標が約300%増加したと発表しています。このように、インターフェイスは、Webサイトやアプリケーションの成功に直接的に測定可能な効果を持っています。Screen Wake Lock APIは、2020年7月にGoogle Chrome 84で提供されました。HTTP Archiveには4月、5月、8月、9月、10月のデータしかありません。Chrome 84のリリース後、利用率は一気に上昇しました。2020年10月には、デスクトップ10ページ、モバイル5ページでAPIが採用されました。

## アイドル検出API

アプリケーションの中には、ユーザーがデバイスを積極的に使用しているか、アイドル状態にあるかを判断する必要があります。例えば、チャットアプリケーションは、ユーザーが不在であることを表示することがあります。画面やマウス、キーボードとのやりとりがないなど、様々な要因が考慮されます。<a hreflang="en" href="https://web.dev/idle-detection/">アイドル検出API</a> (<a hreflang="en" href="https://wicg.github.io/idle-detection/">WICGコミュニティグループ報告書</a>)では、ある閾値を設定することで、ユーザがアイドル状態か画面ロック状態かを確認することができる抽象的なAPIを提供しています。

これを実現するために、APIはグローバルな`window`オブジェクト上に新しい`IdleDetector`インターフェイスを提供します。開発者がこの機能を利用する前に、まず`IdleDetector.requestPermission()`を呼び出してパーミッションを要求しなければなりません。ユーザが許可を与えれば、開発者は`IdleDetector`の新しいインスタンスを作成できます。このオブジェクトは2つのプロパティを提供します。`userState`と`screenState`の2つのプロパティを提供します。このオブジェクトは、ユーザの状態と画面の状態のどちらかが変化したときに`change`イベントを発生させます。最後に、アイドル検出は`start()`メソッドを呼び出して起動する必要があります。このメソッドは2つのパラメーターを持つ設定オブジェクトを受け取ります。ユーザーがアイドル状態でなければならない時間をミリ秒単位で定義する`threshold`と、開発者はオプションで`AbortSignal`を`abort`プロパティに渡すことができます。

{{ figure_markup(
  image="idle_detection_api.png",
  caption='アイドル検出APIを使用したChromeでのページロードの割合<br>(出典. <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">アイドル検出</a>。)',
  description="この機能を使用してChromeでページを読み込んだ割合に基づく、アイドル検出APIの使用状況のグラフです。利用可能なデータは2020年7月と10月のみで、APIの採用率は非常に低いことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=963792757&format=interactive",
  sheets_gid="1324588405"
  )
}}

本稿執筆時点では、アイドル検出APIはオリジントライアル中のため、今後APIの形は変わる可能性があります。また、同様の理由から使用率は非常に低く、測定可能なものはほとんどありません。

## 周期的バックグラウンド同期API

ユーザーがウェブアプリケーションを閉じると、バックエンドサービスとの通信ができなくなります。いくつかのケースでは、ネイティブアプリケーションができるように、開発者は多かれ少なかれ定期的にデータを同期させたいと思うかもしれません。例えば、ニュースアプリケーションは、ユーザーが目覚める前に最新のヘッドラインをダウンロードしたいかもしれません。<a hreflang="en" href="https://web.dev/periodic-background-sync/">周期的バックグラウンド同期API</a> (<a hreflang="en" href="https://wicg.github.io/periodic-background-sync/">WICGコミュニティグループ報告書</a>)は、Webとネイティブの間のこのギャップを埋めることを目指しています。

### 周期同期の登録

周期的バックグラウンド同期APIは、アプリが閉じている場合でも実行できるサービスワーカーに依存しています。他の機能と同様に、このAPIはまずユーザの許可が必要である。このAPIは`PeriodicSyncManager`という新しいインターフェイスを実装している。このインターフェイスが存在する場合、開発者はサービスワーカーの登録時にこのインターフェイスのインスタンスにアクセスできます。バックグラウンドでデータを同期させるには、アプリケーションは登録時に`periodicSync.register()`を呼び出して最初に登録しなければいけません。このメソッドは2つのパラメーターを持ちます:`tag`（登録を後で再認識するための任意の文字列）と、`minInterval`プロパティを持つ設定オブジェクトです。このプロパティは開発者が望む最小間隔をミリ秒単位で定義します。しかし、ブラウザは最終的にどのくらいの頻度でバックグラウンド同期を呼び出すかを決定します。

```js
registration.periodicSync.register('articles', {
  minInterval: 24 * 60 * 60 * 1000 // one day
});
```

### 周期的な同期間隔に対応

デバイスがオンラインの場合、インターバルの間隔毎にブラウザはサービスワーカーの`periodicsync`イベントをトリガーします。その後、サービスワーカースクリプトはデータを同期させるために必要なステップを実行できます。

```js
self.addEventListener('periodicsync', (event) => {
  if (event.tag === 'articles') {
    event.waitUntil(syncStuff());
  }
});
```

この記事を書いている時点で、このAPIを実装しているのはChromiumベースのブラウザのみです。これらのブラウザでは、APIを使用する前にアプリケーションをインストール（ホーム画面に追加）する必要があります。ウェブサイトの<a hreflang="en" href="https://www.chromium.org/developers/design-documents/site-engagement">サイトエンゲージメントスコア</a>は、定期的な同期イベントを呼び出せるか、どのくらいの頻度で呼び出せるかを定義します。現在の保守的な実装では、ウェブサイトは1日1回コンテンツを同期できます。

{{ figure_markup(
  image="periodic_background_sync_api.png",
  caption="周期的バックグラウンド同期APIを使用しているページ数。",
  description="HTTP Archiveで監視しているページ数に基づいた周期的バックグラウンド同期APIの使用状況のグラフです。モバイル端末とデスクトップ端末での利用状況を比較しています。2020年4月以降、デスクトップとモバイルでは1～2ページでAPIが利用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1444904371&format=interactive",
  sheets_gid="386193538",
  sql_file="periodic_background_sync_usage.sql"
  )
}}

このインターフェイスの利用率は現在のところ非常に低い。2020年の間に、HTTP Archiveが監視しているページのうち、このAPIを利用したのは1～2ページのみでした。

## ネイティブアプリストアとの統合

PWAは汎用性の高いアプリケーションモデルです。しかし、場合によっては、別個のネイティブアプリケーションを提供することはまだ意味があるかもしれません。例えば、アプリがウェブ上では利用できない機能を使用する必要がある場合や、アプリ開発者チームのプログラミング経験に基づいている場合などです。ユーザーがすでにネイティブアプリをインストールしている場合、アプリは通知を二度送信したり、対応するPWAのインストールを促進したくないかもしれません。

ユーザーがシステム上に関連するネイティブアプリケーションやPWAを既に持っているかどうかを検出するため、開発者は`navigator`オブジェクト上で<a hreflang="ja" href="https://web.dev/i18n/ja/get-installed-related-apps/">getInstalledRelatedApps()</a>メソッド（<a hreflang="en" href="https://wicg.github.io/get-installed-related-apps/spec/">WICGコミュニティグループ報告書</a>）を使用できます。このメソッドは現在Chromiumベースのブラウザで提供されており、AndroidとUniversal Windows Platform(UWP)の両方のアプリで動作します。開発者はネイティブアプリのバンドルを調整してWebサイトを参照するようにし、ネイティブアプリに関する情報をPWAのWebアプリマニフェストに追加する必要があります。その後、`getInstalledRelatedApps()`メソッドを呼び出すと、ユーザのデバイスにインストールされているアプリのリストが返されます。

```js
const relatedApps = await navigator.getInstalledRelatedApps();
relatedApps.forEach((app) => {
  console.log(app.id, app.platform, app.url);
});
```

{{ figure_markup(
  image="get_installed_related_apps.png",
  caption="`getInstalledRelatedApps()`を使用しているページ数",
  description="HTTP Archiveで監視しているページ数に基づくgetInstalledRelatedApps()の使用状況のグラフです。モバイルデバイスとデスクトップデバイスでの使用状況を比較しています。モバイルデバイスでは着実な成長を示しており、2020年10月にはデスクトップの44ページに対して363ページとピークを迎えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1774881171&format=interactive",
  sheets_gid="860146688",
  sql_file="get_installed_related_apps_usage.sql"
  )
}}

2020年の間に、`getInstalledRelatedApps()`APIはモバイルWebサイトで着実な成長を示しています。10月には、HTTP Archiveによって追跡された363のモバイルページがこのAPIを利用していました。デスクトップページでは、APIの成長はそれほど速くありません。これは現在AndroidストアとMicrosoftストアがWindows向けに提供しているアプリよりもかなり多くのアプリを提供していることにも起因している可能性があります。

## コンテンツインデックスAPI

Webアプリは、キャッシュストレージやインデックスDBなど、さまざまな方法でオフラインでコンテンツを保存できます。しかし、ユーザーにとっては、どのコンテンツがオフラインで利用可能かを発見するのは難しい。<a hreflang="en" href="https://web.dev/content-indexing-api/">コンテンツインデックスAPI</a>（<a hreflang="en" href="https://wicg.github.io/content-index/spec/">WICGエディタ草案</a>）を利用することで、開発者はコンテンツをより目立つように露出させることができます。現在このAPIをサポートしているブラウザはAndroidのChromeだけです。このブラウザでは、ダウンロードメニューに「あなたのための記事」の一覧が表示されます。コンテンツインデックスAPIでインデックスされたコンテンツがそこに表示されます。

コンテンツインデックスAPIは、新しい`ContentIndex`インターフェイスを提供することでサービスワーカーAPIを拡張します。このインターフェイスは、サービスワーカーの登録の`index`プロパティで利用できます。`add()`メソッドを使うと、開発者はコンテンツをインデックスに追加できます。各コンテンツには、ID、URL、起動URL、タイトル、説明、アイコンのセットが必要です。オプションで、コンテンツを記事、ホームページ、動画などの異なるカテゴリにグループ化できます。`delete()` メソッドはインデックスからコンテンツを再び削除し、`getAll()` メソッドはインデックス化されたすべてのエントリのリストを返す。

{{ figure_markup(
  image="content_indexing_api.png",
  caption='コンテンツインデックスAPIを使用したChromeでのページロードの割合<br>（出典 <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">コンテンツインデックス</a>)',
  description="Chromeでこの機能を使用しているページロードの割合に基づく、コンテンツインデックスAPIの使用状況のグラフです。最初は比較的低い使用率を示していますが、2020年10月になると突然10倍に増え、Chromeでのページロードの0.0021%で使用されています",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=258329620&format=interactive",
  sheets_gid="626752011"
  )
}}

コンテンツインデックスAPIは、2020年7月にChrome 84で提供が開始されました。提供直後は、Chromeでのページロードの約0.0002%の間にAPIが使用されていました。2020年10月時点では、この値はほぼ10倍に増加しています。

## 新しいトランスポートAPI

最後に、現在オリジントライアル中の2つの新しいトランスポート方式があります。1つ目は開発者がWebSocketsで高頻度のメッセージを受信できるようにするもので、2つ目はHTTPやWebSocketsとは別に全く新しい双方向通信プロトコルを導入しています。

### <span lang="en">WebSockets</span>の<span lang="en">Backpressure</span> {websocketsのbackpressure}

<span lang="en">WebSocket API</span>は、Webサイトとサーバー間の双方向通信に最適です。しかし、<span lang="en">WebSocket API</span>は<span lang="en">backpressure</span>を許さないので、高頻度のメッセージを扱うアプリケーションはフリーズする可能性があります。<a hreflang="ja" href="https://web.dev/i18n/ja/websocketstream/">WebSocketStream API</a>（<a hreflang="en" href="https://github.com/ricea/websocketstream-explainer/blob/master/README.md">の説明者</a>は、まだ標準化トラックには乗っていません）は、<span lang="en">WebSocket API</span>をストリームで拡張することは、使いやすい<span lang="en">backpressure</span>のサポートを<span lang="en">WebSocket API</span>にもたらしたいと考えています。通常の`WebSocket`コンストラクタを使う代わりに、開発者は`WebSocketStream`インターフェイスの新しいインスタンスを作成する必要があります。ストリームの`connection`プロパティは、読み込みと書き込み可能なストリームへ解決する約束を返します。

```js
const wss = new WebSocketStream(WSS_URL);
const {readable, writable} = await wss.connection;
const reader = readable.getReader();
const writer = writable.getWriter();
```

WebSocketStream APIは、ストリームのリーダーとライターが安全な場合にのみ処理を行うため、透過的にbackpressureを解決します。

{{ figure_markup(
  image="websocketstreams.png",
  caption='WebSocketStreamsを使用したChromeでのページ読み込みの割合<br>（出典 <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3018">WebSocketStream</a>)',
  description="この機能を使用してChromeでのページロードの割合に基づくWebSocketStreamsの使用状況のグラフです。2020年6月と7月にピークを迎え、約0.0008%のページロード中にAPIが使用されたことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1714443590&format=interactive",
  sheets_gid="691106754"
  )
}}

<span lang="en">WebSocketStream API</span>は最初のオリジントライアルを終え、再び実験段階に戻っています。これは、現在このAPIの使用率が非常に低く、ほとんど測定できない理由も説明しています。

### 速くする

<a hreflang="en" href="https://www.chromium.org/quic">QUIC</a>(<a hreflang="en" href="https://www.ietf.org/archive/id/draft-ietf-quic-transport-31.txt">IETFインターネット草案</a>)は、UDP上に実装された多重化されたストリームベースの双方向トランスポートプロトコルです。これは、TCP上に実装されている<span lang="en">HTTP/WebSocket API</span>に代わるものです。<a hreflang="ja" href="https://web.dev/i18n/ja/webtransport/">QuicTransport API</a>は、QUICサーバとメッセージを送受信するためのクライアント側APIです。開発者は、データグラムを介して信頼性のないデータを送信するか、そのストリームAPIを使用して信頼性の高いデータを送信するかを選択できます。

```js
const transport = new QuicTransport(QUIC_URL);
await transport.ready;

const ws = transport.sendDatagrams();
const stream = await transport.createSendStream();
```

QuicTransportは、WebSocket APIのユースケースをサポートし、信頼性やメッセージの順序よりも最小限の遅延が重要なシナリオのサポートを追加しているため、WebSocketの有効な代替手段です。これにより、ゲームや高頻度のイベントを扱うアプリケーションに適しています。

{{ figure_markup(
  image="quic_transport.png",
  caption='QuicTransport<br>を使ったChromeでのページ読み込みの割合（出典 <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3184">QuicTransport</a>）',
  description="この機能を使用してChromeでのページロードの割合に基づくQuicTransportの使用状況のグラフです。2020年10月にピークを迎え、ページロードの約0.00089%の間にAPIが使用されたことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1571330893&format=interactive",
  sheets_gid="708893754"
  )
}}

現在はまだほとんど測定できないほどの使用率です。2020年10月には強力に増加し、現在ではChromeでのページロードの0.00089%の間に使用されています。

## 結論

2020年のWeb機能の状態は健全であり、Chromiumベースのブラウザの新しいリリースには、新しくて強力なAPIが定期的に提供されています。コンテンツインデックスAPIやアイドル検出APIのようないくつかのインターフェイスは、特定のWebアプリケーションに仕上げの機能を追加するのに役立ちます。ファイルシステムアクセスや非同期クリップボードAPIのような他のAPIは、生産性アプリケーションという全く新しいアプリケーションカテゴリをWebに完全に移行させることを可能にします。非同期クリップボードやWeb共有APIのようなAPIの一部は、すでに他の非Chromiumブラウザにも導入されています。Safariは、Web共有APIを実装した最初のモバイルブラウザでした。

ふぐチームは、<a hreflang="en" href="https://developers.google.com/web/updates/capabilities#process">厳格なプロセス</a>を通じて、これらの機能へのアクセスが安全かつプライバシーに配慮した方法で行われることを保証します。さらに、ふぐチームは他のブラウザベンダーやウェブ開発者からの[フィードバック](mailto:fugu-dev@chromium.org)を積極的に募集しています。これらの新しいAPIのほとんどの使用率は比較的低いですが、本章で紹介するAPIの中にはバッジAPIやコンテンツインデックスAPIのように指数関数的、あるいはホッケーの棒のように成長しているものもあります。2021年のウェブ機能のあり方は、ウェブ開発者自身にかかっています。著者は素晴らしいWebアプリケーションを構築し、強力なAPIを後方互換性のある方法で活用して、Webをより有能なプラットフォームにするための手助けをすることをコミュニティに奨励しています。
