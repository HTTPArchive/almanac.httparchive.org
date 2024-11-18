---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: 2022年のWeb AlmanacのHTTP章では、ウェブ全体で使用されているHTTPの歴史的バージョンに関するデータと、HTTP/2やHTTP/3を含む新しいバージョンの増加について取り上げています。また、HTTPライフサイクルの重要な指標の検証も行っています。
hero_alt: Hero image of Web Almanac characters driving vehicles in various lanes carrying script and images resources.
authors: [paivaspol]
reviewers: [tunetheweb, rmarx, LPardue]
analysts: [paivaspol]
editors: [tunetheweb]
translators: [ksakae1216]
paivaspol_bio: Vaspol RuamviboonsukはMicrosoftのソフトウェアエンジニアです。彼はミシガン大学でウェブページの読み込み速度を向上させるシステムに関する研究を行い、博士号を取得しました。彼と<a hreflang="en" href="https://www.linkedin.com/in/vaspol-ruamviboonsuk-7898b824/">LinkedIn</a>で繋がることができます。
results: https://docs.google.com/spreadsheets/d/1NJrPOjBoJSDsHV0rAHpcZ9qBUgy6RVG3QtvbTqrj5_o/
featured_quote: この1年はHTTPプロトコルにとって事件が多い年でした、とくにHTTP/3が標準化されたことによります。私たちは引き続き高いHTTP/2の利用を観察しており、ウェブサーバーからの強力な今後のHTTP/3サポートを見ています。
featured_stat_1: 77%
featured_stat_label_1: HTTP/2以上で提供されるリクエスト
featured_stat_2: 1.5%
featured_stat_label_2: 103 Early Hintsを採用しているウェブサイト
featured_stat_3: 50%
featured_stat_label_3: HTTP/3サポートを持つリクエストの増加
---

## 序章

HTTPはウェブエコシステムの基盤であり、データ交換の基礎を提供し、さまざまなタイプのインターネットサービスを可能にします。とくに過去数年間で、HTTP/2や最近ではHTTP/3の導入により、いくつかの進化を遂げています。HTTP/2は、HTTP/1.1の同時に処理できるリクエストの数が限られているといった欠点を解決しようとしました。一見すると、HTTP/3はHTTP/2と似ておりセマンティクスは同じですが、内部的にはTCPの代わりにQUICをトランスポートプロトコルとして利用する点で、先行するバージョンと根本的に異なります。

HTTP/2がHTTP/3の基礎を提供するため、HTTP/2 Push、優先順位付け、多重化などのHTTP/2の主要機能を分析し、それらがどれだけまだ使用されているかを理解します。また、これらの機能のさまざまな展開経験からの事例研究も提示します。たとえば、HTTP/2 Pushでは、ウェブサーバーがクライアントの要求前にリソースのレスポンスを先取りして送信できます。

プッシュと優先順位付けは理論的にはエンドユーザーにとって有益ですが、使用するのが難しい場合があります。新しい技術について議論し、パフォーマンスが低いHTTP/2の機能の代替として使用できる可能性があります。たとえば、103 Early Hintsレスポンスは、先取りリソースフェッチの同じパフォーマンス目標を達成するHTTP/2サーバープッシュの代替手段を提供します。

最後に、HTTP/3がHTTP/2をどのように改善しているか、また2021年からのいくつかの増加を観察するHTTP/3の現在のサポートについて分析しながら議論します。この章で提供されるデータポイントが、将来のトレンドや新しい技術に関する洞察を提供し、開発者がユーザー体験を向上させるために実験できる新しい技術への指針となることを願っています。

## HTTPの進化

HTTPはウェブの通信を支えるもっとも重要なインターネットプロトコルの1つです。最初の3バージョン（0.9、1.0、1.1）ではテキストベースのプロトコルとして始まりました。その拡張性により、HTTP/1.1は2015年まで15年間現行のHTTPバージョンでした。

HTTP/2は、テキストベースのプロトコルからバイナリベースのものへと進化したHTTPの大きなマイルストーンでした。HTTP/1.1がシリアルなリクエストとレスポンスの交換のみをサポートするのに対し、HTTP/2は並行処理をサポートします。クライアントとサーバーは、リクエストとレスポンスをバイナリフレームのストリームとして表現します。ストリームには一意の識別子があり、フレームを多重化してインターリーブできます。

HTTPの最新バージョンはHTTP/3で、最近<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9114.html">2022年6月にIETFによって標準化されました</a>。HTTP/3はHTTP/2と同じ機能を実装していますが、インターネット上で輸送される方法が重要な違いです。HTTP/3はQUIC上に構築されており、QUICはUDPベースのプロトコルで、HTTP/2が損失の多いネットワークで直面するパフォーマンスの問題のいくつかを軽減します。

## HTTP/2の採用

年々導入されてきたさまざまなHTTPバージョンをふまえ、HTTPバージョンの採用状況の現状から説明します。2022年の __Web Almanac__ データセットのすべてのリソースを取り、それぞれのリソースがどのHTTPバージョンで提供されたかを特定することによって、HTTPバージョンの使用状況を測定します。

しかし、設定上、クライアントがHTTP/3サポートを発見する必要があり、通常は[`alt-svc` HTTPレスポンスヘッダー](https://developer.mozilla.org/docs/Web/HTTP/Headers/Alt-Svc)を介して行われるため、HTTP/3で提供されたリソースを正確にカウントすることは容易ではありません。クライアントが`alt-svc`ヘッダーを受け取る時点で、すでにHTTP/1.1またはHTTP/2のプロトコル交渉を完了しています。この時点の後に、クライアントは後続のリクエストやページの読み込みでプロトコルをHTTP/3にアップグレードできます。そのため、私たちのデータは完全なHTTP/3ページの読み込みを決して捉えることができません。

`alt-svc` HTTPヘッダー機構を介してHTTP/3の発見が遅れることにより、通常のブラウジングユーザーに対してHTTP/3で提供されたリソースが過少報告される可能性があります。したがって、HTTP/2とHTTP/3で提供されたリソースをHTTP/2+としてまとめています。

{{ figure_markup(
  image="http2-adoption-per-request.png",
  caption="リクエストにおけるHTTP/2以上の採用率。",
  description="HTTP/2以上の採用は非常に高く、2022年6月にはデスクトップとモバイルの設定でリクエストの77％がHTTP/2以上を使用して提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=109625269&format=interactive",
  sheets_gid="1707754058",
  sql_file="h2_adoption_pages_reqs.sql"
  )
}}

まず、現状を理解するために、HTTP/2+の普及率を測定します。2022年6月のデータでは、私たちのリクエストの約77％がHTTP/2+を使用していることが観察されました。これは、[2021年7月のHTTP/2+採用率から5％増加しています](../2021/http#リクエストによる採用)。当時、リクエストの73％がHTTP/2+でした。

{{ figure_markup(
  image="http2-adoption-per-site.png",
  caption="ウェブサイトにおけるHTTP/2以上の採用率。",
  description="2022年6月には、デスクトップとモバイルの設定で66％のウェブサイトがHTTP/2以上を使用して提供されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=328815423&format=interactive",
  sheets_gid="1707754058",
  sql_file="h2_adoption_pages_reqs.sql"
  )
}}

HTTP/2+の普及率の増加を理解するために、まず、ウェブサイトのランディングページがHTTP/2+で提供されているかどうかを確認することで、ウェブサイト単位でのHTTP/2+の採用を分析します。データセットの約66％のウェブサイトが、デスクトップとモバイルの設定でHTTP/2+で提供されていましたが、[2021年のデータセットでは約60％のウェブサイトがそうでした](../2021/http#HTTP/2の採用)。この増加は、ウェブサイトが最新のHTTPバージョンへ移行していることを示すポジティブな傾向です。

{{ figure_markup(
  image="http2-adoption-per-cdn.png",
  caption="CDNから提供されるリクエストにおけるHTTP/2以上の採用率。",
  description="デスクトップとモバイルの設定で、CDNから提供されたリクエストの95％がHTTP/2またはそれ以上を使用して提供されました。これは、CDNがHTTP/2採用の増加の主要な要因であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=1268139215&format=interactive",
  sheets_gid="427272739",
  sql_file="h2_adoption_by_cdn_pct.sql"
  )
}}

HTTP/2+の採用を促進する別の要因はCDNから提供されるリソースです。[2021年の分析](../2021/http#CDNによる採用)での観察と同様に、CDNから提供されたほとんどのリソースがHTTP/2+でした。上記の図は、CDNから提供されたリクエストの95％がHTTP/2+で提供されたことを示しています。

## HTTP/2とHTTP/3の利点

次に、HTTP/2が導入した機能がどのように採用されているかに焦点を当てます。主に、単一のネットワーク接続上での_多重化_リクエスト、リソースの_優先順位付け_、および_HTTP/2 Push_の3つの顕著な概念に焦点を当てます。

### 複数のリクエストを単一の接続で多重化

HTTP/2の重要な特徴の1つに、単一のTCP接続で複数のリクエストを多重化することがあります。これは、TCP接続上で同時に1つのリクエストしか許可されず、ほとんどの場合、ホスト名に対して6つの平行TCP接続のみが許可されるという、以前のHTTPバージョンの制限を大幅に改善します。HTTP/2では、リソース配信に使用される接続の論理表現であるストリームの概念が導入されました。それにより、複数のHTTP/2ストリームを単一のTCP接続に多重化でき、接続ごとの同時実行の制限を解除します。

単一のTCP接続にリクエストを多重化することの含意として、ページロード中に必要な接続数の削減があります。[2021年の私たちの調査結果](../2021/http#接続台数)と同様に、HTTP/2が有効なページでは、HTTP/2が有効でないページよりも接続数が少ないことが確認できます。

{{ figure_markup(
  image="connections-comparison-per-page.png",
  caption="HTTPバージョンごとのページ毎の使用される接続数。",
  description="HTTPバージョンとパーセンタイルごとのページ毎の接続数を示す棒グラフ。すべてのパーセンタイルでHTTP/2+ページは接続数が少なく10パーセンタイルではHTTP/1.1で6つ、HTTP/2+で4つ、25パーセンタイルでそれぞれ9つと7つ、50パーセンタイルで15対12、75パーセンタイルで23対20、90パーセンタイルで38対32です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=461867891&format=interactive",
  sheets_gid="901907129",
  sql_file="connections_per_page_load_dist.sql"
  )
}}

上の図は、HTTP/2が有効な場合、中央値のモバイルページがページロード中に12の接続を確立していることを示しています。これに対し、HTTP/2が有効でない中央値のページでは15の接続が確立され、追加で3つの接続が生じるというオーバーヘッドがあります。しかし、より高いパーセンタイルではオーバーヘッドはさらに悪化します。HTTP/2が有効な90パーセンタイルのページは32の接続があり、HTTP/2が有効でない90パーセンタイルのページは38の接続があり、6つの追加接続のオーバーヘッドがあります。これらの傾向は、デスクトップ版とモバイル版のウェブサイト間で同様です。

年を追うごとにHTTP/2の採用が増加していることを考えると、全体的にTCP接続数が徐々に減少していることは驚くべきことではありません。<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#tcp">HTTP Archiveからの縦断的な視点</a>によれば、確立された接続の中央値は2017年の22接続から2022年の13接続に9接続減少しました。

### リソース優先順位付け

HTTP/2では、クライアントは同じ接続上で複数のリクエストを[多重化](https://stackoverflow.com/questions/36517829/what-does-multiplexing-mean-in-http-2/36519379#36519379)できます。これにより、多数のリソースが同時に処理中の場合、レンダリングをブロックするリソースの配信に悪影響を及ぼす可能性があり、これがユーザー体験を損なうことがあります。[元の標準](https://www.rfc-editor.org/rfc/rfc7540#page-25)では、HTTP/2はこの問題に対処しようと、クライアントがページロード中に構築する優先度ツリーを提案し、ウェブサーバーがより重要なレスポンスの送信を優先するために使用できます。しかし、このアプローチは使用が難しく、多くのウェブサーバーやCDNは[正しく実装されていないか無視されました](https://github.com/andydavies/http2-prioritization-issues)。このため、HTTP/2の後の[反復](https://www.rfc-editor.org/rfc/rfc9113.html#section-5.3)では、異なる方式が使用されることが提案されました。

HTTP/2の優先順位付けの課題により、新しい優先順位付けスキームが必要とされました。[HTTPのための拡張可能な優先順位付けスキーム](https://httpwg.org/specs/rfc9218.html)はHTTP/3とは別に開発され、2022年6月に標準化されました。このスキームでは、クライアントは`priority` HTTPヘッダーや`PRIORITY_UPDATE`フレームを通じて、2つのパラメーターで明確に優先順位を割り当てることができます。最初のパラメーターである`urgency`は、要求されたリソースの優先度をサーバーに伝えます。2つ目のパラメーターである`incremental`は、リソースがクライアントで部分的に使用できるかどうかをサーバーに伝えます（たとえば、画像の一部が到着するにつれて部分的に表示される場合）。このスキームをHTTPヘッダーと`PRIORITY_UPDATE`フレームとして定義することで、両方の形式が将来の拡張性を提供するように設計されているため、拡張可能です。執筆時点で、このスキームはSafari、Firefox、ChromeでHTTP/3に対して展開されています。

リソースの優先順位のほとんどはブラウザ自身によって決定されますが、開発者は今では新しい[優先度ヒント](https://web.dev/articles/fetch-priority)を使用して特定のリソースの優先度を調整することもできます。優先度ヒントはHTMLの`fetchpriority`属性を通じて指定できます。たとえば、ウェブサイトがヒーローイメージを優先したい場合、画像タグに`fetchpriority`を追加できます。

```html
<img src="hero.png" fetchpriority="high">
```

優先度ヒントはユーザー体験を向上させるのに非常に効果的です。たとえば、[Etsyは実験を行い](https://www.etsy.com/codeascraft/priority-hints-what-your-browser-doesnt-know-yet)、特定の画像に優先度ヒントを含めた製品リスティングページでLargest Contentful Paint (LCP)が4%向上することを観察しました。

{{ figure_markup(
  caption="優先度ヒントを使用しているモバイルページ。",
  content="1.2%",
  classes="big-number",
  sheets_gid="1067615125",
  sql_file="priority_hints_usage.sql"
)
}}

優先度ヒントは2022年4月末にChrome 101の一部として最近リリースされましたが、2022年8月時点で約1%のデスクトップウェブページと1.2%のモバイルウェブページがすでに優先度ヒントを採用しているため、採用率が非常に有望です。比較的容易にユーザー体験を向上させる可能性があるため、実験には良い機能かもしれません。

### HTTP/2 Push

HTTP/2 Pushにより、ウェブサーバーはクライアントからリクエストが送信される前に、あらかじめレスポンスを送信できます。たとえば、ウェブサイト提供者はページロード中に使用されるリソースを主要なHTMLと共にエンドユーザーにプッシュできます。

{{ figure_markup(
  image="h2-push-usage.png",
  caption="HTTP/2 Pushの使用状況。",
  description="2021年7月と2022年6月のデスクトップとモバイルでのHTTP/2 Pushの使用状況を示す棒グラフ。デスクトップでは1.04%から0.71%に、モバイルでは1.26%のサイトから0.66%に減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=1440772038&format=interactive",
  sheets_gid="1278005075",
  sql_file="h2_h3_pushed.sql"
  )
}}

2021年の上記の図に示されているように、ウェブサイトでプッシュを使用している割合はモバイルで非常に低く、1.26%でした。しかし、今年の分析では、モバイルウェブサイトでプッシュを使用しているウェブサイトの数が0.66%に減少しています。これは2020年以降はじめてのプッシュ使用の減少を示しています。

プッシュを使用するウェブサイトの減少は、[効果的に使用するのが難しい](https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/)ためである可能性が高いです。たとえば、ウェブサイトはプッシュされたリソースがクライアントのキャッシュにすでに存在するかどうかを正確に知ることができません。それがクライアントのキャッシュにある場合、そのリソースをプッシュするために使用される帯域幅はムダになります。

この困難さにより、[ChromeはHTTP/2 Pushを非推奨](https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/ho4qP49oAwAJ)とすることを決定し、[Chromeバージョン106](https://developer.chrome.com/blog/removing-push/)から始まりました。プッシュは公式にはまだHTTP/3標準の一部ですが、HTTPアーカイブクローラーが使用するChromeはHTTP3接続に対してプッシュを実装しておらず、それが使用減少の一因となり、サイトがそのバージョンに移行しプッシュ機能を失ったと考えられます。

### HTTP/2 Pushの代替手段

HTTP/2 Pushの使用に伴う課題やChromeからの非推奨化を考慮すると、開発者は代替手段について考えるかもしれません。

#### プリロード

開発者は、ページロードの後半で使用されるリソースを事前にリクエストするための代替手段としてプリロードを使用できます。これは、HTMLの`<head>`セクションに[`<link rel="preload">`](https://developer.mozilla.org/docs/Web/HTML/Link_types/preload)を含めることで有効になります。たとえば。

```html
<link rel="preload" href="/css/style.css" as="style">
```

または、`Link` HTTPヘッダーとしても使用できます。

```
Link: </css/style.css>; rel="preload"; as="style"
```

どちらのオプションも、ウェブサーバーが追加のURLや重要なリソースを含めることを可能にします。クライアントは、ページロード中に通常発見される前に、提供されたURLに対してリクエストを発行できます。

リソースを積極的にプッシュするほど速くはありませんが、ブラウザがそれらのリソースをフェッチするかどうかを選択できるため、たとえばキャッシュにコピーがすでにある場合はそれをフェッチしないこともあり、より安全です。

{{ figure_markup(
  caption='`<link rel="preload">`を使用しているページ。',
  content="25%",
  classes="big-number",
  sheets_gid="2036031560",
  sql_file="sites_using_link_preload_header.sql"
)
}}

私たちのデータセットには、`<link rel="preload">`タグを含むページが大量にあり、デスクトップとモバイルの両方で約25%です。

#### 103 Early Hints

2017年に<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8297">103 Early Hintsステータスコードが提案され</a>、<a hreflang="en" href="https://developer.chrome.com/blog/early-hints">Chromeは今年それをサポートしました</a>。

Early Hintsは、要求されたオブジェクトの最終レスポンスの前に暫定的なHTTPレスポンスを送信するために使用できます。ウェブサーバーがレスポンスを準備するのに時間がかかること、とくに動的にレンダリングされるメインのHTMLドキュメントの場合、この事実を利用してパフォーマンスを向上させることができます。

Early Hintsの1つの使用例は、事前にフェッチするための`Link: rel="preload"`を送信することや、他のドメインに事前に接続するための`Link: rel="preconnect"`を送信することです。他のヘッダーも概念的に伝達できますが、これはどのブラウザでもサポートされていません。

Early Hintsはプッシュよりも優れた代替手段である可能性があります。クライアントはリソースの取得方法をより大きくコントロールできますが、メインドキュメントのHTMLにプリロードやプリコネクトを追加するだけの改善を許可します。さらに、Early Hintsはプッシュでは不可能だった第三者リソースにも使用できる可能性がありますが、<a hreflang="en" href="https://developer.chrome.com/blog/early-hints#current-limitations">これもまだどのブラウザでもサポートされていません</a>。

{{ figure_markup(
  caption="103 Early Hintsを使用しているデスクトップページ。",
  content="1.6%",
  classes="big-number",
  sheets_gid="187640264",
  sql_file="early_hints_usage.sql"
)
}}

Early Hintsの採用がユーザー体験を向上させることを示す研究があります。たとえば、<a hreflang="en" href="https://blog.cloudflare.com/early-hints-performance/">Shopifyはラボ研究でLCPが20-30%改善されたことを観察しました</a>。私たちのデータセットでは、初期段階にもかかわらず、約1.6%のウェブサイトがEarly Hintsを採用しており、そのほとんど（1.5%）はShopifyのプラットフォーム上で実行されているウェブサイトからのものです。

ページレスポンスに`<link rel="preload">`を含むウェブサイトが25%あるため、これらのリンクノードをEarly Hintsに変換する潜在的な可能性があります。

## HTTP/3

このセクションの残りでは、HTTPの未来であり、<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9114.html">2022年6月に標準化された</a>HTTP/3に焦点を当てます。とくに、HTTP/3がその前身よりもどのように改善されたか、そして現在どれだけのサポートがあるかを探ります。HTTP/3についての詳細な説明については、この章のレビューにも協力してくれた[Robin Marx](https://x.com/programmingart)が書いた<a hreflang="en" href="https://www.smashingmagazine.com/2021/08/http3-core-concepts-part1/">素晴らしい一連の投稿</a>を参照してください。

### HTTP/3の利点

HTTP/2はその前身に比べてさまざまな改善を導入しましたが、プロトコルにはさらなる課題と機会が残されています。たとえば、単一のTCP接続上でのリクエストの多重化は各リクエストのヘッド・オブ・ライン・ブロッキング問題を軽減しましたが、この方法でのリクエストの配信は[まだ非効率的である可能性があります](https://calendar.perfplanet.com/2020/head-of-line-blocking-in-quic-and-http-3-the-details/)。これは、失われたTCPパケットが、その再送信が到着するまで正しく受信された後続のTCPパケットの処理を阻止するためです。これは、後続のTCPパケットが別のHTTPストリーム用であっても、TCPはHTTPプロトコルの上層で行われている多重化を認識できないため、すべてのストリームを止めます。

HTTP/3はHTTP/2の短所を改善することを目指しており、それを実現するためにUDPベースのトランスポートプロトコルであるQUIC上に構築されています。QUICはUDP上でストリームごとの信頼性の高いパケット配信を実装することにより、TCPのヘッド・オブ・ライン・ブロッキングを解決します。

### HTTP/3のサポート

HTTP/3がサポートされていることを広告するために、ウェブサーバーはHTTPレスポンスヘッダーの`alt-svc`に依存しています。`alt-svc`ヘッダーの値には、サーバーがサポートするプロトコルのリストが含まれます。

{{ figure_markup(
  image="alt-svc-example.png",
  caption="`alt-svc`レスポンスヘッダーの例。",
  description="`alt-svc`レスポンスヘッダーがHTTP/3をサポートし、値`h3`、`h3-29`を持つスクリーンショット。",
  width=417,
  height=267
  )
}}

たとえば、2022年9月に<a hreflang="en" href="https://www.cloudflare.com">https://www.cloudflare.com</a>のレスポンスでの`alt-svc`値は、以下のスクリーンショットに示されるように、`h3=":443"; ma=86400, h3-29=":443"; ma=86400`です。`h3`と`h3-29`は、CloudflareがUDPポート443上でHTTP/3とHTTP/3のIETFドラフト29をサポートしていることを示しています。HTTP/3の発見をDNSルックアップの一部として高速化する提案もあります。詳細については<a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">このCloudflareの投稿</a>を参照してください。

HTTP/3の採用を分析するために、リソースがHTTP/3で提供されたか、そのレスポンスヘッダーに`alt-svc`ヘッダーが含まれていて、`h3`または`h3-29`が広告されたプロトコルの1つとして含まれているかを識別します。これにより、HTTP/3が使用可能であるかを理解し、クローラーがまだ`alt-svc`ヘッダーを見ていないという上記の制限を無視します。

{{ figure_markup(
  image="h3-support-per-request.png",
  caption="リクエストにおけるHTTP/3のサポート。",
  description="2021年7月と2022年6月のデスクトップとモバイルでのHTTP/3のサポートを示す棒グラフ。両方で10%から15%に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=971486939&format=interactive",
  sheets_gid="1456324569",
  sql_file="h3_support.sql"
  )
}}

上の図は、昨年のWeb Almanac以来、HTTP/3サポートがあるリクエストの割合が10%から15%に5ポイント増加したことを示しています。デスクトップとモバイルのリクエストで同様の増加が観察されました。

HTTP/2+の採用と同様に、HTTP/3のサポートのほとんどはCDNから発生しています。将来的にさらに多くのCDNがHTTP/3をサポートし始めると、サポートが増えると予想されます。

## 結論

今年はHTTPプロトコルにとって画期的な年であり、とくにHTTP/3が標準化されたことで注目されました。私たちはHTTP/2の高い利用率を継続して観察しており、ウェブサーバーからの強力な今後のHTTP/3サポートを見ています。

さらに、HTTP/2の重要な課題に対処する技術のエコシステムでの強い成長を見てきました。103 Early Hintsはサーバープッシュのより安全な代替手段を提供し、クライアントサポートはChromeが現在サポートしていることで大きく前進しました。新しいHTTP優先順位付けの標準が最終化され、主要なブラウザといくつかのウェブサーバーはすでにHTTP/3でそれをサポートしています。さらに、優先度ヒントがウェブプラットフォームに追加され、クライアントがHTTP/2およびHTTP/3の両方で優先順位をさらに洗練させることを可能にし、初期の実験は有望なユーザー体験の改善をもたらしました。

これからのHTTPプロトコルとウェブエコシステムにとって興奮する時期です。これらの新しい技術がどのように採用され、ユーザー体験にどのような影響を与えるかを見るのが楽しみです。
