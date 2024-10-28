---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: 2021年版Web AlmanacのCMSの章では、CMSの導入、CMSプラットフォーム上で動作するWebサイトのユーザーエクスペリエンス、CMSのリソースウェイトをカバーしています。
authors: [alonko]
reviewers: [alankent, andreylipattsev, chrissater, logicalphase]
analysts: [rviscomi, tosinarasi]
editors: [shantsis]
translators: [ksakae1216]
alonko_bio: Alon KochbaはWixのソフトウェア開発者であり、パフォーマンスに関する取り組みを統括しています。バックエンド出身で、ネットワーキングの豊富な経験を持ち、ウェブを大規模に高速化することを楽しんでいます。
results: https://docs.google.com/spreadsheets/d/1gAJh4VcSEU6-6aQxBiTFl-7cbyHukfdhg-Iaq9y5pnc/
featured_quote: CMSプラットフォームは成長を続けており、年々ユビキタスになってきています。とくに、より多くの人々や企業がオンラインプレゼンスを確立する中で、インターネット上で簡単にコンテンツを作成し、消費するために不可欠な存在となっています。
featured_stat_1: 46%
featured_stat_label_1: CMSによるWebサイト構築
featured_stat_2: 2MB
featured_stat_label_2: 上位CMSのページウェイトの中央値
featured_stat_3: 5.7%
featured_stat_label_3: WordPressサイトでのWebPの利用について
---

## 序章

この章では、CMSのエコシステムの現状と、ウェブ上でコンテンツを消費し体験する方法についてユーザーの認識を形成する上で、CMSが果たす役割の拡大を理解する一助となることを目指します。私たちの目標は、CMSの一般的な状況や、これらのシステムによって生成されたウェブページの特徴に関連する側面について議論することです。

CMSスペースと、ウェブの現在と未来におけるその役割を理解するための探求において、分析すべき多くの興味深く重要な側面と、答えるべき質問がある。私たちは、CMSプラットフォームの広大さと複雑さを認識し、この分野の主要なプレーヤーに関する深い専門知識と好奇心をもって取り組んでいます。

これらのプラットフォームは、私たちが高速で弾力性のあるウェブという集団的な探求を成功させるために重要な役割を担っています。このことは、この1年でますます明らかになり、今後もそうであることが期待されます。

CMS間のばらつきや、これらのプラットフォーム上で構築されるユーザーコンテンツの種類が異なることを考慮し、これらの比較は慎重に行うことが重要です。

CMSのプラットフォームが多数あるため、採用実績の上位のCMSのみにフォーカスしたセクションもあります。

**TLDR;** 世界の約半数のサイトがCMSで作成されていることがわかります。もっとも人気のあるCMSのトップ10は、前年比で比較的安定していますが、市場シェアには興味深い変化が見られます。CMSで構築されたサイトのパフォーマンスは、前回チェックしたときから劇的に向上しています。

それでは、分析に入りましょう。

<p class="note">**免責事項:** AlonはWixに勤務し、ウェブパフォーマンスの取り組みを率いていますが、意見は彼個人のものです。</a>

## CMSとは？

コンテンツマネジメントシステム（CMS）とは、個人や組織がコンテンツを作成、管理、公開するためのシステムのことです。とくにWebコンテンツ用のCMSは、Webで消費・体験されるコンテンツの作成・管理・公開を目的としたシステムです。

各CMSは、ユーザーがコンテンツを中心に簡単かつ効果的にウェブサイトを構築するために、幅広いコンテンツ管理機能のサブセットとそれに対応するメカニズムを実装しています。また、CMSは、ユーザーが必要に応じて簡単にコンテンツをアップロードし、管理できるようにすることを目的とした管理機能も提供しています。

CMSのサイト構築支援は、テンプレートにユーザーコンテンツを追加して利用するものから、ユーザーがサイト構造を設計・構築するものまで、その種類と範囲に大きな差があります。

CMSについて考えるとき、ウェブ上でコンテンツを公開するためのプラットフォームを提供するこのようなシステムの実行可能性に役割を果たすすべての構成要素を考慮する必要があります。これらすべての構成要素は、CMSプラットフォームを取り巻くエコシステムを形成し、ホスティングプロバイダー、エクステンション開発者、開発会社、サイトビルダーなどを含みます。したがって、私たちがCMSについて語るとき、通常はプラットフォームそのものと、それを取り巻くエコシステムの両方を指すことになります。

この章でのCMSの定義は、<a hreflang="en" href="https://www.wappalyzer.com/technologies/cms">WappalyzerのCMSの定義</a>を使用しています。

CMSの皆様には、この<a hreflang="en" href="https://github.com/AliasIO/wappalyzer">オープンソースプロジェクト</a>に貢献いただき、今後の検出・分類の改善に役立てていただきたいと思います。

Shopify、Magento、Webflow、および他のいくつかのプラットフォームは、WappalyzerでCMSとしてマークされていないため、この章の分析に表示されません。

Eコマースプラットフォームは、非CMSサイトのかなりの部分を占めており、[Eコマースの章](./ecommerce)でカバーされています。たとえば、<a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management/all/q">W3Techs</a>によると、Shopifyはこの1年で大きく成長し、7月にはウェブサイトの3.7%を占めるようになりました。

当社の調査では、200以上の個別のCMSが確認され、これらは1つのCMSにインストールされているものから数百万に及ぶものまでさまざまです。

その中には、オープンソースのもの（WordPressやJoomlaなど）もあれば、独自仕様のもの（WixやSquarespaceなど）もあります。CMSプラットフォームには、「無料」のホスティングプランやセルフホスティングプランで使用できるものもあれば、企業レベルでもより上位のプランで使用できるオプションもあります。

CMSの空間は全体として、CMSエコシステムの複雑な連合宇宙であり、すべてが分離していると同時に絡み合っているのです。

## CMSの採用

この作業を通じて、私たちの分析は、デスクトップとモバイルのウェブサイトを調べています。調べたURLの大半は両方のデータセットに含まれていますが、中にはデスクトップまたはモバイルデバイスからしかアクセスされないURLもあります。このためデータに小さな乖離が、生じる可能性があり、そのためデスクトップとモバイルの結果を別々に見ています。

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMS導入前年比。",
  description="過去3年間のCMSの導入状況を示すコラムチャート。2021年はデスクトップWebサイトの45％、モバイルWebサイトの46％がCMSを利用して構築されている。2020年はデスクトップ、モバイルともに42％、2019年はともに40％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=551554892&format=interactive",
  sheets_gid="362035103",
  sql_file="cms_adoption.sql"
) }}

2021年7月時点で、公共サイトの45%以上がCMSプラットフォームを採用しており、[2020年から](../2020/cms#CMSの採用)7%以上の成長を示しています。その内訳は、デスクトップが2019年の42％から45％、モバイルが2020年の42％から46％となっています。

この数字を<a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management/all/q">W3Techs</a>など、よく使われる別のデータセットと比較してみると、2021年7月時点でCMSを使って作成されているWebサイトの割合は64.6％と2020年7月の59.2％を上回り、9％以上増加していると報告されていて興味深いです。

我々の分析とW3Techsの分析との乖離は、調査方法の違い、そしてCMSとは何かという定義の違いによって説明できる。

W3Techsの定義は以下の通りです。「_コンテンツ管理システムとは、Webサイトのコンテンツを作成・管理するためのアプリケーションです。このカテゴリには、Wiki、ブログエンジン、ディスカッションボード、静的サイトジェネレータ、ウェブサイトエディタ、またはウェブサイトのコンテンツを提供するあらゆるタイプのソフトウェアとして分類されるシステムも含め、このようなシステムをすべて含みます_」

前述の通り、WappalyzerはCMSの定義をより厳しくしており、W3Techsのレポートに登場する主要なCMSは除外されている。

[方法論](./methodology)のページで、私たちの方法を詳しく説明しています。

### 地域別のCMS導入状況

CMSプラットフォームは、国によって多少の差はありますが、世界中で広く利用されています。

{{ figure_markup(
  image="cms-adoption-geo.png",
  caption="国別のCMS導入状況。",
  description="ウェブサイト数の多い10カ国を対象に、地域別にCMSの導入を紹介した棒グラフ。米国では、モバイルサイトの47％、デスクトップサイトの46％がCMSで構築されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=2092976179&format=interactive",
  sheets_gid="1226921580",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=538
) }}

ウェブサイト数が多い地域の中で、CMSの採用率がもっとも高いのは米国、イタリア、スペインで、ユーザーが訪問したモバイルサイトの46%～47%がCMSで構築されています。インドとブラジルはもっとも低く、それぞれ35%と37%にとどまっています。

また、このデータを世界中の<a hreflang="en" href="https://github.com/GoogleChrome/CrUX/blob/main/utils/countries.json">サブリージョン</a>に分割し、もっとも人気のある地域順に並べることで、マクロトレンドの特定をより容易にできます。

{{ figure_markup(
  image="cms-adoption-geo-region.png",
  caption="サブリージョン別のCMS導入状況。",
  description="世界のサブリージョン別にCMSの導入を紹介した棒グラフ。南ヨーロッパはモバイルサイトでのCMS導入率が50%ともっとも高く、東アジア、北アフリカ、中東アフリカは33%ともっとも低い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1483728038&format=interactive",
  sheets_gid="180022563",
  sql_file="cms_adoption_by_region.sql",
  width=600,
  height=701
) }}

導入がもっとも進んでいるのは南欧で、半数のサイトがCMSを使用しています。一方、もっとも進んでいないのは東アジアで、データセット中のサイトの3分の1しかCMSを使用していません。

### ランク別CMS採用状況

また、サイトの推定ランク別にCMSの採用状況を調査した。

{{ figure_markup(
  image="cms-adoption-rank.png",
  caption="CMSのランク別採用状況。",
  description="CMSの導入状況をサイトのランク別に分けたコラムチャート。ランキング上位のサイトほどCMSの導入が少なく、ランキング下位のサイトほどCMSの導入率が高い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=409766380&format=interactive",
  sheets_gid="158167539",
  sql_file="cms_adoption_by_rank.sql"
) }}

CMSは、分析対象の全データセットの42%であるのに対し、上位1,000のモバイルウェブサイトの7%にしか過ぎません。これは小規模な企業やウェブサイトでは、使いやすさからCMSを使用する傾向があり、上位のウェブサイトは、プロのウェブ開発者による独自のソリューションで構築される傾向があることから説明できます。CMSプラットフォームの利用が増え続けている中、今後、CMSプラットフォームも上位サイトの採用率を高めていくことができるのか、注目したいところです。

## 上位のCMS

{{ figure_markup(
  image="cms-adoption-share.png",
  caption="CMSの採用シェア。",
  description="CMSを利用している全ウェブサイトのうち、各CMSの相対的なシェアを示す円グラフ。CMSを利用して構築されたサイトの75%はWordPressで構築されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1206051687&format=interactive",
  sheets_gid="891456070",
  sql_file="top_cms.sql"
) }}

CMSを利用している全ウェブサイトの中で、相対的に大きなシェアを占めているのがWordPressのサイトで75％以上の導入率、次いでJoomla、Drupal、Wix、Squarespaceの順となっています。

{{ figure_markup(
  image="top-cms.png",
  caption="CMSの前年比トップ5。",
  description="過去3年間における、上位5つのCMSで構築されたWebサイトの割合を示したコラムチャート。WordPress、Wix、Squarespaceの採用率が前年比で増加し、DrupalとJoomlaは減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=845658898&format=interactive",
  sheets_gid="891456070",
  sql_file="top_cms.sql"
) }}

全ウェブサイトにおけるCMSの採用状況を調べたところ、218種類のCMSプラットフォームのうち、利用率が1%を超えているのは5つのプラットフォームのみでした。

もっともよく使われているプラットフォームであるWordPressは、このうち33.6%が使用しており、2020年の31.4%から7%増加し、総導入数は増加しています。

割合で言うと、JoomlaとDrupalの採用は減少しています。Joomlaのサイトは昨年の2.1%から1.9%に減少し（9.5%減）、Drupalは2%から1.8%に減少しました（10%減）。絶対的な普及率は、測定したサイトの数では増加しましたが、CMS全体の使用率および当社のデータセット（増え続けています！）に占める割合では、減少しています。

Wixの採用率は1.2%から1.6%（33%増）、Squarespaceは0.9%から1%（11%増）に増加しました。

CMSプラットフォームで構築されたこれらのサイトの採用を、<a hreflang="en" href="https://developers.google.com/web/updates/2021/03/crux-rank-magnitude">ランクの大きさ</a>で調べてみると、プラットフォーム間で興味深い分布が、あることがわかります。

{{ figure_markup(
  image="top-cms-by-rank.png",
  caption="CMSのランキングトップ5です。",
  description="上位5つのCMSで構築されたWebサイトの比率を、Webサイトのランキングで区分したコラムチャートです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=2087254046&format=interactive",
  sheets_gid="670045665",
  sql_file="top_cms_by_rank.sql"
) }}

上位1Kのモバイルサイトの3.1％がWordPressで構築されており、全体の33.6％がWordPressで構築されています。Drupalはランキングの中位（10K～1M）内で高い採用率を維持しており、WixとSquarespaceのサイトはほとんどが上位1Mサイト外にランクインしています。

## CMSのユーザー体験

CMSの重要な点は、そのプラットフォーム上に構築されたサイトを訪れるユーザーに対して、どのようなユーザー体験を提供するかということです。私たちは、<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report</a> (CrUX)が提供するRUMや、[Lighthouse](./methodology#lighthouse)を用いた合成テストを通じて、これらの経験を検証しようと試みています。

### コアWeb・バイタル

2021年は、ウェブパフォーマンスにとって素晴らしい年でした。<a hreflang="en" href="https://web.dev/articles/vitals#core-web-vitals">コアWeb・バイタル</a> への注目が高まり、多くのプラットフォームがユーザー体験とロード時間の改善に注力するよう正しい方向へ誘導されました。さらに重要なのは、ユーザーに適切なツールとガイダンスを提供し、ウェブサイトのパフォーマンスを監視して改善することです。その結果、多くのプラットフォームから大幅なパフォーマンスの改善が見られました。これらのプラットフォームは進化を続け、ウェブ全体のユーザー体験を徐々に良くしており、これは私たち全員にとって大きな収穫です。

<a hreflang="en" href="https://httparchive.org/reports/cwv-tech">コアWeb・バイタルの技術レポート</a> では、このデータを掘り下げ、月単位で更新される各技術の進捗を確認することが可能です。

このセクションでは、Web Almanac全体で提示されるデータに一貫した時間枠を提供するため、2021年7月のデータに焦点を当て、ユーザーがCMS搭載のWebページをどのように体験しているかについての理解に光を当てることができる、[Chromeユーザー体験レポート](./methodology#chrome-ux-report)が提供する重要な3要素を検証しています。

* 最大のコンテントフルペイント (LCP)
* 最初の入力までの遅延 (FID)
* 累積レイアウトシフト (CLS)

これらの指標は、優れたウェブ・ユーザー体験を示す中核的な要素を網羅することを目的としています。[パフォーマンス](./performance)の章でより詳しく説明しますが、ここではとくにCMSの観点からこれらの指標を見ることに興味があります。

まず、オリジン数が多い10のCMSプラットフォームを確認し、各プラットフォームのサイトのうち何パーセントが_passing_グレード（上記の各指標の75パーセンタイルが「良好」（緑）の範囲にあること）を持っているかを検証してみましょう。

{{ figure_markup(
  image="core-web-vitals.png",
  caption="CMSのコアとなるウェブバイタルの性能トップ10。",
  description="コアWebバイタルが良好なサイトの割合を、採用率の高いCMS10種類ごとに示した棒グラフ。WordPressはモバイルサイトの19％、デスクトップサイトの26％が合格しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=126065751&format=interactive",
  width=600,
  height=559,
  sheets_gid="113092024",
  sql_file="core_web_vitals.sql"
) }}

デスクトップからの訪問者は、一般的にモバイルよりもわずかに良いスコアであることがわかります。これは、モバイル機器の弱体化と回線の貧弱さによって説明できます。

また、特定のプラットフォームでモバイルとデスクトップの差が大きいということは、デバイスによってユーザーに提供されるページがかなり異なることを示唆しています。

7月のモバイル端末向けでは、TYPO3 CMS（主にヨーロッパ諸国で使用）が、もっとも合格率が高く、46%のモバイルサイトが3つのCWVすべてに合格しています。WordPress、Squarespace、Adobe Experience Managerは、合格したサイトの割合が20%未満でした。

デスクトップ端末の体験はやや良好で、1C-Bitrix（主にロシアで使用）は、CWVを通過したサイトの割合が56%ともっとも高かった。WordPressは合格率がもっとも低く、26%にとどまりました。

<p class="note">Dudaは、8月に47%のサイトが通過し、昨年から全体的に大きく進歩した点で、栄誉ある賞に値すると思います。彼らは、<a hreflang="en" href="https://github.com/AliasIO/wappalyzer/pull/4189">Wappalyzer</a>の誤った検出に関連して、7月に壊れたデータ収集のためにこのレポートに含まれておらず、彼らの起源を誤って膨らませ、彼らのCWV割合を減少させたのである。</p>

また、これらのCMSプラットフォームの進捗を、モバイルビューに着目して昨年のデータと比較して評価することもできます。

{{ figure_markup(
  image="core-web-vitals-yoy.png",
  caption="トップ10 CMSコアWebバイタルのモバイルビューのパフォーマンス前年比。",
  description="コアWebバイタルのモバイルサイトの合格率の前年比の変化を、採用率の高い10種類のCMSごとに並べた棒グラフです。TYPO3 CMSは、2020年の40%から2021年には46%のモバイルサイトがCWVを通過しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=904891027&format=interactive",
  width=600,
  height=559,
  sheets_gid="7628223",
  sql_file="core_web_vitals_yoy.sql"
) }}

これらのCMSはいずれも、2020年8月以降、CWVが良好なオリジンの割合が向上していることが確認できました。WixとSquarespaceがもっとも顕著な進展を見せ、他のCMSとの差を縮めています。

ここでは、3つのコアWeb・バイタルについて、各プラットフォームに改善の余地があるか、またどの指標が昨年からもっとも改善されたかを見ていきましょう。

#### 最大のコンテントフルペイント (LCP)

最大のコンテントフルペイント (LCP)は、ページのメインコンテンツが読み込まれ、ユーザーにとって有益なページとなった時点を測定します。これは、ビューポート内に表示される最大の画像またはテキストブロックのレンダリング時間を測定することによって行われます。

「良い」LCPは2.5秒以下とされています。

{{ figure_markup(
  image="core-web-vitals-lcp.png",
  caption="CMSのLCP性能トップ10。",
  description="LCPが良好なサイトの割合を、採用率の高い10種類のCMSごとに棒グラフで表示したもの。WordPressは、LCPが良好なモバイルサイトの割合が28％、デスクトップサイトの割合が40％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=22169494&format=interactive",
  width=600,
  height=559,
  sheets_gid="113092024",
  sql_file="core_web_vitals.sql"
) }}

TYPO3 CMSはLCPスコアがもっとも高く、69%のオリジンが「良い」LCP体験をしたのに対し、WordPressとAdobe Experience ManagerはLCPスコアがもっとも低く、28%のオリジンしか「良い」LCP体験をしていません。

一般に、ほとんどのプラットフォームがLCPの指標に苦労しているようです。これはおそらく、LCPが画像/フォント/CSSをダウンロードし、適切なHTML要素を表示することに依存していることに関連していると思われます。あらゆる種類のデバイスと接続速度で、これを2.5秒未満で達成することは困難です。LCPのスコアを向上させるには、通常、キャッシュ、プリロード、リソースの優先順位付け、競合する他のリソースの遅延ロードを正しく使用することが必要です。

{{ figure_markup(
  image="core-web-vitals-lcp-yoy.png",
  caption="CMS上位10社のモバイルビューのLCPパフォーマンス前年比。",
  description="LCPの良いモバイルサイトの割合の前年比の変化を、採用率の高い10種類のCMSごとに並べた棒グラフです。TYPO3 CMSは、2021年にLCPが良好なモバイルサイトの割合が69％となり、2020年の66％から上昇しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=5489725&format=interactive",
  width=600,
  height=559,
  sheets_gid="7628223",
  sql_file="core_web_vitals_yoy.sql"
) }}

すべてのCMSがこの1年でLCPを向上させたことがわかりますが、ほとんどのCMSが小幅な向上でした。もっとも大きく伸びたのは、昨年LCPのスコアが非常に低かったWixとSquarespaceです。Tildaもかなりの進歩があったようです。

#### 最初の入力までの遅延 (FID)

最初の入力までの遅延 (FID)は、ユーザーが最初にページとインタラクションを行ったとき（すなわちリンクをクリックしたとき、ボタンをタップしたとき、またはJavaScriptを使用したカスタムコントロールを使用したとき）から、ブラウザがそのインタラクションを処理できるようになるまでの時間を測定するものです。ユーザーの視点に立った「速い」FIDとは、サイト上でのユーザーの行動から、停滞した体験ではなく、ほとんど即座にフィードバックされることです。

遅延は苦痛であり、ユーザーがサイトを操作しようとしたときに、サイトの他の側面からのロードの干渉と相関している可能性があります。

「良い」FIDは100ミリ秒以下と見なされている。

{{ figure_markup(
  image="core-web-vitals-fid.png",
  caption="CMSのFID性能トップ10。",
  description="FIDが良好なサイトの割合を、採用率の高い10種類のCMSごとに棒グラフで示したもの。WordPressは、モバイルサイトの96%、デスクトップサイトの100%が良好なFIDを有しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1139890716&format=interactive",
  width=600,
  height=559,
  sheets_gid="113092024",
  sql_file="core_web_vitals.sql"
) }}

デスクトップでは、ほとんどのCMSでFIDは非常に良好で、すべてのプラットフォームで100%のスコアを獲得しています。ほとんどのCMSはモバイルでも90%以上の良好なFIDを実現していますが、BitrixとJoomlaは83%と85%のオリジンしか良好なFIDを実現していません。

ほぼすべてのプラットフォームが良好なFIDを提供できていることから、最近ではこの指標の厳密さについて疑問の声が上がっています。Chromeチームは最近、<a hreflang="en" href="https://web.dev/responsiveness/">記事</a>を公開し、将来的により良い応答性の指標を持つための考えを詳しく説明しました。

{{ figure_markup(
  image="core-web-vitals-fid-yoy.png",
  caption="トップ10 CMSのモバイルビューのFIDパフォーマンス前年比。",
  description="FIDの良いモバイルサイトの割合の前年比の変化を、採用率の高いCMS10種類ごとに並べた棒グラフです。Squarespaceは、2021年のFIDが良好なモバイルサイトの割合が、2020年の91%から98%に上昇しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=516116235&format=interactive",
  width=600,
  height=559,
  sheets_gid="7628223",
  sql_file="core_web_vitals_yoy.sql"
) }}

年間データを見ると、これらのCMSはすべて過去1年間にFIDを改善することができました。WixはFIDでもっとも追いつく必要があり、かなり数字を伸ばしました。JoomlaとBitrixは今年もっとも低いFIDスコアでしたが、それでも改善することができました。

#### 累積レイアウトシフト (CLS)

累積レイアウトシフト（CLS）は、ウェブページ上のコンテンツの視覚的安定性を測定するもので、ページの全寿命期間中に発生した。ユーザーとの直接的なインタラクションによらない、予期せぬレイアウトシフトごとに、レイアウトシフトのスコアの最大バーストを計測する。

レイアウトシフトは、あるレンダリングフレームから次のレンダリングフレームへ可視要素の位置が変わるときに発生します。

<a hreflang="en" href="https://web.dev/evolving-cls/">CLSメトリクスは昨年進化しました</a>。主にセッション ウィンドウズの概念を導入し、長寿命のページやシングルページアプリ (SPA) に対してより公平になりました。

0.1点以下を「良い」、0.25点以上を「悪い」、その間を「要改善」として測定しています。

{{ figure_markup(
  image="core-web-vitals-cls.png",
  caption="CMSのCLS性能トップ10。",
  description="CLSが有効なサイトの割合を、採用率の高い10種類のCMSごとに示した棒グラフです。WordPressは、モバイルサイトの61%、デスクトップサイトの58%が良好なCLSを実現しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1800297769&format=interactive",
  width=600,
  height=559,
  sheets_gid="113092024",
  sql_file="core_web_vitals.sql"
) }}

WixのCLSスコアはもっとも高く、モバイル端末の81%が「良い」CLSを獲得しています。AdobeエクスペリエンスマネージャーのCLSスコアはもっとも低く、モバイル端末の44%が「良い」CLSを獲得しているに過ぎません。レイアウトのずれは接続速度にかかわらず通常は避けることができるので、すべてのプラットフォームは、<a hreflang="en" href="https://web.dev/articles/optimize-cls">レイアウトのずれを最小限に抑える</a>ことによって、これらの数値を改善するよう努力する必要があります。

{{ figure_markup(
  image="core-web-vitals-cls-yoy.png",
  caption="トップ10 CMSのCLSのパフォーマンスは、モバイルビューの前年比。",
  description="CLSが良好なモバイルサイトの割合の前年比の変化を、採用率の高いCMS10社ごとに並べた棒グラフです。Wixは2020年の57％から2021年には81％のモバイルサイトが良好なCLSを実現しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1814103651&format=interactive",
  width=600,
  height=559,
  sheets_gid="7628223",
  sql_file="core_web_vitals_yoy.sql"
) }}

年間のデータを比較すると、ほとんどのCMSが何らかの進歩を遂げ、あるいはウィンドウズCLSメトリックスへの変更によって恩恵を受けたことがわかります。しかし、Weeblyのような特定のCMSは、過去1年間でCLSのスコアが後退していることがわかります。

### Lighthouse

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>は、ウェブページの品質を向上させるためのオープンソースの自動化ツールです。このツールの重要な点は、パフォーマンス、アクセシビリティ、SEO、ベストプラクティスなどの観点からウェブサイトの状態を評価するための一連の監査機能を提供していることです。Lighthouseレポートは、開発者がWebサイトのパフォーマンスを改善するための提案を得ることができる方法であるラボデータを提供しますが、Lighthouseスコアは<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">CrUX</a>が収集した実際のフィールドデータに直接影響を与えるものではありません。Lighthouseとその<a hreflang="en" href="https://web.dev/lab-and-field-data-differences/">ラボスコアとフィールドデータ</a>の相関については、こちらをご覧ください。

HTTP Archiveは、すべてのモバイル用ウェブページでLighthouseを実行しており（残念ながらデスクトップ用の結果はありません）、これも[CPUが遅い4G接続をエミュレートするためにスロットル](./methodology#lighthouse)されています。

このデータを分析することで、CrUXでは追跡できない指標も含むこれらの合成テストの結果を用いて、CMSのパフォーマンスを別の角度から評価できます。

#### パフォーマンススコア

Lighthouseの<a hreflang="en" href="https://web.dev/performance-scoring/">パフォーマンススコア</a>は、複数の指標スコアの加重平均値です。

{{ figure_markup(
  image="lighthouse-performance.png",
  caption="CMS上位10社のLighthouseパフォーマンススコア（中央値）。",
  description="もっとも採用されているCMS上位10社のLighthouseモバイルパフォーマンススコアの中央値を示す棒グラフです。一般に、どのプラットフォームもスコアが低く、TYPO3 CMSのスコアが33ともっとも高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1164945994&format=interactive",
  width=600,
  height=559,
  sheets_gid="267449225",
  sql_file="lighthouse_category_scores_per_cms.sql"
) }}

モバイルの上位プラットフォームのパフォーマンススコアの中央値は、17～33と低いことがわかります。上で見たように、 <a hreflang="en" href="https://philipwalton.com/articles/my-challenge-to-the-web-performance-community/">これはモバイルフィールド データの悪い結果</a>を直接意味しませんが、とくにローエンドデバイスとLighthouseが、エミュレートしたのと同様のネットワーク接続ではすべてのプラットフォームに改善の余地があることを示唆しています。

#### SEOスコア

検索エンジン最適化（SEO）とは、検索エンジンで見つけやすくするために、ウェブサイトを改善することです。詳しくは[SEO](./seo)の章で説明しますが、検索エンジンのクローラーにできるだけ多くの情報を提供し、検索エンジンの結果に適切に表示されるようサイトをコーディングすることもそのひとつです。カスタムメイドのWebサイトと比較すると、CMSはSEO対策に優れていることが期待されますが、このカテゴリにおけるLighthouseのスコアは適切に高いものでした。

{{ figure_markup(
  image="lighthouse-seo.png",
  caption="CMSトップ10 Lighthouse SEOスコアの中央値。",
  description="もっとも採用されているCMS上位10社のLighthouseモバイルSEOスコアの中央値を示す棒グラフ。Wixのスコアは中央値で95です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=98244918&format=interactive",
  width=600,
  height=559,
  sheets_gid="267449225",
  sql_file="lighthouse_category_scores_per_cms.sql"
) }}

上位10プラットフォームのSEOスコアの中央値はすべて84を超えており、Drupalのスコアがもっとも低く、Wixのスコアがもっとも高く、中央値は95となっています。

#### アクセシビリティスコア

アクセシブルWebサイトとは、障がい者の利用できるように設計・開発されたサイトのことです。また、Webアクセシビリティは、低速のインターネット接続環境など、障害のない人々にもメリットがあります。詳しくは、[アクセシビリティ](./accessibility)の章をご覧ください。

Lighthouseはアクセシビリティ監査のセットを提供し、すべての監査の加重平均を返します（各監査の加重方法の詳細については、<a hreflang="en" href="https://web.dev/accessibility-scoring/">スコアの詳細</a>を参照してください）。

各アクセシビリティ監査は合格か不合格のどちらかですが、他のLighthouse監査とは異なり、アクセシビリティ監査に部分的に合格してもページにはポイントが加算されません。たとえば、ある要素にはスクリーンリーダーに適した名前がついているが、他の要素にはついていない場合、そのページはスクリーンリーダーに適した名前の監査で0点を取られます。

{{ figure_markup(
  image="lighthouse-accessibility.png",
  caption="CMS上位10社のLighthouseアクセシビリティスコアの中央値。",
  description="もっとも採用されているCMS上位10社のLighthouseモバイルアクセシビリティスコアの中央値を示す棒グラフ。SquarespaceとWeeblyのスコアの中央値は91です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=306783633&format=interactive",
  width=600,
  height=559,
  sheets_gid="267449225",
  sql_file="lighthouse_category_scores_per_cms.sql"
) }}

上位10社のCMSのLighthouseアクセシビリティスコアの中央値は、76から91の間です。SquarespaceとWeeblyのスコアが91ともっとも高く、Tildaはもっとも低いアクセシビリティスコアでした。

#### ベストプラクティス

Lighthouse <a hreflang="en" href="https://web.dev/lighthouse-best-practices/">ベストプラクティス</a>はHTTPSをサポートしているか、コンソールにエラーが記録されていないかなど、さまざまな異なる指標について、WebページがWebのベストプラクティスにしたがっているかを確認しようとするものです。

{{ figure_markup(
  image="lighthouse-best-practices.png",
  caption="CMS上位10社のライトハウスベストプラクティススコア中央値。",
  description="もっとも採用されているCMS上位10社のLighthouseモバイルベストプラクティスのスコアの中央値を示す棒グラフ。Wixのスコアの中央値は93です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=813154253&format=interactive",
  width=600,
  height=559,
  sheets_gid="267449225",
  sql_file="lighthouse_category_scores_per_cms.sql"
) }}

Wixはベストプラクティスの中央値が93ともっとも高く、他のトップ10のプラットフォームの多くは73ともっとも低いスコアを共有しています。

## リソースの重み

また、HTTP Archiveのデータを使用して、さまざまなプラットフォームで使用されるリソースの重みを分析し、可能性のある機会を明らかにできます。ページの読み込みパフォーマンスは、ダウンロードされたバイト数だけに依存するわけではありません。しかしページの読み込みに必要なバイト数が少なければ、コストや二酸化炭素排出量を削減でき、とくに低速接続の場合はパフォーマンスが、向上する可能性があります。

{{ figure_markup(
  image="resource-weights-page.png",
  caption="CMSのページ重さの中央値トップ5。",
  description="もっとも採用されている上位5つのCMSの総ページ重量の中央値を、デバイスごとに示したコラムチャート。すべてのCMSのページ重量の中央値は2MB以上、Squarespaceのモバイルでのページ重量は3.3MB程度です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=658342587&format=interactive",
  sheets_gid="740406389",
  sql_file="resource_weights.sql"
) }}

上位5つのCMSのページウェイトの中央値は、Squarespaceの3.3MBを除き、ほとんどが2MB程度です。Squarespaceは、デスクトップよりもモバイルでより多くのバイトを提供する唯一のプラットフォームです。

{{ figure_markup(
  image="resource-weights-distribution.png",
  caption="CMSのページ重量の中央値トップ5。",
  description="モバイルページの総重量が、もっとも採用されている上位5つのCMSのそれぞれにおいて、どのような割合で分布しているかを示すコラムチャートです。WordPressのサイトでは、10パーセンタイルの684KBから90パーセンタイルの7.4MBの間となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1895669428&format=interactive",
  sheets_gid="1101340213",
  sql_file="page_weight_distribution.sql"
) }}

各プラットフォームのパーセンタイルにおけるページ重量の分布はかなり大きく、おそらく異なるウェブページ間のユーザーコンテンツの違い、使用されている画像の数、プラグインなどに関連していると思われます。プラットフォームごとに配信されるページがもっとも小さいのはDrupalで、10パーセンタイルの訪問に対して595KBしか送信されません。最大のページはSquarespaceで、90パーセンタイルの訪問で9.6MBが配信されました。


### ページ重量の内訳

ページ重量は、使用するリソースの総和です。このリソースサイズの違いを、異なるCMS間で評価することを試みることができます。


#### 画像

通常、もっとも重いリソースである画像は、リソースの重さの大部分を占めている。

{{ figure_markup(
  image="resource-weights-images.png",
  caption="上位5つのCMSの画像重量の中央値。",
  description="もっとも採用されているCMSのトップ5で、ダウンロードされる画像リソースの重量の中央値をデバイスごとに示したコラムチャートです。WordPressサイトの中央値は、モバイルとデスクトップで合計1.1MBの画像をダウンロードしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1403287616&format=interactive",
  sheets_gid="740406389",
  sql_file="resource_weights.sql"
) }}

Wixは、モバイルビューの中央値で357KBと大幅に少ない画像バイトしか配信しておらず、画像圧縮と遅延画像読み込みをうまく利用していることがうかがえます。他の上位5つのプラットフォームはすべて1MB以上の画像を配信しており、Squarespaceは最大の1.7MBを配信しています。

高度な画像フォーマットにより圧縮率が大幅に向上し、リソースの節約とサイトの高速読み込みが可能になりました。WebPは現在、すべての主要なブラウザで一般的にサポートされており、<a hreflang="en" href="https://caniuse.com/webp">95% サポート</a>されています。さらに新しい画像フォーマットとして<a hreflang="en" href="https://caniuse.com/avif">AVIF</a> や、<a hreflang="en" href="https://jpegxl.info/">JPEG-XL</a> は、まだ完全ではないが優れた可能性を秘めており、人気が出てきています。

トップクラスのCMSにおける、さまざまな画像フォーマットの使用状況を調べることができます。

{{ figure_markup(
  image="image-formats.png",
  caption="CMSの画像フォーマット人気TOP15。",
  description="CMSの採用率上位15社における、各画像フォーマットの相対的な人気度を示す棒グラフです。WordPressのサイトでは、以下の画像形式が使用されています。JPEG 41.2%、PNG 30.2%、GIF 18.3%、WebP 5.7%、SVG 3.3%、ICO 1.1%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=542088957&format=interactive",
  width=600,
  height=556,
  sheets_gid="105465286",
  sql_file="resource_weights.sql"
) }}

GoDaddy Website BuilderとWixはWebPをもっとも多く使用しており、それぞれ〜58％と33％の採用率です。一方、WordPress、Joomla、DrupalはほとんどWebPを提供しておらず、WordPressサイトで提供される画像のうちWebPは〜5.7％のみとなっています。AVIFはこれらのプラットフォームではほとんど使用されておらず、すべてのプラットフォームで ~0.1% 未満となっています。

<a hreflang="en" href="https://caniuse.com/webp">WebPのサポートの拡大</a>により、すべてのプラットフォームで、画質を落とさずに適用できる古いJPEGやPNG形式の使用を減らすための作業が必要になっているようです。

#### JavaScript

{{ figure_markup(
  image="resource-weights-javascript.png",
  caption="CMSのJavaScriptの重さの中央値トップ5。",
  description="もっとも採用されているCMSのトップ5で、ダウンロードされたJavaScriptリソースの重さの中央値をデバイスごとに示したコラムチャートです。WordPressサイトの中央値は、モバイルで469KB、デスクトップで494KBのJavaScriptが使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=289342580&format=interactive",
  sheets_gid="740406389",
  sql_file="resource_weights.sql"
) }}

上位5つのCMSはすべてJavaScriptに依存したページを配信していますが、DrupalのJavaScriptバイト数はモバイルで372KBと少なく、Wixは1.1MB以上ともっとも多いJavaScriptバイトを配信しています。

#### HTMLドキュメント

{{ figure_markup(
  image="resource-weights-html.png",
  caption="CMSのHTML重量の中央値トップ5。",
  description="もっとも採用されているCMSのトップ5で、ダウンロードされたHTMLリソースの重さの中央値をデバイスごとに示したコラムチャートです。WordPressサイトのHTMLサイズの中央値は、モバイルで34KB、デスクトップで36KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=890684063&format=interactive",
  sheets_gid="740406389",
  sql_file="resource_weights.sql"
) }}

HTMLドキュメントのサイズを調べてみると、Wixが123KBとかなり多くのHTMLを配信している以外は、ほとんどの上位CMSのHTMLサイズの中央値は22KBから34KBであることがわかります。これは、インライン化されたリソースを広範囲に使用していることを示唆しており、さらに改善できる領域であることを示しています。


#### CSS

{{ figure_markup(
  image="resource-weights-css.png",
  caption="CMSのCSS重さの中央値トップ5。",
  description="もっとも採用されているCMSのトップ5で、ダウンロードされたCSSリソースの重さの中央値をデバイスごとに示したコラムチャートです。WordPressサイトの中央値は、モバイルで115KB、デスクトップで119KBのCSSが使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=806030448&format=interactive",
  sheets_gid="740406389",
  sql_file="resource_weights.sql"
) }}

次に、ダウンロードされる明示的なCSSリソースの使用状況を調べます。ここでは、プラットフォーム間で異なる分布が見られ、インライン化アプローチの違いが強調されています。WixはCSSリソースの配信がもっとも少なく、モバイルビューではわずか~25KB、WordPressはもっとも多く、~115KBです。


#### フォント

{{ figure_markup(
  image="resource-weights-fonts.png",
  caption="CMSの中央値フォントの重さトップ5。",
  description="もっとも採用されているCMSのトップ5で、ダウンロードされたフォントリソースの重量中央値をデバイスごとに示したコラムチャートです。WordPressサイトの中央値は、モバイルで121KB、デスクトップで159KBのフォントを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=750270305&format=interactive",
  sheets_gid="740406389",
  sql_file="resource_weights.sql"
) }}

テキストを表示するために、ウェブ開発者は多くの場合、さまざまなフォントを使用することを選択します。Joomlaは、モバイルビューで75KBともっとも少ないフォントバイトを提供し、Squarespaceは212KBともっとも多いフォントバイトを提供しています。

## WordPress専用

WordPressは現在もっともよく使われているCMSで、CMSで構築されたサイトのほぼ4分の3がWordPressを使用しているので、さらに議論する必要があります。

WordPressは、2003年から続くオープンソースのプロジェクトです。WordPressで構築された多くのサイトでは、さまざまなテーマやプラグイン、時にはElementorやDiviなどのページビルダーを利用しています。

WordPressコミュニティは、CMSを維持し、カスタムサービスや製品（テーマやプラグイン）を通じて追加機能の必要条件を提供します。このコミュニティは、比較的少数の人々がCMSそのものと、WordPressをほとんどの種類のウェブサイトに対応できるほど強力で柔軟なものにする追加機能の両方を保守しているため、非常に大きな影響を及ぼしています。この柔軟性は、市場シェアを説明する上で重要ですが、WordPressベースのサイトのパフォーマンスに関する議論を複雑にしています。

WordPressコミュニティの貢献者は最近、パフォーマンスの現状を認め、パフォーマンス専門のコア チームを作るという <a hreflang="en" href="https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/">提案</a> で、平均的なWordPressサイトの現在のパフォーマンスを改善できると期待されています。

### 採用情報

まず、データセットに含まれるすべてのサイトについて、地域別のWordPressの導入状況を調査しました。

{{ figure_markup(
  image="wordpress-adoption-geo.png",
  caption="WordPressの国別採用状況。",
  description="ウェブサイト数が多い10地域ごとのWordPressの導入状況を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=625154641&format=interactive",
  width=600,
  height=579,
  sheets_gid="43346414",
  sql_file="core_web_vitals_by_geo.sql"
) }}

データセットに含まれるサイトの数が多い上位10カ国では、WordPressの導入率は27% 以上でした。スペインはこれらの国の中でもっともWordPressの普及率が高く、モバイルページの37%がWordPressを使用しているのに対し、ドイツでは28%しかWordPressが使用されていませんでした。

### 地域別CWV合格実績

次に、コアWeb・バイタルを通過したWordPressのオリジン量ですが、今回は地域別にモバイルデバイスの内訳を見てみましょう。

{{ figure_markup(
  image="wordpress-passing-cwv.png",
  caption="CWVを通過するWordPressの起源を地域別に紹介。",
  description="ウェブサイト数が多い10地域のそれぞれで、コアWeb・バイタルに合格したWordPressのオリジンの割合を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=642184103&format=interactive",
  height=579,
  sheets_gid="1013591764",
  sql_file="core_web_vitals_by_geo.sql"
) }}

すべての国でカウントされたオリジンのうち、WordPressは19%で合格していましたが、WordPressサイトは国によって合格率が大きく異なります。日本では、38%のサイトがモバイル訪問者のための良いCWVを持っていますが、ブラジルでは、わずか5%のサイトが良いCWVを持っています。

これは、コアWeb・バイタルの非常に興味深い見方を露呈しており、異なるプラットフォームのCWVを比較する際の地理的な偏りを示唆しています。CMSが特定の国でしか存在しない場合、総計の割合を比較することは公平な比較とは言えません。

デバイスの性能が低く、接続速度が遅い国々を含め、世界中で非常に多くの採用実績を持つWordPressは場合によってはこの比較に苦しむかもしれませんが、おそらくすべての地域で改善の余地があると思われます。一方、CMSはターゲットとする地域で最高の体験を提供するよう努力すべきであり、それは時に、より厳しい条件下でも十分に機能するようサイトを高速化することを意味します。

### プラグイン

WordPressサイトが外部リソースをどのように利用しているかを調査し、プラグインやテーマに含まれるリソースと、WordPressコアに同梱されるリソース（wp-includes）に分けました。

{{ figure_markup(
  image="wordpress-resources-loaded.png",
  caption="WordPressのリソースの種類別負荷分布。",
  description="WordPressウェブサイトで使用されているリソースのパーセンタイル分布を示すコラムチャートです。10パーセンタイルでは、4つのプラグイン/テーマ/wp-includesリソースが使用されており、90パーセンタイルでは、78のプラグイン、56のテーマ、24のwp-includesが使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=920269713&format=interactive",
  sheets_gid="296303301",
  sql_file="wordpress_resources.sql"
) }}

モバイルWordPressページの中央値では、`/plugins/`パスに24個のリソース、`/themes/`パスに18個のリソース、`/wp-includes/`パスに12個のリソースがロードされていることがわかります。90パーセンタイルでは、78個のプラグインリソース、56個のテーマ、24個のwp-includesと、膨大な量のリソースがリクエストされていることがわかります。

WordPressの拡張エコシステムは並外れた柔軟性を提供し、その高い普及率に大きく寄与していると思われます。しかし、多くのプラグインが存在し、多くのリソースに依存しているため、多くの場合、性能に悪影響を及ぼしているように見えます。

## 結論

CMSプラットフォームは成長を続けており、年々ユビキタスになってきています。とくに、より多くの人々や企業がオンラインプレゼンスを確立する中で、インターネット上で簡単にコンテンツを作成し、消費するために不可欠な存在となっています。

コアWeb・バイタルの導入は、パフォーマンスデータの可視化の進展とともに、ウェブ全体のウェブパフォーマンスへの注目を生み出しました。これらの洞察が、ウェブの現状をよりよく理解し、最終的にウェブをより良い場所にするため役立つことを期待しています。

CMSは素晴らしい仕事をしておりインフラの強化に努め、進化する新しい標準を試し統合しベストプラクティスに従うことで、ウェブ上のユーザー体験を大規模にさらに改善する大きなチャンスを持っています。

一方、コアWebバイタルはまだまだ進化しています。

私たちは、上記の <a hreflang="en" href="https://web.dev/responsiveness/">ベターレスポンスメトリクス</a>に向けた考えについて言及しました。さらに、サイト内のページ間の移動をより適切に追跡し、<a hreflang="en" href="https://web.dev/articles/vitals-spa-faq">シングルページ・アプリケーション（SPA）とマルチページ・アプリケーション（MPA）</a> のアーキテクチャの違いを考慮する必要があります。

これからも突き進んでいきましょう。
