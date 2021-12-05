---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: メディア
description: 画像ファイルのサイズとフォーマット、レスポンシブ・イメージ、クライアント・ヒント、レイジー・ローディング、アクセシビリティ、ビデオなど、2020年版Web Almanacのメディアの章です。
authors: [tpiros, bseymour, eeeps]
reviewers: [nhoizey, colinbendell, dougsillars, Navaneeth-akam]
analysts: [smatei]
editors: [tunetheweb]
translators: [ksakae1216]
tpiros_bio: Tamas Pirosは、<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のDeveloper Experience Engineerであり、Google Developer Expertであり、<a hreflang="en" href="https://fullstacktraining.com">Full Stack Training</a>を運営するテクニカルインストラクターです。
bseymour_bio: Ben Seymourは、<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のDynamic Media & Content Specialistであり、<a hreflang="en" href="http://responsiveimag.es/">Practical Responsive Images</a>の著者であり、<a hreflang="en" href="https://storyus.life/">Storyus</a>と<a hreflang="en" href="https://haktive.com/">Haktive</a>の共同設立者です。
eeeps_bio: Eric Portisは、<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のWeb Platform Advocateです。
discuss: 2041
results: https://docs.google.com/spreadsheets/d/1SZGpCsTT0u1MFBrxed7HA9FLAloL1dS8ZIng986LvS8/
featured_quote: 画像やビデオは、生来の感情的な反応を引き起こすことができる、もっとも強力なペアリング＆コロン、インスタント・コミュニケーションの可能性を私たちに提供します。しかし、Webページの負担にならないよう、配慮された実装技術が必要です。
featured_stat_1: 84.64%
featured_stat_label_1: モバイルの`<Picture>`要素でのWebPの使用について
featured_stat_2: 40.26%
featured_stat_label_2: 全画像に占めるJPG画像の割合
featured_stat_3: 57.22%
featured_stat_label_3: デスクトップの動画要素にautoplay属性をつける
---

## 序章

今日、私たちはビジュアルウェブの世界に生きており、メディアがウェブサイトの魂を提供しています。Webサイトでは画像や動画を使って情報を提供したり、楽しませたりする視覚的なストーリーを伝え、オーディエンスを惹きつけています。本章では、私たちがウェブ上で画像や動画をどのように使っているか（場合によっては誤用しているか）を分析します。

## イメージ

"百聞は一見にしかず "と言いますが、バイト換算すると一桁も二桁も高いことが多いのです。

画像は、瞬時のコミュニケーションと、生来の感情的な反応を引き起こすことができるという、もっとも強力な組み合わせです。しかし、画像はテキストに比べてはるかに重いため、ユーザー体験の妨げにならないよう配慮した実装が必要です。ここでは、モダンブラウザの機能がどの程度活用されているかを見てみましょう。

### 画像のレスポンシブHTMLマークアップ

JavaScriptを使ってメディアを埋め込むアプローチは無数にありますが、私たちはさまざまな形のHTMLマークアップが継続的に利用されていることに興味を持ちました。`<picture>`要素や、`srcset`属性、`sizes`属性など、いくつかの*responsive images*のアプローチは、2014年にはじめて紹介されて以来、支持が高まっています。

#### Srcset

`srcset`属性は、ユーザーエージェントが候補リストから読み込むのに最適なメディアアセットの決定を試みることを可能にします。

たとえば、以下のように。

```html
<img srcset="images/example_3x.jpg 3x, images/example_2x.jpg 2x"
     src="images/example.jpg" alt="..." />
```

全ページの約26.5%が`srcset`を含むようになりました。

ユーザーエージェントが選択できる画像の数は、2つの主要なパフォーマンス要因に直接影響を与えます。

1. <a hreflang="en" href="https://cloudfour.com/thinks/responsive-images-101-part-9-image-breakpoints/">イメージブレイクポイント</a>（パフォーマンスバジェットを満たすために）
2. キャッシングの効率化

画像候補の数が少ないほど、アセットをキャッシュする可能性が高くなります。また、CDNを使用している場合は、クライアントの最寄りのエッジノードで利用できる可能性が高くなります。しかし、メディアのサイズの違いが大きければ大きいほど、デバイスやコンテキストに適していないメディアを提供してしまう可能性が高くなります。

##### Srcset：画像候補の数量

{{ figure_markup(
  image="srcset-number-of-candidates.png",
  caption="Srcset候補者数",
  description="デスクトップとモバイルの候補者数を示す棒グラフ。ほとんどのページで候補者数が1～3人（デスクトップ58.82％、モバイル60.01％）となっており、特に1～5人になると（デスクトップ82.79％、モバイル83.52％）となります。その後の落ち込みは激しく、5～10人の候補者はデスクトップで13.12％、モバイルで12.42％にとどまりました。10-15人の候補者は、デスクトップで1.96%、モバイルでは1.87%、15-20人の候補者は、デスクトップで0.55%、モバイルでは0.53%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=761924614&format=interactive",
  sheets_gid="1848992988",
  sql_file="image_srcset_candidates.sql"
  )
}}

先に述べたキャッシュの非効率性に加えて、次元的なバリエーションの数が増えると、使用するメディアパイプラインやサービスの複雑さと、必要なメディアストレージの両方が増加します。

このデータを見る際には、いくつかのプラットフォーム（<a hreflang="en" href="https://make.wordpress.org/core/2015/11/10/responsive-images-in-wordpress-4-4/">WordPress</a>など）では、多数のサイトに影響を与える自動化されたアプローチを使用していることに注意してください。

##### Srcset：記述子

候補リストをユーザエージェントに提供する際、候補画像に注釈を付けるための2つの仕組みがあります。それは、`x`記述子と`w`記述子です。

`x`記述子は、特定のリソースのデバイスピクセルの比率を記述します。たとえば、`2x`の記述子は、特定の画像リソースが各軸の2倍のサイズ（4倍のピクセルを含む）で、`window.devicePixelRatio`が`2`のデバイスに適していることを示します。同様に、`3x`の記述子は、9倍のピクセル数を意味し、これはもちろん、かなりのペイロードを意味します。

```html
<img srcset="images/example_3x.jpg 3x, images/example_2x.jpg 2x"
     src="images/example.jpg" alt="..." />
```

`w`記述子は、候補者のピクセル幅を記述するもので、適切な画像を選択するために使用される`sizes`属性と一緒になっています。

```html
<img srcset="images/example_small.jpg 600w, images/example_medium.jpg 1400w, images/example_large.jpg 2400w"
     sizes="100vw"
     src="images/example_fallback.jpg" alt="..." />
```

どちらの方法でも、ユーザーエージェントは、最適な画像候補を評価する際に、現在のデバイスのピクセル比を数学的に考慮できます。

{{ figure_markup(
  image="srcset-descriptor-usage.png",
  caption="Srcset記述子の使い方。",
  description="デスクトップとモバイルのページおよび画像における srcset 記述子の使用状況を示す棒グラフ。デスクトップページの4.90%、モバイルページの5.15%が記述子xを使用しているのに対し、記述子wはデスクトップページの21.37%、モバイルの21.33%となっています。一方、すべての画像を見ると、デスクトップ画像の12.67%、モバイル画像の12.80%が記述子xを使用しているのに対し、記述子wはデスクトップの21.37%、モバイルの21.33%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1336533401&format=interactive",
  sheets_gid="1370415291",
  sql_file="image_srcset_descriptor.sql"
  )
}}

レスポンシブイメージの初期には、一部のブラウザは`x`記述子しかサポートしていませんでしたが、現在は明らかに`w`記述子がもっとも好まれています。

寸法ごとに間隔をあけて画像候補を選択するのが一般的ですが（720px、1200px、1800pxなど、あらかじめ選択された幅のセットですべての画像をレンダリングする）、より直線的なペイロードステップを与えるアプローチもあります（たとえば、50kbの差がある一連のリソース）。<a hreflang="en" href="https://www.responsivebreakpoints.com/">Responsive Image Breakpoints Generator</a>のようなツールは、これを容易にするための役立ちます。

#### サイズ

`sizes`属性がないと、ユーザーエージェントは、画像がビューポートの幅いっぱいに配置されているという最悪のケースを想定して計算を行います。この属性があれば、ブラウザは画像の実際のレイアウトサイズについてより多くの情報を得ることができ、より適切な選択をできます。

たとえば、以下のように。

```html
<img sizes="(min-width: 640px) 50vw, 100vw"
     srcset="images/example_small.jpg 600w, images/example_medium.jpg 1400w, images/example_large.jpg 2400w"
     src="images/example_fallback.jpg" alt="..." />
```

{{ figure_markup(
  image="srcset-sizes-usage.png",
  caption="srcsetでのサイズの使用。",
  description="積み重ねた棒グラフによると、デスクトップではsrcset画像の65.35%がsizesを使用し、残りの34.65%は使用していません。モバイルでは、64.95%が使用し、残りの35.05%が使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=496958447&format=interactive",
  sheets_gid="768487310",
  sql_file="image_srcset_sizes.sql"
  )
}}

2020年のデータでは、`srcset`を使用しているサイトの約35%が`sizes`と組み合わせていませんでした。ブラウザは喜んで`sizes="100vw"`のデフォルトに戻りますが、この属性をオフにしておくと、<a hreflang="en" href="https://alistapart.com/blog/post/article-update-dont-rely-on-default-sizes/">技術的に正しくありません</a>。この見落としにより、もっとも適切な画像候補を決定する数学に欠陥があり、しばしば不必要に大きな画像がリクエストされてしまうケースが定期的に発生しています。

この件について多くの人に聞いたところ、`sizes`は正しく弾力的な方法で実装するのがとくに難しいそうです。これは、（CSSで管理・決定される）レイアウトと、（HTMLの）レスポンシブ・イメージ・マークアップとの間で、リソースを超えた整合性を確保する必要があるためです。

#### 写真

`srcset`や`sizes`は、ビューポートやデバイス、レイアウトに適した寸法の画像をブラウザに提供するためのツールですが、`<picture>`要素は、より効果的な画像フォーマットの活用や「アートディレクション」の検討など、より洗練されたメディア戦略を提供します。

{{ figure_markup(
  image="use-of-picture.png",
  caption="`<picture>`の使用。",
  description="積み重ねた棒グラフによると、デスクトップでは19.30%のページが`<picture>`を使用しており、80.70%が使用していません。モバイルでも同じように、18.54%が使用し、81.46%が使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=416496535&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

現在では、約19%のページで`<picture>`要素を使用して、少なくとも1つの画像を提供しています。

##### 写真：フォーマット切り替え

バックエンドのロジックを使って、1つの画像URLから自動フォーマット切り替えを行うことができるサービスや画像CDNもありますが、同様の動作をマークアップだけで実現することができるのは、`<picture>`要素です。

```html
<picture>
    <source type="image/webp" srcset="images/example.webp" />
    <img src="images/example.jpg" alt="..." />
</picture>
```

これを提供するフォーマットの数に分解します。

{{ figure_markup(
  image="picture-number-of-formats.png",
  caption="`<picture>`フォーマットの数。",
  description="画像使用時のフォーマット数を示す棒グラフ。デスクトップでは68.01％、モバイルでは68.03％のページが1つのフォーマットを使用しています。2つのフォーマットはそれぞれ23.78％と23.78％、3つのフォーマットは7.00％と6.97％、4つ以上のフォーマットはそれぞれ1.21％と1.22％のページでしか使われていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1963933588&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

フォーマットの切り替えに`<picture>`を使用しているページのうち、約68%が、デフォルトとして機能する`<img src>`に加えて、単一のタイプのバリエーションを提供しています。

{{ figure_markup(
  image="picture-format-usage-by-type.png",
  caption="タイプ別の写真フォーマットの使用状況",
  description="画像タイプ別の画像フォーマットの使用状況を示す棒グラフ。デスクトップではWebPが83.29％（モバイルでは84.64％）と圧倒的に多く使われています。次いでPNGが18.18％と17.46％、JPGが4.84％と4.83％、Gifが0.53％と0.53％で、AVIFはいずれのクライアントでも0を超えていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=775091522&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

`<source>`の要素では、WebPが圧倒的に多く、次いでPNG、JPGは`<picture>`の4.83%に過ぎないことがわかります。

<p class="note">なお、当社のクローラーはWebPをサポートしているChromeでクロールしていますが、サポートしていない他のブラウザを使用している場合には、異なる結果が表示されます。</p>

以下は、複数のフォーマットバリエーションを提供するために使用できるマークアップ構文の例です。

```html
<picture>
  <source type="image/avif" srcset="images/example.avif" />
  <source type="image/webp" srcset="images/example.webp" />
  <source type="image/jp2" srcset="images/example.jp2" />
  <source type="image/vnd.ms-photo"  srcset="images/example.jxr" />
  <img src="images/example.jpg" alt="説明" />
</picture>
```

ユーザーエージェントは、ポジティブマッチした最初のものを効果的に選択するため、ここでの順序が重要になります。

`<picture>`でフォーマットを切り替えているページのうち、83%がWebPをフォーマットのバリエーションの1つとして提供しており、ブラウザのサポートが拡大していることも関係しています。

ブラウザ間のフォーマットサポートは、移動祝祭日のようなものです。WebPは現在、より広範にサポートされています。

- WebP: <a hreflang="en" href="https://caniuse.com/webp">90%のカバー率</a> (Edge, Firefox, Chrome, Opera, Android)
- JPEG 2000: <a hreflang="en" href="https://caniuse.com/jpeg2000">18.5%のカバー率</a> (Safari)
- JPEG XR: <a hreflang="en" href="https://caniuse.com/jpegxr">1.7%のカバー率</a> (IE)
- AVIF: <a hreflang="en" href="https://caniuse.com/avif">25%のカバー率</a> (Chrome, Opera)

代替フォーマットのセットを構築する際、作者は圧縮性能に加えて機能も考慮しなければなりません。たとえば、画像に透明度がある場合、`img src`に指定する「最低公倍数」としてはPNGが良いでしょう。その上で、WebPやJPEG2000、AVIFなど、透明度をサポートする次世代フォーマットを含む1つ以上の`<source>`要素を使用できます。

同様に、アニメーションGIFの上に、アニメーションWebPや、ミュート、ループ、自動再生のMP4を重ねることも検討してみてください（ただし動画と画像を混在させることはマークアップのアプローチやメディア処理の必要性に影響します）。

フォーマットスイッチを導入する際には、3つの観点から検討する必要があります。

- ブラウザのフォーマットがランドスケープに対応していること
- サイトのメディアパイプライン：必要なメディアをさまざまなフォーマットで作成するためのプロセス
- どのフォーマットが提供されていて、いつ選択するかをブラウザに伝えるためのマークアップの実装

いくつかのダイナミックメディアサービスや画像CDNは、この作業を自動化し刻々と変化するブラウザフォーマットのサポート状況を追跡し、同期させるよう努力することで、この作業を大幅に簡素化できます。

<p class="note">注：ChromeでAVIFがサポートされたのはバージョン85（2020年8月下旬リリース）からですが、このアルマナックのデータは主にそれ以前のものです。しかし、2020年11月初旬のより最近のデータにアドホッククエリを実行すると、数万件のAVIFリクエストが表示されます。</p>

##### 写真：メディアアートディレクション

`<picture>`要素が提供するメディアの *アートディレクション* 機能により、これまでタイプやレイアウトをデザインする際に楽しんできた、ビューポートに依存した高度なメディア操作が可能になります。

たとえば、アスペクト比が非常に広くて短いランドスケープ指向のメディア（バナーなど）が、狭いポートレート指向のモバイルレイアウトに押し込まれた場合、どれほどうまく機能しないかを考えてみてください。メディアクエリに基づいて画像のトリミングやコンテンツを調整する機能は、十分に活用されていないと私たちは考えています。

この例では、提供されるメディアのアスペクト比を、正方形（1:1）から4:3、最終的にはビューポートの幅に応じて16:9に変更し、メディアのために利用可能なスペースを最大限に活用するように努めています。

```html
<picture>
  <source media="(max-width: 780px)"
          srcset="image/example_square.jpg 1x, image/example_square_2x.jpg 2x" />
  <source media="(max-width: 1400px)"
          srcset="image/example_4_3_aspect.jpg 1x, image/example_4_3_aspect_2x.jpg 2x" />
  <source srcset="image/example_16_9_aspect.jpg 1x, image/example_16_9_aspect_2x.jpg 2x"/>
  <img src="image/example_fallback.jpg" alt="..." />
</picture>
```

##### 写真：方向転換

データによると、`<picture>`を使用しているページのうち、オリエンテーションを利用しているのは1%弱に過ぎませんが、ウェブサイトのデザイナーや開発者にとっては、さらに検討すべき分野であると感じています。

{{ figure_markup(
  image="picture-usage-of-orientation.png",
  caption="`<picture>`オリエンテーションの使用方法。",
  description="デスクトップページの0.93％、モバイルページの0.91％が、`<picture>`のを向きを変えて使用していることを示す棒グラフ。デスクトップで0.59%、モバイルでは0.60%の`<picture>`がオリエンテーションを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=56906843&format=interactive",
  sheets_gid="283790776",
  sql_file="picture_orientation.sql"
  )
}}

モバイルデバイスのビューポートは小さく、狭く、手の中でポートレートモードからランドスケープモードにするのも簡単です。方向指定のメディアクエリには、あまり活用されていない興味深い可能性があります。

構文の例

```html
<picture>
  <source srcset="images/example_wide.jpg"
          media="(min-width: 960px) and (orientation: landscape)">
  <source srcset="images/example_tall.jpg"
          media="(min-width: 960px) and (orientation: portrait)">
  <img src="..." alt="..." />
</picture>
```

### 画像フォーマットの有効活用

Webページでメディアを効果的に使用するには、適切な画像フォーマットとそのフォーマットが提供する機能を使用することが重要です。

#### MIMEタイプとエクステンション

拡張子の分布が多く、同じ拡張子でもさまざまな綴りがあることを確認しました（例：`jpg`vs`JPG`vs`jpeg`vs`JPEG`）。また、MIMEタイプの指定が間違っている場合もあります。たとえば、`image/jpeg`は、JPEG画像のMIMEタイプとして正しく認識されています。しかし、JPEGを使用しているページの0.02%が、間違ったMIMEタイプを指定していることがわかります。さらに、`pnj`という拡張子が28,420回使用されていて（タイプミスである可能性が高い）、そのMIMEタイムが`image/jpeg`に設定されていることがわかります。

{{ figure_markup(
  image="image-usage-by-extension.png",
  caption="拡張による画像利用",
  description="拡張子別の画像利用状況を示す棒グラフ。モバイルでもっとも利用されているフォーマットは`jpg`で40.26％、次に`png`で26.90％、続いて拡張子なしが17.44％、`gif`が6.59％、`svg`が3.13％、`ico`が1.83％、`jpeg`が1.36％となっています。デスクトップも非常に似たような使い方をしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1607248506&format=interactive",
  sheets_gid="402973893",
  sql_file="image_mimetype_ext.sql"
  )
}}

たとえば、「.jpg」が「image/webp」というMIMEタイプで配信されるなど、拡張子とMIMEタイプの間にはさらに不整合が見られますが、これらのいくつかは、オンザフライでの変換や最適化機能を備えたImage CDN配信サービスに起因する自然現象であると考えられます。

#### プログレッシブJPEG

<a hreflang="en" href="https://www.smashingmagazine.com/2018/02/progressive-image-loading-user-perceived-performance/#back-to-basis-progressive-jpegs">プログレッシブJPEG</a>はどれくらい一般的ですか？WebPageTestでは、各ページに「スコア」を付けています。これは、プログレッシブ・エンコードされたJPEGから読み込まれたすべてのJPEGバイトを合計し、プログレッシブ・エンコード*される*可能性があったJPEGバイトの合計数で割ったものです。大半（57％）のページでは、JPEGバイトの25％以下しかプログレッシブエンコードされていませんでした。これは、JPEGのプログレッシブ化が長年のベストプラクティスであり、MozJPEGのような最新のエンコーダーがデフォルトでプログレッシブにエンコードしているにもかかわらず、ダウンサイドのない圧縮節約のための大きなチャンスを示しています。

{{ figure_markup(
  image="progressive-jpeg-score.png",
  caption="プログレッシブJPEGスコア",
  description="JPEGスコアの推移を示す棒グラフ。デスクトップとモバイルの使用率はほぼ同じです。モバイルページの13.72%がスコア0未満、57.77%がスコア0～25、7.53%がスコア25～50、5.79%がスコア50～75、15.19%がスコア75～100となっています。JPEGスコアの推移を示す棒グラフ。デスクトップとモバイルの使用率はほぼ同じです。モバイルページの13.72%がスコア0未満、57.77%がスコア0～25、7.53%がスコア25～50、5.79%がスコア50～75、15.19%がスコア75～100となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1693689151&format=interactive",
  sheets_gid="1834242483",
  sql_file="score_progressive_jpeg.sql"
  )
}}

### マイクロブラウザ

次に、<a hreflang="en" href="https://24ways.org/2019/microbrowsers-are-everywhere/">マイクロブラウザ</a>の話題に移りましょう。 "link unfurlers"や"link expanders"とも呼ばれるこれらのユーザーエージェントは、ウェブページを要求し、メッセージやソーシャルメディアでリンクが共有されたときにリッチなプレビューを組み立てるために、ウェブページから断片的な情報を取得します。マイクロブラウザの*共通語*は、Facebookの<a hreflang="en" href="https://ogp.me">Open Graphプロトコル</a>であることから、Open Graphの`<meta>`タグにマイクロブラウザ向けの画像や動画が含まれているウェブページの割合を調べました。

{{ figure_markup(
  image="open-graph-image-and-video-usage.png",
  caption="オープングラフの画像や動画の使用状況",
  description="デスクトップページの33.78％、モバイルページの32.72％が画像付きOpen Graphを使用しており、デスクトップページの0.09％、モバイルページの0.10％が画像付きOpen Graphを使用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=950603216&format=interactive",
  sheets_gid="625517121",
  sql_file="meta_open_graph.sql"
  )
}}

ウェブページの3分の1は、マイクロブラウザ用のオープングラフタグで画像を含んでいます。しかし、マイクロブラウザ専用の動画を掲載しているページは全体の0.1％程度で、動画を掲載しているページのほとんどが画像も掲載しています。

マイクロブラウザで調整されたリッチなプレビューと組み合わせた、関係性のある口コミマーケティングの力は、明らかに投資する価値があります。

動画コンテンツは制作費が高く、画像に比べてウェブ上での利用が少ないため、利用率が比較的低いことは理解できます。しかし、動画はフルブラウザでなくても、リンクプレビューの中で再生や自動再生の可能な場合が多いため、エンゲージメントを高める大きなチャンスだと考えています。

{{ figure_markup(
  image="open-graph-image-type-usage.png",
  caption="オープングラフイメージタイプの使用",
  description="モバイルにおけるさまざまな画像フォーマットの使用率は、jpgが50.51％、pngが43.82％、gifが1.60％、jpegが1.78％、svgが0.66％、pnjが0.31％、png:150が0.36％、icoが0.28％、webpが0.23％と、棒グラフで示されています。デスクトップも非常に似たような数字となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=475337707&format=interactive",
  sheets_gid="758253988",
  sql_file="meta_open_image_types.sql"
  )
}}

{{ figure_markup(
  image="open-graph-video-type-usage.png",
  caption="オープングラフのビデオタイプの使用状況",
  description="棒グラフでは、デスクトップページの68.55%、モバイルページの78.57%がmp4動画形式を使用し、デスクトップページの19.75%、モバイルページの10.86%がswf形式を使用し、デスクトップページの2.64%、モバイルページの2.83%がwebm形式を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=110839067&format=interactive",
  sheets_gid="353192921",
  sql_file="meta_open_video_types.sql"
  )
}}

Open Graphプロトコルでは、画像や動画のURLは1つしか含めることができません。`<picture>`や`srcset`で提供されるようなコンテキストに応じた柔軟性はありません。そのため、作者はマイクロブラウザに送信するフォーマットを選ぶ際に、どちらかというと保守的になりがちです。マイクロブラウザ専用画像の半分はJPEG、45%はPNG、2%弱はGIFです。WebPは、マイクロブラウザ用画像の0.2%に過ぎません。

同様に、ビデオについても、大半のリソースがもっとも一般的なフォーマットで送信されています。MP4です。2番目に人気のあるフォーマットが<a hreflang="en" href="https://blog.adobe.com/en/publish/2017/07/25/adobe-flash-update.html#gs.my93m2">現在は廃止されている</a> SWFである理由は謎であり、これらがどのマイクロブラウザでも再生可能かどうかも気になるところです。

### `rel=preconnect`の使い方

メディアアセットは、ローカルに保存されることもあれば、画像CDNに保存されることもあります。アセットが最適化され、変換され、エンドユーザーに配信される方法は、使用する適切な技術に大きく依存します。別のドメインからの画像を含める場合、`<link>`要素に`rel=preconnect`属性を使用することで、ブラウザがDNS接続を必要とする前に開始する機会を与えることができます。これは比較的安価な処理ですが、このような接続の確立にかかる追加のCPU時間が他の作業を遅らせる状況も考えられます。

{{ figure_markup(
  caption="preconnectを使ったモバイルページ",
  content="8.19%",
  classes="big-number",
  sheets_gid="121764369",
  sql_file="big_non_custom_metrics.sql"
)
}}

マークアップを分析すると、デスクトップでは7.83％、モバイルでは8.19％のページで採用されていることがわかります。[リソースヒント](./resource-hints#hints-adoption)の章では、DOMを分析することで少し異なる方法を使用しており、それぞれ8.15%と8.65%という似たような、しかし少し大きな数字を得ています。

### `data:`のURLの使い方

データURL（以前はデータURIと呼ばれていました）を使用することは、開発者がHTMLの中にbase64エンコードされた画像を直接埋め込むことができる技術です。これにより、HTMLがDOMツリーに解析されるまでに画像が完全に読み込まれ、最初のペイントで画像を利用できることが事実上保証されます。しかし、バイナリのように無線で圧縮することができず、他の（おそらくより重要な）リソースの読み込みを妨げ、キャッシュを複雑にするため、base64の画像は<a hreflang="en" href="https://calendar.perfplanet.com/2020/the-dangers-of-data-uris/">アンチパターン</a>のようなものになっています。

{{ figure_markup(
  caption="データURIを利用したモバイルページ。",
  content="9.10%",
  classes="big-number",
  sheets_gid="206827357",
  sql_file="big_non_custom_metrics.sql"
)
}}

画像を表示するためにデータURLを利用しているページは9％と、それほど広くは利用されていないようです。ただし、今回調査したのは、HTMLに埋め込まれたBase64エンコードされた画像の`src`のみで、CSSに埋め込まれた背景画像などのBase64エンコードされた画像は含まれていないことに注意が必要です。

### SEOとアクセシビリティ

説明文を画像に関連付けることは、画像を見ることができない人やスクリーンリーダーを利用している人のアクセシビリティに役立つだけでなく、さまざまなコンピュータビジョンのアルゴリズムで画像の主題を理解するために使用されています。説明文は、ページの文脈の中で意味を持ち、説明している画像に関連するものでなければなりません。これらのトピックに関する詳しい情報は、[SEO](./seo)および[アクセシビリティ](./accessibility)の章に記載されています。

#### `alt`テキストの使い方

画像の`alt`属性は、画像の説明を提供するために使われます。これはスクリーンリーダーによってアナウンスされ、ビジュアルブラウザでは画像がロードされないときにも表示されます。

{{ figure_markup(
  image="image-alt-usage-by-page.png",
  caption="ページごとの画像alt使用量",
  description="デスクトップページの96.26％、モバイルページの96.04％に画像が存在することを示す棒グラフ。デスクトップページの52.5%とモバイルページの51.0%にはalt属性がなく、デスクトップページの60.4%とモバイルページの60.6%には空白のalt属性があり、デスクトップページの83.6%とモバイルページの82.1%にはaltが存在しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=2144814052&format=interactive",
  sheets_gid="885941461",
  sql_file="image_alt.sql"
  )
}}

{{ figure_markup(
  image="image-alt-usage-by-image.png",
  caption="画像ごとのalt使用量",
  description="モバイル画像の21.3%とデスクトップ画像の21.5%はalt属性がないこと、モバイル画像とデスクトップ画像の26.2%が空白のalt属性を持っていること、モバイル画像の52.5%とデスクトップ画像の52.3%がalt属性を持っていることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=71848371&format=interactive",
  sheets_gid="885941461",
  sql_file="image_alt.sql"
  )
}}

処理された全ページの約96%に`<img>`要素がありましたが、そのうち21%の画像には`alt`属性がありませんでした。52% の画像には`alt`属性がありましたが、そのうち26%は空白でした。簡単に言うと、ウェブ上の画像のうち、空白ではない`alt`属性を持つものは約4分の1しかなく、有用な説明文である`alt`テキストを持つものはそれよりもさらに少ないと思われます。

#### 図と図のキャプション

HTML5では、言語にさまざまな新しいセマンティック要素が追加されました。そのような要素の1つが`<figure>`で、これはオプションで子として`<figcaption>`要素を含むことができます。`<figcaption>`に含まれるテキストの説明は、`<figure>`の他のコンテンツと意味的にグループ化されます。

{{ figure_markup(
  image="figure-and-figcaption-usage-by-page.png",
  caption="ページごとの図と図キャプションの使用状況",
  description="デスクトップページの12.34％、モバイルページの12.16％がFigを使用しているが、Figcaptionを使用しているのはデスクトップページの1.06％、モバイルページの1.13％に過ぎないことを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=605432940&format=interactive",
  sheets_gid="2037389060",
  sql_file="big_non_custom_metrics.sql"
  )
}}

デスクトップとモバイルでも、約12%のページで`<figure>`要素が使用されていますが、約1%のページで`<figcaption>`を使用して説明文を追加していることがわかります。

## 動画

「百聞は一見にしかず」ならば、30fpsの動画1分は180万円の価値があるに違いない。

動画は、今日、視聴者と関わりを持つもっとも強力な方法のひとつです。しかし、サイトに動画を追加することは、簡単なことではありません。迷路のようなフォーマットやコーデックをナビゲートし、無数の実装方法を検討しなければなりません。しかし、ビデオのインパクトは、視覚的なインパクトとパフォーマンスへのインパクトの両方において、過大評価されることはありません。

### `<video>`要素

`<video>`要素は、ウェブ上での動画配信の中核をなすもので、単独で使用されるほか、動画配信のために段階的に強化されていくJavaScriptプレイヤーと組み合わせて使用されます。

### ソースの有無、総使用量

`<video>`要素を使ってビデオリソースを埋め込むには2つの方法があります。1つのリソースURLを要素自体の`src`属性に指定するか、または任意の数の子`<source>`要素を指定し、ブラウザは読み込めると思われるソースを見つけるまでそれを参照します。最初のクエリでは、サンプルページ全体でこれらのパターンがどのくらいの頻度で見られるかを調べます。

{{ figure_markup(
  image="video-usage-of-src-versus-source.png",
  caption="Src対Sourceのvideoの使い方。",
  description="動画にSrcを使用しているのは、デスクトップページの0.59%、モバイルページの0.49%であるのに対し、Sourceを使用しているのは、デスクトップページの1.14%、モバイルページの0.99%であることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=2100955508&format=interactive",
  sheets_gid="689453572",
  sql_file="big_non_custom_metrics.sql"
  )
}}

`<video>`の中には、`<src>`属性ではなく`<source>`という子を持つものが2倍あります。これは作者が、最低公約数的な単一のリソースをすべての人に送るのではなく、文脈に応じて異なるリソースを異なるエンドユーザーに送る機能を望んでいることを示しています（あるいは一部の視聴者により悪い、あるいは壊れた体験を与えることになります）。

また、興味深いことに、すべてのページにおいて、`<video>`要素がまったく含まれていないのは、わずか1パーセントか2パーセントであることがわかります。これは、`<img>`よりもはるかに少ないのです。

### JavaScriptプレーヤー

いくつかの一般的なプレーヤー（hls.js、video.js、Shaka Player、JW Player、Brightcove Player、Flowplayer）の存在を調べました。これらの特定のプレーヤーを使用しているページは、ネイティブの`<video>`要素を使用しているページの半分以下しかありませんでした。

{{ figure_markup(
  image="video-element-versus-javascript-player.png",
  caption="Video要素とJavaScriptプレーヤーの比較。",
  description="動画を掲載しているデスクトップページの77.88％とモバイルページの74.77％がVideo要素を、画像を掲載しているデスクトップページの28.06％とモバイルページの30.57％がJavaScript Video Playerを、画像を掲載しているデスクトップページの5.94％とモバイルページの5.34％が両方を使用していることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=202644434&format=interactive",
  sheets_gid="1489710615",
  sql_file="video_tag_and_js_player.sql"
  )
}}

video.jsなどの多くのプレイヤーが、ソース内の`<video>`要素を強化しているため、分析は少し複雑になります。検索されたプレーヤーを使用しているページのうち、`<video>`要素も含まれていたのは、わずか5～6%でした。しかし、このパターンの証拠は、`<video>`と`<source>`要素内の`type`属性の値を見ると、実際にはよりはっきりとわかります。

### タイプ別属性

{{ figure_markup(
  image="video-source-types.png",
  caption="ビデオソースの種類",
  description="モバイルにおけるビデオフォーマットの使用率は、棒グラフでは、video/mp4が64.08％、video/mp4が19.68％、video/webmが10.08％、video/oggが4.74％、video/vimeoが0.51％、video/ogvが0.37％、video/mpegが0.12％、video/movが0.09％。デスクトップも非常に似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=203419864&format=interactive",
  sheets_gid="1459916814",
  sql_file="video_source_types.sql"
  )
}}

当然のことながら、もっとも一般的なタイプの値は`video/mp4`です。しかし、次に多いのは、デスクトップ用の`タイプ`の15％、モバイル用クローラーに送信される`タイプ`の20％を占める`video/youtube`で、これは登録されたMIMEタイプではありません。これは、登録されたMIMEタイプではなく、（WordPressを含む）いくつかのプレイヤーがYouTubeの動画を埋め込む際に使用する特別な値です。さらに、Vimeoの埋め込みにも同様のパターンが見られます。

MP4とWebMは、一般的に使用されていると思われる唯一の2つのフォーマットです。これらの*コンテナ*の中でどの*コーデック*が使われているのか、またVP8、HVEC、AV1などの次世代コーデックがどれだけ普及しているのかを知ることは興味深いことです。しかし、そのような分析は、残念ながらこの記事の範囲外である。

### 動画のプリロード

{{ figure_markup(
  image="video-preload-values.png",
  caption="動画のプリロード値。",
  description="棒グラフによると動画を含むデスクトップおよびモバイルページの33%がpreloadに`none`を設定し、動画を含むデスクトップページの36%およびモバイルページの27%が`auto`を設定し、それぞれ24%と33%が`metadata`を設定し、それぞれ4%と5%がこの設定をしていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=989934821&format=interactive",
  sheets_gid="1099175973",
  sql_file="video_preload_values.sql"
  )
}}

`preload`属性は、動画をダウンロードするかどうかを示すもので、3つの値を持つことができます。`none`, `metadata`, `auto`の3つの値を持つことができます（空欄のままだと`auto`の値が仮定されることに注意してください）。4.81% のページが`<video>`要素を持ち、そのうち45.37%が`preload`属性を持っていることがわかります。モバイルでの数字は若干異なり、`<video>`要素を持つページは3.59%のみで、そのうち43.38%に`preload`属性があります。

### オートプレイとミュート

{{ figure_markup(
  image="video-autoplay-and-muted-usage.png",
  caption="動画の自動再生とミュートの使用",
  description="動画のあるデスクトップページの57.22%、モバイルページの53.86%が`自動再生`、56.36%と53.41%が`ミュート`、動画のあるデスクトップページの48.74%とモバイルページの45.99%が両方とも設定されていることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1010709511&format=interactive",
  sheets_gid="1366238292",
  sql_file="video_autoplay_muted.sql"
  )
}}

ビデオに関する追加情報を見るとデスクトップでは、57.22% の`<video>`要素が`autoplay`属性を持っており、デスクトップで`<video>`要素を持つページの56.36%が`muted`属性を利用しており、最後に48.74%のページが`autoplay`と`muted`の両方を併用しています。モバイルの場合も同様で、53.86% が`autoplay`、53.41%が`muted`、45.99% が両方の属性を使用しています。

## 結論

ウェブは、視覚的なストーリーを伝えるのに最適な場所です。今回の調査では、ウェブには実に多くのメディアの要素が活用されていることがわかりました。この多様性は、今日のウェブでメディアが表現される方法の数にも表れています。メディアを表示するためのほとんどの基本的な機能は積極的に使用されていますが、最新のブラウザを使用すれば、さらに多くのことができるようになります。現在使用されている高度なメディア機能の中には素晴らしいものもありますが、時には間違った使い方や、誤った文脈で使用されることもあります。私たちは皆さんに、さらに一歩踏み込んで、ユーザーにもっと素晴らしいビジュアル体験を提供するために、現代のウェブのすべての機能と性能を利用することをオススメしたいと思います。
