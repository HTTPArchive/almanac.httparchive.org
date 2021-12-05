---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Eコマース
description: 2020年版Web AlmanacのEコマースの章では、Eコマースプラットフォーム、ペイロード、画像、サードパーティ、パフォーマンス、SEO、PWAなどを取り上げています。
authors: [rockeynebhwani, jrharalson]
reviewers: [alankent]
analysts: [jrharalson, rockeynebhwani]
editors: [tunetheweb]
translators: [ksakae1216]
rockeynebhwani_bio: Rockey Nebhwaniは、2001年から小売・Eコマース業界で働いている独立系コンサルタントで、アメリカやイギリスのAmazon、Wal-Mart、Tesco、M&S、Safewayなどの小売業者との仕事で幅広い経験を持っています。ロッキーは、Eコマースのイベントで時折講演を行うほか、<a href="https://twitter.com/rnebhwani">@rnebhwani</a>でツイートしています。
#jrharalson_bio: TODO
discuss: 2052
results: https://docs.google.com/spreadsheets/d/1Hvsh_ZBKg2vWhouJ8vIzLmp0nLIMzrT2mr6RQbIkxqY/
featured_quote: Covid-19は、2020年のEコマースの成長を大幅に加速させ、多くの中小企業がオンラインプレゼンスを迅速に確立し、ロックダウン中も取引を継続する方法を見つけなければなりませんでした。WooCommerce、Shopify、Wix、BigCommerceなどのプラットフォームは、より多くの中小企業をオンライン化する上で非常に重要な役割を果たしました。Covid-19では、ブランドによるD2C（Direct to Consumer）の提供も開始され、今後も増加することが予想されます。
featured_stat_1: 21.27%
featured_stat_label_1: Eコマースサイトとして認識されたモバイルサイト
featured_stat_2: 5.19%
featured_stat_label_2: もっとも人気のあるEコマースプラットフォームであるWooCommerceを使用しているサイト
featured_stat_3: 30
featured_stat_label_3: Eコマースサイトが行うJavaScriptリクエスト数の中央値
---

## 序章

「Eコマース・プラットフォーム」とは、オンラインストアを作成・運営するためのソフトウェアやサービスのセットのことです。Eコマース・プラットフォームには、たとえばいくつかの種類があります。

- Shopifyなどの有料サービスは、あなたのストアをホストし、あなたが始めるのをサポートします。ウェブサイトのホスティング、サイトやページのテンプレート、商品データの管理、ショッピングカート、決済などを提供しています。
- Magentoオープンソースのようなソフトウェアプラットフォームで、お客様自身がセットアップ、ホスト、管理を行います。これらのプラットフォームは強力で柔軟性がありますが、Shopifyなどのサービスに比べて設定や運営が複雑になる場合があります。
- Magento Commerceのようなホスティング型のプラットフォームは、セルフホスティング型のプラットフォームと同じ機能を提供しますが、ホスティングはサードパーティによってサービスとして管理されます。

昨年の分析では、Eコマースプラットフォーム上に構築されたサイトのみを検出することができました。そのため、Amazon、JD、eBayなどの大規模なオンラインストアやマーケットプレイス、または自社のプラットフォームを使用して構築されたEコマースサイト（一般的に大企業が使用する）は、分析の対象外となっていました。今年の分析では、WappalyzerのEコマースサイトの検出機能を強化することで、この制限に対処しました。詳細は[プラットフォーム検出](#platform-detection)の項を参照してください。

また、ここでのデータはホームページのみで、カテゴリーや製品などのページは含まれていないことに注意してください。[方法論](./methodology)については、こちらをご覧ください。

## プラットフォーム検出

あるページがECプラットフォームであるかどうかをどのように確認するのですか？検出はWappalyzerによって行われます。Wappalyzerは、ウェブサイトで使用されている技術を明らかにするクロスプラットフォームのユーティリティです。コンテンツマネジメントシステム、Eコマースプラットフォーム、ウェブサーバー、JavaScriptフレームワーク、分析ツールなど、さまざまなテクノロジーを検出します。

2019年と比較すると、2020年にはECサイトの%が大幅に増加していることがわかります。これは主に、今年のWappalyzerではセカンダリーシグナルを使った検出が改善されたためです。これらのセカンダリーシグナルには以下のものがあります。
- Google Analytics Enhanced Ecommerceタグを使用しているサイトは、Eコマースサイトとしてカウントされます。
- セカンダリーシグナルには、'カート'リンクを識別するためにもっともよく使われるパターンを探すことも含まれます。

この方法論の変更により、ヘッドレスソリューションを使用して構築されたエンタープライズプラットフォームやサイトへの対応が強化されました。

### 制限事項

私たちの手法には以下のような限界があります。
- <a hreflang="en" href="https://commercetools.com/">commercetools</a>のようなヘッドレスのEコマースプラットフォームはEコマースプラットフォームとして検出されないかもしれませんが、そのようなサイトでカートの存在を検出できた場合は、そのようなプラットフォームを使用しているサイトも全体のカバー率の統計に含めています。
- 一般的にホームページ以外で展開される技術（例：製品詳細ページのWebAR）は検出されません。
- 当社のクロールは米国で行われているため、米国固有のプラットフォームに偏りがあります。たとえば、グローバル企業が国ごとに異なるプラットフォームでECサイトを構築している場合（国別のドメインやサブドメインを使用している場合）、このような地域ごとの違いは分析結果に反映されない可能性があります。
- B2Bサイトではカート機能をログイン時に隠すのが一般的で、そのため今回の調査はB2B市場を正しく表していないと考えられます。

## Eコマースプラットフォーム

{{ figure_markup(
  image="ecommerce-comparison-2019-to-2020.png",
  caption="Eコマースの比較2019年から2020年まで。",
  description="Eコマースサイトのデスクトップ検出率が9.67%から21.72%に増加したことを示す棒グラフ。モバイルも同様に、9.41%から21.27%に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1775630157&format=interactive",
  sheets_gid="856812465",
  sql_file="pct_ecommsites_bydevice_compare20192020.sql"
) }}

合計では、モバイルウェブサイトの21.72％、デスクトップウェブサイトの21.27％がECプラットフォームを利用していました。2019年は、同数値がモバイルWebサイトで9.41％、デスクトップWebサイトで9.67％でした。

<p class="note">注：この増加は、主にECサイトを検出するためにWappalyzerに施された改良によるもので、Covid-19による成長などの他の要因に起因するものではありません。また、2019年の統計には誤りを考慮して遡及的に軽微な修正が適用されたため、2019年のパーセンテージは<a href="../2019/ecommerce">2019 Eコマース</a>の章で示されたものとは若干異なります。</p>

### 主要なEコマースプラットフォーム

{{ figure_markup(
  image="top-ecommerce-platforms.png",
  caption="トップのEコマースプラットフォーム。",
  description="Eコマースプラットフォームの利用状況を棒グラフで表したもの、WooCommerceはデスクトップで5.12%、モバイルでは5.19%となっています。次いで、Shopify（それぞれ2.55％、2.48％）、Wix（1.05％、1.24％）、Magneto（1.03％、0.96％）、PrestaShop（0.91％、0.94％）、1C-Bitrix（0. 64％、0.65％）、Bigcommerce（0.24％、0.21％）、Cafe24（0.21％、0.12％）、Shopware（いずれも0.14％）、Loja Integradeがそれぞれ0.08％、0.09％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=795567278&format=interactive",
  sheets_gid="872326386",
  sql_file="top_vendors.sql"
) }}

当社の分析では、145の独立したEコマースプラットフォームを数えました（[昨年の分析では116](../2019/ecommerce#ecommerce-platforms)と比較しています）。このうち、市場シェアが0.1%以上のプラットフォームは9つしかありません。WooCommerceはもっとも一般的なEコマースプラットフォームであり、1位の座を維持しています。Wixは、Wappalyzerが2019年6月30日からEコマースプラットフォームとして識別するようになってから、今年はじめてこの分析に登場しました。

### 企業向けEコマースプラットフォームのトップ

プラットフォームの階層を明確にすることは困難ですが、ここではエンタープライズ階層に重点を置いているベンダー4社（Salesforce、HCL、SAP、Oracle）を紹介します。

{{ figure_markup(
  image="enterprise-ecommerce-platforms.png",
  caption="エンタープライズEコマースプラットフォーム（デスクトップ）。",
  description="棒グラフでは、Salesforce Commerce Cloudが2,653件、3,347件、HCL WebSphere Commerceは2019年に2,268件、2020年に2,604件のデスクトップサイトで使用され、SAP Commerce Cloudは1,979件、2,371件、Oracle Commerce Cloudは1,095件、917件となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=783560373&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

このグループからは、Salesforce Commerce Cloudが引き続きリードするプラットフォームとなっています。2020年のデスクトップWebサイトは3,437件で、2019年の2,653件から29.5%増加しています。4つの企業向けEコマースプラットフォームのうち、Salesforceのウェブサイトは36.8%を占めています。

HCLテクノロジーズは、2019年7月にIBMからWebSphere Commerceを買収。この移行は2020年に複雑な結果をもたらした。HCLのWebSphere Commerceは、2019年の2,268のデスクトップWebサイト数から、今年は2,604まで14.8%増加したものの、このグループ内では27.9%まで0.5%人気が落ちていたのです。今後の動向に注目したいです。

SAP Commerce Cloud（正式名称：Hybris）は、昨年の24.8%からわずかに増加した25.4%で、依然として3番目に人気のあるエンタープライズEコマースプラットフォームです。2,371のデスクトップサイトは、2019年に見つかったHybrisが起因する1,979のデスクトップサイトから19.8%増加しています。

最後に、Oracle Commerce Cloudは残念ながら2019年から2020年の間に少し牽引力を失いました。デスクトップのウェブサイトは1,095件から917件へと16％減少し、ひいてはエンタープライズのEコマースプラットフォームの足場も13.7％から9.8％へと落ちてしまいました。

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2019.png",
  caption="企業向けEコマースプラットフォーム - 2019年版デスクトップ",
  description="2019年の企業向けEコマース市場では、Salesforce Commerce Cloudが33.2％、HCL WebSphere Commerceが28.4％、SAP Commerce Cloudが24.8％、Oracle Commerce Cloudが13.7％で利用されていることを示す円グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1864431795&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2020.png",
  caption="企業向けEコマースプラットフォーム - 2020年のデスクトップ",
  description="円グラフによると、2020年の企業向けEコマース市場では、Salesforce Commerce Cloudが36.8％、HCL WebSphere Commerceが27.9％、SAP Commerce Cloudが25.4％、Oracle Commerce Cloudが9.8％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1013485197&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Shopifyの「Shopify Plus」、Adobeの「Magento Enterprise」、Bigcommerceの「Enterprise」などがあり、人気を集めていますがPlatform Detectionの制限により企業向けWebサイトをCommunityやCommercial Webサイトから切り離すことができません。

## COVID-19のEコマースへの影響

COVID-19は世界に大きな影響を与えており、オンラインへの移行もさらに大きなものとなっています。電子商取引プラットフォームの全体的な増加を測定するには、本章のために一部で行われた検出の大幅な増加が影響します。その代わりに、すでに検出されていたいくつかのプラットフォームに注目し、とくにCOVIDが世界の大部分に影響を与え始めた2020年3月以降、その利用が増加していることを指摘します。

{{ figure_markup(
  image="ecommerce-vendor-growth-covid-19-impact.png",
  caption="Eコマースプラットフォームの成長Covid-19の影響",
  description="人気の高い5つのEコマースプラットフォームの成長を示すラインチャート。WooCommerce、Shopify、Wix、Magneto、およびPrestaShopです。WooCommerceは安定した成長を示していますが、2020年2月と6月、7月に顕著な伸びを示しています。Shopifyも同様の結果となっていますが、その割合は少なく、他の3つのプラットフォームはその影響が少ないです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1475961371&format=interactive",
  sheets_gid="535254570",
  sql_file="ecomm_vendors_covid_growth.sql"
) }}

COVIDが世界に大きな影響を与え始めた頃、WooCommerceやShopifyのサイトが明らかに増加しています。

<p class="note">注：<a hreflang="en" href="https://github.com/AliasIO/wappalyzer/pull/2731/commits/f44f20f03618f6a5fd868dd38ce9db5e2e2f1407">Wappalyzer Detection for Wix</a>は、サイトがCMSとしてWixを使用しているか、EコマースプラットフォームとしてWixを使用しているかを区別しません。このため、EコマースプラットフォームとしてのWixの成長は、上記のグラフでは正しく表されていない可能性があります。</p>

## ページの重さとリクエスト

Eコマースプラットフォームのページウェイトには、HTML、CSS、JavaScript、JSON、XML、画像、音声、動画のすべてが含まれます。

{{ figure_markup(
  image="page-requests-distribution.png",
  caption="ページが配信を要求する。",
  description="リクエスト数を示す棒グラフで、10パーセンタイルではデスクトップで46件、モバイルで44件、25パーセンタイルではそれぞれ68件と65件、50パーセンタイルでは103件と98件、75パーセンタイルでは151件と146件、90パーセンタイルではデスクトップで217件、モバイルで208件となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1278986228&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

{{ figure_markup(
  image="page-weight-distribution.png",
  caption="ページの重量配分。",
  description="10パーセンタイルはデスクトップで0.94MB、モバイルで0.85MB、25パーセンタイルはそれぞれ1.55と1.45、50パーセンタイルは2.62と2.48、75パーセンタイルは4.52と4.26、90パーセンタイルはデスクトップで7.89MB、モバイルで7.3MBとなっており、ページの重さをMBで表した棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1078671906&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

有望なことに、モバイルのページウェイトはすべてのパーセンタイルで[2019年との比較](../2019/ecommerce#page-weight-and-requests)で低下しており、デスクトップのページウェイトは多かれ少なかれ変わらない（90パーセンタイルを除く）。ページあたりのリクエスト数も、モバイル（90パーセンタイルを除くすべてのパーセンタイルで9～11リクエスト減少）とデスクトップで減少しました。

[ページ重量](./page-weight)の章で示したように、ECサイトは全サイトと比較して、リクエスト数やサイズが依然として大きいです。

### リソースタイプ別ページ重量

リソースタイプ別に見ると、中央ページでは、画像とJavaScriptのリクエストがEコマースページでは圧倒的に多いことがわかります。

{{ figure_markup(
  image="median-page-requests-by-type.png",
  caption="タイプ別ページリクエストの中央値",
  description="ファイルタイプ別のページあたりのリクエスト数を、中央値のページから順に示した棒グラフです。画像はデスクトップで37件、モバイルで34件、スクリプトはそれぞれ31件と30件、CSSは8件、フォントは5件、その他は4件、htmlは4件、ビデオは3件、xml、テキスト、オーディオはすべて1件となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1680167507&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

しかし、実際の配信バイト数を見ると、メディアが圧倒的に大きな資産となっています。

{{ figure_markup(
  image="median-page-kilobytes-by-type.png",
  caption="タイプ別ページキロバイトの中央値",
  description="ページの中央値に対して、ファイルタイプ別に1ページあたりのキロバイトを小さい順に表示した棒グラフです。画像はデスクトップで1,754キロバイト、モバイルで2,176キロバイト、スクリプトはそれぞれ1,271キロバイトと1,208キロバイト、cssは643キロバイトと611キロバイト、フォントは143キロバイトと123キロバイト、htmlは35キロバイトと34キロバイト、オーディオは14キロバイトと9キロバイト、xmlは1キロバイトと1キロバイト、テキストとその他は両方とも0キロバイト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1077946836&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

Eコマースサイトでは、リクエスト数が少ないにもかかわらず、動画が最大のリソースとなっており、次いで画像、JavaScriptとなっています。

### HTMLペイロードサイズ

{{ figure_markup(
  image="distribution-of-html-bytes-per-ecommerce-page.png",
  caption="ECページごとのHTMLバイト数の分布",
  description="HTMLのキロバイト数を示す棒グラフで、10パーセンタイルはデスクトップで12キロバイト、モバイルで13キロバイト、25パーセンタイルはそれぞれ20キロバイトと21キロバイト、50パーセンタイルは35キロバイトと36キロバイト、75パーセンタイルは76キロバイトと74キロバイト、90パーセンタイルはデスクトップで133キロバイト、モバイルで134キロバイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1956748774&format=interactive",
  sheets_gid="1032303587",
  sql_file="pagestats_html_bydevice.sql"
) }}

なお、HTMLペイロードには、外部リンクとして参照されるのではなく、マークアップ自体に直接インラインのJSON、JavaScript、CSSなどのコードが含まれている場合があります。EコマースページのHTMLペイロードサイズの中央値は、モバイルでは35KB、デスクトップでは36KBとなっています。[2019年との比較](../2019/ecommerce#html-payload-size)では、ペイロードサイズの中央値と10、25、50パーセンタイルの割合はほぼ変わりません。しかし、75パーセンタイルと90パーセンタイルでは、モバイルとデスクトップでそれぞれ約10kbと15kbの増加が見られます。

モバイルのHTMLペイロードサイズは、デスクトップとあまり変わらない。つまり、デバイスやビューポートの大きさが違っても、サイトが大きく異なるHTMLファイルを配信していないようです。

### 画像の使い方

次に、Eコマースサイトでの画像の使われ方を見てみましょう。なお、今回のデータ収集方法では、クリックやスクロールなどのページ上でのユーザーの操作をシミュレートしていないため、遅延読み込みされた画像はこの結果に含まれていません。

{{ figure_markup(
  image="distribution-of-image-requests-for-ecommerce.png",
  caption="電子商取引における画像要求の分布",
  description="画像リクエストの数を示す棒グラフで、10パーセンタイルはデスクトップで14件、モバイルで12件、25パーセンタイルはそれぞれ22件と20件、50パーセンタイルは37件と34件、75パーセンタイルは60件と56件、90パーセンタイルはデスクトップで101件、モバイルで91件のリクエストがあったことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=286315936&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-image-bytes-for-ecommerce.png",
  caption="Eコマース向けイメージバイトの配布",
  description="画像のキロバイト数を示す棒グラフで、10パーセンタイルはデスクトップで242キロバイト、モバイルで189キロバイト、25パーセンタイルはそれぞれ546キロバイトと486キロバイト、50パーセンタイルは1,271キロバイトと1,208キロバイト、75パーセンタイルは2,835キロバイトと2,737キロバイト、90パーセンタイルはデスクトップで5,819キロバイト、モバイルで5,459キロバイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=416820889&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

上の図によると、中央値のEコマースページには34枚の画像があり、画像ペイロードはモバイルで1,208KB、デスクトップでは37枚の画像と1,271KBとなっています。10%のホームページには90枚以上の画像があり、画像ペイロードはモバイルで5.5MB、デスクトップで5.8MBとなっています。

[2019年との比較](../2019/ecommerce#image-stats)では、画像リクエストの中央値と画像ペイロードの中央値の両方が低下しています。画像リクエストの中央値は、モバイルとデスクトップの両方で3減少しました。また、画像ペイロードの中央値は、モバイルとデスクトップの両方で約200kb～250kb減少しました。この減少は、現在<a hreflang="en" href="https://caniuse.com/loading-lazy-attr">より多くのブラウザ</a>でサポートされている`loading="lazy"`属性の使用など、サイトが遅延読み込み技術を採用していることが要因と考えられます。今年の[Markup](./markup#data--attributes)の章では、ネイティブの遅延ローディングの使用が増加しているようで、2020年8月には約3.86%のページでこの属性が使用されており、これは継続的に増加しているという見解が示されています（[このツィート](https://twitter.com/rick_viscomi/status/1344380340153016321?s=20)で見られます）。

#### 一般的な画像フォーマット

{{ figure_markup(
  image="popular-image-formats-on-ecommerce-sites.png",
  caption="Eコマースサイトで人気のある画像フォーマット",
  description="画像フォーマットを人気順に並べた棒グラフで、モバイルではjpgが50.19％、pngが26.54％、gifが17.35％、svgが2.61％、webpが1.17％、フォーマットなしが0.07％となっています。デスクトップでの使用率はほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=753462591&format=interactive",
  sheets_gid="943479146",
  sql_file="pagestats_image_bydevice_format.sql"
) }}

<p class="note">なお、画像サービスやCDNの中には、<code>.jpg</code>や<code>.png</code>などの接尾辞を持つURLであっても、WebPをサポートするプラットフォームには、JPEGやPNGではなくWebPを自動的に配信するものがあります。たとえば、<code>IMG_20190113_113201.jpg</code>は、ChromeではWebP画像を返します。しかし、HTTP Archiveが画像フォーマットを検出する方法は、まずMIMEタイプのキーワードをチェックし、次にファイル拡張子にフォールバックするというものです。つまり、HTTP ArchiveがユーザーエージェントとしてサポートしているのはWebPなので、上記のようなURLを持つ画像のフォーマットはWebPとして与えられることになります。</p>

PNGの使用率は、ほぼ[2019年と同水準](../2019/ecommerce#png)で推移しました（デスクトップ、モバイルともに27％）。JPEGの使用率は減少しました（デスクトップ4%、モバイル6%）。この減少分のうち、ほとんどがGIFの使用増加につながっています。GIFはEコマースのホームページではよく使われていますが、商品の詳細ページではあまり使われていないかもしれません。私たちの手法ではホームページのみを対象としているため、このことが、EコマースサイトでGIFの使用率が著しく高いことを説明しています。Lighthouseの監査では、「アニメーションコンテンツ用のビデオフォーマット」の使用を推奨しています。これは、GIFのアニメーション特性を維持しつつ、パフォーマンスを最適化するためにEコマースサイトが利用できる手法です。詳しくは<a hreflang="en" href="https://web.dev/replace-gifs-with-videos/">この記事</a>をご覧ください。

EコマースサイトにおけるWebPの使用率は、2019年には合計1%だったのが2020年には2%と倍増したものの、依然として非常に低い水準にとどまっています。WebPフォーマットは10年近く前のもので、`picture`要素を使ったプログレッシブ・エンハンスメントを可能にした後も、使用率は低いままです。2020年には、Safariが<a hreflang="en" href="https://caniuse.com/webp">Safari 14</a>でサポートを導入したことで、WebPは新たな息吹を得ました。しかし、今年のWeb Almanacは2020年8月を基準としており、Safariのサポートは2020年9月に行われたため、ここで紹介されている統計はSafariによって追加されたサポートの影響を反映していません。

今年、Chrome 85（2020年8月リリース）では、<a hreflang="en" href="https://www.ctrl.blog/entry/webp-avif-comparison.html">WebP</a>と比較してより効率的な画像フォーマットであるAVIFのサポートも確認できました。来年の分析では、EコマースサイトでのAVIFの使用状況を取り上げたいと考えています。WebPと同様に、AVIFもプログレッシブ・エンハンスメントであり、<a hreflang="en" href="https://caniuse.com/avif">クロスブラウザの問題</a>へ対処するために`picture`要素を使って実装できます。

筆者の経験によると、エンジニアリングチームでは、CDNが提供する画像最適化サービスについての認識が不足しています。CDNは、コードに触れることなくほとんどの重い作業を行うことができます。たとえば、Adobe Scene7は、<a hreflang="en" href="https://helpx.adobe.com/uk/experience-manager/6-3/assets/using/imaging-faq.html">Smart Imaging solution</a>の下でこのサービスを提供しています。また、Salesforce Commerce Cloudのクライアントは、プラットフォームに組み込まれたCDN機能（Cloudflareを使用）を利用することで、簡単な設定でこの機能を有効にできます。このようなソリューションの認知度を高めることで、より効率的なフォーマットへの移行を促進できます。

画像のサイズやフォーマットによるCRUXメトリクスの改善に興味をお持ちの読者のためにもう1つのポイントをご紹介します。現在、プログレッシブ画像は、ユーザーが知覚するパフォーマンスに役立つにもかかわらず、Largest Contentful Paintに対する加重はありません。このトピックについては、コミュニティで興味深い<a hreflang="en" href="https://github.com/WICG/largest-contentful-paint/issues/68">議論</a>が行われており、将来的にはプログレッシブ画像がLCPへ寄与するようになる可能性があります。また、2021年5月からページエクスペリエンスシグナルにCore Web Vitalsが含まれるようになったことで、プログレッシブローディングをサポートするフォーマットに対するEコマースコミュニティの関心が、再び高まる可能性があります。

### 第三者のリクエストとバイト

Eコマースのプラットフォームやサイトでは、しばしば[サードパーティ](./third-party)のコンテンツが利用されています。当社は、サードパーティの使用を検出するために、[サードパーティウェブプロジェクト](./methodology#third-party-web)を使用しています。

{{ figure_markup(
  image="distribution-of-third-party-requests.png",
  caption="第三者からの依頼の分配",
  description="Eコマースサイトに対するサードパーティからのリクエスト数を示す棒グラフで、10パーセンタイルはデスクトップで8件、モバイルで7件、25パーセンタイルはそれぞれ16件と15件、50パーセンタイルは32件と30件、75パーセンタイルは60件と58件、90パーセンタイルはデスクトップで103件、モバイルで98件のサードパーティからのリクエストがあったことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1577985571&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-third-party-bytes.png",
  caption="サードパーティ製バイトの配布",
  description="Eコマースサイトのサードパーティ製キロバイト数を示す棒グラフで、10パーセンタイルはデスクトップが88キロバイト、モバイルが67キロバイト、25パーセンタイルはそれぞれ242キロバイトと208キロバイト、50パーセンタイルは547キロバイトと489キロバイト、75パーセンタイルは1,179キロバイトと1,098キロバイト、90パーセンタイルはデスクトップが2,367キロバイト、モバイルが2,155キロバイトとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1165664044&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

[昨年のサードパーティのデータと比較して](../2019/ecommerce#third-party-requests-and-bytes)サードパーティのリクエストとバイトの使用が大幅に増加していることがわかりますが、特定の原因や顕著な検出の変化を特定することができませんでした。この1年でサードパーティの使用量が基本的に2倍になっているようなので、これに関する<a hreflang="en" href="https://discuss.httparchive.org/t/2052">読者の皆様のご意見</a>をぜひお聞かせください。

## Eコマースのユーザー体験

電子商取引は顧客を獲得することがすべてであり、そのためには高速で動作するウェブサイトがもっとも重要です。このセクションでは、Eコマースサイトの実際のユーザーエクスペリエンスに光を当ててみます。そのために、ユーザーが感じるパフォーマンス指標を分析します。この指標は、3つの<a hreflang="en" href="https://web.dev/vitals/">Core Web Vitals</a>指標で表されます。

### Chromeユーザーエクスペリエンスレポート

このセクションでは、[Chrome User Experience Report](./methodology#chrome-ux-report)で提供されている3つの重要な要素を見てみましょう。これらの要素は、ユーザーが実際にECサイトをどのように体験しているのかを理解する上でのヒントになります。

- 最大のコンテンツフルペイント (LCP)
- 最初の入力までの遅延 (FID)
- 累積レイアウト変更 (CLS)

これらのメトリクスは、優れたWebユーザーエクスペリエンスを示す中核的な要素をカバーすることを目的としています。[パフォーマンス](./performance)の章で詳しく説明していますが、ここではECサイトに特化してこれらのメトリクスを見ていきたいと思います。それでは、それぞれの項目を順に見ていきましょう。

#### 最大のコンテンツフルペイント

最大のコンテンツフルペイント（LCP）は、ページのメインコンテンツが読み込まれたと思われる時点を測定し、その結果、そのページがユーザーにとって有用であるかどうかを判断します。これは、ビューポート内に表示される最大の画像やテキストブロックのレンダリング時間を測定することで実現しています。

これは、ページが読み込まれてからテキストや画像などのコンテンツが最初に表示されるまでの時間を測定する最初のコンテンツフルペイント（FCP）とは異なります。LCPは、ページのメインコンテンツが読み込まれるタイミングを測るのに適したプロキシとされています。

Eコマースの場合、この指標は、ユーザーにとってもっとも有用なコンテンツ（ランディングページのヒーローバナー画像、検索/リストページに表示される1つ目の商品の画像、商品詳細ページの場合の商品画像など）を示す非常に良い指標となります。この指標が導入される前は、サイトはRUMソリューションでサイトを明示的に測定しなければなりませんでしたが、この指標により、測定を行うためのリソースや専門知識を持たない人でも測定が可能になりました。

{{ figure_markup(
  image="ecommerce-real-user-largest-contentful-paint-experiences.png",
  caption="リアルユーザー最大のコンテンツフルペイント体験",
  description="もっとも人気のあるEコマースプラットフォームのトップ5について、LCPスコアが良好なサイト数を示す棒グラフです。WooCommerceはデスクトップで21.73％、モバイルで14.27％、Shopifyは64％、47.47％、Magnetoは39.45％、28.17％、Wixは7.46％、7.40％、PrestaShopはデスクトップで53.03％、モバイルで38.08％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1881724605&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

WixとWooCommerceのスコアはとくに低く、主要なプラットフォーム間で大きなばらつきが見られます。もっとも利用されている3つのEコマースプラットフォームのうちの2つであるため、改善すべき点があるようです。

#### 最初の入力までの遅延

最初の入力までの遅延 (FID)は、インタラクティブ性を測定しようとするもので、より重要なのは、ページの処理に追われている間にページが無反応になった場合のインタラクティブ性の障害を測定することです。

{{ figure_markup(
  image="ecommerce-real-user-first-input-delay-experiences.png",
  caption="リアルユーザーの初回入力遅延体験",
  description="もっとも人気のあるEコマースプラットフォームのトップ5のLCPスコアが良いサイトの数を示す棒グラフです。WooCommerceはデスクトップで99.95%、モバイルでは92.36%、Shopify99.96%、96.49%、Magneto99.99%、89.02%、Wix88.30%、37.95%、PrestaShopはデスクトップで99.93%、モバイルでは92.96%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=490091603&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

一般的に、FIDスコアは他のCore Web Vitalsよりも高く、先に見たようにメディアやJavaScriptを多用しているにもかかわらず、ECサイトがこのカテゴリーで高いスコアを維持しているのは有望です。

#### 累積レイアウト変更

累積レイアウト変更（CLS）は、新しいコンテンツが読み込まれてページに配置されたとき、ページがどれだけ「動く」かを測定します。当社のクロールでは、これは「折り目」の上で最初にページが読み込まれた場合に限られますがEコマースサイトではページの折り目の下やその他のインタラクションが、当社の統計が示す以上にCLSへ影響を与える可能性があることを理解する必要があります。

{{ figure_markup(
  image="ecommerce-real-user-cumulative-layout-shift-experiences.png",
  caption="リアルユーザーの累積レイアウトシフト体験",
  description="もっとも人気のあるEコマースプラットフォームのトップ5について、LCPスコアが良好なサイト数を示す棒グラフです。WooCommerceはデスクトップで37.98％、モバイルで51.40％、Shopifyは40.72％、40.55％、Magnetoは38.11％、38.28％、Wixは58.15％、57.47％、PrestaShopはデスクトップで51.56％、モバイルで49.83％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1137826141&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

約半数のEコマースサイトでCLSのスコアが高く、興味深いことに、モバイルとデスクトップでほとんど差がありません。しかし、モバイル機器は通常、電力不足であり、ネットワークの変化が激しいという常識があります。

#### Core Web Vitals全体

Core Web Vitals全体を見ると、どのサイトが3つのコアメトリクスすべてに合格しているのか、次のようになっています。

{{ figure_markup(
  image="ecommerce-real-user-core-web-vitals-exeriences.png",
  caption="Core Web Vitalsのリアルユーザーの体験談",
  description="もっとも人気のあるEコマースプラットフォームのトップ5のLCPスコアが良好なサイト数を示す棒グラフです。WooCommerceはデスクトップで10.72％、モバイルで8.63％、Shopifyは28.78％、21.24％、Magnetoは18.33％、11.14％、Wixは5.23％、3.30％、PrestaShopはデスクトップで30.43％、モバイルで19.10％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=733851599&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

これは先ほどのLCPのチャートと非常によく似ていますが、変動幅がもっとも大きく、この指標で不合格となったサイトがもっとも多かったことから、やや当然のことかもしれません。

## ツール

Eコマースサイトでは、アナリティクス、タグマネージャー、コンセント管理プラットフォーム、アクセシビリティ・ソリューションなどの一般的なツールをどのように使用しているのでしょうか？

### 分析

{{ figure_markup(
  image="top-analytics-solutions-on-ecommerce-sites.png",
  caption="Eコマースサイトにおける分析のトップのソリューション",
  description="Eコマースプラットフォームの分析プロバイダーの上位を棒グラフで表示しています。モバイルでは、Google Analyticsが77％、GA Enhanced eCommerceが22％、Hotjarが6％、New Relicが4％、TrackJsが3％、Yandex.Metrikaが3％、Matomo Analyticsが2％、BugSnagが2％、Liveinternetが2％、comScoreが1％、Quantcast Measureが1％となっています。デスクトップの利用状況はほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=431305389&format=interactive",
  sheets_gid="618573782",
  sql_file="top_analytics_bydevice_vendor.sql"
) }}

これは、55%のサイトがGoogle Analyticsをより有効に活用する機会があることを示しているか、あるいは、サイトによってはチェックアウトファネルでしかGoogle Analyticsを使用しない場合があるため、ホームページに限定している当社の手法の限界を示していると考えられます。

HotJarはサイトの利用状況を分析し、コンバージョン率を向上させるために、Eコマースサイトでよく使用されるツールですが、モバイルサイトでの使用率は6％と非常に低くなっています。

### タグマネージャー

Eコマースサイトでもっとも使用されているタグマネージャーは、依然としてGoogle Tag Managerであり、次いでAdobe Tag Managerとなっています。Google Tag Managerの無料という性質上、これが変わることはないと思われます。また、2020年8月、GoogleはGoogle Tag Managerで<a hreflang="en" href="https://developers.google.com/tag-manager/serverside">サーバーサイドタギング</a>を開始しました。サーバーサイドタギングを実装すると、ECサイトにはわずかなコストがかかりますが、サイトがサードパーティのオーバーヘッドを排除できるため、Total Blocking Time (TBT)、First Input Delay (FID)、Time to Interactive (TTI)などの指標を改善できます。Simon Ahava氏は、<a hreflang="en" href="https://www.simoahava.com/analytics/server-side-tagging-google-tag-manager/">自身のブログ</a>に多くの有益な情報を掲載しており、読者にオススメしています。

サーバーサイド・タグの採用は、移行を容易にするため、サードパーティがサーバーサイド・テンプレートを提供するかどうかにかかっています。この章を書いている時点では、一般に公開されている<a hreflang="en" href="https://tagmanager.google.com/gallery/#/?context=server&page=1">コミュニティ・ギャラリー</a>には、サーバーサイド・テンプレートが見つかりませんでした。しかし、採用が増えれば、クライアントサイドとサーバーサイドのタギングを使用したサイトのパフォーマンススコアを比較することができ、興味深いものになるでしょう。AdobeやSignalのような他のベンダーも同様のサーバーサイドソリューションを提供しており、サイトはパフォーマンス向上のために採用を検討すべきでしょう。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">タグマネージャー</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Tag Manager</td>
        <td class="numeric">48.45%</td>
        <td class="numeric">46.56%</td>
      </tr>
      <tr>
        <td>Adobe DTM</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td>Ensighten</td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>TagCommander</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td>Signal</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>Matomo Tag Manager</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Yahoo! Tag Manager</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Total</th>
        <th scope="col" class="numeric">49.14%</th>
        <th scope="col" class="numeric">47.20%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>{{ figure_link(caption="Eコマースサイトでのタグマネージャーの利用", sheets_gid="2045910168", sql_file="percent_of_ecommsites_using_each_tag_managers.sql") }}</figcaption>
</figure>

<p class="note">注：上記の分析はWappalyzerによる検出に基づいており、<a href="./third-parties">サードパーティー</a>の章で使用されている<a href="./methodology#third-party-web">サードパーティーウェブ</a>データセットを用いた分析とは異なる可能性があります。</p>

### コンセントマネジメント・プラットフォーム

今年の[Privacy](./privacy)の章では、あらゆるタイプのWebサイトにおけるコンセント管理プラットフォームの採用状況を取り上げました。Eコマースサイトでの導入と全サイトでの導入を比較すると、モバイル（Eコマースサイトでは4.2％、全サイトでは4.0％）とデスクトップ（Eコマースサイトでは4.6％、全サイトでは4.4％）の両方で導入率がやや高いです。

{{ figure_markup(
  image="ecommerce-consent-management-platform-adoption.png",
  caption="コンセントマネジメントプラットフォームの採用",
  description="この棒グラフによると、デスクトップサイトでは全体の4.4%、モバイルサイトでは4.0%がConsent Management Platformを使用しているのに対し、Eコマースサイトではそれぞれ4.6%、4.2%となっています。つまり、ECサイトの方がCMPの使用率が若干高いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=285357141&format=interactive",
  sheets_gid="1374272999",
  sql_file="percent_of_ecommsites_using_cmp.sql"
) }}

各種CMPのシェアを見ると、Eコマースサイトの傾向は、[プライバシー](./privacy)の章で取り上げられているすべてのウェブサイトと同様でした。Web Almanacの今後の版では、より多くの国が独自の規制を打ち出しているため、この採用率が増加することを期待しています。また、Web Almanacチームは最近、Wappalyzerに「Content Management Platform」を追加しました。このチームはもっとも人気のあるCMPを追加しましたが、時間の経過とともにさらに多くのCMPが追加され、採用率が増加するものと思われます。

### アクセシビリティソリューション

今年の[アクセシビリティ](./accessibility)章の紹介では、Web Almanacチームがクイックフィックス型のアクセシビリティ・ソリューションを導入することの危険性について語り、Lainey Feingold氏の素晴らしい記事、<a hreflang="en" href="https://www.lflegal.com/2020/08/quick-fix/">Web Accessibility Quick Fix Overlaysを避けるHonor the ADAを紹介しています。</a>。

推奨はされていませんが、Eコマースサイトにおけるこのようなソリューションの利用状況を調べたところ、モバイルサイトの0.47％、デスクトップサイトの0.54％がこのようなソリューションを導入していることがわかりました。

本章で採用した現在の方法では、トップレベルのEコマースサイトが、デザインによるアクセシビリティの実現を目指さずに、このような手っ取り早い方法を取っているかどうかを簡単に調べる方法がありません。将来的には、HTTP Archiveのデータを、International retailingによるTop 500 UK sitesなどの出版物と組み合わせることで、この点を確認することができるでしょう。

### AMP採用

{{ figure_markup(
  caption="Eコマースサイト（モバイル）でのAMP利用。",
  content="0.61%",
  classes="big-number",
  sheets_gid="1317152621",
  sql_file="pct_ampusage_bydevice_vendor.sql"
)
}}

SEOの章では、[全ウェブサイトにおけるAMPの使用状況](./seo#amp)の統計を取り上げました。本章では、EコマースサイトにおけるAMPの採用状況を見ていきます。AMPはまだすべてのEコマースのユースケースをサポートしていないため、EコマースサイトでのAMP採用率は低いままです（モバイルで0.61％、デスクトップで0.66％）。また、今回の分析では、Wappalyzerによる検出に頼っているため、AMPが別ドメインとして実装されているEコマースサイトが`<link rel="amphtml"...>`要素を使って二重にカウントされている可能性があります。このようなドメインは、ECサイトの合計を算出する際にも2回カウントされるため、パーセンテージを見る上で問題となることはありません。

また、EコマースサイトのCRUXパフォーマンスを、AMP対応サイト（`amphtml`属性を使用して異なるドメインに実装されている場合）と比較することも検討しました。このような分析はAMPドメインのパフォーマンスに有意な差があったかどうかを確認するのに役立ちますが、EコマースウェブサイトにおけるAMPの採用率が低いため、このような分析で意味のある結果を得られない可能性があり、将来的に採用率が上昇した場合に分析を延期しました。

### Webプッシュ通知

マーケターはプッシュ通知が大好きですが、筆者の経験によると、2015年にChromeではじめて<a hreflang="en" href="https://developers.google.com/web/updates/2015/03/push-notifications-on-the-open-web">Push API</a>が導入されたにもかかわらず、Webプッシュ通知に関するマーケターの認知度はまだ非常に低いようです。私たちは、ECサイトにおける（サービスワーカーなどの技術を使って可能な）Webプッシュ通知の採用状況を調べてみました。CRUXの通知許可データの一部として、プッシュ受付率やプッシュプロンプトの解除率などの指標にアクセスしています。このデータがどのように取得され、どのような指標が得られるかについては、<a hreflang="en" href="https://developers.google.com/web/updates/2020/02/notification-permission-data-in-crux">このGoogleの記事</a>を参照してください。

当社の分析では、ウェブプッシュ通知を利用しているのは、デスクトップのEコマースサイトでは0.68%、モバイルのEコマースサイトでは0.69%に過ぎないことがわかりました。プッシュ通知に関しては、お客様がプッシュ通知を便利だと感じることが重要です。そのためには、カスタマージャーニーの適切なタイミングで許可を求め、無関係な通知をユーザーに浴びせないことが重要です。プッシュ通知に対する顧客の疲労に対処するため、Chromeは、許可率が非常に低いサイトを自動的に<a hreflang="en" href="https://blog.chromium.org/2020/05/protecting-chrome-users-from-abusive.html">より静かな通知UI</a>に登録します（ただし、正確な閾値はまだ定義されていません）。受け入れ率がコントロールグループ内で改善されると、そのサイトは標準的なUIに戻されます。

PJ Mclachlan(Product Manager, Google)は、静かな通知UIへ陥らないよう安全な領域にいるため、<a hreflang="en" href="https://www.youtube.com/watch?v=J_t8c9HOjBc">最低でも50%の受け入れ率を目指す</a>ことと、80%以上の受け入れ率を目指すことについて話しています。Eコマースサイトの通知受け入れ率の中央値は、モバイルで13.6%、デスクトップでは13.2%です。中央値では、この受け入れ率には大きな問題があります。90パーセンタイルレベルでも、あまり良い数字ではありません（モバイル：36.9％、デスクトップ：36.8％）。Eコマースサイトは、この <a hreflang="en" href="https://www.youtube.com/watch?v=riKmez3sHaM">トークを参考にして、プッシュの受け入れ率を健全に保ち</a>、今後の虐待的な通知の変更に不意打ちを食らわないようにするための推奨パターンを確認できます。

{{ figure_markup(
  image="web-push-notification-acceptance-rates.png",
  caption="Webプッシュ通知の受け入れ率",
  description="Webプッシュ通知の受け入れ率を棒グラフで表したもの、モバイルでは10パーセンタイルが4％、25パーセンタイルが9％、50パーセンタイルが14％、75パーセンタイルが20％、90パーセンタイルが37％、100パーセンタイルが89％となっています。デスクトップの合格率はほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1062364223&format=interactive",
  sheets_gid="2129008669",
  sql_file="webpushstats_ecommsites.sql"
) }}

## 将来の分析機会

また、Playストアの`.well-known/assetlinks.json`やappストアの`.well-known/apple-app-site-association`のようなネイティブアプリ関連の標準を利用して、Eコマースサイトがネイティブアプリを採用するかどうかも興味深いところです。GoogleはTrusted Web Activityを使ってPWAを簡単に実現できるようにしていますが、現在のところ、どれだけのサイトがこの手法を使ってplay storeにPWAを登録しているかについての統計は公開されていません。

今年の[SEO](./seo)の章では、`hreflang`と`lang`属性、`content-language`HTTPヘッダーを使用したウェブサイトの分析が含まれています。これに加えて、Global-e、Flow、Borderfreeなどの越境ECソリューションをWappalyzerにより検出することで、Eコマースサイトの越境ECの側面を見る機会が得られます。現在、Wappalyzerには、「越境EC」のための独立したカテゴリがなく、したがって、この種の分析はそのようなソリューションのリポジトリを自分たちで構築しない限り、不可能です。

Wappalyzerでは決済ソリューション（Apple Pay / PayPal / ShopPayなど）の検出も行っていますが、実装やソリューションの種類によってはホームページを見ただけでは検出できないこともありますが、ホームページを見ただけで検出できるソリューションについては、このような分析を行うことで前年比の傾向を見ることができます。

## 結論

Covid-19は、2020年のEコマースの成長を大幅に加速させ、多くの中小企業がオンラインプレゼンスを迅速に確立し、ロックダウン中も取引を継続する方法を見つけなければなりませんでした。WooCommerce、Shopify、Wix、BigCommerceなどのプラットフォームは、より多くの中小企業をオンライン化する上で非常に重要な役割を果たしました。Covid-19では、ブランドによるD2C（Direct to Consumer）の提供も開始され、これは今後も増加すると予想されます。Covid-19の影響は、今年のWeb Almanacでは完全には現れないかもしれません。というのも、これらの新規事業が分析に使用するCRUXデータセットの一部になるためには、まず一定のトラフィック閾値を超える必要があるからです。この理由により、来年の分析でも継続的な成長が見られるかもしれません。

また、Webプッシュ通知を利用しているマーケティングチームは、CRUXを利用して通知の統計情報を確認し、今後の通知の不正利用に巻き込まれないように注意してください。タグマネージャーは、マーケティングチームとエンジニアリングチームの間に多くの摩擦をもたらしているようです。Google Tag Managerのサーバーサイドタギングのようなソリューションは、ある程度浸透すると思われますが2021年に多くの変化があるとは思われず3～5年はかかると思われますが、コミュニティはこのエコシステムをさらに進化させるために、それぞれのサードパーティに互換性のあるソリューションを提供するよう求める必要があるでしょう。

今回の分析はホームページのデータのみを対象としているという制限を忘れてはならないが、来年の分析では他にどのようなことを取り上げるべきか、コミュニティの皆様からのご意見をいただきたい。上記のセクションでは、さらなる分析の可能性をいくつか取り上げていますが、<a hreflang="en" href="https://discuss.httparchive.org/t/2052">ご意見・ご感想をお待ちしています</a>。
