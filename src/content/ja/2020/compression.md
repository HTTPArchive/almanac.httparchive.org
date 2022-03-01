---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 圧縮
description: 2020年版Web Almanacの圧縮の章では、HTTP圧縮、アルゴリズム、コンテンツタイプ、ファーストパーティおよびサードパーティによる圧縮とその機会について説明しています。
authors: [mo271, veluca93, sboukortt, jyrkialakuijala]
reviewers: [paulcalvano]
analysts: [AbbyTsai]
editors: [exterkamp]
translators: [ksakae1216]
jyrkialakuijala_bio: Jyrki Alakuijalaは、オープンソースソフトウェアコミュニティの活発なメンバーであり、データ圧縮の研究者でもあります。最近の研究テーマは、Zopfli、Butteraugli、Guetzli、Gipfeli、WebP lossless、Brotli、JPEG XLなどの圧縮フォーマットとアルゴリズム、およびCityHashとHighwayHashという2つのハッシュアルゴリズムです。Googleに入社する前は、神経外科や放射線治療の治療計画用ソフトウェアを開発していました。
sboukortt_bio: Samiは、工学数学の研究を終えてGoogleに入社しました。圧縮に遠隔で興味を持って数年後、最終的には2018年にフルタイムの仕事になりました。
mo271_bio: Moritz Firschingは、Google Switzerlandのソフトウェアエンジニアで、プログレッシブ画像フォーマットとフォント圧縮に取り組んでいます。それ以前は、数学者としてポリトープの研究をしていました。
veluca93_bio: Luca Versariは、Googleのソフトウェアエンジニアで、<a hreflang="en" href="https://gitlab.com/wg1/jpeg-xl">JPEG XL</a>の開発に携わっています。グラフ圧縮に関する博士号を取得中で、数学のバックグラウンドを持っています。
discuss: 2055
results: https://docs.google.com/spreadsheets/d/1NKbP4AqMkgCNCsVD3yLhO2d0aqIsgZ7AGLEtUDHl9yY/
featured_quote: HTTP圧縮を使用すると、ウェブサイトの読み込みが速くなり、より良いユーザー体験が保証されます。
featured_stat_1: 23%
featured_stat_label_1: Brotliを使用する圧縮されたレスポンス
featured_stat_2: 77%
featured_stat_label_2: Gzipを使用した圧縮されたレスポンス
featured_stat_3: 74%
featured_stat_label_3: Lighthouseの監査に合格し、テキスト圧縮で最大のスコアを獲得したウェブサイト
---

## 序章

HTTP圧縮を使用すると、ウェブサイトの読み込みが速くなるため、より良いユーザー体験が保証されます。HTTP圧縮を行わない場合は、ユーザー体験が低下し、関連するウェブサービスの成長率に影響を与え、検索ランキングにも影響を与えます。 圧縮を効果的に使用することで、[ページウェイト](./page-weight)を減らし、[ウェブパフォーマンス](./performance)を向上させることができるため、[検索エンジン最適化](./seo)の重要な部分となります。

画像やその他の[media](./media)タイプでは非可逆圧縮を許容することが多いのですが、テキストの場合は可逆圧縮、つまり解凍後に正確なテキストを復元したいと考えています。

## どのようなコンテンツを圧縮すべきか？

[HTML](./markup)、[CSS](./css)、[JavaScript](./javascript)、JSON、SVGなどのほとんどのテキストベースのアセットや、woff、ttf、icoなどの特定の非テキストフォーマットについては、圧縮を使用することをオススメします。

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="コンテンツタイプ別の圧縮方法",
  description="異なる圧縮アルゴリズムの使用率をコンテンツタイプ別に分類した積み上げ棒グラフです。積み重ねられた棒グラフは、Brotli、Gzip、および圧縮なしの使用を分けています。`text/html` は、圧縮率が50%未満の唯一のコンテンツタイプです。`application/json`と`image/svg+xml`はそれぞれ約64%の圧縮率です。`text/css`と`application/javascript`はそれぞれ約85%の圧縮率です。`application/x-javascript`と`text/javascript`はそれぞれ90%以上の圧縮率です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1658254159&format=interactive",
  sheets_gid="107138856",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

この図は、あるコンテンツタイプのレスポンスのうち、Brotli、Gzip、またはテキスト圧縮なしのいずれかを使用している割合を示しています。
驚くべきことに、すべてのコンテンツタイプで圧縮が有効であるにもかかわらず、その割合の範囲はコンテンツタイプごとに大きく異なっています。たとえば、`text/html`で圧縮を使用しているのはわずか44%であるのに対し、`application/x-javascript`では93%です。

画像ベースの資産では、テキストベースの圧縮はあまり役に立たず、広く採用されていません。データによると、BrotliやGzipを採用している画像レスポンスの割合は非常に低く、4%未満です。テキストベース以外のアセットの詳細については、[メディア](./media)の章を参照してください。

{{ figure_markup(
  image="http-compression-methods-for-image-types.png",
  caption="デスクトップ上の画像タイプの圧縮方法",
  description="これは、すべてのコンテンツタイプのうち、画像に対してどのような圧縮方法が使われているかを示したものです。jpeg、png、gifの3種類の画像タイプでは、約96.5%が圧縮を使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1287110333&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

## HTTP圧縮はどのように使うのですか？

たとえば、<a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>、<a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a>、<a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a>などの最小化ツールを使用できます。しかし、圧縮機能を使うことで、より大きな効果が期待できます。

サーバー側で圧縮を行うには2つの方法があります。

  - 事前圧縮（事前にアセットを圧縮して保存しておくこと）
  - 動的圧縮（リクエストがあったときに、その場でアセットを圧縮する）

事前に圧縮されているので、アセットの圧縮に時間をかけることができます。一方、動的に圧縮されたリソースの場合は、非圧縮ファイルと圧縮ファイルの送信時間の差よりも圧縮にかかる時間が短くなるように圧縮レベルを選択する必要があります。この違いは、両方式の推奨圧縮レベルを見るとよくわかります。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Brotli</th>
        <th scope="col">Gzip</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>事前圧縮</td>
        <td>11</td>
        <td>9かZopfli</td>
      </tr>
      <tr>
        <td>動的圧縮</td>
        <td>5</td>
        <td>6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="使用する推奨圧縮レベル") }}</figcaption>
</figure>

現在、実質的にすべてのテキスト圧縮は、2つのHTTPコンテンツエンコーディングのいずれかによって行われています。<a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a>と<a hreflang="en" href="https://github.com/google/brotli">Brotli</a>です。どちらもブラウザで広くサポートされています。<a hreflang="en" href="https://caniuse.com/?search=brotli">Brotliを使用できます</a>/<a hreflang="en" href="https://caniuse.com/?search=gzip">Gzipを使用できます</a>

Gzipを使用したい場合は、より小さいGzip互換ファイルを生成する[Zopfli](https://ja.wikipedia.org/wiki/Zopfli)の使用を検討してください。これは、とくに圧縮済みのリソースに対して行うべきです。なぜなら、ここでは最大の<a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">利益が期待できるからです</a>。Gzipの異なる圧縮レベルを考慮した <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">GzipとZopfliの比較</a>を参照してください。

多くの[一般的なサーバ](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression)は、動的および/または事前に圧縮されたHTTPをサポートしており、その多くが[Brotli](https://en.wikipedia.org/wiki/Brotli)をサポートしています。

## HTTP圧縮の現状

HTTPレスポンスの約60%は、テキストベースの圧縮を行わずに配信されています。これは驚くべき統計のように思われるかもしれませんが、データセット内のすべてのHTTPレスポンスに基づいていることを覚えておいてください。図19.2に示すように、画像などの一部のコンテンツは、これらの圧縮アルゴリズムの恩恵を受けないため、あまり使用されていません。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">コンテンツのエンコード</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">組み合わせ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>テキスト圧縮なし</em></td>
        <td class="numeric">60.06%</td>
        <td class="numeric">59.31%</td>
        <td class="numeric">59.67%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30.82%</td>
        <td class="numeric">31.56%</td>
        <td class="numeric">31.21%</td>
      </tr>
      <tr>
        <td>Brotli</td>
        <td class="numeric">9.10%</td>
        <td class="numeric">9.11%</td>
        <td class="numeric">9.11%</td>
      </tr>
      </tr>
      <tr>
        <td><em>その他</em></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="圧縮アルゴリズムの採用", sheets_gid="1365871671", sql_file="19_01.type_of_content_encoding.sql") }}</figcaption>
</figure>

圧縮されて提供されているリソースのうち、大部分はGzip（77%）またはBrotli（23%）のいずれかを使用しています。その他の圧縮アルゴリズムはあまり使用されていません。

{{ figure_markup(
  image="compression-algorithms-for-http-responses.png",
  caption="HTTPレスポンスの圧縮アルゴリズム。",
  description="HTTPレスポンスに対するさまざまな圧縮アルゴリズムの使用率を示す棒グラフです。圧縮を使用しているHTTPレスポンスの77.39%がGzipアルゴリズム、22.59%がBrotli、0.03%がその他の方法を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1523202090&format=interactive",
  sheets_gid="1365871671",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

下のグラフでは、上位11種類のコンテンツタイプが表示されており、ボックスの大きさは回答数の相対的な増減を表しています。各ボックスの色は、これらのリソースのうちどれだけが圧縮されて提供されたかを表しており、オレンジは圧縮の割合が低いことを、青は圧縮の割合が高いことを示しています。メディアコンテンツのほとんどがオレンジ色に塗られていますが、これはGzipやBrotliではほとんどメリットがないことから予想されます。 ほとんどのテキストコンテンツは、圧縮されていることを示すために青く塗られています。しかし、一部のコンテンツタイプの淡い水色は、他のコンテンツほど一貫して圧縮されていないことを示しています。

{{ figure_markup(
  image="compression-algorithms-by-content-type-desktop.png",
  caption="デスクトップページのタイプ別圧縮",
  description="ツリーマップチャートには、image/jpeg（91,926,198レスポンス - 3.27%圧縮）、application/javascript（80,360,676レスポンス - 84.88%圧縮）、image/png（66,351,767レスポンス - 3.7%圧縮）、text/css（54,104,482レスポンス - 84.0%圧縮）、text/html（48,670,006レスポンス - 44. 25%圧縮）が含まれています。 25%圧縮）、image/gif（39,390,408レスポンス - 3.42%圧縮）、text/javascript（35,491,375レスポンス - 90.74%圧縮）、application/x-javascript（22,714,896レスポンス - 93.14%圧縮）、application/json（13,453,942レスポンス - 63.02%圧縮）、text/plain（4,629,644レスポンス - 32.89%圧縮）があります。)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=777357707&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

前述の図19.1では、コンテンツタイプごとの圧縮の割合を示していますが、図19.6では、この割合を色で表しています。この2つの図は似ており、非テキストベースのアセットはほとんど圧縮されておらず、テキストベースのアセットはよく圧縮されていることがわかります。また、圧縮率は、モバイルとデスクトップの両方で似ています。

## ファーストパーティとサードパーティの圧縮

[サードパーティ](./third-parties)の章では、サードパーティとそのパフォーマンスへの影響について学びます。サードパーティの使用は、圧縮にも影響します。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">デスクトップ</th>
        <th scope="colgroup" colspan="2">モバイル</th>
      </tr>
      <tr>
        <th scope="col">コンテンツのエンコード</th>
        <th scope="col">ファースト・パーティ</th>
        <th scope="col">サードパーティ</th>
        <th scope="col">ファースト・パーティ</th>
        <th scope="col">サードパーティ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>テキスト圧縮なし</em></td>
        <td class="numeric">61.93%</td>
        <td class="numeric">57.81%</td>
        <td class="numeric">60.36%</td>
        <td class="numeric">58.11%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30.95%</td>
        <td class="numeric">30.66%</td>
        <td class="numeric">32.36%</td>
        <td class="numeric">30.65%</td>
      </tr>
      <tr>
        <td>br</td>
        <td class="numeric">7.09%</td>
        <td class="numeric">11.51%</td>
        <td class="numeric">7.26%</td>
        <td class="numeric">11.22%</td>
      </tr>
      <tr>
        <td>deflate</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><em>その他 / 無効</em></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デバイスタイプ別のファーストパーティ対サードパーティの圧縮率", sheets_gid="862864630", sql_file="19_03.party_of_content_encoding.sql") }}</figcaption>
</figure>

ファーストパーティとサードパーティの圧縮技術を比較すると、サードパーティのコンテンツはファーストパーティのコンテンツよりも圧縮される傾向にあることがわかります。さらに、Brotliの圧縮率はサードパーティのコンテンツの方が高くなっています。これは、GoogleやFacebookなど、通常Brotliをサポートしている大規模なサードパーティから提供されるリソースの数が多いためと考えられます。

[昨年の結果](../2019/compression#first-party-vs-third-party-compression)と比較すると、ファーストパーティでのBrotliを中心とした圧縮の使用が大幅に増加し、ファーストパーティとサードパーティ、デスクトップとモバイルの両方で圧縮の使用が約40%になっていることがわかります。しかし、圧縮を使用している回答のうち、ファーストパーティではBrotliの圧縮率はわずか18％、サードパーティでは27％となっています。

## あなたのサイトの圧縮率を分析する方法

[Firefox Developer Tools](https://developer.mozilla.org/ja/docs/Tools)または<a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a>を使用すると、ウェブサイトがすでに圧縮しているコンテンツをすばやく把握できます。これを行うには、[ネットワーク]タブを開き、右クリックして[応答ヘッダー]の[コンテンツエンコード]を有効にします。個々のファイルのサイズにカーソルを合わせると、「ネットワークでの転送量」と「リソースサイズ」が表示されます。サイト全体で集計すると、Firefoxではサイズ/転送サイズ、Chromeでは「転送」と「リソース」がネットワークタブの左下に表示されます。

{{ figure_markup(
  image="content-encoding.png",
  caption='DevToolsを使用して、サイトでコンテンツのエンコーディングが使用されているかどうかを確認する',
  description="DevToolsを使ってコンテンツ・エンコーディングが使用されているかどうかを確認する方法を示す画像。",
  width=591,
  height=939
  )
}}

また、サイトの圧縮について理解を深めるためのツールとして、Googleの<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>というツールがあり、ウェブページに対して一連の監査を実行できます。<a hreflang="ja" href="https://web.dev/i18n/ja/uses-text-compression/">テキスト圧縮監査</a>では、サイトがテキストベースの圧縮を追加することで利益を得られるかどうかを評価します。この監査では、リソースの圧縮を試み、オブジェクトのサイズを少なくとも10%および1,400バイト削減できるかどうかを評価します。スコアに応じて、結果に圧縮の推奨事項が表示され、圧縮可能な特定のリソースのリストが表示されます。

[HTTP Archive Lighthouseの監査を実施](./methodology#lighthouse)はモバイルページごとに行われるため、すべてのサイトのスコアを集計して、より多くのコンテンツを圧縮する機会がどれだけあるかを知ることができます。全体では74％のウェブサイトがこの監査に合格していますが、約13％のウェブサイトが40点以下のスコアを記録しています。これは、[昨年](../2019/compression#identifying-compression-opportunities)の62.5%の合格スコアと比較すると、11.5%の改善となります。

{{ figure_markup(
  image="text-compression-lighthouse-scores.png",
  caption="テキスト圧縮Lighthouseのスコア",
  description='「テキスト圧縮を有効にする」というLighthouse監査でページが獲得したスコアを棒グラフで表したものです。これによると、10%未満のスコアのサイトが7%、10～39%のスコアのサイトが6%、40～79%のスコアのサイトが10%、80～99%のスコアのサイトが3%、そしてテキストアセットを100%以上圧縮して合格したサイトが74%となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1438276663&format=interactive",
  sheets_gid="1284073179",
  sql_file="19_04.distribution_of_text_compression_lighthouse.sql"
  )
}}

## 結論

[昨年のAlmanac](../2019/compression)と比較すると、より多くのテキスト圧縮を使用する傾向が明らかになっています。テキスト圧縮を一切使用していない回答は2%強減少し、同時にBrotliの使用が2%近く増加しています。Lighthouseのスコアは大幅に向上しました。

テキストの圧縮は、関連するフォーマットに広く使用されていますが、HTTPレスポンスの中には、さらなる圧縮を必要とするものがかなりの割合で存在しています。サーバーの設定をよく見て、必要に応じて圧縮方法やレベルを設定するとよいでしょう。もっとも一般的なHTTPサーバーのデフォルトを注意深く選択することで、よりポジティブなユーザー体験に大きな影響を与えることができます。
