---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: マークアップ
description: 2021年版Web Almanacのマークアップの章では、要素や属性の使用状況、文書の傾向、新しい規格の採用率などを取り上げています。
authors: [AlexLakatos]
reviewers: [j9t, bkardell, shantsis, tunetheweb, rviscomi]
analysts: [kevinfarrugia]
editors: [rviscomi]
translators: [ksakae1216]
AlexLakatos_bio: Alex Lakatosは過去10年間、ブラウザ、通信、FinTechの各組織でオープンウェブの研究に携わってきました。ウェブ技術と開発者支援のバックグラウンドを持ち、<a hreflang="en" href="https://interledger.org/">Interledger Foundation</a> が開発者向けの製品を構築し、開発者コミュニティ全体と関わりを持つのを支援しています。[Twitterで彼にコンタクトを取ることができます](https://twitter.com/avolakatos)。
results: https://docs.google.com/spreadsheets/d/1Ta5Ck7y3W6LCn2CeGtW7dAdLF6Lh5wV2UBQJZTz3W5Q/
featured_quote: 毎年新しい規格の採用を増やしている人々の一員になりましょう。今日学んだ新しいこと、この章だけでなくWeb Almanac全体で取り上げた多くの標準のうちの1つから始めてみてください。
featured_stat_1: 35.3%
featured_stat_label_1: ICOはついにPNGによって最も人気のあるファビコンフォーマットとして廃止されました
featured_stat_2: 98%
featured_stat_label_2: ページには、HTMLの `<script>` 要素が少なくとも1つある
featured_stat_3: 4,256
featured_stat_label_3: 1つのページで最も多くの `<form>` 要素が見つかる。
---

## 序章

Webサイトにアクセスしようとしたとき、何が起こっているのか不思議に思ったことはないだろうか。ブラウザのアドレスバーにURLを入力すると、最初にHTMLファイルがダウンロードされ、解析されます。マークアップはWebの基礎と言えるでしょう。この章では、今日のウェブを成り立たせているレンガのいくつかを見ていくことに専念しました。

過去3年間の分析データをもとに、マークアップの将来、長年のトレンド、新しい標準の採用率などについて、いくつかの疑問点を考えてみました。また、皆様がデータをより深く掘り下げ、私たちの解釈とは異なる方法で解釈してくださることを期待して、データを共有しました。

_マークアップの章では、HTMLに焦点を当てます。他のマークアップ言語（SVGやMathMLなど）や『Web Almanac』の他のトピックについても簡単に触れていますが、それらについてはそれぞれの専用の章で詳しく解説しています。マークアップはウェブへの入り口であるため、章を丸ごと捧げないのは非常に困難でした_。

## 一般

まず、マークアップ文書のより一般的な側面、すなわち文書の種類、文書のサイズ、文書の言語、圧縮などを説明します。

### Doctypes

2021年になっても、すべてのページが `<!DOCTYPE html>` などで始まることを不思議に思ったことはないだろうか。DOCTYPEが必要なのは、ブラウザがページをレンダリングする際、"[後方互換モード](https://developer.mozilla.org/ja/docs/Web/HTML/Quirks_Mode_and_Standards_Mode)"に切り替えてはいけない、その代わりHTML仕様に従うよう最善の努力をするように、ということを伝えるためなのです。

今年は、97.4%のページがdoctypeを持ち、昨年の96.8%からわずかに増加しました。ここ数年を見ると、doctypeの比率は毎年半ポイントずつ着実に増えています。 理想を言えば、100％のウェブページがdoctypeを持つことになるのだが、この調子だと2027年には理想郷に住んでいることになります。

人気という点では、`<!DOCTYPE html>`として知られるHTML5が依然としてもっとも人気で、モバイルページの88.8%がこのDoctypeを使用しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTML ("HTML5")</td>
        <td class="numeric">87.0%</td>
        <td class="numeric">88.8%</td>
      </tr>
      <tr>
        <td>XHTML 1.0過渡期</td>
        <td class="numeric">5.7%</td>
        <td class="numeric">4.6%</td>
      </tr>
      <tr>
        <td>厳密なXHTML 1.0</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>HTML 4.01過渡期</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>HTML 4.01過渡期(<a href="https://hsivonen.fi/doctype/#xml">癖のある</a>)</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="最も人気のあるDoctypeです。",
    sheets_gid="269200864",
    sql_file="doctype.sql"
  ) }}</figcaption>
</figure>

驚くべきは、[それから約20年](https://ja.wikipedia.org/wiki/Extensible_HyperText_Markup_Language)経った今でも、XHTMLはウェブのかなりの部分を占めており、デスクトップでは8%、モバイルは7%弱のページで使用されているということです。

### ドキュメントサイズ

1バイトのデータにもコストがかかるモバイルの世界では、モバイルサイト用のドキュメントサイズの重要性が増しています。また、見たところ、ますます大きくなっているようです。今年、モバイル向けページのHTMLの中央値は27KBで、昨年より2KB増加しています。デスクトップ側では、中央のページのHTMLは29KBでした。

{{ figure_markup(
  image="page-size-by-year.png",
  caption="ページサイズ前年比の中央値。",
  description="2019年、2020年、2021年のモバイルページとデスクトップページのページサイズの中央値の推移を示す棒グラフ。2020年はサイズが若干減少し、2021年は2019年を上回りました。サイズは27キロバイト前後に引き寄せられています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=618740225&format=interactive",
  sheets_gid="742176410",
  sql_file="document_trends.sql"
) }}

興味深かった点は

* 2019年と比較した場合、2020年のページサイズの中央値は縮小していました。上の図を見ると、2020年に凹んだ後、今年は少し増えていますね。
* デスクトップとモバイルの両方で最大のHTML文書は、デスクトップで45MB、モバイルで21MBと、今年に入ってから、それぞれ20MBずつ大幅に減少しているのです。

### 圧縮

文書サイズが大きくなる中、今年は圧縮についても検討しました。私たちは、文書サイズとそれを転送する際に使用する圧縮のレベルが密接に関係していると考えました。

{{ figure_markup(
  image="content-encoding.png",
  caption="コンテンツエンコード方式の採用。",
  description="モバイルページとデスクトップページで使用されているコンテンツのエンコード方式を示す棒グラフ。63.8%のページがgzipを使用し、21.9%がBrotliを使用、14.1%は非圧縮であることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1960175313&format=interactive",
  sheets_gid="75721024",
  sql_file="content_encoding.sql"
) }}

デスクトップ600万ページのうち、84.4%がgzip（62.7%）またはBrotli（21.7%）で圧縮されていることがわかりました。モバイルページについても、85.6%がgzip（63.7%）またはBrotli（21.9%）で圧縮されており、非常によく似た数字となっています。モバイルとデスクトップで割合が若干異なるのは、異なるURLで構成されていることと、[モバイルデータセットがより大きい](./methodology#websites)ことから、驚くべきことではありません。

特にモバイルの世界では、1バイトのデータにもコストがかかるため、圧縮は重要です。[圧縮](./compression)と[モバイルウェブ](./mobile-web)の章で、コンテンツエンコーディングとモバイルウェブの状態についてより詳しく知ることができます。

### ドキュメントの言語

私たちは、`html` 要素の `lang` 属性のユニークなインスタンスに3,598個遭遇しました。この章を書いた時点では、<a hreflang="en" href="https://www.ethnologue.com/guides/how-many-languages">7,139の言語が話されている</a> ので、そのすべてが表現されているわけではないと思わされました。[言語タグの構文](https://developer.mozilla.org/ja/docs/Web/HTML/Global_attributes/lang#language_tag_syntax) を考慮すると、さらに少ない数しか残っていません。

{{ figure_markup(
  image="lang-region.png",
  caption="リージョンを含むもっとも一般的なHTML言語コードの採用。",
  description="データセットに含まれる上位10言語について、地域も含めた使用状況を棒グラフで示したものです。19%が英語、18.6%が設定なし、13.5%がアメリカ英語、日本語、スペイン語、ブラジルポルトガル語、イギリス英語、ロシア語、ドイツ語、フランス語が5.3から1.5と、さまざまな割合で使われていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=742535028&format=interactive",
  sheets_gid="298704786",
  sql_file="html_lang.sql"
) }}

Web Content Accessibility Guidelines (<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/meaning-doc-lang-id.html">WCAG</a>) では、ページの言語を定義して「プログラムからアクセス可能」であることが求められているにもかかわらず、スキャンしたページのうち、デスクトップでは19.6% 、モバイルでは18.6% が[`lang`属性の指定なし](./accessibility) だったのです。言語は `xml:lang` 要素を含むさまざまな方法で指定できますが、今回はチェックしませんでしたので、スキャンされたページの中にはまだ望みがあるかもしれません。

{{ figure_markup(
  image="lang.png",
  caption="リージョンを含まない、もっとも一般的なHTML言語コードの採用。",
  description="データセットに含まれる上位10言語の使用状況を示す棒グラフ。スペイン語、日本語、ポルトガル語、ロシア語、ドイツ語、フランス語、イタリア語、ポーランド語は、6.3〜1.9と、さまざまな割合で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=733528618&format=interactive",
  sheets_gid="298704786",
  sql_file="html_lang.sql"
) }}

正規化された言語セットの上位10言語を見ると、興味深い傾向が見られました。

* モバイルは、英語サイトの相対的な割合が低くなっています。なぜそうなるのか、その原因についてチームで議論しています。携帯電話だけを使ってウェブにアクセスする人がいるので、モバイルセットの言語状況が多様化するのかもしれません。筆者は、モバイルページの多くは外出先での利用を想定しており、そのためローカルなページになっていると考えています。
* スペイン語は日本語よりも地域や下付き文字のオプションが多いのですが、2位以下は僅差の争いでした。
* デスクトップとモバイルの空属性の違いと英語には逆相関がある。

### コメント

{{ figure_markup(
  caption="HTMLでコメントが1つ以上あるページ。",
  content="88%",
  classes="big-number",
  sheets_gid="1557885695",
  sql_file="wpt_bodies.sql"
) }}

ほとんどのプロダクションビルドツールには、コメントを削除するオプションがありますが、私たちが分析したページの大半88%には少なくとも1つのコメントがありました。

一般にコメントはコード上で推奨されるものですが、Webページでは特定のブラウザ向けにマークアップをレンダリングするために、条件付きコメントという特殊なタイプのコメントが使われていました。

```html
<!--[if IE 8]>

  <p>This renders in Internet Explorer 8 only.</p>

<![endif]-->
```

マイクロソフトは、IE10で条件付きコメントのサポートを打ち切りました。それでも、41%のページには少なくとも1つの条件付きコメントが存在していました。これらが非常に古いウェブサイトである可能性は別として、古いブラウザ用のポリフィリングフレームワークのバリエーションのようなものを使っていると考えるしかないでしょう。

### SVGの使用

{{ figure_markup(
  caption="HTMLにSVG要素が1つ以上含まれるページ。",
  content="46.4%",
  classes="big-number",
  sheets_gid="1117632433",
  sql_file="markup.sql"
) }}

今年は、SVGの使い方を取り上げてみたいと思いました。人気のアイコンライブラリでSVGがどんどん使われ、ファビコンのサポートも向上し、アニメーションでもSVG画像が増えてきているので、46.4％のウェブページに何らかのSVGが使われていても不思議ではありません。37.2%がSVG要素を持ち、デスクトップでは20.0%、モバイルは18.4%がSVG画像を使用しており、SVGエンベッド、オブジェクト、iframeのいずれかを含むものはごく僅かでした。

SVGはstyle要素と比較するとより多くのユースケースを持っていますが、人気という点では、その数は同等です。SVGは、ページ上の要素の人気度という点では、トップ20からわずかに外れたところに位置しています。

## 要素

要素は、HTML文書のDNAです。私たちは、Webページという生命体を構成する細胞を分析したいと考えました。ほとんどのページでもっとも人気のある要素、もっとも存在感のある要素、そして廃れた要素は何なのか。

### 要素の多様性

現在定義され使用されている <a hreflang="en" href="https://html.spec.whatwg.org/multipage/indices.html#elements-3">112要素</a>（SVGとMathMLを除く）があり、さらに [28 は非推奨] (https://developer.mozilla.org/ja/docs/Web/HTML/Element#obsolete_and_deprecated_elements) または廃止されています。私たちは、1つのページで実際に使用される要素がいくつあるのか、また `div` がどの程度あり得るのかを確認したいと思いました。

{{ figure_markup(
  image="element-diversity.png",
  caption="1ページあたりの要素の種類数の分布。",
  description="パーセンタイルごとの要素の種類、9割のページが42種類以上の要素を使用している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1081218177&format=interactive",
  sheets_gid="920875734",
  sql_file="element_count_distribution.sql"
) }}

ウェブは`div`でできているわけではありません。モバイルページの中央値は31の異なる要素を使用し、合計616の要素を持っています。

{{ figure_markup(
  image="element-count.png",
  caption="1ページあたりの要素数分布。",
  description="全ページの10％が1,727以上の要素を採用していることを示す、パーセンタイルごとの要素数。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=957921827&format=interactive",
  sheets_gid="920875734",
  sql_file="element_count_distribution.sql"
) }}

中央値のページの要素数はデスクトップで666、モバイルで616だったのに対し、全ページの上位10％ではモバイルで1,727、デスクトップで1,902と3倍近い数に達しています。

### 要素のトップ

2019年から毎年、『Web Almanac』のマークアップ編では、<a hreflang="en" href="https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html">2005年のIan Hickson氏の著作</a>を参考に、もっともよく使われる要素を紹介しています。この著者は伝統を破ることができなかったので、私たちはもう一度データを見てみたのです。

<figure>
  <table>
    <thead>
      <tr>
        <th>2005</th>
        <th>2019</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
      <tbody>
      <tr>
        <td>`title`</td>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
      </tr>
      <tr>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
      </tr>
      <tr>
        <td>`img`</td>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
      </tr>
      <tr>
        <td>`meta`</td>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
      </tr>
      <tr>
        <td>`br`</td>
        <td>`img`</td>
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`table`</td>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`td`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`tr`</td>
        <td>`option`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td>`i`</td>
        <td>`meta`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td>`option`</td>
        <td>`i`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>`ul`</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>`option`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="ページごとの使用頻度の高い要素の進化。",
    sheets_gid="2049124461",
    sql_file="top_elements.sql"
  ) }}</figcaption>
</figure>

上位6つの要素は過去3年間変わっておらず、`link`要素が7位として確固たる地位を築いているようです。

興味深いのは、`i`と`option`の両方が人気を失っていることです。前者はおそらく、アイコンに `i` 要素を悪用するライブラリが、アイコンにSVGを使用するライブラリに取って代わられたからでしょう。今年は、ソーシャルマークアップも盛り上がっているせいか、`meta`要素がトップ10に食い込んできていますね。[ソーシャルマークアップ](#ソーシャルマークアップ)については、この章の後のセクションで見ていきます。スタイル付き `select` 要素の増加は、 `ul`（順序なしリスト）要素がoption要素よりも人気を博していることを物語っています。

#### `main`

<a hreflang="en" href="https://wordpress.com/activity/posting/">2021年にコンテンツの作成が急増</a>（おそらく世界で大流行したため）したため、それがコンテンツ要素の採用にも相関しているかどうかを確認したいと思いました。私たちは、`main` が良い指標になると考えました。これは、ページの構造に関するDOMの概念に影響を与えない、情報量の多い要素だからです。

{{ figure_markup(
  caption="少なくとも1つの `main` 要素を持つモバイルページの割合。",
  content="27.9%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

デスクトップページの27.7％、モバイルページの27.9％が`main`要素を備えていました。人気度では、トップ50の要素の中で34位と健闘しています。114個の要素しかないと思われるかもしれませんが、実際には1000個以上の要素がクエリから返ってきており、そのほとんどがカスタム要素です。

#### `base`

もうひとつ気になったのは、HTML仕様の厳格なルールに開発者がどれだけ注意を払っているかということです。たとえば、仕様では、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/semantics.html#the-base-element">`base`要素はドキュメントに1つ以上存在してはならない</a>とあります。これは、`base`要素がユーザー エージェントによる相対URLの解決方法を定義しているからです。複数の `base`要素があるとあいまいさが生じるため、仕様では、最初の要素以降のすべての`base`要素を無視して、それらを使用できなくする必要があります。

デスクトップページを見ると、`base`はよく使われる要素で、10.4%のページが持っています。しかし、1つしかないのでしょうか？ページよりも5,908個多く `base`要素があるので、少なくともいくつかのページが複数の `base` 要素を持っていると結論付けることができます。開発者が指示に従うことが得意だと誰が言ったのでしょうか？また、W3Cが提供する<a hreflang="en" href="https://validator.w3.org/">Markup Validation Service</a> を使ってHTMLを検証することをオススメします。

#### `dialog`

この章では、より議論を呼びそうな要素や新しい要素の採用についても見ていきたいと思います。`dialog`はその1つで、すべての主要なブラウザがすぐにサポートするわけではありません。デスクトップでは7,617ページ、モバイルでは7,819ページのみがダイアログ要素を使っています。分析したページの0.1%程度に過ぎないことを考えると、まだ採用されていないように見えます。

#### `canvas`

`canvas` 要素は、[Canvas API](https://developer.mozilla.org/ja/docs/Web/API/Canvas_API) または [WebGL API](https://developer.mozilla.org/ja/docs/Web/API/WebGL_API) と共に使用して、グラフィックスやアニメーションを描画することが可能です。Web上のゲームや複合現実感に使われる主要な要素の1つです。デスクトップページの3.1％、モバイルページの2.6％が使用しているのは当然のことです。デスクトップでの使用率が高いのは、さまざまなデバイスのグラフィック性能や、ゲームやバーチャルリアリティに偏ったユースケースを考慮すれば納得がいきます。

### 要素の使用頻度

`html`、`head`、`body`、`title`、`meta`要素はすべてオプションですが、今年もっともよく使われた要素で、いずれも99%以上のページに存在しています。

<p class="note">ブラウザは自動的に `html` と `head` 要素を追加しますが、このグラフでは、クロール時にアクセスできなくなったサイトのために、クロールしたページの 0.2% がエラーになっていることに注意してください。</p>

{{ figure_markup(
  image="element-popularity.png",
  caption="HTMLの上位要素の採用。",
  description="HTML要素の採用状況を示す棒グラフ。html、head、body、title、metaはいずれも99％以上のWebサイトで表示されている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=231602731&format=interactive",
  height=656,
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

昨年と比較すると、比率は若干異なるものの、人気の高い要素の順番は変わっていません。もっとエキゾチックな要素はどうでしょうか？

<figure>
  <table>
    <thead>
      <tr>
        <th><em>要素</em></th>
        <th>ページ数の割合（モバイル）</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`tt`</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>`ruby`</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>`rt`</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="モバイルページでの `tt`, `ruby`, `rt` 要素の採用。",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

興味深いのは、[テレタイプテキスト](https://developer.mozilla.org/ja/docs/Web/HTML/Element/tt) の非推奨要素である `tt` が、東アジアの文字の発音を示すために今でも使われている [ルビアノテーション](https://developer.mozilla.org/ja/docs/Web/HTML/Element/ruby) と [ルビ文字列](https://developer.mozilla.org/ja/docs/Web/HTML/Element/rt) の要素である `ruby` と `rt` より100%人気があることです。

### `script`

{{ figure_markup(
  caption="少なくとも1つの `script` 要素を持つモバイルページの割合。",
  content="98.2%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

スキャンされたページの98％強が、少なくとも1つの `script` 要素を含んでいます。これは、`script`がページ上で6番目に人気のある要素であることと同じです。昨年と比較すると、`script`要素の人気は不変のようで、分析された数百万ページでの出現率は97%から98%へとわずかに上昇しています。

{{ figure_markup(
  caption="少なくとも1つの `noscript` 要素を持つモバイルページの割合。",
  content="51.4%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

また、51.4%のページが`noscript`要素を含んでおり、これは一般的にJavaScriptを無効にしているブラウザにメッセージを表示するために使用されます。`noscript` 要素のもうひとつの一般的な用途は、Googleタグマネージャー(GTM)のスニペットです。デスクトップでは18.8%、モバイルは16.9%のページが、GTMスニペットの一部として `noscript` 要素を使用しています。GTMは、モバイルよりもデスクトップで人気があるのは興味深いことです。

### `template`

Web Components仕様の <a hreflang="en" href="https://css-tricks.com/crafting-reusable-html-templates/"> もっとも認知されていないが、もっとも強力な機能</a> のひとつに `template` 要素があります。2013年からモダンブラウザで [`template`要素](https://developer.mozilla.org/ja/docs/Web/Web_Components/Using_templates_and_slots) がしっかりサポートされているにもかかわらず、2021年には0.5% のページしか使っていませんでした。人気度では、トップ50の要素にすら入っていない。これは、ウェブ開発者にとってのモダンなHTML仕様の普及カーブを物語っていると考えました。

`template`が何をするのかよく分からないという人のために、仕様書を読んで復習しておきましょう。`template` 要素は、スクリプトによって複製され、ドキュメントに挿入されるHTMLの断片を宣言するために使用されます。もしあなたがウェブ開発者で、この言葉に聞き覚えがあると思うのなら、その通りです。 Angularは<a hreflang="en" href="https://angular.io/guide/content-projection">`ng-content`</a>、Reactでは<a hreflang="en" href="https://reactjs.org/docs/portals.html">portals</a>、そしてVueは<a hreflang="en" href="https://v3.vuejs.org/guide/component-slots.html#slots">`slot`</a> です。現在人気のフレームワークはほとんど同じことを行う非ネイティブ機構が備わっています。これらのフレームワークでは、フレームワーク内で機能を再作成する代わりに、ネイティブの `template` 要素またはWeb Componentsを使用するものと考えていました。

### `style`

{{ figure_markup(
  caption="少なくとも1つの `style` 要素を持つモバイルページの割合。",
  content="83.8%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

ウェブページを作るとき、3つのものが一緒になります。ひとつはHTMLで、この章を通してそれを見ていきます。2つ目はJavaScriptで、JavaScriptを読み込むために使われる`script`要素がもっとも人気のあるものの1つであることを[前のセクション](#スクリプト)で見てきました。CSSのインライン化に使われる`style`要素も同様に人気があることは、さほどショックではないでしょう。スキャンされたモバイルページの83.8%は、少なくとも1つの `style` 要素を持っていました。

ページ内での人気度という点では、0.7％とトップ20に入るのがやっとでした。つまり、1つのページで複数の `script` 要素が人気を集めている一方で、ほとんどのページでは `style` 要素の数が5倍も少ないと考えられます。そして、それは理にかなっているのです。なぜなら、`script`要素はインラインと外部スクリプトの両方に使用できますが、CSSでは外部スタイルシートの読み込みに`link`要素という別の要素を使用するからです。`link` 要素は `script` 要素よりもわずかに多くのページに存在していますが、出現数の点ではやや劣っています。

### カスタム要素

また、HTMLやSVGの仕様に現れない要素、それが最新であれ旧式であれ、どのようなカスタム要素が世の中に出回っているのかを調べました。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>ページ数</th>
        <th>ページ数の比率</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`rs-module-wrap`</td>
         <td class="numeric">123,189</td>
         <td class="numeric">2.0%</td>
      </tr>
      <tr>
         <td>`wix-image`</td>
         <td class="numeric">76,138</td>
         <td class="numeric">1.2%</td>
      </tr>
      <tr>
         <td>`pages-css`</td>
         <td class="numeric">75,539</td>
         <td class="numeric">1.2%</td>
      </tr>
      <tr>
         <td>`router-outlet`</td>
         <td class="numeric">35,851</td>
         <td class="numeric">0.6%</td>
      </tr>
      <tr>
         <td>`next-route-announcer`</td>
         <td class="numeric">9,002</td>
         <td class="numeric">0.1%</td>
      </tr>
      <tr>
         <td>`app-header`</td>
         <td class="numeric">7,844</td>
         <td class="numeric">0.1%</td>
      </tr>
      <tr>
         <td>`ng-component`</td>
         <td class="numeric">3,714</td>
         <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="デスクトップページに一部のカスタム要素を採用。",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

圧倒的に人気があるのは<a hreflang="en" href="https://www.sliderrevolution.com/faq/developer-guide-output-class-tag-changes/">Slider Revolution</a>で、大半の要素がこのフレームワークに起因するものだと言われています。この1年で3倍以上の人気となり、人気のあるテンプレートやサイトビルダーの一部かもしれないと考えるに至りました。僅差で2位は、人気の無料サイトビルダーの<a hreflang="en" href="https://www.wix.com/">Wix</a>です。`pages-css`は特定できませんでしたが、なぜ `pages-css` 要素が人気なのか、何かアイデアがありましたら、GitHubの[編集を提案する](#explore-results) で教えてください。

<a hreflang="en" href="https://angular.io/">Angular</a>や <a hreflang="en" href="https://nextjs.org/">Next.js</a> 、あるいは以前の <a hreflang="en" href="https://angularjs.org/">Angular.js</a> など人気フレームワークはもっとカスタムコンポーネントを占めていると思っていましたが、`router-outlet` と `ng-component` はカスタムコンポーネント基盤の小さな一部を構成していることがわかります。

### 廃止された要素

現在、HTMLリファレンスには、[28の廃止・非推奨要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element#obsolete_and_deprecated_elements)が記述されています。私たちは、そのうちのいくつが現在も使われているのかを知りたかったのです。圧倒的に使われているのは `center` と `font` で、昨年と比較してその使用率がわずかに減少しているのは喜ばしいことです。

一方、`nobr`と`big`はまだ非推奨ですが、昨年と比較して使用頻度がわずかに増加しています。

{{ figure_markup(
  image="obsolete-elements.png",
  caption="時代遅れのトップHTML要素の採用。",
  description="centerとfontがもっとも多く、それぞれ6.6%と5.9%のページで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=369760501&format=interactive",
  sheets_gid="1958462994",
  sql_file="top_obsolete_elements.sql"
) }}

デスクトップと比較した場合、モバイルページの廃止要素の割合は若干異なりますが、順位は変わりません。

{{ figure_markup(
  image="relative-obsolete-elements.png",
  caption="廃止された上位のHTML要素の相対的な採用率。",
  description="廃止されたHTML要素の相対的な使用率を示す円グラフ。centerとfontはもっとも人気があり、円周の43.2%と38.2%を占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=237093362&format=interactive",
  sheets_gid="1958462994",
  sql_file="top_obsolete_elements.sql"
) }}

Googleは2021年になってもトップページに`center`要素を使用していますが、私たちが判断するつもりはありません。

### 独自規格・非標準規格の要素

カスタム要素はすべてハイフンが入っていますが、作り物でハイフンがなく、<a hreflang="en" href="https://html.spec.whatwg.org/#toc-semantics">HTML standard</a> に表示されない要素にも遭遇しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`jdiv`</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`noindex`</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`mediaelementwrapper`</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>`ymaps`</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>`h7`</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>`h8`</td>
        <td class="numeric">&lt;0.1%</td>
        <td class="numeric">&lt;0.1%</td>
      </tr>
      <tr>
        <td>`h9`</td>
        <td class="numeric">&lt;0.1%</td>
        <td class="numeric">&lt;0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="非標準要素の採用。",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

いずれも昨年も存在しており、JivoChat、Yandex、MediaElement.js、Yandex Mapsといった人気のフレームワークや製品に起因するものであることがわかります。また、調子に乗って6個ではヘッダーが足りないという人もいるので、`h7`から`h9`まで。

### 埋め込み型コンテンツ

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`iframe`</td>
        <td class="numeric">56.7%</td>
        <td class="numeric">54.5%</td>
      </tr>
      <tr>
        <td>`source`</td>
        <td class="numeric">9.9%</td>
        <td class="numeric">8.4%</td>
      </tr>
      <tr>
        <td>`picture`</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">6.0%
       </td>
      </tr>
      <tr>
        <td>`object`</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`param`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>`embed`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="コンテンツ埋め込み用要素の採用。",
    sheets_gid="1883388700",
    sql_file="element_popularity.sql"
  ) }}</figcaption>
</figure>

コンテンツは、ページ内の複数の要素を通じて埋め込むことができます。もっとも人気があるのは `iframe` で、それに続くのが `source` と `picture` です。

実際の `embed` 要素は、コンテンツを埋め込むための現在のすべての要素の中で、もっとも人気がありません。

### フォーム

フォーム、つまり訪問者から入力を得る方法は、ウェブの構造の一部となっています。デスクトップでは71.3%、モバイルは67.5%のページで、少なくとも1つの`form`が使われていることは、驚くことではありません。もっとも多かったのは、1つのページに1つ（デスクトップでは33.0%、モバイルは31.6%）または2つ（デスクトップでは17.9%、モバイルは16.8%）の`form`要素があることでした。

{{ figure_markup(
  caption="1つのページで見つかるもっとも多くの `form` 要素。",
  content="4,256",
  classes="big-number",
  sheets_gid="1723929411",
  sql_file="forms.sql"
) }}

また、1つのページがデスクトップで4,018個の`form`要素、モバイルで4,256個の`form`要素を持つという極端なケースも存在します。4,000個に分割しなければならないほど価値のある入力とはどのようなものなのか、考えずにはいられません。

## 属性

要素の動作は属性に大きく影響されます。そこで、ページで使用される属性を調べ、`data-*`パターンと、`meta`要素に人気のあるソーシャル属性を探りました。

### トップ属性

{{ figure_markup(
  image="attribute-popularity.png",
  caption="もっとも一般的なHTMLの属性です。",
  description="使用頻度の高い属性トップ10を棒グラフで表したもの。 classが34.3％と圧倒的に多く、次いでhrefが9.9％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1580508221&format=interactive",
  height=558,
  sheets_gid="1328339120",
  sql_file="attributes.sql"
) }}

もっとも人気のある属性は `class` で、これはスタイリングに使用されることを考えると、驚くことではありません。私たちが調査したページで見つかったすべての属性の34.3%は `class` でした。一方、`id`の使用率は5.2%と非常に少ない。興味深いのは、`style` 属性が `id` 属性よりも人気があり、5.6% を占めている点です。

2番目に多い属性は `href` で、9.9%の出現率でした。リンクはウェブの一部なので、アンカー要素の属性がこれほど人気があるのは驚きではありません。意外だったのは、`src`属性が、[かなり多くの要素で利用できる](https://developer.mozilla.org/ja/docs/Web/HTML/Attributes)にもかかわらず、`alt`属性の2倍しか利用されていなかったことです。

#### メタフレーバー

今年、`meta`要素の人気が落ちてきているので、もう少し詳しく見ていきたいと思います。これらは、機械的に読み取れる情報をページに追加する方法を提供するだけでなく、いくつかの巧妙なHTTP同等機能を実行します。たとえば、ページに対して _コンテンツセキュリティポリシー_ を設定できます。

```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*;">
```

利用可能な属性のうち、`name`（`content`と対になっている）がもっともよく使われています。14.2% の `meta` 要素は `name` 属性を持ちませんでした。`content` 属性と組み合わせて、情報を渡すためのキーと値のペアとして使用されます。どんな情報かというと？

{{ figure_markup(
  image="meta-names.png",
  caption="もっともよく使われる `meta` ノード名です。",
  description="meta要素の名前属性の使用頻度上位10位を示した棒グラフ。16.3%のmeta要素には名前がなく、viewportだけが3%を超えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1705395065&format=interactive",
  height=604,
  sheets_gid="1907270745",
  sql_file="meta_nodes_name.sql"
) }}

{{ figure_markup(
  caption="`initial-scale=1,width=device-width` という値を持つ `meta` ビューポートの割合です。",
  content="45.0%",
  classes="big-number",
  sheets_gid="1885501317",
  sql_file="meta_viewport.sql"
) }}

もっとも人気があるのはビューポート情報で、`viewport`の値としては `initial-scale=1,width=device-width` がもっとも人気があります。スキャンされたモバイルページの45.0%がこの値を使用していました。

2番目に多い組み合わせは、<a hreflang="en" href="https://ogp.me/">Open Graph</a> meta要素としても知られる `og:*` meta要素です。これらについては、次のセクションで説明します。

#### ソーシャルマークアップ

ソーシャルプラットフォームがあなたのページへのリンクをプレビューする際に使用する情報やアセットを提供することは、`meta`要素の一般的な使用例です。

{{ figure_markup(
  image="social-meta-names.png",
  caption="ソーシャル `meta` ノードのページ別使用率。",
  description="ソーシャルメディア関連のmeta要素の名前属性の使用頻度上位10位を示した棒グラフです。Twitterのmeta要素よりもOpen Graphのmeta要素の人気があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1723706431&format=interactive",
  height=604,
  sheets_gid="1907270745",
  sql_file="meta_nodes_name.sql"
) }}

もっとも一般的なのは、複数のネットワークで使用されているOpen Graphの `meta` 要素で、Twitter固有の要素はそれに劣ります。`og:title`、`og:type`、`og:image`、`og:url`はすべてのページで必要なので、その使用数にばらつきがあるのは興味深いことです。

### `data-` 属性

<a hreflang="en" href="https://html.spec.whatwg.org/#embedding-custom-non-visible-data-with-the-data-*-attributes">HTML仕様では</a>、接頭辞に `data-` を持つカスタム属性を使用できます。これは、カスタムデータ、状態、注釈などを保存するためのもので、ページやアプリケーションのプライベートなもので、これ以上適切な属性や要素がないようなものです。

{{ figure_markup(
  image="data-attributes.png",
  caption="もっとも一般的な `data-` 属性です。",
  description="要素のデータ属性のうち、使用頻度の高い上位10位までを示した棒グラフです。一般的なdata-idとdata-srcがもっともよく使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1104552143&format=interactive",
  height=599,
  sheets_gid="319139425",
  sql_file="data_attributes.sql"
) }}

もっとも一般的なものである `data-id`、`data-src`、`data-type` は非特定であり、 `data-src` 、 `data-srcset` 、 `data-sizes` は画像の遅延ローディングライブラリで非常によく使用されるものです。`data-element_type` と `data-widget_type` は、人気のウェブサイトビルダーである <a hreflang="en" href="https://code.elementor.com/">Elementor</a> から来ています。

<a hreflang="en" href="https://github.com/kenwheeler/slick">Slick、「あなたが必要とする最後のカルーセル」</a>は `data-slick-index` を担当します。Bootstrapのような人気のあるフレームワークは `data-toggle` を担当し、<a hreflang="en" href="https://testing-library.com/docs/queries/bytestid/">testing-library</a> は `data-testid` に責任を負います。

## その他

これまで、もっとも一般的なHTMLの使用例について、かなりの部分をカバーしてきました。最後にこのセクションを設け、より難解な使用例や、ウェブでの新しい標準の採用について見ていきます。

### `viewport`仕様

`viewport` `meta` 要素は、モバイルデバイスでのレイアウトを制御するために使用されます。あるいは、少なくともそれが登場したときのアイデアでした。今日、<a hreflang="en" href="https://www.quirksmode.org/blog/archives/2020/12/userscalableno.html">一部のブラウザ</a>は、ページを<a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large">最大500%</a>まで拡大できるように、`viewport` オプションをいくつか無視しはじめました。

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
      <td>`initial-scale=1,width=device-width`</td>
      <td class="numeric">46.6%</td>
      <td class="numeric">45.0%</td>
    </tr>
    <tr>
      <td>(空っぽ)</td>
      <td class="numeric">12.8%</td>
      <td class="numeric">8.2%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,width=device-width`</td>
      <td class="numeric">5.3%</td>
      <td class="numeric">5.6%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width`</td>
      <td class="numeric">4.6%</td>
      <td class="numeric">5.4%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width`</td>
      <td class="numeric">4.0%</td>
      <td class="numeric">4.3%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,shrink-to-fit=no,width=device-width`</td>
      <td class="numeric">3.9%</td>
      <td class="numeric">3.8%</td>
    </tr>
    <tr>
      <td>`width=device-width`</td>
      <td class="numeric">3.3%</td>
      <td class="numeric">3.5%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no,width=device-width`</td>
      <td class="numeric">1.9%</td>
      <td class="numeric">2.5%</td>
    </tr>
    <tr>
      <td>`initial-scale=1,user-scalable=no,width=device-width`</td>
      <td class="numeric">1.89%</td>
      <td class="numeric">1.9%</td>
    </tr>
  </tbody>
</table>
  <figcaption>{{ figure_link(
    caption="最も一般的な `meta` のビューポート値を採用。",
    sheets_gid="1885501317",
    sql_file="meta_viewport.sql"
  ) }}</figcaption>
</figure>

もっとも一般的な `viewport` コンテンツオプションは `initial-scale=1,width=device-width` で、これはビューポートについて説明している [MDN guide](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag) で推奨されているオプションなので、驚くことではありません。分析したページの45.0%がこれを使用しており、[昨年](../2020/markup#viewportの仕様)よりほぼ3%多くなっています。8.2%のページで `content` 属性が空になっており、これも昨年より若干多くなっています。これは、ビューポートオプションの不適切な組み合わせの使用率が減少したことと相関しています。

### ファビコン

ファビコンは、ウェブ上でもっとも弾力性のある作品のひとつです。マークアップなしでも機能し、複数の画像形式を受け入れることができます。また、文字通り何十ものサイズがあり、徹底して使用する必要があります。

{{ figure_markup(
  image="favicons.png",
  caption="もっとも一般的なファビコン形式です。",
  description="ファビコンの使用頻度別上位10フォーマットを示した棒グラフです。PNG形式がICO形式をはじめて上回り、形式を指定しないファビコンが僅差で3位となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=1768688487&format=interactive",
  height=583,
  sheets_gid="29842244",
  sql_file="favicons.sql"
) }}

データを見ると、いくつかの驚きがありました。

* ICOは、ついにPNGにその座を奪われた。
* JPGは、他の不人気な選択肢と比較すると、ベストな選択肢ではないにもかかわらず、いまだに使われているのです。
* ファビコンのSVGサポートがようやく改善され、SVGの人気は[今年](#ファビコン)WebPを追い越しました。

### ボタンと入力タイプ

{{ figure_markup(
  caption="少なくとも1つの `button` 要素を持つモバイルページのパーセンテージ。",
  content="65.5%",
  classes="big-number",
  sheets_gid="1883388700",
  sql_file="element_popularity.sql"
) }}

ボタンは賛否両論ある。何がウェブ上のボタンを構成し、何がボタンを構成しないかについて、多くの意見があります。私たちはどちらかの味方をするわけではありませんが、`button`要素を指定するセマンティックな方法をいくつか見てみようと思いました。

{{ figure_markup(
  image="buttons.png",
  caption="もっともポピュラーなボタンタイプです。",
  description="使用頻度の高いボタンの種類トップ5を棒グラフで表示したもの。もっとも人気のあるものは、ボタンタイプ、タイプなし、送信タイプです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=351242151&format=interactive",
  sheets_gid="1847095902",
  sql_file="buttons.sql"
) }}

[昨年](../2020/markup#button-and-input-types)と比較したところ、`button`要素のあるページがかなり増えていることがわかりました。今年は `input` 型のボタンに対するクエリは実行しませんでしたが、ページ上の `button` 要素の使用数は明らかに減少しています。[アクセシビリティの章](./accessibility)にもボタンに関するセクションがあるので、そちらも読んでみてください。

### リンク

<figure>
<table>
  <thead>
    <tr>
     <th>リンク</th>
     <th>デスクトップ</th>
     <th>モバイル</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>常に `target="_blank"` を `noopener` と `noreferrer` と共に使用する</td>
      <td class="numeric">22.0%</td>
      <td class="numeric">23.2%</td>
    </tr>
    <tr>
      <td>`target="_blank"` を `noopener` と `noreferrer` と一緒に使うことがある</td>
      <td class="numeric">78.0%</td>
      <td class="numeric">76.8%</td>
    </tr>
    <tr>
      <td>`target="_blank"`を持つ</td>
      <td class="numeric">81.2%</td>
      <td class="numeric">79.9%</td>
    </tr>
    <tr>
      <td>`target="_blank"` が `noopener` と `noreferrer` と共にある</td>
      <td class="numeric">14.3%</td>
      <td class="numeric">13.2%</td>
    </tr>
    <tr>
      <td>`noopener` で `target="_blank"` を持つ</td>
      <td class="numeric">21.2%</td>
      <td class="numeric">20.1%</td>
    </tr>
    <tr>
      <td>`target="_blank"` を `noreferrer` と共に持つ</td>
      <td class="numeric">1.2%</td>
      <td class="numeric">1.1%</td>
    </tr>
    <tr>
      <td>`target="_blank"` から `noopener` と `noreferrer` を取り除いたもの</td>
      <td class="numeric">71.1%</td>
      <td class="numeric">69.9%</td>
    </tr>
  </tbody>
</table>
  <figcaption>{{ figure_link(
    caption="リンク属性の様々な組み合わせの採用。",
    sheets_gid="1557885695",
    sql_file="wpt_bodies.sql"
  ) }}</figcaption>
</figure>

リンクはウェブを繋ぐ接着剤です。通常、私たちは、リンクが問題になっている事例を調べたいと考えています。`noopener` と `noreferrer` を使わずに `target="_blank"` を使うことは、長い間セキュリティ上の脆弱性でしたが、現在でもデスクトップページの71.1% とモバイルページの68.9% がこの方法を使用しています。

そのためか、今年になって <a hreflang="en" href="https://github.com/whatwg/html/issues/4078">仕様変更</a> が行われ、今ではブラウザはすべての `target="_blank"` リンクに `rel="noopener"` をデフォルトで設定するようになりました。

### Webマネタイズ

<a hreflang="en" href="https://discourse.wicg.io/t/proposal-web-monetization-a-new-revenue-model-for-the-web/3785">Web Monetization</a> は、<a hreflang="en" href="https://www.w3.org/community/wicg/">Web Platform Incubator Community Group</a> (WICG) でW3C標準として提案されています。これは、クリエイターへの報酬、APIコールへの支払い、重要なウェブインフラのサポートを、オープン、ネイティブ、効率的、かつ自動的に行うための歴史の浅い規格です。まだ初期段階にあり、主要なブラウザでは実装されていませんが、フォークや拡張機能でサポートされており、ChromiumやHTTP Archiveデータセットで1年以上前から組み込まれています。私たちは、これまでの採用状況を見てみたいと思いました。

{{ figure_markup(
  caption="Webマネタイズを利用しているモバイルページ数。",
  content="1,067",
  classes="big-number",
  sheets_gid="2034956621",
  sql_file="monetization.sql"
) }}

ウェブマネタイゼーションでは、一般的にページ上に `meta` 要素を使用し、支払われるお金のためのウォレットアドレスを指定します。ちょっとだけ似ていますね。

```html
<meta name="monetization" content="$wallet.example.com/alice">
```

{{ figure_markup(
  link="https://www.chromestatus.com/metrics/feature/timeline/popularity/3119",
  image="meta-monetization.png",
  caption='Webマネタイズの採用状況の推移。(出典 <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/3119">Chrome Status</a>)',
  description="現在、URLの0.02%程度であるWebマネタイズの採用が増加していることを示す棒グラフです。",
  width=600,
  height=278
) }}

割合からするとまだまだ小さい数字ですが、モバイルよりもデスクトップで伸びていることがわかります。HTTPアーカイブのデータセットがいかに大きいか、また、広くネイティブにサポートされている機能であっても、数を増やすのにいかに時間がかかるかを念頭に置いておくことが重要です。今後も時間をかけて、この数字や動向を追っていくのもおもしろいかもしれません。筆者はWeb Monetization標準の編集者として、偏見があるかもしれませんが、<a hreflang="en" href="https://webmonetization.org/docs/getting-started">試してみてください</a>、無料です。

しばらく前から <a hreflang="en" href="https://github.com/WICG/webmonetization/issues/19"> 問題が生じており</a>、新しいバージョンの仕様では <a hreflang="en" href="https://github.com/WICG/webmonetization/pull/193"> 代わりに `link` を使用します。</a> `link` バージョンが使われているのはデスクトップ セットで36ページ、モバイル セットで37ページのみで、それらすべてには `meta` バージョンも含まれていました。

現在、エコシステムには2つの<a hreflang="en" href="https://interledger.org/">Interledger</a>対応ウォレットプロバイダーがあることをわかっているので、それらのウォレットの分布と採用を確認したいと思いました。

{{ figure_markup(
  image="monetization-by-host.png",
  caption="もっとも人気のあるWebマネタイズホストです。",
  description="Webマネタイズされたページでの支払い指南に人気のあるウォレットプロバイダー上位5社を示した棒グラフです。Upholdが圧倒的に多く、86.3%のホストが利用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSaFU4lh2yyjudn8fcy0l65EbP9MdCbB39wQbT0c5cfcJzfl2p1nGOByDdgg8P3dMeZMa0eWkkG685n/pubchart?oid=659719076&format=interactive",
  sheets_gid="688333206",
  sql_file="monetization_by_host.sql"
) }}

UpholdとGatehubが現在のウォレットで、Upholdが圧倒的に優勢なようです。不思議なのは、今年非推奨となったウォレット「Stronghold」が、現役ウォレットプロバイダー「Gatehub」より人気があったことです。これは、Web開発者がWebサイトを更新するスピードの速さを物語っているのではないかと思いました。

## 結論

この章では、興味深いデータ、驚くようなデータ、気になるデータを指摘してきました。今一度、2021年のマークアップのあり方を振り返ってみよう。

私たちにとってもっとも驚きだったのは、約20年後でも、ウェブのかなりの部分でXHTMLが使われていて、2021年には7%強のページがXHTMLを使っていることでした。

2019年と比較すると2020年のページサイズの中央値は縮小していましたが、今年は2019年の中央値も上回り、トレンドが逆行したような印象です。ウェブが重くなっているのです。またもやです。

モバイルページでは、英語の人気が相対的に低くなっています。その理由は定かでありませんが、筆者はその理由の可能性を探ることをオススメしたいと思います。

より良いプラクティスを採用しているライブラリと、人気のない要素が直接的に相関しているのは興味深いことでした。 今年は、`i`と`option`の両方があまり使われていません。これは、アイコンライブラリがSVGの使用に切り替えたからです。

ICOがついにPNGに取って代わられ、もっとも人気のあるファビコン形式となったのは素晴らしいことです。同様に、SVGがこの1年でファビコンの使用量を2倍以上に増やしたのを見ると、PNGを追い抜くにはあと10年はかかると思われます。

`doctype`の比率は毎年半ポイントずつ着実に増えている。この調子でいけば、2027年にはすべてのページが`doctype`を持つという理想的な世界になることでしょう。

筆者が気になったのは、新しい規格の採用が遅く、時には10年周期になることもあること、Webページが思うように更新されないことです。

_それを踏まえて、2021年のウェブのあり方を考えてみたいと思います。また、毎年新しい規格の採用を増やしている人々の一員になることをオススメします。今日学んだ新しいこと、この章だけでなくこのWeb Almanacの出版物全体で取り上げた多くの標準のうちの1つから始めてみてください。_
