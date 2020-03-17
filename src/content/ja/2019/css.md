---
part_number: I
chapter_number: 2
title: CSS
description: 色、単位、セレクター、レイアウト、タイポグラフィとフォント、間隔、装飾、アニメーション、およびメディアクエリをカバーする2019 Web年鑑のCSS章。
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
translators: [ksakae]
discuss: 1757
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-23T00:00:00.000Z
---

## 導入

カスケードスタイルシート（CSS）は、Webページの描画、書式設定、およびレイアウトに使用されます。それらの機能は、テキストの色から3Dパースペクティブまでの単純な概念に及びます。また、さまざまな画面サイズ、コンテキストの表示、印刷を処理する開発者を支援するフックもあります。 CSSは、開発者がコンテンツを絞り込み、ユーザーに適切に適合させることを支援します。

CSSをWebテクノロジーに慣れていない人に説明するときは、CSSを家の壁にペイントする言語と考える事が役立ちます。窓やドアのサイズと位置、および壁紙や植物などが栄える装飾と説明できる。そのストーリーの面白いひねりは、ユーザーが家の中を歩いているかどうかに応じて、開発者はその特定のユーザーの好みやコンテキストに家を作り替えることができるということです！

この章では、WebでのCSSの使用方法に関するデータを検査、集計、および抽出します。私たちの目標はどの機能が使用されているか、どのように使用されているか、CSSがどのように成長し採用されているかを全体的に理解することです。

魅力的なデータを掘り下げる準備はできましたか?! 以下の数値の多くは小さい場合がありますが、重要ではないと誤解しないでください! 新しいものがウェブを飽和させるには何年もかかることがあります。

## 色

色は、Webのテーマとスタイリングに不可欠な部分です。ウェブサイトが色を使用する傾向を見てみましょう。

### 色の種類

16進数は、色を説明する最も一般的な方法であり93％の使用率、RGB、HSLが続きます。興味深いことに、開発者はこれらの色の種類に関してアルファ透明度の引数を最大限に活用しています。HSLAとRGBAは、HSLとRGBよりもはるかに人気があり、使用量はほぼ2倍です。アルファ透明度は後でWeb仕様に追加されましたが、HSLAとRGBAは[IE9までさかのぼって](https://caniuse.com/#feat=css3-colors)サポートされているため、先に進んで使用することもできます！

<figure>
  <a href="/static/images/2019/css/fig1.png">
    <img src="/static/images/2019/css/fig1.png" alt="図1.カラー形式の人気。" aria-labelledby="fig1-caption" aria-describedby="fig1-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1946838030&amp;format=interactive">
  </a>
  <div id="fig1-description" class="visually-hidden">HSL、HSLA、RGB、RGBA、および16進カラー形式の採用を示す棒グラフ。 Hexはデスクトップページの93％、RGBAは83％、RGBは22％、HSLA 19％、HSL 1％で使用されています。デスクトップとモバイルの採用は、モバイルの採用が9％（9倍）であるHSLを除くすべてのカラー形式で類似しています。s</div>
  <figcaption id="fig1-caption">図1.カラー形式の人気。</figcaption>
</figure>

### 色の選択

CSSの[名前付きカラーは148個](https://www.w3.org/TR/css-color-4/#named-colors)あり、`transparent`および`currentcolor`の特別な値は含まれていません。これらを文字列名で使用して、読みやすくできます。最も人気がある名前の付いた色は`黒`と`白`であり、当然のことながら`赤`と`青`が続きます。

<figure>
  <a href="/static/images/2019/css/fig2.png">
    <img src="/static/images/2019/css/fig2.png" alt="図2.上位の名前付き色。" aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="415" data-width="600" data-height="415" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1985913808&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">最も人気のある名前付きの色を示す円グラフ。白が40％で最も人気があり、次に黒が22％、赤が11％、青が5％です。</div>
  <figcaption id="fig2-caption">図2.上位の名前付き色。</figcaption>
</figure>

言語は色によっても興味深いことに推測されます。イギリス式の「grey」よりもアメリカ式の「gray」の例が多くあります。[グレー色](https://www.rapidtables.com/web/color/gray-color.html)（`グレー`、`ライトグレー`、`ダークグレー`、`スレートグレー`など）のほぼすべてのインスタンスは、「e」ではなく「a」で綴ると、使用率がほぼ2倍になりました。 gr [a/e] ysが組み合わされた場合、それらは青よりも上位にランクされ、＃4スポットで固まります。これが、チャートで銀がグレーよりも高いランクになっている理由です。

### 色の数

ウェブ全体でいくつの異なるフォントの色が使用されていますか？　これは一意の色の総数ではありません。むしろ、テキストに使用される色の数です。このグラフの数値は非常に高く、経験からCSS変数なしでは間隔、サイズ、色がすぐに離れて、スタイル全体で多くの小さな値に断片化することがわかります。これらの数値はスタイル管理の難しさを反映しており、あなたがチームやプロジェクトに持ち帰るための何らかの視点を作り出すのに役立つことを願っています。この数を管理可能かつ合理的な量に減らすにはどうすればよいですか？

<figure>
  <a href="/static/images/2019/css/fig3.png">
    <img src="/static/images/2019/css/fig3.png" alt="図3.ページごとの色の分布。" aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1361184636&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">デスクトップおよびモバイルページごとの色の10、25、50、75、および90パーセンタイルを示す分布。デスクトップ分布は8、22、48、83、および131です。モバイルページは、1〜10までに色が増える傾向があります。</div>
  <figcaption id="fig3-caption">図3.ページごとの色の分布。</figcaption>
</figure>

### 色の複製

さて、私たちはここで興味を持ち、ページにいくつの重複色が存在するかを調べたいと思いました。しっかり管理された再利用可能なクラスCSSシステムがなければ、複製はものすごく簡単に作成できます。中央値には十分な重複があるため、パスを実行してそれらをカスタムプロパティと統合する価値があるかもしれません。

<figure>
  <a href="/static/images/2019/css/fig4.png">
    <img src="/static/images/2019/css/fig4.png" alt="図4.ページごとの複製色の分布。" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=326531498&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">ページごとの色の分布を示す棒グラフ。中央のデスクトップページには24の重複した色があります。 10パーセンタイルは4つの重複色であり、90パーセンタイルは62です。デスクトップとモバイルの分布は似ています。</div>
  <figcaption id="fig4-caption">図4.ページごとの複製色の分布。</figcaption>
</figure>

## ユニット

CSSには、異なるユニットタイプ（`rem`、`px`、`em`、`ch`、または`cm`）を使用して同じ視覚的結果を達成するためのさまざまな方法があります！　それで、どのユニットタイプが最も人気ですか？

<figure>
  <a href="/static/images/2019/css/fig5.png">
    <img src="/static/images/2019/css/fig5.png" alt="図5.ユニットタイプの人気。" aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=540111393&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">さまざまなユニットタイプの人気の棒グラフ。 pxとemは、ページの90％以上で使用されています。 remは、ページの40％で次に人気のあるユニットタイプであり、残りのユニットタイプの人気は急落します。</div>
  <figcaption id="fig5-caption">図5.ユニットタイプの人気。</figcaption>
</figure>

### 長さとサイズ

当然のことながら、上の図5では、`px`が最もよく使用されるユニットタイプであり、Webページの約95％が何らかの形式のピクセルを使用しています（これは要素のサイズ、フォントサイズなどです）。ただし、`em`ユニットの使用率はほぼ同じで約90％です。これは、Webページで40％の頻度しかない`rem`ユニットよりも2倍以上人気があります。違いを知りたい場合は、`em`は親フォントサイズに基づいており、`rem`はページに設定されている基本フォントサイズに基づいています。 `em` のようにコンポーネントごとに変更されることはないため、すべての間隔を均等に調整できます。

物理的な空間に基づいた単位となると、`cm`（またはセンチメートル）ユニットが最も人気であり、次に`in`（インチ）、`Q`が続きます。これらのタイプのユニットは、印刷スタイルシートに特に役立つことがわかっていますが、この調査まで`Q`ユニットが存在することさえ知りませんでした！　知ってましたか？

<p class="note">この章の以前のバージョンでは、<code>Q</code>ユニットの予想外の人気について説明しました。この章を取り巻く<a href="https://discuss.httparchive.org/t/chapter-2-css/1757/6">コミュニティの議論</a>のおかげで、これは分析のバグであることがわかり、それに応じて図5を更新しました。</p>

### ビューポートベースのユニット

ビューポートベースのユニットのモバイルとデスクトップの使用に関しては、ユニットタイプに大きな違いが見られました。モバイルサイトは36.8％が`vh`（ビューポートの高さ）を使用していますが、デスクトップサイトは31％しか使用していません。また、`vh`は`vw`（ビューポートの幅）よりも約11％一般的です。 `vmin`（ビューポートの最小値）は`vmax`（ビューポートの最大値）よりも人気があり、モバイルでの`vmin`の使用率は約8％で、`vmax`はWebサイトの1％のみが使用しています。

### カスタムプロパティ

カスタムプロパティは、多くの場合CSS変数と呼ばれます。ただし、通常の静的変数よりも動的です！　CSS変数は非常に強力であり、コミュニティとして私たちはまだ彼らの可能性を発見しています。

<figure>
  <div class="big-number">5%</div>
  <figcaption>図6.カスタムプロパティを使用しているページの割合。</figcaption>
</figure>

私たちのお気に入りはCSS追加の1つが健全な成長を示しており、これは刺激的な情報だと感じました。これらは2016年または2017年以降、すべての主要なブラウザで利用可能であったため、かなり新しいと言っても過言ではありません。多くの人々は、CSSプリプロセッサ変数からCSSカスタムプロパティに移行しています。カスタムプロパティが標準になるまであと数年かかると推定されます。

## セレクター

### ID vs クラスセレクター

CSSには、スタイリングのためにページ上の要素を見つける方法がいくつかあるのでIDとクラスを互いに比較して、どちらがより一般的であるかを確認しましょう。結果は驚くべきものでありません。クラスの方が人気です！

<figure>
  <a href="/static/images/2019/css/fig7.png">
    <img src="/static/images/2019/css/fig7.png" alt="図7.ページごとのセレクタータイプの人気。" aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1216272563&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">IDおよびクラスセレクタータイプの採用を示す棒グラフ。クラスは、デスクトップおよびモバイルページの95％で使用されます。 IDは、デスクトップの89％とモバイルページの87％で使用されます。</div>
  <figcaption id="fig7-caption">図7.ページごとのセレクタータイプの人気。</figcaption>
</figure>

素敵なフォローアップチャートはこれです。スタイルシートで見つかったセレクタの93％がクラスを占めることを示しています。

<figure>
  <a href="/static/images/2019/css/fig8.png">
    <img src="/static/images/2019/css/fig8.png" alt="図8.セレクタごとのセレクタタイプの人気。" aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=351006989&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">セレクタの94％にデスクトップとモバイルのクラスセレクタが含まれていることを示す棒グラフ、一方デスクトップセレクターの7％にはIDセレクターが含まれます（モバイルの場合は8％）。</div>
  <figcaption id="fig8-caption">図8.セレクタごとのセレクタタイプの人気。</figcaption>
</figure>

### 属性セレクター

CSSには、非常に強力な比較セレクターがいくつかあります。これらは、`[target="_blank"]`、`[attribute^="value"]`、`[title~="rad"]`、`[attribute$="-rad"]`または`[attribute*="value"]`などのセレクターです。それらを使用しますか？　よく使われていると思いますか？　それらがWeb全体でIDとクラスでどのように使用されるかを比較しましょう。

<figure>
  <a href="/static/images/2019/css/fig9.png">
    <img src="/static/images/2019/css/fig9.png" alt="図9. ID属性セレクターごとの演算子の人気。" aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=695879874&amp;format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">ID属性セレクターで使用される演算子の人気を示す棒グラフ。デスクトップページとモバイルページの約4％は、スターイコールとキャレットイコールを使用しています。 1％のページで「イコール」と「ダラーイコール」を使用しています。 0％はチルダイコールを使用します。</div>
  <figcaption id="fig9-caption">図9. ID属性セレクターごとの演算子の人気。</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/css/fig10.png">
    <img src="/static/images/2019/css/fig10.png" alt="図10.クラス属性セレクタごとの演算子の人気。" aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=377805296&amp;format=interactive">
  </a>
  <div id="fig10-description" class="visually-hidden">クラス属性セレクターで使用される演算子の人気を示す棒グラフ。 57％のページがスターイコールを使用しています。 36％がキャレットイコールを使用します。 1％はイコールおよびドルイコールを使用します。 0％はチルダイコールを使用します。</div>
  <figcaption id="fig10-caption">図10.クラス属性セレクタごとの演算子の人気。</figcaption>
</figure>

スタイルシートのIDセレクターは通常クラスセレクターよりも少ないため、これらの演算子はIDよりもクラスセレクターではるかに人気がありますが、これらすべての組み合わせの使用法は見た目にも優れています。

### 要素ごとのクラス

OOCSS、アトミック、および機能的なCSS戦略の登場により要素に10以上のクラスを構成してデザインの外観を実現できるため、おそらく興味深い結果が得られるでしょう。クエリは非常に刺激的でなく、モバイルとデスクトップの中央値は要素ごとに1クラスでした。

<figure>
  <div class="big-number">1</div>
  <figcaption>図11.クラス属性ごとのクラス名の中央値数（デスクトップおよびモバイル）。</figcaption>
</figure>

## レイアウト

### Flexbox

[Flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox)は、子を指示、整列するコンテナスタイルです。つまり制約ベースの方法でレイアウトを支援します。 2010年から2013年の間に仕様が2〜3の大幅な変更を経たため、Webでの開始は非常に困難でした。幸いなことに、2014年までにすべてのブラウザに落ち着き実装されました。その歴史を考えると採用率は低かったのですが、それから数年が経ちました！　今では非常に人気があり、それに関する多くの記事とそれを活用する方法がありますが、他のレイアウト戦術と比較してまだ新しいです。

<figure>
  <a href="/static/images/2019/css/fig12.png">
    <img src="/static/images/2019/css/fig12.png" alt="図12.フレックスボックスの採用。" aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2021161093&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">フレックスボックスを使用したデスクトップページの49％とモバイルページの52％を示す棒グラフ。</div>
  <figcaption id="fig12-caption">図12.フレックスボックスの採用。</figcaption>
</figure>

Webのほぼ50％がスタイルシートでflexboxを使用しているため、ここに示したかなりの成功事例です。

### Grid

flexboxと同様に、[グリッド](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)も早い段階でいくつかの仕様変更を経ましたが、公的に展開されたブラウザの実装を変更することはありませんでした。 Microsoftは、水平方向にスクロールするデザインスタイルの主要なレイアウトエンジンとして、Windows 8の最初のバージョンにグリッドを備えていました。最初にそこで検証され、Webに移行し、その後、2017年の最終リリースまで他のブラウザーによって強化されました。ほぼすべてのブラウザーが同時に実装をリリースしたため、Web開発者はある日目覚めただけで優れたグリッドサポートを得ることができました。今日2019年の終わりに、グリッドはまだ子供のように感じています。人々がまだその力と能力に気付き始めているため。

<figure>
  <div class="big-number">2%</div>
  <figcaption>図13.グリッドを使用するWebサイトの割合。</figcaption>
</figure>

これは、Web開発コミュニティが最新のレイアウトツールを使用して調査したことがどれほど少ないかを示しています。主要なレイアウトエンジンの人々がサイトを構築する際に頼るので、グリッドの最終的な引継ぎを楽しみにしています。著者にとって、私たちはグリッドを書くのが大好きです。通常、最初にグリッドへ到達し、次にレイアウトを実現し、繰り返しながら複雑さをダイヤルバックします。今後数年間で、この強力なCSS機能を使用して他の地域がどうなるかは今後の課題です。

### 書き込みモード

WebとCSSは国際的なプラットフォーム機能であり、書き込みモードはHTMLとCSSが要素内でユーザーの好みの読み取りと書き込みの方向を示す方法を提供します。

<figure>
  <a href="/static/images/2019/css/fig14.png">
    <img src="/static/images/2019/css/fig14.png" alt="図14.方向の値の人気。" aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=136847988&amp;format=interactive">
  </a>
  <div id="fig14-description" class="visually-hidden">方向値ltrおよびrtlの人気を示す棒グラフ。 ltrは、デスクトップページの32％とモバイルページの40％で使用されています。 rtlは、デスクトップページの32％とモバイルページの36％で使用されています。</div>
  <figcaption id="fig14-caption">図14.方向の値の人気。</figcaption>
</figure>

## タイポグラフィ

### ページごとのWebフォント

WebページにいくつのWebフォントをロードしていますか：0？　10？　1ページあたりのWebフォントの中央値は3です！

<figure>
  <a href="/static/images/2019/css/fig15.png">
    <img src="/static/images/2019/css/fig15.png" alt="図15.ページごとにロードされるWebフォントの数の分布。" aria-labelledby="fig15-caption" aria-describedby="fig15-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1453570774&amp;format=interactive">
  </a>
  <div id="fig15-description" class="visually-hidden">ページごとにロードされるWebフォントの数の分布。デスクトップでは、10、25、50、75、および90パーセンタイルは0、1、3、6、および9です。これは、75パーセンタイルと90パーセンタイルで1つ少ないフォントであるモバイル配布よりわずかに高くなっています。</div>
  <figcaption id="fig15-caption">図15.ページごとにロードされるWebフォントの数の分布。</figcaption>
</figure>

### 人気のあるフォントファミリー

ページあたりのフォントの総数の問い合わせに対する自然な回答は、次のとおりです。それらはどのフォントですか?!　デザイナーは、あなたの選択が人気のあるものと一致しているかどうかを確認できるようになります。

<figure>
  <a href="/static/images/2019/css/fig16.png">
    <img src="/static/images/2019/css/fig16.png" alt="図16.上位のWebフォント。" aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="450" data-width="600" data-height="450" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1883567922&amp;format=interactive">
  </a>
  <div id="fig16-description" class="visually-hidden">最も人気のあるフォントの棒グラフ。デスクトップページの中で、Open Sans（24％）、Roboto（15％）、Montserrat（5％）、Source Sans Pro（4％）、Noto Sans JP（3％）、Lato（3％）です。モバイルで最も顕著な違いは、Open Sansが時間の22％で使用され（24％から減少）、Robotoが時間の19％で使用される（15％から増加）ことです。</div>
  <figcaption id="fig16-caption">図16.上位のWebフォント。</figcaption>
</figure>

ここではOpen Sansが大きな勝者であり、CSSの`@font-family`宣言の4分の1近くがそれを指定しています。私たちは間違いなく、プロジェクトでOpen Sansを使用しています。

また、デスクトップ導入とモバイル導入の違いに注目することも興味深いです。たとえば、モバイルページはデスクトップよりもOpen Sansの使用頻度がわずかに低いです。一方、デスクトップはRobotoを少しだけ頻繁に使用します。

### フォントサイズ

これは楽しいものです。ユーザーがページ上にあると感じるフォントサイズの数をユーザーに尋ねた場合、通常5または10未満の数値が返されるからです。デザインシステムでフォントサイズはいくつありますか？　Webに問い合わせたところ、中央値はモバイルで40、デスクトップで38でした。タイプランプの配布に役立つカスタムプロパティや再利用可能なクラスの作成について真剣に考える時間になるかもしれません。

<figure>
  <a href="/static/images/2019/css/fig17.png">
    <img src="/static/images/2019/css/fig17.png" alt="図17.ページごとの異なるフォントサイズの数の分布。" aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1695270216&amp;format=interactive">
  </a>
  <div id="fig17-description" class="visually-hidden">ページごとの異なるフォントサイズの分布を示す棒グラフ。デスクトップページの10、25、50、75、および90パーセンタイルは、8、20、40、66、および92のフォントサイズです。デスクトップディストリビューションは、75パーセンタイルでモバイルとは異なり、7〜13の異なるサイズで大きくなっています。</div>
  <figcaption id="fig17-caption">図17.ページごとの異なるフォントサイズの数の分布。</figcaption>
</figure>

## 間隔

### マージン

マージンとは、自分の腕を押し出すときに要求するスペースのような要素の外側のスペースです。これは多くの場合、要素間の間隔のように見えますが、その効果に限定されません。 Webサイトまたはアプリでは、間隔はUXとデザインで大きな役割を果たします。スタイルシートにどのくらいのマージン間隔コードが入るか見てみましょうか？

<figure>
  <a href="/static/images/2019/css/fig18.png">
    <img src="/static/images/2019/css/fig18.png" alt="図18.ページごとの異なるマージン値の数の分布。" aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=4233531&amp;format=interactive">
  </a>
  <div id="fig18-description" class="visually-hidden">ページごとの明確なマージン値の分布を示す棒グラフ。デスクトップページの場合、10、25、50、75、および90パーセンタイルは、12、47、96、167、および248の異なるマージン値です。デスクトップディストリビューションは75パーセンタイルでモバイルとは異なり、12〜31の異なる値で小さくなっています。</div>
  <figcaption id="fig18-caption">図18.ページごとの異なるマージン値の数の分布。</figcaption>
</figure>

かなりたくさんのようです！　デスクトップページの中央値には96の異なるマージン値があり、モバイルでは104です。これにより、デザインに多くのユニークな間隔が生まれます。あなたのサイトにいくつのマージンがあるか​​知りたい？　この空白をすべて管理しやすくするにはどうすればよいですか？

### 論理プロパティ

<figure>
  <div class="big-number">0.6%</div>
  <figcaption>図19.論理プロパティを含むデスクトップおよびモバイルページの割合。</figcaption>
</figure>

`margin-left`と`padding-top`の覇権は限られた期間であり、書き込み方向に依存しない、連続した論理プロパティ構文によりまもなく補完されると推定します。楽観的ではありますが、現在の使用量は非常に低く、デスクトップページでの使用量は0.67％です。私たちにとって、これは業界として開発する必要がある習慣の変化のように感じられますが、新しいシンタックスを使用するために新しい開発者を訓練することを願っています。

### z-index

CSSの`z-index`を使用して、垂直の階層化またはスタックを管理できます。私たちは、人々が自分のサイトでどれだけ多くの価値を使用しているかに興味がありました。 `z-index`が受け入れる範囲は理論的には無限であり、ブラウザーの可変サイズの制限によってのみ制限されます。それらすべてのスタック位置が使用されていますか？　では見てみよう！

<figure>
  <a href="/static/images/2019/css/fig20.png">
    <img src="/static/images/2019/css/fig20.png" alt="図20.ページごとの個別の`z-index`値の数の分布。" aria-labelledby="fig20-caption" aria-describedby="fig20-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1320871189&amp;format=interactive">
  </a>
  <div id="fig20-description" class="visually-hidden">ページごとの異なるz-index値の分布を示す棒グラフ。デスクトップページの場合、10、25、50、75、および90パーセンタイルは、1、7、16、26、および36の異なるz-index値です。デスクトップの分布はモバイルよりもはるかに高く、90パーセンタイルで16もの異なる値があります。</div>
  <figcaption id="fig20-caption">図20.ページごとの個別の<code>z-index</code>値の数の分布。</figcaption>
</figure>

### 人気のあるz-index値

私たちの仕事の経験から、9の任意の数が最も一般的な選択肢であると思われました。可能な限り少ない数を使用するように教えたにもかかわらず、それは共同の基準ではありません。じゃあ何ですか?!　人々が一番上のものを必要とする場合、最も人気のあるZインデックス番号は何ですか？　飲み物を置いてください。これはあなたがそれを失うかもしれないので十分面白いです。

<figure>
  <a href="/static/images/2019/css/fig21.png">
    <img src="/static/images/2019/css/fig21.png" alt="図21.最も頻繁に使用される`z-index`値。" aria-labelledby="fig21-caption" aria-describedby="fig21-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1169148473&amp;format=interactive">
  </a>
  <div id="fig21-description" class="visually-hidden">デスクトップとモバイルの両方について、すべての既知のz-index値とそれらが使用された回数の散布図。 1と2が最も頻繁に使用されますが、残りの人気のある値は数百桁の数字まで桁違いに爆発します：10、100、1,000など。</div>
  <figcaption id="fig21-caption">図21.最も頻繁に使用される<code>z-index</code>値。</figcaption>
</figure>

<figure>
  <div class="big-number" style="word-break: break-all; font-size: 24px">999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 !important</div>
  <figcaption>図21.最も頻繁に使用される<code>z-index</code>値。</figcaption>
</figure>

## デコレーション

### フィルター

フィルターは、ブラウザーが画面に描画するピクセルを変更するための楽しくて素晴らしい方法です。これは、適用対象の要素、ノード、またはレイヤーのフラットバージョンに対して実行される後処理効果です。 Photoshopによって使いやすくなり、Instagramによって、オーダーメイドの定型化された組み合わせによって大衆がアクセスできるようになりました。それらは2012年頃から存在し、10個あります。それらを組み合わせて独自の効果を作成できます。

<figure>
  <div class="big-number">78%</div>
  <figcaption>図23. <code>フィルター</code>プロパティを持つスタイルシートを含むページの割合。</figcaption>
</figure>

スタイルシートの78％に`フィルター`プロパティが含まれていることがわかりました。その数も非常に高かったので、少し怪しいように思えたので、私たちは深掘りしてその高い数を説明しようとしました。正直に言って、フィルターはきちんとしていますが、すべてのアプリケーションやプロジェクトに組み込まれているわけではありません。しない限り！

さらなる調査の結果、[FontAwesome](https://fontawesome.com)のスタイルシートには`フィルター`の使用法と[YouTube](https://youtube.com)埋め込みが含まれていることがわかりました。そのため、非常に人気のあるいくつかのスタイルシートに便乗することで、バックドアに`フィルター`が入り込むと考えています。また、`-ms-filter`の存在も含まれている可能性があり、使用率が高くなっていると考えられます。

### ブレンドモード

ブレンドモードは、ターゲット要素のフラットバージョンに対して実行される後処理効果であるという点でフィルターに似ていますが、ピクセル収束に関係しているという点で独特です。別の言い方をすれば、ブレンドモードとは、2つのピクセルが重なり合ったときに互いに影響を与える方法です。上部または下部のどちらの要素でも、ブレンドモードがピクセルを操作する方法に影響します。 16種類のブレンドモードがあります。どのモードが最も人気かを見てみましょう。

<figure>
  <div class="big-number">8%</div>
  <figcaption>図24. <code>*-blend-mode</code>プロパティを持つスタイルシートを含むページの割合。</figcaption>
</figure>

全体的に、ブレンドモードの使用はフィルターの使用よりもはるかに低いですが、適度に使用されていると見なすのに十分です。

Web年鑑の今後のエディションでは、ブレンドモードの使用法にドリルダウンして、開発者が使用している正確なモード（乗算、スクリーン、カラーバーン、ライトなど）を把握することをお勧めします。

## アニメーション

### トランジション

CSSには、トランジションのこれらの値の方法に関する単一のルールを記述するだけで簡単に使用できるこの素晴らしい補間機能があります。アプリの状態を管理するためにCSSを使用している場合、タスクを実行するためにトランジションを使用する頻度はどれくらいですか？　Webに問合せしましょう！

<figure>
  <a href="/static/images/2019/css/fig25.png">
    <img src="/static/images/2019/css/fig25.png" alt="図25.ページごとの遷移数の分布。" aria-labelledby="fig25-caption" aria-describedby="fig25-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=419145172&amp;format=interactive">
  </a>
  <div id="fig25-description" class="visually-hidden">ページごとのトランジションの分布を示す棒グラフ。デスクトップページの場合、10、25、50、75、および90パーセンタイルは、0、2、16、49、および118です。デスクトップの分布はモバイルよりもはるかに低く、90パーセンタイルで最大77のトランジション。</div>
  <figcaption id="fig25-caption">図25.ページごとの遷移数の分布。</figcaption>
</figure>

それはかなり良いです！　私たちは`animate.css`を含めるべき人気のあるライブラリと考えていました。これはたくさんのトランジションアニメーションをもたらしますが、人々がUIのトランジションを検討しているのを見るのは今でも素晴らしいことです。

### キーフレームアニメーション

CSSキーフレームアニメーションは、より複雑なアニメーションやトランジションに最適なソリューションです。これにより、効果をより明確に制御できるようになります。 1つのキーフレームエフェクトのように小さくすることも、多数のキーフレームエフェクトを堅牢なアニメーションに合成して大きくすることもできます。ページあたりのキーフレームアニメーションの数の中央値は、CSSトランジションよりもはるかに低くなっています。

<figure>
  <a href="/static/images/2019/css/fig26.png">
    <img src="/static/images/2019/css/fig26.png" alt="図26.ページごとのキーフレーム数の分布。" aria-labelledby="fig26-caption" aria-describedby="fig26-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=11848448&amp;format=interactive">
  </a>
  <div id="fig26-description" class="visually-hidden">ページごとのキーフレームの分布を示す棒グラフ。モバイルページの場合、10、25、50、75、および90パーセンタイルは、0、0、3、18、および76キーフレームです。モバイルの分布は、75パーセンタイルと90パーセンタイルで6キーフレーム分、デスクトップよりわずかに高くなっています。</div>
  <figcaption id="fig26-caption">図26.ページごとのキーフレーム数の分布。</figcaption>
</figure>

## メディアクエリ

メディアクエリを使用すると、CSSをさまざまなシステムレベルの変数にフックして、訪問ユーザーに適切に適応させることができます。これらのクエリの一部は、印刷スタイル、プロジェクタースクリーンスタイル、ビューポート/スクリーンサイズを処理できます。長い間、メディアクエリは主にビューポートの知識のために活用されていました。デザイナーと開発者は、小さな画面、大きな画面などにレイアウトを適合させることができます。その後、ウェブはますます多くの機能とクエリを提供し始めました。つまり、メディアクエリはビューポート機能に加えてアクセシビリティ機能を管理できるようになりました。

メディアクエリから始めるのに適した場所は、1ページあたりの使用数です。典型的なページが応答したいと感じるのは、いくつの瞬間やコンテキストですか？

<figure>
  <a href="/static/images/2019/css/fig27.png">
    <img src="/static/images/2019/css/fig27.png" alt="図27.ページごとのメディアクエリ数の分布。" aria-labelledby="fig27-caption" aria-describedby="fig27-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1892465673&amp;format=interactive">
  </a>
  <div id="fig27-description" class="visually-hidden">ページごとのメディアクエリの分布を示す棒グラフ。デスクトップページの場合、10、25、50、75、および90パーセンタイルは、0、3、14、27、および43キーフレームです。デスクトップ配布は、モバイル配布に似ています。</div>
  <figcaption id="fig27-caption">図27.ページごとのメディアクエリ数の分布。</figcaption>
</figure>

### 一般的なメディアクエリブレークポイントサイズ

ビューポートメディアクエリの場合、任意のタイプのCSSユニットを評価用のクエリ式に渡すことができます。以前、人々は`em`と`px`をクエリに渡していましたが、時間がたつにつれて単位が追加され、Webで一般的に見られるサイズの種類について非常に興味を持ちました。ほとんどのメディアクエリは一般的なデバイスサイズに従うと想定していますが、想定する代わりにデータを見てみましょう。

<figure>
  <a href="/static/images/2019/css/fig28.png">
    <img src="/static/images/2019/css/fig28.png" alt="図28.メディアクエリで使用される最も頻繁に使用されるスナップポイント。" aria-labelledby="fig28-caption" aria-describedby="fig28-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1353707515&amp;format=interactive">
  </a>
  <div id="fig28-description" class="visually-hidden">最も人気のあるメディアクエリスナップポイントの棒グラフ。 768pxと767pxが最も人気があり、それぞれ23％と16％です。その後、リストはすぐに削除され、992pxは6％の時間を使用し、1200pxは4％の時間を使用しました。デスクトップとモバイルの使用方法は似ています。</div>
  <figcaption id="fig28-caption">図28.メディアクエリで使用される最も頻繁に使用されるスナップポイント。</figcaption>
</figure>

上記の図28は、前提の一部が正しいことを示しています。確かに、大量のモバイル固有のサイズがありますが、そうでないものもあります。また、このチャートの範囲を超えて`em`を使用するいくつかのトリックエントリで、非常にピクセルが支配的であることも興味深いです。

### ポートレートとランドスケープの使用

人気のあるブレークポイントサイズからの最も人気のあるクエリ値は`768px`であるため、興味をそそられました。この値は、`768px`が一般的なモバイルポートレートビューポートを表すという仮定に基づいている可能性があるため、主にポートレートレイアウトへ切り替えるために使用されましたか？　そこで、ポートレートモードとランドスケープモードの使用の人気を確認するために、フォローアップクエリを実行しました。

<figure>
  <a href="/static/images/2019/css/fig29.png">
    <img src="/static/images/2019/css/fig29.png" alt="図29.メディアクエリの方向モードの採用。" aria-labelledby="fig29-caption" aria-describedby="fig29-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=295845630&amp;format=interactive">
  </a>
  <div id="fig29-description" class="visually-hidden">メディアクエリの縦向きモードと横向きモードの採用を示す棒グラフ。ページの31％は横向き、8％は縦向き、7​​％は両方を指定しています。採用は、デスクトップページとモバイルページで同じです。</div>
  <figcaption id="fig29-caption">図29.メディアクエリの方向モードの採用。</figcaption>
</figure>

興味深いことに、`ポートレート`はあまり使用されませんが、`ランドスケープ`はより多く使用されます。 `768px`はポートレートレイアウトのケースとして十分に信頼できるものであり、到達できるコストははるかに少ないと想定できます。また、デスクトップコンピューターで作業をテストしているユーザーは、ブラウザーを押しつぶすほど簡単にモバイルレイアウトを見るためにポートレートをトリガーできないと想定しています。わかりにくいですが、データは魅力的です。

### 最も人気のあるユニットタイプ

これまで見てきたメディアクエリの幅と高さでは、ピクセルはUIをビューポートに適合させることを考えている開発者にとって主要な選択単位のように見えます。ただし、これを排他的にクエリしたいので、実際に人々が使用するユニットのタイプを見てみましょう。これは私たちが見つけたものです。

<figure>
  <a href="/static/images/2019/css/fig30.png">
    <img src="/static/images/2019/css/fig30.png" alt="図30.メディアクエリスナップポイントでのユニットの採用。" aria-labelledby="fig30-caption" aria-describedby="fig30-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=305563768&amp;format=interactive">
  </a>
  <div id="fig30-description" class="visually-hidden">ピクセルを指定するメディアクエリスナップポイントの75％、emsを指定する8％、remを指定する1％を示す棒グラフ。</div>
  <figcaption id="fig30-caption">図30.メディアクエリスナップポイントでのユニットの採用。</figcaption>
</figure>

### `min-width`と`max-width`

人々がメディアクエリを書くとき、彼らは通常、特定の範囲を超えているか下にあるビューポート、またはその両方をチェックして、サイズの範囲内にあるかどうかをチェックしてるでしょうか？　ウェブに聞いてみましょう！

<figure>
  <a href="/static/images/2019/css/fig31.png">
    <img src="/static/images/2019/css/fig31.png" alt="図31.メディアクエリスナップポイントで使用されるプロパティの採用。" aria-labelledby="fig31-caption" aria-describedby="fig31-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2091525146&amp;format=interactive">
  </a>
  <div id="fig31-description" class="visually-hidden">最大幅を使用するデスクトップページの74％、最小幅を使用する70％、および両方のプロパティを使用する68％を示す棒グラフ。採用はモバイルページでも同様です。</div>
  <figcaption id="fig31-caption">図31.メディアクエリスナップポイントで使用されるプロパティの採用。</figcaption>
</figure>

ここには明確な勝者はありません。 `max-width`と`min-width`はほぼ同じように使用されます。

### printとspeech

Webサイトはデジタルペーパーのように感じますか？　ユーザーとしては、ブラウザーから印刷するだけで、そのデジタルコンテンツを物理コンテンツに変換できることが一般的に知られています。 Webサイトは、そのユースケースに合わせて変更する必要はありませんが、必要に応じて変更できます。あまり知られていないのは、ツールまたはロボットによって読み取られるユースケースでWebサイトを調整する機能です。では、これらの機能はどれくらいの頻度で活用されていますか？

<figure>
  <a href="/static/images/2019/css/fig32.png">
    <img src="/static/images/2019/css/fig32.png" alt="図32.メディアクエリのall、print、screen、およびspeechタイプの採用。" aria-labelledby="fig32-caption" aria-describedby="fig32-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=939890574&amp;format=interactive">
  </a>
  <div id="fig32-description" class="visually-hidden">「all」のメディアクエリタイプを使用するデスクトップページの35％、printを使用する46％、screenを使用する72％、およびspeechを使用する0％を示す棒グラフ。採用率は、モバイルに比べてデスクトップで約5パーセントポイント低くなっています。</div>
  <figcaption id="fig32-caption">図32.メディアクエリのall、print、screen、およびspeechタイプの採用。</figcaption>
</figure>

## ページレベルの統計

### スタイルシート

ホームページから何枚のスタイルシートを参照していますか？　アプリからはどのくらい？　モバイルとデスクトップのどちらにサービスを提供していますか？　ここに他のみんなのチャートがあります！

<figure>
  <a href="/static/images/2019/css/fig33.png">
    <img src="/static/images/2019/css/fig33.png" alt="図33.ページごとにロードされるスタイルシートの数の分布。" aria-labelledby="fig33-caption" aria-describedby="fig33-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1377313548&amp;format=interactive">
  </a>
  <div id="fig33-description" class="visually-hidden">ページごとにロードされるスタイルシートの数の分布。デスクトップとモバイルは、10、25、50、75、および90パーセンタイル（ページごとに1、3、6、12、および20のスタイルシート）を持つ同一の分布を持っています。</div>
  <figcaption id="fig33-caption">図33.ページごとにロードされるスタイルシートの数の分布。</figcaption>
</figure>

### スタイルシート名

スタイルシートの名前は何ですか？　あなたのキャリアを通して一貫した名前にしましたか？　ゆっくり収束したか、一貫して発散しましたか？　このチャートは、ライブラリの人気を少し垣間見せています。また、CSSファイルの一般的な名前を垣間見ることもできます。

<figure>
  <table>
    <thead>
      <tr>
        <th>スタイルシート名</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>style.css</td>
        <td class="numeric">2.43%</td>
        <td class="numeric">2.55%</td>
      </tr>
      <tr>
        <td>font-awesome.min.css</td>
        <td class="numeric">1.86%</td>
        <td class="numeric">1.92%</td>
      </tr>
      <tr>
        <td>bootstrap.min.css</td>
        <td class="numeric">1.09%</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td>BfWyFJ2Rl5s.css</td>
        <td class="numeric">0.67%</td>
        <td class="numeric">0.66%</td>
      </tr>
      <tr>
        <td>style.min.css?ver=5.2.2</td>
        <td class="numeric">0.64%</td>
        <td class="numeric">0.67%</td>
      </tr>
      <tr>
        <td>styles.css</td>
        <td class="numeric">0.54%</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td>style.css?ver=5.2.2</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td>main.css</td>
        <td class="numeric">0.43%</td>
        <td class="numeric">0.39%</td>
      </tr>
      <tr>
        <td>bootstrap.css</td>
        <td class="numeric">0.40%</td>
        <td class="numeric">0.42%</td>
      </tr>
      <tr>
        <td>font-awesome.css</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td>style.min.css</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>styles__ltr.css</td>
        <td class="numeric">0.38%</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>default.css</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td>reset.css</td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>styles.css?ver=5.1.3</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>custom.css</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.33%</td>
      </tr>
      <tr>
        <td>print.css</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.28%</td>
      </tr>
      <tr>
        <td>responsive.css</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>図34.最も頻繁に使用されるスタイルシート名。</figcaption>
</figure>

それらすべてのクリエイティブなファイル名を見てください！　スタイル、スタイル、メイン、デフォルト、すべて。しかし目立ったのは、あなたはわかりますか？ `BfWyFJ2Rl5s.css`は、最も人気のある4位になります。少し調べてみましたが、Facebookの「いいね」ボタンに関連していると思われます。そのファイルが何であるか知っていますか？　話を聞きたいので、コメントを残してください。

### スタイルシートのサイズ

これらのスタイルシートはどれくらいの大きさですか？　CSSのサイズは心配する必要がありますか？　このデータから判断すると、CSSはページ膨張の主な攻撃者ではありません。

<figure>
  <a href="/static/images/2019/css/fig35.png">
    <img src="/static/images/2019/css/fig35.png" alt="図35.ページごとにロードされるスタイルシートのバイト数（KB）の分布。" aria-labelledby="fig35-caption" aria-describedby="fig35-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2132635319&amp;format=interactive">
  </a>
  <div id="fig35-description" class="visually-hidden">ページごとにロードされるスタイルシートのバイト数の分布。デスクトップページの10、25、50、75、および90パーセンタイルは、8、26、62、129、および240KBです。デスクトップ配布は、モバイル配布より5〜10KBわずかに高くなっています。</div>
  <figcaption id="fig35-caption">図35.ページごとにロードされるスタイルシートのバイト数（KB）の分布。</figcaption>
</figure>

Webサイトが各コンテンツタイプにロードするバイト数の詳細については、[ページウェイト](./page-weight)の章を参照してください。

### ライブラリ

新しいプロジェクトをスタートする事にCSSライブラリへ手を出すのは一般的で、人気があり、便利で強力です。あなたはライブラリに手を伸ばす人ではないかもしれませんが、私たちは2019年にウェブへ問い合わせて、どれが群を抜いているか調べました。彼らが私たちと同じように結果に驚くなら、開発者バブルがどれだけ小さいかを知る手がかりになると思います。物事は非常に人気がありますが、ウェブに問い合わせると、現実は少し異なります。

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
        <td>Bootstrap</td>
        <td class="numeric">27.8%</td>
        <td class="numeric">26.9%</td>
      </tr>
      <tr>
        <td>animate.css</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>ZURB Foundation</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>UIKit</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Material Design Lite</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Materialize CSS</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Pure CSS</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Angular Material</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Semantic-ui</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Bulma</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Ant Design</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>tailwindcss</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Milligram</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Clarity</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>図36.特定のCSSライブラリを含むページの割合。</figcaption>
</figure>

このチャートは、[Bootstrap](https://getbootstrap.com/)がプロジェクトを支援するために知っておくべき貴重なライブラリであることを示唆しています。支援する機会があるすべてを見てください！　すべてのサイトがCSSフレームワークを使用しているわけではないので、これはポジティブなシグナルチャートにすぎないことも注目に値します。100％に達することはありません。すべてのサイトの半分以上が、既知のCSSフレームワークを使用していません。とても面白いですよね！

### リセットユーティリティ

CSSリセットユーティリティは、ネイティブWeb要素のベースラインを正規化または作成することを目的としています。あなたが知らなかった場合、各ブラウザはすべてのHTML要素に対して独自のスタイルシートを提供し、それら要素の外観、動作について独自の決定を下すことができます。リセットユーティリティはこれらのファイルを調べ、共通点を見つけた（もしくは見つけなかった）ため、開発者が1つのブラウザーでスタイルを設定し、別のブラウザーでも同じように見える合理的な自信を持たせるため、相違点を解決しました。

それで、どれだけのサイトがそれを使っているかを見てみましょう！　彼らの存在はかなり理にかなっているように思えるので、何人の人々が彼らの戦術に同意し、彼らのサイトでそれらを使用しますか？

<figure>
  <a href="/static/images/2019/css/fig37.png">
    <img src="/static/images/2019/css/fig37.png" alt="図37. CSSリセットユーティリティの採用。" aria-labelledby="fig37-caption" aria-describedby="fig37-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1318910215&amp;format=interactive">
  </a>
  <div id="fig37-description" class="visually-hidden">3つのCSSリセットユーティリティの採用を示す棒グラフ：Normalize.css（33％）、Reset CSS（3％）、およびPure CSS（0％）。デスクトップページとモバイルページで採用に違いはありません。</div>
  <figcaption id="fig37-caption">図37. CSSリセットユーティリティの採用。</figcaption>
</figure>

Webの約3分の1が[`normalize.css`](https://necolas.github.io/normalize.css)を使用していることがわかります。これは、リセットよりもタスクへのより穏やかなアプローチと考えることができます。少し詳しく見てみると、Bootstrapには`normalize.css`が含まれていることがわかりました。 `normalize.css`がBootstrapよりも多く採用されていることも注目に値するので、それを単独で使用する人がたくさんいます。

### `@supports`と`@import`

CSS `@supports`は、ブラウザが特定のプロパティと値の組み合わせが有効であると解析されたかどうかをチェックし、チェックがtrueを返した場合にスタイルを適用する方法です。

<figure>
  <a href="/static/images/2019/css/fig38.png">
    <img src="/static/images/2019/css/fig38.png" alt="図38. CSS「@」ルールの人気" aria-labelledby="fig38-caption" aria-describedby="fig38-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1739611283&amp;format=interactive">
  </a>
  <div id="fig38-description" class="visually-hidden">@importおよび@supports "@"ルールの人気を示す棒グラフ。デスクトップでは、ページの28％で@importが使用され、31％で@supportsが使用されます。モバイルでは、ページの26％で@importが使用され、29％で@supportsが使用されます。</div>
  <figcaption id="fig38-caption">図38. CSS「@」ルールの人気</figcaption>
</figure>

2013年にほとんどのブラウザで`@supports`が実装されたことを考慮すると、大量の使用と採用が見られることはそれほど驚くことでありません。ここでは、開発者のマインドフルネスに感銘を受けています。これは思いやりのあるコーディングです！　すべてのWebサイトの30％は、使用する前にディスプレイ関連のサポートをチェックしています。

これの興味深いフォローアップは、`@imports`より`@supports`の使用が多いことです！　私たちはそれを期待していませんでした！ `@import`は1994年以来ブラウザに存在しています。

## 結論

ここには、データマイニングするための非常に多くのものがあります！　結果の多くは私たちを驚かせました、そして同様にあなたも驚いたことを願っています。この驚くべきデータセットにより、要約が非常に楽しくなり、結果の一部がそうである理由を追い詰めたいかどうかを調査するための多くの手がかりと追跡の跡が残されました。

どの結果が最も驚くべきものでしたか？
どの結果を使用して、コードベースにすばやくクエリを移動しますか？

これらの結果からの最大のポイントは、スタイルシートのパフォーマンス、乾燥、スケーラビリティの点で、カスタムプロパティが予算に見合った価値を提供することだと感じました。インターネットのスタイルシートを再度スクラブし、新しいデータムと挑発的なチャートの扱いを探しています。クエリ、質問、アサーションを含むコメントで[@una](https://twitter.com/una)または[@argyleink](https://twitter.com/argyleink)に連絡してください。私たちはそれらを聞きたいです！
