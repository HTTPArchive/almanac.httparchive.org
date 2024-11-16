---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: 2021年版Web AlmanacのJamstackの章では、技術の採用状況、Jamstackで構築されたWebサイトのパフォーマンス、各種リソースの重み付けなどを取り上げています。
hero_alt: Hero image of the Web Almanac chracters using a large gas cylinder with script markings on the front to inflate a web page.
authors: [denar90]
reviewers: [Dawntraoz, thomkrupa, tunetheweb]
analysts: [denar90, tunetheweb, rviscomi]
editors: [tunetheweb, shantsis]
translators: [ksakae1216]
denar90_bio: Artem Denysov は、ソフトウェアエンジニア、オープンソースの貢献者、Mozillians のメンバー、講演者、そして執筆者です。Webperfとツールで、開発者とユーザーの生活をより快適にします。[Stackbit](https://stackbit.com) で、開発者が Jamstack ウェブサイトを簡単に構築できるようにするために働いています。[Twitter](https://x.com/denar90_) と <a hreflang="en" href="https://www.linkedin.com/in/denar90/">Linkedin</a> でご覧いただけます。
results: https://docs.google.com/spreadsheets/d/1anlgeaBH2Yui2kFWuRGxHU2QdMiCKOgDrn4WyXkt5ro/
featured_quote: Jamstackは、モダンなWebサイトを構築するための、若く、急成長しているテクノロジーです。これは、人々が言うことであり、数字で証明されています。
featured_stat_1: 1.1%
featured_stat_label_1: JamstackのWebサイトでの採用実績
featured_stat_2: 9.5%
featured_stat_label_2: JamstackサイトにおけるjQuery使用率の中央値
featured_stat_3: 1.7MB
featured_stat_label_3: Jamstackサイト間の資源ワイトの中央値
---

## 序章

<figure>
  <blockquote>Jamstackは、よりシンプルな開発者体験、より優れたパフォーマンス、より低いコスト、より高いスケーラビリティを提供することで、Web構築に関する考え方に革命を起こしました。</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://jamstack.wtf/">Jamstack.wtf</a></cite></figcaption>
</figure>

Jamstackは、[JavaScript](./javascript)、API、[Markup](./markup)アーキテクチャに基づいています。この3つの基盤は分離されており、Jamstackのサイトは純粋にマークアップを使って構築できます。純粋なHTMLを使うのも「ある意味」Jamstackですが、スケールさせるのは本当に難しいです。幸いなことに、静的サイトジェネレーター（SSG）の巨大なエコシステムが存在します。

JavaScriptベースのSSG。
* Next.js
* Gatsby
* Nuxt.js
* その他

伝統的なもの。
* Eleventy
* Hugo
* Jekyll
* Hexo
* その他

そして、<a hreflang="en" href="https://jamstack.org/generators/">これら以外にも多くのSSGがあります</a>。必要に応じて、純粋なHTMLとJavaScriptの良さに変換したサイトを構築できます。

より複雑なサイトでは、データを構造化する必要があります。<a hreflang="en" href="https://jamstack.org/headless-cms/">ヘッドレスCMS</a>を使って、API経由でデータを保存・管理する方法がいくつかあります。

さらに、Jamstackのサイトでは、フォーム送信やユーザー入力処理などのサーバーインタラクションをサポートする必要があります。Netlifyのようなサービスは、このニーズに応えるため<a hreflang="en" href="https://www.netlify.com/products/functions/">サーバーレス機能</a>をサポートしています。

この章の目的は、Jamstackで使用されている主なSSGが何であるかを特定し、Jamstack技術の採用状況を年ごとに見ていくことです。世界中にどのように分布しているのか、Jamstackサイトのパフォーマンスレベル、そしてどのように成長しているのかを調べました。また、JamstackサイトのさまざまなCDNプロバイダーのデータも調査しました。さらに、Jamstackサイトで使用されているリソースの結果と、それがユーザー体験に与える影響についても調査しました。

この章を読むにあたって、いくつかのデータの免責事項について触れておきます。
1. 検出されたSSGのHTTP Archiveデータは、Wappalyzerの技術に基づいており、いくつかの制約があります。Eleventyなどの特定のSSGで構築されたサイトかどうかを検出することはできません。また、Next.jsの<a hreflang="en" href="https://nextjs.org/docs/basic-features/pages#static-generation-recommended">静的レンダリング</a>と<a hreflang="en" href="https://nextjs.org/docs/basic-features/pages#server-side-rendering">サーバーサイドレンダリング</a>で生成したサイトかどうかを判別することができません。
2. 今回の分析では、ヘッドレスCMSに関連する情報は得られなかったので、こちらも取り上げないことにします。
3. SSGを使用して構築されたサイト数の上位5つのSSGを使用して、SSGデータを可視化しています。

詳細は、[方法論](./methodology)に記載されています。

## SSGの採用

SSGの採用は、一般的に前年比2倍で伸びています。2019年はモバイルサイト0.4%、デスクトップサイト0.3%にとどまりました。2020年にはモバイルで0.6％、デスクトップサイトで0.7％とほぼ倍増しました。2021年にはモバイルの1.1％、デスクトップサイトの0.9％と再び成長しています。その技術の傾向を裏付けている。たとえば、今年<a hreflang="en" href="https://vercel.com/blog/series-c-102m-continue-building-the-next-web">VercelはシリーズCラウンドで1億200万ドルを調達し</a>、さらに<a hreflang="en" href="https://vercel.com/blog/vercel-funding-series-d-and-valuation">ラウンドDで1億5000万ドル</a>を投資して、Next.jsなどの最新技術でよりよいWebを構築しています。Jamstack指向のCDNプロバイダー<a hreflang="en" href="https://www.netlify.com/press/netlify-raises-usd105-million-to-transform-development-for-the-modern-web">Netlifyが、シリーズD</a>で1億500万ドルの投資を行いました。したがって、来年はJamstackの採用数が、さらに増加することが予想されます。

{{ figure_markup(
  image="year-over-year-adoption.png",
  caption="SSG採用の前年比。",
  description="棒グラフはSSGの普及率を前年比で表したものです。デスクトップの利用率は、2019年0.3％、2020年0.7％、2021年0.9％と増加しています。モバイルの導入も同様に、0.4％→0.6％→1.1％と増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1588757197&format=interactive",
  sheets_gid="874607830",
  sql_file="ssg_compared_to_2020.sql"
) }}

2020年はデスクトップが2.76倍、モバイルは1.5倍にとどまりました。2021年、SSGが構築したサイトのモバイル可用性は2020年よりもずっと良くなり、今年は2020年の1.9倍になっています。

## もっとも普及しているSSGはどれか

{{ figure_markup(
  image="adoption-share.png",
  caption="SSGの採用シェア。",
  description="円グラフはSSG間の採用シェアを表しています。Next.jsはJamstackサイトの43.6%を占めています。2位はNuxt.jsで31.1％、3位はGatsbyで16.0％、4位はHugoで6.0％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=2020451260&format=interactive",
  sheets_gid="1005292860",
  sql_file="adoption.sql"
) }}

まずは、もっとも普及しているSSGを把握することからはじめましょう。Next.jsはJamstackサイトの43.6%をカバーしています。2位はNuxt.jsで31.1％、3位はGatsbyで16.0％、4位はHugoで6.0％となっています。

<p class="note">なお、本章の初出時においては、NuxtとNextのサイト数が誤って多く計上されていたため、数値が異なっています。本章の他の数値も含め、上記の数値は修正されています。</p>

上位3つのSSGは、すべてJavaScriptベースです。Next.jsとGatsbyは、<a hreflang="en" href="https://reactjs.org/">React.js</a>をコアとして、その上に独自の機能を追加することで補完しています。Nuxt.jsは、<a hreflang="en" href="https://vuejs.org">Vue.js</a>をベースにしています。これらの人気のあるフロントエンドフレームワークは、巨大なエコシステムを備えているため、開発が非常に容易になります。<a hreflang="en" href="https://nodejs.org/en/">Node.js</a> は、従来使われているブラウザだけでなく、サーバ上でもJavaScriptを実行できるようにし、開発者が1つの言語に固執することを可能にしています。そのため、<a hreflang="en" href="https://go.dev/">プログラミング言語Go</a>をベースにしたHugoや、<a hreflang="en" href="https://go.dev/">Ruby</a>ベースのJekyllと比べて、サーバの観点からもこれらのSSGの採用が容易になるのだそうです。

今回は、WebサイトにおけるSSGの採用率について見ていきます。

### ランク別採用状況

{{ figure_markup(
  image="rank-adoption.png",
  caption="SSGのランク別採用シェア。",
  description="棒グラフは、ランク付けされたサイト間のSSGの採用シェアを表しています。人気サイトのデータを探ると、Next.jsが大きな成果を上げています。上位1,000サイトのうち3.83%がNext.js（同カテゴリーの全SSGサイトの70%）を占めています。他のランクではNext.jsのシェアが縮小し、Nuxt.jsとGatsbyがランクアップしており、この数値は程度の差はありますが、Nuxt.jsのシェアが伸びています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1137882647&format=interactive",
  sheets_gid="1005292860",
  sql_file="adoption.sql"
) }}

Next.jsは、すべてのランクで依然として人気のあるSSGですが、とくに上位10k位までのSSGに人気があります。

## 地域別採用状況

このセクションでは、Jamstackの地理的な採用を取り上げ、国や地域ごとの分布を探ります。

### 国別採用状況

SSGは世界中で盛んに利用されています。下図は、サイト数のもっとも多い上位10カ国を示したものです。

{{ figure_markup(
  image="ssg-adoption-by-country.png",
  caption="国別のSSG採用状況。",
  description="棒グラフは、国別のSSGの導入状況を表しています。アメリカはデスクトップ1.4%、モバイル1.2%、インドで2.4%、1.7%、イギリスが2.1%、1.7%、ブラジルでは1.6%、1.4%、ドイツが2.2%、1.3%、フランスで1.9%、1.5%、ロシアでは1.7％と1.3％、カナダは2.1％と1.9％、日本は1.5％と0.8％、最後にインドネシアが2.7％と1.7％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=778184046&format=interactive",
  sheets_gid="1956913376",
  sql_file="adoption_by_geo.sql",
  width=600,
  height=540
) }}

米国では、全サイトの1.2～1.4%のページ（デスクトップ用で約22kページ、モバイル用で約16kページ）がSSGで作成されています。インドはデスクトップ用で6kページ、モバイル用で7kページと少ないが、全ページの1.7%がJamstackの技術でカバーされている。3位はイギリスで、こちらも1.7%のページがある。

{{ figure_markup(
  image="ssg-distribution-by-country.png",
  caption="国別のSSG分布。",
  description="棒グラフは国別のSSGの分布を示しています。ほとんどの国で、Next.jsはNuxt.jsやGatsbyよりも高い普及率を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=533375815&format=interactive",
  sheets_gid="1956913376",
  sql_file="adoption_by_geo.sql"
) }}

アメリカはNuxt.jsやGatsbyに比べ、Next.jsの採用が多い。ほぼすべての国で同じような傾向です。ほとんどの国で、Next.jsは好ましい選択です。興味深いことに、GatsbyはJamstackの技術を使用している上位10カ国のうち3カ国のデータがありませんが、そのうちの2カ国は日本とロシア連邦でNuxt.jsがより好まれているようです。

### 地域別採用状況

また、地域別の普及率も調べました。

{{ figure_markup(
  image="ssg-adoption-by-region.png",
  caption="SSGの地域別分布。",
  description="棒グラフは、地域別のSSGの分布。地域別では、ヨーロッパ1.1%、アメリカ1.2%、アジア1.45%、オセアニア2.19%、アフリカ2%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=805975078&format=interactive",
  sheets_gid="1779595527",
  sql_file="adoption_by_region.sql"
) }}

欧州のサイト数は、デスクトップが2万3千サイト、モバイルが2万6千サイトで、同地域の全ウェブサイトの1.1%にあたる。アメリカ大陸では、デスクトップが2万6千サイト、モバイルが2万4千サイト（全体の1.2％）です。アジアはデスクトップが2万1000件、モバイルが2万2000件とほぼ同数で、Jamstackの導入率が高い地域のトップで1.45%。オセアニアとアフリカは、全体の数は少ないが、Jamstackの採用率は高い。オセアニアは2.19%、アフリカでは2%です。サイト全体の導入率は1.1%です。

### サブリージョン別採用状況

さらに小地域別に分類して、さらなる傾向を観察できます。

{{ figure_markup(
  image="ssg-adoption-by-subregion.png",
  caption="サブリージョン別のSSG分布。",
  description="棒グラフは、サブリージョン別のSSGの分布。中央値は全サブリージョンで1.1%前後です。サイト数の少ないサブリージョンでは、ミクロネシアの4.8%のように、さらに広い範囲で採用されている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=4263440&format=interactive",
  sheets_gid="72886421",
  sql_file="adoption_by_subregion.sql",
  width=600,
  height=794
) }}

このリストはSSGサイトの総数で並べられ、その地域の全サイトに対する割合で表示されます。SSGを開発した企業の多くがアメリカにあるため、北アメリカがトップであることは驚くことでありません。しかし、全サイトに占める割合は低く、Jamstackを採用したサイトはわずか1.1%です。しかし驚くべきことに、西ヨーロッパは2位で、リストの下位にあるいくつかのサブ地域と比較して、同様の低い割合の採用となっています。

尾部も素晴らしい結果を示している。たとえば、ミクロネシアでは4.8%というように、サイト数の少ないサブリージョンほど、より広い範囲で技術を導入している。

## CDNプロバイダー間でのSSGの配布

国によってSSGがどのように採用されているかを説明しましたが、ここではCDNプロバイダーによってどのSSGがもっとも普及しているかを分析してみましょう。

SSGでもっとも普及しているCDNプロバイダーは7社です。

* Netlify
* Vercel
* Cloudflare
* AWS
* Azure
* Akamai
* GitHub

Jamstack CDNサービスは、単なるネットワーク配信のためのものではありません。開発者がJamstackサイトを簡単にデプロイし、管理できるようにするための多くの機能を提供している。たとえばNetlifyは、開発者がコードを更新するだけで、継続的なデプロイプロセスが管理されるように、サービスの範囲内でサイトをデプロイする機能を簡単に使用できるよう提供している。<a hreflang="en" href="https://bejamas.io/compare/netlify-vs-vercel/">Jamstack CDNは、_サーバレス機能_、_A/Bテスト_など、他にも多くの機能</a>を提供します。

一方、Cloudflare、Akamai、AWSは純粋にコンテンツを配信するためだけに使われているわけではなく、保護サービスやDNSバランシングなども提供することができる。しかし、Cloudflare、Akamai、AWSがどのように利用されているかは検知できないため、Jamstackのイネーブラーとして見た場合、結果は誤検出となる可能性があります。「Jamstack」の部分はオリジンサーバーで処理されるため、実際にはこれらのサービスでは処理されない可能性があります。

{{ figure_markup(
  image="ssg-distribution-over-cdn.png",
  caption="CDNを利用したSSG配信。",
  description="棒グラフは、CDN上のSSGの分布を示しています。Next.jsは、Cloudflare、AWS、Vercelがほぼ均等に利用され、Netlify、Akamaiは少なく、GitHub、Azureはほとんど利用されていません。GatsbyはNetlifyが中心で、以下AWS、Cloudflareと続き、その他はほとんど使われていない。Nuxt.jsは主にCloudflare、次にAWS、そしてNetlifyで、残りはほとんど使われていません。HugoはNetlifyでの利用が多く、Jekyllも同様にほとんどGitHubでの利用が少ないようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1366870673&format=interactive",
  sheets_gid="1565107748",
  sql_file="core_web_vitals_distribution.sql"
) }}

Next.js、がもっとも普及しており、そのほとんどがCloudflare、Vercel、AWSで提供されています。Gatsbyのサイトのほとんどは、Netlify、AWS、Cloudflareを使用しています。Nuxt.jsのサイトは、Cloudflare、AWS、Netlifyによるサービスを好んで利用しています。HugoはほとんどNetlifyを使用しており、JekyllはGitHubで主に使用されていることは驚くことでありません。

次のグラフでは、人気のあるCDNについて、利用されるCDNの相対的な割合を示しています。

{{ figure_markup(
  image="ssg-distribution-over-cdn-stacked.png",
  caption="CDNを利用したSSG配信。",
  description="CDN上のSSGの分布を棒グラフで表したものです。Next.jsは、Cloudflare、AWS、Vercelでほぼ均等に利用されており、NetlifyとAkamaiでは利用が少なく、GitHubとAzureではほぼ利用がありません。GatsbyはNetlifyが中心で、以下AWS、Cloudflareと続き、その他はほとんど使われていない。Nuxt.jsは主にCloudflare、次にAWS、そしてNetlifyで、残りはほとんど使われていません。Hugoは主にNetlifyで、JekyllはほぼすべてGitHubで利用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=180251589&format=interactive",
  sheets_gid="1565107748",
  sql_file="core_web_vitals_distribution.sql"
) }}

Next.jsは、そのほとんどがVercel（Next.jsを開発した会社）によって提供されています。NetlifyやVercelのようなJamstackに特化したサービスとは対照的に、AWSのような一般的なCDNはJamstackサイトに大きな割合でサービスを提供していないことがわかる。

GitHubをCDNプロバイダーとするのは珍しいかもしれませんが、<a hreflang="en" href="https://pages.github.com/">_GitHubページ_</a> により、ユーザーはJekyll SSGで構築したgithub.ioサブドメインにサイトをデプロイすることができるようになります。

## ユーザー体験とパフォーマンス

今回の分析では、Jamstackの技術を採用した1.1%のサイトがどのようなユーザー体験をしているのかを探りました。Lighthouseとコアウェブ・バイタルの結果に注目しました。

### Lighthouse

Lighthouseのスコアは、すべて弊社クロールによる模擬テストデータです。そのため、モバイルデータプロバイダーや実際に使用するデバイスによって、実際の結果が影響を受ける可能性があります。

#### パフォーマンススコア

{{ figure_markup(
  image="median-lighthouse-performance-score.png",
  caption="Lighthouseのパフォーマンススコアの中央値。",
  description="棒グラフはLighthouseのパフォーマンススコアの中央値を表しています。Next.jsは27、Nuxt.jsは24、Gatsbyは37、Hugoは59、Jekyllは69です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1829586779&format=interactive",
  sheets_gid="745310638",
  sql_file="median_lighthouse_score.sql",
  width=600,
  height=559
) }}

モバイルの全SSGのパフォーマンススコアの中央値はさまざまです。人気上位3つのSSGは、40点を超えることができません。ランキング上位のサイトで使用されていること、ユーザーが世界中に分散していることから、さまざまなデバイスやネットワークで使用されていることが推測されます。<a hreflang="en" href="https://nextjs.org/docs/basic-features/image-optimization">Next.js画像コンポーネント</a> のように、すぐに使える改善でパフォーマンスを向上させることが期待できます。

とくにJekyllは70点近くを獲得しており、SSGエリアのマストドンとしては素晴らしい結果だと思います。<a hreflang="ja" href="https://web.dev/i18n/ja/lighthouse-performance/">Lighthouseパフォーマンス監査</a>の詳細については、このスコアに含まれる指標を正確に理解するためにご覧ください。

#### アクセシビリティスコア

Lighthouseでは、アクセシビリティを測定するための<a hreflang="ja" href="https://web.dev/i18n/ja/lighthouse-accessibility/">監査</a>も行っており、こちらの方が良い結果を出しているようです。

{{ figure_markup(
  image="median-lighthouse-accessibility-score.png",
  caption="Lighthouseのアクセシビリティスコアの中央値。",
  description="棒グラフはLighthouseのアクセシビリティスコアの中央値を表しています。Next.jsは85、Nuxt.jsは82、Gatsbyは89、Hugoは85、Jekyllは89です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1270511864&format=interactive",
  sheets_gid="745310638",
  sql_file="median_lighthouse_score.sql",
  width=600,
  height=559
) }}

自動化されたアクセシビリティ・チェックでチェックできる内容には限界がありますが、それでもこれは好ましい兆候です。このテーマについては、[アクセシビリティ](./accessibility)の章をお読みください。

#### SEOスコア

{{ figure_markup(
  image="median-lighthouse-seo-score.png",
  caption="LighthouseのSEOスコアの中央値。",
  description="棒グラフはLighthouseのSEOスコアの中央値を表しています。Jamstackの全サイトのSEOスコアは、Hugoのスコアが90とやや低いものの、ほとんどのサイトが92と高得点を獲得しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=813819935&format=interactive",
  sheets_gid="745310638",
  sql_file="median_lighthouse_score.sql",
  width=600,
  height=559
) }}

同様に、Jamstackのサイトはすべて90から92の素晴らしいSEOスコアを提供しています。静的なコンテンツを使用することは、常にデフォルトでSEOフレンドリーな技術でした。さらに、SSGは検索エンジンのためにサイトを最適化するための追加機能を備えています。

つまりLighthouseの結果は全般的に良好ですが、SSGのメインターゲットはパフォーマンスとPWAであり、これらのカテゴリでは開発者の体験を改善するための作業が必要で、その結果、サイトのパフォーマンスが改善されるということです。

## コアウェブ・バイタル

<a hreflang="ja" href="https://web.dev/i18n/ja/learn-web-vitals/">コアウェブ・バイタル</a> (CWV) は、ウェブ上で優れたユーザー体験を提供するために不可欠な品質シグナルの統一ガイダンスを提供するためのイニシアチブです。CWV自体は、3つのパフォーマンス指標を使用しています。

- 最大のコンテントフルペイント (LCP) - ページのメインコンテンツと推定される部分のロードタイムを計測します。
- 最初の入力までの遅延 (FID) - 相互作用の遅延を測定するものです。
- 累積レイアウトシフト (CLS) - ページが読み込まれ、ユーザーがコンテンツを読むときにコンテンツが移動しないように、視覚的な安定性を測定するものです。

私たちは、これらの値の実際のユーザーデータを集めている_Chrome UX体験レポート_（CrUX）を使用したので、Lighthouseが提供するラボベースのパフォーマンス指標よりも、実際のユーザー体験をよりよく測定することができるのです。

SSGのデータを分析しましたが、これはSSGがどのように配信されているかも反映しています。上記で見たように、いくつかのサイトは異なるCDNで多かれ少なかれ使用されており、そのためパフォーマンスに良い（または悪い！）影響を与える可能性があるので、そのデータも見ています。

SSGの総合評価では、Jamstackサイトの基本的なパフォーマンス レベルを理解できます。CWV評価には、すべてのメトリクスでCWVの良いスコアを持つページロードの75％パーセンタイルのデータが含まれています。

{{ figure_markup(
  image="cwv-compliance.png",
  caption="実ユーザーによるコアウェブバイタルへの対応。",
  description="棒グラフは、実ユーザーのCore Web Vitalsへの準拠状況を表しています。Next.jsはデスクトップで28.6%、モバイルでは15.8%、Gatsby 37.4%、21.6%、Nuxt.js 22.3%、11.1%、Hugo 52.1%、32.6%、最後にJekyllは57.8%、33.6%がCore Web Vitalをパスしているオリジンがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=93861885&format=interactive",
  sheets_gid="1340534640",
  sql_file="core_web_vitals_passing.sql"
) }}

モバイルでの結果を見ると、JekyllとHugoは全サイトの34.3%と31.8%が良いスコアを獲得し、SSGを上回る結果となりました。Gatsbyは21.9%で3位ですが、JavaScriptベースのSSGの中では1番です。Next.js 13.6%、Nuxt.js 11.0%と、パフォーマンスの良いページが、多いのが特徴です。

### 最大のコンテントフルペイント

<a hreflang="en" href="https://web.dev/articles/lcp">最大のコンテントフルペイント</a>(LCP) メトリクスは、ページの読み込みを最初に開始したときからの相対時間で、ビューポート内で表示される最大の画像またはテキスト ブロックのレンダリング時間を報告します。

{{ figure_markup(
  image="cwv-lcp.png",
  caption="実ユーザーによるコアウェブバイタルLCP。",
  description="棒グラフは、上位5つのメジャーSSGの実ユーザーコアウェブバイタルLCPを表しています。Next.jsはデスクトップ49%、モバイル25.8%、Nuxt.js 44%、21.7%、Gatsby 61%、41.2%、Hugo 89%、70.3%、そして最後にJekyll 91%、76.4%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=950243115&format=interactive",
  sheets_gid="1340534640",
  sql_file="core_web_vitals_passing.sql"
) }}

上では、同じ結果が良好なLCP体験を持つサイトの割合で承認されていることがわかります。もっとも良い結果はJekyllとHugoで、モバイルサイトの76.4%と70.3%が2.5秒以下の「良い」LCPを獲得しています。JavaScriptベースのSSG（Gatsby、Next.js、Nuxt.js）は、より悪い結果となっています。

{{ figure_markup(
  image="LCP-distribution-CDN.png",
  caption="CDN向けLCP配信。",
  description="Stacked Bar chartは、CDNのLCP分布を表しています。Cloudflareはデスクトップ44.3%、モバイル23.6%、AWS 51.8%、31.5%、Netlify 65.0%、45.3%、Vercel 60.9%、39.7%、GitHub 90.5%、82.5%、 Akamai 36.4%、22.0%, Azure 58.0%、36.7%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1326237133&format=interactive",
  sheets_gid="1024061881",
  sql_file="core_web_vitals_distribution.sql"
) }}

GitHubはCDNレベルで測定した場合、トップとなり、おそらくここでホストされているサイトがよりシンプルであることを反映している。次に、Jamstack向けのCDNであるNetlifyが66.8%のサイトでLCPが良好であり、Vercelが63.4%、AWSで59.2%、Cloudflareは54.2%で続いています。

### 最初の入力までの遅延

<a hreflang="ja" href="https://web.dev/i18n/ja/fid/">最初の入力までの遅延</a> (FID) はユーザーがページと最初に対話したとき（すなわち、リンクをクリックしたとき、ボタンをタップしたとき、またはJavaScriptを使用したカスタムコントロールを使用したとき）から、その対話に対応してブラウザがイベント ハンドラーの処理を実際に開始できるまでの時間を測ります。

{{ figure_markup(
  image="cwv-fid.png",
  caption="リアルユーザーのコアウェブバイタルFID。",
  description="棒グラフは、上位5つのメジャーSSGの実ユーザーによるコアウェブ・バイタルFIDを表しています。Next.jsはデスクトップ99.6%、モバイル88.6%、Nuxt.js 99.8%、92.8%、Gatsby 99.9%、96.3%、Hugo 100.0%、96.1%、最後にJekyllは99.9%、94.8%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1366681808&format=interactive",
  sheets_gid="1340534640",
  sql_file="core_web_vitals_passing.sql"
) }}

実際のユーザー体験では、すべてのSSGが異なるSSG間で素晴らしいFIDの結果を示しています。

{{ figure_markup(
  image="FID-distribution-CDN.png",
  caption="CDN向けのFID配信。",
  description="積み上げ棒グラフは、CDNのFID分布を表しています。Cloudflareはデスクトップ99.8%、モバイル91.7%、AWS 99.9%、95.8%、Netlify 99.9%、97.6%、Vercel 99.7%、96.6%、GitHub 100.0%、96.3%、Akamai 99.4%、84.3%、最後にAzureは100.0%、95.6%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1242431240&format=interactive",
  sheets_gid="1024061881",
  sql_file="core_web_vitals_distribution.sql"
) }}

すべてのCDNがJamstackのサイトを88%以上の良好なFIDで配信しているが、CloudflareとAWSのサイトはJamstack向けのCDNよりも若干悪い結果となっているのは興味深いところだ。

### 累積レイアウトシフト

<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">累積レイアウトシフト</a> (CLF) は、ページの全寿命の間に発生する予期せぬレイアウトシフトごとで、_レイアウトシフトのスコア_の最大のバーストを測定するものです。

{{ figure_markup(
  image="cwv-cls.png",
  caption="実ユーザーによるコアウェブバイタルCLS。",
  description="棒グラフは、上位5つのメジャーSSGの実ユーザーCore Web Vitals CLSを表しています。Next.jsはデスクトップで55.8%、モバイルでは50.0%、Nuxt.jsは53.5%、48.7%、Gatsby 71.1%、65.7%、Hugo 77.7%、74.2%、そして最後にJekyllは83.7%、81.1%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=440775226&format=interactive",
  sheets_gid="1340534640",
  sql_file="core_web_vitals_passing.sql"
) }}

ここでもJekyllは素晴らしいパフォーマンスを発揮しています。モバイルの81.1％が良い結果です。次いでHugoが74.2％、Gatsbyが65.7％、Next.jsが50.0％、Nuxt.jsが48.7％と後塵を拝しています。

CDNについては、前回と同じ結果です。GitHub、Netlify、Vercelです。

{{ figure_markup(
  image="CLS-distribution-CDN.png",
  caption="CDN向けCLS配信。",
  description="積み上げ棒グラフは、CDNのCLS分布を表しています。モバイルではCloudflareが52.6%、46.8%、デスクトップではAWSが62.6%、59.2%、Netlify 74.1%、68.3%、Vercel 65.9%、62.4%、GitHub 84.0%、82.7%、Akamai 49.6%、44.8%、最後にAzure 62.6%と59.7%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=692647280&format=interactive",
  sheets_gid="1024061881",
  sql_file="core_web_vitals_distribution.sql"
) }}

一般的にCWVの結果は、Lighthouseの結果を反映しています。HugeとJekyllは、より良い実際のユーザーのパフォーマンスデータを持っています。我々は、これらのSSGを使用して構築されたどのように複雑なサイトを検出することはできません。我々はNext.js、Nuxt.js、Gatsbyのような最新のSSGで多くのJavaScriptが配信され、画像を含むより多くのデータをレンダリングされていることを確認できます。そのため、パフォーマンスに影響が出るのです。それでも、GitHubとJekyllの間に興味深い相関があり、同時に素晴らしい結果を示しています。

## リソース

ここでは、上位5つのSSGのリソースウェイトを調査し、パフォーマンスへの影響度を把握します。結果は中央値で表示しています。

### リソースの重量

{{ figure_markup(
  image="median-page-weight.png",
  caption="ページの重さの中央値。",
  description="棒グラフは、計測した上位5つのSSGのページウェイトの中央値を表しています。Next.jsはデスクトップ版が2,161KB、モバイル版が1,838KB、Nuxt.jsはそれぞれ2,481と2,000、Gatsbyは1,824と1,739、Hugoは855と1,025、最後にJekyllは612、753となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=632409641&format=interactive",
  sheets_gid="984097158",
  sql_file="resource_weights.sql"
) }}

JavaScriptベースのSSGは、HugoやJekyllの2倍近いリソース量になります。トップはNuxt.jsで〜2MB、次いでNext.jsでほぼ1.8MB、Gatsbyで1.7MBとなっています。

前述したように、JavaScriptベースのSSGはJavaScriptのフレームワークをそのまま含んでいます。それは開発を容易にしますが、より多くの責任を必要とします。JavaScriptのエコシステムは、さまざまな目的のために、サイトにどんどんライブラリを追加することを容易にし、バンドルサイズを大きくすることにつながります。

### JavaScript

{{ figure_markup(
  image="median-js-weight.png",
  caption="JavaScriptの重量の中央値。",
  description="棒グラフは、計測された上位5つのSSGのJavaScriptの重みの中央値を表しています。Next.jsはデスクトップ用75、モバイル用746、Nuxt.jsはそれぞれ70と713、Gatsbyは67と645、Hugoは15と177、そしてJekyllは10、129になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=727314511&format=interactive",
  sheets_gid="984097158",
  sql_file="resource_weights.sql"
) }}

リソースの大きな塊はJavaScript用です。ここでもJavaScriptベースのSSGは他と比べてかなり大きく、非JavaScriptベースのSSGが約150KBであるのに対して、約700KBとなっています。これは驚くべきことでありませんが、このような形で実際の違いを見ることができるのは興味深いことです。Next.jsベースのサイトは、他のサイトよりも多くのJavaScriptを使用しています。一方、HugoとJekyllの開発者は、より責任を持ってJavaScriptを使用し、そのバンドルをタイトに保っているようです。そのためのもう1つの理由は、サイトの複雑さかもしれません。HugoとJekyllのサイトは、上位のランキングサイトにあまり表示されないので、彼らは、たとえば上位のランキングサイトに頻繁に表示されるNext.jsのサイトよりもシンプルなユースケースを持っているかもしれません。

SSGの中でどのようなサードパーティライブラリが使用されているかを分析しました。SSGで使用されている他のライブラリやフレームワークを把握するため、ReactとVueは除外しています。

{{ figure_markup(
  image="3rd-party-libs-distribution-over-ssgs.png",
  caption="SSG上でのJavaScriptサードパーティ配布。",
  description="棒グラフは、SSGにおけるJavaScriptのサードパーティの分布を示しています。Gatsbyはstyle-componentsがもっとも多く（9.5% jQuery, 33.8% style-compents, 10.3% Lodash、7.0% Polyfill、1.8% MobX）、HugoはjQueryが多く（それぞれ63.0%、1.4%、4.2%、1.2%、2.6%）、Jekyllも同じ（61.2%、0.8%、1.0%、0.8%、1.5%）、Next.jsはstyle-componentsを、もっとも多く使用し（5.6%、20.4%、9.6%、2.7%、2.2%）、最後にNuxt.jsは外部ライブラリをあまり使用していません（3.8%、0.3%、4.8%、2.0%、0.1%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=972731684&format=interactive",
  sheets_gid="1291311330",
  sql_file="framework_libraries.sql"
) }}

大きな驚きだったのは、jQueryです。HugoやJekyllベースのサイトで使われている（60%以上）のは驚きではありませんでしたが、ReactやVueベースのサイト内で使われているのは予想外でした！Next.js、Many Nuxt,js、GatsbyのサイトでもjQueryが使われています。Next.js、Many Nuxt,js、GatsbyのサイトもjQueryを使用しています。

サードパーティライブラリのうち、Styled-componentsはNext.jsで20%、Gatsbyでは34%使用されています。Nuxt.jsのサイトでは、ほとんど使われていないようです。

Lodashは多用されており、Gatsbyでは10%まですべてのSSGに存在した。

### CSS

{{ figure_markup(
  image="median-css-weight.png",
  caption="CSS重量の中央値。",
  description="棒グラフは、計測した上位5つのSSGのCSS重量の中央値を表しています。Next.jsはデスクトップ用2、モバイル用14、Nuxt.jsは1、17、Gatsbyは1、Hugoは2、29、そしてJekyllは1、23となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=1274478265&format=interactive",
  sheets_gid="984097158",
  sql_file="resource_weights.sql"
) }}

一方、CSSはHugoやJekyllよりも若干重くなっています。
styled-componentsの利点は、繰り返しのないきれいなCSSであるため、これらのJavaScript SSGのCSSのサイズが小さくなるのは、このためかもしれません。もうひとつの仮説は、旧式のSSGはCSSを使ってインタラクションやアニメーションを処理するために旧式の方法を用いているということです。JavaScriptベースのSSGは一般にJavaScriptを多く使うので、CSSで実装可能な機能を置き換えるために使われることが多いのかもしれません。

### 画像

画像の重みの配分が違う。SSGグループ間の相関はない。

{{ figure_markup(
  image="median-image-weight.png",
  caption="画像の重みの中央値。",
  description="棒グラフは、計測された上位5つのSSGの画像重みの中央値を表しています。Next.jsはデスクトップで62、モバイルで465、Nuxt.jsはそれぞれ89、645、Gatsbyは45、454、Hugoは30、522、そしてJekyllは17、295となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=707866311&format=interactive",
  sheets_gid="984097158",
  sql_file="resource_weights.sql"
) }}

Nuxt.jsは645KBともっとも高い値を示しています。次がHugoで522KB。Next.jsは465KB、Gatsbyは545KBとほぼ同じ。Jekyllは295KBともっとも低い値になっています。

#### 画像フォーマット採用

画像は、優れたユーザー体験（UX）のボトルネックの1つです。サイズが大きければ、ユーザーは画像が届くまで長い時間待たされることになります。レイアウトがずれるなどの問題にもつながります。

{{ figure_markup(
  image="image-adoption.png",
  caption="画像フォーマットの採用。",
  description="棒グラフは、SSGページにおける画像フォーマットの使用率を表しています。`png`はデスクトップ32.7%、モバイル29.0%、`jpg`では27.7%、26.2%、`gif`が16.2%、19.5%、`svg`で15.3%、18.0%、`webp`では5.8%、5.1%、そして最後に`ico`は2.1%、2.0%であることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRUiAdcUCSYyS7cQcQlE9uKeMSacgRudtf4pFRkIKKCt8Nw18qOod6TaAUL7tfm8pUbCPKShEN0jJOS/pubchart?oid=470820948&format=interactive",
  sheets_gid="626634977",
  sql_file="adoption_of_image_formats_in_ssgs.sql"
) }}

新しい世代の画像フォーマットの1つである<a hreflang="en" href="https://developers.google.com/speed/webp/">WebP</a>は、Jamstackサイトでの使用率が5.1%となっています。WebPが3％しかなかった[昨年の結果](../2020/jamstack#画像フォーマット)と比較すると、1年前より良くなっていると言えるでしょう。

それでももっとも使われているのはPNGで29.0%、JPEGは26.2%、GIFが19.5%、そしてSVGは18.0%のWebページで使われているそうです。

### 資料からわかること

このリソース重量の分析から、Next.js、Nuxt.js、Gatsbyのパフォーマンスは、巨大なリソースのために苦労していると思われることが確認されました。2MBのページウェイトと700KBのJavaScriptは、とくに平均的なモバイルデバイスと低速のネットワークにおいて、パフォーマンススコアに確実に影響を与えるでしょう。Next.jsとGatsbyのサイトでは、<a hreflang="en" href="https://pustelto.com/blog/css-vs-css-in-js-perf/">styled-componentsを多用することも、パフォーマンスが低下する原因かもしれません</a>。ポジティブなシグナルは、次世代画像フォーマットの画像採用が進んでいることであり、これは長期的にはエンドユーザーのUXを向上させるはずです。

## 結論

ヘッドレスCMSや、いくつかの有名なSSG（EleventyやNext.jsの検出モード）を含めることができないという制限はあるものの、ここでは興味深い結論を導き出すために多くのデータを分析できます。Jamstackのトレンドは年々高まっており、現在では全ウェブサイトの1%以上がJamstackベースとなっています。

Next.jsは、Jamstackで計測可能なサイトの約40%をカバーしていることが分かっています。また、トレンドだけでなく、上位1,000サイトの3.8%で利用されており、Nuxt.jsやGatsbyといった他の人気SSGがそれに続いています。これらはいずれも参入して数年の比較的新しいプレイヤーですが、ランキング上位のサイトでもよく利用されており、その地位を確固たるものにしています。

SSGは世界中で利用されており、このモデルの創業企業が拠点とする国に限定されるものではありません。実際、Jamstackの技術を採用し、最大5％のサイトが急成長しているのは、シリコンバレーのハイテク拠点からもっとも遠い地域であるようです。

他のウェブサイトと同様にJamstackサイトの良好なパフォーマンスを維持するには、ベストプラクティスの知識と経験豊富な開発者レベルが必要ですがSSGはその辺りを改善するために、すぐに使えるソリューションに取り組むことで、これを改善できます。データを楽しみながら、Jamstackを試していただけると幸いです。
