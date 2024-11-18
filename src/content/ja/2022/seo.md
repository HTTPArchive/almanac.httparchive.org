---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: クローラビリティ、インデクサビリティ、ページ体験、オンページSEO、リンク、AMP、国際化などをカバーする2022年版Web AlmanacのSEO章。
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [SophieBrannon, itamarblauer, mordy-oberstein]
reviewers: [patrickstox, TusharPol, mobeenali97, dwsmart, johnmurch]
analysts: [csliva, jroakes, derekperkins]
editors: [MichaelLewittes]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1qBQWxNKIAVJNOFwGlslT7AW0VAoK85Mf3nFvtw0QjVU/
SophieBrannon_bio: Sophieは英国を拠点とするエージェンシーAbsolute Digital Mediaのクライアント・サービス・ディレクターで、医療や金融など競争の激しい業界におけるSEO戦略とコンテンツ・マーケティングを専門としています。Sophieは、カンファレンスのスピーカーや業界ブロガーであり、地域、国、国際的な規模で受賞歴のあるキャンペーンを戦略化し、提供した実績があります。
itamarblauer_bio: Itamar Blauerはロンドンを拠点とするSEOエキスパートです。UXを重視し、データに裏打ちされたクリエイティブなSEOでランキングを上げた実績があります。
mordy-oberstein_bio: モーディ・オーバースタインは、WixのSEOブランディング責任者です。また、SEMrushのコンサルタントを務め、SERP's Upポッドキャストを含む複数のSEOポッドキャストのマイクを握っています。
featured_quote: ページのHTMLにおける構造化データの実装は増加の一途をたどっています。2021年には、デスクトップページの41.8%、モバイルページの42.5%が構造化データを使用していました。2022年には、HTML内に構造化データを持つデスクトップページの44%、モバイルページの45.1%に上昇しています。
featured_stat_1: 84.75%
featured_stat_label_1: HTTPSを採用しているサイト
featured_stat_2: 66%
featured_stat_label_2: H1タグを導入しているウェブサイト
featured_stat_3: 20%
featured_stat_label_3: 遅延読み込み画像プロパティを使用した画像
---

## 序章

検索エンジン最適化（SEO）は、ウェブサイトやページの可視性を向上させ、検索エンジンの検索結果で上位に表示されるようにするためのデジタル技術です。多くの場合、技術的な設定、コンテンツの作成、リンクの獲得を組み合わせ、検索者のクエリと意図に対する関連性を向上させることを目的としています。SEOの人気は高まり続け、もっとも普及しているデジタルマーケティングチャネルのひとつとなっています。

{{ figure_markup(
  image="seo-term-trends.png",
  caption="SEOとペイパークリック、ソーシャルメディアマーケティング、Eメールマーケティングのトピックの方向性検索人気を比較したGoogle Trends。",
  description="検索エンジン最適化、ペイパークリック、ソーシャルメディアマーケティング、Eメールマーケティングなど、他のデジタルマーケティングチャネルと比較して、SEOへの関心が高いことを示すGoogleトレンドのスクリーンショット。相対的かつ絶対的な成長という点では、SEOが大きくリードしています。",
  width=2256,
  height=1492
  )
}}

私たちはこれまでにない新しい洞察を明らかにするカスタムメトリクスを使用して、ウェブ上の800万以上のホームページを分析し、[2021](../2021/seo)や、場合によっては[2020](../2020/seo)の結果と比較しました。注：私たちのデータ、とくにLighthouseとHTTP Archiveからのデータは、サイト全体のクロールではなく、ウェブサイトのホームページだけに限定されています。これらの制限については、[Methodology](./methodology)をご覧ください。

検索エンジンにやさしいウェブとは？


## クローラビリティと索引性

クロールとインデックスは、Googleや他の検索エンジンが最終的に検索結果ページに表示する内容のバックボーンです。クロールとインデックスがなければ、ランキングは成り立ちません。

プロセスの最初のステップは、クロールによるウェブページの発見です。数多くのページがクロールされますが、実際にインデックスされるページは少なく、基本的に検索エンジンのデータベースに保存され、分類されます。そして、検索者のクエリに基づいて、インデックスに登録されたページの中からマッチするページが提供されます。

このセクションでは、ウェブサイトをクロールしインデックスを作成するボットに関連するウェブの状態について説明します。サイトは検索エンジンのボットにどのような指示を与えているのでしょうか？Googleが正しいページを検索結果に表示するために、また重複したページを検索結果に表示しないために、サイトは何をしているのでしょうか？

クローラビリティとインデクサビリティに影響を与えるウェブとそのいくつかの側面を探ってみましょう。

### Robots.txt

robots.txtファイルは検索エンジンのクローラーを含むボットに対して、どこに行くことができどこに行くことができないか、つまり何をクロールすることができ、何をクロールすることができないかを指示します。


#### Robots.txtのステータスコード

{{ figure_markup(
  image="robots-txt-status-codes.png",
  caption="Robots.txtのステータスコード。",
  description="有効なrobots.txtファイルを持つページの割合を示す棒グラフ。モバイルサイトの82.4%が200、15.8%が404、0.2%が403、0.1%が500のステータスコードを返しました。デスクトップでは、81.5%、16.5%、1.6%、0.3%、0.1%と非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=240883913&format=interactive",
  sheets_gid="258446623",
  sql_file="robots-txt-status-codes.sql"
  )
}}

2021年と比較して、2022年にはrobots.txtファイルが200ステータスコードを返すサイトの割合がわずかに増加しています。2022年には、デスクトップサイトのrobots.txtファイルの81.5%が200のステータスコードを返し、モバイルサイトの82.4%が同じコードを返しました。これは、2021年にデスクトップサイトとモバイルサイトのrobots.txtファイルがそれぞれ81%と81.9%で200のステータスコードを返したことと比較しています。

同時に、2022年には、404ステータスコードを返すrobots.txtファイルの割合が、2021年に比べてわずかに減少しました。昨年は、デスクトップサイトのrobots.txtファイルの17.3%が404を返し、モバイルサイトのrobots.txtファイルの16.5%が404を返していました。2022年、404ステータスコードを返すのは、デスクトップサイトのrobots.txtファイルの16.5%、モバイルサイトのrobots.txtファイルの15.8%です。

2021年同様、残りのステータスコードは、最小限の数のrobots.txtファイルに関連付けられています。

注：上記のデータは、robots.txtファイルがどれだけ最適化されているかを示すものではありません。200のステータスコードを返すファイルであっても、おそらくサイト全体の健全性にとって最善ではないディレクティブが含まれている可能性があります。

#### Robots.txtのサイズ

{{ figure_markup(
  image="robots-size.png",
  caption="Robots.txtのサイズコード。",
  description="robots.txtのサイズの違いを100キロバイト単位で表した分布図。デスクトップでは、96.29%が0-100KB、0.31%が100-200KB、0.10%が200-300KB、0.04%が300-400KB、0.02%が400-500KB、0.05%が500KBより大きく、最後に2.26%が見つかりません。モバイルでは、96.48%が0-100 KBの範囲にあり、100-200 KBが0.30%、200-300 KBが0.12%、300-400 KBが0.04%、400-500 KBが0.02%、500 KBより大きいものが0.05%、最後に1.97%が欠落しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1600078634&format=interactive",
  sheets_gid="1828205691",
  sql_file="robots-text-size.sql"
  )
}}

予想通り、robots.txtファイルの圧倒的多数は0～100KBと非常に小さいものでした。

Googleのrobots.txtファイルの上限は500KiBです。ファイルがこの制限に達した後に見つかったディレクティブは、検索エンジンによって無視されます。このカテゴリーに分類されるrobots.txtファイルはごく少数です。とくに、デスクトップとモバイルの両方のサイトのわずか0.005％が、Googleの最大制限を超えるrobots.txtファイルを含んでいます（これは2021年のデータと一致しています）。ファイルサイズが制限を超える場合、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/robots/robots_txt">Googleはディレクティブを統合することを推奨しています</a>。

#### Robots.txtのユーザーエージェントの使い方

{{ figure_markup(
  image="robots-useragents.png",
  caption="Robots.txtユーザーエージェントの使用。",
  description="robots.txtファイルでもっとも一般的なユーザーエージェントのターゲットを示す棒グラフ。デスクトップでは `*` が74.9%、`adsbot-google` が6.8%、`mj12bot` が6.0%、`ahrefsbot` が5.4%、`mediapartners-google` が3.4%、`nutch` が3.7%、`googlebot` が3.3%、`pinterest` が3.3%、`adsbot-google-mobile` が2.8%、`ahrefssiteaudit` が3.2%、`yandex`が2.9％、`bingbot`が2.6％、`semrushbot`が2.2％、`baiduspider`が1.8％、最後に`dotbot`が1.5％。モバイルは76.1％、7.0％、6.0％、5.3％、4.5％、3.5％、3.3％、3.1％、3.3％、2.9％、3.0％、2.5％、2.3％、1.8％、1.7％とほぼ同じ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1197419046&format=interactive",
  sheets_gid="184863489",
  sql_file="robots-txt-user-agent-usage.sql",
  width=600,
  height=499
  )
}}

現在もっとも多くのウェブサイト（デスクトップ74.9%、モバイル76.1%）が、robots.txtファイル内で特定のユーザーエージェントを指定しておらず、これはファイル内のディレクティブがすべてのユーザーエージェントに適用されることを意味します。これは、デスクトップのrobots.txtファイルの74%、モバイルのrobots.txtファイルの75.2% が特定のユーザーエージェントを指定していなかった2020年のデータと一致しています。

興味深いことに、Bingbotはもっとも多く指定されたユーザーエージェントのトップ10には入っていません。SEOツールに関しては、2021年と同様、MajesticのボットとAhrefsのボットがもっとも多く指定されたユーザーエージェントのトップ5に入り、Semrushのボットがもっとも指定されたユーザーエージェントのトップ15に入りました。

検索エンジン別では、Googlebotがrobots.txtファイルの3.3%でトップ、Bingbotは2.5%でした。興味深いことに、モバイルサイトのrobots.txtファイルとBingbotを指定するデスクトップファイルの間には、2021年にはほぼ完全なパーセンテージポイントの差がありました。2022年にはこのような差はなく、基本的に一様です。

注目すべきは、2021年にはrobots.txtファイルのわずか0.5%にYandexbotが指定されていたことです。2022年には6倍に増加し、3%のファイルがYandexbotを指定しています。

### `IndexIfEmbedded`タグ

2022年1月、Googleは _indexifembedded_ という新しいロボットタグを導入しました。このタグは、noindexタグが適用されている場合でも、ページ上のiframeにコンテンツが埋め込まれている場合にインデックスを制御できます。

まず、この新しいタグが適用される可能性のあるページの割合を決定することから始めましょう。

{{ figure_markup(
  image="pages-with-iframe.png",
  caption="`<iframe>`を含むページ。",
  description="モバイルページの4.1%が分析コンテンツ内でiframeを利用しており、95.9%はiframeを利用していないことを示す円グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1839527748&format=interactive",
  sheets_gid="1009024750",
  sql_file="robots-meta-usage.sql"
  )
}}

ページの4%強が `<iframe>` 要素を含んでいます。 この要素を含むページの4.1%のうち、76%はiframeがnoindexされており、新しい`indexifembedded`タグの潜在的な使用例となっています。

しかし、`indexifembedded`ロボットタグを採用しているサイトはごくわずかです。このタグは、調査対象となったページのわずか0.015%にしか見当たりません。

`indexifembedded`タグを採用しているページのうち、98.3%はヘッダーに実装しており、66.3%はHTMLを使用しています。

{{ figure_markup(
  image="indexifembedded-useragents.png",
  caption="`Indexifembedded`ユーザーエージェント。",
  description="`indexifembedded`の実装の大部分がrobotsヘッダーを98.3%使用しており、`googlebot`ユーザーエージェントをターゲットにしていることを示す棒グラフです。他の3つのユーザーエージェント（`google`、`gogglebot-news`、`robots`）の使用率は0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=994494235&format=interactive",
  sheets_gid="1009024750",
  sql_file="robots-meta-usage.sql"
  )
}}

### 無効なヘッド要素

`<head>`要素はページのメタデータのコンテナーとして機能します。SEOの観点からは、ページのタイトルタグとメタディスクリプションは `<head>` 要素の中にあり、ロボットメタタグも同様です。

しかし、すべての要素が `<head>` 要素に属するわけではありません。Googleはページの `<head>` 内で無効な要素に出くわした場合、`<head>` の最後に到達したとみなし、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/guidelines/valid-html">残りのコンテンツを発見することはありません</a>。

2022年のデータでは、デスクトップページの12.7%、モバイルページの12.6%に無効な要素が`<head>`に含まれています。

{{ figure_markup(
  image="invalid-head-elements.png",
  caption="無効な `<head>` 要素です。",
  description="`<head>`の中に無効なHTML要素が含まれているページの割合。デスクトップでは、`img`が9.92%、`div`が3.58%、`a`が1.73%、`p`が1.11%、`span`が1.08%、`iframe`が0.96%、`br`が0.94%、`input`が0.78%、`li`が0.63%、そして最後に`ul`が0.63%のページで使用されています。モバイルはそれぞれ9.77%、3.91%、1.93%、1.32%、1.30%、1.13%、1.12%、1.05%、0.90%、0.90%と非常に似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=2061840642&format=interactive",
  sheets_gid="130501136",
  sql_file="invalid-head-elements.sql"
  )
}}

`<head>`にもっとも誤って適用されているのは、`<img>`要素です。モバイルページの9.7%、デスクトップページの9.9%で、`<head>`内に誤って配置されています。

`<div>`要素は、2022年のデータセット内の3%以上のページで、`<head>`内に誤って配置されている唯一の要素です。デスクトップページの3.5%、モバイルページの3.9%で、`<head>`に誤って適用されています。

## 正規化タグ

正規化タグは、重複コンテンツのページを定義するときや、検索エンジンが優先順位をつけるときに伝統的に使用されています。これはHTMLコードのスニペット（`rel="canonical"`）で、ウェブマスターは検索エンジンに対して、どのページが「優先される」バージョンであるかを定義できます。これらはディレクティブではなく、「ヒント」として機能します。そのため、Googleなどの検索エンジンは、そのページがユーザーにとってどの程度有用であるかに基づいて、そのページの正規化バージョンを決定します。正規化タグは、リンクなどの他のシグナルを統合したり、トラッキングの指標を簡素化したり、シンジケートされたコンテンツをよりよく管理するためにも使用できます。

{{ figure_markup(
  image="canonical-usage.png",
  caption="正規の使用法。",
  description="正規が設定されている、または正規化されているページのパーセンテージをハイライトしたカラムチャート。正規化の採用率はデスクトップで58.7%、モバイルで60.6%、正規化されているのはデスクトップで4.2%、モバイルで7.5%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=34038632&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

データから、正規タグの使用率が年々増加していることがわかります。2019年には、モバイルページの48.3%が正規を使用していました。2020年には53.6%に増加。2021年には58.5%とさらに増加。そして2022年には60.6%に増加しています。

モバイルはデスクトップよりも正規のアトリビューションの割合が高く（60.6%対58.7%）、これはモバイルでのURLの単一使用の直接的な結果と考えられます。この章のデータセットはホームページに限定されているため、これがモバイルの正規アトリビューションが高い理由であると考えるのが妥当でしょう。<a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">Googleのガイドライン</a>によると、独立したモバイルサイトを持つことは推奨されていません。

### HTMLとHTTPの正規表現

正規化タグの実装には2つの方法があります。

1. HTMLの `<head>` 内
2. HTTPヘッダー内（`Link` HTTPヘッダー）

{{ figure_markup(
  image="html-versus-http-canonical.png",
  caption="HTMLとHTTPの正規化の使い分け。",
  description="HTMLヘッダーとHTTPヘッダーの正規表現の実装を比較したカラムチャート。HTMLの正規表現の実装は、デスクトップで58.6%、モバイルで60.4%となっており、HTTPヘッダーでは1.2%、0.9%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1403695913&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

デスクトップ、モバイルともにもっとも一般的な使用法はHTMLで、それぞれ58.6％、60.4％。これは、実装が簡単なためと思われます。一方は基本的なHTMLの知識が必要ですが、もう一方（HTTPヘッダーを使用）はより技術的なスキルが必要です。

### 未加工とレンダリングの比較

{{ figure_markup(
  image="raw-vs-rendered-canonical.png",
  caption="未加工とレンダリング基準",
  description="raw、rendered、httpのcanonicalステータスを比較した棒グラフ。デスクトップの57.9%でraw canonical、58.6%でrendered canonical、0.7%でrendered but not raw canonical、2.2%でrendering changed canonical、0.4%でhttp header changed canonicalが設定されています。モバイルはほぼ同じで、それぞれ59.4%、60.4%、1.0%、1.9%、0.3%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=473608668&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

2021年の未加工のcanonical使用率は57.7%、レンダリングされたcanonical使用率は58.4%であったのに対し、2022年には若干の成長が見られ、未加工のcanonical使用率は59.4%、レンダリングされたcanonical使用率は60.4%に上昇しました。これは、カノニカルの使用率全体の伸びと相関しています。

## ページ体験

この章では、ページ体験のさまざまな要素と、2021年版Web Almanac以降の進化について見ていきます。

### HTTPS

2021年、Googleがコアウェブバイタルアップデートの序章を発表した後、サイトスピードとページ体験への注目が高まりました。HTTPSがランキング要因であるという体験は<a hreflang="en" href="https://developers.google.com/search/blog/2014/08/https-as-ranking-signal">2014年</a>までさかのぼりますが、コアウェブバイタルの発表以降、ページ体験への全体的なフォーカスがウェブ全体のHTTPSの採用に影響を与えたと考えられます。

{{ figure_markup(
  image="https-usage.png",
  caption="HTTPSをサポートしているウェブサイトの割合。",
  description="デスクトップサイトの85%、モバイルサイトの85%がHTTPSを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=115976742&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

データから、より多くのサイトがクロール時に安全な証明書（HTTPS）を使用していることがわかります（これらの証明書の有効期限を考慮）。2021年にはデスクトップページの84.3%がHTTPを使用していましたが、2022年には87.71%に上昇しました。モバイルでは、2021年の81.2%から2022年には84.75%に増加しました。2020年のコアウェブバイタル更新の発表から現在まで、モバイルでは約11%、デスクトップでは10%増加しています。

### モバイルフレンドリー

モバイルフレンドリーは、レスポンシブデザインの実装とダイナミックサービングを比較することで判断できます。これを特定するために、レスポンシブデザインで一般的に使用されるviewportメタタグの使用と、variable： User-Agentヘッダーの使用状況を調べ、ウェブサイトがダイナミックサービングを使用しているかどうかを判断しました。

### ビューポートメタタグ

{{ figure_markup(
  caption="viewport metaタグをサポートしているサイト。",
  content="92%",
  classes="big-number",
  sheets_gid="1858203218",
  sql_file="meta-tag-usage-by-name.sql"
)
}}

2021年にはモバイルページの91.1%がviewport metaタグを使用していましたが、現在では92%に増加しています。2020年には89.2%でした。

### Varyヘッダーの使い方

varyヘッダーは、異なるデバイス上の異なるユーザーに異なるコンテンツを提供できるようにするHTTPヘッダーです。これは動的な提供として知られており、まったく同じコンテンツを異なるデバイスに提供するレスポンシブデザインとは正反対です。

{{ figure_markup(
  image="vary-header.png",
  caption="Varyヘッダーの使い方",
  description="バリアブルヘッダーの有無を比較したカラムチャート。Varyヘッダーはデスクトップサイトの12%、モバイルサイトの13%で実装されており、それぞれ88%、87%が使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1832557145&format=interactive",
  sheets_gid="942102950",
  sql_file="html-response-vary-header-used.sql"
  )
}}

Varyヘッダーの使用率は、ここ数年比較的変化していません。2021年には、デスクトップページの12.6%、モバイルページの13.4%がこのフットプリントを使用していました。2022年のデータもほぼ同じで、デスクトップが12%、モバイルが13%です。

### 読みやすいフォントサイズ

2021年には、モバイルページの13.5%が読みやすいフォントサイズを使用していませんでした。Googleがすべてのデバイスでユーザー体験を重視するようになったおかげで、以前よりも多くのページで読みやすいフォントサイズが使用されるようになりました。読みやすいフォントサイズを使用していないモバイルページはまだ11%に過ぎません。

{{ figure_markup(
  caption="読みやすいフォントサイズを使用していないサイト。",
  content="11%",
  classes="big-number",
  sheets_gid="74703616",
  sql_file="lighthouse-seo-stats.sql"
)
}}

### コアウェブバイタル（CWV）

コアウェブバイタルは、Googleが同年6月にページ体験アップデートの実施を発表した後、2021年を通してSEOのホットトピックでした。今年も引き続き関心が寄せられ、CWVのパフォーマンスに注目するサイトが増えています。

コアウェブバイタルは、開発者やSEO担当者がユーザーがページをどのように体験しているかをより理解するのに役立つ、標準化された一連のメトリクスです。主な指標は以下のとおりです。

* 最大のコンテントフルペイント (LCP)は、ウェブページのメインコンテンツの読み込み速度を測定します。
* 最初の入力までの遅延 (FID)は、ユーザーがウェブページとインタラクション（ボタンをクリックするなど）してから、ブラウザが応答できるようになるまでの時間を測定します。
* 累積レイアウトシフト（CLS）は、視覚的な安定性と、ページがビューポート内で移動するかどうかを測定します。

これら3つの指標はすべて、ユーザー体験とウェブページの安定性にとって非常に重要です。

Core Web Vitalsのデータは、Chromeユーザー体験レポート（CrUX）から得ています。このレポートは、実際の（オプトインした）ユーザーの公開データセットから作成されており、数百万のウェブサイトから取得されています（ラボのデータとは異なり、シミュレーションされたものです）。

{{ figure_markup(
  image="good-cwv-mobile.png",
  caption="モバイルで良いCWV体験をした割合。",
  description="モバイルCore Web Vitalsの経時的な改善を示す時系列チャートで、すべてのCore Web Vitalsが上昇傾向にあります。現在、モバイルサイトの39%がコアウェブバイタルの良好なカテゴリーに分類されています。51%はLCPが良好、74%はCLSが良好、92%はFIDが良好です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1140903870&format=interactive",
  sheets_gid="1713598891",
  sql_file="core-web-vitals.sql"
  )
}}

モバイルでは、現在39%のサイトがCWVに合格しており、2021年の29%、2020年のわずか20%から上昇しています。また、現在92%のサイトがFIDに合格していますが、もっとも多くのサイトオーナーはLCPに苦戦しており、合格率は51%です。

{{ figure_markup(
  image="good-cwv-desktop.png",
  caption="デスクトップでCWVを体験した人の割合。",
  description="デスクトップのCore Web Vitalsの経時的な改善を示す時系列チャートで、全期間にわたって100%で横ばいのFIDを除き、すべてのCore Web Vitalsが上昇傾向にあります。デスクトップサイトの43%はコアウェブバイタルで良好と分類されています。63%はLCPが良好、65%はCLSが良好、100%はFIDが良好です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1399758157&format=interactive",
  sheets_gid="1713598891",
  sql_file="core-web-vitals.sql"
  )
}}

デスクトップでは、驚異的な100%のサイトがFIDに合格していますが、同様にLCPとCLSの合格には苦戦しています。注目すべきは、モバイル（39％）よりもデスクトップ（43％）の方がCWVに合格しているサイトが多いことです。

### `lazy`ローディングと`eager`ローディングのiframeの比較

レイジーローディングは、ウェブページ上の重要でない要素の読み込みを、必要な時点まで延期する技術です。これにより、ページが軽量化され、帯域幅やシステムリソースを節約できます。イージーローディングとは、関連するエンティティが同時にロードされ、一度にフェッチされることです。

{{ figure_markup(
  image="iframe-loading.png",
  caption="`iframe`ローディングプロパティの使用法。",
  description="`lazy`、`auto`、`eager`かnoneの`iframe`ロードプロパティを示すカラムチャート。デスクトップページの95.30%で欠落、3.67%で`lazy`、0.74%で`auto`、0.29%で`eager`、0.00%でblank。モバイルはそれぞれ94.94%、4.08%、0.60%、0.37%、0.00%、0.00%でほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1451716640&format=interactive",
  sheets_gid="246694365",
  sql_file="iframe-loading-property-usage.sql"
  )
}}

iframeだけを見ると、遅延ロードの方がイージーロードよりもはるかに好まれ、iframeの4.08%が遅延ロードであるのに対し、イージーロードは0.37%でした。

<a hreflang="en" href="https://web.dev/iframe-lazy-loading/">iframeのブラウザレベルの遅延読み込みがChrome</a>で標準化されたので、これはとくに興味深いことです。lazyやeagerを指定せずに`loading`属性を標準化したことが、94.4%の属性がlazyやeagerを含んでいないというデータを示している理由でしょう。

## ページ上

関連性のシグナルを探すとき、検索エンジンはウェブページのコンテンツを見ます。SERP（検索エンジンの検索結果ページ）での順位や表示に影響を与えるさまざまなオンページSEOの要素があります。

### メタデータ

{{ figure_markup(
  image="has-title-meta.png",
  caption="タイトルタグとメタディスクリプション",
  description="タイトルタグとメタディスクリプションを含むページの割合のカラムチャート。98%のページにタイトルがあり、71%のページにメタディスクリプションがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1299529015&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

2年連続で、デスクトップとモバイルページの98.8%に`<title>`要素がありました。また、2022年には、デスクトップとモバイルのホームページの71%に`<meta name="description">`タグがあり、昨年より0.1%減少しました。

#### `<title>`要素

`<title>`要素は、ページの関連性に関する強いヒントを提供し、SERPに表示される可能性があるページ上のランキング要素です。2021年8月、<a hreflang="en" href="https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles">Googleは検索結果でより多くのウェブサイトのタイトルを書き換え始めました</a>。

{{ figure_markup(
  image="title-words-percentile.png",
  caption="パーセンタイル別のタイトル語。",
  description="ページタイトル内の単語数の分布。タイトル内の単語数の中央値はデスクトップ、モバイルともに6語。10パーセンタイルではデスクトップで1語、モバイルで2語、25パーセンタイルでは両方で3語、75パーセンタイルでは両方で9語、90パーセンタイルでは両方で12語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1674970307&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="title-characters-percentile.png",
  caption="パーセンタイル別のタイトル文字。",
  description="ページタイトル内の文字数分布。モバイルタイトルの文字数の中央値は、デスクトップが39文字、モバイルが40文字。10パーセンタイルではどちらも12文字、25パーセンタイルではどちらも21文字、75パーセンタイルではどちらも59文字、90パーセンタイルではデスクトップが74文字、モバイルが75文字です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1110487580&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

2022年に

* `<title>`の中央値は6語。
* ページの`<title>`の中央値は、デスクトップで39文字、モバイルで40文字でした。
* ページの10%に12語を含む`<title>`要素がありました。
* デスクトップとモバイルのページの10%に、それぞれ74文字と75文字を含む`<title>`要素がありました。

これらの統計は昨年と変わっていません。注：ホームページのこれらのタイトルは、深いページで使用されるものよりも短い傾向があります。

#### メタディスクリプションタグ

`<meta name="description>` タグはランキングに直接影響しません。しかし、SERP上にページの説明として表示されることがあり、クリック率に影響を与えることがあります。

{{ figure_markup(
  image="meta-description-words-percentile.png",
  caption="パーセンタイル別のメタディスクリプションワード",
  description="デスクトップとモバイルのメタディスクリプション内の単語数の分布。どちらも同じです。メタディスクリプションのワード数の中央値は19ワードです。10パーセンタイルでは2語、25パーセンタイルでは9語、75パーセンタイルでは25語、90パーセンタイルでは35語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1883941031&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="meta-description-characters-percentile.png",
  caption="パーセンタイル別のメタディスクリプション文字数",
  description="メタディスクリプション内の文字数の分布。メタディスクリプションの文字数の中央値は、デスクトップで137文字、モバイルで136文字です。10パーセンタイルではデスクトップが33文字、モバイルが33文字、25パーセンタイルではそれぞれ80文字と78文字、75パーセンタイルではどちらも160文字、90パーセンタイルではどちらも232文字です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1915861678&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

2022年に

* デスクトップとモバイルページの `<meta name="description>` タグに含まれる単語の中央値は19語でした。
* デスクトップページとモバイルページの `<meta name="description>` タグに含まれる文字数の中央値は、それぞれ137文字と136文字でした。
* デスクトップとモバイルのページの10%に、35語を含む`<meta name="description>`タグがありました。
* デスクトップとモバイルのページの10%に、232文字を含む`<meta name="description>`タグがありました。

もっとも、これらのスタッツは昨年と比較的変わりません。

#### ヘッダータグ

見出し要素（`<h1>`、`<h2>`...）は、ページ上のコンテンツを整理するのに役立つため、ページ構造の重要な部分です。見出し要素は直接的なランキング要因ではありませんが、Googleがページ上のコンテンツをより理解するのに役立ちます。

{{ figure_markup(
  image="has-h-elements.png",
  caption="H元素の存在。",
  description="H1タグからH4タグまでの使用率を示すカラムチャート。デスクトップでは、66%のページにH1タグがあり、73%がH2、62%がH3、38%がH4です。モバイルでも同じ割合です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=46522676&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

2022年のタイプ別見出しの実装に関する傾向は、わずかな違いはあるものの、2021年とほぼ一致しています。たとえば、2021年にはモバイルページの71.9%がh2を使用していましたが、2022年には73.02%がh2を使用しています。

もう1つの傾向は、h1とh2の使い方の違いです。デスクトップページの72.7%がh2を使用しているのに対し、h1を使用しているのは65.8%のみです（モバイルでも同様の数字が反映されています）。

これについての明確な説明はありませんが、考えられる理由のひとつは、h1がどのコンテンツよりも上に配置されることが多いからです。h1はコンテンツの自然な流れにとって必須ではありません。しかし、h2がないと、構造化されていないコンテンツが長く続く可能性があります。

{{ figure_markup(
  image="nonempty-h-elements.png",
  caption="空でないH要素の存在。",
  description="H1タグからH4タグの空でない使用率を示す列グラフ。デスクトップでは、H1タグが空でないページが58%、H2タグが空でないページが72%、H3タグが空でないページが61%、H4タグが空でないページが37%です。モバイルでは、それぞれ59％、71％、60％、37％と非常によく似た割合となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1398855380&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

全体的に、2021年の統計と同様に、ページ上に空のH要素は比較的少ないことがわかります。さらに、デスクトップとモバイルのデータにはほとんど食い違いがありません。

しかし、h1については乖離があります。 65.8%のページがh1要素を含んでいたのに対し、58.5%は空ではないh1要素を含んでいました。これは7.3ポイントの差です。h2との差はわずか1.5ポイントです。 2021 Web Almanacにあるように、これはホームページのh1要素にロゴ画像を挿入している多くのウェブサイトの結果かもしれません。

### イメージ属性

`<img>`要素のalt属性の主な目的はアクセシビリティです。alt属性はまた、検索エンジンが画像検索でとくにアセットをランク付けするのを助けます。

{{ figure_markup(
  image="image-alt-present.png",
  caption="`img` `alt` 属性が存在する割合。",
  description="alt属性を実装したimgタグを持つページの分布図。alt属性を持つ画像の使用率の中央値は、デスクトップで56%、モバイルで54%。10パーセンタイルではどちらも0%、25パーセンタイルでは16%と14%、75パーセンタイルでは92%と91%、90パーセンタイルでは100%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1932752526&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="image-alt-empty.png",
  caption="空白の `alt` を持つ `img` の割合。",
  description="空のalt属性を実装したimgタグを持つページの分布図。中央値として、モバイル、デスクトップともに、alt属性が空である画像は0%であり、一般的ではありません。75パーセンタイルでは、両方のデバイスタイプで画像の24%に上昇し、75パーセンタイルでは、デスクトップで75%、モバイルで79%になります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1460266248&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="image-alt-missing.png",
  caption="`alt`がない`img`の割合。",
  description="alt属性が欠落しているページ画像の分布図。alt属性がない画像の中央値は、デスクトップで12%、モバイルで13%です。10パーセンタイルと25パーセンタイルではどちらも0%ですが、中央値より上の75パーセンタイルではデスクトップで51%、モバイルで53%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=986554040&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

発見したこと

- デスクトップページの中央値では、`<img>`タグの56.25%がalt属性を持っています。これは、2021年の56.5%からわずか4分の1ポイントのごくわずかな減少です。
- モバイルページの中央値では、`<img>`タグの54.9%がalt属性を持ちます。これは、2021年のalt属性を持つタグの54.6%からわずかな増加です。
- alt属性が空白の`<img>`タグを含むデスクトップとモバイルページの中央値は、2021年と比較して顕著な変化が見られます。昨年、デスクトップ ページとモバイル ページの中央値には、それぞれ10.5%と11.8%の `<img>` タグと空白の `alt` 属性が含まれていました。2022年には、この数字はデスクトップで12.1%、モバイルで12.5%に上昇。
- alt属性がない`<img>`タグを含むデスクトップとモバイルページの中央値は0%という傾向が続いています。2021年のデスクトップページの中央値では、`<img>`タグの1.4%が空白属性でした。2022年には0%に減少しました。

### 画像 `loading` プロパティの使用法

ユーザーエージェントが画像のレンダリングと表示をどのように優先するかは、`<img>`要素に適用されるloading属性によって影響を受けます。この実装はユーザー体験とパフォーマンス時間に影響を与え、SEOの成功とコンバージョンの両方に影響を与える可能性があります。

{{ figure_markup(
  image="image-loading-property.png",
  caption="画像 `loading` プロパティの使用法。",
  description="画像読み込みプロパティの採用を示す列グラフ。20%の画像がネイティブの遅延ローディングを採用し、78%が属性を使用せず、2%が `eager` に設定しています。0%は `blank` の `auto` に設定しています。この数字はデスクトップとモバイルで同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1909677331&format=interactive",
  sheets_gid="166283668",
  sql_file="image-loading-property-usage.sql"
  )
}}

発見したこと

- 画像読み込みプロパティを使用しないページが大幅に減少しています。2021年には、デスクトップページの83.3%、モバイルページの83.5%が画像読み込みプロパティをまったく利用していませんでした。2022年には、デスクトップページの78.3%、モバイルページの77.9%となっています。
- 逆にloading="lazy "の実装は増加しています。2021年には、デスクトップとモバイルページの15.6%がloading="lazy "を実装していました。2022年には19.8%（デスクトップ）、20.3%（モバイル）に増加しています。
- ブラウザの読み込み方法をデフォルトにするページ数は2022年に減少しています。デスクトップでは0.07%、モバイルでは0.08%のページがloading="auto "を利用しています。2021年には0.01%のページがloading="auto "を利用していました。

### 単語数

コンテンツの長さはランキング要因ではありませんが、ページの平均単語数を評価することは価値があります。

#### レンダリング語数

まず、レンダリングされたページに含まれる単語の数から見てみましょう。

{{ figure_markup(
  image="visible-words-rendered.png",
  caption="パーセンタイル別に表示される単語。",
  description="レンダリングされたコンテンツと表示されたコンテンツのワード数の分布。モバイルのレンダリング語数の中央値は、デスクトップで421語、モバイルで366語です。10パーセンタイルではデスクトップが88語、モバイルが77語、25パーセンタイルではそれぞれ209語と179語、75パーセンタイルでは763語と677語、90パーセンタイルでは1,305語と1,166語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1348358716&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

2022年のデスクトップ・ページの中央値は421語。これは2021年の425語に近い数字です。しかし、これは2020年のデスクトップページの中央値402ワードと比べると、パーセンテージ的には大きな飛躍です。2021年にレンダリング語数が増加した原因が何であれ、それは2022年まで続いているようです。

同様に、2022年のモバイルのレンダリング語数の中央値は366語で、これも2021年のデータと同様の割合です。文脈上、デスクトップページの方がモバイルページよりも多くの単語が含まれています。デスクトップページの中央値は、50パーセンタイル内のモバイルページよりも15%多くの単語を含んでいます。Googleは数年前にモバイルファーストインデックスを採用しており、モバイル版ページにないコンテンツは検索エンジンにインデックスされないリスクがあるため、これは重要なことです。

#### 未加工の単語数

ブラウザがJavaScriptコードを実行したり、DOMやCSSOMに変更を加えたりする前に、ページのソースコードに含まれる単語の数を調べてみましょう。

{{ figure_markup(
  image="visible-words-raw.png",
  caption="パーセンタイルごとに未加工のまま表示される単語。",
  description="受信した未加工のHTMLワードの分布。未加工の単語数の中央値は、デスクトップで363語、モバイルで318語で、レンダリングされたものとは明らかに異なっています。10パーセンタイルではデスクトップが68語、モバイルが61語、25パーセンタイルではそれぞれ174語と151語、75パーセンタイルでは663語と594語、90パーセンタイルでは1,142語と1,039語です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=519228938&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

レンダリング語数と同様に、2022年のデータと2021年のデータにはわずかな違いがあります。たとえばデスクトップページの未加工ワード数の中央値は、2021年の369ワードに対し、2022年は363ワード、モバイルページの未加工ワード数の中央値は318ワードで、中央値が321ワードだった2021年をわずかに下回っています。

ここでも、モバイルページはデスクトップページよりも全体的に少ない単語数です。モバイルページのワード数の中央値は、デスクトップよりも12.39%少なくなっています。前述の通り、これはGoogleのモバイルファーストインデックスのために重要です。

## 構造化データ

構造化データの実装は、Google SERP上のリッチリザルトがより目立つようになったため、注目されるようになりました。

{{ figure_markup(
  image="raw-vs-rendered-structured-data.png",
  caption="未加工データとレンダリングされた構造化データ。",
  description="未加工とレンダリングによる構造化データの変化を示すカラムチャート。デスクトップページの44%が未加工の構造化データを持っており、レンダリングされた構造化データでは2ポイント増えて46%になります。レンダリングされた構造化データのみを持つページは0%、レンダリングによって構造化データが変化するページは5%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=486315827&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

ページのHTMLへの構造化データの実装は増加の一途をたどっています。2021年には、デスクトップページの42%、モバイルページの43%が構造化データを使用していました。2022年には、HTML内に構造化データを持つデスクトップページの44%、モバイルページの45%に上昇しています。

これは、デスクトップとモバイルページの両方で2ポイントの増加を反映しています。多くのコンテンツ管理システムがページに自動構造化データマークアップを追加したことと、前述のように構造化データがGoogle SERPsで重要な役割を果たすようになったことの2つが、採用増加の理由として考えられます。

また、モバイルページとデスクトップページの両方で、最初のHTMLレスポンスに含まれていないJavaScript経由で構造化データが追加されているページが大幅に減少しています。2021年には、モバイルページの1.7%、デスクトップページの1.4%が、最初のHTMLレスポンスに含まれていないJavaScript経由で構造化データを追加していました。現在はデスクトップでわずか0.15%、モバイルで0.13%です。

### もっとも普及している構造化データ形式

{{ figure_markup(
  image="structured-data-formats.png",
  caption="構造化データ形式。",
  description="一般的にサポートされている構造化データ形式の列表。デスクトップページの64%でJSON-LD、33%でマイクロデータ、3%でRDFa、0%でマイクロフォーマット2。モバイルはほぼ同じで、モバイルページの62%がJSON-LD、35%がマイクロデータ、2%がRDFa、1%がマイクロフォーマット2です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1310320311&format=interactive",
  sheets_gid="2048293717",
  sql_file="structured-data-formats.sql"
  )
}}

構造化データは、ページ上にさまざまな方法で実装できます。しかし、JSON-LDは、Googleが推奨する実装方法と一致しており、もっとも普及しています。

2021年の数字と比較すると、2022年のデータでは、JSON-LDによる実装は名目上増加し、マイクロデータによる構造化データの実装はわずかに減少しています。この数字は、とくにモバイルで顕著です。2021年には、モバイルページの60.5%が構造化データの実装にJSON-LDを使用していました。2022年に構造化データの追加にJSON-LDを使用したモバイルページの数は、2.3%増の61.9%です。逆に、2021年には、36.9%のモバイルページがマイクロデータによる構造化データを利用していました。2022年には4.3%減少し、35.3%になりました。

### もっとも普及しているスキーマタイプ

{{ figure_markup(
  image="popular-schemas.png",
  caption="もっとも普及しているスキーマタイプ。",
  description="スキーマタイプの実装を人気順に棒グラフにしたもの。30%のサイトがschema.orgのWebサイトスキーマを採用しています。`schema.org/WebSite`はデスクトップページの31%、`schema.org/SearchAction`は27%、`schema.org/WebPage`は23%、`schema.org/UnknownType-`は22%、`schema.org/Organization`は21%、`schema.org/ListItem`は19%、`schema.org/BreadcrumbList`は18%、`schema. schema.org/ImageObject`が16%、`schema.org/ReadAction`が15%、`schema.org/EntryPoint`が14%、`schema.org/SiteNavigationElement`が6%、`schema.org/PostalAddress`が6%、`schema.org/WPHeader`が5%、`schema.org/WPFooter`が5%、そして最後に`schema.org/Person`がデスクトップページの5%です。モバイルもほぼ同じで、それぞれ30%、26%、23%、22%、20%、18%、16%、14%、13%、7%、6%、5%、5%、5%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=201128426&format=interactive",
  sheets_gid="432096465",
  sql_file="structured-data-schema-types.sql",
  width=600,
  height=532
  )
}}

2021年と2022年のホームページでもっとも普及しているスキーマの種類には強い相関関係があります。

Web Almanacの以前の版で述べたように、`WebSite`, `SearchAction`, `WebPage`, `SearchAction`は、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">サイトリンク検索ボックス</a>[上の図を参照]を動かすものです。

2021年と2022年を比較すると、もっとも普及しているスキーマが軒並み大幅に増加しています。実際、2022年には、注目されるすべてのスキーマタイプで採用が増加しています。もっとも注目すべきは、2021年から22.8%上昇したBreadcrumbsListのスキーマと、12.3%上昇したImageObjectのスキーマです。

もっとも普及しているスキーマの実装という点では、モバイルページとデスクトップページの割合の差は比較的小さい。

構造化データについて詳しくは、構造化データの章をご覧ください。

## リンク

検索エンジンはリンクを利用して新しいページを発見し、ページの重要性を判断するPageRankを渡します。リンクはまた、あるページから別の（おそらく関連性のある）ページへの参照としても機能します。

### 説明的でないリンクテキスト

アンカーテキストとは、リンクに使用されるクリック可能なテキストのことで、検索エンジンがリンク先のページの内容を理解するのに役立ちます。ライトハウスでは、使用されているアンカーテキストが有用であるか、文脈に沿ったものであるか、または "詳しくはこちら "や "ここをクリック "のような一般的で非記述的なものかをチェックするテストを実施しています。2022年のテストでは、モバイルとデスクトップでそれぞれ15%と17%のリンクに説明的なアンカーテキストがありませんでした。

### 発信リンク

{{ figure_markup(
  image="median-internal-links.png",
  caption="同じサイトへの中央リンク",
  description="内部リンク数の中央値の順位分布。デスクトップでは上位1,000サイトが137リンク、上位10,000サイトが139リンク、上位100,000サイトが105リンク、上位100万サイトが88リンク、上位1,000万サイトが63リンク、全サイトが56リンク。モバイルでは、それぞれ106、117、94、82、56、48と若干低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=2040803708&format=interactive",
  sheets_gid="1325442493",
  sql_file="outgoing_links_by_rank.sql"
  )
}}

内部リンクとは、同じウェブサイトの他のページへのリンクのことです。昨年と同様、2022年の数字も、デスクトップ版に比べてモバイル版のリンク数が少ないことを示唆しています。

内部リンクの数の中央値は、デスクトップが56%、モバイルが48%と、モバイルよりも16%高くなっています。これは、開発者が小さな画面でも使いやすいように、モバイルのナビゲーションメニューやフッターを最小限に抑えた結果と考えられます。

CrUXのデータによると、もっとも普及している1,000のウェブサイトは、そうでないサイトよりも発信内部リンクが多く、デスクトップでは合計137本、モバイルでは106本でした。これは中央値の2倍以上です。これは、一般的にページ数の多い大規模サイトでメガメニューが使用されていることが原因と考えられます。

{{ figure_markup(
  image="median-external-links.png",
  caption="中央の外部リンク",
  description="外部リンク数の中央値の順位分布。デスクトップでは上位1,000サイトが15本、上位10,000サイトが13本、上位10万サイトが10本、上位数百万サイトが8本、上位1,000万サイトが7本、すべてのサイトが7本。モバイルはそれぞれ12、11、9、7、6、6と各ランクで1つか2つ少なくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1367867640&format=interactive",
  sheets_gid="1325442493",
  sql_file="outgoing_links_by_rank.sql"
  )
}}

外部リンクとは、別のウェブサイトの他のページへのリンクのことです。ここ数年一貫しているデータですが、デスクトップ版に比べ、モバイル版のページには外部リンクが少ないことが指摘されています。Googleは数年前にモバイルファーストインデックスを導入したにもかかわらず、ウェブサイトはモバイル版をデスクトップ版と同等にはしていません。

### アンカーrel属性の使用

2019年9月、Googleはパブリッシャーがリンクを _sponsored_ または _user-generated content_ に分類できる<a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">属性を導入しました</a>。これらの属性は、以前<a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">2005年に導入された</a>`rel=nofollow`に加えています。新しい属性の `rel=ugc` と `rel=sponsored` は、リンクに追加情報を加えます。

{{ figure_markup(
  image="anchor-rel-attr.png",
  caption="アコー`rel`属性の使用法。",
  description="`rel` `noopener`, `nofollow`, `noreferrer`, `dofollow`, `sponsored`, `ugc`, `follow` を比較したカラムチャートです。デスクトップでは`noopener`が34.3%、`nofollow`が28.8%、`noreferrer`が18.8%、`dofollow`が0.4%、`sponsored`が0.5%、`ugc`が0.4%、最後に`follow`が0.3%のサイトで使われています。モバイルはほぼ同じで、それぞれ32.6%、29.5%、17.3%、0.6%、0.4%、0.4%、0.3%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=583878647&format=interactive",
  sheets_gid="411053146",
  sql_file="anchor-rel-attribute-usage.sql"
  )
}}


新しい属性の採用という点ではあまり変化はなく、2022年には`rel=ugc`がデスクトップとモバイルページの0.4%、`rel=sponsored`がデスクトップの0.5%、モバイルページの0.4%に表示されます。

`rel="dofollow"`は、再び`rel="ugc"`や`rel="sponsored"`よりも多くのページに表示されました。これは技術的には問題ではありませんが、Googleは `rel="follow"` と `rel="dofollow"` を無視します。

実際の属性である `rel="nofollow"` は、2022年にはモバイルページの29.5%で見つかり、昨年より1.2%減少しました。Googleは`nofollow`をヒントとして扱い、検索エンジンがその属性を尊重するかどうかを選択できることを意味します。


## AMP

AMPは2015年のローンチ以来、ランキングに直接的な影響があるかどうかがSEO関係者の間で議論され、物議を醸してきました。その後、Googleはさらなる明確化のため、ドキュメントの中でこのような声明（下記）を発表しました。

<figure>
  <blockquote>AMP自体はランキング要因ではありませんが、スピードはGoogle検索のランキング要因です。Google検索は、ページを構築するために使用された技術に関係なく、すべてのページに同じ基準を適用します。</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://developers.google.com/search/docs/advanced/experience/about-amp">Google検索セントラル</a></cite></figcaption>
</figure>

Core Web Vitalsのローンチ以来、AMPの将来は変化しているようです。以前AMPを導入した主な理由は、ページ速度の改善以外に、トップカルーセルに掲載するために必要だったからです。2021年、Googleはその要件を更新し、AMPの有無にかかわらず、どのページもトップカルーセルに掲載される資格があると概説しました。

{{ figure_markup(
  image="amp-markup.png",
  caption="AMPマークアップタイプ。",
  description="全ページのAMP実装状況を示すカラムチャート。AMPの採用率はサンプルデータセット全体で低い。HTML Amp Attributeはデスクトップページの0.07%、モバイルページの0.19%で使用されています。HTML AmpとEmjoi Attributeはそれぞれ0.01%と0.03%、HTML AmpまたはEmjoi Attributeは0.09%と0.22%、Rel Amp HTML Tagは0.67%と0.60%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1100298070&format=interactive",
  sheets_gid="1210998028",
  sql_file="markup-stats.sql"
  )
}}

デスクトップの利用率は2021年と比較して2022年には0.09%から0.07%に低下し、モバイルの利用率は同じ期間に0.22%から0.19%に低下しています。

## 国際化

SEOにおける国際化とは、検索エンジンに適切にクロールされ、インデックスされるように、複数の国や複数の言語をターゲットとしたベストプラクティスに沿ってウェブサイトを最適化するプロセスのことです。

### Hreflang の使用法

Hreflangタグは、GoogleやBingやYandexなどの検索エンジンが、指定されたページの主要言語を理解するのに役立ちます。これは、主に国際的なSEOキャンペーンで、ウェブサイトの異なるバージョン間で複数の異なる言語が使用されている場合に使用されます。

{{ figure_markup(
  image="hreflang-usage.png",
  caption="Hreflangの使い方。",
  description="一般的なhreflangターゲットの棒グラフ。デスクトップでは、データセットのページの5.4%で `en` が使われています。`x-default`が4.0%、`fr`が2.2%、`de`が2.2%、`es`が2.1%、`en-us`が1.6%、`it`が1.5%、`ru`が1.3%、`en-gb`が1.2%、最後に`nl`が1.0%です。モバイルでは、それぞれ4.7％、3.7％、2.0％、2.0％、1.4％、1.5％、1.3％、1.0％、1.0％とほぼ同じ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=561647523&format=interactive",
  sheets_gid="297028820",
  sql_file="hreflang-link-tag-usage.sql",
  width=600,
  height=546
  )
}}

現在、hreflangタグをデスクトップで使用しているサイトは9.6%、モバイルで使用しているサイトは8.9%です。これは、9.0%のサイトがデスクトップでhreflangsタグを使用し、8.4%のサイトがモバイルでhreflangsタグを実装していた2021年からわずかに増加しています。

2022年にもっとも普及しているhreflangタグは`en`[English]で、デスクトップで5.4%、モバイルで4.7%となっています。この割合は前年とほぼ同じです。

"フォールバック"バージョンであるx-defaultの次に（そして2番目によく採用される）、フランス語、ドイツ語、スペイン語のhreflangタグがもっともよく使われます。

hreflangタグを実装するには、`<head>`、リンクヘッダー、XMLサイトマップの3つの方法があります。注：このデータはホームページのみを見ているため、XMLサイトマップは含まれていません。

### コンテンツの言語使用

Googleはhreflangタグを使う傾向がありますが、Bingなどの他の検索エンジンは[`content-language`属性](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Content-Language)を好みます。これは2つの方法で実装できます。

1. HTML
2. HTTPヘッダー

{{ figure_markup(
  image="content-language.png",
  caption="言語使用（HTMLとHTTPヘッダー）。",
  description="ページに占める言語使用率の棒グラフ。デスクトップでは`en`が4.22%、`en-us`が1.83%、`de`が0.50%、`fr`が0.33%、`es`が0.29%、`pt-br`が0.12%、`it`が0.13%、`ru`が0.12%、`nl`が0.14%、最後に`ja`が0.11%です。モバイルでは、それぞれ3.28%、2.28%、0.53%、0.29%、0.33%、0.15%、0.14%、0.14%、0.11%、0.10%と非常に似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1743056980&format=interactive",
  sheets_gid="1291138023",
  sql_file="content-language-usage.sql",
  width=600,
  height=507
  )
}}

2022年、content-languageの実装方法としてもっとも普及しているのはHTTPサーバーレスポンスで、モバイルサイトの8.27%、デスクトップサイトの8.82%が利用しています。しかし、モバイルサイトの9.3%が使用していた2021年と比較すると、モバイルでの採用は減少しています。逆にデスクトップでは、8.7%のサイトが使用していた2021年と比較して、わずかに増加しています。

一方、HTMLは2022年にデスクトップで2.98%、モバイルで3.01%の採用率です。しかし、モバイルサイトの3.3%がHTMLタグを使用していた2021年と比較すると、やはりモバイルでの使用率は低下しています。

## 結論

[2021年](../2021/seo)、[2020年](../2020/seo)、[2019年](../2019/seo)のデータのパターンと同様に、分析したサイトの大半は、インデックス可能でクローラブルなページを持つことを含むSEOのさまざまな基本に関して、わずかではあるが一貫した改善を見せています。

また、コアウェブバイタルなどのパフォーマンス要素への注目も高まっており、アップデートが最初に発表された2020年にはわずか20%だったのに対し、現在では39%のサイトが合格点を獲得しています。これは、サイトがGoogleの指導をより心に留めていることを示しているようです。それでも、ウェブ全体でもっと取り組む必要があります。

indexifembeddedタグのような新しい序章は、ゆっくりとピックアップを見ています。このことは、ベストプラクティスの継続的な採用の必要性と、SEO、検索エンジンフレンドリー、そしてウェブ全般の状態における成長の機会がいかに大きいかを強調しています。
