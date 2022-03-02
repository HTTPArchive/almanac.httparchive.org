---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: マークアップ
description: 2020年版Web Almanacのマークアップの章では、一般的な見解、要素や属性の使い方、トリビアやトレンドなどを紹介しています。
authors: [j9t, catalinred, iandevlin]
j9t_bio: Jens Oliver Meiert はウェブ開発者であり、著者(<a hreflang="en" href="https://leanpub.com/css-optimization-basics"><cite>CSS Optimization Basics</cite></a>, <a hreflang="en" href="https://leanpub.com/web-development-glossary"><cite>The Web Development Glossary</cite></a>)で、<a hreflang="en" href="https://www.jimdo.com/">Jimdo</a>でエンジニアリングマネージャーを務めています。彼は、HTMLとCSSの最適化を専門とするウェブ開発のエキスパートです。Jensは技術標準に貢献し、特に自身のウェブサイト<a hreflang="en" href="https://meiert.com/en/">meiert.com</a>では、仕事や研究について定期的に執筆しています。
catalinred_bio: Catalin Rosuは、<a hreflang="en" href="https://www.caphyon.com/">Caphyon</a>のフロントエンド開発者で、現在は<a hreflang="en" href="https://www.wattspeed.com/">Wattspeed</a>に携わっています。ウェブ標準への情熱と、優れたUXとUIへの鋭い目を持ち、<a href="https://twitter.com/catalinred">ツイート</a>したり、<a hreflang="en" href="https://catalin.red/">自身のウェブサイト</a>で執筆したりしています。
iandevlin_bio: Ian Devlinは、優れたセマンティックHTMLやアクセシビリティを提唱するウェブ開発者です。<a hreflang="en" href="https://www.peachpit.com/store/html5-multimedia-develop-and-design-9780321793935">HTML5 マルチメディア</a>についての本を書いたこともありますし、<a hreflang="en" href="https://iandevlin.com/">自身のウェブサイト</a>でウェブやその他のことについて散発的に書いています。現在は、ドイツの<a hreflang="de" href="https://www.real-digital.de/">real.digital</a>でシニアフロントエンドエンジニアとして働いています。
reviewers: [zcorpan, matuzo, bkardell]
analysts: [Tiggerito]
editors: [rviscomi]
translators: [ksakae1216]
discuss: 2039
results: https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/
featured_quote: 私たちは、生きたHTMLをほぼ完全に採用しようとしており、流行のページはすぐに削除し、フレームワークの採用や廃止も迅速に行っています。しかし、HTMLが与えてくれる選択肢を使い切った形跡はありません。
featured_stat_1: 85.73%
featured_stat_label_1: "生きた" HTML doctypeを使用しているページの割合
featured_stat_2: 30,073
featured_stat_label_2: 標準外の`h7`要素の数
featured_stat_3: 25.24 KB
featured_stat_label_3: 中央値の文書の重み
---

## 序章

ウェブはHTMLで構築されています。HTMLがなければウェブページも、ウェブサイトも、ウェブアプリケーションもありません。何もないのです。平文のドキュメントやXMLツリーは、このような特別な挑戦を楽しんでいる平行世界にあるかもしれません。この世界では、HTMLがユーザーフレンドリーなウェブの基礎となっています。ウェブの基盤となっている標準は数多くありますが、HTMLはもっとも重要な標準のひとつであることは間違いありません。

HTMLをどのように使うのかでは、どれだけ素晴らしい基盤があるのか。[2019年版マークアップの章](../2019/markup#introduction)の序章で、著者の[Brian Kardell](../2019/contributors#bkardell)は、長い間本当は分かっていなかったことを示唆しています。小さなサンプルはいくつかありました。たとえば<a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">Ian Hicksonの研究</a>（モダンHTMLの親玉の1つ）などがありましたが、昨年まで開発者である私たち、著者である私たちが、HTMLをどのように利用しているのかについて主要な洞察を欠いていました。2019年には、<a hreflang="en" href="https://www.advancedwebranking.com/html/">Catalin Rosuの研究</a>（本章の共著者の1人）と2019年版Web Almanacの両方があり、実際のHTMLについて再び良い見解を得ることができました。

昨年は580万ページを分析し、そのうち440万ページをデスクトップで、530万ページをモバイルでテストしました。今年は2020年にユーザーが訪れるWebサイトに関する[最新データ](./methodology#websites)を用いて750万ページを分析し、そのうち560万ページをデスクトップで、630万ページをモバイルでテストしました。昨年との比較も行っていますが、新たな洞察のために追加の指標を分析したのと同様に、私たち自身の個性や視点を章全体に付与しました。

<p class="note">
  このマークアップの章では、同じマークアップ言語であるSVGやMathMLではなく、ほぼHTMLのみを取り上げています。特に断りのない限り、この章で紹介する統計は、モバイルページのセットを指します。また、Web Almanacの全章のデータは公開されており、利用可能です。<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/">結果</a>を見て、<a hreflang="en" href="https://discuss.httparchive.org/t/2039">あなたの意見</a>をコミュニティに伝えてください！
</p>

## 全般

このセクションではドキュメントタイプやドキュメントのサイズ、さらにはコメントやスクリプトの使用など、HTMLのより高度な側面を取り上げています。"生きたHTML "は、まさに生きているのです

### Doctypes

{{ figure_markup(
  caption="doctypeを持つページの割合。",
  content="96.82%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

96.82%のページが[_doctype_](https://developer.mozilla.org/ja/docs/Glossary/Doctype)を宣言しています。HTML文書がdoctypeを宣言することは、<a hreflang="en" href="https://lists.w3.org/Archives/Public/public-html-comments/2009Jul/0020.html">Ian Hickson氏が2009年に説明したように</a>、「ブラウザのquirksモードのトリガーを避けるため」という歴史的な理由から有用です。もっとも人気のある値は何ですか？

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th>ページ</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTML ("HTML5")</td>
        <td class="numeric">5,441,815</td>
        <td class="numeric">85.73%</td>
      </tr>
      <tr>
        <td>XHTML 1.0 Transitional</td>
        <td class="numeric">382,322</td>
        <td class="numeric">6.02%</td>
      </tr>
      <tr>
        <td>XHTML 1.0 Strict</td>
        <td class="numeric">107,351</td>
        <td class="numeric">1.69%</td>
      </tr>
      <tr>
        <td>HTML 4.01 Transitional</td>
        <td class="numeric">54,379</td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td>HTML 4.01 Transitional (<a hreflang="en" href="https://hsivonen.fi/doctype/#xml">quirky</a>)</td>
        <td class="numeric">38,504</td>
        <td class="numeric">0.61%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっとも人気のある5つのdoctypes。", sheets_gid="1981441894", sql_file="summary_pages_by_device_and_doctype.sql") }}</figcaption>
</figure>

XHTML1.0以降、数がかなり減り、いくつかの標準的なもの、いくつかの難解なもの、さらにはインチキなdoctypeを含むロングテールに入ることはすでにおわかりでしょう。

この結果から、2つの点が注目されます。

1. <a hreflang="en" href="https://blog.whatwg.org/html-is-the-new-html5">生きた HTML</a>（通称「HTML5」）の発表から約10年、生きた HTMLは明らかに当たり前のものになりました。
2. 生きたHTML以前のウェブは、XHTML1.0のような、次によく使われるdoctypにまだ見られます。XHTMLです。それらのドキュメントは、おそらくMIMEタイプが`text/html`のHTMLとして配信されていますが、これらの古いdoctypesはまだ死んでいません。

### ドキュメントサイズ

ページのドキュメントサイズとは、ネットワーク上で転送されたHTMLのバイト数のことで、圧縮が有効な場合はそれも含めて計算されます。630万のドキュメントのセットの両極端では

* 1,110個のドキュメントは空です（0バイト）。
* ドキュメントの平均サイズは49.17KBです（<a hreflang="en" href="https://w3techs.com/technologies/details/ce-gzipcompression">ほとんどの場合、圧縮されています</a>）。
* 最大のドキュメントは61.19 _MB_ で、Web Almanacの中でも独自の分析と章立てが必要なほどです。

では、この状況は一般的にどうなのでしょうか？　ドキュメントの中央値は24.65KBで、これは<a hreflang="en" href="https://httparchive.org/reports/page-weight">驚き</a>がない状態です。

{{ figure_markup(
  image="document-size.png",
  caption="ネットワーク上で転送されたHTMLのバイト数（有効な場合は圧縮を含む）。",
  description="ドキュメントのサイズ（バイト）はパーセンタイルで、デスクトップでは中央値が25.99KB。",
  sheets_gid="2066175354",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=386686971&format=interactive",
  sql_file="summary_pages_by_device_and_percentile.sql"
  )
}}

### ドキュメント言語

`html`開始タグの`lang`属性に2,863の異なる値を確認しました（Ethnologueによる<a hreflang="en" href="https://www.ethnologue.com/guides/how-many-languages">7,117の話されている言語</a>と比較してみてください）。[アクセシビリティ](./accessibility#language-identification)の章によると、ほとんどすべての値が有効なようです。

全ドキュメントの22.36%が`lang`属性を指定していません。一般的には<a hreflang="en" href="https://www.w3.org/TR/i18n-html-tech-lang/#overall">そうすべきだ</a>という意見は多いです、ソフトウェアが最終的に<a hreflang="en" href="https://meiert.com/en/blog/lang/">言語を自動的に検出する</a>という事実を無視してドキュメントの言語は[プロトコルレベルで](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Content-Language)指定することもできますが、これは私たちがチェックしなかったことです。

ここでは、サンプルの中でもっとも人気のある（正規化された）10の言語を紹介します。HTTP Archiveは米国のデータセンターから英語の言語設定でクロールしているため、ページが書かれている言語を見ると、英語に偏っていることに注意してください。とはいえ、分析したサイトのコンテキストを示すために、`lang`属性を提示します。

{{ figure_markup(
  image="document-language.png",
  caption="HTMLの上位の`lang`属性です。",
  description="クロールで使用された`lang`属性のトップ10を示す棒グラフ、デスクトップページの22.82%、モバイルページの22.36%が属性を設定しておらず、`en`はそれぞれ20.09%、18.08%、`ja`は15.17%、13.27%で使用されています。 また、`es`は4.86％、4.09％、`pt-br`は2.65％、2.84％、`ru`は2.21％、2.53％、`en-gb`は2.35％、2.19％、`de`は1.50％、1.92％、最後に`fr`は1.55％、1.43％で使用されていました。",
  sheets_gid="2047285366",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1873310240&format=interactive",
  sql_file="pages_almanac_by_device_and_html_lang.sql"
  )
}}

### コメント

コードにコメントを付けることは一般的に良い習慣であり、HTMLコメントはユーザーエージェントによってレンダリングされることなく、HTML文書にメモを付けるためのものです。

```html
<!-- これは、HTMLのコメントです。 -->
```

多くのページでは制作のためにコメントが削除されているでしょうが90パーセンタイルのホームページでは、モバイルでは約73個、デスクトップでは約79個のコメントが使用されており、10パーセンタイルでは約2個のコメントが使用されていることがわかりました。 中央値のページでは、16個（モバイル）または17個（デスクトップ）のコメントが使用されています。

約89％のページには少なくとも1つのHTMLコメントが含まれており、約46％のページには条件付きのコメントが含まれています。

#### 条件付きコメント

```html
<!--[if IE 8]>
  <p>これは、Internet Explorer 8でのみ表示されます。</p>
<![endif]-->
```

上記は、非標準のHTML条件付きコメントです。過去にはブラウザの違いに取り組むためそれらが役立つことを証明されていましたが、MicrosoftがInternet Explorer 10で<a hreflang="en" href="https://docs.microsoft.com/ja-jp/previous-versions/windows/internet-explorer/ie-developer/compatibility/hh801214(v=vs.85)">dropped conditional comments</a>)を採用したことで、しばらくの間、歴史に名を残しました。

それでも上記のパーセンタイルの両極端では、90パーセンタイルで約6個、10パーセンタイルでは約1個の条件付きコメントを使用しているウェブページがあることをわかりました。 ほとんどのページでは、<a hreflang="en" href="https://github.com/aFarkas/html5shiv">html5shiv</a>、[selectivizr](http://selectivizr.com/)、<a hreflang="en" href="https://github.com/scottjehl/Respond">respond.js</a>などのヘルパーのために条件付きコメントを使用しています。これらのページはきちんとしていて、まだアクティブなページですが、私たちの結論はこれらの多くが時代遅れのCMSテーマを使用していたということです。

本番環境では、HTMLコメントは通常、ビルドツールによって取り除かれます。以上のカウントとパーセンテージ、そして一般的なコメントの使用状況を考慮すると、多くのページがHTMLミニファイアーを介さずに提供されていると考えられます。

### スクリプトの使用

以下の[上位の要素](#top-elements)のセクションで示すように、`script`要素は、6番目によく使われるHTML要素です。この章では、データセットの数百万ページの中で、`script`要素がどのように使われているかに興味を持ちました。

全体では、約2%のページにスクリプトがまったく含まれておらず、`type="application/ld+json"`属性を持つ構造化データスクリプトも含まれていません。最近では、1つのページに少なくとも1つの分析ソリューション用のスクリプトが含まれていることがかなり一般的になっていることを考えると、これは注目すべきことだと思います。

その反対に、約97％のページには、インラインまたは外部のスクリプトが少なくとも1つ含まれているという数字が出ています。

{{ figure_markup(
  image="script-use.png",
  caption="<code>script</code>要素の使い方。",
  description="スクリプトを含むページ（ではない）の割合で、スクリプトはほぼすべてのページにほぼすべての形で存在しています。",
  sheets_gid="150962402",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1895084382&format=interactive",
  sql_file="pages_almanac_by_device.sql"
  )
}}

ブラウザでスクリプトがサポートされていなかったり、オフになっている場合、`noscript`要素は、ページ内にHTMLセクションを追加するのに役立ちます。上記のスクリプト数を考えると、`noscript`要素についても気になりました。

分析の結果、約49％のページが`noscript`要素を使用していることがわかりました。同時に、約16%の`noscript`要素が、"googletagmanager.com "を参照する`src`値を持つ`iframe`を含んでいます。

これは、実際の`noscript`要素の総数が、ページの`body`開始タグの後に`noscript`スニペットを追加するようにユーザーに強制するGoogleタグマネージャーなどの一般的なスクリプトの影響を受ける可能性があるという理論を裏付けているようです。

#### スクリプトの種類

`script`要素で使用される`type`属性値は何ですか？

- `text/javascript`: 60.03%
- `application/ld+json`: 1.68%
- `application/json`: 0.41%
- `text/template`: 0.41%
- `text/html`: 0.27%

`type="module"`を使用して<a hreflang="en" href="https://jakearchibald.com/2017/es-modules-in-browsers/">JavaScriptモジュールスクリプト</a>を読み込む場合、現在、0.13%の`script`要素がこの属性と値の組み合わせを指定していることがわかりました。また、`nomodule`は、テストした全ページの0.95%で使用されています。(1つの指標は要素に関するもので、もう1つの指標はページに関するものであることに注意してください。)

全スクリプトの36.38%は、`type`の値がまったく設定されていません。

## 要素

このセクションでは、要素に焦点を当てています。どのような要素が使用されているのか、どのくらいの頻度で使用されているのか、どのような要素が特定のページに表示される可能性があるのか、カスタム要素、廃止された要素、独自の要素についてはどのような状況なのか、などです。<a hreflang="en" href="https://en.wiktionary.org/wiki/divitis"> _divitis_ </a>はまだありますか？　はい。

### 要素の多様性

では、実際にHTMLがどのように使われているのかを見てみましょう。作者はさまざまな要素を使っているのか、それとも比較的少ない要素しか使っていないのか。

ウェブページの中央値では、30種類の要素が587回使用されていることがわかります。

{{ figure_markup(
  image="element-diversity-element-types.png",
  caption="ページごとの要素タイプ数の分布。",
  description="要素の種類はパーセンタイルで、90％のページが20種類以上の要素を使用しています。",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=924238918&format=interactive",
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

{{ figure_markup(
  image="element-diversity.png",
  caption="1ページあたりの総要素数のパーセンタイルごとの分布。",
  description="1,665個以上の要素を採用しているページが全体の10%であることを示す。",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=680594018&format=interactive",
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/">生きたHTML</a>が現在112個の要素を持っていることを考えると、90パーセンタイルが41個以上の要素を使用していないということは、ほとんどの文書でHTMLがほとんど使い尽くされていないことを示唆しているかもしれません。しかしHTMLが提供する意味的な豊かさは、すべての文書がそのすべてを必要とすることを意味しないので、これがHTMLとその使用にとって実際に何を意味するかを解釈するのは難しいです。HTMLの要素は、利用可能かどうかではなく、目的（セマンティクス）に応じて使用されるべきです。

これらの要素はどのように配分されていますか？

{{ figure_markup(
  image="distribution-of-elements-per-page.png",
  caption="1ページあたりの総要素数の分布。",
  description="興味深いのは約7,500ページの大規模なグループで、それぞれが約250の要素を使用しており、その後はページ数が減りより多くの要素を使用するようになっていることです。",
  sheets_gid="1361520223",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1468756779&format=interactive",
  sql_file="pages_element_count_by_device_and_element_count.sql"
  )
}}

[2019年と比べて](../2019/markup#fig-3)そんなに変わっていない！

### トップ要素

2019年、Web AlmanacのMarkupの章では、<a hreflang="en" href="https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html">2005年のIan Hicksonの仕事</a>を参考に、もっとも頻繁に使用されている要素を紹介しました。私たちはこれを参考にして、もう一度そのデータを見てみました。

<figure>
  <table>
    <thead>
      <tr>
        <th>2005</th>
        <th>2019</th>
        <th>2020</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>title</code></td>
        <td><code>div</code></td>
        <td><code>div</code></td>
      </tr>
      <tr>
        <td><code>a</code></td>
        <td><code>a</code></td>
        <td><code>a</code></td>
      </tr>
      <tr>
        <td><code>img</code></td>
        <td><code>span</code></td>
        <td><code>span</code></td>
      </tr>
      <tr>
        <td><code>meta</code></td>
        <td><code>li</code></td>
        <td><code>li</code></td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td><code>img</code></td>
        <td><code>img</code></td>
      </tr>
      <tr>
        <td><code>table</code></td>
        <td><code>script</code></td>
        <td><code>script</code></td>
      </tr>
      <tr>
        <td><code>td</code></td>
        <td><code>p</code></td>
        <td><code>p</code></td>
      </tr>
      <tr>
        <td><code>tr</code></td>
        <td><code>option</code></td>
        <td><code>link</code></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td><code>i</code></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td><code>option</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="2005年、2019年、2020年のもっとも人気のある要素です。", sheets_gid="781932961", sql_file="pages_element_count_by_device_and_element_type_frequency.sql") }}</figcaption>
</figure>

トップ7には何の変化もありませんでしたが、`option`要素は少し人気がなくなり、8位から10位に下がり、`link`要素と`i`要素が人気を失ってしまいました。これらの要素が使用されるようになったのは、おそらく[resource hints](./resource-hints) の使用が増加したことや、<a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>のようなアイコンソリューションが使用されるようになったからでしょう。

#### `details`と`summary`

もうひとつ気になっていたのは、とくに2020年に<a hreflang="en" href="https://caniuse.com/details">`details`と`summary`要素</a>が導入されてから、その使用状況です。これらは使われていますか？　それらは著者にとって魅力的で、人気もあるのでしょうか？　結果的には、テストした全ページのうち0.39%しか使用されていませんでした。ただし必要な場面で、正しい方法で使用されているかどうかを判断するのは難しいので、「人気がある」という表現は間違っています。

ここでは、`details`要素の中で`summary`を使用する簡単な例を紹介します。

```html
<details>
  <summary>ステータス 動作確認済み</summary>
  <p>速さ：12m/s</p>
  <p>方向：北</p>
</details>
```

しばらく前に、Steve Faulkner氏が、この2つの要素がいかに不適切に使われているかを[指摘](https://twitter.com/stevefaulkner/status/806474286592561152)していました。上の例からわかるように、`details`要素ごとに、`details`の[最初の子](https://developer.mozilla.org/ja/docs/Web/HTML/Element/summary#usage_notes)としてのみ使用可能な`summary`要素が必要になります。

そこで、`details`要素と`summary`要素の数を調べてみたところ、引き続き誤用されていることがわかりました。また、`summary`要素の数は、モバイルとデスクトップの両方で多く、モバイルでは`details`要素1つに対して`summary`要素が1.11、デスクトップでは1.19となっています。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >発生状況</th>
      </tr>
      <tr>
        <th scope="col">要素</th>
        <th scope="col">モバイル(0.39%)</th>
        <th scope="col">デスクトップ(0.22%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>summary</code></td>
        <td class="numeric">62,992</td>
        <td class="numeric">43,936</td>
      </tr>
      <tr>
        <td><code>details</code></td>
        <td class="numeric">56,60</td>
        <td class="numeric">36,743</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="<code>details</code>と<code>summary</code>要素の採用。", sheets_gid="1406534257", sql_file="pages_element_count_by_device.sql") }}</figcaption>
</figure>

### 要素使用の確率

要素のポピュラリティについてもう一度見てみましょう。あるページのDOMで特定の要素が見つかる確率はどのくらいでしょうか？　確かに、`html`、`head`、`body`はすべてのHTMLページに存在し（<a hreflang="en" href="https://meiert.com/en/blog/optional-html/">これらのタグはすべてオプション</a>であるにもかかわらず）、一般的な要素となっていますが、他にどのような要素がよく見られるのでしょうか？

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>確率</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>title</code></td>
        <td class="numeric">99.34%</td>
      </tr>
      <tr>
        <td><code>meta</code></td>
        <td class="numeric">99.00%</td>
      </tr>
      <tr>
        <td><code>div</code></td>
        <td class="numeric">98.42%</td>
      </tr>
      <tr>
        <td><code>a</code></td>
        <td class="numeric">98.32%</td>
      </tr>
      <tr>
        <td><code>link</code></td>
        <td class="numeric">97.79%</td>
      </tr>
      <tr>
        <td><code>script</code></td>
        <td class="numeric">97.73%</td>
      </tr>
      <tr>
        <td><code>img</code></td>
        <td class="numeric">95.83%</td>
      </tr>
      <tr>
        <td><code>span</code></td>
        <td class="numeric">93.98%</td>
      </tr>
      <tr>
        <td><code>p</code></td>
        <td class="numeric">88.71%</td>
      </tr>
      <tr>
        <td><code>ul</code></td>
        <td class="numeric">87.68%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Web Almanac 2020のサンプルのページで、ある要素が見つかる確率が高いこと。", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

標準要素とは、HTMLの仕様に含まれている、あるいは含まれていた要素のことです。では、どの要素が珍しいのでしょうか？　私たちのサンプルでは、次のようなものがあります。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>確率</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>dir</code></td>
        <td class="numeric">0.0082%</td>
      </tr>
      <tr>
        <td><code>rp</code></td>
        <td class="numeric">0.0087%</td>
      </tr>
      <tr>
        <td><code>basefont</code></td>
        <td class="numeric">0.0092%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="サンプルのページから特定の要素が見つかる確率が低いこと。", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

私たちは、どのような要素が廃れてしまったのかを知るために、これらの要素を含めています。しかし、`dir`と`basefont`はXHTML1.0(2000)で最後に指定され、もはやHTMLの一部ではありませんが、`rp`の稀な使用（これは<a hreflang="en" href="https://www.w3.org/TR/1998/WD-ruby-19981221/#a2-4">1998年の早い段階で</a>、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element">still part of HTML</a>に言及されており）は、<a hreflang="en" href="https://www.w3.org/TR/ruby/">Rubyマークアップ</a>があまり普及していないことを示唆しているのかもしれない。

### カスタム要素

Web Almanac2019年版では、いくつかの非標準的な要素を取り上げて[カスタム要素](../2019/markup#custom-elements)を扱いました。今年は、カスタム要素を詳しく見てみることに価値があると考えました。どのようにしてこれらを決定したのでしょうか？　大まかには、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts">その定義</a>を見て、特にハイフンの使用を確認しています。ここでは、サンプル内の全URLの1%以上に使用されている要素に焦点を当ててみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>ページ</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>ym-measure</code></td>
        <td class="numeric">141,156</td>
        <td class="numeric">2.22%</td>
      </tr>
      <tr>
        <td><code>wix-image</code></td>
        <td class="numeric">76,969</td>
        <td class="numeric">1.21%</td>
      </tr>
      <tr>
        <td><code>rs-module-wrap</code></td>
        <td class="numeric">71,272</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-module</code></td>
        <td class="numeric">71,271</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-slide</code></td>
        <td class="numeric">70,970</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-slides</code></td>
        <td class="numeric">70,993</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-sbg-px</code></td>
        <td class="numeric">70,414</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-sbg-wrap</code></td>
        <td class="numeric">70,414</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-sbg</code></td>
        <td class="numeric">70,413</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-progress</code></td>
        <td class="numeric">70,651</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-mask-wrap</code></td>
        <td class="numeric">63,871</td>
        <td class="numeric">1.01%</td>
      </tr>
      <tr>
        <td><code>rs-loop-wrap</code></td>
        <td class="numeric">63,870</td>
        <td class="numeric">1.01%</td>
      </tr>
      <tr>
        <td><code>rs-layer-wrap</code></td>
        <td class="numeric">63,849</td>
        <td class="numeric">1.01%</td>
      </tr>
      <tr>
        <td><code>wix-iframe</code></td>
        <td class="numeric">63,590</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="人気の高い14種類のカスタム要素", sheets_gid="770933671", sql_file="pages_element_count_by_device_and_custom_dash_elements.sql") }}</figcaption>
</figure>

これらの要素は3つのソースから来ています。昨年も紹介した分析ソリューションの<a hreflang="en" href="https://metrica.yandex.com/about">Yandex Metrica</a>（`ym-`）、<a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a> (`rs-`)は、WordPressのスライダーで、サンプルのトップ付近にもっと多くの要素があります。そして、ウェブサイトビルダーの<a hreflang="en" href="https://www.wix.com/">Wix</a> (`wix-`)があります。

また、<a hreflang="en" href="https://amp.dev/">AMPマークアップ</a>の`amp-img`（11,700ページ）、`amp-analytics`（10,256ページ）、`amp-auto-ads`（7,621ページ）などの`amp-`要素を持つグループや、<a hreflang="en" href="https://angular.io/">Angular</a>の `app-` 要素である `app-root` (16,314)、`app-footer` (6,745)、`app-header` (5,274) なども含まれています。

### 廃止された要素

HTMLの使用については、廃止された要素（`applet`、`bgsound`、`blink`、`center`、`font`、`frame`、`isindex`、`marquee`、`spacer`などの要素）の使用を含め、さらに多くの疑問があります。

630万ページのモバイルデータセットでは、約90万ページ（14.01％）にこれらの要素が1つ以上含まれています。ここでは、10,000回以上使用された上位9つの要素を紹介します。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>ページ</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>center</code></td>
        <td class="numeric">458,402</td>
        <td class="numeric">7.22%</td>
      </tr>
      <tr>
        <td><code>font</code></td>
        <td class="numeric">430,987</td>
        <td class="numeric">6.79%</td>
      </tr>
      <tr>
        <td><code>marquee</code></td>
        <td class="numeric">67,781</td>
        <td class="numeric">1.07%</td>
      </tr>
      <tr>
        <td><code>nobr</code></td>
        <td class="numeric">31,138</td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td><code>big</code></td>
        <td class="numeric">27,578</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td><code>frame</code></td>
        <td class="numeric">19,363</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td><code>frameset</code></td>
        <td class="numeric">19,163</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td><code>strike</code></td>
        <td class="numeric">17,438</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td><code>noframes</code></td>
        <td class="numeric">15,016</td>
        <td class="numeric">0.24%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="10,000回以上使用されている廃止された要素。", sheets_gid="1972617631", sql_file="pages_element_count_by_device_and_obsolete_elements.sql") }}</figcaption>
</figure>

また、`spacer`でさえも1,584回使用されており、5,000ページごとに存在しています。Googleが<a hreflang="en" href="https://www.google.com/">自社のホームページ</a>で<a hreflang="en" href="https://web.archive.org/web/19981202230410/https://www.google.com/">22年前から</a>、`center`要素を使用していることは知っていますが、なぜこれほど多くの模倣者がいるのでしょうか。

#### `isindex`

気になっていたら: このデータセットに含まれる<a hreflang="en" href="https://www.w3.org/TR/html401/interact/forms.html#edef-ISINDEX">`isindex`</a>要素の総数は1です。ちょうど1つのページが`isindex`要素を使用していました。`isindex`は<a hreflang="en" href="https://meiert.com/en/indices/html-elements/">HTML4.01とXHTML1.0</a> までは仕様の一部でしたが、2006年になってようやく <a hreflang="en" href="https://lists.w3.org/Archives/Public/public-whatwg-archive/2006Feb/0111.html"> 仕様化</a>され（ブラウザでの実装方法に合わせて）、2016年には<a hreflang="en" href="https://github.com/whatwg/html/pull/1095">廃止</a>されました。

### 独自要素と作り込み要素

その中には標準的なHTML（SVG、MathML）要素でも、カスタム要素でも、廃止された要素でもない独自の要素も含まれていました。私たちが確認したトップ10は以下の通りです。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>noindex</code></td>
        <td class="numeric">0.89%</td>
      </tr>
      <tr>
        <td><code>jdiv</code></td>
        <td class="numeric">0.85%</td>
      </tr>
      <tr>
        <td><code>mediaelementwrapper</code></td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td><code>ymaps</code></td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>yatag</code></td>
        <td class="numeric">0.20%</td>
      </tr>
      <tr>
        <td><code>ss</code></td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>include</code></td>
        <td class="numeric">0.08%</td>
      </tr>
      <tr>
        <td><code>olark</code></td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>h7</code></td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>limespot</code></td>
        <td class="numeric">0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="質問可能な遺産の要素", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

これらの要素の出所は、不明なものもあれば追跡可能なものもあり、混在しているようです。もっともポピュラーなものである`noindex`は、<a hreflang="en" href="https://yandex.com/support/webmaster/adding-site/indexing-prohibition.html">Yandexがページのインデックス作成を禁止するために推奨している</a>ことに起因すると思われます。`jdiv`は[昨年の Web Almanac](../2019/markup#products-and-libraries-and-their-custom-markup)で指摘された、JivoChatのものです。`mediaelementwrapper`はMediaElementというメディアプレイヤーから来ています。`yymaps`と`yatag`もYandexのものです。また、`ss`要素は、eBayの元eコマース製品であるProStoresからのものである可能性があり、`olark`は、Olarkチャットソフトウェアからのものである可能性があります。`h7` は間違いのようです。`limespot`は、おそらくeコマース用のパーソナライゼーションプログラムであるLimespotに関連していると思われます。これらの要素はいずれもウェブ標準の一部ではありません。

### 見出し

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#heading-content">見出し</a>は、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#sectioning-content-2">sectioning</a>や<a hreflang="en" href="https://www.w3.org/WAI/tutorials/page-structure/headings/">accessibility</a>で重要な役割を果たす、特別なカテゴリーの要素です。

<figure>
  <table>
    <thead>
      <tr>
        <th>見出し</th>
        <th>発生状況</th>
        <th>1ページあたりの平均</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>h1</code></td>
        <td class="numeric">10,524,810</td>
        <td class="numeric">1.66</td>
      </tr>
      <tr>
        <td><code>h2</code></td>
        <td class="numeric">37,312,338</td>
        <td class="numeric">5.88</td>
      </tr>
      <tr>
        <td><code>h3</code></td>
        <td class="numeric">44,135,313</td>
        <td class="numeric">6.96</td>
      </tr>
      <tr>
        <td><code>h4</code></td>
        <td class="numeric">20,473,598</td>
        <td class="numeric">3.23</td>
      </tr>
      <tr>
        <td><code>h5</code></td>
        <td class="numeric">8,594,500</td>
        <td class="numeric">1.36</td>
      </tr>
      <tr>
        <td><code>h6</code></td>
        <td class="numeric">3,527,470</td>
        <td class="numeric">0.56</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="標準的な見出し要素の使用頻度と平均値", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

標準的な`<h1>`から`<h6>`までの要素しか見られないと思っていたかもしれませんが、実際にはもっと多くのレベルを使用しているサイトもあります。

<figure>
  <table>
    <thead>
      <tr>
        <th>見出し</th>
        <th>発生状況</th>
        <th>1ページあたりの平均</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>h7</code></td>
        <td class="numeric">30,073</td>
        <td class="numeric">0.005</td>
      </tr>
      <tr>
        <td><code>h8</code></td>
        <td class="numeric">9,266</td>
        <td class="numeric">0.0015</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="非標準的な見出し要素の使用頻度と平均値。", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

最後の2つは、もちろんHTMLの一部ではありませんので、使用しないでください。

## 属性

このセクションでは、ドキュメントで属性がどのように使用されているかに焦点を当て、`data-*`の使用パターンを探ります。その結果、`class`がすべての属性の女王であることがわかりました。

### トップの属性

[もっとも人気のある要素](#top-elements)のセクションと同様に、このセクションではウェブ上でもっとも人気のある属性について掘り下げます。`href`属性がウェブそのものにとってどれほど重要か、また`alt`属性が情報を[アクセシブル](./accessibility#images-and-their-text-alternatives)にするため、どれほど重要かを考えると、これらはもっとも人気のある属性でしょうか？

<figure>
  <table>
    <thead>
      <tr>
        <th>属性</th>
        <th>発生状況</th>
        <th>パーセンテージ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>class</code></td>
        <td class="numeric">2,998,695,114</td>
        <td class="numeric">34.23%</td>
      </tr>
      <tr>
        <td><code>href</code></td>
        <td class="numeric">928,704,735</td>
        <td class="numeric">10.60%</td>
      </tr>
      <tr>
        <td><code>style</code></td>
        <td class="numeric">523,148,251</td>
        <td class="numeric">5.97%</td>
      </tr>
      <tr>
        <td><code>id</code></td>
        <td class="numeric">452,110,137</td>
        <td class="numeric">5.16%</td>
      </tr>
      <tr>
        <td><code>src</code></td>
        <td class="numeric">341,604,471</td>
        <td class="numeric">3.90%</td>
      </tr>
      <tr>
        <td><code>type</code></td>
        <td class="numeric">282,298,754</td>
        <td class="numeric">3.22%</td>
      </tr>
      <tr>
        <td><code>title</code></td>
        <td class="numeric">231,960,356</td>
        <td class="numeric">2.65%</td>
      </tr>
      <tr>
        <td><code>alt</code></td>
        <td class="numeric">172,668,703</td>
        <td class="numeric">1.97%</td>
      </tr>
      <tr>
        <td><code>rel</code></td>
        <td class="numeric">171,802,460</td>
        <td class="numeric">1.96%</td>
      </tr>
      <tr>
        <td><code>value</code></td>
        <td class="numeric">140,666,779</td>
        <td class="numeric">1.61%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="使用頻度の高い上位10属性。", sheets_gid="1348855449", sql_file="pages_almanac_by_device_and_attribute_name_frequency.sql") }}</figcaption>
</figure>

もっとも人気のある属性は`class`で、データセットに30億回近く出現し、使用されている全属性の34％を占めています。

トップ10には、意外にも`input`要素の値を指定する`value`属性がランクインしています。私たちの主観では、`value`属性がそれほど頻繁に使われている印象を受けなかったからです。

### ページの属性

すべてのドキュメントに見られる属性はあるのでしょうか？　ありませんが、ほとんど:

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>href</td>
        <td class="numeric">99.21%</td>
      </tr>
      <tr>
        <td>src</td>
        <td class="numeric">99.18%</td>
      </tr>
      <tr>
        <td>content</td>
        <td class="numeric">98.88%</td>
      </tr>
      <tr>
        <td>name</td>
        <td class="numeric">98.61%</td>
      </tr>
      <tr>
        <td>type</td>
        <td class="numeric">98.55%</td>
      </tr>
      <tr>
        <td>class</td>
        <td class="numeric">98.24%</td>
      </tr>
      <tr>
        <td>rel</td>
        <td class="numeric">97.98%</td>
      </tr>
      <tr>
        <td>id</td>
        <td class="numeric">97.46%</td>
      </tr>
      <tr>
        <td>style</td>
        <td class="numeric">95.95%</td>
      </tr>
      <tr>
        <td>alt</td>
        <td class="numeric">90.75%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
  caption="ページ別トップ10の属性",
  sheets_gid="1185369559",
  sql_file="pages_almanac_by_device_and_attribute_name_present.sql"
)}}</figcaption>
</figure>

これらの結果は、私たちが答えられない問題を提起しています。たとえば、`type`は他の要素でも使用されていますが、なぜこのように絶大な人気があるのでしょうか。とくに、CSSやJavaScriptがデフォルトとされている中で、スタイルシートやスクリプトに対して指定する必要がないのは普通であることを考えると。また`alt`は実際にはどうなのでしょうか。9.25%のページには画像が含まれていないのでしょうか、それとも単にアクセスできないだけなのでしょうか。

### `data-*`属性

HTML仕様によると、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">`data-*`属性</a>は、"カスタムデータ、ステート、アノテーション、および同様のものをページまたはアプリケーションに対してプライベートに保存することを目的としており、これ以上適切な属性または要素がない場合に使用されます。"とあります。どのように使われていますか？　人気のあるものは何ですか？　何かおもしろいものはありますか？

もっとも人気のある2つの属性は、その後に続く各属性（使用率1％以上）よりも2倍近く人気があるため、際立っています:

<figure>
  <table>
    <thead>
      <tr>
        <th>属性</th>
        <th>発生状況</th>
        <th>パーセンテージ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>data-src</code></td>
        <td class="numeric">26,734,560</td>
        <td class="numeric">3.30%</td>
      </tr>
      <tr>
        <td><code>data-id</code></td>
        <td class="numeric">26,596,769</td>
        <td class="numeric">3.28%</td>
      </tr>
      <tr>
        <td><code>data-toggle</code></td>
        <td class="numeric">12,198,883</td>
        <td class="numeric">1.50%</td>
      </tr>
      <tr>
        <td><code>data-slick-index</code></td>
        <td>11,775,250</td>
        <td>1.45%</td>
      </tr>
      <tr>
        <td><code>data-element_type</code></td>
        <td class="numeric">11,263,176</td>
        <td class="numeric">1.39%</td>
      </tr>
      <tr>
        <td><code>data-type</code></td>
        <td class="numeric">11,130,662</td>
        <td class="numeric">1.37%</td>
      </tr>
      <tr>
        <td><code>data-requiremodule</code></td>
        <td class="numeric">8,303,675</td>
        <td class="numeric">1.02%</td>
      </tr>
      <tr>
        <td><code>data-requirecontext</code></td>
        <td class="numeric">8,302,335</td>
        <td class="numeric">1.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっともポピュラーな<code>data-*</code>属性です。", sheets_gid="764700773", sql_file="pages_almanac_by_device_and_data_attribute_name_frequency.sql") }}</figcaption>
</figure>

`data-type`、`data-id`、`data-src`のような属性は、複数の汎用的な用途がありますが、`data-src`はJavaScriptによる遅延画像読み込みで多く使用されています（例：Bootstrap 4）。<a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a>でも、`data-toggle`の存在が説明されており、トグルボタンの状態スタイリングフックとして使用されています。`data-slick-index` は <a hreflang="en" href="https://kenwheeler.github.io/slick/">Slick carousel plugin</a> が、`data-element_type` は <a hreflang="en" href="https://elementor.com/">Elementor's WordPress website builder</a> が持っています。つまり、`data-requiremodule`と`data-requirecontext`は、どちらも<a hreflang="en" href="https://requirejs.org/">RequireJS</a>の一部なのです。

興味深いことに、画像に対するネイティブ遅延ローディングの使用率は、`data-src`の場合と同様です。<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1ram47FshAjzvbQVJbAQPgxZN7PPOPCKIK67VJZCo92c/edit#gid=2109061092">3.86%のページ</a>が`<img>`要素に`loading="lazy"`を使用しています。2月の時点ではこの数字は[0.8%](https://twitter.com/zcorpan/status/1237016679667970050)程度だったので非常に、急速に増加しているようです。これらは、<a hreflang="en" href="https://addyosmani.com/blog/lazy-loading/">クロスブラウザソリューション</a>のために併用されている可能性があります。

## その他

これまで、HTMLの一般的な使い方や、上位の要素や属性の採用について説明してきました。このセクションでは、ビューポート、ファビコン、ボタン、入力、リンクなどの特殊なケースを確認しています。ここで注意しなければならないのは、あまりにも多くのリンクがいまだに「http」のURLを指していることです。

### `viewport`の仕様

[viewport](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag)メタ要素は、モバイルブラウザでのレイアウトを制御するために使用されます。数年前まではWebページを構築する際に「viewport meta要素を忘れないように」というモットーのようなものがありましたが、やがてこれが一般的になり、「ズームやスケーリングが無効になっていないか確認する」というモットーに変わりました。

ユーザーは、テキストを<a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large">最大500%</a>まで拡大・縮小できる必要があります。これが、<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>や<a hreflang="en" href="https://www.deque.com/axe/">axe</a>のような人気のあるツールの監査が、`meta name="viewport"`要素内で`user-scalable="no"`が使用され、`maximum-scale`属性値が`5`未満の場合に失敗する理由です。

データを見てみると結果をよりよく理解するためにスペースを削除し、すべてを小文字に変換し、`content`属性のコンマ値で、ソートすることでデータを正規化しました。

<figure>
  <table>
    <thead>
      <tr>
        <th>コンテンツ属性値</th>
        <th>ページ</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>initial-scale=1,width=device-width</code></td>
        <td class="numeric">2,728,491</td>
        <td class="numeric">42.98%</td>
      </tr>
      <tr>
        <td>blank</td>
        <td class="numeric">688,293</td>
        <td class="numeric">10,84%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,width=device-width</code></td>
        <td class="numeric">373,136</td>
        <td class="numeric">5.88%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width</code></td>
        <td class="numeric">352,972</td>
        <td class="numeric">5.56%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width</code></td>
        <td class="numeric">249,662</td>
        <td class="numeric">3.93%</td>
      </tr>
      <tr>
        <td><code>width=device-width</code></td>
        <td class="numeric">231,668</td>
        <td class="numeric">3.65%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="<code>viewport</code>の仕様、およびその欠如。", sheets_gid="1414206386", sql_file="summary_pages_by_device_and_viewport.sql") }}</figcaption>
</figure>

その結果、分析したページのほぼ半分が、典型的なviewport `content` 値を使用していることがわかりました。しかし約10％のモバイルページでは、viewport meta要素の適切な`content`値が完全に欠落しており、残りのページでは、`maximum-scale`、`minimum-scale`、`user-scalable=no`、または`user-scalable=0`の不適切な組み合わせが使用されています。

<p class="note">
  しばらく前から、モバイルブラウザEdgeでは、viewport meta要素を採用しているWebページで定義されているズーム設定に関わらず、<a hreflang="en" href="https://blogs.windows.com/windows-insider/2017/01/12/announcing-windows-10-insider-preview-build-15007-pc-mobile/">最低でも500%</a>までWebページを拡大することができるようになりました。
</p>

### ファビコン

ファビコンを取り巻く状況は非常に興味深いものがあります。あるブラウザは <a hreflang="en" href="https://realfavicongenerator.net/faq#why_icons_in_root">ドメインのルートを見る</a>に戻り、いくつかの画像フォーマットを受け入れ、さらに数十種類のサイズを促進します（いくつかのツールはそのうちの45種類を生成すると報告されています。<a hreflang="en" href="https://realfavicongenerator.net/">realfavicongenerator.net</a>はすべてのケースを処理するように要求されると _37_ を返します）。この記事を書いている時点では、この状況を改善するために、HTML仕様の<a hreflang="en" href="https://github.com/whatwg/html/issues/4758">open issue</a>があります。

テストを作成する際には、画像の有無はチェックせず、マークアップのみを見ていました。つまり以下の内容を確認する際には、ファビコンが使用されているか、または使用頻度よりもファビコンはどのように参照されているかが重要であることに注意してください。

<figure>
  <table>
    <thead>
      <tr>
        <th>ファビコンの形式</th>
        <th>ページ</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ICO</td>
        <td class="numeric">2,245,646</td>
        <td class="numeric">35.38%</td>
      </tr>
      <tr>
        <td>PNG</td>
        <td class="numeric">1,966,530</td>
        <td class="numeric">30.98%</td>
      </tr>
      <tr>
        <td>No favicon defined</td>
        <td class="numeric">1,643,136</td>
        <td class="numeric">25.88%</td>
      </tr>
      <tr>
        <td>JPG</td>
        <td class="numeric">319,935</td>
        <td class="numeric">5.04%</td>
      </tr>
      <tr>
        <td>No extension specified (no format identifiable)</td>
        <td class="numeric">37,011</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>GIF</td>
        <td class="numeric">34,559</td>
        <td class="numeric">0.54%</td>
      </tr>
      <tr>
        <td>WebP</td>
        <td class="numeric">10,605</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td>…</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>SVG</td>
        <td class="numeric">5,328</td>
        <td class="numeric">0.08%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="一般的なファビコンのフォーマット。", sheets_gid="1930085905", sql_file="pages_almanac_by_device_and_favicon_image_type.sql") }}</figcaption>
</figure>

ここにはいくつかのサプライズがあります:

* 他のフォーマットにも対応していますが、ウェブ上のファビコンのフォーマットとしてはICOが主流です。
* JPGは比較的人気のあるファビコン形式ですが、多くのファビコンサイズでは最良の結果が得られない（または重量が比較的大きくなる）場合があります。
* WebPはSVGの2倍の人気があります。しかし、<a hreflang="en" href="https://caniuse.com/link-icon-svg">SVG favicon support</a>の改善により、この状況は変わるかもしれません。

### ボタンと入力タイプ

最近、ボタンに関する<a hreflang="en" href="https://adrianroselli.com/2016/01/links-buttons-submits-and-divs-oh-hell.html">議論</a>が盛んに行われており、ボタンがどれほど頻繁に誤用されているかが明らかになっています。私たちは、いくつかのネイティブなHTMLボタンについての調査結果を発表するために、これを調べました。

{{ figure_markup(
  caption="ボタン要素のあるページの割合",
  content="60.56%",
  classes="big-number",
  sheets_gid="410549982",
  sql_file="pages_markup_by_device.sql"
) }}

<figure>
  <table>
    <thead>
      <tr>
        <th>ボタンの種類</th>
        <th>発生状況</th>
        <th>ページ (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>&lt;button type="button"&gt;</code></td>
        <td class="numeric">15,926,061</td>
        <td class="numeric">36.41%</td>
      </tr>
      <tr>
        <td><code>&lt;button&gt;</code> without type</td>
        <td class="numeric">11,838,110</td>
        <td class="numeric">32.43%</td>
      </tr>
      <tr>
        <td><code>&lt;button type="submit"&gt;</code></td>
        <td class="numeric">4,842,946</td>
        <td class="numeric">28.55%</td>
      </tr>
      <tr>
        <td><code>&lt;input type="submit" value="…"&gt;</code></td>
        <td class="numeric">4,000,844</td>
        <td class="numeric">31.82%</td>
      </tr>
      <tr>
        <td><code>&lt;input type="button" value="…"&gt;</code></td>
        <td class="numeric">1,087,182</td>
        <td class="numeric">4.07%</td>
      </tr>
      <tr>
        <td><code>&lt;input type="image" src="…"&gt;</code></td>
        <td class="numeric">322,855</td>
        <td class="numeric">2.69%</td>
      </tr>
      <tr>
        <td><code>&lt;button type="reset"&gt;</code></td>
        <td class="numeric">41,735</td>
        <td class="numeric">0.49%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="ボタンタイプの採用。", sheets_gid="410549982", sql_file="pages_markup_by_device.sql") }}</figcaption>
</figure>

分析の結果、約60％のページにボタン要素が含まれており、そのうち半数以上（32.43％）のページに、`type`属性の指定に失敗したボタンが少なくとも1つ存在していることがわかりました。`button` 要素の<a hreflang="en" href="https://dev.w3.org/html5/spec-LC/the-button-element.html">default type</a> が`submit`であることに注意してください。したがって、これらの32%のページにおけるボタンのデフォルトの動作は、現在のフォームデータを送信することです。このような予期せぬ動作を避けるためには、`type`属性を指定するのがベストです。

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>1ページあたりのボタン数</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">5</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">13</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="1ページあたりのボタン数の分布", sheets_gid="309769153", sql_file="pages_markup_by_device_and_percentile.sql") }}</figcaption>
</figure>

10パーセンタイルと25パーセンタイルのページにはボタンがまったく含まれていませんが、90パーセンタイルのページには13個のネイティブな`button`要素が含まれています。つまり、10％のページが13個以上のボタンを含んでいることになります。

### リンク対象

[アンカー要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element/a)、つまり`a`要素は、ウェブリソースをリンクするものです。本節では、それぞれのリンク先に含まれるプロトコルの採用状況を分析します。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロトコル</th>
        <th>発生状況</th>
        <th>ページ(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>https</code></td>
        <td class="numeric">5,756,444</td>
        <td class="numeric">90.69%</td>
      </tr>
      <tr>
        <td><code>http</code></td>
        <td class="numeric">4,089,769</td>
        <td class="numeric">64.43%</td>
      </tr>
      <tr>
        <td><code>mailto</code></td>
        <td class="numeric">1,691,220</td>
        <td class="numeric">26.64%</td>
      </tr>
      <tr>
        <td><code>javascript</code></td>
        <td class="numeric">1,583,814</td>
        <td class="numeric">24.95%</td>
      </tr>
      <tr>
        <td><code>tel</code></td>
        <td class="numeric">1,335,919</td>
        <td class="numeric">21.05%</td>
      </tr>
      <tr>
        <td><code>whatsapp</code></td>
        <td class="numeric">34,643</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td><code>viber</code></td>
        <td class="numeric">25,951</td>
        <td class="numeric">0.41%</td>
      </tr>
      <tr>
        <td><code>skype</code></td>
        <td class="numeric">22,378</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td><code>sms</code></td>
        <td class="numeric">17,304</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td><code>intent</code></td>
        <td class="numeric">12,807</td>
        <td class="numeric">0.20%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リンクターゲットプロトコルの採用", sheets_gid="1963376224", sql_file="pages_wpt_bodies_by_device_and_protocol.sql") }}</figcaption>
</figure>

また、`https`や`http`がもっとも多く、次いでメールの作成や電話、メッセージの送信を容易にする「良心的」なリンクが続いていることがわかります。`javascript`は、JavaScriptがネイティブで緩やかに機能を低下するオプションが用意されているにもかかわらず、いまだに人気のあるリンクターゲットとして際立っています。

### リンクは新規ウィンドウで表示

{{ figure_markup(
  caption='`target="_blank"`のリンクに`noopener`や`noreferrer`の属性を持たないページの割合。',
  content="71.35%",
  classes="big-number",
  sheets_gid="1876528165",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

`target="_blank"`を使用することは、以前から<a hreflang="en" href="https://mathiasbynens.github.io/rel-noopener/">セキュリティ上の脆弱性</a>であることが知られていました。しかし、71.35%のページが`target="_blank"`を使ったリンクを含んでおり、`noopener`や`noreferrer`を使っていません。

<figure>
  <table>
    <thead>
      <tr>
        <th>エレメント</th>
        <th>ページ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>&lt;a target="_blank" rel="noopener noreferrer"&gt;</code></td>
        <td class="numeric">13.63%</td>
      </tr>
      <tr>
        <td><code>&lt;a target="_blank" rel="noopener"&gt;</code></td>
        <td class="numeric">14.14%</td>
      </tr>
      <tr>
        <td><code>&lt;a target="_blank" rel="noreferrer"&gt;</code></td>
        <td class="numeric">0.56%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="空白の関係。", sheets_gid="1876528165", sql_file="pages_wpt_bodies_by_device.sql") }}</figcaption>
</figure>

経験則として、また、<a hreflang="en" href="https://www.nngroup.com/articles/new-browser-windows-and-tabs/">使いやすさの観点から</a>、そもそも`target="_blank"`を使用しないことをオススメします。

<p class="note">最新のSafariとFirefoxでは、<code>a</code>要素に<code>target="_blank"</code>を設定すると、<code>rel="noopener"</code>を設定するのと同じ<code>rel</code>の動作が暗黙的に提供されます。これはすでに<a hreflang="en" href="https://chromium-review.googlesource.com/c/chromium/src/+/1630010">Chromium</a>でも実装されており、Chrome 88にも搭載される予定です</p>。

## 結論

この章では、いくつかの見解に触れてきましたが2020年のマークアップのあり方を振り返る意味で、いくつか目についた点をご紹介します。

{{ figure_markup(
  caption="変わったdoctypeを持つページの割合。",
  content="3.97%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

癖のあるモードに着地するページが減りました。2016年には、その数は<a hreflang="en" href="https://discuss.httparchive.org/t/how-many-and-which-pages-are-in-quirks-mode/777">約7.4%</a>でした。2019年の終わりには、[4.85%](https://twitter.com/zcorpan/status/1205242913908838400)と観測されました。そして今は、約3.97%となっています。この傾向は、本章のレビューに登場した[Simon Pieters](./contributors#zcorpan)の言葉を借りれば、明確で励みになると思われます。

開発の全体像を把握するための歴史的なデータはありませんが、「無意味な」`div`、`span`、`i`のマークアップは、1990年代から2000年代前半に見られた`table`のマークアップをほぼ[置換](#top-elements)しています。意味的により適切な代替手段がないのに、常に`div`や`span`要素が使用されていることに疑問を感じるかもしれませんが、これらの要素は`table`マークアップよりも好ましいものです。表形式のデータ以外のすべてに使用されます。

ページあたりの要素とページあたりの要素タイプはほぼ変わらず、2019年と比較して、私たちのHTMLの書き方に[大きな変化はない](#element-diversity)ことを示しています。このような変化は、顕在化するまでに時間を要する可能性があります。

`g:plusone`（モバイルサンプルでは17,607ページで使用）や`fb:like`（11,335ページ）のような独自の製品固有の要素は、昨年は[もっとも人気のある要素の1つ]（../2019/markup#products-and-libraries-and-their-custom-markup）だったのですが、ほとんどなくなっています。しかし、Slider RevolutionやAMP、Angularなどの[カスタム要素](#custom-elements)が多く観測されます。また、`ym-measure`、`jdiv`、`ymaps`などの要素もまだ多く見られます。ここで私たちが想像するのはゆっくりと変化するプラクティスの海の下で作者が廃止されたマークアップを捨て、新しいソリューションを採用することでHTMLが非常によく開発され、維持されているということです。

さて、[2019年Web Almanacマークアップの章](../2019/markup)では、このテーマに関する前回の大規模な調査から14年分の追記があったため、それからの1年間ではあまりカバーできないと思われるかもしれません。しかし、今年のデータで観察されたのは、HTMLの海の底や岸辺付近で多くの動きがあったということです。私たちは、生きたHTMLをほぼ完全に採用しようとしています。GoogleやFacebookのウィジェットのような流行のページはすぐに削除されています。AngularやAMP（「コンポーネントフレームワーク」と呼ばれています）の人気が著しく低下しReactやVueのようなソリューションが求められているように、私たちはフレームワークを採用するのも、避けるのも早いです。

それでも、HTMLが与えてくれる選択肢を使い切った形跡はありません。あるページで使われている30種類の要素の中央値は、HTMLが提供する要素の約4分の1であり、HTMLがかなり一方的に使われていることを示唆しています。これは、`div`や`span`のような要素の絶大な人気によって裏付けられており、これらの2つの要素が表す可能性のある需要を満たすカスタム要素はありません。残念ながら、サンプルの各文書を検証することはできませんでした。しかし、注意が必要な逸話として、W3Cでテストされた文書の<a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/issues/899#issuecomment-717856201">79%</a>には検証エラーがあることを知りました。これだけ見ても、私たちはまだまだHTMLの技術を習得するには程遠いようです。

だからこそ、私たちは訴えたいことがあるのです。HTMLに注意を払ってください。HTMLに注目してください。HTMLに投資することは重要であり、価値があります。HTMLはドキュメント言語であり、プログラミング言語のような魅力はありませんが、それでもウェブはHTMLの上に構築されています。HTMLの使用量を減らし、本当に必要なものを学びましょう。もっと適切なHTMLを使いましょう、何が使えるのか、何のために存在するのかを学びましょう。そして、<a hreflang="en" href="https://validator.w3.org/docs/why.html">あなたのHTMLを検証しましょう</a>。誰でも無効なHTMLを書くことができますが（次に会う人にHTML文書を書いてもらい、その出力を検証してみてください）、プロの開発者は有効なHTMLを作成することが期待できます。正しくて有効なHTMLを書くことは、誇りを持って行うべき技術です。

次回のWeb Almanacの章では、HTMLを書く技術を詳しく見て、できれば私たちがどのように改善してきたかを見ていく準備をしましょう。

<p class="note">
  あとは、あなたにお任せします。あなたの観察力はどうですか？何があなたの目に留まりましたか？何が悪くなって、何が良くなったと思いますか？<a hreflang="en" href="https://discuss.httparchive.org/t/2039">Leave a comment</a>であなたの意見を聞かせてください。
</p>
