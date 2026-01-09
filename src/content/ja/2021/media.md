---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: メディア
description: 2021年版Web Almanacのメディアの章では、現在Web上で画像や動画がどのようにエンコード、埋め込み、スタイリング、配信されているかを解説しています。
hero_alt: Hero image of Web Almanac characters projecting an image onto a screen while other Web Almanac characters walk to cinema seats with popcorn to watch the projection.
authors: [eeeps, dougsillars]
reviewers: [Navaneeth-akam, tpiros, akshay-ranganath, addyosmani]
analysts: [eeeps, dougsillars, akshay-ranganath]
editors: [tunetheweb]
translators: [ksakae1216]
eeeps_bio: Eric Portisは<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のWebプラットフォーム提唱者です。
dougsillars_bio: Doug Sillarsは、開発者関係のリーダーであり、パフォーマンスとメディアの交差点で活動するデジタルノマドでもあります。彼のツイッターは [@dougsillars](https://x.com/dougsillars) で、ブログは <a hreflang="en" href="https://dougsillars.com">dougsillars.com</a> で定期的に更新しています。
results: https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/
featured_quote: 今年は、ネイティブ遅延読み込みにより、画像転送サイズの増大という潮流を食い止めることができました。
featured_stat_1: 99.93%
featured_stat_label_1: 何らかの画像リソースを読み込むページ。
featured_stat_2: 87.1%
featured_stat_label_2: ウェブ上の画像は、次世代フォーマットであるJPEG、PNG、GIFのいずれかで配信されます。
featured_stat_3: 5.6%
featured_stat_label_3: 動画要素を含むデスクトップページのシェア。昨年から3倍に増加。
---

## 序章

ほぼ30年前 <a hreflang="en" href="https://thehistoryoftheweb.com/the-origin-of-the-img-tag/">`<img>` タグが生まれました</a>、そしてハイパー<em>テキスト</em>は、ハイパー<em>メディア</em>になりました。それ以来、ウェブはますますビジュアル化されています。2021年、Web上のメディアはどうなっているのか？画像と動画を、順番に見ていきましょう。

## 画像

ウェブ上では、画像はどこにでもあるものです。ほとんどすべてのページが画像コンテンツを含んでいます。

{{ figure_markup(
  content="95.9%",
  caption="少なくとも1つのコンテンツ付き `<img>` が含まれるページの割合",
  classes="big-number",
  sheets_gid="1756671383",
  sql_file="at_least_one_img.sql"
)
}}

そして、事実上すべてのページが何らかの画像を提供しています（それが単なる背景やファビコンであっても）。

{{ figure_markup(
  content="99.9%",
  caption="画像リソースへのリクエストが1件以上発生したページの割合",
  classes="big-number",
  sheets_gid="1062090109",
  sql_file="at_least_one_image_request.sql"
)
}}

これらの映像が持つインパクトは計り知れないものがあります。[ページの重さ](./page-weight)の章で強調しているように、画像は依然として他のどのリソースタイプよりもページあたり多くのバイトを担当しています。しかし、前年比では、1ページあたりの画像転送サイズは減少しています。

{{ figure_markup(
  image="mobile-image-transfer-size-by-year.png",
  caption="携帯電話の画像転送サイズの年別推移。",
  description="画像転送サイズの合計、1ページあたりの分布と、2020年と2021年の間でどのように変化したかを示す棒グラフ。25パーセンタイルでは、転送サイズは277kBから257kBに減少しています。50パーセンタイルでは、916kBから877kBに縮小しています。そして75パーセンタイルでは、2,352kBから2,324kBに減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=478222195&format=interactive",
  sheets_gid="381418851",
  sql_file="../page-weight/bytes_per_type_2021.sql"
)
}}

これは驚きです。過去10年間、HTTP Archiveの毎月の<a hreflang="en" href="https://httparchive.org/reports/state-of-images">画像状態レポート</a>に掲載されてる<a hreflang="en" href="https://httparchive.org/reports/state-of-images#bytesImg">Image Bytes</a> チャートは、一見すると上昇する一方です。2021年、この流れを逆転させたのは何だったのか。後ほど詳しく説明する、ネイティブの遅延読み込みの急速な普及と関係があるのではないかと思います。

いずれにせよ、量的に見れば、画像はウェブの中で非常に多くのものを占め続けているのです。しかし、要素数、リクエスト数、バイト数だけでは、画像がユーザーの体験にどれだけ重要であるかはわかりません。それを知るために、<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">Largest Contentful Paint</a> という指標を見てみましょう。これは、任意のページにおけるabove-the-foldコンテンツのもっとも重要な部分を識別しようとするものです。[パフォーマンス](./performance#fig-19)の章にあるように、LCP要素は約4分の3のページで画像が表示されます。

{{ figure_markup(
  content="70.6%",
  caption="LCP要素に画像があるモバイルページ。デスクトップでは79.4%です！",
  classes="big-number",
  sheets_gid="https://docs.google.com/spreadsheets/d/13xhPx6o2Nowz_3b3_5ojiF_mY3Lhs25auBKM6eqGZmo/#gid=1423728540",
  sql_file="../performance/lcp_element_data.sql"
)
}}

画像は、ユーザーのウェブ体験に欠かせないものです。ここでは画像がどのようにエンコードされ、埋め込まれ、レイアウトされ、配信されるのかを詳しく見ていきましょう。

### エンコーディング

ウェブ上の画像データは、ファイルにエンコードされています。このファイルや画像データについて、私たちはどのようなことが言えるのでしょうか。

まず、画素の大きさから見てみましょう。まずは小さいサイズから。

#### 1画素の画像

多くの `<img>` 要素は実際にはコンテンツの多い<a hreflang="en" href="https://www.merriam-webster.com/dictionary/image">画像</a> を表さず、その代わりに1画素しか含まないのです。

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>1x1の画像</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>モバイル</td>
        <td class="numeric">7.5%</td>
      </tr>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">7.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="1画素の画像使用。", sheets_gid="1851007461", sql_file="image_1x1.sql") }}</figcaption>
</figure>

これらの1画素 `<img>` 要素は、はっきり言ってハッキングです。[レイアウトのため](https://en.wikipedia.org/wiki/Spacer_GIF)（これはCSSでやったほうがいい）か [ユーザーの追跡](https://ja.wikipedia.org/wiki/%E3%82%A6%E3%82%A7%E3%83%96%E3%83%93%E3%83%BC%E3%82%B3%E3%83%B3)（これは [Beacon API](https://developer.mozilla.org/docs/Web/API/Beacon_API) でやったほうがいい）かのいずれかで乱用されているのです。

これらの1画素の画像 `<img>` がどのような仕事をしているかは、[データ URI](https://developer.mozilla.org/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) を使っているものがどれだけあるかを見ることで、基本的な内訳を知ることができます。

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>データURI 1画素 `<img>`</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>モバイル</td>
        <td class="numeric">44.7%</td>
      </tr>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">47.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="データ URI 1画素の画像。", sheets_gid="1851007461", sql_file="image_1x1.sql") }}</figcaption>
</figure>

データURIを含む1画素 `<img>` は、ほぼ間違いなくレイアウトに使用されています。リクエストを発生させる残りの約54%は、レイアウトのためかもしれませんし、トラッキングピクセルかもしれませんが、私たちにはわかりません。

なお、この後の解析では、1画素 `<img>` は解析結果から除外しています。このメディアの章では、トラッキングピクセルやレイアウトハックではなく、ユーザーに視覚情報を提供する `<img>` 要素に関心をもっています。

#### 多画素の画像

`<img>` に複数のピクセルが含まれる場合、そのピクセルは何ピクセルになりますか？

{{ figure_markup(
  image="image-pixel-counts.png",
  caption="画像の画素数の分布。",
  description="デスクトップとモバイルの1画像あたりのピクセル数分布を示す棒グラフですが、両者にほとんど差はありません。10パーセンタイルでは、デスクトップ画像は676ピクセル、モバイルは999ピクセル、25パーセンタイルではそれぞれ7,260と9,216、50パーセンタイルでは4万と4万3200、75パーセンタイルでは16万と17万496、90パーセンタイルでは516,242と514,000になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=493015352&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

中央の`<img>`は、モバイルでは40,000ピクセル強を読み込みます。この数字は意外と小さいと感じました。クロールされた `<img>` の半数弱（1ピクセルの画像や何も読み込まないものを除く）は、200x200の画像とほぼ同じ数のピクセルが含まれています。

しかし、1ページあたりの`<img>`要素の数を考えると、この統計はそれほど驚くことでありません。ほとんどのページが15枚以上の画像を含んでいるため、多くの小さな画像やアイコンで構成されていることが多いのです。このように、ハーフメガピクセル以上の画像は、`<img>`要素の10個に1個しかないとはいえ、ページ間を移動する際には決して珍しいことではありません。多くのページには、少なくとも1枚の大きな画像が含まれます。

{{ figure_markup(
  image="number-of-imgs-per-page.png",
  caption="1ページに表示される`<img>`の数。",
  description="ページごとのimg要素の分布を示す棒グラフ。デスクトップとモバイルの両方の棒グラフが表示されています。50パーセンタイルからは、デスクトップのバーが一貫して10〜20％大きくなっています。10パータイルでは、デスクトップで2、モバイルで2です。25パーセンタイルでは、それぞれ6と6です。50パーセンタイルでは、17と15です。75パーセンタイルでは、36と32です。で、最後に90パーセンタイルでは70と61です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1641393356&format=interactive",
  sheets_gid="1553608446",
  sql_file="imgs_per_page.sql"
  )
}}

また、画素数分布の上端では、デスクトップとモバイルの差がほとんどないことにも驚きました。当初、これはレスポンシブ画像機能が効果的に採用されていないことを示しているように思われましたが、モバイルクローラーのビューポートが360×512px @3x（つまり1,080×1,536物理ピクセル）であるのに対し、デスクトップのビューポートは1,376×768px @1xということを考えると、実は驚くべきことではありません。クローラーのビューポートが物理ピクセルで同幅である（1,080 vs 1,376）のです。クローラー間の物理的なピクセル解像度の差が大きければ、もっと明らかになるはずです。

#### アスペクト比

Web上の画像は横向きのものが多く、縦向きのものは比較的少ないです。

{{ figure_markup(
  image="image-orientations.png",
  caption="画像の向き",
  description="デスクトップとモバイルの両方で、画像の縦長、横長、正方形の割合を示す一対の積み上げ棒グラフです。デスクトップの内訳は、縦型12.7%、正方形32.9%、横型54.4%となっています。モバイルの内訳は、縦型12.6％、横型32.7％、横型54.5％と非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1361616235&format=interactive",
  sheets_gid="478089289",
  sql_file="portrait_landscape_square.sql"
  )
}}

これは、モバイルでの機会を逸した感があります。<a hreflang="en" href="https://uxdesign.cc/the-powerful-interaction-design-of-instagram-stories-47cdeb30e5b6">「ストーリー」UIパターン</a>の成功は、縦長のモバイル画面を埋めるため調整された画像に価値があることを示しています。

画像のアスペクト比は、4：3、16：9、とくに1：1（正方形）など、「標準的」な値に集中していました。アスペクト比のトップ10は、全`<img>`の約半分を占めています。

<figure>
  <table>
    <thead>
      <tr>
        <th>アスペクト比</th>
        <th>デスクトップ画像</th>
        <th>モバイル画像</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1:1</td>
        <td class="numeric">32.9%</td>
        <td class="numeric">32.7%</td>
      </tr>
      <tr>
        <td>4:3</td>
        <td class="numeric">3.7%</td>
        <td class="numeric">4.1%</td>
      </tr>
      <tr>
        <td>3:2</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>2:1</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>16:9</td>
        <td class="numeric">1.5%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>3:4</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>2:3</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>5:3</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>6:5</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>8:5</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="画像のアスペクト比のトップ10をランキング形式でご紹介します。", sheets_gid="914161583", sql_file="top_aspect_ratios.sql") }}</figcaption>
</figure>

#### バイト数

ここで、ファイルサイズに目を向けてみましょう。

{{ figure_markup(
  image="distribution-of-image-byte-sizes.png",
  caption="画像のバイトサイズの分布。",
  description="デスクトップとモバイルの両方で画像のバイトサイズ（キロバイト）の分布を示した棒グラフです。10パーセンタイルではデスクトップとモバイルで0.3、25パーセンタイルではそれぞれ1.8と1.9、50パーセンタイルでは9.7と10.3、75パーセンタイルでは39.2と41.6、最後に90パーセンタイルでは132.8、130.7となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=717078449&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

コンテンツが多い`<img>`の中央値は、10kB強です。しかし、中央のページには15個以上の `<img>` が含まれているため、ページ全体の全画像の90パーセンタイルを見ると、100kBを超える画像はまったく珍しくありません。

#### 画素あたりのビット数

バイトと寸法はそれ自体で興味深いものですが、ウェブの画像データがどの程度圧縮されているかを知るには、バイトとピクセルを組み合わせて、_1ピクセルあたりのビット数_を計算する必要があります。これにより、解像度が異なる画像でも、その情報量を比較することができるようになりました。

一般にWeb上のビットマップは、1チャンネル、1ピクセルあたり8ビットの情報にデコードされます。つまり、透明度のないRGB画像であれば、デコードされた非圧縮画像は[24ビット/ピクセル](https://ja.wikipedia.org/wiki/%E8%89%B2%E6%B7%B1%E5%BA%A6#%E3%83%88%E3%82%A5%E3%83%AB%E3%83%BC%E3%82%AB%E3%83%A9%E3%83%BC%EF%BC%8824/32%E3%83%93%E3%83%83%E3%83%88))になると予想されるのです。可逆圧縮の目安は、ファイルサイズを2：1の割合で小さくすることです（8ビットRGB画像では1ピクセルあたり12ビットに相当）。1990年代の非可逆圧縮方式（JPEGやMP3）は、10：1（2.4ビット/ピクセル）が目安でした。画像のコンテンツやエンコーディングの設定によって、これらの比率は *広く* 変化し、<a hreflang="en" href="https://github.com/mozilla/mozjpeg">MozJPEG</a> のような最新のJPEGエンコーダーは、デフォルト設定でこの10:1目標を上回ることが多いことに留意する必要があります。

このような背景のもと、Web上の画像はどのような位置づけにあるのか、ご紹介します。

{{ figure_markup(
  image="distribution-of-image-bits-per-pixel.png",
  caption="1画素あたりの画像ビット数の分布。",
  description="デスクトップとモバイルの両方で、1ピクセルあたりの画像ビット数の分布を示す棒グラフです。デスクトップのバーは、モバイルのものよりも常に5～10％高い。10パーセンタイルでは、ウェブの画像は1ピクセルあたりモバイルが0.2ビット、デスクトップが0.3ビットです。25パーセンタイルでは両者とも1.1、50パーセンタイルではモバイルが2.4、デスクトップが2.5、75パーセンタイルではモバイルが6.0、デスクトップが6.3、そして最後に90パーセンタイルではモバイル画像がなんと1ピクセルあたり13.5ビット、デスクトップはさらに多い14.3ビットとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=839945889&format=interactive",
  sheets_gid="1999710461",
  sql_file="bytes_and_dimensions.sql"
  )
}}

モバイルの中央の`<img>`は、10:1の圧縮率の目標にぴったりで、2.4ビット/画素です。しかし、その中央値付近では、とてつもなく大きな開きがあるのです。もう少し詳しく知るために、フォーマット別に分けて考えてみましょう。

#### フォーマット別、画素あたりのビット数

{{ figure_markup(
  image="median-bits-per-pixel-by-format.png",
  caption="フォーマット別の1画素あたりのビット数の中央値。",
  description="一般的な画像フォーマットにおける、1ピクセルあたりのビット数の中央値をフォーマット別に示した棒グラフです。`gif`はデスクトップ用7.2、モバイル用7.4、`png`はそれぞれ4.8、4.6、`jpg`は2.1、1.5、`avif`は1.3、1.4、`webp`は1.3と1.4です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1390065360&format=interactive",
  sheets_gid="30152726",
  sql_file="bytes_and_dimensions_by_format.sql"
  )
}}

JPEGの中央値は、1ピクセルあたり2.1ビットです。このフォーマットはどこにでもあるため、他のフォーマットを測定するための最適な基準値となります。

PNGの中央値は、その2倍以上です。PNGはロスレスフォーマットと呼ばれることがありますが、1ピクセルあたり4.6ビットの中央値は、これがいかに誤ったものであるかを示しています。真のロスレス圧縮は、通常、1ピクセルあたり約12〜16ビット（アルファチャンネルを扱うかどうかによって異なる）に収まるはずです。PNGがこれほどまでに低いのは、一般的なPNGツールは通常、_非可逆圧縮_だからです。圧縮率を高めるために、ピクセルをエンコードする前にカラーパレットを減らしたり、ディザリングパターンを導入したりと、ピクセルに手を加えてしまうのです。

1ピクセルあたり7.4ビットのGIFは、ここではひどく見劣りします。<a hreflang="en" href="https://web.dev/efficient-animated-content/">これら</a> <a hreflang="en" href="https://bitsofco.de/optimising-gifs/">は</a> <a hreflang="en" href="https://dougsillars.com/2019/01/15/state-of-the-web-animated-gifs/">大変</a>！しかし、ウェブ上の多くのGIFはアニメーションであるため、ここでも少し不利な立場に立たされています。WebプラットフォームのAPIは、アニメーション画像のフレーム数を公開しないため、フレーム数を考慮していない。たとえば、1ピクセルあたり20ビットで計測されるGIFは、10フレームを含む場合、1ピクセルあたり2ビットと計算するのが妥当でしょう。

次世代フォーマットである2つのフォーマットについて見てみると、実に興味深いことがわかります。WebPとAVIFです。どちらも1ピクセルあたり1.3〜1.5ビットで、JPEGより40％近く軽くなっています。<a hreflang="en" href="https://kornel.ski/en/faircomparison">matched qualities</a> を使用した正式な研究では、WebPはJPEGよりも <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">25 ～ 34%</a> 高性能であり、実際のパフォーマンスは驚くほど *良い* と思われます。一方、AVIFの作成者は、<a hreflang="en" href="https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4">実験室で、最新のJPEGエンコーダーJPEGを50% 以上上回ることができる</a>というデータを発表しています。ですから、ここでのAVIFの性能は良いのですが、私はもっと良い結果を期待していました。実験室のデータと実際の性能の間にあるこのような不一致について、私はいくつかの可能性を考えることができます。

第一に、ツールです。JPEGエンコーダーは、画像をうまく圧縮するのにあまり労力をかけないカメラに搭載されているハードウェアエンコーダーから、何十年も前にインストールされた <a hreflang="en" href="https://ja.wikipedia.org/wiki/Libjpeg">`libjpeg`</a> の古いコピー、MozJPEGのような最先端の、デフォルトで最高の機能を持つエンコーダーまで非常に幅広く存在しているのです。要するに、古くてひどく圧縮されたJPEGはたくさんありますが、すべてのWebPとAVIFは最新のツールで圧縮されているのです。

また、参考となるWebPエンコーダー (<a hreflang="en" href="https://developers.google.com/speed/webp/download">`cwebp`</a>) は、品質と圧縮について比較的積極的で、ほとんどの一般的なJPEGツールよりも低品質でより圧縮された結果をデフォルトで返すという逸話があります。

AVIFに関して言えば、<a hreflang="ja" href="https://github.com/AOMediaCodec/libavif">`libavif`</a> は、どの「速度」設定を選ぶかによって、さまざまな圧縮率を実現することが可能です。もっとも遅い速度（もっとも効率の良いファイルを生成）では、`libavif`は1つの画像をエンコードするのに数分かかることもあります。画像レンダリングパイプラインが異なれば、その制約によって速度設定のトレードオフも異なると考えるのが妥当でしょう。その結果、圧縮性能に大きなばらつきが生じます。

もうひとつ、AVIFの実力を評価する際に気をつけたいのは、まだウェブ上にそれほど多くのAVIFが存在しないということです。このフォーマットは現在、比較的少数のサイト、限られたコンテンツで使用されているため、最終的に「どのよう」に機能するかについては、まだ完全には把握できていません。今後数年間、採用が進む（そしてツールも改善される）につれ、この点を追跡するのは興味深いことです。

絶対に明らかなのは、WebPとAVIFの両方を使用すれば、Webのレガシー形式よりも効率的にさまざまなコンテンツ（写真、<a hreflang="en" href="https://jakearchibald.com/2020/avif-has-landed/#flat-illustration"> イラスト</a>、透明度の高い画像など）を配信できることです。しかし、次節で紹介するように、それほど多くのサイトが採用しているわけではありません。

#### フォーマットの採用

{{ figure_markup(
  image="image-format-adoption-mobile.png",
  caption="画像フォーマットの採用（モバイル）。",
  description="ウェブ上の画像に占める各フォーマットの割合を円グラフで表したものです。1位はJPEGで41.8％。次いでPNGが28.8％、GIFが16.5％、WebPが6.9％、SVGが4.0％となっています。このうち、いくつかのパイは、ラベルが貼られていない状態です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=832165430&format=interactive",
  sheets_gid="1886692503",
  sql_file="media_formats.sql"
  )
}}

古いフォーマットが依然として君臨している。JPEGが優勢で、PNGとGIFが表彰台を独占しています。これらを合わせると、ウェブ上の画像のほぼ90%を占めることになります。WebPはもう10年以上前のものですが、<a hreflang="en" href="https://www.macrumors.com/2020/06/22/webp-safari-14/">昨年ユニバーサル ブラウザ サポートを実現したばかり</a>で、まだ1桁の数字にとどまっています。そして、事実上誰もAVIFを使っておらず、クロールされたリソースのわずか0.04％を占めただけでした。AVIF1枚につき、JPEG1,000枚を発見しました。

WebPとAVIFの採用が時間とともにどのように変化したか（およびその理由の推測）についての詳細な分析については、ImageReadyにおける [Paul Calvano](https://x.com/paulcalvano) の最近の素晴らしい講演（<a hreflang="en" href="https://www.youtube.com/watch?v=tz5bpAQY43k">フル動画</a> および <a hreflang="en" href="https://docs.google.com/presentation/d/1VS5QjNR6lh2y9jL5xaeainQ2cTAWyy7QiEjDMh4hNQA/edit#slide=id.gefc0d6ffce_0_0">スライド13〜15</a>）が最高のリソースとなるでしょう。その中で、Safariがサポートを追加した2020年7月から2021年7月にかけて、WebPの採用率が〜34％増加したことを紹介しています。AVIFはまだ新しいフォーマットであり、比較的少数のサイトが使用していることを考えると、驚くには値しないがパーセンテージで見ると、AVIFの数字はさらに急上昇している。AVIFを採用したのは、数人の[大](https://x.com/chriscoyier/status/1465474900588646408)<a hreflang="en" href="https://medium.com/vimeo-engineering-blog/upgrading-images-on-vimeo-620f79da8605">プレーヤー</a>だけだったのです。

### 埋め込み

ウェブページに画像を表示するには、`<img>`要素を用いて画像を埋め込む必要があります。この由緒ある要素は、過去数年の間にいくつかの新機能を獲得しましたが、それらの機能はどのように実践されているのでしょうか？

#### 遅延読み込み

ウェブ上の画像に関して今年ブレイクアウトした話があるとすれば、<a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">ネイティブ遅延読み込み</a>の採用でしょう。このチャートを見てください。

{{ figure_markup(
  image="adoption-of-native-loading-lazy-on-img.png",
  caption='`<img>` に `loading="lazy"` を採用する。',
  description="ネイティブ遅延読み込みを使用しているページの割合を、時系列で示した折れ線グラフです。2019年1月から2020年5月までは使用率0％です。そこから夏にかけて利用が加速し、8月頃には8%のページが遅延読み込みを利用するようになり、その後1年ほど利用が減速（それでも増え続けている）し、2021年7月には約18%で終息するという素晴らしい2段階の曲線が描かれています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1314627953&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1Mw6TjkIClRtlZPHbij5corOZbaSUp-vgTVq3Ig18IwQ/#gid=157636784",
  sql_file="../resource-hints/imgLazy.sql"
  )
}}

2020年7月、ネイティブ遅延読み込みはわずか1％のページで使用されていました。2021年7月には、その数は18％にまで爆発的に増えています。これは、毎年更新されない膨大な数のページやテンプレートを考えると、信じられないような伸び率です。

個人的には、ネイティブ遅延読み込みの急速な普及は、今年、ページあたりの画像バイトが減少したことを説明する最良の方法だと思います。

何が遅延読み込みの普及を促したのか？使いやすさ、開発者の需要の高まり、そしてWordPress <a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">遅延読み込みをWebの広大な領域に関しデフォルトで有効にする</a>という組み合わせであることは、ある程度コンセンサスになっています。

もしかしたら、ネイティブの遅延読み込みが成功しすぎたのでしょうか？Resource Hintsの章では、[遅延ロードされた画像の大半は初期ビューポートにあった](./resource-hints#fig-16)と記しています（一方、この機能は「below the fold」の画像に使うのが理想的です）。 さらに、パフォーマンスの章では、[Largest Contentful Paint 要素の 9.3% が `loading` 属性を `lazy` に設定している](./performance#fig-20) ことを発見しました。これはページのもっとも重要なコンテンツの読み込みを大幅に遅らせ、ユーザーの体験を損ねることになります。

#### デコード

`<img>` の `decoding` 属性は、ネイティブ遅延読み込みの成功を強調するための有効な対照点として機能します。2018年に<a hreflang="en" href="https://www.chromestatus.com/feature/4897260684967936">はじめてサポートされた</a>ネイティブ遅延読み込みの約1年前`decoding`属性により、開発者は大きな画像デコード操作がメイン スレッドをブロックするのを防止することができるようになりました。すべてのウェブ開発者が必要とし、理解しているわけではない機能を提供し、それが使用データにも表れています。<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1nwkpviC3gNhRb48i8OoIgtJx1ckqRjJGW7uc7Gdi_sI/edit?pli=1#gid=1934121343">`decoding`はページのわずか1%、`<img>`要素</a>のわずか0.3%にしか使われていません。

#### アクセシビリティ

ウェブページにコンテンツのある画像を埋め込む場合、そのコンテンツは視覚的でないユーザーにも可能な限りアクセスできるようにする必要があります。この章では、ウェブ上の画像アクセシビリティを詳細に分析し、前年比でわずかな進歩が見られたものの、大部分は改善の余地があります。

#### レスポンシブ画像

2013年、レスポンシブWebサイトにおける画像のアダプティブ・ローディングを可能にする一連の機能が、あまりに大きな反響を呼んで上陸しました。それから8年、レスポンシブ画像機能はどのように活用されているのでしょうか？

まず、[`srcset` 属性](https://developer.mozilla.org/docs/Web/API/HTMLImageElement/srcset) について考えてみましょう。この属性によって、開発者は同じ `<img>` に対して複数の可能なリソースを提供できます。

##### `x` と `w` の記述子の採用


{{ figure_markup(
  caption="モバイルページで `srcset` を使用している割合。",
  content="30.9%",
  classes="big-number",
  sheets_gid="1594311632",
  sql_file="image_srcset_sizes.sql"
)
}}

クロールされたページのほぼ3分の1が `srcset` を使っている、これはとても良いことだ！

そして[`w` 記述子](https://cloudfour.com/thinks/responsive-images-101-part-4-srcset-width-descriptors/)、これは、ブラウザが [さまざまなレイアウト幅とさまざまな画面密度の両方に基づいて](https://jakearchibald.com/2015/anatomy-of-responsive-images/#varying-size-and-density) リソースを選択することを可能にし、[DPR適応のみを可能にする](https://jakearchibald.com/2015/anatomy-of-responsive-images/#fixed-size-varying-density)[`x` 記述子](https://cloudfour.com/thinks/responsive-images-101-part-3-srcset-display-density/)よりも4倍も人気があります。

{{ figure_markup(
  image="srcset-descriptor-adoption.png",
  caption="`srcset` 記述子の採用。",
  description="モバイルとデスクトップの両方で、`srcset`属性内の`x`記述子と`w`記述子を使用しているページの割合を示す棒グラフです。`x` 記述子はデスクトップで6.1%、モバイルでは6.5%のページで使用されています。`w` 記述子は4倍使われている。デスクトップでは24.4％、モバイルでは24.3％の割合です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=89579817&format=interactive",
  sheets_gid="1030564653",
  sql_file="image_srcset_descriptor.sql"
  )
}}

開発者はどのように `srcset` にリソースを投入しているのですか？

##### `srcset` 候補の数

まず、開発者が入れている候補リソースの数を見てみましょう。

{{ figure_markup(
  image="number-of-srcset-candidates.png",
  caption="srcset候補の数。",
  description="`srcset` 属性のうち、異なる数の候補を含む割合を示す積み上げ棒グラフです。デスクトップとモバイルの両方で、ほぼすべて（80-90％）が1-5個の候補を含んでいるようです。次に、5～10個の候補が含まれるバケットを見ると、95%を超えています。残りの`srcset`のほとんどすべてが10〜15個の候補を持ち、15〜20個を持つものはごくわずかです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1875401927&format=interactive",
  sheets_gid="1586096291",
  sql_file="image_srcset_candidates.sql"
  )
}}

大半の `srcset` は5個かそれ以下のリソースで構成されています。

##### `srcset` の密度の範囲

開発者はブラウザに、彼らの`srcset`の中で、適切な幅広い選択肢を与えていますか？この質問に答えるためには、まず `srcset` と `sizes` の値がブラウザでどのように使用されるかを理解する必要があります。

ブラウザが `srcset` から読み込むリソースを選ぶとき、まず候補となるすべてのリソースに <a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#current-pixel-density">密度</a> を割り当てます。`x` 記述子を使用するリソースの密度を計算するのは簡単です。`2x` の密度記述子を持つリソースは、（待てよ）2xの密度を持つ。

`w` 記述子は物事を複雑にします。`1000w`のリソースの密度は？解決された `sizes` 値に依存します (ビューポートの幅に依存するかもしれません！)。`w` 記述子を使用する場合、各記述子を `sizes` 値で割って、その密度を決定します。たとえば

```html
<img
  srcset="large.jpg 1000w, medium.jpg 750w, small.jpg 500w"
  sizes="100vw"
/>
```

500-CSS-`px` 幅のビューポートでは、これらのリソースは以下の密度で割り当てられます。

<figure>
  <table>
    <thead>
      <tr>
        <th>リソース</th>
        <th>密度</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>large.jpg</code></td>
        <td><code>1000w</code> ÷ <code>500px</code> = 2x</td>
      </tr>
      <tr>
        <td><code>medium.jpg</code></td>
        <td><code>750w</code> ÷ <code>500px</code> = 1.5x</td>
      </tr>
      <tr>
        <td><code>small.jpg</code></td>
        <td><code>500w</code> ÷ <code>500px</code> = 1x</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="500px 密度") }}</figcaption>
</figure>

しかし、1000-CSS-`px`幅のビューポートでは、同じリソースが同じ `srcset` と `sizes` 値でマークアップされ、異なる密度を持つことになります。

<figure>
  <table>
    <thead>
      <tr>
        <th>リソース</th>
        <th>密度</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>large.jpg</code></td>
        <td><code>1000w</code> ÷ <code>1000px</code> = 1x</td>
      </tr>
      <tr>
        <td><code>medium.jpg</code></td>
        <td><code>750w</code> ÷ <code>1000px</code> = 0.75x</td>
      </tr>
      <tr>
        <td><code>small.jpg</code></td>
        <td><code>500w</code> ÷ <code>1000px</code> = 0.5x</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="1000px 密度") }}</figcaption>
</figure>

これらの密度が計算された後、ブラウザは現在の閲覧状況にもっともマッチする密度のリソースを選択します。この例では、`srcset`に十分な広さのリソースが含まれていなかったと言ってよいでしょう。CSSのビューポートは1,000pxを超えるものもあり、1xを超える密度も珍しくはない。ノートパソコンでこれを読んでいる人は、今まさに、そんな状況で閲覧していることでしょう。そして、このような状況でブラウザができる最善のことは、`large.jpg`を選ぶことです。その1倍の密度は、高密度のディスプレイではまだぼやけて見えるでしょう。

だから、両方で武装する。

1. ブラウザが `x` と `w` の記述子、 `sizes` 値、およびブラウジングコンテキストをどのようにリソース密度に変換するかを理解していること。
2. ブラウジングの状況に応じて`srcset`内のリソース密度の範囲がどのように変化し、最終的にユーザーに影響を与えるかを理解すること。

。。。ここで、 `x` 記述子、または `w` 記述子を使用した `srcset` によって提供される密度の範囲を見てみましょう。

{{ figure_markup(
  image="srcset-density-coverage.png",
  caption="`x` または `w` 記述子を使用する `srcset` がカバーする密度の範囲。",
  description="デスクトップとモバイルの両方で、いくつかの異なる範囲の密度をカバーする記述子を使用した `srcset` の割合を示す棒グラフです。デスクトップでは、91.2%の`srcset`が1xから1.5xの範囲をカバーしました。90.2%が1xから2xの範囲をカバー。9.2%が1xから2.5xの範囲をカバーしている。そして、9.1%が1xから3xの範囲をカバーしました。モバイルでは、92.9%が1xから1.5xの範囲をカバーした。92.2％が1xから2xの範囲をカバー。17.4%が1xから2.5xの範囲をカバー。17.3%が1xから3xの範囲をカバー。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1895556643&format=interactive",
  sheets_gid="1895556643",
  sql_file="srcset_density_coverage.sql"
  )
}}

このデータを解釈する際には、2つの異なるクローラーのビューポートを念頭に置いてください。

- デスクトップ: 1,376 × 768px @1x
- モバイル: 360 × 512px @3x

ビューポートの幅が異なれば、解決された多くの `sizes` 値が変化し、異なる結果が得られたでしょう。

とはいえ、この結果は良さそうですね。10個の`srcset`のうち9個は、より大きなデスクトップのビューポートでも、妥当な範囲の出力ディスプレイ密度（1x-2x）をカバーするリソースの範囲を提供しているのです。<a hreflang="en" href="https://blog.twitter.com/engineering/en_us/topics/infrastructure/2019/capping-image-fidelity-on-ultra-high-resolution-devices">指数関数的な帯域幅コストと、2xを超える密度での視覚的リターンの減少</a>を考えると、2 x以降の急降下は妥当なだけでなく、おそらく最適とさえ思われます。

##### サイズの精度

レスポンシブ画像は厄介なものです。適度に正確な `sizes` 属性を作成し、進化するページレイアウトやコンテンツに合わせて最新の属性を維持することは、レスポンシブ画像を正しく表示する上でもっとも困難なことかもしれません。どれだけの作成者が`sizes`を間違えているか？そして、どの程度間違っているのでしょうか？

{{ figure_markup(
  image="distribution-of-img-sizes-errors.png",
  caption="`<img>` サイズエラーの分布。",
  description="デスクトップとモバイルの両方で、サイズ属性の相対誤差の分布を示す棒グラフ。10パーセンタイルと25パーセンタイルではデスクトップとモバイルで0%、50パーセンタイルではデスクトップ20%、モバイル13%、75パーセンタイルはそれぞれ100%と67%、そして最後に90パーセンタイルでは266%と148%になるのです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1870082934&format=interactive",
  sheets_gid="424107069",
  sql_file="image_sizes_accuracy.sql"
  )
}}

4分の1以上の `sizes` 属性が完璧で、画像のレイアウトサイズと完全に一致します。私自身、誤った`sizes`の属性をいくつも書いてきた人間として、これは驚きであり、印象的でした。つまり、ここでの精度測定はJavaScriptの実行後に行われ、多くの`sizes`属性は最終的にクライアントサイドのJavaScriptによって書かれていることに気づくまででした。以下は、JavaScriptを実行する前の、もっとも一般的な `sizes` の値です。

<figure>
  <table>
    <thead>
      <tr>
        <th>サイズ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`auto`</td>
        <td class="numeric">8.2%</td>
        <td class="numeric">9.6%</td>
      </tr>
      <tr>
        <td>`(max-width: 300px) 100vw, 300px`</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">5.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 150px) 100vw, 150px`</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>`(max-width: 600px) 100vw, 600px`</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>`(max-width: 400px) 100vw, 400px`</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>`(max-width: 800px) 100vw, 800px`</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 500px) 100vw, 500px`</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 1024px) 100vw, 1024px`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>`(max-width: 320px) 100vw, 320px`</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`(max-width: 100px) 100vw, 100px`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>`100vw`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.7%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="もっとも一般的なサイズの属性値のランキングリスト（JavaScript実行前）。", sheets_gid="228184279", sql_file="image_sizes_attribute_strings.sql") }}</figcaption>
</figure>

モバイルの`sizes`属性の10個に1個は、初期値が`auto`になっています。この標準外の値は、おそらくJavaScriptのライブラリ（おそらく<a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes.js</a>）によって、画像の測定されたレイアウトサイズを使って置き換えられると思われます。

レイアウトが完了する前に、ブラウザが読み込むべき適切なリソースを選択するためのヒントを提供するため、`sizes`の多少の誤差は許容範囲内とします。しかし、大きな誤差は、リソースの選択を誤らせることになります。これは、もっとも精度の低い4分の1の `sizes` 属性について言えることで、デスクトップでは実際の `<img>` レイアウト幅の2倍、モバイルでは1.5倍の幅が報告されます。

つまり、10個の `sizes` 属性のうち1個はJavaScriptライブラリによってクライアントで作成されており、少なくとも4個のうち1個は、そのエラーがリソースの選択に影響を与えるほど不正確なのです。これらの事実は、<a hreflang="en" href="https://github.com/ausi/respimagelint">既存のツール</a>または <a hreflang="en" href="https://github.com/whatwg/html/issues/4654"> 新しいWebプラットフォーム機能</a>が、より多くの著者が `sizes` を正しく理解できるようにするための大きなチャンスであることを示しています。

##### `<picture>`の使い方

`<picture>` 要素は、いくつかのユースケースに対応しています。

1. アートディレクション、[`media`属性](https://developer.mozilla.org/docs/Web/HTML/Element/picture#the_media_attribute)付き
2. MIMEタイプに基づくフォーマット切り替え、[`type` 属性](https://developer.mozilla.org/docs/Web/HTML/Element/picture#the_type_attribute) による

{{ figure_markup(
  caption="モバイルページで `<picture>` が使用されている割合。",
  content="5.9%",
  classes="big-number",
  sheets_gid="620965569",
  sql_file="picture_distribution.sql"
)
}}

`<picture>` は `srcset` よりもはるかに使用頻度が低いです。この2つのユースケースで、どのように使い分けがされているのかを紹介します。

{{ figure_markup(
  image="picture-feature-usage.png",
  caption="`<picture>` 機能の使用法。",
  description="`source` 要素の `media` 属性と `type` 属性を、 `picture` 要素と組み合わせて使用しているページの割合を示す棒グラフです。`media` はモバイル48.1%、デスクトップ44.7%の `picture` 要素で使用されています。`type` はモバイルの `picture` 要素の37.6%、デスクトップの `picture` 要素の38.5%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1613173002&format=interactive",
  sheets_gid="2031063502",
  sql_file="picture_switching.sql"
  )
}}

アートディレクションは、フォーマット切り替えに比べるとやや多いようですが、どちらも潜在的な有用性を考えると、あまり活用されていないように思います。これまで見てきたように、モバイル画面に合わせて画像のアスペクト比を調整しているページはほとんどなく、多くのページが次世代フォーマットを使ってより効率的に画像を配信できるはずです。これらはまさに `<picture>` が解決するために考案された問題であり、おそらく5.9%以上のページがこの機能を使って、これらの問題に対処することができたのでしょう。

フォーマット切り替えは [サーバサイドコンテンツネゴシエーション](https://developer.mozilla.org/docs/Web/HTTP/Content_negotiation) でも実現できるので、`<source type>` によるフォーマット切り替えは2〜3%のページでしか使われていない可能性があります。残念ながら、サーバーサイドの適応メカニズムは、クローリングされたデータから検出することが困難であり、ここでは解析していない。

なお、`<source type>`と`<source media>`は相互に排他的ではないので、ここでの使用比率を合わせても100%にはならない。このことから、少なくとも15%の `<picture>` 要素はこれらの属性のどちらも利用しておらず、それらの `<picture>` は機能的に `<span>` と同等であることがわかります。

### レイアウト

ページに画像を埋め込んだら、それを他のコンテンツと一緒にレイアウトする必要があります。この方法にはさまざまなものがありますが、画像を拡大表示し、2つの大きな質問に答えることで、一般的な方法についていくつかの洞察を得ることができます。

#### 内在サイジングと外在サイジング

[置換要素](https://developer.mozilla.org/docs/Web/CSS/Replaced_element)である画像は、自然で[“内在“サイズ](https://developer.mozilla.org/docs/Glossary/Intrinsic_Size)を持っています。このサイズは、CSSルールによる「外在」レイアウト制約がない場合に、デフォルトでレンダリングされるサイズです。

内在性と外在性のサイズの画像はいくつありますか？

{{ figure_markup(
  image="intrinsic-and-extrinsic-image-sizing.png",
  caption="内在的および外在的な画像サイズ調整。",
  description="画像の幅と高さが、外在性と外在サイジングに基づいて決定される割合を示す積み上げ棒グラフです。3つ目のカテゴリーとして（今のところ）謎なのが、両方です。高さと幅では、内在、外在、両者の分布がかなり異なっています。高さについては、59.6%の画像が内在的サイズ、30.3%が外在的サイズ、残りの10.0%が両方に該当するとのこと。幅については、9.6%が内在的サイズ、66.1%が外在的サイズで、残りの24.4%は両方であることがわかった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=769042260&format=interactive",
  sheets_gid="576119731",
  sql_file="image_sizing_extrinsic_intrinsic.sql"
  )
}}

この質問は少し複雑で、画像によっては（`max-width`、`max-height`、`min-width`、`min-height`の制約があるもの）、外在サイズもあれば、内在サイズのままであることもあります。このような画像は "両方" とラベル付けしています。

いずれにせよ、当然のことながら、ほとんどの画像には幅の制約があり、高さに制約のあるサイジングはあまり一般的でありません。

#### `height` と `width` によるレイアウトのずれの軽減

そこで、最後に調査したいのが、ウェブプラットフォームの機能です。<a hreflang="en" href="https://www.youtube.com/watch?v=4-d_SoCHeWE">`height`と`width`属性を使用して、柔軟な画像のためのレイアウトスペースを確保します</a>。

デフォルトでは、画像が読み込まれ、その固有寸法が判明するまで、内在寸法のままではスペースを取りません。その時点で、パッとページに現れて、<a hreflang="en" href="https://developers.google.com/publisher-tag/guides/minimize-layout-shift">レイアウト シフト</a>が発生するのです。これは、まさに `height` と `width` 属性が解決するために発明された問題でした。<a hreflang="en" href="https://www.w3.org/TR/2018/SPSD-html32-20180315/#img">1996年</a> 。

残念ながら`height` と `width` は、ある次元では可変の外在サイズ（たとえば、 `width: 100%;`）が割り当てられ、他の次元では内在の縦横比を満たすように放置される画像とはうまく動作しません。これはレスポンシブデザインにおける支配的なパターンです。そのため、`width` と `height` はレスポンシブコンテキスト内で人気がなくなりましたが、2019年に [ブラウザが `height` と `width` を使用する方法を調整](https://developer.mozilla.org/docs/Web/Media/images/aspect_ratio_mapping#a_new_way_of_sizing_images_before_loading_completes) によってこの問題が修正されました。さて、一貫して `height` と `width` を設定することは、<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">Cumulative Layout Shift</a> を減らすために作成者ができる最善のことの1つです。これらの属性はどれくらいの頻度でこのタスクを達成しているのでしょうか？

{{ figure_markup(
  caption="モバイルの `<img>` のうち、`height` と `width` の両方の属性を持ち、1次元のみの外形寸法を持つものの割合です。",
  content="7.5%",
  classes="big-number",
  sheets_gid="1150803469",
  sql_file="img_with_dimensions.sql"
)
}}

これらの `<img>` のうち、いくつが新しいブラウザの動作を考慮して作成されたかは分かりませんが、すべてこの恩恵を受けています。そして、既存の属性を再利用することで、多くの既存コンテンツが自動的にその恩恵を受けることができる、というのがポイントでした。

### デリバリー

最後に、ネットワーク上で画像がどのように配信されるかを見てみましょう。

#### クロスオリジン画像ホスト

埋め込まれている画像と同じオリジンでホストされている画像はどれくらいあるのでしょうか？ごくわずかな少数派

{{ figure_markup(
  image="image-origins.png",
  caption="画像の出典。",
  description="ルートHTMLページと同じオリジンから配信された画像と、異なる（クロス）オリジンから配信された画像の数を示す棒グラフです。モバイル50.6%、デスクトップ51.1%の画像が、それを埋め込んだ文書と異なるオリジンを持っています。その他の49.4%と48.9%は同一生成元である。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=391739537&format=interactive",
  sheets_gid="2134623775",
  sql_file="img_xdomain.sql"
  )
}}

クロスオリジン画像は、重要な[セキュリティ制限](https://developer.mozilla.org/docs/Web/HTML/CORS_enabled_image)の対象となり、時には<a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">パフォーマンスコスト</a>を発生することがあります。一方、静的資産を専用のCDNに移動することは、[最初の1バイトまでの時間](https://developer.mozilla.org/docs/Glossary/time_to_first_byte) を助けるためにできるもっともインパクトのあることの1つです。画像CDNは、あらゆる種類のベストプラクティスを自動化できる強力な変換および <a hreflang="ja" href="https://web.dev/i18n/ja/image-cdns/">最適化</a> 機能を提供します。51%のクロスオリジン画像のうち、何枚が画像CDNでホストされているか、またそのパフォーマンスを他のウェブのものと比較することは、とても興味深いことでしょう。残念ながら、これは私たちの分析の範囲外でした。

と、いうことで、そろそろ目を向けてもいいのでは。。。

## 動画

昨年から世の中が劇的に変化する中で、Web上での動画の利用が大きく伸びています。2020年のメディアレポートでは、ウェブサイトの1〜2％が`<video>`タグを持っていると推定されています。2021年には、その数が大幅に増え、デスクトップサイトの5％以上、モバイルサイトの4％が`<video>`タグを組み込んでいます。

{{ figure_markup(
  image="sites-with-at-least-one-video-element.png",
  caption="動画要素が1つ以上あるサイト。",
  description="`video`要素の普及率を示す棒グラフです。デスクトップ5.6%、モバイル4.3%のサイトが、少なくとも1つの動画要素を備えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=2077989873&format=interactive",
  sheets_gid="1629096429",
  sql_file="video_adoption.sql"
  )
}}

このようにWeb上での動画利用が大きく伸びているのは、デバイス/ネットワークの向上に伴い、サイトに動画のような没入感を与えたいという要望があることを示しています。

動画との相互作用については、ウェブページに掲載した場合の動画の長さが興味深いです。440k本のデスクトップ動画と382k本のモバイル動画についてこの値を照会することができ、継続時間をさまざまなバケット（秒単位）に分解することができました。

{{ figure_markup(
  image="video-durations.png",
  caption="動画の持続時間。",
  description="デスクトップとモバイルで、動画の長さを棒グラフで表示したものです。デスクトップでは、0〜10秒20.7%、10〜30秒39.5%、30〜60秒18.7%、60〜120秒11.5%、120秒超9.6%となっています。モバイルでは、0〜10秒20.8%、10〜30秒35.8%、30〜60秒20.0%、60〜120秒12.6%、120秒超10.7%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=366287434&format=interactive",
  sheets_gid="1864781514",
  sql_file="video_durations.sql"
  )
}}

モバイル、デスクトップともに、60%の動画が30秒以下です。しかし、1分以上2分未満が12〜13％、2分以上の動画が10％となっています。

### 動画：フォーマット

動画として配信されているのは、どのようなファイルですか？MIMEタイプに`video`を含むすべてのファイルを照会し、ファイル拡張子でソートしています。

下図は、シェア1％以上の動画拡張機能をすべて表示したものです。

{{ figure_markup(
  image="top-extensions-of-files-with-a-video-mime-type.png",
  caption="videoのMIMEタイプを持つファイルの上位の拡張子。",
  description="デスクトップとモバイルで配信される動画ファイルの拡張子を、2020年と2021年の両方で示した棒グラフです。デスクトップとモバイルの数値はほぼ同じです。デスクトップ上の動画に占める`mp4`拡張子の割合は、2020年には64.3%であったが、2021年には49.2%にとどまる。空白の拡張子は、2020年には動画の17.8%を占め、2021年には32.1%と急激に増加する。`fvideos`に占める`ts`拡張子の割合は、2020年には6.3％、2021年には10.0％となる。`m4s`は2.4%から3.3%に上昇した。`webm`は7.6%から3.3%に減少しました。最後、`mov`は2020年のゼロから2021年には0.8%に成長した。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=2066681624&format=interactive",
  sheets_gid="1430902287",
  sql_file="video_ext.sql"
  )
}}

Web上での動画フォーマットのナンバーワンは、圧倒的に `mp4`（またはMPEG-4）です。<a hreflang="en" href="https://caniuse.com/mpeg4">mp4 h264形式は、すべてのモダンブラウザで98.4% サポートされていて</a>、 `mp4` に対応していないブラウザの1.9% は動画をサポートしていないので、実質100%カバーというわけです。興味深いことに、`mp4` の使用率はデスクトップとモバイルの両方で前年同期比 ~15% 減少しています。WebMのサポートも [前年同期比で大幅に減少](../2020/media#videos)（モバイルとデスクトップの両方で50%減少）しています。

伸びているのは、拡張子のないファイル（YouTubeなどのストリーミングプラットフォームに多い）、そしてウェブストリーミングです。`ts` ファイルは、HTTPライブストリーミング (HLS) で使用されるセグメントで、使用率が4%上昇しています。 `.m4s`はMPEG Dynamic Adaptive Streaming over HTTP (MPEG-DASH) のビデオセグメントです。M4Sファイルは、前年同期の2.3%から3.3%へと50%増加しました。

### 動画CSS： `display`

まず始めに、動画がページ上にどのように表示されるかを、その動画のCSS `display` プロパティで見てみましょう。その結果、約半数の動画が`block`という表示値を使用しており、動画を独自の行に配置し、動画の高さと幅の値を設定できるようにしていることがわかりました。また、`inline-block`の値では、高さと幅を指定することができ、すべての動画の合計で3分の2を指定できます。

`display: none` 宣言は、視聴者から動画を隠します。Web上の動画の5本に1本は、この表示値の後ろに隠されているのです。データ使用量の観点からは、ブラウザで動画をダウンロードしたままなので、最適とは言えません。

{{ figure_markup(
  image="video-css-display-percentages.png",
  caption="動画CSSの表示率。",
  description="CSSのdisplayプロパティにさまざまな値を設定した動画要素の割合を示す棒グラフです。デスクトップでは `block` が50.5%を占め、モバイルでは45.4%を占めています。`none`はデスクトップで17.8％、モバイルで21.1％を占めています。`inline` はデスクトップで15.5%、モバイルでは16.7%を占めます。最後に、`inline-block`はデスクトップで14.9%、モバイルでは16.5%の割合を占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1841222549&format=interactive",
  sheets_gid="428232209",
  sql_file="video_styles.sql"
  )
}}

### 動画属性

HTML5の `<video>` タグには、エンドユーザーに対するビデオプレーヤーの表示方法を定義するために使用できる属性が多数あります。

もっとも一般的な属性と、それらが `<video>` タグの中でどのように使われるかを見てみましょう。

{{ figure_markup(
  image="video-element-attributes.png",
  caption="動画要素の属性。",
  description="HTMLの動画要素の各種属性がデスクトップとモバイルの両方で確認された回数を棒グラフで表示したものです。`preload`はデスクトップで15.3%、モバイルでは15.3%、`autoplay` 14.1%、14.5%、`src` 8.9%、7.7%、`playsinline` 6.9%、7.8%、`width` 6.8%、7.5%、`muted` 7.1%、7.1%、 `controls` 5.8%、7.2%、 `loop` 6.6%、6.0%、 `crossorigin` 3.9%、3.0%、 `poster` 0.7%、0.7%、 `controlslist` 0.2%、0.2%、最後に `height` 0.1%、0.1%となります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1099468813&format=interactive",
  sheets_gid="1827909463",
  sql_file="video_attribute_count.sql"
  )
}}

#### `preload`

もっともよく使われる属性はpreloadです。preload属性は、動画のダウンロードを処理する最良の方法について、ブラウザにヒントを与えます。4つのオプションが可能です。`auto`, `metadata`, `none`, そして空のレスポンス（デフォルトの `auto` が使用される）です。

{{ figure_markup(
  image="video-preload-values.png",
  caption="動画プリロードの値。",
  description="2020年、2021年ともに、デスクトップとモバイルで、さまざまなプリロード属性値の普及状況を示す棒グラフ。プリロードが使用されていない動画は、デスクトップでは2020年に50.6％だったのに対し、2021年には54.4％となり、モバイルではそれぞれ59.2％、58.8％となった。デスクトップでは2020年に19.8%の動画で`none`が使われ、2021年には18.1%に減少、モバイルでは16.8%から16.7%と減少幅が小さくなっています。デスクトップでは16.6%の動画に`auto`という値が使用されていましたが、2021年には12.9%に低下し、モバイルでは13.7%から12.0%に低下しています。`metadata`は、デスクトップでは2020年に10.1％、2021年には11.8％に、モバイルでは8.0％から10.1％に増加しました。2020年のデスクトップ動画の1.8%、2021年のデスクトップ動画の1.7%、2020年のモバイル動画の1.5%、2021年のモバイル動画の1.6%は値が設定されていない。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=151055771&format=interactive",
  sheets_gid="1624656886",
  sql_file="video_preload_values.sql"
  )
}}

興味深いことに、モバイルとデスクトップの両方で`preload`が大幅に削減されていることがわかります。多くの動画で変更された可能性がありますが、昨年ウェブに追加された新しい動画がこの設定を利用していないだけかもしれません。ページ重量の観点からは、これはウェブにとって大きな勝利です。

#### `autoplay`

次によく使われる属性は `autoplay` です。これは、動画ができるだけ早く再生されるようにブラウザに指示します（このため、実際にはautoplayはpreload属性を上書きします）。

autoplay属性はブール値属性であり、デフォルトでその存在が真を意味することを意味します。したがって、`autoplay="false"` を使用している190のサイトには、申し訳ありませんが、それはうまくいきません。

#### `width`

また、`width` 属性は `<video>` の上位属性の1つです。これは、ビデオプレーヤーの幅をブラウザに指定します。なお、`height`が使用されることは非常に稀です。ブラウザはこれを設定できますが、<a hreflang="en" href ="https://github.com/whatwg/html/issues/3090">デフォルトのアスペクト比は2:1</a> を使うので、`aspect-ratio` CSS stylingで明示的に上書きしないと不正確な場合があります。

幅はパーセンテージ、またはピクセル単位で表示することができる。

* パーセント幅が定義されている場合、99%の確率で `100%` という値が使用されます。
* ピクセル単位で幅を定義すると、低い幅では非常に似たような数の動画が見られますが、1800と1920の幅では大きく落ち込んでいることがわかります。

{{ figure_markup(
  image="video-widths.png",
  caption="動画の幅",
  description="属性値 `width` の分布を示す棒グラフです。デスクトップとモバイルの値は、最後まで、ほとんどの範囲において非常に似ています。左から順に、100〜200ピクセルの値がデスクトップで0.6%、モバイルでは0.5%、200〜300がそれぞれ4.9%、5.4%、300〜400 5.1%、6.6%、400〜500 2.4%、2.6%、500〜600 1.8%、1.8%、600〜700 11.4%、12.6%、700〜800 0.9%、1.0%、800～900は1.4%と1.3%、900～1000は0.5%と0.6%、1000～1100は1.2%と1.1%、 1100～1200は0.5%と0.7%、1200～1300は0.9%と1.1%、1300～1400は1.5%と1.6%、1400～1500はモバイルではなくデスクトップの0.2%、1800～1900 7.2%、4.8%、1900～2000 4.6%、2.4%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=1390110707&format=interactive",
  sheets_gid="1827909463",
  sql_file="video_attribute_widths.sql"
  )
}}

動画の幅も定義している大きな動画を持つサイトの約半数が、モバイルデバイス用に大きな動画を削除しているようです。ウェブサイトに埋め込まれた1080p（1920ワイド）のビデオを必要とするデバイスはほとんどないため、これは理にかなっていると言えるでしょう。

#### `src`と`<source>`

`src` 属性は、`<video>` タグ内で、再生する動画のURLを指定するために使用します。動画を参照する別の方法として、`<source>` 要素を使用することもできます。

`<source>` 要素の重要な考え方の1つは、開発者が複数の動画フォーマットをブラウザに供給し、ブラウザが理解できる最初のフォーマットを選択することです。

`<source>` の使用状況を見ると、約40%の動画が `<source>` 要素を持たず、`src` 属性を使用していることがわかります。これは、2020年に見られた比率（35％）とほぼ同じです。

{{ figure_markup(
  image="source-element-count.png",
  caption="`source` 要素の数。",
  description="`video` 要素あたりのさまざまな数の `source` 要素の頻度を示す棒グラフです。もっとも一般的な `video` ごとの `source` 要素の数は1で、デスクトップの約49.2%とモバイルの51.1%の `video` がこの数のソースを含んでいます。2番目に多い `source` の子の数は0です。40.5%のデスクトップと38.2% のモバイルの `video` には `source` の子が存在しません。それぞれ7.2%と7.6%が2つの要素を含み、両方で2.8%が3つの要素を含み、最後にデスクトップとモバイルの両方で0.2%が4つの要素を含む `video` 要素を持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQM9deg869BD9knNdVhFNbFnUdVXeyuwzUEIgSW-2XgOBEbALtVnoFapQ5JsDxzzepj6mVoepKBmN_m/pubchart?oid=709685412&format=interactive",
  sheets_gid="1279089769",
  sql_file="video_number_of_sources.sql"
  )
}}

また、`<source>` 要素は、1つの要素だけで使用されることが、もっとも多いことがわかります（`<video>` タグ全体の50％）。2つ以上のビデオ ソースを指定した `<video>` 要素は、わずか10% です。3:1の割合で、2つのソースが3つのソースよりも一般的で、3つ以上のソースもわずかにあります（48個のソースがある動画は1つあります！）。

2つのソースを使用している動画を見てみましょう。出現率上位10位を紹介します。

<figure>
  <table>
    <thead>
      <tr>
        <th>フォーマット</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    </tbody>
      <tr>
        <td>`["video/mp4","video/webm"]`</td>
        <td class="numeric:">25.9%</td>
        <td class="numeric:">26.1%</td>
      </tr>
      <tr>
        <td>`["video/webm","video/mp4"]`</td>
        <td class="numeric:">22.3%</td>
        <td class="numeric:">23.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/ogg"]`</td>
        <td class="numeric:">20.2%</td>
        <td class="numeric:">24.2%</td>
      </tr>
      <tr>
        <td>`[null,null]`</td>
        <td class="numeric:">14.1%</td>
        <td class="numeric:">8.0%</td>
      </tr>
      <tr>
        <td>`["video/mp4"]`</td>
        <td class="numeric:">3.6%</td>
        <td class="numeric:">3.4%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/mp4"]`</td>
        <td class="numeric:">3.5%</td>
        <td class="numeric:">5.1%</td>
      </tr>
      <tr>
        <td>`["application/x-mpegURL","video/mp4"]`</td>
        <td class="numeric:">2.4%</td>
        <td class="numeric:">2.1%</td>
      </tr>
      <tr>
        <td>`[]`</td>
        <td class="numeric:">2.1%</td>
        <td class="numeric:">1.8%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs="avc1.42E01E, mp4a.40.2","video/webm; codecs="vp8, vorbis"]`</td>
        <td class="numeric:">0.8%</td>
        <td class="numeric:">0.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4;","video/webm;"]`</td>
        <td class="numeric:">0.4%</td>
        <td class="numeric:">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`video` 要素の中に 2 つの `source` 要素がある場合に、もっとも一般的な `type` 値の順序のペアです。", sheets_gid="1549760253", sql_file="video_source_formats.sql") }}</figcaption>
</figure>

上位10例のうち6例では、MP4が最初のソースとして記載されています。<a hreflang="en" href="https://caniuse.com/mpeg4">WebでのMP4サポート率は98.4%で</a>、MP4をサポートしていないブラウザは一般に `<video>` タグをまったくサポートしていません。つまり、これらのサイトは2つのソースを必要とせず、WebMやOggのビデオソースを削除することでウェブサーバーのストレージを節約できる、あるいはビデオの順番を逆にすればWebMをサポートするブラウザがWebMをダウンロードするようになるということを意味しています。

3つのソースを持つ`<video>`要素についても同じ傾向があり、上位10例のうち8例がMP4で始まっています。

<figure>
  <table>
    <thead>
      <tr>
        <th>フォーマット</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    </tbody>
      <tr>
        <td>`["video/mp4","video/webm","video/ogg"]`</td>
        <td class="numeric:">30.4%</td>
        <td class="numeric:">28.6%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=avc1","video/mp4; codecs=avc1","video/mp4; codecs=avc1"]`</td>
        <td class="numeric:">13.3%</td>
        <td class="numeric:">16.4%</td>
      </tr>
      <tr>
        <td>`["video/webm","video/mp4","video/ogg"]`</td>
        <td class="numeric:">7.0%</td>
        <td class="numeric:">6.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=avc1"]`</td>
        <td class="numeric:">5.8%</td>
        <td class="numeric:">7.1%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/ogg","video/webm"]`</td>
        <td class="numeric:">5.0%</td>
        <td class="numeric:">5.5%</td>
      </tr>
      <tr>
        <td>`["video/mp4;","video/ogg; codecs="theora, vorbis","video/webm; codecs="vp8, vorbis"]`</td>
        <td class="numeric:">3.8%</td>
        <td class="numeric:">1.2%</td>
      </tr>
      <tr>
        <td>`["video/mp4; codecs=hevc","video/webm","video/mp4"]`</td>
        <td class="numeric:">3.2%</td>
        <td class="numeric:">3.4%</td>
      </tr>
      <tr>
        <td>`["video/mp4"]`</td>
        <td class="numeric:">3.0%</td>
        <td class="numeric:">3.0%</td>
      </tr>
      <tr>
        <td>`["video/ogg; codecs="theora, vorbis","video/webm","video/mp4"]`</td>
        <td class="numeric:">2.7%</td>
        <td class="numeric:">3.3%</td>
      </tr>
      <tr>
        <td>`["video/mp4","video/webm","video/ogv"]`</td>
        <td class="numeric:">2.5%</td>
        <td class="numeric:">1.7%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`video` 要素の中に 3 つの `source` 要素がある場合、もっとも一般的な `type` 値の順序付きトリプレットです。", sheets_gid="1549760253", sql_file="video_source_formats.sql") }}</figcaption>
</figure>

もちろん、これらの実装では、MP4ファイルを再生するだけで、WebMやOggファイルは無視されます。

ウェブページに占める動画の割合は、1～2％から4～5％へと飛躍的に伸びています。この成長は今後も続くと思われます。興味深いことに、「動画の王様」であるMP4は、依然として王様ではあるものの、（レスポンシブで順応できるビデオサイジングを特徴とする）動画ストリーミングフォーマットにシェアを侵食されつつあるのです。

`preload=auto` の使用を減らし、`preload=none` の使用を増やすなど、`<video>` タグをより効率的に使用する動きが見られます。また、`width` 属性の動作から、小さい画面用に動画が修正（または削除）されていることがわかります。

## 結論

冒頭で述べたようにウェブはますますビジュアル化しておりウェブの進化する機能セットを使ってメディアをエンコードし、埋め込み、レイアウトし、配信する方法は進化し続けているのです。今年は、ネイティブの遅延読み込みが、増大し続ける画像の転送サイズに歯止めをかけました。また、WebPのユニバーサルサポートとAVIFの初期サポートは、より豊かなビジュアルと効率的な未来への道を開くものです。映像面では、`<video>`要素の数が爆発的に増え、アダプティブ・ビットレート・ストリーミングのような高度な配信方式が使われるようになりました。

Web Almanacは、棚卸しや振り返りの機会です。そして、これからの道筋を描くときでもあります。2022年のウェブが、より効果的なビジュアルコミュニケーションになることを祈念しています。

