---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: リソースヒント
description: 2020年版Web Almanacのリソースヒントの章では、dns-prefetch、preconnect、preload、prefetch、Priority Hints、native lazy loadingの使い方を紹介しています。
authors: [Zizzamia]
reviewers: [jessnicolet, pmeenan, giopunt, mgechev, notwillk]
analysts: [khempenius]
editors: [exterkamp]
translators: [ksakae1216]
Zizzamia_bio: Leonardoは、<a hreflang="en" href="https://www.coinbase.com/">Coinbase</a>のスタッフソフトウェアエンジニアとして、ウェブパフォーマンスと成長イニシアチブを担当しています。また、<a hreflang="en" href="https://ngrome.io">NGRome Conference</a>を主催しています。Leonardoはまた、パフォーマンス分析を通じて企業がロードマップに優先順位をつけ、より良いビジネス上の意思決定を行えるよう支援する<a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a>ライブラリを管理しています。
discuss: 2057
results: https://docs.google.com/spreadsheets/d/1lXjd8ogB7kYfG09eUdGYXUlrMjs4mq1Z7nNldQnvkVA/
featured_quote: 過去1年間にリソースヒントの採用が増加し、開発者がリソースの優先順位付けや最終的なユーザー体験の多くの側面をより詳細に制御するために、リソースヒントは不可欠なAPIとなりました。
featured_stat_1: 33%
featured_stat_label_1: `dns-prefetch`を使用しているサイト
featured_stat_2: 9%
featured_stat_label_2: `preload`を使用しているサイト
featured_stat_3: 4.02%
featured_stat_label_3: ネイティブの遅延ローディングを使用しているサイト
---

## 序章

過去10年間で、<a hreflang="en" href="https://www.w3.org/TR/resource-hints/">リソースヒント</a>は、開発者がページのパフォーマンスを向上させ、その結果としてユーザー体験を向上させるために不可欠なプリミティブとなりました。

リソースのプリロードや、ブラウザによるインテリジェントな優先順位付けは、実は2009年にIE8が<a hreflang="en" href="https://speedcurve.com/blog/load-scripts-async/">プリローダー</a>と呼ばれるものを使って始めたことでした。IE8には、HTMLパーサーに加えて、ネットワーク リクエストを開始する可能性のあるタグ (`<script>`、`<link>`、`<img>`) をスキャンする軽量のルックアヘッド プリローダーが搭載されていました。

その後の数年間、ブラウザのベンダーがより多くの作業を行い、それぞれがリソースの優先順位の付け方について独自の特別なソースを追加しました。しかし、ブラウザだけでは限界があることを理解することが大切です。開発者である私たちはリソースヒントをうまく利用してリソースの優先順位を決定したり、ページのパフォーマンスをさらに向上させるためにどのリソースをフェッチしたり、前処理したりするべきかを判断することでこの限界を克服できます。

とくに、昨年達成したリソースのヒントをいくつか挙げます。
- <a hreflang="en" href="https://www.zachleat.com/web/css-tricks-web-fonts/">CSS-Tricks</a> Webフォントが3Gの初回レンダリングでより速く表示されるようになりました。
- リソースヒントを使用した<a hreflang="en" href="https://www.youtube.com/watch?v=4QqlGgF8Y2I&t=1469">Wix.com</a>では、FCPで10％の改善が見られました。
- <a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">Ironmongerydirect.co.uk</a>は、preconnectを使用して、製品画像の読み込みを中央値で400ms、95パーセンタイルで1秒以上改善しました。
- <a hreflang="en" href="https://engineering.fb.com/2020/05/08/web/facebook-redesign/">Facebook.com</a>は、ナビゲーションを高速化するためにpreloadを使用していました。

今日、ほとんどのブラウザでサポートされている主なリソースヒントを見てみましょう。`dns-prefetch`、`preconnect`、`preload`、`prefetch`、そしてネイティブの遅延ローディングです。

個々のヒントに取り組む際には、<a hreflang="en" href="https://github.com/GoogleChrome/web-vitals">WebVitals</a>、<a hreflang="en" href="https://github.com/zizzamia/perfume.js">Perfume.js</a>などのライブラリや、Web Vitalsのメトリクスをサポートするその他のユーティリティを使用して、常に現場での前後の影響を測定することをオススメします。

### `dns-prefetch`

<a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/">`dns-prefetch`</a> は、指定されたドメインのIPアドレスを事前解決するのに役立ちます。利用可能な<a hreflang="en" href="https://caniuse.com/link-rel-dns-prefetch">もっとも古い</a>リソースヒントとして、`preconnect`と比較して最小限のCPUとネットワークリソースを使用し、ブラウザがDNS解決のための <a hreflang="en" href="https://www.chromium.org/developers/design-documents/dns-prefetching">1秒以上</a>の「最悪のケース」の遅延を経験しないことに役立ちます。

```html
<link rel="dns-prefetch" href="https://www.googletagmanager.com/">
```

`dns-prefetch`を使用する際には注意が必要です。軽量であっても、ブラウザが許容する同時進行のDNSリクエスト数の制限を簡単に超えてしまうからです（Chromeにはまだ<a hreflang="en" href="https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353">6</a>の制限があります）。

### `preconnect`

<a hreflang="ja" href="https://web.dev/i18n/ja/uses-rel-preconnect/">`preconnect`</a>は、指定されたドメインのIPアドレスを事前に解決し、TCP/TLS接続を開くのに役立ちます。`dns-prefetch`と同様に、クロスオリジンのドメインに使用され、最初のページ読み込み時に使用されるリソースをブラウザがウォームアップするのに役立ちます。

```html
<link rel="preconnect" href="https://www.googletagmanager.com/">
```

`preconnect`を使用する際には注意が必要です。

- もっとも頻度の高い、重要なリソースのみを温めます。
- 最初の負荷をかける際に、使用したオリジンのウォームアップが遅すぎないようにする。
- CPUやバッテリーのコストが、かかる場合があるので、3つ以下のoriginで使用してください。

最後に、`preconnect`は<a hreflang="en" href="https://caniuse.com/?search=preconnect">Internet ExplorerやFirefox</a>では利用できませんので、<a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/#resolve-domain-name-early-with-reldns-prefetch">予備として`dns-prefetch`を利用することを</a>強くオススメします。

### `preload`

<a hreflang="en" href="https://web.dev/uses-rel-preload/">`preload`</a> ヒントは、早期のリクエストを開始します。これはパーサーが、発見するのが遅れるような重要なリソースを読み込むのに便利です。

```html
<link rel="preload" href="style.css" as="style">
<link rel="preload" href="main.js" as="script">
```

`preload`することを意識します。なぜなら他のリソースのダウンロードを遅らせる可能性があるため、Largest Contentful Paint（<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">LCP</a>）の改善に役立つ、もっとも重要なものにのみ使用してください。 また、Chromeで使用した場合、`preload`リソースを過剰に優先する傾向があり、他の重要なリソースよりもpreloadを優先的に処理する可能性があります。

最後に、HTTPレスポンスヘッダーで使用された場合、一部のCDNは`preload`を自動的に[HTTP/2 push](#http2-push)に変えてしまい、キャッシュされたリソースを過剰にプッシュしてしまうことがあります。

### `prefetch`

<a hreflang="en" href="https://web.dev/link-prefetch/">`prefetch`</a>ヒントを使用すると、次のナビゲーションで使用されると予想される低優先度のリクエストを開始できます。このヒントは、リソースをダウンロードして、あとで使用するためHTTPキャッシュにドロップします。重要なのは、`prefetch`はリソースの実行やその他の処理を行わず、実行するにはページが`<script>`タグでリソースを呼び出す必要があるということです。

```html
<link rel="prefetch" as="script" href="next-page.bundle.js">
```

リソースの予測ロジックを実装する方法はさまざまで、ユーザーのマウスの動きや一般的なユーザーフロー/ジャーニーなどの信号に基づいたり、機械学習の上に両者を組み合わせたりすることもできます。

使用しているCDNの<a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues#current-status">HTTP/2の優先順位付けの品質</a>によっては、`prefetch`の優先順位付けがパフォーマンスを向上させることもあれば、`prefetch`のリクエストを過剰に優先させ、最初のロードのために重要な帯域を奪い、パフォーマンスを低下させることもあることに注意してください。使用しているCDNを再確認し、<a hreflang="en" href="https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/">Andy Davies氏の</a>記事で紹介されているベストプラクティスを考慮に入れてください。

### ネイティブの遅延読み込み

<a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">ネイティブの遅延読み込み</a>のヒントは、画面外の画像やiframeの読み込みを延期するためのネイティブブラウザAPIです。これを使用することで、最初のページロード時に必要のないアセットはネットワークリクエストを開始しないため、データ消費量が削減され、ページパフォーマンスが向上します。

```html
<img src="image.png" loading="lazy" alt="…" width="200" height="200">
```

留意点:Chromiumの遅延読み込みのしきい値ロジックの実装は、これまで<a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds">保守的</a>で、画面外の制限を3000pxに保っていました。昨年この制限は積極的にテストされ、開発者の期待に沿うように改善され、最終的にしきい値を1250pxに変更しました。また、<a hreflang="en" href="https://github.com/whatwg/html/issues/5408">ブラウザ間の標準はなく</a>、ウェブ開発者がブラウザの提供するデフォルトしきい値を上書きする機能はまだありません。

## リソースのヒント

HTTP Archiveをもとに、2020年のトレンド分析に飛び込み、前回の2019年のデータセットと比較してみましょう。

### ヒントの採用

ますます多くのウェブページがメインリソースのヒントを使用しており、2020年にはデスクトップとモバイルの間で一貫した採用が行われると見られています。

{{ figure_markup(
  image="adoption-of-resource-hints.png",
  caption="リソースヒントの採用",
  description="リソースヒントの採用率をヒントの種類とフォームファクター別に分けた棒グラフです。デスクトップでは、33％のページで`dns-prefetch`のリソースヒントが使われており、18％が`preload`、8％が`preconnect`、3％が`prefetch`、1％未満が`prerender`となっています。モバイルも同様で、`dns-prefetch`が34％（1％増）、`preconnect`が9％（1％増）となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1550112064&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

`dns-prefetch`の採用率が33％と他のリソースヒントに比べて相対的に高いのは、2009年にはじめて登場し主要なリソースヒントの中でもっとも広くサポートされていることから、当然のことと言えるでしょう。

[2019](../2019/resource-hints#resource-hints)と比較すると、`dns-prefetch`はDesktopの採用率が4％増加していました。また、`preconnect`でも同様の増加が見られました。すべてのヒントの中でもっとも大きな伸びを示した理由の1つは、<a hreflang="ja" href="https://web.dev/i18n/ja/uses-rel-preconnect/">Lighthouse audit</a>がこの問題に関して明確で有益なアドバイスをしていることです。今年のレポートからは、最新のデータセットがLighthouseの推奨事項に対してどのようなパフォーマンスを示すかについても紹介しています。

{{ figure_markup(
  image="resource-hint-adoption-2019-vs-2020.png",
  caption="リソースヒントの採用2019年対2020年",
  description="2019年と2020年のモバイルにおけるリソースヒントの採用率を、ヒントタイプ別に比較した棒グラフです。ほぼすべてのリソースヒントタイプで利用率が増加していることがわかります。`dns-prefetch`は29％から34％へと5％増加しました。`preload`は16％から18％へと2％増加しました。`preconnect`は4％から9％へと5％増加しました。`prefetch`は3％と横ばいでした。また、`prerender`も1％未満で横ばいです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1494186122&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

`preload`の使用率は2019年から2％の増加にとどまり、伸び悩んでいます。これは、もう少し多くの指定を必要とすることが一因と考えられます。`dns-prefetch`や`preconnect`を使用するにはドメインが必要なだけですが、`preload`を使用するにはリソースを指定する必要があります。`dns-prefetch`と`preconnect`は悪用される可能性があるものの、それなりにリスクが低いのに対し、`preload`は間違った使い方をすると、実際パフォーマンスにダメージを与える可能性がはるかに大きいのです。

`prefetch`はデスクトップの3％のサイトで使用されており、リソースヒントの中でもっとも使用されていないものです。この使用率の低さは、`prefetch`が現在のページロードではなく、その後のページロードを改善するために有用であるという事実から説明できるかもしれません。そのため、サイトがランディングページや最初に表示されるページのパフォーマンスを向上させることだけに注力している場合には、見落とされてしまいます。今後数年間で、後続のページのエクスペリエンスを向上させるために何を測定すべきかがより明確に定義されれば、チームが到達すべき明確なパフォーマンス品質目標を持って`prefetch`の採用を優先するのに役立つでしょう。

### ページあたりのヒント

全体的に開発者はリソースヒントの上手な使い方を学んでおり、[2019](../2019/resource-hints#resource-hints)と比較すると、`preload`、`prefetch`、`preconnect`の使用率が向上していることがわかります。preloadやpreconnectなどの高価な操作では、デスクトップでの使用量の中央値が2から1に減少しました。一方、`prefetch`で優先度の低い将来のリソースをロードする場合は、ページあたりの中央値が1から2に増加しました。

{{ figure_markup(
  image="median-number-of-hints-per-page.png",
  caption="1ページあたりのヒント数の中央値",
  description="ページあたりのリソースヒント数の中央値を、リソースヒントの種類とフォームファクターごとに分けた棒グラフです。`preload`と`prerender`は、モバイルとデスクトップの両方で、1ページあたり1つのヒントを持っています（中央値）。`prefetch`と`dns-prefetch`は、モバイルとデスクトップの両方で、1ページあたり2つのヒントがあります（中央値）。`preconnect`は、デスクトップでは1ページあたり1つのヒント（中央値）、モバイルでは1ページあたり2つのヒント（中央値）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=320451644&format=interactive",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

リソースヒントは、選択的に使用されるときにもっとも効果的です（「すべてが重要なとき、何も重要ではない」）。どのリソースが重要なレンダリングの改善に役立つのか将来のナビゲーションの最適化に役立つのかをより明確に定義することで、リソースの優先順位付けの一部を変更し、最初ユーザーにもっとも役立つもののために帯域幅を解放することで、`preconnect`の使用から`prefetch`へと焦点を移すことができます。

あるページでは、ヒントを動的に追加し、20k以上の新しいプリロードを作成する無限ループを引き起こしていることが判明しました。これは`preload`ヒントの誤用を阻止していません。

{{ figure_markup(
  caption="1つのページでもっとも多くのプリロードヒントを提供しています。",
  content="20,931",
  classes="big-number",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

リソースヒントを使った自動化がますます進む中、プリロードヒントやその他の要素を動的に注入する際には注意が必要です。

### `as`属性

`preload`や`prefetch`では、`as`属性を使用して、ブラウザがリソースの優先順位をより正確に判断できるようにすることが重要です。そうすることで将来のリクエストに備えてキャッシュに適切に保存し、正しいコンテンツセキュリティポリシー([CSP](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP))を適用し、正しい`Accept`リクエストヘッダーを設定できます。

`preload`では、さまざまなコンテンツタイプをプリロードできます。[完全なリスト](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#Attributes)は、Fetch <a hreflang="en" href="https://fetch.spec.whatwg.org/#concept-request-destination">spec</a>で推奨されているものにしたがっています。もっとも人気があるのは、64％の使用率を誇る `script` タイプです。これはシングルページアプリとして構築されたサイトの大部分が、残りのJS依存ファイルのダウンロードを開始するために、できるだけ早くメインバンドルを必要としていることに関連していると考えられます。その後の使用率は、fontが8％、styleが5％、imageが1％、fetchが1％となっています。

{{ figure_markup(
  image="mobile-as-attribute-values-by-year.png",
  caption="モバイルの`as`属性の値を年ごとに表示します。",
  description="2019年と2020年のモバイルページにおける`as`属性値の使用率を、`as`属性値ごとに比較した棒グラフです。2019年の使用率81％、2020年の使用率64％と、`as`値の大半は`script`であることがわかります。`script`の使用率は前年比で17％減少したが、他の値はすべて使用率が増加しました。`not set`は8％増、`font`は5％増、`style`は2％増、その他の注目すべき値は両年とも1％以下となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=903180926&format=interactive",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

[2019](../2019/resource-hints#the-as-attribute)の傾向と比較すると、`as`属性でのフォントやスタイルの使用が急激に増加しています。これは、開発者が重要なCSSの優先度を上げていることや、<a hreflang="ja" href="https://web.dev/i18n/ja/optimize-cls/#web-fonts-causing-foutfoit">改善</a>のために`preload`フォントを`display:optional`と組み合わせて、Cumulative Layout Shift（<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">CLS</a>）を実現していることに関連していると考えられます。

`as`属性が省略されていたり無効な値が設定されていると、ブラウザが正しい優先順位を判断することが難しくなりスクリプトなどの場合には、リソースが2回取得されることもあるので注意が必要です。

### `crossorigin`属性

フォントなどのCORSが有効になっている`preload`や`preconnect`のリソースでは、そのリソースを適切に使用するために`crossorigin`属性を含めることが重要です。`crossorigin`属性がない場合、リクエストはシングルオリジンのポリシーに従いますので、preloadの使用は無意味になります。

{{ figure_markup(
  caption="`preload`を持つ要素のうち、`crossorigin`を使用する割合です。",
  content="16.96％",
  classes="big-number",
  sheets_gid="1185042785",
  sql_file="attribute_usage.sql"
) }}

最近の傾向としては、`preload`を行う要素のうち、`crossorigin`を設定し、anonymous（またはそれに準ずる）モードで読み込むものが16.96％、`use-credentials`を利用するものは0.02％にとどまっています。前述のフォントプリロードの増加に伴い、この割合も増加しています。

```html
<link rel="preload" href="ComicSans.woff2" as="font" type="font/woff2" crossorigin>
```

`crossorigin`属性を持たずにプリロードされたフォントは、<a hreflang="ja" href="https://web.dev/i18n/ja/preload-critical-assets/#how-to-implement-relpreload">2回</a>取得されてしまうことに注意してください。

### `media`属性

異なるスクリーンサイズで使用するリソースを選択する際には、`media`属性と `preload`を使用して、メディアクエリを最適化してください。

```html
<link rel="preload" href="a.css" as="style" media="only screen and (min-width: 768px)">
<link rel="preload" href="b.css" as="style" media="screen and (max-width: 430px)">
```

2020年のデータセットでは、メディアクエリの組み合わせが2,100通り以上あることから、レスポンシブデザインのコンセプトと実装の間にサイトごとの差異がどれだけあるかを考えてみました。データには、Bootstrapなどでおなじみのブレークポイント`767px/768px`も含まれています。

### ベストプラクティス

リソースヒントの使い方は、時に混乱を招くので、Lighthouseの自動監査に基づいて従うべき簡単なベストプラクティスを説明します。

`dns-prefetch`と`preconnect`を安全に実装するには、それらを別々のリンクタグにしてください。

```html
<link rel="preconnect" href="http://example.com">
<link rel="dns-prefetch" href="http://example.com">
```

同じ`<link>`タグ内に`dns-prefetch`フォールバックを実装すると、Safariで<a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=197010">バグ</a>が発生し、`preconnect`リクエストがキャンセルされてしまいます。2％近いページ（～40k）で、1つのリソースに`preconnect`と`dns-prefetch`の両方が存在するという問題が報告されました。

"<a hreflang="ja" href="https://web.dev/i18n/ja/uses-rel-preconnect/">Preconnect to required origins</a>"の監査の場合、テストに合格したページはわずか19.67％で、何千ものウェブサイトが`preconnect`や`dns-prefetch`を使用して重要なサードパーティオリジンへの早期接続を確立し始める大きな機会を生み出していました。

{{ figure_markup(
  caption="Lighthouseの`preconnect`監査に合格したページの割合。",
  content="19.67％",
  classes="big-number",
  sheets_gid="152449420",
  sql_file="lighthouse_preconnect.sql"
) }}

最後に、Lighthouseの"<a hreflang="en" href="https://web.dev/uses-rel-preload/">Preload key requests</a>"の監査を実行した結果、84.6％のページがテストに合格しました。はじめて`preload`を使おうとしている人は、フォントやクリティカルスクリプトを覚えておくといいでしょう。

### ネイティブの遅延ローディング

今回は、<a hreflang="en" href="https://addyosmani.com/blog/lazy-loading/">Native Lazy Loading</a> APIの1周年をお祝いしましょう。このAPIは、公開時点ですでに<a hreflang="en" href="https://caniuse.com/loading-lazy-attr">72%</a>のブラウザをサポートしています。この新しいAPIを利用することで、ページ内の折り返し以下のiframeや画像の読み込みを、ユーザーがその近くでスクロールするまで延期できます。これにより、データ使用量やメモリ使用量を削減し、折り返し部分のコンテンツを高速化できます。遅延ロードを有効にするには、`<iframe>`や`<img>`要素に`loading=lazy`を追加するだけです。

{{ figure_markup(
  caption="ネイティブの遅延ローディングを使用しているページの割合。",
  content="4.02％",
  classes="big-number",
  sheets_gid="2039808014",
  sql_file="native_lazy_loading_attrs.sql"
) }}

とくに、今年初めに発表された公式基準値は保守的すぎ、<a hreflang="en" href="https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/">最近</a>ようやく開発者の期待に応えられる状況です。約72％のブラウザがネイティブ画像/ソースの遅延ローディングをサポートしていることから、とくにローエンドデバイスでのデータ使用量やパフォーマンスを改善したいページにとっては、この分野もチャンスとなります。

Lighthouseの「<a hreflang="en" href="https://web.dev/offscreen-images/">Defer offscreen images</a>」監査を実行した結果、68.65％のページがテストに合格しました。これらのページでは、すべての重要なリソースのロードが完了した後に、画像を遅延ロードできます。

ビューポートが変わると画像が画面外に出てしまうことがあるので、デスクトップとモバイルの両方で監査を行うように注意してください。

## 予測型プリフェッチ

`prefetch`と機械学習を組み合わせることで、後続のページのパフォーマンスを向上させることができます。このソリューションの1つに、<a hreflang="en" href="https://github.com/guess-js/guess">Guess.js</a>があります。予測型プリフェッチの最初のブレークスルーとなり、すでに10以上のウェブサイトが本番で使用しています。

<a hreflang="en" href="https://web.dev/predictive-prefetching/">予測型プリフェッチ</a>は、データ分析や機械学習の手法を用いて、データに基づいたプリフェッチのアプローチを提供する手法です。Guess.jsは、一般的なフレームワーク（Angular、Nuxt.js、Gatsby、Next.js）で予測型プリフェッチをサポートしているライブラリで、今日からでも利用できます。Guess.jsは、ページから可能なナビゲーションをランク付けし、次必要になりそうなJavaScriptのみをプリフェッチします。

学習セットにもよりますが、Guess.jsのプリフェッチは90％以上の精度で行われています。

全体的に見ると予測型プリフェッチはまだ未知の領域ですが、マウスオーバー時のプリフェッチやサービスワーカーのプリフェッチと組み合わせることで、ウェブサイトを利用するすべてのユーザーにデータを節約しながら瞬時に体験を提供できる大きな可能性を秘めています。

## HTTP/2プッシュ

[HTTP/2](./http)には「サーバープッシュ」と呼ばれる機能があり、製品のラウンドトリップタイム([RTTs](https://developer.mozilla.org/ja/docs/Glossary/Round_Trip_Time_(RTT)))やサーバーの処理が長い場合に、ページのパフォーマンスを改善できる可能性があります。簡単に説明すると、クライアントがリクエストを送信するのを待つのではなく、クライアントがすぐにリクエストするだろうと予測したリソースをサーバーが先取りしてプッシュするのです。

{{ figure_markup(
  caption="`preload`/`nopush`を使用したHTTP/2 Pushページの割合です。",
  content="75.36％",
  classes="big-number",
  sheets_gid="308166349",
  sql_file="h2_preload_nopush.sql"
) }}

HTTP/2 Pushは多くの場合、`preload`リンクヘッダーを通して開始されます。2020年のデータセットでは、1％のモバイルページがHTTP/2プッシュを使用しており、そのうち75％のプリロードヘッダーリンクがページリクエストで`nopush`オプションを使用していました。これはウェブサイトが`preload`リソースヒントを使用していても、大多数はこれだけを使用し、そのリソースのHTTP/2プッシュを無効にすることを好むということです。

HTTP/2 Pushは、正しく使用しないとパフォーマンスを損なう可能性があることを言及しておくことが重要で、これがしばしば無効にされる理由となっています。

このパターンは、**重要なリソースをプッシュ**（またはプリロード）し、**最初のルートをできるだけ早くレンダリング**し、**残りのアセットをプリキャッシュ**し、**他のルートや重要でないアセットを遅延ロード**するというものです。これは、WebサイトがProgressive Web Appであり、キャッシング戦略を改善するためにService Workerを使用している場合にのみ可能です。このようにすることで、それ以降のすべてのリクエストがネットワークに出ることはないので、常にプッシュする必要はなく両方の利点を得ることができます。

## サービス・ワーカー

`preload`と`prefetch`の両方において、ページが<a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers">Service Worker</a>によって制御されている場合に採用が増えています。これはService Workerがまだアクティブでないときにプリロードすることでリソースの優先順位を向上させたり、将来のリソースをインテリジェントにプリフェッチしてユーザーが必要とする前に、Service Workerにキャッシュできる可能性があるためです。

{{ figure_markup(
  image="resource-hint-adoption-onservice-worker-pages.png",
  caption="サービスワーカーページでのリソースヒント採用。",
  description="サービスワーカーのページにリソースヒントが採用されている割合を、ヒントの種類とフォームファクターごとに分けた棒グラフです。デスクトップでは、29％のページが`dns-prefetch`リソースヒントを使用し、47％が`preload`、34％が`preconnect`、10％が`prefetch`、1％未満が`prerender`を使用しています。モバイルも同様で、`dns-prefetch`が30％（1％増）、`preconnect`が34％（13％減）となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=252958553&format=interactive",
  sheets_gid="691299508",
  sql_file="adoption_service_workers.sql"
) }}

デスクトップの`preload`では47％、`prefetch`では10％という優れた採用率となっています。いずれの場合も、Service Workerを使用しない場合の平均的な採用率と比較して、非常に高いデータとなっています。

先に述べたように、リソースヒントとサービスワーカーのキャッシュ戦略をどのように組み合わせるかについては、<a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPLパターン</a>が今後重要な役割を果たすことになるでしょう。

## 未来

ここでは、実験的なヒントをいくつか紹介します。リリースに非常に近いところではPriority Hintsがあり、これはWebコミュニティで積極的に実験されています。また、HTTP/2の103 Early Hintsもありますが、これはまだ初期段階にあり、<a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">ChromeやFastlyのような数人のプレイヤーが今後のテストトライアルに向けて協力しています</a>。

### 優先順位のヒント

<a hreflang="en" href="https://developers.google.com/web/updates/2019/02/priority-hints">優先度のヒント</a>はリソースのフェッチの優先度を表現するためのAPIです：高、低、または自動。画像の優先順位を下げたり（カルーセルの中など）、スクリプトの優先順位を変えたり、さらにはフェッチの優先順位を下げたりするのにも使用できます。

この新しいヒントは、HTMLタグとして、またはHTML属性と同じ値を取る`importance`オプションを使ってフェッチリクエストの優先順位を変更することで使用できます。

```html
<!-- リソースの早期取得を開始したいが、同時に優先順位を下げたい -->
<link rel="preload" href="/js/script.js" as="script" importance="low">

<!-- ブラウザが「高」の優先順位をつけている画像ですが、実際にはそれを望んでいません。 -->
<img src="/img/in_view_but_not_important.svg" importance="low" alt="I'm not important!">
```

`preload`や`prefetch`では、リソースの種類に応じてブラウザが優先順位を設定します。優先度のヒントを使うことで、ブラウザにデフォルトのオプションを変更させることができます。

{{ figure_markup(
  caption="モバイルでのプライオリティ・ヒントの採用率。",
  content="0.77％",
  classes="big-number",
  sheets_gid="1596669035",
  sql_file="priority_hints.sql"
) }}

Chromeはまだ<a hreflang="en" href="https://www.chromestatus.com/features/5273474901737472">積極的に</a>実験を行っているため、今のところ0.77％のウェブサイトしかこの新しいヒントを採用しておらず、この記事のリリース時点ではこの機能は保留されています。

もっとも多く使用されているのはscript要素で、これはJSのプライマリファイルやサードパーティファイルの数が増え続けていることからも当然のことです。

{{ figure_markup(
  caption="ヒントのあるモバイルリソースのうち、`低`の優先度を使っている割合です。",
  content="16％",
  classes="big-number",
  sheets_gid="1098063134",
  sql_file="priority_hints_by_importance.sql"
) }}

データによると、優先度ヒントを使用しているリソースの83％がモバイルで「高い」優先度を使用していますが、さらに注目すべきは「低い」優先度のリソースが16％あることです。

優先度ヒントは「高い」優先度でリソースをより早く読み込ませようとする戦術ではなく、ブラウザが何を優先度から外すべきかを判断し重要なリクエストを先に完了させるため重要なCPUや帯域を返すことで、「低い」優先度によるムダな読み込みを防ぐツールとして明らかな優位性を持っています。

### HTTP/2の103 Early Hints
前回、HTTP/2プッシュは、プッシュされるアセットがすでにブラウザのキャッシュにある場合、実際にリグレッションを引き起こす可能性があると述べました。<a hreflang="en" href="https://tools.ietf.org/html/rfc8297">103 Early Hints</a>の提案は、HTTP/2プッシュで約束された同様の利点を提供することを目的としています。潜在的に10倍シンプルなアーキテクチャで、サーバープッシュによる不必要なラウンドトリップという既知のワーストケースの問題に悩まされることなく、長いRTTやサーバー処理に対処します。

現在のところ、Chromiumでは<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=671310">671310</a>、<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1093693">1093693</a>、<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1096414">1096414</a>の問題で会話を追うことができます。

## 結論

昨年、リソースヒントの採用が増加し、開発者がリソースの優先順位付けや最終的なユーザー体験の多くの側面をより詳細にコントロールするために不可欠なAPIとなりました。しかし、これらは指示ではなくヒントであり、残念ながら最終的な決定権は常にブラウザとネットワークにあることを忘れてはなりません。

確かに、たくさんの要素にそれらを適用すれば、ブラウザはあなたの要求通りに動くかもしれません。あるいは、ヒントを無視して、デフォルトの優先順位が状況に応じて最適な選択であると判断するかもしれません。いずれにしても、これらのヒントをどのように使うのがベストなのか、プレイブックを用意しておきましょう。

- ユーザー体験のための重要なページを特定する。
- 最適化すべきもっとも重要なリソースを分析します。
- 可能な限り、<a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPLパターン</a>を採用する。
- それぞれの導入前と導入後のパフォーマンス体験を測定する。

最後になりましたが、ウェブはすべての人のためにあることを忘れないでください。私たちは、ウェブを守り続け、簡単で摩擦のない体験を構築することに集中しなければなりません。

私たちはすべての人に優れたウェブ体験を提供するために必要なすべてのAPIの提供に、年々少しずつ近づいていることを嬉しく思っていますし、次に何が来るのかを楽しみにしています。
