---
title: パフォーマンス
description: 2022年版Web Almanacのパフォーマンス章では、コアWebバイタルを取り上げ、最大のコンテントフルペイント、累積レイアウトシフト、最初の入力までの遅延の各メトリクスとその診断について深く掘り下げています。
authors: [mel-ada, rviscomi]
reviewers: [tunetheweb, pmeenan, 25prathamesh, estelle, konfirmed]
analysts: [rviscomi, 25prathamesh, siakaramalegos, konfirmed]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1TPA_4xRTBB2fQZaBPZHVFvD0ikrR-4sNkfJfUEpjibs/
mel-ada_bio: メル・アダはEtsyのウェブ・パフォーマンス・チームのソフトウェア・エンジニア。現在のコミュニティへの参加には、NYウェブ・パフォーマンス・ミートアップの共同主催や最近の作品についての講演が含まれる。
rviscomi_bio: リック・ヴィスコミはグーグルのDevRelエンジニアで、ウェブパフォーマンスを専門としている。ウェブ・パフォーマンス・テストに関する本、<a hreflang="en" href="https://usingwpt.com/">Using WebPageTest</a>の共著者。また、HTTP Archiveの共同管理者であり、Web Almanacの編集長でもある。
featured_quote: これらの結果は、FIDによって描かれたバラ色の絵にもかかわらず、サイトには絶対に応答性の問題があることを示しています。INPがCWVの指標になるかどうかにかかわらず、今すぐ最適化を始めれば、ユーザーに感謝されるでしょう。
featured_stat_1: 39%
featured_stat_label_1: 静的に検出できないLCPイメージ
featured_stat_2: 22%
featured_stat_label_2: `no-store`のためにbfcacheに不適格なページ。
featured_stat_3: 20%
featured_stat_label_3: INPで良いCWVが期待できる上位1kサイト
---

## 序章

ウェブパフォーマンスはユーザーエクスペリエンスにとって非常に重要です。私たちは皆、ロード時間が遅いためにサイトを離れた経験があるか、あるいはもっと悪いことに、重要な情報にアクセスできなかった経験があります。さらに、多くの<a hreflang="en" href="https://wpostats.com/">ケーススタディ</a>が、ウェブパフォーマンスの向上がビジネスのコンバージョンとエンゲージメントの向上につながることを示しています。驚くべきことに、ウェブパフォーマンスに対する業界の注目度は意外と低いのですが、なぜでしょうか？ウェブパフォーマンスは定義が難しく、さらに測定することがさらに困難だと言う人もいます。

そもそも定義が難しいものをどのように測定するのでしょうか？[Sergey Chernyshev](https://x.com/sergeyche)（UX Captureの作成者）が言うように、"_パフォーマンスを測定する最良の方法は、ユーザーの脳に組み込まれ、彼らがサイトを使用しているときに正確に何を考えているかを理解することです_”。私たちは、そして明らかにすべきではないですが、これを行うことはできません。では、私たちの選択肢は何でしょうか？

幸いにも、パフォーマンスのいくつかの側面を自動的に測定する方法があります！ブラウザがページのロードを担当しており、毎回チェックリストの一連のステップを実行することを私たちは知っています。ブラウザがどのステップにあるかに応じて、サイトがページロードプロセスのどこまで進んでいるかを知ることができます。便利なことに、ブラウザが特定のページロードステップに到達したときにタイムスタンプを発行するために使用される[多数のパフォーマンスタイムラインAPI](https://developer.mozilla.org/ja/docs/Web/API/Performance)があります。

これらの指標は、ユーザーエクスペリエンスを測定するための私たちの最善の推測に過ぎないことに注意することが重要です。たとえば、ブラウザが画面に要素が描画されたイベントを発火したとしても、それが常にその時点でユーザーに見えていたとは限りません。さらに、業界が成長するにつれて、より多くの指標が登場し、いくつかは非推奨になりました。どこから始めればよいか、パフォーマンス指標が私たちのユーザーについて何を伝えているのかを理解することは、とくにこの分野の新しい人々にとって複雑になる可能性があります。

この章では、問題に対するGoogleの解決策である<a hreflang="ja" href="https://web.dev/articles/vitals?hl=ja">Core Web Vitals</a>（CWV）に焦点を当てています。これは、2020年に導入され、2021年に<a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">検索ランキングのシグナル</a>となったウェブパフォーマンス指標です。3つの指標はそれぞれ、ローディング、インタラクティビティ、視覚的安定性というユーザーエクスペリエンスの重要な領域をカバーしています。公開されている<a hreflang="en" href="https://developer.chrome.com/docs/crux">Chrome UX Report</a>（CrUX）データセットは、CWVでウェブサイトがどのようにパフォーマンスを発揮しているかのChromeの視点を提供します。開発者側での設定は一切不要で、Chromeは<a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#eligibility">対象となるウェブサイト</a>から、オプトインしたユーザーのデータを自動的に収集して公開しています。このデータセットを使用することで、時間をかけてウェブのパフォーマンスがどのように変化しているかについての洞察を得ることができます。

この章の焦点であるにもかかわらず、CWVがこの分野で比較的新しく、ウェブパフォーマンスを測定する唯一の方法ではないことに注意することが重要です。検索ランキングへの影響がほぼ1年前に有効であったため、これらの指標に焦点を当てることを選択しました。そして、今年のデータは、ウェブがこの業界の大きな変化にどのように適応しているか、そしてまだ機会が存在するかもしれない領域についての洞察を提供します。CWVは、サイト間のパフォーマンスを大まかに比較可能にする共通のベースラインを提供しますが、どの指標と戦略が自分のサイトに最適かを決定するのはサイト所有者次第です。私たちが望むとおりに、業界の全歴史やパフォーマンスを評価するためのすべての異なる方法を1章に収める方法はありません。

CWVプログラムは、業界ではじめて、ユーザーが実際にパフォーマンスをどのように体験しているかを測定する明確に定義されたアプローチを提案しています。CWVは、ウェブをよりパフォーマントにするための答えでしょうか？この章では、現在のウェブがCWVとどのような関係にあるか、そして未来に向けての展望を検討します。

<p class="note">開示: この章は、Core Web Vitalsプログラムを作成したGoogleの従業員によって共同執筆されています。この章とその基礎となる分析は、Googleと無関係の他の人々によってレビューされ、承認されました。</p>

## Core Web Vitals

CWVがGoogle Searchのランキングシグナルとして追加されてから1年が経ちましたので、このプログラムがウェブ上のユーザーエクスペリエンスにどのような影響を与えたかを見てみましょう。

{{ figure_markup(
  image="good-core-web-vitals-by-device.png",
  caption="デバイスと年によって分けられた良好なCWVを持つウェブサイトの割合。",
  description="2020年にはデスクトップで使用されるウェブサイトの34%、電話での24%が良好なCore Web Vitalsを持っていました。2021年にはそれぞれ41%と29%に増加し、2022年にはさらにデスクトップサイトが44%、電話サイトが39%に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1239858329&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

2021年には、モバイルユーザー向けのウェブサイトの29%が良好なCWVと評価されました。これは2020年からの大幅なステップアップで、5ポイントの増加を表しています。しかし、2022年の進歩はさらに大きな前進で、モバイルで良好なCWVを持つウェブサイトは39%になり、さらに10ポイントの増加を表しました！

デスクトップで良好なCWVを持つウェブサイトは44%です。これはモバイルよりも良いですが、デスクトップ体験の改善率はモバイルほど速くはないため、ギャップは縮まっています。

モバイル体験がデスクトップよりも悪い理由にはいくつかの説明があります。ポケットサイズのコンピューターの携帯性は大きな便利さですが、ユーザーエクスペリエンスに悪影響を及ぼす可能性があります。[モバイルウェブ](./mobile-web#モバイルパフォーマンス)章で説明されているように、小さなフォームファクターは搭載できる処理能力の量に影響を与え、これはさらに、より強力な電話を所有するための高コストによって制約されます。処理能力が低いデバイスは、ウェブページをレンダリングするために必要な計算を実行するのにより長い時間がかかります。これらのデバイスの携帯性は、ウェブサイトのロード速度に影響を与える貧弱な接続性のエリアに持ち込むことができることも意味します。最後に、開発者がウェブサイトを構築する方法についての考慮事項があります。ページのモバイルフレンドリーなバージョンを作成するのではなく、一部のウェブサイトはデスクトップサイズの画像や不必要な量のスクリプト機能を提供しているかもしれません。これらのことはすべて、モバイルユーザーをデスクトップユーザーと比較して不利にする可能性があり、彼らのCWVパフォーマンスが低いことを説明するのに役立つかもしれません。

2022年には、2021年と比較して、はるかに多くのウェブサイトが良好なCWVと評価されました。しかし、その改善はウェブ全体でどれほど均等に分配されましたか？

{{ figure_markup(
  image="good-cwv-performance-by-rank-and-year.png",
  caption="ランクと年によって分けられた良好なCWVを持つウェブサイトの割合。",
  description="2021年と2022年にランクごとに良好なCore Web Vitalsを持つウェブサイトの分布を示す棒グラフ。2021年では、トップ1,000のウェブサイトで37%、トップ10,000で31%、トップ100,000で29%、トップミリオンで30%、全体で32%でした。2022年では、トップ1,000のウェブサイトで53%、トップ10,000で44%、トップ100,000で40%、トップミリオンで40%、全体で42%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=737356809&format=interactive",
  sheets_gid="863235163",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

私たちは、相対的な人気（ランク）と年によってサイトを区分しましたが、デスクトップとモバイルの区別はしませんでした。興味深いことに、どうやら今年は人気のあるサイトに関係なく、全体的にウェブサイトがよりパフォーマントになったようです。もっとも人気のあるトップ1,000のウェブサイトがもっとも顕著に改善され、53%に16ポイントの増加を遂げましたが、すべてのランクが10ポイント以上改善されました。人気のあるウェブサイトは、もっとも良いCWV体験を持っている傾向がありますが、これは、彼らがより大きなエンジニアリングチームと予算を持っていると仮定するとあまり驚くことではありません。

今年、モバイル体験がこれほど改善された理由をより深く理解するために、個々のCWV指標についてさらに詳しく掘り下げてみましょう。

## 最大のコンテントフルペイント（LCP）

<a hreflang="ja" href="https://web.dev/articles/lcp?hl=ja">最大のコンテントフルペイント</a>（LCP）は、ナビゲーションの開始からビューポート内で最大のコンテンツブロックが表示されるまでの時間です。この指標は、ユーザーがもっとも意味のあるコンテンツをどれだけ早く見ることができるかを表しています。

ウェブサイトのLCPが良好であるとは、すべてのページビューの少なくとも75%が2,500ミリ秒よりも速い場合を指します。3つのCWV指標の中で、LCPの合格率はもっとも低く、良好なCWV評価を達成する上でのボトルネックとなることがよくあります。

{{ figure_markup(
  image="good-lcp-by-device.png",
  caption="デバイスと年に分けられた良好なLCPを持つウェブサイトの割合。",
  description="棒グラフによると、良好なLCPを持つウェブサイトの数は2020年の53%から2021年には60%に増加し、2022年には63%になりました。携帯電話で訪問されたサイトでは、2020年の43%から2021年には45%に、そして2022年には51%に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1542261080&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

今年、モバイルで良好なLCP体験を提供するウェブサイトは51%で、デスクトップでは63%です。LCPは、ウェブサイトのモバイル体験が2022年に大幅に改善された主な理由の1つであり、今年は6ポイントの改善がありました。

なぜLCPは今年これほど改善されたのでしょうか？それを理解するために、いくつかのローディングパフォーマンス診断指標、TTFBとFCPを探ってみましょう。

### 最初のバイトまでの時間（TTFB）

<a hreflang="en" href="https://web.dev/articles/ttfb">最初のバイトまでの時間</a>（TTFB）は、ナビゲーションの開始からクライアントに返される最初のデータバイトまでの時間です。これはウェブパフォーマンスチェックリストの最初のステップであり、とくにネットワーク接続速度とサーバー応答時間に関して、LCPパフォーマンスのバックエンドコンポーネントを表しています。

{{ figure_markup(
  image="good-ttfb-by-device.png",
  caption="デバイスと年に分けられた良好なTTFBを持つウェブサイトの割合。",
  description="棒グラフによると、良好なTTFBを持つウェブサイトの数は2020年の47%から2021年には51%に増加し、2022年には52%になりました。携帯電話で訪問されたサイトでは、2020年に良好なTTFBを達成したサイトは41%、2021年は39%、2022年は40%とほぼ安定しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=628253519&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

余談ですが、Chromeは今年初めに「良好」なTTFBの閾値を500ミリ秒から800ミリ秒に<a hreflang="en" href="https://developer.chrome.com/docs/crux/release-notes#202204">変更</a>しました。上のグラフでは、比較目的でこの新しい閾値を使用して過去のデータすべてが示されています。

これを念頭に置くと、良好なTTFBを持つウェブサイトの割合は実際にはあまり改善していません。過去1年間で、ウェブサイトのデスクトップとモバイル体験は1ポイント改善されたに過ぎず、これは良いことですが、LCPに観察された利得を説明するものではありません。「必要な改善」と「不十分」のTTFB分布の両端に改善がなかったわけではありませんが、「良好」な端がもっとも重要です。

もう1つの複雑な点は、TTFBがCrUXで依然として<a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#experimental-metrics">実験的</a>な指標とみなされていることです。CrUXのドキュメントによると、TTFBは、プリレンダリングや戻る/進むナビゲーションなど、より高度なナビゲーションタイプを考慮に入れていません。これはある種の盲点であり、これらの領域で改善があった場合、それらは必ずしもTTFBの結果に影響を与えるとは限りません。

### 視覚コンテンツの初期表示時間（FCP）

<a hreflang="ja" href="https://web.dev/articles/fcp?hl=ja">視覚コンテンツの初期表示時間</a>（FCP）は、リクエストの開始から画面に最初の意味のあるコンテンツが描画されるまでの時間です。TTFBと同様に、この指標はレンダリングをブロックするコンテンツの影響を受けることがあります。「良好」なFCPの閾値は1,800ミリ秒です。

{{ figure_markup(
  image="good-fcp-by-device.png",
  caption="デバイスと年に分けられた良好なFCPを持つウェブサイトの割合。",
  description="棒グラフによると、良好なFCPを持つウェブサイトの数は2020年の53%から2021年には60%に増加し、2022年には64%になりました。携帯電話で訪問されたサイトでは、2020年に良好なFCPを達成したサイトは38%で、2021年も同じで、2022年には49%に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=831105883&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

FCPは今年、劇的に改善されました。モバイルウェブサイトの49%が良好な体験を提供し、デスクトップでは64%です。これは、モバイルとデスクトップそれぞれについて、11ポイントと4ポイントの増加を表しています。

TTFBのデータが反対のことを示していない限り、これはフロントエンドの最適化、たとえばレンダリングをブロックするリソースの削除やリソースの優先順位付けの改善など、大幅な改善があったことを示しています。しかし、以下のセクションで見るように、今年のLCPの改善に感謝すべきはまったく別の何かかもしれません。

### LCPメタデータとベストプラクティス

これらのパフォーマンスの改善は、実際にはウェブサイト自体の変更によるものではないかもしれません。ネットワークインフラ、オペレーティングシステム、またはブラウザの変更も、このようにウェブスケールでLCPパフォーマンスに影響を与える可能性があります。そこで、いくつかのヒューリスティックに深く掘り下げてみましょう。

#### レンダリングをブロックするリソース

ページにレンダリングをブロックするリソースがあるとは、リソースがページの初期描画（またはレンダリング）を遅らせる場合を指します。これは、ネットワーク経由でロードされる重要なスクリプトやスタイルにとくに当てはまります。Lighthouseには、これらのリソースをチェックする<a hreflang="ja" href="https://developer.chrome.com/docs/lighthouse/performancerender-blocking-resources?hl=ja">監査</a>が含まれており、CrUXの各ウェブサイトのホームページで実行しました。これらのページをどのようにテストしているかについては、[Methodology](./methodology)で詳しく学ぶことができます。

{{ figure_markup(
  image="pages-passing-render-blocking-resources-audit.png",
  caption="レンダリングをブロックするLighthouse監査に合格したページの割合、デバイスと年別。",
  description="棒グラフによると、2021年にモバイルページの19%が「レンダリングをブロックするリソース」監査に合格しました。2022年にはわずかに増加して20%になり、デスクトップの同等のデータも追加され、14%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1619115021&format=interactive",
  sheets_gid="1317344415",
  sql_file="render_blocking_resources.sql"
  )
}}

驚くべきことに、レンダリングをブロックするリソースを持つページの割合に劇的な改善はありませんでした。モバイルページのわずか20%が監査に合格しており、これは昨年からわずか1ポイントの増加に過ぎません。

2022年は、デスクトップのLighthouseデータを持つ最初の年です。したがって、以前の年と比較することはできませんが、デスクトップページがLCPとFCPのパフォーマンスがより良い傾向にあるにもかかわらず、モバイルに比べて監査に合格するデスクトップページがはるかに少ないことは興味深いことです。

#### LCPコンテンツタイプ

LCP要素は、画像、見出し、またはテキストの段落など、さまざまなタイプのコンテンツである可能性があります。

{{ figure_markup(
  image="top-lcp-element-types.png",
  caption="LCP要素として特定の要素を持つページの割合。",
  description="棒グラフによると、`IMG`はデスクトップページの47%、モバイルページの42%でLCP要素です。`DIV`はそれぞれ28%と26%、`P`は6%と9%、`H1`は3%と5%、`undetected`は3%と3%、`SECTION`は3%と3%、`H2`は1%と2%、`A`は1%と2%、`SPAN`は1%と1%、`H3`は0%と1%、`HEADER`は1%と1%、`LI`は1%と1%、`RS-SBG`は1%と1%、`TD`は1%と1%、`VIDEO`は0%と0%、最後に`H4`はデスクトップとモバイルの両方のページで0%のLCP要素タイプです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=932136285&format=interactive",
  sheets_gid="1174093943",
  sql_file="lcp_element_data.sql",
  width=600,
  height=702
  )
}}

画像はもっとも一般的なLCPコンテンツタイプであり、`img`要素はモバイルページの42%でLCPを表しています。モバイルページでは、見出しや段落の要素がLCPとなる可能性がデスクトップページよりもわずかに高く、デスクトップページでは画像要素がLCPとなる可能性が高くなっています。1つの可能な説明は、とくに縦向きのモバイルレイアウトでは、レスポンシブでない画像が小さく表示されるため、見出しや段落のような大きなテキストブロックがLCP要素になるというものです。

2番目に人気のあるLCP要素タイプは`div`です。これは、テキストや背景画像のスタイリングに使用される汎用的なHTMLコンテナーです。これらの要素が画像やテキストを含んでいる頻度を詳しく評価するために、[LCP API](https://developer.mozilla.org/docs/Web/API/LargestContentfulPaint)の`url`プロパティを評価できます。<a hreflang="en" href="https://www.w3.org/TR/largest-contentful-paint/#dom-largestcontentfulpaint-url">仕様</a>によると、このプロパティが設定されている場合、LCPコンテンツは画像でなければなりません。

{{ figure_markup(
  image="top-lcp-content-types.png",
  caption="LCPコンテンツのタイプごとのページの割合。",
  description="棒グラフによると、画像はデスクトップページの82%、モバイルページの72%でLCPコンテンツタイプです。テキストはそれぞれ17%と26%、インライン画像はデスクトップの2%、モバイルの1%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=839846485&format=interactive",
  sheets_gid="872701281",
  sql_file="lcp_resource_type.sql"
  )
}}

モバイルページの72%、デスクトップページの82%が画像をLCPとしています。たとえば、これらの画像は従来の`img`要素やCSSの背景画像である可能性があります。これは、前の図で見た`div`要素の大部分も画像であることを示唆しています。モバイルページの26%、デスクトップページの17%がテキストベースのコンテンツをLCPとしています。

ページの1%が実際にインライン画像をLCPコンテンツとして使用しています。これは、キャッシュや複雑さを中心に、さまざまな理由でほとんど常に悪いアイデアです。

#### LCPの優先順位付け

HTMLドキュメントがロードされた後、LCPリソース自体をいかに早くロードできるかに影響を与える2つの主要な要因があります：発見可能性と優先順位付け。[LCPの発見可能性](#lcpの静的発見可能性)については後で探りますが、まずLCP画像がどのように優先されるかを見てみましょう。

画像はデフォルトでは高優先度でロードされませんが、新しい<a hreflang="ja" href="https://web.dev/articles/fetch-priority?hl=ja">優先度のヒント</a> APIのおかげで、開発者はLCP画像を高優先度でロードするように明示的に設定し、非必須リソースよりも優先させることができます。

{{ figure_markup(
  content="0.03%",
  caption="LCP要素に`fetchpriority=high`を使用しているページの割合。",
  classes="big-number",
  sheets_gid="600760184",
  sql_file="lcp_element_data_2.sql"
  )
}}

0.03%のページがLCP要素に`fetchpriority=high`を使用しています。逆効果的に、いくつかのページは実際にLCP画像の優先度を下げています：モバイルで77ページ、デスクトップで104ページです。

`fetchpriority`はまだ非常に新しく、どこでもサポートされているわけではありませんが、ほとんどの開発者のツールボックスになぜ含まれていないのかについてはほとんど理由がありません。APIを開発した[Patrick Meenan](https://x.com/patmeenan)は、実装が相対的に簡単であることに対して潜在的な改善がどれほど大きいかを考えると、それを「チートコード」と[表現しています](https://x.com/patmeenan/status/1460276602479251457)。

#### LCPの静的発見可能性

LCP画像が早期に発見されることは、ブラウザができるだけ早くそれをロードするための鍵です。上で議論した[prioritization](#lcpの優先順位付け)の改善でさえ、ブラウザが後でリソースをロードする必要があることを知らない場合には役立ちません。

LCP画像が_静的に発見可能_であるとは、そのソースURLがサーバーから送信されたマークアップから直接解析できる場合を指します。この定義には、`picture`または`img`要素内で定義されたソースおよび明示的にプリロードされたソースが含まれます。

1つの注意点は、この定義に基づくと、テキストベースのLCPコンテンツは常に静的に発見可能であるということです。しかし、テキストベースのコンテンツはクライアントサイドレンダリングやWebフォントに依存することがあるため、これらの結果を下限として考えてください。

```html
<img data-src="kitten.jpg" class="lazyload">
```

カスタムの遅延読み込み技術のような上記の例は、画像が静的に発見可能でないようにする方法の1つです。これは、`src`属性を更新するためにJavaScriptに依存しているためです。クライアントサイドのレンダリングもLCPコンテンツを隠す可能性があります。

{{ figure_markup(
  content="39%",
  caption="LCP要素が静的に発見可能でなかったモバイルページの割合。",
  classes="big-number",
  sheets_gid="1465687616",
  sql_file="lcp_preload_discoverable.sql"
  )
}}

モバイルページの39%が静的に発見可能でないLCP要素を持っています。この数字はデスクトップでは44%のページでさらに悪いです。これは、前のセクションの発見によるものかもしれません。それによると、LCPコンテンツがデスクトップページで画像である可能性が高いです。

これは、この指標を見る最初の年なので比較のための歴史的データはありませんが、これらの結果は、LCPリソースのロード遅延を改善する大きな機会があることを示唆しています。

#### LCPのプリロード

LCP画像が静的に発見可能でない場合、<a hreflang="ja" href="https://web.dev/articles/preload-critical-assets?hl=ja">プリロード</a>は、ロード遅延を最小限に抑える効果的な方法です。もちろん、リソースが最初から静的に発見可能であればより良いですが、それに対処するにはページのロード方法を複雑に再構築する必要があります。プリロードは比較的簡単な修正方法であり、単一のHTTPヘッダーまたは`meta`タグで実装できます。

{{ figure_markup(
  content="0.56%",
  caption="LCP画像をプリロードするモバイルページの割合。",
  classes="big-number",
  sheets_gid="1465687616",
  sql_file="lcp_preload_discoverable.sql"
  )
}}

モバイルページの約200分の1だけがLCP画像をプリロードしています。この数字は、LCP画像が静的に発見可能でないページのみを考慮すると約400分の1（0.25%）に低下します。

静的に発見可能な画像をプリロードすることは過剰かもしれませんが、ブラウザは<a hreflang="ja" href="https://web.dev/articles/preload-scanner?hl=ja">プリロードスキャナー</a>のおかげですでに画像について知っているはずです。しかし、プリロードはHTML内で早期に発見される他の静的に発見可能な画像よりも、重要な画像を早くロードするのに役立ちます。たとえば、ヘッダーー画像やメガメニューの画像などです。これは、`fetchpriority`をサポートしていない<a hreflang="en" href="https://caniuse.com/?search=fetchpriority">ブラウザ</a>にとくに当てはまります。

これらの結果は、圧倒的多数のウェブがLCP画像をより発見しやすくすることで恩恵を受ける可能性があることを示しています。LCP画像をより早くロードすること、つまり静的に発見可能にするかプリロードすることは、LCPパフォーマンスを大幅に改善するのに役立ちます。しかし、パフォーマンスに関連するすべてのことと同様に、常に実験を行い、特定のサイトに最適なものが何かを理解してください。

#### LCPイニシエーター

LCPリソースが静的に発見可能でない場合、それが発見されるためには、もっと複雑なプロセスが必要です。

{{ figure_markup(
  image="top-lcp-initiators-among-pages-whose-lcp-is-not-statically-discoverable.png",
  caption="LCPが静的に発見可能でないページで、特定のリソースから開始された割合。",
  description="棒グラフによると、`html`はデスクトップの29%、モバイルの28%のページでイニシエーターです。`css`はそれぞれ11%と9%、`unknown`は5%と4%、そして最後に`other`はデスクトップとモバイルの両方のページで0%のイニシエーターです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1835555974&format=interactive",
  sheets_gid="1866346503",
  sql_file="lcp_initiator_type_undiscoverable.sql"
  )
}}

モバイルページの27%が、プリロードスキャナーがすでに実行された後にHTML内で発見されたLCP画像を持っています。これは通常、スクリプトベースの遅延読み込みやクライアントサイドレンダリングによるものです。

モバイルページの8%は、外部スタイルシートに依存してLCPリソースを持っています。たとえば、`background-image`プロパティを使用します。これにより、リソースのクリティカルリクエストチェーンにリンクが追加され、スタイルシートがクロスオリジンでロードされる場合、LCPパフォーマンスがさらに複雑になる可能性があります。

モバイルページの4%が、私たちが検出できない未発見のLCPイニシエーターを持っています。これらはHTMLとCSSのイニシエーターの組み合わせかもしれません。

スクリプトとスタイルの両方に基づく発見可能性の問題はパフォーマンスに悪いですが、プリロードでその影響を緩和できます。

#### LCP遅延読み込み

Lazy-loadingは、非重要リソースの読み込みを遅らせる（通常はビューポート内または近くになるまで）効果的なパフォーマンス技術です。貴重な帯域幅とレンダリングパワーを解放することで、ブラウザはページ読み込みの早い段階で重要コンテンツを読み込むことができます。問題は、Lazy-loadingをLCPイメージ自体に適用した場合、それがブラウザがそれをはるかに遅くまで読み込むことを防ぐことになる点です。

{{ figure_markup(
  content="9.8%",
  caption="`loading=lazy`を設定しているモバイルページの割合",
  classes="big-number",
  sheets_gid="600760184",
  sql_file="lcp_element_data_2.sql"
  )
}}

`img`ベースのLCPを持つページの約10分の1が、ネイティブの`loading=lazy`属性を使用しています。技術的にこれらの画像は静的に発見可能ですが、ブラウザはページをレイアウトしてビューポート内にあるかどうかを知るまで、それらの読み込みを開始するのを待つ必要があります。定義上、LCPイメージは常にビューポート内にありますので、実際にはこれらのイメージがLazy-loadedされるべきではありませんでした。LCPがビューポートのサイズやディープリンクナビゲーションからの初期スクロール位置によって異なるページでは、LCP候補を積極的に読み込むことで全体的なパフォーマンスが向上するかどうかをテストする価値があります。

このセクションのパーセンテージは、すべてのページではなく、`img`要素がLCPであるページのみに基づいています。参考までに、これはページの42%を占めることを思い出してください。

{{ figure_markup(
  content="8.8%",
  caption="カスタム遅延ロードを使用している画像ベースのLCPを持つモバイルページの割合。",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy.sql"
  )
}}

先に示したように、サイトがネイティブの遅延ロード動作をポリフィルする方法の1つは、画像ソースを`data-src`属性に割り当て、クラスリストに`lazyload`のような識別子を含めることです。その後、スクリプトがこのクラス名を持つ画像のビューポートに対する位置を監視し、`data-src`の値をネイティブの`src`値に切り替えて画像のロードを開始させます。

`img`ベースのLCPを持つページの8.8%がこの種のカスタム遅延ロード動作を使用しており、ネイティブの遅延ロードとほぼ同じ割合です。

LCP画像の遅延ロードの悪影響を超えて、ネイティブ画像の遅延ロードはすべての主要ブラウザによって<a hreflang="en" href="https://caniuse.com/loading-lazy-attr">サポートされています</a>ので、カスタムソリューションは不必要なオーバーヘッドを追加している可能性があります。私たちの意見では、カスタムソリューションが画像のロードタイミングをより細かく制御することができるかもしれませんが、開発者はこれらの余分なポリフィルを取り除き、ユーザーエージェントのネイティブな遅延ロードのヒューリスティクスに委ねるべきです。

ネイティブの遅延ロードを使用するもう1つの利点は、Chromeのようなブラウザが<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=996963">LCP候補である可能性が高い属性を無視するヒューリスティクスを使用することを実験している</a>ことです。これはネイティブの遅延ロードでのみ可能であり、カスタムソリューションはこの場合、改善から恩恵を受けることはありません。

{{ figure_markup(
  content="18%",
  caption="ネイティブまたはカスタムの遅延ロードを使用している画像ベースのLCPを持つモバイルページの割合。",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy.sql"
  )
}}

どちらの技術を使用しているページを見ると、`img`ベースのLCPを持つページの18%がもっとも重要な画像のロードを不必要に遅延させています。

正しく使用された場合、遅延ロードは良いことですが、これらの統計はLCP画像からこの機能を取り除くことでパフォーマンスを大幅に改善する大きな機会があることを強く示唆しています。

WordPressはネイティブの遅延ロード採用の先駆者の1つであり、バージョン5.5から5.9の間、実際にはLCP候補から属性を省略しませんでした。したがって、WordPressがこのアンチパターンにどの程度まだ貢献しているかを探りましょう。

{{ figure_markup(
  content="72%",
  caption="LCP画像にネイティブの遅延ロードを使用しているモバイルページでWordPressを使用している割合。",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy_wordpress.sql"
  )
}}

[CMS](./cms)の章によると、[35%のページがWordPressを使用しています](./cms#もっとも人気のあるcmss)。そのため、2022年1月にバージョン5.9で修正が利用可能になって以来、LCP画像にネイティブの遅延ロードを使用しているページの72%がWordPressを使用していることは驚きです。さらなる調査が必要な1つの理論は、プラグインがWordPressコアに組み込まれたセーフガードを迂回して、ページに遅延ロード動作を持つLCP画像を注入している可能性があるということです。

{{ figure_markup(
  content="54%",
  caption="LCP画像にカスタム遅延ロードを使用しているモバイルページでWordPressを使用している割合。",
  classes="big-number",
  sheets_gid="1585533536",
  sql_file="lcp_lazy_wordpress.sql"
  )
}}

同様に、カスタム遅延ロードを使用しているページの割合がWordPressで作成されたページでは54%と不釣り合いに高いです。これはWordPressエコシステム内で遅延ロードの過剰使用に関するより広範な問題を示唆しています。これはWordPressコアに局所化された修正可能なバグではなく、このアンチパターンに貢献している何百もの別々のテーマやプラグインがある可能性があります。

#### LCPサイズ

LCPリソースをロードする時間に大きく影響する要因の1つが、そのワイヤー上のサイズです。より大きなリソースは自然とロードに時間がかかります。では、画像ベースのLCPリソースはどれくらいの大きさなのでしょうか？

{{ figure_markup(
  image="lcp-image-size-distribution.png",
  caption="画像ベースのLCPリソースのサイズ分布。",
  description="10パーセンタイルでは、デスクトップでのLCP画像サイズは15KB、モバイルでは12KB、25パーセンタイルでは46KBと34KB、50パーセンタイルでは124KBと95KB、75パーセンタイルでは301KBと244KB、そして90パーセンタイルではデスクトップで666KB、モバイルでは565KBであることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1738717687&format=interactive",
  sheets_gid="916137359",
  sql_file="lcp_bytes_distribution.sql"
  )
}}

モバイルの中央値のLCP画像は95KBです。正直、もっと悪いと予想していました！

デスクトップページは、分布全体でより大きなLCP画像を持つ傾向にあり、中央値のサイズは124KBです。

{{ figure_markup(
  content="114,285 KB",
  caption="最大のLCP画像のサイズ。",
  classes="big-number",
  sheets_gid="916137359",
  sql_file="lcp_bytes_distribution.sql"
  )
}}

また、最大のLCP画像サイズを調査し、デスクトップで68,607KB、モバイルで114,285KBの画像を発見しました。これらの極端に大きな外れ値を見るのはおもしろいかもしれませんが、これらが実際のユーザーによって訪れられるアクティブなウェブサイトであるという不幸な現実を忘れないようにしましょう。データは常に無料ではなく、これらのようなパフォーマンスの問題は、計量されたモバイルデータプランのユーザーにとって[アクセシビリティ](./accessibility)の問題になり始めます。これらは、これらのような明らかに過大な画像をロードするためにムダにされるエネルギーを考えると、[サステナビリティ](./sustainability)の問題でもあります。

{{ figure_markup(
  image="lcp-image-size-histogram.png",
  caption="画像ベースのLCPサイズのヒストグラム。",
  description="LCP画像サイズがデスクトップとモバイルのページの1%で0 - 100 KB、43%で100 - 200 KB、それぞれ20%と19%で200 - 300 KB、11%と9%で300 - 400 KB、6%と5%で400 - 500 KB、4%と3%で500 - 600 KB、3%と2%で600 - 700 KB、2%と2%で700 - 800 KB、2%と1%で800 - 900 KB、1%と1%で900 - 1000 KB、そして最後に7%のデスクトップと5%のモバイルページで1000 KBを超えていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=664106183&format=interactive",
  sheets_gid="201472151",
  sql_file="lcp_bytes_histogram.sql"
  )
}}

異なる視点から見ると、上記の図は100KB刻みのヒストグラムとして分布を示しています。この視点からは、LCP画像サイズが主に200KB未満の範囲に落ちることがより明確に見えます。また、モバイルのLCP画像の5%が1,000KBを超えるサイズであることがわかります。

LCP画像が理想的にどれくらいの大きさであるべきかは、多くの要因に依存します。しかし、20のウェブサイトのうち1つが、私たちの[360px幅](./methodology#webpagetest)のモバイルビューポートにメガバイトサイズの画像を提供しているという事実は、サイトの所有者が[レスポンシブ画像](https://developer.mozilla.org/ja/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images)を採用する必要があることを明確に示しています。このトピックに関するさらなる分析については、[メディア](./media#srcset)および[モバイルウェブ](./mobile-web#レスポンシブイメージ)の章を参照してください。

#### LCPフォーマット

LCP画像のフォーマット選択は、そのバイトサイズに[大きな影響を及ぼし](./media#画素あたりのフォーマット別ビット数)、最終的にはそのローディングパフォーマンスに影響します。WebPとAVIFは、JPG（またはJPEG）やPNGといった従来のフォーマットよりも効率的であることがわかっている比較的新しいフォーマットです。

{{ figure_markup(
  image="lcp-image-formats.png",
  caption="LCP画像に使用されるフォーマットのページ割合。",
  description="LCP画像を使用するデスクトップおよびモバイルページの67%で`jpg`がLCP画像フォーマットであり、両方で`png`が26%、`webp`が4%、`gif`が2%、`svg`が1%であり、`avif`、`ico`、`heic`、`heif`は両方とも0%と表示されている棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=98443529&format=interactive",
  sheets_gid="1281945683",
  sql_file="lcp_format.sql"
  )
}}

[メディア](./media#フォーマット採用)の章によると、JPGフォーマットはモバイルページでロードされるすべての画像の約40%を占めます。しかし、モバイルのすべてのLCP画像の67%をJPGが占めており、これは26%のPNGよりも2.5倍一般的です。これらの結果は、ページがLCPリソースとしてデジタルアートワークではなく写真品質の画像を使用する傾向があることを示唆しているかもしれません。なぜなら、写真はPNGと比較してJPGでよりよく圧縮される傾向があるからですが、これは単なる憶測です。

画像ベースのLCPを使用するページの4%がWebPを使用しています。これは画像効率にとって良いニュースですが、AVIFを使用しているのは1%未満です。AVIFはWebPよりもさらによく圧縮されるかもしれませんが、すべての現代のブラウザでサポートされていないため、その採用率は低いです。一方、WebPはすべての現代のブラウザでサポートされているため、その低い採用率はLCP画像とそのパフォーマンスを最適化する大きな機会を示しています。

#### LCP画像の最適化

前のセクションでは、LCPリソースに使用されるさまざまな画像フォーマットの人気を見てきました。開発者がLCPリソースを小さくし、より速くロードするための別の方法は、効率的な圧縮設定を利用することです。JPGフォーマットは、画質をあまり落とさずに不要なバイトを削減するために、損失圧縮できます。しかし、一部のJPG画像は十分に圧縮されていないかもしれません。

Lighthouseには、JPGを圧縮レベル85に設定した際のバイト節約を測定する<a hreflang="ja" href="https://developer.chrome.com/docs/lighthouse/performanceuses-optimized-images?hl=ja">監査</a>が含まれています。画像が結果として4KB以上小さくなる場合、監査は失敗し、最適化の機会と見なされます。

{{ figure_markup(
  image="lcp-image-optimization.png",
  caption="JPGベースのLCP画像のバイト節約のヒストグラム。",
  description="LCPリソースであるJPG画像を最適化することで節約できるバイト数を示す棒グラフ。モバイルページの68%が節約可能なキロバイト数が0、20%が最大100KB、5%が200KB、2%が300KB、1%が400KB、4%が500KB以上です。デスクトップページも似たような分布をしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=894221089&format=interactive",
  sheets_gid="369396330",
  sql_file="lcp_wasted_bytes.sql"
  )
}}

Lighthouseによってフラグが立てられたJPGベースのLCP画像を持つページのうち、68%は損失圧縮のみでLCP画像を改善する機会がありません。これらの結果はやや驚きであり、多くの「ヒーロー」JPG画像が適切な品質設定を使用していることを示唆しています。それにもかかわらず、これらのページの20%は最大100KB、4%は500KB以上節約できます。LCP画像の大多数が200KB以下であることを思い出してください。これはかなりの節約です！

#### LCPホスト

LCP画像自体のサイズと効率性に加えて、それがロードされるサーバーもそのパフォーマンスに影響を与える可能性があります。HTMLドキュメントと同じオリジンからLCP画像をロードする方が、オープンな接続を再利用できるため、通常は速くなります。

しかし、LCP画像はアセットドメインや画像CDNなど、他のオリジンからロードされることがあります。これが発生すると、追加の接続を設定する時間がLCPの許容時間から貴重な時間を奪うことになります。

{{ figure_markup(
  image="cross-hosted-lcp-images.png",
  caption="クロスホストされたLCP画像",
  description="LCP画像が同じホストで使用されているデスクトップが55%、モバイルが48%、クロスホストがそれぞれ23%と21%、その他のコンテンツがLCP要素であるのがデスクトップが21%、モバイルが31%の棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=65223493&format=interactive",
  sheets_gid="139284544",
  sql_file="lcp_host.sql"
  )
}}

モバイルページの5分の1がLCP画像をクロスホストしています。これらのサードパーティホストへの接続を設定する時間は、LCP時間に不必要な遅延を追加する可能性があります。可能な限り、ドキュメントと同じオリジンにLCP画像を自己ホストすることがベストプラクティスです。[リソースヒント](../2021/resource-hints)を使用してLCPオリジンに事前接続する、またはさらに良いことに、画像自体をプリロードできますが、これらの技術は非常に広く採用されていません。

### LCPの結論

LCPのパフォーマンスは、とくにモバイルユーザーにとって、今年大幅に改善しました。それがなぜ起こったのかについての決定的な答えはありませんが、上で提示されたデータはいくつかの手がかりを提供しています。

これまでに見てきたことは、レンダリングをブロックするリソースがまだかなり普及しており、非常に少数のサイトが高度な優先順位付け技術を使用しており、LCP画像の3分の1以上が静的に発見できないということです。サイト所有者や大規模な出版プラットフォームが、これらのLCPパフォーマンスの側面を意図的に最適化していると示唆する具体的なデータがないため、OSやブラウザレベルでの最適化を見る他の場所があります。

2022年3月の<a hreflang="en" href="https://blog.chromium.org/2022/03/a-new-speed-milestone-for-chrome.html#:~:text=Chrome%20continues%20to%20get%20faster%20on%20Android%20as%20well.%20Loading%20a%20page%20now%20takes%2015%25%20less%20time%2C%20thanks%20to%20prioritizing%20critical%20navigation%20moments%20on%20the%20browser%20user%20interface%20thread">Chromiumブログ投稿</a>によると、Androidのローディングパフォーマンスは15%改善されました。投稿は詳細には触れていませんが、この改善は「_ブラウザのユーザーインターフェイススレッド上で重要なナビゲーションの瞬間を優先すること_」によるものとしています。これは、2022年にモバイルパフォーマンスがデスクトップパフォーマンスを上回った理由を説明するのに役立つかもしれません。

今年のLCPの6パーセンテージポイントの改善は、何十万ものウェブサイトのパフォーマンスが改善されたときにのみ起こり得ます。それがどのように起こったのかという魅力的な問いを脇に置いて、ウェブ上のユーザーエクスペリエンスが_改善されている_ことを一瞬、評価しましょう。それは困難な作業ですが、このような改善はエコシステムをより健全にし、祝う価値があります。

## 累積レイアウトシフト（CLS）

累積レイアウトシフト（CLS）は、画面上でコンテンツが予期せず動く量を表すレイアウト安定性メトリックです。ウェブサイトが良好なCLSを持っているとは、サイト全体のナビゲーションの少なくとも75%が0.1以下のスコアを持っている場合を言います。

{{ figure_markup(
  image="good-cls-by-device.png",
  caption="デバイス別の良好なCLS",
  description="ウェブサイトの良好なCLSの割合が2020年の54%から2021年の62%へ、そして2022年には65%へと大幅に増加したことを示す棒グラフ。携帯電話で訪れたサイトでは、2020年には60%のサイトが良好なCLSを達成し、2021年は62%、2022年には74%へと増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=20373607&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

今年、モバイルデバイスでのウェブサイトの「良好な」CLSの割合は大幅に改善し、62%から74%へと向上しました。デスクトップでのCLSも3パーセンテージポイント向上し、65%になりました。

LCPがほとんどのサイトが全体的に良好なCWVと評価されるボトルネックである一方で、今年のモバイルCLSの大幅な改善がCWVの合格率にプラスの影響を与えたことは間違いありません。

モバイルCLSがこれほど大きく改善された理由は何だったのでしょうか？1つの可能性としては、2021年11月中旬にリリースされたChromeの新しく改善された<a hreflang="ja" href="https://web.dev/articles/bfcache?hl=ja">戻る/進むキャッシュ</a>（bfcache）が挙げられます。この変更により、適格なページが戻ると進むナビゲーション中にメモリから綺麗に復元されるようになり、HTTPキャッシュからリソースをフェッチしたり、さらに悪いことにはネットワーク経由でフェッチしてページを再構築する「最初から始める」必要がなくなりました。

{{ figure_markup(
  image="monthly-cls-lcp.png",
  caption="良好なモバイルLCPとCLSを持つウェブサイトの月次時系列。",
  description="モバイルLCPとCLSが良好と評価されるウェブサイトの月次割合を示す折れ線グラフ。良好なCLSを持つウェブサイトの方がLCPを持つウェブサイトよりも多い。CLSの線は2021年6月の62%から始まり、2021年9月に67%へと上昇し、2022年1月からは73%へと跳ね上がります。LCPも増加していますが、トレンドは2021年11月の47%から始まり、2022年5月には54%へと着実に上昇しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1531911610&format=interactive",
  sheets_gid="1879625698",
  sql_file="monthly_cls_lcp.sql"
  )
}}

このグラフは、月次の粒度でのLCPとCLSのパフォーマンスを示しています。2022年1月に始まる2か月間で、Chromeがbfcacheのアップデートをリリースした後、良好なCLSを持つウェブサイトの割合が以前よりもはるかに速く上昇し始めました。

しかし、bfcacheがCLSをこれほど改善した理由は何でしょうか？Chromeがページをメモリから即座に復元する方法により、そのレイアウトは確定しており、通常のローディング中に発生する初期の不安定さの影響を受けません。

LCP体験がそれほど劇的に改善されなかった理由の1つとして、戻る/進むナビゲーションは標準のHTTPキャッシングのおかげですでにかなり速かったためです。良好なLCPの閾値は2.5秒であり、任意のクリティカルリソースがすでにキャッシュにあると仮定すると、これはかなり寛大であり、「良好」な体験をさらに速くする追加ポイントはありません。

### CLSメタデータとベストプラクティス

CLSベストプラクティスにどれだけのウェブが準拠しているか探りましょう。

#### 明示的な寸法

レイアウトシフトを回避するもっとも直接的な方法は、コンテンツのスペースを予約するために寸法を設定することです。たとえば、画像に`height`と`width`属性を使用するなどです。

{{ figure_markup(
  content="72%",
  caption="少なくとも1つの画像に明示的な寸法を設定していないモバイルページの割合。",
  classes="big-number",
  sheets_gid="1160188541",
  sql_file="cls_unsized_images.sql"
  )
}}

モバイルページの72%にサイズが指定されていない画像があります。この統計だけでは全体像を示すことはできません。なぜなら、サイズが指定されていない画像が常にユーザーが認識するレイアウトシフトを引き起こすわけではないからです。たとえば、ビューポートの外でロードされる場合などです。それでも、サイト所有者がCLSベストプラクティスに十分に準拠していない可能性を示す兆候です。

{{ figure_markup(
  image="unsized-images.png",
  caption="サイズが指定されていない画像のページごとの分布。",
  description="10、25、50、75、90パーセンタイルごとの画像のページごとの数を示す棒グラフ。モバイルの値はそれぞれ0、0、2、11、26のサイズが指定されていない画像です。デスクトップページは、50から90パーセンタイルで1から3枚のサイズが指定されていない画像が多いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=449564630&format=interactive",
  sheets_gid="1160188541",
  sql_file="cls_unsized_images.sql"
  )
}}

中央値のウェブページには2枚のサイズが指定されていない画像があり、モバイルページの10%には少なくとも26枚のサイズが指定されていない画像があります。

ページ上にサイズが指定されていない画像があることはCLSにとってリスクですが、おそらくもっと重要な要因は画像のサイズです。大きな画像はより大きなレイアウトシフトに寄与し、CLSを悪化させます。

{{ figure_markup(
  image="unsized-image-height.png",
  caption="サイズが指定されていない画像の高さの分布。",
  description="サイズが指定されていない画像の高さの10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルの値はそれぞれ16、40、99、184、267ピクセルです。デスクトップの値ははるかに大きく、18、42、113、237、410ピクセルです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1273679516&format=interactive",
  sheets_gid="309190465",
  sql_file="cls_unsized_image_height.sql"
  )
}}

モバイルの中央値のサイズが指定されていない画像の高さは99ピクセルです。[テストデバイス](./methodology#webpagetest)のモバイルビューポートの高さが512ピクセルであることを考えると、それはビューポート領域の約20%が下にシフトすることを意味します。仮にコンテンツの幅が全幅であるとします。その画像がロードされたときにビューポート内のどこにあるかによって、最大で0.2の<a hreflang="ja" href="https://web.dev/articles/cls?hl=ja#layout-shift-score">レイアウトシフトスコア</a>を引き起こす可能性があり、「良好」なCLSの0.1の閾値を大幅に超えます。

デスクトップページでは、サイズが指定されていない画像がより大きい傾向があります。デスクトップの中央値のサイズが指定されていない画像の高さは113ピクセルで、90パーセンタイルでは高さが410ピクセルです。

{{ figure_markup(
  content="4,048,234,137,947,990,000px",
  caption="最大のサイズが指定されていない画像の高さ。",
  classes="really-big-number",
  sheets_gid="309190465",
  sql_file="cls_unsized_image_height.sql"
  )
}}

測定エラーであることを願うか、または深刻な間違いを犯したウェブ開発者であることを願うだけですが、私たちが見つけた最大のサイズが指定されていない画像は、信じられないほど4京ピクセルの高さがあります。その画像は非常に大きく、地球から月まで…300万回伸びることができます。それが何らかの1回限りの間違いであっても、次に大きいサイズが指定されていない画像でも高さが33,554,432ピクセルあります。いずれにせよ、それは大きなレイアウトシフトです。

#### アニメーション

一部の<a hreflang="ja" href="https://developer.chrome.com/docs/lighthouse/performancenon-composited-animations?hl=ja">非合成</a> CSSアニメーションはページのレイアウトに影響を与え、CLSに貢献する可能性があります。<a hreflang="ja" href="https://web.dev/articles/optimize-cls?hl=ja#animations-%F0%9F%8F%83%E2%80%8D%E2%99%80%EF%B8%8F">ベストプラクティス</a>は、代わりに`transform`アニメーションを使用することです。

{{ figure_markup(
  content="38%",
  caption="非合成アニメーションを持つモバイルページの割合。",
  classes="big-number",
  sheets_gid="309190465",
  sql_file="cls_unsized_image_height.sql"
  )
}}

38%のモバイルページがこれらのレイアウトを変更するCSSアニメーションを使用し、CLSを悪化させるリスクを冒しています。使用されていない画像の問題と同様に、CLSにとってもっとも重要なのは、アニメーションがビューポートに対してどの程度レイアウトに影響を与えるかの度合いです。

{{ figure_markup(
  image="animations.png",
  caption="非合成アニメーションのページごとの分布。",
  description="非合成アニメーションのページごとの数の10、25、50、75、90パーセンタイルを示す棒グラフ。75パーセンタイルで、ページは2回非合成アニメーションを使用し、90パーセンタイルではモバイルで10回、デスクトップで11回使用します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=6443199&format=interactive",
  sheets_gid="603122500",
  sql_file="cls_animations.sql"
  )
}}

上記の分布から、ほとんどのページはこのタイプのアニメーションを使用しておらず、使用しているページも控えめに使用していることがわかります。75パーセンタイルで、ページはこれらを2回使用します。

#### フォント

ページの読み込みプロセスではブラウザがWebフォントを発見し、リクエストし、ダウンロードし、適用するまでに時間がかかることがあります。これがすべて行われている間、テキストがすでにページ上にレンダリングされている可能性があります。Webフォントがまだ利用できない場合、ブラウザはシステムフォントでテキストをレンダリングすることをデフォルトとします。Webフォントが利用可能になったときに、システムフォントでレンダリングされた既存のテキストがWebフォントに切り替わると、レイアウトシフトが発生します。レイアウトシフトの量は、フォント同士の違いによって異なります。

{{ figure_markup(
  content="82%",
  caption="Webフォントを使用しているモバイルページの割合。",
  classes="big-number",
  sheets_gid="https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/edit#gid=1517999851",
  sql_file="../fonts/font_usage_over_time.sql"
  )
}}

ページの82%がWebフォントを使用しているため、このセクションはほとんどのサイトオーナーにとって非常に関連があります。

{{ figure_markup(
  image="font-display-usage.png",
  caption="`font-display`値の採用。",
  description="さまざまな`font-display`値を使用しているページの割合を示す棒グラフ。モバイルページの29%がswapを使用し、17%がblock、8%がauto、2%がfallback、1%未満がoptionalを使用しています。デスクトップの値も同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1648924039&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/edit#gid=1599822681&range=G11",
  sql_file="../fonts/font_display_usage.sql"
  )
}}

フォントによるレイアウトシフトを回避する1つの方法は、[`font-display: optional`](https://developer.mozilla.org/ja/docs/Web/CSS/@font-face/font-display)を使用することで、これはシステムテキストがすでに表示された後にWebフォントを交換することは決してありません。しかし、[フォント](./fonts#フォント表示)の章で指摘されているように、この指示を活用しているページは1%未満です。

`optional`はCLSには良いですが、UXのトレードオフがあります。サイトオーナーは、好ましいフォントをユーザーに表示できるということであれば、レイアウトの不安定さや目立つスタイル未適用テキストのフラッシュ（FOUT）を受け入れるかもしれません。

Webフォントを隠すのではなく、もう1つのCLSを軽減する戦略は、できるだけ早くそれらを読み込むことです。うまくいけば、システムテキストがレンダリングされる前にWebフォントが表示されるでしょう。

{{ figure_markup(
  image="fonts-resource-hints.png",
  caption="フォントリソースに対するリソースヒントの採用。",
  description="Webフォントの各種リソースヒントを使用しているページの割合を示す棒グラフ。モバイルページの32%がdns-prefetchを使用し、20%がpreload、16%がpreconnect、2%がpreloadです。デスクトップの値も同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1831399490&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/edit#gid=592046045&range=F11",
  sql_file="../fonts/resource_hints_usage.sql"
  )
}}

[フォント](./fonts#リソースのヒント)の章によると、モバイルページの20%がWebフォントをプリロードしています。フォントをプリロードする際の1つの課題は、Googleフォントのようなサービスを使用している場合、正確なURLが事前にわからないことがあります。フォントホストへのプリコネクトは、パフォーマンスにとって次善の選択肢ですが、その使用しているページは16%に過ぎず、DNSのプリフェッチを使用するページの半分です。

#### bfcacheの適格性

CLSに対してbfcacheがどれほど影響力があるかを示しましたので、間接的なベストプラクティスとして適格性を考慮する価値があります。

特定のページがbfcacheに適格であるかどうかを確認する最良の方法は、<a hreflang="ja" href="https://web.dev/articles/bfcache?hl=ja#test-to-ensure-your-pages-are-cacheable">DevToolsでテストする</a>ことです。残念ながら、<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1li0po_ETJAIybpaSX5rW_lUN62upQhY0tH4pR5UPt60/edit?usp=sharing">100以上の適格性基準</a>があり、その多くはラボで測定することが難しい、または不可能です。したがって、bfcache適格性を全体として見るのではなく、より簡単に測定できるいくつかの基準を見て、適格性の下限を感じ取りましょう。

{{ figure_markup(
  image="bfcache-unload.png",
  caption="サイトのランク別の`unload`の使用。",
  description="サイトの人気度ランクごとにグループ化された、`unload`ハンドラーを設定してbfcacheの対象外となるページの割合を示す棒グラフ。上位1千のモバイルページの36%がこのハンドラーを設定しており、上位1万では33%、上位10万では27%、上位100万では21%、すべてのモバイルページでは17%です。デスクトップページは、ランクを問わず数パーセンテージポイント高い頻度で`unload`ハンドラーを使用する傾向があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=63175690&format=interactive",
  sheets_gid="996465265",
  sql_file="bfcache_unload.sql"
  )
}}

[`unload`](https://developer.mozilla.org/ja/docs/Web/API/Window/unload_event)イベントは、ページが去る（アンロードされる）プロセスにあるときに作業を行うために推奨されない方法です。それを行うための<a hreflang="ja" href="https://web.dev/articles/bfcache?hl=ja#never-use-the-unload-event">より良い方法</a>があることに加えて、それはページをbfcacheの対象外にする方法の1つでもあります。

すべてのモバイルページの17%がこのイベントハンドラーを設定していますが、ウェブサイトの人気度が高いほど状況は悪化します。上位1千のモバイルページでは、この理由でbfcacheの対象外となるページが36%あります。

{{ figure_markup(
  image="bfcache-nostore.png",
  caption="サイトのランク別の`Cache-Control: no-store`の使用。",
  description="メインドキュメントに`Cache-Control: no-store`ヘッダーを設定することでbfcacheの対象外となるページの割合を示す棒グラフ。上位1千のモバイルページの28%がこのヘッダーを設定し、上位1万では27%、上位10万では28%、上位100万では27%、すべてのモバイルページでは22%です。デスクトップページは、最大で2パーセンテージポイント高い頻度でこのヘッダーを使用します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1655848232&format=interactive",
  sheets_gid="1063873438",
  sql_file="bfcache_cachecontrol_nostore.sql"
  )
}}

[`Cache-Control: no-store`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Cache-Control#no-store)ヘッダーは、ユーザーエージェントに特定のリソースを決してキャッシュしないように指示します。メインHTMLドキュメントに設定された場合、この設定はページ全体をbfcacheの対象外にします。

すべてのモバイルページの22%がこのヘッダーを設定しており、上位1千のモバイルページでは28%です。`unload`基準とこの基準は排他的ではないため、組み合わせると、少なくとも22%のモバイルページがbfcacheの対象外であると言えます。

繰り返しますが、これらのことがCLSの問題を引き起こすわけではありません。しかし、これらを修正することで、ページをbfcacheの対象とすることができ、レイアウトの安定性を間接的にしかし強力に改善することが示されています。

### CLSの結論

CLSは2022年にもっとも改善されたCWVメトリックであり、全体的に「良好」なCWVを持つウェブサイトの数に顕著な影響を与えたようです。

この改善の原因は、Chromeのbfcacheの導入にあると思われます。これは2022年1月のCrUXデータセットに反映されています。しかし、少なくとも5分の1のサイトが、攻撃的な`no-store`キャッシングポリシーまたは`unload`イベントリスナーの推奨されない使用のために、この機能の対象外となっています。これらのアンチパターンを修正することは、パフォーマンスを改善するためのCLSの「奇妙なトリック」です。

サイトオーナーがCLSを直接改善するための他の方法もあります。画像に`height`および`width`属性を設定することがもっとも簡単な方法です。アニメーションのスタイルの最適化やフォントの読み込み方法の最適化も、考慮すべき他の2つを認めることはより複雑なアプローチです。

## 最初の入力までの遅延 (FID)

<a hreflang="ja" href="https://web.dev/articles/fid?hl=ja">最初の入力までの遅延</a>（FID）は、クリックやタップのような最初のユーザーのインタラクションから、ブラウザが対応するイベントハンドラーーの処理を開始するまでの時間を測定します。ウェブサイトが「良好」なFIDを持っている場合、サイト全体のナビゲーションの少なくとも75パーセントが100ミリ秒未満で完了します。

{{ figure_markup(
  image="good-fid-by-device.png",
  caption="デバイス別の良好なFID",
  description="棒グラフは、2020年、2021年、2022年の100%のウェブサイトが良好なFIDを持っていたことを示しています。携帯電話で訪問されたサイトでは、2020年の80%から2021年には90%へ、そして2022年には92%へと増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1546220733&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

事実上すべてのウェブサイトがデスクトップユーザーに対して「良好」なFIDを持っており、この傾向は年を経ても変わっていません。モバイルのFIDパフォーマンスも非常に高速で、92%のウェブサイトが「良好」なFIDを持っており、昨年に比べてわずかに改善されています。

これほど多くのウェブサイトが良好なFID体験を提供しているのは素晴らしいことですが、開発者は自己満足に陥らないよう注意が必要です。Googleは<a hreflang="ja" href="https://web.dev/blog/better-responsiveness-metric?hl=ja">新しい応答性メトリックの実験を行っており</a>、それがFIDに取って代わる可能性があります。とくに、サイトは[FIDに比べてこの新しいメトリック](./#インタラクションから次の描画)でかなり悪いパフォーマンスを示す傾向にあるため、これはとくに重要です。

### FIDのメタデータとベストプラクティス

ウェブ全体で応答性を改善する方法について、もっと深く掘り下げてみましょう。

#### ダブルタップズームを無効にする

Chromeを含む一部のモバイルブラウザは、ユーザーが<a hreflang="ja" href="https://developer.chrome.com/blog/300ms-tap-delay-gone-away?hl=ja">ダブルタップしてズームする</a>ことを試みていないことを確認するため、タップ入力を処理する前に少なくとも250ミリ秒待ちます。"良好"なFIDの閾値が100ミリ秒であることを考えると、この振る舞いは評価を通過することが不可能になります。

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

修正は簡単です。上記のような`meta`ビューポートタグをドキュメントのヘッドに含めることで、ブラウザにデバイスの幅と同じ幅でページをレンダリングするよう促し、テキストコンテンツをより読みやすくし、ダブルタップでのズームが不要になります。

これはレスポンシブネスを意味のある方法で改善するためのもっとも迅速で、簡単で、侵入性の低い方法の1つであり、すべてのモバイルページで設定されるべきです。

{{ figure_markup(
  content="7.3%",
  caption="ビューポート`meta`タグを設定していないモバイルページの割合。",
  classes="big-number",
  sheets_gid="1839727600",
  sql_file="viewport_meta_zoom_disable.sql"
  )
}}

モバイルページの7.3%が`meta`ビューポートディレクティブを設定していません。"良好"なFIDの基準を満たしていないモバイルウェブサイトが約8%あることを思い出してください。これは、サイトのレスポンシブネスを不必要に遅くしているウェブの大きな割合です。これを修正することは、FID評価に合格するか否かの違いを意味するかもしれません。

#### トータルブロッキングタイム (TBT)

<a hreflang="ja" href="https://web.dev/articles/tbt?hl=ja">トータルブロッキングタイム</a> (TBT)は、<a hreflang="ja" href="https://web.dev/articles/fcp?hl=ja">視覚コンテンツの初期表示時間</a> (FCP)と<a hreflang="ja" href="https://web.dev/articles/tti?hl=ja">操作可能になるまでの時間</a> (TTI)の間の時間で、メインスレッドがブロックされ、ユーザー入力に応答できなかった総時間を表します。

TBTは、シンセティックテストでユーザーインタラクションを現実的にシミュレートすることの課題を考慮して、FIDのラボベースの代理としてよく使用されます。

{{ figure_markup(
  image="tbt.png",
  caption="ページごとのラボベースTBTの分布。",
  description="モバイルページの10、25、50、75、および90パーセンタイルのラボベースTBTごとの棒グラフ。モバイルページの値はそれぞれ0.2、0.6、1.7、3.6、および6.4秒です。デスクトップページの値は、上位50パーセントで100ミリ秒未満、75パーセンタイルで約250ミリ秒、90パーセンタイルで600ミリ秒と、はるかに速いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1459512477&format=interactive",
  sheets_gid="528722499",
  sql_file="fid_tbt.sql"
  )
}}

これらの結果は、HTTP ArchiveデータセットのページのラボベースのTBTパフォーマンスから得られたものであることに注意してください。これは重要な区別です。なぜなら、これまでのところ、私たちはCrUXデータセットからの実際のユーザーパフォーマンスデータを見てきたからです。

それを念頭に置いて、モバイルページはデスクトップページよりもTBTが著しく悪いことがわかります。これは驚くことではありません。なぜなら、私たちの[Lighthouse](./methodology#lighthouse)モバイル環境は、低端のモバイルデバイスをエミュレートする方法でCPUを制限するように意図的に設定されているからです。それにもかかわらず、結果は中央値のモバイルページがTBTが1.7秒であることを示しており、これが実際のユーザー体験であれば、FCPから1.7秒以内のタップは反応しないことを意味します。90パーセンタイルでは、ユーザーはページが反応するまで6.3秒待たなければなりません。

これらの結果はシンセティックテストから得られたものであるにもかかわらず、実際のウェブサイトが提供する実際のJavaScriptに基づいています。同様のハードウェアを持つ実際のユーザーがこれらのサイトのいずれかにアクセスしようとした場合、そのTBTはあまり変わらないかもしれません。それにもかかわらずTBTとFIDの主な違いは、後者がユーザーがページと実際に対話することに依存していることであり、彼らはTBTウィンドウの前、中、または後のいつでもこれを行うことができすべてが大きく異なるFID値につながります。

#### 長時間タスク

<a hreflang="ja" href="https://web.dev/articles/long-tasks-devtools?hl=ja">長時間タスク</a>は、メインスレッドが入力に応答できない、少なくとも50ミリ秒のスクリプトによるCPUアクティビティの期間です。ユーザーがその時にページと対話しようとすると、どんな長時間タスクでも応答性の問題を引き起こす可能性があります。

上記のTBT分析のように、このセクションはラボベースのデータからの情報を引用しています。その結果、ページのロード観測ウィンドウ中にのみ長時間タスクを測定できます。このウィンドウは、ページがリクエストされた時点から始まり、60秒後またはネットワークの非活動状態が3秒続いた後のどちらか早い方で終了します。実際のユーザーは、ページの全生存期間中に長時間タスクを経験する可能性があります。

{{ figure_markup(
  image="long-tasks.png",
  caption="ページごとのラボベースの長時間タスクの分布。",
  description="モバイルおよびデスクトップでのページごとのラボベースの長時間タスクの合計の10、25、50、75、および90パーセンタイルを示す棒グラフ。モバイルでは、ページごとの長時間タスクの値は0.8、1.7、3.3、5.3、および8.0秒です。デスクトップでは、最初の50%で100ミリ秒未満、75パーセンタイルで700ミリ秒、90パーセンタイルで1.4秒と、はるかに高速です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1004723255&format=interactive",
  sheets_gid="1849899474",
  sql_file="fid_long_tasks.sql"
  )
}}

中央値のモバイルウェブページは、長時間タスクで3.3秒分を有していますが、デスクトップページは0.4秒分のみです。再び、これはCPU速度が応答性のヒューリスティックスに大きな影響を与えていることを示しています。90パーセンタイルでは、モバイルページは少なくとも8.0秒の長時間タスクを有しています。

これらの結果は、TBT時間の分布よりもかなり高いことに注意する価値があります。TBTはFCPとTTIによって制限され、FIDはCPUがどれだけ忙しいかとユーザーがページと対話しようとするタイミングの両方に依存します。これらのTTI後の長時間タスクも、最初のインタラクション中に発生しない限り、FIDによって表されないため、イライラする応答性の経験を作り出す可能性があります。これは、ページの全生存期間を通じてユーザーの経験をより包括的に表すフィールドメトリックが必要な理由の1つです。

### インタラクションから次の描画 (INP)

<a hreflang="ja" href="https://web.dev/articles/inp?hl=ja">インタラクションから次の描画</a> (INP)は、ユーザーインタラクションに応答してブラウザが次のペイントを完了するまでの時間を測定します。このメトリックは、応答性を測定する方法を改善する提案についてGoogleが<a hreflang="ja" href="https://web.dev/blog/responsiveness?hl=ja">フィードバックを求めた</a>後に作成されました。多くの読者がこのメトリックについてはじめて聞くことになるので、それがどのように機能するかについてもう少し詳しく説明する価値があります。

この文脈での_インタラクション_とは、ユーザーがWebアプリケーションに入力を提供し、次のフレームの視覚フィードバックが画面に描かれるのを待つユーザー体験を指します。INPに考慮される唯一の入力は、クリック、タップ、およびキープレスです。INPの値自体は、ページ上の最悪のインタラクションレイテンシーのうちの1つから取られます。<a hreflang="ja" href="https://web.dev/articles/inp?hl=ja#what-is-inp">INPのドキュメント</a>で、それがどのように計算されるかの詳細を参照してください。

FIDとは異なり、INPはページ上の最初のインタラクションだけでなく、すべてのインタラクションを測定します。また、イベントハンドラーーが処理を開始するまでの時間のみを測定するFIDとは異なり、次のフレームが描かれるまでの全時間を測定します。これらの点において、INPはページ上の包括的なユーザー体験をより代表するメトリックです。

ウェブサイトは、INP体験の75%が200ミリ秒より速い場合、「良好」と評価されます。75パーセンタイルが500ミリ秒以上である場合、ウェブサイトは「悪い」と評価されます。それ以外の場合は、INPは「改善が必要」と評価されます。

{{ figure_markup(
  image="inp-device.png",
  caption="デバイス別のINPパフォーマンスの分布。",
  description="デバイス別に良好、改善が必要、または悪いINPを持つウェブサイトの割合を示す棒グラフ。デスクトップウェブサイトの95%が良好なINPを持ち、4%が改善が必要で、1%が悪いです。モバイルウェブサイトの55%が良好なINPを持ち、36%が改善が必要で、8%が悪いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=755106375&format=interactive",
  sheets_gid="555510064",
  sql_file="web_vitals_by_device.sql"
  )
}}

モバイルでのウェブサイトの55%が「良好」なINPを持ち、36%が「改善が必要」で、8%が「悪い」INPを持っています。デスクトップのINPの話はFIDに似ており、ウェブサイトの95%が「良好」と評価され、4%が「改善が必要」で、1%が「悪い」と評価されています。

デスクトップとモバイルユーザーのINP体験の著しい格差は、FIDと比較してもはるかに広がっています。これは、ウェブサイトが行う圧倒的な作業量にモバイルデバイスが追いついていない程度を示しており、<a hreflang="en" href="https://httparchive.org/reports/state-of-javascript?start=earliest&end=latest&view=grid#bytesJs">JavaScript</a>への依存度が増していることが主な要因であると指摘しています。

#### ランク別INP

ウェブ全体でINPパフォーマンスがどれだけ不均等に分布しているかを見るために、ウェブサイトを人気ランキングでセグメント化すると便利です。

{{ figure_markup(
  image="inp-mobile-performance-by-rank.png",
  caption="ランク別のモバイルINPパフォーマンス。",
  description="ランクによってセグメント化されたモバイルデバイス上のINPパフォーマンスを示す積み上げ棒グラフ。トップ1,000サイトの27%が良好なINP体験を提供し、52%が改善が必要なINP体験を提供し、20%が悪いINP体験を提供しています。トップ10,000サイトではそれぞれ25%、50%、24%、トップ100,000サイトでは31%、50%、18%、トップ1,000,000サイトでは42%、46%、12%、そして全サイトでは55%が良好、27%が改善が必要、5%が悪い体験となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1034889047&format=interactive",
  sheets_gid="805166525",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

もっとも人気のあるトップ1kウェブサイトの27%が良好なモバイルINPを提供しています。サイトの人気度が下がるにつれて、良好なモバイルINPを持つ割合は少し変わります。トップ10kランクで25%に悪化し、トップ100kで31%に改善し、トップ100万で41%になり、最終的には全ウェブサイトで55%になります。トップ1kを除いて、INPパフォーマンスはサイトの人気度に反比例するようです。

{{ figure_markup(
  image="js-bytes-rank.png",
  caption="ランク別、ページあたりにロードされるJavaScriptの中央値。",
  description="デバイスとサイトランクごとにグループ化された、ページあたりのJavaScriptのキロバイト数の中央値を示す棒グラフ。トップ1千のモバイルページの中央値は604KBのJavaScriptをロードし、トップ1万では680KB、トップ10万では610KB、トップ100万では583KB、全体では462KBをロードします。デスクトップの値は同じ傾向にあり、数十キロバイト大きいです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=1725756250&format=interactive",
  sheets_gid="1423103831",
  sql_file="js_bytes_rank.sql"
  )
}}

これらのランクごとにモバイルページがロードするJavaScriptの量を見ると、同じおもしろいパターンに従います！トップ1kのモバイルページの中央値は604KBのJavaScriptをロードし、トップ10kでは680KBに増加し、全ウェブサイトでは462KBまで下がります。これらの結果は、多くのJavaScriptをロードして使用することが必ずしも悪いINPを引き起こすわけではないが、確かに相関関係が存在することを示唆しています。

#### INPが仮想のCWVメトリックとして

INPは公式のCWVメトリックではありませんが、GoogleのCWVプログラムのテックリードである[Annie Sullivan](https://x.com/anniesullie)は、その将来について[コメント](https://x.com/anniesullie/status/1535208365374185474)しています。"_INPはまだ実験段階です！まだコアウェブバイタルではありませんが、FIDを置き換えることができればと思っています。_"

これは興味深い疑問を提起します：仮にINPが今日CWVメトリックであったら、合格率はどのように異なるでしょうか？

{{ figure_markup(
  image="cwv-fid-inp-device.png",
  caption="デバイス別、FIDとINPを使用した良好なCWVを持つウェブサイトの割合の比較。",
  description="FIDまたはINPを応答性メトリックとして使用した場合の、良好なCWVを持つウェブサイトの割合を示す棒グラフ。デスクトップウェブサイトの44%がFIDで良好なCWVを持ち、INPでは43%です。モバイルウェブサイトでは、FIDで40%が良好なCWVを持ち、INPでは31%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=56387241&format=interactive",
  sheets_gid="805166525",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

デスクトップ体験では、状況はあまり変わりません。ウェブサイトの43%がINPで良好なCWVを持つでしょうが、FIDでは44%です。

しかし、モバイル体験のウェブサイト間での差ははるかに劇的で、INPで良好なCWVを持つものは31%に減少し、FIDでは40%です。

{{ figure_markup(
  image="cwv-fid-inp-rank.png",
  caption="ランク別、モバイルウェブサイトのFIDとINPで良好なモバイルCWVを持つ割合の比較。",
  description="FIDまたはINPを応答性メトリックとして使用した場合の、良好なCWVを持つモバイルウェブサイトの割合を示す棒グラフ。トップ1千のもっとも人気のあるモバイルウェブサイトの52%がFIDで良好なCWVを持ち、INPでは20%です。トップ1万ではFIDで42%、INPで18%。トップ10万ではFIDで38%、INPで20%。トップ100万ではFIDで38%、INPで25%。全ウェブサイトではFIDで40%、INPで31%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=2082509168&format=interactive",
  sheets_gid="805166525",
  sql_file="web_vitals_by_rank_and_device.sql"
  )
}}

サイトランクによるモバイル体験を見ると、状況はさらに厳しくなります。FIDで良好なCWVを持つトップ1kのウェブサイトは52%ですが、INPでは20%のみが良好なCWVを持つことになり、32パーセンテージポイントの減少となります。したがって、もっとも人気のあるウェブサイトはFIDと比較して全ウェブサイト（52%対40%）で過剰にパフォーマンスを発揮していますが、INPでは実際には_不十分_（20%対31%）です。

この話はトップ10kウェブサイトにも似ており、CWVとしてのINPによって24パーセンテージポイント減少します。このランクのウェブサイトは、INPで良好なCWVの最低率を持つことになります。前のセクションで見たように、これはJavaScriptの使用量がもっとも高いランクでもあります。人気が低いランクになるにつれて、FIDとINPの良好なCWV率は収束し、それぞれ18、13、9パーセンテージポイントの差に減少します。

これらの結果は、もっとも人気のあるウェブサイトがINPを改善するためにもっとも努力が必要であることを示しています。

{{ figure_markup(
  image="cwv-inp-tech.png",
  caption="技術別、FIDからINPへの切り替えによる良好なCWVを持つウェブサイトの割合の変化。",
  description="FIDからINPへの切り替えによってCWV評価に合格しなくなるモバイルウェブサイトの割合を、使用されているCMSやJavaScriptフレームワークによってグループ化して示す棒グラフ。人気のある技術の減少順に値は次のとおりです: WordPress 6%、React 11%、WooCommerce 3%、Shopify 6%、Vue.js 8%、RequireJS 10%、Wix 15%、Joomla 6%、Drupal 8%、1C-Bitrix 39%、Squarespace 1%、AMP 10%、PrestaShop 7%、Emotion 10%、Angular 5%、Magento 6%、TYPO3 CMS 6%、Nuxt.js 9%、Duda 14%、Adobe Experience Manager 9%、Gatsby 14%、GoDaddy Website Builder 10%、Pixnet 86%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vR-dJP3uphZoGE5A_luniNBFm5V2ww6irfOxANg0hrMid7gjgrtchsN_utOIDOvVZUjIwpmUBb27nHF/pubchart?oid=457714899&format=interactive",
  height=632,
  sheets_gid="1104559069",
  sql_file="web_vitals_by_technology.sql"
  )
}}

このチャートでは、FIDがINPに置き換えられた場合に「良好」なCWVとみなされなくなる特定の技術のウェブサイトの割合を見ています。

このチャートで目立つのは、CMSである1C-BitrixとPixnetで、これらはINPでCWV評価に合格しなくなるウェブサイトの膨大な割合を持っています。Pixnetは、98%から13%に下がり、ウェブサイトの86%が失われる可能性があります！1C-Bitrixの合格率は、79%から40%に減少し、39%の差があります。

Reactフレームワークを使用するウェブサイトの11%がもはやCWVに合格しなくなります。Wixは現在[2番目に人気のあるCMS](./cms#most-popular-cmss)で、Reactを使用しています。そのウェブサイトの15%が「良好」なCWVを持たなくなります。ただし、比例してWixウェブサイトは依然としてReactウェブサイト全体よりもCWVに合格する割合が高くなります、それぞれ24%と19%ですが、INPはその差を縮めるでしょう。

リストの中でもっとも人気のある技術であるWordPressは、230万のウェブサイトの6%がもはや「良好」なCWVを持たなくなります。その合格率は、30%から24%に減少します。

Squarespaceは、この仮説的な変更による動きがもっとも少ないでしょう。ウェブサイトの「良好」なCWVを持つものが1%しか失われません。これは、Squarespaceのウェブサイトが最初のインタラクションが速いだけでなく、ページ体験全体を通じて一貫して速いインタラクションを持っていることを示唆しています。実際に、<a hreflang="en" href="https://datastudio.google.com/s/sM9D7EUjxU8">CWVテクノロジーレポート</a>は、INPで他のCMSを大きく上回っており、ウェブサイトの80%以上がINPの閾値をクリアしていることを示しています。

#### INPとTBT

INPがFIDよりも優れた反応性メトリックである理由は何か？その質問に答える1つの方法は、フィールドベースのINPとFIDのパフォーマンスと、ラボベースのTBTパフォーマンスとの相関を見ることです。TBTはページがどれだけ反応しない可能性があるかの直接的な測定ですが、実際には「ユーザーが感じる体験」を測定しないため、CWV自体にはなり得ません。

このセクションは、2022年5月のデータセットを使用したAnnie Sullivanの<a hreflang="en" href="https://colab.sandbox.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">研究</a>に基づいています。

{{ figure_markup(
  image="tbt-fid.png",
  alt="",
  caption='FIDとTBTの相関を視覚化する散布図。(<a hreflang="en" href="https://colab.sandbox.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">出典</a>)',
  description="フィールドベースのFIDとラボベースのTBTの相関を示す散布図。ほとんどのFID値は0-50msの範囲内で、TBT値は0-10秒の幅広い範囲にわたります。250ms周辺のFID値と約0msのTBTを持つ小さなクラスターがあります。"
  )
}}

このチャートは、ページのFIDとTBTの反応性の関係を示しています。100 msの固定水平線は「良い」FIDの閾値を表し、ほとんどのページはこの閾値の下に快適に収まります。

このチャートのもっとも注目すべき属性は、左下の角に密集した領域であり、TBT軸に沿って広がっているように見えます。この広がりの長さは、高いTBTと低いFIDを持つページを表し、FIDとTBTの間の相関の低さを示しています。

また、低いTBTと約250 msのFIDを持つページのパッチもあります。この領域は、`<meta name=viewport>`タグが欠けているために<a hreflang="en" href="https://developer.chrome.com/blog/300ms-tap-delay-gone-away">タップ遅延</a>の問題を持つページを表しています。これらはこの分析の目的のために安全に無視できる外れ値です。

この分布の<a hreflang="ja" href="https://ja.wikipedia.org/wiki/%E3%82%B1%E3%83%B3%E3%83%89%E3%83%BC%E3%83%AB%E3%81%AE%E9%A0%86%E4%BD%8D%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0">ケンドール</a>と<a hreflang="ja" href="https://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%94%E3%82%A2%E3%83%9E%E3%83%B3%E3%81%AE%E9%A0%86%E4%BD%8D%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0">スピアマン</a>の相関係数はそれぞれ0.29と0.40です。

{{ figure_markup(
  image="tbt-inp.png",
  caption='INPとTBTの相関を視覚化する散布図。(<a hreflang="en" href="https://colab.sandbox.google.com/drive/12lJmAABgyVjaUbmWvrbzj9BkkTxw6ay2">出典</a>)',
  description="フィールドベースのINPとラボベースのTBTの相関を示す散布図。ほとんどのINP値は0-750msの範囲内で、TBT値は0-5秒の範囲にわたります。"
  )
}}

これは同じチャートですが、FIDの代わりにINPです。「良い」INPのための200 msの閾値を表す固定水平線がここにあります。FIDと比較して、この線の上にあるページが多く、「良い」と評価されないページが多いです。

このチャートのページは、FIDとTBTの間の相関度が高いことを示す左下の角により密集しています。まだ広がりがありますが、それほど顕著ではありません。

この分布のケンドールとスピアマンの相関係数はそれぞれ0.34と0.45です。

<figure>
  <blockquote>
  <p>まず、INPはTBTと相関していますか？FIDよりもTBTとの相関が強いですか？はい、そうです！</p>
  <p>しかし、両方のメトリックがTBTと相関しています。INPはメインスレッドをブロックするJavaScriptの問題をより多く捕捉していますか？「良い」閾値を満たすサイトの割合を分解することで、はい、そうです！</p>
  </blockquote>
  <figcaption>—Annie Sullivanの<a href="https://x.com/anniesullie/status/1525161893450727425">Twitter</a>にて</figcaption>
</figure>

Annieが指摘するように、両方のメトリクスはTBTと相関していますが、彼女はINPがより強く相関していると結論づけ、それをより良い反応性メトリックとしています。

### FIDの結論

これらの結果は、FIDによって描かれる明るい絵とは裏腹に、サイトには確かに反応性の問題があることを示しています。INPがCWVメトリックになるかどうかにかかわらず、今からそれを最適化し始めると、ユーザーは感謝するでしょう。

ほぼ10分の1のモバイルサイトが、ダブルタップズームを無効にすることを怠ることで、無料のパフォーマンスを放棄しています。これはすべてのサイトが行うべきことです。HTMLの一行だけで、FIDとINPの両方に利益をもたらします。ページでLighthouseを実行し、<a hreflang="ja" href="https://developer.chrome.com/docs/lighthouse/pwaviewport?hl=ja">ビューポート</a>の監査が確実に行われていることを確認してください。

CWVとしてのINPを仮定して見ると、FIDレベルに戻るだけでなく、どれだけ多くの作業が必要であるかがわかります。とくにJavaScriptの（過度な）使用の結果として、もっとも人気のあるモバイルウェブサイトはこのような変更の影響を受けやすいです。CMSやJavaScriptフレームワークの中には、他よりも大きな影響を受けるものがあり、クライアント側で行う作業の量を集団で抑制するためには、エコシステム全体の努力が必要になります。

## 結論

業界がCWVについてさらに学び続けるにつれて、実装面でも全体的なトップレベルメトリック値でも、着実な改善が見られます。もっとも顕著なパフォーマンス最適化の進歩は、その影響が一度に多くのサイトで感じられるため、プラットフォームレベルで行われています。たとえば、Androidとbfcacheの改善などです。しかし、パフォーマンスパズルのもっとも捉えどころのない部分、つまり個々のサイトオーナーに注目しましょう。

CWVを検索ランキングの一部にするというGoogleの決定は、多くの企業、とくに[SEO](./seo#コアウェブバイタル)業界でパフォーマンスを優先事項のトップに押し上げました。個々のサイトオーナーは確かにパフォーマンスを向上させるために一生懸命に取り組んでおり、このスケールではそれぞれの努力が目立ちにくいかもしれませんが、昨年のCWVの改善に大きな役割を果たしています。

それでもなお、やるべき仕事はあります。私たちの研究は、LCPリソースの優先順位付けと静的な発見可能性を改善する機会を示しています。多くのサイトは依然として人工的なインタラクティビティの遅延を避けるためにダブルタップズームを無効にすることに失敗しています。INPに関する新しい研究は、FIDでは見過ごされやすかった反応性の問題を明らかにしました。INPがCWVになるかどうかにかかわらず、私たちは常に迅速で反応の良い体験を提供しようと努力すべきであり、データは私たちがもっとうまくできることを示しています。

結局のところ、常にやるべき仕事があるということです。そのため、もっとも影響力のあることは、ウェブパフォーマンスをよりアプローチしやすくすることを続けることです。これからの年月で、サイトオーナーへの「最後の一マイル」までウェブパフォーマンスの知識を伝えることを強調しましょう。
