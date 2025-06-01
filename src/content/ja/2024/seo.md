---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: 2024 Web AlmanacのSEOの章では、クローラビリティ、インデックス可能性、ページエクスペリエンス、オンページSEO、リンク、AMP、国際化などについて解説しています。
hero_alt: Web Almanacのキャラクターたちが検索フィールドの下にある様々なウェブページに光を当て、様々なチェックを行っているヒーロー画像。
authors: [fellowhuman1101, dwsmart,  mikaelaraujo, MichaelLewittes]
reviewers: [tunetheweb]
editors: [MichaelLewittes]
analysts: [henryp25, cnichols013]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1lAQKcOF7l6xz9v7yvnI9I1F8yiSqcz3Xx6u-5ady1DQ/
fellowhuman1101_bio: Jamie Indigoはロボットではありませんが、ボットの言葉を話します。<a hreflang="en" href="https://www.coxautoinc.com/">Cox Automotive</a>のテクニカルSEOディレクターとして、検索エンジンがウェブをクロール、レンダリング、インデックスする方法を研究しています。Jamieは野生のJavaScriptを制御し、レンダリング戦略を最適化するのが大好きです。仕事以外では、ホラー映画、グラフィックノベル、そしてDungeons & Dragonsで合法善良なパラディンを恐怖に陥れることを楽しんでいます。
dwsmart_bio: Dave Smartは<a hreflang="en" href="https://tamethebots.com">Tame the Bots</a>の開発者兼テクニカル検索エンジンコンサルタントです。モダンウェブのツール構築と実験が大好きで、ライブギグの最前線で見かけることがよくあります。
mikaelaraujo_bio: Mikael Araújoは<a hreflang="en" href="https://www.mikaelaraujo.com">国際SEOコンサルタント</a>、スピーカー、マーケティング戦略家です。ヨーロッパ、中国、ロシア、アメリカ、ブラジルを拠点とする数多くの企業でリモートワークを経験しています。現在はデータサイエンスを学んでおり、家族との時間を大切にしています。
MichaelLewittes_bio: Michael Lewittesは、コンテンツの品質と信頼性を向上させ、検索結果での順位を上げるSEOソフトウェア会社<a hreflang="en" href="https://www.ranktify.com">Ranktify</a>の創業者です。Michaelは以前、コンテンツ会社を所有・売却し、いくつかの主要なアメリカの出版物で執筆・編集を行っていました。Web Almanacへの参加は2回目となります。
featured_quote: AIとLLMは、検索エンジンが長い間直面してきたもっとも大きな変化をもたらしており、大きな変革をもたらす可能性があります。
featured_stat_1: 70%
featured_stat_label_1: `<h1>`要素を持つページ（そのうち6%が空）。
featured_stat_2: 2.7%
featured_stat_label_2: `robots.txt`に`GPTBot`ディレクティブを持つページ—もっとも一般的なAIクローラー。
featured_stat_3: 10.9%
featured_stat_label_3: 無効な`<head>`要素を持つモバイルページ。
doi: 10.5281/zenodo.14245177
---

## はじめに

検索エンジン最適化（SEO）は、ウェブサイトの技術的な設定、コンテンツ、権威性を向上させ、検索結果での表示を改善する取り組みです。ウェブサイトのコンテンツをユーザーの検索意図に合わせることで、ビジネスはオーガニックトラフィックを集客することができます。

Web AlmanacのSEOチャプターでは、ウェブサイトのオーガニック検索での表示に影響を与える重要な要素と設定に焦点を当てています。主な目標は、ウェブサイト所有者がサイトのクローラビリティ、インデックス可能性、全体的な検索エンジンでの順位を向上させるための実践的な洞察を提供することです。一般的なSEO要素の包括的な分析を通じて、ウェブサイトが検索結果での存在感を最適化するためのもっとも効果的な戦略とテクニックを見つけられることを期待しています。

このチャプターでは、<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>、[Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/)、[Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report)、およびカスタムメトリクスのデータを組み合わせて、SEOの現状とデジタルランドスケープにおける文脈を記録しています。

今年は、これまでこのチャプターが分析してきたホームページに加えて、クロールされたサイトごとに1つの内部ページも分析しました。ホームページは内部ページとかなり異なることが多いため、これにより新しい洞察が得られ、ホームページと内部ページの動作を比較することができるようになりました。

## クローラビリティとインデックス可能性

ページが検索エンジンの検索結果ページ（SERP）に表示されるためには、まずクロールとインデックス登録が必要です。このプロセスはSEOの重要な基盤となります。

検索エンジンは、外部リンク、サイトマップ、またはウェブマスターツールを使用して直接検索エンジンに送信されるなど、いくつかの方法でページを発見します。2022年、Bingはそのクローラーが1日あたり[700億の新しいページ](https://x.com/patrickstox/status/1630582277057986560?s=20)を発見したことを共有しました。今年のGoogleに対する独占禁止法訴訟では、その*インデックス*は約<a hreflang="en" href="https://zyppy.com/seo/google-index-size/#:~:text=But%20recently%2C%20during%20testimony%20in,Google's%20index%20size%20in%202020.">4,000億ドキュメント</a>であることが明らかになりました。これは、クロールされるページの数がインデックスされるページの数よりもはるかに多いことを意味します。

このセクションでは、検索エンジンがコンテンツをクロールしてインデックスする方法に関連するウェブの現状、およびSEO担当者がクローラーとの相互作用とコンテンツのバージョンを保持するために提供できるディレクティブとシグナルについて説明します。

### `robots.txt`

検索エンジンがウェブを探索する際、各サイトの「訪問者センター」とも言える`robots.txt`ファイルで立ち止まります。`robots.txt`ファイルはオリジンのルートに配置され、サイト所有者が[Robots Exclusion Protocol](https://wikipedia.org/wiki/Robots.txt)を実装することを可能にします。これは、検索エンジンがクロールできるURLとできないURLをボットに指示するために設計されています。

これは厳格な技術的な指示ではありません。むしろ、これらの指示を尊重するかどうかはボット次第です。主要な検索エンジンがこのプロトコルを尊重しているため、SEO分析において重要な要素となっています。

`robots.txt`ファイルは1994年からサイトのクロール制御に使用されてきましたが、2022年9月にInternet Engineering Task Forceによって正式に標準化されました。2022年の<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9309">RFC 9390</a>プロトコルの正式化は、前年のWeb Almanacの出版後に実施され、技術標準のより厳格な施行につながりました。

今年のWeb Almanacの測定では、オープンソースの自動化ツールであるLighthouseを独自のデータ収集と並行して実行し、ウェブページの品質向上を図りました。これらの監査により、デスクトップページの8.43%、モバイルページの7.40%が[有効な`robots.txt`ファイル](https://developer.chrome.com/docs/lighthouse/seo/invalid-robots-txt)のチェックに失敗していることが明らかになりました。

#### `robots.txt` のステータスコード

{{ figure_markup(
  image="robots-txt-status-codes.png",
  caption="`robots.txt` のステータスコード。",
  description="`robots.txt` ファイルが有効なページの割合を示す棒グラフ。モバイルサイトの83.9%が200ステータスコードを返し、14.1%が404ステータスコードを返しました。ファイルへのモバイルリクエストの1.5%は応答を受け取れませんでした。モバイルリクエストの0.3%と0.1%のみが禁止（403）またはサーバーエラーレスポンスを受け取りました。デスクトップでのレスポンス分布も同様で、83.5%が200ステータスコードを返し、14.3%が404レスポンスコードを返しました。ファイルへのモバイルリクエストの1.7%は応答を受け取れませんでした。モバイルリクエストの0.3%と0.1%のみが禁止（403）またはサーバーエラーレスポンスを受け取りました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1570550482&format=interactive",
  sheets_gid="1390313757",
  sql_file="robots-txt-status-codes-2024.sql"
  )
}}

2022年以降、`robots.txt` ファイルが200ステータスコードを返すサイトの割合はわずかに増加しています。2024年では、モバイルサイトの `robots.txt` ファイルの83.9%が200ステータスコードを返し、デスクトップサイトは83.5%が200ステータスコードを返しました。これは2022年のモバイルサイト82.4%、デスクトップサイト81.5%から上昇しています。

このわずかな増加は、標準化が比較的最近の出来事であるにもかかわらず、過去30年の歴史がすでに広範な採用につながっていたことを示しています。

また、モバイルサイトとデスクトップサイトで200ステータスコードを返す割合の差は、2022年の1.1%から0.4%に縮小しました。この減少の理由について明確な結論を出すことはできませんが、考えられる説明の1つとして、以前の別個のモバイルサイトの普及から、モバイルレスポンシブデザインの原則の採用が進んだことが挙げられます。

HTTPステータスコードは `robots.txt` ファイルの機能に大きな影響を与えます。ファイルが4XXステータスコードを返す場合、クロール制限がないと見なされます。この動作に関する認識は、`robots.txt` ファイルへの404レスポンスが減少し続けていることからも継続的に高まっています。

2022年には、モバイルサイトの `robots.txt` ファイルの15.8%とデスクトップサイトの16.5%が404ステータスコードを返していました。2024年現在では、モバイルサイト訪問で14.1%、デスクトップサイトで14.3%に減少しています。この減少は200ステータスコードを返す `robots.txt` の増加と一致しており、より多くのサイトが `robots.txt` ファイルを実装することを決定したことを示唆しています。

2024年では、モバイルとデスクトップのクロールの1.7%と1.5%が応答を受け取れませんでした。Googleはこれらをサーバーによるエラーとして解釈します。

テストしたモバイルとデスクトップのリクエストの0.1%に対して、5xx範囲のエラーコードを受け取りました。これらのエラーコードはごくわずかな割合を表していますが、Googleにとっては検索エンジンが30日間サイト全体のクロールをブロックすると見なすことを意味します。30日後、検索エンジンは以前に取得したバージョンのファイルを使用するように戻ります。以前のキャッシュバージョンが利用できない場合、検索エンジンはサイトでホストされているすべてのコンテンツをクロールしたと見なされます。

このわずかなエラー率は、ほとんどの場合、単純なテキストファイル、または `robots.txt` ディレクティブを提供する多くの一般的なCMSシステムによって自動的に処理されるファイルが、大きな課題ではないことを示唆しています。

<aside class="note">注：上記のデータは、200ステータスコードを返す <code>robots.txt</code> ファイルがサイトに有益であるか、またはブロックすべきでない側面を許可またはブロックしているかどうかを示すものではありません。</aside>

#### `robots.txt` のサイズ

{{ figure_markup(
  image="robots-txt-size.png",
  caption="`robots.txt` のサイズ",
  description="`robots.txt` のサイズの分布を示すグラフ。100キロバイト単位で表示されています。デスクトップの1.66%、モバイルの1.59%のクロールで0サイズの `robots.txt` ファイルが返されました。モバイルでは、97.82%が0-100KBの範囲、0.31%が100-200KB、0.11%が200-300KB、0.07%が300-400KB、0.03%が400-500KB、0.06%が500KB以上となっています。デスクトップでは、97.80%が0-100KBの範囲、0.31%が100-200KB、0.10%が200-300KB、0.05%が300-400KB、0.02%が400-500KB、0.05%が500KB以上となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1259588862&format=interactive",
  sheets_gid="1616323575",
  sql_file="robots-txt-size-2024.sql"
  )
}}

`robots.txt` ファイルの大多数—モバイルクロールの97.82%、デスクトップクロールの97.80%—は100KB以下でした。

RFC 9309の標準によると、クローラーは `robots.txt` ファイルのサイズを制限する必要があり、パースの制限は少なくとも<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9309.html#name-limit">500 kiB</a>である必要があります。そのサイズ以下の `robots.txt` ファイルは完全にパースされるべきです。たとえば、Googleは[最大制限を500 kiBに設定](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#file-format)しています。この制限を超える `robots.txt` ファイルを持つサイトはごく少数（わずか0.06%）でした。その制限を超えた部分のディレクティブは検索エンジンによって無視されます。

興味深いことに、モバイルクロールの1.59%、デスクトップクロールの1.66%で0サイズの `robots.txt` ファイルが返されました。これは設定の問題である可能性が高いです。RFC 9303の仕様や一般的な検索エンジンクローラーのサポートドキュメントには記載されていないため、これがどのように処理されるかは不明です。サイトが `robots.txt` に対して空のレスポンスを返す場合、適切なルールを含む `robots.txt` ファイルを返すか、クローリングを制限したくない場合は、URLに対して[`404ステータスコード`](https://developer.mozilla.org/docs/Web/HTTP/Status/404)を返すのが賢明なアプローチでしょう。

#### `robots.txt` ユーザーエージェントの使用状況

{{ figure_markup(
  image="robots-txt-user-agent-usage.png",
  caption="`robots.txt` ユーザーエージェントの使用状況",
  description="`robots.txt` ファイルでもっとも一般的な `user-agent` ターゲットを示す棒グラフ。デスクトップでは * が76.6%、`AdsBot-Google` が9.1%、`AhrefsBot` が8.6%、`MJ12Bot` が6.7%、`Googlebot` が5.9%、`AdsBot-Google-Mobile` が4.6%、`Dotbot` が4.4%、`Nutch` が4.5%、`Pinterestbot` が4.1%、`AhrefsSiteAudit` が4.0%、`PetalBot` が3.4%、`GPTBot` が2.9%、`Mediapartners-Google` が2.3%、`Bingbot` が2.6%、最後に `CCBot` が2.7%。モバイルはデスクトップと一致しており、それぞれ76.9%、8.9%、8.8%、6.6%、6.4%、4.6%、4.9%、4.3%、3.9%、3.7%、3.8%、2.6%、3.0%、2.6%、2.4%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1672540926&format=interactive",
  sheets_gid="1705238622",
  sql_file="robots-txt-user-agent-usage-2024",
  width=600,
  height=594
  )
}}

##### `*` ユーザーエージェント

モバイルクロールで遭遇した `robots.txt` ファイルの76.9%、デスクトップクロールで発見されたファイルの76.6%が、包括的なユーザーエージェント `*` のルールを指定しています。これは2022年のデータ（デスクトップ74.9%、モバイルクロール76.1%）からわずかな上昇を示しています。考えられる説明として、`robots.txt` の可用性全体のわずかな増加が挙げられます。

`*` ユーザーエージェントは、クローラーの `user-agent` を具体的にターゲットとする別のルールセットがない限り、クローラーが従うべきルールを示します。`*` ユーザーエージェントを尊重しない注目すべき例外があり、Googleの[Adsbotクローラー](https://developers.google.com/search/docs/crawling-indexing/google-special-case-crawlers#adsbot-mobile-web)などが含まれます。他のクローラーは、`*` にフォールバックする前に別の一般的な `user-agent` を試します。たとえば、AppleのAppleBotは、指定されている場合は `Googlebot` のルールを使用し、指定されていない場合は `Applebot` を使用します。フォールバックに依存する際に期待通りの動作を確保するため、ターゲットとするクローラーのサポートドキュメントを確認することをオススメします。

##### Bingbot

2022年と同様に、`Bingbot` は再び指定されたもっとも多い `user-agent` のトップ10に入りませんでした。モバイルの2.7%とデスクトップの2.6%の `robots.txt` ファイルのみがその `user-agent` を指定し、14位に降格しました。

##### SEOツール

データによると、人気のSEOツールに対してルールを指定するサイトが増加しています。たとえば、`AhrefsBot` は現在モバイルクロールの8.8%で検出されており、2022年の5.3%から上昇しています。これは、Majesticの `MJ12Bot` を上回りました。`MJ12Bot` 自体も2022年の6.0%から6.6%に増加し、以前は具体的にターゲットとされた `user-agent` の中で2番目に人気でした。

##### AIクローラー

{{ figure_markup(
  image="robots-txt-ai-user-agents.png",
  caption="`robots.txt` AI `user-agent` の使用状況",
  description="`robots.txt` ファイルでもっとも一般的なAIユーザーエージェントターゲットを示す棒グラフ。デスクトップでは、`GPTBot` が2.9%、`CCBot` が2.7%、`Google-Extended` が2.5%、`Anthropic-Ai` が2.1%、`ChatGPT-User` が2.0%、`Claude-Web` が1.9%、`PerplexityBot` が0.2%。モバイルの数値はデスクトップよりもわずかに低く、それぞれ2.6%、2.4%、2.2%、1.7%、1.7%、1.6%、0.2%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=802856810&format=interactive",
  sheets_gid="1705238622",
  sql_file="robots-txt-user-agent-usage-2024"
  )
}}

過去2年間で、大規模言語モデル（LLM）やその他の生成システムが認知度と使用率の両方で勢いを増しています。人々は、トレーニングやその他の目的でデータを収集するために使用するクローラーに対してルールを指定することが増えているようです。

これらの中で、`GPTBot` がもっとも一般的に指定されており、モバイルクロールの2.7%で発見されています。次にもっとも一般的なのは `CCBot` で、これは<a hreflang="en" href="https://commoncrawl.org/ccbot">Common Crawlのエージェント</a>です。`CCBot` はAIのみに関連するものではありませんが、多くの人気ベンダーがこのクローラーから収集されたデータを使用してモデルをトレーニングしています。

まとめ：

- RFC 9309における `robots.txt` プロトコルの正式化により、技術標準への準拠が向上しました。
- 分析では、成功した `robots.txt` レスポンスの増加とエラーの減少が示されており、実装の改善を示しています。
- ほとんどの `robots.txt` ファイルは推奨サイズ制限内にあります。
- `*` `user-agent` が依然として主流ですが、`GPTBot` などのAIクローラーが増加しています。
- これらの洞察は、`robots.txt` の使用状況とSEOへの影響を理解するうえで貴重です。

### Robotsディレクティブ

[robotsディレクティブ](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag)は、個々のHTMLページがどのようにインデックスされ、配信されるかを制御する、きめ細かいページ固有のアプローチです。Robotsディレクティブは `robots.txt` ファイルと類似していますが異なります。前者はインデックス化と配信に影響を与える一方、`robots.txt` はクローリングに影響を与えるためです。ディレクティブが従われるためには、クローラーがページにアクセスできる必要があります。`robots.txt` ファイルで許可されていないページのディレクティブは読み取られず、従われない可能性があります。

#### Robotsディレクティブの実装

Robotsディレクティブタグは、検索結果で返されるページとその表示方法を管理するうえで重要です。Robotsディレクティブは2つの方法で実装できます：

1. ページの `<head>` にrobotsメタタグを配置する（たとえば、`<meta name="robots" content="noindex">`）
2. HTTPヘッダーレスポンスにX-Robots-Tag HTTPヘッダーを配置する

{{ figure_markup(
  image="robots-directive-implementation.png",
  caption="Robotsディレクティブの実装",
  description="robotsディレクティブ実装方法の分布を示す棒グラフ。デスクトップでは、45.5%のページがメタタグを使用し、0.6%がHTTPヘッダーを使用。0.4%が両方を使用。モバイルでは、46.2%のページがメタタグを使用し、0.7%がHTTPヘッダーを使用し、0.3%が両方を使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=368535821&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

どちらの実装方法も有効で、併用できます。メタタグ実装がもっとも広く採用されており、デスクトップページの45.5%、モバイルページの46.2%を占めています。[X-robots HTTPヘッダー](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag#xrobotstag)は1%未満のページに適用されています。少数のサイトが両方のタグを併用していました。これらはデスクトップページの0.4%、モバイルページの0.3%を占めていました。

2024年では：

- デスクトップページの0.4%、モバイルページの0.3%でレンダリングによってディレクティブの値が変更されました。
- 内部ページの方がrobotsディレクティブを持つ可能性が高くなっています。内部ページの48%がメタrobotsタグを含んでいるのに対し、ホームページは43.9%でした。
- レンダリングがホームページのrobotsディレクティブを変更する可能性（0.4%）は、内部ページ（0.3%）よりも高くなっています。

#### Robotsディレクティブルール

2024年には、スニペットのインデックス化と配信を制御するためにディレクティブで主張できる[24の有効な値](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag#directives)（ルールとして知られる）がありました。複数のルールは、別々のメタタグを介して組み合わせるか、メタタグと `X-robots` HTTPヘッダーの両方でカンマ区切りリストで組み合わせることができます。

ディレクティブルールの研究では、レンダリングされたHTMLに依存しました。

{{ figure_markup(
  image="robots-directive-rules.png",
  caption="Robotsディレクティブルール",
  description="デスクトップとモバイルページのレンダリングされたHTMLで見られるrobotsディレクティブルールの使用を比較する棒グラフ。デスクトップでは、54.7%が `follow` を使用、53.4%が `index` を使用、4.7%が `nonindex` を使用、2.5%が `nofollow` を使用、1.6%が `max-image-preview` を使用、1.6%が `max-snippet` を使用、1.2%が `max-video-preview` を使用、0.5%が `noarchive` を使用、0.2%が `nosnippet` を使用、0.01%が `notranslate` を使用、0.09%が `noimageindex` を使用。モバイルの割合も同様で、それぞれ56.0%、53.9%、3.9%、2.2%、1.8%、1.3%、1.1%、0.6%、0.3%、0.10%、0.01%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=2136589874&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql",
  width=600,
  height=690
  )
}}

2024年でもっとも目立ったルールは、`follow`（デスクトップ54.7%、モバイル56.0%）、`index`（デスクトップ53.4%、モバイル53.9%）、`noindex`（デスクトップ4.7%、モバイル3.9%）、`nofollow`（デスクトップ2.5%、モバイル2.2%）でした。これは注目に値します。なぜなら、「index」も「follow」ディレクティブも機能を持たず、<a hreflang="en" href="https://www.reddit.com/r/TechSEO/comments/1944d8k/comment/khdu3iw/">`Googlebot` によって無視される</a>からです。Googleの[robotsタグに関するドキュメント](https://developers.google.com/search/docs/crawling-indexing/special-tags)では、「デフォルト値はindex、followであり、指定する必要はありません」と助言しています。

robots `meta` タグの `name` 値は、ルールがどのクローラーに適用されるかを指定します。たとえば、`meta name="robots"` はすべてのボットに適用されますが、`meta name="googlebot"` はGoogleのみに適用されます。name属性の適用を分析するために、もっとも普及しているrobots `meta` ルールである `follow` タグで値が記述されている割合を調べました。

{{ figure_markup(
  image="name-attributes-in-follow-robots-meta-tag.png",
  caption="`follow` robotsメタタグのname属性",
  description="follow robotsメタタグでもっとも多いデスクトップとモバイルのname属性を比較する棒グラフ。モバイルでは、`Googlebot-News` という名前の属性が62%、`MSNBot` が64%、`robots` が60%、`Googlebot` が51%、`Bingbot` が35%の該当ページで使用。デスクトップも同様で、それぞれ66%、62%、61%、48%、18%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1651546987&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql"
  )
}}

robotsディレクティブでもっとも多く名前が挙げられた5つのクローラーは、汎用robots値、Googlebot、`Googlebot-News`、`MSNBot`、`Bingbot` でした。`follow` robots `meta` タグで使用されるname属性は、タグを持つサイトが特定のボットに合わせてルールを調整する傾向があることを示しています。一般的にデバイス間でわずかな差異がありましたが、Bingbotには大きな違いがあり、デスクトップ（18%）と比較してモバイルページ（35%）でfollowディレクティブが大幅に多く見られました。

{{ figure_markup(
  image="robots-directive-rules-by-name.png",
  caption="name属性値によるRobotsルール",
  description="モバイルページのrobotsディレクティブで名前が指定されたクローラーによるrobotsディレクティブルールを比較する棒グラフ。名前が指定されたボットはMSNBot、Googlebot-News、robots、Googlebot、Bingbot。値は次のように適用されました： `follow`: 64%, 62%, ,  60%, 51%, 35%。`index`: 55%, 63%, 59%, 52% 34%。`noindex`: 1%, 21%, 5%, 4%, 13%。`nofollow`: 1%, 6%, 2%, 2%, 5%。`nosnippet`: 0%, 12%, 0%, 1%, 1%。`max-snippet`: 0%, 0%, 40%, 2%, 16%。`max-video-preview`: 0%, 0%, 40%, 2%, 16%。`max-image-preview`: 0%, 1%, 69%, 2%, 17%。`noarchive`: 0%, 0%, 1%, 19%, 36%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=240042110&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql",
  width=600,
  height=548
  )
}}

robotsディレクティブルールをname属性で見ると、さまざまな適用率が見られます。これは、SEO担当者が個々の検索エンジンのインデックス化と配信を管理するために、特定のボット名によるディレクティブを採用していることを示しています。

ボット名によるルールの分析から得られた注目すべき要点は次のとおりです：

- `noarchive` ルールは `Bingbot` に圧倒的に適用され、36%でした。これは、このタグが<a hreflang="en" href="https://blogs.bing.com/webmaster/september-2023/Announcing-new-options-for-webmasters-to-control-usage-of-their-content-in-Bing-Chat">コンテンツをBingチャットの回答から除外する</a>機能を持つためと考えられます。
- `max-snippet`、`max-video-preview`、`max-image-preview` ルールは、すべてのロボットに対して広く実装されており、それぞれ40%、40%、69%の割合です。
- `Googlebot-News` は `index`（63%）と `nosnippet`（12%）でもっとも多く名前が挙げられました。
- `MSNBot` は `noindex` ディレクティブが与えられる可能性がもっとも低く（1%）でした。比較すると、もっとも可能性が高かったのは `Googlebot-News` の21%でした。
- 0.01%のサイトが無効なクローラー名「Google」を使用して `noindex` ルールを提供していました。Googleには、認識されるrobots `meta` タグに対して2つの有効なクローラー名があります：`Googlebot` と `Googlebot-News`。

### `IndexIfEmbedded` タグ
2022年1月、Googleは[新しいrobotsタグ](https://developers.google.com/search/blog/2022/01/robots-meta-tag-indexifembedded)である `indexifembedded` を導入しました。このタグはHTTPヘッダーに配置され、ページの構築に使用されるリソースのインデックス制御を提供します。このタグの一般的な使用例は、`noindex` タグが適用されている場合でも、ページのiframe内にコンテンツがある場合のインデックス化を制御することです。

`<iframe>` の存在は、`indexifembedded` robotsディレクティブが適用される可能性がある場合のベースラインを提供します。2024年では、モバイルページの7.6%が `<iframe>` 要素を含んでいました。これは2022年の4.1%から85%の注目すべき増加です。

{{ figure_markup(
  image="pages-with-iframe.png",
  caption="`<iframe>` を持つモバイルページ",
  description="分析されたコンテンツ内で `<iframe>` を利用したモバイルページが7.6%、`<iframe>` を使用しなかったページが92.4%であることを示す円グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=8221104&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql"
  )
}}

iframeを使用するほぼすべてのサイトが `indexifembedded` ディレクティブも使用しています。モバイルページのiframeヘッダーを調査したところ、99.9%が `noindex` ディレクティブを使用し、97.8%が `indexifembedded` を使用していました。

{{ figure_markup(
  image="indexifembedded-user-agents.png",
  caption="Indexifembeddedユーザーエージェント",
  description="indexifembedded実装の大部分がrobotsヘッダーを98.1%で使用し、`Googlebot` ユーザーエージェントをターゲットにしていることを示す棒グラフ。汎用robotsユーザーエージェントは0.2%でした。その他のユーザーエージェント（`Googlebot-News` と `Bingbot` を含む）は0%の使用率を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1844266050&format=interactive",
  sheets_gid="815806479",
  sql_file="robots-meta-usage-2024.sql"
  )
}}

2022年に見たように、`indexifembedded` ディレクティブは引き続き `Googlebot` にほぼ独占的に使用されています。robotsヘッダーの使用は2022年の98.3%から2024年の97.2%にわずかに減少しましたが、robotsタグの採用は2022年の66.3%から2024年の98.2%に大幅に増加しました。

### 無効な `<head>` 要素

検索エンジンクローラーはHTML標準に従い、`<head>` 内で無効な要素に遭遇すると、`<head>` を終了し、`<body>` が開始されたと見なします。これにより、重要なメタデータが発見されなかったり、不完全なレンダリングが発生したりする可能性があります。

早期に閉じられた `<head>` の影響は、問題のあるタグの位置がページロードごとに変わる可能性があるため、発見が困難な場合が多いです。壊れた `<head>` タグは、`canonical`、`hreflang`、`title` タグなどの欠落要素に関するレポートによって頻繁に特定されます。

{{ figure_markup(
  image="pages-with-invalid-HTML-in-head.png",
  caption="`<head>` 内の無効なHTML",
  description="デスクトップページの10.6%とモバイルページの10.9%がページの `<head>` 内に無効なHTML要素を持っていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=792944292&format=interactive",
  sheets_gid="1932961327",
  sql_file="invalid-head-sites-2024.sql"
  )
}}

2024年では、モバイルページの10.9%が `<head>` を破壊する無効なHTML要素を持っていました。これは2022年の12.6%から12%の減少を示しています。一方、`<head>` 内に無効なHTMLを持つデスクトップページは、2022年の12.7%から2024年の10.6%に減少しました。

{{ figure_markup(
  caption="`<head>` 内に無効なHTML要素を含むモバイルページ",
  content="10.9%",
  classes="big-number",
  sheets_gid="1932961327",
  sql_file="invalid-head-sites-2024.sql"
)
}}

[Google Search ドキュメント](https://developers.google.com/search/docs/crawling-indexing/valid-page-metadata)によると、`<head>` で使用できる有効な要素は8つあります。これらは次のとおりです：

1. `title`
2. `meta`
3. `link`
4. `script`
5. `style`
6. `base`
7. `noscript`
8. `template`

HTML標準では、上記以外の要素は `<head>` 要素内で許可されていません。[ドキュメント](https://developers.google.com/search/docs/crawling-indexing/valid-page-metadata#dont-use-invalid-elements-in-the-head-element)では、「Googleがこれらの無効な要素の1つを検出すると、`<head>` 要素の終了を想定し、`<head>` 要素内のそれ以降の要素の読み取りを停止します」と述べています。

{{ figure_markup(
  image="invalid-HEAD-elements.png",
  caption="無効な `<head>` 要素",
  description="`<head>` 内で無効なさまざまなHTML要素を持つページの割合を示す縦棒グラフ。デスクトップでは、`<img>` がページの29%でheadに使用され、`<div>` が11%、`<a>` が5%、`<p>` が3%、`<span>` が3%、`<iframe>` が3%、`<br>` が3%、`<input>` が2%、`<li>` が2%、最後に `<ul>` が2%。モバイルも非常に似ており、それぞれ22%、10%、5%、3%、3%、3%、3%、2%、2%、2%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1233734015&format=interactive",
  sheets_gid="233496461",
  sql_file="invalid-head-elements-2024.sql"
  )
}}

もっとも多い `<head>` を破壊するタグは `<img>` 要素で、この問題のデスクトップインスタンスの29%、モバイルインスタンスの22%に影響を与えました。比較すると、2022年の章では、`<img>` タグがモバイルページの10%とデスクトップページの10%で誤用されていることがわかりました。この違いは、サードパーティツールの非推奨実装方法によるものと考えられます。

誤用された `<div>` タグも2022年から大幅に増加しました。2024年では、デスクトップページの11%とモバイルページの10%が `<head>` 内に `<div>` 要素を持っていました。これは、無効な `<head>` がデスクトップページの4%とモバイルページの4%で発生した2022年から3倍以上の増加です。

## 正規化

正規化は、複数のバージョンが利用可能な場合に、ドキュメントの「優先」バージョンを特定するプロセスです。これは、ウェブサイトが異なるURLを通じて同じコンテンツにアクセスできる場合によく必要になります。HTTP/HTTPS、www/非www、末尾のスラッシュ、クエリパラメータ、その他のバリエーションなどです。

`canonical` タグは、検索結果でどのバージョンのコンテンツを返すかについて検索エンジンに対するシグナルです。メタロボットのようなディレクティブではありませんが、「強いヒント」として機能します。重複コンテンツを軽減し、ページバリエーションへのリンクなどのシグナルを統合し、ウェブマスターがコンテンツシンジケーションをより適切に管理できるようにすることで、SEOに利益をもたらします。

`canonical` タグの使用は2024年にわずかに増加しました。2022年では、モバイルページの61%とデスクトップページの59%が `canonical` タグを使用していました。2024年では、モバイルページの65%とデスクトップページの69%まで増加しました。

{{ figure_markup(
  image="canonical-usage.png",
  caption="Canonicalの使用状況",
  description="`canonical` が設定されているか正規化されているページの割合を強調する縦棒グラフ。`canonical` の採用率は、デスクトップで65%、モバイルで65%、正規化されているのはデスクトップで6%、モバイルで8%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=123125644&format=interactive",
  sheets_gid="1684654343",
  sql_file="pages-canonical-stats-2024.sql"
  )
}}

### Canonicalの実装

`canonical` タグには3つの[実装方法](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls)があります：

1. HTTPヘッダー内（Link HTTPヘッダー経由）
2. ページのHTMLの `<head>` セクション内
3. サイトマップ経由

HTML `<head>` タグの実装は、2つの特定のポイントで発生する可能性があります：

1. サーバーからのレスポンスで受信した生のHTML内のリンクとして
2. スクリプトが実行された後のレンダリングされたHTML内のリンクとして

各実装には独自のニュアンスがあります。HTTPヘッダーはPDFなどの非HTMLドキュメントで使用できますが、`rel="canonical"` は使用できません。さらに、サイトマップ経由のcanonicalは維持しやすい場合がありますが、ページ上の宣言よりも[弱いシグナル](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls#:~:text=Less%20powerful%20signal%20to%20Google%20than%20the%20rel%3D%22canonical%22%20mapping%20technique.)です。

`canonical` サイトマップ実装の分析には、宣言された `canonical` 値に関連する重複を特定する必要があります。熱心な研究者として、検索クローラーが `canonical` タグに遭遇する3つの場所について報告するよう分析を調整しました。`canonical` は最初にHTTPヘッダーで見つかり、次に生のHTMLで、最後にレンダリングされたDOMで見つかる可能性があります。

現在、モバイルページの1%のみがHTTPヘッダーを使用しており、2022年の1%から変わっていません。これは、実装にサーバー設定が必要なためと考えられます。代わりに、モバイルページの65%が `<head>` にネストされた `rel="canonical"` を使用しています。

`<head>` `canonical` タグを使用するほとんどのサイトは、生のHTMLとレンダリングされたHTMLの両方でそれらを実装しています。モバイルとデスクトップページの1%未満が、生のHTMLに `canonical` 要素が存在する（ただし、レンダリングされたHTMLには存在しない）状態でした。

{{ figure_markup(
  image="canonical-implementation.png",
  caption="Canonicalの実装方法",
  description="発見可能性の順序でcanonicalの実装方法を示す棒グラフ。HTTPのcanonicalは、デスクトップで1%、モバイルで1%ともっとも低い実装率でした。生のHTMLでのcanonical実装は、デスクトップで64%、モバイルで64%でした。レンダリングされたcanonicalの実装率は似ていますが、デスクトップで64%、モバイルで65%とわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=935126314&format=interactive",
  sheets_gid="1684654343",
  sql_file="pages-canonical-stats-2024.sql"
  )
}}

レンダリングされた `canonical` の実装は、2022年のモバイルの60%から2024年のモバイル使用率の65%に増加しました。デスクトップの使用率は2022年の58%から2024年の65%に増加し、デバイスタイプ間の採用率がほぼ同じになりました。

### Canonicalの競合

ページが `canonical` を送信する機会は3つありますが、シグナルを複数回送信すると競合が発生する可能性があります。たとえば、HTTPの `canonical` URLがレンダリングされたHTMLのものと一致しない場合、検索エンジンはコンテンツのプライマリバージョンが複数の場所に存在するというシグナルを受け取ります。これは要素の目的を損ない、[Googleによると未定義の動作](https://www.youtube.com/watch?v=bAE3L1E1Fmk&t=772s)を引き起こします。2022年では、これはページの0.4%に影響しました。現在、その割合は2024年に0.8%に倍増しています。

同様に、レンダリングは生のHTMLで見つかった `canonical` を変更する可能性があります。これはより一般的で、モバイルページの2.1%に影響します。HTTPヘッダーの `canonical` タグは、レンダリングプロセスで変更される可能性が低くなっています。2024年では、デスクトップページの0.6%とモバイルページの0.5%のみが、HTTPヘッダーで渡された `canonical` 値が変更されました。

`canonical` 要素が検出されたページのうち、98%が有効な `rel=canonical` のLighthouse監査に合格しました。

{{ figure_markup(
  image="canonical-inconsistency.png",
  caption="Canonicalの不整合",
  description="canonical宣言の一般的な問題を示す棒グラフ。Canonicalの不一致は、モバイルとデスクトップで同等に0.8%の割合で発生しました。レンダリングによってcanonicalが変更されたのは、デスクトップページの1.9%とモバイルページの2.1%でした。HTTPヘッダーが変更されたのは、デスクトップページの0.3%とモバイルページの0.2%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1354939448&format=interactive",
  sheets_gid="1684654343",
  sql_file="pages-canonical-stats-2024.sql"
  )
}}

不一致の `canonical` 値は、モバイルとデスクトップページの0.8%で発生しました。レンダリングは、モバイル（2.1%）よりもデスクトップ（1.9%）で `canonical` 要素を変更する可能性が高くなっています。HTTP `canonical` 要素は、めったに使用されませんが、デスクトップページの0.3%とモバイルページの0.2%でレンダリングプロセス中に変更されました。

## ページエクスペリエンス

簡単に言えば、ユーザーはウェブで良い体験を求めています。2020年、Googleはアルゴリズムにページエクスペリエンスを導入しました。このセクションでは、ページエクスペリエンスがどのように進化したかを見ていきます。

### HTTPS

Googleは[2014年にHTTPSをランキングシグナルとして採用](https://developers.google.com/search/blog/2014/08/https-as-ranking-signal)しました。<a hreflang="en" href="https://www.cloudflare.com/learning/ssl/what-is-https/">HTTPS</a>は通信を暗号化するプロトコルを使用します。これは、クロール時にサードパーティによって発行されたセキュア証明書の存在によって確立されます。採用は長年にわたって着実に増加し続けています。2024年では、デスクトップページの89%とモバイルページの88.9%がHTTPSプロトコルを使用していました。

{{ figure_markup(
  image="https-usage.png",
  caption="HTTPSをサポートするウェブサイトの割合",
  description="モバイルとデスクトップデバイス間のHTTPS使用率の割合を示す棒グラフ。デスクトップデバイスはHTTPS使用率が89%、モバイルは89%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=265531428&format=interactive",
  sheets_gid="1219126486",
  sql_file="lighthouse-seo-stats-2024.sql"
  )
}}

このトピックのより詳細な分析については、[セキュリティ](./security)の章を参照してください。

### モバイルフレンドリー

検索エンジンとウェブサイトには共通の目標があります。それは、ユーザーがいる場所でユーザーに会うことです。世界中に66億1000万人のモバイルユーザーがおり、世界の総人口の69.4%がモバイルデバイスを使用しています。

Google検索は、2015年から[モバイルフレンドリーを要件と見なして](https://developers.google.com/search/blog/2015/02/finding-more-mobile-friendly-search)います。検索エンジンは2023年に[モバイルファーストインデックス](https://developers.google.com/search/blog/2023/10/mobile-first-is-here)への7年間の移行を完了しました。

モバイルフレンドリーは、2つのタグの存在によって判断できます：

1. レスポンシブデザインで一般的に使用される[`Viewport` メタタグ](https://developer.mozilla.org/docs/Web/HTML/Viewport_meta_tag)
2. 動的配信で使用され、リクエストヘッダーに基づく[`Vary: User-Agent` ヘッダー](https://developer.mozilla.org/docs/Web/HTTP/Headers/Vary)

#### Viewportメタタグ

[`<meta name="viewport">`](https://developer.mozilla.org/docs/Web/HTML/Viewport_meta_tag)は、モバイル画面サイズに最適化し、[ユーザー入力の遅延を減らす](https://developer.chrome.com/docs/lighthouse/pwa/viewport/)ことができます。

<a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.9/meta-viewport">Viewportメタタグ</a>の使用は2024年も増加し続け、デスクトップページの92%とモバイルページの94%が `width` または `initial-scale` が設定された「viewportタグ」のLighthouseチェックに合格しました。これは、モバイルページの91%がタグを使用していた2022年の採用率から1%の増加でした。

{{ figure_markup(
  image="viewport-meta-tag.png",
  caption="Viewportメタタグの使用状況",
  description="`width` または `initial-scale` が設定された `<meta name=\"viewport\">` タグの使用状況を比較する縦棒グラフ。2024年では、該当するデスクトップページの92%とモバイルページの94%がこのLighthouse監査に合格しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1887654612&format=interactive",
  sheets_gid="1219126486",
  sql_file="lighthouse-seo-stats-2024.sql"
  )
}}

モバイルでのViewportメタタグの使用は、2022年の92%から2024年の94%に増加しました。

#### Varyヘッダーの使用状況

[`vary`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Vary) HTTPレスポンスヘッダーは、リクエスト元のユーザーエージェントに基づいて異なるコンテンツを提供できます。動的配信とも呼ばれるこのヘッダーにより、ページはリクエスト元のデバイスにもっとも適したコンテンツを返すことができます。

{{ figure_markup(
  image="vary-header-used.png",
  caption="Varyヘッダーの使用状況。",
  description="Varyヘッダーが使用されているかどうかを比較した縦棒グラフ。Varyヘッダーはデスクトップサイトの1%、モバイルサイトの2%で実装されています。一方、デスクトップページの99%、モバイルページの98%はVaryヘッダーを使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1933202461&format=interactive",
  sheets_gid="1427616506",
  sql_file="html-response-vary-header-used-2024.sql"
  )
}}

Varyヘッダーの使用率は2024年に大幅に低下しました。このヘッダーは2022年にはデスクトップページの12%、モバイルページの13%に表示されていました。現在では、デスクトップで1%、モバイルで2%にまで減少しています。この減少は、GoogleがJavaScriptで生成されたコンテンツに関連する問題に対して<a hreflang="en" href="https://developers.google.com/search/docs/crawling-indexing/javascript/dynamic-rendering">動的レンダリングは持続可能な長期的な解決策ではない</a>と具体的に述べているためと考えられます。代わりに、検索エンジンは<a hreflang="en" href="https://web.dev/articles/rendering-on-the-web#server-side">サーバーサイドレンダリング</a>、<a hreflang="en" href="https://web.dev/articles/rendering-on-the-web#static">静的レンダリング</a>、または<a hreflang="en" href="https://web.dev/articles/rendering-on-the-web#rehydration">ハイドレーション</a>などの単一ソリューションのレンダリング戦略を解決策として推奨しています。

### 判読可能なフォントサイズ

優れたモバイル体験の基本の1つは、ページ上のコンテンツを簡単に読めることです。12ピクセル未満のフォントサイズでは、モバイル訪問者はコンテンツを読むときに「ピンチしてズーム」する必要があり、これは判読するには小さすぎると見なされます。

{{ figure_markup(
  image="legible-font-sizes.png",
  caption="判読可能なフォントサイズ。",
  description="ホームページと内部ページでの判読可能なフォントサイズの使用状況を比較した棒グラフ。ホームページの91%、内部ページの92%が判読可能なフォントサイズの監査に合格しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1547833548&format=interactive",
  sheets_gid="1219126486",
  sql_file="lighthouse-seo-stats-2024.sql"
  )
}}

Lighthouseには、HTTP Archiveクロールの一部として実行される[判読可能なフォントサイズ監査](https://developer.chrome.com/docs/lighthouse/seo/font-size/)があります。この監査では、コンテンツの60%以上が12ピクセルを超えるフォントを使用しているページをチェックします。このテストはモバイルページに固有のもので、対象ページの92%が合格しました。この割合は、ホームページと内部ページの両方で一貫していました。

### Core Web Vitals

Core Web Vitals（CWV）は、ユーザーがページをどのように体験するかを測定するのに役立つ一連の標準化された指標です。Googleは最初に<a hreflang="en" href="https://developers.google.com/search/blog/2020/05/evaluating-page-experience">ページエクスペリエンスランキングシグナル</a>でランキング要素としてこれらを導入しました。この独立したシグナルは、<a hreflang="en" href="https://developers.google.com/search/docs/appearance/ranking-systems-guide#helpful-content">ヘルプフルコンテンツシステム</a>に吸収されたときに非推奨となり、その後コアアルゴリズムに組み込まれました。

Core Web Vitalsは、パフォーマンスに関連する3つの人間中心の質問に答えるように設計されています。

1. *ページは読み込まれていますか？*  [Largest Contentful Paint](https://web.dev/articles/lcp) （LCP）。
2. *ページはインタラクティブですか？*  [Interaction to Next Paint](https://web.dev/articles/inp) （INP）。
3. *ページの視覚は安定していますか？*  [Cumulative Layout Shift](https://web.dev/articles/cls) （CLS）

Core Web Vitalsは、数百万のウェブサイトにわたる実際のChromeユーザーのページ読み込みによって測定され、公開データセットである[Chrome User Experience Report](https://developer.chrome.com/docs/crux)（CrUX）を介して利用できます。

これらの指標は進化するように設計されています。 <a hreflang="en" href="https://web.dev/blog/inp-cwv-march-12">2024年3月</a> 、<a hreflang="en" href="https://web.dev/articles/inp">Interaction to Next Paint</a> （INP） は、ページでの最初のインタラクションの入力遅延のみを測定した以前の指標であるFirst Input Delay（FID）からインタラクティビティの主要な測定値として引き継ぎました。FIDは多くの理由で不正確な測定値であり、多くのサイト（とくにJavaScriptを多用するサイト）は、ユーザーに優れたインタラクティビティを提供していると誤って表示することがよくありました。その結果、多くのJavaScriptフレームワークでは、この変更により2024年に合格率が低下しています。ただし、現在<a hreflang="en" href="https://web.dev/articles/vitals-spa-faq">SPAはCore Web Vitalsによって正確に測定されていない</a>ことに注意が必要です。

{{ figure_markup(
  image="percent-of-good-cwv-experiences-on-mobile.png",
  caption="モバイルでの良好なCWVエクスペリエンスの割合。",
  description="モバイルのCore Web Vitalsの改善を経時的に示す時系列グラフで、すべてが上昇傾向にあります。現在、モバイルサイトの48%がCore Web Vitalsの良好なカテゴリに分類されます。また、59%が良好なLCP、79%が良好なCLS、74%が良好なINPを備えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=2000131031&format=interactive",
  sheets_gid="1166544354",
  sql_file="core-web-vitals-2024.sql"
  )
}}

CWV評価は、モバイルとデスクトップに分けられます。2024年には、モバイルサイトの48%が合格しました。合格サイトの割合は年々増加しており、2022年には39%、2021年には29%、2020年にはわずか20%でした。

個々の指標を見ると、59%がLargest Contentful Paintに合格し、74%がInteraction to Next Paintに合格し、79%のモバイルサイトがCumulative Layout Shiftに合格しています。

{{ figure_markup(
  image="percent-of-good-cwv-experiences-on-desktop.png",
  caption="デスクトップでの良好なCWVエクスペリエンスの割合。",
  description="デスクトップのCore Web Vitalsの改善を経時的に示す時系列グラフで、すべてが上昇傾向にあります。現在、デスクトップサイトの54%がCore Web Vitalsの良好なカテゴリに分類されます。また、72%が良好なLCP、71%が良好なCLS、97%が良好なINPを備えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1702819031&format=interactive",
  sheets_gid="1166544354",
  sql_file="core-web-vitals-2024.sql"
  )
}}

デスクトップデバイスは、帯域幅の広い接続を持つことが多いため、より寛容です。確かに、デスクトップCWV評価に合格するサイトは54%で、モバイルよりも8%多くなっています。個々の指標もはるかに高い合格率を示しており、LCPは72%、INPは97%、CLSは72%が合格しています。

Core Web Vitalsの詳細については、[パフォーマンス](./performance#core-web-vitals)の章をご覧ください。

### 画像の `loading` プロパティの使用状況

画像は、ページ読み込みに関してきわめて重要なコンポーネントです。画像の読み込みプロパティは、ブラウザがウェブページを構築する際にリソースの取得を優先するのに役立ちます。実装すると、ユーザーエクスペリエンスとパフォーマンスにメリットをもたらします。下流の改善には、コンバージョン率の向上やSEOの成功も含まれる場合があります。

{{ figure_markup(
  image="image-loading-properties.png",
  caption="画像の読み込みプロパティ。",
  description="デスクトップでさまざまな `loading` 属性値の使用状況を示す棒グラフ。`auto` は0%、`blank` は0%、`eager` は4%、無効な属性を持つものは0%、`lazy` は24%、読み込み属性がないものは72%です。モバイルの場合、`auto` は0.1%、`blank` は0%、`eager` は3%、`invalid` 属性を持つものは0.1%、`lazy` は25%、読み込み属性がないものは72%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=953333483&format=interactive",
  sheets_gid="1025550820",
  sql_file="image-loading-property-usage-2024.sql"
  )
}}

ほとんどのサイトはこれらの貴重なシグナルを使用しておらず、デスクトップページの71.9%、モバイルページの71.8%で画像の読み込みプロパティがありません。もっとも採用されている属性は `loading="lazy"` でした。<a hreflang="en" href="https://web.dev/articles/browser-level-image-lazy-loading">遅延読み込み</a>は、ウェブページ上の重要でない要素の読み込みを必要になるまで遅らせる手法です。これにより、ページの重さが軽減され、帯域幅とシステムリソースが節約されます。このタグは、2024年にはモバイルページの24.6%、デスクトップページの24.3%で使用されました。採用の増加は、<a hreflang="ja" href="https://caniuse.com/loading-lazy-attr">`loading` 属性がウェブ標準になった</a>ことによるものと考えられます。

`lazy` ローディングの対義語は、[`eager`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/img#eager) ローディングです。ブラウザはデフォルトで画像を `eager` ロードします。したがって、`eager` 属性を持つ画像と読み込み属性のない画像は同じように動作します。2024年、`eager` ローディングは2番目によく使用されるプロパティでしたが、モバイルページの3.4%、デスクトップページの3.6%にしか表示されませんでした。

{{ figure_markup(
  image="desktop-image-loading-property.png",
  caption="ホームページと内部ページでの画像の読み込みプロパティ。",
  description="デスクトップページでのさまざまな `loading` 属性値の使用状況を示す棒グラフ。ホームページでは、`auto` が0.1%、`blank` が0.0%、`eager` が1.8%、無効な属性を持つものが0.1%、`lazy` が11.0%、読み込み属性がないものが31.1%です。内部ページでは、それぞれ0.1%、0.0%、1.5%、0.0%、10.6%、33.2%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=917180585&format=interactive",
  sheets_gid="1025550820",
  sql_file="image-loading-property-usage-2024.sql",
  width=600,
  height=538
  )
}}

3番目の非推奨の値であるautoは標準化されず、Chromeのサポートから削除されました。現在は無効な値と見なされ、無視されます。

### iframe の `lazy` ローディングと `eager` ローディングの比較s

画像と同様に、iframeも<a hreflang="en" href="https://html.spec.whatwg.org/multipage/urls-and-fetching.html#lazy-loading-attributes">`loading` 属性</a>によって遅延読み込みできます。`img` のloading属性と同様に、`auto` は無効であり無視されます。

{{ figure_markup(
  image="iframe-loading-property-usage.png",
  caption="`iframe` のloadingプロパティの使用状況。",
  description="もっとも一般的な5つの `iframe` loadingプロパティを示す縦棒グラフ。デスクトップページの場合、92.8%がloading属性を宣言せず、4.0%が `lazy` とloading宣言なしの両方を使用した複数のiframeを持ち、2.6%が `lazy` のみを使用し、0.4%が `auto` と欠落した属性を持つ複数のiframeを持ち、0.1%が `eager` と欠落した属性を持つ複数のiframeを持っていました。モバイルも同様の動作を示し、それぞれ92.6%、3.9%、2.9%、0.3%、0.1%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=88529446&format=interactive",
  sheets_gid="660314947",
  sql_file="iframe-loading-property-usage-2024.sql"
  )
}}

1つ以上の `<iframe>` 要素を含むサイトのうち、デスクトップの92.8%と92.6%が読み込みプロパティを宣言していませんでした。`lazy` はもっとも顕著な宣言であり、ページ上に複数の `<iframe>` 要素がある場合に発生することがもっとも多かったです。デスクトップページの4.0%とモバイルページの3.9%に、`lazy` で読み込まれた `<iframe>` 要素と宣言のない `<iframe>` 要素が混在していることがわかりました。さらに、デスクトップページの2.6%とモバイルページの2.9%が、クロール中に発見されたすべての `<iframe>` 要素で `lazy` 属性を使用していました。

2022年には、デスクトップページの3.7%とモバイルページの4.1%が `lazy` loading属性を使用していました。この属性は、2024年にはデスクトップで6.6%、モバイルで6.9%に増加しました。

`<iframe>` 要素は、ページがホストされているサイトまたはサードパーティサービスのいずれかによって制御できるため、読み込み属性の組み合わせの普及は、サイトができる限り読み込み属性を採用していることを示唆しています。サードパーティが管理する `<iframe>` 要素は属性を持たない可能性が高いと考えるのが妥当です。

## オンページ

検索エンジン結果ページ（SERP）にどのページを返すかを決定する際、検索エンジンはページ上のコンテンツを主要な要因として考慮します。コンテンツの理解やユーザーのクエリとの関連性に影響を与える、さまざまなSEOのオンページ要素が存在します。

### メタデータ

オンページのコンテンツは、特定のクエリに対するページの関連性を測る主要な指標です。`title` 要素や `meta` ディスクリプションのような特定のHTML要素は、検索エンジン結果ページ（SERP）に表示される場合がありますが、多くの場合、これらはページのコンテンツに関するシグナルとしてのみ使用されます。

2021年、[Googleは検索結果において、より多くのウェブサイトの `title` タグを書き換え始めました](https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles)。検索エンジンがこれらのタグから直接コンテンツを使用する可能性が低くなるにつれて、その採用率は低下しています。

{{ figure_markup(
  image="title-tag-and-meta-description.png",
  caption="タイトル要素とメタディスクリプション。",
  description="`title` タグとメタディスクリプションを含むページの割合を示す縦棒グラフ。2024年では、デスクトップページの98%がタイトル要素を持ち、デスクトップページの66.7%がメタディスクリプションを持っていました。モバイルページの数値はほぼ同様で、98.2%がタイトル要素を持ち、66.4%がメタディスクリプションを持っていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1166495990&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

2022年では、デスクトップとモバイルページの98.8%が `title` タグを使用していました。2024年現在では、デスクトップページの98.0%が `title` タグを持ち、モバイルページの98.2%が持っています。同様に、`meta` `description` の使用率は、2022年のデスクトップとモバイルホームページの71%から、2024年のデスクトップの66.7%とモバイルホームページの66.4%に減少しました。

### `<title>` 要素

[`<title>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/title) 要素は、ブラウザタブに表示される名前を設定し、ページのコンテンツとクエリの関連性に関する最も強力なオンページ要素の1つです。

{{ figure_markup(
  image="title-words-by-percentile.png",
  caption="タイトルワード（パーセンタイル別）。",
  description="ページタイトル内の単語数の分布図。タイトルの中央値の単語数はデスクトップとモバイルの両方で12単語です。タイトルワードの数はデバイス間で均一で、10パーセンタイルで3単語、25パーセンタイルで7単語、75パーセンタイルで18単語でした。90パーセンタイルでは、モバイルは25単語、デスクトップは24単語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=522747427&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

{{ figure_markup(
  image="title-characters-by-percentile.png",
  caption="タイトル文字（パーセンタイル別）。",
  description="ページタイトル内の文字数の分布図。モバイルのタイトルは、10パーセンタイルを超えると一貫して文字数が多くなりました。文字数の中央値は、デスクトップで77文字、モバイルで79文字でした。10パーセンタイルでは、両方の形式で28文字でした。25パーセンタイルでは、文字数にわずかなずれがあり、デスクトップで46文字、モバイルで47文字でした。同様に、75パーセンタイルでは、デスクトップは116文字、モバイルは117文字でした。90パーセンタイルでは、デスクトップのタイトルには150文字、モバイルには155文字が含まれていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=432363175&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

`title` 要素の単語数はモバイルとデスクトップのエクスペリエンスで一貫していましたが、文字数は中央値でデスクトップの77単語に対してモバイルが79文字とわずかに多くなっていました。

### メタディスクリプションタグ

<a hreflang="en" href="https://moz.com/learn/seo/meta-description">`<meta name="description">`</a> タグはランキング要因ではありませんが、一部の検索エンジンとクエリにおいて、このタグ内のコンテンツがSERPに表示され、クリック率に影響を与える場合があります。

今日、Googleなどの検索エンジンは主に、クエリに基づいてページ上のコンテンツからSERPに表示するスニペットを作成しています。ある研究では、<a hreflang="en" href="https://portent.com/blog/seo/how-often-google-ignores-our-meta-descriptions.htm#:~:text=We%20found%20the%20rewrite%20rate,rank%20on%20the%20first%20page.">検索結果の最初のページで `meta` `description` の71%が書き換えられている</a>ことが示されています。

{{ figure_markup(
  image="meta-description-words-by-percentile.png",
  caption="メタディスクリプションの単語数（パーセンタイル別）。",
  description="デスクトップとモバイルの `meta` `description` 内の単語数の分布。10パーセンタイルでは4単語、25パーセンタイルでは17単語で分布は均等です。中央値のページは、デスクトップで40単語、モバイルで39単語です。75パーセンタイルでは、デスクトップページが52単語、モバイルページが51単語です。90パーセンタイルでは、デスクトップの `meta` `description` は81単語、モバイルページは79単語でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1576250923&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

{{ figure_markup(
  image="meta-description-characters-by-percentile.png",
  caption="メタディスクリプションの文字数（パーセンタイル別）。",
  description="デスクトップとモバイルの `meta` `description` 内の文字数の分布。10パーセンタイルでは、デスクトップが68文字、モバイルが67文字です。中央値のデスクトップページは272文字、中央値のモバイルページは271文字です。75パーセンタイルでは、デスクトップが68文字、モバイルが67文字です。90パーセンタイルでは、デスクトップが540文字、モバイルが531文字です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1699185211&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

2024年では：

- 中央値のデスクトップとモバイルページの `<meta name="description">` タグは、それぞれ40単語と39単語を含んでいました。これは2022年以降、モバイルで110%、デスクトップで105%の単語数増加を表しています。2年前は、デスクトップとモバイルの両方の中央値はわずか19単語でした。
- 中央値のデスクトップとモバイルページの `<meta name="description">` タグは、それぞれ272文字と271文字を含んでいました。これは2022年と比較して、両方のデバイスタイプで99%の増加となります。
- 10パーセンタイルでは、モバイルとデスクトップの `<meta name="description">` タグは4単語を含んでいました。
- 90パーセンタイルでは、`<meta name="description">` タグはデスクトップで81単語、モバイルで79単語を含んでいました。

### ヘッダー要素

ヘッダー要素は、ページのセマンティック構造を確立するために使用されます。これらはページのコンテンツを整理するのに役立つため、検索エンジンのページ理解にとって重要です。これらは階層順序に従い、`<h1>` はページ全体のコンテンツを記述し、`<h2>` や `<h3>` などのサブヘッダーはセクションやサブセクションを記述するために使用されます。

{{ figure_markup(
  image="presence-of-h-elements.png",
  caption="H要素の存在。",
  description="`<H1>` タグから `<H4>` タグまでの使用状況を示す縦棒グラフ。デスクトップでは、70%のページが `<H1>` タグを持ち、71%が `<H2>` タグを持ち、59%が `<H3>` タグを持ち、37%が `<H4>` タグを持っています。モバイルでは、それぞれ70%、70%、59%、36%とわずかに低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=441005695&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

ヘッダー要素は実装が簡単で、ユーザーとボットの理解を向上させるのに役立つため、広く採用されています。2024年のデスクトップページでは、70%が `<h1>` タグを持ち、71%が `<h2>` タグを持ち、59%が `<h3>` タグを持ち、37%が `<h4>` タグを持っていました。モバイルページも同様で、それぞれ70%、70%、59%、36%でした。

これらの数値は2022年から若干変化しています。2024年の注目すべき変化には、`<h1>` タグの採用増加があり、2022年の66%から増加しています。しかし、その後のヘッダーは使用率が減少しました。2024年に71%だった `<h2>` は、2022年には両方のデバイスタイプで73%でした。一方、2024年に59%と37%だった `<h3>` と `<h4>` タグは、2022年にはそれぞれ62%と38%と高い値でした。

{{ figure_markup(
  image="presence-of-non-empty-h-elements.png",
  caption="空でないH要素の存在。",
  description="空でない `<H1>` タグから `<H4>` タグまでの使用状況を示す縦棒グラフ。デスクトップでは、70%のページが `<H1>` タグを持ち、71%が `<H2>` タグを持ち、59%が `<H3>` タグを持ち、37%が `<H4>` タグを持っています。モバイルでは、それぞれ70%、70%、59%、36%とわずかに低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=2012049186&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

前年からの継続的な傾向として、空のままにされるヘッダー要素は比較的少数です。もっとも一般的な空のヘッダー要素は、デスクトップの `<h1>` で6%です。

### 画像

画像はウェブをより豊かな体験にします。中央値のページは14.5枚の画像を特徴としています（デバイスタイプ間でわずかな違いがあります）。画像の使用は、ホームページで顕著に多く、内部ページの10.5枚と比較して平均18.5枚の画像があります。

{{ figure_markup(
  caption="中央値のデスクトップホームページの画像数",
  content="19",
  classes="big-number",
  sheets_gid="1239720340",
  sql_file="image-alt-stats-2024.sql"
)
}}

画像の使用と重量の詳細については、[ページ重量](./page-weight)の章をご覧ください。

#### `alt` 属性

画像の `alt` 属性は、何らかの理由で画像を見ることができない人に画像に関する情報を提供します。その主な目的はアクセシビリティです。検索エンジンも、有用なコンテンツを提供できるため、画像のインデックス化にこのタグを使用します。したがって、altタグは検索エンジン結果ページで画像を配信し、ランク付けする際に考慮されます。

{{ figure_markup(
  image="percentage-of-img-alt-attributes-present.png",
  caption="`alt` タグが存在する `<img>` の割合。",
  description="`alt` 属性を実装した `<img>` タグを持つページの分布図。`alt` 属性を持つ画像の中央値の使用率は、デスクトップで58.3%、モバイルで57.8%です。10パーセンタイルでは両方とも0%、25パーセンタイルでは16.0%と15.5%、75パーセンタイルでは93.8%と94.2%、90パーセンタイルでは両方とも100%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1763319897&format=interactive",
  sheets_gid="1239720340",
  sql_file="image-alt-stats-2024.sql"
  )
}}

2024年の中央値のモバイルサイトは、画像の58%に `alt` 属性を持っていました。これは、モバイルページの54%がaltタグを使用していた2022年からわずかに上昇しています。

{{ figure_markup(
  image="percentage-of-img-with-blank-alt.png",
  caption="空の `alt` タグを持つ `<img>` の割合。",
  description="空の `alt` 属性を実装した `<img>` 要素を持つページの分布図。中央値では、モバイルの14%とデスクトップの14%が空の `alt` 属性を持っています。75パーセンタイルでは、これはモバイルの57%とデスクトップの57%に上昇します。90パーセンタイルでは、空の `alt` 属性がモバイルの91%とデスクトップの90%に現れました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=308025880&format=interactive",
  sheets_gid="1239720340",
  sql_file="image-alt-stats-2024.sql"
  )
}}

2024年には空の `alt` 属性が増加しました。2年前、中央値のページは0%の空の `alt` 属性を持っていました。現在の中央値は、デスクトップページの14%とモバイルの14%が空白のままです。75パーセンタイルでは、デスクトップの57%とモバイルの57%のページで空の `alt` 属性が見られました。

{{ figure_markup(
  image="percentage-of-img-missing-alt.png",
  caption="`alt` タグが欠落している `img` の割合。",
  description="`alt` 属性が欠落しているページ画像の分布図。画像の `alt` 属性が欠落している中央値は、デスクトップとモバイルサイトの両方で0%です。10パーセンタイルと25パーセンタイルでも、両方とも0%です。中央値を上回る（75パーセンタイル）では、デスクトップで16%、モバイルで15%です。最後に、90パーセンタイルでは、デスクトップの画像の65%、モバイルの68%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=897418305&format=interactive",
  sheets_gid="1239720340",
  sql_file="image-alt-stats-2024.sql"
  )
}}

2024年では、中央値のページはモバイルとデスクトップページの両方で、`alt` 属性の欠落がありませんでした。これは、デスクトップページの12%とモバイルページの13%で属性が欠落していた2022年からの注目すべき減少です。75パーセンタイルでは、デスクトップページの16%とモバイルページの15%が `alt` 属性を含んでいませんでした。2022年では、これはそれぞれ51%と53%でした。

`<img>` `alt` 属性の欠落の減少と空の属性の増加を組み合わせると、より多くのCMSインスタンスが各画像に `alt` 属性を含めている可能性があることを示唆しています。

### 動画

{{ figure_markup(
  image="percentage-of-pages-with-video.png",
  caption="動画を含むページの割合。",
  description="デスクトップサイトの5.4%とモバイルページの4.8%が動画を持っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1075984895&format=interactive",
  sheets_gid="1725966837",
  sql_file="pages-containing-a-video-element-2024.sql"
  )
}}

2024年では、`VideoObject` 構造化データマークアップを持つページはわずか0.9%でした。これは2022年の0.4%の率の倍以上ですが、動画を持つページの割合と、動画とスキーマの両方を持つページの間にはまだ大きなギャップがあることを意味します。

## リンク

ページ上のリンクは、検索エンジンによって多くの重要な方法で使用されています。

たとえば、検索エンジンがクロール用の新しいURLを発見するために使用する方法の1つは、すでにクロールして解析しているページから、それをターゲットとするリンクを見つけることです。

検索エンジンはランキングにもリンクを使用します。リンクは、それをターゲットとするリンクに基づいて、特定のURLがどれほど重要で関連性があるかの代理として機能します。これは、Googleが構築されたアルゴリズムである [PageRank](https://ja.wikipedia.org/wiki/PageRank) の基礎です。

リンクに関しては、より多くのリンクがより良いランキングと等しいという単純なケースではありません。それにはもっと多くのニュアンスがあります。最近では、ランキングに関してリンクはそれほど重要な要因ではありません。検索エンジンは、リンクに関係なく優れたコンテンツをより良く検出してランク付けし、同時に操作や[リンクスパム](https://developers.google.com/search/docs/essentials/spam-policies#link-spam)と戦うように進化しています。

### 説明的でないリンク

{{ figure_markup(
  image="pages-passing-links-have-descriptive-text.png",
  caption="リンクに説明的なテキストがあるLighthouseテストに合格したページ",
  description="ホームページでは、デスクトップの84%とモバイルの91%のページがLighthouseの「リンクの説明的テキスト」テストに合格しています。内部ページでは、デスクトップページの86%と内部ページの92%で非常に似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1375761573&format=interactive",
  sheets_gid="1219126486",
  sql_file="lighthouse-seo-stats-2024.sql"
  )
}}

リンクのアンカーテキスト（クリックするハイパーリンクされたテキスト）は、ユーザーと検索エンジンの両方がターゲットとなるリンクページのコンテンツを理解するのに役立ちます。「詳細情報」や「ここをクリック」などの説明的でないアンカーテキストは、固有の意味や文脈的な意味を持たず、SEOの観点から機会損失となります。また、アクセシビリティや支援技術を使用する人々にとっても良くありません。

Lighthouseは、ページに説明的でないリンクがあるかどうかを検出できます。2024年では、デスクトップの84%とモバイルの91%のページがこのテストに合格しました。内部ページでは、デスクトップページの86%とモバイルページの92%が合格しました。

デスクトップとモバイルの間にはわずかな不一致があり、これはおそらくモバイルページでは、同じターゲットへの他のリンクの補完的な役割を果たす可能性があるため、一般的に不適切に示されたコールトゥアクションリンクや「ここをクリック」または「続きを読む」といったコンテンツへの追加リンクが少ないことを示していると考えられます。

### 発信リンク

発信リンクは、異なるページにリンクする `href` 属性を持つ [`<a>` アンカー要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element/a) です。

{{ figure_markup(
  image="median-links-to-same-site.png",
  caption="同じサイトへのリンクの中央値数。",
  description="内部リンクの中央値カウントのランク分布。デスクトップでは、上位1,000サイトで129リンク、上位10,000サイトで122リンク、上位100,000サイトで86リンク、上位1,000,000サイトで71リンク、上位1,000万サイトで52リンク、全サイトで41リンクです。モバイルでは、それぞれ129、122、86、71、52、41リンクとわずかに低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=2081637553&format=interactive",
  sheets_gid="2137900612",
  sql_file="outgoing_links_by_rank-2024.sql"
  )
}}

内部リンクは、同じウェブサイトの他のページへのリンクです。デスクトップページがモバイルページよりも多くの内部リンクを持つという2022年からの傾向が続いています。これは、開発者が使いやすさと小さな画面に対応するために、モバイルでナビゲーションメニューとフッターを最小化していることに起因している可能性がもっとも高いです。

全体的に、ページ上の内部リンクの数は増加しており、上位1,000サイトのページは現在、2022年の106内部リンクと比較して、モバイルで129内部リンクを持っています。すべてのランクグループで同様のレベルの成長がありました。

[CrUXランキングデータ](./methodology#chrome-ux-report)によると、より人気のあるサイトがより多くの発信内部リンクを持っていることは明らかです。これは、より多く訪問されるサイトがより有用な内部リンクを持つより大きなエンティティであることと、より多くのページを処理するのに役立つ「メガメニュー」タイプのナビゲーションの開発への投資のためかもしれません。

{{ figure_markup(
  image="median-links-to-external-sites.png",
  caption="外部サイトへのリンクの中央値数。",
  description="外部リンクの中央値カウントのランク分布。デスクトップでは、上位1,000サイトで16リンク、上位10,000サイトで14リンク、上位100,000サイトで10リンク、上位1,000,000サイトで8リンク、上位1,000万サイトで7リンク、全サイトで6リンクです。モバイルでは、それぞれ11、11、8、7、6、6リンクとわずかに低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1915373603&format=interactive",
  sheets_gid="2137900612",
  sql_file="outgoing_links_by_rank-2024.sql"
  )
}}

外部リンクは、他のウェブサイトを指すリンクです。リンク数は[2022年の章](../2022/seo#fig-35)のものと非常に似たままです。1つまたは2つのリンクからなる非常にわずかな成長があります。

同様に、より人気のあるサイトはより多くの外部リンクを持つ傾向がありますが、再び差は非常にわずかです。

### アンカー `rel` 属性の使用

{{ figure_markup(
  image="anchor-rel-attribute-usage.png",
  caption="アンカー `rel` 属性の使用状況。",
  description="rel `noopener`、`nofollow`、`noreferrer`、`dofollow`、`sponsored`、`ugc`、`follow` を比較した縦棒グラフ。デスクトップでは、`noopener` がサイトの42.6%で使用され、`nofollow` が32.4%、`noreferrer` が24.5%、`dofollow` が0.4%、`follow` が0.4%、`sponsored` が0.4%、`ugc` が0.4%のサイトで使用されています。モバイルはほぼ同じで、それぞれ41.7%、32.7%、23.9%、0.5%、0.4%、0.4%、0.3%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1055504477&format=interactive",
  sheets_gid="1479524506",
  sql_file="anchor-rel-attribute-usage-2024.sql"
  )
}}

[`rel` 属性](https://developer.mozilla.org/ja/docs/Web/HTML/Attributes/rel)は、ページとそのリンク先との関係を決定します。SEOにおいて、`rel` 属性の主な用途は、ページとの関係を検索エンジンに通知することです。Googleはこれを[発信リンクの修飾](https://developers.google.com/search/docs/crawling-indexing/qualify-outbound-links)と呼んでいます。

2005年に初めて導入された[`nofollow`](https://developer.mozilla.org/ja/docs/Web/HTML/Attributes/rel#nofollow)属性は、ターゲットサイトと関連付けられたくない、また、あなたのページ上のリンクに基づいてクロールしてほしくないことを検索エンジンに通知することを目的としています。2024年では、この属性がページの32.7%に存在し、2022年の29.5%から増加しています。

より具体的な属性が2019年に導入されました。これには、スポンサードコンテンツへのリンクを示す `sponsored` と、（パブリッシャーではなく）ユーザーによって追加されたユーザー生成コンテンツへのリンクを示す `ugc` があります。これらの属性の採用は低いままです。2024年では、`sponsored` がわずか0.4%、`ugc` が0.3%でした。両方とも、実際には実在しない属性で検索エンジンに無視される `dofollow` と `follow` よりも人気が低いか同等でした。

興味深いことに、最も人気のある属性は `noopener` で、これはSEOとは関係なく、ブラウザーのタブやウィンドウで開かれたページが元のページにアクセスしたり制御したりすることを防ぐためのものです。さらに、SEOに影響を与えない `noreferrer` は、`Referrer` HTTPヘッダーの送信を阻止するため、リンクに固有のトラッキングパラメーターが存在しない限り、ターゲットサイトは訪問者がどこから来たかを知ることができません。

## 単語数

検索エンジンは単語数に基づいてサイトをランク付けしません。しかし、サイトにどれくらいのテキストが含まれているかを追跡するのに有用な指標であり、サイト所有者が見つけてもらいたいコンテンツを表示するためにクライアントサイドレンダリングにどれくらい依存しているかを見る代理指標でもあります。

### ホームページのレンダリング単語数

{{ figure_markup(
  image="home-page-visible-words-rendered-by-percentile.png",
  caption="パーセンタイル別のホームページの表示可能レンダリング単語数。",
  description="ホームページのレンダリングおよび表示可能コンテンツの単語数の分布。レンダリングされた単語数の中央値は、デスクトップで400語、モバイルで364語です。他のパーセンタイルでも、中央値の上下で、モバイルの方が同様ながらやや少ない単語数となっています。10パーセンタイルでは、デスクトップで76語、モバイルで69語です。25パーセンタイルでは、それぞれ192語と174語です。75パーセンタイルでは、それぞれ734語と678語です。そして90パーセンタイルでは、それぞれ1,260語と1,174語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1171813914&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

レンダリング単語数は、JavaScriptが実行された後のページ上の表示可能な単語の量です。2024年のモバイルホームページの中央値は364語を含み、デスクトップページの中央値は400語とわずかに多くなっています。これは、モバイルホームページの中央値が366語、デスクトップが421語だった2022年のデータからわずかに減少しています。

注目すべきは、モバイルとデスクトップのホームページ単語数の差が、2024年にはわずか36語まで縮まったことです。これは2022年の55語と比較したものです。これは、モバイルユーザーに提供されるコンテンツとの間にわずかながらより近いパリティを示唆しています。Googleは、主にモバイルユーザーエージェントでページをクロールしてインデックス化するモバイルファーストインデックス戦略への移行プロセスを完了しています。これが残りのいくつかのサイトにモバイル訪問者に完全なコンテンツを提供するよう促進したと結論づけるのが妥当です。

### 内部ページのレンダリング単語数

{{ figure_markup(
  image="inner-page-visible-words-rendered-by-percentile.png",
  caption="パーセンタイル別の内部ページの表示可能レンダリング単語数。",
  description="内部ページのレンダリングおよび表示可能コンテンツの単語数の分布。レンダリングされた単語数の中央値は、デスクトップで333語、モバイルで317語です。10パーセンタイルでは、デスクトップで76語、モバイルで64語です。25パーセンタイルでは、それぞれ159語と140語です。75パーセンタイルでは、それぞれ659語と667語です。そして90パーセンタイルでは、それぞれ1,219語と1,306語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=717477318&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

内部ページは全体的にやや少ない単語数を含んでいます。2024年のモバイル内部ページの中央値は、レンダリング後に317の表示可能単語を持ち、デスクトップ内部ページは333語でした。

ホームページと内部ページの間の注目すべき違いの1つは、デスクトップページが一般的に単語数の少ない範囲でモバイルページよりも多くの単語を持つ一方で、パーセンタイルが高くなるにつれてその差が縮まることです。たとえば、75パーセンタイルでは、モバイルページの方がデスクトップの内部ページよりも内部ページで多くの表示可能単語を持っています。

### ホームページの生単語数

{{ figure_markup(
  image="home-page-visible-words-raw-by-percentile.png",
  caption="パーセンタイル別のホームページの表示可能生単語数。",
  description="ホームページの生コンテンツ単語数の分布。レンダリングされた単語数の中央値は、デスクトップで330語、モバイルで311語です。他のパーセンタイルでも、中央値の上下で、モバイルの方が同様ながらやや少ない単語数となっています。10パーセンタイルでは、デスクトップで52語、モバイルで51語です。25パーセンタイルでは、それぞれ149語と142語です。75パーセンタイルでは、それぞれ614語と584語です。そして90パーセンタイルでは、それぞれ1,061語と1,016語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1250129544&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

生単語数は、JavaScriptが実行される前、およびDOMやCSSOMに他の変更が加えられる前の、サーバーからの最初のHTMLレスポンスに含まれる単語を表します。

レンダリング単語数と同様に、2024年には2022年からの小さな変化があります。2024年のページの生単語数の中央値は、モバイルユーザーエージェントで311語、デスクトップで330語でした。これは、モバイルで318語、デスクトップで363語だった2022年の中央値からわずかに減少しています。

### 内部ページの生単語数

{{ figure_markup(
  image="inner-page-visible-words-raw-by-percentile.png",
  caption="パーセンタイル別の内部ページの表示可能生単語数。",
  description="内部ページの生コンテンツ単語数の分布。レンダリングされた単語数の中央値は、デスクトップで284語、モバイルで278語です。10パーセンタイルでは、デスクトップで55語、モバイルで50語です。25パーセンタイルでは、それぞれ126語と116語です。75パーセンタイルでは、それぞれ586語と608語です。そして90パーセンタイルでは、それぞれ1,113語と1,220語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1963447811&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

ホームページと同様に、内部ページの表示可能生単語数は、75パーセンタイル以上でモバイルページがデスクトップページよりも多くの単語を含むことを含めて、レンダリング単語数の数値と非常によく一致しています。

生単語数とレンダリング単語数の両方のページにおけるこのパターンは、この傾向が無限スクロールとは無関係であることを示唆しています。無限スクロールは、モバイルレイアウトでパブリッシャーにとってより人気のある選択肢です。

### ホームページのレンダリング対生単語数

{{ figure_markup(
  image="rendered-vs-raw-home-page-visible-words.png",
  caption="ホームページのレンダリング対生の表示可能単語数。",
  description="ホームページの生対レンダリング単語数の分布。デスクトップでは、10パーセンタイルで生とレンダリング単語数の間に32%の差があり、25パーセンタイルで22%の差、中央値で18%の差、75パーセンタイルで16%の差、90パーセンタイルで16%の差があります。モバイルでは、それぞれ26%、18%、15%、14%、14%の差があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=847900289&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

ホームページでレンダリング表示可能単語数と生単語数を比較すると、驚くほど小さな差異があり、中央値でモバイルが13.6%、デスクトップが17.5%の差を示しています。

デスクトップユーザーエージェントに提供されるホームページは、レンダリング後にモバイルと比較してわずかに高い割合の単語が表示されます。1つの可能な要因は、モバイルレイアウトがタブやアコーディオンを採用することが多く、コンテンツがDOMにあっても視覚的に隠されているため、表示可能として表示されないことです。

単語数が多いほど、レンダリング単語数と生単語数の差が小さくなるという興味深い傾向があります。これは、長文コンテンツのパブリッシャーにとって、サーバーサイドレンダリング技術がクライアントサイドレンダリングよりも相対的に人気があることを示唆している可能性があります。

### 内部ページのレンダリング対生単語数

{{ figure_markup(
  image="rendered-vs-raw-inner-page-visible-words.png",
  caption="内部ページのレンダリング対生の表示可能単語数。",
  description="内部ページの生対レンダリング単語数の分布。デスクトップでは、10パーセンタイルで28%の差があり、25パーセンタイルで21%の差、中央値で15%の差、75パーセンタイルで11%の差、90パーセンタイルで9%の差があります。モバイルでは、それぞれ22%、17%、12%、9%、7%の差があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=660250521&format=interactive",
  sheets_gid="1745108356",
  sql_file="seo-stats-by-percentile-2024.sql"
  )
}}

やや驚くことに、内部ページではレンダリング単語数と生単語数の間にさらに狭い差があり、これらのページが大量のクライアントサイドレンダリングコンテンツを含む可能性が低いことを示唆しています。

差は狭いものの、単語数が多いほどクライアントサイドレンダリングへの依存が少なくなるという同じパターンに従っています。

## 構造化データ

構造化データは、多くのサイトを最適化するために重要なものであり続けています。それ自体はランキング要因ではありませんが、とくにGoogleでリッチリザルトを支えることがよくあります。

これらの強化されたリスティングは、サイトやその要素の1つを目立たせることがよくあります。さらに、正しく実装された構造化データは、たとえば他の検索エンジンでも表示できます。

今年のクロールに内部ページが追加されたことは、構造化データにとってとくに重要です。多くのタイプは特定のページにのみ適用されるためです。

### ホームページ

{{ figure_markup(
  image="home-page-raw-vs-rendered-structured-data.png",
  caption="ホームページの生対レンダリング構造化データ。",
  description="ホームページの生対レンダリングに基づく構造化データの変化を示す縦棒グラフ。デスクトップページでは、ホームページの47%が生の構造化データを持ち、48%がレンダリングされた構造化データを持っています。さらに、ホームページの2%はページがレンダリングされたときのみ構造化データを持ち、ホームページの6%ではレンダリングが構造化データを変更します。モバイルでは、それぞれ48%、49%、2%、5%とほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=361913740&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

構造化データの全体的な使用量は、2024年にモバイルホームページの49%、デスクトップホームページの48%まで増加しました。これは、クロールされたモバイルホームページの47%、デスクトップホームページの46%が構造化データを持っていた2022年からのわずかな増加でした。

サイトの大部分は生のHTMLで構造化データを提供しており、ホームページのモバイルとデスクトップクロールのわずか2%のみがJavaScript経由で追加された構造化データを持っています。

さらに少しのホームページ、モバイルクロールの5%、デスクトップクロールの6%が、JavaScriptによって変更または拡張された構造化データを含んでいました。

トレンドは、生のHTMLで構造化データマークアップを提供することのようです。これは、ベストプラクティスではないにしても、おそらく構造化データを実装するもっとも簡単で信頼できる方法として[Google自身が強調](https://developers.google.com/search/updates#clarifying-dynamically-generated-product-markup)していることです。

### 内部ページ

{{ figure_markup(
  image="inner-page-raw-vs-rendered-structured-data.png",
  caption="内部ページの生対レンダリング構造化データ。",
  description="内部ページの生対レンダリングに基づく構造化データの変化を示す縦棒グラフ。内部ページでは、デスクトップページの50%が生の構造化データを持ち、51%がレンダリングされた構造化データを持っています。さらに、内部ページの2%はページがレンダリングされたときのみ構造化データを持ち、内部ページの6%ではレンダリングが構造化データを変更します。モバイルでは、それぞれ50%、52%、2%、5%とほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=361913740&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

商品ページやイベントページなどの内部ページは、構造化データを持つ可能性が高くなります。2024年には、モバイルの53%、デスクトップ内部ページの51%が何らかの構造化データマークアップを持っていました。そして、構造化データに基づくリッチリザルトの適格性を詳しく説明するGoogleの開発者ドキュメントが多数あるという事実とうまく適合しています。

全体的に、生のHTMLでマークアップを提供するトレンドは、ホームページクロールで見られたものから引き継がれています。

{{ figure_markup(
  image="home-page-structured-data-markup-formats.png",
  caption="ホームページ構造化データマークアップフォーマット。",
  description="ホームページの構造化データタイプを示す縦棒グラフ。JSON-LDは、デスクトップページの40.5%、モバイルページの40.4%で見つかります。Microdataは、デスクトップページの17.4%、モバイルページの18.8%で見つかります。RDFaは、デスクトップページの0.9%、モバイルページの0.8%で見つかり、Microformats2は、デスクトップページのわずか0.1%、モバイルページの0.2%で見つかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=542370994&format=interactive",
  sheets_gid="1441645144",
  sql_file="structured-data-formats-2024.sql"
  )
}}

{{ figure_markup(
  image="inner-page-structured-data-markup-formats.png",
  caption="内部ページ構造化データマークアップフォーマット。",
  description="内部ページの構造化データタイプを示す縦棒グラフ。JSON-LDは、デスクトップページの36.6%、モバイルページの35%で見つかります。Microdataは、デスクトップページの20.1%、モバイルページの20.2%で見つかります。RDFaは、デスクトップページの2.0%、モバイルページの1.8%で見つかり、Microformats2は、デスクトップページの0.2%、モバイルページの0.4%で見つかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=542370994&format=interactive",
  sheets_gid="1441645144",
  sql_file="structured-data-formats-2024.sql"
  )
}}

ページに構造化データを実装する方法は数多くありますが、JSON-LDはホームページで圧倒的にもっとも人気のフォーマットです。クロールされたモバイルの40%、デスクトップホームページの41%を占めています。

これは単純にもっとも実装しやすいフォーマットで、HTML構造から独立した `<script>` 要素を追加することで行われます。Microdataなどの他のフォーマットは、ページのHTML要素に属性を追加することを含みます。Googleが推奨フォーマットとしてJSON-LDの使用をアドバイスしているため、これがもっとも人気のある実装であることは驚くことではありません。

大部分において、内部ページも同様にJSON-LDを使用していますが、それらのページではMicrodataを使用した構造化データの使用がわずかに増加しています。

### もっとも人気のホームページ構造化データタイプ

{{ figure_markup(
  image="most-popular-home-page-schema-types.png",
  caption="もっとも人気のホームページスキーマタイプ。",
  description="ホームページのもっとも人気の15のスキーマタイプを示す縦棒グラフ。デスクトップでは、ページの `schema.org/WebSite` が35%、`schema.org/SearchAction` が29%、`schema.org/WebPage` が25%、`schema.org/Organization` が25%、`schema.org/-UnknownType-` が24%、`schema.org/ListItem` が20%、`schema.org/BreadcrumbList` が20%、`schema.org/ImageObject` が19%、`schema.org/EntryPoint` が18%、`schema.org/ReadAction` が14%、`schema.org/PostalAddress` が8%、`schema.org/SiteNavigationElement` が6%、`schema.org/WPHeader` が6%、`schema.org/Person` が5%、`schema.org/WPFooter` が5%で見つかりました。モバイルでは、それぞれ35%、28%、25%、24%、23%、20%、20%、20%、18%、14%、8%、7%、6%、5%、5%のページで見つかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1774876613&format=interactive",
  sheets_gid="1091913261",
  sql_file="structured-data-schema-types-2024.sql",
  width=600,
  height=594
  )
}}

2022年と比較して、ホームページで見つかった構造化データタイプの人気に関して、2024年に大きな変化はありませんでした。`WebSite`、`SearchAction`、`WebPage` は、GoogleのSitelinks Search Boxを支えるため、引き続き3つのもっとも人気のあるスキーマタイプでした。

興味深いことに、`WebSite` は2024年にモバイルホームページの35%まで少し成長しました。これは2022年の30%からの増加で、GoogleがSERPで[サイト名](https://developers.google.com/search/docs/appearance/site-names)に影響を与える方法としてこれを推奨しているためです。

もっとも人気のあるスキーマタイプの実装に関しては、モバイルとデスクトップの構造化データ使用率の間にわずかな違いがありました。

### もっとも人気の内部ページ構造化データタイプ

{{ figure_markup(
  image="most-popular-inner-page-schema-types.png",
  caption="もっとも人気の内部ページスキーマタイプ。",
  description="内部ページのもっとも人気の15のスキーマタイプを示す縦棒グラフ。デスクトップでは、ページの `schema.org/ListItem` が31%、`schema.org/BreadcrumbList` が30%、`schema.org/WebSite` が29%、`schema.org/WebPage` が27%、`schema.org/-UnknownType-` が28%、`schema.org/Organization` が27%、`schema.org/ImageObject` が24%、`schema.org/SearchAction` が19%、`schema.org/EntryPoint` が16%、`schema.org/ReadAction` が15%、`schema.org/Person` が10%、`schema.org/Article` が6%、`schema.org/SiteNavigationElement` が7%、`schema.org/WPHeader` が6%、`schema.org/WPFooter` が5%で見つかりました。モバイルでは、それぞれ30%、30%、28%、27%、27%、27%、24%、19%、16%、15%、12%、7%、7%、6%、6%のページで見つかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1786706905&format=interactive",
  sheets_gid="1091913261",
  sql_file="structured-data-schema-types-2024.sql",
  width=600,
  height=594
  )
}}

内部ページに関して、`ListItem` は2024年にもっとも人気のスキーマタイプで、モバイルの30%、デスクトップURLの31%を占めました。商品、イベント、記事ページなどの「リーフ」ページよりも、リスティングページの方が多いというのは理にかなっています（ただし、`Article` スキーマは12番目にもっとも人気のあるタイプでした）。

`BreadcrumbList` は2番目にもっとも人気のスキーマタイプでした。内部ページでパンくずリストを表示する可能性が高いため、これは予想されることでした。

驚くことは、少なくともGoogleにとってホームページ固有の `WebSite` 構造化データが、内部ページで3番目にもっとも人気のスキーマタイプだったことです。考えられる説明は、その特定の構造化データタイプがサイトテンプレートレベルで実装され、サイト全体に引き継がれることが多いということです。

より人気のあるスキーマタイプ以外では、`product` 構造化データがモバイルページの4%、デスクトップページの5%で見つかりました。

ウェブ上の構造化データの詳細については、[構造化データ](./structured-data)の章をご覧ください。

## AMP

Accelerated Mobile Pages（AMP）は、とくにモバイルページに対して確実なパフォーマンスを提供するページ構築のフレームワークです。モバイルページ向けに設計されていますが、AMPを使用してすべてのデバイス向けのWebサイトを構築することも十分可能です。

しかし、これはいくぶん議論を呼ぶ技術でもあり、多くの人がページの別バージョンを維持する負担を感じています。さらに、パブリッシャーやサイト所有者が苦労しているAMPのパフォーマンスにはいくつかの制限があります。

直接的なランキング要因ではありませんが、過去にはGoogleのトップストーリーなどの特定の機能は、AMPバージョンを持つことに依存していたか、少なくとも影響を受けていました。

### ホームページでの使用

{{ figure_markup(
  image="amp-markup-on-desktop-vs-mobile-home-pages.png",
  caption="デスクトップ対モバイルホームページのAMPマークアップ",
  description="デスクトップおよびモバイルホームページのAMPマークアップ属性の割合を示す縦棒グラフ。HTML AMP属性はデスクトップページの0.04%で使用されています。HTML AMP & 絵文字属性はデスクトップページの0.01%で使用され、HTML AMPまたは絵文字属性は0.05%のデスクトップページで使用され、Rel AMP HTMLタグは0.37%のデスクトップページで使用されています。モバイルでは、それぞれ0.27%、0.06%、0.33%、0.63%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=491118415&format=interactive",
  sheets_gid="693330825",
  sql_file="mark-up-stats-2024.sql"
  )
}}

[Core Web Vitals](https://web.dev/articles/vitals)（CWV）の登場により、非AMPページのパフォーマンスを定量化する能力が可能になったことで、トップストーリーなどの検索結果で貴重な不動産を獲得するためのAMPの要件は消失し、メリットの多くも失われました。

そのため、`amp` html属性を含むページの割合にわずかな上昇があったのは少し驚きです。2024年には、モバイルクロールで2022年の0.19%と比較して0.27%に上昇しました。しかし、デスクトップクロールは2022年の0.07%から0.04%に下降しました。

これらの数字は比較的小さいため、変化は統計的に有意ではない可能性がありますが、この技術の採用が低いことを示しています。

### ホームページ対内部ページ

{{ figure_markup(
  image="amp-markup-home-vs-inner-pages.png",
  caption="AMPマークアップのホームページ対内部ページ。",
  description="ホームページと内部ページのAMPマークアップ属性の割合を示す縦棒グラフ。HTML AMP属性はデスクトップのホームページの0.31%で使用されています。HTML AMP & 絵文字属性は0.07%で使用され、HTML AMPまたは絵文字属性は0.38%で使用され、Rel AMP HTMLタグは1.01%で使用されています。モバイルでは、それぞれ0.21%、0.03%、0.24%、2.15%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1013706420&format=interactive",
  sheets_gid="693330825",
  sql_file="mark-up-stats-2024.sql"
  )
}}

ホームページは内部ページよりもクロールされたときにAMPページである可能性が高く、モバイルとデスクトップ全体でホームページの0.31%、内部ページではわずか0.21%がHTML AMP属性を持っています。

## 国際化

国際化は、複数の国、言語、または地域をターゲットにするためにWebサイトを最適化し、検索エンジンによる適切なクロールとインデックス作成を確保するプロセスです。これには、正しいオーディエンスにコンテンツを配信するためのベストプラクティスの採用が含まれます。

[Googleなどの現代の検索エンジンは、表示されるコンテンツからページの言語を決定できます](https://developers.google.com/search/docs/specialty/international/managing-multi-regional-sites)。さらに、ナビゲーション要素で使用される言語も検出できます。

それでも、たとえばドイツ語話者のオーディエンスをターゲットにした英語コースなど、検索エンジンが適切な言語を特定するのは混乱を招く場合があります。その場合、ページコンテンツは英語ですが、ターゲットオーディエンスは異なる国のドイツ語話者になります。

したがって、`hreflang` タグやcontent-language属性などの国際化メカニズム（HTTPヘッダー、HTML、またはサイトマップ経由）の主な目的は、混乱を避け、検索エンジンが正しいオーディエンスにコンテンツを配信するのを支援することです。

### `hreflang` 実装

`hreflang` タグは、特定のページの主要な言語が何であるかを検索エンジンが理解するのに役立ちます。そのSEO応用は、異なる（ただし関連する）Webサイト間で適切な言語を使用して、異なる国や地域をターゲットにできることです。

`hreflang` タグ実装の分析により、デスクトップとモバイルの両方で、0.1%のWebサイトが `hreflang` タグ内でHTTPプロトコルを使用していることが明らかになりました。これは、国際化されたWebサイトの小さな部分がまだHTTPS標準を採用していないことを示しています。

その結果、HTTPの使用は、検索エンジンがページコンテンツを正しく解釈する際に混乱を引き起こす可能性のある不整合を引き起こす可能性があります。

さらに、タグの生バージョンとレンダリングバージョンの間には注目すべき相違があります。デスクトップでは0.1%の差（生9.5%対レンダリング9.6%）、モバイルでは0.2%の差（生9.1%対レンダリング9.2%）が存在します。

{{ figure_markup(
  image="hreflang-implementation.png",
  caption="`hreflang` 実装。",
  description="デスクトップとモバイルサイトの `hreflang` 実装を比較した棒グラフ。HTTP `hreflang`：0.1%（デスクトップ）と0.1%（モバイル）；生 `hreflang`：9.5%（デスクトップ）と9.1%（モバイル）；レンダリング `hreflang`：9.6%（デスクトップ）と9.2%（モバイル）を示しています",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=1478193310&format=interactive",
  sheets_gid="144160625",
  sql_file="seo-stats-2024.sql"
  )
}}

`hreflang` タグの「生」バージョンと「レンダリング」バージョンの間の相違は、コンテンツの適切なレンダリングを妨げる技術的な問題があることを示しており、これは検索エンジンがそれをどのように解釈するかに影響します。

これらの相違が軽微と考えられる場合でも、トラフィックの多いWebサイトや公共にとって重要な情報を含むWebサイト（国際機関、研究機関、大学など）は、意図されたオーディエンスとの可視性において重大な損失を経験する可能性があります。

### ホームページ `hreflang` 使用

検索エンジンはページの言語を独自に検出できることが多いですが、`hreflang` タグはコンテンツが意図されたオーディエンスに確実に届くように明示的なシグナルを提供します。これらのタグは通常、Webサイトが異なるロケールや地域をターゲットにした複数の言語バージョンを持つ場合に使用されます。

現在、デスクトップWebサイトの10%とモバイルWebサイトの9%が `hreflang` を利用しています。これは、デスクトップとモバイルでそれぞれ10%と9%の使用率だった2022年からのわずかな増加を表しています。

2024年でもっとも人気の `hreflang` 値は「en」（英語）で、デスクトップで8%、モバイルで8%の使用率を示しました。その特定のタグは、デスクトップで5%、モバイルで5%の使用率だった2022年から大幅な成長を経験しました。

{{ figure_markup(
  image="hreflang-link-usage-home-pages.png",
  caption="ホームページの `hreflang` リンク使用。",
  description="ホームページの `hreflang` リンクを言語コードとプラットフォーム（デスクトップ対モバイル）で分類して示す水平棒グラフ。各タグの合計値は、en（7.6%）、fr（3.0%）、de（3.0%）、es（2.8%）、en-us（2.4%）、it（2.2%）、ru（1.9%）、en-gb（1.5%）、pt（1.4%）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=725111256&format=interactive",
  sheets_gid="1291250464",
  sql_file="hreflang-link-tag-usage-2024.sql",
  width=600,
  height=594
  )
}}

enのもっとも一般的なバリエーションは、en-us（アメリカ英語）でデスクトップ2.8%、モバイル2.4%、en-gb（イギリス英語）でデスクトップ1.7%、モバイル1.5%です。

enに続いて、デフォルト言語バージョンを指定するx-defaultタグが次にもっとも人気のタグです。その後、fr（フランス語）、de（ドイツ語）、es（スペイン語）がもっとも頻繁に使用される `hreflang` 値で、これは2022年の調査結果と類似しています。

### 内部ページ `hreflang` 使用

{{ figure_markup(
  image="hreflang-link-usage-secondary-pages.png",
  caption="内部ページでの `hreflang` リンク使用",
  description="内部ページでの `hreflang` リンクの使用を言語コードとプラットフォーム（デスクトップ対モバイル）で分類して示す水平棒グラフ。各タグの合計値は、x-default（7.3%）、en（7.1%）、fr（3.0%）、de（3.0%）、es（2.8%）、en-us（2.4%）、it（2.2%）、ru（1.9%）、en-gb（1.4%）、pt（1.3%）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=725111256&format=interactive",
  sheets_gid="1291250464",
  sql_file="hreflang-link-tag-usage-2024.sql",
  width=600,
  height=594
  )
}}

内部ページでの `hreflang` タグの使用では、x-default（7.3%）とen（英語、7.1%）がもっとも一般的な値です。値をモバイルとデスクトップで分類すると、x-defaultでデスクトップ8.0%、モバイル7.3%、enでデスクトップ8.0%、モバイル7.1%となります。

内部ページでのほとんどの `hreflang` 値において、デスクトップの使用率はモバイルよりもわずかに高くなっています。差は非常に小さいです。frを除いて、他の `hreflang` 値（de、es、en-us、it、ru、en-gb、pt）は3.0%未満の使用率で、もっとも一般的な値への集中度を示しています。

分布に関しては、内部ページでの `hreflang` タグの使用は、ホームページで見つかったものと類似しています。x-defaultとenは両方のカテゴリーで採用をリードしており、そのグローバルな到達範囲を強調しています。これらの割合は内部ページで低くなっており、`hreflang` 実装は一般的にホームページで優先されることを示唆しています。

### コンテンツ言語使用（HTMLとHTTPヘッダー）

[Google](https://developers.google.com/search/docs/specialty/international)や<a hreflang="ru" href="https://webmaster.yandex.ru/blog/15326">>Yandex</a>などの検索エンジンは `hreflang` タグのみを使用しますが、他の検索エンジンは[content-language属性](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Language)も使用します。これは2つの方法で実装できます：

- HTML
- HTTPヘッダー

{{ figure_markup(
  image="language-usage-combined-by-device.png",
  caption="モバイルとデスクトップの言語使用（htmlとhttpヘッダー）。",
  description="ページの割合として言語使用を示す棒グラフ。モバイルでは、enがデータセット内のページの18%で使用され、続いてpt-brが9%、en-usが8%、jaが5%、frが5%、deが4%、esが4%、viが3%、csが3%、ruが3%、trが3%、zh-twが2%、plが2%、thが2%、itが2%でした。デスクトップでは、それぞれ20%、9%、9%、7%、5%、5%、4%、3%、3%、3%、2%、2%、3%、2%、2%、2%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=709141996&format=interactive",
  sheets_gid="127817290",
  sql_file="content-language-2024.sql",
  width=600,
  height=594
  )
}}

ホームページと内部ページの言語使用データを調査すると（後者は2022年には議論されていませんでした）、英語（en）が主要要素として現れ（ホームページ：18%、内部ページ：18%）、続いてpt-br（ホームページ：9%、内部ページ：9%）、en-us（ホームページ：8%、内部ページ：8%）、ja（ホームページ：6%、内部ページ：6%）となっています。

{{ figure_markup(
  image="home-vs-inner-page-language-usage-combined.png",
  caption="ホームページと内部ページの言語使用（htmlとhttpヘッダー）。",
  description="ページの割合として言語使用を示す棒グラフ。ホームページでは、enがデータセット内のページの18%で使用され、続いてpt-brが9%、en-usが8%、jaが6%、frが5%、deが4%、esが4%、viが3%、ruが3%、csが3%、trが2%、plが2%、zh-twが2%、thが2%、itが2%、huが2%でした。内部ページでは、それぞれ18%、9%、8%、6%、5%、4%、3%、3%、3%、3%、3%、2%、3%、2%、2%、2%で非常に類似していました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTitOH-aAprInUucdKE0WM41rpV2ri7KW90ZH9VGH2QLbvgKDq6tDRPRNJXMx3i0njRGEIZbxwYoKqJ/pubchart?oid=218192895&format=interactive",
  sheets_gid="127817290",
  sql_file="content-language-2024.sql",
  width=600,
  height=594
  )
}}

他の要素に関して、順序は上記のモバイルとデスクトップの比較とほぼ同じパターンに従いました。

両方のグラフの結果データを分析すると、`en` の優位性は、コンテンツの大部分がまだ英語話者向けに調整されていることを示唆しています。この相関関係は、英語が<a hreflang="en" href="https://www.statista.com/statistics/266808/the-most-spoken-languages-worldwide/">もっとも話される言語</a>であるだけでなく、グローバル市場全体で広く使用され、強力なアメリカ市場（en-us）への参入要件でもあることの結果のようです。

中国語が世界で2番目にもっとも話される言語であるにもかかわらず、この言語の主要検索エンジンであるBaiduは、中国語Webサイトを見つけるための特定のタグを必要としません。その結果、言語のデータを収集する際に課題となります。それでも、`zh-tw`（台湾で話される中国語）は言語使用で13位に現れています。

さらに、`pt-br` が2022年のモバイル対デスクトップ比較での6位から2位への成長は非常に重要で、この言語でのオーディエンス獲得の追求を示している可能性があります。

## 結論

2022年の前回のWeb Almanac SEO章から今年の版までの2年間は、しばしば急速に変化する分野であるSEOにおいては長い時間のように思えるかもしれません。しかし、データは基本事項への段階的な変化が緩やかに進んでいることを示しています。

たとえば、`IndexIfEmbedded` タグの最近の成長は、おそらく特定の実践とプロトコルがSEO業界内で大規模に採用される前に、ある程度の時間が必要であることを示しています。

とはいえ、いつものビジネスというわけではありませんでした。First Input Delay（FID）という議論の余地があるが合格しやすい指標をInteraction to Next Paint（INP）が置き換えたにもかかわらず、Core Web Vitals（CWV）を通過するサイトの数は驚異的でした。そのポジティブなニュースは、一般的にパフォーマンスがSEO業界でより真剣に受け止められていることを示しています。

もっとも注目すべきは、AIとLLMが検索エンジンが長い間遭遇した中でもっとも大きな変化のいくつかを提示しており、それらは非常に破壊的である可能性があることです。その結果、関連するクローラーに関連する `robots.txt` の採用がすでに成長しています。

絶えず変化する検索状況とAIおよびLLMによってもたらされる新しい機会により、SEOは迅速に新しい分野に移行する可能性があります。同時に、基本事項への緩やかだが着実な改善は、SEOの状況が、大きな海変化にもかかわらず、長年のベストプラクティスが重要視され、最終的に報われるものであることを強調しています。
