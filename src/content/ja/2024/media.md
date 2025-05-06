---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: メディア
description: 2024年Web Almanacのメディアの章では、画像や動画が現在どのようにエンコード、埋め込み、スタイル設定、配信されているかを紹介します。
hero_alt: Web Almanacのキャラクターたちが画面に映像を投影し、他のWeb Almanacキャラクターたちがポップコーンを持ってシネマの席に向かう様子を描いたヒーロー画像。
authors: [stefanjudis, eeeps]
reviewers: [svgeesus]
editors: [MichaelLewittes]
analysts: [stefanjudis, eeeps]
translators: [ksakae1216]
stefanjudis_bio: Stefan Judisは10年前にフロントエンド開発に恋をし、<a hreflang="en" href="https://www.stefanjudis.com/blog/">ブログ</a>や<a hreflang="en" href="https://webweekly.email/">ニュースレター</a>で公開して学んでいます。
eeeps_bio: <a href="https://ericportis.com">Eric Portis</a>は<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のWebプラットフォームアドボケイトです。
results: https://docs.google.com/spreadsheets/d/1Q2ITOe6ZMIXGKHtIxqK9XmUA1eQBX9CLQkxarQOJFCk/
featured_quote: ウェブ上の画像はますます大きくなっています。画像ピクセル数やレイアウトの寸法のどちらを数えても、数値は上昇しています。そのため、圧縮率の向上（一部は最新の画像フォーマットの採用増加による）にもかかわらず、画像の合計バイトサイズも増加しています。
featured_stat_1: 99.9%
featured_stat_label_1: 少なくとも1つの画像リソースをリクエストしたページの割合。
featured_stat_2: 32%
featured_stat_label_2: 2022年以降のビデオ採用の増加率。
featured_stat_3: 5分の1
featured_stat_label_3: 不正確な`sizes`属性の割合。
doi: 10.5281/zenodo.14552631
---

## はじめに

画像と動画はウェブのあらゆる場所に存在しています。しかし、これらがウェブページにエンコードされ埋め込まれる方法は驚くほど多様で複雑であり、ベストプラクティスも常に進化しています。Web Almanacは、この複雑さと私たちがそれをどのように管理しているかを確認する機会を提供し、ウェブ上のメディアの現状、これまでの進化、そして—もしかしたら—今後の方向性についての広範な視点を与えてくれます。さあ、始めましょう！

## 画像

最も一般的なメディアタイプである画像から始めましょう。画像のないウェブページを見ることはどれくらいありますか？私たちにとっては非常にまれで、もし画像がなければ、おそらくオタクな開発者のブログを見ているのでしょう。

1,000万以上のスキャンおよび解析されたページのうち、99.9%が少なくとも1つの画像をリクエストしたことは驚きではありません。

{{ figure_markup(
  caption="少なくとも1つの画像リソースをリクエストしたページの割合。",
  content="99.9%",
  classes="big-number",
  sheets_gid="186748113",
  sql_file="at_least_one_image_request.sql"
)
}}

ほとんどすべてのページが、背景画像やファビコンだけであっても、何らかの画像を提供しています。

1ページあたりに見つかった`<img>`要素はいくつありましたか？

{{ figure_markup(
  image="img-elements-per-page.png",
  caption="1ページあたりの`<img>`要素の数。",
  description="デスクトップとモバイルでのページごとの画像要素数の分布を示す棒グラフ。両者にはほとんど違いがありません（モバイルは一貫してわずかに少ない）。10パーセンタイルでは、モバイルとデスクトップのページともに1つの画像を含み、25パーセンタイルではモバイルで5つ、デスクトップで6つ、50パーセンタイルでは13と14、75パーセンタイルでは29と32、90パーセンタイルでは56と62です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=796561224&format=interactive",
  sheets_gid="76384810",
  sql_file="imgs_per_page.sql"
)
}}

モバイルページの中央値は13個の`<img>`要素を含んでいます。そして90パーセンタイルでも、ページは「わずか」56個の`<img>`しか含んでいません。今日のウェブのビジュアル的な性質を考えると、これは妥当なようです。

1ページに56個の`<img>`が多いと思うなら、モバイルクローラーが2,000個以上の`<img>`要素を含むページを見つけたとは言わないほうがいいでしょう。

{{ figure_markup(
  content="2,174",
  caption="1ページあたりの最多`<img>`要素数（モバイル）。",
  classes="big-number",
  sheets_gid="76384810",
  sql_file="imgs_per_page.sql"
)
}}

画像は単に普及し豊富なだけではありません。ほとんどの場合、ユーザー体験の中心的な部分でもあります。それを測定する一つの方法は、ページの最大コンテンツフル描画（LCP）に画像がどれだけ関与しているかを確認することです。

{{ figure_markup(
  content="68%",
  caption="LCP要素に画像を含むモバイルページの割合。",
  classes="big-number",
  sheets_gid="2001439429",
  sql_file="lcp_element_data.sql"
)
}}

ウェブ上での画像の重要性を強調しすぎることは難しいです。では、私たちが扱っているものを調査してみましょう！

### 画像リソース

リソース自体から始めましょう。ほとんどの画像はピクセルで構成されています（ベクター画像は一旦脇に置いておきましょう）。ウェブ上の画像は一般的に何ピクセルあるのでしょうか？

おそらく驚くべきことに、多くの画像はたった1ピクセルだけで構成されています！

#### 単一ピクセル画像

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>1×1画像</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>モバイル</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">6.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="1ピクセルだけを含む`<img>`要素によって読み込まれたリソース。", sheets_gid="297753608", sql_file="image_1x1.sql") }}</figcaption>
</figure>

1×1ピクセルの画像は、キャプチャされた画像リクエストの約6%を占めています。これらはおそらく、[昨年のメディアの章](../2022/media#1画素画像に関する注意点)で発見されたトラッキングビーコンやスペーサーGIFでしょう。そして振り返ってみると、嬉しいニュースがあります：1ピクセル画像の割合は2022年から1ポイント完全に低下しています。おそらく古い習慣が徐々に[より新しく優れた代替手段](https://developer.mozilla.org/docs/Web/API/Beacon_API)に置き換えられているのでしょう。

### 画像の寸法

ここで1×1よりも大きな画像に目を向けてみましょう。それらはどれくらいの大きさだったのでしょうか？

{{ figure_markup(
  image="image-pixel-count-distribution.png",
  caption="画像ピクセル数の分布。",
  description="デスクトップとモバイルでの画像あたりのピクセル数の分布を示す棒グラフですが、90パーセンタイルを除いて両者の間に実質的な違いはありません。10パーセンタイルでは、モバイル画像は0.001メガピクセル、25パーセンタイルでは0.013、50パーセンタイルでは0.058、75パーセンタイルでは0.262、そして90パーセンタイルでのモバイル画像は0.778メガピクセルを含んでいます。90パーセンタイルでのデスクトップ用の棒グラフはわずかに高く、0.85メガピクセル以上に達しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=71466048&format=interactive",
  sheets_gid="1417829992",
  sql_file="bytes_and_dimensions.sql"
)
}}

Web Almanacのモバイルクローラーはまったく成長していないにもかかわらず（360pxの幅のビューポートで、デバイスピクセル比3xでページをレンダリング）、0.058メガピクセルの中央値の画像は、[前回調査した時](../2022/media#画像寸法)よりも約25%大きくなっています。参考までに、正方形のアスペクト比では、0.058メガピクセルは約240×240になります。

ほとんどのページには、中央値の画像のピクセル数の約10倍のピクセルを持つ画像が1つあります：

{{ figure_markup(
  image="largest-image-per-page.png",
  caption="ページあたりの最大画像（ピクセル数別）。",
  description="ピクセル数でのページごとの最大画像の分布を示す棒グラフ。モバイルの棒グラフのみにラベルが付いています。10パーセンタイルでは、モバイルページの最大画像は0.023メガピクセルを含んでいます。25パーセンタイルでは0.138メガピクセル、50パーセンタイルでは0.540メガピクセル、75パーセンタイルでは1.280、そして90パーセンタイルでは3.130メガピクセルです。最初の2つのデスクトップの棒グラフはほぼ同じですが、50パーセンタイルでは、1.25倍まで高くなり始めます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1868037089&format=interactive",
  sheets_gid="1057576785",
  sql_file="largest_image_per_page_pixels.sql"
)
}}

正方形のアスペクト比では、0.54メガピクセルは約735×735になります。モバイルクローラーのビューポートと密度を考えると、多くのページに高密度で全幅表示される「ヒーロー」画像が1つあるのはかなり可能性が高いです。

それよりも大きな画像を送信しているページの50%に関しては、ほぼ確実にモバイルクローラーが実際に表示できるよりも多くのピクセルを送信しており、適切に書かれたレスポンシブ画像のマークアップでそのムダを防ぐことができたはずです。しかし、これについては後ほど詳しく説明します。

### 画像のアスペクト比

ウェブ上の画像のサイズについてある程度理解したところで、それらの形状はどうなっているのでしょうか？

{{ figure_markup(
  image="image-orientations.png",
  caption="画像の向き。",
  description="デスクトップとモバイルの両方で、どの割合の画像が縦向き、横向き、正方形であるかを示す積み上げ棒グラフのペア。デスクトップの内訳は：縦向き13%、正方形33%、横向き54%。モバイルの内訳は：縦向き14%、正方形33%、横向き53%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=774294848&format=interactive",
  sheets_gid="60298066",
  sql_file="portrait_landscape_square.sql"
)
}}

ほとんどの画像は縦よりも横幅が広く、8分の1だけが横よりも縦が長く、完全に3分の1が正確に正方形です。正方形は断然、最も人気のある正確なアスペクト比です：

<figure>
  <table>
    <thead>
      <tr>
        <th>アスペクト比（幅 / 高さ）</th>
        <th>画像の割合</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1:1</td>
        <td class="numeric">33.2%</td>
      </tr>
      <tr>
        <td>4:3</td>
        <td class="numeric">3.5%</td>
      </tr>
      <tr>
        <td>3:2</td>
        <td class="numeric">2.9%</td>
      </tr>
      <tr>
        <td>2:1</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>16:9</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>3:4</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>2:3</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>5:3</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位の画像アスペクト比（モバイル）。", sheets_gid="212159042", sql_file="top_aspect_ratios.sql") }}</figcaption>
</figure>

このデータは2年前とほとんど変わっていません。依然としてデスクトップベースのブラウジングへの偏りを示しているようです—クリエイターは縦向きのモバイル画面を大きく美しい縦向きの画像で埋める機会を逃しています。

### 画像の色空間

特定の画像内で可能な色の範囲は、その画像の[色空間](https://wikipedia.org/wiki/Color_space)によって決まります。ウェブ上のデフォルトの色空間は[sRGB](https://wikipedia.org/wiki/SRGB)です。画像が別の色空間を使用していることを示さない限り、<a hreflang="en" href="https://imageoptim.com/color-profiles.html">ブラウザはsRGBを使用します</a>。

画像に明示的に色空間を割り当てる従来の方法は、[ICCプロファイル](https://wikipedia.org/wiki/ICC_profile)を画像内に埋め込むことです。データセットでクロールされたすべての画像に埋め込まれたすべてのICCプロファイルを調査しました。

以下がトップ10です：

<figure>
  <table>
    <thead>
      <tr>
        <th>ICCプロファイルの説明</th>
        <th>sRGB系</th>
        <th>広色域</th>
        <th>画像の割合</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ICCプロファイルなし</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">87.7%</td>
      </tr>
      <tr>
        <td>sRGB IEC61966-2.1</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">3.8%</td>
      </tr>
      <tr>
        <td>c2ci</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td>sRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>uRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>Adobe RGB (1998)</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>Display P3</td>
        <td></td>
        <td>✓</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>c2</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>GIMP built-in sRGB</td>
        <td>✓</td>
        <td></td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Display</td>
        <td></td>
        <td></td>
        <td class="numeric">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="トップICCプロファイル（モバイル）。", sheets_gid="644447618", sql_file="color_spaces_and_depth.sql") }}</figcaption>
</figure>

ウェブ上の画像の大部分は、正しいレンダリングのためにsRGBのデフォルトに依存しており、ICCプロファイルをまったく含んでいません。

最も一般的なICCプロファイルは、完全な公式のsRGBカラープロファイルです。このプロファイルは比較的重く、3 KBの重さがあります。したがって、トップ10のICCプロファイルの残りのほとんどは、<a hreflang="en" href="https://photosauce.net/blog/post/making-a-minimal-srgb-icc-profile-part-1-trim-the-fat-abuse-the-spec">Clinton Ingrahmの424バイトのc2ci</a>のような「sRGB系」プロファイルで、最小限のオーバーヘッドで画像がsRGBを使用していることを明確に指定しています。

この10年間で、ハードウェアとソフトウェアはますますsRGBで可能な色の範囲（いわゆるsRGB[色域](https://wikipedia.org/wiki/Gamut)）の外側にある色をキャプチャして表示できるようになっています。Adobe RGB (1998)とDisplay P3は、トップ10に唯一2つの「広色域」プロファイルです。[Adobe RGB (1998)の使用率は2022年からわずかに減少しましたが、Display P3は増加し](../2022/media#fig-8)、<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Q2ITOe6ZMIXGKHtIxqK9XmUA1eQBX9CLQkxarQOJFCk/edit?gid=644447618#gid=644447618">広色域ICCプロファイルの採用は相対的に約10%増加しています</a>。絶対的な意味では、広色域ICCプロファイルはまだ比較的まれです。ウェブ上の画像の80分の1、ICCプロファイルを持つ画像の10分の1に見つかりました。

ここで非常に重要な注意点は、私たちの分析ではICCプロファイルだけを調査できたということです。前述の通り、これらのプロファイルは比較的重いものです。AVIFのような最新の画像形式（そして<a hreflang="en" href="https://github.com/w3c/png/blob/main/Third_Edition_Explainer.md#labelling-hdr-content">最近近代化されたPNGのような形式</a>）では、CICPと呼ばれる標準を使用して画像の色空間をはるかに効率的に示すことができます—<a hreflang="en" href="https://www.w3.org/TR/png-3/#cICP-chunk">これにより一般的な色空間をわずか4バイトで示すことができます</a>。現代的なPNGエンコーダや価値のあるAVIFエンコーダは、広色域の色空間を示すためにICCの代わりにCICPを使用するのが道理にかなっています。

しかし、私たちの分析では、CICPを含む画像は「ICCプロファイルなし」に分類されています。したがって、ウェブ上の広色域の使用に関する私たちの計算は、総採用率の推定値ではなく、下限と見なすべきです。言い換えれば、ウェブ上の画像の少なくとも80分の1は広色域であることがわかりました。

## エンコード

ここまでウェブの画像リソースがどのようにエンコードされているかを把握したところで、それらがウェブサイトにどのように埋め込まれているかについて見ていきましょう。

### フォーマットの採用状況

数十年間、ウェブ上で一般的に使用されていたビットマップフォーマットはJPG、PNG、GIFの3つだけでした。これらは今でも3つの最も一般的なフォーマットです：

{{ figure_markup(
  image="image-format-adoption-mobile.png",
  caption="画像フォーマットの採用状況（モバイル）。",
  description="ウェブの画像における各フォーマットのシェアを示す円グラフ。JPEGが32.4%で1位です。次にPNGが28.4%、GIFが16.8%、WebPが12%、SVGが6.4%、その他/不明が1.7%です。円グラフの非常に小さな部分にはラベルがついていませんが、ホバーするとICOが1.3%、AVIFが1.0%であることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=424926454&format=interactive",
  sheets_gid="1939630368",
  sql_file="media_formats.sql"
)
}}

しかし、変化が起きていることを嬉しく報告できます。2022年以降の使用率における最大の絶対的変化はJPEGで、2022年のすべての画像の40%から8ポイント減少して2024年には32%になりました。これは2年間で大きな減少です。

その差を埋めるためにどのフォーマットがより多く使用されるようになったのでしょうか？WebPは3ポイント増加し、SVGは2ポイント弱増加し、AVIFはほぼ1ポイント増加しました。最も驚くべきことに、最も古く効率の悪いフォーマットであるGIFも1ポイント増加しました。

そして相対的な意味では、AVIFの使用は急増しています—2年前と比べて、クロールされたページで提供されるAVIFはほぼ4倍になりました。

{{ figure_markup(
  image="image-format-adoption-2-year-change-mobile.png",
  caption="画像フォーマットの採用、2年間の変化（モバイル）。",
  description="7つの画像フォーマットについて、フォーマット採用の相対的な2年間の変化を示す棒グラフ。JPEGは20%減少、PNGは1%増加、GIFは6%増加、WebPは34%増加、SVGは36%増加、ICOは17%減少、そしてAVIFは386%増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=2128858223&format=interactive",
  sheets_gid="1939630368",
  sql_file="media_formats.sql"
)
}}

クローラーが<a hreflang="en" href="https://jpeg.org/jpegxl/">JPEG XL</a>を受け入れていれば、おそらくかなりの数のJPEG XLも見られたでしょう。残念ながら、<a hreflang="en" href="https://caniuse.com/jpegxl">Chromiumベースのブラウザはこのフォーマットをサポートしていません</a>。

ウェブ上のJPEG、PNG、GIFのほとんどすべては、最新のフォーマットを使用したほうが良いでしょう。WebPは良いですが、AVIFとJPEG XLはさらに優れています。ウェブ上のすべての画像という巨大な船が、これらのより効率的なフォーマットへとゆっくりではあるが確実に方向転換していくのは良いことです。またSVGの使用率が上昇していることも良いことです！

最後に、最も古いフォーマットについて少し言及しておきましょう：「<a hreflang="en" href="https://www.theatlantic.com/past/docs/unbound/citation/wc991103.htm">すべてのGIFを燃やせ</a>」は1999年に良いアドバイスでしたが、今日ではさらに良いアドバイスです。開発者はこの37年前のフォーマットを置き換える方法について<a hreflang="en" href="https://cloudfour.com/thinks/video-gifs-are-forever-lets-make-them-better/">Tyler Stickaのアドバイス</a>に従うべきです。

### バイトサイズ

ウェブ上の典型的な画像はどれくらい重いのでしょうか？

{{ figure_markup(
  image="distribution-of-image-byte-sizes.png",
  caption="画像バイトサイズの分布。",
  description="デスクトップとモバイルの両方での画像バイトサイズの分布を示す棒グラフです。モバイルの棒グラフのみにラベルが付いており、デスクトップとモバイルの数値にはほとんど違いがありません。10パーセンタイルでは0キロバイト、25パーセンタイルでは2 KB、50パーセンタイルでは12 KB、75パーセンタイルでは56 KB、そして90パーセンタイルでは177 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1659171071&format=interactive",
  sheets_gid="1417829992",
  sql_file="bytes_and_dimensions.sql"
)
}}

中央値の12 KBは「そんなに重くないじゃないか！」と思わせるかもしれません。しかし、ピクセル数を見たときと同様に、ほとんどのページには多くの小さな画像と、少なくとも1つの大きな画像が含まれていることがわかりました。

{{ figure_markup(
  image="largest-image-per-page-by-kilobytes.png",
  caption="ページあたりの最大画像（キロバイト別）。",
  description="キロバイトで見たページごとの最大画像の分布を示す棒グラフ。デスクトップとモバイルの両方の棒グラフが表示されていますが、モバイルの棒グラフにのみラベルが付いています。デスクトップの数値はすべて約10〜20%大きく表示されています。10パーセンタイルでは、モバイルでのページあたりの最大画像は6 KBの重さがあり、25パーセンタイルでは37 KB、50パーセンタイルでは135 KB、75パーセンタイルでは404 KB、そして90パーセンタイルでは1002 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=2122518926&format=interactive",
  sheets_gid="117141741",
  sql_file="largest_image_per_page_bytes.sql"
)
}}

ほとんどのモバイルページには、135 KB以上の画像が1つあります。これは2022年以降8%の増加です。そして分布の上位に行くほど、加速しています：75パーセンタイルは10%増加し、90パーセンタイルは13%増加（ほぼ正確に1メガバイト）しています。

画像はより重くなり、最も重い画像はより速く重くなっています。

### ピクセルあたりのビット数

バイト数とピクセル数はそれ自体で興味深いですが、ウェブ上の画像データがどれだけ圧縮されているかを知るためには、バイト数とピクセル数を組み合わせてピクセルあたりのビット数を計算する必要があります。これにより、画像の解像度が異なる場合でも、画像の情報密度を同等に比較することができます。

一般的に、ウェブ上のビットマップは、チャネルごと（ピクセルごと）に8ビットの非圧縮情報としてデコードされます。したがって、透明度のないRGB画像がある場合、デコードされた非圧縮画像はピクセルあたり24ビットの重さになると予想できます。

可逆圧縮に関する良い経験則は、ファイルサイズが2:1の比率で縮小されるべきということです（8ビットのRGB画像の場合、ピクセルあたり12ビットになります）。1990年代の非可逆圧縮方式（JPEGやMP3）の経験則は10:1の比率（ピクセルあたり2.4ビット）でした。

画像の内容とエンコード設定に応じて、これらの比率は大きく異なり、<a hreflang="en" href="https://github.com/mozilla/mozjpeg">MozJPEG</a>や<a hreflang="en" href="https://opensource.googleblog.com/2024/04/introducing-jpegli-new-jpeg-coding-library.html">Jpegli</a>のような最新のJPEGエンコーダは、デフォルト設定でこの10:1の目標を上回ることが多いことに注意すべきです。

要約すると：

<figure>
  <table>
    <thead>
      <tr>
        <th>ビットマップデータの種類</th>
        <th>予想される圧縮率</th>
        <th>ピクセルあたりのビット数</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>非圧縮RGB</td>
        <td>1:1</td>
        <td>24ビット/ピクセル</td>
      </tr>
      <tr>
        <td>可逆圧縮RGB</td>
        <td>~2:1</td>
        <td>12ビット/ピクセル</td>
      </tr>
      <tr>
        <td>1990年代の非可逆RGB</td>
        <td>~10:1</td>
        <td>2.4ビット/ピクセル</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="ビットマップRGBデータの典型的な圧縮率と結果として生じるピクセルあたりのビット数。" ) }}</figcaption>
</figure>

そこで、これらすべてを背景として、ウェブ上の画像はどのようになっているでしょうか：

{{ figure_markup(
  image="distribution-of-image-bits-per-pixel.png",
  caption="画像のピクセルあたりビット数の分布。",
  description="デスクトップとモバイルの両方で、画像のピクセルあたりビット数の分布を示す棒グラフ。デスクトップの棒グラフは一貫してモバイルの棒グラフよりわずかに短いですが、ラベルは付いていません。10パーセンタイルでは、ウェブの画像はモバイルでピクセルあたり0.1ビットの重さがあります。25パーセンタイルでは0.9、50パーセンタイルでは2.1、75パーセンタイルでは5.6、そして90パーセンタイルでは、モバイル画像はなんとピクセルあたり12.9ビットの重さがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=400614419&format=interactive",
  sheets_gid="1417829992",
  sql_file="bytes_and_dimensions.sql"
)
}}

中央値の画像はピクセルあたり2.1ビットに圧縮されており、これは1990年代の経験則よりも少し多い圧縮を表しています。これはまた、[2022年に最後にウェブの画像を調査したとき](../2022/media#fig-14)に見た圧縮率よりも8〜10%多い圧縮です。

圧縮をフォーマット別に分類すると、2022年と比較して2024年はすべてのフォーマットでピクセルあたりに費やされるビットが少なくなっていることが分かります—1つを除いて。

#### フォーマット別のピクセルあたりビット数

{{ figure_markup(
  image="median-bits-per-pixel-by-format.png",
  caption="フォーマット別の中央値ピクセルあたりビット数。",
  description="いくつかの人気のある画像フォーマットについて、フォーマット別の中央値ピクセルあたりビット数を示す棒グラフ。デスクトップとモバイルの数値は類似しており、モバイルの棒グラフにのみラベルが付いています。GIFはピクセルあたり6.7ビット、PNG：3.8、JPG：2.0、AVIF：1.4、そしてWebPが最も小さくピクセルあたり1.3ビットです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=165542730&format=interactive",
  sheets_gid="1416380443",
  sql_file="bytes_and_dimensions_by_format.sql"
)
}}

[2022年と比較して](../2022/media#fig-15)、モバイルでは、中央値のPNGは約10%多く圧縮され、中央値のWebPは約7%多く圧縮され、中央値のJPEGは約3%多く圧縮されています。ここでの原因を正確に知ることは難しいですが、私たちは圧縮の増加は2つのことのより広い採用の結果であると仮説しています：より多くの価値を提供する最新のエンコーダと、すべての画像がユーザーに届く前に適切に圧縮されていることを確認する自動画像処理パイプラインです。

この傾向に逆らった1つのフォーマットはAVIFでした。中央値のAVIFのピクセルあたりビット数は、2022年の約1.0から2024年には約1.4ビット/ピクセルに増加しました—これは47%の増加です。面白いことに、私たちは同じ根本原因を仮説としています。現在の多様なAVIFエンコーダは、2年前のAOMの公式libavifエンコーダよりもデフォルト設定で品質を犠牲にすることが少ない、異なる品質/ファイルサイズのトレードオフを行っている可能性が高いです。

GIFがなぜ大幅に効率的になったのかはわかりませんが、なぜGIFが他のすべてのフォーマットよりもはるかに圧縮率が低いのかはわかります。私たちのクエリはピクセルごとであり、多くのGIFがアニメーションであるにもかかわらず、アニメーション画像を考慮していません！

### GIF、アニメーションとそうでないもの

どれだけのGIFがアニメーションなのでしょうか？

{{ figure_markup(
  content="32%",
  caption="モバイルでアニメーションだったGIFの割合。",
  classes="big-number",
  sheets_gid="501019705",
  sql_file="animated_gif_count.sql"
)
}}

アニメーションGIFとアニメーションではないGIFを分けてみると、アニメーションではない中央値のGIFははるかに合理的に圧縮されていることがわかります：

{{ figure_markup(
  image="gif-bits-per-pixel-animated-non-animated.png",
  caption="GIFのピクセルあたりビット数：アニメーションvsアニメーションなし。",
  description="アニメーションGIFとアニメーションなしGIFのピクセルあたりビット数の分布を示す棒グラフ。アニメーションGIFの棒グラフはアニメーションなしGIFの棒グラフを圧倒しています。アニメーションGIFは10、25、50、75、90パーセンタイルでそれぞれ4.5、12.1、32.6、60.6、82.6ビット/ピクセルの重さがあります。アニメーションなしGIFの進行は次の通りです：0.9、1.8、3.5、5.7、9.3ビット/ピクセル。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1948267327&format=interactive",
  sheets_gid="1251617650",
  sql_file="animated_gif_bpp.sql"
)
}}

3.5ビット/ピクセルは中央値のPNGよりも少ないです！

特にアニメーションGIFに目を向けると：それらはどれくらいのフレーム数を持っているのでしょうか？

{{ figure_markup(
  image="distribution-of-animated-gif-frame-counts.png",
  caption="アニメーションGIFフレーム数の分布。",
  description="アニメーションGIFフレーム数の分布を示す棒グラフ。このグラフはデスクトップとモバイルの両方を示していますが、モバイルの数値にのみラベルが付いています。90パーセンタイルまで棒グラフは全く同じに見えます。10パーセンタイルでは、モバイルとデスクトップの両方でGIFあたり4フレームでした。25パーセンタイルでは両方とも8フレームです。50パーセンタイルでは両方とも12フレーム、75パーセンタイルでは両方とも24フレームです。最後に、90パーセンタイルでは、デスクトップクローラーは46フレーム、モバイルクローラーは60フレームを見ました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=230229356&format=interactive",
  sheets_gid="810988388",
  sql_file="animated_gif_framecount.sql"
)
}}

一般的には：10〜20フレームで、[これは2022年からほとんど変わっていません](../2022/media#fig-18)が、最も長いGIFは特にモバイルでより長くなっています。

参考までに、最も多くのフレーム数を持つGIFも調査しました：

{{ figure_markup(
  content="54,028",
  caption="データセット内の最高GIFフレーム数。",
  classes="big-number",
  sheets_gid="810988388",
  sql_file="animated_gif_framecount.sql"
)
}}

24フレーム/秒では、一通り再生するのに37分以上かかります。すべてのアニメーションGIFはおそらく現在では動画であるべきですが、これは間違いなくそうあるべきです。

## 埋め込み

ウェブの画像リソースがどのようにエンコードされているかを理解したところで、それらがウェブサイトにどのように埋め込まれているかについて何が言えるでしょうか？

### 遅延読み込み

ウェブサイトに画像が埋め込まれる方法における最近の最大の変化は、遅延読み込みの急速な採用でした。遅延読み込みは2020年に導入され、[わずか2年後にはほぼ4分の1のウェブサイトで採用されました](../2022/media#レイジーローディング)。その上昇は続き、現在ではすべてのウェブサイトの完全に3分の1で使用されています：

{{ figure_markup(
  image="adoption-of-img-loading-lazy.png",
  caption="遅延読み込み（`<img loading=lazy>`）の採用状況。",
  description="モバイルとデスクトップの両方で、時間の経過に伴うネイティブ遅延読み込みを使用しているページの割合を示す折れ線グラフ。線は互いにかなり近く、2022年6月のわずか25%未満から2024年6月のわずか35%未満まで、ほぼ直線的に上昇しています（多少の波がありますが）。どの1か月でも最も急な上昇は最後にあり、そこに鋭い小さな上昇があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1997305111&format=interactive",
  sheets_gid="228292115",
  sql_file="lazy_loading_adoption_over_time.sql"
)
}}

そして、昨年と同様に、遅延読み込みを少し使いすぎているようです：

{{ figure_markup(
  content="9.5%",
  caption="モバイルでネイティブ遅延読み込みを使用しているLCP対象の`<img>`要素の割合。",
  classes="big-number",
  sheets_gid="2001439429",
  sql_file="lcp_element_data.sql"
)
}}

LCP要素を遅延読み込みすることは、[ページを大幅に遅くするアンチパターン](https://web.dev/articles/lcp-lazy-loading)です。LCP対象の`<img>`の10個に1個近くが遅延読み込みされていることは落胆させられますが、過去2年間でわずかに改善されていることを報告できることは嬉しいことです。違反サイトの割合は2022年から0.3パーセントポイント減少しています。

### `alt` テキスト

`<img>`要素で埋め込まれる画像は、内容を持つべきものです。つまり、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#a-purely-decorative-image-that-doesn't-add-any-information">単なる装飾ではなく</a>、意味のあるものを含むべきです。<a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/non-text-content">WCAG要件</a>と<a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#alt">HTML仕様</a>の両方によれば、ほとんどの場合、`<img>`要素には代替テキストが必要であり、その代替テキストは`alt`属性によって提供されるべきです。

{{ figure_markup(
  content="55%",
  caption="空でない`alt`属性を持つ画像の割合。",
  classes="big-number",
  sheets_gid="694600230",
  sql_file="image_alt.sql"
)
}}

残念ながら、`<img>`要素の45パーセントには`alt`テキストがありません。さらに悪いことに、[今年のアクセシビリティの章からの詳細な分析](./accessibility#画像)によると、`alt`テキストを持つ`<img>`の多くも、その属性にはファイル名や他の意味のない短い文字列しか含まれていないため、それほどアクセシブルではありません。

2022年以降、`alt`テキストの導入は1パーセントポイント増加していますが、私たちはさらに—そしてそうしなければなりません—改善できます。

### `srcset`

遅延読み込みの前に、ウェブ上の`<img>`要素に起きた最大の変化は、「レスポンシブイメージ」のための機能セットで、これによって画像がレスポンシブデザイン内に適合するように調整できるようになりました。2014年に最初にリリースされた`srcset`属性、`sizes`属性、`<picture>`要素は現在10年の歴史を持っています。私たちはこれらをどれくらいの頻度で、どれくらい上手に使用しているでしょうか？

まず、`srcset`属性から見ていきましょう。これによって作成者は、コンテキストに応じてブラウザに選択肢となるリソースのメニューを提供できます。

{{ figure_markup(
  content="42%",
  caption="モバイルで`srcset`属性を使用しているページの割合。",
  classes="big-number",
  sheets_gid="2067327124",
  sql_file="image_srcset_sizes.sql"
)
}}

[前回確認した時、この数字は34%でした](../2022/media#srcset)—2年間で8パーセントポイントの増加は重要であり、勇気づけられます。

`srcset`属性により、作成者は2つの記述子のいずれかを使用してリソースを記述できます。`x`記述子はリソースの密度を指定し、ブラウザがユーザーの画面密度に応じて異なるリソースを選択できるようにします。`w`記述子はブラウザにリソースの幅をピクセル単位で提供します。`sizes`属性と組み合わせて使用すると、`w`記述子によりブラウザは可変レイアウト幅と可変画面密度の両方に適したリソースを選択できます。

{{ figure_markup(
  image="srcset-descriptor-usage.png",
  caption="`srcset`記述子の使用状況。",
  description="`x`記述子と`w`記述子を使用している`srcset`の割合を示す棒グラフで、モバイルとデスクトップの両方を示しています。`x`記述子はデスクトップとモバイルの両方で`srcset`の15%で使用されています。`w`記述子は4倍多く使用されており、デスクトップでは64%、モバイルでは62%の頻度で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1554380054&format=interactive",
  sheets_gid="1810212061",
  sql_file="image_srcset_descriptor.sql"
)
}}

`x`記述子が最初に出荷され、理解しやすいものですが、`w`記述子はより強力です。`w`記述子がより一般的であることを見るのは勇気づけられます。そして、`x`記述子の採用は2022年からほとんど増加していませんが、[`w`記述子の使用はまだ成長し続けています](../2022/media#fig-23)—`w`記述子の採用はモバイルで4パーセントポイント、デスクトップで6パーセントポイント増加しています。

### `sizes`

先ほど、`w`記述子は`sizes`属性と組み合わせて使用すべきだと述べました。では、私たちは`sizes`をどれくらい上手に使用しているでしょうか？あまり上手ではありません！

`sizes`属性は、画像の最終的なレイアウト幅についてブラウザへのヒントとなるもので、通常はビューポート幅に対する相対値です。`sizes`属性は明示的にヒントであることが意図されているため、多少の不正確さは問題なく、むしろ予想されています。

しかし、`sizes`属性が少し以上に不正確である場合、リソース選択に影響を与える可能性があり、実際の画像のレイアウト幅が大きく異なる場合でも、ブラウザが`sizes`幅に合わせて画像を読み込む原因となります。

では、私たちの`sizes`はどれくらい正確でしょうか？

{{ figure_markup(
  image="distribution-of-img-sizes-errors.png",
  caption="`<img sizes>`エラーの分布。",
  description="デスクトップとモバイルの両方での`sizes`属性の相対的なエラーの分布を示す棒グラフ。最初はすべてゼロで、10パーセンタイルと25パーセンタイルではデスクトップとモバイルの両方で0%です。50パーセンタイルではデスクトップで43%、モバイルで16%、75パーセンタイルではそれぞれ168%と94%、そして90パーセンタイルではデスクトップで360%、モバイルで179%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=16669482&format=interactive",
  sheets_gid="776888472",
  sql_file="image_srcset_sizes_per_image_accuracy_impact.sql"
)
}}

多くの`sizes`属性は完全に正確ですが、中央値の`sizes`属性はモバイルで16%、デスクトップで43%大きすぎます。この機能のヒント的な性質を考えると問題ないかもしれませんが、ご覧のように、75パーセンタイルと90パーセンタイルはかなり悪い状況です。最も懸念されるのは、[これらの数値がすべて過去2年間で大幅に悪化している](../2022/media#fig-24)ことで、デスクトップの中央値の`sizes`は2年前よりも2倍以上不正確になっています。

こうした不正確さの影響はどれほどでしょうか？

{{ figure_markup(
  content="20%",
  caption="デスクトップで`srcset`選択に影響を与えるほど不正確だった`sizes`属性の割合。モバイルでは14%です。",
  classes="big-number",
  sheets_gid="1503721277",
  sql_file="image_srcset_sizes_accuracy_pct.sql"
)
}}

デスクトップでは、デフォルトの`sizes`値（`100vw`）と画像の実際のレイアウト幅の差がモバイルよりも大きくなる可能性が高く、5つに1つの`sizes`属性が不正確すぎて、ブラウザが`srcset`から最適ではないリソースを選択する原因となっています。これらのエラーは積み重なります。

{{ figure_markup(
  image="excess-kilobytes-loaded-per-page-due-to-inaccurate-sizes.png",
  caption="不正確な`sizes`によってページごとに読み込まれる余分なキロバイト。",
  description="不正確な`sizes`属性によってページごとに無駄に読み込まれるキロバイトの分布を示す棒グラフ。最初はゼロばかりです。10パーセンタイル、25パーセンタイル、50パーセンタイルでは、モバイルとデスクトップの両方でゼロキロバイトです。75パーセンタイルでは、デスクトップクローラーは179キロバイト、モバイルでは55キロバイトの無駄を検出し、90パーセンタイルでは、デスクトップでは920キロバイト、モバイルでは400キロバイトでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=736387424&format=interactive",
  sheets_gid="252030871",
  sql_file="image_sizes_per_page_accuracy_impact.sql"
)
}}

私たちの推定では、`w`記述子を使用するデスクトップページの4分の1が、不正確な`sizes`属性のために180KB以上の無駄な画像データを読み込んでいます。つまり、`srcset`にはより良い、より小さなリソースがあるにもかかわらず、`sizes`属性が非常に誤っているため、ブラウザはそれを選択しません。`w`記述子を使用するデスクトップページの最も悪い10%は、不良な`sizes`属性のために約1メガバイトの余分な画像データを読み込んでいます。

これはかなり問題ですが、さらに悪いことに、これらの数字はすべて、わずか2年前と比較して約2倍悪化しています。状況は悪く、さらに悪化しています。

<aside class="note">注: 私たちのクローラーは実際には正しいリソースを読み込んでいないため、ここでの数値は推定値です。この推定値は、クローラーが実際に読み込んだ不正確なリソースの圧縮密度とアスペクト比に基づいています。</aside>

開発者が追求すべき2つの解決策があります。

LCP対象および他の重要な画像については、開発者は`sizes`属性を修正する必要があります。`sizes`を監査および修正するための最良のツールは<a hreflang="en" href="https://ausi.github.io/respimagelint/">RespImageLint</a>で、これは他の多くのレスポンシブ画像の問題も修正するのに役立ちます。

ビューポート外（below-the-fold）や重要でない画像については、作成者は<a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#:~:text=In%20this%20case%2C%20the%20sizes%20attribute%20can%20use%20the%20auto%20keyword">`sizes="auto"`</a>を採用し始めるべきです。この値は遅延読み込みと組み合わせてのみ使用できますが、ブラウザに`<img>`の実際のレイアウトサイズを`sizes`値として使用するよう指示し、使用される値が完全に正確であることを保証します。

遅延読み込み画像の自動`sizes`は現在Chromeでのみ実装されていますが、SafariとFirefoxの両方がそれをサポートする意向を表明しています。彼らがすぐにそれを実装し、開発者が（フォールバック値を伴って）今すぐそれを展開し始めることを期待しています。

### `<picture>`

2014年に最後に登場したレスポンシブイメージ機能は`<picture>`要素でした。`srcset`がブラウザに選択肢となるリソースのメニューを提供するのに対し、`<picture>`要素は作者が主導権を握り、どの子`<source>`要素からリソースを読み込むかについての明示的なコンテキスト適応型の指示をブラウザに与えることができます。

`<picture>`要素は`srcset`よりもはるかに少なく使用されています：

{{ figure_markup(
  content="9.3%",
  caption="`<picture>`要素を使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="1095160660",
  sql_file="picture_distribution.sql"
)
}}

この数字は2022年から1.5パーセントポイント以上増加していますが、`<picture>`を使用する1ページに対して`srcset`を使用するページが4ページ以上あるという事実は、`<picture>`のユースケースがより限定的であるか、`<picture>`の導入がより困難であるか、あるいはその両方であることを示唆しています。

人々は`<picture>`をどのような目的で使用しているのでしょうか？

`<picture>`要素は、作者にリソースを切り替える2つの方法を提供します。タイプ切り替えにより、作者は最先端の画像フォーマットをサポートするブラウザに提供し、他のすべてのブラウザにはフォールバックフォーマットを提供することができます。メディア切り替えは<a hreflang="en" href="https://www.w3.org/TR/respimg-usecases/#art-direction">アートディレクション</a>を容易にし、作者が<a hreflang="en" href="https://www.w3.org/TR/mediaqueries-5/#media-condition">メディア条件</a>に基づいて`<source>`間を切り替えることを可能にします。

{{ figure_markup(
  image="picture-feature-usage.png",
  caption="`<picture>`機能の使用状況。",
  description="`picture`要素と組み合わせて、`source`要素上で`media`属性と`type`属性を使用しているページの割合を示す棒グラフ。`media`はモバイルでは`picture`要素の40%、デスクトップでは37%で使用されています。`type`はモバイルとデスクトップの両方で`picture`要素の46%で使用されています（ただし、モバイルの棒グラフはわずかに大きくなっています）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=68600519&format=interactive",
  sheets_gid="1248341599",
  sql_file="picture_switching.sql"
)
}}

2022年から`media`属性の使用は3パーセントポイント減少していますが、`type`切り替えの使用は3パーセントポイント増加しています。この増加は、次世代画像フォーマット、特にまだ普遍的なブラウザサポートを享受していないJPEG XLの人気の高まりと関連している可能性が高いです。

## レイアウト

私たちはすでに[ウェブの画像リソースがどのようなサイズであるか](#画像の寸法)を見てきました。しかし、ユーザーに表示される前に、埋め込まれた画像はレイアウト内に配置され、場合によっては押しつぶされたり引き伸ばされたりして適合させる必要があります。

<aside class="note">注: その分析のためには、[クローラーのビューポート](./methodology#webpagetest)を考慮することが有用です。デスクトップクローラーは1376px幅、DPR 1x、モバイルクローラーは360px幅、DPR 3xでした。</aside>

### レイアウト幅

まず次の質問から始めましょう：ウェブの画像はページに描画されるとどれくらいの幅になるのでしょうか？

{{ figure_markup(
  image="distribution-of-img-layout-widths.png",
  caption="`<img>`レイアウト幅の分布。",
  description="デスクトップとモバイルの両方での画像要素レイアウト幅の分布を示す棒グラフ。一般的に、デスクトップの幅はより大きく、25パーセンタイルではモバイルと同等です。10パーセンタイルでは、デスクトップのレイアウト幅は31 CSSピクセルで、モバイルは21 CSSピクセルです。25パーセンタイルでは、モバイルとデスクトップの両方とも81 CSSピクセルで同等です。50パーセンタイルでは、デスクトップは216 CSSピクセル、モバイルは158 CSSピクセルです。75パーセンタイルでは、デスクトップは345、モバイルは300です。そして最後に90パーセンタイルでは、デスクトップは600 CSSピクセル、モバイルは340 CSSピクセルです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=991739101&format=interactive",
  sheets_gid="1727223276",
  sql_file="image_layout_widths.sql"
)
}}

ウェブ上のほとんどの画像はレイアウト内ではかなり小さくなっています。興味深いことに、[モバイルのレイアウトサイズの大部分は2022年からほとんど変わっていませんが、デスクトップのレイアウトサイズの上位半分はすべて約8%増加しています](../2022/media#sizes)。

しかし、レイアウトサイズの大多数が小さい一方で、ほとんどのページには少なくとも1つのかなり大きな`<img>`があります。

{{ figure_markup(
  image="widest-img-per-page-layout-width.png",
  caption="ページあたりの最も幅広い`<img>`（レイアウト幅別）。",
  description="デスクトップとモバイルの両方で、ページごとの最も幅広い画像レイアウト幅の分布を示す棒グラフ。10パーセンタイルでは、デスクトップクローラーは149 CSSピクセル、モバイルクローラーは101ピクセルを観測しました。25パーセンタイルの幅はデスクトップで330ピクセル、モバイルで280ピクセルでした。50パーセンタイルの数値は680ピクセルと330ピクセル、75パーセンタイルでは1,350ピクセルと360ピクセル、そして90パーセンタイルではデスクトップで1,905ピクセル、モバイルで392ピクセルという高い数値を示しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=764338367&format=interactive",
  sheets_gid="1022961650",
  sql_file="largest_image_per_page_layout.sql"
)
}}

すべてのモバイルページの半分には、ビューポートのほぼ全体を占める画像が少なくとも1つあります。上位の方では、モバイルレイアウトは画像がそれ以上のスペースを占めないようにうまく抑制しています。分布がモバイルクローラーのビューポート幅（360px）にすぐに近づき、それをわずかに超えるだけであることがわかります。

これに対してデスクトップのレイアウト幅は、まったく頭打ちになっていません。それらは拡大し続け、75パーセンタイルでフルビューポート幅（1360px）に達し、90パーセンタイルではそれを大きく超えています。同様に興味深いのは、デスクトップでの25、50、75パーセンタイルのレイアウトサイズが[2年前よりも大きくなっている](../2022/media#fig-30)一方で、分布の端はほとんど変わっていないことです。大きなヒーロー画像はさらに大きくなっています。

### 内在的 vs 外在的サイジング

ウェブの画像はどのようにしてこれらのレイアウトサイズになるのでしょうか？CSSで画像をスケーリングする方法はたくさんありますが、実際にCSSでスケーリングされている画像はどれくらいあるのでしょうか？

画像は、すべての["置換要素"](https://developer.mozilla.org/docs/Web/CSS/Replaced_element)と同様に、[内在的サイズ](https://developer.mozilla.org/docs/Glossary/Intrinsic_Size)を持っています。デフォルトでは—密度を制御する`srcset`やレイアウト幅を制御するCSSルールがない場合—ウェブ上の画像は1xの密度で表示されます。640×480の画像を`<img src>`に配置すると、デフォルトではその`<img>`は幅640 CSSピクセルでレイアウトされます。

作者は画像の高さ、幅、またはその両方に外在的サイジングを適用することができます。画像が一方の次元で外在的にサイズ設定されている場合（例えば、`width: 100%;`ルールによる）、しかしもう一方の次元では内在的サイズのままである場合（`height: auto;`または何もルールがない）、内在的なアスペクト比を使用して比例的にスケーリングされます。

さらに複雑なことに、いくつかのCSSルールは、内在的な次元が何らかの制約に違反しない限り、`<img>`要素を内在的な次元に基づいてサイズ設定します。例えば、`max-width: 100%;`ルールを持つ`<img>`要素は、内在的サイズが`<img>`要素のコンテナのサイズよりも大きい場合を除いて、内在的にサイズ設定されます。その場合は、外在的に縮小されて適合します。

これらの説明を踏まえて、ウェブの`<img>`要素がレイアウトのためにどのようにサイズ設定されているかを見てみましょう：

{{ figure_markup(
  image="intrinsic-and-extrinsic-image-sizing-mobile.png",
  caption="内在的および外在的な画像サイジング（モバイル）。",
  description="幅と高さが内在的サイジングと外在的サイジングのどちらに基づいて決定されるかを示す積み上げ棒グラフ。（今のところ）謎の第三のカテゴリーもあります：両方。高さと幅の間の内在的、外在的、および両方の分布はかなり異なります。高さについては、画像の55%が内在的にサイズ設定され、36%が外在的、残りの9%が両方に該当します。幅については、わずか7%の画像が内在的にサイズ設定され、70%が外在的です。残りの22%は両方です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=771165914&format=interactive",
  sheets_gid="224799521",
  sql_file="image_sizing_extrinsic_intrinsic.sql"
)
}}

大多数の画像は外在的な幅と内在的な高さを持っています。幅の「両方」カテゴリ—`max-width`または`min-width`のサイジング制約を持つ画像を表す—もかなり人気があります。画像を内在的な幅のままにしておくことははるかに人気が低く、[2022年](../2022/media#fig-31)よりもわずかに人気が低くなっています。

### `height`, `width`属性と累積レイアウトシフト

内在的な寸法に依存するレイアウトサイズを持つ`<img>`は、[累積レイアウトシフト（CLS）](https://web.dev/articles/cls)を引き起こすリスクがあります。本質的に、そのような画像はレイアウトが2回行われるリスクがあります—1回目はページのDOMとCSSが処理された時点で、そして2回目は最終的に読み込みが完了し、内在的な寸法が判明した時点です。

先ほど見たように、特定の幅に合わせて画像を外在的にスケーリングしながら、高さ（およびアスペクト比）を内在的なままにしておくことは非常に一般的です。このようなレイアウトシフトの蔓延を防ぐために、[作者は`<img>`要素に`width`と`height`属性を設定すべきです](https://developer.mozilla.org/docs/Learn/Performance/Multimedia#rendering_strategy_preventing_jank_when_loading_images)。これによりブラウザは埋め込みリソースが読み込まれる前にレイアウトスペースを確保できます。

{{ figure_markup(
  content="32%",
  caption="モバイルで`height`と`width`属性の両方が設定されている`<img>`要素の割合。",
  classes="big-number",
  sheets_gid="36830123",
  sql_file="img_with_dimensions.sql"
)
}}

`height`と`width`の使用は[2022年から4パーセントポイント増加しており](../2022/media#fig-32)、これは良いことです。しかし、これらの属性はまだ画像の3分の1にしか使用されておらず、まだ長い道のりがあることを意味しています。

## 配信

最後に、画像がネットワーク上でどのように配信されているかを見てみましょう。

### クロスドメイン画像ホスト

埋め込まれた文書とは異なるドメインから配信されている画像はどれくらいあるのでしょうか？増加する多数派です：

{{ figure_markup(
  image="image-hosts-same-vs-cross-domain.png",
  caption="画像ホスト：同一ドメイン vs クロスドメイン。",
  description="ルートHTMLページと同じドメインから配信された画像と、異なる（クロス）ドメインから配信された画像の数を示す棒グラフで、2022年と2024年の両方のデスクトップとモバイルの内訳を比較しています。モバイルでは、クロスドメイン/同一ドメインの割合は2022年の55%/45%から、2024年には62%/38%になりました—つまり、クロスドメイン画像のシェアは約7パーセントポイント増加しました。デスクトップでは、2022年の53%/47%から2024年には62%/38%になり、クロスドメイン画像ホスティングが9パーセントポイント増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=595767399&format=interactive",
  sheets_gid="817041542",
  sql_file="img_xdomain.sql"
)
}}

ここでのさまざまな潜在的な原因を解きほぐすのは難しいですが、私たちは画像を正しく扱うことがいかに難しいかが一つの要因であるという仮説を立てています。これによりチームは[画像CDN](https://web.dev/image-cdns/)を採用するようになり、画像の最適化と配信をサービスとして提供しています。

これで、ウェブ上の画像の現状についての全体像が得られました。次に、2024年のウェブ上の動画について見ていきましょう。

## 動画

`<video>`要素は2010年に登場し、それ以来、FlashやSilverlightなどのプラグインが廃止されて以来、ウェブサイトに動画コンテンツを埋め込むための最良かつ唯一の方法となっています。私たちはそれをどのように使用しているでしょうか？

### `<video>`要素の採用

まず最初に、最も基本的な質問に答えましょう：どれくらいのページが`<video>`要素を含んでいるのでしょうか？

{{ figure_markup(
  content="6.7%",
  caption="少なくとも1つの`<video>`要素を含むモバイルページの割合。デスクトップでは7.7%です。",
  classes="big-number",
  sheets_gid="1452717500",
  sql_file="video_adoption.sql"
)
}}

これは`<img>`を含むページの数に比べると小さな割合です。しかし、`<video>`が14年前に導入されたにもかかわらず、現在採用は急速に増加しています。モバイルの数字は[2022年から（相対的に）32%増加しています](../2022/media#fig-34)。

### 動画の長さ

これらの動画はどれくらいの長さなのでしょうか？そんなに長くありません！

{{ figure_markup(
  image="video-durations.png",
  caption="動画の長さ。",
  description="デスクトップとモバイルでの動画の長さを示す棒グラフ。モバイルの棒グラフだけにラベルが付いていますが、デスクトップの棒グラフもそれほど変わりません。モバイルでは、動画の21%が0〜10秒、37%が10〜30秒、21%が30〜60秒、12%が60〜120秒、9%が120秒以上です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=743719097&format=interactive",
  sheets_gid="703705018",
  sql_file="video_durations.sql"
)
}}

10本中9本の動画は2分未満です。半分以上が30秒未満です。そして、動画のほぼ4分の1が10秒未満です。

### フォーマットの採用

2024年にサイトはどのようなフォーマットを配信しているでしょうか？<a hreflang="en" href="https://caniuse.com/mpeg4">普遍的なサポート</a>を享受しているMP4が王様です：

{{ figure_markup(
  image="top-extensions-of-files-with-a-video-mime-type.png",
  caption="動画MIMEタイプを持つファイルの主要な拡張子。",
  description="デスクトップとモバイルで配信される動画ファイルの拡張子を示す棒グラフ。モバイルの棒グラフだけにラベルが付いていますが、1つの例外を除いて、デスクトップの棒グラフもかなり似ています。MP4拡張子は動画ファイルの68%を占め、拡張子なしが14%（デスクトップでは特に少ない）、TS拡張子が9%、M4Sが4%、MOVが1%、最後にWebMが1%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=892598197&format=interactive",
  sheets_gid="1427621996",
  sql_file="video_ext.sql"
)
}}

`.mp4`の次に最も一般的な拡張子は、拡張子なし、`.ts`、`.m4s`の3つです。このトリオは、`<video>`要素がHLSまたはMPEG-DASHを使用した適応ビットレートストリーミングを採用している場合に配信されます。`.mp4`または適応ビットレートストリーミング以外のものを配信する動画要素はまれで、見つかった拡張子のわずか4%しかありません。

### 埋め込み

`<video>`要素は、作者が動画がどのように読み込まれ、ページ上で表示されるかを制御できるようにするいくつかの属性を提供しています。以下は、使用頻度順に並べたものです：

{{ figure_markup(
  image="video-attribute-usage.png",
  caption="動画属性の使用状況。",
  description="デスクトップとモバイルの両方でHTML動画要素のさまざまな属性が見つかった回数を示す棒グラフ。一般的に、モバイルとデスクトップの棒グラフは似ていますが、モバイルの棒グラフにのみラベルが付いています。autoplayは動画要素の23%に存在し、playsinlineは14%、preloadは16%、srcは9%、controlsは9%、widthは10%、loopは7%、crossoriginは5%、mutedは8%、そして最後にposterは3%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1127314078&format=interactive",
  sheets_gid="118006887",
  sql_file="video_attribute_names.sql",
  width="600",
  height="522",
)
}}

`playsinline`と`autoplay`の両方が2022年から3パーセントポイント増加していますが—これはおそらくGIFと同じ役割を果たす短いインライン動画の採用増加を表していますが—過去数年間で最も大きく変動したのは`preload`で、その使用率は6パーセントポイント減少しています。

これは2020年代を通じて見てきたトレンドの継続であり、その理由についての私たちの仮説は[2022年と同じままです](../2022/media#preload)。ブラウザは作者よりもエンドユーザーのコンテキストについてより多くを知っています。`preload`属性を含めないことで、作者はますますブラウザの邪魔をしなくなっています。

### `src`と`source`

`src`属性は`<video>`要素のわずか9%にしか存在しません。ウェブ上の残りの多くの`<video>`要素は`<source>`子要素を使用しており、これにより作者は—理論的には—異なるコンテキストで使用するための複数の代替動画リソースを提供できます。

{{ figure_markup(
  image="number-of-sources-per-video.png",
  caption="`<video>`あたりの`<source>`の数。",
  description="デスクトップとモバイルの両方で、動画要素あたりのさまざまな数のソース要素の頻度を示す棒グラフ。デスクトップとモバイルの数値はかなり似ており、モバイルの数値にのみラベルが付いています。動画あたりのソース要素の最も一般的な数は1つで、モバイルの動画要素の48.9%がこの数のソースを含んでいます。2番目に一般的なソース子要素の数は0で、モバイル動画の42.5%にはソース子要素がありません。6.8%が2つ、1.6%が3つ、モバイルでは0.2%の動画要素が4つの要素を含んでいます。5つの子要素を含むものの数は0.0%に切り下げられます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1457938371&format=interactive",
  sheets_gid="1562419289",
  sql_file="video_number_of_sources.sql"
)
}}

しかし、`<source>`子要素を持つ`<video>`要素のほとんどは1つしか持っていません—複数の`<source>`を持つ`<video>`要素は10個に1個だけです。

## 結論

以上が2024年のウェブ上のメディアの現状のスナップショットであり、過去数年間でどのように変化したかの概観です。メディアがウェブのユーザー体験にいかに普遍的で重要であるかを見てきました。また、サイトがメディアを効果的に配信している方法と、そうでない方法についても検討しました。

おそらく驚くことではありませんが、ウェブ上の画像はより大きくなっていることがわかりました。画像のピクセル数やレイアウトの寸法のどちらを数えても、数値は上昇しています。そのため、圧縮率の向上（一部は最新の画像フォーマットの採用増加による）にもかかわらず、画像の合計バイトサイズも増加しています。

同様に、動画側で見られた最も顕著な変化は、単に2年前よりもはるかに多くの動画が使用されているということでした。ウェブはますます視覚的になり続けています。

これらの主要な発見の他に、今年の分析で見つかった注目すべき励みになる点としては、広色域カラースペースの採用の最初の兆し、遅延読み込みの継続的な急速な採用、そしてレスポンシブ画像マークアップの着実な増加が含まれます。

一方、落胆させられる点としては、`alt`テキストがないか無意味な`<img>`要素の膨大な数、不必要に遅いLCP時間につながる遅延読み込みの過剰使用、GIF使用の謎めいた（小さいながらも）増加、そして`sizes`の精度がさらに悪化したことが見られました。

2025年のウェブでより効果的な視覚的コミュニケーションが実現することを願っています！
