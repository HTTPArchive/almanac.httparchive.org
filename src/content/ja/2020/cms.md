---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: 2020年版Web AlmanacのCMSの章では、CMSの導入、CMSスイートの構築方法、CMSを搭載したWebサイトのユーザーエクスペリエンス、CMSのイノベーションについて取り上げています。
hero_alt: Hero image of Web Almanac characters on a type writer writing a web page.
authors: [alexdenning]
reviewers: [sirjonathan, ernee, amedina]
analysts: [GregBrimble, rviscomi]
editors: [tunetheweb]
translators: [ksakae1216]
alexdenning_bio: Alex Denningは、WordPressビジネス向けのマーケティングエージェンシーである <a hreflang="en" href="https://getellipsis.com/">Ellipsis Marketing</a> の創設者です。アレックスはWordPressのコア・コントリビューターであり、<a hreflang="en" href="https://london.wordcamp.org/">WordCamp London</a>の開催にも協力しています。
discuss: 2051
results: https://docs.google.com/spreadsheets/d/1vTf459CcCbBuYeGvgo-RSidppR62SfM-VTkW-dfS3K4/
featured_quote: コンテンツマネジメントシステム（CMS）とは、個人や組織がコンテンツを作成・管理・公開するためのシステムのことを指します。とくにWebコンテンツ用のCMSは、インターネット上で消費・体験されるコンテンツを作成・管理・公開することを目的としたシステムである。
featured_stat_1: 42%
featured_stat_label_1: WebページはCMSで動く
featured_stat_2: 1.5グラム
featured_stat_label_2: CMSのページロードの中央値で排出されるCO2
featured_stat_3: 74%
featured_stat_label_3: WordPressを使用したCMS（昨年と同じです！）。
---

## 序章

コンテンツマネジメントシステム（CMS）とは、個人や組織がコンテンツを作成・管理・公開するためのシステムを指す。とくにWebコンテンツ用のCMSは、インターネット上で消費・体験されるコンテンツを作成・管理・公開することを目的としたシステムです。

各CMSには、幅広いコンテンツ管理機能の一部が実装されており、ユーザーがコンテンツを使って簡単かつ効果的にWebサイトを構築できるような仕組みになっています。コンテンツは多くの場合、一種のデータベースに格納されており、ユーザーはコンテンツ戦略上必要な場所でコンテンツを再利用できます。また、ユーザーが必要に応じてコンテンツをアップロードしたり、管理したりすることを容易にするための管理機能も備えている。

サイト構築をサポートするCMSにはすぐに使えるテンプレートを提供し、そこにユーザーのコンテンツを追加していくものもあれば、サイト構造の設計・構築にユーザーの関与が必要なものもありその種類や範囲は千差万別です。

CMSを考える際には、ウェブ上でコンテンツを公開するためのプラットフォームを提供するシステムの実現性を担うすべてのコンポーネントを考慮する必要があります。これらのコンポーネントは、CMSプラットフォームを取り巻くエコシステムを形成しており、ホスティングプロバイダー、エクステンション開発者、開発会社、サイトビルダーなどが含まれます。このように、CMSについて語るとき、通常はプラットフォーム自体とその周辺のエコシステムの両方を指しています。

ウェブの現在と未来におけるCMS空間とその役割を理解するためには、分析すべき興味深く重要な側面や答えるべき質問がたくさんあります。私たちはCMSプラットフォームの広大さと複雑さを認識し、好奇心と、この分野の主要なプレイヤーに関する深い専門知識を提供します。

本章では、CMSエコシステムの現状、ウェブ上でコンテンツを消費・体験する方法に関するユーザーの認識を形成する上でCMSが果たす役割、そして環境への影響について理解を深めることを目的としています。本章では、CMSの現状と、CMSによって生成されたWebページの特徴を議論することを目的としています。

Web Almanacの第2版は、昨年の成果を基にしています。2020年の結果と2019年の結果を比較することで、傾向を把握できるようになりました。それでは早速、分析していきましょう。

## なぜ2020年にCMSを使うのか？

2020年、人や組織がCMSを利用するのは、多くの場合、CMSが自分のニーズに合ったウェブサイトを作るための近道となるからです。後述するように、CMSには汎用CMSと特化型CMSがある。一般的なCMSはアドオンによる拡張性が高く、専門的なCMSは特定の業界のニーズや機能に特化していることが多いです。

どのCMSが使われているにせよ、ユーザーや組織の問題を解決するために使われているのです。それぞれのCMSが選ばれる理由を探るのはここでは無理ですが、後ほど、もっともポピュラーなCMSであるWordPressを選ぶ割合が高い理由をご紹介します。

## CMSの採用

この作品を通しての分析は、デスクトップとモバイルのウェブサイトを対象としています。調査したURLの大部分は両方のデータセットに含まれていますが、中にはデスクトップまたはモバイルデバイスでしかアクセスされないURLもあります。このため、データにわずかな差異を発生させる可能性があるため、デスクトップとモバイルの結果を別々に見ています。

Webページの42％以上がCMSプラットフォームを利用しており、2019年から5％以上増加しています。その内訳は、デスクトップでは42.18%で2019年の40.01%から、モバイルでは42.27%で2019年の39.61%から増加しています。

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMSの採用傾向。",
  description="2019年と2020年のCMS導入レベルの上昇を示す棒グラフ。モバイルは39.61%から42.47%に増加。デスクトップは40.01%から42.18%に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=2061880890&format=interactive",
  sheets_gid="1638210080",
  sql_file="cms_adoption_compared_to_2019.sql"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>年</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2019</td>
        <td class="numeric">39.61%</td>
        <td class="numeric">40.01%</td>
      </tr>
      <tr>
        <td>2020</td>
        <td class="numeric">42.27%</td>
        <td class="numeric">42.18%</td>
      </tr>
      <tr>
        <td>% Change</td>
        <td class="numeric">6.71%</td>
        <td class="numeric">5.43%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CMSの採用統計。", sheets_gid="1638210080", sql_file="cms_adoption_compared_to_2019.sql") }}</figcaption>
</figure>

CMSプラットフォームを採用したデスクトップのウェブページの増加率は、昨年比で5.43%となりました。モバイルでは約4分の1の6.71%となっています。

[昨年](../2019/cms#cms-adoption)と同様に、<a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management">W3Techs</a>のようなCMSプラットフォームの市場シェアを追跡するための他のデータセットでも異なる結果が見られます。W3Techsの報告によると、ウェブページの60.6%がCMSで作成されており、1年前の56.4%から増加しています。これは6.4%の増加で、私たちの調査結果とほぼ一致しています。

我々の分析とW3Techsの分析の乖離は、調査方法の違いで説明できます。私たちのものについては、[方法論](./methodology)のページに詳しく書かれています。

私たちの調査では、222の個別のCMSが確認され、これらは1つのCMSに1つのインストールから数百万までの範囲でした。

その中には、オープンソースのもの（WordPress、Joomlaなど）と、プロプライエタリなもの（Wix、Squarespaceなど）があります。後述するように、採用シェアの上位3つのCMSはすべてオープンソースですが、プロプライエタリなプラットフォームは今年、採用シェアを大きく伸ばしています。CMSプラットフォームの中には、「無料」のホスティングやセルフホスティングのプランで利用できるものもありますし、企業レベルでも上位のプランで利用できるオプションもあります。

CMSスペースは全体として、CMSエコシステムの複雑な連合宇宙であり、すべてが分離していると同時に絡み合っています。我々の調査によると、CMSの重要性は増すばかりです。CMSの採用が最低でも5％増加したということは、COVID-19が巨大な不確実性を生み出した年に、強固なCMSプラットフォームが安定性をもたらしたことを示しています。昨年もお話しましたが、CMSプラットフォームは私たちがエバーグリーンで健康的で活気のあるウェブを目指す上で、重要な役割を果たします。このことは昨年よりもさらに真実味を帯びてきており、今後もその傾向が続くものと思われます。

## 上位のCMS

今回の分析では、222のCMSがカウントされました。この数は非常に多いのですが、そのうち204社（92％）は採用率が0.01％以下です。その結果、採用率が0.1～1％のCMSは13社、1～2％のCMSは4社、それ以上のCMSは1社となりました。

2%以上のシェアを持つCMSはWordPressで、31%の利用シェアを持っています。これは、次に人気のあるCMSであるJoomlaの15倍以上のシェアです。

{{ figure_markup(
  image="cms-adoption-share-for-top-5-cmss.png",
  caption="上位5つのCMSの導入シェア",
  description="棒グラフによると、2019年にはWordPressが28.91%のシェアを占め、2020年には31.04%まで伸びることがわかりました。これに続くのは、シェアがそれぞれ2.5%未満の他の4つのCMSです。Joomla（2019年は2.24％、2020年は2.05％）、Drupal（それぞれ2.21％、1.98％）、Wix（0.91％、1.28％）、Squarespace（0.76％、0.97％）です。2020年にはDrupalとJoomlaの使用率が下がり、他は増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1429803707&format=interactive",
  sheets_gid="1594044364",
  sql_file="top_cms_platforms_compared_to_2019.sql"
  )
}}

JoomlaとDrupalは、それぞれ8％と10％の採用シェアを失いましたが、WixとSquarespaceはそれぞれ41％と28％の採用シェアを獲得しました。WordPressはこの1年間でさらに7％の採用シェアを獲得しており、これは次に人気のあるCMSであるJoomlaのシェア合計よりも絶対的な増加率が大きい。

この数字は、デスクトップとモバイルに分けてもほぼ同じです。

{{ figure_markup(
  image="cms-top-5-cms-by-client.png",
  caption="クライアント別のCMSトップ5。",
  description="棒グラフによると、デスクトップで31.37%、モバイルでは31.39%のシェアを持つWordPressが圧倒的であるのに対し、他のCMSは2.5%に満たない。Drupalはデスクトップで2.32％、モバイルで1.99％、Joomlaはデスクトップで1.96％、モバイルで2.12％、Squarespaceはデスクトップで1.08％、モバイルで0.85％、Wizはデスクトップで1.05％、モバイルで1.24％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=2098327336&format=interactive",
  sheets_gid="908727245",
  sql_file="top_cmss_yoy_all_clients.sql"
  )
}}

WordPressの場合は非常に似たような数字になっていますが、他のCMSの場合はその差が大きくなっています。DrupalとSquarespaceでは、モバイルよりもデスクトップの方がそれぞれ16.7%と26.3%多く、JoomlaとWixでは、デスクトップよりもモバイルの方が7.5%と15.2%多くなっています。

普及率0.1～1％のカテゴリーでは、より多くの動きが見られます。これらのカテゴリーでは、50,000サイトまでのCMSが採用されています。

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>2019</th>
        <th>2020</th>
        <th>変更%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">28.91%</td>
        <td class="numeric">31.04%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">2.24%</td>
        <td class="numeric">2.05%</td>
        <td class="numeric">-8%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">2.21%</td>
        <td class="numeric">1.98%</td>
        <td class="numeric">-10%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">0.91%</td>
        <td class="numeric">1.28%</td>
        <td class="numeric">41%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">0.76%</td>
        <td class="numeric">0.97%</td>
        <td class="numeric">28%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">0.55%</td>
        <td class="numeric">0.61%</td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>TYPO3 CMS</td>
        <td class="numeric">0.53%</td>
        <td class="numeric">0.52%</td>
        <td class="numeric">-2%</td>
      </tr>
      <tr>
        <td>Weebly</td>
        <td class="numeric">0.39%</td>
        <td class="numeric">0.33%</td>
        <td class="numeric">-15%</td>
      </tr>
      <tr>
        <td>Jimdo</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.24%</td>
        <td class="numeric">-16%</td>
      </tr>
      <tr>
        <td>Adobe Experience Manager</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.23%</td>
        <td class="numeric">-14%</td>
      </tr>
      <tr>
        <td>Duda</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0.22%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>GoDaddy Website Builder</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0.18%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>DNN</td>
        <td class="numeric">0.20%</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">-19%</td>
      </tr>
      <tr>
        <td>DataLife Engine</td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">-12%</td>
      </tr>
      <tr>
        <td>Tilda</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">100%</td>
      </tr>
      <tr>
        <td>Liferay</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.11%</td>
        <td class="numeric">-10%</td>
      </tr>
      <tr>
        <td>Microsoft SharePoint</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.11%</td>
        <td class="numeric">-25%</td>
      </tr>
      <tr>
        <td>Kentico CMS</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.11%</td>
        <td class="numeric">10819%</td>
      </tr>
      <tr>
        <td>Contao</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td>MyWebsite</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>Concrete5</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">-12%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="小型CMSの相対的な採用率（0.1%～1%の採用シェア）", sheets_gid="1594044364", sql_file="top_cmss_yoy_all_clients.sql") }}</figcaption>
</figure>

ここでは3つの新規参入企業が見られます。Duda、GoDaddy Website Builder、MyWebsiteです。また、TildaとKentico CMSの2つは、ここ1年で採用率が100％以上に変化しています。この「ロングテール」と呼ばれるCMSは、オープンソースとプロプライエタリなプラットフォームが混在しており、消費者向けのものから業界に特化したものまであらゆるものが含まれている。CMSプラットフォーム全体の強みは、考えられるあらゆるタイプのWebサイトを動かす専用ソフトウェアを入手できることです。

他のCMSと比較したCMS導入シェアを見ると（CMSを導入していないウェブサイトを除く）、WordPressの優位性が明らかになります。CMSを導入しているWebサイトの導入シェアは74.2％。この数字を相対化すると、Joomla、Drupal、Wix、Squarespaceの採用率が高くなります。それぞれ4.9%、4.7%、3.1%、2.3%となっています。

{{ figure_markup(
  image="cms-adoption-share-2020.png",
  caption="CMSの採用シェア2020。",
  description="円グラフはCMSの導入状況を示したもので、WordPressが4分の3近く（74.92％）を占め、その他のCMSはそれぞれ5％未満となっています。Joomlaが4.9％、Drupalが4.7％、Wixが3.1％、Squarespaceが2.3％、1C-Bitrixが1.5％、TYPO3 CMSが1.2％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=701401011&format=interactive",
  sheets_gid="1594044364",
  sql_file="top_cmss_yoy_all_clients.sql"
  )
}}

### WordPressの使い方

この分野ではWordPressが圧倒的な存在感を放っているので、さらなる議論が必要です。

<a hreflang="en" href="https://wordpress.org/about/">WordPressは、オープンソースプロジェクト</a>で「出版を民主化する」ことをミッションとするです。このCMSは無料です。これが普及率の重要な要因だと思われますが、次に普及している2つのCMS-JoomlaとDrupalも無料です。WordPressのコミュニティ、コントリビューター、ビジネスエコシステムが大きな差別化要因になっていると思われる。

「コア」なWordPressコミュニティは、CMSを維持し、カスタムサービスや製品（テーマやプラグイン）による追加機能の要件を満たしています。このコミュニティの影響力は非常に大きく比較的少数の人々がCMS自体を維持し、追加機能を提供することでWordPressは十分に強力で柔軟性があり、ほとんどのタイプのWebサイトへ対応できるようになっています。この柔軟性は、市場シェアを説明する上で重要です。

この柔軟性のおかげで、WordPressは開発者やサイトの「構築者」または「実装者」にとって、参入障壁が低いものとなっています。柔軟な拡張機能によってサイト構築が容易になり、それによってますます多くのユーザーがWordPressでより強力なサイトを構築するという好循環が生まれています。ユーザーが増えることで、開発者はより良い拡張機能を作ることができるようになり、このサイクルがさらに進むのです。

{{ figure_markup(
  image="cms-wordpress-plugin-resource-per-page.png",
  caption="ページごとのWordPressプラグインのリソース。",
  description="ページあたりのWordPressプラグインの数を示す棒グラフで、10パーセンタイルではモバイルとデスクトップで4個、25パーセンタイルでは両方で8個、50パーセンタイルでは両方で22個、75パーセンタイルではデスクトップで46個、モバイルで44個、90パーセンタイルではデスクトップで76個、モバイルで74個、100パーセンタイルではデスクトップで1918個、モバイルで1948個となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1286172532&format=interactive",
  sheets_gid="1543932766",
  sql_file="wp_resources.sql"
  )
}}

私たちは、WordPressサイトがこれらの拡張機能をどのように使用しているかを調査しました。これらの拡張機能は、通常WordPressのプラグインです。WordPressサイトの中央値（デスクトップおよびモバイル）では1ページあたり22個のプラグインリソースがロードされており、90パーセンタイルのサイトでは、デスクトップで76個、モバイルでは74個のリソースがロードされていました。100パーセンタイルのサイトでは、デスクトップとモバイルでそれぞれ1918と1948のリソースをロードします。これを他のCMSと比較することはできませんが、WordPressの拡張エコシステムが普及率の高さに大きく貢献していることは間違いなさそうです。

2019年から2020年にかけてのWordPressの採用シェアの伸びは7.40％で、CMS全体の採用数の増加を上回っています。これは、WordPressが「平均的な」CMSを大きく超えた魅力を持っていることを示唆しています。

2020年は「COVID-19」の影響が出ている。このことが市場シェアの増加を説明しているのかもしれません。逸話としては、多くの実在する企業が永久的または一時的に閉鎖されたことで、一般的にウェブサイトへの需要が高まり、最大のCMSであるWordPressがその恩恵を受けていることを示唆しています。この影響を完全に把握するには、今後数年間のさらなる調査が必要です。

CMSの導入シェアが明らかになったところで、次はユーザー体験に注目してみましょう。

## CMSのユーザー体験

CMSは優れたユーザー体験を提供しなければなりません。ウェブの多くがページの提供をCMSに依存している中で、ユーザー体験が良好であることを保証するのは、プラットフォームレベルでのCMSの責任です。私たちの目的は、CMSを搭載したウェブサイトを使用する際の、実際のユーザー体験に光を当てることです。

そのために、ユーザーが感じるパフォーマンスの指標を分析することにしました。この指標は、3つのCore Web Vitals指標と、SEOとAccessibilityカテゴリのLighthouseスコアに反映されています。

### Chromeユーザー体験レポート

このセクションでは、[Chrome User Experience Report](./methodology#chrome-ux-report)で提供されている3つの重要な要素を見てみましょう。これらの要素は、ユーザーがCMSを搭載したウェブページをどのように体験しているかについての理解を深めるのに役立ちます。

- 最大のコンテンツフルペイント (LCP)
- 最初の入力までの遅延 (FID)
- 累積レイアウト変更 (CLS)

これらのメトリクスは、優れたウェブ・ユーザー・体験を示す中核的な要素をカバーすることを目的としています。[パフォーマンス](./performance)の章で詳しく説明しますが、ここではCMSに特化してこれらのメトリクスを見ていきたいと思います。それぞれの項目を順に見ていきましょう。

#### 最大のコンテンツフルペイント

最大のコンテンツフルペイント（LCP）はページのメインコンテンツが読み込まれたと思われる時点を測定し、その結果、そのページがユーザーにとって有用であるかどうかを判断します。これは、ビューポート内に表示される最大の画像やテキストブロックのレンダリング時間を測定することで実現しています。

これは、ページが読み込まれてからテキストや画像などのコンテンツが最初に表示されるまでの時間を測定するコンテンツの初回ペイント（FCP）とは異なります。LCPは、ページのメインコンテンツが読み込まれたとき、測定するのに適したプロキシとされています。

「良い」LCPは2.5秒以下とされています。上位5つのCMSのうち、平均的なウェブサイトはLCPが良くありません。デスクトップではDrupalのみが50％以上のスコアを獲得しています。デスクトップとモバイルのスコアには大きな違いがあります。WordPressはデスクトップで33％、モバイルでは25％とほぼ互角ですが、Squarespaceはデスクトップで37％、モバイルでは12％しかありません。

{{ figure_markup(
  image="cms-real-user-largest-contentful-paint-experiences.png",
  caption="リアルユーザーによる最大のコンテンツフル・ペイント体験。",
  description='上位5つのCMSと、最大のコンテンツフルペイントの体験が「良い」かどうかを示す棒グラフ。WordPressはデスクトップで33％、モバイルで25％と中途半端、Drupalはデスクトップで61％、モバイルで47％と最高、Joomlaはデスクトップで48％、モバイルで28％と2番目に良い、Squarespaceはデスクトップで37％だがモバイルでは12％しかない、Wixはデスクトップで9％、モバイルで9％ともっとも低い結果になりました。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=188727692&format=interactive",
  sheets_gid="465267881",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

ここでは、CMSのパフォーマンスがもっと良くなることを期待していますが、この結果からいくつかのポジティブなものが得られました。まずDrupalウェブサイトの61%が良好なLCPを持っているという事実は、[Chrome UX Report](https://x.com/ChromeUXReport/status/1293306510509039616)によると、良好なLCPを持つウェブサイトの世界的な分布が48%であることよりもはるかに優れているという点で、とくに注目に値します。またWordPressのウェブサイトの3～4つに1つが良いLCPを持っているというのも、WordPressのウェブサイトの数が非常に多いことを考えると、ちょっとした驚きです。Wixには追いつくべき点がありますが、Wixのエンジニアがパフォーマンス問題の修正に[積極的に](https://x.com/DanShappir/status/1308043752712343552)取り組んでいることは心強いので、今後も注目していきたいところです。

#### 最初の入力までの遅延

初回入力遅延（FID）とはユーザーがはじめてサイトにアクセスしたとき（リンクをクリックしたり、ボタンをタップしたり、JavaScriptを使用したカスタムコントロールを使用したときなど）からブラウザがそのインタラクションへ実際に応答するまでの時間を計測したものです。ユーザーの視点から見た「速い」FIDとは、サイト上での行動からのフィードバックがすぐに得られることであり、体験が停滞することではありません。遅延は苦痛であり、ユーザーがサイトと対話したときに、サイトの他の側面の読み込みによる干渉と相関している可能性があります。

平均的なCMSウェブサイトでは、デスクトップでのFIDは非常に速く、Wixだけが100%を下回っておりモバイルではまちまちです。ほとんどのCMSでは、平均的なサイトのモバイルFIDはデスクトップのスコアの妥当な範囲内に収まっています。Wixの場合、モバイルで良好なFIDを持つウェブサイトの数は、デスクトップの合計数の半分近くになります。

{{ figure_markup(
  image="cms-real-user-first-input-delay-experiences.png",
  caption="実際のユーザーによる初回入力遅延の体験",
  description='上位5つのCMS初回入力の遅延体験が「良い」かどうかを示す棒グラフ。デスクトップでは、Wixの87%を除き、すべてのCMSが 100%のスコアを獲得しています。モバイルでは、WordPressが88％、Drupalが76％、Joomlaが71％、Squarespaceが91％、Wixが46％となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=893606466&format=interactive",
  sheets_gid="465267881",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

LCPスコアとは対照的に、FIDスコアは概ね良好です。提案されているようにモバイル接続の品質に加えて、CMS上の個々のページの重みや、デスクトップに比べてモバイル機器の性能が低いこと、ここで見られるFIDに影響するパフォーマンスのギャップに関与している可能性があります。

デスクトップ版とモバイル版のWebサイトに投入されるリソースには、わずかな差しかありません。昨年、モバイル向けの最適化が必要であると指摘しました。平均スコアはデスクトップとモバイルで上昇していますが、モバイルではさらなる注意が必要です。

#### 累積レイアウト変更

累積レイアウト変更（CLS）は、ユーザが最初に入力してから500ms経過した時点でのWebページ上のコンテンツの不安定さを測定するものです。これはとくにモバイルにおいて重要で、ユーザーは検索バーなどのアクションを起こしたい場所をタップしますが、追加の画像や広告などが読み込まれるとその場所は移動してしまいます。

0.1以下は「良い」、0.25以上は「悪い」、その間は「改善が必要」と測定されます。

{{ figure_markup(
  image="cms-real-user-cumulative-layout-shift-experiences.png",
  caption="実際のユーザーによる累積レイアウト変更の体験。",
  description='上位5つのCMSと、累積レイアウト変更の体験が「良い」かどうかを示す棒グラフです。WordPressは、「良い体験」をしたデスクトップサイトが47％、モバイルサイトが57％。Drupalはデスクトップで58％、モバイルで70％、Joomlaはデスクトップで51％、モバイルで63％、Squarespaceはデスクトップで35％、モバイルで44％、Wixはデスクトップで58％、モバイルで59％となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1265001868&format=interactive",
  sheets_gid="465267881",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

上位5社のCMSは、ここを改善できる可能性があります。上位5社のCMSで読み込まれたWebページのうち、CLSエクスペリエンスが「良い」とされたのはわずか50％で、この数字はモバイルでは59％にまで上昇しています。すべてのCMSで、デスクトップの平均スコアは59％、モバイルの平均スコアは67％です。これは、すべてのCMSに課題があることを示していますが、とくにトップ5のCMSは改善が必要です。

### Lighthouseスコア

[Lighthouse](./methodology#lighthouse)は、開発者がウェブサイトの品質を評価・改善するために設計された、オープンソースの自動化ツールです。このツールの重要な点は、パフォーマンス、アクセシビリティ、SEO、プログレッシブWebアプリなどの観点からWebサイトの状態を評価する一連の監査を提供していることです。今年の章では、2つの特定の監査カテゴリーに注目しました。SEOとアクセシビリティです。

#### SEO

検索エンジン最適化（SEO）とは、ウェブサイトのコンテンツが検索エンジンで見つかりやすくなるようにウェブサイトを最適化することです。これについては[SEO](./seo)の章で詳しく説明していますが、その一環として検索エンジンのクローラーにできるだけ多くの情報を提供し検索エンジンの検索結果に、適切に表示されるようサイトをコード化することがあります。カスタムメイドのウェブサイトに比べて、CMSには優れたSEO機能が期待されますが、Lighthouseのこのカテゴリーのスコアは高い評価を示しています。

{{ figure_markup(
  image="cms-seo-lighthouse-score.png",
  caption="SEO LighthouseスコアのCMSトップ5。",
  description="上位5つのCMSのそれぞれのSEOスコアの中央値を示す棒グラフ。WordPressの中央値は0.9、Joomlaは0.86、Drupalは0.83、Wixは0.93、Squarespaceは0.93となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=895876622&format=interactive",
  sheets_gid="1671385936",
  sql_file="median_lighthouse_score.sql"
  )
}}

ここでは、上位5つのCMSのすべてが高いスコアを示しており、中央値は0.83以上、中には0.93に達するものもあります。SEOはウェブサイトの所有者がCMSの機能を利用するかどうかにかかっていますが、CMSでこれらのオプションを簡単に利用できるようにし適切なデフォルト設定を行うことで、そのCMSで運営されているサイトに大きなメリットをもたらすことができます。

#### アクセシビリティ

アクセシブルなウェブサイトとは、障害のある人が利用できるように設計・開発されたサイトのことです。Webアクセシビリティは、インターネットの接続速度が遅い場合など、障害のない人にもメリットがあります。<a hreflang="en" href="https://www.w3.org/WAI/fundamentals/accessibility-intro/#what">詳しい説明はこちら</a>、および[アクセシビリティ](./accessibility)の章でご覧いただけます。

Lighthouseは一連のアクセシビリティ監査を提供しており、それらすべての監査の加重平均を返します（各監査の加重方法の詳細については、 <a hreflang="en" href="https://web.dev/accessibility-scoring/">スコアリングの詳細</a>を参照してください）。

各アクセシビリティ監査は合格か不合格のいずれかですが、他のLighthouse監査とは異なり、ページが部分的にアクセシビリティ監査に合格してもポイントは得られません。たとえば一部の要素にスクリーン・リーダー・フレンドリーな名前が付いていて、他の要素には付いていない場合、そのページはスクリーン・リーダー・フレンドリーな名前の監査で0点を獲得します。

{{ figure_markup(
  image="cms-accessibility-lighthouse-score.png",
  caption="上位5つのCMSのアクセシビリティLighthouseスコア。",
  description="上位5つのCMSそれぞれのアクセシビリティ・コンプライアンス・スコアの中央値を示す棒グラフ。中央値は、WordPressが0.84、Joomlaが0.80、Drupalが0.84、Wizが0.94、Squarespaceが0.90となっており、Wizがリードしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=721104287&format=interactive",
  sheets_gid="1671385936",
  sql_file="median_lighthouse_score.sql"
  )
}}

上位5つのCMSのLighthouseアクセシビリティスコアの中央値は、すべて0.80を超えています。すべてのCMSで、Lighthouseスコアの平均的な中央値は0.78で、最小値は0.44、最大値は0.98です。このように、上位5つのCMSは平均よりも優れており、いくつかのCMSは他よりも優れていることがわかります。WixとSquarespaceは、トップ5の中でもっとも高いスコアを持っています。恐らくこれらのプラットフォームは独自に開発されたものであり、作成されたサイトをより綿密に管理できるため、この点が役に立っているのでしょう。

しかし、ここでのハードルはもっと高いはずです。すべてのCMSの平均スコアが0.78であっても改善の余地は大きく、最大スコアの0.98は、アクセシビリティ対応で「最高」のCMSであっても改善の余地があることを示しています。アクセシビリティの向上は必須かつ緊急の課題です。

## 環境への影響

今年は、CMSが環境に与える影響をより深く理解することを目指しました。<a hreflang="en" href="https://www.nature.com/articles/d41586-018-06610-y">情報・通信技術（ICT）産業は世界の炭素排出量の2%を占めており</a>、とくにデータセンターは世界の炭素排出量の0.3%を占めています。これは、ICT業界のカーボンフットプリントが、航空業界の燃料からの排出量に匹敵することを意味します。ここではCMSの役割についてのデータはありませんが、当社の調査によるとウェブサイトの42％がCMSを使用していることから、CMSがウェブサイトの効率化と環境への影響に重要な役割を果たしていることは明らかです。

私たちの調査では、CMSの平均的なページの重さ（KB）を調べ、<a hreflang="en" href="https://gitlab.com/wholegrain/carbon-api-2-0/-/blob/master/includes/carbonapi.php#L342">carbonapi</a>のロジックを使ってこれをCO2排出量にマッピングしました。その結果、デスクトップとモバイルに分けて以下のような結果が得られました。

{{ figure_markup(
  image="cms-carbon-emissions-per-cms-page-view.png",
  caption="CMSのページビューあたりの炭素排出量。",
  description="CMSページのCO2排出量のグラム数をパーセンタイルで表した棒グラフ。10パーセンタイルではデスクトップが0.5グラム、モバイルが0.4グラム、25パーセンタイルではモバイルとデスクトップの両方が0.8グラム、50パーセンタイルでは両方が1.5グラム、75パーセンタイルではデスクトップが2.8グラム、モバイルが2.7グラム、90パーセンタイルではデスクトップが4.9グラム、モバイルが4.7グラムとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1375803209&format=interactive",
  sheets_gid="1594044364",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_cms_web_page.sql"
  )
}}

その結果、CMSのページロードの中央値は2.41MBの転送となり、1.5gのCO2を排出してることがわかりました。これは、デスクトップとモバイルで同じでした。もっとも効率的なパーセンタイルのCMSウェブページでは少なくとも3分の1のCO2が削減されますが、もっとも効率的でないパーセンタイルのCMSウェブページでは、逆に中央値よりも3分の1以上効率が悪くなります。もっとも効率的なページのパーセンタイルは、もっとも効率的でないパーセンタイルの約10倍の効率性があります。

CMSはあらゆるタイプのWebサイトに対応しているため、このような違いがあるのは当然のことです。しかし、CMSはプラットフォームレベルで、作成したウェブサイトの効率性に影響を与えることができます。

ここで重要なのが、ページの重さです。平均的なデスクトップCMSのWebページは、2.4MBのHTML、CSS、JavaScript、メディアなどを読み込みます。しかし、10％のページは7MB以上のデータを読み込んでいます。モバイルデバイスでは、デスクトップに比べて平均的なWebページのロード量は0.1MB少なく、少なくともすべてのパーセンタイルでこの数値が当てはまります。

{{ figure_markup(
  image="cms-distribution-of-cms-pages-sizes.png",
  caption="CMSのページサイズの分布。",
  description="CMSページのパーセンタイルごとのページサイズ（MB）を示す棒グラフ。10パーセンタイルではデスクトップが0.8MB、モバイルが0.7MB、25パーセンタイルではモバイルとデスクトップの両方で1.3MB、50パーセンタイルではデスクトップが2.4MB、モバイルが2.3MB、75パーセンタイルではデスクトップが4.4MB、モバイルが4.3MB、90パーセンタイルではデスクトップが7.7MB、モバイルが7.4MBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1039607732&format=interactive",
  sheets_gid="1074693681",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_cms_web_page.sql"
  )
}}

CMSでは、外部の画像や動画、スクリプト、スタイルシートなど、第三者のリソースを読み込むことが多くあります。

{{ figure_markup(
  image="cms-third-party-bytes.png",
  caption="サードパーティのバイト",
  description="CMSページのパーセンタイルごとのサードパーティ製バイト量（単位：KB）を示す棒グラフ。10パーセンタイルでは、デスクトップが68.03KB、モバイルが52.97、25パーセンタイルでは、モバイルが179.97KB、モバイルが147.52KB、50パーセンタイルでは、デスクトップが436.44KB、モバイルが397.33MB、75パーセンタイルでは、デスクトップが936.18KB、モバイルが927.64、90パーセンタイルでは、デスクトップが1,735.25KB、モバイルが1,766.15となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1932733912&format=interactive",
  sheets_gid="1916130433",
  sql_file="third_party_bytes_and_requests_on_cmss.sql"
  )
}}

デスクトップ用CMSページの中央値は、サードパーティからのリクエストが27件、コンテンツは436KBで、モバイル用では26件、コンテンツは397KBであることがわかりました。

CMSがページのロードサイズに影響を与える主な方法の1つは、より効率的なフォーマットの使用をサポートし、奨励することです。画像は、ビデオに比べてページの重さへの影響が大きいです。

{{ figure_markup(
  image="cms-median-cms-kb-per-resource-type.png",
  caption="リソースタイプごとのCMS KBの中央値。",
  description="CMSの各リソースタイプのリソースサイズ（KB）の中央値を示す棒グラフ。オーディオはデスクトップで14KB、モバイルで10KB、CSSはデスクトップで102KB、モバイルで98KB、フォントはデスクトップで152KB、モバイルで125KB、画像はデスクトップで1,273KB、モバイルで1,280KB、ビデオはデスクトップで1,665KB、モバイルで2,139KB、XMLはデスクトップ、モバイルともに1KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=74536341&format=interactive",
  sheets_gid="1846606749",
  sql_file="third_party_bytes_and_requests_on_cmss.sql"
  )
}}

ここでは、ビデオがリソースタイプごとに大きな割合を占めています。動画をより効率的にすることや、自動再生を止めることによる影響など、今後の研究対象として興味深い分野です。ここでは、画像に焦点を当てます。一般的な画像フォーマットは、JPEG、PNG、GIF、SVG、WebP、ICOです。これらの中で、<a hreflang="en" href="https://developers.google.com/speed/webp/">WebPはほとんどの状況でもっとも効率的です</a>。WebPのロスレス画像は、同等のPNGと比べて<a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_lossless_alpha_study#results">26%小さく</a>、同等のJPGと比べて<a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">25〜34%小さく</a>なります。しかし、WebPはすべてのCMSページにおいて、2番目に人気のない画像フォーマットであることがわかります。

{{ figure_markup(
  image="cms-popularity-of-image-formats.png",
  caption="画像フォーマットの普及",
  description="CMSにおける画像の種類別の割合を示す棒グラフ。デスクトップとモバイルの両方で、jpgが33％、unknownがデスクトップで25％、モバイルで26％、pngがデスクトップで25％、モバイルで23％、gifが両方で13％、svgが両方で2％、webpがicoと同様に両方で1％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=2011368432&format=interactive",
  sheets_gid="748745523",
  sql_file="adoption_of_image_formats_in_cmss.sql"
  )
}}

上位5つのCMSのうち、Wixだけが自動的にWebPフォーマットの画像を変換して提供しています。WordPress、Drupal、Joomlaは拡張機能でWebPをサポートしていますが、本稿執筆時点ではSquarespaceはWebPをサポートしていません。

先に見たように、Wixは「良好な」LCPを持つサイトの割合がもっとも低い結果となりました。WixがWebPの画像バイトを効率的に利用していることはわかっていますが、画像フォーマット以外にもLCPパフォーマンスに影響を与える問題があることは明らかです。しかし、WebPはより効率的なフォーマットであり、もっとも人気のあるCMSによるこのフォーマットのネイティブサポートの改善は有益です。

画像フォーマットは、画像をより効率的にするための1つのメカニズムです。また、画像の「レイジーローディング」のような他のメカニズムについても、今後の研究が必要です。

CMSが環境に与える影響という質問に完全に答えることはできませんが、答えを出すために貢献しています。CMSには環境への影響を真摯に受け止める責任があり、平均ページ重量を減らすことは重要な仕事です。

## 結論

この1年でCMSの重要性は増しています。インターネット上でコンテンツを作成したり、消費したりするのに欠かせない存在であり、この状況は今後も変わることはないでしょう。CMSの重要性は、年々高まっています。

私たちはCMSの採用、CMSで作成されたウェブサイトのユーザー体験を検討し、また、はじめてCMSが環境に与える影響を調べました。ここでは多くの疑問に答えましたが、さらに多くの疑問が残っています。本章を基にした更なる研究を歓迎します。私たちは、CMSが注意を払う必要のあるいくつかの分野を強調しました。2021年の報告書で共有すべき進展があることを期待しています。

CMSは、インターネットとオープンウェブの成功に不可欠です。継続的な進歩に向けて頑張りましょう。
