---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: 2021年版Web AlmanacのJavaScriptの章では、Web上でのJavaScriptの使用方法、ライブラリとフレームワーク、圧縮、Webコンポーネント、ソースマップについて説明しています。
authors: [NishuGoel]
reviewers: [soulcorrosion, mgechev, rviscomi, pankajparkar, tunetheweb]
analysts: [pankajparkar, max-ostapenko, rviscomi]
editors: [rviscomi, pankajparkar, shantsis]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1zU9rHpI3nC6jTz3xgN6w13afW7x34xAKBh2IPH-lVxk/
NishuGoel_bio: Nishu Goelは、<a hreflang="en" href="http://webdataworks.io/">Web DataWorks</a>のエンジニアです。WebテクノロジーとAngularのGoogle Developer Expert、Developer TechnologiesのMicrosoft MVPであり、Step by Step Guide Angular Routing (BPB, 2019)とA Hands-on Guide to Angular (Educative, 2021)の著者でもあります。彼女の著作は、<a hreflang="en" href="https://unravelweb.dev/">unravelweb.dev</a>でご覧いただけます。
featured_quote: レンダリング時間やリソースのロード時間を改善するための機能を活用すれば、全体的な影響を確認し、パフォーマンスに関してさらに優れた体験を得ることができます。
featured_stat_1: 4
featured_stat_label_1: モバイルページごとに行われた非同期リクエストの中央値。
featured_stat_2: 45.6%
featured_stat_label_2: 画像は、JavaScriptで読み込まれるページで最もリクエストの多いコンテンツタイプです。
featured_stat_3: 2.7%
featured_stat_label_3: カスタムエレメントを使用しているデスクトップページの割合
---

## 序章

ここ数年のJavaScript言語の進化のスピードと一貫性には目を見張るものがあります。以前は主にクライアントサイドで使用されていましたが、今ではサービスやサーバーサイドのツールを構築する世界において、非常に重要で尊敬すべき場所となっています。JavaScriptは、より高速なアプリケーションを作成できるだけでなく、<a hreflang="en" href="https://blog.stackblitz.com/posts/introducing-webcontainers/">ブラウザ内でサーバを実行可能</a>なほどに進化しています。

アプリケーションをレンダリングする際、ブラウザの中では、JavaScriptのダウンロードから解析、コンパイル、実行まで、さまざまなことが行われています。まずはその最初のステップとして、実際にページから要求されるJavaScriptの量を把握してみましょう。

## JavaScriptをどれだけ読み込むか？

「測定することは改善への鍵である」と言われています。アプリケーションでのJavaScriptの使用を改善するためには、検出されているJavaScriptのうち、実際に必要とされるものがどれくらいあるかを測定する必要があります。ここでは、Web設定においてJavaScriptが果たす重要な役割を考慮して、ページあたりのJavaScriptバイト数の分布を理解することにしましょう。

{{ figure_markup(
  image="javascript-bytes-per-page.png",
  caption="ページごとに読み込まれるJavaScriptの量の分布。",
  description="ページあたりのJavaScriptバイト数の分布を示す棒グラフ。デスクトップページの中央値は463キロバイトのJavaScriptをロードします。デスクトップの10、25、50、75、90パーセンタイルは、94キロバイト、220キロバイト、463キロバイト、852キロバイト、1,354キロバイトです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=329775434&format=interactive",
  sheets_gid="18398250",
  sql_file="bytes_2021.sql"
  )
}}

50パーセンタイル（中央値）のモバイルページでは427KBのJavaScriptがロードされるのに対し、デスクトップデバイスでロードされるページの中央値では463KBが送信されます。

[2019年の結果](../2019/javascript#fig-2)と比較すると、デスクトップではJavaScriptの使用率が18.4%増加し、モバイルでは18.9%増加していることがわかります。長期的な傾向として、より多くのJavaScriptを使用するようになっていますが、CPUの作業が増えることで、アプリケーションのレンダリング速度を低下する可能性があります。なお、これらの統計は、圧縮応答が可能な転送バイト数を表しているため、実際のCPUコストはかなり高くなる可能性があることをご了承ください。

では、実際にどの程度のJavaScriptがページに読み込まれる必要があるのかを見てみましょう。

{{ figure_markup(
  image="unused-javascript-bytes-per-page.png",
  caption="モバイルにおけるJavaScriptの未使用バイト量の分布。",
  description="ページあたりの未使用JavaScriptバイト数の分布を示す棒グラフ。モバイルの中央値では、155KBの未使用のJavaScriptが読み込まれています。モバイルの10、25、50、75、90パーセンタイルは次のとおりです。20kb、64kb、155kb、329kb、598kb。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=656542402&format=interactive",
  sheets_gid="1704839581",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

[Lighthouse](./methodology#lighthouse)によると、モバイルページの中央値では、155KBの未使用のJavaScriptがロードされています。また、90パーセンタイルでは、598KBのJavaScriptが使われていません。

{{ figure_markup(
  image="unused-vs-total-javascript.png",
  caption="モバイルページにおける未使用および総JavaScriptバイト数の分布。",
  description="読み込まれたJavaScriptと、読み込まれなかったJavaScriptの差を示す棒グラフ。モバイルページの中央値では、読み込まれた427KBのJavaScriptのうち、155KBが未使用です。読み込まれたJavaScript全体の36.2%が未使用となり、CPUコストが増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=890651092&format=interactive",
  sheets_gid="1521645399",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

{{ figure_markup(
  content="36.2%",
  caption="読み込まれたJavaScriptのうち未使用の割合。",
  classes="big-number",
  sheets_gid="1521645399",
  sql_file="unused_js_bytes_distribution.sql"
  )
}}

言い換えれば、中央値のモバイルページでは、36.2%のJavaScriptバイトが使用されていません。JavaScriptがページの<a hreflang="ja" href="https://web.dev/i18n/ja/optimize-lcp/">最大コンテンツの描画</a>（LCP）に与える影響を考えると、とくにデバイスの性能やデータプランが限られているモバイルユーザーにとっては、CPUサイクルや他の重要なリソースがムダに消費されていることを考えると、これは非常に大きな数字です。このようなムダは、大規模なフレームワークやライブラリに同梱されている、使用されていない多くの定型的なコードの結果である可能性があります。

サイトオーナーは、Lighthouseを使って<a hreflang="en" href="https://web.dev/unused-javascript/">使われていないJavaScript</a>をチェックし、ベストプラクティスにしたがって<a hreflang="ja" href="https://web.dev/i18n/ja/remove-unused-code/">使われていないコード</a>を削除することで、ムダなJavaScriptバイトの割合を減らすことができます。

### ページあたりのJavaScriptリクエスト数

Webページのレンダリングが遅くなる要因のひとつとして、ページ上で行われるリクエスト、とくにリクエストをブロックしている場合が考えられます。そこで、デスクトップとモバイルの両方で、1ページあたりのJavaScriptリクエスト数を調べてみることにしました。

{{ figure_markup(
  image="js-requests-per-page.png",
  caption="ページあたりのJavaScriptリクエスト数の分布。",
  description="デスクトップページとモバイルページにおけるJavaScriptリクエストの分布を示す棒グラフ。モバイルページの中央値では20個のJavaScriptリソースがロードされるのに対し、デスクトップでは21個のJavaScriptリソースがロードされます。モバイルでのリクエストの10、25、50、75、90パーセンタイルは次のとおりです。4、10、20、35、56。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1487796178&format=interactive",
  sheets_gid="159538568",
  sql_file="requests_2021.sql"
  )
}}

デスクトップページの中央値では、21個のJavaScriptリソース（`.js`および`.mjs`のリクエスト）がロードされ、90パーセンタイルでは59個のリソースがロードされます。

{{ figure_markup(
  image="js-resources-over-years.png",
  caption="1ページあたりのJavaScriptリクエスト数の年別分布。",
  description="デスクトップおよびモバイルデバイス上で読み込まれるJavaScriptリソースの分布を年ごとに示した棒グラフ。2020年には、1ページで行われたJSリクエストの中央値は19で、これが2021年には20に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=882068136&format=interactive",
  sheets_gid="1068898615",
  sql_file="requests_2020.sql"
  )
}}

[昨年の結果](../2020/javascript#request-count)と比較すると、2021年に要求されたJavaScriptリソースの数はわずかに増加しており、ロードされたJavaScriptリソースの数の中央値はデスクトップページで20、モバイルで19でした。

傾向としては、1ページに読み込まれるJavaScriptリソースの数が徐々に増えています。これはJavaScriptのリクエスト数が少ないとパフォーマンスが向上する場合もあれば、そうでない場合もあることを考えると、実際に数値を上げるべきか、下げるべきか悩むところです。

ここで、最近のHTTPプロトコルの進歩により、JavaScriptのリクエスト数を減らしてパフォーマンスを向上させようという考えが不正確になってきました。HTTP/2とHTTP/3の導入により、HTTPリクエストのオーバーヘッドが大幅に削減されたため、同じリソースをより多くのリクエストで要求することは、必ずしも悪いことではなくなりました。これらのプロトコルの詳細については、[HTTPの章](./http)を参照してください。

## JavaScriptはどのように要求されるのですか？

JavaScriptはさまざまな方法でページに読み込まれますが、そのリクエスト方法はページのパフォーマンスに影響を与えます。

### `module`と`nomodule`

Webサイトを読み込む際、ブラウザはHTMLをレンダリングし、適切なリソースを要求します。ブラウザは、ページを効果的にレンダリングして機能させるために、コード内で参照されるポリフィルを消費します。[アロー関数式](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Functions/Arrow_functions)や[非同期関数](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Statements/async_function)のような新しい構文をサポートしているモダンブラウザは、動作させるために大量のポリフィルを必要としませんし、その必要もありません。

この時、differential loadingが活躍します。`type="module"`属性を指定すると、モダンブラウザにはモダンな構文のバンドルが提供され、ポリフィルがあったとしても少なくなります。同様に、モジュールをサポートしていない古いブラウザには、`type="nomodule"`属性を指定することで、必要なポリフィルとトランスパイルされたコード構文を持つバンドルが提供されます。[HTMLにモジュールを適用する](https://developer.mozilla.org/ja/docs/Web/JavaScript/Guide/Modules#applying_the_module_to_your_html)の続きを読んでください。

これらの属性の採用状況をデータで見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>属性</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`module`</td>
        <td class="numeric">4.6%</td>
        <td class="numeric">4.3%</td>
      </tr>
      <tr>
        <td>`nomodule`</td>
        <td class="numeric">3.9%</td>
        <td class="numeric">3.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="デスクトップとモバイルのクライアントでの負荷のかかり方の違いの分布。",
    sheets_gid="1261294750",
    sql_file="module_and_nomodule.sql"
  ) }}</figcaption>
</figure>

デスクトップページの4.6%が`type="module"`属性を使用しているのに対し、モバイルページでは3.9%しか`type="nomodule"`を使用していません。これは、モバイルのデータセットの方が[はるかに大きい](./methodology#websites)ため、最新の機能を使っていない可能性のある「ロングテール」のウェブサイトが多く含まれていることが原因と考えられます。

なお、<a hreflang="en" href="https://docs.microsoft.com/en-us/lifecycle/announcements/internet-explorer-11-support-end-dates">IE 11ブラウザのサポート終了</a>に伴い、エバーグリーンブラウザは最新のJavaScript構文をサポートしているため、ディファレンシャルローディングは適用しにくくなっています。たとえば、Angularフレームワークでは、<a hreflang="en" href="https://github.com/angular/angular/issues/41840">Angular v13でレガシーブラウザのサポートの削除を</a>2021年11月に発表しました。

### `async`と`defer`

JavaScriptの読み込みは、非同期または遅延の指定がない限り、レンダリングの妨げになる可能性があります。多くの場合、最初のレンダリングにJavaScript（もしくはその一部）が必要となるため、これがパフォーマンス低下の一因となっています。

しかし、JavaScriptを非同期に、あるいは遅延して読み込むことで、このような体験を改善できる場合があります。`async`と`defer`の両属性は、非同期的にスクリプトをロードします。`async`属性を持つスクリプトは定義された順番に関係なく実行されますが、`defer`はドキュメントが完全に解析された後にのみスクリプトを実行するので、指定された順番で実行されることが保証されます。実際に、ブラウザで要求されたJavaScriptにこれらの属性を指定しているページがどれだけあるかを見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>属性</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`async`</td>
        <td class="numeric">89.3%</td>
        <td class="numeric">89.1%</td>
      </tr>
      <tr>
        <td>`defer`</td>
        <td class="numeric">48.1%</td>
        <td class="numeric">47.8%</td>
      </tr>
      <tr>
        <td>両方</td>
        <td class="numeric">35.7%</td>
        <td class="numeric">35.6%</td>
      </tr>
      <tr>
        <td>どちらでもない</td>
        <td class="numeric">10.3%</td>
        <td class="numeric">10.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="`async`と`defer`を使用しているページの割合。",
    sheets_gid="2038121216",
    sql_file="breakdown_of_pages_using_async_defer.sql"
  ) }}</figcaption>
</figure>

昨年の結果では、同じスクリプトに `async` と `defer` の両方の属性を使用しているウェブサイトがあるというアンチパターンが観察されました。これは、ブラウザがサポートしている場合は `async` にフォールバックし、IE8とIE9のブラウザでは `defer` を使用するというものです。しかし、ほとんどのサイトでは、サポートされているすべてのブラウザで`async`が優先されるため、現在ではこの方法は必要ありません。このパターンでは、ページが読み込まれるまで待つのではなく、HTMLの解析が中断されます。この使用頻度は非常に高く、モバイルページの [11.4%](../2020/javascript#how-do-we-load-our-javascript) には、`async` と `defer` 属性を持つスクリプトが少なくとも1つ使用されていました。[根本原因](https://twitter.com/rick_viscomi/status/1331735748060524551?s=20)が判明し、[今後このような使い方をしない](https://twitter.com/Kraft/status/1336772912414601224?s=20)というアクションアイテムも降ろされたのです。

{{ figure_markup(
  content="35.6%",
  caption="同一スクリプト上で `async` と `defer` 属性が設定されているモバイルページの割合。",
  classes="big-number",
  sheets_gid="2038121216",
  sql_file="breakdown_of_pages_using_async_defer.sql"
  )
}}

今年は、モバイルページの35.6%が `async` と `defer` 属性を併用していることがわかりました。昨年との大きな違いは、初期のHTMLの静的なコンテンツを解析するのではなく、実行時に属性の使用状況を測定するように方法を改善したことによるものです。この差は、多くのページが、ドキュメントがすでに読み込まれた後に、これらの属性を動的に更新していることを示しています。たとえば、あるウェブサイトでは、次のようなスクリプトが含まれていることが判明しました。

```js
<!-- Piwik -->
<script type="text/javascript">
   (function() {
      var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
      g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
   })();
</script>
<!-- End Piwik Code -->
```

さて、Piwikとは何でしょうか？そのWikipediaの項目によると。

<figure>
<blockquote>Matomo（旧Piwik）は、国際的な開発者チームによって開発されたフリーでオープンソースのウェブ解析アプリケーションで、PHP/MySQLのウェブサーバー上で動作します。1つまたは複数のウェブサイトへのオンライン訪問を追跡し、分析のためにこれらの訪問に関するレポートを表示します。2018年6月現在、Matomoは145万5千以上のウェブサイトで使用されており、これは既知のトラフィック分析ツールを持つすべてのウェブサイトの1.3%にあたります&hellip;</blockquote>
<figcaption>— <cite><a href="https://ja.wikipedia.org/wiki/Matomo">ウィキペディアのMatomo (ソフトウェア)</a></cite></figcaption>
</figure>

この情報は、我々が観測した増加の多くは、類似のマーケティングおよび分析プロバイダーが、これらの`async`および`defer`スクリプトを以前に検出されたよりも遅くページに動的に注入することによるものである可能性を強く示唆しています。

{{ figure_markup(
  content="2.6%",
  caption="`async`と`defer`属性を併用しているスクリプトの割合。",
  classes="big-number",
  sheets_gid="655357075",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
  )
}}

多くのページがこのアンチパターンを使用しているにもかかわらず、同じscript要素で`async`と`defer`の両方を使用しているスクリプトは全体の2.6%しかないことがわかりました。

### ファーストパーティとサードパーティ

[How much JavaScript do we load](#how-much-javascript-do-we-load)のセクションで、モバイルページのJavaScriptリクエスト数の中央値が20であることを思い出してください。このセクションでは、ファーストおよびサードパーティのJavaScriptリクエストの内訳を見てみましょう。

{{ figure_markup(
  image="js-requests-mobile-host.png",
  caption="モバイルページ1ページあたりのJavaScriptリクエスト数のホスト別分布。",
  description="モバイルページあたりのJavaScriptリクエストのホスト別分布を示す棒グラフ。中央値のモバイルページでは、ファーストパーティからのリクエストが9回、サードパーティからのリクエストが10回となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=395424439&format=interactive",
  sheets_gid="1354767842",
  sql_file="requests_by_3p.sql"
  )
}}

モバイルページの中央値では、サードパーティ製リソースへのリクエストが10件、ファーストパーティ製リクエストが9件となっています。この差は、90パーセンタイルになるほど大きくなります。モバイルページのファーストパーティリソースへのリクエストは33件ですが、モバイルページのサードパーティリソースへのリクエストは34件に上ります。明らかに、サードパーティ製リソースのリクエスト数は、ファーストパーティ製リソースのリクエスト数よりも常に一歩リードしています。

{{ figure_markup(
  image="js-requests-desktop-host.png",
  caption="デスクトップページあたりのJavaScriptリクエスト数のホスト別分布。",
  description="デスクトップページあたりのJavaScriptリクエストのホスト別分布を示す棒グラフ。モバイルページの中央値では、ファーストパーティのリクエストが10件、サードパーティのリクエストが11件となっています。デスクトップでのファーストパーティへのリクエストの10、25、50、75、90パーセンタイルは次のとおりです。2、4、10、19、33。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1584404981&format=interactive",
  sheets_gid="1354767842",
  sql_file="requests_by_3p.sql"
  )
}}

デスクトップページの中央値では、サードパーティ製リソースを11個要求しているのに対し、ファーストパーティ製は10個です。サードパーティ製リソースがもたらす<a hreflang="en" href="https://css-tricks.com/potential-dangers-of-third-party-javascript/">パフォーマンスと信頼性のリスク</a>にかかわらず、デスクトップページとモバイルページの両方で、サードパーティ製スクリプトが一貫して好まれているようです。この効果は、サードパーティのスクリプトがウェブに与える<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/critical-rendering-path/adding-interactivity-with-javascript">便利なインタラクティビティ機能</a>によるものと考えられます。

とはいえ、サイトオーナーは、サードパーティ製のスクリプトが<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">パフォーマンス良くロードされていることを確認する必要があります</a>。<a href="https://twitter.com/csswizardry">Harry Roberts</a>は、さらに一歩進んで、<a hreflang="en" href="https://csswizardry.com/2017/07/performance-and-resilience-stress-testing-third-parties/">サードパーティのパフォーマンスとレジリエンスをストレステストすることを提唱しています</a>。

### `preload`と`prefetch`

ページがレンダリングされると、ブラウザは与えられたリソースをダウンロードしますが、リソースヒントを使って、ブラウザが使用するいくつかのリソースのダウンロードを他のリソースよりも優先させます。`preload`ヒントは、現在のページで必要となる、より高い優先順位のリソースをダウンロードするようブラウザに指示します。しかし`prefetch`ヒントは、リソースがしばらくしてから必要になる可能性があり（将来のナビゲーションに役立つ）、ブラウザにその能力があるときにリソースを取得し、必要になった時すぐに利用できるようにしたほうがよいということをブラウザに伝えます。これらの機能がどのように使われるかについては、[リソースヒント](./resource-hints)の章で詳しく説明しています。

{{ figure_markup(
  image="javascript-resource-hint-usage.png",
  caption="JavaScriptリソースでのリソースヒントの使用",
  description="デスクトップページの1.1％とモバイルページの1.0％が、1つ以上のJavaScriptリソースにリソースヒント`prefetch`を使用し、デスクトップリソースの15.8％とモバイルページの15.4％が、1つ以上のJavaScriptリソースに`preload`を使用していることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=686044315&format=interactive",
  sheets_gid="1387829188",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

`preload`ヒントは、15.4%のモバイルページでJavaScriptのロードに使用されていますが、`prefetch`ヒントは1.0%のモバイルページでしか使用されていません。デスクトップページでは、それぞれ15.8％と1.1％がJavaScriptリソースの読み込みにこれらのリソースヒントを使用しています。

また、ページごとに何個の `preload` と `prefetch` ヒントが使用されているかを確認することも、ヒントの影響に影響を与えるので便利です。たとえば、レンダリング時に読み込まれるリソースが5つあり、その5つすべてが `preload` ヒントを使用している場合、ブラウザはすべてのリソースを優先しようとしますが、これでは `preload` ヒントがまったく使用されていないのと同じように機能してしまいます。

{{ figure_markup(
  image="preload-hints-per-page.png",
  caption="ページごとのJavaScriptリソースのpreloadヒントの分布。",
  description="ページごとのプリフェッチヒントの分布を示す棒グラフ。デスクトップページの中央値は、プリロードヒントで1つのJavaScriptリソースをロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1180601651&format=interactive",
  sheets_gid="1107832831",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

{{ figure_markup(
  image="prefetch-hints-per-page.png",
  caption="ページごとのJavaScriptリソースのprefetchヒントの分布。",
  description="ページごとのprefetchヒントの分布を示す棒グラフ。デスクトップページの中央値は、2つのJavaScriptリソースをprefetchヒントでロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1265752379&format=interactive",
  sheets_gid="1107832831",
  sql_file="resource-hints-prefetch-preload-percentage.sql"
  )
}}

中央値のデスクトップページは、1つのJavaScriptリソースを `preload` ヒントでロードし、2つのJavaScriptリソースを `prefetch` ヒントでロードします。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヒント</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`preload`</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>`prefetch`</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="モバイルページあたりのJavaScriptリソースに対する`preload`および`prefetch`ヒントの数の中央値の前年比比較。",
    sheets_gid="1107832831",
    sql_file="resource-hints-prefetch-preload-percentage.sql"
  ) }}</figcaption>
</figure>

モバイルページあたりの`preload`ヒントの数の中央値は変わりませんが、`prefetch`ヒントの数は1ページあたり3つから2つに減りました。中央値では、これらの結果はモバイルページとデスクトップページの両方で同じであることに注意してください。

## JavaScriptはどのように配信されるのですか？

JavaScriptのリソースは、圧縮と最小化によってネットワーク上でより効率的に読み込むことができます。このセクションでは、両技術がどの程度効果的に利用されているかを理解するために、両技術の使用方法を探っていきます。

### 圧縮

圧縮とは、ネットワーク上で転送されるリソースのファイルサイズを小さくするプロセスです。圧縮率の高いJavaScriptリソースのダウンロード時間を短縮するには、この方法が有効です。たとえば、このページで読み込まれている `almanac.js` スクリプトは28KBですが、圧縮のおかげで転送時間はわずか9KBとなりました。ウェブ上でリソースが圧縮される方法については、[圧縮](./compression)の章で詳しく説明しています。

{{ figure_markup(
  image="compression-requests.png",
  caption="JavaScriptリソースの圧縮方法の採用。",
  description="圧縮方法の使用率を示す棒グラフ。モバイルでは、JavaScriptリクエストの55%がgzip圧縮を適用し、31%がbr圧縮を適用し、14%がどの圧縮方法も適用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1306457429&format=interactive",
  sheets_gid="1182320606",
  sql_file="compression_method.sql"
  )
}}

ほとんどのJavaScriptリソースは、<a hreflang="en" href="https://www.gnu.org/software/gzip/manual/gzip.html">Gzip</a>、<a hreflang="en" href="https://github.com/google/brotli">Brotli</a> (br) を使って圧縮されているか、あるいはまったく圧縮されていない（設定されていない）かのいずれかです。モバイルのJavaScriptリソースの55.4%がGzipで圧縮されているのに対し、30.8%がBrotliで圧縮されています。

興味深いことに、[2019年のJavaScript圧縮の状況](../2019/javascript#fig-10)と比較すると、Gzipは10ポイント近く下がり、Brotliは16ポイント上がっています。この傾向は、Gzipと比較してBrotliが提供する圧縮レベルは高く、より小さいサイズのファイルを重視するようになったことを示しています。

この変化を説明するために、私たちはファーストリソースとサードパーティリソースの圧縮方法を分析しました。

{{ figure_markup(
  image="compression-first-third-party.png",
  caption="モバイルページにおけるファーストおよびサードパーティのJavaScriptリソースを圧縮する方法の採用。",
  description="ファーストパーティとサードパーティの圧縮方法の使用率を示す棒グラフ。サードパーティのJSリクエストの59%がモバイルでgzip圧縮を適用し、サードパーティのリクエストの30%がbr圧縮を適用し、サードパーティのスクリプトの11%がどの圧縮方法も適用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1269923134&format=interactive",
  sheets_gid="821396474",
  sql_file="compression_method_by_3p.sql"
  )
}}

モバイルページ上のサードパーティスクリプトの59.1%がGzip圧縮、29.6%がBrotliで圧縮されています。ファーストパーティースクリプトを見ると、Gzip圧縮は51.7%ですが、Brotliでは32.0%にとどまります。また、圧縮方法が定義されていないサードパーティスクリプトが11.3%存在します。

{{ figure_markup(
  image="uncompressed-first-third-party.png",
  caption="ファーストパーティとサードパーティの非圧縮のリソース。",
  description="ファーストパーティとサードパーティの圧縮されていないリソースの割合を示す棒グラフ。非圧縮のサードパーティ製JavaScriptリソースの90%が5KB未満であり、10KB未満のファーストパーティ製リソースの非圧縮はわずか8%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1043138204&format=interactive",
  sheets_gid="1942216454",
  sql_file="compression_none_by_bytes.sql"
  )
}}

圧縮されていないサードパーティのJavaScriptリソースの90%は5KB未満ですが、ファーストパーティからのリクエストは少し遅れています。このことは、多くのJavaScriptリソースが圧縮されない理由を説明するのに役立つかもしれません。小さなリソースを圧縮することで得られる利益は減少するため、小さなスクリプトはネットワーク上で数バイトを節約することによるパフォーマンス上のメリットよりも、サーバー側での圧縮とクライアント側での解凍によるリソース消費の方が、大きくなる可能性があります。

### 最小化

圧縮はネットワーク上のJavaScriptリソースの転送サイズを変更するだけですが、ミニフィケーションは実際にコード自体を小さくし、より効率的にします。これにより、スクリプトの読み込み時間が短縮されるだけでなく、クライアントがスクリプトを解析するのに費やす時間も短縮されます。

<a hreflang="en" href="https://web.dev/unminified-javascript/">unminified JavaScript</a>のLighthouse監査では、最小化の機会を強調しています。

{{ figure_markup(
  image="unminified-js-audit-scores.png",
  caption="終了していないJavaScriptの監査スコアの分布",
  description='未処理JSの監査スコアの分布の割合を示す棒グラフです。モバイルページの67%が「未処理のJavaScript」のスコアが0.9～1.0の間にあります。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1572896641&format=interactive",
  sheets_gid="1539653841",
  sql_file="lighthouse_unminified_js.sql"
  )
}}

ここで、0.00は最悪のスコアを表し、1.00は最高のスコアを表します。モバイルページの67.1%は、オーディットスコアが0.9から1.0の間にあります。つまり、JavaScriptの未最適化のスコアが0.9よりも悪く、コードの最小化をより有効に活用できるページがまだ30%以上あるということです。[2020年版](../2020/javascript#fig-16)の結果と比較すると、「未処理のJS」のスコアが0.9から1.0の間にあるモバイルページの割合は10ポイント減少しました。

{# TODO: Rick氏はLighthouseチームに、過去1年間でこの監査に大きなスコアリングアルゴリズムの変更があったかどうかを確認しています。そうであれば、良いスコアが10ポイントも下がったことの良心的な説明になるでしょう。この変化は本当に驚きです。 #}

今年のスコアが悪化した理由を理解するために、より深く掘り下げて、1ページあたり何バイトが未処理であるかを見てみましょう。

{{ figure_markup(
  image="unminified-js-bytes.png",
  caption="ページごとの未処理のJavaScriptの量の分布（単位：KB）。",
  description="ページあたりの未処理のJSバイトの割合分布を示す棒グラフ。モバイルページの57％は0キロバイトの未確定JSを持ち、18％は0～10キロバイトの未確定JSを持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1069289665&format=interactive",
  sheets_gid="1511556407",
  sql_file="lighthouse_unminified_js_bytes.sql"
  )
}}

57.4%のモバイルページでは、Lighthouse監査で報告されたように、0KBの未処理のJavaScriptが使用されています。17.9%のモバイルページでは、0～10KBの未完成のJavaScriptが使用されています。残りのページでは、未処理のJavaScriptのバイト数が増加しており、前のグラフで「未処理のJavaScript」の監査スコアが低いページに対応しています。

{{ figure_markup(
  image="average-unminified-js-bytes.png",
  caption="未処理のJavaScriptバイトの平均的な分布。",
  description="未処理のJavaScriptバイトの平均分布を示す円グラフ。平均的なモバイルページの未消化のJavaScriptバイトの82％は、実際にはファーストパーティのスクリプトから来ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1119550643&format=interactive",
  sheets_gid="127709080",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

ホスト別に未処理のJavaScriptリソースを分類したところ、平均的なモバイルページの未処理のJavaScriptバイトの82.0％は、実際にはファーストパーティのスクリプトから来ていることがわかりました。

### ソースマップ

[ソースマップ](https://developer.mozilla.org/ja/docs/Tools/Debugger/How_to/Use_a_source_map)とは、JavaScriptのリソースと一緒に送信されるヒントで、ブラウザがそのリソースを最小化してソースコードにマッピングできます。ウェブ開発者にとっては、本番環境でのデバッグにとくに役立ちます。

{{ figure_markup(
  content="0.1%",
  caption="`SourceMap`ヘッダーを使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="1186092564",
  sql_file="sourcemap_header.sql"
  )
}}

スクリプトリソースに[`ソースマップ`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/SourceMap)レスポンスヘッダーを使用しているモバイルページは、わずか0.1%です。この極端に少ない割合の理由としては、ソースマップを使ってオリジナルのソースコードを本番に出すことを選択するサイトは少ないことが考えられます。

{{ figure_markup(
  content="98.0%",
  caption="`SourceMap`ヘッダーを使用するモバイルページのJavaScriptリソースのうち、ファーストパーティリソースの割合。",
  classes="big-number",
  sheets_gid="2057978707",
  sql_file="sourcemap_header.sql"
  )
}}

JavaScriptリソースの`SourceMap`使用率の98.0%がファーストパーティに起因しています。モバイルページでヘッダーを持つスクリプトのうち、サードパーティのリソースはわずか2.0%です。

## ライブラリーとフレームワーク

多くの新しいライブラリやフレームワークが採用され、開発者とユーザーの体験をそれぞれ独自に改善することが期待されているため、JavaScriptの使用量は年々増加しているようです。あまりにも広く普及しているため、開発者が追いつくのに苦労している様子を表す<a hreflang="en" href="https://allenpike.com/2015/javascript-framework-fatigue"><em>framework fatigue</em></a>という言葉が作られました。このセクションでは、現在ウェブ上で使用されているJavaScriptライブラリやフレームワークの人気度を見てみましょう。

### ライブラリーの利用

ライブラリやフレームワークの使用状況を把握するために、HTTP Archiveは[Wappalyzer](./methodology#wappalyzer)を使用して、ページで使用されている技術を検出しています。

{{ figure_markup(
  image="js-libs-frameworks.png",
  caption="JavaScriptのライブラリやフレームワークの使用方法。",
  description="JavaScriptライブラリとフレームワークの使用状況を示す棒グラフ。モバイルページの84％がjQueryを使用しており、依然としてトップです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=584103777&format=interactive",
  sheets_gid="1851485826",
  sql_file="frameworks_libraries.sql"
  )
}}

jQueryは依然としてもっとも人気のあるライブラリで、モバイルページの84％という驚異的な割合で使用されています。Reactの使用率は、昨年の4％から8％に急上昇しています。Reactの増加は、最近の<a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">Wappalyzerの検出力向上</a>による部分的なものであり、実際の採用状況の変化を必ずしも反映していない可能性があります。また、jQueryを使用したIsotopeが7％のページで見られ、RequireJSはわずか2％のページで上位から脱落していることも注目に値します。

2021年になっても、なぜjQueryが主流なのか不思議に思うかもしれません。これには主に2つの理由があります。まず、[前年よりも強調されている](../2019/javascript#open-source-libraries-and-frameworks)ように、ほとんどの<a hreflang="en" href="https://wordpress.org/">WordPress</a>サイトがjQueryを使用しています。[CMS](./cms)の章によると、WordPressはすべてのWebサイトの約3分の1で使用されているため、これがjQuery採用の大きな割合を占めています。また、他の主要なJavaScriptライブラリの中にも、何らかの形でjQueryを利用しているものがあり、間接的にjQueryが採用されていると考えられます。

{{ figure_markup(
  content="3.5.1",
  caption="もっとも普及しているjQueryのバージョンです。",
  classes="big-number",
  sheets_gid="1097559251",
  sql_file="frameworks_libraries_by_version.sql"
  )
}}

もっともよく使われているjQueryのバージョンは3.5.1で、モバイルページの21.3%で使用されています。次によく使われているjQueryのバージョンは1.12.4で、モバイルページの14.4%で使われています。バージョン3.0への飛躍は、2020年に行われた<a hreflang="en" href="https://wptavern.com/major-jquery-changes-on-the-way-for-wordpress-5-5-and-beyond">WordPress coreへの変更</a>により、jQueryのデフォルトバージョンが1.12.4から3.5.1にアップグレードされたことで説明できます。

### 併用するライブラリ

では、人気のフレームワークやライブラリが、同じページでどのように併用されているかを見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>フレームワークとライブラリ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">16.8%</td>
        <td class="numeric">17.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">8.4%</td>
        <td class="numeric">8.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">4.0%</td>
        <td class="numeric">3.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">2.6%</td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>Slick, jQuery</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>React, jQuery, jQuery Migrate</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="併用されているJavaScriptフレームワークとライブラリの上位の組み合わせ。",
    sheets_gid="1934429143",
    sql_file="frameworks_libraries_combos.sql"
  ) }}</figcaption>
</figure>

もっとも広く使われているJavaScriptのライブラリとフレームワークの組み合わせは、実際には複数のライブラリで構成されているわけではありません！jQueryを単独で使用した場合、モバイルページの17.4%に使用されています。次に多い組み合わせは「jQuery」と「jQuery Migrate」で、モバイルページの8.7％で使用されている。実際、ライブラリとフレームワークの組み合わせのトップ10には、すべてjQueryが含まれている。

### セキュリティの脆弱性

JavaScriptライブラリを使用するには、それなりのメリットとデメリットがあります。これらのライブラリを使用する際の欠点として、古いバージョンには<a hreflang="en" href="https://owasp.org/www-community/attacks/xss/">Cross Site Scripting</a>（XSS）のようなセキュリティリスクが含まれている可能性があります。[Lighthouse](./methodology#lighthouse)は、ページで使用されているJavaScriptライブラリを検出し、そのバージョンがオープンソースの<a hreflang="en" href="https://snyk.io/vuln?type=npm">Snyk脆弱性データベース</a>で既知の脆弱性を持っていた場合、監査に失敗します。

{{ figure_markup(
  content="63.9%",
  caption="セキュリティ上の脆弱性があるライブラリを持つモバイルページの割合。",
  classes="big-number",
  sheets_gid="793786066",
  sql_file="lighthouse_vulnerabilities.sql"
  )
}}

モバイルページの63.9%が、既知のセキュリティ脆弱性を持つJavaScriptライブラリまたはフレームワークを使用しています。この数字は、[昨年の83.5%から](../2020/javascript#fig-30)減少しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ライブラリやフレームワーク</th>
        <th>ページ数の割合</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">57.6%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">12.2%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">10.5%</td>
      </tr>
      <tr>
        <td>Underscore</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>Lo-Dash</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>GreenSock JS</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>AngularJS</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Angular</td>
        <td class="numeric">0.4%</td>
      </tr>
        <td>Vue</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Knockout</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Highcharts</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Next.js</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="脆弱なバージョンのJavaScriptライブラリまたはフレームワークを含むことが判明したモバイルページの割合。",
    sheets_gid="551476210",
    sql_file="lighthouse_vulnerable_libraries.sql"
  ) }}</figcaption>
</figure>

モバイルページの割合をライブラリとフレームワーク別に分けてみると、脆弱性の減少にはjQueryが大きく関わっていることがわかります。今年のJavaScriptの脆弱性は、jQueryを使用しているページの57.6%で発見されたのに対し、[昨年は80.9%](../2020/javascript#fig-31)でした。本章の2020年版で[Tim Kadlec](../2020/contributors#tkadlec)が[予測](../2020/javascript#fig-31)したように、<em>「もし人々がそれらの古くて脆弱なバージョンのjQueryから移行できれば、既知の脆弱性を持つサイトの数は激減するでしょう」</em>。WordPressは、jQueryのバージョン1.12.4からより安全なバージョン3.5.1に移行したことで、JavaScriptの脆弱性が確認されたページの割合が20ポイント減少しました。

## JavaScriptはどのように使用されていますか？

さて、JavaScriptの取得方法を見てきましたが、何のために使うのでしょうか？

### AJAX

JavaScriptは、サーバーと通信してさまざまな形式の情報を非同期的に受け取るために使用されます。[_Asynchronous JavaScript and XML_](https://developer.mozilla.org/en-US/docs/Web/Guide/AJAX/Getting_Started) (AJAX)は、一般的にデータの送受信に使用され、XML以外にもJSON、HTML、テキスト形式などをサポートしています。

ウェブ上でデータを送受信する方法が複数ある中で、1ページあたりに送信される非同期リクエストの数を見てみましょう。

{{ figure_markup(
  image="async-requests-per-page.png",
  caption="ページあたりの非同期リクエスト数の分布。",
  description="ページあたりの非同期リクエストの数を示す棒グラフ。デスクトップのページでは、非同期リクエスト数の10、25、50、75、90パーセンタイルの割合は次のとおりです。2、3、4、8、15。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=709009883&format=interactive",
  sheets_gid="183546956",
  sql_file="ajax_request_per_page.sql"
  )
}}

モバイルページの中央値は4つの非同期リクエストを行っています。ロングテールを見ると、デスクトップページの非同期リクエストの最大数は623で、最大のモバイルページの867の非同期リクエストに抜かれています！

非同期型のAJAXリクエストの代わりに、同期型のリクエストがあります。リクエストをコールバックに渡すのではなく、リクエストが完了するまでメインスレッドをブロックします。

しかし、パフォーマンスやユーザー体験が、低下する可能性があるため、[このような行為は推奨されません](https://developer.mozilla.org/ja/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests#synchronous_request)。また、多くのブラウザでは、このような使用方法についてすでに警告を発しています。今でも同期型のAJAXリクエストを使用しているページがどれだけあるのか、興味をそそられますね。

{{ figure_markup(
  image="usage-sync-async.png",
  caption="同期および非同期のAJAXリクエストの使用法",
  description="モバイルページにおける同期および非同期のAJAXリクエストの使用状況を示す棒グラフ。モバイルページにおける同期型リクエストの割合は2.5％、非同期型リクエストの割合は77.6％となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=189627938&format=interactive",
  sheets_gid="1113974683",
  sql_file="ajax_request_per_page.sql"
  )
}}

モバイルページの2.5%が、非推奨の同期型AJAXリクエストを使用しています。これを踏まえて、過去2年間の結果と比較して、その傾向を見てみましょう。

{{ figure_markup(
  image="usage-sync-async-over-years.png",
  caption="長年にわたる同期および非同期AJAXリクエストの使用状況。",
  description="過去数年間の同期および非同期のAJAXリクエストの使用状況を示す棒グラフ。2019年にモバイルで行われた非同期リクエストの割合は54.9%で、2020年には61.8%、2021年は77.6%と増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=126336838&format=interactive",
  sheets_gid="1113974683",
  sql_file="ajax_async.sql"
  )
}}

非同期型のAJAXリクエストの使用率が明らかに増加していることがわかります。しかし、同期型のAJAXリクエストの使用率には大きな減少は見られません。

現在、ページあたりのAJAXリクエストの数を知っているので、サーバーからデータを要求するためにもっとも一般的に使用されているAPIについても知りたいと思います。

これらのAJAXリクエストを大まかに3つの異なるAPIに分類し、それらがどのように使用されているかを調べてみましょう。コアAPIである[`XMLHttpRequest`](https://developer.mozilla.org/ja/docs/Web/API/XMLHttpRequest) (XHR)、[`Fetch`](https://developer.mozilla.org/ja/docs/Web/API/Fetch_API/Using_Fetch)、[`Beacon`](https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API)は、Webサイト全体で一般的に使用されており主にXHRが使用されていますが、`Fetch`は人気が高く急成長しており、`Beacon`は使用率が低いです。

{{ figure_markup(
  image="ajax_xhr.png",
  caption="ページあたりのXMLHttpRequestリクエスト数の分布。",
  description="デスクトップとモバイルの両方のページで、ページあたりのXMLHttpRequestの使用率を示す棒グラフ。モバイルページの中央値では2回のXHRリクエストが行われていますが、90パーセンタイルでは6回のXHRリクエストが行われています。デスクトップでのXMLHttpRequestの使用率の10、25、50、75、90パーセンタイルは次のとおりです。0、1、2、3、6。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1164635195&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

モバイルページの中央値は2回のXHRリクエストを行いますが、90パーセンタイルの割合では6回のXHRリクエストを行います。

{{ figure_markup(
  image="ajax_fetch.png",
  caption="ページあたりの `Fetch` リクエスト数の分布。",
  description="デスクトップとモバイルの両ページにおける、ページあたりのFetchの使用状況を示す棒グラフ。モバイル・ページの中央値は2回のFetch要求ですが、90パーセンタイルでは3回のFetch要求です。モバイルにおけるFetchの使用率の10、25、50、75、90パーセンタイルは次のとおりです。0、2、2、2、3。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=147712640&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

`Fetch` APIを使用した場合、モバイルページの中央値では2回のリクエスト、ロングテールでは3回のリクエストに達します。このAPIはXHRの標準的なリクエスト方法になりつつありますが、その理由の1つは、よりクリーンなアプローチと、定型的なコードが少ないことです。また、`Fetch`は従来のXHRアプローチよりも<a hreflang="en" href="https://gomakethings.com/the-fetch-api-performance-vs.-xhr-in-vanilla-js/">パフォーマンス上のメリット</a>があるかもしれません。これは、ブラウザがメインスレッドから大きなJSONペイロードをデコードする方法によるものです。

{{ figure_markup(
  image="ajax_beacon.png",
  caption="1ページあたりの `Beacon` リクエストの数の分布。",
  description="デスクトップとモバイルの両方のページで、1ページあたりのBeaconの使用状況を示す棒グラフです。モバイルページの中央値ではBeaconのリクエストはありませんが、90パーセンタイルでは1つのBeaconのリクエストがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1483701430&format=interactive",
  sheets_gid="1012977216",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

`Beacon`の使用率はほとんどなく、1ページあたりのリクエスト数は0で、90パーセンタイルまでは1ページあたり1つのリクエストしかありませんでした。この普及率の低さを説明する1つの可能性として、`Beacon`は一般的に分析データの送信に使用され、とくに、すぐにページをアンロードされる可能性があっても確実にリクエストを送信したい場合に使用されることが挙げられます。しかし、XHRを使用している場合、これは保証されていません。将来的には、分析データやセッションデータなどのために、XHRを使用しているページの統計情報を収集できるかどうかを試してみるとよいでしょう。

XHRと`Fetch`の採用状況を時系列で比較するのもおもしろいかもしれません。

{{ figure_markup(
  image="ajax-apis-per-year.png",
  caption="年別のAJAX APIの採用状況。",
  description="モバイルページにおけるページごとのXHRとFetchリクエストの採用状況を示す棒グラフ。XHRの使用率は、2019年に58％、2020年に62％、2021年に78％と増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpHzC_cMZYj2VLzQ4ODK3uvZkNBXtwdAZriZaBwjLjUM1SGwwmJs9rv8T6OtNdXox29PQ34CasUUwc/pubchart?oid=1254898632&format=interactive",
  sheets_gid="417043080",
  sql_file="percentage_usage_of_different_ajax_apis.sql"
  )
}}

`Fetch`と`XHR`の両方において、ここ数年で使用量が大幅に増加しています。モバイルページでの `Fetch` の使用率は4ポイント、XHRは19ポイント上昇しています。`Fetch`の採用が徐々に増加していることは、よりクリーンなリクエストと優れたレスポンス処理の傾向を示しているように思われます。

### Web ComponentsとシャドウDOM

ウェブが[コンポーネント化](https://developer.mozilla.org/ja/docs/Web/Web_Components)されていく中で、シングルページアプリケーションを構築する開発者は、ユーザービューをコンポーネントのセットとして考えることができます。これは、開発者が各機能ごとに専用のコンポーネントを構築するためだけでなく、コンポーネントの再利用性を最大限に高めるためでもあります。それは、同じアプリの別のビューにあったり、まったく別のアプリにあったりします。このようなユースケースでは、アプリケーションにカスタムエレメントやウェブコンポーネントが使用されます。

多くのJavaScriptフレームワークが普及したことで、再利用性や専用の機能ベースのコンポーネントを構築するという考え方がより広く採用されるようになったと言ってもいいでしょう。このことは、カスタム要素、シャドウDOM、テンプレート要素の採用を検討する上で、私たちの好奇心を刺激します。

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/customelements">カスタムエレメント</a>は、[`HTMLElement`](https://developer.mozilla.org/ja/docs/Web/API/HTMLElement)のAPIの上に構築されたカスタマイズされたエレメントです。ブラウザは`customElements`というAPIを提供しており、開発者は要素を定義し、それをカスタム要素としてブラウザに登録できます。

{{ figure_markup(
  content="3.0%",
  caption="カスタムエレメントを使用しているデスクトップページの割合。",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_pct.sql"
  )
}}

3.0%のモバイルページでは、ウェブページの1つ以上の部分にカスタム要素を使用しています。

{{ figure_markup(
  content="0.4%",
  caption="シャドウDOMを使用しているページの割合。",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_pct.sql"
  )
}}

<a hreflang="en" href="https://developers.google.com/web/fundamentals/web-components/shadowdom">_シャドウDOM_</a>では、ブラウザに導入されたカスタム要素のために、DOM内に専用のサブツリーを作成できます。これにより、要素内のスタイルやノードが要素の外からアクセスできないようになります。

0.4%のモバイルページでは、ウェブコンポーネントのシャドウDOM仕様を利用して、要素のスコープ付きサブツリーを確保しています。

{{ figure_markup(
  content="<0.1%",
  caption="`template`要素を使用しているページの割合。",
  classes="big-number",
  sheets_gid="1991863136",
  sql_file="web_components_pct.sql"
  )
}}

マークアップに再利用可能なパターンがある場合には、[`template`](https://developer.mozilla.org/ja/docs/Web/Web_Components/Using_templates_and_slots#%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88%E3%81%AE%E7%9C%9F%E5%AE%9F)要素が非常に便利です。`template`要素のコンテンツは、JavaScriptで参照されたときにのみレンダリングされます。

テンプレートは、JavaScriptでまだ参照されていないコンテンツが、シャドウDOMを使ってシャドウルートに追加されるため、ウェブコンポーネントを扱う際に有効です。

テンプレートを採用しているWebページは全体の0.1%にも満たない。テンプレートはブラウザで<a hreflang="en" href="https://caniuse.com/template">よくサポート</a>されていますが、テンプレートを使用しているページの割合はまだ非常に低いです。

## 結論

この章で見てきた数字は、JavaScriptの使用がいかに膨大であるか、また時間の経過とともにどのように進化しているかを理解させてくれました。JavaScriptのエコシステムはウェブのパフォーマンスを向上させ、ユーザーの安全性を高めることに重点を置き、開発者の作業を容易にし、生産性を向上させる新しい機能やAPIを備えて成長してきました。

レンダリングやリソースローディングのパフォーマンスを向上させる多くの機能が、ユーザーに高速な体験を提供するために、より広く活用されていることがわかりました。開発者の皆様は、これらの新しいWebプラットフォームの機能を採用することから始めることができます。しかし、これらの機能を賢く利用し、実際にパフォーマンスが向上することを確認してください。というのも、同じスクリプトで `async` 属性と `defer` 属性を使用した場合のように、APIの中には誤用によって害を及ぼすものがあるからです。

今、私たちが利用できる強力なAPIを適切に活用することが、この数字を今後さらに向上させるために必要です。これからもそうしていきましょう。
