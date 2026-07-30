---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: ページの重さ
description: 2025年版Web AlmanacのPage Weightチャプターでは、ページの重さがなぜ重要かを説明し、帯域幅、複雑なページ、ページ重量の推移、ページリクエスト、ファイル形式を取り上げます。
hero_alt: Web Almanacのキャラクターが、さまざまなキロバイトのラベルが付いたボックスとウェブページを天秤で計っているヒーロー画像。
authors: [rickb110, fellowhuman1101]
reviewers: [dwsmart]
analysts: [dwsmart]
editors: [montsec]
translators: [ksakae1216]
fellowhuman1101_bio: Jamie Indigoはロボットではありませんが、ボットと話します。<a hreflang="en" href="https://www.coxautoinc.com/">Cox Automotive</a>のテクニカルSEOディレクターとして、検索エンジンがウェブをクロール、レンダリング、インデックスする方法を研究しています。Jamieはワイルドなアルゴリズムを飼いならしてレンダリング戦略を最適化することが大好きです。仕事以外では、ホラー映画、グラフィックノベル、ダンジョンズ＆ドラゴンズで正義のパラディンを恐怖に陥れることを楽しんでいます。
results: https://docs.google.com/spreadsheets/d/1xGs0oBVuONgj7uI0jPx-07ww94hWMmo6LrI8vdOOL5w/edit
rickb110_bio: Richard Barrettは<a hreflang="en" href="https://www.lumar.io/">Lumar</a>のプロフェッショナルサービスディレクター兼テクニカルサーチコンサルタントです。ウェブオーナーが難しい問題を解決するのを助けることが好きで、いいパズルゲームを2つ3つ好んでいます。
featured_quote: 最終的には、ユーザーエクスペリエンスにまったく影響を与えずに大幅な改善の機会が存在します
featured_stat_1: 202%
featured_stat_label_1: 過去10年間のモバイルページ重量の増加率
featured_stat_2: 98.1%
featured_stat_label_2: JavaScriptファイルのリクエストを少なくとも1回行うページの割合
featured_stat_3: 2,164 KB
featured_stat_label_3: 2025年のモバイルホームページの中央値の重さ
doi: 10.5281/zenodo.18246723
---

## はじめに

ウェブの黎明期、すべてのバイトは贅沢品でした。開発者はGIFのディザリングマッピングやスクリプトの手動最適化に何時間も費やし、56kモデムでページが閲覧できるようにしていました。今日、ギガビット光ファイバーと5G全盛の時代に、その希少性の考え方はほとんど消え去りました。しかし「帯域幅のパイプ」が広がるにつれ、私たちがそこに送り込むコンテンツもそのスペースを埋めるために膨張しています。

ページの重さ（ユーザーのデバイスに転送されるバイトの総量）は、ウェブの健全性を理解するための最も重要な指標の一つであり続けています。数メガバイトの追加をモダンなリッチエクスペリエンスの些細なコストと見なしたくなりますが、実際はずっと複雑です。

## ページの重さとは？

ページの重さ（ページサイズとも呼ばれる）とは、ユーザーが特定のウェブページを表示するためにダウンロードしなければならないデータの総量で、キロバイト（KB）またはメガバイト（MB）で測定されます。

URLにアクセスすると、ブラウザは1つのファイルをダウンロードするだけではありません。ページを正しく表示・機能させるために必要なさまざまなアセットに対して、数十または数百のリクエストを送信します。これらすべての「送信された」バイトの合計がページの重さを構成します。

現代のウェブページは複数の異なるタイプのリソースの組み合わせです。それぞれがサイトの合計「重量」に貢献します：

- **画像・動画：** 高解像度の写真、バックグラウンド動画、GIFはすぐにページサイズを膨らませます。
- **JavaScript：** インタラクティビティを提供するファイル（メニュー、トラッキングピクセル、アニメーションなど）。KBではしばしば画像より小さいですが、JavaScriptはブラウザが解析・実行のために多大なCPUパワーを費やす必要があるため「重い」です。
- **CSS：** ページのレイアウト、色、フォントを決定するスタイルシート。
- **フォント：** 複数のウェイト（太字、斜体、細字）が使用される場合、カスタムウェブフォントは数百KBを追加する可能性があります。
- **HTML：** ページの構造的なコードで、通常は合計重量の最も小さい部分です。
- **サードパーティスクリプト：** 他のサーバーから取得される広告、アナリティクス、ソーシャルメディアウィジェットが含まれます。

すべてのバイトが平等に作られているわけではありません。本章では、ファイルタイプのバイト数とリクエスト量によってページの重さを探ります。

### なぜ重さが重要か

ページの重さはパフォーマンスとアクセシビリティの直接的な指標です。「重い」ページはいくつかの負の連鎖反応を生み出します：

1. **パフォーマンスギャップ：** より大きなペイロードは解析とレンダリングのためにより多くのCPUサイクルを必要とし、より多くのデバイスメモリを使用します。これは接続速度に関わらず、ローエンドデバイスでの遅い体験につながることが多いです。
2. **経済的な負担：** 世界の多くの地域でデータは従量制の商品です。5 MBのページは単に遅い体験ではなく、排他的なものです。ユーザーがページを読み込むためのデータを負担できない場合、サイトは定義上そのユーザーにとってアクセスできないものになります。
3. **アクセシビリティの障壁：** ページが「重い」と、ただ読み込みが遅くなるだけでなく、物理的・認知的に使いにくくなります。過度なページ重量は重大な不平等を生み出し、非力なデバイスや高価で低速な接続でデータキャップが限られているユーザーを著しく不利にします。ページの重さが障害を持つ何百万人ものユーザーへの静かだが重大な参入障壁となる方法についての詳細は、[アクセシビリティ](./accessibility)チャプターを参照してください。
4. **環境への影響：** 転送されるすべてのメガバイトはエネルギーを必要とします。データセンターから冷却システム、ユーザーの手元のデバイスまで。ウェブが成長するにつれ、そのカーボンフットプリントも増大します。
5. **速度とSEO：** 重いページは特に遅い接続では読み込みに時間がかかります。GoogleはコアアルゴリズムにCore Web Vitalsを通じたページ速度を使用しており、膨らんだページは検索結果で低くランク付けされる可能性があります。[SEO](./seo)チャプターも参照してください。

重量効果は3つの主要カテゴリーに分けることができます：ストレージ、送信、レンダリング。

### ストレージ

ストレージとは、アセット（画像、スクリプト、HTML）がウェブサーバーまたはCDN上にどのように存在するかを指します。この段階では、ページの重さはディスク上のファイルサイズに関するものです。

- **静的圧縮：** 開発者はしばしば高度に圧縮された形式でファイルを保存します（画像のWebPやBrotli圧縮テキストなど）。1 MBのファイルは300 KBとして保存できます。
- **データベースのボトルネック：** 動的サイトの場合、「重さ」はデータベースクエリから始まります。サーバーが1ページを生成するためにデータベースから2 MBの生データを取得しなければならない場合、単一のバイトも送信される前に初期レスポンスタイム（[Time to First Byte (TTFB)](https://web.dev/articles/ttfb)）が増加します。
- **コスト：** 非効率なストレージは速度だけでなく、ホスティングコストとデータセンターのカーボンフットプリントを増加させます。

### 送信

送信とは、保存されたファイルをインターネット上で移動するプロセスです。ここでネットワークの制約がページの重さをパフォーマンスの障壁に変えます。

- **転送サイズと実際のサイズ：** 「オンザフライ」圧縮（Gzipなど）のおかげで、ネットワーク上で送信されるバイト数は元のファイルサイズよりもはるかに小さいことが多いです。
- **レイテンシとラウンドトリップ：** 問題はどれだけのデータが送信されるかだけでなく、何枚のファイルが送信されるかです。それぞれの独立したファイルはサーバーへの「ラウンドトリップ」を必要とします。50枚の小さな画像（合計1 MB）のページは、50件の独立したリクエストの転送オーバーヘッドにより、実際には1枚の大きな2 MBの画像を持つページよりも遅く感じることがあります。
- **ボトルネック：** モバイルの4G/5Gでは、信号干渉が「パケットロス」を引き起こす可能性があります。ページが重いほど、パケットがドロップしてブラウザが再度要求するよう強制し、目に見えるハングを引き起こす可能性が高くなります。

### レンダリング

レンダリングとは、データが到着した後に起こることです。これはページの重さの最も誤解されている部分です。ファイルがダウンロードされると、デバイスによって「解凍」されて処理される必要があります。

- **メモリ膨張：** 画像は転送中に200 KBしか占有しないかもしれませんが、ブラウザが「レンダリング」すると、デバイスのRAMでの生のピクセルにデコードされなければなりません。その200 KBのファイルは5 MBのメモリを簡単に占有する可能性があります。
- **JavaScriptの重税：** これはレンダリングの最も「重い」部分です。100 KBの画像は単なるピクセルですが、100 KBのJavaScriptは作業です。CPUはそのコードを解析、コンパイル、実行しなければなりません。ローエンドのスマートフォンでは、この「重さ」は画面を数秒間フリーズさせる可能性があります。
- **DOMの複雑さ：** すべてのHTMLタグはブラウザのメモリに「ノード」を追加します。5,000ノードを持つページ（「重い」DOM）は、インターネット接続の速さに関わらず、スクロールがもたつく感じにさせます。

ウェブサイトはレンダリング戦略を変更しつつあります。これはAIチャットボットや他の大規模言語モデルツールの増大によってウェブサイトがどのようにアクセスされ消費されるかを再考することで促されることもあります。これらの変更のすべてがAIクローラーのアクセシビリティを目的としているわけではありません。AIクローラーのアクセシビリティの技術要件を特定するためのテストが行われており、これらはクローラー間で異なる場合があります。<a hreflang="en" href="https://vercel.com/blog/the-rise-of-the-ai-crawler">AIクローラーはJavaScriptをレンダリングしない</a>ため、すべての重要な情報は最初の生のHTMLに存在しなければならないことが分かっています。

これらの要因への認識が高まることで、JavaScriptファイルの使用削減を含む、このような戦略のより広い採用が将来のエディションで期待できます。

## 私たちは何を送っているのか？

本章では、数百万のウェブサイト全体でトリリオンバイトを分析して、根本的な質問に答えます：私たちはペイロードからより多くの価値を得ているのか、それとも単に「重量クリープ」に屈しているのか？メディア（画像と動画）の優勢を探ります。これらは転送バジェットのライオンシェアを主張し続けており、JavaScriptの着実な台頭はファイルサイズが示唆するよりもはるかに重いパフォーマンスの税金を運んでいます。

### リクエストバイト

時系列でのページの中央値の重さは、ページサイズの成長が加速していることを示しています。2024年10月以降、特にモバイルデバイスで顕著な上昇トレンドがあります。これは、平均して内部ページよりも約45.8%大きいホームページでより大きなスケールで示されています。

ホームページのページ重量も同様に加速していますが、それより早く2023年初め/2022年後半頃に起きています。

これにはより広い影響があります：

#### AIへのページ重量の影響

エネルギー消費と計算コストが増加しており、重いページは訪問ごとにより多くの帯域幅、レンダリング、CPU負荷を意味し、これらすべてがウェブクロールとインデックスのエネルギーフットプリントを増加させます。

これは、エンティティ抽出やコンテンツ要約などのアクションを実行してウェブを「理解」しようとするAI駆動のクローラーが計算予算を管理するためにクロールの深さや頻度を制限する可能性があるため、より遅いまたは浅いクロールをもたらします。

これは、解析してモデル化しやすいため、読み込みが速いまたはより意味的に明確なサイトなど、より軽いフットプリントのウェブコンテンツへのバイアスにつながる可能性があります。JavaScriptとクライアントサイドレンダリングで過負荷になったサイトは、AIモデルが採用するクローラーはレンダリングしないため、大規模なトレーニングセットで過小代表になる可能性があります。
最終的に、パフォーマンスがより重要になるにつれ、AIは遅いまたは非常に重いページで見るものをスキップまたは切り詰める可能性があります。

#### ユーザーへのページ重量の影響

ページが重くなるにつれ、より多くのサイトがLCPとINPで基準を下回る可能性があり、これは検索結果での可視性を直接低下させる可能性があります。さらに重要なのは、利便性がますます重要な要素となっているため、これはフラストレーティングなユーザーエクスペリエンスを生み出し、コンバージョン率の低下につながる可能性があります。

重いページは、これらの増加によって不釣り合いに影響を受ける低速接続またはローエンドデバイスのユーザーとの間のデジタルデバイドを広げます。これは、検索マーケターにとってこれらのユーザーを念頭に置いてウェブサイトを最適化することの重要性を浮き彫りにしています。

#### パブリッシャーへのページ重量の影響

パフォーマンスの低下はオンライントラフィック、コンバージョン率、広告ビューの低下と相関しています。広告テックとアナリティクスのスクリプトは追加の重量を生み出し、ユーザーエクスペリエンスと収益化の間に摩擦を生み出します。

まとめると：
AIシステムは、スクレイピングを減らして要約を増やし、ギャップを「幻覚」で埋めることで適応するかもしれません。これはブランドへのユーザーの信頼を低下させ、オンライントラフィックとコンバージョンの低下につながる可能性があります。ユーザーの行動は、利便性が人々のオンライン情報へのアクセス方法において重要な役割を果たし続ける中で、従来のページ訪問からAI介在のブラウジング体験へとシフトする可能性があります。

## 経年ページ重量

Web Almanacの設立以来、私たちは一貫して2つのトレンドを観察してきました：

1. リクエストの総量が増加する。
2. デスクトップのページ読み込みはモバイルよりも多くのリクエストをもたらす。

{{ figure_markup(
  image="median-home-page-weight-over-time.png",
  caption="時系列で見た中央値ホームページの重量。",
  description="時系列で中央値ホームページの重量の推移を示す折れ線グラフ。2014年10月のデスクトップ1,208 KB、モバイル505 KBから、2025年7月のデスクトップ2,862 KB、モバイル2,559 KBへとページ重量が増加していることを示す。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=100065523&format=interactive",
  sheets_gid="1902270972",
  sql_file="page_weight_trend.sql"
  )
}}

2015年7月、モバイルホームページの中央値はわずか845 KBでした。2025年7月時点で、同じ中央値ページは2,362 KBになっています。過去10年間で202.8%の増加をもたらしました。デスクトップホームページの中央値は同期間に110.2%増加しました。

前年比で、ホームページサイズの中央値は7.8%増加して2.7 MBになりました。モバイルホームページの中央値は2.6 MBで、2024年の2.4 MBから8.4%増加しています。2025年、デスクトップページサイズの中央値は2.9 MBに達し、2024年の中央値2.7 MBから7.3%増加しました。

{{ figure_markup(
  image="median-inner-page-weight-over-time.png",
  caption="時系列で見た中央値内部ページの重量。",
  description="時系列で中央値ホームページの重量の推移を示す折れ線グラフ。2022年5月のデスクトップ1,574 KB、モバイル1,366 KBから、2025年7月のデスクトップ1,963 KB、モバイル1,769 KBへと内部ページ重量が増加していることを示す。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=516848694&format=interactive",
  sheets_gid="1902270972",
  sql_file="page_weight_trend.sql"
  )
}}

内部ページの重量は前年比9.5%増加し続けました。2022年から内部ページの重量追跡データが開始されて以来、モバイル内部ページの中央値の重量は27.8%増加して1.8 MBになり、デスクトップは同期間に25.2%増加して2 MBに達しました。

## バイト数で見るページ重量

ページ機能のすべての更新は、コア機能を維持しながらパフォーマンスを向上させるために設計された追加の重量とファイルタイプをもたらします。一般的なファイルタイプ、その頻度、およびレスポンスサイズを調査し、異なるデバイスとページタイプ間の比較を含む実装のより明確な理解を得ました。

{{ figure_markup(
  image="page-weight-distribution-by-device.png",
  caption="デバイス別ページ重量分布。",
  description="パーセンタイル別のページ重量分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップページは607 KB、モバイルは516 KB。第25パーセンタイルでは、デスクトップページは1,275 KB、モバイルは1,127 KB。第50パーセンタイル（中央値）では、デスクトップページは2,412 KB、モバイルは2,164 KB。第75パーセンタイルでは、デスクトップページは4,570 KB、モバイルは4,119 KB。第90パーセンタイルでは、デスクトップページは9,179 KB、モバイルは8,337 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=142491648&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="page-weight-distribution-by-page-type.png",
  caption="ページタイプ別ページ重量分布。",
  description="パーセンタイル別のページ重量分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、ホームページは589 KB、内部ページは534 KB。第25パーセンタイルでは、ホームページは1,361 KB、内部ページは1,041 KB。第50パーセンタイル（中央値）では、ホームページは2,710 KB、内部ページは1,866 KB。第75パーセンタイルでは、ホームページは5,422 KB、内部ページは3,267 KB。第90パーセンタイルでは、ホームページは11,406 KB、内部ページは6,109 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2023138567&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

### バイト数で見た中央値ページ

ウェブをよりよく理解するために、第50パーセンタイルを調べることができます。中央値は典型的な値を表し、相対的なページ重量を研究するためのコンテキストを提供します。

{{ figure_markup(
  image="median-mobile-page-weight-by-content-type.png",
  caption="コンテンツタイプ別モバイルページの中央値の重量。",
  description="モバイルページの中央値のリソースタイプ別ページ重量分布をキロバイトで示す棒グラフ。HTMLはホームページで22 KB、内部ページで20 KBを占めた。CSSはホームページで77 KB、内部ページで80 KBを占めた。フォントはホームページで122 KB、内部ページで119 KBを占めた。JavaScriptはホームページで632 KB、内部ページで660 KBを占めた。画像はホームページで911 KB、内部ページで354 KBを占めた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=298835929&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

2025年、モバイルホームページの中央値は以下を使用しました：

- 22 KB のHTMLリソース
- 77 KB のCSSリソース
- 122 KB のフォント
- 632 KB のJavaScript
- 911 KB の画像

内部ページは同様でしたが、画像については911 KBから354 KBに減少しました。

{{ figure_markup(
  image="median-desktop-page-weight-by-content-type.png",
  caption="コンテンツタイプ別デスクトップページの中央値の重量。",
  description="デスクトップページの中央値のリソースタイプ別ページ重量分布をキロバイトで示す棒グラフ。HTMLはホームページで22 KB、内部ページで21 KBを占めた。CSSはホームページで82 KB、内部ページで85 KBを占めた。フォントはホームページで139 KB、内部ページで138 KBを占めた。JavaScriptはホームページで697 KB、内部ページで719 KBを占めた。画像はホームページで1058 KB、内部ページで442 KBを占めた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1561526857&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

デスクトップページの中央値のリソースタイプ別重量はモバイルと一致しましたが、リソースはKBでわずかに大きかったです。2025年、デスクトップホームページの中央値は以下を使用しました：

- 22 KB のHTMLリソース
- 82 KB のCSSリソース
- 139 KB のフォント
- 697 KB のJavaScript
- 1,058 KB の画像

両デバイスタイプで、画像はキロバイト数で最大の差を示し、ホームページで1.06 MB、内部ページで442 KBが使用されました。

{{ figure_markup(
  image="median-home-page-weight-by-content-type.png",
  caption="コンテンツタイプ別ホームページの中央値の重量",
  description="ホームページの中央値のリソースタイプ別ページ重量分布をキロバイトで示す棒グラフ。HTMLはホームページで22 KB、内部ページで22 KBを占めた。CSSはホームページで82 KB、内部ページで77 KBを占めた。フォントはホームページで139 KB、内部ページで122 KBを占めた。JavaScriptはホームページで697 KB、内部ページで632 KBを占めた。画像はホームページで1,059 KB、内部ページで911 KBを占めた。合計で、デスクトップページは2,862 KB、モバイルは2,559 KBだった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1580340306&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

2025年のホームページの中央値はデスクトップで2.86 MB、モバイルで2.56 MBでした。画像はモバイルとデスクトップの両方で最も多くのバイトを占め、次いでJavaScriptとフォントが続きました。

### コンテンツタイプ別レスポンスサイズ

すべてのファイルタイプが同等に作られているわけではありません。また、同じサイズでもありません。ファイルタイプはデータがどのように保存・エンコードされるかを定義し、プログラムにファイルの内容を開いて表示する方法を伝えます。

{{ figure_markup(
  image="median-home-page-response-size-by-format.png",
  caption="フォーマット別ホームページの中央値のレスポンスサイズ。",
  description="ホームページの中央値のファイル形式別レスポンスサイズを示す棒グラフ。QuickTimeはデスクトップで400 KB、モバイルページで976 KBを占めた。MPEGはデスクトップで327 KB、モバイルページで640 KBを占めた。WebMはデスクトップで860 KB、モバイルページで582 KBを占めた。JPGはデスクトップで43 KB、モバイルページで49 KBを占めた。WebP動画はデスクトップで33 KB、モバイルページで21 KBを占めた。WebPはデスクトップで17 KB、モバイルページで20 KBを占めた。PNGはデスクトップとモバイルページで7 KBを占めた。AVIFはデスクトップとモバイルページで7 KBを占めた。ICOはデスクトップで3 KB、モバイルページで2 KBを占めた。SVGはデスクトップとモバイルページで7 KBを占めた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=669081712&format=interactive",
  sheets_gid="1891741241",
  sql_file="response_media_file_type_distribution.sql"
  )
}}

モバイルデバイスは一般的に、パフォーマンスの高い体験を提供することがより難しいです。より小さく多様な画面サイズと弱い接続のため、コンテンツの読み込みに時間がかかる可能性があります。これが、モバイルホームページが最も重いファイルの一部を持っていたことを奇妙にさせています。

最大のファイルタイプ、QuickTimeとMPEGは動画に使用されています。モバイルホームページの中央値は976 KBのQuickTimeを使用しており、これはデスクトップの400 KBより244%多いです。同様に、モバイルホームページの中央値はデスクトップよりも196%多くのMPEGバイトを使用しました。3番目に大きいファイルタイプはWebMで、より速い読み込みと低帯域幅使用のために最適化された動画フォーマットです。モバイル接続に理想的であるにもかかわらず、デスクトップでより多くのWebMバイトが送信されました。

さらに調査したところ、動画ファイルがブラウザが異なるRangeヘッダーで複数のリクエストを行うような重複ダウンロードに特に影響を受けやすいことに驚きました。これにより動画のバイト数が膨らみ、モバイルでより悪化しているようでした（おそらく遅いネットワークダウンロードによる）。この動作についてのドキュメントは見つかりませんでしたが、読者の方が説明できる場合はぜひ聞いてみたいと思います。

{{ figure_markup(
  image="median-inner-page-response-size-by-format.png",
  caption="フォーマット別内部ページの中央値のレスポンスサイズ",
  description="内部ページの中央値のファイル形式別レスポンスサイズを示す棒グラフ。QuickTimeはデスクトップで353 KB、モバイルページで720 KBを占めた。WebMはデスクトップで281 KB、モバイルページで424 KBを占めた。MPEGはデスクトップで162 KB、モバイルページで189 KBを占めた。JPGはデスクトップで33 KB、モバイルページで37 KBを占めた。WebPはデスクトップで13 KB、モバイルページで16 KBを占めた。WebP動画はデスクトップで21 KB、モバイルページで9 KBを占めた。AVIFはデスクトップで5 KB、モバイルページで4 KBを占めた。PNGはデスクトップとモバイルページで4 KBを占めた。ICOはデスクトップとモバイルページで2 KBを占めた。SVGはデスクトップとモバイルページで1 KBを占めた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=300581752&format=interactive",
  sheets_gid="1891741241",
  sql_file="response_media_file_type_distribution.sql"
  )
}}

内部ページの中央値では、QuickTimeファイルがバイト数で最大のファイルタイプであり続けました。モバイルは720 KBで、デスクトップの352.6 KBの202%でした。WebMは内部ページで2番目に大きいファイルタイプとしてMPEGを上回り、モバイルで423.6 KB、デスクトップで280.8 KBでした。次いでMPEGが続き、ホームページよりもデバイスタイプ間でより均等な分布（デスクトップ161.6 KB；モバイル188.8 KB）を示しました。

{{ figure_markup(
  image="distribution-of-response-sizes-by-content-type.png",
  caption="コンテンツタイプ別レスポンスサイズの分布。",
  description="デスクトップページのタイプ別リソースサイズの分布を示すローソク足グラフ。動画は第10パーセンタイルで7 KBから第90パーセンタイルで11,129 KBの範囲。フォントは第10パーセンタイルで16 KBから第90パーセンタイルで158 KBの範囲。Wasmは第10パーセンタイルで4 KBから第90パーセンタイルで775 KBの範囲。音声は第10パーセンタイルで6 KBから第90パーセンタイルで445 KBの範囲。画像は第10パーセンタイルで0 KBから第90パーセンタイルで369 KBの範囲。スクリプトは第10パーセンタイルで1 KBから第90パーセンタイルで165 KBの範囲。CSSは第10パーセンタイルで0 KBから第90パーセンタイルで50 KBの範囲。XMLは第10パーセンタイルで0 KBから第90パーセンタイルで3 KBの範囲。HTMLは第10パーセンタイルで0 KBから第90パーセンタイルで59 KBの範囲。テキストは第10パーセンタイルで0 KBから第90パーセンタイルで1 KBの範囲。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=736168851&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

動画は本来、最も大きなファイルになりがちです。また、サイズの範囲も最大で、第10パーセンタイルの7 KBから第100パーセンタイルの1GBまであります。その範囲は、第10パーセンタイルで0 KB、第100パーセンタイルで1.2GBを示した画像ファイルタイプのみによって上回られます。XMLファイルは最も小さい範囲を示し、第10から第50パーセンタイルまでが0 KBで、最も極端なデスクトップページは第100パーセンタイルで52.1 MBでした。

### 画像バイト

画像バイトとは、写真、アイコン、イラストなどのビジュアル要素をレンダリングするために必要なバイナリデータのことです。HTMLやCSS、JavaScriptのようなテキストベースのファイルとは異なり、非常に効率的で容易に圧縮できますが、画像データは本来密度が高いです。これらのバイトの「重さ」は3つの主要な要因によって決まります：

1. **解像度：** アセットの総ピクセル数。
2. **エンコーディング：** データを保存するために使用される数学的方法（例えば、JPEG、PNG、またはWebPやAVIFのような現代的な形式）。
3. **圧縮：** ファイルサイズを縮小するために冗長なデータを除去する程度で、しばしば視覚的な忠実度のコストを伴います。

画像バイトの蓄積は「重い」ページを生み出し、これはレイテンシの増加とLargest Contentful Paint（LCP）スコアの低下と直接相関しています。モバイルデバイスや帯域幅が制限された接続のユーザーにとって、高い画像バイト数は法外な読み込み時間とデータコストの増加につながる可能性があります。

{{ figure_markup(
  image="image-response-size-distribution-by-device.png",
  caption="デバイス別画像レスポンスサイズの分布",
  description="パーセンタイル別の画像ファイルサイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップとモバイルの画像は0 KB。第25パーセンタイルでは、デスクトップとモバイルの画像は1 KB。第50パーセンタイル（中央値）では、デスクトップとモバイルの画像は8 KB。第75パーセンタイルでは、デスクトップ画像は48 KB、モバイルは52 KB。第90パーセンタイルでは、デスクトップ画像は183 KB、モバイルは186 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=665449543&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

第50パーセンタイルでは、個々の画像ファイルはモバイルとデスクトップの両方で8 KBでした。多くのサイトがアナリティクスの一部としてトラッキングピクセルとして知られる小さな画像を使用していることは注目に値します。これらの小さな、しばしば見えない1x1ピクセルの画像はウェブページに埋め込まれ、読み込まれるとサーバーリクエストをトリガーします。これらのファイルは標準的なユーザー向け画像アセットと区別されないため、中央値の画像サイズが予想より小さく見える原因となる可能性があります。

{{ figure_markup(
  image="image-response-size-distribution-by-page-type.png",
  caption="ページタイプ別画像レスポンスサイズの分布。",
  description="パーセンタイル別の画像ファイルサイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、ホームページと内部ページの画像は0 KB。第25パーセンタイルでは、ホームページ画像は1 KB、内部ページ画像は0 KB。第50パーセンタイル（中央値）では、ホームページ画像は8 KB、内部ページ画像は8 KB。第75パーセンタイルでは、ホームページ画像は48 KB、内部ページは52 KB。第90パーセンタイルでは、ホームページ画像は183 KB、内部ページは186 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1086835098&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

内部ページはホームページよりも個々の画像ファイルサイズが小さく、中央値は4 KBでした。第90パーセンタイルでは、ホームページ画像は185 KB、内部ページ画像は123 KBでした。

{{ figure_markup(
  image="image-size-distribution-by-device.png",
  caption="デバイス別画像サイズの分布",
  description="パーセンタイル別の画像サイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップページは74 KB、モバイルは56 KB。第25パーセンタイルでは、デスクトップページは333 KB、モバイルは256 KB。第50パーセンタイル（中央値）では、デスクトップページは1,058 KB、モバイルは911 KB。第75パーセンタイルでは、デスクトップページは2,896 KB、モバイルは2,617 KB。第90パーセンタイルでは、デスクトップページは6,856 KB、モバイルは6,288 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1892733774&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

ウェブページが単一の画像しか使用しないことはほとんどありません。まとめると、デスクトップページの中央値は1,059 KBの画像を使用しました。モバイルページは911 KBを使用しました。デスクトップページは一貫してより多くの合計画像バイトを読み込みました。

{{ figure_markup(
  image="desktop-image-size-distribution-by-page-type.png",
  caption="ページタイプ別デスクトップ画像サイズの分布。",
  description="パーセンタイル別の画像サイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、ホームページは74 KB、内部ページは34 KB。第25パーセンタイルでは、ホームページは333 KB、内部ページは138 KB。第50パーセンタイル（中央値）では、ホームページは1,058 KB、内部ページは442 KB。第75パーセンタイルでは、ホームページは2,896 KB、内部ページは1,284 KB。第90パーセンタイルでは、ホームページは6,856 KB、内部ページは3,431 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=178146605&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

デスクトップホームページは一貫して内部ページよりも多くの画像を使用しました。ホームページの中央値は類似した内部ページの239%の画像バイトを使用しました。第90パーセンタイルでは、ホームページは内部ページの3,431 KBと比較して6,856 KBとほぼ2倍の画像バイトを使用しました。

{{ figure_markup(
  image="mobile-image-size-distribution-by-device.png",
  caption="デバイス別モバイル画像サイズの分布",
  description="パーセンタイル別の画像サイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、ホームページは56 KB、内部ページは23 KB。第25パーセンタイルでは、ホームページは256 KB、内部ページは95 KB。第50パーセンタイル（中央値）では、ホームページは911 KB、内部ページは354 KB。第75パーセンタイルでは、ホームページは2,617 KB、内部ページは1,134 KB。第90パーセンタイルでは、ホームページは6,288 KB、内部ページは3,147 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=542788776&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

内部ページとホームページの画像使用の範囲をモバイルデバイスのみに絞っても、トレンドは続きます。モバイルデバイスはデスクトップと比較して接続速度が遅く、計算能力が限られていることが多いです。しかしこれはモバイルホームページが画像バイトでそのトピックを表現することを妨げないようです。モバイルホームページの中央値は911 KBの画像を使用し、内部ページは354 KBを使用しました。第90パーセンタイルでは、モバイルホームページは6,288 KBの画像を使用し、デスクトップの6,856 KBにほぼ匹敵しました。

{{ figure_markup(
  image="desktop-home-page-image-sizes-by-format.png",
  caption="フォーマット別デスクトップホームページ画像サイズの分布。",
  description="デスクトップページのタイプ別リソースサイズの分布を示すローソク足グラフ。JPGは第10パーセンタイルで3 KBから第90パーセンタイルで278 KBの範囲。WebPは第10パーセンタイルで1 KBから第90パーセンタイルで97 KBの範囲。AVIFは第10パーセンタイルで1 KBから第90パーセンタイルで37 KBの範囲。PNGは第10パーセンタイルで0 KBから第90パーセンタイルで278 KBの範囲。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2115033325&format=interactive",
  sheets_gid="1891741241",
  sql_file="response_media_file_type_distribution.sql"
  )
}}

ファイルタイプが画像サイズに与える影響は、デジタル情報がどのように整理されて破棄されるかにかかっています。すべての画像は生のピクセルのグリッドとして始まりますが、ファイルフォーマットがそれらのピクセルを保存する方法によって、ファイルが数キロバイトか数メガバイトかが決まります。

- **JPG** ファイルは非可逆型のファイルタイプです。大幅なサイズ削減を実現するために「不要な」データを永久に削除します。どれだけ削除されるかはファイル作成者の裁量によります。これがJPGファイルサイズが最大の範囲にまたがる理由で、第10パーセンタイルの3 KBから第90パーセンタイルの278 KBまでの範囲があります。

- **WebP** は画像の汎用ファイルタイプと考えられています。非可逆と可逆の両方として利用可能で、これらのファイルタイプは第10パーセンタイルの1 KBから第90パーセンタイルの97 KBまでの範囲にまたがります。

- **AVIF** は広く採用されている画像ファイルフォーマットの中で最も新しく、最先端の圧縮効率のために2019年に導入されました。このファイルフォーマットは高品質なウェブ画像を生成しながら、非可逆と可逆の両方の圧縮に使用できます。AVIFは第10パーセンタイルの1 KBから第90パーセンタイルの37 KBまでの範囲にあります。

- **PNG** は大きくても完璧な画像ファイルを作成するために使用され、ロゴやアイコンに理想的なフォーマットです。PNGは第10パーセンタイルの0 KBから第90パーセンタイルの278 KBまでの範囲にあります。

### JavaScriptバイト

JavaScriptの重さの増大は、ウェブサイトがインタラクティブ機能を提供するためにJavaScriptに頼り続ける中でのもう一つの重大なトレードオフです。これらのスクリプトはユーザーエンゲージメントを向上させますが、ペイロードサイズの継続的な増加はサイトパフォーマンスへの課題となっています。

このデータセットは圧縮されたJavaScriptファイルのバイトを表していることに注意することが重要です。圧縮の効率によって、これは大きな違いになることがあります。転送量が大きいほど（圧縮を仮定して）、非圧縮と圧縮の差は指数関数的になる可能性があります。さらに、HTMLページにインライン化されたJavaScriptはこのデータには含まれていません。

{{ figure_markup(
  image="javascript-file-sizes-by-device.png",
  caption="デバイス別JavaScriptファイルサイズの分布。",
  description="パーセンタイル別のJavaScriptファイルサイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップとモバイルファイルは0.4 KB。第25パーセンタイルでは、デスクトップとモバイルファイルは1.2 KB。第50パーセンタイル（中央値）では、デスクトップファイルは4.6 KB、モバイルファイルは4.7 KB。第75パーセンタイルでは、デスクトップファイルは21.8 KB、モバイルファイルは21.6 KB。第90パーセンタイルでは、デスクトップファイルは83.5 KB、モバイルファイルは80.1 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1984047379&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

どんな雨粒も洪水を引き起こしたとは思わないように、JavaScriptファイルの個々の中央値はデスクトップで4.6 KB、モバイルで4.7 KBと非常に小さいです。小さなJavaScriptファイルは、ユーザーインタラクションへのレスポンスを遅らせることなく小さなタスクを完了できるため理想的です。第10パーセンタイルでは、最も軽いJavaScriptファイルは両デバイスタイプで0.4 KBでした。第90パーセンタイルでは、デスクトップのJavaScriptファイルは83.5 KB、モバイルは80.1 KBでした。

{{ figure_markup(
  image="javascript-size-distribution-by-device.png",
  caption="デバイス別JavaScriptサイズの分布。",
  description="パーセンタイル別のJavaScriptサイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップページは106 KB、モバイルは89 KB。第25パーセンタイルでは、デスクトップページは303 KB、モバイルは270 KB。第50パーセンタイル（中央値）では、デスクトップページは708 KB、モバイルは646 KB。第75パーセンタイルでは、デスクトップページは1,291 KB、モバイルは1,233 KB。第90パーセンタイルでは、デスクトップページは2,003 KB、モバイルは1,910 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1594171970&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

比較的小さな個々のJavaScriptファイルをまとめると、全体的なページでの使用状況をより良く把握できます。JavaScriptの使用はモバイルとデスクトップ間で比較的一貫していました。第10パーセンタイルでは、デスクトップは106 KB、モバイルは89 KBを使用しました。デスクトップページの中央値は708 KBのJavaScriptを使用しています。これはモバイルの646 KBよりわずかに高いです。これらの数字は中央値を超えて急速に膨らみます。第90パーセンタイルでは、デスクトップは2 MBをわずかに超え、モバイルは1.9 MBを使用しました。

第100パーセンタイルのデスクトップページは189.9 MBのJavaScriptを使用し、モバイルは181.1 MBを使用しました。比較のために、標準解像度の30分のテレビ番組をダウンロードするのは約150 MBです。

{{ figure_markup(
  image="javascript-size-distribution-by-page-type.png",
  caption="ページタイプ別JavaScriptサイズの分布。",
  description="パーセンタイル別のJavaScriptサイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、ホームページは87 KB、内部ページは108 KB。第25パーセンタイルでは、ホームページは275 KB、内部ページは298 KB。第50パーセンタイル（中央値）では、ホームページは664 KB、内部ページは690 KB。第75パーセンタイルでは、ホームページは1,265 KB、内部ページは1,258 KB。第90パーセンタイルでは、ホームページは1,979 KB、内部ページは1,933 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1867682888&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

画像とは異なり、JavaScriptの使用はホームページと内部ページ間で一貫していました。第10パーセンタイルでは、ホームページは87 KB、内部ページは108 KBのJavaScriptを使用しました。ホームページの中央値は664 KBを使用し、内部ページの対応するページは690 KBを使用しました。第90パーセンタイルでは、ホームページと内部ページはそれぞれ1,979 KBと1,933 KBを使用しました。

#### 未使用JavaScript

未使用のJavaScriptファイルは、無駄な機会だけでなくページの肥大化も表しています。呼び出されたすべてのスクリプトは、ページに貢献するかどうかに関わらず、ダウンロード、解析、コンパイル、実行されなければなりません。

このデータセットはWeb Almanacのクロールと同時に実行されたLighthouseテストからのものであることに注意することが重要です。未使用とは非圧縮後の未使用JavaScriptです。例えば、amazon.co.ukは423 KBのJavaScriptをダウンロードしますが、非圧縮すると1,721 KBになります。

{{ figure_markup(
  image="distribution-of-unused-javascript-by-device.png",
  caption="デバイス別未使用JavaScriptの分布。",
  description="パーセンタイル別の未使用JavaScript分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップページは23 KBの未使用JavaScript、モバイルは89 KBを含んでいた。第25パーセンタイルでは、デスクトップページは107 KB、モバイルは94 KBを含んでいた。第50パーセンタイル（中央値）では、デスクトップページは280 KB、モバイルは251 KBを含んでいた。第75パーセンタイルでは、デスクトップページは578 KB、モバイルは530 KBを含んでいた。第90パーセンタイルでは、デスクトップページは1,004 KB、モバイルは931 KBを含んでいた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=855411300&format=interactive",
  sheets_gid="1940153353",
  sql_file="lighthouse_unused_javascript.sql"
  )
}}

中央値ページでは、デスクトップで280 KB、モバイルで251 KBの非圧縮未使用JavaScriptが存在しました。第100パーセンタイルでは、デスクトップページは驚異的な203.2 MBの非圧縮未使用JavaScriptを示しました。

### 動画バイト

画像はウェブページで最も数多くのアセットであることが多いですが、動画バイトはデジタルペイロードの議論の余地のない重量級チャンピオンです。ウェブが「動画ファースト」の体験へとシフトするにつれ（バックグラウンドのヒーロー動画、ループする商品プレビュー、埋め込みクリップの活用など）、転送されるデータの量は前例のない水準に達しています。

{{ figure_markup(
  image="video-response-size-distribution-by-device.png",
  caption="デバイス別動画レスポンスサイズの分布。",
  description="パーセンタイル別の動画レスポンスサイズ分布をキロバイトで示す棒グラフ。第10パーセンタイルでは、デスクトップファイルは3 KB、モバイルは3 KB。第25パーセンタイルでは、デスクトップファイルは53 KB、モバイルは74 KB。第50パーセンタイル（中央値）では、デスクトップ動画ファイルは247 KB、モバイルは384 KB。第75パーセンタイルでは、デスクトップファイルは1,383 KB、モバイルは1,871 KB。第90パーセンタイルでは、デスクトップ動画ファイルは3,904 KB、モバイルは4,799 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2117267151&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

中央値ページの動画バイトは、2024年の246 KBから2025年の315 KBへと前年比28%増加しました。モバイルはすべてのパーセンタイルで一貫してより多くの動画バイトを使用しました。第100パーセンタイルでは、ページは695 MBの動画を送信しました。文脈として、モバイルデバイスのユーザーがデータプランなしでこれらのページの1つを読み込もうとした場合（<a hreflang="en" href="https://www.telus.com/en/mobility/prepaid/plans">MBあたり0.15ドル</a>を支払うことになる）、動画バイトだけで104.10ドルのコストがかかる可能性があります。

{{ figure_markup(
  image="distribution-of-desktop-video-response-sizes-by-page-type.png",
  caption="ページタイプ別デスクトップ動画レスポンスサイズの分布。",
  description="ホームページと内部ページのデスクトップ動画リソースサイズの分布を示す棒グラフ。ホームページでは第10パーセンタイルで2 KB、第25パーセンタイルで53 KB、中央値で288 KB、第75パーセンタイルで1,934 KB、第90パーセンタイルで4,985 KB。内部ページでは、それぞれ1 KB、54 KB、206 KB、832 KB、2,823 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1538567564&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

デスクトップでは内部ページよりもホームページで多くの動画バイトが送信されました。動画を含むホームページの中央値は288 KBで、動画を含む内部ページは206 KBでした。ページタイプ間のギャップは第75パーセンタイルで最も大きく、ホームページは1,934 KBで、内部ページの832 KBより232.6%大きかった。

{{ figure_markup(
  image="mobile-video-response-size-distribution-by-page-type.png",
  caption="ページタイプ別モバイル動画レスポンスサイズの分布。",
  description="ホームページと内部ページのモバイル動画リソースサイズの分布を示す棒グラフ。ホームページでは第10パーセンタイルで5 KB、第25パーセンタイルで74 KB、中央値で512 KB、第75パーセンタイルで2,624 KB、第90パーセンタイルで6,144 KB。内部ページでは、それぞれ1 KB、74 KB、256 KB、1,119 KB、3,454 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=167542013&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

ホームページでの動画バイトが多いパターンはモバイルデバイスでも続きました。ホームページの中央値は内部ページの256 KBと比較して2倍のバイト（512 KB）を送信しました。第90パーセンタイルでは、モバイルホームページは6.1 MBの動画を読み込みました。

いくつかの技術的な層が動画ファイルサイズに影響を与えます：

- **ファイルフォーマット：** 動画と音声ストリームを保持する「ラッパー」（例えばMP4、WebMなど）。コンテナ自体は軽量ですが、コンテナの選択は通常どの効率的なコーデックが使用できるかを決定します。
- **コーデック（圧縮/解凍）：** 動画を縮小するために使用される数学的アルゴリズムの効率性。H.264（AVC）のようなレガシーコーデックは広く互換性がありますが「重い」のに対し、HEVC（H.265）やAV1のような現代のコーデックは大幅に少ないバイト数でより優れた視覚的品質を提供します。
- **クロマサブサンプリング：** 輝度（ルーマ）情報よりも色情報の解像度を低くすることでファイルサイズを削減する方法で、人間の目が輝度により高い感受性を持つことを利用しています。

ファイルフォーマットは動画バイトに対する最も容易に観察できる要因です。WebMファイルはウェブ用に特別に設計されています。ブラウザの制約に合わせて構築されているため、WebMファイルはMP4より軽量であることが一般的に期待されています。

{{ figure_markup(
  image="distribution-of-mobile-home-page-video-sizes-by-format.png",
  caption="フォーマット別モバイルホームページ動画サイズの分布。",
  description="モバイルホームページ動画のサイズ別分布を示すローソク足グラフ。各ローソク足は動画ファイルフォーマットを表す。ボディは第25から第75パーセンタイルの範囲を示し、ヒゲは記録された最大と最小のスループットを表す。QuickTimeボディは53.6から4,627.2 KBまで。Mpegボディは74.3から3,256 KBまで。WebMボディは7.9から58.6 KBまで。WebP Videoボディは4.4から48.2 KBまで。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1471861495&format=interactive",
  sheets_gid="1891741241",
  sql_file="response_media_file_type_distribution.sql"
  )
}}

モバイルホームページ動画の中央値パーセンタイルでは、QuickTimeファイルが最も高い中央値レスポンスサイズ（976.0 KB）を持ち、次いでmpeg（639.5 KB）とWebM（581.8 KB）が続きます。WebP Videoは21.3 KBと大幅に小さい中央値サイズを持っています。WebP Videoファイルは最大サイズ5,743.5 KB、第90パーセンタイル155.6 KBと、測定されたすべてのパーセンタイルで一貫して最小です。

遭遇した最大のホームページデスクトップ動画ファイルはmpegで、第100パーセンタイルで326 MBでした。

{{ figure_markup(
  image="distribution-of-desktop-home-page-video-sizes-by-format.png",
  caption="フォーマット別デスクトップホームページ動画サイズの分布。",
  description="デスクトップホームページ動画のサイズ別分布を示すローソク足グラフ。各ローソク足は動画ファイルフォーマットを表す。ボディは第25から第75パーセンタイルの範囲を示し、ヒゲは記録された最大と最小のスループットを表す。WebMボディは132.5から2,751.4 KBまで。QuickTimeボディは42.8から2,574.6 KBまで。Mpegボディは64.6から6,124.8 KBまで。WebP Videoボディは9.5から93.6 KBまで。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=291934338&format=interactive",
  sheets_gid="1891741241",
  sql_file="response_media_file_type_distribution.sql"
  )
}}

高端のサイズは類似していますが、中央値（第50パーセンタイル）のサイズはさまざまで、WebMが860.22と最も大きい中央値を持ち、次いでQuickTime（399.97 KB）とmpeg（326.52 KB）が続きます。これは、最大のファイルがほぼ同じサイズであるにもかかわらず、「典型的な」webmファイルがQuickTimeやmpegの対応ファイルより大きいことを示唆しています。

WebP Videoの中央値レスポンスサイズは32.58 KBで、これは他のフォーマットの中央値の10〜26倍小さいです。第90パーセンタイルでも、WebP Videoのサイズ228.33は非常に小さいです。これは、WebP Videoファイルの90%が他の3つのフォーマットの最小の90%よりも小さいことを意味し、他のフォーマットの第90パーセンタイルは6,100を超えています。

WebMの中央値サイズ（860.22）はQuickTime（399.97）の2倍以上、mpeg（326.52）のほぼ3倍で、すべてのフォーマットが非常に大きなファイルを処理できますが、WebMの分布の中心がより大きいサイズに偏っていることを示しています。

遭遇した最大のホームページデスクトップ動画ファイルはQuickTimeで、第100パーセンタイルで431 MBでした。

### CSSバイト

カスケーディングスタイルシート（CSS）はウェブ上のページをスタイリングするために長年使用されており、レイアウトを作成してページの視覚的要素を制御する比較的軽量な方法です。

CSSはHTMLと並行して機能し、フォントスタイル、色、スペーシング、さらには要素の可視性を制御することで、より細かいレベルの制御を提供するとともに、ページの他の側面からの分離によって保守性を高めます。CSSは画像よりも軽量で、大きなアセットをCSSエフェクトやアニメーションに置き換えることでサイトパフォーマンスの向上に役立ちます。

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-device-type.png",
  caption="デバイスタイプ別CSSレスポンスサイズの分布。",
  description="ホームページと内部ページにわたるデバイスタイプ別CSSリソースサイズの分布を示す棒グラフ。第10パーセンタイルでは、デスクトップで10 KB、モバイルで7 KB。第25パーセンタイルでは、デスクトップで38 KB、モバイルで34 KB。第50パーセンタイルでは、デスクトップURLで83 KB、モバイルURLで79 KB。第75パーセンタイルでは、デスクトップで161 KB、モバイルで156 KB。第90パーセンタイルでは、デスクトップで274 KB、モバイルで268 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1522118585&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

モバイルのCSSバイトは、昨年と比べて収縮が見られた下位10%を除くすべてのパーセンタイルで増加しました。

しかし、この成長はページの他の側面と比較するとほとんどが控えめです。第90パーセンタイルでは合計ファイルサイズはわずかに1/4 MBを超えるだけで、昨年から8 KBだけ増加しました。

第50パーセンタイルでは昨年から4 KBの増加で、これはCSSファイルに追加された約4,000文字に相当し、継続的な多用を示しています。

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-page-type.png",
  caption="ページタイプ別CSSレスポンスサイズの分布。",
  description="モバイルとデスクトップデバイスにわたるページタイプ別CSSリソースサイズの分布を示す棒グラフ。第10パーセンタイルでは、ホームページで7 KB、内部ページで10 KB。第25パーセンタイルでは、ホームページで33 KB、内部ページで39 KB。第50パーセンタイルでは、ホームページで79 KB、内部ページで82 KB。第75パーセンタイルでは、ホームページで159 KB、内部ページで158 KB。第90パーセンタイルでは、ホームページで274 KB、内部ページで268 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1708847899&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

内部ページは、再び1 KBの収縮が見られた最低10%を除くすべてのパーセンタイルで成長するという同じトレンドに従っています。
内部ページは第25、50、75パーセンタイルでCSSの使用率がわずかに高い特徴があります。

特に、結果の上位端、第75と第90パーセンタイルに達すると、ホームページが実際にはより大きなCSSサイズを持っています。これはCSSの非効率な使用、つまり現在のページでの使用に関わらず大部分のファイルを読み込んでいること、またはすべてのページのビジュアルを提供するためにCSSへの依存が重くなっていることによる可能性があります。

### HTMLバイト

HTMLバイトとは、ページ上のすべてのマークアップの純粋なテキストの重さを指します。通常は、`<div>`や`<span>`のようなドキュメント定義と一般的に使用されるページタグを含みます。しかし、スクリプトタグの内容や他のタグに追加されたスタイリングなどのインライン要素も含まれています。これはHTMLドキュメントの肥大化を急速に引き起こす可能性があります。

{{ figure_markup(
  image="distribution-of-html-response-sizes-by-device-type.png",
  caption="デバイスタイプ別HTMLレスポンスサイズの分布。",
  description="ホームページと内部ページにわたるデバイスタイプ別HTMLレスポンスサイズの分布を示す棒グラフ。第10パーセンタイルでは、デスクトップとモバイルで6 KB。第25パーセンタイルでは、デスクトップとモバイルで14 KB。第50パーセンタイルでは、デスクトップURLで35 KB、モバイルURLで33 KB。第75パーセンタイルでは、デスクトップで78 KB、モバイルで76 KB。第90パーセンタイルでは、デスクトップで152 KB、モバイルで151 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=884629714&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

HTMLサイズは第10と第25パーセンタイルでデバイスタイプ間で均一でした。第50パーセンタイルから、デスクトップのHTMLがわずかに大きくなりました。デスクトップが401.6 MB、モバイルが389.2 MBに達した第100パーセンタイルまで意味のある差は現れませんでした。

{{ figure_markup(
  image="distribution-of-html-response-sizes-by-page-type.png",
  caption="ページタイプ別HTMLレスポンスサイズの分布。",
  description="デバイスタイプ別HTMLレスポンスサイズの分布を示す棒グラフ。第10パーセンタイルでは、ホームページで5 KB、内部ページで7 KB。第25パーセンタイルでは、ホームページと内部ページで14 KB。第50パーセンタイルでは、ホームページURLで34 KB、内部ページURLで33 KB。第75パーセンタイルでは、ホームページで79 KB、内部ページで76 KB。第90パーセンタイルでは、ホームページで155 KB、内部ページで148 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=971853412&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

HTMLサイズでは内部ページとホームページ間の差はほとんどなく、第75パーセンタイル以上でようやく明らかになります。第100パーセンタイルでは、差は顕著です。内部ページのHTMLは驚異的な624.4 MBに達し、ホームページのHTML 166.5 MBより375%大きいです。

{{ figure_markup(
  image="distribution-of-home-page-html-response-sizes-by-device-type.png",
  caption="デバイスタイプ別ホームページHTMLレスポンスサイズの分布。",
  description="ホームページと内部ページにわたるデバイスタイプ別ホームページHTMLレスポンスサイズの分布を示す棒グラフ。第10パーセンタイルでは、デスクトップとモバイルで5 KB。第25パーセンタイルでは、デスクトップで14 KB、モバイルで13 KB。第50パーセンタイルでは、デスクトップURLで35 KB、モバイルURLで33 KB。第75パーセンタイルでは、デスクトップで80 KB、モバイルで78 KB。第90パーセンタイルでは、デスクトップで154 KB、モバイルで155 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1083482035&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

モバイルとデスクトップのサイズの違いは極めて軽微で、これはほとんどのウェブサイトがモバイルとデスクトップユーザーの両方に同じページを提供していることを示唆しています。

このアプローチは開発者のメンテナンス量を劇的に削減しますが、実質的にサイトの2つのバージョンが1つのページに展開されるため、全体的なページ重量が高くなる可能性があります。

{{ figure_markup(
  image="distribution-of-inner-page-html-response-sizes-by-device-type.png",
  caption="デバイスタイプ別内部ページHTMLレスポンスサイズの分布。",
  description="ホームページと内部ページにわたるデバイスタイプ別HTMLレスポンスサイズの分布を示す棒グラフ。第10パーセンタイルでは、デスクトップとモバイルで6 KB。第25パーセンタイルでは、デスクトップとモバイルで14 KB。第50パーセンタイルでは、デスクトップURLで35 KB、モバイルURLで33 KB。第75パーセンタイルでは、デスクトップで78 KB、モバイルで76 KB。第90パーセンタイルでは、デスクトップで152 KB、モバイルで151 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=213306109&format=interactive",
  sheets_gid="1861272244",
  sql_file="bytes_per_type.sql"
  )
}}

内部ページは第90パーセンタイルまで、ホームページの対応するものと同様の動作をしました。第100パーセンタイルでは、最大の内部ページHTMLレスポンスは両デバイスタイプで同じ624.4 MBでした。標準的な10〜25 Mbpsの接続では、これの読み込みに30〜90秒かかります。

### フォントバイト

画像と動画がページ肥大化の最も明白な要因である一方、ウェブフォントは現代のページ重量の微妙だが重大な部分を占めています。設計フェーズで見落とされることが多い、システム標準フォントからカスタム「ウェブフォント」への移行は、新たなレイテンシの層をもたらしました。タイプフェイスのすべてのユニークなウェイト（太字、ライト、シン）とスタイル（イタリック）は個別のファイルダウンロードを必要とし、単一のフォントファミリーが数百キロバイトの追加データへと急速に膨らむ可能性があります。

これらのフォントの「重さ」は3つの主要な要因によって決まります：

1. **文字サポート：** 複数の言語（ラテン語、キリル文字、ギリシャ語）をサポートするフォントには、基本的な英語のみのフォントよりも何千もの「グリフ」（文字の形）が含まれています。
2. **スタイルとウェイト：** 各バリエーション（例えば、Roboto Regular、Roboto Bold、Roboto Bold Italic）は通常、個別のファイルです。完全な「ファミリー」を読み込むことは、大きな最適化された画像よりも重くなる可能性があります。
3. **フォーマット効率：** TTF（TrueType）やOTF（OpenType）のような古いフォーマットは非圧縮ですが、WOFF2のような現代のウェブ専用フォーマットはBrotli圧縮を使用して品質を失わずにファイルサイズを最大30%削減します。

{{ figure_markup(
  image="distribution-of-font-response-sizes-by-device-type.png",
  caption="デバイスタイプ別フォントレスポンスサイズの分布。",
  description="ホームページと内部ページにわたるデバイスタイプ別フォントレスポンスサイズの分布を示す棒グラフ。第10パーセンタイルでは、デスクトップで9 KB、モバイルで8 KB。第25パーセンタイルでは、デスクトップで15 KB、モバイルで14 KB。第50パーセンタイルでは、デスクトップURLとモバイルで23 KB。第75パーセンタイルでは、デスクトップで47 KB、モバイルで45 KB。第90パーセンタイルでは、デスクトップで79 KB、モバイルで80 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=145051765&format=interactive",
  sheets_gid="263221798",
  sql_file="response_type_distribution.sql"
  )
}}

中央値ページは23 KBのフォントを送信しました。送信バイトは第90パーセンタイルまでデバイス間で緊密に一致し続けました。ホームページと内部ページは中央値を23 KBとして、パーセンタイル全体にわたってまったく同じバイト量を送信しました。詳細については、[フォント](./fonts)チャプターを参照してください。

### その他のファイルタイプ

最終的にウェブは多くのファイルタイプを持つ多様なエコシステムです。あまり見かけないファイルタイプには、中央値ページとデバイスタイプ全体で15 KBのWASM、12 KBの音声が含まれます。JSON、XML、テキストファイルタイプは中央値ページで0 KBの使用でした。少なくとも1つのサイトがモバイルページで117.6 MBのJSONを送信しており、最大の低頻度ファイルタイプのタイトルを獲得していることは注目に値します。

## リクエスト量で見るページ重量

バイトの総数がデータの生の量を測定するのに対し、リクエストの量はブラウザとサーバー間の会話の複雑さを測定します。両方のレンズを通してページの重さを研究することは不可欠です。なぜなら「軽い」ページ（バイト数で）でも、レンダリングに多すぎる個別のリクエストを必要とする場合は「遅い」場合があるからです。バイトはページをダウンロードするために必要な帯域幅を表します。リクエストの量はウェブアーキテクチャに固有のレイテンシのオーバーヘッドを表します。

### 中央値ページのファイルタイプ量

ページの重さに最も貢献しているファイルタイプを理解するために、中央値ページ（第50パーセンタイル）のファイルタイプリクエストを調べました。このアプローチは、各ファイルタイプの全体的な影響を測定するためのベースラインを確立します。

{{ figure_markup(
  image="median-number-of-requests-by-content-type-and-device-type.png",
  caption="コンテンツタイプとデバイスタイプ別のリクエスト数の中央値。",
  description="コンテンツタイプとデバイスタイプ別のリクエスト数の中央値を示す棒グラフ。デスクトップの中央値ページは3つのHTMLファイル、4つのフォントファイル、8つのCSSファイル、14の画像、23のJavaScriptファイル、合計73ファイルを読み込む。モバイルの中央値ページは3つのHTMLファイル、3つのフォントファイル、8つのCSSファイル、12の画像、22のJavaScriptファイル、合計68リクエストを読み込む。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=634930478&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

中央値ページはデスクトップで77リクエスト、モバイルで72リクエストを行います。全体的なリクエストはモバイルで前年比9%、デスクトップで8%増加しました。画像ファイルタイプは2025年も下降トレンドを続け、前年比6%減少しました。

ファイルタイプ別リクエストは前年から概ね一貫していました。デスクトップの中央値は77のリソースを呼び出し、モバイルの対応するものは72だけを必要とします。返されるHTMLファイルの数は両方のページタイプで2から3に増加しました。ホームページの中央値のCSSは、前年から変化なしで安定した内部ページの使用と一致するようにわずかに増加しました。JavaScriptは最も多くリクエストされるファイルタイプであり続けました。

{{ figure_markup(
  image="median-number-of-requests-by-content-type-and-page-type.png",
  caption="コンテンツタイプとページタイプ別のリクエスト数の中央値。",
  description="コンテンツタイプとページタイプ別のリクエスト数の中央値を示す棒グラフ。ホームページの中央値は3つのHTMLファイル、4つのフォントファイル、8つのCSSファイル、19の画像、22のJavaScriptファイル、合計78ファイルを読み込む。内部ページの中央値は3つのHTMLファイル、4つのフォントファイル、8つのCSSファイル、13の画像、23のJavaScriptファイル、合計71ファイルを読み込む。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1228002945&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

ホームページの中央値は3つのHTMLファイル、4つのフォントファイル、8つのCSSファイル、19の画像、22のJavaScriptファイル、合計78ファイルを読み込みます。内部ページの中央値は3つのHTMLファイル、4つのフォントファイル、8つのCSSファイル、13の画像、23のJavaScriptファイル、合計71ファイルを読み込みます。

### リクエスト量分布

中央値の動作が確立されたので、パーセンタイル全体のデータを見ることができます。パーセンタイルはデータポイントがどのように分散しているかを明確に示し、パターンの解釈を容易にします。

{{ figure_markup(
  image="distribution-of-request-volume-by-device-type.png",
  caption="デバイスタイプ別リクエスト量の分布。",
  description="デバイスタイプ別リクエスト量分布を示す棒グラフ。第10パーセンタイルでは、デスクトップは27リクエスト、モバイルは25リクエスト。第25パーセンタイルでは、デスクトップは46、モバイルは42リクエスト。第50パーセンタイルでは、デスクトップは77、モバイルは72リクエスト。第75パーセンタイルでは、デスクトップは122、モバイルは116リクエスト。第90パーセンタイルでは、デスクトップは185、モバイルは179リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=959675191&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

最も軽いページでも今年は重くなりました。第10パーセンタイルでは、最もシンプルなページが今年3つのリクエストを追加しました。対照的に、第90パーセンタイルでは9つの追加ファイルがリクエストされました。これは、極端な例で示されるように、モバイルとデスクトップが同じ数のリクエストを行うことを示しています。

{{ figure_markup(
  image="distribution-of-request-volume-by-page-type.png",
  caption="ページタイプ別リクエスト量の分布。",
  description="ページタイプ別リクエスト量分布を示す棒グラフ。第10パーセンタイルでは、ホームページは25、内部ページは26リクエスト。第25パーセンタイルでは、ホームページは45、内部ページは43リクエスト。第50パーセンタイルでは、ホームページは78、内部ページは71リクエスト。第75パーセンタイルでは、ホームページは125、内部ページは113リクエスト。第90パーセンタイルでは、ホームページは190、内部ページは174リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=68159977&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

ホームページと内部ページでグループ化したデータを見ると、ファイルリクエストの増加はすべてのパーセンタイルで一貫していました。中央値ページはデスクトップで77リクエスト、モバイルで72リクエストを行います。ホームページと内部ページの差はパーセンタイルが上がるにつれて広がります。

これは特に興味深い点で、モバイルとデスクトップでデータを見るとリクエスト数に一貫性が見られ、ホームページのリクエストが重要な差別化要因であることを示しています。

{{ figure_markup(
  image="distribution-of-home-page-request-volume-by-device-type.png",
  caption="デバイスタイプ別ホームページリクエスト量の分布。",
  description="デバイスタイプ別ホームページリクエスト量分布を示す棒グラフ。第10パーセンタイルでは、デスクトップは26、モバイルは24リクエスト。第25パーセンタイルでは、デスクトップは47、モバイルは43リクエスト。第50パーセンタイルでは、デスクトップは80、モバイルは75リクエスト。第75パーセンタイルでは、デスクトップは127、モバイルは122リクエスト。第90パーセンタイルでは、デスクトップは192、モバイルは187リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=907352762&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

デバイスタイプ別のホームページリクエストを見ることで詳細な分析が可能です。各デバイスはホームページと内部ページのデータが混在した場合よりもわずかに多くのリクエストを必要とします。デスクトップホームページの中央値は80リクエストを行い、モバイルの対応するものは75を行います。デバイス間で動作は一貫しており、パーセンタイルにわずかな差異があります。

### 画像リクエスト量

インターネットは猫の写真のために作られたという人もいます。これは献身的な動物愛好家からの誇張かもしれませんが、視覚的コンテンツがウェブを支配しているという事実を浮き彫りにしています。

画像は商品の確認から信頼性の高いニュース報道まで、あらゆる面で重要な役割を果たしています。しかし、これらの静的ファイルはしばしば最も重いデジタルリソースの一つであり、パフォーマンス最適化と技術革新の主要な候補となっています。

{{ figure_markup(
  image="distribution-of-image-requests-by-device-type.png",
  caption="デバイスタイプ別画像リクエストの分布。",
  description="デバイスタイプ別画像リクエスト量分布を示す棒グラフ。第10パーセンタイルでは、デスクトップは5、モバイルは4リクエスト。第25パーセンタイルでは、デスクトップは9、モバイルは8リクエスト。第50パーセンタイルでは、デスクトップは17、モバイルは15リクエスト。第75パーセンタイルでは、デスクトップは32、モバイルは28リクエスト。第90パーセンタイルでは、デスクトップは56、モバイルは52リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2111722175&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

第50パーセンタイルでは、デスクトップは17、モバイルは15の画像リクエストを行いました。デスクトップはパーセンタイル全体で一貫してより多くの画像ファイルを使用しました。これはデスクトップページが18枚の画像を呼び出し、モバイルが16枚をリクエストした2024年からわずかに減少しています。第100パーセンタイルでは、デスクトップページは26,330枚の画像をリクエストしました。そのページがどれほど素晴らしいものかは想像するしかありません。

{{ figure_markup(
  image="distribution-of-image-requests-by-page-type.png",
  caption="ページタイプ別画像リクエストの分布。",
  description="ページタイプ別画像リクエスト量分布を示す棒グラフ。第10パーセンタイルでは、ホームページは5、内部ページは4リクエスト。第25パーセンタイルでは、ホームページは10、内部ページは7リクエスト。第50パーセンタイルでは、ホームページは19、内部ページは13リクエスト。第75パーセンタイルでは、ホームページは35、内部ページは25リクエスト。第90パーセンタイルでは、ホームページは62、内部ページは46リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1855976921&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

ホームページと内部ページを比較すると、差は一貫しています。ホームページの中央値は19枚の画像を読み込み、内部ページでは13枚です。このパターンは全分布範囲にわたって維持され、ホームページが平均20の画像リクエスト、内部ページが14だった2024年のデータと非常に近いです。

画像リクエストにはわずかな減少があり、これは第75と第90パーセンタイルでも見られるトレンドですが、最小限の変化はサイト所有者やパブリッシャーの画像へのアプローチに大きな転換がないことを示唆しています。代わりに、ウェブの画像使用はいつも通りのビジネスとして現れています。

### CSSリクエスト量

カスケーディングスタイルシート（[CSS](https://web.dev/css)）はウェブのプレゼンテーション層として機能します。マークアップ言語で書かれた文書のレイアウトを視覚的に表現することを開発者が定義できるスタイル言語です。Web Almanacの範囲では、HTMLに限定されます。場合によってはSVGも含まれることがあります。

CSSにより開発者は色、フォント、レイアウト、サイズなどの要素を指定でき、HTMLで定義された構造的コンテンツからプレゼンテーションを分離します。レスポンシブデザイン、アニメーションのタッチ、洗練されたレイアウトのための興味深い機能を提供するなど、ますます強力になり続けています。かつてJavaScriptを必要とした視覚的効果は今やCSSで実現でき、CSSは現代のウェブデザインの基盤となっています。

{{ figure_markup(
  image="distribution-of-css-requests-by-device-type.png",
  caption="デバイスタイプ別CSSファイルリクエストの分布。",
  description="デバイスタイプとパーセンタイル別のホームページのCSSファイルリクエスト分布を示す棒グラフ。第10パーセンタイルのデスクトップページは2つのCSSファイル、モバイルは1つを読み込む。第25パーセンタイルはデスクトップで4つ、モバイルも4つ。第50パーセンタイルはデスクトップで8つ、モバイルで8つ。第75パーセンタイルはデスクトップで16、モバイルで16。第90パーセンタイルはデスクトップで31、モバイルで31。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1968461101&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

デスクトップとモバイルデバイスの両方にわたって、ページがリクエストするCSSの量にはほとんど差がありませんでした。第50パーセンタイルでは、モバイルとデスクトップの両方が8つのCSSリソースをリクエストし、全分布にわたって1リソースリクエスト以上の差はありませんでした。これは2024年のパターンと非常に一致しており、前年比でのリクエスト数は第90パーセンタイルまでおおむね安定していました。

第90パーセンタイルでは、今年はデスクトップで31、モバイルで30のCSSリクエストが行われ、デスクトップとモバイルの両方で26だった2024年よりわずかに増加しました。これは、開発者がどれだけの別々のアセットに分割しているか、またはどのようなツールを使用しているかという点で、過去12ヶ月間でCSSへのアプローチにほとんど変化がないことを示唆しています。

また、開発者がクライアントタイプに関わらず同じCSSファイルを提供する可能性がはるかに高いことも示しています。

{{ figure_markup(
  image="distribution-of-css-requests-by-page-type.png",
  caption="ページタイプ別CSSファイルリクエストの分布。",
  description="ページタイプとパーセンタイル別のCSSファイルリクエスト分布を示す棒グラフ。第10パーセンタイルのホームページは1つのCSSファイル、内部ページは2つを読み込む。第25パーセンタイルはホームページで3つ、内部ページは4つ。第50パーセンタイルはホームページで8つ、内部ページで8つ。第75パーセンタイルはホームページで16、内部ページで16。第90パーセンタイルはホームページで31、内部ページで30。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=633938007&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

中央値ページは8つのCSSリクエストを行いました。内部ページは第75パーセンタイルまでホームページよりも多くのリクエストを行いました。第90パーセンタイルでは、ホームページが内部ページより1つ多くのリクエストを行いました。

ホームページと内部ページでリクエストされたファイルの数にはほとんど変化がありません。この分析から同じファイルが提供されているかどうかは判断できませんが、開発者がサイト全体にわたって1セットのCSSリソースを提供しているという事実を示しており、これを分割して実際のページに必要なCSSだけを送ることで個々のページのCSSの重さを削減する機会を逃している可能性があります。

### JavaScriptリクエスト量

画像と動画が静的な重さである一方、JavaScriptは能動的な重さです。その影響は独特で、リソースを2回消費します。ダウンロード時（ネットワーク）と実行時（CPU）です。JavaScriptが多数のリクエストに分割されると（モジュラーコーディングのプラクティスやサードパーティプラグインによることが多い）、パフォーマンスに「二重の税金」をもたらします。

合計バイト数が少ない場合でも、スクリプトリクエストの量が多いとブラウザのメインスレッドが麻痺し、読み込まれているように見えるがユーザー入力に反応しないサイトになる可能性があります。

{{ figure_markup(
  caption="JavaScriptを使用しているページ。",
  content="98.1%",
  classes="big-number",
  sheets_gid="1751156584",
  sql_file="pages_using_javascript.sql"
  )
}}

すべてのページの98.1%が少なくとも1つのJavaScriptファイルのリクエストを行っています。この数字にはHTMLに含まれているインラインJavaScriptは含まれていません。

{{ figure_markup(
  image="distribution-of-javascript-requests-by-device-type.png",
  caption="デバイスタイプ別JavaScriptリクエストの分布。",
  description="デバイスタイプ別JavaScriptリクエスト量分布を示す棒グラフ。第10パーセンタイルでは、デスクトップは5、モバイルは4リクエスト。第25パーセンタイルでは、デスクトップは11、モバイルは10リクエスト。第50パーセンタイルでは、デスクトップは23、モバイルは22リクエスト。第75パーセンタイルでは、デスクトップは40、モバイルは38リクエスト。第90パーセンタイルでは、デスクトップは67、モバイルは65リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=414642373&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

デスクトップの中央値ページはデスクトップで23、モバイルで22のJavaScriptリクエストを行いました。デスクトップページは一貫してモバイルよりも多くのJavaScriptファイルを要求しました。デスクトップホームページは第100パーセンタイルで12,676ファイルがリクエストされ、最も多くのJavaScriptファイルを要求しました。Web Almanacクローラーは今年、年間の冬眠に値します。

{{ figure_markup(
  image="distribution-of-javascript-request-volume-by-page-type.png",
  caption="ページタイプ別JavaScriptリクエスト量の分布。",
  description="ページタイプ別JavaScriptリクエスト量分布を示す棒グラフ。第10パーセンタイルでは、ホームページは4、内部ページは5リクエスト。第25パーセンタイルでは、ホームページは10、内部ページは43リクエスト。第50パーセンタイルでは、ホームページは22、内部ページは23リクエスト。第75パーセンタイルでは、ホームページは38、内部ページは39リクエスト。第90パーセンタイルでは、ホームページは65、内部ページは67リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=976800240&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

内部ページは一貫してホームページよりわずかに多くのJavaScriptファイルを要求しました。ホームページの中央値は22のJavaScriptファイルをリクエストし、内部ページは23をリクエストしました。

### フォントリクエスト量

フォントファイルはウェブサイトがウェブサイトのテキスト部分のスタイリングを指定することを可能にします。通常、大文字と小文字のA〜Zのすべての文字で構成されています。これにより、ブラウザはシステムにインストールされたフォント以外のスタイルにテキストを変換できます。

{{ figure_markup(
  image="distribution-of-font-requests-by-device-type.png",
  caption="デバイスタイプ別フォントリクエストの分布。",
  description="デバイスタイプ別フォントリクエスト量分布を示す棒グラフ。第10パーセンタイルでは、デスクトップとモバイルは0リクエスト。第25パーセンタイルでは、デスクトップとモバイルは2リクエスト。第50パーセンタイルでは、デスクトップとモバイルは4リクエスト。第75パーセンタイルでは、デスクトップは7、モバイルは6リクエスト。第90パーセンタイルでは、デスクトップは10、モバイルは9リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1061546215&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

下位10パーセンタイルは、モバイルとデスクトップの両方でシステムにインストールされたフォントに代わりに依存し、追加のフォントリクエストを使用しません。モバイルのフォントリクエストは第75パーセンタイル以上では平均1つ少ない状態で低くなっています。

{{ figure_markup(
  image="distribution-of-font-requests-by-page-type.png",
  caption="ページタイプ別フォントリクエストの分布。",
  description="ページタイプ別JavaScriptリクエスト量分布を示す棒グラフ。第10パーセンタイルでは、ホームページと内部ページは0リクエスト。第25パーセンタイルでは、ホームページと内部ページは2リクエスト。第50パーセンタイルでは、ホームページと内部ページは4リクエスト。第75パーセンタイルでは、ホームページは7、内部ページは6リクエスト。第90パーセンタイルでは、ホームページと内部ページは10リクエスト。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1855939241&format=interactive",
  sheets_gid="673157393",
  sql_file="request_type_distribution.sql"
  )
}}

ホームページと内部ページは第75パーセンタイルを除いて平均リクエスト数が同一です。デスクトップホームページは第100パーセンタイルで3,038ファイルがリクエストされ、最も多くのフォントを読み込みました。問題のサイトがQ1でパフォーマンス最適化を優先したフォントリポジトリであることを本当に願っています。

一般的に、個々のページで異なるフォントが使用されるのではなく、サイト全体のスタイルとして使用されることが期待されます。プロモーション素材のような例外はありますが、平均はインポートされたフォントのほとんどがサイト全体にわたって使用されていることを示しています。

### その他のリクエスト量

HTMLフラグメント、JSONデータ、サードパーティアセットを含む「ユーティリティ」ファイルのリクエスト量は、大きな累積的な「レイテンシ税」を生み出します。特にマイクロサービスとモジュラーデザインの台頭により、現代のウェブアーキテクチャでは、単一のページ読み込みが小さく分散したファイルへの数十のリクエストをトリガーする可能性があります。これらのファイルがバイト単位で軽量であっても、リクエストの量だけでブラウザのネットワークスタックを圧倒し、ページのレンダリングを遅延させる可能性があります。

中央値ページはHTMLで2リクエスト、その他のファイルタイプで2リクエストを行いました。第90パーセンタイルでは、これはHTMLで12、その他のファイルタイプで12に上昇します。それでも、害のないファイルタイプの新記録を打ち立てることに専念している人もいます。どこかに、ページ読み込みで17,065のその他のファイルタイプをリクエストするデスクトップ内部ページがあります。彼らは第100パーセンタイルであるという夢を達成しました。よくやった、相棒。JSONを置いてください。

## バイト節約技術の採用率

ページ重量を削減する最もシンプルな方法は、そもそもバイトを送信しないことです。ウェブページの構築方法に気を配り、リソースの最適化を作業の標準的な部分にすることは、特定の技術を検討する前でも、ページの全体的な重量に大きな影響を与えることができます。

これに加えて、ネットワーク上で送信されるデータ量を削減するために採用できる特定の技術とテクニックもあります。このセクションでは、サードパーティ埋め込みのファサード、最小化、圧縮の3つを見ていきます。

### 動画やその他の埋め込み用のファサード

ファサード（インタラクション時のインポートとも呼ばれる）は、動画埋め込み、ソーシャルメディアの投稿、またはチャットウィジェットなどの重いアイテムをシンプルなグラフィック表現に置き換えるデザインパターンで、ユーザーがインタラクションする際にのみ完全なインタラクティブな要素に置き換えられます。

ユーザーがクリックするとYouTube埋め込みと関連するすべてのデータとリソースを読み込む、動画のシンプルなサムネイルを想像してください。

これはユーザーがページ読み込み時にこれらの追加リソースをダウンロードしようとしないため、パフォーマンスの向上をもたらし、最終的にページの重量を節約できます。ユーザーがその動画を見たくない、またはチャットボットセッションを開きたくない場合、それらのバイトはリクエストされません。

ファサードを使用しているサイトの検出は実際にはほとんど不可能です。しかし、Lighthouseはバージョン13のリリース前に、[ファサードを使用したサードパーティリソースの遅延読み込み](https://developer.chrome.com/docs/lighthouse/performance/third-party-facades)と呼ばれる、認識されているファサードソリューションを持つ一般的な埋め込みのテストを持っていました。今年のクロールはバージョン12で実行されたため、このメトリックにアクセスできました。

{{ figure_markup(
  image="sites-that-could-implement-third-party-facades.png",
  caption="サードパーティファサードを実装できるサイト。",
  description="サードパーティファサードから恩恵を受けられるサイトの割合を示す棒グラフ。Lighthouseで測定したところ、デスクトップホームページの77%、デスクトップ内部ページの74%、モバイルホームページの41%、モバイル内部ページの46%がサードパーティファサードから恩恵を受けられる。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=39146949&format=interactive",
  sheets_gid="940263948",
  sql_file="facades-usage.sql"
  )
}}

モバイル読み込みのホームページの41%とデスクトップクライアントで読み込まれたホームページの77%がファサードを使った遅延読み込みを実装する機会があると検出されました。これは、70%が検出されたデスクトップの2024年からの後退を表しますが、モバイル読み込みは45%からの改善を示しています。

2024年と同様に、モバイルページはデスクトップページよりもファサードを実装する可能性が高いようです。

興味深いことに、内部ページはデスクトップで74%と高いスコアを示した一方、モバイルでは46%と低かった。おそらく開発者はモバイル訪問者のホームページパフォーマンスに多くの焦点を当てているのでしょうか？

数字はページ重量を削減する大きな機会があることを示していますが、同様に独自の問題もあります。ユーザーが要素とインタラクションしてから知覚できる遅延や、特に動画では再生を開始するためにダブルクリックまたはタップが必要な場合があります。

しかし、ページ上の埋め込みを評価し、このアプローチの実装から恩恵を受けられるものがないか確認することは価値があります。

### 圧縮

圧縮とは、リソースをネットワーク経由でデバイスに送信する前にサイズを削減し、その後デバイスで解凍するプロセスです。このプロセスは通常、特にネットワークが最大のボトルネックである場合に、ページの読み込みを高速化します。

HTML、CSS、JavaScript、JSON、SVG、ico、ttfフォントファイルのようなテキストベースのファイルへのHTTP圧縮は、ネットワーク上でのページ重量を大幅に節約できます。メディアのような他のファイルタイプには恩恵が及ばないことに注意する価値があります。これらのファイルではエンコーディングの一部として圧縮が行われています。

[GZip](https://developer.mozilla.org/docs/Glossary/gzip_compression)、[Brotli](https://developer.mozilla.org/docs/Glossary/Brotli_compression)、または圧縮の新参者である[Zstandard (zstd)](https://developer.mozilla.org/docs/Glossary/Zstandard_compression)を使用してHTTPリクエストを圧縮することで、これらのテキストベースリソースの重さを大幅に削減し、パフォーマンスを向上させることができます。

圧縮がページ重量の問題を完全に解消するわけではないことに注意する必要があります。フルサイズに解凍する必要があり、圧縮と解凍のプロセスは、過度に行われると全体的な速度を低下させる可能性がありますが、それはまれなことで、確かにネットワーク上で節約されるバイト数より優れています。

{{ figure_markup(
  image="proper-text-compression-usage.png",
  caption="適切なテキスト圧縮の使用状況。",
  description="正しいテキスト圧縮を使用しているサイトの割合を示す棒グラフ。Lighthouseで測定したところ、デスクトップホームページの70%、デスクトップ内部ページの71%、モバイルホームページの72%、モバイル内部ページの73%がテキストベースリソースを正しく圧縮している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=884349858&format=interactive",
  sheets_gid="125291842",
  sql_file="compression-usage.sql"
  )
}}

2025年、[LighthouseのEnable text compression監査](https://developer.chrome.com/docs/lighthouse/performance/uses-text-compression/)で測定したところ、デスクトップホームページ読み込みの71%、モバイルホームページ読み込みの72%が適切なテキスト圧縮を使用していました。

内部ページでは、通過率はわずかに高く、デスクトップで72%、モバイルで73%でした。

これは、ホームページのデスクトップ通過率が70%、モバイルが71%で、内部ページがデスクトップ71%、内部ページ72%に達した2024年と比較して小さな改善を示しています。言い換えれば、各セグメントが前年比でわずか1パーセントポイント改善されました。

どんな増加もポジティブですが、すべてのデバイスとページタイプにわたって25%以上のページが効率的な圧縮を使用できていないことは、まだやや残念です。

### 最小化

テキストリソースの[最小化](https://developer.mozilla.org/docs/Glossary/Minification)は、スペース、コメントなどの不要なデータを削除し、関数名や変数名を短くしてより小さなファイルを残すこともできます。

最小化にはクライアントサイドの追加オーバーヘッドはありません。つまり、ファイルは動作するために最小化解除される必要はありません。オンザフライで行う場合、オーバーヘッドは純粋にサーバーサイドです。

しかし、CSSやJavaScriptのような多くのリソースでは、最小化はビルドプロセスの一部として事前に処理できます。一度だけ行う必要があります。

{{ figure_markup(
  image="minified-css-usage.png",
  caption="CSSの最小化の適切な使用状況。",
  description="CSSリソースを正しく最小化しているサイトの割合を示す棒グラフ。Lighthouseで測定したところ、デスクトップホームページの61%、内部ページの61%、モバイルホームページの62%、モバイル内部ページの61%がCSSを正しく最小化している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=833067377&format=interactive",
  sheets_gid="1585520251",
  sql_file="minified_css_usage.sql"
  )
}}

2025年の分析では、デスクトップの61%、モバイルホームページ読み込みの62%、デスクトップとモバイルの内部ページ読み込みの61%がLighthouseの[CSS最小化](https://developer.chrome.com/docs/lighthouse/performance/unminified-css/)監査を通過しました。

これは2024年からわずかな低下を意味し、各メトリックが1%低下するという小さいながらも残念なトレンドです。

{{ figure_markup(
  image="minified-javascript-usage.png",
  caption="JavaScriptの最小化の適切な使用状況。",
  description="JavaScriptリソースを正しく最小化しているサイトの割合を示す棒グラフ。Lighthouseで測定したところ、デスクトップホームページの61%、内部ページの61%、モバイルホームページの63%、モバイル内部ページの61%がJavaScriptを正しく最小化している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=2109774882&format=interactive",
  sheets_gid="707175110",
  sql_file="minified_js_usage.sql"
  )
}}

2025年、デスクトップの62%、モバイルホームページ読み込みの63%がLighthouseの[JavaScript最小化](https://developer.chrome.com/docs/lighthouse/performance/unminified-javascript/)テストを通過しました。

内部ページでは、結果は同様で、デスクトップの61%、モバイル読み込みの63%が通過しました。

これは、デスクトップの58%とモバイルホームページの57%が通過し、デスクトップの59%とモバイルの58%の内部ページが同様だった2024年からの改善を示しています。

今年の正しく最小化されたCSSの若干の低下はあるものの、さらに採用の余地がある中で、最小化されているJavaScriptがより多く増加していることは心強いです。

### キャッシュ

キャッシュルールの賢明な使用は、過度なページ重量を軽減するのに役立ちます。一般的なリソースがブラウザによってローカルにキャッシュされている場合、訪問者がウェブサイトをナビゲートする際や後で戻ってきた時に再びダウンロードする必要がなくなります。これにより、ネットワークリクエストが減り、ページの読み込みが速くなります。

当然ながら、これは重いリソースの問題を完全に軽減するわけではありません。それらは少なくとも一度はリクエストされてダウンロードされる必要があります。

キャッシュは変更される可能性が低い静的リソースに最も効果的です。

Lighthouseは[効率的なキャッシュ有効期限の使用](https://developer.chrome.com/docs/performance/insights/cache)監査を提供しており、明示的にキャッシュしないよう設定されていない限り、少なくとも30日のキャッシュ有効期限を持つページによって呼び出される静的リソースを探します。

{{ figure_markup(
  image="distribution-of-wasted-kb-on-home-pages-due-to-short-cache-ttl.png",
  caption="短いキャッシュTTLによるホームページの無駄なKBの分布",
  description="デバイスタイプにわたる低キャッシュTTL設定による潜在的に無駄なリソース読み込みの分布を示す縦棒グラフ。第10パーセンタイルでは、デスクトップで4 KB、モバイルページで4 KB。第25パーセンタイルでは、デスクトップで74 KB、モバイルで66 KB。第50パーセンタイルでは、デスクトップで303 KB、モバイルで270 KB。第75パーセンタイルでは、デスクトップで1,379 KB、モバイルで1,176 KB。第90パーセンタイルでは、デスクトップで4,654 KB、モバイルで3,764 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=191142815&format=interactive",
  sheets_gid="1976787459",
  sql_file="use-efficient-cache-lifetimes.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-wasted-kb-on-inner-pages-due-to-short-cache-ttl.png",
  caption="短いキャッシュTTLによる内部ページの無駄なKBの分布",
  description="デバイスタイプにわたる低キャッシュTTL設定による潜在的に無駄なリソース読み込みの分布を示す縦棒グラフ。第10パーセンタイルでは、デスクトップで4 KB、モバイルページで4 KB。第25パーセンタイルでは、デスクトップで62 KB、モバイルで56 KB。第50パーセンタイルでは、デスクトップで220 KB、モバイルで201 KB。第75パーセンタイルでは、デスクトップで794 KB、モバイルで705 KB。第90パーセンタイルでは、デスクトップで2,248 KB、モバイルで1,946 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=385053741&format=interactive",
  sheets_gid="1976787459",
  sql_file="use-efficient-cache-lifetimes.sql"
  )
}}

データは、多くのウェブサイトがブラウザキャッシュをより有効活用することでページ重量を削減できることを示しています。デスクトップホームページでは、中央値のサイトが約303 KBを節約でき、モバイルホームページではリソースが一貫してキャッシュから読み込まれた場合に約270 KBを節約できる可能性があります。

内部ページはわずかに優れていますが、まだ改善の余地があります。潜在的な節約の中央値はデスクトップで220 KB、モバイルで201 KBです。

これらの数字は潜在的な節約を表しています。初回訪問者には適用されず、任意のリソースがキャッシュされるかブラウザキャッシュから取得されるという保証もありません。

しかし、潜在的な節約を考えると、キャッシュ戦略を見直す価値があるかもしれません。例えば、キャッシュタイミングを確認し、web.devの[HTTPキャッシュを使った不必要なネットワークリクエストの防止](https://web.dev/articles/http-cache)記事のガイダンスを見直すことを検討してください。いくつかの調整は、リピートユーザーにとってより速い体験につながり、不必要なネットワーク活動を削減する可能性があります。

### CDN

キャッシュと同様に、CDNはデフォルトでファイルサイズを削減しないため、ページ重量の確実な解決策ではありません。代わりに、軽減策として機能します。

CDNはオリジンサーバーよりもユーザーに地理的に近いサーバーからコンテンツをキャッシュして提供できます。これはリソースが軽量にはならないものの、物理的な距離が縮まることでコンテンツ配信が速くなり、知覚されるパフォーマンスが向上することを意味します。

多くのCDNは、画像や動画のような資産の圧縮、再エンコーディング、リサイズの処理などの追加機能も提供しています。これらの機能は多くの場合自動または半自動で、つまり最小限の開発時間を必要とし、実際のページ重量を削減するシンプルな方法を提供できます。

これらのページ重量節約最適化テクニックの実装に苦労している場合、すでに使用しているCDNサービスが何を提供しているかを評価するか、他のCDNプロバイダーを探して組み込みツールが何を提供しているか確認することが価値あるかもしれません。
CDNはますます普及し強力になっており、[CDN](./cdn)チャプターでより詳細な情報を得ることをお勧めします。

## ページの重さとCore Web Vitals

今年、[Core Web Vitals](https://developers.google.com/search/docs/appearance/core-web-vitals)データを分析に含めることができました。これらの新しい洞察には重要な注意事項があります：すべてのページがURLレベルのCrUXデータを持っているわけではありません。

明確にするために、CrUXまたはChrome User ExperienceデータはウェブサイトをブラウズするオプトインしたChromeユーザーから収集されるデータです。このデータは制御された環境でのパフォーマンスではなく、実際のユーザーがウェブページをどのように体験するかを反映しています。

CrUXデータセットに含まれるためには、ページが[最小数の訪問者](https://developer.chrome.com/docs/crux/methodology#popularity-eligibility)を駆動する必要があります。その結果、データセットはより人気のあるサイトに偏り、クロールコーパス全体を表していません。

この制限にもかかわらず、常に変化するウェブ上で機能とページ重量のバランスを取る努力をする中で、これらの発見が貴重な視点を提供するものとして役立つことを願っています。

{{ figure_markup(
  caption="2〜3 MBのモバイルページがCore Web Vitalsに合格",
  content="45%",
  classes="big-number",
  sheets_gid="131977176",
  sql_file="pass-all-cwv-by-mb-home-inner.sql"
  )
}}

Core Web Vitalsは、ウェブサイトとのインタラクション時の人間体験の品質を測定するために設計された人間中心のメトリクスのセットです。3つの主要な領域に焦点を当てています：

1. 視覚的な読み込みを測定するLargest Contentful Paint
2. 視覚的な安定性を測定するCumulative Layout Shift
3. インタラクティビティを測定するInteraction to Next Paint

### CrUXデータ：重量別Core Web Vitals評価

ページがCore Web Vitals評価に合格するためには、第75パーセンタイルで良好なLCPとCLSメトリクスを示すCrUXユーザーデータを持ち、INPが第75パーセンタイルで良好か完全に存在しないかのいずれかである必要があります。INPはインタラクティビティを測定しており、すべてのページが訪問者を呼び込むわけではないため、INPデータセットは最も疎になりがちです。ページ重量は計算の一部ではありませんが、データは合計メガバイトと合格率の間の明確な相関関係を示しています。


{{ figure_markup(
  image="pct-of-home-pages-passing-cwv-by-page-weight.png",
  caption="ページ重量別のCore Web Vitalsに合格するホームページの割合。",
  description="異なるページ重量での3つのCore Web Vitals全てに合格するホームページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの70%、モバイルの57%が合格。1 MBから2 MBの間では、デスクトップの59%、モバイルの52%が合格。2 MBから3 MBの間では、デスクトップの53%、モバイルの45%が合格。3 MBから4 MBの間では、デスクトップの48%、モバイルの38%が合格。4 MBから5 MBの間では、デスクトップの44%、モバイルの34%が合格。5 MB以上のページでは、デスクトップの38%、モバイルの30%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1228614280&format=interactive",
  sheets_gid="131977176",
  sql_file="pass-all-cwv-by-mb-home-inner.sql"
  )
}}

1 MB以下のデスクトップホームページの70%がこの評価に合格しました。対照的に、5 MB以上のホームページは38%しか合格せず、軽量な対応ページの合格率のほぼ半分です。モバイルページは同様のパターンを示しています：1 MB以下のページの57%が合格したのに対し、5 MB以上のページは30%しか合格しませんでした。ホームページの重量が増加するにつれて合格率は着実に低下し、モバイルはすべての重量カテゴリーでデスクトップに一貫して遅れを取っています。

2025年、ホームページの中央値はデスクトップで2.9 MB、モバイルで2.6 MBでした。2〜3 MBの範囲では、デスクトップページの63%がCore Web Vitals評価に合格しました。これらの数字はCrUXフィールドデータに依存しているため、主に最も人気のあるサイトのパフォーマンスを反映しています。同じ重量範囲のモバイルでは、ページの53%が合格しました。

{{ figure_markup(
  image="pct-of-inner-pages-passing-cwv-by-page-weight.png",
  caption="ページ重量別のCore Web Vitalsに合格する内部ページの割合。",
  description="異なるページ重量での3つのCore Web Vitals全てに合格する内部ページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの79%、モバイルの68%が合格。1 MBから2 MBの間では、デスクトップの66%、モバイルの55%が合格。2 MBから3 MBの間では、デスクトップの63%、モバイルの63%が合格。3 MBから4 MBの間では、デスクトップの58%、モバイルの50%が合格。4 MBから5 MBの間では、デスクトップの56%、モバイルの47%が合格。5 MB以上のページでは、デスクトップの50%、モバイルの42%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=819647158&format=interactive",
  sheets_gid="131977176",
  sql_file="pass-all-cwv-by-mb-home-inner.sql"
  )
}}

上記で観察されたように、内部ページはホームページより軽量である傾向があります。2025年、ホームページの中央値はデスクトップで2.9 MB、モバイルで2.6 MBでした。内部ページは比較すると軽量で、モバイルの中央値は1.8 MB、デスクトップは2 MBでした。

データは内部ページの方がホームページよりも緩やかなパターンを示しています。1 MB以下のデスクトップ内部ページの79%がCore Web Vitals評価に合格しました。5 MB以上の内部ページの50%が評価に合格しました。モバイルページは合格しにくく、1メガバイトごとに合格率が徐々に低下します。

### CrUXデータ：重量別Largest Contentful Paint

[Largest Contentful Paint（LCP）](https://web.dev/articles/lcp)は、ユーザーがページへのナビゲーションを開始してから、ビューポート内の最大の画像、テキストブロック、または動画がレンダリングされるまでにかかる時間を測定します。ユーザー体験の第75パーセンタイルが2.5秒以内に収まると、ページは合格スコアを達成します。

{{ figure_markup(
  image="pct-of-home-pages-with-good-lcp-by-page-weight.png",
  caption="ページ重量別の良好なLargest Contentful Paintを持つホームページの割合。",
  description="異なるページ重量での良好なLargest Contentful Paintを持つホームページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの82%、モバイルの72%が合格。1 MBから2 MBの間では、デスクトップの76%、モバイルの65%が合格。2 MBから3 MBの間では、デスクトップの71%、モバイルの59%が合格。3 MBから4 MBの間では、デスクトップの67%、モバイルの54%が合格。4 MBから5 MBの間では、デスクトップの64%、モバイルの50%が合格。5 MB以上のページでは、デスクトップの57%、モバイルの44%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1743591811&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

最も軽いページはLCPに合格し、デスクトップの82%、モバイルの72%が合格スコアを達成しました。中央値のページ重量を表す2〜3 MBの範囲のページは、デスクトップで71%、モバイルで59%の合格率でした。最も重いページ、つまり5 MB以上のページでは、合格率はデスクトップで57%、モバイルで44%に低下しました。

{{ figure_markup(
  image="home-page-lcp-by-page-weight-crux.png",
  caption="ページ重量グループ別の秒単位のホームページのLargest Contentful Paint。",
  description="異なるページ重量でグループ化したホームページのLargest Contentful Paintまでの時間を示す棒グラフ。1 MB以下のページでは、LCPはデスクトップで2.1秒、モバイルで2.6秒で達成。1 MBから2 MBの間では、LCPはデスクトップで2.5秒、モバイルで3.0秒で達成。2 MBから3 MBの間では、LCPはデスクトップで2.7秒、モバイルで3.2秒で達成。3 MBから4 MBの間では、LCPはデスクトップで2.8秒、モバイルで3.4秒で達成。4 MBから5 MBの間では、LCPはデスクトップで3.0秒、モバイルで3.6秒で達成。5 MB以上のページでは、LCPはデスクトップで3.3秒、モバイルで3.8秒で達成。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1829796459&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

2〜3 MBの範囲のホームページでは、LCPはデスクトップで2.7秒、モバイルで3.2秒で達成されました。モバイルは1 MB以下のページでさえ2.5秒未満を達成するのに苦労し、LCPは2.6秒を記録しました。ページ重量が増加するにつれてLCP時間も相応に上昇し、モバイルは最大コンテンツ要素のレンダリングに約0.5秒長くかかります。

{{ figure_markup(
  image="pct-of-inner-pages-with-good-lcp-by-page-weight.png",
  caption="ページ重量別の良好なLargest Contentful Paintを持つ内部ページの割合。",
  description="異なるページ重量での良好なLargest Contentful Paintを持つ内部ページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの91%、モバイルの86%が合格。1 MBから2 MBの間では、デスクトップの85%、モバイルの77%が合格。2 MBから3 MBの間では、デスクトップの83%、モバイルの73%が合格。3 MBから4 MBの間では、デスクトップの67%、モバイルの54%が合格。4 MBから5 MBの間では、デスクトップの64%、モバイルの50%が合格。5 MB以上のページでは、デスクトップの57%、モバイルの44%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=221207967&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

内部ページはホームページよりも優れたLargest Contentful Paintのパフォーマンスを示しています。1 MB以下のページでは、デスクトップの91%、モバイルの86%の内部ページがメトリクスに合格しました。

1〜2 MBの範囲のページはモバイル内部ページの中央値サイズを表しており、この範囲のページの77%がスコアを達成しました。2 MBでは、デスクトップの中央値内部ページは同様に動作する2つの範囲の境界に位置しています。2〜3 MBの範囲では、デスクトップ内部ページの83%が合格しました。

{{ figure_markup(
  image="largest-contentful-paint-inner-pages-by-page-weight-crux.png",
  caption="ページ重量別の内部ページのLargest Contentful Paint時間。",
  description="ページ重量でグループ化した内部ページのLargest Contentful Paintまでの時間を示す棒グラフ。1 MB以下のページでは、LCPはデスクトップで1.6秒、モバイルで2.0秒で達成。1 MBから2 MBの間では、LCPはデスクトップで2.0秒、モバイルで2.4秒で達成。2 MBから3 MBの間では、LCPはデスクトップで2.1秒、モバイルで2.6秒で達成。3 MBから4 MBの間では、LCPはデスクトップで2.3秒、モバイルで2.8秒で達成。4 MBから5 MBの間では、LCPはデスクトップで2.3秒、モバイルで2.8秒で達成。5 MB以上のページでは、LCPはデスクトップで2.4秒、モバイルで3.0秒で達成。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=483912866&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

内部ページは全体的にホームページよりも優れたLCPパフォーマンスを示しています。2 MB以下のページは第75パーセンタイルのLCP合格閾値を満たしました。デスクトップページはすべてのサイズ範囲で一貫して評価に合格しました。

### CrUXデータ：重量別Cumulative Layout Shift

2番目のCore Web VitalsメトリクスであるCumulative Layout Shift（CLS）は、ページの視覚的安定性を測定します。ページ読み込みの最初の5秒間に目に見える要素が予期せず動く量を計算し、移動する要素のサイズと移動距離の両方を考慮します。これらのシフトはセッションウィンドウ全体で平均化されて最終スコアが生成されます。

{{ figure_markup(
  image="pct-of-home-pages-with-good-cls-by-page-weight-crux.png",
  caption="ページ重量別の良好なCumulative Layout Shiftを持つ内部ページの割合。",
  description="異なるページ重量での良好なCumulative Layout Shiftを持つホームページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの84%、モバイルの88%が合格。1 MBから2 MBの間では、デスクトップの76%、モバイルの82%が合格。2 MBから3 MBの間では、デスクトップの72%、モバイルの78%が合格。3 MBから4 MBの間では、デスクトップの69%、モバイルの76%のページ。4 MBから5 MBの間では、デスクトップの67%、モバイルの74%が合格。5 MB以上のページでは、デスクトップの64%、モバイルの71%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1793002028&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

第75パーセンタイルでは、2〜3 MB範囲のデスクトップホームページの72%とモバイルホームページの78%がCLS基準を満たしています。これらのページは2025年の中央値ページを表しています。CLSはLCPよりもパーセンタイル間での低下が少なかった。1 MB以下のモバイルページの88%が合格しました。ページ重量が5 MBを超えてもモバイルページの71%はまだ合格しました。

{{ figure_markup(
  image="cls-home-pages-by-page-weight-crux.png",
  caption="ページ重量別のホームページのCumulative Layout Shift。",
  description="異なるページ重量でグループ分けされたホームページのCumulative Layout Shiftまでの時間を示す棒グラフ。1 MB以下のページでは、CLSはデスクトップで0.05、モバイルで0.02でした。1 MBから2 MBの間では、CLSはデスクトップで0.1、モバイルで0.05でした。2 MBから3 MBの間では、CLSはデスクトップで0.13、モバイルで0.08でした。3 MBから4 MBの間では、CLSはデスクトップで0.14、モバイルで0.1でした。4 MBから5 MBの間では、CLSはデスクトップで0.16、モバイルで0.11でした。5 MB以上のページでは、CLSはデスクトップで0.19、モバイルで0.14でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=774306985&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

CLSの合格スコアは≤ 0.10です。CLSスコアはデスクトップで一貫して高く、これはより広いランドスケープが要素のシフトにより多くのスペースを提供するためと考えられます。デスクトップでは2 MB未満のページが評価に合格し、モバイルでは4 MB未満のページが望ましいスコアを達成しました。

{{ figure_markup(
  image="pct-of-inner-pages-with-good-cls-by-page-weight-crux.png",
  caption="ページ重量別の良好なCumulative Layout Shiftを持つ内部ページの割合。",
  description="異なるページ重量での良好なCumulative Layout Shiftを持つ内部ページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの87%、モバイルの90%が合格。1 MBから2 MBの間では、デスクトップの78%、モバイルの84%が合格。2 MBから3 MBの間では、デスクトップの74%、モバイルの77%が合格。3 MBから4 MBの間では、デスクトップの71%、モバイルの75%が合格。4 MBから5 MBの間では、デスクトップの69%、モバイルの73%が合格。5 MB以上のページでは、デスクトップの65%、モバイルの69%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1309475261&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

CLSに合格した内部ページの割合はホームページの割合と同様でした。中央値の2〜3 MBを代表するデスクトップモバイルホームページの72%に対し、内部ページの対応する74%が合格しました。モバイル内部ページの77%が合格し、モバイルデスクトップページの78%と比較されました。

{{ figure_markup(
  image="cls-inner-pages-by-page-weight-crux.png",
  caption="ページ重量別の内部ページのCumulative Layout Shift。",
  description="異なるページ重量でグループ分けされた内部ページのCumulative Layout Shiftまでの時間を示す棒グラフ。1 MB以下のページでは、CLSはデスクトップで0.04、モバイルで0.01でした。1 MBから2 MBの間では、CLSはデスクトップで0.08、モバイルで0.04でした。2 MBから3 MBの間では、CLSはデスクトップで0.11、モバイルで0.09でした。3 MBから4 MBの間では、CLSはデスクトップで0.13、モバイルで0.11でした。4 MBから5 MBの間では、CLSはデスクトップで0.15、モバイルで0.12でした。5 MB以上のページでは、CLSはデスクトップで0.17、モバイルで0.16でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=785004421&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

内部ページのページ重量がCLSに与える影響は、範囲をまたいで一定のパターンを示しています。2 MB以下のデスクトップページと3 MB以下のモバイルページは0.10未満のスコアを達成できました。3 MB以上のページは一貫して望ましいしきい値を超えるスコアを記録しました。

### CrUXデータ：重量別Interaction to Next Paint

3番目のCore Web VitalsメトリクスはInteraction to Next Paint（INP）です。ページのライフサイクル全体でのインタラクティブ性を表すように設計されたINPは、ユーザーがクリック、タップ、またはキーを押してから次の視覚的な更新が表示されるまでのインタラクションの総待ち時間を測定します。200ミリ秒以下のINPは良好なレスポンシブ性を示します。

{{ figure_markup(
  image="pct-of-home-pages-with-good-inp-by-page-weight-crux.png",
  caption="ページ重量別の良好なInteraction to Next Paintを持つホームページの割合。",
  description="異なるページ重量での良好なInteraction to Next Paintを持つホームページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの98%、モバイルの78%が合格。1 MBから2 MBの間では、デスクトップの97%、モバイルの80%が合格。2 MBから3 MBの間では、デスクトップの97%、モバイルの78%が合格。3 MBから4 MBの間では、デスクトップの96%、モバイルの74%のページ。4 MBから5 MBの間では、デスクトップの96%、モバイルの72%が合格。5 MB以上のページでは、デスクトップの95%、モバイルの72%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=137499164&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

INPメトリクスはすべてのCore Web Vitalsメトリクスの中で最も高いデスクトップ合格率を示しています。1 MB以下のホームページでは98%がINPに合格し、5 MB以上の範囲でも95%のデスクトップホームページが評価に合格しています。

モバイルホームページの合格率は低く、1 MB以下のページの78%が合格しましたが、1〜2 MBの範囲のページはわずかに改善され、80%が200ms未満でINPを達成しました。

{{ figure_markup(
  image="inp-home-pages-by-page-weight-crux.png",
  caption="ページ重量別のホームページのInteraction to Next Paint。",
  description="異なるページ重量でグループ分けされたホームページのInteraction to Next Paintまでの時間を示す棒グラフ。1 MB以下のページでは、INPはデスクトップで62ms、モバイルで184msでした。1 MBから2 MBの間では、INPはデスクトップで70ms、モバイルで177msでした。2 MBから3 MBの間では、INPはデスクトップで73ms、モバイルで187msでした。3 MBから4 MBの間では、INPはデスクトップで76ms、モバイルで204msでした。4 MBから5 MBの間では、INPはデスクトップで78ms、モバイルで215msでした。5 MB以上のページでは、INPはデスクトップで82ms、モバイルで217msでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1132016626&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

デスクトップホームページはすべての重量カテゴリで200msの閾値を下回るINP時間を一貫して達成しており、最も重い5 MB以上の範囲でも、第75パーセンタイルのINPはわずか82msでした。3 MB以下のモバイルホームページはINP目標を達成しました。しかし、3〜4 MBの範囲では、第75パーセンタイルのINPが200msを超えました。

{{ figure_markup(
  image="pct-of-inner-pages-with-good-inp-by-page-weight-crux.png",
  caption="ページ重量別の良好なInteraction to Next Paintを持つ内部ページの割合。",
  description="異なるページ重量での良好なInteraction to Next Paintを持つ内部ページの割合を示す棒グラフ。1 MB以下のページでは、デスクトップの99%、モバイルの78%が合格。1 MBから2 MBの間では、デスクトップの97%、モバイルの70%が合格。2 MBから3 MBの間では、デスクトップの97%、モバイルの74%が合格。3 MBから4 MBの間では、デスクトップの96%、モバイルの72%のページ。4 MBから5 MBの間では、デスクトップの94%、モバイルの70%が合格。5 MB以上のページでは、デスクトップの92%、モバイルの65%が合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1518724658&format=interactive",
  sheets_gid="602772059",
  sql_file="good-ni-poor-percent-cwv-by-mb.sql"
  )
}}

内部ページはモバイルとデスクトップの間に同様のギャップを示しています。1 MB以下のページの99%が200ms未満のINPを達成したのに対し、同じ重量範囲のモバイルページは78%にとどまりました。5 MB以上では、デスクトップ内部ページの92%がインタラクティブ性評価に合格したのに対し、65%のモバイルページが目標を達成しました。

{{ figure_markup(
  image="inp-inner-pages-by-page-weight-crux.png",
  caption="ページ重量別の内部ページのInteraction to Next Paint。",
  description="異なるページ重量でグループ分けされた内部ページのInteraction to Next Paintまでの時間を示す棒グラフ。1 MB以下のページでは、INPはデスクトップで55ms、モバイルで186msでした。1 MBから2 MBの間では、INPはデスクトップで73ms、モバイルで227msでした。2 MBから3 MBの間では、INPはデスクトップで82ms、モバイルで207msでした。3 MBから4 MBの間では、INPはデスクトップで77ms、モバイルで213msでした。4 MBから5 MBの間では、INPはデスクトップで88ms、モバイルで222msでした。5 MB以上のページでは、INPはデスクトップで95ms、モバイルで254msでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1413690208&format=interactive",
  sheets_gid="716803504",
  sql_file="cwv_by_mb.sql"
  )
}}

### Lighthouseデータ：重量別Core Web Vitals評価

上記で分析した新たに利用可能なCrUXデータに加えて、2024年に初めて導入した合成Core Web Vitals評価を継続しています。このデータは、この年次レポートを支えるHTTP Archiveクロール中にLighthouseを実行することで収集されます。[Lighthouse](https://developer.chrome.com/docs/lighthouse)は、Googleが開発した無料のオープンソース自動化ツールで、パフォーマンス、アクセシビリティ、SEOなど複数の分野でWebページの品質を評価します。開発者がリリースプロセスの一部として本番環境の問題を監視・軽減するためによく使用されます。

LighthouseデータをラボデータまたはSyntheticデータとして区別することが重要です。実際の体験をエミュレートするように設計されていますが、実際のユーザーのサイトパフォーマンスに影響するすべての要因を考慮することはできません。また、ページの初期読み込みのみを測定するため、インタラクティブ性の計算が継続的なインタラクティブ性と視覚的安定性に限定されます。

CrUXはリアルな人間の体験をより正確に表していますが、限界もあります。Webページはデータセットに表示されるためにデータ匿名化要件を満たすのに十分な訪問数を受ける必要があり、人気のあるページやウェブサイトが表示される可能性が高くなります。

URLにCrUXデータが利用可能な場合は、よりパフォーマントな体験を作るための取り組みの焦点として考慮すべきです。フィールドデータにより、実際の人間の問題を解決できます。Lighthouseのようなラボデータは、実際のユーザーメトリクスで特定された問題をトラブルシューティングするためのより多くのメトリクスを提供します。

### Lighthouseデータ：重量別Largest Contentful Paint

Largest Contentful Paintは、3つのCore Web Vitalsの中でSyntheticテストで最も正確に捉えることができます。出力は、実行する特定のテストシナリオ（コールドロード、事前定義されたスクリーンサイズ、ネットワークスロットリング、CPUスロットリング）に基づく推定値にすぎません。これらの条件がサイトの特定のユーザーにとって現実的かどうかが、LighthouseのLCPがどれだけ「正確」かを決定します。

{{ figure_markup(
  image="synthetic-lcp-by-device-type.png",
  caption="デバイスタイプ別のSynthetic Largest Contentful Paint（秒）。",
  description="Lighthouseで測定したLargest Contentful Paintまでの時間を示す棒グラフ。第10パーセンタイルでは、LCPはデスクトップで1.0秒、モバイルで2.1秒で達成。第25パーセンタイルでは、LCPはデスクトップで1.4秒、モバイルで3.0秒。第50パーセンタイルでは、LCPはデスクトップで2.2秒、モバイルで4.7秒。第75パーセンタイルでは、LCPはデスクトップで3.5秒、モバイルで8.5秒。第90パーセンタイルでは、LCPはデスクトップで3.0秒、モバイルで3.6秒で達成。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1412641202&format=interactive",
  sheets_gid="166619293",
  sql_file="lighthouse_cwv_trends.sql"
  )
}}

良好なLargest Contentful Paintスコアは2.5秒未満です。Lighthouseテストでは、中央値のデスクトップページがこの閾値を満たし、2.2秒を達成しました。モバイルのパフォーマンスは著しく劣り、同じタスクでLCPに4.7秒かかりました。モバイルページの最速第10パーセンタイルのみが2.1秒のLCPで合格スコアを達成しました。対照的に、第90パーセンタイルのモバイルページは15.1秒のLCPを達成し、推奨目標の約6倍遅い結果でした。デスクトップページは第50パーセンタイルまで2.5秒未満でLCPを達成しました。

{{ figure_markup(
  image="crux-lcp-by-device-type.png",
  caption="CrUXで測定したLargest Contentful Paintのリアルユーザーメトリクス（秒）。",
  description="Lighthouseで測定したLargest Contentful Paintまでの時間を示す棒グラフ。第10パーセンタイルでは、LCPはデスクトップで1.0秒、モバイルで2.1秒で達成。第25パーセンタイルでは、LCPはデスクトップで1.4秒、モバイルで3.0秒。第50パーセンタイルでは、LCPはデスクトップで2.2秒、モバイルで4.7秒。第75パーセンタイルでは、LCPはデスクトップで3.5秒、モバイルで8.5秒。第90パーセンタイルでは、LCPはデスクトップで3.0秒、モバイルで3.6秒で達成。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=748997391&format=interactive",
  sheets_gid="1154933839",
  sql_file="crux_cwv_trends.sql"
  )
}}

Chrome User Experienceレポートが提供するリアルユーザーメトリクスは、Webのはるかにパフォーマントな姿を描いています。モバイルとデスクトップの両ページが第50パーセンタイルまで2.5秒未満でLCPを達成しました。第90パーセンタイルでは、デスクトップのフィールドデータはラボデータより1.8秒速かった。モバイルはさらに大きなギャップを示し、第25パーセンタイルから始まって、LighthouseはCrUXで見られるものの2倍以上のLCP値を報告し、第90パーセンタイルまでには、Syntheticの結果はリアルユーザーメトリクスより328%高くなりました。

データセットのこのような大きな差異は、このメトリクスの存在理由を裏付けるものかもしれません。LCPが遅いページは、ユーザーが視覚的な読み込みの欠如を無反応と感じるため、放棄される可能性が高くなります。より多くの放棄されたページロードは、CrUXデータセットの対象となるのに十分なページビューを達成する可能性を下げます。

### Lighthouseデータ：重量別Cumulative Layout Shift

視覚的安定性はSyntheticテストでは初期ページロード中にのみ測定できます。これはメトリクスの堅牢な性質を正確に反映していません。リアルユーザーのページロードで測定されるCLSは、単一の測定値ではなく、「セッションウィンドウ」内のすべてのレイアウトシフトの集積です。セッションウィンドウは1秒未満の間隔で複数のレイアウトシフトが発生する5秒間の期間です。最も高いスコアのセッションウィンドウがページのCLSスコアとして報告されます。

{{ figure_markup(
  image="synthetic-cls-by-device-type.png",
  caption="デバイスタイプ別のSynthetic Cumulative Layout Shift。",
  description="Lighthouseで測定したLargest Contentful Paintまでの時間を示す棒グラフ。第10パーセンタイルでは、LCPはデスクトップで1.0秒、モバイルで2.1秒で達成。第25パーセンタイルでは、LCPはデスクトップで1.4秒、モバイルで3.0秒。第50パーセンタイルでは、LCPはデスクトップで2.2秒、モバイルで4.7秒。第75パーセンタイルでは、LCPはデスクトップで3.5秒、モバイルで8.5秒。第90パーセンタイルでは、LCPはデスクトップで3.0秒、モバイルで3.6秒で達成。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1221443468&format=interactive",
  sheets_gid="166619293",
  sql_file="lighthouse_cwv_trends.sql"
  )
}}

Syntheticデータでは、第75パーセンタイルまでのページが初期ページロードで実質的にCLSに合格していることを示しています。モバイルとデスクトップのスコアは第50パーセンタイルまで一致していました。最も高いスコアは第90パーセンタイルのモバイルページで、0.32を記録しました。

{{ figure_markup(
  image="crux-cls-by-device-type.png",
  caption="CrUXで測定したCumulative Layout Shiftのリアルユーザーメトリクス。",
  description="CrUXで測定したSynthetic Cumulative Layout Shiftまでの時間を示す棒グラフ。第10パーセンタイルから第25パーセンタイルでは、CLSはデスクトップとモバイルで0.0でした。第50パーセンタイルでは、CLSはデスクトップで0.03、モバイルで0.0でした。第75パーセンタイルでは、CLSはデスクトップで0.13、モバイルで0.08でした。第90パーセンタイルでは、CLSはデスクトップで0.36、モバイルで0.29でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1913589530&format=interactive",
  sheets_gid="1154933839",
  sql_file="crux_cwv_trends.sql"
  )
}}

CrUXデータでは、拡張された時間枠とシングルページアプリケーション（SPA）および動的に読み込まれるコンテンツのメカニズムのより良い考慮を導入します。CLSのリアルユーザーメトリクス計算は、ユーザーが体験する可能性が最も高いレイアウトシフトの最大の「バースト」に焦点を当てています。

第50パーセンタイルまでのすべてのユーザーが0.10未満のCLSを体験しました。第75パーセンタイルでは、デスクトップユーザーは良好なCLSを見た一方、モバイルは0.13のCLSでわずかに閾値を超えました。第90パーセンタイルでは、CrUXデスクトップユーザーはモバイルユーザー（0.29）よりも高い視覚的不安定性（0.36）を体験しました。第90パーセンタイルのモバイルユーザーのCrUXデータはSyntheticの対応値（Lighthouseで0.32；CrUXで0.29）より低かった。

### Lighthouseデータ：重量別Total Blocking Time

CrUXデータでは、インタラクティブ性はInteraction to Next Paint（INP）として測定されます。つまり、このメトリクスはページのライフサイクル全体でのユーザー入力と視覚的フィードバックの間の時間を測定します。Lighthouseは初期ページロードのみを測定でき、そのためにインタラクティブ性を推定する代替メトリクスを使用します。[Total Blocking Time（TBT）](https://web.dev/articles/tbt)は、ページロード中にメインスレッドがブロックされた合計時間を測定するラボメトリクスです。TBTはINPのプロキシとして機能します。高いTBTはしばしば高いINPにつながるため、TBTを修正することがINPを改善する重要な方法です。

{{ figure_markup(
  image="synthetic-tbt-by-device-type.png",
  caption="Lighthouseで測定したTotal Blocking Time（ミリ秒）。",
  description="Lighthouseで測定したTotal Blocking Timeまでの時間を示す棒グラフ。第10パーセンタイルでは、TBTはデスクトップで0ms、モバイルで146msで達成。第25パーセンタイルでは、TBTはデスクトップで1ms、モバイルで668msでした。第50パーセンタイルでは、TBTはデスクトップで78ms、モバイルで1,835msでした。第75パーセンタイルでは、TBTはデスクトップで294ms、モバイルで3,953msでした。第90パーセンタイルでは、TBTはデスクトップで722ms、モバイルで7,102msで達成。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=1804092239&format=interactive",
  sheets_gid="166619293",
  sql_file="lighthouse_cwv_trends.sql"
  )
}}

メインスレッドが200ミリ秒未満しかブロックされない場合、ページは良好なTBTを持つと見なされます。モバイルページの第10パーセンタイルのみがこのメトリクスを達成しました。デスクトップページは第50パーセンタイルまで200ms未満のTBTを達成しました。第90パーセンタイルでは、モバイルデバイスのメインスレッドは7.1秒間ブロックされました。

{{ figure_markup(
  image="crux-inp-by-device-type.png",
  caption="CrUXで測定したInteraction to Next Paintのリアルユーザーメトリクス（ミリ秒）。",
  description="CrUXで測定したInteraction to Next Paintまでの時間を示す棒グラフ。第10パーセンタイルでは、INPはデスクトップで36ms、モバイルで97msでした。第25パーセンタイルでは、INPはデスクトップで51ms、モバイルで130msでした。第50パーセンタイルでは、INPはデスクトップで76ms、モバイルで200msでした。第75パーセンタイルでは、INPはデスクトップで120ms、モバイルで320msでした。第90パーセンタイルでは、INPはデスクトップで661ms、モバイルで854msでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRYHxN-EU2nT4dq_bQVWu7mIXxjqUzMGe0HsYEKeU2MiiBqYc1kn1HkO0axkSs1gDDBPB21SRG4dKq9/pubchart?oid=495504735&format=interactive",
  sheets_gid="1154933839",
  sql_file="crux_cwv_trends.sql"
  )
}}

TBTのフィールドメトリクスの対応値であるINPは、200msという同じタイミング目標を共有しています。CrUXはモバイル体験のよりレスポンシブな姿を描いています。第50パーセンタイルまでのモバイルとデスクトップページは良好なレスポンシブ性を達成しました。第75パーセンタイルでは、デバイス間の差異がより顕著になり、デスクトップのINPは120ms（まだ良好なレスポンシブ性と見なされる）、モバイルでは320msで、ユーザーはより多くのラグを感じます。モバイルCrUXデータの第90パーセンタイルは、200msの目標の4倍のINPを計算しました。Syntheticモバイルデータの第90パーセンタイルは、同じ目標の35倍のTBTを記録しました。

## 結論

シンプルな結論は、Web上のすべてのページが年々サイズが拡大し続けているということです。この成長はユーザーデバイスとインターネット接続への需要を加速的に増大させています。

機能性対アクセシビリティのバランスは機能性の方向に傾き続けており、接続やデバイスが限られたユーザーはより悪く、包括的でない体験を被っています。

JavaScriptは依然としてこの成長の主要な原動力であり、98.1%のページが少なくとも1つのリクエストを行っています。JavaScriptはしばしば非効率的にページに追加され、ページに重みを加えながらも積極的に使用されていません。

画像とそのホームページと内部ページの両方での広範な使用は、ページに大量の重みをもたらしており、デスクトップとモバイルの差異は昨年に比べて縮小しており、画像がWeb体験に与える影響を考えると最適化への注目が薄れていることが懸念されます。

これらすべての重みの影響は、重みが増加するにつれてCore Web Vitalsの高い失敗率として見ることができ、Chrome User Experienceレポートデータを含め、ユーザーへの影響が理論的ではなく現実のものであることを示しています。

最終的に、ユーザー体験にまったく影響を与えることなく改善の巨大な機会がここにあります。ロスレス圧縮とJavaScriptに必要なものだけを使用することは、ユーザーにとって大きなメリットとWebオーナーのコスト削減を表しますが、現在これらの機会の多くが無視されています。

ページの重さは引き続き重要な問題ですが、現在のところ、解決策からはますます遠ざかっているようです。
