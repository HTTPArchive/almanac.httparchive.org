---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Eコマース
description: 2021 Web AlmanacのEコマースの章では、Eコマースプラットフォーム、ページ重量、画像、サードパーティ、コアウェブバイタルとlighthouseパフォーマンスメトリクス、SEO、PWAをカバーしています。
hero_alt: Hero image of a Web Almanac character at a super market checkout loading items from a shopping basket onto the conveyor belt while another character payes with a credit card.
authors: [bobbyshaw]
reviewers: [rockeynebhwani, alankent, soulcorrosion, fili]
analysts: [rrajiv]
editors: [shantsis]
translators: [ksakae1216]
bobbyshaw_bio: Tomは、野心的な小売業者のためのeコマース代理店である<a hreflang="en" href="https://www.space48.com">Space 48</a>のイノベーション・ディレクターです。彼は、Ordnance Survey、Betty's & Taylors of Harrogate、Smythsonなどのブランドで10年以上eコマースの経験を積んできました。現在は、BigCommerceでマーチャント向けのアプリ群を立ち上げるためのイニシアチブをリードしています。
results: https://docs.google.com/spreadsheets/d/1HCfrXJ52lV46UvxOvDVjJj70fOeFVrTTD8DUm0tPVXE/
featured_quote: 2020年の第2四半期から第3四半期にかけて、eコマース機能を持つサイトの割合に測定可能な増加が見られました。この増加率は2021年まで維持されていません。実際、モバイルでのECサイトの割合は21.27%から19.49%に減少しており、ECがウェブ全体と同じペースで成長していないことが示唆されています。
featured_stat_1: 19.49%
featured_stat_label_1: モバイルサイトがECサイトと認識される
featured_stat_2: 5.93%
featured_stat_label_2: もっとも普及しているECプラットフォームであるWooCommerceを利用しているサイトの割合
featured_stat_3: 11%
featured_stat_label_3: WooCommerceサイトのうち、コアウェブバイタルの体験が「良好」である割合
---

## 序章

この章では、Web上のeコマースの状況を確認します。eコマースサイトとは、物理的またはデジタルな製品を販売する「オンラインストア」です。オンラインストアを構築する場合、いくつかのタイプから選択できます。

* **ソフトウエア・アズ・ア・サービス (SaaS)** Shopifyのようなプラットフォームは、オンラインストアを開設し、管理するために必要な技術的知識を最小限に抑えることができます。これは、コードベースへのアクセスを制限し、ホスティングを心配する必要をなくすことによって実現されています。
* **プラットフォーム・アズ・ア・サービス (PaaS)** Adobe Commerce (Magento)などのプラットフォームは、最適化されたテクノロジースタックとホスティング環境を提供しながらも、コードベースへのフルアクセスを可能にします。
* **セルフホスティング** WooCommerceなどのプラットフォーム
* また、CommerceToolsのような「APIアズ・ア・サービス」である**ヘッドレス**プラットフォームも存在します。同社は、eコマースのバックエンドをSaaSとして提供し、小売業者はフロントエンド体験の構築とホスティングを担当します。

プラットフォームは、これらのカテゴリのうちの1つ以上に分類される場合があることに注意してください。たとえば、Shopwareには、SaaS、PaaS、セルフホスティングのオプションがあります。

## プラットフォーム検出

私たちは、<a hreflang="en" href="https://github.com/AliasIO/wappalyzer/">Wappalyzer</a> というオープンソースのツールを使って、Webサイトが使用している技術を検出しました。コンテンツ管理システム、eコマースプラットフォーム、JavaScriptのフレームワークやライブラリなどを検出できます。

今回の分析では、以下のいずれかに該当する場合は、eコマースサイトであると判断しました。

* 既知のeコマース・プラットフォームの使用（制限事項参照）
* オンラインストアを示唆する技術の使用（例：<a hreflang="en" href="https://developers.google.com/tag-manager/enhanced-ecommerce">Google Analytics Enhanced Ecommerce</a>）。

[方法論](./methodology)について詳しく説明しています。

### 制限事項

この方法論には、その精度に影響を与えるいくつかの限界があります。

まず、ECサイトを認識する能力に限界があります。

* Wappalyzerは、eコマースプラットフォームを検出したのでしょう。
* PayPalのような支払いプロセッサの検出は、ウェブサイトをeコマースとみなすには不十分でした。これは、オンラインショップではないオンライン決済を受け付けるサイト（例：B2B SaaS）が存在するためです。
* eコマースプラットフォームがウェブサイトのサブディレクトリ内にホストされている場合、ホームページのみが分析対象となるため、検出することはできません。
* ヘッドレス実装は、使用中のプラットフォームを検出する能力を低下させます。eコマースプラットフォームを検出する主な方法の1つは、共通のHTMLまたはJavaScriptコンポーネントを認識することです。そのため、ECプラットフォームのフロントエンドを使用しないヘッドレスウェブサイトは、ECとして検出することが難しくなります。

次に、指標や解説の正確性は、以下のような制約にも影響される可能性があります。

* このような傾向は、検出精度の変化に影響されたものであり、業界の動向を完全に反映したものではない可能性があります。たとえば、あるeコマース・プラットフォームは、検出方法が改善されたため、より普及したように見えるかもしれません。
* すべてのウェブサイトのリクエストは、米国から行われました。ウェブサイトが地理的な位置に基づいてより適切なウェブサイトにリダイレクトされる場合、最終的な位置が分析されます。
* クロールしたサイトは、Chromeブラウザーのユーザーが訪問するウェブサイトに偏りがあるChrome UX Reportからのものです。

## Eコマースプラットフォーム

我々の分析では、モバイルとデスクトップのウェブサイトを考慮しました。これらのサイトは、Chromeユーザーが積極的に訪問しているサイトです。詳しくは、[方法論](./methodology)をご覧ください。訪問したウェブサイトのほとんどは両方の結果セットに含まれていますが、中には片方だけに含まれているものもあります。モバイルとデスクトップの統計情報を共有することが多いです。変動が少ない場合は、どちらか一方のみを表示することもあります。この場合、とくに断りのない限り、モバイルの指標のみが表示されます。

モバイルの分析では、750万サイトから回答を得て、そのうち150万サイト（19.5%）が何らかの形でeコマース機能を有していることがわかりました。同様にデスクトップ分析では、630万サイトから回答を得て、130万サイト（20.2%）が、eコマースであることが判明しています。

{{ figure_markup(
  image="ecommerce-comparison-2019-to-2021.png",
  caption="Eコマース比較2019年～2021年。",
  description="ECサイトのモバイル検出率は、2019年の9.41%から21.27%に増加し、2021年には19.49%に微減していることが棒グラフで示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1127869998&format=interactive",
  sheets_gid="1519192867",
  sql_file="pct_ecommsites_bydevice_compare20202021.sql"
) }}

eコマースサイトの全体のシェアは、21.3％（デスクトップは21.7％）であった昨年のレポートに比べ、モバイルでは1.8％縮小した（デスクトップは1.6％）。一方、eコマースサイトの数は依然として増加しており、昨年と比較して今年はデスクトップで4.5%増加（モバイルでは8.3%）しています。しかし、この増加は、Chromeユーザーが訪問するサイトのリスト全体の増加には追いつきませんでした。

モバイルサイトの9.45%がeコマースだった[2019年の結果](../2019/ecommerce#プラットフォーム検出)と比較すると、ここ1年の変化は僅少ですが、ここ2年は劇的かつ持続的に増加していることが分かります。

しかし、これをCOVID-19に反応して電子商取引が拡大した証拠と考えるべきではないでしょう。[昨年も報告](../2020/ecommerce#Eコマースプラットフォーム)しましたが、この増加は、eコマース・プラットフォームを検出する能力が向上したことによるものです。プラットフォームカバレッジの拡大から、Google Analytics Enhanced Ecommerceの存在など、サイトがeコマースであることを示す二次的なシグナルも使用するようになりました。

### トップeコマース・プラットフォーム

当社の分析では、215のEコマース・プラットフォームが検出され、昨年の145と比較して48%の増加となっています。しかし、デスクトップとモバイルの両方で0.1%以上利用されているプラットフォームは、わずか10にとどまっています。

{{ figure_markup(
  image="top-ecommerce-platforms.png",
  caption="トップクラスのeコマース・プラットフォーム",
  description="eコマースプラットフォームの利用率を棒グラフで見ると、モバイルではWooCommerceが5.93%、次いでShopify（2.72%）、PrestaShop（0.91%）、Magento（0.72%）、Wix eCommerce（0.65%）、Squarespace Commerce（0.39%）、 BigCommerce（0.19%）、Shopware（0.14%）、Cafe24（0.09%）、Loja Integrada（0.10%）となります。デスクトップでの利用も同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1081912666&format=interactive",
  sheets_gid="1561012463",
  sql_file="top_vendors.sql",
  width=600,
  height=500
) }}

<a hreflang="en" href="https://woocommerce.com/">WooCommerce</a>は、<a hreflang="en" href="https://wordpress.org/">WordPress</a> のプラグインで、全ウェブサイトの約6％が使用しているもっとも普及しているeコマース・プラットフォームです。これは、モバイルでのeコマース市場の30%に相当します。

<a hreflang="en" href="https://shopify.com/">Shopify</a>はSaaS型ソリューションで、WooCommerceの約半分のサイト数があり、2番目に普及しているソリューションです。モバイルでのeコマース市場のシェアは14％です。<a hreflang="en" href="https://www.prestashop.com/">PrestaShop</a> はオープンソースのプラットフォームで、WooCommerceの6分の1程度の普及率で、3番目に使われているプラットフォームです。

上位10社のうち4社は、オープンソースやセルフホスティングのエディションを持っています。WooCommerce、PrestaShop、<a hreflang="en" href="https://magento.com/">Magento</a> 、<a hreflang="en" href="https://www.shopware.com/">Shopware</a> の4種類。プラットフォームのバージョンの違いを検知しないため、MagentoやShopwareのオープンソース版と商用版の区別がつきません。

10のプラットフォームのうち6つがSaaSである（またはSaaS版がある）。Shopify、<a hreflang="en" href="https://www.wix.com/ecommerce/website">Wix eCommerce</a>、<a hreflang="en" href="https://www.squarespace.com/ecommerce-website">Squarespace Commerce</a>、<a hreflang="en" href="https://www.bigcommerce.com/">BigCommerce</a>、Shopwareと<a hreflang="pt" href="https://lojaintegrada.com.br/">Loja Integrada</a>。

<aside class="note">注：2021年7月のHTTP Archiveデータに、<a hreflang="en" href="https://www.opencart.com/">OpenCart</a>のサイト数が過小に報告される<a hreflang="en" href="https://github.com/HTTPArchive/httparchive.org/issues/414">問題</a>が発生しました。9月の結果では、10,801のOpenCartサイトが検出されたことは認めるに値します。もし7月に同数のOpenCartサイトが検出されていたとしたら、人気の点ではBigCommerceとShopwareの間に位置することになります。</aside>

### ウェブサイトの人気順で上位のeコマース・プラットフォーム

今年は、<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report/">Chromeユーザーエクスペリエンスレポート</a> が各ウェブサイトの人気ランキングを提供しました。これにより、市場のさまざまなセグメントにおける人気度によって、上位のeコマース プラットフォームを分類することができました。"All "は、モバイル向けプロファイリング750万サイト、デスクトップ向け630万サイトすべてを指します。

{{ figure_markup(
  image="top-5-ecommerce-platforms-by-crux-rank.png",
  caption="CRUXランクによるeコマースプラットフォームのシェアトップ5",
  description="上位1万サイト、上位10万サイト、上位100万サイト、全サイト内でのECプラットフォームの利用状況を示す棒グラフです。全サイトとは対照的に、モバイルでのトップ10万では、Magentoが1.21%、Shopify 0.88%、WooCommerce 0.56%、PrestaShop 0.33%、Wix eCommerce 0%のシェアを獲得しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=211149833&format=interactive",
  sheets_gid="1491793974",
  sql_file="top_vendors_crux_rank.sql"
) }}

ウェブサイトがランク付けされることで、市場のさまざまなセグメントでプラットフォームの人気がどのように変化するかを観察できます。

* WooCommerceは、全体でもっとも普及しているECプラットフォームで、上位100万位以内に入っています。
* Shopifyは、分析したすべてのサイトと比較して、上位100万位以内（割合として）のサイトにおいてより人気があります。
* 上位10,000サイトのうち、Magentoは5つの中でもっとも普及している。
* Wixのeコマースサイトは、上位10万位以内に確認されませんでした。100万位以内では、モバイルの164サイトのみ確認されました。WixのEコマースサイトのほぼ全体が、100万位以下のサイトであることがわかります。

#### 上位100万サイト

この結果を見るもう1つの方法は、各階層のランキングの中でもっとも普及しているプラットフォームを考えることです。たとえば、上位10,000サイトと上位100万サイトでは、異なる傾向が見られると予想されます。

{{ figure_markup(
  image="top-ecommerce-platforms-top-1m-sites.png",
  caption="100万サイトのトップeコマース・プラットフォーム",
  description="上位100万サイト内のECプラットフォームの利用率を降順で示した棒グラフ。モバイルでは3.49%がWooCommerce、2.76%がShopify、1.48%がMagento、1.17%がPrestaShop、0.23%がShopware、0.22%がBigCommerce、0.15%がSalesforce Commerce Cloud、0.14%がVTEX、0.10%がShoper、最後に0.10%がトレイとなっています。デスクトップでの使用率は非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=86873602&format=interactive",
  sheets_gid="1491793974",
  sql_file="top_vendors_crux_rank.sql",
  width=600,
  height=500
) }}

上位100万サイトでは、WooCommerceとShopifyがそれぞれモバイルでのリクエストの3.49%と2.76%を占め、依然として主要なプラットフォームとなっています。しかし、分析したすべてのサイトと比較すると、両者の差はかなり小さくなっています。モバイルでの全サイトリクエストのうち、WooCommerceはShopifyの2倍以上であったのに対し、上位100万サイトでは25%増にとどまっています。

また、MagentoがPrestaShopを抑えて3位となったことも確認できます。Wix eCommerceとSquarespace eCommerceは上位7つのプラットフォームから外れています。代わりに、Shopware、BigCommerce、そして<a hreflang="en" href="https://www.salesforce.com/uk/products/commerce-cloud/overview/">Salesforce Commerce</a>が先行していることが分かります。

#### 上位10万サイト

{{ figure_markup(
  image="top-ecommerce-platforms-top-100k-sites.png",
  caption="上位10万サイトのトップeコマース・プラットフォーム",
  description="上位10万サイト内でのECプラットフォームの利用率を降順に示した棒グラフ。モバイルでは、1.21%がMagento、0.88%がShopify、0.63%がSalesforce Commerce Cloud、0.56%がWooCommerce、0.33%がPrestaShop、0.30%がSAP Commerce Cloud、0.28%がVTEX、0.10%がHCL Commerce、0.08%がShopware、最後がAmazon WebStoreとなっています。デスクトップでの利用は非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=942112971&format=interactive",
  sheets_gid="1491793974",
  sql_file="top_vendors_crux_rank.sql",
  width=600,
  height=500
) }}

CrUXランクによる上位10万サイトを考慮すると、その様相はかなり大きく変化します。Magentoはモバイルサイトの1.21%を占め、もっとも普及しているeコマースプラットフォームベンダーとなりました。Shopifyは2位（0.88%）を維持し、Salesforce Commerce Cloudは3位（0.63%）となっています。<a hreflang="en" href="https://www.sap.com/uk/products/commerce-cloud.html">SAP Commerce Cloud</a> はリーダーボードを6位に上げ、この分野でのエンタープライズ・プラットフォームの競争力が高まっていることを示しています。

#### 上位10,000サイト

{{ figure_markup(
  image="top-ecommerce-platforms-top-10k-sites.png",
  caption="上位10,000サイトのトップeコマース・プラットフォーム",
  description="上位10,000サイト内でのECプラットフォームの利用率を降順で示した棒グラフ。モバイルでは、SAP Commerce Cloudが0.70%、Salesforce Commerce Cloud 0.68%、Magento 0.32%、HCL Commerce 0.26%、Oracle Commerce 0.13%、Shopify 0.12%、WooCommerce 0.10%、VTEX 0.10%、Amazon Webstore 0.10%、そしてSummerCart 0.07%となっています。デスクトップでの利用もほぼ同じような感じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1147944186&format=interactive",
  sheets_gid="1491793974",
  sql_file="top_vendors_crux_rank.sql",
  width=600,
  height=500
) }}

上位10,000サイトにおけるeコマースプラットフォームを搭載したサイトのシェアは、明らかに小さくなっています。

Salesforce Commerce CloudとSAP Commerceは、同程度の数のeコマースサイト（モバイルではそれぞれ0.70%と0.68%）をリードし、その力を発揮しています。

リーダーボードを見下ろすと、この分野ではほとんどサプライズはありません。上位2位から大きく離れているのはMagento（Adobe製品）で、上位10,000サイトでのシェアは0.32%です。それに続くのが、<a hreflang="en" href="https://www.hcltechsw.com/commerce">HCL Commerce</a>（以前はIBM WebSphere Commerceとして知られていた）、<a hreflang="en" href="https://www.oracle.com/uk/cx/ecommerce/">Oracle Commerce</a>です。これらのプラットフォームは、いずれも大企業に適していると一般的に考えられています。

### COVID-19の影響

年度をまたいで発見されたECサイトの総数を比較することは困難です。前述したように、ECサイトかどうかを検出する能力が大幅に向上したためです。Google Analytics Enhancedeコマースインテグレーションのような二次的なシグナルの使用によるところもあります。

そこで、代わりに[昨年のレポート](../2020/ecommerce#COVID-19のEコマースへの影響)では、少数のプラットフォームに焦点を当て、その利用状況がどのように変化したかを確認しました。2020年前半の初期の兆候として、ShopifyとWooCommerceの利用が測定可能で顕著に増加していることが分かりました。Magentoなどの他のプラットフォームが同じような伸びを見せなかったのに対し、2020年1月から2020年7月にかけて20％台の伸びを見せました。これらのプラットフォームは参入コストの低さや使いやすさで知られていますがMagentoは、そうではありません。

2021年に向けて、世界中の人々や企業は適応を続けています。2020年の米国における電子商取引は、<a hreflang="en" href="https://www.digitalcommerce360.com/article/coronavirus-impact-online-retail/">商務省の報告書</a>によると、32.4%の収益成長率を示しました。英国では、<a hreflang="en" href="https://internetretailing.net/industry/industry/ecommerce-grew-by-46-in-2020---its-strongest-growth-for-more-than-a-decade--but-overall-retail-sales-fell-by-a-record-19-ons-22603">Office of National Statistics報告</a> が46%の伸びを示しています。

{{ figure_markup(
  image="ecommerce-vendor-growth-covid-19-impact.png",
  caption="Eコマースプラットフォームの成長、Covid-19の影響",
  description="人気のある5つのeコマース・プラットフォームの成長を示す折れ線グラフです。WooCommerce、Shopify、PrestaShop、Magento、Wix eCommerceです。WooCommerceは、2020年2月と6月、7月に顕著な上昇を見せ、安定した成長を示しています。Shopifyも同様ですが、その割合は少なく、他の3つにそのような影響はあまり見られません。2020年第3四半期以降では、目立った増加は少なくなっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1480107860&format=interactive",
  sheets_gid="1789671097",
  sql_file="ecomm_vendors_covid_growth.sql"
) }}

また、2019年2月から2021年7月までの間、月単位で結果を見ることもできる。ただし、結論を出す前に、プラットフォームの検出問題がシェアの変化の原因になっていることがあることに注意しなければならない。具体的な問題としては、2021年2月から6月にかけてのWooCommerceの市場シェアの低下があり、これは<a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/issues/1843">バグ</a>と認定されました。）

それを考慮すると、やはりモバイルでは注意すべきかもしれません。

* WooCommerceは3.48%から5.93%に成長した。この成長の大部分は、欧米諸国が実施したCOVID-19規制の直後に発生したものです。
* Shopifyの成長率は2020年に大きく上昇し、同年に1.61%から2.50%に成長しました。しかし、この成長率は持続していない。
* また、この間、以前はShopifyと競合していたMagentoがPrestaShopを下回るようになったことがわかる。全サイトのシェア1.25%から0.72%に移行。

筆者の視点では、中小企業がECチャネルを追加する初動が早かったと思います。これは、WooCommerceやShopifyといった費用対効果が高く使いやすいプラットフォームの利用により、2020年前半にほぼ達成されました。

しかし、報告されたオンライン収益の増加の大部分は、すでにeコマースに対応していた企業が恩恵を受けたものであると予想されます。

## Eコマースでのユーザー体験

eコマースサイトの目的は、収益を上げることです。この目的を達成するために、企業は複数の戦略を採用します。たとえば、幅広い購買行動を考慮した機能豊富な体験を提供することが挙げられます。また、ウェブサイトを可能な限り高速化することも必要でしょう。この2つの戦略が目的に対してどのように作用するかは明らかですが、同時に互いに作用することもあります。

後ほど、機能豊富な体験を実現するためのツール＆タクティクスをご紹介します。

まず、サイトの技術的な品質とパフォーマンスを評価します。どちらか一方を決定的に評価できる単一の指標やツールはないため、複数の指標を用いました。

* [Google Lighthouse](./methodology#lighthouse)
* [Chrome UXレポート](./methodology#chrome-ux-report)から見るコアウェブバイタル
* [WebPageTest](./methodology#webpagetest)

### Lighthouse

ウェブページの技術的な品質を測定する方法の1つに、<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Google Lighthouse</a>を使用する方法があります。lighthouseテストでは、5つのカテゴリーごとに100点満点のスコアが提示されます。下図は、リクエストされたすべてのEコマースサイトの各カテゴリーのスコアの中央値を示しています。

{{ figure_markup(
  image="median-lighthouse-scores-for-ecommerce-websites.png",
  caption="EコマースサイトのLighthouseスコア中央値",
  description="EコマースサイトのLighthouseスコアの中央値を示す棒グラフ。パフォーマンススコアの中央値は100点満点中22点、アクセシビリティスコアの中央値は83点、PWAスコアの中央値は42点、SEOスコアの中央値は90点、ベストプラクティススコアの中央値は73点です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=401880767&format=interactive",
  sheets_gid="669431111",
  sql_file="median_lighthouse_score_ecommsites.sql"
) }}

ここでもっとも重要なポイントは、eコマースサイトがパフォーマンスに関して良い灯台のスコアを獲得するのに苦労していることです。これは、このカテゴリーで良いスコアを獲得するためには、より大きなレベルの努力が必要なためと思われます。

### Lighthouseのプラットフォーム別スコア

Lighthouseのスコアをeコマースプラットフォームのベンダー別に分類すると、比較的ばらつきが少なくなっています。このことは、各ECプラットフォームが、これらの分野において、すぐに使える同様の機能を提供していることを示唆しています。

#### パフォーマンス

パフォーマンスは、システムの創発的な特性であり、新機能のように実装できるようなものではありません。新しい機能を追加するように実装すればよいというものではありません。単純に考えれば、機能を増やせば増やすほど遅くなるということです。

同時に、サイトが高速だとコンバージョン率の向上につながることは、もはや常識です。では、なぜEコマースサイトのパフォーマンススコアがこれほど低いのでしょうか？その理由の1つは、サイトスピードや会話率の統計が、eコマースビジネスが直面する意思決定を考慮せずに常に提供されていることかもしれません。毎年、収益の拡大が求められると、収穫逓減の法則でも、コンバージョン率の向上はスピードの向上だけでは対応できなくなります。これは、eコマース体験に対する消費者の高い要求と相まって、より多くの機能が優先される状況になっています。

さらに、機能を含めるかどうかの決定には、多くの場合、より多くのニュアンスがあります。たとえば、ライブチャットウィジェットの利点は、パフォーマンスへの影響を上回るかどうか？答えは、文脈によって変わるのでしょうか？それが遅延ロードされていることを確認するために、開発者がそれをインストールするのを待つべきでしょうか、それとも、Googleタグマネージャーを使用するだけでしょうか？他のもののためにその開発時間を使用しないことの機会費用はいくらですか？

パフォーマンスを別の見方をすれば、<a hreflang="en" href="https://www.investopedia.com/terms/t/tragedy-of-the-commons.asp">コモンズの悲劇パラダイム</a> に苦しむ共有リソースであるということです。プロジェクトのスタート時には最高レベルにあり、時間の経過とともに、消費する権利を持つさまざまなステークホルダーからの要求で枯渇します。

最良の結果を得られるのは、サイトのスピードとユーザー体験のバランスを取ることができる企業でしょう。そのような企業は、最初のページロードにおける機能の影響を最小限に抑えつつ、優れたユーザー体験を提供できます。

{{ figure_markup(
  image="median-lighthouse-performance-scores-for-ecommerce-websites.png",
  caption="LighthouseのECサイトパフォーマンススコアの中央値",
  description="EコマースサイトのLighthouseパフォーマンススコアの中央値を、Eコマースプラットフォーム別に、プラットフォームの人気順に並べた棒グラフです。各プラットフォームのモバイルでのパフォーマンススコアの中央値は以下の通りです。WooCommerce（20）、Shopify（27）、PrestaShop（22）、Magento（18）、Wix eCommerce（27）、Squarespace Commerce（16）、BigCommerce（25）、Shopware（20）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1706895252&format=interactive",
  sheets_gid="1379786622",
  sql_file="median_lighthouse_score_ecommsites.sql"
) }}

プラットフォーム間でもっとも差があったのは、パフォーマンススコアでした。ShopifyとWix eCommerceはもっともパフォーマンスが高く、モバイルでのライトハウスパフォーマンススコアの中央値は27/100でした。もっとも低いスコアは、Loja Integradaの6/100、Squarespace Commerceの16/100、そしてMagentoの18/100でした。繰り返しになりますが、これらはすべて悪いスコアです。

Shopifyは最近、すべての新しいマーケットプレイスのテーマで、Lighthouseの平均パフォーマンススコア60/100を達成するという<a hreflang="en" href="https://shopify.dev/themes/store/requirements">要件を追加</a>したことを高く評価しています。このことが、今後の分析結果にどのような影響を与えるか、興味深いところです。

#### アクセシビリティ

{{ figure_markup(
  image="median-lighthouse-accessibility-scores-for-ecommerce-websites.png",
  caption="EコマースサイトのLighthouseアクセシビリティスコアの中央値",
  description="EコマースサイトのLighthouseアクセシビリティスコアの中央値を、Eコマースプラットフォーム別に、プラットフォームの人気順に並べた棒グラフです。各プラットフォームのモバイルでのアクセシビリティスコアの中央値は、以下の通りです。WooCommerce（85）、Shopify（85）、PrestaShop（75）、Magento（80）、Wix eCommerce（88）、Squarespace Commerce（90）、BigCommerce（78）、Shopware（85）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=985330269&format=interactive",
  sheets_gid="1379786622",
  sql_file="median_lighthouse_score_ecommsites.sql"
) }}

上位8つのプラットフォームは、アクセシビリティの中央値で非常によく似たスコアを出しています。また、アクセシビリティに関する法律や認知度が向上するにつれて、さらに改善されることが期待されます。

プラットフォームが標準テーマのアクセシビリティを向上させることで改善されるかもしれません。たとえば、BigCommerceでは、<a hreflang="en" href="https://support.bigcommerce.com/s/blog-article/aAn4O000000CdJDSA0/improvements-to-accessibility-coming-in-cornerstone-52?language=en_US">デフォルトのテーマを更新</a>して、<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/#intro">ウェブサイトコンテンツのアクセシビリティ</a>ガイドライン（かWCAG）2.1 Level AA標準に適合させています。

また、プラットフォームは、より広範なアプリやテーマのコミュニティに対して、高水準の技術的品質を提供するように促すことができます。<a hreflang="en" href="https://www.shopify.com/partners/blog/theme-store-accessibility-requirements">Shopify</a>は、新しいマーケットプレイスのテーマに対して、Lighthouseアクセシビリティスコアの最低要件を発表しました。

ウェブ全体のアクセシビリティ・スコアに関するより詳細な調査については、[アクセシビリティ](./accessibility)の章をお読みください。

#### PWA

すべてのEC事業者にとって、PWA対応は優先順位が低いようです。その理由は2つ考えられるかもしれません。

* ホーム画面に追加するようなPWAの機能が消費者に採用されているかどうかの調査はほとんど行われていません。
* iOSのSafariはPush Notification APIやホーム画面にPWAを追加する機能をサポートしていない。iOSの市場シェアが大きいため、PWAへの投資の見返りが少なくなっています。

#### ベストプラクティス

{{ figure_markup(
  image="median-lighthouse-best-practices-scores-for-ecommerce-websites.png",
  caption="ライトハウスのベストプラクティスのスコア（中央値）（eコマースサイトの場合",
  description="EコマースサイトのLighthouseベストプラクティススコアの中央値を、Eコマースプラットフォーム別に、プラットフォームの人気順に並べた棒グラフです。各プラットフォームのモバイルでのベストプラクティススコアの中央値は以下の通りです。WooCommerce（80）、Shopify（73）、PrestaShop（73）、Magento（73）、Wix eCommerce（93）、Squarespace Commerce（87）、BigCommerce（73）、Shopware（87）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=2076322933&format=interactive",
  sheets_gid="1379786622",
  sql_file="median_lighthouse_score_ecommsites.sql"
) }}

Wix Ecommerceは、ライトハウスのベストプラクティススコアの中央値で93/100ともっとも高いスコアを獲得しています。小規模ビジネスに特化しているため、平均してよりシンプルなユーザー体験を提供している可能性がありますが、これほど高いスコアを獲得したことは印象的です。

### コアウェブ・バイタル

2020年、Googleはコアウェブ・バイタル（CWV）という名称で、ウェブサイトの所有者と開発者が、優れたユーザー体験のために重要な3つのパフォーマンス指標に集中できるよう取り組みを開始しました。これらの指標は次のとおりです。

**<a hreflang="en" href="https://web.dev/articles/lcp">最大のコンテントフルペイント</a> (LCP)**
* _ローディング_のパフォーマンスを測定します。良いユーザー体験を提供するために、LCPはページが最初にロードされ始めてから2.5秒以内に発生する必要があります。

**<a hreflang="en" href="https://web.dev/articles/fid">最初の入力までの遅延</a> (FID)**
* _インタラクティビティ_を測定します。良いユーザー体験を提供するために、ページのFIDは100ミリ秒以下であるべきです。

**<a hreflang="en" href="https://web.dev/articles/cls">累積レイアウトシフト</a> (CLS)**
* _視覚的_な安定性を測定します。良いユーザー体験を提供するために、ページのCLSは0.1以下を維持する必要があります。

コアウェブバイタルが<a hreflang="en" href="https://developers.google.com/search/blog/2020/05/evaluating-page-experience">Googleの検索アルゴリズムにおけるランキング要因</a>となったことで、eコマース事業者からの注目度が高まっています。

Chromeユーザー体験レポートは、実際のユーザーからこれらの指標を収集できます。そのため、制御された環境でページロードをシミュレートする従来の「ラボ」テストと比較して、より正確な結果が得られると考えられます。

このセクションでは、LCP、FIP、CLSの3つの指標すべてで「良い」の基準値に達しているサイトをレビューします。

{{ figure_markup(
  image="ecommerce-real-user-core-web-vitals-experiences.png",
  caption="コアウェブバイタルのリアルユーザー体験記",
  description="もっとも普及している上位5つのECプラットフォームについて、CWV体験が良好なサイト数を棒グラフで示したもの。WooCommerceはデスクトップ16.92%、モバイル11.32%、Shopifyがデスクトップ43.22%、モバイル32.64%、PrestaShopはデスクトップ40.50%、モバイル21.46%、Magentoでデスクトップ25.80%、モバイル14.02%、Wix eCommerceではデスクトップ29.86%、モバイル21.57%、Squarespace Commerceでデスクトップ38.04%、モバイル13.31%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1634335022&format=interactive",
  sheets_gid="1963925384",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql",
  width=600,
  height=502
) }}

CWVによる「良い」体験を実現しているサイトの割合をプラットフォーム別に見ると、Shopifyがモバイルで32.64%ともっとも高いパフォーマンスを示していることがわかります。一方、WooCommerceのモバイルサイトでは、11.32%しか「良い」体験を実現していません。

パフォーマンスの章にある結果を見て、より広いウェブと比較できます。デスクトップでは41％、モバイルでは29％のサイトが「良い」CWV体験を達成していることがわかりました。このレンズで見ると、Shopifyストアは平均して、モバイルサイトに基づく平均的なサイトよりも良いパフォーマンスを示し、WooCommerceサイトは悪いと言うことができます。ただし、これは因果関係ではなく、相関関係であることを指摘することが重要です。

昨年と比較すると、すべてのプラットフォームでCWVスコアの中央値が向上していることがわかります。もっともパフォーマンスが向上したのは、Shopifyのサイトです。モバイルサイトの21.24%が良いCWV体験をしていたのが、32.64%に増加しました。

最後に、良いCWV体験を実現しているサイトの割合は、プラットフォームがSaaSかセルフホスティングかとは相関していないことを指摘しておきます。

次のセクションでは、各CWV指標を独立して検討し、各プラットフォームでサイトパフォーマンスの低下の最大の要因となっているものが何かについて確認します。

#### 最大のコンテントフルペイント(LCP)

まず、<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">最大のコンテントフルペイント</a> がありますが、これはメインページのコンテンツがロードされるまでの時間、ページが使えるまでにかかる時間の代理として使用するものです。

{{ figure_markup(
  image="ecommerce-real-user-largest-contentful-paint-experiences.png",
  caption="実ユーザーによる最大のコンテントフルペイント体験",
  description="もっとも普及している上位5つのECプラットフォームについて、LCP体験が良好なサイト数を示した棒グラフです。WooCommerceはデスクトップ28.07%、モバイル17.53%、Shopifyでデスクトップ75.93%、モバイル57.94%、PrestaShopではデスクトップ61.54%、モバイル39.85%、Magentoがデスクトップ45.20%、モバイル30.03%、Wix eCommerceでデスクトップ36.70%、モバイル26.20%、Squarespace Commerceではデスクトップ39.63%、モバイル24.37%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=949717130&format=interactive",
  sheets_gid="1963925384",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql",
  width=600,
  height=502
) }}

モバイル向けShopifyサイトの57.94%が良好なLCP体験を達成し、Shopifyが再びトップeコマースプラットフォームの座を獲得しました。WooCommerceを使用しているサイトは、わずか17.53% が良好な体験を実現しており、もっとも悪い結果となりました。とくにこの指標は、WooCommerceのCWV総合スコアの低さにもっとも貢献しているように思われます。

ウェブ全体では、モバイルサイトの45%が良好なLCP体験を実現していることが、「パフォーマンス」の章で明らかにされています。もっとも普及している上位6つのeコマース・プラットフォームのうち、Shopifyだけが、モバイルでリクエストされた全サイトの平均を上回る結果を達成しました。

CWVの3つの指標のうち、ホスティングの設定は主にLCPスコアにのみ影響します。したがって、この時点では、一般的にセルフホスティングされているプラットフォームと、ベンダーによってインフラストラクチャが管理・最適化されているSaaSプラットフォームを比較することに価値があります。SaaSとしてのShopifyは、他のプラットフォームをリードしていることがわかります。しかし、他の2つのSaaSプラットフォーム、Wix eCommerceとSquarespace Commerceは、人気のあるセルフホスティングのプラットフォームMagentoとPrestaShopと比較してモバイルでのパフォーマンスが、悪いことがわかります。

#### 最初の入力までの遅延(FID)

2つ目の指標である <a hreflang="ja" href="https://web.dev/i18n/ja/fid/">最初の入力までの遅延</a> は、ウェブサイトの訪問者がリンクやボタンをクリックするなどしてサイトとやり取りしたときに、ブラウザがどれだけの作業をしなければならないかを測定するものです。これは、サイトの応答性、またはユーザー入力への反応が遅いかどうかの代用品と見なすことができます。

{{ figure_markup(
  image="ecommerce-real-user-first-input-delay-experiences.png",
  caption="実ユーザーの最初の入力までの遅延体験",
  description="もっとも普及している上位5つのECプラットフォームについて、FID体験が良好なサイト数を示す棒グラフです。モバイルでは、WooCommerceが97.44%、Shopifyは98.21%、PrestaShopが97.19%、Magentoで96.61%、Wix eCommerceでは92.05%、そしてSquarespace Commerceは98.23%となっています。デスクトップの比率は非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=411508866&format=interactive",
  sheets_gid="1963925384",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql",
  width=600,
  height=502
) }}

上位のすべてのeコマース・プラットフォームのサイトが、この指標で良好な結果を残しています。デスクトップでは、調査対象となったほとんどのECプラットフォームが100%良好なFID体験を達成しています。モバイルでは、一部体験の悪さが目立ち始めていますが、大半は良好なFID体験を達成しています。Shopify（98.21%）とSquarespace Commerce（98%）は上位のeコマースプラットフォームの中でもっとも高いパフォーマンスを示し、WooCommerce、PrestaShop、Magentoは98%にわずかに及ばない程度に留まっています。

Wix eCommerceは、一般的に良好なパフォーマンスを示しているプラットフォームですが、FIDは同社のウェブサイトの92.05%のみが良好なFID体験を有しており、不得意な分野の1つとなっています。

とはいえ、6つとも非ECサイトよりパフォーマンスが高い。[パフォーマンス](./performance)の章では、モバイルの全サイトの90%が良好な最初の入力までの遅延体験を実現していることがわかりました。

#### 累積レイアウトシフト(CLS))

3つのCWVメトリクスの最後のものは、<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">累積レイアウトシフト</a>です。これは、ページ上のアイテムが「動き回る」量の測定値です。たとえば、新しい画像が表示されて、読んでいたテキストやクリックしようとしていたボタンが別の場所に押されるなどです。

{{ figure_markup(
  image="ecommerce-real-user-cumulative-layout-shift-experiences.png",
  caption="実ユーザーの累積レイアウトシフト体験",
  description="もっとも普及しているeコマースプラットフォーム上位5つのモバイルでのCLS体験が良好なサイト数を示す棒グラフです。WooCommerceはデスクトップ53.46%、モバイル55.34%、Shopifyではデスクトップ55.97%、モバイル52.58%、PrestaShopはデスクトップ61.78%、モバイル47.95%、Magentoがデスクトップ48.77%、モバイル36.46%、Wix eCommerceはデスクトップ74.15%、モバイル76.26%、Squarespace Commerceではデスクトップ60.23%、モバイル49.61%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1602906686&format=interactive",
  sheets_gid="1963925384",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql",
  width=600,
  height=502
) }}

上位プラットフォームのうち、Wix eCommerceは76.26%のモバイルサイトがCumulative Layout Shift Experienceを達成し、すべてのプラットフォームを凌駕しています。一方、Magentoのサイト（36.46%）では、良い体験をした訪問者はその半分以下でした。

これらのeコマースサイトの指標をより広いウェブと比較すると、上位のeコマースプラットフォームのパフォーマンスが、若干悪いことがわかります。パフォーマンスの章では、62%のサイト（モバイルおよびデスクトップ）が良好なCLS体験をしていることがわかりました。

## ページ解剖学

サイトのパフォーマンスの理由を理解する場合、最初に調べるのは、ページの重さ（ダウンロードに必要なキロバイト数）と、ページの読み込みに必要なリクエストの数です。

### ページのリクエスト

{{ figure_markup(
  image="ecommerce-page-requests-distribution.png",
  caption="ページが配信を要求する。",
  description="リクエスト数を示す棒グラフで、10パーセンタイルではデスクトップが49、モバイルが46、25パーセンタイルではそれぞれ72と68、50パーセンタイルでは106と101、75パーセンタイルでは152と145、90パーセンタイルではデスクトップが214、モバイルが202となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1034165153&format=interactive",
  sheets_gid="914828480",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

全ECサイトの50パーセンタイルでは、モバイルでのホームページのリクエスト数は101件でした。これは、昨年見られた98件のリクエストと非常に似た数字です。ページあたりのリクエスト数は、昨年と比較すると、すべてのパーセンタイルで非常によく似ています。

{{ figure_markup(
  image="ecommerce-median-page-requests-by-type.png",
  caption="ページリクエストのタイプ別中央値。",
  description="ページあたりのリクエスト数をファイルタイプ別に中央値から順に並べた棒グラフです。スクリプトはデスクトップで38リクエスト、モバイルで37リクエスト、画像はそれぞれ32と29、cssは両方で11、フォントはデスクトップで6、モバイルで5、その他は両方で5、ビデオは両方で3、htmlは両方で3、テキストは両方で2、xmlとオーディオはすべて1で、いずれも1ページあたりのリクエストが多い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=386200843&format=interactive",
  sheets_gid="738651000",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

これらのリクエストを種類別に分類すると、JavaScriptがもっとも普及しているリソースであり、平均的なeコマース・モバイルのホームページで37件のリクエストが、あることがわかります。これは、1ページあたり30件のJavaScriptリクエストがあった昨年から23%増加したことになります。以前は画像がもっともリクエストされるリソースで、モバイルページあたり34リクエストでしたが、これは29リクエストとわずかに減少しています。

### ページの重さ

サイトのページ重量には、すべてのHTML、CSS、JavaScript、JSON、XML、画像、音声、動画が含まれます。

{{ figure_markup(
  image="ecommerce-page-weight-distribution.png",
  caption="ページの重量配分。",
  description="ページの重さをKBで表した棒グラフ、10パーセンタイルはデスクトップが1,057KB、モバイルが970KB、25パーセンタイルはそれぞれ1,666と1,547、50パーセンタイルは2,771と2,585、75パーセンタイルは4,922と4,537、90パーセンタイルはデスクトップが8,774KB、モバイルが7,798MBとなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1742676196&format=interactive",
  sheets_gid="914828480",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

eコマースホームページのページ重量の中央値は、モバイルでは2.5MBでした。この数値は昨年の結果と同じであるため、平均してホームページは重くなっていない（軽くなっている）ことがわかります。

もっとも重いサイト（90パーセンタイル）は2020年の結果より4％重いので、ワースト1位は若干悪くなっています。

{{ figure_markup(
  image="ecommerce-median-page-kilobytes-by-type.png",
  caption="タイプ別ページキロバイトの中央値。",
  description="中央のページについて、ファイルタイプごとに1ページあたりのキロバイトを降順に並べた棒グラフ。動画はデスクトップで3,195KB、モバイルで2,676KB、画像はそれぞれ1,360KB、1,276KB、スクリプトはそれぞれ689KB、651KB、cssは112と111、フォントは167と134、htmlは40と39になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=575990763&format=interactive",
  sheets_gid="738651000",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

この理由を理解するために、リソースの種類別のページの重さを見てみましょう。モバイルサイトでは、動画が2.6MBともっとも重いリソースであり、画像（1.2MB）、JavaScript（0.6MB）がそれに続いています。昨年と比較すると、動画の読み込みMB数が24%増加していることがわかります。一方、他のすべてのリソースタイプのMBは安定しています。

このことから、もっとも重いサイトは、すぐに全体のページウエイトをかなり大きくすることができる動画を使用しているサイトである可能性があります。2020年と2021年の間でページウェイトの中央値に変化がないことから、動画を使用しているサイトの数は変わっていないが、動画を使用しているサイトのうち、より多く使用していることが示唆されます。この分野でのさらなる研究の機会としては、動画のウェイトを増加させた原因を調べることでしょう。動画の数が増えたのか、動画の時間が長くなったのか、品質が上がったのか？

{{ figure_markup(
  image="ecommerce-page-requests-by-type-at-90th-percentile.png",
  caption="90パーセンタイルでのタイプ別ページ要求数。",
  description="1ページあたりのリクエスト数をファイルタイプ別に90％台から順に並べた棒グラフです。スクリプトはデスクトップで94、モバイルで92、画像は89と90、cssは両方で34、その他は19と22、フォントは13と11、htmlは12と11、動画は両方で11、テキストとオーディオは両方で5、xmlは両方で4です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1076603835&format=interactive",
  sheets_gid="738651000",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

もっとも重いページ（モバイルで17MB）を持つサイトは、中央値（4.8MB）よりはるかに重いことがわかりました。とくに90パーセンタイルでタイプ別のページウェイトを見て、50パーセンタイルと比較すると、すべてのリソースタイプのウェイトが増加していることが分かります。

90パーセンタイルでページの重さにもっとも貢献しているのは、引き続き動画の9MBと画像（5.6MB）です。もっとも重いeコマースホームページが、動画と画像を大量に使用しているページであることは、まったく驚くことではありません。このページはコンテンツが、多いことが多く、これらのリソースタイプはブランドを伝えるのにもっとも効果的な方法だからです。動画と画像は購買体験の重要な要素であり続けますが、筆者の見解では、他のページタイプでは、これらの極端な表現はあまり見られないと思われます。

### HTMLペイロードサイズ

HTMLペイロードは、ドキュメントレスポンスのサイズです。HTMLの他に、インラインのJavaScriptやCSSが含まれることもあります。

{{ figure_markup(
  image="distribution-of-html-bytes-per-ecommerce-page.png",
  caption="EコマースページごとのHTMLバイト数分布",
  description="HTMLのキロバイト数を示す棒グラフで、10パーセンタイルはデスクトップとモバイルで14KB、25パーセンタイルはそれぞれ22と21、50パーセンタイルは39と38、75と76、90パーセンタイルはデスクトップで141KB、モバイルで144KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1110473821&format=interactive",
  sheets_gid="1110292504",
  sql_file="pagestats_html_bydevice.sql"
) }}

HTMLのペイロードの中央値は、モバイルで38KB、デスクトップで39KBでした。一方、90パーセンタイルでは、モバイルで144KB、デスクトップで141KBと、ペイロードが約4倍になっています。

ペイロードサイズは、モバイルとデスクトップの両方でほぼ一定であり、サイトが両方のデバイスタイプにほぼ同じHTMLを配信していることが示唆されました。

### 画像

画像は、2番目に要求の多いリソースタイプであり、ページの重量を増加させる要因としても2番目に大きいものです。

{{ figure_markup(
  image="distribution-of-image-requests-for-ecommerce.png",
  caption="eコマース向け画像リクエストの配信",
  description="画像のリクエスト数を示す棒グラフで、10パーセンタイルはデスクトップで11リクエスト、モバイルで10リクエスト、25パーセンタイルはそれぞれ19と17、50パーセンタイルは31と28、75パーセンタイルは51と47、90パーセンタイルはデスクトップで84リクエスト、モバイルで76リクエストとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1959478173&format=interactive",
  sheets_gid="1637609725",
  sql_file="pagestats_image_bydevice.sql"
) }}

モバイルのホームページで要求される画像数の中央値は28枚であるのに対し、デスクトップでは31枚であることがわかります。10％のサイトがモバイルで76枚の画像を読み込んでいますが、これは昨年の91枚という最高値から減少しています。

全体として、要求される画像枚数が10～20％削減されています。明確な答えを出すのは難しいのですが、<a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">遅延読み込み属性</a> の採用が、増えたことが原因かもしれません。テスト中はスクロールやサイトとのインタラクションが行われないため、遅延ロードされたアセットは測定に加味されません。[JavaScript](./javascript)チャプターによる分析では、17%のサイトがこの属性を使用していることがわかり、この説に一定の説得力が、あることがわかりました。

{{ figure_markup(
  image="distribution-of-image-bytes-for-ecommerce.png",
  caption="eコマース向け画像バイトの配布",
  description="画像のキロバイト数を示す棒グラフで、10パーセンタイルはデスクトップが266KB、モバイルが219KB、25パーセンタイルはそれぞれ577と522、50パーセンタイルは1,315と1,241、75パーセンタイルは2,952と2803、90パーセンタイルはデスクトップ6,074とモバイル5,577KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1732107846&format=interactive",
  sheets_gid="1637609725",
  sql_file="pagestats_image_bydevice.sql"
) }}

画像を数ではなく重みで考慮すると、ページ重量の貢献度の中央値は1.2MB（モバイル）です。90パーセンタイルでは、5.4MBに上昇します。

2020年の分析と比較すると、全体的にECサイトホームページの画像の比重は非常に似ています。

画像のリクエスト数が若干減っていることから、各画像の平均的な重みが若干増えているのでしょう。

{{ figure_markup(
  image="poppular-image-formats-ecommerce.png",
  caption="Eコマースサイトで人気の画像フォーマット",
  description="画像タイプの利用シェアを示す分布図。JPGはデスクトップで53%、モバイルでは54%、PNGは両方で27%、GIFは両方で14%、SVGとWEBPは両方で2%、ICOは両方で1%、その他は0%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=435186757&format=interactive",
  sheets_gid="797916311",
  sql_file="pagestats_image_bydevice_format.sql"
) }}

<aside class="note">画像サービスや CDN の中には、WebP をサポートするプラットフォームには、接尾辞が <code>.jpg</code>や<code>.png</code> の URL でも (JPEG や PNG ではなく) WebP を自動的に配信するものがあることに注意してください。たとえば、<code>IMG_20190113_113201.jpg</code>は、ChromeではWebPの画像を返します。しかし、HTTP Archive が画像フォーマットを検出する方法は、まず MIME タイプのキーワードを確認し、次にファイル拡張子にフォールバックします。つまり、上記のような URL を持つ画像のフォーマットは、HTTP Archive がユーザーエージェントとしてサポートしている WebP が与えられることになります。</aside>

もっとも普及している画像形式はJPGで、モバイルでは54%がこの形式でした。これは、画像の50%がJPGであった昨年に比べ、8%増加しています。

画像の27%はPNGで、これは昨年と同様の割合です。その他の画像の種類はほぼ同じですが、モバイルではGIFが17%から14%に減少しています。

残念ながら、WebPへの対応はまだまだ少ないのが現状です。これは、よりファイル サイズの効率的なフォーマットであり、<a hreflang="en" href="https://caniuse.com/webp">すべてのモダン ブラウザ</a>でサポートされているにもかかわらず。

### サードパーティーからの要望

Eコマースプラットフォームやサイトでは、しばしば[サードパーティ](./third-parties)のコンテンツが利用されます。[サードパーティウェブプロジェクト](./methodology#third-party-web)を使用して、第三者の利用を検知しています。

{{ figure_markup(
  image="distribution-of-third-party-requests.png",
  caption="サードパーティーからの要求の配布",
  description="Eコマースサイトのサードパーティリクエスト数を示す棒グラフで、10パーセンタイルではデスクトップが8、モバイルが7、25パーセンタイルはそれぞれ17と15、50パーセンタイルは33と30、75パーセンタイルは60と56、90パーセンタイルはデスクトップが96、モバイルが91となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1946741517&format=interactive",
  sheets_gid="681665784",
  sql_file="pct_3pusage_bydevice.sql"
) }}

モバイルのEコマースサイトの中央値は、サードパーティに30件のリクエストを行いました。昨年の分析ではサードパーティへのリクエストが増加していましたが、今年はほぼ全体的にほとんど変化がなく、静観しています。上位10%のページが、モバイルでは98から91に、デスクトップでは103から96に、サードパーティへのリクエスト数を減らしているというわずかな変化があります。

{{ figure_markup(
  image="distribution-of-third-party-bytes.png",
  caption="サードパーティーバイトの分布",
  description="Eコマースサイトのサードパーティーのキロバイト数を示す棒グラフで、10パーセンタイルはデスクトップが104KB、モバイルが75KB、25パーセンタイルはそれぞれ250と203、50パーセンタイルは569と495、75パーセンタイルは1,227と1,119、90パーセンタイルはデスクトップが2,527KB、モバイルが2,306KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=52384863&format=interactive",
  sheets_gid="681665784",
  sql_file="pct_3pusage_bydevice.sql"
) }}

サードパーティコンテンツの比重も、昨年の分析とほぼ同じです。50パーセンタイルのサイトでは、495KBのサードパーティ製コンテンツを要求しています。下位10%は75KBを要求しているのに対し、上位10%は2306KBを要求しています。

## ツール

サイトのパフォーマンスや品質の分析に加え、当社の[方法論](./methodology)では、eコマースサイトで使用されているその他の技術も検証することが可能です。これにより、採用されたeコマース戦略（例：国際化）や、典型的な開発手法（例：使用したJavaScriptライブラリ）についての知見を得ることができます。

### JavaScriptフレームワーク＆ライブラリ

JavaScriptの使用は、とくにコア製品がブラックボックスであるSaaSプラットフォームにおいて、コマース体験をカスタマイズするための一般的な方法です。

今年、ECサイトで使用されるJavaScriptの量が著しく増加したわけではありませんが、どのフレームワークやライブラリがもっともよく使用されているかを調べてみました。これにより、JavaScriptが何を実現するために使われているのかを知ることができるかもしれません。

残念ながら、eコマースにおけるヘッドレスフロントエンドの実装の普及について言及することはできません。この手法の限界の1つは、ヘッドレスの場合、eコマースプラットフォームの典型的なマーカーがもはや存在しないため、サイトがeコマースであることを検出するのがより困難であることです。この時点で、分析はより弱い二次的なシグナルへ頼ることになります。

{{ figure_markup(
  image="top-javascript-frameworks-ecommerce.png",
  caption="eコマースサイトで人気のJavaScriptフレームワーク",
  description="ECサイトでもっとも普及しているJavaScriptフレームワークを人気順に並べた棒グラフです。モバイルECサイトでのシェアはGSAPが15.07%、Require JS 7.22%、Handlebars 6.09%、styled-components 3.79%、Vue.js 3.41%、Prototype 2.66%、Stimulus 2.47%、Backbone JS 1.80%、Moustache 1.54%、Angular JS 0.71%となりました。デスクトップでの使用率もほぼ同じような感じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=532064877&format=interactive",
  sheets_gid="1754008320",
  sql_file="top_jsframework_providers_by_device.sql",
  width=600,
  height=500
) }}

{{ figure_markup(
  image="top-javascript-libraries-ecommerce.png",
  caption="eコマースサイトで人気のJavaScriptライブラリ",
  description="ECサイトでもっとも普及しているJavaScriptライブラリを人気順に並べた棒グラフ。モバイルECサイトではjQueryが93.66%、jQuery Migrate 39.74%、jQuery UI 30.99%、Modernizr 19.57%、Lodash 16.60%、Boomerang 13.53%、FancyBox 12.48%、React 11.82%、Underscore.js 11.65%、そしてSlick 9.90%のシェアを獲得しています。デスクトップでの使用率はほぼ同じようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=852523817&format=interactive",
  sheets_gid="2088662521",
  sql_file="top_jslibs_by_device.sql",
  width=600,
  height=500
) }}

<a hreflang="en" href="https://jquery.com/">jQuery</a>は、いまだもっとも普及しているライブラリであることがわかります。その終焉の報道は大いに誇張されている。調査対象となったeコマースサイトの93.66%がまだ使用していました。人気のあるeコマースベンダーの多くは、デフォルトのフロントエンドの一部としてjQueryを提供しています。さらに、プラットフォームはアプリやプラグインのエコシステムによって生かされており、追加機能を購入できます。これらのソリューションも、コスト効率よく機能を提供するためにjQueryを定期的に使用しています。

とくに、<a hreflang="en" href="https://greensock.com/gsap/">GSAP</a> (GreenSock Animation Platform) は、モバイルでリクエストされたeコマースウェブサイトの15%に含まれています。これは、人気のあるLightboxライブラリである <a hreflang="en" href="https://fancyapps.com/docs/ui/fancybox/">Fancybox</a> (12.48%) や、カルーセル作成に使われるライブラリ <a hreflang="en" href="http://kenwheeler.github.io/slick/">Slick</a> (9.90%) より多いのです。

制限のセクションで、すべてのリクエストはホームページに対して行われるため、結果が歪むことを認識しました。つまり、この分析では、Slickがさらに人気を博した可能性のある製品詳細ページのメディアギャラリーに使用されたライブラリは検出されないということです。

### 分析学

eコマースの優れた点の1つは、サイトを訪問した人のうち何人がコンバージョンしたかによって、自社の業績がどの程度かを測定できることです。理論的には、すべての変更、新しい価格設定、新しい機能は分析によって客観的に評価できます。

{{ figure_markup(
  image="top-analytics-ecommerce.png",
  caption="Eコマースサイトのトップ分析ソリューション",
  description="ECサイトでもっとも普及している分析ソリューションライブラリを人気順に並べた棒グラフです。モバイルECサイトのシェアは、Google Analyticsが74.19%、Google Analytics Enhanced Ecommerce 13.38%、HotJar 5.90%、Yandex Metrika 6.31%、New Relic 2.80%、 Matomo Analytics 2.21%、 Site Kit 1.65%、そしてMoat 1.20%となっています。デスクトップでの利用率はほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1380267770&format=interactive",
  sheets_gid="1942109850",
  sql_file="top_analytics_providers_bydevice_wapp.sql",
  width=600,
  height=500
) }}

<a hreflang="en" href="https://marketingplatform.google.com/about/analytics/">Google Analytics</a>は、74.19%のWebサイト（モバイル）で見られる、もっとも普及している解析ツールです。興味深いことに、モバイルのリクエストでは13.38%、デスクトップのリクエストでは13.99%しか、<a hreflang="en" href="https://support.google.com/analytics/answer/6014872?hl=en#zippy=%2Cin-this-article">拡張eコマース</a>の利用を指摘していません。しかし、主に強化されたeコマース機能は、商品一覧ページ、商品詳細ページ、カート、チェックアウトまでのeコマースジャーニーをトラッキングするものであるため、この割合が高まらないのは調査がホームページに限定されていることが原因かもしれません。

### タグマネージャー

これらのツールは、コアウェブサイトプラットフォームの導入（あるいは開発者の関与）なしにJavaScriptの変更をサイトに加えることができるため、eコマースチームやマーケティングチームに新機能を立ち上げるためのサイクルタイムを短縮することを可能にします。

{{ figure_markup(
  image="top-tag-managers-ecommerce.png",
  caption="ECサイトにおけるトップタグマネージャー",
  description="ECサイトでもっとも普及しているタグマネージャーを人気順に並べた棒グラフです。モバイルECサイトでのシェアは、Google Tag Managerが53.95％、Tealiumが0.26％、Adobe Experience Platform Launchが0.20％、Adobe DTMが0.08％となっています。デスクトップでの利用もほぼ同じような感じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1744266071&format=interactive",
  sheets_gid="1965630509",
  sql_file="percent_of_ecommsites_using_each_tag_managers.sql"
) }}

<a hreflang="en" href="https://marketingplatform.google.com/intl/en_uk/about/tag-manager/">Google Tag Manager</a>は、デスクトップで56.39％、モバイルで53.95％の利用率で圧倒的に市場をリードしています。2位と3位は、<a hreflang="en" href="https://tealium.com/">Tealium</a>（モバイル0.26％）と<a hreflang="en" href="https://business.adobe.com/uk/products/experience-platform/launch.html">Adobe Experience Platform Launch</a>（モバイル0.20％）となっています。

### A/Bテスト

アナリティクスと同様に、A/Bテストソリューションを導入することで、仮説を検証できます。新機能に対するフィードバックの仕組みを提供することは、どの戦略が有効で、どれがもはや投資されるべきかを理解する唯一の方法です。

{{ figure_markup(
  image="top-ab-testing-ecommerce.png",
  caption="EコマースサイトにおけるトップA/Bテストソリューション",
  description="ECサイトでもっとも普及しているA/Bテストソリューションを人気順に並べた棒グラフです。モバイルECサイトでのシェアは、Google Optimizeが2.06%、VWO 0.15%、OptimizelyとAdobe Targetが共に0.12%、SiteSpect 0.10%、Oracle Maximiser 0.07%、AB TastyとConvertはいずれも0.05%となっています。デスクトップでの利用もほぼ同じような状況です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1079713389&format=interactive",
  sheets_gid="1562966266",
  sql_file="top_abtesting_bydevice.sql",
  width=600,
  height=440
) }}

<a hreflang="en" href="https://marketingplatform.google.com/about/optimize/">Google Optimize</a>は、モバイルECサイトの2.06%で使用されている、もっとも普及しているA/Bテストツールです。<a hreflang="en" href="https://vwo.com/">VWO</a>は2番目に多いソリューションでしたが、Google Optimizeと比較して10分の1以下のサイト数で見られました（モバイルでは0.15％）。

当然のことですが、残念なことに、調査時点で大半のeコマースサイトはA/Bテストを実施していませんでした。

### Webプッシュ通知

訪問者の許可を得れば、[_Push API_](https://developer.mozilla.org/docs/Web/API/Push_API)を使って、ECサイトが開いていない時でもプッシュ通知を送ることができるようになります。

Chromeのユーザー体験レポートを使って、ECサイトによるWebプッシュ通知の導入状況を調べてみました。実際のユーザーデータから作成されているため、プッシュ許可リクエストの承認率も確認できます。このデータがどのように取得され、どのような指標が利用できるかの詳細については、<a hreflang="en" href="https://developers.google.com/web/updates/2020/02/notification-permission-data-in-crux">このGoogleの記事</a>を参照してください。

{{ figure_markup(
  caption="Webプッシュ通知（モバイル）を利用しているECサイトの割合。",
  content="0.43%",
  classes="big-number",
  sheets_gid="1579949984",
  sql_file="webpush_adoption_by_ecommsites.sql"
)
}}

モバイルで0.43%（デスクトップでは0.48%）のホームページのみがWeb Push APIの利用を要求しています。とくにiOSのSafariはPush Notifications APIをサポートしていませんが、他のブラウザではまだ広く採用されています。注文の更新など、eコマースにおける適切なタイミングでプッシュ通知による体験を段階的に向上させる良い機会がまだあることを示唆しています。

さらに、モバイルサイトの0.69%（デスクトップでは0.68%）がPush通知の送信許可を求めていた昨年から、その使用率は目に見えて減少しています。

利用率の低さを「認知度が低いから」と言い訳することもできるかもしれません。しかし、利用率の低下は別の傾向を示しており、3分の1以上のサイトがプッシュ通知を利用しなくなりました。これはプッシュ通知の受理率が、低いことが原因かもしれません。

{{ figure_markup(
  image="web-push-notification-acceptance-rates-ecommerce.png",
  caption="Webプッシュ通知受付率",
  description="Webプッシュ通知の受け入れ率を示す棒グラフで、モバイルでは10パーセンタイルが4.92%、25パーセンタイルでは9.67%、50パーセンタイルは14.23%、75パーセンタイルで19.91%、90パーセンタイルでは29.80%となっています。デスクトップの合格率はほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=1221136912&format=interactive",
  sheets_gid="771576347",
  sql_file="webpushstats_ecommsites.sql"
) }}

プッシュ通知の受付率は、昨年の結果とほぼ同じです。プッシュ通知リクエストの受付率の中央値は、モバイルで14.23%でした。残念なことに、年をまたいで傾向があるとすれば、それは下向きです。90パーセンタイルでは、昨年は36.9%のプッシュ要求が受け入れられたのに対して、今年はモバイルで29.80%でした。

なぜ、これほどまでに取り込みが進まないのか、筆者は複数の示唆を与えることができます。

* リクエストのタイミングが悪い（例：最初のページロード時）、または
* 十分な動機付けがなされる前に行われた場合、たとえば、通知を受けることの利点について何の説明もなく行われた場合、または
* もっと単純に、訪問者がウェブベースのプッシュ通知にまだ慣れていないだけかもしれません。

### アクセシビリティオーバーレイ

Webサイトをアクセシブルにすることは、決して後回しにすべきではない。しかし、ウェブサイトをよりアクセシブルにすることを謳う技術は増えてきています。アクセシビリティオーバーレイは、サイトに自動的なアクセシビリティの修正を適用しようとするJavaScriptです。これらは通常、アクセシビリティの専門家には<a hreflang="en" href="https://overlayfactsheet.com/">推奨</a><a hreflang="en" href="https://www.a11yproject.com/posts/2021-03-08-should-i-use-an-accessibility-overlay/">されません</a>。

{{ figure_markup(
  caption="アクセシビリティオーバーレイがあるECサイトの割合（モバイル）",
  content="0.77%",
  classes="big-number",
  sheets_gid="437541192",
  sql_file="percent_of_ecommsites_using_a11y_solutions.sql"
)
}}

今回の調査では、サードパーティ製のアクセシビリティツールをホームページで公開しているウェブサイトは1％未満でした。

このようなツールの詳細については、[アクセシビリティ](./accessibility#アクセシビリティオーバーレイ)の章に記載されています。

### AMP

{{ figure_markup(
  caption="ECサイト（モバイル）でのAMPの利用状況。",
  content="0.61%",
  classes="big-number",
  sheets_gid="346207972",
  sql_file="pct_ampusage_bydevice_vendor.sql"
)
}}

Googleが提供するAMPは、最新情報を素早く提供するメディア業界ではよく使われていますが、eコマースではなかなか普及が進んでいません。今年、AMP対応を宣言したウェブサイトやAMPリソースにリンクしているウェブサイトは0.7%未満であると報告されました。

### 同意の管理

{{ figure_markup(
  caption="ECサイト（モバイル）でのサードパーティ製同意管理ソリューションの利用状況。",
  content="6.85%",
  classes="big-number",
  sheets_gid="603073481",
  sql_file="percent_of_ecommsites_using_cmp.sql"
)
}}

EUのCookieポリシーとGDPRにより、要求されるマーケティングパーミッションの複雑さが増しています。今年、モバイルのECサイトの6.85％が、法令に従った同意の収集を容易にするため、サードパーティの同意管理アプリを導入していることがわかりました（デスクトップでは6.52％）。

### コンテンツセキュリティポリシー

お客様が機密情報を共有することが予想されるサイトでは、システムに入り込んだ不正なコードがないことを確信できることがさらに重要です。コンテンツセキュリティポリシー（CSP）は、ホワイトリストに載っていない第三者のウェブサイトへのリクエストを監視したり、ブロックしたりする手法です。

多くのセキュリティポリシーと同様に、このような管理方法は、サードパーティのコードをサイトに素早く追加することを主目的とするタグマネージャーなどのツールを使って素早く行動したいeコマースビジネスの敵対者と見なすことができます。筆者の体験では、CPSを管理するためのオーバーヘッドが原因で、ほとんど利用されていません。

{{ figure_markup(
  caption="コンテンツセキュリティポリシーを使用しているモバイルeコマースページの割合。",
  content="23.28%",
  classes="big-number",
  sheets_gid="1586343490",
  sql_file="percent_of_ecommsites_csp.sql"
)
}}

最初に読んだとき、デスクトップで25.02%、モバイルページでは23.28%のリクエストでコンテンツセキュリティポリシーが利用されていることに驚かされました。しかし、一部のeコマースプラットフォームベンダーは、緩やかなコンテンツセキュリティポリシーをそのまま提供しています。たとえば、Shopifyのサイトでは、すべてのリクエストがHTTPSであることを保証するだけでなく、iframe内にサイトを読み込むことをブロックするポリシーが用意されています。さらに調査を進めないと、サードパーティの資産を管理する手段としてCSPを使用しているeコマースサイトの数を特定することはできません。ポリシーの変更を実施する前にテストすることを目的としたCSPの「レポートのみ」モードを使用しているサイトが0.70％しかないことを考えると、ごく少数である可能性があります。

### 国際化

成功するeコマース・ビジネスの重要な成長戦略は、新しい国への進出です。そのためには、ローカライズされた言語版のサイトを提供する必要があります。

今年の分析では、`hreflang`ヘッダーとリンクタグを探し、どれだけのサイトがそれらを使用しているかを調べました。これらのタグはもっとも普及しているプラットフォーム（例：WooCommerce、Shopify、Magento）ではすぐに利用できないため、何らかの存在が示唆されています。

`hreflang` 属性は、そのページが対象としている言語を伝えるために使用されます。たとえば、イギリスを対象とする英語は `en-gb` で、米国を対象とする英語は `en-us` であるのに対し、特定の国に絞り込むこともできます。

{{ figure_markup(
  image="hreflang-links-ecommerce.png",
  caption="Eコマースサイトで使用される `hreflang` リンクのトップページ",
  description="eコマースサイトのうち、1つ以上の `hreflang` リンクで言語が指定されている割合を示す棒グラフです。モバイルで人気の高い順に並べると、`en` が8.07%、`de` が3.28%、`fr` が2.82%、`es` が2.66%、`it` が1.72%、`nl` が1.21%、`ru` が0.81%、 `pl` と `pt` が0.81% 、そして `be` が0.67% のe-commerceサイトで利用可能なhreflangです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT70VMNXb1X6Mnh69JGhQILb5ImqBkg6MtMpPiZnrNfYXQ7nngGWHO_kj87tAG5FkIyOvpNNYJmkLVY/pubchart?oid=532818660&format=interactive",
  sheets_gid="682046615",
  sql_file="percent_of_ecommsites_using_hreflang_value_link.sql",
  width=600,
  height=500
) }}

その結果、英語のhreflangを指定するリクエストは、デスクトップでは8.81%、モバイルのECサイトでは8.07%であることが確認されました。次にもっとも普及している言語は、ドイツ語（モバイルでは3.28%）、フランス語（2.82%）、スペイン語（2.66%）の順となりました。

このデータから、さらなる調査なしにあまり多くの結論を導き出すことは困難です。しかし、eコマース事業者が言語別のサイトバリエーションを提供することは、まだ珍しいと言えるでしょう。その中でも、西ヨーロッパ諸国で使用されている1つまたは複数の言語のサポートを宣言しているケースがもっとも多いようです。筆者の体験では、イギリス、フランス、ドイツ、スペイン、イタリアはそれぞれ地理的に近いため、国際化は魅力的な成長戦略であると言えます。

eコマース・ウェブサイトの国際化能力をよりよく理解するために、ここでさらに調査を行うことができます。たとえば、宣言された `hreflang` 属性の平均数を調べることで、マルチリージョンサポートの幅を決定することができるかもしれません。

`hreflang`の使用とCRUXメトリクスから得られるランキングデータを相互参照することで、企業がマルチリージョンサポートに投資する時期の傾向を明らかにできます。

## 結論

2020年の第2四半期から第3四半期にかけて、eコマース機能を持つサイトの割合に測定可能な増加が見られました。この増加率は2021年まで維持されていません。実際、モバイルでのECサイトの割合は21.27%から19.49%に減少しており、ECがウェブ全体と同じペースで成長していないことが示唆されています。

WooCommerceとShopifyはもっとも普及しているeコマース・プラットフォームです。また、パンデミックに対応した成長の割合がもっとも大きいのもこの2つです。

今回はじめて、ウェブサイト人気ランキングのデータを用いて分析を行いました。これにより、事業規模別にeコマースプラットフォームの人気度を検証することができました。とくに、10万サイトの中でもっとも普及しているのはMagentoです。次いでShopify、Salesforce Commerce Cloudとなっています。

最後に、サイトのパフォーマンスについてですが、コアウェブ・バイタルはGoogleの検索エンジンのランキング要因になったため、昨年から業界で盛んに議論されています。上位5つのプラットフォームのほとんどで、モバイルで良好なCWVを達成したサイトが10～20%増加しました。Shopifyのサイトでは、平均33%ともっとも高い割合で良好なCWVを体験しています。昨年からの改善にもかかわらず、eコマースサイトは、コアウェブ・バイタルのすべてのプラットフォームにおいて、依然として非常に低いパフォーマンスとなっています。

### 今後の解析の可能性

この方法の限界の1つは、ホームページのみをテストすることです。たとえば、支払いや配送のプロバイダーは、チェックアウトプロセスの間だけ表示されます。このような場合、チェックアウトプロセスのこの段階に到達するため必要なステップを考えると、実現は困難と思われます。

また、トップページのみの評価は、サイトパフォーマンスの分析に影響を及ぼします。商品一覧ページと商品詳細ページが、スピードの最適化においてより重要であることは間違いないでしょう。サイトごとに複数のページを取得することは<a hreflang="en" href="https://github.com/HTTPArchive/httparchive.org/issues/400">調査中</a>で、Web Almanacの将来のエディションで利用できるようになるかもしれません。

Wappalyzerは2,700以上の人気のあるウェブテクノロジーを追跡しており、すでに素晴らしい分析機会を提供してくれています。しかし、とくにeコマースにおいては、非常にロングテールの技術が存在します。現時点では、パーソナライゼーションツールのトップ、レビューアプリのトップ、カート放棄のトップなど、eコマースにおける技術のカテゴリーをレビューすることは、十分なカバレッジがないため、現実的ではありません。これは、検出可能な技術の数が多いことと、1サイトにつき1ページしか要求しないことが一因です。

今後、Wappalyzerを対応する技術が増えれば、技術の利用状況、パフォーマンス、ウェブサイトのCrUXランクに相関性があるかどうかを調べる、さらなる分析ができるようになるかもしれません。
