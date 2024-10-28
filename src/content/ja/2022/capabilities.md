---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: ケイパビリティ
description: 2022年のWeb Almanacのケイパビリティ章では、ハードウェアインターフェースへのアクセスをWebアプリに提供し、Webベースの生産性アプリを強化するなど、新しく強力なWebプラットフォームAPIについて説明しています。
authors: [MichaelSolati]
reviewers: [tomayac, christianliebel]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: [ksakae1216]
MichaelSolati_bio: MichaelはAmplicationのDeveloper Advocateで、開発者がAPIを構築し、IPAを飲むのを支援することに専念しています。さらに、彼はWeb GDEであり、ウェブ上で魅力的な体験を創造することとウェブの魔法のような方法についての愛を見つけました。
results: https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/
featured_quote: Capabilities Projectは、アプリケーションをウェブに移行させ、プラットフォーム固有のアプリケーションに関連するいくつかの障壁を取り除きます。
featured_stat_1: 38
featured_stat_label_1: ケイパビリティは1つのサイトで使用されました。
featured_stat_2: ~10%
featured_stat_label_2: モバイルとデスクトップのサイトのうち、約10%が _Async Clipboard API_ を使用しています。
featured_stat_3: 8%
featured_stat_label_3: モバイルとデスクトップのサイトのうち、8%が _Web Share API_ を使用しています。
---

## 序章

魅力的なウェブ体験は、ブラウザの基本的な機能に限定されるものではありません。基盤となるオペレーティングシステムの機能にアクセスできます。ウェブプラットフォームAPIは、これらの機能を公開し、[Progressive Web Apps (PWA)](./pwa)の基礎となります。PWAは、プラットフォーム固有のアプリケーションと同じ高品質の体験を提供できるウェブアプリケーションです。

さらに、ウェブプラットフォーム上のいくつかの機能は、[ファイルシステム](https://developer.mozilla.org/ja/docs/Web/API/File_System_API)、[位置情報](https://developer.mozilla.org/ja/docs/Web/API/Geolocation_API)、[クリップボード](https://developer.mozilla.org/ja/docs/Web/API/Clipboard_API)へのアクセス、さらに[ゲームパッド](https://developer.mozilla.org/ja/docs/Web/API/Gamepad_API)の検出など、低レベルの機能にアクセスできます。

## 方法論

この章では、HTTP Archiveの数百万ページにわたる公開データセットを使用しました。これらのページは、デスクトップとモバイルの両方で訪問されたかのようにアーカイブされており、デバイスによって異なるコンテンツを提供するサイトもあります。

HTTP Archiveのクローラーは、これらのページのソースコードを解析し、どのAPIが（潜在的に）使用されているかを特定しました。例えば、正規表現 `/navigator\.share\s*\(/g` を使用して、具体的なケースで [Web Share API](https://developer.mozilla.org/ja/docs/Web/API/Web_Share_API) がソースコードに含まれているかどうかをテストします。

この方法には2つの大きな問題があります。第一に、ミニファイなどにより、`navigator` が `n` に縮小された場合など、使用されている一部のAPIを検出できないため、報告が少なくなることがあります。さらに、APIが実際に使用されているかどうかを確認するためにコードを実行しないため、APIの出現を過報告することがあります。これらの限界にもかかわらず、この方法はウェブ上で使用されている機能の良い概要を提供すると考えています。

サポートされている機能のための合計75個の正規表現があります。使用されたすべての表現を見るには、[こちらのソースファイル](https://github.com/HTTPArchive/custom-metrics/blob/5d2f74fbdc580e76da5d1dad738fca8381429b9a/dist/fugu-apis.js)を参照してください。

この章の使用データは、2022年6月のクロールからのものです。生データは、[Capabilities 2022 Results Sheet](https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/edit?usp=sharing)で見ることができます。

また、この章では、昨年のAPI使用状況と比較します。前年の生データは、[Capabilities 2021 Results Sheet](https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/edit#gid=2077755325)で確認できます。

## 非同期クリップボードAPI

最初のAPIである[非同期クリップボードAPI](https://developer.mozilla.org/ja/docs/Web/API/Clipboard_API)は、システムのクリップボードへの読み書きアクセスを可能にします。

非同期クリップボードAPIは、クリップボードにアクセスするための廃止された`document.execCommand()` APIに取って代わります。

### 書き込みアクセス

クリップボードにデータを書き込むためには、[`writeText()`](https://developer.mozilla.org/ja/docs/Web/API/Clipboard/writeText)メソッドと[`write()`](https://developer.mozilla.org/ja/docs/Web/API/Clipboard/write)メソッドがあります。`writeText()`メソッドはString引数を取り、Promiseを返します。一方、`write()`メソッドは[`ClipboardItem`](https://developer.mozilla.org/ja/docs/Web/API/ClipboardItem)オブジェクトの配列を取り、同様にPromiseを返します。`ClipboardItem`オブジェクトは、画像などの任意のデータを保持できます。

ブラウザがClipboards API仕様によってサポートする必要があるデータタイプのリストがあります。この[W3Cのリスト](https://www.w3.org/TR/clipboard-apis/#mandatory-data-types-x)を参照してください。残念ながら、すべてのベンダーが完全なリストをサポートしているわけではありません。可能な場合はブラウザ固有のドキュメントを確認してください。

```js
await navigator.clipboard.writeText("hello world");

const blob = new Blob(["hello world"], { type: "text/plain" });
await navigator.clipboard.write([
  new ClipboardItem({
    [blob.type]: blob,
  }),
]);
```

### 読み取りアクセス

クリップボードからデータを読み取るためには、[`readText()`](https://developer.mozilla.org/ja/docs/Web/API/Clipboard/readText)メソッドと[`read()`](https://developer.mozilla.org/ja/docs/Web/API/Clipboard/read)メソッドがあります。これらの方法はいずれもPromiseを返し、クリップボードからのデータで解決されます。`readText()`メソッドはStringとして解決され、`read()`メソッドは`ClipboardItem`オブジェクトの配列として解決されます。

```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

ユーザーデータを安全に保つためには、クリップボードからデータを読み取るために[Permissions API](https://developer.mozilla.org/ja/docs/Web/API/Permissions_API)の`"clipboard-read"`権限が付与されていなければなりません。

クリップボードへの読み書きアクセスは、Chrome、Edge、Safariの現代のバージョンで利用可能です。Firefoxは`writeText()`のみをサポートしています。

### 非同期クリップボードAPIの成長

{{ figure_markup(
  image="Async-Clipboard-API-Usage.png",
  caption="2021年から2022年にかけてのデスクトップとモバイルでの非同期クリップボードAPIの使用状況。",
  description="デスクトップでの非同期クリップボードAPIの使用率は、2021年の8.91％から2022年には10.10％へと増加しました。モバイルでは、2021年の8.25％から2022年には9.27％へと増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=602028150&format=interactive",
  sheets_gid="637848098",
  sql_file="fugu.sql"
) }}

非同期クリップボードAPIは、デスクトップで2021年の8.91%から2022年には10.10%へと、またモバイルでは2021年の8.25%から2022年には9.27%へと使用率が増加しました。その結果、今年の非同期クリップボードAPIは、デスクトップとモバイルの両方で最も多く使用されたAPIとなり、昨年最も使用されたWeb Share APIを上回りました。

## Web Share API

[Web Share API](https://developer.mozilla.org/ja/docs/Web/API/Web_Share_API)は、デバイスのプラットフォーム固有の共有メカニズムを呼び出し、テキスト、URL、またはWebアプリケーションからのファイルなどのデータをメールクライアント、メッセージングアプリケーションなどの他のアプリケーションと共有できます。

データを共有するために呼び出されるメソッドは[`navigator.share()`](https://developer.mozilla.org/ja/docs/Web/API/Navigator/share)です。`navigator.share()`メソッドは共有するデータを含むオブジェクトを受け取り、Promiseを返します。ただし、共有できるファイルタイプは限られており、[`navigator.canShare()`](https://developer.mozilla.org/ja/docs/Web/API/Navigator/canShare)メソッドは、ブラウザがデータオブジェクトを共有できるかどうかをテストできます。MDNで[共有可能なファイルタイプのリスト](https://developer.mozilla.org/ja/docs/Web/API/Navigator/share#%E5%85%B1%E6%9C%89%E5%8F%AF%E8%83%BD%E3%81%AA%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%9E%8B)を見ることができます。

`navigator.share()`を呼び出した後、ブラウザはプラットフォーム固有のシートを開き、ユーザーがデータを共有するアプリケーションを選択します。

さらに、Web Share APIはユーザーのページとのインタラクション、例えばボタンのクリックなどによってのみトリガーでき、実行されたコードによって任意に呼び出すことはできません。

```js
const data = {
  url: "https://almanac.httparchive.org/en/2022/capabilities",
};

if (navigator.canShare(data)) {
  try {
    await navigator.share(data);
  catch (err) {
    console.error(err.name, err.message);
  }
}
```

Web Share APIは、現代のバージョンのChrome、Edge、およびSafariで利用可能です。ただし、ChromeではWindowsとChromeOSでのみサポートされています。

### Web Share APIの成長

{{ figure_markup(
  image="Web-Share-API-Usage.png",
  caption="2021年から2022年にかけてのデスクトップとモバイルでのWeb Share APIの使用状況。",
  description="デスクトップでのWeb Share APIの使用率は、2021年の9.00％から2022年には8.84％へと減少しました。モバイルでは、2021年の8.58％から2022年には8.36％へと減少しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=934956615&format=interactive",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
) }}

Web Share APIは、デスクトップで2021年の9.00%から2022年には8.84%へ、モバイルでは2021年の8.58%から2022年には8.36%へと使用率が減少しました。その結果、今年、Web Share APIはデスクトップとモバイルの両方で二番目に多く使用されたAPIとなり、昨年の二番目に多く使用された非同期クリップボードAPIに次ぐものとなりました。

多くのサイトでWeb Share APIが使用されています。例えば、ソーシャルメディアプラットフォーム、ドキュメントサイトなどがコンテンツを共有するための素晴らしい方法として使用しています。APIが使用されている例としては、[web.dev](https://web.dev/)や[twitter.com](https://twitter.com/)があります。

{{ figure_markup(
  gif="Web-Share-API.gif",
  image="Web-Share-API.webp",
  caption="Web Share APIを使用してTwitterプロフィールを共有する。",
  description="Web Share APIを使用してTwitterプロフィールを共有する。",
  width=640,
  height=360
) }}

## ホームスクリーンへの追加

昨年のCapabilitiesレポートでは取り上げなかった機能の一つに、デバイスのホームスクリーンにWebアプリケーションを追加する機能があります。どのサイトがこの機能を持っているかを計算するために、[`beforeinstallprompt`](https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeinstallprompt_event)イベントのリスナーがあるかどうかをテストしました。

`beforeinstallprompt`イベントはChromium専用のAPIであり、現在[WICG内でインキュベート中](https://wicg.github.io/manifest-incubations/index.html#installation-prompts)です。

`beforeinstallprompt`イベントは、ユーザーが「インストール」する前にトリガーされます。`beforeinstallprompt`イベントのイベントリスナーを使用することは、Webアプリをデバイスのホームスクリーンに追加するために必要ではありませんので、実際の使用率はもっと高いと考えられます。しかし、この方法論により、どれほど人気のある機能かを把握することができます。

ホームスクリーンにアプリケーションを追加する機能は、PWAの重要な特徴です。この機能を使用するには、Webアプリケーションが[以下の基準](https://web.dev/install-criteria/#criteria)を満たしている必要があります：

- Webアプリは既にインストールされていないこと。
- ユーザーはページを閲覧してから少なくとも30秒経過していること。
- ユーザーはページで少なくとも一度クリックまたはタップしていること。
- WebアプリはHTTPS経由で提供されること。
- Webアプリには[Webアプリマニフェスト](https://developer.mozilla.org/ja/docs/Web/Manifest)が含まれていること：
  - `short_name`または`name`。
  - `icons`（192×192pxおよび512×512pxのアイコンを含む必要があります）。
  - `start_url`。
  - `display`（`fullscreen`、`standalone`、または`minimal-ui`のいずれかである必要があります）。
  - `prefer_related_applications`（存在しないか、`false`である必要があります）。
- Webアプリは`fetch`ハンドラーを持つサービスワーカーを登録していること。

インストールされたアプリケーションは、スタートメニュー、デスクトップ、ホームスクリーン、アプリケーションフォルダー、デバイス上でのアプリケーションの検索、コンテンツ共有シートなどに表示されることがあります。

ホームスクリーンに追加する機能は、iOSおよびiPadOSのChrome、Edge、Safariの現代のバージョンでのみ利用可能です。

### ホームスクリーンへの追加の使用状況

{{ figure_markup(
  caption="モバイルでのホームスクリーンへの追加の使用率。",
  content="7.71%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

前述の通り、昨年はホームスクリーンへの追加機能は測定されていませんでした。しかし、後世と詳細な報告のために、`beforeinstallprompt`イベントはデスクトップページの8.56％、モバイルページの7.71％で使用されており、デスクトップとモバイルの両方で三番目に多く使用される機能となっています。

`beforeinstallprompt`イベントを活用することで、開発者はユーザーがWebアプリケーションをインストールする方法にカスタマイズされた体験を提供することができます。例としては、YouTube TVがそのアプリケーションをインストールすることで、より迅速かつ簡単にアクセスできるようにユーザーを招待するケースがあります。

{{ figure_markup(
  gif="Add-to-Home-Screen.gif",
  image="Add-to-Home-Screen.webp",
  caption="`beforeinstallprompt`イベントによって提供されるアプリ内プロンプトからYouTube TVをインストールする。",
  description="`beforeinstallprompt`イベントによって提供されるアプリ内プロンプトからYouTube TVをインストールする。",
  width=640,
  height=360
) }}

## メディアセッションAPI

[メディアセッションAPI](https://developer.mozilla.org/ja/docs/Web/API/Media_Session_API)を使用すると、開発者はWeb上のオーディオまたはビデオコンテンツのカスタムメディア通知を作成することができます。このAPIには、ブラウザがキーボード、ヘッドセット、およびデバイスの通知エリアやロック画面のソフトウェアコントロールにアクセスするために使用できるアクションハンドラが含まれています。メディアセッションAPIは、ユーザーがアクティブにページを閲覧していなくても、Webページで何が再生されているかを知り、制御することを可能にします。

ページがオーディオまたはビデオコンテンツを再生すると、ユーザーはモバイルデバイスの通知トレイまたはデスクトップのメディアハブにメディア通知が表示されます。ブラウザはタイトルとアイコンを表示しようとしますが、メディアセッションAPIを使用すると、タイトル、アーティスト名、アルバム名、アルバムアートワークなどの豊富なメディアメタデータを持つカスタマイズされた通知を提供することができます。

```js
navigator.mediaSession.metadata = new MediaMetadata({
  title: "Creep",
  artist: "Radiohead",
  album: "Pablo Honey",
  artwork: [
    {
      src: "https://via.placeholder.com/96",
      sizes: "96x96",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/128",
      sizes: "128x128",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/192",
      sizes: "192x192",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/256",
      sizes: "256x256",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/384",
      sizes: "384x384",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/512",
      sizes: "512x512",
      type: "image/png",
    },
  ],
});
```

メディアセッションAPIは、現代のバージョンのChrome、Edge、Firefox、およびSafariで利用可能です。

### メディアセッションAPIの使用状況

{{ figure_markup(
  caption="モバイルでのメディアセッションAPIの使用率。",
  content="7.41%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

メディアセッションAPIは昨年測定されていませんでした。追跡の初年度において、このAPIはデスクトップページの8.37％、モバイルページの7.41％で使用され、デスクトップとモバイルの両方で四番目に多く使用される機能となりました。

YouTube、YouTube Music、SpotifyなどのWebアプリケーションはメディアセッションAPIを活用し、再生されるビデオやオーディオのための豊富なコントロールを提供しています。

{{ figure_markup(
  image="Media-Session-API.png",
  caption="Windowsのタスクバーを通じてYouTube Musicのコントロールと情報にアクセスする。",
  description="Windowsのタスクバーを通じてYouTube Musicのコントロールと情報にアクセスする。",
) }}

Web上のビデオ使用についてさらに詳しく知りたい場合は、[メディア](./media#ビデオ)章をご覧ください。

## デバイスメモリAPI

デバイスの性能は、ネットワーク、CPUコア数、利用可能なメモリ量など、いくつかの要素に依存します。[デバイスメモリAPI](https://developer.mozilla.org/ja/docs/Web/API/Device_Memory_API)は、`Navigator`インターフェース上の読み取り専用プロパティ`deviceMemory`を提供することで、利用可能なメモリについての情報を提供します。このプロパティは、浮動小数点数としてデバイスのメモリ量をギガバイト単位でおおよそ返します。

返される値は、ユーザーのプライバシーを保護するために不正確です。値は2のべき乗に切り捨てられた後、その数を1,024で割って計算されます。また、数値は上下限の範囲内で調整されています。したがって、`0.25`、`0.5`、`1`、`2`、`4`、`8`（ギガバイト）の数値が予想されます。

```js
const memory = navigator.deviceMemory;
console.log('This device has at least ', memory, 'GiB of RAM.');
```

デバイスメモリAPIは、現代のバージョンのChromeとEdgeでのみ利用可能です。

### デバイスメモリAPIの使用状況

{{ figure_markup(
  caption="モバイルでのデバイスメモリAPIの使用率。",
  content="5.76%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

デバイスメモリAPIは昨年は測定されていませんでした。追跡の初年度において、このAPIはデスクトップページの6.27％、モバイルページの5.76％で使用され、デスクトップとモバイルの両方で五番目に多く使用される機能となりました。

2019年のFacebookのリデザインリリース、FB5では、実際のハードウェアに基づいてロード内容を調整することで、アダプティブローディングを積極的に統合しました。例えば、デスクトップでは、利用可能なCPUコア（[`navigator.hardwareConcurrency`](https://developer.mozilla.org/ja/docs/Web/API/Navigator/hardwareConcurrency)）とデバイスメモリ（`navigator.deviceMemory`）に基づいてユーザーのバケットを定義しました。

Chrome Dev Summit 2019の[このビデオ](https://www.youtube.com/watch?v=puUPpVrIRkc&t=1443s)を24:03からご覧ください。Nate SchlossがデバイスメモリAPIなどの機能を使用してFacebookがアダプティブローディングをどのように取り扱っているかを共有しています。

## サービスワーカーAPI

[サービスワーカー](https://developer.mozilla.org/ja/docs/Web/API/Service_Worker_API)はプログレッシブウェブアプリの核心的なコンポーネントの一つです。サービスワーカーはクライアント側のプロキシとして機能し、開発者がシステムのキャッシュやリソース要求への応答方法を制御できるようにします。重要なリソースを事前にキャッシュすることで、ネットワークへの依存を排除し、即時かつ信頼性の高い体験を保証できます。

リソースをキャッシュすることに加えて、サービスワーカーはサーバーからアセットを更新したり、プッシュ通知を可能にしたり、バックグラウンド及び周期的なバックグラウンド同期APIへのアクセスを許可することができます。

サービスワーカーは主要なブラウザに広く採用されていますが、サービスワーカーの全ての機能がすべてのブラウザで利用可能なわけではありません。現在サポートされていない機能の一例としては、SafariのPush APIがあります。Safariは2022年の[macOS Ventura](https://www.apple.com/macos/macos-ventura-preview/features/)および2023年の[iOS 16](https://www.apple.com/ios/ios-16/features/)とiPadOS 16でPush APIをサポートする予定です。

サービスワーカーAPIは、現代のバージョンのChrome、Edge、Firefox、およびSafariで利用可能です。

### サービスワーカーAPIの成長

{{ figure_markup(
  image="Service-Worker-API-Usage.png",
  caption="2021年から2022年にかけてのデスクトップとモバイルでのサービスワーカーAPIの使用状況。",
  description="デスクトップでのサービスワーカーAPIの使用率は、2021年の3.05％から2022年には4.17％へと増加しました。モバイルでは、2021年の3.22％から2022年には3.85％へと増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=304563360&format=interactive",
  sheets_gid="208641216",
  sql_file="fugu.sql"
) }}

昨年のCapabilities章ではサービスワーカーAPIは測定されていませんでしたが、[昨年のPWA章のデータ](/ja/2021/pwa#サービスワーカーの利用状況)を使用して、APIの使用はデスクトップで3.05％から4.17％へ、モバイルページで3.22％から3.85％へと増加し、デスクトップで六番目に、モバイルで七番目に多く使用される機能となりました。

PWA章でのサービスワーカーの使用測定方法はCapabilities章での測定方法と異なります。また、昨年のPWA章のデータパイプラインにバグが見つかり、サービスワーカーの使用が少なく見積もられていたことがあります。

Web上でのサービスワーカーの使用についてさらに深く掘り下げるには、2022年のWeb Almanacの[PWA章](/ja/2022/pwa#サービスワーカー)をご覧ください。

## ゲームパッドAPI

[_ゲームパッドAPI_](https://developer.mozilla.org/ja/docs/Web/API/Gamepad_API)は、Webアプリケーションがゲームパッドやその他のゲームコントローラーからの入力にどのように対応するかを定義しています。このAPIには3つのインターフェースがあります。1つはデバイスに接続されたコントローラーを表し、もう1つは接続されたコントローラーのボタンを表し、最後にゲームパッドが接続または切断されたときに発火されるイベント用のものです。

```js
window.addEventListener("gamepadconnected", (e) => {
  const gp = navigator.getGamepads()[e.gamepad.index];
  console.log(`Controller connected at index ${gp.index}`);
});
```

ゲームパッドAPIは、現代のバージョンのChrome、Edge、Firefox、およびSafariで利用可能です。

### ゲームパッドAPIの成長

{{ figure_markup(
  image="Gamepad-API-Usage.png",
  caption="2021年から2022年にかけてのデスクトップとモバイルでのゲームパッドAPIの使用状況。",
  description="デスクトップでのゲームパッドAPIの使用率は、2021年の4.39％から2022年には4.12％へと減少しました。モバイルでは、2021年の5.10％から2022年には4.65％へと減少しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=679096832&format=interactive",
  sheets_gid="1737472884",
  sql_file="fugu.sql"
) }}

ゲームパッドAPIの使用は、デスクトップで2021年の4.39％から2022年には4.12％へと減少しました。モバイルでは、2021年の5.10％から2022年には4.65％へと減少しました。その結果、今年ゲームパッドAPIはデスクトップで七番目に、モバイルで六番目に多く使用される機能となりました。

GoogleのStadia、NVIDIAのGeForce Now、MicrosoftのXbox Cloud GamingなどのWebアプリケーションは、クラウド上でローカルデバイスやゲームコンソールでゲームを実行する体験と同等のゲーム体験を提供します。ゲームパッドAPIのおかげで、これらのWebアプリケーションはユーザーにキーボードとマウスだけでなく、従来のコンソールゲームコントローラーを使用することを可能にします。

{{ figure_markup(
  image="Gamepad-API.webp",
  gif="Gamepad-API.gif",
  caption="ChromeブラウザでGoogle StadiaにXboxコントローラーを接続する。",
  description="ChromeブラウザでGoogle StadiaにXboxコントローラーを接続する。",
  width=640,
  height=360
) }}

## プッシュAPI

[_プッシュAPI_](https://developer.mozilla.org/ja/docs/Web/API/Push_API) を使用すると、アプリケーションがフォアグラウンドにない場合でも、Webアプリケーションがサーバーからメッセージを受信できます。開発者は非同期通知や更新をユーザーに送信でき、意味のある更新を提供し、アプリケーションとの再エンゲージメントを促すことができます。

プッシュ通知をサーバーから受信するためには、Webアプリケーションにサービスワーカーが必要です。サービスワーカー内から、[`PushManager.subscribe()`](https://developer.mozilla.org/ja/docs/Web/API/PushManager/subscribe)メソッドを使用してプッシュ通知を購読することができます。

プッシュAPIは、現代のバージョンのChrome、Edge、およびFirefoxで利用可能です。

### プッシュAPIの使用状況

{{ figure_markup(
  caption="モバイルでのプッシュAPIの使用率。",
  content="1.86%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

プッシュAPIは昨年測定されていませんでした。追跡の初年度において、このAPIはデスクトップページの2.03％、モバイルページの1.86％で使用され、デスクトップとモバイルの両方で八番目に多く使用される機能となりました。

## プロジェクトフグ

多くのユーザーがプラットフォーム固有のアプリケーションに属していると期待する機能は、Web上にも存在します。しかし、Capabilities Project（多くの人々にプロジェクトフグとして知られている）のおかげで、これらの機能はWeb上に存在しています。プロジェクトフグは、iOS、Android、またはデスクトップアプリができることを考慮して、Webアプリケーションに機能の同等性をもたらすための企業間の取り組みです。プロジェクトフグは、ユーザーのセキュリティ、プライバシー、信頼、およびWebの他の核心的な原則を維持しながら、プラットフォーム固有の機能をWebに公開する作業に取り組んでいます。

プロジェクトフグには、Microsoft、Intel、Samsung、Googleなど多くのグループや個人が参加しています。

Capabilities Projectについてもっと学ぶために、Chrome Developersブログの[この投稿](https://developer.chrome.com/blog/fugu-status)をチェックしてください。

## 結論

Capabilitiesは、Web上で開発者が活用できる新しい可能性と機能を解き放ちます。この章では、現在Web上で使用されている最も人気のあるWebプラットフォームAPIの8つを共有しました。また、異なるWebアプリケーションで使用されているいくつかの機能も紹介しました。Webの美しさは、デバイスにインストールする必要がなく、追加のライブラリやプラグインも必要ないということです。

Webの機能を活用するエキサイティングな体験には、[What Web Can Do Today?](https://whatwebcando.today/)（WWCDT）や[Discourse](https://www.discourse.org/)があります。WWCDTは、追跡している機能の38を使用し、各APIのライブデモを示して多くのWeb APIを紹介しています。Discourseは、コミュニティにWebフォーラムを提供し、追跡している機能の14を使用しています。たとえば、Badging APIを使用すると、ユーザーは未読通知の数を確認できます。

プロジェクトフグ、Capabilities Projectにより、アプリケーションはWebに移行し、プラットフォーム固有のアプリケーションに関連するいくつかの障壁を取り除くことができます。ネイティブコードを書く必要がなく、ユーザーが最新の更新にアクセスしているかを心配する必要がなく、ユーザーにアプリストアで検索してダウンロードするよう促す必要もありません。Webとその機能は、ユーザーに魅力的な体験を提供するための新たな可能性を開きます。
