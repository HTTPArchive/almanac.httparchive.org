---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 構造化データ
description: schema.org、RDFa、Microdataなどの採用や影響について解説した2021年版Web Almanacの「構造化データ」の章です。
authors: [jonoalderson, cyberandy]
reviewers: [vdwijngaert, philbarker]
analysts: [GregBrimble]
editors: [jvandriel, JasmineDWillson, tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1uEA217YjpX1xdRVBnIz9ekjpjIrpGIh5GwUxvnzJNig/edit?usp=sharing
jonoalderson_bio: デジタル戦略家、マーケティングテクノロジスト、フルスタックデベロッパー。Webサイトのパフォーマンス、テクニカルSEO、schema.org、構造化データなど、あらゆることに手を出すのが好き。
cyberandy_bio: アンドレア・ボルピーニはWordLiftのCEOで、現在はセマンティックウェブ、SEO、人工知能に注力しています。
featured_quote: 構造化データを使ってコンテンツを記述することで、機械がWebページやWebサイトをデータベースとして扱えるようになります。それは、ビジネス、技術、そして社会に豊かな可能性をもたらします。
featured_stat_1: 33.53%
featured_stat_label_1: JSON-LDマークアップを含むページ
featured_stat_2: 8.9%
featured_stat_label_2: JSON-LDに `WebSite` マークアップが含まれるページ
featured_stat_3: 18
featured_stat_label_3: エンティティ間のネストされた関係の数が最も多い
---

## 序章

ウェブページを読むとき、私たちは「非構造化」されたコンテンツを消費しています。段落を読み、メディアを検証し、消化したものを検討する。このプロセスの一環として、私たちは直感と文脈（主題に精通しているなど）を適用して、重要なテーマ、データポイント、エンティティ、および関係を特定します。私たち人間は、この作業を非常に得意としています。

しかし、このような直感や文脈は、_ソフトウェア_で再現することが困難です。システムが高い信頼性を持って解析し、重要なテーマを特定し、抽出することは難しいのです。

このような制限は、私たちが効果的に構築・創造できるものの種類を制限し、ウェブテクノロジーの「スマートさ」を制限することになります。

情報に_構造_を導入することで、ソフトウェアがコンテンツを理解するのを_はるかに_容易_にできます。このためには、ラベルやメタデータを追加して、主要な概念や実体、およびそれらの特性や関係を特定します。

機械が構造化されたデータを確実に、かつ大規模に抽出することができれば、よりスマートな新しいタイプのソフトウェア、システム、サービス、ビジネスが可能になります。

Web Almanacの「構造化データ」の章の目的は、構造化データが現在ウェブ上でどのように使用されているかを探ることです。これにより、現在の状況、課題、および機会についての洞察が得られることを期待しています。

この章は『Web Almanac』にはじめて掲載されたため、残念ながら比較のための過去データが不足しています。今後の章では、対前年比の傾向も探っていく予定です。

## 主要コンセプト

構造化データは、複雑な風景であり、本質的に抽象的で「メタ」なものである。構造化データの重要性と潜在的な影響を理解するために、以下の主要な概念を調べてみる価値があります。

### セマンティックウェブ

公開されたウェブページに構造化データを追加し、それらのページが含む（あるいはそれに関する、あるいは参照する）エンティティを定義すると、[リンクデータ](https://en.wikipedia.org/wiki/Linked_data)の形式ができ上がります。

私たちは、コンテンツに含まれる（あるいは関連する）事柄について、[_３つの組み_](https://en.wikipedia.org/wiki/Semantic_triple)という形で_供述_を行います。この __記事__ はこの __人__ によって __承認__ された」、「その __動画__ は __猫__ に __ついて__ だ」というような記述です。

このようにコンテンツを記述することで、機械がウェブページやウェブサイトをデータベースとして扱うことができるようになります。規模が大きくなれば、<a hreflang="en" href="https://www.techrepublic.com/article/an-introduction-to-tim-berners-lees-semantic-web/">セマンティックウェブ</a>、すなわち巨大なグローバル情報データベースを構築できます。

<figure>
<blockquote>_セマンティックウェブ_とは、ウェブ上のデータを、表示目的だけでなく、自動化、統合、様々なアプリケーション間でのデータの再利用ができるように定義・リンクするという考えを実現するために、W3Cが始めた長期プロジェクトの名称です。</blockquote>
<figcaption>— Greg Ross、<cite><a hreflang="en" href="https://www.techrepublic.com/article/an-introduction-to-tim-berners-lees-semantic-web/">Tim Berners-Leeのセマンティックウェブ入門</a></cite></figcaption>
</figure>

それは、ビジネス、テクノロジー、そして社会に豊かな可能性をもたらします。

### 検索エンジン、そしてその先へ

現在、構造化データのもっとも広範な消費者は、_サーチエンジン_と_ソーシャル・メディア・プラットフォーム_である。

ほとんどの主要な検索エンジンでは、ウェブサイトの所有者は、さまざまな種類の構造化データをウェブサイトに実装することによって、さまざまな形式の <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/search-gallery">_豊富な結果_</a>（可視性とトラフィックに影響を与える可能性があります）の資格を得ることができます。

実際、検索エンジンは、構造化データの一般的な採用（および <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/intro-structured-data">教育周り</a>）において、ウェブ全体で非常に大きな役割を担っています。この章は、Web Almanac [去年のSEOの章](../2020/seo#構造化データ)から生まれたということです。近年では、検索エンジンの影響もあり、<a hreflang="en" href="https://schema.org/">schema.org</a>が構造化データの選択語彙として普及しました。

さらに、ソーシャルメディアプラットフォームは、コンテンツがプラットフォーム上で共有（またはリンク）されたときに、コンテンツの読み方や表示方法に影響を与えるため構造化データに依存しています。これらのプラットフォームにおけるリッチなプレビュー、カスタマイズされたタイトルと説明文、およびインタラクティブ性は、多くの場合、構造化データによって実現されています。

しかし、ここで見て理解すべきことは、検索エンジンの最適化やソーシャルメディアのメリットだけではありません。構造化データの規模、多様性、影響、そして_可能性_はリッチリザルト、検索エンジンをはるかに超え、schema.orgをはるかに超えるものです。

たとえば、構造化されたデータによって容易になる。

* 複数のページ、ウェブサイト、概念にまたがるトピックのモデリングとクラスタリングが容易になり、新しいタイプの調査、比較、サービスが可能になります。
* アナリティクスデータを充実させ、コンテンツやパフォーマンスの分析をより深く、水平化して行えるようにする。
* 業務システムやウェブサイトのコンテンツを照会するための統一された（少なくとも接続された）言語と構文を作成すること。
* セマンティック検索：検索エンジン最適化に使用されるのと同じリッチなメタデータを使用して、内部検索システムを構築・管理すること。

私たちの研究結果は、必然的に検索エンジンの影響によって形作られますが、私たちは構造化データの他のタイプ、フォーマット、およびユースケースについても調査したいと考えています。

## 構造化データの種類とカバー率

構造化データには、多くの形式、標準、構文があります。私たちは、[私たちのデータセット](./methodology)全体で、これらのうちもっとも一般的なものについてのデータを収集しました。

具体的には、以下のような構造化されたデータを特定し、抽出しています。

* [Schema.org](http://schema.org/)
* <a hreflang="en" href="https://www.dublincore.org/specifications/dublin-core/">Dublin core</a>
* ソーシャルネットワークで使用されるメタタグ:
    * <a hreflang="en" href="https://ogp.me/">Open Graph</a>
    * <a hreflang="en" href="https://developer.twitter.com/en/docs/twitter-for-websites/cards/guides/getting-started">Twitter</a>
    * <a hreflang="en" href="https://developers.facebook.com/docs/sharing/webmasters/">Facebook</a>
* [Microformats](http://microformats.org/) (と<a hreflang="en" href="https://microformats.org/wiki/microformats2">microformats2</a>)
* [RDFa](https://en.wikipedia.org/wiki/RDFa), [Microdata](https://en.wikipedia.org/wiki/Microdata_(HTML)) と<a hreflang="en" href="https://json-ld.org/">JSON-LD</a>

これらは、さまざまなユースケースとシナリオの広い概要を提供し、レガシーな標準と最新のアプローチの両方を含みます（たとえば、microformatsとJSON-LD）。

さまざまな構造化データ型における具体的な使用方法を探る前に、いくつかの注意点を簡単に調べておきましょう。

### データの注意点

#### 1. コンテンツマネジメントシステムの影響

評価したページの多くは、<a hreflang="en" href="https://wordpress.org/">WordPress</a> や <a hreflang="en" href="https://www.drupal.org/">Drupal</a> などの [コンテンツ管理システム](./cms)（CMS）を使用しているWebサイトのものでした。これらのシステム、あるいはその機能を強化するテーマやプラグイン、モジュールは、分析対象の構造化データを含む[HTMLマークアップ](./markup)を生成する役割を担っていることがよくあります。

つまり、私たちの調査結果は、もっとも普及しているCMSの動作や出力と一致するように偏ることを意味します。たとえば、Drupalを使用している多くのウェブサイトは、RDFaの形で構造化データを自動的に出力しますし、WordPress（[かなりの割合のウェブサイト](./cms#top-cmss)を動かす）はしばしばテンプレートコードにmicroformatsマークアップを含めます。これは、私たちの調査結果の形状に大きく寄与しています。

#### 2. ホームページのみのデータの限界

残念ながら、このデータ収集方法の性質と規模から、分析対象はホームページのみ（つまり、評価した各ホスト名の _root URL_）に限定されます。

そのため、収集・分析できるデータの量が大幅に制限され、収集したデータの種類も偏ってしまうのは間違いありません。

多くのホームページは、より具体的なページへの入り口として機能しているため、今回の分析では、より深いページに存在するコンテンツの種類を過小評価していると考えるのが妥当であろう。その中には、_記事_、_人_、_製品_などの情報が含まれている可能性があります。

逆に、ホームページによくある情報やすべてのページに存在するサイト全体の情報、たとえば_ウェブページ_、_ウェブサイト_、_組織_に関する情報などは、過剰にインデックスされる可能性が高いです。

#### 3. データの重複

構造化データ形式の性質上、このような分析を大規模かつクリーンに行うことは困難です。多くの場合、構造化データは複数のフォーマットで実装され（重複することも多い）、構文とボキャブラリーの境界線があいまいになっています。

たとえば、FacebookやOpen Graphのメタデータは、技術的にはRDFaのサブセットと言えます。つまり、私たちの調査では、Facebookのメタタグを含むページをFacebookのカテゴリ_と_`RDFa`のセクションで識別しています。私たちは、このようなタイプの重複やニュアンスを整理し、正規化し、意味をなすように最善を尽くしてきました。

#### 4. モバイルメトリクス

今回のデータセット全体を通して、構造化データの採用と有無は、デスクトップとモバイルのデータセットでごくわずかに異なるだけです。そのため、ここでは簡潔にするため、主に_モバイル_データセットに焦点を当てて説明します。

### タイプ別使用状況

このセットの多くのページで、さまざまな種類の構造化データが、存在することがわかります。

{{ figure_markup(
  image="structured-data-usage-by-type.jpg",
  caption="構造化データの利用",
  description="ウェブ上のさまざまな構造化データの種類を示す棒グラフです。データに含まれるすべてのモバイルページのうちRDFaは60.61%、Open Graphタグでは57.45%、Twitterタグは37.48%、Microdataでは24.91%、Facebookタグは8.15%、Dublin Coreタグでは1.22%、Microformatsは0.68%、microformats2では0.11%です。デスクトップでの利用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=501587417&format=interactive",
  sheets_gid="1876349096",
  sql_file="present_types.sql"
  )
}}

また、とくに_RDFa_と_Open Graphタグ_は非常に多く、それぞれ60.61%、57.45%のページに表示されていることが分かります。

一方、_Microformats_や_microformats2_などのレガシーフォーマットは、ページの1%未満にしか表示されません。

### シンタックスタイプ別カバレッジ

ある種の構造化データがいつ存在するかを特定するだけでなく、それが記述するデータの種類に関する情報を収集します。それぞれを分解し、各フォーマットと構文がどのように使用されているかを調べます。

#### RDFa

<a hreflang="en" href="https://www.w3.org/TR/rdfa-lite/">Resource Description Framework in Attributes</a>(RDFa)は、2015年にW3Cが発表したリンクデータのマークアップのための技術である。マークアップに属性を追加することで、Webページ上の視覚情報を補強し、翻訳することができる。

たとえば、ウェブサイトの所有者は、ハイパーリンクに `rel="license"` 属性を追加して、それがライセンス情報ページへのリンクであることを明示的に記述できます。

{{ figure_markup(
  image="structured-data-rdfa-types.jpg",
  caption="RDFaタイプ",
  description="ウェブ上でのRDFaの利用状況を示す棒グラフ。データ中の全モバイルページのうち `foaf:image` は0.86%、 `foaf:document` では0.36%、 `sioc:item` では0.24%、 `schema:webpage` では0.11%、 `image` では0.9%、 `listitem` では0.08%、 `breadcrumblist` では007%、 `og:website` では0.06%、 `skos:concept` では0.04%、 `webpage` では0.04%、 `v:breadcrumb` では0.04%、 `schema:article` では0.03%、 `sioc:useraccount` では0.03%、そして `person` では0.03% であった。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=1063480738&format=interactive",
  sheets_gid="379443022",
  width=600,
  height=504,
  sql_file="rdfa_type_ofs.sql"
  )
}}

RDFaのタイプを評価すると、`foaf:image`構文が他のタイプよりもはるかに多くのページに存在し、データセットの全ページの0.86%以上であることがわかります。これは小さな割合に見えるかもしれませんが、65,000ページを表し、発見されたRDFaマークアップ全体の60%以上に相当します。

この異常値を超えると、RDFaの使用はかなり減少し、断片的になるが、まだ興味深い発見がある。

##### FOAFについて

[FOAF](http://xmlns.com/foaf/spec/) (または "Friend of a Friend") は、2000年代初頭に作られた、人に関する用語のリンクデータ辞書である。_人_、_グループ_、_文書_の記述に使用できます。

FOAFはW3CのRDF構文を使っており、<a hreflang="en" href="https://web.archive.org/web/20140331104046/http://www.foaf-project.org/original-intro">原文紹介</a>では以下のように説明されています。

<figure>
<blockquote>ある友人たちが興味を持つ事柄について書かれた、相互に関連するホームページのWebを考えてみよう。ウェブ上に現れるそれぞれの新しいホームページは、世界に新しい何かを伝え、事実やゴシップを提供し、ウェブを断絶された情報の断片の鉱山にしています。FOAFは、これらすべての情報を理解する方法を提供します。</blockquote>
<figcaption><cite><a hreflang="en" href="https://web.archive.org/web/20140331104046/http://www.foaf-project.org/original-intro">FOAFの紹介</a></cite></figcaption>
</figure>

Drupal CMSの古いバージョンでは、デフォルトで `typeof="foaf:image"` と `foaf:document` マークアップがHTMLに追加されているため、この結果では `foaf` マークアップが目立つと思われます。

##### その他の注目すべきRDFaの発見について

FOAFのプロパティだけでなく、他のさまざまな標準や構文がリストに表示されます。

注目すべきは、`sioc:item`（ページの0.24％）や`sioc:useraccount`（ページの0.03％）など、いくつかの`sioc`プロパティが確認できることです。<a hreflang="en" href="https://www.w3.org/Submission/sioc-spec/">SIOC</a> は、メッセージボード、フォーラム、Wiki、ブログなどの_オンラインコミュニティ_に関連する構造化データを記述するために設計された標準です。

また、<a hreflang="en" href="https://www.w3.org/TR/skos-primer/">SKOS</a> (または "Simple Knowledge Organization System") のプロパティである `skos:concept` が0.04% のページで見受けられました。SKOSもその1つで、分類や区分（タグやデータセットなど）を記述する方法を提供することを目的とした規格である。

#### Dublin Core

<a hreflang="en" href="https://dublincore.org/">Dublin Core</a> は、1995年にオハイオ州ダブリンで開催されたOCLC（Online Computer Library Center）とNCSA（National Center for Supercomputing Applications）のワークショップで考案されたリンクデータ標準と相互運用できるボキャブラリーである。

幅広いリソース（デジタルと物理の両方）を記述できるように設計されており、さまざまなビジネスシーンで利用することができる。2000年以降、RDFベースのボキャブラリーの中で非常に人気が高く、W3Cの採択を受けた。

2008年からはDublin Core Metadata Initiative（DCMI）によって管理され、他のリンクデータ語彙との高い相互運用性を維持している。通常、HTML文書内のメタタグの集合体として実装される。

{{ figure_markup(
  image="structured-data-dublin-core.jpg",
  caption="Dublin Coreの利用状況",
  description="ウェブ上でのDublin Coreタグの使用状況を示す棒グラフ。データ中の全モバイルページのうち `dc.title` は0.70%、 `dc.language` では0.49%、 `dc.description` では0.44%、 `dc.publisher` では0.22%、 `dc.creator` では0.21%、 `dc.subject` では0.20%、 `dc.source` では19%、 `dc.identifier` が0.17%、 `dc.relation` が0.16%、 `dcterms.title` が0.15%、 `dc.type` が0.14%、 `dcterms.rightsholder` が0.12%、そして `dcterms.identifier` が0.11% となりました。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=1985156978&format=interactive",
  sheets_gid="358057466",
  width=600,
  height=574,
  sql_file="dublin_core_types.sql"
  )
}}

もっとも人気のある属性タイプは`dc:title`（0.70%のページ）であることは、驚くにはあたらない。しかし、`dc:language`が0.49%の普及率で（_description_、_subject_、_publisher_などの一般的な記述子より）次にあるのは興味深いことです。これは、Dublin Coreが多言語のメタデータ管理システムでよく使われていることを考えると、納得がいく。

また、異なる概念間の関係を表現することができる属性である`dc:relation`（0.16%のページ）が比較的多く出現していることも興味深い。

SEOの文脈ではSchema.orgが優勢であると多くの人が思うかもしれませんが、DCの役割は、その概念の幅広い解釈と_リンクされたオープンデータ運動_に深く根ざしていることから、極めて重要であることに変わりはありません。

#### ソーシャルメタデータ

ソーシャル・ネットワークとプラットフォームは、構造化データの最大の発行者であり消費者でもあります。このセクションでは、構造化データフォーマットの役割、普及率、規模について説明します。

##### オープングラフ

<a hreflang="en" href="https://ogp.me/">オープングラフ・プロトコル</a>は、オープンソースの規格で、もともとはFacebookが作成したものです。これは、_コンテンツを共有する_というコンテキストに特化した構造化データの一種で、Dublin CoreやMicroformatsなどの標準を緩やかにベースにしています。

これは、一連のメタタグとプロパティを記述したもので、プラットフォーム間で共有する際にコンテンツをどのように（再）表示するかを定義するために使用することができる。たとえば、投稿に「いいね！」を押したり、埋め込んだり、リンクを共有したりするときに使用します。

これらのタグは通常、HTML文書の `<head>` に実装され、ページの _title_, _description_, _URL_, _featured image_ といった要素を定義します。

Open Graphプロトコルは、その後、_Twitter_、_Skype_、_LinkedIn_、_Pinterest_、_Outlook_など、多くのプラットフォームやサービスで広く採用されるようになりました。プラットフォームが共有/埋め込みコンテンツの表示方法について独自の基準を持っていない場合（時には持っている場合でも）、Open Graphタグはデフォルトの動作を定義するためによく使用されます。

{{ figure_markup(
  image="structured-data-open-graph.jpg",
  caption="Open Graphの利用状況",
  description="Web上でのOpen Graphタグの利用状況を示す棒グラフ。データに含まれるすべてのモバイルページのうち `title` が54.87%、 `og:url` が52.03%、 `og:type` が48.18%、 `og:description` が48.55%、 `og:site_name` が43.37%、 `og:image` が36.98%、 `og:locale` が26.39%、 `og:image:width` が12.40%、`og:security` が12.40%、`go:text` が12.40%、 `gogo` が3.40%、`ogo:text` が3.40%です。 95%、 `og:image:height` が12.91%、 `og:image:secure_url` がWeb上でのOpen Graphタグの利用状況を示す棒グラフ。データに含まれるすべてのモバイルページのうち `og:title` が54.87%、 `og:url` が52.03%、 `og:type` が48.18%、 `og:description` が48.55%、 `og:site_name` が43.37%、 `og:image` が36.98%、 `og:locale` が26.39%、 `og:image:width` が12.95%、 `og:image:height` が12.91%、 `og:image:secure_url` が5.61%、 `og:image:alt` が1.75%、 `og:image:type` が1.61%、 `og:updated_time` が1.54%、そして `og:locale:alternate` が0.87% であります。デスクトップでの使用率もほぼ同じです。5.61%、 `og:image:alt` が1.75%、 `og:image:type` が1.61%、 `og:updated_time` が1.54%、そして `og:locale:alternate` が0.87% であります。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=688746239&format=interactive",
  sheets_gid="1440633828",
  width=600,
  height=574,
  sql_file="open_graph_types.sql"
  )
}}

もっとも一般的なOpen Graphタグは`og:title`であり、54.87%のページで見受けられる。これは、どのような種類のものが表現されているか（例： `og:type` ページの48.18%に掲載）、どのように表現されるべきか（例： `og:description`ページの48.55%に掲載）を記述する関連属性のセットに密接に追随しています。

これらのタグは、サイト上のすべてのページの `<head>` で使用される「定型」タグの一部として一緒に使用されることが多いので、この狭い分布は予想されることです。

やや少ないのは `og:locale`（26.39%のページ）で、これはページのコンテンツの言語を定義するために使用されます。

さらに少ないのは、`og:image`タグに関するより具体的なメタデータで、`og:image:width`（12.95%のページ）、`og:image:height`（12.91%のページ）、 `og:image:secure_url`（5.61% のページ）と `og:image:alt`（1.75% のページ）の形式です。 HTTPSの採用がますます一般的になっている現在、`og:image:secure_url`（`og:image`の`https`バージョンを識別するためのもの）はほとんど冗長になっていることは注目に値します。

これらの例を超えると使用頻度は急速に低下し、（多くの場合、不正、非推奨、または誤った）タグのロングテールになってしまいます。

##### Twitter

TwitterはOpen Graphタグをフォールバックやデフォルトとして使用していますが、このプラットフォームは独自の構造化データをサポートしています。TwitterでURLが共有されたときに、どのようにページを表示するかを定義するために、特定のメタタグ（すべて接頭辞が`twitter:`）を使用できます。

{{ figure_markup(
  image="structured-data-twitter.jpg",
  caption="Twitterのメタタグの利用状況",
  description="ウェブ上でのTwitterのメタタグの使用状況を示す棒グラフです。当社のデータでは、全モバイルページのうち `twitter:card` が35.42%、`twitter:title` が20.86%、`twitter:description` が18.68%、`twitter:site` が11.31%、`twitter:image` が11.41%、`twitter:label1` が6.85%, `twitter:data1` が6.85%、`twitter:creator` が3.58%、`twitter:url` が3.13%、`twitter:domain`が2.21%、`twitter:image:src` が0.58%, `twitter:text:title` が0.57%、 `twitter:app:id:phone` が0.54%、`twitter:app:url:iphone` が0.52% であった。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=2059334677&format=interactive",
  sheets_gid="485696602",
  width=600,
  height=574,
  sql_file="twitter_types.sql"
  )
}}

もっとも一般的なTwitterのメタタグは`twitter:card`で、全ページの35.42%に見られました。このタグは、プラットフォームで共有される際のページの表示方法を定義するために使用できます（例：_summary_、メディアオブジェクトに関する追加データと組み合わせた場合の_player_など）。

この異常値を超えると、採用率は急降下する。次に多いタグは`twitter:title`と`twitter:description`（どちらも共有URLの表示方法を定義するために使用）で、それぞれ全ページの20.86%と18.68%に表示されます。

これらのタグや、`twitter:image`タグ（ページの11.41%）と`twitter:url`タグ（ページの3.13%）の普及が進まない理由は、Twitterが定義されていない場合、同等のOpen Graphタグ（`og:title`, `og:description` と`og:image`）に戻るためであると理解できます。

また、注目すべきは

* 当該ウェブサイトに関連するTwitterアカウントを定義する`twitter:site`タグ（11.31%のページ）です。
* `twitter:creator`タグ（3.58%）は、ウェブページのコンテンツの作者のTwitterアカウントを定義しています。
* `twitter:label1`タグと`twitter:data1`タグ（ともに6.85%のページに掲載）は、ウェブページに関するカスタムデータと属性を定義するために使用できます。追加のラベル／データのペア（例：`twitter:label2`と`twitter:data2`）も、かなりの数（0.5%）のページに存在しています。

これらの例を超えると使用頻度は急速に低下し、（多くの場合、不正、非推奨、または誤った）タグのロングテールになってしまいます。

##### Facebook

Facebookは、Open Graphタグに加えて、Webページをプラットフォーム上の特定のブランド、プロパティ、人物に関連付けるための追加のメタデータ（metaタグ、接頭辞は`fb:`）をサポートしています。

{{ figure_markup(
  image="structured-data-facebook.jpg",
  caption="Facebookメタタグの利用状況",
  description="ウェブ上でのFacebookのメタタグの使用状況を示す棒グラフ。データ中の全モバイルページのうち `fb:app_id`は6.06%、`fb:admins`では2.63%、`fb:pages`は0.86%、`fb:page_id`では0.13%、`fb:profile_id`は0.06%、`fb:use_auto_ad_placement`では0.01%、そして `fb:article_style` は0.01% 以下であることがわかります。デスクトップでの使用も同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=1536454005&format=interactive",
  sheets_gid="1437193020",
  sql_file="facebook_types.sql"
  )
}}

検出されたFacebookタグのうち、有意に採用されたタグは3つだけです。

これらは `fb:app_id`, `fb:admins`, `fb:pages` で、それぞれ6.06%, 2.63%, 0.86% のページで確認されました。

これらのタグは、ウェブページとFacebookページ/ブランドを明示的に関連付けるため、またはこれらのプロファイルを管理するユーザー（または複数のユーザー）に権限を付与するために使用されます。

また、Facebook社がどの程度サポートしているかは不明です。Facebookはここ数年で大きく変化しており、技術文書もあまり整備されていません。しかし多くのコンテンツ管理システム、テンプレート、ベストプラクティスガイド、そしてFacebookのデバッグツールの中には、まだこれらが含まれ、参照されているものがあります。

##### Microformatsとmicroformats2

Microformats（一般に`μF`と略される）は、HTMLにセマンティクスと構造化データを埋め込むためのメタデータのオープンデータ規格です。

これらは、見出しや段落などの通常のHTML要素の背後にある意味を記述する、定義されたクラスのセットで構成されています。

この構造化データのフォーマットは、広く採用されている標準規格（セマンティック（X）HTML）を再利用してセマンティクスを伝えることを指針としています。<a hreflang="en" href="https://microformats.org/wiki/what-are-microformats">公式ドキュメント</a>は、Microformatsを「人間が第一、機械が第二のために設計された」と説明し、「既存の広く採用されている標準に基づいて作られた、シンプルでオープンなデータ形式の集合」であるとしています。

Microformatsは2つのバージョンで提供されています。Microformats v1とMicroformats v2（microformats2）です。2014年3月に導入された後者は、v1を置き換えて優先し、microdataとRDFaの両方の構文から学んだいくつかの重要な教訓を活用しています。

{{ figure_markup(
  image="structured-data-microformats.jpg",
  caption="Microformatsの利用状況",
  description="ウェブ全体におけるMicroformatsマークアップの存在を示す棒グラフ。私たちのデータでは、すべてのモバイルページのうち `adr` は0.50%、 `geo` で0.10%、 `hReview` で0.06%、 `hReview-aggregate` で0.05%、 `hProduct` で0.01%、 `hListing` で0.01%、 `hCard` では0.01%です。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=1769132909&format=interactive",
  sheets_gid="1565986462",
  sql_file="classic_microformats_types.sql"
  )
}}

歴史的に、またその性質上（HTMLの拡張として）、Microformatsは企業や組織のプロパティを記述するために、ウェブサイト開発者によって多用されてきました。とくにローカルビジネスを促進するページ。これは、`adr`プロパティ（ページの0.50％）、レビュー（`hReview`、ページの0.06％）、その他のローカルビジネスとその製品/サービスを特徴付けるための情報が目立つことを説明するのに大いに役立ちます。

{{ figure_markup(
  image="structured-data-microformats2.jpg",
  caption="microformats2の利用状況",
  description="ウェブ上のmicroformats2マークアップの存在を示す棒グラフ。データ中の全モバイルページのうち `h-entry`は0.08% `h-card` では0.04% `h-adr` では0.02% `h-feed` では0.01% `h-item` では0.01% `h-product` では0.01% 未満、 `h-event` では0.01% 未満となっています。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=216200284&format=interactive",
  sheets_gid="214118301",
  sql_file="microformats2_types.sql"
  )
}}

レガシーなマイクロフォーマットとよりモダンなバージョンの違いは大きく、マークアップの使用における行動や嗜好の変化に関する興味深い洞察が得られます。

`adr` クラスが古典的なmicroformatsのデータセットを支配していたところ、同等の `h-adr` プロパティは0.02% のページ上にしか存在しません。この結果は、代わりに `h-entry` プロパティ（ページの0.08% にあり、ブログ記事と同様のコンテンツユニットを記述）と `h-card` プロパティ（ページの0.04% にあり、組織や個人の _名刺_ を記述）によって支配されています。

この差の原因として考えられるのは、次の3点である。

* 一般的なクラス名（`adr`など）のデータは、私たちのmicroformats v1データでは、ほぼ確実に過大評価されています。これらの値が、_構造化データ_とより一般的な理由（たとえば、CSSルールを伴うHTMLクラス属性値として）で使われる場合を見分けるのは困難です。
* 一般的なマイクロフォーマットの使用は（種類を問わず）大幅に減少し、他のフォーマットに置き換えられています。
* 多くのウェブサイトやテーマでは、一般的なデザイン要素やレイアウトに `h-entry` (時には `h-card`) マークアップをまだ含んでいます。たとえば、多くのWordPressテーマでは、メインコンテンツコンテナーに `h-entry` クラスが出力され続けています。

#### Microdata

microformatsやRDFaと同様に、[microdata](https://en.wikipedia.org/wiki/Microdata_(HTML))は、HTML要素に属性を追加することを基本としています。microformatsとは異なりますが、RDFaと同様に、定義された意味の集合に縛られることはありません。この規格は拡張可能で、作者はどのボキャブラリーのデータを記述するかを宣言することができる。もっとも一般的なのはschema.orgである。

microdataの限界の1つは、エンティティ間の抽象的で複雑な関係を記述するのが困難なことで、その関係がページのHTML構造に明示的に反映されていない場合です。

たとえば、ある_組織_の_営業時間_を記述する場合、その情報が文書内で同時に、または論理的に構成されていないと難しいかもしれません。なお、この問題を解決するための標準や方法論（たとえば、インラインの `<meta>` タグやプロパティを含めるなど）はありますが、広く採用されているわけではありません。

{{ figure_markup(
  image="structured-data-microdata.jpg",
  caption="Microdataの種類",
  description="ウェブ上でのmicrodataの利用状況を示す棒グラフ。データ中のすべてのモバイルページ（接頭辞 `schema.org/` を削除して正規化）のうち、 `webpage` は7.44%、 `sitenavigationelement` で5.62%、 `wpheader` で4.87%、 `wpfooter` で4.56%、 `organization` で4.02%、 `blog` で3.66%、 `creativework` で2.14%、 `imageobject` で1.83%、 `blogposting` で1.34%、 `person` では1.37%、 `postaladdress` で1.34%、 `website` で1.33%、 `wpsidebar` で1.38%、 `product` で1.22%、 `imagegallery` が1.11%、 `offer` が1.09%、 `listitem` が0.96%、 `breadcrumblist` が0.96%、そして `article` が0.85% です。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=1112123145&format=interactive",
  width=600,
  height=715,
  sql_file="microdata_item_types.sql"
  )
}}

分析したページでもっとも一般的なmicrodataのタイプは、Webページそのものを記述するもので、`webpage`（7.44%のページ）、`sitenavigationelement`（5.62%のページ）、`wpheader`（4.87% of pages）と`wpfooter`（4.56% of pages）などのプロパティが利用されました。

なぜこのような構造的な記述子がコンテンツ記述子（`person`や`product`など）よりも目立つのかは簡単に推測できます。マイクロデータの作成と維持には、コンテンツ制作者がコンテンツに特定のコードを追加する必要がありますが、それはコンテンツレベルよりもテンプレートレベルで行う方が、簡単なことが多いのです。

マイクロデータの強みの1つは、HTMLマークアップとの明確な関係（およびその中でのオーサリング）ですが、そのため、マイクロデータを使用するための技術的な知識と能力を持つコンテンツ制作者へのアプローチは限られています。

とはいえ、マイクロデータの種類は幅広く、さまざまなものが採用されていることがわかります。特筆すべきは

* `Organization`(4.02%)は、通常、ウェブサイトを公開する会社、製品の製造会社、著者の雇用主、または同様のものを表します。
* `CreativeWork`（2.14％）は、すべての文章と画像コンテンツ（例：ブログ記事、画像、ビデオ、音楽、アート）を記述するもっとも一般的な親タイプです。
* `BlogPosting` (1.34%)、これは個々のブログ投稿を記述します（一般に、著者として `Person` も特定されます）。
* `Person`（1.37%）これは、コンテンツの作者やページに関係する人（例：ウェブサイトの発行者、出版組織のオーナー、商品を販売する個人など）を表すのによく使われます。
* `Product` (1.22%) と `Offer` (1.09%) は、一緒に使用すると、購入可能な製品を説明します（通常、価格、レビュー、入手可能性を説明する追加のプロパティが付きます）。

#### JSON-LD

microdataやmicroformatsとは異なり、<a hreflang="en" href="https://json-ld.org/">JSON-LD</a> はHTMLマークアップにプロパティやクラスを追加することによって実装されるものではありません。その代わり、機械可読のコードは、JavaScript Object Notationの1つまたは複数の独立した塊としてページに追加されます。このコードには、ページ上の実体とその関係の説明が含まれています。

この実装は、ページのHTML構造と直接結びついていないため、複雑な関係や抽象的な関係を記述したり、人間が読めるページの内容では容易に得られない情報を表現することがはるかに容易になります。

{{ figure_markup(
  image="structured-data-json-ld.jpg",
  caption="JSON-LDの利用状況",
  description="ウェブ上のページにおけるJSON-LDの使用状況を示す棒グラフです。データ中の全モバイルのうち `Website` は8.90%、`Organization` で6.00%、`LocalBusiness` で1.67%、`BreadcrumbList` で1.45%、`WebPage` で0.97%、`ItemList` で0.50%、`Product` で0.60%、`BlogPosting` で0.46%、`Person` で0.40%。 30%, `Article` で0.30%, `AutoDealer` で0.23%, `Corporation` で0.20%, `Event` で0.17%, `Store` で0.16%, `VideoObject` で0.15%, `FAQPage` で0.14%, `Restaurant` で0.18% そして `ApartmentComplex` で0.11% であった。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=2104105656&format=interactive",
  sheets_gid="609208795",
  width=600,
  height=676,
  sql_file="jsonld_types.sql"
  )
}}

予想されるように、今回の結果はmicrodataの利用を評価した結果と似ています。どちらのアプローチもschema.orgの使用に大きく偏っているため、この結果は拡大解釈されるでしょう。しかし、いくつかの興味深い違いがあります。

JSON-LD形式は、サイトオーナーがHTMLマークアップとは別にコンテンツを記述できるため、ページのコンテンツへそれほど厳密に縛られない、より抽象的で複雑な関係を表現することが容易になる可能性があるのです。

このことは、今回の調査結果にも反映されており、より具体的で構造化された記述子がマイクロデータよりも一般的であることがわかる。たとえば

* `BreadcrumbList` (ページの1.45%) は、ウェブサイトにおけるウェブページの階層的な位置を説明します（各親ページについても説明します）。
* `ItemList` (ページの0.5%): _レシピ_ の _ステップ_ や _カテゴリー_ の _製品_ など、一連のエンティティを記述します。

これらの例以外では、マイクロデータの時と同じようなパターンが引き続き見られます（規模はかなり小さいですが）。Webサイト、地元企業、組織、Webページの構造に関する記述が、広範な採用の大部分を占めています。

##### JSON-LDの構造および関係

JSON-LDの主な利点の1つは、他のフォーマットよりもエンティティ間の関係をより簡単に記述できることである。

たとえば、_イベント_には、主催する_法人_があり、特定の_場所_で開催され、_オファー_の一部としてチケットが、販売されることがあります。そのイベントを説明する_ブログ記事_には_作成者_があり、といった具合に。このような関係の記述は、他の構文に比べてJSON-LDの方がはるかに簡単で、実体に関する豊かな物語を伝えるのに役立ちます。

しかし、こうした関係は往々にして深く、複雑に絡み合っていくものです。したがって、この分析では、エンティティ間のもっとも一般的なタイプの関係のみを調べ、ツリーや関係構造全体を評価することはしません。

以下は、すべての構造/関係値において、タイプ間のもっとも一般的な接続を、その頻度に基づいて示しています。なお、これらの構造や価値は、より大きな関係性の連鎖の一部であるため、時には重なり合うこともあります。

<figure>
<table>
  <thead>
    <tr>
      <th>関係性</th>
      <th>デスクトップページの%</th>
      <th>モバイルページの%</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`WebSite > potentialAction > SearchAction`</td>
      <td class="numeric">6.44%</td>
      <td class="numeric">6.15%</td>
    </tr>
    <tr>
      <td></td>
      <td class="numeric">5.06%</td>
      <td class="numeric">4.85%</td>
    </tr>
    <tr>
      <td>`@graph > WebSite`</td>
      <td class="numeric">4.89%</td>
      <td class="numeric">4.69%</td>
    </tr>
    <tr>
      <td>`WebPage > isPartOf > WebSite`</td>
      <td class="numeric">4.02%</td>
      <td class="numeric">3.81%</td>
    </tr>
    <tr>
      <td>`@graph > WebPage`</td>
      <td class="numeric">4.01%</td>
      <td class="numeric">3.79%</td>
    </tr>
    <tr>
      <td>`BreadcrumbList > itemListElement > ListItem`</td>
      <td class="numeric">3.93%</td>
      <td class="numeric">3.78%</td>
    </tr>
    <tr>
      <td>`Organization > logo > ImageObject`</td>
      <td class="numeric">2.85%</td>
      <td class="numeric">3.03%</td>
    </tr>
    <tr>
      <td>`@graph > BreadcrumbList`</td>
      <td class="numeric">3.18%</td>
      <td class="numeric">2.99%</td>
    </tr>
    <tr>
      <td>`WebPage > potentialAction > ReadAction`</td>
      <td class="numeric">2.92%</td>
      <td class="numeric">2.71%</td>
    </tr>
    <tr>
      <td>`WebPage > breadcrumb > BreadcrumbList`</td>
      <td class="numeric">2.60%</td>
      <td class="numeric">2.44%</td>
    </tr>
    <tr>
      <td>`WebSite`</td>
      <td class="numeric">2.49%</td>
      <td class="numeric">2.30%</td>
    </tr>
    <tr>
      <td>`@graph > Organization`</td>
      <td class="numeric">2.26%</td>
      <td class="numeric">2.13%</td>
    </tr>
    <tr>
      <td>`WebSite > publisher > Organization`</td>
      <td class="numeric">2.22%</td>
      <td class="numeric">2.09%</td>
    </tr>
    <tr>
      <td>`Product > offers > Offer`</td>
      <td class="numeric">1.47%</td>
      <td class="numeric">1.89%</td>
    </tr>
    <tr>
      <td>`Product`</td>
      <td class="numeric">1.41%</td>
      <td class="numeric">1.73%</td>
    </tr>
    <tr>
      <td>`@graph > ImageObject`</td>
      <td class="numeric">1.80%</td>
      <td class="numeric">1.71%</td>
    </tr>
    <tr>
      <td>`ItemList > itemListElement > ListItem`</td>
      <td class="numeric">1.71%</td>
      <td class="numeric">1.69%</td>
    </tr>
    <tr>
      <td>`@graph > SiteNavigationElement`</td>
      <td class="numeric">1.70%</td>
      <td class="numeric">1.66%</td>
    </tr>
    <tr>
      <td>`WebPage > primaryImageOfPage > ImageObject`</td>
      <td class="numeric">1.67%</td>
      <td class="numeric">1.59%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="JSON-LD entity relations.", sheets_gid="1786787384", sql_file="jsonld_entities_relationships.sql") }}</figcaption>
</figure>

もっとも多い構造は、`website`、`potentialAction`、`SearchAction`スキーマの関係です（構造の6.15%を占めます）。この関係により、Googleの検索結果に<a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">_サイトリンク検索ボックス_</a>を利用できます。

おそらくもっとも興味深いのは、次に多い構造（関係の4.85％）が、関係を定義していないことである。これらのページは、もっとも単純なタイプの構造化データのみを出力し、個々の孤立した実体とそのプロパティを定義する。

次に多い構造（リレーションシップの4.69%）は、`@graph`プロパティを導入しています（`Website`の記述と合わせて）。`@graph` プロパティはそれ自体ではエンティティでないですが、JSON-LDではエンティティ間の関係を含み、グループ化するために使用できます。

さらに関係を探っていくと、`WebPage > isPartOf > WebSite`（関係の3.81%）、`Organization > logo > ImageObject`（関係の3.03%）、`WebSite > publisher > Organization`（関係の2.09%）など、コンテンツと組織の関係についてさまざまな記述が見受けられるようになりました。

また、パンくずナビに関連する構造もたくさん見ることができます。

* `BreadcrumbList > itemListElement > ListItem`（3.78%の関係性）
* `@graph > BreadcrumbList`（2.99%の関係）
* `ItemList > itemListElement > ListItem`（1.69%の関係性）

これらのもっとも一般的な構造以外にも、`ApartmentComplex > amenityFeature > LocationFeatureSpecification` (0.1%の関係性）や `AutoDealer > department > AutoRepair` (0.04%の関係性）、`MusicEvent > performer > PerformingGroup` (0.01%の関係性）など、あらゆるエンティティ、コンテンツタイプ、概念を説明する非常に長いテールの関係を見てとることができます。

このような構造や関係は、ウェブサイトのホームページの分析に限られているため、今回のデータセットが示すよりもはるかに一般的である可能性があることを再度確認しておきます。たとえば、何千もの集合住宅を個別に掲載しているウェブサイトが、内側のページでそれを行っている場合、このデータには反映されないということです。

{{ figure_markup(
  image="structured-data-json-ld-entities-relationships.svg",
  caption="JSON-LDのエンティティ関係をSankey図にしたもの。",
  description='"From" -> "Relationship" -> "To "の形で複雑に絡み合った関係を示すSankey図。`WebPage` は最大の "From" アイテムで、複数の "Relationship" タイプと "To" 結果に分岐しています (たとえば、`WebPage` -> `PotentialAction` -> `SearchAction`)。続いて、`WebSite`、`Organization`、`Product`、`BreadCrumblist`、`BlogPosting`と続き、徐々に他の項目が使用されるようになります。真ん中の"Relationships"の列では、`PotentialAction`がもっともよく使われ、次に `ItemListElement`, `IsPartOf`, `Publisher`, `image` と続き、その後、同様のロングテールでどんどん使用率が下がっていきます。"To"列では、`ImageObject`がもっとも使用されており、次に`Organization`、`SearchAction`、`ListItem`、`WebSite`、`WebPage`と続き、さらに長い尾を引いて使用率が減少しています。このグラフから感じられるのは、3つのカラムの間に多くが混同して使用しており、さまざまな関係があるということです。',
  width=1200,
  height=1200
  )
}}

モバイルページにおけるJSON-LDエンティティ間の相関を示し、フローとして表現することで、エンティティやリレーションシップを視覚的に結びつける図です。各クラスはクラスター内の一意な値を表し、高さはその頻度に比例する。

このグラフでは、分析対象は頻度の高い上位200チェーンに限定しています。

また、このグラフから、一般出版からeコマース、地域ビジネス、イベント、自動車、音楽など、これらのグラフの背景にある分野を概観できます。

##### 関係性の深さ

さらに、モバイルとデスクトップのデータセットにおいて、エンティティ間のもっとも深く複雑な関係を計算しました。

関係が深ければ深いほど、エンティティ（およびそれに関連する他のエンティティ）のより豊かで包括的な記述に等しくなる傾向があります。

{{ figure_markup(
  caption="デスクトップでもっとも深いネスト関係。",
  content="18",
  classes="big-number",
  sheets_gid="597889314",
  sql_file="jsonld_depth_percentiles.sql"
)
}}

深い関係性は

* デスクトップでは、18のネストした接続の深さ。
* モバイルの場合、12個のネスト接続の深さ。

このような構造は、規模が大きくなると記述や維持が困難になるため、手作りのマークアップではなく、プログラムによる出力生成の可能性を示唆するものであると考える価値があります。

##### `sameAs`の使用

構造化データのもっとも強力な使用例の1つは、ある実体が他の実体と`sameAs`であることを宣言することである。ある_もの_を包括的に理解するためには、多くの場合、複数の場所や形式に存在する情報を消費する必要があります。それぞれのインスタンスが他のインスタンスと相互参照できる方法があれば、「点と点を結ぶ」ことが容易になり、その実体をより豊かに理解できます。

このように、`sameAs`は非常に強力なツールであるため、ここではもっとも一般的な`sameAs`の使用方法と関係性について、時間をかけて調べてみました。

{{ figure_markup(
  image="structured-data-json-ld.jpg",
  caption="SameAsの使用状況",
  description="ウェブ上のページにおける `sameAs` 宣言の使用状況を示す棒グラフです。データ中の全モバイルのうち `facebook.com` が4.26%、`instagram.com` が2.74%、`twitter.com` が2.46%、`youtube.com` が1.78%、`linkedin.com` が1.04%、`pinterest.com` が0.60%、`google.com` が0.51%、`yelp.com`、`wikidata.org` が0.12%、`wikipedia.org` が0.11%、 `tumblr.com` が0.08% 、 `uptodown.io` が0.10%、 `vk.com` が0.08%、 `soundcloud.com` が0.04%、 `vimeo.com` が0.03%、 `pinterest.co.uk` が0.03%、 `tripadvisor.com` が0.03%、 `t.me` が0.03%、そして `flickr.com` が0.02% であったと報告しています。デスクトップでの使用率もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3kZ1Ys-9tId-WBa_8muMzrTAu1Ad5TXYgkopXMmBVc1xmd2N_4PZIpEZEOqRL7baymle0kHzaC6KY/pubchart?oid=1501633178&format=interactive",
  sheets_gid="685929099",
  width=600,
  height=638,
  sql_file="jsonld_same_ases.sql"
  )
}}

`sameAs`プロパティは全JSON-LDマークアップの1.60%を占め、ページの13.03%に存在しています。

もっとも一般的な `sameAs` プロパティ（_URL_ から_ホスト名_への正規化）の値は、ソーシャル メディア プラットフォーム（例：facebook.com、instagram.com）と公式ソース（例：wikipedia.org、yelp.com）で、前者の合計が使用率の約75% を占めていることがわかります。

このプロパティは、主にウェブサイトや企業のソーシャルメディアアカウントを特定するために使用されていることは明らかです。おそらく、Googleが検索結果のナレッジパネルを管理するための入力として、このデータに歴史的に依存していることが動機となっているのでしょう。この要件が<a hreflang="en" href="https://twitter.com/googlesearchc/status/1143558928439005184">2019年に非推奨</a>となったことを考えると、このデータセットが今後、徐々に変化していくことが予想されるかもしれません。

## 結論

構造化データは、ウェブ上で広く、そして多様に使用されています。その一部は間違いなく陳腐化していますが（時代遅れのフォーマットを使用したレガシーなサイトやページ）、新しい標準や新興の標準も強力に採用されています。

schema.org（とくにJSON-LD経由）のような最新の標準の採用は、ページやコンテンツに関するデータの提供に対する検索エンジンのサポート（および報酬）を利用したい組織や個人によって動機づけられているように見受けられるという逸話があります。しかし、これ以外にも、他の理由で構造化データを使ってページを充実させている人たちの豊かな風景があるのです。他のシステムと統合し、コンテンツをよりよく理解するため、あるいは_他_の人が_自分自身_のストーリーを語り、独自の製品を構築するのを容易にするためウェブサイトやコンテンツを記述するのです。

深く結びついた構造化データからなるウェブが、より統合された世界を動かすというのは、長い間SF的な夢だった。しかし、おそらく、もうそれほど長くはないでしょう。これらの規格が進化し、その普及が進むにつれ、私たちはエキサイティングな未来への道を切り開くことになります。

### 今後の展開

将来的には、ここで始めた分析を継続し、構造化データ利用の時間的な変遷をマップ化できるようにしたいと考えています。

さらなる探求を期待しています。
