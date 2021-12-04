---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: 2019年のWeb AlmanacのJavaScriptの章では、Web上でどれだけJavaScriptを使用しているか、圧縮、ライブラリとフレームワーク、読み込み、ソースマップを網羅しています。
authors: [housseindjirdeh]
reviewers: [obto, paulcalvano, mathiasbynens, rviscomi]
analysts: [rviscomi]
editors: [obto]
translators: [ksakae]
discuss: 1756
results: https://docs.google.com/spreadsheets/d/1kBTglETN_V9UjKqK_EFmFjRexJnQOmLLr-I2Tkotvic/
housseindjirdeh_bio: HousseinはGoogleの開発提唱者で、スピード、パフォーマンス、ウェブフレームワークのエコシステムに取り組んでいます。彼は <a href="https://twitter.com/hdjirdeh">@hdjirdeh</a> でツイートし、<a hreflang="en" href="https://houssein.me/">https://houssein.me/</a> でブログを書いています。
featured_quote: JavaScript はブラウザに送信するリソースの中で最もコストのかかるもので、ダウンロード、解析、コンパイル、そして最終的に実行されます。ブラウザはスクリプトの解析とコンパイルにかかる時間を大幅に短縮しましたが、ダウンロードと実行は、JavaScriptがWebページで処理される際に最もコストのかかる段階となっています。
featured_stat_1: 89%
featured_stat_label_1: ファーストパーティよりもサードパーティのコードが多いサイト
featured_stat_2: 83%
featured_stat_label_2: jQueryを使用しているサイト
featured_stat_3: 4.6%
featured_stat_label_3: Reactを使ったホームページ
---

## 序章

JavaScriptはウェブ上で、対話可能で複雑な体験を構築することを可能にするスクリプト言語です。これには、ユーザーの会話への応答、ページ上の動的コンテンツの更新などが含まれます。イベントが発生したときにウェブページがどのように振る舞うべきかに関係するものはすべて、JavaScriptが使用されています。

言語の仕様自体は、世界中の開発者が利用している多くのコミュニティビルドのライブラリやフレームワークとともに、1995年に言語が作成されて以来、変化と進化を続けてきました。JavaScriptの実装やインタプリタも進歩を続けており、ブラウザだけでなく多くの環境で利用できるようになっています。

<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>は毎月<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">数百万ページ</a>をクロールし、<a hreflang="en" href="https://webpagetest.org/">WebPageTest</a> のプライベートインスタンスを通して実行し、各ページのキー情報を保存しています（これについての詳細は[方法論](./methodology) で学べます）。JavaScriptのコンテキストでは、HTTP Archiveはウェブ全体の言語の使用法に関する広範な情報を提供しています。この章では、これらの傾向の多くを集約して分析します。

## どのくらいのJavaScriptを使っているのか？

JavaScriptは、私たちがブラウザに送るリソースの中で最もコストのかかるものでダウンロード、解析、コンパイル、そして最終的に実行されなければなりません。ブラウザはスクリプトの解析とコンパイルにかかる時間を大幅に短縮しましたが、WebページでJavaScriptが処理される際には、<a hreflang="en" href="https://v8.dev/blog/cost-of-javascript-2019">ダウンロードと実行が最もコストのかかる段階になっています</a>。

ブラウザに小さなJavaScriptのバンドルを送ることは、ダウンロード時間を短縮し、ひいてはページパフォーマンスを向上させるための最良の方法です。しかし、実際にどのくらいのJavaScriptを使っているのでしょうか？

{{ figure_markup(
  image="fig1.png",
  caption="ページあたりのJavaScriptバイト数の分布",
  description="10パーセンタイルで70バイト、25パーセンタイルで174バイト、50パーセンタイルで373バイト、75パーセンタイルで693バイト、90パーセンタイルで1,093バイトのJavaScriptを使用していることを示す棒グラフ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1974602890&format=interactive"
  )
}}

上の図1.1を見ると、JavaScriptを373KB使用しているのは、50パーセンタイル（中央値）であることがわかります。つまり、全サイトの50％がこれだけのJavaScriptをユーザーに提供していることになります。

この数字を見ると、これはJavaScriptの使いすぎではないかと思うのは当然のことです。しかし、ページのパフォーマンスに関しては、その影響はネットワーク接続や使用するデバイスに完全に依存します。モバイルクライアントとデスクトップクライアントを比較した場合、どのくらいのJavaScriptを提供しているのでしょうか？

{{ figure_markup(
  image="fig2.png",
  caption="デバイス別のページあたりのJavaScriptの分布。",
  description="デスクトップとモバイルでそれぞれ10パーセンタイルで76バイト/65バイトのJavaScriptを使用していることを示す棒グラフで、25パーセンタイルで186/164バイト、50パーセンタイルで391/359バイト、75パーセンタイルで721/668バイト、90パーセンタイルで1,131/1,060バイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1914565673&format=interactive"
  )
}}

どのパーセンタイルでも、モバイルよりもデスクトップデバイスに送信するJavaScriptの数がわずかに多くなっています。

### 処理時間

解析とコンパイルが行われた後、ブラウザによって取得されたJavaScriptは、利用する前に処理（または実行）される必要があります。デバイスは様々であり、その計算能力はページ上でのJavaScriptの処理速度に大きく影響します。ウェブ上での現在の処理時間は？

V8のメインスレッドの処理時間を異なるパーセンタイルで分析すると、アイデアを得ることができます。

{{ figure_markup(
  image="fig3.png",
  caption="デバイス別のV8メインスレッド処理時間。",
  description="処理時間をデスクトップとモバイルでそれぞれ10パーセンタイルで141ms/377ms、25パーセンタイルで352/988ms、50パーセンタイルで849/2,437ms、75パーセンタイルで1,850/5,518ms、90パーセンタイルで3,543/10,735msとした棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=924000517&format=interactive"
  )
}}

すべてのパーセンタイルにおいて、処理時間はデスクトップよりもモバイルの方が長くなっています。メインスレッドの合計時間の中央値はデスクトップでは849msであるのに対し、モバイルでは2,437msと大きくなっています。

このデータはモバイルデバイスがJavaScriptを処理するのにかかる時間が、より強力なデスクトップマシンに比べてどれだけ長いかを示していますが、モバイルデバイスは計算能力の点でも違いがあります。次の表は、1つのWebページの処理時間がモバイルデバイスのクラスによって大きく異なることを示しています。

{{ figure_markup(
  image="js-processing-reddit.png",
  caption='reddit.comのJavaScript処理時間。<a hreflang="en" href="https://v8.dev/blog/cost-of-javascript-2019">2019年のJavaScriptのコスト</a>より。',
  description="3つの異なるデバイスを示す棒グラフ: 上部のPixel3は、メインスレッドとワーカースレッドの両方で400ms未満と量が少ないです。Moto G4の場合、メインスレッドで約900ms、ワーカースレッドでさらに300msです。そして最後のバーはAlcatel 1X 5059Dで、メインスレッドで2,000ms以上、ワーカースレッドで500ms以上となっています。",
  width=600,
  height=363
  )
}}

### リクエスト数

Webページで使用されているJavaScriptの量を分析しようとする場合、1つの方法として、送信されたリクエスト数を調べる価値があります。[HTTP/2](./http)では、複数の小さなチャンクを送信することで、より大きなモノリシックなバンドルを送信するよりもページの負荷を改善できます。また、デバイスクライアント別に分解してみると、どのくらいのリクエストがフェッチされているのでしょうか。

{{ figure_markup(
  image="fig5.png",
  caption="総JavaScriptリクエスト数の分布。",
  description="10パーセンタイルではデスクトップとモバイルそれぞれ4/4のリクエストを示す棒グラフ、25パーセンタイルでは10/9、50パーセンタイルでは19/18、75パーセンタイルでは33/32、90パーセンタイルでは53/52が使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1632335480&format=interactive"
  )
}}

中央値では、デスクトップ用に19件、モバイル用に18件のリクエストが送信されています。

### ファーストパーティ対サードパーティ

これまでに分析した結果のうち、全体のサイズとリクエスト数が考慮されていました。しかし、大多数のウェブサイトでは、取得して使用しているJavaScriptコードのかなりの部分が[サードパーティ](./third-parties)のソースから来ています。

サードパーティのJavaScriptは、外部のサードパーティのソースから取得できます。広告、分析、ソーシャルメディアの埋め込みなどは、サードパーティのスクリプトを取得するための一般的なユースケースです。そこで当然のことながら、次の質問に移ります。

{{ figure_markup(
  image="fig6.png",
  caption="デスクトップ上のファーストスクリプトとサードパーティスクリプトの分布。",
  description="デスクトップ上で10パーセンタイルでは0/1リクエストがファーストパーティとサードパーティであることを示す棒グラフが表示されています、25パーセンタイルでは2/4、50パーセンタイルでは6/10、75パーセンタイルでは13/21、90パーセンタイルでは24/38となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1108490&format=interactive"
  )
}}

{{ figure_markup(
  image="fig7.png",
  caption="モバイル上のファーストパーティとサードパーティのスクリプトの分布。",
  description="モバイルで10パーセンタイルでは0/1リクエストがファーストパーティとサードパーティであることを示す棒グラフが表示されています、25パーセンタイルでは2/3、50パーセンタイルでは5/9、75パーセンタイルでは13/20、90パーセンタイルでは23/36となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=998640509&format=interactive"
  )
}}

モバイルクライアントとデスクトップクライアントの両方において、すべてのパーセンタイルにおいて、ファーストパーティよりもサードパーティのリクエストの方が多く送信されています。これが意外に思える場合は、実際に提供されるコードのうち、サードパーティのベンダーからのものがどれくらいあるのかを調べてみましょう。

{{ figure_markup(
  image="fig8.png",
  caption="デスクトップ上でダウンロードされたJavaScriptの総ダウンロード数の分布。",
  description="10パーセンタイルでは、ファーストパーティとサードパーティのリクエストに対してデスクトップ上で0/17バイトのJavaScriptがダウンロードされていることを示す棒グラフ、25パーセンタイルでは11/62、50パーセンタイルでは89/232、75パーセンタイルでは200/525、90パーセンタイルでは404/900である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=633945705&format=interactive"
  )
}}

{{ figure_markup(
  image="fig9.png",
  caption="モバイルでダウンロードされたJavaScriptの総ダウンロード数の分布。",
  description="棒グラフは、10パーセンタイルではファーストパーティとサードパーティのリクエストでそれぞれ0/17バイトの JavaScriptがモバイルでダウンロードされていることを示していますが、25パーセンタイルでは6/54、50パーセンタイルでは83/217、75パーセンタイルでは189/477、90パーセンタイルでは380/827です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1611383649&format=interactive"
  )
}}

中央値では、モバイルとデスクトップの両方で、開発者が作成したファーストパーティのコードよりもサードパーティのコードの方が89％多く使用されています。これは、サードパーティのコードが肥大化の最大の要因の1つであることを明確に示しています。サードパーティの影響についての詳細は、["サードパーティ"](./third-parties)の章を参照してください。

## リソース圧縮

ブラウザとサーバの会話のコンテキストで、リソース圧縮とは、データ圧縮アルゴリズムを使用して変更されたコードを指します。リソースは事前に静的に圧縮することも、ブラウザからの要求に応じて急ぎ圧縮することもでき、どちらの方法でも転送されるリソースサイズが大幅に削減されページパフォーマンスが向上します。

テキスト圧縮アルゴリズムは複数ありますが、HTTPネットワークリクエストの圧縮（および解凍）に使われることが多いのはこの2つだけです。

- <a hreflang="en" href="https://www.gzip.org/">Gzip</a> (`gzip`): サーバーとクライアントの相互作用のために最も広く使われている圧縮フォーマット。
- <a hreflang="en" href="https://github.com/google/brotli">Brotli</a> (`br`): 圧縮率のさらなる向上を目指した新しい圧縮アルゴリズム。<a hreflang="en" href="https://caniuse.com/#feat=brotli">90%のブラウザ</a>がBrotliエンコーディングをサポートしています。

圧縮されたスクリプトは、一度転送されるとブラウザによって常に解凍される必要があります。これは、コンテンツの内容が変わらないことを意味し、実行時間が最適化されないことを意味します。しかし、リソース圧縮は常にダウンロード時間を改善しますが、これはJavaScriptの処理で最もコストのかかる段階の1つでもあります。JavaScriptファイルが正しく圧縮されていることを確認することは、サイトのパフォーマンスを向上させるための最も重要な要因の1つとなります。

JavaScriptのリソースを圧縮しているサイトはどれくらいあるのでしょうか？

{{ figure_markup(
  image="fig10.png",
  caption="JavaScript リソースをGzipまたはBrotliで圧縮しているサイトの割合。",
  description="バーチャートを見ると、デスクトップとモバイルでそれぞれJavaScriptリソースの67%/65%がGzipで圧縮されており、15%/14%がBrotliで圧縮されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=241928028&format=interactive"
  )
}}

大多数のサイトではJavaScriptのリソースを圧縮しています。Gzipエンコーディングはサイトの〜64-67％で、Brotliは〜14％で使用されています。圧縮率はデスクトップとモバイルの両方でほぼ同じです。

圧縮に関するより深い分析については、["圧縮"](./compression)の章を参照してください。

## オープンソースのライブラリとフレームワーク

オープンソースコード、または誰でもアクセス、閲覧、修正が可能な寛容なライセンスを持つコード。小さなライブラリから、<a hreflang="en" href="https://www.chromium.org/Home">Chromium</a>や<a hreflang="en" href="https://www.openhub.net/p/firefox">Firefox</a>のようなブラウザ全体に至るまで、オープンソースコードはウェブ開発の世界で重要な役割を果たしています。JavaScriptの文脈では、開発者はオープンソースのツールに依存して、あらゆるタイプの機能をWebページに組み込んでいます。開発者が小さなユーティリティライブラリを使用するか、アプリケーション全体のアーキテクチャを決定する大規模なフレームワークを使用するかにかかわらずオープンソースのパッケージに依存することで、機能開発をより簡単かつ迅速にできます。では、どのJavaScriptオープンソースライブラリが最もよく使われているのでしょうか？

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
          <td class="numeric">85.03%</td>
          <td class="numeric">83.46%</td>
        </tr>
        <tr>
          <td>jQuery Migrate</td>
          <td class="numeric">31.26%</td>
          <td class="numeric">31.68%</td>
        </tr>
        <tr>
          <td>jQuery UI</td>
          <td class="numeric">23.60%</td>
          <td class="numeric">21.75%</td>
        </tr>
        <tr>
          <td>Modernizr</td>
          <td class="numeric">17.80%</td>
          <td class="numeric">16.76%</td>
        </tr>
        <tr>
          <td>FancyBox</td>
          <td class="numeric">7.04%</td>
          <td class="numeric">6.61%</td>
        </tr>
        <tr>
          <td>Lightbox</td>
          <td class="numeric">6.02%</td>
          <td class="numeric">5.93%</td>
        </tr>
        <tr>
          <td>Slick</td>
          <td class="numeric">5.53%</td>
          <td class="numeric">5.24%</td>
        </tr>
        <tr>
          <td>Moment.js</td>
          <td class="numeric">4.92%</td>
          <td class="numeric">4.29%</td>
        </tr>
        <tr>
          <td>Underscore.js</td>
          <td class="numeric">4.20%</td>
          <td class="numeric">3.82%</td>
        </tr>
        <tr>
          <td>prettyPhoto</td>
          <td class="numeric">2.89%</td>
          <td class="numeric">3.09%</td>
        </tr>
        <tr>
          <td>Select2</td>
          <td class="numeric">2.78%</td>
          <td class="numeric">2.48%</td>
        </tr>
        <tr>
          <td>Lodash</td>
          <td class="numeric">2.65%</td>
          <td class="numeric">2.68%</td>
        </tr>
        <tr>
          <td>Hammer.js</td>
          <td class="numeric">2.28%</td>
          <td class="numeric">2.70%</td>
        </tr>
        <tr>
          <td>YUI</td>
          <td class="numeric">1.84%</td>
          <td class="numeric">1.50%</td>
        </tr>
        <tr>
          <td>Lazy.js</td>
          <td class="numeric">1.26%</td>
          <td class="numeric">1.56%</td>
        </tr>
        <tr>
          <td>Fingerprintjs</td>
          <td class="numeric">1.21%</td>
          <td class="numeric">1.32%</td>
        </tr>
        <tr>
          <td>script.aculo.us</td>
          <td class="numeric">0.98%</td>
          <td class="numeric">0.85%</td>
        </tr>
        <tr>
          <td>Polyfill</td>
          <td class="numeric">0.97%</td>
          <td class="numeric">1.00%</td>
        </tr>
        <tr>
          <td>Flickity</td>
          <td class="numeric">0.83%</td>
          <td class="numeric">0.92%</td>
        </tr>
        <tr>
          <td>Zepto</td>
          <td class="numeric">0.78%</td>
          <td class="numeric">1.17%</td>
        </tr>
        <tr>
          <td>Dojo</td>
          <td class="numeric">0.70%</td>
          <td class="numeric">0.62%</td>
        </tr>
      </tbody>
    </table>
   <figcaption>{{ figure_link(caption="デスクトップとモバイルでのトップ JavaScript ライブラリ") }}</figcaption>
</figure>

これまでに作成された中で最も人気のあるJavaScriptライブラリである<a hreflang="en" href="https://jquery.com/">jQuery</a>は、デスクトップページの85.03％、モバイルページの83.46％で使用されています。[Fetch](https://developer.mozilla.org/ja/docs/Web/API/Fetch_API)や[querySelector](https://developer.mozilla.org/ja/docs/Web/API/Document/querySelector)など、多くのブラウザAPIやメソッドの出現により、ライブラリが提供する機能の多くがネイティブ形式に標準化されました。jQueryの人気は衰退しているように見えるかもしれませんが、なぜ今でもウェブの大部分で使われているのでしょうか？

理由はいくつか考えられます。

- <a hreflang="en" href="https://wordpress.org/">WordPress</a>は、30％以上のサイトで使用されているため、デフォルトでjQueryが含まれています。
- アプリケーションの規模によってはjQueryから新しいクライアントサイドライブラリへの切り替えに時間を要する場合があり、多くのサイトでは新しいクライアントサイドライブラリに加えてjQueryで構成されている場合があります。

他にもjQueryの亜種（jQuery migrate、jQuery UI）、<a hreflang="en" href="https://modernizr.com/">Modernizr</a>、<a hreflang="en" href="https://momentjs.com/">Moment.js</a>、<a hreflang="en" href="https://underscorejs.org/">Underscore.js</a>などがトップで使用されているJavaScriptライブラリです。

### フレームワークとUIライブラリ

<p class="note"><a href="./methodology#wappalyzer">方法論</a>で述べたように、HTTP Archive(Wappalyzer)で使用されているサードパーティ製の検出ライブラリには、特定のツールを検出する方法に関して多くの制限があります。<a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">JavaScriptライブラリやフレームワークの検出を改善するための未解決の問題があります</a>、それがここで紹介した結果に影響を与えています。

過去数年の間に、JavaScriptのエコシステムでは、**シングルページアプリケーション** (SPA) の構築を容易にするオープンソースのライブラリやフレームワークが増えてきました。シングルページアプリケーションとは、単一のHTMLページを読み込み、サーバーから新しいページを取得する代わりにJavaScriptを使用してユーザーの対話に応じてページを修正するWebページのことを指します。これはシングルページアプリケーションの大前提であることに変わりはありませんが、このようなサイトの体験を向上させるために、異なるサーバーレンダリングアプローチを使用できます。これらのタイプのフレームワークを使用しているサイトはどれくらいあるのでしょうか？

{{ figure_markup(
  image="fig12.png",
  caption="デスクトップで最もよく使われるフレームワーク",
  description="Reactを使用しているサイトは4.6％、AngularJSを使用しているサイトは2.0％、Backbone.jsを使用しているサイトは1.8％、Vue.jsを使用しているサイトは0.8％、Knockout.jsを使用しているサイトは0.4％、Zone.jsを使用しているサイトは0.3％、Angularを使用しているサイトは0.3％、AMPを使用しているサイトは0.1％、Ember.jsを使用しているサイトは0.1％という棒グラフになっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1699359221&format=interactive"
  )
}}

ここでは人気のあるフレームワークのサブセットのみを分析していますが、これらのフレームワークはすべて、これら2つのアプローチのいずれかに従っていることに注意することが重要です。

- <a hreflang="en" href="https://developer.chrome.com/apps/app_frameworks">モデルビューコントローラ</a>（またはモデルビュービューモデル）アーキテクチャー
- コンポーネントベースアーキテクチャ

コンポーネントベースモデルへの移行が進んでいるとはいえ、MVCパラダイムを踏襲した古いフレームワーク（<a hreflang="en" href="https://angularjs.org/">AngularJS</a>、<a hreflang="en" href="https://backbonejs.org/">Backbone.js</a>、<a hreflang="en" href="https://emberjs.com/">Ember</a>）は、いまだに何千ページにもわたって使われています。しかし、<a hreflang="en" href="https://reactjs.org/">React</a>、<a hreflang="en" href="https://vuejs.org/">Vue</a>、<a hreflang="en" href="https://angular.io/">Angular</a>はコンポーネントベースのフレームワークが主流です（<a hreflang="en" href="https://github.com/angular/zone.js">Zone.js</a>は現在Angular coreの一部となっているパッケージです）。

## 差分ロード

<a hreflang="en" href="https://v8.dev/features/modules">JavaScriptモジュール</a>、またはESモジュールは、<a hreflang="en" href="https://caniuse.com/#feat=es6-module">すべての主要ブラウザ</a>でサポートされています。モジュールは、他のモジュールからインポートおよびエクスポートできるスクリプトを作成する機能を提供します。これにより、サードパーティのモジュールローダーに頼ることなく、必要に応じてインポートとエクスポートを行い、モジュールパターンで構築されたアプリケーションを誰でも構築できます。

スクリプトをモジュールとして宣言するには、スクリプトタグが`type="module"`属性を取得しなければなりません。

```html
<script type="module" src="main.mjs"></script>
```

ページ上のスクリプトに`type="module'`を使用しているサイトはどれくらいあるでしょうか？

{{ figure_markup(
  image="fig13.png",
  caption="type=moduleを利用しているサイトの割合。",
  description="デスクトップでは0.6%のサイトが「type=module」を使用しており、モバイルでは0.8%のサイトが使用していることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1409239029&format=interactive"
  )
}}

ブラウザレベルでのモジュールのサポートはまだ比較的新しく、ここでの数字は、現在スクリプトに`type="module"`を使用しているサイトが非常に少ないことを示しています。多くのサイトでは、コードベース内でモジュールを定義するためにモジュールローダー（全デスクトップサイトの2.37％が<a hreflang="en" href="https://github.com/requirejs/requirejs">RequireJS</a>を使用しています）やバンドラー（<a hreflang="en" href="https://webpack.js.org/">webpack</a>を使用しています）にまだ依存しています。

ネイティブモジュールを使用する場合は、モジュールをサポートしていないブラウザに対して適切なフォールバックスクリプトを使用することが重要です。これは、`nomodule`属性を持つ追加スクリプトを含めることで実現できます。

```html
<script nomodule src="fallback.js"></script>
```

併用すると、モジュールをサポートしているブラウザは`nomodule`属性を含むスクリプトを完全に無視します。一方、モジュールをサポートしていないブラウザは ¥`type="module"`属性を持つスクリプトをダウンロードしません。ブラウザは`nomodule`も認識しないので、`type="module"`属性を持つスクリプトを普通にダウンロードします。このアプローチを使うことで、開発者は<a hreflang="en" href="https://web.dev/serve-modern-code-to-modern-browsers/">最新のコードを最新のブラウザに送信してページ読み込みを高速化する</a>できます。では、ページ上のスクリプトに`nomodule`を使っているサイトはどれくらいあるのだろうか。

{{ figure_markup(
  image="fig14.png",
  caption="nomoduleを使用しているサイトの割合。",
  description="デスクトップでは0.8％のサイトが「nomobule」を利用しており、モバイルでは0.5％のサイトが利用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=781034243&format=interactive"
  )
}}

同様に、スクリプトに`nomodule`属性を使用しているサイトはほとんどありません（0.50％-0.80％）。

## プリロードとプリフェッチ

[プリロード](https://developer.mozilla.org/ja/docs/Web/HTML/Preloading_content) と [プリフェッチ](https://developer.mozilla.org/ja/docs/Web/HTTP/Link_prefetching_FAQ)は[リソースヒント](./resource-hints)であり、どのリソースをダウンロードする必要があるかを判断する際にブラウザを助けることができます。

- `<link rel="preload">`でリソースをプリロードすると、ブラウザはこのリソースをできるだけ早くダウンロードするように指示します。これは、ページの読み込みプロセスの後半に発見され、最後にダウンロードされてしまう重要なリソース（例えば、HTMLの下部にあるJavaScriptなど）に特に役立ちます。
- `<link rel="prefetch">`を使用することで、ブラウザが将来のナビゲーションに必要なリソースを取得するためのアイドル時間を利用できるようにします。

では、プリロードやプリフェッチディレクティブを使っているサイトはどれくらいあるのでしょうか？

{{ figure_markup(
  image="fig15.png",
  caption="スクリプトにrel=preloadを使用しているサイトの割合。",
  description="バーチャートを見ると、デスクトップでは14%のサイトがスクリプトに'rel=preload'を使用しており、モバイルでは15%のサイトがスクリプトにrel=preloadを使用していることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=2007534370&format=interactive"
  )
}}

HTTP Archiveで測定したすべてのサイトで、デスクトップサイトの14.33％、モバイルサイトの14.84％が`<link rel="preload">`をページ上のスクリプトに使用しています。

プリフェッチについて以下のようなものがあります。

{{ figure_markup(
  image="fig16.png",
  caption="スクリプトにrel=prefetchを使用しているサイトの割合。",
  description="デスクトップでは0.08%のサイトが「rel=prefetch」を使用しており、モバイルでは0.08%のサイトが使用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=547807937&format=interactive"
  )
}}

モバイルとデスクトップの両方で、0.08％のページがスクリプトのいずれかでプリフェッチを利用しています。

## 新しいAPI

JavaScriptは言語として進化を続けています。ECMAScriptと呼ばれる言語標準そのものの新バージョンが毎年リリースされ、新しいAPIや機能が提案段階を通過して言語そのものの一部となっています。

HTTP Archiveを使用すると、サポートされている（あるいはこれからサポートされる）新しいAPIを調べて、その使用法がどの程度普及しているかを知ることができます。これらのAPIは、サポートしているブラウザで既に使用されているかもしれませんし、すべてのユーザに対応しているかどうかを確認するためにポリフィルを添付しています。

以下のAPIを使用しているサイトはどれくらいありますか？

- [Atomics](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Atomics)
- [Intl](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Intl)
- [Proxy](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- [SharedArrayBuffer](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)
- [WeakMap](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- [WeakSet](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)

{{ figure_markup(
  image="fig17.png",
  caption="新しいJavaScript APIの利用法",
  description="バーチャートを見ると、デスクトップとモバイルのサイトの25.5%/36.2%がWeakMap、6.1%/17.2%がWeakSet、3.9%/14.0%がIntl、3.9%/4.4%がProxy、0.4%/0.4%がAtomics、0.2%/0.2%がSharedArrayBufferを使用していることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=594315296&format=interactive"
  )
}}

Atomics(0.38％)とSharedArrayBuffer(0.20％)は、使用されているページが少ないので、このチャートではほとんど見えません。

ここでの数値は概算であり、機能の使用状況を測定するための<a hreflang="en" href="https://chromium.googlesource.com/chromium/src.git/+/master/docs/use_counter_wiki.md">UseCounter</a> を活用していないことに注意してください。

## ソースマップ

多くのビルドシステムでは、JavaScriptファイルはサイズを最小化し、多くのブラウザではまだサポートされていない新しい言語機能のためにトランスパイルされるようにミニ化されています。さらに、<a hreflang="en" href="https://www.typescriptlang.org/">TypeScript</a>のような言語スーパーセットは、元のソースコードとは明らかに異なる出力へコンパイルされます。これらの理由から、ブラウザに提供される最終的なコードは読めず、解読が困難なものになることがあります。

**ソースマップ**とは、JavaScriptファイルに付随する追加ファイルで、ブラウザが最終的な出力を元のソースにマップできます。これにより、プロダクションバンドルのデバッグや分析をより簡単にできます。

便利ではありますが多くのサイトが最終的な制作サイトにソースマップを入れたくない理由は、完全なソースコードを公開しないことを選択するなど、いくつかあります。では、実際にどれくらいのサイトがソースマップを含んでいるのでしょうか？

{{ figure_markup(
  image="fig18.png",
  caption="ソースマップを使用しているサイトの割合。",
  description="デスクトップサイトの18％、モバイルサイトの17％がソースマップを使用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=906754154&format=interactive"
  )
}}

デスクトップページでもモバイルページでも、結果はほぼ同じです。17～18％は、ページ上に少なくとも1つのスクリプトのソースマップを含んでいます（`sourceMappingURL`を持つファーストパーティスクリプトとして検出されます）。

## 結論

JavaScriptのエコシステムは毎年変化し続け、進化し続けています。新しいAPI、改良されたブラウザエンジン、新しいライブラリやフレームワークなど、私たちが期待していることは尽きることがありません。HTTP Archiveは、実際のサイトがどのようにJavaScriptを使用しているかについての貴重な洞察を提供してくれます。

JavaScriptがなければ、ウェブは現在の場所にはなく、この記事のために集められたすべてのデータがそれを証明しているに過ぎません。
