---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: 2021年版Web AlmanacのWebAssemblyの章では、Wasm圧縮、セクションサイズ、もっとも人気のある命令、およびポストMVPの提案をカバーしています。
hero_alt: Hero image of Web Almanac characters performing scientific experiments on various code symbols resulting in 1s and 0s coming out the other end.
authors: [RReverser]
reviewers: [jsoverson, carlopi, kripken, rviscomi, tunetheweb]
analysts: [RReverser]
editors: [shantsis]
translators: [ksakae1216]
RReverser_bio: Ingvarは、より良いツール、仕様、ドキュメントを通じて開発者の体験を向上させることに常に取り組んでいる情熱的なD2D（開発者間）プログラマーです。現在、Google Chrome チームで WebAssembly Developer Advocate として働いています。
results: https://docs.google.com/spreadsheets/d/1IMa2SbdQgshb4pGWF1KOh9s4zMtLbRymWZGYjdaatXY/
featured_quote: WebAssembly [...] はウェブのエコシステムに非常によく統合されているので、多くのウェブサイト所有者は、すでにWebAssemblyを使っていることにさえ気づかないかもしれません。彼らにとっては、他のサードパーティのJavaScript依存関係と同じように見えます。
featured_stat_1: 44 MB
featured_stat_label_1: データセット内の最大のWebAssemblyレスポンスのダウンロードサイズ。
featured_stat_2: 40.2%
featured_stat_label_2: モバイルでの非圧縮WebAssemblyレスポンスの割合。
featured_stat_3: 55.2%
featured_stat_label_3: デスクトップでサードパーティオリジンから読み込まれたWebAssemblyファイルのパーセンテージ。
---

## 序章

<a hreflang="en" href="https://webassembly.org/">WebAssembly</a> はバイナリ命令形式で、開発者がJavaScript以外の言語で書かれたコードをコンパイルし、効率的で移植性の高いパッケージでWebに持ってくることを可能にするものです。既存のユースケースは、再利用可能なライブラリやコーデックから完全なGUIアプリケーションまで多岐にわたります。2017年から4年間、すべてのブラウザで利用できるようになり、それ以来、採用が進み、今年からWeb Almanacで利用状況を追跡する良いタイミングだと判断しました。

## 方法論

この分析では、2021-09-01にHTTP Archiveをクロールし、`Content-Type` (`application/wasm`) またはファイル拡張子 (`.wasm`) にマッチするすべてのWebAssemblyレスポンスを選択しました。そして、<a hreflang="en" href="https://github.com/RReverser/wasm-stats/blob/master/downloader/wasms.csv">それらすべて</a>をダウンロードし、その過程でさらにURL、レスポンス サイズ、圧縮前のサイズ、コンテンツ ハッシュを<a hreflang="en" href="https://github.com/RReverser/wasm-stats/blob/master/downloader/results.csv">CSVファイル</a>に保存する <a hreflang="en" href="https://github.com/RReverser/wasm-stats/blob/master/downloader/index.mjs">script</a> を使用しました。サーバーエラーで何度も応答が得られないリクエストや、コンテンツが実際にWebAssemblyらしくないものは除外しました。たとえば、いくつかの <a hreflang="en" href="https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor">Blazor</a> ウェブサイトでは、<a hreflang="en" href="https://docs.microsoft.com/en-us/troubleshoot/windows-client/deployment/dynamic-link-library#the-net-framework-assembly">.NET DLLs</a> に `Content-Type: application/wasm` を付けて提供していましたが、これらは実際にはフレームワークコアでパースされるDLLであって、WebAssemblyモジュールではありません。

WebAssemblyのコンテンツ解析では、BigQueryを直接利用することができませんでした。その代わりに、与えられたディレクトリ内のすべてのWebAssemblyモジュールを解析し、カテゴリごとの命令数、セクションサイズ、インポート/エクスポート数などを収集し、すべての統計情報を `stats.json` ファイルに格納する <a hreflang="en" href="https://github.com/RReverser/wasm-stats">ツール</a> を作成しました。前のステップでダウンロードしたファイルのあるディレクトリで実行した後、結果のJSONファイルを <a hreflang="en" href="https://cloud.google.com/bigquery/docs/batch-loading-data">BigQueryにインポート</a>し、<a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/util/wasm_stats.sql">対応する `summary_requests` と `summary_pages` テーブル</a>と一緒に `httparchive.almanac.wasm_stats` へ結合して、それぞれのレコードが自己完結しWebAssembly要求、応答、モジュールコンテンツに関するすべての必要情報を含むようにします。この最終的なテーブルは、本章のすべての分析に使用されました。

クローラーリクエストを解析のソースとして使用することは、この記事の数字を見る際に注意すべきトレードオフがあります。

- まず、ユーザーとのインタラクションをきっかけに発生するリクエストの情報がありませんでした。ページロード中に収集されたリソースのみを対象としました。
- 次に、ウェブサイトには人気のあるものとそうでないものがありますが、正確な訪問者データがなかったため、それを考慮せず、検出されたWasmの利用状況をそれぞれ同等に扱いました。
- 最後に、サイズのようなグラフでは、ユニークなファイルだけを比較するのではなく、複数のウェブサイトで使用されている同じWebAssemblyモジュールをユニークな使用量としてカウントしています。これは、ライブラリ同士を比較するのではなく、Webページ全体におけるWebAssemblyの使用状況の全体像にもっとも興味があるためです。

これらのトレードオフは他の章で行われた分析ともっとも一致していますが、もし他の統計を集めることに興味があるなら、`httparchive.almanac.wasm_stats`のテーブルに対して独自のクエリを実行することを歓迎します。

## モジュール数は？

デスクトップで3854、モバイルで3173のWebAssemblyリクエストが確認されました。これらのWasmモジュールはデスクトップでは2724ドメイン、モバイルでは2300ドメインで使用されており、デスクトップとモバイルの全ドメインのそれぞれ0.06%と0.04%に相当します。

興味深いことに、もっとも人気のあるMIMEタイプを見ると、`Content-Type: application/wasm`が圧倒的に人気がある一方で、すべてのWasmレスポンスをカバーしているわけではないことがわかります。`.wasm`の拡張子を持つ他のURLも含めてよかったです。

{{ figure_markup(
  caption="上位のMIMEタイプ。",
  description="デスクトップとモバイルのWebAssemblyリクエストのうち、application/wasmが72.8%と69.6%を占め、application/octet-streamが13.1%と14.2% 、MIMEタイプが10.5%と12.7% 、text/plainが1.7%と2%、その他はそれぞれ1%未満であることが示されている棒グラフがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1635040165&format=interactive",
  sheets_gid="298942353",
  sql_file="mime_types.sql",
  image="mime_types.png"
  )
}}

そのうちのいくつかは `application/octet-stream` という任意のバイナリデータの一般的な型を使い、いくつかは `Content-Type` ヘッダーを持たず、他のものはplainやHTMLなどのテキスト型、あるいは `binary/octet-stream` のように不正な型を使っています。

WebAssemblyの場合、正しい `Content-Type` ヘッダーを提供することは、セキュリティ上の理由だけでなく、[`WebAssembly.compileStreaming`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/compileStreaming) や [`WebAssembly.instantiateStreaming`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/instantiateStreaming) によるストリーミング、コンパイルやインスタンス化の高速化も可能になるので、重要です。

## Wasmのライブラリはどのくらいの頻度で再利用されているのでしょうか？

また、これらの応答をダウンロードする際にその内容をハッシュ化し、そのハッシュをディスク上のファイル名として使用することで、重複排除を行いました。その後、デスクトップでは656個、モバイルでは534個の一意のWebAssemblyファイルが残りました。

{{ figure_markup(
  caption="Wasmのレスポンス数",
  description="デスクトップとモバイルのデータセットにおけるWasmの総レスポンス数、およびユニークファイル数を示す棒グラフ。ユニークファイル数は、デスクトップでは全レスポンス数3854件のうち656件、モバイルでは3173件のうち534件と、かなり少なくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=341129382&format=interactive",
  sheets_gid="1692581795",
  sql_file="counts.sql",
  image="counts.png"
  )
}}

ユニークなファイルの数と総レスポンス数の差が激しいことから、さまざまなWebサイトでWebAssemblyライブラリが高度に再利用されていることがすでに示唆されています。クロスオリジン/同一オリジンのWebAssemblyリクエストの分布を見ると、さらに確認できます。

{{ figure_markup(
  caption="クロスオリジンのWebAssemblyの使用。",
  description="棒グラフは、デスクトップで55.2%、モバイルでは45.5%のWebAssemblyがサードパーティのドメインからモジュールをロードしていることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1239068211&format=interactive",
  sheets_gid="49966611",
  sql_file="cross_domain.sql",
  image="cross_domain.png"
  )
}}

では、その再利用されるライブラリは何なのか、もっと掘り下げて考えてみましょう。まず、コンテンツ・ハッシュだけでライブラリの重複排除を試みましたが、残ったものの多くが、ライブラリのバージョンだけが異なる重複ライブラリであることがすぐに判明しました。

そこで、URLからライブラリ名を抽出することにしました。名前の衝突の可能性があるため、理論的にはより問題がありますが、実際にはトップライブラリのためのより信頼性の高いオプションであることが判明しました。URLからファイル名を抽出し、拡張子、マイナーバージョン、コンテンツハッシュのように見えるサフィックスを削除し、結果を繰り返し回数でソートして、各クライアントの上位10個のモジュールを抽出しました。残ったモジュールについては、どのライブラリから来たものなのか、手作業で調べました。

{{ figure_markup(
  caption="WebAssemblyの人気ライブラリ。",
  description="デスクトップとモバイルのデータセットで上位10ライブラリを1つのグラフに統合した棒グラフです。各ライブラリは、そのライブラリに起因すると考えられるWasmリクエストの割合とともに表示されます。一覧は以下の通りです。Amazon IVS（デスクトップ30.3%、モバイル28.7%）、Hyphenopoly（13.2%、18.9%）、Blazor（3.5%、5.0%）、ArcGIS（3.7%、3.6%）、Draco（2.9%、2.4%）、CanvasKit（3.6%、1%）、Playa Games（デスクトップのみ3.3%）、Tableau（デスクトップ1.3%、モバイル1.9%）、Xat（1.5%、1.4%）、Tencent Video（デスクトップだけ2%）、Nimiq（0.5%、1%）およびScandit（0.2%、1.2%）である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=384910968&format=interactive",
  sheets_gid="1520429605",
  sql_file="popular_by_name.sql",
  image="popular_by_name.png",
  width=600,
  height=650
  )
}}

デスクトップとモバイルの両方で使用されるWebAssemblyのほぼ3分の1は、<a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon Interactive Video Service</a> プレーヤー ライブラリに属しています。オープンソースではありませんが、関連するJavaScriptのグルーコードを調べると、<a hreflang="en" href="https://emscripten.org/">Emscripten</a> でビルドされていることがわかります。

次に、<a hreflang="en" href="https://github.com/mnater/Hyphenopoly">Hyphenopoly</a>は、さまざまな言語のテキストをハイフンでつなぐためのライブラリで、デスクトップとモバイルでそれぞれ13％と19％のWasmリクエストを占めています。JavaScriptと<a hreflang="en" href="https://www.assemblyscript.org/">AssemblyScript</a>で構築されています。

デスクトップとモバイルのトップ10リストにある他のライブラリは、それぞれWebAssemblyリクエストの最大5%を占めています。上記のライブラリの完全なリストと、推測されるツールチェーン、および詳細情報を含む対応するホームページへのリンクはこちらです。

- <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon IVS</a> (Emscripten)
- <a hreflang="en" href="https://mnater.github.io/Hyphenopoly/">Hyphenopoly</a> (AssemblyScript)
- <a hreflang="en" href="https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor">Blazor</a> (.NET)
- <a hreflang="en" href="https://developers.arcgis.com/javascript/latest/">ArcGIS</a> (Emscripten)
- <a hreflang="en" href="https://google.github.io/draco/">Draco</a> (Emscripten)
- <a hreflang="en" href="https://skia.org/docs/user/modules/canvaskit/">CanvasKit</a> (Emscripten)
- <a hreflang="en" href="https://www.playa-games.com/en/">Playa Games</a> (Unity via Emscripten)
- <a hreflang="en" href="https://help.tableau.com/current/api/js_api/en-us/JavaScriptAPI/js_api.htm">Tableau</a> (Emscripten)
- <a hreflang="en" href="https://xat.com/">Xat</a> (Emscripten)
- <a hreflang="en" href="https://intl.cloud.tencent.com/products/vod">Tencent Video</a> (Emscripten)
- <a hreflang="en" href="https://www.npmjs.com/package/@nimiq/core-web">Nimiq</a> (Emscripten)
- <a hreflang="en" href="https://www.scandit.com/developers/">Scandit</a> (Emscripten)

方法論と結果について、もう少しだけ注意点があります。

1. Hyphenopolyはさまざまな言語の辞書を小さなWebAssemblyファイルとしてロードしますが、これらは技術的に別のライブラリではなく、Hyphenopoly自体のユニークな使用法でもないため、上のグラフからは除外しています。
2. Playa GamesのWebAssemblyファイルは、似たようなドメインでホストされている同じゲームで使用されているようです。私たちは、クエリでそれらを個々の使用として数えますが、リストの他の項目とは異なり、再利用可能なライブラリとして数えるべきかどうかは明らかではありません。

## 送るサイズはどのくらいですか？

WebAssemblyにコンパイルされた言語は、通常、独自の標準ライブラリを持っています。言語によってAPIや値の型が大きく異なるため、JavaScriptのビルトインを再利用することができないのです。その代わりに、独自のコードだけでなく、標準ライブラリのAPIもコンパイルして、単一のバイナリとしてまとめてユーザーに提供する必要があります。その結果、ファイルサイズはどうなるのだろうか？見てみよう。

{{ figure_markup(
  caption="非圧縮のレスポンスサイズ。",
  description="デスクトップとモバイルの非圧縮レスポンスサイズの分布をパーセンタイル25、50、75、90で示した棒グラフです。とくに、10パーセンタイルでは1KB、中央値で約810KB、90パーセンタイルではデスクトップで6.5MB、モバイルで2.7MBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=528882928&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="uncompressed_resp_sizes.png"
  )
}}

サイズもさまざまで、単純なヘルパーライブラリからWebAssemblyでコンパイルされた完全なアプリケーションまで、さまざまな種類のコンテンツをきちんとカバーしていることが分かります。

最大で81MBのサイズが確認され、かなり気になるところですが、これは非圧縮のレスポンスであることを念頭に置いてください。RAMの使用量や起動時のパフォーマンスも重要ですが、Wasmバイトコードの利点の1つは高圧縮であり、ダウンロード速度や課金上の理由から、通信上のサイズが重要になります。

代わりに、サーバーから送信された生のレスポンスボディのサイズを確認してみましょう。

{{ figure_markup(
  caption="生のレスポンスサイズ。",
  description="上記と同様の棒グラフですが、サーバーから受信した生のレスポンスサイズの分布を示しています。10パーセンタイルは約1KB、中央値は約290KB、90パーセンタイルはデスクトップで2.5MB、モバイルで1.4MBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1094358341&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="raw_resp_sizes.png"
  )
}}

中央値は約290KBで、半分が290KB以下、半分がそれ以上のダウンロード量ということになります。Wasmの全レスポンスの90%は、デスクトップで2.6MB未満、モバイルで1.4MB未満に留まっています。

{{ figure_markup(
  caption="デスクトップでダウンロードした最大のWasmレスポンス。",
  content="44 MB",
  classes="big-number",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql"
)
}}

HTTP Archiveの最大レスポンスでは、デスクトップで約44MB、モバイルで約28MBのWasmがダウンロードされます。

圧縮しても、世界の多くの地域ではまだ高速インターネット接続ができないことを考えると、この数字はかなり極端です。アプリケーションやライブラリの範囲を狭める以外に、Webサイトがこの数字を改善するためにできることはあるのでしょうか？

### Wasmは、実際どのように圧縮されているのですか？

まず、`Content-Encoding`ヘッダーに基づいて、これらの生のレスポンスで使用される圧縮方法について見てみましょう。モバイルでは帯域幅がさらに重要なので、ここではモバイルのデータセットを表示しますが、デスクトップの数値もかなり似ています。

{{ figure_markup(
  caption="Compression methods.",
  description="モバイルでの圧縮方式の分布を示す円グラフ。45.6%がgzip、40.2%が非圧縮、14.2%がBrotli、そしてごく少数がdeflateを使用していることが分かります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1660946444&format=interactive",
  sheets_gid="189654676",
  sql_file="compression_methods.sql",
  image="compression_methods.png"
  )
}}

残念ながら、モバイルにおけるWebAssemblyのレスポンスの40%は、圧縮されずに送信されていることがわかります。

{{ figure_markup(
  content="40.2%",
  caption="モバイルでの非圧縮WebAssemblyレスポンスの割合。",
  classes="big-number"
  )
}}

また、46%はgzipを使用しています。gzipは長い間、ウェブにおける事実上の標準的な方法であり、今でもきちんとした圧縮率を提供していますが、今日のベストアルゴリズムとは言えません。最後に、14% のみがBrotliを使用しています。この最新の圧縮形式はさらに優れた比率を提供し、<a hreflang="en" href="https://caniuse.com/brotli"> すべてのモダン ブラウザ</a>でサポートされています。実際、BrotliはWebAssemblyをサポートしているすべてのブラウザでサポートされているので、これらを一緒に使用しない理由はありません。

### 圧縮率を改善できないか？

違いがあったのでしょうか？我々は、それを解明するために、すべてのWebAssemblyファイルをBrotli（圧縮レベル9）で再圧縮することにしました。各ファイルで使用したコマンドは

```bash
brotli -k9f some.wasm -o some.wasm.br
```

でき上がったサイズはこちら。

{{ figure_markup(
  caption="Brotli圧縮後のサイズ。",
  description="手動でBrotli再圧縮した後のサイズの分布を、さまざまなパーセンタイルに沿って示した棒グラフです。とくに、デスクトップでは10パーセンタイルが1KB、中央値が約243KB、90パーセンタイルが2.2MB、モバイルでは846KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=2085720303&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="br_sizes.png"
  )
}}

中央値はほぼ290KBからほぼ240KBに下がり、これはもうかなり良い兆候です。上位10パーセンタイルは、2.5MB / 1.4MBから2.2MB / 0.8MBに減少しています。その他のパーセンタイルでも、大幅な改善が見られます。

パーセンタイルはその性質上、データセット間で必ずしも同じファイルに収まるとは限らないので、グラフ間で直接数値を比較し、サイズの節約を理解するのは難しいかもしれません。その代わり、これからは各最適化によってもたらされる節約額そのものを、一歩ずつ見ていくことにしましょう。

{{ figure_markup(
  caption="Brotli対応節約術。",
  description="上のグラフと似たような棒グラフですが、節約効果を示すように調整されています。10パーセンタイルでは差がなく、中央値ではデスクトップで46KB、モバイルで39KBの改善、90パーセンタイルではデスクトップで596KB、モバイルで328KBの改善となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1741617577&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="br_savings.png"
  )
}}

中央値は約40KBの節約となった。上位10%は、デスクトップで600KB弱、モバイルで330KBを節約しています。最大の削減量は、35MB/21MBに達します。これらの違いは、少なくともWebAssemblyコンテンツについては、可能な限りBrotli圧縮を有効にすることへ有利に働きます。

さらに興味深いことに、グラフの反対側では、もっとも節約できるはずの1.4MBまで後退していることがわかりました。何があったのでしょうか。Brotliの再圧縮が、一部のモジュールで状況を悪化させたというのは、どういうことなのでしょうか？

前述したように今回は圧縮レベル9のBrotliを使用したが、正直、この記事を書くまですっかり忘れていたのだが、レベル10と11もあるです。たとえば、<a hreflang="en" href="https://quixdb.github.io/squash-benchmark/#results-table">Squashのベンチマーク</a>で見られるように、これらのレベルでは、パフォーマンスが急激に低下する代わりに、さらに良い結果が得られます。このようなトレードオフの関係から、一般的なオンザフライ圧縮の候補としては不利になるため、この記事では使用せず、より穏やかなレベル9を採用しました。しかしウェブサイトの作者は、静的リソースを先に圧縮したり圧縮結果をキャッシュしたりすることを選択でき、CPU時間を犠牲にすることなく、さらに帯域を節約できます。このようなケースは、分析の結果、リグレッションとして表示されます。つまりリソースは、この記事で行ったよりもさらに最適化することが可能であり、場合によっては、すでに最適化されていることもあるのです。

### どの部分が一番スペースを取っているのでしょうか？

圧縮は別として、WebAssemblyバイナリのハイレベルな構造を分析することで、最適化の機会を探すことも可能でしょう。どのセクションがもっとも大きなスペースを占めているか？これを確認するために、すべてのWasmモジュールのセクションサイズを合計し、バイナリサイズ合計で割りました。ここでもモバイルデータセットの数字を使っていますが、デスクトップの数字もそれほど大きくはずれていません。

{{ figure_markup(
  caption="セクションのサイズ分布。",
  description="モバイルにおける各種セクションのバイナリサイズの分布を示す円グラフ。コードが73.7%、データ19.3%、カスタムセクション6.5%で、残りはごくわずかな割合です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=683121338&format=interactive",
  sheets_gid="1082802229",
  sql_file="section_sizes.sql",
  image="section_sizes.png"
  )
}}

当然のことながら、バイナリサイズの大部分（~74%）はコンパイルされたコード自身によるもので、その次に埋め込まれた静的データが~19%となっています。関数型、インポート/エクスポート記述子などは、総サイズのごく一部を構成しているに過ぎません。カスタムセクションは、モバイルデータセットにおける総サイズの約6.5%を占めています。

{{ figure_markup(
  content="6.5%",
  caption="モバイルデータセットのバイナリサイズに占めるカスタムセクションの割合。",
  classes="big-number"
  )
}}

カスタムセクションは、主にWebAssemblyのサードパーティツールのために使用されます。型結合システム、リンカー、DevToolsなどのための情報を含むかもしれません。どれも正当なユースケースですが、プロダクションコードではほとんど必要ないので、このような大きな比率は疑わしいと言えます。それでは、カスタムセクションがもっとも多いファイルトップ10にあるものを見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>URL</th>
        <th>カスタムセクションのサイズ</th>
        <th>カスタムセクション</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a href="https://gallery.platform.uno/package_85a43e09d7152711f12894936a8986e20694304a/dotnet.wasm">…/dotnet.wasm</a></td>
        <td class="numeric">15,053,733</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://cdn.decentraland.org/@dcl/unity-renderer/1.0.12536-20210902152600.commit-86fe4be/unity.wasm.br?v=1.0.8874">…/unity.wasm.br?v=1.0.8874</a></td>
        <td class="numeric">9,705,643</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://nanoleq.com/nanoleq-HTML5-Shipping.wasmgz">…/nanoleq-HTML5-Shipping.wasmgz</a></td>
        <td class="numeric">8,531,376</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://convertmodel.com/export.wasm">…/export.wasm</a></td>
        <td class="numeric">7,306,371</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://webasset-akm.imvu.com/asset/c0c43115a4de5de0/build/northstar/js/northstar_api.wasm">…/c0c43115a4de5de0/…/northstar_api.wasm</a></td>
        <td class="numeric">6,470,360</td>
        <td>`name`, `external_debug_info`</td>
      </tr>
      <tr>
        <td><a href="https://webasset-akm.imvu.com/asset/9982942a9e080158/build/northstar/js/northstar_api.wasm">…/9982942a9e080158/…/northstar_api.wasm</a></td>
        <td class="numeric">6,435,469</td>
        <td>`name`, `external_debug_info`</td>
      </tr>
      <tr>
        <td><a href="https://superctf.com/ReactGodot.wasm">…/ReactGodot.wasm</a></td>
        <td class="numeric">4,672,588</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://ui.perfetto.dev/v18.0-591dd9336/trace_processor.wasm">…/v18.0-591dd9336/trace_processor.wasm</a></td>
        <td class="numeric">2,079,991</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://ui.perfetto.dev/v18.0-615704773/trace_processor.wasm">…/v18.0-615704773/trace_processor.wasm</a></td>
        <td class="numeric">2,079,991</td>
        <td>`name`</td>
      </tr>
      <tr>
        <td><a href="https://unpkg.com/canvaskit-wasm@0.25.1/bin/profiling/canvaskit.wasm">…/canvaskit.wasm</a></td>
        <td class="numeric">1,491,602</td>
        <td>`name`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="最大のカスタムセクション。",
    sheets_gid="179685689",
    sql_file="large_custom_sections.sql"
  ) }}</figcaption>
</figure>

それらはすべて、基本的なデバッグのための関数名を含む `name` セクションにほぼ限定されています。実際、データセットに目を通し続けると、それらのカスタムセクションのほとんどすべてがデバッグ情報のみを含んでいることがわかります。

### デバッグ情報を削除することで、どの程度節約できるのか？

デバッグ情報はローカルでの開発には有用ですが、これらのセクションは非常に大きく、上の表では圧縮前に14MB以上あります。もしユーザが体験している問題をデバッグしたいのであれば、送信前に `llvm-strip` や `wasm-strip` または `wasm-opt --strip-debug` を使ってデバッグ情報を取り除き、生のスタックトレースを収集し、オリジナルのバイナリを使ってローカルでソースロケーションにマッチさせるというアプローチがよいかもしれません。

このデバッグ情報を削除することで、前のステップのBrotliだけと比較して、Brotliとの組み合わせでどの程度節約できるかを確認するのは興味深いことです。しかし、データセットに含まれるほとんどのモジュールにはカスタムセクションがないので、90パーセンタイル以下は役に立たないだろう。

{{ figure_markup(
  caption="strip-debug + Brotliの節約。",
  description="上記の変換によって達成された節約額の分布を示す散布図。グラフの大部分には変化が見られず、0パーセンタイル台にはわずかな減少が見られ、上位10％台には目に見える改善が散見されるのみです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=852876683&format=interactive",
  sheets_gid="50034228",
  sql_file="sizes_and_savings_100.sql",
  image="strip_br_savings_100.png"
  )
}}

代わりに、カスタムセクションを持つファイルにのみ、貯蓄の分配を見てみましょう。

{{ figure_markup(
  caption="strip-debug + Brotliの節約。",
  description="同じ変換で、カスタムセクションを持つファイルのみについて、サイズ改善の分布を示す棒グラフ。注目すべきは、10および25パーセンタイルでは最大1KBのごくわずかな改善、中央値では54KB、90パーセンタイルではデスクトップで247KB、モバイルで118KBの改善を示している点です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1291981446&format=interactive",
  sheets_gid="440746911",
  sql_file="sizes_and_savings.sql",
  image="strip_br_savings.png"
  )
}}

グラフからわかるように、いくつかのファイルのカスタムセクションは無視できるほど小さいですが、中央値は54KBで、90パーセンタイルはデスクトップで247KB、モバイルで118KBです。デスクトップとモバイルで最大のWasmバイナリで2.4MB/1.3MBの節約となり、とくに低速接続ではかなり顕著な改善となりました。

上の表から、カスタムセクションの生のサイズと比べると、その差がかなり小さいことにお気づきだろうか。その理由は、 `name` セクションは、その名前が示すように、ほとんどが関数名で構成されているからです。関数名は、繰り返しの多いASCII文字列であり、そのため非常に圧縮されやすいのです。

カスタムセクションを `llvm-strip` で削除する過程で、WebAssemblyモジュールに変更が加えられ、圧縮前は小さくても圧縮後はわずかに大きくなるという異常事態がいくつか発生しています。しかし、このようなケースはまれで、圧縮後のモジュールの合計サイズと比較すると、サイズの差は重要でありません。

### `wasm-opt`を使うとどのくらい節約できるのでしょうか？

<a hreflang="en" href="https://github.com/WebAssembly/binaryen">Binaryen</a> スイートの `wasm-opt` は、結果のバイナリのサイズとパフォーマンスの両方を改善することができる強力な最適化ツールです。Emscripten、wasm-pack、AssemblyScriptなどの主要なWebAssemblyツールチェーンで使用され、基礎となるコンパイラが生成するバイナリを最適化するために使用されます。

非圧縮と圧縮の両方の実世界ベンチマークにおいて、大幅なサイズ削減を実現します。

{{ figure_markup(
  caption="`wasm-opt` の非圧縮サイズベンチマーク。",
  description="`base64`、`box2d`、`lua`、`sqlite`、`zlib` など、さまざまな実世界のモジュールにおける `wasm-opt` サイズベンチマークを示す棒グラフです。結果として得られるサイズは、元のサイズの78%から、最悪の場合93%までさまざまである。中央値は89%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=724059342&format=interactive",
  sheets_gid="1763590037",
  image="wasm_opt_bench.png",
  width=600,
  height=615
  )
}}

{{ figure_markup(
  caption="`wasm-opt` + Brotliサイズベンチマーク。",
  description="同じ `wasm-opt` サイズベンチマークを、元のモジュールと結果のWebAssemblyモジュールの両方にBrotli圧縮を適用した場合の棒グラフです。結果は83%から99%の間で変化し、中央値は91%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=2047888306&format=interactive",
  sheets_gid="1763590037",
  image="wasm_opt_br_bench.png",
  width=600,
  height=615
  )
}}

収集したHTTPアーカイブのデータセットでも `wasm-opt` の性能を確認することにしましたが、引っ掛かりがあります。

前述の通り、`wasm-opt`はすでにほとんどのコンパイラツールチェーンで使用されているので、データセット内のモジュールのほとんどはすでにその結果の成果物となっています。上記の圧縮解析とは異なり、既存の最適化を逆にしてオリジナルで `wasm-opt` を実行する方法はありません。その代わりに、最適化前のバイナリに対して `wasm-opt` を再実行することで、結果に歪みを与えています。これは、strip-debugステップの後に生成されたバイナリに対して使用したコマンドです。

```bash
wasm-opt -O -all some.wasm -o some.opt.wasm
```

そして、その結果をBrotliに圧縮して、いつものように前のステップと比較しました。

このデータは実際の使用状況を代表するものではなく、一般消費者は `wasm-opt` を通常通り使用すべきですが、CDNのように最適化を大規模に実行したい消費者や、バイナリエンのチーム自身には有用かもしれません。

{{ figure_markup(
  caption="`wasm-opt` + Brotliの節約。",
  description="修正したデータセットに対して `wasm-opt` + Brotliを実行したときの絶対的なサイズ変化の分布を示す棒グラフです。 結果はまちまちですが、10パーセンタイルではデスクトップとモバイルでそれぞれ26KBと6KBの減少、中央値では4KBと1KBの減少、90パーセンタイルでは1KB以下の小さな改善となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=541095203&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="wasm_opt_br_savings.png"
  )
}}

グラフの結果はまちまちですが、どの変化も26KBまでと比較的小さいものです。もし、外れ値（0と100のパーセンタイル）を含めると、最良側でデスクトップが最大1MB、モバイルが240KB、最悪デスクトップが255KB、モバイルが175KBと、より大幅に改善されることが分かります。

ごく一部のファイルで大幅な節約ができたということは、ウェブで公開する前に最適化されていなかった可能性が高いということです。しかし、なぜ他の結果はこれほどまでにまちまちなのでしょうか？

圧縮しない場合の節約サイズを見てみると、今回のデータセットでも、`wasm-opt`は一貫してファイルサイズをほぼ同じにするか、あるいはさらにサイズをわずかに向上させるケースが多く、最適化されていないファイルでは大きな節約となることがより明らかになります。

{{ figure_markup(
  caption="圧縮されていない `wasm-opt` の節約。",
  description="同じデータセットで `wasm-opt` を実行し、今回はBrotliを使用せずに節約した結果を示す棒グラフです。10パーセンタイルと25パーセンタイルでは、デスクトップとモバイルで0キロバイトの改善、または改善なし、中央値では両方で12キロバイトの改善、90パーセンタイルではデスクトップで約100キロバイト、モバイルで45キロバイトの改善が見られました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=270629181&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="wasm_opt_savings.png"
  )
}}

このことから、圧縮後のグラフに驚くべき分布が見られる理由はいくつか考えられます。

1. 前述の通り、我々のデータセットは実際の `wasm-opt` の使用状況とは異なっており、大半のファイルは `wasm-opt` によってすでに最適化されています。さらに命令の並べ替えを行い非圧縮サイズを少し改善すると、特定のパターンが他のパターンよりも圧縮されやすくなったり、されにくくなったりすることになり、その結果、統計的なノイズが発生することになります。
2. 我々はデフォルトの `wasm-opt` パラメーターを使用していますが、ユーザによっては `wasm-opt` フラグを微調整して、特定のモジュールに対してさらに良い節約を実現しているかもしれません。
3. 前述したように、ネットワーク（圧縮）サイズがすべてではありません。WebAssemblyのバイナリが小さいと、VMでのコンパイルが速く、コンパイル中のメモリ消費量が少なく、コンパイルしたコードを保持するメモリも少なくなる傾向があります。`wasm-opt` はここでバランスを取る必要があり、圧縮されたサイズが、より良い生のサイズを優先して後退することもあります。
4. 最後に、いくつかの回帰は、そのバランスを研究し改善するための貴重な例となる可能性がありそうです。私たちはBinaryenチームに <a hreflang="en" href="https://github.com/WebAssembly/binaryen/issues/4322">それらを報告し</a>、最適化の可能性についてより深く検討できるようにしました。

## 人気のあるインストラクションは何ですか？

ここまでで、Wasmをセクションごとに切り分けたときの中身を垣間見ることができました。ここでは、WebAssemblyモジュールの中でもっとも大きく、もっとも重要な部分であるコードセクションの内容をより深く見ていきましょう。

インストラクションをさまざまなカテゴリーに分け、すべてのモジュールでまとめてカウントしています。

{{ figure_markup(
  caption="インストラクションの種類。",
  description="wasm-statsツールで収集した命令種別の分布を示す円グラフ。ローカル変数の演算が36%、定数15.2%、ロードストア演算14.7%、数学、ロジック、その他の演算が14.3%、コントロールフロー13.3%、ダイレクトコール4.6%、その他は非常に少ない。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1316275499&format=interactive",
  sheets_gid="1402848319",
  sql_file="instruction_kinds.sql",
  image="instruction_kinds.png"
  )
}}

この分布から得られる1つの驚くべきことは、ローカル変数の操作、つまり `local.get`, `local.set`, `local.tee` が最大のカテゴリーで36%を占め、次のカテゴリーであるライン定数 (15.2%), ロード/ストア操作 (14.7%) とすべての数学および論理演算 (14.3%) をはるかに上回っていることです。ローカル変数演算は、通常、コンパイラの最適化パスの結果として生成されます。これは、高価なメモリアクセス操作を可能な限りローカル変数にダウングレードし、その後、エンジンがこれらのローカル変数をCPUレジスタに置くことで、より安価にアクセスできるようにするためです。

Wasmにコンパイルする開発者にとって実用的な情報ではありませんが、エンジンやツールの開発者にとっては、さらなるサイズ最適化の可能性がある領域として興味深いものでしょう。

## MVP後の拡張機能の使い方は？

もう1つ興味深い指標は、MVP後のWasmの拡張性です。WebAssembly 1.0は数年前にリリースされましたが、今でも活発に開発されており、時間の経過とともに新しい機能が追加されて成長しています。これらの中には、共通の操作をエンジンに移すことでコードサイズを改善するもの、より強力なパフォーマンスプリミティブを提供するもの、開発者の体験やウェブとの統合を改善するものなどがあります。公式の <a hreflang="en" href="https://webassembly.org/roadmap/">機能ロードマップ</a> では、人気のあるすべてのエンジンの最新バージョンで、これらの提案のサポートを追跡しています。

Almanacのデータセットでも、その採用状況を見てみよう。

{{ figure_markup(
  caption="MVP後の拡張機能の使用状況。",
  description="総モジュール数とMVP後の各種拡張機能を使用したモジュール数を棒グラフで示したもの。総数については、冒頭で述べたとおり、デスクトップで3,854、モバイルで3,173となっています。このうち、Sign拡張モジュールがデスクトップで2,938件、モバイルで2,137件と多く、目立っている。残りは、グラフにほとんど表示されないほど少ないです。atomics、BigInt imports/exports、bulk memory、SIMD、mutable imports/exportsの各提案は、デスクトップでは最大30モジュール、モバイルでは最大21モジュールにしか見つかりませんでした。複数値、floatからintへの非トラップ変換、参照型、末尾呼び出しなどの提案は、どちらのデータセットでもどのモジュールにも見つかりませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=706910122&format=interactive",
  sheets_gid="1918192673",
  sql_file="proposals.sql",
  image="proposals.png",
  width=600,
  height=542
  )
}}

それは、<a hreflang="en" href="https://github.com/WebAssembly/sign-extension-ops/blob/master/proposals/sign-extension-ops/Overview.md">sign-extension operators proposal</a> という機能です。MVPからそれほど時間が経たないうちにすべてのブラウザに提供され、LLVM（Clang / EmscriptenやRustが使用するコンパイラバックエンド）でもデフォルトで有効になったので、その採用率の高さが理解できます。それ以外の機能は、現在のところ開発者がコンパイル時に明示的に有効にする必要があります。

たとえば、<a hreflang="en" href="https://github.com/WebAssembly/nontrapping-float-to-int-conversions/blob/master/proposals/nontrapping-float-to-int-conversion/Overview.md">non-trapping float-to-int conversions</a> はsign-extension operatorsと非常によく似た精神を持っています。コード サイズを多少節約するために数値型の組み込み変換も提供していますが、つい最近Safari15のリリースで統一的にサポートされました。そのため、この機能はまだデフォルトでは有効になっていません。ほとんどの開発者は、非常に説得力のある理由なしに、異なるブラウザに異なるバージョンのWebAssemblyモジュールを構築して出荷する複雑さを望んでいません。その結果、データセット内のWasmモジュールのどれもが、これらの変換を使用していませんでした。

複数値、参照型、末尾呼び出しなど、使用実績がゼロの機能も同様の状況です。これらはほとんどのWebAssemblyユースケースに恩恵をもたらす可能性がありますが、コンパイラやエンジンのサポートが不完全なためです。

残り、使用されている機能の中で、とくに興味深いのはSIMDとatomicです。どちらも、さまざまなレベルで実行を並列化し、高速化するための命令を提供します。<a hreflang="en" href="https://v8.dev/features/simd">SIMD</a> により、一度に複数の値に対して数学演算を行うことができ、atomicにより <a hreflang="en" href="https://web.dev/webassembly-threads/">Wasmにおけるマルチスレッド</a>の基礎が提供されます。それらの機能はデフォルトでは有効ではなく、特定のユースケースを必要とし、とくにマルチスレッドはソースコードで特別なAPIを使用する必要があり、さらにWebサイトで使用する前 <a hreflang="ja" href="https://web.dev/i18n/ja/coop-coep/">cross-origin isolated</a> にするための追加設定も必要です。そのため、比較的低い利用レベルであることは当然ですが、時間の経過とともに成長していくことが期待されます。

## 結論

WebAssemblyは比較的新しく、Web上ではややニッチな参加者ですが、単純なライブラリから大規模なアプリケーションまで、さまざまなWebサイトやユースケースで採用されているのは素晴らしいことです。

実際、WebAssemblyはWebのエコシステムに非常によく統合されており、多くのWebサイトのオーナーは、WebAssemblyをすでに使っていることにさえ気づかないかもしれませんし、彼らには他のサードパーティのJavaScript依存のように見えます。

提供サイズに改善の余地があり、さらなる分析により、コンパイラやサーバーの設定を変更することで達成可能なようです。また、エンジン、ツール、CDN開発者がWebAssemblyの利用を理解し、規模に応じて最適化するのに役立つかもしれない、いくつかの興味深い統計や事例を発見しています。

Web Almanacの次版では、これらの統計を長期にわたって追跡し、最新情報をお届けする予定です。
