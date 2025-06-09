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

In 2024, 74% of mobile and 97% of desktop websites had good INP. Interestingly, the gap between mobile and desktop is huge, i.e. more than 20%.

The primary reason for weaker performance on mobile is its lower processing power and frequently poor network connections. Alex Russell's article "<a hreflang="en" href="https://infrequently.org/2022/12/performance-baseline-2023/">The Performance Inequality Gap</a>" (2023) raises the issue of the growing performance inequality gap caused by the affordance of high-end vs low-end devices. As the prices of high-end devices rise, fewer users can afford them, widening the inequality gap.

{{ figure_markup(
  image="good-interaction-to-next-paint.png",
  caption="Good INP score by device.",
  description="Bar chart showing the percentage of websites with good INP performance by device (desktop and mobile) across three years. In 2022, 95% of desktop websites had good INP, while 55% of mobile websites achieved good INP. In 2023, the percentage of websites with good INP improved to 97% for desktop and 64% for mobile. By 2024, 97% of desktop websites maintained good INP performance, while mobile improved further to 74%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=416359271&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

Although the INP metric displays worse results than the FID, there has been a positive tendency over the past three years. The percentage of mobile pages having good INP increased from 55% in 2022 to 74% in 2024. This is a significant increase, and even though we can't be exactly sure what to attribute it to, we can think of a few potential drivers for this change.

The first one could be awareness. With the introduction of the INP and the announcement that it will replace FID, many teams realized the impact that could have on their overall CWV score and search ranking. That could have encouraged them to actively work towards fixing parts of the sites that contributed to low INP scores. The second driver could be just a regular advancement in technology. With the above-displayed INP data coming from real users, we can also assume that users' devices and network connections could have slightly improved over the years, providing them with better site interactivity. The third (and perhaps biggest?) driver is improvements to browsers themselves (and in particular to Chrome, given that powers out insights). The Chrome team have made <a hreflang="en" href="https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/speed/metrics_changelog/inp.md">a number of improvements that impact INP</a> over the last two years.

Mobile INP metric by rank reveals an interesting trend. In [the 2022 chapter](../2022/performance#inp-by-rank), we assumed that the more popular a website is, the more performance optimizations it would have, leading to better performance. However, when it comes to INP, the opposite seems to be true.

{{ figure_markup(
  image="interaction-to-next-paint-score-mobile-2024.png",
  caption="INP performance on mobile devices segmented by rank.",
  description="Stacked bar chart showing mobile INP performance by website rank, categorized into good (under 200 milliseconds), needs improvement (200–500 milliseconds), and poor (over 500 milliseconds).For the top 1,000 websites, 53% have good INP, 41% need improvement, and 6% perform poorly. For the top 10,000 websites, 49% are in the good range, 44% need improvement, and 7% are poor. In the top 100,000, 51% are good, 43% need improvement, and 6% are poor. For the top 1,000,000 websites, 61% have good INP, 35% need improvement, and 4% are poor. As the rank increases to the top 10,000,000 websites, 73% are good, 24% need improvement, and 3% are poor. Finally, for the top 100,000,000 websites, 74% have good INP, 24% need improvement, and 2% are poor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=296559964&format=interactive",
  sheets_gid="355582610",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

Fewer websites in the top 1,000 rank have good INP compared to the results for all websites. For example, 53% of the top 1,000 websites have a good INP score, while a much bigger percentage of all websites, i.e. 74%, meet this threshold.

This could be because the most visited websites often have more user interactions and complex functionality. Logically, the INP for an interactive e-commerce site would differ from a simple, static blog.

{{ figure_markup(
  image="good-interaction-to-next-paint-home-secondary-page.png",
  caption="Good INP performance on Home and Secondary page by device.",
  description="Bar chart showing the percentage of pages with good INP for home pages and secondary pages, separated by desktop and mobile performance. For home pages, 96% of desktop pages have a good INP, while 73% of mobile pages achieve a good INP. For secondary pages, 96% of desktop pages also have a good INP, with 72% of mobile pages reaching this performance level.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1483510539&format=interactive",
  sheets_gid="1159394005",
  sql_file="web_vitals_by_device_secondary_pages.sql"
  )
}}

Unlike other performance metrics like FCP and LCP, the percentage of secondary pages with good INP does not differ from the home page results. This is likely because INP isn't as impacted by caching as loading speed is.

#### INP sub-parts

Interaction to Next Paint metric can be broken down into three key sub-parts:

- **Input Delay**: the time spent to finish processing the tasks that were already in the queue at the moment of the interaction
- **Processing Time**: the time spent processing the event handlers attached to the element which the user interacted with
- **Presentation Delay**: the time spent figuring out the new layout, if changed, and painting the new pixels on the screen

To optimize your website's interactivity, it's important to identify the duration of every sub-part.

{{ figure_markup(
  image="interaction-to-next-paint-subparts-rum-vision.png",
  caption="INP sub-parts by percentile.",
  description="Bar chart showing the distribution of INP sub-parts in milliseconds (ms) by percentile. At the 10th percentile, all sub-parts (input delay, processing time, and presentation delay) are minimal. At the 25th percentile, the values slightly increase but remain below 10 milliseconds. At the 50th percentile, input delay and processing time stay modest, while presentation delay reaches around 20 milliseconds. At the 75th percentile, input delay increases to around 50 milliseconds, with processing time and presentation delay also rising. At the 90th percentile, input delay reaches around 150 milliseconds, and both processing time and presentation delay exceed 100 milliseconds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=226800794&format=interactive",
  sheets_gid="731456372",
  )
}}

The INP sub-part duration distribution data from RUMvision shows that presentation delay (36 milliseconds) contributes the most to the median INP. As percentiles increase, input delay and processing time become longer. At the 75th percentile, input delay reaches 37 milliseconds and processing delay 56 milliseconds. By the 90th percentile, input delay jumps to 155 milliseconds, which makes it the biggest contributor to poor INP. One way to optimize input delay is by avoiding long tasks, which we explore in the Long Tasks section.

### Long tasks

One of the sub-parts of INP is input delay, which can be longer than it should be due to various factors, including long tasks. [A task](https://web.dev/articles/optimize-long-tasks#what-is-task) is a discrete unit of work that the browser executes, and JavaScript is often the largest source of tasks. When a task exceeds 50 milliseconds, it is considered a long task. These long tasks can cause delays in responding to user interactions, directly affecting interactivity performance.

Due to the lack of same-source data for long tasks and INP, we decided not to correlate them. We will, however, explore the average Long Task duration using data from RUMvision.

{{ figure_markup(
  image="long-task-duration.png",
  caption="Task duration, segmented by device.",
  description="Bar chart showing the distribution of task duration in milliseconds (ms) by percentile and device type. At the 25th percentile, the task duration is 61 milliseconds for desktop and 71 for mobile. At the 50th percentile, it increases to 90 milliseconds for desktop and 108 milliseconds for mobile. At the 75th percentile, task duration is 161 milliseconds for desktop and 187 milliseconds for mobile; at the 90th percentile, it reaches 331 milliseconds for desktop and 377 for mobile. This distribution shows that task durations grow significantly as we move from the 25th to the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=688921860&format=interactive",
  sheets_gid="1272522211"
  )
}}

The task duration distribution shows a median task duration of 90 milliseconds for desktop and 108 milliseconds for mobile, which is twice more than the best practice recommendation of under 50 milliseconds. Less than 25% of websites have an optimal task duration below 50 milliseconds. We can also see that in every percentile, task duration on mobile sites is longer than on desktop sites, with the gap increasing as the percentile increases. On the 90th percentile, there is a 46 millisecond difference between the average task duration between device types. This correlates well with INP scores that show better results on desktop compared to mobile.

Task duration data was retrieved using the <a hreflang="en" href="https://www.w3.org/TR/longtasks-1/">Long Tasks API</a>, which provides some useful data about performance issues, but it has limitations when it comes to accurately measuring sluggishness. It only identifies when a long task occurs and how long it lasts. It might overlook essential tasks such as rendering. Due to these limitations, we will explore the Long Animation Frames API in the next section, which offers more detailed insights.

#### Long animation frames

[Long Animation Frames (LoAF)](https://developer.chrome.com/docs/web-platform/long-animation-frames) are a performance timeline entry for identifying sluggishness and poor INP by tracking when work and rendering block the main thread. LoAF tracks animation frames instead of individual tasks like the Long Tasks API. A long animation frame is when a rendering update is delayed beyond 50 milliseconds (the same as the threshold for the Long Tasks API). It helps to find scripts that cause INP performance bottlenecks.  This data allows us to analyze INP performance based on the categories of scripts responsible for LoAF.

{{ figure_markup(
  image="interaction-to-next-paint-script-categories-desktop-rum-vision.png",
  caption="Distribution of INP performance segmented by script categories on desktop.",
  description="Stacked bar chart showing the distribution of INP across LOAF script categories for desktop, measured in milliseconds (ms). User Review, SMS & Email, and Analytics scripts perform best, with most of their INP in the good range. Tag Manager and Consent Provider scripts have more mid-range INP, with some falling into the poor category. Advertising, Others, and User Behaviour scripts perform worse, with the majority of INP falling into the poor range.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1975914925&format=interactive",
  sheets_gid="947269170",
  )
}}

{{ figure_markup(
  image="interaction-to-next-paint-script-categories-mobile-rum-vision.png",
  caption="Distribution of INP performance segmented by script categories on mobile.",
  description="Stacked bar chart showing the distribution of INP across LOAF script categories for mobile, measured in milliseconds (ms). For Social scripts, most are in the good range, with few in the poor range. Video and Tag Manager scripts also have a majority in the good range but with a larger portion in the mid-range. Site Search and Advertising scripts have a more even distribution, with a significant part in the mid-range and some in the poor range. Developer Utilities, Others, and User Behaviour scripts perform worse, with most falling in the poor range.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1978447282&format=interactive",
  sheets_gid="947269170",
  )
}}

The top two categories contributing the most to slow INP scores on mobile and desktop devices are User Behavior scripts (37% of mobile and 60% of desktop pages with good INP) and CDN/Hosting (50% of mobile and 65% of desktop pages with good INP).

User Behavior scripts include scripts from hosts like `script.hotjar.com`, `smartlook.com`, `newrelic.com`, etc. While these tools provide valuable insights about users, our data shows that they can significantly degrade user experience by slowing down website interactions.

CDN and Hosting script category examples come from domains like `cdn.jsdelivr.net`, `ajax.cloudflare.com`, `cdnjs.cloudflare.com`, `cdn.shopify.com`, `sdk.awswaf.com`, `cloudfront.net`, `s3.amazonaws.com` and others. Having CDNs among the categories with the poorest INP results seems controversial because CDNs are usually recommended as a performance optimization technique that reduces server load and delivers content faster to users. However, the CDNs included in this category usually deliver first- or third-party JavaScript resources, which contribute to LoAF and negatively impact interactivity.

On mobile devices, Consent Providers seem to have a significant impact on INP, resulting in only 53% of mobile pages having good INP when using one. This category consists of providers like `consentframework.com`, `cookiepro.com`, `cookiebot.com`, `privacy-mgmt.com`, `usercentrics.eu`, and many others. On desktop devices, Consent Provider scripts show much better results, i.e. 76% of pages with good INP. This difference is likely due to the more powerful processors on desktop devices.

It is worth noting that the monitoring category, which also includes performance monitoring tools, has one of the least impacts on poor INP results. This is a good argument in favor of using web performance monitoring tools, as they help with valuable web performance insights without significantly affecting interactivity performance.

### Total Blocking Time (TBT)

[Total Blocking Time (TBT)](https://web.dev/articles/tbt) measures the total amount of time after First Contentful Paint (FCP) where the main thread was blocked for long enough to prevent input responsiveness.

TBT is a lab metric and is often used as a proxy for field-based responsiveness metrics, such as INP, which can only be collected using real user monitoring, such as CrUX and RUMvision. <a hreflang="en" href="https://colab.research.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">Lab-based TBT and field-based INP</a> are correlated, meaning TBT results generally reflect INP trends. A TBT below 200 milliseconds is considered good, but most mobile websites exceed this target significantly.

{{ figure_markup(
  image="total-blocking-time-2024.png",
  caption="TBT per page by percentile.",
  description="Bar chart showing the distribution of Total Blocking Time (TBT) per page in milliseconds (ms) by percentile. At the 10th percentile, both desktop and mobile TBT are near 0 milliseconds. At the 25th percentile, desktop TBT is 84 milliseconds, while mobile is 417 milliseconds. At the 50th percentile, desktop has 67 milliseconds of TBT, and mobile rises significantly to 1,209 milliseconds. At the 75th percentile, desktop reaches 282 milliseconds, with mobile at 2,990 milliseconds. Finally, at the 90th percentile, desktop TBT is 718 milliseconds, and mobile climbs to 5,955 milliseconds",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1525715716&format=interactive",
  sheets_gid="89045350",
  sql_file="inp_tbt.sql"
  )
}}

The median TBT on mobile is 1,209 milliseconds, which is 6 times higher than the best practice. In contrast, desktop websites show much better performance, with a median TBT of just 67 milliseconds. It is important to emphasize that the lab results use an emulated low-power device and a slow network, which may not reflect the real user data, as actual device and network conditions can vary. However, even with that in mind, these results still show that in the 90th percentile, user on mobile device will need to wait almost 6 seconds before the site becomes interactive.

With TBT being caused by long tasks it is not surprising to notice the same trend per percentiles as well as similar trend in gap between mobile and desktop in the two metrics results. It is also important to note that high TBT can be contributing to the input delay part of the INP, negatively impacting the overall INP score.


### Interactivity conclusion

The main takeaways of the interactivity results are:

- Despite the improvement in INP each year, a significant gap between desktop (97% good INP) and mobile (74% good INP) performance still exists.
- The top visited websites show poorer INP results compared to less popular ones.
- INP can be divided into three sub-parts: Input Delay, Processing Time, and Presentation Delay. Presentation Delay has the biggest share of the median INP in RUMvisions's data.
- Scripts from user behavior tracking, consent provider, and CDN categories are the main contributors to poor INP scores.

## Visual stability

Visual stability on a website refers to the consistency and predictability of visual elements as the page loads and users interact with it. A visually stable website ensures that content does not unexpectedly shift, move, or change layout, which can disrupt the user experience. These shifts often happen due to assets without specified dimensions (images and videos), third-party ads, heavy fonts, etc. The primary metric for measuring visual stability is [Cumulative Layout Shift (CLS)](https://web.dev/articles/cls).

### Cumulative Layout Shift (CLS)

CLS measures the biggest burst of layout shift scores for any unexpected layout shifts that happen while a page is open. Layout shifts occur when a visible element changes its position from one place to another.

A CLS score of 0.1 or less is considered good, meaning the page offers a visually stable experience, while scores between 0.1 and 0.25 indicate the need for improvement, and scores above 0.25 are considered poor, indicating that users may experience disruptive, unexpected layout shifts.

{{ figure_markup(
  image="good-cls-by-device-2024.png",
  caption="CLS performance by device for 2024.",
  description="Stacked bar chart showing CLS performance for 2024 by device. For desktop sites, 72% of sites had good CLS score, 18% need improvement, and 11% are considered poor. For mobile sites, 79% of sites have a good score, 12% need improvement, and 9% have a poor score.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1271338928&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

In 2024, 72% of websites achieved good CLS scores, while 11% had poor ones. We can also see that websites on mobile devices provide a better user experience when it comes to site stability than desktop sites.

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="The percent of websites having good CLS, segmented by device and year.",
  description="Bar chart showing the number of websites with good CLS segmented by device and years. The percentage of mobile sites having good CLS was 60% for year 2020., 62% for 2021, 74% for 2022, 76% for 2023, and 79% for 2024. For desktop sites, 54% had good CLS in 2020, 62% in 2021, 65% in 2022, 68% in 2023, and 72% in 2024.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1974391374&format=interactive",
  sheets_gid="1535582002",
  sql_file="web_vitals_by_device.sql"
  )
}}

Looking at the metrics over time, we can see a nice upward trend. There is an increase from 60% of websites with good visual stability in 2020 to almost 80% in 2024. A visible jump in mobile data is already addressed in detail and attributed to the introduction of bfcache in [the 2022 chapter](../2022/performance#cumulative-layout-shift-cls). There is still a visible difference from 2022, so we will look in detail at some of the aspects that possibly contributed to it.

### Back/forward cache (bfcache)

[The back/forward cache (bfcache)](https://web.dev/articles/bfcache) is a browser optimization feature that improves the speed and efficiency of navigating between web pages by caching a fully interactive snapshot of a page in memory when a user navigates away from it. However, not all sites are eligible for bfcache. With an <a hreflang="en" href="https://html.spec.whatwg.org/multipage/nav-history-apis.html#nrr-details-reason">extensive eligibility criteria</a>, the easiest way to check if the site is eligible is to [test it in Chrome DevTools](https://developer.chrome.com/docs/devtools/application/back-forward-cache).

Let's look deeper by checking a few eligibility criteria that are quite a common cause and easily measurable using lab data.

One of the "usual suspects" is the `unload` event that is triggered when a user navigates away from a page. Due to how bfcache preserves a page's state, `unload` event makes the page ineligible for bfcache. Important to note here is that this feature is specific for browsers on desktops. Mobile browsers ignore the `unload` event when deciding bfcache eligibility, since it is already unreliable on those devices given how background pages are discarded more often there. This behavior could explain CLS improvement over the years and the gap between mobile and desktop numbers:

{{ figure_markup(
  image="unload-usage.png",
  caption="Usage of unload by site rank.",
  description="Bar chart showing the percentage of pages ineligible for bfcache (back-forward cache) due to unload handlers, by rank, for desktop and mobile devices. For the top 1,000 websites, 35% of desktop pages are ineligible. For the top 10,000, 34% of desktop are ineligible. In the top 100,000, 29% of desktop are ineligible. At the 1,000,000 rank, 21% of desktop pages are ineligible. At the 10,000,000 rank, 17% of desktop are ineligible, while for all ranks, 16% of desktop pages are ineligible.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1163433950&format=interactive",
  sheets_gid="1706831462",
  sql_file="bfcache_unload.sql"
  )
}}

From the above chart showing `unload` events from pages, we can see a few interesting things. Overall event usage is quite low, 15-16%. However, it increases drastically for the top 1.000 sites, to 35% on desktop and 27% on mobile, indicating that more popular sites probably use quite some more third-party services that often use this specific event. The gap between mobile and desktop is significant as, while mobile sites using `unload` events are still eligible for the bfcache, they are still unreliable.

It is expected to see this decrease in the use of unload events with major browsers like Google Chrome and Firefox moving towards its deprecation since around 2020 and encouraging the use of alternative events like `pagehide` and `visibilitychange`. These events are more reliable, do not block the browser's navigation, and are compatible with bfcache, allowing pages to be preserved in memory and restored instantly when users navigate back or forward.

Another common reason for websites to fall in the bfcache ineligibility category is the use of the `cache-control: no-store` directive. This cache control header instructs the browser (and any intermediate caches) not to store a copy of the resource, ensuring that the content is fetched from the server on every request.

{{ figure_markup(
  caption="Percentage of sites using `Cache-Control: no-store`.",
  content="21%",
  classes="big-number",
  sheets_gid="389603749",
  sql_file="cls_animations.sql"
)
}}

21% of sites are using `Cache-Control: no-store`. That is a slight decrease from the 2022 report when this measure was about 22%.

When bfcache was first introduced, it brought noticeable improvements to Core Web Vitals. Based on that, Chrome is [gradually bringing bfcache to more sites](https://developer.chrome.com/docs/web-platform/bfcache-ccns) that were previously ineligible due to the use of the `Cache-Control: no-store` header. This change aims to further improve site performance.

Unload event, as well as `Cache-Control: no-store`, do not directly affect the page's visual stability. As already mentioned, the concept of bfcache load as a side-effect has this positive impact by eliminating some potential issues affecting metrics directly, such as unsized images or dynamic content. To continue exploring the visual stability aspect of the web, let's check some of the practices that directly impact the CLS.

### CLS best practices

The following best practices allow you to reduce, or even completely avoid CLS.

#### Explicit dimensions

One of the most common reasons for unexpected layout shifts is not preserving space for assets or incoming dynamic content. For example, adding `width` and `height` attributes on images is one of the easiest ways to preserve space and avoid shifts.

{{ figure_markup(
  content="66%",
  caption="The percent of mobile pages that fail to set explicit dimensions on at least one image.",
  classes="big-number",
  sheets_gid="1674162543",
  sql_file="cls_unsized_images.sql"
  )
}}

66% of mobile pages have at least one unsized image, which is an improvement from 72% in 2022.

{{ figure_markup(
  image="unsized-images-amount.png",
  caption="The number of unsized images per page.",
  description="Bar chart showing the number of unsized images per page by percentile for desktop and mobile devices. At the 10th and 25th percentiles, both desktop and mobile pages have 0 unsized images. At the 50th percentile, both desktop and mobile pages have 2 unsized images. At the 75th percentile, desktop pages have 10 unsized images, while mobile pages have 9. At the 90th percentile, desktop pages have 26 unsized images, and mobile pages have 23.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=603112996&format=interactive",
  sheets_gid="1674162543",
  sql_file="cls_unsized_images.sql"
  )
}}

The median number of unsized images per web page is two. When we shift to the 90th percentile, that number jumps to 26 for desktop sites and 23 for mobile. Having unsized images on the page can be a risk for layout shift; however, an important aspect to look at is if images are affecting the viewport and if yes, how much.

{{ figure_markup(
  image="unsized-images-height.png",
  caption="Distribution of the heights of unsized images.",
  description="Bar chart showing the 10, 25, 50, 75, and 90th percentile height of unsized images. The values for mobile are 16, 38, 100, 200, and 297px tall, respectively. The values for the desktop are larger: 16, 40, 110, 241, and 403.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRiPhLGlGUxomTx_5nC9ahQDRxZBmJXMT3Q0Z2z4Y2pPVqC9kzjsUjRk4hz-JZzaPBjVxyaf7Gtqh93/pubchart?oid=1462566122&format=interactive",
  sql_file="cls_unsized_image_height.sql"
  )
}}

The median mobile site has unsized images of about 100 pixels in height. Our test devices have a mobile viewport height of 512 pixels, representing almost 20% of the screen width. This can potentially be shifted down when an unsized (full-width) image loads, which is not an insignificant shift.

As expected, image heights on desktop pages are larger, with the size on the median being 110px and on the 90th percentile 403 pixels.

#### Fonts

Fonts can directly impact CLS. When web fonts are loaded asynchronously, a delay occurs between the initial rendering of the page and the time when the custom fonts are applied. During this delay, browsers often display text using a fallback font, which can have different dimensions (width, height, letter spacing) compared to the web font. When the web font finally loads, the text may shift to accommodate the new dimensions, causing a visible layout shift and contributing to a higher CLS score.

{{ figure_markup(
  caption="The percent of mobile pages that use web fonts.",
  content="85%",
  classes="big-number",
  sheets_gid="344191137",
  sql_file="font_usage_mobile.sql"
)
}}

Using system fonts is one way to fix this issue. However, with 85% of mobile pages using web fonts it is not very likely that they will stop being used any time soon. A way to control the visual stability of a site that uses web fonts is to use the `font-display` property in CSS to control how fonts are loaded and displayed. [Different `font-display` strategies can be used](https://web.dev/articles/font-best-practices#choose_an_appropriate_font-display_strategy) depending on the team's decision about the tradeoff between performance and aesthetics.

{{ figure_markup(
  image="font-display-usage.png",
  caption="Usage of font-display.",
  description="Bar chart showing the percent of pages that use the various font-display values. 45% of mobile pages use swap, 23% block, 9% auto, 3% fallback, and 1% use optional. The values for desktop are similar.",
  chart_url="https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1458420916&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1EkdvJ8e0B9Rr42evC2Ds5Ekwq6gF9oLBW0BA5cmSUT4/edit?gid=455989674#gid=455989674",
  sql_file="../fonts/performance/styles_font_display.sql"
  )
}}

From the data displayed above, we can see that around 44% of both mobile and desktop sites use `font-display:swap` while 23% of sites use `font-display:block`. 9% of sites set the `font-display` property to `auto` and 3% use the `fallback` property. Only around 1% of sites use the `optional` strategy.

Compared to the 2022 data, there is a visible increase in the use of all `font-display` strategies, the biggest one being on `swap`, whose usage on both mobile and desktop pages jumped from around 30% in 2022 to over 44%.

Since most `font-display` strategies can contribute to CLS, we need to look at other strategies for minimizing potential issues. One of those is using resource hints to ensure third-party fonts are discovered and loaded as soon as possible.

{{ figure_markup(
  image="fonts-resource-hints.png",
  caption="Adoption of resource hints for font resources.",
  description="Bar chart showing the percent of pages that use each type of resource hint on web fonts. 18% of mobile pages use preconnect, 16% dns-prefetch, 11% preload, and less than 1% prefetch. The values for desktop are almost the same.",
  chart_url="https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=769711215&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1EkdvJ8e0B9Rr42evC2Ds5Ekwq6gF9oLBW0BA5cmSUT4/edit?gid=405563602#gid=405563602",
  sql_file="../fonts/performance/pages_link_relationship.sql"
  )
}}

Around 11% of all tested mobile and desktop pages are preloading their web fonts, indicating to the browser that they should download these files, hopefully early enough to avoid shifts due to late font arrival. Note that using preload incorrectly can harm performance instead of helping it. To avoid this, we need to make sure that the preloaded font will be used and that we don't preload too many assets. Preloading too many assets can end up delaying other, more important resources.

18% of sites are using `preconnect` to establish an early connection to a third-party origin. Like with `preload` it is important to use this resource hint carefully and not to overdo it.

#### Animations

Another cause of unexpected shifts can be [non-composited](https://developer.chrome.com/docs/lighthouse/performance/non-composited-animations) CSS animations. These animations involve changes to properties that impact the layout or appearance of multiple elements, which forces the browser to go through more performance-intensive steps like recalculating styles, reflowing the document, and repainting pixels on the screen. The best practice is to use CSS properties such as `transform` and `opacity` instead.

{{ figure_markup(
  content="39%",
  caption="The percent of mobile pages that have non-composited animations.",
  classes="big-number",
  sheets_gid="293393420",
  sql_file="cls_animations.sql",
  )
}}

39% of mobile pages and 42% of desktop pages still use non-composited animations, which is a very slight increase from 38% for mobile and 41% for desktop in the analysis from 2022.

### Visual stability conclusion

Visual stability of the site can have a big influence on the user experience of the page. Having text shifting around while reading or a button we were just about to click disappear from the viewport can lead to user frustration. The good news is that Cumulative Layout Shift (CLS) continued to improve in 2024. That indicates that more and more website owners are adopting good practices such as sizing images and preserving space for dynamic content, as well as optimizing for bfcache eligibility to benefit from this browser feature.

## Conclusion

Web performance continued to improve in 2024, with positive trends across many key metrics. We now have a more comprehensive metric to assess website interactivity—INP—which hopefully should lead to even greater performance optimizations.

However, challenges remain. For example, there is still a significant gap in INP performance between desktop and mobile. Presentation Delay is the main contributor to poor INP, mostly caused by third-party scripts for behavior tracking, consent providers, and CDNs.

Visual stability continues to improve by the adoption of best practices like proper image sizing and preserving space for dynamic content. Additionally, with recent changes in Chrome's bfcache eligibility, more sites will benefit from faster back and forward navigation.

Overall, web performance is on a promising track, making loading times faster, interactivity smoother, and visual stability more reliable. However, the difference between mobile and desktop experiences remains large. In future Web Almanac reports, we hope to see this gap decreasing, making the web experience consistent across all devices.
