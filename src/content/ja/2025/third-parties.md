---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: サードパーティ
description: 2025年版Web Almanacのサードパーティチャプター。ウェブで使用されているサードパーティのデータと、サードパーティのインクルージョンチェーンの分析を網羅。
hero_alt: Web Almanacのキャラクターたちがウェブページに様々なものを差し込んでいるヒーロー画像。
authors: [jazlan01, abubakaraziz]
reviewers: [tunetheweb]
analysts: [jazlan01]
editors: [tunetheweb]
translators: [ksakae1216]
jazlan01_bio: Muhammad Jazlanはカリフォルニア大学デービス校のコンピュータサイエンス博士課程2年生です。ウェブにおけるトラッキングの計測、検出、および軽減を研究テーマとしています。
abubakaraziz_bio: Muhammad Abu Bakar Azizはボストンにあるノースイースタン大学のコンピュータサイエンス博士候補者です。ウェブプライバシーを研究テーマとしており、特にサードパーティやオンライン広告主がCCPAやGDPRなどのプライバシー法をどのように遵守しているかを実証的に計測しています。
results: https://docs.google.com/spreadsheets/d/1FPssodcLgX8iFWFXDrthWVkBCUTl5_IJon2cyaZVudU/edit
featured_quote: トップ10のサードパーティドメインはGoogleが独占しています。
featured_stat_1: 90%
featured_stat_label_1: 少なくとも1つのサードパーティを持つページ
featured_stat_2: 16
featured_stat_label_2: ページに存在するサードパーティドメインの中央値
featured_stat_3: 18%
featured_stat_label_3: TCF標準を使用しているウェブサイトの割合
doi: 10.5281/zenodo.18246420
---

## はじめに

サードパーティはウェブ上にあまねく存在しています。ウェブサイト開発者は、広告、アナリティクス、ソーシャルメディア連携、決済処理、コンテンツ配信などの主要機能を実装するためにサードパーティに依存しています。このモジュール型のアプローチは、豊富な機能の効率的かつ迅速なデプロイを可能にします。しかし、プライバシー、セキュリティ、パフォーマンスに関する潜在的な懸念をもたらします。今年新たに、使用されているコンセントフレームワークやシグナルを受け取るサードパーティを含め、ユーザーのコンセント選択がウェブ上のサードパーティ間でどのように伝達されるかを分析しています。

本章では、ウェブにおけるサードパーティの使用パターンについて実証的な分析を行います。以下の観点から調査します：

- **普及率：** どれだけのウェブサイトがサードパーティを使用しているか、またその割合
- **リソースタイプ：** サードパーティが取る形式（画像、JavaScript、フォントなど）
- **機能カテゴリ：** 広告ネットワーク、アナリティクス、CDN、動画プロバイダー、タグマネージャーなど
- **統合方法：** サードパーティがページに直接または間接的にどのようにロードされるか
- **コンセントインフラ：** どのサードパーティがコンセントシグナルを転送し、それらの転送が実際にどのように行われているか

## 定義

まず、分析全体で使用される定義と用語を確認します。

### サイトとページ

本章では、これまでの年と同様に、「サイト」という用語を特定のドメインの登録可能な部分を表すために使用します。これはしばしば*拡張トップレベルドメインプラス1*（eTLD+1）と呼ばれます。例えば、URL `https://www.bar.com/` のeTLD+1は `bar.com` であり、URL `https://foo.co.uk` のeTLD+1は `foo.co.uk` です。「ページ」（またはウェブページ）とは、固有のURL、より具体的には特定のURLに存在するドキュメント（例えばHTMLやJavaScript）を意味します。

### サードパーティとは？

以前のバージョンとの比較を可能にするため、Web Almanacの前版で使用されたサードパーティの定義に従います。

_サードパーティ_ とは、サイトオーナー（ファーストパーティとも呼ばれる）とは異なるエンティティです。サイトオーナーが直接実装・提供していないサイトの側面を含みます。より正確には、サードパーティのコンテンツはユーザーが最初に訪問したサイトではなく、別のサイトからロードされます。ユーザーが `example.com`（ファーストパーティ）を訪問し、`example.com` が `awesome-cats.edu` から面白い猫の画像を含んでいる（例えば `<img>` タグを使って）とします。このシナリオでは、`awesome-cats.edu` はユーザーが最初に訪問したものではないため、サードパーティです。ただし、ユーザーが直接 `awesome-cats.edu` を訪問した場合、`awesome-cats.edu` はファーストパーティとなります。

分析では、HTTP Archiveデータセットの少なくとも5つの固有ページでリソースが見つかるドメインから発生するサードパーティのみを含めました。

サードパーティのコンテンツがファーストパーティドメインから直接提供される場合、ファーストパーティのコンテンツとしてカウントされます。例えば、セルフホストされたアナリティクススクリプト、CSS、またはフォントはファーストパーティのコンテンツとしてカウントされます。同様に、サードパーティドメインから提供されるファーストパーティのコンテンツはサードパーティのコンテンツとしてカウントされます。一部のサードパーティは異なるサブドメインからコンテンツを提供しています。ただし、サブドメインの数に関わらず、単一のサードパーティとしてカウントされます。

さらに、サードパーティがファーストパーティに偽装されることがますます一般的になっています。これを可能にする2つの主要な技術があります：

- **CNAMEクローキング**は、CNAMEレコードを使用してサードパーティのコンテンツがファーストパーティドメインから来ているように見せる技術です。本分析では、CNAMEクローキングされたサービスはファーストパーティとして扱います。

- **サーバーサイドトラッキング**は、サイトオーナーがトラッカーをファーストパーティとして組み込み、すべてのリクエストをファーストパーティドメイン経由でルーティングし、トラッカーをファーストパーティのように見せる新興のトレンドです。例えば、ウェブサイト `www.example.com` がサーバーサイドGoogle Tag ManagerをGoogle Analyticsとともに組み込み、サブドメイン `sst.example.com` をクロークしてGoogle Tag Managerコンテナにリクエストを送信する場合があります。このようにして、サードパーティへのリクエストはユーザーのブラウザではなく、タグマネージャーのサーバーから発生します。

分析では、サードパーティの通信はサーバー間で行われ、クライアントサイドのHTTP Archiveデータでは直接観測できないため、このようなケースをファーストパーティのインタラクションとして扱います。その結果、私たちの測定値はウェブ上のサードパーティの実際の普及率の下限を表しています。

## カテゴリ

前述の通り、サードパーティは動画の埋め込み、広告の配信、ソーシャルメディアサイトのコンテンツの埋め込みなど、様々なユースケースで使用できます。昨年と同様に、データセットで観察されたサードパーティをカテゴリ分けするために、<a hreflang="en" href="https://x.com/patrickhulce">Patrick Hulce</a>による<a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">Third-Party Web</a>リポジトリを使用します。このリポジトリは以下のカテゴリでサードパーティを分類しています：

- **Ad（広告）：** これらのスクリプトは広告ネットワークの一部で、広告の配信または計測を行います。
- **Analytics（アナリティクス）：** これらのスクリプトはユーザーとその行動を計測またはトラッキングします。追跡対象によって影響範囲は大きく異なります。
- **CDN：** これらは公開CDNや私有CDNを通じて配信される、公開ホストされたオープンソースライブラリ（例：jQuery）と私的なCDN使用の混合です。
- **Content（コンテンツ）：** これらのスクリプトはコンテンツプロバイダーまたは出版特有のアフィリエイトトラッキングからのものです。
- **Customer Success（カスタマーサクセス）：** これらのスクリプトはチャットや問い合わせソリューションを提供するカスタマーサポート/マーケティングプロバイダーからのものです。これらのスクリプトは一般的に重量が大きいです。
- **Hosting（ホスティング）：** これらのスクリプトはウェブホスティングプラットフォーム（WordPress、Wix、Squarespaceなど）からのものです。
- **Marketing（マーケティング）：** これらのスクリプトはポップアップ/ニュースレターなどを追加するマーケティングツールからのものです。
- **Social（ソーシャル）：** これらのスクリプトはソーシャル機能を有効にします。
- **Tag Manager（タグマネージャー）：** これらのスクリプトは多くの他のスクリプトをロードし、多くのタスクを開始する傾向があります。
- **Utility（ユーティリティ）：** これらのスクリプトは開発者向けのユーティリティ（APIクライアント、サイト監視、不正検出など）です。
- **Video（動画）：** これらのスクリプトは動画プレーヤーとストリーミング機能を有効にします。
- **Consent provider（コンセントプロバイダー）：** これらのスクリプトはサイトがユーザーのコンセントを管理することを可能にします（例：[一般データ保護規則](https://wikipedia.org/wiki/General_Data_Protection_Regulation)のコンプライアンスのため）。_クッキーコンセント_ ポップアップとも呼ばれ、通常はクリティカルパスでロードされます。
- **Other（その他）：** これらは正確なカテゴリや帰属のない共有オリジン経由で配信される雑多なスクリプトです。

### `Content-Type`

[`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) HTTPヘッダーを使用して、サードパーティリソースをスクリプト、HTMLコンテンツ、JSONデータ、プレーンテキスト、画像などの異なるタイプに分類します。これにより、ウェブサイト全体で配信されるサードパーティリソースの構成を分析できます。

## 普及率

{{ figure_markup(
  image="pages-using-at-least-one-3p.png",
  caption="1つ以上のサードパーティを使用しているページの割合。",
  description="異なるランクグループにわたって少なくとも1つのサードパーティを使用しているページの割合を示す棒グラフ。異なるランクグループにわたって約90〜92%のページがサードパーティを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=249114645&format=interactive",
  sheets_gid="1741089577",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

[前年](../2024/third-parties#普及率)と比較して、ウェブサイト全体で1つ以上のサードパーティを使用しているページの割合にわずかな減少が見られます。ただし、この減少にもかかわらず、1つ以上のサードパーティを持つページの割合は90%以上を維持しています。

{{ figure_markup(
  image="num-3p-by-rank.png",
  caption="ランク別サードパーティ数の分布。",
  description="ランクグループ別のサードパーティ数の分布を示す棒グラフ。ランクグループが上昇するにつれてサードパーティ数が減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=211745165&format=interactive",
  sheets_gid="199539546",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

前年と比較して、全ウェブサイトランクにわたってサードパーティドメインの中央値が大幅に減少しており、特に低ランクのウェブサイトで大きな減少が見られます。

この減少にはいくつかの要因が考えられます。第一に、サードパーティはCNAMEクローキングやサーバーサイドトラッキングを通じてますます隠蔽されており、クライアントサイドの計測での可視性が低下する可能性があります。第二に、HTTP Archiveのクローラーはウェブページとのインタラクションやページのスクロールを行わないため、遅延ロードにより一部のサードパーティが正しくロードされない場合があります。その結果、観察されるサードパーティリクエストが少なくなる可能性があります。

また、デスクトップページはモバイルページよりも一般的に多くのサードパーティを含んでいることも確認されています。

{{ figure_markup(
  image="num-3p-req-per-page-by-rank.png",
  caption="ランク別ページあたりのサードパーティリクエスト数の分布。",
  description="ランク別のページあたりのサードパーティリクエストの中央値を示す棒グラフ。ページあたりのサードパーティリクエスト数はトップ1Kからトップ10Kのランクグループにかけて増加し、その後高ランクグループでは減少します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1763082827&format=interactive",
  sheets_gid="641162136",
  sql_file="number_of_third_party_requests_per_page_by_rank.sql"
  )
}}

低ランクのウェブサイトはより多くのサードパーティリクエストをロードします。トップ1,000はデスクトップで129リクエスト、モバイルで106リクエストの中央値を持ち、全サイトのデスクトップ83リクエスト、モバイル79リクエストと比較しています。

前年比で、すべてのランクにわたってサードパーティリクエストが増加しています。トップ1,000サイトは[2024年と比較して](../2024/third-parties#fig-3)デスクトップで15リクエスト、モバイルで15リクエストの増加を示しており、より広いデータセットではデスクトップで5リクエスト、モバイルで5リクエスト増加しました。この上昇トレンドは、先ほど観察したユニークなサードパーティドメイン数の減少にもかかわらず起きており、個々のサードパーティがページあたりより多くのリクエストを送信していることを示しています。

{{ figure_markup(
  image="3p-req-categories-by-rank.png",
  caption="ランク別サードパーティリクエストカテゴリの分布。",
  description="ランクグループ別のサードパーティカテゴリの分布を示す棒グラフ。トップカテゴリはad、analytics、cdnです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1133634663&format=interactive",
  sheets_gid="445864775",
  sql_file="number_of_third_party_providers_by_rank_and_category.sql"
  )
}}

棒グラフはランクとカテゴリ別のページあたりのサードパーティプロバイダーの中央値を示しています。前版ではこの分析はランクとカテゴリ別のページあたりのサードパーティドメイン数に焦点を当てていましたが、今年はユニークなサードパーティプロバイダーの数を計測しており、全体的に低い数値となっています。今年のトップカテゴリは `ad`、`analytics`、`cdn` です。

{{ figure_markup(
  image="3p-req-types-by-rank.png",
  caption="ランク別サードパーティリクエストタイプの分布。",
  description="コンテンツタイプ別のサードパーティリクエストの割合分布を示す円グラフ。トップ3のコンテンツタイプは `script`（24.8%）、`image`（19.9%）、その他（13.9%）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1309978891&format=interactive",
  sheets_gid="418010554",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

チャートはサードパーティリクエストが `script`、`image`、`other` カテゴリによって支配されていることを示しています。`script`、`image`、`other` の合計は全サードパーティリクエストのコンテンツタイプの半数以上を占めています。このパターンは `script`、`image`、`other` もトップリクエストタイプとして特定した[2024年版](../2024/third-parties#fig-5)と一致しており、昨年からほとんど変化がないことを示しています。

{{ figure_markup(
  image="top-3p-by-num-pages.png",
  caption="ページ数別トップサードパーティ。",
  description="存在するページの割合でトップサードパーティを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=194077318&format=interactive",
  sheets_gid="803451847",
  sql_file="top100_third_parties_by_number_of_websites.sql",
  width=600,
  height=498
  )
}}

トップ10のサードパーティドメインは `fonts.googleapis.com`、`googletagmanager.com`、`google-analytics.com`、`accounts.google.com`、`adservice.google.com` を含むGoogle所有のサービスが独占しています。Metaの `facebook.com` はトップ10で唯一のGoogle以外のドメインで、21%のページで7位にランクインしています。

## サードパーティ間のコンセント伝達

このセクションでは、異なるサードパーティがウェブ全体でユーザーコンセントをどのように転送しているかを調査します。<a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">先行研究</a>では、サードパーティがコンセント情報の伝達に業界標準フレームワークに依存することが多いことが示されています。分析では、IABの3つのコンセント標準、すなわち<a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">透明性とコンセントフレームワーク（TCF）</a>、<a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">CCPAフレームワーク</a>、および<a hreflang="en" href="https://iabtechlab.com/gpp/">グローバルプライバシープロトコル（GPP）</a>に主に焦点を当てています。

これらのフレームワークはコンセント情報がウェブサイトとサードパーティ間でどのようにエンコードされ共有されるかを定義しています。データセットで観察されたサードパーティの中でどのコンセント標準が最も普及しているかを特定することから始めます。サードパーティが使用するフレームワークを判定するために、リクエストURLの特定パラメータの存在に依存しています。異なる標準の詳細は以下の通りです：

- **TCF標準**: IAB TCFで指定されているように、サードパーティリクエストに `gdpr` または `gdpr_consent` パラメータが含まれているかを確認することでTCFフレームワークの使用を特定します。

- **GPP標準**: `gpp` と `gpp_sid` パラメータの存在を確認することでGPPフレームワークの使用を特定します。

- **USP標準と非USP標準**: IAB CCPAフレームワークで定義されているように、リクエストが `us_privacy` パラメータを送信しているかを確認することでUSP標準の使用を特定します。また、<a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">先行研究</a>で特定された非標準パラメータを通じて送信されるコンセント文字列を検出することで、非標準USP標準の使用も特定します。

ウェブサイトランク、サードパーティカテゴリ、およびコンセントを受け取る最も頻繁に観察されるサードパーティにわたってコンセントシグナルの普及率を分析します。

### 異なるランクにわたるコンセントシグナルの普及率

{{ figure_markup(
  image="consent-signal-prevalence-by-rank.png",
  caption="ランク別コンセントシグナルの普及率。",
  description="ウェブサイトランクにわたるサードパーティリクエストにおける異なるコンセント標準の普及率を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=2066656520&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

TCF標準が主要なコンセント標準であり、特に低ランクサイトでは全サイトの18%に対して36%に達しています。この高い採用率はGDPR下での強力なオプトインコンセント要件と一致しています。USP標準は2番目に普及しており、ランク全体で9〜17%の採用率です。これはCCPAに対応して導入されたIAB CCPAコンセントフレームワークの使用を反映しています。GPPの採用は管轄区域をまたいでコンセントフレームワークを統一するという目標にもかかわらず、3〜6%と最小限に留まっています。

### 異なるカテゴリにわたるコンセント標準の分布

{{ figure_markup(
  image="consent-signal-prevalence-by-category.png",
  caption="カテゴリ別コンセントシグナルの普及率。",
  description="異なるサードパーティカテゴリにわたるコンセント標準の普及率を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=828032137&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

異なるサードパーティカテゴリにわたって異なるコンセント標準の選好が見られます。例えば、Socialサービスは最高のTCF採用率を示している一方、広告ベンダーはGPP、USP標準、そして小さなTCFシェアのより均衡した組み合わせを採用しています。さらに、Analyticsベンダーは主にGPPを採用しています。

### コンセントを受け取るトップサードパーティ

{{ figure_markup(
  image="consent-signal-prevalence-by-domain.png",
  caption="ドメイン別コンセントシグナルの普及率。",
  description="最も多くのコンセントシグナルを受け取るサードパーティを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1262795614&format=interactive",
  sheets_gid="1788947788",
  sql_file="consent_signals_by_parameter_and_domain_optimized.sql"
  )
}}

トップランクのウェブサイトの中で、`pubmatic.com` が最も多くのコンセントシグナルを受け取り、`adservice.google.com` が2位です。最も多くのコンセントシグナルを受け取るドメインの大多数は広告とアドテクベンダー（広告取引所、DSP、広告サーバー）です。多くの管轄区域でサードパーティの広告やアナリティクスプロバイダーが広告やその他の目的でユーザーデータを使用する前にユーザーのコンセントを取得しなければならないことを考えると、これは直感的に理解できます。

## インクルージョン

先ほどの例を振り返ると、`example.com`（ファーストパーティ）が `awesome-cats.edu`（`<img>` タグによるサードパーティ）から画像を含めることができます。この画像のインクルージョンは直接インクルージョンとみなされます。しかし、もし画像が `XMLHttpRequest` を介してサイト上のサードパーティスクリプトによってロードされた場合、その画像のインクルージョンは間接インクルージョンとみなされます。間接的にインクルードされたサードパーティはさらに追加のサードパーティを含める場合があります。例えば、サイトに直接インクルードされたサードパーティスクリプトが、さらに別のサードパーティスクリプトを含める場合があります。本章では、サードパーティのインクルージョンチェーンの深さについて基本的な分析を行います。

{{ figure_markup(
  image="median-depth-tp-inclusion-chains.png",
  caption="サードパーティインクルージョンチェーンの中央深度。",
  description="インクルージョンチェーンの中央深度を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=692408075&format=interactive",
  sheets_gid="1518420053",
  sql_file="inclusion_chain.sql"
  )
}}

インクルージョンチェーンの中央深度は3であり、サードパーティの大多数がウェブページ上で少なくとも別のサードパーティを含めていることを意味します。インクルージョンチェーンの最大深度は2,285です。

## 結論

私たちの調査結果は、ウェブ上のサードパーティの遍在性と集中化が進んでいることを示しています。10のウェブページのうち9つ以上が1つ以上のサードパーティを含んでいます。前年と比較してユニークなサードパーティドメインの中央値は減少していますが、サードパーティからのリクエストの総数は大幅に増加しており、個々のベンダーがページあたりより多くのリクエストを送信していることを示しています。

コンセント標準に関しては、TCFが全ウェブサイトランクにわたって主要なコンセント標準です。個々のサードパーティの中では、`pubmatic.com`、`adservice.google.com` およびその他のアドテクドメインが最も多くのコンセントシグナルを受け取っています。

最後に、CNAMEクローキングやサーバーサイドトラッキングなどの難読化技術の使用の増加は、クライアントサイドの計測でのサードパーティの可視性を低下させており、私たちの調査結果が実際の普及率の下限を表していることを示しています。
