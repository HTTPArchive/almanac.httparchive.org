---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Eコマース
description: 2019年Web AlmanacのEコマースの章では、Eコマースのプラットフォーム、ペイロード、画像、サードパーティ、パフォーマンス、SEO、PWAをカバーしています。
hero_alt: Hero image of a Web Almanac character at a super market checkout loading items from a shopping basket onto the conveyor belt while another character payes with a credit card.
authors: [samdutton, alankent]
reviewers: [voltek62]
analysts: [rviscomi]
editors: [tunetheweb]
translators: [ksakae1216]
discuss: 1768
results: https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/
samdutton_bio: Sam Duttonは2011年からDeveloper AdvocateとしてGoogle Chromeチームで働いています。数々のイベントを企画して発表し、いくつかのウェブ開発コースを作成して教え、PWA、パフォーマンス、メディア、イメージ、「Next Billion Users」イニシアティブをカバーする様々なビデオ、コードラボ、文書化されたガイダンスに取り組んできました。彼は<a hreflang="en" href="https://simpl.info">simpl.info</a>を管理しており、HTML、CSS、JavaScriptの最もシンプルな例を提供しています。南オーストラリアで育ち、シドニーの大学に進学し、1986年からロンドンに住んでいます。
alankent_bio: Alan KentはGoogleのDeveloper Advocateで、Eコマースとコンテンツエコシステムに焦点を当てています。彼は <a hreflang="en" href="https://alankent.me">alankent.me</a> でブログを書いており、<a href="https://x.com/akent99">@akent99</a> としてツイートしています。
featured_quote: この調査では、ホームページの10%近くがeコマース・プラットフォーム上にあることが判明しました。<em>eコマースプラットフォーム</em> は、オンラインストアを作成して運営することを可能にするソフトウェア ソフトウェアまたはサービスのセットです。Shopifyなどの有料サービス、Magentoオープンソースなどのソフトウェアプラットフォーム、およびMagento Commerceなどのホスト型プラットフォームなどが含まれます。
featured_stat_1: 3.98%
featured_stat_label_1: WooCommerceを使用してサイト最も人気のあるEコマースプラットフォーム
featured_stat_2: 116
featured_stat_label_2: 検出されたEコマースプラットフォームの数
featured_stat_3: 1,517 KB
featured_stat_label_3: モバイルEコマースページあたりの画像バイト数の中央値。
---

## 序章

この調査では、ホームページの10％近くがEコマース・プラットフォーム上にあることが判明しました。「Eコマースプラットフォーム」は、オンラインストアを作成し、運営することを可能にするソフトウェアまたはサービスのセットです。Eコマースプラットフォームのいくつかのタイプがあります。

- <a hreflang="en" href="https://www.shopify.com/">Shopify</a>のような**有料サービス**は、あなたのお店をホストし、あなたが始めるのを手助けしてくれます。彼らはウェブサイトのホスティング、サイトやページのテンプレート、商品データの管理、ショッピングカートや支払いを提供しています。
- <a hreflang="en" href="https://magento.com/products/magento-open-source">Magento Open Source</a>のような**ソフトウェアプラットフォーム**は自分で設定し、ホストし、管理できます。これらのプラットフォームは強力で柔軟性がありますが、Shopifyのようなサービスよりもセットアップや運用が複雑になることがあります。
- <a hreflang="en" href="https://magento.com/products/magento-commerce">Magento Commerce</a>のような**ホスト付きプラットフォーム**は、ホスティングがサードパーティによってサービスとして管理されていることを除いて、彼らのセルフホスティングされた対応と同じ機能を提供しています。

{{ figure_markup(
  caption="Eコマースプラットフォーム上のページの割合。",
  content="10%",
  classes="big-number"
)
}}

この分析では、Eコマース・プラットフォーム上に構築されたサイトのみを検出できました。つまり、Amazon、JD、eBayなどの大規模なオンラインストアやマーケットプレイスはここには含まれていません。また、ここでのデータはホームページのみを対象としており、カテゴリ、商品、その他のページは含まれていないことにも注意してください。当社の[方法論](./methodology)の詳細については、こちらをご覧ください。

## プラットフォーム検出

ページがEコマースプラットフォーム上にあるかどうかを確認するにはどうすればいいですか？

検出は[Wappalyzer](./methodology#wappalyzer)で行います。Wappalyzerは、Webサイトで使用されている技術を発見するためのクロスプラットフォームユーティリティです。[コンテンツ管理システム](./cms)、Eコマースプラットフォーム、Webサーバー、[JavaScript](./javascript)フレームワーク、[アナリティクス](./third-parties)ツールなどを検出します。

ページ検出は常に信頼できるものでなく、サイトによっては自動攻撃から保護するために検出を明示的にブロックしている場合もあります。特定のEコマースプラットフォームを使用しているすべてのウェブサイトを捕捉することはできないかもしれませんが、検出したウェブサイトは実際にそのプラットフォームを使用していると確信しています。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Eコマースページ</td>
        <td class="numeric">500,595</td>
        <td class="numeric">424,441</td>
      </tr>
      <tr>
        <td>総ページ数</td>
        <td class="numeric">5,297,442</td>
        <td class="numeric">4,371,973</td>
      </tr>
      <tr>
        <td>採用率</td>
        <td class="numeric">9.45%</td>
        <td class="numeric">9.70%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="検出されたEコマースプラットフォームの割合。") }}</figcaption>
</figure>

## Eコマースプラットフォーム

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">3.98</td>
        <td class="numeric">3.90</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">1.59</td>
        <td class="numeric">1.72</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">1.10</td>
        <td class="numeric">1.24</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">0.91</td>
        <td class="numeric">0.87</td>
      </tr>
      <tr>
        <td>Bigcommerce</td>
        <td class="numeric">0.19</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>Shopware</td>
        <td class="numeric">0.12</td>
        <td class="numeric">0.11</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位6つのEコマースプラットフォームの採用。") }}</figcaption>
</figure>

検出された116のEコマースプラットフォームのうち、デスクトップまたはモバイルサイトの0.1％以上で検出されたのは6つだけでした。これらの結果には国別、サイトの規模別、その他の類似した指標による変動は示されていません。

上記の図13.3を見ると、WooCommerceの採用率が最も高く、デスクトップおよびモバイルサイトの約4％を占めていることがわかります。Shopifyは約1.6％の採用で2位です。Magento、PrestaShop、Bigcommerce、Shopwareが0.1％に近づき、採用率が小さくなっています。

### ロングテール

{{ figure_markup(
  image="fig4.png",
  caption="トップのEコマースプラットフォームの採用。",
  description="上位20のEコマースプラットフォームの採用状況の棒グラフ。上位6プラットフォームの採用状況のデータ表は、上記の図13.3を参照してください。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1565776696&format=interactive",
  width=600,
  height=414,
  data_width=600,
  data_height=414
  )
}}

110のEコマースプラットフォームがあり、それぞれがデスクトップまたはモバイルのウェブサイトの0.1％未満を持っています。そのうち約60社は、モバイルかデスクトップのウェブサイトの0.01％未満を占めています。

{{ figure_markup(
  image="fig5.png",
  caption="上位6つのEコマースプラットフォームと他の110のプラットフォームとの複合的な採用。",
  description="上位6つのEコマースプラットフォームは、すべてのウェブサイトの8％を占めています。残りの110のプラットフォームはウェブサイトの1.5％を占めているに過ぎません。デスクトップとモバイルの結果は似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2093212206&format=interactive",
  width=600,
  height=361,
  data_width=600,
  data_height=361
  )
}}

モバイルでのリクエストの7.87％、デスクトップでのリクエストの8.06％は、上位6つのEコマース・プラットフォームのうちの1つのホームページが対象となっています。さらにモバイルでのリクエストの1.52％、デスクトップでのリクエストの1.59％は、他の110のEコマース・プラットフォームのホームページが対象となっています。

## Eコマース（すべてのプラットフォーム）

合計で、デスクトップページの9.7％、モバイルページの9.5％がEコマースプラットフォームを利用していました。

{{ figure_markup(
  image="fig6.png",
  caption="任意のEコマースプラットフォームを使用しているページの割合。",
  description="デスクトップページの9.7%がEコマースプラットフォームを使用しており、モバイルページの9.5%がEコマースプラットフォームを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1360307171&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

ウェブサイトのデスクトップ比率は全体的に若干高くなっていますが、一部の人気プラットフォーム（WooCommerce、PrestaShop、Shopwareを含む）では、実際にはデスクトップウェブサイトよりもモバイル性が高くなっています。

## ページの重さと要望

Eコマースプラットフォームの[ページの重さ](./page-weight)は、すべてのHTML、CSS、JavaScript、JSON、XML、画像、オーディオ、およびビデオを含んでいます。

{{ figure_markup(
  image="fig7.png",
  caption="Eコマースのページ重量の分布。",
  description="10、25、50、75、およびEコマースページの重量の90パーセンタイルの分布。中央値のデスクトップEコマースページは2.7MBをロードします。10パーセンタイルは1.0MB、25パーセンタイルは1.6MB、75パーセンタイルは4.5MB、90パーセンタイルは7.6MBです。デスクトップのウェブサイトは、メガバイトの10分の1の割合でモバイルよりもわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=448248428&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Eコマースページごとのリクエストの分布。",
  description="Eコマースページあたりのリクエストの10、25、50、75、および 90パーセンタイルの分布。中央値のデスクトップ Eコマースページは108リクエストを行います。10パーセンタイルは53リクエスト、25パーセンタイルは76、75パーセンタイルは153、90パーセンタイルは210です。デスクトップのウェブサイトは、約10リクエストでモバイルよりもわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1968521689&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

デスクトップEコマースプラットフォームのページの読み込み量の中央値は108リクエストと2.7MBです。すべてのデスクトップページの重量の中央値は74リクエストと[1.9 MB](./page-weight#ページの重さ) です。言い換えれば、Eコマースページは他のウェブページよりも50％近く多くのリクエストを行い、ペイロードは約35％大きくなっています。比較すると、<a hreflang="en" href="https://amazon.com">amazon.com</a>のホームページは、最初のロード時に約5MBのページ重量に対して約300リクエストを行い、<a hreflang="en" href="https://ebay.com">ebay.com</a>は約3MBのページウェイトに対して約150リクエストを行います。Eコマースプラットフォーム上のホームページのページ重量とリクエスト数は、各パーセンタイルでモバイルの方が若干小さくなっていますが、すべてのEコマースのホームページの約10％が7MB以上をロードし200以上のリクエストをしています。

このデータは、ホームページのペイロードとスクロールなしのリクエストを含んでいます。明らかに、最初のロードに必要なはずのファイル数よりも多くのファイルを取得しているように見えるサイトがかなりの割合で存在しています(中央値は100以上)。以下の[サードパーティのリクエストとバイト数](#サードパーティからのリクエストとバイト)も参照してください。

Eコマース・プラットフォーム上の多くのホームページが、なぜこれほど多くのリクエストを行い、これほど大きなペイロードを持つのかをよりよく理解するために、さらに調査を行う必要があります。著者らはEコマース・プラットフォーム上のホームページで、最初のロード時に数百回のリクエストを行い、数メガバイトのペイロードを持つホームページを定期的に目にします。リクエスト数とペイロードがパフォーマンスの問題であるならば、どのようにしてそれらを減らすことができるのでしょうか？

## タイプ別のリクエストとペイロード

以下の表は、デスクトップでのリクエストの場合のものです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ファイルの種類</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>画像</td>
        <td class="numeric">353</td>
        <td class="numeric">728</td>
        <td class="numeric">1,514</td>
        <td class="numeric">3,104</td>
        <td class="numeric">6,010</td>
      </tr>
      <tr>
        <td>ビデオ</td>
        <td class="numeric">156</td>
        <td class="numeric">453</td>
        <td class="numeric">1,325</td>
        <td class="numeric">2,935</td>
        <td class="numeric">5,965</td>
      </tr>
      <tr>
        <td>スクリプト</td>
        <td class="numeric">199</td>
        <td class="numeric">330</td>
        <td class="numeric">572</td>
        <td class="numeric">915</td>
        <td class="numeric">1,331</td>
      </tr>
      <tr>
        <td>フォント</td>
        <td class="numeric">47</td>
        <td class="numeric">85</td>
        <td class="numeric">144</td>
        <td class="numeric">226</td>
        <td class="numeric">339</td>
      </tr>
      <tr>
        <td>css</td>
        <td class="numeric">36</td>
        <td class="numeric">59</td>
        <td class="numeric">102</td>
        <td class="numeric">180</td>
        <td class="numeric">306</td>
      </tr>
      <tr>
        <td>html</td>
        <td class="numeric">12</td>
        <td class="numeric">20</td>
        <td class="numeric">36</td>
        <td class="numeric">66</td>
        <td class="numeric">119</td>
      </tr>
      <tr>
        <td>オーディオ</td>
        <td class="numeric">7</td>
        <td class="numeric">7</td>
        <td class="numeric">11</td>
        <td class="numeric">17</td>
        <td class="numeric">140</td>
      </tr>
      <tr>
        <td>xml</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>その他</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>テキスト</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="リソースタイプ別のページ重量分布（KB単位）のパーセンタイル。") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>ファイルの種類</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>画像</td>
        <td class="numeric">16</td>
        <td class="numeric">25</td>
        <td class="numeric">39</td>
        <td class="numeric">62</td>
        <td class="numeric">97</td>
      </tr>
      <tr>
        <td>スクリプト</td>
        <td class="numeric">11</td>
        <td class="numeric">21</td>
        <td class="numeric">35</td>
        <td class="numeric">53</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>css</td>
        <td class="numeric">3</td>
        <td class="numeric">6</td>
        <td class="numeric">11</td>
        <td class="numeric">22</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td>フォント</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">5</td>
        <td class="numeric">8</td>
        <td class="numeric">11</td>
      </tr>
      <tr>
        <td>html</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">7</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>ビデオ</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">5</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>その他</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>テキスト</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>xml</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>オーディオ</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別の1ページあたりのリクエストの分布のパーセンタイル。") }}</figcaption>
</figure>

Eコマースページでは、画像が最大のリクエスト数とバイト数の割合を占めています。デスクトップEコマースページの中央値には、1,514KB(1.5MB)の重さの画像が39枚含まれています。

[JavaScript](./javascript)リクエストの数は、より良いバンドル(および/または[HTTP/2](./http)多重化)によってパフォーマンスを向上する可能性があることを示しています。JavaScriptファイルの総バイト数はそれほど大きくありませんが、個別のリクエストが多くなっています。[HTTP/2](./http#http2の採用)の章によると、リクエストの40％以上はHTTP/2経由ではないそうです。同様に、CSSファイルは3番目にリクエスト数が多いですが、一般的には少ないです。CSSファイル(またはHTTP/2)をマージすることで、そのようなサイトのパフォーマンスを向上させることができるかもしれません。著者の経験では、多くのEコマースページでは、未使用のCSSとJavaScriptの割合が高い。[ビデオ](./media) のリクエスト数は少ないかもしれませんが、(驚くことではありません) 特にペイロードが重いサイトでは、ページの重量の割合が高くなります。

## HTMLペイロードサイズ

{{ figure_markup(
  image="fig11.png",
  caption="EコマースページあたりのHTMLバイト数の分布（KB単位）。",
  description="EコマースページあたりのHTMLバイトの10、25、50、75、および90パーセンタイルの分布。中央値のデスクトップ Eコマースページには、36KBのHTMLがあります。10パーセンタイルは12KB、25パーセンタイルは20、75パーセンタイルは66、90パーセンタイルは118です。デスクトップWebサイトの HTMLバイト数は、モバイルよりも1～2KB多いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=908924961&format=interactive"
  )
}}

HTMLペイロードには、外部リンクとして参照されるのではなく、マークアップ自体にインラインJSON、JavaScript、CSSなどの他のコードが直接含まれている場合があることに注意してください。EコマースページのHTMLペイロードのサイズの中央値は、モバイルで34KB、デスクトップで36KBです。しかし、Eコマースページの10％には、115KB以上のHTMLペイロードがあります。

モバイルのHTMLペイロードのサイズは、デスクトップとあまり変わりません。言い換えれば、サイトは異なるデバイスやビューポートのサイズに対して、大きく異なるHTMLファイルを配信していないように見えます。多くのEコマースサイトでは、ホームページのHTMLペイロードが大きくなっています。これがHTMLの肥大化によるものなのか、それともHTMLファイル内の他のコード（JSONなど）によるものなのかはわかりません。

## 画像の統計

{{ figure_markup(
  image="fig12.png",
  caption="Eコマースページごとの画像バイト数の分布（KB単位）。",
  description="Eコマースページあたりの画像バイト数の10、25、50、75、および90パーセンタイルの分布。中央値のモバイルEコマースページには、1,517KBの画像があります。10パーセンタイルは318KB、25パーセンタイルは703、75パーセンタイルは3,132、90パーセンタイルは5,881です。デスクトップとモバイルのウェブサイトでは、同様の分布を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=323146848&format=interactive"
  )
}}

{{ figure_markup(
  image="fig13.png",
  caption="Eコマースページごとの画像リクエストの分布。",
  description="Eコマースページあたりの画像リクエストの10、25、50、75、および90パーセンタイルの分布。中央値のデスクトップEコマースページでは、40件の画像リクエストが発生します。10パーセンタイルはリクエストが16件、25パーセンタイルは25件、75パーセンタイルは62件、90パーセンタイルは97件です。デスクトップの分布は、各パーセンタイルで2～10件のリクエストがモバイルよりもわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1483037371&format=interactive"
  )
}}

<aside class="note">私たちのデータ収集<a href="./methodology">方法論</a>はクリックやスクロールなど、ページ上でのユーザー操作をシミュレートしていないため、遅延して読み込まれた画像はこれらの結果には表示されないことに注意してください。</aside>

上記の図13.12と13.13で中央値のEコマースページには、モバイルでは37枚の画像と1,517KBの画像ペイロードがあり、デスクトップでは40枚の画像と1,524KBの画像ペイロードがあることを示しています。ホームページの10％は、90以上の画像と6MB近くの画像ペイロードを持っています！

{{ figure_markup(
  caption="モバイルEコマースページあたりの画像バイト数の中央値。",
  content="1,517 KB",
  classes="big-number"
)
}}

Eコマースページのかなりの割合で、大きな画像ペイロードを持ち、最初のロード時に大量の画像リクエストを行います。詳細については、HTTP Archiveの<a hreflang="en" href="https://httparchive.org/reports/state-of-images">State of Images</a>レポート、および[media](./media)と[page weight](./page weight)の章を参照してください。

ウェブサイトの所有者は、自分のサイトを最新のデバイスで見栄えの良いものにしたいと考えています。その結果、多くのサイトでは、画面の解像度やサイズに関係なく、すべてのユーザーに同じ高解像度の製品画像を配信しています。開発者は、異なるユーザーに可能な限り最高の画像を効率的に配信できるレスポンシブ技術に気づいていない（または使いたくない）かもしれません。高解像度の画像が必ずしもコンバージョン率を高めるとは限らないことを覚えておきましょう。逆に重い画像の使いすぎは、ページの速度に影響を与える可能性が高く、それによってコンバージョン率を低下させる可能性があります。サイトレビューやイベントでの著者の経験では、開発者やその他の関係者の中には、画像に遅延ローディングを使用することにSEOなどの懸念を持っている人もいます。

一部のサイトがレスポンシブ画像技術や遅延読み込みを使用していない理由をよりよく理解するために、より多くの分析を行う必要があります。またEコマースプラットフォームが、ハイエンドのデバイスや接続性の良いサイトに美しい画像を確実に配信すると同時に、ローエンドのデバイスや接続性の悪いサイトにも最高の体験を提供できるようなガイダンスを提供する必要があります。

## Popular image formats

{{ figure_markup(
  image="fig15.png",
  caption="一般的な画像フォーマット。",
  description="様々な画像フォーマットの人気を示す棒グラフ。JPEGが最も人気のあるフォーマットで、デスクトップEコマースページの画像の54％を占めています。次いでPNGが27％、GIFが14％、SVGが2％、WebPとICOがそれぞれ1％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2108999644&format=interactive"
  )
}}

<aside class="note">画像サービスやCDNの中には、`.jpg`や`.png`という接尾辞を持つURLであっても、WebPをサポートしているプラットフォームには自動的にWebP(JPEGやPNGではなく)を配信するものがあることに注意してください。たとえば、<a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">IMG_20190113_113201.jpg</a>はChromeでWebP画像を返します。しかし、HTTP Archive<a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/31a25b9064a365d746d4811a1d6dda516c0e4985/bulktest/batch_lib.inc#L994">画像フォーマットを検出する方法</a>は、最初にMIMEタイプのキーワードをチェックしてから、ファイルの拡張子にフォールバックするというものです。つまり、HTTP ArchiveがユーザーエージェントとしてWebPをサポートしているため、上記のようなURLを持つ画像のフォーマットはWebPとして与えられることになります。</aside>

### PNG

Eコマースページの4つに1つの画像はPNGです。Eコマースプラットフォーム上のページでPNGのリクエストが多いのは、商品画像のためと思われます。多くのコマースサイトでは、透過性を確保するために写真画像と一緒にPNGを使用しています。

PNGフォールバックでWebPを使用することは、[画像要素](http://simpl.info/picturetype)を介して、または<a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">Cloudinary</a>のような画像サービスを介してユーザーエージェントの能力検出を使用することで、はるかに効率的な代替手段となります。

### WebP

Eコマースプラットフォーム上の画像の1％だけがWebPであり、これはサイトレビューやパートナーの仕事での著者の経験と一致しています。WebPは<a hreflang="en" href="https://caniuse.com/#feat=webp">Safari以外のすべての最新ブラウザでサポートされています</a>し、フォールバックの仕組みも充実しています。WebPは透過性をサポートしており、写真画像のためのPNGよりもはるかに効率的なフォーマットです（上記のPNGのセクションを参照してください）。

WebPをPNGのフォールバックで使用したり、無地の色の背景でWebP/JPEGを使用して透明化を可能にするため、Webコミュニティとして、より良いガイダンスや提唱を提供できます。WebPは、<a hreflang="ja" href="https://web.dev/i18n/ja/serve-images-webp">ガイド</a> やツール (例:<a hreflang="en" href="https://squoosh.app/">Squoosh</a>や<a hreflang="en" href="https://developers.google.com/speed/webp/docs/cwebp">cwebp</a>など)があるにもかかわらず、電子商取引プラットフォームではほとんど使用されていないようです。現在<a hreflang="en" href="https://blog.chromium.org/2010/09/webp-new-image-format-for-web.html">10年近く経っている</a>WebPの利用が増えていない理由をさらに調査する必要があります。

## 画像の寸法

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">モバイル</th>
        <th scope="colgroup" colspan="2">デスクトップ</th>
      </tr>
      <tr>
        <th scope="col">パーセンタイル</th>
        <th scope="col">横幅(px)</th>
        <th scope="col">高さ(px)</th>
        <th scope="col">横幅(px)</th>
        <th scope="col">高さ(px)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">100</td>
        <td class="numeric">64</td>
        <td class="numeric">100</td>
        <td class="numeric">60</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">247</td>
        <td class="numeric">196</td>
        <td class="numeric">240</td>
        <td class="numeric">192</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">364</td>
        <td class="numeric">320</td>
        <td class="numeric">400</td>
        <td class="numeric">331</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">693</td>
        <td class="numeric">512</td>
        <td class="numeric">800</td>
        <td class="numeric">546</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Eコマースページごとの固有画像の寸法（ピクセル単位）の分布。") }}</figcaption>
</figure>

Eコマースページで要求された画像の中央値（「中間値」）は、モバイルで247X196px、デスクトップで240X192pxです。Eコマースページで要求される画像の10％は、モバイルでは693X512px以上、デスクトップでは800X546px以上です。これらの寸法は画像の本質的なサイズであり、表示サイズではないことに注意してください。

中央値までの各パーセンタイルでの画像のサイズがモバイルとデスクトップで似ていることを考えると、多くのサイトではビューポートごとに異なるサイズの画像を配信していない、言い換えればレスポンシブ画像技術を使用していないように思えます。モバイル向けに大きな画像が配信されている場合もありますが、これはデバイス検出や画面検出を使用しているサイトによって説明できるかもしれません（そうでないかもしれません！）。

なぜ多くのサイトが（一見して）異なる画像サイズを異なるビューポートに配信していないのか、もっと研究する必要があります。

## サードパーティからのリクエストとバイト

多くのウェブサイト、特にオンラインストアでは、分析、A/Bテスト、顧客行動追跡、広告、ソーシャルメディアのサポートなどのためにサードパーティのコードやコンテンツを大量にロードしています。サードパーティのコンテンツは、<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">パフォーマンスに大きな影響を与える</a>ことがあります。 [Patrick Hulce](https://x.com/patrickhulce)の<a hreflang="en" href="https://github.com/patrickhulce/third-party-web">サードパーティウェブツール</a>は、本レポートのサードパーティのリクエストを判断するために使用されており、これについては[サードパーティ](./third-parties)の章で詳しく説明しています。

{{ figure_markup(
  image="fig17.png",
  caption="Eコマースページごとのサードパーティリクエストの分布。",
  description="Eコマースページあたりのサードパーティリクエストの10、25、50、75、90パーセンタイルの分布。デスクトップでのサードパーティリクエストの数の中央値は19です。10、25、75、90パーセンタイルは4、9、34、54となっています。デスクトップの分布は、各パーセンタイルでモバイルよりも1-2件のリクエスト数だけ高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=865791628&format=interactive"
  )
}}

{{ figure_markup(
  image="fig18.png",
  caption="Eコマースページあたりのサードパーティのバイト数の分布。",
  description="Eコマースページあたりのサードパーティのバイト数の10、25、50、75、90パーセンタイルの分布。デスクトップでのサードパーティのバイト数の中央値は320KBです。10、25、75、90パーセンタイルは次のとおりです。42、129、651、1,071。デスクトップの分布は、各パーセンタイルでモバイルよりも10～30KB高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=164264869&format=interactive"
  )
}}

Eコマースプラットフォーム上の中央値（「中規模」）のホームページでは、サードパーティのコンテンツに対するリクエストは、モバイルで17件、デスクトップで19件となっています。Eコマース・プラットフォーム上のすべてのホームページの10％は、サードパーティのコンテンツに対して50件以上のリクエストを行い、その総ペイロードは1MBを超えています。

<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript/">他の研究</a>で、サードパーティのコンテンツはパフォーマンスの大きなボトルネックになる可能性であることが指摘されています。この調査によると、17以上のリクエスト（上位10％では50以上）がEコマースページの標準となっています。

## プラットフォームごとのサードパーティリクエストとペイロード

以下の表は、モバイルのみのデータを示しています。

{{ figure_markup(
  image="fig19.png",
  caption="各Eコマースプラットフォームのモバイルページごとのサードパーティリクエストの分布。",
  description="各プラットフォームのEコマースページあたりのサードパーティリクエストの10、25、50、75、および90パーセンタイルの分布。ShopifyとBigcommerceは、分布の中央値で約40件のサードパーティのリクエストをロードしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1242665725&format=interactive"
  )
}}

{{ figure_markup(
  image="fig20.png",
  caption="各Eコマースプラットフォームのモバイルページあたりのサードパーティのバイト数（KB）分布。",
  description="各プラットフォームのEコマースページあたりのサードパーティのバイト数(KB)の10、25、50、75、および90パーセンタイルの分布。ShopifyとBigcommerceは、中央値で1,000KBを超え、分布全体で最も多くのサードパーティのバイトをロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1017068803&format=interactive"
  )
}}

Shopifyのようなプラットフォームでは、クライアントサイドのJavaScriptを使ってサービスを拡張することがありますが、Magentoのような他のプラットフォームではサーバーサイドの拡張機能が多く使われています。このアーキテクチャの違いが、ここで見る数字に影響を与えています。

明らかに、一部のEコマースプラットフォームのページでは、サードパーティコンテンツへのリクエストが多く、サードパーティコンテンツのペイロードが大きくなっています。一部のプラットフォームのページで、サードパーティコンテンツへのリクエストが多く、サードパーティコンテンツのペイロードが他のプラットフォームよりも大きいのはなぜかについて、さらに分析を行うことができます。

## コンテンツの初回ペイント(FCP)

{{ figure_markup(
  image="fig21.png",
  caption="Eコマースプラットフォーム毎のFCP体験の平均分布。",
  description="上位6つのEコマースプラットフォームのFCPエクスペリエンスの平均分布の棒グラフ。WooCommerceは、遅いFCP体験の密度が43%と最も高くなっています。Shopifyは、高速FCP体験の密度が47%で最も高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1341906463&format=interactive"
  )
}}

[コンテンツの初回ペイント](./performance#コンテンツの初回ペイントfirst-contentful-paint)は、ナビゲーションからテキストや画像などのコンテンツが最初に表示されるまでの時間を測定します。この文脈では、**速い**は1秒未満のFCP、**遅い**は3秒以上のFCP、**中程度**はその中間のすべてを意味します。サードパーティのコンテンツやコードは、FCPに大きな影響を与える可能性があることに注意してください。

上位6つのEコマースプラットフォームはすべて、モバイルでのFCPがデスクトップよりも悪くなっています。FCPは、接続性だけでなく、デバイスの能力（処理能力、メモリなど）にも影響されることに注意してください。

FCPがデスクトップよりもモバイルの方が悪い理由を明らかにする必要があります。原因は何でしょうか？　接続性やデバイスの能力、それとも何か他の要因でしょうか？

## プログレッシブウェブアプリ（PWA）のスコア

Eコマースサイト以外のこのトピックの詳細については、[PWAの章](./pwa)も参照してください。

{{ figure_markup(
  image="fig22.png",
  caption="モバイルEコマースページのLighthouse PWAカテゴリスコアの分布。",
  description="EコマースページのLighthouseのPWAカテゴリスコアの分布。0（失敗）から1（完璧）のスケールで、ページの40％が0.33のスコアを取得します。ページの1％が0.6以上のスコアを取得しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1148584930&format=interactive"
  )
}}

Eコマースのプラットフォーム上のホームページの60％以上は、0.25と0.35の間に<a hreflang="en" href="https://developers.google.com/web/ilt/pwa/lighthouse-pwa-analysis-tool">Lighthouse PWAスコア</a>を取得します。Eコマースのプラットフォーム上のホームページの20％未満は、0.5以上のスコアを取得し、ホームページの1％未満は0.6以上のスコアを取得します。

Lighthouseは、プログレッシブWebアプリ（PWA）のスコアを0から1の間で返します。PWAの監査は、14の要件をリストアップした<a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">Baseline PWA Checklist</a>に基づいています。Lighthouseは、14の要件のうち11の要件について自動監査を実施しています。残りの3つは手動でしかテストできません。11の自動PWA監査はそれぞれ均等に重み付けされているため、それぞれがPWAスコアに約9ポイント寄与します。

PWA監査のうち少なくとも1つがnullスコアを取得した場合、LighthouseはPWAカテゴリ全体のスコアをnullアウトします。これは、モバイルページの2.32％が該当しました。

明らかに、大多数のEコマースページは、ほとんどの<a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">PWA チェックリスト監査</a> に失敗しています。どの監査が失敗しているのか、なぜ失敗しているのかをよりよく理解するために、さらに分析を行う必要があります。

## 結論

Eコマースの使用法のこの包括的な研究はいくつかの興味深いデータを示し、また同じEコマースのプラットフォーム上に構築されたものの間でも、Eコマースのサイトの広いバリエーションを示しています。ここでは多くの詳細を説明しましたが、この分野ではもっと多くの分析が可能です。例えば、今年はアクセシビリティのスコアを取得していませんでした（それについての詳細は[アクセシビリティの章](./accessibility)をチェックアウトしてください）。同様に、これらのメトリクスを地域別にセグメント化することも興味深いことでしょう。この調査では、Eコマース・プラットフォームのホームページ上で246の広告プロバイダーが検出されました。さらなる調査（おそらく来年のWeb Almanacに掲載されるかもしれません）では、Eコマースプラットフォーム上で広告を表示しているサイトの割合を計算できます。この調査ではWooCommerceが非常に高い数値を記録していますので、来年の調査では一部のホスティングプロバイダーがWooCommerceをインストールしているにもかかわらず、有効にしていないために数値が膨らんでいるのではないかという興味深い統計を見ることができます。
