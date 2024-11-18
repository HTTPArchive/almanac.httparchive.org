---
##See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: フォント
description: 2022年版Web Almanacのフォントの章では、フォントの読み込み先、フォントフォーマット、フォントの読み込み性能、可変フォント、カラーフォントについて説明しています。
hero_alt: Hero image of Web Almanac characters on an assembly line preparing various F letters in various styles and shapes.
authors: [bramstein]
reviewers: [alexnj, jmsole, RoelN, svgeesus]
analysts: [bramstein, konfirmed]
editors: [shantsis]
translators: [ksakae1216]
bramstein_bio: Bram Steinは開発者であり、プロダクトマネージャーです。タイポグラフィをこよなく愛し、デザインとテクノロジーの交差点で働くことに喜びを感じている。A Book Apartによる<a hreflang="en" href="https://abookapart.com/products/webfont-handbook">Webフォントハンドブック</a>と<a hreflang="en" href="https://fontfaceobserver.com">FontFace Observer</a>ライブラリの著者である。また、世界中のカンファレンスでタイポグラフィやウェブパフォーマンスについて講演している。
results: https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/
featured_quote: 私たちは、「WOFF2だけを使って、他のことは忘れてください」と宣言する時期だと考えています。これにより、あなたのCSSとワークフローが大幅に簡素化され、WOFF2はあらゆる場所でサポートされるようになりました。
featured_stat_1: 29%
featured_stat_label_1: `font-display&colon;swap`を使用しているサイト。
featured_stat_2: 18%
featured_stat_label_2: アイコンウェブフォントを使用しているサイト
featured_stat_3: 97%
featured_stat_label_3: Googleが提供するバリアブルフォントが使用されています。
---

## 序章

ウェブフォントの黎明期から、私たちは長い道のりを歩んできました。ほんの一握りのウェブセーフフォントから、何十万ものウェブフォントというタイポグラフィの爆発的な普及につながったのです。その技術や使いやすさは、ほとんど認識できないほどです。いくつかのフォントフォーマットを使った手の込んだ「bullet-proof」フォント読み込み戦略から、単にWOFF2ファイルを含むだけというものまで。

{{ figure_markup(
  image="webfont-usage.png",
  caption="ウェブフォント使用。",
  description="2010年（使用率0％）から2022年（80％以上）まで、Webフォントのリクエスト数の割合を経年変化で示した散布図です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1021821560&format=interactive",
  sheets_gid="1517999851",
  sql_file="font_usage_over_time.sql"
  )
}}

Webフォントのこの進歩が示すもの。ウェブフォントの利用率は伸び続けています。[2020年のフォント](../2020/fonts)の章では、デスクトップサイト全体の82%がWebフォントを使用していました。それから2年で、使用率は約84%に増えています。モバイルでは若干数値が下がりますが、同様の伸びを表しています。

私たちは大きな進歩を遂げましたが、まだそこまでには至っていません。世界の人口の大部分はWebフォントを使用できません。なぜなら、彼らの文字システムは、（小さな）Webフォントとして提供するには大きすぎるか、複雑すぎるかのどちらかだからです。幸い、<a hreflang="en" href="https://www.w3.org/Fonts/WG/">W3Cフォント・ワーキンググループ</a> は、<a hreflang="en" href="https://www.w3.org/TR/IFT/">インクリメンタルフォントトランスファー</a> ウェブ標準に熱心に取り組んでおり、うまくいけばこれを解決できるかもしれません。

2021年はFontsの章がありませんでしたが、今年はその分を取り戻せたらと思っています。今年は、フォントファイルの中身や、CSSでフォントがどのように使われているかを詳しく調べることで、少し違った角度から見てみました。もちろん、サービス、`font-display`、リソースヒントの使い方といった「基本」にも立ち返りました。最後に、 _可変フォント_ と _カラーフォント_ に焦点を当てた2つの特別なセクションで、この章を締めくくります。

## パフォーマンス

{{ figure_markup(
  image="popular-web-font-mime-types.png",
  caption="人気のウェブフォントのMIMEタイプ。",
  description="列表では、`woff2`がデスクトップで78%、モバイルでは75%、`woff`がそれぞれ10%と12%、`octet-stream`が6%と7%、`ttf`が3%と4%、`sfnt`が1%と1%、`otf`が0%と0%、最後に `opentype` がデスクトップとモバイルで0%と使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1637212263&format=interactive",
  sheets_gid="510414604",
  sql_file="font_format_usage.sql"
  )
}}

意外なことに、提供されるフォントの種類にはあまり変化がありません。全フォントファイルの約75%は<a hreflang="en" href="https://www.w3.org/TR/WOFF2/">WOFF2</a>として、約12%はWOFFとして、残りはオクテットストリームまたは</a>として提供されています。
TrueType Fontと、それからランダムなMIMEタイプの一群です。これは、[2020年のフォントの章の結果](../2020/fonts#フォーマットとMIMEタイプ)とかなり似ています。幸いなことに、SVGとEOTのフォント使用はほとんど完全になくなりました。

2019年、2020年に記載した通りです。WOFF2は最高の圧縮を提供し、好ましいフォーマットであるべきです。実際、宣言する時期でもあると思われます。

> WOFF2だけを使い、他のことは忘れてください。

これにより、CSSとワークフローが大幅に簡素化され、またフォントのダウンロードが誤って二重になったり、不正確になったりするのを防ぐことができます。WOFF2は現在、<a hreflang="en" href="https://caniuse.com/woff2">あらゆる場所でサポートされています</a>。ですから、よほど古いブラウザをサポートする必要がない限り、WOFF2を使ってください。そうできない場合は、古いブラウザにウェブフォントを一切提供しないことを検討してください。これは、しっかりとしたフォールバック戦略をとっていれば問題ありません。古いブラウザの訪問者は、単にあなたのフォールバックフォントを見ることができます。

### ホスティング

人々はどこでフォントを入手しているのでしょうか？セルフホストか、ウェブフォントサービスを使うか？両方ですか？数字を見てみましょう。

{{ figure_markup(
  image="hosting-type.png",
  caption="ホスティングタイプ。",
  description="デスクトップページの67%、モバイルページの67%でセルフホスト（非排他的）フォントが使用され、セルフホスト（排他的）はそれぞれ18%、20%、サービス（非排他的）は68%、65%、最後にサービス（排他的）はデスクトップページの19%、モバイルページの18%で使用されているという棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1751970122&format=interactive",
  sheets_gid="1791297167",
  sql_file="font_usage_by_service.sql"
  )
}}

一般的には、67％がセルフホスティングとサービスを利用しています。セルフホスティングのみを利用しているのは19%に過ぎません。<a hreflang="ja" href="https://developer.chrome.com/ja/blog/http-cache-partitioning/">キャッシュ パーティショニング</a>の導入後、ホスティング サービスを使用することによるパフォーマンスの利点はもはやないこと、および <a hreflang="en" href="https://www.theregister.com/2022/01/31/website_fine_google_fonts_gdpr/">欧州の裁判所は、欧州に拠点を置く企業がGoogleフォント</a> を使うことに徐々に強い疑念を持つようになっていることの理由からこの数字は今後数年間で上昇することが見込まれています。

このデータをさらにサービス別に分けることができます。驚くことではありませんが、<a hreflang="en" href="https://fonts.google.com/">Googleフォント</a>はもっとも多くのウェブフォントサービスで、すべてのウェブページの65%近くが使用しています。無料に勝るものはありませんね。

{{ figure_markup(
  image="webfont-usage-by-service.png",
  caption="サービス別のウェブフォント利用状況。",
  description="2019年は59.4%、2020年で63.9%、2021年は65.2%、2022年で64.5%のページでGoogleフォントが使用されていることを示すコラムチャートです。フォントAwesomeが3.7%、5.4%、6.3%、6.9%、Adobeフォントで3.4%、3.6%、3.9%、4.2%、Fonts.comは0.4%、0.3%、0.2%、そして最後にCloud.Typographyが2019年に0.3%、2020年で0.2%、2021年は0.2%、そして2022年に0.2%となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1049143598&format=interactive",
  sheets_gid="1791297167",
  sql_file="font_usage_by_service.sql"
  )
}}

次点は、<a hreflang="en" href="https://fontawesome.com/">フォントAwesome</a>というウェブサービスで、7％近くのサイトで使われているそうです。たった1つのフォントファミリーで、この結果はすごいことです。3位は<a hreflang="en" href="https://fonts.adobe.com/">Adobeフォント</a>で、4.2%のサイトで使用されています。また、<a hreflang="en" href="https://www.fonts.com/">Fonts.com</a> と <a hreflang="en" href="https://www.typography.com/webfonts">Cloud.Typography</a> は、どちらも0.2%のサイトで使用されているサービスです。

例年を振り返ってみると、今年ははじめてGoogleフォントの使用率が減少していることがわかります。これが前述のキャッシュパーティションによるものなのか、GDPRによるものなのか、それともまったく別のものなのか、何とも言えません。減少幅はわずかなので、この傾向が来年も続くかどうかが注目されます。

一方、フォントAwesomeとAdobeフォントの両サービスは、ここ数年で大きく成長しました。フォントAwesomeサービスの利用率は2019年から2022年にかけて86％成長し、Adobeフォントの利用率は同期間に24％成長した。

なお、サービスデータは、2020年および2019年のフォントの章と比較して、測定方法が異なります。それらの章では、サービスへのリクエスト数を調べたのに対し、2022年のデータでは、サービスを利用しているページを調べています。したがって、2022年のデータは、サイトに読み込まれたフォントの数に影響されないため、より正確なものとなっています。たとえば、2020年の章で指摘したGoogle Fontsの使用率の低下は、Google Fontsが _可変フォント_ に切り替えたことにより、サービスへのリクエスト数が大幅に減少したことがもっとも大きな原因でした。

### ファイルサイズ

圧縮は、ダウンロードする必要のあるデータ量を減らすのに最適な方法ですが、それには限界があります。フォントのファイルサイズに影響を与えるものをよりよく理解するために、全フォントのフォントサイズの中央値を見てみましょう。

{{ figure_markup(
  image="font-sizes.png",
  caption="フォントサイズ",
  description="10パーセンタイルではデスクトップで10KB、モバイルで8KBのフォントが使われ、25パーセンタイルではそれぞれ15KBと13KB、50パーセンタイルでは20KBと20KB、75パーセンタイルでは44KBと43KB、最後に90パーセンタイルではデスクトップ、モバイルともに75KBとなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2083466743&format=interactive",
  sheets_gid="1323521462",
  sql_file="font_size_quantiles.sql"
  )
}}

フォントサイズの中央値は約20キロバイトです。これは結構なことです。しかし、先に見たように、フォントサービスは全フォントリクエストの70%近くを占めています。GoogleフォントやAdobeフォントのようなサービスには、フォントをできるだけ最適化するためのチームがあり、フォントサイズの中央値は、これらのサービスによって大きく歪められている可能性があります。

{{ figure_markup(
  image="self-hosted-font-sizes.png",
  caption="セルフホスティングのフォントサイズ。",
  description="さまざまなパーセンタイルでのセルフホスティングフォントのサイズを示すコラムチャート。10パーセンタイルでは、セルフホスティングフォントはデスクトップで7KB、モバイルで7KB、25パーセンタイルでは、それぞれ17KB、17KB、50パーセンタイルではどちらも37KB、75パーセンタイルではどちらも75KB、最後に90パーセンタイルではデスクトップで96KB、モバイルで91KBとなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=15369234&format=interactive",
  sheets_gid="1359064325",
  sql_file="font_size_quantiles_without_services.sql"
  )
}}

セルフホスティングのフォントサイズを見ると、まったく違うことがわかります。フォントサイズの中央値は約2倍の約40キロバイトに達しています。これはいったいどういうことなのでしょうか。人気のあるウェブフォントのMIMEタイプのグラフをもう一度見て、ウェブフォントサービスからのリクエストをすべて削除してみると、何が起こっているのかがわかるかもしれませんね。

セルフホストフォントを使用している多くのサイトがWOFF2ではなく、いまだにWOFFを使用しています。これらのサイトのフォントが、WOFF2が導入されてから一度も更新されていないのか、あるいはWOFF2について知っている開発者が少ないのか、はっきりしません。いずれにせよ、簡単にできる最適化であり、多くのサイトが恩恵を受ける可能性があります。

{{ figure_markup(
  image="popular-web-font-mimetypes-self-hosted.png",
  caption="人気のウェブフォントのMIMEタイプ（セルフホスティング）。",
  description="カラムチャートでは、woff2がデスクトップの45%、モバイルのセルフホストフォントの46%、woffがそれぞれ26%、26%、octet-streamは15%、15%、そして最後にttfがデスクトップの6%、モバイルのセルフホストフォントの6%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=291490668&format=interactive",
  sheets_gid="259914355",
  sql_file="font_format_usage_without_services.sql"
  )
}}

しかし、サービスとセルフホスティングのフォントサイズの中央値の差は、WOFF2の使用率の低さで説明するには大きすぎる。WOFF2は優れた圧縮機能を備えていますが、圧縮だけではフォントサイズの中央値の大きな差は説明できません。ウェブフォントサービスは、セルフホストフォントでは十分に行われていない、他の種類の最適化を実行しているはずです。その答えを見つけるには、フォントの内部を見る必要があります。

### OpenTypeのテーブルサイズ

典型的なフォントは、基本的に <a hreflang="en" href="https://simoncozens.github.io/fonts-and-layout/opentype.html">小さなリレーショナルデータベース</a> であり、それぞれのテーブルにはグリフの形状、グリフの関係、メタデータなどのデータが格納されています。たとえば、フォントの文字であるグリフを構成するベクターベジエ曲線を格納するテーブルがあります。また、グリフ同士を関連付けるテーブルもあり、カーニングや合字の関係（有名な _リガチャ_ 合字のように、この2つのグリフを一緒に使うときはこのグリフと入れ替える）などが格納されています。

あるテーブルがファイルサイズ全体に与える影響を測定する合理的な方法は、そのテーブルの中央値を、そのテーブルを含むフォントの数に乗じることです。

<figure>
  <table>
    <thead>
      <tr>
        <th>OpenTypeテーブル</th>
        <th>インパクト</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>glyf</code> (ベクター形状)</code></td>
        <td class="numeric">79.6%</td>
      </tr>
      <tr>
        <td><code>CFF</code> (ベクター形状)</td>
        <td class="numeric">4.9%</td>
      </tr>
      <tr>
        <td><code>GPOS</code> (位置づけ関係)</td>
        <td class="numeric">4.7%</td>
      </tr>
      <tr>
        <td><code>hmtx</code> (水平配置量)</td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td><code>post</code> (メタデータ)</td>
        <td class="numeric">2.2%</td>
        </tr>
      <tr>
        <td><code>name</code> (名前メタデータ)</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td><code>cmap</code> (文字コードとグリフを対応させる)</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td><code>fpgm</code> (フォントプログラム)</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td><code>kern</code> (カーニングデータ)</td>
        <td class="numeric">0.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="影響度（ファイルサイズの中央値×全体に占めるリクエスト数の割合）。",
      sheets_gid="1853636944",
      sql_file="font_size_quantiles_by_opentype_table.sql",
    ) }}
  </figcaption>
</figure>

もっとも高い影響力を持つテーブルのトップ10は、`glyf`、`CFF`、`GPOS`、`hmtx` のテーブルから始まります。これらには、すべてのグリフのアウトラインを構成するベジエ曲線（`glyf`と`CFF`）、OpenTypeポジショニング機能（`GPOS`）、水平メトリクス（`hmtx`）のデータが含まれています。これらの表はフォントのグリフ数に直接関係しているので、これは素晴らしいことです。不要なグリフを削除してフォントのグリフ数を減らせば、そのファイルサイズを劇的に減らすことができます。

<a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-subsetting.html">何が必要、不要なのか</a>を見極めるのは難しいところです。誤ってグリフを削除してしまったり、テキストを正しくレンダリングするために必要なOpenType機能を壊してしまったりする可能性があります。たとえば <a hreflang="en" href="https://fonttools.readthedocs.io/en/latest/subset/index.html">フォントツール</a> を使って手動でサブセットする代わりに、<a hreflang="en" href="https://github.com/Munter/subfont">subfont</a> や <a hreflang="en" href="https://github.com/zachleat/glyphhanger">glyphhanger</a> などのツールを使って、サイトのコンテンツに基づいて「完璧な」サブセットを自動的に作成できます。ただし、フォントのライセンスがそのような変更を許可しているかどうかには注意してください。

興味深いのは、`name`テーブルと`post`テーブルがもっとも多い10位に入っていることです。この2つのテーブルは主にデスクトップフォントには重要だが、ウェブフォントには必要ないメタデータを含んでいます。これは多くのウェブフォントが、名前テーブルのエントリ、`post`テーブルのグリフ名、非Unicodeの`cmap`エントリなど、影響を与えずに削除できるメタデータを含んでいることを示しています。私たちは、ファウンドリやウェブ開発者がウェブ フォントの不要なバイトをすべて削除するために使用できる、普遍的な推奨事項（または <a hreflang="en" href="https://pmt.sourceforge.io/pngcrush/">pngcrush</a> に似たツール）をぜひ見たいと思っています。

### アウトラインフォーマット

OpenTypeのサイズテーブルには、ベクターグリフのアウトラインデータとして2つの項目があることにお気づきでしょうか。`glyf` と `CFF` です。OpenTypeには、ベクターのアウトラインを保存するための4つの競合する方法があります。TrueType (`glyf`)、コンパクトフォントフォーマット（`CFF`）、コンパクトフォントフォーマット2（`CFF2`）、スケーラブルベクターグラフィックス（`SVG`; 古いSVGフォントフォーマットと混同しないように）。また、画像ベースのフォーマットも3つあります。そのうちの2つについては、カラーフォントのセクションで説明します。

OpenTypeの仕様は、慈善的に「妥協の産物」と呼べるようなものです。コンセンサスが得られなかったため、もっとも同じことをする競合するいくつかのアプローチが仕様に加えられました。この経緯に興味がある方は、David Lemon氏の<a hreflang="en" href="https://www.pastemagazine.com/design/adobe/the-font-wars/">フォント戦争</a>が素晴らしい読み物です。競合するアプローチのこのパターンは、可変フォントとカラーフォントのセクションで何度も繰り返されます（ただし、アクターは異なります）。結局のところ、ベクター アウトラインを保存する複数の方法があることはもっともですが、タイプ デザイナーと実装に大きな追加負担をかけることになり、言うまでもなく、悪用のための攻撃対象領域が増えます。

タイプデザイナーは好みのアウトライン形式を選べる。アウトラインフォーマットの分布を見ると、タイプデザイナーが何を選択しているかがよくわかる。圧倒的多数（91％）のフォントが`glyf`のアウトライン形式を使用し、9％が`CFF`のアウトライン形式を使用しています。`SVG`カラーフォントの使用もありますが、1％未満です（写真には写っていません）。

{{ figure_markup(
  image="outline-formats.png",
  caption="アウトラインのフォーマット。",
  description="モバイルフォントのうち、TrueType（`glyf`）が90.8％、`CFF`が9.2％という円グラフがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=934239411&format=interactive",
  sheets_gid="1181700309",
  sql_file="outline_formats.sql"
  )
}}

OpenTypeの仕様では、<a hreflang="en" href="https://docs.microsoft.com/en-us/typography/opentype/otspec191alpha/glyphformatcomparison_delta">`glyf`と`CFF`の違い</a>を挙げています。

- `glyf`フォーマットは2次ベジエ曲線を使用し、`CFF`（および`CFF2`）は3次ベジエ曲線を使用します。このことは、一部のタイプデザイナーにとっては重要ですが、フォントのユーザーにとっては重要ではありません。
- `glyf` フォーマットはヒンティングをよりコントロールし、小さな調整を行うことができます。一方、`CFF`はテキストラスターライザーにヒント機能をもっとも多く組み込んでいます。
- `CFF`フォーマットは、より効率的なフォーマットであり、フォントサイズを小さくすることができると主張しています。

最後の主張がおもしろいですね。`CFF`は小さいのか？

{{ figure_markup(
  image="font-outline-sizes.png",
  caption="フォントのアウトラインサイズ。",
  description="一般的なパーセンタイルにおけるフォントのアウトラインサイズを示す列表。10パーセンタイルでは`CFF`が1KB、glyfが10KB、25パーセンタイルではそれぞれ14と21、50パーセンタイルでは29と49、75パーセンタイルでは54と109、そして最後に90パーセンタイルでは`CFF`が124KB、glyfが136KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=672500092&format=interactive",
  sheets_gid="1853636944",
  sql_file="font_size_quantiles_by_opentype_table.sql"
  )
}}

平均すると、確かに`CFF`の方がテーブルサイズは小さくなります。しかし、現実はもっと微妙で、圧縮を考慮していないため、テーブルサイズはフォントが解凍された後に記録されます。

<a hreflang="en" href="https://www.w3.org/TR/2016/NOTE-WOFF20ER-20160315/#brotli-adobe-cff">WOFF2評価レポート</a>に見られるように、`glyf`圧縮の中央値は66％、`CFF`圧縮の中央値は50％です（WOFF2による非圧縮から圧縮までの場合）。

{{ figure_markup(
  image="compressed-font-outline-sizes.png",
  caption="フォントのアウトラインサイズを圧縮しました。",
  description="25パーセンタイルでは`CFF`とglyfのフォントサイズはともに6KB、50パーセンタイルでは`CFF`が15KB、glyfが17KBと乖離し始め、75パーセンタイルではそれぞれ32KBと39KB、90パーセンタイルではCFFが86KB、glyfは56KBしかないことがカラムチャートからわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1880460638&format=interactive",
  sheets_gid="1853636944",
  sql_file="font_size_quantiles_by_opentype_table.sql"
  )
}}

圧縮を適用すると、まったく異なる画像になります。ファイルサイズの中央値の違いはごくわずかで、`glyf`アウトラインを使用すると、大きなフォントがより小さくなります。

つまり、最初は`CFF`の方が小さくても、`glyf`よりも圧縮量が少ないので、最終的にはすべて同じになるのです。実際、大きなファイルでは、`glyf`形式を使用した方がサイズは小さくなるようです。

### リソースのヒント

リソースヒントとは、ブラウザが通常より早くリソースをロードまたはレンダリングするための特別な指示です。ブラウザは通常、ページでフォントが使用されていることが分かっている場合にのみ、ウェブフォントを読み込みます。それを知るためには、HTMLとCSSの両方を解析する必要があります。しかし、ウェブ開発者としてフォントを使用されることが分かっている場合は、リソースヒントを使用して、ブラウザにフォントをもっと早く読み込むように指示できます。

ウェブフォントに関連するリソースヒントには、`dns-prefetch`、`preconnect`、`preload`といういくつかの種類があり、影響の小さいものから高いものへと順番に並んでいます。理想的にはもっとも重要なフォントをプリロードしたいところですが、それらがホストされている場所によっては、必ずしもそれが可能とは限りません。

{{ figure_markup(
  image="fonts-resource-hints-usage.png",
  caption="フォントのリソースヒントの使い方。",
  description="カラムチャートでは、`dns-prefetch`がデスクトップページの30%、モバイルページの32%のフォントで使用され、`preload`がそれぞれ21%、20%、`preconnect`は16%、そして最後に`prefetch`がデスクトップページの2%、モバイルページの2%のフォントで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1831399490&format=interactive",
  sheets_gid="592046045",
  sql_file="resource_hints_usage.sql"
  )
}}

2020年以降、`dns-prefetch`ヒントの使用には大きな変化はありませんが、`preload`（2020年の17%から2022年の20%）と`preconnect`（2020年の8%から2022年の15%）の使用はかなり大きく増えています。これはすごい！と思いました。

[2020年の章で述べた](../2020/fonts#リソースのヒント)ように、`preload`と`preconnect`リソースヒントはフォントの読み込み性能にもっとも大きな影響を与えるものです。ほとんどの場合、それは頭にリンク要素を追加するのと同じくらい簡単です。たとえば、Googleフォントを使っている場合。

```html
<link rel="preconnect" href="https://fonts.gstatic.com">
```

フォントをセルフホストしている場合は、さらに進んで、もっとも重要なフォント（たとえば主要なテキストフォント）を事前に読み込むためのヒントをブラウザに提供できます。そうすれば、ブラウザは早期にフォントを読み込むことができ、テキストのレンダリング開始時に利用できる可能性が高くなります。

### `font-display`

長年にわたり、もっとも多くのブラウザは、ウェブフォントが読み込まれるまでテキストを描画しませんでした。低速の接続では、テキストコンテンツがすでに読み込まれているにもかかわらず、数秒間、見えないテキストを表示することがよくありました。この動作は、テキストのレンダリングをブロックするため、 _block_ と呼ばれています。他のブラウザでは、フォールバックフォントをすぐに表示し、ウェブフォントが読み込まれたとき入れ替えるようになっていました。フォールバックフォントをウェブフォントに置き換えることを、 _swap_ と呼びます。

ウェブ開発者がフォントの読み込みをよりコントロールできるようにするため、ウェブフォントの読み込み中にブラウザがどのように振る舞うべきかを伝える `font-display` ディスクリプターが導入されました。これは、フォントの読み込み中に何をすべきかについて、4つの異なる値を定義しています。これらの値は、 _block_ と _swap_ の異なる組み合わせで実装されています。

- `swap`: のブロックは非常に短い期間で、常に入れ替わります。
- `block`: を短期間でブロックし、常に入れ替える。
- `fallback`: ブロックはごく短時間で、スワップは短時間で行う。
- `optional`: をブロックし、スワップ期間はありません。

また、`auto`もあり、これはブラウザに判断を委ねるもので、最近のブラウザはすべて`block`をデフォルト値としています。

{{ figure_markup(
  image="usage-of-font-display.png",
  caption="`font-display`の使用法。",
  description="フォント表示のカラムチャートでは、`swap`がデスクトップの32%、モバイルの29%、`block`がそれぞれ16%、17%、`auto`は9%、8%、`fallback`が2%、2%、最後に`optional`がデスクトップ、モバイルともに0%のページで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1648924039&format=interactive",
  sheets_gid="1599822681",
  sql_file="font_display_usage.sql"
  )
}}

`font-display: swap` の使用は、印象的な30% にまで成長しました（[2020 年の 11%](../2020/fonts#ファーストペイントへの挑戦) から）。この増加のかなりの部分は、<a hreflang="en" href="https://www.youtube.com/watch?v=YJGCZCaIZkQ&t=1880s">Googleフォントが2019年にswapを推奨値にしたこと</a>を起因している可能性がもっとも高いです。また、`block`値が`auto`を抜いて、2番目に多く使われている値になっているのも興味深い。開発者がなぜ意図的にサイトのパフォーマンスを低下させるのかはわかりませんが、少し心配ではあるものの、興味深い展開です。

私たちの推測では、開発者やその顧客は、フォールバックフォントのフラッシュを見るのを本当に嫌がると思います。`font-display: block`を使うことは、その問題を簡単に「解決」できます。しかし、もっと良い解決策があるのです。近い将来、CSSフォントメトリックオーバーライドを使って、フォールバックフォントを微調整し、ウェブフォントのメトリックに近づけることができるようになります。これにより、フォールバックフォントをウェブフォントと入れ替えたときに起こる、テキストの乱反射を抑えることができます。

CSSの `ascent-override`, `descent-override`, `line-gap-override`, `size-adjust` 記述子は `@font-face` ルールに入り、任意のフォントのメトリクスをオーバーライドするために使用できます。これらの記述子を `local()` と一緒に使うことで、Webフォントとほぼ一致する[カスタマイズされたフォールバック](https://developer.mozilla.org/ja/docs/Web/CSS/@font-face/ascent-override#%E4%BB%A3%E6%9B%BF%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E5%AF%B8%E6%B3%95%E3%82%92%E4%B8%8A%E6%9B%B8%E3%81%8D)フォントを作成できます。<a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">`local()`</a>の良い使い方がやっとできました。

{{ figure_markup(
  image="css-font-metrics-override-usage.png",
  caption="CSSフォントメトリクスのオーバーライド使用。",
  description="カラムチャートでは、`ascent-override`がデスクトップページの0.11%、モバイルページの0.20%、`descent-override`がそれぞれ0.07%、0.13%、`line-gap-override`は0.07%、0.13%、最後に `size-adjust` はデスクトップページの0.05%、モバイルページの0.13% に対して使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2058878625&format=interactive",
  sheets_gid="241586017",
  sql_file="font_metric_override_usage.sql"
  )
}}

この `@font-face` 記述子は非常に新しいものですが、すでにいくつかの使用例があります。これらをさらに便利にするため、開発者は2つのことを必要としています。

1. すべてのブラウザとプラットフォームで利用可能な、一貫したフォールバックフォントのセットです。可変フォントにすることも可能です。可能性を想像してください。
2. フォントのサイズやメトリクスをいじって、自動的にマッチングさせるツール。これを手作業で行うのは非常に手間がかかるので、ツールは必須です。これはウェブフォントの代わりとしてではなく、単にウェブフォントが読み込まれている間の一時的なフォールバックとして（あるいはフォントが読み込まれなかったり、ブラウザが非常に古かったりした場合の代用品として）意図されています。

<a hreflang="en" href="https://meowni.ca/font-style-matcher/">Font Style Matcher</a>や <a hreflang="en" href="https://www.industrialempathy.com/perfect-ish-font-fallback/">Perfect-ish Font Fallback</a>などのツールで徐々に実現しつつありますが、残念ながら、代替フォントはまだ非常にプラットフォームに依存します。

## フォントの使用方法

性能も重要ですが、ウェブ上でフォントがどのように使われているかということも興味深いです。たとえば、もっとも普及しているフォントやファウンドリは何か？人々はOpenTypeの機能を使っているのでしょうか？データを見てみましょう。

### ファミリー＆ファウンドリー

<figure>
  <table>
    <thead>
      <tr>
        <th>ファミリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Roboto</td>
        <td class="numeric">14.5%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Font Awesome</td>
        <td class="numeric">10.5%</td>
        <td class="numeric">12.8%</td>
      </tr>
      <tr>
        <td>Noto Sans</td>
        <td class="numeric">10.1%</td>
        <td class="numeric">8.0%</td>
      </tr>
      <tr>
        <td>Open Sans</td>
        <td class="numeric">5.9%</td>
        <td class="numeric">7.7%</td>
      </tr>
      <tr>
        <td>Lato</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Poppins</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td>Montserrat</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Source Sans Pro</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>icomoon</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Proxima Nova</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Raleway</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Noto Serif</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Ubuntu</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>NanumGothic</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Oswald</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>PT Sans</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>GLYPHICONS Halflings</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Rubik</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>eicons</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>revicons</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="もっとも使われているフォント。",
      sheets_gid="1543752771",
      sql_file="popular_font_families_by_vendor.sql",
    ) }}
  </figcaption>
</figure>

Googleフォントがウェブフォントサービスに多大な影響を与えている今、ウェブでもっとも使われているフォントがRobotoであることは驚くにはあたらない。Robotoは、GoogleがAndroidオペレーティングシステムのシステムフォントとして作成したものです。このことは、Robotoのモバイルでの使用がデスクトップサイトと比較して大きく異なっていることの説明にもなります。Androidでは、Google Fontsはウェブフォントとしてダウンロードするのではなく、システムにインストールされたバージョンを使用します。

2位はFont Awesomeで、実質的に1つのフォントファミリーであるにもかかわらず、素晴らしい成果をあげています。フォントAwesomeとIcomoon、Glyphicons、eicons、reviconsを合わせると、ウェブサイトで使用されているウェブフォント全体の約18％を占めています。アイコンフォントは、<a hreflang="en" href="https://fontawesome.com/docs/web/dig-deeper/accessibility">アクセシビリティの観点</a>から見て問題があるので、これがこれほど普及しているのを見ると心配になります。

{{ figure_markup(
  content="18%",
  caption="アイコンウェブフォントを使用しているサイト",
  classes="big-number",
  sheets_gid="1543752771",
  sql_file="popular_font_families_by_vendor.sql",
) }}

また、使用率1％のProxima Novaも特筆すべき点です。これは、トップ20の中で唯一の商用、非アイコン、フォントです。これは<a hreflang="en" href="https://www.marksimonson.com/">Mark Simonson Studio</a>の驚くべき成果です。

もう1つの興味深い事実は、上位のファミリーの大部分がオープンソースであるということです。これは、Google Fontsがこれらのフォントを委託しているか、既存のオープンソースフォントをライブラリに含めているためと考えられます。

<figure>
  <table>
    <thead>
      <tr>
        <td>ベンダー</td>
        <td>デスクトップ</td>
        <td>モバイル</td>
      </tr>
    </thead>
    <tbody>
    <tr>
      <td>Google</td>
      <td class="numeric">30.5%</td>
      <td class="numeric">17.7%</td>
    </tr>
    <tr>
      <td>フォントAwesome</td>
      <td class="numeric">12.3%</td>
      <td class="numeric">15.6%</td>
    </tr>
    <tr>
      <td>Łukasz Dziedzic</td>
      <td class="numeric">3.6%</td>
      <td class="numeric">4.3%</td>
    </tr>
    <tr>
      <td>Indian Type Foundry</td>
      <td class="numeric">3.0%</td>
      <td class="numeric">4.1%</td>
    </tr>
    <tr>
      <td>Julieta Ulanovsky</td>
      <td class="numeric">2.5%</td>
      <td class="numeric">3.1%</td>
    </tr>
    <tr>
      <td>Adobe</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">1.9%</td>
    </tr>
    <tr>
      <td>Ascender Corporation</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">2.0%</td>
    </tr>
    <tr>
      <td>Icomoon</td>
      <td class="numeric">1.3%</td>
      <td class="numeric">1.5%</td>
    </tr>
    <tr>
      <td>Mark Simonson Studio</td>
      <td class="numeric">1.3%</td>
      <td class="numeric">1.3%</td>
    </tr>
    <tr>
      <td>ParaType Inc.</td>
      <td class="numeric">1.0%</td>
      <td class="numeric">1.4%</td>
    </tr>
  </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="もっとも普及しているフォントファウンドリー。",
      sheets_gid="1543752771",
      sql_file="popular_font_families_by_vendor.sql",
    ) }}
  </figcaption>
</figure>

もっとも普及している活字鋳造所（場合によっては活字デザイナー）のリストも、同様に魅力的だ。Google、Adobe、Ascender（Monotype）のような大企業に加え、いくつかの小さな会社、さらには数人の個人がこれほど大きな影響を及ぼしているのを見るのは良いことです。

### OpenTypeの特徴

OpenTypeの機能は、しばしばフォントのスーパーパワーと呼ばれます。そしてもちろん、スーパーパワーを持つフォントは、認識されていないことが多い。OpenTypeの機能は、発見するのも使うのも難しいのです。幸い<a hreflang="en" href="https://wakamaifondue.com/">Wakamai Fondue</a>のようなウェブツールがあり、どの機能があり、何をし、どう使うかを明確に示してくれます。

{{ figure_markup(
  content="44%",
  caption="OpenTypeの機能を含むフォント。",
  classes="big-number",
  sheets_gid="183792112",
  sql_file="font_opentype_support.sql",
) }}

OpenTypeの機能には、文体を整えるためだけのものもあれば、テキストを正しくレンダリングするために必要なものもあります。この2つは、裁量的機能と必須機能として言及されているのをよく見かけるかもしれません。全フォントの44％近くが、裁量的または必須的なOpenType機能を備えています。つまり、あなたが使っているフォントもスーパーパワーを持っている可能性が高いのです。

裁量的機能は、たとえば、隣接する2つのグリフを合字に置き換えて読みやすさを向上させるために使用できます。また、OpenTypeの機能では、たとえばスワッシュを追加してグリフの代替バージョンを提供することが一般的です。

かなりの数のフォントが、<a hreflang="en" href="https://fonts.google.com/knowledge/introducing_type/introducing_alternate_glyphs">OpenTypeの裁量的機能</a>を備えています。もっとも一般的な裁量的機能は、驚くなかれ、合字です。これに続くのは、分数、比例数詞、表形式数詞、裏数字、序数詞など、数字を修正するあらゆる機能です。また、上付き文字もある程度一般的です。

{{ figure_markup(
  image="opentype-features-support-in-fonts.png",
  caption="フォントでOpenType機能をサポート。",
  description="カラムチャートでは、`kern`がデスクトップフォントの12.8%、モバイルフォントの12.4%、`liga`が10.0%、10.1%、`locl`は9.6%、9.7%、`frac`が8.1%、7.6%、`numr`で6.8%、5.8%、`dnom`が6.7%、5.8%、`pnum`は5.1%、4.7%、最後に`tnum`は5.0%、モバイルフォントでは4.5%が採用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1500912295&format=interactive",
  sheets_gid="83804141",
  sql_file="font_opentype_features_usage.sql"
  )
}}

OpenTypeの必須機能を見てみると、他のものよりも際立っているものが2つあります。 _カーニング_ と _ローカライズフォーム_ です。ローカライズフォームは、いくつかの言語で必要とされたり好まれたりする代替グリフを指定するために使用されます。これは、かなりの数のフォントが多言語をサポートしていることを意味し、国際化の進展の大きな証となります。

カーニングとは、2つのグリフの任意の組み合わせの間のスペースをわずかに増やしたり減らしたりして、それらの間のスペースをより均等に見えるようにすることです。カーニングはすべてのブラウザでデフォルト有効になっているので、フォントがカーニングをサポートしている限りは有効になっています。

{{ figure_markup(
  content="34%",
  caption="カーニングデータを含むフォント。",
  classes="big-number",
  sheets_gid="1953603748",
  sql_file="font_kerning.sql",
) }}

OpenTypeの機能として、または旧来の`kern`テーブルを使用してカーニングデータを保存しているウェブフォントは、全体の34%に過ぎません。ほとんどすべてのフォントは、正しく見えるようにカーニングを必要とするので、この数字は実際よりもずっと高くなると予想されます。ウェブフォントが普及し始めた頃、ブラウザのカーニングのサポートがあまり良くなかったため、初期のウェブフォントの多くは、スペースを節約するためにカーニングデータを含めなかったという説明があります。現在では、すべてのブラウザがカーニングをサポートしているため、フォントにカーニングデータが含まれていない理由はありません。

{{ figure_markup(
  image="openType-feature-usage-in-css.png",
  caption="CSSにおけるOpenTypeの機能利用。",
  description="カラムチャートでは、`kern`がデスクトップページの3.6%、モバイルページの3.2%、`liga`が2.2%、`palt`は0.4%、`pnum`で0.4%、`tnum`が0.4%、`lnum`は0.3%、そして最後に`calt`がデスクトップの0.1%、モバイルページの0.1%のページで使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1359153027&format=interactive",
  sheets_gid="1050025794",
  sql_file="font_feature_settings_tags_usage.sql"
  )
}}

さらに興味深いのは、カーニングは`font-feature-settings`プロパティでもっともよく使われる機能タグでもあるということです。3.2%近くのサイトがカーニングを手動で有効にしています（もっとひどい場合は無効にしています）。その必要はないのです。それはデフォルトで有効になっています。実際、`font-feature-settings`や、より高いレベルの<a hreflang="en" href="https://drafts.csswg.org/css-fonts/#font-kerning-prop">`font-kerningプロパティ`</a>でカーニング設定を変更する必要はありません。カーニングを無効にすると、サイトが速くなるわけではありませんが、タイプセットが貧弱になるのは事実です。

その他のもっともよく使われる機能は、実際にタイプデザイナーが使用するものとほぼ一致している：合字とさまざまな数字です。このリストに `palt`（プロポーショナルオルタネート）機能があるのは興味深いことで、これは主に日中韓フォントに使用されるものです（これ自体は、WOFF2圧縮でもウェブフォントとして使用するには通常大きすぎるため一般的ではありません）。 カーニングと同様に、`calt`機能（文脈上の代替文字）はデフォルトで有効になっており、明示的に有効または無効にする必要はありません。スタイルセット、文字バリエーション、スモールキャップ、スワッシュなど、使用頻度は低いものの、タイポグラフィを本当に向上させる可能性を秘めた便利なOpenType機能が他にもたくさんあります。私たちのオススメは、フォントを <a hreflang="en" href="https://wakamaifondue.com/">Wakamai Fondue</a>にドロップして、すべての隠れたスーパーパワーを探索することです。

{{ figure_markup(
  image="usage-of-font-feature-settings-vs-font-variant.png",
  caption="font-feature-settingsとfont-variantの使い分け。",
  description="カラムチャートでは、`font-feature-settings`がデスクトップページの13.3%、モバイルページの12.6%で使用されており、`font-variant`がデスクトップページの3.9%、モバイルページの3.5%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1087474243&format=interactive",
  sheets_gid="959516935",
  sql_file="font_feature_settings_vs_font_variant.sql"
  )
}}

全体的に、OpenType機能の使用率はウェブ上でかなり低いです。私たちは、もっとも多くの人がOpenTypeの機能を有効にするため高レベルの`font-variant`プロパティを使用していることを期待していましたが、その使用率は`font-feature-settings`よりもさらに低くなっています。`font-feature-settings`プロパティは12.6%のサイトで使用されており、`font-variant`プロパティは3.5%のサイトでしか使用されていません。

これは残念なことです。人々はフォントに存在するOpenTypeの機能を使用していないだけでなく、高レベルの`font-variant`プロパティの代わりに、エラーが起こりやすい`font-feature-settings`プロパティを主に使用しているのです。このプロパティは、<a hreflang="en" href="https://pixelambacht.nl/2022/boiled-down-fixing-variable-font-inheritance/">明示的にリストアップしなかったOpenType機能をデフォルト値に戻す</a>ので、`font-feature-settings`プロパティにはとくに注意する必要があります。

もっともよく使われる `font-feature-settings` の値はすべて `font-variant` と同等で、より読みやすく、副作用として他のOpenType機能を設定解除しないようになっています。これらのハイレベルな機能のサポートは過去にはそれほど良くなかったのですが、最近では<a hreflang="en" href="https://caniuse.com/?search=font-variant">よくサポートされています</a>。最近導入された `font-variant-alternates` プロパティを除いては。

{{ figure_markup(
  image="usage-of-css-font-variant-values.png",
  caption="CSS font-variant値の使用。",
  description="棒グラフでは、`font-variant: small-caps`がデスクトップページの1.5%、モバイルページの1.4%、`font-variant: tabular-nums`がそれぞれ1.0%、0.6%、`font-variant-numeric: tabular-nums`は0.8%、0.7%、 `font-variant-ligatures: discretionary-ligatures` で0. 4%と0.3%、`font-variant-ligatures: no-common-ligatures`が0.3%と0.3%、 `font-variant-caps: all-small-caps`が0.2%と0.2%, `font-variant-numeric: lining-nums`が0.2%と0.2%、最後に `font-variant-ligatures: common-ligatures` がデスクトップとモバイルページで0.1%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=682306512&format=interactive",
  sheets_gid="1231655846",
  sql_file="font_variant_values.sql",
  width=600,
  height=535
  )
}}

もっとも多くのページで使われている `font-variant` の値は `small-caps` で、1.4% でした。これは驚くべきことで、スモールキャップは0.7%のフォントでしかサポートされていないからです。つまり、`font-variant: small-caps` や `font-variant-caps` を使っているもっとも多くの人は、タイプデザイナーが作ったスモールキャップの代わりに、ブラウザが生成した偽のスモールキャップを受け取ってしまうということです。将来的には、<a hreflang="en" href="https://drafts.csswg.org/css-fonts-4/#font-synthesis-small-caps">font-synthesis-small-capsプロパティ</a>を使用することによって、偽のスモールキャップを回避できます。

その他の値は、フォントそのものが提供するものとほぼ一致しています。`font-variant`プロパティの使用率は低いですが、時間が経つにつれてこの数値が上がり、`font-feature-settings`の使用はカスタムまたは独自のOpenType機能での使用に追いやられることを期待、というより希望します。

### ライティングシステムと言語

どのようなフォントが作られ、使われているかを理解するために、フォントがどのような言語をサポートしているかを見てみるのもおもしろいのではないかと考えました。たとえば、ドイツ語やベトナム語、ウルドゥー語のフォントはたくさん作られているのでしょうか。残念ながら、この質問に答えるのは難しいのですが、多くの言語が同じ文字体系を共有しているからです。つまり、フォントは同じ文字セットを共有しているかもしれませんが、ある特定の言語向けにのみ明示的に設計されているかもしれません。そこで、言語ではなく、文字体系について見ていきましょう。

{{ figure_markup(
  image="writing-systems-supported-by-fonts.png",
  caption="フォントがサポートするライティングシステム。",
  description="デスクトップページの57.6%、モバイルページの53.6%でラテン語が使用され、キリル文字がそれぞれ6.1%、6.2%、ギリシャ語は3.4%と3.4%、カタカナが0.9%、1.0%、ひらがなが0. 9％と0.9％、ヘブライ語が0.5％と0.5％、アラビア語が0.3％と0.4％、タイ語が0.2％と0.3％、ハングルが0.5％と0.3％、デーバナガリが0.2％と0.3％、最後にハン語がデスクトップとモバイルページで0.2％となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=45355249&format=interactive",
  sheets_gid="841363278",
  sql_file="font_writing_scripts.sql",
  width=600,
  height=401
  )
}}

驚くなかれ、ラテン系がリードしており、なんと全フォントの53.6％が[ラテン文字系](https://ja.wikipedia.org/wiki/%E6%96%87%E5%AD%97%E4%BD%93%E7%B3%BB%E5%88%A5%E3%81%AE%E8%A8%80%E8%AA%9E%E3%81%AE%E4%B8%80%E8%A6%A7#%E3%83%A9%E3%83%86%E3%83%B3%E6%96%87%E5%AD%97)の（重要な）サブセットをサポートしています。この中には、英語、フランス語、ドイツ語など、欧米で使われている多くの言語が含まれています。しかし、ベトナム語やタガログ語など、アジア圏の言語も含まれています。2位と3位は、キリル文字とギリシャ語です。これらは一般的に使われており、追加しなければならないグリフの数が限られているため、フォントに追加する作業もそれなりに少なくて済むからです。カタカナとひらがな（日本語）は、それぞれ1%と0.9%で、合計1.9%です。なお、約10％のフォントが、文字システムの最低基準を満たせませんでした（写真には写っていません）。たとえば、少数の文字にしか対応していないフォントや、サブセット化が進んでいるフォントが含まれます。

悲しいことに、他の文字システムはもっと普及していません。たとえば、漢文（中国語）は<a hreflang="en" href="https://www.worldatlas.com/articles/the-world-s-most-popular-writing-scripts.html">世界で2番目に普及している文字システム</a>です（ラテン語の次に）。しかし、ウェブフォントの0.2%しかサポートしていません。アラビア語は3番目に多く使われている文字システムですが、やはりウェブフォントの0.4%しかサポートされていません。これらの<a hreflang="en" href="https://www.w3.org/TR/PFE-evaluation/#fail-large">ライティングシステムがウェブフォントとして使われていない理由</a>は、サポートしなければならないグリフの数が非常に多く、それらを正しくサブセットするのが難しいため、非常に大きくなってしまうからです。

GoogleフォントやAdobeフォントなどのサービスはこれらの文字システムをサポートしていますが、これらは独自の技術を使用しており、単にセルフホスティングで利用することはできません。しかし、W3Cフォントワーキンググループは、<a hreflang="en" href="https://www.w3.org/TR/IFT/">インクリメンタルフォントの転送</a>という新しい標準に取り組んでおり、Web開発者が大きなフォントをセルフホストできるようにします。この技術が広く利用されるようになれば、他の文字体系がラテン語に追いつくことを期待しています。

### 一般的なフォントファミリー

フォールバックフォントについては、`font-display`について説明したときにすでに触れました。たとえばUI要素やフォームの入力など、ウェブフォントがまったく必要ない場合もあります。ウェブフォントの使用を避けるための私たちのお気に入りの方法の1つは、オペレーティングシステムによって使用されるフォントファミリーにマッピングされる新しい一般的な`system-ui`ファミリー名を使用することです。他にもいくつかの一般的なファミリーがあることをご存知でしょうか？オペレーティングシステムのフォントを使いたいが、もう少し特殊なニーズがある場合は、`ui-monospace`, `ui-sans-serif`, `ui-serif`, `ui-rounded` もあります。

{{ figure_markup(
  image="usage-of-css-generic-font-family-names.png",
  caption="CSS汎用フォントファミリー名の使用。",
  description="棒グラフでは、`sans-serif`がデスクトップページの89.1%、モバイルページの89.3%、`monospace`がそれぞれ65.8%、64.7%、`serif`は54.0%、55.0%、`cursive`が3. 7%と3.9%、 `system-ui`が4.0%と3.6%、 `fantasy`が0.5%と0.5%、 `ui-monospace`が0.6%と0.5%で、最後に `ui-sans-serif`がデスクトップの0.5%とモバイルの0.4%で使われました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1479159855&format=interactive",
  sheets_gid="467837585",
  sql_file="usage_of_system_families.sql",
  width=600,
  height=400
  )
}}

これらはかなり新しいものですが、すでに重要な用途に使用されています。とくに、`sans-serif`、`monospace`、`serif`は、CSS仕様の最初のバージョンから存在しているため、明らかにリードしていることがわかります。

もっとも普及しており、よく知られているのは `system-ui` で3.6%、次いで `ui-monospace` で0.5%、`ui-sans-serif` で0.4%です。0.5%の`fantasy`のリクエストは何を望んでいたのかは不明です。このジェネリックは仕様が不十分で、事実上役に立たないからです。

来年は、このような一般的なファミリーネームをより多く使用することを期待します。UI要素やフォームなど、ネイティブ感を出したい場合に最適です。さらに、ローカルにインストールされたフォントを使用することが保証されているため、パフォーマンス面でも優れています。

### フォントスムージング

{{ figure_markup(
  image="usage-of-font-smoothing-properties.png",
  caption="フォントスムージングプロパティの使用方法。",
  description="棒グラフでは、`-webkit-font-smoothing: antialiased`がデスクトップの74%、モバイルページの73%で使用され、`-moz-osx-font-smoothing: grayscale`が67%と66%で、 `-webkit-font-smoothing: auto`が13%と12%、最後に `-webkit-font-smoothing: subpixel-antialiased` はデスクトップの13%とモバイルページの13%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=534216530&format=interactive",
  sheets_gid="1970926839",
  sql_file="font_smoothing_usage.sql"
  )
}}

そして、私たちにとっても驚きだったのが、macOS専用の[フォントスムージング設定](https://developer.mozilla.org/ja/docs/Web/CSS/font-smooth)を指定するのが。好きな人が多いことです。たとえば、`-webkit-font-smoothing: antialiased`という値は、全サイトの73.4%で使用されています。これは驚くべきことで、この値とその兄弟である `-mox-osx-font-smoothing` や `font-smoothing` は、公式のCSSプロパティですらないからです。これは、もっとも使用されている非公式CSSプロパティと言えるかもしれません。

これは、CSSフレームワークがこれらのプロパティを含んでいることと、macOSでフォントが少し太く表示されることを嫌って、可変フォントグレードを使用するようになったことが原因だと思われます。2023年の「フォント」の章で、これらのプロパティに再び触れるのもおもしろいかもしれません。また、これらのプロパティを標準化する時期が来ているのかもしれません。需要があるのは明らかです。

## 可変フォント

_可変フォント_ により、タイプデザイナーは、1つのファミリーの複数のスタイルを1つのフォントファイルにまとめることができます。これは、ウェイト（細字、普通字、太字）や幅（コンデンス、ノーマル、エキスパンド）など、1つまたは複数のデザイン軸を定義することによって実現されます。バリアブルフォントは、各スタイルを個別のフォントファイルとして保存する代わりに、一握りの「マスター」インスタンスからそれらを補間します。

たとえばタイプデザイナーが明示的にセミボールドのスタイルを作成しなかったとしても、ウェイト軸を持つバリアブルフォントを使用すれば、テキストレンダリングエンジンは単純にセミボールドのスタイルを補間します（バリアブルフォントのウェイト軸がその範囲をサポートしていれば、他のウェイトも必要な場合があります）。バリアブルフォントは、タイポグラフィの表現力を高めるだけでなく、ウェブ開発者にとって、複数のフォントバリエーションを使用した場合のファイルサイズの節約という大きなメリットもあります。ただし、バリアブルフォントは、1つのバリエーションよりもサイズが大きくなります。

{{ figure_markup(
  image="usage-of-variable-fonts.png",
  caption="可変フォントの使用。",
  description="2020年にはデスクトップとモバイルの両方で11%のページがバリアブルフォントを使用しており、2021年には両方の13%に増加し、2022年にはデスクトップページの28%とモバイルページの29%に急増したことを示すコラムチャートです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=920070467&format=interactive",
  sheets_gid="1460535004",
  sql_file="variable_font_usage.sql"
  )
}}

アルマナック2020年フォント章の前回の測定から、可変フォントの使用率が3倍近くに増加! 約29％のウェブサイトが可変フォントを使用しています。この成長のもっとも大きなものは、ここ1年で起こったようで、125％という驚くべき伸びを示しています。

{{ figure_markup(
  content="97%",
  caption="Googleフォントで提供されている可変フォントを使用しています。",
  classes="big-number",
  sheets_gid="325872648",
  sql_file="variable_font_googlefonts_vs_other.sql",
) }}

この驚異的な使用量の増加は、リクエストデータをホスト別に分割することで説明できます。Googleフォントは、提供される可変フォントの97％を占め、それ以外は3％に過ぎません。Googleがウェブフォントサービスに多大な影響を与えたとしても、この成長は、まったく新しい可変フォントを導入するのではなく、人気のある既存の静的スタイルを可変バージョンに置き換えることでしか説明できないのです。

その結果、Googleフォントとそのユーザーは、おそらくパフォーマンスにおいて大きなメリットを得ていることでしょう。可変フォントは、通常、複数の静的インスタンスを使用するよりも小さいです。たとえば、ウェブサイトが同じファミリーのスタイルを2つか3つ以上使用する場合、可変フォントはファイルサイズが小さく、1回のリクエストですみます。通常、レギュラー、ボールド、ライトウェイトの使用は、可変フォントを使用する十分な理由となります。さらに、可変フォントでは、ニーズに合わせて軸を調整することもできます、セミデミボールドは？

一人の俳優がこの成長に関与しているかどうかは別として、これは驚くべき成果であり、サイトのパフォーマンスを最適化するための可変フォントの有用性を示す良い指標となります。

可変フォントはまた、2つの競合するフォーマットを持っています: `glyf`フォーマットの可変拡張とコンパクトフォントフォーマット2（`CFF2`）フォーマットです。`glyf`フォーマットと`CFF2`の主な違いは、`CFF`の前身と同じで異なるタイプのベジエ曲線、より自動化されたヒンティング、そしてファイルサイズの縮小を謳っていることです。

{{ figure_markup(
  content="99.99%",
  caption="アウトラインフォーマット `glyf` を使用した可変フォント。",
  classes="big-number",
  sheets_gid="993301429",
  sql_file="types_of_variable_font.sql",
) }}

では、どのフォーマットを使えばいいのでしょうか？幸いなことに、開発者、タイプデザイナー、ブラウザベンダーにとって、状況は非常にシンプルです。提供されているすべての可変フォントのうち、99.99%が可変の`glyf`形式を使用しています。Google Fontsやその他のフォントサービスを計算から除外しても、その数はなんと99.98%になります。誰も`CFF2`を使っていないのです。

`CFF2`ベースの可変フォントは、（少なくとも今のところは）避けることをオススメします。ブラウザやオペレーティングシステムが `CFF2` をサポートするようになったのはごく最近のことで、一部のブラウザではまだサポートしていません。`CFF2`を使用することで`glyf`ベースの可変フォントと比較して、唯一目に見える利点はファイルサイズの節約とされていますが、パフォーマンスのセクションで見てきたように、この主張はもっとも高いレベルで疑わしいものなのです。

{{ figure_markup(
  image="usage-of-font-variation-settings-axes.png",
  caption="font-variation-settingsの軸の使用法。",
  description="列表では、`wght`がデスクトップページの82%、モバイルページの87%で使用され、`opsz`がそれぞれ5%と4%、`wdth`が5%と4%、`slnt`が3%と2%、`ital`が2%と1%、そして最後に`GRAD`がデスクトップとモバイルページの1%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2021084759&format=interactive",
  sheets_gid="1634075051",
  sql_file="variable_font_axes_css.sql"
  )
}}

では、人々はどのように可変フォントを使用しているのでしょうか？当然のことながら、`font-variation-settings`プロパティで使用される値としては、ウェイト軸がもっとも普及しており、次いでオプティカルサイズ、幅、スラント、イタリック、グレードと続きます。

なぜなら、カスタムウェイト軸の値を設定するために、低レベルの `font-variation-settings` プロパティを使用する必要がないからです。たとえば、500と600の間の重さを設定するには、`font-weight: 550`のように、`font-weight`プロパティにカスタム値を指定するだけでよいのです。

{{ figure_markup(
  image="popular-variable-font-weight-values.png",
  caption="人気の可変フォントウェイト値。",
  description="棒グラフでは、可変フォントを使用しているデスクトップページの22%、可変フォントを使用しているモバイルページの23%に`400`のフォントウェイトが使用され、両者の22%に`600`、デスクトップページの21%とモバイルページの22%に`700`、それぞれ19%と21%に`300`、4%と3%に`500`、両ページの2%に`800`、デスクトップの2%とモバイルページの1%に`550`、両方の1%に`900`、両方の1%に`200`、最後にデスクトップとモバイル両方のページで1%の`450`のフォントが使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1275376550&format=interactive",
  sheets_gid="1634075051",
  sql_file="variable_font_axes_css.sql",
  width=600,
  height=401
  )
}}

さらに不可解なのは、もっとも普及しているウェイト軸の値が、CSSの初期からある「デフォルト」のウェイト値であることです！ウェイト軸の値は、CSSの初期からある「デフォルト」のウェイト値です。ウェイト値のうち、ウェイト範囲に沿ったカスタム値は16％しかないのです。

もっとも普及している「カスタム」ウェイト値は `550` で、使用率はわずか1.5%、次いで `450`で使用率は1%です。同様の結果は、オプティカルサイズ、ワイド、イタリック、スラント軸にも見られ、これらは高レベルの `font-optical-sizing`, `font-stretch`, `font-style` プロパティを使用して設定することができる。高レベルのプロパティを使用すると、CSSがより読みやすくなり、低レベルのプロパティでよくあるエラーの原因である軸を誤って無効にしてしまうことを防ぐことができます。

バリアブルフォントの利点の1つとして、1軸または複数軸のアニメーション化が強く推奨されています。可変フォントの使用率が高いにもかかわらず、CSSの遷移やキーフレームを使って実際にアニメーションさせている人はごくわずかです。HTTP Archiveの全データセットのうち、可変フォントを使ったアニメーションを行っているウェブサイトは、わずか数百件です。

私たちの目には、バリアブルフォントは主にパフォーマンス上の利点で使用され、タイポグラフィの調整能力ではあまり使用されていないように見えます。それはそれで素晴らしいことですが、今後、より多くの人がバリアブルフォントを使い、そのタイポグラフィの可能性を最大限に発揮してくれることを期待しています。

## カラーフォント

カラーフォントは、皆さんが期待する通り、色が内蔵されたフォントです。元々は絵文字のために作られた技術ですが、今では絵文字よりも文字色フォントの方が多くなっています。

{{ figure_markup(
  image="color-font-usage.png",
  caption="カラーフォントの使用方法。",
  description="2020年はデスクトップページの0.005%、モバイルページの0.004%、2021年はそれぞれ0.013%、0.015%、2022年でデスクトップページの0.015%、モバイルページの0.018%でカラーフォントが使われていることを示すコラムチャートです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1366906842&format=interactive",
  sheets_gid="1630630917",
  sql_file="color_font_usage.sql"
  )
}}

カラーフォントの使用率は、前回のフォント章（2020年）からかなり伸びています。2020年にカラーフォントを使用しているページの0.004%だった使用率が、2022年には約0.018%になりました。この数字はまだ非常に小さいですが、その使用率は明らかに伸びています。

しかし、可変フォントの使用率の伸びと比較すると、カラーフォントの取り込みが限定的であることは、やや残念なことです。カラーフォントはOpenType仕様に追加された比較的新しいもの（2015年）ですが、可変フォントはさらに最近追加されたもの（2016年）です。

カラーフォントの普及を大きく妨げてきた（そしてこれからも妨げるかもしれない）主な要因は、 _唯一の真のカラーフォント形式_ を求める標準化の「戦い」が続いていることと、カラーフォントパレットを選択・編集するためのCSSが、最近までブラウザでサポートされていないことです。

現在、4つのカラーフォントフォーマットが競合しています。2つはベクターアウトラインに基づくもの（`SVG`と`COLR`）、2つはイメージに基づくもの（`CBDT`と`sbix`）です。`COLR`フォーマットは、既存のグリフのアウトラインを再利用し、それにソリッドカラーとレイヤリングを追加したものです。もっとも新しいバージョンは `COLRv1` と呼ばれ、グラデーション、合成、ブレンドモードも導入された。既存のグリフアウトラインを再利用するため、`COLR`フォーマットは可変フォントにも対応しており、<a hreflang="en" href="https://www.typearture.com/variable-fonts/">アニメーションのカラーフォント</a>を作成できます。`SVG`フォーマットは異なるアプローチをとり、基本的にフォントの各グリフに対してSVG画像を埋め込みます。残念ながら、`SVG` フォーマットは可変フォントに対応していませんし、将来的にも対応する可能性は低いでしょう。CBDT`と`sbix`はどちらも各グリフに画像を埋め込みますが、対応する画像形式が異なるだけです。

{{ figure_markup(
  image="color-font-formats.png",
  caption="カラーフォントのフォーマット。",
  description="円グラフによると、モバイルで使用されているカラーフォントはSVGが74.2%、COLRv0で22.8%、CBDTが2.5%、sbixは0.2%、そしてCOLRv1も0.2%となっていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2109618513&format=interactive",
  sheets_gid="1976816146",
  sql_file="color_fonts.sql"
  )
}}

カラーフォントの使用率は79％が`SVG`、19％が`COLRv0`、2％が`CBDT`です。

画像ベースのフォーマットは人気がないと結論づけられますが、それには理由があります：埋め込まれた画像はうまく拡大縮小できず、そのファイルサイズはウェブでの使用には適していません。

しかし、ベクターカラーフォントフォーマット間の分裂は、より微妙なものです。現時点では`SVG`が優勢に見えますが、`COLR`も依然として大きな使用率を誇っています。`COLR`フォーマットは、すべてのブラウザでサポートされていること、可変フォントで使用できること、そして実装が簡単であることなど、多くの利点がある。このような理由だけで、もっとも普及しているフォーマットになると予想されます。もっと皮肉な見方をすれば、Googleが<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=306078">ChromeとAndroidで`SVG`のサポートを実装することを拒否しているため、このフォーマットがもっとも普及しているだろうということです</a>。興味深いことに、<a hreflang="en" href="https://lists.webkit.org/pipermail/webkit-dev/2021-March/031765.html">Appleは`COLRv1`の実装を拒否しています</a>。なぜなら`COLRv1`の機能の多くは、すでに`SVG`フォーマットでサポートされているからです。残念ながら、ウェブ開発者はこの「カラーフォント戦争」の渦中に巻き込まれています。私たちは、この状況がすぐに解決され、私たち全員がカラーフォントを使い始めることができるようになることを願っています。

CSSの仕様が更新され、カラーフォントに対応して、<a hreflang="en" href="https://css-tricks.com/colrv1-and-css-font-palette-web-typography/">パレットの選択とカスタマイズ</a>が可能になりました。パレットとは、タイプデザイナーがフォントに保存したカスタムカラースキームのことです。CSSの `font-palette` プロパティでは、フォントからパレットを選択でき、`@font-palette-values` ルールでは、新しいパレットを作成したり既存のパレットを上書きできます。この技術のより明白な使用例の1つは、カラーフォントの中にライトモードとダークモードのパレットを組み込むことです。そこには、未開拓の可能性がたくさんあります。

{{ figure_markup(
  image="bradley-initials.png",
  caption='<a hreflang="en" href="https://djr.com/">David Jonathan Ross</a>によるCOLR v1とマルチパレットを使用した<a hreflang="en" href="https://tools.djr.com/misc/bradley-initials/">Bradley Initials</a>。',
  description="A specimen of the font Bradley Initials by David Jonathan Ross showing six different color palettes.",
  width=1911,
  height=1142
  )
}}

残念ながら、これらのCSSプロパティの使用は、現在では存在しません。これは、これらのプロパティのサポートが最近になってブラウザに追加されたことと、カラーフォントの数が限られていることが原因だと思われます。

カラーフォントの技術を発展させた大きな原動力のひとつが絵文字でした。しかし、カラー絵文字を持つWebフォントは数十種類しかありません。もっともカラーフォントはテキストを書くためのもので、絵文字には対応していない。これには、いくつかの説明が考えられます。

- どのOSもすでに独自のカラー絵文字フォントを搭載しているので、ユーザーはそれ以外のものを使う必要性を感じない。
- 絵文字は数が多いので、そのフォントを作るのは大変な労力とお金がかかります。
- 絵文字フォントは一般的にかなり大きく、ウェブフォントほど適していません。

しかし、絵文字のフォントにもう少し多様性があってもいいのではないでしょうか。COLR v1フォーマットの導入により、今後、絵文字フォントを目にすることがより多くなりそうです。

これらはすべて非常に低い使用率に基づくものですが、いくつかの発展的な傾向があるように思われます。2023年をカラーフォントの年と宣言するのはまだ早いですが、今後数年間、カラーフォントが大きく成長することは間違いないようです。とくに、業界が推奨するカラーフォント形式を1つに定め、ブラウザのカラーフォントへの対応が進むにつれて、カラーフォントは大きく成長するでしょう。Googleフォントも、<a hreflang="en" href="https://material.io/blog/color-fonts-are-here">カラーフォントの第一弾</a>をライブラリに追加したばかりで、きっとインパクトがあるはずです。

## 結論

この章とその前の年を振り返ってみると、ウェブフォントサービスがどれほど大きな影響力を持っているか、そしておそらくこれからも持ち続けるであろうことがよくわかります。たとえばGoogleフォントだけで、ウェブフォントのもっとも多く、もっとも普及しているウェブフォントのほとんど、そして可変フォントのほとんどに対応しています。これはすごいことです。

私たちは、ウェブフォントの将来はセルフホスティングであると強く信じていますが、ウェブフォントサービスを利用することが多くの開発者にとって理にかなっていることも否定はできません。ウェブフォントサービスは使いやすく、もっとも高いパフォーマンス（ベストではありませんが）を提供し、もっともフォントのライセンスについて心配する必要がありません。これは良いトレードオフです。

一方セルフホスティングは今までになく簡単で、もっとも高いパフォーマンス、より多くのコントロール、そしてプライバシーの問題に悩まされることはないでしょう。セルフホスティングを計画する場合、WOFF2、リソースヒント、`font-display`を必ず使用してください。これらを組み合わせることで、あなたのサイトのフォント読み込みパフォーマンスにもっとも大きな影響を与えることができます。

ここ2、3年、Googleのおかげで、可変フォントが華々しく登場しました。もっともパフォーマンスが高いからという理由で使っている人が多いようですが、私たちは、このようなケースは、採用が革新をもたらすと信じています。今後、どのような楽しいタイポグラフィやクレイジーなタイポグラフィが登場するか、楽しみです。

カラーフォントについても、慎重に楽観視しています。利用がようやく増えてきたのです。技術は以前からあったのですが、カラーフォントのフォーマットに関する意見の相違や、CSSのサポートが限られていることが、採用の妨げになっています。これらがすぐに解決され、本当の意味での成長が見られるようになることを期待しています。

Webフォントの利用は、今後も増え続け、時代とともに進化していくことは間違いないでしょう。私たちは、未来がどうなるかを知りたいと思っています。<a hreflang="en" href="https://www.w3.org/TR/IFT/">Incremental Font Transfer</a>のようなテクノロジーは、より多くの文字システムにウェブ フォントを提供し、何十億もの人々がはじめてウェブ フォントを使い始めることを可能にします。それは楽しみですね。
