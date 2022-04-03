---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: モバイルウェブ
description: 2021年版Web AlmanacのモバイルWebの章では、Webページのバイタル、画像、技術採用、アクセシビリティなどをカバーしています。
authors: [fellowhuman1101, dwsmart, ashleyish]
reviewers: [foxdavidj, fili]
analysts: [rvth, foxdavidj]
editors: [shantsis]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1mdma245ja_THTBApaJTeS4vmLY_Fn8VC6Kd8qx7wp-o/
fellowhuman1101_bio: Jamie Indigoはロボットではなく、ボットをしゃべるんです。<a hreflang="en" href="https://www.deepcrawl.com">Deepcrawl</a> のテクニカルSEOコンサルタントとして、検索エンジンがどのようにウェブをクロールし、レンダリングし、インデックスを作成するかを研究しています。野生のJavaScriptフレームワークを手なずけ、レンダリング戦略を最適化することが大好きです。仕事以外では、ホラー映画、グラフィック小説、Dungeons & Dragonsが好きです。
dwsmart_bio: Dave Smart は、<a hreflang="en" href="https://tamethebots.com">Tame the Bots</a> の開発者であり、検索エンジンの技術コンサルタントです。ツールの構築やモダンウェブの実験が好きで、ライブの最前線にいることもしばしば。
ashleyish_bio: Ashley Berman Hale は、<a hreflang="en" href="https://www.deepcrawl.com">Deepcrawl</a> のテクニカル SEO およびプロフェッショナルサービス担当副社長です。植物、動物、そして小さな人間のママでもあります。アシュリーは、地元のローラーダービーリーグでプレーし、新しいSEOを指導しています。
featured_quote: 2021年、明確な「モバイルウェブ」という認識は時代遅れです。複数のデータソースによると、モバイルはユーザーがデジタルコンテンツとインタラクトするための多くの方法の一つであるようです。
featured_stat_1: 18.4%
featured_stat_label_1: ネイティブ遅延ローディングによるモバイルページの読み込み
featured_stat_2: 43.4%
featured_stat_label_2: モバイルページのロードに不適切なサイズの画像が含まれる
featured_stat_3: 45.0%
featured_stat_label_3: モバイルページ読み込みの上位1,000件のうち、ズームを防ぐ
---

## 序章

2021年1月、世界人口の59.5％がインターネットを利用していた。全世界のアクティブなインターネットユーザー46億6000万人のうち、<a hreflang="en" href="https://www.statista.com/statistics/617136/digital-population-worldwide/">92.6% がモバイルデバイスでインターネットにアクセスしている</a>ということです。

ポケットに収められたモバイルウェブのユビキタス化により、<a hreflang="en" href="https://www.statista.com/statistics/330695/number-of-smartphone-users-worldwide/">Statista</a>によると、世界人口の80.8%がスマートフォンを所有しているとのことです。これは、前年比0.0%の比較的小さな伸びです。これに対し、2016年のスマートフォン所有率は49.4％でした。

この章では、世界的な接続性、技術の普及、モバイルフレンドリーな機能の利用など、モバイルウェブの最近の動向について考察した。

### 方法論に関するメモ

モバイルウェブとの関連でタブレット端末の体験をどのように分類するかという課題を考えたとき、このデータセットは分析から除外することにしました。多くの場合、タブレットのデータは、デスクトップまたはモバイルに分類されます。どちらをデフォルトとすべきか、統一された基準はありません。

### データソースについて

この章では、いくつかの異なるデータソースを使用しました。

* CrUX
* HTTP Archive
* Lighthouse
* Wappalyzer
* <a hreflang="en" href="https://twitter.com/paulcalvano/status/1454866401781587969">Akamai</a>

なお、HTTP ArchiveとLighthouseのデータは、ウェブサイトのホームページのみから特定されるデータに限定されており、サイト全体のデータではありません。詳しくは、[Methodology](./methodology)のページをご覧ください。

## ワールドワイドな接続性

2021年も世界的なCOVID-19の大流行の影響を受け、地域によってその影響も異なり、対策も地域によって異なるという状況です。これにより、ノートパソコンやパソコンとモバイル端末の使い分けが変わってきたのでしょうか。

### モバイルWebアクセスのコスト

モバイルウェブアクセスの金銭的コストは、2021年には大きく変化していた。<a hreflang="en" href="https://www.cable.co.uk/mobiles/worldwide-data-pricing/">ある分析</a>によると、イスラエルで1GBの平均価格はわずか0.05米ドルであることが判明しました。赤道ギニアで同じデータ通信料を使用した場合、ユーザーは49.67米ドルを支払うことになります。

パフォーマンス編」のデータによると、サイトの中央値は現在2,205KBとなっています。市場データを使用して、<a hreflang="en" href="https://whatdoesmysitecost.com/#usdCost">自分のサイトのコストについて</a> は中央のサイトをロードするための最良のシナリオの価格を計算しました。

もっとも高額な有料ロードはカナダのユーザーで0.26米ドル、次いでブラジルで0.18米ドルでした。ポーランドやロシアの一般的なデータプランで同じページを読み込んでも、ユーザーの請求書にはほとんど記載されず、0.01米ドル未満にとどまります。

### モバイルからのサイトへのトラフィックとデスクトップからのトラフィック(CrUX)

モバイル端末からのトラフィックとデスクトップからのトラフィックの割合はどうなっているのでしょうか？また、サイトの種類や業界によって、これらのユーザーの構成は大きく変わる可能性があります。

#### トラフィック利用の人気順

{{ figure_markup(
   caption="2021年7月データの817,4923オリジンのうち、モバイルトラフィックがデスクトップトラフィックを上回った割合。",
   content="77.4%",
   classes="big-number",
   sheets_gid="601797488",
   sql_file="mobile_greater_than_desktop.sql"
)
}}

今年の新しいCrUXデータセットでは、もっとも人気のあるサイト <a hreflang="en" href="https://developers.google.com/web/updates/2021/03/crux-rank-magnitude">ranked by magnitude</a> を、これらのオリジンへのトラフィック記録によって照会することが可能です。

{{ figure_markup(
   image="mobile-web-more-mobile-than-desktop-traffic.png",
   caption="デスクトップよりモバイルのトラフィックが多いサイトの割合。",
   description="デスクトップよりもモバイルのトラフィックが多いサイトの内訳を、ランクの大きさでグループ分けした棒グラフです。上位1Kオリジンのサイトでは、84.9%がモバイルトラフィックをより多く持っています。2つ目のグループ化である10Kオリジンでは、85.1%とモバイルトラフィックの割合が高くなっています。100Kオリジンの82.6%、上位1Mオリジンの80.1%は、デスクトップよりもモバイルからのトラフィックが多くなっています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=787161132&format=interactive",
   sheets_gid="601797488",
   sql_file="mobile_greater_than_desktop.sql"
  )
}}

CrUXランキング（データセット内のトラフィック上位1,000、10,000など）でグループ化すると、トラフィックが多いサイトほど、モバイルからのトラフィックの割合がわずかに増加します。上位1,000を除くすべてのサイトは、デスクトップに対してモバイルがわずかに少なく（84.9％対85.1％）なっています。

#### トラフィック分布

{{ figure_markup(
   image="mobile-web-mobile-traffic-distribution.png",
   caption="モバイルとその他のトラフィックの分布。",
   description="ほとんどのWebサイトにおいて、モバイルがトラフィックの大半を占めていることを示すグラフ。分析したウェブサイトの50％がモバイルデバイスから79.4％以上のトラフィックを得ており、2020年の77.6％から増加しています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=2123612862&format=interactive",
   sheets_gid="1909852444",
   sql_file="mobile_traffic_distribution.sql"
   )
}}

分布も同様に、モバイルヘビーな傾向を示しています。50パーセンタイルでは、トラフィックの79.4%がモバイルデバイスからのもので、2020年の77.6%を上回り、2019年の79.9%に追いついています。

#### CrUXデータを超えて

CrUXのデータセットは、ログインしており、同期が有効で、_検索やブラウジングをより快適にする_ / _あなたが閲覧したURLをGoogleに送信_ の設定を無効にしていないChromeユーザーのデータしか収集できないという制限があります。こういう意味です。

* FirefoxやSafariなど、他の主要なブラウザは欠落している
* iOSユーザーからのデータはまったくありません（ChromeはiOSデバイスの他のブラウザと同様にiOSでWebKitを使用します）

幸いなことに、他にもいくつかの資料があります。<a href="./contributors#paulcalvano">Paul Calvano</a>は、2021年7月の <a hreflang="en" href="https://www.akamai.com/products/mpulse-real-user-monitoring">Akamai mPulse</a> リアルユーザー モニタリング データについて、いくつかの分析を実施しました。また、モバイル端末からのトラフィックは59.4%で、モバイル端末とデスクトップ端末の比率はやや拮抗していることがわかりました。mPulseのデータは1時間ごとに集計されているため、いくつかの興味深い傾向を見ることができます。

##### すべての日々は平等ではない

{{ figure_markup(
   image="mobile-web-akamai-device-distribution-by-day.png",
   caption="日別デバイスタイプ分布 - mPulse 2021年7月。",
   description="2021年7月にアカマイのmPulseが発表した曜日別のモバイルvsデスクトップのトラフィック分布では、週末ごとにモバイルトラフィックが顕著に10%増加し、デスクトップのトラフィックも同様に減少しています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1981057164&format=interactive",
   sheets_gid="634917379"
   )
}}

週末のモバイルトラフィックの割合は、55～56%から65～67%へと10%程度増加しています。世界的に見ると、すべての国が月曜日から金曜日までの労働週ではありません。日曜日から木曜日も<a hreflang="en" href="https://en.wikipedia.org/wiki/Workweek_and_weekend">よくあるパターン</a>で、これは金曜日にわずかに上昇し、土曜日と日曜日にモバイル利用の大きなジャンプにつながることが見て取れるものです。

##### すべての時代が平等ではない

平日はモバイルの利用が減少し、デスクトップの利用がトラフィック全体に占める割合が増加しています。これは、インターネットユーザーがモバイル端末とデスクトップ端末を切り替えて利用していることを示しています。午前5時（UTC）頃から上昇し、午後7時（UTC）頃に再び上昇し始めます（午前10時/11時頃にも若干の上昇があります）。これは、就業時間と一致しています。

{{ figure_markup(
   image="mobile-web-akamai-device-distribution-by-hour-weekdays.png",
   caption="週末の時間帯別デバイスタイプ分布 - mPulse 2021年7月号。",
   description="2021年7月のアカマイのmPulseによる、平日の時間帯別、モバイルとデスクトップのトラフィック分布の折れ線グラフ（UTC表記）です。このパターンから、モバイルとデスクトップのトラフィックの間に逆変動が、あることがわかります。一方のデバイスタイプのトラフィックが増加すると、もう一方のデバイスは減少します。デスクトップの利用率は、従来の就業時間帯（午前7時から午後6時）と考えられる時間帯にもっとも高くなりますが、モバイルの利用率はどの時間帯でも52%から65%で大きくなっています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=12081105&format=interactive",
   sheets_gid="300179855",
   width="600",
   height="480"
   )
}}

週末は、モバイルとデスクトップのトラフィックの割合がより安定的に推移しています。

{{ figure_markup(
   image="mobile-web-akamai-device-distribution-by-hour-weekends.png",
   caption="週末の時間帯別デバイスタイプ分布 - mPulse 2021年7月号。",
   description="2021年7月のAkimai's mPulseによる、土日の時間帯別、モバイル対デスクトップのトラフィック分布（UTC表示）。時間ごとの変動が少ない先ほどのグラフに比べると、かなりフラットなグラフになっています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1776273851&format=interactive",
   sheets_gid="300179855",
   width="600",
   height="480"
   )
}}

このことから、異なるデバイスを選択できる人は、プライベートな時間ではモバイルのものを使う可能性が、高いことがわかります。

Cloudflareも素晴らしい調査結果を発表しています。アカマイのデータと同様に、この調査でも、CrUXのデータセットよりもモバイルデバイスとデスクトップデバイスがより近い割合で分かれていることが示されています。10月4日までの30日間で、トラフィックの52%はモバイルでした。

<figure>
  <blockquote>この1ヶ月間で、モバイルインターネットトラフィックの割合がもっとも高い国を探しました。その答えは... スーダン、インターネットトラフィックの83%がモバイルデバイスによるもので、実はイエメンと同率でした。</blockquote>
  <figcaption>— João Tomé、<cite><a hreflang="en" href="https://blog.cloudflare.com/where-mobile-traffic-more-and-less-popular/">モバイルトラフィックがもっとも多い場所ともっとも少ない場所は？</a></cite></figcaption>
</figure>

<a hreflang="en" href="https://radar.cloudflare.com/">クラウドフレアのRadar</a>トレンドレポートでは、地域ごとにトラフィックをセグメントできます。モバイルとデスクトップの割合が地域ごとに異なるのは興味深いことで、スーダンやイエメンは83%の使用率で並ぶのに対し、セイシェルはわずか29%の使用率です。

#### 結論を出すこと

モバイル端末の利用は引き続き堅調で、世界的に在宅勤務が増える傾向にあるにもかかわらず（保健当局や政府による規制や勧告のため）、モバイル端末によるウェブサイトへのアクセスは依然としてもっとも一般的な手段であることが明らかになりました。デスクトップに対するモバイルの人気は、昨年失ったものの大部分を取り戻したように見えますが、それ自体はかなり小さな後退です。

当然ながら、この数字からその理由を知ることはできませんが、多くのウェブユーザーにとってモバイル端末が唯一のデバイスであり、モバイルを使うかデスクトップを使うかの選択肢がないことは覚えておいて損はないでしょう。

モバイルトラフィックの割合が予想通りかどうかを予測するのは難しいですが、地域や分野に対して低いと思われる場合は、この部分のユーザーへのサービスが不十分であることを示している可能性があります。

## モバイルの方法論と技術スタック

モバイルウェブは非常によく利用されていますが、これらの体験は一般的に処理能力が低く、インターネットの相互接続も遅いものです。 このような制限を緩和するために、多くの技術が登場しています。 たとえば、接続の種類を識別して、その接続に最適なアセットを提供するクライアントヒントやAPIなどがあります。

このセクションでは、モバイルウェブの全体的なアプリの使用状況や、プログラミング言語、コンテンツ管理システム、ウェブサーバーがデスクトップのエクスペリエンスと比較してどうであるかについても見ていきます。

### クライアントヒント

[_クライアントヒント_](https://developer.mozilla.org/ja/docs/Web/HTTP/Client_hints)は、サーバーがアクセスするクライアントに要求して、デバイスやその機能、ネットワーク状況、その他のエージェント設定やプリファレンスに関する情報を取得できるHTTPリクエストヘッダーフィールドの集合体です。

これにより、そのデバイスに合わせた判断やコード、コンテンツ、エクスペリエンスの提供が可能になります。

モバイルウェブでは、劣悪なネットワーク環境と低性能なデバイスがより一般的であり、この情報を積極的に要求するサイトは、単にデスクトップページをモバイル画面に収まるように縮小する以上のことを考えている可能性が高いです。

HTTPクライアントヒントは比較的新しい機能で、<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8942#section-3.1">RFCは今年の2月に発行されたばかり</a>で、やや実験的なものです。したがって、1.4%のサイトがモバイルユーザーに対して少なくとも1つのクライアントヒントを要求していることがわかったのは、非常に心強いことです。

このような情報をもとにサイトが何をするのか、どのようにモバイルユーザー向けにカスタマイズするのかは分かりませんが、最初の兆候としては良いことだと思います。

これらのヒントは、大きく分けて3つのグループに分けられます。

* **デバイスクライアントのヒント**: サイトにアクセスするデバイスの機能および特徴の詳細。
* **ネットワーククライアントのヒント**: 機器とサーバー間のネットワーク接続の詳細。
* **ユーザーエージェントのヒント**: アクセスしているエージェントに関する詳細。

#### デバイスクライアントのヒント

{{ figure_markup(
   image="mobile-web-usage-of-device-client-hints.png",
   caption="Device Client Hintディレクティブの使用方法。",
   description="モバイルとデスクトップのページロードで検出されたデバイスクライアントヒントディレクティブの使用率を比較した棒グラフ。デスクトップサイトでは、モバイルサイトよりも `device-memory`、`dpr`、`viewport-width` クライアントヒントの使用率が低い（約0.10%対0.15%）ことがわかりました。また、`width`の使用率は、デバイスの種類によって異なり、0.01%でした。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=663083561&format=interactive",
   sheets_gid="1041308066",
   sql_file="client_hints.sql"
   )
}}

[`DPR`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/DPR) と [`Viewport-Width`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Viewport-Width) はモバイルサイトの0.15%でトップ、 [`Device-Memory`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Device-Memory) は0.14%で少し遅れ[`Width`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Width) はわずか0%ですが、これは現在非推奨で代替案はSec-CH-Widthで、これを要求するサイトは見つかりませんでした。

現在、これらのヘッダーをサポートしているのは、Chrome（およびMicrosoftのEdgeなどのChromiumベースのブラウザ）とOperaのみで、<a hreflang="en" href="https://caniuse.com/client-hints-dpr-width-viewport">SafariとFirefoxはまだ搭載されていません</a>。

#### ネットワーククライアントのヒント

{{ figure_markup(
   image="mobile-web-usage-of-network-client-hints.png",
   caption="Network Client Hintディレクティブの使用方法。",
   description="モバイルとデスクトップのページロードで検出されたネットワーククライアントヒントディレクティブの使用状況を示す棒グラフです。ここでも、モバイルの方が高いようです（デスクトップが0.09%に対してモバイルは0.15%）。一方、`save-data`の使用率はどちらも低く、それぞれ0.04%と0.08%となっています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=172140786&format=interactive",
   sheets_gid="1041308066",
   sql_file="client_hints.sql"
   )
}}

ネットワーククライアントヒントは、デバイスクライアントヒントと同様の利用率を示しており、[Downlink](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Downlink) と [ECT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ECT)（エフェクティブコネクションタイプ）はモバイルの負荷の0.2%が要求し、 [RTT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/RTT)（ラウンドトリップタイム）はモバイルの負荷の0.1%が要求しています。

Google Web Fundamentalsの記事、<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/save-data/">セーブデータで高速・軽快なアプリケーションを実現する</a>で詳しく述べられているように、ユーザーの利点を考えると、この機会を逃したように思われます。

#### User-Agent クライアントヒント

<a hreflang="en" href="https://blog.chromium.org/2021/05/update-on-user-agent-string-reduction.html">Chrome</a>、<a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=216593">Safari</a>、<a hreflang="en" href="https://bugzilla.mozilla.org/show_bug.cgi?id=1679929">Firefox</a> などの主要なブラウザは、<a hreflang="en" href="https://www.w3.org/2001/tag/doc/unsanctioned-tracking/#unsanctioned-tracking-tracking-without-user-control">パッシブフィンガープリント</a> を減らすため `User-Agent` 文字列に削減と上限設定を行いました。

従来は、サイトがこの情報を使って、それらのデバイスに合わせたエクスペリエンスを提供していたかもしれません。この方法は、刻々と変化するデバイスの状況に対応しようとすると、ユーザーエージェントの文字列が簡単に変更でき、なりすましが可能であるという欠点がありました。

_User-Agentクライアントヒント_ はこの情報を取得する方法を提供しますが、デバイスヒントやネットワークヒントとは異なり、`Accept-CH` ヘッダーを介してサーバーがこの情報を要求する必要はありません。これが、おそらくこれを要求しているサイトがほんの一握りしか検出されなかった理由です。

### ネットワーク情報APIおよびデバイスメモリAPIの使用状況

[_ネットワーク情報API_](https://developer.mozilla.org/ja/docs/Web/API/Network_Information_API) と [`Navigator.deviceMemory`](https://developer.mozilla.org/ja/docs/Web/API/Navigator/deviceMemory) は、クライアントヒントで公開されるものと同様のスコープで、デバイスと接続情報を収集するためのJavaScriptへのインタフェースを提供します。

#### ネットワーク情報API

{{ figure_markup(
   image="mobile-web-usage-of-networkinformation-effectivetype.png",
   caption="`NetworkInformation.effectiveType`の使用法。",
   description="ネットワーククライアントヒントディレクティブの使用状況をデスクトップとモバイルで比較した棒グラフです。デスクトップ端末の18.4%がこのAPIを使用しているのに対し、モバイル端末では18.2%となっています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=844974484&format=interactive",
   sheets_gid="277973945",
   sql_file="network_info_effective_type_usage.sql"
   )
}}

モバイルとデスクトップのページロードの比較には、[`NetworkInformation.effectiveType`](https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation/effectiveType)を使用しました。これは、有効な接続タイプ、`slow-2g`、`2g`、`3g`、`4g`に基づく文字列を返します。最上位は`4g`なので、5gやブロードバンド、固定接続を含む「4g以上の高速接続」と考えてもよいでしょう。

モバイルリクエストの18.2%に `NetworkInformation.effectiveType` を利用したページロードがありましたが、驚くべきことに、デスクトップリクエストの18.4%がこのAPIの利用を検知しています。

#### デバイスメモリAPI

{{ figure_markup(
   image="mobile-web-usage-of-navigator-devicememory.png",
   caption="`Navigator.deviceMemory`の使用法。",
   description="モバイルとデスクトップでの `Navigator.deviceMemoryAPI` の使用状況を比較した棒グラフです。デスクトップサイトの10.2%がDevice Memory APIを使用したのに対し、モバイルのページロードでは10.9%でした。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=634683822&format=interactive",
   sheets_gid="1309485612",
   sql_file="navigator_device_memory_usage.sql"
   )
}}

このAPIは、クライアントが処理できるかもしれないものを判断し、それに応じて適応するのに役立つ、デバイスメモリの概算量を返します。

モバイルページの読み込みの10.9%がこのAPIを利用しており、デスクトップの読み込みの10.2%をわずかに上回っています。

Client Hintsと同様、これらのAPIはまだ実験的なものです。また、各ブラウザでユニバーサルサポートされていません。（引用元: <a hreflang="en" href="https://caniuse.com/netinfo">ネットワーク情報API</a>と<a hreflang="en" href="https://caniuse.com/mdn-api_navigator_devicememory">`Navigator.deviceMemory`</a>) しかし、より広く採用されています。

普及の理由のひとつは、サードパーティのスクリプトがページロード時にこれらを要求することだろう。もうひとつの理由は、実装のしやすさかもしれません。HTTPヘッダーの設定と読み込みは、より複雑で、インフラの変更を伴う可能性が高いと考えられるからです。

### クライアントヒント、ネットワーク情報API、デバイスメモリAPIの結論

実験的なAPIや機能については、すでにいくつかの有望な導入事例があります。ブラウザのサポートが進み、APIが実験的な状態から移行するにつれて、さらに利用が進むことを期待しています。

もしあなたがネットワークやデバイスの能力に制限のあるウェブアプリケーションを使用していて、低性能のデバイスや貧弱なネットワーク接続からアクセスするユーザーがかなりの割合を占めているなら、これらのAPIによって、より良いユーザー体験を提供できるかどうかを調査する良い機会かもしれません。

### モバイルウェブでのアプリ利用状況

モバイルウェブでもっともよく使われるライブラリやテクノロジーは、パフォーマンスに影響を与え、テクノロジーの採用について情報を与えてくれます。

<a hreflang="en" href="https://www.wappalyzer.com/">Wappalyzer</a>のデータによると、JavaScriptライブラリJQueryは、モバイルウェブの主要ライブラリで、テストサイトの84.4％に搭載されています。Googleは、上位5位中3位を占め、圧倒的なプロバイダーです。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">アプリ</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">デスクトップとモバイルの使い分け</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">84.4%</td>
        <td class="numeric">84.4%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Google Analytics</td>
        <td class="numeric">65.4%</td>
        <td class="numeric">68.6%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td>PHP</td>
        <td class="numeric">50.5%</td>
        <td class="numeric">50.5%</td>
        <td class="numeric">-0.4%</td>
      </tr>
      <tr>
        <td>Google Font API</td>
        <td class="numeric">47.6%</td>
        <td class="numeric">47.6%</td>
        <td class="numeric">-0.1%</td>
      </tr>
      <tr>
        <td>Google Tag Manager</td>
        <td class="numeric">43.4%</td>
        <td class="numeric">43.4%</td>
        <td class="numeric">2.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="人気のある技術利用。", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

上位5つのモバイルWeb技術のうち、3つの技術の採用率はデスクトップサイトより高かった。 これらのアプリは、Googleがパフォーマンスの問題を診断するために推奨しているオープンソースの監査ツールであるLighthouseによって頻繁にフラグが立てられるため、モバイルパフォーマンスへの取り組みによってモバイルでの採用率が低下したと考えるのは妥当でしょう。

2021年、Googleは<a href="https://developers.google.com/search/docs/advanced/experience/page-experience">ページ体験ランキングシグナル</a>をアルゴリズムに追加しました。このランキングシグナルは、モバイルデバイスで提供される検索エンジンの結果ページに特化したもので、実際のユーザーのページロードから収集したデータを使用してパフォーマンスを測定しています。

JavaScriptライブラリJQueryは、モバイルウェブで圧倒的なシェアを誇り、モバイルページ読み込みの84.4%で利用されています。Googleは、上位5位中3位を占める圧倒的なプロバイダーです。

#### コンテンツ管理システム

コンテンツ管理システムは、サイトオーナーが認証されたバックエンドを通じて、コンテンツの公開、更新、制御を行うことを可能にします。2021年のモバイルウェブにおけるコンテンツ管理システムの上位5つは以下の通りです。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">CMS</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">33.6%</td>
        <td class="numeric">32.9%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルとデスクトップのCMSを比較すると突出している。", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

2021年のCMSは、PHPで書かれたオープンソースのCMSであるWordPressが主流となった。この技術は33.6％のサイトに登場しました。

#### デスクトップ技術の採用率を比較する

モバイルウェブの技術採用率は、デスクトップと歩調を合わせて推移しました。もっとも顕著な違いは、サードパーティピクセルの使用という形で現れました。デスクトップサイトの68.6%がGoogle Analyticsを使用しているのに対し、モバイルサイトでは65.4%でした。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">カテゴリー</th>
        <th scope="col">テクノロジー</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ普及率向上</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>分析</td>
        <td>Google Analytics</td>
        <td class="numeric">68.6%</td>
        <td class="numeric">65.4%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td>タグマネージャー</td>
        <td>Google Tag Manager</td>
        <td class="numeric">46.0%</td>
        <td class="numeric">43.4%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>分析</td>
        <td>Facebook Pixel</td>
        <td class="numeric">20.6%</td>
        <td class="numeric">18.9%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>ウィジェット</td>
        <td>Facebook</td>
        <td class="numeric">28.0%</td>
        <td class="numeric">26.3%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>JavaScript ライブラリ</td>
        <td>jQuery UI</td>
        <td class="numeric">23.8%</td>
        <td class="numeric">22.2%</td>
        <td class="numeric">1.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デスクトップ普及率の高い技術。", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

パフォーマンス測定と優先順位付けの変更を考慮すると、これらのJavaScriptを多用するサードパーティ製アセットがないのは、モバイルページのエクスペリエンスを向上させるための意図的な努力の一環と考えるのが妥当でしょう。Facebookピクセル分析スクリプトは、デスクトップに比べてモバイルサイトでは、-1.7%減少しました。

モバイルサイトでは、特定の技術を採用する傾向が強いが、その差は小さかった。Bloggerはモバイルサイトの3.1%、デスクトップサイトの1.7%で採用されています。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">カテゴリー</th>
        <th scope="col">テクノロジー</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">モバイルの普及率向上</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ブログ</td>
        <td>ブロガー</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">3.1%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>ウェブサーバー</td>
        <td>OpenGSE</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">3.2%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>プログラミング言語</td>
        <td>Python</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td>プログラミング言語</td>
        <td>Java</td>
        <td class="numeric">2.8%</td>
        <td class="numeric">4.0%</td>
        <td class="numeric">1.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルの普及率が高い技術。", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

#### モバイルウェブアプリの利用状況に関する結論の導き出し

2021年、JQuery経由のJavaScriptがモバイルWebに浸透。サードパーティーの分析ツールは、モバイルでの採用率が低かった。

このデータで明らかになったのは、CMSやウェブサーバのレベルでは、モバイルとデスクトップはサイト開発方法において密接な相関関係があるということです。おそらく、レスポンシブデザインはオーバーヘッドが少なく、ひとつのコードベースですべての体験を提供できることが大きな要因となっています。

WordPressがモバイルサイトでの人気を維持・拡大し、他のCMSもデスクトップと同様のシェアを獲得していることから、CMSのコアの改善と最適化がモバイルウェブ全体に大きな利益をもたらす絶好の機会となっているのです。

そのため、<a hreflang="en" href="https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/">提案されたWordPressパフォーマンス チーム</a>のような活動は重要かつ貴重なものとなっています。

## モバイルウェブとの対話

ユーザージャーニーにおける摩擦を減らすためには、モバイルデザインと使いやすさに気を配ることが重要です。ユーザーは、マウスやトラックパッドのような洗練された操作ではなく、指のタップでモバイルウェブをナビゲートします。

### 代替プロトコルリンク

ウェブはリンクで成り立っている。モバイルウェブでは、http/sを超える[Unique Resource Identifier](https://ja.wikipedia.org/wiki/Uniform_Resource_Identifier) スキームにより、ユーザーは <a hreflang="en" href="https://developers.google.com/web/fundamentals/native-hardware/click-to-call">`tel:`を使って電話番号をダイヤルしたり</a> 、メールを開始したりといった作業を最小限の摩擦で完了できます。

もっとも一般的なURIスキームは、93.2%のサイトで見られた`https:`と、その非セキュア版である`http:`で、56.7%に見られた。2020年には、コンテンツが安全でない場合に警告を発してユーザーの安全を守ることを、ブラウザが大きく発表したため、安全でないリンクプロトコルの高い使用率は注目される。

ウェブページのリンクの次に、モバイルウェブでアンカーhrefの値でよく使われるプロトコルは次の5つです。

{{ figure_markup(
   image="mobile-web-popular-link-protocols.png",
   caption="人気のある代替プロトコルのリンク集です。",
   description="デスクトップとモバイルで人気のある代替プロトコルリンクの利用状況を示す棒グラフ。`mailto`はデスクトップでわずかに多く使われています（28.3%に対して28.9%）、モバイルでは、`tel`の方が多く（20.7％対24.2％）、`whatsapp`、`viber`、`skype`の利用は少ないが、モバイルでは多い（デスクトップではそれぞれ0.4%、0.4%、0.3%に対し、モバイルでは0.6%、0.5%、0.3%)。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=859715983&format=interactive",
   sheets_gid="115658247",
   sql_file="popular_link_protocols.sql"
   )
}}

モバイルデバイスは、電話であり、SMSやその他のメッセージングサービスを備えていますが、デスクトップクライアントは備えていない場合があります。標準的な `http:` / `https:` 以外のリンクプロトコルを使用することで、これらの機能のいくつかを解放できます。コピー＆ペーストすることなく、通話やメッセージ送信のためのタップ可能なリンクを提供することで、よりスムーズで統合されたユーザーインタラクションを実現できます。

#### `mailto`

`mailto:` をクリックすると、ユーザーが選択したメールクライアントを起動します。

```html
<a href="mailto:enquiries@example.com?subject=Enquiring about Red Widgets">
  enquiries@example.com
</a>
```

指定されたメールアドレスと件名でメールをプリフィルする。モバイルで便利ですが、デスクトップにも関連します。

#### `tel`

`tel:` は電話をかけます。

```html
<a href="tel:+44123467890">
  電話 +44 (0)123 4567890
</a>
```

電話アプリを開き、その番号にダイヤルする準備ができます。これにより、コピー＆ペーストの手間が省け、電話による問い合わせを重視するビジネスでは摩擦が少なくなります。

#### `sms`

`sms:` は、クライアントのデフォルトのSMSメッセージングアプリを呼び出します。

```html
<a href="sms:+441234567890">
  テキストで問い合わせる
</a>
```

クリックすると正しい番号のメッセージがプリフィルされる場合、メッセージ本文をプリフィルすることもできます。これはトップ5から外れ、モバイルサイトの読み込みのわずか0.3％がこれを利用しています。

#### その他のメッセージングアプリ

他のメッセージングアプリは、`<a href="">` を開かせるプロトコルを登録できます。上の表にあるように、ここではWhatsAppとViberが主要で、ネイティブアプリ `sms:` の使用率を上回ります。

#### 代替プロトコルリンクの結論

`mailto:`はインターネット上で長い歴史を持ち、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc1738#section-3">1994年までさかのぼります</a>。しかし、モバイルデバイスでのさらなる有用性を考えると、`tel:`が24%の使用率に達し、遠く及ばないのは頼もしいことです。

smsの取り込みがこれほど少ないのは驚きであり、WhatsAppやViberなどの独自アプリを下回っているのは残念です。

SMSはデフォルトで利用できる可能性が高く、追加インストールも必要ないため、一見すると利用しやすいように見えます。しかし、WhatsAppとViberのメッセージは無料ですが、SMSのメッセージはユーザーの携帯電話会社から料金が、発生する場合があります。このことが、相対的な人気の高さを説明しているのかもしれない。

`https:` 以降のプロトコルがユーザーに提供できる通信のための拡張機能を使用しておらず、モバイルウェブサイトに適している場合、これらはシンプルでユーザーフレンドリー、かつ低開発の利点を提供できる可能性があります。

### 入力欄

URIスキームが、ユーザーがウェブサイトからアクションを起こすことを可能にするのに対し、入力欄はユーザーがウェブサイトに情報を提供することを可能にする。

入力要素は、HTMLの中でもっとも強力で複雑な機能の1つです。入力要素は、ウェブベースのフォームのためのインタラクティブなコントロールを作成するために使用されます。ウェブユーザーは、ボタン、チェックボックス、カレンダー、検索など、ユーザーの入力に基づきページの内容を制御できるこれらの要素を経験します。

{{ figure_markup(
   caption="モバイルページで入力を使用している割合。",
   content="71.5%",
   classes="big-number",
   sheets_gid="702940634",
   sql_file="mobile_greater_than_desktop.sql"
)
}}

テストしたモバイルページの71.5％が入力を含んでいました。これは、デスクトップの71.1%よりわずかに高い値です。

#### タイプ宣言

{{ figure_markup(
   image="mobile-web-popular-input-types.png",
   caption="モバイルで人気の入力タイプ。",
   description="モバイルで人気のある入力タイプの使用状況を示す棒グラフ。入力タイプを使用しているモバイルページの72.6%で `text` が、53.2%で `hidden` が、40.1%で `submit` が、27.1%でnot set (n/a)、25.1%では`email`、23.9%で `search`、23.7%で `checkbox`、13.7%で`password`が使われ5.9%で `radio`、最後の5.4%で`tel`が使用されていることがわかります。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1625671749&format=interactive",
   sheets_gid="1769747270",
   sql_file="popular_mobile_input_types.sql"
   )
}}

入力によって作成されたインタラクティブ・コントロールの出現を追跡するには、`type`属性を探せばよいのです。 `type` 属性はinput要素がどのように動作するかを制御するため、もっとも重要です。テストしたサイトの70.9%で `type` 属性の値が宣言されていました。

`type`属性がない場合、入力のデフォルトは`text`で、1行のテキストフィールドになります。input要素を使用しているページの分析では、27.1%のページが入力タイプを宣言しておらず、デフォルトの`text`文字列値を使用していました。

全ページのうち、72.6%が少なくとも1つの `text` 型の入力を含んでいた。これはもっともよく使われている。

宣言された `text` 値とフォールバック値を合わせると、input要素を使用しているサイトの99.7%がtext値を取得していることがわかります。

#### 高度な入力タイプ

{{ figure_markup(
   caption="モバイルページで入力を使用している割合。",
   content="44.8%",
   classes="big-number",
   sheets_gid="785717317",
   sql_file="usage_of_advanced_input_types.sql"
)
}}

入力項目が1つ以上あるページのうち、44.8%が1つ以上の「高度な入力タイプ」を使用しています。高度な入力タイプには、 `color`、`date`、`datetime-local`、`email`、`month`、`number`、`range` 、`reset`、`search`、`tel`、`time`、`url`、`week`、`datalist` があります。

##### 電話番号

電話番号の入力を求めるページは5.4％でした。モバイルユーザーにとって、アルファベットキーボードから数字キーボードへの移行は摩擦の大きいポイントです。電話番号を入力するページの62.6%は、入力フィールドに`type=tel`の値がないものを使用していました。

##### Eメール

入力タイプ `email` は、ユーザーに有効な電子メールアドレスを送信することを要求します。フォームに電子メール以外の値を入力すると、フォームの送信時にエラーが表示されます。

25.1%のページが、ユーザーに電子メールを求めるフィールドを少なくとも1つ含んでいました。

電子メールの収集は、ユーザージャーニーにおける重要なマイクロコンバージョンであることが多いため、最小限の摩擦で電子メールを収集することは、サイトにとってより高いコンバージョン率という利益をもたらします。このように明確なビジネス価値があるにもかかわらず、ユーザーの電子メールを尋ねるページの42%は、少なくとも1つのインスタンスでtype=emailの入力タイプが使用されていません。

##### 検索条件入力

サイト内検索は、ユーザーを目的のコンテンツに誘導するための強力なツールです。検索入力は、機能的にはテキストと同じテキストフィールドです。検索入力フィールドとテキスト入力フィールドの主な違いは、ブラウザによる処理のされ方です。

検索入力タイプを使用すると、十字のアイコンが表示され、ユーザーは既存の検索テキストを素早く消去できます。また、最近のブラウザの多くは、検索クエリをドメイン間で保存します。検索タイプが指定されている場合、保存されているクエリを使用してフィールドをオートコンプリートできます。

テストしたページの23.9%に検索入力欄があった。このようなフィールドは、テキストまたは宣言されていない入力タイプを使用しているにもかかわらず存在する可能性があることに留意する必要があります。これは、17%のサイトが検索入力を使用していた2020年よりも若干増加しています。

ビジネス上の価値が入力タイプの採用に影響を与えているようだ。Eコマースサイトは、取引というビジネス目標を達成するために、ユーザーを目的の商品まで迅速に移動させるという既得権益を有している。

テストしたECサイトの43.3％がモバイル体験で検索入力を使用しています。興味深いことに、これはデスクトップクライアントで入力タイプを使用しているサイトの42.6%より高い数字です。

#### オートコンプリート

[`オートコンプリート`](https://developer.mozilla.org/ja/docs/Web/HTML/Attributes/autocomplete)属性は、フォームや入力がブラウザの自動入力機能でどのように動作するかをある程度制御できるようにするものです。完全に無効にする方法から、名前や住所などの自動入力のヒントを提供する方法まで、さまざまなオプションがあります。

モバイル端末でのテキストやデータの入力は、フルキーボードを備えた端末よりも一般的に面倒な作業となるため、自動入力はデスクトップユーザーよりもさらに便利で時間の節約になる機能です。<a hreflang="en" href="https://www.youtube.com/watch?v=m2a9hlUFRhg&t=1433s">Googleは、自動入力を使用するとフォーム送信が25% 増加することを発見しました</a>。

モバイルページの読み込みでは、24.8%のページが`オートコンプリート`属性を利用しており、デスクトップページの読み込みの27%よりも低い数値となっています。

HTTP Archiveのデータはホームページのみを対象としているため、チェックアウトや問い合わせなど、入力が必要と思われる場所での利用率はもっと高い可能性があります。しかし、間違いなくもっとも有用であるはずのモバイル体験での利用率が低いのは、残念なことかもしれません。

#### 入力欄の結論

入力タイプの宣言は、摩擦を減らすために非常に重要です。入力要素が適切なタイプでマークアップされていれば、入力要素は異なるキーボードを促し、体験を向上させることができます。ユーザー体験への恩恵により、入力タイプを低リフトで採用することは有意義な投資となります。

電話や電子メールといった入力タイプの採用率が低いことは、モバイルウェブの入力欄がユビキタスであることを考えると、驚くべきことです。ビジネスゴールとユーザー体験との間のこのギャップは、モバイルウェブでのユーザー体験が重要であることを示している。Webサイトがもたらす最大のチャンスは、自社で機能を開発することではなく、モダンブラウザにネイティブ搭載されつつある機能性を活用することかもしれません。

### モバイルウェブにおけるアクセシビリティ

パンデミックによって、世界中の人間が友人、家族、地域社会から孤立せざるを得なくなった。また、<a hreflang="en" href="https://www.hhs.gov/civil-rights/for-providers/civil-rights-covid19/guidance-long-covid-disability/index.html#footnote10_0ac8mdc">COVID後の状態</a>により、障害に直面する人の数が増加しました。このシフトにより、対面でのサービスや商取引、コミュニケーションが阻害され、デジタル空間が新たなデフォルトとなることを余儀なくされたのです。

アクセシビリティの目標は、すべてのユーザーに対して機能と情報の平等性を提供するWeb体験を作り出すことです。アクセシビリティの実践により、低速のインターネット接続を使用している人や、データプランが限られている人、あるいは高価なデータプランを持っている人も情報を利用できるようになるため、モバイルのユーザーはアクセシビリティの恩恵を受けることができます。

#### ARIAロール

アクセスしやすいリッチなインターネットアプリケーション (ARIA) は、一般的に使用されるインタラクションやウィジェットを支援技術に渡すことができるように、HTMLを補足する属性のセットです。これらの属性は、<a hreflang="en" href="https://webaim.org/blog/web-accessibility-and-seo/">検索エンジンがページの内容を理解するのに役立つ</a>ものでもあります。

サイトが支援技術を使用してアクセスされる場合、要素のARIAロールは、ユーザーがどのように対話できるかの情報を伝えます。

{{ figure_markup(
   image="mobile-web-most-common-mobile-aria-roles.png",
   caption="ARIAの代表的な役割トップ10。",
   description="モバイルウェブでのARIAロールの採用をデスクトップと比較した棒グラフです。`ボタン`はモバイルページの29.0%で使用され、次に`ナビゲーション` (22.5%)、`プレゼンテーション` (21.1%)、`ダイアログ` (20.1%)、`検索` (18.8%)、`メイン` (16.8%)、`バナー` (14.3%)、`コンテンツ情報` (12.1%)、`イメージ` (10.9%) そして最後に`タブリスト` (7.4%) が続きます。デスクトップでの利用も同様です。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1644250399&format=interactive",
   sheets_gid="1584971419",
   sql_file="../accessibility/common_aria_role.sql"
   )
}}

2021年にもっとも普及したARIAロールは`ボタン`で、29%のサイトに掲載されています。`ボタン`の役割は、ユーザーによってアクティブにされたとき反応を引き起こす、クリック可能な要素を示しています。

71%以上のモバイルサイトがウェブベースのフォームにインタラクティブ・コントロールを搭載している一方で、もっとも一般的に採用されているARIA属性であるaria-labelは、テストサイトの11.2%にしか搭載されていないことがわかりました。このアクセシビリティに特化した属性は、テキスト文字列で入力にラベルを付けるために使用されます。

#### カラーコントラスト

色覚異常や高齢者に多い低色感のユーザーには、色のコントラスト不足が影響します。十分なカラーコントラストは、コンテンツへの平等なアクセスを可能にし、ビジネス目標にポジティブな影響を与えることができます。Googleのケーススタディでは、eコマースサイトのEastpakは、コールトゥアクションボタンにテキスト色とその背景の十分なコントラストを使用すると、<a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">クリック率が20%増加した</a>と報告しています。

{{ figure_markup(
   image="mobile-web-sufficient-color-contrast.png",
   caption='十分なカラーコントラストが確保されたモバイルサイト',
   description="十分なカラーコントラストでモバイルページを読み込むことができた割合を示す棒グラフ。2019年は22.0%のサイトが監査に合格しました。2020年は21.1%に低下。2021年は22.2%に上昇しました。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1440359640&format=interactive",
   sheets_gid="1628455121",
   sql_file="../accessibility/color_contrast.sql"
   )
}}

コンバージョン率を高める可能性があるにもかかわらず、77.8%のサイトで十分なカラーコントラストが使用されているかどうかのLighthouse監査に不合格となりました。これは、前年比でわずかに改善されています。

#### タップ対象

タップ対象は、ユーザーの入力に反応する要素です。リンク、ボタン、フォームフィールドなど、さまざまなものが含まれます。

効果的なユーザー交流を実現するためには、タップターゲットのサイズとページ上の他のタップ対象との間隔は適切であることが必要です。インタラクティブ要素は、少なくとも48x48ピクセルで、他のインタラクティブ要素から少なくとも8ピクセルのパディングを取る必要があります。

{{ figure_markup(
  caption="モバイルサイトにおいて、十分な大きさのタップ対象を使用している割合。",
  content="39.3%",
  classes="big-number",
  sheets_gid="1766782050",
  sql_file="tap_targets.sql"
)
}}

全体では、テストしたサイトの39.3%が十分な大きさのモバイルタップ対象を使用していました。タップ対象の採用率は、ドメインランクのグループ間で一貫していました。これは、適切なサイズのタップ対象が36.3%であった2020年からわずかに増加したものです。

#### ズームとスケーリング

ビューポートメタ要素は、ユーザーのデバイスでページをどのようにレイアウトするかをブラウザへ通知するために重要です。また、`user-scalable="no"`や小さな`maximum-scale:`パラメーターを追加して、ユーザーがコンテンツを拡大することを完全に防止するか、制限するように設定することも可能です。モバイルデバイスでは、これは一般的にピンチズームです。

ズームインできないようにすることは、弱視のユーザーにとって問題であり、<a hreflang="en" href="https://dequeuniversity.com/rules/axe/3.3/meta-viewport">WCAG2.0ガイダンスに引っかかるもの</a>です。

残念なことに、モバイルページの29.4%がこの要件を満たせず、ズームを妨げるビューポートを含んでいました。（引用元：[2020 Web Almanacアクセシビリティ](../2020/accessibility#ズームと拡大縮小)の章）

ドメインランキングで使用率を見ると、さらに状況は悪くなる。

{{ figure_markup(
   image="mobile-web-zoom-blocking-viewport-tags.png",
   caption="ドメインランクによる拡大・縮小を無効化しました。",
   description="モバイルページのロードでズームとスケーリングが無効化された割合を、オリジンの人気度でグループ化した棒グラフです。上位1Kのオリジンでは、45.0%でズームとスケーリングを無効化されたページロードがもっとも多くなっています。上位1Mサイトの30.4%が機能を無効化し、全サイトの29.4%が無効化するなど、グループごとに割合が段階的に減少しています。これは、もっとも人気のあるサイト（Cruxメトリックランキングの大きさで測定）が、アクセシビリティ機能を無効にする可能性がもっとも高いことを示しています。デスクトップについては、22.4%から27%と、すべてのランクで無効化率が低くなっています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=86675708&format=interactive",
   sheets_gid="1840321233",
   sql_file="viewport_zoom_scale_by_domain_rank.sql"
  )
}}

人気のあるサイトほどこれに該当する可能性が高く、全体として、より多くのユーザーが準拠していないモバイルサイトにアクセスしていることを意味します。

#### アクセシビリティの結論

ウェブがアクセスしやすくなれば、より多くの人々がウェブを知覚して理解してナビゲートして交流、貢献できます。ウェブアクセスの成長と必要性に対応するため、平等で包括的なアクセスを優先させなければならない。

ここで取り上げたのは、アクセシビリティのほんの一部です。ARIA、ズーム、カラーコントラストは最低限必要なものです。<a hreflang="en" href="https://www.w3.org/WAI/business-case/#increase-market-reach">W3Cのウェブアクセシビリティ・イニシアチブ</a>の調査によると、世界人口の15％（10億人以上）が認知障害を抱えていることが分かっています。さらに多くの人が未登録のまま、あるいは人生のある時点で障害を持つようになり、サイトへのアクセスに影響を与えるかもしれません。アクセシビリティは、ごく一部の人のためのものではありません。

優れたアクセシビリティの実践が不十分なため、これらのユーザーには、人間として邪魔になる技術的な障害が発生するのです。というのも、このような潜在的なユーザーに対して適切に対応することは、明らかに商業的な機会だからです。

多くの法域において、アクセシビリティは単なるグッドプラクティスではありません。

<figure>
  <blockquote>昨年は<a hreflang="en" href="https://info.usablenet.com/2020-report-on-digital-accessibility-lawsuits">米国障害者法に関連する訴訟が20%増加</a>しています。</blockquote>
<figcaption>— Web Almanac <cite><a href="./accessibility">2021年 アクセシビリティの章</a></cite></figcaption>
</figure>

モバイルウェブでのアクセシビリティについて詳しく知りたい方は、[アクセシビリティ](./accessibility)の章をご覧ください。

## モバイル検索エンジン最適化(SEO)

どんなウェブサイトでも、獲得は重要なステップです。最適化されたモバイルウェブサイトも、誰にも発見されず、訪問されなければ、悪いことに変わりはありません。

検索エンジン、ソーシャルメディア、他のウェブサイトからのリンクが主な発見経路となる可能性が高い。

検索エンジンは、多くのサイトにとって主要な獲得源であり、さらに多くのサイトにとって今もなお規模が大きいため、SEOはほとんどすべてのサイトにとって重要な検討事項となっています。

SEOではモバイルに特化した分野や懸念事項があります。

### モバイルファーストインデックス

Googleは、ウェブへのアクセス方法の主流がモバイルであることを認識し、現在では<a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-first-indexing">モバイルユーザエージェント</a>を持つウェブサイトを主にインデックスしています。2019年7月以降、すべての新規サイトがこの方法でインデックスされ、現在、ほとんどの既存サイトもモバイルファーストインデックスに移行しています。

つまり、デスクトップ端末にしか提供されないコンテンツやマークアップがある場合、googleはその部分をインデックスしなくなるのです。

### モバイルフレンドリー

<a hreflang="en" href="https://developers.google.com/search/blog/2015/04/rolling-out-mobile-friendly-update">Google</a> と <a hreflang="en" href="https://blogs.bing.com/webmaster/2015/11/12/mobile-friendly-test">Bing</a> などの検索エンジンは、モバイルフレンドリーという何らかの概念を直接ランキングシグナルとして使っています。これは主に、コンテンツがビューポートに収まるか、テキストが読みやすいか、タップ対象が適度な大きさであるかを確認するためのテストです。

Googleは<a hreflang="en" href="https://search.google.com/test/mobile-friendly">モバイルフレンドリーテスト</a>を提供しており、<a hreflang="en" href="https://www.bing.com/webmaster/tools/mobile-friendliness">Bing</a> もあなたのページが合格かどうかを診断するのに役立つとされています。

これを実現する推奨される方法は、レスポンシブWebデザインを使用することです。web.devでは、<a hreflang="en" href="https://web.dev/learn/design/">素晴らしい学習リソース</a>を提供しています。

### コアウェブバイタル＆ページエクスペリエンス

2021年7月15日、Googleは<a hreflang="en" href="https://developers.google.com/search/blog/2021/04/more-details-page-experience">ページ体験ランキングアップデート</a>を展開することを発表しました。これは、モバイルフレンドリーを含むいくつかの異なるシグナルで構成されており、主な新機能として<a hreflang="ja" href="https://web.dev/i18n/ja/vitals/">Core Web Vitals metrics</a>が追加されました。

モバイルウェブにとってとくに興味深いのは、コアウェブバイタルの部分が<a hreflang="en" href="https://support.google.com/webmasters/thread/104436075/core-web-vitals-page-experience-faqs-updated-march-2021">モバイル専用</a>で、これらの指標は今のところモバイル結果の一部のみを担っていますが、<a hreflang="en" href="https://developers.google.com/search/blog/2021/11/bringing-page-experience-to-desktop">2022年2月</a>にデスクトップへの展開が予定されていることです。

モバイルフレンドリーやコアウェブバイタルのSEOにおける役割については、[SEO](./seo#モバイルフレンドリー)の章で詳しく説明されています。

## モバイルパフォーマンス

モバイル端末は、デスクトップ端末に比べて消費電力が低く、ネットワーク接続も遅くて信頼性が、低い可能性があります。このような状況を考えると、パフォーマンスはより大きな課題であり、より優先度の高いものとなりえます。

### 読み込み性能

新しく獲得したユーザーの注意を引きつける、あるいはリピーターの注意を引きつけるには、サイトの重要なコンテンツを素早く見てもらうことから始まります。

#### 最大のコンテンツフルペイント

<a hreflang="en" href="https://web.dev/lcp/">最大のコンテンツフルペイント</a> (LCP) は、この経験を捉えるために設計された指標です（Core Web Vitalsの1つです）。ビューポートで最大の要素がレンダリングされるときの指標で、`<img>`、`<svg>`内の`<image>`、`<video>`（posterが設定されている場合）、背景画像付きのブロック要素、テキストブロックに限定されます。

LCPは2.5秒以下が好スコアとされています。

{{ figure_markup(
   image="mobile-web-largest-contentful-paint.png",
   caption='LCPのデバイス別パフォーマンス。[パフォーマンス](./performance)の章のデータです。',
   description="モバイルとデスクトップでLCPの閾値を比較した棒グラフの積み上げ。デスクトップ用サイトの60.3%が「Good」と評価されたのに対し、モバイル用サイトは45.3%にとどまりました。デスクトップの27.5%が「要改善」と評価されたのに対し、モバイルは35.2%。デスクトップで12.2%、モバイルでは19.5%が「LCPが悪い」と回答しています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=875306231&format=interactive",
   sheets_gid="1682201087",
   sql_file="../performance/web_vitals_by_device.sql"
  )
}}

このデータによると、CrUXのデータセットに記録されたモバイルページの読み込みのうち、2.5秒以下の目標を達成しているのはわずか45%で、デスクトップの60%よりはるかに低いことがわかります。

しかし、2.5秒以下の基準を満たしたのは[モバイルページの読み込みの43%](../2020/performance#デバイス別LCP)であった2020年と比べると、わずかながら改善されていることがわかります。

モバイル層に対して良好なLCPスコアを達成するためには、より大きな課題があることは明らかですが、追い求める価値のある課題です。最近の<a hreflang="en" href="https://web.dev/vodafone/">ボーダフォン</a>の調査では、LCP時間をわずか8％短縮しただけで31％ものコンバージョン増加につながったことが示されています。パフォーマンスは、収益に直接影響を与える可能性があります。

### 画像

CSSやJavaScriptなど、さまざまなアセットがモバイルのロードタイムに影響を与えます。しかし、大きな要因は画像です。

レスポンシブWebデザインのアプローチとして、デスクトップユーザーに適したネイティブサイズの画像を用意し、CSSで画面に合わせて拡大縮小することがよくあります。

#### 適切な大きさの画像

{{ figure_markup(
   caption="モバイルページの読み込みで、適切なサイズの画像が表示された割合",
   content="56.6%",
   classes="big-number",
   sheets_gid="1754517886",
   sql_file="correctly_sized_images.sql"
)
}}

2020年の58.8％から一歩後退しているのが悲しいところです。つまり、43.4%のモバイルユーザーが間違ったサイズの画像を取得していることになります。

#### レスポンシブ画像

画像も[レスポンシブに提供](https://developer.mozilla.org/ja/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images)できます。`srcset`属性と`<picture>`要素で適切なサイズと適切なフォーマットの画像を指定し、画面とデバイスにもっとも適した画像をブラウザにダウンロードさせることができます。

{{ figure_markup(
   image="mobile-web-responsive-images.png",
   caption="レスポンシブな画像を提供するために、`<picture>` と `srcset` を使用します。",
   description="棒グラフは、モバイルサイトの6.2%が`<picture>`要素を使用し（デスクトップサイトでは6.3%）、32.0%が`srcset`属性を使用して画像をレスポンシブに読み込んでいることを示しています（デスクトップサイトでは31.7%）。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1030195048&format=interactive",
   sheets_gid="1802999215",
   sql_file="picture_source_srcset_usage.sql"
  )
}}

画像を含むモバイルページの読み込みで`<picture>`要素が使われたのはわずか6.2%で、デスクトップよりわずかに低い数値でした。

画像を含むモバイルページのロードのうち、32%が `srcset` 属性を使用しています。この属性は `<picture>` 要素と `<img>` 要素の両方で使用できるため、ここでいくつかのクロスオーバーが、発生する可能性があることは言及しておく価値があるでしょう。

#### 遅延ローディング

初期ビューポートにない画像を遅延ロードさせることは、リソースを表示可能なもののロードに集中させるための良い戦略です。Chrome、Opera、そして2021年9月からAndroid版Firefox（引用元：<a hreflang="en" href="https://caniuse.com/loading-lazy-attr">caniuse.com</a>）でサポートされているネイティブのlazy-load属性は、JavaScriptの回避策なしにこれを実現できます。

{{ figure_markup(
   caption='画像を含むモバイルページのロードに `loading="lazy"` が使用されている。',
   content="18.4%",
   classes="big-number",
   sheets_gid="1889147690",
   sql_file="lazy_loading_usage.sql"
  )
}}

これは、2020年のわずか4.1％から大きく飛躍しています。

HTTP Archiveの<a hreflang="ja" href="https://httparchive.org/reports/state-of-images#imgLazy">ネイティブ画像のレイジーローディングレポート</a> を見ると、とくに `<img>` タグに属性を使用することが、同じように目覚ましい成長を示していることがわかります。

{{ figure_markup(
   image="mobile-web-native-lazy-loading-over-time.png",
   caption="遅延ローディング属性の経時的な使用状況。",
   description="HTTP Archiveデータから、モバイルページとデスクトップページで `loading='lazy'` 属性が使用されている割合を時系列で示した折れ線グラフです。線は上昇傾向にあり、2020年7月の1.4%から始まり、2021年10月の19.4%まで連動して上昇しています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=62374244&format=interactive",
   sheets_gid="1889147690"
  )
}}

この成長の原動力は、WordPressの普及にあると考えられます（引用元：<a hreflang="en" href="https://twitter.com/rick_viscomi/status/1344380340153016321?s=20">Rick Viscomiのツイッター</a>）。WordPressは、2020年8月11日に一般公開された<a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">バージョン5.5で遅延ローディングに対応</a>しました。

また、<a hreflang="en" href="https://web.dev/lcp-lazy-loading/">遅延ローディングLCP候補</a> を誤って使用すると、パフォーマンスに悪影響を及ぼす可能性があることも述べておく必要があります。折り返し位置より下の画像にのみ `loading="lazy"` を適用するようにすることが、ベストプラクティスです。

#### 画像の結論

今年、より多くのモバイルページの読み込みでサイズが、正しくない画像があったことは残念です。おそらく`<img>`要素と比較した複雑さに基づいて、`<picture>`の取り込みも低いままです。

しかし、`loading="lazy"`属性の採用は、わずか1年で大きな飛躍を遂げました。

画像は依然としてWebの重要な要素であり、それはモバイルユーザーに対しても変わりません。もしあなたのサイトが、モバイルに適した画像を提供するために利用可能ないくつかのアプローチを活用していないのであれば、これを調査する時期が来ています。

### レイアウトの安定性

一般的にフォームファクターが小さく、画面占有面積が限られているモバイルデバイスでは、予期せぬコンテンツの移り変わりがとくに気になるものです。

記事を読んでいて上に広告が表示され、今いる段落が下に飛んだり、フォントが読み込まれて目の前で変わったりするのは、不快でネガティブな体験です。

#### レイアウトの累積移動量

Core Web Vitalsの1つである <a hreflang="en" href="https://web.dev/cls/">レイアウトの累積移動量</a> (CLS) は、この種の要素のシフトの影響を把握するために設計されたメトリックです。

この指標は、インパクト・フラクションとディスタンス・フラクションを掛け合わせた計算です。インパクト・フラクションは画面の面積がどれだけ移動したかを、ディスタンス・フラクションは画面の面積がどれだけ移動したかを表しています。

CLSのスコアが0.1以下は良好、0.25以下は確かに改善、それ以上は不良と判断される

画面サイズが小さいほどずれが大きく、360×640pxの場合、この例のブロックではCLSスコアが0.22となる。

{{ figure_markup(
   gif="mobile-cls-example.gif",
   image="mobile-cls-example-static.png",
   caption="モバイルサイズの画面上にCLSを引き起こす広告を表示した画面キャプチャモックアップ。",
   description="広告の挿入により、モバイルのビューポートサイズでは画面上で比較的多くのコンテンツが移動します。",
   width=600,
   height=371,
   gif_width=197,
   gif_height=350
  )
}}

デスクトップ画面サイズでは、同じ要素が表示されてもCLSスコアは0.07にとどまります。

{{ figure_markup(
   gif="desktop-cls-example.gif",
   image="desktop-cls-example-static.png",
   caption="デスクトップサイズの画面にCLSを引き起こす広告を表示した画面キャプチャモックアップ。",
   description="広告の挿入により、デスクトップのビューポートサイズでは、画面上で比較的少量のコンテンツが移動します。",
   width=600,
   height=371,
   gif_width=600,
   gif_height=341
  )
}}

CrUXデータセットによると、モバイルページの読み込みの62%でCLSが、0.1以下であったことが示されています。

{{ figure_markup(
   image="mobile-web-cumulative-layout-shift.png",
   caption='デバイス別のCLS性能。',
   description="CLSの閾値グループをモバイルとデスクトップで比較した棒グラフの積み上げ。デスクトップ62.2%、モバイル61.6%のサイトが「良い」と評価されました。デスクトップの22.7%が「要改善」と評価されたのに対し、モバイルは21.1%。デスクトップで15.0%、モバイルでは17.3%が「CLSが悪い」と回答しています。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=776500715&format=interactive",
   sheets_gid="1682201087",
   sql_file="../performance/web_vitals_by_device.sql"
  )
}}

これは、昨年達成した43％を大きく上回るものですが直接の比較は難しく、<a hreflang="en" href="https://web.dev/evolving-cls/">2021年6月1日</a> に長寿命ページの体験をよりよく捉えるために指標を変更したので、このジャンプの一部はこれに起因する可能性があります。

### ユーザーとの対話への対応

ユーザーがサイトを利用する際、何かをクリックしてから実際に何かが起こるまでの時間が長いと、ウェブサイトやアプリが重く感じられ、遅いと感じることがあります。このような入力と動作の間の遅延は多くの場合、重いJavaScriptの処理がメインスレッドをブロックし、その処理が完了するまで、ユーザーが発行したコマンドをブラウザが処理できない状態になること起因します。

一般にモバイル機器はデスクトップやノートパソコンに比べ、はるかに低電力であるため、その影響は増幅される可能性があります。

#### 最初の入力遅延

<a hreflang="en" href="https://web.dev/fid/">最初の入力遅延</a> (FID) は、これを捉えるために設計された3つ目のCore Web Vitalメトリックです。最初のインタラクション（タップまたは要素のクリック）が発生してからブラウザが、それが起こったという処理を開始するまでの時間を測定します。タップが引き金となった可能性のある処理にかかる時間は測定しません。

FIDスコアは100ms以下が良好、300ms以上が不良となります。

{{ figure_markup(
   image="mobile-web-first-input-delay.png",
   caption='デバイス別のFID性能。',
   description="モバイルとデスクトップでFIDの閾値のグループ分けを比較した棒グラフ。デスクトップでは99.0%が「Good」と評価されたのに対し、モバイルでは90.0%。モバイルの9.8%が「要改善」と評価されました。",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1158252805&format=interactive",
   sheets_gid="1682201087",
   sql_file="../performance/web_vitals_by_device.sql"
  )
}}

心強いことに、CrUXデータセットのモバイルページロードの90%が良好なFIDスコアを獲得し、2020年の80%から上昇しました。

Chrome Speed Metricsチームは、新しい応答性メトリックについて、<a hreflang="en" href="https://web.dev/responsiveness/">いくつかの計画を共有し、フィードバックを求めています</a>。

Core Web Vitals全般について知りたい場合は、[パフォーマンス](./performance)の章にCore Web Vitalsの詳細がたくさん載っています。

### サービスワーカー

[サービスワーカー](https://developer.mozilla.org/ja/docs/Web/API/Service_Worker_API)は、モバイルデバイスに限らずオフライン機能を追加したり、キャッシュからWebアプリケーションへの読み込みをよりよく制御したりすることで、ユニークな機能を発揮します。この2つの機能は、接続性の低下や全喪失に遭遇する可能性が高いモバイルユーザーにとって、しばしばより適切なものとなります。

14.8%の事業所がサービス従事者を登録、2020年の0.9%から大きく上昇

サービスワーカーとPWA（プログレッシブWebアプリ）について詳しく知りたい方は、[PWA](./pwa)の章をご覧ください。

### モバイル性能の結論

全体として2020年に向けて一歩進んだ性能になっており、とくにレイアウトの安定性が大きく向上しています。

また、`loading="lazy"`の使用率が目覚ましく伸びていることや、サービスワーカーの普及など、良い兆候も見られます。開発者がこれらを受け入れているという事実は、パフォーマンスが真剣に受け止められていることを示すポジティブなサインです。

しかし、最大のコンテンツフルペイントの改善や画像のハンドリングは、他の分野よりも開発者が苦労しているようです。うまくいけば、<a hreflang="en" href="https://nextjs.org/docs/api-reference/next/image">next/image</a> のようなツールやライブラリが提供されます。
Next.jsのフレームワークや、WordPressのような人気のあるCMSでの採用は、開発者がこれらのペインポイントを克服するのに役立ちます。

## 結論

2021年には、明確な「モバイルウェブ」という認識は時代遅れになっています。

複数のデータソースによると、モバイルはユーザーがデジタルコンテンツとインタラクションするための多くの方法の1つであり、実際、デジタルインタラクションの大半を占めているようです。

多くのユーザーにとって、モバイルデバイスはウェブに接するための主要な、あるいは唯一の手段です。にもかかわらず、方法論、パフォーマンス戦略、アクセシビリティの原則の採用や、ブラウザでサポートされる機能の採用は低いままです。

いくつかの分野では大きな進展があり、ほとんどの業績評価指標は2020年のデータよりも改善されています。しかし、まだまだ成長の余地がある分野も残っています。

アクセシビリティは、より多くの努力と時間を費やすことが望まれる分野であり、画像のベストプラクティスはまだいくらか残っているのです。

モバイルユーザー分野の成長と規模が拡大し続ける中、多くの業界にとって、もはやモバイルウェブをサポートするためのビジネスケースを作る必要はなく、完全に受け入れ、2021年に開発者が利用できる多くのツールやテクニックを活用することが重要となっています。
