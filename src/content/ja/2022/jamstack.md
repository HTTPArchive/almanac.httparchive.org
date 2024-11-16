---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: 2022年のWeb AlmanacのJamstackの章は、Jamstackサイトの量的分析、Jamstackの成長、Jamstack的なフレームワークとホスティングについて扱っています。
hero_alt: Hero image of the Web Almanac chracters using a large gas cylinder with script markings on the front to inflate a web page.
authors: [seldo, whitep4nth3r]
reviewers: [tunetheweb]
analysts: [seldo, tunetheweb]
editors: [DesignrKnight]
translators: [ksakae1216]
seldo_bio: Laurieは1996年からWeb開発者として活動しており、awe.sm（2010年）<a hreflang="en" href="https://www.crunchbase.com/organization/snowball-factory">awe.sm</a> や npm（2014年）<a hreflang="en" href="https://npmjs.com/">npm</a> のような会社を設立するために時々休憩をとっています。現在は、<a hreflang="en" href="https://netlify.com">Netlify</a>でデータエバンジェリストとして働いています。彼はWebをより大きく、より良いものにすることに情熱を注いでいます。そのための最良の方法の1つは、より多くの人々にWeb開発を奨励し、既存の技術を教え、Web開発を容易にするためのツールやサービスを構築することにより、彼らが多くを学ぶ必要がないようにすることだと彼は考えています。
whitep4nth3r_bio: Salmaはあなたのためにコードを書きます。彼女はライブストリーマーで、ソフトウェアエンジニア、開発者教育者でもあり、人々がテクノロジー分野に進むのを手助けすることが好きです。音楽教師およびコメディアンとしてのキャリアの後、2014年にテクノロジー分野に転身し、スタートアップ、エージェンシー、グローバルなeコマースのためのフロントエンド開発とテクノロジーリーダーシップを専門としています。現在はデベロッパーリレーションズで働いています。<a hreflang="en" href="https://twitch.tv/whitep4nth3r">TwitchでSalmaを見つけて</a>、彼女が何を作っているのかを確認してください。
results: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/
featured_quote: Webのどれくらいの割合がJamstackであるかを正確に知ることはできませんが、Webの約3%がJamstack的であり、このグループは過去3年間強く成長していると言えます。これはJamstackコミュニティにとって非常に良い兆候です。
featured_stat_1: ~3%
featured_stat_label_1: 2022年のWeb上のJamstack的なサイト
featured_stat_2: 106%
featured_stat_label_2: 2020年以降のJamstack的なサイトの成長
featured_stat_3: 36%
featured_stat_label_3: Jamstack的なJekyllサイト
---

## 序章

Jamstackについて書く際の最大の問題の1つは、Jamstackが具体的に何であるかを定義することです。ここに3つの異なる定義があります（いくつかの単語を強調しました）。

1. ファイルを事前にレンダリングしてCDNから直接配信することにより、Webサーバーの管理や運用の必要をなくし、迅速かつ安全なサイトとアプリを提供します。

2. Jamstackは、Webをより __高速__ に、より安全に、スケールしやすくするために設計された __アーキテクチャ__ です。開発者が愛用する多くのツールやワークフローを活用し、最大限の生産性を引き出します。

3. Jamstackは、Web体験レイヤーをデータやビジネスロジックから __切り離す__ という __アーキテクチャアプローチ__ であり、柔軟性、スケーラビリティ、__パフォーマンス__、および保守性を向上させます。

上記の定義はすべて<a hreflang="en" href="https://jamstack.org/">Jamstack.org</a>からのもので、それぞれ<a hreflang="en" href="https://web.archive.org/web/20200331214426/https://jamstack.org/">2020年</a>、<a hreflang="en" href="https://web.archive.org/web/20210924115533/https://jamstack.org/what-is-jamstack/">2021年</a>、<a hreflang="en" href="https://web.archive.org/web/20220809174445/https://jamstack.org/">2022年</a>の定義です。Jamstackの定義に関してより権威ある情報源は考えにくいので、定義が移り変わるものであると言えます。

しかし、強調された単語が示すように、明らかに一貫性があります。サイトは迅速であるべきで、事前にレンダリングされ、データを取得する場所とデータをレンダリングする方法を切り離すアーキテクチャアプローチを使用すべきです。正確な辞書の定義は得にくいですが、Jamstack開発者は「Jamstack」と言うと何を意味しているかを理解しています。それは、非常に迅速にロードされ、ビルド時に一度多くの有用なコンテンツをレンダリングし、必要に応じてJavaScriptを介して追加データを取得するサイトです。

<p class="note">開示事項: このレポートの二人の著者はNetlifyの社員でした。NetlifyはJamstackという用語を発明し、Jamstack.orgを所有しています。このレポートとその基になる分析は、Netlifyと無関係の他者によってレビューおよび承認されました。</p>

## Jamstackを定量化する: 何をカウントすべきか？

しかし、2022年のWeb Almanacをまとめようとするとき、問題はもっと複雑になります。何百万ものWebサイトを扱う際、「見たらわかる」という定義では不十分です。私たちはJamstackをどのように定量化すべきでしょうか？どのようにして正確に識別して、それについて学ぶことができるでしょうか？まず、自分たちに一連の質問を投げかけて始めました。

### すべての静的サイトはJamstackサイトですか？

それは明らかに「はい」と思われるかもしれません：もしページが一度にすべてレンダリングされるフラットなHTMLであれば、確かにJamstackのように聞こえます。しかし、JavaScriptが流行する前の90年代に人々が構築したすべてのページはどうでしょうか？それらはJamstackですか？そう感じられませんでした。すべての静的サイトがJamstackサイトというわけではありません。その理由を考えてみました。

私たちはJamstackの初期定義の「CDN」の側面に着地しました。特定のCDNプロバイダーである必要はありませんが、定義の確かな部分は「事前レンダリング」であり、これは何かをレンダリングしてからキャッシュすることを意味します。したがって、Jamstackサイトはキャッシュされるべきです（自分でキャッシュするか、CDNを使用するかは関係ありません）。

これにより別のエッジケースが生じます。多くのサイトがキャッシュされています！完全に動的なサイトでさえ、負荷のピークを避けるために数分間物をキャッシュすることがよくあり、現在では多くのサイトがCDNによって提供されていますが、これはJamstackのパターンには何も借りていないサイトのアーキテクチャであっても本質的にキャッシュです。通常のキャッシュサイトとJamstackサイトの違いは何でしょうか？キャッシュ可能性は一部ですが、他には何がありますか？

### JamstackサイトはJavaScriptを使用する必要がありますか？

Jamstackサイトが必ずしもJavaScriptを使用するわけではないと決めました。もちろん、多くのJamstackサイトは使用します。結局のところ、「J」は元々「JavaScript」の略でした。しかし、Jamstackの最初の定義でも、JavaScriptの使用は任意であり、JavaScriptがなく完全に静的なサイトも常にJamstackでした。

### Jamstackを使用すると特定のフレームワークが必要ですか？

Jamstackについて考えるとき、人々が思い浮かべるいくつかのフレームワークが確かにあります。2020年と2021年のWeb Almanacでは、[Jamstackを使用するフレームワークだけで定義していました](../2021/jamstack)。これにはStatic Site Generators（SSG）に焦点を当てていました。これは十分に理にかなっていますが、いくつかの問題があると思いました。

まず、簡単に検出できないフレームワークはどうでしょうか？例として、<a hreflang="en" href="https://www.11ty.dev/">Eleventy</a>は、Jamstackで成長して人気のある選択肢であり、生成されたHTMLには跡形もありません。それはデフォルトではエンドユーザーには見えませんが、必要に応じて<a hreflang="en" href="https://www.11ty.dev/docs/data-eleventy-supplied/#eleventy-variable">generator tag</a>を追加できます。礼儀正しく邪魔にならないフレームワークを数えないのは間違っているように思えます。

第二にフレームワークが多すぎます！大きなものが何十個もあり、小さなものが数千個あります。検出できるものについても、常に良い検出方法があるわけではありません。さらに、フレームワークをまったく使用せずに「Jamstack的」に感じるサイトを構築することも確かに可能です。プレーンHTMLは確かにJamstackです。

第三にJamstack開発者に人気のあるフレームワークを使用しても、構築するサイトがJamstackサイトになるとは限りません。建築上の理由でレンダリングが非常に遅い場合や、すべてのページを動的にレンダリングする場合は、多くのJamstackサイトが使用している同じフレームワークを使用していても、Jamstackサイトにはなりません。すべてのサイトがJamstackである必要はありませんし、それで問題ありません。

したがって、今回はフレームワークを定義の一部として無視することにしましたが、あとで見るように、予想されるフレームワークが結果に現れました。

### Jamstackサイトはパフォーマンスが高い必要がありますか？

Jamstackの3つの定義に共通している唯一の特徴は __パフォーマンス__ でした。しかし、「速い」という言葉はWebサイトに関してはあいまいです。Web Almanacを読んだことがあれば、Webサイトのパフォーマンスを測定するために使用できる多くの指標があることを知っているでしょうし、それらすべてについての良い議論がたくさんあります。

したがって、Jamstackサイトの感じ方について真剣に考えました。最初に、Jamstackサイトは初期コンテンツを非常に迅速にレンダリングします。使用できる指標がたくさんある中で、その考えをもっとも明確に捉えたのは、<a hreflang="en" href="https://web.dev/lcp/">Largest Contentful Paint</a>、またはLCPでした。これは、ページ上の最大のアイテムがレンダリングされるまでの時間を測定します。APIを介して追加のコンテンツを取り込むことも、しないこともありますが、Jamstackであるためには、何か重要なものを迅速にレンダリングする必要があります。

## 指標の定義

HTTP Archiveでクエリとして表現できるJamstackの正確な定義を選んだ方法の詳細に興味がない場合は、次の2つのセクションをスキップして安全に[Jamstackの成長](#jamstackの成長)まで進むことができます。ここで行動に移す洞察を得るために、私たちの方法論を理解することは重要ではありません。

私たちは測定したいことを知っていました。ほとんどのコンテンツを非常に迅速にロードし、キャッシュ可能なサイトです。これらのことを測定するさまざまな方法を多く実験した後、いくつかの具体的な指標を思いつきました。

__Largest Contentful Paint (LCP)__：すべてのページのすべてのLCP時間の分布を取得し、<a hreflang="en" href="https://developer.chrome.com/docs/crux">Chrome UX Report</a>から実際のユーザーデータの中央値を選び、「もっともコンテンツを迅速にロードした」とみなされる任意のサイトとしました。これはモバイルデバイスで2.4秒、デスクトップデバイスで2.0秒でした。

__Cumulative Layout Shift (CLS)__：非常に迅速にスケルトンをロードするが、実際のコンテンツのロードに長い時間がかかるサイトを避けたいと思いました。それにもっとも近いものは<a hreflang="en" href="https://web.dev/cls/">Cumulative Layout Shift</a>で、ページのレイアウトがロード中にどれだけ跳ねるかを測定します。CLSを「操作」する方法がありますが、私たちはそれが測定しようとしているものの合理的な代理であるとまだ信じています。私たちはこの測定が好きでした、なぜなら「跳ねる」サイトもまた「Jamstack的」ではないと感じられるからです。「Jamstack的」という言葉を多く使うことになるでしょう。再び、Chrome UX Reportのデータの中央値を選びました。

<p class="note">Chrome UX ReportのデータはCLSデータをもっとも近い0.05に丸めますが、それは残念なことです。なぜなら「実際の」中央値は約0.02-0.03のようで、モバイルではゼロに丸められ、デスクトップでは0.05に丸められるからです。0は膨大な数のページを除外するため、私たちはモバイルとデスクトップの両方に最適な閾値として0.05を使用することにしました。</p>

__キャッシュ__：これはとくに定量化が難しいものでした。なぜなら、Jamstackサイトであっても、ほとんどのホームページが実際には長時間キャッシュされているにもかかわらず、再検証を要求するからです。私たちは`Age`、`Cache-Control`、`Expires`を含むHTTPヘッダーの組み合わせを使用しました。これらは長時間キャッシュされる可能性のあるページで一般的に見られました。

当初、私たちは「小さな」サイトを除外するための別の測定が必要だと思っていました。つまり、実際のところ誰も訪れない「まもなく公開」や「Hello world」ページを非常に迅速にロードするサイトです。しかし、HTTP Archiveのデータは<a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#popularity-eligibility">Chromeのユーザー訪問による人気</a>に基づいて定義されており、それらのサイトがサンプルに入るほど十分に訪問されるものはほとんどありません（ただしexample.comは入っています！）。

良い質問は、これらの指標に<a hreflang="en" href="https://web.dev/vitals/">Core Web Vitals</a>（CWV）の数値を使用しない理由は何かということです。LCPについては、私たちの数値はCWVの数値とほぼ同じです。CLSについては、CWVチームが<a hreflang="en" href="https://web.dev/defining-core-web-vitals-thresholds/#achievability-3">要件を緩和しました</a>（彼らの閾値は中央値の2倍以上です）が、私たちはそれがJamstack体験を代表していないと考えました。したがって、両方に中央値を選ぶのが公平だと決めました。そしてCWVには「キャッシュ可能性」の指標はありません。

## "Jamstack的"免責事項

はっきりさせておきたいのは、これは「Jamstack」の非常に非常に曖昧な定義です。実際、この作業を行っているときに「Jamstack的」という言葉を使い始めました。

最大の誤差の源泉は基本的なものです。Jamstackの定義は_アーキテクチャ_に関するものですが、アーキテクチャは生成されたHTMLをクロールすることで、非常に広い意味でしか判断できません。HTMLの山を見て、フロントエンドとバックエンドが切り離されているかどうかを判断する方法は単純にありません。したがって、私たちの測定は最善の努力であり、大まかな見積もりであり、それを誤解されたくありません。

この方法論はJamstackサイトを過少評価も過大評価もします：

* あなたのサイトが静的であるが切り離されていない場合（たとえば、<a hreflang="en" href="https://www.squarespace.com/">SquareSpace</a>と<a hreflang="en" href="https://www.wix.com/">Wix</a>のサイトは明らかにバックエンドと密接に結びついています）、パフォーマンスが良ければ過大評価されます。
* あなたのJamstackサイトが切り離されているが、コンテンツを非常に頻繁に更新する場合、キャッシュ戦略が私たちが求めるものと異なるかもしれないので、過少評価されます。
* あなたのJamstackサイトが切り離されているが非常に遅くレンダリングされる場合、LCP数値が高くなり、過少評価されます。
* 逆に、あなたの非Jamstack動的サイトが非常に速い場合、それをJamstackと誤って判断し、過大評価するかもしれません。

これらすべての注意事項にもかかわらず今年の「Jamstack的」サイトの見積もりは、厳密にSSGに焦点を当てた定義を改善しており、結局のところAlmanacの目標である、今日のWebが実際にどこにあるのかについてのより良い感覚を与えます。

## Jamstackの成長

新しい基準を適用して、HTTP Archiveで「Jamstack」として分類されるサイトの割合を測定しました。2020年と2021年の測定方法が非常に異なっていたため、2022年の定義を使用してそれらのサンプルを再測定しました。

{{ figure_markup(
  caption="Jamstackサイト。",
  description="2020年、2021年、2022年のデスクトップとモバイルでのJamstackサイトの割合を示す棒グラフ。2020年はデスクトップとモバイルともに1.7%、2021年はそれぞれ2.2%と2.1%、2022年はデスクトップで2.7%、モバイルで3.6%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=2132409776&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack_counts.sql",
  image="jamstack-counts.png"
  )
}}

主な発見は、2022年にはモバイルWebサイトの3.6%が「Jamstack的」であり、2020年以来100%以上成長していることです。デスクトップでは2.7%のサイトがJamstack的であり、この数値も成長していますが、この2つのグループ間の違いは主にデバイスによるレイアウトの違いによってCLS閾値を満たすサイトの数が異なるためです。再び、これがどれほど近似的であるかについての多くの注意事項を上で見てください。

新しい定義での歴史的な数値は、[昨年測定されたものよりかなり高い](../2021/jamstack#SSGの採用)です。これは使用されている技術に基づいて採用を完全に判断したときのことです。Jamstackと見なされていなかった技術も含む一部の技術を検出する限界を考慮すると、これはおそらく驚くべきことではありません。

私たちが無作為に選んだサイトのセットをサンプリングしたとき、私たちが判断できる限り、見た目や感じがJamstackサイトのように思えるサイトを見つけていることにほとんど満足していました。

自分自身で判断し、私たちを正直に保つために、ここに完全に無作為に選ばれた10の「Jamstack的」サイトがあります。どのようなキュレーションも行っていません。

- <a hreflang="en" href="https://www.cazador-del-sol.de/">www.cazador-del-sol.de</a>
- <a hreflang="en" href="https://snpbooks.org/">snpbooks.org</a>
- <a hreflang="en" href="https://eikounoayumi.jp/">eikounoayumi.jp</a>
- <a hreflang="en" href="https://rochesteronline.precollegeprograms.org/">rochesteronline.precollegeprograms.org</a>
- <a hreflang="en" href="https://surveyforcustomers.com/">surveyforcustomers.com</a>
- <a hreflang="en" href="https://www.shopmate.eu/">www.shopmate.eu</a>
- <a hreflang="en" href="https://docs.saleor.io/">docs.saleor.io</a>
- <a hreflang="en" href="https://www.wildeyebrewing.ca/">www.wildeyebrewing.ca</a>
- <a hreflang="en" href="https://360insurancegroup.com/">360insurancegroup.com</a>
- <a hreflang="en" href="https://144onthehill.co.uk/">144onthehill.co.uk</a>

Webの3.6%（またはデスクトップの2.7%）が正確にJamstackであるかどうかは、Jamstackの定義が検証できないアーキテクチャの選択に依存しているため、私たちは確実に言うことはできませんが、Jamstackが成長していることは確かです。私たちの基準を満たすサイトの割合は年々着実に増加しています。Webはより「Jamstack的」になっています。

もちろん、私たちの定義が2つのパフォーマンス指標とキャッシング指標であるため、間違っている可能性の1つは、Webが一般的によりパフォーマンスが向上している場合です。それを確認するために、指標を再び分割しました（これはモバイルデータです。デスクトップデータは大きく異なりませんでした）。

{{ figure_markup(
  caption="モバイルでの時間の経過とともにJamstack指標の変化。",
  description="2020年、2021年、2022年からの3つのJamstack指標の変化を示す折れ線グラフ。2020年と2021年の間はほぼ静的でしたが、昨年CLSの割合が上昇しました（48%から61%へ）、LCPも若干上昇しました（44%から50%へ）。キャッシュ可能な割合はすべての年で11%でほぼ静的でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=806511079&format=interactive",
  sheets_gid="1068922155",
  sql_file="percentage_jamstack_criteria_per_year.sql",
  image="changes-in-jamstack-counts-over-time.png"
  )
}}

ご覧のとおり、2020年から2022年までの私たちの指標にはわずかな改善がありました。しかし、ここでもっとも小さな数値である「私たちのキャッシング基準を満たすサイトの割合」は、年とモバイルまたはデスクトップを問わず、Webの11-14%です。Jamstackサイトの私たちのセットはこれらのグループの交差点です。これら3つの基準を同時に満たすサイトのセットは、個々のグループよりもはるかに小さいです。

したがって、私たちは本当にサイトの独特なサブセットを見ており、そのセットはWeb全体のパフォーマンスの改善よりもはるかに速く成長しています。私たちは単に「どれだけの高速サイトがあるか」を測定しているわけではありません。

## Jamstack-y フレームワーク

Jamstack-yサイトが実際に存在し、識別可能であることを確認したので、これからいくつかの質問をしてみましょう。ここからが楽しいところです。Jamstack-yの定義にフレームワークが含まれていないため、私たちはサイトを見て、Jamstackでもっとも頻繁に現れるフレームワークを見ることができます。

Wappalyzerが提供するフレームワークの識別を使用しましたが、これには（以前に言及したように）Eleventyのような「見えない」フレームワークは含まれておらず、数えたり分析したりすることはできません。

Wappalyzerには、「ウェブフレームワーク」と「JavaScriptフレームワーク」というやや任意的な区別があります。こちらが全体のウェブでトップ10のJavaScriptフレームワークです。

{{ figure_markup(
  caption="全サイトで使用されているJavaScriptフレームワーク。",
  description="棒グラフで示されているのは、デスクトップサイトの8.2%とモバイルサイトの8.1%でReactが使用されており、それぞれ6.9%と7.7%でGSAPが3.1%と2.8%でVue.jsが2.3%と2.3%でRequireJSが1.9%と1.8%でstyled-componentsが1.8%と1.5%でHandlebarsが1.7%と1.4%でBackbone.jsが1.4%と1.1%でAngularJSが1.1%と1.3%でMustacheがそして最後に0.9%のデスクトップと1.1%のモバイルサイトでMooToolsが使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1813867996&format=interactive",
  sheets_gid="496656547",
  sql_file="jamstack_javascript_frameworks.sql",
  image="all-sites-javascript-frameworks.png",
  width=600,
  height=489
  )
}}

Jamstackサイトでのトップ10は以下の通りです。

{{ figure_markup(
  caption="Jamstackサイトで使用されているJavaScriptフレームワーク。",
  description="棒グラフで示されているのは、デスクトップのJamstackサイトで12.0%、モバイルで12.5%でReactが使用され、それぞれ6.4%と7.3%でGSAPが6.0%と5.6%でStimulusが3.4%と4.5%でRequireJSが2.3%と1.9%でVue.jsが1.5%と1.6%でstyled-componentsが0.7%と1.8%でMustacheが1.0%と1.5%でAMPが1.3%と0.8%でEmotionがそして最後にデスクトップで1.2%、モバイルで0.8%でGatsbyが使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=691994111&format=interactive",
  sheets_gid="496656547",
  sql_file="jamstack_javascript_frameworks.sql",
  image="jamstack-javascript-frameworks.png",
  width=600,
  height=489
  )
}}

一般的なウェブと比較して、JamstackではReactやGatsbyがより人気があることがわかります。次に、「ウェブフレームワーク」について見てみましょう。これもWappalyzerによってやや任意的に定義されています。

{{ figure_markup(
  caption="全サイトで使用されているウェブフレームワーク。",
  description="棒グラフで示されているのは、デスクトップサイトの8.4%とモバイルサイトの6.7%でMicrosoft ASP.NETが使用されており、それぞれ1.4%と1.1%でRuby on Railsが1.0%と1.0%でLaravelが0.8%と0.7%でExpressが0.8%と0.7%でNext.jsが0.7%と0.7%でCodeIgniterが0.5%と0.4%でNuxt.jsが0.3%と0.3%でDjangoが0.3%と0.3%でHelix Ultimateがそして最後にデスクトップで0.3%、モバイルで0.2%でYiiが使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=193748603&format=interactive",
  sheets_gid="1751614355",
  sql_file="jamstack_web_frameworks.sql",
  image="all-sites-web-frameworks.png",
  width=600,
  height=493
  )
}}

質問はおもしろいです。Next.jsとNuxt.jsがウェブフレームワークとみなされ、Vue.jsとReactはJavaScriptフレームワークとみなされる理由は何でしょうか？さておき、MicrosoftのASP.NetフレームワークがWeb全体で非常に人気がありますし、Ruby on Railsも同様です。Jamstackではどうでしょうか？

{{ figure_markup(
  caption="Jamstackサイトで使用されているウェブフレームワーク。",
  description="棒グラフで、デスクトップのJamstackサイトで3.5%、モバイルで3.1%がMicrosoft ASP.NETを使用しており、Symfonyはそれぞれ2.1%と1.8%、Next.jsは1.8%と1.4%、Ruby on Railsは0.7%と0.8%、Nuxt.jsは0.6%と0.4%、CodeIgniterは両方0.4%、Djangoは0.4%と0.3%、Expressは0.4%と0.3%、最後にLaravelとYiiはデスクトップとモバイルのJamstackサイトの0.2%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1904684465&format=interactive",
  sheets_gid="1751614355",
  sql_file="jamstack_web_frameworks.sql",
  image="jamstack-web-frameworks.png",
  width=600,
  height=493
  )
}}

ご覧の通り、JamstackではASP.Netが依然として第一のウェブフレームワークですが、Ruby on Railsはそれほど人気がありません。代わりにJamstackのお気に入りであるNext.jsが第五位から第三位に、Nuxt.jsは第七位から第五位に上昇しました。驚くべき追加はSymfonyで、一般的なサイトでは11位ですが、私たちのJamstackセットでは第二位まで上昇しました。

Next.jsとNuxt.jsがJamstackコミュニティでもっとも大きなフレームワークであることから、これは大きな驚きではありませんが、フレームワークに依存しない定義が「Jamstack-y」サイトを正しく特定しているのを見るのは再び良いことでした。

一見すると、ASP.NetがまだJamstack-yグループで第1位であり、PHPベースのSymfonyが第2位になるのはさらに驚くかもしれません。しかし、ASP.NETやPHPを使用しても、パフォーマンスの高い、現代的なサイトを構築する理由はありません。Jamstackは特定の技術リストではなく、建築的アプローチですので、流行に乗っていない技術スタックで働く人々にとっては励みになる結果だと思います。

SSGについてはどうでしょうか？Wappalyzerはそれらを別のカテゴリとしています。ここに両方のサイトでの数値があります（注：私たちはNuxt.jsとNext.jsを手動でこのリストに追加しました。WappalyzerはそれらをSSGとはみなしませんが、どちらもそのように使用することができるので、それらを考慮するのは有用だと思いました）。全サイトに対するそれらの数値です。

{{ figure_markup(
  caption="すべてのサイトで検出可能なSSG。",
  description="棒グラフで、Next.jsはデスクトップサイトの0.74%とモバイルサイトの0.63%で使用されており、Nuxt.jsはそれぞれ0.45%と0.40%、Gatsbyは0.22%と0.21%、Hugoは0.09%と0.06%、Jekyllは0.07%と0.03%、Docusaurusは0.02%と0.01%、Hexoは0.02%と0.00%、Gridsomeは0.01%と0.01%、最後にSitePadとAstroはモバイルとデスクトップのサイトの0.00%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=582270948&format=interactive",
  sheets_gid="1299424402",
  sql_file="jamstack_ssgs.sql",
  image="all-sites-web-frameworks.png",
  width=600,
  height=496
  )
}}

Jamstackサイトについては、こちらです。

{{ figure_markup(
  caption="Jamstackサイトで検出可能なSSG。",
  description="棒グラフで、Next.jsはデスクトップのJamstackサイトで1.79%、モバイルで1.40%で使用されており、Gatsbyはそれぞれ1.19%と0.81%、Hugoは0.77%と0.49%、Jekyllは0.85%と0.34%、Nuxt.jsは0.56%と0.41%、Docusaurusは0.19%と0.09%、Hexoは0.16%と0.04%、Gridsomeは0.05%と0.03%、Octopressは0.02%と0.01%、最後にAstroはデスクトップとモバイルのJamstackサイトで0.02%と0.01%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1349389169&format=interactive",
  sheets_gid="1299424402",
  sql_file="jamstack_ssgs.sql",
  image="jamstack-web-frameworks.png",
  width=600,
  height=496
  )
}}

ご覧のとおり、ほぼ同じリストで、ほぼ同じ順序ですが、Nuxtはいくつかの位置を下げています。これは直感的に理解できます。SSGによって生成されたサイトはJamstack-yと資格を得ることが期待されますが、それがその建築目標を達成する唯一の方法では明らかにありません。

SSGは、すべてのサイトではなく、すべてのJamstackサイトのはるかに大きな割合を占めており、SSGを使用することはJamstackサイトを入手するためのかなり良い方法であることを示しています。しかし、SSGを使用してもJamstackサイトが作成されるとは限りません。こちらは私たちのサンプルのいくつかのフレームワークの総数です。

<figure>
  <table>
    <thead>
      <tr>
        <th>SSG</th>
        <th>すべてのサイト</th>
        <th>Jamstackサイト</th>
        <th>Jamstack %</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Next.js</td>
        <td class="numeric">39,928</td>
        <td class="numeric">2,651</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>Nuxt.js</td>
        <td class="numeric">24,600</td>
        <td class="numeric">824</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>Gatsby</td>
        <td class="numeric">12,014</td>
        <td class="numeric">1,765</td>
        <td class="numeric">15%</td>
      </tr>
      <tr>
        <td>Hugo</td>
        <td class="numeric">5,071</td>
        <td class="numeric">1,135</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td>Jekyll</td>
        <td class="numeric">3,531</td>
        <td class="numeric">1,259</td>
        <td class="numeric">36%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="デスクトップでのJamstackサイトにおけるSSGの割合。",
      sheets_gid="1299424402",
      sql_file="jamstack_ssgs.sql",
    ) }}
  </figcaption>
</figure>

すべてのSSGで、私たちの定義によるJamstack-yと資格を得たサイトの割合は、そのフレームワークの総サイト数よりも少なかったです。Jekyllがもっとも良い結果を出し、Jekyllのサイトの3分の1以上が私たちの基準を満たしていました。NextとNuxtはとくに低い割合で、これは予想されることです。これらはSSGとして使用できますが、しばしば動的サイトを作成するために使用され、私たちはどのモードであるかを判断する方法がありません。

## Jamstack-yホスティング

私たちは、人々がJamstack-yサイトをどこでホストしているかにも興味がありました。パターンはあるでしょうか？再び、私たちはWappalyzerのデータを使用して技術を特定しましたが、今回は彼らのPlatform as a Service (PaaS)カテゴリーを使用しました。

{{ figure_markup(
  caption="すべてのサイトで使用されるPaaS。",
  description="棒グラフで、Amazon Web Servicesはデスクトップサイトの7.2%とモバイルサイトの5.9%で使用されており、WP Engineはそれぞれ1.7%と1.1%、Azureは1.1%と0.9%、WordPress.comは0.8%と1.1%、SiteGroundは0.7%と0.6%、Herokuは0.4%と0.3%、Kinstaは0.4%と0.3%、Flywheelは0.3%と0.2%、Aruba.itは0.2%と0.4%、最後にNetlifyはデスクトップとモバイルのサイトで0.3%と0.2%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=966567769&format=interactive",
  sheets_gid="351874654",
  sql_file="jamstack_paas.sql",
  image="all-sites-paas.png",
  width=600,
  height=473
  )
}}

そしてJamstackサイトについてはこちらです。

{{ figure_markup(
  caption="Jamstackサイトで使用されるPaaS。",
  description="棒グラフで、Amazon Web ServicesはデスクトップのJamstackサイトで10.8%、モバイルで9.4%で使用されており、GitHub Pagesはそれぞれ4.6%と2.0%、Netlifyは2.4%と1.7%、Pantheonは2.1%と1.7%、Vercelは1.6%と1.1%、Acquia Cloud Platformは1.4%と1.2%、Cloudwaysは0.7%と0.9%、Azureは0.7%と0.7%、Platform.shは0.4%と0.3%、最後にHerokuはデスクトップとモバイルのJamstackサイトで0.3%と0.2%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=437110555&format=interactive",
  sheets_gid="351874654",
  sql_file="jamstack_paas.sql",
  image="jamstack-paas.png",
  width=600,
  height=473
  )
}}

ウェブの巨人であるAmazon Web Servicesは両方のセットで支配的ですが、全体的な好みとJamstack-y開発者の好みの間にはいくつかの重要な違いがあります。

WP Engine、Azure、WordPress.comはWeb全体で非常に人気がありますが、Jamstackコミュニティ内での人気は大幅に低下しています。GitHub Pagesは広いウェブでは11位ですが、Jamstackセットでは2位です。一方、Jamstack開発者のお気に入りであるNetlifyとVercelは、それぞれ3位と5位を占めており、大きなウェブではNetlifyは10位、Vercelは14位（表示されていません）です。PantheonとAcquia Cloud Platformは、全体でトップ10に入っていませんが、それぞれ11位から4位、12位から6位に大幅に跳ね上がりました。

これらのホストの相対的な人気が広いウェブに対してどのように変化したかは、それらがすべて世帯名ではないため、少し驚くかもしれませんが、2021年から2022年にかけて私たちのセットでプラットフォームの好みがどのように変わったかを見る価値があると思いました。モバイルデータを使用して、2021年から2022年にかけてJamstackサイトでさまざまなプラットフォームを使用する割合がどのように変わったかです。

<figure>
  <table>
    <thead>
      <tr>
        <th>PaaS</th>
        <th class="numeric">2021</th>
        <th class="numeric">2022</th>
        <th>Change</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Amazon Web Services</td>
        <td class="numeric">7.00%</td>
        <td class="numeric">9.45%</td>
        <td class="numeric">2.45%</td>
      </tr>
      <tr>
        <td>GitHub Pages</td>
        <td class="numeric">2.62%</td>
        <td class="numeric">1.99%</td>
        <td class="numeric">-0.63%</td>
      </tr>
      <tr>
        <td>Pantheon</td>
        <td class="numeric">1.97%</td>
        <td class="numeric">1.70%</td>
        <td class="numeric">-0.27%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">1.68%</td>
        <td class="numeric">1.72%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>Acquia Cloud Platform</td>
        <td class="numeric">1.37%</td>
        <td class="numeric">1.18%</td>
        <td class="numeric">-0.20%</td>
      </tr>
      <tr>
        <td>Vercel</td>
        <td class="numeric">0.50%</td>
        <td class="numeric">1.10%</td>
        <td class="numeric">0.60%</td>
      </tr>
      <tr>
        <td>Cloudways</td>
        <td></td>
        <td class="numeric">0.91%</td>
        <td class="numeric">N/A</td>
      </tr>
      <tr>
        <td>Azure</td>
        <td></td>
        <td class="numeric">0.67%</td>
        <td class="numeric">N/A</td>
      </tr>
      <tr>
        <td>Platform.sh</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.29%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Heroku</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.22%</td>
        <td class="numeric">-0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="JamstackサイトのSSGs割合（デスクトップ）。",
      sheets_gid="1299424402",
      sql_file="jamstack_ssgs.sql",
    ) }}
  </figcaption>
</figure>

GitHub Pages、Pantheon、Acquia Cloud Platform、Herokuは人気が下がっている一方で、AWS、Netlify、Vercel、Platform.shはより人気が出ています。2021年のPaaSデータにCloudwaysやAzureが含まれていないため、これらとの比較はできません。AWS、Netlify、Vercelが人気を集めているのは、単なるホスティングではなく、開発者のワークフローに役立つツールのスイートを提供しているからと推測できます。

すべてのプラットフォームリストから欠けているのは、Webの巨人であるCloudflareですが、WappalyzerはCloudflareをPaaSではなくCDNとして分類しています。ただし、Cloudflareには非常にJamstack的なPaaSオファリングであるCloudflare Pagesがありますが、Wappalyzerのデータは「CDN上でホストされている」と「そのCDN上に一部のアセットをホストしている」とを区別していないため、この分析には含めることができませんでした。著者は、Cloudflareが非常に人気のあるJamstackホスティングオプションであると考えていますが、これを確認するための良いデータはありません。

## 結論

今年の分析からもっとも重要な洞察は、HTTP Archiveのデータだけを見てJamstackを測定することは困難であるということです。それでも、プラットフォームやフレームワークに依存しない測定アプローチを使用して、結果のデータから「既知」のJamstackプラットフォームやフレームワークと強い相関関係を見出すことができたのは、ArchiveでJamstackサイトを確実に特定できるようになったことの励みになりました。

Webの何パーセントがJamstackであるか正確にはわかりませんが、Webの約3%がJamstack的であり、このグループは過去3年間で強く成長していると言えます。これはJamstackコミュニティにとって良い兆候です。

また、一部のフレームワークやホスティングプラットフォームは、広いWebよりもJamstackでより人気があることがわかりました。これは、技術的に当社の基準を達成するのに優れているためか、または単にJamstack開発者が特定のスタックを好むコミュニティの好みがあるためかもしれません。

もちろん、Jamstackコミュニティが特定のプラットフォームやフレームワークを好むと、それは自己強化のトレンドとなります。これにより、それらのツールを使用してJamstackサイトを実現する方法に関するドキュメントやチュートリアルが増え、これらのツールを使ってJamstackサイトを構築することが容易になります。したがって、任意のテクノロジースタックでJamstack的な結果を達成できると信じていますが（データもそれを示しています）、Jamstackサイトを達成するのに役立つツールやプラットフォームを特定するのにこのデータが役立つことを願っています。

また、Jamstackサイトを構築する際に目指すべきより確かな目標を持つことが、「Jamstackとして数えるもの」を定量化するこの試みから得られる最終的な有用な洞察であると信じています。特定のフレームワークを選んでそれを忘れるというわけではありません。結果についてです。LCPやCLSの時間を分析することで、努力が「Jamstack的」であるかどうかを定量化できることは、自動化できる有用なことです。
