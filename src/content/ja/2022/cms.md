---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: 2022年のWeb AlmanacのCMS章では、CMSの採用状況、CMSプラットフォーム上で動作するウェブサイトのユーザーエクスペリエンス、およびCMSのリソース量について扱っています。
authors: [sirjonathan]
reviewers: [alexdenning, alonkochba, dknauss]
analysts: [csliva]
editors: [dknauss]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1HvTcCEw9LeMNX-fI_yOy0HemKFYKaQAHBxtB0etakqY/
sirjonathan_bio: Jonathan Woldは、WordPressエコシステムに17年以上取り組んできたオープンウェブの支持者です。WordPressへの愛に加えて、彼は幅広い読書、戦略ゲーム、演技、ロッククライミング、そして時々三人称で文章を書くことを楽しんでいます。
featured_quote: 年ごとに比較すると、DrupalとJoomlaは市場シェアが引き続き減少している一方、Squarespaceは安定しており、Wixは成長しています。WordPressは引き続き上昇しており、モバイルでは2021年に比べて1.4%増加し、デスクトップでは2021年に比べて0.2%増加しています。
featured_stat_1: 45%
featured_stat_label_1: デスクトップデータセット内で既知のCMSに割り当てられたウェブサイトの割合
featured_stat_2: 7%
featured_stat_label_2: トップ1,000ウェブサイトのうち、既知のCMSに割り当てられた割合
featured_stat_3: 34%
featured_stat_label_3: ページビルダーを使用しているとされるWordPressサイト
---

## 序章

この章では、コンテンツ管理システム（CMS）エコシステムの現状と、それらがウェブ上でのコンテンツ体験におけるユーザー認識を形成する上で果たしている役割について理解を深めようとしています。私たちの目標は、CMSの全体像と、これらのシステムによって作成されたウェブページの特性を探求することです。

私たちは、CMSが高速で強固なウェブを構築するための共同の取り組みにおいて重要な役割を果たしていると信じています。現在の状況を理解し、疑問を投げかけ、将来の研究に向けた問いを立てることが、この目標を達成するための道筋です。

私たちのチームは、今年のデータに対して好奇心を持って取り組み、その好奇心を複数の人気CMSに関する個人的な専門知識と結びつけました。CMS間の違いやその上で扱われるコンテンツの種類の違いを考慮しながら、私たちの分析を読んでいただくことをオススメします。

## CMSとは何ですか？

コンテンツ管理システム（CMS）という用語は、個人や組織がコンテンツを作成、管理、公開できるようにするシステムを指します。とくにウェブコンテンツのCMSは、ウェブ上で体験されるコンテンツを作成、管理、公開するためのシステムです。

各CMSは、ユーザーがコンテンツを中心にウェブサイトを構築できるようにするさまざまなコンテンツ管理機能と対応するメカニズムを実装しています。また、CMSはコンテンツの追加と管理を容易にするための管理機能も提供します。

CMSは、サイトを構築するために提供するアプローチが大きく異なります。いくつかのCMSは、ユーザーコンテンツを補完するすぐに使えるテンプレートを提供する一方で、他のCMSはサイト構造を設計し構築するためにユーザーの関与を必要とします。

このWeb Almanacの章では、ホスティングプロバイダー、拡張機能開発者、開発エージェンシー、サイトビルダーなど、CMSプラットフォームを取り巻くエコシステムを構成するすべての要素を考慮しようとしました。このため、CMSに言及する際には、通常そのプラットフォーム自体だけでなく、その周辺のエコシステムも意図しています。

<a hreflang="en" href="https://www.wappalyzer.com/technologies/cms">Wappalyzerの定義</a>に基づく私たちのデータセットでは、270以上の個別のCMSが特定されました。欠けているCMSを知っていますか？<a hreflang="en" href="https://github.com/wappalyzer/wappalyzer/blob/7ac625c34432cb35d01abd683f88d3bfadca4cca/CONTRIBUTING.md">Wappalyzerに貢献</a>してください。

データセットの中には、WordPressやJoomlaのようなオープンソースのCMSもあれば、WixやSquarespaceのようなプロプライエタリなCMSもあります。一部のCMSは「無料」でホスティングされたり、セルフホストされたプランで使用でき、また、エンタープライズレベルまで利用できる上位プランのオプションもあります。

CMS全体の領域は、離散的でありながら相互に関連するCMSエコシステムの複雑で分散型の世界です。

## CMSの採用

私たちの分析では、デスクトップとモバイルのウェブサイトが含まれています。調査したURLの大部分は両方のデータセットに含まれていますが、一部のURLはデスクトップまたはモバイルデバイスのみでアクセスされます。これによりデータに違いが生じる可能性があるため、デスクトップとモバイルの結果を別々に検討しました。

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMSの採用状況。",
  description="過去3年間にわたるCMSの採用状況を示す棒グラフ。2022年にはデスクトップウェブサイトの45%、モバイルウェブサイトの47%がCMSを使用して構築されています。2021年には、デスクトップは45%、モバイルは約46%、2020年には両方とも42%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=386824637&format=interactive",
  sheets_gid="643278583",
  sql_file="cms_adoption.sql"
  )
}}

2022年6月の時点で、Web Almanacのデスクトップデータセット内のウェブサイトの45%がCMSによって運営されており、[2021年](../2021/cms#CMSの採用)と同様の利用状況を示しています。モバイルデータセットでは、2021年の46%から2022年には47%に増加しています。デスクトップの生データを詳しく見ると、絶対数および割合の両方でわずかな減少が見られますが、この減少はCMSの使用率の低下を示すものではなく、割り当ての小さな変動によるものである可能性が高いです。デスクトップサイトの数がHTTP Archive（ソースであるCrUXデータセット）で640万サイトから540万サイトに大幅に減少した一方で、モバイルサイトの数は750万サイトから約40万サイト増加して790万サイトに達しました。この増加は、デスクトップの代わりにモバイルデバイスの使用が引き続き成長していることを反映していると考えられます。

これらの数値を、<a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management/all/q">W3Techs</a>のような一般的に使用されている他のデータセットと比較することは有益です。W3Techsは、2021年6月の時点で、ウェブサイトの64.6%がCMSを使用して作成されていると報告しています。これは、2020年6月の59.2%から9%以上の増加です。

私たちの分析とW3Techsの分析の違いは、調査方法やCMSの定義の違いによって説明できます。

W3Techsの定義は次のとおりです："_コンテンツ管理システムは、ウェブサイトのコンテンツを作成および管理するためのアプリケーションです。このカテゴリーには、ウィキ、ブログエンジン、ディスカッションボード、静的サイトジェネレーター、ウェブサイトエディタ、またはウェブサイトコンテンツを提供するあらゆる種類のソフトウェアも含まれます_。"

前述のように、WappalyzerのCMSの定義は私たちよりも厳しいものです。Wappalyzerは、W3Techsのレポートに登場するいくつかの主要なCMSを除外しています。私たちのCMSの定義について詳しくは、[Methodology](./methodology)ページをご覧ください。

### 地域別のCMSの採用

CMSは世界中で使用されていますが、国によってばらつきがあります。

{{ figure_markup(
  image="cms-adoption-geo.png",
  caption="地域別のCMS採用。",
  description="ウェブサイト数がもっとも多い10か国におけるCMSの採用状況を示す棒グラフ。米国では、データセット内のモバイルウェブサイトの39%、デスクトップウェブサイトの43%がCMSを使用して構築されています。日本ではそれぞれ38%と32%、英国では39%と39%、ドイツでは36%と39%、インドでは35%と35%、ブラジルでは34%と31%、フランスでは38%と35%、ロシア連邦では40%と35%、イタリアでは42%と40%、スペインではデスクトップで42%、モバイルで41%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1831148760&format=interactive",
  sheets_gid="353349768",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=538
  )
}}

ウェブサイト数がもっとも多い国の中で、CMSの採用率がもっとも高いのはイタリアとスペインで、モバイルサイトの40%〜41%がCMSで構築されています。ブラジルと日本では、採用率がそれぞれ31%と32%ともっとも低いです。

とくに注目すべきは、個々の国を考慮すると、[2021年のデータセット](../2021/cms#地域別のCMS導入状況)と比較して全体的に減少していることです。モバイルの結果を年ごとに比較すると、インドを除くすべての国で減少が見られ、英国とドイツでは4%減少し、米国とイタリアでは8%減少しています。地理的に一貫して減少していることを考慮すると、CMSの採用が大幅に減少したというよりも、割り当てのばらつきが原因である可能性が高いです。次年度の分析ではこの点をさらに評価することをオススメします。


### ランク別のCMSの採用

私たちは、データセットに含まれるサイトの推定ランク別にCMSの採用を調査しました。

{{ figure_markup(
  image="cms-adoption-rank.png",
  caption="ランク別のCMS採用。",
  description="ウェブサイトのランク別に分けたCMSの採用状況を示す棒グラフ。トップ1,000サイトではデスクトップとモバイルの両方で7%です。トップ10,000ではそれぞれ15%と16%、トップ100,000ではそれぞれ21%と21%、トップ1,000,000ではそれぞれ29%と29%、すべてのサイトではそれぞれ39%と43%です。ランクが高いサイトほどCMSが割り当てられる可能性が低く、ランクが低いサイトほどCMSが明確に割り当てられている割合が高いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=898515378&format=interactive",
  sheets_gid="1599740178",
  sql_file="cms_adoption_by_rank.sql"
  )
}}

データセットによると、トップ1,000のウェブサイトのうちCMSを使用しているのはデスクトップとモバイルの両方で7%未満ですが、データセット内のすべてのモバイルサイトの47%がCMSを使用しています。この明らかな違いの説明として、昨年も述べたように、ウェブサイトを持つ中小企業は使いやすさから人気のCMSを利用する傾向があり、そのCMSが容易に特定できるということが考えられます。しかし、よりランクの高いウェブサイトを持つ大企業は、特注のCMSソリューションを使用していることが多く、それらは私たちには特定できません。

もう1つの説明は、開発に多くのリソースを割り当てられるランクの高いサイトは、セキュリティ上の理由からCMSの特定を隠す傾向があるということです。トップ1,000の90%以上がCMSを完全に使用しないというのはあり得ないことですので、単にデータセットに反映されていないだけである可能性が高いです。

関連する傾向としては、「ヘッドレス」CMSの採用と、コンテンツ（およびそれを支えるCMS）をエンドユーザーに提供するフロントエンド体験から分離する動きがあります。

データセット全体への自信は依然として高いものの、来年度のレポートでランク別のデータセットをさらに調査し、より多くのCMSを検出および特定して結果の全体的な精度を向上させることができるかどうかを確認することに興味があります。

## もっとも人気のあるCMS

特定可能なCMSを使用しているすべてのウェブサイトの中で、WordPressサイトは相対的な市場シェアの大部分を占めており、モバイルでの採用率は35%以上です。次いでWix（2%）、Joomla（1.8%）、Drupal（1.6%）、Squarespace（1.0%）が続いています。

{{ figure_markup(
  image="top-5-cms-yoy.png",
  caption="過去1年間での上位5つのCMS。",
  description="過去3年間にわたる上位5つのCMSを使用して構築されたウェブサイトの割合を示す棒グラフ。WordPressは2020年に31.4%、2021年に33.6%、2022年に35.0%です。Joomlaはそれぞれ同じ年で2.1%、1.9%、1.8%です。Drupalは2.0%、1.8%、1.6%です。Wixは1.2%、1.6%、2.0%です。Squarespaceは2020年に0.9%、2021年に1.0%、2022年に1.0%です。WordPress、Wix、Squarespaceは年ごとに採用率が増加している一方で、DrupalとJoomlaは減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=714516300&format=interactive",
  sheets_gid="1396671791",
  sql_file="top_cms.sql"
  )
}}

年ごとに比較すると、DrupalとJoomlaは市場シェアが引き続き減少している一方で、Squarespaceは安定しており、Wixは成長しています。WordPressは引き続き上昇しており、モバイルでは2021年に比べて1.4%増加し、デスクトップでは2021年に比べて0.2%増加しています。

{{ figure_markup(
  image="wordpress-page-builders.png",
  caption="WordPressページビルダーの採用。",
  description="WordPressの上位5つのページビルダーを示す棒グラフ。ElementorはデスクトップWordPressサイトの40%、モバイルの43%を占めています。wpBakeryはそれぞれ34%、33%、Diviは16%、15%、SiteOrigin Page Builderは3%、3%、Oxygenは両方で1%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=184382453&format=interactive",
  sheets_gid="2087504589",
  sql_file="wordpress_page_builders.sql"
  )
}}

WordPressでは、ユーザーがコンテンツ管理用のインターフェイスを提供する「ページビルダー」をよく利用します。今年はWappalyzerの検出方法が向上したため、ページビルダーの採用状況を調査しました。その結果、ページビルダーが割り当てられているWordPressサイト（私たちのデータセット内のすべてのWordPressサイトの約34%）の中で、ElementorとWP Bakeryが明確な勝者であり、Divi、SiteOrigin、Oxygenがそれに続いていることがわかりました。

今日の時点で、ページビルダーはサイトのパフォーマンスに大きな影響を与えています。歴史的に、ページビルダーはパフォーマンスが悪いことの経験的な指標とされてきました。たとえば、私たちのデータセットでは、複数のページビルダーがインストールされているウェブサイトも珍しくなく、これによりサイトが読み込むリソースが大幅に増加しています。

ページビルダーデータの追跡を開始したことで、今後の版では、年ごとのページビルダーの採用状況の変化を評価し、それらの変化がWordPress全体のCMSとしてのパフォーマンスにどのように関連しているかを調べる機会が得られます。

## CMSユーザーエクスペリエンス

CMSの重要な機能の1つは、これらのプラットフォーム上で構築されたサイトを訪問するユーザーに提供するユーザーエクスペリエンスです。私たちは、<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report</a> (CrUX) を通じたリアルユーザーメジャーメント (RUM) と、[Lighthouse](./methodology#lighthouse) を使用したシンセティックテストを通じて、これらのエクスペリエンスを調査しようと試みています。

### Core Web Vitals

<a hreflang="en" href="https://httparchive.org/reports/cwv-tech">Core Web Vitals Technology Report</a>を使用して、利用可能なデータを詳しく調べ、月ごとに更新されるプラットフォームの進捗を確認できます。

このセクションでは、Web Almanac全体で提示されたデータの時間枠を一貫させるため、2022年6月のデータに焦点を当てます。私たちは、[Chrome User Experience Report](../2021/methodology#chrome-ux-report) が提供する3つの重要な指標を調査し、CMSによって運営されているウェブページがどのように体験されているかを理解する手がかりを探ります：

* <a hreflang="ja" href="https://web.dev/articles/lcp?hl=ja">Largest Contentful Paint</a> (LCP)
* <a hreflang="ja" href="https://web.dev/articles/fid?hl=ja">First Input Delay</a> (FID)
* <a hreflang="ja" href="https://web.dev/articles/cls?hl=ja">Cumulative Layout Shift</a> (CLS)

これらの指標は、優れたウェブユーザーエクスペリエンスの技術的基礎をカバーすることを目的としています。[パフォーマンス](./performance) の章ではこれらの指標についてさらに詳しく説明していますが、ここではCMSに関連してとくにそれらを調べています。

まず、もっとも多くのオリジンを持つ10のCMSプラットフォームを確認し、それぞれのプラットフォームで「合格」評価を持つサイトの割合を調査します。合格評価とは、上記の各指標が各サイトで「良好」（緑）範囲内にあることを意味します：LCPが2.5秒以下、FIDが100ms以下、CLSが0.1以下です。

{{ figure_markup(
  image="top-cwv-performance.png",
  caption="CMSごとのCore Web Vitalsパフォーマンス。",
  description="もっとも採用されている10のCMSごとの、良好なCore Web Vitalsを持つサイトの割合を示す棒グラフ。WordPressはデスクトップとモバイルの30%のサイトが合格。Wixはデスクトップで41%、モバイルで39%。Joomlaはそれぞれ40%と38%。Drupalは49%と50%。Squarespaceは47%と34%。1C-Bitrixは54%と40%。TYPO3 CMSは57%と62%。Dudaは68%と67%。Weeblyは36%と43%。Jimdoはデスクトップで54%、モバイルで61%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1221898999&format=interactive",
  sheets_gid="445373655",
  sql_file="core_web_vitals.sql",
  width=600,
  height=559
  )
}}

デスクトップ訪問者の方がモバイル訪問者よりも高いスコアを獲得していることがわかります。これは、モバイルデバイスのリソース制限や接続の悪さによって説明できます。一部のプラットフォームでモバイルとデスクトップのパフォーマンスに大きな差があることは、ユーザーが使用するデバイスによって提供されるページが非常に異なることを示唆しています。

6月のモバイルデバイスの場合、Dudaがもっとも高い合格サイト割合を持っており、67%のモバイルサイトがすべてのCWVに合格しています。WordPressは30%のサイトが合格しており、これはもっとも低い割合ですが、それでも2021年のデータ（WordPressサイトの19%が合格）から大幅に増加しています。

デスクトップデバイスのエクスペリエンスは、ほとんどのCMSでモバイルよりも優れています。Dudaがもっとも高い合格率を持ち、68%です。WordPressは合格サイトの割合がもっとも低く、30%です。

また、これらのCMSプラットフォームのモバイルデバイス上でのパフォーマンスの進捗を、昨年のデータと比較して評価できます。

{{ figure_markup(
  image="top-cwv-yoy.png",
  caption="年ごとのCore Web Vitalsのモバイル合格率。",
  description="もっとも採用されている10のCMSごとに、Core Web Vitalsに合格したモバイルサイトの割合の年ごとの変化を示す棒グラフ。WordPressは2020年に15%、2021年に19%、2022年に30%。Joomlaはそれぞれ20%、26%、38%。Drupalは28%、34%、50%。Wixは4%、29%、39%。Squarespaceは5%、17%、34%。1C-Bitrixは23%、30%、40%。TYPO3 CMSは41%、46%、62%。Dudaは21%、30%、67%。Weeblyは28%、32%、43%。Adobe Experience Managerは2020年で11%、2021年で14%、2022年で23%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=144597470&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

これらのCMSはすべて、2021年6月以降、良好なCWVを持つオリジンの割合が改善されています。

次に、3つのCore Web Vitalsを詳しく見て、それぞれのプラットフォームが改善の余地がある箇所と、昨年からもっとも改善された指標を確認しましょう。

#### Largest Contentful Paint (LCP)

Largest Contentful Paint（LCP）は、ページの主要なコンテンツが読み込まれた時点を測定し、その時点でページがユーザーにとって有用であると見なされます。LCPは、ビューポート内に表示される最大の画像またはテキストブロックのレンダリング時間を測定することで評価されます。

「良好な」LCPは2.5秒未満とされています。

{{ figure_markup(
  image="lcp-cwv-performance.png",
  caption="CMS別の良好なLCPを持つサイトの割合。",
  description="もっとも採用されている10のCMSごとに、良好なLCPを持つサイトの割合を示す棒グラフ。WordPressはデスクトップで45%、モバイルで37%です。Wixはそれぞれ48%と43%です。Joomlaは62%と55%です。Drupalは73%と60%です。Squarespaceは66%と40%です。1C-Bitrixは72%と50%です。TYPO3 CMSは82%と79%です。Dudaは85%と79%です。Weeblyは59%と49%です。最後に、Jimdoはデスクトップで69%、モバイルで74%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1306847805&format=interactive",
  sheets_gid="445373655",
  sql_file="core_web_vitals.sql",
  width=600,
  height=559
  )
}}

TYPO3とDudaはもっとも良いLCPスコアを持ち、起源の79%が「良好な」LCP体験をしています。WordPressとSquarespaceはもっとも悪いLCPスコアを持ち、それぞれ起源の37%と40%が良好なLCPスコアを持っています。

{{ figure_markup(
  image="lcp-cwv-yoy.png",
  caption="年ごとのLCPモバイル。",
  description="もっとも採用されている10のCMSごとに、年ごとに良好なLCPモバイルサイトの割合がどのように変化したかを示す棒グラフ。WordPressは2021年に28%、2022年に37%です。Joomlaはそれぞれ42%と55%です。Drupalは50%と60%です。Wixは33%と43%です。Squarespaceは30%と40%です。1C-Bitrixは45%と50%です。TYPO3 CMSは69%と79%です。Dudaは52%と79%です。Weeblyは42%と49%です。Adobe Experience Managerは2021年に28%、2022年に34%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=964886559&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

2021年のデータセットと比較して、すべてのCMSはLCPの向上を示しました。Joomlaは13%改善されました。Drupal、Squarespace、TYPO3は10%改善されました。WordPressは9%改善されました。

これらの改善は、ほとんどのCMSで数字が低いにもかかわらず、前向きな兆候です。良好なLCPスコアを達成することは困難である可能性があり、その理由はLCPが画像/フォント/CSSのダウンロードとそれに続く適切なHTML要素の表示に依存しているからです。すべてのデバイスタイプと接続速度で2.5秒未満でこれを達成することは挑戦的です。LCPスコアの改善には、キャッシング、プリロード、リソースの優先順位付け、および他の競合リソースの遅延読み込みの正しい使用が通常含まれます。

#### First Input Delay (FID)

First Input Delay（FID）は、ユーザーがページとはじめてインタラクションする（つまりリンクをクリックする、ボタンをタップする、またはカスタムのJavaScript駆動のコントロールを使用する）時からブラウザがそのインタラクションを処理できるようになるまでの時間を測定します。ユーザーの観点から「速い」FIDは、停止した経験ではなく、ほぼ即座にフィードバックが得られることを意味します。

遅延は痛点であり、ユーザーがサイトと対話しようとする間にサイトの他の部分が読み込まれることと相関がある可能性があります。「良好な」FIDは100ミリ秒未満とされています。

2021年のレポートでは、ほぼすべてのプラットフォームが良好なFIDを提供しているという事実が、この指標の厳しさについて疑問を投げかけました。Chromeチームは<a hreflang="en" href="https://web.dev/responsiveness/">記事を公開しました</a>。これは2022年の5月に更新され、新しい指標である<a hreflang="en" href="https://web.dev/inp/">Interaction to Next Paint (INP)</a>に言及しています。この執筆時点でそのベータ版であるため、来年のレポートでの可能な拡張に備えて、この参照に限定しています。

{{ figure_markup(
  image="fid-cwv-yoy.png",
  caption="年ごとのFIDモバイル。",
  description="もっとも採用されている10のCMSごとに、年ごとにモバイルサイトの良好なFIDスコアの割合がどのように変化したかを示す棒グラフ。WordPressは2021年も2022年も96%です。Joomlaは2021年に85%、2022年に89%です。Drupalはそれぞれ90%と95%です。Wixは94%と92%です。Squarespaceは98%と98%です。1C-Bitrixは83%と94%です。TYPO3 CMSは93%と95%です。Dudaは92%と95%です。Weeblyは96%と90%です。最後に、Adobe Experience Managerは2021年に94%、2022年に95%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=242914394&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

年次データは、ほとんどのCMSが過去1年間でFIDを改善したことを示しています。WixとWeeblyは前年のデータよりもいくつかのパーセンテージポイント後退しました。

#### Cumulative Layout Shift (CLS)

Cumulative Layout Shift（CLS）は、ウェブページ上のコンテンツの視覚的安定性を測定し、ユーザーの直接的なインタラクションによって引き起こされないページのライフスパン中に発生する予期しないレイアウトシフトの最大のバーストを測定します。

レイアウトシフトは、表示される要素が1つのレンダリングフレームから次のフレームへと位置を変えるたびに発生します。<a hreflang="en" href="https://web.dev/evolving-cls/">CLSメトリックは2021年に進化しました</a>。主に長期間存在するページやシングルページアプリケーション（SPA）に公平であるためにセッションウィンドウの概念が導入されました。

0.1以下のスコアは「良好」と測定され、0.25以上は「悪い」とされ、その間は「改善が必要」とされます。

{{ figure_markup(
  image="cls-cwv-yoy.png",
  caption="年ごとのCLSモバイル。",
  description="もっとも採用されている10のCMSごとに、年ごとに良好なCLSモバイルサイトの割合がどのように変化したかを示す棒グラフ。WordPressは2021年に61%、2022年に75%です。Joomlaは62%と72%です。Drupalは69%と81%です。Wixは81%と89%です。Squarespaceは54%と76%です。1C-Bitrixは66%と76%です。TYPO3 CMSは69%と81%です。Dudaは55%と86%です。Weeblyは56%と69%です。最後に、Adobe Experience Managerは2021年に44%、2022年に59%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=2127088376&format=interactive",
  sheets_gid="1494726447",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

年次データを比較すると、すべてのCMSが進歩していることがわかります。とくにWordPress、Squarespace、Duda、Adobe Experience Managerは顕著な向上を示しています。

### Lighthouse

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>は、ウェブページの品質を向上させるためのオープンソースの自動化ツールです。このツールの重要な側面の1つは、パフォーマンス、アクセシビリティ、SEO、ベストプラクティスなどの観点からウェブサイトの状態を評価する一連の監査を提供することです。Lighthouseレポートはラボデータを提供し、開発者がウェブサイトのパフォーマンスを改善する方法についての提案を得る方法ですが、Lighthouseスコアは<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">CrUX</a>によって収集された実際のフィールドデータに直接的な影響はありません。<a hreflang="en" href="https://web.dev/lab-and-field-data-differences/">ラボスコアとフィールドデータの相関関係</a>については、さらに詳しく読むことができます。

HTTP Archiveは、そのモバイルウェブページでLighthouseを実行しており、[遅い4G接続をエミュレートしCPUを遅くする](./methodology#lighthouse)設定もされています。また、今年からデスクトップでも実行を開始しました。

これらの合成テストの結果を使用して、CrUXで追跡されていない指標も含め、CMSのパフォーマンスについて別の視点から分析できます。

#### パフォーマンススコア

Lighthouseの<a hreflang="en" href="https://web.dev/performance-scoring/">パフォーマンススコア</a>は、いくつかのスコア指標の加重平均です。

{{ figure_markup(
  image="median-lighthouse-performance.png",
  caption="Lighthouseの中央値パフォーマンススコア。",
  description="もっとも採用されている10のCMSごとのLighthouseの中央値パフォーマンススコアを示す棒グラフ。WordPressはデスクトップで43、モバイルで26です。Drupalはそれぞれ45と29です。Joomlaは44と27です。Wixは45と29です。Squarespaceは40と19です。1C-Bitrixは37と22です。TYPO3 CMSは46と35です。Dudaは53と47です。Weeblyは45と25です。Adobe Experience Managerは36と17です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=2275923&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

ほとんどのプラットフォームのモバイルでの中央値パフォーマンススコアは低く、約19から35の範囲です。Dudaの47は例外です。Philip Waltonが2021年に指摘したように、<a hreflang="en" href="https://philipwalton.com/articles/my-challenge-to-the-web-performance-community/">これがモバイルフィールドデータの悪い結果を直接示すわけではありません</a>が、すべてのプラットフォームが改善の余地があり、とくにLighthouseがエミュレートしようとしているようなネットワーク接続を持つ低性能デバイスでの改善が必要です。

WordPress、Joomla、Drupal、1C-Bitrixは昨年の結果から変化はありませんでした。Wixは30%から29%に下がりましたが、他は改善を示しています。

デスクトップスコアは全体的に良好で、すべてのCMSが10から20ポイントの改善を見せています。これは、デスクトップに利用可能なより高速なCPUとネットワークを考慮すると驚くことではありません。

#### SEOスコア

検索エンジン最適化（SEO）は、ウェブサイトを改善して検索エンジンでより簡単に見つけられるようにする実践です。これについては私たちの[SEO](./seo)の章でより詳しく扱っていますが、CMSとも関連があります。CMSとその上のコンテンツは、検索エンジンのクローラーにできるだけ多くの情報を提供し、検索エンジンの結果でサイトコンテンツを適切にインデックスできるように設定されています。カスタムビルドのウェブサイトと比較すると、CMSは良好なSEO機能を提供すると期待されますが、このカテゴリーのLighthouseスコアは適切に高いです。

{{ figure_markup(
  image="median-lighthouse-seo.png",
  caption="Lighthouseの中央値SEOスコア。",
  description="もっとも採用されている10のCMSごとのLighthouseの中央値SEOスコアを示す棒グラフ。WordPressはデスクトップで91、モバイルで89です。Drupalは83と83です。Joomlaはそれぞれ83と86です。Wixは92と91です。Squarespaceは92と92です。1C-Bitrixは83と85です。TYPO3 CMSは83と86です。Dudaは83と86です。Weeblyは82と85です。Adobe Experience Managerは83と85です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1901746915&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

トップ10のプラットフォームの中央値SEOスコアは83から92の範囲で、[2021年の84から95からわずかに減少しました](../2021/cms#SEOスコア)。デスクトップスコアは似ており、いくつかの場合はわずかに良く、他の場合はわずかに悪くなっています。

#### アクセシビリティスコア

アクセシブルなウェブサイトは、障害を持つ人々が使用できるように設計および開発されたサイトです。ウェブアクセシビリティは、遅いインターネット接続などの障害を持たない人々にも利益をもたらします。詳細は[アクセシビリティ](./accessibility)章で読むことができます。

Lighthouseは一連のアクセシビリティ監査を提供し、それらすべての加重平均を返します。各監査がどのように加重されているかの完全なリストについては、<a hreflang="en" href="https://web.dev/accessibility-scoring/">スコアリング詳細</a>を参照してください。

各アクセシビリティ監査は合格または不合格ですが、他のLighthouse監査とは異なり、ページがアクセシビリティ監査を部分的に合格してもポイントは得られません。たとえば、一部の要素がスクリーンリーダーに優しい名前を持っているが、他の要素が持っていない場合、そのページはスクリーンリーダーに優しい名前の監査でゼロを取得します。

{{ figure_markup(
  image="median-lighthouse-accessibility.png",
  caption="Lighthouseのアクセシビリティスコアの中央値。",
  description="もっとも採用されている10のCMSごとのLighthouseのアクセシビリティスコアの中央値を示す棒グラフ。WordPressはデスクトップとモバイルで86です。Drupalは86と86です。Joomlaはそれぞれ83と83です。Wixは88と88です。Squarespaceは93と91です。1C-Bitrixは77と77です。TYPO3 CMSは84と85です。Dudaは78と79です。Weeblyは83と84です。Adobe Experience Managerは86と86です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=201542197&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

トップ10のCMSのLighthouseアクセシビリティスコアの中央値は77から91の範囲です。Squarespaceが最高スコアの91を持ち、1C-Bitrixが最低のアクセシビリティスコアを持っています。デスクトップスコアはモバイルとほぼ同一であり、デスクトップとモバイルデバイスに同じサイトが配信されていることを反映している可能性があります。

#### ベストプラクティス

Lighthouseの<a hreflang="en" href="https://web.dev/lighthouse-best-practices/">ベストプラクティス</a>は、HTTPSのサポート、コンソールにエラーが記録されていないことなど、さまざまな指標に対してウェブページがウェブのベストプラクティスにしたがっていることを確認しようとします。

{{ figure_markup(
  image="median-lighthouse-best-practices.png",
  caption="Lighthouseのベストプラクティススコアの中央値。",
  description="もっとも採用されている10のCMSごとのLighthouseのベストプラクティススコアの中央値を示す棒グラフ。WordPressはデスクトップで92、モバイルで83です。Drupalは83と83です。Joomlaはそれぞれ83と75です。Wixは92と100です。Squarespaceは92と92です。1C-Bitrixは83と75です。TYPO3 CMSは92と83です。Dudaは83と75です。Weeblyは75と75です。Adobe Experience Managerは83と75です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1066307789&format=interactive",
  sheets_gid="921264211",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

Wixは中央値のベストプラクティススコアが100でもっとも高く、他のトップ10のプラットフォームは最低スコアが75を共有しています。再び、デスクトップの結果は非常に似ており、いくつかのケースでは大きくなっています。これは、このカテゴリーの他の監査がプラットフォームベースであるため、モバイルページで画像のアスペクト比が正しくないことを反映している可能性があります。

## リソースの重さ

また、さまざまなプラットフォームで使用されるリソースの重さを分析するためにHTTP Archiveのデータを使用しました。これは、パフォーマンス改善の機会を浮き彫りにするためです。ページの読み込みパフォーマンスはダウンロードされるバイト数だけに依存するわけではありませんが、ページを読み込むために必要なバイト数が少なければコストが削減され、炭素排出量が少なくなり、とくに接続速度が遅い場合にはパフォーマンスが向上する可能性があります。

{{ figure_markup(
  image="median-cms-page-weight.png",
  caption="CMS別のリソースの重さの中央値。",
  description="各デバイスカテゴリーでもっとも採用されている上位5つのCMSのそれぞれの中央ページ重量を示す棒グラフ。WordPressはデスクトップで2,559 KB、モバイルで2,314 KBです。Drupalはそれぞれ2,351 KBと2,146 KBです。Joomlaは2,799 KBと2,495 KBです。Wixは3,172 KBと2,158 KBです。Squarespaceは3,462 KBと3,577 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1764509612&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

上位5つのCMSのほとんどは、約2 MBの中央ページ重量を提供していますが、Squarespaceは約3.5 MBと大きくなっています。Joomlaを除くすべてが[2021年のデータからページ重量の増加](../2021/cms#ページ重量の内訳)を示しています。

{{ figure_markup(
  image="distribution-cms-page-weight.png",
  caption="CMS別のモバイルページ重量の分布。",
  description="もっとも採用されている上位5つのCMSのそれぞれのトータルモバイルページ重量のパーセンタイル分布を示す分布図。WordPressは10パーセンタイルで673 KB、25パーセンタイルで1,229 KB、50パーセンタイルで2,314 KB、75パーセンタイルで4,479 KB、90パーセンタイルで8,558 KBです。Wixはそれぞれ1,048、1,455、2,158、3,586、6,843 KBです。Joomlaは685、1,268、2,495、4,892、9,473 KBです。Drupalは618、1,130、2,146、4,193、8,229 KBです。そして最後にSquarespaceは10パーセンタイルで1,496 KB、25パーセンタイルで2,123 KB、50パーセンタイルで3,577 KB、75パーセンタイルで6,539 KB、90パーセンタイルで11,434 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1236078412&format=interactive",
  sheets_gid="859067552",
  sql_file="page_weight_distribution.sql"
  )
}}

各プラットフォームのパーセンタイルでのページ重量の分布は著しいです。ページ重量は、ウェブページ間のユーザーコンテンツの違い、使用される画像の数、インストールされたプラグインなどに関連している可能性があります。プラットフォームごとに提供される最小のページはWordPressからで、昨年のデータからの顕著な改善が見られます。今年、WordPressは訪問の10パーセンタイルで673 KBしか送信していません。最大のページはSquarespaceからで、訪問の90パーセンタイルで約11.4 MBを配信しており、昨年のデータから約2 MBの増加です。

### ページ重量の内訳

ページ重量は、ページで使用されるリソースのキロバイトの合計です。異なるCMSでこれらの異なるリソースサイズを評価しようとできます。

#### 画像

通常、ウェブページで読み込まれるもっとも重いリソースである画像は、リソース重量の大部分を占めます。

{{ figure_markup(
  image="median-cms-image-size.png",
  caption="CMS別の画像サイズの中央値。",
  description="各デバイスでもっとも採用されている上位5つのCMSの画像リソースのダウンロード重量の中央値を示す棒グラフ。WordPressはデスクトップで1,202 KB、モバイルで1,100 KBです。Drupalはデスクトップで1,279 KB、モバイルで1,158 KBです。Joomlaはデスクトップで1,690 KB、モバイルで1,504 KBです。Wixはデスクトップで647 KB、モバイルで290 KBです。最後にSquarespaceはデスクトップで1,623 KB、モバイルで1,790 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1491116500&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

Wixはモバイルビューの中央値で290 KBの画像バイトのみを提供し、これは画像圧縮と遅延画像読み込みの良好な使用を示唆しています。他のトップ5のプラットフォームは1 MB以上の画像を提供し、Squarespaceは最大約1.7 MBを提供しています。

進んだ画像フォーマットは圧縮に大きな改善をもたらし、リソースの節約とサイトの高速化を可能にします。WebPは現在、すべての主要ブラウザで一般的にサポートされており、<a hreflang="en" href="https://caniuse.com/webp">95%以上のサポート</a>があります。さらに、<a hreflang="en" href="https://caniuse.com/avif">AVIF</a>や<a hreflang="en" href="https://jpegxl.info">JPEG-XL</a>など、新しい画像フォーマットも人気を集めており、採用が進んでいます。

トップCMSでの異なる画像フォーマットの使用状況を調査できます：

{{ figure_markup(
  image="image-format-popularity.png",
  caption="CMS別の画像フォーマットの人気度。",
  description="トップ15のもっとも採用されているCMSのそれぞれで、各画像フォーマットの相対的な人気度を示す棒グラフ。WordPressでは、jpgが39%、pngが30%、gifが20%、webpが7%、svgが4%、icoが1%、avifが0%です。Wixでは、それぞれ11%、5%、6%、75%、0%、1%、0%です。Joomlaでは、48%、36%、10%、2%、2%、3%、0%です。Drupalでは、41%、35%、13%、2%、6%、2%、0%です。Squarespaceでは、53%、30%、12%、0%、3%、2%、0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1668189558&format=interactive",
  sheets_gid="710966440",
  sql_file="image_format_popularity.sql",
  width=600,
  height=556
  )
}}

WixとDudaはWebPの使用がもっとも多く、それぞれ約75%と42%の採用率ですが、他はわずかな増加を示しています。

<a hreflang="en" href="https://caniuse.com/webp">WebPのサポートが拡大する</a>中で、すべてのプラットフォームは、画像品質を損なうことなく古いJPEGおよびPNGフォーマットの使用を減らすために取り組むべき課題があります。

WordPressは2021年6月にリリースされたWordPress 5.8でWebPサポートを導入しました。WebPサポートはWordPress 6.1で<a hreflang="en" href="https://make.wordpress.org/core/2022/06/30/plan-for-adding-webp-multiple-mime-support-for-images/">デフォルトで含まれる予定でした</a>が、この決定は延期されました。最終的に、WordPressを通じてWebPの採用が大幅に増加することが期待され、その結果は2023年の結果に明らかになるかもしれません。

#### JavaScript

{{ figure_markup(
  image="median-size-js.png",
  caption="CMS別のJavaScriptリソースの中央値。",
  description="各デバイスでもっとも採用されている上位5つのCMSのJavaScriptリソースのダウンロード重量の中央値を示す棒グラフ。すべてのケースでデスクトップとモバイルのサイズは同じです。WordPressはデスクトップとモバイルで共に521 KBです。Drupalは両方で416 KBです。Joomlaは452 KBです。Wixは1,318 KBです。Squarespaceは両方で997 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1169405351&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

上位5つのCMSはすべてJavaScriptに依存するページを提供しており、Drupalがもっとも少ないJavaScriptバイトを提供しています：モバイルで416 KBです。Wixは1.3 MB以上のJavaScriptバイトを提供し、もっとも多くなっています。

#### HTMLドキュメント

{{ figure_markup(
  image="median-size-html.png",
  caption="CMS別のHTMLサイズの中央値。",
  description="各デバイスでもっとも採用されている上位5つのCMSのHTMLリソースのダウンロード重量の中央値を示す棒グラフ。ほとんどのケースでデスクトップとモバイルのサイズは非常に似ています。WordPressはデスクトップで40 KB、モバイルで37 KBです。Drupalは両方で23 KBです。Joomlaは26 KBと22 KBです。Wixはデスクトップで123 KB、モバイルで118 KBです。Squarespaceは両方で27 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1713320070&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

HTMLドキュメントサイズを調べると、上位のCMSのほとんどが中央値のHTMLサイズを約22 KB〜37 KBで提供していることがわかります。例外はWixで、約118 KBを提供しており、2021年の結果に比べてわずかな改善が見られます。これはインラインリソースの広範な使用を示唆しており、さらに改善できる領域を示しています。

#### CSS

{{ figure_markup(
  image="median-size-css.png",
  caption="CMS別のCSSサイズの中央値。",
  description="各デバイスでもっとも採用されている上位5つのCMSのCSSリソースのダウンロード重量の中央値を示す棒グラフ。ほとんどのケース（Wixを除く）でデスクトップとモバイルのサイズは非常に似ています。WordPressはデスクトップで117 KB、モバイルで115 KBです。Drupalはそれぞれ68 KBと66 KBです。Joomlaは86 KBと83 KBです。Wixはデスクトップで18 KBですが、モバイルでは9 KBのみです。Squarespaceは両方で89 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=176229983&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

次に、ダウンロードされる明示的なCSSリソースの使用を調査します。ここでは、CSSのインライン化についての議論を強化するプラットフォーム間で異なる分布が見られます。Wixはもっとも少ないCSSリソースを提供し、モバイルビューで約9 KBのみを送信します。WordPressは約115 KBでもっとも多くを提供します。

#### フォント

{{ figure_markup(
  image="median-size-font.png",
  caption="CMS別のフォントサイズの中央値。",
  description="各デバイスでもっとも採用されている上位5つのCMSのフォントリソースのダウンロード重量の中央値を示す棒グラフ。すべてのケースでデスクトップとモバイルのサイズは同じです。WordPressは137 KBです。Drupalは92 KBです。Joomlaは82 KBです。Wixは148 KBです。Squarespaceは202 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1008146261&format=interactive",
  sheets_gid="1736220112",
  sql_file="resource_weights.sql"
  )
}}

テキストを表示するために、ウェブ開発者はしばしばさまざまなフォントを使用します。Joomlaはモバイルビューでもっとも少ないフォントバイトを提供し、82 KBです。Squarespaceはもっとも多く202 KBを提供します。

## 2022年のWordPress

WordPressは現在、もっとも一般的に使用されているCMSです。CMSを使用して構築されたサイトの約3分の2がWordPressを使用しており、これについてさらに議論することが必要です。

WordPressは2003年から存在するオープンソースプロジェクトです。WordPress上で構築された多くのサイトは、Elementor、WP Bakery、Diviなどのページビルダーを通じてさまざまなテーマやプラグインを使用しています。

WordPressエコシステムは、CMSおよび追加機能に必要なカスタムサービスや製品（テーマやプラグイン）を維持しています。このコミュニティは比較的少数の人々によってCMS自体と追加機能の両方が維持されており、この影響は大きいです、WordPressがほとんどの種類のウェブサイトに対応できるほど十分に強力で柔軟であるため、市場シェアを説明する際にはこの柔軟性が重要ですが、WordPressベースのサイトのパフォーマンスについての議論を複雑にもします。

2021年には、WordPressコミュニティの貢献者がパフォーマンスの現状を認め、この<a hreflang="en" href="https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/">提案</a>でパフォーマンスに特化したコアチームを作ることが提案されました。これにより、平均的なWordPressサイトのパフォーマンスが向上することを期待しています。

今年は昨年の結果と比較し、地理的な採用と地理的なCore Web Vitalsの合格率に焦点を当て、平均リソース使用量を見ています。

### 地理別の採用率

まず、私たちは2021年の結果と比較して、データセット内のすべてのサイトを対象に地理的なWordPressの採用を調査しました。

{{ figure_markup(
  image="wordpress-adoption-geo-yoy.png",
  caption="地理別のWordPressの採用率（年次比較）。",
  description="ウェブサイトがもっとも多い10の地域におけるWordPressの採用率を示す棒グラフ。すべての国で、2021年は32%、2022年は34%です。アメリカ合衆国は両年とも32%です。日本は35%と38%、ブラジルは29%と31%、ドイツは27%と29%、イギリスは31%と32%、スペインは37%と39%、イタリアは36%と38%、インドは28%と30%、フランスも28%と30%、カナダは2021年に32%、2022年に33%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=442489769&format=interactive",
  sheets_gid="694875761",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=579
  )
}}

私たちのデータセットによると、主要な地域でWordPressの採用は著しく増加しています。

### 地理別のCore Web Vitals合格率

次に、地理的な分布、モバイルデバイスの使用、および2021年の結果との比較に基づいて、Core Web Vitalsの合格スコアを持つWordPressのオリジンの数を調べました。

{{ figure_markup(
  image="wordpress-cwv-yoy.png",
  caption="地理別のWordPress Core Web Vitals（年次比較）。",
  description="ウェブサイトがもっとも多い10の地域におけるWordPressのCore Web Vitalsの採用率を示す棒グラフ。アメリカ合衆国では、2021年は28%、2022年は40%です。日本では38%と52%、インドは8%と15%、ブラジルは5%と10%、イギリスは33%と44%、ドイツは35%と48%、スペインは21%と33%、イタリアは19%と29%、フランスは26%と39%、カナダは2021年に36%、2022年に49%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=1279742547&format=interactive",
  sheets_gid="1742929367",
  sql_file="core_web_vitals_by_geo.sql",
  width=600,
  height=579
  )
}}

すべての地域で改善が見られ、ブラジルの全体的な5%の増加から日本の14%の増加までの範囲です。ブラジルは10%と比較的低いですが、日本は52%と高く、地域間で大きな格差があります。低い側のブラジルは年間で100%の改善が見られ、来年のデータセットを評価する際には、低いパフォーマンスの原因と改善の機会をさらに調査する価値があるかもしれません。

### プラグイン

WordPressサイトが外部リソースをどのように使用しているかを探求し、それらをプラグイン、テーマ、WordPressコア（wp-includes）に含まれるリソースに分けて、2021年の結果と比較しました。

{{ figure_markup(
  image="median-wordpress-resources.png",
  caption="年次比較のWordPressリソース。",
  description="WordPressウェブサイトで使用されるリソースの中央値を示す棒グラフ。デスクトップとモバイルでリソース数は同じです：プラグイン24個、テーマ18個、wp-includesが中央値で12個です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQpmp9GvO62PKJmEC_yxnHVx4zuqKwYh68tquM5yZCCrOlZETqbLhu3iuSarRq2n4bW7dRbUoSB8NO2/pubchart?oid=660449132&format=interactive",
  sheets_gid="1922458949"
  )
}}

年を追うごとに使用されるリソースの数に目立った変化はありません。来年も再度調査を行い、人気のあるテーマやプラグインのパフォーマンスへの影響をさらに詳しく見ていくかもしれません。

## 結論

CMSプラットフォームは年々成長し続け、より一般的になっています。インターネット上でコンテンツを作成し消費するためには欠かせないものであり、とくにますます多くの人々やビジネスがオンラインプレゼンスを確立するにつれて、その重要性は増しています。

Core Web Vitalsの導入とパフォーマンスデータの可視性の向上により、ウェブパフォーマンスはCMSが使用されるあらゆる場所で優先事項となっています。この章の洞察が、ウェブの現状をより良く理解するのに役立ち、最終的にウェブをより良い場所にすることを願っています。

CMSは素晴らしい仕事をしており、インフラを強化し、新しい標準との統合や実験を進め、ベストプラクティスに従うことによって大規模にウェブ上でのユーザーエクスペリエンスをさらに向上させる機会を持っています。

一方で、Core Web Vitalsとしての基準もまだ進化の余地があります。上記で触れた<a hreflang="en" href="https://web.dev/responsiveness/">より良い反応性の指標</a>についてのいくつかのアイデアがあります。さらに、サイト内のページ間のナビゲーションは、<a hreflang="en" href="https://web.dev/vitals-spa-faq">シングルページアプリケーション（SPA）とマルチページアプリケーション（MPA）</a>のアーキテクチャ間の構造的な違いを考慮して、より適切に追跡されるべきです。

来年の結果を楽しみにしており、データセットを拡大し、方法論を改善することを望んでいます。その間、前進し続け、ウェブをより良くしていきましょう。
