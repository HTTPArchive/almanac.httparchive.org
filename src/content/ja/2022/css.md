---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: 2022年版Web AlmanacのCSSの章では、Web上でのCSSの使用に関するトレンド、変化、パターンを取り上げています。
hero_alt: Hero image of almanac chracters measuring and painting a web page.
authors: [rachelandrew]
reviewers: [svgeesus, j9t]
analysts: [rviscomi]
editors: [rviscomi]
translators: [ksakae1216]
rachelandrew_bio: Rachel Andrew はテクニカルライターとして Google に勤務し、<a hreflang="en" href="https://web.dev">web.dev</a> や <a hreflang="en" href="https://developer.chrome.com/">Chrome Developers site</a> に携わっています。フロントエンドおよびバックエンドのウェブ開発者、著者、講演者であり、<a hreflang="en" href="https://abookapart.com/products/the-new-css-layout">The New CSS Layout</a>など22冊の本の著者または共著者、オンとオフラインの両方で数多くの出版物の常連寄稿者でもあります。CSSワーキンググループのメンバーであるレイチェルは、Twitterで[@rachelandrew](https://x.com/rachelandrew)として愛猫の写真を投稿しているのを見ることができます。
results: https://docs.google.com/spreadsheets/d/1OU8ahxC5oYU8VRryQs9BzHToaXcOntVlh6KUHjm15G4/
featured_quote: ここ数年、CSSの新機能が続々と登場しています。その多くは、開発者がすでにJavaScriptやプリプロセッサで行っていたことにヒントを得たものですが、一方で、数年前には不可能だったことを可能にする方法を提供するものもあります。しかし、実際に開発者はその機能をWebページやアプリケーションで使っているのでしょうか？
featured_stat_1: 43%
featured_stat_label_1: カスタムプロパティを使用しているページの割合
featured_stat_2: 0.3%
featured_stat_label_2: 新しい `accent-color` プロパティを使用したページの割合
featured_stat_3: 12%
featured_stat_label_3: グリッドレイアウトを使用しているページの割合
---

## 序章

CSSは、Webページなどのレイアウトや書式設定に使われる言語です。構造を表す[HTML](./markup)、動作を表す[JavaScript](./javascript)に続く、Webの3大言語のひとつです。

ここ数年、CSSの新機能が続々と登場しています。その多くは、開発者がすでにJavaScriptやプリプロセッサで行っていたことにヒントを得たものですが、一方で、数年前には不可能だったことを可能にする方法を提供するものもあります。しかし、実際に開発者はその機能をWebページやアプリケーションで使っているのでしょうか？この疑問に対して、私たちはデータで答えようとしています。

この章ではTwitterで話題になったり、カンファレンスで紹介されたり、巧妙なデモで見つかったりした機能ではなく、開発者が実際に制作現場で使っているものをデータで調べています。どの新機能が採用され、どの古い技術が使われなくなり、どのレガシー技術がスタイルシートに、頑固に残っているかを見ることができます。

## 使用方法

毎年、CSSの規模が大きくなっていることがわかりますが、2022年も例外ではありませんでした。

{{ figure_markup(
    image="stylesheet-transfer-size.png",
    caption="スタイルシートの転送サイズのページ別分布。",
    description="ページあたりのスタイルシート転送サイズの10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページでは、6、28、68、139、256KBの値になっています。すべてのパーセンタイルにおいて、これらの統計値はデスクトップよりも10KB未満低くなる傾向があります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1081662712&format=interactive",
    sheets_gid="1921790724",
    sql_file="stylesheet_kbytes.sql"
  )
}}

25パーセンタイルが1ポイント下がった他は、各パーセンタイルでわずかながら増加した。90パーセンタイルでは、7%近く増加し、[2020](../2020/css) と [2021](../2021/css) の間で見られた増加と同様の増加でした。モバイル用のスタイルシートは、デスクトップ用に提供されるスタイルシートよりもわずかに小さいままです。

CSSのウェイトがもっとも大きいデスクトップ ページは62,631KBで、昨年よりわずかに小さくなっています。もっとも大きなモバイル用スタイルシートは、17,823KBから78,543KBに増加していますが、これはありがたいことに例外的なケースです。

{{ figure_markup(
    image="stylesheet-count.png",
    caption="ページごとのスタイルシート数の分布。",
    description="ページあたりのスタイルシート数の10、25、50、75、90パーセンタイルを示す棒グラフ。デスクトップとモバイルのページの値は、それぞれ1、3、7、13、22スタイルシート/ページでほぼ同じです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=358463962&format=interactive",
    sheets_gid="398646778",
    sql_file="stylesheet_count.sql"
  )
}}

ページあたりのスタイルシート数は2021年とほぼ同じで、50パーセンタイル台でモバイルが1つ増えています。

昨年は、1つのページが読み込むスタイルシートの数が2,368となり、記録が更新されました。今年は、モバイルで1,387個のスタイルシートを読み込んでいるサイトが見つかりましたが、それでもかなりの量です。

{{ figure_markup(
    image="rules-per-page.png",
    caption="ページごとのスタイルルールの総数の分布。",
    description="ページあたりのスタイルルールの数の10、25、50、75、90パータイルを示す棒グラフ。モバイルページとデスクトップページは非常に似ている傾向があります。モバイルの値は、1ページあたり52、224、613、1,197、2,023のルールです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=2137701589&format=interactive",
    sheets_gid="1977925185",
    sql_file="rules_per_stylesheet.sql"
  )
}}

ページ内のスタイルルールの数を見ると、すべてのパーセンタイルで増加しており、低いパーセンタイルほどモバイル向け、高いパーセンタイルほどデスクトップ向けのルールが多くなっています。この増加幅は相当なものです。50パーセンタイルではデスクトップのルールが130個、90パーセンタイルでは202個増えています。

{{ figure_markup(
    image="rules-per-stylesheet.png",
    caption="スタイルシートごとのルール数の分布。",
    description="スタイルシートごとのルール数の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルとデスクトップの値はほぼ同じです。モバイルページでは、スタイルシートあたりのルール数が0、4、31、110、285となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=56198269&format=interactive",
    sheets_gid="1977925185",
    sql_file="rules_per_stylesheet.sql"
  )
}}

読み込まれたスタイルシートの総数から、通常、人々はCSSを複数のスタイルシートに分割していることがわかります。50パーセンタイルでは、スタイルシートごとに31ルールが読み込まれ、90パーセンタイルでは、デスクトップで276ルール、モバイルで285ルールにまで増加します。

## セレクターとカスケード

2022年には、[`@layer`](https://developer.mozilla.org/docs/Web/CSS/@layer)がすべてのエンジンに搭載され、カスケードに関しても変化がありました。この新しいアットルールは、セレクターをレイヤーにグループ化し、そのレイヤーの優先順位を管理できます。

この新しいカスケード管理方法が広く使われるようになるにはまだ少し早いですが、セレクターの使い方がどのように進化してきたかを見てみましょう。

### クラス名

{{ figure_markup(
    image="top-selector-classes.png",
    caption="ページ数の割合でもっとも普及しているクラス名です。",
    description="もとも多くのページで使用されているCSSクラス名を棒グラフで表示。モバイルとデスクトップは同じような結果になっています。モバイルでは、クラス名のトップは`active`で、47%のページで使用されています。次に`fa`が33%、`fa`をプレフィックスとする他のクラスが32%、`wp`をプレフィックスとするクラスが31%となっています。残りの上位10クラスは、降順に並べると次のようになります。`button`が27%で `adoption`、 `pull-right`、 `emoji`、 `disabled` が26%、最後に `pull-left` と `title` が25%となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1082092053&format=interactive",
    height="691",
    sheets_gid="1020483137",
    sql_file="top_selector_classes_wp_fa_prefixes.sql"
  )
}}

2020年、2021年と同様、ウェブ上でもっとも普及しているクラス名は`active`です。Font Awesomeのプレフィックスである`fa`、`fa-*`は依然として2位と3位を占めています。しかし、`wp-*`クラス名は順位を上げ、4位となりました。2021年には20％だったのが、現在では31％のページで表示されています。また、`has-large-font-size`といったクラス名も登場しており、これらは新しいWordPressブロックエディターで使用されています。

トップ20から`clearfix`が消え、今では10%のページで見られるだけです。これは、フロートベースのレイアウトがウェブから消えつつあることを明確に示しています。

{{ figure_markup(
    image="top-selector-ids.png",
    caption="ページ数の割合でもっとも普及しているID名です。",
    description="もっとも多くのページで使用されているCSS IDを示す棒グラフ。モバイルとデスクトップの傾向は似ています。ID `content`は15%のページで使用され、次に`footer`が12%、`header`、`fb-root`、`fb_dialog_loader_close`、`fb_dialog_ipad_overlay`、`fb_dialog_loader_spinner`が10%、`respond`と`comments`%、そして最後に`main`が8%のページで使用されていることがわかります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=224121847&format=interactive",
    height="497",
    sheets_gid="756835829",
    sql_file="top_selector_ids.sql"
  )
}}

ID名は`content`がもっとも普及しており、`footer`、`header`がそれに続く。`fb_`で始まるIDは、Facebookウィジェットの使用を示しています。2021年には、GoogleのreCAPTCHAシステムの使用を示す`rc-`で始まるIDが7%のページで見られ、FacebookのID名に押されてトップ10から外れたものの、現在も同じ頻度で見られています。

### `!important`

{{ figure_markup(
    image="important-adoption.png",
    caption="ページごとの `!important` プロパティの数の分布。",
    description="1ページで使用される`!important`の数の10、25、50、75、90パーセンタイルを示す棒グラフです。モバイルページでは、それぞれ0%、1%、2%、5%、9%となっています。デスクトップの値も同じです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=316255168&format=interactive",
    sheets_gid="1802353995",
    sql_file="meta_important_adoption.sql"
  )
}}

今年は、上位2つのパーセンタイルで `!important` の使用率がわずかに増加しています。`@layer`の使用が定着するにつれて、通常は特異性の問題へ対処するために使用されるこのプロパティの使用にどのような影響を与えるか興味深いところです。

{{ figure_markup(
    image="important-props.png",
    caption="ページ数の割合で、`!important`が適用される上位のプロパティを示します。",
    description="`!important`で使用されるプロパティのうち、もっとも普及しているものを棒グラフで示した。モバイルページでは、`display`が83%、`color` 77%、`width` 76%、`height` 74%、`padding` 72%、`background`、`background-color`、`margin`がそれぞれ70%、`border` 69%、そして最後に`font-size`が64%という値になっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1202340370&format=interactive",
    height="604",
    sheets_gid="377488072",
    sql_file="meta_important_properties.sql"
  )
}}

`!important`が適用されるものについては、上位のプロパティは変更されていません。しかし、`position`は上位10位から外れ、`font-size`に置き換わりました。

### Selector specificity

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
        <td class="numeric">10</td>
        <td class="numeric">0,1,0</td>
        <td class="numeric">0,1,0</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">0,1,2</td>
        <td class="numeric">0,1,3</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">0,2,0</td>
        <td class="numeric">0,2,0</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">0,2,0</td>
        <td class="numeric">0,2,0</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">0,3,0</td>
        <td class="numeric">0,3,0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="ページごとの特異性の中央値の分布。",
    sheets_gid="1684019013",
    sql_file="specificity.sql"
  ) }}</figcaption>
</figure>

25パーセンタイル台のデスクトップを除き、特異度の中央値は昨年とまったく同じで、過去2年間一定です。これらの値は、<a href="https://en.bem.info/methodology/quick-start/" hreflang="en">BEM</a>などの方法論によって作られた平坦化された特異性を示しています。

### 擬似クラスと擬似要素

{{ figure_markup(
    image="pseudo-classes.png",
    caption="もっとも普及している擬似クラスのページ数割合。",
    description="もっとも多くのページで使用されている擬似クラスを棒グラフで表示。モバイルでは、`hover`が91%、`before` 77%、`focus` 76%、`after` 75%、`active` 73%、`first-child` 63%、`last-child` 60%、`not` 59%、その後、`visited`が48%、`root` 45%、`nth-child` 39%、`link` 34%、`disabled` 29%、`checked` 22%、最後に -ms-input-placeholderが19%となっていて人気が急激に低下することがわかります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=108638805&format=interactive",
    height="612",
    sheets_gid="370286500",
    sql_file="top_selector_pseudo_classes.sql"
  )
}}

今回もユーザーアクション擬似クラス `:hover`、`:focus`、`:active` が上位3位を占めています。否定擬似クラス `:not()` も、カスタムプロパティを作成するために使用される `:root` と共に、人気が上昇し続けているようです。

昨年、ユーザーの期待によりマッチする方法でフォーカスのある要素をスタイルする方法である `:focus-visible` が、ページの1%未満にしか出現していないことが指摘されました。このプロパティは、2022年3月以降、3つの主要なエンジンすべてで利用可能となり、現在ではデスクトップページの10％、モバイルページの9％で見られるようになっています。

{{ figure_markup(
    image="pseudo-elements.png",
    caption="もっとも普及している擬似要素のページ数比率。",
    description="もっとも多くのページで使用された接頭辞なしの擬似要素を棒グラフで示したものです。モバイルでは、`before`が41%、`after` 38%、`placeholder` 11%、`selection` 9%、`root`と`first-letter`が2%、`marker` 1%、そして`backdrop`、`full-page-media`、`file-selector-button`は1%未満しか登録していないことがわかります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1671689923&format=interactive",
    height="500",
    sheets_gid="425572900",
    sql_file="top_selector_pseudo_elements.sql"
  )
}}

接頭辞のついた、つまりブラウザ固有の擬似要素を除外しています。これらは通常、インターフェイスコンポーネントやブラウザクロームの一部を選択するために使用され、開発者が実際に使用している擬似要素に興味があります。

昨年から `::before` と `::after` の使用頻度が増えています。これらは、生成されたコンテンツをドキュメントへ挿入するために使用されます。`content` プロパティの使用状況を確認すると、空文字列を挿入するために使用されていることが多く、スタイリングのために使用されていることがわかります。生成されたコンテンツは、要素を追加することなくグリッド領域にスタイルを設定する方法の1つです。おそらく、これがこれらのプロパティの使用率の上昇に寄与しているのでしょう。

擬似要素である `::marker` の使用率が1%になり、リストマーカーを選択し、スタイルを設定する機能が徐々に利用され始めていることがわかります。

### 属性セレクター

{{ figure_markup(
    image="attribute-selectors.png",
    caption="もっとも普及している属性セレクター（ページ数の割合）です。",
    description="もっとも多くのページで使用されている属性セレクターを示す棒グラフ。もっとも多いのは`type`で54%、次に`class`で37%、`disabled` 24%、`dir` 17%、`role`と`title` 11%、`hidden`,`href` 10%、`aria-disabled` 9%、 style,src 8%、 `controls`,`id`で7%、 `lang`と`aria-hidden`で5%、そして`tabindex`、`name`、`data-type`、`aria-selected`で4%、最後に`multiple`で3%が挙げられています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1566442848&format=interactive",
    height="675",
    sheets_gid="1504728475",
    sql_file="top_selector_attributes.sql"
  )
}}

もっとも普及している属性セレクターは `type` で、54%のページで利用されています。次にもっとも普及している属性セレクターは `class` で37%、 `disabled` で25%、そして `dir` で17%のページで利用されています。

## 値と単位

CSSでは値や単位を指定する方法として、設定された長さや、グローバルキーワードに基づく計算など、複数の方法が用意されています。

### 長さ

{{ figure_markup(
    image="length-units.png",
    caption="もっとも普及している `<length>` 単位（ページ数の割合）。",
    description="もっとも多くのページで使用されている長さの単位を示す棒グラフです。もっとも普及している長さの単位はピクセル（`px`）で、71%のページで使用されており、パーセント（`%`）が18%、`em` 8%、`rem` 2%と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1742992649&format=interactive",
    sheets_gid="161285719",
    sql_file="units_frequency.sql"
  )
}}

ピクセルは、2021年と同じ71％で、もっとも普及している。用途の広がりもほぼ同じです。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロパティ</th>
        <th><code>px</code></th>
        <th><code>&lt;number&gt;</code></th>
        <th><code>em</code></th>
        <th><code>%</code></th>
        <th><code>rem</code></th>
        <th><code>pt</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>font-size</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 71%</td>
        <td class="numeric">2%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 15%</td>
        <td class="numeric">5%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 6%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 2%</td>
      </tr>
      <tr>
        <td>border-radius</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 64%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 20%</td>
        <td class="numeric">3.13%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 11%</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 2%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>line-height</td>
        <td class="numeric"><span class="numeric-bad">(▼5%)</span> 49%</td>
        <td class="numeric"><span class="numeric-good">(▲4%)</span> 35%</td>
        <td class="numeric">12.94%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 2%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>border</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 70%</td>
        <td class="numeric">28%</td>
        <td class="numeric">2%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>text-indent</td>
        <td class="numeric"><span class="numeric-bad">(▼5%)</span> 26%</td>
        <td class="numeric"><span class="numeric-good">(▲13%)</span> 65%</td>
        <td class="numeric"><span class="numeric-bad">(▼4%)</span> 5%</td>
        <td class="numeric"><span class="numeric-bad">(▼3%)</span> 5%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>vertical-align</td>
        <td class="numeric"><span class="numeric-bad">(▼26%)</span> 3%</td>
        <td class="numeric"><span class="numeric-bad">(▼9%)</span> 3%</td>
        <td class="numeric"><span class="numeric-good">(▲39%)</span> 94%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>gap</td>
        <td class="numeric"><span class="numeric-good">(▲4%)</span> 25%</td>
        <td class="numeric"><span class="numeric-bad">(▼6%)</span> 10%</td>
        <td class="numeric"><span class="numeric-good">(▲32%)</span> 33%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-bad">(▼31%)</span> 32%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>margin-inline-start</td>
        <td class="numeric"><span class="numeric-bad">(▼31%)</span> 7%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 49%</td>
        <td class="numeric"><span class="numeric-good">(▲30%)</span> 44%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>grid-gap</td>
        <td class="numeric"><span class="numeric-good">(▲5%)</span> 68%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 10%</td>
        <td class="numeric"><span class="numeric-bad">(▼2%)</span> 7%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 15%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>margin-block-end</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 3%</td>
        <td class="numeric"><span class="numeric-good">(▲54%)</span> 85%</td>
        <td class="numeric"><span class="numeric-bad">(▼53%)</span> 12%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>padding-inline-start</td>
        <td class="numeric"><span class="numeric-bad">(▼4%)</span> 29%</td>
        <td class="numeric"><span class="numeric-good">(▲11%)</span> 16%</td>
        <td class="numeric"><span class="numeric-bad">(▼10%)</span> 53%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 3%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>mask-position</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 3%</td>
        <td class="numeric"><span class="numeric-bad">(▼14%)</span> 36%</td>
        <td class="numeric"><span class="numeric-good">(▲10%)</span> 60%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(
    caption=" プロパティごとの分布。",
    sheets_gid="1471089154",
    sql_file="units_properties.sql"
  ) }}</figcaption>
</figure>

このグラフの上下の矢印は、[2021年の実績](../2021/css#fig-15)からの変化を示しています。昨年と同様に、ほとんどの場合、ピクセルの使用から他の長さ単位への移行が見られます。今回も `vertical-align` プロパティはピクセルと `<number>` の使用が大幅に減少し、 `em` の使用が大幅に増加しました。

{{ figure_markup(
    image="font-relative-length-units.png",
    caption="もっとも普及している相対的フォントの単位。",
    description="モバイルページにおける相対的フォントの単位を示す円グラフ。`em`が79.9％、`rem`が19.5％、`ch`が0.5％となっている。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1099832022&format=interactive",
    sheets_gid="161285719",
    sql_file="units_frequency.sql"
  )
}}

フォントのサイズ調整方法としては、`em`がもっとも普及しているが、`rem`への移行が続いており、昨年より若干（2ポイント弱）増加している。

{{ figure_markup(
    image="zero-length-units.png",
    caption="長さ0の値で使用される単位（またはその欠如）。",
    description="長さ0の値で使用される単位の相対的な普及率を示す円グラフ。もっとも普及しているのは86.6%のページで単位のない0、次に12.7%のページで`px`、そして0.7%のページでその他の単位が使われています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=782579377&format=interactive",
    sheets_gid="242535636",
    sql_file="units_zero.sql"
  )
}}

素の `<number>` 単位が許されるプロパティはいくつかありますが (たとえば `line-height`) 、`<length>` 値は、長さがゼロでも単位が不要という特殊なケースです。長さ0の値をすべて調べたところ、ほぼ87%が単位を省略しており、これは昨年より少し減少しています。単位を含む長さ0の値のほぼすべてがピクセル（0px）を使用していました。

### 計算方法

{{ figure_markup(
    image="calc-props.png",
    caption="`calc()`関数を使ったもっとも普及しているプロパティです。",
    description="もっとも多くのページで使用されている`calc()`プロパティを示す棒グラフ。もっとも普及しているのは`width`で27%、次いで`max-width`と`top`で14%、`height` 13%、`left` 10%、`max-height` 8%、`right`と`min-left` 6%、`min-height` 5%、`margin-right` 4%、`padding-left`,`margin-top` 3%、そして`padding-bottom`、`minage`、`bottom`、`padding-right`、`flex-basis`および`transform`ですべて2%となります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=203539180&format=interactive",
    height="695",
    sheets_gid="2120544742",
    sql_file="calc_properties.sql"
  )
}}

例年通り、`calc()`の、もっとも普及している用途は、widthの値です。この使用は12%ポイント減少しましたが、`max-width`の使用は9ポイント増加しました。

{{ figure_markup(
    image="calc-units.png",
    caption="`calc()` 関数で使用されるもっとも普及している長さの単位です。",
    description="もっとも多くのページで使用されているcalc()の単位を示す棒グラフ。パーセント (`%`) とピクセル (`px`) はともに42%のページで、ビューポート幅 (`vw`) とビューポート高さ (`vh`)と`em`はすべて8%のページで、`rem`は6%のページで使用されています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1749089658&format=interactive",
    sheets_gid="1431660156",
    sql_file="calc_units.sql"
  )
}}

計算にピクセルを使用しているサイトの割合は9ポイント減少し、現在では`%`の使用率と同じ42%になっています。ビューポートの単位である `vw` と `vh` は今年2%から8%に、 `em` は同じだけ増加し、 `rem` の使用率は3%から6%に倍増しています。

{{ figure_markup(
    image="calc-operators.png",
    caption="`calc()` 関数で使用されるもっとも普及している演算子です。",
    description="もっとも多くのページで使用されているcalc()演算子の棒グラフです。減算演算子（`-`）が42％、加算演算子（`＋`）が18％、除算演算子（`/`）が11％、乗算演算子（`*`）が10％となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1571752832&format=interactive",
    sheets_gid="220199231",
    sql_file="calc_operators.sql"
  )
}}

計算演算子では「引き算」が依然としてダントツの人気ですが、「足し算」が変わらない以外は、上位4つの値とも2021年以降に低下しています。

{{ figure_markup(
    image="calc-unit-complexity.png",
    caption="`calc()` の値で使用されるユニークな単位の数。",
    description="`calc()`1回あたりの単位数の分布を示す棒グラフ。79%の`calc()`が2つのユニットを使用し、次いで20%が1つのユニットを使用しています。3つ以上のユニットを使用するものは1%のみです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=220014387&format=interactive",
    sheets_gid="87407358",
    sql_file="calc_complexity_units.sql"
  )
}}

昨年と同様、`calc()`の値はかなり単純なものになる傾向があります。たとえば、ピクセルなどの固定長をパーセンテージから引くという一般的な使用例など、大多数が2つの値を使用しています。1単位の値が少し増加し、2単位の値が少し減少した。

## グローバルキーワード

{{ figure_markup(
    image="keywords.png",
    caption="グローバルキーワードの値の使用状況。",
    description="もっとも多くのページで使用されているグローバルキーワードの棒グラフです。`inherit`が87%、`initial` 64%、`unset` 51%、`revert` 4%で続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1675598127&format=interactive",
    sheets_gid="393924630",
    sql_file="keyword_totals.sql"
  )
}}

昨年はグローバルキーワードの使用率が大幅に上昇しましたが、2022年は`inherit`が同じ割合で使用されています。しかし、他の3つの数値は使用率が上昇しています。新しい値では、`revert`が1%から4%に増加しました。

## カスタムプロパティ

{{ figure_markup(
    image="custom-property-adoption.png",
    caption="過去4年間のカスタムプロパティの使用状況。",
    description="2019年以降のモバイルページにおけるカスタムプロパティの使用率の年次推移を示す棒グラフです。2019年から2022年にかけて、カスタムプロパティの使用率は5％から19％、29％、そして2022年の現在では42％にまで上昇しています。`var()`関数は、2020年に27％、2021年に35％、そして2022年の現在は43％のページで使用されています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=832908182&format=interactive",
    sheets_gid="786267748",
    sql_file="custom_property_adoption.sql"
  )
}}

カスタムプロパティ（CSS変数として知られることもある）の使用は大きく急増し、2021年から2022年にかけての成長も例外ではありません。デスクトップとモバイルの両方で、43%のページがカスタムプロパティを使用しており、少なくとも1つの `var()` 関数を持っています。

{{ figure_markup(
    image="custom-property-names.png",
    caption="一般的なカスタムプロパティ名のソース。",
    description="カスタムプロパティ名のソースの相対的な人気度を示す円グラフ。WordPressが40.2%、その他のソースが36.5%、Elementor 11.4%、Bootstrap 10.2%、そしてWoocommerce 1.3%となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=321767420&format=interactive",
    sheets_gid="409270558",
    sql_file="custom_property_names.sql"
  )
}}

昨年と同様に、WordPressは、もっとも一般的なカスタムプロパティ名のドライバーであり、これらは `-wp-*` というプレフィックスによって簡単に識別できます。これに続いて、`–white``–blue`などの色名が多く、特定の色合いを指定するために使用されています。

### 種類

{{ figure_markup(
    image="custom-property-value-types.png",
    caption="カスタムプロパティの値の種類を配布。",
    description="カスタムプロパティの値の種類の相対的な人気を示す円グラフ。カラー値を設定するカスタムプロパティが30.6%、ディメンションタイプ24.0%、その他のタイプが15.3%、数値タイプ11.4%、イメージ9.0%、フォントスタック7.6%、そして計算2.2%と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=2125209096&format=interactive",
    sheets_gid="1053355643",
    sql_file="custom_property_value_types.sql"
  )
}}

カスタムプロパティの値には、タイプが含まれる。たとえば、`--red: #EF2143`は `--red` に色の値を割り当てていますが、 `--multiplier: 2.5`は数値の値を割り当てています。タイプは昨年から少し変化しています。カスタムプロパティの用途としては、色を設定することがもっとも多く、カラータイプが見られるページも増えていることが分かっています。しかし、使用割合でいうと、40%から30%に低下しています。この分布に入るのが`calc()`であり、値型としてのimagesです。

### プロパティ

{{ figure_markup(
    image="custom-property-props.png",
    caption="もっとも普及しているカスタムプロパティのプロパティをページ数の割合で表示します。",
    description="もっとも多くのページで使用されているカスタムプロパティを含むプロパティを示す棒グラフ。`color`プロパティは38%のページでカスタムプロパティが設定され、`background-color`が34%、`background` 32%、`border-color` 30%、`font-size`と`width`が27%、`padding-top` 21%、`justify-content` 20%、`border` 19%、`height` 17%で続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1522542060&format=interactive",
    height="530",
    sheets_gid="1294760653",
    sql_file="custom_property_properties.sql"
  )
}}

これらのプロパティを含むページが増える一方で、カスタムプロパティを値として持つプロパティは昨年とほぼ同じ順位で推移しています。カスタムプロパティは `color` に使用されることが多いようです。当然のことながら、カラースキームの作成はこの機能の明らかな使用法です。しかし`var()`関数を使って`font-size`を設定することは、リストの10位から5位になり、`justify-content`のalignment値を設定することは、トップ10に移動しました。2021年にはモバイルページの5%、デスクトップページの4%がこのアライメント値を設定するためにカスタムプロパティを使用していましたが、これが20%に跳ね上がりました。データから、この増加の一部はWordPressの使用によるものであるように見えます。たとえば、5%のページが `-navigation-layout-justify` カスタムプロパティを使用しています。

### 機能

{{ figure_markup(
    image="custom-property-functions.png",
    caption="もっとも普及しているカスタムプロパティ機能をページ数の割合で示したもの。",
    description="もっとも多くのページで使用されているカスタムプロパティ関数の棒グラフです。もっとも普及しているのは`calc`で30%のページで使われ、次いで`linear-gradient` 11%、`rgba` 6%、`rotate`, `translate`, `scaleX`が5%、 `translateX`, `scaleY`, `translateY`, `skewY`, `skewX`, `min`は4%、`rgb`, `rotateY`, `rotateX`が3%のページで使用されていることがわかります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=580147519&format=interactive",
    height="525",
    sheets_gid="580592610",
    sql_file="custom_property_functions.sql"
  )
}}

カスタムプロパティの値型として `calc()` が注目され始めていることを見てきましたが、このように使われる関数は圧倒的に多いようです。続いて、`linear-gradient()`、アルファチャンネル付きのRGBカラー値を設定するための `rgba()` 関数と続きます。 続いて、トランジションやアニメーションに使われるさまざまな関数があり、この分野でのカスタムプロパティの利用が進んでいることがわかります。

### 複雑さ

カスタムプロパティを他のカスタムプロパティの値に含めることは可能です。2020年版Web Almanacの[この例](../2020/css#複雑さ)を考えてみましょう。

```css
:root {
  --base-hue: 335; /* depth = 0 */
  --base-color: hsl(var(--base-hue) 90% 50%); /* depth = 1 */
  --background: linear-gradient(var(--base-color), black); /* depth = 2 */
}
```

前の例のコメントで示したように、これらのサブリファレンスが連鎖すればするほど、カスタムプロパティの深さは大きくなります。

{{ figure_markup(
    image="custom-property-depth.png",
    caption="カスタムプロパティの深さの分布。",
    description="カスタムプロパティの深さの値の分布を示す棒グラフ。62% のカスタム・プロパティが深さ0であり、ネストされたカスタム・プロパティを保持してないことがわかります。36% の発生は深さが1で、1レベルのネストしたカスタム プロパティがあります。2%の出現は深さが2であり、1%未満は深さが3以上のカスタムプロパティを持っていました。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=742584548&format=interactive",
    sheets_gid="1220007551",
    sql_file="custom_property_depth.sql"
  )
}}

2021年に見られるように、大半のカスタムプロパティは深さが0であり、他のカスタムプロパティの値をその値に含めないことを意味する。深度1のプロパティの数は少し増え、深度2の数は少し減りました。しかし、このデータからは、過去1年間にカスタムプロパティの使い方がそれほど複雑になったとは思えません。

## 色

{{ figure_markup(
    image="color-formats.png",
    caption="もっとも普及しているカラーフォーマットの出現率。",
    description="もっとも多くのページで使用されているカラーフォーマットを棒グラフで示したもの。6桁の`#RRGGBB`構文が49%のページ、3桁の`#RGB`が25%のページ、`rgba`関数が14%のページ、透明キーワードが8%のページ、名前付きカラーが2%、`rgb`関数は1%、残りのフォーマットは1%未満のページで使用されており、以下の通りであった。8桁の`#RRGGBBAA`、`hsla`関数、`currentColor`キーワード、4桁の`#RGBA`、システムカラーキーワード、`hsl`関数、カラー関数、`hwb`関数、`lch`関数、そして最後に`lab`関数が、人気順に並んでいます。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=523191620&format=interactive",
    height="652",
    sheets_gid="750894349",
    sql_file="color_formats.sql"
  )
}}

伝統的な6桁の `#RRGGBB` 構文の使用は2021年以来変わっておらず、色の宣言の半分で使用されています。8桁の `#RRGGBBAA` 16進法が広く使われているにもかかわらず、`rgba()` 形式がアルファ成分を追加する方法としてもっとも広く使われているのは、おそらくこれがずっと以前にブラウザへ実装されたからでしょう。

他の値の使い方も同様で、ウェブコミュニティはまだ他のカラーフォーマットを利用し始めておらず、`hsl()`のような広くサポートされているものでさえも利用していません。

{{ figure_markup(
    image="color-keywords.png",
    caption="登場回数がもっとも少ないネーミングカラー。",
    description="もっとも少ないページ数で使用されたネームドカラーを示す棒グラフ。`MediumSpringGreen`は、わずか1,793のモバイルページで使用されています。そこから`DarkSalmon`、`MediumOrchid`、`DarkOrchid`、`MediumSlateBlue`、`LavenderBlush`、`RosyBrown`、`Moccasin`、`SpringGreen`、`Thistle`と徐々に採用が増え、2,205ページで使用されていることがわかります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=80217989&format=interactive",
    height="464",
    sheets_gid="2096495459",
    sql_file="color_keywords.sql"
  )
}}

8%のページがキーワード `transparent` を使用しており、もっとも普及している色の名前です。2%のページが他の色を使用しており、`white`がもっとも普及しており、`black`がそれに続いています。一方、`mediumspringgreen`はもっとも人気のない色として低迷しています。

### アルファのサポートと活用

{{ figure_markup(
    image="color-formats-alpha.png",
    caption="アルファ対応でもっとも普及しているカラーフォーマットです。",
    description="アルファをサポートしないフォーマットに対するアルファカラーフォーマットの普及率を示す棒グラフ。使用されているカラーフォーマットの23%がアルファをサポートし、77%がサポートしていない。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=806405561&format=interactive",
    sheets_gid="750894349",
    sql_file="color_formats.sql"
  )
}}

`rgba()`関数は3番目に普及しているカラーフォーマットで、`rgb()`形式よりもかなり多く使われていますが、これはおそらくアルファチャネルのサポートを利用するためと思われます。アルファチャンネルをサポートしている値とサポートしていない値の出現頻度を調べたところ、使用されているカラーフォーマットの77%はアルファチャンネルをサポートしていないことがわかりました。

{{ figure_markup(
    image="color-formats-alpha-distribution.png",
    caption="アルファ対応によるカラーフォーマットの分布。",
    description="アルファをサポートするカラーフォーマットの相対的な使用率を示す棒グラフです。`rgba`関数が14％、`transparent`キーワードが8％で使用されています。その他のフォーマットは1%未満です。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1242036465&format=interactive",
    sheets_gid="750894349",
    sql_file="color_formats.sql"
  )
}}

他のデータから予想されるように、`rgba()`はもっとも普及しているアルファ対応フォーマットで、`transparent`キーワードがそれに続いています。`hsla()`のような他のフォーマットはほとんど使われていません。

### 新しいカラープロパティと値

色の世界ではおもしろいことが起きています。新しい色空間に加え、色に関連するプロパティや値も多数登場しています。私たちは、これらのどれかがデータに影響を及ぼしているのではと考えました。

<a hreflang="en" href="https://web.dev/accent-color/">`accent-color`</a> プロパティを使うと、チェックボックス、ラジオボタン、レンジスライダーなど、スタイルが決まりにくいフォーム要素にアクセントカラーとしてブランドカラーを追加できます。今年3月から全エンジンに搭載されたばかりのためか、使用率はまだ0.3％未満です。

今年、すべてのエンジンで利用可能になったもうひとつのプロパティは [`color-scheme`](https://developer.mozilla.org/docs/Web/CSS/color-scheme) で、コンポーネントをどの配色（明暗）でレンダリングするかを指定できます。このプロパティは、意外なことに、今のところ0.2%のページでしか見つかっていない。

## グラデーションと画像

{{ figure_markup(
    image="gradient-functions.png",
    caption="もっとも普及しているグラデーション機能をページ数の割合で紹介。",
    description="もっとも多くのページで使用されたグラデーション機能を示す棒グラフです。`linear-gradient`が76%のページで、次いで `-webkit-linear-gradient`が53%、`-webkit-gradient` 44%、`-o-linear-gradient` 43%、`-moz-linear-gradient` 38%、`-ms-linear-gradient` 23%、 `radial-gradient` 15%、`-webkit-radial-gradient` 6%、 `repeat-linear-gradient` 4%、最後に `-moz-radial-gradient`が2%のページで使用されました。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=824533060&format=interactive",
    height="486",
    sheets_gid="972045834",
    sql_file="gradient_functions.sql"
  )
}}

リニアグラデーションは引き続き主要な選択肢であり、2021年よりもわずかに高い割合で表示されていますが、グラデーションの使用は過去2年間ほぼ同じです。`linear-gradient`プロパティに関しては、9年以上前からすべてのエンジンで接頭辞なしでサポートされているにもかかわらず、接頭辞の使用頻度が非常に高いです。

### 画像フォーマット

{{ figure_markup(
    image="image-formats.png",
    caption="CSSから読み込まれる画像フォーマット。",
    description="CSSで読み込まれる画像のフォーマットについて、相対的な人気を示す円グラフ。PNGが30.3%を占めSVGが23.1% 、GIFが19.0% 、JPGが18.1%、WebP 9.3%と続き、その他の形式は1%未満に留まっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1771292057&format=interactive",
    sheets_gid="947921429",
    sql_file="image_formats.sql"
  )
}}

この表は、CSSから読み込まれる画像の画像形式を分類したものです。HTMLから読み込まれる画像は含まれず、スタイルルールに表示される画像のみです。PNGが44%から30%に減少し、SVGとWebPがそれぞれ6%ポイント増加しています。

### CSSに含まれる画像の数

{{ figure_markup(
    image="css-initiated-images.png",
    caption="CSSから読み込んだ画像の枚数分布。",
    description="ページ毎のCSSから読み込まれる画像の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルページの値はそれぞれ1、1、3、5、10であり、デスクトップの値と非常によく似ています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1307100659&format=interactive",
    sheets_gid="504054046",
    sql_file="image_weights.sql"
  )
}}

CSSから読み込まれる画像の数は、2021年と同じままです。CSSは多くの画像を読み込む原因にはなりません。下位2パーセンタイルはそれぞれ1枚、90パーセンタイルでも、すべての画像タイプで10枚前後を推移しています。

### CSSにおける画像の重み付け

CSSでは画像の読み込みはあまり発生しませんが、その画像の重さは重要です。データでは、画像の数は変わらないにもかかわらず、画像の重さが2021年から増えていることがわかりました。

{{ figure_markup(
    image="image-weights.png",
    caption="CSSから読み込まれる画像の総重量の分布。",
    description="ページごとにCSSから開始された画像バイトの合計の10、25、50、75、90パーセンタイルを示す棒グラフです。モバイルページでは、1、3、17、134、547KBとなっています。デスクトップ用ページでは高いパーセンタイルで、数十KB単位でより重い画像が、読み込まれる傾向があります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1802160609&format=interactive",
    sheets_gid="504054046",
    sql_file="image_weights.sql"
  )
}}

中央のページでは、モバイルで1KB増加し、17KBとなっています。しかし、グラフの上端、90パーセンタイルでは、モバイルで67KB、デスクトップで42KB増加していることがわかります。2021年と同様、モバイルでは一貫してウェイトが低くなっており、開発者がより小さな画像をモバイルのコンテキストに提供しようとしていることがうかがえます。

### CSSにおける画像のピクセルサイズ

{{ figure_markup(
    image="image-dimensions.png",
    caption="CSSから読み込んだ画像のサイズ分布。",
    description="1ページあたりのCSSで開始された画像サイズの25、50、75パーセンタイルを示す棒グラフ（単位は平方ピクセル）。モバイルページでは、729、2,910、44,096ピクセル平方という値になっています。デスクトップ用ページでは、かなり小さい画像が読み込まれる傾向にあります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=86638563&format=interactive",
    sheets_gid="366877201",
    sql_file="image_dimensions.sql"
  )
}}

このグラフは興味深いもので、グラフの下限では、デスクトップとモバイルでほぼ同じサイズの画像を提供していること、50および75パーセンタイルでは、デスクトップよりもはるかに大きな画像をモバイルユーザーに提供していることを表しています。このデータからわかることは、モバイルユーザーに対して、より大きな画像を配信しているということです。おそらく、タブレット端末のランドスケープモードを考慮しているのでしょう。

## レイアウト

ウェブでレイアウトを行う際には、多くの選択肢から選ぶことができ、ほとんどのサイトでは、これらのさまざまな方法が使用されていることでしょう。使用されているレイアウト方法を検出するために、プロパティと値の組み合わせでデータを簡単に検索すると、次の表が得られます。

{{ figure_markup(
    image="layout-props.png",
    caption="ページ数の割合によるレイアウト方法。",
    description="もっとも多くのページで使用されているレイアウト方法を示す棒グラフです。`block` と `absolute` レイアウトが92%のページで使用されており、次に `inline-block` が90%、 `floats` が89%、 `fixed` が84%、 `inline` が82%、CSSテーブルが79%、 `flex` が77%、そして `box` が51%のページで使用されていることがわかります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1738709324&format=interactive",
    height=756,
    sheets_gid="1793404870",
    sql_file="layout_properties.sql"
  )
}}

この表は、そのページで使われている主なレイアウト方法を教えてくれるものではありません。これらのページのCSSに表示されるプロパティまたは値を示しています。たとえば、51% のページが2009年の古いバージョンのflexboxを使用しており、`display: box` と表示されています。これは後方互換性のために、おそらくAutoprefixerなどのツールで追加されたものと思われます。

### フレックスボックスとグリッドの採用

{{ figure_markup(
    image="flexbox-grid.png",
    caption="過去4年間のFlexboxとグリッドの採用状況。",
    description="2019年から2022年までのモバイルページにおけるフレックスボックスとグリッドの採用傾向を年別に示した棒グラフです。フレックスボックスは、2019年に49％、2020年に63％、2021年に71％、2022年に74％のページで使用されました。グリッドは2019年に2％、2020年に5％、2021年に8％、2022年に12％のページで使用されています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1410523848&format=interactive",
    sheets_gid="1855799827",
    sql_file="flexbox_grid.sql"
  )
}}

フレックスボックスとグリッドの利用が増え続けています。2021年、フレックスボックスの採用率は71％でしたが、現在は74％に達しています。グリッドは8%から12%に急増しています。前のセクションとは対照的に、ここで測定されているのは、レイアウトに実際にフレックスボックスやグリッドを使用しているページの割合であり、スタイルシートに単に何らかのフレックスボックスやグリッドのプロパティを持つページとは異なることに注意してください。

グリッドの採用はかなり遅れています。これは、レイアウトに使用されるフレームワークが普及しており、その多くがフレックスボックスをベースとしたレイアウトを採用しているためだと思われます。

また、この新機能の採用がどのように進展しているかを見るために、私たちにとって新しい `flex` と `grid` のプロパティの値もいくつか見てみました。

`flex-basis` プロパティのcontentの値は、ブラウザがアイテムに設定された幅ではなく、アイテムに内在するコンテンツのサイズを参照するよう明示的に指示するものです。これは新しい値で、執筆時点ではSafariのリリースバージョンでは使用できません。現在、この値を使用しているのは、モバイルサイトの0.5%、デスクトップサイトの0.6%にすぎません。

`grid-template-rows` と `grid-template-columns` の `subgrid` 値は、クエリを実行した時点では、Firefoxでのみサポートされています。当然といえば当然ですが、データセット全体のうち、モバイル向けは211ページ、デスクトップ向けは212ページにしか登場しません。[Interop 2022](./interoperability)プロジェクトの一環としての価値なので、これが相互運用可能になった後、どのように支持が広がっていくのかに注目したいですね。

### Box sizing

{{ figure_markup(
    content="92%",
    caption="`box-sizing: border-box`を設定したページの割合。",
    classes="big-number",
    sheets_gid="859735058",
    sql_file="box_sizing.sql"
  )
}}

ウェブは圧倒的に、オリジナルのW3Cボックス モデルを拒否して `box-sizing: border-box` を支持することに票を投じました。このプロパティと値の組み合わせを使っているページの数は、また少し増えて90%以上になっています。


{{ figure_markup(
    content="44%",
    caption="セレクター `*` で `box-sizing: border-box` を宣言しているページの割合です。",
    classes="big-number",
    sheets_gid="1754933881",
    sql_file="box_sizing_border_box_selectors.sql"
  )
}}

分析したページのほぼ半数が、ユニバーサルセレクター（`*`）を介して、ページ上のすべての要素に `border-box` のサイズ設定を適用しています。

約22％のページがチェックボックスとラジオボタンに `border-box` を使用しています。また、`.wp-`クラスが多く、分析したページの20%でWordPressが使用されていることがわかります。

{{ figure_markup(
    image="box-sizing.png",
    caption="ページごとの `border-box` 宣言の数の分布。",
    description="1ページあたりの`box-sizing: border-box`宣言の数の10、25、50、75、90パーセンタイルを示した棒グラフです。数値は順に1ページあたり1、7、22、52、101個の宣言があります。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1043112167&format=interactive",
    sheets_gid="859735058",
    sql_file="box_sizing.sql"
  )
}}

モバイルページの中央値では、`border-box`は22回宣言されています。90パーセンタイルでは、101回と圧倒的な回数です。なお、前年のクエリには、この指標に影響を与えるバグがありました。それを修正すれば、2021年の結果は同等になります。

### マルチカラム

{{ figure_markup(
    content="23%",
    caption="マルチカラムレイアウトを使用しているページの割合。",
    classes="big-number",
    sheets_gid="1226061352",
    sql_file="multicol.sql"
  )
}}

[CSS 段組みレイアウト](https://developer.mozilla.org/docs/Web/CSS/CSS_Columns)レイアウトの利用が再び増加し、現在23%のページで見られ、2021年から3ポイント上昇しました。

### `aspect-ratio`プロパティ

{{ figure_markup(
    content="2%",
    caption="`aspect-ratio`プロパティを使用しているページの割合です。",
    classes="big-number",
    sheets_gid="1009310505",
    sql_file="all_properties.sql"
  )
}}

新しい `aspect-ratio` プロパティは、2%のページで使用されています。これは2021年末から相互運用可能になったので、このプロパティの使用率が時間とともに伸びていくのが興味深いところです。

## トランジションとアニメーション

`animation`プロパティは、モバイルページの77％（昨年と同じ）に表示され、デスクトップでは76.8％とわずかに増加しました。`transition` プロパティはさらに人気があり、モバイルページの85％、デスクトップページの85.6％に見受けられます。デスクトップの頻度は、2021年から4ポイントほどわずかに減少しています。

{{ figure_markup(
    image="transition-props.png",
    caption="もっとも普及している `transition` プロパティを、ページ数の割合で表示します。",
    description="もっとも多くのページで使用されているトランジションプロパティを棒グラフで表示しています。もっとも多くのページで使われているプロパティは`all`53％で、以下、`opacity`が50％、`transform` 38％、`none` 25％、`height` 22％、`color` 21％、`background-color` 20％、`background` 17％、`box-shadow` 13％、`left` 12％、`width`、`top`と `-webkit-transform` 10%、`border-color`と`visibility` 8％と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1745619326&format=interactive",
    height="533",
    sheets_gid="349042756",
    sql_file="transition_properties.sql"
  )
}}

昨年と同様、もっとも一般的な使用法は、`all`キーワードですべてのアニメート可能なプロパティにトランジションを適用することです。この使用法は7ポイント増の53%に達し、次いで50%のページで `opacity` が使用されています。

{{ figure_markup(
    image="transition-durations.png",
    caption="遷移期間の分布。",
    description="遷移期間の10、25、50、75、90パーセンタイルを示した棒グラフ。数値は順に100、170、300、400、1,000ミリ秒。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=364746687&format=interactive",
    sheets_gid="1177632572",
    sql_file="transition_durations.sql"
  )
}}

遷移の持続時間を見ると、昨年からの変化が見られます。 2021年、90パーセンタイルでは、遷移時間の中央値は0.5秒でしたが、現在では1秒に跳ね上がっています。上位4つのパーセンタイルすべてで増加していることがわかります。

{{ figure_markup(
    image="transition-delays.png",
    caption="遷移遅延の分布。",
    description="遷移遅延の10、25、50、75、90パーセンタイルを示す棒グラフ。値の順番は -600、0、140、300、500ミリ秒。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=658113477&format=interactive",
    sheets_gid="1737381354",
    sql_file="transition_delays.sql"
  )
}}

また、遷移遅延の分布も変化しています。90パーセンタイルの遅延は1.7秒から0.5秒に減少している。しかし、10パーセンタイルの遅延の中央値は0.5秒以上になっています。これは、トランジションがアニメーションの途中から始まる場合に見られます。

{{ figure_markup(
    image="transition-keyframe-distribution.png",
    caption="アニメーションごとのキーフレームの分布。",
    description="アニメーションごとのキーフレーム数の10、25、50、75、90パーセンタイルを示す棒グラフです。値の順番は2、2、2、3、5キーフレームです。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=646157411&format=interactive",
    sheets_gid="376876473",
    sql_file="transition_keyframes_distribution.sql"
  )
}}

また、1つのアニメーションに使用されるキーフレームの平均数を調べたところ、6,995個という驚異的な数のキーフレームを使用しているサイトが見つかりました。しかし、これは異常なことで90パーセンタイルでも、1アニメーションあたりのキーフレーム数は、デスクトップとモバイルの両方で5個です。

{{ figure_markup(
    image="transition-keyframe-stops.png",
    caption="もっとも普及しているトランジションキーフレームを出現率で表示。",
    description="遷移ルールの中でもっとも多く使用されているキーフレームを棒グラフで示したものです。もっとも普及しているキーフレームは0%で22%、次いでtoが16%、100%は15%、fromで7%、残りのキーフレームは50%、60%、40%、80%、20%、75%、90%と徐々に減少し、採用率は2%で終了しています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=550751466&format=interactive",
    sheets_gid="1859883128",
    sql_file="transition_keyframe_stops.sql"
  )
}}

ご想像の通り、もっとも普及しているのは0%から100%までで、次いで50%となっています。開発者は一般的にこれらのストップを10%間隔で設定し、たとえば33%を使っているページはわずか1%です。

{{ figure_markup(
    image="transition-timing-functions.png",
    caption="タイミング機能の配布。",
    description="タイミング機能の使用率の相対的な分布を示す円グラフ。`ease`が31.8%、`linear` 17.9%、`ease-in-out` 17.5%、`cubic-bezier` 16.4%、`ease-out`は8.4%、`ease-in` 5.2%、`steps`が2.8%の順で使用されました。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=586595091&format=interactive",
    sheets_gid="1907298177",
    sql_file="transition_timing_functions.sql"
  )
}}

2021年と比較すると、遷移時に使用されるタイミング機能の分布はほとんど変化していない。当時と同様に、明確なトップは`ease`です。

{{ figure_markup(
    image="transition-animation-names.png",
    caption="アニメーション名で識別されるアニメーションの種類。",
    description="もっとも多く使われているアニメーションの種類を示す棒グラフ。もっとも普及しているのはuncategorizedで13%、次いで`rotate` 13%、`bounce` 11%、`slide` 10%、`fade` 9%、`wobble` 5%、`scale` 4%、`pulse` 2%、`visibility` 2%となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=214267440&format=interactive",
    height="463",
    sheets_gid="1632805666",
    sql_file="transition_animation_names.sql"
  )
}}

開発者がアニメーションを何に使っているかを理解するために、アニメーションクラスに使われている名前を見てみました。たとえば、クラス名に `spin` が含まれるものは、rotateと判断されます。Rotateアニメーションは、2021年と同じくもっとも普及しています。しかし、その割合は18%から13%に低下し、bounceアニメーションは5位から3位にランクアップしています。

昨年同様、unknown/otherが多いのは、クラス名`a`が多いためで、特定のアニメーションタイプに対応させることができないためです。

## 視覚効果

{{ figure_markup(
    content="18%",
    caption="ブレンドモードを使用しているページの割合です。",
    classes="big-number",
    sheets_gid="971500",
    sql_file="effects_blend_mode_popularity.sql"
  )
}}

CSSで使用されているいくつかの視覚効果について調べました。たとえば、デスクトップページの18%は `background-blend-mode` または `mix-blend-mode` プロパティでスタイルを定義しています。

{{ figure_markup(
    image="blend-mode-values.png",
    caption="ブレンドモードを設定するページでもっとも普及しているブレンドモード。",
    description="もっとも多くのページで使用されているブレンドモードを示す棒グラフ。ブレンドモードプロパティを設定したページの42%で乗算値が使用され、次いで33%のページで`overlay`と`screen`、32%で`darken`、31%で`lighten`、29%で`soft-light`、28%で`color`、28%で`color-burn`と`color-dodge`、最後に21%で`difference`となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=204649391&format=interactive",
    height="515",
    sheets_gid="648874350",
    sql_file="effects_blend_mode_values.sql"
  )
}}

ブレンドモードでもっともよく見られる値は`multiply`で、42%のページで見られました。しかし、他の値についても、かなりの割合で分布しています。

約18%のページが、カスタムプロパティ `var(--overlay-mix-blend-mode)` を使っていました。これは、何らかのライブラリやツールに由来する、特定の名前です。

{{ figure_markup(
    image="filter-functions.png",
    caption="フィルターを設定するページでもっとも普及しているフィルター機能。",
    description="フィルターを設定しているページでもっとも多く使われている関数を棒グラフにしたもの。アルファ関数が82％、フィルターなし（none）59％、`progid:DXImageTransform.Microsoft.gradient` 46％、`blur` 31％、`drop-shadow`と`grayscale` 22％、`brightness` 20％、`progid:DXImageTransform.Microsoft.BasicImage`と`inherit` 10％、`url`、`sepia`、`contrast`、`none` `!important`すべて8％となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1568163707&format=interactive",
    height="591",
    sheets_gid="1004790461",
    sql_file="effects_filter_functions.sql"
  )
}}

グラフィカルな効果を適用するフィルターを設定しているページの割合のうち、82%がInternet Explorer 8以下で使用される非標準の値である `alpha()` を使用しています。また、<a hreflang="ja" href="https://learn.microsoft.com/ja-jp/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms532997(v=vs.85)">`Microsoft.gradient()`</a> フィルターの使用率も高いことがわかります。

[標準値](https://developer.mozilla.org/docs/Web/CSS/filter)のうち、31%のページで `blur()` が使用されており、`none` に次いでもっとも普及している値となっています。

{{ figure_markup(
    image="clip-path-functions.png",
    caption="`clip-path()`を設定したページで、人気のある `clip-path` 値です。",
    description="`clip-path`を設定しているもっとも多くのページで使用されている`clip-path`の値を示す棒グラフです。もっとも普及している値は`inset`で88%、次いで`none`70%、`polygon`17%、`var`9%、`circle`7%、`url`3%、`ellipse`2%となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=163739565&format=interactive",
    sheets_gid="1458239816",
    sql_file="effects_clip_path_functions.sql"
  )
}}

`clip-path` を使って要素をクリップしているページでは、大多数が `inset()` という、単純に要素のボックスを挿入する値を使っており、`clip-path` を使っているページの88% がこの関数を使っているとのことです。

その後、値 `none` もありますが、ほとんどの開発者は、独自のパスをもっとも柔軟に定義できる値である `polygon()` を使うことにしています。

## レスポンシブデザイン

多くの開発者が[コンテナクエリ](https://developer.mozilla.org/docs/Web/CSS/CSS_Container_Queries)を熱望しており、フレックスボックスやグリッドなどの新しいレイアウト手法によって、複数の画面サイズでうまく動作するデザインが可能になることも多いですが、レスポンシブデザインを行うページの大半で[メディアクエリ](https://developer.mozilla.org/docs/Web/CSS/Media_Queries/Using_media_queries)が使用されています。

開発者がメディアクエリを書くとき、もっとも多いのはビューポートの幅をテストすることです。`max-width`と`min-width`は、2020年、2021年と同じように、もっとも普及しているクエリでした。3位と4位の結果も順位変動はありませんでした。

{{ figure_markup(
    image="media-query-features.png",
    caption="人気のメディアクエリ機能。",
    description="もっとも多くのページで使用されているメディアクエリ機能を示す棒グラフ。もっとも普及しているのは83%のページで`max-width`、次いで`min-width` 79%、`-webkit-min-device-pixel-ratio` 35%、 `prefers-reduced-motion` 34%、 `orientation` 30%、 `max-device-width` 26%、 `-ms-high-contrast` 24%、 `max-height` 23%、 `min-resolution` 19% となっています。`-webkit-transform-3d`および`transform-3d` 12%, `min-device-pixel-ratio`および`min-height` 11%、`min--moz-device-pixel-ratio`は10%、`forced-colors`、`min-device-width`と`prefers-color-scheme`が8%、`-o-min-device-pixel-ratio` 7%、`hover` 5%、`pointer` 2%です。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=2066259966&format=interactive",
    height="598",
    sheets_gid="2106336302",
    sql_file="media_query_features.sql"
  )
}}

しかし、2021年にランキング上昇を指摘された`prefers-reduced-motion`メディアクエリは、今回`orientation`を抑えて4位を獲得しました。これは、`prefers-reduced-motion`が2%上昇した一方で、`orientation`が4%下落したためです。

{{ figure_markup(
    image="prefers-features.png",
    caption="ユーザー・プレファレンス機能の使用率（ページ数ベース）。",
    description="`prefers`が付くメディアクエリ機能を示す棒グラフ。もっとも普及している値は34%のページで`prefers-reduced-motion`、次に`prefers-color-scheme` 8%、`prefers-contrast` 1%、`prefers-reduced-transparency` 1%未満となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=632942914&format=interactive",
    sheets_gid="2106336302",
    sql_file="media_query_features.sql"
  )
}}

`prefers-*` ユーザープリファレンス機能だけを見ると、`prefers-reduced-motion` がもっとも普及していることがわかります。これは、ブラウザのサポートが良く、ウェブ上でアニメーションや遷移が普及していることが原因です。`prefers-color-scheme` 機能は、ユーザーが明るい色か暗い色のどちらを好むかをチェックする機能で、ウェブサイトやアプリケーションでダークモードを使用することが一般的になったため、使用率がわずかに増加しています。

{{ figure_markup(
    image="hover-features.png",
    caption="ホバーやポインターのメディア機能を利用する。",
    description="ホバーとポインターのメディア機能の人気を示す棒グラフ。ホバー機能は5%、ポインターでは2%、エニーポインターとエニーホバーは1%以下のページで使用されています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1898240066&format=interactive",
    sheets_gid="2106336302",
    sql_file="media_query_features.sql"
  )
}}

メディア機能の `hover` と `pointer` は、開発者がデバイスの機能をテストし、ユーザーがどのようにデバイスとインタラクトしているかを確認するのに役立ちます。たとえば、大型のタブレットやタッチスクリーンのラップトップが数多く使用されていることから、ユーザーがタッチスクリーンを使用しているかどうかを発見するには、スクリーンサイズだけよりもこれらの機能の方が適しています。

`hover` と `pointer` の両方がもっとも多い機能のトップ10に入っています。あまり役に立たない `any-pointer` と `any-hover` はほとんど使われていないようです。`any-pointer` を使用すると、 `pointer` が現在タッチスクリーンを使用していることを示していても、ユーザーがマウスやトラックパッドなどの細かいポインターにアクセスしているかどうかを判断できます。これらの機能を組み合わせることで、ユーザーがどのような環境で作業しているかを把握できます。

### 共通ブレークポイント

{{ figure_markup(
    image="media-query-breakpoints.png",
    caption="もっとも普及しているブレイクポイントの分布。",
    description="メディアクエリで使用されるもっとも普及しているブレイクポイントを示す棒グラフ。35%のページが`max-width` に480pxを、23%が`min-width` に使用しています。39%のページが`max-width` に600pxを、32%が`min-width` に600pxを使用しています。51%のページが`max-width` に767px、`min-width` に8%を使用。38%のページが`max-width` に768px、`min-width` に57pxを使用しています。12%のページが`max-width` に782pxを、`min-width` に25%を使用しています。25%のページが`max-width` に800pxを、`min-width` に7%を使用。29%のページが`max-width` に991pxを、`min-width` に3%を使用しています。13%のページが`max-width` に992pxを、`min-width` に39%を使用しています。26%のページが`max-width` に1024pxを、17%が`min-width` に1024pxを使用。19%のページが`max-width` に1200px、`min-width` に42%を使用しています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1285928011&format=interactive",
    sheets_gid="1037504354",
    sql_file="media_query_values.sql"
  )
}}

過去2年間と同様、共通のブレイクポイントはほとんど変化していません。グラフは同じ形をしており、もっとも一般的なブレークポイントは、`max-width`が767px、`min-width`が768pxとなっています。2021年に述べたように、これはポートレートモードのiPadに対応します。

繰り返しますが、ブレイクポイントは圧倒的にピクセル値で設定されているので、他の値をピクセルに変換してグラフにすることはしていません。最初の `em` 値は、やはり `48em` で、位置78で見つかりました。

## クエリで変更されたプロパティ

メディアクエリブロック内に表示されるプロパティを調べ、ブレークポイントに応じてどのプロパティを変更しているかを確認しました。

{{ figure_markup(
    image="media-query-props.png",
    caption="メディアクエリーブロックでもっとも普及しているプロパティです。",
    description="メディアクエリブロックの中でもっとも多くのページで使用されているプロパティを示す棒グラフ。ディスプレイと幅のプロパティは83%のページでメディアクエリに含まれており、`height`と`padding`は78%、`margin-left` 77%、`font-size` 76%、`margin`と`position` 75%、`margin-right`、`left`、`top`、`margin-top`、`max-width`  74%、`right`と`margin-bottom` 73%、`padding-left` 72%、`text-align` 71%、`padding-right` 70%、`background` 69%、`float` 67%と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1670810448&format=interactive",
    height="714",
    sheets_gid="2050421561",
    sql_file="media_query_properties.sql"
  )
}}

メディアクエリで変更されたプロパティでは、`display`プロパティがもっとも多いのですが、順位に若干の入れ替えがありました。これらは、見た目ほど劇的な変化ではありません。`color` プロパティはチャートから消えましたが、これは74%から67%への変化を表しているに過ぎません。しかし、`background-color`の使用率は65%から63%に減少しています。これは、何らかのフレームワーク、あるいはWordPressがスタイルシートでこれを使用しなくなったのではないかと思わされます。

もう1つ興味深いのは、2020年には`font-size`がメディアブロックの73%に出現し、5位であったことです。2021年には60%のブロックに表示され、12位に表示されました。今年は76％、6位と順位を上げている。

## 機能クエリ

CSS機能の対応テストに使用されるフィーチャー・クエリーは、モバイルページの40％、デスクトップページの38％で確認されました。これは、2021年の48％という数字から減少しています。これは、テストされた一般的な機能のサポートが、使用前に機能のテストを気にする必要がないほど大きくなっていることを示しているのかもしれません。

1ページあたりの機能クエリブロック数は、75%で4、90%でデスクトップが7、モバイルが8となっています。ただし、1,722個の特徴クエリブロックを持つサイトがありました。

{{ figure_markup(
    image="supports-features.png",
    caption="フィーチャークエリでテストされたもっとも普及している機能。",
    description="機能クエリ（`@supports`）がもっとも多くテストされている機能を示す棒グラフ。`sticky`機能が36%、`mask-image` 20%、`touch-callout` 11%、`ime-align`5%、`grid` 5%、`overflow-scrolling` 5%、`appearance` 3%、カスタムプロパティ2%、`object-fit` 1%、最大関数1%と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=316208344&format=interactive",
    sheets_gid="542186816",
    sql_file="supports_criteria.sql"
  )
}}

昨年と同様、機能検索でもっとも普及している機能は`position: sticky`ですが、この機能のブラウザサポートが向上したためか、出現率は53%から36%に減少しています。

このテストでは、非標準の機能が強く現れており、 `touch-callout` (`-webkit-touch-callout`) と `ime-align` (`-ms-ime-align`) があります。前者は使用率が5%から11%に増加し、`ime-align`は7%から5%に減少しています。

{{ figure_markup(
    image="supports-props.png",
    caption="フィーチャークエリーブロック内で使用されているプロパティ（ページ数の割合）。",
    description="もっとも多くのページで見られる機能クエリブロック内に使用されているプロパティを示す棒グラフ。オブジェクトフィットプロパティは27%のページでフィーチャークエリーブロックに含まれ、以下、`content` 26%、`background-attachment` 25%、`border-radius`、`mask-size`、`mask-image`、`mask-repeat`、`mask-position`、mask-mode 24%、`-webkit-mask-size`、 `-webkit-mask-repeat`および `-o-object-fit` 23%、`display` 17%、width 15%、`height` 13%、`flex` 11%、`justify-content`および`align-items` 10%と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1247122547&format=interactive",
    height="783",
    sheets_gid="1467181186",
    sql_file="supports_properties.sql"
  )
}}

サポートテストを行った後、これらの機能クエリブロックの内部で、どのプロパティを使用するのでしょうか？`object-fit` プロパティがもっとも多く、 `mask-*` プロパティは `-webkit-mask-*` プロパティと同様に良い結果を出しています。これは、最近までマスクの相互運用性がなく、Chromeではプロパティがまだ `-webkit`プレフィックスを必要と、したためと思われます。

`display`プロパティは上位20位以内にありますが、グリッドプロパティを見つけるには、リストのかなり下の方に行かなければなりません。`grid-template-columns` プロパティは、機能クエリブロックの2%で見つかりました。

## 国際化

英語は、文章がページの上から順に水平に書かれていることから、水平トップ・トゥ・ボトム言語と言われている。文字の方向は左から右へ（LTR）です。アラビア語、ヘブライ語、ウルドゥー語も上から下への水平方向の言語だが、スクリプトの方向は右から左（RTL）です。また、中国語、日本語、モンゴル語など、上から下へ垂直に書かれる言語もある。CSSは、このような異なる書き方や文字の向きに対応できるように進化してきた。

### 方向性

`direction`プロパティを使ってCSSを`<body>`か`<html>`要素に設定しているページ数は2021年から変わらず、`<html>`に設定しているページが11％、`<body>`に設定しているページが3％となっています。<a hreflang="en" href="https://www.w3.org/International/questions/qa-html-dir">`direction`を設定するにはCSSではなくHTML</a>を使うことが推奨されているので、ここではそのベストプラクティスへ合わせた低い数値にしています。

## 論理的・物理的プロパティ

`border-block-start` や `text-align` の `start` のような論理的またはフローに関係するプロパティは、画面の物理的な寸法に縛られるのではなく、テキストのフローに従うので、国際化には有用です。これらのプロパティに対するブラウザのサポートは現在とても優れているので、私たちはもっと採用が進むのではないかと考えていました。

{{ figure_markup(
    image="logical-props.png",
    caption="使用される論理プロパティの分布。",
    description="論理プロパティの使用率の相対的な分布を示す円グラフ。`margin`プロパティが70.0%、`text-align` 12.6%、`padding` 11.2%、`border` 4.5%、`inset` 1.7%使用されていることがわかる。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=597319721&format=interactive",
    sheets_gid="1478929671",
    sql_file="i18n_logical_properties.sql"
  )
}}

論理プロパティの使用率は、2021年からわずかに増加し、4%から5%になった。しかし、2022年のグラフは、2021年のグラフと大きく異なっています。圧倒的に多くの人が論理プロパティを使用して `margin` プロパティを設定しており、26%から70%に増加しています。もっとも普及している `margin` プロパティは `margin-inline-start` と `margin-inline-end` で、全体の9%のページで見受けられます。これらは、たとえばラベルとそれに続くフィールドの間隔が、LTRとRTLのスクリプトで同じように動作することを確認するためにとくに有用です。

### Ruby

今回も、[CSS Ruby](https://developer.mozilla.org/docs/Web/CSS/CSS_Ruby)の使用を確認しました。これは、インターリニアアノテーション（ベーステキストに沿った短いテキスト）に使用するプロパティの集合体です。

{{ figure_markup(
    content="0.2%",
    caption="モバイルページでCSS Rubyを使用している割合です。",
    classes="big-number",
    sheets_gid="1827604622",
    sql_file="ruby_adoption.sql"
  )
}}

その使用率はまだ微々たるものですが、2021年から増加しました。2021年にはデスクトップ8,157ページ、モバイル9,119ページと、分析した全ページの0.1%未満しか使用されていないことが判明しました。今年は、デスクトップ16,698ページ、モバイル21,266ページ、つまり分析した全ページの0.2％が利用していた。

## CSS in JS

{{ figure_markup(
    image="css-in-js.png",
    caption="CSS in JSの利用。",
    description="CSS in JSライブラリの人気度合いの相対的な分布を示す円グラフ。もっとも普及しているライブラリはStyled Componentsで、採用率は49.4%、次いでEmotion 22.9%、Goober 10.9%、Glamor 7.7%、Aphrodite 5.0%、そしてStyled Jax 2.4%となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=140888375&format=interactive",
    sheets_gid="1374787728",
    sql_file="css_in_js.sql"
  )
}}

CSS-in-JSの利用は昨年から増えておらず、3％にとどまっています。この利用は、ほとんどがライブラリによるもので、もっとも普及しているのはStyled Componentsです。このライブラリのシェアは57%から49%に低下し、新しいライブラリがほぼ11%でミックスに加わっています。<a hreflang="en" href="https://goober.js.org/">Goober</a> は、自らを「1KB未満のcss-in-jsソリューション」と表現しており、この種のものが好きな人々の間に確実に浸透している。

## Houdini

[Houdini](https://developer.mozilla.org/docs/Web/CSS/CSS_Houdini)は、オープンなWeb上ではまだほとんど使われていないんです。アニメーションのカスタムプロパティを使用しているページ数を見ると、2021年以降、わずかな増加にとどまっています。また、Houdini Paint APIの利用状況も調べてみました。私たちは、Web上でこれが使用されている事例を発見しました。使用されている小作品名を見ると、その多くが <a hreflang="en" href="https://css-houdini.rocks/smooth-corners/">smooth corners</a> 小作品で、通常の `border-radius` にうまくフォールバックできることから、人々はこれを段階的強化として使用していることがわかります。

## Sass

Sassのようなプリプロセッサーは、開発者がCSSでできるようになりたいと思っていてもできないことの良い指標と見ることができます。そしてCSSのパワーアップに伴い、開発者からのよくある質問は、Sassを使う必要がまったくないのか、というものです。カスタムプロパティの利用が増加していることから、プリプロセッサでよく使われる変数や定数の機能が、CSSに組み込まれ同等の機能を持つようになったことがわかります。

{{ figure_markup(
    image="sass-function-calls.png",
    caption="もっとも普及しているSass関数呼び出しの割合。",
    description="もっとも多く使われているSass関数呼び出しを示した棒グラフ。Sass関数呼び出しのうち、`if`関数が19％を占め、以下、その他の関数17％、`darken` 14％、`map-get` 10％、`map-keys` 9％、パーセンテージ6％、`nth` 5％、`lighten`と`mix` 4％、`type-of`、α調整、単位、長さが3％と続きます。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1702171363&format=interactive",
    height="552",
    sheets_gid="1751596973",
    sql_file="sass_function_calls.sql"
  )
}}

関数の呼び出しを見ると、色関数はまだSassの非常に一般的な使い方であり、近いうちに `color-mix()` などの <a href="https://www.w3.org/TR/css-color-5/" hreflang="en"> 新しいCSS色関数</a>に置き換えられるかもしれないことがわかります。昨年からの変化もある。`darken`機能が2ポイント下がって14％で3位となった。しかし、`lighten`機能は1ポイント増えている。

{{ figure_markup(
    image="sass-control-flow-statements.png",
    caption="SCSS上の制御フロー文の配布。",
    description="SCSSを使用したページでもっとも多く使われている制御フロー文の棒グラフです。ifが65％、@forが60％、@eachが60％、@whileが7％と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=652567190&format=interactive",
    sheets_gid="2100910538",
    sql_file="sass_control_flow_statements.sql"
  )
}}

コントロールフローを見ると、`@for`と`@each`は少し増えていますが、`@while`は2%から7%に増えています。

{{ figure_markup(
    image="sass-nesting.png",
    caption="SCSSにおける明示的なネストの使用率（SCSSを使用しているページの割合）。",
    description="SCSSを使用したもっとも多くのページで使用されているネスティングセレクターを棒グラフで示したものです。88%のSCSSページでネスティングセレクターが使用されています。もっとも普及しているセレクターは85%のSCSSページで`&:pseudo-class`、次いで`&.class` 81%、`&::`擬似要素70%、そのまま `&` 単体65%、`&[attr]`59%、`& +`（隣接兄弟）31%、`&子孫`25%、`& >`（子）24%、`& ~`と `&#id` 5%の順になっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1858217462&format=interactive",
    height="455",
    sheets_gid="1739922540",
    sql_file="sass_nesting.sql"
  )
}}

ネスティングはまた、CSSネスティングの将来の仕様が現在CSSワーキンググループで開発・議論されていることを考えると、興味深いものです。SCSSシートのネスティングは非常に一般的で、`&`という文字を探すことで識別できます。昨年と同様に、`:hover`のような擬似クラスや、`.active`のようなクラスがもっともよくネストされるケースを構成しています。すべての用途で微増しているが、`&子孫`は18％から25％へと7ポイント増加している。暗黙の入れ子は特殊文字を使用しないため、本調査では測定していない。

## 印刷用CSS

{{ figure_markup(
    content="5%",
    caption="印刷に特化したスタイルを持つデスクトップページの割合。",
    classes="big-number",
    sheets_gid="2112165521",
    sql_file="print_stylesheet_adoption.sql"
  )
}}

よりよい印刷体験を提供するために、開発者が印刷用スタイルシートを作成しているかどうかを調べたところ、デスクトップサイトの5％、モバイルサイトの4％しか作成していませんでした。

{{ figure_markup(
    image="print-props.png",
    caption="印刷スタイルシートを持つページの印刷スタイルでもっとも多いプロパティ。",
    description="印刷スタイルシートを持つもっとも多くのページで使用されている印刷プロパティを示す棒グラフ。`display`プロパティは印刷スタイルシートを持つページの55%で使われ、`margin` 48%、`color` 47%、`width` 43%`、background` 42%、`padding`と`text-decoration` 39%、 `font-size` 37%、 `text-align` 36%、`content` 34%がそれに続く。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1905758001&format=interactive",
    height="455",
    sheets_gid="962139614",
    sql_file="print_all_properties.sql"
  )
}}

印刷用スタイルを使用しているページのうち、半数以上が`display`の値を変更しています。おそらく、印刷用にグリッドやフレックスのレイアウトを簡素化するためでしょう。また、色を変えたり、マージンやパディングを調整したり、`font-size`を設定している人も見受けられます。34%は `content` プロパティで、これは生成されたコンテンツを挿入するために使用されます。

印刷物は断片的なメディアです。コンテンツはページごとに分割され、その分割を制御するために一連の断片化プロパティが用意されています。たとえば、開発者は通常、見出しがページの最後に表示されることや、キャプションが関連する図から切り離されることを避けたいと考えています。

{{ figure_markup(
    image="print-fragmentation-props.png",
    caption="印刷スタイルシートで使用されるフラグメンテーションプロパティ。",
    description="印刷用スタイルシートを持つページでの断片化プロパティの使用状況を示す棒グラフ。`page-break-inside`プロパティは印刷スタイルシートを持つページの32%で使われ、`page-break-after` 30%、`orphans` 22%、`page-break-before` 19%、`break-after` 2%がそれに続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=141331795&format=interactive",
    height="455",
    sheets_gid="962139614",
    sql_file="print_all_properties.sql"
  )
}}

このグラフから、多くの開発者が、使用率の低い `break-before` のような新しいプロパティではなく、 `page-break-inside`, `page-break-after`, `page-break-before` という古い断片化プロパティを用いていることがわかります。

`orphans` プロパティはFirefoxでサポートされていないにもかかわらず、印刷用スタイルシートの22%で表示されています。このプロパティは、フラグメンテーションブレークの前にページの下に残すべき行数を定義します。`widows` プロパティ（fragmentation breakの後にそれ自体で残される行数を設定する）もほぼ同じ頻度で見受けられます。おそらく、人々は両方に同じ値を設定しているのでしょう。

### ページングされたメディア

Paged Mediaを扱うための全体の仕様があり、印刷用のCSSもある。しかし、これはブラウザにうまく実装されていません。これらの機能の優れた実装を見つけるには、印刷に特化したユーザーエージェントを使用する必要があります。

ブラウザは、[`@page`](https://developer.mozilla.org/docs/Web/CSS/@page)ルールとその擬似クラスをいくらかサポートしており、開発者はこれらを使って、最初のページと見開きの左右のページに対して異なるページプロパティを設定しているのを見かけました。

<figure>
  <table>
    <thead>
      <tr>
        <th>擬似クラス</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>:first</code></td>
        <td class="numeric">5,950</td>
        <td class="numeric">7,352</td>
      </tr>
      <tr>
        <td><code>:right</code></td>
        <td class="numeric">1,548</td>
        <td class="numeric">2,115</td>
      </tr>
      <tr>
        <td><code>:left</code></td>
        <td class="numeric">1,554</td>
        <td class="numeric">2,101</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(
    caption="`@page` の拡散擬似クラスを使って見つかったページの数。",
    sheets_gid="590030258",
    sql_file="print_page_pseudo_classes.sql"
  ) }}</figcaption>
</figure>

これらの擬似クラスを使っている人のうち、もっとも多くの人が使っていたのは、ページの余白や大きさを設定することでした。

## メタ

このセクションでは、CSSの使用に関する一般的な情報、たとえば宣言が繰り返される頻度や、CSSの一般的な間違いについてまとめています。

### 宣言の繰り返し

2020年と2021年には、「宣言の繰り返し」の多さを調べる分析が行われました。これは、同じプロパティと値を使用する宣言の数を調べることで、スタイルシートがどれだけ効率的かを特定することを目的としています。

{{ figure_markup(
    image="repetition.png",
    caption="繰り返しの分布。",
    description="1ページあたりのユニークな宣言の割合の10、25、50、75、90パーセンタイルを示す棒グラフです。数値は順に32%、38%、45%、53%、61%です。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1151123515&format=interactive",
    sheets_gid="477246191",
    sql_file="repetition.sql"
  )
}}

2021年には、繰り返しがわずかに減少したと報告されましたが、今年はわずかに増加しています。したがって、この指標は前年比ではかなり安定していると思われます。

### ショートハンドとロングハンド

CSSでは、ショートハンドプロパティとは、1つの宣言で複数のロングハンドプロパティを設定できるものを指します。たとえば、`background`というショートハンドプロパティは、以下のすべてのロングハンドプロパティを設定するために使うことができる。

- `background-attachment`
- `background-clip`
- `background-color`
- `background-image`
- `background-origin`
- `background-position`
- `background-repeat`
- `background-size`

開発者がスタイルシートの中で `background` のようなショートハンドのプロパティと `background-size` のようなロングハンドのプロパティを混在させる場合、ロングハンドをショートハンドの後に置くのが常に最善とされています。私たちは、どのロングハンドがもっとも一般的であるかを確認するために、この事例を調べました。

{{ figure_markup(
    image="shorthand-first-props.png",
    caption="ショートハンドの次に来るもっとも普及しているロングハンドプロパティです。",
    description="ロングハンドプロパティが、関連するショートハンドプロパティの後に来る場合の相対的な人気を示す棒グラフです。`background-size`プロパティがこのパターンの15%を占め、`background-image` 6%、`font-size`、`margin-bottom`、`margin-top`、`border-bottom-color`が5%、`line-height`、`border-top-color`、`margin-left`は4%、 `padding-left`で3%と続いています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1722219756&format=interactive",
    height="445",
    sheets_gid="293529425",
    sql_file="meta_shorthand_first_properties.sql"
  )
}}

2020年、2021年と同様、`background-size`がもっとも多く、2021年との差はほとんど見られない。

### 回復不能な構文エラー

例年通り、CSSの解析には<a hreflang="en" href="https://github.com/reworkcss/css">Rework</a>エンジンを使用しています。回復不可能なエラーとは、エラーの程度がひどく、スタイルシート全体をReworkで解析することができないものです。昨年は、デスクトップページの0.94%、モバイルページの0.55%に回復不可能なエラーが含まれていました。今年は、デスクトップページの13%、モバイルページの12%にそのようなエラーが見られました。これは大きなジャンプのように見えますが、いくつかの方法の変更（サイズの閾値の追加）により、すべての事例が回復不可能なエラーであるとは限らないようです。

## 存在しないプロパティ

例年通り、有効な構文でありながら、実際には存在しないプロパティを参照している宣言をチェックしました。これには、スペルミスやベンダープレフィックスの間違い、開発者が勝手に作ったものなどが含まれます。

{{ figure_markup(
    image="unknown-props.png",
    caption="もっともよく見かける未知のプロパティ。",
    description="無効でもっとも多くのページで見られるプロパティを示した棒グラフ。もっとも普及しているのは `-archetype`で11%、次いで`font-smoothing`と`behavior`で10%、`tap-highlight-color` 6%、`moz-transition` 5%、`min-center` 4%、`box-flex` 3%、`webkit-transition`では3%、残りはすべて1%未満のページで見つかり、`url-encoded`、`border-collapse`、`webkit-border-radius`、`moz-border-radius`および`enable-background`となっています。",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=932637515&format=interactive",
    height="514",
    sheets_gid="127761236",
    sql_file="meta_unknown_properties.sql"
  )
}}

謎のプロパティのトップは `-archetype` で、存在しないプロパティを持つスタイルシートのケースの11%で出現するようになりました。このプロパティは、昨年の4%から11%に急上昇し、トップの座を獲得しています。2番目のプロパティは `font-smoothing` で、昨年より4%ポイント低下している。これは実際には存在しない `-webkit-font-smoothing` の接頭辞なしバージョンであるように見えます。不正な `webkit-transition`（本来は `-webkit-transition` であるべき）の使用は、14%から3% に減少しました。このことから、おそらくフレームワークなどの[サードパーティ](./third-parties)を介して大量のスタイルシートに入り込んでいたものと思われますが、その後アップデートで問題が修正されました。

## 結論

CSSは急速な進化を続けていますが、主要なエンジンに数年前から搭載されている機能であっても、新しい機能の採用はかなり遅いことがデータから読み取れます。この記事を書いている時点では、コンテナクエリなど、要望の高い機能がいくつかブラウザに搭載されています。これらの機能の採用が需要に見合うかどうか、興味深いところです。

このデータで明らかになったことは、人気のあるプラットフォーム、とくにWordPressが利用統計にどれだけ影響を与えるかということです。WordPressのクラス名やカスタムプロパティ名はデータではっきりと確認できますが、WordPressサイトの大部分に追加されたクラスで使用されているプロパティや値は見えにくくなっています。WordPressが新しい機能を採用した場合、これらの標準クラスの一部として、使用率が急激に上昇することが予想されます。

昨年の結論で述べたように、このデータは、新しい機能（グリッドレイアウトなど）やベストプラクティス（物理プロパティではなく論理プロパティの使用など）が徐々に、そして着実に採用されていることを物語っています。今後数年間、このような変化がどのように展開されるかを楽しみにしています。
