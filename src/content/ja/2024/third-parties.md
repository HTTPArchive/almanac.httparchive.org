---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: サードパーティ
description: 2024 Web Almanacのサードパーティに関する章では、ウェブで使用されているサードパーティのデータと、サードパーティの包含チェーンの分析をカバーしています。
hero_alt: Web Almanacのキャラクターがウェブページに様々なものを接続しているヒーロー画像。
authors: [turban1988, Yash-Vekaria, zubairshafiq, ChrisBeeti]
reviewers: [tunetheweb]
editors: [tunetheweb]
analysts: [Yash-Vekaria, ChrisBeeti]
translators: [ksakae1216]
turban1988_bio: 工学博士のTobias Urbanは、<a hreflang="en" href="https://www.en.w-hs.de/">Westphalian University of Applied Sciences</a>のサイバーセキュリティを専門とするコンピュータサイエンスの教授です。彼の研究は、ITセキュリティ、データ保護、およびGDPRがインターネットに与える影響に焦点を当てています。
Yash-Vekaria_bio: Yash Vekariaは<a hreflang="en" href="https://www.ucdavis.edu/">カリフォルニア大学デービス校</a>のコンピュータサイエンス博士課程の学生です。彼はウェブベースの大規模インターネット測定を行い、ウェブのダイナミクスの研究と改善に取り組んでいます。とくに、オンライントラッキングの実践とユーザープライバシーの問題に関する研究と透明性の向上に焦点を当てています。
zubairshafiq_bio: Zubair Shafiqは<a hreflang="en" href="https://www.ucdavis.edu/">カリフォルニア大学デービス校</a>のコンピュータサイエンス教授です。彼の研究は、経験的に裏付けられた測定とモデリング手法を用いて、インターネットをプライベートで安全なものにすることを目指しています。
ChrisBeeti_bio: Chris Böttgerは<a hreflang="en" href="https://www.en.w-hs.de/">Westphalian University of Applied Science</a>のコンピュータサイエンス博士課程の学生です。彼の研究はウェブとネットワークセキュリティに焦点を当てており、主にユーザープライバシーとトラッキング技術に取り組んでいます。
results: https://docs.google.com/spreadsheets/d/18uTDBygSqgT_PNFldOz4guLSuXyMzDthRGnAG5if4sU/
featured_quote: Googleはウェブ上で最も人気のあるサードパーティであり、トップ10のサードパーティドメインのうち5つがGoogleドメインです。
featured_stat_1: 92%
featured_stat_label_1: 1つ以上のサードパーティを含むウェブページ
featured_stat_2: 78
featured_stat_label_2: ウェブページあたりのサードパーティリクエストの中央値
featured_stat_3: 22
featured_stat_label_3: ウェブページあたりのサードパーティの中央値
doi: 10.5281/zenodo.14193384
---

## はじめに

ウェブサイト開発者は、広告、アナリティクス、ソーシャルメディア連携、決済処理、コンテンツ配信などの機能を実装するためにサードパーティを利用できます。ウェブページは通常、ファーストパーティと様々なサードパーティによって提供されるリソースで構成されています。サードパーティを利用してウェブページを構築することで、モジュール化された開発が可能になり、豊富な機能を効率的かつ迅速に展開できますが、プライバシー、セキュリティ、パフォーマンスの問題を引き起こす可能性もあります。

この章では、ウェブでのサードパーティの利用実態を明らかにするための実証分析を行います。ほぼすべてのウェブサイトが1つ以上のサードパーティを含んでいることがわかりました。これらのサードパーティによって提供されるリソースの種類（画像、JavaScript、フォントなど）の内訳を提供します。また、ウェブ上のサードパーティの異なるカテゴリ（広告、アナリティクス、CDN、動画、タグマネージャーなど）の内訳も提供します。さらに、異なるサードパーティがウェブページにどのように含まれているか（直接的または間接的）の内訳も提供します。

## 定義

分析を始める前に、この章で扱う内容の共通の定義を確認しておくと役立ちます。

### サイトとページ

この章では、**サイト**という用語を使用して、特定のドメインの登録可能な部分（しばしば _extended Top Level Domain plus one_ (eTLD+1) と呼ばれる）を表します。たとえば、URL `https://www.bar.com/` の場合、eTLD+1は `bar.com` であり、URL `https://foo.co.uk` の場合、eTLD+1は `foo.co.uk` です。**ページ**（またはウェブページ）とは、一意のURL、より具体的には特定のURLにあるドキュメント（たとえばHTMLやJavaScript）を指します。

### サードパーティとは？

この章と以前の版との比較を可能にするため、以前のWeb Almanacで使用されたサードパーティの定義に従います。

**サードパーティ**とは、サイト所有者（ファーストパーティ）とは異なるエンティティです。サイト所有者が直接実装・提供していないサイトの側面を含みます。より正確には、サードパーティコンテンツは、ユーザーが最初に訪問したサイトではなく、別のサイト（つまりサードパーティ）から読み込まれます。ユーザーが `example.com`（ファーストパーティ）を訪問し、`example.com` が `awesome-cats.edu` から面白い猫の画像を含めている（たとえば `<img>` タグを使用）とします。このシナリオでは、`awesome-cats.edu` はサードパーティです。なぜなら、ユーザーが最初に訪問したのはそこではないからです。しかし、ユーザーが直接 `awesome-cats.edu` を訪問した場合、`awesome-cats.edu` はファーストパーティとなります。

定義に合わせるため、HTTP Archiveデータセットで少なくとも50のユニークなページでリソースが見つかるドメインからのサードパーティのみを含めました。サードパーティコンテンツがファーストパーティドメインから直接提供される場合、それはファーストパーティコンテンツとしてカウントされます。たとえば、セルフホスティングされたCSSやフォントはファーストパーティコンテンツとしてカウントされます。同様に、サードパーティドメインから提供されるファーストパーティコンテンツは、サードパーティコンテンツとしてカウントされます（「50ページ以上の基準」を満たす場合）。一部のサードパーティは異なるサブドメインからコンテンツを提供します。しかし、サブドメインの数に関係なく、それらは単一のサードパーティとしてカウントされます。さらに、サードパーティがファーストパーティとして偽装されることがますます一般的になっています。たとえば、<a hreflang="en" href="https://ldklab.github.io/assets/papers/madweb21-cloaking.pdf">CNAME cloaking</a>のような技術を通じてです。この分析では、それらをファーストパーティとして扱います。したがって、私たちの結果は、ウェブ上のサードパーティの普及率の下限を示しています。

### カテゴリ

前述のように、サードパーティは様々な用途に使用できます。たとえば、動画を含めるため、広告を提供するため、またはソーシャルメディアサイトからのコンテンツを含めるためなどです。データセットで観察されたサードパーティを分類するために、[Patrick Hulce](https://x.com/patrickhulce)の<a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">third-party Web</a>リポジトリを参照しています。このリポジトリは、サードパーティを以下のカテゴリに分類しています：

- **広告（Ad）**: これらのスクリプトは広告ネットワークの一部で、広告の提供または測定を行います。
- **アナリティクス（Analytics）**: これらのスクリプトはユーザーとその行動を測定または追跡します。追跡される内容によって、影響の範囲は広くなります。
- **CDN**: これらは、異なるパブリックCDNで提供される公開ホストされたオープンソースライブラリ（たとえばjQuery）とプライベートCDNの使用の混合です。
- **コンテンツ（Content）**: これらのスクリプトはコンテンツプロバイダーまたは出版固有のアフィリエイトトラッキングからのものです。
- **カスタマーサクセス（Customer Success）**: これらのスクリプトは、チャットやコンタクトソリューションを提供するカスタマーサポート/マーケティングプロバイダーからのものです。これらのスクリプトは一般的に重いです。
- **ホスティング（Hosting）***: これらのスクリプトはウェブホスティングプラットフォーム（WordPress、Wix、Squarespaceなど）からのものです。
- **マーケティング（Marketing）**: これらのスクリプトはポップアップ/ニュースレターなどを追加するマーケティングツールからのものです。
- **ソーシャル（Social）**: これらのスクリプトはソーシャル機能を有効にします。
- **タグマネージャー（Tag Manager）**: これらのスクリプトは多くの他のスクリプトを読み込み、多くのタスクを開始する傾向があります。
- **ユーティリティ（Utility）**: これらのスクリプトは開発者ユーティリティ（APIクライアント、サイトモニタリング、不正検出など）です。
- **動画（Video）**: これらのスクリプトは動画プレーヤーとストリーミング機能を有効にします。
- **同意プロバイダー（Consent provider）**: これらのスクリプトはサイトがユーザーの同意を管理することを可能にします（たとえば[一般データ保護規則](https://wikipedia.org/wiki/General_Data_Protection_Regulation)の遵守のため）。これらは「Cookie同意」ポップアップとしても知られており、通常はクリティカルパスで読み込まれます。
- **その他（Other）**: これらは共有オリジンを通じて配信される雑多なスクリプトで、正確なカテゴリや帰属がありません。

<aside class="note">注：ここでのCDNカテゴリには、パブリックCDNドメインでリソースを提供するプロバイダー（たとえば <code>bootstrapcdn.com</code>、<code>cdnjs.cloudflare.com</code>など）が含まれ、単にCDNで提供されるリソースは含まれません。たとえば、ページの前にCloudflareを配置しても、私たちの基準に従えば、そのファーストパーティの指定には影響しません。</aside>

<aside class="note">前年と同様に、ホスティングカテゴリは分析から除外しています。たとえば、ブログにWordPress.comを使用したり、eコマースプラットフォームにShopifyを使用したりする場合、それらのドメインに対するそのサイトからの他のリクエストは、多くの点でそれらのプラットフォームのホスティングの一部であるため、真の「サードパーティ」として無視します。</aside>

### `Content Type`

サードパーティリソースのタイプを決定するために、[`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) HTTPヘッダーを使用します。Content-Typeの値には、`text/javascript`または`application/javascript`（スクリプト用）、`text/html`（HTMLコンテンツ用）、`application/json`（JSONデータ用）、`text/plain`（プレーンテキスト用）、`image/png`（PNG画像用）、`image/jpeg`（JPEG画像用）、`image/gif`（GIF画像用）などが含まれます。

## 普及率

{{ figure_markup(
  image="percent_pages_using_atleast_one_3p.png",
  caption="1つ以上のサードパーティを使用しているページの割合。",
  description="異なるランクグループで1つ以上のサードパーティを使用しているページの割合を示す棒グラフ。約92%のページが異なるランクグループでサードパーティを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=984151122&format=interactive",
  sheets_gid="528037668",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

低ランクのウェブサイトでは、1つ以上のサードパーティを使用しているページの割合がわずかに減少しています。2021年と2022年と同様に、1つ以上のサードパーティを含むページの割合は92%と高いままです。

{{ figure_markup(
  image="num_3p_by_rank.png",
  caption="ランク別のサードパーティ数の分布。",
  description="ランクグループ別のサードパーティ数の分布を示す棒グラフ。サードパーティの数はランクグループが上がるにつれて減少します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=964391197&format=interactive",
  sheets_gid="409919642",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

低ランクのウェブサイトでは、サードパーティの数がかなり減少していることがわかります。トップ1000のウェブサイトではサードパーティの中央値が66、トップ100万のウェブサイトでは27です。デスクトップのサードパーティ数はモバイルページよりも多くなっています。デスクトップとモバイルの差は、より上位のウェブサイトで大きくなっています。

{{ figure_markup(
  image="num_3p_req_per_page_by_rank.png",
  caption="ランク別のページあたりのサードパーティリクエスト数の分布。",
  description="ランク別のページあたりのサードパーティリクエスト数の中央値を示す棒グラフ。ページあたりのサードパーティリクエスト数はトップ1Kからトップ10Kのランクグループで増加し、その後上位のランクグループで減少します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=2138228339&format=interactive",
  sheets_gid="1476178274",
  sql_file="number_of_third_party_requests_per_page_by_rank.sql"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
サードパーティリクエストの数は、上位のウェブサイトの方が下位のウェブサイトよりも多いことがわかります。リクエストを見ると、上位と下位のウェブサイトの差は、[図2](#fig-2)のサードパーティの数を見る場合ほど偏っていません。

{{ figure_markup(
  image="3p_req_categories_by_rank.png",
  caption="ランク別のサードパーティリクエストカテゴリの分布。",
  description="ランクグループ別のサードパーティカテゴリの分布を示す棒グラフ。トップカテゴリは同意プロバイダー、動画、カスタマーサクセスです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=1044951420&format=interactive",
  sheets_gid="1662995860",
  sql_file="number_of_third_parties_by_rank_and_category.sql"
  )
}}

不明なものを除くと、トップカテゴリには同意プロバイダー、動画、カスタマーサクセスが含まれています。もっとも人気のある同意プロバイダードメインは `fundingchoicesmessages.google.com`、もっとも人気のある動画ドメインは `www.youtube.com`、もっとも人気のあるカスタマーサクセスドメインは `embed.tawk.to` です。

{{ figure_markup(
  image="3p_req_types_by_rank.png",
  caption="ランク別のサードパーティリクエストタイプの分布。",
  description="コンテンツタイプ別のサードパーティリクエストの割合分布を示す円グラフ。トップ3のコンテンツタイプは `script`（30.5%）、`image`（26.0%）、`html`（11.7%）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=906292432&format=interactive",
  sheets_gid="418010554",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

トップ3のタイプには `script`、`image`、`other` が含まれています。これらのコンテンツタイプで最も人気のあるドメインは `fonts.googleapis.com` です。

{{ figure_markup(
  image="top_3p_by_num_pages.png",
  caption="ページ数によるトップサードパーティ。",
  description="存在するページの割合によるトップサードパーティを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=1091257032&format=interactive",
  sheets_gid="1109396463",
  sql_file="top100_third_parties_by_number_of_websites.sql",
  width=600,
  height=498
  )
}}

トップ10のサードパーティドメインには、`googleapis.com`、`googletagmanager.com`、`google-analytics.com`、`google.com`、`youtube.com` など、Googleが所有する複数のドメインが含まれています。Metaの `facebook.com` はトップ5の中で唯一の非Googleドメインです。

## 包含

先ほどの例を思い出してください。`example.com`（ファーストパーティ）が `<img>` タグを使用して `awesome-cats.edu`（サードパーティ）から画像を含めることができます。この画像の包含は直接的な包含と見なされます。しかし、画像がサイト上のサードパーティスクリプトによって `XMLHttpRequest` を通じて読み込まれた場合、画像の包含は間接的な包含と見なされます。間接的に含まれるサードパーティは、さらに追加のサードパーティを含めることができます。たとえば、サイトに直接含まれるサードパーティスクリプトが、さらに別のサードパーティスクリプトを含めることができます。

このようなページ上のサードパーティの間接的な包含は、サードパーティ包含チェーンとして表現できます。包含チェーンは、特定のリクエストを引き起こしたものを特定するイニシエーター情報を使用して構築できます。包含チェーンでは、サードパーティのeTLD+1をノード識別子として使用します。包含チェーンには、同じ企業が運営する複数のドメイン（たとえば：`example.com` → `googletagmanager.com` → `google-analytics.com` → `doubleclick.net`）や異なる企業（たとえば：`example.com` → `googletagmanager.com` → `facebook.com`）が含まれる場合があります。

{{ figure_markup(
  image="median_depth_tp_inclusion_chains.png",
  caption="サードパーティ包含チェーンの中央値の深さ。",
  description="包含チェーンからの中央値の深さを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=496285056&format=interactive",
  sheets_gid="868914926",
  sql_file="inclusion_chain.sql"
  )
}}

包含チェーンの中央値の深さは3です。包含チェーンの4%が長さ > 1で、これはページ上で少なくとも1つのサードパーティを間接的に含んでいることを意味します。とくに、包含チェーンの14%が長さ > 5です。もっとも深い包含チェーンの長さは2,930です。

{{ figure_markup(
  image="median_depth_categories.png",
  caption="異なるカテゴリのウェブサイトの中央値の深さ。",
  description="異なるカテゴリと全体の中央値の深さを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=186961190&format=interactive",
  sheets_gid="1274132728",
  sql_file="inclusion_chain_by_category.sql"
  )
}}

すべてのカテゴリで、デスクトップページはモバイルページよりも長い包含チェーンを持っています。異なるウェブサイトカテゴリ間で大きな違いが観察されます。もっとも長い包含チェーンを持つウェブサイトカテゴリは `/Games` です。

{{ figure_markup(
  image="depth_of_gtm_called_urls.png",
  caption="Google Tag Manager包含チェーンURL。",
  description="Google Tag Managerから呼び出された包含チェーン内のURLの中央値の深さを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=496082761&format=interactive",
  sheets_gid="1091971377",
  sql_file="depth_of_gtm_calls.sql.sql"
  )
}}

トップサードパーティドメインの1つである `googletagmanager.com` に注目してみましょう。これには `googleapis.com`、`google-analytics.com`、`google.com`、`gstatic.com`、`youtube.com`、`googlesyndication.com`、`googleadservices.com` など、多くのGoogleドメインが含まれています。`googletagmanager.com` に含まれるトップ10のサードパーティドメインのうち、非Googleドメインは3つだけで、Metaの `facebook.com` と `facebook.net`、そしてShopifyの `shopify.com` です。

## 結論

私たちの調査結果は、ウェブ上のサードパーティの遍在性と複雑な性質を示しています。ウェブでのサードパーティの使用は、これまで以上に一般的になっていることがわかりました。10ページ中9ページ以上が1つ以上のサードパーティを含んでおり、多くの場合間接的に含まれています。

サードパーティは、ファーストパーティによって直接含まれていないことが多いことがわかりました。すべてのウェブページ上のサードパーティの約3分の1が、広告、アナリティクス、同意管理に使用されています。Googleはウェブ上で最も人気のあるサードパーティであり、トップ10のサードパーティドメインのうち5つがGoogleドメインです：`googleapis.com`、`googletagmanager.com`、`google.com`、`google-analytics.com`、`youtube.com`。

サードパーティの包含は、ウェブ開発者が考慮すべきプライバシー、セキュリティ、パフォーマンスへの影響をもたらします。
