---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: 2021年版Web AlmanacのCSSの章では、Web上でのCSSの使用に関するトレンド、変化、パターンを取り上げています。
authors: [meyerweb, GeekBoySupreme]
reviewers: [svgeesus, j9t, estelle, bkardell, argyleink, LeaVerou]
analysts: [rviscomi]
editors: [shantsis]
translators: [ksakae1216]
meyerweb_bio: Eric A. Meyerは、burger flipper、hardware jockey、大学のウェブマスター、初期のブロガー、オリジナルの<a hreflang="en" href="https://archive.webstandards.org/css/members.html">CSS Samurai</a>の一人、[CSS Working Group](https://en.wikipedia.org/wiki/CSS_Working_group)のメンバー、コンサルタントとトレーナー、そして[Netscape](https://ja.wikipedia.org/wiki/%E3%83%8D%E3%83%83%E3%83%88%E3%82%B9%E3%82%B1%E3%83%BC%E3%83%97%E3%82%B3%E3%83%9F%E3%83%A5%E3%83%8B%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%BA)のスタンダード・エバンジェリストとして活躍してきました。現在は、<a hreflang="en" href="http://igalia.com/">Igalia</a>のDeveloper Advocateであり、<a hreflang="en" href="https://aneventapart.com/">An Event Apart</a>の共同創始者である<a hreflang="en" href="http://zeldman.com/">Jeffrey Zeldman</a>と共に活動しています。中でもEricは、<cite><a hreflang="en" href="https://abookapart.com/products/design-for-real-life">Design For Real Life</a></cite>を<a hreflang="en" href="https://sarawb.com">Sara Wachter-Boettcher</a>と<a hreflang="en" href="https://abookapart.com/">A Book Apart</a>のために共同執筆し、<cite><a hreflang="en" href="http://meyerweb.com/eric/books/css-tdg/">CSS&colon; The Definitive Guide</a></cite>と、<a hreflang="en" href="http://standardista.com/">Estelle Weyl</a>が<a hreflang="en" href="https://oreilly.com/">O'Reilly</a> また、初の公式な<a hreflang="en" href="http://w3.org/">W3C</a>テストスイートを作成し、<a hreflang="en" href="http://microformats.org/">microformats</a>の作成を支援しました。
GeekBoySupreme_bio: Shuvamはデザイナーであり、<a hreflang="en" href="https://www.behance.net/shuvammanna">doodler</a>、<a hreflang="en" href="https://distortedaura.wordpress.com/">writer</a>、<a hreflang="en" href="https://www.instagram.com/the_distorted_aura/">shutterbug</a>であり、<a hreflang="en" href="https://github.com/GeekBoySupreme">software tinker</a>でもあります。現在は、<a hreflang="en" href="https://deepsource.io">DeepSource</a>でデザインをしたり、Indie-Hackingで、<a hreflang="en" href="https://doneth.space">Doneth</a>のようなプロジェクトに取り組み、コンピュータが人間とどのように相互作用するかの荒削りな部分を探求しています。
results: https://docs.google.com/spreadsheets/d/12vQIA0xsC5Jr3J9Sh03AcAvgFjMAmP1xSS6Tjai9LF0/
featured_quote: 2021年版Web Almanacでは、私たちが必要だと思っているものと、実際に制作現場で目にするものとでは、CSSの使い方がどのように違うのかをより深く理解することができます。
featured_stat_1: 71%
featured_stat_label_1: 何らかのレイアウトにFlexboxを使用しているページの割合
featured_stat_2: 3
featured_stat_label_2: CSSで読み込まれた画像の数の中央値
featured_stat_3: 29%
featured_stat_label_3: カスタムプロパティを使用しているページの割合。
---

## 序章

CSS（Cascading Style Sheets）は、ウェブ上のページを構築するための3本柱のひとつで、構造を定義するためのHTML、動作やインタラクションを指定するためのJavaScriptと合わせて、三位一体となっています。

2021年版のWeb Almanacでは、前回と比較して、CSSの使い方が「必要だと思うもの」「実際に制作現場で目にするもの」の領域でどのように異なるかをより深く理解できます。CSSの機能をより強固にすることや、CSSで`<div>`を中央に配置することへの挑戦がブログやカンファレンスでの発言、Twitterでの発言などで話題になっていましたが、ウェブ上のページでは、まったく相反する結果が示されていました。これはCSSが十分な年齢になったことで、奇抜なおもちゃに、夢中になるのではなく、安定した状態を維持することに重きを置くようになったという事実を裏付けています。

CSS-in-JSの採用は、クロールされた全ページの3％（昨年比1パーセントポイント増）にまで増加しましたが、最先端のHoudiniの機能は、まだほとんどがチュートリアルやサンプルギャラリーに限られています。レスポンシブ対応は、引き続きもっとも関心の高い優先事項の1つであり、`max-width`と`min-width`はトップのメディアクエリであり、「calc()」は幅を決定するためにもっともよく使用されるCSS関数です。

ユーザーがウェブに集まり続ける中、第二の故郷、ワークスペース、ガレージ、ウサギの穴のような場所であるインターネットを、私たちがどのように描いてきたのかを知るためのデータに飛び込んでみましょう。

## 使用方法

{{ figure_markup(
  image="stylesheet-transfer-size.png",
  caption="ページごとのスタイルシート転送サイズの分布",
  description="1ページのスタイルシートの総重量の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図。数値は以下の通りです。10パーセンタイルは、デスクトップでKB、モバイルで6KB。25パーセンタイルでは、デスクトップが31KB、モバイルが27KB。50パーセンタイル、デスクトップが71KB、モバイルが66KB。75パーセンタイル、デスクトップ142KB、モバイル135KB。90パーセンタイル、デスクトップ257KB、モバイル250KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=900703452&format=interactive",
  sheets_gid="350963758",
  sql_file="stylesheet_kbytes.sql"
) }}

CSSはほとんどのページでもっとも重いコンポーネントではありませんが、ウェブの他の部分と同様に、年々そのサイズは増加し続けています。ウェブページの中央値では約7KBのCSSがロードされ、上限値では平均4分のMB強となっています。2020年と比較すると、CSSの総重量の中央値は約7.9％増加し、90パーセンタイルは7％弱増加していますが、すべてのパーセンタイルでモバイルCSSがデスクトップCSSよりも少し小さいという昨年のパターンは維持されています。

すべてのページがこのような制約を受けたわけではありません。最大のCSSウエイトを持つページでは、64,628KBの負荷がかかりました。それに比べて、モバイル用の最大のCSSウェイトはわずか17,823KBと、非常にスリムな印象を受けます。

2020年と同様に、ページの重さはプリプロセッサーによって大きく左右されないことがわかりました。デスクトップページの17％、モバイルページの16.5％がソースマップを含んでおり、昨年の15％からわずかに増加しました。ソースマップを含むCSSのシェアが一貫しているのは、ソースマップのシェアが、ソースマップの採用よりもビルドツールの使用によるものであることを示しているように思われます。

どのようなソースマップが使われているかについては、昨年とほぼ同様の結果となりました。

<figure>
  <table>
   <thead>
    <tr>
      <th>ソースマップの種類</th>
      <th>2020</th>
      <th>2021</th>
    </tr>
   </thead>
   <tbody>
    <tr>
      <td>CSSファイル</td>
      <td class="numeric">45%</td>
      <td class="numeric">45%</td>
    </tr>
    <tr>
      <td>Sass</td>
      <td class="numeric">34%</td>
      <td class="numeric">37%</td>
    </tr>
    <tr>
      <td>Less</td>
      <td class="numeric">21%</td>
      <td class="numeric">17%</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="2021年と2020年のソースマップの種類。",
   sheets_gid="945827671",
   sql_file="sourcemap_adoption.sql"
  ) }}</figcaption>
</figure>

これは、SassがLessに比べて優位に立ち続けている証拠とも言えますが、その変化は非常に小さいため、統計的にもそうでなくても、有意であると言うのは難しいでしょう。いつものように、時間が解決してくれるでしょう。

{{ figure_markup(
  image="stylesheets-per-page.png",
  caption="ページあたりのスタイルシート数の分布。",
  description="ページごとに読み込まれるスタイルシートの総数の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図です。その結果は以下の通りです。10パーセンタイルは、デスクトップ用スタイルシート1枚、モバイル用スタイルシート1枚。25パーセンタイルは、デスクトップとモバイルの両方で3枚。50パーセンタイル、デスクトップ用に7枚、モバイル用に6枚。75パーセンタイル、デスクトップとモバイルの両方で13枚。90パーセンタイル、デスクトップとモバイルの両方で22枚です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1775427809&format=interactive",
  sheets_gid="751625680",
  sql_file="stylesheet_count.sql"
) }}

埋め込み型、外部型を問わず、1ページあたりのスタイルシート数の平均は、昨年よりもわずかに増加しています。50パーセンタイルから90パーセンタイルまではそれぞれ1つずつ増加しましたが、10パーセンタイルと25パーセンタイルは変化がありませんでした。

{{ figure_markup(
  caption="ページで読み込まれる外部スタイルシートの最大数です。",
  content="2,368",
  classes="big-number",
  sheets_gid="751625680",
  sql_file="stylesheet_count.sql"
) }}

信じられないことに、外部スタイルシートの数がもっとも多い今年の記録は、昨年の記録をほぼ2倍上回っています。2020年の1,379に対して2,368です。これを行った人は誰でも、いくつかのファイルを組み合わせてサーバーを休ませてください。

{{ figure_markup(
  image="rules-per-page.png",
  caption="ページごとのスタイルルールの総数の分布。",
  description="CSSルールの総数に対する10％、25、50、75、90パーセンタイルの中央値を示したペアの列挙図です。その結果は以下の通りです。10パーセンタイルは、デスクトップで17ルール、モバイルで15ルール。25パーセンタイルは、デスクトップで145ルール、モバイルで152ルール。50パーセンタイル、デスクトップが512、モバイルが483。75パーセンタイル、デスクトップ：1,078、モバイル：1,063。90パーセンタイル、デスクトップが1,841、モバイルが1,821です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=472863207&format=interactive",
  sheets_gid="697775839",
  sql_file="selectors.sql"
) }}

スタイルシートの数は重要ですが、実際のスタイルルールの数はどうでしょうか？　昨年と比較すると、下位のパーセンタイルは少し増加していますが、上位のパーセンタイルはほとんど変化していません。2021年と2020年で異なるのは、ほぼすべてのパーセンタイルにおいて、デスクトップページの方がモバイルページよりも平均してルール数が多いということです。

## セレクターとカスケード

カスケードを理解することは、CSSを扱う上で非常に重要なことです。とくに、ある要素に書いたスタイルがまったく機能していない場合には、なおさらです。

CSSには、クラス、ID、そしてスタイルの重複を避けるために重要なカスケードを使用するなど、ページにスタイルを適用するためのさまざまな方法があります。

### クラス名

{{ figure_markup(
  image="most-popular-class-names.png",
  caption="もっとも人気のあるクラス名。",
  description="もっとも人気があるクラス名を示したグラフで、モバイルでのシェア率を示しています。デスクトップ用のバーは、すべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りで、値は与えられたクラス名を含む全ページの割合を示しています。`active` 42％; `fa` 32％; `fa-*` 32％、`pull-right` 29％、`pull-left` 28％、`disabled` 24％、`selected` 22％、`button` 22％、`container` 20％、`wp-*` 20％、`sr-only` 20％、`title` 20％、`btn` 19％、`sr-only-focusable` 19％、`clearfix` 17％、`current` 16％、`right` 16％、`rtl` 15％、`widget` 15％、`row` 15％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1533988979&format=interactive",
  width=600,
  height=691,
  sheets_gid="982850647",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}

昨年同様、もっとも人気のあるクラス名は `active` で、`fa`、`fa-*`（Font Awesomeのプレフィックス）、`wp-*`（WordPressのプレフィックス）のクラス名が非常に強い印象を与えています。`selected`と`disabled`は昨年と比べて順位が入れ替わっていますが、もっとも心強い変化は`clearfix`が5％減少したことで、フロートベースのレイアウトが衰退し続けていることを示しています。

また、Bootstrapのアクセシビリティ機能である`sr-only-focusable`が配置されているのも心強いですね。これはBootstrapのアクセシビリティ機能で、要素を画面外に配置しても、スクリーンリーダーがアクセスできるようにするものです。

### ID

{{ figure_markup(
  image="most-popular-id-names.png",
  caption="もっとも人気のあるID名。",
  description="もっとも人気があるID名を示したグラフで、モバイルでのシェア率を示しています。デスクトップ用のバーは、すべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りで、値は指定されたID名を含む全ページの割合を示しています: `content` 14％、`footer` 11％、`header` 10％、`logo` 7％、`rc-imageselect` 7％、`comments` 7％、`main` 7％、`rc-anchor-alert` 7％、`rc-anchor-over-quota` 7％、`rc-anchor-invisible-over` 7％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=609865919&format=interactive",
  width=600,
  height=497,
  sheets_gid="289906540",
  sql_file="top_selector_ids.sql"
) }}

ページは引き続きIDを使用しており、その割合は2020年に見られたものとほぼ同じです。人気のあるID名のリストも一貫しています。"content"が約14％でトップに立ち、"footer"と "header"がそれに続きます。後者の2つのIDは、昨年に比べて約1％減少していますが、これだけで決定的なことは言えず、開発者は可能な限り対応するHTML要素の`<header>`と`<footer>`に置き換えるべきでしょう。

`rc-`で始まるIDは、GoogleのreCAPTCHAシステムの一部であり、そのほとんどのバージョンは、<a hreflang="en" href="https://www.w3.org/TR/turingtest/#the-google-recaptcha">さまざまな方法でアクセスできません</a>。

### 属性セレクター

{{ figure_markup(
  image="most-popular-attribute-selectors.png",
  caption="もっともポピュラーな属性セレクターです。",
  description="属性セレクターで選択されるもっとも人気のある属性を、使用率48％から使用率3％までの人気の高い順に並べたチャート。リストは以下の通りです。`type`, `class`, `disabled`, `dir`, `title`, `hidden`, `aria-disabled`, `role`, `href`, `controls`, `src`, `style`, `data-type`, `lang`, `xmlns`, `id`, `data-align`, `poster`, `name`, `readonly`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1836678858&format=interactive",
  sheets_gid="942534767",
  sql_file="top_selector_attributes.sql"
) }}

もっとも一般的な属性セレクターは引き続き `type` で、チェックボックスやラジオボタン、テキスト入力などのフォームコントロールを選択する際に使用されることが多いです。

### 擬似的なクラスと要素

擬似クラス、擬似要素ともに、順位や分布は2020年のWeb Almanacから大きく変わっていませんでした。いくつかの順位は変わりましたが、全体的にはほとんど変化がないようです。これが常識の定着を示しているのか、デザイナーの関心事のスナップショットを示しているのか、あるいは単に分析の性質を示しているのかは議論の余地があります。

{{ figure_markup(
  image="most-popular-pseudo-classes.png",
  caption="もっともポピュラーな疑似クラスです。",
  description="もっとも人気のある疑似クラスを、使用率85％から使用率12％までの人気の高い順に並べたチャート。リストは以下の通りです。`hover`, `focus`, `active`, `first-child`, `last-child`, `not`, `visited`, `root`, `nth-child`, `link`, `disabled`, `empty`, `checked`, `-ms-input`, `last-of-type`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1619223389&format=interactive",
  sheets_gid="843054585",
  sql_file="top_selector_pseudo_classes.sql"
) }}

2020年と同様に、ユーザーアクション擬似クラスの `:hover`, `:focus`, `:active` がトップ3を占め、いずれも全ページの3分の2以上に登場しています。構造的な擬似クラスも数多く登場しましたが、もっとも興味深い変化は、否定の擬似クラスである `:not()` は `:visited` よりも人気を博し、ページの50％のシェアを獲得したことです。

今年、とくにチェックしたのは、[`:focus-visible`という、フォーカスされた要素をユーザーの期待に合うようにスタイルする方法](https://developer.mozilla.org/ja/docs/Web/CSS/:focus-visible)の使用です。この機能は、2020年にChromiumへ搭載され、2021年1月にはFirefoxに搭載され、（発表時点では）Safari 15で実験的なフラグを立てて利用できるようになっています。最近の導入状況を反映してか、分析したページの1％未満にしか登場しませんでした。この数字が今後数年間で変化するかどうかが注目されます。

{{ figure_markup(
  image="most-popular-unprefixed-pseudo-elements.png",
  caption="もっともポピュラーな接頭辞なしの疑似要素です。",
  description="ベンダーのプレフィックスが付いていない、もっともポピュラーな擬似要素をリストアップしたチャートです。リストは以下の通りです。`before`（デスクトップ34％、モバイル33％）、`after`（デスクトップ31％、モバイル31％）、`selection`（デスクトップ7％、モバイル7％）、`placeholder`（デスクトップ7％、モバイル7％）、`first-letter`（デスクトップ1％、モバイル1％）、`marker`（デスクトップ0％、モバイル0％）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1825062416&format=interactive",
  height=500,
  sheets_gid="1863963291",
  sql_file="top_selector_pseudo_elements.sql"
) }}

現在使用されている擬似要素のほとんどは、特定のインタフェースコンポーネント、chromeの一部、またはハイライトされたテキストなどを選択するためのブラウザ固有の方法です。これらを除外すると、`::first-letter`が使用されているページは非常に少ないことがわかりますが、それでも`::first-line`よりは多くのページで使用されていることがわかります。`::marker` は、箇条書きやカウンターのようなリストアイテムのマーカーを順序付きリストとして選択する方法で、ページシェアは1％にも満たないが、リストに入っています。ここで注意すべきなのは、`::marker`のクロスブラウザサポートは、<a hreflang="en" href="https://caniuse.com/css-marker-pseudo">比較的新しい</a>ということです（2020年10月）。今後数年間で利用者が増えるかどうかが注目されます。

### `!important`

{{ figure_markup(
  image="important-properties-per-page.png",
  caption="`!important`を使ったページルールの割合の分布。",
  description="`!important`キーワードで重要とされたプロパティの割合の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図。その結果は以下の通りです。10パーセンタイルは、デスクトップ、モバイルともに0％。25パーセンタイル、デスクトップとモバイルの両方で1％。50パーセンタイル、デスクトップとモバイルの両方で2％。75パーセンタイル、デスクトップとモバイルの両方で4％。90パーセンタイル、デスクトップとモバイルの両方で8％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1184051032&format=interactive",
  sheets_gid="1176732383",
  sql_file="meta_important_adoption.sql"
) }}

その古い戦斧 `!important` は、2020年のWeb Almanacと比較して、マークされたルールのシェアがほとんど変わらず、ウェブ上で持ちこたえています。

`!important`と書かれたルールが17,990個もあるモバイルページを発見しました。この数字は、もっとも重要なデスクトップページの17,648個のルールを上回っています。これがスクリプトやプリプロセッサのミスによるものであることを願ってやみません。

`!important`が何に適用されるかというと、昨年と同様に`display`であり、その他の項目は2020年と同じ順番であるが、最後の項目を除いて`position`が`float`を上回っています。

{{ figure_markup(
  image="top-important-properties.png",
  caption="`!important`の対象となるもっとも人気のあるプロパティです。",
  description="`!important`キーワードで重要とされる可能性の高いプロパティを、そのようにマークされたプロパティを含むすべてのページのパーセンテージで表したグラフです。値はモバイル用のみですが、デスクトップ用のバーはすべてモバイル用のバーから1～2パーセント以内に収まっています。そのリストは以下の通りです。`display` 81％ of pages, `color` 74％ of pages, `width` 72％、`height` 70％、`background` 69％、`padding` 69％、`margin` 67％、`border` 66％、`background-color` 65％、`position` 61％.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=905910904&format=interactive",
  sheets_gid="1381789151",
  sql_file="meta_important_properties.sql"
) }}

### セレクターの特異性

<figure>
  <table>
   <thead>
    <tr>
      <th>パーセンタイル</th>
      <th>デスクトップ</th>
      <th>モバイル</th>
   </tr>
   </thead>
   <tbody>
    <tr>
      <th>10</th>
      <td>0,1,0</td>
      <td>0,1,0</td>
    </tr>
    <tr>
      <th>25</th>
      <td>0,2,0</td>
      <td>0,1,3 (up 0,0,1)</td>
    </tr>
    <tr>
      <th>50</th>
      <td>0,2,0</td>
      <td>0,2,0</td>
    </tr>
    <tr>
      <th>75</th>
      <td>0,2,0</td>
      <td>0,2,0</td>
    </tr>
    <tr>
      <th>90</th>
      <td>0,3,0</td>
      <td>0,3,0</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="ページごとのセレクターの特異性の中央値の分布。",
   sheets_gid="1962870115",
   sql_file="specificity.sql"
  ) }}</figcaption>
</figure>

多くのCSSメソドロジーでは、作者が単一のクラスに限定することを推奨しています。これは、すべてのセレクターの特異性を、より管理しやすい単一のレイヤーに押し込めるためです。たとえば、<a hreflang="en" href="https://en.bem.info/methodology/css/">BEMの手法</a>は、全ページの34％に見られました。セレクターの特異性の中央値の10パーセンタイルは、デスクトップとモバイルの両方の特異性の平均値が（0,1,0）であることから、この種の考え方のさらなる証拠を示しています。これは昨年の調査結果と同様で、ほぼすべての中央値が一致しています。ただし、モバイルの25パーセンタイルは若干上昇しています。

## 値と単位

CSSには、値や単位を指定する方法が複数用意されており、設定された長さや、グローバルキーワードに基づく計算などがあります。

### 長さ

{{ figure_markup(
  image="most-popular-length-units.png",
  caption="もっともポピュラーな長さの単位です。",
  description="長さの値に使われるもっとも一般的な単位を示したペアの列のチャートです。その結果は以下の通りです。`px`（ピクセル）デスクトップ、モバイルともに71％。`%`（パーセンテージ）デスクトップで17％、モバイルで18％。`em`（m単位）デスクトップ、モバイルともに9％。`rem` (root-relative `em`) デスクトップとモバイルの両方で2％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1920968690&format=interactive",
  sheets_gid="529909801",
  sql_file="units_frequency.sql"
) }}

ピクセルの長さをどう思うかは別として、ピクセルは圧倒的に人気のある長さ単位で、全ページの約71％に登場しています。2位の「パーセンテージ」は、「ピクセル」に圧倒的な差をつけています。

<figure>
  <table>
   <thead>
    <tr>
      <th>プロパティ</th>
      <th>`px`</th>
      <th>`<number>`</th>
      <th>`em`</th>
      <th>`%`</th>
      <th>`rem`</th>
      <th>`pt`</th>
    </tr>
   </thead>
   <tbody>
    <tr>
      <td>`font-size`</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 69%</td>
      <td class="numeric">2%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 16%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 5%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 5%</td>
      <td class="numeric">2%</td>
    </tr>
    <tr>
      <td>`line-height`</td>
      <td class="numeric"><span class="numeric-bad">(▼5%)</span> 49%</td>
      <td class="numeric"><span class="numeric-good">(▲3%)</span> 34%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 14%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 2%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`border-radius`</td>
      <td class="numeric">65%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 20%</td>
      <td class="numeric">3%</td>
      <td class="numeric">10%</td>
      <td class="numeric"><span class="numeric-good">(▲2%)</span> 2%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`border`</td>
      <td class="numeric">71%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 28%</td>
      <td class="numeric">2%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`text-indent`</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 31%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 52%</td>
      <td class="numeric">8%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 8%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`gap`</td>
      <td class="numeric"><span class="numeric-bad">(▼8%)</span> 13%</td>
      <td class="numeric"><span class="numeric-good">(▲2%)</span> 18%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 0%</td>
      <td class="numeric">0%</td>
      <td class="numeric"><span class="numeric-good">(▲7%)</span> 69%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`vertical-align`</td>
      <td class="numeric"><span class="numeric-bad">(▼11%)</span> 18%</td>
      <td class="numeric">12%</td>
      <td class="numeric"><span class="numeric-good">(▲11%)</span> 66%</td>
      <td class="numeric">4%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`grid-gap`</td>
      <td class="numeric"><span class="numeric-good">(▲3%)</span> 66%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 10%</td>
      <td class="numeric">9%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 0%</td>
      <td class="numeric"><span class="numeric-bad">(▼2%)</span> 14%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`padding-inline-start`</td>
      <td class="numeric"><span class="numeric-bad">(▼7%)</span> 26%</td>
      <td class="numeric"><span class="numeric-good">(▲2%)</span> 7%</td>
      <td class="numeric"><span class="numeric-good">(▲4%)</span> 66%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`mask-position`</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
      <td class="numeric"><span class="numeric-bad">(▼1%)</span> 49%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 51%</td>
      <td class="numeric">0%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`margin-inline-start`</td>
      <td class="numeric"><span class="numeric-bad">(▼7%)</span> 31%</td>
      <td class="numeric"><span class="numeric-good">(▲5%)</span> 51%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 15%</td>
      <td class="numeric"><span class="numeric-good">(▲2%)</span> 2%</td>
      <td class="numeric">1%</td>
      <td class="numeric">0%</td>
    </tr>
    <tr>
      <td>`margin-block-end`</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 5%</td>
      <td class="numeric"><span class="numeric-good">(▲7%)</span> 38%</td>
      <td class="numeric"><span class="numeric-bad">(▼9%)</span> 56%</td>
      <td class="numeric">0%</td>
      <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
      <td class="numeric">0%</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="プロパティごとの長さタイプの分布",
   sheets_gid="2127104776",
   sql_file="units_properties.sql"
  ) }}</figcaption>
</figure>

面白くなるのは、さまざまな長さの単位がどのように使われているかを正確に分析することです。一例を挙げると、`line-height`でもっともよく使われる長さの単位はピクセルで、次に`<number>`の値（単位のないゼロ長さの値のすべてのインスタンスを含む）が続きます。また、`vertical-align`や`padding-inline-start`では、`em`がもっとも一般的な長さの単位です。

この表の数字の横の括弧内の正負は、2020年の結果からの変化を示しています。ほとんどの物件で、他の長さの単位に比べて画素数が少なくなっていますが、2つの例外があります。もっとも大きな変更点は`vertical-align`で、供給される値が`baseline`のようなキーワードではなくlengthの場合、選択される単位がpixelsから`em`に11ポイント変更されました。

{{ figure_markup(
  image="most-popular-font-relative-units-of-length.png",
  caption="もっともポピュラーなフォント、相対的な長さの単位です。",
  description="次のような結果の円グラフです。`em`（m単位）81.7％、`rem`（語源的な`em`）17.8％、`ch`（ゼロ幅の前進）0.5％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=658259611&format=interactive",
  sheets_gid="529909801",
  sql_file="units_properties.sql"
) }}

フォントのサイジングに関しては、`em`が`rem`に対して圧倒的な優位性を保っていますが、変化の兆しもあります。2020年から2021年にかけて、`em`から`rem`へ7ポイントの変動がありました。

{{ figure_markup(
  image="zero-lengths-by-unit.png",
  caption="ゼロ長の値に使用される単位（またはその欠如）。",
  description="次のような結果の円グラフです。単位のないゼロ値87.8％、`0px`（ピクセル）11.6％、その他0.6％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=758334535&format=interactive",
  sheets_gid="2139699206",
  sql_file="units_zero.sql"
) }}

裸の `<number>` 単位を許可するプロパティはいくつかありますが（例：`line-height`）、`<length>` 値には、長さがゼロであれば単位を必要としないという特殊なケースがあります。すべての長さゼロの値を調べたところ、ほぼ88％が単位を省略していました。ゼロの長さで単位を含むものは、ほぼすべてがピクセル（`0px`）を使用していました。ゼロの長さには単位が必要なく、単位を含めることはかなり無意味なので、これは嬉しい結果となりました。今後、単位のないゼロの長さのシェアが拡大することを期待しています。

### 計算方法

{{ figure_markup(
  image="most-popular-properties-using-calc.png",
  caption="`calc()`関数を使った代表的なプロパティです。",
  description="対になっている列のチャートで、値はモバイル用にしか示されていませんが、デスクトップ用のバーはすべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りです。`width` 39％、`left` 18％、`top` 7％、`height` 5％、`max-width` 5％、`min-height` 3％、`margin-left` 3％、`margin-right` 3％、`max-height` 2％、`right` 2％、`padding-bottom` 1％、`flex-basis` 1％、`padding-left` 1％、`font-size` 1％、`margin-top` 1％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=907378413&format=interactive",
  sheets_gid="212269204",
  sql_file="calc_properties.sql"
) }}

例年通り、`calc()`のもっとも一般的な使い方は幅の設定ですが、`width`に占める`calc()`の値の割合は、2020年と比較して20ポイントも減少しました。これは、`calc()`が`width`に使われることが減ったのではなく、他のプロパティに使われることが増えたことを反映していると考えられます。

{{ figure_markup(
  image="most-popular-units-using-calc.png",
  caption="関数`calc()`で使われるもっとも一般的な長さの単位です。",
  description="計算値に使用される可能性の高い値の単位を示した対になった列のチャートです。数値はモバイル用のみですが、デスクトップ用のバーはすべてモバイル用のバーと比べて1～2％以内に収まっています。リストは以下の通りです。`px`（ピクセル）51％、percentage（パーセント）38％、`rem`（ルート相対`em`）3％、`vw`（ビューポート幅）2％、`em`（m単位）2％、`vh`（ビューポート高さ）2％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=833777702&format=interactive",
  sheets_gid="605954740",
  sql_file="calc_units.sql"
) }}

ピクセル単位は計算上の使用率ではまったく変化がなかったが、パーセントは他の単位のロングテールと比較して少し負けており、2020年から4ポイント低下しました。

{{ figure_markup(
  image="most-popular-operators-using-calc.png",
  caption="関数`calc()`で使われる代表的な演算子です。",
  description="対になっている列のチャートで、値はモバイル用にしか示されていませんが、デスクトップ用のバーはすべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りです。`-` 61％. `+` 18％、`/`（除算）14％、`*`（乗算）7％.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1708226150&format=interactive",
  sheets_gid="464539022",
  sql_file="calc_operators.sql"
) }}

昨年同様、演算子は引き算が断トツで、シェアはほとんど変化しませんでした。2位と3位の変化は大きく、足し算が割り算を上回って6ポイント増加し、割り算は同程度減少しました。

{{ figure_markup(
  image="units-per-calc-occurence.png",
  caption="関数`calc()`で使用されるユニークなユニットの数です。",
  description="対になっている列のチャートで、値はモバイル用にしか示されていませんが、デスクトップ用のバーはすべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りです。ユニットタイプ1つ、16％。2種類のユニットタイプ、82％。3種類以上のユニットタイプ、1％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=276182784&format=interactive",
  sheets_gid="856430777",
  sql_file="calc_complexity_units.sql"
) }}

`calc()`の値は比較的シンプルで、パーセント値の計算結果からピクセルを引くなど、2つの異なる単位を使った計算が圧倒的に多いです。全`calc()`式の99％は、1種類または2種類の単位を使用しています。

### グローバルキーワード

{{ figure_markup(
  image="global-keyword-adoption.png",
  caption="グローバルキーワードの値の使い方",
  description="グローバルキーワードを使用している全ページのうち、グローバルキーワードの使用率を示した対になる列のチャートです。数値はモバイル用のみですが、デスクトップ用のバーはすべてモバイル用のバーよりも1～2パーセント以内に収まっています。リストは以下の通りです。`inherit`87％、`initial`57％、`unset`48％、`revert`1％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=884074059&format=interactive",
  sheets_gid="731307554",
  sql_file="keyword_totals.sql"
) }}

2020年版Web Almanacと比較して、`initial`などのグローバルキーワードの使用率が大幅に上昇しました。  `inherit`は2～3ポイントしか上昇していませんが、`initial`は約8ポイント、`unset`は約10ポイント上昇しています。また、`revert`も1ポイント上昇しました。

## カラー

{{ figure_markup(
  image="most-popular-color-formats.png",
  caption="もっとも一般的なカラーバリューのフォーマットです。",
  description="使用されているカラーシンタックスフォーマットを、カラー値の全出現回数に対する割合で示した対になった列のチャートです。数値はモバイル用のみですが、デスクトップ用のバーはすべてモバイル用のバーよりも1～2パーセント以内に収まっています。リストは以下の通りです。`#rrggbb` 50％、`#rgb` 25％、`rgba()` 14％、`transparent` 8％、`namedColor` 1％ です。その先の残りの値は0％で表示され、以下の順番で表示されます。`rgb()`, `hsla()`, `#rrggbbaa`, `currentColor`, `system`, `hsl()`, `#rgba`, `color()` の順になります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=936970618&format=interactive",
  sheets_gid="2108707108",
  sql_file="color_formats.sql"
) }}

さまざまな色の値の種類があるにもかかわらず、Netscape 1.1の時代から使われている`#RRGGBB`という構文が、色の宣言の半分に使われています。2位はCSSの革新的な`#RGB`略記法で、カラーバリューの4分の1を占めています。言い換えれば、すべての色の値の75％は、16進数のRGB構文で表現されているということです。第3位の`rgba()`というフォーマットは、作者が古典的な16進法のフォーマットを超える理由を示しています：アルファ値にアクセスするためです。(実際、どちらのシェアも小さいですが、`hsla()`は`hsl()`よりも人気があり、`rgba()`が普通の`rgb()`よりもはるかに一般的であるのと同じです。)

たとえば`rgba(0, 0, 0, 1)`のように、これまで機能的な構文の中で値にカンマが使われていたカラーフォーマットでは、著者はカンマを削除し、スラッシュでカラーとアルファを分けることができるようになりました（例：`rgb(0 0 / 1)`）。2020年以降、このカンマなしの構文の使用率は倍増し、機能的な色の構文全体の0.12％から0.25％になりました。

<figure>
  <table>
   <thead>
    <tr>
      <td></td>
      <th scope="col">キーワード</th>
      <th scope="col">デスクトップ</th>
      <th scope="col">モバイル</th>
    </tr>
   </thead>
   <tbody>
    <tr>
      <td>{{ swatch('transparent') }}</td>
      <td>`transparent`</td>
      <td class="numeric">82.24%</td>
      <td class="numeric">82.93%</td>
    </tr>
    <tr>
      <td>{{ swatch('white') }}</td>
      <td>`white`</td>
      <td class="numeric">7.97%</td>
      <td class="numeric">7.59%</td>
    </tr>
    <tr>
      <td>{{ swatch('black') }}</td>
      <td>`black`</td>
      <td class="numeric">2.44%</td>
      <td class="numeric">2.29%</td>
    </tr>
    <tr>
      <td>{{ swatch('red') }}</td>
      <td>`red`</td>
      <td class="numeric">2.23%</td>
      <td class="numeric">2.17%</td>
    </tr>
    <tr>
      <td>{{ swatch('currentColor') }}</td>
      <td>`currentColor`</td>
      <td class="numeric">1.94%</td>
      <td class="numeric">2.03%</td>
    </tr>
    <tr>
      <td>{{ swatch('gray') }}</td>
      <td>`gray`</td>
      <td class="numeric">0.68%</td>
      <td class="numeric">0.64%</td>
    </tr>
    <tr>
      <td>{{ swatch('silver') }}</td>
      <td>`silver`</td>
      <td class="numeric">0.56%</td>
      <td class="numeric">0.55%</td>
    </tr>
    <tr>
      <td>{{ swatch('grey') }}</td>
      <td>`grey`</td>
      <td class="numeric">0.39%</td>
      <td class="numeric">0.37%</td>
    </tr>
    <tr>
      <td>{{ swatch('green') }}</td>
      <td>`green`</td>
      <td class="numeric">0.32%</td>
      <td class="numeric">0.31%</td>
    </tr>
    <tr>
      <td>{{ swatch('blue') }}</td>
      <td>`blue`</td>
      <td class="numeric">0.15%</td>
      <td class="numeric">0.12%</td>
    </tr>
    <tr>
      <td>{{ swatch('whitesmoke') }}</td>
      <td>`whitesmoke`</td>
      <td class="numeric">0.12%</td>
      <td class="numeric">0.11%</td>
    </tr>
    <tr>
      <td>{{ swatch('orange') }}</td>
      <td>`orange`</td>
      <td class="numeric">0.12%</td>
      <td class="numeric">0.10%</td>
    </tr>
    <tr>
      <td>{{ swatch('lightgray') }}</td>
      <td>`lightgray`</td>
      <td class="numeric">0.08%</td>
      <td class="numeric">0.08%</td>
    </tr>
    <tr>
      <td>{{ swatch('lightgrey') }}</td>
      <td>`lightgrey`</td>
      <td class="numeric">0.07%</td>
      <td class="numeric">0.07%</td>
    </tr>
    <tr>
      <td>{{ swatch('yellow') }}</td>
      <td>`yellow`</td>
      <td class="numeric">0.07%</td>
      <td class="numeric">0.06%</td>
    </tr>
    <tr>
      <td>{{ swatch('gold') }}</td>
      <td>`gold`</td>
      <td class="numeric">0.04%</td>
      <td class="numeric">0.03%</td>
    </tr>
    <tr>
      <td>{{ swatch('magenta') }}</td>
      <td>`magenta`</td>
      <td class="numeric">0.03%</td>
      <td class="numeric">0.03%</td>
    </tr>
    <tr>
      <td>{{ swatch('Background') }}</td>
      <td>`Background`</td>
      <td class="numeric">0.02%</td>
      <td class="numeric">0.03%</td>
    </tr>
    <tr>
      <td>{{ swatch('Highlight') }}</td>
      <td>`Highlight`</td>
      <td class="numeric">0.02%</td>
      <td class="numeric">0.03%</td>
    </tr>
    <tr>
      <td>{{ swatch('pink') }}</td>
      <td>`pink`</td>
      <td class="numeric">0.03%</td>
      <td class="numeric">0.03%</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="もっとも人気のある色の名前キーワード値です。",
   sheets_gid="2107615938",
   sql_file="color_keywords.sql"
  ) }}</figcaption>
</figure>

色の名前領域では、依然として`transparent`が圧倒的な人気を誇っており、色の名前キーワード全体の約82％を占めています。おなじみの`white`、`black`、`red`は約12％で、`currentColor`は2020年と比べて0.5％の増加で5位となっています。

昨年のWeb Almanacでは「`Canvas` や `ThreeDDarkShadow` など、かつては非推奨であったが、現在は部分的に非推奨ではなくなったシステムカラー」が、かろうじて使用されているという記述がありました。これは今でも正しいのですが、奇妙なことに、トップ20にはこのような値が1つ（`Highlight`）ではなく2つあります。とはいえ、どちらもごくわずかなページ数の領域での出来事なので、このような変化は目立たないでしょう。

{{ figure_markup(
  caption="display-p3の色のうち、sRGB空間外にある色の割合。",
  content="79％",
  classes="big-number",
  sheets_gid="721597121",
  sql_file="color_p3.sql"
) }}

display-p3色空間の使用率は、2020年に発見された時と同様に、消え入るように少ないままです。これはおそらく、この記事を書いている時点では、Safari（デスクトップとモバイルの両方）でのみサポートされているためです。デスクトップは90ページ、モバイルは105ページと約3倍になりました。モバイルでdisplay-p3を使って表現された色の79％がsRGB色空間では表現できない色だったからです。`color()`関数がブラウザで広くサポートされるようになるまでは、Webは画面が実際に表示できる色の約3分の2を許容するsRGBに留まります。

## イメージ

「百聞は一見にしかず」と言いますが、バイト換算すると一桁も、二桁も高いことが、多いのが画像です。JavaScriptで画像を埋め込んだり、HTMLで画像を埋め込んだりと、さまざまなアプローチがありますが、ここではCSSで読み込んだ画像がどのように使われているかを見てみました。

### CSSにおける画像のフォーマット

まず、探した画像フォーマットの内訳と、それぞれのフォーマットの出現頻度を紹介します。

{{ figure_markup(
  image="css-initiated-image-formats.png",
  caption="CSSで読み込んだ外部画像のフォーマット分布。",
  description="次のような結果の円グラフです。PNG 44.1％、GIF 18.3％、SVG 17.2％、JPG 16.4％、WebP 3.7％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=868556131&format=interactive",
  sheets_gid="1133067574",
  sql_file="image_formats.sql"
) }}

PNGが圧倒的な人気を誇り、GIF、SVG、JPGが驚くほど僅差で続いています。かなり新しいWebPフォーマットは、CSSで読み込まれる画像の3.7％しか占めておらず、一番上の小さなスライスは、認識されない値とICOフォーマットに対応しています。

また、アニメーションの有無については確認していません。

なお、今回の分析では、CSSで読み込まれる画像のみを対象としており、HTMLで何が読み込まれているかは確認していません。したがって以下の結果は、Webページの重さ、あるいはCSSの重さ、重くないことを示す指標とはなりません。あくまでも、CSSで読み込まれた画像がページの総重量にどれだけ貢献しているかを示すものです。

### CSS内の画像数

{{ figure_markup(
  image="number-of-images-loaded.png",
  caption="CSSで読み込んだ外部画像数の分布。",
  description="CSSで読み込んだ画像数の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図。その結果は以下の通りです。10パーセンタイルと25パーセンタイルは、デスクトップとモバイルの両方で1。50パーセンタイルは、デスクトップとモバイルの両方で3。75パーセンタイル、デスクトップで6個、モバイルで5個。90パーセンタイル、デスクトップで11、モバイルで10。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1206209320&format=interactive",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}

下位2パーセンタイルはそれぞれ1枚、90パーセンタイルでも10枚程度と、すべての画像タイプにおいて、ほとんどのCSSでは画像の読み込み量は多くないことがわかりました。

{{ figure_markup(
  caption="ページのCSSで読み込まれる外部画像の最大数。",
  content="6,089",
  classes="big-number",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}

デスクトップ版のCSSで6,088枚のPNG画像を読み込んでいるサイトがありました。モバイル版では実際に画像が追加され、6,089枚のPNGになっていました。効率化のために、すべての画像が小さく、カラーインデックス化されていることを願っています。

### CSSにおける画像の重さ

画像の数もさることながら、その重さも重要です。たとえば、10MBの背景を1枚読み込むのと、100KBの画像を10枚読み込むのとでは、サーバーでの圧縮を考慮しても劣ります。


{{ figure_markup(
  image="total-image-weight.png",
  caption="CSSで読み込まれた外部画像の総重量（KB）の分布。",
  description="モバイルでCSSを経由し読み込まれる画像の総重量について、10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図です。その結果は以下の通りです。10パーセンタイル：1.0KB 25パーセンタイル、3.0 KB. 50パーセンタイル、16.3 KB. 75パーセンタイル、119.3 KB. 90パーセンタイル、479.7 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1022255274&format=interactive",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}

中央のページのCSSによる画像の読み込みは、合計16KBほどでした。また、CSSによるモバイルの画像読み込み量は、デスクトップに比べて全体的に一貫してやや少なめで、CSS開発者がモバイルのコンテキストの制限を多少なりとも念頭に置いていることがうかがえます。

{{ figure_markup(
  caption="CSSで読み込まれたイメージのもっとも重い総量をKBで表しています。",
  content="314,386",
  classes="big-number",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}

たまにはね。CSSで読み込まれた画像の総重量が314,386.1KBと、GBの3分の1という膨大な量になっているページがありました。

<figure>
  <table>
   <thead>
    <tr>
      <th>パーセンタイル</th>
      <th>JPG</th>
      <th>PNG</th>
      <th>GIF</th>
      <th>(その他)</th>
      <th>SVG</th>
      <th>WebP</th>
    </tr>
   </thead>
   <tbody>
    <tr>
      <td>10</td>
      <td class="numeric">4.5</td>
      <td class="numeric">0.7</td>
      <td class="numeric">0.5</td>
      <td class="numeric">0.3</td>
      <td class="numeric">0.4</td>
      <td class="numeric">1.7</td>
    </tr>
    <tr>
      <td>25</td>
      <td class="numeric">28.2</td>
      <td class="numeric">2.2</td>
      <td class="numeric">1.7</td>
      <td class="numeric">0.3</td>
      <td class="numeric">0.6</td>
      <td class="numeric">14.2</td>
    </tr>
    <tr>
      <td>50</td>
      <td class="numeric">114.3</td>
      <td class="numeric">7.0</td>
      <td class="numeric">3.7</td>
      <td class="numeric">0.3</td>
      <td class="numeric">1.7</td>
      <td class="numeric">39.6</td>
    </tr>
    <tr>
      <td>75</td>
      <td class="numeric">350.7</td>
      <td class="numeric">36.4</td>
      <td class="numeric">8.3</td>
      <td class="numeric">48.1</td>
      <td class="numeric">5.4</td>
      <td class="numeric">133.9</td>
    </tr>
    <tr>
      <td>90</td>
      <td class="numeric">889.3</td>
      <td class="numeric">173.6</td>
      <td class="numeric">13.0</td>
      <td class="numeric">229.2</td>
      <td class="numeric">20.0</td>
      <td class="numeric">361.8</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="モバイルページでCSS経由で読み込まれた外部画像の総重量（KB）の画像フォーマット別分布。",
   sheets_gid="1175815151",
   sql_file="image_weights_by_type.sql"
  ) }}</figcaption>
</figure>

画像の重さをフォーマット別に分類してみると、興味深いことがわかりました。90パーセンタイルでは、GIF画像がSVGファイルよりも平均的に軽いのです。

また、驚くことではないかもしれませんが、もっとも重い画像フォーマットがJPGであることも興味深いことでした。これはおそらく、ホームページのトップなどでよく見かける大きな写真にはJPGが好まれ、圧縮やその他の最適化トリックを使っても、すべてのピクセルが加算されてしまうからでしょう。

### グラデーション

<figure>
  <table>
   <thead>
    <tr>
      <th>プロパティ</th>
      <th>デスクトップ</th>
      <th>モバイル</th>
    </tr>
   </thead>
   <tbody>
    <tr>
      <td>`background`</td>
      <td class="numeric">62%</td>
      <td class="numeric">62%</td>
    </tr>
    <tr>
      <td>`background-image`</td>
      <td class="numeric">62%</td>
      <td class="numeric">61%</td>
    </tr>
    <tr>
      <td>`-webkit-mask-image`</td>
      <td class="numeric">5%</td>
      <td class="numeric">5%</td>
    </tr>
    <tr>
      <td>`--*`</td>
      <td class="numeric">1%</td>
      <td class="numeric">1%</td>
    </tr>
    <tr>
      <td>`mask-image`</td>
      <td class="numeric">1%</td>
      <td class="numeric">1%</td>
    </tr>
    <tr>
      <td>`border-image`</td>
      <td class="numeric">1%</td>
      <td class="numeric">1%</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="グラデーション画像の値が与えられたプロパティの割合。",
   sheets_gid="204136042",
   sql_file="gradient_properties.sql"
  ) }}</figcaption>
</figure>

CSSグラデーションを使用しているページの割合は、昨年とほぼ同じでした。デスクトップページの77％、モバイルページの76％でした。しかし、グラデーションが使用されているプロパティには変化が見られ、`background`と`background-image`が圧倒的な人気を誇っていましたが、グラデーションの約62％がこのプロパティに割り当てられていました。

{{ figure_markup(
  image="most-popular-unprefixed-gradient-functions.png",
  caption="グラデーション画像の値の中でももっともポピュラーなタイプです。",
  description="対になっている列のチャートで、値はモバイル用にしか示されていませんが、デスクトップ用のバーはすべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りです。`linear-gradient` 74.3％、`radial-gradient` 14.5％、`repeating-linear-gradient` 3.7％、`repeating-radial-gradient` 0.1％、`conic-gradient` 0％、`repeating-conic-gradient` 0％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=2004838082&format=interactive",
  sheets_gid="1135532290",
  sql_file="gradient_functions.sql"
) }}

線形グラデーションの人気は引き続き高く、[2020年版Web Almanac](../2020/css)で見られた放射状グラデーションに対する5対1のリードを維持しています。

グラデーションの接頭辞付きバージョン（例：`-webkit-linear-gradient`）を含めると、結果的には昨年のグラフと同じになりました。

その他、グラデーションの値を分析してわかったことがあります。

* グラデーションのカラーストップ数の中央値は、4ストップの90パーセンタイルを除いて、わずか2ストップです。
* ハードカラーストップ（2つのカラーストップを同じ位置に配置したグラデーション）は、グラデーション全体の半分強に存在している。
* カラーストップ補間（別名「ミッドポイント」）は、すべてのグラデーションインスタンスの21％で使用されました。

{{ figure_markup(
  image="most-color-stops.png",
  classes="height-16vw-122px",
  caption="もっとも多くのカラーストップを持つ線形グラデーションです。",
  description="もっとも多くのカラーストップがあるグラデーションのスクリーンショット。汚れた金色から緑青、サーモン、焦げたオレンジへと変化する、さまざまな色合いの複雑なマルチカラーストライプが連続しています。",
  width=600,
  height=100
) }}

また、グラデーションの複雑さの上限でも、劇的な減少が見られました。昨年、もっとも多くのカラーストップを使用したグラデーションの数は646ストップでした。今年の受賞者のカラーストップ数はわずか81個でした。

## レイアウト

ウェブ上のレイアウトにテーブルを使用していた時代からFlexbox、Grid、Multicolumn、そしてfloat、positioning、さらにはCSSテーブルプロパティなど、さまざまな選択肢が用意されている時代になりました。どのようなプロパティと値の組み合わせがあるのか、スタイルシートを簡単に検索してみたところ、次のような数値が出てきました。

{{ figure_markup(
  image="top-layout-methods.png",
  caption="もっとも一般的に宣言されているレイアウトタイプです。",
  description="対になっている列のチャートで、値はモバイル用にしか示されていませんが、デスクトップ用のバーはすべてモバイル用のバーから1～2パーセント以内に収まっています。リストは以下の通りです。`absolute` 93％、`block` 93％、`inline-block` 91％、`floats` 91％、`inline` 82％、`fixed` 82％、`css-tables` 81％、`flex` 74％、`box` 50％、`inline-flex` 39％、`grid` 36％、`list-item` 29％、`inline-table` 23％、`inline-box` 22％、`stick` 17％、`inline-grid` 12％、`none` 8％、`flexbox` 8％、`inline-stack` 5％、`contents` 5％、`auto` 2％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1090750625&format=interactive",
  height=756,
  sheets_gid="1349743417",
  sql_file="layout_properties.sql"
) }}

分析したページの93％が絶対配置を使ってレイアウトされていると主張しているわけではありません。分析したページの93％が絶対配置でレイアウトされていると主張しているわけではありません！　むしろ、このチャートが示しているのは、分析したページの93％のスタイルに`position: absolute`が登場しているということです。同様に、`display: grid`が36％のページのスタイルに登場しているかもしれませんが、それは全ページの37％がGridページであることを意味するものではなく、単にスタイルシートのどこかにこの組み合わせが登場しているということです。

このセクションでは、プロパティ値の組み合わせだけでなく、ページでの実際の使用状況の証拠を見て、より詳細な分析をしています。

### フレックスボックスとグリッドの採用

{{ figure_markup(
  image="flexbox-grid-adoption.png",
  caption="モバイルデバイスでのFlexboxおよびGridレイアウトの採用。",
  description="2019年から2021年まで、モバイルでのFlexboxとGridの採用率が年ごとに増加していることを示すグラフです。Flexboxについては、2019年の採用率は50％を少し下回る程度で、2020年は約65％、2021年は71％となっています（2021年のみラベルが付いています）。Gridの場合、採用率は2019年に2％、2020年に4％、2021年に8％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1784148592&format=interactive",
  sheets_gid="928762069",
  sql_file="flexbox_grid.sql"
) }}

Flexboxとグリッドの採用が進み続けています。2019年のFlexboxの採用率は41％、2020年は63％でした。今年、Flexboxはモバイルで71％、デスクトップで73％を記録しました。一方、グリッドは、Web Almanacでは毎年2％から4％、そして現在は8％と倍増しています。 前のセクションとは対照的に、ここで計測されているのは、単にスタイルシートにFlexboxやGridのプロパティが含まれているページではなく、実際にFlexboxやGridをレイアウトに使用しているページの割合であることに注意してください。

### 異なるグリッドレイアウト技術の使用

さまざまなグリッドのプロパティを調べてみると、いくつかの興味深いパターンが見つかりました。

* 全グリッドページの約15％が、グリッドの名前付きエリアを定義するために `grid-template-areas` を使用しています。
* グリッドのテンプレートにある角括弧は、名前付きのグリッド線があることを示していますが、約700万ページの分析のうち、1万ページ弱しか見つかりませんでした。

また、Flexboxのレイアウトを分析し、フレックスの成長値と縮小値をゼロに設定し、すべてのフレックスアイテムの幅をパーセンテージやピクセル幅などの静的なものに設定したレイアウトを確認しました。これらは「グリッドライクのFlexbox」と呼ばれ、Flexboxレイアウトの4分の1強がこの条件を満たしていることがわかりました。分析が複雑であるため、多くのケースを見逃している可能性があります。しかし、デザイナーがグリッドスタイルのレイアウトに強い関心を持っていることは明らかであり、今後数年間でグリッドへの移行は進む可能性があります。

### マルチカラム

{{ figure_markup(
  caption="マルチカラムレイアウトを使用しているページの割合。",
  content="20％",
  classes="big-number",
  sheets_gid="1371521792",
  sql_file="multicol.sql"
) }}

マルチカラムレイアウトはユーザーが列の一番下までスクロールしてから次の列の一番上まで戻ってこなければならないという、ウェブ上では少々面倒なものですが、分析したページの20％でマルチカラムの使用が検出され、これは2020年版Web Almanacよりも5％上昇しています。これほど多くのページに掲載されていることに驚きを隠せませんし、その採用率が高まっていることにも驚きを隠せません。

### ボックスのサイズ

{{ figure_markup(
  image="border-box-declarations-per-page.png",
  caption="1ページあたりの`border-box`宣言の数の中央値の分布。",
  description="ページ上のborder-box宣言の数の10、25、50、75、90パーセンタイルの中央値を示すペアの列グラフです。その結果は以下の通りです。第10、25、50パーセンタイルは、デスクトップ、モバイルともに0。75パーセンタイルでは、デスクトップとモバイルの両方で2。90パーセンタイルでは、デスクトップとモバイルの両方で9。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1213231382&format=interactive",
  sheets_gid="477060329",
  sql_file="box_sizing.sql"
) }}

W3Cのオリジナルボックスモデルの原則は、引き続き否定されています。`box-sizing: border-box`を使用しているページがどれくらいあるかを調べたところ、2020年から約5％増加し、90％という圧倒的な数字になりました。分析したページの約半数が、ユニバーサルセレクター(`*`)を使って、ページ上のすべての要素にボーダーボックスのサイズを適用しています。このような「1つのサイズがすべてに適合する」アプローチは、ページあたりの `border-box` 宣言の数の中央値が下位3つのパーセンタイルで非常に低いことの説明に役立つかもしれません。

また、約4分の1のページでは、チェックボックスやラジオボタンに`box-sizing`を適用しています。

## トランジションとアニメーション

アニメーションは引き続き広く使用されており、`animation`プロパティは、分析対象となった全モバイルページの77％、全デスクトップページの73％で使用されています。 さらに人気の高い`transition`は、モバイルページの85％、デスクトップページの90％で使用されています。

{{ figure_markup(
  image="most-popular-transition-properties.png",
  caption="トランジション効果が与えられたもっとも人気のあるプロパティです。",
  description="デスクトップとモバイルの両方でもっともよく使われるアニメーションのプロパティをリストアップしたチャートで、値はモバイル用に示されています（デスクトップは常にモバイルの1～2パーセント以内です）。結果は以下の通りです。`all` 46％、`opacity` 42％、`transform` 30％、`none` 20％、`height` 18％、`color` 18％、`background-color` 13％、`background` 12％、`left` 8％、`width` 8％、`box-shadow` 8％、`-webkit-transform` 7％、top 7％、`border-color` 6％、`visibility` 6％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1505834154&format=interactive",
  sheets_gid="1623088261",
  sql_file="transition_properties.sql"
) }}

これらのトランジションの中で、もっとも一般的なアプリケーションは、`all`キーワードを使ったすべての[animatable property](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_animated_properties)への適用であり、分析されたページの46％で発生しています（明示的であれデフォルトであれ）。これに続くのは`opacity`で、トランジションを含むすべてのページの42％です。

{{ figure_markup(
  image="distribution-of-transition-durations.png",
  caption="遷移時間の分布",
  description="遷移時間の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図。1つを除くすべてのパーセンタイルで、デスクトップとモバイルで値がまったく同じになっています。その結果は以下の通りです。10パーセンタイルでは、100ミリ秒。25パーセンタイルでは、150ミリ秒。50パーセンタイルでは、250ミリ秒。75パーセンタイルは、デスクトップで330ミリ秒、モバイルで333ミリ秒。90パーセンタイルでは、500ミリ秒。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=894159072&format=interactive",
  sheets_gid="432079881",
  sql_file="transition_durations.sql"
) }}

私たちは、これらのトランジションの持続時間と遅延時間を見てみました。90パーセンタイルの場合でも、トランジションの持続時間の中央値はわずか0.5秒でした。

{{ figure_markup(
  image="distribution-of-transition-delays.png",
  caption="トランジションディレイの分布",
  description="遷移時間の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図。すべてのパーセンタイルにおいて、デスクトップとモバイルで値がまったく同じになっています。その結果は以下の通りです。10パーセンタイル -320ミリ秒。25パーセンタイル0ミリ秒、50パーセンタイル200ミリ秒、75パーセンタイル600ミリ秒、90パーセンタイル1,700ミリ秒。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=501863648&format=interactive",
  sheets_gid="909003541",
  sql_file="transition_delays.sql"
) }}

トランジションの遅延の中央値がもっとも高かったのは1.7秒でしたが、さらに興味深いことに、10パーセンタイルの中央値の遅延は負の3分の1秒とまではいかない程度で、多くのトランジションがアニメーションの途中で開始されていることを示しています（これは負の遅延が引き起こす現象です）。

遷移の継続時間と遅延の範囲を詳しく見てみると、非常に長時間かかることがわかりました。もっとも大きな値は9,999,999,999,996秒で、これは約3億1700万年に相当します。 別の言い方をすると、<a hreflang="en" href="https://www.joshworth.com/dev/pixelspace/pixelspace_solarsystem.html">月がたった1ピクセルだったら</a>水平方向のスクロール遷移にこの期間を使用した場合、1ピクセルだけ右へスクロールするのに2世紀以上かかることとなります。しかし、私たちが発見したもっとも長い移行遅延である31.7 _兆年_ 年に相当するミリ秒の値に比べれば、その差は歴然としています。

{{ figure_markup(
  image="timing-functions.png",
  caption="移行タイミング機能の採用",
  description="全トランジションにおけるタイミング関数の分布を示した円グラフ。数値は、ease 31.7％、linear 18.8％、ease-in-out 18.2％、cubic-bezier 14.4％、ease-out 8.3％、ease-in 4.8％、step 3.8％となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1700244926&format=interactive",
  sheets_gid="1217291895",
  sql_file="transition_timing_functions.sql"
) }}

トランジションの際に使用されるタイミング関数については、デフォルト値である`ease`が断トツのトップ。2位は`ease-in-out`と`linear`の事実上の同点でしたが、意外だったのは4位の`cubic-bezier`でした。これはライブラリやある種のツールから来ている可能性が高いと思われます。なぜなら、三次ベジエ曲線の作成方法を手で学ぶことは可能ですが、わざわざそうする人はほとんどいないからです（そうする理由もあまりありませんが）。

なるほど、でも、どんなアニメーションが行われているのでしょうか？　そのために、さまざまなアニメーションラベルを、実行されているアニメーションの種類によって分類しました。たとえば、`fa-spin`、`spin`、`spinner-spin`などと表示されているアニメーションは「回転」アニメーションに分類され、もっとも人気がありました。

{{ figure_markup(
  image="animation-name-categories.png",
  caption="もっともポピュラーなアニメーションの種類です。",
  description="もっとも人気のあるアニメーションの種類を示したグラフで、モバイルでの値を示しています（デスクトップは常にモバイルの1～2パーセント以内）。その結果は以下の通りです。`rotate` 18％、unknown or other 14％、`fade` 9％、`wobble` 7％、`bounce` 7％、`scale` 6％、`slide` 5％、`pulse` 2％、`visibility` 2％、`flip` 1％、`move` 0％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=676429696&format=interactive",
  sheets_gid="721830186",
  sql_file="transition_animation_names.sql"
) }}

「不明・その他」の順位が高い理由の1つは、アニメーションのラベル`a`で、名前のついたアニメーション全体の約6〜7％でした。(これにもっとも近いと思われる`b`は2％の普及率でした）。

「移動」や「スライド」スタイルのアニメーションが弱いのは意外かもしれませんが、これらは具体的には`animation`のタイプであることを忘れないでください。このサンプルでは、`transition`プロパティで駆動するトランジションは表現されていません。多くの単純な動き（およびフェード）はトランジションで処理され、`animation`はより複雑な効果のために確保されていると考えられます。

## レスポンシブデザイン

FlexboxやGridなどの組み込みツールの登場により、ウェブを閲覧する際のさまざまなスクリーンサイズに対応したサイトを作ることが非常に容易になりました。また、media-queriesを使用することで、さらに効果的になります。

### 使用されているメディア機能

作者がメディアクエリを作成する際には、ビューポートの幅をテストすることがほとんどです。`max-width`と`min-width`が圧倒的に多いクエリで、これは2020年と同じでした。3位と4位の結果にも順位の変動はありませんでした。

{{ figure_markup(
  image="media-query-features.png",
  caption="メディアクエリとして使用されるもっとも一般的な機能です。",
  description="もっとも一般的に使用されているメディアクエリの一覧表で、モバイル用の値が記載されています（デスクトップは常にモバイルの1～2％以内）。その結果は以下の通りです。`max-width` 81％、`min-width` 78％、`webkit-min-device-pixel-ratio` 42％、`orientation` 34％、`prefers-reduced-motion` 32％、`max-device-width` 28％、`min-resolution` 23％、`-ms-high-contrast` 23％、`max-height` 22％、`webkit-transform-3d` 14％、`max-height` 22％、`-webkit-transform-3d` 14％、`min-device-pixel-ratio` 14％、`min--moz-device-pixel-ratio` 12％、`min-height` 11％、`-o-min-device-pixel-ratio` 9％、`min-device-width` 8％、`prefers-color-scheme` 7％、`forced-colors` 7％、`hover` 4％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1275783028&format=interactive",
  height=671,
  sheets_gid="1192142763",
  sql_file="media_query_features.sql"
) }}

顕著な変化が見られたのは、`prefers-reduced-motion`クエリのランキングでした。このクエリは、2020年には24％のシェアで7位でしたが、今年は32％のシェアで5位に上がり、`orientation`をわずかに上回っています。

また、最下位には新参者が登場しました。昨年19位だった[`pointer`](https://developer.mozilla.org/ja/docs/Web/CSS/@media/pointer)は、ディスプレイデバイスの主な入力機構がマウスなどのポインティングデバイスであるかどうかをチェックするクエリで、21位に転落してしまいました。一方、[`hover` メディア機能](https://developer.mozilla.org/ja/docs/Web/CSS/@media/hover)は、20位にランクインしました。`hover` は、ディスプレイデバイスの主要な入力メカニズムが、ページ上の要素にホバー状態を引き起こすことができるかどうかをテストするために使用されます。

どちらのクエリも目的は似ていて、（簡単に言うと）ページを表示するために使用されているデバイスがマウス駆動であるかどうかを調べることです。モバイルファーストのデザイン哲学と組み合わせると、デスクトップのスタイルがモバイルのデフォルトスタイルを上書きするように追加され、`pointer`や`hover`のようなクエリがどのように役立つかがわかります。どちらかが優位に立つかどうかを判断するのはまだ早いですが、今年のトレンドは`hover`に傾いています。

また、今年は`prefers-color-scheme`が登場し、7％となりました。これは、昨年のレポート以降、iOSデバイスがダークモードに対応したためと思われますが、いずれにしても、デザイナーが配色の好みを考慮するようになったことは喜ばしいことです。

### 一般的なブレークポイント

2020年と同様、もっともよく使われたブレークポイントは767ピクセルと768ピクセルで、これはiPadのポートレートモードの解像度と疑わしいほどよく一致しています。`767px`は最大幅のブレークポイントとして使われることが圧倒的に多く、最小幅の値として使われることはほとんどありませんでした。一方、`786px`は最小値、最大値としてもよく使われていました。

{{ figure_markup(
  image="most-popular-breakpoints.png",
  caption="もっともポピュラーなメディアクエリのブレークポイントです。",
  description="もっとも人気のあるメディアクエリのブレークポイントを列挙した積み上げ式のチャートです。結果は以下の通りです。480ピクセルは、24％ `min-width`と36％ `max-width`。 600ピクセルは、31％ `min-width`と38％ `max-width`。767ピクセルは、9％の`min-width`と52％の`max-width`です。768ピクセルは、`min-width` 57％、`max-width` 38％。782ピクセルは、`min-width` 25％、`max-width` 10％。800ピクセルは、8％ `min-width` 26％ `max-width`です。991ピクセルは、`min-width` 3％、`max-width` 30％です。992ピクセルは、`min-width` 40％、`max-width` 13％です。1024ピクセルは、`min-width` 16％、`max-width` 27％。1200ピクセルは、`min-width` -44％、`max-width` -18％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=990843085&format=interactive",
  sheets_gid="1275086846",
  sql_file="media_query_values.sql"
) }}

767-768の範囲を超えて、次に人気があったのは600ピクセルと1,200ピクセルで、その次が480ピクセルでした。

ブレークポイントのクエリをすべてピクセルに変換したのかと思われるかもしれませんが、残念ながら変換していません。今回分析したすべてのブレークポイントのうち、ピクセル以外の値として最初に挙げられたのは`48em`で、ランキングでは76位、デスクトップでは1％、モバイルでは2％のスタイルに現れています。次のemベースの値である`40em`は、85位に見られます。

### メディアクエリ内のプロパティ

では、これらのメディアクエリブロックの中で、作者は実際に何をスタイリングするのでしょうか？　もっともよく設定されるプロパティは `display` で、次いで `color`、`width`、`height` となります。

{{ figure_markup(
  image="most-popular-properties-used-in-media-queries.png",
  caption="メディアクエリで変更するのがもっともポピュラーなプロパティです。",
  description="モバイル用に与えられた値を使ったチャートです（デスクトップは常にモバイルの1～2％以内）。その結果は以下の通りです。`display` 81％、`color` 74％、`width` 72％、`height` 70％、`background` 69％、`padding` 69％、`margin` 67％、`border` 66％、`background-color` 65％、`position` 61％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=285981171&format=interactive",
  sheets_gid="1782726219",
  sql_file="media_query_properties.sql"
) }}

2020年から2021年にかけてのもっとも注目すべき変化の1つは、メディアブロック内に設定されるプロパティとしての`font-size`の凋落です。2020年には、全メディアブロックの73％に登場し、ランキング5位となっていました。今年は全メディアブロックの約6割に登場し、12位にランクインしました。

`margin-right`と`margin-top`はさらに大きく落ち込み、それぞれ8位と9位から25位と17位になりました。このような変化は、共通のフレームワークやソフトウェアの変更を強く示唆しています。WordPressのデフォルトテーマの変更もその一例ですが、これが変化の正確な原因であるかどうかはわかりません。

## クエリ機能

クエリ機能（`@supports`）の使用率は伸び続けています。2019年には30％のページが使用していることが判明し、昨年は39％でした。2021年には、ほぼ48％のページが、どのコンテキストでどのCSSを適用するかを決めるために、クエリ機能を使用しています。

では、作者は何を条件にCSSを使うのでしょうか？　もっとも多かったのは「スティッキーポジショニング」で、全体の半数以上を占めています。

{{ figure_markup(
  image="most-popular-features-queried.png",
  caption="CSSの代表的な機能を`@supports`で照会できます。",
  description="モバイル用に与えられた値を使ったチャートです（デスクトップは常にモバイルの1～2％以内）。その結果は以下の通りです。`sticky` 53％、`mask-image` 15％、`me-aligh` 7％、`overflow-scrolling` 6％、`touch-callout` 5％、`grid` 3％、`appearance` 1％、カスタムプロパティ1％、`max()` 1％、`transform-style` 1％.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1806919245&format=interactive",
  sheets_gid="349568482",
  sql_file="supports_criteria.sql"
) }}

グリッドをサポートしているかどうかを確認したクエリ機能はわずか3％で、グリッドをサポートしているかどうかを確認したページは261,406ページになります。グリッドレイアウトが使用されていたのは、モバイルページで270万ページ、デスクトップページで230万ページであったことを考えると、この数字が正確であれば、グリッドレイアウトの大部分はフォールバックなしで導入されていると考えられます。

## Custom properties

{{ figure_markup(
  image="custom-property-usage.png",
  caption="カスタムプロパティ使用量の変化（2019-2021年）。",
  description="カスタムプロパティと値関数`var()`の使用状況の経年変化を示したグラフ。カスタムプロパティは、カスタムプロパティ機能を使用しているスタイルシートのうち、2019年には5％、2020年には19.3％、2021年には28.6％で使用されていました。また、`var()`値関数は、カスタムプロパティ機能を使用しているスタイルシートのうち、2020年には27％、2021年には35.2％で使用されていました。2019年は`var()`のデータがありません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=752724350&format=interactive",
  sheets_gid="1813615348",
  sql_file="custom_property_adoption.sql"
) }}

Web Almanacの3年間で、カスタムプロパティ（CSS変数とも呼ばれる）の使用率がもっとも高まったものの1つです。2019年の使用率は全サイトの5％程度でしたが、昨年はモバイルが20％近く、デスクトップが15％と急増していました。今年は、全モバイルページの28.6％、デスクトップページの28.3％でカスタムプロパティが定義されていることがわかりました。さらに、モバイルページの35.2％、デスクトップページの35.6％に、少なくとも1つの `var()` 関数値が含まれていることがわかりました。

### ネーミング

{{ figure_markup(
  image="custom-property-names.png",
  caption="もっともポピュラーなカスタムプロパティ名です。",
  description="もっとも人気のあるカスタムプロパティ名の一覧表です。デスクトップは常に1～2％以内であるため、モバイルの結果を示しています。結果は以下の通りです。`--wp-style--color--link`, 18.1％。`wp-admin-theme-color`, 7.5％。`red`、`--blue`、`--green`はすべて7.2％です。`--dark` と `--white` はともに7.1％です。`--primary`と`--secondary`は6.9％です。`--gray-dark` 6.8％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=205956063&format=interactive",
  sheets_gid="725813203",
  sql_file="custom_property_names.sql"
) }}

最初に確認したこと、"開発者は自分のカスタムプロパティを何と呼んでいるのか？　"ということでした。結論から言うと、ここではWordPressの普及率が出ていて、WPコアで定義されたリンクカラーリングのカスタムプロパティがトップエントリーになっています。

その後、たくさんの色名が見つかりました。名前のついた色 `blue` がすぐそこにあり、`--blue` へカスタム値を定義する必要があるとは奇妙に思えるかもしれませんが、実際には、開発者は基本的な色名にカスタムシェードを割り当てています。そのため、`--blue: blue`ではなく、`--blue: #3030EA`です。

### 使用方法

{{ figure_markup(
  image="custom-property-properties.png",
  caption="custom-propertyの値を与えられるもっとも人気のあるプロパティ。",
  description="モバイル用に与えられた値を使ったチャートです（デスクトップは常にモバイルの1～2％以内）。結果は以下の通りです。`color` 31％、`background-color` 17％、`background` 15％、`border-color` 13％、`height` 12％、`width` 12％、`border` 11％、`box-shadow` 11％、`margin-top` 10％、`font-size` 9％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=951347176&format=interactive",
  sheets_gid="1369726995",
  sql_file="custom_property_properties.sql"
) }}

色にちなんだすべてのカスタムプロパティに加えて、カスタムプロパティの値を受け取る（`var()`関数を使用する）もっとも一般的な4つのプロパティは、いずれも何らかの形で色を設定しています。

{{ figure_markup(
  image="custom-property-value-types.png",
  caption="カスタムプロパティ値の種類の分布",
  description="モバイル用に与えられた値を円グラフにしたもの。結果は、color 40％、寸法（長さ）27.2％、font_stack10.9％、number 11.1％、その他10.8％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1962152689&format=interactive",
  sheets_gid="2132273363",
  sql_file="custom_property_value_types.sql"
) }}

各カスタムプロパティには、1種類のCSS値が設定されます。たとえば、`--red: #EF2143` は `--red` に色の値を割り当て、`--multiplier: 2.5` は数字の値を割り当てます。 その結果、「色」がもっとも多く、次いで「寸法（長さ）」、そして「フォントファミリー」の順で単独、グループ共に人気だということがわかりました。

### 複雑さ

カスタムプロパティを他のカスタムプロパティの値に含めることは可能です。2020 Web Almanacの例を見てみましょう。

```css
:root {
  --base-hue: 335; /* depth = 0 */
  --base-color: hsl(var(--base-hue) 90% 50%); /* depth = 1 */
  --background: linear-gradient(var(--base-color), black); /* depth = 2 */
}
```

前述の例のコメントにあるように、これらの下位参照を連鎖させればさせるほど、カスタムプロパティの _depth_ は大きくなります。

{{ figure_markup(
  image="custom-property-depth.png",
  caption="カスタムプロパティの深さの中央値の分布",
  description="ペアの列のチャートです。結果は以下の通りです。カスタムプロパティの深さがゼロの場合、デスクトップで64％、モバイルで68％の発生率。カスタムプロパティの深さが1段階の場合、デスクトップで32％、モバイルで29％。深度が2段階の場合、デスクトップとモバイルの両方で3％。3段階以上の場合、デスクトップとモバイルの両方で0％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1735836564&format=interactive",
  sheets_gid="1066390528",
  sql_file="custom_property_depth.sql"
) }}

意外かもしれませんが、カスタムプロパティの値の深さは0のものが圧倒的に多く、他のカスタムプロパティの値を自分の値に含めていません。3分の1近くは値の深さが1段階で、2段階以上の値を持つカスタムプロパティはほとんどありません。

2020年と同様に、カスタムプロパティの値が使用されているセレクターも確認しました。約60％がルート要素（`:root`または`html`セレクターを使用）に設定されており、約5％が`<body>`要素に適用されていました。残りは、ルート要素の子孫である `<body>` 以外の要素に適用されています。つまり、全カスタムプロパティの約3分の2が、実質的にグローバルな定数として使用されていることになります。これは、昨年の結果と同じです。

## 国際化

英語は横書きで、文字を左から右に読む。しかし、アラビア語、ヘブライ語、ウルドゥー語などの言語は右から左に書きますし、モンゴル語、中国語、日本語のように、上から下へ縦に書く言語や文字もあります。そのため、非常に複雑な構造になっています。HTMLとCSSには、このような問題を解決する方法があります。

### 方向性

テキストの方向は、CSSプロパティの`direction`を使って、明示的に強制できます。このプロパティは、全ページの11％の `<html>` 要素で使用されており、3％の `<body>` 要素で使用されていることがわかりました（重複した結果をチェックしていないので、重複している可能性があることに注意してください）。

CSSで方向性を設定しているページのうち、`<html>`要素の92％、`<body>`要素の82％が`ltr`（左から右）に設定されていました。全体的に見ると、CSSで方向性を設定しているページのうち、`rtl`（右から左）が使われているのは9％だけでした。これは、ほとんどの言語が右から左ではないことを考えると、大体予想できることです。

### 論理的・物理的特性

また、国際化に役立つCSSの機能として、`margin-block-start`、`padding-inline-end`などの「論理的」なプロパティや、`text-align`などのプロパティの`start`や`end`などの値があります。これらのプロパティと値により、ボックスの機能を、上、右、下などの物理的な方向ではなく、テキストの流れの方向に関連付けることができます。

{{ figure_markup(
  image="logical-property-and-value-usage.png",
  caption="論理的なプロパティのプロパティタイプの分布",
  description="モバイルでの分布を示す円グラフ。結果は以下の通り。`text-align` 34％、`margin` 26.4％、`padding` 21.6％、`border` 11.8％、`size` 2.2％、`min-size` 2％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=190768531&format=interactive",
  sheets_gid="1595217858",
  sql_file="i18n_logical_properties.sql"
) }}

2021年半ばの時点で、何らかの論理的プロパティを使用しているページは、わずか4％でした。使っているページのうち、約33％が`text-align`を`start`や`end`へ設定するために使っていました。また、46％ほど（合計）が論理的なマージンやパディングを設定していました。繰り返しになりますが、これらの数字は重複してる可能性があります。

### Ruby

CSSは、方向性や論理的な機能に加えて、CSS Rubyによる国際化にも対応しています。これは、インターリニアアノテーション（原文の横に短い文章を並べたもの）のレイアウトに影響を与えるプロパティの集まりです。CSS Rubyの使用率は非常に低く、デスクトップでは8,157ページ、モバイルでは9,119ページと、分析した全ページの0.1％にも満たないことが分かりました。

## CSSとJS

{{ figure_markup(
  image="css-in-js-libraries.png",
  caption="CSS-in-JSライブラリの分布。",
  description="モバイルでの分布を示す円グラフ。結果は以下の通りです。Styled Components 57.7％、Emotion 24.4％、Glamor 7.5％、Aphrodite 6.6％、Styled Jsx 2％ となりました。表示されていない小さなスライスがいくつかあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1003466201&format=interactive",
  sheets_gid="1851845193",
  sql_file="css_in_js.sql"
) }}

『CSS in JS」の話題は、少なくともTwitterでの炎上騒ぎの1つや2つにはもってこいですが、自然界での使用は非常に少ない状態が続いています。今年の調査では、ページの約3％が何らかの形でCSS-in-JSを使用していることがわかりましたが、これは2020年の2％から増加しています。さらに、そのほぼすべてがこの目的のために構築されたライブラリによるものであり、その半分以上がStyled Componentsライブラリによるものです。

### Houdini

CSS Houdiniは、ある意味ではCSS-in-JSの逆を行くもので、作者がCSSに少しだけJSを混ぜることを可能にします。おそらく、仕様の中核部分の<a hreflang="en" href="https://ishoudinireadyyet.com/">遅い実装</a>（Blinkベースではないブラウザで）が原因で、Houdiniはその地位を確立するのに苦労しています。 We find that it's effectively not used on the open web in 2021: only 1,030 desktop pages and 1,175 mobile pages show evidence of animated custom properties, a feature of Houdini. This is a threefold increase over the 2020 findings, but it looks like it will still be some time before Houdini finds an audience。

## Meta

このセクションでは、宣言の繰り返しの頻度や、作者がCSSを書く際にどのようなミスをするかなど、CSSのより一般的な概念を見ていきます。

### 宣言の繰り返し

2020年版Web Almanacでは、「宣言の繰り返し」の量を分析しています。これは、同じプロパティや値を使用している宣言がいくつあるか、ページのスタイル内でユニークな宣言がいくつあるかを判断することで、スタイルシートの効率を大まかに見積もるための指標です。

2021年の数字が発表され、すべてのパーセンタイルで反復回数の中央値がわずかに低下していることがわかりました。

{{ figure_markup(
  image="declaration-repetition.png",
  caption="ページごとの宣言文の繰り返しの分布。",
  description="繰り返し申告される物件の割合の10、25、50、75、90パーセンタイルの中央値を示したペアの列挙図。各パーセンタイルには、デスクトップ用とモバイル用の2つの列がありますが、モバイル用の値のみが表示されています（デスクトップ用の常に1～2パーセント以内です）。その数字は以下の通りです。10パーセンタイル、30％。25パーセンタイル、36％。50パーセンタイル、44％。75パーセンタイル、53％. 90パーセンタイル、62％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1849063734&format=interactive",
  sheets_gid="560362648",
  sql_file="repetition.sql"
) }}

この低下の度合いは、10％、50％、90％で2％のオーダーなので、これが統計的なノイズである可能性は十分にあります。これを判断する唯一の方法は、今後も分析を継続し、長期的なトレンドをグラフ化することです。

### ショートハンドとロングハンド

CSSでは、非常に具体的なプロパティの集合体が、単一の宣言でより具体的なプロパティの値を設定できる単一の「umbrella」プロパティによってもカバーされている部分が多くあります。たとえば、`font`は、`font-family`、`font-size`、`line-height`、`font-weight`、`font-style`、`font-variant`の値を包含します。umbrellaプロパティの `font` は、いわゆる「ショートハンド」プロパティで、作者がある種のショートハンドで多くのことを設定できるようにするものです。これに対応する具体的なプロパティ（たとえば、`font-family`）は、「ロングハンド」プロパティと呼ばれます。

#### ロングハンドの前にショートハンド

スタイルシートの中で、`background`のような短縮形プロパティと`background-size`のような長音部プロパティが混在している場合は、長音部が短縮形の後に来るのが常にベストです。私たちは、どのロングハンドがもっとも一般的であるかを調べるために、著者がこのようにした例を調べました。

{{ figure_markup(
  image="most-popular-longhand-properties-after-shorthands.png",
  caption="対応する短縮形プロパティの後に表示される、もっとも一般的なロングハンドプロパティです。",
  description="すべての値がモバイル用に与えられたチャート一覧です（デスクトップの常に1～2パーセント以内）。結果は以下の通りです。`background-size`, 15％。`background-image`, 7％。`margin-bottom`, `margin-top`, `border-bottom-color`, `font size`, 5％。`border-top-color`, 4％。 `margin-left`, `line-height`, `background-color`, 3％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1051485878&format=interactive",
  sheets_gid="1761101514",
  sql_file="meta_shorthand_first_properties.sql",
  width=600,
  height=429
) }}

2020年と同様に`background-size`が選ばれましたが、昨年はモバイルで41％、今年は15％の割合でしか見られませんでした。

#### バックグラウンド

バックグラウンドロングハンドのプロパティが前節のチャートの上位にあったので、バックグラウンドショートハンドとロングハンドの使用に目を向けてみました。

{{ figure_markup(
  image="usage-of-background-shorthand-vs-longhands.png",
  caption="もっともよく使われるバックグラウンドのプロパティです。",
  description="すべての値がモバイル用に与えられたチャートです（デスクトップはほぼ1～2パーセント以内）。その結果以下の通りです。`background` 96％、`background-color` 95％、`background-position` 91％、`background-image` 90％、`background-repeat` 85％、`background-size` 82％、`background-clip` 47％ (デスクトップは56％), `background-attachment` 37％、`background-origin` 5％（デスクトップほぼ0％）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=668445598&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql",
  width=600,
  height=429
) }}

むしろ、これらを設定していないページがあったことに小さな驚きを感じました。圧倒的に96％のページが`background`というショートハンドを使用していますが、これは1996年のCSS1に遡ります。同年代のロングハンドプロパティも同様で、85％以上のページで適用されていることがわかりました。

しかし、最近の `background-size` は急速に普及しており、82％ のページで採用されていることから、作者にとっての有用性の高さがわかります。一方、`background-origin`は、昨年の12％から今年はわずか5％にまで落ち込んでいます。

#### marginとpadding

{{ figure_markup(
  image="usage-of-margin-padding-shorthands-vs-longhands.png",
  caption="もっともよく使われるmarginとpaddingのプロパティです。",
  description="すべての値がモバイル用に与えられたチャートです（デスクトップのほぼ1～2パーセント以内）。結果は以下の通りです。`margin-left` 96％、`margin` 9％、`margin-top`, `padding` 93％。`padding-bottom`、`margin-bottom`、`margin-right`、92％。`padding-left` 91％、`padding-right` 90％。`padding-top` 73％ (デスクトップでは90％)。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=918848418&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}

続いて、marginとpaddingのプロパティを見てみましょう。背景と同じように、これらのプロパティを設定しているページが多いことよりも、設定していないページがあることの方が驚きです。今年の関心事は、ロングハンドの`margin-left`がショートハンドの`margin`を抑えて1位になったことです。

#### フォント

{{ figure_markup(
  image="usage-of-font-shorthand-vs-longhands.png",
  caption="よく使われるフォントのプロパティ",
  description="すべての値がモバイル用に与えられたチャートです（デスクトップのほぼ1～2パーセント以内）。その結果は以下の通りです。`font-size` 95％、`font-family` 94％、`font-weight` 92％、`font-style` 86％、`font` 82％ でデスクトップ57％、`font-variant` 23％ でデスクトップ12％、`font-stretch` 5％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1034544520&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}

2020年と同様に、短縮形の`font`は一般的なロングハンドの`font-weight`と比較して、`font-size`がリードし、昨年の`font-weight`から首位を奪いました。

ここでは、`font-variant`と`font-stretch`という2つの異なったストーリーがあります。`font-variant`は、CSS1の頃から存在していましたが、デザイナーにはあまり浸透しませんでした。おそらく、長い間、`small-caps`を設定できなかったからでしょう。現在では、それとダウンロード可能なフォントを使って多くのことができるようになりましたが、著者はこの能力を活用していないようです。その使用率は今年大きく低下し、2020年の43％から2021年には23％に低下しました。

`font-variant`をもう少し詳しく見てみましょう。モバイルページの23％で使用されていますが、現在省略されているロングハンドのプロパティはほとんど使用されていません。以下は、`font-variant`だけでなく、それに対応するロングハンドをそれぞれ使用しているページの実際の数です。

<figure>
  <table>
   <thead>
    <tr>
      <th>プロパティ</th>
      <th>デスクトップ</th>
      <th>モバイル</th>
    </tr>
   </thead>
   <tbody>
    <tr>
      <td>`font-variant`</td>
      <td class="numeric">3,098,211</td>
      <td class="numeric">3,641,216</td>
    </tr>
    <tr>
      <td>`font-variant-numeric`</td>
      <td class="numeric">153,932</td>
      <td class="numeric">166,744</td>
    </tr>
    <tr>
      <td>`font-variant-ligatures`</td>
      <td class="numeric">107,211</td>
      <td class="numeric">112,345</td>
    </tr>
    <tr>
      <td>`font-variant-caps`</td>
      <td class="numeric">81,734</td>
      <td class="numeric">86,673</td>
    </tr>
    <tr>
      <td>`font-variant-east-asian`</td>
      <td class="numeric">20,662</td>
      <td class="numeric">20,340</td>
    </tr>
    <tr>
      <td>`font-variant-position`</td>
      <td class="numeric">5,198</td>
      <td class="numeric">5,842</td>
    </tr>
    <tr>
      <td>`font-variant-alternates`</td>
      <td class="numeric">4,876</td>
      <td class="numeric">5,511</td>
    </tr>
   </tbody>
  </table>
  <figcaption>{{ figure_link(
   caption="`font-variant`プロパティを使用しているページ数です。",
   sheets_gid="886194727",
   sql_file="all_properties.sql"
  ) }}</figcaption>
</figure>

これは、著者がショートハンドのみを使用し、ロングハンドを無視しているということでしょうか。しかし、昨年から `font-variant` の使用が急減していることから、一般的なフレームワークやツールがデフォルトスタイルから `font-variant` を削除したのではないかと考えています。いずれにしても、広くサポートされている多くのフォント機能を、作者は見逃しているのかもしれません。

もうひとつの低得点プロパティである`font-stretch`は、フォントファミリーがワイドまたはナローフェースを利用できるか、そして作者がそれらを利用することを選択するか（または知っているか）に大きく依存しているため、そのシェアが5％（昨年の8％から減少）となったことはあまり驚きではありません。

#### Flexbox

{{ figure_markup(
  image="usage-of-flex-shorthands-vs-longhands.png",
  caption="もっともよく使われるFlexbox関連のプロパティです。",
  description="ペアの列のチャートです。結果は以下の通りです。`flex-basis`では、デスクトップ35％、モバイル82％でした。`flex-direction`、デスクトップ90％、モバイル75％。`flex`, デスクトップ89％、モバイル68％。`flex-grow`、デスクトップ43％、モバイル66％。`flex-wrap`、デスクトップ70％、モバイル66％。`flex-flow`, デスクトップの23％とモバイルの35％。`flex-shrink`、デスクトップとモバイルの両方で32％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=772069330&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}

Flexboxのロングハンドとショートハンドのプロパティの中には、激動の歴史を持つものもあります。たとえば、CSS Flexboxの仕様自体、<a hreflang="en" href="https://drafts.csswg.org/css-flexbox-1/#flex-grow-property">作者が `flex-grow`、`flex-shrink`、`flex-basis` の使用を避け</a>、代わりに `flex` ショートハンドを使用することを推奨しています。これにより、設定されていないプロパティが適切な値を持つようになります。残念ながら、実際にはこれはうまくいっていないようで、モバイルページでは `flex-basis` が `flex` よりも多く使用されており、その差は10％以上にもなります。

この数字には、モバイルでは`flex-basis`の使用率が2倍になる一方、デスクトップではあまり変化がないなど、昨年と比較して大きな変動があることに留意する必要があります。これは、モバイル開発で使用される共通のフレームワークが変更されたことによるものかもしれませんし、その他の要因によるものかもしれません。

#### Grid

{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="もっともよく使われるグリッド関連のプロパティです。",
  description="すべての値がモバイル用に与えられたチャート。結果は以下の通りです。`grid-template-columns` 71％、`grid-template-rows` 34％、`grid-row-start` 33％、`grid-row` 32％、`grid-column-start` 27％、`grid-column-end` 26％、`grid-template-areas` 25％、`grid-gap` 24％、`grid-column` 23％、`grid-row-end` 10％、`grid-area` 9％、`grid-column-gap` 9％、`grid-auto-flow` 3％、`grid-row-gap` 2％、`grid-auto-rows` 1％. 以下はすべて0％です。`grid-auto-column`, `grid-template`, `grid`, `grid-column-span`, `grid-columns`, `grid-rows`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=2100289470&format=interactive",
  height=575,
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}

ここ数年の傾向として、グリッドのショートハンドプロパティ（`grid-template`、`grid`など）は、それらが包含するロングハンドプロパティよりもはるかに少ない頻度で使用されていることがわかっています。 実際には、両方とも0％という驚異的な数字で、ランキングでは隣り合っています。残りの略語はすべてこの2つに集約されており、`grid-template-rows`や`grid-column`などのロングハンドのプロパティは広く使用されています。実際、注目すべき使用率の高いロングハンドプロパティは`grid-gap`だけで、モバイルのグリッドページでは24％の使用率となっています。今後、より新しい、そして一般的な`gap`が`grid-gap`を追い越すかどうか、興味深いところです。

### CSSの間違い

人は成功からだけでなく、失敗からも多くのことを学ぶことができます。私たちはこの機会に、よくある間違いだけでなく、正しいように見えて正しくないものを探しました。

#### 回復不能なシンタックスエラー

今年の解析作業では、2020年と同様に<a hreflang="en" href="https://github.com/reworkcss/css">Rework</a>というCSSパーサーを使用しましたが、より心強い数字が得られました。デスクトップページのわずか0.94％、モバイルページの0.55％に回復不能なエラーが含まれていました。つまり、Reworkでスタイルシート全体を解析不可能なほどひどいエラーです。確かに、回復可能な小さなCSSエラーが発生したページの数は格段に多かったかもしれませんが、今年の回復不可能なエラーの数は、昨年に比べて大幅に減少しています。これは、シンタックスクリーンアップが突然発生したのではなく、Reworkが変更されたことを示していると考えられます。

#### 存在しないプロパティ

{{ figure_markup(
  image="most-popular-unknown-properties.png",
  caption="もっとも一般的な未知のプロパティです。",
  description="モバイル用の結果を一覧にしたグラフです。結果は以下の通りです。`webkit-transition` 14％、`font-smoothing` 14％、`tap-highlight-color` 9％、`behavior` 8%`box-orient` 5％、`-archetype` 4％. `webkit-box-orient`, `box-flex`, `box-align`, `box-pack` はすべて3％ です。`ms-transform` と `margin-center` はともに2％ です。`font-rendering`, `user-drag`, `text-fill-color` ではすべて0％を超えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=946019101&format=interactive",
  height=401,
  sheets_gid="1993096589",
  sql_file="meta_unknown_properties.sql"
) }}

私たちがチェックしたいことのひとつに、構文的には有効だが、実際には存在しないプロパティを使用している宣言の存在があります。これは、ベンダー接頭辞付きのプロパティは数えませんが、不正なベンダー接頭辞付きのプロパティは含みます。実際、もっとも広く見られた存在しないプロパティは`webkit-transition`（適切なベンダープレフィックスに必要な先頭の`-`がない）で、存在しないプロパティを含むすべてのページの14％に見られました。本質的に結びついていたのは `font-smoothing` で、これは `-webkit-font-smoothing` の接頭辞なしのバージョンで、実際には存在しませんし、[すぐに存在する可能性もありません](https://developer.mozilla.org/ja/docs/Web/CSS/font-smooth) 。

#### ショートハンドの前にロングハンド

本章の前のセクションでは、どのロングハンドプロパティが対応するショートハンドプロパティの後に出てくる可能性が高いかを調べました（たとえば、`background`の後に`background-size`が続くこともあります）。

{{ figure_markup(
  image="most-common-shorthands-after-longhands.png",
  caption="対応するロングハンド・プロパティの後に（不適切に）表示されるもっとも一般的なショートハンド・プロパティです。",
  description="モバイル用の値を使ったペアカラムのチャートです（デスクトップの常に1～2％以内）。結果は:次のとおりです。`background` 53％、`margin` 12％、`font` 12％、`padding` 8％、`animation` 4％、`border-radius` 3％、`list-style` 2％、`flex` 1％、`overflow` 1％、`transition` 1％、その他3％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=288419798&format=interactive",
  height=388,
  sheets_gid="1352208996",
  sql_file="meta_longhand_first_properties.sql"
) }}

ロングハンドの後にショートハンドを置くという逆のことをするのは、気が滅入るほどよくある間違いで、背景のプロパティでよく起こります。ロングハンドの後に対応するショートハンドを置く場合、背景のロングハンドプロパティは、`background`ショートハンドプロパティの値で上書きされます。

## Sass

CSSプリプロセッサの大きな利点の1つは、CSS自体に欠けているものを明らかにできるため、将来的にCSSをどのように拡張していくべきかの指針となることです。これは以前にもあったことで、変数はプリプロセッサで非常に人気があったため、CSSは最終的に<a hreflang="en" href="https://www.w3.org/TR/css-variables-1/">カスタムプロパティ</a>をそのレパートリーに加えました。色の変更やネストされたセレクターなど、プリプロセッサの他の機能も基本言語に組み込まれています。そこで本章では、現在ウェブ上でもっとも人気のあるプリプロセッサの1つであるSassを、開発者がどのように使っているかを紹介します。

{{ figure_markup(
  image="most-popular-sass-function-calls.png",
  caption="もっとも一般的に使用されるSassの関数呼び出しです。",
  description="モバイル用の値を使ったペアカラムのチャートです（デスクトップは常に1～2％以内）。その結果（その他）18％、`darken` 16％、`if` 15％、`map-get` 10％、`map-keys` 9％、`percentage` 7％、`nth` 5％、`lighten` 5％、`mix` 4％、(alpha adjustment) 3％、`length` 3％、`type-of` 3％、`unit` 2％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=714529985&format=interactive",
  height=552,
  sheets_gid="400373190",
  sql_file="sass_function_calls.sql"
) }}

使用されているSass関数は、比率に若干の変更はあるものの、2020年版Web Almanacで見つかったものとほぼ同じでした。タイプ別に分類すると、全Sass関数の28％が色を変更するもの（例：`darken`、`mix`）で、さらに6％が色成分を読み取るために使用されていることがわかりました（例：`alpha`、`blue`）。

{{ figure_markup(
  image="usage-of-control-flow-statements-in-scss.png",
  caption="もっとも一般的に使用されるSassのフロー制御構造です。",
  description="モバイル用の値を使ったペアカラムのチャートです（デスクトップは常に1～2％以内）。その結果、`@if`66％、`@for`58％、`@each`58％、`@while`2％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=438915471&format=interactive",
  sheets_gid="920758691",
  sql_file="sass_control_flow_statements.sql"
) }}

条件付きで動作させたいという要望は、`if()`関数がSass関数全体の15％で3位になったことからもわかります。

この同じ欲求は、`@if`のようなSassのフロー制御構造の使用でより明確に見ることができます。文字通り、すべてのSassスタイルシートの3分の2が `@if` を使用しており、半分以上が `@for` または `@each`（またはその両方）を使用しています。この人気の機能は、<a hreflang="en" href="https://drafts.csswg.org/css-conditional-4/#when-rule">最近CSSに追加されました</a>。対照的に、`@while`構造を使用しているのはわずか2％です。

{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="Sassでのルールネストの普及について。",
  description="モバイル用の値を使ったペアカラムのチャートです（デスクトップの常に1～2％以内）。結果は以下の通りです。合計87％、`@:pseudo-class` 85％、`&.class` 81％、`&::pseudo-element` 70％、`&`（単体）64％、`$[attr]` 59％、`& >` 27％、`& +` 26％、`& descendant` 18％、`&#id` 7％、`& -` 5％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=61926709&format=interactive",
  height=455,
  sheets_gid="1859409315",
  sql_file="sass_nesting.sql"
) }}

Sassのもう1つの大きな魅力は、他のルールの中にルールを入れ子にできるので、繰り返しのセレクタパターンを書く必要がないことです。この機能は、<a hreflang="en" href="https://www.w3.org/TR/css-nesting-1/">ネイティブのCSSで開発中</a>であり、その理由を我々の分析が示しています。すべてのSassスタイルシートの87％が、検出可能な形式のルールの入れ子を使用しています。特殊文字を必要としない暗黙的なネスティングは測定されませんでした。

## 結論

最後に、2021年版Web Almanacは、安定しつつも進化し続けるテクノロジーを物語っています。昨年のAlmanacと今年のAlmanacの間に大きな変化はほとんど見られず、明らかに成長しているプラクティスやウェブ機能もあれば、衰退し始めているものもありますが、全体的には継続性が非常に強く感じられました。

これはCSSが停滞しているということでしょうか？　そうではなくて、新しいレイアウト手法が増えたり、大きな新機能が開発されたりしていますが、その多くはプリプロセッサの領域で培われた手法に基づいています。私たちは、CSSが「解決済み」であるとか、「最善の方法がすでに確立されている」などとは考えていません。実務者が経験を積むことで、CSSという言語とCSSという実務の両方に変化が訪れるでしょう。その変化は、急激なものではなく徐々に、破壊的なものではなく着実なものになるかもしれませんが、これは成熟した技術に期待されることでもあります。

今後、CSSがどのように成長していくのか、楽しみにしています。
