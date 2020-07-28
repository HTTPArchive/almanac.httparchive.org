---
part_number: I
chapter_number: 4
title: メディア
description: 2019年版Web Almanacのメディアの章では、画像ファイルのサイズとフォーマット、レスポンシブ画像、クライアントのヒント、遅延読み込み、アクセシビリティ、動画を取り上げています。
authors: [colinbendell, dougsillars]
reviewers: [ahmadawais, eeeps]
translators: [ksakae]
discuss: 1759
results: https://docs.google.com/spreadsheets/d/1hj9bY6JJZfV9yrXHsoCRYuG8t8bR-CHuuD98zXV7BBQ/
queries: 04_Media
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-07-20T00:00:00.000Z
---

## 序章
画像、アニメーション、動画はウェブ体験の重要な一部です。それらが重要な理由はたくさんあります。ストーリーを伝えたり、視聴者の関心を引きつけたり、他のウェブ技術では簡単には作れないような芸術的な表現を提供したりするのに役立ちます。これらのメディアリソースの重要性は、2つの方法で示すことができます。1つは、1ページのダウンロードに必要なバイト数の多さ、もう1つはメディアで描かれたピクセル数の多さです。

純粋なバイトの観点から見ると、HTTP Archiveは[歴史的に報告されている](https://legacy.httparchive.org/interesting.php#bytesperpage)メディアから関連付けられたリソースバイトの平均3分の2を持っています。分布の観点から見ると、事実上すべてのウェブページが画像や動画に依存していることがわかります。10パーセンタイルでさえ、我々はバイトの44％がメディアからであり、ページの90パーセンタイルで総バイトの91％に上昇できることを参照してください。

<figure>
  <a href="/static/images/2019/media/fig1_bytes_images_and_video_versus_other.png">
    <img src="/static/images/2019/media/fig1_bytes_images_and_video_versus_other.png" alt="図1. Webページのバイト：画像と動画対その他。" aria-labelledby="fig1-caption" aria-describedby="fig1-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1189524305&format=interactive">
  </a>
  <div id="fig1-description" class="visually-hidden">p10パーセンタイルでページバイトの44.1％がメディア、p25パーセンタイルで52.7％がメディア、p50パーセンタイルで67.0％がメディア、p75パーセンタイルで81.7％がメディア、p90パーセンタイルで91.2％がメディアであることを示す棒グラフです。</div>
  <figcaption id="fig1-caption">図1. Webページのバイト：画像と動画対その他。</figcaption>
</figure>

メディアは視覚体験には欠かせないものですが、この大量のバイトのインパクトには2つの副作用があります。

まず、これらのバイトをダウンロードするために必要なネットワークのオーバーヘッドは大きく、携帯電話や低速ネットワーク環境（コーヒーショップやUberに乗っているときのテザリングのような）では劇的にページの[パフォーマンス](./performance)を遅くできます。画像はブラウザによる優先度の低いリクエストですが、ダウンロード中のCSSやJavaScriptを簡単にブロックできます。これ自体がページのレンダリングを遅らせることになります。しかし、画像コンテンツは、ページの準備ができたことをユーザーに視覚的に伝える手がかりとなります。そのため、画像コンテンツの転送が遅いと、ウェブページが遅いという印象を与えることがあります。

2つ目の影響は、ユーザーへの金銭的なコストです。これはウェブサイトの所有者の負担ではなく、エンドユーザーの負担となるため、しばしば無視されがちな側面です。逸話として、[日本のような](https://twitter.com/yoavweiss/status/1195036487538003968?s=20)という市場では、データの上限に達した月末近くは学生の購買意欲が低下し、ユーザーはビジュアルコンテンツを見ることができなくなるということが伝えられています。

さらに、世界のさまざまな地域でこれらのウェブサイトを訪問するための金銭的コストは不釣り合いです。中央値と90パーセンタイルでは、画像のバイト数はそれぞれ1MBと1.9MBです。[WhatDoesMySiteCost.com](https://whatdoesmysitecost.com/#gniCost)を使用すると、マダガスカルのユーザーの一人当たりの国民総所得（GNI）コストは90パーセンタイルでウェブページを1回読み込んだだけで、一日の総所得の2.6％になることがわかります。対照的に、ドイツでは、これは1日の総所得の0.3％になります。

<figure>
  <a href="/static/images/2019/media/fig2_total_image_bytes_per_web_page_mobile.png">
    <img src="/static/images/2019/media/fig2_total_image_bytes_per_web_page_mobile.png" alt="図2. ウェブページあたりの総画像バイト数（モバイル）。" aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2025280105&format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">モバイルの中央値のウェブページでは、90パーセンタイルで1MBの画像と4.9MBの画像が必要です。</div>
  <figcaption id="fig2-caption">図2. ウェブページあたりの総画像バイト数（モバイル）。</figcaption>
</figure>

ページあたりのバイト数を見ると、ページパフォーマンスとユーザーに対するコストだけを見ることになりますが、それは利点を見落としています。これらのバイトは、画面上のピクセルをレンダリングするために重要です。このように、1ページあたりに使用されるメディアのピクセル数を見ることで、画像や動画リソースの重要性を見ることができます。

ピクセル量を見るときに考慮すべき3つのメトリクスがあります。CSSピクセル、ナチュラルピクセル、スクリーンピクセルです。

* _CSSピクセルボリューム_ はCSSの観点からのレイアウトです。この尺度は、画像や動画を引き伸ばしたり、押し込んだりできる境界ボックスに焦点を当てています。また、実際のファイルのピクセルや画面表示のピクセルは考慮されていません。
* _ナチュラルピクセル_ とは、 ファイル内で表現される論理的なピクセルのことを指します。この画像をGIMPやPhotoshopで読み込んだ場合、ピクセルファイルの寸法は自然なピクセルとなります。
* _スクリーンピクセル_ とは、ディスプレイ上の物理的な電子機器を指します。携帯電話や最新の高解像度ディスプレイが登場する以前は、CSSピクセルとスクリーン上のLEDポイントの間には1:1の関係がありました。しかし、モバイルデバイスは目に近づけられ、ノートPCの画面は昔のメインフレーム端末よりも近づけられているため、現代のスクリーンは従来のCSSピクセルに対する物理ピクセルの比率が高くなっています。この比率は、Device-Pixel-Ratio、または口語でRetina™ディスプレイと呼ばれています。
 
 <figure>
  <a href="/static/images/2019/media/fig3_image_pixel_per_page_mobile_css_v_actual.png">
    <img src="/static/images/2019/media/fig3_image_pixel_per_page_mobile_css_v_actual.png" alt="図3. 1ページあたりのピクセル画像（モバイル）。CSS対実物。" aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2027393897&format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">画像コンテンツに割り当てられているCSSの画素数を、実際の画像の画素数と比較した結果、p10（実測は0.07MP、CSSは0.04MP）、p25（実測は0.38MP、CSSは0.18MP）、p50（実測は1.6MP、CSSは0.65MP）、p75（実測は5.1MP、CSSは1.8MP）、p90（実測は12MP、CSSは4.6MP）が表示されていることがわかります。</div>
  <figcaption id="fig3-caption">図3. 1ページあたりのピクセル画像（モバイル）。CSS対実物。</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/media/fig4_image_pixel_per_page_desktop_css_v_actual.png">
    <img src="/static/images/2019/media/fig4_image_pixel_per_page_desktop_css_v_actual.png" alt="図4. 1ページあたりのピクセル画像（デスクトップ）。CSS対実物。" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1364487787&format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">画像コンテンツに割り当てられたCSSの画素数をデスクトップ用の実際の画像の画素数と比較した結果、p10（実際は0.09MP、CSSは0.05MP）、p25（実際は0.52MP、CSSは0.29MP）、p50（実際は2.1MP、CSSは1.1MP）、p75（実際は6.0MP、CSSは2.8MP）、p90（実際は14MP、CSSは6.3MP）が表示されています。</div>
  <figcaption id="fig4-caption">図4. 1ページあたりのピクセル画像（デスクトップ）。CSS対実物。</figcaption>
</figure>

CSSピクセルと自然ピクセル量を見ると、中央値のウェブサイトは1メガピクセル (MP) のメディア コンテンツを表示するレイアウトになっていることがわかります。90パーセンタイルでは、CSSレイアウトのピクセル量はモバイルで4.6MP、デスクトップで6.3MPに増加しています。これはレスポンシブレイアウトが、異なる可能性が高いだけでなく、フォームファクターが異なることも興味深い。要するに、モバイルレイアウトはデスクトップに比べてメディアに割り当てられるスペースが少ないということです。

対照的に、ナチュラル（ファイル）ピクセル量はレイアウト量の2～2.6倍です。デスクトップウェブページの中央値は2.1MPのピクセルコンテンツを送信し、1.1MPのレイアウトスペースに表示されます。モバイルでは、90パーセンタイルの割合で12MPが4.6MPに圧縮されていることがわかります。

もちろん、モバイルデバイスのフォームファクターはデスクトップとは異なります。デスクトップが大きく主に横向きで使用されるのに対し、モバイルデバイスは小さく通常縦向きで使用されます。前述したように、モバイルデバイスは目から近い位置にあるため、一般的にデバイスピクセル比（DPR）が高く、タイムズスクエアのビルボードに必要なピクセル数と比べて1インチあたりのピクセル数が多く必要となります。これらの違いにより、レイアウトの変更を余儀なくされ、モバイルのユーザーはコンテンツの全体を消費するためにサイトをスクロールするのが一般的です。

メガピクセルは、主に抽象的な指標であるため、難しい指標です。ウェブページで使用されているピクセルの量を表現するのに便利な方法は、ディスプレイサイズに対する比率として表現することです。

ウェブページのクロールで使用したモバイル端末では、`512 x 360`の表示で、0.18MPのCSSコンテンツが表示されています（物理的な画面である`3x`や3^2以上の画素である1.7MPと混同しないように）。このビューアーのピクセル量を画像に割り当てられたCSSピクセルの数で割ると、相対的なピクセル量が得られます。

もし、画面全体を完璧に埋め尽くす画像が1枚あったとしたら、これは1xピクセルの塗りつぶし率になります。もちろん、ウェブサイトが1枚の画像でキャンバス全体を埋め尽くすことはほとんどありません。メディアコンテンツは、デザインや他のコンテンツと混在する傾向があります。1xよりも大きい値はレイアウトが追加の画像コンテンツを見るため、ユーザーが、スクロールする必要があることを意味します。

<p class="note">注：これは、viperとレイアウトコンテンツのボリュームの両方のCSSレイアウトを見ているだけです。レスポンシブ画像の効果や、DPRの高いコンテンツを提供することの効果を評価しているわけではありません。</p> 

<figure>
  <a href="/static/images/2019/media/fig5_image_pixel_volume_v_css_pixels.png">
    <img src="/static/images/2019/media/fig5_image_pixel_volume_v_css_pixels.png" alt="図5. 画像のピクセル量と画面サイズ（CSSピクセル）の関係。" aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1889020047&format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">実際の画面サイズCSSピクセルと比較したページあたりに必要なピクセル量の比較では、p10（モバイル20%、デスクトップ2%）、p25（モバイル97%、デスクトップ13%）、p50（モバイル354%、デスクトップ46%）、p75（モバイル1003%、デスクトップ123%）、およびp90（モバイル2477%、デスクトップ273%）が示されています。</div>
  <figcaption id="fig5-caption">図5. 画像のピクセル量と画面サイズ（CSSピクセル）の関係。</figcaption>
</figure>

デスクトップの中央値のウェブページでは、画像や動画を含むレイアウトが表示されるのはディスプレイの46％に過ぎません。対照的に、モバイルでは、メディアピクセルの量が実際のビューポートサイズの3.5倍を埋めています。レイアウトは、1つの画面で埋められる以上のコンテンツがあり、ユーザーはスクロールする必要があります。最低でも、1サイトあたり3.5ページ分のコンテンツがスクロールしていることになります（飽和度100％を想定）。モバイルの90パーセンタイルでは、これはビューポートサイズの25倍にまで大幅に拡大します！

メディアリソースは、ユーザーエクスペリエンスにとって非常に重要です。

## 画像 

バイトの削減とユーザー体験の最適化に役立つ画像の管理と最適化については、すでに多くのことが書かれています。ブランド体験を定義するのはクリエイティブなメディアであるため、多くの人にとって重要かつクリティカルなトピックとなっています。したがって画像や動画コンテンツの最適化は、意図した体験の忠実性を維持しながら、ネットワーク上で転送されるバイト数を減らすのに役立つベストプラクティスを適用することとの間のバランスをとる行為です。

画像、動画、アニメーションに利用されている戦略は、大まかに似ていますが、具体的なアプローチは大きく異なります。一般的には、これらの戦略は次のようなものです。

* **ファイル形式** - 最適なファイル形式を利用
* **レスポンシブ** - レスポンシブ画像技術を適用して、画面に表示されるピクセルだけを転送する
* **遅延ローディング** - 人が見たときだけコンテンツを転送する
* **アクセシビリティ** - 全人類に一貫した体験を提供する

<p class="note">これらの結果を解釈する際には注意が必要です。Web Almanacのためにクロールされたウェブページは、Chromeブラウザでクロールされました。これは、SafariやFirefoxに適したコンテンツネゴシエーションが、このデータセットでは表現されていない可能性があることを意味しています。例えば、JPEG2000、JPEG-XR、HEVC、HEICなどのファイル形式は、Chromeではネイティブにサポートされていないため、使用されていません。これは、ウェブにこれらの他の形式や経験が含まれていないことを意味するものではありません。同様に、Chrome には遅延読み込みのネイティブサポートがあります（v76 以降）が、他のブラウザではまだ利用できません。これらの注意事項については、<a href="./methodology">方法論</a>をご覧ください。</p>

画像を利用していないウェブページを見つけることは稀です。長年にわたり、ウェブ上でコンテンツを表示するためのさまざまなファイルフォーマットが登場してきましたが、それぞれが異なる問題に対処してきました。主に4つの普遍的な画像フォーマットがあります。JPEG、PNG、GIF、およびSVGです。さらに、Chromeではメディア パイプラインが強化され、5つ目の画像フォーマットのサポートが追加されました。WebP。他のブラウザでも同様にJPEG2000（Safari）、JPEG-XL（IEとEdge）、HEIC（SafariではWebViewのみ）のサポートが追加されています。

それぞれのフォーマットにはそれぞれメリットがあり、Web上での理想的な使い方があります。とても簡単にまとめると以下のようになります。

<figure>
<table>
<thead>
<tr>
<th>フォーマット</th>
<th class="width-45">ハイライト</th>
<th class="width-45">欠点</th>
</tr>
</thead>
<tbody>
<tr>
<td>JPEG</td>
<td><ul><li>ユビキタスに対応</li><li>写真コンテンツに最適</li></ul></td>
<td><ul><li>常に品質の損失がある</li><li>ほとんどのデコーダは、最新のカメラからの高ビット深度の写真を扱うことができません（チャンネルあたり8ビット以上）</li><li>透明性のサポートはありません</li></ul></td>
</tr>
<tr>
<td>PNG</td>
<td><ul><li>JPEGやGIFのように、幅広いサポートを共有しています</li><li>ロスレスです</li><li>透明度、アニメーション、高ビット深度をサポート</li></ul></td>
<td><ul><li>JPEGに比べてはるかに大きなファイル</li><li>写真コンテンツには理想的ではない</li></ul></td>
</tr>
<tr>
<td>GIF</td>
<td><ul><li>PNGの前身Gは、アニメーションで最もよく知られています。</li><li>ロスレス</li></ul></td>
<td><ul><li>256色の制限があるため、変換による視覚的な損失が常にあります</li><li>アニメーション用の非常に大きなファイル</li></ul></td>
</tr>
<tr>
<td>SVG</td>
<td><ul><li>ファイルサイズを増やさずにリサイズできるベクターベースのフォーマット</li><li>ピクセルではなく数学に基づいており、滑らかな線を作成します</li></ul></td>
<td><ul><li>写真やその他のラスターコンテンツには有用ではない</li></ul></td>
</tr>
<tr>
<td>WebP</td>
<td><ul><li>PNGのようなロスレス画像とJPEGのようなロスレス画像を生成することができる新しいファイル形式です</li><li><a href="https://developers.google.com/speed/webp/faq">JPEGと比較して平均30%のファイル削減率を誇っています</a>が、他のデータでは、ファイル削減率の中央値は<a href="https://cloudinary.com/state-of-visual-media-report/">ピクセル量に基づいて10-28%の間であることが示唆されています</a></li></ul></td>
<td><ul><li>JPEGとは異なり、一部の画像がぼやけて見えるクロマサブサンプリングに限定されます</li><li>普遍的にサポートされているわけではありません。Chrome、Firefox、Androidのエコシステムのみ</li><li>ブラウザのバージョンに応じて断片化された機能のサポート</li></ul></td>
 </tr>
 </tbody>
 </table>

 <figcaption>図6. 主流のファイル形式の説明。</figcaption>
</figure>
  
### 画像フォーマット

すべてのページを見てみると、これらのフォーマットの普及率が、高いことがわかります。ウェブ上でもっとも古いフォーマットの1つであるJPEGは画像リクエストの60％、全画像バイトの65％で圧倒的に、もっとも一般的に使用されている画像フォーマットです。興味深いことに、PNGは画像要求とバイト数の28％で2番目によく使われている画像フォーマットです。色の正確さやクリエイティブなコンテンツの精度に加えて、サポートがどこにでもあることが広く使われている理由と考えられます。対照的に、SVG、GIF、WebPは4％とほぼ同じ使用率です。

<figure>
  <a href="/static/images/2019/media/fig7_image_format_usage.png">
    <img alt="Most frequent Image types used on web pages" aria-labelledby="fig7-caption" aria-describedby="fig7-description" src="/static/images/2019/media/fig7_image_format_usage.png" width="600" height="376">
  </a>
  <div id="fig7-description" class="visually-hidden">ツリーマップを見ると、JPEGが60.27％、PNGが28.2％、WebPが4.2％、GIFが3.67％、SVGが3.63％となっています。</div>
  <figcaption id="fig7-caption">図7. 画像フォーマットの使用法</figcaption>
</figure>

もちろん、ウェブページの画像コンテンツの使い方は一様でありません。画像に依存しているページもあれば、いくつかは他よりも画像に依存しています。`google.com`のホームページを見てみると、一般的なニュースサイトに比べて画像はほとんどないことがわかります。実際、中央値のウェブサイトには13枚の画像があり、90パーセンタイルでは61枚、99パーセンタイルでは229枚の画像があります。

<figure>
  <a href="/static/images/2019/media/fig8_image_format_usage_per_page.png">
    <img src="/static/images/2019/media/fig8_image_format_usage_per_page.png" alt="Figure 8. Image format usage per page." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=294858455&format=interactive">
  </a>
<div id="fig8-description" class="visually-hidden">p10パーセンタイルでは画像フォーマットが全く使用されていないことを示す棒グラフ、p25パーセンタイルではJPGが3枚とPNGが4枚、p50パーセンタイルではJPGが9枚、PNGが4枚、GIFが1枚、p75パーセンタイルではJPEGが39枚、PNGが18枚、SVGが2枚、GIFが2枚、p99パーセンタイルではJPGが119枚、PNGが49枚、WebPが28枚、SVGが19枚、GIFが14枚使用されていることを示しています。</div>
  <figcaption id="fig8-caption">図8. 1ページあたりの画像フォーマットの使用量</figcaption>
</figure>

中央値のページではJPEGが9枚、PNGが4枚となっており、GIFが使用されているのは上位25％のページのみで、採用率は報告されていません。1ページあたりの各フォーマットの使用頻度は、より近代的なフォーマットの採用についての洞察を提供していません。具体的には、各フォーマットに少なくとも1枚の画像が含まれているページの割合は？

<figure>
  <a href="/static/images/2019/media/fig9_pages_using_at_least_1_image.png">
    <img src="/static/images/2019/media/fig9_pages_using_at_least_1_image.png" alt="図9. 少なくとも1枚の画像を使用しているページの割合。" aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1024386063&format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">棒グラフで見ると、90%のページでJPEGが使用されており、89%がPNG、9%がWebP、37%がGIF、22%がSVGとなっています。</div>
  <figcaption id="fig9-caption">図9. 少なくとも1枚の画像を使用しているページの割合。</figcaption>
</figure>

これは、90パーセンタイルのページでさえWebPの頻度がゼロである理由を説明するのに役立ちます。WebPがイメージに適していない理由はたくさんありますが、メディアのベストプラクティスの採用は、WebP自体の採用のようにまだ初期段階にとどまっています。

### 画像ファイルのサイズ

画像ファイルのサイズを見るには、リソースあたりの絶対バイト数とピクセルあたりのバイト数の2つの方法があります。
 
<figure>
  <a href="/static/images/2019/media/fig10_image_format_size.png">
    <img alt="A comparison of image formats by file size" aria-labelledby="fig10-caption" aria-describedby="fig10-description" src="/static/images/2019/media/fig10_image_format_size.png" width="600" height="371">
  </a>
  <div id="fig10-description" class="visually-hidden">p10パーセンタイルではJPEGの4KB、PNGの2KB、GIFの2KBが使用され、p25パーセンタイルではJPGの9KB、PNGの4KB、WebPの7KB、GIFの3KBが使用され、p50パーセンタイルではJPGの24KB、PNGの11KB、WebPの17KB、GIFの6KBが使用されていることを示すチャート。SVGの1KBが使用され、p75パーセンタイルではJPEGの68KB、PNGの43KB、WebPの41KB、GIFの17KB、SVGの2KBが使用され、p90パーセンタイルではJPGの116KB、PNGの152KB、WebPの90KB、GIFの87KB、SVGの8KBが使用されています。</div>
  <figcaption id="fig10-caption">図10. 画像形式別のファイルサイズ（KB）。</figcaption>
</figure>

このことから、ウェブ上の典型的なリソースの大きさや小ささを知ることができます。しかし、これではこれらのファイル分布の画面上で表現されているピクセルの量を知ることはできません。これを行うには、各リソースのバイト数を画像の自然なピクセル数で割ることができます。1ピクセルあたりのバイト数が低いほど、視覚コンテンツの伝送効率が高いことを示しています。

 <figure>
  <a href="/static/images/2019/media/fig11_bytes_per_pixel.png">
    <img src="/static/images/2019/media/fig11_bytes_per_pixel.png" alt="図11. ピクセルあたりのバイト数。" aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1379541850&format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">ローソク足チャートは、p10パーセンタイルでは、JPEGが0.1175byte/pixel、PNGが0.1197byte/pixel、GIFが0.1702byte/pixel、WebPが0.0586byte/pixel、SVGが0.0293byte/pixelであることを示しています。p25パーセンタイルでは、JPEGが0.1848byte/pixel、PNGが0.2874byte/pixel、GIFが0.3641byte/pixel、WebPが0.1025byte/pixel、SVGが0.174byte/pixelとなっています。p50パーセンタイルでは、JPEGが0.2997byte/pixel、PNGが0.6918byte/pixel、GIFが0.7967byte/pixel、WebPが0.183byte/pixel、SVGが0.6766byte/pixelとなっています。p75パーセンタイルでは、JPEGが0.5456byte/pixel、PNGが1.4548byte/pixel、GIFが2.515byte/pixel、WebPが0.3272byte/pixel、SVGが1.9261byte/pixelとなっています。p90パーセンタイルでは、JPEGが0.9822byte/pixel、PNGが2.5026byte/pixel、GIFが8.5151byte/pixel、WebPが0.6474byte/pixel、SVGが4.1075byte/pixelとなっています。</div>
  <figcaption id="fig11-caption">図11. ピクセルあたりのバイト数。</figcaption>
</figure>

以前はGIFファイルがJPEGよりも小さいと思われていましたが、今ではJPEGのリソースが大きくなった原因はピクセルボリュームにあることがはっきりとわかります。おそらく、GIFが他のフォーマットと比較して非常に低いピクセル密度を示していることは驚きではありません。さらにPNGは高いビット深度を扱うことができ、クロマサブサンプリングのぼやけに悩まされることはありませんが、同じピクセルボリュームではJPGやWebPの約2倍のサイズになります。

なお、SVGに使用されるピクセル量は、画面上のDOM要素のサイズ（CSSピクセル）です。ファイルサイズの割にはかなり小さいですが、これは一般的にSVGがレイアウトの小さい部分で使用されていることを示唆しています。これが、PNGよりも1ピクセルあたりのバイト数が悪く見える理由です。

繰り返しになりますが、この画素密度の比較は、同等の画像を比較しているわけではありません。むしろ、典型的なユーザー体験を報告しているのです。次に説明するように、これらの各フォーマットでも、ピクセルあたりのバイト数をさらに最適化して減らすために使用できる技術があります。

### 画像フォーマットの最適化

体験に最適なフォーマットを選択することは、フォーマットの能力のバランスをとり、総バイト数を減らすことです。ウェブページの場合、画像を最適化することでウェブパフォーマンスを向上させることが1つの目標です。しかし、それぞれのフォーマットには、バイト数を減らすのに役立つ追加機能があります。

いくつかの機能は、総合的な体験に影響を与えることができます。たとえばJPEGやWebPでは、_量子化_（一般的には_品質レベル_と呼ばれる）や _クロマサブサンプリング_ を利用でき、視覚的な体験に影響を与えることなく、画像に格納されているビット数を減らすことができます。音楽用のMP3のように、この技術は人間の目のバグに依存しており、カラーデータが失われるにもかかわらず同じ体験を可能にします。しかし、すべての画像がこれらの技術に適しているわけではありません。

他のフォーマット機能は、単にコンテンツを整理するだけで、時には文脈に沿った知識を必要とします。たとえばJPEGのプログレッシブエンコーディングを適用すると、ピクセルはスキャンレイヤーに再編成されブラウザはより早くレイアウトを完成させることができ、同時にピクセル量を減らすことができます。

1つの[Lighthouse](./methodology#lighthouse)テストは、ベースラインとプログレッシブにエンコードされたJPEGをA/Bで比較するものです。これは画像全体がロスレス技術でさらに最適化されるか、また異なる品質レベルを使用するなど、潜在的には不可逆技術で最適化されるかどうかを示すための気付きを提供しています。

 <figure>
  <a href="/static/images/2019/media/fig12_percentage_optimized_images.png">
    <img src="/static/images/2019/media/fig12_percentage_optimized_images.png" alt="図12. 「最適化された」画像の割合。" aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1569150767">
  </a>
  <div id="fig12-description" class="visually-hidden">p10パーセンタイルでは100%の画像が最適化されており、p25パーセンタイルでも同様で、p50パーセンタイルでは98%の画像が最適化されており（2%は最適化されていない）、p75パーセンタイルでは83%の画像が最適化されており（17%は最適化されていない）、p90パーセンタイルでは59%の画像が最適化されており、41%の画像が最適化されていないことを示す棒グラフです。</div>
  <figcaption id="fig12-caption">図12. 「最適化された」画像の割合。</figcaption>
</figure>

このAB Lighthouseテストでの節約は、p95で数MBに達することができる潜在的なバイトの節約だけでなく、ページパフォーマンスの向上を実証しています。

 <figure>
  <a href="/static/images/2019/media/fig13_project_perf_improvements_image_optimization.png">
    <img src="/static/images/2019/media/fig13_project_perf_improvements_image_optimization.png" alt="図13. Lighthouseからの画像最適化によるページパフォーマンスの向上を予測。" aria-labelledby="fig12-caption" aria-describedby="fig13-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=167590779">
  </a>
  <div id="fig13-description" class="visually-hidden">p10パーセンタイルでは0ms、p25パーセンタイルでも同じ、p50パーセンタイルでは150ms、p75パーセンタイルでは1,460ms、p90パーセンタイルでは5,720msの保存が可能であることを示す棒グラフです。</div>
  <figcaption id="fig13-caption">図13. Lighthouseからの画像最適化によるページパフォーマンスの向上を予測。</figcaption>
</figure>

### レスポンシブ画像

ページパフォーマンスを向上させるもう1つの軸として、レスポンシブ画像の適用があります。これは、画像の縮小によってディスプレイに表示されない余分なピクセルを減らすことで、画像のバイト数を減らすことに重点を置いた手法です。この章の最初の方でデスクトップの中央のウェブページでは、1MPの画像プレースホルダーが使用されているにもかかわらず、実際のピクセル量は2.1MP転送されていることを見ました。これは1xDPRテストだったので、1.1MPのピクセルがネットワーク経由で転送されましたが、表示されませんでした。このオーバーヘッドを減らすために、2つの技術のうちの1つを使用できます（3つの可能性もあります）。

* **HTMLマークアップ** - `srcset`要素と`sizes`要素を組み合わせて使用することで、ブラウザはビューポートの寸法とディスプレイの密度に基づいて最適な画像を選択できます。
* **クライアントヒント** - これは、リサイズ可能な画像の選択をHTTPコンテントネゴシエーションに移行させます。
* **特典**: JavaScriptライブラリーは、JavaScriptがブラウザーDOMを実行して検査し、コンテナーに基づいて正しい画像を挿入できるようになるまで画像のロードを遅らせます。

### HTMLマークアップの使用

レスポンシブ画像を実装するもっとも一般的な方法は、`<img srcset>` または `<source srcset>`のいずれかを用いて代替画像のリストを作成することです。`srcset`がDPRに基づいている場合、ブラウザは追加情報なしでリストから正しい画像を選択できます。しかし、ほとんどの実装では、`srcset`のピクセルサイズに基づいて正しい画像を選択するため必要なレイアウト計算の方法をブラウザへ指示するため`<img sizes>`を利用しています。

 <figure>
  <a href="/static/images/2019/media/fig14_html_usage_of_responsive_images.png">
    <img src="/static/images/2019/media/fig14_html_usage_of_responsive_images.png" alt="図14. HTMLでレスポンシブ画像を使用しているページの割合。" aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=582530039&format=interactive">
  </a>
  <div id="fig14-description" class="visually-hidden">18%の画像が「sizes」を使用しており、21%が「srcset」を使用しており、2%が「picture」を使用していることを示す棒グラフです。</div>
  <figcaption id="fig14-caption">図14. HTMLでレスポンシブ画像を使用しているページの割合。</figcaption>
</figure>

[アートディレクション](https://developer.mozilla.org/ja/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images#Art_direction)のような高度なレスポンシブウェブデザイン（RWD）レイアウトによく使われていることを考えると、`<picture>`の使用率が著しく低いのは驚くべきことでありません。

### サイズの使用

`srcset`の有用性は、通常は`sizes`メディアクエリの精度に依存します。`sizes`がないと、ブラウザは`<img>`タグが小さいコンポーネントではなくビューポート全体を埋め尽くすと仮定します。興味深いことに、ウェブ開発者が`<img sizes>`に採用している共通のパターンは5つあります。

* **`<img sizes="100vw">`** - これは画像がビューポートの幅を埋め尽くすことを示します（デフォルトでもあります）。
* **`<img sizes="200px">`** - これは、DPRに基づいてブラウザを選択する際に便利です。
* **`<img sizes="(max-width: 300px) 100vw, 300px">`** - これは2番目に人気のあるデザインパターンです。これはWordPressとおそらく他のいくつかのプラットフォームで自動生成されるものです。元の画像サイズ（この場合は300px）に基づいて自動生成されているように見えます。
* **`<img sizes="(max-width: 767px) 89vw, (max-width: 1000px) 54vw, ...">`** - このパターンは、CSSレスポンシブレイアウトに合わせてカスタムビルドしたデザインパターンです。ブレークポイントごとに使用するサイズの計算が異なります。

<figure markdown>
`<img sizes>` | 頻度 (百万) | %
-- | -- | --
(max-width: 300px) 100vw, 300px | 1.47 | 5%
(max-width: 150px) 100vw, 150px | 0.63 | 2%
(max-width: 100px) 100vw, 100px | 0.37 | 1%
(max-width: 400px) 100vw, 400px | 0.32 | 1%
(max-width: 80px) 100vw, 80px | 0.28 | 1%

  <figcaption id="fig15-caption">図15. 最も人気のある<code>sizes</code>パターンを使用しているページの割合。</figcaption>
</figure>

* **`<img sizes="auto">`** - これはもっともよく使われている使い方ですが、実際には非標準であり、`lazy_sizes`JavaScriptライブラリの使用によるものです。これはクライアント側のコードを使って、ブラウザのためにより良い`sizes`の計算を注入します。これの欠点は、JavaScriptの読み込みとDOMの準備が完全に整っているかどうかに依存し、画像の読み込みが大幅に遅れることです。

 <figure>
  <a href="/static/images/2019/media/fig16_top_patterns_of_img_sizes.png">
    <img src="/static/images/2019/media/fig16_top_patterns_of_img_sizes.png" alt="図16. 'img sizes'のトップパターン。" aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=663985412&format=interactive">
  </a>
  <div id="fig16-description" class="visually-hidden">1,130万枚の画像が「img sizes="(max-width: 300px) 100vw, 300px"」を使用しており、「auto」が160万枚、「img sizes="(max-width: 767px) 89vwなどなど"」が100万枚、「100vw」が23万枚、「300px」が13万枚であることを棒グラフで示しています。</div>
  <figcaption id="fig16-caption" >図16. <code>&lt;img sizes&gt;</code>のトップパターン。</figcaption>
</figure>

### クライアントヒント

[クライアントヒント](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/client-hints) は、コンテンツ制作者が画像のリサイズをHTTPコンテンツネゴシエーションに移すことを可能にします。この方法では、HTMLはマークアップを乱雑にするための追加の `<img srcset>` を必要とせず、代わりにサーバや [最適な画像を選択するための画像CDN](https://cloudinary.com/blog/client_hints_and_responsive_images_what_changed_in_chrome_67) に依存できます。これによりHTMLの簡素化が可能になり、オリジンサーバが時間の経過とともに適応し、コンテンツ層とプレゼンテーション層を切り離すことが可能になります。

クライアントヒントを有効にするには、ウェブページでブラウザに追加のHTTPヘッダー`Accept-CH: DPR, Width, Viewport-Width`を使ってシグナルを送る必要があります。 _または_ HTML`<meta http-equiv="Accept-CH" content="DPR, Width, Viewport-Width">`を追加します。どちらか一方の手法の利便性は実装するチームに依存し、どちらも利便性のために提供されています。

<figure>
  <a href="/static/images/2019/media/fig17_usage_of_accept-ch_http_v_html.png">
    <img src="/static/images/2019/media/fig17_usage_of_accept-ch_http_v_html.png" alt="Accept-CH の使用法: HTTP と HTML の比較。" aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=284657706&format=interactive">
  </a>
  <div id="fig17-description" class="visually-hidden">71%が'meta http-equiv'を使用し、30% が'Accept-CH'HTTPヘッダーを使用し、1%が両方を使用していることを示す棒グラフです。</div>
  <figcaption id="fig17-caption">図17. <code>Accept-CH</code>ヘッダーと同等の<code>&lt;meta&gt;</code>タグの使用法。</figcaption>
</figure>

HTMLでクライアントヒントを呼び出すために`<meta>`タグを使うのは、HTTPヘッダーに比べてはるかに一般的です。これは、ミドルボックスにHTTPヘッダーを追加するよりも、マークアップテンプレートを変更する方が便利であることを反映していると思われます。しかし、HTTPヘッダーの利用状況を見ると、50％以上が単一のSaaSプラットフォーム（Mercado）からのものです。

呼び出されたクライアントヒントのうち、大部分のページでは`DPR`,`ViewportWidth`,`Width`の3つのユースケースで使用されている。もちろん、`Width`のクライアントヒントでは、ブラウザがレイアウトに関する十分なコンテキストを持つために`<img sizes>`を使用する必要があります。

<figure>
  <a href="/static/images/2019/media/fig18_enabled_client_hints.png">
    <img src="/static/images/2019/media/fig18_enabled_client_hints.png" alt="図18. 有効化されたクライアントヒント。" aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1878506264&format=interactive">
  </a>
  <div id="fig18-description" class="visually-hidden">ドーナツ型のパイチャートを見ると、クライアントヒントの26.1%が「dpr」を使用しており、24.3%が「viewport-width」を使用しており、19.7%が「width」を使用しており、6.7%が「save-data」を使用しており、6.1%が「device-memory」を使用しており、6.0%が「downnlink」を使用しており、5.6%が「rtt」を使用しており、5.6%が「ect」を使用していることを示しています。</div>
  <figcaption id="fig18-caption">図18. 有効化されたクライアントヒント。</figcaption>
</figure>

ネットワーク関連のクライアントヒント`downlink`、`rtt`、`ect`はAndroid Chromeでのみ利用可能です。

### 遅延ローディング

ウェブページのパフォーマンスを改善することは、部分的にはイリュージョンのゲームとして特徴付けることができます。このように遅延読み込み画像は、ユーザーがページをスクロールしたときにのみ画像やメディアコンテンツが読み込まれる、これらのイリュージョンの1つです。これにより、遅いネットワークでも知覚パフォーマンスが向上し、ユーザーが他の方法で表示されていないバイトをダウンロードする手間が省けます。

以前、<a href="#fig-5">図5</a>で、75パーセンタイルの画像コンテンツの量が、理論的には単一のデスクトップやモバイルのビューポートで表示できる量をはるかに超えていることを示しました。[オフスクリーン画像](https://developers.google.com/web/tools/lighthouse/audits/offscreen-images)Lighthouseの監査は、この疑念を裏付けています。ウェブページの中央値では、折り目の下に27％の画像コンテンツがあります。これは、90パーセンタイルの割合で84％に増加しています。

<figure>
  <a href="/static/images/2019/media/fig19_lighthouse_audit_offscreen.png">
    <img src="/static/images/2019/media/fig19_lighthouse_audit_offscreen.png" alt="図19. Lighthouse監査：オフスクリーン。" aria-labelledby="fig19-caption" aria-describedby="fig19-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2123391693&format=interactive">
  </a>
  <div id="fig19-description" class="visually-hidden">P10パーセンタイルでは画像の0%が画面外、P25パーセンタイルでは2%が画面外、P50パーセンタイルでは27%が画面外、P75パーセンタイルでは64%が画面外、P90パーセンタイルでは 84%が画面外であることを示す棒グラフです。</div>
  <figcaption id="fig19-caption">図19. Lighthouse監査：オフスクリーン。</figcaption>
</figure>

Lighthouseの監査では、質の高いプレースホルダーを使用するなど、油断できない状況がいくつもあるため、臭いを嗅ぎ分けてくれます。

遅延ローディングはIntersection Observers、Resize Observersの組み合わせを含め[実装可能](https://developers.google.com/web/fundamentals/performance/lazy-loading-guidance/images-and-video) です、または[lazySizes](https://github.com/aFarkas/lazysizes)、[lozad](https://github.com/ApoorvSaxena/lozad.js)などのJavaScriptライブラリの使用などさまざまな方法で実装できます。

2019年8月、Chrome76では`<img loading="lazy">`を使用したマークアップベースの遅延ローディングのサポートが開始されました。2019年のWeb Almanacに使用されたウェブサイトのスナップショットは2019年7月のデータを使用していますが、2,509以上のウェブサイトがすでにこの機能を利用していました。

### アクセシビリティ

画像アクセシビリティの中心にあるのは `alt` タグです。画像に `alt` タグが追加されると、このテキストは画像を見ることができない（障害のある、インターネット接続が悪いのいずれかの理由で）ユーザーに画像を説明するために使用されます。

データセットのHTMLファイルに含まれるすべての画像タグを検出できます。デスクトップでは1,300万個、モバイルでは1,500万個の画像タグのうち、91.6％の画像に`alt`タグが存在しています。一見すると、ウェブ上では画像のアクセシビリティは非常に良好な状態にあるように見えます。しかし、よく調べてみると、見通しはあまり良くありません。データセットに存在する`alt`タグの長さを調べると、`alt`タグの長さの中央値は6文字であることがわかります。これは空の`alt`タグ（`alt=""`のように見える）に対応する。6文字以上の長さの`alt`テキストを使用している画像は全体の39％にすぎない。実際の」`alt`テキストの中央値は31文字で、そのうち25文字が実際に画像を説明しています。

## 動画

ウェブページで提供されるメディアは画像が主流ですが、ウェブ上でのコンテンツ配信では動画が大きな役割を果たし始めています。HTTP Archiveによると、デスクトップサイトの4.06％、モバイルサイトの2.99％が動画ファイルをセルフホスティングしていることがわかります。つまり、動画ファイルはYouTubeやFacebookのようなウェブサイトがホストしているわけではないということです。

### 動画フォーマット

動画は、多くの異なるフォーマットやプレイヤーで配信できます。モバイルおよびデスクトップ向けの主要なフォーマットは、`.ts`（HLSストリーミングのセグメント）と`.mp4`(H264 MPEG) です。

<figure>
  <a href="/static/images/2019/media/fig20_video_files_by_extension.png">
    <img src="/static/images/2019/media/fig20_video_files_by_extension.png" alt="図20. 拡張子別の動画ファイルの数" aria-labelledby="fig20-caption" aria-describedby="fig20-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=999894252&format=interactive">
  </a>
  <div id="fig20-description" class="visually-hidden">棒グラフは、デスクトップで「ts」が1,283,439件（モバイルで792,952件）、デスクトップで「mp4」が729,757件（モバイルで662,015件）、デスクトップで「webm」が38,591件（モバイルで32,417件）、デスクトップは「mov」が22,194件（モバイルは14,986件）、デスクトップは「m4s」が17,338件（モバイルは16,046件）、デスクトップは「m4v」が7,466件（モバイルは6,169件）となっています。</div>
  <figcaption id="fig20-caption">図20. 拡張子別の動画ファイルの数</figcaption>
</figure>

他にも、`webm`、`mov`、`m4s`、`m4v`（MPEG-DASHストリーミングセグメント）などのフォーマットが見られます。ウェブ上のストリーミングの大部分はHLSであり、静的動画の主要なフォーマットは`mp4`であることが明らかです。

各フォーマットの動画サイズの中央値は以下の通りです。

<figure>
  <a href="/static/images/2019/media/fig21_median_vidoe_file_size_by_extension.png">
    <img src="/static/images/2019/media/fig21_median_vidoe_file_size_by_extension.png" alt="図21. 動画の拡張子別のファイルサイズの中央値。" aria-labelledby="fig21-caption" aria-describedby="fig21-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=821311770&format=interactive">
  </a>
  <div id="fig21-description" class="visually-hidden">「ts」の平均ファイルサイズがデスクトップで335KB(モバイルで156KB)、「mp4」がデスクトップで175KB(モバイルで128KB)、「webm」がデスクトップで359KB(モバイルで192KB)、「mov」がデスクトップで128KB(モバイルで96KB)、「m4s」がデスクトップで324KB(モバイルで246KB)、「m4v」がデスクトップで383KB(モバイルで161KB)であることを示す棒グラフ。</div>
  <figcaption id="fig21-caption">図21. 動画の拡張子別のファイルサイズの中央値。</figcaption>
</figure>

中央値はモバイルの方が小さくなっていますが、これはおそらくデスクトップで非常に大きな動画を持っているサイトがモバイル用へ無効化していたり、動画ストリームが小さい画面に小さいバージョンの動画を提供していたりすることを意味していると思われます。

### 動画ファイルのサイズ

ウェブ上で動画を配信する場合、ほとんどの動画はHTML5動画プレイヤーで配信されます。HTML動画プレイヤーは、さまざまな目的で動画を配信するために非常にカスタマイズが可能です。たとえば、動画を自動再生するには、パラメーター`autoplay`と`muted`を追加します。`controls`属性は、ユーザーが動画を開始/停止したり、スキャンしたりすることを可能にします。HTTP Archiveの動画タグを解析することで、これらの属性の使用状況を確認できます。

<figure>
  <a href="/static/images/2019/media/fig22_html_video_tag_attributes_usage.png">
    <img src="/static/images/2019/media/fig22_html_video_tag_attributes_usage.png" alt="図21. HTML 動画タグ属性の使用法。" aria-labelledby="fig21-caption" aria-describedby="fig21-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=593556050&format=interactive">
  </a>
  <div id="fig22-description" class="visually-hidden">デスクトップ用のバーチャート。'autoplay'は11.84%、'buffered'は0%、'controls'は12.05%、'crossorigin'は0.45%、'currenttime'は0.01%、'disablepictureinpicture'は0.01%、'disableremoteplayback'は0.01%、'duration'は0.05%、'height'は7.33%、'intrinsicsize'は0%、'loop'は14.57%、'muted'は13.92%、'playsinline'は6.49%、'poster'は8.98%、'preload'は11.62%、'src'は3.67%、'use-credentials'は0%、and 'width'は9%。そしてモバイルで'autoplay'は12.38%、'buffered'は0%、'controls'は13.88%、'crossorigin'は0.16%、'currenttime'は0.01%、disablepictureinpicture'は0.01%、'disableremoteplayback'は0.02%、'duration'は0.09%、'height'は6.54%、 intrinsicsize'は0%、'loop'は14.44%、'muted'は13.55%、'playsinline'は6.15%、'poster'は9.29%、'preload'は10.34%、'src'は4.13%、'use-credentials'は0%、'width'は9.03%である。</div>
  <figcaption id="fig22-caption">図22. HTML動画タグ属性の使用法。</figcaption>
</figure>

もっとも一般的な属性は`autoplay`、`muted`、`loop`で、続いて`preload`タグ、そして`width`と`height`です。`loop`属性の使用は背景の動画や、動画をアニメーションGIFの代わりに、使用する場合に使用されるのでウェブサイトのホームページでよく使用されても不思議ではありません。

ほとんどの属性はデスクトップとモバイルで似たような使い方をしていますが、いくつかの属性には大きな違いがあります。モバイルとデスクトップの間でもっとも大きな違いがあるのは`width`と`height`の2つの属性で、モバイルではこれらの属性を使用しているサイトが4％少なくなっています。興味深いことに、モバイルでは`poster`属性（再生前に動画ウィンドウの上に画像を配置する）が少しだけ増加しています。

アクセシビリティの観点からは、`<track>`タグはキャプションや字幕を追加するために使用できます。HTTP Archiveには`<track>`タグの使用頻度に関するデータがありますが、調査したところ、データセットのほとんどのインスタンスはコメントアウトされているか、`404`エラーを返すアセットを指していました。多くのサイトでは、JavaScriptやHTMLのボイラプレートを使用しており、trackが使用されていない場合でもtrackを削除しないようになっているようです。

### 動画プレイヤー

より高度な再生（および動画ストリームの再生）を行うには、HTML5ネイティブ動画プレイヤーは動作しません。再生に使用する一般的な動画ライブラリがいくつかあります。

<figure>
  <a href="/static/images/2019/media/fig23_top_javascript_video_players.png">
    <img src="/static/images/2019/media/fig23_top_javascript_video_players.png" alt="図23. トップの JavaScript 動画プレイヤー" aria-labelledby="fig23-caption" aria-describedby="fig23-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=215677194&format=interactive">
  </a>
  <div id="fig23-description" class="visually-hidden">3,365のデスクトップサイト(3,400のモバイルサイト)、52,375のデスクトップサイト(40,925のモバイルサイト)、110,280のデスクトップサイト(96,945のモバイルサイト)、325のデスクトップサイト(275のモバイルサイト)の「shaka」、377,990のデスクトップサイト(391,330のモバイルサイト)の「video」を示す棒グラフです。</div>
  <figcaption id="fig23-caption">図23. トップの JavaScript 動画プレイヤー</figcaption>
</figure>

もっとも人気があるのは（圧倒的に）video.jsで、JWPLayerとHLS.jsがそれに続いています。著者は、「video.js」という名前のファイルが、同じ動画再生ライブラリではない可能性があることを認めています。

## 結論
ほぼすべてのウェブページではユーザー体験を向上させ、意味を生み出すために、画像や動画をある程度使用しています。これらのメディアファイルは大量のリソースを利用し、ウェブサイトのトン数の大部分を占めています（そして、それらがなくなることはありません！）代替フォーマット、遅延ロード、レスポンシブ画像、画像の最適化を利用することは、ウェブ上のメディアのサイズを小さくするために長い道のりを行くことができます。
