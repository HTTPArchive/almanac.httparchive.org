---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: メディア
description: 2022年版Web Almanacのメディア章では、画像や動画がWeb上でどのようにエンコード、埋め込み、スタイリング、配信されているかを解説しています。
authors: [eeeps, akshay-ranganath]
reviewers: [nhoizey, yoavweiss]
analysts: [eeeps, akshay-ranganath]
editors: [MichaelLewittes]
translators: [ksakae1216]
eeeps_bio: Eric Portisは<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のウェブプラットフォーム提唱者です。
akshay-ranganath_bio: Akshay Ranganathは<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のSr.Solution Architectで、CDN/WebPerfの課題に取り組むことが好きです。
results: https://docs.google.com/spreadsheets/d/1T5oVAVmcH3sM6R-WwH4ksr2jFtPhuLXs3-iXXoABb3E/
featured_quote: 今年もっともエキサイティングだったのは、AVIFの採用が加速したことと、レイジーローディングとアダプティブ・ビットレート・ストリーミングの採用が増え続けていることです。しかし、広色域の色空間がほとんどないこと、GIFという永遠のゾンビフォーマット、サイズとレイジーローディング（パフォーマンスのために設計された2つの機能）の両方が、不適切な使用によってかなりのページでパフォーマンスを損なっていることなど、不満な点もありました。
featured_stat_1: 99.9%
featured_stat_label_1: 少なくとも1つの画像要求が発生したページ。
featured_stat_2: 405%
featured_stat_label_2: AVIF採用の前年同期比。
featured_stat_3: 59%
featured_stat_label_3: 30秒以内の動画要素。
---

## 序章

ハイパー *テキスト* であるにもかかわらず、ウェブは極めて視覚的です。実際、画像や動画はウェブユーザーの体験に欠かせない要素となっています。AVIF、ワイドカラー、アダプティブ・ビットレート・ストリーミング、レイジー・ローディングなどの新技術を採用し、ビジュアルウェブはどこまで進化したのか、そしてまだどこまで進化しなければならないのか、Web Almanacは私たちに調査するユニークな機会を与えてくれます。私は、アニメーションGIFを見ているのです。

さっそく潜入してみましょう。

## 画像

一般的なウェブサイトのページウェイトのうち、画像は大きな割合を占めています。[ページウェイト](./page-weight)の章から、2021年6月の中央値ウェブサイトの総ウェイトは2,019キロバイト（モバイル時）で、そのうちの881キロバイトは画像だったことがわかります。これは、HTML（30KB）、CSS（72KB）、JavaScript（461KB）、フォント（97KB）の合計よりも多い。

{{ figure_markup(
  content="99.9%",
  caption="画像リソースへのリクエストが少なくとも1回発生したページ。",
  classes="big-number",
  sheets_gid="1169944186",
  sql_file="at_least_one_image_request.sql"
)
}}

背景やファビコンであっても、ほとんどすべてのページで何らかの画像が提供されています。

{{ figure_markup(
  content="70%",
  caption="LCPの責任要素に画像があるモバイルページ。",
  classes="big-number",
  sheets_gid="1131925867",
  sql_file="lcp_element_data.sql"
)
}}

モバイルでは70％、デスクトップでは80％と、もっとも多くのページで、もっともインパクトのあるリソースは画像です。<a hreflang="en" href="https://web.dev/articles/lcp">最大のコンテントフルペイント</a> (LCP)は、折り目の上にある最大の要素を特定するウェブパフォーマンス指標です。もっとも多くの場合、その要素は画像を持っています。

ウェブにおける画像の重要性について言い過ぎたことはない。では、ウェブの画像について、どのようなことが言えるのでしょうか。

### 画像リソース

まず、リソースそのものについて説明します。ビットマップイメージはピクセルでできています。一般的にWebの画像は何ピクセルあるのでしょうか？

#### 1画素画像に関する注意点

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>1x1画像</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>モバイル</td>
        <td class="numeric">7.3%</td>
      </tr>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">7.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="1ピクセルだけを含む `<img>` 要素によって読み込まれるリソース。", sheets_gid="1553017697", sql_file="image_1x1.sql") }}</figcaption>
</figure>

不審なほど多くのものが1×1です。これらの `<img>` は、画像コンテンツをまったく含んでいません。レイアウト用（[スペーサーGIF](https://en.wikipedia.org/wiki/Spacer_GIF)）と[トラッキングビーコン](https://ja.wikipedia.org/wiki/%E3%82%A6%E3%82%A7%E3%83%96%E3%83%93%E3%83%BC%E3%82%B3%E3%83%B3)の2つの目的で使用されているのです。

新しく作成されたウェブサイトは、レイアウトにCSSを使い、トラッキングに[ビーコンAPI](https://developer.mozilla.org/en-US/docs/Web/API/Beacon_API)を使うべきです。既存の多くのコンテンツは、トラッキングピクセルとスペーサーGIFを永遠に使い続けるだろうが、ここのデスクトップ数は[昨年](../2021/media#fig-5)から変わっておらず、モバイル数はほんの少ししか縮小していないことに落胆させられる。<a hreflang="en" href="https://developers.facebook.com/docs/meta-pixel/implementation/marketing-api#intialize-img">古い習慣</a> <a hreflang="en" href="https://spacergif.org/stats/">こごえる</a>！

可能な限り、これらの実際には画像ではない`<img>`を分析から除外しました。

#### 画像寸法

{{ figure_markup(
  image="distribution-of-image-pixel-counts.png",
  caption="画像の画素数の分布。",
  description="デスクトップとモバイルの画像1枚あたりの画素数分布を示す棒グラフだが、両者にはほとんど差がない（デスクトップは一貫して若干低い）。10パーセンタイルでは、モバイル画像の画素数は0.001メガピクセル、25パーセンタイルでは0.01、50パーセンタイルでは0.046、75パーセンタイルでは0.203、90パーセンタイルでは0.608となる。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=988080204&format=interactive",
  sheets_gid="708677709",
  sql_file="bytes_and_dimensions.sql"
)
}}

1ピクセル以上を含む画像に移るもっとも多くのページには、少なくとも1つの大きな画像が含まれているのですが、その画像はかなり小さいです。

「メガピクセル」は、画像サイズを表すもっとも直感的な指標ではありません。たとえば、アスペクト比4:3の場合、中央の画素数0.046MPは、248×186の画像になります。

これは小さいと思われるかもしれませんが、中央のページには少なくとも1つの`<img>`が含まれており、そのピクセル数は中央の`<img>`要素よりも10倍近く多くなっています。

{{ figure_markup(
  image="largest-image-per-page-by-pixel-count.png",
  caption="1ページあたりもっとも大きな画像（画素数で）。",
  description="1ページあたりのもっとも大きな画像の分布をピクセル単位で示した棒グラフです。デスクトップとモバイルの両方を示しています。デスクトップは一貫して10～20％高いように見えますが、これらの棒グラフにはラベルが貼られていません。10パーセンタイルでは、モバイルページのもっとも大きな画像は0.201メガピクセルです。25パーセンタイルでは0.113メガピクセル、50パーセンタイルでは0.431メガピクセル、75パーセンタイルでは1.088メガピクセル、90パーセンタイルでは2.560メガピクセルとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=230013578&format=interactive",
  sheets_gid="209430368",
  sql_file="largest_image_per_page_pixels.sql"
)
}}

アスペクト比4:3の場合、0.431MPは758×569に相当する。モバイルクローラーのビューポートが（一般的な）360px幅であることを考えると、これらの大きな画像の多くは、ビューポートのほぼ全体に、高い密度で描かれることになると思われます。

要するに、ほとんどの画像は小さいが、もっとも多くのページに少なくとも1枚の大きな画像が含まれている。

#### 画像のアスペクト比

Webではどのようなアスペクト比が一般的なのでしょうか？

{{ figure_markup(
  image="image-orientations.png",
  caption="画像の向き。",
  description="デスクトップとモバイルの両方で、画像の縦長、横長、正方形の割合を示す一対の積み上げ棒です。デスクトップの内訳は、縦型13％、正方形33％、横型54％です。モバイルの内訳も同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=5572776&format=interactive",
  sheets_gid="976702915",
  sql_file="portrait_landscape_square.sql"
)
}}

[昨年ともっとも似ている](../2021/media#アスペクト比)、ほとんどの画像が横長で、モバイルとデスクトップの数値にほぼ差が、ないことがわかります。2021年と同様、これは大きな機会損失のように感じられます。多くのインスタグラマーが知っているように縦長の画像は、<a hreflang="en" href="https://uxdesign.cc/the-powerful-interaction-design-of-instagram-stories-47cdeb30e5b6">モバイル画面では、正方形や横長の画像よりも全幅で大きく表示され</a>、<a hreflang="en" href="https://www.dashhudson.com/blog/best-picture-format-instagram-dimensions">高いエンゲージメント</a>を促進する。ソースが横長であっても、<a hreflang="en" href="https://web.dev/codelab-art-direction/">アート ディレクション</a>を使用して、モバイル画面用に画像を調整することは可能ですし、そうすべきです。

<figure>
  <table>
    <thead>
      <tr>
        <th>アスペクト比</th>
        <th>画像の割合%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1:1</td>
        <td class="numeric">32.92%</td>
      </tr>
      <tr>
        <td>4:3</td>
        <td class="numeric">3.99%</td>
      </tr>
      <tr>
        <td>3:2</td>
        <td class="numeric">2.74%</td>
      </tr>
      <tr>
        <td>2:1</td>
        <td class="numeric">1.66%</td>
      </tr>
      <tr>
        <td>16:9</td>
        <td class="numeric">1.62%</td>
      </tr>
      <tr>
        <td>3:4</td>
        <td class="numeric">1.02%</td>
      </tr>
      <tr>
        <td>2:3</td>
        <td class="numeric">0.72%</td>
      </tr>
      <tr>
        <td>5:3</td>
        <td class="numeric">0.54%</td>
      </tr>
      <tr>
        <td>6:5</td>
        <td class="numeric">0.48%</td>
      </tr>
      <tr>
        <td>8:5</td>
        <td class="numeric">0.47%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="画像のアスペクト比がもっとも多いランキング表（モバイル）。", sheets_gid="1668821585", sql_file="top_aspect_ratios.sql") }}</figcaption>
</figure>

画像のアスペクト比は、4：3、3：2、とくに1：1（正方形）といった「標準的」な値に集中していた。実際、全画像の40％がこの3つのアスペクト比のいずれかを持っており、上位10個のアスペクト比は全`<img>`の約半分を占めていました。

#### 画像の色空間

画像は画素でできており、各画素は色を持っています。ある画像内で可能な色の範囲は、その画像の[色空間](https://ja.wikipedia.org/wiki/%E8%89%B2%E7%A9%BA%E9%96%93)によって決定されます。

Webのデフォルトの色空間は[sRGB](https://en.wikipedia.org/wiki/SRGB)です。CSSの色はデフォルトでsRGBを指定され、とくに指定がない限り<a hreflang="en" href="https://imageoptim.com/color-profiles.html">ブラウザは画像の色もsRGBであると仮定します</a>。

これは、ほぼすべてのディスプレイやキャプチャーハードウェアがsRGBまたはそれに近いものを扱っていた世界では理にかなっていました。しかし、時代は変わりつつあるのです。2022年には、もっとも携帯電話のカメラがsRGBよりも広い色域で撮影するようになります。また、sRGB以外の豊かな色彩を表現できるディスプレイハードウェアもかなり普及しています。

広色域ディスプレイに対応した最新のブラウザは、sRGBより広い色域で画像をエンコードすれば、sRGB外の鮮やかな色を喜んで描画します。しかし、そうでしょうか？

要するに、ダメなんです。

ある画像がRGB以外の色空間を使用していることをブラウザに伝えるには、一般的に画像の色空間を記述した[ICCプロファイル](https://ja.wikipedia.org/wiki/ICC%E3%83%97%E3%83%AD%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)を添付する必要があります。そのICCプロファイルには名前がついています。ウェブ上で使用されているユニークなICCプロファイルの名前を25,000以上見つけました。ここでは、もっとも多い20個を紹介します：


<figure>
  <table>
    <thead>
      <tr>
        <th>ICCプロファイルの説明</th>
        <th>sRGBっぽい</th>
        <th>広色域</th>
        <th>画像の割合%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>タグなし</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">90.17%</td>
      </tr>
      <tr>
        <td>sRGB IEC61966-2.1</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">3.23%</td>
      </tr>
      <tr>
        <td>c2ci</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">2.40%</td>
      </tr>
      <tr>
        <td>sRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.88%</td>
      </tr>
      <tr>
        <td>Adobe RGB (1998)</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.76%</td>
      </tr>
      <tr>
        <td>uRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.54%</td>
      </tr>
      <tr>
        <td>ディスプレイ P3</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>c2</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.33%</td>
      </tr>
      <tr>
        <td>ディスプレイ</td>
        <td></td>
        <td></td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>sRGB内臓</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.24%</td>
      </tr>
      <tr>
        <td>GIMP内蔵sRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.22%</td>
      </tr>
      <tr>
        <td>sRGB IEC61966-2-1黒スケール</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td>一般的なRGBプロファイル</td>
        <td></td>
        <td></td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>U.S. Web Coated (SWOP) v2</td>
        <td></td>
        <td></td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>sRGB MozJPEG</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Artifexソフトウェア sRGB ICCプロファイル</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Dot Gain 20%</td>
        <td></td>
        <td></td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Coated FOGRA39 (ISO 12647-2:2004)</td>
        <td></td>
        <td></td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>Apple Wideカラーシェアリングプロファイル</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>sRGB v1.31 (Canon)</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>HD 709-A</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="ICC色空間記述のもっとも多い20個のランキングリスト（モバイル）。", sheets_gid="560546690", sql_file="color_spaces_and_depth.sql") }}</figcaption>
</figure>

ウェブ上の画像10枚のうち9枚はタグ付けされておらず、RGBデータを含んでいればsRGBとして解釈されます。残りの10％のほとんどは、sRGBまたはそれに近いタグが明示的に付けられています。「c2ci」、「uRGB」、「c2」はすべてsRGBの亜種で、<a hreflang="en" href="https://github.com/saucecontrol/Compact-ICC-Profiles">最小かつ軽量であるように設計されています</a>。ウェブ上の全画像のうち、sRGBより広い色域でタグ付けされているのは1％強に過ぎません。もっと簡潔に言うと、広色域画像は現在、グレースケール画像と同じくらいウェブで人気があります。<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1T5oVAVmcH3sM6R-WwH4ksr2jFtPhuLXs3-iXXoABb3E/edit?pli=1#gid=560546690&range=P5">ウェブ画像の1.16%を占めています</a>。

AVIFとPNGは、ICCプロファイルを使用せずに、フォーマット固有のショートハンドを使用して広色域の色空間を持つ画像にタグ付けできます。ICCプロファイルを使用しないワイドガモットAVIFとPNGの検出を試みましたが、エンコードのさまざまな方法と、ツールによる報告の方法を考慮すると、今年取り組むには少し複雑すぎることがわかりました。来年に期待しましょう！

### エンコード

さて、Webの画像コンテンツについて少し理解できましたが、そのコンテンツがどのようにエンコードされて配信されるのかについて、どのようなことが言えるのでしょうか。

#### フォーマット採用

GIF、JPEG、PNGは、何十年もの間、ウェブ上の標準的なビットマップ画像ファイルフォーマットとして使われてきました。それが変わり始めたのは、2014年にChromeがWebPのサポートを出荷してからです。この2、3年で、その変化は加速しています。SafariとFirefoxはWebPのサポートを出荷し、3つの主要なブラウザはすべて、少なくともAVIFの実験的サポートを出荷しました。

フォーマット別に、クローラーが見たすべての画像リソースを紹介します。

{{ figure_markup(
  image="image-format-adoption.png",
  caption="画像フォーマットの採用。",
  description="ウェブ上の画像に占める各フォーマットの割合を円グラフにしたものです。1位はJPEGで40.3%です。次にPNGが28.2％、GIFが15.9％、WebPが8.9％、SVGが4.7％、ICOが1.6％となっています。パイには、ラベルが貼られていない小さな断片がいくつか残されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1390540775&format=interactive",
  sheets_gid="635730566",
  sql_file="media_formats.sql"
)
}}

0.22%というAVIFのパイは、グラフに表示されていないほど小さなものです。0.22％という数字は、昨年と比較すると、あまり大きくないように思われるかもしれませんが、かなりの進歩があったことを意味します。

{{ figure_markup(
  image="image-format-adoption-year-over-year-change.png",
  caption="画像フォーマットの採用状況、前年比。",
  description="各フォーマットの使用率シェアの前年比を棒グラフで示したもの。AVIFが突出しており、405％の伸びを示している。WebPは29％、SVGは16％の伸びを示しています。レガシーフォーマットはいずれも微減です： JPEG：-4％、PNG：-2％、GIF： -4%; ICO: -8%となっています。最後に、その他/不明が+2%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1597734507&format=interactive",
  sheets_gid="635730566",
  sql_file="media_formats.sql"
)
}}

少しずつ、古いフォーマットから新しいフォーマットへの移行が進んでいます。そうあるべきでしょう！新フォーマットは、旧フォーマットをかなりの差で凌駕しています。それは、まもなく実感できることでしょう。

#### バイトサイズ

Web上の一般的な画像はどのくらい重いのでしょうか？

{{ figure_markup(
  image="distribution-of-image-byte-sizes.png",
  caption="画像のバイトサイズの分布。",
  description="デスクトップとモバイルの画像バイトサイズの分布を示す棒グラフです。10パーセンタイルでは0キロバイト、25パーセンタイルでは2キロバイト、50パーセンタイルでは10キロバイト、75パーセンタイルでは46キロバイト、そして90パーセンタイルでは148キロバイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=961266271&format=interactive",
  sheets_gid="708677709",
  sql_file="bytes_and_dimensions.sql"
)
}}

中央値が10KBだと、「え、そんなに重くないよ！」と思われるかもしれません。しかし、画素数を見たときと同じように、小さな画像が多い一方で、もっとも多くのページには少なくとも1つの大きな画像があります。

{{ figure_markup(
  image="largest-image-per-page-by-kilobytes.png",
  caption="1ページあたりもっとも大きな画像（キロバイト単位）。",
  description="ページあたりのもっとも大きな画像の分布をキロバイト単位で示した棒グラフです。このグラフはデスクトップとモバイルの両方を示しており、モバイルは通常デスクトップより10％程度低く表示されます。10パーセンタイルでは、モバイルページとデスクトップページのもっとも大きな画像はどちらも6キロバイトです。25パーセンタイルでは、デスクトップが37キロバイト、モバイルが34キロバイトです。50パーセンタイルでは142キロバイトと127キロバイト、75パーセンタイルでは425キロバイトと377キロバイト、90パーセンタイルでは1,013キロバイトと911キロバイトとなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=185626936&format=interactive",
  sheets_gid="1771092530",
  sql_file="largest_image_per_page_bytes.sql"
)
}}

もっとも多くのページで100KBを超える画像が少なくとも1枚あり、上位10％のページではほぼ1MB以上の重さの画像が少なくとも1枚ある。

#### 画素あたりのビット数

バイト数やピクセル数だけでもおもしろいですが、ウェブ上の画像データの圧縮率を知るには、バイト数とピクセル数を合わせて1ピクセルあたりのビット数を算出する必要があります。これにより、解像度が異なる画像であっても、その情報密度を比較することができるようになります。

一般に、Web上のビットマップは、1チャンネル、1ピクセルあたり8ビットの情報にデコードされます。つまり、透明度のないRGB画像の場合、デコードされた非圧縮画像は[1ピクセルあたり24ビット](https://ja.wikipedia.org/wiki/%E8%89%B2%E6%B7%B1%E5%BA%A6#%E3%83%88%E3%82%A5%E3%83%AB%E3%83%BC%E3%82%AB%E3%83%A9%E3%83%BC%EF%BC%8824/32%E3%83%93%E3%83%83%E3%83%88))になると予想されます。可逆圧縮の経験則は、ファイルサイズを2:1の比率で削減することです（8ビットRGB画像の場合、1ピクセルあたり12ビットになります）。1990年代の非可逆圧縮方式であるJPEGやMP3では、10:1（1ピクセルあたり2.4ビット）の比率が目安でした。画像のコンテンツやエンコーディングの設定によって、これらの比率は大きく変化し、<a hreflang="en" href="https://github.com/mozilla/mozjpeg">MozJPEG</a> などの最新のJPEGエンコーダーは、デフォルト設定でこの10:1目標を上回ることが一般的であることに注意すべきです。要約すると、次のようになります。

<figure>
  <table>
    <thead>
      <tr>
        <th>ビットマップデータの種類</th>
        <th>期待される圧縮率</th>
        <th>画素あたりのビット数</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>非圧縮RGB</td>
        <td>1:1</td>
        <td>24ビット/画素</td>
      </tr>
      <tr>
        <td>ロスレス圧縮されたRGB</td>
        <td>~2:1</td>
        <td>12ビット/画素</td>
      </tr>
      <tr>
        <td>1990年代のロッシーRGB</td>
        <td>~10:1</td>
        <td>2.4ビット/画素</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="ビットマップRGBデータの代表的な圧縮率と圧縮結果のビット/ピクセル数。") }}</figcaption>
</figure>

では、このような背景を踏まえて、Webの画像をどのように評価するか、ご紹介しましょう。

{{ figure_markup(
  image="distribution-of-image-bits-pixel.png",
  caption="画像ビット/ピクセルの分布。",
  description="デスクトップとモバイルの両方で、ピクセルあたりの画像ビット数の分布を示す棒グラフです。デスクトップの棒グラフは、一貫してモバイルの棒グラフよりも数パーセントポイント高いが、ラベルは付いていない。10パーセンタイルでは、モバイルのウェブ画像は1ピクセルあたり0.1ビットです。25パーセンタイルでは1.0、50パーセンタイルでは2.3、75パーセンタイルでは5.8、そして90パーセンタイルではなんと1ピクセルあたり13.3ビットのモバイル画像となります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1231605169&format=interactive",
  sheets_gid="708677709",
  sql_file="bytes_and_dimensions.sql"
)
}}

モバイルの`<img>`の中央値は、1ピクセルあたり2.3ビットで、圧縮率10:1の目標をほぼ達成できます。しかし、その中央値の周辺には、非常に大きな広がりがあります。もう少し詳しく知るために、フォーマット別に分類してみましょう。

#### 画素あたりのフォーマット別ビット数

{{ figure_markup(
  image="median-bits-per-pixel-by-format.png",
  caption="フォーマット別の1画素あたりの中央値ビット数。",
  description="一般的な画像フォーマットのピクセルあたりのビット数の中央値を、フォーマット別に示した棒グラフです。デスクトップとモバイルの数値はほぼ同じで、モバイルの棒グラフにのみラベルが付けられています。GIFは1ピクセルあたり7.5ビット、PNGは4.2ビット、JPGは2.1ビット、WebPは1.4ビット、AVIFは1.0ビットともっとも小さいです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=816096019&format=interactive",
  sheets_gid="1658597028",
  sql_file="bytes_and_dimensions_by_format.sql"
)
}}

これらの数字のほとんどは、[昨年](../2021/media#フォーマット別、画素あたりのビット数)と基本的に変わっていません。

PNGは技術的には「可逆圧縮」技術を採用しています（アルファチャンネルを扱うかどうかにもよりますが、1ピクセルあたり12～16ビットを想定しています）、そのエンコーダーは一般に非可逆的であることがわかります。圧縮率を高めるために、画像を「可逆圧縮」する前に、カラーパレットを減らし、ディザリングパターンを導入するのです。

そして、典型的なWebPは、典型的なJPEGよりも1ピクセルあたり3分の1軽くなっていることがわかります。これは、私たちが期待するところとほぼ同じです。 <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">正式な研究</a>では、<a hreflang="en" href="https://kornel.ski/en/faircomparison">品質比較</a>を用いて、WebPがJPEGよりもほぼ同じマージンで優れていると推定しています。

昨年と比較して、唯一大きく動いたのはAVIFです。このフォーマットは、昨年の1ピクセルあたり1.5ビットから1.0ビットへと、WebPよりも圧縮率を下げています。これは非常に大きな減少ですが、まったく予想外だったわけではありません。AVIFは非常に若いフォーマットで、エンコーダーは素早く反復し、その採用は著しく広がっています。来年には、AVIFの中央値がさらに圧縮されていることでしょう。

非可逆圧縮と品質のトレードオフの品質面を見なければ、この結果だけでは、AVIFがWeb対応フォーマットの中で「もっとも良い」圧縮を提供していると結論づけることはできない。しかし、今年は、実世界での使用において、AVIFはもっとも圧縮率が高いという結論を出すことができます。この結論と、<a hreflang="en" href="https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4">in-the-lab結果</a>のように、品質を保つのに良い仕事をすることを示唆する結果を組み合わせると、画像はかなり良く見え始めます（冗談です）。

<a hreflang="en" href="https://caniuse.com/avif">AVIFのブラウザ サポート</a>も今年、大きな飛躍を遂げました。つまり、ウェブ上でビットマップ画像を送信するのであれば、[99.9%のページがそうである](#画像)ように、少なくともAVIFの送信を検討すべきなのです。

#### GIF、アニメーション、そうでないもの

圧縮チャートのもう一方の端には、私たちの古い友人であるGIFがあります。これはとくに悪いように見えますが、このフォーマットのせいばかりではありません。この35年前のフォーマットがいまだによく使われている理由のひとつは、アニメーションができることで、画素数を計算する際にフレーム数を考慮していないのです。このことは、いくつかの興味深い問題を提起しています。まず、アニメーションを行うGIFはどれくらいあるのでしょうか？

{{ figure_markup(
  content="29%",
  caption="モバイルでアニメーションされたGIFの割合。",
  classes="big-number",
  sheets_gid="1586002077",
  sql_file="animated_gif_count.sql"
)
}}

私はこれが意外に低いことに気づきました。<a hreflang="en" href="https://caniuse.com/?search=png">PNGが2006年に普遍的なサポートを獲得して以来</a>、非アニメーションGIFを出荷する正当な理由は [ありませんでした](https://en.wikipedia.org/wiki/Portable_Network_Graphics#Compared_to_GIF)。「GIF」という言葉は、その唯一の正当な使用例と同義語になっています。 短い、無音、自動再生、ループするアニメーションのためのポータブルでユニバーサルなフォーマットであることです。これらの非アニメーションGIFはすべてレガシーコンテンツなのか、それとも相当数の新しい非アニメーションGIFが作成されウェブに公開されているのか、疑問が残るが、そうでなければいい！

アニメーションGIFと非アニメーションGIFを分けたところで、非アニメーションGIFとアニメーションGIFの圧縮特性はどうなっているのか？

{{ figure_markup(
  image="gif-bits-per-pixel-animated-vs-non-animated.png",
  caption="GIFの1ピクセルあたりのビット数：アニメーションと非アニメーションの比較。",
  description="アニメーションGIFと非アニメーションGIFの画素あたりのビット数の分布を示す棒グラフです。アニメーションGIFの棒グラフが、非アニメーションGIFの棒グラフを圧倒しています。アニメーションGIFの1ピクセルあたりのビット数は、4.5、11.3、30.4、54.3、73.6で、それぞれ10、25、50、75、90パーセンタイルにあたります。非アニメーションgifの進行は以下の通りです。0.9、1.8、3.5、5.7、8.5ビット/ピクセル。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1578261884&format=interactive",
  sheets_gid="1549622786",
  sql_file="animated_gif_bpp.sql"
)
}}

アニメーションGIFを除外してみると、このフォーマットはもっと良くなります。GIFは1ピクセルあたり3.5ビットの中央値で、PNGよりもピクセル単位で小さくなっています。これは、各フォーマットが圧縮を要求されるコンテンツの種類を反映していると思われます。 GIFは、設計上、256色と2値の透明度しか含むことができません。GIFは設計上、256色と2値の透明度しか持つことができませんが、PNGは1670万色と完全なアルファチャンネルを持つことができます。

GIFの話をする前に、GIFについてもう1つ質問があります。GIFアニメは通常何フレームあるのでしょうか？

{{ figure_markup(
  image="distribution-of-animated-gif-frame-counts.png",
  caption="アニメーションGIFのフレーム数の分布。",
  description="アニメーションGIFのフレーム数の分布を示す棒グラフ。このグラフはデスクトップとモバイルの両方を示していますが、もっとも多いパーセンタイルに入るまでは、数値は互角で、モバイルの数値がわずかに遅れ始めています。10パーセンタイルでは、モバイルもデスクトップもGIF1枚あたり3フレームを表示しています。25パーセンタイルでは、両者とも8フレームです。50パーセンタイルでは12フレーム、75パーセンタイルではデスクトップが24フレーム、モバイルが21フレームとなります。最後に、90パーセンタイルでは、デスクトップのクローラーは45フレーム、モバイルのクローラーは42フレームが表示されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=514250122&format=interactive",
  sheets_gid="1129449602",
  sql_file="animated_gif_framecount.sql"
)
}}

GIFアニメの大半は、十数フレーム以下で登場します。ちなみに、私たちが見つけたGIFのもっとも多いフレーム数は15,341フレームでした。30FPSで計算すると、8分半のGIFになる。心が揺れ動く。

### エンベデッド

さて、ウェブの画像リソースがどのようにエンコードされているのかがわかったところで、それらがどのようにウェブページに埋め込まれるのかについて、どのようなことが言えるのでしょうか。

#### レイジーローディング

{{ figure_markup(
  image="adoption-of-loading-lazy-on-img.png",
  caption="`<img>`に`loading=lazy`を採用した。",
  description="ネイティブレイジーローディングを使用するページの割合を時系列で示した折れ線グラフです。グラフは2020年5月の0%から始まっています。そこから3段階のカーブを描き夏にかけて利用が加速し、8月頃には8％のページが遅延ロードを利用するようになり、2021年1月までは利用が減速（それでも増え続ける）し、（15％程度の利用で）直線的になり2022年6月の25％弱で終息していることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=539020085&format=interactive",
  sheets_gid="747829499",
  sql_file="lazy_loading_adoption_over_time.sql"
)
}}

昨年の最大の話題は、レイジーローディングの急速な普及でした。採用のペースが落ちたとはいえ、驚くべき速度で進んでいます。昨年6月、レイジーローディングを採用していたページは17%でした。それが今年は1.4倍に増えました。現在では24％のページがレイジーローディングを利用しています。

ウェブ上の膨大なレガシーコンテンツを考えると、2年間でゼロからクロールされるページの4分の1程度になったというのは驚くべきことで、ネイティブの遅延ローディングに対する需要がいかに大きかったかを示しています。

{{ figure_markup(
  content="9.8%",
  caption="モバイルでネイティブレイジーローディングを使用しているLCP `<img>` の割合。",
  classes="big-number",
  sheets_gid="747829499",
  sql_file="lazy_loading_adoption_over_time.sql"
)
}}

そして実際に、昨年と同様に、ページが遅延ローディングを少し _多用_ しているようです。

LCP要素のレイジーローディングは、LCPのスコアをより悪くする。ページを遅くするアンチパターンです。10個に1個のLCP `<img>` がレイジーローディングされていることを見ると、がっかりします。このアンチパターンが昨年から少しずつ増えているのを見ると、なおさらです。

#### `alt`テキスト

`<img>`要素で埋め込まれた画像は、コンテントフルであることが前提です。つまり、「単なる飾りではなく、意味のあるものが含まれていなければならない」ということです。<a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/non-text-content">WCAGの要件</a> と <a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#alt">HTML仕様</a>の両方によると、すべての内容のある画像には代替テキストが必要で、その代替テキストは通常 `alt` 属性が提供すべきです。

{{ figure_markup(
  content="54%",
  caption="空白でない `alt` 属性を持つイメージの割合。",
  classes="big-number",
  sheets_gid="1159402915",
  sql_file="image_alt.sql"
)
}}

この結果は、全`<img>`のほぼ半分が明らかにアクセシブルでないことを意味します。[今年のアクセシビリティの章の詳細な分析](./accessibility#イメージ)が示唆するところでは、空白でない`alt`属性を持つ`<img>`の大部分も、それほどアクセシブルではないのです。

私たちはもっとうまくやれるし、やらなければならない。

#### `srcset`

Lazy-loadingの前に、ウェブ上の`<img>`に起こった最大の出来事は、「レスポンシブ・イメージ」のための一連の機能で、レスポンシブ・デザインに適合するように画像を調整することを可能にしました。2014年にはじめて出荷された`srcset`属性、`sizes`属性、そして`<picture>`要素は、10年近く前から作者が適応性の高いリソースをマークアップすることを可能にしています。私たちは、これらの機能をどの程度、どのように使っているのでしょうか？

まず、`srcset`属性から説明します。この属性は、文脈に応じてブラウザにリソースの選択メニューを与えることができます。

{{ figure_markup(
  content="34%",
  caption="`srcset`属性を使用しているページの割合。",
  classes="big-number",
  sheets_gid="632017314",
  sql_file="image_srcset_sizes.sql"
)
}}

3分の1のページが `srcset` を使っているが、3分の2は使っていない。2022年のレスポンシブデザインにおけるフルードグリッドの普及を考えると、`srcset`を使用していないページの中には、使用すべきものがたくさんあるのではないでしょうか？

`srcset`属性は、2つの記述子のうちの1つを使用してリソースを記述することを可能にします。`x`ディスクリプターはリソースがどの画面密度に適しているかを指定し、`w`ディスクリプターは代わりにリソースの幅をピクセルでブラウザに与えます。`sizes`属性と組み合わせて使用することで、`w`記述子はブラウザが流動的なレイアウト幅と可変的な画面密度の両方に適したリソースを選択することを可能にします。

{{ figure_markup(
  image="srcset-descriptor-usage.png",
  caption="`srcset`ディスクリプターの使用法。",
  description="モバイルとデスクトップの両方で、`x`記述子と`w`記述子を使用している`srcset`の割合を示す棒グラフです。デスクトップでは15%、モバイルは14%の`srcset`で `x`ディスクリプターが使用されています。`w`ディスクリプターは4倍多く使われています。デスクトップでは57％、モバイルでは59％の割合で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1207511817&format=interactive",
  sheets_gid="935446394",
  sql_file="image_srcset_descriptor.sql"
)
}}

`x`ディスクリプターは最初に登場したものであり、よりシンプルに考えることができます。何年もの間、より強力な `w` ディスクリプターよりも人気を博していました。10年近く経って、世界が `w` ディスクリプターを受け入れるようになったことは、私の心を温かくしてくれます。

#### `sizes`

先ほど、`w`ディスクリプターは`sizes`属性と組み合わせて使うべきと書きました。私たちは `sizes` をどのように使っているのでしょうか？二つ返事でOKです。あまりうまくはありません。

`sizes`属性は、ブラウザに画像の最終的なレイアウトサイズを示すヒントとなるもので、通常はビューポートの幅に相対するものです。画像のレイアウト幅に影響を与える変数がたくさんあります。`sizes`属性は明示的にヒントであることを想定しているので、多少の不正確さは問題ありませんし、むしろ期待されています。しかし`sizes`属性が少しばかり不正確であれば、リソース選択に影響を与え、実際の画像のレイアウト幅が大きく異なるのに、`sizes`の幅に合うようにブラウザが画像を読み込んでしまうことがあります。

So how accurate are our `sizes`?

{{ figure_markup(
  image="distribution-of-img-sizes-errors.png",
  caption="`<imgサイズ>`のエラーの分布。",
  description="デスクトップとモバイルの両方で、`sizes`属性の相対誤差の分布を示す棒グラフです。10パーセンタイルと25パーセンタイルでは、デスクトップとモバイルの両方で0%となっています。50パーセンタイルではデスクトップ19%、モバイル13%、75パーセンタイルはそれぞれ105%と71%、そして90パーセンタイルでは305%と151%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=173383101&format=interactive",
  sheets_gid="428964279",
  sql_file="image_srcset_sizes_per_image_accuracy_impact.sql"
)
}}

多くの`sizes`属性は完全に正確ですが、`sizes`属性の中央値は、モバイルでは13%、デスクトップで19%大きすぎることがわかります。しかし、ご覧のように、p75とp90の数値は美しくなく、悪い結果につながります。

{{ figure_markup(
  content="19%",
  caption="デスクトップでは `srcset` の選択に影響を与えるほど不正確な `sizes` 属性がありました。モバイルでは、14％です。",
  classes="big-number",
  sheets_gid="1675255539",
  sql_file="image_srcset_sizes_accuracy_pct.sql"
)
}}

デスクトップでは、デフォルトの `sizes` 値 (`100vw`) と実際の画像のレイアウト幅の差がモバイルより大きい可能性が高いため、5つに1つの `sizes` 属性が不正確で、ブラウザが `srcset` から最適でないリソースを選択する原因となっています。このようなエラーは積み重なります。

{{ figure_markup(
  image="excess-kilobytes-loaded-per-page-due-to-inaccurate-sizes.png",
  caption="不正確なサイズにより、1ページあたり過剰なキロバイトが読み込まれます。",
  description="不正確な `sizes` 属性のためページごとに読み込まれるムダなキロバイトの分布を示す棒グラフです。ゼロの束で始まっています。10、25、50パーセンタイルでは、モバイルとデスクトップともに0キロバイトです。75パーセンタイルでは、デスクトップのクローラーが83キロバイト、モバイルが27キロバイト、90パーセンタイルでは、デスクトップが536キロバイト、モバイルが283キロバイトのムダがありました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=2013610794&format=interactive",
  sheets_gid="1909870095",
  sql_file="image_sizes_per_page_accuracy_impact.sql"
)
}}

私たちは、デスクトップページの4分の1が、純粋に悪い`sizes`属性に基づいて、83KB以上の余分な画像データを読み込んでいると推定しています。つまり、次のようなことです。`srcset`にもっと小さくて良いリソースがあるのに、`sizes`属性が誤っているため、ブラウザがそれを選択しないのです。さらに、sizesを使用するデスクトップページの10%は、間違ったsizes属性のために、5メガバイト以上の過剰な画像データを読み込んでいます！

<p class="note">注：当社のクローラーは実際には正しいリソースを読み込まなかったため、ここに記載した数字は、クローラーが実際に読み込んだ誤ったリソースのバイトサイズに基づく推定値です。</p>

短期的に個々の開発者は<a hreflang="en" href="https://ausi.github.io/respimagelint/">RespImageLint</a> を使用して、ひどく壊れた`sizes`属性を監査して修正し、この種のムダを防止できますし、そうすべきです。

中期的には、可能であれば、ウェブプラットフォームはより良いツールを提供する必要があります。多くの開発者にとって、正確な `sizes` 属性を作成し、維持することは、あまりにも困難であることが証明されました。<a hreflang="en" href="https://github.com/whatwg/html/pull/8008">遅延ロードされた画像の自動サイズ</a>を可能にする提案は、テーブル上にあります。2023年に進展することを期待しましょう。

<a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes.js library</a>は、この種のソリューションに対する意欲をすでに証明しています。<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1T5oVAVmcH3sM6R-WwH4ksr2jFtPhuLXs3-iXXoABb3E/edit#gid=232511628">10%の`sizes`属性は現在、JavaScriptの実行前に値 "auto" を持ち</a>、画像を遅延ロードする前にlazysizes.jsによって後で完全に正しい値に書き直されます。遅延ロードに依存しているため、このパターンはLCP画像や、折りたたみの上にある `<img>` 要素には適していないことに注意してください。これらの画像の場合、レスポンシブ・ローディングのパフォーマンスを向上させる唯一の方法は、よくオーサリングされた `sizes` 属性を指定することです。

#### `<picture>`

2014年に上陸した最後のレスポンシブ画像機能は、`<picture>`要素でした。`srcset`がブラウザにリソースのメニューを渡すのに対し、`<picture>`要素は作者が主導権を握り、ブラウザにどの子`<source>`要素からリソースを読み込むかについて明示的に指示できます。

`<picture>`要素は、`srcset`に比べ、使用頻度が圧倒的に少ない。

{{ figure_markup(
  content="7.7%",
  caption="モバイルページのうち、`<picture>`要素を使用している割合。",
  classes="big-number",
  sheets_gid="1115439529",
  sql_file="picture_distribution.sql"
)
}}

これは昨年より2ティックほど増えていますが`<picture>`を使うページ1つに対して`srcset`を使うページが5つ近くあるということは、`<picture>`のユースケースがよりニッチであるか、デプロイがより困難であるか、その両方であることを示しています。

人々は何のために`<picture>`を使っているのでしょうか？

`<picture>`要素は、リソースを切り替えるための2つの方法を提供します。Type-switchingは、最先端の画像フォーマットをサポートするブラウザに提供し、それ以外のブラウザにはフォールバックフォーマットを提供できます。メディアスイッチでは、<a hreflang="en" href="https://www.w3.org/TR/respimg-usecases/#art-direction">アートディレクション</a>を促進し、メディアの状況に応じてさまざまな`<source>`を切り替えることができるようになります。

{{ figure_markup(
  image="picture-feature-usage.png",
  caption="`<picture>`機能の使い方です。",
  description="source要素の `media` 属性と `type` 属性を `picture` 要素と組み合わせて使用しているページの割合を示す棒グラフです。`media`は、モバイルでは41%、デスクトップで43%の `picture` 要素で使用されています。type`は、モバイルとデスクトップの両方で、`picture`要素の43%に使用されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1200360202&format=interactive",
  sheets_gid="236851814",
  sql_file="picture_switching.sql"
)
}}

使い方はそれなりに均等に分かれている。興味深いのは、[昨年](../2021/media#fig-23)からタイプスイッチの差が縮まっていることだ。これは、AVIFやWebPといった次世代画像フォーマットの普及が進んでいることと関係していると思われます。

### レイアウト

レスポンシブ画像の難しさは、HTMLを書くときに`<img>`がどのように配置されるかを考えなければならないことです。そこで、基本的な疑問が生まれます。`<img>`はどのように配置されるのか？

[ウェブの画像リソースがどのようにサイズアップするか](#画像寸法)はすでに見たとおりです。しかし、ユーザーに表示される前、埋め込み画像はレイアウト内に配置されなければならず、レイアウトに合わせて縮小されたり引き伸ばされたりする可能性があります。

この分析を通じて、[クローラーのビューポート](./methodology#webpagetest)に留意することが有用です。デスクトップクローラーは幅1376px、DPRは1倍、モバイルクローラーは幅360px、DPRは3倍でした。

#### レイアウト幅

ここで一番シンプルな疑問は、こうかもしれません。 Webの画像は、ページに描かれたとき、どれくらいの幅になるのでしょうか。

{{ figure_markup(
  image="distribution-of-img-layout-widths.png",
  caption="`<img>`のレイアウト幅の分布。",
  description="デスクトップとモバイルの両方で、`<img>`のレイアウト幅の分布を示す棒グラフです。10パーセンタイルでは、デスクトップとモバイルのレイアウト幅はともに30CSS pxでした。25パーセンタイルの幅は、デスクトップが88px、モバイルが80pxであった。50パーセンタイルでは200pxと159px、75パーセンタイルでは318pxと300px、90パーセンタイルではデスクトップで558px、モバイルで340pxと比較的大きな数値が出ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1449895769&format=interactive",
  sheets_gid="1422214804",
  sql_file="image_layout_widths.sql"
)
}}

埋め込むリソースと同じように、ウェブ上の画像の多くは、レイアウトの中ではかなり小さなものになります。同様に、ほとんどのページには、かなり大きな画像が少なくとも1枚はあります。

{{ figure_markup(
  image="widest-img-per-page-layout-width.png",
  caption="1ページでもっとも幅の広い `<img>` を表示します（レイアウト幅）。",
  description="デスクトップとモバイルの両方で、年齢ごとのもっとも広い`<img>`のレイアウト幅の分布を示す棒グラフです。10パーセンタイルでは、デスクトップクローラーは148CSS px、モバイルクローラーは107pxを表示しました。25パーセンタイルの幅は、デスクトップが307px、モバイルが278pxでした。50パーセンタイルでは640pxと330px、75パーセンタイルでは1,176pxと360px、90パーセンタイルではデスクトップで1,905px、モバイルで453pxと屹立しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=334270155&format=interactive",
  sheets_gid="1318107523",
  sql_file="largest_image_per_page_layout.sql"
)
}}

モバイルページの75％以上が、75vw以上のビューポートを占める画像を少なくとも1つ持っています。その後、徐々に増加し、最終的にはかなりの数（10～25％）のページで、ビューポートより広い画像が表示されるようになります。これは、作者が[ビューポートメタタグ](https://developer.mozilla.org/ja/docs/Web/HTML/Viewport_meta_tag)を記述しておらず、デスクトップサイズのページがモバイル画面内に収まるように縮小されているためと思われます。

デスクトップのレイアウト幅と対比してみるとおもしろいのですが、デスクトップのレイアウト幅は頂点に達することはありません。幅はどんどん大きくなっています。デスクトップのページの10％以上が、クローラーのビューポート1360pxを超える幅の画像を含んでおり、おそらく水平スクロールバーを引き起こしていると思われるのは驚きです。

#### 本質的なサイジングと外在的なサイジング

なぜWebの画像はこのようなレイアウトサイズになってしまうのでしょうか？CSSで画像を拡大縮小する方法はたくさんあります。しかし、CSSをまったく使わずに画像を拡大縮小しているものはどれくらいあるのでしょうか？

画像は、すべての["置換された要素"](https://developer.mozilla.org/docs/Web/CSS/Replaced_element)と同様に、[固有のサイズ](https://developer.mozilla.org/docs/Glossary/Intrinsic_Size)を持っています。デフォルトでは、密度を制御する `srcset` やレイアウト幅を制御するCSSルールがない場合、ウェブ上の画像は1xの密度で表示されます。640×480の画像を`<img src>`に配置すると、デフォルトでその`<img>`は640CSSピクセル幅でレイアウトされます。

作者は、イメージの高さ、幅、またはその両方に、外付けのサイズ設定を適用できます。もし画像が一方の次元で外在的な大きさ（たとえば、`width: 100%;` のルール）を与えられ、他方の次元では本来の大きさ（`height: auto;` またはまったくルールなし）に任されていた場合、その画像は本来の縦横比を使って比例的に拡大されます。

さらに複雑なことに、いくつかのCSSルールでは、何らかの制約に違反しない限り、`<img>`はその本来の大きさで表示されます。たとえば、`max-width: 100%;` ルールを持つ `<img>` 要素は本質的な大きさになりますが、その本質的な大きさが `<img>` 要素のコンテナーのサイズより大きい場合は、外在的に縮小されてフィットします。

さて、ここまでの説明でWebの`<img>`という要素は、どのようにレイアウトされるのか、その大きさを説明します。

{{ figure_markup(
  image="intrinsic-and-extrinsic-image-sizing.png",
  caption="内在的・外在的なイメージサイジング。",
  description="幅と高さが外付けサイズと外付けサイズに基づいて決定された画像の割合を示す積み上げ棒グラフです。今のところ、「両方」という謎の3つ目のカテゴリがあります。高さと幅の場合、固有、外在、両方の分布はかなり異なっています。高さの場合、画像の59％が本質的なサイズ、31％が外在的なサイズ、残りの10％が両方に分類されます。幅については、9％の画像が本質的なサイズであり、67％が外在的なサイズ、残りの24％が両方に該当します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1534436519&format=interactive",
  sheets_gid="1153572147",
  sql_file="image_sizing_extrinsic_intrinsic.sql"
)
}}

大半の画像は外付けの幅を持ち、大半の画像は内付けの高さを持つ。幅の「両方」カテゴリは、`max-width`または`min-width`のいずれかのサイズ制約がある画像を表しますが、これもかなり人気があります。画像を本来の幅にすることは、はるかに人気がなく、[昨年](../2021/media#内在サイジングと外在サイジング)よりもわずかに人気がないようです。

#### `height`、`width`、累積レイアウトシフト

レイアウトサイズが固有の幅に依存する `<img>` は、<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">累積レイアウトシフト</a>を引き起こす危険があります。要するに、このような画像は2回レイアウトされる危険性があります。1回目はページのDOMとCSSが処理されたとき、2回目は読み込みが終了して本来のサイズが判明したときです。

先ほど見てきたように、高さ（とアスペクト比）はそのままにして、ある幅に合うように画像を外挿的にスケーリングすることは非常によくあることです。結果として生じるレイアウトのずれに対抗するため、数年前、ブラウザは<a hreflang="en" href="https://developer.mozilla.org/docs/Web/Media/images/aspect_ratio_mapping#a_new_way_of_sizing_images_before_loading_completes">`<img>` の `height` と `width` 属性の動作方法を変更することにしました</a>。最近では、リソースの縦横比を反映するように `height` と `width` 属性を一貫して設定することが、普遍的に推奨されるベストプラクティスとなっており、これにより作者は画像リソースの読み込み前、ブラウザにその固有の寸法を伝えることができます。

{{ figure_markup(
  content="28%",
  caption="モバイルの `<img>` 要素に `height` と `width` の両方の属性が設定されている割合です。",
  classes="big-number",
  sheets_gid="928689051",
  sql_file="img_with_dimensions.sql"
)
}}

残念ながら、ユニバーサル・アダプションに至るまでには、長い道のりがあります。

### デリバリー

最後に、ネットワーク上で画像がどのように配信されるかを見てみましょう。

#### クロスドメインイメージホスト

埋め込み先のドキュメントと異なるドメインから配信されている画像はどれくらいある？[昨年より3.6ポイント増](../2021/media#クロスオリジン画像ホスト)など、過半数を占める。

{{ figure_markup(
  image="image-hosts-cross-vs-same-domain.png",
  caption="イメージホスト：クロスドメインと同一ドメインの比較。",
  description="ルートHTMLページと同じドメインで配信された画像と、異なる（クロス）ドメインで配信された画像の数を示す棒グラフです。モバイルでは、画像の55%がクロスドメイン、45%が同一ドメインでした。デスクトップでは、53％がクロスドメインで、47％が同一ドメインでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1184925121&format=interactive",
  sheets_gid="431284065",
  sql_file="img_xdomain.sql"
)
}}

画像の大半がドメイン間で配信されるようになっているという事実は、<a hreflang="en" href="https://css-tricks.com/images-are-hard/">画像を正しく扱うことがいかに難しいか</a>を明確にし、<a hreflang="ja" href="https://web.dev/i18n/ja/image-cdns/">イメージCDN</a>にメディアの処理を依頼するメリットを示しています。

そして、次は `<img>` の若くてダイナミックな兄弟である `<video>` に注目しましょう。

## ビデオ

2010年に登場した`<video>`要素は、FlashやSilverlightなどのプラグインが廃止されて以来、Webサイトにビデオコンテンツを埋め込むための最良の、そして唯一の方法となっています。

ここ数年、ウェブコンテンツが変化していることを実感しています。かつては静止画（Flickr、Instagram）が主流でしたが、最近は動画（TikTok）が主流になってきています。この感覚は、Web Almanacのデータセットでも実証されているのでしょうか。私たちはウェブ上で`<video>`をどのように使っているのでしょうか？

### ビデオ採用

`<video>`要素の利用が増え続けている。

{{ figure_markup(
  image="adoption-of-video-over-time.png",
  caption="`<video>`の経時的な採用状況。",
  description="`<video>`要素を含むページの割合を時系列で示した折れ線グラフです。モバイルの数値は、デスクトップの数値より定期的に1ポイントずつ低くなっています。2010年秋の時点では、モバイルが4％弱、デスクトップが5％弱でスタートし、2020年秋には5％弱になります。2022年6月のグラフの終わりでは、モバイルが5％、デスクトップが6％強と、ほぼ直線的に上昇しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=642519393&format=interactive",
  sheets_gid="331851685",
  sql_file="video_adoption.sql"
)
}}

モバイルでは、`<video>`の使用率が2021年6月のページの4.3%から2022年6月のページの5%に上昇しました。20ページに1ページが`<video>`要素を含むようになり、前年比18%増となりました。ウェブに`<img>`と同じ数の`<video>`が登場することはないでしょうが、`<video>`の数は年々増加しています！

### ビデオの持続時間

その動画はどれくらいの長さなんですか？あまりありません！

{{ figure_markup(
  image="video-durations.png",
  caption="ビデオの持続時間です。",
  description="デスクトップとモバイルで、動画の長さを示す棒グラフです。モバイルの棒グラフにのみラベルを付けていますが、デスクトップの棒グラフはあまり変わりません。モバイルでは、0～10秒が23%、10～30秒は36%、30～60秒が19%、60～120秒は12%、120秒以上が10%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1553889662&format=interactive",
  sheets_gid="1432010937",
  sql_file="video_durations.sql"
)
}}

10本中9本の動画が2分以内。そして半数以上が30秒以下です。ほぼ4分の1の動画は10秒以下です。もしかしたら、これらは`<video>`の服を着たGIFなのかもしれません。

### フォーマット採用

2022年、サイトが配信するフォーマットは？<a hreflang="en" href="https://caniuse.com/mpeg4">ユニバーサル・サポート・ストーリー</a>を持つMP4は、王者です。

{{ figure_markup(
  image="top-extensions-of-files-with-a-video-mime-type.png",
  caption="ビデオのMIMEタイプを持つファイルの上位拡張子。",
  description="デスクトップとモバイルで配信された動画ファイルの拡張子を示す棒グラフです。デスクトップとモバイルの数値はほぼ同じで、モバイルの棒グラフにのみラベルが付けられています。動画ファイルの52％がMP4拡張子、26％が空白拡張子（モバイルではもっと多い）、12％がTS拡張子、6％がM4S、2％がWebM、最後に1％がMOVとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=153073113&format=interactive",
  sheets_gid="216837908",
  sql_file="video_ext.sql"
)
}}

しかし、MP4の数字は[昨年](../2021/media#fig-29)から数ティック下がっており、空白の拡張子を持つファイル、`.ts`ファイル、`.m4s`ファイルの増加が続いている。これらのファイルは、`<video>`が[HLS](https://en.wikipedia.org/wiki/HTTP_Live_Streaming)または[MPEG-DASH](https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP)を使用してアダプティブ・ビットレート・ストリーミングを採用している場合に配信されます。

アダプティブ ストリーミングを使用したレスポンシブな動画配信が増加傾向にあるのは心強いことです。同時に、Webプラットフォームが、JavaScriptに依存しない、<a hreflang="en" href="https://github.com/whatwg/html/issues/6363">アダプティブビデオのためのシンプルで宣言的な解決法</a>を提供してくれることを期待しています。

### エンベデッド

`<video>`要素には、ビデオをどのように読み込んでページ上に表示するかを制御するための属性がいくつか用意されています。ここでは、これらの属性を使用頻度の高い順に紹介します。

{{ figure_markup(
  image="video-attribute-usage.png",
  caption="`<video>`属性の使い方。",
  description="HTML video要素のさまざまな属性が、デスクトップとモバイルの両方で見つかった回数を示す棒グラフです。一般に、モバイルとデスクトップの棒グラフは似ていますが、モバイルの棒グラフにのみラベルが付けられています。autoplayは20%、preload 16%、width 12%、playsinline 11%、control 9%、src 8%、muted 8%、loop 7%、crossorigin 4%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1835151388&format=interactive",
  sheets_gid="1517058887",
  sql_file="video_attribute_names.sql"
)
}}

ここで解き明かすべきことはいくつもあります。

まず、`autoplay`が`preload`を抜いて今年もっとも人気のある属性となりました。また、`playsinline`、`muted`、`loop`の人気も高まっているようです。おそらく、<a hreflang="en" href="https://web.dev/replace-gifs-with-videos/">アニメーションGIFを置き換えるために`<video>`要素を使う</a>人が増えているのでしょう？もしそうなら、いいことだ！

つまり、ほとんどの `<video>` 要素は、これらの属性を持たない `<img>` 要素で見られたのと同じ種類の <a hreflang="en" href="https://web.dev/articles/cls">CLS</a>問題の影響を受けやすいということです。ブラウザの助けを借りて、これらの属性を追加してください！

また、`<video>`要素に`controls`属性を持つものが10個に1個以下であることから、かなりの数の人が動画と対話するための独自のユーザーインターフェイスを提供するプレイヤーを使用していることがわかります。

`preload`の使い方は、もう少し検討する必要がある。

#### `preload`

`preload`属性は、ここ数年、使用頻度が低下しています。

{{ figure_markup(
  image="video-preload-attribute-value-usage.png",
  caption="`<video preload>` 属性値の使い方です。",
  description="2020年、2021年、2022年のデスクトップとモバイルにおける、さまざまなプリロード属性値の普及状況を示す棒グラフ。2022年の棒グラフのみラベル付きです。2022年には、59%の動画要素でpreloadが使用されていない。この割合は2021年よりもわずかに大きく、バーが53%程度だった2020年よりも大幅に大きくなっています。none値は、2022年に15％のビデオ要素で使用されました。この数字は2年連続で減少しており、2020年には20％近くあった。Autoは、2022年には14％のビデオ要素で使用されました。これは2021年にわずかに減少しましたが、2022年には再びほぼ同じ量だけ増加しました。メタデータ値は、2022年には9％のビデオ要素で使用されました。これは、2020年の12％近くから年々減少しています。Emptyは2%の動画要素で使用され、これは前の2年間と変わっていないようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=1167702490&format=interactive",
  sheets_gid="192355478",
  sql_file="video_preload_values.sql"
)
}}

なぜか？私は、著者がブラウザの邪魔をしないようにするためだと思いたい。

動画データを読み込むタイミングは、ブラウザによって異なる。`preload`属性は、作者がそのプロセスをよりコントロールできるようにするための方法です。たとえば、`none`でブラウザにプリロードしないよう明示的に指示したり、`metadata`だけをプリロードするように指示したり、`auto`または空の値を使用してブラウザにプリロードするように指示したりすることができる。過去3年間、作者が動画の読み込みをあまりコントロールできなかったことは興味深く、おそらく心強いことでしょう。ブラウザは、ユーザーのコンテキストをもっともよく知っています。プリロード属性をまったく含めないことで、彼らが最善と考えることを行うことができます。

#### `src`と`<source>`

`src`属性は `<video>` 要素の8-9%にしか存在しません。残りの多くは、複数の `<source>` 子要素を使用し、作者が複数の代替フォーマットのビデオリソースを提供できるようにしています。

{{ figure_markup(
  image="number-of-sources-per-video.png",
  caption="`<video>`毎の`<source>`の数。",
  description="`video` 要素あたりの `source` 要素の数の頻度を示す棒グラフです。もっとも一般的な `video` ごとの `source` 要素の数は1つです。 51.25%のモバイル動画がこの数のソースを含んでいます。2番目に多い `source` の子要素の数は0です。デスクトップとモバイルの両方で、7.63%が2を、2.44%が3を、そして0.18%が4の要素を含む`video`要素を含んでいます。0.02% の要素に5つの子要素が含まれています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSsMG0kx2OTN-Dl9ap_Iu_99Ewpaf-X81B5EMTjVphfCJk953qZijIkGIfLF4mqCGlcrLWWzx_sWkJH/pubchart?oid=905380642&format=interactive",
  sheets_gid="1523141644",
  sql_file="video_number_of_sources.sql"
)
}}

`<video>`要素には、いくつの子要素がありますか？ほとんどは1つだけで、複数使うものはほとんどありません。

## 結論

2022年におけるウェブ上のメディア状況のスナップショットをご覧ください。画像や動画がいかにウェブに浸透しているか、そしてウェブの画像や動画がどのようにエンコードされ、埋め込まれているか、その一端を知ることができたと思います。今年のもっともエキサイティングな動きは、AVIFの採用が加速していることと、レイジーローディングとアダプティブ・ビットレート・ストリーミングの採用が増え続けていることです。

しかし、広色域の色空間がほとんどないこと、GIFという永遠のゾンビフォーマット（アニメーションと非アニメーションの両方）、`sizes`属性とレイジーローディングというパフォーマンスのために設計された2つの機能が（不適切な使用によって）かなりの数のページでパフォーマンスに影響を与えていることなど、不満な点もいくつかありました。

2023年、ウェブ上でより効果的なビジュアルコミュニケーションを実現するために！
