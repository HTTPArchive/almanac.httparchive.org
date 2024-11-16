---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: パフォーマンス
description: Core Web Vitals、Lighthouse Performance Score、First Contentful Paint(FCP)、Time to First Byte(TTFB)を網羅した2020年版Web Almanacのパフォーマンス編。
hero_alt: Hero image of Web Almanac chracters images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [thefoxis]
reviewers: [borisschapira, rviscomi, foxdavidj, noamr, Zizzamia, exterkamp]
analysts: [max-ostapenko, dooman87]
editors: [tunetheweb]
translators: [ksakae1216]
thefoxis_bio: Karolinaは、<a hreflang="en" href="https://calibreapp.com/">Calibre</a>のプロダクトデザインリーダーとして、最も包括的なスピードモニタリングプラットフォームの開発に取り組んでいます。また、パフォーマンスに関するニュースやリソースをお届けする<a hreflang="en" href="https://perf.email/">Performance Newsletter</a>の編集も担当しています。また、パフォーマンスがユーザー体験に与える影響について、<a hreflang="en" href="https://calibreapp.com/blog/category/web-platform">頻繁に記事を書いています</a>。
discuss: 2045
results: https://docs.google.com/spreadsheets/d/164FVuCQ7gPhTWUXJl1av5_hBxjncNi0TK8RnNseNPJQ/
featured_quote: パフォーマンスの低さは、不満やコンバージョンへの悪影響を引き起こすだけでなく、現実的な参入障壁となります。今年の世界的な大流行は、そうした既存の障壁をさらに明らかにしました。
featured_stat_1: 25%
featured_stat_label_1: モバイルでのFCPに優れたサイト
featured_stat_2: 18%
featured_stat_label_2: モバイルでのTTFBが良好なサイト
featured_stat_3: 4%
featured_stat_label_3: LH6のパフォーマンス・スコアが変わらないサイト
---

## 序章

スピードの遅さが全体的なユーザー体験、ひいてはコンバージョンに悪影響を及ぼすことは疑いの余地がありません。しかしパフォーマンスの低下は、単にフラストレーションの原因になったり、ビジネス上の目標に悪影響を及ぼすだけでなく、現実に参入障壁を生み出します。今年の世界的なパンデミックでは、<a hreflang="en" href="https://www.weforum.org/agenda/2020/04/coronavirus-covid-19-pandemic-digital-divide-internet-data-broadband-mobbile/">そのような既存の障壁がさらに明らかになりました</a>。遠隔地での学習、仕事、交流への移行に伴い、突然、私たちの生活全体がオンラインに移行しました。接続性が悪く、高性能なデバイスにアクセスできないため、多くの人にとってこの変化は、不可能ではないにしても、せいぜい苦痛でしかありませんでした。これは、世界中の接続性、デバイス、速度の不平等を浮き彫りにする、真のテストとなりました。

パフォーマンス・ツールは、ユーザー体験の多様な側面を描き出し、根本的な問題を見つけやすくするために進化し続けています。[昨年のパフォーマンスの章](../2019/performance)以降、この分野では数多くの重要な開発が行われており、スピードモニタリングへの取り組み方をすでに変革しています。

人気の高い品質監査ツール「Lighthouse 6」の大幅なリリースに伴い、<a hreflang="en" href="https://calibreapp.com/blog/how-performance-score-works">有名な「パフォーマンススコア」のアルゴリズムが大幅に変更され</a>、スコアも変更されました。<a hreflang="en" href="https://calibreapp.com/blog/core-web-vitals">Core Web Vitals</a>という、ユーザー体験のさまざまな側面を描いた新しいメトリクスが発表されました。これは、今後の検索ランキングの要因のひとつとなり、開発コミュニティの目を新しいスピードシグナルへ移すことになるでしょう。

この章では、<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report (CrUX)</a>が提供する実世界のパフォーマンスデータを、これらの新開発のレンズを通して見ていくとともに、その他の関連するいくつかのメトリクスを分析します。なお、iOSの制限により、CrUXのモバイル版の結果には、アップル社のモバイルOSを搭載したデバイスは含まれていませんのでご了承ください。この事実は、とくに国ごとの指標のパフォーマンスを調べる際に、分析に影響を与えることは間違いありません。

それでは早速、ご紹介しましょう。

## Lighthouseパフォーマンススコア

2020年5月、<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/releases/tag/v6.0.0">Lighthouse 6がリリースされました</a>。人気のパフォーマンス監査スイートの新しいメジャーバージョンでは、パフォーマンススコアのアルゴリズムに注目すべき変更が加えられました。パフォーマンススコアは、サイトの速度をハイレベルで表現したものです。Lighthouse 6では、5つの指標ではなく6つの指標でスコアを測定します。「First Meaningful Paint」と「First CPU Idle」が削除され、代わりに「Largest Contentful Paint」（LCP）、「Total Blocking Time」（TBT、ラボでは「First Input Delay」に相当）、「Cumulative Layout Shift」（CLS）が採用されました。

新しいスコアリングアルゴリズムでは、新世代のパフォーマンス指標が優先されています。「Core Web Vitals」を優先し「First Contentful Paint（FCP）」、「インタラクティブになるまでの時間（TTI）」、「Speed Index」は、スコアの重みが小さくなるにつれて優先度を下げています。また、このアルゴリズムでは、ユーザー体験の3つの側面が強調されています。*インタラクティブ性*（Total Blocking TimeとTime to Interactive）、*視覚的安定性*（Cumulative Layout Shift）、*負荷の認識*（First Contentful Paint、Speed Index、Largest Contentful Paint）です。

また、デスクトップとモバイルで異なる基準点を用いてスコアを算出するようになりました。これが実際に意味するところは、デスクトップでは（高速なウェブサイトを期待して）寛容さに欠け、モバイルでは（モバイルでのベンチマークパフォーマンスはデスクトップよりも迅速ではないため）寛容になるということです。Lighthouse 5と6のスコアの違いを比較するには、<a hreflang="en" href="https://googlechrome.github.io/lighthouse/scorecalc/">Lighthouse Score calculator</a>をご利用ください。では、実際にスコアはどのように変化したのでしょうか。

{{ figure_markup(
  image="performance-change-in-lighthouse-score.png",
  caption="Lighthouse Performance Scoreにおけるバージョン5と6の違い。",
  description="バージョン5とバージョン6のパフォーマンススコアの変化を示すコラムチャート。スコアに変化がなかったサイトは4％ともっとも多く、スコアの改善よりも減少が、多いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=786955541&format=interactive",
  sheets_gid="518150031",
  sql_file="lh6_vs_lh5_performance_score_02.sql"
  )
}}

上の図では、4%のウェブサイトがパフォーマンススコアの変化を記録しなかったことがわかりますが、マイナスの変化を記録したサイトの数がスコアの改善を記録したサイトを上回っています。パフォーマンススコアの成績は悪化しており（10～25ポイントのエリアでもっとも顕著な減少カーブを描いています）、これは以下でさらに直接的に描写されています。

{{ figure_markup(
  image="performance-lighthouse-score-distributions-yoy.png",
  caption="Lighthouse 5と6のLighthouse Performance Scoreの分布。",
  description="Lighthouse 5とLighthouse 6でパフォーマンススコア0～100を獲得したサイトの割合を示した散布図。Lighthouse 6のアルゴリズムでは、0～25のスコアを持つサイトの割合が増加し、50～100のスコアを持つサイトの数が減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=926035471&format=interactive",
  sheets_gid="1303574513",
  sql_file="lh6_vs_lh5_performance_score_distribution.sql"
  )
}}

Lighthouse 5とLighthouse 6の比較では、スコアの分布がどのように変化したかを直接観察できます。Lighthouse 6のアルゴリズムでは、0～25点のスコアを獲得したページの割合が増え、50～100点のスコアを獲得したページの割合が減っています。Lighthouse 5では、100点を獲得したページの割合は3%でしたが、Lighthouse 6では、その割合はわずか1%にまで減少しました。

このような全体的な変化は、アルゴリズム自体に多数の修正が加えられていることを考えると、予想外のことではありません。

## Core Web Vitals: Largest Contentful Paint

Largest Contentful Paint(LCP)は、最大の<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/#what-elements-are-considered">above-the-fold要素</a>がレンダリングされた時間を報告する、画期的なタイミングベースのメトリックです。

### デバイス別LCP

{{ figure_markup(
  image="performance-lcp-by-device.png",
  caption="デバイスタイプごとに分割されたLCPパフォーマンスの集計。",
  description="デスクトップで53％、モバイルで43％のウェブサイト体験が「良い」に分類されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=696629857&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

上のグラフでは、43％から53％のウェブサイトでLCPのパフォーマンスが、良好（2.5秒以下）であることがわかります。つまり、大多数のウェブサイトでは、重要なオーバーザフォールドメディアを優先的に高速で読み込むことができています。比較的新しい指標としては、これは楽観的なシグナルと言えます。デスクトップとモバイルで若干の差があるのは、ネットワークの速度、デバイスの性能、画像のサイズ（デスクトップ特有の大きな画像は、ダウンロードとレンダリングに多くの時間を使う）が、異なることが原因と考えられます。

### 地域別LCP

{{ figure_markup(
  image="performance-lcp-by-geo.png",
  caption="国別に分割されたLCPのパフォーマンスを集計。",
  description="LCPの良好な測定値の割合がもっとも高いのは、ヨーロッパとアジアの国々に分布していることを示す棒グラフ。韓国は76％の良好な測定値でトップ、インドは16％で最下位です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1936626175&format=interactive",
  width="645",
  height="792",
  sheets_gid="263037691",
  sql_file="web_vitals_by_country.sql"
  )
}}

良好なLCP測定値の割合がもっとも高いのは、主にヨーロッパとアジアの国々に分布しており、韓国は良好な測定値の割合が76%でトップでした。韓国は携帯電話の通信速度において常にトップであり、10月にはダウンロード145Mbpsという驚異的な数値が <a hreflang="en" href="https://www.speedtest.net/global-index"> Speedtest Global Index</a> で報告されています。日本、チェコ、台湾、ドイツ、ベルギーも、確実に高いモバイル速度を誇る国の一角です。オーストラリアは、モバイルネットワークの速度ではトップであるものの、デスクトップ接続の遅さと遅延に悩まされており、上記のランキングでは最下位となっています。

インドは、我々の一連のデータの中では最後の方に位置しており、良い体験ができたのはわずか16%でした。はじめてインターネットに接続する人口は継続的に増加していますが、モバイルとデスクトップのネットワーク速度は<a hreflang="en" href="https://www.opensignal.com/reports/2020/04/india/mobile-network-experience">依然として問題となっています</a>。平均ダウンロード速度は4Gで10Mbps、3Gで3Mbps、デスクトップでは50Mbpsを下回っています。

### 接続タイプ別LCP

{{ figure_markup(
  image="performance-lcp-by-connection-type.png",
  caption="接続タイプ別に分割されたLCPパフォーマンスを集計。",
  description="棒グラフによると、4Gで48%のWebサイトが良好なLCPを持っていることがわかります。評価の高いウェブサイトの数は、3Gでは8％、2Gでは1％、低速の2Gでは0％、オフライン接続では18％に減少しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=97874305&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

LCPは、最大のオーバーザフォールド要素（画像、動画、テキストを含むブロックレベルの要素を含む）がレンダリングされたときに表示されるタイミングなので、ネットワークの速度が遅いほど、測定値の悪い部分が多くなるのは当然のことです。

ネットワーク速度とLCPパフォーマンスの向上には明確な相関関係がありますが、4Gであっても、結果が「良好」に分類されたのは48% に過ぎず、読み取り値の半分は改善が必要とされています。メディアの最適化を自動化し、適切なサイズとフォーマットを提供し、さらに低データモードに最適化することで、針を動かすことができるでしょう。このガイドでは、<a hreflang="ja" href="https://web.dev/i18n/ja/optimize-lcp/">LCPの最適化について詳しく説明しています</a>。

## Core Web Vitals: Cumulative Layout Shift

Cumulative Layout Shift(CLS)とは、ページ閲覧中にビューポート内の要素がどれだけ移動するかを数値化したものです。秒やミリ秒といった単位でインタラクションの特定の部分を測定しようとするのではなく、ウェブサイト上で予想外の動きがどの程度発生しているかを正確に把握し、ユーザー体験を評価できます。

このように、CLSは本章で紹介した他の指標とは異なる、新しいタイプのUXホリスティック指標です。

### デバイス別CLS

{{ figure_markup(
  image="performance-cls-by-device.png",
  caption="デバイスタイプごとに分割されたCLSのパフォーマンスを集約。",
  description="棒グラフでは、デスクトップで54％、モバイルで60％と、半数以上のウェブサイトが良好なCLSを持っていることが示されています。どちらの場合も、CLSが悪いと評価されたのは21%だけでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1672696367&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

CrUXのデータによると、デスクトップの場合もモバイルの場合も、半数以上のWebサイトがCLSの良い評価を得ています。デスクトップとモバイルでは、評価の高いウェブサイトの数にわずかな差（6ポイント）があり、モバイルの方が有利です。これは、モバイルに最適化されているため、機能やビジュアルが充実していない傾向があり、CLS評価では携帯電話がリードしていると推測できます。

### 地域別CLS

{{ figure_markup(
  image="performance-cls-by-geo.png",
  caption="国別に分割されたCLSのパフォーマンスを集計しています。",
  description="上位28カ国では、50％以上のウェブサイトで良好なCLSが報告されていることが棒グラフで示されています。中程度（改善が必要）」は全体の11～15％で安定しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1861585123&format=interactive",
  width="645",
  height="792",
  sheets_gid="47865955",
  sql_file="web_vitals_by_country.sql"
  )
}}

異なる地域でのCLSのパフォーマンスは主に良好で、少なくとも56％のサイトが「良好」と評価されました。これは、視覚的に安定していると思われる優れたニュースです。LCPの地域分布で見られたように、韓国、日本、チェコ、ドイツ、ポーランドといった国が上位を占めていることがわかります。

視覚的安定性は、LCPのような他のメトリクスに対する地理的および遅延の影響を受けにくい。上位の国と下位の国との間の良い評価の割合の差は、LCPでは61％、CLSではわずか13％です。中程度の評価のウェブサイトの割合は全体的に比較的低く、全体的に悪い体験の割合は19%～29%となっています。CLSの低下には多くの要因があります。<a hreflang="ja" href="https://web.dev/i18n/ja/optimize-cls/">Optimize Cumulative Layout Shift guide</a>では、それらの要因に対処する方法を紹介しています。

### 接続タイプ別CLS

{{ figure_markup(
  image="performance-cls-by-connection-type.png",
  caption="CLSのパフォーマンスを接続タイプ別に集計したものです。",
  description="CLSの測定結果は、「良い」、「改善が必要」、「悪い」が均等に分布していることを示す棒グラフです。良い」と回答した割合は、「オフライン」が70％、「4G」が64％で、それぞれトップとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=151288279&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

CLSスコアは、オフラインと4Gを除くほとんどの接続タイプで、ほぼ均等に分布しています。オフラインのシナリオでは、サービスワーカーがウェブサイトを提供していると推測されます。そのため、接続形態によるダウンロードの遅延がなく、良い成績がもっとも多くなっています。

4Gについて明確な結論を出すのは困難ですが、おそらく4G+接続がデスクトップ機器のインターネット・アクセス方法として使用されているのではないかと推測できます。この仮定が妥当であれば、Webフォントや画像が大量にキャッシュされ、CLS測定にプラスの影響を与える可能性があります。

## Core Web Vitals: First Input Delay

First Input Delay (FID) は、ユーザーが最初にインタラクションを行ってから、ブラウザがそのインタラクションに応答できるまでの時間を測定します。FIDは、ウェブサイトがどれだけインタラクティブであるかを示す良い指標です。

### デバイス別FID

{{ figure_markup(
  image="performance-fid-by-device.png",
  caption="デバイスタイプ別に分割されたFIDのパフォーマンスを集約したもの。",
  description="デスクトップ（100%）とモバイル（80%）での良好なFIDパフォーマンスの割合が高いことを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2090682651&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

良いスコアがこれほど高い割合でウェブサイトに分布しているのは、比較的珍しいことです。デスクトップでは、サイトの分布の75パーセンタイルに基づいて、100％のサイトがFIDの速いタイミングを報告しており、インタラクションの遅延を経験している人の数は非常に少ないことを意味しています。

モバイルでは、80％のサイトが「良い」と評価されています。これは、デスクトップに比べてCPUの能力が低いこと、モバイルでのネットワークの遅延（スクリプトのダウンロードと実行が遅れる）、さらにバッテリー効率と温度の制限によりモバイル機器のCPUの能力が制限されていることが原因と考えられます。これらはすべて、FIDなどのインタラクティビティ指標に直接影響します。

### 地理的な位置によるFID

{{ figure_markup(
  image="performance-fid-by-geo.png",
  caption="国別に分けられたFIDのパフォーマンスを集計。",
  description="国別に見たFIDの優れたパフォーマンスを示す棒グラフ。上位28カ国では、79％から97％の割合でFIDを利用しており、利用していない国はほとんどありません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1107653062&format=interactive",
  width="645",
  height="792",
  sheets_gid="2120295762",
  sql_file="web_vitals_by_country.sql"
  )
}}

FIDスコアの地理的分布は、先に紹介したデバイス集計表の結果を裏付けるものです。最悪の場合、79％のWebサイトが良好なFIDを持っていますが、トップは97％と印象的で、韓国が再びリードしています。興味深いことに、CLSとLCPのランキングで上位を占めていたチェコ、ポーランド、ウクライナ、ロシアなどの国々が、このランキングでは最下位になっています。

ここでも、その理由を推測できますが、本当のところを確かめるには、さらなる分析が必要です。FIDがJavaScriptの実行能力と相関していると仮定すると、より高性能なデバイスがより高価で高級品として扱われる国ではFIDランキングが、低くなる可能性があります。 ポーランドを例に挙げると、米国に比べて<a hreflang="en" href="https://qz.com/1106603/where-the-iphone-x-is-cheapest-and-most-expensive-in-dollars-pounds-and-yuan/">iPhoneの価格がもっとも高い</a>国のひとつであり、[相対的に低い賃金](https://en.wikipedia.org/wiki/List_of_European_countries_by_average_wage#Net_average_monthly_salary)と相まって、1回の給料ではアップルの主力製品を購入するには不十分です。対照的に、<a hreflang="en" href="https://www.news.com.au/finance/average-australian-salary-how-much-you-have-to-earn-to-be-better-off-than-most/news-story/6fcdde092e87872b9957d2ab8eda1cbd">平均的な給料</a>をもらっているオーストラリア人は、1週間分の給料でiPhoneを購入できます。幸いなことに、低評価のウェブサイトの割合はほとんどが0で、1～2％の読み取り率の例外もあり、インタラクションに対する反応が比較的スピーディであることを指し示しています。

### 接続タイプ別FID

{{ figure_markup(
  image="performance-fid-by-connection-type.png",
  caption="接続タイプ別に分割されたFIDのパフォーマンスを集計したもの。",
  description="異なるタイプのネットワークで一貫して高い分布の良好なFIDパフォーマンスを示す棒グラフ。オフライン、3G、4Gが80％以上の良好な評価のウェブサイト体験をリードしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=808962538&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

ネットワークの速度と高速FIDには直接的な相関関係があり、2Gネットワークでは73％、4Gネットワークでは87％となっています。ネットワークが速ければ、スクリプトのダウンロードが速くなり、その結果、解析の開始が速くなり、メインスレッドをブロックするタスクが少なくなります。とくに、評価の低いサイトの割合が5％を超えていないのに、このような結果が出たのは楽観的です。

## First Contentful Paint

First Contentful Paint（FCP）は、ブラウザがテキスト、画像、非白キャンバス、SVGコンテンツをレンダリングした最初の時間を測定します。FCPは、サイトが読み込まれる最初の兆候を見るまでの待ち時間を示すもので、体感速度の良い指標となります。

### デバイス別FCP

{{ figure_markup(
  image="performance-fcp-desktop-distribution.png",
  caption="デスクトップでのFCPパフォーマンスが「速い」「普通」「遅い」と判定されたウェブサイトの分布。",
  description="デスクトップ上のFCPパフォーマンスが「速い」「普通」「遅い」と表示されたWebサイトの分布。速いウェブサイトの分布は、中央に膨らみがある線形に見える。2019年と比較して、速いFCP体験と遅いFCP体験が増えているが、FCP分類の変更により平均的な体験の数は縮小している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1953305743&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

{{ figure_markup(
  image="performance-fcp-mobile-distribution.png",
  caption="モバイルでのFCPパフォーマンスが「速い」「普通」「遅い」と判定されたウェブサイトの分布。",
  description="デスクトップでFCPパフォーマンスが「速い」「平均」「遅い」と表示されたウェブサイトの分布。速いウェブサイトの分布は直線的に見え、デスクトップのグラフで観察される膨らみは少ない。2019年と比較して、速いFCP体験と遅いFCP体験が増加し、FCP分類の変更により平均的な体験の数が減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=38297781&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

上のグラフでは、FCPの分布をデスクトップとモバイルで分けています。[昨年との比較](../2019/performance#fcp-by-device)では、平均的なFCP測定値が明らかに少なくなっている一方で、デバイスの種類にかかわらず、速いユーザー体験と遅いユーザー体験の割合が上昇しています。モバイルユーザーがデスクトップユーザーよりも遅いFCPを体験する頻度が高くなるという同じ傾向がまだ見られます。全体的に、ユーザーは平凡な体験ではなく、良い体験や悪い体験をすることが多くなっています。

{{ figure_markup(
  image="performance-fcp-mobile-year-on-year.png",
  caption="FCPモバイルパフォーマンスが良い、改善が必要、悪いとラベル付けされたウェブサイトの分布を2019年と2020年で比較したもの。",
  description="Bar chart showing how the distribution of good, needs improvement and poor mobile FCP has changed between 2019 and 2020. In 2020, 75% of websites have a sub-par FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2037503700&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

モバイルデバイスでのFCPを前年比で比較すると、良い体験が少なく、中程度や悪い体験が多くなっています。75%のWebサイトでは、FCPがあまり良くないものとなっています。このように、理想的ではないFCPが高い割合で読まれていることが、不満やユーザー体験を低下させる原因になっていると推測できます。

たとえば、サーバーの遅延（Time to First Byte（TTFB）（#time-to-first-byte）やRTTなどのいくつかの指標で測定）、JavaScriptリクエストのブロック、カスタムフォントの不適切な処理など、数多くの要因でペイントを遅らせる原因となっています。

### 地域別FCP

{{ figure_markup(
  image="performance-fcp-by-geo.png",
  caption="国別に分割されたFCPのパフォーマンスを集計。",
  description="FCPパフォーマンスの良好なウェブサイトが40％以上あるのは28カ国中7カ国のみであることを示す棒グラフ。FCPの値域の変更により、2019年と比較して良い結果と悪い結果の数が増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=78259488&format=interactive",
  sheets_gid="1708427314",
  width="645",
  height="792",
  sql_file="web_vitals_by_country.sql"
  )
}}

分析を掘り下げる前に、2019年の「パフォーマンス」の章では、「良い」と「悪い」の分類のしきい値が2020年とは異なっていたことに触れておきます。2019年には、FCPが1秒以下のサイトは「良い」とされ、FCPが3秒以上のサイトは「悪い」に分類されました。2020年には、これらの範囲は「良い」が1.5秒、「悪い」が2.5秒にシフトしました。

この変化は、分布がより多くの「良い」および「悪い」評価のウェブサイトにシフトすることを意味します。[昨年の結果](../2019/performance#fcp-by-geography)と比較しても、「良い」ウェブサイトと「悪い」ウェブサイトの割合が上昇していることから、その傾向を観察できます。速いウェブサイトの割合が高い上位10地域は、チェコとベルギーが加わり、米国と英国が落ちたことで、2019年とは比較的変わりません。韓国は、高速FCPを報告しているウェブサイトの62％でトップに立ち、昨年から約2倍になっています（これも、結果の再分類によるものと思われます）。ランキング上位の他の国でも、良い体験をしたという報告が倍増しています。

平凡（「改善が必要」）なサイトの割合が少なくなる一方で、パフォーマンスの低いFCPサイトの数は増加しており、とくにラテンアメリカや南アジア地域のランキング下位で顕著になっています。

繰り返しになりますが、TTFBの読み取り率が悪いなど、FCPに悪影響を及ぼす理由はいくつかありますが、必要な文脈がなければ証明することは困難です。たとえば、オーストラリアのような特定の国のパフォーマンスを分析すると、意外にも低い方になります。オーストラリアは、世界でもっともスマートフォンの普及率が高い国の1つであり、モバイルネットワークももっとも高速で、平均所得水準も比較的高い国の1つです。本来であれば、もっと上位にあるべきだと考えられます。しかし、固定回線の遅さ、遅延、CrUXにおけるiOSの不足などを考慮すると、この位置は理にかなっていると言えます。このような例（表面的にしか触れていませんが）では、各国のコンテキストを理解することがいかに難しいかがわかります。

### 接続タイプ別FCP

{{ figure_markup(
  image="performance-fcp-by-connection-type.png",
  caption="接続タイプ別に分割されたFCPのパフォーマンスを集計したもの。",
  description="棒グラフによると、4Gで良好なFCPを報告しているウェブサイトはわずか31％。オフラインでは、この数字は10％に減少し、その他の接続タイプでは、ほぼすべてのサイトでFCPが悪くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1949864731&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

他の指標と同様に、FCPは接続速度に影響されます。3Gでは、良いと評価している体験者は2％しかいませんが、4Gでは31％となっています。FCPのパフォーマンスは理想的な状態ではありませんが、[2019年から改善されている](../2019/performance#fcp-by-effective-connection-type)部分もあり、これもやはり良いと悪いのカテゴライズを変えたことが影響しているのかもしれません。良いウェブサイトと悪いウェブサイトの割合が同じように上昇し、中程度（「改善が必要」）のサイト体験の数を狭めていることがわかります。

この傾向は、デジタルデバイドの拡大を示しており、遅いネットワークや潜在的に性能の低いデバイスでの体験は一貫して悪化しています。低速回線でのFCPの改善は、TTFBの改善に直結します。これは、[接続タイプ別TTFBパフォーマンス集計表](#接続タイプ別のttfb)でも確認できます。

<a hreflang="en" href="https://ismyhostfastyet.com/">ホスティングプロバイダー</a>や<a hreflang="en" href="https://www.cdnperf.com/">CDN</a>の選択は、速度に連鎖的な影響を与えます。最速の配信に基づいてこれらの決定を行うことは、とくに低速のネットワークでは、FCPとTTFBの改善に役立ちます。FCPはフォントの読み込み時間にも大きく影響されるため、<a hreflang="en" href="https://web.dev/font-display/">Webフォントのダウンロード中にテキストが表示されるようにする</a>ことも価値のある戦略です（とくに、低速の接続ではこれらのリソースを取得するのにコストがかかる場合）。

「オフライン」の統計を見ると、かなりの数のFCP問題もネットワークの種類とは相関していないことが推測できます。このカテゴリーでは、その言葉が真実であれば得られるであろう、大きな利益は観察されません。レンダリングは、JavaScriptを取得することでそれほど遅延しないように見えますが、解析と実行に影響されます。

## Time to First Byte

Time to First Byte（TTFB）とは、最初のHTMLリクエストが行われてから、最初のバイトがブラウザに戻ってくるまでの時間のことです。リクエストが迅速に処理されないと、描画だけでなくリソースの取得も遅れるため、すぐに他のパフォーマンス指標にも影響がおよびます。

### デバイス別TTFB

{{ figure_markup(
  image="performance-ttfb-by-device.png",
  caption="デバイスタイプ別に分割されたTTFBのパフォーマンスを集計したもの。",
  description="バーチャートでは、デスクトップで76％、モバイルで83％のウェブサイトはTTFBが悪いことを示しています。TTFBが良好なウェブサイトは24%を超えていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1981576071&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

デスクトップで76％のウェブサイトはTTFBが「良くない」と回答しており、モバイルでは83％に上ります。このデータは、パフォーマンス測定や作業のほとんどが、アセットデリバリやサーバサイドの作業ではなく、フロントエンドやビジュアルレンダリングに集中していると仮定した場合、TTFBがいかに見過ごされがちな指標であるかを示していると言えるでしょう。TTFBが高いと、他の数多くのパフォーマンス信号に直接的な悪影響を及ぼすため、今後も対応が必要な分野です。

### 地域別のTTFB

{{ figure_markup(
  image="performance-ttfb-by-geo.png",
  caption="国別に分割されたTTFBのパフォーマンスを集計しています。",
  description="棒グラフによると、TTFBのパフォーマンスは一貫して低水準であり、TTFBの良好なウェブサイトが30％以上あるのは28カ国中4カ国のみである。また、改善が必要と判断されたWebサイトが非常に多く（常に40％以上）、順位が低いほど悪い体験の割合が高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1135415956&format=interactive",
  width="645",
  height="792",
  sheets_gid="1440255644",
  sql_file="web_vitals_by_country.sql"
  )
}}

今年のTTFBのジオリーディングを[2019年の結果](../2019/performance#ttfb-by-geo)と比較すると、やはり高速なウェブサイトが多いことを指摘していますが、FCPと同様に閾値が変更されています。以前は、200ms以下のTTFBは速く、1000ms以上は遅いと考えていました。2020年には、TTFBが500ms以下を「良い」、1500ms以上を「悪い」としています。このような分類の変更により、韓国では「良い」が36％増加し、台湾では22％増加するなど、大きな変化が見られました。全体的には、アジア太平洋地域や一部のヨーロッパ地域など、同じような地域が上位を占めています。

### 接続タイプ別のTTFB

{{ figure_markup(
  image="performance-ttfb-by-connection-type.png",
  caption="TTFBのパフォーマンスを接続タイプ別集計したものです。",
  description="棒グラフによると、TTFBは接続タイプが大きく影響し、4Gとオフラインではそれぞれ21%と22%しか良好な結果が得られませんでした。その他の接続タイプでは、良好なTTFBの測定値はほとんど見られませんでした（3Gでは1％の例外あり）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=810992122&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

TTFBは、ネットワークのレイテンシーと接続タイプの影響を受けます。遅延が大きいほど、また接続速度が遅いほど、TTFBの測定値は悪くなります（上図参照）。高速とされるモバイル接続（4G）でも、TTFBが高速なWebサイトはわずか21%です。4Gの速度以下で速いと分類されたサイトはほとんどありません。

2018年12月～2019年11月の<a hreflang="en" href="https://www.speedtest.net/insights/blog/content/images/2020/02/Ookla_Mobile-Speeds-Poster_2020.png">世界のモバイル通信速度</a>を見ると、世界的に見て、モバイル接続は高速ではないことがわかります。それらのネットワーク速度や携帯電話ネットワークの技術標準（5Gなど）は均等でなく、TTFBに影響を与えています。一例として、<a hreflang="en" href="https://www.mobilecoveragemaps.com/map_ng#7/8.744/7.670">ナイジェリアのネットワークの地図を見てみましょう</a>国のエリアのほとんどが2Gと3Gのカバー率で、4Gの範囲はほとんどありません。

驚くべきことは、オフラインと4Gの起源の間で、良好なTTFBの結果が比較的同じ数であることです。サービス・ワーカーがいれば、TTFB問題の一部が緩和されることを予想されますが、この傾向は上のグラフには反映されていません。

## パフォーマンス・オブザーバーの使い方

Webサイトやアプリケーションの評価に使用できるユーザー中心の評価基準は、何十種類もあります。しかし、事前に定義された評価基準は、私たちの特定のシナリオやニーズにまったく合わないことがあります。[PerformanceObserver API](https://developer.mozilla.org/docs/Web/API/PerformanceObserver)では、[User Timing API](https://developer.mozilla.org/docs/Web/API/User_Timing_API)、[Long Task API](https://developer.mozilla.org/docs/Web/API/Long_Tasks_API)、<a hreflang="ja" href="https://web.dev/i18n/ja/custom-metrics/#event-timing-api">Event Timing API</a>や<a hreflang="ja" href="https://web.dev/i18n/ja/custom-metrics/">その他のいくつかの低レベルAPI</a>で得られたカスタムメトリックデータを取得できます。たとえば、彼らの協力を得て、ページ間の遷移のタイミングを記録したり、SSR（Server-Side-rendered）アプリケーションの水和を数値化したりすることができました。

{{ figure_markup(
  image="performance-performance-observer-usage.png",
  caption="パフォーマンス デバイスタイプ別のObserverの使用状況。",
  description="Performance Observer APIの採用率が低く、デスクトップで6.6%、モバイルでは7%であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=632678090&format=interactive",
  sheets_gid="934401790",
  sql_file="performance_observer.sql"
  )
}}

上の図では、Performance Observerは、デバイスタイプに応じて追跡サイトの6～7%で使用されていることを示しています。これらのWebサイトは、低レベルAPIを活用してカスタムメトリクスを作成し、PerformanceObserver APIでそれらを照合して、他のパフォーマンスレポートツールで使用する可能性があります。このような採用率は、定義済みのメトリクスに傾倒する傾向を示しているかもしれませんが（たとえば、Lighthouseから来ている）、比較的ニッチなAPIとしては印象的でもあります。

## 結論

ユーザー体験は、スペクトルだけでなく、さまざまな要素に依存しています。劣悪で恵まれない体験を排除せずにパフォーマンスの状態を理解しようとするには、交差的にアプローチしなければなりません。ウェブサイトにアクセスするたび、ストーリーが浮かび上がってきます。個人や国レベルの社会経済的地位によって、購入できるデバイスやインターネットプロバイダーの種類が決まります。私たちが住んでいる場所の地理的条件は、遅延に影響を与え（オーストラリア人はいつもこの痛みを感じています）、経済状況は利用可能な携帯電話ネットワークの範囲を決定します。どんなウェブサイトを見るのか？何のために訪問するのか？コンテキストは、データを分析するだけでなく、すべての人にアクセス可能で高速な体験を提供するために必要な共感と配慮を得るためにも重要です。

新しいCore Web Vitalsのパフォーマンス指標について、表面的には楽観的なシグナルが出ています。Largest Contentful Paintの低速ネットワークでの一貫した劣悪な体験に絞らなければ、少なくとも半分はデスクトップとモバイルデバイスの両方で良好な体験となっています。新しい測定基準は、パフォーマンス問題への取り組みが進んでいることを示唆しているかもしれませんが、「最初の描画」と「最初のバイトまでの時間」に大きな改善が見られないことは憂慮すべきことです。ここでは、Largest Contentful Paintと同じネットワークタイプが、高速接続やデスクトップデバイスと同様にもっとも不利な条件となっています。パフォーマンススコアも、速度の低下を表しています（あるいは、過去に測定したものよりも正確に表現されているかもしれません）。

このデータからわかることは私たちの特権（中・高所得国、高給取り、新しく高性能なデバイス）の複数の側面のために、私たちが経験することのないシナリオ（接続速度の低下など）に対するパフォーマンスを改善するために、投資を続けなければならないということです。また、初期描画（LCPおよびFCP）やアセットデリバリー（TTFB）の高速化についても、まだまだ課題が、あることが明らかになりました。多くの場合、パフォーマンスは本質的にフロントエンドの問題のように感じられますが、バックエンドや適切なインフラの選択によって、多くの大幅な改善が可能です。繰り返しになりますが、ユーザー体験はさまざまな要素に左右されるため、総合的に判断する必要があります。

新しい測定基準は、ユーザー体験を分析するための新しいレンズをもたらしますが、既存のシグナルを忘れてはなりません。しかし、既存のシグナルを忘れてはなりません。もっとも改善が必要な分野で針を動かし、もっとも恵まれていない人々の体験にポジティブな変化をもたらすことに集中しましょう。高速でアクセス可能なインターネットは人間の権利です。
