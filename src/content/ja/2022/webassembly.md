---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: 2022年版Web AlmanacのWebAssemblyの章では、使用方法、言語、MVP後の機能などを取り上げています。
hero_alt: Hero image of Web Almanac chracters performing scientific experiments on various code symbols resulting in 1's and 0's coming out the other end.
authors: [ColinEberhardt]
reviewers: [binji, RReverser]
analysts: [JamieWhitMac]
editors: [tunetheweb]
translators: [ksakae1216]
ColinEberhardt_bio: <a hreflang="en" href="https://www.scottlogic.com/">Scott Logic</a>のCTOであり、様々な技術に関する著者、ブロガー、講演者として活躍しています。また、<a hreflang="en" href="https://www.finos.org/">FINOS</a>のボードメンバーであり、金融分野におけるオープンソースのコラボレーションを奨励しています。また、GitHubで非常に活発に活動しており、さまざまなプロジェクトに貢献しています。
results: https://docs.google.com/spreadsheets/d/11jyABro0fKtuN6INnYP9pJlv5QWwp0jfJyTsGfKgScg/
featured_quote: ニッチな技術であるにもかかわらず、WebAssemblyはすでにWebに価値を与えています。この技術から大きな恩恵を受けるウェブアプリケーションは数多くあります。
featured_stat_1: 383
featured_stat_label_1: ユニークなWebAssemblyバイナリを発見
featured_stat_2: 34.9%
featured_stat_label_2: Amazon IVSを利用したモバイルサイト
featured_stat_3: 72.8%
featured_stat_label_3: Emscriptenを使用したモジュール
---

## 序章

WebAssemblyまたはWasmは、2019年12月に公式に認められたW3C標準となり、Web技術のファミリー（JavaScript、HTML、CSS）の中では比較的新しい存在です。

WebAssemblyはブラウザに新しいランタイムを導入し、JavaScriptランタイムと一緒に、そして密接に連携して動作する。WebAssemblyは、小さな命令セットと厳格な分離モデル（WebAssemblyはデフォルトでI/Oを持たない）を持ち、比較的に軽量です。WebAssemblyを開発する主な動機の1つは、幅広いプログラミング言語（C++、Rust、Goなど）用のコンパイルターゲットを提供し、開発者がより広いツールセットで新しいWebアプリケーションを書いたり、既存のアプリケーションを移植したりできるようにすることでした。

WebAssemblyの有名な例としては、<a hreflang="en" href="https://blog.chromium.org/2019/06/webassembly-brings-google-earth-to-more.html">Google Earth</a> の中で使用されており、C++ デスクトップ アプリケーションがブラウザ内で利用できるようになっています。<a hreflang="en" href="https://www.figma.com/blog/webassembly-cut-figmas-load-time-by-3x/">Figma</a> はこの技術を使って大幅にパフォーマンスを改善したブラウザベースのデザイン ツールで、最近では <a hreflang="en" href="https://web.dev/ps-on-the-web/">Photoshop</a> が同様の理由でWebAssemblyを使っていました。

## 方法論

WebAssemblyはコンパイル対象であり、バイナリモジュールとして配布されています。そのため、Web上での利用状況を分析する際には、さまざまな課題に直面します。WebAssemblyを含む最初の版である2021年版Web Almanacでは、[使用した方法論の詳細なセクション](../2021/webassembly#方法論)、および関連する注意事項が含まれています。2022年版のここでの調査結果は、同じ方法論に従ったものです。追加された唯一の強化点は、WebAssemblyモジュールのオーサリングに使用された言語を判定するメカニズムです。その解析の精度については、それぞれの項目で詳しく取り上げています。

## WebAssemblyはどの程度使われているのですか？

デスクトップで3,204件、モバイルで2,777件のWebAssemblyリクエストが確認されました。これらのモジュールは、デスクトップでは2,524ドメイン、モバイルでは2,216ドメインで使用されており、デスクトップとモバイルの全ドメインの0.06%と0.04%に相当します。

これは、クロールで発見したモジュールの数が控えめに減少したことを表しており、デスクトップで16％、モバイルで12％の減少となっています。これは必ずしもWebAssemblyが衰退していることを意味するものではなく、この変化を解釈する場合、以下の点に注意する必要があります。

- WebAssemblyを使用してあらゆる種類のWebベースのコンテンツを作成できますが、その主な利点は、大規模なコードベースを持つより複雑な業務用アプリケーションで、何年も前のものであることが多いです（例：Google Earth、Photoshop、AutoCADなど）。これらのWeb「アプリ」は、Webサイトほど多くはなく、WebAssemblyがあまり普及していないホームページを主な対象とするAlmanacのクロールでは常に利用できるわけではありません。
- 後のセクションで見るように、私たちが見るWebAssemblyの使用の多くは、比較的少数のサードパーティライブラリから来るものです。その結果、これらのライブラリのどれか1つでも小さな変更があれば、見つかるモジュールの数に大きな影響を与えることになります。

モバイルブラウザに提供されたWebAssemblyモジュールがわずかに少ない（-13％）ことがわかりました。これは、一般的に優れたサポートを持つモバイルブラウザのWebAssembly能力を反映しているわけではありません。むしろ、[プログレッシブ・エンハンスメント](https://developer.mozilla.org/ja/docs/Glossary/Progressive_Enhancement)の標準的な実践によるものと思われます。この場合、WebAssemblyを必要とするより高度な機能は、モバイルユーザーにはサポートされていません。

{{ figure_markup(
  caption="Wasmの対応数。",
  description="デスクトップとモバイルのデータセットにおけるWasmの総回答数、およびユニークファイル数を示す棒グラフ。ユニークファイル数は、デスクトップでは全回答数3,204件のうち383件、モバイルでは2,777件のうち310件と、かなり少なくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1842699031&format=interactive",
  sheets_gid="2142789475",
  sql_file="counts.sql",
  image="counts.png"
  )
}}

WebAssemblyのモジュールをハッシュ化することで、デスクトップ用の3,204個のモジュールのうち、いくつがユニークなモジュールなのかを特定できます。モジュールの重複を排除することで、総数はおよそ10分の1になり、ユニークなモジュールはデスクトップブラウザに383個、モバイルに310個提供されています。これは、異なるウェブサイトが同じWebAssemblyコードを利用し、おそらく共有モジュールによって再利用されていることを意味します。

wasmリクエストのかなりの割合がクロスオリジンであり、再利用されているという考えをさらに強めています。とくに、これは昨年から大幅に増加しています（67.2％対55.2％）。

{{ figure_markup(
  caption="クロスオリジンのWebAssembly使用。",
  description="デスクトップにおけるWebAssemblyの使用率の67.2％、モバイルにおける使用率の60.9％がクロスオリジンであることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=2039142493&format=interactive",
  sheets_gid="491240617",
  sql_file="cross_domain.sql",
  image="cross_domain.png"
  )
}}

これらのWebAssemblyモジュールは、サイズがかなり異なっており、小さいものでは数キロバイト、大きいものでは7.3メガバイトになります。さらに詳しく、解凍後のサイズを見ると、中央値（50パーセンタイル）は835KBytesであることがわかります。

もっとも小さなWebAssemblyモジュールは、たとえばブラウザの機能を満たすポリフィリングや、簡単な暗号化タスクなど、非常に特定の機能のために使用されていると思われます。より大きなモジュールは、WebAssemblyにコンパイルされたアプリケーション全体であると考えられます。

{{ figure_markup(
  caption="非圧縮のレスポンスサイズ。",
  description="デスクトップとモバイルの非圧縮レスポンスサイズの分布をパーセンタイル25、50、75、90で示した棒グラフです。もっとも注目すべきは、10パーセンタイルで23KB、中央値で約835KB、90パーセンタイルでデスクトップが4.87MB、モバイルが3.24MBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=736723663&format=interactive",
  sheets_gid="1169986524",
  sql_file="module_sizes.sql",
  image="uncompressed_resp_sizes.png"
  )
}}

WebAssemblyが広く使われていないのは明らかで、使用量が増えるどころか、緩やかに縮小しているのがわかります。

## WebAssemblyは何に使われているのですか？

{{ figure_markup(
  caption="WebAssemblyの人気ライブラリ。",
  description="デスクトップとモバイルのデータセットにおける上位10ライブラリを1つのグラフに統合した棒グラフです。各ライブラリは、そのライブラリに起因するWasmリクエストの割合と一緒に表示されています。リストは以下の通りです： Amazon IVS（デスクトップ33.5%、モバイル34.9%）、Hyphenopoly（8.2%、12.1%）、Blazor（6.2%、8.5%）、ArcGIS（6.7%、6.0%）、CanvasKit（7.7%、2.7%）、Tableau（5.2% と3.0%）、Draco（3.2%と3.1%）、Xat（1.6%と1.5%）およびHewlett Packard Enterprise（HPE）（1.6%と0.8%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1535512737&format=interactive",
  sheets_gid="721946887",
  sql_file="popular_by_name.sql",
  image="popular_by_name.png"
  )
}}

- <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon IVS（Amazonインタラクティブビデオサービス）</a> - ここでは、WebAssemblyがビデオコーデックとして使用されていると思われ、ユーザーのブラウザのコーデックサポートに依存しない一貫したビデオデコードを可能にしています。
- <a hreflang="en" href="https://mnater.github.io/Hyphenopoly/">Hyphenopoly</a> - CSSハイフネーション用のポリフィルを提供するnpmモジュールです。コアとなるアルゴリズムはWebAssemblyモジュールとして出荷され、小さなフットプリントと一貫したパフォーマンスを提供します。
- <a hreflang="en" href="https://dotnet.microsoft.com/en-us/apps/aspnet/web-apps/blazor">Blazor</a> - Microsoft Blazorは、.NETプラットフォームとC#を使用したWebアプリケーションの開発を支援するプラットフォーム・ランタイム・UIライブラリです。
- <a hreflang="en" href="https://developers.arcgis.com/javascript/latest/">ArcGIS</a> - インタラクティブなマッピングアプリケーションを構築するための包括的なツール群です。ArcGISチームにとってパフォーマンスは最大の関心事であり、これを実現するためにWebGLなどのさまざまな技術を採用しています。とくに、WebAssemblyは、高速なクライアントサイドプロジェクションを可能にするために使用されています。
- <a hreflang="en" href="https://skia.org/docs/user/modules/canvaskit/">CanvasKit</a> - このライブラリは、標準のCanvas2D APIよりも高度な機能を提供します。C++で書かれたグラフィックライブラリSkiaで実装されており、WebAssemblyにコンパイルされているため、ブラウザ上で実行できます。
- <a hreflang="en" href="https://www.tableau.com/">Tableau</a> - インタラクティブなビジュアライゼーションを構築するための一般的なツールです。WebAssemblyが同社の主力製品の一部として使用されているのか、それともクロールの一部として発見された特定のダッシュボードに使用されているだけなのかは明らかではありません。
- <a hreflang="en" href="https://google.github.io/draco/">Draco</a> - 3次元幾何学メッシュや点群を圧縮・伸張するためのライブラリです。C++で書かれており、WebAssembyの構築により、ブラウザ内で使用できます。
- <a hreflang="en" href="https://xat.com/">Xat</a> - 某ソーシャルメディアサイト。WebAssemblyを何に使っているのかは不明です。
- <a hreflang="en" href="https://www.hpe.com/us/en/home.html">Hewlett Packard Enterprise</a> - 何のためにWebAssemblyを使っているのかが不明です。

人気のあるWebAssemblyライブラリを見ると、その用途はかなり限定的で特定の数値計算タスクに使用されたり、大規模で成熟したC++コードベースを活用して、JavaScriptに移植する必要なくその機能をWebに持ち込むことが多いことがわかります。

## 人々はどのような言語を使っているのでしょうか？

WebAssemblyはバイナリ形式であるため、プログラミング言語、アプリケーション構造、変数名など、ソースの情報の多くが難読化されるか、コンパイル過程で完全に失われます。

しかし、モジュールはしばしばエクスポートとインポートを持ち、それはホスト環境（ブラウザ内のJavaScriptランタイム）内の関数を名付け、モジュールのインターフェイスを記述します。ほとんどのWebAssemblyツールチェーンは、JavaScriptアプリケーションにモジュールを統合することを容易にする「バインド」の目的のために、少量のJavaScriptコードを作成します。これらのバインディングは、モジュールのエクスポートまたはインポートに存在する認識可能な関数名を持つことが多く、モジュールを作成するために使用された言語を識別するための信頼できるメカニズムを提供します。

WebAssembly特有の解析をクローラーに提供する <a hreflang="en" href="https://github.com/HTTPArchive/wasm-stats">wasm-stats</a> プロジェクトを強化し、エクスポート/インポートを検査して、特定のモジュールを作成するために使用される言語を示す共通のパターンを識別するコードを追加しました。例として、あるモジュールが `wbindgen` という名前のモジュールをインポートした場合、これは <a hreflang="en" href="https://crates.io/crates/wasm-bindgen">wasm-bindgen</a> によって生成されたコードへの参照であり、そのモジュールがRustで書かれたことを明確に示す指標となります。

また、export/import名が縮小されており、ソース言語の特定が困難な場合もある。しかし、Emscripten（C++ツールチェイン）は、短縮名に対して特徴的な規約を持っており、このパターンを示すモジュールはEmscriptenを使用して生成されたと比較的確信できます。

{{ figure_markup(
  caption="WebAssembly言語の使用法。",
  description="LikelyEmscripten（デスクトップ：63.8%、モバイル：61.1%）、Unknown（11.7%、16.9%）、Emscripten（13.3%、11.8%）、Rust（8.0%、6.0%）、Blazor（2.7%、3.5%）、Go（0.6%、0.7%）となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1942715596&format=interactive",
  sheets_gid="915015663",
  sql_file="language_usage.sql",
  image="language_usage.png"
  )
}}

その結果、デスクトップでは、72.8%のモジュールがEmscriptenで作成されている可能性が高く、その結果、C++で書かれている可能性が高いことが判明しました。次に多いのはRustで6.0％、Blazor（C#）で3.5％です。また、Goで書かれたモジュールも少数ながら見受けられました。

特筆すべきは、16.9%のモジュールが識別可能な言語を持っていなかったことです。<a hreflang="en" href="https://www.assemblyscript.org/">AssemblyScript</a> は、人気のあるWebAssembly固有の言語ですが、生成されるモジュールには明らかな手がかりがありません。全モジュールの8.2%を占めるHypehnopolyがAssemblyScriptを使用していることが分かっており、これらの「未確認」モジュールのほぼ半分を占めています。

これらの結果を、<a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">WebAssemblyの現状2022年調査</a>で、Rustがもっとも頻繁に使用されていた言語と対比すると興味深いです。しかし、その調査では、かなりの数の回答者が、ブラウザベースのアプリケーション以外にWebAssemblyを使用していました。

## どのような機能が使われているのでしょうか？

WebAssemblyの最初のリリースは、MVPとみなされました。他のWeb標準と同様に、World Wide Web Consortium（W3C）のガバナンスのもと、継続的に進化しています。今年は、<a hreflang="en" href="https://www.w3.org/TR/wasm-core-2/">WebAssembly v2ドラフト</a>の発表があり、多くの新機能が追加されました。

{{ figure_markup(
  caption="MVP後の拡張子の使用状況。",
  description="総モジュール数と、MVP後の各種拡張機能を使用したモジュール数を示す棒グラフ。総数としては、冒頭で述べたように、デスクトップが3,204件、モバイルが2,777件となっています。その中でも、サイン拡張機能が目立ち、デスクトップで2,850件、モバイルで2,378件と多く見受けられました。それ以外は、グラフにほとんど表示されないほど低い値です。atomics、BigIntのインポート/エクスポート、バルクメモリー、SIMD、ミュータブルインポート/エクスポートの各提案は、デスクトップでは最大38モジュール、モバイルでは最大28モジュールにしか見つかりませんでした。多値、トラップしないfloat-int変換、参照型、テールコールのような提案は、どちらのデータセットでもどのモジュールでも見つかりませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1935172150&format=interactive",
  sheets_gid="1865524955",
  sql_file="proposals.sql",
  image="proposals.png"
  )
}}

使用されているPost-MVPの機能を調べたところ、 _符号拡張（整数値をより深くビット拡張するための演算子を追加する比較的簡単な機能拡張）_ が圧倒的に多く使用されていることがわかりました。これは、[昨年の分析結果と大きな違いはありません](../2021/webassembly#MVP後の拡張機能の使い方は？)。

とくに、Web開発者がHTML/JavaScript/CSSのどの機能を使うかの選択に迫られるのに対し、WebAssemblyではツールチェーンの開発者が決定することが多いのです。その結果、あるツールチェーンがPost-MVP機能を実行可能なオプションと判断した場合、Post-MVP機能の採用が急増することが予想されます。

## 結論

WebAssemblyは、Webに関しては紛れもなくニッチな技術であり、今後もそうである可能性が非常に高いです。WebAssemblyは、C++、Rust、Go、AssemblyScript、C#など、さまざまな言語をWebに導入してきましたが、これらはまだJavaScriptと同じように使うことはできません。Webサイトの大部分は、コンテンツが比較的静的で（HTMLでCSSでレンダリングされ）、（JavaScriptで）適度なインタラクティブ性があるため、現時点ではWebAssemblyを使用する説得力のある理由はない。

将来的にこれを変える可能性のある重要な提案がいくつかあります。当初はWebIDLで、これはインターフェイスの種類に取って代わられましたが、再びコンポーネントモデル仕様に取って代わられることになりました。これらにより、将来的にはJavaScriptを他のプログラミング言語と簡単に交換できるようになるかもしれませんが、今のところはそうではありません。

ニッチな技術であるにもかかわらず、WebAssemblyはすでにWebに価値を与えています。この技術から大きな利益を得ているWebアプリケーションは数多くあります。しかし、Webアプリケーションは、この研究の基礎となる「クロール」からは見えないことが多い。

最後に、WebAssemblyランタイムのコア機能である多言語、軽量、セキュアは、より幅広い非ブラウザ アプリケーションのための一般的な選択肢となっています。<a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">WebAssemblyの現状2022年調査</a>では、サーバーレス、コンテナー化、プラグインアプリケーションにこの技術を使用する人の数が大幅に増加したことが示されています。WebAssemblyの将来は、ニッチなWeb技術としてではなく、他の幅広いプラットフォームで完全に主流となるランタイムとしてかもしれません。
