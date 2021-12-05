---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: 2019年版Web AlmanacCMS章では、CMSの採用、CMS組み合わせの構築方法、CMSを搭載したWebサイトのユーザーエクスペリエンス、CMSのイノベーションを取り上げています。
authors: [ernee, amedina]
reviewers: [sirjonathan]
analysts: [rviscomi]
editors: [rviscomi]
translators: [ksakae1216]
discuss: 1769
results: https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/
ernee_bio: Renee Johnsonは、ウェブと製品のコンサルタントであり、WordPressの愛好家であり、WordCampの主催者でありボランティアでもあります。現在は、GoogleのContent Man agement System Developer Relationsチームでプロダクトサポートスペシャリストとして働いています。
amedina_bio: Alberto MedinaはGoogleのWeb Content Ecosystemsチームの開発提唱者で、Ampのような先進的な技術や最新のWeb APIの利用を通じたWeb上の質の高いコンテンツの普及促進に焦点を当てています。Albertoの仕事は現在、コンテンツ管理システムに重点を置いており、CMS開発者関係と呼ばれるコンテンツエコシステムの分野をリードしている。
featured_quote: 一般的にコンテンツ管理システム（CMS）とは、個人や組織がコンテンツを作成、管理、公開するためのシステムのことを指します。特にウェブコンテンツのためのCMSとは、オープンウェブを介して消費され、体験されるコンテンツを作成、管理、公開することを目的としたシステムのことです。各CMSは、コンテンツ管理機能の一部を実装しており、ユーザーがコンテンツを中心としたウェブサイトを簡単かつ効果的に構築するための仕組みを提供しています。
featured_stat_1: 40%
featured_stat_label_1: CMSを利用したページ
featured_stat_2: 74%
featured_stat_label_2: WordPressを利用したCMSサイト
featured_stat_3: 1,232 KB
featured_stat_label_3: デスクトップCMSページごとに読み込まれる画像KBの中央値。
---

## 序章

**コンテンツ管理システム（CMS）**とは、個人や組織がコンテンツを作成・管理・公開するためのシステムを総称しています。具体的には、オープンウェブを介して消費・体験できるコンテンツを作成・管理・公開することを目的としたシステムのことを指します。

各CMSは、ユーザーがコンテンツを中心に簡単かつ効果的にウェブサイトを構築できるように、幅広いコンテンツ管理機能とそれに対応するメカニズムのサブセットを実装しています。このようなコンテンツは多くの場合、何らかのデータベースに保存されており、ユーザーはコンテンツ戦略のために必要な場所であればどこでも再利用できる柔軟性を持っています。CMSはまた、ユーザーが必要に応じてコンテンツを簡単にアップロードして管理できるようにすることを目的とした管理機能を提供します。

サイト構築のためにCMSが提供するサポートの種類と範囲には大きなばらつきがあり、ユーザーコンテンツで「水増し」されたすぐに使えるテンプレートを提供するものもあれば、サイト構造の設計と構築にユーザーの関与を必要とするものもあります。

CMSについて考えるとき、ウェブ上にコンテンツを公開するためのプラットフォームを提供するシステムの実行可能性に関わるすべてのコンポーネントを考慮に入れる必要があります。これらのコンポーネントはすべて、CMSプラットフォームを取り巻くエコシステムを形成しており、ホスティングプロバイダ、拡張機能開発、開発代理、サイトビルダーなどが含まれています。このように、CMSというと、通常はプラットフォームそのものとそれを取り巻くエコシステムの両方を指すことになります。

### コンテンツ制作者はなぜCMSを使うのか？

(ウェブの進化）時代の初期にはウェブのエコシステムはユーザーがウェブページのソースを見て、必要に応じてコピーペーストし画像などの個別の要素で新しいバージョンをカスタマイズするだけでクリエイターになれるという、単純な成長ループで動いていました。

ウェブが進化するにつれ、ウェブはより強力になる一方で、より複雑になりました。その結果、その単純な成長のループは破られ、誰でもクリエイターになれるような状況ではなくなってしまいました。コンテンツ制作の道を追求できる人にとっては、その道のりは険しく困難なものになってしまいました。ウェブでできることと実際にできることの差である<a hreflang="en" href="https://medinathoughts.com/2018/05/17/progressive-wordpress/">利用可能性ギャップ</a>は着実に拡大していきました。

{{ figure_markup(
  image="web-evolution.png",
  caption="1999年から2018年までのWeb機能の増加を示すグラフ。",
  description="左側の1999年頃と書かれたラベルには2本の棒グラフがありますが、できることは、実際に行われていることに近いことを示しています。右側の2018年と書かれたものは、同じような棒グラフですが、できることの方がはるかに大きく、実際に行われていることの方がわずかに大きくなっています。できることと実際にできることのギャップが大きくなっています。",
  width=600,
  height=492
  )
}}

ここでCMSが果たす役割は、技術的な専門性の異なるユーザーがコンテンツ制作者としてウェブのエコシステムのループに入りやすくするという非常に重要なものです。コンテンツ制作への参入障壁を下げることで、ユーザーをクリエイターに変えることで、ウェブの成長ループを活性化させます。それが人気の理由です。

### この章の目標

私たちはCMS空間とウェブの現在と未来におけるその役割を理解するための探求の中で、分析すべき多くの興味深い重要な側面があり、答えるべき質問があります。私たちはCMSプラットフォーム空間の広大さと複雑さを認識しており、そこにあるすべてのプラットフォームに関わるすべての側面を完全にカバーする全知全能の知識を主張しているわけではありませんが、私たちはこの空間への魅力を主張しこの空間の主要なプレイヤーのいくつかについて深い専門知識を持っています。

この章では広大なCMSの空間の表面領域のスクラッチを試み、CMSエコシステムの現状とコンテンツがウェブ上でどのように消費され、どのように体験されるかについてのユーザーの認識を形成する上でのCMSの役割について私たちの全体的な理解に光を当てようとしています。私たちの目標はCMSの状況を網羅的に見ることではなく、CMSの状況全般に関連するいくつかの側面と、これらのシステムによって生成されたウェブページの特徴について論じていきたいと思います。このWeb Almanacの初版はベースラインを確立するものであり、将来的には、トレンド分析のためにこのバージョンとデータを比較できるようになるでしょう。

## CMS導入

{{ figure_markup(
  caption="CMSを搭載したウェブページの割合。",
  content="40%",
  classes="big-number"
)
}}

今日では、ウェブページの40％以上が何らかのCMSプラットフォームを利用していることがわかります。40.01％がモバイル用で、39.61％がデスクトップ用です。

他にも<a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management">W3Techs</a>のようにCMSプラットフォームの市場シェアを追跡しているデータセットがあり、CMSプラットフォームを利用したウェブページの割合が50％を超えていることを反映しています。さらに、これらのデータはCMSプラットフォームが成長しており、場合によっては前年比12％の成長率を記録しています。弊社の分析とW3Techの分析との乖離は、調査方法の違いによって説明できるかもしれません。我々の分析については、[方法論](./methodology)のページを参照してください。

要するに、多くのCMSプラットフォームが存在するということです。下の写真は、CMSの風景を縮小したものです。

{{ figure_markup(
  image="cms-logos.png",
  caption="上位のコンテンツ管理システム。",
  description="WordPress、Drupal、WixなどのトップCMSプロバイダーのロゴマーク。",
  width=600,
  height=559
  )
}}

その中には、オープンソース（WordPress、Drupalなど）のものもあれば、有償（AEMなど）のものもあります。CMSプラットフォームの中には「無料」のホスティングプランやセルフホスティングプランで利用できるものもありますし、企業レベルでも、より高い階層のプランで利用できる高度なオプションもあります。CMS空間全体として複雑で連携した*CMSエコシステム*の世界であり、全てが分離され、同時にウェブの広大な構造に絡み合っています。

またCMSプラットフォームを利用したウェブサイトが何億もあり、これらのプラットフォームを利用してウェブにアクセスし、コンテンツを消費するユーザーが桁違いに増えていることを意味しています。このように、これらのプラットフォームは、常緑で健康的で活力に満ちたウェブを目指す私たちの集団的な探求を成功させるために重要な役割を果たしています。

### CMSの風景

今日のウェブの大部分は、ある種のCMSプラットフォームを利用しています。この現実を反映して、さまざまな組織が収集した統計となります。[Chrome UXレポート](./methodology#chrome-ux-report)(CrUX)とHTTP Archiveのデータセットを見ると、データセットの特殊性を反映して定量的には記載されている割合は異なるかもしれませんが、他の場所で発表されている統計と一致している図が得られます。

デスクトップとモバイルデバイスで提供されているウェブページを見てみると、何らかのCMSプラットフォームによって生成されたページとそうでないページの割合が約60-40％に分かれていることがわかります。

{{ figure_markup(
  image="fig4.png",
  caption="CMSを使用しているデスクトップおよびモバイルサイトの割合。",
  description="デスクトップサイトの40％、モバイルサイトの40％がCMSを使用して構築されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644425372&format=interactive"
  )
}}

CMSを搭載したウェブページは、利用可能なCMSプラットフォームの大規模なセットによって生成されます。そのようなプラットフォームの中から選択するには多くのものがあり、1つを使用することを決定する際に考慮できる多くの要因があり、以下のようなものがあります。

* コア機能
* 作成・編集のワークフローと体験
* 参入障壁
* カスタマイズ性
* コミュニティ
* 他にもたくさん

CrUXとHTTP Archiveのデータセットには、約103のCMSプラットフォームが、混在したウェブページが含まれています。これらのプラットフォームのほとんどは、相対的な市場シェアが非常に小さいものです。今回の分析では、データに反映されているウェブ上でのフットプリントという観点から、上位のCMSプラットフォームに焦点を当ててみたいと思います。完全な分析については、<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/edit#gid=0">この章の結果のスプレッドシートを参照してください</a>。

{{ figure_markup(
  image="fig5.png",
  caption="全CMSウェブサイトに占めるトップCMSプラットフォームの割合。",
  description="WordPressがCMSサイト全体の75％を占めていることを示す棒グラフ。次に大きなCMSであるDrupalは、CMS市場の約6%のシェアを持っています。残りのCMSは急速に採用率が1%未満に縮小しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1652315665&format=interactive",
  width=600,
  height=600,
  data_width=600,
  data_height=600
  )
}}

データセットに含まれる最も顕著なCMSプラットフォームを図14.5に示す。WordPressはモバイルサイトの74.19%、デスクトップサイトの73.47% を占めています。CMSの世界におけるWordPressの優位性は、後述するいくつかの要因に起因していますが、WordPressは主要なプレイヤーです。DrupalやJoomlaのようなオープンソースのプラットフォームと、SquarespaceやWixのようなクローズドなSaaSが上位5つのCMSを占めています。これらのプラットフォームの多様性は、多くのプラットフォームからなるCMSエコシステムを物語っています。また、興味深いのは、上位20位までの小規模CMSプラットフォームのロングテールです。企業向けに提供されているものから、業界特有の用途のために社内で開発された独自のアプリケーションまで、コンテンツ管理システムは、グループがウェブ上で管理、公開、ビジネスを行うためのカスタマイズ可能なインフラストラクチャを提供しています。

WordPressプロジェクト](https://wordpress.org/about/)は、そのミッションを「*出版の民主化*」と定義しています。その主な目標のいくつかは、使いやすさと、誰もがウェブ上でコンテンツを作成できるようにソフトウェアを無料で利用できるようにすることです。もう1つの大きな要素は、このプロジェクトが育んでいる包括的なコミュニティです。世界のほとんどの大都市ではWordPressプラットフォームを理解し、構築しようと定期的に集まり、つながりを持ち共有し、コードを書く人々のグループを見つけることができます。地域のミートアップや年次イベントに参加したり、ウェブベースのチャンネルに参加したりすることは、WordPressの貢献者、専門家、ビジネス、愛好家がそのグローバルなコミュニティに参加する方法の一部となっています。

WordPressの人気は参入障壁の低さと、ユーザー（オンラインと対面）がプラットフォーム上でのパブリッシングをサポートし、拡張機能（プラグイン）やテーマを開発するためのリソースが要因となっています。またWordPressのプラグインやテーマは、ウェブデザインや機能性を追求した実装の複雑さを軽減してくれるので、利用しやすく経済的です。これらの側面が、新規参入者によるリーチと採用を促進するだけでなく、長期的な使用を維持しています。

オープンソースのWordPressプラットフォームは、ボランティア、WordPress Foundation、そしてウェブエコシステムの主要なプレイヤーによって運営されサポートされています。これらの要素を考慮すると、WordPressを主要なCMSとすることは理にかなっています。

## CMSを搭載したサイトはどのように構築されているのか

それぞれのCMSプラットフォームのニュアンスや特殊性とは無関係に、最終的な目標は、オープンウェブの広大なリーチを介してユーザーに提供するウェブページを出力することにあります。CMSを搭載したウェブページとそうでないウェブページの違いは、前者では最終的な結果の構築方法のほとんどをCMSプラットフォームが決定するのに対し後者ではそのような抽象化された層がなく、すべての決定は開発者が直接またはライブラリの設定を介して行うという点にあります。

このセクションでは、CMS空間の現状を出力の特徴（使用された総リソース、画像統計など）の観点から簡単に見ていき、ウェブエコシステム全体とどのように比較するかを見ていきます。

### リソースの総使用量

どんなWebサイトでも、その構成要素がCMSサイトを作っています。[HTML](./markup)、[CSS](./css)、[JavaScript](./javascript)、[media](./media)（画像や動画）です。CMSプラットフォームは、これらのリソースを統合してWeb体験を作成するための強力に合理化された管理機能をユーザーに提供します。これは、これらのアプリケーションの最も包括的な側面の1つですが、より広いウェブに悪影響を及ぼす可能性があります。

{{ figure_markup(
  image="fig6.png",
  caption="CMSページ重量の分布。",
  description="CMSページの重さの分布を示す棒グラフ。デスクトップCMSページの重さの中央値は2.3MBです。10パーセンタイルでは0.7MB、25パーセンタイルでは1.2MB、75パーセンタイルでは4.2MB、90パーセンタイルでは7.4MBとなっています。デスクトップの値は、モバイルよりもわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=991628102&format=interactive"
  )
}}

{{ figure_markup(
  image="fig7.png",
  caption="ページあたりのCMSリクエストの分布。",
  description="ページあたりのCMSリクエストの分布を示す棒グラフ。中央値のデスクトップCMSページは86リソースをロードします。10パーセンタイルでは39リソース、25パーセンタイルでは57リソース、75パーセンタイルでは127リソース、90パーセンタイルでは183リソースをロードします。デスクトップはモバイルよりも3～6リソースの僅差で一貫して高い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=140872807&format=interactive"
  )
}}

上の図14.6と7では、デスクトップCMSページの中央値は86のリソースと2.29MBの重さをロードしていることがわかります。モバイルページのリソース使用量は、83のリソースと2.25 MBと、それほど大きくはありません。

中央値は、すべてのCMSページが上か下かの中間点を示しています。つまり全CMSページの半分はリクエスト数が少なく、重量が少ないのに対し、半分はリクエスト数が多く、重量が多いということになります。10パーセンタイルではモバイルとデスクトップのページはリクエスト数が40以下で重量が1MBですが、90パーセンタイルではリクエスト数が170以上で重量が7MBとなり、中央値の3倍近くになっています。

CMSのページは、ウェブ全体のページと比較してどうでしょうか？　[ページ重量](./page-weight)の章では、リソースの使用量についてのデータを見つけることができます。中央値では、デスクトップページは74リクエストで1.9MBを読み込み、ウェブ上のモバイルページは69リクエストで1.7MBを読み込みます。中央値では、CMSページはこれを上回っています。また、CMSページは90パーセンタイルでウェブ上のリソースを上回っていますが、その差はもっと小さいです。要するに、CMSページは最も重いページの1つと考えられます。

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>image</th>
        <th>video</th>
        <th>script</th>
        <th>font</th>
        <th>css</th>
        <th>audio</th>
        <th>html</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">1,233</td>
        <td class="numeric">1,342</td>
        <td class="numeric">456</td>
        <td class="numeric">140</td>
        <td class="numeric">93</td>
        <td class="numeric">14</td>
        <td class="numeric">33</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">2,766</td>
        <td class="numeric">2,735</td>
        <td class="numeric">784</td>
        <td class="numeric">223</td>
        <td class="numeric">174</td>
        <td class="numeric">97</td>
        <td class="numeric">66</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">5,699</td>
        <td class="numeric">5,098</td>
        <td class="numeric">1,199</td>
        <td class="numeric">342</td>
        <td class="numeric">310</td>
        <td class="numeric">287</td>
        <td class="numeric">120</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプごとのデスクトップCMSページのキロバイト数の分布。") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>image</th>
        <th>video</th>
        <th>script</th>
        <th>css</th>
        <th>font</th>
        <th>audio</th>
        <th>html</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">1,264</td>
        <td class="numeric">1,056</td>
        <td class="numeric">438</td>
        <td class="numeric">89</td>
        <td class="numeric">109</td>
        <td class="numeric">14</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">2,812</td>
        <td class="numeric">2,191</td>
        <td class="numeric">756</td>
        <td class="numeric">171</td>
        <td class="numeric">177</td>
        <td class="numeric">38</td>
        <td class="numeric">67</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">5,531</td>
        <td class="numeric">4,593</td>
        <td class="numeric">1,178</td>
        <td class="numeric">317</td>
        <td class="numeric">286</td>
        <td class="numeric">473</td>
        <td class="numeric">123</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプごとのモバイルCMSページのキロバイト分布。") }}</figcaption>
</figure>

モバイルやデスクトップのCMSページにロードされるリソースの種類を詳しく見ると、画像や動画は、その重さの主な貢献者としてすぐに目立ちます。

影響は必ずしもリクエスト数と相関するわけではなく、個々のリクエストにどれだけのデータが関連付けられているかということです。例えば、中央値で2つのリクエストしかない動画リソースの場合、1MB以上の負荷がかかります。マルチメディア体験には、スクリプトを使用してインタラクティブ性を統合したり、機能やデータを提供したりすることもあります。モバイルページとデスクトップページの両方で、これらは3番目に重いリソースです。

CMSの経験がこれらのリソースで飽和状態にある中で、フロントエンドのウェブサイト訪問者に与える影響を考慮しなければなりません。さらに、モバイルとデスクトップのリソース使用量を比較すると、リクエストの量と重さにはほとんど差がありません。つまり、同じ量と重量のリソースがモバイルとデスクトップの両方のCMS体験を動かしていることになります。接続速度とモバイルデバイスの品質のばらつきは、<a hreflang="en" href="https://medinathoughts.com/2017/12/03/the-perils-of-mobile-web-performance-part-iii/">もう一つの複雑さの層</a>を追加します。この章の後半では、CrUXのデータを使用して、CMS空間でのユーザー体験を評価します。

### サードパーティのリソース

リソースの特定のサブセットを強調して、CMSの世界での影響を評価してみましょう。[サードパーティ](./third-parties)リソースとは、送信先サイトのドメイン名やサーバーに属さないオリジンからのリソースです。画像、動画、スクリプト、その他のリソースタイプがあります。これらのリソースは、例えば`iframe`を埋め込むなど、組み合わせてパッケージ化されていることもあります。当社のデータによると、デスクトップとモバイルの両方で、サードパーティのリソースの中央値は近いことがわかります。

モバイルCMSページのサードパーティリクエストの中央値は15、重さ264.72KBでデスクトップCMSページのサードパーティリクエストの中央値は16、重さ271.56KBです。(これは「ホスティング」の一部とみなされる3Pリソースを除いたものであることに注意)。

{{ figure_markup(
  image="fig10.png",
  caption="CMSページにおけるサードパーティウェイト（KB）の分布。",
  description="デスクトップとモバイルのCMSページにおけるサードパーティのキロバイトの分布を示すパーセンタイル10、25、50、75、90の棒グラフ。デスクトップのサードパーティ重量の中央値（50パーセンタイル）は272KB。10パーセンタイルは27KB、25位104KB、75位577KB、90位940KBとなっています。モバイルはパーセンタイルが小さい方がわずかに小さく、大きい方がわずかに大きくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=354803312&format=interactive"
  )
}}

{{ figure_markup(
  image="fig11.png",
  caption="CMSページの第三者リクエスト数の分布。",
  description="デスクトップとモバイル用のCMSページのサードパーティリクエストの分布を示すパーセンタイル10、25、50、75、90の棒グラフ。デスクトップのサードパーティリクエスト数の中央値（50パーセンタイル）は16。10パーセンタイルは3、25パーセンタイルは7、75パーセンタイルは31、90パーセンタイルは52です。デスクトップとモバイルでは、ほぼ同等の分布となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=699762709&format=interactive"
  )
}}

中央値は、少なくとも半分のCMSウェブページが、ここで報告している値よりも多くのサードパーティのリソースを提供していることを示しています。90パーセンタイルではCMSページは約940KBで52のリソースを配信できますが、これはかなりの増加です。

サードパーティのリソースがリモートドメインやサーバーからのものであることを考えると、送信先のサイトは、これらのリソースの品質やパフォーマンスへの影響をほとんどコントロールできません。この予測不可能性が速度の変動につながり、ユーザー体験に影響を与える可能性があります。

### 画像の統計

{{ figure_markup(
  image="fig12.png",
  caption="CMSページにおける画像の重み（KB）の分布。",
  description="デスクトップとモバイルのCMSページの画像キロバイトの分布を示すパーセンタイル10、25、50、75、90の棒グラフ。デスクトップの画像重量の中央値（50パーセンタイル）は1,232KB。10パーセンタイルは198KB、25パーセンタイル507KB、75パーセンタイル2,763KB、90パーセンタイル5,694KBとなっています。デスクトップとモバイルでは、ほぼ同等の分布となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1615220952&format=interactive"
  )
}}

{{ figure_markup(
  caption="デスクトップCMSページあたりの画像の読み込みキロバイト数の中央値。",
  content="1,232 KB",
  classes="big-number"
)
}}

先に図14.8と14.9を見て、画像はCMSページの総重量に大きく寄与していることを思い出してください。上記の図14.12と14.13は、デスクトップCMSページの中央値は31枚の画像とペイロードが1,232KBであるのに対し、モバイルCMSページの中央値は29枚の画像とペイロードが1,263KBであることを示しています。ここでも私たちは、デスクトップとモバイルの両方の経験のためのこれらのリソースの重量のための非常に近いマージンを持っています。[ページ重量](./page-weight)の章では、さらに、画像リソースがウェブ全体で同じ量の画像を持つページの重量の中央値を十分に上回っていることが示されています。その結果は以下の通りです。CMSページは重い画像を供給している。

モバイルやデスクトップのCMSページでよく見られるフォーマットは何ですか？　当社のデータによると、平均的にJPG画像が最も人気のある画像フォーマットです。次いでPNG、GIFが続き、SVG、ICO、WebPのようなフォーマットが2％強、1％強と大きく後れを取っています。

{{ figure_markup(
  image="fig14.png",
  caption="CMSページでの画像フォーマットの採用。",
  description="デスクトップとモバイルのCMSページにおける画像フォーマットの採用状況の棒グラフ。JPEGが全体の半分近くを占め、PNGが3分の1、GIFが5分の1を占め、残りの5%はSVG、ICO、WebPで占められています。デスクトップとモバイルでは、ほぼ同等の採用率となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=98218771&format=interactive"
  )
}}

おそらく、これらの画像タイプの一般的な使用例を考えると、このようなセグメンテーションは驚くべきものでありません。ロゴやアイコン用のSVGは、JPEGがユビキタスであるのと同様に一般的です。WebPはまだ比較的新しい最適化されたフォーマットであり、<a hreflang="en" href="https://caniuse.com/#search=webp">ブラウザの普及が進んでいます</a>。これが今後数年の間にCMS空間での使用にどのような影響を与えるかを見るのは興味深いことでしょう。

## CMSを搭載したウェブサイトのユーザー体験

ウェブコンテンツ制作者として成功するには、ユーザー体験がすべてです。リソースの使用量やウェブページの構成方法に関するその他の統計などの要因は、サイトを構築する際のベストプラクティスの観点から、サイトの品質を示す重要な指標となります。しかし私たちは最終的に、これらのプラットフォームで生成されたコンテンツを消費したり、利用したりする際にユーザーが実際にどのようにウェブを体験しているのかを明らかにしたいと考えています。

これを実現するために、CrUXデータセットに収録されているいくつかの<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics">利用者目線のパフォーマンス指標</a>に向けて分析を行います。これらのメトリクスは、<a hreflang="en" href="https://paulbakaus.com/tutorials/performance/the-illusion-of-speed/">人として私たちが時間をどのように感じるか</a>に何らかの形で関連しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>持続時間</th>
        <th>知覚</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>< 0.1秒</td>
        <td>瞬間</td>
      </tr>
      <tr>
        <td>0.5-1秒</td>
        <td>即時</td>
      </tr>
      <tr>
        <td>2-5秒</td>
        <td>放棄されるポイント</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="人間がどのようにして短い時間を知覚するのか。") }}</figcaption>
</figure>

0.1秒（100ミリ秒）以内に起こることは、私たちにとっては事実上瞬時に起こっていることです。そして、数秒以上の時間がかかる場合、私たちはそれ以上待たずに生活を続ける可能性が非常に高くなります。これは、ウェブでの持続的な成功を目指すコンテンツ制作者にとって非常に重要なことです。なぜならユーザーを獲得し、魅了し、ユーザーベースを維持したいのであればサイトの読み込み速度がどれだけ速くなければならないかを教えてくれるからです。

このセクションでは、ユーザーがCMSを搭載したウェブページをどのように体験しているのかを理解するために、3つの重要な次元を見てみましょう。

* コンテンツの初回ペイント (FCP)
* 入力の推定待ち時間 (FID)
* Lighthouseスコア

### コンテンツの初回ペイント

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/first-contentful-paint">コンテンツの初回ペイント</a> は、ナビゲーションからテキストや画像などのコンテンツが最初に表示されるまでの時間を測定します。成功したFCPの経験、つまり「速い」と認定される経験とは、ウェブサイトの読み込みが正常に行われていることをユーザーへ保証するため、DOM内の要素がどれだけ速くロードされるかということです。FCPのスコアが良ければ対応するサイトが良いUXを提供していることを保証するものではありませんが、FCPが悪ければ、ほぼ確実にその逆を保証することになります。

{{ figure_markup(
  image="fig16.png",
  caption="CMS全体のFCP経験の平均分布。",
  description="CMSごとのFCP経験値の平均分布を棒グラフにしたもの。以下の図14.17を参照して、上位5つのCMSデータ表を作成した。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644531590&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>速い<br>(&lt; 1000ms)</th>
        <th>中程度</th>
        <th>遅い<br>(&gt;= 3000ms)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">24.33%</td>
        <td class="numeric">40.24%</td>
        <td class="numeric">35.42%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">37.25%</td>
        <td class="numeric">39.39%</td>
        <td class="numeric">23.35%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">22.66%</td>
        <td class="numeric">46.48%</td>
        <td class="numeric">30.86%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">14.25%</td>
        <td class="numeric">62.84%</td>
        <td class="numeric">22.91%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">26.23%</td>
        <td class="numeric">43.79%</td>
        <td class="numeric">29.98%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位5つのCMSのFCP経験値の平均分布。") }}</figcaption>
</figure>

CMSの世界におけるFCPの傾向は、ほとんどが中程度の範囲にあります。CMSプラットフォームがデータベースからコンテンツを照会し、送信し、その後ブラウザでレンダリングする必要があるため、ユーザーが体験する遅延の一因となっている可能性があります。前のセクションで説明したリソース負荷も一役買っている可能性があります。さらに、これらのインスタンスの中には共有ホスティング上にあるものやパフォーマンスが最適化されていない環境もあり、これもブラウザ上での体験に影響を与える可能性があります。

WordPressはモバイルとデスクトップで、中程度のFCP体験と遅いFCP体験を示しています。Wixはクローズドなプラットフォームで中程度のFCP体験が強みです。企業向けオープンソースCMSプラットフォームであるTYPO3は、モバイルとデスクトップの両方で一貫して高速な体験を提供しています。TYPO3は、フロントエンドに組み込まれたパフォーマンスとスケーラビリティ機能がウェブサイトの訪問者にプラスの影響を与える可能性があると宣伝しています。

### 入力の推定待ち時間

<a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">入力の推定待ち時間</a> (FID) は、ユーザーが最初にサイトとやり取りをした時（リンクをクリックした時、ボタンをタップした時、カスタムのJavaScriptを使用したコントロールを使用した時など）から、ブラウザが実際にそのやり取りへ応答できるようになるまでの時間を測定します。ユーザーの視点から見た「速い」FIDとは、サイト上でのアクションからの即時フィードバックであり、停滞した体験ではありません。この遅延(痛いところ)は、ユーザーがサイトと対話しようとしたときに、サイトの読み込みの他の側面からの干渉と相関する可能性があります。

CMS領域のFIDは一般的に、デスクトップとモバイルの両方で平均的に高速なエクスペリエンスを提供する傾向にある。しかし、注目すべきは、モバイルとデスクトップの体験の間に大きな違いがあることです。

{{ figure_markup(
  image="fig18.png",
  caption="CMS全体のFID経験の平均分布。",
  description="CMSごとのFCP経験値の平均分布を棒グラフにしたもの。上位5つのCMSデータ表については、下記の図19を参照のこと。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=625179047&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>速い<br>(&lt; 100ms)</th>
        <th>中程度</th>
        <th>遅い<br>(&gt;= 300ms)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">80.25%</td>
        <td class="numeric">13.55%</td>
        <td class="numeric">6.20%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">74.88%</td>
        <td class="numeric">18.64%</td>
        <td class="numeric">6.48%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">68.82%</td>
        <td class="numeric">22.61%</td>
        <td class="numeric">8.57%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">84.55%</td>
        <td class="numeric">9.13%</td>
        <td class="numeric">6.31%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">63.06%</td>
        <td class="numeric">16.99%</td>
        <td class="numeric">19.95%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="上位5つのCMSのFID経験値の平均分布。") }}</figcaption>
</figure>

この差はFCPのデータにも見られますが、FIDではパフォーマンスに大きなギャップが見られます。例えば、Joomlaのモバイルとデスクトップの高速FCP体験の差は約12.78％ですが、FIDの体験では27.76％と大きな差があります。モバイルデバイスと接続品質が、ここで見られるパフォーマンスの格差に一役買っている可能性があります。以前に強調したように、ウェブサイトのデスクトップ版とモバイル版に出荷されるリソースにはわずかな差があります。モバイル（インタラクティブ）体験のための最適化は、これらの結果から明らかになります。

### Lighthouseスコア

[Lighthouse](./methodology#lighthouse) は、開発者がWebサイトの品質を評価して改善するのに役立つように設計された、オープンソースの自動化ツールです。このツールの重要な側面の1つは、**パフォーマンス**、**アクセシビリティ**、**プログレッシブなWebアプリ**などの観点からWebサイトの状態を評価するための監査のセットを提供することです。この章の目的のために、2つの特定の監査カテゴリに興味を持っています。PWAとアクセシビリティです。

#### PWA

**プログレッシブウェブアプリ** ([PWA](./pwa))という用語は、<a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#reliable">信頼できる</a>、<a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#fast">速い</a>、<a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#engaging">魅力的</a>とみなされるウェブベースのユーザー体験を指します。Lighthouseは、0（最悪）から1（最高）の間のPWAスコアを返す一連の監査を提供しています。これらの監査は、14の要件をリストアップした<a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist#baseline">ベースラインPWAチェックリスト</a>に基づいています。Lighthouseは、14の要件のうち11の要件について自動監査を実施しています。残りの3つは手動でしかテストできません。11の自動PWA監査はそれぞれ均等に重み付けされているため、それぞれがPWAスコアに約9ポイント寄与します。

{{ figure_markup(
  image="fig20.png",
  caption="CMSページのLighthouse PWAカテゴリスコアの分布。",
  description="全CMSページのLighthouse PWAカテゴリスコアの分布を示す棒グラフです。最も一般的なスコアは0.3で、CMSページの22%です。この分布には他にも2つのピークがあります。スコアが0.15のページが11％、スコアが0.56のページが8％です。0.6以上のスコアを取得しているページは1%未満です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1812566020&format=interactive"
  )
}}

{{ figure_markup(
  image="fig21.png",
  caption="CMSごとの灯台PWAカテゴリスコアの中央値。",
  description="CMSごとのLighthouse PWAスコアの中央値を示す棒グラフ。WordPressサイトのスコア中央値は0.33です。次の5つのCMS（Joomla、Drupal、Wix、Squarespace、1C-Bitrix）のスコア中央値はすべて0.3です。PWAのスコアがトップのCMSは、Jimdoが0.56、TYPO3が0.41となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1071586621&format=interactive"
  )
}}

#### アクセシビリティ

アクセシブルなウェブサイトとは、障害者が利用できるように設計・開発されたサイトのことです。Lighthouseは、一連のアクセシビリティ監査を提供し、それらすべての監査の加重平均を返します（各監査の加重方法の完全なリストについては、<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Cxzhy5ecqJCucdf1M0iOzM8mIxNc7mmx107o5nj38Eo/edit#gid=1567011065">スコアリングの詳細</a>を参照してください）。

各アクセシビリティ監査は合格か、不合格かですが他のLighthouseの監査とは異なり、アクセシビリティ監査に部分的に合格してもページはポイントをもらえません。例えば、いくつかの要素がスクリーンリーダーに優しい名前を持っていて他の要素がそうでない場合、そのページは*screenreader-friendly-names*監査で0点を獲得します。

{{ figure_markup(
  image="fig22.png",
  caption="CMSページのLighthouseアクセシビリティカテゴリスコアの分布。",
  description="CMSページのLighthouseアクセシビリティスコアの分布を示す棒グラフ。この分布は、約0.85のモードで、高いスコアに大きく傾いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=764428981&format=interactive"
  )
}}

{{ figure_markup(
  image="fig23.png",
  caption="CMSごとのLighthouseアクセシビリティカテゴリスコアの中央値。",
  description="CMSごとのLighthouseアクセシビリティカテゴリスコアの中央値を示す棒グラフ。ほとんどのCMSのスコアは約0.75です。注目すべき例外としては、Wixのスコア中央値が0.93、1C-Bitrixのスコアが0.65のものがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=940747460&format=interactive"
  )
}}

現在、モバイルCMSのホームページで100％のパーフェクトスコアを獲得しているのは1.27％しかありません。上位のCMSの中では、Wixがモバイルページのアクセシビリティスコアの中央値が最も高く、トップに立っています。全体的に見て、これらの数字は、私たちの人口のかなりの部分がアクセスできないウェブサイトはどれだけ多いか（CMSによって駆動されているウェブのどれだけの部分か）を考えると悲惨なものとなります。デジタル体験が私たちの生活の多くの側面に影響を与えるのと同様に、この数字は私たちに *最初からアクセシブルなウェブ体験を構築すること* を奨励し、ウェブを包括的な空間にする作業を継続するための指令であるべきです。

## CMSイノベーション

ここまでCMSエコシステムの現状をスナップショットで紹介してきましたが、この分野は進化しています。[パフォーマンス](./performance)とユーザー体験の欠点に対処するため、実験的なフレームワークがCMSインフラストラクチャに統合されているのを目の当たりにしています。React.jsやGatsby.js、Next.jsなどの派生フレームワーク、Vue.jsの派生フレームワークであるNuxt.jsなどのライブラリやフレームワークが少しずつ採用されてきています。

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>React</th>
        <th>Nuxt.js,<br>React</th>
        <th>Nuxt.js</th>
        <th>Next.js,<br>React</th>
        <th>Gatsby,<br>React</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">131,507</td>
        <td class="numeric"></td>
        <td class="numeric">21</td>
        <td class="numeric">18</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">50,247</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">3,457</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">2,940</td>
        <td class="numeric"></td>
        <td class="numeric">8</td>
        <td class="numeric">15</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>DataLife Engine</td>
        <td class="numeric">1,137</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Adobe Experience Manager</td>
        <td class="numeric">723</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">7</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Contentful</td>
        <td class="numeric">492</td>
        <td class="numeric">7</td>
        <td class="numeric">114</td>
        <td class="numeric">909</td>
        <td class="numeric">394</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">385</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">340</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>TYPO3 CMS</td>
        <td class="numeric">265</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Weebly</td>
        <td class="numeric">263</td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Jimdo</td>
        <td class="numeric">248</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">223</td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>SDL Tridion</td>
        <td class="numeric">152</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td class="numeric">123</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CMSごとのReactとコンパニオンフレームワークの採用率（モバイルサイト数）。") }}</figcaption>
</figure>

また、ホスティングプロバイダーや代理店が企業の顧客に焦点を当てた戦略のためのツールボックスとして、CMSやその他の統合技術を使用した総合的なソリューションとしてデジタルエクスペリエンスプラットフォーム（DXP）を提供しているのも見受けられます。これらのイノベーションは、ユーザー（とそのエンドユーザー）がこれらのプラットフォームのコンテンツを作成し、消費する際に最高のUXを得ることを可能にするターンキーのCMSベースのソリューションを作成するための努力を示しています。目的は、デフォルトでの優れたパフォーマンス、豊富な機能、優れたホスティング環境です。

## 結論

CMS空間は最も重要な意味を持っています。これらのアプリケーションが力を発揮するウェブの大部分と様々なデバイスや接続でページを作成し、それに遭遇するユーザーの数は、些細なことであってはなりません。この章やこのWeb Almanacに掲載されている他の章が、この空間をより良いものにするためのより多くの研究と技術革新を促してくれることを願っています。深い調査を行うことで、これらのプラットフォームがウェブ全体に提供する強み、弱み、機会について、より良いコンテキストを提供できます。コンテンツ管理システムは、オープン・ウェブの完全性を維持するために影響を与えることができます。コンテンツ管理システムを前進させていきましょう！
