---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: 2024年版Web AlmanacのCMSの章では、CMSの導入、CMSプラットフォーム上で動作するウェブサイトのユーザーエクスペリエンス、CMSのリソースウェイトについて解説します。
hero_alt: Webページを作成するタイプライターに乗ったWeb Almanacのキャラクターたちのヒーローイメージ。
authors: [sirjonathan, LoraRaykova, niko-kaleev]
reviewers: [raewrites, dknauss]
editors: [tunetheweb, raewrites]
analysts: [nrllh, sirjonathan]
translators: [ksakae1216]
sirjonathan_bio: Jonathan Woldはオープンウェブの提唱者であり、20年以上にわたってWordPressのエコシステムに注力しています。WordPressとオープンウェブへの愛情はもとより、読書、戦略ゲーム、演技、ロッククライミング、そして時折三人称で文章を書くことを楽しんでいます。
LoraRaykova_bio: LoraはNitroPackのコンテンツマネージャーで、CEE（中東欧）地域のSaaS企業向けに、8年以上にわたって詳細で専門的なコンテンツを開発してきた経験を持っています。
niko-kaleev_bio: NikoはNitroPackのコンテンツライターで、ホスティング、コアウェブバイタル、ウェブパフォーマンス指標、最適化といった微妙なニュアンスを持つトピックを5年以上にわたって分析してきた経験があります。
results: https://docs.google.com/spreadsheets/d/118lwQV_GwFYqIxXvsm57oeadJdjAJEOMCRq1PsTqhfs/
featured_quote: 今年、業界全体でパフォーマンスとユーザーエクスペリエンスへの注目が深まり、CMSプラットフォームはコアウェブバイタルとLighthouseスコアで着実な改善を示しています。多くのCMSが、読み込み速度、インタラクティビティ、アクセシビリティを向上させる最適化戦略を採用しており、ユーザーファーストのウェブへの共通のコミットメントを反映しています。
featured_stat_1: 36%
featured_stat_label_1: WordPressを使用しているモバイルサイトの割合
featured_stat_2: 49%
featured_stat_label_2: CMSを使用しているモバイルサイトの割合
featured_stat_3: 72%
featured_stat_label_3: WordPressが占めるCMS市場シェア
doi: 10.5281/zenodo.14065528
---

この章では、進化し続けるコンテンツ管理システム（CMS）の状況と、ユーザーがウェブ上でコンテンツを体験する方法に対するその影響力の増大を解釈します。私たちは、より広範なCMSエコシステムと、これらのプラットフォームを通じて作成されたウェブページのユニークな特性の両方を探求することを目指します。

CMSプラットフォームは、高速で回復力のあるウェブを構築するための共同作業において極めて重要です。その現状を調査し、批判的な問いを立て、将来の探求分野を特定することで、ウェブパフォーマンスとユーザーエクスペリエンスに対するCMSの影響をより深く理解できます。

今年は、いくつかの人気のあるCMSに関する好奇心と専門知識をもってデータに取り組みました。私たちの分析を、CMSの多様性とそれらがサポートする多様なコンテンツタイプのレンズを通してご覧いただくことをお勧めします。

## CMSとは？

**コンテンツ管理システム（CMS）** とは、個人や組織がデジタルコンテンツ、とくにウェブ上のコンテンツを作成、管理、公開するためのツールです。ウェブベースのCMSは、作成者と訪問者の両方のユーザーエクスペリエンスを優先しながら、ウェブサイトのシームレスな作成と管理を可能にします。

CMSプラットフォームは、ユーザーがウェブサイトを構築するためのさまざまな機能を提供します。ユーザーフレンドリーなテンプレートから、サイトのデザインや構造にユーザーの入力を必要とする、よりカスタマイズ可能なオプションまで多岐にわたります。また、コンテンツ管理を簡素化するための管理ツールも含まれています。

CMSは、サイト作成へのアプローチが大きく異なります。既製のテンプレートやドラッグ＆ドロップのブロックビルダーを提供するものもあれば、ユーザーがレイアウトやサイト構造を設計する必要があるものもあります。アプローチに関わらず、CMSは通常、ホスティングプロバイダー、拡張機能開発者、ウェブ代理店、サイトビルダーなどを含むエコシステムによって支えられています。

Web Almanacのこの章では、2023年と2024年のCMSプラットフォームを取り巻くエコシステム全体を探ります。CMSと言う場合、プラットフォーム自体と、そのエコシステムを形成する関連サービスやツールを指します。

<a hreflang="en" href="https://www.wappalyzer.com/technologies/cms">WappalyzerのCMSの定義</a>に基づき、私たちのデータセットは249の個別のCMSプラットフォームを識別します。

WordPressやJoomlaのようなオープンソースのCMSもあれば、WixやSquarespaceのようなプロプライエタリなCMSもあります。これらのプラットフォームは、無料のセルフホストプランから、プレミアムなエンタープライズレベルのサービスまで、さまざまなホスティングオプションを提供しています。

CMSの状況は、機能、規模、ユーザーエクスペリエンスが異なるプラットフォームが相互接続された多様なエコシステムです。

## CMSの導入

私たちの分析は、デスクトップとモバイルの両方のウェブサイトを対象としています。ほとんどのURLは両方のデータセットに表示されましたが、一部はデスクトップまたはモバイルデバイスからのみアクセスされていました。これらの違いを考慮し、不一致を避けるために、デスクトップとモバイルの結果を別々に分析しました。

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMSの導入状況",
  description="2022年から2024年にかけてのCMS導入状況の棒グラフで、上昇傾向にあります。デスクトップCMSは2022年にサイトの46%、2023年に49%、2024年に51%で使用されています。モバイルでは、それぞれ48%、49%、51%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=2013113638&format=interactive",
  sheets_gid="310746911",
  sql_file="cms_adoption.sql"
  )
}}

2024年6月現在、Web Almanacのデスクトップデータセットに含まれるウェブサイトの51%がCMSによって構築されており、2022年と比較して着実に増加しています。モバイルデータセットでは、2022年の48%から2024年には51%に増加しています。

デスクトップの生データを詳しく見ると、2023年に明確な増加が記録され、ポジティブな傾向が見られます。これは、絶対数とパーセンテージの両方のデータによって裏付けられており、HTTP Archive（およびソースのCrUXデータセット）によって追跡されるデスクトップURLの数は、2022年7月の540万から2024年6月には1,270万に増加しました。追跡されるモバイルURLの数も同様に、モバイルデバイス使用の急増を反映しており、2023年のデータセットでは860万のモバイルURLが増加し、2024年にはわずかに減少しました。

私たちの分析は、W3Techsのような他で一般的に使用されるデータセットとは異なることに注意することが重要です。これらの相違は、調査方法論の違いや、CMSとして何が適格であるかの定義の違いによるものであり、最終的な統計に影響を与えます。

たとえば、前述のように、Wappalyzerは私たちよりも厳格なCMSの定義を使用しており、W3Techのレポートに表示されるいくつかの重要なプラットフォームを除外しています。私たちのCMS基準については、[方法論](./methodology)で詳しく学ぶことができます。

### 地域別のCMS導入状況

2024年6月現在、世界中のCMS導入は着実に増加しており、私たちのデータセットで追跡されるURL数の増加と一致しています。

{{ figure_markup(
  image="cms-adoption-by-geo.png",
  caption="地域別のCMS導入状況",
  description="アメリカ合衆国のCMSはデスクトップサイトの40%、モバイルサイトの44%で使用されています。インドではそれぞれ30%と33%、日本では39%と39%、ドイツでは33%と43%、ブラジルでは31%と32%、グレートブリテンおよび北アイルランド連合王国では36%と42%、フランスでは36%と40%、ロシア連邦では37%と39%、インドネシアでは27%と24%、そして最後にイタリアではデスクトップで41%、モバイルで46%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=2018893523&format=interactive",
  sheets_gid="708001576",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=538
  )
}}

今年は、2022年の分析とは異なり、地理的なCMSの使用状況についてより良い洞察を提供するために、国と地域を区別しています。

CMSの導入率がもっとも高いのはイタリアとスペインで、モバイルサイトの46%から44%（2022年は40%から41%）がCMSで構築されています。ブラジルとインドネシアの導入率はもっとも低く、それぞれわずか32%と24%です。日本ではモバイルCMSの導入が着実に増加しており、2022年の32%に対し2024年は39%です。逆に、インドでは導入率がわずかに減少しています（2022年6月から2%減）。これは、データセットの増加と追跡URLの増加に起因する可能性があり、インドのウェブ開発市場をよりよく理解するのに役立ちます。

モバイル結果の前年比（YoY）分析では、各国で一貫した成長が見られ、CMS導入が全体的に減少するという[2022年の推測](../2022/cms#地域別のcms導入状況)を覆しました。

地域別のCMS導入率が何を示しているかを探ってみましょう。

{{ figure_markup(
  image="cms-adoption-by-region.png",
  caption="地域別のCMS導入状況",
  description="ヨーロッパではCMSがデスクトップサイトの41%、モバイルサイトの46%で使用されていることを示す棒グラフ。アメリカ大陸ではそれぞれ40%と42%。アジアでは34%と33%、オセアニアでは37%と44%、そして最後にアフリカではデスクトップサイトの35%、モバイルサイトの39%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=996685882&format=interactive",
  sheets_gid="729753765",
  sql_file="cms_adoption_by_region.sql"
  )
}}

国別の内訳の傾向に続き、ヨーロッパがCMS導入率でモバイル結果46%を記録し、リードしています。生成された数値に不一致はなく、オセアニアとアメリカ大陸がそれに続きます（それぞれ44%と42%）。北米では、下の小地域別CMS導入グラフが示すように、150万のサイトページでモバイルCMS導入率が44%であることに注意することが重要です。

{{ figure_markup(
  image="cms-adoption-by-subregion.png",
  caption="小地域別のCMS導入状況",
  description="北米ではCMSがデスクトップサイトの41%、モバイルサイトの44%で使用されていることを示す棒グラフ。西ヨーロッパではそれぞれ39%と46%、南ヨーロッパでは43%と49%、東ヨーロッパでは35%と39%、東アジアでは36%と37%、北ヨーロッパでは38%と44%、南アメリカでは34%と35%、南アジアでは30%と31%、東南アジアでは31%と29%、西アジアでは29%と32%、オーストラリアとニュージーランドでは37%と44%、中央アメリカでは37%と39%、南部アフリカでは37%と43%、北部アフリカでは27%と31%、西部アフリカでは27%と36%、東部アフリカでは32%と37%、中央アジアでは25%と33%、カリブ海では30%と37%、中部アフリカでは24%と33%、メラネシアではモバイルサイトの29%（デスクトップデータなし）、そして最後にポリネシアではモバイルサイトの27%（デスクトップデータなし）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=976092675&format=interactive",
  sheets_gid="855626423",
  sql_file="cms_adoption_by_subregion.sql",
  width=600,
  height=701
  )
}}

### ランク別のCMS導入状況

データセットに含まれるサイトの推定ランク別にCMSの導入状況を調査しました。

{{ figure_markup(
  image="top-cms-by-rank.png",
  caption="ランク別のCMS使用状況",
  description="上位1,000サイトではCMSがデスクトップサイトの7%、モバイルサイトの8%で使用されていることを示す棒グラフ。上位10,000サイトではそれぞれ16%と17%。100,000サイトでは21%と21%、1,000,000サイトでは28%と27%、10,000,000サイトでは45%と45%、そして最後に全サイトではデスクトップとモバイルの両方で49%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=337512055&format=interactive",
  sheets_gid="1821067375",
  sql_file="cms_adoption_by_rank.sql"
  )
}}

データセットによると、データセット内の全モバイルサイトの49%がCMSを使用しているにもかかわらず、上位1,000のウェブサイトのうちデスクトップとモバイルの両方でCMSを使用しているのは約8%です。

これは過去数年間の継続的な傾向であり、主にビジネスの規模とそのウェブ開発ニーズの相対的な関係に起因する可能性が高いです。小規模なビジネス（ここではデータセットの大部分を占める）は、手頃な価格と使いやすさから人気のCMSを使用する傾向があります。これらの場合、CMSを特定するのはしばしば簡単です。

対照的に、より上位にランクされるウェブサイトを持つ大企業は、私たちが容易に特定できないカスタムビルドのCMSソリューションを使用することがよくあります。また、CMSの正体を難読化する可能性も高いです。上位1,000の90%以上がCMSを完全に使用しないとは考えにくいです。私たちのデータセットに表示されない可能性の方がはるかに高いです。

上位ランキングのウェブサイトはさておき、今年はすべてのランクグループでCMS導入の大幅な減少が観察されました。CMSを使用するウェブサイトの総割合は、2022年の39%から15%減少し、これは主に2024年のデータセットの規模が拡大したためだと考えられます。

相関する可能性のある傾向として、「ヘッドレス」CMSの採用と、コンテンツ（およびそれを動かすCMS）をエンドユーザーに提供されるフロントエンドエクスペリエンスから切り離す動きがあります。もう一つのもっともらしい説明は、YoYのCMS導入率に使用された追跡URLと比較して、私たちのデータセットのサイズが小さいことです。そこでは一貫した成長が観察されています。

## もっとも人気のあるCMS

トップCMSについてもう少し見てみましょう。

### 上位5CMSの導入成長率

特定可能なCMSを使用しているすべてのウェブサイトの中で、WordPressサイトが相対的な市場シェアの大部分を占めており、2024年のモバイルでの導入率は35%を超えています。それに続くのがWix（2.8%）、Joomla（1.5%）、Squarespace（1.5%）、そしてDrupal（1.2%）です。

{{ figure_markup(
  image="top-cms-yoy.png",
  caption="上位5CMSの前年比",
  description="WordPressは2022年に35.1%、2023年に34.9%、2024年に35.6%使用されたことを示す棒グラフ。Wixはそれぞれ2.4%、2.6%、2.8%。Joomlaは1.9%、1.7%、1.5%。Squarespaceは1.3%、1.4%、1.5%、そして最後にDrupalは1.4%、1.3%、1.2%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1804381043&format=interactive",
  sheets_gid="738765206",
  sql_file="top_cms_yoy.sql"
  )
}}

前年比で見ると、DrupalとJoomlaは市場シェアが減少し続けているのに対し、SquarespaceとWixは成長しています（それぞれ0.5%と0.8%）。WordPressは上昇を続けており、2023年から2024年にかけてモバイルで0.6%増加しました。これは、例年よりも緩やかな成長ペースを表しています。

## CMSのユーザーエクスペリエンス

Core Web Vitalsの導入から4年が経ち、ユーザーエクスペリエンスが優先事項となりました。これにより、ユーザーは主に使いやすさ、プラグイン/拡張機能の数、利用可能なテーマに基づいてCMSプラットフォームを比較していましたが、特定のプラットフォームが提供するデフォルトのユーザーエクスペリエンスという追加の基準が加わりました。

これらのエクスペリエンスを調査するために、<a hreflang="en" href="https://developer.chrome.com/docs/crux">Chrome User Experience Report (CrUX)</a>からデータを収集し、3つの特定の指標を調査しました：

- Core Web Vitals
- Lighthouseスコア
- リソースの重み

### Core Web Vitals

GoogleのCore Web Vitalsは、ユーザー中心の3つのパフォーマンス指標のセットであり、読み込み速度、インタラクティビティ、視覚的安定性に焦点を当て、ユーザーエクスペリエンスの重要な側面を測定します：

- Largest Contentful Paint (読み込み)
- Interaction to Next Paint (インタラクティビティ)
- Cumulative Layout Shift (視覚的安定性)

2020年に導入され、2021年にランキングシグナルになって以来、CWVはウェブ全体で優れたユーザーエクスペリエンスを提供するために不可欠であると認識されています。

より大規模なスケールでウェブサイトがCore Web Vitalsに対してどのようにパフォーマンスを発揮するかに興味がある場合は、[パフォーマンス](./performance)の章でこのトピックをより詳しく扱っています。

このセクションでは、CMSプラットフォームのコンテキストでとくにCore Web Vitalsに注目します。

200以上の既知のCMSプラットフォームがありますが、市場シェアが85%以上あることを考慮して、もっとも使用されている上位10のCMSにリストを絞りました。<a hreflang="en" href="https://lookerstudio.google.com/reporting/55bc8fad-44c2-4280-aa0b-5f3f0cd3d2be/page/M6ZPC">Core Web Vitals Technology Report</a>を使用しました。これは、さまざまなテクノロジーがGoogleのCore Web Vitalsに対してどのようにパフォーマンスを発揮するかについてのグローバルな概要を提供します。

以下は、3つのCore Web Vitalsすべてで「良好」（LCPが2.5秒未満、INPが200ミリ秒未満、CLSが0.1未満）と評価された各プラットフォーム上のサイトの割合です：

{{ figure_markup(
  image="core-web-vitals-yoy.png",
  caption="CMSごとのモバイルでのCore Web Vitalsパフォーマンスの前年比",
  description="WordPressは2023年に合格率28%、2024年に40%、Wixはそれぞれ40%と57%、Joomlaは37%と45%、Drupalは46%と56%、Squarespaceは33%と60%、1C-Bitrixは30%と45%、Dudaは62%と73%、TYPO3 CMSは63%と71%、Tildaは28%と39%、そして最後にWeeblyは40%と49%だったことを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=867117364&format=interactive",
  sheets_gid="216688098",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

主に3つの理由から、モバイルの結果に焦点を当てることにしました：

1. 2024年7月現在、モバイルは世界のトラフィックシェアの68.29%を占めています
2. モバイルデバイスにはリソースと接続性の制限があり、日常のユーザーがウェブをどのように体験するかをより現実的に描写します
3. すべてのCMSプラットフォーム、およびテクノロジー全般は、デスクトップでより良いスコアを出します

それはさておき、10すべてのCMSプラットフォームがCore Web Vitalsを改善したことがわかります。Squarespaceは前年比で28%という驚異的な改善を遂げ、トップに立っています。上位3つには、18%のWixと14%の1C-Bitrixが含まれます。リストは次のようになります：WordPress（前年比11%）、Tilda（前年比11%）、Duda（前年比11%）、Drupal（前年比10%）、Weebly（前年比10%）。最下位はTYPO3 CMSの9%とJoomlaの8%です。

これらの前年比の改善は、トップ10のCMSが集合的に提供する総合的なCore Web Vitals合格率と同様に注目に値します。参考までに、2024年6月現在のすべてのオリジンのグローバルCWV合格率は51%です。

Duda、TYPO3 CMS、Squarespaceのようなプラットフォームがその数値をはるかに上回る結果を出していることは、これらのプラットフォームがユーザーエクスペリエンスの向上に注力してきた努力の証です。

さて、3つのCore Web Vitalsを掘り下げて、各プラットフォームがどこを改善できるか、そして2023年からどの指標がもっとも改善したかを見てみましょう。

#### Largest Contentful Paint (LCP)

Largest Contentful Paintは、ページ内で最も大きな要素（Above the fold）が読み込まれるまでにかかる時間を測定します。LCPスコアが2.5秒未満であれば「良好」と見なされます。

この指標は、ユーザーがウェブページ上で最も意味のあるコンテンツをどれだけ迅速に確認できるかを表します。

3つのCore Web Vitalsの中で、LCPは最適化が最も困難です。そのため、LCPの合格率は最も低く、CWVを合格するためのボトルネックと見なされています。

LCPがこれほど難しい指標である理由は、その最適化に多くの可動部分があるためです。以下を行う必要があります：

1. LCPリソースのできるだけ早い読み込み開始を保証する。
2. LCPリソースの読み込み完了後、LCP要素がすぐにレンダリングされるようにする。
3. 品質を犠牲にすることなく、LCPリソースの読み込み時間をできるだけ短縮する。
4. 初期のHTMLドキュメントをできるだけ速く配信する。

しかし、トップ10のCMSは、前年比のLCP改善と総合スコアに関して、いくつかの素晴らしい結果を示しました：

{{ figure_markup(
  image="lcp-yoy.png",
  caption="モバイルでの年次CMS LCPパフォーマンス。",
  description="2023年と2024年のCMSパフォーマンスの変化を示す棒グラフ。WordPressは2023年にサイトの28%がLCPに合格し、2024年には40%が合格しました。Wixはそれぞれ40%と57%、Joomlaは37%と45%、Drupalは46%と56%、Squarespaceは33%と60%、1C-Bitrixは30%と45%、Dudaは62%と73%、TYPO3 CMSは63%と71%、Tildaは28%と39%、そして最後にWeeblyは2023年にCore Web Vitalsに合格したサイトが40%、2024年には49%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1116621071&format=interactive",
  sheets_gid="216688098",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

年次統計に飛び込む前に、世界のLCP合格率（2024年6月時点）が63.4%であることに注意してください。グラフからわかるように、プラットフォームの半数以上がより良い結果を達成しています。

2023年からどれだけ改善したかを考えると、Squarespaceは再び他のCMSを上回り、前年比で27%の改善を遂げました。Wixは13%で2位、WordPressは11%で3位です。残りのプラットフォームの改善は10%未満でした。

#### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS) は、レイアウトの安定性を測定するために使用される指標です。画面上のコンテンツが予期せずどれだけ移動したかを反映します。

ウェブサイトは、全サイト訪問の少なくとも75%が0.1以下のスコアであれば、良好なCLSを持つと見なされます。

{{ figure_markup(
  image="cls-yoy.png",
  caption="モバイルでのCMS CLSパフォーマンスの前年比",
  description="2023年から2024年にかけてのCMSのCLSパフォーマンスの変化を示す棒グラフ。WordPressは良好なサイトが77%から82%に改善、Wixは94%から87%に、Joomlaは73%から77%に、Drupalは82%から86%に、Squarespaceは72%から87%に、1C-Bitrixは75%から79%に、Dudaは89%から88%に、TYPO3 CMSは83%から86%に、Tildaは87%から88%に、そしてWeeblyは66%から66%になりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1756885568&format=interactive",
  sheets_gid="216688098",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

年次データを比較すると、CLSの結果はLCPや総合的なCWV合格率ほど印象的ではないことがわかります。ほとんどのプラットフォームはほとんど進歩がなく、Duda、Wix、Weeblyは2023年の結果を改善するのに苦労しました。

#### Interaction to Next Paint (INP)

2023年に発表され、年内は実験段階にあったInteraction to Next Paintは、2024年3月12日に正式にFirst Input Delay (FID) に代わる新しいインタラクティビティのコアウェブバイタル指標となりました。

INPは、ユーザーのページ訪問中のすべての対象となるインタラクションの遅延を観察することにより、ユーザーのインタラクションに対するページの応答性を評価します。最終的なINP値は、観測されたもっとも長いインタラクションです。

簡単に言うと、この最新のコアウェブバイタルは、インタラクション（たとえば、マウスクリック）からブラウザが画面を更新（またはペイント）できるまでの時間を測定します。

200ミリ秒以下のINPは、ページが良好な応答性を持つことを意味します。

入力遅延、処理時間、表示遅延を含むインタラクション全体の遅延を考慮すると、INPの導入はコアウェブバイタルの全体的な合格率の低下につながりました。

そうは言っても、INPがもたらした大きな変化を考えると、トップ10のCMSが示した前年比の改善と総合的なCWV合格率はさらに印象的です。

INPスコアに関しては、プラットフォームの大部分が80%以上の合格率を達成しています。

{{ figure_markup(
  image="inp-yoy.png",
  caption="モバイルでのCMS INPパフォーマンスの前年比",
  description="2023年から2024年にかけてのCMS INパフォーマンスの変化を示す棒グラフ。WordPressは良好なサイトが69%から82%に改善、Wixは50%から85%に、Joomlaは69%から79%に、Drupalは71%から83%に、Squarespaceは85%から90%に、1C-Bitrixは36%から60%に、Dudaは70%から87%に、TYPO3 CMSは86%から93%に、Tildaは44%から60%に、そしてWeeblyは68%から74%になりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=670977052&format=interactive",
  sheets_gid="216688098",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

合格できなかったCMSにはTildaと1C-Bitrixが含まれ、これらは前年比で改善したにもかかわらず、依然として84.1%という世界基準を達成するのに苦労しています。

#### FIDの非推奨

First Input Delayはもはやコアウェブバイタルの指標ではありません。さらに、Chromeは2024年9月9日にFIDのサポートを正式に非推奨としました。

INPがFIDに取って代わった主な理由は、測定範囲と包括性です。

Web Almanacの過去の版を見ると、すべてのウェブサイトがデスクトップで良好なFIDスコアを持ち、モバイルでもほぼすべてが良好でした。このデータは、訪問者が遅延のあるウェブサイトをめったに経験しないことを示すはずです。

残念ながら、現実にはウェブにはしばしば応答性の問題があります。そしてFIDはもはやそれを正確に測定していませんでした。

FIDの問題は、最初の入力の遅延のみを測定し、処理時間と表示遅延を無視し、ユーザーセッション全体のページの応答性を捉えることができなかった点にありました。

対照的に、INPはユーザーセッション全体にわたるページの応答性を評価し、ユーザーエクスペリエンスのより包括的で正確な表現を提供します。

### Lighthouse

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>は、ウェブページの品質を向上させるために設計されたオープンソースの自動化ツールで、以下の4つのカテゴリに基づいてウェブサイトを評価する一連の監査を提供します。

- パフォーマンス
- アクセシビリティ
- SEO
- ベストプラクティス

Lighthouseは、ウェブサイトのパフォーマンスを向上させるための実用的な提案を開発者に提供するラボデータを含むレポートを生成します。ただし、Lighthouseスコアは<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">CrUX</a>によって収集された実際のフィールドデータに直接影響を与えないことに注意することが重要です。Lighthouseの<a hreflang="en" href="https://web.dev/lab-and-field-data-differences/">ラボスコアとフィールドデータの違い</a>についてさらに詳しく調べることができます。

HTTP Archiveは、モバイルとデスクトップのウェブページでLighthouseを実行し、[モバイル向けにスロットルされたCPUパフォーマンスを持つ低速の4G接続](./methodology#lighthouse)をシミュレートします。

このデータを分析することで、CrUXが監視していない指標も捉える合成テストを通じて、CMSのパフォーマンスに関する異なる視点を得ることができます。

#### パフォーマンススコア

Lighthouseの<a hreflang="en" href="https://web.dev/performance-scoring/">パフォーマンススコア</a>は、いくつかのスコアリングされた指標の加重平均です。

{{ figure_markup(
  image="lighthouse-performance-score.png",
  caption="Lighthouseパフォーマンススコアの中央値",
  description="WordPressのCMSパフォーマンススコアの中央値はデスクトップで61、モバイルで38、Wixはそれぞれ85と55、Squarespaceは60と30、Joomlaは58と39、Drupalは65と40、Dudaは80と59、1C-Bitrixは51と33、Weeblyは71と33、TYPO3 CMSは65と47、そしてTistoryは54と29であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=2144802411&format=interactive",
  sheets_gid="14177383",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

2022年の結果では、ほとんどのモバイルプラットフォームのパフォーマンススコアの中央値が約19から35の範囲でしたが、2024年にはモバイルとデスクトップの両方のウェブサイトで素晴らしい改善が見られます。

WixとDudaは、それぞれ85と80というデスクトップパフォーマンススコアの中央値で明確なリーダーとして際立っており、Dudaはモバイルでより高いスコアを達成しています。次にWeebly、Drupal、TYPO3 CMS、WordPress、Squarespaceが続き、Lighthouseのカラーコーディングスキームによれば、オレンジ色の「改善が必要」ステータスでマークされたパフォーマンススコアの中央値を示しています。

全体的なポジティブな傾向は、ブラウザとCMSのネイティブおよび技術的な改善によるものであり、高品質なウェブパフォーマンスの重要性が全体的に認識されていることを示しています。

WixやDudaなどのプロプライエタリなプラットフォームが示す大幅な増加は、CMSの運用方法に部分的に関連しています。つまり、パフォーマンス分野でのイノベーションの速度を向上させる、効率化された一元的な開発の恩恵を受けています。

過去数年で結論付けたように、モバイルスコアが低いことは、Lighthouseがエミュレートしようとするものと同様の不安定なネットワーク接続を持つローエンドデバイスに焦点を当てた、よりスマートなソリューションと最適化の機会となります。さらに、利用可能なより高速なCPUとネットワークを考えると、モバイルデバイスがデスクトップのカウンターパートに遅れをとるのは当然です。それにもかかわらず、2024年の結果は励みになるものであり、CMSプラットフォームがLighthouseのパフォーマンス指標に関してどのように推移するかを引き続き追跡していきます。

##### パフォーマンススコアの年次トレンド

{{ figure_markup(
  image="lighthouse-mobile-perf-yoy.png",
  caption="Lighthouseモバイルパフォーマンススコアの中央値。",
  description="2023年と2024年のCMSパフォーマンススコアの前年比を示す棒グラフ。WordPressは2023年が33、2024年が38、Wixは50と55、Squarespaceは28と30、Joomlaは35と39、Drupalは36と40、Dudaは56と59、1C-Bitrixは31と33、Tildaは36と37、TYPO3 CMSは42と47、Weeblyは32と33でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=270170798&format=interactive",
  sheets_gid="1754565121",
  sql_file="lighthouse_category_scores_per_cms_yoy.sql",
  width=600,
  height=559
  )
}}

2023年から2024年にかけてのパフォーマンスデータの前年比比較は、トップCMSプラットフォーム間で段階的な改善という心強い傾向を示しています。DudaとWixは引き続きモバイルパフォーマンスをリードしており、DudaはLighthouseスコアの中央値が56から59に、Wixは50から55に上昇しました。WordPressも改善を示し、33から38に増加しました。同様にJoomlaは35から39へ、Drupalは36から40へと移行しました。これらの結果は、モバイルパフォーマンスの最適化に対する業界全体の幅広い焦点を反映していますが、SquarespaceやWeeblyなどの一部のプラットフォームはわずかな向上しか示していません。これらのさまざまな改善は、CMSプラットフォームがモバイルデバイスでのユーザーエクスペリエンス向上に取り組む中での継続的な課題と優先事項を浮き彫りにしています。

#### SEOスコア

検索エンジン最適化（SEO）は、ウェブサイトが検索エンジンで見つけやすくなるように、ウェブサイトへの訪問者の質と量を向上させる実践です。このトピックは[SEO](./seo)の章で扱われていますが、CMSにも関連しています。

CMSとその上のコンテンツは、通常、検索エンジンのクローラーができるだけ多くの情報を取得し、検索エンジンの結果でサイトのコンテンツを適切にインデックス付けしやすくするために設定されています。カスタムビルドのウェブサイトと比較して、CMSは優れたSEO機能を提供することが期待され、このカテゴリのLighthouseスコアは適切に高いままです。

{{ figure_markup(
  image="lighthouse-seo-score.png",
  caption="Lighthouse SEOスコアの中央値",
  description="WordPressのCMS SEOスコアの中央値はデスクトップで92、モバイルで92、Wixはそれぞれ100と100、Squarespaceは92と92、Joomlaは92と92、Drupalは85と85、Dudaは92と92、1C-Bitrixは92と92、Weeblyは85と91、TYPO3 CMSは92と92、そしてTistoryは92と85であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1386400078&format=interactive",
  sheets_gid="14177383",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

トップ10プラットフォームのSEOスコアの中央値は85〜100の範囲で、[2022年の82〜92](../2022/cms#SEOスコア)から素晴らしい増加です。高いパフォーマンススコアの中央値を考えると、WixがSEOでもリードし、モバイルとデスクトップの両方で完璧な100点を獲得したことは驚きではありません。モバイルとデスクトップで92という高い中央値スコアを持つ次点のプラットフォームは、ユーザーに堅牢なSEOベストプラクティスを提供しています。

##### SEOの年次トレンド

{{ figure_markup(
  image="lighthouse-mobile-seo-yoy.png",
  caption="LighthouseモバイルSEOスコアの中央値",
  description="2023年と2024年のCMS SEOスコアの前年比を示す棒グラフ。WordPressは2023年が90、2024年が92、Wixは97と100、Squarespaceは93と92、Joomlaは88と92、Drupalは85と85、Dudaは86と92、1C-Bitrixは86と92、Tildaは91と100、TYPO3 CMSは89と92、そしてWeeblyは85と91でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=61098748&format=interactive",
  sheets_gid="1754565121",
  sql_file="lighthouse_category_scores_per_cms_yoy.sql",
  width=600,
  height=559
  )
}}

2023年から2024年にかけての前年比比較では、トップCMSプラットフォーム全体で一貫して高いSEOスコアが明らかになり、ほとんどが中央値を維持またはわずかに改善しています。このハイエンドでの安定性は、CMSプラットフォームがSEOのベストプラクティスを優先していることを示唆しており、ユーザーが検索エンジンの可視性のための強固な基盤を持っていることを保証しています。

#### アクセシビリティスコア

アクセシブルなウェブサイトとは、障害を持つ人々が利用できるように設計・開発されたサイトのことです。ウェブアクセシビリティは、低速なインターネット接続を使用している人々など、障害のない人々にも利益をもたらします。詳細は[アクセシビリティ](./accessibility)の章でご覧ください。

Lighthouseは一連のアクセシビリティ監査を提供し、それらすべての加重平均を返します。各監査がどのように重み付けされるかの完全なリストについては、<a hreflang="en" href="https://web.dev/accessibility-scoring/">スコアリングの詳細</a>を参照してください。

各アクセシビリティ監査は合格か不合格かのいずれかですが、他のLighthouse監査とは異なり、アクセシビリティ監査を部分的に合格してもページはポイントを獲得できません。たとえば、一部の要素にはスクリーンリーダーフレンドリーな名前が付いているが、他の要素には付いていない場合、そのページはスクリーンリーダーフレンドリーな名前の監査で0点を獲得します。

{{ figure_markup(
  image="lighthouse-a11y-score.png",
  caption="Lighthouseモバイルアクセシビリティスコアの中央値。",
  description="WordPressのCMSアクセシビリティスコアの中央値はデスクトップで86、モバイルで86、Wixはそれぞれ95と94、Squarespaceは93と94、Joomlaは83と83、Drupalは86と85、Dudaは89と88、1C-Bitrixは75と75、Weeblyは86と86、TYPO3 CMSは84と84、そして最後にTistoryは78と74であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=476143776&format=interactive",
  sheets_gid="14177383",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

2024年、トップ10 CMSのLighthouseアクセシビリティスコアの中央値は74から95の範囲にあり、[2022年の77から91からわずかに改善](../2022/cms#アクセシビリティスコア)しています。SquarespaceはWixにわずかな差でトップの座を明け渡し、Wixはモバイルとデスクトップでそれぞれ94と95のマークを達成しました。1C-Bitrixは2024年に最も低いアクセシビリティスコアを記録し、デスクトップとモバイルの両方で2ポイントのわずかな減少を示しています。これはおそらく、同じサイトがデスクトップとモバイルデバイスの両方に配信されていることを反映しています。

##### アクセシビリティの年次トレンド

{{ figure_markup(
  image="lighthouse-mobile-a11y-yoy.png",
  caption="Lighthouseモバイルアクセシビリティスコアの中央値。",
  description="2023年と2024年にわたるCMSアクセシビリティスコアの前年比を示す棒グラフ。WordPressは2023年に87、2024年に86、Wixは94と94、Squarespaceは92と94、Joomlaは84と83、Drupalは87と85、Dudaは88と88、1C-Bitrixは77と75、Tildaは81と84、TYPO3 CMSは86と84、そして最後にWeeblyは86と86でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=476143776&format=interactive",
  sheets_gid="1754565121",
  sql_file="lighthouse_category_scores_per_cms_yoy.sql",
  width=600,
  height=559
  )
}}

2023年から2024年の比較では、トップCMSプラットフォーム全体でアクセシビリティスコアがほぼ安定していることが明らかになり、ほとんどが最小限の変化を示しています。WixはSquarespaceと共にリードを共有し、両年ともに高いスコアの94を維持しています。Squarespaceは2023年の92から改善し、2024年にはWixの94に並びました。注目すべきは、WordPress、Joomla、Drupal、TYPO3がいずれもわずかな低下を見せたことです。これらのスコアは、プロプライエタリCMS全体でアクセシビリティへの継続的な重視を示唆しており、オープンソースCMSには改善の余地があることを示しています。

#### ベストプラクティス

Lighthouseの<a hreflang="en" href="https://web.dev/lighthouse-best-practices/">ベストプラクティス</a>監査は、ウェブページがさまざまな指標にわたって広く受け入れられているウェブ標準に準拠しているかどうかを評価します。これには、次のような重要な要素が含まれます。

- HTTPSサポート、
- コンソールエラーの排除、
- 非推奨APIの回避、
- ブラウザ互換性の最適化、
- セキュリティプロトコル、
- など。

これらのベストプラクティスに従うことで、開発者はウェブサイトの機能とユーザーエクスペリエンスの両方を向上させ、さまざまなブラウザやデバイスでより安全で安定した、信頼性の高いパフォーマンスを確保できます。

{{ figure_markup(
  image="lighthouse-best-practices-score.png",
  caption="Lighthouseベストプラクティススコアの中央値",
  description="WordPressのCMSベストプラクティススコアの中央値はデスクトップで78、モバイルで79、Wixはそれぞれ78と79、Squarespaceは100と96、Joomlaは78と79、Drupalは78と79、Dudaは78と79、1C-Bitrixは56と57、Weeblyは56と57、TYPO3 CMSは96と96、そしてTistoryは74と79であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1321714408&format=interactive",
  sheets_gid="14177383",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

2024年の私たちの分析は、2022年の結果と比較して、全体的に大きな変化を示しています。SquarespaceがWixから首位を奪い、ベストプラクティススコアの中央値が100と最高になりました。一方、他のトップ10プラットフォームの多くは78というスコアを共有しています（2022年からわずかに改善）。

他のほとんどのCMSがベストプラクティス監査で悪い数値を示す中、TYPO3 CMSは2022年の83と92（それぞれモバイルとデスクトップ）と比較して、モバイルとデスクトップの両方で96の中央値スコアを獲得し、2位を主張しています。

##### ベストプラクティスの年次トレンド

{{ figure_markup(
  image="lighthouse-mobile-best-practices-yoy.png",
  caption="Lighthouseモバイルベストプラクティススコアの中央値",
  description="2023年から2024年にかけてのCMSベストプラクティススコアの前年比を示す棒グラフ。WordPressは2023年の92から2024年には79に、Wixは92から79に、Squarespaceは92から96に、Joomlaは83から79に、Drupalは83から79に、Dudaは92から79に、1C-Bitrixは75から57に、Tildaは83から79に、TYPO3 CMSは92から96に、そしてWeeblyは83から57になりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=10302778&format=interactive",
  sheets_gid="1754565121",
  sql_file="lighthouse_category_scores_per_cms_yoy.sql",
  width=600,
  height=559
  )
}}

2023年から2024年にかけての前年比比較では、ほとんどのCMSプラットフォームでベストプラクティスのスコアが安定していることがわかります。SquarespaceとTYPO3 CMSは2024年にトップの座を分け合い、それぞれ96のベストプラクティススコアを獲得しました。WordPress、Wix、Joomla、Drupal、Duda、Tildaを含む他のほとんどのプラットフォームは79の安定したスコアを維持し、ウェブ標準への一貫した準拠を反映しています。対照的に、1C-BitrixとWeeblyは57と低いスコアで、これらのプラットフォームがベストプラクティスのコンプライアンスで改善できる領域を浮き彫りにしています。

## リソースの重み

HTTP Archiveのデータを活用して、さまざまなCMSプラットフォームのリソースの重みを分析し、パフォーマンス最適化の機会を見つけることを目指しました。ページの読み込み速度はダウンロードされるバイト数だけで決まるわけではありませんが、ページの読み込みに必要なデータ量を減らすことにはいくつかの利点があります。

バイト数が少ないということは、帯域幅コストの削減、二酸化炭素排出量の削減、そしてとくに接続が遅いユーザーにとってのパフォーマンス向上を意味します。この分析は、リソースの最適化がユーザーエクスペリエンスと持続可能性の両方に意味のある影響を与えることができる領域に光を当てます。より詳細な分析については、[ページ重量](./page-weight)の章をお読みください。

{{ figure_markup(
  image="median-cms-page-weight.png",
  caption="CMSページ重量の中央値",
  description="人気のCMSのページ重量の中央値を示す棒グラフ。WordPressの中央値はデスクトップで2,252KB、モバイルで2,047KB、Wixは2,560KBと2,215KB、Squarespaceは3,323KBと3,015KB、Joomlaは2,133KBと2,035KB、そしてDrupalはデスクトップで1,903KB、モバイルで1,762KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=255848791&format=interactive",
  sheets_gid="1442275519",
  sql_file="resource_weights.sql"
  )
}}

過去数年間、ページ重量の増加傾向が着実に観察されましたが、2024年には、トップ5のCMSのほぼすべてが注目すべき改善を示しています。Drupalのページ重量の中央値は、2022年の約2.1MBから約1.7MBに減少しました。WordPressとJoomlaは現在、2022年の約2.3MBに対し、約2MBに近い値で推移しています。Wixは、ページ重量の中央値がわずかに増加した唯一のCMSで、2022年の2.1MBに対し2.2MBです。Squarespaceは、2022年の約3.5MBに対し、約3MBというもっとも重いページ重量の中央値を引き続き提供しています。

{{ figure_markup(
  image="cms-page-weight-distribution.png",
  caption="CMSのページ重量の分布",
  description="さまざまなパーセンタイルにおけるキロバイト（KB）単位のページ重量を示す棒グラフ。WordPressは10パーセンタイルで598KB、25パーセンタイルで1,101KB、50パーセンタイルで2,047KB、75パーセンタイルで3,959KB、90パーセンタイルで7,826KBです。Wixはそれぞれ1,217KB、1,565KB、2,215KB、3,322KB、6,369KBです。Squarespaceは1,594KB、2,076KB、3,015KB、5,013KB、9,404KBです。Joomlaは561KB、1,021KB、2,034KB、4,303KB、9,052KBです。Drupalは524KB、937KB、1,762KB、3,500KB、7,160KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1457951957&format=interactive",
  sheets_gid="2016584461",
  sql_file="page_weight_distribution.sql"
  )
}}

各プラットフォームのパーセンタイルにおけるページ重量の分布はかなり大きいです。ページ重量は、ウェブページ間のユーザーコンテンツの違い、使用される画像の数、インストールされているプラグインなどに関係している可能性があります。プラットフォームごとに配信されるもっとも小さいページはDrupalからで、WordPressが僅差で続いています。両者とも2022年の結果（それぞれ2.1MBと2.3MB）から改善しています。

今年、Drupalは10パーセンタイルの訪問に対してわずか524KBしか送信していませんが、JoomlaとWordPressも大きく遅れをとってはおらず、それぞれ561KBと598KBです。注目すべき減少を見せつつも、依然としてここで最大のページを提供しているのはSquarespaceで、90パーセンタイルの訪問に対して約9.4MBを配信しており、2022年のデータと比較して約2MBの減少です。

### ページ重量の内訳

ページ重量とは、ウェブページに読み込まれるすべてのリソースの合計サイズをキロバイト単位で測定したものを指します。これらのリソース（画像、JavaScript、CSS、HTML、フォントなど）は、集合的にページのパフォーマンスに影響を与えます。

以下では、さまざまなCMSプラットフォーム間のリソースの重みを分析・比較し、各CMSが全体のページ重量にどのように貢献しているかについての洞察を提供します。

#### 画像

画像はほとんどのウェブサイトで重要なリソースであり、しばしばページ重量の大部分を占めます。デザインとエンゲージメントのためにビジュアルが多用されるCMSプラットフォームでは、画像の最適化が不可欠です。高解像度の画像は、適切に圧縮されたり、WebPのような最新のフォーマットで提供されたりしない場合、ページの読み込み時間を遅くする可能性があります。詳しくは[メディア](./media)の章をお読みください。

{{ figure_markup(
  image="cms-size-of-images.png",
  caption="CMSの画像サイズの中央値",
  description="人気のCMSの画像重量の中央値を示す棒グラフ。WordPressの中央値はデスクトップで833KB、モバイルで725KB、Wixはそれぞれ312KBと152KB、Squarespaceは1,226KBと921KB、Joomlaは1,035KBと988KB、そしてDrupalはデスクトップで741KB、モバイルで653KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1544422290&format=interactive",
  sheets_gid="1442275519",
  sql_file="resource_weights.sql"
  )
}}

2024年、Wixは引き続き大幅に少ない画像バイト数を配信しており、モバイルビューの中央値でわずか152KB（2022年より138KB少ない）です。これは、画像圧縮と遅延読み込みがうまく利用されていることを示唆しています。他のトップ4プラットフォームはすべて1MB未満の画像を配信しており、2022年のデータ（WordPress 1.1MB、Squarespace 約1.7MB、Joomla 約1.5MB、Drupal 約1.1MB）と比較して大幅な改善です。

高度な画像フォーマットは圧縮を大幅に改善し、リソースの節約とサイトの高速読み込みを可能にします。WebPは今日、すべての主要なブラウザで一般的にサポートされており、95%以上のサポート率を誇ります。さらに、AVIFなど、より新しい画像フォーマットの人気と採用が続いています。

トップCMS全体でのさまざまな画像フォーマットの使用状況を調べることができます。

{{ figure_markup(
  image="image-format-popularity-by-cms.png",
  caption="CMS別のモバイルでの画像フォーマット人気度",
  description="さまざまなCMSにおける画像フォーマットの人気度を示す積み上げ棒グラフ。ほとんどがJPG 30〜50%、PNG 30%、GIF 10〜20%で、WebP、SVG、ICO、AVIFは10%未満です。例外はWixで、WebPが大量（70%）に使用されており、Dudaも同様に46%のWebPを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1032342538&format=interactive",
  sheets_gid="809952267",
  sql_file="image_format_popularity.sql",
  width=600,
  height=556
  )
}}

2024年、WixとDudaは引き続きWebPを最大限に活用しており、それぞれ約75%と約60%の採用率ですが、その他はわずかな増加にとどまっています。

WebPは現在広くサポートされていますが、プラットフォームがこのフォーマットを十分に活用していないことが依然として観察されます。WebPのサポートが拡大するにつれて、すべてのプラットフォームは、画質を損なうことなく古いJPEGおよびPNGフォーマットの使用を減らすために取り組むべきことがあるようです。

WordPress 5.8以降、WordPressはWebPフォーマットをサポートし、アップロードされた画像を自動的にWebPに変換するように設定できます。しかし、このフォーマットの人気は2022年のデータと比較して頭打ちになっているようです。これは、WordPressのコアパフォーマンスチームがプラットフォームの一般的なパフォーマンス改善に対して、より包括的なアプローチを選択したことで説明できます。詳しくは[2024年のWordPress](#2024年のWordPress)のセクションをお読みください。

#### JavaScript

JavaScriptは、現代のウェブサイトのインタラクティブな機能の多くを動かしています。CMSプラットフォームは、動的コンテンツの読み込み、フォーム検証、ユーザーエンゲージメントツールなどの機能を有効にするために、さまざまなJSライブラリやフレームワークを頻繁に使用します。しかし、過剰または最適化が不十分なJavaScriptは、パフォーマンスに悪影響を与える可能性があります。詳しくは[JavaScript](./javascript)の章で詳細な情報をご覧ください。

{{ figure_markup(
  image="cms-size-of-js.png",
  caption="CMSのJSサイズの中央値",
  description="人気のCMSのJavaScript重量の中央値を示す棒グラフ。WordPressの中央値はデスクトップで565KB、モバイルで528KB、Wixはそれぞれ1,461KBと1,462KB、Squarespaceは1,309KBと1,314KB、Joomlaは409KBと386KB、そしてDrupalはデスクトップで479KB、モバイルで471KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1698213507&format=interactive",
  sheets_gid="1442275519",
  sql_file="resource_weights.sql"
  )
}}

2024年、私たちはJavaScriptの使用量が全体的に増加しているのを観察します。トップ5のCMSのほぼすべてが2022年のデータと比較してより多くのJavaScriptを配信しており、Squarespaceは997KBから約1.3MBへと大幅に増加しています。Wixは依然としてもっとも多くのJavaScriptを配信しており、約1.3MBから約1.4MBへとわずかに増加しています。DrupalとWordPressはJavaScriptのわずかな増加を示し、Joomlaは409KBと最小のJSを配信しています（2022年の452KBから改善）。

#### HTML

HTMLは、レイアウトとコンテンツを定義し、あらゆるウェブページの構造的なバックボーンを形成します。CMSプラットフォームはHTMLコードの多くを自動生成するため、時に肥大化して非効率なマークアップになることがあります。HTMLは通常、他のリソースと比較して軽量ですが、最適化されていない、または過度に複雑なHTML構造は、依然としてレンダリング時間とユーザーエクスペリエンスに影響を与える可能性があります。詳しくは[マークアップ](./markup)の章で詳細な情報をご覧ください。

{{ figure_markup(
  image="cms-size-of-html.png",
  caption="CMSのHTMLサイズの中央値",
  description="人気のCMSのHTML重量の中央値を示す棒グラフ。WordPressの中央値はデスクトップで40KB、モバイルで38KB、Wixはそれぞれ142KBと143KB、Squarespaceは25KBと25KB、Joomlaは19KBと18KB、そしてDrupalは20KBと20KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=417293866&format=interactive",
  sheets_gid="1442275519",
  sql_file="resource_weights.sql"
  )
}}

HTMLドキュメントのサイズを調べると、トップCMSのほとんどが約22KB〜38KBの中央値HTMLサイズを配信していることがわかります。唯一の例外はWixで、約142KBを配信しており、2022年の結果から著しく増加しています。これは、インラインリソースの広範な使用を示唆しており、さらに改善できる領域を示しています。

#### CSS

CSSは、レイアウト、色、フォントなどの要素を決定し、ウェブサイトの視覚的なスタイリングを制御します。CMSプラットフォームでは、テーマやテンプレートに未使用または冗長なスタイルを含む広範なCSSファイルが付属していることがよくあります。大きなCSSファイルは、ページ重量を増加させ、レンダリング時間を遅くする可能性があります。

{{ figure_markup(
  image="cms-size-of-css.png",
  caption="CMSのCSSサイズの中央値",
  description="人気のCMSのCSS重量の中央値を示す棒グラフ。WordPressの中央値はデスクトップで121KB、モバイルで118KB、Wixはそれぞれ12KBと5KB、Squarespaceは133KBと133KB、Joomlaは89KBと86KB、そしてDrupalはデスクトップで72KB、モバイルで70KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=2059559160&format=interactive",
  sheets_gid="1442275519",
  sql_file="resource_weights.sql"
  )
}}

2024年、CSSをインライン化するケースを強化するプラットフォーム間で異なる分布が見られます。Wixはもっとも少ないCSSリソースを配信し、2022年のモバイルビューで9KBから5KBに減少しました。Squarespaceは今年、2022年の89KBから133KBへと大幅に多くのCSSを配信しています。WordPressは2022年の数値からわずかに増加し、CSS配信で2位です。Drupalもわずかな増加を示していますが、Joomlaは2024年により少ないCSSを配信した唯一のCMSプラットフォームです。

#### フォント

CMSベースのウェブサイトは、ブランディングと視覚的な魅力を高めるために、さまざまなフォントを頻繁に提供します。しかし、フォントはページにさらなる重みをもたらす可能性があり、とくに複数のフォントファミリーやバリエーションが読み込まれる場合はそうです。最適化されていないフォントの読み込みは、テキストのレンダリングを遅らせ、ユーザーエクスペリエンスに影響を与える可能性があります。詳しくは[フォント](./fonts)の章で詳細な内訳をご覧ください。

{{ figure_markup(
  image="cms-size-of-fonts.png",
  caption="CMSのフォントサイズの中央値",
  description="人気のCMSのフォント重量の中央値を示す棒グラフ。WordPressの中央値はデスクトップで182KB、モバイルで152KB、Wixはそれぞれ154KBと125KB、Squarespaceは184KBと169KB、Joomlaは120KBと100KB、そしてDrupalはデスクトップで123KB、モバイルで104KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=655172650&format=interactive",
  sheets_gid="1442275519",
  sql_file="resource_weights.sql"
  )
}}

今年、トップ5のCMSはすべて、配信されるフォントバイト量に変化を示しています。Squarespaceは引き続き169KB（2022年の202KBから大幅に減少）と最高の量を配信しています。Wixもフォントファイルの配信量がわずかに減少していますが、WordPress、Joomla、Drupalはすべて配信されるフォントバイト量が増加しています。Googleがホストするフォントの統合が進むことが、来年の結果に影響を与えるかどうかは興味深いところです。

## 2024年のWordPress

{{ figure_markup(
  caption="WordPressを使用しているモバイルサイトの割合",
  content="36%",
  classes="big-number",
  sheets_gid="1621293918",
  sql_file="top-cms-by-geo.sql"
)
}}

今年のクロールに含まれる1600万以上のモバイルサイトのうち、WordPressは570万サイトで使用されており、全サイトの36%を占めています。比較すると、次に近いCMSはWixで、456,253サイト、つまりサイトの3%です。

WordPressの世界的な優位性は、主に2つの要因に起因します。オープンソースプロジェクトの機能を維持・改善するコミュニティと、幅広いウェブサイトやユーザーに対応するCMSの柔軟性です。

さらに、数万ものプラグイン、テーマ、ページビルダーが利用可能であるため、あらゆる技術的背景を持つユーザーがWordPressを選択することができます。しかし、機能を拡張するこれらの簡単な方法は、特にパフォーマンスに関しては諸刃の剣となることがあります。

次のセクションでは、ページビルダーの採用状況と、Core Performance Teamによって導入された改善点をレビューします。

### ページビルダー

{{ figure_markup(
  image="top-5-page-builders.png",
  caption="トップ5のページビルダー。",
  description="サイトで使用されているトップ5のページビルダーを示す棒グラフ。Elementorはデスクトップサイトの54%とモバイルの56%で使用され、wpBakeryは両方で21%、Diviは両方で14%、SiteOrigin Page Builderは両方で2%、最後にOxygenはデスクトップとモバイルの両方で1%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQYh0RHAqp768faimbvZpvS71yJwCaOAFR0AzgotkEphtxphBKR1kt-pqgxA8Uxj4FSii1RQWwgG6rk/pubchart?oid=1601231589&format=interactive",
  sheets_gid="1497515207",
  sql_file="wordpress_page_builders.sql"
  )
}}

WordPressユーザーは、CMS内でコンテンツ管理のインターフェースを提供する「ページビルダー」をよく活用します。Wappalyzerの検出方法の改善により、2022年の結果と比較してページビルダーの採用トレンドを追跡することができます。

ページビルダーに帰属するWordPressサイトの中で、ElementorとWPBakeryが依然として明確な勝者であることがわかりました（それぞれモバイルで13%と12%の増加）、Divi、SiteOrigin、Oxygenが後に続きます。

今日見る限り、ページビルダーはサイトのパフォーマンスに大きな影響を与える可能性があります。歴史的に、ページビルダーはパフォーマンスが悪いという逸話的な指標でした。たとえば、私たちのデータセットでは、複数のページビルダーがインストールされているウェブサイトが珍しくないことを示しています。これにより、サイトが読み込むリソースが大幅に増加します。

しかし、ネイティブのパフォーマンス改善と進歩のおかげで、ページビルダーはよりスリムな代替案を提供する傾向があり、サイトオーナーの間でますます人気が高まっています。ウェブサイトを開発する際のベストプラクティスと組み合わせることで、WordPressでの全体的なパフォーマンスを向上させることができ、次のセクションでさらに詳しく説明します。

### WordPressの最新のパフォーマンス改善

WordPress Core Performance Teamは、WordPressコアとその周辺エコシステムのパフォーマンスを監視、強化、促進します。このグループは、WordPressコアのパフォーマンスを向上させるために2021年に設立され、それにより平均的なWordPressサイトのパフォーマンスが向上しました。

2024年に進むと、チームは期待を超え、WordPressの各主要リリースにわたって多数のパフォーマンスアップデートを統合しました。

さらに、2021年11月にプロジェクトを開始して以来、WordPressの全体的なCore Web Vitals合格率は12%上昇しました。

{{ figure_markup(
  image="wordpress-cwv-pass-trend.png",
  caption="WordPress Core Web Vitals合格率のトレンド。",
  description="2020年1月に15%未満だったWordPressオリジンのCore Web Vitals合格率が、2024年7月までに41%に着実に増加していることを示す折れ線グラフ。",
  width=1752,
  height=888
  )
}}

これらの結果をもたらした改善点の一部は次のとおりです：

- **WordPress 6.0**: <a hreflang="en" href="https://make.wordpress.org/core/2022/04/29/caching-improvements-in-wordpress-6-0/">WordPress Caching API</a>、<a hreflang="en" href="https://make.wordpress.org/core/2022/04/28/taxonomy-performance-improvements-in-wordpress-6-0/">タクソノミー用語クエリ</a>、および<a hreflang="en" href="https://make.wordpress.org/core/2022/05/02/performance-increase-for-sites-with-large-user-counts-now-also-available-on-single-site/">大規模ユーザー数を持つサイトのパフォーマンス向上</a>の改善
- **WordPress 6.3**: コアに統合された170以上の<a hreflang="en" href="https://make.wordpress.org/core/2023/08/07/wordpress-6-3-performance-improvements/">パフォーマンスアップデート</a>、ブロックおよびクラシックテーマのLCPとTTFBの改善、画像に対する*<a hreflang="en" href="https://make.wordpress.org/core/2023/07/13/image-performance-enhancements-in-wordpress-6-3/">fetchpriority="high"</a>*属性のサポート追加、スクリプトの読み込み戦略の導入（deferまたはasyncでスクリプトを読み込むサポートを追加）
- **WordPress 6.4:** コアおよびバンドルテーマのフロントエンドスクリプトに対する<a hreflang="en" href="https://make.wordpress.org/core/2023/10/17/script-loading-changes-in-wordpress-6-4/">スクリプト読み込み戦略</a>の実装と100以上のパフォーマンスアップデートの統合
- **WordPress 6.5:** <a hreflang="en" href="https://make.wordpress.org/core/2024/04/23/wordpress-6-5-performance-improvements/">複数のパフォーマンス改善</a>を導入し、AVIF画像フォーマットのサポートとより高速なローカリゼーションシステムを含む

チームはまた、<a hreflang="en" href="https://wordpress.org/plugins/performance-lab/">Performance Lab</a>プラグインをリリースしました。これは、最終的にWordPressコアソフトウェアに統合される可能性のあるパフォーマンス関連の「フィーチャープロジェクト」のコレクションです：

- 画像プレースホルダー
- モダンな画像フォーマット
- パフォーマント翻訳
- 埋め込みオプティマイザー（実験的）
- 強化されたレスポンシブ画像（実験的）
- 画像プライオリタイザー（実験的）

<a hreflang="en" href="https://wordpress.org/plugins/speculation-rules/">Speculative Loading</a>は、Performance Labの一部であり、最近利用可能になった別のプラグインです。このプラグインは、[Speculation Rules API](https://developer.mozilla.org/docs/Web/API/Speculation_Rules_API)をサポートし、ユーザーの操作に基づいて特定のURLを動的にプリフェッチまたはプリレンダリングするルールを定義できます。この[APIについては次のセクションで詳しく説明します](#speculation-rules-api)。デフォルトでは、関連するリンクにユーザーがホバーしたときにWordPressフロントエンドURLをプリレンダリングするように設定されており、ユーザーは瞬時にページを読み込むことができます。

リリース以来、このプラグインの採用は着実に成長し、この章の執筆時点で30,000以上のアクティブインストールに達しています。

## 新たなトレンドとテクノロジー

今年の版に追加するには、採用や実世界への影響に関するデータが不十分でしたが、いくつかの新興技術は、すべてのCMSプラットフォームとウェブ全体のパフォーマンスを向上させることを約束しています。

そのため、私たちはそれらをまだ含めることにし、注視し続け、2025年にその影響を再検討することにしました。

### Speculation Rules API

Speculation Rules APIは、Googleが開発したJSON定義のAPIで、後続のページナビゲーションのパフォーマンスを向上させ、レンダリング時間を短縮し、ユーザーエクスペリエンスを向上させます。前のセクションで、[Speculative Loading WordPressプラグイン](#WordPressの最新のパフォーマンス改善)がこれをどのように利用したかについてはすでに見てきました。

このAPIにより、開発者はどのURLを動的にプリフェッチまたはプリレンダリングするかを指定できます。

- **プリフェッチ**: ユーザーが要求する前にリソース（ページやアセットなど）をバックグラウンドでフェッチし、ユーザーが最終的にプリフェッチされたコンテンツにナビゲートしたときの読み込み時間を短縮します。
- **プリレンダリング**: ページをバックグラウンドで完全にレンダリングするため、ユーザーがナビゲートしたときに読み込み時間なしで即座に利用できます。

さらに、APIは、リンクにカーソルを合わせるなどのユーザーの行動や予測されるナビゲーションパターンに基づいてパフォーマンスを向上させ、必要なときにコンテンツをより迅速に読み込むことができます。

投機がいつ発動するかを微調整するために、開発者は「熱心さ」の設定を調整できます。

- **Eager**: 条件が満たされるとすぐに投機ルールがトリガーされます。
- **Moderate**: ユーザーが少なくとも200ミリ秒間リンクにカーソルを合わせるなど、ある程度の意図を示す短い遅延の後に投機が行われます。
- **Conservative**: リンクをタップまたはクリックするなど、より決定的なユーザーアクションによってのみ投機がトリガーされ、ナビゲーションの可能性が高いことを示します。

これらの熱心さのレベルにより、開発者はパフォーマンスの最適化とリソース管理のバランスを取り、ブラウザが適切なタイミングでコンテンツをプリロードまたはプリレンダリングするようにできます。

### Long Animation Frames API (LoAF)

Long Animation Frames API（LoAF）は、Long Tasks APIを改善するために設計されました。Chrome 123で出荷され、開発者が応答性の問題に対処し、Interaction to Next Paint（INP）を改善するためのより実用的な洞察を提供します。

応答性とは、ページがユーザーの操作にどれだけ迅速に反応するかを指し、遅延なく更新が描画されることを保証します。INPの場合、200ミリ秒未満の応答時間が理想的ですが、アニメーションにはさらに短い時間が必要な場合があります。

個々のタスクを測定する代わりに、LoAFは50ミリ秒以上かかるフレームとして定義される長いアニメーションフレームに焦点を当て、ブロッキング作業をより効果的に特定するのに役立ちます。

### 人工知能（AI）

人工知能（AI）は、ユーザーがウェブサイトを構築、管理、最適化する方法を再構築しています。AI駆動のツールやプラグインがより普及し、自動化、パーソナライズ、強化されたユーザーエクスペリエンスを可能にしています。

WordPressエコシステムに関しては、コミュニティはまだAIトレンドを完全には受け入れていないようです。2023年5月の<a hreflang="en" href="https://make.wordpress.org/core/2023/05/02/lets-talk-wordpress-core-artificial-intelligence/">スレッド</a>で、WordPressコアチームと貢献者は、CMSにおけるAIの役割について意見交換しました。

議論の結果、いくつかのハイライトが際立っています。

- **AIはプラグインスペースにとどまるべきです**: AIの統合は現在、サードパーティのシステムと価格設定に依存しているため、AIモデルがサーバーで直接実行できるほど高速になるまで、コアではなくプラグインを通じて採用される可能性が高いです。
- **イノベーションの焦点としての開発者エクスペリエンス（DX）**: 一部の人は、とくにブロックエディターにおける現在のDXの制限に対処することが優先事項であるべきだと提案しています。拡張性を高めることで、プラグインがAI統合をより自由に実験できるようになります。
- **コラボレーションのためのAI**: 他の人は、<a hreflang="en" href="https://en-au.wordpress.org/about/roadmap/">Gutenbergロードマップ</a>のフェーズ3の一部として新しいユーザータイプとしてAIチャットボットを追加するなど、AIを使用してコラボレーションとワークフローを強化することを提案しています。より大胆なアイデアは、ビジネスサポートのためにパーソナルAIアシスタントを管理パネルに統合することです。

WordPressコアはさておき、AIはコンテンツ生成、パーソナライズ、チャットボットなどを提供する多数のプラグインで採用されています。したがって、AIはすでにWordPressエコシステムを変え始めていると言っても過言ではありません。

## 結論

CMSプラットフォームは2024年も上昇軌道を続けており、多様なコンテンツ作成者、企業、世界中のユーザーをサポートするにつれて、ますますインターネットの構造に不可欠なものとなっています。採用率が着実に上昇しているため、CMSは人々がコンテンツを作成および管理する方法を形成しているだけでなく、ユーザーがウェブを体験し、関与する方法も強化しています。

今年は、パフォーマンスとユーザーエクスペリエンスに対する業界全体の焦点が深まり、CMSプラットフォームはCore Web VitalsとLighthouseスコア全体で着実な改善を示しています。多くのCMSは、読み込み速度、インタラクティブ性、アクセシビリティを向上させる最適化戦略を採用しており、ユーザーファーストのウェブへの共通のコミットメントを反映しています。Core Web VitalとしてのInteraction to Next Paint（INP）の採用は、応答性のより包括的な尺度、ページ読み込み時間の新しい標準、およびデバイスやネットワーク条件全体でのブラウジング体験に対するより高い期待を私たちに与えてくれました。

しかし、課題は残っています。CMSが機能を拡張し、新しいテクノロジーを採用するにつれて、追加された機能とパフォーマンスのバランスを取ることが依然として重要です。ページ重量やJavaScriptの読み込みなどの問題は、とくにモバイルで一部のプラットフォームに影響を与え続けており、継続的な最適化とベストプラクティスの遵守の重要性を強調しています。

今後、AIがコンテンツ作成を変革し、投機的読み込みがパフォーマンスを向上させるなどの新興技術によって、CMSがどのように進化し続けるかを楽しみにしています。まだ開発の初期段階にありますが、これらの新しいテクノロジーは、ウェブのパフォーマンスとエンゲージメントを再定義する可能性を秘めています。データセットを拡大し、方法論を改良するにつれて、ウェブの状態とCMSのより明確な全体像を提供することを目指します。より速く、よりアクセスしやすく、よりユーザーフレンドリーなウェブを目指して、一緒に改善を続けていきましょう。
