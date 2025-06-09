---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: パフォーマンス
description: Core Web Vitalsを扱った2024年のWeb Almanacのパフォーマンス章。Largest Contentful Paint、Cumulative Layout Shift、Interaction to Next Paintの各メトリクスとその診断についての詳細な分析。
hero_alt: Web Almanacのキャラクターがウェブページに画像を追加している間、別のWeb Almanacキャラクターがストップウォッチで時間を計測しているヒーロー画像。
authors: [imeugenia, ines-akrap]
reviewers: [rviscomi, siakaramalegos]
editors: [Cherry]
analysts: [kevinfarrugia, guaca]
translators: [ksakae1216]
ines-akrap_bio: Ines Akrapは、ウェブサイトを高速化し、持続可能で、すべてのユーザーに最高のユーザーエクスペリエンスを提供することを最適化することに情熱を注ぐフロントエンドソフトウェアエンジニアです。StoryblokでSolutions Engineerとして働いています。講演、ポッドキャスト、ワークショップ、コースを通じて知識を共有することを楽しんでいます。
imeugenia_bio: Jevgenijaは、ウェブパフォーマンスと開発者エクスペリエンスに情熱を注ぐフロントエンドエンジニア兼技術イベントオーガナイザーです。デジタルファーストのホテルブランドである<a hreflang="en" href="https://www.limehome.com/en/">Limehome</a>で働いています。ラトビアとベルリンで数年間Google Developer Groupを運営していました。
results: https://docs.google.com/spreadsheets/d/15038wEIoqY53Y_kR8U6QWM-PBO31ZySQGi147ABTNBc/
featured_quote: ウェブパフォーマンスは、読み込み時間、インタラクティビティ、視覚的安定性において改善しています。しかし、モバイルとデスクトップエクスペリエンスの間のギャップは依然として大きいです。
featured_stat_1: 43%
featured_stat_label_1: INPで測定した場合に良好なCWVスコアを持つモバイルウェブサイトの割合で、これはFIDで測定した場合より5%低い数値です。
featured_stat_2: 16%
featured_stat_label_2: LCP要素に不要なレイジーローディングを使用しているウェブサイトの割合。
featured_stat_3: 13%
featured_stat_label_3: モバイルウェブサイトのホームページと比較してセカンダリページで良好なCWVスコアが高い割合。
doi: 10.5281/zenodo.14065738
---

## はじめに

高速なウェブサイトに文句を言う人はいませんが、読み込みが遅くてもたつくウェブサイトはユーザーをすぐにイライラさせます。ウェブサイトの速度と全体的なパフォーマンスは、ユーザーエクスペリエンスとウェブサイトの成功に直接影響します。さらに、ウェブサイトが遅い場合、ユーザーにとってアクセスしにくくなり、これは情報の宇宙への普遍的なアクセスを提供するというウェブの根本的な目標に反します。

近年、[Core Web Vitals](https://web.dev/articles/vitals)パフォーマンスメトリクスは改善し、多くのパフォーマンスメトリクスにわたって積極的な傾向を示しています。しかし、いくつかの不整合が観察できます。たとえば、ハイエンドデバイスとローエンドデバイスの間のギャップが拡大しており、とくにモバイルウェブパフォーマンスにおいて、Alex Russellの研究<a hreflang="en" href="https://infrequently.org/2024/01/performance-inequality-gap-2024/">The Performance Inequality Gap</a>で強調されています。ウェブパフォーマンスは、人々が購入できるデバイスとネットワークに結びついています。幸い、より多くの開発者がこれらの課題を認識し、パフォーマンスの改善に積極的に取り組んでいます。

パフォーマンス章では、ウェブパフォーマンスを評価するための重要な[ユーザー中心のメトリクス](https://web.dev/articles/user-centric-performance-metrics)であるCore Web Vitalsに焦点を当てています。しかし、読み込み、インタラクティビティ、視覚的安定性というより広い視点からウェブパフォーマンスを分析し、First Contentful Paintのような補助的なメトリクスを追加します。これにより、2024年にウェブサイトがどのように機能したかをより包括的に把握するために、他のパフォーマンスとユーザーエクスペリエンス関連のメトリクスを探ることができます。

今年の新機能は何ですか？

- [Interaction to Next Paint (INP)がFirst Input Delay (FID)を正式に置き換え](https://web.dev/blog/inp-cwv-march-12)、Core Web Vitalsの一部となりました。INPは全体的なインタラクティビティパフォーマンスをより正確に評価するのに役立ちます。
- [Long Animation Frames (LoAF)](https://developer.chrome.com/docs/web-platform/long-animation-frames)データが初めて利用可能になり、INPが低い理由についての新しい洞察を提供します。
- 今年の時点で、パフォーマンス章にはホームページに加えて、セカンダリページのデータ分析も含まれています。これにより、ホームページとセカンダリページのパフォーマンスを比較できます。

### データソースに関する注記

HTTP Archiveにはラボパフォーマンスデータのみが含まれています。言い換えれば、単一のウェブサイト読み込みイベントからのデータです。これは有用ですが、ユーザーがパフォーマンスをどのように体験するかを理解したい場合には限定的です。

したがって、HTTP Archiveデータに加えて、このレポートの大部分は[Chrome User Experience Report (CrUX)](https://developer.chrome.com/docs/crux)からの実際のユーザーデータに基づいています。Chromeは世界でもっとも広く使用されているブラウザですが、すべてのブラウザや世界のすべての地域でのパフォーマンスを反映していないことに注意してください。

CrUXは優れたデータソースですが、LCPやINPのサブパーツ、Long Animation Framesなどの特定のメトリクスは含まれていません。幸い、パフォーマンス監視プラットフォーム<a hreflang="en" href="https://www.rumvision.com/">RUMvision</a>が、2024年1月1日から10月6日までの期間のこのデータを提供してくれました。HTTP Archiveと比較すると、RUMvisionはより少ない数のウェブサイトをテストするため、同じメトリクスの結果がわずかに異なる可能性があります。

## Core Web Vitals

Core Web Vitals（CWV）は、ウェブパフォーマンスのさまざまな側面を測定するために設計されたユーザー中心のメトリクスです。これには、読み込みパフォーマンスを追跡する[Largest Contentful Paint（LCP）](https://web.dev/articles/lcp)、インタラクティビティを測定する[Interaction to Next Paint（INP）](https://web.dev/articles/inp)、視覚的安定性を評価する[Cumulative Layout Shift（CLS）](https://web.dev/articles/cls)が含まれます。

今年から、INPが正式に[First Input Delay（FID）](https://web.dev/articles/fid)を置き換えて、CWVの一部となりました。INPがユーザーが経験するすべてのインタラクションの完全な遅延を測定するのに対し、FIDは最初のインタラクションの入力遅延のみに焦点を当てています。この幅広いスコープにより、INPは完全なユーザーエクスペリエンスをよりよく反映します。

{{ figure_markup(
  image="good-core-web-vitals-fid-devices-years.png",
  caption="FIDとINPを使用してCWVが良好なウェブサイトの割合、年別に分類。",
  description="モバイルにおけるCore Web Vitals（CWV）が良好なウェブサイトの割合を示すバーチャート、時間の経過とともにFID（First Input Delay）を用いたCWVとINP（Interaction to Next Paint）を用いたCWVを比較。2022年、FIDを用いたCWVが良好なウェブサイトは39％、INPを用いたCWVが良好なウェブサイトは31％でした。2023年、FIDを用いたCWVが43％、INPを用いたCWVが37％に増加しました。2024年、FIDを用いたCWVが良好なウェブサイトは48％、INPを用いたCWVが良好なウェブサイトは43％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1908072353&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

FIDからINPメトリクスへの置き換えは、モバイルでCWVが良好なウェブサイトの割合に大きな影響を与えました。これはユーザーエクスペリエンスが悪化したということではなく、メトリクスの更新により現在はより正確に反映されているだけです。もしインタラクティビティの測定にまだFIDを使用していたとすると、モバイルデバイスでCWVが良好なウェブサイトは48％となります。しかし、INPメトリクスでは、この数字は43％に低下します。興味深いことに、どの応答性メトリクスを使用しても、デスクトップデバイスのパフォーマンスは54％で同じままです。

2020年から2022年の期間、FIDを用いたCWVで測定されたモバイルウェブパフォーマンスはデスクトップよりも速く改善され、両者のギャップは縮まり、2022年にはわずか5％まで達しました。INPを用いたCWVチャートが示すように、2024年にはデスクトップのウェブサイトがモバイルよりも11％良好なパフォーマンスを示しており、INPの導入はギャップがはるかに大きいことを示しています。

{{ figure_markup(
  image="good-core-web-vitals-inp-devices-years.png",
  caption="CWVが良好なウェブサイトの割合、ランクとデスクトップ対モバイルで分類。",
  description="デスクトップとモバイルのランク別CWV（Core Web Vitals）パフォーマンスが良好なウェブサイトの割合を示すバーチャート。上位1,000のウェブサイトについて、モバイルウェブサイトの40％が良好なCWVを持ち、デスクトップウェブサイトの54％と比較されます。上位10,000では、モバイルウェブサイトの33％が良好なCWVを持ち、デスクトップウェブサイトの46％がそうです。上位100,000では、モバイルウェブサイトの31％とデスクトップウェブサイトの43％が良好なCWVを持ちます。上位1,000,000では、モバイルウェブサイトの36％が良好なCWVを持ち、デスクトップウェブサイトの48％と比較されます。10,000,000以上のランクのウェブサイトについて、モバイルウェブサイトの44％とデスクトップウェブサイトの43％が良好なCWVを達成しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1814767865&format=interactive",
  sheets_gid="355582610",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

INPを用いたCWVは、ランク別にウェブサイトを分析する際に新しい傾向を示しています。以前は、もっとも人気のあるウェブサイトが[最適なCWVエクスペリエンスを持つ傾向](../2022/performance#fig-2)にありましたが、今年の統計は逆を示しています：モバイルでもっとも人気のある1000のウェブサイトの40％が良好なCWVを持っており、これは全ウェブサイトのCWV 43％よりも低い数値です。

{{ figure_markup(
  image="good-core-web-vitals-fid-vs-inp.png",
  caption="技術別、FIDからINPへのCWV良好なウェブサイトのパーセントポイント変化。",
  description="さまざまなプラットフォームと技術にわたって、INPによる新しいモバイルCWV障害のパーセントポイントを示すバーチャート。1C-Bitrixが新しい障害の最高パーセンテージを19％で持ち、次にNext.jsが10％、Emotionが8％となっています。WordPress、React、Vue.js、Drupalなどの他のプラットフォームは2％から5％の範囲でより小さな減少を示しています。チャートは、Handlebars、Backbone.js、Squarespace、Angularを含むさまざまな技術のより小さな減少の範囲も表示しており、すべて約2％から5％の減少を見ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=655066315&format=interactive",
  sheets_gid="869409419",
  sql_file="web_vitals_by_technology.sql",
  width=600,
  height=632
  )
}}

前述のように、INPメトリクスの切り替えによりCWVスコアは低下しました。このシフトがさまざまな技術にどのような影響を与えたかを調査しました。上の図は、INPが導入された後のさまざまな技術にわたるCWVが良好なウェブサイトの割合のパーセントポイント低下を示しています。

いくつかの技術が大きな影響を受けました。1C-Bitrix（中央アジアで人気のCMS）で19％の低下、Next.js（Reactベースのフレームワーク）で10％の低下、Emotion（CSS-in-JSツール）で8％の低下が含まれます。CWVスコアの低下が使用されている技術のみによるものであると完全に確信することはできません。Next.jsはサーバーサイドレンダリング（SSR）と静的サイト生成（SSG）機能を持っており、理論的にはINPを向上させるはずですが、それでも大幅な低下を見ています。Next.jsがReactに基づいているため、多くのウェブサイトがクライアントサイドレンダリングに依存しており、これがINPに悪影響を与える可能性があります。これは、開発者が使用するフレームワークのSSRとSSG機能を活用することを思い出させるものかもしれません。

今年の時点で、ホームページデータと比較できるセカンダリページが利用可能です。

{{ figure_markup(
  image="good-core-web-vitals-home-secondary-page.png",
  caption="CWVが良好なウェブサイトの割合、ページタイプ別に分類。",
  description="デスクトップとモバイルでのホームページとセカンダリページのCWV（Core Web Vitals）が良好なページの割合を示すバーチャート。ホームページについて、デスクトップページの45％が良好なCWVを持ち、モバイルページの38％が良好なCWVを達成しています。セカンダリページについて、デスクトップページの61％が良好なCWVを持ち、モバイルページの51％と比較されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1034225442&format=interactive",
  sheets_gid="1159394005",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

セカンダリページは、ホームページよりも大幅に良好なCWV結果を示しています。デスクトップセカンダリページでCWVが良好な割合は、ホームページよりも14パーセントポイント良好です。モバイルウェブサイトでは、その差は13パーセントポイントです。CWVデータのみを見ることで、どのような種類のパフォーマンスエクスペリエンスが良いかを特定するのは困難です。これらの側面（レイアウトシフト、読み込み、インタラクティビティ）を対応するセクションで探ります。

## 読み込み速度

人々はしばしばウェブサイトの読み込み速度を単一のメトリクスとして言及しますが、実際には読み込みエクスペリエンスは多段階のプロセスです。読み込み速度を構成するすべての側面を完全に捉える単一のメトリクスはありません。すべての段階がウェブサイトの速度に影響を与えます。

### Time to First Byte（TTFB）

[Time to First Byte](https://web.dev/articles/ttfb)（TTFB）は、ユーザーがページの読み込みを開始してから、ブラウザが応答の最初のバイトを受信するまでの時間を測定します。これには、リダイレクト時間、DNS検索、接続とTLSネゴシエーション、リクエスト処理などのフェーズが含まれます。接続とサーバー応答時間の遅延を短縮することで、TTFBを改善できます。800ミリ秒が良好なTTFBの閾値とされています—ただし、[いくつかの注意点があります！](https://web.dev/articles/ttfb#good-ttfb-score)

{{ figure_markup(
  image="good-time-to-first-byte.png",
  caption="TTFBが良好なウェブサイトの割合、デバイスと年で分類。",
  description="2020年から2024年のモバイルウェブサイトのTTFB（Time to First Byte）パフォーマンスを示す積み上げバーチャート、良好、改善が必要、悪いに分類。2024年、モバイルウェブサイトの42％が良好なTTFBを持ち、40％が改善が必要、19％が悪いでした。2023年、41％が良好、41％が改善が必要、19％が悪いでした。2022年、ウェブサイトの40％が良好なTTFBを持ち、41％が改善が必要、19％が悪いでした。2021年、39％が良好、42％が改善が必要、18％が悪いでした。2020年、モバイルウェブサイトの41％が良好なTTFBを持ち、41％が改善が必要、18％が悪いでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1925312055&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

過去5年間、良好なTTFBを持つモバイルウェブページの割合は安定しており、2021年の41％から2024年の42％となりました。TTFB改善が必要なページの割合は1％減少し、残念ながら、TTFBが悪いページの割合は同じままです。このメトリクスが大幅に変化していないため、接続速度やバックエンド遅延に大きな改善がなかったと結論できます。

### First Contentful Paint（FCP）

[First Contentful Paint（FCP）](https://web.dev/articles/fcp)は、ユーザーがコンテンツを見始める速さを示すのに役立つパフォーマンスメトリクスです。ユーザーが最初にページをリクエストしてから、最初のコンテンツが画面にレンダリングされるまでの時間を測定します。良好なFCPは1.8秒未満であるべきです。

{{ figure_markup(
  image="good-first-contentful-paint-2024.png",
  caption="FCPが良好なウェブサイトの割合、デバイスと年で分類。",
  description="時間の経過とともにデバイス別のFCP（First Contentful Paint）パフォーマンスが良好なウェブサイトの割合を示すバーチャート。2021年7月、デスクトップウェブサイトの60％が良好なFCPを持ち、モバイルウェブサイトの38％と比較されました。2022年6月までに、デスクトップウェブサイトの64％とモバイルウェブサイトの49％が良好なFCPを持ちました。2023年9月、デスクトップウェブサイトの63％が良好なFCPを持ち、モバイルウェブサイトの47％がそうでした。2024年6月までに、デスクトップウェブサイトの68％、モバイルウェブサイトの51％に割合が増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1058680176&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

FCPは過去数年間で改善を示しています。2023年にわずかな低下がありましたが、2024年にメトリクスが回復し、デスクトップウェブサイトで68％、モバイルウェブサイトで51％に達しました。全体的に、これは最初のコンテンツが読み込まれる速さの積極的な傾向を反映しています。TTFBメトリクスがほとんど変わらなかったことを考慮すると、FCPの改善はサーバーサイド最適化よりもクライアントサイドレンダリングによって推進されている可能性があります。

興味深いことに、ウェブサイトのパフォーマンスはFCPに影響する唯一の要因ではありません。研究<a hreflang="en" href="https://www.debugbear.com/blog/chrome-extension-performance-2021#impact-on-page-rendering-times">How Do Chrome Extensions Impact Browser Performance?</a>で、Matt Zeunertはブラウザ拡張機能がページ読み込み時間に大きく影響することを発見しました。多くの拡張機能は、ページが読み込みを開始するとすぐにコードの実行を開始し、first contentful paintを遅延させます。たとえば、一部の拡張機能はFCPを100ミリ秒から250ミリ秒に増加させることができます。

### Largest Contentful Paint（LCP）

[Largest Contentful Paint（LCP）](https://web.dev/articles/lcp)は、ビューポート内でもっとも大きな要素がどれだけ速く読み込まれるかを示すため、重要なメトリクスです。ベストプラクティスは、LCPリソースができるだけ早く読み込みを開始するようにすることです。良好なLCPは2.5秒未満であるべきです。

{{ figure_markup(
  image="largest-contentful-paint-scores-2024.png",
  caption="LCPが良好、改善が必要、悪いウェブサイトの割合、デバイス別に分類。",
  description="デバイス別のLCPパフォーマンスを示す積み上げバーチャート、良好（2.5秒未満）、改善が必要（2.5–4秒）、悪い（4秒超）に分類。デスクトップについて、ウェブサイトの72％が良好なLCPを持ち、20％が改善が必要、8％が悪いパフォーマンスです。スマートフォンについて、ウェブサイトの59％が良好なLCPを持ち、27％が改善が必要、14％が悪いパフォーマンスです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=2074458485&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

LCPは近年改善しており（2022年にLCPが良好なページが44％から2024年に54％へ）、CWVの全体的な積極的傾向に従っています。2024年、モバイルページの59％が良好なLCPスコアを達成しました。しかし、74％が良好なLCPを持つデスクトップサイトと比較すると、まだ大きなギャップがあります。この確立された傾向は、デバイス処理能力とネットワーク品質の違いによって説明されます。しかし、多くのウェブページがまだモバイル使用に最適化されていないことも強調されます。

{{ figure_markup(
  image="good-larges-contentful-paint-primary-secondary-pages.png",
  caption="LCPが良好なウェブサイトの割合、デバイスとページタイプで分類。",
  description="デスクトップとモバイルでのホームページとセカンダリページのLCPが良好なページの割合を示すバーチャート。ホームページについて、デスクトップページの63％が良好なLCPを持ち、モバイルページの53％が同じ結果を達成しています。セカンダリページについて、デスクトップページの82％が良好なLCPを持ち、モバイルページの72％と比較されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1404370023&format=interactive",
  sheets_gid="1159394005",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

ホームページとセカンダリページの比較は興味深い傾向を明らかにします：すべてのセカンダリページの72％が良好なLCPを持っており、これはホームページの結果よりも20％高いです。これは、ユーザーが通常最初にホームページをナビゲートし、初期読み込みがホームページで発生するためと考えられます。セカンダリページにナビゲートした後、多くのリソースはすでに読み込まれ、キャッシュされており、LCP要素のレンダリングが速くなります。もう1つの可能な理由は、ホームページがセカンダリページと比較して、ビデオや画像などのよりメディアリッチなコンテンツを含むことが多いことです。

#### LCPコンテンツタイプ

{{ figure_markup(
  image="largest-contentful-paint-top-content-types.png",
  caption="デバイス別に分類された上位3つのLCPコンテンツタイプ。",
  description="2024年のデスクトップとモバイルの上位LCPコンテンツタイプを示すバーチャート。デスクトップについて、ページの83.3％が画像をLCPコンテンツタイプとして持ち、モバイルページの73.3％が画像をLCPコンテンツとして持ちます。テキストはデスクトップでLCPコンテンツの16.3％、モバイルで26.3％を占めます。インライン画像は珍しく、デスクトップでLCPコンテンツの0.3％、モバイルで0.4％を占めます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1134330296&format=interactive",
  sheets_gid="1760287339",
  sql_file="lcp_resource_type.sql"
  )
}}

LCP要素のほとんど、つまりモバイルページの73％が画像です。興味深いことに、この割合はデスクトップページで10％高くなっています。テキストコンテンツでは状況が逆転しています。デスクトップと比較して、10％多くのモバイルウェブページがテキストをLCP要素として使用しています。この違いは、デスクトップウェブサイトがより大きなビューポートサイズと一般的により高いパフォーマンスにより、より多くの視覚的コンテンツに対応できるためと考えられます。

#### LCPサブパーツ

LCP要素が完全にレンダリングされる前に、処理のいくつかの段階が発生する必要があります：

- **Time to First Byte**（TTFB）、これはサーバーが最初のリクエストへの応答を開始するのにかかる時間です。
- **Resource Load Delay**、これはTTFB後にブラウザがLCPリソースの読み込みを開始するまでの時間です。テキストベースの要素やインライン画像（data URI）などのインラインリソースとして発生するLCP要素は、0ミリ秒の読み込み遅延を持ちます。外部画像のように別のアセットをダウンロードする必要があるものは、読み込み遅延を経験する可能性があります。
- **Resource Load Duration**、これはLCPリソースの読み込みにかかる時間を測定します；リソースが不要な場合、この段階も0ミリ秒です。
- **Element Render Delay**、これはリソースの読み込みが完了してからLCP要素のレンダリングが完了するまでの時間です。

記事[Common Misconceptions About How to Optimize LCP](https://web.dev/blog/common-misconceptions-lcp#lcp_sub-part_breakdown)で、Brendan Kennyは最近のCrUXデータを使用してLCPサブパーツの内訳を分析しました。

{{ figure_markup(
  image="median-subpart-p75s.png",
  caption="各LCPサブパーツで費やされた時間、良好、改善が必要、悪いのLCPバケットにグループ化。",
  description="2024年7月のモバイルとデスクトップにわたる、良好、改善が必要、悪いp75 LCPのオリジンp75 LCPサブパーツの中央値を示すバーチャート。良好なp75 LCPについて、TTFBは600ミリ秒、画像読み込み遅延は350ミリ秒、画像読み込み期間は160ミリ秒、レンダリング遅延は230ミリ秒です。改善が必要なp75 LCPについて、TTFBは1360ミリ秒、画像読み込み遅延は720ミリ秒、画像読み込み期間は270ミリ秒、レンダリング遅延は310ミリ秒です。悪いp75 LCPについて、TTFBは2270ミリ秒、画像読み込み遅延は1290ミリ秒、画像読み込み期間は350ミリ秒、レンダリング遅延は360ミリ秒です。"
  )
}}

研究では、画像読み込み期間がLCP時間に与える影響がもっとも少なく、LCPが悪いウェブサイトの75パーセンタイルでわずか350ミリ秒であることが示されました。画像サイズ削減などのリソース読み込み期間最適化技術がしばしば推奨されますが、LCPが悪いサイトでも、他のLCPサブパーツほど多くの時間節約を提供しません。

TTFBは外部リソースへのネットワークリクエストのため、すべてのLCPサブパーツの中でもっとも大きな部分です。LCPが悪いウェブサイトはTTFBだけで2.27秒を費やしており、これは良好なLCPの閾値（2.5秒）とほぼ同じ長さです。TTFBセクションで見たように、良好なTTFBを持つウェブサイトの割合にはあまり改善がなく、このメトリクスがLCP最適化の大きな機会を提供することを示しています。

驚くことに、ウェブサイトはLCPステータスに関係なく、読み込み期間よりもリソース読み込み遅延により多くの時間を費やしています。これにより、読み込み遅延は最適化努力の良い候補となります。読み込み遅延を改善する1つの方法は、LCP要素ができるだけ早く読み込みを開始するようにすることで、これはLCP静的発見可能性のセクションで詳しく探ります。

今年、別のリアルユーザーモニタリングソースからのLCPサブパーツデータを分析しました：RUMvision。RUMvisionは異なるウェブサイト集団を持っていますが、より大きなCrUXウェブサイト集団と比較することは興味深いです。RUMvisionのようなパフォーマンス監視ツールを使用するウェブサイトは、CrUXで表される平均的なウェブサイトよりもパフォーマンス最適化の機会について多くの洞察を持つべきであると仮定します。当然、2つの異なるデータセットからのLCPサブパーツ結果はいくつかの違いを示します。

{{ figure_markup(
  image="largest-contentful-paint-subparts.png",
  caption="パーセンタイル別の各LCPサブパーツで費やされた時間。",
  description="異なるパーセンタイルにわたるLCPサブパーツの分布をミリ秒（ms）で示すバーチャート。10パーセンタイルでは、すべてのサブパーツが最小値を持ちます。25パーセンタイルでは、リソースTTFBと読み込み遅延は100ミリ秒未満のままです。50パーセンタイルでは、リソースTTFBが約200ミリ秒に増加し、読み込み遅延、読み込み期間、レンダリング遅延がわずかに増加します。75パーセンタイルでは、リソースTTFBが500ミリ秒を超え、レンダリング遅延も増加を示します。90パーセンタイルでは、リソースTTFBは1500ミリ秒を超え、レンダリング遅延は600ミリ秒以上に上昇し、読み込み遅延と読み込み期間も増加します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=249678580&format=interactive",
  sheets_gid="1987931132"
  )
}}

RUMvisionデータによると、TTFBは他のLCPサブパーツと比較してLCP時間へのもっとも大きな貢献者でもあります。しかし、他のサブパーツの結果は異なります。レンダリング遅延はLCPへの2番目に大きな貢献者で、184ミリ秒かかります。75パーセンタイルで、レンダリング遅延は443ミリ秒に成長します。これは、LCP読み込み遅延が2番目に大きなサブパーツであるCrUXデータセットとは異なる傾向を反映しています。

通常、LCP要素がまだDOMに追加されていない場合、LCP要素のレンダリングには長時間かかります—これは次のセクションで探るクライアントサイド生成コンテンツの一般的な問題です。また、長いタスクによってブロックされたメインスレッドも遅延に貢献する可能性があります。さらに、`<head>`内のスタイルシートや同期スクリプトなどのレンダリングブロッキングリソースがレンダリングを遅延させる可能性があります。

さまざまなデータセットにわたるウェブサイトが直面する異なるLCP課題を観察することは興味深いです。CrUXデータセットからの平均的なウェブサイトが画像読み込み遅延に苦労する一方で、RUMvisionデータセットからのウェブサイトはしばしばレンダリング遅延の問題に直面します。それにもかかわらず、すべてのウェブサイトはReal User Monitoring（RUM）を持つパフォーマンス監視ツールの使用から恩恵を受けることができます。これらのツールは、実際のユーザーが経験するパフォーマンス問題へのより深い洞察を提供するためです。

#### LCP静的発見可能性

LCPリソース読み込み遅延を最適化するもっとも効果的な方法の1つは、リソースができるだけ早く発見できるようにすることです。初期HTMLドキュメントでリソースを発見可能にすると、LCPリソースがより早くダウンロードを開始できます。

{{ figure_markup(
  caption="LCP要素が静的に発見可能でないモバイルページの割合。",
  content="35%",
  classes="big-number",
  sheets_gid="200850285",
  sql_file="lcp_preload_discoverable.sql"
)
}}

残念ながら、モバイルウェブサイトの35％はドキュメント内で静的に発見可能なLCP要素を持っていません。これは2022年に見た39％からのわずかな改善ですが、まだLCPパフォーマンスの重要な阻害要因です。

以下のセクションで探るように、ウェブサイトがLCPリソースを静的に発見可能でなくする主な方法は3つあります：遅延読み込み、CSS背景画像、クライアントサイドレンダリングです。

#### LCP遅延読み込み

LCPリソース発見可能性への主要な障害は、LCPリソースの遅延読み込みです。全体的に、遅延読み込み画像は、重要でないリソースの読み込みをビューポートの近くまで延期するために使用されるべき有用なパフォーマンス技術です。しかし、LCP画像で遅延読み込みを使用すると、ブラウザが素早く読み込むのを遅らせてしまいます。そのため、LCP要素には遅延読み込みを使用すべきではありません。

{{ figure_markup(
  caption="画像ベースのLCPでネイティブまたはカスタム遅延読み込みを使用するモバイルページの割合。",
  content="16%",
  classes="big-number",
  sheets_gid="1048885241",
  sql_file="lcp_lazy.sql"
)
}}

良いニュースは、2024年により少ないウェブサイトがこのパフォーマンスアンチパターンを使用していることです。2022年、モバイルウェブサイトの18％がLCP画像を遅延読み込みしていました。2024年までに、これは16％に減少しました。

使用される特定の遅延読み込み技術について、モバイルウェブサイトの9.5％が`loading=lazy`属性でLCP画像をネイティブ遅延読み込みしています。これは2022年に見た9.8％のサイトと非常に似ています。しかし、最大の改善はカスタムアプローチから来ました。今年、モバイルウェブサイトの6.7％がカスタムアプローチを使用しており、たとえば`data-src`属性の背後にLCP画像ソースを隠すものがあり、これは2022年の8.8％から減少しています。

`loading=lazy`でのLCP画像の`src`属性は技術的に設定されており、したがって静的HTMLで発見可能であるため、前のセクションの静的発見可能性の数値には含めていないことに注意してください。しかし、ネイティブ遅延読み込み画像は確実にリソース読み込み遅延に貢献しており、次に探るように、ソースがCSSやJavaScriptによって設定される画像とは多少異なる方法でですが。

#### CSS背景画像

{{ figure_markup(
  image="largest-contentful-paint-non-discoverable.png",
  caption="LCPが静的に発見可能でなく、指定されたリソースから開始されるページの割合。",
  description="デスクトップとモバイルについて、発見不可能なLCP（Largest Contentful Paint）の開始者をリソースタイプ別に分類して示すバーチャート。デスクトップについて、ページの38％が発見不可能なLCPの開始者としてHTMLを持ち、モバイルについてはこの数値は33％です。CSSはデスクトップページで発見不可能なLCPの11％、モバイルで9％を担当しています。未知のリソースタイプはデスクトップで発見不可能なLCPの5％、モバイルで4％を占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=427707611&format=interactive",
  sheets_gid="1131647963",
  sql_file="lcp_initiator_type.sql"
  )
}}

また、LCP要素をCSS背景画像として開始するウェブサイトは、CSSファイルが処理されるまでLCP静的発見を遅らせます。データは、モバイルページの9％がCSSからLCPリソースを初期化することを示しています。2022年と比較して、このメトリクスは変わっていません。

#### 動的に追加された画像

発見不可能なLCP要素のもう1つの一般的な理由は、動的に追加された画像です。これらの画像は、初期HTMLが読み込まれた後にJavaScriptを通じてページに追加され、HTMLドキュメントスキャン中に発見不可能になります。

以下のチャートはクライアントサイド生成コンテンツの分布を示しています。初期HTMLと最終HTML（JavaScript実行後）を比較し、違いを測定します。クライアントサイド生成コンテンツの割合が増加するにつれて、良好なLCPを持つウェブサイトの割合がどう変化するかを表示します。

{{ figure_markup(
  image="good-largest-contentful-paint-client-side-generated-content.png",
  caption="良好なLCPを持つウェブサイトの割合対ページ上のクライアントサイド生成コンテンツの割合。",
  description="デスクトップとモバイル両方について、クライアントサイド生成HTMLの割合と比較した良好なLCPを持つオリジンの割合を示すラインチャート。デスクトップについて、良好なLCPを持つオリジンの割合は、0-10％のクライアントサイド生成HTMLを持つページで約75％から始まり、比較的安定を保ち、40-50％のクライアントサイドHTML使用付近でわずかにピークを迎えた後、90-100％の範囲で約65％まで徐々に低下します。モバイルについて、良好なLCPの割合は0-10％の範囲で約60％から始まり、似た傾向を示し、30-40％の範囲でわずかにピークを迎えた後、90-100％のクライアントサイドHTML使用で約45％まで急激に低下します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=750231640&format=interactive",
  sheets_gid="829333856",
  sql_file="inp_long_tasks.sql"
  )
}}

クライアントサイド生成コンテンツの量が70％に達するまで、良好なLCPを持つページの割合はモバイルデバイスで約60％にとどまります。この閾値の後、良好なLCPを持つウェブサイトの割合は40％で終わるまで、より速い速度で低下し始めます。これは、サーバーサイドとクライアントサイド生成コンテンツの組み合わせがLCP要素がレンダリングされる速さに大きく影響しないことを示唆しています。しかし、ウェブサイトを完全にクライアントサイドでレンダリングすることは、LCPに大きな悪影響を与えます。

#### LCP優先順位付け

LCP画像の読み込み遅延を最適化するもっとも効果的な方法の1つは、`fetchpriority=high`属性を使用して宣言的に優先順位付けすることです。LCPリソースがブラウザのプリロードスキャナーによって静的に発見可能であっても、列に他のより高い優先度のリソースがある場合、まだ即座に読み込みを開始しない可能性があります。画像は通常高優先度リソースとは見なされないため、ブラウザにこのヒントを提供することで、LCPリソースの優先度を適切に調整し、より早く読み込んで読み込み遅延フェーズを短縮できます。

{{ figure_markup(
  caption="LCP画像で`fetchpriority=high`を使用するモバイルページの割合。",
  content="15%",
  classes="big-number",
  sheets_gid="731441901",
  sql_file="lcp_async_fetchpriority.sql"
)
}}

LCP画像優先順位付けの採用は2024年にモバイルウェブサイトの15％に急上昇し、2022年のわずか0.03％から上昇しました！この大きな飛躍は、WordPressが2023年に`fetchpriority`の<a hreflang="en" href="https://make.wordpress.org/core/2023/07/13/image-performance-enhancements-in-wordpress-6-3/">コアサポート</a>を実装したことに大部分起因しています。

このような急速な成長を見ることは素晴らしいことですが、この影響力のある1行最適化を活用できるより多くのサイトにはまだ大きな余地があります。

#### LCPサイズ

[LCPサブパーツ](#lcpサブパーツ)に関するCrUXとRUMvisionのデータは、リソース読み込み期間が遅いLCPの主なボトルネックになることが稀であることを示しました。しかし、LCPリソースのサイズや形式などの主要な最適化要因を分析することは依然として価値があります。

{{ figure_markup(
  image="largest-contentful-paint-image-sizes.png",
  caption="LCP画像サイズの分布、デバイスタイプ別に分類。",
  description="デスクトップとモバイルページのLCP画像サイズの分布をキロバイト（KB）で測定したヒストグラム。モバイルについて、ページの48％が100から200KBの間のLCP画像サイズを持ち、デスクトップページの18％がこの範囲に該当します。デスクトップについて、ページの30％が0から100KBの間のLCP画像を持ち、モバイルの1％と比較されます。200から300KBの範囲で、デスクトップページの9％とモバイルページの5％がLCP画像を持ちます。画像サイズが増加するにつれて割合は徐々に減少し、700KBより大きなLCP画像を持つページはわずかです。最高範囲で、デスクトップとモバイルページの両方の8％が1000KB以上のLCP画像を持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=164375992&format=interactive",
  sheets_gid="1329122831",
  sql_file="lcp_bytes_histogram.sql"
  )
}}

2024年、モバイルウェブサイトの48％が100KB以下のLCP画像を使用しました。ただし、モバイルページの8％についてはLCP要素サイズが1000KBを超えています。

これは、画像最適化によって節約できる無駄なキロバイト数も報告する<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/blob/main/core/audits/byte-efficiency/uses-optimized-images.js">Lighthouse audit on unoptimized images</a>と一致しています。

{{ figure_markup(
  image="largest-contentful-paint-images-wasted-kb.png",
  caption="LCP画像での無駄なキロバイトの分布。",
  description="パーセンタイル別のデスクトップとモバイルのLCP画像での無駄なキロバイトの分布を示すバーチャート。10、25、50パーセンタイルで、デスクトップとモバイルページの両方が0無駄キロバイトを持ちます。75パーセンタイルで、デスクトップページは20キロバイトを無駄にし、モバイルページは10キロバイトを無駄にします。90パーセンタイルで、デスクトップページは190キロバイトを無駄にし、モバイルページは128キロバイトを無駄にします。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=321466279&format=interactive",
  sheets_gid="1984265626",
  sql_file="lcp_wasted_bytes.sql"
  )
}}

監査結果は、中央値のウェブサイトがLCP画像で0KBを無駄にしている、つまり最適化された画像を提供していることを示しています。これにより、多くのサイトがLCPリソースを効果的に最適化している一方で、一部はまだ改善が必要であるという結論に至ります。

寸法のリサイズと圧縮の増加によって画像サイズを削減できます。画像サイズを削減するもう1つの方法は、より良い圧縮アルゴリズムを持つWebPやAVIFなどの新しい画像形式を使用することです。

{{ figure_markup(
  image="largest-contentful-paint-image-file-format.png",
  caption="LCP画像に指定された画像ファイル形式を使用するページの割合。",
  description="デスクトップとモバイルのLCP（Largest Contentful Paint）画像形式の分布を示すバーチャート。JPGがもっとも一般的な形式で、デスクトップページの61％と類似した割合のモバイルページで使用されています。PNGは2番目にもっとも一般的な形式で、ページの26％で使用されています。WebPが7％で続き、MP4、SVG、GIF、AVIFなどの他の形式はページの2％未満で使用されています。ICO、HEIC、HEIF形式はほとんど使用されておらず、それらの割合はデスクトップとモバイル両方で0％に四捨五入されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=2086275423&format=interactive",
  sheets_gid="240287365",
  sql_file="lcp_format.sql"
  )
}}

JPGとPNGは依然として合計87％ともっとも高い採用割合を持っていますが、WebPとAVIF形式の両方が採用率を増加させています。2022年と比較して、WebP画像形式の使用は[4%](../2022/performance#LCPフォーマット)から7％に増加しました。また、AVIF使用は0.1％から0.3％にわずかに増加しました。<a hreflang="en" href="https://webstatus.dev/?q=avif">Baseline</a>によると、AVIF形式は主要ブラウザで新しく利用可能になったため、将来的により高い採用を見ることを期待しています。

### 読み込み速度の結論

- 良好なFCPとLCPを持つウェブサイトの割合は改善しましたが、TTFBは大きな変化を示しませんでした。
- 遅いLCPの1つの原因は、LCP要素の遅延読み込みです。このアンチパターンの使用は減少しましたが、15％のウェブサイトがまだこのテストに失敗しており、LCP要素の遅延読み込み除去から恩恵を受けることができます。
- LCP要素について、AVIFやWebPなどの現代的な画像形式の採用が成長しています。

## インタラクティビティ

ウェブサイトのインタラクティビティとは、ユーザーがページ上のコンテンツ、機能、または要素とどの程度関わり、反応できるかの度合いを指します。インタラクティビティの測定には、クリック、タップ、スクロールなどのさまざまなユーザーインタラクション、およびフォーム送信、ビデオ再生、ドラッグアンドドロップ機能などのより複雑なアクションのパフォーマンス評価が含まれます。

### Interaction to Next Paint（INP）

[Interaction to Next Paint（INP）](https://web.dev/articles/inp)は、セッション中にページで行われたすべてのインタラクションを観察し、（ほとんどのサイトで）最悪の遅延を報告することによって計算されます。インタラクションの遅延は、ユーザーがインタラクションを開始してから、ブラウザが次にフレームをペイントできる瞬間まで、インタラクションを駆動するイベントハンドラーのグループの最長の単一期間で構成されます。

オリジンが「良好な」INPスコアを受けるには、すべてのセッションの少なくとも75％が200ミリ秒以下のINPスコアを必要とします。INPスコアは、ページ上のすべてのインタラクションでもっとも遅い、またはもっとも遅いに近いインタラクション時間です。詳細については、[INPの計算方法の詳細](https://web.dev/articles/inp#good-score)を参照してください。

{{ figure_markup(
  image="interaction-to-next-paint-2024.png",
  caption="デバイス別のINPパフォーマンスの分布。",
  description="デバイス別のINPパフォーマンスを示す積み上げバーチャート、デスクトップとスマートフォンが良好（200ミリ秒未満）、改善が必要（200–500ミリ秒）、悪い（500ミリ秒超）に分類されています。デスクトップについて、ウェブサイトの97％が良好なINPを持ち、2％が改善が必要、1％未満が悪いパフォーマンスです。スマートフォンについて、ウェブサイトの74％が良好なINPを持ち、24％が改善が必要、2％が悪いパフォーマンスです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=667078190&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

2024年、モバイルの74％とデスクトップの97％のウェブサイトが良好なINPを持っていました。興味深いことに、モバイルとデスクトップの間のギャップは巨大で、つまり20％以上です。

モバイルでパフォーマンスが弱い主な理由は、その低い処理能力としばしば悪いネットワーク接続です。Alex Russellの記事「<a hreflang="en" href="https://infrequently.org/2022/12/performance-baseline-2023/">The Performance Inequality Gap</a>」（2023年）は、ハイエンド対ローエンドデバイスの余裕によって引き起こされる拡大するパフォーマンス不平等ギャップの問題を提起します。ハイエンドデバイスの価格が上昇するにつれて、それらを買える余裕のあるユーザーが少なくなり、不平等ギャップが拡大します。

{{ figure_markup(
  image="good-interaction-to-next-paint.png",
  caption="デバイス別の良好なINPスコア。",
  description="3年間にわたるデバイス（デスクトップとモバイル）別の良好なINPパフォーマンスを持つウェブサイトの割合を示すバーチャート。2022年、デスクトップウェブサイトの95％が良好なINPを持ち、モバイルウェブサイトの55％が良好なINPを達成しました。2023年、良好なINPを持つウェブサイトの割合はデスクトップで97％、モバイルで64％に改善しました。2024年までに、デスクトップウェブサイトの97％が良好なINPパフォーマンスを維持し、モバイルはさらに74％に改善しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=416359271&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

INPメトリクスはFIDよりも悪い結果を表示しますが、過去3年間にわたって積極的な傾向がありました。良好なINPを持つモバイルページの割合は、2022年の55％から2024年の74％に増加しました。これは大幅な増加であり、何に起因するかを正確に確信できませんが、この変化のいくつかの潜在的な推進要因を考えることができます。

最初のものは認識かもしれません。INPの導入とそれがFIDを置き換えるという発表により、多くのチームが全体的なCWVスコアと検索ランキングに与える影響を実感しました。それが、低いINPスコアに貢献したサイトの部分を修正する方向に積極的に取り組むことを促したかもしれません。2番目の推進要因は技術の通常の進歩かもしれません。上記に表示されたINPデータが実際のユーザーから来ているため、ユーザーのデバイスとネットワーク接続が年月とともにわずかに改善し、より良いサイトインタラクティビティを提供した可能性もあります。3番目の（そして恐らく最大の？）推進要因は、ブラウザ自体への改善です（特に我々の洞察を提供するChromeに）。Chromeチームは過去2年間で<a hreflang="en" href="https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/speed/metrics_changelog/inp.md">INPに影響する多くの改善</a>を行いました。

ランク別のモバイルINPメトリクスは興味深い傾向を明らかにします。[2022年の章](../2022/performance#ランク別INP)では、ウェブサイトの人気が高いほど、パフォーマンス最適化が多く施されており、より良いパフォーマンスにつながるだろうと推測していました。しかし、INPに関しては、逆のことが当てはまるようです。

{{ figure_markup(
  image="interaction-to-next-paint-score-mobile-2024.png",
  caption="ランク別に分類されたモバイルデバイスでのINPパフォーマンス。",
  description="ウェブサイトランク別のモバイルINPパフォーマンスを示す積み上げバーチャート、良好（200ミリ秒未満）、改善が必要（200-500ミリ秒）、悪い（500ミリ秒超）に分類。上位1,000のウェブサイトについて、53％が良好なINPを持ち、41％が改善が必要、6％が悪いパフォーマンスです。上位10,000のウェブサイトについて、49％が良好な範囲にあり、44％が改善が必要、7％が悪いです。上位100,000では、51％が良好、43％が改善が必要、6％が悪いです。上位1,000,000のウェブサイトについて、61％が良好なINPを持ち、35％が改善が必要、4％が悪いです。ランクが上位10,000,000のウェブサイトまで増加すると、73％が良好、24％が改善が必要、3％が悪いです。最後に、上位100,000,000のウェブサイトについて、74％が良好なINPを持ち、24％が改善が必要、2％が悪いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=296559964&format=interactive",
  sheets_gid="355582610",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

上位1,000ランクのウェブサイトで良好なINPを持つサイトは、全ウェブサイトの結果と比較して少なくなっています。たとえば、上位1,000のウェブサイトの53％が良好なINPスコアを持っているのに対し、全ウェブサイトのはるかに大きな割合、つまり74％がこの閾値を満たしています。

これは、もっとも訪問されるウェブサイトがしばしばより多くのユーザーインタラクションと複雑な機能を持っているためかもしれません。論理的に、インタラクティブなeコマースサイトのINPは、シンプルで静的なブログとは異なるでしょう。

{{ figure_markup(
  image="good-interaction-to-next-paint-home-secondary-page.png",
  caption="デバイス別のホームページとセカンダリページでの良好なINPパフォーマンス。",
  description="ホームページとセカンダリページで良好なINPを持つページの割合を示すバーチャート、デスクトップとモバイルのパフォーマンスで分離。ホームページについて、デスクトップページの96％が良好なINPを持ち、モバイルページの73％が良好なINPを達成しています。セカンダリページについて、デスクトップページの96％も良好なINPを持ち、モバイルページの72％がこのパフォーマンスレベルに達しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1483510539&format=interactive",
  sheets_gid="1159394005",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

FCPやLCPなどの他のパフォーマンスメトリクスとは異なり、良好なINPを持つセカンダリページの割合はホームページの結果と差がありません。これは、INPが読み込み速度ほどキャッシュの影響を受けないためと考えられます。

#### INPサブパーツ

Interaction to Next Paintメトリクスは、3つの主要なサブパーツに分解できます：

- **Input Delay**：インタラクションが発生した時点でキューにすでにあったタスクの処理を完了するために費やされた時間
- **Processing Time**：ユーザーがインタラクションした要素に添付されたイベントハンドラーの処理に費やされた時間
- **Presentation Delay**：変更された場合の新しいレイアウトの計算と画面での新しいピクセルのペイントに費やされた時間

ウェブサイトのインタラクティビティを最適化するには、すべてのサブパーツの期間を特定することが重要です。

{{ figure_markup(
  image="interaction-to-next-paint-subparts-rum-vision.png",
  caption="パーセンタイル別のINPサブパーツ。",
  description="パーセンタイル別のINPサブパーツの分布をミリ秒（ms）で示すバーチャート。10パーセンタイルでは、すべてのサブパーツ（入力遅延、処理時間、プレゼンテーション遅延）が最小です。25パーセンタイルでは、値はわずかに増加しますが10ミリ秒以下にとどまります。50パーセンタイルでは、入力遅延と処理時間は控えめなままですが、プレゼンテーション遅延は20ミリ秒程度に達します。75パーセンタイルでは、入力遅延は50ミリ秒程度まで増加し、処理時間とプレゼンテーション遅延も上昇します。90パーセンタイルでは、入力遅延は150ミリ秒程度に達し、処理時間とプレゼンテーション遅延の両方が100ミリ秒を超えます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=226800794&format=interactive",
  sheets_gid="731456372",
  )
}}

RUMvisionからのINPサブパーツ期間分布データは、プレゼンテーション遅延（36ミリ秒）が中央値INPへの貢献がもっとも大きいことを示しています。パーセンタイルが増加するにつれて、入力遅延と処理時間が長くなります。75パーセンタイルでは、入力遅延が37ミリ秒、処理遅延が56ミリ秒に達します。90パーセンタイルまでには、入力遅延が155ミリ秒まで跳ね上がり、これが悪いINPへの最大の貢献要因となります。入力遅延を最適化する1つの方法は、ロングタスクを避けることで、これについてはロングタスクセクションで探ります。

### ロングタスク

INPのサブパーツの1つは入力遅延で、ロングタスクを含むさまざまな要因により本来よりも長くなる可能性があります。[タスク](https://web.dev/articles/optimize-long-tasks#what-is-task)は、ブラウザが実行する個別の作業単位で、JavaScriptがしばしばタスクの最大のソースです。タスクが50ミリ秒を超えると、ロングタスクと見なされます。これらのロングタスクは、ユーザーインタラクションへの応答に遅延を引き起こし、インタラクティビティパフォーマンスに直接影響します。

ロングタスクとINPの同一ソースデータが不足しているため、それらを関連付けないことにしました。しかし、RUMvisionのデータを使用して平均ロングタスク期間を探ります。

{{ figure_markup(
  image="long-task-duration.png",
  caption="デバイス別に分類されたタスク期間。",
  description="パーセンタイルとデバイスタイプ別のタスク期間の分布をミリ秒（ms）で示すバーチャート。25パーセンタイルでは、タスク期間はデスクトップで61ミリ秒、モバイルで71ミリ秒です。50パーセンタイルでは、デスクトップで90ミリ秒、モバイルで108ミリ秒に増加します。75パーセンタイルでは、タスク期間はデスクトップで161ミリ秒、モバイルで187ミリ秒です；90パーセンタイルでは、デスクトップで331ミリ秒、モバイルで377ミリ秒に達します。この分布は、25パーセンタイルから90パーセンタイルに移行するにつれてタスク期間が大幅に長くなることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=688921860&format=interactive",
  sheets_gid="1272522211"
  )
}}

タスク期間分布は、デスクトップで90ミリ秒、モバイルで108ミリ秒の中央値タスク期間を示しており、これは50ミリ秒未満のベストプラクティス推奨値の2倍です。25％未満のウェブサイトが50ミリ秒未満の最適なタスク期間を持っています。また、すべてのパーセンタイルにおいて、モバイルサイトのタスク期間がデスクトップサイトよりも長く、パーセンタイルが増加するにつれてギャップが拡大することがわかります。90パーセンタイルでは、デバイスタイプ間の平均タスク期間の間に46ミリ秒の差があります。これは、モバイルと比較してデスクトップでより良い結果を示すINPスコアとよく相関しています。

タスク期間データは<a hreflang="en" href="https://www.w3.org/TR/longtasks-1/">Long Tasks API</a>を使用して取得されました。これは、パフォーマンス問題について有用なデータを提供しますが、動作の重さを正確に測定することについては制限があります。ロングタスクがいつ発生し、どれくらい続くかのみを識別します。レンダリングなどの重要なタスクを見落とす可能性があります。これらの制限により、次のセクションでは、より詳細な洞察を提供するLong Animation Frames APIを探ります。

#### ロングアニメーションフレーム

[Long Animation Frames (LoAF)](https://developer.chrome.com/docs/web-platform/long-animation-frames)は、作業とレンダリングがメインスレッドをブロックするときを追跡することで、動作の重さと悪いINPを識別するためのパフォーマンスタイムラインエントリです。LoAFは、Long Tasks APIのような個別のタスクの代わりにアニメーションフレームを追跡します。ロングアニメーションフレームは、レンダリングアップデートが50ミリ秒を超えて遅延する場合です（Long Tasks APIの閾値と同じ）。これは、INPパフォーマンスのボトルネックを引き起こすスクリプトを見つけるのに役立ちます。このデータにより、LoAFの原因となるスクリプトのカテゴリーに基づいてINPパフォーマンスを分析できます。

{{ figure_markup(
  image="interaction-to-next-paint-script-categories-desktop-rum-vision.png",
  caption="デスクトップでのスクリプトカテゴリー別INPパフォーマンスの分布。",
  description="デスクトップ用LOAFスクリプトカテゴリー全体のINPの分布を示す積み上げバーチャート、ミリ秒（ms）で測定。ユーザーレビュー、SMS・メール、アナリティクススクリプトがもっとも良いパフォーマンスを示し、INPのほとんどが良好な範囲にあります。タグマネージャーと同意プロバイダースクリプトは中間範囲のINPが多く、一部が悪いカテゴリーに分類されます。広告、その他、ユーザー行動スクリプトはパフォーマンスが悪く、INPの大部分が悪い範囲に分類されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1975914925&format=interactive",
  sheets_gid="947269170",
  )
}}

{{ figure_markup(
  image="interaction-to-next-paint-script-categories-mobile-rum-vision.png",
  caption="モバイルでのスクリプトカテゴリー別INPパフォーマンスの分布。",
  description="モバイル用LOAFスクリプトカテゴリー全体のINPの分布を示す積み上げバーチャート、ミリ秒（ms）で測定。ソーシャルスクリプトについて、ほとんどが良好な範囲にあり、悪い範囲はわずかです。ビデオとタグマネージャースクリプトも良好な範囲が大部分を占めますが、中間範囲の部分が大きくなっています。サイト検索と広告スクリプトはより均等な分布を持ち、中間範囲に重要な部分があり、悪い範囲も一部含まれます。開発者ユーティリティ、その他、ユーザー行動スクリプトはパフォーマンスが悪く、ほとんどが悪い範囲に分類されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1978447282&format=interactive",
  sheets_gid="947269170",
  )
}}

モバイルとデスクトップデバイスで遅いINPスコアへの貢献がもっとも大きい上位2つのカテゴリーは、ユーザー行動スクリプト（モバイルの37％、デスクトップの60％のページが良好なINP）とCDN/ホスティング（モバイルの50％、デスクトップの65％のページが良好なINP）です。

ユーザー行動スクリプトには、`script.hotjar.com`、`smartlook.com`、`newrelic.com`などのホストからのスクリプトが含まれます。これらのツールはユーザーについて価値ある洞察を提供しますが、我々のデータは、ウェブサイトのインタラクションを遅くすることでユーザーエクスペリエンスを大幅に悪化させる可能性があることを示しています。

CDNとホスティングスクリプトカテゴリーの例は、`cdn.jsdelivr.net`、`ajax.cloudflare.com`、`cdnjs.cloudflare.com`、`cdn.shopify.com`、`sdk.awswaf.com`、`cloudfront.net`、`s3.amazonaws.com`などのドメインから来ています。CDNがもっとも悪いINP結果を持つカテゴリーに含まれることは議論の余地があるように思えます。なぜなら、CDNは通常、サーバー負荷を減らし、ユーザーによりコンテンツを速く配信するパフォーマンス最適化技術として推奨されるからです。しかし、このカテゴリーに含まれるCDNは通常、ファーストパーティまたはサードパーティのJavaScriptリソースを配信し、これがLoAFに貢献してインタラクティビティに悪影響を与えます。

モバイルデバイスでは、同意プロバイダーがINPに重要な影響を与えるようで、それらを使用するとモバイルページの53％のみが良好なINPを持つことになります。このカテゴリーは、`consentframework.com`、`cookiepro.com`、`cookiebot.com`、`privacy-mgmt.com`、`usercentrics.eu`などのプロバイダーで構成されます。デスクトップデバイスでは、同意プロバイダースクリプトははるかに良い結果を示し、つまり76％のページが良好なINPを持ちます。この違いは、デスクトップデバイスのより強力なプロセッサーによるものと考えられます。

注目すべきは、パフォーマンス監視ツールも含む監視カテゴリーが、悪いINP結果へのもっとも少ない影響の1つを持つことです。これは、ウェブパフォーマンス監視ツールの使用を支持する良い論拠です。これらは、インタラクティビティパフォーマンスに大きく影響することなく、価値あるウェブパフォーマンスの洞察を提供するためです。

### Total Blocking Time（TBT）

[Total Blocking Time（TBT）](https://web.dev/articles/tbt)は、First Contentful Paint（FCP）後に、メインスレッドが入力応答性を阻害するのに十分な時間ブロックされた総時間を測定します。

TBTはラボメトリクスで、CrUXやRUMvisionなどのリアルユーザーモニタリングでのみ収集できるINPなどのフィールドベースの応答性メトリクスの代理として使用されることがよくあります。<a hreflang="en" href="https://colab.research.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">ラボベースのTBTとフィールドベースのINP</a>は相関があり、TBTの結果は一般的にINPの傾向を反映します。200ミリ秒未満のTBTが良好と見なされますが、ほとんどのモバイルウェブサイトはこの目標を大幅に超えています。

{{ figure_markup(
  image="total-blocking-time-2024.png",
  caption="パーセンタイル別のページあたりのTBT。",
  description="パーセンタイル別のページあたりのTotal Blocking Time（TBT）の分布をミリ秒（ms）で示すバーチャート。10パーセンタイルでは、デスクトップとモバイルのTBTは両方とも0ミリ秒近くです。25パーセンタイルでは、デスクトップのTBTは84ミリ秒、モバイルは417ミリ秒です。50パーセンタイルでは、デスクトップは67ミリ秒のTBTを持ち、モバイルは1,209ミリ秒まで大幅に上昇します。75パーセンタイルでは、デスクトップは282ミリ秒に達し、モバイルは2,990ミリ秒です。最後に、90パーセンタイルでは、デスクトップのTBTは718ミリ秒で、モバイルは5,955ミリ秒まで上昇します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1525715716&format=interactive",
  sheets_gid="89045350",
  sql_file="inp_tbt.sql"
  )
}}

モバイルの中央値TBTは1,209ミリ秒で、これはベストプラクティスの6倍高い値です。対照的に、デスクトップウェブサイトは、中央値TBTがわずか67ミリ秒と、はるかに良いパフォーマンスを示しています。ラボ結果はエミュレートされた低電力デバイスと低速ネットワークを使用するため、実際のデバイスとネットワーク条件は変化する可能性があり、実際のユーザーデータを反映していない可能性があることを強調することが重要です。しかし、それを念頭に置いても、これらの結果は、90パーセンタイルではモバイルデバイスのユーザーがサイトがインタラクティブになるまでほぼ6秒待つ必要があることを示しています。

TBTはロングタスクによって引き起こされるため、パーセンタイルごとの同じ傾向、および2つのメトリクス結果でのモバイルとデスクトップ間のギャップでの類似の傾向に気づくのは驚くことではありません。また、高いTBTがINPの入力遅延部分に貢献し、全体的なINPスコアに悪影響を与える可能性があることに注意することも重要です。


### インタラクティビティの結論

インタラクティビティ結果の主な要点は以下の通りです：

- 毎年INPの改善にもかかわらず、デスクトップ（97％の良好なINP）とモバイル（74％の良好なINP）のパフォーマンス間には依然として大きなギャップが存在します。
- もっとも訪問されるウェブサイトは、人気の低いサイトと比較してより悪いINP結果を示しています。
- INPは3つのサブパーツに分けることができます：入力遅延、処理時間、プレゼンテーション遅延。プレゼンテーション遅延がRUMvisionのデータで中央値INPの最大の割合を占めています。
- ユーザー行動追跡、同意プロバイダー、CDNカテゴリーからのスクリプトが、悪いINPスコアの主な貢献要因です。

## 視覚的安定性

ウェブサイトの視覚的安定性は、ページが読み込まれユーザーがそれとインタラクションする際の視覚的要素の一貫性と予測可能性を指します。視覚的に安定したウェブサイトは、コンテンツが予期せずシフト、移動、レイアウト変更をしないことを保証し、ユーザーエクスペリエンスを阻害しません。これらのシフトは、寸法が指定されていないアセット（画像とビデオ）、サードパーティ広告、重いフォントなどによってしばしば発生します。視覚的安定性を測定する主要なメトリクスは、[Cumulative Layout Shift（CLS）](https://web.dev/articles/cls)です。

### Cumulative Layout Shift（CLS）

CLSは、ページが開いている間に発生する予期しないレイアウトシフトについて、レイアウトシフトスコアの最大バーストを測定します。レイアウトシフトは、可視要素がある場所から別の場所に位置を変更するときに発生します。

0.1以下のCLSスコアは良好と見なされ、ページが視覚的に安定したエクスペリエンスを提供することを意味します。0.1から0.25の間のスコアは改善の必要性を示し、0.25を超えるスコアは悪いと見なされ、ユーザーが破壊的で予期しないレイアウトシフトを経験する可能性があることを示します。

{{ figure_markup(
  image="good-cls-by-device-2024.png",
  caption="2024年のデバイス別CLSパフォーマンス。",
  description="2024年のデバイス別CLSパフォーマンスを示す積み上げバーチャート。デスクトップサイトについて、72％のサイトが良好なCLSスコアを持ち、18％が改善が必要、11％が悪いと見なされます。モバイルサイトについて、79％のサイトが良好なスコアを持ち、12％が改善が必要、9％が悪いスコアです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1271338928&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

2024年、72％のウェブサイトが良好なCLSスコアを達成し、11％が悪いスコアでした。また、サイトの安定性に関して、モバイルデバイスのウェブサイトがデスクトップサイトよりも良いユーザーエクスペリエンスを提供していることもわかります。

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="デバイスと年で分類された良好なCLSを持つウェブサイトの割合。",
  description="デバイスと年で分類された良好なCLSを持つウェブサイトの数を示すバーチャート。良好なCLSを持つモバイルサイトの割合は、2020年が60％、2021年が62％、2022年が74％、2023年が76％、2024年が79％でした。デスクトップサイトについては、2020年に54％が良好なCLSを持ち、2021年に62％、2022年に65％、2023年に68％、2024年に72％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1974391374&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

時間の経過とともにメトリクスを見ると、良い上昇傾向を確認できます。2020年の良好な視覚的安定性を持つウェブサイトの60％から2024年のほぼ80％まで増加しています。モバイルデータの目に見える上昇は、すでに詳細に言及されており、[2022年の章](../2022/performance#累積レイアウトシフトCLS)でbfcacheの導入に起因するとされています。2022年からの目に見える違いがまだあるため、それに貢献した可能性のある側面をいくつか詳しく見ていきます。

### Back/forward cache（bfcache）

[Back/forward cache（bfcache）](https://web.dev/articles/bfcache)は、ユーザーがページから離れるときに、完全にインタラクティブなページのスナップショットをメモリにキャッシュすることで、ウェブページ間のナビゲーションの速度と効率を向上させるブラウザ最適化機能です。しかし、すべてのサイトがbfcacheの対象となるわけではありません。<a hreflang="en" href="https://html.spec.whatwg.org/multipage/nav-history-apis.html#nrr-details-reason">広範囲な適格性基準</a>があるため、サイトが適格かどうかを確認する最も簡単な方法は、[Chrome DevToolsでテストする](https://developer.chrome.com/docs/devtools/application/back-forward-cache)ことです。

よくある原因でラボデータを使用して簡単に測定できるいくつかの適格性基準をチェックして、より深く見てみましょう。

「よくある容疑者」の1つは、ユーザーがページから離れるときにトリガーされる`unload`イベントです。bfcacheがページの状態を保持する方法により、`unload`イベントはページをbfcache不適格にします。ここで重要なのは、この機能はデスクトップのブラウザに特有であることです。モバイルブラウザは、bfcache適格性を決定する際に`unload`イベントを無視します。これらのデバイスでは、バックグラウンドページがより頻繁に破棄されるため、すでに信頼性がないからです。この動作は、長年にわたるCLSの改善とモバイルとデスクトップの数値間のギャップを説明できるかもしれません：

{{ figure_markup(
  image="unload-usage.png",
  caption="サイトランク別のunloadの使用状況。",
  description="デスクトップとモバイルデバイスについて、ランク別にunloadハンドラーによってbfcache（back-forward cache）不適格となるページの割合を示すバーチャート。上位1,000のウェブサイトについて、デスクトップページの35％が不適格です。上位10,000では、デスクトップの34％が不適格です。上位100,000では、デスクトップの29％が不適格です。1,000,000ランクでは、デスクトップページの21％が不適格です。10,000,000ランクでは、デスクトップの17％が不適格で、全ランクでは、デスクトップページの16％が不適格です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1163433950&format=interactive",
  sheets_gid="1706831462",
  sql_file="bfcache_unload.sql"
  )
}}

ページからの`unload`イベントを示す上記のチャートから、いくつかの興味深いことがわかります。全体的なイベント使用状況はかなり低く、15-16％です。しかし、上位1,000サイトでは劇的に増加し、デスクトップで35％、モバイルで27％となり、より人気のあるサイトがこの特定のイベントをよく使用するサードパーティサービスをかなり多く使用している可能性があることを示しています。モバイルとデスクトップの間のギャップは重要です。`unload`イベントを使用するモバイルサイトがまだbfcacheの対象となっている一方で、それらは依然として信頼性がないからです。

Google ChromeやFirefoxなどの主要ブラウザが2020年頃からその廃止に向けて動き、`pagehide`や`visibilitychange`などの代替イベントの使用を推奨していることから、unloadイベントの使用のこの減少を見ることは予想されます。これらのイベントはより信頼性があり、ブラウザのナビゲーションをブロックせず、bfcacheと互換性があり、ユーザーが前後にナビゲートするときにページをメモリに保持し、即座に復元することを可能にします。

ウェブサイトがbfcache不適格カテゴリーに分類されるもう1つの一般的な理由は、`cache-control: no-store`ディレクティブの使用です。このキャッシュ制御ヘッダーは、ブラウザ（および中間キャッシュ）にリソースのコピーを保存しないよう指示し、リクエストごとにサーバーからコンテンツを取得することを保証します。

{{ figure_markup(
  caption="`Cache-Control: no-store`を使用するサイトの割合。",
  content="21%",
  classes="big-number",
  sheets_gid="389603749",
  sql_file="cls_animations.sql"
)
}}

21％のサイトが`Cache-Control: no-store`を使用しています。これは、この測定値が約22％だった2022年のレポートからのわずかな減少です。

bfcacheが最初に導入されたとき、Core Web Vitalsに顕著な改善をもたらしました。それに基づいて、Chromeは`Cache-Control: no-store`ヘッダーの使用により以前は不適格だったサイトに[徐々にbfcacheを適用](https://developer.chrome.com/docs/web-platform/bfcache-ccns)しています。この変更は、サイトパフォーマンスをさらに改善することを目的としています。

unloadイベントと`Cache-Control: no-store`は、ページの視覚的安定性に直接影響しません。すでに述べたように、bfcache読み込みの概念は副作用として、サイズが指定されていない画像や動的コンテンツなど、メトリクスに直接影響する潜在的な問題の一部を排除することで、この積極的な影響を与えます。ウェブの視覚的安定性の側面を探求し続けるために、CLSに直接影響するいくつかのプラクティスをチェックしてみましょう。

### CLSベストプラクティス

以下のベストプラクティスにより、CLSを削減、または完全に回避することができます。

#### 明示的な寸法

予期しないレイアウトシフトのもっとも一般的な理由の1つは、アセットや受信する動的コンテンツのためのスペースを保持しないことです。たとえば、画像に`width`と`height`属性を追加することは、スペースを保持しシフトを回避するもっとも簡単な方法の1つです。

{{ figure_markup(
  content="66%",
  caption="少なくとも1つの画像で明示的な寸法を設定できていないモバイルページの割合。",
  classes="big-number",
  sheets_gid="1674162543",
  sql_file="cls_unsized_images.sql"
  )
}}

66％のモバイルページが少なくとも1つのサイズが指定されていない画像を持っており、これは2022年の72％からの改善です。

{{ figure_markup(
  image="unsized-images-amount.png",
  caption="ページあたりのサイズが指定されていない画像の数。",
  description="デスクトップとモバイルデバイスのパーセンタイル別にページあたりのサイズが指定されていない画像の数を示すバーチャート。10パーセンタイルと25パーセンタイルでは、デスクトップとモバイルページの両方がサイズが指定されていない画像を0個持ちます。50パーセンタイルでは、デスクトップとモバイルページの両方がサイズが指定されていない画像を2個持ちます。75パーセンタイルでは、デスクトップページがサイズが指定されていない画像を10個持ち、モバイルページは9個です。90パーセンタイルでは、デスクトップページがサイズが指定されていない画像を26個、モバイルページは23個持ちます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=603112996&format=interactive",
  sheets_gid="1674162543",
  sql_file="cls_unsized_images.sql"
  )
}}

ウェブページあたりのサイズが指定されていない画像の中央値は2個です。90パーセンタイルに移ると、その数はデスクトップサイトで26個、モバイルで23個まで跳ね上がります。ページにサイズが指定されていない画像を持つことはレイアウトシフトのリスクとなる可能性があります。しかし、重要な側面は、画像がビューポートに影響しているかどうか、そしてもしそうなら、どの程度かを見ることです。

{{ figure_markup(
  image="unsized-images-height.png",
  caption="サイズが指定されていない画像の高さの分布。",
  description="サイズが指定されていない画像の10、25、50、75、90パーセンタイルの高さを示すバーチャート。モバイルの値はそれぞれ16、38、100、200、297ピクセルの高さです。デスクトップの値はより大きく：16、40、110、241、403です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1462566122&format=interactive",
  sql_file="cls_unsized_image_height.sql"
  )
}}

中央値のモバイルサイトは約100ピクセルの高さのサイズが指定されていない画像を持っています。我々のテストデバイスは512ピクセルのモバイルビューポート高さを持ち、画面幅のほぼ20％を表しています。これは、サイズが指定されていない（全幅の）画像が読み込まれるときに潜在的に下にシフトされる可能性があり、これは軽微でないシフトです。

予想通り、デスクトップページの画像の高さはより大きく、中央値のサイズが110ピクセル、90パーセンタイルで403ピクセルです。

#### フォント

フォントはCLSに直接影響する可能性があります。ウェブフォントが非同期で読み込まれる場合、ページの初期レンダリングとカスタムフォントが適用される時間の間に遅延が発生します。この遅延中、ブラウザはしばしばフォールバックフォントを使用してテキストを表示しますが、これはウェブフォントと比較して異なる寸法（幅、高さ、文字間隔）を持つ可能性があります。ウェブフォントが最終的に読み込まれると、テキストが新しい寸法に合わせてシフトし、目に見えるレイアウトシフトを引き起こし、より高いCLSスコアに貢献する可能性があります。

{{ figure_markup(
  caption="ウェブフォントを使用するモバイルページの割合。",
  content="85%",
  classes="big-number",
  sheets_gid="344191137",
  sql_file="font_usage_mobile.sql"
)
}}

システムフォントを使用することは、この問題を修正する1つの方法です。しかし、85％のモバイルページがウェブフォントを使用しているため、近い将来それらの使用が停止される可能性は非常に低いです。ウェブフォントを使用するサイトの視覚的安定性を制御する方法は、CSSで`font-display`プロパティを使用してフォントの読み込みと表示方法を制御することです。パフォーマンスと美的観点のトレードオフについてのチームの決定に応じて、[異なる`font-display`戦略を使用](https://web.dev/articles/font-best-practices#choose_an_appropriate_font-display_strategy)できます。

{{ figure_markup(
  image="font-display-usage.png",
  caption="font-displayの使用状況。",
  description="さまざまなfont-display値を使用するページの割合を示すバーチャート。モバイルページの45％がswapを使用し、23％がblock、9％がauto、3％がfallback、1％がoptionalを使用しています。デスクトップの値も似ています。",
  chart_url="https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1458420916&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1EkdvJ8e0B9Rr42evC2Ds5Ekwq6gF9oLBW0BA5cmSUT4/edit?gid=455989674#gid=455989674",
  sql_file="../fonts/performance/styles_font_display.sql"
  )
}}

上に表示されたデータから、モバイルとデスクトップサイトの両方の約44％が`font-display:swap`を使用している一方で、23％のサイトが`font-display:block`を使用していることがわかります。9％のサイトが`font-display`プロパティを`auto`に設定し、3％が`fallback`プロパティを使用しています。約1％のサイトのみが`optional`戦略を使用しています。

2022年のデータと比較すると、すべての`font-display`戦略の使用に目に見える増加があり、最大のものは`swap`で、モバイルとデスクトップページ両方での使用が2022年の約30％から44％超まで上昇しました。

ほとんどの`font-display`戦略がCLSに貢献する可能性があるため、潜在的な問題を最小化するための他の戦略を見る必要があります。その1つは、サードパーティフォントができるだけ早く発見され読み込まれることを保証するためにリソースヒントを使用することです。

{{ figure_markup(
  image="fonts-resource-hints.png",
  caption="フォントリソースのリソースヒントの採用。",
  description="ウェブフォントで各タイプのリソースヒントを使用するページの割合を示すバーチャート。モバイルページの18％がpreconnectを使用し、16％がdns-prefetch、11％がpreload、1％未満がprefetchを使用しています。デスクトップの値もほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=769711215&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1EkdvJ8e0B9Rr42evC2Ds5Ekwq6gF9oLBW0BA5cmSUT4/edit?gid=405563602#gid=405563602",
  sql_file="../fonts/performance/pages_link_relationship.sql"
  )
}}

テストされたモバイルとデスクトップページの全体の約11％がウェブフォントをプリロードしており、ブラウザにこれらのファイルをダウンロードするよう指示し、フォントの遅い到着によるシフトを回避できるよう早期にダウンロードできることを期待しています。プリロードを不正に使用すると、それを助ける代わりにパフォーマンスを害する可能性があることに注意してください。これを回避するには、プリロードされたフォントが使用されることを確認し、あまりに多くのアセットをプリロードしないことが必要です。あまりに多くのアセットをプリロードすると、他のより重要なリソースを遅延させることになる可能性があります。

18％のサイトが`preconnect`を使用してサードパーティオリジンへの早期接続を確立しています。`preload`と同様に、このリソースヒントを慎重に使用し、やりすぎないことが重要です。

#### アニメーション

予期しないシフトのもう1つの原因は、[非合成](https://developer.chrome.com/docs/lighthouse/performance/non-composited-animations)CSSアニメーションです。これらのアニメーションは、複数の要素のレイアウトや外観に影響するプロパティの変更を含み、スタイルの再計算、ドキュメントのリフロー、画面のピクセルの再描画などのよりパフォーマンス集約的なステップを通過することをブラウザに強制します。ベストプラクティスは、代わりに`transform`や`opacity`などのCSSプロパティを使用することです。

{{ figure_markup(
  content="39%",
  caption="非合成アニメーションを持つモバイルページの割合。",
  classes="big-number",
  sheets_gid="293393420",
  sql_file="cls_animations.sql",
  )
}}

39％のモバイルページと42％のデスクトップページがまだ非合成アニメーションを使用しており、これは2022年の分析でのモバイル38％、デスクトップ41％からの非常にわずかな増加です。

### 視覚的安定性の結論

サイトの視覚的安定性は、ページのユーザーエクスペリエンスに大きな影響を与える可能性があります。読んでいる間にテキストがシフトしたり、クリックしようとしていたボタンがビューポートから消えたりすることは、ユーザーフラストレーションにつながる可能性があります。良いニュースは、Cumulative Layout Shift（CLS）が2024年に改善し続けたことです。これは、画像のサイジングや動的コンテンツのスペース保持などの良いプラクティスを採用し、このブラウザ機能から恩恵を受けるためにbfcache適格性を最適化するウェブサイト所有者がますます増えていることを示しています。

## 結論

ウェブパフォーマンスは2024年に改善し続け、多くの主要メトリクスにわたって積極的な傾向を示しました。ウェブサイトのインタラクティビティを評価するより包括的なメトリクス、つまりINPを持つようになり、これがさらに大きなパフォーマンス最適化につながることが期待されます。

しかし、課題は残っています。たとえば、デスクトップとモバイル間でINPパフォーマンスにまだ大きなギャップがあります。プレゼンテーション遅延が悪いINPの主な貢献要因で、主に行動追跡、同意プロバイダー、CDNのサードパーティスクリプトによって引き起こされます。

視覚的安定性は、適切な画像サイジングや動的コンテンツのスペース保持などのベストプラクティスの採用により改善し続けています。さらに、Chromeのbfcache適格性の最近の変更により、より多くのサイトがより速い戻る・進むナビゲーションから恩恵を受けるでしょう。

全体的に、ウェブパフォーマンスは有望な軌道にあり、読み込み時間をより速く、インタラクティビティをよりスムーズに、視覚的安定性をより信頼性があるものにしています。しかし、モバイルとデスクトップエクスペリエンス間の違いは依然として大きいです。将来のWeb Almanacレポートでは、このギャップが減少し、すべてのデバイスにわたって一貫したウェブエクスペリエンスを実現することを期待しています。
