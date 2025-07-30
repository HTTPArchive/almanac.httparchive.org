---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: 2024年のWeb AlmanacのJamstackの章では、プリレンダリングされたサイトとハイブリッドサイトの定量化、そしてそれらを支えるビルドツールの成長について取り上げます。
hero_alt: Web Almanacのキャラクターが、前面にスクリプトの印がついた大きなガスボンベを使ってウェブページを膨らませているヒーローイメージ。
authors: [mikeneu]
reviewers: [thomkrupa]
editors: [avidlarge]
analysts: [guaca]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1wKswSnp8TuN4aZb63ir7hE5eCikIu8zEdQYPp4Xo6O0/
featured_quote: 今年の際立った特徴は、2024年にトラフィックの多い上位1万のウェブサイトにおいて、プリレンダリングとハイブリッドアーキテクチャが合わせて67%も成長したことです。ウェブがいかに本質的に静的であるかを考えると、この傾向は有望です。
featured_stat_1: 43%
featured_stat_label_1: プリレンダリングされたサイトが動的サイトより小さい割合。
featured_stat_2: 3x
featured_stat_label_2: 2024年におけるプリレンダリングサイト向けAstroの成長率
featured_stat_3: 42%
featured_stat_label_3: プリレンダリングされたサイトが動的サイトより使用するJavaScriptが少ない割合。
mikeneu_bio: Mike Neumegenは、アクセスしやすく、速く、シンプルで、安全で、強力な基礎に根ざしたウェブの構築に情熱を注いでいます。彼は、Gitベースのワークフローをコンテンツ編集者にもたらすコンテンツ管理プラットフォームである<a hreflang="en" href="https://cloudcannon.com/">CloudCannon</a>の共同設立者です。
doi: 10.5281/zenodo.14065579
---

## 導入

Jamstackを覚えていますか？この言葉自体はもはや広く使われなくなりましたが、その中心的な概念は依然として重要です。

Jamstackの核心は、可能な限りページをプリレンダリングすることを推進する配信アーキテクチャです。2024年のWeb Almanac Jamstackの章では、今日一般的に使用されている3つの主要な配信アーキテクチャについて探ります：

1. **プリレンダリング**: 事前にページをビルドし、静的ファイルとして提供します。
2. **ハイブリッド**: インクリメンタル静的再生成（ISR）やエッジファンクションのような技術を使い、静的なページと動的なページを混在させ、両者の境界を曖昧にします。
3. **動的**: リクエストごとにサーバーでページが生成されます。

ウェブサイトが静的であればあるほど、より速く、スケーラブルで、安全で、環境に優しくなる傾向があるため、**静的ファースト**のアプローチを取ることが一般的になってきました。プリレンダリング、ハイブリッド、そして動的なアプローチは、ウェブ開発者のツールキットにおける貴重なツールであり、それぞれ異なる状況に適しています。これらのカテゴリがどのように進化しているか見ていきましょう。

## データセットの定義

では、サイトがどの配信アプローチを取っているかをどう判断するのでしょうか？理想的には、すべてのサイトをきちんと分類できる明確な目印があればよいのですが、残念ながらそのような目印はなく、それがこれらのアーキテクチャについて報告する上でもっとも大きな課題の1つとなっています。

以前のJamstack Web Almanacの章では、2つのアプローチが取られてきました：

1. 検出可能な静的サイトジェネレータを持つウェブサイトに焦点を当てる。これにより、対象のサイトが的を絞った技術を使用していると確信できるため、正確な状況を把握できました。問題は、多くの静的サイトジェネレータがデフォルトでフィンガープリントを残さないため、データセットがNext.jsやNuxtのようなフレームワークに偏ってしまうことです。さらに問題を複雑にしているのは、これらの重いJavaScriptフレームワークはページのプリレンダリングと動的レンダリングの両方が可能であるため、どちらのカテゴリに入れるべきかという点です。

2. [2022年のJamstackの章](../2022/jamstack)で開拓された2番目のアプローチでは、[Largest Contentful Paint](https://web.dev/articles/lcp)、[Cumulative Layout Shift](https://web.dev/articles/cls)、そしてキャッシングのしきい値を用いてデータセットを構築しました。このアプローチは、明確な静的サイトジェネレータのフィンガープリントを持たないプリレンダリングされたサイトをより多く含めることで、データセットを広げます。欠点は、フロントエンドのパフォーマンスに焦点を当てることで、プリレンダリングの定義が曖昧になることです。プリレンダリングはしばしば配信速度を向上させますが、私たちの見解では、その範囲はそこまでです。LCPの高速化のような配信後の事象は、嬉しい副産物です。

どちらのアプローチにも長所があります。最初のアプローチはプリレンダリングされたサイトを明確に定義するデータを使い、2番目のアプローチは指標に依存します。今年は、両方の長所を活かすために、スコアリングシステムを組み合わせています。このスコアリングシステムは、サイトがプリレンダリングされているかどうかの信頼度を反映するために開発しました。11tyで生成されたり、GitHub Pagesでホストされているような強力な指標は100ポイントを獲得し、Time to First Byte（TTFB）が速いといったよりソフトなシグナルは、この場合は50ポイントといった低いポイントを受け取ります。

次に、ポイントを合計し、以下のいずれかのカテゴリに入れます：

### プリレンダリング

サイトが100ポイント以上を獲得した場合、それをプリレンダリングと呼びます。これは、サイトが静的に生成されているか、分離されていることを示す複数の兆候があることを意味します。これは高い基準であり、2024年の全サイトの約0.5%を含みます。

### ハイブリッド

サイトが50から99ポイントの間でスコアを獲得した場合、それをハイブリッドカテゴリに入れます。これらは静的かもしれないが、私たちが判断するのに十分なフィンガープリントがないウェブサイト、あるいは純粋に静的ではないが、いくつかのアプローチや哲学を共有しているウェブサイトです。たとえば、NetlifyでホストされているNuxtサイトや、TTFBが速いGatsbyサイトなどです。ハイブリッドはより緩やかなカテゴリですが、それでも2024年のデータセットの約5%を占める高い基準です。

### 動的

50ポイント未満のスコアのものはすべて動的カテゴリに分類されます。これらのサイトは、サーバーサイドレンダリングに依存しているか、他のカテゴリに入れるのに十分なフィンガープリントがありません。動的はウェブの大部分を占め、データセットの約94.5%を占めます。

## スコアリング

スコアリングの仕組みについて詳しく見ていきましょう。

### 検出可能な静的サイトジェネレータ

これは非常に大きな手がかりです。SSGに基づいて、ウェブサイトがプリレンダリングされている可能性がどれくらいあるかをスコアで示すことができます。これらはおおよその目安なので、Next.jsサイトの30%が純粋に静的であると断言することはできませんが、他のデータポイントと組み合わせることで、確信を持つことができる1つのデータポイントです。

<figure>
  <table>
    <thead>
      <tr>
        <th>SSG</th>
        <th>ポイント</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Astro</td>
        <td class="numeric">50</td>
      </tr>
      <tr>
        <td>Bridgetown</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Docusarus</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Eleventy</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Gatsby</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Gridsome</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Hexo</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Hugo</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Jekyll</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Mintlify</td>
        <td class="numeric">70</td>
      </tr>
      <tr>
        <td>Next.js</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Nextra</td>
        <td class="numeric">70</td>
      </tr>
      <tr>
        <td>Nuxt</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Octopress</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Pelican</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Retype</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Scully</td>
        <td class="numeric">70</td>
      </tr>
      <tr>
        <td>VuePress</td>
        <td class="numeric">100</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="SSGポイント分布。"
    ) }}
  </figcaption>
</figure>


### ホスティングプロバイダ

GitHub Pagesは静的コンテンツしか提供できないため、そのプラットフォームでホストされていれば、プリレンダリングされているに違いないとわかります。NetlifyとVercelはどちらも多くの静的ウェブサイトを持っていますが、動的な機能も備えています。スコアリングではこれを考慮に入れようとしました。

<figure>
  <table>
    <thead>
      <tr>
        <th>ホスティングプロバイダ</th>
        <th>ポイント</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>GitHub Pages</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Tiiny Host</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Vercel</td>
        <td class="numeric">30</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ホスティングプロバイダのポイント分布。"
    ) }}
  </figcaption>
</figure>

### TTFB

[Time to First Byte](https://web.dev/articles/ttfb) は、サーバーがブラウザに何かを返すまでにかかった時間です。この指標を使う背後にある考え方は、サーバーが行うべきことが静的ファイルを返すだけならTTFBは非常に速くなるのに対し、サーバーがページを生成するために動的な処理を行う必要がある場合は時間がかかるというものです。もちろん、サーバーがページを生成するのに時間をかけている間に *何か* を送信すればTTFBはごまかせますが、だからこそ良好なTTFBには100ではなく50のスコアを与えています。

<figure>
  <table>
    <thead>
      <tr>
        <th>サーバー応答時間</th>
        <th>ポイント</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>800ms以下</td>
        <td class="numeric">50</td>
      </tr>
      <tr>
        <td>800msより大きく <strong>かつ</strong> 1800ms以下</td>
        <td class="numeric">25</td>
      </tr>
      <tr>
        <td>1800ms以上</td>
        <td class="numeric">0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="サーバー応答時間のポイント分布。"
    ) }}
  </figcaption>
</figure>


### キャッシング

キャッシングは、サイトがどれほど静的であるかを把握するのに良い指標となります。サイトが積極的なキャッシングヘッダーを使用している場合、サーバーが最小限の作業しか行っていないことを強く示唆しており、これは非常に静的らしいと感じられます。一方、長くてもそれほど積極的でないヘッダーを持つサイトは、依然として静的なアプローチを示唆していますが、確実性は低くなります。

<figure>
  <table>
    <thead>
      <tr>
        <th>キャッシュヘッダー</th>
        <th>ポイント</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`max-age`が2週間以上 <strong>かつ</strong> 再検証を必要としない。</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>`max-age`が2週間以上 <strong>かつ</strong> 再検証を必要とする。</td>
        <td class="numeric">50</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="キャッシュヘッダーのポイント分布。"
    ) }}
  </figcaption>
</figure>


### ETag

ETagは、ブラウザがリソースが最後に取得されてから変更されたかどうかを確認できるようにすることで、キャッシュの検証を助けます。サーバーが毎回コンテンツを再生成する代わりにキャッシュされたコンテンツに依存していることを示しているため、これは静的なアプローチへの小さな後押しと見ています。

<figure>
  <table>
    <thead>
      <tr>
        <th>Etag</th>
        <th>ポイント</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ETagが存在する</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>ETagがない</td>
        <td class="numeric">0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Etagポイント分布。"
    ) }}
  </figcaption>
</figure>


### `Set-Cookie`

`Set-Cookie`ヘッダーは、動的な振る舞いを示唆します。通常、これはサーバーがセッションなどを処理していることを意味し、コンテンツが純粋に静的ではないことを示唆します。

<figure>
  <table>
    <thead>
      <tr>
        <th>Set Cookie</th>
        <th>ポイント</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Set-Cookieが存在する</td>
        <td class="numeric">-10</td>
      </tr>
      <tr>
        <td>Set-Cookieがない</td>
        <td class="numeric">0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Set Cookieポイント分布。"
    ) }}
  </figcaption>
</figure>

### データセットの制限事項

このセグメンテーションは難しいということを改めて強調しておきます。これらは利用可能なデータに基づく大まかな推定であり、一部の誤分類は避けられません。また、このスコアリング方法を用いたのは今年が初めてであり、今後数年で改良できるものです。

これを最小限に抑えるため、プリレンダリングとハイブリッドに該当するものの基準を高く設定しました。これらのカテゴリは、このレポートで示されているよりも大きい可能性があります。

## 分析

カテゴリが定義されたので、2024年にそれらがどのようにトレンドになっているか見てみましょう。

### 静的サイトジェネレータ

SSGはプリレンダリングを実行する技術であり、分析の自然な出発点となります。すべての静的サイトジェネレータがフィンガープリントを残すわけではないことに留意してください。たとえば、11tyのようなツールはデフォルトで何の痕跡も残さないため、このデータセットには反映されていません。

{{ figure_markup(
  image="prerendered-static-site-generators.png",
  caption="プリレンダリングされたサイトの静的サイトジェネレータ使用状況。",
  description="プリレンダリングされたサイトの静的サイトジェネレータ使用状況を示す棒グラフ。2024年には、Hugoがモバイルページの18%で使用され、Next.jsが13%、Astroが5%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=1868506505&format=interactive",
  sheets_gid="1131487846",
  sql_file="ssg.sql"
  )
}}

過去3年間、プリレンダリングカテゴリではHugoがかなりの差をつけてリードしているのがわかります。Hugoは高速で柔軟なSSGとして知られており、パフォーマンスを重視するコミュニティがあるため、リストのトップにいるのは驚くことではありません。

Next.jsはウェブ上での優位性を維持し、プリレンダリングカテゴリでHugoとの差を着実に縮めています。注目すべきは、私たちのスコアリングでは、既知のHugoサイトのほぼすべてをプリレンダリングと見なしているのに対し、Next.jsがプリレンダリングと見なされるには複数の指標が必要であるという点です。

一方、Jekyll、Gatsby、Hexoはプリレンダリングカテゴリでの使用率が安定または減少しており、これはこれらのフレームワークへの開発が減少していることを反映しています。

Docusaurusは着実に上昇しており、ドキュメンテーション専用であることを考えると印象的です。

ここで本当に際立っているのはAstroで、2024年には3倍に成長しました！今やプリレンダリングカテゴリの主要プレイヤーであり、この傾向が続けば主要なフレームワークになる可能性があります。

ハイブリッドカテゴリを見てみましょう：

{{ figure_markup(
  image="hybrid-static-site-generators.png",
  caption="ハイブリッドサイトの静的サイトジェネレータ使用状況。",
  description="ハイブリッドサイトの静的サイトジェネレータ使用状況を示す棒グラフ。2024年には、Next.jsがモバイルページの23%で使用され、Nuxtが9%、Astroが1%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=633489729&format=interactive",
  sheets_gid="1131487846",
  sql_file="ssg.sql"
  )
}}

ハイブリッドカテゴリでは、Next.jsが過去1年で39%増加し、そのリードを広げていることがわかります。Next.jsは、プリレンダリング、動的レンダリング、インクリメンタル静的再生成（サイト全体のリビルドを必要とせずに特定の静的ページをオンデマンドで更新）が可能な非常に柔軟なフレームワークです。情報サイトから本格的なウェブアプリケーションまで、あらゆるものに対応できるその多様性が、使用率の増加の大きな理由の1つです。

Nuxtはハイブリッドカテゴリ内で着実に成長を続け、Astroは2024年に急速な成長を遂げました。

### パフォーマンス

プリレンダリングされたサイトは、サーバーがリクエストごとに動的にレスポンスをレンダリングするのではなく、即座に応答できるため、そのパフォーマンスで知られています。これにより、読み込み時間が短縮され、サーバーへの負荷が軽減されます。分析でそれがどのように現れるか見てみましょう。

サイトのページ転送サイズの中央値は、サイト全体のパフォーマンスに重要な要素であると予想されるため、興味深い出発点です。

{{ figure_markup(
  image="page-transfer-size.png",
  caption="年ごとの転送サイズ。",
  description="プリレンダリング、ハイブリッド、ダイナミックの各カテゴリについて、年ごとの転送サイズの内訳を示す縦棒グラフ。2024年、プリレンダリングされたサイトの中央値は1,427 KB、ハイブリッドサイトの中央値は2,083 KB、動的サイトの中央値は2,434 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=1985928033&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

平均して、プリレンダリングされたサイトは転送サイズがはるかに小さく、動的サイトの43%に相当します。

プリレンダリングサイトとハイブリッドサイトの間のジャンプは、プリレンダリングサイトが静的な情報サイトである可能性が高いのに対し、ハイブリッドサイトはeコマースやウェブアプリケーションに傾倒する可能性があり、それがより大きな転送サイズにつながる可能性があるという、それぞれの異なるユースケースを反映している可能性があります。


この余分な重みがどこから来ているのかを分解してみましょう。

{{ figure_markup(
  image="total-requests.png",
  caption="年ごとの総リクエスト数。",
  description="プリレンダリング、ハイブリッド、ダイナミックの各カテゴリにおける年ごとのリクエスト数を示す縦棒グラフ。2024年、プリレンダリングされたサイトの中央値は42、ハイブリッドサイトの中央値は65、動的サイトの中央値は72です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=136070557&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

総リクエスト数を見ると、カテゴリ間の総ページ重量の違いの一部を説明できるかもしれません。2022年から2024年にかけて、プリレンダリングされたサイトでは総リクエスト数はほぼ同じままで、動的ではわずかに増加し、ハイブリッドカテゴリではもっとも大きな増加（2024年に16%）が見られます。

{{ figure_markup(
  image="css-size.png",
  caption="年ごとのCSSサイズ。",
  description="プリレンダリング、ハイブリッド、ダイナミックの各カテゴリにおける年ごとのCSSの中央値を示す縦棒グラフ。2024年、プリレンダリングされたサイトの中央値は26KB、ハイブリッドサイトの中央値は41KB、動的サイトの中央値は77KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=2011541229&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

CSSの総転送量は別の視点を提供し、すべてのカテゴリでわずかな上昇傾向を示しています。ハイブリッドサイトと動的サイトの間の顕著なジャンプが目立ちます。正確な原因を特定するにはさらなる分析が必要ですが、考えられる説明としては、プリレンダリングサイトとハイブリッドサイトはウェブ開発者によって手作りされる傾向があるのに対し、動的サイトはしばしばテーマ、ウェブサイトビルダー、プラグインに依存しており、これらは肥大化したウェブアセットで悪名高いということです。

{{ figure_markup(
  image="javascript-size.png",
  caption="年ごとのJavaScriptサイズ。",
  description="プリレンダリング、ハイブリッド、ダイナミックの各カテゴリにおける年ごとのJavaScriptの中央値を示す縦棒グラフ。2024年、プリレンダリングされたサイトの中央値は330KB、ハイブリッドサイトの中央値は674KB、動的サイトの中央値は574KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=1540077714&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

JavaScriptの総転送量は、もっとも興味深い洞察の1つを提供しており、ハイブリッドサイトのJavaScriptサイズが急激に増加し、2024年には動的カテゴリのそれを上回っています。

{{ figure_markup(
  image="javascript-frameworks.png",
  caption="プリレンダリングサイトとハイブリッドサイトで使用されるJavaScriptフレームワーク。",
  description="2024年にプリレンダリングサイトとハイブリッドサイトで使用されるもっとも一般的なJavaScriptフレームワークを示す棒グラフ。Reactがもっとも人気で、プリレンダリングサイトの23%、ハイブリッドサイトの39%で使用されています。次にVue.jsが来て、プリレンダリングサイトの8%、ハイブリッドサイトの13%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=1961429073&format=interactive",
  sheets_gid="1131487846",
  sql_file="js_frameworks.sql"
  )
}}

プリレンダリングされたウェブサイトとハイブリッドウェブサイトで使われるJavaScriptフレームワークを分解すると、Reactのような重いフレームワークがハイブリッドカテゴリでより一般的に使われていることがわかります。

{{ figure_markup(
  image="transfer-excluding-css-js.png",
  caption="年ごとのCSSとJavaScriptを除いた転送サイズ。",
  description="プリレンダリング、ハイブリッド、ダイナミックの各カテゴリにおける、年ごとの非JavaScriptおよびCSS転送サイズの中央値を示す縦棒グラフ。2024年、プリレンダリングされたサイトの中央値は1,071KB、ハイブリッドサイトの中央値は1,368KB、動的サイトの中央値は1,783KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=919021609&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

総転送サイズからCSSとJavaScriptを除くと、HTML、画像、フォント、その他のメディアが残ります。このフィルタリングされた総中央転送サイズを比較すると、各カテゴリ間にまだ顕著な差があります。これは各カテゴリで行われる総リクエスト数に対応しており、これらのカテゴリで画像やフォントがより多く使用されていることを反映している可能性があります。

{{ figure_markup(
  image="astro-hugo-next-transfer-size.png",
  caption="Astro vs Hugo vs Next.js：年ごとの転送サイズ。",
  description="プリレンダリングカテゴリにおけるAstro、Hugo、Next.jsサイトの年ごとの総転送サイズの中央値を示す縦棒グラフ。2024年、Astroサイトの中央値は889KB、Hugoサイトの中央値は1,174KB、Next.jsサイトの中央値は1,659KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=1751742689&format=interactive",
  sheets_gid="1131487846",
  sql_file="hugo_astro_next.sql"
  )
}}

プリレンダリングカテゴリで際立っている3つの静的サイトジェネレータ、Astro、Hugo、Next.jsに焦点を当てることで、ページ重量を分析するための別の視点が得られます。注：この分析には、比較を公平に保つため、プリレンダリングカテゴリのサイトのみが含まれます。

Astroは、AstroアイランドやデフォルトでのゼロJavaScriptからアセット最適化パイプラインまで、必要な最小限のデータのみを送信するために数多くのステップを踏んでいます。そのパフォーマンスへの献身がデータに反映されているのを見るのは素晴らしいことです。

HugoはAstroからページ重量が一段階上がっているのが見られます。HugoにはAstroと同じタイプの資産最適化パイプラインが多くありますが、Astroのパイプラインはフレームワークに深く統合されており、それが違いを説明している可能性があります。

Next.jsはページ重量がかなり増加しています。Next.jsはルーティングとハイドレーションのためのバンドルされたランタイム、そしてReactライブラリと共に出荷され、これら両方がより高いページ重量のベースラインに寄与しています。

{{ figure_markup(
  image="astro-hugo-next-js-size.png",
  caption="Astro vs Hugo vs Next.js：年ごとのJavaScriptサイズ。",
  description="プリレンダリングカテゴリにおけるAstro、Hugo、Next.jsサイトの年ごとのJavaScript転送サイズの中央値を示す縦棒グラフ。2024年、Astroサイトの中央値は164KB、Hugoサイトの中央値は210KB、Next.jsサイトの中央値は583KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=823335659&format=interactive",
  sheets_gid="1131487846",
  sql_file="hugo_astro_next.sql"
  )
}}

これを純粋に出荷されたJavaScriptに分解すると、Next.jsのJavaScriptバンドルがいかに重いかがわかります。Astroの3.5倍の大きさです。

{{ figure_markup(
  image="core-web-vitals.png",
  caption="年ごとの良好なコアウェブバイタルを持つサイト。",
  description="各カテゴリで良好なコアウェブバイタルスコアを持つサイトの割合を年ごとに示す縦棒グラフ。2024年、プリレンダリングサイトの41%、ハイブリッドサイトの31%、動的サイトの33%が良好なコアウェブバイタルスコアを持っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=275245520&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

配信アプローチがコアウェブバイタルにどのように影響するか見てみましょう。私たちは、サイトが以下の条件を満たす場合に[Googleの良好なコアウェブバイタルの定義](https://web.dev/articles/vitals#core-web-vitals)を使用します：

* **Largest Contentful Paint** (LCP)がユーザーの75%で2.5秒未満
* **Cumulative Layout Shift** (CLS)がユーザーの75%で0.1未満
* **Interaction to Next Paint** (INP)がユーザーの75%で200ミリ秒未満

プリレンダリングは通常、より速いTime to First Byte（TTFB）をもたらし、それは自然にLCPを改善します：ブラウザがHTMLを速く受け取るほど、アセットの取得とページのレンダリングを早く開始できます。これらのサイトは、しばしば開発者によって手作りされるため、CLSのような詳細にもより注意が払われる傾向があります。ハイブリッドはJavaScriptフレームワークと最大のJavaScriptペイロードを多用しており、それが良好なコアウェブバイタルの割合がもっとも低い理由を説明している可能性があります。

### 成長

では、これらのアーキテクチャはウェブ全体でどのように採用されているのでしょうか？

{{ figure_markup(
  image="global-adoption.png",
  caption="プリレンダリングサイトとハイブリッドサイトのグローバルな成長。",
  description="年ごとにプリレンダリングおよびハイブリッドであるサイトの総数の割合を示す縦棒グラフ。2024年には、サイトの0.5%がプリレンダリング、5%がハイブリッドです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=1749178863&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack-overview.sql"
  )
}}

完全なデータセットを見ると、プリレンダリングアーキテクチャとハイブリッドアーキテクチャは増加傾向にあるものの、ウェブの他の部分と比較するとまだ比較的小規模であることがわかります。これは、ほとんどのウェブサイトが、プリレンダリングおよびハイブリッドカテゴリで一般的な開発者中心のツールではなく、ウェブサイトビルダーやGUIに依存しているため、理にかなっています。

もっともトラフィックの多いサイトにズームインすると、より多くの成長が見られます：

{{ figure_markup(
  image="prerendered-high-traffic-adoption.png",
  caption="高トラフィックウェブサイトにおけるプリレンダリングの採用。",
  description="もっともトラフィックの多いウェブサイトのうち、年ごとにプリレンダリングされている割合を示す縦棒グラフ。2024年には、もっとも人気のある1,000サイトと10,000サイトの0.8%がプリレンダリングされており、上位10万サイトでは0.6%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=959672300&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack_distribution_by_rank.sql"
  )
}}

もっとも人気のある上位1kおよび10kのサイトでは、プリレンダリングの採用が大幅に増加しており、1Mマーク以降では成長が頭打ちになっています。これらの高トラフィックサイトは、パフォーマンス、SEO、セキュリティ、安定性を非常に重視しており、これらの原則はプリレンダリングアプローチと完全に一致しています。

{{ figure_markup(
  image="hybrid-high-traffic-adoption.png",
  caption="高トラフィックウェブサイトにおけるハイブリッドの採用。",
  description="もっともトラフィックの多いウェブサイトのうち、年ごとにハイブリッドである割合を示す縦棒グラフ。2024年には、もっとも人気のある1kサイトの11.7%がハイブリッドで、上位10kサイトの12.7%、上位100kサイトの6.1%、上位1Mサイトの4.4%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTzPcqcOjo0RTaHjgSQCXZYJRyquXzzd6qOsD6PysgZZdGXlR8pP5i2Reoa_WJwJLjFHniXA2DWwDq1/pubchart?oid=214828640&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack_distribution_by_rank.sql"
  )
}}

ハイブリッドでも同様で、現在ではもっとも人気のある1万のウェブサイトの12%以上を占めています。

## 結論

今年の際立った特徴は、2024年にトラフィックの多い上位1万のウェブサイトにおいて、プリレンダリングとハイブリッドアーキテクチャが合わせて67%も成長したことです。これらの人気サイトの12%以上が現在、これらのアプローチを使用しています。プリレンダリングとハイブリッド配信は、ウェブ全体という文脈ではまだニッチですが、その利点がもっとも評価される分野で急速に支持を得ています。

ウェブがいかに本質的に静的であるかを考えると、この傾向は有望です。静的ファーストのモデルを採用し、動的コンテンツに動的レンダリングを限定することで、ウェブはより速く、より軽量になるだけでなく、大幅に環境に優しくなる可能性があります。

Hugoはプリレンダリング分野でトップの静的サイトジェネレータとしてリードを続けており、Next.jsがその差を詰めています。Astroは2024年にプリレンダリングフレームワークの中で最大の成長を遂げ、この分野では比較的新しいフレームワークであることを考えると、これは印象的な偉業です。

プリレンダリングカテゴリとハイブリッドカテゴリの両方でNext.jsとAstroの存在感が増していることは、開発者が静的および動的コンテンツ生成をより細かく制御できるハイブリッドアーキテクチャへのシフトを示しています。Astroのパフォーマンス向上とページ重量削減への注力は実を結んでいるようで、Next.jsに追いつく上で大きな進歩を遂げています。

Jamstackという言葉はもはや広く使われていないかもしれませんが、その進化はトップクラスのウェブサイトを動かす未来を形作り続け、より速く、より安定し、安全で、環境に優しいウェブへの道を開いています。
