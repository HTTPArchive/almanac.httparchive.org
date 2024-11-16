---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: パフォーマンス
description: 2021年版Web Almanacのパフォーマンス編では、Core Web Vitals（最大コンテンツの描画、累積レイアウトシフト、初回入力遅延）に加え、コンテンツの初回ペイントと最初のバイトまでの時間をカバーしています。
hero_alt: Hero image of Web Almanac characters images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [siakaramalegos]
reviewers: [rviscomi, kevinfarrugia, estelle, ziemek-bucko, jzyang, fili, tunetheweb, samarpanda, edmondwwchan]
analysts: [siakaramalegos, rviscomi, Nithanaroy]
editors: [jzyang]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/13xhPx6o2Nowz_3b3_5ojiF_mY3Lhs25auBKM6eqGZmo/
siakaramalegos_bio: Sia Karamalegosはウェブ開発者、国際会議のスピーカー、ライターです。Googleデベロッパー ウェブテクノロジーの専門家、Cloudinaryメディア開発者エキスパート、Stripeコミュニティエキスパートであり、Eleventy Meetupを共同開催しています。<a hreflang="en" href="https://sia.codes/">sia.codes</a> や<a hreflang="en" href="https://x.com/thegreengreek">Twitter</a> で、彼女の執筆、講演、ニュースレターをチェックしてください。
featured_quote: フレームワークレベルでパフォーマンスに関するスマートなデフォルトを設定できれば、より良いウェブを作ることができ、同時に開発者の仕事を楽にすることができます。
featured_stat_1: 37%
featured_stat_label_1: 上位1,000サイトのうちCore Web Vitalsを通過したサイトの割合
featured_stat_2: 79%
featured_stat_label_2: デスクトップで画像をLCP要素として表示したページ
featured_stat_3: 67 s
featured_stat_label_3: 最長の総ブロッキング時間
---

## 序章

ユーザー体験にとって、パフォーマンスは重要です。読み込みが遅く、反応が遅いWebサイトは、ユーザーをイライラさせ、コンバージョンの低下を招きます。<a hreflang="ja" href="https://web.dev/i18n/ja/vitals/">Core Web Vitals</a>が<a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">Google検索ランキング</a>に寄与するのは今年がはじめてです。そのため、ウェブサイトのパフォーマンス向上に対する関心が高まっており、ユーザーにとっては嬉しいニュースです。

*今年の報告書の主なポイントは何ですか？*まず、良いユーザー体験を提供するためには、まだ長い道のりが必要です。たとえば、ネットワークやデバイスの高速化は、JavaScriptの配信量を無視できるレベルにはまだ達していませんし、そこまで到達していないかもしれません。2つ目は、新機能を性能のために誤用し、結果的に性能が低下します。第三に、インタラクティブ性を測定するためのより良い測定基準が必要であり、それは現在進行中です。そして、4つ目は、CMSやフレームワークレベルのパフォーマンスへの取り組みが、上位1000万のウェブサイトのユーザー体験に大きな影響を与える可能性があることです。

*今年の新機能は？* 今回はじめて、トラフィックランキング別のパフォーマンスデータを公開します。また、過去の主要なパフォーマンス指標もすべて把握しています。最後に、また、過去の主要なパフォーマンス指標もすべて把握しています。最後に、最大コンテンツの描画（LCP）要素について、より深く掘り下げた内容を追加しました。（LCP）要素について、より深く掘り下げた内容を追加しました。

### 方法論に関する注記

パフォーマンスの章が他の章と異なる点は、分析に <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chromeユーザー体験レポート</a> (CrUX) へ大きく依存していることです。なぜか？私たちの最優先事項がユーザー体験であるならば、パフォーマンスを測定する最良の方法は、リアルユーザーデータ（リアルユーザーメトリクス、略してRUM）です。

<figure>
<blockquote>Chromeユーザー体験レポートは、実際のChromeユーザーがウェブ上の人気スポットをどのように体験しているかについてのユーザー体験メトリクスを提供します。</blockquote>
<figcaption>— <cite><a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chromeユーザー体験レポート</a></cite></figcaption>
</figure>

CrUXのデータは、ハイレベルなフィールド/RUMの指標のみを提供し、Chromeブラウザーのみを対象としています。また、CrUXは、ページ単位ではなく、オリジン（ウェブサイト）単位でデータを報告します。

CrUX RUMのデータをHTTP ArchiveのWebPageTestのラボデータで補完しています。WebPageTestには、Lighthouseのフルレポートを含む、各ページに関する非常に詳細な情報が含まれています。WebPageTestは、[全米のロケーション](./methodology#webpagetest)でパフォーマンスを測定していることに注意してください。CrUXのパフォーマンスデータは、実際のユーザーのページロードを表しているので、グローバルなものです。

パフォーマンスを前年比で比較する場合、以下の点に留意してください。

- 2020年から<a hreflang="en" href="https://web.dev/articles/cls-web-tooling">累積レイアウトシフト（CLS）</a>の計算が変更されました。
- 2020年から<a hreflang="en" href="https://web.dev/articles/cls-web-tooling#additional-updates">コンテンツの初回ペイント（FCP）の基準値（「良い」、「改善が必要」、「悪い」）が変更</a>されました。
- 昨年は2020年8月のデータをもとに、今年は2021年7月の実行をもとに報告しました。

詳しくはWeb Almanacの[方法論](./methodology)をお読みください。

## ハイレベルなパフォーマンス：Core Web Vitals

個々の指標へ飛び込む前に、<a hreflang="ja" href="https://web.dev/i18n/ja/vitals/">Core Web Vitals</a> (CWV) の複合パフォーマンスについて見てみましょう。Core Web Vitals（LCP、CLS、FID）は、ユーザー体験に焦点を当てたパフォーマンスメトリクスの集合体です。読み込み、インタラクティブ性、視覚的な安定性に重点を置いています。

ウェブパフォーマンスは、アルファベットの羅列で有名ですが、このフレームワークでコミュニティがまとまりつつあります。

ここでは、CWVの3つの指標すべてで「良好」の閾値に達したWebサイトへ焦点を当て、Webがどのように高いレベルで機能しているかを理解します。指標別分析では、各指標による同じチャートを詳しく説明し、さらにCWVにはない指標も取り上げます。

### デバイス別

{{ figure_markup(
  image="performance-1-good-cwv-by-device.png",
  caption="2020年から2021年にかけてデバイス別の優れたCore Web Vitals",
  description="2020年と2021年のコアウェブバイタルが良好な起点の割合を示す棒グラフ。2020年では、デスクトップWebサイトの34％が良好で、モバイルWebサイトの24％が良好でした。2021年には、デスクトップWebサイトの41％が良好で、モバイルの29％が良好であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=116267418&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

<p class="note"><strong>備考:</strong>昨年からCLSの計算方法が変更になったため、この数値は単純比較ではありません。</p>

Chromeユーザー体験レポートに掲載されたウェブサイトのコアウェブバイタルは、前年比で改善されました。しかし、この改善のかなりの部分は、必ずしもCLSの性能向上ではなく、CLSの計算方法の変更によるものです。その結果、CLSの「改善」はデスクトップで8ポイント（モバイルは2ポイント）となった。LCPはデスクトップで7ポイント改善（モバイルは2ポイント改善）。FIDは、デスクトップでは両年ともすでに100％で、モバイルでは10ポイント改善した。

例年通り、モバイル端末よりもデスクトップマシンの方が、パフォーマンスが高いという結果になりました。このため、実際のモバイル端末でサイトのパフォーマンスをテストし、実際のユーザー指標（つまり、フィールドデータ）を測定することが非常に重要です。開発者向けツールでモバイルをエミュレートすることは、研究室（＝開発）では便利ですが、実際のユーザー体験を代表するものではありません。

### 有効な接続タイプ別

CrUXの接続タイプ別データはわかりにくいかもしれません。トラフィックに基づくものではありません。ある接続タイプでWebサイトに何らかの経験があれば、その接続タイプの分母が増加します。もし、その接続タイプでそのウェブサイトにとって良い経験があれば、それは分子を増加させます。別の言い方をすれば、4Gの速度でページロードを経験したすべてのWebサイトのうち、36%はCWVが良好であったということです。

{{ figure_markup(
  image="performance-2-good-cwv-by-ect.png",
  caption="効果的な接続タイプによる良好なCWV性能",
  description="Core Web Vitalsが良好な接続タイプにおける起点の割合を示す棒グラフ。オフラインのカテゴリーでは、CWVが良好なウェブサイトは44％、低速の2Gと2Gは0％、3Gは5％、4Gは36％であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=150765595&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

接続の高速化は、Core Web Vitalsのパフォーマンス向上と相関しています。オフラインのパフォーマンスが向上したのは、おそらくプログレッシブ ウェブ アプリのサービス ワーカー キャッシングが原因です。ただし、オフラインの有効な接続タイプのカテゴリのオリジン数は、合計2,634(0.02%) とごくわずかです。

3G以下の通信速度は、大幅な性能劣化と相関が、あることがトップの収穫です。低速の接続速度でのアクセス用に、簡略化したエクスペリエンスを提供することを検討してください (たとえば、<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/save-data/">データセーバーモード</a>)。ユーザーの代表的なデバイスと接続を使用して、サイトのプロファイルを作成します（アナリティクスデータに基づく）。

{{ figure_markup(
  image="performance-3-change-in-ect.png",
  caption="2020-2021年有効接続タイプの変更",
  description="2020年と2021年の各接続タイプ内の総オリジン数の割合を示す棒グラフ。オフラインのカテゴリはオリジンの0％から0％（2020年→2021年）、低速2Gと2Gは1％から0％、3Gは27％から25％、4Gは72％から75％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=658987455&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

先ほど、LCPとFIDの改善について、前年比で改善したと申し上げました。これらは、モバイル機器やモバイルネットワークの高速化が一因と思われます。上図では、3Gでの総アクセス元が2パーセントポイント減少し、4Gでのアクセス元が3パーセントポイント増加しています。オリジンの割合は、必ずしもトラフィックと相関があるわけではありません。しかし、人々がより高速な接続を利用できるようになれば、その接続タイプからアクセスされるオリジンもより多くなると推測されます。

接続タイプ別のパフォーマンスは、オリジンだけでなく、トラフィック別にトラッキングを開始できれば、より分かりやすくなると思います。 また、高速通信時のデータも見られるといいですね。ただし、[APIは現在、4G以上のものを4Gとしてグループ化するよう制限されています](https://developer.mozilla.org/docs/Glossary/Effective_connection_type)。

### 地域別

{{ figure_markup(
  image="performance-4-top-cwv-country.png",
  caption="CWVの性能が良い地域トップ30",
  description="CWVの良好な国内の原産地の割合を示す棒グラフ。韓国56%、日本50%、チェコ48%、ドイツ47%、オランダ45%、台湾45%、ベルギー45%、カナダ43%、イギリス42%、ポーランド42%、アメリカ40%、ルーマニア38%。フランス38%、ウクライナ37%、ロシア35%、トルコ34%、スペイン34%、イタリア33%、オーストラリア28%、ベトナム28%、タイ27%、マレーシア27%、インドネシア20%、メキシコ19%、チリ19%、ブラジル17%、フィリピン17%、インド16%、コロンビア15%、アルゼンチン14%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=162241310&format=interactive",
  width=645,
  height=792,
  sheets_gid="2016679282",
  sql_file="web_vitals_by_country.sql"
  )
}}

アジアやヨーロッパの一部の地域は、引き続き高いパフォーマンスを示しています。これは、ネットワークの速度が速いこと、より高速なデバイスを持つ裕福な人口が多いこと、エッジキャッシュの位置が、近いことが原因であると考えられます。多くの結論を出す前に、このデータセットをもっと理解する必要があります。

CrUXのデータはChromeのみ収集されています。国別のオリジン比率は、相対的な人口規模とは一致しません。理由としては、ブラウザのシェア、アプリ内ブラウジング、デバイスのシェア、アクセスレベル、使用レベルの違いなどが考えられます。すべてのCrUX分析において、地域レベルの差異とその背景を評価する際には、これらの注意事項に留意してください。

### 順位別

今年はじめて、ランキングデータを掲載しました！CrUXでは、Chromeで計測した1サイトあたりのページビュー数でランキングを決定しています。チャートでは、カテゴリーは加算式になっています。上位10,000サイトには上位1,000サイトが含まれる、といった具合です。詳しくは[方法論](./methodology#chrome-ux-report)をご覧ください。

{{ figure_markup(
  image="performance-7-cwv-by-rank.png",
  caption="CWVのランク別良パフォーマンス",
  description="各ランキンググループにおいて、CWVが良好なWebサイトの割合を示す棒グラフ。上位1,000サイトの37%、上位10,000サイトの31%、上位10万サイトの29%、上位100万サイトの30%、CrUXでは全オリジンの32%が良好なCWVを有していました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=444585880&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

Core Web Vitalsでは、上位1,000サイトが他を大きく引き離している。グラフの真ん中には、CLSに起因するパフォーマンスの低下という興味深い谷が発生しています。FIDはすべてのグループ化で横ばいでした。他のすべての指標は、上位のランキングほど高いパフォーマンスを示すという相関関係にあります。

相関関係は因果関係ではありません。しかし、数え切れないほどの企業がパフォーマンスの向上を示し、最終的なビジネスインパクトにつながっています（<a hreflang="en" href="https://wpostats.com/">WPO stats</a>）。トラフィックの増加やエンゲージメントの増加を達成できない理由が、パフォーマンスであってはならないのです。

## 指標別分析

このセクションでは、各指標について掘り下げて説明します。あまり詳しくない方のために、各指標を詳しく説明した記事へのリンクも用意しています。

### 最初のバイトまでの時間（TTFB）

<a hreflang="en" href="https://web.dev/articles/ttfb">最初のバイトまでの時間</a> (TTFB) は、ブラウザがページを要求してから、サーバーから最初のバイトの情報を受け取るまでの時間です。ウェブサイトのロードに関する連鎖の最初の指標となるものです。TTFBが悪いと、連鎖的にFCPやLCPに影響を与えることになります。それが、私たちが最初にこの指標について話す理由です。

{{ figure_markup(
  image="performance-TTFB-by-device.png",
  caption="デバイス別TTFB性能",
  description="デスクトップとモバイルデバイスのTTFBパフォーマンスを示す積み上げ棒グラフ。デスクトップ・デバイスでは26%のWebサイトが良好（0.5秒未満）、55%が改善を必要とし、19%が不良（1.5秒以上）、であることがわかりました。モバイルでは、15%が良好、59%が要改善、26%が不良でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=594735556&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

TTFBはモバイルよりもデスクトップの方が高速であり、これはネットワーク速度が速いためと思われる。[昨年](../2020/performance#fig-17_)と比較すると、TTFBはデスクトップでわずかに改善し、モバイルで遅くなった。

{{ figure_markup(
  image="performance-TTFB-by-ect.png",
  caption="接続タイプ別のTTFBパフォーマンス",
  description="効果的な接続タイプでのTTFBパフォーマンスを示す積み上げ棒グラフ。オフラインのWebサイトでは、43%が「良好」、39%が「要改善」、18%が「劣悪」なパフォーマンスでした。低速の2Gでは、1% が「良好」、2% が「要改善」、98% が「不良」でした。2Gの場合、「良い」が0%、「改善必要」2%、「悪い」97%。3Gでは、1%が「良好」、27%が「要改善」、72%が「不良」でした。4Gでは、「良い」が19%、「改善必要」58%、「悪い」23%であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1059484029&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

TTFBはまだまだこれからです。当社のウェブサイトの75％は4G回線グループ、25％は3G回線グループで、残りのものはごくわずかでした。4Gの実効速度では、19%のオリジンだけが「良好」なパフォーマンスでした。

オフライン接続でどうしてTTFBが発生するのか、疑問に思われるかもしれません。おそらく、TTFBデータを記録し送信するオフラインのサイトのほとんどは、[サービスワーカーキャッシング](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Offline_Service_workers)を使用していると思われます。TTFBは、そのレスポンスがCache Storage APIやHTTP Cacheからのものであっても、ページのレスポンスの最初の1バイトを受信するまでの時間を測定します。実際のサーバーが関与している必要はない。レスポンスにサービスワーカーからのアクションが必要な場合、サービスワーカー・スレッドの起動とレスポンスの処理にかかる時間も、TTFBの一因になり得ます。しかし、サービスワーカーの起動時間を考慮しても、これらのサイトは平均して、他の接続カテゴリよりも速く最初のバイトを受信します。

{{ figure_markup(
  image="performance-TTFB-by-rank.png",
  caption="TTFBのランク別パフォーマンス",
  description="各ランキンググループのTTFBパフォーマンスを示す積み上げ棒グラフ。上位1,000サイトでは、32%が「良い」、63%が「改善必要」、5%が「悪い」となっています。上位10,000サイトでは、27%が「良い」、66%が「要改善」、7%が「悪い」でした。上位10万サイトでは、22%が「良い」、65%が「改善必要」、13%が「悪い」でした。100万人規模では、「良い」が18％、「改善必要」が62％、「悪い」が20％。全体では、「良い」18％、「改善が必要」58％、「悪い」24％であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=829561432&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

ランクについては、高ランクのサイトほどTTFBが速かった。その理由のひとつは、これらの多くは、パフォーマンスを優先するためのより多くのリソースを持つ大企業であることでしょう。これらの企業は、サーバーサイドのパフォーマンスの向上や、エッジCDNを通じたアセット配信に注力している可能性があります。もうひとつの理由は、選択バイアスです。上位のオリジンは、サーバーが近い地域、つまり低遅延の地域でより多くアクセスされる可能性があります。

もう1つ可能性があるとすれば、CMSの導入が関係している。[CMS編](./cms)では、ランク別のCMS導入状況を示しています。

{{ figure_markup(
  image="cms-adoption-by-rank.png",
  caption="ランク別CMS採用状況",
  description="ランキングのカテゴリーごとに、CMSを利用しているウェブサイトの割合を棒グラフで示したもの。モバイルでは、1,000位以内が7%、10,000位以内15%、10万位以内20%、100万位以内29%、全サイトでは42%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=409766380&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1gAJh4VcSEU6-6aQxBiTFl-7cbyHukfdhg-Iaq9y5pnc/#gid=158167539",
  sql_file="../cms/cms_adoption_by_rank.sql"
  )
}}

「すべて」のグループでは42%のページ（モバイル）がCMSを使用しているのに対し、上位1,000サイトでは7%の導入にとどまっています。

次に、上位5つのCMSを順位別に見ると、WordPressが「全ページ」の33.6%を占め、もっとも導入が進んでいることがわかります。

{{ figure_markup(
  image="top-cmss-by-rank.png",
  caption="CMSのランキングトップ5",
  description="各ランキングカテゴリーにおける上位CMSのシェア率を棒グラフで示したもの。WordPressは、上位1,000位で3.1%、1万位では8.6%、10万位で13.2%、100万位では21.1%、そして全サイトの33.6%を占めています。残りのCMSは全ランキングに占める割合が3%未満でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzYkQYaBTpD5FKloDXsdb32Y2pjdxFZq_LoekECgTy53F-dRATm9wFFJ3dDVDS8_cGn0h2mKDBjgdM/pubchart?oid=1745757207&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1gAJh4VcSEU6-6aQxBiTFl-7cbyHukfdhg-Iaq9y5pnc/#gid=670045665",
  sql_file="../cms/top_cms_by_rank.sql"
  )
}}

最後に、<a hreflang="en" href="https://datastudio.google.com/s/o6zLzlTpWaI">Core Web Vitalsテクノロジーレポート</a> を見ると、各CMSが指標別にどのようなパフォーマンスを見せてくれるかがわかります。

{{ figure_markup(
  link="https://datastudio.google.com/s/o6zLzlTpWaI",
  image="cms_ttfb_cwv_report.png",
  caption='CMSによる良いTTFBを持つオリジン (<a hreflang="en" href="https://datastudio.google.com/s/o6zLzlTpWaI">Core Web Vitalsテクノロジーレポート</a>)',
  description="WordPress、Wix、Squarespaceの「良いTTFBを持つオリジン」の時系列チャート。7月は、WordPressとWixが5％、Squarespaceが20％でした。"
  )
}}

2021年7月に良好なTTFBを経験したWordPressのオリジンはわずか5％でした。上位1000万サイトにおけるWordPressの大きなシェアを考慮すると、そのTTFBの悪さがランクによるTTFBの劣化の一因である可能性があります。

### コンテンツの初回ペイント (FCP)

<a hreflang="ja" href="https://web.dev/i18n/ja/fcp/">コンテンツの初回ペイント (FCP)</a> は、読み込みが最初に開始されてから、ブラウザがページのコンテンツ部分（テキスト、画像など）を最初にレンダリングするまでの時間を測定するものです。

{{ figure_markup(
  image="performance-FCP-by-device.png",
  caption="デバイス別のFCPパフォーマンス",
  description="デスクトップとモバイルデバイスのFCPパフォーマンスを示す積み上げ棒グラフ。デスクトップ・デバイスでは、60%のWebサイトが良好（1.8秒未満）、27%が改善を必要とし、13%が不良（3.0秒以上）のFCPパフォーマンスを示しています。モバイルでは、38%が良好、38%が要改善、24%が不良でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1509111466&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

モバイルよりもデスクトップの方が、FCPが速いのは平均ネットワーク速度が速いことと、プロセッサが速いことの両方が原因だと思われます。モバイルでのFCPが良好だったのは、38%のオリジンだけでした。同期JavaScriptのようなレンダリングをブロックするリソースは、一般的な原因である可能性があります。TTFBはFCPの最初の部分なので、TTFBが悪いと、良好なFCPを達成するのが難しくなります。

<p class="note"><strong>注：</strong>昨年からFCPの閾値が変更されています。今年のデータを昨年のデータと比較しようとする場合は、注意が必要です。</p>

{{ figure_markup(
  image="performance-FCP-by-ect.png",
  caption="接続タイプ別のFCPパフォーマンス",
  description="効果的な接続タイプでのFCPパフォーマンスを示す積み上げ棒グラフ。オフラインのWebサイトでは、38%が「良い」、26%が「改善必要」、36%は「パフォーマンスが悪い」と回答しています。低速2Gの場合、100%が「悪い」。2Gの場合、1％が「改善必要」、99％が「悪い」。3Gでは、4%が「良好」、21%が「要改善」、75%が「不良」。4Gでは、46%が「良好」、35%が「要改善」、19%が「不良」でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=679577784&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

3G以下のスピードのオリジンでは、FCPで著しい劣化が発生しました。繰り返しになりますが、分析によるユーザーデータを反映した実際のデバイスとネットワークを使用して、ウェブサイトのプロファイリングを行っていることを確認してください。光ファイバー接続のハイエンドデスクトップでプロファイリングしている場合、JavaScriptのバンドルは重要でないように見えるかもしれません。

オフライン接続は、4Gに近い性能でしたが、それほど良いものではありませんでした。サービスワーカーの起動時間や複数のキャッシュの読み込みが影響している可能性があります。FCPでは、TTFBよりも多くの要因が絡んできます。

{{ figure_markup(
  image="performance-FCP-by-rank.png",
  caption="FCPのランク別パフォーマンス",
  description="各ランキンググループのFCPパフォーマンスを示す積み上げ棒グラフ。上位1,000サイトでは、67%が「良い」、28%が「改善必要」。上位10,000サイトでは、62%が「良い」、31%が「要改善」、7%が「悪い」でした。上位10万サイトでは、54%が「良い」、35%が「改善必要」、12%が「悪い」でした。上位100万人では、「良い」が49％、「改善必要」が35％、「悪い」が16％。全体では、「良い」45％、「改善が必要」35％、「悪い」20％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=965739974&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

TTFBと同様、FCPも上位にランクインして改善されました。また、TTFBと同様に、<a hreflang="en" href="https://datastudio.google.com/s/kZ9K0d-sBQw">WordPressのオリジンの19.5% のみが、FCPの良いパフォーマンスを経験しました</a>。TTFBの性能が低いのだから、FCPも遅いのは当然です。TTFBが遅いと、FCPやLCPで良いスコアを出すのは難しいのです。

FCPがうまくいかない原因としては、レンダリングをブロックするリソース、サーバーの応答時間（TTFBの遅さに関連するもの）、大きなネットワークペイロード、などが挙げられます。

### 最大コンテンツの描画 (LCP)

<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">最大コンテンツの描画（LCP）</a> は、ロード開始からブラウザがビューポートで最大の画像またはテキストを表示するまでの時間を測定します。

{{ figure_markup(
  image="performance-LCP-by-device.png",
  caption="LCPのデバイス別性能",
  description="デスクトップとモバイルのLCPパフォーマンスを示す棒グラフを積み重ねたもの。デスクトップ・デバイスでは、60%のWebサイトが良好（2.5秒未満）、27%が改善を必要とし、12%は不良（>= 4秒）であることがわかりました。モバイルでは、45%が「良い」、35%が「改善必要」、19%が「悪い」と回答しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=556816803&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

LCPはモバイルよりデスクトップの方が速かった。TTFBはFCPのようにLCPに影響を与える。 デバイス、接続形態、ランクによる比較は、すべてFCPの傾向を反映しています。レンダーブロックリソース、総重量、ロードストラテジーはすべてLCPのパフォーマンスに影響を与えます。

{{ figure_markup(
  image="performance-LCP-by-ect.png",
  caption="接続タイプ別のLCPパフォーマンス",
  description="効果的な接続タイプでのLCPパフォーマンスを示す積み上げ棒グラフ。オフラインのWebサイトでは、49%が良好、17%が要改善、34%が劣悪なパフォーマンスでした。低速の2Gでは、1%が要改善、99%が不良でした。2Gでは、4%が改善必要で、96%が不良でした。3Gでは、8%が良好、28%が要改善、65%が不良でした。4Gでは、51%が良好、33%が要改善、16%が不良でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=583947675&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

LCPが良好なオフラインの起点は、4Gの体験とより密接に一致していますが、LCPが悪い体験はオフラインの方が高いのです。LCPはFCPの後に発生し、0.7秒の追加予算があるため、FCPよりもオフラインのウェブサイトの方が良いLCPを達成した可能性があります。

{{ figure_markup(
  image="performance-LCP-by-rank.png",
  caption="LCPのランク別パフォーマンス",
  description="各ランキンググループのLCPパフォーマンスを示す積み上げ棒グラフ。上位1,000サイトでは、64%が「良い」、25%が「改善必要」、11%が「悪い」と回答しています。上位10,000サイトでは、59%が「良い」、30%が「改善必要」、11%が「悪い」でした。上位10万サイトでは、55%が「良い」、32%が「改善必要」、13%が「悪い」でした。100万人規模では、「良い」が53％、「改善必要」が33％、「悪い」が14％。全体では、「良い」50％、「改善が必要」33％、「悪い」17％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1080361066&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

LCPについては、FCPよりも順位によるパフォーマンスの差が接近している。また、上位1,000位までのオリジンではLCPが、悪い割合が高くなっています。WordPressでは、<a hreflang="en" href="https://datastudio.google.com/s/kvq1oJ60jaQ">28%のオリジンが良好なLCPを経験</a>しています。LCPの悪化は通常、一握りの問題によって引き起こされるため、これはユーザーエクスペリエンスを向上させるチャンスです。

#### LCPの要素

LCPの要素をより深く掘り下げてみましょう。

{{ figure_markup(
  image="performance-top-15-lcp-nodes.png",
  caption="LCP HTML要素ノード上位15個",
  description="LCPエレメントのノードタイプごとのページ占有率を示す棒グラフです。`IMG`は47%と42%。`DIV`は28%、27%。`P`6%、10%。`H1`3%、5%。`SECTION`3%、2%。未検出2%、2%。`H2`2%、2%。`A`1%、2%。`SPAN`1%、1%。`HEADER`1%、1%。`LI`1%、1%。`RS-SBG`1%、1%。`H3`0%、1%。`TD`1%、1%。`VIDEO`が0%、0%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1549429021&format=interactive",
  width=600,
  height=909,
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

IMG、DIV、P、H1がLCPノード全体の83％を占めた（モバイルの場合）。背景画像はCSSで適用できるため、コンテンツが画像なのかテキストなのかは、これだけではわかりません。

{{ figure_markup(
  image="performance-lcp-with-image.png",
  caption="デバイス別画像付きLCP素子",
  description="デスクトップページの79％が画像を含むLCP要素を持ち、モバイルページの71％が持つことを示す棒グラフ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=992354142&format=interactive",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

HTMLノードに関係なく、71-79%のページでLCP要素が、画像であったことがわかります。さらに、デスクトップ端末ではLCPが、画像である割合が高くなっています。これは、画面サイズが小さいため、画像がビューポートからはみ出し、見出しテキストがもっとも大きな要素になることが、原因である可能性があります。

いずれの場合も、LCP要素の大半を画像が占めています。このため、画像の読み込み方法について、より深く掘り下げる必要があります。

{{ figure_markup(
  image="performance-lcp-antipatterns.png",
  caption="アンチパターンの可能性があるLCP要素",
  description="棒グラフは、モバイルのページの9.3%がLCP要素のネイティブレイジーロードを使用し、16.5%がおそらくレイジーロード、0.4%が非同期デコードを使用していることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=130632749&format=interactive",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

ユーザー体験の観点から、LCPの要素はできるだけ速くロードされることが望まれます。LCPがCore Web Vitalの1つに選ばれた理由は、ユーザー体験です。レンダリングがさらに遅くなるため、遅延ロードさせないようにします。しかし、9.3%のページがLCPの `<img>` 要素にネイティブのloading=lazyフラグを使用していることがわかります。

すべてのブラウザがネイティブの遅延ローディングに対応しているわけではありません。一般的な遅延ロードのポリフィルは、画像要素に「lazyload」クラスがあると検出します。このように、"lazyload "クラスを持つ画像を集計に加えることで、より遅延ロードの可能性が高い画像を特定できます。LCPの`<img>`要素を遅延ロードしていると思われるサイトの割合は、モバイルでは16.5%に跳ね上がります。

LCP要素を遅延ローディングすると、パフォーマンスが低下します。 *やめてくれ！* WordPressはネイティブの遅延ローディングを早くから採用しています。初期の方法は、すべての画像に遅延ロードを適用する素朴なソリューションで、結果は <a hreflang="en" href="https://web.dev/articles/lcp-lazy-loading"> 負の性能相関</a>を示しました。このデータをもとに、より良いパフォーマンスを発揮するために、よりニュアンスの異なるアプローチを実施することができたのです。

画像の<a hreflang="en" href="https://developer.mozilla.org/docs/Web/HTML/Element/img#attr-decoding">`decode`属性</a>は、比較的新しいものです。`async`に設定することで、読み込みやスクロールのパフォーマンスを向上させることができます。現在、0.4%のサイトがLCP画像に非同期デコード指令を使用しています。非同期デコードがLCP画像に与える悪影響は、現在のところ不明です。したがって、LCPイメージに `decode="async"` を設定する場合は、設定前と設定後にサイトをテストしてください。

{{ figure_markup(
  content="354",
  caption="画像やiframeでないLCP要素にネイティブ遅延ローディングを使おうとしたウェブサイト",
  classes="big-number",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

興味深いことに、デスクトップの354のオリジンは、loading属性をサポートしないHTML要素（例：`<div>`）に対してネイティブの遅延ロードを使用しようとしました。loading属性は `<img>` と、一部のブラウザでは `<iframe>` 要素にのみ対応しています（<a hreflang="en" href="https://caniuse.com/loading-lazy-attr">Can I use</a> を参照してください）。

### 累積レイアウトシフト (CLS)

{{ figure_markup(
  image="performance-CLS-by-device.png",
  caption="デバイス別CLS性能",
  description="デスクトップとモバイルのCLSパフォーマンスを示す積み上げ棒グラフ。デスクトップ・デバイスでは、62%のウェブサイトが良好（< 0.1）、23%が改善を必要とし、15%は不良（>= 0.25）であることがわかりました。モバイルでは、62%が「良い」、21%が「改善必要」、17%が「悪い」と回答しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=160840238&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">累積レイアウトシフト (CLS)</a> は、FCPやLCPなどの視覚的な表示にかかる時間ではなく、ユーザーがどの程度のレイアウト シフトを経験するかによって特徴付けられます。このように、デバイスごとの性能はほぼ同等でした。

{{ figure_markup(
  image="performance-CLS-by-ect.png",
  caption="接続タイプ別のCLSパフォーマンス",
  description="効果的な接続タイプでのCLSのパフォーマンスを示す積み上げ棒グラフ。オフラインのWebサイトでは、87%が「良い」、4%が「悪い」と回答しています。低速の2Gおよび2Gでは、53～52%が良好、15%が要改善、32～33%が劣悪でした。3Gでは、58%が「良い」、16%が「改善必要」、26%が「悪い」。4Gでは、69%が「良い」、13%が「改善必要」、18%が「悪い」でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1650043738&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

4Gから3G以下への性能劣化は、FCPやLCPほど顕著ではありませんでした。多少の劣化はあるが、端末データには反映されず、接続タイプのみに反映されます。

オフラインのウェブサイトは、すべての接続タイプの中でもっとも高いCLSパフォーマンスを示しました。サービスワーカーキャッシングを使用しているサイトでは、レイアウトシフトの原因となる画像や広告などの一部のアセットでキャッシュされない場合があります。そのため、これらのアセットは読み込まれず、レイアウトシフトを引き起こすことはありません。このようなサイトのフォールバックHTMLは、オンラインウェブサイトのより基本的なバージョンになることがよくあります。

{{ figure_markup(
  image="performance-CLS-by-rank.png",
  caption="CLSのランク別パフォーマンス",
  description="各ランキンググループのCLSのパフォーマンスを示す積み上げ棒グラフ。上位1,000サイトでは、53%が「良い」、25%が「改善必要」、21%が「悪い」でした。上位10,000サイトでは、46%が「良い」、27%が「改善必要」、27%が「悪い」でした。上位10万サイトでは、48%が「良い」、26%が「改善必要」、26%が「悪い」でした。100万人規模では、「良い」54％、「改善が必要」25％、「悪い」21％。全体では、61%が「良い」、23%が「改善必要」、16%が「悪い」。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1468770181&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

ランキングについては、CLSのパフォーマンスは、上位10,000サイトで興味深い谷を示しました。また、1M以上のランキンググループは、1M未満のランキングサイトよりもパフォーマンスが低下しています。「all」グループは、他のすべてのランク付けされたグループよりもパフォーマンスが良かったので、1M以下のグループのパフォーマンスが向上しています。<a hreflang="en" href="https://datastudio.google.com/s/qG00yMxSa3o">WordPressを使ったオリジンの60%が良いCLSを経験した</a>ことから、WordPressが再びこれに関与していると思われます。

CLSが悪くなる原因としては画像のスペースが確保されていない、ウェブフォントを読み込むと文字がずれる、最初に描いた後トップバナーが挿入される。またアニメーションが合成されていない、iframeがある、などが挙げられます。

### 初回入力遅延 (FID)

<a hreflang="ja" href="https://web.dev/i18n/ja/fid/">初回入力遅延 (FID)</a> は、ユーザーが最初にページと対話してから、その対話に応答してブラウザがイベントハンドラーの処理を開始するまでの時間を測ります。

{{ figure_markup(
  image="performance-FID-by-device.png",
  caption="デバイス別のFID性能",
  description="デスクトップとモバイルのFID性能を示す棒グラフを積み重ねたもの。デスクトップでは、100%のWebサイトが良好（100ms未満）でした。モバイルでは、90%が「良い」、10%が「改善必要」、0%が「悪い」（>= 300ms）でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=230841623&format=interactive",
  sheets_gid="2140629699",
  sql_file="web_vitals_by_device.sql"
  )
}}

FIDのパフォーマンスは、モバイル端末よりもデスクトップ端末の方が優れており、これは、より大量のJavaScriptを処理できる端末のスピードが速いためと思われます。

{{ figure_markup(
  image="performance-FID-by-ect.png",
  caption="接続タイプ別のFID性能",
  description="効果的な接続タイプでのFIDパフォーマンスを示す積み上げ棒グラフ。オフラインのWebサイトでは、78%が良好、17%が要改善、5%が劣悪なパフォーマンスでした。低速の2Gおよび2Gの場合、81～82%が良好、18%が要改善、0～1%が不良でした。3Gでは、90%が良好、10%が要改善でした。4Gでは、93%が良好、7%が要改善、0%が不良でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1135701788&format=interactive",
  sheets_gid="1361919728",
  sql_file="web_vitals_by_eff_connection_type.sql"
  )
}}

FIDの性能は、接続の種類によって多少劣化しますが、他の指標に比べるとそれほどではありません。スコアの分布が大きいため、結果のばらつきが少なくなっているようです。

他の指標とは異なり、オフラインのウェブサイトでは、他の接続カテゴリーよりもFIDが悪化していました。これは、サービスワーカーを持つ多くのウェブサイトがより複雑な性質を持つためと思われます。サービスワーカーがあっても、メインスレッドで実行されるクライアントサイドのJavaScriptの影響がなくなるわけではありません。

{{ figure_markup(
  image="performance-FID-by-rank.png",
  caption="FIDのランク別パフォーマンス",
  description="FIDのパフォーマンスをランキンググループごとに積み上げ棒グラフで表示。すべてのカテゴリーで、93～94%が「良い」、5～7%が「改善必要」、「悪い」は0%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=1539782601&format=interactive",
  sheets_gid="1988323604",
  sql_file="web_vitals_by_rank.sql"
  )
}}

FIDのランク別実績は横ばい。

すべてのFID指標において、「良好」のカテゴリーに非常に大きなバーが表示されますが、これは本当にピーク性能に達していない限り、あまり効果がないことを示しています。良いニュースは、<a hreflang="en" href="https://web.dev/better-responsiveness-metric/">Chromeチームが現在これを評価しており</a>、あなたのフィードバックを求めていることです。

もし、あなたのサイトのパフォーマンスが「良い」の範疇にないのであれば、間違いなくパフォーマンスに問題があります。FID問題の一般的な原因は、長時間実行されるJavaScriptが多すぎることです。バンドルサイズを小さくし、サードパーティのスクリプトに注意を払いましょう。

### 合計ブロッキング時間 (TBT)

<figure>
<blockquote>合計ブロッキング時間 (TBT) メトリクスは、コンテンツの初回ペイント (FCP) と ユーザー操作可能になるまでの時間 (TTI) の間で、メインスレッドが入力反応を妨げるほど長くブロックされた時間の総計を測定します。</blockquote>
<figcaption>— <cite><a hreflang="ja" href="https://web.dev/i18n/ja/tbt/">Web.dev</a></cite></figcaption>
</figure>

<a hreflang="ja" href="https://web.dev/i18n/ja/tbt/">合計ブロッキング時間 (TBT)</a> は、潜在的な双方向性の問題をデバッグするのに役立つラボ ベースのメトリックです。FIDはフィールドベースの指標であり、TBTはラボベースの類似指標である。現在、私はクライアントのWebサイトを評価する際、JavaScriptによるパフォーマンスの問題の可能性を示す別の指標として、総ブロック時間TBTに着目しています。

残念ながら、TBTはChromeユーザー体験レポートでは計測されていません。しかし、HTTP Archive Lighthouseのデータ（モバイルのみ収集）を使用すれば、状況を把握することは可能です。

{{ figure_markup(
  image="performance-tbt.png",
  caption="Lighthouse TBTスコア",
  description="棒グラフは、TBTが良好（200ms未満）なモバイルページは31％、改善必要なページが11％、TBTが不良（600ms以上）なページは58％であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQj6-t49BNV_5W-w83AABkUoo6klfyUyIz13yKShLAzK8qGs5lJ9TKcggIEp6JgxikVF-UJBAHpsrNl/pubchart?oid=2135422883&format=interactive",
  sheets_gid="46896816",
  sql_file="tbt.sql"
  )
}}

<p class="note"><strong>注：</strong>グラフのグループは、TBTのLighthouseスコアに基づいています（例：>= 0.9は「良い」結果）。スコアの四捨五入により、200msをわずかに超えるTBT値が「良好」に分類されています（600msの閾値でも同様です）。</p>

このデータは、WebPageTestでスロットルCPUのLighthouseを1回実行したものであり、実際のユーザー体験を反映したものではないことに留意してください。しかし、TBTとFIDを比較すると、潜在的なインタラクティビティははるかに悪く見えます。インタラクティブ性の「本当の」評価は、おそらくこの間のどこかにあるのでしょう。ですから、もしFIDが「良い」のであれば、FIDでは捉えられないような劣悪なユーザー体験を見逃しているかもしれないので、TBTを見てみてください。FIDが悪いのと同じ問題は、TBTも悪いのです。

{{ figure_markup(
  content="67秒",
  caption="最長のTBT",
  classes="medium-number",
  sheets_gid="1423728540",
  sql_file="lcp_element_data.sql"
  )
}}

## 結論

2020年よりパフォーマンスは向上しました。素晴らしいユーザー体験を提供するにはまだ長い道のりがありますが、改善するための手段を講じることは可能です。

まず、パフォーマンスを測定できなければ、改善することはできません。ここでは、実際のユーザーの端末を使ってサイトを測定し、リアルユーザーモニタリング（RUM）を設定することが良い第一歩となります。<a hreflang="en" href="https://rviscomi.github.io/crux-dash-launcher/">CrUX dashboard launcher</a> で、あなたのサイトがChromeユーザーでどのように機能しているかを知ることができます（あなたのサイトがデータセットに含まれている場合）。複数のブラウザにまたがって測定するRUMソリューションを設定する必要があります。このソリューションは自分で構築することもできますし、多くの分析ベンダーのソリューションの1つを利用することもできます。

次に、HTML、CSS、JavaScriptの新機能がリリースされたら、それを理解した上で実装することです。新しい戦略を採用した結果、パフォーマンスが向上したかどうかをA/Bテストで検証する。たとえば、フォールドより上にある画像をダラダラとロードしないなどです。RUMツールを実装していれば、自分の変更が誤ってリグレッションを引き起こしたときに、より適切に検出できます。

第三に、FID（現場・実使用データ）とTBT（実験室データ）の両方に対する最適化を継続することです。新しい応答性指標の <a hreflang="en" href="https://web.dev/responsiveness/">提案</a> を見て、フィードバックを提供して参加してください。また、新しい<a hreflang="en" href="https://web.dev/smoothness/">アニメーションの滑らかさの指標</a>も提案されています。より高速なウェブを目指す私たちにとって、変化は必然であり、より良い方向へと向かっています。私たちが最適化を続けていくためには、お客様の参加が重要です。

最後に、WordPressは上位1000万のウェブサイト、あるいはそれ以上のパフォーマンスに影響を与える可能性があることを確認しました。これは、すべてのCMSとフレームワークが留意すべき教訓です。フレームワークレベルでパフォーマンスに関するスマートなデフォルトを設定することができれば、より良いウェブを作ることができ、同時に開発者の仕事を容易にできます。

あなたがもっとも興味を持ったこと、驚いたことは何ですか？あなたの感想をTwitter（[@HTTPArchive](https://x.com/HTTPArchive)）でシェアしてください。
