---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: アクセシビリティ
description: 2025年版Web AlmanacのアクセシビリティチャプターはWeb Almanacのアクセシビリティの章で、読みやすさ、ナビゲーション、フォーム、メディア、ARIA、アクセシビリティアプリを網羅しています。
hero_alt: 青い人型アクセシビリティアイコンを前面に持つロボットがウェブページをスキャンし、Web Almanacのキャラクターがラベルを確認しているヒーロー画像。
authors: [tricinel, mgifford]
reviewers: [hidde, atierney, scottdavis99]
analysts: [mgifford, tunetheweb]
editors: [tricinel]
translators: [ksakae1216]
tricinel_bio: Bogdanは、進行中の作業を妨げることなくアクセシブルなウェブサイトを構築する支援をするアクセシビリティコンサルタントです。教育・ヘルスケア分野での10年以上の経験を持ち、インクルーシブデザインとウェブアクセシビリティの深い専門知識を有しています。2024年3月から「誰もが入れる場所を作る」という信念のもと、アクセシビリティに関する<a hreflang="en" href="https://dailyaccessibility.com">日刊ニュースレター</a>を執筆しています。
mgifford_bio: Mike GiffordはCivicActionsのオープンスタンダード＆プラクティスリードです。オープンガバメント、デジタルアクセシビリティ、サステナビリティに関するソートリーダーでもあります。DrupalコアアクセシビリティメンテナーおよびW3C招聘エキスパートを務めており、オーサリングツールアクセシビリティの専門家として認められ、W3Cのドラフト版ウェブサステナビリティガイドライン（WSG）1.0にも貢献しています。
results: https://docs.google.com/spreadsheets/d/13sY_wmYODArxo-hH5cSuRAbvtLdGI3x5Xc9qUyqP8as/
featured_quote: ウェブはすべての人のために機能すべきです。この原則が私たちの意思決定を導かない限り、アクセシビリティのギャップは解消されません。
featured_stat_1: 85
featured_stat_label_1: Lighthouseアクセシビリティスコアの中央値。
featured_stat_2: 67%
featured_stat_label_2: デフォルトのフォーカスアウトラインを削除しているサイト。
featured_stat_3: 2%
featured_stat_label_3: アクセシビリティオーバーレイを使用しているサイト。
doi: 10.5281/zenodo.18246524
---

## はじめに

ウェブは急速に変化しています。2025年、主流のテクノロジーがインクルーシブな機能にますます依存するようになる中、ウェブアクセシビリティはかつてないほど重要です。例えば、音声アシスタントはスクリーンリーダー技術を使用しています。動画キャプションや触覚フィードバックなど、もともとアクセシビリティのために設計された機能は今では一般的になっています。

ユニバーサルデザインの原則は現代のウェブ開発において根本的に重要です。私たちは多様なニーズに対応し、すべてのユーザーの体験を改善するソリューションをますます作り出しています。Tim Berners-Lee卿が有名な言葉を残しているように、「ウェブの力はその普遍性にある。障害の有無にかかわらず誰もがアクセスできることは必須の側面だ。」

最近の世界的な出来事と変化する法的要件が、デジタルインクルージョンを注目の的にしています。<a hreflang="en" href="https://inclusive.microsoft.design/">MicrosoftのInclusive Design Guidelines</a>は、アクセシビリティが永続的な障害を持つ人々だけでなく、より多くの人々を助けることを示しています。このガイドラインは一時的・状況的な制限についても具体的に言及しています。例えば、片手でデバイスを使う能力は、怪我をした人、幼い子どもを持つ親、荷物を持っている人にも役立ちます。

2025年、ウェブアクセシビリティ法には実質的な効力があります。欧州連合（EU）の[欧州アクセシビリティ法（EAA）](https://en.wikipedia.org/wiki/European_Accessibility_Act)は大きな前進です。<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">ウェブコンテンツアクセシビリティガイドライン（WCAG）</a>を参照する[EN 301 549](https://en.wikipedia.org/wiki/EN_301_549)標準への準拠について、多数のウェブサイトとアプリに対して2025年6月を期限として設定しました。

米国も規制を更新しました。州・地方政府のサイトは、<a hreflang="en" href="https://www.ada.gov/resources/2024-03-08-web-rule/">米国障害者法タイトルIIで義務付けられた</a>通り、<a hreflang="en" href="https://www.w3.org/TR/WCAG21/">WCAG 2.1</a>を満たす必要があります。2024年のデータは、これらの期限がウェブサイトのアクセシビリティに与える具体的な影響を測定するための重要なベースラインを提供しています。

分析には<a hreflang="en" href="https://www.deque.com/axe/axe-core/">DequeのaxeコアエンジンによるGoogle Lighthouse</a>を使用しています。2025年の結果を2024年のデータと比較し、主要なトレンドを特定します。WCAG 2.2のより広い採用に伴い、新しい達成基準の普及と `duplicate-id` などの廃止ルールからの継続的な変化を検討します。

私たちのアプローチは<a hreflang="en" href="https://webaim.org/projects/million/">WebAim Million</a>と似ていますが、クロールするサイトと使用する分析ツールが異なります。HTTP Archiveは毎月Lighthouseやその他のツールを使用して、ホームページとセカンダリページにわたって1,700万サイトをクロールしています。WebAimは<a hreflang="en" href="https://wave.webaim.org/">WAVE</a>で<a hreflang="en" href="https://webaim.org/projects/million/#method">上位100万ホームページ</a>を調査しています。

LighthouseにもaXeコアを使った自動テストは、<a hreflang="en" href="https://html5accessibility.com/stuff/2025/03/24/a-tools-errand/#:~:text=automation%20blues">WCAG達成基準のサブセットを部分的にしか確認できません</a>。GOV.UKのAlphagovは<a hreflang="en" href="https://alphagov.github.io/accessibility-tool-audit/">一般的な自動監査ツールの比較</a>を提供していますが、すべてのツールがアクセシビリティエラーの50%未満しか検出していません。多くの基準には自動テストがなく、すべてのアクセシビリティ問題がWCAGの基準に対応しているわけでもありません。

グッドハートの法則を覚えておいてください。指標がターゲットになると、信頼できる指標ではなくなります。完璧なスコアは完全なアクセシビリティを保証しません。Lighthouseのアクセシビリティスコアは最終目標ではなく、評価の出発点として扱うべきです。それでも、これらのスコアを追跡することはウェブの全体的な進歩の貴重なスナップショットを提供します。

私たちのレポートはHTMLのみに焦点を当てており、PDFやその他のオフィスドキュメントは含みません。

2024年と比較して、Lighthouseアクセシビリティスコアの中央値は1%改善し、2025年には85%を超えました。2019年の最初のWeb Almanac以来、着実で段階的な進歩が見られています。<a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/accessibility/scoring">Google Lighthouseはaxeコアの問題に異なる重みを割り当てています</a>ので、<a hreflang="en" href="https://accessibility.civicactions.com/posts/prioritizing-accessibility-bugs-for-maximum-impact">組織によって修正の優先順位が異なる場合があります</a>。

{{ figure_markup(
  image="lighthouse-audit-improvements-yoy.png",
  caption="Lighthouseの監査改善状況（前年比）。",
  description="6年間のGoogle Lighthouseアクセシビリティスコアの中央値の平均上昇を示す棒グラフ。値は年々ゆっくりと増加しており、2019年は83%、2020年は80%、2021年は82%、2022年は83%、2024年は84%、2025年は85%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1116937150&format=interactive",
  sheets_gid="1543303999",
  sql_file="lighthouse_a11y_score.sql"
  )
}}

今年、以下のaxeコアテストで最大の進歩が見られました：

- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-input-field-name">ARIAの入力フィールドにはアクセシブルな名前が必要</a>：2024年比 +3%
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-meter-name">ARIAの `meter` ノードにはアクセシブルな名前が必要</a>：2024年比 +15%
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-progressbar-name">ARIAの `progressbar` ノードにはアクセシブルな名前が必要</a>：2024年比 +5%
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-tooltip-name">ARIAの `tooltip` ノードにはアクセシブルな名前が必要</a>：2024年比 +13%
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/meta-refresh">20時間未満の遅延リフレッシュを避ける</a>：2024年比 +1%
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/object-alt">`<object>` 要素には代替テキストが必要</a>：2024年比 +1%
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/select-name">`<select>` 要素にはアクセシブルな名前が必要</a>：2024年比 +5%

{{ figure_markup(
  image="most-improved-lighthouse-accessibility-tests-axe.png",
  caption="最も改善されたLighthouseアクセシビリティテスト（axe）。",
  description="4年間で7つの特定のLighthouseチェックの改善を示す系列チャート。`aria-input-field-name` については、2021年12%、2022年14%、2024年21%、2025年24%。`aria-meter-name` については、2021年0%、2022年100%、2024年35%、2025年50%。`aria-progressbar-name` については、2021年1%、2022年3%、2024年14%、2025年19%。`aria-tooltip-name` については、2021年29%、2022年75%、2024年74%、2025年87%。`meta-refresh` については、2021年と2022年は2%、2024年7%、2025年8%。`object-alt` については、2021年1%、2022年20%、2024年10%、2025年11%。`select-name` については、2024年37%、2025年42%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=2072636024&format=interactive",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
  )
}}

今年、Web Almanacに[人工知能（AI）](#人工知能aiの影響)に関する新しいセクションを追加しました。AIはウェブサイトの構築・コードの記述・コンテンツの生成・パフォーマンスの最適化・インターフェースとのインタラクション方法を変えています。画像の説明やキャプションの生成から、チームが問題を見つけ修正するのを助けるアシスタントまで、アクセシビリティ作業においても役割が増しています。

同時に、AIはリスクと未解決の問題をもたらします。ウェブサイトがAIによって作成されたり、AIの支援を受けたりした場合を確認する信頼できる方法はまだありません。言語モデルはアクセシビリティ問題を含むコードやコンテンツで訓練されています。自動化された説明やパターンはコンテキスト・ユーザーの意図・ニュアンスを見逃しやすいです。データ使用・環境への影響・内在するバイアスに関する広範な懸念は、ウェブ上のAIから誰が恩恵を受け、誰が傷つけられ排除されるかに直接影響します。

新しいAIチャプターはこれらの緊張を探求しています：AIがすでにチームをどのように助けているか、どこで不足しているか、どのような標準・保護措置・実践が必要か。分析全体を通じて一つの原則が貫かれています：AIは人間の専門知識とインクルーシブデザインを置き換えるのではなく、支援すべきです。

このチャプター全体を通じて、自分のサイトのアクセシビリティを改善するための実践的なリンクと具体的なソリューションを見つけることができます。

## 読みやすさ

ユーザーはウェブコンテンツを簡単に読んで理解できる必要があります。これは読みやすいフォントの選択にとどまりません。明確な言語の使用・ページの論理的な整理・予測可能なデザインパターンへの準拠も含まれます。

このレポートは測定可能な技術的指標に焦点を当てていますが、平易な言語での執筆などの定性的要素も同様に重要です。WCAG 3.0は明確な言語の要件を組み込む方法を検討していますが、まだ開発段階にあります。

平易な言語と同様に、数値もアクセシビリティ上の課題をもたらします。一部のユーザーは数値の解釈に苦労しており、自動テストでは障壁として確実に検出できません。これに対処するには、ウェブ上で数値情報を明確に提示するための実践的なアドバイスを提供する<a hreflang="en" href="https://accessiblenumbers.com">Accessible Numbers</a>などのリソースを参照してください。

英語のコンテンツには読みやすさの指標があります。[Flesch-Kincaid](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests)の可読性スコアはその一例です。しかしウェブはグローバルです。多くの言語と多様な視聴者にまたがっています。すべてのケースや言語をカバーする標準化された自動テストは存在しません。

### カラーコントラスト

前景色と背景色の差異が、ユーザーがウェブコンテンツを認識できるかどうかを決定します。不十分なカラーコントラストは、特に低視力のユーザーや<a hreflang="en" href="https://www.colourblindawareness.org/">色覚異常</a>を持つユーザーにとって、依然として一般的な障壁です。

カラーコントラストは、高齢ユーザー・老眼鏡を忘れた人などの一時的な障害を持つ人・明るい日光や困難な環境でコンテンツを読む人にとっても特に重要です。

WCAGはAA適合性を達成するために、通常テキストに対して少なくとも4.5:1、大きなテキストに対して3:1のコントラスト比を要求しています。AAA適合性は通常テキストに対して7:1を要求します。[WCAGのコントラスト比](https://developer.mozilla.org/docs/Web/Accessibility/Guides/Understanding_WCAG/Perceivable/Color_contrast)は重要なベースラインですが、これらのガイドラインはすべての形態の色覚異常や個人の知覚の違いに対応しているわけではありません。

<a hreflang="en" href="https://git.myndex.com/">Accessible Perceptual Contrast Algorithm（APCA）</a>を含む他のドキュメントは、より知覚的に正確なコントラストの測定を提供することを目的としています。

<a hreflang="en" href="https://accessibility.civicactions.com/guide/tools#color">オープンソースツール</a>（<a hreflang="en" href="https://contrast.report/">新しくリリースされたContrast Report</a>など）は、カラーコントラストの問題を見つけて修正することをこれまで以上に簡単にしています。必要な比率を満たさない色に対して修正案も提示します。追加のガイダンスとして、<a hreflang="en" href="https://www.dennisdeacon.com/web/accessibility/testing-methods-use-of-color/">Dennis Deaconのカラーコントラストテストに関する記事</a>などの専門家リソースを参照できます。

{{ figure_markup(
  image="sites-with-sufficient-color-contrast.png",
  caption="十分なカラーコントラストを持つサイト。",
  description="6年間にわたるデスクトップとモバイルの十分なカラーコントラストを持つウェブサイトの割合を示す系列棒グラフ。2019年は22%が十分なカラーコントラストを持っていた。2020年は21%に低下し、2021年に22%に回復。2022年はデスクトップとモバイルともに23%で、2024年にデスクトップが28%、モバイルが29%に急上昇。2025年はデスクトップとモバイルともに30%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1491798527&format=interactive",
  sheets_gid="15996962",
  sql_file="color_contrast.sql"
  )
}}

今年、テキストコントラストの合格率は2024年比でおよそ1%改善しました。しかし、現時点でモバイルサイトの31%のみが最低限のカラーコントラスト要件を満たしています。モバイル体験は明瞭な視認性に大きく依存しているため、このギャップはスマートフォンでウェブにアクセスするユーザーにとって深刻な問題です。

ブラウザとオペレーティングシステムはライト・ダーク・ハイコントラストモードのサポートを強化しています。ユーザーはより多くのコントロールを持つようになっています。しかし、ほとんどのサイトはまだこれらの設定に対応していません。

### ズームとスケーリング

ユーザーはニーズに合わせてコンテンツをリサイズできる必要があります。ズームを無効にするとユーザーコントロールが失われ、WCAGのリサイズ要件に直接違反します。これは単なる小さな不便にとどまりません。低視力のユーザーや読書に画面拡大機能を使用している人にとって、サイトが完全に使用不能になる可能性があります。

2025年でも、この制限的なパターンはまだ見られます。多くの場合、開発者がモバイルデバイスでピクセルパーフェクトなレイアウトを望むためです。残念ながら、それはユーザビリティとアクセシビリティを犠牲にしています。

{{ figure_markup(
  image="pages-with-zooming-and-scaling-disabled.png",
  caption="ズームとスケーリングが無効になっているページ。",
  description="デスクトップとモバイルのズーム無効化データを示す棒グラフ。デスクトップサイトの15%・モバイルサイトの13%がスケーリングを無効化。デスクトップの19%・モバイルの17%が最大スケールを1に設定。デスクトップの21%・モバイルの19%がいずれかを使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=327558014&format=interactive",
  sheets_gid="684000055",
  sql_file="viewport_zoom_scale.sql"
  )
}}

ズームやスケーリングを無効にするサイトの数は減少し続けています。2025年には、`user-scalable=no` の使用または制限的な最大スケールの設定によってスケーリングを制限しているサイトは、モバイルで19%・デスクトップで21%のみです。これは2024年比で1〜2%の改善であり、ゆっくりではありますが着実な進歩を示しています。

{{ figure_markup(
  image="font-unit-usage.png",
  caption="フォントサイズ単位の使用状況。",
  description="フォントサイズの単位を示す棒グラフ。`px` はデスクトップの67%で使用され、`em` は16%、`rem` は9%、パーセンテージは4%、`<number>` は2%、`pt` は1%のウェブサイトで使用されている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=611369037&format=interactive",
  sheets_gid="1493373752",
  sql_file="units_properties.sql"
  )
}}

フォントサイズの単位は、テキストがユーザー設定にどのように反応できるかに直接影響します。`em` や `rem` などの相対単位を使うと、ブラウザの設定に合わせてテキストが予測可能にスケーリングされます。2025年には、モバイルサイトでの `em` の使用が2%増加し、読みやすさのためにフォントサイズを調整するユーザーの体験が改善しました。それ以外のフォントサイズ単位の使用状況は昨年とほぼ同じです。

サイトがズームを制限しているかどうかを確認するには、ソースコードで `<meta name="viewport">` タグを調べてください。リサイズを制限する `maximum-scale`・`minimum-scale`・`user-scalable=no`・`user-scalable=0` などの値の使用を避けてください。代わりに、ユーザーがコンテンツサイズを自由に調整できるようにしましょう。<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-scale.html#:~:text=Content%20satisfies%20the%20Success%20Criterion%20if%20it%20can,more%20extreme%2C%20adaptive%20layouts%20may%20introduce%20usability%20problems.">WCAGはコンテンツや機能の損失なしにテキストが200%までリサイズできることを要求しています</a>。

### 言語の識別

`lang` 属性でページの主要言語を宣言することは必須です。スクリーンリーダーが正しい発音規則を選択でき、ブラウザがより正確な自動翻訳を提供できるようになります。主要言語を超えて、メイン言語と異なるセクションの言語を指定することも同様に重要です。これにより、スクリーンリーダーが外国語の単語やフレーズに対して発音を適切に切り替えられるようになります。

<a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/language-of-page">straightforward Level A WCAG requirement</a>であるにもかかわらず、言語宣言は多くのサイトが不十分な領域のままです。2025年には、約86%のサイトが有効な `lang` 属性を含んでおり、2024年からほぼ変わっていません。これは継続的な採用を示す一方、改善の余地があることも浮き彫りにしています。

`lang` 属性の正しい適用は、ページの主要言語を指定するために `<html>` タグに含めることから始まります。ページには複数の言語が含まれることがよくあります。必要に応じて個々の要素やセクションに `lang` 属性を使用してください。<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/language-of-parts.html">W3Cの言語の部分指定に関するドキュメント</a>にこのトピックの詳細なガイダンスがあります。

言語宣言の欠如や誤りは翻訳エラーを引き起こす可能性があります。

例えば、Chromeの自動翻訳は宣言された言語がない場合にページコンテンツを誤解釈し、混乱した不正確な翻訳につながる可能性があります。適切な言語タグ付けは、右から左に書く言語のスタイリングや他の言語固有の動作もサポートします。

## ユーザー設定

モダンCSSには、ウェブサイトがユーザーのオペレーティングシステムまたはブラウザ設定に適応できる[ユーザー設定メディアクエリ](https://developer.mozilla.org/docs/Web/CSS/Reference/At-rules/@media/prefers-color-scheme)が含まれています。ユーザーはより快適でパーソナライズされた体験を得られます。ウェブサイトはモーション・コントラスト・カラースキームの設定に対応できます。

{{ figure_markup(
  image="user-preference-media-query.png",
  caption="ユーザー設定メディアクエリ。",
  description="デスクトップとモバイルでさまざまなユーザー設定メディア機能を使用するページの割合を比較した棒グラフ。最も広く使われている機能は `prefers-reduced-motion` で、デスクトップ（49.99%）とモバイル（50.55%）のページの約半数に出現。`-ms-high-contrast` と `forced-colors` もデスクトップでそれぞれ約21%と16%、モバイルで20%と19%と顕著な使用率を示す。`prefers-color-scheme`（両プラットフォームで約13%）や `prefers-contrast`（約1%）などの他の機能はあまり使われておらず、レガシーまたは実験的な機能はほぼ出現しない。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1063383428&format=interactive",
  sheets_gid="1601070335",
  sql_file="media_query_features.sql",
  width=600,
  height=551
  )
}}

最も馴染み深いクエリである `prefers-reduced-motion` と `prefers-color-scheme` はブラウザで広くサポートされ続けています。2025年には、これらのクエリのウェブサイトによる採用はほとんど変化がありません。しかし、低視力ユーザーのハイコントラストモードをサポートする `forced-colors` の使用は5%増加して19%になりました。一方、時代遅れの `-ms-high-contrast` メディアクエリの使用は3%減少して20%になりました。これはモダンCSSスタンダードへの段階的な移行を反映しています。

これらの設定を継続的に取り入れることで、個人のニーズとシステム設定を尊重し、アクセシビリティとユーザー満足度が向上します。

CSSメディアクエリによるパーソナライズのより広い実装は、これらの段階的な改善にもかかわらず大きな成長は見られていません。さらなる採用を促進することで、前庭障害の敏感さに対するモーション低減や視覚的な快適さのためのディスプレイカラーやコントラストの調整など、ウェブサイトがユーザーの設定を尊重できるようになります。

## ナビゲーション

ユーザーはさまざまな方法でウェブサイトをナビゲートします。マウスでスクロールする人もいれば、キーボード・スイッチコントロールデバイス・スクリーンリーダーで見出しをナビゲートする人もいます。効果的なナビゲーションシステムは、入力デバイスに関わらずすべてのユーザーに機能しなければなりません。

ワイドスクリーンテレビやSiri・Amazon Alexaのような音声インターフェースは独自のナビゲーション課題を生み出します。サイトに適切なセマンティック構造を構築することで、スクリーンリーダーユーザーのナビゲーションが向上します。また、他の多くの種類のテクノロジーのユーザーにも役立ちます。

### フォーカス表示

フォーカス表示は、ウェブコンテンツを移動するためにキーボードナビゲーションと支援デバイスに主に依存するユーザーにとって必須です。現在フォーカスされている要素を強調表示する視覚的な手がかりを提供し、ユーザーがページ上のどこにいるかを理解できるようにします。

Google Lighthouseなどの自動テストツールは多くの基本要件を特定し、フォーカスインジケーターに関する明らかな問題を検出できます。しかし、キーボードトラップ・フォーカス順序・フォーカスが新しいコンテンツに論理的に移動するかどうかなどの複雑なインタラクションには限界があります。自動監査に合格することは、サイトのキーボードアクセシビリティやキーボードユーザーの良好なユーザー体験を保証しません。

包括的な手動テストは欠かせません。

オープンソースの<a hreflang="en" href="https://accessibilityinsights.io/docs/web/overview/">Accessibility Insights for the Web</a>拡張機能などのツールは、DequeのaxeコアとガイドとなるASTを組み合わせて、ガイド付きの手動テストを提供しています。「Tab Stops」の可視化機能は、テスターがキーボードユーザーが辿るパスを確認し、フォーカススタイルの欠如や予期しないフォーカストラップなどの潜在的な問題を効果的に特定するのに役立ちます。

運動能力に制限のある代替ナビゲーションデバイスのユーザーは、フォーカスの視認性と順序に関して固有のニーズを持っています。支援技術のインターフェースをカスタマイズすることで、能力に合わせたコントロールを最大化できます。

フォーカステストのベストプラクティスには以下が含まれます：

- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focus-traps">キーボードユーザーが行き詰まるフォーカストラップがないこと</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focusable-controls">すべてのインタラクティブコントロールがキーボードでフォーカス可能であること</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/logical-tab-order">タブ順序が論理的で直感的であること</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/managed-focus">フォーカスが新しくまたは動的にロードされたコンテンツに適切に向けられること</a>

<a hreflang="en" href="https://www.a11y-collective.com/blog/focus-indicator/">A11y Collectiveのフォーカスインジケーターに関するレポート</a>は、可視フォーカスアウトラインスタイルの実装とテストのための実践的な洞察を提供しています。

#### フォーカススタイル

WCAGはすべてのインタラクティブコンテンツに<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-visible.html">明確に見えるフォーカスインジケーター</a>が必要であることを定めています。この視覚的な手がかりにより、キーボードユーザーはページを移動しながら現在フォーカスされている要素を識別できます。

目立つフォーカスインジケーターがないと、キーボードユーザーや支援技術に依存するユーザーは迷子になりやすくなります。ハイコントラストアウトラインなどの堅牢なフォーカススタイルは、アクセシブルなデザインの基本です。<a hreflang="en" href="https://www.gov.uk/">GOV.UK</a>のような多くの機関では、一貫性と明確性を確保するためにフォーカスインジケーターの標準を確立しています。

デザインアノテーションは<a hreflang="en" href="https://tetralogical.com/blog/2025/09/23/annotating-designs-using-common-language/">Craig AbbottがTetraLogicalブログで明確に示したように</a>、キーボードインタラクションを指定する必要があります。この投稿の直後、GitHubは同じ問題に対処するためにアクセシビリティ<a hreflang="en" href="https://github.com/github/annotation-toolkit">Annotation Toolkit</a>をリリースしました。

{{ figure_markup(
  image="pages-overriding-browser-focus-styles.png",
  caption="ブラウザのフォーカススタイルを上書きしているページ。",
  description="デスクトップとモバイルで3つのフォーカス関連CSSパターンを使用するページの割合を比較した棒グラフ。基本の `:focus` セレクターはデスクトップとモバイルの両方でページの約90%に存在。`:focus { outline: 0; }` でフォーカスアウトラインを削除しているのは両方でページの約3分の2（67%）。よりアクセシブルな `:focus-visible` セレクターの使用はより低く、ページの約4分の1（デスクトップ25%・モバイル24%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1774339890&format=interactive",
  sheets_gid="1499298533",
  sql_file="focus_outline_0.sql"
  )
}}

2025年には、67%のサイトがデフォルトのフォーカスアウトラインを明示的に削除しており、2024年から14%増加しました。この懸念すべきトレンドは、効果的なスタイルに置き換えられない場合、アクセシビリティを損なう可能性があります。一方、`:focus-visible` 疑似クラスの採用は増加しています。これは、開発者が必要な時にのみ表示されるコンテキスト対応のフォーカスインジケーターを作り始めていることを意味します。

#### `tabindex`

`tabindex` 属性は、要素のキーボードフォーカス順序への参加を制御します。開発者はフォーカス可能な要素を含める・除外する・並び替えることができます。正しく使用することは論理的なナビゲーションとアクセシビリティをサポートし、<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-order.html">WCAGの要件</a>でもあります。特に正の値での誤用は、自然なタブ順序を乱し、ユーザーを混乱させる可能性があります。

{{ figure_markup(
  image="tabindex-usage.png",
  caption="`tabindex` の使用状況。",
  description="デスクトップとモバイルで異なる `tabindex` 値を使用するページの割合を示す棒グラフ。ページの過半数が `0` を使用（デスクトップ52.1%、モバイル50.1%）。`-1` などの負の `tabindex` 値も同様の割合（デスクトップ52.0%、モバイル50.3%）。一方、正の `tabindex` 値はごく少数のページにのみ出現（デスクトップ3.7%、モバイル3.4%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=140565248&format=interactive",
  sheets_gid="1566430802",
  sql_file="tabindex_usage_and_values.sql"
  )
}}

2025年には `tabindex` の使用がわずかに増加しました。50%超のサイトが使用しており、2024年より約3〜4%高くなっています。正の `tabindex` の使用は安定して低い水準を保っており、正の tabindex 値を避けるべきという認識が続いていることを反映しています。

### ランドマーク

ランドマークは `<header>`・`<nav>`・`<main>`・`<footer>` などのネイティブHTML要素を使用して、ウェブページを明確なテーマ別領域に構造化します。これらの要素は明確で高レベルなページのアウトラインを作成し、支援技術のユーザーがレイアウトをすばやく理解して関連セクションに直接ジャンプできるようにします。

開発者が冗長なARIA属性を追加する場合、一般的なアクセシビリティのアンチパターンが見られます。例えば、`<nav>` 要素に `role="navigation"` を追加するケースです。`<nav>` 要素は本質的にナビゲーションロールを持っているため、この重複はコードを煩雑にするだけで利益なく、支援技術を混乱させる可能性があります。<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/html/H101">ARIAランドマークロールを追加する前に、まずネイティブHTML5要素を優先するのがベストプラクティスです</a>。これはARIAの主要なガイドラインです。

Eric Baileyのようなアクセシビリティの専門家は、ネイティブのセマンティックHTMLで十分なコンテキストで<a hreflang="en" href="https://www.smashingmagazine.com/2025/06/what-i-wish-someone-told-me-aria/">ARIAを過度に使用することの落とし穴</a>を強調しています。Heydon Pickeringの<a hreflang="en" href="https://heydonworks.com/article/pride-shame-and-accessibility/">ウェブアクセシビリティの12原則</a>も、セマンティック構造とランドマークがアクセシブルなナビゲーションで果たす重要な役割を強調しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素</th>
        <th>要素 %</th>
        <th>ロール %</th>
        <th>両方 %</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>main</td>
        <td class="numeric">40.72%</td>
        <td class="numeric">17.81%</td>
        <td class="numeric">47.34%</td>
      </tr>
      <tr>
        <td>header</td>
        <td class="numeric">65.99%</td>
        <td class="numeric">10.95%</td>
        <td class="numeric">67.41%</td>
      </tr>
      <tr>
        <td>nav</td>
        <td class="numeric">67.73%</td>
        <td class="numeric">18.02%</td>
        <td class="numeric">70.94%</td>
      </tr>
      <tr>
        <td>footer</td>
        <td class="numeric">66.38%</td>
        <td class="numeric">9.59%</td>
        <td class="numeric">67.66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ランドマーク要素とロールの使用状況（デスクトップ）。",
      sheets_gid="445686890",
      sql_file="landmark_elements_and_roles.sql"
      )
    }}
  </figcaption>
</figure>

{{ figure_markup(
  image="yearly-growth-in-pages-with-element-role.png",
  caption="要素ロールを持つページの年次成長。",
  description="5年間にわたるランドマーク `role` 属性（`footer`・`header`・`main`・`nav`）を使用するページの割合を示すチャート。すべてのロールで使用が着実に成長：`nav` は2021年の66%から2025年の71%に首位を維持。次いで `footer`（65%→68%）、`header`（64%→67%）、`main`（35%→47%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=553285039&format=interactive",
  sheets_gid="445686890",
  sql_file="landmark_elements_and_roles.sql"
  )
}}

2025年には、ネイティブの `<main>` 要素の使用拡大（現在47%、2024年比3%増）を筆頭に、ARIAランドマークの採用がわずかに増加しました。この進歩は、セマンティックHTMLへの準拠の改善と、支援ツールに依存するユーザーのためのより堅牢なページ構造を反映しています。

スクリーンリーダーユーザーは、これらのページ領域間をジャンプするために「ローター」やランドマークメニューを使ってナビゲートすることが多いです。ランドマークを指すスキップリンクは、コアコンテンツへの即時アクセスを可能にすることでユーザビリティを向上させます。繰り返されるナビゲーションブロックやバナーを回避できます。スキップリンクについては後のセクションで説明します。

ネイティブHTML5ランドマークの活用と冗長なARIAロールの最小化に関する継続的な教育により、キーボードと支援技術のナビゲーション体験がさらに向上します。セマンティック構造の採用の増加はアクセシビリティの目標をサポートし、ウェブコンテンツを現代のベストプラクティスに合わせます。

### 見出し階層

一貫した見出し構造はウェブページの目次のように機能します。アクセシビリティ・SEO・ユーザーの理解をサポートします。スクリーンリーダーユーザーにとって、見出しによるナビゲーションは情報をすばやく見つけるための重要な方法です。検索エンジンもページの構成と関連性を理解するために見出し階層に依存しています。

見出しは視覚的なスタイリングだけでなく、ドキュメント構造を伝えるべきです。`<h3>` や `<h4>` などの見出しタグをフォントサイズのためだけに使用すると、論理的な順序が崩れます。支援技術のユーザーのナビゲーションが困難になり、構造とプレゼンテーションの分離原則に違反します。代わりに、開発者はCSSで見出しをスタイリングし、コンテンツ階層に従って見出しタグを使用すべきです。

セマンティクスが重要な理由の復習として、<a hreflang="en" href="https://www.jonoalderson.com/conjecture/why-semantic-html-still-matters/">Jono Aldersonのこの記事</a>を参照してください。

複数年にわたる低下の後、見出し階層のスコアは2025年に約2%改善し、適切な見出し構造への関心の再燃を示しています。

{{ figure_markup(
  caption="適切に順序付けされた見出しのLighthouse監査に合格しているモバイルサイト。",
  content="59%",
  classes="big-number",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

それでも、構造ではなくスタイリングのために見出しを誤用することは一般的なままです。

### スキップリンク

スキップリンクは、キーボードユーザーやマウス以外の入力デバイスを使用するユーザーが、サイトのナビゲーションメニューなどの大きくて繰り返しのあるコンテンツブロックをスキップして、メインページコンテンツに直接ジャンプできるようにするナビゲーション補助機能です。通常、効率的なナビゲーションのために「メインコンテンツにスキップ」リンクがページの最初のフォーカス可能な要素として存在します。

コンテンツのブロックをバイパスすることは<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/bypass-blocks.html">WCAGの要件</a>であり、基本的な実装が標準のままです。

<a hreflang="en" href="https://paypal.github.io/skipto/">PayPalのオープンソースSkipTo</a>のような高度なツールは、ページ上のすべての主要なランドマークと見出しの動的メニューを生成するために存在しています。このより豊かなインタラクションは幅広いユーザーに利益をもたらし、全体的なナビゲビリティとユーザビリティを向上させます。Eleanor Hecksは<a hreflang="en" href="https://www.smashingmagazine.com/2025/04/what-mean-site-be-keyboard-navigable/">キーボードアクセシビリティの重要性</a>について説得力のある記事を書き、<a hreflang="en" href="https://tetralogical.com/blog/2025/05/09/foundations-keyboard-accessibility/">TetraLogical</a>も同様の記事を書きました。

スキップリンクの採用は2024年から2025年にかけてほぼ静的なままです。

{{ figure_markup(
  caption="スキップリンクを持つと思われるモバイルおよびデスクトップページ。",
  content="24%",
  classes="big-number",
  sheets_gid="1734473098",
  sql_file="skip_links.sql"
)
}}

デスクトップとモバイルページの約24%が、一般的な分析方法で検出可能なスキップリンクを含んでいます。この数値は実際の使用状況を過小評価している可能性があり、一部のスキップリンクはページのより深い部分に出現したり、ナビゲーションメニュー以外のランドマークをターゲットにしている場合があるためです。

{{ figure_markup(
  image="yearly-growth-in-pages-with-skip-links.png",
  caption="スキップリンクを持つページの年次成長。",
  description="4年間にわたるデスクトップとモバイルのスキップリンクを持つページの割合を示す複数系列の棒グラフ。使用は2021年の19.7%から2025年のデスクトップ25.65%・モバイル26.23%に着実に成長し、近年はモバイルがデスクトップよりも一貫してわずかに高い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=688571011&format=interactive",
  sheets_gid="1734473098",
  sql_file="skip_links.sql"
  )
}}

### ドキュメントタイトル

説明的なページ `<title>` は基本的な必要条件です。ブラウザのタブやウィンドウ間をナビゲートするユーザーにコンテキストを提供し、スクリーンリーダーが最初にアナウンスする情報であることが多く、ユーザーが状況を把握するのを助けます。WCAGも<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/page-titled">すべてのページに意味のあるタイトルが必要</a>であることを定めています。

{{ figure_markup(
  image="title-element-statistics.png",
  caption="titleタグ要素の統計。",
  description="デスクトップとモバイルのtitle要素の使用パターンを比較した棒グラフ。ほぼすべてのページ（98%）が両プラットフォームでtitle要素を持ち、4語以上のタイトルはデスクトップページの69%・モバイルページの67%に出現。レンダリング後に変化するタイトルはデスクトップとモバイルの両方でページの7%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1678943411&format=interactive",
  sheets_gid="480324977",
  sql_file="page_title"
  )
}}

2025年のデータは、前年と比較してドキュメントタイトルの存在と説明性がわずかに改善されたことを示しています。現在、約98%のサイトが `<title>` 要素を含んでおり、2024年から1%増加しています。

これは肯定的です。しかし、この高い包含率にもかかわらず、多くのタイトルの説明性は不十分なままです。これはユーザビリティに影響し、特に方向確認のために明確なタイトルに依存するスクリーンリーダーユーザーに影響します。

4語以上のタイトルを持つモバイルサイトが2%減少しており、モバイルページでより短いまたは具体性の低いタイトルが増えていることを示している可能性があります。ナビゲーションとコンテキストを強化するために、ページコンテンツの簡単な説明とウェブサイト名の両方を含めることが引き続きベストプラクティスです。

ドキュメントタイトルはすべてのユーザーに利益をもたらす基本的なアクセシビリティ機能のままです。ブラウザのタブやウィンドウをナビゲートする際のコンテキストを提供します。ほぼすべてのページに存在していますが、タイトルの説明性と一貫性の改善は2025年以降も重要な焦点であり続けます。

### テーブル

HTMLテーブルは2次元のグリッドでデータを表示します。アクセシビリティは適切なセマンティック要素での構造化に依存します。`<caption>` を使用するとスクリーンリーダーユーザーに重要なコンテキストが提供され、`<th>` 要素は行と列のヘッダーを定義してユーザーがデータ内の関係を理解するのを助けます。2025年にリリースされた<a hreflang="en" href="https://codepen.io/stevef/pen/ByoMebv">Steve Faulknerのツール</a>は、開発者がHTML要素のセマンティクスを迅速に検査するのに役立ちます。

`<caption>` の使用は2024年と比較して2025年も安定しており、キャプションを含むサイトの割合はわずかです。この低い採用率は過去年と同様です：デスクトップサイトの約1.6%がキャプションを含んでおり、これは重要ではあるものの見落とされがちなアクセシビリティ機能です。

テーブルをレイアウト目的で誤用するべきではありません。CSS FlexboxとGridがレイアウトを担います。テーブルが純粋にレイアウト用途で使用される場合、`role="presentation"` 属性でセマンティックな意味を除去し、支援技術との混乱を避けます。

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>desktop</th>
        <th>mobile</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>キャプション付きテーブル</td>
        <td class="numeric">5.6%</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>プレゼンテーション用テーブル</td>
        <td class="numeric">4.9%</td>
        <td class="numeric">5.4%</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">4.8%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="テーブルの使用状況。",
      sheets_gid="1701660946",
      sql_file="table_stats.sql"
      )
    }}
  </figcaption>
</figure>

2025年には、モバイルテーブルの4.9%がこの技術を使用しており、2024年の4%、2022年の1%から増加しています。テーブルをアクセシブルにするためにセマンティックHTML要素を正しく使用することへの重点は変わっていません。

## フォーム

フォームはログインから購入、情報共有まで、ユーザーがウェブと対話する方法です。フォームのアクセシビリティを確保することは、ユーザーがタスクを完了しオンラインで十分に参加するために重要です。

### `<label>` 要素

`<label>` 要素は入力フィールドにアクセシブルな名前を提供するための標準的な推奨方法であり続けています。通常は入力の `id` を指す `for` 属性を通じて説明的なテキストをフォームコントロールにプログラム的に関連付けることで、支援技術のユーザーが必要な情報を明確に理解できるようにします。適切なラベルは、ラベルをクリックすると入力にフォーカスが設定されるため、クリック可能な領域を拡大することでユーザビリティも向上させます。

{{ figure_markup(
  image="where-inputs-get-their-accessible-names-from.png",
  caption="入力のアクセシブルな名前の取得元。",
  description="デスクトップとモバイルの入力のアクセシブルな名前のソースを示す棒グラフ。最も一般的なソースは関連する `<label>` 要素で、入力の約3分の1に使用（デスクトップ34.27%・モバイル34.57%）。次いで `placeholder` テキスト（デスクトップ24.49%・モバイル25.12%）と、アクセシブルな名前がまったくない入力（デスクトップ24.65%・モバイル24.93%）が続く。`aria-label`・`title`・`value` 属性や `aria-labelledby` の関連付けなどの他のソースは、入力のごく一部のみを占める。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1732059331&format=interactive",
  sheets_gid="1144087268",
  sql_file="form_input_name_sources.sql"
  )
}}

2025年には、モバイル入力の約35%が `<label>` からアクセシブルな名前を取得しており、2024年の32%から増加しています。これは肯定的なトレンドです。

プレースホルダーテキストのみからアクセシブルな名前を取得する入力が2%減少しました。プレースホルダーテキストの信頼性は低く、ラベルの代替にはなりません。しかし、アクセシブルな名前がまったくない入力の割合は昨年から変わっておらず、継続的なアクセシビリティのギャップを示しています。

2025年のデータは `label` の使用の段階的な改善を示しています。また、完全なアクセシビリティ準拠とユーザビリティを達成するために、適切なラベリング慣行を引き続き拡大する必要性も強調しています。

### `placeholder` 属性

placeholder属性はフォームフィールド内に期待される入力形式のヒントや例を提供します。しかし、その入力のアクセシブルな名前として `<label>` 要素を置き換えるべきではありません。プレースホルダーテキストはユーザーが入力を開始するとすぐに消え、参照できなくなります。

プレースホルダーテキストはデフォルトのコントラストが低く、WCAGのカラーコントラスト要件に失敗することがよくあります。スクリーンリーダーのプレースホルダーサポートも広く異なります。

推奨されるアプローチは、入力に対して可視で、プログラム的に関連付けられたラベルを使用し、プレースホルダーは補足的なヒントや例としてのみ使用することです。

{{ figure_markup(
  image="use-of-placeholders-on-inputs.png",
  caption="入力でのプレースホルダーの使用。",
  description="デスクトップとモバイルで入力にプレースホルダーを使用するサイトの割合と関連パターンを比較した棒グラフ。デスクトップサイトの約56%・モバイルサイトの55%がプレースホルダーを使用し、デスクトップサイトの58%・モバイルサイトの59%がラベルのない入力を持つ。注目すべき点として、デスクトップサイトの53%・モバイルサイトの55%がプレースホルダーを使用し、かつ入力ラベルがない。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1130613025&format=interactive",
  sheets_gid="1641253918",
  sql_file="placeholder_but_no_label.sql"
  )
}}

2025年には、プレースホルダーテキストのみを入力のアクセシブルな名前として使用するケースが2%減少しました。この肯定的なトレンドにもかかわらず、この慣行は依然として一般的です。デスクトップ入力の53%・モバイル入力の55%がアクセシブルな命名のためにプレースホルダーテキストのみに依存しており、依然として重大なアクセシビリティの障壁をもたらしています。

### 必須情報

フォームフィールドが必須であることを伝えることは、ユーザビリティとアクセシビリティにとって重要です。アスタリスク（\*）などの視覚的なインジケーターは一般的ですが、セマンティック情報が欠けているため単独では不十分です。

HTML5の `required` 属性は、フォームを送信する前にユーザーがフィールドに記入しなければならないことを示すネイティブで機械可読な方法を提供します。この属性はテキスト・メール・パスワード・日付・チェックボックス・ラジオなど多くの入力タイプで機能します。ブラウザはバリデーションを強制し、支援技術はユーザーに必須ステータスを伝えます。

{{ figure_markup(
  image="how-required-inputs-are-specified.png",
  caption="必須入力の指定方法。",
  description="デスクトップとモバイルで必須入力をマークする方法を比較した棒グラフ。`required` 属性が最も一般的で、デスクトップ67%・モバイル66%。次いで `aria-required` がデスクトップ36%・モバイル37%。視覚的なアスタリスクはデスクトップサイトの18%・モバイルサイトの19%に出現。`required` と `aria-required` の両方などの重複は両プラットフォームでサイトの9%に出現。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1477108194&format=interactive",
  sheets_gid="1187751102",
  sql_file="form_required_controls.sql"
  )
}}

2025年には required属性の採用がわずかに増加し、モバイルで1%増の66%になりました。`aria-required` の使用はモバイルで3%減少して37%になりました。これは、ARIAよりもネイティブHTMLバリデーションのより意味論的な使用への段階的なシフトを示しています。ARIAはネイティブセマンティクスを置き換えるためではなく、補完するためのものです。

2025年の進歩は、必須入力のより良いセマンティック表示に向けたゆっくりではありますが着実な動きを反映しており、フォームのアクセシビリティとユーザー体験を改善しています。

### キャプチャ

CAPTCHAは人間と自動ボットを区別し、悪意のある活動を軽減します。頭字語は「Completely Automated Public Turing Test to Tell Computers and Humans Apart（コンピュータと人間を区別するための完全自動化公開チューリングテスト）」を意味します。CAPTCHAは必要なセキュリティ機能を果たしますが、特に視覚・運動・認知の障害を持つ人々にとって重大なアクセシビリティの障壁を頻繁に生み出します。

従来の視覚的なCAPTCHAは、障害を持つユーザーにとって解決が困難または不可能な場合があります。W3Cはより包括的な代替検証方法の検討を推奨しており、例えば：

- 音声による挑戦を提供するオーディオCAPTCHA
- ユーザー入力なしにバックグラウンドで動作する「invisible」CAPTCHA
- 多要素認証方法やよりシンプルな検証フローの組み込み。

2025年には、CAPTCHAの使用は前年と比較してほぼ安定したままです。

{{ figure_markup(
  image="captcha-usage-year-over-year.png",
  caption="CAPTCHAの使用状況（前年比）。",
  description="2021年から2025年にかけてのデスクトップとモバイルでCAPTCHAを使用するサイトの割合を示す複数系列の棒グラフ。使用は2022年にデスクトップ20%・モバイル19%でピークを迎え、2024年に17%と16%にわずかに低下し、2025年には18%と17%で安定。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1433910378&format=interactive",
  sheets_gid="1834983243",
  sql_file="captcha_usage.sql"
  )
}}

特筆すべきは、ルクセンブルク政府が<a hreflang="en" href="https://accessibilite.public.lu/en/news/2025-09-22-captchas.html">CAPTCHAスキャナー</a>ツールをリリースしたことです。これは政府ウェブサイト全体のCAPTCHA実装を評価・監視し、公共部門のアクセシビリティ準拠の改善を目的としています。

視覚的なCAPTCHAをよりアクセシブルなオプションに置き換えるまたは補完する継続的な努力は不可欠です。すべてのユーザーが過度の困難や排除なしに検証ステップを完了できるべきです。

## ウェブ上のメディア

ウェブ上のアクセシブルなメディアには、コンテンツをすべての人が使用できるようにするための代替フォーマットの提供が必要です。視覚障害のあるユーザーは、重要な視覚情報を伝える音声説明から利益を得ます。聴覚障害のあるまたは難聴のユーザーは、音声コンテンツにアクセスするためにキャプションや手話通訳に依存しています。

音声説明とキャプションだけでは十分ではありません。音声のみおよびビデオのみのコンテンツには、完全なテキスト代替を提供するトランスクリプトが必要です。画像などの非テキストコンテンツには適切な代替テキストを提供してください。意味のある情報を追加しない場合は、装飾的なものとしてマークしてください。

アクセシブルなメディアの原則と要件は2024年から2025年にかけて一貫しており、障害のあるユーザーにインクルーシブなマルチメディア体験を提供することの継続的な重要性を強調しています。

### 画像

`alt` 属性は画像のテキスト説明を提供します。スクリーンリーダーユーザーが視覚コンテンツを理解するために必須です。2025年でも、この属性は画像アクセシビリティの基本として残っており、前年からエラー率に大きな変化はありません。

{{ figure_markup(
  caption="`alt` テキストを持つ画像のLighthouse監査に合格している画像の割合。",
  content="69%",
  classes="big-number",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

JPGとPNGファイルはウェブ画像を引き続き支配していますが、WEBPとSVG形式の使用には歓迎すべき成長が見られます。SVGファイルは複雑でインタラクティブな画像に役立つ豊かなセマンティクスを提供します。

{{ figure_markup(
  image="most-common-file-extensions-in-alt-text.png",
  caption="`alt` テキストで最も一般的なファイル拡張子。",
  description="デスクトップとモバイルの画像altテキストで見つかった最も一般的なファイル拡張子を示す棒グラフ。JPEG画像が最も多く、デスクトップで54.0%、モバイルで53.4%を占める`jpg`が筆頭で、次いで`png`が34.5%と34.6%。`jpeg`（デスクトップ4.8%、モバイル10.1%）、`webp`、`svg`、`ico`、`gif`などのその他の形式は小さなシェアを占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1120578928&format=interactive",
  sheets_gid="2115828969",
  sql_file="alt_ending_in_image_extension.sql"
  )
}}

しかし、引き続き継続している問題が1つあります：画像のalt textの約8.5%が`.jpg`や`.png`などの一般的なファイル拡張子で終わっています。これは自動オーサリングツールがファイル名を `alt` テキストとして挿入する場合によく起こります。残念ながら、これは何の価値も追加せず、支援技術に依存するユーザーの助けになりません。

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` 属性の長さ。",
  description="デスクトップとモバイルの画像の`alt`属性長さの分布を示すグループ棒グラフ。両プラットフォームで約13〜14%の画像に`alt`属性がなく、30%は空の`alt`を使用しています。空でないテキストを持つ残りの画像のうち、ほとんどは短く、約20%が10文字以下、17%が20文字以下、18%（デスクトップ）と10%（モバイル）が30文字以下で、100文字以上はわずか約1%、100文字超はほぼ0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=536884664&format=interactive",
  sheets_gid="785975896",
  sql_file="common_alt_text_length"
  )
}}

説明性と簡潔さのバランスが取れる傾向にある20〜30文字のalt textへのポジティブなトレンドがあります。しかし、約50%の画像はまだ空のalt属性か10文字未満のテキストを持っています。空のalt textは純粋に装飾的な画像にのみ適切です。ただし、ほとんどの画像は意味のある説明に値する重要な情報を伝えており、意味のあるalt textから恩恵を受けます。

ベストプラクティスは引き続き、画像コンテキストに合わせた簡潔かつ説明的なalt textの提供、ファイル名の回避、適切な場合のSVGのようなセマンティックファイル形式の使用を強調しています。人工知能（AI）ツールも有望です。<a hreflang="en" href="https://www.drupal.org/project/ai_image_alt_text">DrupalのAI支援alt textサジェスト機能の統合</a>は、著者が編集可能な例を提供することでより良いalt属性を作成するのを助けます。Brian Teemanは<a hreflang="en" href="https://magazine.joomla.org/all-issues/june-2024/ai-generated-alt-text">AI生成のAlt Text</a>について興味深い批評を書いています。

画像は着実な進歩にもかかわらず、大幅なアクセシビリティ改善の機会がある分野であり続けています。

### 音声と動画

HTML `<track>` 要素は、`<video>` や `<audio>` などのメディア要素のキャプション、字幕、音声説明などの時間指定テキストトラックを提供します。2025年においても、この要素はまだ十分に活用されていません。聴覚障害、難聴、または視覚障害のあるユーザーにとっての重要性にもかかわらず、採用率は1%未満と非常に低いままです。

多くの現代的なビデオプラットフォームは現在、ネイティブの `<track>` 要素の代わりに[HTTP Live Streaming (HLS)](https://en.wikipedia.org/wiki/HTTP_Live_Streaming)を一般的に使用しています。これが低い使用統計の一因となっているかもしれません。カスタム実装が必要なHLSは、開発者が自分でキャプションサポートを組み込むことをより意識的に行う必要があることを意味します。つまり、開発者がキャプションを忘れたり、不十分な実装をしたりする余地がより多くあります。

キャプションは聴覚障害や難聴のあるユーザーに不可欠です。また、騒がしい環境にいる視聴者や音声言語の理解が困難な方にも利益をもたらします。音声説明は視覚障害のあるユーザーが視覚的コンテンツについてのコンテキストを得るのを可能にします。

2024年と比較して、キャプションと字幕の `<track>` 使用に大きな成長は見られておらず、デスクトップで0.1%から0.4%、モバイルで0.1%から0.2%への微増にとどまっています。これは業界にまだ大幅な改善の余地があることを示しています。

## ARIAを使った支援技術

Accessible Rich Internet Applications（ARIA）は、ウェブコンテンツのアクセシビリティを向上させるためのHTML属性のセットです。ARIAは、ネイティブHTMLだけではアクセシブルにできない複雑またはカスタムコンポーネントに特に有用です。ARIAは動的でインタラクティブなユーザーインターフェイスを強化し、スクリーンリーダーやその他の支援技術を使用する人々がすべてのページ要素を理解してインタラクトできるようにします。

ARIAは慎重に使用する必要があります。

誤った使用や過度な使用は新たな障壁を生む可能性があり、ユーザーとアクセシビリティツールの両方に混乱を引き起こします。例えば、意図された機能と一致しないARIA属性、不適切な要素に追加されたロール、または冗長なARIAはユーザー体験を乱し、アクセシビリティエラーを増やす可能性があります。

Adrian Roselliの研究は、`aria-description` などの<a hreflang="en" href="https://adrianroselli.com/2025/01/aria-description-does-not-translate.html">特定のARIAプロパティの限界</a>を強調し、ARIAの強みと落とし穴の両方を理解することの重要性を示しています。

ARIAの最も重要な原則は次のとおりです:

**ネイティブHTMLを使用できる場合は、そうするべきです。**

`<button>`、`<input>`、`<nav>` などのネイティブ要素には、ARIAが完全には再現できない組み込みのアクセシビリティがあります。ARIAは必要な場合にのみネイティブセマンティクスを補完すべきであり、置き換えるものではありません。

Florian Schroiffを含む専門家による最近の<a hreflang="en" href="https://www.a11y-collective.com/blog/aria-in-html/">ガイダンス</a>と現在のベストプラクティスは、複雑なカスタム要素にのみARIAを適用し、偶発的な排除や誤通信を避けるために仕様に厳格に従うことを強調しています。

2025年においても、ARIAはウェブアクセシビリティにおいて重要ですが、時として問題のある役割を果たし続けています。

### ARIAロール

ARIAロールは要素の目的や種類を支援技術に伝えます。2025年においても、ウェブコンテンツをアクセシブルにする上で重要な役割を果たし続けています。`<button>` などのネイティブHTML要素には組み込みのセマンティクスがありますが、ARIAはタブインターフェイスや `dialog` コンポーネントなど、ネイティブな等価物がないカスタムコンポーネントにロールを割り当てる機能を提供します。

{{ figure_markup(
  image="top-ten-most-common-aria-roles.png",
  caption="最も一般的なARIAロール トップ10。",
  description="デスクトップとモバイルページで最も一般的な10のARIAロールを示す棒グラフ。`button`が最も広く使用されているロール（デスクトップで53.06%、モバイルで53.56%）で、`presentation`（42.48%と41.54%）と`dialog`（34.05%と36.01%）が続きます。その他の頻繁に使用されるロールには、`search`、`navigation`、`img`、`main`、`region`、`group`、`status`があり、すべてページの約15〜25%に現れています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1028393265&format=interactive",
  sheets_gid="2081252628",
  sql_file="common_aria_role",
  width=600,
  height=676
  )
}}

2025年においてARIA `button` ロールの使用が約4%増加し、デスクトップで53%、モバイルサイトで54%に達しています。`presentation` や `dialog` などのロールの使用も同様の増加が見られましたが、`search` ロールの使用は安定しています。

ARIA `button` ロールの使用増加は懸念を引き起こします。これはウェブサイトが `<div>` や `<span>` などの非セマンティック要素に `button` などのロールを適用していることを示すことが多いです。あるいは、`<button>` などのネイティブHTML要素に冗長にロールを割り当てているケースもあります。

### presentationロールの使用

`role="presentation"` または `role="none"` を適用すると、支援技術に要素を純粋にプレゼンテーション的なものとして扱うよう指示します。これにより、アクセシビリティツリーからネイティブセマンティクスが削除されます。意味のある情報を伝えないレイアウト要素には有用ですが、過度な使用や誤用は重大なアクセシビリティの障壁を生む可能性があります。

例えば、`<ul>` 要素に `role="presentation"` を適用すると、子の `<li>` 要素のものを含む、リスト全体のセマンティクスが無視されます。スクリーンリーダーユーザーは、リストに何個のアイテムがあるかなどの重要なコンテキストと構造情報を失います。

`presentation` ロールは要素が純粋に装飾的またはレイアウト目的で使用される場合に誤解を招くセマンティクスを削除するのに役立ちますが、明確な意図を持って控えめに適用すべきです。

{{ figure_markup(
  caption="デスクトップサイトとモバイルサイトの少なくとも1つの`presentation`ロールを持つサイトの割合。",
  content="42%",
  classes="big-number",
  sheets_gid="2081252628",
  sql_file="common_aria_role.sql"
)
}}

2025年において、`role="presentation"` の使用が2%増加し、懸念すべきトレンドが続いています。

### ARIAを使った要素のラベリング

ブラウザはアクセシブルな名前、ロール、状態、説明などのページ要素に関する情報を公開するアクセシビリティツリーを維持しています。支援技術はこれに依存してユーザーにコンテキストを伝えます。要素のアクセシブルな名前は重要で、通常は可視テキストコンテンツから導き出されます。ただし、ネイティブテキストが不十分または利用できない場合、`aria-label` や `aria-labelledby` などのARIA属性を使用してアクセシブルな名前を明示的に設定またはオーバーライドできます。

{{ figure_markup(
  image="top-10-aria-attributes.png",
  caption="ARIA属性 トップ10。",
  description="デスクトップとモバイルページで最も一般的な10のARIA属性を示す棒グラフ。`aria-label`がデスクトップで70%、モバイルで68%でトップで、`aria-hidden`（両方で66%）が続きます。その他の頻繁に使用される属性には`aria-expanded`（40%と38%）、`aria-controls`（34%と33%）、`aria-live`（33%と32%）、`aria-labelledby`（30%と29%）があり、`aria-describedby`はデスクトップとモバイルの両方で17%まで減少しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=318641062&format=interactive",
  sheets_gid="1821302308",
  sql_file="common_element_attributes.sql",
  width=780,
  height=676
  )
}}

2025年において、主要なARIA属性のほぼすべての使用が増加しました。`aria-label` のデスクトップ使用は5%増加し、`aria-labelledby` は3%増加しました。デスクトップでの `aria-describedby` の使用は1%減少しました。

これらの変化は、開発者がよりプログラム的により多くの要素にアクセシブルな名前を割り当てていることを示しています。これは役立ちますが、慎重に実装されない場合には問題になる可能性もあります。

{{ figure_markup(
  image="button-accessible-name-source.png",
  caption="ボタンのアクセシブルな名前のソース。",
  description="デスクトップとモバイルのボタンのアクセシブルな名前のソースを示す棒グラフ。ボタンのコンテンツが大多数のアクセシブルな名前を提供しており（デスクトップで57%、モバイルで55%）、`aria-label`属性（28%と29%）が続きます。デスクトップボタンの約9%、モバイルボタンの約11%にはアクセシブルな名前がなく、`title`（1%）と`value`（5%と4%）属性からの小さなシェアがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=312250756&format=interactive",
  sheets_gid="1995812848",
  sql_file="button_name_sources.sql"
  )
}}

対応する可視ラベルなしに `aria-label` のみでボタンを定義することが4〜5%増加し続けているという懸念すべきトレンドが見られます。ユーザーが視覚的に見るものと支援技術が通知するものとのこの乖離は混乱と障壁を生む可能性があります。これは認知障害のある方や音声入力を使用する方に特に当てはまります。理想的には、一貫したユーザー体験を提供するためにアクセシブルな名前と可視ラベルが一致すべきです。

ページの約66%が `aria-label` 属性を使用しており、以前の年より増加し、アクセシブルな名前のための最も頻繁に使用されるARIA属性となっています。ページの約4分の1が `aria-labelledby` を使用しています。

アクセシビリティを向上させるためにARIAを使用することは肯定的ですが、意味のある正確な命名を確保するために支援技術を使ったテストと障害のあるユーザーの参加の重要性を強調しています。

### コンテンツの非表示

`aria-hidden="true"` 属性は要素とそのすべての子孫をアクセシビリティツリーから削除し、スクリーンリーダーからコンテンツを見えなくします。これは、そうでなければ非視覚ユーザーを混乱させる可能性がある純粋に装飾的または冗長な視覚要素を隠すのに役立ちます。

{{ figure_markup(
  caption="`aria-hidden`属性を持つ少なくとも1つの要素があるページ。",
  content="66%",
  classes="big-number",
  sheets_gid="2081252628",
  sql_file="common_aria_role.sql"
)
}}

2025年において、`aria-hidden` の使用は2024年と比較して3%増加しました。ウェブサイトの約66%がこのARIA属性を使用してコンテンツの一部を非表示にしています。

同様に、コンテンツのセクションが展開されているか折りたたまれているかを示す `aria-expanded` 属性も採用が増加し、デスクトップサイトの40%、モバイルサイトの38%に達しています。この属性はアコーディオンや展開可能なメニューなどの開示ウィジェットの状態を支援技術に伝えるために重要です。

これらのARIA属性の慎重な適用は2025年においても重要です。動的コンテンツの管理を助け、デバイスやユーザーニーズにわたってインクルーシブな体験を確保します。

### スクリーンリーダー専用テキスト

2025年においても、アクセシビリティのための一般的かつ効果的な技術として、スクリーンリーダー専用テキストの使用があります。これは視覚的に非表示になっているが、スクリーンリーダーなどの支援技術からはアクセス可能なテキストです。このアプローチは、可視インターフェイスを煩雑にせずにインタラクティブ要素に追加コンテキスト、説明、または説明的なラベルを提供するためによく適用されます。

開発者は、この効果を達成するために `.sr-only`、`.visually-hidden`、または `.element-invisible` などの一般的なCSSクラスをよく使用します。これらのクラスは通常、テキストをアクセシビリティツリーに残してスクリーンリーダーで読み取れるようにしながら、画面外の配置、クリッピング、またはゼロサイズのボックスを使用して視覚的にテキストを非表示にします。

{{ figure_markup(
  caption="sr-onlyまたはvisually-hiddenクラスを持つデスクトップウェブサイト。",
  content="16%",
  classes="big-number",
  sheets_gid="1554469444",
  sql_file="sr_only_classes.sql"
)
}}

これらの一般的なスクリーンリーダー専用クラスの使用は2024年から2025年の間で基本的に変わらずです。一部のウェブサイトは、セマンティックHTMLだけでは明らかでない方法でスクリーンリーダーユーザーにコンテキストを提供するために隠しテキストを含んでいます。

### 動的にレンダリングされたコンテンツ

ARIAライブリージョンは、動的に変化するコンテンツをアクセシブルにするために重要です。フォームバリデーションメッセージ、ステータス更新、ライブフィードなどのページコンテンツの更新をスクリーンリーダーに通知します。これらの更新はページの完全リロードなしに発生するため、ユーザーが中断なしに重要な情報を受け取るために必要です。

<figure>
  <table>
    <thead>
      <tr>
        <th>ロール</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>暗黙の <code>aria-live</code> 値</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>status</td>
        <td class="numeric">15.18%</td>
        <td class="numeric">14.51%</td>
        <td>polite</td>
      </tr>
      <tr>
        <td>alert</td>
        <td class="numeric">7.12%</td>
        <td class="numeric">6.74%</td>
        <td>assertive</td>
      </tr>
      <tr>
        <td>timer</td>
        <td class="numeric">0.91%</td>
        <td class="numeric">0.84%</td>
        <td>off</td>
      </tr>
      <tr>
        <td>log</td>
        <td class="numeric">0.61%</td>
        <td class="numeric">0.55%</td>
        <td>polite</td>
      </tr>
      <tr>
        <td>marquee</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
        <td>off</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ライブリージョンARIAロールとその暗黙の`aria-live`値を持つページ。",
      sheets_gid="2081252628",
      sql_file="common_aria_role.sql"
      )
    }}
  </figcaption>
</figure>

2025年において、サイトの約33%が `aria-live` 属性を使用しており、2024年から4%増加しています。本質的に `aria-live` 値が `polite` である `status` の `role` 値の使用が約5%増加しました。これは、緊急でない更新をユーザーに通知するていねいな通知の広範な採用を示しています。

`alert`、`timer`、`log`、`marquee` などの追加のARIAロールも、事前定義された動作で暗黙の `aria-live` 属性を持ち、幅広いライブリージョンのユースケースを可能にします。

2025年のARIAライブリージョンの使用増加は、動的なコンテンツ更新を効果的に伝達する進歩を反映しており、最新のレスポンシブなウェブ体験とインタラクトするために支援技術に依存するユーザーをサポートしています。

## ユーザーパーソナライゼーションウィジェットとオーバーレイ修復

アクセシビリティウィジェットとオーバーレイ修復ツールは、ウェブサイトのアクセシビリティを向上させるためのサードパーティスクリプトです。フォントサイズやコントラスト調整などのユーザーパーソナライゼーションオプションと、一般的なアクセシビリティ問題の自動修正を提供します。

これらのオーバーレイは多くの場合、迅速なコンプライアンス修正を約束しますが、手動のコードとデザイン変更を必要とする複雑なアクセシビリティの課題に対処するには不十分です。<a hreflang="en" href="https://www.edf-feph.org/accessibility-overlays-dont-guarantee-compliance-with-european-legislation/">欧州障害フォーラム</a>は、このようなツールがユーザー自身の支援技術に干渉し、アクセシビリティを低下させてユーザーをイライラさせる競合を引き起こす可能性があると警告しています。

オーバーレイは一部の表面的な障壁を取り除き、追加のパーソナライゼーション機能を提供するのに役立ちますが、それに依存することで組織が適切なアクセシビリティへの投資をやめてしまうことが多くなります。オーバーレイは一般的に、根本的なコードの問題を修正することと比較して、使いやすさ、セキュリティ、パフォーマンスの欠点がより多いです。

{{ figure_markup(
  image="pages-using-accessibility-apps-overlays.png",
  caption="アクセシビリティアプリ（オーバーレイ）を使用しているページ。",
  description="2021年から2025年にかけてのデスクトップとモバイルでアクセシビリティアプリ（オーバーレイ）を使用しているページの割合を示す複数シリーズの棒グラフ。使用率は着実に成長しており、デスクトップで1.0%から2.1%、モバイルで0.8%から1.8%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=277084081&format=interactive",
  sheets_gid="93717182",
  sql_file="a11y_technology_usage.sql"
  )
}}

データによると、デスクトップサイトの約2%がそのようなアクセシビリティアプリを使用しています。最も高いトラフィックのサイトではさらに低く、トップ1,000では0.2%です。このパターンは、オーバーレイは主にトラフィックの少ないサイトに採用されており、議論の多い不完全なソリューションであることを示しています。

2025年の使用率の小幅な増加にもかかわらず、これらのアクセシビリティアプリの分布は2024年と一致しており、<a hreflang="en" href="https://userway.org/">UserWay</a>、<a hreflang="en" href="https://accessibe.com/">AccessiBe</a>、<a hreflang="en" href="https://www.audioeye.com/">AudioEye</a>、<a hreflang="en" href="https://www.equalweb.com/">EqualWeb</a> などのプロバイダーが主流です。

{{ figure_markup(
  image="accessibility-app-usage-by-rank.png",
  caption="ランク別アクセシビリティアプリの使用状況。",
  description="トップ1000からトップ1億までのサイトランクグループ別に特定のアクセシビリティアプリ（AccessiBe、AudioEye、EqualWeb、UserWay）を使用しているページの割合を示す複数シリーズの棒グラフ。UserWayはほとんどのランクで最も高い使用率を示し、トップ1000万グループで0.81%でピークに達し、AccessiBe はトップ100万グループで0.58%でピークに達します。使用率は上位層と下位層のサイトの両方と比較して、中位層のランクグループ（1万から1000万）でより高い傾向があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1915310442&format=interactive",
  sheets_gid="2094043875",
  sql_file="a11y_technology_usage_by_domain_rank.sql"
  )
}}

### オーバーレイに関する混乱

アクセシビリティオーバーレイとパーソナライゼーションウィジェットは、2025年に約2%の小幅な使用増加を見せているものの、依然として大きな論争と混乱の源となっています。

国際アクセシビリティ専門家協会（IAAP）や欧州障害フォーラム（EDF）などの主要組織は、オーバーレイが万能薬ではないと明示的に警告しています。ユーザーのアクセスを妨げたり、支援技術に干渉したりしてはならず、サイトを完全に準拠させるものとしてマーケティングされるべきではありません。

マーケティングの主張は組織に非現実的な期待を生むことが多く、法的および実際的なリスクにつながります。これらのツールは、インクルーシブデザイン、手動アクセシビリティテスト、継続的な修復に代わることはできません。これらはすべてアクセシビリティ基準を満たすために不可欠です。

欧州アクセシビリティ法やその他の規制は、アクセシビリティはウェブサイトのソースに組み込まれなければならないことを強調しています。アクセシビリティオーバーレイが存在していても、基礎となるウェブサイト自体がアクセシブルでなければ、アクセシビリティ基準の詳細な基準を満たしません。したがって、それ自体では適切なソリューションではありません。

Bitvtest.deは<a hreflang="de" href="https://bitvtest.de/test-methodik/web/beschreibung-des-pruefverfahrens#c761">最近、オーバーレイツールを使用するウェブサイトのテストを中止し、認証マークの付与を禁止することを決定</a>しました。Bitvtestは、ウェブサイトやアプリのアクセシビリティをチェックするための構造化されたアプローチであるドイツのBITV-Testを基盤とした専門的なアクセシビリティテストサービスです。

## 人工知能（AI）の影響

人工知能（AI）は、通常人間の知能を必要とするタスクを実行できるシステムを構築することに焦点を当てたコンピュータサイエンスの広大な分野です。この分野の中で、大規模言語モデル（LLM）は統計的パターンを学習するために非常に大きなデータセットでトレーニングされた特定の種類のAIシステムです。

LLMはこれらのパターンを使用してテキストを生成・変換し、質問に答え、指示に従いますが、人間的な意味での理解や意図はありません。トレーニングデータに基づいて可能性の高い単語や文章を予測します。

ウェブアクセシビリティツールはLLMにますます依存しています。多くのプラットフォームが不足している画像説明に対処する方法としてAI生成の `alt` テキストを提供するようになりましたが、これらの自動化ソリューションの品質と精度は大きく異なります。

開発者は<a hreflang="en" href="https://github.com/github/accessibility-scanner">GitHubのアクセシビリティスキャナー</a>などのAIツールを日常業務に取り入れています。これらのツールはインスタントフィードバックとアクセシビリティの推奨事項を提供し、アクセシビリティの問題を修正しやすくします。

しかし、アクセシビリティにおけるAIには問題がないわけではありません。

現時点では、AIがウェブサイトやそのコンテンツを作成または改善したかどうかを確認する標準的な方法がありません。これにより、サイトの評価が難しくなり、ユーザーが何を見ているかわからないままにしています。

アクセシビリティアドボケートのLéonie Watsonのような専門家は、AIがオンラインでコンテンツとのインタラクション方法を変える「<a hreflang="en" href="https://tetralogical.com/blog/2025/08/08/accessibility-and-the-agentic-web/">エージェンティックウェブ</a>」について話しています。これはアクセシビリティ基準をどのように適応させる必要があるかという疑問を提起します。

AI搭載のブラウザと拡張機能は急速に主流になりつつあります。ブラウザに組み込まれた音声アシスタントとAIエージェントは、基本的な情報検索のほとんどを間もなく処理するかもしれません。人々はすでに従来の検索結果の代わりにAI生成の回答を選択するオプションがあります。このシフトはアクセシブルなデザインを助けたり傷つけたりする可能性があります。それはすべてこれらのAIツール自体が完全にアクセシブルかどうかにかかっています。

Joe Dolsonのような専門家は<a hreflang="en" href="https://wpbuilds.com/accessibility/5/">AIが独自に完全にアクセシブルなウェブサイトを構築できるかどうか</a>を探求し、技術の潜在的可能性と現在の限界の両方を強調しています。Scott VinkleのShopifyでの<a hreflang="en" href="https://scottvinkle.com/blogs/work/4-ways-i-use-ai-as-an-accessibility-specialist">経験</a>は、AIが実際の状況でアクセシビリティを向上させる方法を示しています。

<a hreflang="en" href="https://www.a11y-collective.com/blog/artificial-intelligence-accessibility/">A11Y CollectiveブログのAIとアクセシビリティについて</a>は、`alt` テキストやリアルタイムキャプション、音声アシスタントを自動化するAIツールは規模でアクセシビリティを助けることができますが、精度、コンテキスト、プライバシー、バイアスにまだ苦労していると指摘しています。

<a hreflang="en" href="https://dri.es/comparing-local-llms-for-alt-text-generation">Dries Buytaertの研究</a>は、AIが未ラベルの画像の膨大なバックログに対処できることを示していますが、品質のための人間によるレビューはまだ不可欠です。彼はAI搭載のalt textを検討している組織のための品質、プライバシー、コスト、複雑さのバランスを探ります。

<a hreflang="en" href="https://www.digitalaccesstraining.com/pages/articles?p=ai-and-accessibility-opportunities-and-challenges-for-content-creators">デジタルアクセシビリティトレーニング</a>は、コンテンツクリエイター向けのAIの機会と課題を概説しています。AIツールは規模でアクセシビリティ機能を実現しますが、コンテンツの妥当性、バイアス、倫理的使用についての懸念を引き起こします。

Hidde de Vriesは<a hreflang="en" href="https://hidde.blog/ai-for-accessible-components/">人間と言語モデルがアクセシブルなコンポーネントコードにアプローチする方法を対比</a>しています。人間はインターフェイスの意図に導かれ、仕様、ユーザーニーズ、支援技術の動作、プラットフォームの特性に基づいてHTML、CSS、ARIAの決定を行います。LLMの代わりにトレーニングデータから可能性の高いコードを予測しますが、これは既存のコードのほとんどにアクセシビリティの問題があり、モデルには特定のユーザーへの意図や理解がないため問題です。

Adrian Roselliは、コンピュータビジョンとLLMの最近の進歩が、複雑な記事を理解しやすい要約に蒸留するのを読者が助ける可能性があることを認めています。しかし、彼は<a hreflang="en" href="https://adrianroselli.com/2023/06/no-ai-will-not-fix-accessibility.html">これらのツールにはまだコンテキストと著者性が欠けている</a>と主張しています。コンテンツがなぜ作成されたか、ジョークやミームが何に依存しているか、またはインターフェイスがどのように機能することを意図されているかを知ることができません。彼らの説明とコードの提案は容易に要点を外れたり、ユーザーを誤解させたりする可能性があります。

AIはアクセシビリティを超えた重要な倫理的懸念を引き起こします。

{{ figure_markup(
  caption="LLMのトレーニングに必要な炭素排出量に相当するガソリン車の台数。",
  content="100",
  classes="big-number",
)
}}

主要な問題の1つは環境への影響です。<a hreflang="en" href="https://arxiv.org/ftp/arxiv/papers/2104/2104.10350.pdf">炭素排出量と大規模ニューラルネットワークのトレーニングに関する研究</a>は、GPT‑3のような単一の大規模言語モデルのトレーニングが1,200メガワット時以上の電力を消費し、約500〜550メートルトンのCO₂相当を生産したと推定しています。これは100台以上のガソリン車の生涯排出量に相当します。詳しい情報については[サステナビリティ](./sustainability)チャプターを参照してください。

もう1つの核心的な懸念は、トレーニングデータがどのように収集・使用されるかです。<a hreflang="en" href="https://natlawreview.com/article/two-major-lawsuits-aim-answer-multi-billion-dollar-question-can-ai-train-your">高プロファイルな訴訟</a>のいくつかは、AIベンダーが許可や補償なしに著作権のある素材をスクレイピングして使用したと主張しています。これには何百万ものストック写真や本が含まれていました。

大規模モデルの<a hreflang="en" href="https://www.boia.org/blog/ethics-of-ai-in-accessibility-avoiding-bias-when-using-generative-ai-text">研究</a>は、それらがトレーニングデータに存在する障害差別的、人種差別的、その他の有害なバイアスを増幅できることを示しています。これは最終的に、障害、人種、性別の説明方法を形成し、規模でスティグマを強化します。

先を見据えると、AIはウェブ開発者とコンテンツクリエイターが依存するツールとしてますます重要になることは明らかです。しかし、AIは人間の専門知識を支援すべきであり、置き換えるものではありません。

これらのツールが改善されるにつれて、アクセシビリティコミュニティは2026年以降のいくつかの重要な問題に答える必要があります：

- AI生成コンテンツが正確でアクセシブルかどうかを確認するにはどうすればよいか？
- ウェブコンテンツにおけるAIの使用を管理すべき基準は何か？
- 支援技術はAI駆動インターフェイスとどのように機能するか？
- AIは個人のニーズを尊重しながら平等なアクセシビリティを提供できるか？
- AIがバイアスを強化したり人々を排除するのを防ぐためにはどのような倫理ガイドラインが必要か？

## セクターとアクセシビリティ

このセクションでは、パターンとリーダーを特定するために、さまざまな業界およびコミュニティセクター間でアクセシビリティスコアを比較します。

### 国

ウェブサイトの原産国は、サーバーの地理的位置（GeoID）またはトップレベルドメイン（TLD）によって特定できます。どちらの方法にも限界があります。ホスティングコスト、サーバーロケーション戦略、ドメイン所有慣行により、ウェブサイトのサーバーが対象ユーザーを反映していない場合があります。`.ai` や `.io` などのグローバルに使用されているTLDは、必ずしも原産国に結びついているわけではありません。

{{ figure_markup(
  image="most-accessible-by-geoid-of-server.png",
  caption="サーバーのGeoIDによる最もアクセシブルな国",
  description="トップレベルドメイン全体の平均アクセシビリティスコアで国をランキングした表。米国が85.63%でトップ、次いでカナダ（84.98%）、英国（84.96%）、オーストラリア（84.59%）が続く。ドイツ（84.53%）やオランダ（83.86%）、フランス（83.82%）などの欧州諸国も高くランク付けされており、日本（81.54%）、韓国（79.39%）、台湾（79.19%）などのアジア諸国はスコアが低い。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1913573905&format=interactive",
  sheets_gid="134589352",
  sql_file="lighthouse_score_by_country.sql",
  height=500
  )
}}

2025年、米国はGeoIDによる最もアクセシブルな国として引き続きトップの位置を維持しており、これは連邦機関に対する数十年にわたるSection 508コンプライアンス要件とADA第III編訴訟の継続によって推進されています。`.edu` と `.gov` TLDもアクセシビリティ指標をリードしており、米国政府および教育機関の必須コンプライアンスを反映しています。

2025年におけるEUアクセシビリティ法の限定的な影響も注目されます。この法律は2025年6月28日に完全施行され、欧州連合全域で民間・公共セクターのデジタルサービスをアクセシブルにすることを義務付けましたが、予備データはヨーロッパベースのサイトのウェブアクセシビリティに劇的な上昇がないことを示しています。

このラグは、実装上の課題、既存サービスの移行期間、および組織がデジタルオファリングを再設計・監査するために必要な時間を反映していると考えられます。

法的執行と訴訟の脅威は、米国のリーディングポジションが示すように、アクセシビリティコンプライアンスの最も強力な推進力であり続けています。新しいヨーロッパおよびグローバルな法律の完全な影響が、組織が実装スケジュールと移行期間を調整する中で、ウェブアクセシビリティ統計に現れるには数年かかる可能性があります。

2025年に注目すべきトレンドが現れました。`.ai` ドメインがアクセシビリティランキングに初めて登場し、現在は `.edu` と `.gov` を除くすべてのTLDを上回っています。これは、アクセシビリティを含む最新の開発慣行を優先するAI関連ビジネスの採用拡大を反映していると考えられます。

1995年に小さなカリブ海の島である[アンギラ](https://en.wikipedia.org/wiki/Anguilla)に最初に割り当てられた `.ai` TLD拡張子は、2009年にアンギラが全世界への直接登録を開放するまで、15年近くほとんど無名のままでした。このドメインは、2022年以降の人工知能ブームがそれをグローバルで最も急成長するTLDの1つに変えるまで、その歴史のほとんどを休眠状態で過ごしました。

転機となったのは、2022年後半のChatGPTの登場で、AIへの前例のない関心を呼び起こしました。2022年7月から2023年7月の間に、<a hreflang="en" href="https://domainwheel.com/ai-domains-statistics/">登録済みの `.ai` ドメインは急増し</a>、75,314件から196,292件へと、わずか12ヶ月で161%増加しました。

地理的には、北米が `.ai` <a hreflang="en" href="https://techjury.net/industry-analysis/the-rise-of-ai-domains/">登録</a>の62.5%を占め、米国だけで全登録済み `.ai` ドメインの62.5%を占めています。アジアが18.8%、ヨーロッパが17.2%で続いています。

多くの `.ai` ドメイン保有者はベンチャー支援を受けた、資金力のあるテクノロジースタートアップであり、AIを使用する可能性が高いです。AIが人間チームよりもアクセシブルなコードを生成できるかどうかはまだ議論中ですが、これは1つの指標です。

`.com` や `.org` を使用する古い伝統的な企業とは異なり、新しいAI企業は最初からアクセシビリティを考慮した現代のウェブ標準とツールで構築することが多いです。`.ai` ドメインを使用しAI製品を販売するこれらの企業は、少なくともコードやコンテンツのために相談するという形で、より自動化されたエージェント的なセットアップで使用していない場合でも、ウェブサイト構築にAIを関与させている可能性が非常に高いです。

`.com`、`.org`、`.net` などの伝統的なTLDはアクセシビリティのリーダーとしてランク付けされていません。これは、ドメインタイプだけではアクセシビリティコンプライアンスの強力な予測因子ではないことを示唆しています。

{{ figure_markup(
  image="accessible-countries-by-top-level-domain-tld.png",
  caption="トップレベルドメイン（TLD）によるアクセシブルな国。",
  description="平均アクセシビリティスコアでトップレベルドメイン（TLD）をランキングしたバーチャート。教育（.edu）と政府（.gov）ドメインが89.1%と87.6%でトップ、次いで.ai（87.2%）、.no（87.0%）、.fi（86.5%）が続く。.ca（85.9%）、.io（85.8%）、.se（85.5%）、.at（85.4%）、.uk（85.3%）などの国別コードTLDも高いスコアを示し、.de（85.0%）や.co（84.6%）などの一般的なTLDはトップ20の下位に位置する。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=414356016&format=interactive",
  sheets_gid="1037208406",
  sql_file="lighthouse_score_by_tld.sql",
  width=600,
  height=480
  )
}}

TLDランキングの地図は2024年と非常に似ていますが、現在利用可能な非国特定TLDの増加数は当然ながら含まれていません。

{{ figure_markup(
  image="map-accessible-countries-by-tld.png",
  caption="トップレベルドメイン（TLD）によるアクセシブルな国の地図。",
  description="世界地図で視覚的に表示された最もアクセシブルな国々は、ノルウェーの87%、フィンランドの86%で、次いでカナダ、米国、英国、スウェーデン、アイルランド、オーストラリア、ニュージーランド、オーストリア、ベルギー、スイス、デンマーク、南アフリカが続く。中国はトップレベルドメインによるアクセシビリティが最も低く、約67%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1554186781&format=interactive",
  sheets_gid="1037208406",
  sql_file="lighthouse_score_by_tld.sql"
  )
}}

### 政府

政府ウェブサイトは、アクセシビリティへの公的コミットメントを示す重要な場であり続けています。しかし、実装は各管轄区域によって大きく異なります。2025年のデータは、最近の法律、データ収集の方法論的変化、執行メカニズムの影響を受けたグローバルな政府ウェブサイトアクセシビリティの重要なトレンドを明らかにしています。

今年は、2024年のスキャンに含まれなかったより広範なドメインを評価するために、異なる方法論を使用しました。

2024年には、オランダ政府から79ドメインのみをサンプリングしました。2025年には957ドメインと10倍以上の数を照会しました。同様に、ルクセンブルクとフィンランドについては約2倍の数のドメインをスキャンしました。精度の向上により、より包括的なデータセットが得られますが、前年比較も複雑になります。

英国では、アクセシビリティが94%に改善し、2024年から2%上昇しました。これは、すべての公共デジタルサービスにおけるアクセシビリティを優先する<a hreflang="en" href="https://www.gov.uk/service-manual/service-standard">英国政府のデジタルサービス基準</a>などの標準化されたデザインシステムの恩恵を反映しています。オランダ、ルクセンブルク、フィンランドは引き続きリードしており、オランダは過去の年に98%を達成しています。これらの国は、一貫したガバナンスフレームワークとデザインシステムの優先化によってこの地位を維持しています。

スコットランド（gov.scot）とウェールズ（gov.wales）も含めるよう努力しました。2025年には19,568ドメインから平均を算出しましたが、2024年は16,594ドメインのみでした。

モニタリングはアクセシビリティを優先するための重要な要素であり、アクセシビリティを含む多くのウェブサイト品質指標の進捗状況を強調する<a hreflang="en" href="https://observatoire.numerique.gouv.fr/observatoire">フランス政府のダッシュボード</a>のような取り組みを称賛します。この背後にあるコードの多くはオープンソースです。オランダ政府も約9,000のウェブサイトとアプリケーションを追跡する<a hreflang="en" href="https://dashboard.digitoegankelijk.nl/">ダッシュボード</a>を持っています。執筆時点で、追跡されているすべてのウェブプロパティの60%が法的要件に準拠しています。

<a hreflang="en" href="https://accessible-eu-centre.ec.europa.eu/accessibility-monitoring_en">AccessibleEUが実施するアクセシビリティモニタリングレポート</a>は重要ですが、より抽象的です。EUの[ウェブアクセシビリティ指令](https://en.wikipedia.org/wiki/Web_Accessibility_Directive)は、加盟国に3年ごとにアクセシビリティコンプライアンスを監視・報告することを要求しています。<a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/news/web-accessibility-directive-monitoring-reports-2022-2024">これらのレポート</a>は公開されています。

欧州連合の進化する規制環境は、2025年の政府ウェブサイトアクセシビリティに大きな影響を与えています。

EUウェブアクセシビリティ指令は、公共セクターの組織に特定の技術的基準を満たすことを要求しています。2025年6月28日に完全施行されたより広範な欧州アクセシビリティ法（EAA）は、eコマース、旅行、銀行などの主要セクターの民間セクター組織に要件を拡大しています。

この規制の勢いにもかかわらず、2025年のアクセシビリティデータは欧州政府ウェブサイトコンプライアンスに劇的な急増を示しておらず、実装がまだ進行中であり、完全な影響は2026年まで見えないかもしれないことを示唆しています。

EUの加盟国は、ユーザーがバリアを報告するためのアクセシビリティステートメントを公開し、フィードバックメカニズムを提供することが求められています。<a hreflang="en" href="https://cerovac.com/a11y/2025/07/we-need-to-talk-about-your-accessibility-statement/">アクセシビリティステートメント</a>はEUのウェブアクセシビリティ指令の重要な部分ですが、現時点ではサイトスキャンに含める良い方法がありません。Funka Foundationは、<a hreflang="en" href="https://www.linkedin.com/pulse/yes-nordics-score-well-lets-think-one-step-further-funkafoundation-yczzf/">コンプライアンスのためのこのタイプのテストの限界</a>について思い起こさせてくれています。

{{ figure_markup(
  image="most-accessible-national-government.png",
  caption="最もアクセシブルな国家政府。",
  description="平均アクセシビリティスコアで国家政府ドメインをランキングしたバーチャート。英国が94.31%でトップ、次いでオランダ（93.81%）、フィンランド（93.77%）、ノルウェー（93.49%）、スウェーデン（93.37%）が続く。シンガポール、デンマーク、ルクセンブルク、欧州連合、オーストラリア、オーストリア、ベルギー、アイスランド、ニュージーランド、アイルランドを含む他のいくつかの欧州連邦政府も90%以上のスコアを示している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=940831164&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

2025年の地図は2024年とほとんど区別がつきません。

{{ figure_markup(
  image="map-accessibility-global-government-websites.png",
  caption="グローバルな政府ウェブサイトのアクセシビリティの地図。",
  description="地図は世界中の最もアクセシブルな政府ウェブサイトを視覚的に示しています。スカンジナビア諸国が際立っており、ヨーロッパの多くの国々も同様です。オーストラリアとニュージーランドが太平洋地域で強調されています。カナダは米国よりもわずかに濃い色で表示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1960560393&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

米国では、新しい連邦義務にもかかわらず、州政府のコンプライアンスは一貫性がないままです。2024年6月に公表された障害を持つアメリカ人法（ADA）第II編に関する司法省（DOJ）の最終規則は、すべての州および地方政府機関がWCAG 2.1 AAコンプライアンスを特定の期限までに達成することを要求しています：人口50,000人以上を対象とする機関は2026年4月26日まで、小規模機関は2027年4月26日まで。

コロラドやバーモントなどの州は、集中型ガバナンス構造を確立することで優れた成果を上げています。<a hreflang="en" href="https://sipa.colorado.gov/">コロラド州の全州インターネットポータル局</a>（SIPA）は、集中管理が複数の機関にわたるアクセシビリティを改善する方法を示しています。

ネバダ、カンザス、カリフォルニア、ニューヨークは両年のサンプルで好成績でした。しかし、平均値は州政府が<a hreflang="en" href="https://www.justice.gov/archives/opa/pr/justice-department-publish-final-rule-strengthen-web-and-mobile-app-access-people">2024年の司法省ウェブおよびモバイルアプリアクセス強化のための最終規則</a>の新要件の達成に有意な進歩を遂げたことを示していません。全国州最高情報責任者協会（NASCIO）全国会議での州技術リーダーたちは、<a hreflang="en" href="https://statescoop.com/accessibility-nascio-state-priority-2025/">アクセシビリティを最優先事項として再確認しました</a>。

<a hreflang="en" href="https://www.access-board.gov/news/2025/07/21/celebrating-35-years-of-americans-with-disabilities-act/">7月に35周年を迎えた</a>障害を持つアメリカ人法（ADA）は、グローバルに前例を設けた先駆的な取り組みでした。

オープンソースツール<a hreflang="en" href="https://github.com/GovTechSG/oobee">Oobee</a>を通じて示された<a hreflang="en" href="https://archive.opengovasia.com/2025/03/11/digital-accessibility-singapores-commitment-to-inclusivity/?c=ca">シンガポールのアクセシビリティ改善への最近のコミットメント</a>は、新興のグローバルモメンタムを示しています。Oobeeは組織が数百ページをスキャンし、統合アクセシビリティレポートを生成できるようにし、<a hreflang="en" href="https://www.digitalpublicgoods.net/r/oobee">デジタル公共財</a>としての位置づけをしています。

{{ figure_markup(
  image="most-accessible-us-state-governments.png",
  caption="最もアクセシブルな米国州政府。",
  description="平均アクセシビリティスコアで米国の州・準州政府サイトをランキングしたバーチャート。ニューハンプシャーが94.61%でトップ、次いでネバダ（92.43%）、カンザス（91.67%）、ニューヨーク（91.45%）、サウスカロライナ（91.07%）が続く。アリゾナ、カリフォルニア、ミズーリ、モンタナ、ノースカロライナを含む他の多くの州も約90%以上のスコアを示す一方、ニュージャージー（83.91%）やロードアイランド（83.31%）などの州はリストの下位に位置する。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=445029634&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql",
  width=600,
  height=500
  )
}}

### コンテンツ管理システム（CMS）

ウェブサイトのコンテンツ管理システム（CMS）の選択は、アクセシビリティの結果に大きな影響を与えます。<a hreflang="en" href="https://almanac.httparchive.org/en/2024/methodology#wappalyzer">Wappalyzer</a>のデータを使用して、2025年のWeb Almanacは従来のCMS、プラットフォーム、専門的なウェブサイトビルダー全体でアクセシビリティスコアを比較しました。これにより、一貫したパターンと注目すべき外れ値の両方が明らかになりました。

{{ figure_markup(
  image="most-accessible-traditional-cms.png",
  caption="最もアクセシブルな従来のCMS。",
  description="平均アクセシビリティスコアで従来のコンテンツ管理システム（CMS）をランキングしたバーチャート。ContentfulとAdobe Experience Managerが88.28%と88.26%のスコアでトップ、次いでWordPress（85.58%）、Contao（85.29%）、Drupal（85.22%）、Craft CMS（85.13%）が続く。TYPO3 CMS、Odoo、DNN、Joomlaが84.71%から82.11%のスコアでリストを締めくくる。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=2137638034&format=interactive",
  sheets_gid="419466395",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

従来のCMSの中で、<a hreflang="en" href="https://www.sitecore.com/">Sitecore</a>は2025年に85%のアクセシビリティを維持しましたが、インスタンス数は10,000を下回りました。<a hreflang="en" href="https://business.adobe.com/products/experience-manager/sites/aem-sites.html">Adobe Experience Manager（AEM）</a>と<a hreflang="en" href="https://www.contentful.com/">Contentful</a>は引き続きリードしており、これらのエンタープライズソリューションを採用する大企業がアクセシビリティの問題に対処するためのリソースをより多く持っているためと考えられます。<a hreflang="en" href="https://wordpress.com/">WordPress</a>は2024年から有意な改善を示しませんでしたが、市場支配力とユーザーベースの高まるアクセシビリティ意識を反映して、3位に上昇しました。

注目すべきことに、上位5つの従来のCMSは一貫したエラーパターンを共有しています。カラーコントラスト、リンク名、見出し順序が最も一般的な問題として支配的です。CMSはリンクの命名や色の選択を指示できないため、これらのエラーは主にプラットフォームの制限ではなくコンテンツの選択を反映しています。ただし、AEMだけが上位5つのエラーに `label-content-name-mismatch` を含んでいます。WordPressは `meta-viewport` エラーを持つ点でユニークです。

上位10のCMSの中で、<a hreflang="en" href="https://www.dnnsoftware.com/">DNN</a>だけが上位3つのエラーに `image-alt` を持っています。ほとんどの従来のCMSでは、`image-alt` と `target-size` はGoogle Lighthouseエラーの4位または5位に一貫して位置しています。

{{ figure_markup(
  image="most-accessible-website-platform-cms.png",
  caption="最もアクセシブルなウェブサイトプラットフォームCMS。",
  description="平均アクセシビリティスコアでウェブサイトプラットフォームコンテンツ管理システム（CMS）をランキングしたバーチャート。Wixが94.19%の平均スコアでトップ、次いでSquarespace（93.05%）、WebNode（91.44%）、Google Sites（90.10%）が続く。Webflow、HubSpot CMS Hub、Shopify、Framer Sites、Duda、Weeblyなどの他のプラットフォームも89.07%から85.80%のスコアで好調なパフォーマンスを示す。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=408491967&format=interactive",
  sheets_gid="419466395",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォームCMS</th>
        <th>最も多い</th>
        <th>2番目</th>
        <th>3番目</th>
        <th>4番目</th>
        <th>5番目</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a hreflang="en" href="https://www.wix.com/">Wix</a></td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>color-contrast</td>
        <td>button-name</td>
        <td>target-size</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.squarespace.com/">Squarespace</a></td>
        <td>color-contrast</td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>label-content-name-mismatch</td>
        <td>frame-title</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.webnode.com/">Webnode</a></td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>frame-title</td>
        <td>color-contrast</td>
        <td>image-redundant-alt</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://workspace.google.com/products/sites/">Google Sites</a></td>
        <td>image-alt</td>
        <td>link-name</td>
        <td>aria-allowed-attr</td>
        <td>heading-order</td>
        <td>color-contrast</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://webflow.com/">Webflow</a></td>
        <td>link-name</td>
        <td>color-contrast</td>
        <td>heading-order</td>
        <td>html-has-lang</td>
        <td>target-size</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="人気のCMSプラットフォームの上位アクセシビリティ監査問題。",
      sheets_gid="419466395",
      sql_file="lighthouse_score_by_cms.sql"
      )
    }}
  </figcaption>
</figure>

Wix、Squarespace、Google Sitesなどのウェブサイトプラットフォームは、アクセシビリティにおいて従来のCMSを大幅に上回っています。この優れたパフォーマンスは、そのアプローチに起因していると考えられます。これらのプラットフォームは、テンプレート化されたデザインと組み込みのアクセシビリティデフォルトを通じてユーザーの選択を制限し、アクセシビリティの悪い決定の機会を減らすことがよくあります。

データは、コンテンツクリエイターが一部の決定に最終的な責任を持つ場合でも、CMSの選択がアクセシビリティの結果に有意な影響を与えることを証明しています。より厳格なデザイン制約と組み込みのアクセシビリティデフォルトを持つプラットフォームはより優れたパフォーマンスを示し、最大の柔軟性を提供するプラットフォームはアクセシビリティの決定をユーザーに委ねます。

### JavaScriptフロントエンドフレームワーク

JavaScriptフレームワークの選択も、ウェブサイトのアクセシビリティの結果に大きな影響を与えます。<a hreflang="en" href="https://stateofjs.com/en-US">State of JSレポート</a>の分類を使用して、さまざまなUIフレームワークとメタフレームワークがアクセシビリティパフォーマンスとどのように相関するかを調べました。これにより、パターン、変化、そして新興の懸念が明らかになりました。

{{ figure_markup(
  image="most-accessible-javascript-frontend-ui-frameworks.png",
  caption="最もアクセシブルなJavaScriptフロントエンドUIフレームワーク。",
  description="平均アクセシビリティスコアでJavaScriptフロントエンドUIフレームワークをランキングしたバーチャート。Qwikが91.86%の平均スコアでトップ、次いでStimulus（91.42%）とOpenUI5（90.23%）が続く。Astro（89.22%）、Next.js（88.05%）、Remix（87.61%）、React（87.56%）、Ember.js（86.72%）、Alpine.js（85.91%）、Angular（85.63%）、Preact（85.28%）も比較的高いアクセシビリティスコアを達成している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=430687243&format=interactive",
  sheets_gid="1977955459",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

2025年、<a hreflang="en" href="https://openui5.org/">OpenUI5</a>がアクセシビリティランキングで上昇した一方、2024年にリードしていたフレームワーク（<a hreflang="en" href="https://stimulus.hotwired.dev/">Stimulus</a>、<a hreflang="en" href="https://remix.run/">Remix</a>、<a hreflang="en" href="https://qwik.dev/">Qwik</a>）は順位が変動しました。RemixはUIとメタフレームワークの両方のカテゴリに登場しますが、2025年にはランキングが低下し、他のフレームワークが前進できるようになりました。この不安定さは、サンプルサイズの変化や競合フレームワークの実際の改善を反映している可能性があります。Remixのすべての機能が<a hreflang="en" href="https://reactrouter.com/">React Router</a>の次のバージョンに統合され、Remixがリアクトフレームワークとして冗長になったという事実も、ランキングに影響を与える可能性があります。

歴史的に、Stimulus、Remix、Qwikは、プログレッシブエンハンスメントとセマンティックHTMLを優先しているため、React、<a hreflang="en" href="https://svelte.dev/">Svelte</a>、<a hreflang="en" href="http://Ember.js">Ember.js</a>などのメインストリームオプションを数パーセントポイント上回っていました。

メタフレームワークの中では、Remix、<a hreflang="en" href="https://rwsdk.com/">RedwoodJS</a>、<a hreflang="en" href="https://astro.build/">Astro</a>が2024年にリードしており、Remixの低下により<a hreflang="en" href="https://www.gatsbyjs.com/">Gatsby</a>が2025年に3位に上昇しました。サーバーファーストのメタフレームワーク（SvelteKit、Astro、Remix、Qwik、<a hreflang="en" href="https://fresh.deno.dev/">Fresh</a>、<a hreflang="en" href="https://analogjs.org/">Analog</a>）の台頭は、クライアントサイドJavaScriptの複雑さを軽減することで、より優れたパフォーマンスとアクセシビリティの実践に向けた広範な業界のシフトを反映しています。

ライブラリの選択もアクセシビリティに影響します。

Reactは最大の柔軟性とカスタマイズを提供しますが、開発者がアクセシビリティを意図的に実装することを要求します。その広範なエコシステムには<a hreflang="en" href="https://react-spectrum.adobe.com/react-aria/index.html">React Aria</a>や<a hreflang="en" href="https://reach.tech/">Reach UI</a>などのアクセシビリティ重視のライブラリが含まれていますが、アクセシビリティはデフォルトで強制されません。

<a hreflang="en" href="https://angular.dev/">Angular</a>は、強力な組み込みアクセシビリティ機能、セマンティックHTMLを促進する構造化された規則、ARIA属性サポート、およびキーボードナビゲーションとスクリーンリーダーサポートを標準搭載した<a hreflang="en" href="https://material.angular.io/">Material Design</a>コンポーネントを提供します。Angularの意見が強い構造は、開発者をより標準化されたアクセシブルな実践に向けて導く傾向があります。

<a hreflang="en" href="http://Vue.js">Vue.js</a>は、Reactの柔軟性とAngularの構造のバランスを目指しています。Vueのプログレッシブデザイン、明確なテンプレート構文、コンポーネントアーキテクチャはアクセシビリティをサポートしていますが、<a hreflang="en" href="https://github.com/vue-a11y">vue-a11y</a>などのサードパーティプラグインへの依存度が高くなっています。

<a hreflang="en" href="https://github.blog/open-source/social-impact/our-pledge-to-help-improve-the-accessibility-of-open-source-software-at-scale/">GitHubがグローバルアクセシビリティ啓発デー（GAAD）の誓約</a>を取り、オープンソースのアクセシビリティを大規模に改善することも注目されます。このコミットメントは重要なギャップに対処しています：企業の90%がオープンソースを使用し、コードベースの97%がオープンソースコンポーネントを含み、商業ツール内のコードの推定70〜90%がオープンソースに由来しています。

{{ figure_markup(
  image="most-accessible-javascript-meta-frameworks.png",
  caption="最もアクセシブルなJavaScriptメタフレームワーク。",
  description="平均アクセシビリティスコアでJavaScriptメタフレームワークをランキングしたバーチャート。RedwoodJSが92.38%の平均スコアでトップ、次いでAstro（89.22%）、Gatsby（88.20%）、Next.js（88.05%）、Remix（87.61%）が続く。Nuxt.js、AdonisJS、Quasar、Meteorが84.52%から79.91%のスコアでリストを締めくくる。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=208297617&format=interactive",
  sheets_gid="1977955459",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

RedwoodJSが最もアクセシブルであり、AstroとGatsbyが続いています。

## 結論

2025年のWeb Almanacアクセシビリティ分析は、重大な課題と機会の喪失によって抑制された、段階的な進歩の1年を明らかにしています。

自動テストは、規模を問わずアクセシビリティを評価するために不可欠なままです。しかし、データは<a hreflang="en" href="https://www.a11y-collective.com/blog/how-to-check-web-accessibility/">測定だけでは意味のある改善を保証しない</a>ことを示しています。ウェブコミュニティは、障害を持つ何百万ものユーザーを引き続き排除しているシステム上の問題に対処するために、基本的なコンプライアンス指標を超えなければなりません。

2025年の最も顕著な改善は、規制圧力と執行メカニズムが最も強いセクターと地域で生まれました。しかし、2025年6月28日の欧州アクセシビリティ法の期限後に劇的な改善がなかったことは示唆的です。完全な影響は2026年以降まで明らかにならないかもしれません。

`.ai` ドメインが最もアクセシブルなTLDの1つに急速に台頭したことは、重要なパターンを反映しています。新興のベンチャー支援テクノロジー企業は、最初からモダンなアクセシビリティの実践で構築する傾向があり、一方でレガシーウェブサイトはアクセシブルでないままであることが多いです。これは、開発初期に優先された場合、アクセシビリティが達成可能であることを証明しています。

特定の分野での改善にもかかわらず、2024年に特定されたコアのアクセシビリティバリアは2025年でもほとんど変わらず持続しています。

カラーコントラスト、リンクの命名、見出し階層、および画像の `alt` テキストは、ほぼすべてのプラットフォームとフレームワークで上位4つの問題として残っています。これらは、ツールの直接的な失敗ではなく、著者がそれらをどのように使用するかの問題です。W3Cの<a hreflang="en" href="https://www.w3.org/WAI/planning/arrm/tasks/">アクセシビリティの役割と責任マッピング（ARRM）</a>によると、著者はこれらすべての失敗において何らかの役割を担っています。

この現実は重要な洞察を明らかにしています。CMSプラットフォーム、JavaScriptフレームワーク、ウェブテクノロジーはアクセシビリティの基盤を提供できますが、コンテンツクリエイターにアクセシブルな選択を強制することはできません。<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/atag/">オーサリングツールアクセシビリティガイドライン（ATAG）2.0</a>や新しいW3Cの<a hreflang="en" href="https://www.w3.org/community/atag/">ATAGコミュニティグループ</a>のようなアプローチが役立つかもしれません。

2025年の指標は、段階的な改善が期待された場所での停滞を示唆しており、測定しやすいものと修正しやすいものの間のギャップを浮き彫りにしています。

アクセシビリティオーバーレイの継続的な台頭（現在はサイトの2%）は懸念されます。組織が真のアクセシビリティよりもショートカットを選ぶことが多いように見えます。IAAPと欧州障害フォーラムは、オーバーレイがユーザーの支援技術を妨げる可能性があり、アクセシブルなデザインの代替として使用してはならないと明示的に警告しています。2025年のデータは、オーバーレイが低トラフィックサイトに集中したままであることを確認しており、これは高品質でリソースが豊富な組織が真の解決策に向けてそれらから離れつつあるサインです。

2025年のデータは、自動化が必要だが不十分であることを強調しています。Lighthouseおよび類似ツールは簡単に測定可能な違反を検出しますが、ウェブ上の画像の50%は空または不十分な `alt` テキストを持っています。見出し階層は監査できますが、意味的な意味のある性質は人間の判断を必要とします。カラーコントラストは確認できますが、視覚的なデザインの選択はアクセシビリティ要件に基づいた主観的な芸術的決断を伴います。

2025年の調査結果は、障害を持つ何百万もの人々にとって依然として大部分がアクセス不可能なウェブを明らかにしています。

特定の分野での段階的な改善は励みになりますが、カラーコントラスト、リンクの命名、見出し構造、画像の説明の持続的なギャップは、ウェブコミュニティがまだアクセシビリティを真の優先事項にしていないことを示しています。

`.ai` ドメインの台頭、GitHubのオープンソースへの誓約、EUアクセシビリティ法やADA第II編の最終規則などの規制期限は、2026年にはより実質的な変化が見られるかもしれないという希望を与えています。それは、組織が測定から説明責任へ、口先だけのことからリソースへ、コンプライアンスから真のインクルージョンへと移行する場合に限ります。

ウェブはすべての人のために機能すべきです。その原則がデザイン、開発、デプロイメントの決定を導くまで、このレポートに記録されたアクセシビリティのギャップは持続し続けるでしょう。
