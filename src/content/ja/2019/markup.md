---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: マークアップ
description: 使われている要素、カスタム要素、価値、製品、及び一般的なユースケースについて抑えてある 2019 Web Almanac マークアップの章
hero_alt: Hero image of Web Almanac chracters as dressed as constructor workers putting togehter a web page from HTML element blocks.
authors: [bkardell]
reviewers: [zcorpan, tomhodgins, matthewp]
analysts: [rviscomi]
editors: [rviscomi]
translators: [MSakamaki]
discuss: 1758
results: https://docs.google.com/spreadsheets/d/1WnDKLar_0Btlt9UgT53Giy2229bpV4IM2D_v6OM_WzA/
bkardell_bio: Brian Kardellは、<a hreflang="en" href="https://igalia.com">Igalia</a> の開発者提唱者、標準化貢献者、<a hreflang="en" href="https://bkardell.com">ブロガー</a>であり、現在は <a hreflang="en" href="https://openjsf.org/">Open JS Foundation</a> の W3C 諮問委員会代表を務めています。彼はExtensible Web Community Groupの創設者であり、<a hreflang="en" href="https://extensiblewebmanifesto.org">The Extensible Web Manifesto</a> の共著者でもあります。
featured_quote: 2019年7月現在、HTTP Archiveは、約440万件のデスクトップホームページと約530万件のモバイルホームページについて、DOM内で使用されているすべての<em>要素</em>名の収集を開始しており、これにより調査と解剖を開始することができるようになりました。このクロールでは、これらのページで5,000以上の明確な<em>非標準要素名</em>に遭遇したので、私たちがカウントしている要素の合計の明確な数を「トップ」の5,048に制限しました。
featured_stat_1: 11
featured_stat_label_1: 90%以上のページで使用されている要素
featured_stat_2: 15%
featured_stat_label_2: 非推奨の要素を含むページ
featured_stat_3: 65
featured_stat_label_3: カルーセルのバリエーションが見つかりました
---

## 導入

2005年にIan "Hixie" Hicksonはこれまでの研究に基づいた<a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">マークアップデータの分析</a>を投稿しました。この作業のほとんどは、クラス名を調査して、内々で開発者が採用しているセマンティクスを確認し、標準化する意味があるかの確認をすることが目的でした。この研究の一部は、HTML5の新要素の参考として役に立ちました。

14年すぎて、新しい見方をする時が来ました。以降、[カスタム要素(Custom Elements)](https://developer.mozilla.org/docs/Web/Web_Components/Using_custom_elements)と<a hreflang="en" href="https://extensiblewebmanifesto.org/">Extensible Web Manifesto</a>の導入により、開発者は要素そのものの空間を探し、標準化団体が<a hreflang="en" href="https://bkardell.com/blog/Dropping-The-F-Bomb-On-Standards.html">辞書編集者のようになる</a>ことで、牛の通り道を舗装する(pave the cowpaths)よりよい方法を見つけることを推奨しています。様々なものに使われる可能性があるCSSクラス名とは異なり、非標準の*要素*は作成者が要素であることを意識しているため、さらに確実なものとなります。

2019年7月の時点で、HTTP Archiveは、約440万のデスクトップホームページと約530万のモバイルホームページのDOMで使用されているすべての*要素*名の収集を開始しました。 _([方法論](./methodology)の詳細を御覧ください)_

このクロールの結果、*5,000種類を超える非標準の要素*が検出されたため、計測する要素の合計数を「トップ」（以下で説明）5,048種類に制限しました。

## 方法論

各ページの要素の名前は、JavaScriptの初期化後DOMより収集されました。

現実の要素出現数を確認することは標準の要素であっても有用ではありません、検出されたすべての要素の約25%は`<div>`です。そして、約17%が`<a>`で、11%が`<span>`となっており、これらは10%以上を占める唯一の要素たちです。言語は<a hreflang="en" href="https://www.youtube.com/watch?v=fCn8zs912OE">一般的にこのようなもの</a>ですが、これと比較してみると驚くほど少ない用語が使われています。さらに、非標準の要素の取り込みを検討してみると、１つのサイトが特定の要素を1000回も使用しているために、とても人気があるように見えてしまい、大きな誤解を招く可能性があります。

そのような方法を取らず、私達はHixieの元の研究のようにホームページに各要素が少なくとも1回は含まれているサイトの数に着目しました。

<p class="note">注意: この方法は潜在的なバイアスが無いとは言い切れません。人気のある製品は複数のサイトで使われています。これにより個々の作成者は意識していない非標準のマークアップが導入されるでしょう。したがって、この方法は一般的なニーズに対応するのと同じように、作成者の直接的な知識や意識的な採用を意味しないことに注意する必要があります。調査中に、このような例はいくつか見つかりました。</p>

## 上位の要素と概説

2005年、Hixieはページ中に最もよく使用されていて、頻度の少ない上位要素を調査しました。トップ３は `html`、`head`、`body`でした、これらはオプションなので省略されてもパーサーによって作成されており、彼は興味深いと述べています。パーサーによる解析後のDOMを使って調査すると、データは普遍的に表示されます。なので、４番目に使用頻度の高い要素からはじめました。以下は、その時点から現在までのデータの比較です。(ここでは面白いので出現数を含めました)

<figure>
  <table>
    <thead>
      <tr>
        <th>2005 (サイト毎)</th>
        <th>2019 (サイト毎)</th>
        <th>2019 (出現数)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>title</td>
        <td>title</td>
        <td>div</td>
      </tr>
      <tr>
        <td>a</td>
        <td>meta</td>
        <td>a</td>
      </tr>
      <tr>
        <td>img</td>
        <td>a</td>
        <td>span</td>
      </tr>
      <tr>
        <td>meta</td>
        <td>div</td>
        <td>li</td>
      </tr>
      <tr>
        <td>br</td>
        <td>link</td>
        <td>img</td>
      </tr>
      <tr>
        <td>table</td>
        <td>script</td>
        <td>script</td>
      </tr>
      <tr>
        <td>td</td>
        <td>img</td>
        <td>p</td>
      </tr>
      <tr>
        <td>tr</td>
        <td>span</td>
        <td>option</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="2005年から2019年までの上位要素の比較。") }}</figcaption>
</figure>

### ページ毎の要素

{{ figure_markup(
  image="hixie_elements_per_page.png",
  caption="Hixieによる2005年の要素頻度の分布。",
  description="要素数が増加するにつれて相対頻度の分布が減少することを示すグラフ",
  width=600,
  height=318
  )
}}

{{ figure_markup(
  image="fig3.png",
  caption="2019年の要素頻度。",
  description="約2,500ページからなるグラフは、約30個の要素から開始します。そして2,000個の要素を含む327ページまで直線的に追従する前の283個の要素を持つ6,876ページあたりでピークに達します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=2141583176&format=interactive"
  )
}}

図3.2の2005年のHixieのレポートと図3.3の最新データを比較すると、DOMツリーの平均サイズが大きくなっていることがわかります。

{{ figure_markup(
  image="hixie_element_types_per_page.png",
  caption="2005年にHixieが分析したページ毎の要素タイプのヒストグラム。",
  description="相対周波数が19個の要素点の周りで釣鐘曲線となっていることを示すグラフ",
  width=600,
  height=320
  )
}}

{{ figure_markup(
  image="fig5.png",
  caption="2019年時点でのページ毎の要素タイプのヒストグラム。",
  description="308,168,000のサイトで使用されている平均要素数を示すグラフは、マークされた30個の要素の周りで釣鐘曲線になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1500675289&format=interactive"
  )
}}

ページあたりの要素の種類の平均数と、ユニークな要素数の最大値の両方が増加していることがわかります。

## カスタム要素

記録された要素のほとんどはカスタム（単純に「非標準」となる物）でした。しかし、どの要素がカスタムであるか、カスタムではないかを議論するのは少し面倒です。実際にかなりの数の要素が仕様や提案のどこかに書かれています。今回、244個の要素を標準として検討しました。（ただし、一部は非推奨またはサポート対象外のものです）

* 145個のHTML要素
* 68個のSVG要素
* 31個のMathML要素

実際は、これらのうち214だけに遭遇しました。

* 137個のHTML要素
* 54個のSVG要素
* 23個のMathML要素

デスクトップのデータセットでは、検出された4,834個の非標準要素のデータを収集しました。次がそれに当たります。

* 155個（3％）は、非常に高い確率でマークアップまたはエスケープの例外として識別できます（解析されたタグ名にマークアップが破損していることを暗示する文字が含まれていました）
* 341個（7％）はXMLスタイルのコロン名前空間を使っています（ただし、HTMLとしてはXML名前空間は使っていません）
* 3,207個（66％）は有効なカスタム要素の名前です
* 1,211個（25％）はグローバルな名前空間にあります（非標準であり、ダッシュもコロンもありません）
    * うち、216個は2文字以上で、`<cript>`、`<spsn>`または`<artice>`などの標準要素名からレーベンシュタイン距離が1であるため、タイプミスの*可能性*としてフラグを立てました。ただし、これらの一部（ `<jdiv>`など）には意図的なものも含まれています。

付け加えると、デスクトップページの15％とモバイルページの16％には、既に廃止された要素が含まれています。

<p class="note">注意：この結果は、それぞれのの作成者がマークアップを手動で作成しているのではなく、何らかの製品を使っている為と考えられます。</p>

{{ figure_markup(
  image="fig6.png",
  caption="最も頻繁に使われている非推奨の要素。",
  description="デスクトップの8.31％（モバイルの7.96％）で使用中の「center」、デスクトップサイトの8.01％（モバイルの7.38％）で使用中の「font」、デスクトップサイトの1.07％（モバイルの1.20％）で使用中の「marquee」 、デスクトップサイトの0.71％（モバイルの0.55％）で使用中の「nobr」、デスクトップサイトの0.53％（モバイルの0.47％）で使用中の「big」、デスクトップサイトの0.39%（モバイルの0.35％）で使用中の「frameset」、デスクトップサイトの0.39％（モバイルの0.35％）による「frame」の使用、デスクトップサイトの0.33％（モバイルの0.27％）による「strike」、デスクトップサイトの0.25％（モバイルの0.27％）で使用中の「noframes」を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1304237557&format=interactive"
  )
}}

上記の図3.6は、最も頻繁に使われている非推奨の要素トップ10を表しています。これらは非常に小さな数値に見えますが、この観点は重要です。

## 価値観と使用法

要素の使い方に関する数値（標準、非推奨、またはカスタム）を議論する為には、まず何らかの観点を確立する必要があります。

{{ figure_markup(
  image="fig7_full.png",
  caption='トップ150の要素（<a hreflang="en" href="/static/images/2019/markup/fig7_full.png">詳細</a>）。',
  description="使用される要素を減少の割合で降順で並べた棒グラフ：html、head、body、titleは使用率99％を超えるています、meta、a、divは98％を超える使用率です、link、script、img、spanが90％を超 えています、ul、li、p、style、input、br、formなどが70%を超えています、h2、h1、iframe、h3、button、footer、header、navは50％を超えています、50％未満からほぼ0％に低下するその他のあまり知られていないタグもあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1694360298&format=interactive",
  width=600,
  height=778,
  data_width=600,
  data_height=778
  )
}}

上記の図3.7は、ページ中に現れたかどうかでカウントされた要素のトップ150を表示しています。利用率がどのように落ちていくかに着目してください。

ページの90%以上で使われている要素は11個しかありません。

- `<html>`
- `<head>`
- `<body>`
- `<title>`
- `<meta>`
- `<a>`
- `<div>`
- `<link>`
- `<script>`
- `<img>`
- `<span>`

上を除き、ページ中50％以上使われている要素は15個だけです。

- `<ul>`
- `<li>`
- `<p>`
- `<style>`
- `<input>`
- `<br>`
- `<form>`
- `<h2>`
- `<h1>`
- `<iframe>`
- `<h3>`
- `<button>`
- `<footer>`
- `<header>`
- `<nav>`

また、ページ中に5％以上使われている要素は40個のみでした。

`<video>`でさえ、ぎりぎりその範囲内に収まっていません。デスクトップデータセット内の4％という結果で現れています（モバイルでは3％）。この数字はとても低いように聞こえますが、実のところ4％はかなり人気だったりします。事実、ページ中1％以上の要素は98個しかありません。

これらの要素の分布を抑え、どの要素が1％以上使われているのかを見るのは興味深いことです。

{{ figure_markup(
  link="https://rainy-periwinkle.glitch.me/scatter/html",
  image="element_categories.png",
  caption="標準化によって人気になった要素の分類。",
  description="HTML、SVG、Math MLを示す散布図は比較的少数のタグを使用しますが、非標準要素（「in global ns」、「dasherized」、「colon」に分けられる）ははるかに広がっています。",
  width=600,
  height=1065
  )
}}

図3.8は、各要素の順位とそれらがどのカテゴリに属するかを示しています。データポイントを単純に見ることができるように、個別の塊へ分割しました（そうしなければ、全データを表現するために十分なピクセル領域がありませんでした）、これは人気を一つの「線」として表します。一番下が最も一般的で、上が一般的では無いものです。矢印は、ページの1％以上に表示される要素の終端を指しています。

ここでは2つのことを確認できます。まず、使用率が1％を超える要素の塊は、HTMLだけではありません。実際、*最も人気のある100個の要素のうち27個はHTMLではなく*SVGです！ さらに、*その隙間または近くには非標準のタグもあります*！そして多くのHTML要素がページ毎に1％未満として現れている事に注意してください。

では、これらのページで1％の利用率となっている要素はすべて無駄ですか？、いいえ絶対にあえりえません。これが視点を確立することが重要な理由です。Webには約20億のWebサイトがあります。データセットのすべてのWebサイトの0.1％に何かが表示される時、これはWeb全体で*約200万のWebサイト*を表していると推定できます。0.01％でさえ_20万のサイト_を推定できます。これは、良い思想では無い古い要素であったとしても、めったに要素のサポートを打ち切らない理由でもあります。数十万または数百万のサイトを壊すことは、ブラウザベンダーが簡単にできることではありません。

ほとんどの要素は、ネイティブの物も含めてページの1％未満として現れていますが、それでも非常に重要であり成功しています。たとえば`<code>`は私が頻繁に使用する要素です。 これは間違いなく便利で重要ですが、ページの0.57％でしか使われていません。この部分は私達の測定対象に基づいているため偏っています。通常、ホームページは特定の種類のもの（たとえば`<code>` など）が含まれる可能性は低いでしょう。例えば、ホームページでは見出し、段落、リンク、リスト以外はあまり一般的ではないでしょう。ただし、データには一般的に価値があります。

また、著者が定義した（ネイティブではない）`.shadowRoot`を含むページに関する情報も収集しました。デスクトップページの約0.22％とモバイルページの約0.15％にシャドウルートが確認できています。数が少ないように聞こえるかもしれませんが、これはモバイルデータセット内の約6.5kサイトとデスクトップ上の10kサイトであり、いくつかのHTML要素よりも多くなっています。たとえば、`<summary>` はデスクトップ上で同レベルで利用されており、146番目に人気のある要素です。`<datalist>` はホームページの0.04％に使われており、201番目に人気のある要素です。

実際、HTMLで定義されている要素の15％以上は、デスクトップデータセットのトップ200から圏外です。`<meter>`は、HTMLがLiving Standardモデルに移行する前、2004-2011頃の最も人気のない「HTML5時代」の要素です。そしてこの要素の人気は1,000番目です。最近導入された要素（2016年4月）である`<slot>`の人気は1,400番目となっています。

## 大量データ：実際のWeb上の実際のDOM

データセット中のネイティブ/標準機能をどのように使っているかと言う観点を念頭に置いて、非標準のものについて話しましょう。

測定したほとんどの要素は単一のWebページでのみ使用されると思われるかもしれませんが、実際には5,048個の要素すべてが複数のページに出現しています。データセット中、最も出現数が少ない要素は15ページに存在しています。そして、約5分の1は100ページ以上に存在します。約7％は1,000ページ以上に存在します。

データ分析を支援するために<a hreflang="en" href="https://rainy-periwinkle.glitch.me">Glitchで小さなツール</a>を共同で作りました。このツールはあなたも使うことができます。そして、あなたの観測した内容をパーマリンクと共に[@HTTPArchive](https://x.com/HTTPArchive)へシェアしてください。（Tommy Hodginsは、同じように洞察に使える<a hreflang="en" href="https://github.com/tomhodgins/hade">CLIツール</a>を作成しています。）

それでは、いくつかのデータを見ていきましょう。

### 製品（およびライブラリ）とそのカスタムマークアップ

いくつかの標準でない要素の普及率については、ファーストパーティの採用をしたというより、人気のあるサードパーティのツールに含まれていることが関係しているでしょう。たとえば `<fb:like>` 要素は0.03%のページで見つかります。これはサイト所有者が意図的に記述しているのではなく、Facebookウィジェットに含まれているためです。<a hreflang="en" href="https://web.archive.org/web/20060203031245/http://code.google.com/webstats/2005-12/editors.html">Hixieが14年前に言及した</a>要素のほとんどは減少しているように見えますが、大部分が残っています。

- [Claris Home Page](https://en.wikipedia.org/wiki/Claris_Home_Page)（最後の安定版は21年前）で作られた一般的要素は、100ページ以上に*まだ*現れてます。 たとえば、<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/28b0b7abb3980af793a2f63b484e7815365b91c04ae625dd4170389cc1ab0a52.html">`<x-claris-window>`</a>は130ページに現れています。
- 英国のeコマースプロバイダーである<a hreflang="en" href="https://www.oxatis.co.uk">Oxatis</a>の`<actinic:*>` 要素の一部はさらに多くのページに出現しています。たとえば、<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/30dfca0fde9fad9b2ec58b12cb2b0271a272fb5c8970cd40e316adc728a09d19.html">`<actinic:basehref>`</a>はデスクトップデータ中の154ページに出現しています。
- Macromediaの要素はほとんど消えたようです。一覧にはたった一つの要素`<mm:endlock>`だけが現れており、その数はわずか22ページだけです。
- Adobe Go-Liveの<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html">`<csscriptdict>`</a>は、デスクトップデータセットの640ページに引き続いて現れています。
- Microsoft Officeの<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html">`<o:p>`</a>要素は、2万ページ以上のデスクトップページとなる0.5％に引き続いて現れています。

そして、Hixieのオリジナルレポートにはなかった多くの新しい要素も現れました。

- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/e8bf0130c4f29b28a97b3c525c09a9a423c31c0c813ae0bd1f227bd74ddec03d.html">`<ym-measure>`</a>は、Yandexの<a hreflang="en" href="https://www.npmjs.com/package/yandex-metrica-watch">Metrica analytics package</a>によって挿入されるタグです。デスクトップとモバイルページの1％以上で使われており、最も利用されている要素トップ100でその地位を確立しています。すごい！
- 今は亡きGoogle Plusの<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/a532f18bbfd1b565b460776a64fa9a2cdd1aa4cd2ae0d37eb2facc02bfacb40c.html">`<g:plusone>`</a>は、2万1千ページ以上で出現しています。
- Facebookの<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/2e2f63858f7715ef84d28625344066480365adba8da8e6ca1a00dfdde105669a.html">`<fb:like>`</a>は、14,000のモバイルページで出現しています。
- 同様に、<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/5a964079ac2a3ec1b4f552503addd406d02ec4ddb4955e61f54971c27b461984.html">`<fb:like-box>`</a>は7.8kモバイルページで出現しています。
- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/6997d689f56fe77e5ce345cfb570adbd42d802393f4cc175a1b974833a0e3cb5.html">`<app-root>`</a>は、Angularなどのフレームワークで一般的に含まれており、8.2kモバイルページに出現しています。

これらを5％未満のネイティブHTML要素と比べてみましょう。

{{ figure_markup(
  image="fig9.png",
  caption="採用率が5％以下での、製品固有とネイティブで人気の要素。",
  description="videoは184,149サイト、canvasは108,355、ym-measure（製品固有のタグ）は52,146、コードは25,075、g:plusone（製品固有のタグ）は21,098、fb:like（製品固有のタグ）は12,773、fb:like-box（製品固有のタグ）は6,792、app-root（製品固有のタグ）は8,468、summaryは6,578、templateは5,913、meterは0を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=962404708&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

このような興味深い洞察を一日中行うことができます。

これは少々違うものですが、人気のある要素には製品のエラーによって引き起こされる可能性もあります。たとえば1,000を超えるサイトで`<pclass="ddc-font-size-large">` が出現しています。しかしこれは、これは人気のある"as-a-service"製品がスペースを取り忘れているために発生していました。幸いなことに、このエラーは調査中に報告されて、すぐに修正されました。

Hixieはオリジナルの論文で次のように述べています。

<blockquote>この非標準マークアップに対して楽天的でいられる間は少なくとも、これらの要素にはベンダープレフィックスを明確に利用しているため、これは良い考えだと言えます。これにより、標準化団体が新しく作る要素と属性が、それらと衝突する可能性を大幅に減らすことができます。</blockquote>

ただし、上で述べた通りこれは一般的ではありません。記録できた非標準要素の25％以上は、グローバル名前空間の汚染を避けるために、いかなる名前空間戦略も使っていません。例えば、<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/53567ec94b328de965eb821010b8b5935b0e0ba316e833267dc04f1fb3b53bd5.html">モバイルデータセットにある1157個の要素一覧</a>を表示します。見ての通り、これらの多くは曖昧な名前やつづりの間違など、問題がない可能性があります。しかし、少なくともこれはいくつかの挑むべき課題を示しています。例えば、 `<toast>`（Google社員が`<std-toast>`として最近<a hreflang="en" href="https://www.chromestatus.com/feature/5674896879255552">提案しようとした仕様</a>）がこの一覧に含まれています。

それほど難しくない一般的な要素もいくつかあります。

- Yahoo Mapsの<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/2ba66fb067dce29ecca276201c37e01aa7fe7c191e6be9f36dd59224f9a36e16.html">`<ymaps>`</a>は、〜12.5kのモバイルページに出現します。
- 2008年のフォント置換ライブラリである<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/5cfe2db53aadf5049e32cf7db0f7f6d8d2f1d4926d06467d9bdcd0842d943a17.html">`<cufon>`と `<cufontext>`</a>は、〜10.5kモバイルページに出現しています。
- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/976b0cf78c73d125644d347be9e93e51d3a9112e31a283259c35942bda06e989.html">`<jdiv>`</a>要素は、Jivo chatの製品によって挿入されており、〜40.3kモバイルページに出現しています。

前回のチャートに今回のデータを配置すると、次のようになります（改めて、データセットに基づいて少しだけ変わっています）

{{ figure_markup(
  image="fig10.png",
  caption="採用率が5％以下での、製品固有のコンテキストまたはネイティブで人気のあるその他の要素。",
  description="videoは184,149サイトで使用され、canvasは108,355、ym-measureは52,416、codeは25,075、g:plusoneは21,098、db:likeは12,773、cufonは10,523、ymapsは8,303、fb:like-boxは6,972、app-rootが8,468、summaryが6,578、templateが5,913、meterが0を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=468373762&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

この結果には興味深い点があります、それは一つのツールが他の便利になる手段も提供していると言うことです。データ空間を調べることに興味がある場合に、具体的なタグ名は想定される尺度の一つでしかありません。良い「俗語」の発展を見つけることができれば、それは間違いなく最強の指標でしょう。しかし、それが私たちの興味の範囲外である場合はどうなりますか？

### 一般的なユースケースとソリューション

たとえば、一般的なユースケースの解決に興味が人々の場合はどうでしょうか？これは、現在抱えているユースケースに対応したソリューションを探している場合や、標準化を促進するために人々が解決しようとしている一般的なユースケースをさらに研究するようなものがあります。一般的な例として「タブ」を取り上げます。長年にわたって、タブのようなものに対して多くの要求がありました。あいまいな検索をしてみると<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/c6d39f24d61d811b55fc032806cade9f0be437dcb2f5735a4291adb04aa7a0ea.html">タブには多くのバリエーション</a>があることがわかります。同一のページに2つの要素が存在しているかを簡単に識別できないため、利用されているかどうかを数えるのは少し難しくなります。そのためこの計測条件は地味ですが、最大のカウントを持つものを単純に使用します。ほとんどの場合、実際のページ数はそれより大幅に増えるでしょう。

また、数多くの<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/e573cf279bf1d2f0f98a90f0d7e507ac8dbd3e570336b20c6befc9370146220b.html">アコーディオン</a>や<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/0bb74b808e7850a441fc9b93b61abf053efc28f05e0a1bc2382937e3b78695d9.html">ダイアログ</a>、少なくとも65種類の<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/651e592cb2957c14cdb43d6610b6acf696272b2fbd0d58a74c283e5ad4c79a12.html">カルーセル</a>、それと<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/981967b19a9346ac466482c51b35c49fc1c1cc66177ede440ab3ee51a7912187.html">ポップアップ</a>に関するもの、そして最低でも27種類存在する<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/2e6827af7c9d2530cb3d2f39a3f904091c523c2ead14daccd4a41428f34da5e8.html">トグルとスイッチ</a>があります。

おそらくですが、<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/5ae67c941395ca3125e42909c2c3881e27cb49cfa9aaf1cf59471e3779435339.html">非ネイティブである92種類のボタン要素</a>が必要な理由を調査することで、ネイティブとのギャップを埋めようとすることができます。

人気の有るものがポップアップ（`<jdiv>`などのチャット）という事に気付く事ができれば 、私達の知っている知識（たとえば、`<jdiv>`についての目的や`<olark>`）を知り、<a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/db8fc0e58d2d46d2e2a251ed13e3daab39eba864e46d14d69cc114ab5d684b00.html">それらに取り組むために作り上げた43のこと</a>を見て、そこを辿りながら空間を調査することができます。

## 結論

なのでここには多くのデータがありますが、要約すると。

* ページ中の要素は、14年前よりも平均と最大の両方で増えています。
* ホームページ上に存在する要素の寿命は*非常に*長いでしょう。要素を非推奨やサポート停止にしたとしても、消えることはありません。
* 世の中には多くの壊れたマークアップがあります。（タグのつづり間違い、スペースの抜け、エスケープ間違い、誤解）
* 「有益」である事を測定するのは難しいでしょう。多くのネイティブ要素は5％の敷居、さらには1％敷居を超えることはありませんが、多くのカスタム要素は多くの理由でその敷居を越えます。少なくとも1%を超えたものには注目をするべきかもしれませんが、データを見る限りは割と*良い*成功を収めているようなので、おそらく0.5％とすべきでしょう。
* 既に大量のカスタムマークアップがあります。様々な形式がありますが、ダッシュを含む要素は確実に削除されたようです。
* 牛の通り道を舗装する(pave the cowpaths)ために、このデータをさらに調査して、適切な観測結果を出す必要があります。

最後はあなたの出番です。大規模なコミュニティの創造性と好奇心を利用し、いくつかのツール(<a hreflang="en" href="https://rainy-periwinkle.glitch.me/">https://rainy-periwinkle.glitch.me/</a>など)を使うことでこのデータを探索することができます。興味深い観察結果を共有して、知識と理解の共有の場を作ってください。
