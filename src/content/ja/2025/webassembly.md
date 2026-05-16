---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: 2025年版Web AlmanacのWebAssemblyチャプター。使用状況、言語、MVP以降の機能を網羅。
hero_alt: Web Almanacのキャラクターたちが様々なコードシンボルに科学実験を行い、反対側から1と0が出てくるヒーロー画像。
authors: [nimeshgit]
reviewers: [nrllh, tunetheweb]
analysts: [nimeshgit]
editors: [tunetheweb]
translators: [ksakae1216]
nimeshgit_bio: NimeshはAI・MLアナリティクス、オペレーション、ビジネスプロセスに焦点を当て、デジタルトランスフォーメーションと自動化ソリューションを提供しています。
results: https://docs.google.com/spreadsheets/d/16z2MNwq8FFbuNYcJJZceML6rB5VAmBXNNHZy5FZuf8g/edit
featured_quote: WebAssemblyはもはや単なる「ウェブ」技術ではなく、高性能でユニバーサルなバイトコードフォーマットへと進化しています。
featured_stat_1: 0.35%
featured_stat_label_1: WebAssemblyを使用しているデスクトップサイト。
featured_stat_2: 228 MB
featured_stat_label_2: 検出された最大のWebAssemblyファイル。
featured_stat_3: 2.05%
featured_stat_label_3: トップ1,000のWebAssemblyを使用しているデスクトップサイト。
doi: 10.5281/zenodo.18258991
---

## はじめに

WebAssembly（Wasm）は、ウェブ中心の最適化ツールから高性能なユニバーサルバイトコードフォーマットへと進化しました。<a hreflang="en" href="https://www.w3.org/TR/2019/REC-wasm-core-1-20191205/">2019年にW3C標準として正式に採用され</a>、2025年12月の<a hreflang="en" href="https://webassembly.github.io/spec/core/">Wasm Version 3.0のリリース</a>でエコシステムは技術的な転換点を迎えました。このバージョンはガベージコレクション、64ビットアドレス空間、Multiple Memoriesなどの<a hreflang="en" href="https://webassembly.github.io/spec/core/">高度な機能</a>を標準化しており、Java、Kotlin、DartなどのハイレベルなLanguageがブラウザとスタンドアロン環境の両方でネイティブかつ効率的に動作することを可能にしています。

## 方法論

WebAssemblyが初めて紹介された[2021年版Web Almanac](../2021/webassembly#方法論)と同じ方法論に従っています。

**データ収集:** 本章は、Google BigQueryにホストされているHTTP Archiveの2025年7月クロールデータを利用して、`Content-Type`（`application/wasm`）と`.wasm`ファイル拡張子を照合することでWebAssemblyモジュールを特定しています。この方法で、43,000サイトで少なくとも1つのWebAssemblyモジュールを発見し、分析した全サイトの0.35%を占めています。

**分析:** HTTP Archiveデータセットに加えて、HTTP Archiveから特定されたWebAssemblyモジュールをダウンロードして検証するツール<a hreflang="en" href="https://github.com/nimeshgit/almanac-wasm-stats">`almanac-wasm-stats`</a>をローカル分析に使用しています。このツールはダウンロードしたファイルからメタデータを抽出し、Wasmモジュール内で使用されているプログラミング言語、ライブラリ、特定の機能を特定することを可能にします。

**制限事項:** `almanac-wasm-stats`ツールはWasmモジュールの静的解析に焦点を当てており、実行はしません。そのため、ブラウザやスタンドアロン環境での実際の実行中に存在する可能性のある動的な動作やランタイム機能を捉えることができません。また、一部のWasmモジュールは難読化またはminify化されている場合があり、その特性を正確に特定する能力が制限される可能性があります。
言語使用分析に役立つ以下の機能を([wasm-stats](https://github.com/HTTPArchive/wasm-stats))を拡張してalmanac-wasm-statsに実装しました。

  1. URLと対応するユーザーエージェント文字列を入力として受け取ることで、ダウンロードタスクを改善します。
  2. BigQueryのJSONL結果形式で大量の入力を受け付けます。
  3. Binary ToolkitでWasmを検証し、統計改善に役立つインサイトを提供します（wasm2wat参照）。
  4. Wasmファイルのダウンロード、検証、統計収集などのタスクを並行して実行・追跡します。
  5. 古いRust実装（[`wasm-stats`](https://github.com/HTTPArchive/wasm-stats)）の言語識別子を拡張し、Scala、Dotnet/Mono、Go & TinyGo、TeaVMベースの言語、Kotlinを新たに追加。これにより「Unknown」の数が減少し、言語統計が改善されます。
  6. 検証とダウンロードの失敗とともに、完全なWasm言語使用統計を生成します。
  7. 将来の拡張に向けて、既存のJSON統計形式でWebAssembly Toolkit / SDKを使用した新しい統計を導入できるプラグアンドプレイアーキテクチャを採用しています。

## WebAssemblyの使用状況

このセクションでは、ウェブにおけるWebAssemblyの使用状況に関する結果を紹介します。

### 年次トレンド

{{ figure_markup(
  image="usage-trends.png",
  caption="WebAssemblyの使用トレンド",
  description="数年間の急成長後のWebAssembly使用状況を示す棒グラフ。2024年から2025年の間に、WebAssemblyを使用するデスクトップサイトの割合が0.36%から0.35%へわずかに減少した一方、モバイルの使用率は0.28%で横ばいでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=729417371&format=interactive",
  sql_file="counts.sql",
  sheets_gid="540023407"
  )
}}

WebAssemblyの採用は2021年の0.04%から成長していますが、直近2年間は一定の水準を維持しています。2025年には、デスクトップサイトの0.35%、モバイルサイトの0.28%でWebAssemblyモジュールを確認し、約43,000サイトに相当します。また、観測された全ての年でモバイルの採用率はデスクトップより低く、平均30%の差があります。

### ランク別WebAssembly

{{ figure_markup(
  image="webassembly-by-rank.png",
  caption="WebAssembly使用サイトのランク",
  description="デスクトップとモバイルのクライアントリクエストにおける1,000、10,000、100,000、1,000,000、10,000,000、全体のページランクグループの分布を示す棒グラフ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1476075550&format=interactive",
  sql_file="ranking.sql",
  sheets_gid="1733811663"
  )
}}

サイトの人気度とWebAssemblyの採用には強い相関関係があります。使用はトップ1,000サイトに最も集中しており、デスクトップで2%、モバイルで1.27%に達しています。これらのトップクラスのサイトは、Wasmが提供する高いパフォーマンスを必要とするデザインツールや重いメディアエディターなどの複雑なアプリケーションを頻繁にホストしています。

サイトのランクが下がるにつれて採用率も低下し、一貫した分布パターンに従っています。トップ1,000万サイト外では、採用率はデスクトップで約0.33%、モバイルで0.28%です。

トップランクグループではデスクトップの使用率が高いままですが、ロングテールではその差が大幅に縮まっており、ウェブの大多数においてWebAssemblyは特定の環境に限定されるのではなく、クロスプラットフォームリソースとして展開されていることを示しています。

## WebAssemblyのリクエスト

{{ figure_markup(
  image="number-of-wasm-requests.png",
  caption="Wasmリクエスト数",
  description="両クライアントにおけるWasm合計、ユニークなWasmファイル、モジュール別のユニークなレスポンスを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=74534440&format=interactive",
  sql_file="counts.sql",
  sheets_gid="540023407"
  )
}}

全体で、デスクトップで303,496件、モバイルで308,971件のWebAssemblyリクエストを記録しました。デスクトップサイトの方がWebAssemblyを多く利用していますが、リクエストの総量はモバイルがわずかに多くなっています。

さらに、デスクトップで157,967個、モバイルで165,870個のユニークなURLを特定しました。ユニークなバイナリ数を推定するために、同一のファイル名とレスポンスサイズでモジュールをグループ化しました。この方法で、デスクトップで87,596個、モバイルで84,851個のユニークなWasmモジュールが見つかりました。これらの結果は、名前ベースで約72%のWebAssemblyリクエストが重複モジュールを提供していることを示しており、ウェブ全体でのライブラリの大規模な再利用を浮き彫りにしています。

### MIMEタイプ

{{ figure_markup(
  image="top-mime-types.png",
  caption="上位MIMEタイプ",
  description="両クライアントにおけるMIMEタイプとWasmリクエストの割合を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1325615855&format=interactive",
  sql_file="mime_types.sql",
  sheets_gid="1706394885",
  width="600",
  height="430"
  )
}}

`application/wasm` MIMEタイプはデスクトップで293,470件、モバイルで301,127件のリクエストで確認されました。MIMEタイプが欠落または不正確（`text/html`や`text/plain`など）なケースは少なく、デスクトップで3.2%、モバイルで2.4%のリクエストに影響していました。これらは2021年と比較して大幅に減少しており、適切なサーバー設定への意識と遵守が向上していることを示しています。

### モジュールサイズ

WebAssemblyモジュールのサイズは使用ケースによって大きく異なります。下位50%のモジュールは2KBから14KBの範囲で非常に小さいことが確認されました。これらは通常、JavaScriptが精度に欠けるパフォーマンスクリティカルなタスクを処理するために、AssemblyScriptやRustで書かれたBase64エンコーダーやチェックサム計算機などの「マイクロユーティリティ」です。

一方、90パーセンタイルではサイズがデスクトップで381KB、モバイルで316KBへと大幅に増加します。これらの大きなバイナリは通常、複雑な3Dレンダリングやロジックを処理するためにC++やC#などの重い言語からコンパイルされた、Adobe PhotoshopやGoogle Earthなどのフルデスクトップグレードのアプリケーションをウェブに移植したものです。

{{ figure_markup(
  image="raw-response-sizes.png",
  caption="生のレスポンスサイズ。",
  description="様々なパーセンタイルにわたるキロバイト単位でのデスクトップとモバイルプラットフォームにおけるWebAssembly（Wasm）の生レスポンスサイズの分布を示す棒グラフ。低パーセンタイルと中央値では、ファイルサイズは同一で非常に小さく、10パーセンタイルでわずか2KBから始まり、両プラットフォームで50パーセンタイルで14KBに達します。ただし、90パーセンタイルで大きな乖離が生じ、デスクトップのレスポンスサイズがモバイルの316KBに対して381KBに達します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=658325543&format=interactive",
  sql_file="module_sizes.sql",
  sheets_gid="241152503"
  )
}}

上記のグラフはレスポンスボディのサイズを示しており、「生のレスポンスサイズ」と呼ばれ、クライアントが受信したデータペイロードのデコード済みの生データのみを測定します。リソース自体のサイズを表しています。ただし、Wasmの成果物に関する研究と一般的な慣行によると、WasmモジュールはBrotliなどの様々なツールで圧縮・最適化され、Content-Encodingヘッダーとともにgzip、br、zstdなどの圧縮方法でネットワーク経由でクライアントに転送されます。

{{ figure_markup(
  image="compression-methods-desktop-client.png",
  caption="デスクトップクライアントで使用される圧縮方法",
  description="br、gzip、zstdの圧縮方法とaws_chunkedのレコードを示す円グラフ。デスクトップクライアントではWasmが'br'圧縮方法で78.1%、gzip圧縮方法が17.9%、zstd圧縮方法が3.9%で広く転送されていることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1275607668&format=interactive",
  sql_file="compression_methods.sql",
  sheets_gid="241152503"
  )
}}

{{ figure_markup(
  image="compression-methods-mobile-client.png",
  caption="モバイルクライアントで使用される圧縮方法",
  description="br、gzip、zstdの圧縮方法とaws_chunkedのレコードを示す円グラフ。モバイルクライアントではWasmが'br'圧縮方法で80.1%、gzip圧縮方法が17.9%、zstd圧縮方法が3.9%で広く転送されていることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1994486126&format=interactive",
  sql_file="compression_methods.sql",
  sheets_gid="241152503"
  )
}}

興味深いことに、過去数年間の様々なコミュニティによる[パフォーマンスベンチマーク](https://facebook.github.io/zstd/#benchmarks)活動を見ると、'br'と'zstd'の圧縮方法への認知が高まっており、開発者やCDNプロバイダーによる継続的な進化と採用が見られます。

{{ figure_markup(
  caption="検出された最大のWebAssemblyファイル（デスクトップ）。",
  content="234 MB",
  classes="big-number",
  sheets_gid="241152503",
  sql_file="module_sizes.sql"
  )
}}

{{ figure_markup(
  caption="検出された最大のWebAssemblyファイル（モバイル）。",
  content="170 MB",
  classes="big-number",
  sheets_gid="241152503",
  sql_file="module_sizes.sql"
  )
}}

これらの標準的な分布を超えて、データセットには重要な外れ値が含まれています。特定された最大の単一WebAssemblyモジュールは、デスクトップで234MB、モバイルで170MBを記録しており、大規模なクライアントサイドアプリケーションが展開されていることを示しています。

興味深いことに、JSの成果物がMBサイズであることが多いのに対し、Wasmの成果物がかなり小さいサイズである理由は、JSが人間が読める高レベルのソースコードであるのに対し、バイトコードはマシンに依存しないコードの低レベルな中間表現であるからです。

Google V8のような現代のJSエンジンは、実行プロセスの一部としてJSソースコードを内部的にバイトコードに変換しています。これはバイトコードのJSに比べた小さなサイズでの効率性を示しています。

## WebAssemblyライブラリ

次に、エコシステムで最も人気のある基盤となるライブラリとフレームワークを理解するために、WebAssemblyバイナリ内のインポート名を分析します。

{{ figure_markup(
  image="popular-webAssembly-libraries.png",
  caption="人気のWebAssemblyライブラリ。",
  description="デスクトップとモバイルのデータセットで人気のあるライブラリを1つのグラフにまとめた棒グラフ。各ライブラリとそれに起因するWasmリクエストの割合が示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1063093178&format=interactive",
  sql_file="popular_library_by_name.sql",
  sheets_gid="1181339291",
  width="600",
  height="596"
  )
}}

WebAssemblyモジュールで最も使用されているライブラリやフレームワークは、System（43%）、<a hreflang="en" href=" https://learn.microsoft.com/en-us/aspnet/core/blazor/webassembly-build-tools-and-aot?view=aspnetcore-10.0">Microsoft</a>（23%）、RXEngine（6%）、<a hreflang="en" href="https://devblogs.microsoft.com/dotnet/extending-web-assembly-to-the-cloud/">Dotnet</a>（6%）であり、特にDotnetと<a hreflang="en" href="https://learn.microsoft.com/en-us/aspnet/core/blazor/hosting-models?view=aspnetcore-10.0#blazor-webassembly">Blazor</a>フレームワークによって牽引されるMicrosoftのエコシステムの優位性を示しています。

MicrosoftはSystemユーティリティ、Identity、ネットワーキング、ストレージ、JSONなど、多数の再利用可能なライブラリ向けに様々なWebAssemblyライブラリとフレームワークを持っています。それらのライブラリとフレームワークを組み合わせることで、WebAssemblyにおけるMicrosoftエコシステムはデスクトップで78.8%、モバイルクライアントで79.3%をカバーしています。

## WebAssembly言語

WebAssemblyはC++、C#、Rubyなど様々な言語で開発できます。Wasm 3.0の導入により、Java、Scala、Kotlin、Dartなどのサポート言語の範囲が拡大しました。このセクションでは、WebAssemblyモジュールの開発に使用されている言語の概要を説明します。

{{ figure_markup(
  image="language-usage.png",
  caption="WebAssembly言語の使用状況。",
  description="不明（デスクトップ40.5%、モバイル45.5%）、.Net Monoベースの言語（36.8%と35.2%）、LikelyEmscripten（8.8%と6.7%）、Scala（3.6%と3.4%）、Blazor（4.9%と3.5%）、Rust（1.5%と2.2%）、AssemblyScript（2.4%と2.3%）、Emscripten（1.3%と1.1%）、Go/TinyGo（〜0.1%と〜0.1%）、TeaVMベースの言語（〜0.1%と〜0.1%）",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1492105065&format=interactive",
  sql_file="language_usage.sql",
  sheets_gid="101432539",
  width="600",
  height="422"
  )
}}

ツールはデスクトップで64.3%、モバイルで72.8%のWebAssemblyモジュールのソース言語を正常に特定しました。残りの（35.7%と27.2%）は、主にminify化（メタデータの除去）、WebAssemblyの検証またはダウンロードの失敗により特定できませんでした。

特定された言語の中では、.NET/Mono + Blazorが最も一般的で、デスクトップで41.7%、モバイルで38.7%のシェアを持っています。minify化されたエクスポート/インポート名はソース言語を不明瞭にすることが多いですが、Emscripten（C++）ツールチェーンは独自の命名規則を使用しています。これにより確信を持ってこれらのモジュールを帰属させることができ、Emscriptenがデスクトップで10.1%、モバイルで7.8%を占め、Scalaがデスクトップで3.6%、モバイルで3.4%という結果が得られました。

ライブラリ使用に関する調査結果と合わせると、これらの結果はWebAssemblyの領域におけるMicrosoftエコシステムの圧倒的な優位性を強調しています。

## WebAssembly機能

このセクションでは、MVP後（Minimum Viable Product以降）のWebAssembly機能の使用状況を分析します。ここで取り上げる機能はWebAssemblyが<a hreflang="en" href="https://webassembly.org/features/">サポートする</a>全機能を網羅していないことを認識していますが、これらの機能の採用状況を強調することは重要だと考えています。読者の方々には、将来的により多くの機能を追跡できるよう、本章で使用した分析ツールへの貢献をお願いします。

{{ figure_markup(
  image="extensions-usage.png",
  caption="MVP後の拡張機能の使用状況。",
  description="様々なMVP後の拡張機能を使用するモジュール数とともにモジュールの総数を示す棒グラフ。記事の冒頭で述べた通り、総数はデスクトップで233,857、モバイルで255,060です。符号拡張演算が際立っており、デスクトップで45,969、モバイルで50,394という多くのモジュールで見つかりました。バルクメモリはデスクトップで187,674、モバイルで204,103です。その他はグラフにほとんど表示されないほど低い数値です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1868040845&format=interactive",
  sql_file="proposals.sql",
  sheets_gid="111956915"
  )
}}

バルクメモリが最も広く採用されている機能で、デスクトップで187,674、モバイルで204,103のモジュールに登場しています。この機能は大きなメモリブロックの効率的なコピーと初期化を可能にすることでパフォーマンスを向上させ、CのネイティブなmemcpyFunction の効率を模倣しています。さらに、符号拡張（8ビット整数から32ビットへの拡張など、整数値を拡張する演算子を提供する）が2番目に人気の機能で、デスクトップで45,969、モバイルで50,394のモジュールで確認されました。

## 結論

WebAssemblyの採用は過去4年間で大幅に増加し、2021年の0.04%から2025年の0.35%へと上昇しましたが、直近2年間では成長が安定しています。使用は高ランクのウェブサイトで最も多く、人気の低いページでは大幅に減少します。WebAssemblyは現在、特定のユーティリティ機能（暗号化やチェックサムなど）の処理と、完全なスタンドアロンアプリケーションの駆動という2つの異なる目的で展開されています。さらに、調査結果はMicrosoftのフレームワークの広範な採用を示しており、現在のWebAssemblyエコシステムを牽引するうえでの重要な役割を示しています。

Wasm仕様の大きな進展とコミュニティからの関心の高まりを考慮すると、WebAssemblyの採用は今後さらに増加すると考えています。
