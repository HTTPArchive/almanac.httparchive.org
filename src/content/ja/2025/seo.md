---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: 2025年版Web AlmanacのSEOチャプター。クロール可能性、インデックス可能性、ページエクスペリエンス、オンページSEO、リンク、AMP、国際化などを網羅。
hero_alt: 検索フィールドの下にさまざまなウェブページがあり、Web Almanacのキャラクターがページに光を当てながら各種チェックを行っているヒーロー画像。
authors: [Amaka-maxi, chr156r33n, SophieBrannon]
reviewers: [fellowhuman1101]
analysts: [augustin_delport, chr156r33n]
editors: [MichaelLewittes, montsec, hello-sharon]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1MoWoxogYWH6fv5r485EttvVgJuw7dMzzcot66X3MWu4/edit
Amaka-maxi_bio: AmakaはSEOおよびコンテンツストラテジストで、過去7年間にわたりブランドのオンラインプレゼンスを形成してきました。英国、米国、オーストラリアのエージェンシー（Whitecoat SEOやSwitch Key Digitalを含む）で勤務し、法律、医療、家庭サービス、B2B分野のクライアントのためにコンテンツシステム、テクニカルSEOの基盤、検索主導のストーリーテリングを構築しています。その仕事は明確さ、思慮深い戦略、共感のミックスを反映しています。仕事以外でも同じ姿勢を持ち込んでおり、特に毎日の最良の部分である娘との時間を大切にしています。
chr156r33n_bio: Chris GreenはTorque Partnershipのテクニカルディレクターであり、15年以上のサーチ業界のベテランです。Fortune 500企業に対して、検索戦略やブランド・アルゴリズム・AIシステムの進化する関係性についてアドバイスしています。
SophieBrannon_bio: Sophie Brannonはアトランタを拠点とするStudioHawk USの共同創設者兼ディレクターです。エージェンシー、社内、コンサルタントにわたる10年以上のSEO経験を持ち、eコマース、金融、ゲーム、ヘルス、SaaSなど幅広い業界で活動してきました。Sophieはオーガニック成長に対して戦略的かつデータドリブンなアプローチを採用し、テクニカルSEO、ユーザーエクスペリエンステスト、コンテンツ、デジタルPRを通じてブランドの持続可能なスケールを支援しています。SEOをアクセスしやすくし、次世代の検索マーケターを育成することに情熱を持っています。
featured_quote: AIサーチがコンテンツの発見方法を再構築する中、ウェブの基本原則はかつてないほど重要です。そして心強いことに、データはその基盤が揺るぎないことを示しています。
featured_stat_1: 2.10%
featured_stat_label_1: のモバイルサイトが `llms.txt` ファイルを使用しています。
featured_stat_2: 92%
featured_stat_label_2: HTTPSの採用率が約92%に達しました。約89%から安定した、しかし重要な前進です。
featured_stat_3: 50%
featured_stat_label_3: のすべてのページが構造化データを含んでいます。
doi: 10.5281/zenodo.18246492
---

## はじめに

検索エンジン最適化（SEO）は、オンラインで情報がどのように発見・理解されるかにおいて引き続き中心的な役割を担っています。SEOはウェブサイトが効果的にクロールされ、インデックスされ、検索結果に表示されるかどうかを決定する技術的・構造的・コンテンツ的な施策全般を包含します。

強固なSEOの基盤は、従来の検索エンジンでの視認性を支えるだけでなく、AIシステムがウェブコンテンツを新しい方法で解釈・要約し始めるにつれ、その重要性はますます高まっています。

2025年版Web AlmanacのSEOチャプターは、HTTP Archiveのクロール、Lighthouseレポート、Chrome User Experience（CrUX）レポート、およびカスタム指標からデータとインサイトを収集しています。ウェブの技術的な状態がどのように進化しているかを記録し、今日のオーガニック視認性に最も影響を与える要因を特定することが目標です。

多くのSEO指標がウェブ全体で安定している一方、それを取り巻く状況は急速に変化しています。AIクローラーの台頭、`llms.txt` の登場、機械可読性への関心の高まりは、最適化がもはやボットに *見つけてもらう* だけでなく、ボットに *理解してもらう* ことについてであることを示唆しています。オンライン検索のこうした変化するコンテキストは、今後の最適化にどのような影響を与えるのでしょうか。また、最新のデータポイントはすでにAIのSEOへの影響をどのように反映しているのでしょうか？

## クロール可能性とインデックス可能性

ウェブコンテンツが検索結果で視認されるためには、まず検索エンジンのクローラーにクロールされ、インデックスされる必要があります。クロール可能性はボットがページを見つけてアクセスできるかどうかを決定し、インデックス可能性はそのページが検索結果に表示される資格があるかどうかを定義します。この2つの概念が合わさって、検索の視認性の基本要素を形成します。ボットに最初に発見・理解されなければ、ページはランク付けされたりユーザーに提供されたりすることができません。同様に、サイトがインデックス可能でなければ、コンテンツはAIプラットフォームで引用されません。

[Googleのドキュメント](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt)は、クロールルールの遵守が `robots.txt` ファイルの存在だけでなく、そのファイルが正しく構成されているかどうかにも依存することを明確にしています。検索エンジンはまた、ディレクティブを効率的に解析し、一貫して解釈できるよう、実際の制限と標準化されたキャッシュ動作を適用しています。

同時に、<a hreflang="en" href="https://www.cloudflare.com/learning/bots/what-is-robots-txt/">Cloudflareが説明するように</a>、`robots.txt` は常に遵守されるコマンドというよりも、行動規範として機能します。評判の良いボットはこれらのシグナルを尊重しますが、他のボットはまったく無視する場合もあります。この協調と予測不可能性の混在が現代のクロール環境を定義し、サイトが実際にクローラーアクセスをどのように管理しているかを検討する舞台を設定しています。

### `robots.txt`

クローラーのためのウェブの事実上の「案内所」として機能する `robots.txt` ファイルは、ボットがサイトのどの部分が公開されているか、または制限されているかを確認する場所です。3年前にIETFがRobots Exclusion Protocol（<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9309">RFC 9309</a>）を<a hreflang="en" href="https://www.ietf.org/about/">標準化</a>して以来、その構文、キャッシュ動作、エラー処理が明確に定義され、クローラーがアクセスルールを解釈するための安定したフレームワークが提供されています。

そのフレームワークを改良する取り組みは継続中です。2024年後半、<a hreflang="en" href="https://garyillyes.github.io/ietf-rep-ext/draft-illyes-repext.html">IETFはREPextというワーキングドラフトを導入しました</a>。これはRFC 9309を基に、レスポンスヘッダーとHTML `meta` タグを通じたページレベルのクロール制御を探求するもので、将来の実装をより細かく柔軟にする可能性があります。

しかし現時点では、`robots.txt` ファイルはクロール管理の基盤であり続けています。ほとんどのウェブサイトは有効なファイルを提供しており、省略しているのはごく少数です。省略しているサイトの場合、サイト所有者は複雑なボット固有のルールよりも、シンプルで普遍的なディレクティブを好む傾向があります。続くセクションでは、これらの傾向が2025年のデータにどのように現れているかを検討します。

#### `robots.txt` ステータスコード

{{ figure_markup(
  image="robotstxt-status-codes.png",
  caption="`robots.txt` のステータスコード。",
  description="robots.txtファイルにアクセスした際に返されるHTTPステータスコードの分布を示す棒グラフ。200ステータスコード（成功）はデスクトップとモバイルの両方で84.9%のサイトに返されます。タイムアウトはデスクトップで1.0%、モバイルで1.1%のサイトで発生します。404ステータスコード（見つからない）はデスクトップサイトの13.3%、モバイルサイトの13.2%に返されます。403ステータスコード（禁止）はデスクトップとモバイルの両方で0.5%のサイトに返されます。500ステータスコード（サーバーエラー）はデスクトップとモバイルの両方で0.1%のサイトに返されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1134590836&format=interactive",
  sheets_gid="1959645667",
  sql_file="robots-txt-status-codes-2025.sql"
  )
}}

2025年には、`robots.txt` ファイルへのリクエストの85%が有効な200ステータスコードを返しており、2024年の84%から増加しています。この若干の上昇は、2022年の標準化の波及効果と、有効な `robots.txt` ファイルを提供するCMSのデフォルト設定の普及が続いていることを示唆しています。ただし重要なのは、200レスポンスはファイルが存在することを確認するだけで、そのディレクティブが正しいまたはサイトにとって有益であることを保証するものではありません。

有効な（200）`robots.txt` ステータスコードに関しては、モバイルとデスクトップの差はほぼ消失しており、現在モバイルはデスクトップよりわずか0.06%リードしています。これは業界が独立した「mドット」サイトから統一された設定のレスポンシブデザインへ移行していることを反映しています。

`robots.txt` ファイルに対する404エラーの割合は2024年の14%から13%に低下しました。見つからないファイルの減少は、クロール無制限をデフォルトとするのではなく、より多くのサイトが明示的に `robots.txt` ファイルを提供していることを意味します。

タイムアウトは約1.0%、403レスポンスは約0.5%、5xxは約0.1%です。まれではありますが、`robots.txt` ファイルへの[5xxレスポンス](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#:~:text=Other%20errors-,A%20robots.,treated%20as%20a%20server%20error.)は、キャッシュされたファイルまたは後続の成功したフェッチが利用可能になるまで、検索エンジンがサイトを一時的にブロック済みとして扱う原因になりえます。

#### `robots.txt` ファイルサイズ

{{ figure_markup(
  image="robotstxt-size.png",
  caption="`robots.txt` のサイズ。",
  description="robots.txtファイルのファイルサイズ分布を示す棒グラフ。0〜100バイトのファイルはデスクトップサイトの97.5%、モバイルサイトの97.6%を占めます。100〜200バイトのファイルはデスクトップサイトの0.3%、モバイルサイトの0.3%を占めます。200〜300バイトのファイルはデスクトップサイトの0.1%、モバイルサイトの0.1%を占めます。300〜400バイトのファイルはデスクトップサイトの0.1%、モバイルサイトの0.1%を占めます。400〜500バイトのファイルはデスクトップサイトの0.0%、モバイルサイトの0.0%を占めます。500バイト以上のファイルはデスクトップサイトの0.1%、モバイルサイトの0.1%を占めます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=379008836&format=interactive",
  sheets_gid="52352071",
  sql_file="robots-txt-size-2025.sql"
  )
}}

ほぼすべての `robots.txt` ファイルはサイズ制限（[Googleは500KBの](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#:~:text=Google%20enforces%20a%20robots.,the%20size%20of%20the%20robots.)解析カットオフを強制）を大幅に下回っており、空のファイルを提供しないなどの標準に準拠しています。

ごく少数のサイトが完全に空の `robots.txt` ファイルを提供しており、現在デスクトップで1.8%、モバイルで1.7%と2024年からわずかに増加しています。ほとんどの[主要クローラーは空のファイルを許可的に扱います](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#:~:text=For%20the%20first%2012%20hours,checking%20for%20a%20new%20version\).)が、標準（<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9309.html">RFC 9309</a>）はこの動作を明示的に定義していないため、あまり知られていないボットによる一貫性のない処理の余地が残ります。制限が意図されていない場合は、有効なファイルまたは404を返すのがより安全なアプローチです。

2025年には、ファイルの98%が100KB未満であり、2024年からわずかに低下しています。年間のこの小さな変化は、安定した成熟した実装パターンを示しています。

100〜200KBのファイルは `robots.txt` の0.3%、200〜300KBはわずか0.1%を占め、前年からほぼ変化がありません。Googleが強制する500KBの解析カットオフを超えたサイトはわずか0.1%で、クローラー制限への強い準拠を確認しており、過大サイズの `robots.txt` ファイルはエッジケースであることを裏付けています。

`robots.txt` ファイルサイズがクロール可能性の障壁になることはほとんどありません。より差し迫った問題は、空または設定ミスのファイルで、クローラーがサイトルールを解釈する際に不確実性をもたらします。

#### `robots.txt` ユーザーエージェントの使用状況

{{ figure_markup(
  image="robotstxt-user-agents.png",
  caption="`robots.txt` のユーザーエージェント。",
  description="robots.txtファイルで指定されている最も一般的なユーザーエージェントを示す棒グラフ。ワイルドカードユーザーエージェント（*）はデスクトップサイトの77.04%、モバイルサイトの77.14%に表示されます。adsbot-googleはデスクトップサイトの9.82%、モバイルサイトの9.51%に表示されます。ahrefsbotはデスクトップサイトの9.29%、モバイルサイトの9.50%に表示されます。mj12botはデスクトップサイトの7.31%、モバイルサイトの7.28%に表示されます。googlebotはデスクトップサイトの6.22%、モバイルサイトの6.66%に表示されます。nutchはデスクトップサイトの5.03%、モバイルサイトの4.81%に表示されます。dotbotはデスクトップサイトの4.58%、モバイルサイトの5.02%に表示されます。adsbot-google-mobileはデスクトップサイトの4.76%、モバイルサイトの4.71%に表示されます。pinterestはデスクトップサイトの4.59%、モバイルサイトの4.35%に表示されます。ahrefssiteauditはデスクトップサイトの4.57%、モバイルサイトの4.27%に表示されます。その他のユーザーエージェントはグラフに表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=315238915&format=interactive",
  sheets_gid="1725497160",
  sql_file="robots-txt-user-agent-usage-2025.sql"
  )
}}

_分析のため、クロールで識別されたすべてのユーザーエージェント名を小文字化し、サイト間の差異を無視しました。一部のクローラーはドキュメントで推奨する大文字化を提供していますが、`robots.txt` ファイルを処理する際には理論上、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc9309#section-2.2.1:~:text=Crawlers%20MUST%20use%20case%2Dinsensitive%20matching%20to%20find%20the%20group%20that%20matches%20the%20product%20token%20and%20then%20obey%20the%20rules%20of%20the%20group">大文字と小文字を区別しないマッチングを使用する必要があります</a>。_

キャッチオールユーザーエージェント `*` は、今日の `robots.txt` ファイルで見られるクローラーディレクティブとして最も一般的なアプローチです。2025年には77%のファイルに表示されており、2024年から、また2022年の70%台半ばから若干増加しています。この着実な上昇は、ほとんどのサイト所有者が複雑なボット固有の指示を維持するよりも、広範な普遍的ルールを実装することを好むことを示しています。

`robots.txt` ファイルで特定のユーザーエージェント _が_ 言及されている場合、Googleの広告クローラー（`adsbot-google`）と `ahrefsbots` が昨年と同様にリードしています。

`robots.txt` ディレクティブにおける `adsbot-google` のターゲティングは2025年にデスクトップで9.8%、モバイルで9.5%に上昇しており、2024年のデスクトップ9.1%、モバイル8.9%と比較しています。

`ahrefsbot` も主要な名前付きクローラーであり続け、デスクトップの9.3%、モバイルの9.5%の `robots.txt` ファイルで指定されています。`ahrefssiteaudit`（デスクトップ4.6%/モバイル4.3%）と合わせると、大量のクロール活動を生み出しうるSEOツールのアクセスを制御することの継続的な重要性を反映しています。

今年注目すべき量で表示されたその他の名前付きクローラーには次のものがあります：

- `mj12bot`（Majestic）: デスクトップ7.3% / モバイル7.3%
- `googlebot`: デスクトップ6.2% / モバイル6.7%
- `nutch`: デスクトップ5.0% / モバイル4.8%

##### `bingbot` は `robots.txt` でほとんど名指しされない

`bingbot` は `robots.txt` ファイルの名前付きユーザーエージェントの中で22位にランクし、`robots.txt` の3%未満に表示されます。ボットが `robots.txt` ファイルに表示される場合、ウェブサイト管理者がそのクローラーを許可、制限、またはクロール率の設定など、その動作を明示的に制御するほど関心を持っていることを意味します。低い表示率は無視されていることを示唆しています。Microsoftの<a hreflang="en" href="https://blogs.microsoft.com/on-the-issues/2025/01/03/the-golden-opportunity-for-american-ai/">AIへの大規模な投資</a>と<a hreflang="en" href="https://blogs.microsoft.com/blog/2023/02/07/reinventing-search-with-a-new-ai-powered-microsoft-bing-and-edge-your-copilot-for-the-web/">BingへのChatGPTの統合</a>にもかかわらず、クローラー自体は `robots.txt` ファイルでより目立つ存在にはなっていません。AI機能強化にもかかわらず、Bingのウェブフットプリントとサイトオペレーターにとっての重要性はほぼ変わらないままで、`robots.txt` ファイルで名指しされる `gptbot` のようなAI特化クローラーの急速な台頭との静かな対照をなしています（詳細は後述）。

##### 名前付きユーザーエージェント使用の緩やかな増加

{{ figure_markup(
  image="robotstxt-seo-tool-related-user-agents.png",
  caption="`robots.txt` のSEOツール関連ユーザーエージェント。",
  description="robots.txtファイルで言及されているSEOクローラーボットの普及率を示す棒グラフ。`ahrefsbot` はデスクトップサイトの9.3%、モバイルサイトの9.5%に表示されます。`ahrefssiteaudit` はデスクトップサイトの4.6%、モバイルサイトの4.3%に表示されます。`mj12bot` はデスクトップサイトの7.3%、モバイルサイトの7.3%に表示されます。`semrushbot` はデスクトップサイトの3.0%、モバイルサイトの3.1%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=747347117&format=interactive",
  sheets_gid="1725497160",
  sql_file="robots-txt-user-agent-usage-2025.sql"
  )
}}

全体として、2024年と比較して、2025年の `robots.txt` ファイルでは、普遍的なワイルドカード `*` のみに頼るのではなく、名前付きクローラーのディレクティブを含む割合がわずかに大きくなっています。たとえば、MJ12Botは昨年のモバイル6.6%から2025年のモバイル7.3%に上昇し、Googlebotはモバイル6.4%から6.7%に、Nutchはモバイル4.3%から4.81%に増加しました。これらの控えめな伸びは、普遍的な制御のシンプルさから離れることなく、重要な箇所でカスタマイズされたクロールルールを設定するサイト所有者が増えているという、段階的な改善を示しています。

特定のボットへの言及が増加する中での `*` の継続的な優位性は、実用的なバランスを示唆しています。普遍的なディレクティブが標準のままですが、ビジネス上の懸念がある箇所には対象を絞ったルールが追加されます。すべてのクローラーが `*` を一貫して解釈するわけではありません。GoogleのAdsBotはそれを無視し、Applebotは `*` を適用する前にGooglebotルールにフォールバックするため、特定のケースでは明示的なターゲティングが必要です。

##### `robots.txt` でAIクローラーを名指し

AIクローラーの台頭により、`robots.txt` は従来の検索最適化ツールからコンテンツ権限を管理するための広範なメカニズムへと変貌しました。2025年には、AI関連ボットをターゲットにしたディレクティブが2024年の水準から大幅に増加しました。

{{ figure_markup(
  image="robotstxt-ai-related-user-agents.png",
  caption="`robots.txt` のAI関連ユーザーエージェント。",
  description="robots.txtファイルにおける名前付きユーザーエージェント使用の増加を示す棒グラフ。`gptbot` はデスクトップサイトの4.5%、モバイルサイトの4.2%に表示されます。`petalbot` はデスクトップサイトの4.0%、モバイルサイトの4.4%に表示されます。`claudebot` はデスクトップサイトの3.6%、モバイルサイトの3.4%に表示されます。`ccbot` はデスクトップサイトの3.5%、モバイルサイトの3.2%に表示されます。`amazonbot` はデスクトップサイトの3.3%、モバイルサイトの3.0%に表示されます。`google-extended` はデスクトップサイトの3.4%、モバイルサイトの3.0%に表示されます。`perplexitybot` はデスクトップサイトの2.8%、モバイルサイトの2.7%に表示されます。`chatgpt-user` はデスクトップサイトの2.8%、モバイルサイトの2.5%に表示されます。`facebookbot` はデスクトップサイトの2.9%、モバイルサイトの2.5%に表示されます。`meta-externalagent` はデスクトップサイトの2.8%、モバイルサイトの2.5%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=725000646&format=interactive",
  sheets_gid="1725497160",
  sql_file="robots-txt-user-agent-usage-2025.sql"
  )
}}

前年比の比較は、採用の加速を明らかにしています：

- `gptbot`: デスクトップ4.5%、モバイル4.2%と、2024年のデスクトップ2.9%、モバイル2.7%から約55%増加。
- `ccbot`: デスクトップ3.5%、モバイル3.2%と、2024年のデスクトップ2.7%、モバイル2.4%から増加。
- `petalbot`: 今年デスクトップ4.0%、モバイル4.4%；2024年には個別に追跡されていなかった。
- `claudebot`: デスクトップ3.6%、モバイル3.4%と、2024年のデスクトップ1.9%、モバイル1.6%からほぼ2倍。

注目すべきは、2024年のデータには `anthropic-ai`（昨年デスクトップ2.0%、モバイル1.7%）や `chatgpt-user`（昨年デスクトップ2.0%、モバイル1.7%）などの広範なカテゴリーが含まれていたのに対し、2025年のデータはより特定のボットターゲティングを示しています。

今年AIクローラー分野に参入したその他のボットには、`amazonbot`（デスクトップ3.3%、モバイル3.0%）、`google-extended`（デスクトップ3.4%、モバイル3.0%）、`perplexitybot`（デスクトップ2.8%、モバイル2.7%）、`chatgpt-user`（デスクトップ2.8%、モバイル2.5%）、`facebookbot`（デスクトップ2.9%、モバイル2.5%）、`meta-externalagent`（デスクトップ2.8%、モバイル2.5%）があります。

ユーザーエージェントのターゲティング全体は年々緩やかに成長しているのに対し、AIクローラーの採用ははるかに急激です。2024年以降の `gptbot` のほぼ倍増、`petalbot`、`claudebot` などの測定可能な採用は、2023年のわずかな存在から2025年には数パーセントの採用率に達した、名前付きユーザーエージェントに対する `robots.txt` ディレクティブの最近の記憶の中で最も急速な拡張の一つを表しています。

この変化はサイト所有者に新たな複雑さをもたらしています。「このページは検索にインデックスされるべきか？」と問うだけでなく、「このコンテンツはAIモデルのトレーニングに使用されるべきか？」とも問わなければなりません。これらは異なるビジネス的・倫理的含意を持つ別々の考慮事項です。

`robots.txt` は、検索での視認性とデータの大規模収集からの保護のバランスを取る二重目的の制御ポイントになっています。AIモデルとクローラーが増殖するにつれ、このトレンドは激化する可能性があります。

## `llms.txt`

`llms.txt` ファイルは、「推論時にLLMがウェブサイトを使用するのに役立つ情報を提供する」新しい標準として提案されています（<a hreflang="en" href="http://llmstxt.org">llmstxt.org</a>より）。このテキストファイルはMarkdown形式のウェブサイトコンテンツの高度に簡略化されたバージョンを含み、LLMが生成レスポンスで取り込んで使用しやすくすることを目指しています。

この標準はまだ広く採用されておらず、SEO業界全体で議論の的となっています。Googleは `llms.txt` を使用していないとしばしば述べており、<a hreflang="en" href="https://www.seroundtable.com/google-ai-llms-txt-39607.html">現在Googleのサービスは使用していません</a>。しかし、Anthropicは<a hreflang="en" href="https://docs.claude.com/llms-full.txt">`llms.txt` のリードを取っており</a>、このフォーマットがモデル推論中のコンテンツ利用を管理・最適化するための信頼できるメカニズムへと発展するかもしれないという楽観論が高まっています。

### `llms.txt` の採用率

`llms.txt` の使用がSEOやAI最適化に有効なアプローチであることが証明されるかどうかにかかわらず、このような新しいファイル形式と提案された標準の導入は、今後のウェブサイトの構築と最適化に影響を与える可能性があります。

2025年Almanacの一環として、ウェブ全体の `llms.txt` 採用レベルを評価するモニターを導入しました。

{{ figure_markup(
  image="valid-llms-txt.png",
  caption="有効な `llms.txt`",
  description="llms.txtの採用状況を示す棒グラフ。デスクトップサイトの2.13%、モバイルサイトの2.10%に表示されます。これにより、デスクトップサイトの97.87%、モバイルの97.90%がllms.txtを持っていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=637355278&format=interactive",
  sheets_gid="1895020036",
  sql_file="llms-status-2025.sql"
  )
}}

採用率は2%と比較的低いですが、`llms.txt` 形式がどれほど新しいか、および分析されたすべてのモバイルサイトで合計324,184の有効なファイルが確認されたことを考えると、これらの数値は依然として注目に値します。

これらの `llms.txt` ファイルの内容を掘り下げると、これまでのこの標準の採用について、そして将来この動きを促すものについていくつかの手がかりが見えます。

- `llms.txt` ファイルの39.6%はAll in One SEOに関連
- `llms.txt` ファイルの3.6%はYoast SEOに関連

これはこれらのCMS拡張が生成したファイルに（デフォルトで）残すコメントから得られましたが、`llms.txt` ファイルを持つウェブサイト所有者の相当数がCMS/アドオン拡張によって生成されていることを示しています。したがって、これが常に意識的な行為または `llms.txt` 標準の支持なのか、意図せぬ組み込みなのかは確認できません。

2025年1月以来、[この新興標準への関心は高まり続けており](https://trends.google.com/trends/explore?q=llms.txt)、1〜2社の主要なAI企業の認知にかかっています。それでも、2026年の数字を見るのは興味深いでしょう。

## ロボットディレクティブ

[ロボットディレクティブ](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag)は、特定のページがどのようにインデックスされ検索結果に表示されるかに対するページレベルの制御を提供します。`robots.txt` ファイルと同様の機能を持ちますが、両者は異なる目的を持ちます：

- ロボット _ディレクティブ_ は **インデックスとサービング** に影響する
- 一方 `robots.txt` は **クロール** を制御する

ディレクティブが適用されるためには、クローラーがページにアクセスできる必要があります。ページが robots.txt によってブロックされている場合、そのディレクティブが見られたり従われたりすることはないかもしれません。

### ロボットディレクティブの実装

ロボットディレクティブを実装する主な方法は2つあります：

1. [`<meta name=robots>`](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta/name/robots) タグを使用する（ウェブページの `<head>` セクション内に配置）
2. [`X-Robots-Tag`](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/X-Robots-Tag) HTTPヘッダーを使用する

どちらの方法を選ぶかは、具体的なユースケースと利用可能な手段や方法によって異なります。

`meta` ロボットタグは主にHTMLページ向けで、ほとんどの主要なCMSでネイティブまたはアドオンを通じて広くサポートされており、その他の一般的でよくサポートされているフレームワークでも同様です。

`X-Robots-Tags` はPDFや文書などの他のHTML以外のファイルタイプにも実装できるという大きな利点があります。ただし、CMSユーザーにとっては設定が簡単でないことが多く、常に選択肢として使えるわけではありません。

{{ figure_markup(
  image="robots-directive-implementation.png",
  caption="ロボットディレクティブの実装",
  description="ウェブサイト全体のロボットディレクティブ実装方法を示す棒グラフ。Metaロボットディレクティブはデスクトップサイトの47.0%、モバイルサイトの47.9%で使用されています。X-Robots-Tagディレクティブはデスクトップサイトの0.6%、モバイルサイトの0.7%で使用されています。Meta RobotsとX-Robots-Tagの両方のディレクティブがデスクトップサイトの0.4%、モバイルサイトの0.4%で一緒に使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=736143902&format=interactive",
  sheets_gid="574446946",
  sql_file="seo-stats-2025.sql"
  )
}}

`meta` ロボットはロボットディレクティブを実装するための最も広く使われている方法で、デスクトップページの47.0%、モバイルページの47.9%に表示されており、X-Robotsはデスクトップ0.6%、モバイル0.7%で大差で2番手につけています。

`meta` ロボットを実装しているページ数は昨年記録されたデスクトップ45.5%、モバイル46.2%から増加しており、前年比（YoY）の成長を示しています。対照的に、`X-Robots-Tag` の実装はYoYでほぼ変わっていません。インナーページはロボットディレクティブを持つ可能性が50%で、ホームページの46%と比較しています。

一部のページ（デスクトップとモバイルの両方で0.4%）では `meta` ロボットと `X-Robot-Tag` の両方が同時に実装されています。この0.4%という数字は昨年から安定していますが、2つの実装方法間で矛盾するシグナルが生成される可能性が高まるため、広く推奨されている慣行ではありません。

#### ロボットディレクティブのルール

実装方法はロボットディレクティブの一側面に過ぎません。[ディレクティブルール](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag#directives)がページやドキュメントをどのように処理するかを決定します。

ルールはコンマ区切りの値として `meta` ロボットまたは `X-Robots-Tag` のいずれかに追加できます。

ディレクティブルールの調査では、レンダリングされたHTMLに依存しました。

{{ figure_markup(
  image="robots-directive-rules.png",
  caption="ロボットディレクティブのルール",
  description="ページ全体のロボットディレクティブの実装を示す棒グラフ。`follow` ディレクティブはデスクトップサイトの64.0%、モバイルサイトの60.5%に表示されます。indexディレクティブはデスクトップサイトの69.0%、モバイルサイトの59.3%に表示されます。`nofollow` ディレクティブはデスクトップサイトの2.4%、モバイルサイトの2.8%に表示されます。`noindex` ディレクティブはデスクトップサイトの3.5%、モバイルサイトの2.4%に表示されます。`max-image-preview` ディレクティブはデスクトップサイトの5.0%、モバイルサイトの2.8%に表示されます。`max-snippet` ディレクティブはデスクトップサイトの2.2%、モバイルサイトの1.1%に表示されます。`max-video-preview` ディレクティブはデスクトップサイトの1.6%、モバイルサイトの0.8%に表示されます。`noarchive` ディレクティブはデスクトップサイトの2.5%、モバイルサイトの1.8%に表示されます。`nosnippet` ディレクティブはデスクトップサイトの0.1%、モバイルサイトの0.1%に表示されます。`notranslate` ディレクティブはデスクトップサイトの0.0%、モバイルサイトの0.0%に表示されます。追加のディレクティブはグラフに表示されます。
",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=779209791&format=interactive",
  sheets_gid="3780528",
  sql_file="robots-meta-usage-2025.sql"
  )
}}

最もよく使われる2つのルール `follow` と `index` は、`noindex` や `nofollow` などの反対の目的を持つ他のルールがない場合のデフォルト値とみなされ（Googleには無視されます）。

これらを含めることは、ロボットがページをインデックスし、そこからリンクをたどるべきであることを意味します。モバイルでの `follow` と `index` の使用率はそれぞれ60.5%と59.3%であり、これらの2つのタグが一緒に見られ、一般的に補完的であることを意味しています。

技術的に不要な `meta` ロボットルールの組み合わせがこれほど多い可能性のある原因のひとつはYoast SEOで、<a hreflang="en" href="https://developer.yoast.com/features/seo-tags/meta-robots/functional-specification/#:~:text=Unless%20otherwise%20defined%20by%20the%20user%20(or%20via%20page/template/filtering%20logic)%2C%20%7B%7Bvalues%7D%7D%20outputs%20index%2C%20follow.">`index,follow` をデフォルトで適用します</a>。Yoastはホームページでのをてのセオツール/プラグインの使用を見ると約16%の採用率（デスクトップとモバイル）を持ち、<a hreflang="en" href="https://www.wappalyzer.com/technologies/seo/">識別されたすべてのSEOツール</a>のうち、70%近くの時間で使用されています。

`nofollow` と `noindex` は次に最もよく使われる `meta` ロボットルールで、使用頻度はかなり低く、デスクトップページの2.8%、モバイルページの2.4%に表示されます。

{{ figure_markup(
  image="seo-tools.png",
  caption="最も一般的なロボットディレクティブの実装",
  description="ウェブサイト全体で実装されている最も一般的なロボットディレクティブルールを示す棒グラフ。Yoast SEOはデスクトップサイトの15.96%、モバイルサイトの15.49%に表示されます。RankMath SEOはデスクトップサイトの3.56%、モバイルサイトの3.60%に表示されます。All in One SEOはデスクトップサイトの2.96%、モバイルサイトの2.92%に表示されます。Yoast SEO Premiumはデスクトップサイトの1.42%、モバイルサイトの1.30%に表示されます。Ahrefsはデスクトップサイトの0.28%、モバイルサイトの0.25%に表示されます。The SEO Frameworkはデスクトップサイトの0.18%、モバイルサイトの0.15%に表示されます。SEOmaticはデスクトップサイトの0.07%、モバイルサイトの0.05%に表示されます。Avada SEOはデスクトップサイトの0.06%、モバイルサイトの0.06%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1233372001&format=interactive",
  sheets_gid="2072167686",
  sql_file="wordpress_seo_plugin-2025.sql"
  )
}}

`meta` ロボットディレクティブのもう一つの要素は `name` 属性で、これらのディレクティブが特定のロボット/クローラーのユーザーエージェントを対象にしているかどうかを指定できます。たとえば、一部のクローラーが特定のルールを必要とし、他のクローラーがそうでない場合に動作をカスタマイズできます。

この属性内で最もよく名前が挙がるクローラーは2024年と一致しており：`bingbot`、`msnbot`、`googlebot`、`google-news` がデフォルトの `robots` とともに最も頻繁に表示されます。

{{ figure_markup(
  image="robots-directive-rules-by-name.png",
  caption="名前別ロボットディレクティブルール",
  description="モバイルページのロボットディレクティブで名指しされたクローラー別のロボットディレクティブルールを比較する棒グラフ。名指しされたボットは `bingbot`、`msnbot`、`googlebot`、`googlebot-news` です。適用された値は次のとおりです：`follow`: 94.9%、78.8%、61.0%、75.6%、54.0%。index: 92.6%、66.8%、60.7%、77.3%、58.3%。`nofollow`: 0.8%、3.9%、1.9%、2.4%、3.9%。`noindex`: 1.4%、5.0%、3.5%、3.5%、9.1%。`max_image_preview`: 84.4%、0.5%、71.1%、25.2%、3.8%。`max_snippet`: 84.4%、0.5%、42.1%、24.9%、1.6%。`max_video_preview`: 84.2%、0.5%、42.1%、24.6%、1.2%。`noarchive`: 2.0%、3.5%、0.9%、4.5%、1.1%。`nosnippet`: 0.1%、0.1%、0.1%、0.8%、5.5%。`notranslate`: 0.0%、0.0%、0.0%、1.2%、0.1%。`noimageindex`: 0.1%、0.0%、0.1%、0.7%、0.1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1906268341&format=interactive",
  sheets_gid="3780528",
  sql_file="robots-meta-usage-2025.sql",
  width=600,
  height=648
  )
}}

`msnbot` は `bingbot` に置き換えられたレガシークローラーです。ロボットディレクティブへの継続的な存在は、古いクローラー名の更新や削除の遅れを示唆しています。この遅れの追加の証拠は、`max_image_preview`、`max_snippet`、`max_video_preview` などの新しいロボットルールが `googlebot` と `bingbot` には一般的に適用されているが、`msnbot` には適用されていないという事実に見られます。

### `indexifembedded` タグ

現在よく確立されたMetaロボットルールである `indexifembedded` は、iframeコンテンツが埋め込まれているページの一部として扱われるようにしたい場合を指定できる非常に特定のタグです。これを機能させるには `noindex` とペアにする必要があり、現在Googleのみがサポートするルールです。

{{ figure_markup(
  image="indexifembedded-usage-in-iframe-content.png",
  caption="`iframe` コンテンツでの `indexifembedded` の使用",
  description="ウェブページのheadセクション内に見つかる無効なHTML要素の普及率を示す棒グラフ。`indexifembedded` を使用する `iframe` 要素はデスクトップサイトの88.9%、モバイルサイトの87.7%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=489480572&format=interactive",
  sheets_gid="3780528",
  sql_file="robots-meta-usage-2025.sql"
  )
}}

iframeコンテンツ内では、`indexifembedded` ルールはほぼ90%の時間（デスクトップ88.9%、モバイル87.7%）で見つかります。興味深いのは、2022年から2024年にかけて使用率が上昇した後、2025年には99.9%の使用率から低下したことです。

### 無効な `<head>` 要素

検索エンジンのクローラーはコンテンツを解析する際にHTML標準に従います。発生しうる問題の一つは、ページの `<head>` 内に無効なHTML要素が見つかる場合です。これにより `<head>` が暗黙的に早期終了したと見なされ、残りのすべての `<head>` 要素がページの `<body>` 内に含まれるようになります。

SEOへの悪影響が最も大きいのは、`title`、`canonical` タグ、hreflang、Metaロボットディレクティブなどの重要なメタデータが無効な `head` 要素の下に配置されている場合（`body` 内に含まれることでそれらが機能しなくなります）です。

{{ figure_markup(
  image="pages-with-invalid-html-in-head.png",
  caption="`<head>` に無効なHTMLがあるページ",
  description="headセクションに無効なHTMLがあるページを示すグラフ。無効なHTML要素はデスクトップサイトの10.1%、モバイルサイトの10.3%に見つかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1130119859&format=interactive",
  sheets_gid="702547823",
  sql_file="invalid-head-sites-2025.sql"
  )
}}

今年見つかった無効なhead要素は2024年のデータで見られた下降傾向を継続しており、前年比でページの `<head>` セクションの無効な要素が再び少なくなっています。

2025年には、デスクトップページで10.1%の無効な `<head>` 要素、モバイルページで10.3%の無効な要素が見られます。2024年のデータ（デスクトップ10.6%、モバイル10.9%）と比較すると、デスクトップで4.7%、モバイルで5.2%の低下を表しています。

「無効な」`<head>` 要素の定義には、W3C標準に基づいていないページの `<head>` に含まれるものすべてが含まれます。[Google検索のドキュメント](https://developers.google.com/search/docs/crawling-indexing/valid-page-metadata#use-valid-elements-in-the-head-element)によると、`<head>` で使用できる有効な要素は8つあります。これらは：

- `<title>`
- `<meta>`
- `<link>`
- `<script>`
- `<style>`
- `<base>`
- `<noscript>`
- `<template>`

2025年に最も多く見られる無効な要素は2024年のデータと同じです：`<img>`、`<div>`、`<a>` タグ。

{{ figure_markup(
  image="invalid-head-elements.png",
  caption="無効な `head` 要素",
  description="ウェブページの `head` セクション内に見つかる無効なHTML要素を示す棒グラフ。`img` 要素はデスクトップサイトの27.2%、モバイルサイトの23.0%に誤って表示されます。`div` 要素はデスクトップサイトの11.5%、モバイルサイトの10.6%に表示されます。`a` 要素はデスクトップサイトの5.2%、モバイルサイトの4.9%に表示されます。`iframe` 要素はデスクトップサイトの3.5%、モバイルサイトの3.1%に表示されます。`p` 要素はデスクトップサイトの3.3%、モバイルサイトの3.2%に表示されます。`span` 要素はデスクトップサイトの3.2%、モバイルサイトの3.1%に表示されます。`br` 要素はデスクトップサイトの2.6%、モバイルサイトの2.5%に表示されます。`input` 要素はデスクトップサイトの2.4%、モバイルサイトの2.42%に表示されます。`li` 要素はデスクトップサイトの1.9%、モバイルサイトの2.2%に表示されます。`ul` 要素はデスクトップサイトの1.9%、モバイルサイトの2.2%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=9729751&format=interactive",
  sheets_gid="702547823",
  sql_file="invalid-head-sites-2025.sql"
  )
}}

無効な `<img>` タグについては、2024年は2022年から急増が見られましたが、2025年の結果はより安定しています（今年はデスクトップ27.2%、モバイル23%に対し、昨年はデスクトップ29%、モバイル22%）。具体的には、デスクトップの使用率は低下し、モバイルは小幅に増加しています。

`<div>` タグはデスクトップ11.5%、モバイル10.6%で目立った変化はありません。`<a>` タグも同様に昨年からほとんど変化がなく、デスクトップ5.2%、モバイル4.9%です。

## 正規化

`canonical` タグは、重複またはほぼ重複するページが存在する場合に、どのバージョンが主要なページであるかを検索エンジンに伝えます。これらがなければ、クローラーはランキングシグナルを分散させ、クロールバジェットを無駄にし、検索結果に誤ったURLを表示する可能性があります。これらがあれば、すべての権限とインデックス優先度が単一の決定的なページに集中します。

`canonical` タグはディレクティブ（`meta` ロボットのような）ではなく、正しく実装することでランキング問題を最小化する支援シグナルを提供する「強いヒント」です。

`canonical` タグの使用がまた増加しており、昨年のモバイルとデスクトップの両方65%から、2025年にはデスクトップ68%、モバイル67%に増加しました。

{{ figure_markup(
  image="canonical-usage.png",
  caption="`canonical` の使用状況",
  description="デスクトップとモバイルページにわたるcanonicalタグの使用状況を示す棒グラフ。デスクトップでは68%のページにcanonicalタグがあり、モバイルでは67%です。さらに、デスクトップページの7%、モバイルページの9%が正規化されています（つまり、他のページから正規バージョンとして参照されています）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=180455031&format=interactive",
  sheets_gid="574446946",
  sql_file="seo-stats-2025.sql"
  )
}}

ページはそのcanonical URLが異なる場所を指す場合に「正規化されている」と言います。正規化されたページも今年増加しており、2024年のデスクトップ6%、モバイル8%から2025年にはデスクトップ7%、モバイル9%に増加しました。

### `canonical` の実装

`Canonical` タグはMetaロボットと同様に、HTTPレスポンスの一部またはページの `head` 内に実装できます。各実装方法の背後にある動機は、プラットフォームや要件によって異なり、それぞれにメリットとデメリットがあります。

ページの `head` 内の `Canonical`（`rel="canonical"`）は最もよく使用されており（ほとんどのCMSで標準化されているため）、ページのcanonical URLを示します。

HTTP canonicalも同じことができ、PDFなどの他のファイルタイプにも使用できるという追加の利点があります。ただし、CMSユーザーには広く実装されておらず、より高度な技術的理解が必要です。

{{ figure_markup(
  image="canonical-implementation.png",
  caption="`canonical` の実装",
  description="ウェブサイト全体のcanonical実装方法を示す棒グラフ。HTTP `Canonical` タグはデスクトップサイトの0.58%、モバイルサイトの0.50%に見つかります。生の `Canonical` タグはデスクトップサイトの64.40%、モバイルサイトの64.27%に表示されます。レンダリングされた `Canonical` タグはデスクトップサイトの66.01%、モバイルサイトの66.11%に存在します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=580513321&format=interactive",
  sheets_gid="1477268458",
  sql_file="pages-canonical-stats-2025.sql"
  )
}}

HTTPのcanonical実装は `rel="canonical"` タグと比較してまだ非常に低く、2025年にはデスクトップ0.6%、モバイル0.5%となっています。このデータは2024年の数値（デスクトップ0.7%、モバイル0.6%）からわずかな低下を表しています。

### 生のcanonicalタグとレンダリングされたcanonicalタグ

ページの `head` 内に配置される `rel=canonical` タグは、サイトの構築方法に応じて、生のHTML、レンダリングされたHTML、またはその両方に表示されます。ただし、最も信頼性の高いアプローチは、レンダリング後も変更されないことを保証するために、生のHTMLに `canonical` タグを含めることです。

JavaScriptで駆動されるページの場合、canonicalタグはページのレンダリングが完了した後にブラウザで挿入または更新されることがよくあります。生/レンダリングのcanonicalsの結果から、生のHTMLにcanonicalが欠如しているがレンダリングされたDOMに存在するケースは約2%のみです。これは、ほとんどのサイトが生のHTMLにcanonicalを含めることを選択し、ページレンダリング時に削除されないことを示しています。

2025年のデータでは、生のHTMLのcanonicalsの数値はデスクトップ64.4%、モバイル64.27%と2024年のデータと同等です。しかし、レンダリングされたcanonicalは2025年にデスクトップ66%、モバイル66.1%に増加しており、昨年のデスクトップ64%、モバイル65%と比較しています。

### canonicalの矛盾

JavaScriptを使用して `head` 内でcanonicalタグをレンダリングすることは機能しますが、エラーの余地が増えるため、静的なサーバーサイドのcanonicalタグが一般的により安全なオプションです。canonicalタグが一致しない場合、その使用が損なわれ、予期しない結果を引き起こす可能性があります。canonicalの不一致は2024年の数値から0.1%低下し、デスクトップとモバイルの両方で0.8%から今年0.7%に減少しました。

{{ figure_markup(
  image="canonical-inconsistency.png",
  caption="`canonical` の不整合",
  description="ウェブサイト全体のcanonical不整合の問題を示す棒グラフ。Canonical Mismatch問題はデスクトップサイトの0.72%、モバイルサイトの0.71%で検出されます。Rendered Change Canonical問題はデスクトップサイトの2.71%、モバイルサイトの3.02%で発生します。HTTP Header Changed Canonical問題はデスクトップサイトの0.25%、モバイルサイトの0.21%に見つかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=284369724&format=interactive",
  sheets_gid="1477268458",
  sql_file="pages-canonical-stats-2025.sql"
  )
}}

## ページエクスペリエンス

ページエクスペリエンスは、コンテンツの内容やランキングの高さを超えて、ユーザーがウェブページを操作する際に実際にどのように感じるかを捉えます。2020年にGoogleのランキングシステムの一部として導入され、これらのシグナルはページ速度、モバイルのレスポンシブ性、視覚的安定性、セキュリティなどの使いやすさの要因を測定します。Googleはその後、独立したページエクスペリエンスシステムを[コアランキングフレームワーク](https://developers.google.com/search/blog/2020/11/timing-for-page-experience)に統合しましたが、基礎となる指標はSEOとUXの両方のベストプラクティスを引き続き導いています。

2025年、データは技術的に成熟しているが、エクスペリエンスの品質においてまだ不均一なウェブを反映しています。HTTPSの採用はほぼ普遍的になり、モバイルフレンドリーさは差別化要因というよりも期待事項となり、Core Web Vitalsは実世界のパフォーマンスを定量化するための業界標準となっています。それでも、これらの進歩にもかかわらず、レンダリングの遅さからインタラクティビティの不一致まで、摩擦ポイントは依然として存在し、ユーザーエクスペリエンスはコンプライアンスと同様に一貫性についてであることをサイト所有者に思い出させています。

### HTTPS

HTTPSはユーザーとウェブサイト間のデータ交換を保護するために導入され、情報を傍受や改ざんから守ります。後にGoogleのアルゴリズムで[正式なランキングシグナル](https://developers.google.com/search/blog/2014/08/https-as-ranking-signal)となりました。

{{ figure_markup(
  image="https-usage.png",
  caption="HTTPSの使用状況",
  description="異なるページタイプにわたるHTTPS使用状況を示す棒グラフ。ホームページはデスクトップサイトの84.6%、モバイルサイトの86.6%でHTTPSを使用しています。インナーページはデスクトップサイトの92.4%、モバイルサイトの93.4%でHTTPSを使用しています。すべてのページではHTTPSはデスクトップの91.7%、モバイルページの91.5%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1953106420&format=interactive",
  sheets_gid="106300643",
  sql_file="lighthouse-seo-stats-2025.sql"
  )
}}

2025年、HTTPSの使用率はデスクトップページの91.7%、モバイルページの91.5%に達しており、2024年の約89%からわずかに増加しています。HTTPSがウェブのほとんどのデフォルトとなったため、成長は鈍化しています。残る小さなギャップは、まだ移行していない古いまたはメンテナンスが少ないサイトを表しています。その結果、HTTPSはユーザーと検索エンジンの両方にとって、差別化要因というよりもベースラインの期待として機能するようになっています。

それでも、完全な普遍的な暗号化は簡単ではありません。[Googleの透明性レポート](https://transparencyreport.google.com/https/overview)は継続的な障害を記録しています。一部の国や組織はHTTPSトラフィックをブロックまたは低下させ、技術的な能力が限られている組織は優先度を下げる場合があります。Googleの製品でさえ課題に直面しており、ユーザー所有ドメインの証明書管理（例：Blogger）は、それらのドメインがネイティブにHTTPSをサポートしていない場合に複雑になる可能性があります。これらの制約は、なぜ少数のサイトがまだ遅れをとっているかを説明するのに役立ちます。

### モバイルフレンドリー

Googleは2023年にモバイルファーストインデックスへの移行を完了しました。つまり、ウェブサイトのモバイルバージョンが検索ランキングを決定するようになりました。以下のデータは、これに応じてサイトがモバイルフレンドリーなデザインプラクティスをどれだけ採用しているかを調べています。

#### `viewport` メタタグ

`viewport` メタタグは、ページがさまざまな画面サイズにわたってどのようにスケールおよび表示されるかを定義し、レスポンシブウェブデザインの重要な要素です。モバイルブラウジングの台頭とともに導入され、ユーザーが水平にズームやスクロールをすることなく、コンテンツがさまざまなデバイスにスムーズに適応することを保証します。

{{ figure_markup(
  image="meta-viewport-usage.png",
  caption="`meta viewport` の使用状況",
  description="`meta viewport` タグのウェブサイトにわたる使用状況を示す棒グラフ。meta viewportタグを持つページの中央値はデスクトップサイトで93.1%、モバイルサイトで95.2%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1734425605&format=interactive",
  sheets_gid="106300643",
  sql_file="lighthouse-seo-stats-2025.sql"
  )
}}

`viewport` メタタグの使用はほぼ普遍的で、デスクトップページの93.1%、モバイルページの95.2%に表示されています。これは、レスポンシブデザインの原則が現代のウェブサイトで広く使用されていることを示しています。デスクトップとモバイルの差が小さいことは、開発者が別々のモバイルとデスクトップのコードベースを維持するのではなく、すべてのデバイスで一貫したレスポンシブデザインアプローチを使用していることを意味し、モバイルフレンドリーなデザインプラクティスの成熟を示しています。

#### `Vary` ヘッダーの使用状況

{{ figure_markup(
  image="vary-header-user.png",
  caption="`Vary` ヘッダーの使用",
  description="クライアントレンダリングとサーバーレンダリングページを比較した、ウェブサイト全体の `Vary` ヘッダー使用状況を示す棒グラフ。`Vary` ヘッダーはクライアントレンダリングページの99.3%、サーバーレンダリングページの99.8%で使用されていない（FALSE）一方、クライアントレンダリングページの0.2%、サーバーレンダリングページの0.7%のみで使用されています（TRUE）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=908000907&format=interactive",
  sheets_gid="713464186",
  sql_file="html-response-vary-header-used-2025.sql"
  )
}}

かつて動的配信の標準ツールだった `Vary: User-Agent header` は今やほぼ絶滅状態です。2025年には、ページの約1%しか含んでいませんが、ほぼすべてのサイトが統一されたレンダリングを選択しています。この変化は、`viewport` メタタグの普及（95%超）とGoogleのモバイルファーストインデックスへの移行と一致しており、サイトの別々のモバイルとデスクトップバージョンを維持する必要性を減少させました。ウェブは主にレスポンシブなシングルバージョンデザインに集約されています。

### 読みやすいフォントサイズ

読みやすさはモバイルエクスペリエンスの最も基本的な側面の一つです。ユーザーはズームや目を細めることなく快適にコンテンツを読めるべきで、アクセシビリティ標準もそれを強化しています。Web Content Accessibility Guidelines（[WCAG](https://www.w3.org/WAI/WCAG21/Understanding/resize-text.html#)）によると、ボディテキストは少なくとも16px（1rem）で、レイアウトや機能を損なわずに200%までスケールできる必要があります。

Lighthouseの[読みやすいフォントサイズ監査](https://developer.chrome.com/docs/lighthouse/seo/font-size)は同様のベンチマークを使用し、可視テキストの60%未満が `12px` を超えるページにフラグを立てます。2025年には、モバイルページの92%がこのテストを通過しており、2024年のパフォーマンスを反映し、ほとんどのサイトがホームページとインナーページの両方で基本的な読みやすさ標準を満たしていることを示しています。

{{ figure_markup(
  image="legible-font-size-used-mobile.png",
  caption="使用されている読みやすいフォントサイズ（モバイル）",
  description="モバイルページでの読みやすいフォントサイズ（16px以上）の使用状況を示す棒グラフ。読みやすいフォントサイズはホームページの92.07%、インナーページの92.93%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1856892869&format=interactive",
  sheets_gid="106300643",
  sql_file="lighthouse-seo-stats-2025.sql"
  )
}}

### Core Web Vitals

Core Web Vitalsは、読み込み（Largest Contentful Paint、LCP）、インタラクティビティ（現在はInteraction to Next Paint、INPで測定）、視覚的安定性（Cumulative Layout Shift、CLS）に焦点を当て、実際のユーザーがページをどのように体験するかを測定します。

{{ figure_markup(
  image="of-good-cwv-experiences-desktop.png",
  caption="良好なCore Web Vitalsエクスペリエンスの割合（デスクトップ）",
  description="2020年1月から2025年6月までのデスクトップでの良好なCore Web Vitalsエクスペリエンスの割合を示す折れ線グラフ。2025年6月、74%のページが良好なLargest Contentful Paint（LCP）スコアを達成し、72%が良好なCumulative Layout Shift（CLS）スコアを達成し、97%が良好なInteraction to Next Paint（INP）スコアを達成し、56%が良好な総合Core Web Vitalsスコアを達成しました。パフォーマンスはFIDを除くすべての指標で時間とともに着実に改善しており、FIDは2024年3月12日にInteraction to Next Paint（INP）指標に置き換えられるまで一貫して高い水準を維持していました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1199819818&format=interactive",
  sheets_gid="1335667521",
  sql_file="core-web-vitals-2025.sql"
  )
}}

{{ figure_markup(
  image="percentage-of-good-cwv-experiences-mobile.png",
  caption="良好なCore Web Vitalsエクスペリエンスの割合（モバイル）",
  description="2020年1月から2025年6月までのモバイルでの良好なCore Web Vitalsエクスペリエンスの割合を示す折れ線グラフ。2025年6月、62%のページが良好なLargest Contentful Paint（LCP）スコアを達成し、81%が良好なCumulative Layout Shift（CLS）スコアを達成し、77%が良好なInteraction to Next Paint（INP）スコアを達成し、48%が良好な総合Core Web Vitalsスコアを達成しました。パフォーマンスはすべての指標で時間とともに大幅に改善されており、FIDは2024年3月12日にInteraction to Next Paint（INP）指標に置き換えられるまで期間を通じて一貫して高い水準を維持していました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1667754305&format=interactive",
  sheets_gid="1335667521",
  sql_file="core-web-vitals-2025.sql"
  )
}}

2025年、Core Web Vitals全体のパフォーマンスは数年間の着実な前年比改善を経てほぼ安定しています。デスクトップはCore Web Vitalsパフォーマンスで引き続きリードし、約60%のページが「良好」な総合Core Web Vitalsエクスペリエンスを提供しており、モバイルの50%強と比較しています。この差は、より高速なハードウェア、より強力な接続、レイアウト制約が少ないといったデスクトップの固有の優位性を反映しています。

両プラットフォームにわたって、CLSが最も強い指標で、約75%のページが合格しています。しかし、LCPはモバイルで55〜60%近くにとどまり続けており、読み込み速度が今日のウェブサイトにとって最も持続的なCore Web Vitalsの課題であることを示しています。[研究が示すように](https://www.speedcurve.com/blog/psychology-site-speed/)、これはユーザー満足度に影響し、特にAI駆動の環境でオンラインコンバージョンにも影響を与える可能性があります。

2024年3月、特にモバイルで見られる目立つ低下は、Googleの<a hreflang="en" href="https://searchengineland.com/google-replace-fid-inp-core-web-vitals-414546#:~:text=On%20the%20left%2C%20long%20tasks,rankings%2C%E2%80%9D%20according%20to%20Splitt.">2024年3月のFirst Input Delay（FID）からInteraction to Next Paint（INP）への置き換え</a>への移行を反映しています。INPは展開前にパフォーマンスツールに表示され始め、FIDがしばしば見落としていたレスポンシブネスの問題を露呈する、より厳しいしきい値を導入しました。この段階的な変化は「良好な」ユーザーエクスペリエンスと見なされるバーを引き上げ、変更が発効したときの変動を説明しています。

### 画像の `loading` プロパティの使用状況

`loading` 属性はブラウザに画像をいつ取得してレンダリングするかを伝えます。速度とリソース使用のバランスをとるのに役立つ組み込みのパフォーマンスヒントです。動作を決定する2つの主な値があります：

- `lazy`: 画像が画面に表示されるまで読み込みを遅延させ、初期ページの重さを減らし、体感パフォーマンスを向上させます。
- `eager`: ページが読み込まれるとすぐに画像を取得し、ヒーローバナーやロゴなどのアバブザフォールドビジュアルの即時表示を確保します。

この属性により、開発者は異なるコンテキストで読み込み動作を微調整し、重要なビジュアルを優先しながら重要度の低いものを後回しにして読み込み時間と帯域幅効率を向上させることができます。

{{ figure_markup(
  image="image-loading-properties.png",
  caption="画像の `loading` プロパティ",
  description="ウェブサイト全体の画像読み込み属性の使用状況を示す棒グラフ。`lazy` 読み込み属性はデスクトップ画像の68.1%、モバイル画像の68.2%で使用されています。`eager` 読み込み属性はデスクトップ画像の26.5%、モバイル画像の26.6%で使用されています。`auto` 読み込み属性はデスクトップ画像の5.1%、モバイル画像の5.0%で使用されています。読み込み属性が欠如している画像はデスクトップとモバイルの両方で0.1%を占めます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1802101112&format=interactive",
  sheets_gid="2043457799",
  sql_file="image-loading-property-usage-2025.sql"
  )
}}

2025年、約68%の画像（デスクトップとモバイルの両方）に画像読み込み属性が設定されておらず、読み込み動作はブラウザのデフォルトに任されています。一方、約26%が遅延読み込みを使用し、わずか4〜5%のみが明示的にeager読み込みを使用しています。

{{ figure_markup(
  image="home-page-image-loading-properties.png",
  caption="ホームページの画像 `loading` プロパティ",
  description="ホームページでの画像 `loading` 属性の使用状況を示す棒グラフ。`missing` 読み込み属性はデスクトップホームページ画像の66.97%、モバイルホームページ画像の66.67%で使用されています。`lazy` 読み込み属性はデスクトップホームページ画像の27.30%、モバイルホームページ画像の27.66%で使用されています。`eager` 読み込み属性はデスクトップホームページ画像の5.40%、モバイルホームページ画像の5.43%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=186621260&format=interactive",
  sheets_gid="2043457799",
  sql_file="image-loading-property-usage-2025.sql"
  )
}}

{{ figure_markup(
  image="inner-page-image-loading-properties.png",
  caption="インナーページの画像 `loading` プロパティ",
  description="インナーページでの画像 `loading` 属性の使用状況を示す棒グラフ。`loading` 属性が欠如している画像はデスクトップインナーページ画像の69.86%、モバイルインナーページ画像の69.86%を占めます。`lazy` 読み込み属性はデスクトップインナーページ画像の25.34%、モバイルインナーページ画像の25.34%で使用されています。eager読み込み属性はデスクトップインナーページ画像の4.60%とモバイルインナーページ画像でも使用されています。`auto` 読み込み属性はデスクトップインナーページ画像の0.10%、モバイルインナーページ画像の0.10%で使用されています。無効な `loading` 属性を持つ画像はデスクトップとモバイルの両方のインナーページで0.06%を占めます。空白の `loading` 属性を持つ画像はデスクトップとモバイルの両方のインナーページで0.04%を占めます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=132795067&format=interactive",
  sheets_gid="2043457799",
  sql_file="image-loading-property-usage-2025.sql"
  )
}}

このパターンはページタイプ全体で一貫しています：

- ホームページ: デスクトップ27.3%、モバイル27.7%が遅延読み込み
- インナーページ: デスクトップ25.6%、モバイル25.3%が遅延読み込み

画像読み込み属性の欠如が多いことは、遅延読み込みの採用がパフォーマンス重視のサイトに集中している一方、多くの他のサイト（おそらくレガシーまたはCMS駆動のサイト）が明示的な読み込み戦略を実装していないことを示唆しています。`loading="lazy"` のほぼ普遍的なブラウザサポートとレスポンシブデザインを考慮すると、大多数の画像が体感パフォーマンスを向上させ帯域幅使用を削減するために明示的な遅延読み込みの恩恵を受けられます。

### iframeの `lazy` 読み込みと `eager` 読み込み

{{ figure_markup(
  image="iframe-image-loading-properties.png",
  caption="`iframe` の画像読み込みプロパティ",
  description="`iframe` 読み込み属性の使用パターンを示す棒グラフ。読み込み属性が欠如しているiframeはデスクトップサイトの91.5%、モバイルサイトの91.2%に表示されます。遅延読み込みと欠如属性を持つiframeはデスクトップサイトの9.5%、モバイルサイトの9.3%に表示されます。遅延読み込みを持つiframeはデスクトップサイトの3.2%、モバイルサイトの3.5%に表示されます。auto読み込みと欠如属性を持つiframeはデスクトップサイトの0.9%、モバイルサイトの0.8%に表示されます。eager読み込みと欠如属性を持つiframeはデスクトップサイトの0.2%、モバイルサイトの0.2%に表示されます。auto読み込みを持つiframeはデスクトップサイトの0.1%、モバイルサイトの0.1%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1842542140&format=interactive",
  sheets_gid="130917545",
  sql_file="iframe-loading-property-usage-2025.sql"
  )
}}

iframeに `loading="lazy"` を追加するだけで、ビューポートの近くまで読み込みが遅延され、[YouTube埋め込み](https://web.dev/articles/iframe-lazy-loading)で約500KB、[Facebookウィジェット](https://web.dev/learn/performance/lazy-load-images-and-iframe-elements)で約200KBを節約できます。しかし、2025年にiframeの読み込み属性は依然として著しく十分に活用されておらず、デスクトップページの91.5%、モバイルページの91.2%がiframe読み込みプロパティを宣言していません。これは2024年のデスクトップ92.8%、モバイル92.6%からわずかに低下しています。

明示的なiframe遅延読み込み属性は約13%のページに表示されており（3.5%が単独、9.3%が欠如宣言と混在）、しばしば宣言のないiframeと一緒に一貫性なく適用されています。前年と同様に、このパターンは出版社が制御を制限されている広告、動画、分析ダッシュボードなどの埋め込みサードパーティ要素の優位性を反映していると思われます。明示的な `eager` 宣言は事実上存在しないままで（デスクトップとモバイルの両方で0.2%）、単にブラウザのデフォルトを再述するだけです。大幅なパフォーマンス向上の機会があるにもかかわらず、iframeの遅延読み込みの採用は画像の遅延読み込みよりもはるかに遅れています。

この不一致は主に、広告、動画プレーヤー、分析ダッシュボードなどのサードパーティの埋め込みがiframeの使用を支配している方法を反映しています。これらの要素は外部で制御されているため、出版社は読み込み動作を定義したり属性を直接追加したりする能力が限られています。多くの場合、サードパーティのスクリプトは読み込み後に動的にiframeを注入するため、クローラーと監査はiframeが存在していても `loading` 属性を検出しません。その結果、表面上「欠如している」属性の一部は、真の省略ではなく測定における可視性のギャップを表している可能性があります。

これはまた開発者の優先度付けとも関係しています。チームは通常、制御が難しく増分的な利益が小さいiframe動作に対処する前に、ファーストパーティアセット（画像、スクリプト、Core Web Vitals）のパフォーマンスの最適化に焦点を当てます。

## オンページ

ページ構造は現在のAI駆動の環境においても依然として重要です。タイトル、メタディスクリプション、見出しは意味と意図を伝え、メディア属性は明確さとアクセシビリティを強化します。2025年のデータは、これらの要素の使用全体における安定性を示しており、大きな変化ではなく漸進的な調整を反映したわずかなシフトのみです。

### メタデータ

{{ figure_markup(
  image="title-tag-and-meta-description.png",
  caption="`title` タグとメタディスクリプション",
  description="ウェブサイト全体のtitleタグとメタディスクリプションの存在を示す棒グラフ。titleタグはデスクトップページの98.6%、モバイルページの98.5%に存在します。メタディスクリプションはデスクトップページの67.7%、モバイルページの67.2%に存在します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=870468193&format=interactive",
  sheets_gid="574446946",
  sql_file="seo-stats-2025.sql"
  )
}}

`title` タグの採用はほぼ普遍的なままで、2025年にはデスクトップページの98.62%、モバイルページの98.54%にわずかに増加しており、2024年のデスクトップ98.0%、モバイル98.2%から上昇しています。この安定性は、検索結果でタイトルが広く書き換えられているにもかかわらず、SEO戦略における要素の永続的な役割を反映しています。出版社はまだ、表示制御に関係なくtitleタグを基本的なものとして見ているようです。

一方、メタディスクリプションは異なる軌跡をたどっています。2022年のページの71%への表示から2024年のデスクトップ66.7%、モバイル66.4%へと低下した後、2025年にはデスクトップ67.7%、モバイル67.2%にわずかに回復しました。採用率は2022年の以前の水準には完全に回復していませんが、今年の上昇はGoogleが書き換えることがあっても、出版社がクリックスルーの最適化とクロスプラットフォームの一貫性のためにメタディスクリプションに価値を見出し続けていることを示唆しています。

### `title` 要素の長さ

`title` タグはユーザーとアルゴリズムの両方にとってページのトピックの最も明確なシグナルの一つですが、その効果は部分的に長さに依存します。短すぎるとコンテキストが不足し、長すぎると検索結果で切り捨てられるリスクがあります。2025年のデータは、出版社が2024年からほとんど変化なく、安定した中間点の周りにクラスタリングし続けていることを示しています。

{{ figure_markup(
  image="title-words-by-percentile.png",
  caption="パーセンタイル別のtitleの単語数",
  description="`title` タグの単語数分布をパーセンタイル別に示す棒グラフ。10パーセンタイルでは、`title` タグはデスクトップで3単語、モバイルで4単語を含みます。25パーセンタイルでは、デスクトップとモバイルの両方で7単語を含みます。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で12単語を含みます。75パーセンタイルでは、デスクトップとモバイルの両方で18単語を含みます。90パーセンタイルでは、デスクトップで24単語、モバイルで25単語を含みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=737860354&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

中央値のtitleタグはデスクトップとモバイルの両方で12単語を含み、昨年から変わっていません。75パーセンタイルでは18単語に増加し、90パーセンタイルではデスクトップで24単語、モバイルで25単語に延びます。

{{ figure_markup(
  image="title-characters-by-percentile.png",
  caption="パーセンタイル別のtitleの文字数",
  description="`title` タグの文字数分布をパーセンタイル別に示す棒グラフ。10パーセンタイルでは、`title` タグはデスクトップとモバイルの両方で28文字を含みます。25パーセンタイルでは、デスクトップで46文字、モバイルで47文字を含みます。50パーセンタイル（中央値）では、デスクトップで77文字、モバイルで79文字を含みます。75パーセンタイルでは、デスクトップで116文字、モバイルで117文字を含みます。90パーセンタイルでは、デスクトップで150文字、モバイルで154文字を含みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1675479095&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

中央値のtitleの長さはデスクトップで77文字、モバイルで79文字で、2024年とほぼ同じです。75パーセンタイルでは116〜117文字に上昇し、90パーセンタイルでは150〜154文字に達します。

これらの数値は、よく引用されるtitleの「安全な範囲」である50〜60文字を大幅に上回っており、表示が切り捨てられても出版社がキーワードカバレッジとコンテキストを優先していることを示唆しています。

2024年から2025年にかけてこのパターンが継続していることは、Googleの書き換えプラクティスを反映している可能性もあります。タイトルはSERPで頻繁に変更されるため、出版社はピクセルパーフェクトな表示制限に合わせて細かく調整する動機が少なくなっています。

### メタディスクリプションの長さ

{{ figure_markup(
  image="meta-description-words-by-percentile.png",
  caption="パーセンタイル別のメタディスクリプションの単語数",
  description="メタディスクリプションの単語数分布をパーセンタイル別に示す棒グラフ。10パーセンタイルでは、メタディスクリプションはデスクトップとモバイルの両方で4単語を含みます。25パーセンタイルでは、デスクトップで18単語、モバイルで19単語を含みます。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で40単語を含みます。75パーセンタイルでは、デスクトップとモバイルの両方で51単語を含みます。90パーセンタイルでは、デスクトップとモバイルの両方で79単語を含みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2126645889&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

{{ figure_markup(
  image="meta-description-chars-by-percentile.png",
  caption="パーセンタイル別のメタディスクリプションの文字数",
  description="メタディスクリプションの文字数分布をパーセンタイル別に示す棒グラフ。10パーセンタイルでは、メタディスクリプションはデスクトップで69文字、モバイルで70文字を含みます。25パーセンタイルでは、デスクトップで166文字、モバイルで168文字を含みます。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で274文字を含みます。75パーセンタイルでは、デスクトップで329文字、モバイルで330文字を含みます。90パーセンタイルでは、デスクトップで537文字、モバイルで533文字を含みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1000016762&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

分布パターンは2022年から2024年の急激な成長の後、ほぼ安定しています。今年のデータは以下を示しています：

- **中央値（50パーセンタイル）:** デスクトップとモバイルの両方で40単語、274文字と、2024年から変わりませんが、2022年の中央値19単語、約135文字の2倍以上です。
- **10パーセンタイル:** 4単語、約69〜70文字と、昨年と同じです。
- **25パーセンタイル:** 18〜19単語、166〜168文字。
- **75パーセンタイル:** 51単語、329〜330文字。
- **90パーセンタイル:** 79単語、533〜537文字。

この分布は、出版社が快適な範囲に落ち着いていることを確認しています：内容を提供するのに十分な長さで、一般的には約80単語または約540文字以下に抑えられています。Googleが頻繁にスニペットを書き換えても、適切に構造化されたディスクリプションを維持することで、サイト所有者はコンテンツが他の場所でどのように表示されるかに一定の影響力を持てます。

実際には、スニペットの表示はピクセル幅によって制限されており（デスクトップで<a hreflang="en" href="https://ux.stackexchange.com/questions/125770/does-the-980px-screen-width-rule-still-stand">約920〜980px</a>、モバイルで680px）、切り捨ては文字幅によって異なります。

このパターンが続けば、適切に構造化されたメタディスクリプションは従来のSERPシグナル以上のものになります：ページがAI駆動の要約や引用のために表示されるかどうかを決定するのに役立ちます。

### 見出しタグ

適切に構造化された見出しはテキストをフォーマットするだけでなく、ページの論理的な流れをマッピングし、読者とクローラーの両方を主なアイデアに案内します。2025年のデータは、すべての主要タグにわたる安定性を示しており、昨年からわずかなシフトのみです。

{{ figure_markup(
  image="presence-of-heading-elements.png",
  caption="見出し要素の存在",
  description="ウェブサイト全体の見出し要素の存在を示す棒グラフ。H1はデスクトップページの71%、モバイルページの70%に存在します。H2要素はデスクトップの72%、モバイルの71%に存在します。H3要素はデスクトップの60%、モバイルの60%に存在します。H4要素はデスクトップの37%、モバイルの36%に存在します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2085727321&format=interactive",
  sheets_gid="574446946",
  sql_file="seo-stats-2025.sql"
  )
}}

- `<h1>`: デスクトップページの71%、モバイルページの70%に存在します。空でない使用はわずかに低く、両方で66%です。
- `<h2>`: 最も広く採用されており、デスクトップページの72%、モバイルの71%で、ほぼすべてが空でありません。
- `<h3>`: 60%のページで使用されており、58%が空でなく、2024年から変わっていません。
- `<h4>`: デスクトップページの37%、モバイルの36%に存在し、35〜36%が意味のあるコンテンツを含んでいます。

見出しタグの採用は明らかに頭打ちになっています。以前の年には `<h1>` の成長と `<h3>`/`<h4>` の低下が見られましたが、2025年は安定したパターンを確認しています。

{{ figure_markup(
  image="non-empty-heading-elements.png",
  caption="空でない見出し要素",
  description="ウェブサイト全体の空でない見出し要素を示す棒グラフ。空でないH1要素はデスクトップページとモバイルページの66%に存在します。空でないH2要素はデスクトップページの71%、モバイルページの70%に存在します。空でないH3要素はデスクトップページとモバイルページの58%に存在します。空でないH4要素はデスクトップページの36%、モバイルページの35%に存在します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=813206574&format=interactive",
  sheets_gid="574446946",
  sql_file="seo-stats-2025.sql"
  )
}}

空でないデータは特に示唆に富んでいます。「存在する」と「空でない」のギャップは今やわずか数パーセントポイントで、2022年（デスクトップの `<h1>` の約6%が空）の大きなギャップと比較しています。これは、空の見出しが例外ではなく標準となった、よりクリーンでより意味的に構造化されたマークアップを示唆しています。

アクセシビリティとSEOを超えて、この見出し構造の改良はより広いトレンドとも一致しています：出版社がAI駆動プラットフォームのためにオンページの明確さを最適化しています。AIの概要、要約ツール、引用システムがクリーンなセマンティック階層に依存して情報を抽出・帰属させるようになるにつれ、適切に構造化された見出しはページのアイデアがAI出力で正確に表現・クレジットされることを保証する一部となっています。

それでも進歩には限界があります。`<h1>` はページの70%に表示されていますが、空でないのは66%のみです。この4%のギャップは上限効果を示しており、採用率が100%に達することは考えにくい自然な上限です。シングルページアプリやミニマリストのホームページなど、一部のデザインは意図的に意味のある `<h1>` をスキップします。これらのケースはエラーではなくデザインの選択を反映しています。

### 画像

2025年の画像使用データは以前の年との幅広い一貫性を示していますが、サイトの上位層に向けて画像使用が劇的にスケールアップすることも強調しています。

{{ figure_markup(
  image="home-page-images-per-device.png",
  caption="デバイスごとのホームページの画像数",
  description="パーセンタイル別のホームページの画像数の分布を示す棒グラフ。10パーセンタイルでは、ホームページはデスクトップとモバイルの両方で2枚の画像を持ちます。25パーセンタイルでは、デスクトップとモバイルの両方で8枚。50パーセンタイルではデスクトップで20枚、モバイルで19枚。75パーセンタイルではデスクトップで44枚、モバイルで41枚。90パーセンタイルではデスクトップで85枚、モバイルで80枚。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1589362695&format=interactive",
  sheets_gid="1260634277",
  sql_file="image-alt-stats-2025.sql"
  )
}}

{{ figure_markup(
  image="images-per-page.png",
  caption="ページごとの画像数",
  description="パーセンタイル別のページごとの画像数の分布を示す棒グラフ。10パーセンタイルでは、ページはデスクトップで4枚、モバイルで3枚の画像を持ちます。25パーセンタイルでは、デスクトップで16枚、モバイルで8枚。50パーセンタイル（中央値）では、デスクトップで39枚、モバイルで21枚。75パーセンタイルでは、デスクトップで85枚、モバイルで52枚。90パーセンタイルでは、デスクトップで165枚、モバイルで109枚。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1981015938&format=interactive",
  sheets_gid="1260634277",
  sql_file="image-alt-stats-2025.sql"
  )
}}

- 中央値（50パーセンタイル）では、ホームページにはデスクトップで20枚、モバイルで19枚の画像があります。
- 75パーセンタイルでは、画像数はデスクトップで44枚、モバイルで41枚に増加します。
- 90パーセンタイルでは、画像の使用はデスクトップで85枚、モバイルで80枚にさらに跳ね上がります。

比較すると、25パーセンタイルはわずか8枚の画像で、ホームページデザインの幅広いバリエーションを示しています。しかし分布全体にわたって、デスクトップとモバイルの数値は密接に一致しており、レスポンシブデザインプラクティスがデバイス間で画像使用を一貫させていることを示唆しています。

#### `alt` 属性

`alt` 属性はアクセシビリティの中心であり、検索での画像インデックスもサポートしています。今年は採用に着実な改善が見られ、全体的に欠如している属性が減っていますが、注目すべき空白値のわずかな増加もあります。

{{ figure_markup(
  image="percentage-of-image-alt-attributes-present.png",
  caption="画像のalt属性が存在する割合",
  description="パーセンタイル別の画像alt属性の存在分布を示す棒グラフ。10パーセンタイルでは、デスクトップとモバイルの両方で0%の画像にalt属性があります。25パーセンタイルでは、デスクトップの17%、モバイルの16%の画像にalt属性があります。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で60%の画像にalt属性があります。75パーセンタイルでは、デスクトップとモバイルの両方で93%の画像にalt属性があります。90パーセンタイルでは、デスクトップとモバイルの両方で100%の画像にalt属性があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=903246628&format=interactive",
  sheets_gid="1260634277",
  sql_file="image-alt-stats-2025.sql"
  )
}}

中央値では、モバイルページの画像の60%が `alt` 属性を含んでおり、2024年の58%から増加しています。90パーセンタイルでは採用率が100%に達し、出版社の相当数がすべての画像に一貫してalt テキストを適用していることを示しています。

{{ figure_markup(
  image="percentage-of-image-with-blank-image-alt.png",
  caption="空白のimage altを持つ画像の割合",
  description="パーセンタイル別の空白alt属性を持つ画像の分布を示す棒グラフ。10パーセンタイルと25パーセンタイルでは、デスクトップとモバイルの両方で0%の画像に空白alt属性があります。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で15.38%の画像に空白alt属性があります。75パーセンタイルでは、デスクトップの57%、モバイルの58%の画像が空白です。90パーセンタイルでは、デスクトップの89%、モバイルの90%の画像が空白です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1901156374&format=interactive",
  sheets_gid="1260634277",
  sql_file="image-alt-stats-2025.sql"
  )
}}

中央値では、モバイルページの画像の15%が空白の `alt` 値を持っており、2024年の14%からわずか1ポイント増加しています。75パーセンタイルでは58%が空白で、90パーセンタイルでは90%が空白となり、いずれも昨年より1ポイント高くなっています。増加は小さいですが、すべての採用が意味のある説明に転換されているわけではないという懸念を示しています。

{{ figure_markup(
  image="percentage-of-image-with-alt-image-missing.png",
  caption="altが欠如している画像の割合",
  description="パーセンタイル別のalt属性が欠如している画像の分布を示す棒グラフ。10パーセンタイルと25パーセンタイルでは、デスクトップとモバイルの両方で0%の画像にalt属性が欠如しています。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で15%の画像にalt属性が欠如しています。75パーセンタイルでは、デスクトップの57%、モバイルの58%の画像にalt属性が欠如しています。90パーセンタイルでは、デスクトップの89%、モバイルの90%の画像にalt属性が欠如しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=385799990&format=interactive",
  sheets_gid="1260634277",
  sql_file="image-alt-stats-2025.sql"
  )
}}

中央値のページは再び `alt` の欠如が見られず、12〜13%のページが完全に欠如していた2022年からのポジティブなトレンドが続いています。

より広い変化は「欠如」から「空白」へのシフトのようです。画像には属性が配置される可能性が高くなっていますが、常に説明的なコンテンツが伴うわけではありません。空白は省略より望ましいですが、スクリーンリーダーと検索エンジンに対して限られた価値しか提供しません。

空白の増加は劇的ではなく小さく安定しているものの、技術的なコンプライアンスと意味のあるアクセシビリティの差を依然として浮き彫りにしています。2025年のホームページ画像数が最少8枚から80枚以上にわたることを考えると、思慮深いaltテキストの重要性は増すばかりです。ウェブは明らかに正しい方向に進んでいますが、課題はカバレッジの進歩がアクセシビリティと意味においても進歩をもたらすことを保証することです。

### 動画

{{ figure_markup(
  image="percentage-of-pages-with-video.png",
  caption="動画があるページの割合",
  description="動画要素を含むページの割合を示すグラフ。動画はデスクトップページの6.40%、モバイルページの5.68%に存在します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1648531612&format=interactive",
  sheets_gid="313625928",
  sql_file="pages-containing-a-video-element-2025.sql"
  )
}}

ウェブ上での動画の採用は続いて成長していますが、緩やかです。2025年には、デスクトップページの6.40%、モバイルページの5.68%に動画要素が含まれており、2024年のデスクトップ5.87%、モバイル5.13%からわずかに増加しています。デスクトップページはまだモバイルよりも動画を多く掲載しており、昨年と同じギャップを繰り返しています。

この控えめな成長は、画像と比較して動画の制作および実装コストが高いことを反映しているかもしれません。しかし、長期的なトレジェクトリは上昇傾向のままです。SEOがより包括的になり、ブランディングがウェブ全体で最も強いシグナルの一つとして浮上するにつれ、動画は権威とクロスチャネルの視認性を強化する上でより大きな役割を果たす可能性があります。

より大きな課題は最適化です。動画がより頻繁に登場している一方で、2024年にVideoObjectマークアップを使用したのはページの0.9%のみで、ほとんどの動画コンテンツがリッチリザルトに見えないままになっています。構造化データの採用が増えるまで、動画のSEOポテンシャルの多くは未活用のままです。

## リンク

リンクは依然として重要性の重要なシグナルです。しかし、リンクが多いだけでランキングが上がる時代はほぼ終わりました。今日のリンクシグナル（内部・外部）はコンテンツの品質、関連性、ユーザーエクスペリエンスとバランスよく組み合わされています。

2025年のデータは、リンクプラクティスが成熟していることを示しており、説明的なアンカー、内部ナビゲーション、外部参照において安定したパターンが見られ、関係を修飾するためのrelなどの属性の選択的な使用もあります。

### 非説明的なリンク

2025年、ほとんどのサイトが「ここをクリック」や「もっと読む」などの漠然とした表現よりも説明的なアンカーテキストを提供し続けています。これはLighthouseのテスト合格率に反映されており、ホームページとインナーページの両方で高い水準を維持しています。

- 2024年: ホームページはデスクトップ84%、モバイル91%で合格し、インナーページはデスクトップ86%、モバイル92%とより強い結果でした。
- 2025年: ホームページはデスクトップ84.64%、モバイル86.64%とほぼ変わらず、しかしインナーページはデスクトップ92.42%、モバイル93.45%に改善しました。

ホームページとインナーページの差は持続しており、インナーページが一貫して約6〜9ポイント高くなっています。これはホームページが汎用のナビゲーションとプロモーション用CTAに依存しやすい一方、インナーページは自然とより説明的なコンテキスト・コンテンツ駆動のリンクを使用しているためと考えられます。デバイス間のパリティは近く、レスポンシブデザインプラクティスがデバイス間のアクセシビリティ標準を効果的に維持していることを示しています。

全体として、説明的なリンクプラクティスは成熟しており、前年比のわずかな変化のみです。残る機会は、漠然としたCTAがまだ最も一般的なホームページリンクの明確さを改善することにあります。

{{ figure_markup(
  image="pages-passing-links-have-descriptive-text.png",
  caption="説明的なテキストを持つリンクが通過するページ",
  description="説明的なテキストを持つリンクがあるページの割合を示す棒グラフ。ホームページはデスクトップサイトの84.64%、モバイルサイトの86.64%で説明的なリンクテキストを持ちます。インナーページはデスクトップサイトの92.42%、モバイルサイトの93.45%で説明的なリンクテキストを持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=791832113&format=interactive",
  sheets_gid="106300643",
  sql_file="lighthouse-seo-stats-2025.sql"
  )
}}

### 発信リンク

2025年の発信リンクは、内部および外部リンクの両方で安定したパターンを示しています。内部リンクが優勢で、中央値ではデスクトップページが同一サイトへの43リンク、モバイルページが39リンクを含んでいたのに対し、90パーセンタイルではそれらの数字が174と161に跳ね上がりました。

上位に向けた急激な上昇は、大規模または複雑なサイト（ニュースメディア、eコマースプラットフォーム、エンタープライズポータルなど）がメガメニューや密集したフッターを通じて広範なナビゲーションを表示する方法を反映しているかもしれません。デスクトップページは一貫してモバイルよりも数リンク多く表示していますが、開発者は使いやすさのために小さな画面でメニューを合理化しながらも、主要なパスウェイは維持しています。

外部リンクははるかに少ないままです。中央値のページはデスクトップとモバイルの両方でわずか6つの発信リンクを含んでおり、90パーセンタイルでもその数は25と24にしか達しません。これは2022年を反映した2024年でも記録されたフラットなトレンドを継続しています。

内部リンクは長年にわたって着実に成長している一方、外部リンクは保守的なままで、おそらく出版社がユーザーを自分のエコシステム内に留めることに焦点を当てていることを反映しています。合わせて、これらの数値は成熟した均衡を示唆しています。内部リンクはナビゲーションとクロール可能性をサポートするために成長する一方、外部リンクは控えめなレベルで安定しています。

{{ figure_markup(
  image="outgoing-links-to-the-same-site.png",
  caption="同一サイトへの発信リンク",
  description="パーセンタイル別の同一サイトへの発信リンクの分布を示す棒グラフ。10パーセンタイルでは、デスクトップで7つ、モバイルで6つの同一サイトへの発信リンクがあります。25パーセンタイルでは、デスクトップで19、モバイルで17。50パーセンタイルでは、デスクトップで43、モバイルで39。75パーセンタイルでは、デスクトップで89、モバイルで82。90パーセンタイルでは、デスクトップで174の発信リンク、モバイルで161。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=977071429&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

{{ figure_markup(
  image="outgoing-links-to-external-sites.png",
  caption="外部サイトへの発信リンク",
  description="パーセンタイル別の外部サイトへの発信リンクの分布を示す棒グラフ。10パーセンタイルでは、デスクトップとモバイルの両方で1つの外部サイトへの発信リンクがあります。25パーセンタイルでは、デスクトップで3つ、モバイルで2つの発信リンクがあります。50パーセンタイル（中央値）では、デスクトップとモバイルの両方で6つの発信リンクがあります。75パーセンタイルでは、デスクトップで13、モバイルで12の発信リンクがあります。90パーセンタイルでは、デスクトップで25、モバイルで24の発信リンクがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=209692578&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

### アンカーの `rel` 属性の使用

`rel` 属性はもともと検索エンジンのためにリンクを修飾するためのものでしたが、今日最も一般的な使用はセキュリティに焦点を当てています。2025年、noopenerはページの40.9%に、noreferrerは25%に表示されます。どちらもランキングには影響しませんが、タブハイジャックを防いで参照データを隠すことでサイトの健全性を高めユーザーを保護するため、広く採用されています。

検索関連の修飾子については、`nofollow` が32.3%のページで引き続き優位を占め、2024年の水準とほぼ同じです。対照的に、より特定的な `sponsored` と `ugc` 属性はそれぞれ0.5%で停滞したままです。Googleが細かい分類を推進する取り組みにもかかわらず、採用は動いておらず、ウェブマスターが「`nofollow` 対通常リンク」の大まかな区別を超えた価値をほとんど見出していないことを示唆しています。

総合すると、データはrel属性の使用パターンがほぼ安定していることを示しており、前年比の動きはほとんどありません。セキュリティプラクティスが使用をリードし、SEO修飾子は安定したままで、実験的な属性は勢いを示しません。dofollowやfollowなどの古い属性でさえ、0.5%未満のページにとどまっており、古いSEOの神話がウェブの小さな隅で実際の影響なく反響し続けていることを思い起こさせます。

{{ figure_markup(
  image="anchor-rel-attribute-usage.png",
  caption="アンカー `rel` 属性の使用",
  description="ウェブサイト全体のアンカー `rel` 属性の使用状況を示す棒グラフ。`noopener` 属性はデスクトップの41.8%、モバイルサイトの40.9%に表示されます。`nofollow` 属性はデスクトップの30.8%、モバイルサイトの32.3%に表示されます。`noreferrer` 属性はデスクトップの25.5%、モバイルサイトの25%に表示されます。`ugc` 属性はデスクトップの0.6%、モバイルサイトの0.5%に表示されます。`sponsored` 属性はデスクトップの0.5%、モバイルサイトの0.5%に表示されます。`follow` 属性はデスクトップの0.4%、モバイルサイトの0.4%に表示されます。`dofollow` 属性はデスクトップの0.3%、モバイルサイトの0.4%に表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=59900496&format=interactive",
  sheets_gid="359942313",
  sql_file="anchor-rel-attribute-usage-2025.sql"
  )
}}

## ワード数

ワード数はSEOで長い間議論されてきた点で、コンテンツの品質や徹底さの代理指標として扱われることが多くあります。それにもかかわらず、ページの適切な長さについてのコンセンサスはほとんどありません。このセクションでは、生のページとレンダリングされたページにわたるワード数の分布を検討します。

### レンダリングされたワード数

レンダリングされたワード数とは、JavaScriptが実行された後のページ上の可視の単語数を指します。

#### ホームページのレンダリングされたワード数

{{ figure_markup(
  image="home-page-rendered-visible-words-by-percentile.png",
  caption="パーセンタイル別のホームページのレンダリングされた可視単語数",
  description="パーセンタイル別のホームページのレンダリングされた可視単語数の分布を示す棒グラフ。10パーセンタイルでは、ホームページはデスクトップで75、モバイルで69のレンダリングされた可視単語を持ちます。25パーセンタイルでは、デスクトップで196、モバイルで177。50パーセンタイル（中央値）では、デスクトップで413、モバイルで378。75パーセンタイルでは、デスクトップで760、モバイルで703。90パーセンタイルでは、デスクトップで1,295、モバイルで1,191のレンダリングされた可視単語を持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=184044274&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

2025年のモバイルホームページの中央値は378単語を含んでおり、2024年の中央値364単語からわずかに増加しています。デスクトップホームページのレンダリングされた中央値ワード数も前年比でわずかに増加しており、2025年は413単語（2024年の400単語から増加）を示しています。
モバイルとデスクトップのレンダリングされたワード数は2022年以降、デスクトップ中央値421単語、モバイル366単語だったものが低下を見せています。2025年のデスクトップとモバイルのパリティは昨年と比較してわずかに近づいており、モバイルとデスクトップのホームページワード数の差がわずか35単語に縮小し、デスクトップとモバイルのパリティが36単語だった2024年のレポートから1減少しています。これは年間を通じての一定の一貫性を示しています。

#### インナーページのレンダリングされたワード数

{{ figure_markup(
  image="inner-page-rendered-visible-words-by-percentile.png",
  caption="パーセンタイル別のインナーページのレンダリングされた可視単語数",
  description="パーセンタイル別のインナーページのレンダリングされた可視単語数の分布を示す棒グラフ。10パーセンタイルでは、インナーページはデスクトップで76、モバイルで64のレンダリングされた可視単語を持ちます。25パーセンタイルでは、デスクトップで161、モバイルで142。50パーセンタイル（中央値）では、デスクトップで339、モバイルで323。75パーセンタイルでは、デスクトップで668、モバイルで675。90パーセンタイルでは、デスクトップで1,232、モバイルで1,313のレンダリングされた可視単語を持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=90196654&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

インナーページはホームページと比較して単語数が少ない傾向があります。2025年のモバイルインナーページの中央値はデスクトップで339単語、モバイルで323単語でした（デスクトップの中央値が333、モバイルが317だった2024年から増加しています）。

ここでのパーセンタイルは、インナーページの全データセットに対するページのワード数の位置を表しています。たとえば、90パーセンタイルはテストされたページの90%より多くの単語を持つページを反映しています。興味深いことに、50パーセンタイルまでは、デスクトップのインナーページが一般的にモバイルのインナーページより多くの単語を持つ傾向がありますが、パーセンタイルが高くなるにつれて差が縮まります。90パーセンタイルでは、デスクトップと比較してモバイルのインナーページワード数が大幅に増加しています。このトレンドは、デスクトップが常に高いワード数を持つホームページコンテンツでは見られません。

### 生のワード数

生のワード数とは、JavaScriptの実行またはDOMやCSSOMへのその後の変更の前に、サーバーから配信される元のHTMLに含まれる単語の総数を指します。

#### ホームページの生のワード数

{{ figure_markup(
  image="home-page-visible-raw-words-by-percentile.png",
  caption="パーセンタイル別のホームページの可視生単語数",
  description="パーセンタイル別のホームページの可視生単語数の分布を示す棒グラフ。10パーセンタイルでは、ホームページはデスクトップで50、モバイルで46の可視生単語を持ちます。25パーセンタイルでは、デスクトップで151、モバイルで138。50パーセンタイル（中央値）では、デスクトップで340、モバイルで316。75パーセンタイルでは、デスクトップで634、モバイルで597。90パーセンタイルでは、デスクトップで1,083、モバイルで1,026の可視生単語を持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=605750705&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

2025年のページの生のワード数の中央値は、デスクトップユーザーエージェントで340単語、モバイルで316単語と、デスクトップで330単語、モバイルで311単語だった2024年からわずかに増加しています。

#### インナーページの生のワード数

{{ figure_markup(
  image="inner-page-visible-raw-words-by-percentile.png",
  caption="パーセンタイル別のインナーページの可視生単語数",
  description="パーセンタイル別のインナーページの可視生単語数の分布を示す棒グラフ。10パーセンタイルでは、インナーページはデスクトップで48、モバイルで42の可視生単語を持ちます。25パーセンタイルでは、デスクトップで121、モバイルで108。50パーセンタイル（中央値）では、デスクトップで280、モバイルで271。75パーセンタイルでは、デスクトップで587、モバイルで604。90パーセンタイルでは、デスクトップで1,109、モバイルで1,204の可視生単語を持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=536665933&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

どのパーセンタイルでもモバイルがデスクトップより多くの単語を含まなかったホームページの生のワード数とは異なり、インナーページの可視ワード数は75パーセンタイル以上でデスクトップページがモバイルページより少ない単語数を示しています。

### レンダリングされたワード数と生のワード数

ホームページでレンダリングされたワード数と生のワード数を比較すると、差異は小さく、中央値ではデスクトップで18%、モバイルで16%の差を示しています。これはモバイルで成長が見られており、2024年はわずか14%でした。

すべてのパーセンタイルにわたって、デスクトップユーザーエージェントに提供されるホームページは、モバイルと比較してレンダリング後に可視化される単語の割合が高くなっています。これはモバイルでのアコーディオンのような、DOMにレンダリングされていてもコンテンツが非表示になる一般的なレイアウトによるものと思われます。

モバイルとデスクトップのすべてのパーセンタイルにわたる最大の差異はわずか2%で、10パーセンタイルのような低いパーセンタイルでは等しいワード数を示しています。

#### ホームページのレンダリングされたワード数と生のワード数

{{ figure_markup(
  image="home-page-rendered-vs-raw-diff-by-percentile.png",
  caption="パーセンタイル別のホームページのレンダリングと生の差分",
  description="パーセンタイル別のホームページのレンダリングされたワード数と生のワード数の差を比率として示す棒グラフ。10パーセンタイルでは、デスクトップとモバイルの両方でレンダリングから生のワード数比率は33%です。25パーセンタイルでは、デスクトップで23%、モバイルで22%。50パーセンタイル（中央値）では、デスクトップで18%、モバイルで16%。75パーセンタイルでは、デスクトップで17%、モバイルで15%。90パーセンタイルでは、デスクトップで16%、モバイルで14%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1342963015&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

2025年、10パーセンタイルでデスクトップ37%、モバイル34%と大幅な上昇が見られ、2024年のデスクトップ28%、モバイル22%と比較しています。

#### インナーページのレンダリングされたワード数と生のワード数

{{ figure_markup(
  image="inner-page-rendered-vs-raw-diff-by-percentile.png",
  caption="パーセンタイル別のインナーページのレンダリングと生の差分",
  description="パーセンタイル別のインナーページのレンダリングされたワード数と生のワード数の差を比率として示す棒グラフ。10パーセンタイルでは、デスクトップで37%、モバイルで34%のレンダリングから生のワード数比率です。25パーセンタイルでは、デスクトップで25%、モバイルで24%。50パーセンタイル（中央値）では、デスクトップで17%、モバイルで16%。75パーセンタイルでは、デスクトップで12%、モバイルで11%。90パーセンタイルでは、デスクトップで10%、モバイルで8%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=753836011&format=interactive",
  sheets_gid="371538594",
  sql_file="seo-stats-by-percentile-2025.sql"
  )
}}

インナーページのレンダリングされたワード数と生のワード数の差は10パーセンタイルで最大のギャップが見られ、アコーディオンやタブレイアウトなどのモバイルブレークポイントでHTMLには存在するがモバイルでは非表示になっているコンテンツへの依存によるものと思われます。25、50、75パーセンタイルではわずか1%の差でギャップが縮まり、90パーセンタイルでは2%となります。

このパターンは単語が多いほど、クライアントサイドのレンダリングへの依存が少ないようで、これは2024年のチャプターでも同様でした。

## 構造化データ

直接のランキング要因ではないものの、構造化データは検索エンジンがページのコンテキストを理解するのを助け、検索エンジン結果ページ（SERP）でリッチリザルトを表示するための強力な手段として引き続き重要です。

<a hreflang="en" href="https://insightland.org/blog/structured-data-ai-search/">構造化データ</a>は、大規模言語モデルがページの「内容」だけでなく「意味」を理解するためにも活用されるようになっています。MicrosoftはBingが<a hreflang="en" href="http://schema.org">schema.orgマークアップ</a>を使用して、専門家記事・製品・レビュー・FAQをBing ChatやCopilotが区別できるようにしていることを認めています。Googleの<a hreflang="en" href="https://www.semrush.com/blog/how-can-schema-markup-specifically-enhance-llm-visibility/">AIオーバービュー</a>の動作も同様の依存を示唆しており、GPTBotなどのクローラーは状況によってはHTML内に埋め込まれたスキーマを解析できます。

### ホームページの構造化データ

{{ figure_markup(
  image="home-page-use-of-structured-data-by-format.png",
  caption="Home page use of structured data by format",
  description="Bar chart showing structured data format usage on home pages. JSON-LD format is used on 43% of desktop home pages and 43% of mobile home pages. Microdata format is used on 17% of desktop home pages and 16% of mobile home pages. Microformats2 format is used on 0.14% of desktop home pages and 0.17% of mobile home pages. RDFa format is used on 1% of desktop home pages and 1% of mobile home pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=98889259&format=interactive",
  sheets_gid="1715613851",
  sql_file="structured-data-formats-2025.sql"
  )
}}

構造化データの全体的な使用率は、2024年のデスクトップ48%・モバイル49%と比べ、2025年はデスクトップ・モバイルともに50%に成長しました。

大半のサイトは生のHTMLで構造化データを提供しており、JavaScriptで追加するケースはモバイル・デスクトップともに2%のみ（2024年から変化なし）です。

GoogleはJavaScriptで注入されたスキーマも処理できますが、初期HTMLに含めることで処理の遅延・クロールの問題・ユーザー体験の低下を防ぐことができます。

JSON-LDはホームページで圧倒的に人気のフォーマットで、2024年のデスクトップ41%・モバイル40%と比べ、2025年はデスクトップ・モバイルともに43%を占めています。

Googleは通常、[JSON-LD構造化データの使用を推奨しています](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data)。実装・保守が最も簡単なためですが、MicrodataやRDFaなど他のフォーマットもクロール・解析は可能です。Microdataの使用率はデスクトップ・モバイルともに2024年比で1%低下しています。

### インナーページの構造化データ

{{ figure_markup(
  image="inner-page-use-of-structured-data-by-format.png",
  caption="Inner page use of structured data by format",
  description="Bar chart showing structured data format usage on inner pages. JSON-LD format is used on 39% of desktop inner pages and 37% of mobile inner pages. Microdata format is used on 19% of desktop inner pages and 19% of mobile inner pages. Microformats2 format is used on 0.2% of desktop inner pages and 0.2% of mobile inner pages. RDFa format is used on 2% of desktop inner pages and 2% of mobile inner pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=518770957&format=interactive",
  sheets_gid="1715613851",
  sql_file="structured-data-formats-2025.sql"
  )
}}

インナーページでは若干の差異が見られ、Microdataはモバイル・デスクトップともに19%、JSON-LDはデスクトップ39%に対してモバイルは37%となっています。

これはホームページが最も多くのSEO対策を受けており、OrganizationやWebsiteスキーマなどのグローバルサイトテンプレートを通じて、手動またはJSON-LDで直接実装される可能性が高いためかもしれません。ホームページはリッチリザルトやブランドナレッジパネルで優先されることが多いため、JSON-LDの採用率はデバイス間でより高く一貫している傾向があります。

一方、製品ページや記事ページなどのインナーページは、デスクトップとモバイルのテンプレートによって異なる動的またはCMS生成マークアップに依存することが多く、若干の差異が生じます。

### 最も人気の高い構造化データタイプ

{{ figure_markup(
  image="home-page-structured-data-use.png",
  caption="ホームページの構造化データ使用状況",
  description="ホームページで使用される最も人気の高い構造化データタイプを示す棒グラフ。schema.org/WebSiteタイプはデスクトップホームページの37%、モバイルホームページの36%に出現。schema.org/SearchActionタイプはデスクトップホームページの28%、モバイルホームページの28%に出現。schema.org/Organizationタイプはデスクトップホームページの26.74%、モバイルホームページの26%に出現。schema.org/WebPageタイプはデスクトップホームページの25%、モバイルホームページの25%に出現。schema.org/-UnknownType-はデスクトップホームページの24%、モバイルホームページの24%に出現。schema.org/ListItemタイプはデスクトップホームページの21%、モバイルホームページの21%に出現。schema.org/BreadcrumbListタイプはデスクトップホームページの21%、モバイルホームページの21%に出現。schema.org/ImageObjectタイプはデスクトップホームページの21%、モバイルホームページの21%に出現。schema.org/EntryPointタイプはデスクトップホームページの17%、モバイルホームページの17%に出現。schema.org/ReadActionタイプはデスクトップホームページの14%、モバイルホームページの14%に出現。その他のSchema.orgタイプもチャートに表示。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2020786426&format=interactive",
  sheets_gid="943142477",
  sql_file="structured-data-schema-types-2025.sql",
  width=600,
  height=432
  )
}}

最も人気の高い構造化データタイプ上位2位に大きな変化はなく、2022年・2024年・2025年を通じてWebSiteとSearchActionが最も人気です。これらはGoogleのサイトリンク検索ボックスを機能させるものですが、視覚的には2024年11月に廃止されました。ただし、それを支える構造化データを削除する必要はありません。

Organizationスキーマの人気が若干上昇し、2025年のデータでは初めてWebPage スキーマ（Web**Site**スキーマと混同しないでください）を上回りました。

WebSiteスキーマは引き続きすべての構造化データタイプの中で最も人気で、2025年のモバイルでは2024年の35%・2022年の30%と比べ36%に若干増加しました。モバイルの構造化データ使用率は年ごとの差異が小さいです。

{{ figure_markup(
  image="inner-page-structured-data-use.png",
  caption="インナーページの構造化データ使用状況",
  description="インナーページで使用される最も人気の高い構造化データタイプを示す棒グラフ。schema.org/ListItemタイプはデスクトップインナーページの29%、モバイルインナーページの27%に出現。schema.org/BreadcrumbListタイプはデスクトップインナーページの28%、モバイルインナーページの27%に出現。schema.org/WebSiteタイプはデスクトップインナーページの26%、モバイルインナーページの25%に出現。schema.org/Organizationタイプはデスクトップインナーページの26%、モバイルインナーページの25%に出現。schema.org/-UnknownType-はデスクトップインナーページの26%、モバイルインナーページの25%に出現。schema.org/WebPageタイプはデスクトップインナーページの25%、モバイルインナーページの24%に出現。schema.org/ImageObjectタイプはデスクトップインナーページの22%、モバイルインナーページの21%に出現。schema.org/SearchActionタイプはデスクトップインナーページの17%、モバイルインナーページの16%に出現。schema.org/EntryPointタイプはデスクトップインナーページの15%、モバイルインナーページの14%に出現。schema.org/ReadActionタイプはデスクトップインナーページの14%、モバイルインナーページの13%に出現。その他のSchema.orgタイプもチャートに表示。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1147706334&format=interactive",
  sheets_gid="943142477",
  sql_file="structured-data-schema-types-2025.sql",
  width=600,
  height=432
  )
}}

インナーページでは、ListItem構造化データが引き続き最も人気のインナーページスキーマタイプですが、モバイルの使用率は2024年の30%から2025年の27%に低下しています。

興味深いことに、WebSite構造化データはホームページ固有のスキーマタイプであるにもかかわらず（少なくとも[Googleによれば](https://developers.google.com/search/docs/appearance/structured-data/organization?_gl=1*jf94bx*_up*MQ..*_ga*OTY2MjgzMjIwLjE3NjIzMjkyODU.*_ga_SM8HXJ53K2*czE3NjIzMjkyODQkbzEkZzAkdDE3NjIzMjkzMDIkajQyJGwwJGgw#guidelines)）、インナーページでも3番目に人気の構造化データタイプです。これは多くの種類のスキーマがCMSレベルでテンプレート化されており、インナーページにも複製されているためかもしれません。

スキーマの使用状況の詳細については、専用の[構造化データ](./structured-data)チャプターをご覧ください。

## AMP

Accelerated Mobile Pages（AMP）はかつて、特にモバイル検索におけるパフォーマンスと視認性を高める近道として推進されていました。しかし、すべてのページに直接パフォーマンス指標を提供するCore Web Vitalsが登場したことで、AMPの役割は急激に縮小しました。2025年のデータでは、ホームページ・インナーページを通じて採用率は一貫して低く、1%を下回るままです。残存する使用はニッチなまたはレガシーな実装を反映しており、主流の戦略とはなっていません。

### ホームページのAMP使用状況

{{ figure_markup(
  image="home-page-amp-markup-desktop-vs-mobile.png",
  caption="ホームページのAMPマークアップ：デスクトップ対モバイル",
  description="ホームページにおけるAMPマークアップの使用状況をデスクトップとモバイルで比較した棒グラフ。HTML AMPはデスクトップホームページの0.03%、モバイルホームページの0.2%に出現。AMP Emojiはデスクトップホームページの0.01%、モバイルホームページの0.1%に出現。AMP HTMLまたはEmojiはデスクトップホームページの0.04%、モバイルホームページの0.3%に出現。Rel AMPはデスクトップホームページの0.3%、モバイルホームページの0.7%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1374602633&format=interactive",
  sheets_gid="792475547",
  sql_file="mark-up-stats-2025.sql"
  )
}}

AMPマークアップの採用は2025年も極めて低い水準にとどまり、インナーページではすべてのデバイスタイプでわずかな使用しか見られません。`rel=amphtml` が最も一般的なシグナルで、デスクトップページの0.8%、モバイルページの0.9%に出現しています。HTML AMPはモバイルページのわずか0.1%に見られ、デスクトップではほぼゼロです。AMP EmojiやAMP HTML + Emojiなど他のバリアントはほぼ存在せず、0.2%以下です。

2024年と比較すると、全体的な状況は停滞と言えます。2024年に見られた若干の上昇は継続せず、使用率は引き続き1%を大きく下回ったままです。GoogleがTop Storiesの要件からAMPを外したことと、Core Web VitalsがユニバーサルなパフォーマンスメトリクスとしてAMPの地位を確実にフリンジテクノロジーに押し込んでいます。

### ホームページ対インナーページのAMP使用状況

{{ figure_markup(
  image="inner-page-amp-markup-desktop-vs-mobile.png",
  caption="インナーページのAMPマークアップ：デスクトップ対モバイル",
  description="インナーページにおけるAMPマークアップの使用状況をデスクトップとモバイルで比較した棒グラフ。HTML AMPはデスクトップインナーページの0.03%、モバイルインナーページの0.1%に出現。AMP Emojiはデスクトップインナーページの0.01%、モバイルインナーページの0.02%に出現。AMP HTMLまたはEmojiはデスクトップインナーページの0.04%、モバイルインナーページの0.2%に出現。Rel AMPはデスクトップインナーページの0.8%、モバイルインナーページの0.9%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1159596578&format=interactive",
  sheets_gid="792475547",
  sql_file="mark-up-stats-2025.sql"
  )
}}

{{ figure_markup(
  image="amp-markup-home-vs-inner.png",
  caption="AMPマークアップ：ホームページ対インナーページ",
  description="ホームページとインナーページ間のAMPマークアップ使用状況を比較した棒グラフ。HTML AMPはホームページの0.1%、インナーページの0.1%に出現。AMP Emojiはホームページの0.03%、インナーページの0.01%に出現。AMP HTMLまたはEmojiはホームページの0.3%、インナーページの0.2%に出現。Rel AMPはホームページの1%、インナーページの1.7%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1296281363&format=interactive",
  sheets_gid="792475547",
  sql_file="mark-up-stats-2025.sql"
  )
}}

2024年はホームページがインナーページよりわずかにAMPを採用している傾向がありましたが、2025年はその逆となっています。`rel=amphtml` はインナーページの1.7%に出現するのに対し、ホームページは1.0%です。HTML AMPも同様で、採用率は現在均等（各0.1%）に分かれています。

## 国際化

hreflang属性は国際サイトや多言語ウェブサイトにとって重要な機能であり、検索エンジンがユーザーに適切な言語や地域バージョンのページを提供するのを助けます。2025年、hreflangはおよそ20%のページに出現しています。採用は国際ターゲティングが最も大きな影響を持つホームページで優先されることが多く、インナーページはカバレッジが一貫していません。成長は継続していますが、広く使用される少数の言語に集中しています。

### `hreflang` の実装

現在、5ページに1ページがhreflangマークアップを含んでいます。生（デスクトップ）は20.3%、生（モバイル）は19.7%で、レンダリング後はそれぞれ20.8%・20.2%とわずかに高い値です。これはhreflangタグを持つページが9〜10%程度だった昨年の数値のほぼ2倍です。

HTTP hreflangはほぼ消滅しており、デスクトップページの0.2%・モバイルページの0.1%が使用しているのみです。これは2024年のすでに小さなシェアと一致しており、HTTPSが国際化ウェブサイトのほぼすべてでデフォルトとなったことを裏付けています。

生とレンダリング後の値の近似性（1%未満の差）は、hreflangを実装しているほとんどのサイトが技術的に正しい方法で実装しており、レンダリング後も維持されていることを示しています。これはギャップがわずかに大きかった2024年からの改善です。

{{ figure_markup(
  image="hreflang-implementation.png",
  caption="`hreflang` の実装方法",
  description="ウェブサイト間のhreflang実装方法を示す棒グラフ。HTMLのhreflangタグはデスクトップサイトの0.2%、モバイルサイトの0.1%で使用。HTTPヘッダーhreflangはデスクトップサイトの20.3%、モバイルサイトの19.7%で使用。サイトマップhreflangはデスクトップサイトの20.8%、モバイルサイトの20.2%で使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1192602854&format=interactive",
  sheets_gid="574446946",
  sql_file="seo-stats-2025.sql"
  )
}}

### ホームページの `hreflang` 使用状況

{{ figure_markup(
  image="hreflang-link-usage-home-page.png",
  caption="hreflangリンクの使用状況 - ホームページ",
  description="ホームページにおける言語コード別のhreflangリンク使用状況を示す棒グラフ。英語（en）はデスクトップの7.8%、モバイルの7.4%に出現。x-defaultはデスクトップの7.2%、モバイルの6.9%に出現。フランス語（fr）はデスクトップの3.1%、モバイルの3.2%に出現。ドイツ語（de）はデスクトップの2.9%、モバイルの3.1%に出現。スペイン語（es）はデスクトップの2.9%、モバイルの3%に出現。イタリア語（it）はデスクトップの2.1%、モバイルの2.4%に出現。英語US（en-us）はデスクトップの2.2%、モバイルの1.9%に出現。ロシア語（ru）はデスクトップの1.7%、モバイルの2.1%に出現。ポルトガル語（pt）はデスクトップの1.3%、モバイルの1.6%に出現。オランダ語（nl）はデスクトップの1.4%、モバイルの1.5%に出現。日本語（ja）はデスクトップの1.2%、モバイルの1.5%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=247968429&format=interactive",
  sheets_gid="1800175141",
  sql_file="hreflang-link-tag-usage-2025.sql",
  width=600,
  height=515
  )
}}

ホームページでの `hreflang` 使用は依然として少数の値に高度に集中しています。英語（`en`）が引き続き支配的で、デスクトップホームページの7.4%、モバイルの7.3%に出現し、`x-default` がデスクトップ7.2%・モバイル6.9%で続いています。

フランス語（モバイル3.2%）・ドイツ語（モバイル3.1%）・スペイン語（モバイル3.0%）などの第2言語グループが次のティアを形成し、イタリア語・ロシア語・ポルトガル語・オランダ語・日本語は2.5%未満にとどまっています。

この集中は、`hreflang` の採用がページ全体の20%をカバーするまでに成長したにもかかわらず、その大半が広くターゲットとされる少数の視聴者層に集中していることを示しています。

2024年に `en` がデスクトップ・モバイルともにホームページの8%に出現していたのと比べ、2025年のデータは若干の低下を示しています。ただし、第2言語群の採用は安定しており、全体的な分布は年を通じて一貫しています。

### インナーページの `hreflang` 使用状況

{{ figure_markup(
  image="hreflang-link-usage-inner-page.png",
  caption="hreflangリンクの使用状況 - インナーページ",
  description="インナーページにおける言語コード別のhreflangリンク使用状況を示す棒グラフ。英語（en）はデスクトップの7.6%、モバイルの6.8%に出現。x-defaultはデスクトップの7.4%、モバイルの6.8%に出現。フランス語（fr）はデスクトップの3.2%、モバイルの3.2%に出現。ドイツ語（de）はデスクトップの3%、モバイルの3.1%に出現。スペイン語（es）はデスクトップの2.9%、モバイルの3%に出現。英語US（en-us）はデスクトップの2.3%、モバイルの1.9%に出現。ロシア語（ru）はデスクトップの1.7%、モバイルの2.1%に出現。ポルトガル語（pt）はデスクトップの1.3%、モバイルの1.7%に出現。オランダ語（nl）はデスクトップの1.5%、モバイルの1.5%に出現。日本語（ja）はデスクトップの1.3%、モバイルの1.6%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=268209538&format=interactive",
  sheets_gid="1800175141",
  sql_file="hreflang-link-tag-usage-2025.sql",
  width=600,
  height=515
  )
}}

インナーページでのhreflang採用はホームページのパターンを反映していますが、わずかに低い水準です。英語（en）がデスクトップページの7.6%・モバイルの6.9%でトップを占め、x-defaultがデスクトップ7.4%・モバイル6.8%で続いています。フランス語（インナーモバイルページの3.2%）・ドイツ語（モバイル3.1%）・スペイン語（モバイル3.0%）が次のティアを形成し、他のすべての言語値は2.5%未満にとどまっています。

2024年にデスクトップのx-defaultとenが8%近くだったのと比べ、2025年の数値はわずかな低下を示しています。この分布は、hreflangがインナーページよりもホームページで優先される傾向にあることを再確認するものです。フランス語・ドイツ語・スペイン語の緊密なクラスタリング（インナーモバイルページで3.0〜3.2%）は、英語以外の多言語ウェブ採用の大部分が欧州主要市場によって推進されていることを裏付けています。

## 結論

AIサーチがコンテンツの発見方法を再形成する中、ウェブの基本原則はかつてないほど重要です。心強いことに、データはその基盤が揺るぎないことを示しています。

クロール可能性とインデックス可能性は依然として強固です。ほとんどのサイトが有効な `robots.txt` ファイルと `canonical` タグを提供しており、マークアップの品質は年々改善しています。`robots.txt` 自体の役割も進化しており、アクセスのゲートキーパーからコンテンツ使用意図の宣言へと移行しています。数百万のファイルが `gptbot` や `claudebot` などのAIクローラーに明示的に対応するようになっています。強固な `meta` ロボットの採用と安定したカノニカルシグナルと合わせて、これらの技術的な柱は人間とマシン主導の検索システムの両方にとって信頼できる基盤を提供しています。

これらのアクセスシグナルを超えて、ウェブの中間層——ページエクスペリエンス・パフォーマンス・オンページ構造——が心強い安定性を示しています。HTTPSの採用は91%を超え、Core Web Vitalsは歴史的に高い水準で横ばいとなり、タイトル・ディスクリプション・見出しなどのオンページメタデータは検索とAI主導のインデックス作成の両方に向けて最適化が進んでいます。構造化データの採用率は50%に達し、ほとんどの実装は直接HTMLに埋め込まれています。これらはすべて、クローラーとモデルによる、より速く・よりクリーンな解釈を確保するためのものです。

`llms.txt` はウェブがAIシステムに直接語りかけるための最新の実験です。サイトオーナーは、コンテンツがAIによってどのようにランク付けされ・読まれ・再利用されるかについて考えるよう招かれています。採用率はまだ低く（約2%）、意図的な戦略よりもCMSプラグインによって推進されていますが、その存在はマインドセットの転換を示しています。`llms.txt` が標準になるか脚注にとどまるかは、2026年に持ち越される重要な問いです。

この進歩の多くは、ベストプラクティスをデフォルトで組み込むようになったCMSプラットフォームから生まれており、ウェブ全体の技術的なベースラインを静かに引き上げています。テクニカルSEOの全体的な軌跡は心強いものです。ウェブは1年前よりも一般的により一貫性があり・クロールしやすく・意味的に高度になっています。

SEO担当者は長年、これらの基本原則——構造化データ・メタデータ・クリーンなアーキテクチャ——が重要であることを知っていましたが、絶え間ないアルゴリズムの変動が、しばしばそれらを手っ取り早い戦術よりも二次的なものと感じさせていました。しかし今、大規模言語モデルがコンテンツの解釈と引用のために構造化され適切にラベル付けされたデータにますます依存するようになった今、それらの同じ基本原則が再び実証されています。基礎は時代遅れになったことはなく、今後もそうなることはないでしょう。
