---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/
title: 持続可能性
description: 2022年版Web Almanacの持続可能性の章では、ウェブページの環境への影響、その原因、そしてそれらをどのように削減するかについて説明しています。
authors: [ldevernay, gerrymcgovernireland, timfrick]
reviewers: [mrchrisadams, cqueern, Djohn12]
analysts: [fershad, camcash17, 4upz]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1wU3SjB8XYkbaqxYt8CNtbmDbjCcYZ8m5kiYof7uyI5k/edit
ldevernay_bio: ローラン・デヴェルネは、<a hreflang="en" href="https://greenspector.com/en/home/">Greenspector</a>のデジタル節約エキスパートです。彼のブログは、<a hreflang="en" href="https://ldevernay.github.io/">個人的なもの</a>や<a hreflang="en" href="https://greenspector.com/en/blog-2/">会社のためのもの</a>がありますが、ほぼ常にウェブの持続可能性についてです。これにより、彼は熱心な支持者であるとも、一途なマニアであるとも言えます。
gerrymcgovernireland_bio: ジェリーは8冊の本を出版しています。最新作である<a hreflang="en" href="https://gerrymcgovern.com/books/world-wide-waste/">World Wide Waste</a>は、デジタルが環境に与える影響を検証しています。彼は、人々にとって本当に重要なことを特定するのに役立つ研究方法である<a hreflang="en" href="https://gerrymcgovern.com/books/top-tasks-a-how-to-guide/">Top Tasks</a>を開発しました。
timfrick_bio: <a hreflang="en" href="https://www.mightybytes.com/teammember/tim-frick/">Tim Frick</a>は1998年にデジタルエージェンシー<a hreflang="en" href="https://www.mightybytes.com/">Mightybytes</a>を設立し、非営利団体、ソーシャルエンタープライズ、目的を持った企業が問題を解決し、その影響を増幅し、測定可能なビジネス成果を達成するのを支援しています。Mightybytesは、善のためにビジネスを使う<a hreflang="en" href="https://www.mightybytes.com/b-corporation/">認定Bコーポレーション</a>です。認定Bコーポレーションは、社会的および環境的パフォーマンス、透明性、説明責任のもっとも厳しい検証基準を満たしています。Timは4冊の著書を持ち、その中には<em><a hreflang="en" href="https://www.oreilly.com/library/view/designing-for-sustainability/9781491935767/">Designing for Sustainability&colon; A Guide to Building Greener Digital Products and Services</a></em>が含まれます。熟練のパブリックスピーカーとして、彼は定期的に会議で発表し、持続可能なデザイン、影響の測定、デジタル経済での問題解決に関するワークショップを提供しています。また、<a hreflang="en" href="https://www.climateride.org/">Climate Ride</a>、<a hreflang="en" href="https://www.illinoisbcorps.org/">B Local Illinois</a>、<a hreflang="en" href="https://greatlakes.org/">Alliance for the Great Lakes</a>など、いくつかの非営利団体の理事を務めてきました。
featured_quote: これは持続可能性についての最初のWeb Almanacの章であり、世界中での干ばつ、熱波、その他の気候イベントといった事象とともに、象徴的な年に行われます。すでにいくつかのベストプラクティスが採用され、徐々に広がりつつあります。しかし、まだ行うべきことはたくさんあります。これらのアクションのいくつかは実装が容易ですが、それでも大きな利益をもたらす可能性があります。また、ベストプラクティスと対策は、できれば実際のデバイス上で、持続可能性の継続的な改善には不可欠です。
featured_stat_1: 10%
featured_stat_label_1: より持続可能なホスティングに依存するウェブサイト
featured_stat_2: 2.76
featured_stat_label_2: 90パーセンタイルのウェブページのGHG排出量（g eqCO2）
featured_stat_3: 26%
featured_stat_label_3: キャッシュを一切使用していないモバイルウェブサイト
---

## 序章

2019年に<a hreflang="en" href="https://www.greenit.fr/environmental-footprint-of-the-digital-world/">GreenIT.frは、34億台の機器と41億人のインターネットユーザーが存在すると推定しました</a>。そのため、デジタル世界が人類の炭素足跡に与える影響は、一次エネルギー消費および温室効果ガス排出の約4％、水消費の0.2％、電気消費の5.5％を占めるかもしれません。

もう1つの重要な指標は、非生物資源（金属などの「生きていない」資源）の枯渇への寄与です。私たちが使用するすべてのデバイスは製造のために材料を必要とします。そのため、ユーザー機器の製造は環境への影響のもっとも重要な源と考えられており、ほとんどがまったくリサイクルされていない機器の使用終了がこれに続きます。これはデータセンターやネットワーク、さらにはユーザー機器の使用よりもはるかに影響が大きいです。一部のメーカーからの努力にもかかわらず、インジウム、銅、金などの必要な材料の枯渇のため、今後数年間で状況は悪化する可能性が高いです。

GreenIT.frの前述の研究によると、デジタルサービスの全体的な影響は年々着実に増加しており、2010年から2025年の間に2倍または3倍になる可能性があります。これを回避するためには、少なくとも軽減するためには、私たちは所有する接続デバイスの数を減らし、できるだけ長く各デバイスを保持する必要があります：購入するのではなく修理すること。これは、とくにスマートフォンなど、すぐに古くなってしまうように見えるデバイスにとって厳しいかもしれません：ウェブサイトやアプリケーションのロードに時間がかかるほど、バッテリーの持ちが悪くなります。

デジタルサービスの影響を減らし、デジタルサービスを無形で環境に優しいものとして考える方法を変えることができます。

収集されたすべてのデータを考慮すると、Web Almanacはウェブサイト全体の環境への影響を評価するのに適した場所のようです。この旅の中で、ベストプラクティスを通じてそれらをどのように減らすか、そしてこれらがどれだけ広く採用されているかも見ていきます。

このために、私たちは次のことを区別します。

- 節度：必要なときにのみ何かを実装すること。これはデジタル全体（本当に接続されたおむつが必要ですか？）、機能（ホームページにソーシャルメディアのフィードは役立ちますか？）、またはコンテンツ（装飾的な画像、ビデオなど）である可能性があります。あなたのウェブサイト上のすべてが有用で、使用されている、使いやすい（そして再利用可能）かどうか自問してください。
- 効率：節度を考慮した後、ウェブサイト上に残るもののサイズや影響をどのように減らすか。ウェブサイトの場合、これは主に縮小、圧縮、キャッシングなどの技術的最適化を通じて行われます。

始めるためのオンライン活動。

- <a hreflang="en" href="https://learninglab.gitlabpages.inria.fr/mooc-impacts-num/mooc-impacts-num-ressources/Partie3/Activites/Capsule_Partie3_4_AgirUtilisateur/story.html">あなたはエコ責任あるインターネットユーザーですか？</a>
- <a hreflang="en" href="https://learninglab.gitlabpages.inria.fr/mooc-impacts-num/mooc-impacts-num-ressources/Partie3/Activites/Capsule_Partie3_3_Mesurer/story.html">あなたのインターネット閲覧の影響は何ですか？</a>
- <a hreflang="en" href="https://learninglab.gitlabpages.inria.fr/mooc-impacts-num/mooc-impacts-num-ressources/Partie3/Activites/Capsule_Partie3_2_Mesurer/indexEn.html">ウェブページを構成するさまざまな要素の重量比較</a>

この旅に役立つリソースは以下のものがあります:

- ベストプラクティスのリポジトリ: <a hreflang="fr" href="https://github.com/cnumr/best-practices/">115 bonnes pratiques</a>, <a hreflang="en" href="https://gr491.isit-europe.org/en/">Handbook of sustainable digital services</a>.
- 書籍とウェブサイト: <a hreflang="en" href="https://sustainablewebdesign.org/">Sustainable Web Design</a>.
- オンラインコース: <a hreflang="en" href="https://www.isit-academy.org/">INR - Sustainable IT</a>, <a hreflang="en" href="https://learninglab.inria.fr/en/mooc-impacts-environnementaux-du-numerique/">Environmental impact of digital services</a>, <a hreflang="en" href="https://docs.microsoft.com/en-us/learn/modules/sustainable-software-engineering-overview/">Principles of Sustainable Software Engineering</a>.

### 制限と仮定

すべてのベストプラクティスを網羅するわけではなく、利用可能な指標はそれらすべてをカバーすることができません。指標は、特定のウェブサイトに不必要な機能があるか、または一部の画像が純粋に装飾的であるかどうかを教えてくれません。このような考慮事項はこの章の範囲を超えていますが、まだできることはたくさんあります。そして、Lighthouseがさらに多くの種類の監査を提供するにつれて、新しい指標が利用可能になると期待できます。

ここでの環境指標は炭素排出のみですが、水消費、土地利用、非生物資源消費などの他の指標も考慮すべきです。これは<a hreflang="en" href="https://learninglab.gitlabpages.inria.fr/mooc-impacts-num/mooc-impacts-num-ressources/en/Partie3/FichesConcept/FC3.3.1-ACVservicesnumeriques-MoocImpactNum.html?lang=en">LCA（ライフサイクルアセスメント）</a>の正確なポイントです。しかし、そのような操作には専門知識、多くの情報、時間が必要です。現在、一部の構造は、より少ない指標と情報を組み合わせて妥協を図っており、LCI（ライフサイクルインベントリ）を使用しています。これにより、環境への影響評価をより手頃な価格でアクセスしやすく（たとえばCI/CDまたはモニタリングでの繰り返し可能な）行うことができますが、あなたが行う必要がある仮定を制御下に置くことができます。

ページで収集された指標のみを使用しますが、デジタルサービスの環境への影響を評価するためには、ユーザージャーニー全体の指標を収集する方が正確かもしれません。たとえば、電子商取引サイトでは、ユーザーが記事を購入して支払いをすることを考慮する方がよいでしょう。

### 交差点環境問題

持続可能性は、1987年のブルントランド委員会による初期の定義以来、大きく進化しました。現在では、その中核となる環境に焦点を当てつつ、交差する社会的およびガバナンスの問題（"ESG"の"S"と"G"）を取り入れています。より責任ある持続可能なインターネットは、これを反映すべきです。

言い換えれば、デジタルの持続可能性は排出量だけに焦点を当てることはできません。気候変動は大きな要因ですが、それを<a hreflang="en" href="https://qz.com/845206/renewable-energy-human-rights-violations/">不公平な解決策を正当化するため</a>や<a hreflang="en" href="https://www.iisd.org/system/files/publications/green-conflict-minerals.pdf">不平等を助長するため</a>に使用することはできません。[PDF]それは気候 _正義_ に基づいていなければなりません。

この目的のために、デジタル製品やサービスを設計する際には、以下の交差する問題を念頭に置いてください:

- **アクセシビリティ:** コンテンツへの障壁を取り除くことで、あなたのウェブサイトはより使いやすく、アクセスしやすくなります。これは、障害を持つユーザーを含むユーザーがタスクを達成するために回り道をしなくて済むため、環境への影響も改善します。
- **プライバシー:** 侵入的でないウェブサイトは、ユーザーにデータのコントロールを与え、共有したいものを選択させることで、より良いものです。プライバシーに焦点を当てたウェブサイトは、追跡、保存、維持するデータが少ないため、通常環境にも優しいです。
- **誤情報/偽情報:** 人々は質問に答えるためにインターネットを利用します。誤情報（非故意的）と偽情報（故意的）を含むコンテンツは、ユーザーが効率的にこれを行う能力を損ないます。
- **注意経済:** <a hreflang="en" href="https://blog.mozilla.org/en/internet-culture/mozilla-explains/deceptive-design-patterns/">欺瞞的なパターン</a>を避けることで、ユーザーを集中させ、無意味なブラウジングや最初の目的からの逸脱を減らします。
- **セキュリティ:** 持続可能性を目指すことは外部リソースが少なく、機能が少ないなど、ウェブサイトの攻撃対象を減らすことで、セキュリティにも役立ちます。

これらはすべて、デジタル持続可能性の原則に沿った<a hreflang="en" href="https://www.mightybytes.com/blog/what-is-corporate-digital-responsibility/">企業デジタル責任</a>へのより広範な組織的アプローチの一部です。

### ウェブの環境への影響を理解する

インターネットはこれまでに存在した最大で、もっともエネルギー集約的な機械です。インターネットを作成し維持するためには、膨大な物質入力が必要です。1台のサーバーは製造中に1トン以上のCO2を引き起こすことがあります。ラップトップは製造に300kgのCO2を引き起こし、1,200kgの原材料の採掘につながります。持続可能な採掘というものは存在しません。

インターネットの大部分のエネルギーと廃棄物はデバイス自体に組み込まれていますが、インターネットの運用に必要なエネルギーも無視できません。データは本質的に無料で、私たちが望むだけ保存できると常にマーケティングされていますが、データの保存と処理には実際の、急速に増加するエネルギー要求があります。たとえば2015年、アイルランドのデータセンターは電力の5％を消費していましたが、2021年には14％に増加し、アイルランドの農村地域のすべての家庭や建物の需要を上回りました。

ウェブの持続可能性を高めるために、デバイスのより良い管理に焦点を当て、ウェブサイトやアプリと対話するために使用されるデバイスに可能な限りストレスをかけないようにすることで、設計および開発を進めることができます。私たち自身のデバイスに関しては、デバイスの寿命とエネルギー消費に焦点を当てる必要があります。コンピューターの稼働寿命が長ければ長いほど、製造中に引き起こされた損害を償却できます。この考えの頂点は、オープンソースになり、Linuxのようなオペレーティングシステムを使用してデバイスの寿命を延ばすことです。オープンソースは、再利用と共有に焦点を当てることで、元々のデジタル持続可能性の哲学です。それでも、持続可能性のベストプラクティスの実装を防ぐべきではありません。

設計および開発プロセス中に消費されるエネルギーが少なければ少ないほど良いです。コードやコンテンツを再利用できるなら、それは素晴らしいアイデアです。最小限のワット数を使用してください。ラップトップはデスクトップよりもはるかにエネルギー効率が良いです。たとえば、大画面はラップトップと同じくらいのエネルギーを消費する可能性があるため、避けるべきです。エネルギー消費を減らすことは良いことです。

人気があり、需要の高いウェブサイトやアプリの場合、エネルギーと廃棄物の影響の最大98％がユーザーのスマートフォンやラップトップで発生します。小さな節約が大きな違いを生むことがあります。ダニー・ヴァン・クーテンは、200万のウェブサイトで使用されるWordPressのMailchimpプラグインを開発しました。<a hreflang="en" href="https://raidboxes.io/en/blog/wordpress/wordpress-plugin-co2/">彼はコードを20KB削減し、それが月間59,000kgのCO2の削減につながったと推定しています</a>。

## ウェブサイトの環境への影響を評価する

Ecograder、Website Carbon、Ecoping、CO2.jsなど、いくつかの利用可能なツールですでに共有されている<a hreflang="en" href="https://sustainablewebdesign.org/calculating-digital-emissions/">方法論を採用しました</a>。これにより、データ転送量（たとえば、ページの重さ）に基づいて温室効果ガス排出量を推定します。

コミュニティは<a hreflang="en" href="https://marmelab.com/blog/2022/04/05/greenframe-compare.html">この話題について合意に達するのにまだ苦労しています</a>。ここで利用可能な指標を考慮すると、これが最良の妥協案と思われます。しかし、すべての人がこれに同意するわけではなく、この方法論は今後数ヶ月から数年の間に進化するべきであり、おそらく進化するでしょう。

そこで、ページの重さの概要から始め、次に炭素排出量の計算に進みます。

### ページの重さ

ページの重さは、ウェブページにアクセスするために転送されるデータ量を表します（HTTPリクエストに基づいてのみ）。前述のように、ここでは温室効果ガス排出量を計算するための代理指標として使用されます。

この指標はできるだけ低く保つことが推奨されます。始めるときは1 MBが最大ですが、<a hreflang="en" href="https://infrequently.org/2021/03/the-performance-inequality-gap/">究極の閾値は500 kBであるべきです</a>。

これについての詳細は、[Page Weight](./page-weight)の章を参照してください。

{{ figure_markup(
  image="kilobytes-number-by-percentile.png",
  caption="パーセンタイル別のキロバイト数",
  description="90パーセンタイルでは、デスクトップのウェブページは9 MBを超え、モバイルのウェブページは8 MBを超えます。75パーセンタイルでは、デスクトップのウェブページは4.5 MBを超え、モバイルは約4 MBです。50パーセンタイルでは、デスクトップのウェブページは2.5 MB未満、モバイルは2 MB以上となっています。25パーセンタイルでは、デスクトップは1 MB以上、モバイルは1 MB未満です。最後に、10パーセンタイルでは、ページの重さはデスクトップで約0.5 MB、モバイルで0.4 MBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=2123741324&format=interactive",
  sheets_gid="1911144863",
  sql_file=""
) }}

モバイルとデスクトップのページ重量を比較すると、その差が小さいことがわかりますが、これは意外なことです。メディアは画面のサイズに応じて適切なサイズと形式で提供されるべきですが、ここではそうではないかもしれません。

90パーセンタイルでは、デスクトップページは9 MBを超え、モバイルページは8 MBを超えています。推奨される閾値500 kBからはかけ離れています。この閾値以下のページを見つけるには、10パーセンタイルに到達する必要があります。寛大な気持ちで1 MBを目指す場合、これは25パーセンタイルの周辺で見つかるかもしれません。まだまだ長い道のりがあります…

### 炭素排出量

<p class="note">注: 「炭素排出量」という概念は単純化されています。ここでは温室効果ガス排出量を考慮しており、単に炭素排出量のみではありません。</p>

{{ figure_markup(
  image="carbon-emissions-by-percentile.png",
  caption="パーセンタイル別の炭素排出量（g）",
  description="この棒グラフは、90パーセンタイルでデスクトップウェブページが3.09g、モバイルページが2.76gの炭素を排出していることを示しています。75パーセンタイルではデスクトップページが1.59g、モバイルページが1.38gを排出。50パーセンタイルではデスクトップで0.79g、モバイルで0.69g。25パーセンタイルではデスクトップページが0.39g、モバイルページが0.34gを排出。最後に、10パーセンタイルではデスクトップページが0.18g、モバイルページが0.15gを排出しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=568360340&format=interactive",
  sheets_gid="1911144863",
  sql_file=""
) }}

ウェブサイトの炭素排出量はモバイルとデスクトップで非常に近いです。10パーセンタイルでは非常に低く（約0.15 g eqCO2、これは<a hreflang="fr" href="https://datagir.ademe.fr/apps/mon-impact-transport/">熱車で1メートル未満に相当</a>）。90パーセンタイルでは最大2.76 g eqCO2に達し（熱車で少し14メートル以上に相当）。

これは多くないように思えますが、各ウェブサイトは毎月何千もの訪問者を獲得し、場合によってはさらに多くの訪問者を獲得することを念頭に置く必要があります（時にはそれ以上）。グラフで見るのは1ページを1回訪問したときの排出量です。すべてのウェブサイトの毎月の環境への影響は積み上がります。

さらに追加のグラフ: コンテンツタイプ別のパーセンタイルごとの排出量。

{{ figure_markup(
  image="percent-of-total-emissions-by-type-mobile.png",
  caption="タイプ別の総排出量のパーセンタイルごとの割合（モバイル）",
  description="デスクトップの異なるコンテンツタイプがパーセンタイルごとの総ページ炭素排出量に占める割合を示す棒グラフ。90パーセンタイルではHTMLコンテンツが総排出量の約1.8%を占め、JavaScriptが18.1%未満、CSSが約3.4%、画像が約72.3%、フォントが総排出量の4.5%を占めます。75パーセンタイルでは、HTMLが1.8%、JavaScriptが23.4%、CSSが約3.8%、画像が約65.7%、フォントが総排出量の5.2%を占めます。50パーセンタイルでは、HTMLが1.9%、JavaScriptが30%、CSSが約4.4%、画像がほぼ57.4%、フォントが総排出量の6.3%を占めます。25パーセンタイルでは、HTMLが2.4%、JavaScriptが38.8%、CSSが約5.2%、画像が48.3%、フォントが総排出量の5.3%を占めます。10パーセンタイルでは、HTMLが3.8%、JavaScriptが53.4%、CSSが約3.6%、画像が39.2%、フォントが0%の総排出量を占めます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=141071996&format=interactive",
  sheets_gid="1911144863",
  sql_file=""
) }}

画像とJavaScriptは影響が大きいようですが、上位パーセンタイルに行くにつれて画像の影響がさらに大きくなります。ただし、炭素排出量の計算にはデータ転送のみを考慮していることに注意してください。通常、JavaScriptの処理は画像よりも影響が大きいです。JavaScriptファイルをダウンロードしたあとでも、それらを処理する必要があり、時にはページの再読み込みや他のリソースの取得を行うことがあります。それにもかかわらず、このグラフはこれらの影響を減らす必要性を強調しています。これは画像に関しては後の章で見るように、かなり簡単かもしれません。JavaScriptの場合はもっと難しいかもしれませんが、最小化、圧縮、またはそれへの依存を減らすなどの技術的な最適化がいくつかあります。これについても後で詳しく説明します。

### リクエスト数

ページを読み込むためにファイルが必要な場合、リクエストが発行されます。このため、リクエストはネットワークとサーバーに与えるページの影響を表すのに役立ち、これが環境への影響を計算するためにときどき使用される理由です。リクエストを分析することで、可能な最適化を見つけることができます。これについては、さまざまなタイプのアセットと外部リクエストを議論する際に考慮します。

リクエストの数は最小限に抑えるべきです。25未満という上限を設けることはかなり良いスタートです。しかし、トラッカーなどがしばしばその目標を達成するのを難しくしています。

{{ figure_markup(
  image="number-of-requests-by-percentile.png",
  caption="パーセンタイル別のリクエスト数",
  description="この棒グラフは、90パーセンタイルでデスクトップのページあたり184リクエスト、モバイルで168リクエストがあることを示しています。75パーセンタイルではデスクトップで121リクエスト、モバイルで111リクエストです。50パーセンタイルではデスクトップで76リクエスト、モバイルで70リクエストに減少します。25パーセンタイルではデスクトップで45リクエスト、モバイルで41リクエストです。最後に10パーセンタイルではデスクトップで25リクエスト、モバイルで23リクエストが見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=843262877&format=interactive",
  sheets_gid="174962437",
  sql_file=""
) }}

モバイルとデスクトップのリクエスト数を比較すると、またしてもわずかな違いが見られますが、そうあるべきではありません。25 HTTPリクエストの閾値以下のページを見つけるには、再び10パーセンタイルに到達する必要があります。

それでは、どのコンテンツタイプが原因でしょうか？

{{ figure_markup(
  image="number-of-requests-by-percentile-by-type-mobile.png",
  caption="モバイルでのタイプ別パーセンタイルごとのリクエスト数",
  description="モバイルデバイス上で、90パーセンタイルではHTMLコンテンツに対して14リクエスト、JavaScriptリソースに60リクエスト、CSSにほぼ24リクエスト、画像の取得に約70リクエスト、フォントに8リクエストがあります。75パーセンタイルでは、HTMLが6リクエスト、JavaScriptが37リクエスト、CSSが12リクエスト、画像が39リクエスト、フォントが5リクエストです。50パーセンタイルでは、HTMLが2リクエスト、JavaScriptが20リクエスト、CSSが6リクエスト、画像が22リクエスト、フォントが3リクエストです。25パーセンタイルでは、HTMLが1リクエスト、JavaScriptが9リクエスト、CSSが3リクエスト、画像が10リクエスト、フォントが1リクエストです。10パーセンタイルでは、HTMLが1リクエスト、JavaScriptが4リクエスト、CSSが1リクエスト、画像が6リクエスト、フォントが1リクエストです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=768422178&format=interactive",
  sheets_gid="174962437",
  sql_file="requests_by_type.sql"
) }}

通常通り、画像が主な原因ですが、JavaScriptもそれに迫っています。

モバイルとデスクトップのバージョンでほぼ同数のHTTPリクエストがありますが、そうあるべきではありません。ページの重さと同様に、モバイルページはできるだけ軽く保つべきです。これは、古くなったデバイス、不安定な接続、高価なモバイルデータを考慮しています。多くの人がまだこのような最適でない条件でウェブを使用しているため、モバイルウェブはこれを考慮して、すべての人にアクセスしやすいように最善を尽くすべきです。

{{ figure_markup(
  image="number-of-bytes-by-percentile-by-type-mobile.png",
  caption="モバイルでのタイプ別パーセンタイルごとのバイト数",
  description="モバイルデバイス上で、90パーセンタイルではHTMLが135 KB、JavaScriptが約1,367 KB、CSSが256 KB、画像が5,475 KB、フォントが338 KBです。75パーセンタイルではHTMLが67 KB、JavaScriptが857 KB、CSSが139 KB、画像が2,402 KB、フォントが191 KBに減少します。50パーセンタイルではHTMLが30 KB、JavaScriptが461 KB、CSSが68 KB、画像が881 KB、フォントが97 KBです。25パーセンタイルではHTMLが13 KB、JavaScriptが209 KB、CSSが28 KB、画像が260 KB、フォントが29 KBです。10パーセンタイルではHTMLが6 KB、JavaScriptが87 KB、CSSが6 KB、画像が64 KB、フォントが0 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=683807493&format=interactive",
  sheets_gid="1911144863",
  sql_file="page_bytes_per_type.sql"
) }}

画像とJavaScriptのHTTPリクエスト数はほぼ同じですが、全体の重さは画像の方がはるかに高いです。一般的に、画像よりもJavaScriptを処理する方が重いため、これはまだ悪いニュースです。再び、結果はモバイルとデスクトップで非常に近いですが、モバイルで軽い体験を提供することが理にかなっているように思えます。

### より持続可能なホスティング

<p class="note">注: ここでは（他の場所でも）「グリーンホスティング」という言及が見られます。これはある種の省略形で、実際に完全にグリーンである、またはカーボンニュートラルなどのホスティングは存在しません。ここでは、より持続可能なホスティングの使用方法に焦点を当てます。</p>

この章の大部分では、ネットワーク、コンピュート、ストレージなどのリソース量の変化がデジタルサービスの環境への影響にどのように影響するかに焦点を当てています。これを持続可能性のためのレバーとしての_消費_と考えるかもしれません。しかし、他にもレバーは存在します。ゼロまで効率化することはできませんが、同じ種類のサーバーで実行される同じコードが、よりグリーンなエネルギーで実行される場合、それはそうでない場合よりも環境への影響が低くなります。このレバーを_強度_と考えることができます。

ここにはいくつかの良いニュースがあります。世界中で私たちが依存している電力グリッドは、再生可能エネルギーと貯蔵のコストが下がることによって時間とともによりグリーンになっています。2022年には、私たちの電気の38%がクリーンなソースから得られています（<a hreflang="en" href="https://ember-climate.org/insights/research/global-electricity-review-2022/">エンバー気候の例</a>および<a hreflang="en" href="https://public.flourish.studio/story/1176231/?utm_source=showcase&utm_campaign=story/1176231">このチャート</a>）。

しかし、すべてのグリッドや、プロバイダーが運用するすべての地域が同じくらいグリーンであるわけではありません。<a hreflang="en" href="https://aws.amazon.com/aws-cost-management/aws-customer-carbon-footprint-tool/">アマゾンウェブサービスの顧客カーボンフットプリントツール</a>は、一方の地域でサービスを実行することと他方で実行することの間に、炭素排出量に計測可能な違いがあることを示しています。また、<a hreflang="en" href="https://www.cloudcarbonfootprint.org/">オープンソースのクラウドカーボンフットプリント</a>も、増え続ける数のプロバイダーについてそれを示しています。他の場所では、<a hreflang="en" href="https://www.thegreenwebfoundation.org/">グリーンウェブ財団</a>も、その地域のグリッドが化石燃料でどれだけ動力を得ているかの見積もりのために、任意のドメインを調べるAPIを提供しています。

しかし、再生可能エネルギーを使用するだけでは、真に持続可能なホスティングを提供するには不十分です。PUE（電力使用効率）、WUE（水使用効率）、機器の取り扱い方法なども確認する必要があります。これをさらに調査するには、<a hreflang="en" href="https://www.wholegraindigital.com/blog/choose-a-green-web-host/">Wholegrain Digitalの記事</a>や<a hreflang="en" href="https://e3p.jrc.ec.europa.eu/communities/data-centres-code-conduct">ヨーロッパデータセンターコードオブコンダクト</a>を確認できます。一般的に、カーボンニュートラルであると主張する企業には注意してください（<a hreflang="fr" href="https://presse.ademe.fr/2022/02/lademe-publie-un-avis-dexperts-sur-lutilisation-de-largument-de-neutralite-carbone-dans-les-communications.html">フランスのADEME機関が述べているように</a>）、とくにほとんどの企業がスコープ3の排出を含んでいないためです。また、上記のように、あなたの炭素排出を補償するだけでは不十分で、それを減らすべきです。

#### HTTPアーカイブにリストされているサイトの何割がグリーンホスティングを利用していますか？

技術企業の数が増えており、彼らのインフラを動力するために購入するすべての電力をグリーンにするための措置を講じています。MicrosoftやSalesforceなどの企業はすでに、そのサーバーファームが年間で使用するだけのグリーンエネルギーを購入しています。多くの他の企業も同様です。私たちは<a hreflang="en" href="https://www.thegreenwebfoundation.org/green-web-datasets/">グリーンウェブ財団のデータセット</a>を使用して、どれだけの組織が<a hreflang="en" href="https://www.thegreenwebfoundation.org/what-we-accept-as-evidence-of-green-power/">「グリーンホスト」として類似の措置を講じているか</a>、そして彼らが毎年使用するすべてのエネルギーをグリーンエネルギーで動力を供給している証拠を共有している場所を見ました。

{{ figure_markup(
  image="green-hosting-percentages.png",
  caption="グリーンホスティングの割合",
  description="上位1,000サイトでは、デスクトップで54%、モバイルで52%がグリーンウェブホスティングに依存しており、上位10,000サイトではデスクトップで50%、モバイルで48%、上位100,000ではデスクトップで39%、モバイルで38%、上位100万ではデスクトップで24%、モバイルでも24%です。全世界で測定されたウェブサイトでは、デスクトップで13%、モバイルで10%のみがグリーンウェブホスティングに依存しています",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=222811305&format=interactive",
  sheets_gid="1022303859",
  sql_file="green_web_hosting.sql"
) }}

全体として、測定されたウェブサイトのわずか10パーセントがグリーンホスティングに依存しています。これはウェブサイトがグリーンホスティングを選択することと、ホスティング会社が持続可能性を目指すことの両方で、多くのことが行われるべきであり、行われるべきであることを強調しています。

<p class="note">注: グリーンドメインのこれらの数字は、グリーンウェブ財団と直接共有された情報、または公開された情報に基づいています。彼らの検索サービスのAPIレスポンスでリンクされています。サイトがグリーンであると思われる場合に「グリーンではない」と表示される理由については、<a hreflang="en" href="https://www.thegreenwebfoundation.org/support/why-does-my-website-show-up-as-grey-in-the-green-web-checker/">彼らの説明ページ</a>を参照してください。</p>

### ウェブサイトの環境への影響を減らす

ベストプラクティスは、測定がなければ機能しませんし、その逆もまた同様です。ウェブサイトの環境への影響についてより良い表現を得た今、この影響をどのように軽減するか見ていきましょう。

### ムダを避ける

ウェブサイトの影響を減らすもっとも明白な方法の1つは、不必要なものをすべて避けることです。

- コンテンツとコードのムダを減らす：多くのウェブサイトやアプリには不必要なコンテンツや機能があります。このページやその機能が本当に必要かどうかを問う声になりましょう。陳腐なストック画像はほとんどのページに何も加えませんが、重さだけが加わります。画像を削除することは、ページの重さを減らす最良の方法の1つです。使用されていないコードも削除すべきです。
- 処理を減らす。バイト単位で見ると、JavaScriptはHTML、CSS、画像、テキストよりもはるかに大きな影響を与えます。これは、ユーザーのデバイス上でエネルギー集約的な処理が発生するためです。できるだけエネルギー効率の良い実装を選びましょう。多くのウェブページはJavaScriptさえ必要としません。常に最軽量のコーディングオプションを選びましょう。
- 最軽量の通信オプションを選ぶ。 <a hreflang="en" href="https://www.google.com/url?q=https://text.npr.org/&sa=D&source=docs&ust=1662467318246688&usg=AOvVaw2K1v83mXXmEePMRoG6edxq">テキストは圧倒的に環境に優しいコミュニケーション方法です</a>。ビデオは圧倒的にエネルギー集約的で持続不可能です。そのため、ユーザーのニーズに応じて必要な場合にのみ使用すべきです。この場合、ビデオはできるだけ効率的に統合すべきです。
- 長寿命のデザインをする。古いマシンや古いオペレーティングシステムを使用している人々が、あなたのウェブサイト/アプリを引き続き使用できるようにデザインしてください。デバイスをできるだけ長く保持することを支援するように設計してください。デジタルの観点から見ると、環境にとってこれ以上のことはありません。

#### 使用されていないアセットの読み込み

表示されるページ、とくに見えるページの部分に必要なアセットのみを読み込むべきです。これは、遅延読み込み、クリティカルCSS、<a hreflang="en" href="https://www.patterns.dev/posts/import-on-interaction/">_インタラクション時のインポート_</a>や<a hreflang="en" href="https://www.patterns.dev/posts/import-on-visibility/">_可視性時のインポート_</a>といったパターンを通じて行うことができます。また、クライアントデバイスに適したサイズで画像を読み込むことも含まれます。ここでは主に過剰なフォントと使用されていないコードに焦点を当てます。

##### フォント

持続可能性のためには、<a hreflang="en" href="https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/">システムフォントを使用することが推奨されます</a>。カスタムフォントを使用する必要がある場合は、ムダを避けるためにいくつかのことを考慮する必要があります。フォントを読み込むことは、必要のない多くの文字や記号を読み込むことを意味する場合があります。たとえば、すべてのウェブサイトがキリル文字を必要とするわけではありませんが、一部のフォントはそれをネイティブに含んでいます。これを確認するには、<a hreflang="en" href="https://wakamaifondue.com/">wakamaifondue</a>などのツールを使用できます。フォントファイルのサイズを減らすためには、WOFF2形式を目指し、<a hreflang="en" href="https://the-sustainable.dev/reduce-the-weight-of-your-typography-with-variable-fonts/">可変フォントを使用する</a>べきです。また、<a hreflang="en" href="https://everythingfonts.com/subsetter">サブセットを使用する</a>か、<a hreflang="en" href="https://github.com/Munter/subfont">subfont</a>などのツールを使用できます。<a hreflang="en" href="https://web.dev/api-for-fast-beautiful-web-fonts/">Google Fonts APIは、これらすべてのためにいくつかの賢いオプションを提供します</a>。Google Fontsに関しては、<a hreflang="en" href="https://rewis.io/urteile/urteil/lhm-20-01-2022-3-o-1749320/">GDPRも念頭に置くべきです</a>。

このトピックについての詳細は、[Fonts](./fonts)章を参照してください。また、<a hreflang="en" href="https://web.dev/reduce-webfont-size/">web.dev</a>で関連するドキュメントを見つけることができます。

##### 使用されていないCSS

使用されていないCSSは、とくにCSSフレームワーク（Bootstrapなど）を使用している場合に見られます。その際、ビルドフェーズで使用されていないCSSを削除することを念頭に置くべきです。<a hreflang="en" href="https://developer.chrome.com/docs/devtools/coverage">Chrome Dev Toolsは、これを確認するためのCoverageツールを提供しています</a>。注意が必要です。多くのウェブサイトでは、初回訪問時にすべてのCSSとJavaScriptが読み込まれ、それらをキャッシュしてウェブサイトのさらなる訪問と探索のために使用します。これは必ずしも悪いことではありませんが、使用されていないコードはとくに考慮すべき欠点の1つです。なぜなら、それはさらなるコード処理を遅くする可能性があるからです。

{{ figure_markup(
  image="unused-css-bytes.png",
  caption="使用されていないCSSのバイト数",
  description="90パーセンタイルでは、デスクトップで221 KB、モバイルで218 KBの使用されていないCSSがあります。75パーセンタイルでは、デスクトップで117 KB、モバイルで113 KB、50パーセンタイルではデスクトップで52 KB、モバイルで49 KBです。25パーセンタイルでは、デスクトップで19 KB、モバイルで17 KBの使用されていないCSSが見つかりました。最後に、10パーセンタイルでは、デスクトップとモバイルのどちらでも0 KBの使用されていないCSSが見られます",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1850605337&format=interactive",
  sheets_gid="1952093899",
  sql_file="unused_css_bytes.sql"
) }}

良いニュースは、10パーセンタイルのウェブサイトは不要なCSSを読み込まないことです。残念ながら、このグラフでは、90パーセンタイルで200 kB以上にまで増加しています。これが初期のキャッシュ理由であるかどうかは確認が必要です。持続可能性の観点から見ると、200 kBのCSSは大きな問題です。

### 使用されていないJavaScript

依存関係を追加したり、jQueryのようなライブラリを使用したりすると、使用されていないJavaScriptの量がすぐに増えることがあります。<a hreflang="en" href="https://developer.chrome.com/docs/devtools/coverage">Chrome Dev ToolsのCoverageツール</a>は、これをチェックするのに良い方法です。CSSの場合と同様に、これは時にすべての必要なものをキャッシュする戦略の一部です。これは、使用されていないJavaScriptがより長い処理をもたらす傾向があるという事実によってバランスを取るべきです。可能であれば、必要な機能のみを持つ<a hreflang="en" href="http://microjs.com">より小さな代替品</a>を探し、すべてのツールボックスを読み込むことを望むのではなく、いつか役立つことを期待してください。かつて、jQueryはほとんどのウェブサイトで見られるオールインワンソリューションでした。<a hreflang="en" href="https://youmightnotneedjquery.com/">今日では、多くのことがモダンなJavaScriptで処理できます</a>。<a hreflang="en" href="https://bundlephobia.com/">NPMの依存関係とそれがあなたのバンドルをどのように大きくするかをチェックしてください</a>。

{{ figure_markup(
  image="unused-javascript-bytes.png",
  caption="使用されていないJavaScriptのバイト数",
  description="90パーセンタイルでは、デスクトップで645 KB、モバイルで604 KBの使用されていないJavaScriptがあります。75パーセンタイルでは、デスクトップで372 KB、モバイルで342 KB、50パーセンタイルではデスクトップで177 KB、モバイルで162 KBです。25パーセンタイルでは、デスクトップで69 KB、モバイルで62 KBの使用されていないJavaScriptが見つかりました。最後に、10パーセンタイルでは、デスクトップとモバイルのどちらでも0 KBの使用されていないJavaScriptが見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=625795710&format=interactive",
  sheets_gid="1918594785",
  sql_file="unused_js_bytes.sql"
) }}

再び、10パーセンタイルでは使用されていないJavaScriptがなく、素晴らしいです。しかし、これはCSSよりも上位パーセンタイルでさらに悪化し、90パーセンタイルで600 kB以上に達しています。これは、目指すべき理想的なページの総重量よりもすでに多いです。

### 持続可能なUX

ウェブサイトに対しては、開発プロセス中ではなく、設計とプロトタイピングの初期段階で持続可能な選択肢と最適化を行うことが可能です。効率的なコンテンツを最初から優先するユーザーエクスペリエンスを設計することが可能であり、ユーザーを持続可能性の実践における積極的な参加者として関与させる体験を作ることもできます。いくつかの信念とは対照的に、これらはすべて、美しく、地球中心のウェブ体験を作り上げることを犠牲にすることなく達成できます。

特定のユーザーエクスペリエンスタスクに関連する排出を定量化することは難しいですが、一部の研究では、消費者デバイスの使用が製品の全体的なデジタルフットプリントの最大52％を占めると推定しています。<a hreflang="en" href="https://www.mightybytes.com/blog/where-do-digital-emissions-come-from/">そのため、UXを持続可能性のために最適化することは、製品の環境への影響を大幅に減らすことにつながります</a>。

#### ステークホルダーのための設計

もっとも持続可能な製品は、非人間を含むすべてのステークホルダーが誰であるかを明確に把握しているものです。このようにして、製品は設計プロセス中に人間中心および<a hreflang="en" href="https://planetcentricdesign.com/">地球中心のアプローチ</a>を取ります。

<a hreflang="en" href="https://www.mightybytes.com/blog/stakeholder-mapping/">ステークホルダーマッピング</a>などの合理化された実践に従事することは、ステークホルダーのエコシステムとそのニーズを特定し、関与する全員のための包括的な体験を編成する道を設定するのに役立ちます。この研究を使用して、すべての関与するステークホルダー（人間および非人間）のニーズを無視することによる意図しない結果を防ぐ製品を設計するための機会をマッピングできます。これは、ユーザーの目標と一致する<a hreflang="en" href="https://www.mightybytes.com/blog/how-to-design-an-impact-business-model/">ビジネスモデル</a>に地球中心の革新を組み込むための交差するタッチポイントを活用することによってさらに進めることができます。

#### ユーザージャーニーの最適化

ユーザーが最小のステップで目標を達成するのを優先する戦略的なユーザージャーニーを作成することは、サイトの炭素に優しいウェブ体験を作成する方法の1つです。ユーザーが製品をナビゲートする時間が短ければ短いほど、その訪問中に使用されるエネルギー、データ、およびリソースが少なくなります。これを行う戦略には、ユーザーのエンゲージメントと方向性を促進するのに役立つ画像、ビデオ、視覚的資産の使用に注意を払うことが含まれます。

これには、「より少ないほどよい」というアプローチも含まれ、必要なコンテンツのみをユーザーに表示するムダのないデザイン実践に従事し、同じ価値を提供する資産の選択を強調します。これらはすべて、すでに増加している<a hreflang="en" href="https://econreview.berkeley.edu/paying-attention-the-attention-economy/">注意経済</a>を避けながら、ユーザーが必要なものをより早く取得するのに役立ちます。プロトタイピングやその他の方法を通じてユーザーフィードバックをテストし続け、ユーザーにとって最適な体験を作成していることを確認するための潜在的な痛みのポイントを特定します。

#### 持続可能な行動を促進する

製品の機能に選択アーキテクチャを組み込むことで、ユーザーにその製品の環境タッチポイントに関連して持続可能な選択を促すことの人気が高まっています。この実践の例には、チェックアウト時にユーザーにより持続可能な包装オプションを提供する、もっとも炭素に優しい製品オプションを表示する、報酬システムやこれらの選択を視覚化して奨励するダッシュボードを構築するなどがあります。

この意思決定を支援し、この種の選択を提供することは、ユーザーがウェブサイトとより持続可能な方法で対話するのを助けるだけでなく、ユーザーの対話を最適化するための参入障壁を取り除くのにも役立ちます。最近では、アクセシビリティ機能、言語選択、デバイス最適化、または低エネルギーカラーを利用しながら適切なコントラストを促進する非常に人気のあるダークモードなどがあります。

これらの種類のオプションは、ユーザーの潜在的な痛みのポイントを最小限に抑えながら、時間、エネルギーを節約し、ユーザーのフラストレーションを防ぐカスタム体験を可能にするのに役立ちます。選択の力は通知の有効化と頻度など、より人気のあるオプトアウト機能にさらに深く浸透し、利用された場合にはリソースを節約し、ユーザーが訪問ごとの体験と影響をカスタマイズすることを可能にします。

#### 循環性と製品寿命終了のための設計

デジタル製品やサービスの全ライフサイクルを分析し理解することで、廃棄物を減らし、時間とともに環境への影響を改善する機会が明らかになります。明確で測定可能な成功指標を定義し追跡することが、このプロセスを導くのに役立ちます。

- **循環性:** モジュラーで簡単に交換または更新可能なコンポーネントの設計と、継続的な改善に焦点を当てることで、<a hreflang="en" href="https://www.mightybytes.com/blog/technical-debt-agile-and-sustainability/">技術的負債を減らし</a>、デジタル製品またはサービスの寿命を延ばすことができます。これにより、時間とリソースの使用も削減されます。
- **製品寿命終了:** デジタル製品やサービスに明確な廃止計画を作成することで、時代遅れまたは使用されていないデータを保存および提供するために必要なエネルギーが削減されます。また、良好なデータ廃棄の実践は、ユーザーの「忘れられる権利」を尊重する新たなデータプライバシー法とも一致します。

### コンテンツの最適化

不要なコンテンツや機能が削除されたことを確認してウェブサイトを最適化したとしましょう。これは節度の部分（通常は難しい部分）です。次に、持続可能な限り効率的に保つために、残されたすべてのものに焦点を当てることができます。

このセクションでは、画像、ビデオ、アニメーションに焦点を当てます。これらに関する詳細は、[Media](./media)章で取り上げます。

#### 画像の最適化

画像はリクエストとページの重さの大きな部分を占めています。これを軽減するためにできることを見てみましょう。すでに言及されているように、必要のない画像はすでに削除されているはずです。

可能な技術最適化から期待できる相対的な利点を詳しく見るために、<a hreflang="en" href="https://discuss.httparchive.org/t/state-of-the-web-top-image-optimization-strategies/1367">HTTP Archiveの投稿がそれらを比較しています</a>。HTML（時にはCSS）にますます簡単に依存できるようになっているので、それらをすべて実装するべきです。

##### フォーマット（WebP/AVIF）

WebPは<a hreflang="en" href="https://caniuse.com/webp">すでに広くサポートされており</a>、画像にとって最高のフォーマットの1つです。その圧縮は印象的で、転送および処理されるデータが少なくなります。さらに、広範なサポートを享受しています。AVIFはさらに優れているはずですが、<a hreflang="en" href="https://caniuse.com/avif">ブラウザーからの広範な採用が進むまで待つ</a>のが賢明かもしれません。その間は、画像にWebPフォーマットを使用してください。アイコンは<a hreflang="en" href="https://jakearchibald.github.io/svgomg/">最適化されたSVG</a>であるべきで、追加のリクエストを避けるためにHTMLに直接含めることもできます。

{{ figure_markup(
  image="image-formats-in-use.png",
  caption="使用中の画像フォーマット",
  description="円グラフで、全体として、jpgがデスクトップの画像フォーマットの52.9%、モバイルの54.9%を表しています。pngはデスクトップ画像の29.1%、モバイル画像の28.2%で使用されています。WebPはデスクトップ画像の11.6%、モバイルの10.7%で使用されています。Gifはデスクトップ画像の2.8%、モバイル画像の2.6%で使用されています。Svgはデスクトップ画像フォーマットの2.6%、モバイルの2.4%を占めています。Icoはデスクトップとモバイルの画像フォーマットの0.9%を表し、最後にavifはデスクトップとモバイルの画像フォーマットの0.3%を表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=865768073&format=interactive",
  sheets_gid="21166754",
  sql_file="image_formats.sql"
) }}

現在、ウェブサイトのわずか10%がWebPを使用しており、これは[昨年](../2021/media#フォーマットの採用)よりも改善されていますが、理想からはほど遠い状態です。これは巨大な機会であり、画像の全体的な重さを減らすのに役立ちます。AVIFはさらに後れを取っており、わずかに0%を超える程度ですが、今後数年でこの数字が増えることを期待できます。

##### 応答性、サイズ、品質

ユーザーがさまざまなデバイス（主にスマートフォンですが、ゲームコンソール、スマートウォッチ、タブレットなども含まれます）でウェブを閲覧する割合が増えているため、それぞれに適したサイズと重さの画像を配信することを目指すべきです。これはレスポンシブデザインの主要なトピックの1つであり、開発者はこれを自動化するための多くのツールを持っています。

また、人間の目はこの上の違いを検出できないため、品質を85%以上にする必要はほとんどありません。品質を85%に下げることで、画像のサイズを減らすことができます。

{{ figure_markup(
  image="responsive-image-types.png",
  caption="レスポンシブ画像タイプ",
  description="デスクトップで33%、モバイルで34%のウェブサイトがsrcset属性を使用していることを示す円グラフ。25%のウェブサイトがデスクトップでsizesと一緒に使用しており、モバイルでは26%が使用しています。8%のウェブサイトがデスクトップでsizesなしでsrcset属性を使用しており、モバイルでも8%が使用しています。picture要素はデスクトップとモバイルのウェブサイトで8%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=403648557&format=interactive",
  sheets_gid="695142267",
  sql_file="responsive_images.sql"
) }}

ウェブサイトの約34%が`srcset`属性を使用しており、これはレスポンシブ画像を統合するための素晴らしい方法です。`<picture>`要素も素晴らしく機能し、すでにウェブサイトの7%で見られます。楽観的に考えると、レスポンシブ画像が毎年地盤を固めていると焦点を当てることができますが、それでもウェブサイトの多数派で使用されているわけではありません。しかし、レスポンシブデザインはかなりの時間存在しており、より広く普及しているべきです。

##### 遅延読み込み

最初の読み込みを高速化する簡単な方法は、画像を段階的に読み込むことです：必要なときに必要なもののみを読み込みます。これは[遅延読み込み](./media#レイジーローディング)を通じて行われ、<a hreflang="en" href="https://caniuse.com/loading-lazy-attr">ほとんどのブラウザが現在これをネイティブでサポートしています</a>。すべてのユーザーがページを最後までスクロールするわけではないので、現在のユーザーによって見られることがないかもしれない画像の読み込みを避けるべきです。そのため、これは持続可能性とユーザーの両方にとって迅速な勝利です。

{{ figure_markup(
  image="native-lazy-loading-usage.png",
  caption="ネイティブの遅延読み込みの使用状況",
  description="2019年7月1日にはウェブサイトがネイティブの遅延読み込みを使用していなかったことを示す棒グラフ。2020年8月1日には、デスクトップで4%、モバイルで4%のウェブサイトがネイティブの遅延読み込みを使用しています。2021年7月1日には、デスクトップとモバイルの両方で18%のウェブサイトがネイティブの遅延読み込みを使用しており、2022年6月1日には、デスクトップで23%、モバイルで24%のウェブサイトがネイティブの遅延読み込みを使用しています",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=862073668&format=interactive",
  sheets_gid="1363374212",
  sql_file="image_lazy_loading.sql"
) }}

このグラフから、ネイティブの遅延読み込みが実装されて以来、より広く採用されていることがわかります。約4分の1のウェブサイトがこれを使用しています。一部はまだJavaScriptライブラリを使用してこの動作を実装しており、このグラフには表示されません。ネイティブの遅延読み込みに切り替えることは、リクエストをわずかに減らし、一部のJavaScript処理を避けるための素晴らしい機会です。

iframeに関するクイックノート：遅延読み込みはiframeにもネイティブで適用可能ですが、持続可能性の理由から、iframeを完全に避けることを検討すべきです。ほとんどの場合、埋め込みビデオやインタラクティブマップを含めたい場合など、<a hreflang="en" href="https://web.dev/third-party-facades/">ファサード</a>が適切なパターンです。ページの重量とリクエストを増加させることが多く、しばしばアクセシビリティの問題を引き起こすため、ページに直接外部コンテンツを含めるのは良くありません。

#### ビデオ

<a hreflang="en" href="https://theshiftproject.org/en/article/unsustainable-use-online-video/">ビデオは、ウェブサイトに含めることができるもっとも影響力のあるリソースの1つです</a>。これについての詳細は、[Media](./media)章で取り上げます。サードパーティのビデオを統合するには、<a hreflang="en" href="https://web.dev/third-party-facades/">ファサードを使用する必要があります</a>。さらに、<a hreflang="en" href="https://www.smashingmagazine.com/2021/02/optimizing-video-size-quality/">賢く設定する必要があります</a>。たとえば、プリロードと自動再生を避けるべきです。また、<a hreflang="en" href="https://theshiftproject.org/en/guide-reduce-weight-video-5-minutes/">ビデオのサイズを迅速に削減する方法を学ぶことができます</a>。

##### プリロード

ビデオ（またはオーディオファイル）を自動的にプリロードすることは、すべてのユーザーにとって有用でない可能性のあるデータを取得することを含みます。このようなコンテンツを含むページに多くの訪問者がいる場合、迅速に蓄積する可能性があります。したがって、プリロードは避けるべきであり、ユーザーの操作に基づいてのみ行うべきです。

{{ figure_markup(
  image="video-preload-usage.png",
  caption="ビデオプリロードの使用状況",
  description="プリロード属性は、デスクトップのビデオの57.6%、モバイルのビデオの59.5%で使用されていません。プリロード属性は、デスクトップのビデオで17.3%、モバイルのビデオで15.4%で「none」の値が見られます。'auto'の値は、デスクトップのビデオで15.3%、モバイルのビデオで13.6%で使用されています。'metadata'の値は、デスクトップのビデオで7.5%、モバイルのビデオで9.2%で使用されています。プリロード属性は、デスクトップとモバイルのビデオで1.6%で空です。プリロード属性の値は、「TRUE」で、それぞれデスクトップのビデオで0.4%、モバイルのビデオで0.3%で使用されています。最後に、プリロード属性の値は、デスクトップとモバイルのビデオでそれぞれ0.1%で「preload」、「yes」、「undefined」または「FALSE」となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1090171830&format=interactive",
  sheets_gid="1420607407",
  sql_file="video_preload_values.sql"
) }}

このグラフを見るとき、プリロード属性には3つの可能な値があることを心に留めておく必要があります。「none」、「auto」、「metadata」（デフォルト）。値なしでプリロード属性を使用することや、誤った値で使用することは、「metadata」値を使用するのと同じかもしれません。それでもメタデータを取得するためにビデオの最大3%を読み込むことが関与し、それによってかなりの影響を与える可能性があります。持続可能性のためには、「none」が最善の方法です。しかし、これはブラウザに対するヒントに過ぎないことを心に留めておく必要があります。最終的には、ブラウザがビデオのプリロードをどのように処理するかが、あなたが考えていたことと合致しないかもしれません。

この件に関しては、<a hreflang="en" href="https://www.stevesouders.com/blog/2013/04/12/html5-video-preload/">Steve Soudersの記事（2013年）</a>と<a hreflang="en" href="https://web.dev/fast-playback-with-preload/">web.devの別の記事（2017年）</a>をチェックすべきです。ブラウザやデバイスを設定してデータを節約できるかもしれませんが、ビデオのプリロードは、ブラウザがデフォルトでより持続可能に処理すべきものです。

##### 自動再生

プリロードに関して行ったほとんどの考慮事項は、自動再生にも適用されます。これに加えて、関心のないユーザーにデータを読み込み、コンテンツを表示することにより、アクセシビリティの問題を引き起こす可能性があります。一部のユーザーにとって、無許可の動く画像や音声は邪魔であり、ブラウジング体験を妨げる可能性があります。

また、この属性は`preload`設定を上書きする可能性があります。自動再生には明らかに読み込みが必要です。

{{ figure_markup(
  image="video-autoplay-usage.png",
  caption="ビデオ自動再生の使用状況",
  description="デスクトップで53.1%、モバイルで52.6%のウェブサイトが自動再生属性を使用していないことを示す棒グラフ。38.6%のデスクトップビデオと38.8%のモバイルビデオで空の値で使用されています。自動再生値は、デスクトップビデオの5.3%とモバイルビデオの5.1%で使用されています。TRUE値は、デスクトップビデオの2.5%とモバイルビデオの3%で使用されています。1値は、デスクトップとモバイルのビデオでそれぞれ0.3%で使用されています。FALSE値は、デスクトップとモバイルのビデオで0.2%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=2034030994&format=interactive",
  sheets_gid="1238590607",
  sql_file="video_autoplay_values.sql"
) }}

ウェブサイトの半数以上が自動再生を使用していないのは良いことです。しかし、これはブール属性なので、空の値（または間違った値）を持つことでも自動再生がトリガーされます。上記の理由から、持続可能性とアクセシビリティのためにこれを避けるべきです。

#### アニメーション

アクセシビリティのために、ユーザーがある程度のコントロールを持っていない限り、動く部分や点滅する部分は避けるべきです。持続可能性に関しては、アニメーションはコストがかかります。これはバッテリーの放電速度とCPU消費を増加させる傾向があり、結果としてスマートフォンの自立性を低下させる可能性があります。また、いくつかのコードを取得して実行することも関与し、レンダリングを遅延させる可能性があります。

（悪名高い）カルーセルのケースは以下のページで文書化されています：

- <a hreflang="en" href="https://shouldiuseacarousel.com/">なぜそれらを使用すべきではないか</a>
- <a hreflang="en" href="https://www.smashingmagazine.com/2022/04/designing-better-carousel-ux/">代わりに何ができるか</a>

アニメーションを使用する必要がある場合は、<a hreflang="en" href="https://web.dev/efficient-animated-content/">GIFを避ける</a>か、少なくとも最適化されたビデオに変換するべきです。なぜなら、アニメーションGIFは非常に重くなる可能性があるからです。

#### ファビコンとエラーページ

デフォルトでは、ブラウザはウェブサイトに到着するとファビコンを探します。存在しない場合、ほとんどのサーバーは404エラーとそのウェブサイトの404ページのHTMLを返します。したがって、以下の点を考慮することをオススメします。

- ファビコンを忘れずにキャッシュしてください！
- 404ページのHTMLをできるだけ軽く最適化するか、さらに良い方法として、サーバーを設定して404ページのHTMLではなくテキストのみを送信するようにしてください。

これに関する詳細は、<a hreflang="en" href="https://nooshu.com/blog/2020/08/25/you-should-be-testing-your-404-pages-web-performance/">Matt Hobbsの記事</a>を参照してください。

### 外部コンテンツの最適化

ウェブ開発の素晴らしい点の1つは、フレームワークやライブラリだけでなくコンテンツにも簡単に依存できることです。しかし、実装が簡単だからといって、それが役立つか、影響が少ないわけではありません。追加したい各外部要素について、それがユーザーに本当に必要かどうかを考えてみてください。そうである場合は、できるだけ効率的に統合してください。また、各コンテンツにはコストがかかることを念頭に置いてください。リクエストや追加のコードだけでなく、時には脆弱性や少なくとも攻撃面の増大を伴うこともあります。

#### サードパーティ

サードパーティのリクエストは、すべてのリクエストの45%を占めており、94%のモバイルウェブサイトで少なくとも1つの識別可能なサードパーティのリソースがあります。これは、サードパーティのコードがしばしばウェブページ上で複雑な機能を提供するために使用されるため、驚くべきことではありません。また、ウェブサイトにクロスプラットフォームのコンテンツを含めるための迅速な修正としても機能します。

{{ figure_markup(
  caption="モバイルページのサードパーティリクエストのうち、グリーンホスティングから提供されている割合。",
  content="91%",
  classes="big-number",
  sheets_gid="951750086",
  sql_file="../third-parties/percent_of_websites_with_third_party.sql"
)
}}

ウェブ上のリクエストの大部分を占めるサードパーティのリクエストが、大部分がグリーンホスティングプロバイダーから提供されていることを知ると安心です。

{{ figure_markup(
  image="green-third-party-requests.png",
  caption="グリーンなサードパーティリクエストの割合",
  description="棒グラフで、トップ1000のウェブサイトでは、サードパーティリクエストの64%がデスクトップで、63%がモバイルデバイスでグリーンホスティングに依存しています。トップ10000のウェブサイトでは、デスクトップで66%、モバイルで67%です。トップ100000サイトでは、デスクトップとモバイルの両方で74%です。トップ100万では、デスクトップで84%、モバイルで83%です。全体的に見ると、デスクトップでのサードパーティリクエストの89%がグリーンホスティングに依存しており、モバイルでは91%に上がります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1339778519&format=interactive",
  sheets_gid="951750086",
  sql_file="green_third_party_requests.sql"
) }}

上のグラフは、グリーンホスティングプロバイダーから提供されるサードパーティリクエストの割合を示しています。ここで興味深いのは、グリーンウェブサイトホスティングとは逆の傾向が見られることです。これは予想外かもしれませんが、もっともリクエストされたトップ5のサードパーティはすべてGoogleのエンティティ（フォント、アナリティクス、アカウント、タグマネージャー、広告）です。これらのエンティティに関連するURLは、ほぼすべてがグリーンホスティングから提供されているとリストされています。

##### サードパーティリクエストをより持続可能にする

見てきたように、ほとんどのサードパーティリクエストはグリーンホスティングから提供されています。しかし、とくにランクが高いサイトでは改善の余地がまだあります。ウェブサイトで使用されているサードパーティサービスの持続可能性に興味がある場合、<a hreflang="en" href="https://aremythirdpartiesgreen.com/">Are my third parties green?</a>はオンラインテストツール、ディレクトリ、およびAPIで、始めるのに役立ちます。_透明性のために、このツールは章の著者の一人によって作成されたものであることを明記しておきます。_

ホスティングを超えて、サードパーティのデータ転送の影響も考慮すべきです。サードパーティサービスのプロバイダーは、他のウェブサイトにコンテンツを統合することを比較的簡単にしますが、それが常にデータ転送量を減らすように最適化されているわけではありません。たとえば、2022年のアルマナックの[サードパーティ](./third-parties)章では次のように明らかにされています。

> モバイルデバイスでもっとも人気のあるサードパーティはGoogleフォントで、すべてのウェブサイトの62.6%で使用されています。提供されるCSSは最小化されていません。データによると、Googleフォントを使用している平均ページは、それを最小化することで13.3KBを節約できます。

フォントの場合、自己ホスティングとサブセッティングは、組み合わせるとこのムダを減らすのに役立つ2つの技術です。しかし、ほとんどのサードパーティはスクリプトの形で提供されます。これらはネットワークを介してデータを転送する際のコストだけでなく、エンドユーザーのデバイスでの処理能力も利用します。これらについては、「ジャストインタイム」で読み込むことで影響を減らすことができます。

このパターンは<a hreflang="en" href="https://www.patterns.dev/posts/import-on-interaction/">_インタラクション時のインポート_</a>として知られており、ページが最初に読み込まれるときにインタラクティブなコンテンツの代わりに静的なファサードを使用します。その後、ユーザーが要素と対話する直前にコンテンツがリクエストされ、読み込まれます。これにより、初期に転送されるデータが少なくなり、ページを表示する際の処理も減少します。とくにスクリプトが決して要求されない場合はそうです。

### 技術最適化の実装

これまでに、ウェブサイトのコンテンツの持続可能性について多くを見てきました。これで、他のすべての技術最適化に取り組むことができます。ここでも多くの作業が必要であり、ほとんどは自動化されるべきです。再び、これはWeb Almanacの他の章といくつか交差するかもしれませんが、持続可能性についての章を提供し、ウェブサイトをより持続可能にする方法について説明することが目的です。

ウェブパフォーマンスの専門家は技術最適化の分野で多くの作業を行っているので、彼らから学ぶべきことがたくさんあります。ただし、彼らのベストプラクティスが必ずしもウェブサイトをより持続可能にするわけではないことを念頭に置いてください。しかし、物事を軽くシンプルにすることは、持続可能性とパフォーマンスのために素晴らしいことです。アクセシビリティにも言及すると良いでしょう。

#### JavaScript

JavaScriptについては、ウェブの成長にどのように役立ってきたか（そして時にはそれがウェブをどのように遅くするか）について多くのことが語られています。ここでは、実装が簡単で持続可能性に大きな利益をもたらすいくつかの簡単な勝利に焦点を当てましょう。これについてもっと学びたい場合は、[JavaScript](./javascript)章をチェックしてください。

##### 最小化

JavaScriptを最小化することは、ブラウザにとって不要な文字を削除し、ファイルを軽くすることを含みます。

{{ figure_markup(
  image="unminified-javascript-savings.png",
  caption="最小化されていないJavaScriptの節約",
  description="90パーセンタイルでは、デスクトップで40KB、モバイルで36KBのJavaScriptがJsの最小化を使用することで節約できることを示す棒グラフ。75パーセンタイルでは、デスクトップで10KB、モバイルで9KBが節約できます。50パーセンタイル、25パーセンタイル、10パーセンタイルでは節約されるKBはありません。これはこれらのウェブサイトでJavaScriptの最小化がすでに行われていることによるものです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=457277769&format=interactive",
  sheets_gid="1952499146",
  sql_file="unminified_js_bytes.sql"
) }}

このグラフから、ほとんどのウェブサイトがJavaScriptを効率的に最小化しており、最小化からの利益はそれほど大きくないことがわかります。しかし、実装が簡単で常に有益であるため、なぜ実行しないのでしょうか？

##### HTML内でできるだけ少なく含める

インラインコードは悪い習慣であり、持続可能性にとってさらに悪いです。HTMLを重くして読み込みや処理を困難にすることは望ましくありません。JavaScriptをインラインで書くことは、時に最適化（およびメンテナンス）を困難にすることもあります。

{{ figure_markup(
  image="script-usage.png",
  caption="スクリプトの使用",
  description="デスクトップでは34％のJavaScriptがインラインで、残りの66％が外部ファイルからのものです。モバイルでは、35％のJavaScriptがインラインで、65％が外部ファイルからのものです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1900077125&format=interactive",
  sheets_gid="2126160877",
  sql_file="script_count.sql "
) }}

ウェブサイトの約3分の1がJavaScriptをインラインで使用しています。これはCMSでよく見られることです。

#### CSS

CSSは、とくにウェブサイト上の画像の数を制限したり、前述の章で述べたアニメーションを作成したりする場合に、持続可能性のための素晴らしいレバーになり得ます。効率的なCSSの書き方に関するドキュメントは見つけることができますが、ここではすべての場所で実装されるべき標準的な最適化に焦点を当てます。これについてもっと学びたい場合は、[CSS](./css)章を参照してください。

##### 最小化

CSSと同様に、JavaScriptを最小化することは、ブラウザにとって不要な文字を削除し、ファイルを軽くすることを含みます。

{{ figure_markup(
  image="unminified-css-savings.png",
  caption="最小化されていないCSSの節約",
  description="90パーセンタイルでは、デスクトップで15KB、モバイルで14KBのCSSがCSSの最小化を使用することで節約できることを示す棒グラフ。75パーセンタイルでは、デスクトップで5KB、モバイルで4KBが節約できます。50パーセンタイル、25パーセンタイル、10パーセンタイルでは節約されるKBはありません。これはこれらのウェブサイトでCSSの最小化がすでに行われていることによるものです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=898637516&format=interactive",
  sheets_gid="1896195819",
  sql_file="unminified_css_bytes.sql"
) }}

ほとんどのウェブサイトで最小化されていないCSSは存在せず、潜在的な利益は非常に軽いようです。しかし、CSSを最小化することは依然として有益であり、すべてのウェブサイトで実装されるべきです。

##### HTML内に可能な限り少なく含める

JavaScriptと同様に、CSSをインラインで書くことはHTMLファイルのサイズとウェブサイトのパフォーマンスにとって悪影響を及ぼす可能性があります。これは、CMSを使用して構築されたウェブサイトや<a hreflang="en" href="https://web.dev/extract-critical-css/">クリティカルCSSメソッド</a>に依存しているウェブサイトでよく見られます。

{{ figure_markup(
  image="style-usage.png",
  caption="スタイルの使用",
  description="デスクトップとモバイルの両方で、25%のCSSがインラインで使用され、残りの75%が外部スタイルシートから来ていることを示す棒グラフ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1184478802&format=interactive",
  sheets_gid="362809205",
  sql_file="stylesheet_count.sql"
) }}

このグラフから、ウェブサイトの約四分の一が依然としてCSSをインラインで使用していることがわかります。持続可能性の理由から、これは避けるべきです。

#### CDN

CDNの実装は、ウェブサイトをより持続可能にするのに役立ちます。これにより、ユーザーに可能な限り近い場所でアセットを提供し、時には自動的に最適化を支援します。

{{ figure_markup(
  image="cdn-usage.png",
  caption="ウェブ上のCDNの使用",
  description="分析されたページの69.7%がデスクトップでCDNを使用しておらず、モバイルで71.2%がCDNを使用していないことを示す棒グラフ。16.9%がデスクトップでCloudflareを使用し、モバイルで15.1%が使用しています。5.2%がデスクトップでGoogleを使用し、モバイルで6.5%が使用しています。2.8%がデスクトップでFastlyを使用し、2.6%がモバイルで使用しています。2.2%がデスクトップでAmazon Cloudfrontを使用し、モバイルで1.8%が使用しています。1.1%がデスクトップでAkamaiを使用し、モバイルで0.8%が使用しています。0.4%がデスクトップでAutomatticを使用し、モバイルで0.7%が使用しています。Sucuri Firewallは、デスクトップとモバイルでそれぞれ0.5%と0.3%で使用されています。NetlifyとVercelは、モバイルとデスクトップのテストされたページの0.2%で使用されています。最後に、CDN、Highwinds、Microsoft Azure、OVH CDNは、デスクトップとモバイルのページの0.1%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=508019478&format=interactive",
  sheets_gid="1415782903",
  sql_file="cdn_adoption.sql",
  width=600,
  height=511
) }}

これらの明らかな利点にもかかわらず、70%以上のウェブサイトがまだCDNを使用していません。

#### テキスト圧縮

<a hreflang="en" href="https://web.dev/uses-text-compression/">ウェブサイトのテキストアセットを圧縮する</a>ことは、いくつかの（簡単な）サーバー側の設定を必要とするかもしれません。HTML、JavaScript、CSSなどのテキストファイルは、BrotliまたはGzip形式で圧縮され、容易に軽量化されます。

{{ figure_markup(
  image="compression-used-on-text-resources.png",
  caption="テキストリソースで使用される圧縮",
  description="デスクトップでのテキストリソースの28%がBrotli形式で圧縮され、47%がGzipで圧縮されており、25%は圧縮されていないことを示す棒グラフ。モバイルでは、テキストリソースの29%がBrotli形式で圧縮され、46%がGzipで圧縮され、25%はまったく圧縮されていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=2065385728&format=interactive",
  sheets_gid="218418435",
  sql_file="text_compression.sql"
) }}

それにもかかわらず、ウェブサイトの4分の1はまだテキスト圧縮を実装していません。Gzipは全面的にサポートされているので、安心して使用してください。

#### キャッシング

<a hreflang="en" href="https://web.dev/uses-long-cache-ttl/">キャッシング</a>はブラウザのキラー機能の1つですが、常に完璧に実装するのは簡単ではありません。キャッシングは、ブラウザがすべてのリソースを毎回要求するのを防ぐため、持続可能性に非常に良いです。

{{ figure_markup(
  image="cache-control-header-usage.png",
  caption="キャッシュコントロールヘッダーの使用状況",
  description="デスクトップで23%のウェブサイトがキャッシュコントロールのみを使用し、1%が期限のみを使用し、51%が両方を使用しています。デスクトップで25%のウェブサイトがキャッシングをまったく使用していません。モバイルでは、22%のウェブサイトがキャッシュコントロールのみを使用し、1%が期限のみを使用し、51%が両方を使用しています。モバイルで26%のウェブサイトがキャッシングをまったく使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1354451270&format=interactive",
  sheets_gid="326683091",
  sql_file="cache_header_usage.sql"
) }}

このページからわかることは、ウェブサイトの四分の一以上がまったくキャッシングを使用していないということです。これは持続可能性とパフォーマンス、そして明らかな理由からユーザーにとって大きな損失です。

## SEOと持続可能性

アクセシビリティと同様に、検索エンジン最適化の取り組みに関連する排出量を特定するのは困難です。しかし、SEOは重要な持続可能性の影響を持っています。

- キーワードリサーチはSEOの基盤であり、著者が作成するコンテンツを特定のターゲットユーザーのニーズと一致させるのに役立ちます。
- 構造化データは検索エンジンがページコンテンツをよりよく理解するのを助け、結果としてより関連性の高い情報を提供できます。
- 検索最適化されたコンテンツは、通常、そのフォーマットによって素早くスキャンが可能で、明確に書かれているため、理解しやすくなります。
- コンテンツのパフォーマンスを時間とともに分析する（直帰率、スクロールの深さなど）ことで、著者は公開されたコンテンツを改善し、ユーザーのニーズにより適切に対応できます（検索結果も改善します）。分析に使用されるツールによっては、プライバシーに関する問題が発生する可能性があります。

これらの努力は、ユーザーが自分のニーズに関連する情報を探すために費やす時間を減らすのに役立ちます。これにより、エネルギーの使用が減少します。

逆に、検索エンジンは、チュートリアルやガイドなどの長文コンテンツをしばしば報酬として与えますが、これはリスト記事やその他の短い形式のコンテンツよりも多くの帯域幅（およびエネルギー）を使用する可能性があります。多くの持続可能性関連の概念と同様に、有用で魅力的なコンテンツを作成し、パフォーマンスと効率を最適化する間の適切なバランスを見つけることが鍵です。

数年前、Googleは単一の検索が60Wの電球を17秒間点灯させるのに必要なエネルギーを記録しました。2022年には、検索エンジン最適化の具体的な環境への影響を定量化するためのさらなる研究が必要ですが、良いSEO作業の持続可能性への影響は明確です。最適化されたコンテンツはエンドユーザーのエネルギー消費を減らします（イライラを減らすことを言うまでもありません）。

## 持続可能なデータおよびコンテンツ管理

上記で述べたように、構造化データは検索エンジンがウェブページをよりよく理解し、より関連性の高い結果を生成するのを助けます。しかし、データとの集団的な関係はSEOを超えて持続可能性の影響を持っています。

- 使用されていない重複した古いまたは、不完全なデータや管理が悪いコンテンツはサーバーのスペースを消費し、ユーザーにエラーを引き起こし、ホストおよび維持にエネルギーを必要とします。
- <a hreflang="en" href="https://www.mightybytes.com/blog/how-to-run-a-content-audit/">定期的なコンテンツ監査</a>と明確な<a hreflang="en" href="https://www.mightybytes.com/blog/content-governance/">コンテンツガバナンス計画</a>は、コンテンツのパフォーマンスを測定し、時間とともに古くなったりパフォーマンスが低下したりするコンテンツを剪定するのに役立ちます。
- サードパーティサービスはウェブページに小さなコードスニペットを挿入するだけかもしれませんが、収集されたデータは非常にリソース集約的です。たとえば、1つのデジタル広告が<a hreflang="en" href="https://www.businessinsider.com/making-net-zero-possible-the-hidden-impact-of-digital-ads-2022-7">最大323トンのCO2e</a>を生産することがあります。
- マーケティングオートメーション、メールマーケティング、CRMシステムなどのデータツールメーカーは、しばしば製品管理の努力をデータ収集に焦点を当てていますが、それを最適化するわけではありません。実際、これらのプラットフォームのいくつかはデータ使用に対して課金し、そのビジネスモデルは持続可能性の原則と相反することがあります。
- 同様に、多くの組織には明確なデータ廃棄ポリシーがなく、効果的なデータ管理についてチームをトレーニングしていません。これは持続可能性の問題だけでなく、プライバシーおよびセキュリティの問題でもあります。

これらは、管理が悪いコンテンツとデータに関連する長い持続可能性の問題リストからのいくつかの例です。組織は定期的にコンテンツとデータ管理の慣行を監査し、<a hreflang="en" href="https://www.mightybytes.com/blog/design-a-sustainable-data-strategy/">効率を向上させリソース使用を減らす</a>ための改善を図るべきです。

### 人気のフレームワーク、プラットフォーム、CMS

オンラインプラットフォームやCMSツールは、ウェブ上で出版やビジネスを行いたい人々の参入障壁を下げるのに役立ちます。同様に、開発フレームワークやサイトジェネレーターは、ウェブのために構築する人々がプロジェクトを迅速に開始し、一般的な開発問題を解決するデフォルトやソリューションを活用できるようにします。

以下のチャートは、もっとも人気のある5つのeコマースプラットフォーム、CMSツール、サイトジェネレーターツールの中央ページ重量を示しています。

{{ figure_markup(
  image="median-kilobytes-by-ecommerce.png",
  caption="eコマース別の中央値キロバイト",
  description="WooCommerceページはデスクトップで3,048 KB、モバイルで2,827 KBの中央重量があることを示す棒グラフ。Shopifyはデスクトップで2,428 KB、モバイルで2,080 KBです。Squarespace Commerceはデスクトップで3,462 KB、モバイルで3,577 KBです。PrestaShopはデスクトップで2,900 KB、モバイルで2,528 KBです。Magentoはデスクトップで3,317 KB、モバイルで3,093 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=574238152&format=interactive",
  sheets_gid="1434449385",
  sql_file="ecommerce_bytes_per_type.sql"
) }}

{{ figure_markup(
  image="median-kilobytes-by-cms.png",
  caption="CMS別の中央値キロバイト",
  description="WordPressページはデスクトップで2,559 KB、モバイルで2,314 KBの中央重量があることを示す棒グラフ。Drupalはデスクトップで2,351 KB、モバイルで2,146 KBです。Joomlaはデスクトップで2,799 KB、モバイルで2,495 KBです。Wixはデスクトップで3,172 KB、モバイルで2,158 KBです。Squarespaceはデスクトップで3,462 KB、モバイルで3,577 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1499422639&format=interactive",
  sheets_gid="1561070567",
  sql_file=""
) }}

{{ figure_markup(
  image="static-site-generator-median.png",
  caption="静的サイトジェネレーターの中央値KB",
  description="Next.jsページはデスクトップで2,387 KB、モバイルで2,064 KBの中央重量があることを示す棒グラフ。Nuxt.jsはデスクトップで2,877 KB、モバイルで2,210 KBです。Gatsbyはデスクトップで2,049 KB、モバイルで1,731 KBです。Hugoはデスクトップで870 KB、モバイルで1,088 KBです。Jekyllはデスクトップで662 KB、モバイルで781 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1545025671&format=interactive",
  sheets_gid="613315308",
  sql_file="ssg_bytes_per_type.sql"
) }}

とくに興味深いのは、リストされたプラットフォーム/ツールの中で、全体の中央値（2,019 KB）よりもモバイルページの重量が少ないのは3つだけであることです。これらはすべて静的サイトジェネレーターカテゴリにあり、とくにHugoとJekyllの場合は、これらのツールが使用されているウェブサイトの種類、主にブログやテキストコンテンツ、JavaScriptへの依存度が少ないことに起因する可能性が高いです。また、SSGはパフォーマンスを念頭に置いて使用されることが多いため、商品理由のみでCMSを使用している平均的なウェブサイトよりもさらに最適化される可能性が高いことも指摘しておきます。

3つのセグメントを横断して見ると、デスクトップとモバイルのページサイズの間に大きな差があることがわかります。詳しく見ると、これはいくつかのプラットフォームがモバイルデバイス用に画像の最適化を行っているためのようです。これを強調するために、デスクトップとモバイルのサイズに大きな違いを示すWixなど、他の人気プラットフォームと比較したCMSカテゴリを見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">CMS</th>
        <th scope="col">デバイス</th>
        <th scope="col">HTML</th>
        <th scope="col">JavaScript</th>
        <th scope="col">CSS</th>
        <th scope="col">Image</th>
        <th scope="col">Fonts</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td>デスクトップ</td>
        <td class="numeric">40</td>
        <td class="numeric">521</td>
        <td class="numeric">117</td>
        <td class="numeric">1,202</td>
        <td class="numeric">166</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>モバイル</td>
        <td class="numeric">37</td>
        <td class="numeric">481</td>
        <td class="numeric">115</td>
        <td class="numeric">1,100</td>
        <td class="numeric">137</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td>デスクトップ</td>
        <td class="numeric">23</td>
        <td class="numeric">416</td>
        <td class="numeric">68</td>
        <td class="numeric">1,279</td>
        <td class="numeric">114</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td>モバイル</td>
        <td class="numeric">23</td>
        <td class="numeric">406</td>
        <td class="numeric">66</td>
        <td class="numeric">1,158</td>
        <td class="numeric">92</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td>デスクトップ</td>
        <td class="numeric">26</td>
        <td class="numeric">452</td>
        <td class="numeric">86</td>
        <td class="numeric">1,690</td>
        <td class="numeric">104</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td>モバイル</td>
        <td class="numeric">22</td>
        <td class="numeric">401</td>
        <td class="numeric">83</td>
        <td class="numeric">1,504</td>
        <td class="numeric">82</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td>デスクトップ</td>
        <td class="numeric">123</td>
        <td class="numeric">1,318</td>
        <td class="numeric">86</td>
        <td class="numeric">647</td>
        <td class="numeric">197</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td>モバイル</td>
        <td class="numeric">118</td>
        <td class="numeric">1,215</td>
        <td class="numeric">9</td>
        <td class="numeric">290</td>
        <td class="numeric">148</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td>デスクトップ</td>
        <td class="numeric">27</td>
        <td class="numeric">997</td>
        <td class="numeric">89</td>
        <td class="numeric">1,623</td>
        <td class="numeric">214</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td>モバイル</td>
        <td class="numeric">27</td>
        <td class="numeric">990</td>
        <td class="numeric">89</td>
        <td class="numeric">1,790</td>
        <td class="numeric">202</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="CMS、デバイス、およびリソースタイプ別の中央値キロバイト", sheets_gid="1561070567", sql_file="cms_bytes_per_type.sql") }}</figcaption>
</figure>

{{ figure_markup(
  image="median-kilobytes-by-cms-and-resource-type-desktop.png",
  caption="デスクトップでのCMSおよびリソースタイプ別の中央値キロバイト",
  description="",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=159460424&format=interactive",
  sheets_gid="1561070567",
  sql_file="cms_bytes_per_type.sql"
) }}

{{ figure_markup(
  image="median-kilobytes-by-cms-and-resource-type-mobile.png",
  caption="モバイルでのCMSおよびリソースタイプ別の中央値キロバイト",
  description="",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvn7rDUZ96mbcJGd-R-gGdofTptGuReAxtTp-jYGUPpXaDO11ef2LjXz_aj-bk7wIA3gvFbEX_El-e/pubchart?oid=1726838193&format=interactive",
  sheets_gid="1561070567",
  sql_file="cms_bytes_per_type.sql"
) }}

上の表およびグラフは、Wixがモバイルイメージの最適化により積極的に取り組んでいることを示しています。Next.jsやNuxt.jsのようなフレームワークを使用しているサイトジェネレーターのセグメントでも同様のパターンが見られます。

この見かけ上小さな洞察は、プラットフォームおよびフレームワークがより持続可能なウェブサイトを提供するために果たす重要な役割を捉えています。適切なデフォルトを適用することにより、プラットフォーム開発者およびフレームワークの著者は、開発者がツールを活用して、[**green by default**](https://screenspan.net/blog/green-by-default/)のサイトを作成できるように支援できます。

## 結論

これは持続可能性に関する最初の **Web Almanac** の章であり、世界中で発生している干ばつ、熱波、その他の気候イベントという象徴的な年に行われます。確かに何か問題があり、見過ごすことがどんどん難しくなっています。ウェブはこれに一役買っており、その環境への影響を理解することが優先事項です。**HTTP Archive** からのアクセス可能なデータを鑑みると、この章はメトリクスを集め、持続可能性に関してウェブの状態を振り返る絶好の機会です。

利用可能なメトリクスに基づくと、一部のベストプラクティスがすでに採用され、徐々に広がっているのが見られます。しかし、まだ多くのことが行われる必要があります。これらのアクションのいくつかは実装が容易ですが、非常に有益であることが証明されるかもしれません。また、ベストプラクティスと実際のデバイスでの措置は、持続可能性の継続的な改善に不可欠です。

持続可能性についての認識を高め、ベストプラクティスを発見し、実装することは、皆に委ねられています。これについての言葉を広め、議論を生み出すことが不可欠です。アクセシビリティと同様に、これは私たち全員に関係しており、ウェブをより持続可能にするために必要なすべてを持っています。

ここで見たほとんどのことは、開発者がウェブサイトをより持続可能にするためにできることを示しています。しかし、さらに進む必要があります。デザインを通じて節度を求める必要があります。プロジェクトマネージャーは持続可能性を優先事項とし、これが後で常に対処できるわけではないことを確認する必要があります。企業は、ビジネスモデルをより持続可能なものにすることを考える必要があります。

この章を通じてウェブの持続可能性についてより意識を高め、現在の持続可能なウェブサイトの状況を理解し、このトピックを扱い、言葉を広めるためのいくつかのツールと手がかりを提供したいと考えています。

### 行動できること

ウェブサイトの持続可能性は考慮されるべきです。今日に至るまで、まだ多くのことが行われる必要があります。必要であれば、上で推奨されたいくつかのリソースから始めて、この件についての認識を高め、言葉を広めるべきです。

既存のウェブサイトで始めるには、次のことができます。

- 画像を最適化する（WebP + 遅延読み込み + レスポンシブ性 + キャッシュ + 品質）し、これが自動的に行われるようにする
- ビデオの実装を避ける。必要な場合、自動再生やプリロードはしない
- より持続可能なホスティングを探す

その後、以下を行うべきです。

- あなたのサードパーティーを整理する。
- 簡単な技術的最適化から始めて、CSSとJavaScriptを最適化し、それを自動化する。
- デザインを見直して、ページをよりシンプルにする（視覚的コンテンツを減らす、アニメーションを減らすなど）し、ユーザージャーニーを合理化する

ウェブサイトをより持続可能にすることは、継続的な改善の一部です。すべてを一度に行うことはできませんし、すべきではありません。ベストプラクティスと測定に依存して、正しい方向に進んでいることを確認してください。既存のウェブサイトで作業をしている場合でも、ゼロから新しいものを作成している場合でも、チーム内の全員を巻き込むか、少なくともこのトピックを認識していることが重要です。

あなたのユーザーの中には、あなたのウェブサイトがより持続可能であること、およびそれをどのように達成したかを知りたいと思う人もいます。そして、それはすべての人にとって利益になります。

_特別な感謝を込めて<a hreflang="en" href="https://www.wholegraindigital.com/team/tom-greenwood/">Tom Greenwood</a>、[Hannah Smith](https://x.com/hanopcan)、[Eugenia Zigisova](https://x.com/jevgeniazi)、[Rick Viscomi](https://x.com/rick_viscomi)およびこの章を可能にした他の素晴らしい人々全員に。_
