---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: パフォーマンス
description: 2025年版Web Almanacのパフォーマンスチャプター。Core Web Vitalsを網羅し、Largest Contentful Paint、Cumulative Layout Shift、Interaction to Next Paintの各指標とその診断を詳しく解説。
hero_alt: Web Almanacのキャラクターがウェブページに画像を追加し、別のキャラクターがストップウォッチで時間を計っているヒーロー画像。
authors: [himanshujariyal, 25prathamesh, hfhashmi, aarontgrogg]
reviewers: [tunetheweb, stoyan, tannerhodges]
analysts: [tannerhodges]
editors: [tunetheweb]
translators: [ksakae1216]
himanshujariyal_bio: Himanshu JariyalはMicrosoftのBingパフォーマンスチームのシニアソフトウェアエンジニアです。実ユーザーのパフォーマンス計測・分析と、大規模な本番システムの最適化を専門としています。
25prathamesh_bio: Prathamesh Rasamは10年以上にわたって大規模なウェブ・モバイルシステムに携わってきたウェブパフォーマンスアーキテクトです。ウェブパフォーマンスに関する公演者として活動し、リアルタイムのウェブ・アプリパフォーマンスモニタリングプラットフォームを大規模に構築しています。
hfhashmi_bio: HumaiiraはUCデービス校のコンピュータサイエンスの博士課程学生です。ネットワーク計測、ポリシー、プライバシーの交差点に関する研究を行っています。
aarontgrogg_bio: Aaron T. Groggは1998年にウェブ開発のキャリアをスタートしました。その後、標準、セマンティックウェブ、アクセシビリティ、そしてパフォーマンスとユーザーに焦点を当てたデジタル体験の重要性を強く提唱するようになりました。Aaronは新しいウェブ技術とベストプラクティスを発見・共有し、すべての人のためにウェブを前進させることに専念しています。
results: https://docs.google.com/spreadsheets/d/1KJQznDT9tL2IYCbYIcWas2k9OG1rK4pkk9U1qOLgBM0/edit
featured_quote: パフォーマンスの向上は実際に起きていますが、均一ではありません。インタラクティビティでは上位サイトがリードし、新機能の長尾採用はCMSのデフォルト設定によってますます推進されています。
featured_stat_1: 97%
featured_stat_label_1: デスクトップで良好なINPを持つウェブサイト（≤200ミリ秒）
featured_stat_2: 87%
featured_stat_label_2: 少なくとも1つのウェブフォントを使用しているモバイルページ
featured_stat_3: 28%
featured_stat_label_3: アンロードハンドラーを使用している上位1,000のデスクトップページ（2024年の35%から減少）
doi: 10.5281/zenodo.18258743
---

## はじめに

ウェブパフォーマンスとは、ウェブページがどれだけ速くスムーズに読み込まれ、ユーザーの操作に反応するかを指します。パフォーマンスは、特にさまざまなデバイスやネットワーク環境でウェブが使用される中で、エンゲージメント、リテンション、全体的な信頼感を形成する上で重要な役割を果たします。速くレスポンシブに感じられるページは探索や継続的な利用を促す一方、遅かったり予測不可能な体験はフローを妨げ、信頼感を低下させます。したがって、パフォーマンスに影響する要因を理解することは、エンドユーザーにとって信頼できると感じるウェブ体験を構築するために不可欠です。

ウェブパフォーマンスの計測には、実際の環境でページがどのように読み込まれ、レンダリングされ、ユーザー入力に反応するかを表す広範な指標が含まれます。デバイス、ネットワーク、実行の制約により、ウェブが常に瞬時に感じられるとは限りません。そのため、パフォーマンスは速度だけでなく、処理が進んでいる間の体験の感触にも関係します。コンテンツが読み込まれる間に明確なフィードバックを提供し、レイアウトを視覚的に安定させることで、ユーザーはページの動作を理解し、ウェブサイトを操作する際にコントロールしている感覚を得られます。

これらの考慮事項が、Core Web Vitalsと呼ばれる[ユーザー中心のパフォーマンス指標](https://web.dev/articles/user-centric-performance-metrics)の開発と採用に影響を与えました。具体的には、読み込みパフォーマンス、応答性、視覚的安定性の主要な側面を捉える[Largest Contentful Paint（LCP）](https://web.dev/articles/lcp)、[Interaction to Next Paint（INP）](https://web.dev/articles/inp)、[Cumulative Layout Shift（CLS）](https://web.dev/articles/cls)です。過去1年間で、Core Web VitalsのうちLCPとINPの2つについて、<a hreflang="en" href="https://www.debugbear.com/blog/firefox-safari-web-vitals">報告のサポートがChrome以外のブラウザにも拡大</a>され、ブラウザエンジン間でユーザー体験をより一貫して計測できるようになりました。

これらの指標は、[Time to First Byte（TTFB）](https://web.dev/articles/ttfb)や[First Contentful Paint（FCP）](https://web.dev/articles/fcp)などの従来の指標、およびページリソースの読み込み動作の計測によって補完されています。これらの広範なシグナルの集合は、パフォーマンスのボトルネックがどこで発生しやすいか、そしてそれが全体的なページ動作とどのように関係するかを説明するのに役立ちます。最新のウェブパフォーマンス指標のより包括的な概要は[web.dev](https://web.dev/performance)で確認できます。

このパフォーマンスチャプターでは、デバイスとネットワーク環境をまたいで大規模にこれらのシグナルを調査し、ウェブパフォーマンスの現状をデータに基づいた視点で提供します。実際のデータを分析することで、ウェブが改善されている箇所、課題が残る箇所、そしてより良いユーザー体験と関連するパターンを明らかにします。今年の分析には、[Early Hints](https://developer.chrome.com/docs/web-platform/early-hints)や[Speculation Rules](https://developer.chrome.com/docs/web-platform/implementing-speculation-rules)などの新興パフォーマンス機能も含まれています。

### データソースと方法論

この章は、<a hreflang="en" href="https://httparchive.org/faq">HTTP Archive</a>と[Chrome UX Report（CrUX）](https://developer.chrome.com/docs/crux)のデータをもとに、ラボベースの計測と実ユーザーのパフォーマンスデータを組み合わせています。HTTP ArchiveはWebPageTest経由でChromeベースのページ読み込みデータを収集し、制御された条件下でのページ動作についての詳細な洞察を提供します。一方CrUXは、Chromeユーザーから収集した実際のユーザー体験を反映しています。主な分析は2025年7月の計測に基づいており、ウェブ上の数百万のウェブサイトと大量のページ読み込みを対象としています。データ収集と方法論の詳細は[方法論](./methodology)で確認できます。

## Core Web Vitalsの概要

Core Web VitalsはGoogleが実際のユーザーにウェブページがどのように感じられるかを理解するための主要な指標です。以下の条件を満たすページが「良好」と見なされます：

- **Largest Contentful Paint（LCP）**: メインコンテンツが素早く表示される（2.5秒以内）ため、ページが有用に感じられる。
- **Interaction to Next Paint（INP）**: クリックやタップへのページの反応がほぼ即時（200ミリ秒以内）。
- **Cumulative Layout Shift（CLS）**: レイアウトがほぼ安定しており、予期しない移動がほとんどない（スコア ≤ 0.1）。

ほとんどのユーザーに対してこれらのしきい値を満たすページは、「良好」な全体的なページ体験を提供していると分類されます。

もちろん、これらはウェブ全体の推定的な分類を目的とした大まかな指標です。個々のウェブサイトでは、ユーザーにとっての「良好」の期待値が異なる場合があります。

{{ figure_markup(
  image="good-core-web-vitals-devices-years.png",
  caption="良好なCore Web Vitalsのトレンド。",
description="デバイス別・年別に良好なCore Web Vitals（CWV）パフォーマンスを持つウェブサイトの割合を示す棒グラフ。2021年、モバイルの32%とデスクトップの41%が良好なCWVスコアを達成。2022年にモバイル31%、デスクトップ44%に増加し、2023年にはモバイル36%、デスクトップ48%に。2024年にはモバイルで44%、デスクトップで55%に達し、2025年にはモバイル48%、デスクトップ56%にさらに改善。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=221638490&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

モバイルのCore Web Vitalsは継続的な前年比改善を示しており、2023年の36%から2024年の44%に増加し、2025年には48%に達しました。この上昇はサイトの最適化に加え、ブラウザ、デバイス、ネットワークの改善を反映している可能性があります。

デスクトップのパフォーマンスも、2023年の48%から2024年の55%へとポジティブなトレンドを示しました。ただし、2025年の改善は僅かで、56%への増加にとどまりました。

これらのトレンドをより深く理解するために、次のセクションではCore Web Vitalsがページの人気度によってどのように異なるかを調べます。より人気のあるページはランク値が低く表示されます。

{{ figure_markup(
  image="good-core-web-vitals-by-rank.png",
  caption="ランク別の良好なCWVを持つウェブサイト。",
  description="サイトランク別にデスクトップとモバイルのパフォーマンスを比較して、良好なCore Web Vitals（CWV）スコアを達成しているウェブサイトの割合を示すグラフ。上位1,000のウェブサイトでは、デスクトップの59%が良好なCWVを持ち、モバイルは51%と比較。モバイルのパフォーマンスはその後のティアでさらに低下し、上位10,000で42%、上位100,000で37%に。デスクトップのパフォーマンスはランク間で比較的安定しており、55%〜57%の間を推移。モバイルのパフォーマンスは下位ランクのサイトで再び改善し、上位1,000万で49%、全体で48%に達する。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=293787205&format=interactive",
  sheets_gid="1354135914",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

モバイルでは、最も人気のあるサイトと最も人気のないサイトが、人気分布の中間に位置するサイトよりも優れたパフォーマンスを示す傾向があります。最も人気のあるサイトはCore Web Vitalsの結果が良好な一方、中程度の人気のサイトではパフォーマンスが低下し、最も人気のないサイトでは再び改善されます。

- 最も人気のある1,000のモバイルサイトの51%が良好なCore Web Vitals（CWV）を持つ。
- CWVは次の10,000サイトで42%、次の100,000サイトで37%に低下する。
- しかし、次の1,000,000サイトで42%、次の10,000,000サイトで48%に改善する。

このパターンは、人気ティア間のページの複雑さとパフォーマンスへの投資の違いを反映している可能性があります。
- 人気の高いサイトはパフォーマンスを優先事項として扱い、ユーザーエンゲージメントとビジネス成果との<a hreflang="en" href="https://www.speedcurve.com/blog/site-speed-business-correlation/">密接な相関関係</a>から継続的な最適化に投資する可能性が高い。
- 中程度の人気のサイトは、追加機能やサードパーティスクリプトなど高い複雑さとパフォーマンスへの継続的な焦点の欠如を組み合わせ、結果の低下につながる場合がある。
- 人気の低いサイトは多くの場合よりシンプルで、機能が少なく軽量なページを持ち、プラットフォームのデフォルト設定の恩恵を受けて比較的優れたパフォーマンスを提供できる。

このU字型のパターンはモバイルでより顕著で、より遅いデバイスと不安定なネットワーク状況がページの複雑さと最適化の限界の影響を増幅させる傾向があります。デスクトップでは、より強力なハードウェアと安定したネットワークにより、これらの違いの目に見える影響を軽減できます。

パフォーマンスはプライマリナビゲーションとセカンダリナビゲーション間でも大きく異なる場合があります。プライマリナビゲーションは通常、ユーザーがホームページのサイトにアクセスするときに発生し、より多くのリソースをフェッチして実行する必要があります。一方、セカンダリナビゲーションは、ユーザーが同じサイト内のページ間を移動する際に発生し、以前に読み込まれてキャッシュされたリソースの恩恵を受けることができます。

この章のほとんどのCrUXデータはオリジン単位ですが、クローラーはクロール時に利用可能な場合はページレベルのCrUXデータも収集しており、ホームページとセカンダリページナビゲーション間のCore Web Vitalsの違いを調べることができます。

{{ figure_markup(
  image="good-core-web-vitals-home-secondary-page.png",
  caption="ホームページとセカンダリページの良好なCWV。",
  description="デスクトップとモバイルのホームページとセカンダリページの良好なCore Web Vitals（CWV）スコアを持つページの割合を示すグラフ。ホームページでは、デスクトップページの47%とモバイルページの45%が良好なCWVを達成。セカンダリページでは、デスクトップで61%、モバイルで56%に増加。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=604736426&format=interactive",
  sheets_gid="1721986308",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

セカンダリページはホームページよりも高いCWV合格率を示しており、デスクトップで14%、モバイルで11%のリードがあります。このパフォーマンスの差は、セカンダリページがキャッシュされた情報の恩恵を受けることが多く、それがより速いページ読み込みに貢献していることを示唆しています。ホームページはより頻繁に更新され、より動的でさまざまなコンポーネントを含む傾向がある一方、セカンダリページはよりテンプレート化されて一貫性があり、より安定して最適化しやすい場合があります。

現代のシングルページウェブサイトは、フルページリロードなしにコンテンツが変わるJavaScriptベースのナビゲーションを使用することが多いです。これらのナビゲーションはユーザーにとってページ間の移動のように感じられますが、現在のWeb Vitalsの計測では常に完全に捕捉されるわけではありません。[ソフトナビゲーション](https://developer.chrome.com/blog/new-soft-navigations-origin-trial)のサポートにより、これらのページ内遷移でのCore Web Vitalsの捕捉が改善され、最初のページ読み込みを超えた実際のユーザー体験のより正確なビューが提供されることが期待されています。

## 読み込み速度

ユーザーの品質と信頼性の認識に影響を与える主要な要因の1つが、ウェブサイトの初期読み込み速度です。しかし、「速度」はウェブサイトの文脈において本質的に相対的であり、単一の値で定義するのは難しいです。パフォーマンスはユーザーのデバイス能力とネットワーク環境によって異なるため、ユーザー体験を捉えるために単一の「読み込み時間」に頼ることはできません。そのため、サイトがどれだけ速く読み込まれるかだけでなく、どれだけ速く *感じられる* かを計測する複数の[ユーザー中心の指標](https://web.dev/articles/user-centric-performance-metrics)を見ていきます。

以下のセクションでは、First Contentful Paint（FCP）とLargest Contentful Paint（LCP）の2つの主要な読み込み指標に焦点を当てます。

### First Contentful Paint

ウェブページの速度に対するユーザーの第一印象を理解するために、[First Contentful Paint（FCP）](https://web.dev/articles/fcp)を見ていきます。この指標は、ユーザーが最初にページをリクエストした時点から計測して、ページが *あらゆる* コンテンツを表示し始めるまでにかかる正確な時間を捉えます。FCPスコアが1.8秒未満のページは「良好」と見なされ、1.8〜3.0秒のスコアはページが「改善が必要」であることを示し、3.0秒を超えるスコアは「不良」なパフォーマンスと見なされます。

{{ figure_markup(
  image="fcp-performance-by-year-and-device-2025.png",
  caption="年別・デバイス別のFCPパフォーマンス。",
  description="年別・デバイス別のFirst Contentful Paint（FCP）パフォーマンスの分布を「良好」、「改善が必要」、「不良」に分類して示す棒グラフ。デスクトップでは、良好なFCPを持つページの割合が2024年の68%から2025年の70%に増加し、不良なFCPは10%から9%に減少。モバイルでは、良好なFCPが2024年の51%から2025年の55%に改善し、不良なFCPは18%から16%に対応して減少。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1596764241&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

FCPパフォーマンスは2024年以降、デスクトップとモバイルの両方で改善されました。「良好」なFCPを達成するデスクトップサイトの割合が2%増加し、モバイルサイトはより大きな4%の改善を見せました。FCPは大まかに2つの主要な部分から構成されていると理解でき、それぞれが読み込みプロセスの異なる側面によって影響を受けます：

- 1つ目は、[Time to First Byte（TTFB）](https://web.dev/articles/ttfb)で捉えられるネットワークとサーバーのオーバーヘッドです。これには接続セットアップ、リダイレクト、サーバー処理時間が含まれ、主にネットワークインフラとプロトコル効率によって影響を受けます。Service Workerがキャッシュからレスポンスを提供する場合、ネットワークのラウンドトリップを回避でき、再訪問時のTTFBを改善できます。ただし、Service Workerの起動も遅延を加える可能性があり、[Navigation Preload](https://web.dev/blog/navigation-preload)は初期化中にネットワークリクエストを並行して開始することでこれを軽減するのに役立ちます。
- 2つ目はクライアントサイドレンダリングで、最初のバイトを受信した後に始まります。これはブラウザがリソースを解析してページの最初の可視コンテンツをレンダリングするために必要な時間を反映しており、ブラウザの動作、レンダリングブロックリソース、ユーザーハードウェア能力などの要因によって影響を受けます。

{{ figure_markup(
  image="ttfb-performance-by-year-and-device-2025.png",
  caption="年別・デバイス別のTTFBパフォーマンス。",
  description="2024年と2025年のTTFB（Time to First Byte）パフォーマンスをデスクトップとモバイルのデバイスタイプ別に示す積み上げ棒グラフ。各棒グラフには3つのカテゴリがあります：「良好」（0.8秒未満）、「改善が必要」（0.8〜1.8秒）、「不良」（1.8秒超）。2024年、デスクトップウェブサイトの54%が良好なTTFBを持ち、33%が改善が必要、13%が不良なパフォーマンス。2025年には、55%のデスクトップウェブサイトが良好なTTFBを持ち、33%が改善が必要、12%が不良なパフォーマンス。モバイルウェブサイトでは、2024年に42%が良好なTTFB、40%が改善が必要、19%が不良なパフォーマンス。2025年には、44%のモバイルウェブサイトが良好なTTFB、40%が改善が必要、17%が不良なパフォーマンス。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=220208816&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )}}

2024年以降、「良好」なTTFBを達成するサイトの割合はデスクトップで1%、モバイルで2%増加しました。

{{ figure_markup(
  image="pages-passing-render-blocking-audit-2025.png",
  caption="レンダリングブロックLighthouse監査に合格したページ。",
  description="2024年と2025年のレンダリングブロックリソース監査に合格したページの割合をデスクトップとモバイルのデバイスタイプ別に比較して示す棒グラフ。2024年、デスクトップページの13%が監査に合格し、モバイルページの14%が合格。2025年、デスクトップページの13%が監査に合格し、モバイルページの15%が合格。モバイルページは2024年から2025年にかけてわずかな改善を示す一方、デスクトップページは変わらず。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=102924133&format=interactive",
  sheets_gid="1432298892",
  sql_file="render_blocking_resources.sql"
  )
}}

同期間、「レンダリングブロックリソース監査」に合格したページの割合はデスクトップで横ばい、モバイルで1%増加しました。

まとめると、2024年から2025年にかけてのFCPの改善は、サーバーレスポンスタイムのわずかな改善とレンダリングブロック作業のわずかな削減と一致しています。これは、ネットワーク配信とクライアントサイドレンダリングの両方での段階的な改善が、より早い最初の描画に貢献しており、モバイルデバイスへの影響がわずかに大きいことを示唆しています。

FCPが最初の視覚的反応を捉えるのに対し、LCPはページの主要なコンテンツがいつ表示されるかを反映し、通常より長く複雑なクリティカルパスを伴います。FCPと同様に、LCPはいくつかの連続したフェーズの合計として理解できます：サーバーから最初のバイトを受信するまでの時間（TTFB）、ブラウザがLCPリソースのフェッチを開始するまでの遅延（リソース読み込み遅延）、そのリソースの読み込みに費やされる時間（リソース読み込み時間）、および要素がレンダリングされる前の遅延（要素レンダリング遅延）。これらのフェーズ全体で時間がどこに費やされているかを理解することが、LCP、ひいては全体的な[Core Web Vitalsパフォーマンス](https://web.dev/articles/defining-core-web-vitals-thresholds)の改善に重要です。

### Largest Contentful Paint

ページがいつ意味のある形で読み込まれたと感じるかを理解するために、[Largest Contentful Paint（LCP）](https://web.dev/articles/lcp)を見ていきます。この指標は、ユーザーが最初にページをリクエストした時点から、最大の可視要素（通常はヒーロー画像、見出し、または目立つテキストブロック）が画面上でレンダリングを終了するまでの時間を計測します。LCPスコアが2.5秒未満のページは「良好」と見なされ、2.5〜4.0秒のスコアはページが「改善が必要」であることを示し、4.0秒を超えるスコアは「不良」なパフォーマンスと見なされます。

{{ figure_markup(
  image="lcp-performance-by-device-2025.png",
  caption="デバイス別のLCPパフォーマンス。",
  description="デスクトップとモバイルのデバイスタイプ別のLCP（Largest Contentful Paint）パフォーマンスを示す積み上げ棒グラフ。各棒グラフには3つのカテゴリがあります：「良好」（2.5秒未満）、「改善が必要」（2.5〜4.0秒）、「不良」（4秒超）。デスクトップウェブサイトでは74%が良好なLCPを達成し、18%が改善が必要、7%が不良なパフォーマンス。スマートフォンデバイスでは、62%のウェブサイトが良好なLCPを持ち、25%が改善が必要、13%が不良なパフォーマンス。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=546968144&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

現在、デスクトップページの74%が「良好」なLCPスコアを達成しているのに対し、モバイルは62%で、モバイルは「不良」な体験の率もほぼ2倍（13%対7%）を示しています。このギャップは、モバイルにおけるより遅いネットワークとより低性能なデバイスの複合的な影響と一致しています。

#### LCPコンテンツタイプ

LCPを効果的に最適化するには、まずどのタイプのコンテンツが通常LCP要素になるかを理解する必要があります。

{{ figure_markup(
  image="top-lcp-content-types-2025.png",
  caption="LCPコンテンツタイプ。",
  description="2025年のデスクトップとモバイルの上位LCPコンテンツタイプを示す棒グラフ。デスクトップでは85.3%のページが画像をLCPコンテンツタイプとして持ち、76.0%のモバイルページが画像をLCPコンテンツとして持つ。テキストはデスクトップで14.4%、モバイルで23.7%のLCPコンテンツを占める。インライン画像はまれで、デスクトップのLCPコンテンツの0.3%、モバイルの0.4%を占める。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1953839389&format=interactive",
  sheets_gid="1342917583",
  sql_file="lcp_resource_type.sql"
  )
}}

LCPコンテンツタイプのトレンドは過去の年と同様です（[2022年](../2022/performance#fig-8)および[2024年](../2024/performance#lcpコンテンツタイプ)のデータも参照）。画像は両デバイスタイプのLCP要素として引き続き支配的で、デスクトップページの85.3%とモバイルページの76%が画像をLCP要素として持っています。テキストベースのLCP要素が残りの多くを占めており、デスクトップで14.4%、モバイルで23.7%です。このギャップは、狭いビューポートでヒーロー画像がリサイズされ、より小さなビジュアルに置き換えられるか、または完全に削除されるレスポンシブデザインの慣行を反映している可能性が高く、代わりに見出しテキストが最大の可視要素になります。

インライン画像（HTMLに直接埋め込まれたデータURI）はページの約0.5%でまれなままで、より大きなHTMLペイロードとキャッシュ効率に関するトレードオフについての限定的で慎重な採用と意識を示しています。

#### LCP画像フォーマット

LCP要素としての画像のこの継続的な支配を考慮すると、LCPのリソース読み込み時間フェーズに直接影響するため、使用されている画像フォーマットを見ることが重要になります。[2024年のチャプターではこのフェーズが他と比べて最適化の可能性が低いことが示されましたが](../2024/performance#lcpサブパーツ)、画像フォーマットの効率性は依然として全体的なパフォーマンスに貢献します。

{{ figure_markup(
  image="lcp-image-formats-2025.png",
  caption="LCP画像フォーマット。",
  description="デスクトップとモバイルのLCP（Largest Contentful Paint）画像フォーマットの分布を示す棒グラフ。JPGが最も一般的なフォーマットで、デスクトップページの57%と同様の割合のモバイルページで使用されている。PNGが2番目に一般的なフォーマットで、ページの26%で使用されている。WebPが11%で続き、MP4、SVG、GIF、AVIFなどの他のフォーマットはページの2%未満で使用されている。ICO、HEIC、HEIFフォーマットはほとんど使用されておらず、デスクトップとモバイルの両方で割合は0%に丸められる。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=319360439&format=interactive",
  sheets_gid="1338677449",
  sql_file="lcp_format.sql"
  )
}}

WebPやAVIFなどの最新フォーマットはレガシーフォーマットよりも優れた圧縮を提供し、ファイルサイズが小さく転送が速くなります。しかし、レガシーのJPGとPNGは依然として多く使用されています（JPGがLCP画像の57%、PNGが26%を占めています）。

ただし、JPGの使用が[2024年以降](../2024/performance#fig-19)4%減少し、WebPが4%増加しているなど、いくつかの前向きな兆候があります。

PNGやその他のフォーマットが2024年の割合と同じである（AVIFが0.7%に達したことを除いて）ことから、ウェブページはゆっくりとではありますが、JPGからWebPに移行しているようです。この遅い採用は、最新フォーマットが広いサポートを持っているにもかかわらず、既存の画像パイプラインとコンテンツライブラリを移行するコストを反映しているかもしれません。

#### クロスオリジンLCP画像

LCP画像のオリジンは、ブラウザがダウンロードを開始できる速さに影響し、リソース読み込み遅延フェーズに影響します。画像がページと同じドメインでホストされている場合、ブラウザは既存の接続を再利用できます。クロスオリジン画像は、特にオリジンがまだ接続されていない場合、追加の接続セットアップ（DNS/TCP/TLS）を生じさせる可能性があり、ダウンロードが開始できるまでの時間が増加します。

{{ figure_markup(
  image="cross-origin-lcp-images-2025.png",
  caption="クロスオリジンLCP画像。",
  description="デスクトップの51%とモバイルページの44%でLCP画像に同じホストが使用され、クロスホストはそれぞれ18%と16%、その他のコンテンツがデスクトップの32%とモバイルページの40%のLCP要素であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=820268406&format=interactive",
  sheets_gid="540816699",
  sql_file="lcp_host.sql"
  )
}}

デスクトップページの51%とモバイルページの44%は、ドキュメントと同じホストからLCP画像を提供しています。クロスホストのLCP画像はページの16〜18%を占めており、[preconnectヒント](https://web.dev/learn/performance/resource-hints#preconnect)で軽減されない限り、接続オーバーヘッドのコストを支払っている可能性がある意味のある割合です。

「その他のコンテンツ」カテゴリ（デスクトップ32%、モバイル40%）は、LCP要素が画像でないページ、おそらくテキストブロックや背景要素を表しています。「その他のコンテンツ」のモバイルの割合が高いのは、狭いビューポートでヒーロー画像が優先度を下げられるレスポンシブデザインパターンを反映しているかもしれませんが、このデータだけでは確定的にはわかりません。

#### LCPリソースの優先度設定

リソース読み込み遅延フェーズはLCP時間の大部分を占めることが多いため、ブラウザはクリティカルリソースを加速するためのツールを提供しています。`fetchpriority="high"` 属性は、ブラウザが通常よりも高い優先度でリソースを優先するよう指示します。これは画像がLCP要素であっても通常は高優先度と見なされないため有用です。一方、`<link rel="preload">` はブラウザがHTMLで自然に発見する前にリソースをフェッチするよう指示します。

{{ figure_markup(
  image="adoption-of-lcp-prior-2025.png",
  caption="LCP優先度設定技術の採用。",
  description='デスクトップとモバイルのLCP優先度設定技術の採用を示す棒グラフ。preloadの使用はデスクトップ2.2%、モバイル2.1%。fetchpriority="high"は最高の採用率でデスクトップ16.3%、モバイル17.3%。fetchpriority="low"は両デバイスタイプで0.3%とまれに使用されている。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1243485141&format=interactive",
  sheets_gid="1463760382",
  sql_file="lcp_async_fetchpriority.sql"
  )
}}

`fetchpriority="high"` の採用は成長を続けており、現在LCP画像を持つモバイルページの17%に登場しています（[2024年の15%](../2024/performance#lcp優先順位付け)から増加）。preloadの使用は2.1〜2.2%と低いままです。

両技術は比較的実装が簡単ですが、preloadはリソースがHTMLドキュメントで素早く発見できない場合にのみ必要であることに注意すべきです。また、preloadを使用する場合は、`fetchpriority="high"` と組み合わせて画像が高優先度でフェッチされることを確保すべきです（preloadだけを使用しても保証されません）。

LCP画像に `fetchpriority="low"` を使用しているページの0.3%は意図的でない可能性があります。開発時にどの画像がLCP要素になるかを特定することは、開発者にとってトリッキーな場合があるためです（ビューポートとコンテンツによって異なります）。

#### LCP遅延読み込み

画像の遅延読み込みとは、画像が必要になるまで読み込みを遅らせることを意味します。例えば、ページ読み込み時にすべての画像を読み込むデフォルトの代わりに、フォールドより下の画像をユーザーのビューポートに近づいたときにのみ読み込みます。これは重要なフォールドより上のコンテンツを優先するのに役立ちます。遅延読み込みは一般的に有用な最適化ですが、LCP画像に適用するとユーザーが待っているメインコンテンツの表示が遅れるため、有害になる可能性があります。

{{ figure_markup(
  caption="LCP画像を遅延読み込みしているモバイルページの割合。",
  content="17%",
  classes="big-number",
  sheets_gid="1877819046",
  sql_file="lcp_lazy.sql"
)
}}

全体として、約16〜17%のページがLCP画像を遅延読み込みしており、この数字は2024年以降変わらず安定しています。ただし、構成は変化しています：ネイティブの `loading="lazy"` の使用がわずかに増加し（モバイルで9.5%から10.4%、デスクトップで10.2%から11.5%）、`data-src` 属性の背後にソースを隠すカスタムアプローチは減少しています（モバイルで6.7%から5.9%）。ネイティブの `loading="lazy"` はカスタムアプローチよりもLCP遅延読み込みの大きなシェアを占めており、標準化されたブラウザ機能への移行を示しています。

### 読み込み速度の結論

まとめると、読み込み指標は以下の主要なトレンドを浮き彫りにしています：

- FCPとLCPはともに2024年以降改善されており、デスクトップは一貫してモバイルを上回っています。
- 新しい画像フォーマットの採用は、JPGからWebPへの緩やかな移行にもかかわらず、依然として限られています。
- 約16%のウェブページがまだLCP画像を遅延読み込みしており、プライマリコンテンツの表示を遅らせています。

## インタラクティビティ

歴史的にウェブパフォーマンスの計測は読み込み速度に集中してきましたが、INPのような指標のおかげで、ページが読み込まれた後のインタラクティビティを計測することが同等、あるいはそれ以上に重要であるという認識が高まっています。

### Interaction to Next Paint（INP）

[Interaction to Next Paint（INP）](https://web.dev/articles/inp)は、セッション中にページと行われたすべてのインタラクションを観察し、最悪の遅延を報告することで計算されます（ほとんどのサイトでは、多くのインタラクションを持つページが外れ値を無視するための追加の余裕があります）。インタラクションの遅延は、ユーザーがインタラクションを開始した時点から、ブラウザが次にフレームを描画できる瞬間まで、インタラクションを駆動するイベントハンドラーのグループの単一の最長期間で構成されます。

オリジンが「良好」なINPスコアを受け取るには、すべてのセッションの少なくとも75%が200ミリ秒以下のINPスコアを必要とします。INPスコアは、ページ上のすべてのインタラクションの中で最も遅い、またはほぼ最も遅いインタラクション時間です。詳細については、[INPの計算方法の詳細](https://web.dev/articles/inp#good-score)を参照してください。

{{ figure_markup(
  image="inp-performance-by-device-2025.png",
  caption="デバイス別のINPパフォーマンス。",
  description="デバイス別のINPパフォーマンスを良好（200ミリ秒未満）、改善が必要（200〜500ミリ秒）、不良（500ミリ秒超）に分類して示す積み上げ棒グラフ。デスクトップでは97%のウェブサイトが良好なINPを持ち、2%が改善が必要、1%未満が不良なパフォーマンス。スマートフォンでは77%のウェブサイトが良好なINPを持ち、21%が改善が必要、3%が不良なパフォーマンス。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=73846591&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
) }}

2025年、モバイルのINPパフォーマンスは前向きな改善を示し、77%のウェブサイトが良好なスコアを達成しました（[2024年の74%](../2024/performance#interaction-to-next-paint-inp)から上昇）。この3パーセントポイントの向上は、何百万ものウェブサイトが今やモバイルユーザーにより応答性の高い体験を提供していることから、意味のある進歩を表しています。デスクトップのパフォーマンスは97%と引き続き模範的で、過去数年に確立された高い水準を維持しています。

注目すべきことに、モバイルとデスクトップのパフォーマンスギャップは縮小し始めており、2024年の23パーセントポイントから2025年の20パーセントポイントに縮小しました。20パーセントポイントのギャップはまだ大きいですが、これはギャップを縮める方向への最初の測定可能な一歩です。このトレンドは、モバイル最適化の取り組みがウェブ全体で勢いを増していることを示しています。

{{ figure_markup(
  image="mobile-inp-performance-by-rank-2025.png",
  caption="ランク別のモバイルデバイスのINPパフォーマンス。",
  description="ウェブサイトランク別のモバイルINPパフォーマンスを「良好」（200ミリ秒未満）、「改善が必要」（200〜500ミリ秒）、「不良」（500ミリ秒超）に分類して示す積み上げ棒グラフ。上位1,000のウェブサイトでは63%が良好なINP、32%が改善が必要、5%が不良。上位10,000のウェブサイトでは56%が良好、38%が改善が必要、6%が不良。上位100,000では56%が良好、38%が改善が必要、6%が不良。上位1,000,000のウェブサイトでは64%が良好なINP、31%が改善が必要、5%が不良。上位10,000,000のウェブサイトでは76%が良好、21%が改善が必要、3%が不良。すべてのウェブサイトでは77%が良好なINP、21%が改善が必要、3%が不良。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1626195308&format=interactive",
  sheets_gid="1354135914",
  sql_file="inp_by_rank.sql"
) }}

最も人気のあるウェブサイトは2025年に目覚ましいINPの改善を示し、上位1,000サイトは良好なスコアが53%から63%に急増しました。これは10パーセントポイントの向上で、他のすべてのカテゴリを上回りました。これは、高トラフィックのウェブサイトがインタラクティビティの最適化を優先していることを示しており、ユーザーエンゲージメントとビジネス指標への直接的な影響によって促進されている可能性が高いです。

人気サイトは全体平均の77%をまだ下回っていますが、ギャップは大幅に縮まりました。上位1,000サイトは2024年に平均より21パーセントポイント下でしたが、2025年には14パーセントポイント下にとどまっており、どのカテゴリでも観察された最速の改善率です。

このパターンは、高トラフィックウェブサイトが直面する独自の課題を反映しています：より複雑な機能、より豊かなインタラクティブ機能、より重いサードパーティ統合、および多様なユーザーインタラクションパターン。Eコマースプラットフォーム、ソーシャルメディアサイト、ニュースポータルは本質的により多くのJavaScript実行を必要とし、良好なINPスコアの達成をより困難にしています。

大幅な前年比改善は、主要なウェブサイトがコード分割、インタラクション最適化、選択的機能読み込みを通じてこれらの課題を成功裏に解決していることを示唆しています。最も訪問されるサイトがパフォーマンスを向上させ続けるにつれて、より高い基準を設定し、より広いウェブエコシステムに価値ある最適化パターンを提供しています。

{{ figure_markup(
  image="good-inp-for-home-pages-and-secondary-pages-2025.png",
  caption="ホームページとセカンダリページの良好なINP。",
  description="デスクトップとモバイルのホームページとセカンダリページで良好なINPを持つページの割合を示す棒グラフ。ホームページでは、デスクトップページの97%が良好なINPを持ち、モバイルページの80%が良好なINPを達成。セカンダリページでは、デスクトップページの95%が良好なINPを持ち、モバイルページの69%が良好なINP。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1226158281&format=interactive",
  sheets_gid="1721986308",
  sql_file="web_vitals_by_device_secondary_pages.sql"
) }}

ページレベルのCrUXデータを見ると、[2024年から](../2024/performance#fig-21)の注目すべき変化として、ホームページが今やモバイルデバイスでセカンダリページよりも大幅に良好なINPパフォーマンスを示しています。モバイルホームページは80%の良好なINPスコアを達成し、2024年より7パーセントポイント改善されました。セカンダリページは69%に低下し、11パーセントポイントのギャップを生じさせました。この乖離は、ホームとセカンダリページがほぼ同一のパフォーマンスを示した2024年（モバイルで73%対72%）からの変化を表しています。デスクトップのパフォーマンスは両ページタイプでそれぞれ97%と95%と堅調を維持しました。

ホームページのINPの改善は、第一印象が重要なランディングページへの最適化の注力が増加したことを反映している可能性があります。しかし、セカンダリページのパフォーマンス低下は注意が必要で、これらのページはフィルター、カルーセル、フォーム検証などのより複雑なインタラクションを含むことが多く、またユーザージャーニーの深いところで活性化するサードパーティウィジェットと分析からのJavaScriptも蓄積するためです。

### Total Blocking Time（TBT）

[Total Blocking Time（TBT）](https://web.dev/articles/tbt)は、First Contentful Paint（FCP）後にメインスレッドが入力応答性を防ぐほど長くブロックされた合計時間を計測します。

TBTはラボ指標であり、実ユーザーモニタリングを使用してのみ収集できるINPのようなフィールドベースの応答性指標のプロキシとしてよく使用されます。[ラボベースのTBTとフィールドベースのINPは相関しており](https://colab.research.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2)、TBTの結果は一般的にINPのトレンドを反映しています。200ミリ秒未満のTBTは良好と見なされますが、ほとんどのモバイルウェブサイトはこの目標を大幅に超えています。

{{ figure_markup(
  image="distribution-of-tbt-per-page-2025.png",
  caption="ページあたりのTBTの分布。",
  description="パーセンタイル別のページあたりのTotal Blocking Time（TBT）の分布をミリ秒（ms）で示す棒グラフ。10パーセンタイルでは、デスクトップTBTは0ミリ秒、モバイルは127ミリ秒。25パーセンタイルでは、デスクトップTBTは3ミリ秒、モバイルは679ミリ秒。50パーセンタイルでは、デスクトップは92ミリ秒のTBT、モバイルは大幅に上昇して1,916ミリ秒。75パーセンタイルでは、デスクトップは336ミリ秒に達し、モバイルは4,193ミリ秒。90パーセンタイルでは、デスクトップTBTは802ミリ秒、モバイルは7,555ミリ秒に達する。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=566862109&format=interactive",
  sheets_gid="309018170",
  sql_file="tbt_by_percentile.sql"
) }}

モバイルの中央値TBTは2025年に1,916ミリ秒に増加し、[2024年の1,209ミリ秒から58%上昇](../2024/performance#total-blocking-time-tbt)しました。デスクトップのTBTも67ミリ秒から92ミリ秒に上昇しました。90パーセンタイルでは、モバイルユーザーはページが完全にインタラクティブになる前に7.5秒以上のブロック時間に直面しています。

これは明らかな矛盾を提示しています：フィールドベースのINPスコアが改善されたにもかかわらず、ラボベースのTBTは大幅に悪化しました。この乖離の背後にはいくつかの要因が考えられます。

- 現実世界のデバイスがより強力になり、ラボテストが一貫したエミュレートデバイスを使用して明らかにするコードの複雑さの増加を隠しています。
- 一部のサイトはINPを支配するインタラクションを最適化しながら、TBTに表れる大量のバックグラウンド作業を実行し続けている可能性があります。
- INP指標は進化し続けており、Chromiumの<a hreflang="en" href="https://chromium.googlesource.com/chromium/src/+/main/docs/speed/metrics_changelog/inp.md">INP指標の変更履歴</a>に記載されているように、計測の安定化と現実世界のインタラクション動作のより良い捕捉に焦点を当てた今後の改善が予定されています。

デスクトップ（中央値92ms）とモバイル（中央値1,916ms）のギャップの拡大は、デバイスクラス間の持続的なパフォーマンスの不平等を強調しており、INPの改善にもかかわらず、メインスレッドブロッキングの根本的な課題が激化していることを示唆しています。

### インタラクティビティの結論

インタラクティビティの結果の主なポイントは以下の通りです：

- モバイルINPは77%に改善し（74%から上昇）、モバイルとデスクトップのギャップを20パーセントポイントに縮小しました。
- 上位1,000のウェブサイトが最も大きな改善を達成し、良好なINPが53%から63%に向上しました。
- ホームページはセカンダリページを大幅に上回るようになりました（モバイルで80%対69%）。
- INPの改善にもかかわらず、TBTは58%増加し、全体的なJavaScript実行の重さが増していることを示しています。

## 視覚的安定性

視覚的安定性はCumulative Layout Shift（CLS）によって計測され、ページがユーザーにとってどれだけ予測可能でスムーズに感じられるかの指標です。このセクションでは、最近の数年間の進歩、デバイスの違い、および変化に焦点を当てます。

### Cumulative Layout Shift（CLS）

Cumulative Layout Shift（CLS）は、ページの読み込みとインタラクション中の予期しないレイアウトの動きを計測し、スコアが高いほど視覚的なシフトが多くなります。CLSスコアは3つのしきい値に分類されます：「良好」（≤ 0.1）、「改善が必要」（> 0.1かつ ≤ 0.25）、「不良」（> 0.25）。これにより、ウェブサイト間の視覚的安定性を評価・比較するための標準化された方法が提供されます。

{{ figure_markup(
  image="good-cls-by-device-2025.png",
  caption="デバイス別のCLSパフォーマンス",
  description="2025年のデバイス別Cumulative Layout Shift（CLS）パフォーマンスの分布を「良好」、「改善が必要」、「不良」に分類して示すグラフ。デスクトップでは72%のページが良好なCLSスコアを達成し、17%が改善が必要、10%が不良と分類されている。モバイルページは全体的に良好なパフォーマンスを示し、81%が良好なCLSを達成し、10%が改善が必要、9%が「不良」カテゴリ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=79158134&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

2025年、デスクトップページの72%とモバイルページの81%が「良好」なCumulative Layout Shift（CLS）スコアを達成しています。デスクトップページはモバイル（10%）に比べてCLSが「改善が必要」な割合が高く（17%）、「不良」なCLSのページの割合はデバイス間でほぼ同じで約9〜10%です。これは、ほとんどのページがCLSのしきい値を満たすのに近く、深刻なレイアウト不安定性を経験するページが少ないことを示しています。

[2024年と比較して](../2024/performance#cumulative-layout-shift-cls)、「不良」なCLSを持つデスクトップページの割合が1%減少し、「改善が必要」と分類されるページの割合が同様に増加しました。

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="2021年から2025年のデバイス別CLSパフォーマンス",
  description="2021年から2025年にかけてのデスクトップとモバイルの良好なCumulative Layout Shift（CLS）スコアを持つウェブサイトの割合を示すグラフ。デスクトップでは良好なCLSを持つサイトの割合が2021年の62%から2025年の72%に増加。モバイルでは良好なCLSが2021年の62%から2025年の81%に増加。2022年以降の各年において、モバイルはデスクトップよりも良好なCLSを持つサイトの割合が高い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1623776585&format=interactive",
  sheets_gid="1060077014",
  sql_file="web_vitals_by_device.sql"
  )
}}

過去の年を振り返ると、「良好」なCLSのしきい値を満たすウェブサイトの割合はデスクトップとモバイルの両方で毎年増加しています。デスクトップのCLSは2021年の62%から2025年の72%へと徐々に改善し、モバイルは同期間に81%と、より大きな改善を見せました。ただし、昨年と比較した増加はわずかで、デスクトップで「良好」なCLSのしきい値を満たすサイトの割合は変わらず、モバイルは2%しか改善されていません。

{{ figure_markup(
  image="good-cls-home-secondary-page.png",
  caption="ページタイプ別の良好なCWVを持つウェブサイトの割合。",
  description="2025年のデスクトップとモバイルのホームページとセカンダリページの良好なCumulative Layout Shift（CLS）スコアを持つページの割合を示すグラフ。ホームページでは、デスクトップページの71%とモバイルページの79%が良好なCLSを達成。セカンダリページでは、デスクトップで73%、モバイルで81%に増加し、両ページタイプでモバイルがデスクトップを上回る。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=24521456&format=interactive",
  sheets_gid="1721986308",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

ページレベルのCrUXデータを見ると、ホームページ以外のページはデスクトップとモバイルの両デバイスでホームページよりもわずかに良好な視覚的安定性を示しています。2025年、デスクトップのセカンダリページの73%が「良好」なCLSを達成しており、デスクトップホームページの71%と比較されます。モバイルでは、セカンダリページの81%が「良好」なCLSのしきい値を満たしており、モバイルホームページの79%と比較されます。これは、ヒーローメディア、バナー、プロモーション要素などのより動的なコンテンツを含むことが多いホームページが、セカンダリページよりもレイアウトシフトを起こしやすいことを示唆しています。

{{ figure_markup(
  image="good-cls-by-month.png",
  caption="2023年から2025年のデバイス別月次CLSトレンド。",
  description="2023年1月から2025年初頭にかけてのデスクトップとモバイルの「良好」なCumulative Layout Shift（CLS）スコアを持つウェブサイトの月次割合を示すグラフ。デスクトップは2023年初頭の約65%から2025年までに約72%に増加し、モバイルは同期間に約75%から約79〜80%に上昇。モバイルは全期間を通じてデスクトップよりも良好なCLSの割合が高い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=142338615&format=interactive",
  sheets_gid="1891926464",
  sql_file="monthly_cls_lcp.sql"
  )
}}

2023年から2025年にかけて、「良好」なCLSを持つサイトの割合は両デバイスタイプで着実に増加しており、モバイルが一貫してデスクトップを上回っています。時間の経過とともに若干の変動がありますが、両トレンドとも急激な変曲点なしに緩やかな上昇軌跡を示しており、突然の変化ではなく継続的な改善を示しています。

### CLSのベストプラクティス

サイトがCLSの可能性を低減するために従えるベストプラクティスが多数あります。

#### バック/フォワードキャッシュ（bfcache）

[バック/フォワードキャッシュ（bfcache）](https://web.dev/articles/bfcache)は、ユーザーがブラウザの戻るまたは進むボタンを使用してナビゲートするときに、ブラウザがページをメモリから即座に復元できるようにします。ページをリロードしてJavaScriptを再実行するのではなく、ブラウザはページの状態を保持し、ほぼ瞬時のナビゲーションと改善されたユーザー体験をもたらします。ページが以前の状態に復元されるため、bfcacheは再ナビゲーション中に発生する可能性のあるレイアウトシフトを回避するのにも役立ちます。

ただし、すべてのページがbfcacheの対象ではありません。対象資格はページライフサイクル要件のセットに依存しており、これらの制約に違反するページは完全なリロードにフォールバックします。対象外の理由のリストは<a hreflang="en" href="https://html.spec.whatwg.org/multipage/nav-history-apis.html#nrr-details-reason">HTML仕様</a>で確認できます。bfcacheの動作は最終的にブラウザによって処理されますが、開発者はChrome DevToolsを使用して[ページの適格性を評価](https://developer.chrome.com/docs/devtools/application/back-forward-cache)できます。

ページは既知のライフサイクルの動作によってbfcacheから除外される場合があります。これには、unloadまたは `beforeunload` イベントハンドラーの使用、アクティブな接続や管理されていないタイマーなどの復元できない副作用、および安全なページの復元に干渉する特定のサードパーティスクリプトが含まれます。そのため、unloadイベントはパフォーマンスへの負の影響とバック/フォワードキャッシュとの非互換性のために非推奨とされ、推奨されていません。

Chromeチームは、最近の使用パターンに反映されているように、`visibilitychange` や `pagehide` などの代替手段を支持して [`unload` の回避を推奨しています](https://developer.chrome.com/docs/web-platform/deprecating-unload)。[2024年と比較して](../2024/performance#backforward-cache-bfcache)、2025年にはすべてのランクと両デバイスでアンロードハンドラーの使用が減少しました。この削減は、より多くのページがbfcacheの動作の対象になったことを示唆しています。この進歩にもかかわらず、アンロードハンドラーは依然として上位ランクのサイトとデスクトップでより一般的で、以下のグラフに示すように、ウェブのかなりの部分のbfcacheの適格性を制限し続けています。

{{ figure_markup(
  image="unload-handler-usage.png",
  caption="ウェブサイトランクとデバイス別のアンロードハンドラー使用状況（2025年）",
  description="2025年のデスクトップとモバイルにおけるウェブサイトランク別のアンロードイベントハンドラーを使用しているページの割合を示すグラフ。上位1,000のウェブサイトでは、アンロードハンドラーがデスクトップページの28%とモバイルページの20%に現れており、ランクが上がるにつれて使用率が着実に低下。すべてのウェブサイトでは、アンロードハンドラーがデスクトップページの11%とモバイルページの10%に存在し、すべてのランクでデスクトップの使用率がモバイルより高い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=140804120&format=interactive",
  sheets_gid="1870744021",
  sql_file="bfcache_unload.sql"
  )
}}

サイトの人気が下がるにつれてアンロードハンドラーの使用が一貫して減少するのは興味深いです。高トラフィックのウェブサイト（上位1,000サイト）では、アンロードハンドラーがデスクトップページの28%とモバイルページの20%に存在し、この割合は下位ランクのサイトに向かって着実に低下し、デスクトップで11%、モバイルで10%に達します。すべてのランクで、デスクトップページはモバイルよりも高いアンロードハンドラーの使用を示しており、アンロードハンドラーがウェブの長尾全体よりも大規模で複雑なサイトでより一般的であることを示唆しています。これは上位サイトがアナリティクス、広告、およびアンロードハンドラーを登録するレガシーライフサイクルパターンに大きく依存しているためと考えられます。

ウェブサイトがbfcacheの対象外カテゴリに入る別の一般的な理由は、`Cache-Control: no-store` ディレクティブの使用です。このキャッシュ制御ヘッダーは、ブラウザ（および中間キャッシュ）にリソースのコピーを保存しないよう指示し、コンテンツがリクエストのたびにサーバーからフェッチされることを保証します。

{{ figure_markup(
  caption="`Cache-Control: no-store` を使用しているサイトの割合。",
  content="23%",
  classes="big-number",
  sheets_gid="374304732",
  sql_file="bfcache_cachecontrol_nostore.sql"
)
}}

現在23%のサイトが `Cache-Control: no-store` を使用しており、[2024年](../2024/performance#backforward-cache-bfcache)の21%から増加しました。この増加は、認証済みおよびパーソナライズされた体験の増加、より厳格なセキュリティまたはコンプライアンス要件、特にbfcacheの適格性に関して `Cache-Control: no-store` のパフォーマンスへの影響を低減したブラウザの動作の進化を反映している可能性があります。

歴史的にすべてのブラウザが `Cache-Control: no-store` をbfcacheを避ける理由として扱ってきましたが、[Chromeは安全な場合に一部の `no-store` ページのbfcacheを許可する](https://developer.chrome.com/docs/web-platform/bfcache-ccns)場合があることに注意してください。FirefoxとSafariを含む他のブラウザは一般的に `Cache-Control: no-store` をbfcacheブロッカーとして扱い続けています。

#### 固定画像サイズ

画像はCumulative Layout Shift（CLS）の最も一般的な原因の1つで、ブラウザが事前にどれだけのスペースを確保すべきか分からない場合に発生します。画像が明示的な寸法なしに読み込まれると、ブラウザは最初に画像の高さがゼロであるかのようにページをレイアウトし、画像の読み込みが完了した後に周囲のコンテンツをシフトします。

これを防ぐには、画像は常に `width` と `height` 属性を介して、またはCSSの `aspect-ratio` を使用して本質的な寸法を定義する必要があり、ブラウザは画像がフェッチされる前に正しい量のスペースを割り当てることができます。

{{ figure_markup(
  caption="少なくとも1つの画像に明示的な寸法を設定していないモバイルページの割合。",
  content="62%",
  classes="big-number",
  sheets_gid="1870744021",
  sql_file="cls_unsized_images.sql"
)}}

2025年、明示的な寸法がない画像によるレイアウト不安定性のリスクを抱えたページが依然として大きな割合を占めています。モバイルでは62%のページが少なくとも1つの画像に寸法を設定しておらず、2024年の66%から改善されており、CLS対応の画像慣行の漸進的な採用を示しています。

デスクトップページは同様だがわずかに悪いパターンを示しており、2025年に65%が影響を受けており、2024年の69%から低下しています。下降傾向は前向きですが、大多数のページはまだブラウザがレイアウト時に画像サイズを推測する必要があり、画像をCLSへの最も持続的で防止可能な貢献者の1つにしています。

{{ figure_markup(
  image="unsized-images-per-page.png",
  caption="ページあたりの寸法未指定画像。",
  description="2025年のデスクトップとモバイルにおける異なるパーセンタイルでのページあたりの寸法未指定画像数を示す棒グラフ。50パーセンタイルでは、デスクトップページは平均2つの寸法未指定画像を持ち、モバイルは1つ。75パーセンタイルではデスクトップで9つ、モバイルで8つに増加。90パーセンタイルでは、デスクトップで25枚、モバイルで22枚の寸法未指定画像に急増し、低いパーセンタイルでは寸法未指定画像がほとんどない。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=106540407&format=interactive",
  sheets_gid="1218246619",
  sql_file="cls_unsized_images.sql"
  )
}}

ウェブページあたりの寸法未指定画像の中央値は2枚です。90パーセンタイルでは、この数字はデスクトップで26枚、モバイルで23枚に急増します。寸法未指定の画像はレイアウトシフトのリスクを高めます。ただし、CLSへの実際の影響は、画像のサイズと、特にシフトがビューポートに影響する場合に読み込まれたときにコンテンツがどれだけシフトするかの両方に依存します。CLSは影響フラクション（ビューポートのどれだけが影響を受けるか）と距離フラクション（要素がどれだけ動くか）に基づいて計算されるため、大きな画像やページの上部に近いシフトほどCLSへの貢献が大きくなる傾向があります。

{{ figure_markup(
  image="unsized-images-by-height.png",
  caption="寸法未指定画像の高さ。",
  description="2025年のデスクトップとモバイルにおける異なるパーセンタイルでの寸法未指定画像の高さを示す棒グラフ。50パーセンタイルでは、寸法未指定画像はデスクトップで111px、モバイルで98pxの高さを持ち、75パーセンタイルではそれぞれ246pxと200pxに増加。90パーセンタイルでは、寸法未指定画像の高さがデスクトップで413px、モバイルで300pxに達する",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=2046199622&format=interactive",
  sheets_gid="116114708",
  sql_file="cls_unsized_image_height.sql"
  )
}}

寸法未指定の画像は高いパーセンタイルでははるかに高くなります。中央値では、寸法未指定画像はデスクトップとモバイルの両方で約100pxの高さですが、90パーセンタイルではデスクトップで約413px、モバイルで300pxに成長します。高い寸法未指定画像がビューポートに表示される場合、特にCLSを増加させます。これは読み込まれたときにより大きな縦方向のレイアウトシフトを引き起こすためです。ウェブページは縦方向にスクロールするため、画像の高さがないことは幅がないことよりもCLSへの影響がはるかに大きいです。

#### フォント

ブラウザは、カスタムウェブフォントがまだダウンロード中の間、フォールバック（システム）フォントを使用してテキストを最初に表示することがよくあります。この一時的なレンダリングは、Cumulative Layout Shift（CLS）スコアに悪影響を与える可能性があります。カスタムフォントが最終的に読み込まれると、ブラウザはフォールバックフォントを置き換えます。これによりテキストのサイズと間隔が変わり、コンテンツのシフトが起こります。

{{ figure_markup(
  caption="ウェブフォントを使用しているモバイルページの割合。",
  content="87%",
  classes="big-number",
  sheets_gid="1246939241",
  sql_file="font_usage_mobile.sql"
)}}

モバイルページの大多数87%が少なくとも1つのウェブフォントを使用しています。このカスタムタイポグラフィの広範な使用は、ダウンロードと適用を必要とし、レイアウトシフトの[可能性を大幅に高めます](https://web.dev/articles/optimize-cls#web-fonts)。

フォントによるレイアウトシフトを効果的に最小化するには、理想的にはリソースヒントを使用して、できるだけ早く重要なフォントを読み込むことが重要です。フォントが最初のレンダリングの前または非常に近くに読み込まれると、ブラウザはすぐに正しいフォントでテキストを表示できます。これにより、レイアウトシフトの一般的な原因であるデフォルトフォントからのスワップが防止されます。現在のデータは、この機会がしばしば見逃されていることを示しています。

{{ figure_markup(
  image="fonts-resource-hint-usage.png",
  caption="フォントリソースヒントの使用状況。",
  description='2025年のデスクトップとモバイルにおけるフォント関連リソースヒントを使用しているページの割合を示す棒グラフ。`dns-prefetch` は最も一般的に使用されるヒントで、`desktop` と `mobile` の両方でページの24%に登場し、次いで各デバイスで22%の `preconnect` が続く。`preload` は `desktop` で15%、`mobile` で16%とやや少なく使用され、`prefetch` は両プラットフォームで約5%とまれなまま。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=111695502&format=interactive",
  sheets_gid="667157886",
  sql_file="font_resource_hint_usage.sql"
  )
}}

フォントリソースヒントの使用状況はデスクトップとモバイルでほぼ同様です。約24%のページがdns-prefetchを使用し、22%がpreconnectを使用しており、これは主に接続セットアップ時間の削減に役立ちます。Preloadはレンダリング中にフォントを早期に利用可能にする良い方法ですが、ページの15〜16%でしか使用されていません。さらに少ないページ（約5%）がprefetchを使用していますが、これは一般的に初期ページ読み込み中に必要なフォントにはあまり役立ちません。これは、リソースヒントのより的を絞った使用によってフォントのパフォーマンスを改善する大きな機会があることを示唆しています。

#### 非コンポジットアニメーション

[非コンポジットアニメーション](https://developer.chrome.com/docs/lighthouse/performance/non-composited-animations)は、レイアウトに影響するプロパティを変更し、レンダリングが始まった後に周囲のコンテンツを動かすリフローを引き起こすため、レイアウトシフトに貢献します。`transform` や `opacity` などのコンポジットプロパティを使用したアニメーションは、レイアウトを変更せずに視覚的な外観を更新することでこれを回避し、視覚的安定性においてより安全です。

{{ figure_markup(
  caption="非コンポジットアニメーションを持つモバイルページの割合。",
  content="40%",
  classes="big-number",
  sheets_gid="1135625211",
  sql_file="cls_animations.sql"
)}}

非コンポジットアニメーションは依然として一般的で、モバイルページの40%とデスクトップページの44%に登場しています。

{{ figure_markup(
  image="non-composite-animations-per-page.png",
  caption="ページあたりの非コンポジットアニメーション。",
  description='2025年のデスクトップとモバイルにおけるパーセンタイル別のページあたりの非コンポジットアニメーション数を示す棒グラフ。デスクトップとモバイルの両方が50パーセンタイルまでゼロの非コンポジットアニメーションを報告。75パーセンタイルでは、ページはデスクトップで3つ、モバイルで2つのアニメーションを持ち、90パーセンタイルではデスクトップで13、モバイルで11に急増。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1922146788&format=interactive",
  sheets_gid="1135625211",
  sql_file="cls_animations.sql"
  )
}}

非コンポジットアニメーションの影響は主に高いパーセンタイルで現れ、75パーセンタイルで使用率が増加し、90パーセンタイルではデスクトップで13アニメーション、モバイルで11アニメーションに急増します。

### 視覚的安定性の結論

ウェブ全体の視覚的安定性は特にモバイルデバイスで年々大幅に進歩しています。ほとんどのページは今や最小限の予期しない動きで安定した体験を提供しており、ベストプラクティスの採用が改善されていることを反映しています。ただし、特にデスクトップで約20〜30%のページがまだ「良好」なCLSを達成していないことから、継続的な改善と最適化の余地があります。

漸進的な改善にもかかわらず、寸法未指定の画像は依然として一般的で、フォントの読み込みパターンはまだレイアウトシフトの機会を生み出しており、多くのサイトが既知のCLS軽減策を完全に実装していないことを示唆しています。明示的な画像サイズ設定、重要なフォントのプリロード、コンポジットアニメーションの使用などのシンプルな[ベストプラクティス](https://web.dev/articles/optimize-cls)を採用することで、ページは視覚的安定性の改善に役立てることができます。

## Early Hints

[Early Hints](https://developer.mozilla.org/docs/Web/HTTP/Reference/Status/103)は、リクエストされたページを読み込むために必要なリソースについてブラウザに早期シグナルを提供します。

Early Hintsは、リクエストされたページがまだ準備中の間にサーバーからブラウザに送信されます。これにより、ブラウザはリクエストされたページが返される前に、楽観的に他のドメインへのプリコネクトやアセットのプリロードを開始できます。

これにより、Early Hintsは現在リクエストされているページの読み込みパフォーマンスに絶対的な影響を与えることができます。HTMLがブラウザに返るのを待ち、パーサーがメインCSSファイルやLCPアセットのリンク（またはプリロードリンク）を見つけるのではなく、HTMLがブラウザに返される前にそれらのアセットのフェッチを開始できると考えてみてください。これにより、単一の描画でほぼ完璧にレンダリングされたFCPが可能になります。

Early Hintsは `crossorigin` 属性とCSPヘッダー情報も含むことができるため、<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8297#section-3">セキュリティ上の理由から</a>HTTP/2以上でのみ使用することが推奨されます。

### Early Hintsの使用状況

{{ figure_markup(
  image="early-hints-usage.png",
  caption="Early Hintsの使用状況。",
  description="このチャートは、2025年のデスクトップとモバイルのウェブサイトランク別にEarly Hintsを使用しているページの割合を示しています。すべてのグループで使用率は非常に低く、上位100万グループのデスクトップページで6%を超えるのみです。他のすべてのグループはほぼ5%未満です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=1274076138&format=interactive",
  sheets_gid="1150834797",
  sql_file="early_hints_usage_rank.sql"
  )
}}

採用はまだ本格化していないことがわかります。すべてのグループで使用率は非常に低く、上位1,000,000サイトのデスクトップでやっと6%を超える程度で、他のほとんどのグループは5%をはるかに下回っています。

これはおそらくEarly Hintsのセットアップと設定の複雑さに関連しています。特定のページのアセットは、ページが完成して送信準備ができる前にサーバーに関連付けられている必要があります。ほとんどのCMSにとってこれは課題となるでしょう。

モバイル/デスクトップの同等性も非常に顕著です。差は1%を超えることはなく、通常は0.5%に近いです。つまり、Early Hintsが実装されている場合、すべてのデバイスタイプで同様に実装されている可能性が高いです。

2025年も使用率は低いままですが、過去3年間で顕著な増加が見られます。

{{ figure_markup(
  image="early-hints-usage-by-year.png",
  caption="年別Early Hints使用状況。",
  description="このチャートは、2023年、2024年、2025年のデスクトップとモバイルの年別にEarly Hintsを使用しているページの割合を示しています。すべての年のすべてのグループで使用率は非常に低いですが、年を追うごとに一貫した増加があり、1%強からおよそ4%へと伸びています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=888096185&format=interactive",
  sheets_gid="1512001974",
  sql_file="early_hints_usage_trends.sql"
  )
}}

### Early Hintsのサポート

ほとんどのウェブパフォーマンス機能とは異なり、Early Hintsはブラウザだけでなくサーバーのサポートにも依存しています。この公開時点では、`preconnect` はすべてのブラウザでサポートされており、`preload` はSafariを除くすべてのブラウザでサポートされています。

サーバーに関しては、Early HintsはNode、H2O、NGINXで完全にサポートされており、Apacheでは `mod_http2` を使用している場合にサポートされます。

Early HintsはCDNを通じて利用可能で、[Fastlyは2020年から](https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code)、<a hreflang="en" href="https://blog.cloudflare.com/early-hints/">Cloudflareは2021年から</a>、<a hreflang="en" href="https://www.akamai.com/blog/performance/akamai-103-early-hints-prototype-the-results-are-in">Akamaiは2023年から</a>対応しています。

## Speculation Rules

[Speculation Rules](https://developer.mozilla.org/docs/Web/API/Speculation_Rules_API)は、ユーザーが現在のページを表示した後にいずれかのページに移動することを期待して、完全なページを楽観的にプリフェッチまたはプリレンダリングする実験的なブラウザAPIです。これらのアクションはユーザーが現在表示しているページのバックグラウンドで実行されます。現在は主にChromiumベースのブラウザに実装されていますが、SafariはフラグによるプリフェッチのPartial実装があります。

Speculation Rulesは現在のページのパフォーマンスには役立ちませんが、後続ページの読み込みパフォーマンスを大幅に改善し、しばしばほぼ瞬時のページ読み込みに近づけることができます。

このAPIは、より高度な設定オプションでページ向けの `<link rel="prefetch">` と `<link rel="prerender">` を置き換えることを意図しています。なお、Speculation Rules APIはフルページ専用です。個別のアセットに対しては、引き続き `<link rel="prefetch">` を使用する必要があります。

### Speculation Rulesの使用状況

以下のチャートはSpeculation Rulesを含むホームページの割合を示しており、興味深いことがわかります。上位1,000サイトでのSpeculation Rulesの使用率は非常に低く、デスクトップで3%、モバイルで5%に過ぎません。各グループが増えるにつれて使用率は上昇しますが、上位1,000,000サイトでもモバイルとデスクトップ合わせて15%にとどまります。最後のグループ、上位10,000,000サイトになってようやく、デスクトップ24%、モバイル25%へと急激に上昇します：

{{ figure_markup(
  image="speculation-rules-usage.png",
  caption="Speculation Rulesの使用状況。",
  description='このチャートは、2025年のデスクトップとモバイルのウェブサイトランク別にSpeculation Rulesを含むホームページの割合を示しています。上位1,000のウェブサイトでは、Speculation Rulesはデスクトップページの3%とモバイルページの5%に存在し、ランクが下がるにつれて使用率は緩やかに増加します。すべてのウェブサイトでは、Speculation Rulesはデスクトップページの24%とモバイルページの35%に存在し、すべてのランクでデスクトップとモバイルの使用率はほぼ同等です。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSdGtVc2AYakM2cNaGLtpVgQwXfG7jOrGQymbbJo20qaMXn1Pd1cyV_tU9PROEuwFbhFBeI3GHCNhvN/pubchart?oid=826167809&format=interactive",
  sheets_gid="1244034811",
  sql_file="speculation_rules_rank.sql"
  )
}}

これはSpeculation Rulesの設定の複雑さに関連している可能性があります。ユーザーの正確な意図は決してわからないため、サイトはページをプリフェッチまたはプリレンダリングする際に慎重である必要があります。フェッチされたが使用されないものはすべて無駄になります。そのため、eコマースサイトのような大規模サイト、特に多数のカテゴリやメニューオプションが直接ジャンプできる大規模サイトでは、Speculation Rulesを適切に設定するのが難しい場合があります。レガシーまたは独自CMSへの実装も複雑になる可能性があります。

逆に、Speculation Rulesはインターネットの大きなシェアを持つ <a hreflang="en" href="https://make.wordpress.org/core/2025/03/06/speculative-loading-in-6-8/">WordPress</a> に組み込まれるようになり、これがロングテールでの高い採用率を説明するかもしれません。

また、モバイルとデスクトップの使用率の同等性も注目に値します。差は1%を超えることはほとんどありません。つまり、Speculation Rulesが実装されている場合、すべてのデバイスタイプで同様に実装されている可能性が高いです。

## 結論

今年のデータの分析は、よりレスポンシブになりつつあるが、最適化がまだ複雑なウェブの姿を描き出しています。ウェブの使用感における明確な進歩が見られます。モバイルのインタラクティビティは大幅に改善され、スマートフォンとデスクトップコンピュータ間のパフォーマンスギャップがついに縮まり始めています。これは、Interaction to Next Paint（INP）のような新しい指標への業界の注力が功を奏しており、開発者がユーザーにとって最も重要なインタラクションを優先しようとしていることを示しています。

しかし、ウェブの異なるセグメントが新しい標準を採用する方法における「パフォーマンスの分断」も観察されます。例えば、最も人気のあるサイトが複雑なJavaScriptの手動最適化によってインタラクティビティ（INP）の改善をリードしていることがわかりました。これに対して、Speculation Rulesのような新しい標準は、トップではなく、WordPressのような人気CMSのプラットフォームレベルの統合によって推進されるウェブの「ロングテール」で最高の採用率を示しています。これは、パフォーマンスの将来が個々の手動作業への依存を減らし、ウェブを構築するツールに組み込まれたスマートなデフォルトへの依存を増やす可能性があることを示唆しています。

これらの進歩にもかかわらず、ウェブパフォーマンスの基本は依然として課題を突きつけています。高度な指標が改善される一方で、根本的な問題は依然として残っています。モバイルページの約40%が依然として視覚的不安定性のリスクのある非コンポジットアニメーションを使用しており、大多数のページが画像の正しいサイズ指定や重要なフォントをスムーズに読み込むために必要なリソースヒントを欠いています。これは、フレームワークが複雑なJavaScriptの管理を助けてくれる一方で、良好なウェブパフォーマンスを確保するためのより単純なベストプラクティスを見落としがちであることを示唆しています。

最後に、測定そのものの状況が成熟しています。より多くのブラウザがINPのような現代的な指標のサポートを拡大するにつれ、クロスブラウザ比較がより一貫したものになります。今後を見据えると、開発者の目標はトップレベルのスコアを超えて、可能性と実践のギャップを埋め、トップサイトが使用する手動最適化と現代のウェブの自動化ツールの両方を活用して、すべてのユーザーに信頼できる体験を提供することです。

