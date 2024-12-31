---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: モバイル・ウェブ
description: 2020年版Web Almanacのモバイルウェブの章では、ページの読み込み、テキストコンテンツ、ズームとスケーリング、ボタンとリンク、フォームへの入力のしやすさなどを解説しています。
hero_alt: Hero image of Web Almanac characters squeezing a web page onto a mobile screen.
authors: [spanicker, mdiblasio]
reviewers: [foxdavidj]
analysts: [foxdavidj]
editors: [exterkamp]
translators: [ksakae1216]
spanicker_bio: Shubhie Panickerは、Chromeのウェブフレームワークエコシステムへの取り組みを担当するエンジニアリングリーダーで、オープンソースツール、フレームワーク、コミュニティとのコラボレーションを行っています。Chromeのウェブプラットフォームチームのメンバーとして、ウェブ標準や、いくつかのウェブパフォーマンスAPIに対するchromiumの実装に取り組んできました。Chrome以前は、検索やGoogle PhotosなどのGoogle製品のインフラやウェブフレームワークに携わっていました。
mdiblasio_bio: Michael DiBlasioは、Googleのウェブエコシステムコンサルタントです。マイケル・ディブラジオは、ウェブエコシステムの健全性を高め、クリエイターやパートナーにとってウェブが商業的に成り立つようにするための支援に注力しています。彼は、戦略的な小売業者と密接に協力して、新しい最新のウェブ技術を採用し、既存のウェブ体験の質を向上させています。Google以前は、IBMのコンサルタントを務めていました。
discuss: 2048
results: https://docs.google.com/spreadsheets/d/1DGLY7UEWOlDL5_2dtS_j2eqMjiV-Rw5Fe2y6K6-ULvM/
featured_quote: モバイル・ウェブは過去10年間で爆発的に成長し、今や多くの人がウェブを体験する主要な手段となっています。それにもかかわらず、エンゲージメントやオンラインセールスはデスクトップに比べてまだ遅れています。本章では、モバイルウェブの最近のトレンドを紹介するとともに、ユーザーの旅の完了が困難になりがちな理由を分析します。
featured_stat_1: 41.20%
featured_stat_label_1: 不適切なサイズの画像が掲載されているページの割合
featured_stat_2: 60.1%
featured_stat_label_2: 検索入力の存在が確認できないEコマースのランディングページの割合
featured_stat_3: 2.6s
featured_stat_label_3: 75パーセンタイルのモバイル用LCP
---

## 序章
モバイル・ウェブは過去10年間で爆発的に成長し、今や多くの人がウェブを体験する主要な手段となっています。それにもかかわらず、エンゲージメントやオンラインセールスはデスクトップに比べてまだ遅れています。本章では、モバイルウェブの最近のトレンドを紹介するとともに、ユーザーの旅の完了が困難になりがちな理由を分析します。

2020年は、世界的なパンデミックの影響で、モバイルとデスクトップの両方で、<a hreflang="en" href="https://www.nytimes.com/interactive/2020/04/07/technology/coronavirus-internet-use.html">インターネットの使用量</a>が大幅に増加しました。世界中の人々が専業主婦の注文や社会的な距離を置いた新しいライフスタイルに順応したことで、ニュースサイトやeコマース、ソーシャルメディアサイトへのアクセスが増加しました。2020年はウェブにとっても、モバイル利用にとっても、歴史的に重要な年となりました。

### データソース
この章では、いくつかの異なるデータソースを使用しました。

* [CrUX](./methodology#chrome-ux-report)
* [HTTP Archive](./methodology#dataset)
* [Lighthouse](./methodology#lighthouse)

各データソースの方法論や注意点については、上記のリンクを参照してください。なおHTTP ArchiveおよびLighthouseのデータは、ウェブサイトのトップページのみから抽出したデータに限定されており、サイト全体のデータではありませんのでご注意ください。

上記に加えて、Chromeでのページロードのセクションでは、非公開のChromeデータソースを使用しました。これについては、<a hreflang="en" href="https://chromium.googlesource.com/chromium/src/+/master/services/metrics/ukm_api.md">Chromeのデータ収集API</a>をお読みください。

このデータは、（オプトインした）Chromeユーザーのサブセットからのみ収集されていますが、ホームページに限定されているという問題はありません。このデータは仮名で、ヒストグラムとイベントで構成されています。

<p class="note">注：レポートは、ユーザーがブラウザのウィンドウを同期する機能を有効にしている場合、「検索と閲覧をより快適にする/訪問したページのURLをGoogleに送信する」の設定を無効にしていない限り、有効になります。</p>

## モバイルウェブとデスクトップのトラフィック傾向

ユーザーは、モバイルウェブとデスクトップでどのくらいウェブサイトを訪れているのでしょうか？　モバイルとデスクトップのトラフィックには、何かパターンがあるのでしょうか？　これらの疑問と、それがウェブサイトにとってどのような意味を持つのかを検証するために、私たちはいくつかのレンズからデータを調べました。

perficient.comで公開されている<a hreflang="en" href="https://www.perficient.com/insights/research-hub/mobile-vs-desktop-usage-study">レポート</a>では、<a hreflang="en" href="https://www.similarweb.com/">similarweb</a>をデータソースとして、数年間のモバイルとデスクトップのトラフィックの傾向を示しています。サイト訪問の大部分（**58％**）がモバイルデバイスからのものであるにもかかわらず、オンラインでの総滞在時間に占めるモバイルデバイスの割合は42％にとどまっています。さらに、1回の訪問あたりの平均滞在時間は、モバイルに比べてデスクトップでは約2倍となっています（デスクトップ：11.52分、モバイル：5.95分）。

### Chromeでのページロード（Chromeのデータソース）

このセクションでは、本章のために特別に公開されたChromeの非公開データソース[詳細はこちら](#データソース)の統計データを参照しています。このデータを使って、AndroidとWindowsでのページロードを評価しています（それぞれモバイルとデスクトップの代理としています）。

<p class="note">注：この項では、Androidの場合はモバイル、Windowsの場合はデスクトップと表記することがあります。</p>

#### オリジン間のページロードを人気順に表示

オリジンへのトラフィックを人気度別に見ると、ユーザーが特定のオリジンにどのくらいの頻度でアクセスしているか、それによってウェブ上の世界的な分布がどうなっているかがわかります。

Rick Byersが1年前にこの分布を[ツィート](https://x.com/RickByers/status/1195342331588706306)していたので、最新のデータを見てみました。このグラフは、オリジンの人気度による全体的な分布を、Chromeでのページロード（％）への貢献度で示したものです。

{{ figure_markup(
  image="page-loads-across-origins-ranked-by-popularity.png",
  caption='オリジン間のページロードを人気順に並べたもの（Chromeの場合）',
  description="モバイルとデスクトップの両方で、少数のオリジンがトラフィックの大部分を占めていることを示すグラフ。上位30のオリジンがモバイルの総トラフィックの25％を占める。上位200のオリジンがモバイルの総トラフィックの33％を占める。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=949521302&format=interactive",
  sheets_gid="1301196247"
  )
}}

いくつかの収穫がありました。

* Chromeの使用率は、上位200サイト、次の10,000サイト、残りのすべてのサイトでほぼ均等に分かれています。
* ウェブには、**頭でっかち**なところがあります。
  * モバイル、デスクトップともに、少数のオリジンがトラフィックの大部分を占めています。
  * 上位の30オリジンは、モバイルでの総トラフィックの25％を占めています。
  * 上位200のオリジンは、モバイルでの総トラフィックの33％を占めています。
* ウェブには**幅広い胴体**があります。
  * 上位1万のオリジンがトラフィックの約3分の2を占めます。モバイルでのトラフィックの64％を占めています。
* ウェブには **長い尾** があります。
  * Androidでは上位98％に3万のオリジンが入っているのに対し、Windowsでは180万のオリジンが入っています。
  * Androidでは、Windowsに比べて約2倍の長さの尾を引いています。これは、デスクトップに比べてモバイル端末やユーザーの数が多いことに起因すると考えられます。

#### モバイルからのサイトへのトラフィックとデスクトップからのトラフィックの比較（CrUX）

*モバイルとデスクトップのトラフィック分布の予想について、ウェブサイトは推論できますか？*

モバイルとデスクトップの配分は、サイトによって大きく異なるため、予測は難しいです。さらに業界のカテゴリー（例：エンターテインメント、ショッピング）や、サイトがネイティブアプリを持っているか、ネイティブアプリをどれだけ積極的に宣伝しているかなどにも大きく左右されます。

CrUXデータセットを利用して、モバイルデバイスとデスクトップからのChromeトラフィックを評価しました。

{{ figure_markup(
  image="mobile-traffic-distribution.png",
  caption='モバイルとその他のトラフィックの分布',
  description="ほとんどのウェブサイトのトラフィックの大半がモバイルであることを示すグラフ。分析したウェブサイトの50％が、トラフィックの77.61％以上をモバイルから受け取っています（2019年の79.93％からわずかに減少しています）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1290224874&format=interactive",
  sheets_gid="2049480794"
  )
}}

この分布は、モバイルが多いようです。その理由としては、総トラフィックは少ないものの、モバイルからのトラフィックしか得られないサイトが多数（CrUXでは200万以上）存在することが挙げられます。前のセクションで見たように、モバイルははるかに長い「テール」を持っています。

CrUXのデータがあるすべてのウェブサイトをバケツに入れてランダムに選ぶと、選んだウェブサイトの50％がモバイルからのトラフィックの77.61％以上を占めていることになります（2019年の79.93％から少し減少しています）。

これは興味深い観察結果ですが、モバイルとデスクトップの大まかな傾向についてCrUXから結論を出すのは難しいことに注意してください。なぜなら:
* CrUXはChromeのみのデータで、主要なモバイルブラウザであるSafariを含む他のブラウザが欠けています。
* Chromeの場合でも、これはオプトインしたユーザーの一部であり、オプトイン率やプラットフォーム間の差異の影響を受けます。

#### トレンドの結論

では、モバイルとデスクトップのトラフィックを比較することで、どのようなことがわかったのでしょうか。

モバイルとデスクトップのトラフィック配分は、サイトによって大きく異なり、業界カテゴリやネイティブアプリの有無などの他の要因にも左右されます。しかしChromeでのサイト訪問では、ユーザーがデスクトップでより多くの時間を過ごしているにもかかわらず、あるウェブサイトのトラフィックは主にモバイルウェブからのものである可能性が高いと考えられます。これは、モバイルChromeのテールがはるかに長いためです。

個々のウェブサイトについて、モバイルとデスクトップのトラフィック分布の予想を一般化することはできませんが、自社サイトの分布を<a hreflang="en" href="https://www.perficient.com/insights/research-hub/mobile-vs-desktop-usage-study">業界カテゴリの分布</a>と比較することは価値があります。

もしあなたのウェブサイトが業界平均と大きく異なる場合は、その原因を探る価値があるかもしれません。たとえば、ロードパフォーマンスの悪さが原因の1つになるかもしれません。

## ユーザーの旅

モバイル・ウェブでのユーザーの旅は、コマーシャルの旅を含めて、完了するのが難しいです。

モバイルは小売サイトでの滞在時間の79.6％を占める一方で、<a hreflang="en" href="https://www.emarketer.com/content/frictionless-commerce-2020">eコマースの売上</a>の32.3％しか占めていません。これは、ユーザーがモバイルで行動を開始しても、最終的にはデスクトップで行動することが多いことを示しています。これはなぜでしょうか？

このような疑問を解決するためには、まず、ユーザーの旅の要素を理解する必要があります。

私たちは、ユーザーの旅を4つのフェーズに分けています。

### 1. 取得

ウェブサイトにとって、訪問者の獲得は重要なエントリーフェーズです。獲得とは、検索エンジンや広告のクリック、他のサイトからのリンク、ソーシャルメディアなどを通じて、ウェブサイトに訪問者を集めることです。

#### SEO

獲得段階ではSEOが重要で検索エンジンは、ウェブサイトに訪問者を送り込み、ユーザーの旅を開始させる重要なソースです。SEO対策の主な目的は、検索エンジン（ページをクロールしてインデックスを作成する検索エンジンボット）と、ウェブサイトを閲覧してコンテンツを消費するユーザーのためにウェブサイトを最適化することです。

現在、多くのユーザーがモバイルで検索を開始しています。

##### レスポンシブWebデザイン

ウェブの閲覧や検索にモバイル端末が普及したことにより、Google検索は数年前に<a hreflang="en" href="https://developers.google.com/search/blog/2016/11/mobile-first-indexing">モバイルファーストインデックス</a>へ移行しました。これは、検索ランキングがモバイルユーザーから見たページを考慮することを意味しており、モバイルフレンドリーがランキング要因となっています。Googleは2021年3月に、すべてのサイトを対象に、<a hreflang="en" href="https://developers.google.com/search/blog/2020/07/prepare-for-mobile-first-indexing-with">モバイルファーストインデックス</a>へ全面的に切り替える予定です。

ウェブサイトは、検索ユーザーからのトラフィックに影響を与えるため、良好な検索体験とSEOのために、モバイルフレンドリ性を確保する必要があります。そのためには、<a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/responsive-design">レスポンシブWebデザイン</a>が推奨されます。

レスポンシブWebサイトでは、viewport metaタグやCSSメディアクエリを使用して、モバイルフレンドリーな体験を提供しています。これらのモバイルフレンドリーについて詳しく知りたい方は、[SEOの章](./seo#mobile-friendliness)をご覧ください。

<a hreflang="ja" href="https://web.dev/i18n/ja/responsive-web-design-basics/">レスポンシブWebデザインの詳細はこちら</a>。

検索エンジンからのオーガニックなトラフィックだけでなく、**広告のクリック**もウェブサイトに送られる訪問者の重要なソースとなる可能性があります。SEOと同様に広告に投資し、広告からのトラフィックを受け取るウェブサイトにとって、広告の最適化は重要な意味を持ちます。

#### 読み込み性能

第一印象は重要です。ページコンテンツをタイムリーに配信することは、訪問者の離脱やユーザーの不満を避けるために重要です。読み込みパフォーマンスは獲得フェーズの重要な要素であり、読み込みパフォーマンスが悪いとユーザーはこの旅を放棄してしまいます。

<a hreflang="en" href="https://web.dev/milliseconds-make-millions/">最近の調査</a>では、0.1秒のモバイル速度の改善により、小売サイトではコンバージョン率が+8.4％、旅行サイトでは+10.1％向上したとの結果が出ています。

読み込みパフォーマンスは膨大なテーマなので、ここではいくつかの側面をピックアップして紹介します。

##### 最大のコンテンツフル・ペイント

読み込み体験の重要な側面は、ウェブページのメインコンテンツがどれだけ早く読み込まれ、ユーザーに表示されるかということです。これを測定することは困難でした。過去にGoogleは、これを把握するために<a hreflang="en" href="https://web.dev/first-meaningful-paint/">First Meaningful Paint</a>（FMP）などのパフォーマンス指標を推奨していましたが説明が難しく、ページのメインコンテンツが表示されるタイミングを特定できないことが多くありました。

シンプルな方が良い場合もあります。最近では、ページのメインコンテンツがいつ読み込まれたかを測定するより正確な方法は、単純に最大の要素がいつレンダリングされたかを見ることだと分かってきました。<a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP)は、タイミングベースの指標で、折り返し部分よりも大きい要素がレンダリングされた時間を表します。

良いLCPスコアは、75パーセンタイルで2.5秒です。75パーセンタイルでのLCPの中央値はモバイルで2.6秒、デスクトップでは2.3秒であることがわかりました。モバイルWebはとくにLCPの点で失敗しやすいと言えます。

{{ figure_markup(
  image="median-p75-lcp-score.png",
  caption="75パーセンタイルLCPスコア中央値",
  description="75パーセンタイルのLCPの中央値は、モバイルで2.6秒、デスクトップで2.3秒であることを示すグラフ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=964425991&format=interactive",
  sheets_gid="872081120"
  )
}}

##### イメージ

フォント、CSS、JavaScriptなど、あらゆる種類のアセットが読み込みパフォーマンスに重要な役割を果たしていますが、ここでは画像について詳しく見てみましょう。

帯域幅の拡大やスマートフォンの普及に伴い、ウェブでは画像を多用したページが増え続けています。そして、画像は読み込みパフォーマンスにコストをかけています。

画像のパフォーマンス問題の原因としては、サイズが適切でない画像や最適化されていない画像がよく挙げられます。なんと41.20％のページで不適切なサイズの画像が使用されています。

{{ figure_markup(
  image="pages-with-properly-sized-images.png",
  caption="適切なサイズの画像があるページ",
  description="モバイルページの41.20％が不適切なサイズの画像を使用していることを示すグラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1030767824&format=interactive",
  sheets_gid="699494809"
  )
}}

画像を掲載しているページの4.1％が、画像に遅延読み込み属性を使用しており、比較的新しいプリミティブとしてはまずまずの採用率です。

### 2. エンゲージメント

ユーザーの旅の次の段階は、ユーザーがコンテンツを消費し、意図を実現するためのエンゲージメントです。

#### コンテンツの移り変わり

コンテンツの移動は、ユーザーがコンテンツを利用する際の体験を損ないます。具体的には、リソースの読み込みに伴って位置がずれるコンテンツは、ユーザー体験を阻害します。ブラウザは可能な限り早くコンテンツをダウンロードして表示するため、ユーザー体験をスムーズにするためのサイト設計が重要です。
これはとくにモバイルウェブでは重要なことで、小さな画面ではずれたコンテンツが目立ってしまいます。

{{ figure_markup(
  image="example-of-a-site-shifting-content-while-it-loads-lookzook.gif",
  caption="読者の気を引くためにコンテンツをずらした例。CLS合計で42.59％。画像提供：LookZook",
  description="Webサイトの読み込みが進む様子を撮影した動画です。テキストはすぐに表示されますが、画像の読み込みが進むにつれテキストがページの下の方に移動していき、読むのに非常に苦労します。この例のCLSの計算値は42.59％です。画像提供：LookZook",
  width=360,
  height=640
  )
}}

##### 累積レイアウト変更

<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">Cumulative Layout Shift</a> (CLS)は、ユーザーの訪問中にビューポート内のコンテンツがどれだけ移動するかを定量化する指標です。

<a hreflang="ja" href="https://web.dev/i18n/ja/optimize-cls/">CLSが悪くなる原因としてもっとも多いのは</a>。

* 寸法のない画像。
* 寸法のない広告、埋め込み、iframeなど。
* 動的に注入されるコンテンツ。
* FOIT/FOUTを引き起こすウェブフォント。
* ネットワークの応答を待ってDOMを更新するアクション。

これらの原因をローカルや開発環境で特定することは、実際のユーザーがどのようにページを体験するかに大きく依存するため、簡単なことではありません。サードパーティのコンテンツやパーソナライズされたコンテンツは、開発環境と本番環境では同じように動作しないことがよくあります。

CrUXのデータによると、モバイルサイトの60％、デスクトップサイトの54％が、良いCLSを持っています。

{{ figure_markup(
  image="aggregate-lcp-performance-by-device.png",
  caption='デバイス別のLCPパフォーマンスを集計',
  description="モバイルサイトの60％、デスクトップサイトの54％が良いCLSを持っていることを示すグラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=277999653&format=interactive",
  sheets_gid="1730986965"
  )
}}

#### デザイン要素

ユーザーに興味を持ってもらうためには、探しているものがすぐに見つかり、その意図を満たすことが重要です。

##### ランディングページ

たとえば明確なコール・トゥ・アクションを設定したり、価値ある提案をわずかな言葉でユーザーに明示するなど、シンプルなデザインの工夫が大きな効果をもたらします。

{{ figure_markup(
  image="landing-page-cta.png",
  caption='Pixel phoneのランディングページの4つの重要な部分。<br>(出典：Yahoo! <a hreflang="en" href="https://winonmobile.withgoogle.com">Google</a>)',
  description="Pixel phoneのランディングページの4つの部分を分解したイメージです。「価値提案」「コールトゥアクション」「気を散らさない」「主なサービス」。",
  width=1200,
  height=642
  )
}}

自動転送カルーセルはユーザーエクスペリエンスに悪影響を及ぼすことが<a hreflang="en" href="https://www.nngroup.com/articles/auto-forwarding/">調査で明らか</a>になっています。ホームページでの自動転送カルーセルは避けるか、その頻度を減らすべきです。

##### カラー＆コントラスト

<a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">Eastpakがモバイルユーザーから学んだ5つの教訓</a>から以下の例を考えてみましょう。

{{ figure_markup(
  image="eastpak-20-ctr.png",
  caption='Eastpakは、メインのコールトゥアクションの色のコントラストを改善することで、クリックスルー率を20％向上させました。<br>（出典。<a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">Google</a>)',
  description="Eastpak社のコールトゥアクションボタンの色のコントラストを改善することで、クリック率を20％向上させたイメージです。",
  width=1094,
  height=1122
  )
}}

ここでは、見づらいボタンを対照的な色のボタンに変更しただけで、メインのコールトゥアクションのクリック率が20％向上しました。

{{ figure_markup(
  image="eastpak-12-ctr.png",
  caption='Eastpakは、チェックアウトボタンの色のコントラストを改善することで、コンバージョン率を12％向上させました。<br>（出典。<a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">Google</a>)',
  description="Eastpak社がチェックアウトボタンの色のコントラストを改善することで、コンバージョン率を12％向上させたイメージ。",
  width=1166,
  height=1102
  )
}}

チェックアウトボタンの色を黒からオレンジに変更するだけで、より目立つようになり、コンバージョン率が12％向上しました。

Mckinsey & Company社は、デザインやUXに強い企業は、より優れた業績を示しているという<a hreflang="en" href="https://www.mckinsey.com/business-functions/mckinsey-design/our-insights/the-business-value-of-design#">報告書</a>を発表しました。デザインとUXに重点を置く企業は、同業他社に比べてより強い収益成長を示しました。

たとえば、白地に薄いグレーの文字など、コントラスト比の低い文字は読みづらいです。これは、ユーザーの読解力や読書速度を低下させる原因となります。

Lighthouseでは、<a hreflang="ja" href="https://web.dev/i18n/ja/color-contrast/">色のコントラストをチェック</a>したところ、78.94％と過半数のウェブページで色のコントラストが、十分でないことがわかりました。

{{ figure_markup(
  image="sites-with-sufficient-color-contrast.png",
  caption='十分な色のコントラストがあるサイト',
  description="78.94％と過半数のWebページで色のコントラストが不足していることを示すグラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=524145395&format=interactive",
  sheets_gid="1180749800"
  )
}}

##### タップターゲット

モバイルのユーザーエクスペリエンスは、デスクトップでマウスを使うのに比べてユーザーが指を使ってサイトにアクセスするため、「ファットフィンガリング」の影響を受けやすい。

調査によると、ボタンやタップターゲットの最小サイズと、それらの間隔の最小値に関する基準があります。<a hreflang="ja" href="https://web.dev/i18n/ja/tap-targets/">Lighthouseの推奨</a>は、ターゲットが48px×48pxよりも小さく、8px以下の間隔で配置することです。その結果63.69％という大多数のウェブページで、タップターゲットのサイズが、不適切であることがわかりました。これは昨年の65.57％のウェブページが不適切なサイズのタップターゲットを持っていたことと比較すると、わずかに改善されています。

{{ figure_markup(
  image="sites-with-properly-sized-tap-targets.png",
  caption='適切なサイズのタップターゲットがあるサイト',
  description="63.69％と過半数のウェブページで、タップターゲットのサイズが、適切でないことがわかりました。昨年は65.57％のWebページが不適切なサイズのタップターゲットを持っていましたが、今年はわずかに改善されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1829334180&format=interactive",
  sheets_gid="38974332"
  )
}}

##### 検索入力

検索入力や検索バーは、ユーザーを惹きつけるための重要なツールであり、ユーザーが探している情報を素早く見つけることができます。とくにモバイルデバイスでは、大量の情報を簡単に消費するための画面領域が不足しているため、この機能は重要です。

検索は、大規模なEコマースサイト、コンテンツの多いサイト、ニュースサイト、予約サイトなどで多用されており、ユーザーが簡単に情報を見つけられるようになっています。ページ数の少ない小さなサイトには検索入力は必要ありませんが、サイトの成長とともに必要になってきます。100ページ以上のサイトでは、目立つ検索バーを設置することが推奨されます。

<a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-cee/marketing-strategies/data-and-measurement/lyst-increases-overall-conversion-rate-25-making-usability-improvements/">ファッションサイトlyst.comのケーススタディ</a>では、検索アイコンを検索ボックスに置き換えることでユーザーが検索機能をより簡単に見つけられるようになり、デスクトップでは43％、モバイルでは13％利用率が向上しました。

{{ figure_markup(
  image="search-input-lyst.png",
  caption='lyst.comで検索アイコンを検索ボックスに置き換えたところ、コンバージョン率がモバイルで13％、デスクトップで43％向上しました。<br>(出典：Yahoo! <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-cee/marketing-strategies/data-and-measurement/lyst-increases-overall-conversion-rate-25-making-usability-improvements/">Google</a>)',
  description="lyst.comがウェブサイトの検索アイコンを検索ボックスに置き換えた結果、コンバージョン率がモバイルで13％、デスクトップで43％増加したことを示すグラフィック。",
  width=1194,
  height=1170
  )
}}

検索入力が使用されているのは、何らかの入力を使用しているサイト全体の17％です。60.10％と、過半数のECランディングページで検索入力の存在が確認できません。

{{ figure_markup(
  image="ecommerce-sites-using-a-search-input.png",
  caption='検索入力を利用したECサイト',
  description="ECサイトのランディングページの過半数である60.10％が、検索入力の存在を見落としているというグラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=992212527&format=interactive",
  sheets_gid="91645550"
  )
}}

##### A/Bテスト

A/Bテストは、デザインやUXに関するデータに基づいた意思決定を行うための重要なツールです。A/Bテストでは、UXやデザインの変更が意図した指標を測定可能な形で改善し、予期せぬ回帰を引き起こさないことを検証できます。

ここでは、A/Bテストが可能なデザインクエスチョンの一例をご紹介します。
* ボタンの色を変えれば、クリック率が上がる？
* クリックターゲットのサイズを大きくすれば、クリック数は増えるのでしょうか？
* 検索アイコンを検索ボックスに置き換えれば、検索完了数が増えるのでは？

<a hreflang="en" href="https://www.thirdpartyweb.today/">thirdpartyweb.today</a>によると、<a hreflang="en" href="https://www.optimizely.com">Optimizely</a>はA/Bテストでもっとも人気のあるサードパーティ製品で、20,000以上のページで使用されているそうです。

### 3. コンバージョン

「コンバージョン」というとEコマースサイトに関連する概念のように聞こえるかもしれませんが、コンバージョンとは音楽ストリーミングサービスへの登録、賃貸住宅の予約、旅行サイトへのレビューの書き込みなど、ユーザーの取引が成功した場合を指します。

Comscore Media Matrix社によると、モバイル機器からのトラフィックは米国の小売サイトでの滞在時間の79.6％を占めていますが、米国のEコマース売上の32.3％に過ぎません。

デスクトップと比較してモバイルデバイスでの取引は、小さなキーボードや画面サイズで個人情報を入力しなければならないため、エラーが発生しやすく、面倒なものです。ユーザーが不満を感じたり、最悪の場合は放棄してしまうことを避けるために、チェックアウトフローはシンプルで短いものでなければなりません。27％のユーザーは、<a hreflang="en" href="https://www.smashingmagazine.com/2018/08/best-practices-for-mobile-form-design/">「長すぎる／複雑なチェックアウトプロセス」</a>が原因でチェックアウトを放棄しています。35％のユーザーは、小売業者が<a hreflang="en" href="https://baymard.com/blog/ecommerce-checkout-usability-report-and-benchmark">ゲストチェックアウト</a>を提供していない場合、チェックアウトを放棄します。

#### フォームセマンティクス

モバイル機器では、キーボードが適切な入力タイプに最適化されていると、ユーザーは必要な情報をより簡単に入力できます。たとえば電話番号の入力には数字キーボードが便利で、メールアドレスの入力には「@」記号が、表示されたキーボードが便利です。サイトでは、`input`タグの`type`属性を使って、最適なキーを表示するためのブラウザのヒントを提供できます。

{{ figure_markup(
  image="sites-with-inputs-using-the-following-input-types.png",
  caption='以下の入力タイプを使用するサイト（入力あり）。',
  description="モバイルでもっともよく使われている入力タイプを示したグラフ。 text: 54.025％; hidden: 37.319％; submit: 29.611％; search: 17.100％; email: 15.164％; checkbox: 14.305％; password: 10.204％; button: 3.442％; radio: 3.391％; image: 2.585％; tel: 2.458％; number: 0.892％; file: 0.668％; range: 0.270％; reset: 0.132％; date: 0.122％; url: 0.104％; input: 0.063％; phone: 0.061％; name: 0.049％; No input type: 0.029％; mail: 0.017％; textbox: 0.016％; username: 0.014％; select: 0.013％; textfield: 0.013％; time: 0.010％; textarea: 0.005％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1866868829&format=interactive",
  sheets_gid="1443384706"
  )
}}

#### サインアップ、サインイン、チェックアウト

今日、ブラウザはトランザクションを完了するために必要なユーザー情報の入力を支援し、潜在的な入力エラーを減らすことができます。`autocomplete`属性は、入力要素に正しいユーザー情報を入力するためのヒントをブラウザに提供します。Chromeオートフィルを使って情報を入力したユーザーは、<a hreflang="en" href="https://developers.google.com/web/fundamentals/design-and-ux/input/forms#use_metadata_to_enable_auto-complete">そうでないユーザーに比べて</a>平均30％早くチェックアウトを完了しています。

オートコンプリートはユーザーがログインし、そのためにパスワードを覚えておく必要があるチェックアウトフローを完成させる際に、とくに役立ちます。2019年に行われた<a hreflang="en" href="https://www.hypr.com/hypr-password-study-findings/">HYPRによる調査</a>によると、78％のユーザーが過去90日間にパスワードを忘れてリセットしなければならなかったとのことです。

また、一部のフォームフィールドを完全になくすことも可能です。Credential Management APIとPayment Request APIは、標準ベースのブラウザAPIでサイトとブラウザの間にプログラムによるインタフェースを提供し、シームレスなサインインと決済を実現します。Payment Request APIを利用しているEコマースサイトは全体の0.61％、Credential Management APIを利用しているのは全体の0.008％に過ぎません。注目すべきは、2019年に比べてPayment Request APIの採用率が増加し、決済完了率が6倍になったことです。

### 4. 維持

旅の最後の段階は、ユーザーの維持です。これは、ユーザーを引き込み、リピーターやロイヤルビジターにすることを意味します。

#### PWAによるインストール性

リピーターのユーザーは、[PWA](./pwa)でネイティブアプリのような体験ができるというメリットがあります。ユーザー維持のための重要な価値提案は、PWAのインストール性です。PWAがインストールされると、モバイルユーザーがアプリを見つけるのに期待する場所、つまりホームスクリーンやアプリトレイから利用できるようになります。ユーザーがPWAをタップして起動すると、フルスクリーンでロードされ、ネイティブアプリのようにタスクスイッチャーで利用できます。

楽天24は、日本最大級の電子商取引企業である楽天が提供するオンラインストアです。最近行われた<a hreflang="en" href="https://web.dev/rakuten-24/">楽天24</a>のケーススタディでは、ウェブアプリを<a hreflang="en" href="https://web.dev/define-install-strategy/">インストール可能</a>にすることで、1か月間の期間中に以前のモバイルウェブフローと比較して訪問者の保持率がなんと450％も向上しました。

楽天24もインストール性を導入したことで、1か月の期間でこれらの改善が見られました。
* 他のウェブユーザーと比較して、1ユーザーあたりの訪問頻度が310％増加
* 顧客一人当たりの売上高を150％増加
* コンバージョン率200％アップ

#### デバイス間でのシームレスな体験
最後にデバイス間でシームレスな体験を提供することで、ユーザーの思い入れと維持を深めることができ、サインイン体験がその力となります。

[ユーザーの旅](#ユーザーの旅)の冒頭で、モバイルは小売サイトでの滞在時間の79.6％を占めているが、Eコマースの売上の32.3％しか占めていないと述べました。これは、ユーザーはモバイルで閲覧しユーザーの旅を開始することが多いですが、コンバージョンやトランザクションを完了するのはデスクトップであることを示唆しています。

たとえばコンテンツを探したり、消費したりするのが簡単であることや、タイピングやフォーム入力が容易であることなどが理由として挙げられます。

大規模なサイトでは、モバイルウェブとデスクトップのどちらに投資するかという問題ではなく、どちらもお互いに補完し合うことが多いのです。

ユーザーの旅の4つのフェーズをすべて考慮することで、ユーザーを惹きつける機会の全領域と、各フェーズにおけるリスクや課題を理解できます。

## 結論

今やウェブへのアクセスはモバイルが主流となっており、去年からウェブへのアクセスはますます重要になってきています。モバイルのニーズはデスクトップのそれとは異なります。モバイルでは小さい画面でネットワークが限られていることが多いため、画像サイズを小さくできますしそうすべきですが、不適切なサイズの画像が5分の2を占めていることからも、まだまだ課題があると言えます。同様に、モバイルではマウスのような正確さがないため、タップターゲットは大きくする必要がありますが、これはまだ問題があることを示しています。このように、モバイルサイトの利用を容易にするためウェブサイトのオーナーができることはたくさんありますが、それにはデスクトップとは異なる考え方が必要な場合もあります。
