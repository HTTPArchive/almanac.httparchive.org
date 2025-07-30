---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: ページの重さ
description: 2024年版 Web Almanac の「ページの重さ」の章では、ページの重さが重要な理由、帯域幅、複雑なページ、経時的なページの重さ、ページリクエスト、ファイル形式について解説します。
hero_alt: Web Almanac のキャラクターが、さまざまなキロバイトのラベルが貼られた箱とウェブページを天秤で比較しているヒーローイメージ。
authors: [dwsmart, fellowhuman1101]
reviewers: [ines-akrap]
editors: [montsec]
analysts: [burakguneli]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1GHTFwsjJokf1U5dZmDg-7bBlH_Lu-rlOHVmmzTj0D98/
fellowhuman1101_bio: Jamie Indigoはロボットではありませんが、ボットと話します。<a hreflang="en" href="https://www.coxautoinc.com/">Cox Automotive</a> のテクニカルSEOディレクターとして、検索エンジンがウェブをどのようにクロールし、レンダリングし、インデックスに登録するかを研究しています。Jamieは野生のJavaScriptを飼いならし、レンダリング戦略を最適化するのが大好きです。仕事以外の時間は、ホラー映画やグラフィックノベルを楽しみ、ダンジョンズ＆ドラゴンズで合法的な善のパラディンを恐怖に陥れています。
dwsmart_bio: Dave Smartは <a hreflang="en" href="https://tamethebots.com">Tame the Bots</a> の開発者兼テクニカル検索エンジンコンサルタントです。ツールを作成したり、モダンなウェブで実験したりするのが好きで、ギグや2つのギグで最前線にいることがよくあります。
featured_quote: ページの重さはアクセシビリティの問題です。ページの重さが大きいと、最高級のデバイスや高速でデータ使用量の上限が高い接続を利用できないユーザーに不釣り合いな影響を与えます。
featured_stat_1: 1.8 MB
featured_stat_label_1: 過去10年間におけるモバイルページの重さの中央値の増加。
featured_stat_2: 1,235 ms
featured_stat_label_2: ページの重さによる、モバイルページの中央値の合計ブロック時間。
featured_stat_3: 41%
featured_stat_label_3: モバイルのホームページでは、すべてのJavaScriptが圧縮されていません。
doi: 10.5281/zenodo.14562057
---

## はじめに

インターネットは急速に成長しています。新しいページが作られるたびに、そのコンテンツをレンダリングするために必要なリソース一式がもたらされますが、より多くのコンピューティングリソースが必要とされるため、これは高価なものとなります。これらの帯域幅要求は、ジェネレーティブAIイニシアチブのコンピューティングリソースと競合しています。

米国では、急速に増大するAI需要により、データセンターのエネルギー消費量が2026年には国内総電力使用量の約<a hreflang="en" href="https://hbr.org/2024/07/the-uneven-distribution-of-ais-environmental-impacts">6%</a>に達すると予測されており、送電網インフラへのさらなる圧力がかかり、継続的なAIの進歩を支えるための持続可能なソリューションの緊急の必要性が浮き彫りになっています。これらのジェネレーティブAIイニシアチブは、ひいてはウェブの規模を急速に増大させるでしょう。<a hreflang="en" href="https://www.statista.com/statistics/871513/worldwide-data-created/">Statistaは、2024年に149ゼタバイト</a>のインターネットコンテンツが作成されたと推定しています。比較すると、2010年から2018年までの合計は127.5ゼタバイトでした。

要するに、リソースはますます希少になり、高価になっています。Googleが現在、ページ上の要素を優先しているため、ページの重さの問題に取り組むことが重要になっています。ウェブサイトの不必要な肥大化を減らすことは、ユーザー体験を向上させ、コンバージョンを高めるだけでなく、持続可能性への取り組みもサポートします。

2024年のウェブパフォーマンスに関する議論で強調されているように、重いウェブサイトは、とくにローエンドのデバイスでのユーザーアクセスと応答性の不平等の一因となり、「パフォーマンスの不平等ギャップ」を広げています。Alex Russelのシリーズ、<a hreflang="en" href="https://infrequently.org/2024/01/performance-inequality-gap-2024/">パフォーマンスの不平等ギャップ</a>は、現在のデバイスのパフォーマンスと機能に関して行われているいくつかの仮定が真実ではないかもしれないこと、そしてデバイスがますます強力になっている一方で、それがすべての人に当てはまるわけではなく、ペイロードの大きいウェブページによって悪影響を受けるユーザーのロングテールが存在することを鋭く浮き彫りにしています。

この格差の拡大は、すべてのユーザーに公平なアクセスとエンゲージメントを確保するために、軽量で効率的なウェブデザインの重要性を強調しています。不適切なタイミングでネットワーク接続が弱くなった場合でも、インターネットへのアクセスがメガバイト単位で課金される市場に住んでいる場合でも、ページの重さは重要であり、ページの重さが増加すると情報の利用可能性が低下します。

### ページの重さはアクセシビリティの問題です

ページの重さが大きいと、最高級のデバイスや高速でデータ使用量の上限が高い接続を利用できないユーザーに不釣り合いな影響を与えます。

肥大化したページは、これらにアクセスできない人々にとって、ウェブの体験がより高価でパフォーマンスの低いものになることを意味し、極端な場合にはページが実質的に使用できなくなることさえあります。

## ページの重さとは？

ページの重さとは、ウェブページのバイトサイズのことです。ウェブはその誕生以来、大規模に進化しており、2024年のページの重さは、到着したURLのHTMLだけではありません。ほとんどすべての場合、そのページを読み込んで表示するために必要なアセットが含まれます。これらのアセットには、次のものが含まれます。

- サーバーからの最初のレスポンスで返される[HTML](./markup)。
- ページに埋め込まれた[画像やその他のメディア（動画、音声など）](./media)。
- ページをスタイリングするための[カスケーディングスタイルシート（CSS）](https://developer.mozilla.org/ja/docs/Web/CSS)。
- インタラクティビティと機能性を提供するための[JavaScript](./javascript)。
- 他のプロバイダーからの、上記のうちの1つまたは複数でありうる[サードパーティのリソース](./third-parties)。

ウェブページに追加されるすべての余分なものは、全体のページの重さを増加させ、すべてのビットは最終的に、ネットワークを介して送信し、処理し、解析し、最終的にユーザーが消費し対話するために画面にレンダリングし描画するという、ブラウザにとってより多くの作業とオーバーヘッドを意味します。

リソースのいくつかの形式は、さらに大きなオーバーヘッドを伴います。とくにJavaScriptは、コンパイルして実行する必要もあります。これは、持続可能性とコンバージョン率の両方に連鎖的な影響を及ぼします。ページが重ければ重いほど、[より多くの二酸化炭素排出量](./sustainability#ウェブサイトの環境への影響を評価する)が発生し、そのページでのコンバージョン率の可能性は低くなります。

ページの重さが二酸化炭素排出量に与える影響について詳しくは、[サステナビリティ](./sustainability)の章をご覧ください。

ページの重さと、それが読み込み時間に与える全体的な影響を管理するのに役立つさまざまな緩和策がありますが、より重いものは常により多くの作業を伴うという厳しい現実があります。

重さの影響は、ストレージ、伝送、レンダリングの3つの主要なカテゴリに分けることができます。

### ストレージ

ウェブページのすべてのバイトはどこかに保存される必要があり、ウェブの仕組みの性質上、それは通常、複数の場所に保存されることを意味します。

それはウェブサーバー自体から始まります。純粋なストレージスペースは、ストレージの種類にもよりますが、ギガバイトあたりのコストは比較的小さいままです。たとえば、Googleのクラウドストレージは、[北米では月額0.02ドルから0.03ドル](https://cloud.google.com/storage/pricing#north-america)、ヨーロッパでは0.006ドルから0.025ドルです。ウェブサーバーのメモリに保存されたリソースは、ディスク上のリソースよりも高速にアクセスできますが、コストはディスク上のリソースよりもはるかに速く上昇します。

同じリソースの複数のコピーが、多数の中間キャッシュに分散され、エッジキャッシュが採用されている場合は複数のデータセンターに分散されることもあります。

方程式の2番目の部分は、これらのリソースがページにアクセスするときにユーザーのデバイスにも保存される必要があるということです。ローエンドのデバイス、とくにモバイルデバイスは、保持できる量にはるかに制限がある場合があります。大きなペイロードをプッシュすると、ストレージ容量が圧倒され、他の貴重なリソースがキャッシュからパージされる可能性があります。これにより、それらのリソースを再利用したであろう新しいページに移動するときに、追加のコストとパフォーマンスの低下につながる可能性があります。

### 送信

初めてサイトにアクセスするときは、すべてのリソースをインターネット経由でデバイスに配信する必要があります。同じURLへのその後のアクセス、あるいは同じサイト上の他のURLへのアクセスでさえ、リソースの一部はキャッシュから使用できるかもしれませんが、かなりの量がネットワーク経由で再度取得される必要があるかもしれません。

すべてのネットワーク接続がどこでも同じというわけではありません。非常に高速なブロードバンド接続でデータ制限が寛大である場合もあれば、従量制で上限のある低速なモバイル接続である場合もあります。

したがって、戦略的に考えるのが最善です。ページの重さが大きいほど、リソースの送信に時間がかかり、モバイル接続が遅い、またはデータ制限が低いユーザーがもっとも大きな打撃を受け、ビジネスにも影響を与える可能性があります。

リソースの送信を最適化する最善の方法は、小さなリソースを提供することです。それが難しい場合は、[リソースヒント](https://web.dev/learn/performance/resource-hints)（プリコネクトやプリロードなど）や[フェッチ優先度](https://web.dev/articles/fetch-priority)を使用して、ページでリソースが読み込まれる順序を管理できます。

### レンダリング

ブラウザが要求されたURLを誰かの画面に描画する前に、それらのリソースを収集して処理する必要があります。

ページの重さが大きいほど、ブラウザが必要なすべての部分を取得して処理するのに時間がかかり、ユーザーがページを読んで対話できる時点が遅れます。

読み込み後でも、過度のページの重さは、ブラウザが大きなリソースをシャッフルするのに手間取っているため、ページの対話への応答が遅くなる可能性があります。


## 数字で見るページの重さ

インターネットは、裸のテキストの場所から、今日私たちが知っている豊かでインタラクティブな風景へと、新しいコンテンツタイプを導入することによって開花しました。画像は視覚的な深みをもたらし、Javascriptはインタラクティビティを可能にし、動画はストーリーテリングの新しい方法を導入しました。

これらの各テクノロジーは、ページにより多くの重みをもたらしました。1995年にHTML 2.0が導入される前は、重み付けされる唯一のアセットはHTMLでした。<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc1866">RFC 1866</a>が`<img>`タグを導入したとき、ページの重さは劇的に増加しました。1996年には、JavaScriptがスケールに乗り、10年後にはJQueryのようなライブラリが続きました。2010年には、広く認識された最初の単一アプリケーションフレームワークが登場し、Angular、React、VueなどのJavaScriptフレームワークが市場に参入する道を開きました。

ページの機能が進化するたびに、機能を維持しながらパフォーマンスを向上させることを目的とした、より多くの重みとファイルタイプがもたらされます。

一般的なファイルタイプ、その出現頻度、および応答サイズを分析して、その適用をよりよく理解しました。これには、デバイスおよびページタイプ別の比較が含まれます。

### 中央値ページのファイルタイプリクエスト

ページの重さに関連するファイルタイプを理解するには、ページの50パーセンタイルのファイルタイプリクエストを見る必要があります。これにより、各ファイルタイプが全体に与える影響のベースラインが提供されます。

{{ figure_markup(
  image="number-of-requests-by-content-and-device-type.png",
  caption="コンテンツタイプおよびデバイスタイプ別の中央値リクエスト数。",
  description="コンテンツタイプおよびデバイスタイプ別の中央値リクエスト数を示す棒グラフ。中央値のデスクトップページは、HTMLファイル2つ、フォントファイル4つ、CSSファイル8つ、画像18枚、JavaScriptファイル24個、合計71個を読み込みます。中央値のモバイルページは、HTMLファイル2つ、フォントファイル3つ、CSSファイル8つ、画像16枚、JavaScriptファイル22個、合計66個のリクエストを読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1656379757&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

デスクトップページのリクエスト総数は9%減少し、2022年のページあたり76リクエストから71に減少しました。同様に、モバイルは70から66リクエストに減少しました。画像ファイルタイプの数は2024年に43%減少しました。

デスクトップページは2024年に18枚の画像をリクエストしましたが、2022年には25枚でした。

Javascriptは、もっともリクエストされたファイルタイプとして画像を追い抜きました。中央値のページは、デスクトップページで24のJavascriptリソースをリクエストしました。モバイルでは22のリクエストがありました。

{{ figure_markup(
  image="number-of-requests-by-content-and-page-type.png",
  caption="コンテンツタイプおよびページタイプ別の中央値リクエスト数。",
  description="コンテンツタイプおよびページタイプ別の中央値リクエスト数を示す棒グラフ。中央値のホームページは、HTMLファイル2つ、フォントファイル4つ、CSSファイル7つ、画像20枚、JavaScriptファイル23個を読み込みます。中央値の内部ページは、HTMLファイル2つ、フォントファイル4つ、CSSファイル8つ、画像14枚、JavaScriptファイル22個を読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=513546724&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

ページの重さの行動パターンを分析し始めると、内部ページの影響に注意することが重要です。この章全体を通して、ホームページと内部ページを比較した場合にのみ表示される強い差異が見られます。

これは、新しいデータがデバイスタイプの比較を変更するため、注目に値します。これを念頭に置いて、2022年のデータセットに対してより正確な測定値を得るために、ホームページにフィルタリングされた比較も含まれています。

### リクエスト量

ページが行う各リクエストは、意図したエクスペリエンスとコンテンツを作成するために必要なコンポーネントです。リクエストの総数、ビルドを完了するために必要なピースの数は、ページのパフォーマンスに影響します。

最新のブラウザはマルチスレッドおよびマルチプロセスです。これは、ネットワークリクエストを含むさまざまなタスクを処理するために複数のスレッドとプロセスを利用できることを意味します。各リクエストは実行にリソースを必要とし、技術的な制限により、同時に完了できるリクエストの数は限られています。人間と同様に、ブラウザも一度にできることは限られています。

この知識があれば、リクエストの数がページの重さと知覚されるパフォーマンスの両方に影響することがわかります。

{{ figure_markup(
  image="distribution-of-requests-by-device-type.png",
  caption="デバイスタイプ別のリクエストの分布。",
  description="デバイスタイプおよびパーセンタイル別のリクエストの分布を示す棒グラフ。10パーセンタイルのデスクトップページは24リクエスト、モバイルは22リクエスト、25パーセンタイルはデスクトップで42リクエスト、モバイルで39リクエスト、50パーセンタイルはデスクトップで71リクエスト、モバイルで66リクエスト、75パーセンタイルはデスクトップで115リクエスト、モバイルで109リクエスト、90パーセンタイルはデスクトップで176リクエスト、モバイルで170リクエストを読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1595667871&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

中央値のページは、デスクトップで71件、モバイルで66件のリクエストを行います。これらの数値には、ホームページと内部ページの両方が含まれます。2022年の分布と比較すると、すべてのパーセンタイルでファイル総数が減少しています。

{{ figure_markup(
  image="distribution-of-requests-by-page-type.png",
  caption="ページタイプ別のリクエストの分布。",
  description="ページタイプおよびパーセンタイル別のリクエストの分布を示す棒グラフ。10パーセンタイルでは、ホームページは22リクエスト、内部ページは23リクエストを読み込みます。25パーセンタイルでは、ホームページは42リクエスト、内部ページは39リクエストです。50パーセンタイルでは、ホームページは72リクエスト、内部ページは65リクエストです。75パーセンタイルでは、ホームページは117リクエスト、内部ページは107リクエストです。90パーセンタイルでは、ホームページは180リクエスト、内部ページは166リクエストです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1854762675&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

全体的に低い数値は、ホームページと比較して内部ページからのリクエスト数が一貫して少ないことによって影響を受けます。中央値のホームページは72のリソースを呼び出しますが、その内部の対応物は65しか必要としません。

{{ figure_markup(
  image="distribution-of-requests-by-homepages-by-device-type.png",
  caption="デバイスタイプ別のホームページによるリクエストの分布。",
  description="デバイスタイプおよびパーセンタイル別のホームページのリクエストの分布を示す棒グラフ。10パーセンタイルのデスクトップページは23リクエスト、モバイルは21リクエスト、25パーセンタイルはデスクトップで43リクエスト、モバイルで40リクエスト、50パーセンタイルはデスクトップで74リクエスト、モバイルで70リクエスト、75パーセンタイルはデスクトップで120リクエスト、モバイルで114リクエスト、90パーセンタイルはデスクトップで182リクエスト、モバイルで177リクエストを読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=728818282&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

データの整合性のためにホームページのみを分析した場合、2024年の総リクエスト数はわずかに減少しましたが、2022年のレートと一致していました。中央値のデスクトップホームページは2022年に76のリソースをリクエストし、現在は74をリクエストしています。モバイルの中央値は変更されていません。

### 画像

画像は、ウェブページを構築し表示するために不可欠な静的ファイルです。ウェブがますます視覚的になるにつれて、パフォーマンスを向上させるテクノロジーとアセットのバイトサイズのバランスをとる必要性を例示しています。

{{ figure_markup(
  image="Distribution-of-image-requests-by-device-type.png",
  caption="デバイスタイプ別の画像リクエストの分布。",
  description="デバイスタイプおよびパーセンタイル別のホームページの画像リクエストの分布を示す棒グラフ。10パーセンタイルのデスクトップページは5枚の画像、モバイルは4枚、25パーセンタイルはデスクトップで9枚、モバイルで8枚、50パーセンタイルはデスクトップで18枚、モバイルで16枚、75パーセンタイルはデスクトップで33枚、モバイルで30枚、90パーセンタイルはデスクトップで60枚、モバイルで55枚の画像を読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1033192122&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-image-requests-by-page-type.png",
  caption="ページタイプ別の画像リクエストの分布。",
  description="デバイスタイプおよびパーセンタイル別の画像リクエストの分布を示す棒グラフ。10パーセンタイルのホームページは5枚の画像、内部ページは4枚、25パーセンタイルはホームページで10枚、内部ページで7枚、50パーセンタイルはホームページで20枚、内部ページで14枚、75パーセンタイルはホームページで36枚、内部ページで26枚、90パーセンタイルはホームページで65枚、内部ページで50枚の画像を読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=2009344757&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

2022年には、中央値のページでデスクトップ用に25枚、モバイルページ用に22枚の画像がリクエストされました。これはデスクトップで18枚、モバイルで16枚に減少しています。

画像ファイルタイプの減少は、ウェブが視覚的でなくなったことを意味するわけではありません。代わりに、サイトはCSS効果（<a hreflang="en" href="https://www.w3schools.com/css/css3_shadows.asp">シャドウ</a>や[グラデーション](https://developer.mozilla.org/ja/docs/Web/CSS/gradient)など）や[CSSアニメーション](https://web.dev/articles/animations-guide)に切り替えている可能性があります。これらのアセットは、解像度に依存しないアセットを生成するために使用でき、すべての解像度とズームレベルで常にシャープに見え、多くの場合、画像ファイルに必要なバイト数のほんの一部で済みます。

デスクトップページは一貫してより多くの画像ファイルタイプを要求し、デスクトップとモバイルの間のギャップはパーセンタイル全体で着実に一貫して拡大しています。ホームページと内部ページの差は比較すると顕著でした。デバイスタイプが比較的一貫した数値を示したのに対し、中央値のホームページは20枚の画像を呼び出したのに対し、内部ページはわずか14枚でした。

{{ figure_markup(
  caption="100パーセンタイルでデスクトップページで行われた画像リクエスト。",
  content="14,974",
  classes="big-number",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
)
}}

### CSS

CSS、またはカスケーディングスタイルシートは、HTMLのようなマークアップ言語で書かれたドキュメントのプレゼンテーションを記述するために使用されるスタイルシート言語です。言い換えれば、CSSはウェブページの視覚的なスタイリングとレイアウトを担当します。

開発者は、HTML要素の色、フォント、サイズ、間隔、その他多くの視覚的側面を制御できます。CSSはHTMLと連携して機能し、コンテンツとプレゼンテーションを分離します。

この分離により、ウェブページはより保守しやすく、柔軟で、応答性が高くなり、バイト数の多い画像アセットをCSS効果やアニメーションに置き換えることで、サイトのパフォーマンスを向上させるために使用できます。

{{ figure_markup(
  image="distribution-of-css-file-requests-by-device-type.png",
  caption="デバイスタイプ別のCSSファイルリクエストの分布。",
  description="デバイスタイプおよびパーセンタイル別のCSSファイルリクエストの分布を示す棒グラフ。10パーセンタイルのデスクトップページは2つのCSSファイル、モバイルも2つ、25パーセンタイルはデスクトップで4つのCSSファイル、モバイルも4つ、50パーセンタイルはデスクトップで8つのCSSファイル、モバイルで8つ、75パーセンタイルはデスクトップで16のCSSファイル、モバイルで15、90パーセンタイルはデスクトップで26のCSSファイル、モバイルで26を読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1092434902&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-css-file-requests-by-page-type.png",
  caption="ページタイプ別のCSSファイルリクエストの分布。",
  description="ページタイプおよびパーセンタイル別のCSSファイルリクエストの分布を示す棒グラフ。10パーセンタイルのホームページは1つのCSSファイル、内部ページは2つ、25パーセンタイルはホームページで3つのCSSファイル、内部ページで4つ、50パーセンタイルはホームページで7つのCSSファイル、内部ページで8つ、75パーセンタイルはホームページで15のCSSファイル、内部ページで16、90パーセンタイルはホームページで26のCSSファイル、内部ページで26を読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=451662692&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

CSSは、デバイスやページの種類を問わず、ウェブ開発者のツールキットに不可欠なツールです。中央値のデスクトップページとモバイルページはどちらも8つのCSSアセットを要求しました。パーセンタイルは、75番目の名目上の差異を除いて同一でした。

ホームページと内部ページを比較すると、90パーセンタイルまでホームページが一貫して1つ少ないカスケーディングスタイルシートを呼び出していることがわかりました。100パーセンタイルでは、内部ページが3,346件のリクエストに対して4,879件のリクエストで逸脱していることがわかりました。どちらも高いですが、内部ページは46%高くなっています。

### JavaScript

JavaScriptは、高水準で動的なインタプリタ型プログラミング言語です。ウェブのコアテクノロジーの1つであり、インタラクティブなウェブページやウェブアプリケーションを可能にします。JavaScriptを使用すると、開発者はウェブページにインタラクティビティ、アニメーション、エフェクトを追加できます。これには、ドロップダウンメニュー、画像スライダー、パーソナライズされたコンテンツ、分析トラッキングなどの機能が含まれます。

{{ figure_markup(
  caption="JavaScriptを使用しているモバイルホームページ。",
  content="97.8%",
  classes="big-number",
  sheets_gid="799485869",
  sql_file="pages_using_javascript.sql"
)
}}

すべてのモバイルホームページの97.8%、内部ページの98.5%でクライアントサイドのプログラミング言語として使用されています。

{{ figure_markup(
  image="javascript-request-distribution-by-device-type.png",
  caption="デバイスタイプ別のJavaScriptリクエストの分布。",
  description="デバイスタイプおよびパーセンタイル別のJavaScriptファイルリクエストの分布を示す棒グラフ。10パーセンタイルのデスクトップページは5つのJavaScriptファイル、モバイルは5つ、25パーセンタイルはデスクトップで12のJavaScriptファイル、モバイルで11、50パーセンタイルはデスクトップで24のJavaScriptファイル、モバイルで22、75パーセンタイルはデスクトップで43のJavaScriptファイル、モバイルで41、90パーセンタイルはデスクトップで12のJavaScriptファイル、モバイルで69を読み込みます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1888491876&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

2024年には、JavaScriptが画像を抜いて主要なファイルタイプになりました。中央値のページでは、デスクトップ用に24個、モバイルページ用に22個のJSファイルがリクエストされました。これは、2022年と比較してデスクトップで8%、モバイルで4.5%増加しています。JavaScriptのリクエスト数は、90パーセンタイルまで内部ページとホームページで一貫していました。

100パーセンタイルでは、デスクトップページとホームページがリクエスト数で対応するものから離れました。デスクトップページは33%多くのリクエストを行い、ホームページは31%多くなりました。デスクトップホームページは12,676のJavaScriptリソースをリクエストしました。コメントを求めてページに連絡を試みましたが、公開時点でリクエストはまだ読み込み中でした。

2024年にJavaScriptがどのように使用されているかについて詳しくは、[JavaScript](./javascript)の章をご覧ください。

### サードパーティサービス

サードパーティのリソースとは、ウェブページやアプリケーションに統合されているが、別のプロバイダーによってホストおよび維持されている外部のアセットやサービスのことです。これらのリソースには、JavaScript、CSS、フォント、分析ツールなどが含まれます。[サードパーティ](./third-parties)の章によると、[ページの92%に1つ以上のサードパーティリソースがありました](./third-parties#普及率)。もっとも多く呼び出されたサードパーティリソースはスクリプトで、コンテンツタイプ別のリクエストの30.5%を占めていました。著者らはまた、下位ランクのウェブサイトではサードパーティの数が大幅に減少していることにも言及しています。

詳細については、[サードパーティ](./third-parties)の章を参照してください。

### その他のアセット

ウェブページは、コード、スタイル、画像だけでなく、さまざまな他のアセットやリソースを利用できます。これらの追加アセットは、ウェブページの全体的な機能性、インタラクティビティ、視覚的な魅力に貢献し、HTML、CSS、JavaScriptと調和して完全なユーザーエクスペリエンスを作成します。

#### HTML

HTML、またはハイパーテキストマークアップ言語は、ウェブページを作成および構造化するために使用される標準のマークアップ言語です。見出し、段落、リスト、リンク、画像などの要素を定義し、ウェブサイトのコンテンツとレイアウトの基盤を提供します。HTMLは、一連のタグと属性を使用して、ウェブページのコンテンツのセマンティックな意味と視覚的なプレゼンテーションを記述します。

1つのウェブページに複数のHTMLリクエストが含まれる理由はいくつかあります。

1. **埋め込みリソース**: ウェブページは通常、HTMLドキュメントだけでなく、画像、CSSファイル、JavaScriptファイル、フォントなどの追加リソースも読み込みます。これらの外部リソースはそれぞれ、そのコンテンツを取得するためにサーバーへの個別のHTTPリクエストをトリガーします。
2. **動的に読み込まれるコンテンツ**: 一部のウェブページでは、JavaScriptを使用して、最初のページ読み込み後に追加のコンテンツやデータを動的に読み込みます。これには、無限スクロール、AJAXを利用したコンテンツの更新、要素の遅延読み込みなどが含まれます。これらの動的リクエストは、最初のHTMLドキュメントリクエストに加えて行われます。
3. **プリロード/プリフェッチ**: ウェブ開発者は、`rel="preload"`または`rel="prefetch"`を持つ`<link>`タグを含めて、ブラウザに特定のリソースを実際に必要になる前に事前に積極的に取得するように指示することがあります。これにより、知覚されるパフォーマンスが向上します。
4. **エラー処理**: リソースの読み込み中にネットワークエラーやサーバーの問題が発生した場合、ブラウザはリクエストを再試行し、同じコンテンツに対して複数のリクエストが発生します。

{{ figure_markup(
  image="html-requests-distribution-by-percentile.png",
  caption="パーセンタイル別のHTMLリクエストの分布。",
  description="デバイスタイプ別のHTMLリクエストの分布を示す棒グラフ。10および25パーセンタイルでは、モバイルとデスクトップは1つのリクエストを行いました。中央値のページは、両方のデバイスで2つのHTMLリクエストを行いました。75パーセンタイルでは、デスクトップは6つ、モバイルは7つでした。90パーセンタイルでは、両方とも12のHTMLリクエストを行いました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=594681881&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

中央値のページは2つのHTMLリクエストを行い、これはデバイスやページの種類を問わず一貫していました。90パーセンタイルでは、12のHTMLリクエストが見られました。100パーセンタイルでは、デスクトップのホームページが13,389件のリクエストを行い、その数は劇的に急増しました。

#### フォント

{{ figure_markup(
  image="font-requests-distribution-by-percentile.png",
  caption="パーセンタイル別のフォントリクエストの分布。",
  description="デバイスタイプ別のフォントファイルリクエストの分布を示す棒グラフ。10パーセンタイルでは、モバイルとデスクトップでフォントファイルはリクエストされませんでした。25パーセンタイルでは、デスクトップは2つ、モバイルは1つのリクエストを行いました。中央値のページは、デスクトップで4つ、モバイルで3つのフォントファイルリクエストを行いました。75パーセンタイルでは、デスクトップは7つ、モバイルは6つでした。90パーセンタイルでは、デスクトップは11、モバイルは9つのフォントファイルリクエストを行いました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=378448165&format=interactive",
  sheets_gid="556601917",
  sql_file="request_type_distribution.sql"
  )
}}

中央値のページは4つのフォントファイルを要求しました。90パーセンタイルまで、フォントリクエストはデバイスやページの種類を問わずかなり低く、一貫していました。100パーセンタイルでは、デスクトップのホームページが3,038個のフォントを要求していることがわかりました。この量のフォントリクエストから、このサイトはフォントリポジトリまたは身代金要求ジェネレーターであると推測されます。

### リクエストバイト

中央値のページの重さを経時的に比較すると、残念ながらほぼ同じペースで増加し続けていることがわかります。中央値のページの重さは、経時的な比較で示されるように、依然としてほぼ同じペースで増加しています。

{{ figure_markup(
  image="median-page-weight-over-time.png",
  caption="経時的な中央値ページの重さ。",
  description="経時的な中央値ページの重さを示す折れ線グラフ。グラフは、2014年10月のデスクトップ1,208 KB、モバイル505 KBから、2024年10月のデスクトップ2,652 KB、モバイル2,311 KBへと、時間の経過とともにページの重さが増加していることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1318848334&format=interactive",
  sheets_gid="1332718864",
  sql_file="page_weight_trend.sql"
  )
}}

2024年10月に測定されたデスクトップページの中央値のページの重さは2,652 KBで、モバイルはそれよりわずかに低いものの、依然として重い2,311 KBです。

2022年の章と比較すると、両方の数値は高く、中央値のデスクトップページは2,312 KB、モバイルは2,037 KBでした。2024年のモバイルページは、2022年のデスクトップページよりわずか1 KB軽いです。2024年10月、デスクトップページの中央値のページの重さは2,652 KBでしたが、モバイルページの中央値のページの重さは2,311 KBでした。

これらの数値はどちらも2022年のものより高くなっています。2022年、デスクトップページの中央値のページの重さは2,312 KB、モバイルページの中央値のページの重さは2,037 KBでした。注目すべきは、2024年のモバイルページの重さは2022年のデスクトップページの重さよりわずか1 KB軽いだけであることです。

{{ figure_markup(
  caption="過去10年間で中央値のモバイルページの重さがどれだけ増加したか。",
  content="1.8 MB",
  classes="big-number",
  sheets_gid="1332718864",
  sql_file="page_weight_trend.sql"
)
}}

前年比で比較すると、2023年10月から2024年10月にかけて、デスクトップは8.6%（210 KB）、モバイルは6.4%（140 KB）増加しました。

中央値のデスクトップページは過去10年間で120%、つまり1.4 MB増加しました。中央値のモバイルページは同期間で357%、つまり1.8 MBというより大幅な増加を遂げています。これは、モバイルページに3.5インチフロッピーディスク1枚分以上のデータを追加することに相当します。

前年比では、2023年10月から2024年10月にかけて、デスクトップは8.6%（210 KB）、モバイルは6.4%（140 KB）増加しました。

ウェブデータの最終的なユーザーへのコストを計算するためのウェブベースのツールである<a hreflang="en" href="https://whatdoesmysitecost.com/#usdCost">What Does My Site Cost?</a>によると、中央値のデスクトップページはユーザーに最大0.32米ドルの費用がかかる可能性があり、一部の地域では国民総所得の最大1.7%に達する可能性があります。

#### コンテンツタイプとファイル形式

{{ figure_markup(
  image="median-homepage-weight-by-content-and-device-type.png",
  caption="コンテンツタイプおよびデバイスタイプ別の中央値ホームページの重さ。",
  description="リソースのタイプ別の中央値ページの重さを示す棒グラフ。中央値のデスクトップページは、HTML 18 KB、CSS 78 KB、フォント 131 KB、JavaScript 613 KB、画像 1,054 KBを読み込みます。モバイルホームページの場合は、18 KB、73 KB、111 KB、558 KB、900 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1854561083&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

動画を除き、ホームページの主要なリソースタイプは画像です。画像を使用する中央値のデスクトップページは1,054 KBを要求し、モバイルページは900 KBを要求します。これは、デスクトップページが1,026 KB、モバイルページが900 KBを要求した2022年からわずかに増加しています。

JavaScriptはページの重さに2番目に大きく貢献しており、中央値のデスクトップページは613 KB、モバイルページは558 KBを提供しています。画像と同様に、これらは両方とも2022年の章からの成長を表しており、デスクトップページでは509 KB、モバイルページでは461 KBでした。

{{ figure_markup(
  image="median-desktop-page-weight-by-page-and-content-type.png",
  caption="ページおよびコンテンツタイプ別の中央値デスクトップページの重さ。",
  description="ページタイプおよびコンテンツタイプ別のリソースの中央値ページの重さを示す棒グラフ。中央値のデスクトップホームページは、HTML 18 KB、CSS 78 KB、フォント 131 KB、JavaScript 613 KB、画像 1,054 KBを読み込みます。デスクトップの内部ページの場合は、18 KB、73 KB、131 KB、627 KB、442 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1972138072&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="median-mobile-page-weight-by-page-and-content-type.png",
  caption="ページおよびコンテンツタイプ別の中央値モバイルページの重さ。",
  description="ページタイプおよびコンテンツタイプ別のリソースの中央値ページの重さを示す棒グラフ。中央値のモバイルホームページは、HTML 18 KB、CSS 73 KB、フォント 111 KB、JavaScript 558 KB、画像 900 KBを読み込みます。モバイルの内部ページの場合は、17 KB、77 KB、108 KB、582 KB、348 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=941541885&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

モバイルページとデスクトップページの両方で、内部ページは画像のバイト数が少なく、JavaScriptのバイト数がわずかに多い傾向があります。

この新しい分析はまた、以前考えられていたように、画像が常にページの重さの最大の構成要素であるとは限らないこと、そして内部ページではJavaScriptがその疑わしい名誉を代わりに得たことを示しています。

{{ figure_markup(
  image="distribution-of-response-sizes-by-content-type.png",
  caption="コンテンツタイプ別の応答サイズの分布。",
  description="デスクトップページのタイプ別リソースサイズの分布の箱ひげ図。動画は群を抜いて最大のリソースタイプであり、90パーセンタイルで8,614 KBに達します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=124632855&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

画像は全体としてページの重さに最大の貢献者かもしれませんが、リクエストごとのサイズを見ると、動画が先頭に立ち、次にフォント、そして[WebAssembly (wasm)](https://web.dev/explore/webassembly)ファイル（2022年には検出されなかった）が続きます。2022年の分析では、音声が2番目に重かったですが、今年は画像の背後に4番目に後退しました。

#### JavaScriptバイト

JavaScriptファイルの重さの増加は、パフォーマンスにさらなるペナルティをもたらします。純粋なサイズが考慮されるだけでなく、ブラウザはJavaScriptを解析して実行する必要があり、これはとくにローエンドのデバイスではコストのかかるプロセスになる可能性があります。

{{ figure_markup(
  image="distribution-of-javascript-response-sizes-by-device-type.png",
  caption="デバイスタイプ別のJavaScript応答サイズの分布。",
  description="デバイスタイプ別のJavaScriptリソースサイズの分布の棒グラフ（ホームページと内部ページ全体）。10パーセンタイルでは、デスクトップで101 KB、モバイルで89 KB、25パーセンタイルでは、デスクトップで270 KB、モバイルで244 KB、50パーセンタイルでは、デスクトップURLで620 KB、モバイルURLで570 KB、75パーセンタイルでは、デスクトップで1,172 KB、モバイルで1,103 KB、90パーセンタイルでは、デスクトップで1,834 KB、モバイルで1,732 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1609680901&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

デスクトップページはモバイルページよりも多くのJavaScriptバイトを要求する傾向がありますが、中央値のデスクトップページは620 KBのJavaScriptを要求し、モバイルページは570 KBで、その差は大きくありません。

Alex Russellの<a hreflang="en" href="https://infrequently.org/2024/01/performance-inequality-gap-2024/">パフォーマンスの不平等ギャップ、2024年</a>の調査によると、これらはしかし、75パーセンタイルで3秒未満のページ読み込みという提案された目標である365 KBをはるかに上回っています。

75パーセンタイルでは、モバイルとデスクトップの両方が、5秒の読み込み時間を達成するための提案された650 KBの予算をはるかに超えており、それはJavaScriptの多いページであり、マークアップがそれに応じて小さいと仮定した場合です。

{{ figure_markup(
  image="distribution-of-js-response-sizes-by-page-type.png",
  caption="ページタイプ別のJavaScript応答サイズの分布。",
  description="ページタイプ別のJavaScriptリソースサイズの分布の棒グラフ（デバイスタイプ全体）。10パーセンタイルでは、ホームページで86 KB、内部ページで104 KB、25パーセンタイルでは、ホームページで248 KB、内部ページで267 KB、50パーセンタイルでは、ホームページURLで585 KB、内部ページURLで604 KB、75パーセンタイルでは、ホームページで1,151 KB、内部ページで1,120 KB、90パーセンタイルでは、ホームページで1,1822 KB、内部ページで1,744 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=989064677&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

ホームページと内部ページのJavaScriptファイルの応答サイズには大きな違いはありません。内部ページは50パーセンタイルまで少し多くのJavaScriptを持っていますが、それ以上ではホームページの方が多くなる傾向があります。

これは、開発者がすべてのページですべて、またはほとんどのJavaScriptリソースを読み込んでいる機会があることを示している可能性があり、[ツリーシェイキング](https://wikipedia.org/wiki/Tree_shaking)によって全体的に必要なJavaScriptを削減する機会を表しています。これは、JavaScriptファイルをより具体的なものに分割し、必要なときにのみ読み込む方法であり、したがってダウンロードされる無駄なJavaScriptバイトを削減します。

#### CSSバイト

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-device-type.png",
  caption="デバイスタイプ別のCSS応答サイズの分布。",
  description="デバイスタイプ別のCSSリソースサイズの分布の棒グラフ（ホームページと内部ページ全体）。10パーセンタイルでは、デスクトップで10 KB、モバイルで8 KB、25パーセンタイルでは、デスクトップで36 KB、モバイルで32 KB、50パーセンタイルでは、デスクトップURLで80 KB、モバイルURLで75 KB、75パーセンタイルでは、デスクトップで152 KB、モバイルで146 KB、90パーセンタイルでは、デスクトップで269 KB、モバイルで260 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=724413424&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-css-response-sizes-by-page-type.png",
  caption="ページタイプ別のCSS応答サイズの分布。",
  description="ページタイプ別のCSSリソースサイズの分布の棒グラフ（モバイルおよびデスクトップデバイス全体）。10パーセンタイルでは、ホームページで7 KB、内部ページで11 KB、25パーセンタイルでは、ホームページで32 KB、内部ページで36 KB、50パーセンタイルでは、ホームページで76 KB、内部ページで79 KB、75パーセンタイルでは、ホームページと内部ページで149 KB、90パーセンタイルでは、ホームページで266 KB、内部ページで263 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=928222763&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

CSSのサイズは、すべてのパーセンタイルでデスクトップの方がモバイルよりもわずかに大きく、ホームページと内部ページの間にはほとんど差がありませんでした。

これは、一般的に採用されている方法が、すべてのデバイスとページタイプに対して1セットのCSSであることを示しています。これは、上記のJavaScriptと同様に、ツリーシェイキングによって全体的に必要なCSSを削減する機会を逃している可能性を指摘していますが、CSSではキャッシュとビルドツールの機能をバランスさせるという、常により微妙な問題があります。

全体として、76KBのCSSファイルは、期待するよりも少し大きいように見えますが、過度に大きいわけではありません。しかし、CSSファイルの最適なサイズは、可能な限り小さいものであることを覚えておいてください。うまくいけば、人々がそれをすべてヘッドにインラインで詰め込んでいるわけではないことを願っています。

#### 画像バイト

過去のページの重さの章では、画像は常に全体のページの重さに最大の貢献者でしたが、2024年の新しい内部ページのデータは、それがホームページに特有の傾向であることを示していますが、それでも全体として大きな構成要素を表しています。

{{ figure_markup(
  image="distribution-of-image-response-sizes-by-device-type.png",
  caption="デバイスタイプ別の画像応答サイズの分布",
  description="デバイスタイプ別の画像リソースサイズの分布の棒グラフ。10パーセンタイルでは、デスクトップで84 KB、モバイルで62 KB、25パーセンタイルでは、デスクトップで322 KB、モバイルで263 KB、50パーセンタイルでは、デスクトップで1,054 KB、モバイルで900 KB、75パーセンタイルでは、デスクトップで2,822 KB、モバイルで2,517 KB、90パーセンタイルでは、デスクトップで6,526 KB、モバイルで5,905 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1690867892&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

中央値のデスクトップホームページは1,054 KBの画像を読み込んでおり、モバイルは少し軽い900 KBです。前述のとおり、これは2022年のデスクトップページが1,026 KB、モバイルが900 KBだったのに比べて依然として増加しています。75パーセンタイルに達すると、事態はすぐに膨れ上がり、デスクトップでは2,822 KB、モバイルでは2,517 KBの画像になります。

実際、中央値以上では、すべてのパーセンタイルが[2022年の章よりも大きかった](../2022/page-weight#画像バイト)ですが、より肯定的な発見は、10番目と25番目では、画像のバイト数が前の章からほぼ安定しているか減少していることであり、これはすでに画像ファイルサイズの最適化を行っていた開発者がそれを継続しており、少しずつ上手になっている可能性があることを示しています。

また、開発者がページの重さへの影響を減らすことにもっとも集中しているように見えるのが、ページの重さがもっとも高いペナルティを伴う可能性があるモバイルユーザー向けであることも喜ばしいことです。これは、人々が[レスポンシブ画像](https://web.dev/articles/serve-responsive-images)配信を使用しているためかもしれません。

{{ figure_markup(
  image="distribution-of-desktop-image-response-sizes-by-page-type.png",
  caption="ページタイプ別のデスクトップ画像応答サイズの分布",
  description="デスクトップクライアント上のページタイプ別の画像リソースサイズの分布の棒グラフ。10パーセンタイルでは、ホームページで84 KB、内部ページで36 KB、25パーセンタイルでは、ホームページで342 KB、内部ページで142 KB、50パーセンタイルでは、ホームページで1,054 KB、内部ページで442 KB、75パーセンタイルでは、ホームページで2,8722 KB、内部ページで1,253 KB、90パーセンタイルでは、ホームページで6,526 KB、内部ページで3,295 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=2019094499&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-mobile-image-response-sizes-by-page-type.png",
  caption="ページタイプ別のモバイル画像応答サイズの分布。",
  description="デスクトップクライアント上のページタイプ別の画像リソースサイズの分布の棒グラフ。10パーセンタイルでは、ホームページで62 KB、内部ページで24 KB、25パーセンタイルでは、ホームページで263 KB、内部ページで97 KB、50パーセンタイルでは、ホームページで900 KB、内部ページで348 KB、75パーセンタイルでは、ホームページで2,517 KB、内部ページで1,098 KB、90パーセンタイルでは、ホームページで5,905 KB、内部ページで2,986 KBです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1851191068&format=interactive",
  sheets_gid="526470628",
  sql_file="bytes_per_type.sql"
  )
}}

ホームページと内部ページを見ると、デスクトップとモバイルの両方でホームページの方が画像バイト数が多いという明確な傾向があり、中央値のデスクトップページはホームページで1,054 KB、内部ページで442 KB、モバイルではホームページで900 KB、内部ページで348 KBです。デスクトップとモバイルの両方で、中央値の内部ページはホームページの半分の画像バイト数しかありません。

{{ figure_markup(
  image="distribution-of-desktop-image-sizes-by-format.png",
  caption="フォーマット別のデスクトップ画像サイズの分布。",
  description="デスクトップ画像のサイズ別の分布を示す箱ひげ図。JPGが群を抜いて最大のフォーマットであり、90パーセンタイルで274 KB、次にPNGが196 KB、WebPが116 KB、AVIFが45 KBと続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=226775276&format=interactive",
  sheets_gid="397148495",
  sql_file="../media/media_formats.sql"
  )
}}

{{ figure_markup(
  image="distribution-of-mobile-image-sizes-by-format.png",
  caption="フォーマット別のモバイル画像サイズの分布。",
  description="デスクトップ画像のサイズ別の分布を示す箱ひげ図。JPGが群を抜いて最大のフォーマットであり、90パーセンタイルで266 KB、次にPNGが207 KB、WebPが107 KB、AVIFが46 KBと続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=226775276&format=interactive",
  sheets_gid="397148495",
  sql_file="../media/media_formats.sql"
  )
}}

JPG、WebP、PNGファイル形式は、2022年の画像の重さのトップソースとしての地位を維持しています。ウェブでの画像形式の使用に関する詳細については、[メディア](./media)の章をご覧ください。

#### 動画バイト

動画には多くのデータが含まれており、動画の1秒ごとに多くの画像、つまりフレーム、そして多くの場合音声も含まれています。そのため、ページの重さを大幅に増加させる可能性があります。

最新のフォーマットはこれを圧縮して縮小するのに役立ちますが、ある時点でファイルサイズと品質の間にトレードオフが生じます。

そのトレードオフを正しく行い、[動画やその他の埋め込み用のファサード](#動画やその他の埋め込み用のファサード)などの他のテクニックと組み合わせることで、影響を可能な限り減らすことができます。

{{ figure_markup(
  image="distribution-of-video-response-sizes-by-device-type.png",
  caption="デバイスタイプ別の動画応答サイズの分布。",
  description="デスクトップおよびモバイル上の動画リソースサイズの分布の棒グラフ。デスクトップでは、10パーセンタイルで3 KB、25パーセンタイルで34 KB、中央値で194 KB、75パーセンタイルで875 KB、90パーセンタイルで2,835 KBです。モバイルでは、それぞれ3 KB、43 KB、299 KB、1,169 KB、3,432 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=898316028&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

中央値のページは、デスクトップユーザー向けに194 KBの動画を要求し、驚くべきことにモバイルユーザー向けにはより大きな299 KBを要求します。実際、その傾向は25パーセンタイル以降に存在しており、これはモバイルデバイスがページの重さの削減からもっとも恩恵を受ける可能性が高いことを考えると、残念な傾向です。

{{ figure_markup(
  image="desktop-video-response-size-distribution-by-page-type.png",
  caption="ページタイプ別のデスクトップ動画応答サイズの分布。",
  description="ホームページおよび内部ページ上のデスクトップ動画リソースサイズの分布の棒グラフ。ホームページでは、10パーセンタイルで5 KB、25パーセンタイルで44 KB、中央値で243 KB、75パーセンタイルで1,257 KB、90パーセンタイルで3,910 KBです。内部ページでは、それぞれ1 KB、24 KB、144 KB、493 KB、1,760 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1089264171&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

{{ figure_markup(
  image="mobile-video-response-size-distribution-by-page-type.png",
  caption="ページタイプ別のモバイル動画応答サイズの分布。",
  description="ホームページおよび内部ページ上のモバイル動画リソースサイズの分布の棒グラフ。ホームページでは、10パーセンタイルで5 KB、25パーセンタイルで62 KB、中央値で410 KB、75パーセンタイルで1,563 KB、90パーセンタイルで4,704 KBです。内部ページでは、それぞれ1 KB、24 KB、188 KB、775 KB、2,159 KBでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=847216939&format=interactive",
  sheets_gid="1755654802",
  sql_file="response_type_distribution.sql"
  )
}}

ホームページは内部ページよりも動画リソースのペイロードが大きいことがわかり、中央値のホームページはデスクトップで243 KB、モバイルデバイスで410 KBの動画リソースを要求しています。内部ページはデスクトップで144 KB、モバイルデバイスで188 KBと低くなっています。

これは、開発者がサイトやビジネス全体に焦点を当てる傾向があるホームページに動画の「ヒーロー」セクションを使用したり、そうでなければ動画を埋め込んだりすることを好むことを示している可能性があります。一方、内部ページは、おそらくカテゴリやリスティングページ、個々の記事や製品など、より焦点を絞ったページである可能性が高いです。

## バイト節約技術の採用率

ページの重さを減らすためにできることはいくつかあります。最初の1つは、テクノロジーというよりはアプローチであり、表面的には非常に単純です。必要のないものを送らないでください。

これは、ページに追加するもの、出荷するものに注意を払うべきであることを意味します。要するに、追加しているものがページのユーザーとページが満たす必要のあるビジネスケースに本当に価値を付加しているかどうかを確認する必要があります。

しかし、目的はすべての機能を削除することではなく、むしろ、追加しているものが価値を付加していることを確認することです。

貴重なコンテンツをより効率的な方法で配信するのに役立つこれらのパターンとアプローチのいくつか、そしてそれらがどのくらいの頻度で実装されているかを見てみましょう。

### 動画やその他の埋め込み用のファサード

動画、ソーシャルメディアの投稿、その他のインタラクティブな埋め込みなどのサードパーティの埋め込みは、ページの重さを大幅に増加させる可能性があります。動画や投稿の共有ボタンをクリックして、コードをページに貼り付けるのは簡単ですが、それに伴う巨大なペイロードに完全に気づいていない場合があります。

動画にはかなりのバイト数があると予想されるかもしれませんが、ライブチャットウィジェットの埋め込みや、ツイートのようなソーシャルメディアの投稿でさえ、かなりのオーバーヘッドを伴う可能性があり、いいねボタンをクリックしたり再共有したりするなどのインタラクティビティを有効にするために驚くほどの量のJavaScriptを読み込みます。

良い妥協案となりうる1つのデザインパターンは、<a hreflang="en" href="https://www.patterns.dev/vanilla/import-on-interaction/">インタラクション時のインポート</a>としても知られるファサードを使用することです。この基本的な原則は、埋め込みのグラフィカルまたは単純な非インタラクティブな表現を使用し、ユーザーがそれをクリックした場合にインタラクティブな完全な埋め込みになるというものです。

動画の場合、それは多くの場合ポスター画像を表示し、クリックすると完全な埋め込みが読み込まれます。ソーシャルメディアの投稿の場合、スタイル設定されたHTML、または動画ソリューションのように、ユーザーが投稿をクリックすると完全なインタラクティビティが読み込まれる画像のいずれかになります。

最終的に、ユーザーが対話すると、より大きなペイロードを読み込む必要がありますが、多くのユーザーが対話したり、動画を視聴したり、カスタマーサービスや営業とライブチャットを開始したりしたくない場合に節約が生まれます。そのコストを支払うユーザーは、積極的に機能を使用したいユーザーです。

ファサードの使用にはいくつかの欠点があります。これらは、[web.devのサードパーティファサードの記事](https://developer.chrome.com/docs/lighthouse/performance/third-party-facades#live_chat_intercom_drift_help_scout_facebook_messenger)で詳しく説明されています。しかし、最終的に、このアプローチは全体のページの重さを大幅に節約するのに役立ちます。

ファサードの採用状況を調べるには、Lighthouseに目を向けることができます。Lighthouseは、[ファサードを使用してサードパーティのリソースを遅延読み込みする](https://developer.chrome.com/docs/lighthouse/performance/third-party-facades)監査を提供しており、ページに埋め込まれている特定可能なリソースの中に、ファサードを使用する機会があるかどうかを確認できます。

採用を判断することは、全体として困難です。なぜなら、ファサードを実装しているサイトを確実にテストすることはできないからです。解決策には、ページが探しているリソースを読み込まなくなることが含まれるため、潜在的に利益を得られる可能性のあるサイトを見ることの方が有意義です。

{{ figure_markup(
  image="sites-that-could-implement-third-party-facades.png",
  caption="サードパーティのファサードを実装できるサイト。",
  description="サードパーティのファサードから恩恵を受ける可能性のあるサイトの割合を示す棒グラフ。デスクトップホームページの70%、デスクトップ内部ページの65%、モバイルホームページの45%、モバイル内部ページの46%が、Lighthouseの測定によると、サードパーティのファサードから恩恵を受ける可能性があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=758898069&format=interactive",
  sheets_gid="632010634",
  sql_file="facades-usage.sql"
  )
}}

デスクトップホームページの70%が、一部の埋め込みをファサードに置き換える機会があると検出されました。デスクトップの内部ページでは65%でした。モバイルクロールでは、状況はここでより良く、モバイルホームページの45%、モバイル内部ページの46%が潜在的に恩恵を受ける可能性があります。

データから、モバイルクライアントに提供されるページでの採用率が高いか、開発者やパブリッシャーがモバイルユーザー向けのサードパーティ埋め込みの種類を省略しているかのどちらかであるように思われます。

ファサードは2022年の前回のアルマナックページの重さの章で取り上げられましたが、テストは過去2年間でわずかに変更され、データを分析するために使用した方法論も変更されたため、直接比較はできません。

### 圧縮

圧縮を使用すると、リソースをネットワーク経由で要求元のクライアントに送信する前にサイズを縮小できます。クライアントでは、ウェブページの場合は通常ブラウザですが、使用前に解凍されます。理論上、そして通常は実際には、ペイロードが小さいほどページの読み込みが速くなります。

HTML、CSS、JavaScript、JSON、SVG、ico、ttfフォントファイルなどのテキストベースのファイルの場合、HTTP圧縮は送信されるページの重さを減らす強力な味方です。GZIPまたはBrotli圧縮を使用すると、テキストベースのリソースのサイズを大幅に削減できる場合があります。画像や動画などの他のファイルタイプは、すでに圧縮されているため、HTTP圧縮の恩恵を受けません。

{{ figure_markup(
  image="proper-text-compression-usage.png",
  caption="適切なテキスト圧縮の使用法。",
  description="正しいテキスト圧縮を使用しているサイトの割合を示す棒グラフ。デスクトップホームページの70%、デスクトップ内部ページの71%、モバイルホームページの71%、モバイル内部ページの72%が、Lighthouseの測定によると、テキストベースのリソースを正しく圧縮しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1267287467&format=interactive",
  sheets_gid="803366125",
  sql_file="compression-usage.sql"
  )
}}

デスクトップホームページの70%、および基本的に同様の71%の内部ページがテキスト圧縮を正しく使用していることを検出しました。ホームページの数値は、2022年の74%からの低下を表しています。

モバイルクロールでは、ホームページの71%と内部ページの72%がテキスト圧縮を正しく使用していました。ホームページを2022年と比較すると、これも73%からの低下を表しています。

使用率の低下は、おそらく小さいものの、残念です。圧縮を有効にすることが難しくなったわけではなく、おそらく簡単になりました。とくにCloudflareのようなCDNを使用している場合は、ダッシュボードでスイッチを切り替えるだけで済みます。

圧縮は完全に魔法ではなく、クライアントにとってこれらのリソースのページの重さの影響を完全になくすわけではないことに注意してください。最終的には、使用前に再度解凍する必要があります。

また、完全に無料のプロセスでもありません。サーバーでこれらのリソースを圧縮するには作業が必要であり、可能な場合は圧縮されたリソースをキャッシュすることで多少軽減できます。また、クライアントでそれらを解凍するにも作業が必要です。

しかし、トレードオフとして、通常は行う価値があります。圧縮技術は一般的に十分に最適化されており効率的であり、主要なボトルネックはネットワークです。

### 最小化

最小化は、スペース、リターン、コードコメントなど、ブラウザがリソースを使用するために必要のない[不要な文字を削除する](https://developer.mozilla.org/ja/docs/Glossary/Minification)ことで、リソースの全体的なサイズを縮小できます。

圧縮とは異なり、クライアント側で追加の作業を行う必要はなく、リソースを解凍する必要はありません。リソースがオンザフライで最小化される場合、サーバー側で多少のオーバーヘッドと作業が発生する可能性がありますが、多くの場合、CSSリソースを事前に最小化するのが最善です。それらは本質的に静的である可能性が高く、多くの場合、ビルド時に実行できます。

{{ figure_markup(
  image="minified-css-proper-usage.png",
  caption="最小化されたCSSの適切な使用法。",
  description="CSSリソースを正しく最小化しているサイトの割合を示す棒グラフ。デスクトップホームページと内部ページの62%、モバイルホームページの63%、モバイル内部ページの62%が、Lighthouseの測定によると、CSSを正しく最小化しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=389006381&format=interactive",
  sheets_gid="1779746551",
  sql_file="minified_css_usage.sql"
  )
}}

2024年には、ホームページの62%がCSSを正しく最小化しており、Lighthouseによって検出されました。これは、2022年の84%から大幅に低下しています。モバイルホームページでは63%で、2022年の68%から低下し、内部ページはわずかに低い62%でした。

{{ figure_markup(
  image="minified-javascript-proper-usage.png",
  caption="最小化されたJavaScriptの適切な使用法。",
  description="JavaScriptリソースを正しく最小化しているサイトの割合を示す棒グラフ。デスクトップホームページの58%、内部ページの57%、モバイルホームページの59%、モバイル内部ページの58%が、Lighthouseの測定によると、JavaScriptを正しく圧縮しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=241357742&format=interactive",
  sheets_gid="695301697",
  sql_file="minified_js_usage.sql"
  )
}}

2024年には、デスクトップホームページの58%がJavaScriptを正しく最小化しており、Lighthouseによって検出されました。これは、2022年の77%から大幅に低下しています。内部ページはわずかに悪く、57%でした。モバイルでは、ホームページの59%がこのテストに合格し、2022年の64%から低下しました。デスクトップと同様に、内部ページはわずかに悪く、58%でした。

このテストに合格するサイトの方が多いことは依然として心強いですが、2024年にはCSSとJavascriptの両方の最小化が2022年よりも普及していないことは非常に残念です。

### キャッシュとCDN

キャッシュとCDNの使用は、ユーザーへのリソース配信に必要な時間を最小限に抑えることでページの読み込み時間を短縮するのに役立つため、ページの重さを管理する上で役割を果たします。ただし、CDNはページの重さを減らすわけではないことに言及する価値があります。

リソースには、静的および動的の両方、ならびにパーソナライゼーション、サードパーティの統合、エッジコンピューティングが含まれます。

一方では、サーバーとブラウザの両方で使用されるキャッシュにより、リソースを再利用できます。キャッシュされたコンテンツは、地理的に分散された一連の相互接続されたサーバーであるCDNを介して送信され、リソースを要求するサーバーと提供されるリソースの間の距離を短縮します。これは、国際的なウェブサイトにとってとくに重要です。

CDNに関する詳細については、[CDN](./cdn)の章を参照してください。

## ページの重さとCore Web Vitals

[Core Web Vitals](https://web.dev/intl/ja/articles/vitals)は、「パフォーマンス」という危険なほど曖昧な定義を人間中心の測定に洗練させるために設計された一連のパフォーマンスメトリックです。「良い」ページであるためには、ページはユーザーにとって重要な瞬間を測定する3つの評価に合格する必要があります。

1. 読み込み中ですか？ ([Largest Content Paint (LCP)](https://web.dev/intl/ja/articles/lcp))
2. ユーザーは対話できますか？ ([Interaction to Next Paint (INP)](https://web.dev/intl/ja/articles/inp))
3. 視覚的に安定していますか？ ([Cumulative Layout Shift (CLS)](https://web.dev/intl/ja/articles/cls))

Core Web Vitalsは、進化する一連のメトリックとして設計されています。今年、[インタラクティビティのメトリックが](https://developers.google.com/search/blog/2023/05/introducing-inp)First Input Delay (FID) からInteraction to Next Paint (INP) に変更されました。この変更は、2つの重要な進歩をもたらしたためです。

- 1つ目は、単一のインタラクションからページのすべてのインタラクションを含むようにシフトすることです。言い換えれば、マウスでのクリック、タッチスクリーン付きデバイスでのタップ、物理キーボードまたは画面キーボードでのキーの押下です。
- 2つ目は、JavaScriptが主にインタラクティビティを駆動することが多いため、JavaScriptフレームワークを使用するサイトのインタラクティビティを正確に表現することです。

INPで測定された応答性が200ミリ秒未満の場合、それは良い体験と見なされ、INPパフォーマンス評価に合格します。Total Blocking Timeはラボデータの同等物として残り、INPの問題が検出された場合の診断用です。

2023年3月の切り替えでは、多くのJavaScriptフレームワークのオリジンが「良い」分類に合格しなくなりました。React、Next、Nuxt、Vueなどの著名なフレームワークを使用するサイトがもっとも大きな打撃を受けました。サイトは迅速に適応し、2024年9月までに、INPで評価された場合の合格オリジンの数は、FIDメトリックが使用された場合の数を上回りました。

データを収集するために、LCPとCLSをキャプチャするが、INPまたはFIDのインタラクションベースのメトリックはキャプチャしない、Lighthouseのラボテスト監査に頼らなければなりませんでした。ラボテストには欠点があり、web.devの[ラボデータとフィールドデータが異なる理由（およびそれについて何をするか）](https://web.dev/intl/ja/articles/lab-and-field-data-differences)で詳述されているように、パフォーマンスを真に評価するには常に実際のユーザーメトリックを使用する必要があります。

2024年6月のデータを使用しました。各パーセンタイルとデバイスタイプのページの重さは次のとおりです。

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>デスクトップページの重さ</th>
        <th>モバイルページの重さ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10番目</td>
        <td class="numeric">549 KB</td>
        <td class="numeric">471 KB</td>
      </tr>
      <tr>
        <td>25番目</td>
        <td class="numeric">1,138 KB</td>
        <td class="numeric">995 KB</td>
      </tr>
      <tr>
        <td>50番目</td>
        <td class="numeric">2,157 KB</td>
        <td class="numeric">1,938 KB</td>
      </tr>
      <tr>
        <td>75番目</td>
        <td class="numeric">4,169 KB</td>
        <td class="numeric">3,766 KB</td>
      </tr>
      <tr>
        <td>90番目</td>
        <td class="numeric">8,375 KB</td>
        <td class="numeric">7,680 KB</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Lighthouseテストによるデバイスごとのパーセンタイルページの重さ。",
      sheets_gid="2030864989",
      sql_file="cwv_trend.sql",
    ) }}
  </figcaption>
</figure>

### Largest Contentful Paint (LCP)

[Largest Contentful Paint](https://web.dev/intl/ja/articles/lcp#what-is-a-good-lcp-score)の良いスコアは2.5秒以下です。4秒を超えるLCPは不良と見なされます。

{{ figure_markup(
  image="lcp-distribution-by-page-weight.png",
  caption="デバイスタイプとページの重さによるLCPスコアの分布",
  description="パーセンタイル別のLCPスコアの分布の縦棒グラフ。デスクトップでは、10パーセンタイルで1.1秒、25パーセンタイルで1.6秒、中央値で12.5秒、75パーセンタイルで3.9秒、90パーセンタイルで6.4秒です。モバイルでは、それぞれ2.7秒、3/9秒、6秒、10.5秒、18秒でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=73621248&format=interactive",
  sheets_gid="2030864989",
  sql_file="cwv_trend.sql"
  )
}}

ページの重さとLargest Contentful Paintの間には明確な相関関係があり、ページの重さが高いほど、LCPまでの時間が長くなります。これは、はるかに急な曲線を持つモバイルデバイスにとくに当てはまります。

### Cumulative Layout Shift (CLS)

[Cumulative Layout Shift](https://web.dev/intl/ja/articles/cls#what-is-a-good-cls-score)の良いスコアは0.1以下です。0.25を超えるCLSは不良と見なされます。この特定のメトリックを見るときに留意すべき点の1つは、CLSがページの全期間にわたって効果的に測定されるため、ラボデータとフィールドデータの違いにくに影響を受けることです。これには、インタラクションやスクロールが含まれますが、ラボテストでは最初の読み込みしかキャプチャできません。

{{ figure_markup(
  image="cls-distribution-by-page-weight.png",
  caption="デバイスタイプとページの重さによるCLSスコアの分布。",
  description="パーセンタイル別のCLSスコアの分布の縦棒グラフ。デスクトップでは、10パーセンタイルで0、25パーセンタイルで0、中央値で0.01、75パーセンタイルで0.06、90パーセンタイルで0.23秒です。モバイルでは、それぞれ0、0、0.02、0.11、0.31でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=822364055&format=interactive",
  sheets_gid="2030864989",
  sql_file="cwv_trend.sql"
  )
}}

LCPと同様に、CLSもページの重さが増加するにつれて増加しましたが、デスクトップとモバイルの違いはより線形でした。CLSは直接的な読み込み時間の問題ではないため、これは最適化が不十分で広告の多いページがコンテンツに広告を挿入し、コンテンツを押し下げたり、寸法の定義されていない大きなファイルサイズの画像が原因である可能性があります。

### 合計ブロック時間

前述のように、Interaction to Next Paint、あるいは古いFirst Input Delayでさえ、ラボテストでは正確に測定できません。しかし、[web.devの推奨](https://web.dev/intl/ja/articles/inp#lab-measurement)どおり、[Total Blocking Time](https://web.dev/intl/ja/articles/tbt)（TBTと略されることが多い）は、インタラクティビティがどのように影響を受けるかを確認するための良い代理メトリックになります。

200ミリ秒以下の合計ブロック時間は、良い目標と見なされます。

{{ figure_markup(
  image="distribution-of-tbt-scores-by-device-type.png",
  caption="デバイスタイプ別の合計ブロック時間スコアの分布。",
  description="パーセンタイル別のTBTスコアの分布の縦棒グラフ。デスクトップでは、10パーセンタイルで0ミリ秒、25パーセンタイルで0ミリ秒、中央値で53ミリ秒、75パーセンタイルで245ミリ秒、90パーセンタイルで648ミリ秒です。モバイルでは、それぞれ103ミリ秒、411ミリ秒、1,235ミリ秒、2,942ミリ秒、5,786ミリ秒でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRhwSJkKZwXMgxXEe9VbCGUazuIPoC5SERZ_DUWxxxoQjG4O4TbcWa_DA_mUBKM3XSOEBbbEKfucuny/pubchart?oid=1133418038&format=interactive",
  sheets_gid="2030864989",
  sql_file="cwv_trend.sql"
  )
}}

合計ブロック時間で測定した、ページサイズが大きいほどパフォーマンスに悪影響を与えるという傾向は、モバイルとデスクトップの両方のエクスペリエンスで明らかです。しかし、その格差はモバイルユーザーにとってとくに大きいです。50パーセンタイルでは、Time to First Byte (TBT) はデスクトップで53ミリ秒、モバイルで1,235ミリ秒で、1.2秒の差があります。この格差は90パーセンタイルでさらに顕著になり、TBTはデスクトップで648ミリ秒、モバイルでは驚異的な5,786ミリ秒で、実に5.1秒もの差があります。

インタラクティビティは、過度のページの重さに関連するもっとも悪影響を受けるメトリックの1つであると結論付けるのは妥当です。

2024年のCore Web Vitalsに関する詳細データについては、[パフォーマンス](./performance)の章をご覧ください。

## 結論

ページの重さという増大する問題は、機能性とアクセシビリティのバランスの必要性を反映しています。

JavaScriptフレームワークやリッチメディアなどの進歩は、ウェブのインタラクティビティとストーリーテリングを強化しましたが、同時に重大な課題ももたらしました。肥大化したページは、限られたデバイスや低速な接続を持つユーザーに不釣り合いな影響を与え、ウェブ体験を包括的で公平なものではなくなります。

残念ながら、今年のデータは、モバイルとデスクトップの両方のユーザーでページの重さが増加し続けるという同じ傾向を示しています。

軽量で効率的な設計に焦点を当て、圧縮、キャッシュ、バイト節約技術などの慣行を採用することで、開発者は「パフォーマンスの不平等ギャップ」を埋め、ウェブがすべての人にアクセス可能であり続けることを保証できます。

最終的に、このアプローチはユーザーに利益をもたらすだけでなく、ウェブの持続可能性と長期的な成長もサポートします。

全体として、2024年のページの重さは「解決済みの問題」とはほど遠いですが、開発者がバイト節約の技術やテクノロジーを受け入れる機会はまだたくさんあり、ファサードや圧縮などの採用の余地は十分にあります。これにより、私たち全員にとってより軽く、より明るいウェブが実現します。
