---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: ケイパビリティ
description: 2021年版Web Almanacの「ケイパビリティ」の章では、Webアプリケーションにハードウェアインタフェースへのアクセスを提供し、Webベースの生産性アプリケーションを強化する、全く新しい強力なWebプラットフォームAPIをカバーしています。
hero_alt: Hero image of Web Almanac characters with superhero capes plugging various capabilities into a web page.
authors: [christianliebel]
reviewers: [tomayac, hemanth]
analysts: [tomayac]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/
christianliebel_bio: Christian Liebel は、<a hreflang="en" href="https://thinktecture.com">Thinktecture</a> のコンサルタントで、さまざまなビジネス分野のクライアントが優れた Web アプリケーションを実装できるように支援しています。Microsoft MVPのデベロッパー技術部門、Google GDEのWeb/ケイパビリティとAngularが取得しており、W3C Webアプリケーションワーキンググループに参加しています。
featured_quote: ケイパビリティは、Webアプリケーションの全く新しいユースケースを解放する新しいWebプラットフォームAPIです。
featured_stat_1: 9%
featured_stat_label_1: _WebシェアAPI_を使用したデスクトップWebサイト
featured_stat_2: 8.25%
featured_stat_label_2: _非同期クリップボードAPI_を利用したモバイルサイト
featured_stat_3: 11
featured_stat_label_3: _宣言型リンクキャプチャ_を使用したモバイルサイト
---

## 序章
ケイパビリティは、Webアプリケーションのまったく新しいユースケースを解放する新しいWebプラットフォームAPIです。それらの新しいAPIは、Webベースのアプリケーションモデルである[プログレッシブ・ウェブ・アプリケーション(PWA)](./pwa)に不可欠なものです。PWAとは、ユーザーが自分のシステムにインストールできるWebアプリのことです。PWAはオフラインでも動作し、素早く起動する。基本的なオペレーティングシステムと統合するために、PWAはウェブプラットフォームAPIのみを使用できます。ブラウザはすでにいくつかの低レベルの機能をウェブに公開していますが（たとえば、[geolocation](https://developer.mozilla.org/docs/Web/API/Geolocation_API), [gamepad](https://developer.mozilla.org/docs/Web/API/Gamepad_API), または [webcam](https://developer.mozilla.org/docs/Web/API/MediaDevices/getUserMedia)アクセス）、多くのAPIはまだ欠けていたり使い勝手が悪かったり（たとえば、ファイルシステムやクリップボードへのアクセスを）していました。

### プロジェクト・フグ

<a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">ケイパビリティ・プロジェクト</a>（コードネームフグ）は、Microsoft、Intel、Google、およびその他のChromium貢献者による共同作業です。これは、新しい強力なWebプラットフォームAPIを安全かつプライバシーを保護する方法で設計・実装することにより、プラットフォーム固有のアプリケーションとWebアプリケーションの間のギャップを埋めようとしています（[プライバシー](./privacy)の章もご覧ください）。機能がより多くのユースケースを解放するにつれて、最終的にWebへの移行を行うための新しいアプリケーションカテゴリ全体への道を開きます（例：IDE、画像エディター、オフィスアプリケーションなど）。

<figure>
<blockquote>_プロジェクト・フグ_は、Webの機能のギャップを埋め、新しいクラスのアプリケーションをWeb上で実行できるようにする取り組みです。プロジェクト・フグが提供するAPIは、セキュリティ、低摩擦、クロスプラットフォーム配信というWebの中核的な利点を維持しながら、Web上での新しい体験を可能にします。Project Fugu API の提案はすべてオープンで標準化されたトラックで行われます。</blockquote>
<figcaption>— <cite><a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">Webケイパビリティチーム</a></cite></figcaption>
</figure>

この2年間、フグチームは、デスクトップ生産性アプリケーションのための機能とハードウェア関連のAPIに焦点を合わせてきました。この章では、いくつかの新しい機能を簡単に紹介し、デスクトップとモバイルのさまざまなウェブサイトがそれらをどの程度使用しているかを分析します。ケイパビリティは、アプリのようなウェブサイトにとってとくに興味深いものであるため、その相対的な使用率は比較的低くなっています。このため、この章ではウェブサイトの絶対数が使用されています。各ケイパビリティには、それを利用するデモ用のWebサイトやアプリが用意されています。

### 方法論

この章では、HTTP Archiveのデータセットを使用します。セキュリティ上の理由から、一部のAPIは機能するためにユーザーのジェスチャー（クリックやキープレスなど）を必要とします。HTTP Archiveのクローラーは、実行時にそれらのAPIを検出することをサポートしていないため、代わりにウェブサイトのソースコードを静的に解析しています。たとえば、正規表現 `/navigator\.share\s*\(/g` をウェブサイトのソースコードにマッチさせ、_Web Share API_ を使用しているかどうかを判断します。

この方法は、APIの実際の使用状況を測定していないため、完全に正確というわけではありません。開発者は、異なる構文を使用してAPIを呼び出したり、簡略化したコードで作業したりする可能性があるからです。しかし、この方法で十分な概観を得ることができるはずです。この<a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/fugu-apis.js">ソースファイル</a>には、サポートされる30の機能の正確な正規表現が記載されています。

本章の使用データはすべて2021年7月のクロールを基準としています。生データは<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/">能力2021結果シート</a>に掲載されています。

本章でよりよく使われる2つのAPIについては、Chrome Platform Statusの追加データを紹介します。このデータは、本章の出版前の過去12か月間でAPIの使用状況がどのように変化したかを示しています。

### 提供するAPIの状況

ここで紹介するAPIのほとんどは、いわゆる_インキュベーション_であることに注意してください。とくに断りのない限り、それらは（まだ）W3C勧告、すなわち公式のWeb標準ではありません。その代わり、これらのAPIは、ブラウザベンダーと開発者が新機能について議論できるウェブプラットフォームインキュベータ コミュニティグループ（WICG）で作業されています。

すでにいくつかのブラウザで出荷されているAPIもあれば、Chromiumベースのものでしか利用できないAPIもあります。これらのブラウザには、Google Chrome、Microsoft Edge、Opera、Brave、またはSamsung Internetが含まれます。Chromiumベースのブラウザのベンダーは、特定の機能を無効にすることができるため、ChromiumベースのすべてのブラウザですべてのAPIが使用できるとは限らないことに注意してください。また、一部の機能は、ブラウザの設定でフラグを有効にしたあとでのみ利用できる場合があります。

## 非同期クリップボードAPI
[_非同期クリップボードAPI_](https://developer.mozilla.org/docs/Web/API/Clipboard_API)を使用すると、クリップボードからのデータの読み取りやクリップボードへのデータの書き込みを行うことができます。非同期のため、UIをブロックすることなく、画像を縮小しながら貼り付けるような使い方が可能です。これまでクリップボードの操作に使われていた `document.execCommand()` のような性能の低いAPIを置き換えることができます。

### 書き込みアクセス
非同期クリップボードAPIは、データをクリップボードにコピーするための2つのメソッドを提供します。省略記法の [`writeText()`](https://developer.mozilla.org/docs/Web/API/Clipboard/writeText) はプレーンテキストを引数にとり、ブラウザはそれをクリップボードにコピーします。[`write()`](https://developer.mozilla.org/docs/Web/API/Clipboard/write) メソッドは、任意のデータを含むことができるクリップボード項目の配列を受け取ります。ブラウザは、特定のデータ形式のみを実装することを決めることができます。Clipboard API仕様は、プレーンテキスト、HTML、URIリスト、PNG画像など、ブラウザが最低限サポートしなければならない必須データ型の <a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#mandatory-data-types-x"> リストを指定しています</a>。

```js
await navigator.clipboard.writeText('hello world');

const blob = new Blob(['hello world'], { type: 'text/plain' });
await navigator.clipboard.write([
  new ClipboardItem({
    [blob.type]: blob,
  }),
]);
```

### 読み取りアクセス
クリップボードにデータをコピーするのと同様に、クリップボードからデータを貼り付けて戻すには2つの方法があります。まず、クリップボードからプレーンテキストを返す [`readText()`](https://developer.mozilla.org/docs/Web/API/Clipboard/readText) という別のショートハンドメソッドを紹介します。[`read()`](https://developer.mozilla.org/docs/Web/API/Clipboard/read) メソッドを用いると、ブラウザがサポートするデータ形式でクリップボード内のすべてのアイテムにアクセスできます。

```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

ブラウザは、ウェブサイトがクリップボードの内容にアクセスすることを許可する前に、プライバシー上の理由から許可プロンプトを表示したり、別のUIを表示したりすることがあります。非同期クリップボードAPIは、Chrome、Edge、Safariで利用できます（<a hreflang="en" href="https://caniuse.com/async-clipboard">current browser support for the Async Clipboard API</a>）。Firefoxは `writeText()` メソッドのみをサポートしています。

{{ figure_markup(
caption="Async Clipboard APIを使用したデスクトップWebサイト。",
content="560,359",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

デスクトップ560,359（8.91%）、モバイル618,062（8.25%）のサイトにおいて、Async Clipboard API (`writeText()` method) はもっとも使われているフグAPIの1つです。`write()`メソッドは、デスクトップ1,180サイト、モバイル1,227サイトで使用されています。例として、商用サイト<a hreflang="en" href="https://clippingmagic.com/">Clipping Magic</a>では、AIアルゴリズムの助けを借りて画像の背景を除去できます。クリップボードから画像を貼り付けるだけで、ウェブサイトがその背景を削除してくれます。

このAPIの使用率が高いのは、おそらくYouTubeの埋め込み動画に含まれるスクリプトが関係していると思われます。ビデオプレーヤーでユーザーが "copy link" ボタンをクリックすると、`writeText()` メソッドが呼び出されます。

{{ figure_markup(
image="async-clipboard-api.jpg",
caption='クリッピングマジックは、非同期クリップボードAPIで貼り付けられた画像の背景を人工知能で除去するものです。',
description='クリッピングマジックの画面。左側が画像、右側が背景のない同じ画像。',
width=699,
height=440
) }}

ここ数ヶ月、APIの利用が低水準で急激に増加しています。2020年11月には、`read()`メソッドは全ページロードの0.00032%しかアクティブになっていなかったが、2021年10月には0.002921%まで使用率が指数関数的に増加した。`write()` メソッドは、同期間に0.000674から0.001601パーセントに増加しました。

{{ figure_markup(
image="async-clipboard-api-page-loads.png",
caption='ChromeでAsync Clipboard APIを使用してページを読み込む割合。<br>（提供元：<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2369">非同期クリップボード読み込み</a>、<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2370">非同期クリップボード書き込み</a>）',
description="非同期クリップボードAPIの利用状況を、Chromeのページロードのうちこの機能を利用している割合で示したグラフです。readとwriteの使用率を比較しており、2021年の間にreadは指数関数的に増加し、writeは直線的に増加していることがわかる。2021年10月、Chromeの全ページロードの0.0029%でreadが、0.0016%でwriteが呼び出されています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5Byx-_990HdH35no6J879Vk-wNe6EJGHfJJEP61RuLYHyVJfRU0X0L96-kpFAEmWt7x4pB9aiMfQr/pubchart?oid=1933317785&format=interactive",
sheets_gid="1382342903"
)
}}

## ファイルシステムアクセスAPI
次に生産性関連のAPIとして、[_ファイルシステムアクセスAPI_](https://developer.mozilla.org/docs/Web/API/File_System_Access_API)を紹介します。Webアプリは、<a hreflang="en" href="https://web.dev/browser-fs-access/#the-traditional-way-of-dealing-with-files">すでにファイルを扱うことができました</a>。`<input type="file">` では、ユーザーはファイルピッカーを使って1つまたは複数のファイルを開くことができます。また、`<a download>` により、ダウンロードフォルダーにファイルを保存できます。File System Access APIは、さらなるユースケースをサポートする。ディレクトリを開いたり、変更したり、ユーザーが指定した場所にファイルを保存したり、ユーザーが開いたファイルを上書きしたりします。また、`IndexedDB` にファイルハンドルを持続させて、ページを再読み込みしたあとでも（パーミッション制限された）アクセスを継続できるようにすることも可能です。とくに、APIはファイルシステムへのランダムアクセスを許可しておらず、特定のシステムフォルダーはデフォルトでブロックされている。

### 書き込みアクセス
グローバルな `window` オブジェクトに対して [`showSaveFilePicker()`](https://developer.mozilla.org/docs/Web/API/Window/showSaveFilePicker) メソッドを呼び出すと、ブラウザはオペレーティングシステムのファイルピッカーを表示するようになります。このメソッドはオプションのオプションオブジェクトを受け取り、保存を許可するファイルタイプ (`types`, default: all types) と、ユーザーが "accept all" オプションでこのフィルターを無効にできるかどうか (`excludeAcceptAllOption`, default: `false`) を指定できます。

ユーザーがローカルファイルシステムからファイルを正常に選択すると、そのハンドルを受け取ることができます。そのハンドルに対して `createWritable()` メソッドを実行すると、ストリームライターにアクセスできます。以下の例では、このライターはテキスト `hello world` をファイルに書き込み、その後ファイルを閉じます。

```js
const handle = await window.showSaveFilePicker({
  types: [{
    description: 'PNG files',
    accept: { 'image/png': ['.png'] }
  }],
  excludeAcceptAllOption: true
});
const writable = await handle.createWritable();
await writable.write('hello world');
await writable.close();
```

### アクセスを読み取る
オープンファイルピッカーを表示するには、グローバルな `window` オブジェクトの [`showOpenFilePicker()`](https://developer.mozilla.org/docs/Web/API/Window/showOpenFilePicker)メソッドを呼び出してください。このメソッドには、オプションのオプションオブジェクトも渡されます。このオブジェクトには、上記と同じプロパティ (`types`, `excludeAcceptAllOption`) が設定されます。さらに、ユーザーが1つのファイルを選択するか、複数のファイルを選択するか (`multiple`, default: `false`) を指定できます。

ユーザーは複数のファイルを選択する可能性があるため、ファイルハンドルの配列を受け取ります。配列の再構築式 `[handle]` を用いると、最初に選択されたファイルのハンドルが配列の最初の要素として受け取られます。ファイルハンドルに対して `getFile()` メソッドを呼び出すと、`File` オブジェクトが得られ、ファイルのバイナリデータへアクセスできるようになります。`text()` メソッドを呼び出すと、オープンされたファイルからプレーンテキストを受け取ることができます。

```js
const [handle] = await window.showOpenFilePicker({
  multiple: false
});
const blob = await handle.getFile();
const text = await blob.text();
console.log(text);
```

### ディレクトリーを開く
最後に、このAPIでは、ウェブアプリ（統合開発環境など）がディレクトリ全体のハンドルを取得できます。このハンドルを使って、開いたディレクトリ内で既存のファイルやフォルダーを作成、更新、削除できます。今回のメソッドは [`showDirectoryPicker()`](https://developer.mozilla.org/docs/Web/API/window/showDirectoryPicker) という名前になっています。

```js
const handle = await window.showDirectoryPicker();
```

ファイルシステムアクセスAPIは、Chromiumベースのブラウザとデスクトップシステムでのみ利用可能です（<a hreflang="en" href="https://caniuse.com/native-filesystem-api">ファイルシステムアクセスAPIの現在のブラウザサポート</a>）。幸いなことに、ウェブプラットフォームは、モバイルデバイスや他のブラウザーでも同様の機能を提供するために、前述のフォールバックアプローチを提供しています。開発者はGoogleが開発したライブラリ <a hreflang="en" href="https://github.com/GoogleChromeLabs/browser-fs-access">browser-fs-access</a> を使うことができます。このライブラリはファイルシステムアクセスAPIがあればそれを使い、なければ別の実装にフォールバックします。

{{ figure_markup(
caption="ファイルシステムアクセスAPIを使用したデスクトップWebサイト。",
content="29",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

HTTP Archiveに登録されているデスクトップ向け6,286,373サイト、モバイル向け7,491,840サイトのうち、ファイルシステムアクセスAPIが使用されているのはデスクトップ向け29サイト、モバイル向け23サイトです。それらのサイトの例としては、手描き風の図をスケッチしてディスクに保存できる画像エディター<a hreflang="en" href="https://excalidraw.com/">エクスカリッドロー</a>があります。また、画像編集ソフトCorelDRAWのWeb版である<a hreflang="en" href="https://coreldraw.app/">CorelDRAW.app</a>もその一例です。

{{ figure_markup(
image="file-system-access-api.jpg",
caption='Excalidraw PWAは、ファイルシステムアクセスAPIを使用して、内蔵の保存ダイアログからローカルファイルシステムに画像を保存します。',
description='Excalidrawドローイングアプリケーションとファイル保存ダイアログを開いた画面。',
width=656,
height=409
) }}

## WebシェアAPI
[_WebシェアAPI_](https://developer.mozilla.org/docs/Web/API/Navigator/share)を使用すると、WebサイトやWebアプリケーションのテキスト、URL、ファイルを、メールクライアントやメッセンジャーなど、他のアプリケーションと共有できます。そのためには、[`navigator.share()`](https://developer.mozilla.org/docs/Web/API/Navigator/share)メソッドを呼び出してください。他のアプリケーションと共有するためのデータをオブジェクトとして取得します。ブラウザは内蔵の共有シートを開き、ユーザーはそこからターゲットアプリケーションを選択できます。このメソッドは、コンテンツが正常に共有された場合に解決するプロミスを返し、そうでない場合は拒否されます。

```js
await navigator.share({
  files: picturesArray,
  title: 'Holiday pictures',
  text: 'Our holiday in the French Alps'
})
```

WebシェアAPIは、iOSおよびmacOSのSafari、WindowsおよびChrome OSのChromeおよびEdgeでサポートされています（<a hreflang="en" href="https://caniuse.com/web-share">現在のWeb Share API対応ブラウザ</a>）。現在、Webアプリケーションワーキンググループで <a hreflang="en" href="https://www.w3.org/TR/web-share/">草案</a> が作成されています。これは、W3C勧告になるための軌道の最初の段階の1つです。

{{ figure_markup(
caption="Web Share APIを利用したデスクトップWebサイト。",
content="566,049",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

デスクトップ566,049サイト（9.00%）、モバイル642,507サイト（8.58%）で、WebシェアAPIはもっとも利用されているフグのAPIです。たとえば、<a hreflang="en" href="https://beta.paintz.app/">PaintZアプリのベータ版</a>では、保存ダイアログを通じて、ローカルにインストールされている別のアプリケーションと図面を共有できます。

このAPIの使用率が高いのは、YouTubeの埋め込み動画に含まれるスクリプトが関係していると思われる。デバイス上でWebシェアAPIが利用可能な場合、ユーザーが動画プレーヤーの「Share」ボタンをクリックすると、このAPIが実行されます。

{{ figure_markup(
image="web-share-api.jpg",
caption='PaintZのベータ版では、WebシェアAPIを使用してローカルアプリケーションとドローイングを共有しています。',
description='ドローイングアプリケーションPaintZの画面と、アプリからドローイングを受け取った内蔵メッセージングアプリケーションをオーバーレイ表示したもの。',
width=676,
height=419
) }}

ここ数カ月、WebシェアAPIの利用が全体的に増えています。Chrome Platform Statusのデータでは、2020年11月に全ページロードの0.0097%でAPIが呼び出されてから、2021年10月には0.0136%まで、かなり直線的に伸びていることがわかります。

{{ figure_markup(
image="web-share-api-page-loads.png",
caption='WebシェアAPIを使用したChromeのページロードの割合。（<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/1501">提供元</a>）',
description="WebシェアAPIの利用状況を、Chromeのページロードにこの機能が使われている割合で示したグラフ。2020年11月から2021年10月にかけて、かなり直線的に伸びていることがわかる。2020年11月には全ページロードの0.0097%で、2021年10月には全ページロードの0.0136%でAPIが呼び出された。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5Byx-_990HdH35no6J879Vk-wNe6EJGHfJJEP61RuLYHyVJfRU0X0L96-kpFAEmWt7x4pB9aiMfQr/pubchart?oid=2113981194&format=interactive",
sheets_gid="1372715282"
)
}}

## URLハンドラーと宣言型リンクキャプチャ
この章で説明する生産性に関連する最後の2つの機能は、_URLハンドラー_と_宣言型リンクキャプチャ_で、オペレーティングシステムとさらに深く統合するための追加メソッドです。

### URLの取り扱い
<a hreflang="en" href="https://web.dev/pwa-url-handler/">URLハンドラー</a> の助けを借りて、PWAはインストール時に特定のURLスキームに対するハンドラーとして自身を登録できます。たとえば `https://*.example.com` のハンドラーとして登録できます。ユーザーがこのスキームに一致するURLを開くと、新しいブラウザタブではなく、インストールされたPWAが開きます。URLハンドリングは、<a hreflang="en" href="https://www.w3.org/TR/appmanifest/">_Webアプリケーションマニフェスト_</a>という[Webアプリケーションのメタデータ](https://developer.mozilla.org/docs/Web/Manifest)を含むファイルを拡張したものです。URLスキームに登録するには、マニフェストに `url_handlers` プロパティを追加する必要があります。このプロパティは `origin` プロパティを持つオブジェクトを含む配列を取ります。

```json
{
  "url_handlers": [{
    "origin": "https://*.example.com"
  }]
}
```

ウェブアプリのオリジン以外のオリジンを登録したい場合は、<a hreflang="en" href="https://web.dev/pwa-url-handler/#the-web-app-origin-association-file">所有権を確認する</a>必要があります。この機能は比較的初期の段階にあり、デスクトップのChromeとEdgeにのみ対応しています。URLハンドリングは現在、<a hreflang="en" href="https://developer.chrome.com/blog/origin-trials">オリジン・トライアル</a>として提供されています。つまり、この機能はまだ一般的に利用できるものではありません。その代わり、開発者はこの実験的なAPIを使うために、まずOrigin Trialトークンに登録し、このトークンをウェブサイトと一緒に配信して、この機能を使うことを選択する必要があります。詳細は、<a hreflang="en" href="https://github.com/GoogleChrome/OriginTrials/blob/gh-pages/developer-guide.md">Web開発者向けOriginトライアルガイド</a> に掲載されています。

{{ figure_markup(
caption="デスクトップのWebサイトでは、URLハンドリングを使用しています。",
content="44",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

デスクトップ44サイト、モバイル41サイトがURLハンドリングを利用しています。たとえば、Pinterest PWAはインストール時にPinterestの異なるオリジン（例：`*.pinterest.com`と`*.pinterest.de`）のURLハンドラーとして自身を登録する。

### 宣言型リンクキャプチャ
<a hreflang="en" href="https://web.dev/declarative-link-capturing/">宣言型リンクキャプチャ</a> の助けを借りて、ユーザーがPWAを開いたときの動作をさらに制御できます。たとえば、オフィス系アプリケーションでは、新しい文書を作成するために別のウィンドウを開きたいが、音楽プレーヤーでは1つのウィンドウを開いたままにしておきたい。そこで、宣言型リンクキャプチャでは、3種類のモードを定義しています。

1. `none` はリンクをまったくキャプチャしません（デフォルト）
2. `new-client` はPWAの新しいウィンドウを開きます。
3. `existing-client-navigate` は既存のクライアントを新しいURLに移動させるか、クライアントが存在しない場合は新しいウィンドウを開きます。

宣言型リンクキャプチャもWebアプリケーションマニフェストの拡張機能です。これを使用するには、マニフェストに `capture_links` プロパティを追加する必要があります。このプロパティは、上記の3つのモードに一致する文字列または文字列の配列を取ります。配列を使用する場合、ブラウザが特定のモードをサポートしない場合は、次のエントリにフォールバックします。

```json
{
  "capture_links": [
    "existing-client-navigate",
    "new-client",
    "none"
  ]
}
```

{{ figure_markup(
caption="デスクトップ型Webサイトでは、宣言型リンクキャプチャを使用しています。",
content="36",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

このケイパビリティも初期段階です。Chrome OSのみの対応となります。現在、デスクトップ36サイト、モバイル11サイトがこの機能を利用しており、たとえば、元素の周期表を表示するPWAである<a hreflang="en" href="https://periodex.co/">Periodex</a>は、その例です。このアプリでは、上のリストにあるように `capture_links` という設定を使っています。つまり、サポートされていればブラウザは既存のウィンドウを再利用し、そうでなければ新しいウィンドウを開き、サポートされていなければ通常通りに動作します。

## ハードウェアAPI
次のケイパビリティは、ハードウェア関連のAPIに焦点を当てたものです。Chromiumベースのブラウザでは、USB、ブルートゥース、シリアルデバイスなど、ハードウェアインターフェイスにアクセスするためのAPIが多数用意されています。さらに、汎用センサーAPIを使えば、デバイスのセンサーから読み取ることができます。このセクションで説明するすべての機能は、Chromiumベースのブラウザと、それぞれのハードウェアインタフェースまたはセンサーが存在するシステムでのみ利用可能です。

### Web USB API
<a hreflang="en" href="https://web.dev/usb/">_Web USB API_</a> により、開発者はドライバーやサードパーティのアプリケーションを使用せずにUSBデバイスへアクセスできます。たとえば、ファームウェアのアップデートを行う場合、開発者はそれぞれのプラットフォームに特化したアプリとして実装しなければならないが、この機能は興味深い。USBデバイスにアクセスするには、`navigator.usb.requestDevice()` メソッドを呼び出す必要があります。接続されているすべてのUSBデバイスのリストに対するフィルターを定義するオブジェクトを受け取ります。少なくとも `vendorId` を指定する必要があります。ブラウザにはデバイスピッカーが表示され、ユーザがマッチするデバイスを選択できます。そこから、デバイスセッションを開始できます。

```js
try {
  const device = await navigator.usb.requestDevice({
    filters: [{ vendorId: 0x8086 }]
  });
  console.log(device.productName);
  console.log(device.manufacturerName);
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
caption="デスクトップ用Webサイトでは、Web USBを使用します。",
content="182",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

このAPIは、Chromiumベースのブラウザーではバージョン61から一般で利用できるようになっています (<a hreflang="en" href="https://caniuse.com/webusb">Web USB APIをサポートする現在のブラウザ</a>)。182のデスクトップと155のモバイルサイトがこのAPIを使用しており、たとえば、AndroidやiOSデバイスの画面をミラーリングできるPWA <a hreflang="en" href="https://app.vysor.io/#/">Vysor</a> は、すべてコンピューターに追加のソフトウェアをインストールせずに使用できます。

{{ figure_markup(
image="web-usb.jpg",
caption='Vysor PWAは、Web USBを利用してUSB機器と接続し、その画面の内容をデスクトップに投影できます。',
description='VysorのWebアプリケーションで、接続されているUSB機器の一覧を表示するモーダルダイアログを開いた画面です。',
width=699,
height=440
) }}

### WebブルートゥースAPI
<a hreflang="ja" href="https://web.dev/i18n/ja/bluetooth/">_WebブルートゥースAPI_</a>を使用すると、<a hreflang="en" href="https://www.bluetooth.com/bluetooth-resources/intro-to-bluetooth-gap-gatt/">一般属性プロファイル (GATT)</a>を使用して近くのブルートゥース・ローエナジーデバイスと通信することが可能です。一致するデバイスを見つけるには、`navigator.bluetooth.requestDevice()` メソッドを呼び出します。次の例では、ブルートゥースデバイスのリストは、バッテリーサービスを提供しているかどうかでフィルタリングされています。ブラウザにデバイスピッカーが表示され、ユーザーがブルートゥースデバイスを選択できます。その後、リモートデバイスに接続し、データを収集できます。

```js
try {
  const device = await navigator.bluetooth.requestDevice({
    filters: [{ services: ['battery_service'] }]
  });
  console.log(device.name);
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
caption="WebブルートゥースAPIを使用したデスクトップWebサイト。",
content="71",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

このAPIは、Chrome OS、Android、macOS、WindowsのChromiumベースのブラウザで、バージョン56から一般的に利用できます（<a hreflang="en" href="https://caniuse.com/web-bluetooth">現在のWebブルートゥースAPIの対応ブラウザ</a>）。Linuxでは、フラグの後ろでAPIが提供されています。71のデスクトップと45のモバイルサイトがこの機能を利用しています。たとえば、家庭のビール醸造家を対象とした <a hreflang="en" href="https://web.brewfather.app/">Brewfather</a> PWAでは、ビールのレシピをブルートゥース対応の醸造システムに無線で送信できます。ここでもまた、サードパーティのソフトウェアをインストールすることなく、すべてが行われます。

{{ figure_markup(
image="web-bluetooth.jpg",
caption='Brewfatherアプリは、Webブルートゥースを利用してレシピをBrewコントローラーに送信します。',
description='ビールのレシピを表示し、醸造を開始することができるWebアプリケーション「Brewfather」のスクリーンショット。',
width=699,
height=440
) }}

### WebシリアルAPI
<a hreflang="en" href="https://web.dev/serial/">_WebシリアルAPI_</a>は、マイコンなどのシリアルデバイスと接続するためのものです。そのためには、`navigator.serial.requestPort()` メソッドを呼び出します。オプションでデバイスリストをフィルタリングするためのメソッドを渡すことができます。ブラウザにはデバイスピッカーが表示され、ユーザーがデバイスを選択できます。次に、ポートの `open()` メソッドを呼び出して、接続を開くことができます。

```js
try {
  const port = await navigator.serial.requestPort();
  await port.open({ baudRate: 9600 });
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
caption="WebシリアルAPIを利用したデスクトップWebサイト。",
content="15",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

この機能は、2021年3月にChromium 89で提供された比較的新しいものです（<a hreflang="en" href="https://caniuse.com/web-serial">現在のWebシリアルAPIのブラウザサポート</a>）。現在、デスクトップ15サイト、モバイル14サイトでWebシリアルAPIが利用されており、ブラウザ上でArduinoやESPマイコン用のプログラムを開発できる<a hreflang="en" href="https://duino.app/">Duino App</a>もその1つです。これらのプログラムは、リモートサーバーでコンパイルされ、WebシリアルAPIを介して接続されたボードにアップロードされます。

{{ figure_markup(
image="web-serial.jpg",
caption='Duinoアプリは、Webシリアルを使用してArduinoマイコンにプログラムをアップロードするWebベースのIDEです。',
description='WebベースのDuinoコードエディタアプリケーションがコードをコンパイルしている画面。',
width=699,
height=440
) }}

### 汎用センサーAPI
最後に<a hreflang="en" href="https://web.dev/generic-sensor/">_汎用センサーAPI_</a> により、加速度計、ジャイロスコープ、または方向センサーなど、デバイスのセンサーからセンサーデータを読み込むことができます。センサーにアクセスするには、センサークラス、たとえば `Accelerometer` の新しいインスタンスを作成する。コンストラクターは、要求された周波数を持つ設定オブジェクトを受け取ります。`onreading` と `onerror` イベントにアタッチすることで、センサーの値が更新されたときやエラーが発生したときに、それぞれ通知を受けることができます。最後に、`start()` メソッドを呼び出して、読み取りを開始する必要があります。

```js
try {
  const accelerometer = new Accelerometer({ frequency: 10 });
  accelerometer.onerror = (event) => {
    console.log(event);
  };
  accelerometer.onreading = (e) => {
    console.log(e);
  };
  accelerometer.start();
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
image="generic-sensor-api-usage.png",
caption='デスクトップおよびモバイルウェブサイトでの汎用センサーAPIの使用状況。',
description="Generic Sensor APIの使い方を示した図表。3種類のセンサーAPIを比較しています。相対方位センサーは、デスクトップで824サイト、モバイルで831サイトともっとも多く利用されています。直線加速度センサーは、デスクトップで257サイト、モバイルで237サイトと、大きく差をつけられています。ジャイロセンサーは、デスクトップで36サイト、モバイルで22サイトと、もっとも利用されていない。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5Byx-_990HdH35no6J879Vk-wNe6EJGHfJJEP61RuLYHyVJfRU0X0L96-kpFAEmWt7x4pB9aiMfQr/pubchart?oid=1901915946&format=interactive",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

この機能は、バージョン67以降のChromiumブラウザでサポートされています（<a hreflang="en" href="https://caniuse.com/mdn-api_sensor">汎用センサーAPIをサポートする現在のブラウザ</a>）。相対方位センサーはデスクトップ824サイト、モバイル831サイト、直線加速度センサーはデスクトップ257サイト、モバイル237サイト、ジャイロセンサーはデスクトップ36サイト、モバイル22サイトで利用されています。この3つを使ったアプリケーションの例として<a hreflang="en" href="https://obs.ninja/">VDO.Ninja</a>、旧OBS Ninjaがあります。OBSなどの映像放送ソフトとリモートで接続するためのソフトウェアです。このアプリを使うことで、接続した放送ソフトがデバイスからセンサーデータを読み取ることができます。たとえば、バーチャルリアリティコンテンツを配信する際に、スマートフォンの動きを取り込むことができるようになります。FuguのコントリビューターであるIntelは、汎用センサーAPIの追加の <a hreflang="en" href="https://intel.github.io/generic-sensor-demos/">demos</a> を提供しています。

{{ figure_markup(
image="generic-sensor-api.jpg",
caption='汎用センサーAPIを使用することで、デバイスの向きに応じて3Dモデルを回転させることができます。',
description='3Dモデルを表示した携帯電話のスクリーンショット2枚。2枚目のスクリーンショットでは、端末の向きが変わっているため、3Dモデルが回転しています。',
width=808,
height=822
) }}

## もっとも多くの機能を使用しているサイト
また、HTTP Archiveのデータセットから、もっとも多くの機能を使用しているウェブサイトを特定する解析も行いました。この検出スクリプトは、合計30個のフグAPIを識別できます。そこで、もっとも多くのフグAPIを使用しているWebサイトに賞を贈りましょう。盛り上がってきましたね〜。

{{ figure_markup(
image="fugu-podium.jpg",
caption='フグのAPIをもっとも多く利用している3つのWebサイト。',
description="画像は、フグのAPIをもっとも多く利用した3つのWebサイトのスクリーンショットが並べられた優勝壇上です。",
width=1050,
height=442
) }}

1. 1位は<a hreflang="en" href="https://whatwebcando.today/">whatwebcando.today</a> で、28の機能を使用しています。HTML5のデバイス統合APIを、各機能のライブデモを提供することで、紹介しています。当然ながら、使用されているAPIの数は非常に多い。結果セットでは、<a hreflang="en" href="https://whatpwacando.today/">whatpwacando.today</a> という同様のサイトがPWA機能を紹介し、8つのAPIを使用していることがわかります。
1. 次点は、スウェーデンの警察告知を表示する<a hreflang="en" href="https://polisnotis.se/">PolisNotis</a> PWAです。PWA関連のリンクをクリックすると必ず新しいウィンドウが開くように定義する宣言型リンクキャプチャAPIなど、10個のAPIを使用しています。WebシェアAPIはソースコードで使用されていますが、共有機能はUIに公開されていません。また、Badging APIを利用して、新しいお知らせがあった場合にアプリアイコンを通じてユーザーに注意を促しています。
1. 僅差の3位は、9つのAPIを使用するウェブサイト<a hreflang="en" href="https://system-scanner.net/">システムスキャナー</a>です。汎用センサーAPIで提供されるセンサー情報を含む、ブラウザが公開するシステム情報の概要を表示します。
1. 8つのサイトが8つのフグAPIを使用しています。その1つが、前述の<a hreflang="en" href="https://excalidraw.com/">Excalidraw</a>で、手書き風の図面を作成するためのオンラインドローイングツールです。従来の生産性アプリとして、新機能の恩恵を受けています。

結果セットの中には、<a hreflang="en" href="https://www.discourse.org/">Discourse</a>に基づいたインターネット・フォーラムであるウェブサイトもあります。合計8つのフグAPIに対応したフォーラムソフトです。Discourseベースのフォーラムがインストール可能で、とくに未読通知数を表示するBadging APIをサポートしています。

この結果には、APIを積極的に利用していないサイトも含まれています。たとえば、理論的には機能にアクセスできるライブラリコードを配布しているサイトがあります。ユーザーのブラウザを特定するために、フグAPIの存在を確認するサイトもあります。

## 結論
開発者がより多くのユースケースを利用できるようにすることで、ウェブを前進させることができるのです。この章で示すように、開発者は新しいWebプラットフォームAPIを使用して、強力なアプリケーションを構築します。プラットフォーム固有のものとは対照的に、これらのアプリケーションは、必ずしもシステムにインストールする必要はなく、動作するためにサードパーティのランタイムやプラグインを追加で必要としません。強力なブラウザを実行できるプラットフォームであれば、どのような環境でも動作するのです。

このコンセプトが機能している一例として、Visual Studio Codeがあります。このアプリケーションは常にWebベースでしたが、それでもElectronのようなプラットフォーム固有のアプリケーションラッパーに依存していました。ファイルシステムアクセスAPIなどの機能により、Microsoftは2021年10月にブラウザアプリケーション（<a hreflang="en" href="https://vscode.dev">vscode.dev</a>）として公開することができました。デバッグやターミナルアクセスを除いて、ほとんどすべての機能がここで動作します（まだ、この機能はありません！）。

また、<a hreflang="en" href="https://photoshop.adobe.com">Adobe Photoshop</a>も2021年10月に<a hreflang="en" href="https://web.dev/ps-on-the-web/">ウェブアプリケーションとしてリリースされました</a>。Photoshopは、ここで紹介した機能のいくつかと、WebAssemblyを使用して、既存のコードをWebに移行できます。ベクターベースの対応するIllustratorは、現在クローズドベータ版として提供されており、後日リリースされる予定です。最初のエディションはまだ限られた機能しかありませんが、アドビはすでにこれにとどまらず、<a hreflang="en" href="https://web.dev/ps-on-the-web/#what's-next-for-adobe-on-the-web">webへのさらなる拡大を計画している</a>ことを発表しています。

このように、ケイパビリティプロジェクトは、アプリケーションの全カテゴリーを最終的にWebに移行させる道を開くものです。
