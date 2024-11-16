---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
#TODO - Review and update chapter description
description: 2022年版Web AlmanacのJavaScriptの章では、Web上でのJavaScriptの使用方法、ライブラリとフレームワーク、圧縮、Webコンポーネント、ソースマップをカバーしています。
hero_alt: Hero image of the Web Almanac chracters cycling to power a website.
authors: [malchata]
reviewers: [mgechev, pankajparkar, NishuGoel, housseindjirdeh, kevinfarrugia, tunetheweb]
analysts: [NishuGoel, kevinfarrugia]
editors: [DesignrKnight, rviscomi]
translators: [ksakae1216]
malchata_bio: Jeremy Wagnerは、GoogleのパフォーマンスとCore Web Vitalsに関するテクニカルライターです。また、A List Apart、CSS-Tricks、Smashing Magazineでも執筆しています。いつか、砂がまだ考えることを教えられていない人里離れた荒野に移住する予定です。それまでは、妻と義理の娘たちとともにミネソタ州のツインシティに住み、ストリップモールの存在を嘆き続けています。
results: https://docs.google.com/spreadsheets/d/1vOeFUyfEtWRen3Xj57ZsWav40n5tlcJoV0HmAxmNE_I/
featured_quote: JavaScriptの状況は常に進化しています。私たちがこれまで以上に JavaScript に依存していることは明らかですが、これはウェブの総合的なユーザー体験にとってトラブルの元となります。私たちは、プロダクションウェブサイトに搭載されるJavaScriptの量を減らすために、できる限りのことをする必要があり、またそれ以上のことをする必要があります。
featured_stat_1: 26%
featured_stat_label_1: Babelでコードを変換しているページがもっとも多い。
featured_stat_2: 8%
featured_stat_label_2: モバイルで過去1年間にダウンロードされた追加のJavaScript
featured_stat_3: 20
featured_stat_label_3: サードパーティ製スクリプトの提供数中央値
---

## 序章

JavaScriptは、ウェブ上のインタラクティブ機能の大部分を提供する強力な力です。単純なものから複雑なものまで、さまざまな動作を実現し、Web上でかつてないほど多くのことを可能にしています。

しかし、リッチなユーザー体験を提供するためにJavaScriptを使用する機会が増えたことで、代償を払うことになりました。JavaScriptがダウンロードされ、解析され、コンパイルされた瞬間から実行されるコードのすべての行まで、ブラウザはすべてを可能にする為あらゆる種類の作業をオーケストレーションする必要があります。JavaScriptの使用量が少なすぎると、ユーザー体験やビジネス上の目標を達成できない可能性があります。一方JavaScriptを使いすぎると、読み込みが遅く、反応が鈍く、ユーザーをイライラさせるようなユーザー体験を作ることになります。

今年も、WebにおけるJavaScriptの役割について、2022年の調査結果を発表し、快適なユーザー体験を実現するためのアドバイスを提供します。

## JavaScriptの負荷はどのくらい？

まず始めに、ウェブ開発者がウェブ上で提供しているJavaScriptの量を評価します。結局のところ、改善を行う前に、現在の状況の評価を行う必要があるのです。

{{ figure_markup(
    image="bytes-per-page.png",
    caption="1ページあたりに読み込まれるJavaScriptの量の分布。",
    description="1ページあたりのJavaScriptのキロバイト数の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページでは、それぞれ87KB、209KB、461KB、857KB、1,367KBとなっています。デスクトップは全体的にやや高い値となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=807278764&format=interactive",
    sheets_gid="1117050794",
    sql_file="bytes_2022.sql"
  )
}}

昨年に引き続き、今年もブラウザに搭載されるJavaScriptの量が増えています。[2021年](../2021/javascript#JavaScriptをどれだけ読み込むか？)から2022年にかけて、モバイル端末では8％の増加、一方、デスクトップ端末では10％の増加が確認されています。この増加幅は例年より少ないものの、それでも懸念される傾向が続いています。デバイスの性能は向上し続けていますが、すべての人が最新のデバイスを使用しているわけではありません。JavaScriptが増えれば増えるほど、端末のリソースに負担がかかるのは事実です。

{{ figure_markup(
    image="unused-js.png",
    caption="JavaScriptの未使用バイト数の分布。",
    description="1ページあたりの未使用JavaScriptのキロバイト数を10、25、50、75、90パーセンタイルで示した棒グラフです。モバイルページでは、0、62、162、342、604の値になっています。デスクトップはやや高い傾向にあります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1640758017&format=interactive",
    sheets_gid="943216000",
    sql_file="unused_js_bytes_distribution.sql"
  )
}}

<a hreflang="en" href="https://web.dev/unused-javascript/">Lighthouse</a> によると、中央のモバイル ページでは、162KBの未使用のJavaScriptがロードされているそうです。90パーセンタイルでは604KBのJavaScriptが、未使用であることがわかります。これは、未使用のJavaScriptの中央値と90パーセンタイルがそれぞれ155KBと598KBであった昨年からわずかに上昇したものです。とくにこの分析ではJavaScriptリソースの転送サイズを追跡しているため圧縮されている場合は、使用されたJavaScriptの解凍部分が、このグラフが示すよりもはるかに大きい可能性があることを考えると、この量は未使用のJavaScriptに相当します。

モバイルページで読み込まれた総バイト数の中央値と比較すると、未使用のJavaScriptは、読み込まれたスクリプト全体の35%を占めています。これは、昨年の36%からわずかに減少していますが、それでも未使用で読み込まれるバイトの大部分であることに変わりはありません。このことは多くのページが、現在のページでは使われないかもしれない、あるいはページのライフサイクルの後半でのインタラクションによって引き起こされるスクリプトを読み込んでおり、起動コストを減らすために[ダイナミックな`import()`](#ダイナミックなimport) が有効かもしれないことを示唆しています。

## 1ページあたりのJavaScriptリクエスト数

ページ上のすべてのリソースは、少なくとも1つのリクエストを開始し、リソースがより多くのリソースに対して追加のリクエストを行う場合は、より多くのリクエストを開始する可能性があります。

スクリプトのリクエストは多ければ多いほど、より多くのJavaScriptを読み込むだけでなくスクリプトリソース間の競合が増え、メインスレッドを停滞させ起動が、遅くなる可能性が高くなるのです。

{{ figure_markup(
    image="requests-per-page.png",
    caption="1ページあたりのJavaScriptリクエスト数の分布。",
    description="1ページあたりのJavaScriptリクエストの10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページでは、4、10、21、37、60の値になっています。デスクトップでは、全体的に1～3リクエストとやや高い傾向にあります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=372493183&format=interactive",
    sheets_gid="1148191446",
    sql_file="requests_2022.sql"
  )
}}

2022年、モバイルページの中央値は21のJavaScriptリクエストに応答したのに対し、90パーセンタイルでは60のリクエストに応答しています。昨年と比較すると、中央値で1リクエスト、90パーセンタイルで4リクエストの増加です。

2022年のデスクトップデバイスでは、JavaScriptのリクエスト数が中央値で22、90パーセンタイルで63になっています。昨年と比較すると、中央値で1件、90パーセンタイルで4件増加しており、モバイルデバイスと同じ増加率になっています。

リクエスト数の増加幅は大きくないものの、2019年のWeb Almanac開始以来、前年比でリクエスト増加の傾向が続いています。

## JavaScriptはどのように処理されるのですか？

Node.jsのようなJavaScriptランタイムの出現以来、JavaScriptをバンドルし変換するためビルドツールへ依存することがますます一般的になってきました。これらのツールは紛れもなく便利ですが、JavaScriptの提供量に影響を与える可能性があります。今年のWeb Almanacでは、新たにバンドルとトランスパイラの使用状況に関するデータを提示します。

### バンドル

JavaScriptバンドルは、プロジェクトのJavaScriptソースコードを処理し、変換や最適化を適用するビルドタイムツールです。出力はプロダクションレディのJavaScriptです。たとえば、次のようなコードです。

```js
function sum (a, b) {
  return a + b;
}
```

バンドルはこのコードをより小さく、しかしより最適化された同等品に変換し、ブラウザがダウンロードする時間をより短くします。

```js
function n(n,r){return n+r}
```

バンドルは、ソースコードを最適化し、実稼働環境でのパフォーマンスを向上させるための重要な役割を担っています。

JavaScriptのバンドルに関しては豊富な選択肢がありますが、よく頭に浮かぶのは<a hreflang="en" href="https://webpack.js.org/">webpack</a>でしょう。幸いなことに、webpackの生成するJavaScriptにはいくつかのシグネチャ（たとえば `webpackJsonp`）が含まれており、ウェブサイトのプロダクションJavaScriptがwebpackを使ってバンドルされているかどうかを検出することが可能です。

{{ figure_markup(
    image="webpack-rank.png",
    caption="webpackでバンドルされたJavaScriptを使用しているページの順位。",
    description="webpackを使用しているページの割合を、人気の高い順に棒グラフで表示したものです。モバイルでは、上位1Kで17%、上位10Kでは15%、上位100Kは12%、上位1Mが8%、全ウェブサイトでは5%という値になっています。デスクトップページはモバイルに近い傾向です。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1191436570&format=interactive",
    sheets_gid="1329160999",
    sql_file="usage_of_webpack_by_rank.sql"
  )
}}

もっとも普及している1,000のWebサイトのうち、17%がバンドルとしてwebpackを使用しています。HTTP Archiveがクロールするもっとも多いページの多くは、ソースコードのバンドルと最適化にwebpackを使用している知名度の高いeコマースサイトである可能性が高いため、これは理にかなった結果です。それでも、HTTP Archiveのデータセットに含まれる全ページの5%がwebpackを使用しているという事実は、重要な統計データです。しかし、使用されているバンドルはwebpackだけではありません。

{{ figure_markup(
    image="parcel-rank.png",
    caption="ParcelでバンドルされたJavaScriptを使用しているページの順位。",
    description="Parcelを使用しているページの割合を、人気の高い順に示した棒グラフです。モバイルでは、上位1Kで1.3%、上位10Kでは1.9%、上位100Kが1.5%、上位1Mは1.2%、全ウェブサイトでは1.3%という値になっています。デスクトップページはモバイルに近い傾向です。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=369910383&format=interactive",
    sheets_gid="908384281",
    sql_file="usage_of_parcel_by_rank.sql"
  )
}}

<a hreflang="en" href="https://parceljs.org/">Parcel</a>は、webpackの代替品として注目され、その採用実績は大きいです。Parcelの採用率はすべてのランクで一貫しており、ランク間で1.2%から1.9%の幅を占めている。

HTTP Archiveはエコシステム内のすべてのバンドラーの使用状況を追跡することはできませんが、バンドラーの使用状況はJavaScriptの全体像において開発者の体験にとって重要であるだけでなく、依存性管理コードという形で貢献できるオーバーヘッドがJavaScriptの提供量の要因になりうる、という点で重要です。ユーザーが使用するブラウザに対してもっとも効率的に出力できるよう、プロジェクト全体の設定がどのように行われているかを確認することは価値があります。

### トランスパイラ

トランスパイラとは、新しいJavaScriptの機能を古いブラウザで実行できる構文に変換するため、ビルド時にツールチェーンでよく使われるものです。JavaScriptは長年にわたって急速に進化してきたため、これらのツールは今でも使用されています。今年のWeb Almanacでは、広く互換性のあるプロダクション対応のJavaScriptを提供する際の <a hreflang="en" href="https://babeljs.io/">Babel</a> の使用に関する分析が新たに掲載されました。とくにBabelに注目したのは、開発者コミュニティで代替品よりも広く使われているためです。

{{ figure_markup(
    image="babel-rank.png",
    caption="Babelを使用しているページをランク別に紹介。",
    description="Babelを使用しているページの割合を、人気の高い順に示した棒グラフです。モバイルページでは、上位1kの40%、上位10kの40%、上位100kの32%、上位1Mの23%、そして全ウェブサイトの26%という値になっています。デスクトップはモバイルに迫る勢いです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1109529452&format=interactive",
    sheets_gid="304021769",
    sql_file="usage_of_typescript_and_babel_by_rank.sql"
  )
}}

この結果は、JavaScriptが長年にわたって進化してきたことを考えれば、驚くような展開ではありません。特定のブラウザのセットに対して幅広い互換性を維持するために、Babelは<a hreflang="en" href="https://babeljs.io/docs/en/babel-plugin-transform-runtime#why">トランスフォーム</a>を使用して互換性のあるJavaScriptコードを出力しています。

トランスフォームは、トランスフォームしていないものよりも大きくなることがよくあります。トランスフォームが大規模であったり、コードベース全体で重複していたりすると、潜在的に不必要な、あるいは使用されていないJavaScriptがユーザーに出荷される可能性があります。これはパフォーマンスに悪影響を及ぼす可能性があります。

上位100万位にランクインしたページの26％でさえ、Babelを使ってJavaScriptのソースコードをトランスフォームしていることを考えると、これらの体験の中には必要のないトランスフォームを提供している可能性もないわけではありません。プロジェクトでBabelを使用する場合、Babelの利用可能な<a hreflang="en" href="https://babeljs.io/docs/en/options"> 設定オプション</a> とプラグインを慎重に検討し、その出力を最適化する機会を探してください。

Babelは特定の機能をレガシーな構文に変換する必要があるかどうかを判断するため<a hreflang="en" href="https://github.com/browserslist/browserslist">Browserslist</a>に依存しているため、あなたのコードがあなたのユーザーが実際に使用しているブラウザで動作するように変換されるよう、Browerslist設定も必ずレビューしてください。

## JavaScriptはどのようにリクエストされるのですか？

JavaScriptを要求する方法は、パフォーマンスにも影響を与える可能性があります。JavaScriptをリクエストする方法には最適なものがありますが、場合によっては最適とは言い難い方法もあります。ここでは、ウェブが全体としてどのようにJavaScriptを提供しているか、そしてそれがパフォーマンスへの期待にどのように合致するかを見ていきます。

### `async`、`defer`、`module`と`nomodule`

HTMLの `<script>` 要素にある `async` と `defer` 属性は、スクリプトの読み込みに関する挙動を制御できます。`async` 属性はスクリプトが解析の妨げになることを防ぎますが、ダウンロードされるとすぐに実行されるため、レンダリングをブロックする可能性があります。`defer` 属性はDOMの準備が整うまでスクリプトの実行を遅らせますので、パースとレンダリングの両方をブロックすることはありません。

`type="module"` と `nomodule` 属性は、ブラウザに提供されるES6モジュールの有無にとくに関係します。`type="module"` が使用された場合、ブラウザはそれらのスクリプトのコンテンツがES6モジュールを含むことを予期し、デフォルトでDOMが構築されるまでそれらのスクリプトの実行を延期します。反対の `nomodule` 属性は、現在のスクリプトがES6モジュールを使用していないことをブラウザに示します。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>async</code></td>
        <td class="numeric">76%</td>
        <td class="numeric">76%</td>
      </tr>
      <tr>
        <td><code>defer</code></td>
        <td class="numeric">42%</td>
        <td class="numeric">42%</td>
      </tr>
      <tr>
        <td><code>async</code>と<code>defer</code></td>
        <td class="numeric">28%</td>
        <td class="numeric">29%</td>
      </tr>
      <tr>
        <td><code>module</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td><code>nomodule</code></td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption='`<script>` 要素で `async`、`defer`、`type="module"`、`nomodule` 属性を使用しているページの割合です。',
    sheets_gid="2108682936",
    sql_file="breakdown_of_pages_using_async_defer.sql"
  ) }}</figcaption>
</figure>

76% のモバイル ページが `async` を使用してスクリプトを読み込んでいることは、開発者がレンダー ブロッキングの影響を認識していることを示すものであり、励みになります。しかし、`defer`の使用率がこれほど低いということは、レンダリングパフォーマンスを向上させる機会が残されていることを示唆しています。

[昨年](../2021/javascript#asyncとdefer)で述べたように、`async`と`defer`の両方を使うことはアンチパターンで、`defer`部分は無視されて`async`が優先されるので避けるべきものです。

一般的に `type="module"` と `nomodule` がないのは、JavaScriptモジュールを提供しているページがほとんどないためです。時間が経つにつれて、開発者がブラウザに変換されていないJavaScriptモジュールを提供するため、とくに `type="module"` の使用は増加する可能性があります。

全サイトのスクリプト全体の割合で見ると、少し違った見方ができる。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>async</code></td>
        <td class="numeric">49.3%</td>
        <td class="numeric">47.2%</td>
      </tr>
      <tr>
        <td><code>defer</code></td>
        <td class="numeric">8.8%</td>
        <td class="numeric">9.1%</td>
      </tr>
      <tr>
        <td><code>async</code>と<code>defer</code></td>
        <td class="numeric">3.0%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td><code>module</code></td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td><code>nomodule</code></td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption='スクリプトの `<script>` 要素で `async`、`defer`、`type="module"`、`nomodule` 属性を使用している割合です。',
    sheets_gid="357655091",
    sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
  ) }}</figcaption>
</figure>

ここでは、`async` と `defer` の両方があまり使用されていないことがわかります。これらのスクリプトの一部は、最初のレンダリングの後に動的に挿入されるかもしれません。しかし、かなりの割合のページが、最初のHTMLに含まれる多くのスクリプトにこれらの属性を設定せず、レンダリングを遅らせている可能性もあります。

### `preload`、`prefetch`と`modulepreload`

`preload`、`prefetch`、`modulepreload` などのリソースヒントは、どのリソースを早期に取得すべきかをブラウザへ示唆するのに有用です。それぞれのヒントは異なる目的を持っており、`preload`は現在のナビゲーションに必要なリソースを取得するために使用され、`modulepreload`は[JavaScriptモジュール](https://developer.mozilla.org/docs/Web/JavaScript/Guide/Modules)を含むスクリプトを`preload`するために相当し、`prefetch`は次のナビゲーションで必要なリソースに使用されます。

<figure>
  <table>
    <thead>
      <tr>
        <th>リソースヒント</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>preload</code></td>
        <td class="numeric">16.4%</td>
        <td class="numeric">15.4%</td>
      </tr>
      <tr>
        <td><code>prefetch</code></td>
        <td class="numeric">1.0%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td><code>modulepreload</code></td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="各種リソースヒントを使用しているページの割合。",
    sheets_gid="625000048",
    sql_file="resource-hints-prefetch-preload-modulepreload-percentage.sql"
  ) }}</figcaption>
</figure>

リソースヒントの導入動向を分析するのは難しい。すべてのページがリソースヒントの恩恵を受けるわけではありませんし、リソースヒントを広く使うことを一律に推奨するのは、使い過ぎるとそれなりの結果を招くので賢明ではありません。<a hreflang="en" href="https://blog.webpagetest.org/posts/removing-unused-preloads-on-festival-foods/">とくに `preload` が関係している</a>。しかし、モバイルページの15%に`preload`のヒントが比較的多く見られることから、多くの開発者がこのパフォーマンスの最適化を認識し、それを利用しようとしていることがうかがえます。

`prefetch` は、長い複数ページのセッションには有益ですが、使用するにはトリッキーです。それでも、`prefetch` は完全に推測的で、ある種の条件下ではブラウザが無視することもあるほどです。これは、あるページが未使用のリソースをリクエストすることによって、データを浪費する可能性があることを意味します。それは本当に「場合による」のです。

`modulepreload` が使われていないのは、`<script>` 要素に `type="module"` 属性が採用されていないのと同じで、理にかなっています。それでも、トランスフォームなしでJavaScriptモジュールを配布しているアプリは、このリソースヒントの恩恵を受けることができます。なぜなら、指定されたリソースだけを取得するのではなく、モジュールツリー全体を取得することができるからです。これは特定の状況で役に立つかもしれません。

では、各リソースヒントの種類はいくつ使用されているのか、分析を掘り下げてみましょう。

{{ figure_markup(
    image="prefetch.png",
    caption="ページごとのJavaScriptリソースに対する `prefetch` 採用の分布。",
    description="ページごとのJavaScriptリソースのプリフェッチヒントの10、25、50、75、90パーセンタイルを示す棒グラフです。モバイルページの値は、それぞれ1、2、3、7、16です。デスクトップの値は、50パーセンタイルよりページあたり1-4ヒント高くなる傾向があります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=987611412&format=interactive",
    sheets_gid="397179470",
    sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

ここでの `prefetch` の採用はやや意外で、1ページあたりJavaScriptリソースに対して3つの `prefetch` ヒントを出しています。しかし、75パーセンタイルと90パーセンタイルにあるこれらのヒントの数は、発生しないページ移動のための未使用リソースという形で、かなりの量のムダがあることを示唆しています。

{{ figure_markup(
    image="preload.png",
    caption="ページごとのJavaScriptリソースに対する `preload` 採用の分布。",
    description="ページごとのJavaScriptリソースのプリロードヒントの10、25、50、75、90パーセンタイルを示した棒グラフです。モバイルページの値は、それぞれ、1、1、2、3、5です。デスクトップの値は、モバイルとほぼ同じです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1371197443&format=interactive",
    sheets_gid="397179470",
    sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

この分析では、1つ以上の `preload` ヒントを使用しているページで、JavaScriptリソースにいくつのリソースヒントが使用されたかを追跡しています。中央のページはJavaScriptに対して2つの `preload` ヒントを配信しており、表面上は悪くありませんがスクリプトのサイズ、スクリプトが起動する処理量、あるいは `preload` で取得したスクリプトが最初のページロードに必要かどうかによって、しばしば異なります。

残念ながら、90パーセンタイルのJavaScriptリソースには5つの `preload` ヒントがあり、これは多すぎるかもしれません。これは、90%台のページがとくにJavaScriptに依存しており、その結果生じるパフォーマンスの問題を克服しようとして `preload` を使用していることを示唆しています。

{{ figure_markup(
    image="modulepreload.png",
    caption="ページごとのJavaScriptリソースに対する `modulepreload` 採用の分布。",
    description="ページごとのJavaScriptリソースのmodulepreloadヒントの10、25、50、75、90パーセンタイルを示す棒グラフです。モバイルページの値は、それぞれ、1、1、2、6、14です。デスクトップの値は、モバイルとほぼ同じです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=100852946&format=interactive",
    sheets_gid="397179470",
    sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

`modulepreload` では、75パーセンタイルで6個、90パーセンタイルで14個という驚異的な数のヒントが表示されました。このことから、上位のパーセンタイルで1つ以上の `modulepreload` ヒントを使用しているページでは、変換されていないES6モジュールを直接ブラウザに送信している一方で、非常に多くのリソースヒントが必要なため、上位の範囲ではJavaScriptに過度に依存していることが示唆されます。

リソースヒントはブラウザにリソースを読み込む方法を最適化するための素晴らしいツールですが、使用する際のアドバイスがひとつあるとすれば、控えめに、そして最初は発見できないようなリソースに使用することです。たとえば、最初にDOMへ読み込んだJavaScriptファイルが、別のファイルを要求する場合などです。スクリプトを大量にプリロードするよりも、出荷するJavaScriptの量を減らすようにしましょう。そうすれば、より良いユーザー体験につながります。

### JavaScript を `<head>` 内に記述する

古くからよく言われているパフォーマンスのためのベストプラクティスは、JavaScriptをドキュメントのフッターにロードしてスクリプトのレンダーブロックを回避し、スクリプトが実行される前にDOMが構築されるようにすることでした。しかし最近では、ある種のアーキテクチャでは `<script>` 要素をドキュメントの `<head>` に配置することがより一般的になってきています。

これはウェブアプリケーションでJavaScriptの読み込みを優先させる良い方法ですが、DOMのレンダーブロックを避けるために、可能な限り `async` と `defer` 属性を使用すべきです。レンダーブロッキングとは、ページが依存しているリソースを処理するために、ブラウザがページのすべてのレンダリングを停止しなければならないことを指します。これは、[ふらちなコンテンツ](https://en.wikipedia.org/wiki/Flash_of_unstyled_content)のような不快な効果や、DOMの準備に依存するスクリプトのためにDOMの準備ができていないときに発生しうるJavaScript実行時エラーを避けるために行われます。

{{ figure_markup(
    caption="ドキュメント `<head>` 内にレンダーブロッキングスクリプトがあるモバイルページの割合です。",
    content="77%",
    classes="big-number",
    sheets_gid="1658693311",
    sql_file="render_blocking_javascript.sql"
  )
}}

モバイルページの77%が `<head>` 内にレンダリングをブロックするスクリプトを少なくとも1つ含んでいるのに対し、デスクトップページの79%はこのようなスクリプトを含んでいることがわかりました。スクリプトがレンダリングをブロックすると、ページコンテンツが迅速に描画されなくなるため、これは懸念すべき傾向です。

{{ figure_markup(
    image="render-blocking-scripts-rank.png",
    caption="ドキュメント `<head>` にレンダリングをブロックするスクリプトがあるランク別ページ。",
    description="レンダーブロッキングJavaScriptを搭載しているページの割合をサイトの人気順で区分した棒グラフです。上位1Kのモバイルページの63%、上位1万ページの68%、上位1億ページの70%、上位1万ページの73%、そして全体では77%がレンダーブロッキングJavaScriptを搭載しています。デスクトップ用ページでは、とくに人気の高いページほどレンダーブロッキングJavaScriptが多い傾向にあります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=193447897&format=interactive",
    sheets_gid="971996043",
    sql_file="render_blocking_javascript_by_rank.sql"
  )
}}

ランキングされたページでこの問題を見ると、同じように厄介なパターンが見られます。とくに、モバイル端末からアクセスされた上位1,000サイトのうち63%は、`<head>`内に少なくとも1つのレンダーブロッキングスクリプトを含んでおり、その割合は順位が上がるにつれて増加します。

これには解決策があります。`defer` を使用するのは比較的安全で、DOMのレンダリングをブロックしないようにします。`async` を使用するのも良い方法ですが、他の `<script>` 要素に依存したスクリプトを作成すると、エラーを発生させる可能性があります。

可能であれば、レンダリングに不可欠なJavaScriptをフッターに配置し、ブラウザがそれらのリソースを要求する際に先手を打てるようにプリロードできます。いずれにせよ、レンダーブロッキングを引き起こすJavaScriptの状態と、私たちが提供するJavaScriptの量は、決して良いものではありません。

### スクリプトインジェクション

スクリプトインジェクションとは、[`HTMLScriptElement`](https://developer.mozilla.org/docs/Web/API/HTMLScriptElement)を [`document.createElement`](https://developer.mozilla.org/docs/Web/API/Document/createElement)を使ってJavaScriptで作成し、DOM挿入メソッドでDOMに注入するパターンのことです。また、文字列中の `<script>` 要素のマークアップは、 [`innerHTML`](https://developer.mozilla.org/docs/Web/API/Element/innerHTML)メソッドによってDOMに注入できます。

スクリプトインジェクションは多くのシナリオで使用されるかなり一般的な手法ですが、この方法の問題は、<a hreflang="en" href="https://web.dev/preload-scanner/#injected-async-scripts">最初のHTMLペイロードが解析されるときにスクリプトを発見できないようにして、ブラウザのプリロード スキャンナー</a>を破ってしまうということです。これは、注入されたスクリプト リソースが最終的にマークアップのレンダリングを担当する場合、<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">最大のコンテントフルペイント (LCP)</a>などのメトリックに影響を与える可能性があり、マークアップの大きな塊をその場で解析する長いタスクを開始させる可能性があります。

{{ figure_markup(
    image="injected-scripts.png",
    caption="注入されたスクリプトの割合の各パーセンタイルでの分布。",
    description="注入されたスクリプトのページあたりの割合の10、25、50、75、90パーセンタイルを示す棒グラフです。モバイルページでは、それぞれ0％、8％、25％、50％、70％という値になっています。デスクトップの値もほぼ同じです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=389798470&format=interactive",
    sheets_gid="1017601908",
    sql_file="distribution_of_injected_scripts.sql"
  )
}}

中央値では、ページのスクリプトの25%が注入され、最初のHTML応答で発見できるようにするのとは対照的であることがわかります。さらに問題なのは、ページの75パーセンタイルと90パーセンタイルでは、それぞれ50%と70%のスクリプトが注入されていることです。

スクリプト・インジェクションは、ユーザーが消費するページのコンテンツを表示するために使用すると、<a hreflang="en" href="https://www.igvita.com/2014/05/20/script-injected-async-scripts-considered-harmful/">パフォーマンスに悪影響を与える可能性があります</a>ので、このような場合は必要なときに避けるべきです。スクリプト・インジェクションが今日のウェブでこれほど普及していることは、懸念すべき傾向です。最新のフレームワークやツールはこのパターンに依存している可能性があり、つまり、いくつかのアウトオブボックス体験は、Webサイトの機能を提供するためこの潜在的なアンチパターンに依存している可能性があります。

### ファーストパーティーのJavaScriptとサードパーティーのJavaScript

Webサイトがよく提供するJavaScriptには、2つのカテゴリがあります。

- ウェブサイトの重要な機能を支え、インタラクティブ性を提供するファーストパーティのスクリプト。
- UX調査、分析、広告収入の提供、動画やソーシャルメディア機能などの埋め込みなど、さまざまな要件を満たす外部ベンダーから提供されるサードパーティスクリプトです。

ファーストパーティのJavaScriptは最適化しやすいかもしれませんが、サードパーティのJavaScriptはそれ自体がパフォーマンス問題の重大な原因となり得ます。サードパーティのベンダーは、顧客のために新たなビジネス機能を提供するための新機能を追加するよりも、そのJavaScriptリソースの最適化を優先させないかもしれないからです。さらに、UX研究者、マーケティング担当者、およびその他の非技術者は、これらのスクリプトが提供する機能や収益源を放棄することをためらうかもしれません。

このセクションでは、ファーストパーティとサードパーティのコードの内訳を分析し、現在のWebサイトがJavaScriptをどこからどのように読み込むかを分割している現状についてコメントします。

#### リクエスト

{{ figure_markup(
    image="requests-party.png",
    caption="ホスト別のファーストパーティとサードパーティのJavaScriptリクエストの分布。",
    description="モバイルページあたりのJavaScriptリクエストの10、25、50、75、90パーセンタイルを、スクリプトがファーストパーティのホストによって提供されたかサードパーティのホストによって提供されたかによって分類した棒グラフ。両者の値はほぼ同じで、それぞれ2、4、10、20、34となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=2001603308&format=interactive",
    sheets_gid="755344459",
    sql_file="requests_by_3p.sql"
  )
}}

ここでは、悲観的な図が示されています。パーセンタイルに関係なく、観測されたすべてのホストは、ファースト・スクリプトとサード・パーティ・スクリプトを同量ずつ配信しているようです。中央値のホストは各タイプを10個、75パーセンタイルのホストは各タイプを20個、90パーセンタイルのホストはサードパーティ・スクリプトを34個提供しています。

これは問題であり、心配な傾向です。サードパーティのスクリプトは、パフォーマンスに関してあらゆる種類の損害を与える責任があります。サードパーティのスクリプトは多くのタスクをオーケストレーションする高価なタイマーを実行したり、独自のイベントリスナーを追加してインタラクティブ性を遅延させたり、ビデオやソーシャルメディアのサードパーティの中には提供するサービスを強化するために法外な量のスクリプトを出荷したりするなど、さまざまなことを行うことがあります。

サードパーティ製スクリプトを軽減するための手順は、技術的なものよりも文化的なものであることが多い。サードパーティ製スクリプトを過剰に出荷している場合は、各スクリプトとその実行内容を監査し、アクティビティのプロファイルを作成して、パフォーマンスに関する問題を見つけます。

もしあなたがかなりのUX研究をしているのなら、（オリジンが適切な[`Timing-Allow-Origin`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Timing-Allow-Origin)ヘッダーを送信する場合）独自のフィールドデータを収集し、サードパーティ製スクリプトが引き起こすパフォーマンスの問題を回避するための情報に基づいた意思決定を検討することをオススメします。サードパーティーのスクリプトを追加するたびに、ロードコストだけでなく、ユーザーの入力に対する応答性が重要なランタイム中のコストも発生します。

#### バイト

そこで、ホストがサードパーティ製スクリプトを大量に提供していることが分かったのですが、ファーストとサードパーティ製スクリプトのバイトコストはどうなっているのでしょうか。

{{ figure_markup(
    image="bytes-party.png",
    caption="ホスト別のファーストパーティとサードパーティのJavaScriptのバイト数の分布。",
    description="モバイルページごとに読み込まれたJavaScriptのキロバイトサイズを、ファーストパーティとサードパーティのどちらのホストから提供されたかによって分類し、10、25、50、75、90パーセンタイルを示した棒グラフです。サードパーティの値は、1ページあたりそれぞれ34、109、292、595、1,003キロバイトです。ファーストパーティのスクリプトは、1ページあたり20、65、109、309、642キロバイトと、かなり低い値になっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1411726363&format=interactive",
    sheets_gid="1560368150",
    sql_file="bytes_by_3p.sql"
  )
}}

ほぼすべてのパーセンタイルで、サードパーティ製スクリプトの送信バイト量が、ファーストパーティ製スクリプトの送信バイト量を上回っています。75パーセンタイルでは、サードパーティのスクリプトのペイロードは、ファーストパーティのスクリプトの2倍であるように見えます。90パーセンタイルでは、送信されるサードパーティ製スクリプトの量は、ほぼ1メガバイトになるようです。

もし、あなたのウェブサイトのファーストスクリプトとサードパーティスクリプトのペイロードが上記のグラフと同様であることがわかったら、エンジニアリング組織と協力して、この数字を減らす努力をすることが重要です。そうすることで、ユーザーの役に立つことができるのです。

### ダイナミックな`import()`

<a hreflang="en" href="https://v8.dev/features/dynamic-import">ダイナミックな`import()`</a>は[静的な`import`構文](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/import)の変形で、スクリプト内のどこでも実行できます。一方静的な`import`式はJavaScriptファイルの先頭で実行しなければならず、他の場所では実行することができません。

ダイナミックな`import()`により、開発者はメインのバンドルからJavaScriptコードのチャンクを効果的に「分割」してオンデマンドでロードすることができ、前もってロードするJavaScriptを少なくして起動時のパフォーマンスを改善できます。

{{ figure_markup(
    caption="動的な `import()` を使用しているモバイルページの割合。",
    content="0.34%",
    classes="big-number",
    sheets_gid="563835654",
    sql_file="dynamic_import.sql"
  )
}}

現在観測されているモバイルページの0.34%という驚異的な低さで、デスクトップページの0.41%で動的な `import()` が使用されています。とはいえ、バンドルによっては動的な `import()` 構文をES5互換の代替構文にトランスフォームすることが一般的です。この機能が広く使われている可能性は高いのですが、プロダクションのJavaScriptファイルではあまり使われていないようです。

これは難しいことですが、バランスを取ることができ、それにはユーザーの意図を測ることが必要です。インタラクションを遅らせることなくJavaScriptのロードを延期する1つの方法は、ユーザーがインタラクションを行う意図を示したときにJavaScriptを[preload](https://developer.mozilla.org/docs/Web/HTML/Link_types/preload)することです。たとえば、フォームの検証のためにJavaScriptのロードを延期し、ユーザーがそのフォームのフィールドにフォーカスした時点でそのJavaScriptをプリロードできます。そうすれば、JavaScriptが要求されたとき、すでにブラウザーのキャッシュにあるはずです。

また、サービスワーカーのインストール時に、インタラクションに必要なJavaScriptをプリキャストしておくという方法も考えられます。インストールは、ページの <a hreflang="en" href="https://developer.mozilla.org/docs/Web/API/Window/load_event">`load` イベント</a>でページが完全にロードされた時点で行う必要があります。これにより、必要な機能が要求されたときに、サービスワーカーのキャッシュから起動コストをかけずに取得することができる。

動的な `import()` は使い方が難しいのですが、より広く採用することで、JavaScriptを起動時に読み込むパフォーマンスコストをページのライフサイクルの後半、おそらくネットワークリソースの競合が少ない時点にシフトさせることができます。起動時に読み込まれるJavaScriptの量は増える一方なので、動的な `import()` の採用が増えることを期待しています。

### Web ワーカー

[Webワーカー](https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Using_web_workers)は、DOMへ直接アクセスせずに専用のJavaScriptファイルを独自スレッドで回転させることで、メインスレッドの作業を軽減するウェブプラットフォームの機能です。この技術は、メインスレッドに負担をかけるような作業を別スレッドで、行うことで負荷を軽減するために利用されます。

{{ figure_markup(
    caption="Web Workerを利用したモバイルページ数。",
    content="12%",
    classes="big-number",
    sheets_gid="1990906363",
    sql_file="web_workers.sql"
  )
}}

現在、モバイルおよびデスクトップページの12% が、ユーザー体験を悪化させる可能性のあるメインスレッドの作業を軽減するために、1つ以上のウェブワーカーを使用していることは喜ばしいことですが、改善の余地は多くあります。

DOMに直接アクセスしなくてもできる重要な作業がある場合は、Web Workerを使用するのがよいアイデアです。Web Workerとのデータ転送には[専用の通信パイプライン](https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Using_web_workers#%E3%83%AF%E3%83%BC%E3%82%AB%E3%83%BC%E3%81%A8%E3%81%AE%E3%83%87%E3%83%BC%E3%82%BF%E8%BB%A2%E9%80%81%E3%81%AE%E8%A9%B3%E7%B4%B0)を使う必要がありますが、この技術を使うことで、ユーザーの入力に対するWebページの応答性を格段に向上させることは十分可能です。

しかし、その通信パイプラインは、設定や使い方にコツがいるものですが、このプロセスを簡略化できるオープンソースのソリューションがあります。<a hreflang="en" href="https://www.npmjs.com/package/comlink">comlink</a>はこれを支援するライブラリの1つで、Webワーカーに関する開発者の体験をより楽しいものにできます。

ウェブワーカーを自前で管理するかライブラリで管理するかは別として、ポイントは高価な作業を行う場合、それがメインスレッドで行われる必要があるかどうかを判断し、そうでなければウェブサイトのユーザー体験を可能な限り良くするためにウェブワーカーの使用を強く検討する、ということです。

### ワークレット

ワークレットは、ペイントやオーディオ処理などのタスクのためのレンダリングパイプラインに低レベルでアクセスできる特殊なワーカーの一種です。4種類のワークレットがありますが、現在利用可能なブラウザに実装されているのは、<a hreflang="en" href="https://caniuse.com/mdn-api_css_paintworklet">ペイントワークレット</a>と<a hreflang="en" href="https://caniuse.com/mdn-api_audioworklet">オーディオワークレット</a>の2種類のみです。ワークレットは独自のスレッドで実行されるため、メインスレッドで高価な描画やオーディオ処理から解放されるという明確なパフォーマンス上の利点があります。

{{ figure_markup(
    caption="ペイントワークレットが1つ以上登録されているモバイルページの割合です。",
    content="0.0013%",
    classes="big-number",
    sheets_gid="263104357",
    sql_file="worklets.sql"
  )
}}

ワークレットはニッチな技術なので、あまり使われていないのも無理はありません。ペイントワークレットは、ジェネレーティブアートワークの高価な処理を別のスレッドにオフロードする優れた方法であり、ユーザー体験にちょっとしたセンスを加えるのに最適な技術であることは言うまでもありません。100万件のWebサイトのうち、ペイントワークレットを使用しているのはわずか13件です。

{{ figure_markup(
    caption="音声ワークレットが1つ以上登録されているモバイルページの割合です。",
    content="0.0004%",
    classes="big-number",
    sheets_gid="263104357",
    sql_file="worklets.sql"
  )
}}

音声ワークレットの採用率はさらに低く、100万件に4件の割合で採用されているに過ぎません。これらの技術の採用が時間とともにどのように推移するかは興味深いところです。

## JavaScriptはどのように配信されるのですか？

JavaScriptのパフォーマンスで同様に重要なのは、ブラウザにスクリプトを配信する方法です。これには、JavaScriptを圧縮する方法から始まる、一般的でありながら時に見過ごされる最適化の機会がいくつか含まれています。

### 圧縮

圧縮はHTML、CSS、SVG画像、そしてJavaScriptなど、主にテキストベースの資産に適用される、よく使用される技術です。ウェブで広く使われているさまざまな圧縮技術があり、ブラウザへのスクリプトの配信を高速化し、リソースの読み込み段階を効果的に短縮できます。

{{ figure_markup(
    image="compression-methods.png",
    caption="JavaScriptのメソッド別圧縮。",
    description="スクリプトリクエストのうち、gzip、Brotli、deflate、または圧縮方法が設定されていないものの割合を比較した棒グラフです。モバイルページでは、それぞれ52%、34%、0%、13%となっています。デスクトップでは、1%ポイント以内に収まっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1805733290&format=interactive",
    sheets_gid="1841484709",
    sql_file="compression_method.sql"
  )
}}

スクリプトの転送サイズを減らすために使える圧縮技術はいくつかありますが、<a hreflang="en" href="https://github.com/google/brotli">Brotli</a> (br)方式が<a hreflang="en" href="https://www.smashingmagazine.com/2016/10/next-generation-server-compression-with-brotli/">もっとも有効</a>だと言われています。Brotliの <a hreflang="en" href="https://caniuse.com/brotli">モダンブラウザでの優れたサポート</a>にもかかわらず、<a hreflang="en" href="https://www.gzip.org/">gzip</a>がもっとも好ましい圧縮方法であることは明らかでしょう。これは、多くのウェブサーバーがデフォルトとして使用しているためと思われます。

何かがデフォルトである場合、そのデフォルトは、より良いパフォーマンスのためにチューニングされるのではなく、そのままの状態で維持されることがあります。Brotliでスクリプトを圧縮しているページが34%しかないことを考えると、スクリプトリソースの読み込み性能を向上させる機会があることは明らかですが、昨年の30%に比べて改善されていることも特筆すべきことでしょう。

{{ figure_markup(
    image="compression-by-host.png",
    caption="ホスト別のスクリプトリソースの圧縮方法。",
    description="モバイルページにおけるスクリプトリクエストのうち、各圧縮方式が使用されている割合を、ファーストホストとサードパーティホストのどちらによって提供されたかによって分類した棒グラフ。サードパーティホストの60%がgzipで、29%がBrotliで、12%が圧縮方式なしで、0%がdeflateで圧縮されたスクリプトを送信しています。ファーストパーティホストでは45%がgzipで、40%がBrotliで、15%が任意の圧縮方式で、0%がdeflateで提供されています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1368281759&format=interactive",
    sheets_gid="1339368020",
    sql_file="compression_method_by_3p.sql"
  )
}}

この問題は、サードパーティのスクリプトプロバイダーによってさらに悪化し、それぞれ60%対29%と、依然としてBrotliよりも広くgzip圧縮を導入しています。サードパーティーのJavaScriptが今日のWebにおける深刻なパフォーマンスの問題であることを考えると、これらのリソースのロード時間は、代わりにBrotliを使用してサードパーティーのリソースを展開することで短縮できる可能性があります。

{{ figure_markup(
    image="uncompressed.png",
    caption="非圧縮のリソースをサイズ別に紹介。",
    description="モバイル ページにおける圧縮されていないJavaScriptリソースのキロバイト単位の分布を、スクリプトがファーストパーティのホストによって提供されたかサードパーティのホストによって提供されたかによって分類したヒストグラムです。非圧縮のサードパーティ製スクリプトは小さい方に偏っており、リクエストの90%は5KB未満、5～10KBのリクエストは3%、100KB以上のリクエストは2%です。ファーストパーティのスクリプトは、サイズが大きくなる傾向で、5KB未満がわずか50%、5～10KBでは12%、100KB超は6%でした。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1991115497&format=interactive",
    sheets_gid="1609356066",
    sql_file="compression_none_by_bytes.sql"
  )
}}

ありがたいことに、圧縮せずに配信されるのはもっとも小さなリソース、とくにペイロードが5KB未満のサードパーティ製スクリプトだけであることが分かっています。これは小さいリソースに圧縮を適用した場合、圧縮の収穫が少なくなるためで、実際、動的圧縮のオーバーヘッドが追加されると、リソースの配信を遅延させる可能性があります。残念ながら、ペイロードが100KBを超えるファーストパーティのスクリプトなど、より大きなリソースを圧縮する機会が、あらゆる分野で存在します。

圧縮設定を常に確認し、ネットワーク上で配信されるスクリプトのペイロードを可能な限り小さくするようにしてください。これらのスクリプトは、ブラウザに配信された後、解凍され、その処理時間は圧縮によって変化しません。圧縮は、起動時のインタラクティビティを悪化させる可能性のある巨大なスクリプトペイロードを配信するための良い言い訳ではありません。

### 最小化

テキスト資産の最小化は、ファイルサイズを小さくするために古くから行われている方法です。ソースコードに含まれる不要なスペースやコメントをすべて削除し、転送サイズを小さくするものです。さらに、JavaScriptでは、変数名、クラス名、関数名などを読みにくい記号に変換する「UGL化」という手法を採用している。Lighthouseの<a hreflang="en" href="https://web.dev/unminified-javascript/">Minify JavaScript</a>監査は、最小化されていないJavaScriptをチェックします。

{{ figure_markup(
    image="lighthouse-unminified.png",
    caption="JavaScript監査スコアの分布。",
    description="Lighthouseの最小化されていないJavaScript監査で、さまざまな範囲のスコアを持つページの割合を示すヒストグラム。モバイルページの68%が0.9から1.0の範囲で最高のスコアを獲得し、0.75から0.9が4%、0.5から0.75が8%、0.25から0.50が11%、0.1から0.25が2%、そして最悪の範囲である0.1以下が7%となりました。デスクトップ用ページでは、0.9以上のページが79％と、良い範囲に偏る傾向があります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=968128936&format=interactive",
    sheets_gid="906447348",
    sql_file="lighthouse_unminified_js.sql"
  )
}}

ここで、0.00は最悪のスコアを表し、1.00は最高のスコアを表します。Lighthouseのminified JavaScript監査では、モバイルページの68%が0.9から1.0のスコアであるのに対し、デスクトップページでは79%となっています。つまり、モバイルでは32%のページがminified JavaScriptを使用する機会があるのに対し、デスクトップでは21%ということになります。

{{ figure_markup(
    image="lighthouse-unminified-bytes.png",
    caption="JavaScriptのMinifyによる潜在的な節約効果の分布。",
    description="JavaScriptの最小化によって節約できる可能性のあるキロバイトの10、25、50、75、90パーセンタイルを、節約できる総量とサードパーティースクリプトのみを使用した場合のものに分けて示した棒グラフです。各パーセンタイルでの節約量は、それぞれ3、5、12、34、76 KBです。サードパーティースクリプトのみの場合は、0、0、0、3、19KBです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1309849294&format=interactive",
    sheets_gid="https://docs.google.com/spreadsheets/d/1YqoRRsyiNsrEabVLu2nRU98JIG_0zLLuoQhC2nX8xbM/edit#gid=442223364",
    sql_file="../third-parties/distribution_of_lighthouse_unminified_js_by_3p.sql"
  )
}}

中央値では、最小化可能なJavaScriptは約12KBです。しかし、75パーセンタイルと90パーセンタイルになると、この数字は34KBから約76KBへと大きく跳ね上がります。サードパーティは、90パーセンタイルまでは非常に良好で、最小化されていないJavaScriptが約19キロバイト提供されています。

{{ figure_markup(
    image="lighthouse-unminified-avg.png",
    caption="最小化されていないJavaScriptの平均的なムダなバイト数。",
    description="円グラフは、ムダなJavaScriptの平均バイト数の81.3%がファーストパーティのスクリプトから、18.7%がサードパーティのスクリプトからきていることを表しています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=656802580&format=interactive",
    sheets_gid="1457445566",
    sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

先ほど紹介したデータから、未定義のJavaScriptのムダなバイト数は、平均を見ればそれほど驚くことではありません。ファーストパーティーは、80%強の未修飾JavaScriptを提供する最大の原因となっています。残りの20% 弱は、送信するバイト数を減らすためにもう少し努力できます。

最小化は、ウェブパフォーマンスの最初の原則の1つである「より少ないバイト数で提供する」ことに対応しています。Lighthouseの監査でJavaScriptが最小化されていないことが判明した場合、バンドラーの設定を確認し、ファーストパーティのコードが実運用で可能な限り効率化されていることを確認します。サードパーティのスクリプトが未定義であることに気づいたら、そのベンダーとチャットして、修正できることを確認する必要があるかもしれません。ウェブ上のサードパーティのあり方については、[サードパーティ](./third-parties)の章を参照してください。

### ソースマップ

<a hreflang="en" href="https://firefox-source-docs.mozilla.org/devtools-user/debugger/how_to/use_a_source_map/index.html">ソースマップ</a>は、Web開発者が、最小化および醜形化したプロダクション コードを元のソースへマッピングするために使用するツールです。ソースマップはプロダクションのJavaScriptファイルで使用され、デバッグのための便利なツールです。ソースマップはリソースの最後にあるソースマップファイルを指すコメントで指定するか、<a hreflang="en" href="https://developer.mozilla.org/docs/Web/HTTP/Headers/SourceMap">`SourceMap`</a>HTTPレスポンスヘッダーとして指定することが可能です。

{{ figure_markup(
    caption="一般に公開されているソースマップに対して、ソースマップコメントを指定しているモバイルページの割合。",
    content="14%",
    classes="big-number",
    sheets_gid="1840293255",
    sql_file="sourcemaps.sql"
  )
}}

モバイルデバイスからアクセスしたJavaScriptリソースの14% が、一般にアクセス可能なソースマップへのソースマップコメントを配信しているのに対し、デスクトップデバイスからアクセスしたJavaScriptリソースでは15% が配信しています。しかし、ソースマップHTTPヘッダーを使用しているページでは、話はまったく異なります。

{{ figure_markup(
    caption="ソースマップヘッダーを指定しているモバイルページの数。",
    content="0.12%",
    classes="big-number",
    sheets_gid="1454051104",
    sql_file="sourcemap_header.sql"
  )
}}

モバイルデバイスのJavaScriptリソースに対するリクエストのうち、ソースマップHTTPヘッダーを使用したものは0.12%に過ぎませんが、デスクトップデバイスの場合は0.07%となっています。

パフォーマンスの観点からは、これはあまり意味がありません。ソースマップは開発者の体験を向上させるものです。しかし、避けるべきはインラインソースマップの使用です。インラインソースマップは、オリジナルのソースのbase64表現を制作可能なJavaScriptアセットに挿入するものです。ソースマップをインライン化すると、JavaScriptリソースをユーザーに送信するだけでなく、ソースマップも送信することになり、ダウンロードと処理に時間がかかる巨大なJavaScript資産になる可能性があります。

## レスポンシブ

JavaScriptが影響を与えるのは、スタートアップのパフォーマンスだけではありません。インタラクティブ性を提供するためJavaScriptに依存している場合、それらのインタラクションは、実行に時間がかかるイベントハンドラーによって駆動されます。インタラクションの複雑さと、それを駆動するためのスクリプトの量によっては、ユーザーは入力の応答性の悪さを体験する可能性があります。

### 指標

実験室と現場の両方で応答性を評価するために多くのメトリクスが使用されており、Lighthouse、Chrome UXレポート (CrUX)、HTTP Archiveなどのツールはこれらのメトリクスを追跡して、今日のウェブサイトの応答性の現状をデータに基づいて表示します。とくに断りのない限り、以下のグラフはすべて、原点レベルでその指標の75パーセンタイルを表しており<a hreflang="ja" href="https://web.dev/i18n/ja/vitals/#core-web-vitals">合格と判定される閾値</a>です。

その最初のものは、<a hreflang="ja" href="https://web.dev/i18n/ja/fid/">最初の入力までの遅延 (FID)</a>で、ページとの最初のインタラクションの入力遅延を記録するものです。入力遅延とは、ユーザーがページとインタラクションを行った後、そのインタラクションのイベントハンドラーが実行され始めるまでの時間です。Webサイトとのインタラクションでユーザーが受ける第一印象に焦点を当てた、負荷応答性の指標と考えられています。

{{ figure_markup(
    image="fid.png",
    caption="Webサイトの75パーセンタイルFID値の分布。",
    description="オリジンの75パーセンタイルFID値の10、25、50、75、90パーセンタイルを示す棒グラフ。デスクトップと携帯の両方が25msとなる90パーセンタイルまでは、すべての値が0msとなっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=217835320&format=interactive",
    sheets_gid="2108420759",
    sql_file="fid.sql"
  )
}}

このグラフは、全ウェブサイトの75パーセンタイルFID値の分布を表しています。中央のウェブサイトは、デスクトップとモバイルの両方のユーザー体験の少なくとも75%において、FID値が0msです。この「完璧なFID」体験は、75パーセンタイルのWebサイトにまで及んでいます。90パーセンタイルになると、不完全なFID値が見られるようになりますが、これは25ミリ秒にすぎません。

良いFIDの閾値が<a hreflang="ja" href="https://web.dev/i18n/ja/fid/#fid-%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E8%89%AF%E3%81%84%E3%82%B9%E3%82%B3%E3%82%A2%E3%81%A8%E3%81%AF%EF%BC%9F">100 ms</a>であることを考えると、少なくとも90%のWebサイトがこの水準を満たしていると言えるでしょう。実際、[パフォーマンス](./performance)の章で行われた分析から、実際に100%のウェブサイトがデスクトップデバイスで、92%がモバイルデバイスで良いFID体験をしていることが分かっているのです。FIDは、異常に寛容な指標です。

{{ figure_markup(
    image="inp.png",
    caption="Webサイトの75パーセンタイルINP値の分布。",
    description="オリジンのINP値の75パーセンタイルの10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルの体験では、それぞれ75、100、150、250、400ミリ秒です。デスクトップ体験では、50、75、125、225、350ミリ秒と、軒並み低い値になっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=675812331&format=interactive",
    sheets_gid="1763213051",
    sql_file="inp.sql"
  )
}}

しかし、ページのライフサイクル全体にわたるページの応答性を包括的に見るには、<a hreflang="en" href="https://web.dev/articles/inp">次のペイントまでのインタラクション (INP)</a>を見る必要があります。これは、ページに対して行われたすべてのキーボード、マウス、タッチ操作を評価し、総合的にページの応答性を表すことを意図して、操作待ち時間の高いパーセンタイルを選択するものです。

良いINPスコアは<a hreflang="en" href="https://web.dev/articles/inp#what's-a-%22good%22-inp-value">200ミリ秒</a>以下だと考えてください。中央値では、モバイルとデスクトップの両方がこの閾値を下回っていますが、75パーセンタイルでは別の話で、モバイルとデスクトップの両方のセグメントが「要改善」の範囲に大きく入っています。このデータは、FIDとはまったく異なり、INPスコアがあまりよくない主な原因であるページ上の <a hreflang="ja" href="https://web.dev/i18n/ja/long-tasks-devtools/">長いタスク</a>を減らすために、ウェブサイトができることをすべて行う機会がたくさんあることを示唆しています。

{{ figure_markup(
    image="tbt.png",
    caption="ページのラボベースTBT値の分布。",
    description="ページの合成TBT値の10、25、50、75、90パーセンタイル値を示す棒グラフ。モバイルページのTBTは、それぞれ154、606、1,686、3,596、6,385ミリ秒です。デスクトップ・ページでは、0、1、72、257、601ミリ秒です。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1624036326&format=interactive",
    sheets_gid="947698668",
    sql_file="tbt.sql"
  )
}}

長いタスクに関連するものとして、<a hreflang="ja" href="https://web.dev/i18n/ja/tbt/">総ブロッキング時間（TBT）</a>メトリクスがあり、これは起動中の長いタスクの合計ブロック時間を計算します。

なお、TBTとTTI（下記）は、先のFIDとINPの統計と異なり、実ユーザーのデータを元にしたものではありません。その代わりに、デバイスに適したCPUとネットワークのスロットルを有効にしたデスクトップとモバイル環境の[シミュレーション](./methodology#lighthouse)で、合成パフォーマンスを測定しています。この手法の結果、Webサイト全体に実ユーザーの値が分布するのではなく、各ページで厳密に1つのTBTとTTIの値が得られます。

<a hreflang="en" href="https://github.com/GoogleChromeLabs/chrome-http-archive-analysis/blob/main/notebooks/HTTP_Archive_TBT_and_INP.ipynb">INPはTBTと非常によく相関している</a>ことを考えると、TBTスコアが高いとINPスコアが低くなると考えるのは妥当なことです。合成アプローチを使用すると、デスクトップとモバイルのセグメントの間に大きな隔たりがあります。これは、処理能力とメモリに優れたデスクトップ端末が、性能の劣るモバイル端末を大きく上回っていることを示しています。75パーセンタイルでは、ページのブロック時間が3.6秒近くあり、体験が悪いと認定されます。

{{ figure_markup(
    image="tti.png",
    caption="TTIスコアのオリジン、パーセンタイル別の分布。",
    description="ページの合成TTIの10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページでは、TTIの分布は、それぞれ、5、9、16、27、41秒です。デスクトップ用ページでは、3、5、10、20、32秒となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1458856020&format=interactive",
    sheets_gid="864627793",
    sql_file="time_to_interactive.sql"
  )
}}

最後は、<a hreflang="ja" href="https://web.dev/i18n/ja/tti/">操作可能になるまでの時間（TTI）</a>です。この指標は、5秒未満であれば「良い」と見なされます。10パーセンタイルだけがかろうじて5秒を切っていることから、シミュレーション環境のほとんどのウェブサイトがJavaScriptに依存しており、ページが適切な時間枠内でインタラクティブになることができません。とくに90パーセンタイルでは、インタラクティブになるまでに41.2秒という途方もない時間がかかっています。

### 長いタスク/ブロック時間

前のセクションでおわかりのように、インタラクションの応答性が悪くなる主な原因は、長いタスクです。長いタスクとは、メインスレッドで50ミリ秒以上実行されるタスクのことです。50ミリ秒を超えるタスクの長さは、そのタスクのブロッキング時間であり、タスクの合計時間から50ミリ秒を引くことで計算できます。

長いタスクは、そのタスクが終了するまでメインスレッドが他の作業を行えないようにブロックするため、問題となります。ページに長いタスクがたくさんあると、ブラウザがユーザーの入力に反応するのを遅く感じられることがあります。極端な例では、ブラウザがまったく反応しないように感じることさえあります。

{{ figure_markup(
    image="long-tasks.png",
    caption="ページごとの長いタスクの数の分布。",
    description="ページあたりの長いタスク数の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページでは、1ページあたり、それぞれ5、10、19、32、48の長いタスクが発生しています。デスクトップ・ページでは、1ページあたりの長いタスクが2、3、7、12、19と少なくなっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=563658830&format=interactive",
    sheets_gid="1504800023",
    sql_file="distribution_of_number_of_long_tasks.sql"
  )
}}

中央値のページは、モバイルデバイスで19の長いタスクに遭遇し、デスクトップデバイスでは7の長いタスクに遭遇しています。もっとも、デスクトップ端末はモバイル端末よりも処理能力やメモリリソースが高く、活発に冷却されていることを考えれば、これは理にかなった結果です。

しかし、パーセンタイルが高くなると、状況はかなり悪化します。ページあたり75パーセンタイルでの長いタスクは、モバイルとデスクトップでそれぞれ32と12です。

{{ figure_markup(
    image="long-tasks-time.png",
    caption="ページごとの長時間タスクの時間分布。",
    description="ページあたりの長いタスクの合計時間の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページでは、1ページあたりのロングタスクの時間がそれぞれ781、1,744、3,590、6,570、および10,856ミリ秒でした。デスクトップでは、160、349、738、1,419、2,501ミリ秒と、かなり低い値になっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=970989213&format=interactive",
    sheets_gid="1295792422",
    sql_file="distribution_of_long_tasks_time.sql"
  )
}}

ページごとの長時間のタスクの数を知るだけでは不十分で、それらのタスクがページ上でかかっている総時間を理解する必要があります。モバイルページの中央値では、長時間のタスクに費やされる時間は3.59秒ですが、デスクトップページでは0.74秒とはるかに少なくなっています。

{# TODO(authors): この結果は、ラボでシミュレートされたMoto G4デバイスから得られたものであることを踏まえ、以下の「これらの結果はトラブルを意味する」というビットを言い換えることを検討してみてください。 #}

75パーセンタイルでは、モバイル端末の処理時間が大幅に低下しており、1ページあたり約6.6秒の処理時間が長いタスクの処理に費やされています。これは、ブラウザが最適化できる、あるいは別のスレッドのウェブワーカーに移行できる可能性のある激しい作業に費やしている多くの時間です。いずれにせよ、この結果は、モバイルウェブと応答性に問題があることを示唆しています。

### スケジューラAPI

JavaScriptのタスクのスケジューリングは、歴史的にブラウザに委ねられてきました。新しいメソッドとして、 [`requestIdleCallback`](https://developer.mozilla.org/docs/Web/API/Window/requestIdleCallback)や [`queueMicrotask`](https://developer.mozilla.org/docs/Web/API/queueMicrotask)がありますが、これらのAPIは粗い方法でタスクをスケジュールします。とくに `queueMicrotask` の場合、使い方を誤るとパフォーマンスの問題を引き起こす可能性があります。

Scheduler APIは最近リリースされ、優先順位に基づくタスクのスケジューリングをより細かく制御できるようになりましたが、<a hreflang="en" href="https://caniuse.com/mdn-api_scheduler_posttask">Chromiumベースのブラウザ</a>にしか今のところ限定されていません。

{{ figure_markup(
    caption="Scheduler APIを使用しているモバイルページの割合です。",
    content="0.002%",
    classes="big-number",
    sheets_gid="1872107610",
    sql_file="posttask_scheduler.sql"
  )
}}

現在、Scheduler APIを使用するJavaScriptを搭載しているモバイルページは2千分の1 (0.002%) に過ぎませんが、デスクトップページでは3千分の1 (0.003%) が搭載しています。この非常に新しい機能に関するドキュメントの欠如と、その限定的なサポートを考慮すると、驚くべきことではありません。しかし、この機能に関する文書が利用可能になり、とくにフレームワークで使用されるようになれば、この数は増加すると思われます。この重要な新機能を採用することで、最終的にはより良いユーザー体験の結果が得られると信じています。

### 同期型XHR

AJAX、つまりナビゲーション リクエストなしでページ上のデータを非同期に取得し情報を更新する <a hreflang="en" href="https://developer.mozilla.org/docs/Web/API/XMLHttpRequest">`XMLHttpRequest`</a> (XHR) メソッドの使用は、動的なユーザー体験を生み出す方法として非常に一般的でした。これは主に非同期の [`fetch`](https://developer.mozilla.org/docs/Web/API/Fetch_API)メソッドに取って代わられましたが、XHRは<a hreflang="en" href="https://caniuse.com/mdn-api_xmlhttprequest">すべての主要なブラウザ</a>でまだサポートされています。

XHRには同期的なリクエストを行うためのフラグがあります。<a hreflang="en" href="https://developer.mozilla.org/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests#synchronous_request">同期XHR</a>は、イベントループとメインスレッドがリクエストを終了するまでブロックされ、結果としてデータが利用可能になるまでページが停止するため、パフォーマンス上有害です。`fetch` は、よりシンプルなAPIで、より効果的かつ効率的な代替手段であり、データの同期取得はサポートされていません。

{{ figure_markup(
    caption="モバイルページで同期XHRを使用している割合です。",
    content="2.5%",
    classes="big-number",
    sheets_gid="1908785275",
    sql_file="sync_requests.sql"
  )
}}

同期XHRはモバイルページの2.5%、デスクトップページの2.8%で使用されているだけですが、どんなに小規模であっても、その使用が続いていることは一部のレガシーアプリケーションがこの時代遅れの手法に依存している可能性があり、ユーザー体験を損なうシグナルであることに変わりはありません。

同期XHR、および一般的なXHRの使用は避けてください。`fetch` はより人間工学的な代替手段ですが、設計上同期的な機能はありません。同期XHRを使わない方がページのパフォーマンスは良くなりますし、いつの日かこの数がゼロになることを望んでいます。

### `document.write`

DOMの挿入メソッド（[`appendChild`](https://developer.mozilla.org/docs/Web/API/Node/appendChild)など）が導入される前は、<a hreflang="ja" href="https://developer.mozilla.org/docs/Web/API/Document/write">`document.write`</a>を使用して、ドキュメント内の `document.write` が行われた位置にコンテンツを挿入しました。

`document.write` は非常に問題があります。ひとつにはHTMLパーサをブロックしてしまうこと、そして他の多くの理由から問題があり、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dynamic-markup-insertion.html#document.write()">HTMLの仕様書では、その使用について警告しています</a>。低速な接続では、この方法でノードを追加するためにドキュメントの解析をブロックすると、完全に回避可能なパフォーマンスの問題が発生します。

{{ figure_markup(
    caption="`document.write`を使用したモバイルページの数です。",
    content="18%",
    classes="big-number",
    sheets_gid="809741499",
    sql_file="usage_of_document_write.sql"
  )
}}

観測されたページの18%は、適切な挿入方法の代わりに `document.write` を使ってDOMにコンテンツを追加しており、一方、デスクトップページの17%はまだそうしていることがわかりました。これは、ドキュメントに新しいノードを挿入するために望ましいDOMメソッドを使用するように書き換えられていないレガシーアプリケーションや、サードパーティのスクリプトがまだこれを使用していることが原因であると思われます。

この傾向が弱まることを期待します。すべての主要なブラウザは、このメソッドを使用しないよう明確に警告しています。まだ非推奨ではありませんが、今後数年間のブラウザでの存在も保証されていません。もし `document.write` の呼び出しがあなたのウェブサイトにあるのなら、できるだけ早く取り除くことを優先させるべきでしょう。

### レガシーJavaScript

JavaScriptはここ数年でかなり進化しています。新しい言語機能の導入により、JavaScriptはより有能でエレガントな言語となり、開発者はより簡潔なJavaScriptを書くことができるようになり、結果としてJavaScriptの読み込み量が減りました。ただし、それらの機能がBabelのような[transpiler](#トランスパイラ)を使って不必要に古い構文に変換されていないことが条件です。

Lighthouseは現在、[`async` と `await`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/async_function)や [JavaScript クラス](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Classes)などの新しい、しかし広くサポートされている言語機能のトランスフォームなど、現代のウェブでは不要かもしれないBabelトランスフォームをチェックします。

{{ figure_markup(
    caption="レガシーJavaScriptを搭載しているモバイルページの割合です。",
    content="67%",
    classes="big-number",
    sheets_gid="1408995244",
    sql_file="usage_of_legacy_javascript.sql"
  )
}}

モバイルページの3分の2強は、トランスフォームされているJavaScriptリソースを出荷しているか、あるいは不要なレガシーJavaScriptを含んでいます。

トランスフォームは互換性のためにプロダクションのJavaScriptに多くのバイトを追加しますが、古いブラウザをサポートする必要がない限り、これらのトランスフォームの多くは不要であり、起動時のパフォーマンスに悪影響を与える可能性があります。モバイルでは非常に多くのページが、デスクトップでは68% のページが、このようなトランスフォームを実装していることが気になります。

Babelは<a hreflang="en" href="https://babeljs.io/docs/en/assumptions">コンパイラの仮定機能</a>などを通じて、この問題を解決するために多くのことを行っていますが、Babelはまだユーザー定義の設定によって動いており、古い設定ファイルの存在下では多くのことを行うことができるだけです。

前述のように開発者には、<a hreflang="en" href="https://babeljs.io/docs/en/configuration">Babel</a>と<a hreflang="en" href="https://github.com/browserslist/browserslist">Browserslist</a>の設定を慎重に見直し、必要なブラウザで動作するように、最小限のトランスフォームがコードに適用されているかどうか確認することを強く推奨します。そうすることで、エンドユーザーへの出荷バイト数を大幅に削減できます。このあたりは開発者の腕の見せ所ですが、言語の進化が比較的安定してきた今、この数字が時間とともに減少することを期待しています。

## JavaScriptはどのように使われているのですか？

Webページを構築する方法は1つだけではありません。ウェブプラットフォームを直接使うことを選ぶ人もいるかもしれませんが、ウェブ開発者業界のトレンドは、私たちの仕事をやりやすく、推論しやすくする抽象化されたものに手を伸ばすことであることは否定できません。例年通り、ライブラリやフレームワークの役割と、それらのライブラリやフレームワークがユーザーにとってウェブをより危険な場所にする可能性のあるセキュリティ上の脆弱性をどの程度頻繁に提示するかを探っていきます。

### ライブラリとフレームワーク

ライブラリとフレームワークは、開発者の体験の大きな部分を占めますが、フレームワークのオーバーヘッドによってパフォーマンスが損なわれる可能性もあります。開発者はこのトレードオフを概ね受け入れていますが、ウェブで一般的に使用されているライブラリとフレームワークを理解することは、ウェブがどのように構築されているかを理解する上で非常に重要です。このセクションでは、2022年のウェブにおけるライブラリとフレームワークの状態について見ていきます。

#### ライブラリの利用状況

ライブラリやフレームワークの利用状況を把握するために、HTTP Archiveでは[Wappalyzer](./methodology#wappalyzer)を使って、ページで使われている技術を検出しています。

{{ figure_markup(
    image="frameworks-libraries.png",
    caption="もっとも多いライブラリやフレームワークの採用。",
    description="もっとも多いJavaScriptライブラリとフレームワークを使用しているページの割合を示す棒グラフです。もっとも普及しているものから順に、モバイルページの81%でjQueryが使用されており、次いでcore-jsが41%、jQuery Migrateで34%、jQuery UIでは23%、Modernizrは13%、Lodash、LazySizes、OWL Carouselが9%、React、FancyBox、Slick、GSAPが8%、Isonopでは7%、Underscore.jsおよびLightboxは6%となる。デスクトップでの採用もほぼ同じです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTok8UGqYaA58uKaASB2pfM2jlmQu6g3kwHxB6Lb8L7dbccyDtQht823YhchdXRG8SZpB3asRayJI97/pubchart?oid=1455350286&format=interactive",
    height="491",
    sheets_gid="582575220",
    sql_file="frameworks_libraries.sql"
  )
}}

jQueryが今日のWebでもっとも使用されているライブラリであることは、いまだ驚くに値しない。WordPressが[35%](./cms#もっとも普及しているCMS)のサイトで使用されていることも理由の1つですが、それでもjQueryの使用の大半はWordPressプラットフォーム以外での使用です。

jQueryは比較的小さく、動作もそれなりに速いのですが、それでもアプリケーションの中ではある程度のオーバーヘッドを占めます。jQueryが提供するもののほとんどは、現在では<a hreflang="en" href="https://youmightnotneedjquery.com/">ネイティブDOM APIで可能</a>であり、今日のWebアプリケーションでは不要かもしれません。

多くのウェブアプリケーションがBabelでコードをトランスフォームし、ブラウザ間のAPIの欠落を埋めるためにcore-jsを使用することが多いため、core-jsの使用は驚くべきことでありません。ブラウザが成熟するにつれて、この数字は下がるはずです。これは実に良いことで、最近のブラウザはこれまで以上に高性能となっており、core-jsのコードを提供してもムダなバイトに終わる可能性があるからです。

Reactの利用状況は昨年と変わらず8％で、JavaScriptのエコシステムの選択肢が増えたため、ライブラリの利用が頭打ちになったことを示唆しているのかもしれない。

#### 併用するライブラリ

同じページで複数のフレームワークやライブラリが使われているのは、決して珍しいシナリオではありません。昨年に引き続き、この現象を検証することで、2022年にどれだけのライブラリとフレームワークが併用されたかを洞察します。

<figure>
  <table>
    <thead>
      <tr>
        <th>ライブラリ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">10.19%</td>
        <td class="numeric">10.33%</td>
      </tr>
      <tr>
        <td>jQuery、jQueryマイグレート</td>
        <td class="numeric">4.30%</td>
        <td class="numeric">4.94%</td>
      </tr>
      <tr>
        <td>core-js、jQuery、jQueryマイグレート</td>
        <td class="numeric">2.48%</td>
        <td class="numeric">2.80%</td>
      </tr>
      <tr>
        <td>core-js、jQuery</td>
        <td class="numeric">2.78%</td>
        <td class="numeric">2.74%</td>
      </tr>
      <tr>
        <td>jQuery、jQuery UI</td>
        <td class="numeric">2.40%</td>
        <td class="numeric">2.07%</td>
      </tr>
      <tr>
        <td>core-js、jQuery、jQueryマイグレート、jQuery UI</td>
        <td class="numeric">1.18%</td>
        <td class="numeric">1.36%</td>
      </tr>
      <tr>
        <td>jQuery、jQueryマイグレート、jQuery UI</td>
        <td class="numeric">0.88%</td>
        <td class="numeric">0.99%</td>
      </tr>
      <tr>
        <td>GSAP、Lodash、Polyfill、React</td>
        <td class="numeric">0.48%</td>
        <td class="numeric">0.93%</td>
      </tr>
      <tr>
        <td>Modernizr、jQuery</td>
        <td class="numeric">0.87%</td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td>core-js</td>
        <td class="numeric">0.92%</td>
        <td class="numeric">0.85%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="観測されたページで併用されているライブラリやフレームワークの解析。",
    sheets_gid="1200090523",
    sql_file="frameworks_libraries_combos.sql"
  ) }}</figcaption>
</figure>

jQuery、UIフレームワーク、マイグレーションプラグインの組み合わせが上位7位を占め、core-jsもライブラリの利用状況において重要な役割を果たしていることから、jQueryが大きな力を秘めていることは明らかです。

#### セキュリティの脆弱性

今日のWebではJavaScriptが広く普及しており、インストール可能なJavaScriptパッケージの出現により、JavaScriptのエコシステムにセキュリティ上の脆弱性が存在することは驚くことでありません。

{{ figure_markup(
    caption="脆弱性のあるJavaScriptのライブラリやフレームワークをダウンロードしたモバイルページの割合です。",
    content="57%",
    classes="big-number",
    sheets_gid="1881889053",
    sql_file="lighthouse_vulnerabilities.sql"
  )
}}

モバイルページの57%が脆弱なJavaScriptライブラリまたはフレームワークを提供していることは重要ですが、この数字は昨年の64%から減少しています。これは心強いことですが、この数字を下げるにはかなりの努力が必要です。より多くのセキュリティ脆弱性にパッチが適用されることで、開発者が依存関係を更新し、ユーザーを危険にさらすことを回避する動機付けになることを期待しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ライブラリまたはフレームワーク</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">49.12%</td>
        <td class="numeric">48.80%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">16.01%</td>
        <td class="numeric">14.88%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">11.53%</td>
        <td class="numeric">11.19%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">4.54%</td>
        <td class="numeric">3.91%</td>
      </tr>
      <tr>
        <td>Underscore</td>
        <td class="numeric">3.41%</td>
        <td class="numeric">3.11%</td>
      </tr>
      <tr>
        <td>Lo-Dash</td>
        <td class="numeric">2.52%</td>
        <td class="numeric">2.44%</td>
      </tr>
      <tr>
        <td>GreenSock JS</td>
        <td class="numeric">1.65%</td>
        <td class="numeric">1.62%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.27%</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><a href="https://angularjs.org">AngularJS</a></td>
        <td class="numeric">0.99%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.44%</td>
        <td class="numeric">0.57%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="もっとも多く利用されているライブラリやフレームワークの上位10位までのうち、JavaScriptの既知の脆弱性を持つページの割合です。",
    sheets_gid="1532536873",
    sql_file="lighthouse_vulnerable_libraries.sql"
  ) }}</figcaption>
</figure>

jQueryは現在Web上でもっとも普及しているライブラリであり、jQueryとそれに関連するUIフレームワークが、現在Web上でユーザがさらされているセキュリティ脆弱性のかなりの部分を代表していることは、驚くことではありません。これは、一部の開発者が、既知の脆弱性に対する修正を利用していない旧バージョンのスクリプトをまだ使用していることが、原因である可能性があります。

Bootstrapは、開発者が[CSS](./css)を直接使用せずに、素早くプロトタイプや新しいレイアウトを構築できるようにするUIフレームワークで、注目すべきエントリーであると言えます。GridやFlexboxなどの新しいCSSレイアウトモードがリリースされれば、Bootstrapの使用は減少し、代わりに開発者がBootstrapの依存関係を更新して、より安全でセキュアなウェブサイトを提供できるようになるかもしれません。

どのようなライブラリやフレームワークを使用しているかにかかわらず、ユーザを危険にさらすことを避けるために、可能な限り依存関係を定期的に更新するようにしてください。パッケージの更新により、リファクタリングやコードの修正を発生させることがありますが、その労力は、責任の軽減とユーザーの安全性の向上に見合うものです。

### ウェブコンポーネントとシャドウDOM

これまでWeb開発では、多くのフレームワークで採用されているコンポーネント化モデルが推進されてきました。Webプラットフォームも同様に、Webコンポーネントとshadow DOMを通じてロジックとスタイリングのカプセル化を提供するように進化してきました。今年の分析の手始めとして、<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/customelements">カスタム要素</a>から始めます。

{{ figure_markup(
    caption="カスタムエレメントを使用したデスクトップページの割合です。",
    content="2.0%",
    classes="big-number",
    sheets_gid="170257316",
    sql_file="web_components_pct.sql"
  )
}}

この数字は、昨年のデスクトップページでのカスタム要素使用率の分析結果である3%から少し減少しています。カスタム要素が提供する利点と、モダンブラウザでのそれなりに幅広いサポートにより、ウェブコンポーネントモデルが開発者にウェブプラットフォームの組み込み要素を活用し、より高速なユーザー体験を実現することを促してくれることを期待しています。

{{ figure_markup(
    caption="モバイルページでシャドウDOMが使用されている割合。",
    content="0.39%",
    classes="big-number",
    sheets_gid="170257316",
    sql_file="web_components_pct.sql"
  )
}}

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/shadowdom">シャドウDOM</a>は、サブ要素やスタイリングのための独自のスコープを含む専用のノードをドキュメント内に作成し、メインDOMツリーからコンポーネントを分離することができるようにします。シャドウDOMを使用しているページは全体の0.37%という昨年の数値と比較すると、モバイルページで0.39%、デスクトップページでは0.47%と、その採用率はほぼ横ばいとなっていることがわかります。

{{ figure_markup(
    caption="モバイルページでテンプレートが使用されている割合。",
    content="0.05%",
    classes="big-number",
    sheets_gid="170257316",
    sql_file="web_components_pct.sql"
  )
}}

`template` 要素は、開発者がマークアップのパターンを再利用するのに役立ちます。テンプレートは、JavaScriptから参照されたときのみ、その内容を表示します。テンプレートはWebコンポーネントとうまく機能します。JavaScriptからまだ参照されていないコンテンツは、シャドウDOMを使ってシャドウルートに追加されるからです。

現在、デスクトップとモバイルの両方で、およそ0.05%のウェブページが `template` 要素を使用しています。テンプレートはブラウザで十分にサポートされていますが、現在その採用はほとんどありません。

{{ figure_markup(
    caption="`is` 属性を使用したモバイルページの割合です。",
    content="0.08%",
    classes="big-number",
    sheets_gid="1386786307",
    sql_file="web_components_is_attribute.sql"
  )
}}

HTMLの[`is`](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/is)属性は、カスタム要素をページに挿入するための代替手段です。カスタム要素の名前をHTMLタグとして使用するのではなく、その名前は任意の標準的なHTML要素に渡され、ウェブコンポーネントのロジックが実装されます。`is` 属性は、ウェブコンポーネントがページに登録できなかった場合でも、標準的なHTML要素の動作にフォールバックすることができるウェブコンポーネントを使用する方法です。

この属性の使用状況を追跡するのは今年がはじめてですが、当然のことながら、その採用率はカスタム要素そのものよりも低くなっています。Safariがサポートされていないため、iOSのブラウザとmacOSのSafariはこの属性を利用できず、この属性の利用が限定的である一因になっている可能性があります。

## 結論

JavaScriptの状況は、昨年のトレンドが示唆するように、ほぼ継続しています。確かに提供数は増えていますが、minifiation、リソースヒント、圧縮、さらには使用するライブラリに至るまで、さまざまなテクニックを利用することで過剰なJavaScriptの悪影響を軽減しようとしています。

JavaScriptの状況は常に進化しています。私たちがこれまで以上にJavaScriptへ依存していることは明らかですが、これはウェブの総合的なユーザー体験にとって問題をもたらすものです。私たちは、プロダクションウェブサイトに搭載されるJavaScriptの量を減らすために、できる限りのことをする必要があり、またそれ以上のことをする必要があります。

ウェブプラットフォームが成熟するにつれ、そのさまざまなAPIや機能を直接採用することが意味のあることであれば、より多く採用されるようになることを期待しています。より良い開発者体験のためにフレームワークを必要とする体験については、さらなる最適化と、フレームワークの作者がより良い開発者体験とユーザー体験の両方を開発するために新しいAPIを採用する機会があることを期待しています。

来年は、その流れが変わることを期待したい。その間、<a hreflang="ja" href="https://web.dev/i18n/ja/fast/">できる限りWebを速くするために</a>、<a hreflang="en" href="https://web.dev/lab-and-field-data-differences/#lab-data">lab</a>と<a hreflang="en" href="https://web.dev/lab-and-field-data-differences/#field-data">field</a>両データに目を向けつつできる限りのことを続けていこうではありませんか。
