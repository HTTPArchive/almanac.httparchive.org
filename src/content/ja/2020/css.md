---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: 2020年のWeb AlmanacのCSSの章では、カラー、ユニット、セレクタ、レイアウト、アニメーション、メディアクエリ、Sassの使用法をカバーしています。
authors: [LeaVerou, svgeesus, rachelandrew]
reviewers: [estelle, fantasai, j9t, mirisuzanne, catalinred, hankchizljaw]
analysts: [rviscomi, LeaVerou, dooman87]
editors: [tunetheweb]
translators: [ksakae]
LeaVerou_bio: Lea <a hreflang="en" href="https://designftw.mit.edu">HCIとウェブプログラミングの講師</a>、<a hreflang="en" href="https://mavo.io">ウェブプログラミングをより簡単にする方法</a>を<a hreflang="en" href="https://mit.edu">MIT</a>で研究しています。彼女はベストセラーの技術系<a hreflang="en" href="https://www.amazon.com/CSS-Secrets-Lea-Verou/dp/1449372635?tag=leaverou-20">著者</a>であり、経験豊富な<a hreflang="en" href="https://lea.verou.me/speaking">講演者</a>でもあります。彼女はオープンなウェブ標準に情熱を注いでおり、<a hreflang="en" href="https://www.w3.org/Style/CSS/members.en.php3">CSSワーキンググループ</a>の長年のメンバーでもあります。Leaは、<a hreflang="en" href="https://github.com/leaverou">人気のあるオープンソースプロジェクトやウェブアプリケーション</a>、<a hreflang="en" href="https://prismjs.com">Prism</a>、<a hreflang="en" href="https://github.com/leaverou/awesomplete">Awesomplete</a>などを立ち上げています。彼女は<a href="https://twitter.com/leaverou">@leaverou</a>でツイートし、<a hreflang="en" href="https://lea.verou.me">lea.verou.me</a>でブログを書いています。
svgeesus_bio: Chris LilleyはWorld Wide Web Consortium(W3C)のテクニカルディレクターです。「SVGの父」と呼ばれ、PNGの共著、CSS2の共同編集者、<code>@font-face</code> を開発したグループの議長、WOFFの共同開発者でもあります。元テクニカルアーキテクチャグループ。ChrisはまだWeb上でColor Managementを使おうとしています、ため息。現在はCSSレベル3/4/5 (いや、本当に)、Web Audio、そしてWOFF2に取り組んでいます。
rachelandrew_bio: 私はウェブ開発者、ライター、スピーカーです。<a hreflang="en" href="https://grabaperch.com">Perch CMS</a>と<a hreflang="en" href="https://noti.st">Notist</a> の共同設立者。<a hreflang="en" href="https://www.w3.org/wiki/CSSWG">CSSワーキンググループ</a>のメンバー。<a hreflang="en" href="https://www.smashingmagazine.com/">Smashing Magazine</a>の編集長です。
discuss: 2037
results: https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/
featured_quote: ウェブはもう10代の若者ではなく、30歳になった今、そのように振る舞っています。それは、複雑さよりも安定性や読みやすさを優先する傾向がありますが、たまにある罪悪感はさておき。
featured_stat_1: 72.58%
featured_stat_label_1: `<length>`値のパーセンテージのうち、`px`単位を使用する割合。
featured_stat_2: 91.05%
featured_stat_label_2: ベンダーの接頭辞が付いた機能を使用しているモバイルページの割合
featured_stat_3: `darken()`
featured_stat_label_3: 最も人気のあるSCSS機能
---

## 序章

CSS（Cascading Stylesheets）とは、ウェブページやその他のメディアをレイアウト、フォーマット、ペイントするために使用される言語です。Webサイトを構築するための3つの主要言語の1つで、他の2つは構造を指定するために使用されるHTMLと、動作を指定するために使用されるJavaScriptです。

[昨年のWeb Almanac](../2019/)では、2019年のテクノロジーの状態を評価するために、HTTP Archiveのコーパス上で41個のSQLクエリを通して測定された[さまざまなCSSのメトリクス](../2019/css)を調べました。今年は与えられたCSS機能を使用しているページの数だけでなく、それを*どのように*使用しているかを測定するために、さらに深く掘り下げてみました。

全体的に見て私たちが観察したのは、CSSの採用に関しては、ウェブは2つの異なる歯車の中にあるということでした。私たちのブログやTwitterでは、最新のものを話題にしがちですが、10年以上前のコードを使用しているサイトはまだ何百万もあります。[過ぎ去った時代のベンダープレフィックス](#vendor-prefixes)、[独自のIEフィルタ](#filters)、[レイアウト用のフロート](#layout)のようなものは、それらのすべての[clearfix](#class-names)の栄光の中で使われています。しかし、私たちは、多くの新機能が印象的に採用されていることも観察しました。しかし一般的には、何かがどれだけクールに認識されるかと、それがどれだけ実際に使われるかの間には逆相関があります。

同様に私たちのカンファレンスでの講演では、頭が爆発したり、Twitterのフィードが「CSSは*あれ*ができるのか！」で埋め尽くされたりするような、複雑で凝ったユースケースに焦点を当てることがよくあります。しかし、実際のところ、ほとんどのCSSの使用法は非常に単純なものです。[CSS変数はほとんど定数として使われる](#complexity)し、他の変数を参照することはほとんどなく、`calc()`は[ほとんどが2つの用語で使われる](#calculations)し、グラデーションは[ほとんどが2つのストップを持つ](#gradients)などです。

ウェブはもう10代の若者ではなく、30歳になった今、そのように振る舞っています。それは、複雑さよりも安定性や読みやすさを優先する傾向がありますが、たまにある罪悪感はさておき。

## 方法論

<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>は毎月<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">数百万ページ</a>をクロールし、<a hreflang="en" href="https://webpagetest.org/">WebPageTest</a>のプライベートインスタンスを通して実行し、各ページのキー情報を保存しています。（これについての詳細は[methodology](./methodology)を参照してください）。

今年は、どのメトリクスを勉強するか、コミュニティを巻き込むことにしました。私たちはまず、<a hreflang="en" href="https://projects.verou.me/mavoice/?repo=leaverou/css-almanac&labels=proposed%20stat">メトリクスを提案して投票するアプリ</a>から始めました。最終的には非常に多くの興味深いメトリクスがあったので、ほぼすべてのメトリクスを含めることにしましたが、フォントメトリクスだけを除外しました。

この章のデータは、121個のSQLクエリを使用し、SQL内の3000行のJavaScript関数を含む10000行以上のSQLを作成しました。これは、Web Almanacの歴史の中で最大の章となっています。

この規模の分析を可能にするため、多くの技術的な作業が行われました。昨年と同様に、私たちはすべてのCSSコードを<a hreflang="en" href="https://github.com/reworkcss/css">CSSパーサー</a>に通し、コーパス内のすべてのスタイルシートの[抽象構文木](https://ja.wikipedia.org/wiki/%E6%8A%BD%E8%B1%A1%E6%A7%8B%E6%96%87%E6%9C%A8)(AST)を保存しました。今年は、このAST上で動作する<a hreflang="en" href="https://github.com/leaverou/rework-utils">ヘルパーのライブラリ</a>と<a hreflang="en" href="https://projects.verou.me/parsel">セレクタパーサー</a>も開発しましたが、これらも別々のオープンソースプロジェクトとしてリリースされました。ほとんどのメトリクスでは、単一のASTからデータを収集するために<a hreflang="en" href="https://github.com/LeaVerou/css-almanac/tree/master/js">JavaScript</a>を使用し、コーパス全体のデータを集約するために<a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/sql/2020/01_CSS">SQL</a>を使用しました。あなた自身のCSSが私たちのメトリクスに対してどのように機能しているか興味がありますか？　私たちは<a hreflang="en" href="https://projects.verou.me/css-almanac/playground">online playground</a>を作成し、自分のサイトで試してみることができます。

特定の指標については、CSS ASTを見るだけでは十分ではありませんでした。私たちは、ソースマップを介して提供された<a hreflang="en" href="https://sass-lang.com/">SCSS</a>を見たいと考えていました。それは、開発者がCSSから何を必要としているかを示しているのに対し、CSSを研究することで開発者が現在使用しているものを示すことができるからです。そのためには、クローラーが特定のページを訪問したときにクローラーで実行される*カスタムメトリック*—JavaScriptコードを使用しなければなりませんでした。適切なSCSSパーサーを使用するとクロールが遅くなりすぎるので、<a hreflang="en" href="https://github.com/LeaVerou/css-almanac/blob/master/runtime/sass.js">正規表現</a>(*ああ、恐ろしい！*)に頼らざるを得ませんでした。粗野なアプローチにもかかわらず、私たちは[多くの洞察](#sass)を得ることができました！

カスタムメトリクスは[カスタムプロパティの分析](#custom-properties)の一部にも使われていました。スタイルシートだけでもカスタムプロパティの使用状況に関する多くの情報を得ることができますが、カスタムプロパティは継承されているため、DOMツリーを見てコンテキストを確認できなければ依存関係グラフを構築することはできません。またDOMノードの計算されたスタイルを見ることで、各プロパティがどのような種類の要素に適用されているのか、どの要素が[registered](https://developer.mozilla.org/ja/docs/Web/API/CSS/RegisterProperty)であるのかといった情報を得ることができます。

<p class="note">我々はデスクトップとモバイルの両方のモードでページをクロールしていますが、多くのデータでは同様の結果が得られるため、特に断りのない限り、この章で提示されている統計はモバイルページのセットを参照しています。</p>

## 使用方法

ページ重量のシェアではJavaScriptがCSSをはるかに上回っていますが、CSSのサイズは年々確実に大きくなっておりデスクトップページの中央値では62KBのCSSコードが読み込まれ、10ページに1ページが240KB以上のCSSコードを読み込んでいます。モバイルページでは、すべてのパーセンタイルでCSSコードの使用量がわずかに減少していますが、その差は4～7KBにとどまっています。これは間違いなく過去数年よりも多いですが、[JavaScriptの中央値444KBと1.2MBのトップ10%]には及ばないですね(./javascript#how-much-javascript-do-we-use)

{{ figure_markup(
  image="stylesheet-size.png",
  caption="1ページあたりのスタイルシート転送サイズの分布。",
  description="ページあたりのスタイルシート転送サイズの分布を示す棒グラフ。デスクトップでは、1ページあたりのスタイルシートのバイト数が約10KBとやや多い傾向にあります。モバイルの10、25、50、75、90パーセンタイルは以下の通りです。5、22、56、122、234KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=762340058&format=interactive",
  sheets_gid="314594173",
  sql_file="stylesheet_kbytes.sql"
) }}

これらのCSSの多くはプリプロセッサや他のビルドツールで生成されていると考えるのが妥当でしょうが、ソースマップが含まれているのは約15%に過ぎませんでした。これがソースマップの採用を意味しているのか、それともビルドツールの使用状況を意味しているのかは不明です。これらのうち、圧倒的多数（45%）は他のCSSファイルからのもので、ミニ化、<a hreflang="en" href="https://autoprefixer.github.io/">autoprefixer</a>、<a hreflang="en" href="https://postcss.org/">PostCSS</a>など、CSSファイルを操作するビルドプロセスを利用していることを示しています。<a hreflang="en" href="https://sass-lang.com/">Sass</a>は、<a hreflang="en" href="https://lesscss.org/">Less</a>よりもはるかに人気が高く（ソースマップを持つスタイルシートの34%対21%）、SCSSの方が人気がありました（.scssの33%対.sassの1%）。

これらすべてのキロバイトのコードは、通常、複数のファイルと`<style>`要素に分散されています。実際、中央値のページには3つの`<style>`要素と6つのリモートスタイルシートがあり、そのうちの10%は14個の`<style>`要素と20個以上のリモートCSSファイルを持っています。これはデスクトップで最適ではありませんが、生のダウンロード速度よりも往復のレイテンシが重要なモバイルでは、[パフォーマンス](./performance)を本当に殺してしまいます。

{{ figure_markup(
  caption="ページによって読み込まれるスタイルシートの数が最も多い。",
  content="1,379",
  classes="big-number",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
)
}}

驚くべきことに、1ページあたりのスタイルシートの最大数は、`<style>`要素が26,777個、リモートのものが1,379個という驚異的な数なのです！　そのページを読み込むのは絶対に避けたいですね！

{{ figure_markup(
  image="stylesheet-count.png",
  caption="1ページあたりのスタイルシート数の分布。",
  description="ページあたりのスタイルシートの分布を示す棒グラフ。デスクトップとモバイルは分布全体でほぼ同じです。モバイルの10、25、50、75、90パーセンタイルは以下の通りです。1ページあたりのスタイルシート数は1、3、6、12、21です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=163217622&format=interactive",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
) }}

サイズのもう1つの指標は、ルールの数です。中央値のページには、合計448のルールと5,454の宣言が含まれています。興味深いことに、ページの10%はわずかな量のCSSを含んでおり、13のルールよりも少ないのです。モバイルの方がスタイルシートがわずかに小さいにもかかわらず、ルール数がわずかに多く、全体的にルールが小さいことを示しています（メディアクエリで起こりがちなことですが）。

{{ figure_markup(
  image="rules.png",
  caption="1ページあたりのスタイルルールの総数の分布。",
  description="ページごとのスタイルルールの分布を示す棒グラフ。モバイルはデスクトップよりも若干ルールが多い傾向にあります。モバイルの10、25、50、75、および90パーセンタイルは以下の通りです。1ページあたりのルールは13、140、479、1,074、1,831です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1918103300&format=interactive",
  sheets_gid="42376523",
  sql_file="selectors.sql"
) }}

## セレクターとカスケード

CSSには、クラスやID、スタイルの重複を避けるために重要なカスケードの使用など、ページにスタイルを適用する方法がたくさんあります。では、開発者はどのようにしてページにスタイルを適用しているのでしょうか？

### クラス名

最近の開発者は何にクラス名を使っているのでしょうか？　この質問に答えるために、最も人気のあるクラス名を調べてみました。そのリストは、<a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>クラスが占めており、198個中192個が`fa`または`fa-*`でした。最初に調査してわかったことは、Font Awesomeは非常に人気があり、ほぼ3分の1のWebサイトで使用されているということだけでした。

しかし、一度`fa-*`クラスと`wp-*`クラス（これも非常に人気のあるソフトウェアである<a hreflang="en" href="https://wordpress.com/">WordPress</a>に由来する）を分解してみると、より意味のある結果が得られました。これらを省略すると、状態関連のクラスが最も人気があるようで、`.active`が半数近くのウェブサイトで出現し、`.selected`と`.disabled`がその直後に続いています。

上位クラスのうち、プレゼンテーション的なものはわずか数個だけで、それらのほとんどはアライメントに関連したもの（古い<a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a> の`pull-right`や`pull-left`、`alignright`,`alignleft`など）か`clearfix`で、フロートがより近代的なGridやFlexboxモジュールによってレイアウト方法として置き換えられているにもかかわらず、いまだにウェブサイトの22%で発生しています。

{{ figure_markup(
  image="popular-class-names.png",
  caption="ページ数の割合で最も人気のあるクラス名です。",
  description="デスクトップページとモバイルページで最も人気のあるクラス名トップ14を示す棒グラフ。アクティブなクラスは40%のページで見られます。残りのクラスは20-30%のページで見られています。`fa`,`fa-*;`,`pull-right`,`pull-left`,`selected`,`disabled`,`clearfix`,`button`,`title`,`wp-*;`,`btn`,`container`,`sr-only`の順です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1187401149&format=interactive",
  sheets_gid="863628849",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}

### ID

最近ではIDの特異度が非常に高いため、一部の業界では推奨されていませんが、ほとんどのウェブサイトでは、ほとんど使用されていません。セレクターで複数のIDを使用しているページは半数以下（最大特異度は(1,x,y)以下）で、ほぼ全てのページでIDを含まない特異度の中央値は(0,x,y)となっています。特異度の計算の詳細とこの(a,b,c)表記法については、<a hreflang="en" href="https://www.w3.org/TR/selectors/#specificity-rules">selectors specification</a>を参照してください。

しかし、これらのIDは何に使われているのでしょうか？　最も人気のあるIDは構造的なものであることがわかりました:`#content`,`#footer`,`#header`,`#main`ですが、[対応するHTML要素](https://developer.mozilla.org/ja/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure#html_layout_elements_in_more_detail)が存在するにもかかわらず、セレクターとして使用できます。

{{ figure_markup(
  image="popular-ids.png",
  caption="ページの割合で最も人気のあるIDです。",
  description="デスクトップとモバイルページで最も人気のあるIDのトップ10を示す棒グラフ。最も人気のあるIDは`content`で、ページの14%を占めています。`footer`と`header`のIDの採用率はわずかに低い。`logo`、`main`、`respond`、`comments`、`fancybox-loading`、`wrapper`、および`submit`のIDは、ページ上で5～10%の割合で採用されています。デスクトップとモバイルの間で顕著な違いがあるのは、`comments`のIDがモバイルページの約8%で使われているのに対し、デスクトップページでは5%しか使われていないことです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=141873739&format=interactive",
  sheets_gid="734822190",
  sql_file="top_selector_ids.sql"
) }}

IDは、意図的に特異度を下げたり、上げたりするために使うこともできます。<a hreflang="en" href="https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/">IDセレクタを属性セレクタとして書くという特異性ハック</a>（特異性を減らすために`#foo`の代わりに`[id="foo"]`を使う）は驚くほど珍しく、少なくとも一度は0.3%のページでしか使われていませんでした。もうひとつのID関連の特異性ハックは、`.foo`の代わりに`:not(#nonexistent) .foo`のような否定＋子孫セレクターを使って特異性を高めるというものですが、これも非常に稀で、0.1%のページでしか使われていませんでした。

### `!important`{important}

代わりに、古くて粗雑な`!important`は、その<a hreflang="en" href="https://www.impressivewebs.com/everything-you-need-to-know-about-the-important-css-declaration/#post-475:~:text=Drawbacks,-to">よく知られた欠点</a>にもかかわらず、まだかなり使われています。中央値のページでは、宣言のほぼ2％、つまり50分の1で`!important`が使用されています。

{{ figure_markup(
  caption="すべての宣言で`!important`を使用するモバイルページ！　",
  content="2,138",
  classes="big-number",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
)
}}

一部の開発者は文字通りそれを十分に得ることができません。すべての宣言で`!important`を使用する2304のデスクトップページと2138のモバイルページが見つかりました！

{{ figure_markup(
  image="important-properties.png",
  caption="ページごとの`!important`プロパティの割合の分布。",
  description="ページあたりの「!important」プロパティの割合の分布を示す棒グラフ。デスクトップページは、モバイルよりもわずかに多くのプロパティでモバイル用の10、25、50、75、および90パーセンタイルは以下の通りです。0、1、2、4、および7%のプロパティで「!important」を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=768784205&format=interactive",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
) }}

開発者がオーバーライドすることに熱心なのは何ですか？　プロパティごとの内訳を調べたところ、80％近くのページが`display`プロパティで`!important`を使用していることがわかりました。`display：none !important`を適用してヘルパークラスのコンテンツを非表示にし、`display`を使用してレイアウトモードを定義する既存のCSSをオーバーライドするのが一般的な戦略です。 これは、後から考えると、CSSの欠陥であったものの副作用です。 3つの直交する特性を1つに組み合わせました。内部レイアウトモード、フロー動作、および可視性ステータスはすべて、`display`プロパティによって制御されます。これらの値を個別の`display`キーワードに分けて、カスタムプロパティを介して個別に調整できるようにする努力がありますが、当分の間<a hreflang="en" href="https://caniuse.com/mdn-css_properties_display_multi-keyword_values">ブラウザのサポートは事実上存在しません</a>。

{{ figure_markup(
  image="important-top-properties.png",
  caption="ページの割合で上位の`!important`プロパティを表示します。",
  description="`!important`で使われているプロパティのトップ10を示す棒グラフ。モバイルとデスクトップでは、使用方法が似ています。`display`プロパティは`!important`で最も多く使用されており、モバイルページの79%で使用されています。それに続くプロパティは、モバイルページの71-58%で、順に以下のようになっています。`color`,`width`,`height`,`background`,`padding`,`margin`,`border`,`background-color`,`float`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=257343566&format=interactive",
  sheets_gid="1222608982",
  sql_file="meta_important_properties.sql"
) }}

### 特異性とクラス

`id`と`!important`をほとんど使わないようにすることに加えて、セレクターのすべての選択基準を単一のクラス名に詰め込むことで特異性を完全に回避する傾向があり、その結果すべてのルールが同じ特異性を持つことを強制し、カスケードをより単純なラストワンウィンシステムに変える。BEMは、唯一のものではありませんが、このタイプの一般的な方法論です。すべてのルールでBEMスタイルの方法論に従うことは稀なので、どのくらいの数のウェブサイトがBEMスタイルの方法論を独占的に使用しているのかを評価することは困難ですが（<a hreflang="en" href="https://en.bem.info/">BEMのウェブサイト</a>でさえ、多くのセレクターで複数のクラスを使用しています）、ページの約10％の中央値が(0,1,0)の特異度を持っており、これはほとんどがBEMスタイルの方法論に従っていることを示しているかもしれません。BEMの反対側では、開発者はしばしば<a hreflang="en" href="https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/#safely-increasing-specificity">重複クラス</a>を使って特異性を高め、セレクターを別のセレクターよりも先に進めるようにしています（例えば、`.foo`の代わりに`.foo.foo.foo`とするなど）。この種の特異性ハックは実際にはBEMよりも人気があり、モバイルサイトの14%（デスクトップの9%）に存在しています。これは、ほとんどの開発者がカスケードを完全に排除することを望んでいるわけではなく、単にカスケードをよりコントロールしたいだけだということを示しているのかもしれません。

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
        <td>10</td>
        <td>0,1,0</td>
        <td>0,1,0</td>
      </tr>
      <tr>
        <td>25</td>
        <td>0,2,0</td>
        <td>0,1,2</td>
      </tr>
      <tr>
        <td>50</td>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <td>75</td>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <td>90</td>
        <td>0,3,0</td>
        <td>0,3,0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="1ページあたりの特異度中央値の分布。",
      sheets_gid="1213836297",
      sql_file="specificity.sql"
    ) }}
  </figcaption>
</figure>

### セレクター属性

最も人気のある属性セレクターは`type`属性で、45%のページで使用されており、異なるタイプの入力をスタイルする可能性があります。

{{ figure_markup(
  image="attribute-selectors.png",
  caption="ページの割合で最も人気のあるセレクター属性。",
  description="上位のセレクター属性をページのパーセンテージ別に示した棒グラフ。モバイルとデスクトップの使用率は似ています。最も人気のあるセレクター属性は`type`で、モバイルページの46%で使用されています。次に、`class`セレクター属性がモバイルページの30%で使用されています。次のセレクター属性は17～3%で利用されています。`disabled`,`dir`,`title`,`hidden`,`controls`,`data-type`,`data-align`,`href`,`poster`,`role`,`style`,`xmlns`,`aria-disabled`,`src`,`id`,`name`,`lang`,`multiple`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=320159317&format=interactive",
  sheets_gid="1926527049",
  sql_file="top_selector_attributes.sql"
) }}

### 擬似クラスと擬似要素

ウェブプラットフォームが長く確立された後に何かを変更するときには、常に多くの慣性があります。例えば10年以上前に変更があったにもかかわらず、疑似要素が疑似クラスとは別の構文を持つことに、ウェブはまだほとんど追いついていません。レガシーな理由で疑似クラスの構文でも利用できるすべての疑似要素は、疑似クラスの構文の方がはるかに普及しています（2.5倍から5倍！）。

{{ figure_markup(
  image="selector-pseudo-classes.png",
  caption="レガシーの`:pseudo-class`構文を`::pseudo-elements`のモバイルページの割合として使用します。",
  description="棒グラフは、擬似クラス構文(前に1コロン)と擬似要素構文(2コロン)を擬似要素に使用しているページの割合を示しています。前の`before`擬似要素は、モバイルページの71%で擬似クラス構文を使用し、33%で擬似要素構文を使用しています。擬似要素の`after`は、クラスと要素の構文でモバイルページの68%と30%、`first-letter`でモバイルページの7%と1%、`first-line`でモバイルページの1%と0%で使用されている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=227968207&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

圧倒的に最も人気のある擬似クラスはユーザーアクションのもので、`:hover`,`:focus`,`:active`がリストのトップにあり、すべてのページの3分の2以上で使用されていて、開発者が宣言的なUIインタラクションを指定できる利便性を気に入っていることがわかります。

`:root`は、その機能が正当化されるよりもはるかに人気があるようで、3分の1のページで使用されています。HTMLコンテンツでは、`<html>`要素を選択するだけなのに、なぜ開発者は`html`を使わなかったのでしょうか？　考えられる答えは、`:root`擬似クラスへカスタムプロパティを定義することに関連した一般的な慣習にあるかもしれません[これも非常によく使われています](#custom-properties)。もう1つの答えは特異性にあるかもしれません:`:root`は擬似クラスであるため、`html`よりも高い特異性を持っています。(0, 1, 0) 対 (0, 0, 1) です。例えば、`:root .foo`の特異度は (0, 2, 0) であるのに対し、`.foo`の特異度は (0, 1, 0) です。これは、カスケードレースの中でセレクターが他のセレクターよりもわずかに上を行くのに必要なことが多く、`!important`のようなスレッジハンマーを避けるために必要なことです。この仮説を検証するために、私たちはまた、まさにこれを測定しました：子孫セレクターの先頭に`:root`を使うページがどれくらいあるか？　結果は我々の仮説を検証しました：29%のページがそのように`:root`を使用しています。さらにデスクトップページの14％とモバイルページの19％が、子孫セレクターの開始時に`html`を使用しており、おそらくセレクターの特異性をさらに小さくするために使用していると思われます。これらの特異性ハックの人気は、開発者が`!important`を介してそれらに与えられているものよりも特異性を微調整するためのより細かい制御を必要とすることを強く示しています。ありがたいことに、これは [`:where()`](https://developer.mozilla.org/ja/docs/Web/CSS/:where) でまもなく実現します。すでに <a hreflang="en" href="https://caniuse.com/mdn-css_selectors_where">全面的に実装されています</a>（今のところChromeではフラグの後ろに隠れていますが）。

{{ figure_markup(
  image="popular-selector-pseudo-classes.png",
  caption="ページ数に占める割合としては、最も人気のある疑似クラス。",
  description="デスクトップとモバイルのページに占める最も人気のある疑似クラスの割合を示す棒グラフ。デスクトップとモバイルはほぼ同様で、モバイルの方が採用率が若干高い傾向にあります。最も人気のある擬似クラスは`hover`で、84%のページで使用されています。以下の擬似クラスは、71%から12%へとほぼ直線的に人気が低下しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1363774711&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

疑似要素に関しては通常の疑似要素である`::before`と`::after`に続いて、人気のある疑似要素のほとんどは、フォームコントロールやその他の組み込みUIをスタイリングするためのブラウザ拡張機能であり、組み込みUIのスタイリングをより細かく制御したいという開発者のニーズを強く反映しています。フォーカスリング、プレースホルダー、検索入力、スピナー、選択、スクロールバー、メディアコントロールのスタイリングは特に人気がありました。

{{ figure_markup(
  image="popular-selector-pseudo-elements.png",
  caption="ページ数に占める割合としては、最も人気のある疑似要素です。",
  description="デスクトップとモバイルのページに占める最も人気のある疑似要素の割合を示す棒グラフ。デスクトップとモバイルはほぼ同様で、モバイルの方が採用率が若干高い傾向にあります。最も人気のある擬似要素は`before`で、モバイルページの33%で使用されています。擬似要素`after`はモバイルページの30%で使用されています。また、`moz-focus-inner`は24%のページで使われている。擬似要素の人気は17%から4%へと順に下がっていく。`webkit-input-placeholder`、`moz-placeholder`、`webkit-search-decoration`、`webkit-search-cancel-button`、`webkit-inner-spin-button`(7%),`selection`,`-ms-clear`,`-moz-select`,`-webkit-media-controls`,`-webkit-scrollbar-thumb`の順に人気が落ちています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1417577353&format=interactive",
  sheets_gid="1972610663",
  sql_file="top_selector_pseudo_elements.sql",
  width=600,
  height=500
) }}

## 値と単位

CSSには値や単位を指定する方法が多数用意されており、長さの設定や計算、あるいはグローバルキーワードに基づいて指定できます。

### 長さ

地味な`px`単位は、長年にわたって多くの否定的な報道を受けてきました。最初は古いInternet Explorerのズーム機能との相性が悪かったことが原因でしたが、最近ではビューポートサイズ、要素フォントサイズ、ルートフォントサイズなどの別のデザイン要素に基づいてスケーリングする、ほとんどのタスクに対応する優れた単位が登場し暗黙のデザイン関係を明示的にすることでメンテナンスの手間を減らすことができました。ピクセルの主なセールスポイントであった`px`-デザイナーが完全に制御できる1つのデバイスピクセルに対応するという点も、現在の高ピクセル密度スクリーンではピクセルはもはやデバイスピクセルではないため、今ではなくなっています。このような状況にもかかわらず、CSSピクセルは今でもウェブのデザインをほぼ全面的に牽引しています。

{{ figure_markup(
  caption="`px`単位を使用している`<length>`値の割合。",
  content="72.58%",
  classes="big-number",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

`px`単位は全体的に最も人気のある長さの単位であり、全スタイルシートの長さの72.58%が`px`を使用しています。さらにパーセンテージを除外すると（パーセンテージは実際には単位ではないので）、`px`のシェアはさらに増えて84.14%となっています。

{{ figure_markup(
  image="length-units.png",
  caption="最も人気のある`<length>`の単位を出現率で表したものです。",
  description="棒グラフは、最も人気のある長さの単位の出現率（すべてのスタイルシートで出現する頻度）を示しています。px単位が圧倒的に人気があり、モバイルスタイルシートでは 73%の割合で使われています。次に人気のある単位は`%`（パーセント記号）で17%で、次いで`em`(9%)、`rem`(1%) である。以下の単位はいずれも使用率が低く、四捨五入すると0%になる。`pt`,`vw`,`vh`,`ch`,`ex`,`cm`,`mm`,`in`,`vmin`,`pc`および`vmax`である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2095127496&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

この`px`はプロパティ間でどのように分布しているのでしょうか？　プロパティによって違いはありますか？　ほとんど間違いありません。例えば、`font-size`や`line-height`、`text-indent`などのフォント関連のメトリクスに比べて、`px`の使用率はボーダーの方がはるかに高い（80-90%）と予想されます。しかし、これらの場合でも`px`の使用率は他の単位をはるかに上回っています。実際、`px`よりも他のユニット（ *他の* ユニット）が使われているプロパティは、`vertical-align`(55%`em`)、`mask-position`(50%`em`)、`padding-in-line-start`(62%`em`)、`margin-block-start`と`margin-block-end`(65%`em`)、そして新しい`gap`(62%`rem`) だけです。

これらのコンテンツの多くは古いもので、相対単位を使ってデザインの適応性を高めたり、時間を節約したりすることに作者がもっと意識を向けるようになる前に書かれたものだと簡単に論じることができます。しかし、これは`grid-gap`(62%`px`)のような最近のプロパティを見れば簡単に反論できます。

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
        <td><code>font-size</code></td>
        <td class="numeric">70%</td>
        <td class="numeric">2%</td>
        <td class="numeric">17%</td>
        <td class="numeric">6%</td>
        <td class="numeric">4%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>line-height</code></td>
        <td class="numeric">54%</td>
        <td class="numeric">31%</td>
        <td class="numeric">13%</td>
        <td class="numeric">3%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>border</code></td>
        <td class="numeric">71%</td>
        <td class="numeric">27%</td>
        <td class="numeric">2%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>border-radius</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">21%</td>
        <td class="numeric">3%</td>
        <td class="numeric">10%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>text-indent</code></td>
        <td class="numeric">32%</td>
        <td class="numeric">51%</td>
        <td class="numeric">8%</td>
        <td class="numeric">9%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>vertical-align</code></td>
        <td class="numeric">29%</td>
        <td class="numeric">12%</td>
        <td class="numeric">55%</td>
        <td class="numeric">4%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>grid-gap</code></td>
        <td class="numeric">63%</td>
        <td class="numeric">11%</td>
        <td class="numeric">9%</td>
        <td class="numeric">1%</td>
        <td class="numeric">16%</td>
        <td></td>
      </tr>
      <tr>
        <td><code>mask-position</code></td>
        <td></td>
        <td></td>
        <td class="numeric">50%</td>
        <td class="numeric">50%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>padding-inline-start</code></td>
        <td class="numeric">33%</td>
        <td class="numeric">5%</td>
        <td class="numeric">62%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>gap</code></td>
        <td class="numeric">21%</td>
        <td class="numeric">16%</td>
        <td class="numeric">1%</td>
        <td></td>
        <td class="numeric">62%</td>
        <td></td>
      </tr>
      <tr>
        <td><code>margin-block-end</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">31%</td>
        <td class="numeric">65%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>margin-inline-start</code></td>
        <td class="numeric">38%</td>
        <td class="numeric">46%</td>
        <td class="numeric">14%</td>
        <td></td>
        <td class="numeric">1%</td>
        <td></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="プロパティ別の単位使用量。",
      sheets_gid="1200981062",
      sql_file="units_properties.sql"
    ) }}
  </figcaption>
</figure>

同様に、多くのユースケースで`rem`と`em`の優位性が大いに宣伝されており、ブラウザでの普遍的なサポートが <a hreflang="en" href="https://caniuse.com/rem">何年にもわたって</a>されているにもかかわらず、ウェブはまだほとんど追いついていないのが現状です。野生では`ch`（'0'グリフの幅）と`ex`（使用中のフォントのx-height）の使用も見られましたが、非常に小さいものでした（全フォント関係単位の0.37%と0.19%に過ぎませんでした）。

{{ figure_markup(
  image="font-units.png",
  caption="フォント相対単位の相対シェア",
  description="各フォントベースのユニットの相対的な人気度を示す棒グラフ。`em`が87.3%と圧倒的に多く、次いで`rem`が12.2%、`ch`が0.4%、モバイルページでは`ex`が0.2%となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=166603845&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

つまり、`0px`や`0em`などの代わりに`0`と書くことができます。開発者（あるいはCSSのミニファイヤー？）はこれを広く利用しています。すべての`0`値のうち、89%は単位がありませんでした。

{{ figure_markup(
  image="zero-lengths.png",
  caption="モバイルページでの出現率としての単位ごとの長さ0の相対的な人気度。",
  description="円グラフを見ると、モバイルページでは単位のない長さ0（別名ユニットレス）が88.7％、`px`単位が10.7％、その他の単位が0.5％のインスタンスで使われていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1935151776&format=interactive",
  sheets_gid="313150061",
  sql_file="units_zero.sql"
) }}

### 計算

CSSで異なる単位間の計算を行うために[`calc()`](https://developer.mozilla.org/ja/docs/Web/CSS/calc()) 関数が導入されたとき、それは革命でした。以前はプリプロセッサだけがこのような計算に対応していましたが、結果は静的な値に限定され、しばしば必要とされる動的なコンテキストを欠いていたため、信頼性がありませんでした。

今日では、`calc()`は<a hreflang="en" href="https://caniuse.com/calc">すべてのブラウザでサポートされている</a> ということで、すでに9年が経過しているので60%のページで一度は使われており、広く採用されているのは驚くに値しません。どちらかと言えば、これよりももっと高い採用率を期待していました。

`calc()`は主に長さのために使われ、その96%は`<length>`値を受け付けるプロパティに集中しており、そのうちの60%（全体の58%）は`width`プロパティに使用されています！

{{ figure_markup(
  image="calc-properties.png",
  caption="`calc()`を使用するプロパティの相対的な人気度を、出現率の割合で示します。",
  description="calc関数を使用するプロパティの相対的な人気度を、出現率として示した棒グラフ。デスクトップとモバイルでも同様の結果が得られています。calc関数は幅プロパティで最も多く使用されており、モバイルページでのcalc発生の59%を占めています。calc関数はleftプロパティで11%、topプロパティ5%、max-widthプロパティ4%、heightプロパティ4%使用されており、残りのプロパティは2%と1%で減少しています：min-height、margin-left、flex-basis、margin-right、max-height (1%)、right、padding-bottom、padding-left、font-size、padding-right。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=722318406&format=interactive",
  sheets_gid="1661677319",
  sql_file="calc_properties.sql"
) }}

これは、`calc()`で最もよく使われる単位が`px`（`calc()`の51%）と`%`（`calc()`の42%）であり、`calc()`の64%が減算を含んでいることからも明らかなように、ほとんどがパーセントからピクセルを引くために使われているようです。興味深いことに、`calc()`で最も人気のある長さの単位は全体的に最も人気のある長さの単位とは異なります（例えば、`em`よりも`rem`の方が人気があり、次いでビューポート単位が続きます）。

{{ figure_markup(
  image="calc-units.png",
  caption="`calc()`を使用する単位の相対的な人気度を、出現率の割合で示します。",
  description="calc関数を使用するプロパティの相対的な人気度を、出現率として示した棒グラフ。デスクトップとモバイルでも同様の結果が得られています。calc関数は`width`プロパティで最も頻繁に使用されており、モバイルページでのcalc発生の59%を占めています。calc関数は`left`プロパティ11%、`top`プロパティ5%、`max-width`プロパティ4%、`height`プロパティ4%の割合で使用されており、残りのプロパティは2%と1%で減少しています:`min-height`,`margin-left`,`flex-basis`,`margin-right`,`max-height`(1%),`right`,`padding-bottom`,`padding-left`,`font-size`,`padding-right`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=477094785&format=interactive",
  sheets_gid="769910871",
  sql_file="calc_units.sql"
) }}

{{ figure_markup(
  image="calc-operators.png",
  caption="`calc()`を使用する演算子の相対的な人気度を、出現回数の割合で示します。",
  description="calc関数を使用しているオペレーターの相対的な人気度を発生率として示した棒グラフ。デスクトップとモバイルでも同様の結果が得られています。モバイルページのcalcインスタンスの64%が減算演算子（マイナス記号）でcalc関数を最もよく使用しており、次いで除算（フォワードスラッシュ）20%、加算（プラス記号）11%、乗算（アスタリスク）5%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1909242522&format=interactive",
  sheets_gid="2077258816",
  sql_file="calc_operators.sql"
) }}

ほとんどの計算は非常に単純で、最大2つの異なる単位を含む計算の99.5％、最大2つの演算子を含む計算の88.5％、1セット以下の括弧を含む計算の99.4％（4つの計算のうち3つは括弧が全く含まれていません）となっています。

{{ figure_markup(
  image="calc-complexity-units.png",
  caption="`calc()`の発生ごとの単位数の分布。",
  description="calc関数の1回の発生あたりの単位数の分布を示す棒グラフ。デスクトップとモバイルでは似たような結果となっています。モバイルページでは、Calcの使用頻度は1回が11％、2回が89％、3回以上が約0％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=695698141&format=interactive",
  sheets_gid="1493602565",
  sql_file="calc_complexity_units.sql"
)
}}

### グローバルキーワードと`all`

それは[`inherit`](https://developer.mozilla.org/ja/docs/Web/CSS/inherit)で、継承可能なプロパティを継承された値にリセットしたり、継承不可能なプロパティに対して親の値を再利用したりすることを可能にします。前者の方が後者よりもはるかに一般的で、`inherit`の81.37%が継承可能なプロパティで使用されています。残りのほとんどは、背景、境界線、寸法を継承するためのものです。後者は、適切なレイアウトモードでは`width`と`height`を強制的に継承する必要がほとんどないため、レイアウトの難しさを示している可能性が高いです。

`inherit`キーワードは、リンクのアフォーダンスとして色以外のものを使おうとしている場合に、デフォルトのリンク色を親のテキスト色にリセットするのに特に便利です。したがって、`color`が`inherit`で使用される最も一般的なプロパティであることは驚くことではありません。すべての`inherit`の使用量のほぼ3分の1は`color`プロパティにあります。75%のページでは、少なくとも一度は`color: inherit`を使用しています。

プロパティの*初期値*は<a hreflang="en" href="https://www.w3.org/TR/CSS1/#cascading-order">CSS1の頃から存在していた</a>概念ですが、それを明示的に参照するための専用のキーワード`initial`ができたのは<a hreflang="en" href="https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#initial-keyword">17年後</a>で、そのキーワードが<a hreflang="en" href="https://caniuse.com/css-initial-value">ブラウザのユニバーサルサポート</a>になるまでにはさらに2年かかりました。したがって、`inherit`よりもはるかに使用されていないのは当然のことです。古い継承が85%のページで見られるのに対し、`initial`は51%のページで見られます。さらに、`initial`が実際に何をするのかについては多くの混乱があり、`display`は`initial`とともに最もよく使われるプロパティのリストのトップにあり、`display: initial`はページの10%に表示されています。おそらく開発者は、これによって`display`が[user agent stylesheet](https://developer.mozilla.org/ja/docs/Web/CSS/Cascade#user-agent_stylesheets)の値にリセットされ、`display: none`のオンオフを切り替えるために利用されていると考えたのだろう。しかし、<a hreflang="en" href="https://drafts.csswg.org/css-display/#the-display-properties">`display`の初期値は`inline`である</a>ので、`display: initial`は単に`display: inline`を書くための別の方法であり、コンテキストに依存した魔法のような特性を持たない。

代わりに、`display: revert`は、これらの開発者が期待していたことを実際に行い、`display`を与えられた要素のUA値にリセットすることになるだろう。しかし、`revert`はもっと新しいもので、定義されたのは<a hreflang="en" href="https://www.w3.org/TR/2015/WD-css-cascade-4-20150908/#valdef-all-revert">2015年</a>であり、<a hreflang="en" href="https://caniuse.com/css-revert-value">今年ユニバーサルブラウザのサポートを得ただけ</a>であるため、あまり使われていないことがわかります：ページの0.14%にしか表示されず、使用量の半分は<a hreflang="en" href="https://github.com/WordPress/WordPress/commit/303180b392c530b8e2c8b3c27532d591b915caeb">WordPressのTwentyTwentyテーマの最近のバージョン</a>にある`line-height: revert;`です。

最後のグローバルキーワード`unset`は、本質的に`initial`と`inherit`のハイブリッドです。継承されたプロパティでは`inherit`になり、それ以外のプロパティでは`initial`になります。同様に、`initial`と同様に、`unset`は<a hreflang="en" href="https://www.w3.org/TR/2013/WD-css-cascade-3-20130730/#inherit-initial">2013年に定義</a> され、2015年には<a hreflang="en" href="https://caniuse.com/css-unset-value">ブラウザのフルサポート</a> されました。`unset`の方が実用性が高いにもかかわらず、`initial`が51%のページで使用されているのに対し、`unset`は43%のページでしか使用されていません。さらに、`max-width`と`min-width`以外のすべてのプロパティにおいて、`initial`の使用率が`unset`の使用率を上回っています。

{{ figure_markup(
  image="keyword-totals.png",
  caption="グローバルキーワードの採用率がページ数に占める割合。",
  description="グローバルキーワードの採用率をページに占める割合を示す棒グラフ。モバイルページほど採用率が高い傾向にあります。モバイルページでは、`inherit`キーワードが85％、`initial`が51％、`unset`が43％、`revert`が約0％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1246886332&format=interactive",
  sheets_gid="437371205",
  sql_file="keyword_totals.sql"
) }}

`all`プロパティは<a hreflang="en" href="https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#all-shorthand">2013年に導入</a> され、<a hreflang="en" href="https://caniuse.com/css-all">2016年にはほぼユニバーサルに近い形でサポートされ(Edgeを除く)、今年初めにはユニバーサルに対応</a> しました。これは、CSSのほぼすべてのプロパティ（カスタムプロパティ、`direction`、`unicode-bidi`を除く）の短縮形であり、<a hreflang="en" href="https://drafts.csswg.org/css-cascade-4/#defaulting-keywords">4つのグローバルキーワード</a>（`initial`、`inherit`、`unset`、`revert`）のみを値として受け入れます。これは、どのようなリセットをしたいかに応じて`all: unset`や`all: revert`のように、CSSのリセットを一本化することを想定していました。しかし、まだ採用率は非常に低く、`all`が見つかったのは477ページ（全ページの0.01%）で、`revert`キーワードと一緒に使われただけでした。

## カラー

古いジョークは最高だと言われますが、それは色にも当てはまります。オリジナルの暗号的な`#rrggbb`16進法は、2020年のCSSで色を指定するための最も一般的な方法であり続けています。全色の半分はこの方法で書かれています。次に人気のある形式は、やや短めの`#rgb`3桁の16進数形式で、26%となっています。これはより短いとはいえ、表現できる色数はかなり少なく、1670万個のsRGB値のうちわずか4096個です。

{{ figure_markup(
  image="popular-color-formats.png",
  caption="カラーフォーマットの相対的な普及率。",
  description="カラーフォーマットの相対的な普及率を示す棒グラフです。モバイルページでは、`#rrggbb`フォーマットが50%で使用されており、デスクトップでは52%とわずかに高くなっています。モバイルページでは、`#rgb`フォーマットが25%で使用されており、次いで`rgba()`が14%、`transparent`が8%、`red`のような名前付きカラーが1%で、残りのカラーフォーマットはいずれもモバイルページでの相対的な人気度は約0%です。それ以外のカラーフォーマットは、`#rrggbbaa`,`rbg()`,`hsla()`,`currentColor`,`#rgba`, システムカラー,`hsl()`,`color()`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=65722098&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

同様に、機能的に指定されたsRGBカラーの99.89%は、カンマなしの新しい形式`rgb(127 255 84)`ではなく、コンマ付きのレガシー形式`rgb(127, 255, 84)`を使用しています。なぜなら、すべての最新のブラウザが新しい構文を受け入れているにもかかわらず、変更しても開発者にとってのメリットはゼロだからです。

では、なぜ人々はこれらの試行錯誤されたフォーマットから迷走するのでしょうか？アルファの透過性を表現するためです。これは`rgba()`を見れば明らかで、`rgb()`の40倍の使用率（全色の13.82%対0.34%）と`hsl()`の30倍の使用率（全色の0.25%対0.01%）である`hsla()`を見ればわかります。

HSLは<a hreflang="en" href="https://drafts.csswg.org/css-color-4/#the-hsl-notation">わかりやすく、修正しやすい</a>はずです。しかし、これらの数字は、実際にはスタイルシートでのHSLの使用がRGBよりもはるかに少ないことを示しています。

{{ figure_markup(
  image="color-formats-alpha.png",
  caption="カラーフォーマットの相対的な人気度をアルファサポート別にグループ化し、モバイルページでの出現率で示したもの（`#rrggbb`および`#rgb`を除く）。",
  description="アルファサポートの有無でグループ化されたカラーフォーマットの相対的な人気度を、`#rrggbb`と`#rgb`を除いたモバイルページでの出現率で示した棒グラフです。アルファをサポートしているカラーフォーマットの出現率は約23%で、アルファをサポートしていないカラーフォーマットの出現率は2%にすぎません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1861989753&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

名前付きカラーについてはどうでしょうか？　透明な`transparent`というキーワードは、`rgb(0 0 0 0 / 0)`という言い方もできますが、最も人気のあるキーワードで、sRGBの値全体の8.25%を占めています（名前付きカラーの使用量全体の66%）。これらの中で最も人気があったのは、`white`,`black`,`red`,`gray`,`blue`のようなわかりやすい名前でした。非日常的な名前の中では`whitesmoke`が最もよく使われていました（確かに、whitesmokeはイメージできますよね）が、`gainsboro`,`lightCoral`,`burlywood`などはあまり使われていませんでした。その理由は理解できますが、実際に何を意味するのかは調べてみる必要があります。

また、派手な色の名前をつけたいのであれば、CSS[Custom properties](#custom-properties)で自分の色を定義してみてはいかがでしょうか。`--intensePurple`と`--corporateBlue`は、あなたが必要とするものなら何でも意味を持ちます。これはおそらく、[カスタムプロパティの50%](#use-by-type)が色に使われている理由を説明していると思います。

{{ figure_markup(
  link="https://codepen.io/leaverou/pen/GRjjJwJ",
  image="color-keywords-app.png",
  caption='<a hreflang="en" href="https://codepen.io/leaverou/pen/GRjjJwJ">このインタラクティブなアプリ</a>を使って、カラーキーワードの使用データをインタラクティブに探ってみましょう！',
  description="色を選択し、円グラフで色の相対的な使用状況を確認できるインタラクティブなアプリのスクリーンショット。色のデータは次の表のようになっています。",
  width=600,
  height=1065
  )
}}

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
        <td>{{ swatch('transparent') }}</span></td>
        <td>transparent</td>
        <td class="numeric">84.04%</td>
        <td class="numeric">83.51%</td>
      </tr>
      <tr>
        <td>{{ swatch('white') }}</td>
        <td>white</td>
        <td class="numeric">6.82%</td>
        <td class="numeric">7.34%</td>
      </tr>
      <tr>
        <td>{{ swatch('black') }}</span></td>
        <td>black</td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.42%</td>
      </tr>
      <tr>
        <td>{{ swatch('red') }}</td>
        <td>red</td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.01%</td>
      </tr>
      <tr>
        <td>{{ swatch('currentColor') }}</span></td>
        <td>currentColor</td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.43%</td>
      </tr>
      <tr>
        <td>{{ swatch('gray') }}</span></td>
        <td>gray</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td>{{ swatch('silver') }}</span></td>
        <td>silver</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>{{ swatch('grey') }}</span></td>
        <td>grey</td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td>{{ swatch('green') }}</span></td>
        <td>green</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>{{ swatch('magenta') }}</span></td>
        <td>magenta</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('blue') }}</span></td>
        <td>blue</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('whitesmoke') }}</span></td>
        <td>whitesmoke</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgray') }}</span></td>
        <td>lightgray</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>{{ swatch('orange') }}</span></td>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgrey') }}</span></td>
        <td>lightgrey</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('yellow') }}</span></td>
        <td>yellow</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>{{ swatch('Highlight') }}</span></td>
        <td>Highlight</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('gold') }}</span></td>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('pink') }}</span></td>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>{{ swatch('teal') }}</span></td>
        <td>teal</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="カラーキーワードの相対的な人気度を出現率で表す。",
      sheets_gid="1429541094",
      sql_file="color_keywords.sql"
    ) }}
  </figcaption>
</figure>

そして最後に、`Canvas`や`ThreeDDarkShadow`のような、かつては非推奨だったが、今では部分的に非推奨になっているシステムカラー: これらはひどいアイデアでJavaやWindows 95のようなものの典型的なユーザーインターフェースをエミュレートするために導入されましたが、すでにWindows 98には追いつけず、すぐに廃れてしまいました。いくつかのサイトでは、これらのシステムカラーを使ってあなたの指紋を採取しようとしていますが、この抜け穴は<a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5710">私たちが話している間に閉鎖しようとしています</a>。これらを使用する正当な理由はほとんどなく、ほとんどのウェブサイト(99.99%)は使用していないので、私たちは問題ありません。

驚くべきことに、<a hreflang="en" href="https://css-tricks.com/currentcolor/">かなり有用な値`currentColor`</a> は、全sRGB色の0.14%（名前のついた色の1.62%）にとどまりました。

これまで議論してきたすべての色に共通しているのは、ウェブの標準色空間であるsRGB（そしてハイビジョンテレビの場合は、そこから来ている）ということです。なぜそれがそんなに悪いのでしょうか？　それは、限られた色の範囲しか表示できないからです。携帯電話、テレビ、そしておそらくあなたのラップトップは、ディスプレイ技術の進歩により、はるかに鮮やかな色を表示することができます。以前は高給取りのプロの写真家やグラフィックデザイナーのために予約されていた広い色域を持つディスプレイは、今では誰もが利用できるようになりました。ネイティブアプリはデジタル映画やストリーミングTVサービスと同様にこの機能を使用していますが、最近までウェブはこの機能を利用していませんでした。

そして、我々はまだ見落としている。<a hreflang="en" href="https://webkit.org/blog/6682/improving-color-on-the-web/">2016年にSafariで実装された</a>にもかかわらず、ウェブページでのdisplay-p3カラーの使用は、ごくわずかです。私たちがウェブをクロールしたところ、モバイルでは29ページ、デスクトップでは36ページしか使用されていませんでした。（そして、その半分以上は構文エラーやミス、未実装の`color-mod()`関数を使おうとしたものでした）。私たちはその理由を知りたいと思いました。

相性だよね？　壊れてほしくないですよね？　私たちが調べたスタイルシートでは、フォールバックがしっかりと使われていました:ドキュメントの順番、カスケード、`@supports`、`color-gamut`メディアクエリなど、良いものはすべて揃っていました。スタイルシートの中には、デザイナーが望む色が表示され、display-p3で表現され、フォールバックのsRGB色も表示されていました。希望する色と予備色の間の目に見える差（<a hreflang="en" href="https://zschuessler.github.io/DeltaE/learn/">ΔE2000</a>と呼ばれる計算）を計算してみましたが、これは一般的には非常に控えめなものでした。ちょっとした微調整。慎重な探索。実際、display-p3で指定した色は、sRGBが管理できる色の範囲（色域）内に収まっていることが37.6%もありました。今のところは、実際に利益を得るためというよりも、慎重に実験しているだけのようだが、今後の展開に期待したいところだ。

<figure>
  <table class="large-table">
    <thead>
      <tr>
        <th scope="col" colspan="2">sRGB</th>
        <th scope="col">display-p3</th>
        <th scope="col">ΔE2000</th>
        <th scope="col" class="no-wrap">色域</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td><code>color(display 1 0.80 0.25 / 1)</code></td>
        <td class="numeric">3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(120,0,255,1)</code></td>
        <td>{{ swatch('rgba(120, 0, 255, 1)') }}</td>
        <td><code>color(display 0.47 0 1 / 1)</code></td>
        <td class="numeric">1.933</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(121,127,132,1)</code></td>
        <td>{{ swatch('rgba(121, 127, 132, 1)') }}</td>
        <td><code>color(display 0.48 0.50 0.52 / 1)</code></td>
        <td class="numeric">0.391</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(200,200,200,1)</code></td>
        <td>{{ swatch('rgba(200, 200, 200, 1)') }}</td>
        <td><code>color(display 0.78 0.78 0.78 / 1)</code></td>
        <td class="numeric">0.274</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(97,97,99,1)</code></td>
        <td>{{ swatch('rgba(97, 97, 99, 1)') }}</td>
        <td><code>color(display 0.39 0.39 0.39 / 1)</code></td>
        <td class="numeric">1.474</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(0,0,0,1)</code></td>
        <td>{{ swatch('rgba(0, 0, 0, 1)') }}</td>
        <td><code>color(display 0 0 0 / 1)</code></td>
        <td class="numeric">0.000</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,255,255,1)</code></td>
        <td>{{ swatch('rgba(255, 255, 255, 1)') }}</td>
        <td><code>color(display 1 1 1 / 1)</code></td>
        <td class="numeric">0.015</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td><code>color(display 0.33 0.25 0.53 / 1)</code></td>
        <td class="numeric">1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td><code>color(display 0.51 0.40 0.78 / 1)</code></td>
        <td class="numeric">1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td><code>color(display 0.27 0.75 0.82 / 1)</code></td>
        <td class="numeric">5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(255,0,72)</code></td>
        <td>{{ swatch('rgb(255, 0, 72)') }}</td>
        <td><code>color(display 1 0 0.2823 / 1)</code></td>
        <td class="numeric">3.529</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td><code>color(display 1 0.80 0.25 / 1)</code></td>
        <td class="numeric">3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(241,174,50,1)</code></td>
        <td>{{ swatch('rgba(241, 174, 50, 1)') }}</td>
        <td><code>color(display 0.95 0.68 0.17 / 1)</code></td>
        <td class="numeric">4.701</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(245,181,40,1)</code></td>
        <td>{{ swatch('rgba(245, 181, 40, 1)') }}</td>
        <td><code>color(display 0.96 0.71 0.16 / 1)</code></td>
        <td class="numeric">4.218</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(147, 83, 255)</code></td>
        <td>{{ swatch('rgb(147, 83, 255)') }}</td>
        <td><code>color(display 0.58 0.33 1 / 1)</code></td>
        <td class="numeric">2.143</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(75,3,161,1)</code></td>
        <td>{{ swatch('rgba(75, 3, 161, 1)') }}</td>
        <td><code>color(display 0.29 0.01 0.63 / 1)</code></td>
        <td class="numeric">1.321</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,0,0,0.85)</code></td>
        <td>{{ swatch('rgba(255, 0, 0, 0.85)') }}</td>
        <td><code>color(display 1 0 0 / 0.85)</code></td>
        <td class="numeric">7.115</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td><code>color(display 0.33 0.25 0.53 / 1)</code></td>
        <td class="numeric">1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td><code>color(display 0.51 0.40 0.78 / 1)</code></td>
        <td class="numeric">1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td><code>color(display 0.27 0.75 0.82 / 1)</code></td>
        <td class="numeric">5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#6d3bff</code></td>
        <td>{{ swatch('#6d3bff') }}</td>
        <td><code>color(display .427 .231 1)</code></td>
        <td class="numeric">1.584</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#03d658</code></td>
        <td>{{ swatch('#03d658') }}</td>
        <td><code>color(display .012 .839 .345)</code></td>
        <td class="numeric">4.958</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#ff3900</code></td>
        <td>{{ swatch('#ff3900') }}</td>
        <td><code>color(display 1 .224 0)</code></td>
        <td class="numeric">7.140</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#7cf8b3</code></td>
        <td>{{ swatch('#7cf8b3') }}</td>
        <td><code>color(display .486 .973 .702)</code></td>
        <td class="numeric">4.284</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#f8f8f8</code></td>
        <td>{{ swatch('#f8f8f8') }}</td>
        <td><code>color(display .973 .973 .973)</code></td>
        <td class="numeric">0.028</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e3f5fd</code></td>
        <td>{{ swatch('#e3f5fd') }}</td>
        <td><code>color(display .875 .945 .976)</code></td>
        <td class="numeric">1.918</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e74832</code></td>
        <td>{{ swatch('#e74832') }}</td>
        <td><code>color(display .905882353 .282352941 .196078431 / 1 )</code></td>
        <td class="numeric">3.681</td>
        <td>true</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption='この表は、フォールバックのsRGB色を表示した後、ディスプレイp3色を表示したものです。1の色差(ΔE2000)はかろうじて見えますが、5ははっきりと区別できます。これは要約表です(<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/#gid=264429000">表全体を参照</a>)。',
      sheets_gid="1370141402"
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="p3-chromaticity-big.svg",
  object="p3-chromaticity-big.svg",
  caption="指定されたdisplay-p3色のUV色度とそのフォールバック。",
  description="この1976年のu'v'図は、色の色度を示しています（2Dにフラット化しているので、明るさは表示されていません）。外側の曲線は純粋な単一波長のスペクトルを表しています。直線は紫で、赤と紫が混ざっています。小さくて灰色の三角形がsRGBの色域で、大きくて暗い三角形がdisplay-p3の色域です。2020年にWeb上で実際に使用される23色のディスプレイp3固有の色を示しています。各色のペアについて、大きな円がsRGBの色域、小さな円がディスプレイp3の色域です。sRGBの色域内であれば、これらの円が正しい色を示しています。そうでない場合は、白い丸に赤い縁がついているものがsRGB域外の色を示しています。",
  width=600,
  height=600
) }}

sRGBとdisplay-p3では紫がかった色が似ていますが、これはおそらくどちらの色空間も同じ青の原色を使っているからでしょう。赤、オレンジ、黄色、緑の色は、sRGBの色域境界付近（ほぼ飽和状態）にあり、display-p3の色域境界付近の類似点にマッピングされています。

ウェブが未だにsRGBの地に囚われている理由は2つあるようです。1つ目はツールの不足、良いカラーピッカーの不足、もっと鮮やかな色があることへの理解不足です。しかし、私たちが考える大きな理由は、現在までにsRGBを実装しているブラウザはSafariだけだということです。これは急速に変化していて、ChromeもFirefoxも現在実装していますが、そのサポートが出荷されるまではおそらくdisplay-p3を使用するのは、<a hreflang="en" href="https://gs.statcounter.com/browser-market-share">閲覧者の17%しか見ない</a>ので、あまりにも少ない利益のために努力しすぎているのではないでしょうか。ほとんどの人はフォールバックを見るでしょう。だから現在の使用法は、大きな違いというよりは、色の鮮やかさの微妙なシフトです。

display-p3カラー（他にもオプションはあるが、野生で見つけたのはこれだけ）の使い方が今後1、2年でどのように変化していくのかを見てみるのも面白いだろう。

なぜなら、*wide color gamut* (WCG)は始まりに過ぎないからです。テレビや映画業界では、すでにP3を超えて、さらに広い色域へと移行しています[*Rec.2020*](https://en.wikipedia.org/wiki/Rec._2020)。*ハイダイナミックレンジ* (HDR)は、特にゲームやストリーミングテレビ、映画などの家庭ではすでに登場しています。ウェブ上では、まだまだ追いつけない部分があります。

## グラデーション

ミニマリズムとフラットデザインが流行しているにもかかわらず、CSSのグラデーションは75%のページで使用されています。予想通り、ほぼすべてのグラデーションが背景で使用されています。74.45%のページでは背景にグラデーションを指定していますが、その他のプロパティで指定しているのはわずか7%です。

線形グラデーションは放射状グラデーションの5倍の人気があり、ほぼ73%のページに表示されているのに対し、放射状グラデーションは15%です。この人気の差は驚異的で、これまで必要とされていなかった`-ms-linear-gradient()`でさえも、`radial-gradient()`よりも人気があるのです（Internet Explorer 10は`-ms-`接頭辞を付けても付けなくてもグラデーションをサポートしていました）。<a hreflang="en" href="https://caniuse.com/css-conic-gradients">新しくサポートされた</a>の`conic-gradient()`はさらに利用率が低く、デスクトップページでは652ページ(0.01%)、モバイルページでは848ページ(0.01%)にしか表示されていません。

すべてのタイプの繰り返しグラデーションの利用率もかなり低く、`repeating-linear-gradient()`が登場するページはわずか3%に過ぎず、他のタイプのグラデーションの利用率はさらに低くなっています（`repeating-conic-gradient()`は21ページでしか利用されていません！）。

接頭辞付きグラデーションも、2013年以降、グラデーションに接頭辞が必要とされなくなったにもかかわらず、いまだに非常によく使われています。注目すべきは、-webkit-gradient()が<a hreflang="en" href="https://caniuse.com/css-gradients">2011年以降必要とされなくなった</a>にもかかわらず、すべてのウェブサイトの半数でいまだに使用されていることです。また、`-webkit-linear-gradient()`はグラデーション関数の中で2番目によく使われており、57%のウェブサイトで使われています。

{{ figure_markup(
  image="gradient-functions.png",
  caption="ページのパーセンテージとして最も人気のあるグラデーション機能です。",
  description="デスクトップページとモバイルページの割合で最も人気のあるグラデーション機能を示す棒グラフ。グラデーション関数はモバイルページで人気が高い傾向にあります。最も人気のあるグラデーション関数は`linear-gradient`で、モバイルページの73%で使用されています。次いで、`-webkit-linear-gradient`が57%、`-webkit-gradient`と`linear-gradient`が50%、`-moz-linear-gradient`が49%、`-ms-linear-gradient`が33%、`radial-gradient`が15%、`-webkit-radial-gradient`が9%、そして、`repeating-linear-gradient`と`-moz-radial-gradient`がモバイルページの3%で使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1552177796&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

{{ figure_markup(
  image="gradient-functions-unprefixed.png",
  caption="最も人気のあるグラデーションは、ベンダーの接頭辞を省略して、ページのパーセンテージとして機能します。",
  description="ベンダーの接頭辞を省略して、デスクトップとモバイルページに占める最も人気のあるグラデーション機能の割合を示す棒グラフ。デスクトップの採用率はモバイルにわずかに遅れている。モバイルページでは、`linear-gradient`のバリエーションが72.57%、`radial-gradient`が15.13%、`repeating-linear-gradient`が2.99%、`repeating-radial-gradient`が0.07%、`conic-gradient`が0.01%、`repeating-conic-gradient`が約0.00%で使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1676879657&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

異なる色を同じ位置に配置したカラーストップ（ハードストップ）を使用してストライプやその他のパターンを作成することは、<a hreflang="en" href="https://lea.verou.me/2010/12/checkered-stripes-other-background-patterns-with-css3-gradients/">2010年にLea Verouによって初めて普及した</a>テクニックで、現在では<a hreflang="en" href="https://bennettfeely.com/gradients/">ブレンドモードを備えた本当にクールなもの</a>など、多くの興味深いバリエーションがあります。ハックのように見えるかもしれませんが、ハードストップはページの50%に見られ、画像エディターや外部のSVGに頼らずにCSS内で軽量なグラフィックを作成したいという開発者の強いニーズがあることを示しています。

 補間ヒント（または、この技術を普及させたAdobeが「中間点」と呼ぶ）は、<a hreflang="en" href="https://caniuse.com/mdn-css_types_image_gradient_linear-gradient_interpolation_hints">2015年以降、ほぼ万国共通のブラウザのサポート</a> にもかかわらず、ページの22%にしか見られません。これは残念なことです。これがないと、カラーストップは滑らかな曲線ではなく、色空間の直線で結ばれてしまうからです。この使用率の低さは、それらが何をするのか、あるいはどのように使うのかについての誤解を反映していると思われます。これとは対照的に、CSSトランジションやアニメーションと比較すると、イージング関数（キーフレームをジャラジャラした直線ではなく曲線で接続するなど、ほとんど同じことをする）の方がはるかに一般的に使用されています（[トランジションの80％](#transitions-and-animations)）。"Midpoints"というのはあまりわかりやすい記述ではありませんし、"interpolation hint"というのは、ブラウザが簡単な算術をするのを手伝っているように聞こえます。

ほとんどのグラデーションの使用法は単純で、データセット全体の75%以上のグラデーションが2色のストップを使用しているだけです。実際、半分以下のページでは、3色以上のカラーストップを使ったグラデーションが1つでも含まれています。

一番色が止まっているグラデーションは<a hreflang="en" href="https://dabblet.com/gist/4d1637d78c71ef2d8d37952fc6e90ff5">こちら</a>で646色！　可愛いですね。これはほぼ確実に生成されたもので、結果として得られるCSSコードは8KBなので、1pxの高さのPNGであればフットプリントが小さくても問題ないでしょう（下の画像は1.1KBです）。

{{ figure_markup(
  image="gradient-most-stops.png",
  classes="height-16vw-122px",
  caption="最も色が止まっているグラデーション、646。",
  description="色相の異なる複雑な多色のストライプが連続している、最も色が止まっているグラデーションのスクリーンショット。",
  width=600,
  height=122
) }}

## レイアウト

CSSには現在、レイアウトオプションが多数用意されており、テーブルをレイアウトに使用しなければならなかったテーブルとは一線を画しています。Flexbox、Grid、Multiple-columnレイアウトはほとんどのブラウザでサポートされています。

### Flexboxとグリッドの採用

[2019年版](../2019/css#flexbox)では、モバイルとデスクトップをまたいだページの41%が[Flexbox](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox)のプロパティを含むと報告されていました。2020年には、この数字はモバイルで63%、デスクトップで65%にまで拡大しています。Flexboxが実行可能なツールとなる前に開発されたレガシーサイトの数がまだ存在していることから、このレイアウト方法は広く採用されていると言えるでしょう。

[グリッドレイアウト](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Grid_Layout)を見てみると、グリッドレイアウトを利用しているサイトの割合は、モバイルでは4％、デスクトップでは5％にまで伸びています。昨年から倍増していますが、フレックスレイアウトにはまだ大きく遅れをとっています。

{{ figure_markup(
  image="flexbox-grid-mobile.png",
  caption="年ごとのFlexboxとグリッドの採用率をモバイルページの割合で表示しています。",
  description="モバイルページに占めるFlexboxとGridの採用率を年別に示した棒グラフ。Flexboxの採用率は2019年から2020年にかけて、モバイルページの41%から63%へと成長しました。Gridの採用率は同期間に2%から4%へと成長しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1879364309&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="flexbox-grid-desktop.png",
  caption="年ごとのflexboxとグリッドの採用率をデスクトップページの割合で示す。",
  description="flexboxとグリッドの採用率をデスクトップページに占める割合として年別に示した棒グラフ。フレックスボックスの採用率は、2019年から2020年にかけて、モバイルページの41%から65%へと成長しました。グリッドの採用率は同期間に2%から5%に成長した。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1140202160&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

この章の他のほとんどのメトリクスとは異なり、これは実際に測定されたグリッドの使用状況であり、スタイルシートで指定されていて使用されない可能性のあるグリッド関連のプロパティや値だけではないことに注意してください。一見するとこれがより正確に見えるかもしれませんが、心に留めておくべきことは、HTTP Archiveはホームページをクロールしているため、グリッドが内部ページに多く出現することが多いため、このデータはより低く偏っているかもしれないということです。

スタイルシートで`display: grid`と`display: flex`を指定しているページがどれだけあるか？　この指標ではグリッドレイアウトの採用率が著しく高く、30%のページが`display: grid`を一度は使用しています。しかし、Flexboxの採用率にはそれほど大きな影響はなく、68%のページが`display: flex`を指定しています。これはFlexboxの採用率が非常に高いように聞こえますが、80%のページでテーブル表示モードを使用しているCSSテーブルの方がはるかに人気があることは注目に値します。この使用法のいくつかは、<a hreflang="en" href="https://css-tricks.com/snippets/css/clear-fix/">ある種のclearfix</a>が`display: table`を使用していることに起因するもので、実際のレイアウトではありません。

{{ figure_markup(
  image="layout-methods.png",
  caption="レイアウトモードと、それらが表示されるページの割合。このデータは`display`,`position`,`float`プロパティの値を組み合わせたものです。",
  description="デスクトップとモバイルのページに占めるレイアウト手法の採用率を示す棒グラフ。特に断りのない限り、デスクトップとモバイルの結果は似ています。レイアウト方法のトップ4は、ブロック、アブソリュート、フロート、インラインブロックで、それぞれ92％、92％、91％、90％の採用率となっています。それに続いて、インラインテーブル、固定テーブル、CSSテーブルがそれぞれ81％、80％、80％の採用率となっています。フレックスは68％の採用率を持ち、ボックスが46％で続き、デスクトップの採用率が38％、インラインフレックスが33％、グリッドが30％、リストアイテムが26％、インラインテーブルが26％、インラインボックスが20％、スティッキーが13％でモバイルページの採用率よりも明らかに大きくなってます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013998073&format=interactive",
  width="600",
  height="588",
  sheets_gid="335708969",
  sql_file="layout_properties.sql"
) }}

グリッドレイアウトよりも前のブラウザではFlexboxが使用可能であったことを考えると、グリッドシステムを設定するためにFlexboxを使用している可能性があります。グリッドとしてFlexboxを使うためには、Flexboxの固有の柔軟性の一部を無効にする必要があります。そのためには、`flex-grow`プロパティを`0`に設定し、パーセンテージを使ってフレックスアイテムのサイズを設定します。この情報を使って、デスクトップとモバイルの両方で19%のサイトがこのグリッドのような方法でFlexboxを使用していることを報告することができました。

GridではなくFlexboxを選択した理由は、Gridレイアウトが<a hreflang="en" href="https://caniuse.com/css-grid">Internet Explorerではサポートされていなかった</a>ことを考えると、ブラウザのサポートがよく挙げられます。さらに、著者の中にはまだグリッドレイアウトを学んでいなかったり、Flexboxベースのグリッドシステムを使っているフレームワークを使っている人もいるでしょう。<a hreflang="en" href="https://getbootstrap.com/docs/4.5/layout/grid/">Bootstrap</a>フレームワークは現在Flexboxベースのグリッドを使用しており、他のいくつかの一般的なフレームワークの選択肢と共通しています。

### 異なるグリッドレイアウト技術の使用法

グリッド・レイアウト仕様では、CSSでレイアウトを記述し定義するための多くの方法を提供しています。最も基本的な使い方は、<a hreflang="en" href="https://www.smashingmagazine.com/2020/01/understanding-css-grid-lines/">あるグリッド線から別のグリッド線へ</a> のように項目をレイアウトすることです。[名前付き行](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Grid_Layout/Layout_using_Named_Grid_Lines)や`grid-template-areas`の使用はどうでしょうか？

名前付きの行については、トラックリストの中に角括弧があるかどうかをチェックしました。角括弧の内側に配置されている名前または名前。

```css
.wrapper {
  display: grid;
  grid-template-columns: [main-start] 1fr [content-start] 1fr [content-end] 1fr [main-end];
}
```

その結果、モバイルではグリッドを利用しているページの0.23％が名前付きラインを持っていたのに対し、デスクトップでは0.27％という結果が出ました。

[グリッドテンプレートエリア](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Grid_Template_Areas)の機能は、グリッドアイテムに名前を付け、`grid-template-areas`プロパティの値としてグリッド上に配置することを可能にするもので、少し良い結果が得られました。グリッドを使用しているサイトのうち、モバイルでは19%、デスクトップでは20%がこの方法を使用していました。

これらの結果から、グリッドレイアウトの使用率は、プロダクションウェブサイトではまだ比較的低いだけでなく、その使用方法も比較的シンプルであることがわかります。著者は、行や領域に名前を付けられるような方法よりも、シンプルなラインベースの配置を選択しています。そうすることは何も悪いことではありませんが、グリッドレイアウトの採用が遅れているのは、作者がまだこの機能の威力を理解していないことが一因なのではないでしょうか。もしグリッドレイアウトがブラウザのサポートが不十分で本質的にFlexboxとみなされているとしたら、それは確かに説得力のある選択ではないでしょう。

### 複数カラムレイアウト

[マルチカラムレイアウト](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Columns/Basic_Concepts_of_Multicol)、または*multicol*とは、新聞のようにコンテンツを列に並べることができる仕様のことです。印刷用のCSSではよく使われていますが、Web上では読者がコンテンツを読むために上下にスクロールしなければならないような状況が発生するリスクがあるため、あまり有用ではありません。しかし、データによると、デスクトップでは15.33%、モバイルでは14.95%と、グリッドレイアウトよりもmulticolを使用しているページがかなり多くなっています。基本的なmulticolプロパティは十分にサポートされていますが、より複雑な使い方や<a hreflang="en" href="https://www.smashingmagazine.com/2019/02/css-fragmentation/">断片化</a>での改行制御は<a hreflang="en" href="https://caniuse.com/multicolumn">ざっくばらんなサポート</a>となっています。このようなことを考えると、これだけの使用法があるというのはかなり驚きでした。

### ボックスのサイジング

ページ上のボックスの大きさを知っておくと便利ですが、[標準のCSSボックスモデル](https://developer.mozilla.org/ja/docs/Learn/CSS/Building_blocks/The_box_model#what_is_the_css_box_model)では、コンテンツボックスのサイズにpaddingとborderを追加しているため、ボックスに与えたサイズはページ上でレンダリングされるボックスよりも小さくなってしまいます。履歴を変更することはできませんが、`box-sizing`プロパティで指定したサイズを`border-box`に適用するように切り替えることができるので、設定したサイズがレンダリングされるサイズになります。どのくらいのサイトが`box-sizing`プロパティを使っているのでしょうか？ほとんどのサイトが使っています。box-sizing`プロパティは、デスクトップCSSの83.79%、モバイルでは86.39%のサイトで利用されています。

{{ figure_markup(
  image="box-sizing.png",
  caption="1ページあたりの`border-box`宣言の数の分布。",
  description="1ページあたりの`box-sizing`宣言数の分布をデスクトップとモバイルで示した棒グラフ。モバイルの分布は、1ページあたりの宣言数が0～11でデスクトップをリードしており、高いパーセンタイルになるほど増加しています。モバイルの分布の10、25、50、75、90パーセントは以下の通りです。1ページあたりの`border-box`宣言数は0、4、17、46、96です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1626960751&format=interactive",
  sheets_gid="1982524793",
  sql_file="box_sizing.sql"
) }}

デスクトップページの中央値には14件の`box-sizing`宣言があります。モバイルページには17個あります。おそらく、スタイルシート内のすべての要素に対してグローバルなルールとしてではなく、コンポーネントシステムがコンポーネントごとに宣言を挿入しているためでしょう。

## トランジションとアニメーション

トランジションとアニメーションは全体的に非常に人気があり、`transition`プロパティは全ページの81%で、`animation`プロパティはモバイルページの73%、デスクトップページの70%で使用されている。モバイルページでは、<a hreflang="en" href="https://css-tricks.com/how-web-content-can-affect-power-usage/">バッテリーの節約</a>を優先しているはずなのに、モバイルページでの使用率が低くないのはやや驚きです。一方で、JSアニメーションよりもCSSアニメーションの方がはるかにバッテリー効率が良く、特に変形と不透明度をアニメーションさせるだけのものが大半を占めています（次項参照）。

最も一般的に指定されている遷移プロパティは`all`で、41%のページで使用されています。`all`は初期値なので、実際には明示的に指定する必要がないので、これは少し不可解です。次いで、フェードイン/フェードアウトのトランジションが最も一般的なタイプで、クロールされたページの3分の1以上で使用されており、`transform`プロパティのトランジション（スピン、スケール、動きのトランジションが多い）が続いている。驚くべきことに、`height`のトランジションは`max-height`のトランジションよりもはるかに人気がありますが、後者は開始または終了の高さが不明な場合の回避策として一般的に教えられています（自動）。また、`scale`プロパティはFirefox以外ではサポートされていないにもかかわらず、かなりの使用率があることも驚きでした(2%)。最先端のCSSを意図的に使っているのか、タイプミスなのか、それとも変形をアニメーションさせる方法についての誤解なのか。

{{ figure_markup(
  image="transition-properties.png",
  caption="ページの割合としてトランジションプロパティを採用しています。",
  description="最も人気のある遷移プロパティの採用状況を示す棒グラフ。デスクトップページとモバイルページは、フィルタがデスクトップではほとんど使用されていないことを除いて、非常によく似ています。モバイルページで最もよく使われているトランジションプロパティは`all`で、41%のページで使用されており、次いで`opacity`が37%、`transform`が26%、`color`が17%、`none`が15%、`height`が13%、`background-color`が12%、`background`が10%、`filter`が7%で、残りのプロパティはモバイルページの6%で使用されています。残りのプロパティは、`width`、`left`、`top`、`webkit-transform`、`box-shadow`、`border-color`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1677028861&format=interactive",
  sheets_gid="134272305",
  sql_file="transition_properties.sql"
) }}

嬉しいことに、これらのトランジションのほとんどはかなり短く、トランジションの持続時間の中央値はわずか300msで、90%のWebサイトの持続時間の中央値は半秒以下であることがわかりました。トランジションが長いとUIが重く感じてしまいますが、短いトランジションは邪魔にならず変化を伝えることができるので、これは一般的に良い方法です。

{{ figure_markup(
  image="transition-durations.png",
  caption="移行期間の分布。",
  description="デスクトップページとモバイルページの遷移時間のミリ秒単位での分布を示す棒グラフ。デスクトップとモバイルは、10％、25％、90％では、それぞれ100、150、500msの持続時間で同等であるが、中央値と75％では、デスクトップの方が50ms高い。また、デスクトップとモバイルは、それぞれ100、150、500msと同等であるが、中央値と75%では、デスクトップの方が50ms、300、400msと高い持続時間を持っている。それぞれ300ミリ秒と400ミリ秒です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1587838983&format=interactive",
  sheets_gid="286912288",
  sql_file="transition_durations.sql"
) }}

仕様書の作者はそれを正しく理解している！　`Ease`は最もよく使われるタイミング関数であるが、それはデフォルトであるため、実際には省略することも可能です。おそらくデフォルトを明示的に指定するのは自己文書化された冗長性を好むからなのか、あるいは、おそらくもっとありそうなことだが、デフォルトであることを知らないからなのか、どちらかだろう。直線的にアニメーションを進行させるという欠点があるにもかかわらず、`linear`は19.1%と、2番目に多く使われているタイミング関数です。また、組み込みのイージング関数がすべての遷移の87%以上に対応していることも興味深い。

{{ figure_markup(
  image="transition-timing-functions.png",
  caption="タイミング機能の相対的な人気度は、モバイルページでの出現率として示されています。",
  description="円グラフは、モバイルページでのタイミング関数の相対的な人気度を示したものです。最も人気のあるタイミング関数は`ease`で31％、次いで`linear`が19％、`ease-in-out`が19％、`cubic-bezier`が13％、`ease-out`が9％、`steps`が5％、`ease-in`が4％となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=63879013&format=interactive",
  sheets_gid="1514240349",
  sql_file="transition_timing_functions.sql"
) }}

アニメーションを採用した主な要因は、Font Awesomeであると考えられています。アニメーション名には様々な種類がありますが、その多くは基本的なカテゴリーに分類されているようで、5つに1つは「スピン」のようなものが含まれています。滑らかな永久回転を求めるのであれば、「直線的な」トランジションやアニメーションの割合が高いのもそのためかもしれません。

{{ figure_markup(
  image="transition-animation-names.png",
  caption="使用されているアニメ名のカテゴリの相対的な人気度を、出現率として表示しています。",
  description="アニメーション名のカテゴリの相対的な人気度を、出現回数に占める割合で示した棒グラフです。最も人気のあるカテゴリは`rotate`で、モバイルページでの出現率は21％で、次いで`unknown/other`が13％、`fade`が9％、`bounce`が7％、`scale`が6％、`wobble`と`slide`が5％、`pulse`が2％、残りの1％が`visibillity`、`flip`、`move`である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=709747830&format=interactive",
  sheets_gid="1998209374",
  sql_file="transition_animation_names.sql"
) }}

## 視覚効果

CSSはまた、デザイナーに少量のコードでアクセスできるブラウザに組み込まれた高度なデザイン技術へのアクセスを可能にする、非常に多様な視覚効果を提供しています。

### ブレンドモード

昨年は、8%のページでブレンドモードを使用していました。今年は採用率が大幅に上昇し、13%のページで要素にブレンドモードを使用しており(`mix-blend-mode`)、2%のページで背景にブレンドモードを使用しています(`background-blend-mode`)。

### フィルター

フィルターの採用率は依然として高く、`filter`プロパティは79.43%のページに登場しています。最初これは非常に刺激的でしたが、その多くは同じプロパティ名を共有していた古い[IE DX filters](https://developer.mozilla.org/en-US/docs/Archive/Web/CSS/-ms-filter)である可能性が高いです。Blinkが認識する有効なCSSフィルターのみを考慮した場合、使用率はモバイルで22%、デスクトップで20%にまで低下し、`blur()`が最も人気のあるフィルタタイプで、4%のページに表示されています。

これは、半透明の背景のコントラストを改善したり、多くのネイティブUIでおなじみのエレガントな<a hreflang="en" href="https://css-tricks.com/backdrop-filter-effect-with-css/">"すりガラス"効果</a>を作り出すのに非常に便利です。`フィルター`ほど人気があるわけではありませんが、ページの6%で`backdrop-filter`が見つかりました。

`filter()`関数を使うと、特定の画像にのみフィルタを適用することができ、背景に非常に便利です。残念ながら、これは<a hreflang="en" href="https://caniuse.com/css-filter-function">現在のところSafariでのみサポートされている</a>。`filter()`の使用法は見つからなかった。

### マスク

10年前、Safariで`-webkit-mask-image`でマスクを取得して盛り上がっていました。みんなとその犬が使っていました。最終的には <a hreflang="en" href="https://www.w3.org/TR/css-masking-1/">仕様</a> と、WebKitプロトタイプに近いモデルの接頭辞なしプロパティのセットを手に入れることができ、マスクが標準化され、すべてのブラウザで一貫した構文を持つようになるのは時間の問題だと思われました。10年後の今、接頭辞なしの構文は<a hreflang="en" href="https://caniuse.com/css-masks">ChromeやSafariではまだサポートされておらず、世界の5%以下のユーザーのブラウザで利用できることを意味します</a>。したがって、`webkit-mask-image`が標準のものよりもまだ人気があり、22%のページで見つかっているのも不思議ではありません。しかし、サポートが非常に悪いにもかかわらず、`mask-image`は19%のページで見つかりました。他のほとんどのマスキングプロパティでも同様のパターンが見られ、接頭辞なしのバージョンは`webkit-`とほぼ同じくらいの数のページに表示されています。全体的に見ると、マスクは誇大広告から外れているにもかかわらず、ウェブの4分の1近くでまだ見つかっており、実装者の関心が低いにもかかわらず、ユースケースがまだ存在していることを示しています（ヒント、ヒント！）。

{{ figure_markup(
  image="mask-properties.png",
  caption="マスクのプロパティの相対的な人気度を出現率で表す。",
  description="マスクプロパティの相対的な人気度を出現率で示したものです。モバイルページでは`webkit-mask-image`が22%で使用されており、デスクトップページでは19%であったのに対し、モバイルページでは22%で使用されている。以下、`mask-size`と`mask-image`が19%、`mask-repeat`、`mask-position`、`mask-mode`、`-webkit-mask-size`が18%、`-webkit-mask-repeat`と`-webkit-mask-position`が16%、`-webkit-mask`と`mask`プロパティが2%となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=615866471&format=interactive",
  width="600",
  height="575",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

### クリッピングパス

マスクが人気になったのと同じ頃、似たような、しかしよりシンプルなプロパティ（元々はSVGのもの）が登場し始めました。それは`clip-path`です。しかし、マスクとは異なり、このプロパティには明るい運命がありました。このプロパティはかなり早く標準化され、比較的早くボード全体でサポートされるようになりましたが、最後に残ったのは2016年にプレフィックスを削除したSafariでした。今日では、接頭辞なしのページの19%、接頭辞`-webkit-`のページの13%で見られるようになりました。

## レスポンシブデザイン

FlexboxやGridのような柔軟で応答性の高い新しいレイアウト手法が組み込まれていることで、ウェブを閲覧する多くの異なる画面サイズやデバイスに対応できるサイトを作ることが幾分容易になりました。これらのレイアウト方法は、通常、メディアクエリを使用することでさらに強化されています。データによると、デスクトップサイトの80％、モバイルサイトの83％が、`min-width`のようなレスポンシブデザインに関連したメディアクエリを使用していることがわかります。

### 人々はどのメディア機能を利用しているのか？

ご想像の通り、最も一般的に使用されているメディア機能は、レスポンシブウェブデザインの初期の頃から使用されているビューポートサイズ機能です。`max-width`をチェックしているサイトの割合は、デスクトップとモバイルの両方で78%です。モバイルサイトの75％、デスクトップサイトの73％で`min-width`機能をチェックしています。

画面が縦か横かに基づいてレイアウトを差別化できる`orientation`メディア機能は、全サイトの33%のサイトで利用されています。

統計の中で、いくつかの新しいメディア機能が出てきています。<a hreflang="en" href="https://web.dev/prefers-reduced-motion/">`prefers-reduced-motion`</a>メディア機能は、ユーザーがモーションの縮小を要求したかどうかをチェックする方法を提供します。この機能は、ユーザーが制御するオペレーティングシステムの設定で明示的にオンにすることもできますし、バッテリー残量が減っているなどの理由で暗黙的にオンにすることもできます。24%のサイトがこの機能をチェックしています。

その他の良いニュースとしては、<a hreflang="en" href="https://www.w3.org/TR/mediaqueries-4/">Media Queries Level 4</a>仕様の新機能が登場し始めています。モバイルでは、5%のサイトがユーザーが持っているポインターの種類をチェックしています。`coarse`ポインターはタッチスクリーンを使用していることを示し、`fine`ポインターはポインティングデバイスを示しています。ユーザーがどのようにサイトを操作しているのかを理解することは、画面サイズを見るよりも役立つことが多いですが、それ以上に役立つこともあります。人は、キーボードとマウスを使用して小さな画面のデバイスを使用しているかもしれませんし、タッチスクリーンを使用して高解像度の大画面デバイスを使用しているかもしれませんし、より大きなヒットエリアの恩恵を受けているかもしれません。

{{ figure_markup(
  image="media-query-features.png",
  caption="最も人気のあるメディアクエリの特徴は、ページのパーセンテージです。",
  description="最も人気のあるメディアクエリ機能をページ数に占める割合で示した棒グラフ。特に断りのない限り、デスクトップとモバイルは大体似たようなものです。モバイルページで最も人気のあるメディアクエリ機能は`max-width`で79％、次いで`min-width`が75％、`-webkit-min-device-pixel-ratio`が45％（デスクトップの39％から上昇）、オリエンテーションが33％、`max-device-width`が28％、`-ms-high-contrast`が24％（デスクトップの15％から上昇）、`prefers-reduced-motion`が24％となっています。`max-height`と`min-resolution`が22%、`webkit-transform-3d`、`transform-3d`、`min-device-pixel-ratio`がすべて15%、`min-height`はモバイルページの14%で使用されていますが、デスクトップページの3%にしか使用されていません、`o-min-device-pixel-ratio`が8%、`pointer`が5%、最後に`device-width`が2%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1998463556&format=interactive",
  sheets_gid="1374950017",
  width="600",
  height="600",
  sql_file="media_query_features.sql"
) }}

### 一般的なブレークポイント

デスクトップとモバイルデバイスで使用されている最も一般的なブレークポイントは768pxの`min-width`です。54%のサイトがこのブレークポイントを使用しており、次いで`max-width`の767pxが50%と密接に続いています。<a hreflang="en" href="https://getbootstrap.com/docs/4.1/layout/overview/">Bootstrap framework</a>は768pxの最小幅を「Medium」のサイズとして使用しているので、これが多くの使用量の源になっているのかもしれません。他にも、1200px(40%)と992px(37%)という2つのよく使われる`min-width`値もBootstrapにはあります。

{{ figure_markup(
  image="breakpoints.png",
  caption="モバイルページに占める割合として、`min-width`と`max-width`による最も人気のあるブレークポイントを示します。",
  description="モバイルページに占める`min-width`と`max-width`の割合で最も人気のあるブレークポイントを示します。モバイルページのうち、最小幅として使われているのは21%、最大幅として使われているのは35%で、`480px`が使われています。600pxは最小幅が27%と最大幅が37%で、`767px`は8%と50%で、`768px`は54%と35%で、`800px`は8%と24%である。`991px`は3%と30% 、`992px`は37%と11%、`1024px`は13%と23% 、`1199px`は31%、`1200px`は40%と19%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=502128948&format=interactive",
  sheets_gid="1070028321",
  sql_file="media_query_values.sql"
) }}

ピクセルはブレークポイントに使用される単位です。`em`はリストの中ではかなり下の方にありますが、ピクセルでブレークポイントを設定するのが一般的な選択のようです。これには多くの理由があると思われます。レガシー: レスポンシブデザインに関する初期の記事はすべてピクセルを使用しており、多くの人がレスポンシブデザインを作成する際に特定のデバイスをターゲットにすることを今でも考えています。サイジング。これはウェブデザインについての新しい考え方で、おそらくレイアウトのための本質的なサイジング方法とともに、まだ十分に活用されていないものです。

### メディアクエリ内で使用されるプロパティ

モバイルデバイスでは79%、デスクトップでは77%のメディアクエリが`display`プロパティを変更するために使用されています。おそらく、人々はFlexやグリッドフォーマットのコンテキストへ切り替える前にテストをしていることを示しています。繰り返しになりますが、これはリンクされたフレームワーク、例えば<a hreflang="en" href="https://getbootstrap.com/docs/4.1/utilities/display/">Bootstrap responsive utilities</a>のようなものかもしれません。78%の作者がメディアクエリの内部で`width`プロパティを変更しており、`margin`、`padding`、および`font-size`はすべて変更されたプロパティの上位にランクされています。

{{ figure_markup(
  image="media-query-properties.png",
  caption="メディアクエリで使用されている最も人気のあるプロパティをページのパーセンテージで表示しています。",
  description="メディアクエリで使用されている最も人気のあるプロパティをページの割合で表した棒グラフ。デスクトップとモバイルは非常によく似ています。モバイルページの割合は、`display`、`width`、`margin-left`、`padding`、`font-size`、`height`、`margin`、`margin-right`、`margin-top`、および`position`の順で79%から71%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1199544976&format=interactive",
  sheets_gid="190367365",
  sql_file="media_query_properties.sql"
) }}

## カスタムプロパティ

昨年、カスタムプロパティを採用しているウェブサイトはわずか5%でした。今年は採用率が急上昇しています。昨年のクエリ（カスタムプロパティを設定する宣言のみをカウントしていた）を使用すると、モバイルでは4倍（19.29％）、デスクトップでは3倍（14.47％）になりました。しかし、`var()`を介してカスタムプロパティを参照している値を見ると、さらに良い結果が得られます。モバイルページの27％、デスクトップページの22％が、少なくとも一度は`var()`関数を使用していました。

一見すると、これは印象的な採用率ですが、WordPressが主な推進力となっているように見えます。

### ネーミング

{{ figure_markup(
  image="custom-property-names.png",
  caption="ソフトウェアエンティティごとのカスタムプロパティ名の相対的な人気度を、モバイルページでの出現率として示しています。",
  description="カスタム プロパティ名の相対的な人気度を、プロパティの作成を担当したソフトウェアのエンティティごとに、モバイル ページでの出現率として円グラフで示しています。モバイルページでのカスタムプロパティ名の発生の35%はAvada、31%はBootstrap、16%はElementor、13%はWordPress、3%は古いバージョンのMultirangeにまで遡ることができます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1627287194&format=interactive",
  sheets_gid="1043074687",
  sql_file="custom_property_names.sql"
) }}

上位1,000件のプロパティ名のうち、個人のウェブ開発者によって作られた「カスタム」は13件にも満たない。その大半は、WordPress、Elementor、Avadaなどの人気のあるソフトウェアに関連したものです。これを判断するために、どのカスタムプロパティがどのソフトウェアに登場するのか（GitHubでの検索）だけでなく、どのプロパティが似たような頻度でグループに登場するのかを考慮しました。これは、カスタムプロパティがウェブサイト上で使われる主な方法がそのソフトウェアの使用によるものだということを必ずしも意味するものではありません（人々は今でもコピー＆ペーストをしています！）が、開発者が定義したカスタムプロパティ間にはあまり有機的な共通点がないことを示しています。トップ1000のリストに有機的に入っていると思われるカスタムプロパティの名前は、`--height`、`--primary-color`、そして`--caption-color`だけです。

### タイプ別利用法

カスタムプロパティの最大の使用法は、色の命名と、全体的に一貫した色を維持することであるようです。デスクトップページの約5人に1人、モバイルページの約6人に1人が`background-color`でカスタムプロパティを使用しており、`var()`参照を含む上位11のプロパティは、カラープロパティか、色を含む略語のいずれかです。長さは2番目に大きく、`width`と`height`が`var()`と一緒に使われているのはモバイルページの7%です（興味深いことに、デスクトップページでは3%程度しか使われていない）。このことは、最も人気のある値の型でも確認されており、カスタムプロパティ宣言の52%をカラー値が占めています。寸法（数値＋単位（長さ、角度、時間など））は、2番目に人気のあるタイプで、単位のない数値（12%）よりも高くなっています。なぜなら、数値は`calc()`と乗算で次元に変換できますが、次元での除算はまだサポートされていないため、次元を数値に変換することはできません。

{{ figure_markup(
  image="custom-property-properties.png",
  caption="カスタムプロパティで使用されているプロパティ名をページのパーセンテージとして最もよく使用されています。",
  description="カスタムプロパティで使用されている最も人気のあるプロパティ名を、ページに占める割合で示した棒グラフ。モバイルでは、各プロパティの採用率がデスクトップよりもはるかに高くなっています。カスタムプロパティが使用されているのは、`background-color`が19%、`color`が15%で、モバイルページのうち、`background-color`が19%、`color`が15%です。残りのプロパティでは、9%から6%の間でカスタムプロパティが使用されています。`border`,`background`,`border-top`,`border-bottom`,`background-image`,`box-shadow`,`height`,`width`,`border-left`,`min-height`,`margin-top`,`border-right`,`border-left-color`です。デスクトップの採用率は約4%ポイント低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=16420165&format=interactive",
  sheets_gid="556945658",
  sql_file="custom_property_properties.sql"
) }}

プリプロセッサでは、色変数を操作して、異なる色合いなどの色のバリエーションを生成することがよくあります。しかし、CSSでは<a hreflang="en" href="https://drafts.csswg.org/css-color-5/">色変更関数</a>は未実装の草案に過ぎません。今のところ、変数から新しい色を生成する唯一の方法は、個々のコンポーネントに変数を使用し、`rgba()`や`hsla()`のようなカラー関数にプラグインすることです。しかしモバイルページの4%未満、デスクトップページの0.6%未満がこれを行っており、カラー変数の使用率が高いのは主に色全体を保持するためであり動的に生成されるのではなく、そのバリエーションを別の変数にしていることを示しています。

{{ figure_markup(
  image="custom-property-functions.png",
  caption="カスタムプロパティで使用される最も一般的な関数名をページのパーセンテージで表示します。",
  description="カスタム プロパティで使用される最も一般的な関数名を、ページに占める割合で示した棒グラフ。モバイルでの採用率は、最初の6つの関数の方がはるかに高い。`calc`(7%)、`linear-gradient`、`rgba`(4%)、`radial-gradient`、`hsla`、`drop-shadow`の6つの関数です。デスクトップページとモバイルページでは、以下の関数が1%の採用率となっている。`o-linear-gradient`,`translate`,`webkit-linear-gradient`です。最後に、これらの関数はデスクトップやモバイルページでの採用率は約0%です。`scale`、`webkit-gradient`、`max`、`to`、`from`、`rotate`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1986770560&format=interactive",
  width="600",
  height="525",
  sheets_gid="2076074923",
  sql_file="custom_property_functions.sql"
) }}

### 複雑さ

次に、カスタムプロパティの使い方がどれだけ複雑かを見てみました。ソフトウェアエンジニアリングにおけるコードの複雑さを評価する1つの方法として、依存関係グラフの形状があります。まず、各カスタムプロパティの *depth* を調べました。例えば`#fff`のようなリテラル値に設定されたカスタムプロパティの深さは0ですが、var()を介してそれを参照するプロパティの深さは1などとなります。例えば、以下のようになります。

```css
:root {
  --base-hue: 335; /* depth = 0 */
  --base-color: hsl(var(--base-hue) 90% 50%); /* depth = 1 */
  --background: linear-gradient(var(--base-color), black); /* depth = 2 */
}
```

調査した3つのカスタムプロパティのうち2つ（67％）は深さが0で、30％は深さが1でした（モバイルではやや少なかった）。深さが2のプロパティは1.8%未満で、深さが3以上のプロパティはほとんどなく（0.7%）、かなり基本的な使い方であることを示しています。このような基本的な使い方の利点は、間違いを犯しにくいということです。

{{ figure_markup(
  image="custom-property-depth.png",
  caption="カスタムプロパティの深さの分布を出現率で表したもの。",
  description="カスタムプロパティの深さの分布を、出現率の割合で表した棒グラフです。デスクトップページとモバイルページのカスタムプロパティの深さが0の場合、それぞれ発生の67%と60%です。深度1の場合は31%と38%です。深度2では、それぞれわずか2%です。深度3以上の発生は約0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=262191540&format=interactive",
  sheets_gid="1368222498",
  sql_file="custom_property_depth.sql"
) }}

カスタム・プロパティが宣言されているセレクターを調べてみると、ほとんどのカスタム・プロパティの使用法はかなり基本的なものであることがわかります。3つのカスタムプロパティ宣言のうち2つはルート要素上で宣言されており、基本的にグローバル定数として使用されていることがわかります。多くの一般的なポリフィルでは、このようにグローバルであることが要求されているため、そのようなポリフィルを使用している開発者は選択の余地がなかったのかもしれません。

## CSSとJS

ここ数年、CSSのクラスやスタイルを単純に設定したり、オフにしたりするだけではなく、CSSとJavaScriptの相互作用が大きくなってきています。では、Houdiniのような技術やCSS-in-JSのようなテクニックをどれだけ使っているのでしょうか？

### Houdini

[Houdini](https://developer.mozilla.org/ja/docs/Web/Houdini)という言葉を聞いたことがあるかもしれません。HoudiniはCSSエンジンの一部を公開する低レベルAPIのセットで、ブラウザのレンダリングエンジンのスタイリングやレイアウトプロセスにフックすることでCSSを拡張する力を開発者に与えます。いくつかのHoudiniの仕様がブラウザで出荷されている](https://ishoudinireadyyet.com/)ので、実際に使用されているかどうかを確認する時が来たと考えました。短い答え: いいえ。そして今、長い答えのために。。。

まず、[Properties & Values API](https://developer.mozilla.org/ja/docs/Web/API/CSS/RegisterProperty)を見てみました。これは開発者がカスタムプロパティを登録して、型や初期値を与え、継承を防ぐことができるというものです。主なユースケースの1つはカスタムプロパティをアニメーションさせることができることなので、カスタムプロパティがアニメーションされる頻度も調べてみました。

最先端の技術によくあるように、特にすべてのブラウザでサポートされていない場合は、野生での採用は非常に低くなっています。登録されているカスタムプロパティがあるのはデスクトップページが32ページ、モバイルページが20ページのみでしたが、これには登録されているがクロール時には適用されていないカスタムプロパティは含まれていません。アニメーションでカスタムプロパティを使用しているのは、325のモバイルページと330のデスクトップページ（0.00%）のみで、そのほとんど（74%）は<a hreflang="en" href="https://quasar.dev/vue-components/expansion-item">Vueコンポーネント</a>によって駆動されているようです。これは、クロール時にアニメーションがアクティブになっていなかったため、スタイルを登録する必要のない計算されたスタイルが存在しなかったためと考えられます。

[Paint API](https://developer.mozilla.org/ja/docs/Web/API/CSS_Painting_API)は、より広く実装されたHoudiniの仕様で、開発者はカスタムグラデーションやパターンを実装するなど、`<image>`の値を返すカスタムCSS関数を作成することができます。12ページだけが`paint()`を使用していることがわかりました。各ワークレット名(`hexagon`,`ruler`,`lozenge`,`image-cross`,`grid`,`dashed-line`,`ripple`)はそれぞれ1ページに1つしか表示されませんでした。

<a hreflang="en" href="https://github.com/w3c/css-houdini-drafts/blob/master/css-typed-om/README.md">Typed OM</a>は、別のHoudini仕様で、古典的なCSS OMの文字列の代わりに構造化された値へのアクセスを可能にします。他のHoudini仕様に比べてかなり高い採用率を持っているようですが、全体的にはまだ低いです。デスクトップページでは9,864件（0.18%）、モバイルページ6,391件（0.1%）で使用されています。これは低いように見えるかもしれませんが、視点を変えれば、これらの数字は`<input type="date">`の採用と同じようなものです! この章のほとんどの統計とは異なり、これらの数字は実際の利用状況を反映しており、ウェブサイトの資産に含まれているだけではないことに注意してください。

### CSS-in-JS

CSS-in-JSについては、誰もが愛犬と一緒に使っていると思われるほど、多くの議論（または議論）が行われています。

{{ figure_markup(
  caption="任意のCSS-in-JS方式を使用しているサイトの割合。",
  content="2%",
  classes="big-number",
  sheets_gid="1368222498",
  sql_file="css_in_js"
)
}}

しかし、各種CSS-in-JSライブラリの利用状況を見てみると、いずれかのCSS-in-JS方式を利用しているWebサイトは2%程度で、<a hreflang="en" href="https://styled-components.com/">Styled Components</a>が半分近くを占めていることがわかりました。

{{ figure_markup(
  image="css-in-js.png",
  caption="モバイルページでのCSS-in-JSライブラリの相対的な普及率。",
  description="モバイルページでのCSS-in-JSライブラリの相対的な人気度を示す円グラフです。モバイルページでの出現率は、Styled Componentsが42%を占め、Emotionが30%、Aphroditeが9%、React JSSが8%、Glamorが7%、Styled Jsxが2%と続き、その他のライブラリは1%未満となっています。Radium、React Native for Web、Goober、Merge Styles、Styletron、Fela。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=969014374&format=interactive",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
) }}

## 国際化

英語は多くの言語と同様に、横書きで書かれ、文字は左から右に並べられています。しかし、一部の言語（アラビア語やヘブライ語など）では、ほとんどが右から左に書かれていて、上から下に向かって縦書きで書かれている場合もあります。他の言語からの引用は言うまでもありません。そのため、物事は非常に複雑になることがあります。HTMLとCSSの両方には、これを処理する方法があります。

### 方向

テキストが水平線で表示されている場合、ほとんどの筆記システムでは左から右へ文字が表示されます。ウルドゥー語、アラビア語、ヘブライ語は右から左に文字を表示しますが、数字は左から右に書かれています。括弧、引用符、句読点などの一部の文字は、左から右または右から左の文脈で使用され、方向性は中立であると言われています。異なる言語のテキスト文字列が互いに入れ子になっている場合、状況はより複雑になります。例えば、英語のテキストにヘブライ語の短い引用符が含まれていて、その中に英語の単語が含まれている場合などです。Unicodeの双方向性アルゴリズムは、方向が混在するテキストの段落をどのようにレイアウトするかを定義していますが、段落の基本方向を知る必要があります。

双方向性をサポートするために、HTMLでは<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#the-dir-attribute">`dir`属性</a>と<a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdo-element">`<bdo>`要素</a>、CSSでは<a hreflang="en" href="https://www.w3.org/TR/css-writing-modes-3/#direction">direction</a>と<a hreflang="en" href="https://www.w3.org/TR/css-writing-modes-3/#unicode-bidi">`unicode-bidi`</a>の両方のプロパティを使って方向を明示的にサポートしています。HTMLとCSSの両方のメソッドの使い方を見てみました。

モバイルページのうち、`<html>`要素に`dir`属性を設定しているのはわずか12.14%（デスクトップでは同様の10.76%）です。世界のほとんどのライティングシステムは`ltr`であり、デフォルトの`dir`の値は`ltr`です。`<html>`に`dir`を設定したページのうち、91%が`ltr`に設定し、8.5%が`rtl`に設定し、0.32%が`auto`に設定した（明示的な方向は未知の値で、主に未知の内容で埋められるテンプレートに有用です）。さらに少数の2.63%は`dir`を`<html>`よりも`<body>`に設定しています。これは良いことで、`<html>`に設定すると`<title>`のように`<head>`の中のコンテンツもカバーできるからです。

なぜCSSのスタイリングではなく、HTML属性を使って方向性を設定するのか？　理由の1つには、懸念事項の分離があります。これは、<a hreflang="en" href="https://www.w3.org/International/tutorials/bidi-xhtml/index.en">推奨されている方法</a>でもあります。<q>マークアップが使える方向性を管理するためにCSSやUnicodeのコントロールコードを使うのは避ける</q>。結局のところ、スタイルシートは読み込まれないかもしれませんし、テキストはまだ読み込まれる必要があります。

### 論理的特性と物理的特性

CSSを学ぶ際に最初に教えられるプロパティの多くは、`width`,`height`,`margin-left`,`padding-bottom`,`right`など、特定の物理的な方向性に基づいています。しかし、コンテンツを異なる指向性特性を持つ複数の言語で表示する必要がある場合、これらの物理的な方向はしばしば言語に依存します。方向性は2次元的な特性である。例えば、縦書きでコンテンツを表示する場合（伝統的な中国語のような）、`height`は`width`になる必要があるかもしれません。

過去には、これらの問題に対する唯一の解決策は、異なる記述システム用のオーバーライドを持つ別個のスタイルシートでした。しかし、最近になって、CSSは[*物理的な*プロパティと値](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Logical_Properties)を取得しました。これは *物理的な*プロパティと同じように動作しますが、コンテキストの方向性に敏感です。例えば、`width`の代わりに`inline-size`と書き、`left`の代わりに [`inset-inline`](https://developer.mozilla.org/ja/docs/Web/CSS/inset-inline)プロパティを使用できます。論理的な *property* の他に、論理的な *keywords* もあります。例えば、`float: left`の代わりに`float: inline-start`と書くこともできます。

これらのプロパティはかなり<a hreflang="en" href="https://caniuse.com/css-logical-props">よくサポートされている</a>（いくつかの例外を除いて）ですが、ユーザーエージェントスタイルシートの外ではあまり使われていません。論理プロパティは0.6%以上のページで使用されていませんでした。ほとんどの場合、余白とパディングを指定するために使用されていた。`text-align`のための論理キーワードは2.25%のページで使われていたが、それ以外のキーワードには全く出くわしていなかった。これはブラウザのサポートによるところが大きい。`text-align: start`と`end`は <a hreflang="en" href="https://caniuse.com/mdn-css_properties_text-align_flow_relative_values_start_and_end">かなり良いブラウザサポート</a> であるのに対し、`clear`と`float`の論理キーワードはFirefoxでしかサポートされていません。

## ブラウザサポート

ウェブプラットフォームの長年の問題は、新しい機能をどのように導入してプラットフォームを拡張するかということです。CSSでは、変化を導入するより良い方法として、ベンダープレフィックスからフィーチャークエリへの移行を見てきました。

### ベンダープレフィックス

{{ figure_markup(
  caption="いずれかのベンダーの接頭辞付き機能を使用しているモバイルページの割合。",
  content="91.05%",
  classes="big-number",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

プレフィックスは開発者に実験的な機能を紹介するための失敗した方法として認識されており、ブラウザはほとんどの場合プレフィックスの使用を止め、代わりにフラグを選択していますが、それでも91%のページでは少なくとも1つのプレフィックス機能が使用されています。

{{ figure_markup(
  image="vendor-prefix-features.png",
  caption="タイプ別で最も人気のあるベンダープリフィックス機能をページ数に占める割合で表示しています。",
  description="最も人気のあるベンダープリフィックス機能をタイプ別にページ数に占める割合で表した棒グラフ。デスクトップとモバイルは非常によく似ています。モバイルページの91%がベンダープリフィックスプロパティを使用し、77%がキーワードと擬似要素を使用し、65%が関数を使用し、61%が擬似クラスを使用し、52%がメディアを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1057411197&format=interactive",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

使用されているプレフィックス機能の84%がプロパティで、モバイルページの90.76%、デスクトップページの89.66%で使用されています。これは、2009年から2014年頃のCSS3時代の名残である可能性が高いです。これは、最も人気のある接頭辞付きのものからも明らかですが、2014年以降、接頭辞を必要としていないものはありませんでした。

{{ figure_markup(
  image="vendor-prefix-properties.png",
  caption="ベンダープレフィックスを使用して最もよく使用されるプロパティの相対的な人気度。",
  description="ベンダープレフィックスが最も多く使用されているプロパティの相対的な人気度を、出現率のパーセンテージで表した棒グラフ。デスクトップとモバイルでも同様の結果が得られています。ベンダープレフィックスの利用率は、`transform`プロパティが19%を占め、次いで`transition`が12%、`border-radius`が9%、`box-shadow`が8%、`user-select`と`box-sizing`が5%、`animation`が4%、`filter`が3%、`font-smoothing`、`backface-visibility`、`appearance`、`flex`がそれぞれ2%、残りのプロパティが1%となっています。残りのプロパティは`transform-origin`,`osx-font-smoothing`,`animation-name`,`background-size`,`transition-property`,`tap-highlight-color`です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=859599479&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql",
  width="600",
  height="627"
) }}

これらの接頭辞の中には、`-moz-border-radius`のようなものがあり、2011年以降は役に立たなくなっています。さらに驚くべきことに、これまで存在しなかった他の接頭辞付きプロパティは、今でも適度に一般的で、全ページの約9%が`-o-border-radius`を含んでいます！このような接頭辞付きプロパティは、2011年には存在しませんでした。

`webkit-`が最も人気のある接頭辞で、接頭辞付きプロパティの半数がこの接頭辞を使用していることは驚くことではありません。

{{ figure_markup(
  image="top-vendor-prefixes.png",
  caption="ベンダープレフィックスの相対的な人気度、出現率としての。",
  description="ベンダープレフィックスの相対的な人気度を出現率で表した棒グラフです。モバイルページでは`-webkit`が49%、`-moz`が23%、`-ms`が 19%、`-o`が8%、`-khtml`が 1%、そして`-pie`,`-js`,`-ie`が0%となっている。デスクトップも同様である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=702800205&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

接頭辞付き擬似クラスはプロパティほど一般的ではなく、10%以上のページで使われているものはありません。接頭辞付き擬似クラス全体の3分の2近くは、プレースホルダのスタイリングのためのものです。対照的に、標準の`:placeholder-shown`擬似クラスはほとんど使用されておらず、0.34%以下のページで使用されています。

{{ figure_markup(
  image="vendor-prefix-pseudo-classes.png",
  caption="ページに占める割合として、最も人気のあるベンダープリフィックスの疑似クラス。",
  description="ベンダープリフィックスの疑似クラスをページに占める割合を示した棒グラフです。モバイルページでは`:ms-input-placeholder`が10%、`:-moz-placeholder`が8%、`:-mox-focusring`が2%、以下のページでは1%以下となっています。以下の場合は1%以下です:`:-webkit-full-screen`, :-moz-full-screen, :-moz-any-link,`:-webkit-autofill`,`:-o-prefocus`,`:-ms-full-lscreen`,`:-ms-input-placeholder`[sic],`:-ms-lang`,`:-moz-ui-invalid`,`:-webkit-input-placeholder`,`:-moz-input-placeholder`,`:-webkit-any-link`",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1884876858&format=interactive",
  sheets_gid="1477158006",
  width="600",
  height="650",
  sql_file="vendor_prefix_pseudo_classes.sql"
) }}

最も一般的な接頭辞付き疑似要素は`::-moz-focus-inner`で、Firefoxの内側のフォーカスリングを無効にするために使われます。これは接頭辞付き疑似要素のほぼ4分の1を占めており、標準的な代替手段はありません。標準バージョンの`::placeholder`は後れを取っており、使用されているページはわずか4%に過ぎません。

接頭辞付き擬似要素の残りの半分は、主にネイティブ要素（検索入力、ビデオ＆オーディオコントロール、スピナーボタン、スライダー、メーター、プログレスバー）のスクロールバーとシャドウDOMのスタイリングに費やされています。これは、標準に準拠したCSSはまだ不十分であるものの、標準に準拠した組み込みUIコントロールのカスタマイズに対する開発者の強いニーズを示しています。

{{ figure_markup(
  image="vendor-prefix-pseudo-elements.png",
  caption="カテゴリ別の接頭辞付き疑似要素の使用法。",
  description="ベンダープリフィックスの疑似要素の相対的な人気度を目的別に、出現率の割合で示した棒グラフです。プレースホルダは、プレフィックスの出現率の29%で使用され、フォーカス リング21%、スクロールバー11%、検索入力10%、メディア コントロール8%、スピナー7%、その他、選択、スライダー、クリア ボタンはすべて3%、プログレスバー 2%、ファイルアップロード1%、残りはすべて約0%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013685965&format=interactive",
  sheets_gid="1466863581",
  width="600",
  height="566",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

ChromeやSafariの方がずっとプレフィックスを好むようになっているのは周知の事実ですが、特に疑似要素についてはその傾向が顕著です。

{{ figure_markup(
  image="top-pseudo-element-prefixes.png",
  caption="疑似要素ベンダープレフィックスの相対的な人気度を、モバイルページでの出現率として示しています。",
  description="疑似要素ベンダープレフィックスの相対的な人気度を、モバイルページでの出現率で示した円グラフです。疑似要素ベンダープレフィックスの使用率は、`-webkit`が47％を占め、次いで`-moz`が26％、`-ms`が15％、`-o`が7％、その他が6％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=744523431&format=interactive",
  sheets_gid="1466863581",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

接頭辞付き関数のほぼすべての使用法(98%)はグラデーションを指定するためのものであるが、<a hreflang="en" href="https://caniuse.com/css-gradients">2014年以降は必要とされていない</a>。これらの中で最もよく使われているのは`-webkit-linear-gradient()`で、調査したページの4分の1以上で使われています。残りの2%未満は主にcalcのためのもので、<a hreflang="en" href="https://caniuse.com/calc">2013年以降は接頭辞が不要となっています</a>。

{{ figure_markup(
  caption="モバイルページでのベンダープレフィックス関数の全出現率におけるグラデーション関数の割合",
  content="98.22%",
  classes="big-number",
  sheets_gid="1586213539",
  sql_file="vendor_prefix_functions.sql"
) }}

接頭辞付きメディア機能の使用率は全体的に低く、最も人気のあるものは`-webkit-min-pixel-ratio`で、「Retina」ディスプレイを検出するために13%のページで使用されています。これに対応する標準メディア機能である[`resolution`](https://developer.mozilla.org/ja/docs/Web/CSS/@media/resolution)がついにこれを上回り、モバイルページの22%とデスクトップページの15%で使用されています。

全体では、`*-min-pixel-ratio`はデスクトップではプレフィックス付きメディア機能の4分の3を占め、モバイルでは約半分を占めています。この違いの理由はモバイルでの利用率の低下ではなく、もう1つのプレフィックスメディア機能である`-*-ハイコントラスト`の人気がモバイルでははるかに高く、プレフィックスメディア機能の残りの半分近くを占めていますが、デスクトップでは18%しか占めていません。対応する標準メディア機能である [forced-colors](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/forced-colors)は、ChromeとFirefoxではまだ実験的であり、フラグの後ろに隠れているため、我々の分析では全く表示されていません。

{{ figure_markup(
  image="vendor-prefixed-media.png",
  caption="ベンダーが接頭辞を付けたメディア機能の相対的な人気度を、モバイルページでの出現率として示しています。",
  description="ベンダープレフィックスされたメディア機能の相対的な人気度を、モバイルページでの出現率で示した円グラフです。`min-device-pixel-ratio`と`high-contrast`がそれぞれ47％、`transform-3d`が5％、1％未満の残りの機能は、`device-pixel-ratio`、`max-device-pixel-ratio`、その他の機能です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1940027848&format=interactive",
  sheets_gid="1192245087",
  sql_file="vendor_prefix_media.sql"
) }}

### フィーチャークエリ

フィーチャークエリ（[@supports](https://developer.mozilla.org/ja/docs/Web/CSS/@supports)）は、ここ数年着実にトラクションを得ており、ページの39%で使用されており、昨年の30%から顕著に増加しています。

しかし、それらは何のために使用されているのでしょうか？我々は、最も人気のあるクエリを見てみました。結果は意外なものでした。グリッド関連のクエリがトップになると思っていたのですが、圧倒的に人気のある機能クエリは`position: sticky`のものでした。これはフィーチャークエリ全体の半分を占め、約4分の1のページで使用されています。対照的に、グリッド関連のクエリは全クエリの2%に過ぎず、開発者はグリッドのブラウザサポートが十分に快適であると感じているため、グリッドの機能強化としてだけ使用する必要はないことを示しています。

さらに不思議なのは、`position: sticky`自体が機能クエリほど使われておらず、デスクトップページの10%とモバイルページの13%にしか表示されていないことです。つまり、`position: sticky`を使わずに検出しているページが50万以上もあるということです。なぜでしょうか？

最後に、`max()`がすでに検出された機能のトップ10に入っており、デスクトップページの0.6%とモバイルページの0.7%で検出されていることは心強いことでした。`max()`(および`min()`、`clamp()`)`) が <a hreflang="en" href="https://caniuse.com/mdn-css_types_max">今年はボード全体でしかサポートされていなかった</a>ことを考えると、これは非常に印象的な採用であり、開発者がどれだけこの機能を必要としていたかを浮き彫りにしています。

少数ですが注目に値するページ数（約3000または0.05％）は、奇妙なことに、`@supports`よりもかなり前に存在していた`display：block`や`padding：0px`などのCSS2構文で`@supports`を使用、実装されました。 これが何を達成することを意図していたのかは不明です。 おそらく、`@supports`を実装していない古いブラウザからCSSルールを保護するために使用されたのでしょうか？

{{ figure_markup(
  image="supports-criteria.png",
  caption="サポート機能の相対的な人気度を、出現率として問い合わせました。",
  description="引用された@supportsの機能の相対的な人気度を、出現率で示した棒グラフです。最も人気のある機能は`sticky`でモバイルページの49%で、次いで`ime-align`が24%、`mask-image`が12%、`overflow-scrolling`が5%、`grid`が2%、カスタムプロパティ、`transform-style`、`max()`、`object-fit`は全て1%で、`appearance`が約0%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1901533222&format=interactive",
  sheets_gid="1155233487",
  sql_file="supports_criteria.sql"
) }}

## メタ

これまでCSS開発者が何を使用してきたかを見てきましたが、このセクションでは、CSS開発者がどのように使用しているかについて詳しく見ていきたいと思います。

### 宣言の繰り返し

スタイルシートがどれだけ効率的で保守性の高いものであるかを知るために、大まかな要因の1つは宣言の繰り返し、つまり一意な(異なる)宣言と総宣言数の比率です。この要因は大まかなもので、宣言を正規化することは些細なことではないからです (`border: none`,`border.0`,`border-width: 0`,`border-width: 0`)。また、繰り返しにはメディア・クエリ（最も有用ですが測定が難しい）、スタイルシート、Almanacの全体的なメトリクスのようなデータセット・レベルなどのレベルがあるからです。

宣言の繰り返しに注目してみたところ、モバイルでは中央値のウェブページで合計5,454個の宣言を使用しており、そのうち2,398個が一意の宣言であることがわかりました。中央値の比率（この2つの値ではなく、データセットに基づいています）は45.43%でした。これが意味するのは、中央値のページでは、各宣言がおよそ2回使用されているということです。

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>ユニーク / 全体</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">30.97%</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">45.43%</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">63.67%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="モバイルページのリピート率の分布。",
      sheets_gid="2124098640",
      sql_file="repetition.sql"
    ) }}
  </figcaption>
</figure>

これらの比率はその後、我々が乏しい過去のデータから知っているものよりも優れています。2017年、Jens Oliver Meiert<a hreflang="en" href="https://meiert.com/en/blog/70-percent-css-repetition/">220の人気ウェブサイトをサンプリング</a>して、以下のような平均値を出しました。6,121件の宣言があり、そのうち1,698件がユニークで、ユニーク/全体の比率は28%(中央値34%)でした。このトピックについてはさらに調査が必要かもしれませんが、これまでのところわかっていることはほとんどありません、宣言の繰り返しは目に見えるものであり、人気のある大規模なサイトでは改善されているか問題となっている可能性があります。

### 短縮形と通常の記載

短縮形の中には、他のものよりも成功しているものもあります。時には、その短縮形は十分に使いやすく、その構文も覚えやすいので特定の値を独立して上書きしたい場合には、意図的に通常の記載だけを使うことになることもあります。また、構文があまりにも混乱しているために、ほとんど使われていない短縮形もあります。

#### 通常の記載の前の短縮形

短縮形の中には、他のものよりも成功しているものもあります。時には、その短縮形は十分に使いやすく、その構文も覚えやすいので特定の値を独立して上書きしたい場合には、意図的に通常の木しあだけを使うことになることもあります。また、構文があまりにも混乱しているために、ほとんど使われていない短縮形もあります。短縮形を使って、同じルールの中でいくつかの通常の記載を使ってそれをオーバーライドするのは、さまざまな理由から良い戦略と言えます。

第一に、それは良い守備的コーディングです。短縮形は、明示的に指定されていない場合、すべての通常の記載を初期値にリセットします。これにより、カスケードを通して不正な値が入ってくるのを防ぎます。

第二に、短文がスマートなデフォルト値を持っている場合に、値の繰り返しを避けることは保守性に優れています。例えば、`margin: 1em 1em 0 1em`の代わりに、次のように書くことができます。

```css
margin: 1em;
margin-bottom: 0;
```

同様にリスト値のプロパティについても、すべてのリスト値で値が同じである場合には、通常の記載を使用することで繰り返しを減らすことができます。

```css
background: url("one.png"), url("two.png"), url("three.png");
background-repeat: no-repeat;
```
第三に、短縮形の構文の一部があまりにも奇妙な場合、通常の記載は可読性を向上させるのに役立ちます。

```css
/* Instead of: */
background: url("one.svg") center / 50% 50% content-box border-box;

/* This is more readable: */
background: url("one.svg") center;
background-size: 50% 50%;
background-origin: content-box;
background-clip: border-box;
```

では、どのくらいの頻度でこのようなことが起こるのでしょうか？　非常に頻繁です。88%のページで少なくとも一度はこの戦略を使用しています。これは、`background`の中の`background-size`のスラッシュ構文が、私たちが考え出した中で最も読みやすく、記憶に残りやすい構文ではなかった可能性があることを示しています。他のロングハンドでは、このような頻度に近いものはありません。残りの60%はロングテールで、他の多くのプロパティに均等に広がっています。

{{ figure_markup(
  image="most-popular-longhand-after-shorthand.png",
  caption="同じルールの短縮形の後に来る最も人気のある通常の記載。",
  description="バーチャートは`background-size`がデスクトップで15%、モバイルで41%、`background-image`がそれぞれ8%と6%、`margin-bottom`が6%と4%、`margin-top`が6%と4%であることを示しています。`border-bottom-color`は5%と3%、`font-size`は4%と3%、`border-top-color`は4%と3%、`background-color`は4%と3%、`padding-left`は3%と2%、`margin-left`は3%と2%、`margin-left`は3%と2%を配置します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=176504610&format=interactive",
  sheets_gid="17890636",
  sql_file="meta_shorthand_first_properties.sql",
  width="600",
  height="429"
) }}

#### font

`font`はかなり人気がありますが（80%のページで4,900万回使われています）、他のほとんどの通常の記載（`font-variant`と`font-stretch`を除く）に比べれば、ほとんど使われていません。これは、ほとんどの開発者がこの通常の記載を快適に使っていることを示しています (この通常の記載は非常に多くのウェブサイトで使われているので)。開発者はしばしば、子孫ルールで特定のタイポグラフィを上書きする必要がありますが、 それがなぜ通常の記載がこれほど多く使われているのかを説明しているのでしょう。

{{ figure_markup(
  image="font-shorthands.png",
  caption="`font`の短縮形とロングハンドのプロパティを採用しました。",
  description="フォントの短縮系と通常の記載プロパティの採用状況を示す棒グラフ。最も使用されているプロパティは、モバイルページの95%から92%までの通常の記載で、降順にfont-weight、font-family、font-size、line-height、font-styleとなっています。フォント短縮形は、80%のモバイルページで使用されています。あまり使用されていないフォント・通常の記載は、font-variantが43%で、font-stretchが8%です。採用率はデスクトップとモバイルでほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1455030576&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### background

最も古い通常の記載の一つである`background`もまた、非常によく使われており、92%のページで10億回使用されています。しかし、これは開発者がすべての構文を使いこなせているわけではありません:`background`のほぼすべて（90%以上）は非常にシンプルなもので、1つか2つの値を持つものです。それ以上のものについては、ロングハンドの方がわかりやすいと考えられています。

{{ figure_markup(
  image="background-shorthand-versus-longhand.png",
  caption="`background`の短縮形とその通常の記載の用法比較。",
  description="バーチャートを見ると、`background`はデスクトップで91%、モバイルで92%、`background-color`はそれぞれ91%と92%、`background-image`は85%と87%、`background-position`は84%と85%となっています。`background-repeat`は82%と84%、`background-size`は77%と79%、`background-clip`は48%と53%、`background-attachment`は37%と38%、`background-origin`はデスクトップで5%、モバイルで12%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2014923335&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="429"
) }}

#### Marginsとpaddings

`margin`と`padding`の両方の短縮形、およびそれらの通常の記載は、CSSプロパティの中で最もよく使用されているものの1つです。Paddingは短縮記号として指定される可能性がかなり高くなっています（`padding`は150万回使用されているのに対し、それぞれの短縮記号は300～400万回使用されています）が、marginはあまり差がありません（`margin`は110万回使用されているのに対しそれぞれの短縮記号は500～800万回使用されています）。多くのCSS開発者がこれらの短縮形の値の時計回りの順序と、2つまたは3つの値の繰り返しルールについて最初は混乱していたことから、これらの短縮形の使用のほとんどは単純なもの（1つの値）になると予想していましたが、1,2,3,4つの値のすべての範囲を見ることができました。明らかに1や2の値の方が一般的ですが、3や4の値は全く珍しくなく、`margin`の25%以上、`padding`の10%以上で使用されています。

{{ figure_markup(
  image="margin-padding-shorthand-vs-longhand.png",
  caption="`margin`と`padding`の短縮形とその通常の記載の用法比較。",
  description="棒グラフでは、`padding`がデスクトップで93%、モバイルで94%、`margin`がそれぞれ93%と93%、`margin-left`が91%と92%、`margin-top`が90%と91%、`margin-right`が90%と91%であることを示しています。`margin-bottom`が90%と91%、`padding-left`が90%と90%、`padding-top`が88%と89%、`padding-bottom`が88%と89%、`padding-right`が87%と88%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=804317202&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Flex

ほぼすべての`flex`,`flex-*`プロパティは非常によく使われており、30～60%のページで使用されています。しかし、`flex-wrap`と`flex-direction`の両方が、その短縮形である`flex-flow`よりもはるかに多く使われています。`flex-flow`が使われるときは、2つの値、つまり両方の通常の記載を短く設定する方法として使われます。1つまたは2つの値で`flex`を使用するための[精巧な賢明なデフォルト](https://developer.mozilla.org/ja/docs/Web/CSS/flex#Syntax:~:text=The%20flex%20property%20may%20be%20specified%20using%20one%2C%20two%2C%20or%20three%20value)があるにもかかわらず、使用の約90%は3つの値の構文で、3つの通常の記載を明示的に設定しています。

{{ figure_markup(
  image="flex-shorthand-vs-longhand.png",
  caption="flexの短縮形とその通常の記載の使い方比較",
  description="バーチャートでは、`flex-direction`がデスクトップで55%、モバイルで60%、`flex-wrap`がそれぞれ55%と58%、`flex`が52%と56%、`flex-grow`が44%と52%、`flex-basis`が40%と44%、`flex-shrink`が28%と37%、`flex-flow`が27%と30%であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=930720666&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Grid

`grid-template`の略語として`grid-template-columns`,`grid-template-template-rows`,`grid-template-areas`があることをご存知でしょうか? また、`grid`プロパティがあり、それらはすべてその通常の記載の一部であることを知っていましたか? 知らないのですか？　ほとんどの開発者はそうではありません。`grid`プロパティが使われたのは 5,279のウェブサイト(0.08%)で、`grid-template`が使われたのは 8,215のウェブサイト(0.13%)だけでした。一方、`grid-template-columns`は170万のウェブサイトで使用されており、その200倍以上も使用されています。

{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="Gridの短縮形とその通常の記載の使い方比較",
  description="バーチャートを見ると、`grid-template-columns`はデスクトップで27%、モバイルで26%、`grid-template-rows`はそれぞれ24%と24%、`grid-column`は20%と20%となっています。`grid-row`は20%と19%、`grid-area`は6%と6%、`grid-template-areas`は6%と6%、`grid-gap`は4%と5%、`grid-column-gap`は4%と3%、`grid-row-gap`は3%と3%である。`grid-column-end`は3%と2%で、`grid-column-start`は3%と2%で、`grid-row-start`は3%と2%で、`grid-row-end`は2%と2%で、`grid-auto-columns`は2%と2%で、`grid-auto-rows`は1%と1%である。`grid-auto-flow`は1%と1%、`grid-template`は0%と0%、`grid`は0%と0%、`grid-column-span`は0%と0%、`grid-columns`は0%と0%、`grid-rows`は0%と0%の順である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=290183398&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="575"
) }}

### CSSの間違い

どんな複雑で進化するプラットフォームでもそうですが、すべてが正しく行われるわけではありません。そこで、開発者が犯している間違いのいくつかを見てみましょう。

#### 構文エラー

この章のほとんどのメトリクスでは、CSSパーサーである<a hreflang="en" href="https://github.com/reworkcss/css">Rework</a> を使用しました。これは精度を劇的に向上させるのに役立ちますが、ブラウザに比べて構文エラーに寛容でないことも意味します。スタイルシート全体の1つの宣言に構文エラーがあったとしても、構文解析は失敗し、そのスタイルシートは解析の対象外となります。しかし、そのような構文エラーを含むスタイルシートはどれくらいあるのだろうか？　モバイルよりもデスクトップの方がかなり多いことが判明しました。具体的には、デスクトップページで発見されたスタイルシートの10%近くに少なくとも1つの回復不可能な構文エラーが含まれていたのに対し、モバイルページでは2%しか含まれていませんでした。すべての構文エラーが実際にパースに失敗するわけではないので、これらは基本的には構文エラーの下限値であることに注意してください。例えば、セミコロンがない場合、次の宣言が値の一部として解析されるだけで（例えば、`{property: "color", value: "red background: yellow"}`など）、パーサが失敗することはありません。

#### 存在しないプロパティ

また、既知のプロパティのリストを使用して、最も一般的な存在しないプロパティを調べました。この分析のこの部分から接頭辞付きのプロパティを除外し、接頭辞なしのプロプライエタリなプロパティを手動で除外しました (例: Internet Explorerの`behavior`、奇妙なことに今でも20万件のウェブサイトに表示されています)。残りの存在しないプロパティのうち。

- そのうち37%は接頭辞付きプロパティの変形した形式でした(例:`webkit-transition`や`-transition`)。
- 43%は接頭辞のみでしか存在しないプロパティの接頭辞なしの形式(例えば、`font-smoothing`は384Kのウェブサイトに登場しました)で、おそらく互換性のために、標準であるという誤った仮定の下で、あるいは標準になることを願って含まれていたのでしょう。
- 人気のあるライブラリへの道を見つけたタイプミス。この分析の結果、`white-wpace`というプロパティが234,027のウェブサイトに存在していることがわかりました。これは、同じタイプミスが有機的に発生したとは思えないほどの数です。そして驚いたことに、Facebookウィジェットが原因であることが判明しました(https://twitter.com/rick_viscomi/status/1326739379533000704)。修正はすでに行われています。
- そして、もう一つの奇妙なことがあります。プロパティ`font-rendering`が2,575ページに登場しています。しかし、プリフィックスの有無にかかわらず、このようなプロパティが存在する証拠を見つけることができません。非標準の<a hreflang="en" href="https://medium.com/better-programming/improving-font-rendering-with-css-3383fc358cbc">`-webkit-font-smoothing`</a> がありますが、これは300万のウェブサイト、つまりページの約49%に登場しており、非常に人気がありますが、`font-rendering`はスペルミスというには十分に近くありません。[`テキストレンダリング`](https://developer.mozilla.org/ja/docs/Web/CSS/text-rendering)は約10万のWebサイトで使われているので、2.5万人の開発者が皆、`font-smoothing`と`text-rendering`の混成語を間違えて作ってしまったと考えられます。

{{ figure_markup(
  image="most-popupular-unknown-properties.png",
  caption="最も人気のある未知の物件。",
  description="バーチャートを見ると、`webkit-transition`はデスクトップで15%、モバイルで14%、`font-smoothing`はそれぞれ13%、12%、`user-drag`はモバイルで12%、`white-wpace`はモバイルで10%、`tap-highlight-color`はモバイルで10%、10%となっています。`webkit-box-shadow`は4%と4%、`ms-transform`は2%と2%、`transition`は1%と1%、`font-rendering`は0%と0%、デスクトップでは`webkit-border-radius`は2%、デスクトップでは`moz-border-radius`は2%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1166982997&format=interactive",
  sheets_gid="84286607",
  sql_file="meta_unknown_properties.sql",
  width="600",
  height="401"
) }}

#### 短縮形の前の通常の記載

短縮形の後に通常の記載を使うのは、デフォルトを使ったり、いくつかのプロパティを上書きしたりするのに便利な方法です。これは特にリスト値を持つプロパティで便利です。反対に、短縮形の前に通常の記載を使うことは、常に間違いです。例えば、これを見てみましょう。

```css
background-color: rebeccapurple; /* longhand */
background: linear-gradient(white, transparent); /* shorthand */
```

これは`white`から`rebeccapurple`へのグラデーションではなく、`white`から`transparent`へのグラデーションを生成します。`rebeccapurple`の背景色は、この後に続く`background`短縮形によって上書きされ、すべての通常の記載が初期値にリセットされます。

開発者がこのような間違いを犯す主な理由は2つあります。それは、短縮形がどのように動作し、どの短縮形によってどの通常の記載がリセットされるのかについての誤解、あるいは宣言を移動させた際に残った残骸です。

では、この間違いはどのくらい一般的なのでしょうか？　確かに、トップ600万のウェブサイトでは、それほど一般的ではありませんよね？　違う！　結局のところ、それは非常に一般的であり、ウェブサイトの54％で少なくとも一度は発生しています！

この種の混乱は、他の速記法よりも`background`速記法の方がはるかに多いようです: これらの間違いの半分以上(55%)は、`background`の前に`background-*`の通常の記載を置くことに起因しています。この場合、これは実際には全くの間違いではなく、優れたプログレッシブな機能強化なのかもしれません。リニアグラデーションなどの機能をサポートしていないブラウザは、以前に定義された通常の記載値、この場合は背景色をレンダリングします。短縮形を理解しているブラウザは、暗黙的にまたは明示的に通常の記載に上書きします。

{{ figure_markup(
  image="most-popupular-shorthands-after-longhands.png",
  caption="通常の記載の次に人気のある短縮形。",
  description="バーチャートを見ると、`background`はデスクトップの56.46%とモバイルの55.17%で、`margin`はそれぞれ12.51%と12.18%、`font`は10.15%と10.31%、`padding`は8. 36%と7.87%、`border-radius`が1.08%と3.14%、`animation`が3.18%と3.05%、`list-style`が2.09%と2.00%、`transition`が1.09%と0.98%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1389278729&format=interactive",
  sheets_gid="1143644053",
  sql_file="meta_longhand_first_properties.sql"
) }}

## Sass

CSSコードを分析することで、CSS開発者が何をしているかがわかりますが、プリプロセッサのコードを見ることで、CSS開発者が何をしたくてもできないことを少し知ることができます。Sassは2つの構文で構成されています。よりミニマルなSassと、CSSに近いSCSSです。前者は人気が落ちてきていて、今ではあまり使われていないので、後者だけを見てみました。ソースマップ付きのCSSファイルを使って、SCSSのスタイルシートを抽出して解析してみました。ソースマップの分析に基づいて、SCSSは最もポピュラーな前処理構文であるため、SCSSに注目することにしました。

開発者が色修正機能を必要としていることは以前からわかっており、<a hreflang="en" href="https://drafts.csswg.org/css-color-5/">CSS Color 5</a>で取り組んでいます。しかし、SCSSの関数呼び出しを解析することで、色修正関数がどれだけ必要かを証明するためのデータが得られ、またどのような種類の色修正が最も一般的に必要とされているかを知ることができます。

全体的に、Sassの関数呼び出しの3分の1以上は、色を変更したり色の成分を抽出したりするために行われています。私たちが見つけたほとんどの色の変更は、かなり単純なものでした。半分は色を暗くするためのものでした。実際、`darken()`は全体的に最も人気のあるSass関数コールで、一般的な`if()`よりも多く使われていました。明るいコアカラーを定義し、`darken()`を使って暗い色のバリエーションを作るのが一般的な戦略のようです。反対に明るくすることはあまり一般的ではなく、関数呼び出しのうち`lighten()`が使われているのは5%に過ぎませんが、それでも全体では6番目に人気のある関数でした。アルファチャンネルを変更する関数は全体の約4%で、色を混ぜる関数は全体の3.5%となっている。色相、彩度、赤/緑/青のチャンネルを調整する関数や、より複雑な`adjust-color()`のような他のタイプの色の変更はほとんど使われていません。

{{ figure_markup(
  image="most-popupular-sass-function-calls.png",
  caption="最も人気のあるSassの関数呼び出し。",
  description="バーチャートを見ると、`(other)`がデスクトップで23%とモバイルで23%使用されており、`darken`がそれぞれ17%と18%、`if`が14%と14%、`map-keys`が8%と9%、`percentage`が8%と8%であることがわかる。`map-get`は8%と7%、`lighten`は5%と6%、`nth`は5%と5%、`mix`は4%と4%、`length`は3%と3%、`type-of`は2%と2%、`(α調整)`はデスクトップで2%、モバイルで2%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=774248494&format=interactive",
  sheets_gid="170555219",
  sql_file="sass_function_calls.sql"
) }}

カスタム関数の定義は<a hreflang="en" href="https://github.com/w3c/css-houdini-drafts/issues/857">Houdiniで何年も議論されてきた</a>のですが、Sassスタイルシートを研究していると、その必要性がどれだけ一般的なものかというデータが得られます。非常に一般的であることがわかりました。調査したSCSSスタイルシートの少なくとも半分はカスタム関数を含んでおり、中央値のSCSSシートは1つではなく2つのカスタム関数を含んでいます。

また、CSS WGでは限定的な条件式の導入について<a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5009">最近</a><a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5624">議論</a>が行われており、Sassではこれがどのくらいの頻度で必要とされているかについてのデータを提供してくれています。SCSSのシートのほぼ3分の2が少なくとも1つの`@if`ブロックを含んでおり、すべての制御フロー文のほぼ3分の2を占めています。また、値内の条件式のための`if()`関数もあり、これは全体で2番目によく使われる関数です(14%)。

{{ figure_markup(
  image="usage-of-control-flow-statements-scss.png",
  caption="SCSSでの制御フロー文の使用法",
  description="棒グラフを見ると、`@if`はデスクトップで63％、モバイルで63％、`@for`はそれぞれ55％と55％、`@each`は54％と55％、`@while`は2％と2％となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=157473209&format=interactive",
  sheets_gid="498478750",
  sql_file="sass_control_flow_statements.sql"
) }}

これは、Sassや他のプリプロセッサで`&`を使ってできることと同様に、他のルールの中にルールを入れ子にできます。SCSSシートでネスティングはどのくらい一般的に使われているのでしょうか？　非常によく使われています。SCSSシートの大部分は、少なくとも1つの明示的に入れ子にしたセレクタを使用しており、擬似クラス(例:`&:hover`)とクラス(例:`&.active`)がそのうちの4分の3を占めています。また、子孫が想定され、`&`文字が不要な暗黙の入れ子は考慮されていません。

{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="usage-of-explicit-nesting-in-scss.",
  description="棒グラフを見ると、`Total`はデスクトップで85%とモバイルで85%、`&:pseudo-class`はそれぞれ83%と83%、`&. class`が80%と80%、`&::pseudo-element`が66%と66%、`& (by itself)`が62%と62%、`&[attr]`が57%と57%、`& >`が24%と23%、`& +`が21%と20%、`& descendant`が16%と15%、`& descendant`が16%と15%、``&id`がデスクトップで6%、モバイルで6%であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=370242263&format=interactive",
  sheets_gid="1872903377",
  sql_file="sass_nesting.sql"
) }}

## 結論

ふー！　それはたくさんのデータでした！ 私たちが行ったように、あなたが興味を持ってくれたことを願っています。私たちは、あなたが私たちと同じように興味を持ってくれたことを願っていますし、おそらくそれらのいくつかについてあなた自身の洞察を形成できました。

その結果、WordPress、Bootstrap、Font Awesomeなどの人気のあるライブラリが新機能を採用する主な要因となっている一方で、個人の開発者は保守的な傾向があるということがわかりました。

もう1つの観察は、ウェブには新しいコードよりも古いコードの方が多いということです。実際のウェブは、20年前に書かれた可能性のあるコードから最新のブラウザでしか動作しない最先端の技術まで、非常に広範囲にわたっています。しかし、この研究が示してくれたのは相互運用性に優れているにもかかわらず、しばしば誤解され十分に活用されていない強力な機能があるということです。

また、開発者がCSSを使いたくても使えない方法のいくつかを示し、開発者が何を混乱させているのかについての洞察を得ることができました。このデータの一部はCSS WGに持ち帰られ、CSSの進化を促進するために役立てられる予定です。

私たちは、この分析がウェブサイトの開発方法にさらなる影響を与える可能性があることに興奮しており、これらのメトリクスが時間の経過とともにどのように発展していくかを見るのを楽しみにしています。
