---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: キャッシング
description: 2021 Web Almanacのキャッシングの章では、cache-control、expires、TTL、validity、various、set-cookies、サービスワーカー、opportunitiesをカバーしています。
hero_alt: Hero image of Web Almanac charactes and resources in parking slots in a car park with parking meters in from of them. The middle spot is labelled 304.
authors: [Zizzamia, jessnicolet]
reviewers: [WilhelmWillie, roryhewitt]
analysts: [rviscomi]
editors: [tunetheweb]
translators: [ksakae1216]
Zizzamia_bio: Leonardo は、<a hreflang="en" href="https://www.coinbase.com/">Coinbase</a> のソフトウェアエンジニアスタッフで、製品エンジニアが世界でもっとも高い品質のアプリケーションを大規模に出荷できるようにするためのイニシアチブをリードしています。彼は<a hreflang="en" href="https://ngrome.io">NGRome Conference</a>をキュレーションしている。また、レオは<a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a> ライブラリのメンテナンスも行っており、企業がパフォーマンス分析を通じてロードマップの優先順位付けやより良いビジネス決定を行えるよう支援しています。
jessnicolet_bio: Jessicaはオペラ歌手としてキャリアをスタートし、過去10年間はクラシック音楽業界に身を置いてきました。2020年初頭、パンデミックにより、彼女は技術、特にウェブ開発の分野で新しいキャリアをスタートさせることを決意しました。彼女はもともと、ステージ上でもオフでも、文章を書いたり物語を語ったりするのが好きで、この新しい分野に移行した体験を記録した<a hreflang="en" href="https://jessicanicolet.medium.com/">3つの記事のシリーズ</a>をMediumで発表しています。現在、テクニカルライティングの正社員を募集しています。
results: https://docs.google.com/spreadsheets/d/1-v3yR0LZIC3t4zWtqTgR3jJsKjjRMP-HATU2caP8e2c/
featured_quote: キャッシュヘッダーの採用は、数多くのキャッシュの選択肢の中から選択できるようになるにつれ、着実に増え続けています。ハイエンドデバイスだけでなく、ローエンドデバイスから製品にアクセスする次の10億人のユーザーに向けてもページを最適化する。
featured_stat_1: 99.8%
featured_stat_label_1: フォントをキャッシュするページ
featured_stat_2: 51兆年
featured_stat_label_2: 記録された最も大きな `max-age` の値
featured_stat_3: 59.1%
featured_stat_label_3: キャッシングで最大1MBを節約できるモバイルページ
---

## 序章

この20年間で、私たちがウェブアプリケーションを体験する方法は変化し、よりリッチでインタラクティブなコンテンツが提供されるようになりました。しかし、残念ながら、このようなコンテンツには、データストレージと帯域幅の両方においてコストがかかっています。ほとんどの場合、使用するネットワークが劣化していたり、デバイスに十分な容量がなかったりすると、多くの人がウェブ製品を完全に体験することが難しくなります。キャッシュは、このような問題の解決策であると同時に原因でもあります。数多くの選択肢を使いこなすことで、ハイエンドデバイスだけでなく、ローエンドデバイスから製品にアクセスする次の10億人のユーザーにも対応した構築が可能になります。

キャッシュは、JavaScript、CSSファイル、基本的な文字列値などの単純な静的アセットから、より複雑なJSON APIレスポンスまで、以前にダウンロードしたコンテンツの再利用を可能にする技術です。

その核心は、キャッシュによって特定のHTTPリクエストを回避し、アプリケーションがユーザーに対してより応答的で信頼性が高いと感じられるようにすることです。各リクエストは通常、主に2つの場所にキャッシュされます。
- **[コンテンツデリバリーネットワーク (CDNs)](./cdn)** は通常、サードパーティの会社で、ユーザーがアプリケーションにアクセスしている場所にできるだけ近い場所でデータを複製することを主な目的としています。ほとんどのCDNは、いくつかのデフォルトの動作を持っていますが、主にヘッダーを使用することによって、キャッシュの方法を指示できます。
- **ブラウザ**は、体験を最適化するためにあなたが定義したHTTPヘッダーを尊重するか、またはいくつかの内部デフォルトを適用します。その上、ブラウザは、単純な文字列を[_cookies_](https://developer.mozilla.org/docs/Web/HTTP/Cookies)に、複雑なAPI応答を[_IndexedDB_](https://developer.mozilla.org/docs/Web/API/IndexedDB_API)に、あるいはリソース全体を _サービスワーカー_ で _キャッシュストレージ_ に保存するなどの手動キャッシュ戦略を利用することも可能です。

この章では、ブラウザとCDNの間で使用されるHTTPヘッダーに主に焦点を当て、サービスワーカーのキャッシュ戦略についても簡単に触れます。

## CDNキャッシュの採用

コンテンツデリバリーネットワーク（CDN）は、通常、データのコピーを保存する複数の場所に分散したサーバーのグループです。これにより、サーバーはエンドユーザーへもっとも近いサーバーに基づいてリクエストを処理できます。

{{ figure_markup(
  image="top-cdns.png",
  caption="トップCDNの採用。",
  description="もっとも普及しているCDNのページ数の割合による採用率の棒グラフです。Cloudflareのモバイルとデスクトップでの採用率は14%、Google 7%、Fastly 2%、Amazon CloudFront 2%、Akamai 1%、Automattic 1%となっています。Sucuri Firewall、Incapsula、Netlifyを含む残りのCDNは、平均0％の採用率となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2035524639&format=interactive",
  height=501,
  sheets_gid="58739923",
  sql_file="top_cdns.sql"
) }}

2021年のウェブ全体では、Desktopに使用されているCDNはCloudflareがもっとも普及しており、総ページ数の14%、次いでGoogleが6%となっています。CloudflareとGoogleがもっとも普及していますが、この2つ以外にも、Fastly、Amazon CloudFront、Akamaiなど、多種多様なソリューションが残っています。

## サービス・ワーカー採用

<a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers">_サービスワーカー_</a>の採用が着実に増え続けています。

{{ figure_markup(
  image="sw-adoption.png",
  caption="サービスワーカーの採用。",
  description="サービスワーカーの採用率をサイトランキングとページ数の割合で棒グラフにしたもの。1,000位のサイトの採用率は9%、1万位のサイトは8%、10万位が5%、100万位では2%、残りのサイトは1%となっている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=688062455&format=interactive",
  sheets_gid="802609299",
  sql_file="service_worker_rank.sql"
) }}

サービスワーカーを登録しているページは1％強であるのに対し、アクセス数の多い上位1,000ドメインにランクインしているページの約9％がサービスワーカーを登録しています。

このように、とくに上位1,000ページにおいてサービスワーカーの採用率が高いのは、リモートファースト、そしてそれに関連してモバイルフレンドリーという世界的なトレンドと関係があるのかもしれません。1年を通じて1つの場所で仕事をしたり生活したりすることへの依存度がシフトするにつれて、私たちはデバイスが私たちについていくために、さらにハードでスマートな働きをすることを必要としているのです。サービスワーカーは、ユーザーが信頼性の低いネットワークやローエンドデバイスを使用している場合、パフォーマンスを向上させることができるツールです。

サービスワーカー内のリソースをキャッシュする主な方法は、[_キャッシュストレージAPI_](https://developer.mozilla.org/docs/Web/API/CacheStorage)を使用することです。これにより、開発者はワーカーを通過するすべてのリクエストに対して、カスタムキャッシュ戦略を作成できます。よく知られているものに、_stale-while-revalidate_、_ネットワークにフォールバックするキャッシュ_、_キャッシュにフォールバックするネットワーク_、_キャッシュのみ_があります。近年では、プラグアンドプレイでキャッシュを決定できる<a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-strategies">ワークボックス</a>の人気が高まっているおかげで、それらの戦略を採用するのがさらに容易になっています。

サービスワーカー、およびWorkboxについては、[PWA](./pwa)の章で詳しく説明します。

## キャッシュヘッダーの採用

CDNとブラウザの両方において、HTTPヘッダーは開発者がリソースを適切にキャッシュするために習得しなければならない主要なツールです。ヘッダーとは、HTTPリクエストやレスポンスから読み取られる単純な命令であり、それらのいくつかは、使用するキャッシュ戦略を制御するのに役立ちます。

キャッシュ関連ヘッダーは、それがあるかないかで、ブラウザやCDNに3つの重要な情報を伝えます。
- **Cacheability**: このコンテンツはキャッシュ可能か？
- **Freshness**: キャッシュ可能な場合、どのくらいの期間キャッシュできるのか？
- **Validation**: キャッシュ可能な場合、キャッシュされたバージョンがまだ新鮮であることを確認するにはどうすればよいか？

ヘッダーは単独、あるいは一緒に使うものです。コンテンツが**キャッシュ可能**で**新鮮**であるかどうかを判断するため。
- `Expires`は、明示的に有効期限を指定します（つまり、コンテンツの正確な有効期限を指定します）。
- `Cache-Control` はキャッシュ期間 (すなわち、コンテンツが生成されたときから相対的に、ブラウザにキャッシュできる期間）を指定します。

両方が指定された場合、`Cache-Control`が優先されます。

{{ figure_markup(
  image="cache-control-expires.png",
  caption="`Cache-Control` ヘッダーと `Expires` ヘッダーを設定したレスポンスの割合。",
  description="Cache-ControlヘッダーとExpiresヘッダーの使用率を示す棒グラフです。デスクトップとモバイルのリクエストの74.8%がCache-Controlを使用し、それぞれ55.5%と55.6%がExpiresを使用、54.8%と54.9%が両方を使用、そして24.6%と25.1%がどちらも使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=816405026&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

2019年以降、`Cache-Control`ヘッダーの使用率は着実に増加しています。モバイルリクエストのレスポンスの74.2%が `Cache-Control` ヘッダーを含み、デスクトップリクエストのレスポンスの74.8%がこのヘッダーを利用していました。

2020年以降、この特定のヘッダーの使用率は、モバイルで0.71%、デスクトップでは1.13%増加しました。しかし、モバイルではまだ25.1%のリクエストが `Cache-Control` と `Expires` ヘッダーのどちらも使用していません。このことから、コミュニティでは `Cache-Control` の適切な使用に関する認識が高まっていると思われますが、これらのヘッダーを完全に採用するにはまだ長い道のりがあります。

内容を**検証**するために、私たちは
- `Last-Modified` は、オブジェクトが最後に変更された日時を示します。この値は日付のタイムスタンプです。
- `ETag` (Entity Tag) は引用符で囲まれた文字列として、コンテンツに一意の識別子を与えます。これは、サーバーが選択した任意の形式を取ることができます。通常はファイルの内容のハッシュ値ですが、タイムスタンプや単純な文字列でもかまいません。

両方が指定された場合、`ETag`が優先される。

{{ figure_markup(
  image="last-modified-etag.png",
  caption="`Last-Modified` と `ETag` ヘッダーを設定したレスポンスのパーセンテージ。",
  description="`Last-Modified`と`ETag`ヘッダーの使用率を示す棒グラフです。デスクトップとモバイルで70.5%が `Last-Modified` を、46.5%が `ETag` を、41.6%が両方を、そして24.5%がどちらも使っていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1490687174&format=interactive",
  sheets_gid="2102749619",
  sql_file="header_trends.sql"
) }}

2020年と2021年を比較すると、`ETag`の利用が年々わずかに増え、`Last-Modified`の利用が1.5％減るという、過去繰り返された傾向にあることがわかります。来年注目すべきは、`ETag` や`Last-Modified`ヘッダーを使用しない回答が1.4%増加するという新しい傾向で、これはコミュニティがこれらのヘッダーの価値を理解していないことを示唆している可能性があるのです。

### `Cache-Control` ディレクティブ
`Cache-Control` ヘッダーを使用する場合、特定のキャッシュ機能を示す1つ以上の_ディレクティブ_定義された値を指定します。複数のディレクティブはカンマで区切られ、どのような順番でも設定できますが、中には互いに衝突するものもあります（たとえば、`public`と`private`など）。さらに、いくつかのディレクティブは `max-age` のような値をとります。

以下は、もっとも一般的な `Cache-Control` ディレクティブを示した表です。

<table>
  <tr>
    <th>ディレクティブ</th>
    <th>説明</th>
  </tr>
  <tr>
    <td><code class="no-wrap">max-age</code></td>
    <td>現在時刻を基準として、リソースのキャッシュが可能な秒数を示す。たとえば、<code>max-age=86400</code>などです。</td>
  </tr>
  <tr>
    <td><code class="no-wrap">public</code></td>
    <td>ブラウザや CDN を含む、任意のキャッシュが応答を保存できることを示します。これはデフォルトで想定されています。</td>
  </tr>
  <tr>
    <td><code class="no-wrap">no-cache</code></td>
    <td>キャッシュされたリソースは、たとえそれが古いとマークされていなくても、使用前に条件付きリクエストによって再検証されなければならない。</td>
  </tr>
  <tr>
    <td><code class="no-wrap">must-revalidate</code></td>
    <td>キャッシュされた古いエントリは、使用前に条件付きリクエストによって再検証されなければならない。</td>
  </tr>
  <tr>
    <td><code class="no-wrap">no-store</code></td>
    <td>レスポンスがキャッシュされてはならないことを示す。</td>
  </tr>
  <tr>
    <td><code class="no-wrap">private</code></td>
    <td>このレスポンスは特定のユーザーを対象としたものであり、CDNなどの共有キャッシュに保存されるべきものではありません。</td>
  </tr>
  <tr>
    <td><code class="no-wrap">immutable</code></td>
    <td>キャッシュされたエントリがその TTL の間、決して変更されず、再バリデーションが必要ないことを示す。</td>
  </tr>
</table>

{{ figure_markup(
  image="cache-control-directives.png",
  caption="`Cache-Control` ディレクティブの使用法。",
  description="12個の `Cache-Control` ディレクティブの分布を示す棒グラフです。デスクトップでの使用率は、 `max-age` が62.2%, `public` が29.7%, `no-cache` が16.5%, `must-revalidate` が12.2%, `no-store` が9.6%, `private` が9.5%、 `immutable`が3.5% 、 `no-transform`が1.8% 、 `stale-while-revalidate`が2.3%、 `s-maxage` 1.6%、 `proxy-revalidate` 0.9%、そして `stale-if-error` が0.2%であった。モバイルでの使用率は、 `max-age` が60.7%、 `public` が29.7%、 `no-cache` が15.6%、 `must-revalidate` が13.2%、 `no-store` が10.3%、 `private` が10.1%、 3.9%が `immutable` 、1.6%が `no-transform` 、2.4%が`stale-while-revalidate`、1.4%が `s-maxage`、1.0%が `proxy-revalidate`、0.2%が `stale-if-error` であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1359015817&format=interactive",
  height=436,
  sheets_gid="1944529311",
  sql_file="cache_control_directives.sql"
) }}

`max-age`ディレクティブはもっとも一般的で、62.2%のデスクトップ・リクエストがこのディレクティブを含む `Cache-Control` レスポンス・ヘッダーを含んでいます。

2020年との比較では、上図の上位7つの指令のほとんどとともに、デスクトップでは`max-age`の採用が2%増加しました。

`immutable` ディレクティブは比較的新しいもので、特定のタイプのリクエストのキャッシュ性を大幅に向上させることができます。しかし、まだ一部のブラウザでしかサポートされておらず、_Wix_が16.4%、_Facebook_ 8.6%、_Tawk_ 2.8%、_Shopify_ 2.4%といったホストネットワークから来るリクエストが、ほとんどであることが分かっています。

もっとも誤用されている `Cache-Control` ディレクティブは、引き続き `set-cookie` で、デスクトップでは _ディレクティブ_ 全体の0.07% で、モバイルでは0.08% で使用されています。しかし、2020年からは0.16%の使用量削減という意味でも喜ばしいことです。

`no-cache`、`max-age=0`、`no-store` が一緒に使われている場合を見てみると年々増加傾向にあり `no-store` が `no-cache` と `max-age=0` のいずれか/両方と一緒に指定されると、 `no-store` ディレクティブが優先され、他のディレクティブが、無視されることが分かってきています。これらのディレクティブの使用について、たとえば大規模なカンファレンスの際にもっと認識を高めることで、誤ってムダなバイトを使用することを避けることができるかもしれません。

{{ figure_markup(
  caption="`max-age`で記録されたもっとも大きな値。",
  content="51兆年",
  classes="medium-number",
  sheets_gid="529870849",
  sql_file="max_age_distribution.sql"
) }}

おもしろい事実：もっとも一般的な`max-age`の値は30日であり、もっとも大きな値は51兆年です。

### `304` Not Modified ステータス

サイズに関して言えば、`304 Not Modified` のレスポンスは `200 OK` のレスポンスよりもずっと小さいので、必要なサイズのデータのみを配信することでページのパフォーマンスを向上させることができるということになります。そこで、条件付きリクエストを正しく使用することが重要になります。再バリデーション、つまりデータの節約は、 `ETag` ヘッダーまたは `Last-Modified` ヘッダーのどちらかを使用することで行うことができます。

`Last-Modified` レスポンスヘッダーは `If-Modified-Since` リクエストヘッダーと一緒に動作し、リクエストされたファイルに何らかの変更がなされたかどうかをブラウザに知らせます。

{{ figure_markup(
  image="http-304-by-caching-strategy.png",
  caption="キャッシュ戦略別のHTTP 304応答率。",
  description="キャッシュ戦略別のHTTP 304応答率の棒グラフです。デスクトップでの使用率は、`If-Modified-Since`による期待値で18%、`If-Modified-Since`による実際値で94%、`ETag`による期待値で84%、`ETag`による実際値で88%となっています。モバイルでの使用率は、`If-Modified-Since`を含む期待値で13%、`If-Modified-Since`を含む実績で86%、`ETag`を含む期待値で91%、`ETag`を含む実績で88%であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1965033294&format=interactive",
  sheets_gid="1136058277",
  sql_file="valid_if_none_match_returns_304.sql"
) }}

2020年から2021年にかけて、`If-Modified-Since`の304レスポンスの分布が、7.7%増加したことがわかりました。これは、コミュニティがこれらのデータ節約を活用していることを示しています。

### 日付文字列の有効性

タイムスタンプを表すために使用される3つの主要なHTTPヘッダー、 `Date`、`Last-Modified`、`Expires` はすべて日付の書式を持つ文字列を使用します。HTTPレスポンスヘッダーの `Date` はほとんどの場合、ウェブサーバによって自動的に生成されるため、無効な値は非常に稀です。しかし、日付が正しく設定されていない場合、それが提供されるレスポンスのキャッシュに影響を与える可能性があります。

{{ figure_markup(
  image="invalid-date-formats.png",
  caption="日付の形式が無効な回答の割合。",
  description="無効な日付フォーマットを持つレスポンスヘッダーのパーセンテージをヘッダー別に表示した棒グラフです。デスクトップのレスポンスの割合は、`Expires`が2.8%、`Last-Modified` 0.7%、`Date` 0.1% です。モバイルのレスポンスの割合は、`Expires`が3.2％、`Last-Modified`が0.9％、`Date`が0.0％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=383751268&format=interactive",
  sheets_gid="1680471251",
  sql_file="invalid_last_modified_and_expires_and_date.sql"
) }}

2020年から2021年にかけて無効な`Date`を使用する割合は0.5%改善しましたが、`Last-Modified`と`Expires`については悪化しており、キャッシュ時の日付設定に関係が、あることがわかります。

このことから、日付ベースのヘッダーの自動化には、さらなる注意が、必要であることがわかる。

### `Vary`

リソースのキャッシュに不可欠なステップは、そのリソースが以前にキャッシュされていたかどうかを理解することです。ブラウザは通常、キャッシュキーとしてURLを使用します。同時に、同じURLに対するリクエストでも `Accept-Encoding` が異なるとレスポンスが異なるため、不正にキャッシュされる可能性があります。そのため、`Vary`ヘッダーを使用して、1つ以上のヘッダーの値をキャッシュキーに追加するようにブラウザに指示します。

{{ figure_markup(
  image="vary-directives.png",
  caption="`Vary` ディレクティブの使用法。",
  description="`Vary` ヘッダーの分布を示す棒グラフです。デスクトップのレスポンスの90.4%は `Accept-Encoding` を使用しています。残りの値はかなり少なく、 `User-Agent` は10.2%、 `Origin` 約10.5%、そして `Accept` 5.0%となっています。モバイルのレスポンスの90.3%は `Accept-Encoding` を使用しています。残りの値はかなり少なく、`User-Agent`が10.9%、`Origin` 約10.1%、`Accept` 4.8%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1279247484&format=interactive",
  height=436,
  sheets_gid="1033782866",
  sql_file="vary_directives.sql"
) }}

もっとも普及している `Vary` ヘッダーは `Accept-Encoding` で90.3% の使用率、次いで `User-Agent` で10.9% 、 `Origin` で10.1% 、そして `Accept` で4.8% の使用率です。

2020年から`Accept-Encoding`の使用率が1.5%減少していることがわかりました。

{{ figure_markup(
  caption="`Vary` ヘッダーを設定したモバイル用レスポンスのパーセンテージ。",
  content="46.3%",
  classes="big-number",
  sheets_gid="1033782866",
  sql_file="vary_directives.sql"
) }}

監査した総リクエストのうち、`Vary`ヘッダーを使用しているのは46.25%に過ぎませんが、2020年と比較すると、全体で2.85%増加していることを指摘することが重要です。

{{ figure_markup(
  caption="`Vary` ヘッダーを持つモバイルレスポンスのうち、`Cache-Control` も設定されているものの割合です。",
  content="83.4%",
  classes="big-number",
  sheets_gid="1033782866",
  sql_file="vary_directives.sql"
) }}

`Vary` ヘッダーを使用するリクエストのうち、83.4%は `Cache-control` も使用しています。これは、2020年から2.1%改善されたことを示しています。

## キャッシュ可能なレスポンスにCookieを設定する

2020年のキャッシュの章では、キャッシュ可能なレスポンスで `set-cookie` を使用することに注意するよう念を押しました。なぜなら、レスポンスのわずか4.9%が `private` ディレクティブを使用しており、ユーザーの個人データがCDN経由で誤って別のユーザーに提供される危険性があるためです。

{{ figure_markup(
  image="cacheable-set-cookie.png",
  caption="`Set-Cookie` を使用するキャッシュ可能なレスポンスのパーセンテージ。",
  description="デスクトップで35.6%、モバイルでは36.0%の回答がセットクッキーを使用しており、デスクトップで64.4%、モバイルでは64.0%がset-cookiesを使用していないことを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=261881101&format=interactive",
  sheets_gid="104392613",
  sql_file="set_cookie.sql"
) }}

2021年には、`set-cookie`とキャッシュの共存に関する認識が高まっていることがわかります。`set-cookie`でprivateディレクティブを使用しているウェブページはまだ5%しかありませんが、キャッシュ可能な `set-cookie` レスポンスの総数は4.41%減少しています。

## どのようなコンテンツをキャッシュしているのか？

{{ figure_markup(
  image="caching-by-resource-type.png",
  caption="リソースタイプ別にキャッシュ戦略を使用したリクエストのパーセンテージ。",
  description="キャッシュ可能なリソースの種類の分布を示す棒グラフ。デスクトップのレスポンスでは、フォントの99.8%、CSSの99.3%、オーディオの99.3%、ビデオの98.8%、スクリプトの95.3%、画像の91.3%、xmlの80.2%、htmlの72.6%、その他の種類の65.0%、およびテキストの29.8% がキャッシュ可能であることが示されています。モバイルのレスポンスでは、フォントの99.8%、CSSの99.1%、オーディオの99.0%、ビデオの98.8%、スクリプトの95.1%、イメージの89.9%、xmlの81.0%、htmlの76.6%、その他の種類の65.4%、そしてテキストの29.5%がキャッシュ可能です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=2036781114&format=interactive",
  height=436,
  sheets_gid="1202769738",
  sql_file="non_cacheable_by_resource_type.sql"
) }}

フォント、CSS、オーディオファイルは99%以上キャッシュ可能で、現在ほぼ100%のページでフォントがキャッシュされています。これは、静的なファイルであるため、キャッシュに適しているためと思われます。

しかし、もっともよく使われるリソースの中には、動的な性質のためか、キャッシュ不可能なものがあります。とくに、HTMLは23.4% ともっとも高い割合でキャッシュ不可能なリソースがあり、画像は10.1% でそれに続いています。

2020年と2021年のモバイルデータを比較すると、キャッシュ可能なHTMLが5.1%増加していることがわかります。これは、サーバーサイドレンダリングアプリケーションによって生成されたようなHTMLページをキャッシュするために、CDNをより良く利用する方向に進んでいる可能性を物語っています。ページは通常、特定のウェブページのコンテンツが頻繁に変更されない場合、SSRによって生成されます。このURLは、数週間あるいは数ヶ月間、同じHTMLを提供する可能性があり、そのコンテンツは高度にキャッシュ可能です。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">タイプ</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>テキスト</td>
        <td class="numeric">0.2</td>
        <td class="numeric">0.2</td>
      </tr>
      <tr>
        <td>XML</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>その他</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>動画</td>
        <td class="numeric">4</td>
        <td class="numeric">8</td>
      </tr>
      <tr>
        <td>HTML</td>
        <td class="numeric">3</td>
        <td class="numeric">14</td>
      </tr>
      <tr>
        <td>オーディオ</td>
        <td class="numeric">0.2</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>CSS</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>画像</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>スクリプト</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>フォント</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="TTLの中央値（単位：日）",
    sheets_gid="1792973510",
    sql_file="ttl_by_resource.sql"
  ) }}</figcaption>
</figure>

すべてのリソースタイプで_Time To Live_（TTL）の中央値を見てみると全体で同じような割合のキャッシュをしていても、モバイルでは、とくにHTML、オーディオ、ビデオでかなり長いキャッシュが、存在することがわかります。

{{ figure_markup(
  image="cacheable-responses.png",
  caption="キャッシュ可能なレスポンスとキャッシュ不可能なレスポンスの割合。",
  description="キャッシュ可能な回答の比率を示す棒グラフ。デスクトップで90.4%、モバイルでは89.7% の回答がキャッシュ可能です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=674929574&format=interactive",
  sheets_gid="812850996",
  sql_file="ttl.sql"
) }}

とはいえ、モバイル体験のための最適化を続けていても、キャッシュ可能なデスクトップリソースの潜在的な量は、モバイル用のリソースよりわずかに多いままであることは興味深いことです。

## キャッシュTTLとリソースエイジの比較は？

{{ figure_markup(
  image="first-party-resource-age-by-content-type.png",
  caption="コンテンツタイプ別のファーストパーティリソースエイジの分布（モバイルのみ）。",
  description="ファーストパーティコンテンツの年齢を0-52週、>1年、>2年に分けて、空白とマイナスの数字も含めて表示した棒グラフです。0は、とくにファーストパーティのHTML、xml、テキストに使用されています。0～52週が混在しており、2年以上がかなり使われています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=597168369&format=interactive",
  sheets_gid="856268091",
  sql_file="resource_age_party_and_type_wise_groups.sql"
) }}


{{ figure_markup(
  image="third-party-resource-age-by-content-type.png",
  caption="コンテンツタイプ別のサードパーティリソースエイジの分布（モバイルのみ）。",
  description="サードパーティコンテンツの年齢を0-52週、>1年、>2年に分け、空白とマイナスの数字も表示した棒グラフです。0は、とくにファーストパーティのCSS、その他、xmlに多く使われています。0〜52週が混在しており、2年以上使われているのは一部のみです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1206143849&format=interactive",
  sheets_gid="856268091",
  sql_file="resource_age_party_and_type_wise_groups.sql"
) }}

画像と動画は、ファースト・ソースでも、サード・パーティ・ソースでも、同じ平均年齢を維持していることがわかる。画像は一貫してリソース年齢が2年であるのに対し、動画のリソースはほとんどが8～52週であった。

他のコンテンツタイプに分けると、サードパーティーのフォントは、8～52週間の間にもっとも多くキャッシュされ、72.4%であることがわかりました。しかし、ファーストパーティーの場合、リソースの年齢層は8～52週と2年以上に均等に分かれており、かなり大きなばらつきがあります。オーディオとスクリプトについても同様の結果が出ており、ファーストパーティでは8～52週、サードパーティでは1～7週が大半を占めています。

オーディオは、ファーストパーティーとサードパーティーの両方で、もっとも高度にキャッシュされたリソースでした。しかし、リソース年齢は、ファーストパーティ（平均8～52週間）とサードパーティ（わずか1～7週間）で大きく異なっていました。ファーストパーティーのオーディオリソースは更新頻度が、低い傾向があるため（なぜ？）、サードパーティーは、より新鮮なリソースを提供することでキャッシュの機会を利用している可能性があります。

キャッシュされたファーストパーティーのCSSの最大グループ（32.2％）は8～52週間の傾向があり、サードパーティーの最大グループは1週間未満で、その期間にキャッシュされたリソースは51.8％でした。

もっとも、HTMLは1週間未満で42.7%、サードパーティは1～7週間で43.1%と、ファーストパーティのグループがもっとも多くサービスを提供しています。

このデータを検討した上での考察。
- ファーストパーティではHTML、サードパーティではCSSがもっとも新鮮なコンテンツです。
- ファースト、サードパーティともに、もっとも陳腐化したコンテンツは画像です。

このデータからファーストパーティは、JSやCSSファイルへのリンクを含むHTMLコンテンツの更新を優先し、ブラウザ拡張機能のようにCSSやスクリプトを主体とするサードパーティは、CSSを最新の状態に保つことを優先していることがわかります。ファーストパーティとサードパーティの違いを考えると、サードパーティにとってコンテンツの配信方法は実際のコンテンツよりも重要であり、そのためコンテンツの表示と最適化が、より重要であることが分かります。

コンテンツ年齢と比較してキャッシュTTLが短すぎるとされたモバイルリソースは、2020年以降に改善が見られました。このデータは、コミュニティが適切な相対キャッシュについて理解を深めていることを示唆するものであり、エキサイティングなものです。

{{ figure_markup(
  caption="54%のモバイルリソースはTTLより古い",
  content="54%",
  classes="big-number",
  sheets_gid="768623684",
  sql_file="content_age_older_than_ttl.sql"
) }}

キャッシュTTLが長すぎると、古くなったコンテンツが、提供される可能性がありますが、短すぎるとエンドユーザーにとって何のメリットもありません。キャッシュTTLとコンテンツエイジの関係は、2020年の60.2%から2021年には54.3%となり、この差は徐々に縮まってきています。コンテンツエイジ（ページのHTMLやCSSなどの改修頻度）に対する気配りができればできるほど、より正確にキャッシュの上限を設定することができるようになるのです。

開発者はキャッシュ期間をコンテンツ年齢により正確に設定できるようになってきており、その結果、より責任ある、つまりより効果的なキャッシュを実現できるようになっています。

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>ファーストパーティ</th>
        <th>サードパーティ</th>
        <th>全体</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">59.5%</td>
        <td class="numeric">46.2%</td>
        <td class="numeric">54.3%</td>
      </tr>
      <tr>
        <td>モバイル</td>
        <td class="numeric">60.1%</td>
        <td class="numeric">44.7%</td>
        <td class="numeric">54.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="短いTTLを持つリクエストの割合。",
    sheets_gid="1069912023",
    sql_file="content_age_older_than_ttl_by_party.sql"
  ) }}</figcaption>
</figure>

ファーストパーティプロバイダーとサードパーティプロバイダーに分けると、もっとも改善されたのはサードパーティで、13.2%の改善が見られました。世界中の企業が、開発者向けにキャッシュを最適化する製品を開発していることは、非常に心強いことです。開発者コミュニティのパフォーマンス向上に対する関心の高まりが、サードパーティによるキャッシュ戦略の最適化を促し、さらにはその動機付けになった可能性があります。

しかし、今後数年間、ファーストパーティがどのように効果的な改善をしていくかという課題は残されています。

## キャッシュの機会を特定する

{{ figure_markup(
  image="lighthouse-caching-ttl-scores.png",
  caption="LighthouseキャッシュのTTLスコアの分布。",
  description="モバイル向けウェブページの `uses-long-cache-ttl` に対するLighthouse監査スコアの分布を示す棒グラフです。スコアが0.10未満の回答が36.2%、スコア0.10～0.39 25.6%、スコア0.40～0.79 20.3%、スコア0.80～0.99 12.1%となっています。スコア1が4.4％、スコアなしが1.3％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1825783189&format=interactive",
  sheets_gid="2098771743",
  sql_file="cache_ttl_lighthouse_score.sql"
) }}

Lighthouseの_キャッシングTTL_スコアに基づき、100点満点でランクインしたページが2020年の3.3%から2021年には4.4%に増加するという改善が見られました。

このスコアは、ページがキャッシュポリシーの追加的な改善によって恩恵を受けることができるかどうかを反映しています。31% のページが50パーセンタイルのスコアを上回ったことは喜ばしいことですが、25パーセンタイル以下の52% のページには大きな改善の可能性があります。

このことから、Webページにはある程度のキャッシュ機能が備わっていても、そのポリシーの使い方が古く、自社製品の最新状態に最適化されていないと考えざるを得ません。

{{ figure_markup(
  image="lighthouse-caching-byte-savings.png",
  caption="キャッシュによる潜在的なバイト数削減の分布。",
  description="モバイルウェブページのLighthouseキャッシング監査による潜在的なバイト節約量の分布を示す棒グラフです。1MB未満が59.1%、1～2MB 19.8%、2～3MB 7.1%、3～4MB 3.9%となっており、4MB以上が8.7%となっています。4MB以上節約できたのは8.7%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSGgVDZ9RkFQLmk5C3_siIcH-8macUEZMobcC0o1z8frYj8NOkI_C2s_yE5ppMdxDAD5INjNsCBa3h1/pubchart?oid=1045307868&format=interactive",
  sheets_gid="469776025",
  sql_file="cache_wastedbytes_lighthouse.sql"
) }}

2020年から2021年にかけてのLighthouseの_wasted bytes_監査に基づくと、繰り返し閲覧される監査対象の全ページにおいて、ムダなバイトが3.28%改善されました。これは、1MBをムダにするページの割合を42.8%から39.5%に下げ、有料のインターネットデータプランを持つ海外のユーザーにとって、よりコストの低い製品を作るというコミュニティのかなりの傾向を示しています。

現在、監査されたページのうち、ムダなバイトが0である割合は1.34%とまだ比較的低いです。今後数年間は、コミュニティがウェブパフォーマンスの最適化に注力し続けるため、この割合が増加することを期待しています。

## 結論

故・偉大な<a hreflang="en" href="https://www.karlton.org/karlton/">Phil Karlton</a>は、「コンピューター サイエンスには難しいことが2つしかない」という有名な言葉を残しました。正直なところ、私はキャッシュがなぜそんなに難しいのか、いつも不思議に思っています。私の考えでは、キャッシュをうまく行うには、2つの重要な要素が必要です：シンプルに保つこと、そして潜在的なエッジケースをすべて理解することです。

残念ながらキャッシュを賢くしようとしすぎると、間違ったものをキャッシュしてしまったり、もっと悪いことに、過剰にキャッシュしてしまったりすることがあるのです。同じようなことですが、すべてのエッジケースを理解するには、広範な調査とテスト、そしてゆっくりとした漸進的な改良が必要です。それでも、古いブラウザがあなたをバスの下に投げ出さないことを願わなければなりません。しかし私たちがいまだに優れたキャッシュ戦略を追い求める理由は、ラウンドトリップリクエストの大幅な削減、サーバーの高い節約、ユーザーから求められるデータの削減、そして最終的にはより良いユーザー体験という、究極の報酬が非常に大きいからです。

どのような場合でも、キャッシュの最適な使用方法のプレイブックを用意するようにしてください。
- 開発サイクルの初期段階、および製品出荷後のキャッシュ作業を優先させる。
- 主要なエッジケースを再現するエンドツーエンドのテストを書く
- 定期的なサイト監査と、古くなったり欠落している可能性のあるキャッシュルールの更新

最終的には私たちが仲間を指導し、理解しやすい良いドキュメントを書くことによって知識を広めることができればキャッシングは、それほど複雑なものではなくなります。キャッシングは、一部の人だけがマスターすればいいというものではありません。私たちの目標は、会社全体の共通認識として定着させることです。なぜなら、最終的に私たちが本当に注力したいのは、ユーザーにとって簡単で摩擦のない体験を構築することだからです。
