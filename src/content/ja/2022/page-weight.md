---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: ページの重さ
description: 2022年のWeb Almanacのページの重さの章は、ページの重さが重要である理由、帯域幅、複雑なページ、時間と共に変化するページの重さ、ページリクエスト、ファイル形式について説明しています。
hero_alt: Hero image of Web Almanac characters using a set of scales to weigh a web page against variuos boxes labelled with various different kilobytes.
authors: [fellowhuman1101, dwsmart]
reviewers: [CSteele-gh]
analysts: [drohe]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1JvJMiRsL6T9m_NEBHFh-rrQmU5a-ufdOKriSJbrEN8M/
fellowhuman1101_bio: Jamie Indigoはロボットではありませんが、ボットの言葉を話します。技術的なSEOとして<a hreflang="en" href="https://www.deepcrawl.com">DeepCrawl</a>で、彼らは検索エンジンがウェブをどのようにクロール、レンダリング、そしてインデックス化するかを研究しています。彼らは野生のJavaScriptを手懐けることと、レンダリング戦略の最適化が大好きです。仕事をしていないとき、Jamieはホラー映画やグラフィックノベル、ダンジョンズ＆ドラゴンズが好きです。
dwsmart_bio: Dave Smartは、[Tame the Bots](https://tamethebots.com)で開発者および技術的な検索エンジンコンサルタントとして活動しています。彼は現代のウェブでツールを構築し、実験することが大好きで、しばしばライブギグの最前線で見かけることがあります。
featured_quote: 2022年には、ページのサイズを減らす機会があるにもかかわらず、ページの重さはますます大きくなる傾向が続きました。
featured_stat_1: 110 MB
featured_stat_label_1: モバイルページでロードされたフォントの最大重量
featured_stat_2: 678 MB
featured_stat_label_2: 最大のデスクトップページの重量
featured_stat_3: 594%
featured_stat_label_3: 10年間でのモバイルページ重量の増加
---

## 序章

過去10年間でモバイルページの重量が594％増加したことを示します。この期間に、影響を緩和するためのパフォーマンス向上技術が登場しました。最近のパフォーマンス測定方法であるCore Web Vitalsは、ページの重さを要因として除外しています。

Googleが推進するCore Web Vitalsイニシアチブは、上の折り返しのコンテンツがどれだけ早く見え、使えるかにパフォーマンスの認識をシフトしている一方で、大きなネットワークペイロードは依然として長いロード時間と相関しています。

多くのウェブサイトの構築者は、高速のデスクトップ接続の利点を享受しており、限られた、しばしば高価なモバイルネットワークアクセスを経験していません。

<a hreflang="en" href="https://www.itu.int/itu-d/reports/statistics/2022/05/30/gcr-chapter-2/">国際電気通信連合のグローバル・コネクティビティ・レポート</a>によると、世界の世帯の66％がインターネットアクセスを持っています。低所得国では、高所得国の91％に比べて22％しかアクセスがありません。途上国の農村地域では、4Gが有意義な接続の最低限であるにもかかわらず、3Gしか利用できないことが多いです。

世界の低所得国と中所得国の半数以上で、住民は<a hreflang="en" href="https://digital-world.itu.int/ministerial-roundtable-cutting-the-cost-can-affordable-access-accelerate-digital-transformation/">月平均収入の2％以上を1GBのモバイルブロードバンドデータ</a>に支払っています。

ページの重さは依然として重要です。不運なタイミングで弱いネットワーク接続を経験している場合でも、インターネットアクセスがメガバイト単位で課金される市場に住んでいる場合でも、ページの重さが増加すると情報の利用可能性が低下します。

## ページの重さとは何か？

ページの重さとは、ウェブページのバイトサイズを指します。もはや1994年ではないため、ウェブページはブラウザのアドレスバーで表示されるURLのHTMLだけではまれです。むしろ、ブラウザで表示されレンダリングされたウェブページは、特定の要素とアセットを使用します。

これが、ページの重さがページの作成に使用されるすべてのアセットを含む理由です。これには以下が含まれます。

- ページ自体を構成する[HTML](./markup)
- ページに埋め込まれた[画像やその他のメディア（ビデオ、オーディオなど）](./media)
- ページのスタイリングに使用される[カスケーディングスタイルシート（CSS）](./css)
- インタラクティビティを提供する[JavaScript](./javascript)
- 上記の1つ以上を含む[サードパーティ](./third-parties)リソース

各リソースはページのバイトと、ページの転送、処理、レンダリングに関わる計算リソースに追加されます。スクリプトのようなリソースは、ダウンロード、解析、コンパイル、および実行が必要なため、CPU使用量の形で追加のオーバーヘッドがあります。

ページの重さが膨れ上がるにつれて、影響を軽減するための勇敢な努力や方法が提案されています。それでも、リソース割り当てとページの重さの複雑な関係のからくりは、ほとんどのユーザーには見えません。

リソースのページの重さの影響をさらに詳しく調査しましょう：ストレージ、転送、およびレンダリング。

### ストレージ

最終的にウェブページを構成するすべてのリソースはどこかに保存する必要があります。ウェブサイトの場合、それはしばしば複数の場所を意味し、それぞれが自身のコストとオーバーヘッドを持っています。

ウェブサーバー上のストレージは、ディスクストレージ上では比較的低コストで、比較的スケーラブルです。もしウェブサーバーがメモリから提供している場合は少し高価かもしれません。これらのリソースは、中間キャッシュやCDNで複製される場合もあります。

それがソースですが、最終的にはリソースはクライアント側にも何らかの形で保存する必要があります。そこでは、とくにモバイルデバイスの場合、ストレージがより限定されている可能性があります。巨大で膨れ上がったファイルを提供することは、ユーザーのキャッシュを満たし、他の有用なリソースを押し出す可能性があります。

解像度がプリントメディアに適している未最適化の画像や、複数のメガバイトに及ぶ巨大なビデオファイルが依然として定期的に見られます。

これの多くは、メディアの適切なフォーマットとコーデックを選び、サイズと品質の両方に注意を払うことで軽減できます。<a hreflang="en" href="https://squoosh.app/">Squoosh</a>のようなサービスは、可能な限り小さなサイズで画像を最大限に活用するのに役立ち、<a hreflang="en" href="https://web.dev/image-cdns/">画像CDN</a>の専門家がこれの多くを自動化できます。

メディアは定期的にもっとも重い要素ですが、節約できるのはメディアだけではありません。テキストリソースも圧縮して最小化できます。

リソースをダイエットにすることは、これまでになく簡単になりました！

### 転送

はじめてウェブページを訪問するとき、そのページが要求するすべてのリソースは、サーバーからあなたのデバイスへインターネットを介して転送される必要があります。

これは超高速で高月間使用量のブロードバンド接続を介して行われることがありますが、遅くて高価でキャップされたモバイル接続や、衛星を介して行われることもあります。

ページの重さが大きいほど、これにかかる時間は長くなります。また、データプランが低いユーザーにとってはより高価になることもあります。

<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">`preconnect`</a>、<a hreflang="en" href="https://web.dev/preload-critical-assets/">`preload`</a>、<a hreflang="en" href="https://web.dev/articles/fetch-priority">Priority Hints</a>などロードされるものの順序を管理し、知覚されるロード時間を助ける最適化がありますが、最終的にはリソースはまだ転送され受信される必要があり、最良の最適化はより小さなリソースを提供することです。

### レンダリング

リソースの取得は、ウェブサイトを画面上に描画し、ユーザーに表示するための最初のステップに過ぎません。それを行うために、ウェブブラウザはページをレンダリングするためにすべての関連リソースを使用する必要があります。

ここでページの重さは重要な役割を果たします。まず、転送が遅い場合（ファイルが大きいため）、ブラウザがこれらをレンダリングするために作業を開始するまでの時間が長くなります。

大きなファイルは、ネットワーク上で受信された後も影響を及ぼします。大きなファイルは読み取り、処理、およびレンダリングのためにより多くの処理能力とメモリを必要とします。これにより、コンテンツの一部、またはすべてがユーザーに表示されるまでの遅延が長くなることにつながります。遅延が長ければ長いほど、ユーザーがページを放棄してより応答性の高いサイトから情報を求める可能性が高くなります。

ここでのJavaScriptはとくに懸念されます。ダウンロードする必要があるだけでなく、解析して実行する必要もあります。

巨大なファイルは、ユーザーが最初にダウンロードするのを待つ場合でも、継続的なパフォーマンスのペナルティを持つことがあります。これらはブラウザに利用可能なすべてのクライアントサイドリソースを消費し、パフォーマンスを遅くするか、ブラウザを完全にクラッシュさせる可能性があります。

最新の高性能スマートフォン、ラップトップ、タブレットでは、これらの大きなファイルを処理するパワーがあり、顕著なパフォーマンスの問題なく処理できるかもしれませんが、古いまたは低パワーのデバイスはうまく処理できない可能性があります。これらは、遅くておそらく高価なモバイル接続を持つデバイスでもあり、もっとも単純で信頼性の高いアクセスを必要とする人々にとって「二重のペナルティ」になる可能性があります。

## 私たちは何を配信しているのか？

1995年にHTML 2.0が導入される前、ページの重さは予測可能で管理しやすかったです。唯一のアセットはHTMLでした。<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc1866">RFC1866</a>は`<img>`タグを導入しました。画像がウェブページに含まれるようになると、ページの重さは劇的に増加しました。

HTML仕様のさらなるバージョンでは、ページの重さを増加させる可能性のあるさらに多くの機能が追加されました。たとえば外部CSSを使ってページ間で一貫したスタイリングを可能にしました。

1996年にはJavaScriptがはじめて登場し、2005年にはXHRが登場し、2006年にはjQueryのようなライブラリが誕生し、Angular、React、Vueなどのフレームワークに続き待ち構えていたリバイアサンであるJavaScriptを完全に解き放ちました。

ページの重さの増加は、機能を維持しながらパフォーマンスを向上させることを目的としたファイルタイプの増加をもたらしました。資産タイプ別にそれらを検討することで、トレードオフが強調されます。

### 画像

画像は、パフォーマンス向上技術とアセットのバイトサイズのバランスをとる代表例です。これらの静的ファイルは、ウェブページを構築し、レンダリングするためのリソースとして機能します。ウェブの視覚的な性質が高まるにつれて、このメディアタイプはもっとも普及しているアセットとしての地位を保持するでしょう。

PNG、JPEG、GIFなどの古い形式は、より広い「歴史的な」ブラウザサポートの遺産を楽しんでいます。パフォーマンスに焦点を当てたファイルタイプ<a hreflang="en" href="https://developers.google.com/speed/webp">WebP</a>は顕著なブラウザサポートを獲得し、現在<a hreflang="en" href="https://caniuse.com/webp">全世界のユーザーの97％</a>が利用可能です。

ウェブ上の画像の使用とその影響についての調査と考察については、[メディア](./media)章を参照してください。

### JavaScript

JavaScriptはウェブ上でもっとも人気のあるクライアントサイドスクリプト言語です。[98％のウェブサイト](./markup#fig-10)がインタラクティブなオンラインコンテンツを作成するために使用しており、<a hreflang="en" href="https://w3techs.com/technologies/details/cp-javascript">他のソースもそれが非常に高いと同意しています</a>。適度に使用された場合は素晴らしいですが、JavaScriptの魅力は、パフォーマンス、検索エンジン最適化、ユーザーエクスペリエンスの問題にもつながる可能性があります。

インターネットでもっとも好まれる問題を引き起こす魔法のアイテムについての詳細な洞察については、[JavaScript](./javascript)章を参照してください。

### サードパーティサービス

ページの重さは、元のホストのアセットに限定されません。ページによって要求されるサードパーティリソースが、分析、チャットボット、フォーム、埋め込み、分析、A/Bテストツール、データ収集の形で重さに追加されます。

[サードパーティ](./third-parties)章によると、モバイルデバイスのウェブサイトの94％が少なくとも1つのサードパーティリソースを使用しています！それぞれがページ重さのバイトサイズに貢献しています。

### その他のアセット

ウェブの基本的な構成要素は25年以上にわたって比較的変わらずに残っています。ウェブ体験の豊かさが増すにつれて、フォントとビデオの使用も増えています。

これらの増加は他のファイル重量の増加と同様に、とくに100パーセンタイルに顕著です。

{{ figure_markup(
  caption="モバイルページでの最大フォント使用量。",
  content="110 MB",
  classes="big-number",
  sheets_gid="1763112644",
  sql_file="bytes_per_type.sql"
)
}}

2021年には、モバイルサイトの100パーセンタイルがフォントファイルとして20,452キロバイトを使用しました。2022年には、これらの外れ値は110メガバイトに膨らみました。この540％の成長は、デスクトップの前年比で見られませんでした。デスクトップは2021年に66,257キロバイト、2022年に68,285キロバイトでした。

しかし、100パーセンタイルはおもしろい調査対象ではありますが、常にウェブの最悪の部分を示します。90パーセンタイルでは、モバイルフォントの重さはそれほど極端ではありませんでしたが、それでも大きく401キロバイトでした。

ウェブのタイポグラフィ的な性質に関するさらなる洞察は、[フォント](./fonts)章で見つけることができます。

## 数字によるページの重さ

これで、ページの重さを考慮する際に何に主に興味があるかがわかりました。詳細について詳しく見ていきましょう。

### リクエストの量

リクエストされたバイト数の合計だけでなく、ページを作成するために行われたリクエストの数もページのパフォーマンスに影響を与えることがあります。したがって、これもページの重さの一部として考慮します。

{{ figure_markup(
  image="distribution-of-requests.png",
  caption="リクエストの分布。",
  description="パーセンタイル別のリクエストの分布を示す棒グラフ。10パーセンタイルのモバイルページは23リクエスト、デスクトップも23、25パーセンタイルはモバイルで41リクエスト、デスクトップで45、50パーセンタイルはモバイルで70リクエスト、デスクトップで76、75パーセンタイルはモバイルで102リクエスト、デスクトップで121、90パーセンタイルはモバイルで168リクエスト、デスクトップで184。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=523847409&format=interactive",
  sheets_gid="508674603",
  sql_file="request_type_distribution.sql"
  )
}}

中央値（50パーセンタイル）のページでは、デスクトップページのロードには76のリクエストがあり、モバイルでは70のリクエストがあります。すべてのパーセンタイルでデスクトップとモバイルの差はほとんどありません。

昨年の中央値のデスクトップリクエストは74でしたので、昨年との大きな違いはありません。

{{ figure_markup(
  image="distribution-of-requests-by-content-type.png",
  caption="コンテンツタイプ別の中央値のリクエスト数。",
  description="コンテンツタイプ別の中央値のリクエスト数を示す棒グラフ。中央値のデスクトップページは画像25枚、JavaScriptファイル22個、CSS7個、HTMLファイル3個、合計76リクエストをロードします。中央値のモバイルページは画像22枚、JavaScriptファイル21個、CSSファイル7個、HTMLファイル2個、合計70リクエストをロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=666775105&format=interactive",
  sheets_gid="508674603",
  sql_file="request_type_distribution.sql"
  )
}}

タイプ別にリクエストを分析すると、画像がもっとも多いリソースリクエストで、中央値のページではデスクトップページのロード時に25枚の画像、モバイルでは22枚の画像をリクエストします。これは昨年のデスクトップ23枚、モバイル25枚とほぼ同じです。

JavaScriptはリクエスト数が次に多く、デスクトップで22リクエスト、モバイルで21リクエストです。これも2021年のデスクトップ21、モバイル20と非常に近い数値です。

一般的に、デスクトップとモバイルの違いはほとんどなく、モバイルで画像がわずかに少ないことがありますが、これは初期ビューポートが小さいために遅延ロードが発火しないことが原因かもしれません。

{{ figure_markup(
  image="distribution.png",
  caption="パーセンタイル別のページ重さの分布。",
  description="パーセンタイル別の総ページ重さの分布を示す棒グラフ。10パーセンタイルのモバイルページのロード重量は445 KB、25パーセンタイルは990 KB、50パーセンタイルは2,019 KB、75パーセンタイルは4,042 KB、90パーセンタイルは8,082 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=590874210&format=interactive",
  sheets_gid="1763112644",
  sql_file="page_weight_trend.sql"
  )
}}

50パーセンタイルでは、デスクトップページは2MBを超え、モバイルページはそれ未満です。90パーセンタイルでは、デスクトップは約9.0MBに、モバイルは約8.0MBに成長しています。

全体的なページ重さは、デスクトップとモバイルのユーザーエージェントで提供されるものを見ると非常に近いですが、より高いパーセンタイル（大きなページ）ではギャップがわずかに広がっています。モバイルデバイスはローカルリソースが少なく、ネットワーク機能が制限されている傾向があるため、これは懸念されます。

{{ figure_markup(
  caption="最大のデスクトップページの重さ",
  content="678 MB",
  classes="big-number",
  sheets_gid="1763112644",
  sql_file="page_weight_trend.sql"
)
}}

100パーセンタイルでは、検出された最大のページで、デスクトップユーザーは678MBのページに直面し、モバイルユーザーは390MBでした。

これらの大きなサイズを構成するものをもう少し詳しく掘り下げてみましょう。

### リクエストバイト

{{ figure_markup(
  image="median-page-weight-over-time.png",
  caption="時間経過による中央値のページ重量。",
  description="時間経過による中央値のページ重量を示す折れ線グラフ。グラフは時間とともにページ重量が増加していることを示しており、2012年3月にはデスクトップで669 KB、モバイルで288 KBから、2022年7月にはデスクトップで2,312 KB、モバイルで2,037 KBになっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1631675184&format=interactive",
  sheets_gid="1472139207",
  sql_file="page_weight_trend.sql"
  )
}}

時間経過とともに中央値のページ重量を見ると、傾向は一貫してがっかりさせるものであり、中央値の重量は時間とともに増加しています。

{{ figure_markup(
  caption="10年間でのモバイルページ重量の増加",
  content="594%",
  classes="big-number",
  sheets_gid="1472139207",
  sql_file="page_weight_trend.sql"
)
}}

2012年6月から2022年6月の10年間で、デスクトップページロードの中央値のページ重量は221%、または1.6 MB増加し、モバイルページロードでは594%、または1.7 MB増加しました。

年間比較（2022年6月対2021年6月）では、デスクトップは2,121 KBから2,315 KBに、モバイルは1,912 KBから2,020 KBに増加しました。

#### コンテンツタイプとファイル形式

{{ figure_markup(
  image="median-page-weight-by-content-type.png",
  caption="コンテンツタイプ別の中央値ページ重量。",
  description="コンテンツタイプ別のリソースの中央値ページ重量を示す棒グラフ。中央値のデスクトップページは画像が1,026 KB、JavaScriptが509 KB、CSSが72 KB、HTMLが31 KBをロードします。中央値のモバイルページは画像が881 KB、JavaScriptが461 KB、CSSが68 KB、HTMLが30 KBをロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1961492622&format=interactive",
  sheets_gid="1763112644",
  sql_file="page_weight_trend.sql"
  )
}}

ページの重さを構成するもっとも一般的なリソースコンテンツタイプの中央値の重量を見ると、画像が最大の貢献者であり、デスクトップページでは1,026 KB、モバイルでは811 KBです。次に大きな貢献者は、デスクトップとモバイルの両方のページロードでJavaScriptです。

{{ figure_markup(
  image="distribution-of-response-size-by-content-type.png",
  caption="コンテンツタイプ別の応答サイズの分布。",
  description="タイプ別のリソースサイズの分布を示す箱ひげ図。ビデオは他のリソースタイプと比べて圧倒的に大きく、90パーセンタイルで2,158 KBに達します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=131869564&format=interactive",
  sheets_gid="1337138155",
  sql_file="response_type_distribution.sql"
  )
}}

インターネット全体でページ重量にもっとも大きく貢献しているのは画像ですが、リクエストごとの純粋なサイズでもっとも大きな貢献者はビデオ、オーディオ、フォントです。90パーセンタイルで、ビデオリクエストは2,158 KBで、他のすべての90パーセンタイルタイプを合わせたものの4倍の重さがあります。

画像と同様に、より現代的なフォーマットや、より良いエンコーディング、サイズ設定、圧縮を活用することで、この重さを減らす機会があります。ただし、ビデオはその性質上重くなりがちであり、許容できる品質とサイズの間のバランスが必要です。詳細は[メディア章のビデオセクション](./media#ビデオ)を参照してください。

{{ figure_markup(
  image="median-response-size-by-content-type.png",
  caption="コンテンツタイプ別の中央値応答サイズ。",
  description="コンテンツタイプ別の中央値応答サイズを示す棒グラフ。中央値のモバイルページはビデオが268 KB、フォントが20 KB、オーディオが19 KB、画像が8 KB、JavaScriptが4 KB、CSSが2 KBをロードします。中央値のデスクトップページはビデオが208 KB、フォントが20 KB、オーディオが60 KB、画像が7 KB、JavaScriptが4 KB、CSSが2 KBをロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1388305020&format=interactive",
  sheets_gid="1337138155",
  sql_file="response_type_distribution.sql"
  )
}}

各コンテンツタイプの中央値応答サイズを見ると、モバイルページロードでビデオコンテンツがデスクトップよりも大きい268 KBであることが意外です。デスクトップでは208 KBです。フォントの中央値重量が画像よりも高く、モバイルで20 KB対8 KBと2倍以上になっていることも驚きです。

{{ figure_markup(
  image="median-response-size-by-format.png",
  caption="フォーマット別の中央値応答サイズ。",
  description="フォーマット別の中央値応答サイズを示す棒グラフ。中央値のデスクトップページはmp4が192 KB、f4vが480 KB、フラッシュが139 KB、jpgが24 KB、flvが136 KB、webpが14 KB、pngが5KBをロードします。中央値のモバイルページはmp4が342 KB、f4vが240 KB、フラッシュが118 KB、jpgが28 KB、flvが19 KB、webpが15 KB、pngが5KBをロードします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=405613087&format=interactive",
  sheets_gid="159262492",
  sql_file="response_format_distribution.sql"
  )
}}

ファイル形式に焦点を当てると、f4v、フラッシュ、flvがページにかなりの重さを加えていることが残念です。フラッシュプレイヤープラグインは2021年に廃止され、<a hreflang="en" href="https://support.google.com/chrome/answer/6258784">Chromeのような主要なブラウザから削除されました</a>ので、これらのバイトはおそらく完全にムダです。

#### 画像バイト

Web Almanacの開始以来、画像はページ重量の最大の割合を占めていますので、どのフォーマットが使用されているかを見る価値があります。

{{ figure_markup(
  image="distribution-of-image-sizes-by-format.png",
  caption="フォーマット別の画像サイズの分布。",
  description="サイズ別の画像の分布を示す箱ひげ図。JPGは圧倒的に最大のフォーマットで、90パーセンタイルで213 KB、次にWebPが99 KB、PNGが129 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1569662161&format=interactive",
  sheets_gid="159262492",
  sql_file="response_format_distribution.sql"
  )
}}

フォーマット別の画像サイズの分布は、JPG、WebP、PNGファイル形式が2021年の状態を維持し、画像重量の主要なソースであることを示しています。

{{ figure_markup(
  image="distribution-of-image-sizes.png",
  caption="画像サイズの分布。",
  description="パーセンタイル別の画像サイズの分布を示す棒グラフ。デスクトップページは10パーセンタイルで82 KB、25パーセンタイルで331 KB、50パーセンタイルで1,026 KB、75パーセンタイルで2,694 KB、90パーセンタイルで6,066 KBをロードします。モバイルページは10パーセンタイルで64 KB、25パーセンタイルで260 KB、50パーセンタイルで881 KB、75パーセンタイルで2,402 KB、90パーセンタイルで5,474 KBをロードします",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=692759206&format=interactive",
  sheets_gid="1763112644",
  sql_file="page_weight_trend.sql"
  )
}}

2022年のデスクトップの画像の中央値重量は1,026キロバイトで、2021年からわずか44キロバイトの増加でした。モバイルは881キロバイトでほとんど変わりませんでした。

年次の一貫性は、100パーセンタイルの極端な部分によってのみ崩れます。最大のデスクトップページには672MBの画像が含まれており、2021年の186MBという重い最大値から大幅に増加しました。同様に、モバイルの100パーセンタイルは959％増の385MBを見ました。

#### ビデオバイト

モバイルウェブのメディア章によると、モバイルページの5％に`video`要素が含まれています。この情報は、ビデオファイルがセットにグループ化されている全体的なページ重量の他のファイルタイプの100パーセンタイルと一致しています。ビデオ体験を提供するページは、それに応じて重量が増加します。

ウェブ上のビデオの[51.5％](./media#ビデオ)を占めるMP4は、最大の応答サイズの可能性も表しています。50パーセンタイルで、mp4の応答サイズは534キロバイトになります。

{{ figure_markup(
  image="distribution-of-video-sizes-by-format.png",
  caption="フォーマット別のビデオサイズの分布。",
  description="フォーマット別の画像サイズの分布を示す箱ひげ図。mp4は50パーセンタイルで最大で534 KB、次にf4vが155 KB、フラッシュが257 KB、flvが720 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1651375033&format=interactive",
  sheets_gid="159262492",
  sql_file="response_format_distribution.sql"
  )
}}

## バイト節約技術の採用率

では、送信しているこれらのバイトについて何ができるでしょうか？明らかに、ただ送信を停止することもできますが、理由があって送信されているはずです！したがって、内容を保持しつつ、ただキロバイトをパイプに詰め込むよりも効率的な方法で送信する方法を見てみましょう。

### ビデオとその他の埋め込みのためのファサード

ビデオやその他のインタラクティブな埋め込みは、ページの全体的な重量を大幅に増加させる可能性があります。ビデオはその性質上バイト数が多いことがありますが、ソーシャルメディアの埋め込みなど他のコンテンツも、たとえばツイートを埋め込むために多くのJavaScriptやその他のデータを取り込むことがあります。

良いデザインパターンは、ファサードの使用、つまり遅延ローディングの形態です。これは基本的に要素のグラフィカル表現を表示し、必要になるまで完全なものをロードしないというものです。たとえば、YouTubeビデオの場合、初期ロードはビデオのポスター画像だけであることがあります。これは<a hreflang="en" href="https://github.com/paulirish/lite-youtube-embed">人気のあるlite-youtube-embed</a>ライブラリによって採用されており、クリック時に実際の完全なYouTube埋め込みに変わります。また、従来の画像の遅延ロードのように振る舞い、ビューポート内または近くに変更することもできます。

このアプローチには欠点がありますが、<a hreflang="en" href="https://web.dev/third-party-facades/">web.devのサードパーティファサードに関する記事</a>で詳述されているように、ワイヤー上で送信されるデータの観点からユーザーにとっての利点は明らかです。彼らはビデオを見たい、またはライブチャットアプリと対話したい場合にのみ、そのコストを支払う必要があります。

実際には、ここでの採用は追跡が難しいです。Lighthouseは限られたサードパーティリソースの使用を見て、これらがリクエストされている場合、ファサードが利用可能かもしれないと指摘します。

サイトがファサードをうまく使用している場合、これらのリソースはリクエストされず、したがってLighthouseではテストできません。

ファサードパターンはサードパーティリソースに限定される必要はなく、これらは追加のルックアップや接続のデメリットがありますが、大きな自己ホストリソースにもうまく機能する可能性があります。

分析によると、Lighthouseがファサードが有益である可能性があることを検出できたサイトがいくつかあります。

{{ figure_markup(
  image="third-party-facades.png",
  caption="サードパーティのファサード。",
  description="サードパーティのファサードが有益である可能性があるサイトの割合を示す棒グラフ。デスクトップサイトの9.6％、モバイルサイトの8.8％がサードパーティのファサードから恩恵を受ける可能性があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1279294107&format=interactive",
  sheets_gid="1886611950",
  sql_file="facades-usage.sql"
  )
}}

テストされたデスクトップページの9.6％がファサードの実装から恩恵を受ける可能性があり、モバイル訪問ではやや良好な8.8％です。

### 圧縮

クライアントにリソースを提供する前に圧縮することでネットワークを介して送信する必要があるバイトを節約でき、理論上、そして通常は実際にも、より速いロードが可能になります。

[HTML](./markup)、[CSS](./css)、[JavaScript](./javascript)、JSON、SVGのようなテキスト非メディアファイルや、ttf、icoファイルに対して、HTTP圧縮は強力なツールで、gzipやBrotli圧縮を使用してファイルサイズを小さくできます。画像やビデオのようなメディアはすでに圧縮されているため、恩恵はほとんどありません。

{{ figure_markup(
  image="text-compression-proper-usage.png",
  caption="テキスト圧縮の適切な使用。",
  description="正しくテキスト圧縮を使用しているサイトの割合を示す棒グラフ。デスクトップサイトの74％、モバイルサイトの73％が、リソースのテキストベースを正しく圧縮しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1121279016&format=interactive",
  sheets_gid="1736634135",
  sql_file="compression-usage.sql"
  )
}}

デスクトップのページロードの74％、モバイルのページロードの73％で圧縮が検出されました。

モバイルの使用率がやや低いのは、モバイルが遅くて高価なネットワーク接続を持つ可能性が高いため、失望する結果です。

最終的に圧縮はページの重さの全体的な影響を減らすわけではありません。なぜなら、これらのリソースは使用前にクライアントで解凍されなければならないからです。

また、圧縮は完全に無料のプロセスではありません。静的リソースに対してキャッシュ可能であるとしても、サーバーには圧縮のための処理オーバーヘッドがあり、クライアント側にはこれらのリソースを使用する前に解凍するコストがあります。

これはトレードオフについてであり、しばしばネットワークが最悪のボトルネックとなります。圧縮技術は驚くほど効率的であり、通常、その正味の利益はそれだけの価値があります。

### 縮小化

<a hreflang="en" href="https://en.wikipedia.org/wiki/Minification_(programming)">縮小化</a>は、不要な文字（空白、コードコメントなど）を削除することで、テキストベースのリソースの全体的なサイズを減らすのに役立ちます。これらはブラウザがこれらのリソースをどのように解釈し使用するかには関係ありません。

CSSとJavaScriptは縮小化のための素晴らしい候補です。私たちはLighthouseのテストを使用して両方を調べました。

{{ figure_markup(
  image="minified-css-proper-usage.png",
  caption="CSSの適切な縮小化。",
  description="CSSリソースを正しく縮小化しているサイトの割合を示す棒グラフ。デスクトップサイトの84％、モバイルサイトの68％がCSSを正しく縮小化しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=2147180836&format=interactive",
  sheets_gid="922332593",
  sql_file="minified_css_usage.sql"
  )
}}

デスクトップページロードの84％が提供されたCSSを正しく縮小化し、モバイルページロードの68％がより少ない割合でした。

{{ figure_markup(
  image="minified-javascript-proper-usage.png",
  caption="JavaScriptの適切な縮小化。",
  description="JavaScriptリソースを正しく縮小化しているサイトの割合を示す棒グラフ。デスクトップサイトの77％、モバイルサイトの64％がJavaScriptを正しく縮小化しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=1333759402&format=interactive",
  sheets_gid="320865285",
  sql_file="minified_js_usage.sql"
  )
}}

デスクトップページロードの77％が提供されたJavaScriptリソースを正しく縮小化し、モバイルページロードの64％がより少ない割合でした。

CSSとJavaScriptの縮小化はありがたいことに人気があり、多くのサイトが正しく行っていますが、まだ改善の余地があります。

圧縮と同様に、モバイルユーザーのための縮小化がデスクトップよりも遅れているのは残念です。圧縮と同様に、モバイルデバイスではバイトを節約することがとくに役立ちます。

圧縮とは異なり、クライアント側に縮小化のオーバーヘッドはありません。リソースを使用するために「非縮小化」する必要はありません。サーバー側には提供時にリアルタイムで縮小化が行われる場合にオーバーヘッドが発生する可能性がありますが、CSSとJavaScriptは静的ファイルである可能性が高く、縮小化はビルド時またはリソースを公開する前に行うべきで、それ以上のオーバーヘッドはありません。

### キャッシュとCDN

キャッシュを使用すると、リソースを指定された有効期限まで再利用できます。キャッシュはブラウザやサーバーで使用されます。

CDNは人気のある例です。これら相互接続されたサーバーは地理的に分散されており、ユーザーにもっとも近いネットワーク位置からキャッシュされたコンテンツを送信することで、遅延を減らします。CDNはページの重さを減らすわけではなく、リクエスターとリソース間の距離を短縮することで遅延を減らします。

そのため、この章ではこの点については調査していませんが、[CDN](./cdn)章ではこれについて詳しく取り上げており、昨年の[キャッシング](../2021/cdn)章ではそれについてさらに詳しく説明しています。

## 結論

重たいページの重さは、ユーザーの待ち時間を長くします。ウェブページの増大するコストは、データアクセスのコスト、技術要件を満たすためのデバイスのコスト、および時間のコストで支払われます。

画像とJavaScriptは依然としてバイトサイズの最大の貢献者である一方で、2022年はモバイル上でのバイト重視のビデオの増加や、画像のカウンターパートよりも中央値のフォントバイトサイズが高いといった驚くべき増加が明らかになりました。

ほとんどのウェブと比べて幸いにも極端であるとはいえ、100パーセンタイルで見られる荒唐無稽な外れ値は、新しいファイルタイプや機能がデジタル体験に導入されると、制御されていない膨張の可能性を示しています。

バイト節約技術はいくつかの圧力を軽減していますが、モバイルユーザーにとってより影響が大きいにもかかわらず、デスクトップでの採用率が高いままです。このまま放置されると、デジタルの不平等の格差はさらに拡大するでしょう。
