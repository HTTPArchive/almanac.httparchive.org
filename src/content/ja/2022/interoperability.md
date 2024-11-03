---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 相互運用性
description: Compat 2021（GirdとFlexbox）とInterop 2022（フォーム、スクロール、タイポグラフィとエンコーディング、ダイアログ、コンテントメント、サブグリッド、カラースペース、ビューポートユニット、カスケードレイヤー）をカバーする2022 Web Almanacの相互運用性の章。
authors: [bkardell]
reviewers: [meyerweb, foolip]
analysts: [rviscomi, kevinfarrugia]
editors: [tunetheweb]
translators: [ksakae1216]
bkardell_bio: Brian Kardellは、<a hreflang="en" href="https://igalia.com">Igalia</a>の開発者支持者であり、W3C諮問委員会代表、標準化貢献者、<a hreflang="en" href="https://bkardell.com">ブロガー</a>です。Extensible Web Community Group の創設者であり、<a hreflang="en" href="https://extensiblewebmanifesto.org">The Extensible Web Manifesto</a> の共著者。
results: https://docs.google.com/spreadsheets/d/1w3GzzTNeKxafFODmjDs6OC2dseNEDDKwUV8KeSgRI1Y/
featured_quote: 相互運用性は標準の重要な目標ですが、私たちは時々、その目標を達成できないことがあります。 この章では、開発者に向けて、改善に向けた取り組みについて、毎年最新情報を提供する予定です。この章では、相互運用性に関して今年新しくなったことや改善されたことを取り上げ、実装者が長期にわたってその影響を測定するための手段を提供します。
featured_stat_1: 309%
featured_stat_label_1: 2021年4月から2022年9月までのCSS `aspect-ratio` 利用サイトの増加数
featured_stat_2: 0.3%
featured_stat_label_2: 2022年9月現在、新たに相互運用可能となった`dialog`要素を使用しているサイトの割合
featured_stat_3: 4%
featured_stat_label_3: 最近の相互運用可能なCSS `containment`を使用したモバイルページ。このサポートはコンテナクエリにとって重要です。
---

## 序章

2019年、Mozilla Developer Network（MDN）の製品諮問委員会は、173カ国の28,000人以上の開発者とデザイナーを対象とした重要な調査を実施しました。そこから得られた結果は、最初の <a hreflang="en" href="https://insights.developer.mozilla.org/reports/pdf/MDN-Web-DNA-Report-2019.pdf">ウェブ開発者ニーズ調査</a>（Web DNA）として発表されました。この調査では、重要な不満や苦痛のポイントのいくつかは、もっとも頻繁にブラウザ間の違いに関係していることが特定されました。2020年、これは <a hreflang="en" href="https://insights.developer.mozilla.org/reports/mdn-browser-compatibility-report-2020.html">MDNブラウザ互換性レポート</a> として知られるフォローアップにつながりました。

歴史的に、実装者の優先順位と焦点は独自に管理されてきました。しかし、この新しいデータを受けて、ブラウザ メーカーは <a hreflang="en" href="https://web.dev/compat2021/"> _Compat 2021_ </a> と呼ばれる初の取り組みに協力しました。Compat 2021の開始当初、すべてのエンジンは、安定した出荷状態のブラウザにおいて、5つの分野で65～70%の互換性しか得られませんでした。現在では、すべてのエンジンが90%を超えています。2022年には、この取り組みが拡大され、<a hreflang="en" href="https://hacks.mozilla.org/2022/03/interop-2022/"> _Interop 2022_ </a> に改名されました。

どちらの取り組みも、本章で取り上げるべきいくつかの異なるものを提供しています。Compat 2021からもっとも改善されたものが出荷されてからほぼ1年が経ち、Interop 2022の多くのものはすでに出荷されているブラウザに導入されていますが、年末までにさらに多くのものが導入される予定です。

このような取り組みにおける興味深い疑問は、"どうすればうまくいった（あるいはいかなかった）とわかるのか "ということです。スコアの大幅な改善は有用ですが、開発者の採用がなければ不十分です。そこでWeb Almanacでは今年はじめて、このような疑問と格闘し何が変わり、何がもう一度見る価値があるのかについて、開発者に中心的な情報を提供するために新しい相互運用性の章を設けることにしました。

この章では、Compat 2021で行われた作業を要約し、私たちができることを測定します。また、Interop 2022で何が起きているかを調べ、私たちが長期的に追跡できる価値あるメトリクスがあるかどうかを検討します。これらの取り組みには非互換性やフラストレーションの程度の差こそあれ、安定したすでに有用な機能から、私たちが最初からセットアップしようとした真新しいものまで、さまざまなケースが混在しています。

## Compat 2021

Compat 2021は、5つの主要分野に重点を置いています。

- グリッド
- フレックスボックス
- スティッキーポジション
- トランスフォーム
- アスペクト比

2021年1月の時点では、すべての安定版／出荷版ブラウザがこれらの分野で65～70％の互換性を獲得しており、各ブラウザで失敗しているテストは必ずしも同じ30～35％ではありませんでした。

{{ figure_markup(
  image="compat-2021-dashboard.png",
  caption='コンパチ2021ダッシュボード。<br>(ソースはこちら： <a hreflang="en" href="https://wpt.fyi/compat2021">ウェブ・プラットフォーム・テスト</a>)',
  description="Compat 2021ダッシュボードの最近のスクリーンショットで、実際に出荷されている安定したブラウザでの相互運用性の向上を示しています。Chrome/Edge 96%、Firefox 91%、Safari 94%。",
  width=780,
  height=801
  )
}}

今日、かなりのレベルで改善されていることがわかります。ChromeとEdgeは96%、Firefoxは91%、Safariは94%です。

### グリッド

CSSグリッドは、ここ数年もっとも普及している機能のひとつです。[HTTP Archiveのデータ](./css#フレックスボックスとグリッドの採用)を見ると、グリッドが登場して以来、年々倍増しています。グリッドはすでにかなり高い相互運用性を持っていましたが、サポートにはまだ細かな違いがいくつもありました。2021年と2022年を通して、グリッドの機能をテストするWeb Platform Testsの900以上のテストの整合性を改善する作業が行われました。もしあなたが過去にグリッドで何かをしようとして頭痛の種になったことがあるなら、もう一度試してみてください。

そのよい例が、グリッド トラック、つまりグリッドの行と列をアニメーション化する機能です。しかし、この章の執筆中に、<a hreflang="en" href="https://webkit.org/blog/13152/webkit-features-in-safari-16-0/">WebKit</a> と <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/Ll7br0giMk8/m/l4WNHdatBQAJ">Chromium</a> の両方にグリッドトラックのアニメーションが追加されました。つまり、あなたがこれを読む頃には、3つの主要なエンジンすべてにグリッドトラックのアニメーションが追加されているはずです。

### フレックスボックス

Flexboxはさらに古く、より広く使われています。今年、その使用は再び拡大し、[現在、モバイルページの75%、デスクトップページの76%に表示されています](./css#フレックスボックスとグリッドの採用)。Gridと同じようなテスト数で、非常に広く採用されているにもかかわらず、当初はもっとひどい状態でした。2021年に入ると、ボロボロのバグと未実装のままのサブ機能の組み合わせがありました。たとえば[位置揃えキーワード値](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Box_Alignment#positional_alignment_keyword_values)（justify-contentとalign-contentに適用でき、justify-selfとalign-selfにも適用できる）は、サポートがボロボロで、いくつかの相互運用性の問題がありました。絶対位置のフレックスアイテムでは、これはさらに悪化していました。これらの問題は解決されました。

{{ figure_markup(
  caption="スタイルシートで `flex-basis: content` を使用しているデスクトップページ。",
  content="112,323",
  classes="big-number",
  sheets_gid="1354091711",
  sql_file="flex_basis_content.sql"
)
}}

これはフレックスアイテムのコンテンツに基づいて自動的にサイズを調整するために使用されます。 これは当初Firefoxに実装されましたが、2021年にはWebKitとChromiumへの実装が進められていました。今日、これらのテストはすべてのブラウザで一律にパスし、`flex-basis: content` はデスクトップで112,323ページ、モバイルで75,565ページ、ページの約1%に表示されています。ユニバーサルサポート1年目の機能としては悪くないスタートで、昨年の約2倍です。今後もこの指標から目が離せません。

### Sticky positioning

{{ figure_markup(
  caption="スタイルシートで `position: sticky` を使用しているデスクトップページ。",
  content="5.5%",
  classes="big-number",
  sheets_gid="712845051",
  sql_file="position_sticky.sql"
)
}}

スティッキーポジショニングは以前から存在していました。実際、フィーチャークエリの50%以上を占め、[最も普及しているフィーチャークエリ](../2022/css#フィーチャークエリ)であることは注目に値します。たとえば、Chromeではヘッダーをテーブルに貼り付けることができません。`position:sticky`は、2022年にはデスクトップページの約5%、モバイルページの約4%で積極的に使用されています。これらの相互運用性の問題への対処が、時間の経過とともに採用にどのような影響を与えるか、今後しばらくこの指標から目が離せません。


### CSSトランスフォーム

{{ figure_markup(
  image="css-transforms-wpt-dashboard-stable.png",
  caption='CSSトランスフォームWebページテストダッシュボード（安定版）。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/compat2021?feature=css-transforms&stable">ウェブプラットフォームテスト</a>)',
  description="Compat 2021のグラフでは、当時と現在とで、すべての安定したブラウザでcssトランスフォームが20-30%向上しています。",
  width=720,
  height=479
  )
}}

CSSトランスフォームは人気があり、長い間存在してきました。しかし、当初は多くの相互運用性の問題があり、とくに `perspective:none` と `transform-style: preserve-3d` の問題がありました。そのため、多くのアニメーションが<a hreflang="en" href="https://web.dev/compat2021/#css-transforms"> 不整合</a>という悩ましい問題を抱えていました。

{{ figure_markup(
  image="css-transforms-wpt-dashboard-experimental.png",
  caption='CSSトランスフォームWebページテストダッシュボード（実験的）。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/compat2021?feature=css-transforms">ウェブプラットフォームテスト</a>)',
  description="同じCSSトランスフォームを実験的なブラウザで表示したCompat 2021のグラフでは、すべてのブラウザで90%以上のスコアが得られています。",
  width=720,
  height=479
  )
}}

上記と同じCSSトランスフォームを実験的なブラウザで表示した最近のcompat 2021のグラフを見ると、すべてのブラウザが実験的なバージョンで90%以上のスコアを獲得しており、ブラウザの将来のバージョンを示しています。Interop 2022の一環として、Compat 2021の継続的な作業が含まれているため、これは安定したブラウザで大きく目に見える改善が続いている分野の1つです。

### `アスペクト比`

`アスペクト比`は2021年に開発された新機能です。その潜在的な有用性を考慮し、私たちは最初から高い相互運用性を目指すことにしました。

{{ figure_markup(
  image="aspect-ratio-usage.png",
  caption='アスペクト比の経年変化。<br>(ソース: <a hreflang="en" href="https://chromestatus.com/metrics/css/timeline/popularity/657">Chromeステータス</a>)',
  description="デスクトップで0.11％、モバイルで0.24％だったアスペクト比を含むルールが、デスクトップで1.44％、モバイルで1.55％と、ここ1年半ほどで着実に採用されていることを示すチャート。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=921119661&format=interactive",
  sheets_gid="1987465082"
) }}

2022年、`アスペクト比`はすでに[アーカイブクロールの2%のURLのCSS](./css#aspect-ratioプロパティ)に登場しています。これらのページの2%が`アスペクト比`を使用しているという意味ではありません。これらのページでどのルールが適用されているかは別の問題で、デスクトップではページビューの1.55%、モバイルでは1.44%という控えめな結果になっています。それでも、成長グラフは着実に採用が増加していることを示しています。これは、今後追跡していく上で興味深い指標となるでしょう。

## Interop 2022

以前の _Compat_ の取り組みと同様に、改名された _Interop_ の取り組みではバグの収集から良い最終的な実装への着地、比較的新しいがすぐに出荷される機能まで、さまざまなものが混在しています。まずはバグから。。。

### バグ

多くの場合、成熟した機能であるにもかかわらず、さまざまなブラウザでボロボロのバグが報告されています。ボロボロのバグがあるということは、オーサリング体験が個々の合格率が意味するよりもずっと悪くなる可能性があるということです。たとえば、すべてのブラウザが70%の合格率を報告しても、すべてのブラウザが異なる30%で不合格だった場合、実際の相互運用性はかなり低くなります。Interop 2022における私たちの焦点の大部分は、このような機能に関する実装の調整とバグの解消です。

#### フォーム

ウェブの歴史のもっとも長い間、フォームはかなり重要な役割を果たしてきました。2022年には、<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit#gid=2057119066">デスクトップ ページの69% 以上が `<form>` 要素を含んでいます</a>。これらは多くの投資を受けてきましたが、それにもかかわらず、開発者が仕様と異なるケースを見つけたり、時には微妙な方法で他の実装と異なるケースを見つけたりするため、多くのブラウザのバグの原因となっています。私たちは、<a hreflang="en" href="https://wpt.fyi/results/?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-forms">合格率が非常に低い200のテスト</a>を特定しました。個々のスコアは、~62% (Safari) から ~91% (Chrome) までの範囲でしたが、やはり各ブラウザにはサポートに異なるギャップがありました。

私たちは実験的なリリースでこれらのギャップを埋めるためにかなり急進的な進歩を遂げました。HTTP Archiveのデータを使って、利用状況や採用状況を追跡できることはおそらくほとんどありませんが、開発者の苦痛やフラストレーションが軽減され、個々のブラウザで回避策を必要とすることが少なくなることを願っています。

{{ figure_markup(
  image="forms-wpt-dashboard.png",
  caption='WPTダッシュボードのフォーム（実験的）。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-forms&stable">ウェブプラットフォームテスト</a>)',
  description="2022年の間にすべてのブラウザでフォームの相互運用性が向上したことを示すグラフ。すべてのブラウザのスコアは現在92～99%です。",
  width=732,
  height=696
  )
}}

#### スクロール

長年にわたり、私たちは新しいパターンを追加し、`scroll-snap`、`scroll-behavior`、`overscroll-behavior` などのスクロール体験に関する新しい能力を開発してきました。2022年には、これらの主要プロパティを含むCSSスタイルシートの数はこのようになっていました：

{{ figure_markup(
  image="scroll-property-adoption.png",
  caption='スクロールプロパティの採用。',
  description="デスクトップとモバイルでのスクロールプロパティの採用状況。`scroll-snap-type`はデスクトップページの7.8%、モバイルページの7.9%、`scroll-behavior`はデスクトップページの7.2%、モバイルページの6.9%、最後に`overscroll-behavior`はデスクトップページの2.4%、モバイルページの3.0%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=1940734631&format=interactive",
  sheets_gid="1538908642",
  sql_file="../css/all_properties.sql"
) }}

残念なことに、この分野には多くの非互換性が残っており、スクロールの非互換性に対処することは開発者を苦しめます。スクロールに関する <a hreflang="en" href="https://wpt.fyi/results/css?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-scrolling">ウェブプラットフォームテスト106</a> を特定しました。このプロセスの開始時点では、安定版（stable-release）のスコアは約70%（FirefoxとSafari）から約88%（Chrome）でした。ギャップが異なるため、実際の「相互運用性」交差点はこれらのどれよりも低くなっています。

{{ figure_markup(
  image="scrolling-wpt-dashboard.png",
  caption='WPTのダッシュボードをスコーリング。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-scrolling&stable">ウェブプラットフォームテスト</a>)',
  description="実験的なブラウザの改善を示す最近のチャートでは、とくにFirefoxの改善率が約71%から86%以上へと大幅に向上しています。",
  width=718,
  height=683
  )
}}

これらの改良が時間とともに採用にどのような影響を及ぼすかを見積もるのは非常に困難ですが、私たちはこれらの指標を注視します。その間に、スクロール機能で相互運用性の問題を経験したことがある方は、もう一度見てみるとよいでしょう。このような改善が継続され、安定したブラウザのリリースに到達するにつれて、体験が大幅に改善されることを期待しています。

#### タイポグラフィとエンコーディング

テキストのレンダリングはウェブの得意分野です。フォームのように、多くの基本的なアイデアは昔からありましたが、タイポグラフィやエンコーディングのサポートに関しては、多くのギャップや不整合が残っています。

Interop 2022では、`font-variant-alternates`、`font-variant-position`、`ic`ユニット、CJKテキストエンコーディングに関する一般的な問題が取り上げられました。私たちは、<a hreflang="en" href="https://wpt.fyi/results/?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-text">ウェブプラットフォームテスト114のテスト</a> において、さまざまな種類のギャップを表す114のテストを特定しました。

{{ figure_markup(
  image="typography-and-encodings-wpt-dashboard.png",
  caption='タイポグラフィとエンコーディングWPTダッシュボード。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-text&stable">ウェブプラットフォームテスト</a>)',
  description="過去1年間のタイポグラフィとエンコーディングの相互運用性スコアを示したグラフ。Chromeは約70％、Safariは約79％、Firefoxは約98％でスタート。ChromeはSafariとの差をかなり縮めましたが、それ以外は変化のない3直線です。",
  width=727,
  height=688
  )
}}

Chromeは最近Safariとの差を縮め始めていますが、SafariとWebKitの両方がこの分野でFirefoxの完成度に追いつくにはまだ注意が必要です。

### 実装の完了

実装の調整はとくに困難です。実験と初期の実装体験の必要性と、作業がよく理解され、すべてのブラウザで実装を出荷する状態に達する可能性が非常に高いことを確実にするための十分な合意との間には微妙なバランスがあります。この調整には何年もかかることもあります。今年は、実装が完了し、少なくとも準備が整ったという合意が得られた3つの項目に焦点を当てました。 `<dialog>` 要素、CSS Containment、Subgridです。それぞれを見てみましょう。

#### `<dialog>`

ダイアログ要素は、2014年8月のChrome 37ではじめて出荷されました。ダイアログを導入するには、"top-layer "や "inertness "など、サポートする多くの概念を導入し、定義する必要があります。また、多くの新しいアクセシビリティとUXの質問に答える必要があります。

さまざまなことが原因で、ダイアログの作業は長い間停滞していましたが、数年かけて回復しました。2017年4月には、Firefox Nightly 53にフラグが立てられました。それ以来、すべての質問に答えるために多くの作業が行われました。最終的な詳細が整理され、Interop 2022の一環として、まず良好な相互運用性を確保するために作業の優先順位がつけられました。私たちは88のテストを特定しました。これは、2022年3月に[Firefox 98](https://developer.mozilla.org/ja/docs/Mozilla/Firefox/Releases/98) と <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-15_4-release-notes">Safari 15.4</a> の両方の安定したブラウザでデフォルトで出荷され、すべてのブラウザで ~93% 以上のスコアを記録しました。

{{ figure_markup(
  image="dialog-element-wpt-dashboard.png",
  caption='WPTダッシュボードのダイアログ要素。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-dialog&stable">ウェブプラットフォームテスト</a>)',
  description="過去1年間のダイアログの相互運用性スコアを示したグラフ。FirefoxとSafariは約80%から始まり、Chromeは少し高い87%でした。Chrome/Edgeは99.4%、Safariは97.5%、Firefoxは92.8%で、いずれも着実に改善しています。",
  width=720,
  height=685
  )
}}

アーカイブがクロールするページのうち `<dialog>` を必要とするページの数を予測するのは難しいですが、その成長を追跡することは有益で興味深いでしょう。昨年、`<dialog>`をサポートしたブラウザは1つだけで、モバイルデータセットのページの~0.101%に表示されました。この章に使用したクロールの時点では、約5か月間全世界で出荷されており、<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit#gid=2057119066">~0.148%</a>で表示されていることがわかりました。まだ小さな数字ですが、これは昨年の今頃の ~146% です。来年もこの指標を追跡します。それまでの間、もしあなたが `<dialog>` を必要としているなら、朗報があります！

#### CSSの格納

CSSコンテナメントは、CSSがどのように処理し、レンダリングすべきかという観点から、ページのサブツリーを他の部分から分離するための概念を導入したものです。これは、パフォーマンスを向上させ、[コンテナクエリ](https://developer.mozilla.org/docs/Web/CSS/CSS_Container_Queries)を理解するための扉を開くために使用できるプリミティブとして導入されました。

{{ figure_markup(
  image="containment-wpt-dashboard.png",
  caption='コンテインメントWPTダッシュボード。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-contain&stable">ウェブプラットフォームテスト</a>)',
  description="過去1年間の封じ込めの相互運用性スコアを示したグラフ。Safariは当初30%程度とかなり低かったのですが、早い段階で88%まで上昇し、着実に99%まで上昇しました。Chrome/EdgeとFirefoxは、それぞれ84%と95%とかなり高い数値でスタートし、99%まで向上しています。",
  width=709,
  height=675
  )
}}

2016年7月にChrome安定版で初出荷。Firefoxは2019年9月に2番目の実装を出荷しました。今年、Interop 2022で取り上げられたのは、それが普遍的に利用可能になったときに、私たちが良い状態でスタートできるようにするためです。<a hreflang="en" href="https://wpt.fyi/results/css/css-contain?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-contain">235テスト</a>を確認しました。<a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-15_4-release-notes">Safariは2022年3月に安定版リリース15.4</a> でコンテントメント サポートを出荷しました。この1年を通して、各ブラウザはサポートを改善し、今では普遍的に利用できるようになりました。

{{ figure_markup(
  caption="スタイルシートでコンテクメントを使用しているモバイルページの数。",
  content="3.7%",
  classes="big-number",
  sheets_gid="1436876723",
  sql_file="contain.sql"
)
}}

2022年のデータでは、モバイルでは3.7%、デスクトップでは3.1%のページで、スタイルシートにコンテントメントが表示されています。


{{ figure_markup(
  image="contain-property-usage.png",
  caption="`contain`プロパティの使い方。",
  description="`layout`はデスクトップページの`contain`の値の27%、モバイルページの34%、`strict`は24%と19%、`content`は12%と11%、`paint`は12%と9%、`none`は7%と8%、`style layout paint`は10%と8%、`layout style`は2%と4%、`style`は1%と3%、`layout size style`は1%と1%、`style size layout`は2%と1%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=932967645&format=interactive",
  sheets_gid="1251142331",
  sql_file="contain_values.sql",
  width=600,
  height=489
) }}

上の図は、これらのページにおける値の相対的な出現を示しています。`layout`のコンテインはもっとも普及しており、`contain`の値の34%を占めています。

コンテナクエリは長年にわたって<a hreflang="en" href="https://2021.stateofcss.com/en-US/opinions/#currently_missing_from_css_wins">#もっともリクエストの多かったCSS機能第1位</a> であるため、これは長期にわたって追跡し続ける興味深い指標となるでしょう。コンテナクエリが普遍的に利用できるようになった今、基本的な概念に慣れ親しむ絶好の機会です。

なおChromeとSafariでは、ある程度のコンテナクエリのサポートがすでに提供されており、ポリフィルも利用可能というわけで、すでに`@container`ルールセットが含まれているスタイルシートがどれくらいあるのかも調べてみることにしました。

{{ figure_markup(
  caption="`@container`ルールセットを含むモバイルページの割合。",
  content="0.002%",
  classes="big-number",
  sheets_gid="1772897513",
  sql_file="container.sql"
)
}}

まだまだ少ないようです！モバイルデータセットでクロールした約800万ページのうち、コンテナクエリを使用しているのはわずか238ページです。コンテナクエリが新しく、まだ完全に出荷されていないことを考えると、これは驚くべきことではありません。しかし、将来的に採用を追跡するための良いベースラインを与えてくれます。

#### サブグリッド

CSSのグリッド・レイアウトでは、コンテナーが行、列、トラックで子のレイアウトを表現できますが、これには常に限界があります。子ではない子孫も同じグリッドレイアウトに参加させる必要がしばしばあります。[サブグリッド](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Grid_Layout/Subgrid)はこのような問題の解決策です。2019年12月にFirefoxの安定版リリースではじめてサポートされましたが、他の実装はすぐには続きませんでした。

この待望の機能に関する作業を調整し、優れた相互運用性を確保することも、Interop 2022の目標でした。私たちは <a hreflang="en" href="https://wpt.fyi/results/css/css-grid/subgrid?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-subgrid">ウェブ・プラットフォーム・テストにおける51のテスト</a>をマークしました。

{{ figure_markup(
  image="subgrid-wpt-dashboard.png",
  caption='サブグリッドWPTダッシュボード。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-subgrid&stable">ウェブプラットフォームテスト</a>)',
  description="過去1年間の安定版リリースにおけるサブグリッドのスコアを示したグラフ。Chromeは約20％、Safariは約10％から約98％、Firefoxは約81％から約83％に達しています。",
  width=719,
  height=683
  )
}}

この記事を書いている時点では、非常に多くの進展があり（Safariは現在もっとも完成度が高い）、安定した出荷ブラウザには少なくとも2つの実装（SafariとFirefox）があります。年末までにChromeで急速な改善が見られることを期待しています。

{{ figure_markup(
  caption="スタイルシートで `subgrid` を使用しているモバイルページの割合。",
  content="0.002%",
  classes="big-number",
  sheets_gid="519660506",
  sql_file="subgrid.sql"
)
}}

これはまだすべての安定したブラウザで完全に利用できるわけではありませんが、データセットにはすでに少量の利用が含まれています。

### 新機能

今年、CSSの範疇に入るすべての新機能と、それらに関するもっとも多くのデータは、[CSS](./css)の章で扱われます。ここでは、主にいくつかのハイライトを取り上げます。

#### 色空間と関数

ウェブ上の色は、常に魅力的な挑戦に満ちています。長年にわたり、私たちは作者に、結局は同じ[sRGB](https://en.wikipedia.org/wiki/SRGB)色であるものを表現する多くの方法を与えてきました。つまり、色の名前（`red`）として書くことができます。単純なことです。

しかし、16進数の`(#FF0000)`を使うこともできます。人間は一般的に16進数で考えないので、`rgb()`色関数（`rgb(255,0,0)`）を追加しました。どちらも2つの異なる、同等の番号体系を使っていることに注意してください。また、これらはブラウン管ディスプレイで一般的だった、個々の光の強さの混合という観点から物事を表現するものです。

RGBの色の構成方法は、人間にとって非常に視覚化しにくいので、sRGBの色を（おそらく？）わかりやすく表現するために、[`hsl(0, 100%, 50%)`](https://ja.wikipedia.org/wiki/HSL%E8%89%B2%E7%A9%BA%E9%96%93%E3%81%A8HSV%E8%89%B2%E7%A9%BA%E9%96%93)や[`hwb(0, 0%, 0%)`](https://en.wikipedia.org/wiki/HWB_color_model)のような他の座標系を開発しました。ただし、繰り返しますが、これらはsRGB座標系です。

{{ figure_markup(
  image="p3-color-space.jpg",
  caption="sRGBと比較したp3色空間。",
  description="p3色空間がsRGBよりも広い色域を持ち、より多くの色を表現できることを示す図。",
  width=736,
  height=300
  )
}}

では、ディスプレイの能力が限界を超えるとどうなるのでしょうか？実際、広色域ディスプレイに見られるように、これは今日のケースです。

2017年にリリースされたSafari 10で、AppleはP3カラー画像のサポートを追加しました。[CIELABモデル](https://en.wikipedia.org/wiki/CIELAB_color_space#Cylindrical_model)に基づいて、利用可能な色域空間をすべてサポートするために、新しい`lab()`座標系と`lch()`座標系がCSSに追加されました。これらの座標系は知覚的に統一されており、以前は表現できなかった色を表現できるようになりました（また、サポートが不足している場合にどうすべきかを定義しています）。これらのサポートは2021年9月にSafari 15ではじめて出荷されました。

`lab()`と`lch()`の色域空間が充実し知覚的な均一性が向上したことで、2つの色を受け取り、指定した色空間で指定した量だけ混合した結果を返す`color-mix()`のような新しい色関数にも、より簡単にフォーカスできるようになりました。

Interop 2022では、優れた相互運用性を優先することを目標に、これらの項目に関する <a hreflang="en" href="https://wpt.fyi/results/css/css-color?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-color">189のテスト</a>を実施しました。FirefoxとChromeは着実に改善していますが、この分野ではまだかなり遅れています。1つの課題は、必然的に、多くの下位レベルのサポート -<a hreflang="en" href="https://youtu.be/eHZVuHKWdd8?t=906">基礎となるグラフィックス ライブラリやレンダリング パイプラインなど全体を通して</a> - もsRGBで処理するように構築されているため、サポートを追加するのが簡単ではないということです。

{{ figure_markup(
  image="color-spaces-and-functions-wpt-dashboard.png",
  caption='カラースペースと機能WPTダッシュボード。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-color&stable">ウェブプラットフォームテスト</a>)',
  description="過去1年間の安定版リリースにおけるカラースペースと機能のスコアを示したグラフ。Chrome/EdgeとFirefoxは50%前後でスタートし、Firefoxは中程度にしか向上していませんが、Chrome/Edgeは65%近くまで少し向上しています。Safariは90%強でスタートし、95%以上に上昇しました。",
  width=719,
  height=684
  )
}}

#### ビューポートユニット

2020 MDNブラウザ互換性レポートでは、<a hreflang="en" href="https://insights.developer.mozilla.org/reports/mdn-browser-compatibility-report-2020.html#findings-viewport">既存のvh/vw単位で報告されたビューポートのサイズで動作する機能は、共通のテーマでした</a>。ブラウザがさまざまなインターフェイスの選択を体験し、ウェブサイトがさまざまなデザインのニーズを持つようになったため<a hreflang="en" href="https://drafts.csswg.org/css-values-4/#viewport-variants">CSS Working Groupはもっとも大きい（`lv*` 単位）、もっとも小さい（`sv*` 単位）、そして動的な（`dv*` 単位）ビューポート測定を測定するためにビューポート単位のいくつかの新しいクラス</a>を定義しました。すべてのビューポート関連のメジャーは、同様の単位を含みます。

- 幅の1% (`vw`, `lvw`, `svw`, `dvw`)
- 高さの1% (`vh`, `lvh`, `svh`, `dvh`)
- インライン軸のサイズの1% (`vi`, `lvi`, `svi`, `dvi`)
- 最初に含まれるブロックのサイズの1% (`vb`, `lvb`, `svb`, `dvb`)
- 2つの次元のうち小さい方 (`vmin`, `lvmin`, `svmin`, `dvmin`)
- 2つの次元のうち大きい方 (`vmax`, `lvmax`, `svmax`, `dvmax`)

{{ figure_markup(
  image="viewport-units-wpt-dashboard.png",
  caption='ビューポート・ユニットWPTダッシュボード（実験的）。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-viewport">ウェブプラットフォームテスト</a>)',
  description="過去1年間の実験的リリースにおけるビューポートユニットのスコアを示したグラフ。1月には、どのエンジンもビューポートユニットをサポートしていませんでした。Safariは2月に約65％のサポートを獲得し、早期にジャンプしましたが、すぐに約87％のサポートでChromeに追い越されました。9月の時点では、すべてのエンジンが100%の合格率を記録しています。",
  width=732,
  height=697
  )
}}

Interop 2022では、これらのユニットのさまざまな側面を検証するための7つのテストが特定されました。Safariは2022年3月に、Firefoxは5月末に、これらのユニットをはじめてサポートしました。本稿執筆時点では、Chromiumの実験的ビルドでサポートされています。

この記事を書いている時点では、HTTP Archiveはまだこれらのユニットの使用を発見していませんが、非常に新しいものです。私たちは今後もこのユニットの採用を追跡します。

#### カスケードレイヤー

カスケード・レイヤーはCSSの興味深い新機能で、CSSにずっと存在していた基本的なアイデアの上に構築されています。作者として、私たちがルールの重要性を表現する主な手段は、「具体性」でした。これは多くのことに有効ですが、デザインシステムやコンポーネントのアイデアを取り入れようとすると、すぐに扱いにくくなります。ブラウザはまた、UAスタイルシートと呼ばれるもので内部的にCSSを使います。しかし、UAスタイルシートでは、ふつうは特異性に関連した争いは起きないことにお気づきかもしれません。それは、CSSが機能する仕組みの中に、ルールの "レイヤー "が組み込まれているからです。カスケード・レイヤーは、作者が同じメカニズムにプラグインし、CSSと特異性の課題をより効果的に管理する方法を提供します。[Miriam Suzanne](https://x.com/TerribleMia)は、<a hreflang="en" href="https://css-tricks.com/css-cascade-layers/">より詳しい説明とガイド</a>を書きました。

{{ figure_markup(
  image="cascade-layers-wpt-dashboard.png",
  caption='カスケードレイヤーWPTダッシュボード（実験的）。<br>(ソース: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-cascade">ウェブプラットフォームテスト</a>)',
  description="過去1年間の実験的リリースにおけるカスケードレイヤーサポートのスコアを示すチャート。1月の時点で、Firefoxのサポート率はおよそ75%、Safariは62%、Chromeはわずか11%でした。1年を通して、それぞれが着実にスコアを伸ばしています。9月現在、FirefoxとChromeは約96%、Safariは100%です。",
  width=720,
  height=675
  )
}}

これをうまく開始するために、Interop 2022はウェブプラットフォームテストで <a hreflang="en" href="https://wpt.fyi/results/css/css-cascade?label=experimental&label=master&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-cascade">31個のテストを定義しました</a>。今年の初めには、安定したブラウザでのサポートは存在しませんでしたが、4月以降、3つのエンジンの安定したリリースで普遍的に実装されています。以下は開発の様子です。

{{ figure_markup(
  caption="`@layer`ルールセットを含むモバイルページの割合。",
  content="0.003%",
  classes="big-number",
  sheets_gid="474436360",
  sql_file="layer_adoption.sql"
)
}}

今年のデータセットの時点では、レイヤーは野生のごく少数の場所で発生。

Web Almanacの今後のエディションでは、カスケード・レイヤーの採用と傾向を追跡します。整合性のある作業、緊密なリリース、優れた相互運用性への早期集中が、その潜在能力を発揮し、不満を軽減するのに役立つことを願っています。

どこでも出荷されている今こそ、Cascade LayersがCSSのコントロールにどのように役立つかを学ぶ絶好の機会です。

## 結論

相互運用性は標準の目標であり、最終的には大規模な採用の鍵となります。しかし、実際には、相互運用性に到達するためには、複雑な独立した作業、集中力、予算、優先順位の集大成が必要です。歴史的には、実装の着地と非互換性の間に何年ものギャップが生じることもあり、これは時として困難なことでした。ブラウザーベンダーはこのフィードバックを聞き、既存のギャップを埋めるための協調的な取り組みに重点を置き、新しい実装が非常に高い相互運用性を持って到着するまでの期間を短縮する努力を始めました。

私たちは、今年行われたこの作業のレビューが、開発者に情報を提供し、これらの機能の採用や注目を促す一助となることを願っています。私たちはできる限りの指標を追跡し続け、私たちがどのようにやっているかという感覚を伝え、どこにどのように焦点を当てるかに影響を与えるために、データをどのように利用できるかということに目を向けていきます。
