---

#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: 2024年版Web AlmanacのJavaScriptの章では、Web上でのJavaScriptの使用状況、ライブラリとフレームワーク、圧縮、Webコンポーネント、ソースマップについて解説します。
hero_alt: Web Almanacのキャラクターが自転車をこいでウェブサイトに電力を供給しているヒーロー画像。
authors: [haddiamjad, NishuGoel]
reviewers: [tunetheweb]
editors: [tunetheweb]
analysts: [onurguler18, nrllh]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/16isMe5_rvmRmJHtK5Je66AhwO8SowGgq0EFqXyjEXw8/
featured_quote: JavaScriptへの過度な依存には、妥協が必要です。ダウンロードやパースから実行までの各段階で、ブラウザのリソースを大量に消費します。使用が少なすぎるとユーザー体験やビジネス目標に影響を与え、多すぎると読み込みが遅くなり、ページが応答しなくなり、ユーザーのエンゲージメントが低下する可能性があります。
featured_stat_1: 14%
featured_stat_label_1: モバイルのJavaScriptバイト数の中央値の増加
featured_stat_2: 47%
featured_stat_label_2: モバイルの未使用JavaScriptの中央値
featured_stat_3: 30%
featured_stat_label_3: Webワーカーを使用しているページ
doi: 10.5281/zenodo.14962516
---

## はじめに

JavaScriptは、基本的なアニメーションから高度な機能まで、インタラクティブなWeb体験を作り出すために不可欠です。その発展により、Webの動的な機能が大幅に向上しました。

しかし、JavaScriptへの過度な依存には、妥協が必要です。ダウンロードやパースから実行までの各段階で、ブラウザのリソースを大量に消費します。使用が少なすぎるとユーザー体験やビジネス目標に影響を与え、多すぎると読み込みが遅くなり、ページが応答しなくなり、ユーザーのエンゲージメントが低下する可能性があります。

この章では、Web上でのJavaScriptの役割を再評価し、スムーズで効率的なユーザー体験を設計するための推奨事項を提供します。

## どのくらいのJavaScriptを読み込んでいるのか？

Web開発者がデプロイしているJavaScriptの量を分析します。現状を明確に把握することは、効果的な改善を推進するために重要です。

{{ figure_markup(
  image="median-javascript-kilobytes-per-page.png",
  caption="ページあたりのJavaScriptの中央値（キロバイト）。",
  description="2019年から2024年までのJavaScript使用量の中央値を示す棒グラフ。デスクトップのJavaScriptの中央値は、2019年の391キロバイトから、444、463、509、538、そして2024年には613キロバイトに増加。モバイルでは、2019年の359キロバイトから、411、427、461、491、そして2024年には558キロバイトに増加。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1181894330&format=interactive",
  sheets_gid="1824580205",
  sql_file="bytes_2024.sql"
  )
}}

JavaScriptの量は継続的に増加しています。2024年には、この上昇傾向が続き、モバイルで558キロバイト、デスクトップで613キロバイトに達し、中央値のJavaScriptペイロードが14%増加しました。この継続的な傾向は懸念すべきものです。デバイスの性能は向上していますが、最新のテクノロジーにアクセスできる人は限られています。大きなJavaScriptバンドルは、デバイスのリソースに追加の負荷をかけ、とくに古いまたは性能の低いハードウェアを使用するユーザーのパフォーマンスに影響を与えます。

## ページあたりのJavaScriptリクエスト数はいくつか？

Webページ上の各リソースは少なくとも1つのリクエストを引き起こしますが、そのリソースが他のリソースを引き込むと、急速に増加する可能性があります。

{{ figure_markup(
  image="median-javascript-requests-per-page.png",
  caption="ページあたりのJavaScriptリクエストの中央値。",
  description="2019年から2024年までのJavaScriptリクエストの中央値を示す棒グラフ。デスクトップでは2019年の19から2024年には23に、モバイルでは18から22に増加。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2056554025&format=interactive",
  sheets_gid="342139378",
  sql_file="requests_2024.sql"
  )
}}

スクリプトリクエストの場合、リスクはさらに高くなります。リクエストを多く送信するほど、より多くのJavaScriptを読み込むことになり、これらのスクリプトがメインスレッドで競合する可能性が高くなります。このリソースの競合により、パフォーマンスが低下し、起動が遅延し、ユーザーを待たせることになります。

2024年、モバイルページの中央値は22のJavaScriptリクエストを行い、90パーセンタイルでは68に達します。これは、中央値で1つ、90パーセンタイルで4つのリクエストが前年比で増加したことを示しています。

デスクトップでは、状況は同様です。中央値は23のJavaScriptリクエストに増加し、90パーセンタイルでは70リクエストに達します。ここでも、中央値で1つ、90パーセンタイルで5つのリクエストが増加しており、モバイルで観察される傾向と一致しています。

これらの増加は一見控えめに見えるかもしれませんが、Webの動作の継続的な進化を示しています。Web Almanacが2019年に開始されて以来、JavaScriptリクエストは着実に増加しており、将来、この増加がパフォーマンスの改善を大幅に上回る可能性があることを示唆しています。これは、JavaScriptが重いWebの複雑さを乗り越えながら、開発者とユーザーの両方にとって何を意味するのでしょうか？

{{ figure_markup(
  image="distribution-of-unused-javascript.png",
  caption="未使用JavaScriptの分布。",
  description="パーセンタイル別の未使用JavaScriptバイトを示す棒グラフ。デスクトップでは、10パーセンタイルで21キロバイト、25パーセンタイルで87キロバイト、中央値で235キロバイト、75パーセンタイルで509キロバイト、90パーセンタイルで923キロバイト。モバイルでは、10パーセンタイルで0キロバイト、25パーセンタイルで74キロバイト、中央値で206キロバイト、75パーセンタイルで450キロバイト、90パーセンタイルで818キロバイト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=762521448&format=interactive",
  sheets_gid="1175581542",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

JavaScriptの増加とともに、ページ読み込み時にダウンロードされたバイトの約半分（モバイルでは中央値で206キロバイト—配信されたバイトの44%）が未使用であることがわかります。

## JavaScriptのパッケージはどのように処理されるのですか？

Web開発の急速な世界では、JavaScriptの読み込み方法がサイトのパフォーマンスを左右する可能性があります。ページレンダリングを遅くする可能性のある同期的な読み込みから、速度を向上させる非同期技術まで、開発者はさまざまなオプションを利用できます。課題は、JavaScriptのインタラクティブ性の力と、迅速でシームレスなユーザー体験の必要性のバランスを取ることです。最適な読み込み戦略を習得することで、Webクリエイターはサイトの応答性とユーザー満足度を大幅に向上させることができます。

### バンドラー

JavaScriptバンドラー（webpackやParcelなど）は、複数のJavaScriptファイルを1つのバンドルにパッケージ化してユーザーへの配信を効率化します。コードとその依存関係を分析し、HTTPリクエストの数を減らすために最終的な出力を最適化します。ファイルを結合することで、バンドラーは読み込み時間とパフォーマンスを改善できます。ただし、これらのツールは機能的なコードとユーザートラッキングスクリプトを意図せずに絡み合わせてしまい、パフォーマンスとプライバシーの考慮事項を複雑にする可能性があります。

{{ figure_markup(
  image="sites-using-webpack-grouped-by-rank.png",
  caption="ランク別のwebpack使用サイト。",
  description="ランク別のwebpack使用率を示す棒グラフ。デスクトップでは上位1,000サイトで15%、上位10,000サイトで17%、上位100,000サイトで13%、上位100万サイトで9%、上位1,000万サイトで6%、全サイトで6%。モバイルでは上位1,000サイトで13%、上位10,000サイトで16%、上位100,000サイトで13%、上位100万サイトで9%、上位1,000万サイトと全サイトで5%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=784514302&format=interactive",
  sheets_gid="1114140412",
  sql_file="usage_of_webpack_by_rank.sql"
  )
}}

webpackの使用率は全体的に5%で安定していますが、最近の傾向では、モバイルとデスクトップの両方で上位1,000サイトでの採用が減少しています。5%は控えめに見えるかもしれませんが、Web Almanacのサイト全体でみると依然として相当な数を示しています。

{{ figure_markup(
  image="sites-using-parcel-grouped-by-rank.png",
  caption="ランク別のParcel使用サイト。",
  description="ランク別のParcel使用率を示す棒グラフ。デスクトップでは上位1,000サイトで0.32%、上位10,000サイトで0.40%、上位100,000サイトで0.51%、上位100万サイトで0.65%、上位1,000万サイトで0.54%、全サイトで0.49%。モバイルでは上位1,000サイトで0.26%、上位10,000サイトで0.28%、上位100,000サイトで0.43%、上位100万サイトで0.58%、上位1,000万サイトで0.44%、全サイトで0.34%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=989440772&format=interactive",
  sheets_gid="422902451",
  sql_file="usage_of_parcel_by_rank.sql"
  )
}}

Parcelはwebpackに次ぐ2番目に人気のある選択肢として、開発者の間で注目すべき採用率を誇っています。しかし、最近の傾向では使用率が低下しており、昨年のモバイルウェブサイトの1.3%から今年は0.3%に減少しています。デスクトップでも同様のパターンが見られ、JavaScriptバンドラーの状況が変化していることを示しています。

### トランスパイラー

2022年のWeb Almanacでは、[ソースマップが利用可能なサイトに対するトランスパイラーの割合を調査](../2022/javascript#トランスパイラ)しました。今年は、全サイトに対する割合に変更しました。この方法論の変更により、サイトの過剰カウント（ソースマップを使用しているサイトは、定義上、トランスパイルが必要な複雑なWebアプリケーションである可能性が高い）から、過小カウント（すべてのサイトが公開ソースマップを公開しているわけではない）に移行しています。

{{ figure_markup(
  image="sites-using-babel-grouped-by-rank.png",
  caption="ランク別のBabel使用サイト。",
  description="ランク別のBabel使用率を示す棒グラフ。デスクトップでは上位1,000サイトで7.6%、上位10,000サイトで8.9%、上位100,000サイトで6.9%、上位100万サイトで4.7%、上位1,000万サイトで4.1%、全サイトで5.3%。モバイルでは上位1,000サイトで9.9%、上位10,000サイトで12.0%、上位100,000サイトで9.1%、上位100万サイトで5.8%、上位1,000万サイトで4.7%、全サイトで6.1%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2030733123&format=interactive",
  sheets_gid="1658473552",
  sql_file="usage_of_typescript_and_babel_by_rank.sql"
  )
}}

Babelは上位ランクのウェブサイトで特に普及しており、上位10,000のモバイルサイトの12%がBabelを使用しています（これはソースマップを使用しているサイトの23%～38%で、[昨年のBabelの結果](../2022/javascript#fig-6)と同様です）。モバイルサイトは、ランクに関係なく、デスクトップサイトよりも一貫して高い採用率を示しています。これらの傾向は、とくに上位層やモバイル最適化されたサイトにおけるBabelの重要性を浮き彫りにし、モダンなWeb開発における重要性の高まりを示しています。

#### TypeScriptはどのくらい使用されているか？

TypeScriptはJavaScriptのスーパーセットで、静的型を追加し、開発中のエラーを捕捉しやすくし、コードの保守性を向上させます。これらのツールは開発プロセスを効率化し、ブラウザ間の互換性を確保します。

{{ figure_markup(
  image="sites-using-typescript-grouped-by-rank.png",
  caption="ランク別のTypeScript使用サイト。",
  description="ランク別のTypeScript使用率を示す棒グラフ。デスクトップでは上位1,000サイトで5.2%、上位10,000サイトで6.7%、上位100,000サイトで6.1%、上位100万サイトで5.5%、上位1,000万サイトで4.9%、全サイトで6.0%。モバイルでは上位1,000サイトで4.5%、上位10,000サイトで6.2%、上位100,000サイトで5.7%、上位100万サイトで5.4%、上位1,000万サイトで4.9%、全サイトで6.2%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=295342967&format=interactive",
  sheets_gid="1658473552",
  sql_file="usage_of_typescript_and_babel_by_rank.sql"
  )
}}

全ランクにおいて、約6%のページがTypeScriptを使用しており、モバイルの方がやや高い採用率を示しています。これは、ソースマップを公開しているサイトのみをカウントしていることに注意してください。使用率はおおむね一定していますが、上位ランク（1,000）のページは、下位ランクのページと比較してTypeScriptの採用率がやや低くなっています。

## JavaScriptはどのようにリクエストされるのか？

Web開発の急速な世界では、JavaScriptの読み込み方法がサイトのパフォーマンスを左右する可能性があります。ページレンダリングを遅くする可能性のある同期的な読み込みから、速度を向上させる非同期技術まで、開発者はさまざまなオプションを利用できます。課題は、JavaScriptのインタラクティブ性の力と、迅速でシームレスなユーザー体験の必要性のバランスを取ることです。最適な読み込み戦略を習得することで、Webクリエイターはサイトの応答性とユーザー満足度を大幅に向上させることができます。

### `async`、`defer`、`module`、`nomodule`

When optimizing JavaScript loading, developers have several powerful attributes at their disposal.

`async`属性は、HTMLの解析を継続しながらスクリプトを非同期で読み込み、利用可能になった時点で即座に実行します。一方、`defer`はHTMLの解析が完了するまでスクリプトの実行を遅延させ、遅延されたスクリプトの順序を維持します。

モダンなWebアプリケーションでは、`module`属性はスクリプトがJavaScriptモジュールであることを示し、ES6のimport/export構文と厳格モードをデフォルトで有効にします。これを補完する`nomodule`属性は、ES6モジュールをサポートしていないブラウザ用のフォールバックスクリプトを指定し、より広い互換性を確保しながら、モダンブラウザではこれらのフォールバックを無視できるようにします。これらの属性を戦略的に使用することで、開発者はページのパフォーマンスとユーザー体験を最適化するためにスクリプトの読み込み動作を微調整できます。

{{ figure_markup(
  image="how-is-javascript-requested.png",
  caption="JavaScriptはどのようにリクエストされているか？",
  description="デスクトップでは、`async`が87%のサイトで使用され、`defer`が48%、`async`と`defer`の両方が22%、`module`が4%、`nomodule`が0%、`async`も`defer`も使用していないのが11%のサイトです。モバイルではほぼ同じで、`async`が87%のサイトで使用され、`defer`が47%、`async`と`defer`の両方が22%、`module`が4%、`nomodule`が0%、`async`も`defer`も使用していないのが11%のサイトです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1907402404&format=interactive",
  sheets_gid="901949116",
  sql_file="breakdown_of_pages_using_async_defer.sql"
  )
}}

[2022年のWeb Almanac](../2022/javascript#async-defer-moduleとnomodule)から2024年までのJavaScriptの読み込みトレンドを比較すると、開発者の実践に顕著な変化が見られます。`async`属性の使用は、デスクトップとモバイルの両方で76%から87%に大幅に増加しました。`defer`属性の使用は、42%から47%と控えめな増加を見せています。`async`と`defer`の組み合わせは、28-29%から22%にわずかに減少しており、これは開発者が一方の方法を選択するようになった可能性があります。

`module`の使用は4%と低いままで、`nomodule`はほぼゼロの採用率を示しており、モダンなJavaScriptモジュールシステムがまだWeb全体で広く実装されていないことを示しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>属性</th>
        <th>2022</th>
        <th>2024</th>
        <th>変化率</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>async</code></td>
        <td class="numeric">47.2%</td>
        <td class="numeric">49.5%</td>
        <td class="numeric">4.8%</td>
      </tr>
      <tr>
        <td><code>defer</code></td>
        <td class="numeric">9.1%</td>
        <td class="numeric">13.0%</td>
        <td class="numeric">43.3%</td>
      </tr>
      <tr>
        <td><code>async</code>と<code>defer</code></td>
        <td class="numeric">3.1%</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">-3.0%</td>
      </tr>
      <tr>
        <td><code>module</code></td>
        <td class="numeric">0.4%</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">208.8%</td>
      </tr>
      <tr>
        <td><code>nomodule</code></td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">N/A</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="スクリプト別のJavaScriptリクエスト（モバイル）。", sheets_gid="8375823", sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql") }}</figcaption>
</figure>

2022年から2024年までの`<script>`タグのトレンドを比較すると、スクリプト全体での`async`の使用は4.8%増加し、優位性を維持しています。一方、`defer`属性の使用は、2024年のモバイルで9.1%から13.0%に大幅に増加しました。`async`と`defer`の組み合わせはわずかに減少しています。`module`属性は使用量が3倍になりましたが、デスクトップとモバイルの両方で依然として採用率は低いままです。

### `preload`、`prefetch`と`modulepreload`

リソースヒントは、どのリソースを早期にフェッチするかを示すことで、ブラウザのパフォーマンスを最適化する重要な役割を果たします。`preload`は現在のナビゲーションに必要なリソースをフェッチするために使用され、重要なアセットが必要になった時点ですぐに利用できるようにします。`modulepreload`は同様の目的を果たしますが、JavaScriptモジュールのプリロードに特化しており、モジュラースクリプトを効率的に読み込むのに役立ちます。一方、`prefetch`は次のナビゲーションで必要になるリソース用に設計されており、ブラウザが将来のページ遷移を予測して準備できるようにします。

{{ figure_markup(
  image="resource-hints-adoption-for-javascript-resources.png",
  caption="JavaScriptリソースのリソースヒント採用状況。",
  description="JavaScriptリソースのリソースヒント採用状況を示す棒グラフ。デスクトップでは`prefetch`が5.1%のページで使用され、`preload`が7.7%、`modulepreload`が0.7%のページで使用されています。モバイルでも同様で、`prefetch`が4.8%のページで使用され、`preload`が7.5%、`modulepreload`が0.7%のページで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=516338021&format=interactive",
  sheets_gid="724748185",
  sql_file="resource-hints-prefetch-preload-modulepreload-percentage.sql"
  )
}}

2022年から2024年までのリソースヒントの採用トレンドを比較すると、`preload`の使用率は[2022年のデスクトップでの16.4%](../2022/javascript#preload-prefetchとmodulepreload)から2024年には全体で7.5%に大幅に減少しました。`prefetch`の採用率は2022年の約1.0%から2024年には全体で4.8%に大幅に増加しました。`modulepreload`の使用率は両年とも非常に低く、2022年は約0.1%、2024年も同様に低い0.7%となっています。

{{ figure_markup(
  image="distribution-of-prefetch-adoption-for-javascript-resources-per-page.png",
  caption="ページあたりのJavaScriptリソースの`prefetch`採用分布。",
  description="JavaScriptリソースの`prefetch`採用状況をパーセンタイル別に示す棒グラフ。デスクトップでは10パーセンタイルで2リソース、25パーセンタイルで12リソース、50パーセンタイル、75パーセンタイル、90パーセンタイルで15リソースがプリフェッチされています。モバイルではほぼ同じで、10パーセンタイルで2リソース、25パーセンタイルで10リソース、50パーセンタイル、75パーセンタイル、90パーセンタイルで15リソースがプリフェッチされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=598973620&format=interactive",
  sheets_gid="1228269471",
  sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

JavaScriptリソースの`prefetch`採用分布（`prefetch`を使用しているページの中で）は、中央値から90パーセンタイルまで15のプリフェッチヒントでピークに達しています。

{{ figure_markup(
  image="distribution-of-preload-adoption-for-javascript-resources-per-page.png",
  caption="ページあたりのJavaScriptリソースの`preload`採用分布。",
  description="JavaScriptリソースの`preload`採用状況をパーセンタイル別に示す棒グラフ。デスクトップとモバイルで同じ数値で、10パーセンタイル、25パーセンタイル、50パーセンタイルで1リソース、75パーセンタイルで3リソース、90パーセンタイルで6リソースがプリロードされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=388378073&format=interactive",
  sheets_gid="1228269471",
  sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

`preload`を使用しているページでは、中央値で1つの`preload`のみが使用され、90パーセンタイルで6つまで増加しています。

{{ figure_markup(
  image="distribution-of-modulepreload-adoption-for-javascript-resources-per-page.png",
  caption="ページあたりのJavaScriptリソースの`modulepreload`採用分布。",
  description="JavaScriptリソースの`modulepreload`採用状況をパーセンタイル別に示す棒グラフ。デスクトップでは10パーセンタイルで1リソース、25パーセンタイルで4リソース、50パーセンタイルで12リソース、75パーセンタイルで31リソース、90パーセンタイルで68リソース。モバイルでは10パーセンタイルで1リソース、25パーセンタイルで4リソース、50パーセンタイルで12リソース、75パーセンタイルで26リソース、90パーセンタイルで66リソース。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=922735274&format=interactive",
  sheets_gid="1228269471",
  sql_file="resource-hints-preload-prefetch-modulepreload-distribution.sql"
  )
}}

`modulepreload`の使用状況はかなりばらつきがありますが、使用率が低いため、一部のサイトの影響を受けやすい状態です。

### インジェクトされたスクリプト

スクリプトのインジェクションは、`document.createElement`を使用して`HTMLScriptElement`を作成し、DOM挿入メソッドでDOMに追加するか、`innerHTML`を使用して文字列として`<script>`マークアップを挿入することを含みます。多くのユースケースで一般的ですが、この手法はブラウザのプリロードスキャナーをバイパスし、初期HTMLの解析中にスクリプトを検出できなくなる可能性があります。これは、インジェクトされたスクリプトが長時間のタスクを引き起こしたり、大量のマークアップを動的に解析したりする場合、[Largest Contentful Paint (LCP)](https://web.dev/articles/lcp)などのパフォーマンスメトリクスに悪影響を与える可能性があります。

{{ figure_markup(
  image="distribution-of-percentage-of-injected-scripts.png",
  caption="インジェクトされたスクリプトの割合の分布。",
  description="パーセンタイル別のインジェクトされたスクリプトの割合を示す棒グラフ。デスクトップでは10パーセンタイルで0%、25パーセンタイルで5%、中央値で24%、75パーセンタイルで50%、90パーセンタイルで73%。モバイルでは同様で、10パーセンタイルで0%、25パーセンタイルで3%、中央値で21%、75パーセンタイルで50%、90パーセンタイルで70%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=153813417&format=interactive",
  sheets_gid="1725251320",
  sql_file="distribution_of_injected_scripts.sql"
  )
}}

インジェクトされたスクリプトの2つの分布を比較すると、2024年のグラフでは中央値（50パーセンタイル）でインジェクトされたスクリプトの割合が2022年の25%から21%に減少しています。より高いパーセンタイルでは、2022年と2024年の両方で90パーセンタイルで70%のスクリプトがインジェクトされており、トレンドは一貫しています。初期のパーセンタイルではインジェクションがわずかに増加していますが、全体的に見て、スクリプトのインジェクションパターンは高いリソースレベルで安定しています。

### ファーストパーティとサードパーティのJavaScript

ファーストパーティのJavaScriptは、ウェブサイトのドメインによって直接提供され、そのドメインに属するコードで、サイトの機能とユーザー体験に重要な役割を果たします。一方、サードパーティのJavaScriptは外部ドメインから提供され、通常は分析、広告、ソーシャルメディア統合などのサービスに使用されます。ファーストパーティのスクリプトは直接的な制御と透明性がありますが、サードパーティのスクリプトはパフォーマンス、セキュリティ、プライバシーのリスクを引き起こす可能性があります。これら2つのタイプのバランスを管理することは、サイトのパフォーマンスを最適化し、ユーザーデータを保護するために重要です。このセクションでは、ファーストパーティとサードパーティのコードの分布を探り、モダンなウェブサイトが異なるソース間でJavaScriptの負荷をどのように分割しているかを評価します。

#### リクエスト

{{ figure_markup(
  image="distribution-of-javascript-requests-by-host.png",
  caption="ホスト別のJavaScriptリクエストの分布。",
  description="ホスト別のリクエストをパーセンタイル別に示す棒グラフ。10パーセンタイルでファーストパーティ2、サードパーティ2、25パーセンタイルでそれぞれ5と4、50パーセンタイルで11と10、75パーセンタイルで24と20、90パーセンタイルで45と36。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2046058068&format=interactive",
  sheets_gid="644448469",
  sql_file="requests_by_3p.sql"
  )
}}

2つのトレンドを比較すると、2024年のグラフでは[2022年と比較してサードパーティのJavaScriptリクエストが増加](../2022/javascript#ファーストパーティーのJavaScriptとサードパーティーのJavaScript)しており、とくに90パーセンタイルでは、サードパーティのリクエストが2022年の34から2024年には36に増加しています。ファーストパーティのリクエストもわずかに増加していますが、サードパーティスクリプトの増加がより顕著です。このサードパーティJavaScriptの増加は懸念すべきものです。外部スクリプトに対する直接的な制御がないため、パフォーマンスに悪影響を与え、セキュリティの脆弱性を引き起こし、ユーザーのプライバシーリスクを引き起こす可能性があります。

#### バイト数

{{ figure_markup(
  image="distribution-of-javascript-bytes-by-host.png",
  caption="ホスト別のJavaScriptバイト数の分布。",
  description="モバイルのパーセンタイル別のバイト数を示す棒グラフ。10パーセンタイルでファーストパーティ12キロバイト、サードパーティ56キロバイト、25パーセンタイルで68と158、50パーセンタイルで168と375、75パーセンタイルで393と766、90パーセンタイルでファーストパーティ904キロバイト、サードパーティ1,292キロバイト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=227593882&format=interactive",
  sheets_gid="2060931510",
  sql_file="bytes_by_3p.sql"
  )
}}

ダウンロードされたバイト数は、リクエスト数と同様の増加を示しています。

### 動的インポート

動的`import()`は、従来の静的インポート構文よりも柔軟な代替手段を提供し、JavaScriptファイルの先頭に制限される静的インポートとは異なり、スクリプト内のどこからでも呼び出すことができます。

重要度の低いコードの読み込みを実際に必要になるまで遅延させることで、動的インポートは起動時のパフォーマンスを大幅に向上させ、初期読み込みを削減し、全体的な効率を向上させることができます。

{{ figure_markup(
  content="3.70%",
  caption="動的`import()`を使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="100825266",
  sql_file="dynamic_import.sql",
) }}

モバイルページでの動的インポートの使用率が0.34%から3.70%に急増したことは、パフォーマンス最適化のためのこの手法の採用が増加していることを示しています。この急激な増加は、開発者が動的インポートを活用して読み込み時間を改善し、モバイルデバイスでの初期JavaScriptペイロードを削減する傾向が強まっていることを示しています。重要度の低いスクリプトを遅延させることで、ウェブサイトはとくにリソースが制限されたモバイル環境で、パフォーマンスとユーザー体験の両方を向上させることができます。この増加は、より効率的なオンデマンド読み込み戦略へと業界が移行していることを反映しています。

### Webワーカー

Webワーカーは、メインスレッドの負荷を軽減するために設計された強力なWebプラットフォーム機能で、別のスレッドでバックグラウンドでJavaScriptを実行します。従来のスクリプトとは異なり、WebワーカーはDOMに直接アクセスせずに独立して動作し、UIの応答性に影響を与えることなく、データ処理や複雑な計算などの負荷の高いタスクを処理できます。これらのリソースを大量に消費する操作をオフロードすることで、Webワーカーはよりスムーズなパフォーマンスを確保し、メインスレッドが圧迫されることを防ぎ、より高速で効率的なWeb体験を提供するために不可欠です。

{{ figure_markup(
  content="30%",
  caption="Webワーカーを使用しているモバイルページの数。",
  classes="big-number",
  sheets_gid="879412790",
  sql_file="web_workers.sql",
) }}

モバイルページでのWebワーカーの使用率が12%から30%に増加したことは、この技術の採用における重要な変化を示しています。この約3倍の増加は、開発者がWebワーカーを活用して負荷の高いタスクをオフロードし、パフォーマンスを改善し、モバイルデバイスでのよりスムーズなユーザー体験を確保する傾向が強まっていることを示しています。モバイルページの約3分の1がWebワーカーを採用していることは、重要なUI更新のためにメインスレッドを解放することの重要性に対する認識が高まっていることを反映しており、最終的により応答性の高い効率的なモバイルインタラクションを実現しています。

### ワークレット

ワークレットは、描画や音声処理などのタスクのためにレンダリングパイプラインへの低レベルアクセスを提供するように設計された特殊なWebワーカークラスです。ワークレットの主なパフォーマンス上の利点は、別のスレッドで独立して実行できることで、リソースを大量に消費するタスクをメインスレッドからオフロードできます。これにより効率が向上するだけでなく、メインスレッドを重要な操作のために解放することでパフォーマンスも向上し、よりスムーズな視覚効果とシームレスな音声体験を実現できます。

{{ figure_markup(
  content="0.0016%",
  caption="少なくとも1つのペイントワークレットを登録しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="1929297167",
  sql_file="worklets.sql",
) }}

{{ figure_markup(
  content="0.0004%",
  caption="少なくとも1つのオーディオワークレットを登録しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="1929297167",
  sql_file="worklets.sql",
) }}

モバイルデバイスでのワークレットの採用は依然として極めて低く、ペイントワークレットが前回のWeb Almanacからわずかに増加して0.0016%、オーディオワークレットはモバイルページのわずか0.0004%で使用されています。これらの数値は、ワークレットが音声処理やレンダリングなどのタスクのオフロードに提供する潜在的な利点にもかかわらず、その使用がモバイルWeb開発の主流からは程遠いことを示しています。これは、その特殊な機能性と、より広範なブラウザサポートと開発者の習熟度の必要性による可能性があります。

## JavaScriptはどのように配信されるのか？

JavaScriptリソースのブラウザへの配信方法は、Webパフォーマンスの重要な側面であり続けており、圧縮はペイロードサイズの削減と読み込み時間の改善に重要な役割を果たしています。2024年のWeb上でのJavaScriptリソースの圧縮と配信方法を確認しましょう。

### 圧縮方法

JavaScriptリソースがネットワーク上で配信される際、転送サイズを削減するために圧縮することができます。圧縮は、帯域幅の使用を削減し、ページの読み込み時間を改善する重要な最適化手法です。JavaScriptの配信に使用される圧縮アルゴリズムには、brotli（br）、gzip、zstdがあります。

brotliはgzipよりも優れた圧縮率を提供しますが、とくにJavaScriptなどのテキストリソースでは、gzipは長年にわたってWeb標準として広範なブラウザサポートと高速な圧縮速度を誇ってきました。Zstandard（zstd）は、Facebookが開発した新しい圧縮アルゴリズムで、高速な圧縮と解凍速度を維持しながら高い圧縮率を提供することを目指しています。有望な機能にもかかわらず、2024年のデータでは採用率は1%と低い水準にとどまっています。

{{ figure_markup(
  image="compression-methods-of-script-resources.png",
  caption="スクリプトリソースの圧縮方法。",
  description="スクリプトリソースの圧縮方法を示す棒グラフ。デスクトップではbrotli（`br`）が44%、gzip（`gzip`）が41%、圧縮なしが13%、Z-standard（`zstd`）が1%。モバイルでも同様で、brotli（`br`）が45%、gzip（`gzip`）が41%、圧縮なしが12%、Z-standard（`zstd`）が1%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1205373602&format=interactive",
  sheets_gid="2030065986",
  sql_file="compression_method.sql"
  )
}}

2024年は、JavaScriptの圧縮トレンドにおいて重要な転換点となり、Brotli（`br`）がついにgzipを追い抜いてもっとも一般的な圧縮方法となりました。Brotliは現在、モバイルとデスクトップの両方でJavaScriptリクエストの45%と44%を占めており、gzipは両プラットフォームで41%となっています。これは2022年の状況（gzipが52%、Brotliが34%）から大きな変化であり、2021年の数値（gzip: 55%、Brotli: 30.8%）からの変化はさらに顕著です。

このBrotliの台頭は、Webパフォーマンスにとって重要な勝利です。Brotliはgzipよりも優れた圧縮率を実現し、とくにJavaScriptリソースではその効果が顕著です。Brotliの採用率の着実な年次成長（30.8% → 34% → 45%）は、Web開発者とホスティングプロバイダーの間でその利点に対する認識が高まっていることを示しています。

{{ figure_markup(
  image="growth-of-brotli-for-compressing-javascript.png",
  caption="JavaScriptの圧縮におけるBrotliの成長。",
  description="2019年から2024年までのJavaScriptリソースのBrotli使用率の成長を示す棒グラフ。デスクトップでは2019年の15%から、2020年20%、2021年30%、2022年33%、2024年44%に増加。モバイルでも同様で、2019年の14%から、2020年20%、2021年31%、2022年34%、2024年45%に増加。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1695781069&format=interactive",
  sheets_gid="2030065986",
  sql_file="compression_method.sql"
  )
}}

残りの状況を見ると、約12-13%のリクエストがまだ圧縮されていない状態で送信されており、新しいzstd圧縮方式は両プラットフォームで1%という低い採用率を維持しています。ごく少数のウェブサイトでは、gzip + deflateやbr + gzipなどの圧縮手法の組み合わせも使用されているようです。これは必ずしも両方が同時に使用されていることを意味するわけではありません。なぜなら、両方を使用しても追加の効果はないためです。この使用状況は、同じページ上の異なるアセットが異なる圧縮方式を使用しているか、またはBrotliがすべてのブラウザでサポートされていなかった時期に異なるブラウザをサポートするために使用されている可能性があります。

{{ figure_markup(
  image="compression-methods-of-script-resources-by-host.png",
  caption="ホスト別のスクリプトリソースの圧縮方法。",
  description="ファーストパーティとサードパーティの圧縮方法を示す棒グラフ。Brotli（`br`）はファーストパーティで45%、サードパーティで60%、gzip（`gzip`）はファーストパーティで60%、サードパーティで29%、圧縮なしはファーストパーティで15%、サードパーティで12%、Deflate（`deflate`）は両方で0%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=539033561&format=interactive",
  sheets_gid="271400568",
  sql_file="compression_method_by_3p.sql"
  )
}}

サードパーティスクリプトを見ると、興味深い対比が見られます。トレンドを見ると、gzipが再び明確な勝者となっており、60%対29%という比較で、依然として主要な圧縮方式として使用されています。これは、多くのサードパーティJavaScriptがBrotli圧縮なしでデプロイされているため、パフォーマンスの向上機会が失われていることを示しています。

{{ figure_markup(
  image="uncompressed-resources-by-host.png",
  caption="ホスト別の圧縮されていないリソース。",
  description="ホストタイプ別の圧縮されていないリソースのキロバイト分布を示す棒グラフ。ファーストパーティでは、0キロバイトが56%、5キロバイトが10%、10キロバイトが7%、15キロバイトが4%、20キロバイトが3%、25キロバイトが1%、30キロバイトが1%、35キロバイトが2%、40キロバイトが1%、45キロバイトが1%、50キロバイトが1%、55キロバイトが1%、60キロバイトが1%、65キロバイトが1%、70キロバイトが0%、75キロバイトが0%、80キロバイトが1%、85キロバイトが2%、90キロバイトが1%、95キロバイトが0%、100キロバイトが6%。サードパーティでは、0キロバイトが93%、5キロバイトが2%、10キロバイトが1%、15キロバイトが0%、20キロバイトが1%、25-95キロバイトが0%、100キロバイトが1%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1830077596&format=interactive",
  sheets_gid="947283086",
  sql_file="compression_none_by_bytes.sql"
  )
}}

圧縮されていないリソースの全体像を見ると、5キロバイト未満の小さなリソースが圧縮なしで送信されていることがわかります。これは理にかなっています。なぜなら、そのような小さなリソースに圧縮を適用しても大きな価値はなく、むしろ圧縮のオーバーヘッドが追加される可能性があるためです。しかし、一部の大きなファーストパーティリソースは依然として圧縮の恩恵を受けていません。100キロバイト以上のスクリプトの6%がまったく圧縮されていない状態です。

### ミニファイ

JavaScriptのミニファイは、機能を変更することなく不要な文字を削除してJavaScriptコードのサイズを削減する重要な最適化手法です。長い小説から空白をすべて削除し、キャラクター名を短くするようなものと考えてください。ストーリーは同じままで、より少ないスペースで済みます。関数名、変数名、クラス名などを短くする部分は、uglification（醜化）とも呼ばれます。

{{ figure_markup(
  image="distribution-of-unminified-javascript-audit-scores.png",
  caption="未ミニファイJavaScriptの監査スコアの分布。",
  description="デスクトップとモバイルの未ミニファイJavaScriptの監査スコアを示す棒グラフ。デスクトップでは0.0点が9%、0.50点が31%、1.00点が60%。モバイルでは0.00点が20%、0.50点が18%、1.00点が62%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=127145587&format=interactive",
  sheets_gid="1963564843",
  sql_file="lighthouse_unminified_js.sql"
  )
}}

ここで、0.00は最悪のスコア、1.00は最高のスコアを表します。モバイルページの62%がLighthouseのミニファイJavaScript監査で0.9から1.0のスコアを獲得しており、デスクトップページでは60%となっています。これは、モバイルでは38%のページがミニファイJavaScriptを配信する機会があり、デスクトップページでは40%のページにその機会があることを意味します。

{{ figure_markup(
  image="unminified-javascript-bytes-per-page.png",
  caption="ページあたりの未ミニファイJavaScriptのバイト数。",
  description="デスクトップとモバイルの未ミニファイJavaScriptのバイト数を示す棒グラフ。0キロバイトはデスクトップで61.27%、モバイルで63.81%、10キロバイトはそれぞれ14.97%と14.50%、20キロバイトは7.43%と7.03%、30キロバイトは4.00%と3.71%、40キロバイトは2.55%と2.29%、50キロバイトは1.93%と1.74%、60キロバイトは1.42%と1.22%、70キロバイトは0.97%と0.81%、80キロバイトは0.75%と0.65%、90キロバイトは0.62%と0.52%、100キロバイトは0.46%と0.42%、110キロバイトは0.33%と0.31%、120キロバイトは0.29%と0.28%、130キロバイトは0.26%と0.24%、140キロバイトは0.25%と0.25%、150キロバイトは0.26%と0.22%、160キロバイトは0.18%と0.19%、170キロバイトは0.13%と0.12%、180キロバイトは0.12%と0.14%、190キロバイトは0.12%と0.11%、200キロバイトは1.67%と1.44%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1457149352&format=interactive",
  sheets_gid="1469161400",
  sql_file="lighthouse_unminified_js_bytes.sql"
  )
}}

中央値では、ページあたり約12キロバイトのミニファイ可能なJavaScriptが配信されています。75パーセンタイルと90パーセンタイルでは、その数値は大きく跳ね上がり、34キロバイトから約76キロバイトに増加します。サードパーティは全体的に良好ですが、90パーセンタイルでは約19キロバイトの未ミニファイJavaScriptを配信しています。

{{ figure_markup(
  image="average-wasted-bytes-of-unminified-javascript.png",
  caption="未ミニファイJavaScriptの平均無駄バイト数。",
  description="未ミニファイJavaScriptの平均無駄バイト数を示す円グラフ。ファーストパーティが82.7%、サードパーティが17.3%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1906849262&format=interactive",
  sheets_gid="111413017",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

2024年の未ミニファイJavaScriptによる帯域幅の無駄について、ファーストパーティコードが依然として主な原因です。数字が物語るように、無駄なバイトの82.7%が組織自身のスクリプトから発生し、サードパーティコードは17.3%と少ないものの無視できない割合を占めています。これは以前から見られたパターンですが、変化が少ないのは驚きです。パフォーマンスの問題についてサードパーティを非難しがちですが、実際の改善の余地はファーストパーティコードにあるようです。

ミニファイは単なるチェックボックスではありません。必須の作業です。コメント、空白、未使用コードを削除することでファイルサイズが縮小され、ページの読み込みが高速化されます。ファーストパーティスクリプトは私たちの責任であり、ミニファイしないと明らかなパフォーマンス向上の機会を逃すことになります。サードパーティも無関係ではありません。17.3%は小さく見えるかもしれませんが、最適化されていないベンダースクリプトは、とくに低速ネットワークや古いデバイスでパフォーマンスを低下させる可能性があります。サードパーティスクリプトがミニファイされていない場合、そのツールが本当に価値があるのか、より軽量な代替手段に置き換えられないかを検討すべきです。

スクリプトから1キロバイトでも削減できれば、読み込み時間の短縮、ユーザー満足度の向上、SEOの改善につながります。

### ソースマップ

ソースマップは、開発者にとって重要なツールであり続けています。ミニファイされた本番コードと元の人間が読みやすい形式の間のギャップを埋めるものです。デバッグには不可欠ですが、実際には十分に活用されていないか、誤用されていることが多いです。2024年のデータを詳しく見ていきましょう。

{{ figure_markup(
  content="19%",
  caption="公開アクセス可能なソースマップへのコメントを指定しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="591409222",
  sql_file="sourcemaps.sql",
) }}

これは前年比でわずかな上昇を示しています。2022年には、モバイルページの14%のみがソースマップコメントを使用し、ヘッダーを活用したのは0.12%でした。採用は徐々に進んでいますが、進捗は緩やかです。HTTPヘッダー方式は依然として稀で、これはサーバー設定と開発者の意識に依存するためと考えられます。

{{ figure_markup(
  content="0.18%",
  caption="ソースマップヘッダーを指定しているモバイルページの数。",
  classes="big-number",
  sheets_gid="251410295",
  sql_file="sourcemap_header.sql",
) }}

ソースマップ自体はパフォーマンスの問題ではありません。ブラウザは明示的に要求されない限り（たとえばDevTools経由）、ソースマップを無視します。しかし、誤用は逆効果になる可能性があります：

インラインソースマップ（本番ファイル内にbase64エンコードされたもの）はJavaScriptのペイロードを肥大化させ、ダウンロードと処理を遅くします。
適切にスコープが設定されていない公開ソースマップは、機密コードロジックや認証情報が漏洩するリスクがあります。

データは、多くのチームが依然としてヘッダーよりもソースマップコメントを選択していることを示しています。コメントは実装が容易で（webpackやRollupなどのビルドツールで自動化されることが多い）、ヘッダーはより良い制御が可能です。たとえば、ヘッダーは内部ツールや認証済みユーザーにのみ条件付きで提供でき、生のソースコードの露出を減らすことができます。

## レスポンシブネス

JavaScriptはインタラクティブ性を提供するために使用されますが、JavaScriptの使用は入力のレスポンシブネスを低下させる可能性があります。詳細については、専用の[パフォーマンス](./performance)の章をご覧ください。

### メトリクス

レスポンシブネスを測定するために、[Chrome UX Report (CrUX)](https://developer.chrome.com/docs/crux)のフィールドデータとLighthouseのラボデータの両方を確認します。

#### Interaction to Next Paint (INP)

{{ figure_markup(
  image="distribution-of-inp-by-origin.png",
  caption="オリジン別のINPの分布。",
  description="デスクトップとモバイルのINP分布を示す棒グラフ。デスクトップでは10パーセンタイルで25ミリ秒、25パーセンタイルで50ミリ秒、50パーセンタイルで75ミリ秒、75パーセンタイルで125ミリ秒、90パーセンタイルで225ミリ秒。モバイルでは各パーセンタイルでやや高く、10パーセンタイルで50ミリ秒、25パーセンタイルで75ミリ秒、50パーセンタイルで100ミリ秒、75パーセンタイルで150ミリ秒、90パーセンタイルで275ミリ秒。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1787373547&format=interactive",
  sheets_gid="94761497",
  sql_file="inp.sql"
  )
}}

[Interaction to Next Paint (INP)](https://web.dev/articles/inp)は[2024年にCore Web Vitalになりました](https://web.dev/blog/inp-cwv-launch)。ページ上のすべてのキーボード、マウス、タッチ操作を測定し、インタラクションの待ち時間の高いパーセンタイルを選択して全体的なページのレスポンシブネスを表します。

「良好」なINPスコアは200ミリ秒以下です。中央値（50パーセンタイル）では、モバイル（100ミリ秒）とデスクトップ（75ミリ秒）の両方がこの閾値を大きく下回っています。しかし、75パーセンタイルでは、デスクトップ（125ミリ秒）とモバイル（150ミリ秒）が「改善が必要」な範囲に近づいています。90パーセンタイルでは、デスクトップ（225ミリ秒）とモバイル（275ミリ秒）が「良好」な閾値を超えており、多くのウェブサイトでレスポンシブネスの問題が発生していることを示しています。

#### Total Blocking Time (TBT)

{{ figure_markup(
  image="distribution-of-tbt.png",
  caption="TBTの分布。",
  description="デスクトップとモバイルのTBT分布を示す棒グラフ。デスクトップでは10パーセンタイルで0ミリ秒、25パーセンタイルで0ミリ秒、50パーセンタイルで67ミリ秒、75パーセンタイルで279ミリ秒、90パーセンタイルで707ミリ秒。モバイルでは各パーセンタイルでかなり高く、10パーセンタイルで83ミリ秒、25パーセンタイルで416ミリ秒、50パーセンタイルで1,208ミリ秒、75パーセンタイルで2,988ミリ秒、90パーセンタイルで5,950ミリ秒。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=2035948582&format=interactive",
  sheets_gid="1798282039",
  sql_file="tbt.sql"
  )
}}

[Total Blocking Time (TBT)](https://web.dev/articles/tbt)メトリクスは、起動時の長時間タスクの合計ブロック時間を計算するラボメトリクスです。

TBTはLighthouseから取得され、実際のユーザーデータではありません。デバイスに適したCPUとネットワークの制限を有効にした、シミュレートされたデスクトップとモバイル環境での合成パフォーマンスを測定します。

75パーセンタイルでは、モバイルページは約3.0秒（2,988ミリ秒）のブロック時間があり、これは良くないユーザー体験を示しています。90パーセンタイルでは、モバイルのブロック時間は5.95秒（5,950ミリ秒）まで急増する一方、デスクトップはかなり低いままで、デバイスタイプ間のパフォーマンスギャップが浮き彫りになっています。

### ロングタスク / ブロック時間

ロングタスクは、メインスレッドで50ミリ秒以上実行されるタスクのことです。50ミリ秒を超えるタスクの長さがそのタスクのブロック時間となり、タスクの合計時間から50ミリ秒を引くことで計算できます。

{{ figure_markup(
  image="distribution-of-number-of-long-tasks-per-page.png",
  caption="ページあたりのロングタスク数の分布。",
  description="デスクトップとモバイルのロングタスク分布を示す棒グラフ。デスクトップでは10パーセンタイルで1つ、25パーセンタイルで2つ、50パーセンタイルで3つ、75パーセンタイルで6つ、90パーセンタイルで11のロングタスク。モバイルでは各パーセンタイルでかなり高く、10パーセンタイルで4つ、25パーセンタイルで8つ、50パーセンタイルで14、75パーセンタイルで24、90パーセンタイルで38のロングタスク。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=38515194&format=interactive",
  sheets_gid="539796368",
  sql_file="distribution_of_number_of_long_tasks.sql"
  )
}}

中央値では、モバイルで14のロングタスク、デスクトップデバイスで3のロングタスクが発生しています。これは予想通りの結果です。デスクトップデバイスは通常、モバイルデバイスよりも処理能力とメモリリソースが大きいためです。

75パーセンタイルでは、モバイルページで24のロングタスクが発生する一方、デスクトップページでは6のロングタスクです。90パーセンタイルでは、モバイルページで38のロングタスクに達しますが、デスクトップページではわずか11のロングタスクにとどまっています。これは、JavaScriptの実行を最適化する課題を浮き彫りにしており、とくにブロッキングタスクの負担がはるかに大きいモバイルユーザーにとって重要です。

{{ figure_markup(
  image="distribution-of-long-tasks-time-per-page.png",
  caption="ページあたりのロングタスク時間の分布。",
  description="デスクトップとモバイルのロングタスク時間分布を示す棒グラフ。デスクトップでは10パーセンタイルで90ミリ秒、25パーセンタイルで164ミリ秒、50パーセンタイルで329ミリ秒、75パーセンタイルで688ミリ秒、90パーセンタイルで1,343ミリ秒。モバイルでは各パーセンタイルでかなり高く、10パーセンタイルで539ミリ秒、25パーセンタイルで1,152ミリ秒、50パーセンタイルで2,366ミリ秒、75パーセンタイルで4,483ミリ秒、90パーセンタイルで7,770ミリ秒。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=1576475306&format=interactive",
  sheets_gid="560197680",
  sql_file="distribution_of_long_tasks_time.sql"
  )
}}

中央値では、モバイルページで2.37秒（2,366ミリ秒）がロングタスクに費やされていますが、デスクトップページではそのごく一部の時間しか費やされていません。

75パーセンタイルでは、ページは4.48秒（4,483ミリ秒）をロングタスクの処理に費やしており、デスクトップページではそれよりもかなり低い値となっています。90パーセンタイルでは、モバイルのロングタスク時間は7.77秒（7,770ミリ秒）まで急上昇し、大きなレスポンシブネスの問題を示しています。この過度な処理時間は、ロングタスクの分割やWebワーカーを活用して負荷の高い計算をメインスレッドから切り離すなど、JavaScriptの最適化が強く必要であることを示唆しています。これらの結果は、重いJavaScript実行に直面するモバイルユーザーが抱える課題を浮き彫りにしています。

### スケジューラAPI

[スケジューラAPI](https://developer.mozilla.org/docs/Web/API/Scheduler)は最近、[`yield`メソッド](https://developer.mozilla.org/docs/Web/API/Scheduler/yield)が追加され、[ロングタスクを分割する](https://web.dev/articles/optimize-long-tasks)より簡単な方法を提供しています。

{{ figure_markup(
  content="0.65%",
  caption="Scheduler APIを使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="401999176",
  sql_file="posttask_scheduler.sql",
) }}

現在、Scheduler APIを使用しているデスクトップページはわずか0.65%ですが、これは[前回の調査](../2022/javascript#スケジューラAPI)の0.002%から大幅な増加を示しています。モバイルでは0.81%のページがこの機能を利用しています。2022年からのこの成長は、ドキュメントの改善とサポートの拡大に伴い、開発者がScheduler APIをアプリケーションに組み込む機会が増えていることを示唆しています。とくにフレームワークでの採用増加は、JavaScriptの実行においてより効率的なスケジューリングとパフォーマンスの最適化へのシフトを示しています。この傾向は今後も続き、最終的にユーザー体験の向上に貢献すると予想されます。

### 同期XHR

AJAX（XMLHttpRequest、XHR）には同期リクエストを可能にするフラグがあります。同期XHRはパフォーマンスに悪影響を与えます。リクエストが完了するまでイベントループとメインスレッドがブロックされ、データが利用可能になるまでページが固まってしまうためです。`fetch`はよりシンプルなAPIを持つ、より効果的で効率的な代替手段であり、データの同期取得をサポートしていません。

{{ figure_markup(
  content="2.15%",
  caption="同期XHRを使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="1982786595",
  sql_file="sync_requests.sql",
) }}

同期XHRは現在、モバイルページの2.15%、デスクトップページの2.22%で使用されており、2022年（それぞれ2.5%と2.8%）からわずかに減少しています。使用率は減少傾向にありますが、この程度の水準でも継続的な使用が見られることは、一部のレガシーアプリケーションがこの時代遅れの手法に依存し続けており、ユーザー体験に悪影響を与えていることを示しています。

### `document.write`

`document.write` APIは、[HTML仕様自体がその使用を警告している](https://html.spec.whatwg.org/multipage/dynamic-markup-insertion.html#document.write())ように、多くの理由で非常に問題があります。

{{ figure_markup(
  content="12%",
  caption="`document.write`を使用しているモバイルページの数。",
  classes="big-number",
  sheets_gid="1535345080",
  sql_file="usage_of_document_write.sql",
) }}

注目すべきことに、観測されたモバイルページの12%が、適切な挿入メソッドの代わりに`document.write`を使用してDOMにコンテンツを追加しています。デスクトップでは13%のページがこの手法に依存し続けています。これは2022年（18%と17%）から減少しており、より多くの開発者がこの非効率な手法から離れつつあることを示唆しています。しかし、レガシーアプリケーションとサードパーティスクリプトがその使用に影響を与え続けています。

### レガシーJavaScript

Lighthouseは現在、モダンウェブでは不要かもしれないBabelトランスフォームをチェックしています。たとえば、`async`と`await`の使用、JavaScriptクラス、その他の新しいが広くサポートされている言語機能の変換などです。

{{ figure_markup(
  content="67%",
  caption="レガシーJavaScriptを配信しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="265685844",
  sql_file="usage_of_legacy_javascript.sql",
) }}

モバイルページの3分の2強が、変換されているか不要なレガシーJavaScriptを含むJavaScriptリソースを配信し続けています。この数値は2022年から変化がなく、パフォーマンスの問題が認識されているにもかかわらず、多くのページがこれらの変換に依存し続けていることを示しています。デスクトップでは70%のページがこれらの変換を配信し続けています。

2022年からこの統計にほとんど変化はありませんが、JavaScriptの進化が安定し、開発者がより効率的な手法を採用するにつれて、時間とともに減少することを期待しています。

## JavaScriptはどのように使用されているか？

JavaScriptは直接使用することも、ライブラリやフレームワークなどの抽象化を通じて使用することもできます。

### ライブラリの使用状況

ライブラリとフレームワークの使用状況を理解するため、HTTP Archiveは[Wappalyzer](./methodology#wappalyzer)を使用してページで使用されている技術を検出しています。

{{ figure_markup(
  image="adoption-of-top-libraries-and-frameworks.png",
  caption="主要なライブラリとフレームワークの採用状況。",
  description="デスクトップとモバイルにおける主要なライブラリとフレームワークの採用状況を示す棒グラフ。jQueryはデスクトップページの75%、モバイルの74%で使用され、core-jsはそれぞれ42%と41%、jQuery Migrateは33%と33%、jQuery UIは23%と22%、Swiperは両方で15%、Lodashは12%と11%、Modernizrは両方で11%、Reactは両方で10%、GSAPは両方で9%、OWL Carouselは両方で8%、Slickは両方で8%、LazySizesは両方で8%、FancyBoxは両方で7%、Isotopeは両方で7%、Underscore.jsは両方で6%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTCTcjvYejhJMWHZwhCSCVm3cbTzqq8pdJRqC6wnBnbsTvPvHu5rTOTbX4_6gWHx-urn-pccmk9bhT3/pubchart?oid=400487834&format=interactive",
  sheets_gid="345976742",
  sql_file="frameworks_libraries.sql",
  width=600,
  height=491
  )
}}

Web Almanacの過去の版を読んでいる方々は、jQueryがウェブで74%のページに登場し、いまだにもっとも広く使用されているライブラリであることに驚かないでしょう。これはWordPressによる部分が大きいものの、WordPress以外でもjQueryは多くのウェブサイトで主要な選択肢であり続けています。

core-js（41%）の広範な採用も予想通りです。多くのウェブアプリケーションがBabelに依存しており、BabelはJavaScriptの不足している機能のポリフィルを提供するためにcore-jsを使用することが多いためです。ブラウザが進化し、より多くのモダンな機能をネイティブにサポートするようになるにつれ、この数字は減少し、ウェブアプリケーションの不要なバイト数が削減されるはずです。

jQuery Migrateは33%のページに存在しており、多くのウェブサイトが古いjQueryのバージョンに依存し続けていることを示しています。同様に、jQuery UIはほとんど非推奨となっているにもかかわらず、22%のページでまだ使用されています。

その他の注目すべきライブラリには、Swiper（15%）、Lodash（11%）、Modernizr（11%）があり、これらはすべてUI要素の処理と機能検出で重要な役割を果たしています。

Reactの使用率は昨年の8%から10%にわずかに増加しましたが、これは比較的安定した採用率を示唆しています。これは、Reactは人気を維持しているものの、JavaScriptエコシステムでの競争の激化により、その成長が横ばいになっていることを示している可能性があります。

一方、GSAP（9%）、OWL Carousel（8%）、Slick（8%）、LazySizes（8%）、FancyBox（7%）などのライブラリは、とくにパフォーマンスとアニメーションを多用するアプリケーションで広く使用され続けています。

ウェブエコシステムのモダン化が進むにつれ、これらのレガシーライブラリ、とくにjQueryベースのものは、よりネイティブなソリューションとモダンなフレームワークに取って代わられ、時間とともに減少していくと予想されます。

### ライブラリの組み合わせ

フレームワークとライブラリは、同じページで一緒に使用されることが多くあります。昨年と同様に、この現象を調査し、2024年にどれだけのライブラリとフレームワークが組み合わせて使用されているかを把握します。

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
        <td class="numeric">7.57%</td>
        <td class="numeric">7.61%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">3.71%</td>
        <td class="numeric">3.91%</td>
      </tr>
      <tr>
        <td>core-js, jQuery</td>
        <td class="numeric">1.71%</td>
        <td class="numeric">1.67%</td>
      </tr>
      <tr>
        <td>GSAP, Lodash, React</td>
        <td class="numeric">1.25%</td>
        <td class="numeric">1.50%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">1.71%</td>
        <td class="numeric">1.48%</td>
      </tr>
      <tr>
        <td>core-js, jQuery, jQuery Migrate</td>
        <td class="numeric">1.33%</td>
        <td class="numeric">1.29%</td>
      </tr>
      <tr>
        <td>Swiper, core-js, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">1.10%</td>
        <td class="numeric">1.22%</td>
      </tr>
      <tr>
        <td>core-js, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td>Lodash, Modernizr, Stimulus, YUI, core-js</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">0.88%</td>
      </tr>
      <tr>
        <td>core-js</td>
        <td class="numeric">0.73%</td>
        <td class="numeric">0.75%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="一般的なライブラリの組み合わせ。", sheets_gid="86789973", sql_file="frameworks_libraries_combos.sql") }}</figcaption>
</figure>

jQueryには強い持続力があることは明らかです。jQueryとそのUIフレームワーク、移行プラグインの組み合わせが上位7位までを占めており、core-jsもライブラリの使用において重要な役割を果たしています。

## Web ComponentsとシャドウDOM

Web Componentsは、ウェブコンポーネントとシャドウDOMを通じてロジックとスタイリングのカプセル化を可能にします。今年の分析では、まずカスタム要素から見ていきましょう。

{{ figure_markup(
  content="7.8%",
  caption="カスタム要素を使用しているデスクトップページの割合。",
  classes="big-number",
  sheets_gid="455028778",
  sql_file="web_components_pct.sql",
) }}

この数値は2022年のデスクトップページにおけるカスタム要素の使用率2.0%から増加しています。カスタム要素がもたらす利点とモダンブラウザでの十分な対応により、ウェブコンポーネントモデルの採用が増加していることは心強い傾向です。この傾向は、開発者がより高速なユーザー体験を作るためにウェブプラットフォームの組み込み機能を活用する機会が増えていることを示唆しています。

{{ figure_markup(
  content="2.5%",
  caption="シャドウDOMを使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="455028778",
  sql_file="web_components_pct.sql",
) }}

シャドウDOMを使用すると、サブ要素とスタイリングのスコープを持つ専用のノードをドキュメント内に作成でき、コンポーネントをメインのDOMツリーから分離できます。2022年のシャドウDOM使用率0.39%と比較すると、この機能の採用は大幅に増加し、2024年には2.51%に達しています。この成長は、開発者がよりよいコンポーネントのカプセル化とスタイリングの一貫性のためにシャドウDOMを活用する傾向が高まっていることを示しています。

{{ figure_markup(
  content="0.28%",
  caption="テンプレートを使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="455028778",
  sql_file="web_components_pct.sql",
) }}

template要素は、開発者がマークアップパターンを再利用するのに役立ちます。その内容はJavaScriptから参照されたときのみレンダリングされます。テンプレートはウェブコンポーネントとうまく連携し、JavaScriptからまだ参照されていないコンテンツはシャドウDOMを使用してshadowルートに追加されます。

現在、モバイルのウェブページの約0.28%がtemplate要素を使用しており、2022年の0.05%から顕著な増加を示しています。テンプレートはブラウザで十分にサポートされているものの、その採用率は依然として低いながらも成長の兆しを見せています。

{{ figure_markup(
  content="0.29%",
  caption="`is`属性を使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="1947715772",
  sql_file="web_components_is_attribute.sql",
) }}

HTML `is`属性は、カスタム要素をページに挿入する別の方法です。カスタム要素の名前をHTMLタグとして使用する代わりに、その名前は標準のHTML要素に渡され、ウェブコンポーネントのロジックを実装します。`is`属性は、ウェブコンポーネントがページで登録に失敗した場合でも標準のHTML要素の動作にフォールバックできるウェブコンポーネントの使用方法です。

2024年には、`is`属性の採用率は2022年の0.08%から0.29%に増加しています。この成長にもかかわらず、その使用率はカスタム要素自体よりも低いままです。Safariでのサポート欠如により、iOSとmacOSのブラウザではこの属性を利用できず、これが限定的な採用の一因となっている可能性があります。

## 結論

JavaScriptの状況は予想通りの傾向を続けています。その使用は増加し続けていますが、同時にその影響を軽減する取り組みも進んでいます。開発者はパフォーマンスと機能性のバランスを取るため、圧縮化、リソースヒント、圧縮、よりスマートな依存関係管理を活用する機会が増えています。

しかし、JavaScriptへの依存度の高まりは、ウェブパフォーマンスとユーザー体験に関する懸念を引き起こしています。不要なスクリプトの実行を減らし、配信を最適化することは依然として重要な課題です。ウェブプラットフォームの進化とともに、フレームワークが効率性を改善しパフォーマンスを意識したベストプラクティスを取り入れる一方で、可能な場合はネイティブAPIのさらなる採用が進むことを期待しています。

今後を見据えると、この傾向に意味のある変化をもたらすには、より良いツール、ベストプラクティス、認識向上に向けた集団的な取り組みが必要です。それまでは、すべてのユーザーに高速で堅牢なウェブを提供するため、JavaScriptの配信最適化に引き続き注力していく必要があります。
