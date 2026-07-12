---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: ケイパビリティ
description: 2025年版Web Almanacのケイパビリティチャプターでは、ウェブアプリがハードウェアインターフェースにアクセスしたり、ウェブベースの生産性アプリを強化したり、ブラウザ組み込みAIなどを実現する、まったく新しい強力なウェブプラットフォームAPIを取り上げます。
hero_alt: Web Almanacのキャラクターたちがスーパーヒーローのケープをまとい、さまざまなケイパビリティをウェブページに接続しているヒーロー画像。
authors: [Dawntraoz]
reviewers: [webmaxru, tomayac]
analysts: [guaca, tomayac]
editors: [tunetheweb]
translators: [ksakae1216]
Dawntraoz_bio: Alba Silventeは、Fundaのシニアフロントエンドエンジニアです。<a hreflang="en" href="https://www.dawntraoz.com/">自身のブログ</a>でフロントエンド開発、Jamstack、ウェブパフォーマンスについて執筆し、カンファレンスでの登壇、テックポッドキャストの主催、オープンソースコミュニティへの積極的な貢献を行っています。Google Developer Expert（ウェブ技術）、Microsoft MVP、Women Tech Makersアンバサダーでもあります。
results: https://docs.google.com/spreadsheets/d/1tBTCtkEw0QEOyebuHIettqGEKw1gtO2EB1jkwpRKb18
featured_quote: ウェブ上のケイパビリティは成熟を続けており、既存のAPIが着実に採用される一方で、ブラウザネイティブなAI機能という新しいクラスが台頭し始めています。
featured_stat_1: ~13%
featured_stat_label_1: Compression Streams APIを使用するサイトの割合。
featured_stat_2: ~5%
featured_stat_label_2: Media Capabilities APIを使用するサイトの割合。
featured_stat_3: <1%
featured_stat_label_3: ブラウザネイティブAI APIを使用するサイトの割合。
doi: 10.5281/zenodo.18246600
---

## はじめに

今日のウェブブラウザは、これまでにないほど豊かなウェブ体験を提供しています。ブラウザ自体の基本的な機能に留まらず、低レベルの機能や実行中のオペレーティングシステムも活用しています。

こうしたケイパビリティは、[Clipboard](https://developer.mozilla.org/docs/Web/API/Clipboard_API)、[File System](https://developer.mozilla.org/docs/Web/API/File_System_API)、[Service Worker](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) などの実績あるAPIから、ウェブアプリの開発を変革する可能性を持つ実験段階の新しいAPIまで、ウェブプラットフォームAPIを通じて提供されています。

AIの時代において、ブラウザは取り残されるわけにはいきません。AIの民主化のために、誰もが利用できる持続可能でアクセシブルなAI APIを提案していく必要があります。そこで今年のケイパビリティチャプターでは、ChromeとEdge固有のこれらの新しいAPIの初期利用状況について取り上げます。

## 方法論

本チャプターは例年同様、HTTP Archiveの数百万ページに及ぶ公開データセットを使用しています。サイトによってはリクエスト元のデバイスによって異なるコンテンツを提供するため、デスクトップとモバイルの両方でアーカイブされています。

### HTTP ArchiveはどのようにケイパビリティAPIを検出しているか？

HTTP Archiveのクローラーは、`/navigator\.share\s*\(/g` のような正規表現を使って、各ページでどのAPIが（潜在的に）使用されているかを判定するためにソースコードを解析します。

この検出方法にはいくつかの問題があります。例えばミニファイによって `navigator` が `n` に短縮されている場合など、検出できないAPIが存在するため過少報告になる場合があります。一方、実際にAPIが使用されているかどうかをコードを実行して確認するわけではないため、過剰報告になる場合もあります。

こうした制限はあるものの、本チャプターの他のエディションと同様、現在ウェブ上でどのようなケイパビリティが使われているかについて、十分な概観を得ることができます。

サポートされるケイパビリティに対して合計86の正規表現が存在します。使用されている全ての式は、<a href="https://github.com/tomayac/fugu-api-data">Fugu API data</a>プロジェクトをベースにした<a hreflang="en" href="https://github.com/HTTPArchive/custom-metrics/blob/main/dist/fugu-apis.js">ソースファイル</a>で確認できます。

### Project Fugu

データを詳しく見ていく前に、ウェブとモバイル/デスクトップアプリケーション間の機能同等性の実現を目指すクロスカンパニーイニシアチブであるProject Fuguへの感謝を表明したいと思います。

このイニシアチブのおかげで、プラットフォーム固有のケイパビリティをウェブに公開することで、これまでアプリケーションのみで利用可能だった多くの機能を活用できるようになっています。

このコンテキストで公開されているAPIについては、Chromeデベロッパーブログで[ケイパビリティプロジェクト](https://developer.chrome.com/docs/capabilities)の詳細をご覧ください。

## 最もよく使われる機能トップ7

以下のセクションでは、2025年のデータセットで観測されたウェブプラットフォームケイパビリティの中で最も広く使用されている7つを取り上げます。これらの機能は、長年使われてきたAPIと、広く実用的に採用されるまでに成熟した比較的新しいAPIが混在しています。モバイルとデスクトップの両方のページで普及していることは、今日のウェブプラットフォームが最も多く依存している領域を示しており、現代のウェブアプリケーションの基礎的な構成要素となっているケイパビリティを理解するための有用な基準を提供します。

### Compression Streams API

[Compression Streams API](https://developer.mozilla.org/docs/Web/API/Compression_Streams_API)は、ウェブアプリがGZIPやDeflate（最近ではBrotliも）などの広くサポートされたフォーマットを使用して、ブラウザ上でデータを直接圧縮・解凍できるようにします。これにより、サーバーサイドの処理に依存せず、大量データの効率的な転送と保存が可能になります。

データは `CompressionStream` と `DecompressionStream` オブジェクトを通じて処理され、ウェブの[Streaming API](https://web.dev/streams)（`ReadableStream`、`WritableStream`）と統合されます。

```js
const text = "Hello Web Almanac 2025!";
const stream = new Blob([text]).stream();
const compressed = stream.pipeThrough(new CompressionStream("gzip"));
const decompressed = compressed.pipeThrough(new DecompressionStream("gzip"));
const result = await new Response(decompressed).text();

console.log(result); // "Hello Web Almanac 2025!"
```

2023年5月以降、この機能は最新のデバイスとブラウザバージョンで動作します。Chromiumベースのブラウザ、Safari、Firefoxで利用可能ですが、古いデバイスや他のブラウザでは動作しない場合があります。

{{ figure_markup(
  image="compression-streams.png",
  caption="Compression Streams APIの使用状況（2024年〜2025年）。",
  description="2024年から2025年にかけてモバイルとデスクトップの両プラットフォームでCompression Streams APIの使用が急増したことを示す棒グラフ。モバイルデバイスでは2024年のわずか2.3%から2025年には12.3%へと5倍以上に急増し、デスクトップの採用も同期間に2.7%から14.0%へとさらに急激な増加を見せました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=951480556&format=interactive",
  sheets_gid="1897009688",
  sql_file="fugu.sql"
  )
}}

Compression Streams APIの採用は2024年から2025年にかけて急増し、2025年に最も広く使用されるAPIとなり、3年間首位だったClipboard APIを抜きました。

モバイルでは使用率が2.3%から12.3%に、デスクトップでは2.7%から14.0%に急増しました。この急激な上昇は、過去2年間でAPIが[主要なエンジン全てで広くサポートされる](https://web.dev/blog/compressionstreams)ようになり、技術的な障壁が取り除かれ、開発者がJavaScriptのポリフィルを削除してネイティブのgzip/deflate圧縮を利用できるようになったことと一致しています。

このAPIはストリーミング効率が重要なデータ量の多いアプリケーションに特に有用であり、それが強い採用曲線を説明しています。

### Clipboard API

[Clipboard API](https://developer.mozilla.org/docs/Web/API/Clipboard_API)は、システムクリップボードへの非同期の読み書きアクセスを提供します。プレーンテキスト、HTML、画像などのフォーマットをサポートしていますが、ブラウザによってサポート状況が異なる場合があります。

[セキュリティ上の制限](https://developer.mozilla.org/docs/Web/API/Clipboard_API#security_considerations)により、クリップボード操作はクリックなどのユーザーアクションをトリガーとする必要があります。

```js
// Write text
await navigator.clipboard.writeText("Hello from Web Almanac!");

// Read text
const text = await navigator.clipboard.readText();

console.log(text); // "Hello from Web Almanac!"
```

非同期Clipboard APIはChromiumベースのブラウザ、Safari、Firefoxでサポートされています。ウェブカスタムフォーマットなどのリッチなクリップボードデータのサポートはChromiumベースのブラウザのみです。

{{ figure_markup(
  image="clipboard.png",
  caption="Clipboard APIの使用状況（2024年〜2025年）。",
  description="2024年から2025年にかけてモバイルとデスクトッププラットフォームでのClipboard APIの使用増加を示す棒グラフ。モバイルデバイスではAPIを使用するページの割合が10.0%から11.2%に上昇し、デスクトップも同様に10.4%から11.8%に増加しました。全体として、両プラットフォームで一貫した上昇傾向が見られ、デスクトップは両年ともモバイルよりわずかに高い使用率を維持しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=714385047&format=interactive",
  sheets_gid="1966659557",
  sql_file="fugu.sql"
  )
}}

Clipboard APIは引き続き着実な成長を見せています。モバイルの採用率は2024年の10.0%から2025年の11.2%に、デスクトップは10.4%から11.8%に増加しました。これは、開発者がレガシーな `execCommand()` のクリップボードハックから離れ、コピーボタンや貼り付けワークフローのために非同期APIを採用する動きが進んでいることを反映しています。前年比の伸びは穏やかで、Clipboard APIが新興のケイパビリティではなく、今や確立されたユーティリティであることを示しています。

### Web Share API

[Web Share API](https://developer.mozilla.org/docs/Web/API/Web_Share_API)は、ウェブアプリがデバイスのネイティブ共有メカニズムを呼び出せるようにし、ユーザーがテキスト、URL、ファイルをメッセージング、メール、ソーシャルアプリなどの他のインストール済みアプリと共有できるようにします。

メインメソッドは `navigator.share()` で、共有するデータを持つオブジェクトを受け取ります。オプションの `navigator.canShare()` メソッドは、共有を試みる前に提供されたデータ（特にファイル）が共有可能かどうかを確認するために使用できます。

このAPIはクリックなどのユーザーアクションが必要で、プラットフォームの共有シートを起動し、ユーザーが共有先のアプリを選択できるようにします。

```js
const data = {
  title: "Web Almanac 2025",
  text: "Check out the latest edition of the Web Almanac!",
  url: "https://almanac.httparchive.org/en/2025/",
};

if (navigator.canShare && navigator.canShare(data)) {
  try {
    await navigator.share(data);
    console.log("Data shared successfully!");
  } catch (err) {
    console.error("Share failed:", err);
  }
} else {
  console.warn("Sharing not supported on this device.");
}
```

Web Share APIはモダンなChrome、Edge、Safariでサポートされています。FirefoxはフラグによってのみAPI実装しており、デフォルトでは使用できません。

{{ figure_markup(
  image="web-share.png",
  caption="Web Share APIの使用状況（2024年〜2025年）。",
  description="2024年から2025年にかけてモバイルとデスクトップの両プラットフォームでWeb Share APIの使用がわずかに増加したことを示す棒グラフ。モバイルの使用率は6.0%から6.6%に増加し、デスクトップも同様に6.2%から6.7%へとわずかに上昇しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1903144577&format=interactive",
  sheets_gid="930326182",
  sql_file="fugu.sql"
  )
}}

最も広く採用されているAPIの一つである使用状況にわずかな変化があり、現在最も使用されているAPIのランキングで3位を占めています。

Web Share APIの採用は概ね横ばいで、モバイルは2024年の6.0%から2025年の6.6%へわずかに上昇し、デスクトップは6.2%から6.7%に増加しました。採用はほぼ横ばいながらわずかな上昇を見せています。このAPIは主要ブラウザで成熟と安定の段階に達しており、これらの漸進的な増加は大幅な成長というよりも自然な変動を示しています。

### Device Memory API

[Device Memory API](https://developer.mozilla.org/docs/Web/API/Device_Memory_API)は、`navigator.deviceMemory` を通じてデバイスのRAMのギガバイト単位の概算値を公開します。これにより開発者は、低メモリデバイスに軽量なページを提供するなど、エクスペリエンスを調整できます。

この値はプライバシー上の理由から丸められた粗い値となっています。

```js
console.log(navigator.deviceMemory);
// Example output: 8 (for an 8 GB device)
```

Chromiumベースのブラウザで利用可能で、SafariやFirefoxではサポートされていません。

{{ figure_markup(
  image="device-memory.png",
  caption="Device Memory APIの使用状況（2024年〜2025年）。",
  description="モバイルとデスクトップの両プラットフォームでDevice Memory APIの使用が増加したことを示す棒グラフ。モバイルの使用率は2024年の5.0%から2025年の6.3%に増加し、デスクトップの使用率は4.9%から6.2%に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=799153560&format=interactive",
  sheets_gid="1811570014",
  sql_file="fugu.sql"
  )
}}

Device Memory APIはモバイルで5.0%から6.3%、デスクトップで4.9%から6.2%へと顕著な上昇を見せました。この増加は、開発者が低メモリデバイスに軽量なアセットを提供できるアダプティブパフォーマンス戦略においてAPIの有用性が広く認識されるようになったことを反映しています。もう一つの考えられる説明として、開発者がAIモデルをダウンロードする前に、利用可能なメモリに基づいてデバイスでAI推論を合理的に実行できるかどうかを判断しようとしているという可能性もあります。

より多くの開発者が `navigator.deviceMemory` を活用して低メモリデバイスに軽量なエクスペリエンスを提供しています。採用はChromiumのみの可用性と意図的に粗い値によってまだ制限されていますが、この成長はパフォーマンスを重視するサイトがこれを実際に活用し始めていることを示しています。

### Media Session API

[Media Session API](https://developer.mozilla.org/docs/Web/API/Media_Session_API)は、開発者がメディア通知をカスタマイズし、プラットフォームレベルのメディアコントロール（ロック画面、ヘッドセットボタン、スマートディスプレイなど）と統合できるようにします。

`navigator.mediaSession` を使用して、アプリはメディア再生のメタデータとアクションを定義できます。

```js
navigator.mediaSession.metadata = new MediaMetadata({
  title: "Web Almanac Podcast",
  artist: "HTTP Archive",
  album: "2025 Edition",
});

navigator.mediaSession.setActionHandler("play", () => {
  audio.play();
});
```

ChromiumベースのブラウザとSafariで広くサポートされています。Firefoxは一部の重要な機能をサポートしていません。

{{ figure_markup(
  image="media-session.png",
  caption="Media Session APIの使用状況（2024年〜2025年）。",
  description="Media Session APIの使用状況を示すこの棒グラフは、両プラットフォームでわずかな下降傾向という特徴的なパターンを示しています。モバイルの使用率は2024年の4.9%から2025年の4.7%に低下し、デスクトップの採用も5.5%から5.3%にわずかに減少しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1577112625&format=interactive",
  sheets_gid="1863050303",
  sql_file="fugu.sql"
  )
}}

Media Session APIはわずかな減少を経験しました。モバイルの採用は2024年の4.9%から2025年の4.7%に低下し、デスクトップも5.5%から5.3%にわずかに下落しました。これらの差は軽微であり、意味のある変化よりもデータセットの自然な変動を反映している可能性が高いです。全体的に使用は安定しており、プラットフォームレベルのメディアコントロールとの統合がユーザーエクスペリエンスを向上させる音楽プレーヤーやポッドキャストアプリなどのオーディオ・ビデオサイトに集中しています。

### Add to Home Screen

この機能により、ユーザーは[Progressive Web App（PWA）をデバイス上のアプリライクなエクスペリエンスとしてインストール](https://developer.chrome.com/blog/how_chrome_helps_users_install_the_apps_they_value)できます。

サイトがインストール可能条件を満たすと、Chromeやほかのブラウザはインストールバッジ（アドレスバーのアイコンや「インストール」メニューオプションなど）を表示し、ユーザーがアプリをホーム画面に追加またはスタンドアロンアプリとしてインストールできるようにします。また、これらの条件を満たさないサイト向けの手動インストールフローもサポートしています。ChromeはさらにAndroidでML駆動のインストールプロンプトを試験的に導入し、ユーザーがインストール可能なエクスペリエンスを発見できるよう支援しています。

{{ figure_markup(
  image="add-to-home-screen.png",
  caption="Add to Home Screenの使用状況（2024年〜2025年）。",
  description="モバイルとデスクトップの両プラットフォームでAdd to Home Screenの使用がわずかに減少したことを示す棒グラフ。モバイルの使用率は2024年の4.8%から2025年の4.6%に低下し、デスクトップの採用も5.1%から4.9%へとわずかに低下しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=398812036&format=interactive",
  sheets_gid="1084353718",
  sql_file="fugu.sql"
  )
}}

Add to Home Screen機能の採用は横ばいで、モバイルの使用率は2024年の4.8%から2025年の4.6%にわずかに低下し、デスクトップは5.1%から4.9%に低下しました。これらの小さな減少は、実際の下降トレンドよりも通常の変動を反映している可能性が高いです。成長はプラットフォームの断片化によって制約されています。AndroidとChromiumベースのブラウザがインストールプロンプトを公開する一方、iOSは手動のSafari駆動のインストールフローに依存しています。これにより、PWAの採用にもかかわらず広範な普及が制限されています。

### Media Capabilities API

[Media Capabilities API](https://developer.mozilla.org/docs/Web/API/Media_Capabilities_API)は、ブラウザが指定されたオーディオまたはビデオ設定を効率的にデコードして再生できるかどうかを開発者が照会できるようにします。

アダプティブメディアストリーミングのスムーズさと電力効率に関するインサイトを提供します。

```js
const config = {
  type: "file",
  audio: {
    contentType: "audio/mp3",
    channels: 2,
    bitrate: 132700,
    samplerate: 5200,
  },
};

const result = await navigator.mediaCapabilities.decodingInfo(config);

console.log(result.supported); // true or false
console.log(result.powerEfficient); // true or false
```

広く利用可能で、多くのデバイスとブラウザバージョンで動作します。2020年1月からブラウザ全体で利用可能です。ただし、この機能の一部はSafariなどのブラウザでサポートレベルが異なる場合があります。

{{ figure_markup(
  image="media-capabilities.png",
  caption="Media Capabilities APIの使用状況（2024年〜2025年）。",
  description="Media Capabilities APIの使用が急増したことを示す棒グラフ。モバイルの採用率はわずか0.6%から4.4%へと急上昇し、デスクトップの使用率はさらに大きく0.8%から5.0%にジャンプしました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1359620848&format=interactive",
  sheets_gid="1154224831",
  sql_file="fugu.sql"
  )
}}

Media Capabilities APIは過去1年間で劇的な成長を遂げました。モバイルの採用率は2024年のわずか0.61%から2025年の4.37%へ上昇し、デスクトップの使用率は0.75%から5.00%へジャンプしました。この急増は、デバイスに最適なストリームを選択する前にコーデックサポート、再生スムーズさ、電力効率を判断するために `decodingInfo()` を使用するストリーミングプラットフォームによる急速な採用を示しています。漸進的な変化しか見られなかった他のAPIとは異なり、Media Capabilitiesはメディアヘビーなサイトによって牽引される急速な採用軌道に明らかに乗っています。

## 過去1年間の新機能

2025年のCapabilitiesチャプターで最も注目すべき変化の一つは、[ブラウザネイティブのAIおよび言語API](https://developer.chrome.com/docs/ai/built-in-apis)が初めて登場したことです。AIはウェブ上で外部サービスやライブラリを通じて長年広く使用されてきましたが、これらのAPIはブラウザが直接提供する組み込みの標準化された言語機能への移行を表しています。

### Built-in AI APIs

2025年時点では、実験的なコンテキスト外で利用可能なAPIはサブセットのみです：_LanguageDetector_、_Translator_、_Summarizer_、および _Prompt_（拡張機能に限定）。通常の _Prompt_ API、_Writer_、_Rewriter_、_Proofreader_ などのその他の組み込みAI機能は実験的なままで、追加のセットアップが必要で、一時的またはトークンベースの制限のもとで動作しています。実験的な機能は本番ウェブサイトに登場する可能性が低いため、この区別は使用データを解釈する際に重要です。

<figure>
  <table>
    <thead>
      <tr>
        <th>Built-in AI API</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>LanguageDetector</td>
        <td>0.28%</td>
        <td>0.26%</td>
      </tr>
      <tr>
        <td>Prompt</td>
        <td>0.08%</td>
        <td>0.09%</td>
      </tr>
      <tr>
        <td>Translator</td>
        <td>0.28%</td>
        <td>0.26%</td>
      </tr>
      <tr>
        <td>Summarizer</td>
        <td>0.13%</td>
        <td>0.14%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Built-in AI APIの使用状況", sheets_gid="843125108", sql_file="fugu.sql") }}</figcaption>
</figure>

利用可能にもかかわらず、ウェブ全体での使用は非常に限られています。下表に示すように、これらの各APIはデスクトップとモバイルの両データセットでページの1%をはるかに下回る割合でしか登場していません。ただし、実際のサポートは現在ほとんどのデスクトッププラットフォーム（Windows、macOS、Linux、およびChromebook PlusデバイスのChromeOS）に限定されています。Language DetectorとTranslatorが最も多く観測され、それぞれデスクトップページの約0.28%、モバイルページの0.26%で使用されており、PromptとSummarizerはさらに小さな足跡を示しています。

低い採用率は予想されていました。これらのAPIは新しく、多くはまだ進化中であり、現在ChromeとEdgeという限られたブラウザセットでサポートされています。それでも2025年のデータセットへの組み込みは重要な意味を持ちます。HTTP Archiveにブラウザネイティブの組み込みAIプリミティブが初めて測定可能な形で登場したことを示し、今後数年間でウェブにおける組み込みAI機能がどのように進化するかを追跡するためのベースラインを確立しています。

これらのAPIやウェブ上のAIについての詳細な議論は[生成AI](./generative-ai)チャプターも参照してください。

## 結論

2025年のCapabilities分析は、幅広さと深さの両面で成熟し続けるウェブプラットフォームを示しています。Compression StreamsやAsync Clipboardなどの確立されたAPIは大幅または着実に成長し、より広いクロスエンジンサポートと開発者がレガシーパターンを置き換えていることを反映しています。Web Share、Media Session、Add to Home Screenなどの機能は安定を維持し、年間の変動はわずかにとどまりました。同時に、Media CapabilitiesなどのスペシャリストAPIはメディアヘビーなサイトで顕著な採用増加を見せており、垂直方向のユースケースでの深い採用を示唆しています。

最も注目すべきは、2025年がLanguageDetector、Translator、Prompt、Summarizerを含むブラウザネイティブのAIおよび言語APIの最初の測定可能な足跡を記録したことです。それぞれがページの1%をはるかに下回る割合でしか登場していなくても、その存在は将来の採用のベースラインを確立し、より高レベルの機能を公開する準備がますます整いつつあるウェブプラットフォームを示唆しています。

今後を見据えると、ブラウザサポートが固まり開発者向けツールが進化するにつれて、継続的な標準化と実際の有用性によって成長が形作られていくでしょう。新しいAPIは実験的な珍しさから、より豊かでスマートなウェブアプリケーションのための実用的な構成要素へと移行していく可能性があります。
