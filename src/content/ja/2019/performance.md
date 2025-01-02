---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: パフォーマンス
description: コンテンツの初回ペイント（FCP）、最初のバイトまでの時間（TTFB）、初回入力遅延（FID）を取り扱う2019 Web Almanac パフォーマンスの章。
hero_alt: Hero image of Web Almanac characters images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [rviscomi]
reviewers: [JMPerez,foxdavidj,sergeychernyshev,zeman]
analysts: [rviscomi, raghuramakrishnan71]
editors: [rachellcostello]
translators: [MSakamaki]
discuss: 1762
results: https://docs.google.com/spreadsheets/d/1zWzFSQ_ygb-gGr1H1BsJCfB7Z89zSIf7GX0UayVEte4/
rviscomi_bio: Rick ViscomiはGoogle のシニア開発プログラムエンジニアで、HTTP ArchiveやChrome UX Reportなどのウェブ透過性プロジェクトに携わり、ウェブサイトの構築方法と体験の交差点を研究しています。Rickは、<a hreflang="en" href="https://www.youtube.com/playlist?list=PLNYkxOF6rcIBGvYSYO-VxOsaYQDw5rifJ">The State of the Web</a>のホストを務めており、専門家がウェブのトレンドについて議論しています。Rickは、ウェブのパフォーマンスをテストするためのガイドである <a hreflang="en" href="https://usingwpt.com">Using WebPageTest</a> の共著者であり、<a hreflang="en" href="https://dev.to/rick_viscomi">dev.to</a> でウェブについて頻繁に執筆していますし、<a href="https://x.com/rick_viscomi">@rick_viscomi </a> の Twitter でもウェブについて書いています。
featured_quote: パフォーマンスはユーザー体験の内臓的な部分です。多くのウェブサイトでは、ページの読み込み時間を高速化してユーザー体験を向上させることは、コンバージョン率の向上につながります。逆に、パフォーマンスが悪いと、ユーザーは頻繁にコンバージョンしないし、不満でページを激怒してクリックしてしまうことさえ観察されています。
featured_stat_1: 13%
featured_stat_label_1: FCPが速いサイト
featured_stat_2: 42%
featured_stat_label_2: TTFBが遅いサイト
featured_stat_3: 40%
featured_stat_label_3: FIDが速いサイト
---

## 導入

パフォーマンスはユーザー体験で大切なものの一つです。多くのWebサイトでは、ページの読み込み時間を早くする事によるユーザー体験の向上と、コンバージョン率の上昇は一致しています。逆に、パフォーマンスが低い場合、ユーザーはコンバージョンを達成せず、不満を持ち、ページをクリックすると怒りを覚えることさえあります。

Webのパフォーマンスを定量化する方法は色々とあります。ここで一番大切なのは、ユーザーにとって特に重要な点を計測することです。ただ、`onload`や`DOMContentLoaded`などのイベントはユーザーが実際に目で見て体験できているものとは限りません。例えば、電子メールクライアントを読み込んだ時、受信トレイの内容が非同期に読み込まれる間、画面全体を覆うようなプログレスバーが表示される事があります。ここでの問題は`onload`イベントが受信ボックスの非同期読み込みの完了まで待機しないことです。この例において、ユーザーの一番大切にするべき計測値とは「受信トレイが使えるようになるまでの時間」であり、`onload`イベントに着目するのは誤解を招く可能性があります。そのために、この章ではユーザーが実際にページをどのように体験しているかを把握し、よりモダンで広く使える描画、読み込み、および対話性の計測を検討します。

パフォーマンスデータにはラボとフィールドの２種類があります。合成テストや実ユーザー測定（またはRUM）でそれらを聞いたことがあるかもしれません。ラボでパフォーマンスを測定すると、各Webサイトが共通の条件でテストされ、ブラウザー、接続速度、物理的な場所、キャッシュ状態などの状態は常に同じになります。この一貫性が保証されることで、それぞれのWebサイトを比較することができます。その反面、フィールドのパフォーマンス測定は、ラボでは決して行うことのできない無限に近い条件の組み合わせで、現実に近いユーザーのWeb体験を計測することを可能にします。この章の目的と実際のユーザー体験を理解するために、今回はフィールドデータを見ていきます。

## パフォーマンスの状態

Web Almanacにある他のほとんどの章は、<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>のデータに基づいています。ただ、実際のユーザーがWebをどのように体験するかを取得するには、違うデータセットが必要になります。このセクションでは、[Chrome UXレポート](http://bit.ly/chrome-ux-report)（CrUX）を使用しています。この情報はHTTP Archiveとすべて同じウェブサイトで構成されるGoogleの公開データセットとなっており、Chromeを使うユーザーの実際の体験を集約しています。そして体験は次のように分類されます。

- ユーザーデバイスのフォームファクタ
  - デスクトップ
  - 携帯電話
  - タブレット
- モバイル用語で言うユーザーの有効な接続タイプ(ECT)
  - オフライン
  - 遅い2G
  - 2G
  - 3G
  - 4G
- ユーザーの地理的な位置

体験は描画、読み込み、そして対話性の定量化を含めて毎月測定されます。最初に私達が見るべき指標は<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics#first_paint_and_first_contentful_paint">コンテンツの初回ペイント(First Contentful Paint)</a>(FCP)です。これはページや画像やテキストなど、ユーザーが画面として見るために必要なものが表示されるのを待つ時間です。次は、読み込み時間の指標である[最初のバイトまでの時間(Time to First Byte)](https://developer.mozilla.org/docs/Glossary/time_to_first_byte) (TTFB)です。これはユーザーがナビゲーションを行ってから、Webページのレスポンスの最初のバイトを受信するまでにかかった時間を計測したものです。そして最後に確認するフィールドの指標は<a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">初回入力遅延(First Input Delay)</a> (FID)です。これは比較的新しい指標で、読み込み以外のパフォーマンスUXの一部を表すものです。ユーザーがページのUIを操作できるようになるまでの時間、つまり、ブラウザのメインスレッドがイベント処理の準備が整うまでの時間を測定したものです。

では、それによってどのような洞察ができるのかを見てきましょう。

### コンテンツの初回ペイント(First Contentful Paint)

{{ figure_markup(
  image="fig1.png",
  caption="Webサイトの高速、適度、および低速のFCPパフォーマンスの分布。",
  description="Webサイト1000個から見た、FCPが高速、適度、低速の分布。FCPが早いサイトの分布は100%から0%までが線形になっているように見えます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=115935793&format=interactive"
  )
}}

図7.1では、FCPの体験がWeb全体でどのように分散しているかを見ることができます。このチャートは、CrUXデータセット内にある数百万のWebサイト分布を1,000個のWebサイトに圧縮しており、図の縦線一つ一つはWebサイトを表しています。このグラフは、１秒未満の高速なFCP体験、３秒以上かかる遅い体験、その中間にある適度な体験（以前は平均と言われていた）の割合で並べられています。グラフには、ほぼ100%高速な体験を備えたWebサイトと、ほぼ100%低速な体験となっているWebサイトが存在しています。その中間にある、高速、適度、及び低速のパフォーマンスが混じり合ったWebサイトは、低速よりも適度か高速に傾いており、良い結果になっています。

<aside class="note">注意：ユーザー体験の低下があった場合、その理由が何であるか突き止めるのは難しいでしょう。Webサイト自体が不十分で非効率な構築がされている可能性があるかもしれませんが、ユーザーの通信速度が遅い可能性やキャッシュが空など、他の環境要因がある可能性があります。そのため、このフィールドデータを見てユーザー体験が悪いとわかっても、理由は必ずしもWebサイトにあるとは言えません。</aside>

Webサイトが十分に**高速**かどうかを分類するために、新しい方法論である PageSpeed Insights (PSI)を使います。この方法はWebサイトのFCP体験の少なくとも75%が１秒未満でなければなりません。同様に、FCP体験がとても**低速**となる25%のWebサイトでは３秒以上かかっています。どちらの条件も満たさない場合、Webサイトのパフォーマンスは**適度**です。

{{ figure_markup(
  image="fig2.png",
  caption="高速、適度、低速のFCPラベルが貼られたWebサイトの分布。",
  description="Webサイトの13%が高速なFCPで、66%が適度のFCP、20%が低速のFCPを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=36103372&format=interactive"
  )
}}

図7.2の結果は、Webサイトの13％だけが高速と判断されています。これはまだ改善の余地があるようですが、多くのWebサイトで意味を持つコンテンツを素早く一貫して描画できています。Webサイトの３分の２は適度のFCP体験となっているようです。

デバイス毎にFCPのユーザー体験がどの様になっているかを知るために、フォームファクタ別に分類してみましょう。

#### デバイス毎のFCP

{{ figure_markup(
  image="fig3.png",
  caption="<em>デスクトップ</em> Webサイトの高速、適度、低速のFCPパフォーマンスの分布。",
  description="1,000個のデスクトップWebサイトの高速、適度、低速のFCP分布、高速なFCPの分布は100%から0%までが線形となっており、中央で少し膨らんでいます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1231764008&format=interactive"
  )
}}

{{ figure_markup(
  image="fig4.png",
  caption="<em>携帯電話向け</em> Webサイトの高速、適度、低速のFCPパフォーマンスの分布。",
  description="1,000個の携帯電話向けWebサイトの高速、適度、低速のFCP分布、高速なFCPの分布は100%から0%までに膨らみが無く、線形に見えます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=167423587&format=interactive"
  )
}}

上の図7.3と図7.4は、FCPの分布をデスクトップと携帯電話で分類しています。微妙な差ですが、デスクトップFCP分布の胴部は携帯電話ユーザーの分布よりも凸型となっているように見えます。この視覚的な近似が示すのは、デスクトップユーザーが高速なFCPにおいて全体的に割合が高いことを示しています。これを検証するために、PSIという方法を各分布に適用していきます。

{{ figure_markup(
  image="fig5.png",
  caption="高速、適度、低速FCPのラベルが付けられたWebサイトの分布。デバイスの種類で分類されています。",
  description="デスクトップとモバイルのFCP分布を示す棒グラフ。デスクトップは高速、適度、低速が17%、67%、16%となっており、モバイルは11%、66%、23%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=486448175&format=interactive"
  )
}}

PSIの分類によると、モバイルユーザーの11%と比べて、デスクトップユーザーは17%に対して高速なFCP体験が全体的に提供されています。全体的な分布を見ると、デスクトップのほうが体験が少しだけ高速に偏っていますが、低速のWebサイトは少なく高速と適度のカテゴリーが多くなっています。

Webサイトでデスクトップユーザーが高確率で携帯電話のユーザーより高速なFCP体験をするのは何故でしょう？それは結局、このデータセットはWebがどのように機能しているかという答えでしかなく必ずそう動いていると言った話では無いからです。ただ、デスクトップユーザーはキャリアの通信ではなく、WiFiのような高速で信頼性の高いネットワークでインターネット接続をしていると推測できます。この疑問に答えるために、ECTでユーザー体験がどのように違うかを調べることもできます。

#### 有効な接続タイプ毎のFCP

{{ figure_markup(
  image="fig6.png",
  caption='高速、適度、低速のFCPでラベル付けされたWebサイトの分布。<abbr title="effective connection type">ECT</abbr> で分類されています。',
  description="有効な接続タイプ毎のFCP分布棒グラフ。4Gの高速、適度、低速：14％、67％、19％。 3G：1％、38％、61％。 2G：0％、9％、90％。 低速な2G：0％、1％、99％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1987967547&format=interactive"
  )
}}

上の図7.6にあるFCP体験は、ユーザーの体験するECT毎にグループ化されています。興味深いことに、ECTの速度と高速FCPを提供するWebサイトの割合との間には相関関係があります。ECTの速度が低下すると、高速な体験の割合はゼロに近づきます。ECTが4Gのユーザーにサービスを提供しているWebサイトの14％は高速なFCPエクスペリエンスを提供していますが、そのWebサイトの19％は低速な体験を提供しています。61％のWebサイトは、ECTが3Gのユーザーに低速のFCPを提供し、ECTが2Gだと90％に、ETCが低速の2Gだと99％となっています。これらの事実から、4Gより遅い接続を持つユーザーには、Webサイトがほぼ一貫して高速のFCPを提供できていないことを示しています。

#### 地理によるFCP

{{ figure_markup(
  image="fig7.png",
  caption="高速、適度、低速FCPでラベル付を行ったWebサイトの分布を地域別に分類したもの。",
  description="最も人気があるトップ23地域のFCP分布棒グラフです。韓国は36%で最も早いWebサイトを持っています。そこから高速なWebサイトの割合は、日本28%、台湾26％、オランダ21%となり、そこから他の地域は急速に減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=792398959&format=interactive",
  width=600,
  height=940,
  data_width=600,
  data_height=940
  )
}}

最後にユーザーの地理（geo）でFCPを切り分けてみましょう。上記のグラフは、個別に多くのWebサイトを持っているトップ23の地域を表しています。これはオープンWeb全体での人気の計測です。アメリカのWebユーザーは、1,211,002の最も際立ったWebサイトにアクセスします。十分に高速なFCP体験のWebサイトの割合で地理をソートしましょう。リストのトップ3には[アジアパシフィック](https://en.wikipedia.org/wiki/Asia-Pacific)(APAC)が入っています。それは韓国、台湾、日本です。この結果から、[これらの地域では非常に高速なネットワーク接続](https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds)が使われていることが説明できます。韓国では高速のFCP基準を満たすウェブサイトが36％あり、低速と評価されているのはわずか7%です。高速/適度/低速のウェブサイトの世界的な分布はおおよそ13/66/20であり、韓国がかなり良い意味で外れ値となっています。

他のAPAC地域の話をしましょう。タイ、ベトナム、インドネシア、インドの高速Webサイトは、ほぼ10％未満です。そして、これらの地域は韓国の3倍以上低速なWebサイトと言う割合になっています。

### 最初のバイトまでの時間(Time to First Byte) (TTFB)

<a hreflang="en" href="https://web.dev/articles/ttfb">最初のバイトまでの時間</a>は、ユーザーがWebページにナビゲーションしてからレスポンスの最初のバイトを受信するまでにかかった時間の測定値です。

{{ figure_markup(
  image="nav-timing.png",
  caption="ページナビゲーションのイベントとNavigation Timing API の図表。",
  description="ページの読み込みにおけるネットワークフェーズのシーケンスを示す図：startTime（promptForUnload）、リダイレクト、AppCache、DNS、TCP、リクエスト、レスポンス、処理、読み込み。",
  width=2580,
  height=868
  )
}}

TTFBとそれに影響する多くの要因を説明するために、[Navigation Timing APIの仕様](https://developer.mozilla.org/docs/Web/API/Navigation_timing_API)から図を借りました。上の図7.8は`startTime`から`responseStart`までの間を表しており、`unload`、`redirects`、`AppCache`、`DNS`、`SSL`、`TCP`などのサーバー側のリクエスト処理に費やす全てを含んでいます。このようなコンテキストを考慮して、ユーザーがこの数値をどのように体験しているかを見てみましょう。

{{ figure_markup(
  image="fig9.png",
  caption="WebサイトのTTFBパフォーマンス、高速、適度、低速の分布。",
  description="Webサイト1,000個の高速、適度、低速のTTFBの配布。 高速TTFBの分布は、10番目まで早い割合で、そして約90％から50％に急速に低下します。 その後分布は50％から0％に徐々に減少し、最後の1割は底辺を這います。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=444630188&format=interactive"
  )
}}

図7.1のFCPチャートと同様に、これは高速TTFB毎に並べられた代表的な1,000個の値のサンプルのビューです。 <a hreflang="en" href="https://developers.google.com/speed/docs/insights/Server#recommendations">高速TTFB</a>は0.2秒（200ミリ秒）未満、低速TTFBは1秒以上、その間はすべて適度です。

高速の割合の曲がり方を見ると、形はFCPとかなり異なります。75％を超える高速なTTFBを持つWebサイトは非常に少なく、25％を下回るWebサイトが半分以上となっています。

以前にFCPで使用したPSI方法論からインスピレーションを貰って、TTFB速度のラベルを各Webサイトに適用しましょう。ウェブサイトが75％以上のユーザー体験に対して高速なTTFBを提供する場合、**高速**とラベル付けされます。それ以外に、25％以上のユーザー体験に対して**低速** なTTFBを提供するものを、低速とします。この条件のどちらでもないものを**適度**とします

{{ figure_markup(
  image="fig10.png",
  caption="TTFBが高速、適度、低速としてラベル付けされたWebサイトの分布。",
  description="Webサイトの2%が高速なTTFBを、56%が適度のTTFBを、42%が低速なTTFBとなっていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=926985367&format=interactive"
  )
}}

Webサイトの42%で低速のTTFB体験となっています。TTFBは他のすべてのパフォーマンス値の妨げになるため、この値はとても重要です。_定義上は、TTFBに1秒以上かかる場合、ユーザーは高速なFCPを体験できない可能性があります_。

#### TTFB by geo

{{ figure_markup(
  image="fig11.png",
  caption="高速、適度、低速のTTFBそれぞれでラベル付けされたWebサイトの分布。地域別に分類されています。",
  description="最も人気のあるトップ23地域のTTFB分布の棒グラフ。韓国は14%で特に早いWebサイトを持っています。そこから、早いWebサイトの割合は台湾7%、日本5%、オランダ4%となり、他の地域では急速に減少していきます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=685447534&format=interactive",
  width=600,
  height=940,
  data_width=600,
  data_height=940
  )
}}

次に、さまざまな地域で、高速なTTFBをユーザーに提供しているWebサイトの割合を見てみましょう。韓国、台湾、日本のようなAPAC地域は依然として世界のユーザーを上回っています。しかし、どの地域も15%を超えてた高速なTTFBとなっているWebサイトはありません。インドでは、高速TTFBとなっているWebサイトは1%未満で、低速なTTFBとなっているWebサイトは79%となっています。

### 初回入力遅延（First Input Delay）

最後に確認するフィールド値は<a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">初回入力遅延(First Input Delay)</a>(FID)です。この値は、ユーザーがページのUIを最初に操作してから、ブラウザのメインスレッドでイベントの処理が可能になるまでの時間です。この時間には、アプリケーションへの実際の入力処理の時間は含まれないことに注意してください。最悪の場合は、FIDが遅いとページが応答しなくなり、ユーザー体験は苛立たしいものとなってしまいます。

いくつかのしきい値を定義することから始めましょう。新しいPSI手法によると、**高速**なFIDは100ミリ秒未満です。これによりアプリケーションは、入力イベントを処理しユーザーへの応答の結果が瞬時に感じるのに十分な時間を与えることができます。**低速**なFIDは300ミリ秒以上となっており、その間はすべて**適度**にあたります。

{{ figure_markup(
  image="fig12.png",
  caption="Webサイトの高速、適度、低速のFIDパフォーマンスの分布。",
  description="Webサイト1,000個の高速、適度、低速のFID配布。75%を超える高速なFIDの分布は、4分の3でもWebサイトがあり、その後急速に0％に低下します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=60679078&format=interactive"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
貴方はいま難題を抱えています。この表はWebサイトの高速、適度、低速のFID体験の分布を表しています。これは以前のFCPとTTFBの表とは劇的に異なります。([図7.1](#fig-1)と[図7.9](#fig-9)をそれぞれ見る).高速FIDの曲線は100%から75%にゆるやかに下っていき、その後急降下します。FIDの体験は、ほとんどのWebサイトでほぼ高速になっています。

{{ figure_markup(
  image="fig13.png",
  caption="高速、適度、低速のTTFBでラベル付けされたWebサイトの分布。",
  description="40％のWebサイトが高速なFID、45％が適度のFID、15％が低速のFIDであることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1828752871&format=interactive"
  )
}}

十分に高速や低速のFIDとなるWebサイトのラベル付けを行うため、PSI方法論はFCPと少しだけ異なる方法を取ります。**高速**なサイトと定義するのは、FID体験の95％以上を高速と定める必要があります。遅いFID体験となる5％のサイトを**遅い**として、そのほかの体験を**適度**とします。

以前の測定と比較して、集計されたFIDパフォーマンスの分布は低速よりも高速および適度の体験に大きく偏っています。Webサイトの40%でFIDが早く、FIDが遅いと言えるのは15%だけです。FIDが対話性の計測であるという性質は、ネットワーク速度によって制限される読み込みの計測と違い、パフォーマンス特性の全く異なる方法になります。

#### デバイス毎のFID

{{ figure_markup(
  image="fig14.png",
  caption="<em>デスクトップ</em> WebサイトのFIDパフォーマンスの高速、適度、低速の分布。",
  description="デスクトップWebサイト1,000個の高速、適度、低速FIDの配布。 Webサイトの最速の4分の3で、高速FIDの分布は100％から90％にかけて非常にゆっくりと減少して、その後高速FIDは75％まで減少します。 ほぼすべてのデスクトップWebサイトは、75％以上の高速なFID体験を備えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=16379508&format=interactive"
  )
}}

{{ figure_markup(
  image="fig15.png",
  caption="<em>携帯電話向け</em> WebサイトのFIDパフォーマンスの高速、適度、低速の分布。",
  description="モバイルWebサイト1,000個の高速、適度、低速FIDの配布。 高速なFIDの分布は着実に減少していますが、デスクトップよりもはるかに速く減っています。 ウェブサイトの4分の3までが75％となる高速に達していますが、その後すぐに0％に低下します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=519511409&format=interactive"
  )
}}

FIDをデバイスで分類してみると、この2つはまったく別の話となるようです。デスクトップユーザーの殆どは常に高速なFIDで楽しめているようです。まれに遅い体験をさせられるWebサイトがあるかもしれませんが、結果としては圧倒的に高速となっています。一方モバイルのユーザーは2種類の体験に大別できます。かなり高速(デスクトップほどではないが)か、全く早くないのどちらかとなるようです。後者はWebサイトの10%のみ体験しているようですが、これは大きな違いでしょう。

{{ figure_markup(
  image="fig16.png",
  caption="高速、適度、低速FIDとしてラベル付けされたWebサイトの分布。デバイス種類別に分類されています。",
  description="デスクトップとモバイルFID分布の棒グラフ。 デスクトップは高速、適度、低速がそれぞれ82％、12％、5％。 モバイルの場合26％、52％、22％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1533541692&format=interactive"
  )
}}

PSIラベルをデスクトップと携帯電話の体験に適用してみると、差分が非常に明瞭になります。デスクトップユーザーが経験するWebサイトの82％はFIDが高速であるのに対し、低速は5％だけです。モバイルで体験するWebサイトは、26％が高速であり、22％が低速です。フォームファクターは、FIDなどの対話性計測の成果に大きな役割を果たします。

#### 有効な接続タイプ別のFID

{{ figure_markup(
  image="fig17.png",
  caption='<abbr title="effective connection type">ECT</abbr>によって分類された高速、適度、低速FIDとしてラベル付けされたWebサイトの分布',
  description="有効な接続タイプ毎のFID分布の棒グラフ。4G高速、適度、低速がそれぞれ41％、45％、15％。3G：22％、52％、26％。 2G：19％、58％、23％。 低速な2G：15％、58％、27％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1173039776&format=interactive"
  )
}}

一見、FIDはCPUの動作速度が影響するように思えます。性能の悪いデバイスを使うと、ユーザーがWebページを操作しようとしたときに待ち状態になる可能性が高いと考えるのは自然でしょうか？

上記のECTの結果からは、接続速度とFIDパフォーマンスの間に相関関係があることが示されています。ユーザーの有効な接続の速度が低下すると、高速なFIDを体験するWebサイトの割合も低下しています。4GのECTを使うユーザーがアクセスするWebサイトの41%は高速なFIDで、3Gは22%、2Gは19%、低速な2Gは15%です。

#### FID by geo

{{ figure_markup(
  image="fig18.png",
  caption="高速、適度、低速FIDでラベル付けされたWebサイトの分布を地域別に分類したもの。",
  description="最も人気のある上位23の地域のFID分布の棒グラフ。最速のWebサイトは韓国の69％です。そこから高速なWebサイトの割合は、オーストラリア55％、アメリカ合衆国52％、カナダ51％となり、他の地域で確実に減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=11500240&format=interactive",
  width=600,
  height=940,
  data_width=600,
  data_height=940
  )
}}

この地理的な位置によるFIDの内訳では、韓国はまたもや他のすべてよりも抜きん出ています。しかし、トップを占める地域にはいくつか新しい顔ぶれが現れています。次に現れるのはオーストラリア、米国、カナダとなっており、50％以上のWebサイトが高速なFIDとなっています。

他の地域固有の結果と同様に、ユーザー体験に影響を与える可能性のある要因は多数あるでしょう。例えば、より裕福な地理的条件が揃う地域に住んでいる人々は、より高速なネットワーク・インフラを購入でき、デスクトップも携帯電話もお金をかけてハイエンドなものを持っている率は高くなる可能性があります。

## 結論

Webページの読み込み速度を定量化することは、単一の計測では表すことのできない不完全な科学です。従来の`onload`等を計測する計測する方法は、ユーザー体験とは関係のない部分まで計測してしまい、本当に抑えるべき点を見逃してしまう可能性があります。FCPやFIDなどのユーザーの知覚に相当する計測は、ユーザーが見たり感じたりする内容を着実に伝達できます。ただそれでも、どちらの計測も単独で見てはページ全体の読み込み体験が高速なのか低速かについての結論を導き出すことはできません。多くの計測値を総合的に見ることでのみ、Webサイト個々のパフォーマンスとWebの状態を理解することができます。

この章で表されたデータから、高速なWebサイトとにするためには多くの設定されるべき目標と作業があることを示しています。確かなフォームファクター、効果的な接続の種類、そして地理にはユーザー体験の向上と相関しますが、低いパフォーマンスとなる人口の統計も組み合わせる必要があることを忘れてはいけません。殆どの場合、Webプラットフォームはビジネスで使われています。コンバージョン率を改善してより多くのお金を稼ぐことは、Webサイトを高速化する大きな動機になるでしょう。最終的に、すべてのWebサイトのパフォーマンスとは、ユーザーの邪魔をしたり、イラつかせたり、怒らせたりしない方法で、ユーザーにより良い体験を提供することです。

Webがまた一つ古くなり、ユーザー体験を測定する能力が徐々に向上するにつれて、開発者がより総合的なユーザー体験を捉えて計測された値を身近に思えるようになることを楽しみにしています。FCPは有用なコンテンツをユーザーに表示するタイムラインのほぼ最初部分であり、それ以外にも<a hreflang="en" href="https://web.dev/articles/lcp">Large Contentful Paint</a>（LCP）と呼ばれる新しい計測値が出現して、ページの読み込みがどのように認識されるかの可視性が向上しています。<a hreflang="en" href="https://web.dev/articles/cls">Layout Instability API</a>は、ページの読み込み以降でユーザーが不満を持つ体験がある事を新たに垣間見せてくれました。

こういった新しい計測が出来るようになった2020年のWebは、さらに透明性が高まって理解が深まり、開発者がパフォーマンスを改善するための有意義な進歩を遂げることで、より良いユーザー体験を提供できるでしょう。
