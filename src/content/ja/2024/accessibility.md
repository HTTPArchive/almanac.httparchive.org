---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: アクセシビリティ
description: 2024年版 Web Almanac のアクセシビリティの章では、読みやすさ、ナビゲーション、フォーム、メディア、ARIA、アクセシビリティアプリについて説明しています。
hero_alt: 青い人型のアクセシビリティアイコンを前面に付けたロボットがWebページをスキャンしており、Web Almanacのキャラクターたちがラベルをチェックしているヒーロー画像。
authors: [mgifford]
reviewers: [hidde, b_atish, katekalcevich]
analysts: [mgifford]
editors: [JonathanPagel, JonathanAvila, shantsis]
translators: [ksakae1216]
discuss:
results: https://docs.google.com/spreadsheets/d/1btB1r9QpdgTyToPhn7glcGAdMFs7eq4UcQSVIHBqiYQ/
mgifford_bio: Mike Giffordは、CivicActionsのオープンスタンダード&プラクティスリードです。彼はオープンガバメント、デジタルアクセシビリティ、持続可能性における思想的リーダーでもあります。DrupalコアアクセシビリティメンテナーやW3C招待専門家を務めており、オーサリングツールアクセシビリティの専門家として認められ、W3CのWebサステナビリティガイドライン（WSG）1.0ドラフトの貢献者でもあります。
featured_quote: 現代の多くの政府はWCAG 2.0 AAまたはWCAG 2.1 AAのいずれかにコミットしています。これらの政策の実装が等しく提供されていないことは明らかです。
featured_stat_1: 40%
featured_stat_label_1: デスクトップサイトの40%とモバイルサイトの39%が少なくとも1つの`role="presentation"`を持っています。
featured_stat_2: 0.1%
featured_stat_label_2: `<track>`要素を含む`<audio>`要素を持つサイト。
featured_stat_3: 57%
featured_stat_label_3: 適切に順序付けられた見出しのLighthouseオーディットに合格したモバイルサイト。
doi: 10.5281/zenodo.14063775
---

## はじめに

Webは変化し続けています。Siri、Alexa、Cortanaなどの音声アシスタントは、スクリーンリーダー技術を使用してWebページから読み上げることで回答を提供することがよくあります。同様の方法は<a hreflang="en" href="https://www.theverge.com/23203911/screen-readers-history-blind-henter-curran-teh-nvda">パーソナルコンピューティングの初期</a>から存在していました。キャプション（字幕と呼ばれることもある）は聴覚障害者のために作成されましたが、現在では[利便性のため](https://wikipedia.org/wiki/Subtitles#Use_by_hearing_people_for_convenience)に皆に使用されるようになっており、スマートフォンのバイブレーションモードは今や標準機能です。キャプションを楽しんで使用する他のグループには、集中力を維持するためにキャプションを使用するADHDの人々、言語理解を向上させるために依存する非ネイティブスピーカー、音声コンテンツが聞き取りにくい騒音環境にいる人々が含まれます。

現代のデバイスとプラットフォームは、アクセシビリティのための多くのオプションを提供しています。これらは、障害者だけでなく一般の人々のユーザー体験をパーソナライズするのに役立ちます。しかし、多くの人はアクセシビリティメニューを開いて試してみることはありません。

優れたアクセシビリティは、障害者だけでなく、すべての人に有益です。これは<a hreflang="en" href="https://universaldesign.ca/principles-and-goals/">ユニバーサルデザイン</a>の基本原則です。ティム・バーナーズ＝リーが述べたように：<a hreflang="en" href="https://www.w3.org/WAI/fundamentals/accessibility-intro/">"Webの力はその普遍性にあります。障害に関係なく、すべての人がアクセスできることが本質的な側面です。"</a> COVID-19パンデミックは、デジタルインターフェースのアクセシビリティの向上がもはやオプションとして認識されるべきではないことを明確にしました。仮想世界への信頼できるアクセスなしに現実世界をナビゲートすることはますます困難になっています。

<a hreflang="en" href="https://inclusive.microsoft.design/">Microsoftのインクルーシブデザインガイドライン</a>は、永続的な障害シナリオを超えて、一時的または状況的制限まで拡張しています。人間の能力は様々です。人が腕を失った（永続的）場合でも、事故のためにギプスをしている（一時的）場合でも、赤ちゃんを抱いている（状況的制限）場合でも、片手や音声操作でコンピューターや電話を使用できることは彼らに恩恵をもたらします。

{{ figure_markup(
  image="microsoft-inclusivity-gudelines.png",
  alt="Microsoftのインクルーシブデザイン図。",
  caption='Microsoftのインクルーシブデザイン図。<br>この画像とアプローチは彼らの<a hreflang="en" href="https://inclusive.microsoft.design/tools-and-activities/Inclusive101Guidebook.pdf">インクルーシブ101ガイドブック</a>の提供によるものです。',
  description="障害シナリオに焦点を当てたMicrosoftのインクルーシブデザイン図—永続的（片腕）、一時的（腕の怪我）、状況的（新しい親）。",
  width=404,
  height=658
  )
}}

世界中の政府は、デジタルアクセシビリティが道徳的義務であるだけでなく、多くの場合法的に要求されることを認識しています。アクセシビリティは商業と民主主義にも優れています。たとえば、欧州連合（EU）は、2025年6月までに、幅広い分野のWebサイトが<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Web Content Accessibility Guidelines（WCAG）</a>原則（[EN 301 549](https://wikipedia.org/wiki/EN_301_549)標準を通じて）に準拠することを義務付けています。これにより最終的に、より多くの人々がEUでサービスを売買できるようになります。他の国々も同様の法律を可決しており、組織により仮想的なオファリングをよりアクセシブルにするよう圧力を高めています。

EN 301 549や<a hreflang="en" href="https://www.section508.gov/manage/laws-and-policies/">Section 508</a>などの立法で参照される標準は、Web Content Accessibility Guidelinesに基づいており、このレポートで使用される自動アクセシビリティテストはガイドラインの一部に対してのみテストできます。私たちのテストは、オープンソースツールである<a href="https://developer.chrome.com/docs/lighthouse/accessibility/scoring">Google Lighthouse</a>を活用しており、これは<a hreflang="en" href="https://github.com/dequelabs/axe-core">Dequeのオープンソースaxe-core</a>を使用しています。

[過去のレポート](../2022/accessibility)には更新された多くの情報があります。時間の経過とともに変化を追跡し、変化が起こる場所を記録することは有用です。私たちはまた、異なる分野とWebアクセシビリティについての新しいセクションを紹介したいと思いました。私たちの分析を通じて、CMS、JavaScriptフレームワークを追跡し、異なる技術の平均アクセシビリティを評価できます。異なる国と政府のアクセシビリティを比較し、時間の経過とともにそれがどのように変化するかを追跡することもできます。

継続的な課題にもかかわらず、Webアクセシビリティには顕著な改善が見られました。Lighthouseアクセシビリティオーディットのメジアンスコアは、過去2年間で84%に上昇しました。WCAG 2.2では、4.1.1成功基準が削除されました。<a hreflang="en" href="https://www.deque.com/blog/wcag-2-2-removes-4-1-1-parsing-and-how-axe-core-is-impacted/?_gl=1*1yzu5tn*_up*MQ..*_ga*MTY0NDE2MjY4LjE3MjY3NTI0NTg.*_ga_C9H6VN9QY1*MTcyNjc1MjQ1Ny4xLjAuMTcyNjc1MjQ1Ny4wLjAuMA..">したがって、Dequeはaxeから<code>duplicate-id</code>と<code>duplicate-id-active</code>オーディットを削除しました</a>ので、これは私たちのスキャンにもう含まれていませんでした。これらの非推奨のaxeルールは、2022年のレポートで調査された数百万のサイトに影響を与えました。また、<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/">2.2で追加された新しい成功基準</a>もあり、対応するテストが<a hreflang="en" href="https://www.deque.com/blog/axe-core-4-5-first-wcag-2-2-support-and-more/">axe-coreに追加されました</a>。

アクセシビリティスコアは重要なツールですが、[グッドハートの法則](https://wikipedia.org/wiki/Goodhart%27s_law)に精通している人は、測定がターゲットになることの危険性を知っているでしょう。自動テストは<a hreflang="en" href="https://www.smashingmagazine.com/2022/11/automated-test-results-improve-accessibility/#automate-it">WCAG成功基準の一部のみに対処できる</a>ことも認めなければなりません。また、<a hreflang="en" href="https://www.matuzo.at/blog/building-the-most-inaccessible-site-possible-with-a-perfect-lighthouse-score">完璧なスコアがアクセシブルなサイトを保証するものではない</a>ことも認めなければなりません。

{{ figure_markup(
  image="lighthouse-audit-median-score-yoy.png",
  caption="年毎のLighthouseオーディット改善。",
  description="5年間にわたるアクセシビリティの平均的な向上を示す棒グラフで、メジアンGoogle Lighthouseスコアのアクセシビリティです。値は年々徐々に増加しており、次のとおりです：2019年（83%）、2020年（80%）、2021年（82%）、2022年（83%）、2024年（84%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=837866368&format=interactive",
  sheets_gid="255848343",
  sql_file="lighthouse_a11y_score.sql"
  )
}}

同様に、評価されたページの割合が増加したページランクごとのメジアンLighthouseスコアの増加も見ることができます。これは2020年から2021年の間ほどの改善ではなく、2023年のWeb Almanacは作成されなかったため、2年間で1%の増加です。しかし、Lighthouseスコアはaxeを活用しており、<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/">WCAG 2.2</a>により合致するようにテストを増やしていることも注目に値します。

もっとも改善されたLighthouseテストを使用してもっとも一般的なエラーを見ると、Lighthouseオーディットのどの部分がもっとも改善されたかを確認できます。完璧からは程遠いものの、前進が見られます。

{{ figure_markup(
  image="lighthouse-audit-markup-improvements.png",
  caption="もっとも改善されたLighthouseアクセシビリティテスト（axe）。",
  description="2022年と2024年の5つの特定のLighthouseオーディットに合格するサイト数を示す棒グラフ。`aria-allowed-attr`は2022年にサイトの82%、2024年に95%で合格。`aria-input-field-name`は2022年にサイトの14%、2024年に21%で合格。`aria-progressbar-name`は2022年にサイトの3%、2024年に14%で合格。`color-contrast`は2022年にサイトの23%、2024年に29%で合格。`frame-title`は2022年にサイトの36%、2024年に51%で合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=899104036&format=interactive",
  sheets_gid="1279863228",
  sql_file="lighthouse_a11y_audits.sql"
  )
}}

Google Lighthouseには現在、スコアリングに使用される<a href="https://developer.chrome.com/docs/lighthouse/accessibility/scoring">57の異なるオーディットテスト</a>が含まれています。これらはすべて、さまざまなアクセシビリティ製品やサービスで広く採用されているDequeの<a hreflang="en" href="https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md">オープンソースaxe-core</a>に基づいています。7つのオーディット（`aria-meter-name`、`aria-toggle-field-name`、`aria-tooltip-name`、`document-title`、`duplicate-id-active`、`html-lang-valid`、`object-alt`）を除いて、全体的に改善が見られました。`object-alt`と`aria-tooltip-name`の両方が2022年の改善で言及されましたが、残念ながらこの改善は2024年には繰り返されませんでした。

この章を通じて、読者が自分のアクセシビリティイニシアティブで適用し、フォローできる実用的なリンクとソリューションを含めました。一貫性のため、「障害者」というアイデンティティファーストの用語も広く使用されていることを認識していますが、章全体を通じて人中心言語の「障害を持つ人々」を使用することにしました。私たちの用語選択は、どちらの用語がより適切かを示唆することを意図したものではありません。

## 読みやすさ

Webでの情報やコンテンツの読みやすさは重要です。Webサイトのコンテンツの読みやすさに貢献するさまざまな要因があります。これらの側面を考慮することで、インターネット上のすべての人がコンテンツを簡単に消費できるようになります。このレポートでは測定可能なもの内容をカバーしており、平易な言語は読みやすさにとって重要ですが、測定するのは簡単ではありません。[Flesch–Kincaid](https://wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests)のような比較的単純な数学的読みやすさスコアがあります。一部の人々はそれを英語の[読みやすさを決定する](https://wikipedia.org/wiki/Readability)ために使用していますが、Webはグローバルです。言語は難しく、もっとも人気のある言語間でも適用できる自動平易言語テストについて合意された標準はありません。

### カラーコントラスト

カラーコントラストとは、ユーザーがコンテンツを見ることができるように、ページの要素の前景色と背景色の違いを指します。WCAGがコントラストガイドラインに準拠する方法を非常に明確にしているにもかかわらず、Webサイトがテキストやアイコンなどの重要な要素で不十分なコントラストを持つことは非常に一般的です。

通常サイズのテキスト（24pxまで、または太字の場合は18px）についてWCAGで定義された<a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum">最小コントラスト要件</a>は、AA適合性では4.5:1、AAA適合性では7:1です。ただし、より大きなフォントサイズの場合、より低いコントラストでも大きなテキストは読みやすさが向上するため、コントラスト要件は3:1のみです。

Google Lighthouseは、ほとんどのカラーコントラスト問題を簡単にテストできますが、すべてではありません。誰もがワークフローに簡単に組み込むことができる<a hreflang="en" href="https://accessibility.civicactions.com/guide/tools#color">色の組み合わせをチェックするためのオープンソースツール</a>が幅広くあります。一般的なコントラスト感度を持っている場合、十分なコントラストの自分の認識に依存することはできないため、これらのツールの使用が必要であることに注意することが重要です。

Lighthouseテストでは、モバイルサイトの29%とデスクトップサイトの28%が十分なテキストのカラーコントラストを持っていることが判明しました。これは過去数年間と比較して中程度の改善ですが、基本的な読みやすさに必要なレベルをまだはるかに下回っています。

{{ figure_markup(
  image="color-contrast-2019-2020-2021-2022-2024.png",
  caption="十分なカラーコントラストを持つサイト。",
  description="カラーコントラストの段階的な進歩を示す棒グラフ。2019年にモバイルサイトの22%が十分なカラーコントラストを持っていたものが、2020年に21%にわずかに下がり、2020年にやや22%に増加し、2022年により多く23%に増加、2024年はモバイルで29%への大きなジャンプを見ました。2022年のデスクトップサイトは23%で、2024年には28%に上昇しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=476448992&format=interactive",
  sheets_gid="985048008",
  sql_file="color_contrast.sql"
  )
}}

カラーコントラストは<a hreflang="en" href="https://www.nia.nih.gov/health/vision-and-vision-loss/aging-and-your-eyes">年齢を重ねるにつれてより重要</a>になります。また、人々が眼鏡を持っていない場合や屋外でコンテンツを読む必要がある場合など、<a hreflang="en" href="https://inclusive.microsoft.design/">一時的な障害や状況的制限</a>にとって定期的に問題となるものでもあります。ブラウザーやオペレーティングシステムがライト、ダーク、ハイコントラストモードのサポートを実装しているため、適切なコントラストを達成することはより困難になっています。これらはブラウザーやオペレーティングシステムによってよくサポートされていますが、まだほとんどのWebサイトではよくサポートされていません。サイトがユーザーの設定した好みに従うことへの需要が高まっており、複数のタイプの障害がユーザーにこのコントロールを与えることから恩恵を受けることができます。詳細については、以下のユーザー設定セクションを参照してください。

### ズームとスケーリング

これまで以上に、ユーザーは超ワイドな曲面スクリーンからモバイルフォン、さらには時計まで、さまざまな技術でWebサイトと関わっています。スケーリングを無効にすることは、何が自分にとって最適に機能するかを定義するユーザーエージェンシーを奪います。<a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/resize-text">WCAGでは</a>、Webサイトのテキストは、コンテンツや機能の損失なしに少なくとも200%まで拡大できる必要があると要求しています。

多くの人々がズーム機能を無効にする理由を完全に理解していないため、ズーム機能を無効にしないことの重要性を強調するために、2022年に以前にハイライトした<a hreflang="en" href="https://adrianroselli.com/2015/10/dont-disable-zoom.html">Adrian Roselliの投稿</a>を再訪しています。

{{ figure_markup(
  image="pages-zooming-scaling-disabled.png",
  caption="ズームとスケーリングが無効なページ。",
  description="デスクトップとモバイルの無効なズームに関するデータを示す棒グラフ。デスクトップサイトの14%とモバイルサイトの16%がスケーリングを無効にし、それぞれ18%と20%が最大スケールを1に設定し、20%と23%がいずれかを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1480116719&format=interactive",
  sheets_gid="1937244738",
  sql_file="viewport_zoom_scale.sql"
  )
}}

ズームとスケーリングを無効にしているサイトの減少が見られることを嬉しく思います。2022年のモバイルユーザーのデータと比較すると、スケーリングを無効にしたサイトが2%少なく、最大スケール1を無効にしたサイトが4%少なくなっています。デスクトップの平均は、前回のレポートと比較して両方とも2%下がりました。ユーザーはブラウザーを設定してこの設定をオーバーライドできますが、一部のデフォルトは依然として作成者の好みを尊重します。

サイトがズームを無効または制限しているかを確認するには、ページのソースを確認し、`<meta name="viewport">`を検索します。maximum-scale、minimum-scale、user-scalable=no、またはuser-scalable=0でタグ付けされている場合。理想的には、コンテンツのサイズ変更に制限はないはずですが、WCAGは<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-scale.html#:~:text=Content%20satisfies%20the%20Success%20Criterion%20if%20it%20can,more%20extreme%2C%20adaptive%20layouts%20may%20introduce%20usability%20problems.">200%拡大</a>の必要性のみを指定しています。

{{ figure_markup(
  image="font-unit-usage.png",
  caption="フォント単位の使用。",
  description="pxがデスクトップページの65%とモバイルページの66%でフォントサイズに使用されていることを示す棒グラフ。emは両方で9%。remは両方で4%、%はデスクトップで4%、モバイルで5%、`<number>`は両方で2%、最後にptはデスクトップで15%、モバイルで14%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=655410508&format=interactive",
  sheets_gid="806505055",
  sql_file="units_properties.sql"
  )
}}

フォントサイズの定義方法も読みやすさに影響し、ピクセルは他の単位ほど柔軟ではありません。ピクセル（px）の使用はデスクトップで65%、モバイルで66%です。emの使用は2022年の6%から9%に増加しました。remは2022年には6%でしたが、現在は4%に減少しています。2022年以降、emやremの使用に大幅な増加はありませんが、ユーザーがブラウザー設定でフォントサイズを増減する場合、しばしば<a hreflang="en" href="https://www.freecodecamp.org/news/css-units-when-to-use-each-one/">ユーザーにより良い体験を提供</a>します。

### 言語識別

lang属性で言語を識別することは、スクリーンリーダーのサポートを向上させ、自動ブラウザー翻訳を促進します。この機能はすべてのユーザーに恩恵をもたらします。たとえば、lang属性がない場合、Chromeの自動翻訳機能は不正確な翻訳を生成する可能性があります。Manuel Matuzovićは、<a hreflang="en" href="https://www.matuzo.at/blog/lang-attribute/">不足しているlang属性が翻訳エラーにつながる可能性</a>の例を提供しています。lang属性は、Chen Hui-Jingが指摘するように、<a hreflang="en" href="https://chenhuijing.com/blog/css-for-i18n/">異なる言語と読み方向のWebページをスタイリング</a>する際にも役立ちます。

{{ figure_markup(
  caption="モバイルサイトで有効なlang属性を持つ。",
  content="86%",
  classes="big-number",
  sheets_gid="559595084",
  sql_file="valid_html_lang.sql"
)
}}

2022年には、モバイルWebサイトの83%がlang属性を含んでいましたが、2年後には86%になっているのは有望です。ただし、これはWCAGの下でレベルA適合性の問題であるため、まだ改善の余地があります。この基準を満たすには、lang属性を認識された<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/act/rules/bf051a/#known-primary-language-tag">プライマリ言語タグ</a>とともに`<html>`タグに追加する必要があります。言語を適切に定義することは重要です。テンプレートが新しいWebサイトを作成するためにコピーされる場合、コンテンツの言語とコードの言語属性（lang="en"）の間に不一致が生じることがあります。

また、ページ言語がありますが、ページには多くの場合複数の言語が含まれていることを覚えておいてください。ページに複数の言語が含まれている場合、lang属性を他のタグにも適用できます。W3Cには<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/language-of-parts.html">言語の部分への対処方法</a>についての良いドキュメントがあります。

### ユーザー設定

現代のCSSには<a hreflang="en" href="https://www.w3.org/TR/mediaqueries-5">レベル5メディアクエリ</a>が含まれており、これには<a hreflang="en" href="https://12daysofweb.dev/2021/preference-queries/">ユーザー設定メディアクエリ</a>が含まれます。ユーザー設定メディアクエリは、ユーザーが自分に合った設定を選択できるようにすることで、アクセシビリティを向上させます。これには、ダークモードなどの個人の好みに合ったカラースキームやコントラストモードの選択が含まれます。ユーザーは、前庭障害のあるユーザーに有益な、ページのアニメーションを最小化することも選択できます。

{{ figure_markup(
  image="userpreference-media-queries.png",
  caption="ユーザー設定メディアクエリ。",
  description="デスクトップサイトの49%とモバイルサイトの50%が`prefers-reduced-motion`メディアクエリを使用し、12%のサイトが`prefers-color-scheme`を使用し、`prefers-contrast`はデスクトップとモバイルサイトの1%未満で使用されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=570596768&format=interactive",
  sheets_gid="1665700473",
  sql_file="media_query_features.sql"
  )
}}

モバイルサイトの50%以上が`prefers-reduced-motion`メディアクエリを含んでいることがわかりました。これは2022年の34%から増加しています。これは重要です。なぜなら、<a hreflang="en" href="https://kb.iu.edu/d/bizw">デジタルアニメーションは前庭障害のある人に害を与える可能性</a>があるからです。このクエリを使用することで、そのようなアニメーションを適応または削除してアクセシビリティを向上させることができます。Mozillaの開発者コミュニティには、[モーションセンシティブなサイトの構築](https://developer.mozilla.org/ja/docs/Web/CSS/@media/prefers-reduced-motion)に関する優れたリソースがあります。

[サステナビリティ](./sustainability)の章には、アニメーションの使用の増加とデジタルサステナビリティへの影響について素晴らしい統計があります。

コントラストについては、デスクトップとモバイルWebサイトの12%のみが`prefers-color-scheme`メディアクエリを利用しており、これは2022年の8%から増加しています。コンテンツの読みやすさを向上させるために、ユーザーが表示モードを調整できるようにすることは良い慣行です。prefers-color-schemeクエリは、ブラウザーがユーザーの好みのカラースキームを検出し、ライトモードとダークモードをサポートできるようにします。`prefers-contrast`クエリは、ハイコントラストモードを有効にすることで、視力の低いユーザーや光過敏症のユーザーにとって価値があります。

<a href="https://developer.mozilla.org/ja/docs/Web/CSS/@media/forced-colors"><code>forced-contrast</code></a>のサポートは、2024年にデスクトップで約4%増加して14%になりました。強制色モードは、色のコントラストの向上を通じてテキストの読みやすさを向上させるために設計されたアクセシビリティ機能です。有効になると、ユーザーのオペレーティングシステムがほとんどの色関連のスタイルを制御し、Webサイトの色設定をオーバーライドします。このモードは、より予測可能なテキストと背景のコントラストを確保するために、背景画像などの一般的なパターンを無効にします。

もっともよく知られた実装は、現在<a hreflang="en" href="https://support.microsoft.com/en-us/topic/fedc744c-90ac-69df-aed5-c8a90125e696">コントラストテーマ</a>と呼ばれるWindowsのハイコントラストモードです。これらのテーマは、低コントラストと高コントラストのオプションを持つ代替カラーパレットを提供し、ユーザーがシステムカラーを好みに合わせてカスタマイズできるようにします。`-ms-high-contrast`の使用は2024年にわずかに減少し、約23%になりました。これは<a hreflang="en" href="https://blogs.windows.com/msedgedev/2024/04/29/deprecating-ms-high-contrast/">Edge</a>や[Chrome](https://developer.chrome.com/docs/devtools/rendering/emulate-css/)でエミュレートできるため、テストが簡単になりました。

## ナビゲーション

Webサイトのナビゲーションについて話すとき、ユーザーがさまざまな方法と入力デバイスを使用する可能性があることを認識することが重要です。マウスを使ってスクロールする人もいれば、キーボード、スイッチコントロールデバイス、またはスクリーンリーダーを使って見出しを通ってナビゲートする人もいます。Webサイトを設計するとき、使用するデバイスや支援技術に関係なく、すべてのユーザーにとって効果的に機能することを確保することが重要です。ワイドスクリーンテレビと音声インターフェース（SiriやAmazon Alexaなど）の両方が、ナビゲーションの設計方法に課題をもたらします。サイトに優れたセマンティック構造を構築することは、スクリーンリーダーユーザーがサイトをナビゲートするのに役立ちますが、他の多くのタイプの技術のユーザーにも役立ちます。

### フォーカス表示

フォーカス表示は、主にキーボードやその他の代替ナビゲーションデバイスを使ってWebサイトをナビゲートするユーザーにとって重要です。WebAimには、<a hreflang="en" href="https://webaim.org/articles/motor/assistive">運動能力が限られた人のための支援技術</a>について優れたリソースがあります。これらのデバイスは、制御できるものを最大化するためにユーザーによってカスタマイズされています。これらのデバイスでは、可視的なフォーカススタイルとフォーカス順序の管理方法に多くの類似点がありますが、キーボードのみのユーザーとは異なる場合があります。

ほとんどの自動テストは、フォーカス順序やキーボードトラップをテストしません。Lighthouseは、サイトがキーボードナビゲーション可能であることを伝えることはできません。それができることは、サイトがキーボードナビゲーション可能でない場合に、必要不可欠ないくつかの基本的なテストに失敗したことを伝えることだけです。Lighthouseは、<a hreflang="en" href="https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md">Equesのaxeルール</a>を使用してベストプラクティスを評価しています。フォーカス表示で完璧なスコアを持っていても、ページを手動でテストする必要があります。Lighthouseは以下をテストすることを推奨しています：

- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focus-traps">フォーカストラップ</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focusable-controls">インタラクティブコントロールがキーボードフォーカス可能</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/logical-tab-order">論理的なタブ順序</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/managed-focus">ページの新しいコンテンツに向けられたフォーカス</a>

<a hreflang="en" href="https://accessibilityinsights.io/docs/web/overview/">Accessibility Insights</a>は、Dequeのaxeを活用する優れたオープンソースツールです。この<a hreflang="en" href="https://accessibilityinsights.io/downloads/">Chrome/Edge拡張機能</a>は、キーボードのみのテストを支援し、開発者が他のテストを通じてガイドできます。Tab Stops機能は、キーボードのみのユーザーがWebサイトを通じて進歩する優れた視覚的指標です。

### フォーカススタイル

WCAGは、ページを移動する際に現在フォーカスされている要素をユーザーが識別できるようにするため、すべてのインタラクティブコンテンツに可視的なフォーカスインジケータを義務付けています。

{{ figure_markup(
  image="pages-overriding-focus-styles.png",
  caption="ブラウザーフォーカススタイルをオーバーライドするページ。",
  description="Webサイトの82%が:focus疑似クラスを使用し、:focus疑似クラスを使用するサイトの53%がアウトラインを0またはnoneに設定していることを示す棒グラフ。デスクトップサイトの14%とモバイルサイトの12%が:focus-visible疑似クラスを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1264001671&format=interactive",
  sheets_gid="1799906695",
  sql_file="focus_outline_0.sql"
  )
}}

Webサイトの53%が`:focus {outline: 0}`を適用していることがわかりました（2022年には86%でした）。これは、フォーカスされたインタラクティブ要素のブラウザーが提供するデフォルトのアウトラインを削除します。一部のWebサイトはこれをオーバーライドするためにカスタムスタイルを実装していますが、必ずしもそうではなく、ユーザーが現在フォーカスされている要素を識別するのが困難になり、ナビゲーションを妨げます。Sara Soueidanは<a hreflang="en" href="https://www.sarasoueidan.com/blog/focus-indicators/">WCAG準拠のフォーカスインジケータの設計</a>について貴重なガイダンスを提供しています。ポジティブな点として、Webサイトの12%が現在:focus-visibleを使用しており（2022年の9%、2021年の0.6%から増加）、これはフォーカスインジケータを表示するタイミングを決定するためにブラウザーヒューリスティクスを使用する疑似クラスです。これは、アクセシビリティプラクティスの大幅な改善です。

### `tabindex`

一般的に、HTMLはtabindexを設定しなくてもフォーカス順序が設定されます。CSSとJavaScriptは、DOMでの表示方法に変更を引き起こすことがよくあります。tabindex属性は、要素がフォーカスを受け取ることができるかどうかを制御し、キーボードフォーカスまたは"tab"順序での位置を決定します。

分析によると、モバイルWebサイトの63%とデスクトップWebサイトの64%がtabindexを利用しています（それぞれ60%と62%から増加）。この属性は、アクセシビリティに影響を与える可能性があるいくつかの目的に役立ちます：

- `tabindex="0"`は、要素をシーケンシャルキーボードフォーカス順序に配置します。カスタムインタラクティブ要素とウィジェットは、フォーカスシーケンスに含まれることを確保するために`tabindex="0"`を持つ必要があります。
- `tabindex="-1"`は、キーボードフォーカス順序から要素を削除しますが、JavaScriptを介してプログラマティックにフォーカスできるようにします。
- 正のtabindex値は、デフォルトのキーボードフォーカス順序をオーバーライドし、しばしば<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-order.html">WCAG 2.4.3 - フォーカス順序</a>の問題につながります。

非インタラクティブ要素をキーボードフォーカス順序に配置することは避けることが重要です。これは、見ることができるスクリーンリーダーユーザーや代替ナビゲーションユーザーにとって混乱を招く可能性があります。

{{ figure_markup(
  image="tabindex-usage-and-values.png",
  caption="tabindexの使用。",
  description="tabindexを使用するページのうち、tabindex 0がデスクトップではそれらのページの49%、モバイルではそれらのページの47%で使用され、負のtabindexはデスクトップで48%、モバイルで47%で使用され、最後に正のtabindexは調査されたすべてのサイトの4%で使用されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1092084835&format=interactive",
  sheets_gid="2010133634",
  sql_file="tabindex_usage_and_values.sql"
  )
}}

tabindex属性を使用するすべてのWebサイトのうち、4%が正の値を使用しています（2022年の7%から減少）。正のtabindex値を使用することは、自然なタブ順序を破壊するため、一般的に悪い慣行と考えられています。Karl Grovesは<a hreflang="en" href="https://karlgroves.com/2018/11/13/why-using-tabindex-values-greater-than-0-is-bad">このトピックについて洞察的な記事</a>を提供しています。

### ランドマーク

ランドマークは、Webページを異なるテーマ領域に構造化するのに役立ち、支援技術のユーザーがより簡単にナビゲートできるようにします。たとえば、<a hreflang="en" href="https://www.afb.org/blindness-and-low-vision/using-technology/cell-phones-tablets-mobile/apple-ios-iphone-and-ipad-2">ローターメニュー</a>は異なるページランドマーク間をナビゲートするのに役立ち、<a hreflang="en" href="https://webaim.org/techniques/skipnav/">スキップリンク</a>は`<main>`などの特定のランドマークにユーザーを誘導できます。ランドマークは、さまざまなHTML5要素を使用して定義できます。このセマンティック構造は、Web Accessibility Initiative – Accessible Rich Internet Applications（ARIA）の<a hreflang="en" href="https://www.w3.org/TR/WCAG20-TECHS/ARIA11.html">ランドマークロール</a>でも適用できます。ただし、<a hreflang="en" href="https://www.a11y-collective.com/blog/the-first-rule-for-using-aria/">ARIAの第一のルール</a>に従って、可能な限りネイティブHTML5要素を使用することが最良です。

ARIAランドマークは伝統的にスクリーンリーダーユーザーにのみ表示されていましたが、一部のサイトでは、見出しとランドマークをページ固有の目次に集約するこの<a hreflang="en" href="https://github.com/paypal/skipto">オープンソースSkipToスクリプト</a>などのツールを使用し始めています。ドキュメント構造をユーザーに公開することは、すべての人の理解を助けます。SkipToは、本来基本的なブラウザー機能であるべきものを提供します。これは、後のセクションで議論されるスキップリンクを超えるものです。

<figure>
  <table>
    <thead>
      <tr>
        <th>要素タイプ</th>
        <th>% 要素</th>
        <th>% ロール</th>
        <th>% 両方</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>main</code></td>
        <td class="numeric">37%</td>
        <td class="numeric">17%</td>
        <td class="numeric">44%</td>
      </tr>
      <tr>
        <td><code>header</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">12%</td>
        <td class="numeric">66%</td>
      </tr>
      <tr>
        <td><code>nav</code></td>
        <td class="numeric">66%</td>
        <td class="numeric">19%</td>
        <td class="numeric">70%</td>
      </tr>
      <tr>
        <td><code>footer</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">10%</td>
        <td class="numeric">67%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ランドマーク要素と`role`の使用（デスクトップ）。",
      sheets_gid="1224962143",
      sql_file="landmark_elements_and_roles.sql",
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="pages-with-element-role-yty.png",
  caption="要素ロールを持つページの年間成長。",
  description="上記の表で特定されたロールを持つ線グラフ。footer、header、nav要素の段階的な成長と、mainロールの使用の約9%の増加があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1090856027&format=interactive",
  sheets_gid="1224962143",
  sql_file="landmark_elements_and_roles.sql"
  )
}}

ほとんどのWebページでもっとも一般的に期待されるランドマークには、`<main>`、`<header>`、`<nav>`、`<footer>`が含まれます。私たちの調査結果は以下のことを明らかにしています：
- すべてのページの37%のみがネイティブHTML `<main>`要素を使用している
- すべてのページの17%が`role="main"`を持つ要素を持っている
- 43%がそれらのいずれかを使用している（2021年の35%から増加）

Scott O'Haraの<a hreflang="en" href="https://www.scottohara.me/blog/2018/03/03/landmarks.html">ランドマークに関する記事</a>は、アクセシビリティを向上させるための貴重な洞察を提供しています。

### 見出し階層

見出しは、支援技術を使用する人々を含むすべてのユーザーにとって、Webサイトをナビゲートするのに役立つため重要です。支援技術は、ユーザーが興味のある特定のセクションにジャンプできるようにします。Marcy Suttonの<a hreflang="en" href="https://marcysutton.com/how-i-audit-a-website-for-accessibility#Headings-and-Semantic-Structure">見出しとセマンティック構造に関する記事</a>で強調されているように、見出しは目次のように機能し、ユーザーと検索エンジンが特定のコンテンツ領域に効率的にナビゲートできるようにします。

残念ながら、見出し階層は過去2年間で悪化しています。Lighthouseは適切に順序付けられた見出しを追跡し、1%をわずかに上回る下落をしました：

{{ figure_markup(
  caption="適切に順序付けられた見出しのLighthouseオーディットに合格したモバイルサイト。",
  content="57%",
  classes="big-number",
  sheets_gid="1279863228",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

見出しレベルは異なるフォントサイズと関連付けられており、コンテンツを構造化するのではなく、Webサイトを視覚的にスタイルするために頻繁に誤用されています。この誤用は、ユーザー体験とアクセシビリティツール、そして検索エンジンの両方に悪影響を与えます。CSSは要素をスタイルするために使用すべきであり、見出しタグではありません。

WCAGは、<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/multiple-ways.html">成功基準2.4.5：複数の方法</a>で概説されているように、ヘッダーのプライマリメニューを超えて複数のナビゲーションオプションをWebサイトが提供することを義務付けています。たとえば、認知障害を持つ人を含む多くのユーザーは、大きなWebサイトでページを見つけるために検索機能を好みます。

現在、モバイルWebサイトの21%とデスクトップWebサイトの22%が検索入力を含んでいます（それぞれ2022年の23%と24%から減少）。これは良いトレンドではありません。

### スキップリンク

スキップリンクは、キーボード、スイッチコントロールデバイス、またはその他の代替ナビゲーションツールに依存するユーザーが、フォーカス可能な要素をすべてナビゲートすることなく、Webページのさまざまなセクションをバイパスできるようにします。一般的な使用は、プライマリナビゲーションをスキップして`<main>`コンテンツに直接移動することです。とくに、広範囲なインタラクティブナビゲーションメニューを持つサイトでは、これは一部のユーザーにとってユーザー体験を劇的に改善できます。

{{ figure_markup(
  caption="スキップリンクを特徴とする可能性のあるモバイルとデスクトップページ。",
  content="24%",
  classes="big-number",
  sheets_gid="756398875",
  sql_file="skip_links.sql"
)
}}

デスクトップとモバイルページの24%がスキップリンクを含んでいる可能性があることがわかりました。これにより、ユーザーはページの不要な部分を避けることができます。私たちの分析は、ページの上部付近に配置されたスキップリンク（ナビゲーションをバイパスするものなど）のみを検出するため、この割合は実際にはより高い可能性があります。スキップリンクは、上記のSkipToスクリプトで説明したように、ページの他のセクションをスキップするためにも使用できます。

### ドキュメントタイトル

説明的なページタイトルは、ページ、タブ、ウィンドウ間をナビゲートするために重要です。スクリーンリーダーなどの支援技術は、これらのタイトルを声に出して読み、ユーザーが自分の場所を把握するのに役立ちます。

{{ figure_markup(
  image="page_title-information.png",
  caption="タイトル要素の統計。",
  description="デスクトップとモバイルサイトの97%が`<title>`要素を使用し、それらのタイトルの69%が4つ以上の単語を持ち、デスクトップの7%とモバイルの6%のタイトルがレンダリング時に変更されることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1921322394&format=interactive",
  sheets_gid="1803785019",
  sql_file="page_title.sql"
  )
}}

モバイルWebサイトの97%がドキュメントタイトルを含んでいますが、4つ以上の単語を持つタイトルを持っているのは69%のみです。私たちの分析は、ホームページと2次ページに限定されているため、内部ページについての洞察は限られています。2次ページは、4つ以上の単語の説明的なタイトルを持つ可能性が8%高いことがわかりました（2024年の平均で78%）。理想的には、タイトルには、ナビゲーションを向上させるためのページのコンテンツの簡潔な説明とWebサイトの名前の両方が含まれるべきです。

レンダリング時に変更されたタイトル値は、初期HTMLタイトルとJavaScriptが読み込まれた後のページの最終値の比較から導出されます。データは、スキャンされたデスクトップサイトの7%がタイトルのコンテンツを動的に変更していることを示しています。2次ページは、ホームページよりもタイトルを変更する可能性がわずかに低くなっています。

### テーブル

テーブルは、2つの次元を使用してデータと関係を提示します。アクセシビリティのために、テーブルは、支援技術を使用するユーザーがデータを理解してナビゲートするのに役立つために、キャプションやヘッダーセルなどの要素を持つよく構造化された形式が必要です。`<caption>`要素を使用するキャプションは、スクリーンリーダーのコンテキストを提供するためとくに重要です。現在、デスクトップサイトの1.6%が`<caption>`を使用しており（2022年の1.3から微増）、これはテーブルをよりアクセシブルにするための重要な側面です。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan=2>テーブルサイト</th>
        <th scope="colgroup" colspan=2>すべてのサイト</th>
      </tr>
      <tr>
        <td></td>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">キャプション付きテーブル</th>
        <td class="numeric">5.5%</td>
        <td class="numeric">4.8%</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <th scope="row">プレゼンテーションテーブル</th>
        <td class="numeric">4.4%</td>
        <td class="numeric">5.0%</td>
        <td class="numeric">3.1%</td>
        <td class="numeric">4.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="テーブルの使用。",
      sheets_gid="1512848123",
      sql_file="table_stats.sql",
    ) }}
  </figcaption>
</figure>

CSS FlexboxとGridのおかげで、テーブルをページレイアウトに使用する必要はありません。必要に応じて、テーブルは`role="presentation"`を使用してセマンティクスを明示的に削除し、レイアウトの目的で使用されるときの混乱を避けることができます。モバイルテーブルの4%がこの回避策を使用していることがわかります（2022年の1%と比較）。

## フォーム

フォームは、ログインや購入などのユーザーインタラクションに不可欠です。障害を持つユーザーにとって、アクセシブルなフォームは、タスクを完了し、同等の機能を実現するために重要です。フォームは、静的なHTMLページよりも開発者が構築するのがはるかに複雑であることも多いです。

### `<label>` 要素

`<label>`要素は、[入力フィールドをアクセシブルな名前とリンクする](https://developer.mozilla.org/ja/docs/Learn/Forms/Basic_native_form_controls)ための推奨される方法です。for属性を使用して入力のidとマッチさせることで、適切なプログラム的関連付けが保証され、フォームの使いやすさが向上します。さらに、label要素が適切に使用されると、ユーザーはラベルをクリックまたはタップしてフォームフィールドにフォーカスできます。

たとえば：

```
<label for="emailaddress">メール</label>
<input type="email" id="emailaddress">
```

{{ figure_markup(
  image="form-input-name-sources.png",
  caption="入力のアクセシブルな名前の取得元。",
  description="label要素のアクセシブルな名前のソースを示す棒グラフ。サイトの27%がアクセシブルな名前を持たない。32%が`label`要素からアクセシブルな名前を取得。デスクトップ入力の24%とモバイルの25%が`placeholder`属性からアクセシブルな名前を取得。`aria-label`が9%を担当。`value`属性が3%を貢献。`title`属性がデスクトップの3%とモバイルの2%の調査サイトに貢献。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=2076905999&format=interactive",
  sheets_gid="1902508631",
  sql_file="form_input_name_sources.sql"
  )
}}

残念ながら、モバイル入力の13%がアクセシブルな名前を欠いています（2022年の38%から大幅に改善）。モバイルサイトの15%のみが`<label>`を使用しており（2022年の19%から減少）、これはスクリーンリーダーや音声テキストツールに依存するユーザーを妨げる可能性があります。アクセシブルな名前は常に使用する必要があり、サイトは、アクセシブルな名前が入力の表示ラベルと一致することを確保することで、スクリーンリーダーを超えた支援技術をサポートする必要があります。WCAG 2.1は、音声コントロールなどの技術がより良くサポートされることを確保するために、2.5.3 Label in Name（レベルA）を追加しました。`aria-label`と`aria-labelledby`の使用は、HTML `<label>`が使用できない場合にのみ使用する必要があります。

### `placeholder` 属性

`placeholder`属性は、入力形式の例を提供します。アクセシブルな名前を提供する方法として`<label>`を置き換えるべきではありません。プレースホルダーが表示ラベルを提供する唯一の方法である場合、ユーザーが入力を開始するとその参照点が消えます。<a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">ブラウザーがデフォルトでプレースホルダーテキストにWCAGを満たすのに十分なコントラストを提供しない</a>ことは新しい懸念ではありません。さらに、それらは<a hreflang="en" href="https://www.digitala11y.com/anatomy-of-accessible-forms-placeholder-is-a-mirage/">常にスクリーンリーダーでサポートされているわけではありません</a>。より良い解決策は、入力の下または横に入力形式の例を表示し、aria-describedbyを使用してプログラム的に入力に接続することです。

{{ figure_markup(
  image="placeholder-but-no-label.png",
  caption="入力でのプレースホルダーの使用。",
  description="デスクトップサイトの55%とモバイルサイトの54%がプレースホルダーを使用していることを示す棒グラフ。デスクトップサイトの59%とモバイルサイトの61%がラベルのない入力を持っている。デスクトップサイトの55%とモバイルサイトの57%がプレースホルダーとラベルのない入力の両方を持っている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=186177069&format=interactive",
  sheets_gid="615941327",
  sql_file="placeholder_but_no_label.sql"
  )
}}

モバイルサイトの57%とデスクトップサイトの55%がプレースホルダーのみを使用しており、これはアクセシビリティの問題につながる可能性があります。HTML5ガイドラインによると、プレースホルダーはアクセシビリティのためにラベルを置き換えるべきではありません。

<figure>
  <blockquote>アクセシビリティと制御の使いやすさを低下させるため、ラベルの代替としてのplaceholder属性の使用は、高齢者ユーザーや認知、運動、細かい運動技能、または視覚障害を含むさまざまなユーザーにとって有害です。</blockquote>
  <figcaption>
  — <cite><a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">W3CのPlaceholder Research</a></cite>
  </figcaption>
</figure>


### 必須情報

フォームで必須フィールドを示すことは重要です。HTML5以前は、アスタリスク（*）が一般的に使用されていましたが、これは視覚的な手がかりのみであり、エラー検証を提供しません。さらに、HTML5のrequired属性と`aria-required`属性は、必須フィールドを示すためのセマンティクスを改善できます。

{{ figure_markup(
  image="form-required-controls.png",
  caption="必須入力の指定方法。",
  description="required属性がデスクトップサイトの64%とモバイルサイトの65%で使用され、`aria-required`が41%と40%で使用され、アスタリスクが20%と19%で使用され、これら3つのうち2つが実装されているのが14%と13%、すべて3つが使用されているのがデスクトップで2%、モバイルで1%であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=285790110&format=interactive",
  sheets_gid="1192677260",
  sql_file="form_required_controls.sql"
  )
}}

現在、
* モバイルサイトの65%がrequired属性を使用している（2022年の67%から減少）
* 40%が`aria-required`を使用している（2022年の32%から増加）
* 19%が依然としてアスタリスクのみに依存している（2022年の22%から減少）

これは、requiredと`aria-required`で補完されない限り避けるべきです。

### キャプチャ

WebサイトはしばしばCAPTCHAを使用して、訪問者が人間であり、ボットではないことを確認します。CAPTCHAは「Completely Automated Public Turing Test to Tell Computers and Humans Apart」の略で、悪意のあるソフトウェアを防ぐために一般的に使用されています。

{{ figure_markup(
  caption="2つの検出可能なCAPTCHAタイプのいずれかを実装しているモバイルサイト。",
  content="16%",
  classes="big-number",
  sheets_gid="590408963",
  sql_file="captcha_usage.sql"
)
}}

これらのテストは、とくに低視力や読み障害のある人にとって、すべての人にとって困難な場合があります。W3Cは、探索する価値のある視覚的CAPTCHAの代替案を提案しています。

## Webでのメディア

メディアのアクセシビリティは重要です。障害を持つ人々は、メディアコンテンツを理解し、相互作用するための代替手段を必要としています。たとえば、盲目のユーザーは画像や動画の音声説明を必要とし、耳の聞こえないまたは難聴のユーザーは手話やキャプションを必要とします。

音声のみおよび動画のみのコンテンツには、トランスクリプトが必要です。画像などの非テキストコンテンツには、同等の代替案が必要であり、それらが単に装飾的な場合は、セマンティック的にそのようにマークされる必要があります。

メディアプレーヤーは、ユーザーが音声または動画コンテンツを直接インラインで再生できるようにするために、しばしばページに埋め込まれます。この場合、オープンソースの<a hreflang="en" href="https://ableplayer.github.io/ableplayer/">Able Player</a>などのアクセシブルなプレーヤーを使用することが重要です。

## 画像

画像は、スクリーンリーダーにテキスト説明を提供する`alt`属性を持つことができます。画像の69%がGoogle Lighthouseの<a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.7/image-alt">alt テキストを持つ画像のオーディット</a>に合格しました（2022年の59%から上昇）。これは注目すべき増加であり、とくに数値が2021年から2022年にかけてわずか1%しか増加しなかったためです。

{{ figure_markup(
  caption="alt テキストを持つ画像のLighthouseオーディットに合格。",
  content="69%",
  classes="big-number",
  sheets_gid="1279863228",
  sql_file="lighthouse_a11y_audits.sql"
)
}}


alt テキストは、画像のコンテキストを反映する必要があります。装飾的な画像の場合は`alt=""`が適切で、意味のある画像には情報的な説明が必要です。ファイル名をalt テキストとして使用することは避けることも重要です。これはほとんど関連する情報を提供しないためです。現在、モバイルの7.5%とデスクトップの7.2%のサイトがこれを行っています。

{{ figure_markup(
  image="common-file-extensions-in-alt-text.png",
  caption="alt テキストでもっとも一般的なファイル拡張子。",
  description="alt で使用されるすべての拡張子のうち、jpgがデスクトップサイトで53%、モバイルで52%の時間使用され、pngは両方で33%、jpegは5%と5%、icoは4%、svgは2%、gifは1%、webpは2%、最後にtifは0%であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=283728620&format=interactive",
  sheets_gid="942056773",
  sql_file="alt_ending_in_image_extension.sql"
  )
}}

alt テキスト値でもっとも一般的に見つかるファイル拡張子（空でない`alt`属性を持つサイトの場合）は、`jpg`（および`jpeg`）、`png`、`ico`、`svg`です。これは、CMSまたはその他のコンテンツ管理システムがalt テキストを自動生成するか、コンテンツエディターに提供を要求していることを示している可能性があります。しかし、CMSが単に画像ファイル名を`alt`属性に含めるだけの場合、通常はユーザーに利益をもたらしません。したがって、意味のあるテキスト説明を使用することが重要です。

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` 属性の長さ。",
  description="デスクトップサイトの画像のテキスト代替の長さを比較した棒グラフ。alt が設定されていないのが15%、空に設定されているのが30%、10文字以下が17%、20文字以下が15%、30文字以下が8%、100文字以下が15%、100文字を超えるのが1%であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=580789543&format=interactive",
  sheets_gid="1040825973",
  sql_file="common_alt_text_length.sql"
  )
}}

alt テキストのない画像は現在15%でわずかに減少しており、2022年の値から3%減少しています。デスクトップとモバイルの両サイトでalt テキスト属性の30%が空であることがわかりました。これは2022年の27%から増加しています。空の`alt`属性は、純粋に装飾的で、スクリーンリーダーやその他の支援技術によって説明される必要のない画像にのみ使用されるべきです。ほとんどの画像はページコンテンツに貢献するため、一般的に<a hreflang="en" href="https://www.craigabbott.co.uk/blog/how-to-write-good-alt-text-for-screen-readers/">意味のある説明を含める</a>べきです。

残念ながら、`alt`属性の17%が10文字以下を含んでおり、これは2022年から1%減少しています。これらの異常に短い説明は、画像を適切に説明するための不十分な情報を示唆しています。これらの一部はリンクのラベル付けに使用される場合があり、これは受け入れられますが、<a hreflang="en" href="https://adrianroselli.com/2024/05/my-approach-to-alt-text.html">多くは十分な説明的コンテンツを欠いています</a>。

これらの統計を変更するために、確実にもっと多くのことが行えます。<a hreflang="en" href="https://www.w3.org/TR/ATAG20/">オーサリングツールアクセシビリティガイドライン（ATAG）2.0</a>で提案されているように、より良いドキュメントと検証を通じて作成者をサポートするコンテンツツールは非常に少ないです。ますます多くの人々が、通常はクライアント側でalt テキストを作成するために人工知能（AI）を検討しています。Brian Teemanは<a hreflang="en" href="https://magazine.joomla.org/all-issues/june-2024/ai-generated-alt-text">AI生成Alt テキスト</a>について興味深い批評を書きました。

有望なアプローチの1つは、<a hreflang="en" href="https://www.drupal.org/project/aidmi">AIDmi</a>でCKEditorにAIを組み込んだDrupalのMike Ferandaからのものです。alt テキストがどのようなものであるかの例を作成者に示すことで、彼らが伝えようとしていることを反映するようにそれを編集する可能性が高くなります。このアプローチは他の編集ツールにも適用できます。

### 音声と動画

`<track>`要素は、キャプションや説明など、`<audio>`および`<video>`要素にタイムテキストを提供するために使用されます。これは、聴覚障害や視覚障害のあるユーザーがコンテンツを理解するのに役立ちます。

{{ figure_markup(
  caption="`<audio>`要素を持つサイトが`<track>`要素を含む。",
  content="0.1%",
  classes="big-number",
  sheets_gid="546746158",
  sql_file="audio_track_usage.sql"
)
}}

`<video>`要素の場合、数値はデスクトップとモバイルサイトの両方で0.5%、モバイルサイトで0.65%とわずかに高くなっています。これらの統計は、第三者サービスがテキスト代替を提供する可能性が低い`<iframe>`を介して埋め込まれた音声または動画をカバーしていません。私たちの業界はもっと多くのことができます。

<aside class="note">このレポートのデータを収集する方法論には、聴覚障害者および難聴者向けの字幕（SDH）を含むマニフェストファイルを含む現代のHLS（HTTP Live Streaming）は含まれていませんでした。将来、これをスキャンすることで、クローズドキャプションでサポートされている言語をより良く理解し、音声説明の使用に関する情報も収集できるようになります。</aside>

## ARIAによる支援技術

<a hreflang="en" href="https://www.w3.org/TR/using-aria/">Accessible Rich Internet Applications（ARIA）</a>は、障害を持つ個人のWebアクセシビリティを向上させるために設計されたHTML5要素の属性セットを提供します。しかし、ARIA属性の過度な使用は、時として解決する以上の問題を引き起こすことがあります。ARIAは、ネイティブHTML5要素が完全にアクセシブルな体験を確保するのに不適切な場合にのみ使用されるべきであり、必要以上に置き換えたり使用したりするべきではありません。

### ARIAロール

支援技術が要素と相互作用する際、要素のロールはユーザーがそのコンテンツとどのように関わるかを伝えるのに役立ちます。

たとえば、<a hreflang="en" href="https://inclusive-components.design/tabbed-interfaces/">タブ式インターフェース</a>は、その構造を正確に表現するために、しばしば特定のARIAロールを必要とします。<a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/#tabpanel">WAI-ARIAオーサリングプラクティスデザインパターン</a>は、ネイティブHTMLに相当するものがないため、コンテナ要素にtablistロールを割り当てることを提案して、アクセシブルなタブ式インターフェースの作成方法を概説しています。

HTML5は、組み込みのセマンティクスとロールを持つ多数のネイティブ要素を導入しました。たとえば、`<nav>`要素は本質的に`role="navigation"`を持っているため、ARIAでこのロールを明示的に追加する必要がありません。

{{ figure_markup(
  image="top-10-aria-roles.png",
  caption="トップ10のもっとも一般的なARIAロール。",
  description="デスクトップサイトの49%とモバイルサイトの50%でbuttonが使用され、presentationがそれぞれ40%と39%、dialogが31%、navigationが26%と25%、searchが25%、mainが23%、imageが20%、bannerが16%、contentinfoが14%、最後にregionが14%で使用されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=176303741&format=interactive",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
  )
}}

モバイルサイトの50%以上が、少なくとも1つの要素に`role="button"`が割り当てられたホームページを持っていることがわかりました（2022年の33%、2021年の29%、2020年の25%から上昇）。この増加は懸念されます。なぜなら、Webサイトがカスタムボタンとして`<div>`または`<span>`要素を使用しているか、`<button>`要素に冗長にロールを適用している可能性があることを示唆しているからです。どちらの慣行も問題があり、可能な限り`<button>`などのネイティブHTML要素を使用するというARIAの基本原則に違反しています。

{{ figure_markup(
  caption='hrefを持つアンカーで`role="button"`を持つWebサイト。',
  content="18%",
  classes="big-number",
  sheets_gid="172806090",
  sql_file="anchors_with_role_button.sql"
)
}}

Webサイトの18%が`role="button"`を持つ少なくとも1つのリンクを持っています（2022年の21%からわずかに減少）。ARIAロールを追加することで支援技術に要素の目的を知らせることができますが、その要素をネイティブの対応要素のように機能させることはできません。リンクとボタンは異なる動作をするため、この不一致はキーボードナビゲーションの問題につながる可能性があります。たとえば、リンクはスペースキーでアクティブ化されませんが、ボタンはアクティブ化されます。

### presentation ロールの使用

要素に`role="presentation"`が割り当てられると、その要素は、必要な子要素のセマンティクス（たとえば、`<ul>`内のリスト項目、またはテーブル内の行とセル）とともに、固有のセマンティクスを失います。たとえば、親の`<table>`または`<ul>`要素に`role="presentation"`を適用すると、このロールが子要素に伝播し、テーブルまたはリストのセマンティクスが失われます。

`role="presentation"`でセマンティクスを削除することは、要素が視覚的な存在のみを持ち、その構造が支援技術によって認識されないことを意味します。要素のコンテンツはスクリーンリーダーによって読み上げられますが、セマンティクスに関する情報は提供されません。

{{ figure_markup(
  caption='デスクトップサイトの40%とモバイルサイトの39%が少なくとも1つの`role="presentation"`を持っています。',
  content="40%",
  classes="big-number",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
)
}}

これは懸念されます。なぜなら、2022年にはすでにデスクトップサイトの25%とモバイルサイトの24%で高い値だったからです。

同様に、`role="none"`を使用することも要素のセマンティクスを削除します。今年、サイトの5%が`role="none"`を使用しており、2022年の11%から減少しています。`<table>`が純粋にレイアウトに使用される場合など、まれなケースでは有用かもしれませんが、一般的にはアクセシビリティに有害である可能性があるため、慎重に使用する必要があります。

ほとんどのブラウザーは、リンクや入力、またはtabindex属性を持つ要素を含むフォーカス可能な要素のアクセシビリティツリーでロールを公開する際に、`role="presentation"`と`role="none"`を無視します。同様に、これらのロールを持つ要素が（`aria-describedby`などの）グローバルARIA状態またはプロパティを含む場合、`presentation`と`none`ロールは無視される可能性があります。

### ARIAによる要素のラベリング

DOMに加えて、ブラウザーには<a href="https://developer.mozilla.org/ja/docs/Glossary/Accessibility_tree">アクセシビリティツリー</a>があり、アクセシブルな名前、説明、ロール、状態などのHTML要素の詳細が含まれています。この情報は、アクセシビリティAPIを通じて支援技術に伝達されます。

要素のアクセシブルな名前は、そのコンテンツ（たとえば、ボタンのテキスト）、属性（たとえば、画像の`alt`属性）、または関連する要素（たとえば、フォームコントロールにリンクされたラベル）から取得できます。複数のソースが利用可能な場合、アクセシブルな名前のソースを決定するために使用される階層があります。アクセシブルな名前についてさらに読むには、Léonie Watsonの記事<a hreflang="en" href="https://developer.paciellogroup.com/blog/2017/04/what-is-an-accessible-name/">"アクセシブルな名前とは何か？"</a>が貴重なリソースです。

{{ figure_markup(
  image="top10-aria-attributes.png",
  caption="トップ10のARIA属性。",
  description="`aria-label`がサイトの65%で使用され、`aria-hidden`が63%、`aria-expanded`が35%と34%、`aria-live`が29%と28%、`aria-controls`が29%と28%、`aria-labelledby`が27%と26%、`aria-current`が25%と26%、`aria-haspopup`が25%と23%、`aria-describedby`が18%と16%、最後に`aria-atomic`が15%と14%で使用されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=859350702&format=interactive",
  sheets_gid="941417225",
  sql_file="common_element_attributes.sql"
  )
}}

アクセシブルな名前の割り当てを支援する2つのARIA属性は、`aria-label`と`aria-labelledby`です。これらの属性は、ネイティブに導出されたアクセシブルな名前よりも優先され、控えめに、必要な場合にのみ使用されるべきです。スクリーンリーダーでアクセシブルな名前をテストし、障害を持つ個人を関与させることは、名前が役立ち、アクセシビリティを妨げないことを確保するために重要です。

私たちは、評価されたページのほぼ66%が`aria-label`属性を持つ少なくとも1つの要素を特徴としていることを観察しました（2022年のデスクトップの58%とモバイルの57%から増加）。これにより、アクセシブルな名前のためのもっとも頻繁に使用されるARIA属性となっています。さらに、デスクトップページの27%とモバイルページの25%が`aria-labelledby`属性を持つ少なくとも1つの要素を持っていました（両方とも2022年のデータから2%増加）。この傾向は、より多くの要素がアクセシブルな名前を割り当てられている一方で、視覚的ラベルを欠く要素の増加も示している可能性があります。これは、認知障害のあるユーザーや音声入力ユーザーにとって困難となる可能性があります。

{{ figure_markup(
  image="button-name-sources.png",
  caption="ボタンのアクセシブルな名前のソース。",
  description="デスクトップボタンの59%とモバイルボタンの57%でコンテンツが使用され、`aria-label`属性が24%で使用され、10%と12%でアクセシブルな名前がなく、value属性が6%と5%で使用され、title属性が両方で1%使用されていることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1222426699&format=interactive",
  sheets_gid="883063802",
  sql_file="button_name_sources.sql"
  )
}}

ボタンは通常、コンテンツまたはARIA属性からアクセシブルな名前を受け取ります。<a hreflang="en" href="https://www.w3.org/WAI/ARIA/apg/patterns/button/">ARIAガイドライン</a>によると、可能であれば要素がARIA属性よりもコンテンツからアクセシブルな名前を導出することが好ましいです。私たちは、デスクトップのボタンの59%がテキストコンテンツからアクセシブルな名前を取得していることを発見しました。これは2022年の61%からわずかに減少しています。`aria-label`属性の使用は、デスクトップで23.9%にわずかに増加しており（2022年の20%から）、より多くのサイトがアクセシブルな名前に`aria-label`属性を使用していることを意味します。

一部のケースでは、複数のボタンが同じコンテンツを持っているが異なる機能を持つ場合や、ボタンが画像やアイコンのみを含む場合など、`aria-label`が有用です。

## コンテンツの隠蔽

時として、視覚的インターフェースには支援技術のユーザーにとって有益でない冗長な要素が含まれています。このような場合、`aria-hidden="true"`を使用して<a hreflang="en" href="https://niquette.ca/articles/hiding-elements/">スクリーンリーダーから要素を隠す</a>ことができます。ただし、要素を削除することで、視覚的に提示されているものと比較してスクリーンリーダーユーザーにとって情報が少なくなる場合、このアプローチは使用すべきではありません。支援技術からコンテンツを隠すことは、アクセシブルにすることが困難なコンテンツを回避する方法であってはなりません。

{{ figure_markup(
  caption="`aria-hidden`属性を持つ少なくとも1つの要素を持つ。",
  content="63%",
  classes="big-number",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
)
}}

この属性を使ってセマンティックコンテンツを隠したり表示したりすることは、アクセシビリティAPIにコンテンツがいつ隠されているかを示すために、現代のインターフェースでよく行われる慣行です。この例として、見出しのリストの下にあるコンテンツが隠されており、ユーザーが見出しの1つを選択して関連するコンテンツを表示するまで隠される、アコーディオンコンポーネントがあります。

ARIAはアクセシビリティに大きな影響を与える可能性があり、慎重に使用する必要があります。<a hreflang="en" href="https://blog.pope.tech/2022/07/12/what-you-need-to-know-about-aria-and-how-to-fix-common-mistakes/">適切なメッセージを伝えるためにARIAを正しく適用することが重要です</a>。

たとえば、開示ウィジェットは、要素が展開または折りたたみによって表示または非表示になったときに支援技術に合図するために、`aria-expanded`属性を使用する必要があります。私たちの観測によると、モバイルページの34%が少なくとも1つの`aria-expanded`属性を持つ要素を持っており、これは2022年から約5%増加しています。

## スクリーンリーダー専用テキスト

開発者がスクリーンリーダーユーザーに追加情報を提供するために使用する一般的なアプローチは、スクリーンリーダーからはアクセス可能に保ちながら、CSSでテキストを視覚的に隠すことです。このCSS技術により、テキストがアクセシビリティツリーに含まれながら、視覚的には隠されたままになることが保証されます。

{{ figure_markup(
  caption="sr-onlyまたはvisually-hiddenクラスを持つデスクトップWebサイト。",
  content="16%",
  classes="big-number",
  sheets_gid="538059940",
  sql_file="sr_only_classes.sql"
)
}}

sr-onlyとvisually-hiddenクラス名は、開発者とUIフレームワークによって、スクリーンリーダーのみがアクセス可能なテキストを作成するために頻繁に使用されます。たとえば、BootstrapとTailwindはこの目的でsr-onlyクラスを含んでいます。私たちは、デスクトップページの16%とモバイルページの15%がこれらのCSSクラスの一方または両方を使用していることを発見しました（それぞれ2022年から1ポイント増加）。すべてのスクリーンリーダーユーザーが視覚障害を持っているわけではないため、スクリーンリーダー専用のソリューションに過度に依存することは避けるべきであることに注意することが重要です。この技術がインタラクティブ要素のアクセシブルな名前で使用される場合、コンピューターを音声で制御する人にとって、要素と相互作用するためにどのコマンドを与えるべきかを知ることが困難になる可能性があります。

## 動的レンダリングコンテンツ

時として、DOMの新しいまたは更新されたコンテンツについてスクリーンリーダーに通知することが必要です。たとえば、フォーム検証エラーは伝達されるべきですが、遅延読み込み画像はアナウンスする必要がないかもしれません。DOMの更新は、非破壊的な方法で行われるべきです。

{{ figure_markup(
  caption="`aria-live`を使用するライブリージョンを持つデスクトップページ。",
  content="29%",
  classes="big-number",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
)
}}

ARIAライブリージョンは、スクリーンリーダーがDOMの変更をアナウンスできるようにします。私たちは、デスクトップページの29%が`aria-live`属性を持つライブリージョンを使用しており（2022年の23%から増加）、モバイルページの28%が`aria-live`を使用していること（2022年の22%から増加）を発見しました。さらに、ページは暗黙の`aria-live`値を持つARIAライブリージョンロールを使用しています：

<figure>
  <table>
    <thead>
      <tr>
        <th>ロール</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>暗黙の<code>aria-live</code>値</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>status</code></td>
        <td class="numeric">9.2%</td>
        <td class="numeric">8.7%</td>
        <td><code>polite</code></td>
      </tr>
      <tr>
        <td><code>alert</code></td>
        <td class="numeric">6.9%</td>
        <td class="numeric">6.7%</td>
        <td><code>assertive</code></td>
      </tr>
      <tr>
        <td><code>timer</code></td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.8%</td>
        <td><code>off</code></td>
      </tr>
      <tr>
        <td><code>log</code></td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
        <td><code>polite</code></td>
      </tr>
      <tr>
        <td><code>marquee</code></td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
        <td><code>off</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ライブリージョンARIAロールを持つページとその暗黙の`aria-live`値。",
      sheets_gid="514880281",
      sql_file="common_aria_role.sql",
    ) }}
  </figcaption>
</figure>

ライブリージョンのバリエーションとその使用法について詳しくは、[MDNライブリージョンドキュメント](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/ARIA_Live_Regions)をチェックするか、この<a hreflang="en" href="https://dequeuniversity.com/library/aria/liveregion-playground">Dequeによるライブデモ</a>を試してみてください。

## ユーザーパーソナライゼーションウィジェットとオーバーレイ修復

ユーザーは、Webサイトでアクセシビリティウィジェットを見ることにますます慣れています。これらにより、彼らの体験を向上させるアクセシビリティ機能にアクセスできます。アクセシビリティオーバーレイはこれらの1つのタイプであり、通常2つのタイプの技術を含みます：パーソナライゼーションウィジェットとJavaScriptオーバーレイです。オーバーレイは汎用またはカスタムのいずれかです：

- **ユーザーパーソナライゼーション**：サイト訪問者がサイト内メニューを介してサイトの外観を変更できるようにするツール — フォントやカラーコントラストの調整などの変更
- **自動オーバーレイ修復**：複雑なアルゴリズムや人工知能を使用して、ユーザーインターフェースに影響を与える多くの一般的なWCAG問題を自動的にスキャンし、修復を試みる汎用技術
- **カスタムオーバーレイ修復**：特定の適合性ニーズに対処するためにエキスパート開発者によって書かれたサイト固有のコードで、支援技術との衝突を避けるために、コンテキスト内でアクセシビリティエキスパートによって検証されたもの

ブラウザーはパーソナライゼーションのための優れた組み込みツールを持っていますが、多くのユーザーはそれらについて知りません。一部のサイトは、カスタマイゼーションを簡単にするためにさまざまなアクセシビリティ機能を提供する **パーソナライゼーションウィジェット** を追加しています。多くの場合、これには<a hreflang="en" href="https://mcmw.abilitynet.org.uk/">ブラウザーに含まれている</a>フォントサイズ、間隔、コントラストが含まれます。これには、<a hreflang="en" href="https://www.microsoft.com/en-us/edge/features/read-aloud?form=MA13FJ">Edgeに含まれている</a>[テキスト読み上げ](https://ja.wikipedia.org/wiki/%E9%9F%B3%E5%A3%B0%E5%90%88%E6%88%90)などのツールも含まれる場合があります。これはさまざまなユーザーに有用ですが、とくにその環境で自分の支援技術を利用できない人にとって有用です。これらのウィジェットは、支援技術を積極的に使用していないユーザーや、ブラウザーの組み込みアクセシビリティ機能をすでに最大限に活用しているユーザーにとって役立ちます。

使用する場合、これらのツールが支援技術ユーザーを含むユーザー体験（UX）を妨げないことが重要です。そのため、欧州障害フォーラム（EDF）は、<a hreflang="en" href="https://www.edf-feph.org/accessibility-overlays-dont-guarantee-compliance-with-european-legislation">アクセシビリティオーバーレイは欧州法との適合性を保証しない</a>と明確に述べたレポートを発表しました：

「支援技術のユーザーは、すでに自分のデバイスとブラウザーを好みの設定に構成しています。オーバーレイ技術は、ユーザーの支援技術と干渉し、ユーザー設定を上書きして、代わりにオーバーレイを使用することを人々に強制する可能性があります。これにより、一部のユーザーグループにとってWebサイトのアクセシビリティが低下し、コンテンツへのアクセスが妨げられる可能性があります。」

**オーバーレイ修復** は、オーバーレイ製品でよく見られる2つめのタイプの技術です。自動オーバーレイ修復は、ページがブラウザーでレンダリングされる際に、一般的なWCAG問題を継続的に見つけて対処しようとします。カスタムオーバーレイ修復も、アクセシビリティの障壁を克服するためにJavaScriptで書くことができ、とくにもはや更新できないレガシーコードがある場合に有効です。障害を持つユーザーとのテストを含む適切な手動テストにより、カスタムオーバーレイは効果的なソリューションになり得ます。

人気のある自動オーバーレイが一部のユーザーにとって製品のアクセシビリティを低下させるという文書化された報告が多数あります。

この技術は一部のユーザーの一般的な障壁に対処し、サイトをよりアクセシブルにすることができます。自動オーバーレイは、開発チームがデザインやソースコードに対処することでのみ解決できるより複雑な問題に集中できるようにすることで、組織のアクセシビリティの進歩とコンプライアンスへの道筋を前進させることもできます。

残念ながら、多くのチームはオーバーレイに投資した後、単にアクセシビリティへの投資を停止します。

この技術は、優れたアクセシビリティ実践の必要性を置き換えるものではありません。アクセシビリティは製品ライフサイクルのすべての段階に含まれる必要があります。オーバーレイは、ソースでエラーを修正するよりも常に多くのユーザビリティ、セキュリティ、パフォーマンスの問題を抱えることになります。自動ツールはWebサイトを完全にアクセシブルにしたり、WCAG準拠にしたりできないことを覚えておくことが重要です。

{{ figure_markup(
  image="pages-using-a11y-apps.png",
  caption="アクセシビリティアプリ（オーバーレイ）を使用するページ。",
  description="2024年のデータを示す棒グラフで、デスクトップサイトのほぼ2%とモバイルサイトのほぼ1.7%がアクセシビリティアプリを使用している。このグラフはまた、2022年と2021年のデータとも比較している。デスクトップでのオーバーレイの使用は2021年と比較してほぼ倍増しており、2021年はデスクトップで1%未満、モバイルで0.8%だった。2022年のデスクトップとモバイルのデータは1.6%と1.2%で、観測された成長と一致している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=924673292&format=interactive",
  sheets_gid="1139100212",
  sql_file="a11y_technology_usage.sql"
  )
}}

2024年には、デスクトップWebサイトのほぼ2%が既知のアクセシビリティアプリを利用していることを観察しました。これらの製品すべてがアクセシビリティオーバーレイではありませんが、検出可能なオーバーレイは同様の成長傾向を示しています。

{{ figure_markup(
  image="a11y-app-usage-by-rank.png",
  caption="ランク別のアクセシビリティアプリ使用状況。",
  description="もっとも一般的に使用される4つのオーバーレイブランドと、トップ1,000、10,000、100,000、1,000,000、10,000,000、およびすべてのページのグループランクでのパーセンタイルを示す棒グラフ。UserWayがもっとも人気で、AccessiBe、AudioEye、EqualWebが続く。比較のため、トップ1,000万ページのみを見ると、Userwayが0.71%、Accessibyが0.49%、AudioEyeが0.45%、EqualWebが0.04%である。AccessiBeは、トップ100万サイトの他の値と比較して優位に見える。AudioEyeは、トップ10,000サイトで人気のようである。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1842351478&format=interactive",
  sheets_gid="251539385",
  sql_file="a11y_technology_usage_by_domain_rank.sql"
  )
}}

UserWayは私たちのデータセットで最も広く使用されているオーバーレイです。

{{ figure_markup(
  image="pages-using-a11y-apps-by-rank.png",
  caption="ランク別のアクセシビリティアプリ使用ページ。",
  description="トップ1,000サイトで、デスクトップの0.3%とモバイルの0.2%がアクセシビリティアプリを使用し、トップ10,000ではそれぞれ0.5%と0.4%、トップ100,000では0.8%と0.7%、トップ100万では1.1%と1.0%、トップ1,000万では1.2%と1.0%、すべてのサイトでは1.0%と0.9%であることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=2030664465&format=interactive",
  sheets_gid="300879270",
  sql_file="a11y_overall_tech_usage_by_domain_rank.sql"
  )
}}

これらのソリューションは、一般的に高トラフィックのWebサイトではあまり使用されません。訪問数でトップ1,000にランクされたサイトでは、わずか0.2%のみがオーバーレイを使用しています。

### オーバーレイに関する混乱

<a hreflang="en" href="https://www.accessibilityassociation.org/">国際アクセシビリティプロフェッショナル協会（IAAP）</a>は、<a hreflang="en" href="https://www.accessibilityassociation.org/s/overlay-position-and-recommendations">アクセシビリティオーバーレイのポジションと推奨事項</a>を概説した論文を発表しました。その中で、IAAPはオーバーレイ技術がユーザーのアクセスを妨げてはならないことを強調しています。さらに、IAAPメンバーは、Webサイトやアプリケーションがオーバーレイ技術で完全にアクセシブルになるという含意の主張をサポートしてはならないと述べています。

多くのオーバーレイプロバイダーによる虚偽の広告宣伝は、アクセシビリティ擁護者からの抗議を促しました：<a hreflang="en" href="https://adrianroselli.com/2020/06/accessiBe-will-get-you-sued.html">Adrian Roselliの#accessiBe Will Get You Sued</a>は2020年に最初に公開されましたが、ケースが進展するにつれて積極的に更新されています；Lainey Feingoldの<a hreflang="en" href="https://www.lflegal.com/2023/07/adrian-roselli-slapp-lawsuit/">アメリカの法的観点</a>。

アクセシビリティを前進させるために使用されるツールや技術の能力と制限を明確に理解することが重要です。企業の能力に関する虚偽の主張は、多くのクライアントを混乱させています。組織は、適用可能なアクセシビリティ要件を満たし、訪問者に最高の体験を提供することを確保するために、適切な調査を行う責任があります。

EU委員会も米国司法省（DOJ）も、Webアクセシビリティ標準がどのように満たされるべきかを述べていません — ただ、それらが満たされなければならないということだけです。<a hreflang="en" href="https://www.federalregister.gov/documents/2024/04/24/2024-07758/nondiscrimination-on-the-basis-of-disability-accessibility-of-web-information-and-services-of-state">DOJ ADA Title IIルール制定</a>から、ルールは「公的機関がこのルールの下で技術標準に適合するために実装する可能性のある内部ポリシーや手順については対処していない」とあります。

一部の事例では、オーバーレイと手動の専門知識の組み合わせがアクセシビリティの改善を加速する可能性があります。

## セクターとアクセシビリティ

今年は一連の新しいデータ比較を提供しています。異なるコミュニティがアクセシビリティをどのように扱ってきたかには、認識できる違いがあることを強調したいと思います。良いガバナンスまたは良いデフォルトに基づいているかにかかわらず、重要なアクセシビリティの違いを見ることが可能です。このセクションの著者の希望は、これがさまざまなコミュニティがアクセシビリティをどのように扱うかのレビューを促すことです。

また、このセクションでは、オープンソースツールである[Google Lighthouse](https://developer.chrome.com/docs/lighthouse/accessibility/scoring)を使用してWebサイトのアクセシビリティも評価しました。

### 国別

国情報を特定する方法は2つあります。まずサーバーのGeoIDによる方法、そして第二にトップレベルドメインによる方法です。異なる国でのホスティングの価格のため、一部の国は他の国よりもGeoIDでよく表現されています。同様に、`.ai`や`.io`ドメインのように多くのドメインが国とは独立して動作できることを考えると、すべての`.ca`、`.es`、または`.fi`ドメインがカナダ、スペイン、またはフィンランドに位置していると仮定することはできません。

{{ figure_markup(
  image="country-by-geoid.png",
  caption="GeoIDによるもっともアクセシブルな国々。",
  description="GeoIDを含む棒グラフで、アクセシビリティの平均が最も高い国はアメリカで84%の値です。カナダ、イギリス、オーストラリア、ドイツ、オランダ、フランス、メキシコ、イタリア、スペイン、アルゼンチン、インドネシア、インド、ポーランド、ブラジル、日本、トルコ、ベトナム、中国と進み、最後に韓国が78%となり、1%未満の減少があります。これらは10万以上のドメインをホストする国のものでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=421126157&format=interactive",
  sheets_gid="260430925",
  sql_file="lighthouse_score_by_country.sql",
  width=600,
  height=504
  )
}}

アメリカで運営されている多くのサイトがアクセシビリティに関するSection 508ガイドラインの対象となっていることは注目に値します。組織は、アクセシブルなWebサイトを持たないことでADA Title IIIの下でアメリカで訴訟を起こされています。アメリカがもっともアクセシブルな国であることは驚くことではありません。他の管轄区域も、自分たちの地域内で販売したり市民に販売したりする企業を処罰し始めています。ますます多くの人々が[欧州アクセシビリティ法](https://ja.wikipedia.org/wiki/%E6%AC%A7%E5%B7%9E%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B7%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E6%B3%95)を見て、2025年に導入される新しい要件に備えています。

以下のマップは、国別トップレベルドメイン（TLD）によるデスクトップアクセシビリティスコアの平均を示しています。

{{ figure_markup(
  image="country-by-tld.png",
  caption="トップレベルドメイン（TLD）によるアクセシブルな国々。",
  description="45,000以上のドメインを持つトップレベルドメインを見ると、アクセシビリティについて学ぶことができます。アクセシブルなドメインとして棒グラフで表示されているのは、.edu（教育）、.gov（米国政府）、ノルウェー、フィンランド、.io、カナダ、USA、.app、UK、スウェーデン、アイルランド、オーストラリア、ニュージーランド、.co、オーストリア、ベルギー、スイス、デンマーク、南アフリカ、.orgです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1241724533&format=interactive",
  sheets_gid="1209052596",
  sql_file="lighthouse_score_by_tld.sql",
  width=600,
  height=483
  )
}}

しかし、TLDをランク付けして非国家コードも含めて見ると、少し理解しやすくなります。

{{ figure_markup(
  image="country-by-tld-globe.png",
  caption="トップレベルドメイン（TLD）によるアクセシブルな国々のマップ。",
  description="45,000以上のドメインを持つトップレベルドメインを見ると、アクセシビリティについて学ぶことができます。世界地図で視覚的に表示すると、もっともアクセシブルな国々は、ノルウェー、フィンランド、カナダ、USA、UK、スウェーデン、アイルランド、オーストラリア、ニュージーランド、オーストリア、ベルギー、スイス、デンマーク、南アフリカです。中国はトップレベルドメインによるともっともアクセシビリティが低いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=783736776&format=interactive",
  sheets_gid="1209052596",
  sql_file="lighthouse_score_by_tld.sql"
  )
}}

前のチャートと同様に、`.edu`と`.gov`ドメインがもっともアクセシブルです。Section 508と<a hreflang="en" href="https://www.levelaccess.com/compliance-overview/section-504-compliance/">Section 504</a>の下での米国政府は、20年以上にわたってこれを義務の一部としてきました。初期のアクセシビリティ法制と<a hreflang="en" href="https://www.accessibility.com/digital-lawsuits">活発な訴訟</a>が、米国でのアクセシビリティの採用を推進してきました。米国外の国々は、WCAG適合のための法制化と執行措置の提供を後から開始しました。Lainey Feingoldは<a hreflang="en" href="https://www.lflegal.com/global-law-and-policy/">グローバルな法律とポリシー</a>の素晴らしいリストを維持しています。

### 政府

すべての政府ドメインが一貫したアクセシビリティルールに従っているわけではありませんが、多くの国の政府サイトを分離することができました。一部の国では政府サイトの命名に一貫性がないため、カバーされない例外があります。私たちは世界中のほとんどの政府機関の平均を収集しました。

{{ figure_markup(
  image="accessible-governments.png",
  caption="もっともアクセシブルな政府Webサイト。",
  description="もっともアクセシブルなグローバル政府を示す棒グラフ。オランダ（98%）、ルクセンブルク（96%）、フィンランド（94%）、UK（92%）、欧州連合（91%）、ノルウェー（91%）、ジャージー（91%）、シンガポール（92%）、ベルギー（91%）、ドイツ（91%）、フランス（90%）、オーストラリア（89%）、ニュージーランド（89%）、デンマーク（89%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=415917251&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

ほとんどの現代の政府は、WCAG 2.0 AAまたはWCAG 2.1 AAのいずれかにコミットしています。これらのポリシーの実装が等しく提供されていないことは明らかです。これは欧州連合内のアクセシビリティを調べる際にとくに重要で、各加盟国は<a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/policies/web-accessibility-directive-standards-and-harmonisation">Webアクセシビリティ指令</a>に基づく法制を実装する必要があります。3年間の<a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/library/web-accessibility-directive-monitoring-reports">EU加盟国レポート</a>を、ここで提供された値や将来のWeb Almanacと比較することが可能であるべきです。米国の平均が87%であることは注目に値します。

{{ figure_markup(
  image="accessible-governments-world.png",
  caption="グローバル政府Webサイトのアクセシビリティマップ。",
  description="マップは上記の表を視覚的に単純に図示しています。スカンジナビア諸国がヨーロッパの多くの国と同様に際立っています。太平洋ではオーストラリアとニュージーランドがハイライトされています。カナダは米国よりもわずかに濃い色になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1696489298&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

オランダ（98%）が確実にトップで、ルクセンブルク（96%）とフィンランド（94%）が続きます。<a hreflang="en" href="https://design-system.service.gov.uk">イギリス</a>と<a hreflang="en" href="https://github.com/nl-design-system">オランダ</a>はどちらもアクセシビリティを優先する標準化されたデザインシステムを持っています。ルクセンブルクとフィンランドの成功に何が貢献しているのでしょうか？ほとんどのアクセシビリティコンテンツが英語でのみ利用可能であることを考慮すると、これが一部の政府による採用を減少させているのでしょうか？

政府ドメインは主にドメイン名パターンマッチングに基づいて発見されました。政府がドメイン名を使用する方法には多くの不整合がありますが、ここには比較を提供するのに十分な情報があります。`.gov`は米国政府のすべてのレベルをカバーしているため、州固有のレポートを除いて、それらの州固有のサブドメインを除外しようとしたことは注目に値します。このレポートでは、市や地域の`.gov`サイトを除外することができませんでした。上記のTLD `.gov`ドメインチャートを見ると、平均は87%でした。

さまざまな州のアクセシビリティも確認できます。

{{ figure_markup(
  image="US-state-governments.png",
  caption="もっともアクセシブルな米国州政府。",
  description="米国でもっともアクセシブルな州を示す棒グラフ。コロラド（96%）、バーモント（94%）、ネバダ（93%）、サウスカロライナ（91%）、ジョージア（91%）、ノースカロライナ（91%）、カンザス（90%）、メイン（90%）、カリフォルニア（90%）、ニューヨーク（90%）、ハワイ（89%）、DC（89%）、ロードアイランド（89%）、ミズーリ（89%）、マサチューセッツ（89%）、ニューハンプシャー（89%）、ミネソタ（89%）、ミシガン（88%）、オレゴン（88%）、アイオワ（88%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=174949843&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql",
  width=600,
  height=504
  )
}}


{{ figure_markup(
  image="US-state-governments-map.png",
  caption="もっともアクセシブルな米国州政府のマップ。",
  description="米国州固有のマップによる上記データの視覚化。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1855786285&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

再び、コロラドとバーモントは他の州よりもはるかに進んでいます。コロラドは、<a hreflang="en" href="https://sipa.colorado.gov/">州全体インターネットポータル機構（SIPA）</a>を中央集権化し、<a hreflang="en" href="https://oit.colorado.gov/accessibility-law">新しいアクセシビリティ法制</a>とともに、現在平均96%を達成しています。ジョージア州は中央機関を通じて管理される<a hreflang="en" href="https://digital.georgia.gov/services/govhub">中央Drupalインストール</a>を持っていますが、これが上位5位に入る理由を説明しているのでしょうか？ペンシルベニア州の州平均は82%とはるかに低いですが、2023年に設立された新しい<a hreflang="en" href="https://code.oa.pa.gov/">デジタルエクスペリエンスチーム</a>もあります。

今年初めに、米国司法省は<a hreflang="en" href="https://www.ada.gov/resources/2024-03-08-web-rule/">障害者のアメリカ人法（ADA）タイトルIIの規制を更新しました</a>。米国の州政府と地方政府は今後すべて、WCAG 2.1 AAに完全に準拠することが要求されます。コンプライアンス日は人口の規模によって異なりますが、2026年4月または2027年4月のいずれかになります。米国の州がこの新しい規制にどのように準拠するかを測定することが重要です。これらの数値の改善が見られるでしょう。

### コンテンツマネジメントシステム（CMS）

<a hreflang="en" href="https://webaim.org/projects/million/">WebAim Million</a>調査はCMSデータをレビューしており、私たちはWeb Almanacを通じて同等の結果を提供できます。Web Almanacは、オープンソースだった時代のWappalyzerのフォークのカスタマイズ版を使用しています。これにより、レポートはどのCMSが使用されているかを特定し、結果を比較できます。Typo3がGoogle Lighthouseデータを使用する場合よりもWebAimでより良い結果を得ていたことは明らかです。両方の調査は、CMSの選択がアクセシビリティに影響を与えることを明確に示しました。

ほとんどの人がCMSについて考える時、ダウンロードして自分でインストールできるものを思い浮かべます。これは主にオープンソースツールで構成されていますが、排他的ではありません。Adobe Experience Manager（AEM）、Contentful、Sitecoreがこのトップ10リストでもっともアクセシブルな3つでした。この可能な説明は、AEMのようなクローズドソースソフトウェアは、アクセシビリティ問題に対処するためのより多くのリソースを持つ大企業によって使用される可能性が高いことです。さらに、オープンソースソフトウェアはWebサイト所有者に多くの自由を与えますが、場合によってはより悪いアクセシビリティにつながる可能性があります。

{{ figure_markup(
  image="traditional-cms.png",
  caption="アクセシブルな従来型コンテンツマネジメントシステム（CMS）の棒グラフ。",
  description="10,000以上のインスタンスを持つもっともアクセシブルなCMSは、AEM（87%）、Contentful（87%）、Sitecore（85%）、WordPress（85%）、Craft CMS（84%）、Contao（84%）、Drupal（84%）、Liferay（83%）、TypoCMS（83%）、DNN（82%）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=174688785&format=interactive",
  sheets_gid="686463338",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

これらの従来型CMSの監査を見ると、上位4つのLighthouse問題には非常に一貫性があります。カラーコントラスト、リンク名、見出し順序、alt属性は、これらのCMS全体で定期的に発生する問題であり、これらの問題は主にユーザーに関連しています。なぜなら、CMSは選択された色やリンクの命名に責任を持つことができないからです。

<figure>
  <table>
    <thead>
      <tr>
        <th>従来型CMS</th>
        <th>もっとも多い</th>
        <th>2番目に多い</th>
        <th>3番目に多い</th>
        <th>4番目に多い</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Adobe Experience Manager</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>label-content-name-mismatch</code></td>
      </tr>
      <tr>
        <td>Contentful</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>image-alt</code></td>
      </tr>
      <tr>
        <td>Sitecore</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>image-alt</code></td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>target-size</code></td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>image-alt</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="人気CMSのトップアクセシビリティ監査問題。",
      sheets_gid="653243391",
      sql_file="lighthouse_a11y_audits_by_cms.sql",
    ) }}
  </figcaption>
</figure>

異なるCMSは、それらが持つトップエラーに多くの共通点があります。それらはほとんどコンテンツ問題に関係しており、これはATAG 2.0が支援するために書かれたものです。ATAGのベストプラクティスがWCAG 3.0に持ち込まれることが期待されています。このスキャンは公開されているWebサイトのみを対象としているため、オーサリングインターフェースは評価されていません。作成者には障害があることに注目する価値があり、作成者はアクセシブルなインターフェースを期待できるべきです。作成者はアクセシブルなコンテンツを作成するためのサポートも必要です。オーサリングツールへのより大きな焦点を促進するために、W3Cは<a hreflang="en" href="https://www.w3.org/WAI/atag/report-tool/">ATAGレポートツール</a>を作成しました。

作成者がページのアクセシビリティを評価するのに役立つ多くのツールがあります。スタッフのブラウザー設定を制御する機関は、すべてのブラウザーにオープンソースの<a hreflang="en" href="https://accessibilityinsights.io/docs/web/getstarted/assessment/">Accessibility Insights</a>ブラウザープラグインを単純にインストールすることを選択できます。これにより、エラーが管理者にとってはるかに見やすくなります。ただし、上記のCMSの多くにとって、最良のソリューションは、作成者を支援することを目的とした<a hreflang="en" href="https://sa11y.netlify.app/">Sa11y</a>や<a hreflang="en" href="https://editoria11y.princeton.edu/">Editoria11y</a>のようなツールをインストールすることかもしれません。Joomlaバージョン4.1以降では<a hreflang="en" href="https://sa11y.netlify.app/joomla/">Sa11yがデフォルトで含まれています</a>ので、すべての作成者が恩恵を受けます。

Webサイトプラットフォームは一般的に従来型CMSよりも良いパフォーマンスを示し、Wix、Squarespace、Google Sitesが大幅に優れています。

{{ figure_markup(
  image="platform-cms.png",
  caption="もっともアクセシブルなWebサイトプラットフォームコンテンツマネジメントシステム（CMS）の棒グラフ。",
  description="もっともアクセシブルなCMSの棒グラフ：Wix（94%）、Squarespace（92%）、Google Sites（90%）、Duda（87%）、HubSpot CMS（87%）、Pixnet（86%）、Weebly（86%）、GoDaddy Website Builder（85%）、WebNode（84%）、Tilda（83%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1383581431&format=interactive",
  sheets_gid="686463338",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

これらのCMSプラットフォームの監査を見ると、上位4つのLighthouse問題は問題の頻度において一貫性が低いですが、依然として多くの類似点があります。代替テキスト、リンク名、見出し順序、カラーコントラストはすべて依然として問題ですが、発生率が異なるだけです。

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォームCMS</th>
        <th>もっとも多い</th>
        <th>2番目に多い</th>
        <th>3番目に多い</th>
        <th>4番目に多い</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Wix</td>
        <td><code>heading-order</code></td>
        <td><code>link-name</code></td>
        <td><code>button-name</code></td>
        <td><code>color-contrast</code></td>
      </tr>
      <tr>
        <td>Google Sites</td>
        <td><code>image-alt</code></td>
        <td><code>link-name</code></td>
        <td><code>aria-allowed-attr</code></td>
        <td><code>heading-order</code></td>
      </tr>
      <tr>
        <td>Duda</td>
        <td><code>link-name</code></td>
        <td><code>color-contrast</code></td>
        <td><code>image-alt</code></td>
        <td><code>heading-order</code></td>
      </tr>
      <tr>
        <td>HubSpot CMS</td>
        <td><code>color-contrast</code></td>
        <td><code>heading-order</code></td>
        <td><code>link-name</code></td>
        <td><code>target-size</code></td>
      </tr>
      <tr>
        <td>Pixnet</td>
        <td><code>heading-order</code></td>
        <td><code>link-name</code></td>
        <td><code>color-contrast</code></td>
        <td><code>frame-title</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="人気CMSプラットフォームのトップアクセシビリティ監査問題。",
      sheets_gid="653243391",
      sql_file="lighthouse_a11y_audits_by_cms.sql",
    ) }}
  </figcaption>
</figure>

異なるCMSプラットフォームには、さまざまな強みと弱みがあります。たとえば、ARIAコンポーネントにはアクセシブルな名前が必要であることは明らかですが、GoDaddy Website Builderで構築されたWebサイトの36%がこのテストに失敗しています。一方、私たちのデータセットで100,000以上の出現を持つすべてのCMSプラットフォームの中央値失敗率はわずか1%です。GoDaddyはダイアログ名の分野でも異常値で、テストの14%が失敗しており、平均失敗率の1.3%と比較して高いです。

ポジティブな側面では、Dudaはボタン名で際立っており、そのWebサイトの3%のみがテストに失敗しており、中央値の13%と比較して優秀です。さらに印象的なのはWixで、WixのWebサイトの20%のみがカラーコントラストのLighthouseテストに失敗しており、もっとも使用されているCMSプラットフォーム間の中央値失敗率は70%です。同様に、Wixは画像の代替テキストに関して例外的に良い成績を示しており、失敗率はわずか1%で、中央値の34%と比較して優秀です。

これらの違いは、作成者がコンテンツをアクセシブルにするための最後のステップを取る必要がある場合でも、CMSがアクセシビリティに影響を与えることが可能であることを示しています。

### JavaScriptフロントエンドフレームワーク

<a hreflang="en" href="https://webaim.org/projects/million/#frameworks">WebAim Million</a>は、JavaScriptフレームワークとライブラリの影響も調べています。使用されるライブラリに基づいてデータのパターンを見ることが再び可能です。私たちは<a hreflang="en" href="https://2023.stateofjs.com/">State of JavaScript 2023</a>の定義を使用して作業しました。

{{ figure_markup(
  image="javascript-frontend-ui.png",
  caption="もっともアクセシブルなJavaScriptフロントエンドUIフレームワーク。",
  description="Stimulus（91%）、Remix（89%）、Qwik（89%）、Astro（89%）、OpenUI5（89%）、Next.js（87%）、React（87%）、AlpineJS（86%）、Htmx（85%）、Svelte（85%）、Ember.js（85%）でランク付けされた棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1864888468&format=interactive",
  sheets_gid="1029816121",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

Stimulus、Remix、Qwikは、React、Svelte、Ember.jsよりも平均で数パーセントアクセシブルです。

{{ figure_markup(
  image="javascript-meta-frameworks.png",
  caption="もっともアクセシブルなJavaScriptメタフレームワーク。",
  description="メタフレームワークが以下の順序で表示された棒グラフ：RedwoodJS（92%）、Remix（89%）、Astro（89%）、SolidStart（88%）、Gatsby（88%）、Next.js（87%）、Nuxt.js（84%）、AdonisJS（82%）、Quasar（82%）、Meteor（73%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=506578618&format=interactive",
  sheets_gid="1029816121",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

RedwoodJSが明らかにもっともアクセシブルで、Remix、Astroがそれに続きます。

## 結論

私たちの分析は、Webアクセシビリティに大きな変化がないことを示しています。いくつかの改善はありましたが、多くの簡単な問題が未解決のままです。カラーコントラストの改善と画像の`alt`属性の使用は、対処されれば大きな影響を与える可能性があります。CMSシステムとJavaScriptフレームワークには大きな責任があり、例はそれらがアクセシビリティに真の正の影響を与えることができることを証明しています。

私たちはしばしば、アクセシビリティを向上させることを意図した機能が、実際にはユーザー体験を悪化させながら、時として改善の誤った感覚を作り出すことを観察します。これらのアクセシビリティ問題の多くは、デザイナーと開発者がアクセシビリティ配慮を後付けとして扱うのではなく、最初から統合すれば避けることができるでしょう。組織は、よりアクセシブルなユーザー体験の開発を可能にするために、アクセシビリティトレーニング、運用、予算を優先する必要があります。一部の政府は、そのアプローチがいかに効果的であるかを実証しています。

Webコミュニティは、Webサイトがすべての人に対応する場合にのみ優れた顧客体験を提供することを理解する必要があります。2024年において、使用されるデバイス、ブラウザー、支援技術に基づいて人々を差別すべきではありません。私たちは対処が簡単な重要な指標に焦点を当てており、2025年により多くの改善が見られることを期待しています。
