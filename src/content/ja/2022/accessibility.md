---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: アクセシビリティ
description: 読みやすさ、ナビゲーション、フォーム、メディア、ARIA、アクセシビリティ・アプリを網羅した2022年版ウェブ年鑑のアクセシビリティの章。
authors: [SaptakS, thibaudcolas, scottdavis99]
reviewers: [shantsis]
analysts: [thibaudcolas]
editors: [dereknahman]
translators: [ksakae1216]
SaptakS_bio: Saptak Sは、ウェブ開発において使いやすさ、セキュリティ、プライバシー、アクセシビリティを重視する、人権に焦点を当てたウェブ開発者です。彼は、<a hreflang="en" href="https://www.a11yproject.com">The A11Y Project</a>、<a hreflang="en" href="https://onionshare.org/">OnionShare</a>、<a hreflang="en" href="https://wagtail.org/">Wagtail</a>など、様々なオープンソースプロジェクトのコントリビューター兼メンテナーです。彼のブログは<a hreflang="en" href="https://saptaks.blog">saptaks.blog</a>で見つけることができます。
scottdavis99_bio: Scott Davisは、<a hreflang="en" href="https://www.thoughtworks.com/">Thoughtworks</a>における著者兼デジタルアクセシビリティアドボケートです。彼は、ウェブ開発の最先端・革新的・新興・非伝統的な側面に焦点を当てています。"デジタルアクセシビリティは、単なるコンプライアンスチェックボックス以上のものです。アクセシビリティは革新のためのスプリングボードです。"
thibaudcolas_bio: Thibaud Colasは、アクセシビリティのトピックに焦点を当てたウェブ開発者であり、オープンソースのコントリビューターです。彼は、[Wagtail](https://wagtail.org/) CMSのコアコントリビューターであり、[Django](https://www.djangoproject.com/)のアクセシビリティチームのメンバーでもあります。
results: https://docs.google.com/spreadsheets/d/1ladaKh6RbtMKQwkccwxDJGQf85KyhfLrtlM_9e9sLH8/
featured_quote: 良いアクセシビリティは、障害を持つ人だけでなく、すべての人にとって有益です。これはユニバーサルデザインの核心原則の一つです。COVID-19パンデミックが始まって以来、ますます多くの人々がインターネットに依存するようになりました。同様に、アクセシビリティも改善する必要があります。そうでなければ、多くの人々を疎外するリスクがあります。ウェブアクセシビリティの現状はまだ望ましいレベルには達していませんが、今年はサイトのアクセシビリティが全体的に改善されたことが見られました。
featured_stat_1: 8%
featured_stat_label_1: `prefers-color-scheme` を使用して、ライト/ダークモードに基づいてスタイルを調整するサイト
featured_stat_2: 22.9%
featured_stat_label_2: Lighthouseのカラーコントラスト監査に合格するモバイルサイト
featured_stat_3: 9%
featured_stat_label_3: `:focus-visible` を使用するサイトは、昨年の0.6%に比べて増加
---

## 序章

グローバルオンライン人口の27%が<a hreflang="en" href="https://www.gwi.com/hubfs/Downloads/Voice-Search-report.pdf">モバイルで音声検索を使用しています</a>。Facebookの動画の85%が<a hreflang="en" href="https://idearocketanimation.com/18761-facebook-video-captions/">音声をオフにしてクローズドキャプションをオンで視聴されています</a>。Siri、Alexa、Cortanaなどの音声アシスタントに質問すると、通常、<a hreflang="en" href="https://www.theverge.com/23203911/screen-readers-history-blind-henter-curran-teh-nvda">パーソナルコンピューターが存在して以来のスクリーンリーダー技術</a>を使ってウェブページから答えを読み上げます。

ソフトウェアの機能が「アクセシビリティ機能」でなくなり、単に私たち全員が使用する「機能」となるのはいつですか？次にスマートフォンをサイレント/バイブレートモードにするとき、とくに聴覚障害/難聴コミュニティのメンバーでない場合、自分自身にその質問をしてみてください。

良いアクセシビリティは、障害を持つ人だけでなく、すべての人にとって有益です。これは<a hreflang="ja" href="https://ja.wikipedia.org/wiki/%E3%83%A6%E3%83%8B%E3%83%90%E3%83%BC%E3%82%B5%E3%83%AB%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3">ユニバーサルデザイン</a>の核心原則の1つです。ティム・バーナーズ＝リーは「ウェブの力はその普遍性にあります。障害の有無にかかわらず、誰もがアクセスできることが本質的な側面です」と述べています。COVID-19パンデミックが始まって以来、ますます多くの人々がインターネットに依存するようになりました。同様に、アクセシビリティも改善する必要があります。そうでなければ、多くの人々を疎外するリスクがあります。

Lighthouseアクセシビリティ監査データの全体的なサイトスコアの中央値は、2020年の80%から2021年には82%へ、そして2022年には83%へと上昇しました。この増加が正しい方向へのシフトを表していることを願っています。

ウェブアクセシビリティの現状はまだ望ましいレベルには達していませんが、今年はサイトのアクセシビリティが全体的に改善されたことが見られました。Lighthouseアクセシビリティ監査データの全体的なサイトスコアの中央値は、2020年の80%から2021年には82%へ、そして2022年には83%へと上昇しました。Lighthouseの結果を監査ごとに見ることで、どのような具体的な改善が行われたかを把握できます。

{{ figure_markup(
  image="lighthouse-audit-improvements-yoy.png",
  caption="年ごとのLighthouse監査の改善。",
  description="2021年と2022年において、5つの特定のLighthouse監査に合格しているサイトの数を示す棒グラフ。`aria-required-children`は2021年に63%のサイトで合格し、2022年には68%で合格。`aria-tooltip-name`は2021年に29%で合格し、2022年には75%で合格。`definition-list`は2021年に65%で合格し、2022年には68%で合格。`html-has-lang passes`は2021年に81%で合格し、2022年には84%で合格。`object-alt`は2021年に1%で合格し、2022年には20%で合格。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1480221360&format=interactive",
  sheets_gid="1270834582",
  sql_file="lighthouse_a11y_audits.sql",
) }}

Lighthouse監査の報告結果を見ると、41個の自動チェックのうち、35個が2022年に2021年に比べてより多くのサイトで成功裏に合格しました。11個の監査が1%以上の改善を示し、<a hreflang="ja" href="https://dequeuniversity.com/rules/axe/4.4/aria-required-children?lang=ja">`aria-required-children`</a>、<a hreflang="ja" href="https://dequeuniversity.com/rules/axe/4.4">`aria-tooltip-name`</a>、<a hreflang="ja" href="https://dequeuniversity.com/rules/axe/4.4/definition-list">`definition-list`</a>、<a hreflang="ja" href="https://dequeuniversity.com/rules/axe/4.4/html-has-lang">`html-has-lang`</a>、<a hreflang="ja" href="https://dequeuniversity.com/rules/axe/4.4/object-alt">`object-alt`</a>がとくに顕著な増加を示しています。この増加が正しい方向へのシフトを表していることを願っています。

ウェブにおけるアクセシビリティの改善に向けて、実践的なリンクと解決策を提供する形で本章を書こうと試みました。一貫性を保つために、本章では「障害を持つ人々」という人第一の用語を使用していますが、アイデンティティ第一の用語「障害のある人々」も使われていることを認識しています。私たちが用語を選んだことは、どちらの用語がもっとも適切かを指示するものではありません。

## 読みやすさ

ウェブ上の情報やコンテンツの可読性は極めて重要です。コンテンツの可読性に貢献するウェブサイトの要因は数多くあります。これらの要因は、インターネット上の誰もがコンテンツを消費するだけでなく、コンテンツのどの側面によっても害を受けないことを保証します。

### カラーコントラスト

カラーコントラストとは、テキスト、図表、アイコノグラフィー、その他の情報を含む前景がセクションの背景からどれだけ際立っているかを指します。高いカラーコントラストは通常、人々がコンテンツを区別しやすくなることを意味します。

<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Web Content Accessibility Guidelines</a>（WCAG）によって定義される通常サイズのテキスト（24pxまで）の最小コントラスト要件は、AA適合性で4.5:1、AAA適合性で7:1です。ただし、大きなフォントサイズの場合、コントラスト要件は3:1のみであり、大きなテキストは低いコントラストでも可読性が向上します。

{{ figure_markup(
  image="color-contrast-2019-2020-2021-2022.png",
  caption="十分なカラーコントラストを持つサイト。",
  description="2019年には22.0%のモバイルサイトが十分なカラーコントラストを持っていたこと、2020年にはわずかに減少して21.1%になり、2020年にはわずかに増加して22.2%になり、2022年にはさらに増加して22.9%になったことを示す棒グラフ。2022年では、デスクトップサイトも22.7%に達しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=2111814473&format=interactive",
  sheets_gid="1468870242",
  sql_file="color_contrast.sql",
) }}

22.9%のモバイルサイトが十分なテキストのカラーコントラストを持っていることが分かりました。前年比でほぼ1%増加しています。2022年には、デスクトップサイトのデータもあり、22.7%が自動テキストコントラストチェックに合格しています。テキストベースのカラーコントラストに関する問題は、ウェブサイトの構築を開始する前に非常に簡単に検証できるものです。開発者やデザイナーがテキストやグラフィカル要素のカラーコントラストをチェックするのに役立つ複数のツールがあります。以下はその一部です。

- <a hreflang="en" href="https://webaim.org/resources/contrastchecker/">ウェブカラーコントラストチェッカー（WebAIM製）</a>
- <a hreflang="en" href="https://www.figma.com/community/plugin/733159460536249875">Figmaプラグイン（Stark製）</a>

プロジェクトの初めや問題に取り組む際に、カラーコントラスト要件を満たすカラースキームを選択し、ウェブサイト全体で使用するのは良いアイデアです。また、ユーザーが選択できるように、ダークモード、ライトモード、高コントラストモードなどの他のカラーモードを提供することもできます。

### ズームとスケーリング

ズームは、視力が低いユーザーがウェブサイトのテキストをより見やすく表示するためによく使用する機能の1つです。ブラウザにはシステム設定があり、ユーザーがウェブサイトをズームイン/アウトしてスケーリングすることを可能にするツールもあります。[Adrian Roselli](https://x.com/aardrian)は、ズームを無効にしないべき[さまざまな理由について詳細に説明](https://adrianroselli.com/2015/10/dont-disable-zoom.html)しています。

{{ figure_markup(
  image="pages-zooming-scaling-disabled.png",
  caption="ズームインとスケーリングが無効になっているページ。",
  description="デスクトップサイトの16％とモバイルサイトの18％がスケーリングを無効にし、それぞれ最大スケールを1に設定したのは20％と24％であり、23％と28％はどちらかを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=550476172&format=interactive",
  sheets_gid="602773443",
  sql_file="viewport_zoom_scale.sql",
) }}

WCAGは、ウェブサイト内のテキストを最低でも200％までリサイズできるようにすることを要件としています。私たちは、デスクトップホームページの23％とモバイルホームページの28％がズームを無効にしようとしていることを発見しました。

開発者がズームを無効にした方法は、`<meta name="viewport" >` タグに `content` 属性内に `maximum-scale`、`minimum-scale`、`user-scalable=no`、または `user-scalable=0` のような値を追加することです。したがって、これらの値を持つウェブサイトがある場合は、ズームを有効にするために `content` 属性から特定の値を削除してください。

{{ figure_markup(
  image="pages-zooming-scaling-disabled-by-rank.png",
  caption="ランク別にズームとスケーリングが無効になっているページ。",
  description="トップ1,000のサイトでは、デスクトップサイトの21％とモバイルサイトの40％がズームとスケーリングを無効にしています。トップ10,000ではそれぞれ25％と36％、トップ100,000では25％と32％、トップミリオンでは24％と29％、そしてすべてのサイトでは23％と28％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1987306037&format=interactive",
  sheets_gid="1896788548",
  sql_file="viewport_zoom_scale_by_domain_rank.sql",
) }}

トップ1,000のもっとも訪問されるサイトのうち、デスクトップサイトの21％とモバイルサイトの40％は、ユーザーのズームやスケーリングを無効にしようとするコードを使用して構築されています。これは、ズームが無効になっているサイトの割合がモバイルではデスクトップと比較してほぼ倍になっていることを意味します。どのデバイスでもズームを無効にしないことは非常に重要です。この問題に対処するために、ブラウザは開発者がズームを無効にしようとする試みを上書きし始めています。[Manuel Matuzović](https://x.com/mmatuzo)は、ブラウザでのズームの無効化とユーザー設定に関する懸念について語った記事を書いています。[詳細はこちら](https://www.matuzo.at/blog/2022/please-stop-disabling-zoom/)をご覧ください。

{{ figure_markup(
  image="font-unit-usage.png",
  caption="フォント単位の使用。",
  description="フォントサイズに `px` が使用されているデスクトップとモバイルページの割合はそれぞれ71％、`em` はそれぞれ15％、`rem` はそれぞれ6％、`%` はデスクトップで4％、モバイルで5％、`<number>` はそれぞれ2％、最後に `pt` はそれぞれ2％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=850268795&format=interactive",
  sheets_gid="955782036",
  sql_file="units_properties.sql",
) }}

フォントサイズに選択する単位についても考慮すべき点があります。デスクトップのページの71％が `px` を使用しており、`em` と `rem` はそれぞれ15％と6％しか使用していません。したがって、デスクトップでの `px` の使用率は前年比で2％増加し、一方で `em` の使用率は2％減少しました。`font-size` に関しては、ユーザーがブラウザの設定で明示的に大きなまたは小さなデフォルトフォントサイズを選択した場合、`px` を使用すると [スケーリングされない可能性があるため](https://adrianroselli.com/2019/12/responsive-type-and-zoom.html#Update02)、`em` または `rem` などの相対単位を使用することが賢明とされています。

### 言語の識別

`lang` 属性を使用した言語の識別は、より良いスクリーンリーダーサポートを提供するために重要であり、自動ブラウザ翻訳にも役立ちます。これは、障害を持つ人々を含むすべての人々に役立つ機能のもう1つの良い例です。`lang` 属性がない場合、Chromeの自動ブラウザ翻訳がテキストを誤って翻訳することがよくあります。[Manuel Matuzović](https://www.matuzo.at/blog/lang-attribute/)は、`lang` 属性の不足による自動翻訳の失敗の一例を示しています。

{{ figure_markup(
  content="83%",
  caption="モバイルサイトには有効な `lang` 属性があります。",
  classes="big-number",
  sheets_gid="420415839",
  sql_file="valid_html_lang.sql",
) }}

83%のモバイルウェブサイトには`lang`属性が存在することは励みになります。さらに、そのグループの中で99%以上が有効な値を持っています。ただし、これはWCAG 2.1のLevel A適合の問題であるため、改善の余地があります。この成功基準を満たすには、`lang`属性を `<html>` タグに設定し、[既知の主要言語タグ](https://www.w3.org/WAI/standards-guidelines/act/rules/bf051a/#known-primary-language-tag) を使用できます。 [`lang`属性](https://developer.mozilla.org/ja/docs/Web/HTML/Global_attributes/lang) はグローバル属性であり、ウェブページに複数の言語のコンテンツがある場合に他のタグにも設定できます。ウェブサイトの正しい言語を定義することは重要です。ウェブサイトを作成するためにテンプレートをコピーする場合、ウェブサイトのコンテンツで使用される言語とコードで使用される`lang="en"`属性との間に不一致があることがあります。

### ユーザーの設定

<a hreflang="en" href="https://www.w3.org/TR/mediaqueries-5">CSS Media Queries Level5仕様</a> には、ユーザーのアクセシビリティに関するさまざまな設定に使用できる特定のユーザー設定メディアクエリがあります。これには、ユーザーに適したカラースキームやコントラストモードを選択することから、前庭障害を持つ人々に役立つページ上のアニメーションを削減することなどが含まれます。

{{ figure_markup(
  image="userpreference-media-queries.png",
  caption="ユーザー設定メディアクエリ。",
  description="`prefers-reduced-motion` メディアクエリを使用するデスクトップサイトが34%、モバイルサイトも34%です。 `prefers-color-scheme` メディアクエリを使用するデスクトップサイトは8%、モバイルサイトも8%です。また、`prefers-contrast` メディアクエリはデスクトップサイトとモバイルサイトの両方で1%が使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=727284960&format=interactive",
  sheets_gid="48059230",
  sql_file="media_query_features.sql",
) }}

モバイルウェブサイトの34%がprefers-reduced-motionを使用していることが判明しました。動きを主要な要素とするウェブサイトは、前庭障害を持つ方にとって問題を引き起こす可能性があるため、prefers-reduced-motionメディアクエリを利用して、これらのアニメーションを調整または削除することが重要です。アクセシビリティに関する素晴らしい <a hreflang="en" href="https://alistapart.com/article/designing-safer-web-animation-for-motion-sensitivity/">リソース</a> も多くあり、<a hreflang="en" href="https://www.a11yproject.com/posts/design-accessible-animation/">アクセス可能なアニメーションの設計</a> に関する情報も豊富です。

デスクトップとモバイルのウェブサイトのうち、8%が `prefers-color-scheme` メディアクエリを使用し、さらに1%が `prefers-contrast` を使用していることが判明しました。これらのメディアクエリは、ユーザーの好みに基づいて <a hreflang="en" href="https://www.a11yproject.com/posts/operating-system-and-browser-accessibility-display-modes/">ディスプレイモード</a> を調整することで、コンテンツの読みやすさを向上させます。`prefers-color-scheme` はブラウザがユーザーのシステムカラーを検出するのを可能にし、ウェブ開発者はこの情報を使用して明暗モードを提供できます。`prefers-contrast` は、低視力や光過敏症のあるユーザーにとって高コントラストモードが役立つ場合に便利です。

### 強制カラーモード

「強制カラーモード」は、テキストの可読性をカラーコントラストを通じて向上させるためのアクセシビリティ機能です。強制カラーモードでは、ユーザーのオペレーティングシステムがほとんどの色に関連するスタイルの制御を引き継ぎます。一般的なパターンとして背景画像などが完全に無効化されるため、テキストと背景のコントラストが予測可能になります。そのもっともよく知られた実装はWindowsの _ハイコントラストモード_ であり、Windows 11では <a hreflang="en" href="https://support.microsoft.com/en-us/topic/fedc744c-90ac-69df-aed5-c8a90125e696">_コントラスト・テーマ_</a> に改名されました。これらのテーマは、代替の低コントラストと高コントラストのカラーパレットを提供し、利用可能な[システムカラー](https://developer.mozilla.org/ja/docs/Web/CSS/system-color)のどれかをカスタマイズする能力も提供します。

{{ figure_markup(
  image="forced-colors-mode.png",
  caption="強制色モード。",
  description="25%のデスクトップサイトと24%のモバイルサイトが `-ms-high-contrast` メディアクエリを使用し、9%のデスクトップサイトと8%のモバイルサイトが `forced-colors` を使用していることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=359612516&format=interactive",
  sheets_gid="48059230",
  sql_file="media_query_features.sql",
) }}

他のユーザー好みのメディアクエリと同様に、多くのウェブサイトが強制色モードに基づいて調整を行っています。モバイルサイトの8%とデスクトップサイトの9%が `forced-colors` メディアクエリを使用してスタイルを変更していますが、古いIE11専用の `-ms-high-contrast` メディアクエリの使用率はモバイルとデスクトップの両方で20%以上です。
これによってサイトがどの程度強制色モードをサポートしているかは分かりませんが、`forced-colors` メディアクエリが主要なブラウザでサポートされているのは[2020年から](https://caniuse.com/mdn-css_at-rules_media_forced-colors)であり、Windows以外のデバイスで[強制色モードのエミュレート](https://developer.chrome.com/docs/devtools/renderingemulate-css?hl=ja)をサポートするのは2022年2月からであることを考えると、データはそれでもなお励みになります。

## ナビゲーション

ウェブサイトをナビゲートする際に重要なのは、ユーザーがさまざまな方法や入力デバイスを使用する可能性があることを覚えておくことです。マウスでページをスクロールする人もいれば、キーボードやスイッチコントロールデバイスを使用する人もいます。また、スクリーンリーダーを使って異なる見出しレベルをブラウズする人もいます。ウェブサイトを作成する際は、人々が選択するデバイスや支援技術に関係なく、ウェブサイトが全員にとって機能するようにすることが重要です。

### フォーカス表示

キーボードナビゲーションやスイッチコントロールデバイスに主に依存している人々にとって、フォーカス表示は非常に重要です。これらのツールは、運動能力が限られている人々によく使用されます。スイッチコントロールデバイスには、[単一スイッチ](https://www.24a11y.com/2018/i-used-a-switch-control-for-a-day/)から[シップ・アンド・パフデバイス](https://accessibleweb.com/assistive-technologies/assistive-technology-focus-sip-and-puff-devices/)までさまざまな種類があります。目に見えるフォーカススタイルと適切なフォーカス順序は、そのようなユーザーがページ上の位置を視覚的に知るために不可欠です。

#### フォーカススタイル

WCAGは、ページをトラバースする際にどの要素がキーボードフォーカスを持っているかを知るために、すべての対話型コンテンツに目に見えるフォーカスインジケーターを要求しています。事実上、[WCAG 2.2](https://w3c.github.io/wcag/guidelines/22/)では（2022年12月に公開予定）、これは[AAレベルからレベルAに昇格されました](https://w3c.github.io/wcag/guidelines/22/#focus-visible)。

{{ figure_markup(
  image="pages-overriding-focus-styles.png",
  caption="フォーカススタイルを上書きするページ。",
  description="デスクトップサイトの90%とモバイルサイトの89%が `:focus` 擬似クラスを使用し、デスクトップサイトの90%とモバイルサイトの91%が `:focus` 擬似クラスを使用してアウトラインを0またはnoneに設定しています。デスクトップサイトの9%とモバイルサイトの10%が `:focus-visible` 擬似クラスを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=500239469&format=interactive",
  sheets_gid="1548098920",
  sql_file="focus_outline_0.sql",
) }}

私たちは、ウェブサイトの86%が `:focus {outline: 0}` を追加していることを発見しました。これは、フォーカスされた対話型要素にブラウザが使用するデフォルトのアウトラインを削除します。いくつかの場合では、カスタムスタイリングを使って上書きされていますが、常にそうではありません。これにより、ユーザーはどの要素がフォーカスされているかを判断できず、ナビゲーションが妨げられます。[Sara Soueidan](https://x.com/SaraSoueidan)には、[WCAG準拠のフォーカスインジケーターをデザインする方法についての素晴らしい記事](https://www.sarasoueidan.com/blog/focus-indicators/)があります。しかし、昨年の0.6%と比較して、9%のウェブサイトが `:focus-visible` を持っているのを見るのは興味深いことです。これは間違いなく正しい方向への一歩です。

#### `tabindex`

`tabindex` は、要素がフォーカスを受け取ることができるかどうかを制御するために追加できる属性です。その値によって、要素はキーボードフォーカスまたは「タブ」順序内で整理されることもあります。

私たちは、モバイルウェブサイトの60%とデスクトップウェブサイトの62%が `tabindex` を使用していることを発見しました。`tabindex` 属性はいくつかの異なる目的に使用され、アクセシビリティの問題を引き起こす可能性があります：

- `tabindex="0"` を追加すると、要素はシーケンシャルなキーボードフォーカス順序に追加されます。対話型であることを意図したカスタム要素やウィジェットは、明示的に割り当てられた `tabindex="0"` が必要です。
- `tabindex="-1"` は、要素がキーボードフォーカス順序にはないが、JavaScriptを使用してプログラム的にフォーカスできることを意味します。
- 正の値の `tabindex` は、キーボードフォーカス順序を上書きするために使用され、ほとんどの場合、[WCAG 2.4.3 - フォーカス順序](https://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-focus-order.html)の失敗につながります。

キーボードフォーカス順序に非対話型要素を配置することは、低視力ユーザーに混乱を招く可能性があるため、避けるべきです。

{{ figure_markup(
  image="tabindex-usage-and-values.png",
  caption="`tabindex` の使用。",
  description="`tabindex` を使用するページの棒グラフ。デスクトップの場合、`tabindex` を持つページの77%で0が使用されており、モバイルの場合は76%です。負の `tabindex` はどちらも69%、正の `tabindex` はデスクトップで8%、モバイルで7%が使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=723679746&format=interactive",
  sheets_gid="1436895233",
  sql_file="tabindex_usage_and_values.sql",
) }}

すべてのウェブサイトの中で `tabindex` 属性を持つものは、そのうち7%が正の値を持っています。`tabindex` に正の値を使用することは一般的に良くない慣行であり、通常のナビゲーションを妨げる可能性があります。[Karl Groves](https://x.com/karlgroves) は、この概念について詳しく説明する [素晴らしい記事](https://karlgroves.com/2018/11/13/why-using-tabindex-values-greater-than-0-is-bad) を書いています。

### ランドマーク

ランドマークは、ウェブページをテーマごとの領域に分けるのに役立ち、支援技術を使用するユーザーがページの構造を理解しやすくし、ウェブサイトをナビゲートしやすくします。たとえば、[ローターメニュー](https://www.afb.org/blindness-and-low-vision/using-technology/cell-phones-tablets-mobile/apple-ios-iphone-and-ipad-2)を使用して異なるページのランドマーク間をナビゲートできますし、[スキップリンク](https://webaim.org/techniques/skipnav/)を使用して `<main>` を含むランドマークをターゲットに￥できます。ランドマークは、さまざまなHTML5要素を使用して作成できますが、ARIAの最初のルールにしたがって、可能な限りネイティブなHTML5要素を優先すべきです。

<figure>
  <table>
    <thead>
      <tr>
        <th>HTML5 <br>要素</th>
        <th>ARIAロール <br>相当</th>
        <th>要素を<br>持つページ</th>
        <th>ロールを<br>持つページ</th>
        <th>要素または<br>ロールを持つページ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`<main>`</td>
        <td>`role="main"`</td>
        <td class="numeric">31%</td>
        <td class="numeric">17%</td>
        <td class="numeric">38%</td>
      </tr>
      <tr>
        <td>`<header>`</td>
        <td>`role="banner"`</td>
        <td class="numeric">63%</td>
        <td class="numeric">13%</td>
        <td class="numeric">65%</td>
      </tr>
      <tr>
        <td>`<nav>`</td>
        <td>`role="navigation"`</td>
        <td class="numeric">63%</td>
        <td class="numeric">22%</td>
        <td class="numeric">67%</td>
      </tr>
      <tr>
        <td>`<footer>`</td>
        <td>`role="contentinfo"`</td>
        <td class="numeric">65%</td>
        <td class="numeric">11%</td>
        <td class="numeric">66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ランドマーク要素とロールの使用（デスクトップ）。",
      sheets_gid="2141972716",
      sql_file="landmark_elements_and_roles.sql",
    ) }}
  </figcaption>
</figure>

ほとんどのウェブページに期待される一般的なランドマークは、`<main>`、`<header>`、`<nav>`、`<footer>` です。デスクトップとモバイルページの31%だけがネイティブのHTML `<main>` 要素を持っており、デスクトップページの17%が `role="main"` を持つ要素を持っており、38%のページが `<main>` または `role="main"` のいずれかを持っています。ネイティブ要素の使用が増加しているのは良いことです。[Scott O' Hara](https://x.com/scottohara) の [ランドマークに関する記事](https://www.scottohara.me/blog/2018/03/03/landmarks.html) は、より良いアクセシビリティを確保するために心に留めておくべきすべての詳細をカバーしています。

### 見出し階層

見出しは、支援技術を使用するすべてのユーザーを含む、すべてのユーザーがウェブサイトをナビゲートするのに役立ちます。支援技術を使用するユーザーは、関心のある特定のセクションにナビゲートできます。[Marcy Sutton](https://x.com/marcysutton) の [見出しとセマンティック構造に関する記事](https://marcysutton.com/how-i-audit-a-website-for-accessibility#Headings-and-Semantic-Structure) によると、見出しは特定のコンテンツエリアに移動するためにナビゲートできる目次と考えることができます。

{{ figure_markup(
  content="58%",
  caption="適切に順序付けられた見出しに合格したモバイルサイト。",
  classes="big-number",
  sheets_gid="1270834582",
  sql_file="lighthouse_a11y_audits.sql",
) }}

58%のウェブサイトは、レベルを飛ばさない正しく順序付けられた見出しのテストに合格しており、これは昨年と同じです。来年は、[WHATWG標準のドキュメントアウトラインの例が更新されている](https://github.com/whatwg/html/pull/7829) ため、この数字が増加することを期待しています。非常に重要なことは、見出しレベルは特定の要素の実際のスタイル（または重要性）を表す必要はないということです。見出しは主に階層目的で使用されるべきであり、要素のスタイリングにはCSSを使用できます。ページ内の見出しの構造についての非常に良い記事は、[Steve Faulkner](https://x.com/stevefaulkner) による ["How to mark up subheadings, subtitles, alternative titles and taglines"](https://stevefaulkner.github.io/Articles/How%20to%20mark%20up%20subheadings,%20subtitles,%20alternative%20titles%20and%20taglines.html) です。

### 二次ナビゲーション

WCAGでは、ヘッダー内のプライマリナビゲーションメニュー以外にも、異なるページ間をナビゲートするための複数の方法が必要とされています。これは、[Success Criterion 2.4.5: Multiple Ways](https://www.w3.org/WAI/WCAG21/Understanding/multiple-ways.html)に記載されています。たとえば、多くのページがあるウェブサイトでは、認知的制限を持つ人を含む多くの人が、ページを見つけるために検索機能を使用することを好みます。

モバイルのウェブサイトでは23%、デスクトップでは24%が検索入力を持っています。二次ナビゲーションのためのもう1つの推奨される方法は、ウェブサイトにサイトマップを含めることです。サイトマップの存在についてのデータはありませんが、[W3Cの技術ガイド](https://www.w3.org/WAI/WCAG21/Techniques/general/G63)では、それらが何であるか、およびそれらを効果的に実装する方法を詳しく説明しています。

### スキップリンク

スキップリンクは、キーボードやスイッチコントロールデバイスのユーザーが、すべてのフォーカス可能なアイテムを通過することなく、ページの異なるセクションをスキップできるようにする機能です。もっとも一般的にスキップされるセクションの1つは、とくにウェブサイトのプライマリナビゲーションに多くのインタラクティブなアイテムがある場合、プライマリナビゲーションから `<main>` セクションへ移動することです。

{{ figure_markup(
  content="21%",
  caption="スキップリンクを持つ可能性があるモバイルおよびデスクトップページ",
  classes="big-number",
  sheets_gid="1778743357",
  sql_file="skip_links.sql",
) }}

デスクトップおよびモバイルページの21%にスキップリンクが存在する可能性があることがわかりました。これにより、ユーザーはページコンテンツの一部をバイパスできます。この数字は実際にはもっと高い可能性があります。なぜなら、私たちの検出はページの早い段階でのスキップリンクの存在のみをチェックするためです（例：ナビゲーションをスキップするため）。スキップリンクはページの一部をスキップするためにも使用できます。

### ドキュメントタイトル

ページ、タブ、ウィンドウ間でナビゲートする際、記述的なページタイトルが役立ちます。新しいページのタイトルは支援技術によって読み上げられ、ユーザーが現在どこにいるのかを把握するのに役立ちます。

{{ figure_markup(
  image="page_title-information.png",
  caption="タイトル要素の統計。",
  description="バーチャートで、デスクトップとモバイルサイトの98%が `<title>` 要素を使用しており、そのタイトルのうち69%（デスクトップ）と70%（モバイル）が4語以上の単語を含んでいます。また、4%（両方）がレンダリング時に変更されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=154664062&format=interactive",
  sheets_gid="634812711",
  sql_file="page_title.sql",
) }}

モバイルウェブサイトの98%にドキュメントタイトルがありますが、そのうち70%のみが4語以上のタイトルを持っています。私たちはウェブサイトのホームページのみをスキャンしているため、ウェブサイトの内部ページが `<title>` タグでページを詳しく説明するテキストを使用しているかどうかを判断することはできません。理想的には、タイトルにはウェブサイトのタイトルとページのコンテキストに関するタイトルの両方が含まれているべきで、より良いナビゲーションのために役立ちます。

### テーブル

テーブルは、二軸を使用してデータとデータ間の関係を表現するのに役立ちます。テーブルは、適切な要素とマークアップを備えた整然とした構造を持つべきであり、支援技術を使用するユーザーがテーブルに表されたデータを簡単に理解し、テーブルを通じてナビゲートするのに役立ちます。テーブルのキャプション、適切なヘッダー、そして各行の適切なヘッダーセルは、支援技術を使用するユーザーがデータを理解するのに役立つ重要な要素です。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">テーブルサイト</th>
        <th scope="colgroup" colspan="2">全サイト</th>
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
        <td>キャプション付きテーブル</td>
        <td class="numeric">5.4%</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>プレゼンテーションテーブル</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="アクセシブルなテーブルの使用。",
      sheets_gid="599630882",
      sql_file="table_stats.sql",
    ) }}
  </figcaption>
</figure>

テーブルにキャプションを提供する場合、`<caption>` 要素はスクリーンリーダーユーザーにもっともコンテキストを提供するための正しいセマンティックな選択です。ただし、[テーブルのラベリングの代替方法](https://www.w3.org/WAI/tutorials/tables/caption-summary/)もあります。テーブルのキャプションは、テーブルの情報を要約する見出しとして機能します。テーブル要素を持つデスクトップおよびモバイルサイトの1.3%が `<caption>` を使用しています。

テーブルはページのレイアウトにも使用されることがありますが、CSSのFlexboxやGridプロパティの登場により、視覚的なフォーマットにテーブルを使用することは避けるべきです。ただし、他に選択肢がない場合、テーブルは `role="presentation"` を設定できます。この回避策を使用するテーブルが1%観察されました。

## フォーム

フォームは、ユーザーが情報を提出し、ウェブサイトと対話するもっとも一般的な方法の1つです。ログイン、ソーシャルメディアへの投稿の作成、または電子商取引サイトでの購入など、これらのユーザージャーニーはいずれも何らかの段階でフォームを必要とします。適切なフォームのアクセシビリティがなければ、障害を持つ人々は適切に対話することができず、その結果、タスクを完了することができず、非障害者のユーザーと同じ情報や機能の平等性を達成することができません。

フォームのアクセシビリティに関しては、特定の点を念頭に置くべきです。

### `<label>`要素

`<label>` 要素は、フォーム内の入力フィールド（または[フォームコントロール](https://developer.mozilla.org/ja/docs/Learn/Forms/Basic_native_form_controls)）にアクセシブルな名前を提供するもっとも効果的な方法です。`for` 属性を使用して `<label>` をフォームコントロールにプログラム的にリンクできます。`for` 属性には、リンクしたいフォームコントロール要素の `id` 属性の値を含める必要があります。たとえば：

```html
<label for="emailaddress">Email</label>
<input type="email" id="emailaddress">
```

`for` 属性は重要です。これがないと、`<label>` は対応するフォームコントロールにプログラム的にリンクされません。これはフォームの使いやすさに影響を与える可能性があり、他の方法が使用されない限り、フィールドには意味的にリンクされたラベルがない可能性が高くなります。

{{ figure_markup(
  image="form-input-name-sources.png",
  caption="入力がアクセシブルな名前を取得するソース。",
  description="デスクトップ入力要素の38%とモバイル入力要素の38%にアクセシブルな名前がないことを示す棒グラフ。デスクトップページの24%とモバイルページの26%では`placeholder`がソースです。`relatedElement: label`の場合はそれぞれ20%と19%、`attribute: aria-label`の場合は7%と8%、`attribute: value`の場合は5%と5%、`attribute: title`の場合は4%と2%、`attribute: alt`の場合はどちらも1%、`attribute: type`の場合はどちらも1%、`relatedElement: aria-labelledby`の場合はどちらも0%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=231535249&format=interactive",
  sheets_gid="1245935907",
  sql_file="form_input_name_sources.sql",
  width="600",
  height="537",
) }}

入力の38%にアクセシブルな名前がなく、わずか19%が`<label>` を使用しています。適切なアクセシブルな名前がないと、スクリーンリーダーのユーザーや音声認識のユーザーは入力が収集しようとしているデータを特定できません。多くのウェブサイトには目に見えるラベルがない入力があり、すべてのユーザーに問題を引き起こすことがあります。また、入力の目的が視覚的にもプログラム的にも明確に定義されていない場合もあります。検索フィールドなど、ラベルを視覚的に省略する場合でも、アクセシブルな名前を提供するためにスクリーンリーダー専用の`<label>`を追加する必要があります。

### `placeholder` 属性

フォームコントロール内の `placeholder` 属性の目的は、そのフォームコントロールが受け入れるデータや形式の例を提供することです。たとえば、`<input type="text" id="credit-card" placeholder="1234-5678-9999-0000">` は、カード番号を4桁ごとにダッシュで区切って入力する必要があることをユーザーに知らせます。

しかし、`<label>` 要素とは異なり、`placeholder` 属性は誰かがタイピングまたはデータを入力し始める瞬間に消えます。これは、認知障害のあるユーザーが入力しようとしていたデータについて混乱する原因となります。また、すべてのスクリーンリーダーがアクセシブルな名前のための `placeholder` 属性をサポートしているわけではないため、問題が生じる可能性があります。そのため、アクセシブルな名前のために `placeholder` 属性を使用すると、多くの[アクセシビリティ問題](https://www.smashingmagazine.com/2018/06/placeholder-attribute/)が生じる可能性があり、避けるべきです。

{{ figure_markup(
  image="placeholder-but-no-label.png",
  caption="入力にプレースホルダーを使用する。",
  description="デスクトップサイトの59％とモバイルサイトの55％がプレースホルダーを使用していることを示す棒グラフ。デスクトップサイトの67％とモバイルサイトの67％にラベルのない入力があります。デスクトップサイトの61％とモバイルサイトの63％は、プレースホルダーとラベルのない入力を持っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1142115744&format=interactive",
  sheets_gid="1464041597",
  sql_file="placeholder_but_no_label.sql",
) }}

調査対象のウェブサイトの62.7％は、`<label>` 要素にリンクされていない `placeholder` 属性のみを持つ入力を持っており、これは非常に問題です。[HTML5仕様](https://html.spec.whatwg.org/#the-placeholder-attribute)では、「placeholder属性は、ラベルの代わりとして使用されるべきではない」と明確に記されています。すべてのユーザーのアクセシビリティを向上させるためには、`<label>` を提供することが重要です。

<figure>
  <blockquote>ラベルの代わりとしてプレースホルダー属性を使用すると、高齢者や認知障害、移動障害、微細な運動技能障害、視覚障害を持つユーザーを含むさまざまなユーザーのコントロールのアクセシビリティと使いやすさが低下する可能性があります。</blockquote>
  <figcaption>
  — <cite><a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">W3Cのプレースホルダー研究</a></cite>
  </figcaption>
</figure>

### 情報の必要性

ウェブサイトがユーザーから入力を収集する際には、どの情報がオプションで、どの情報が提出に必要なのかを明確に示す方法が必要です。たとえば、フォームでメールアドレスは必須フィールドである可能性がありますが、ミドルネームはオプションのフィールドになる可能性があります。HTML5が2014年に `<input>` フィールドに `required` 属性を導入する前は、必須入力フィールドのラベルにアスタリスク（*）を付けるという一般的な方法がありました。しかし、アスタリスクのみを使用することは視覚的な指標に過ぎず、フィールドが必須であることを支援技術に十分に伝える検証や情報を提供しません。

{{ figure_markup(
  image="form-required-controls.png",
  caption="必須入力が指定されている方法。",
  description="`required` 属性はデスクトップサイトの66％とモバイルサイトの67％で使用されており、`aria-required` は32％と32％で使用されています。アスタリスクは22％と22％で使用されています。`required` と `aria-required` は8％と8％で使用されています。アスタリスクと `required` は8％と9％で使用されています。アスタリスクと `aria-required` は7％と6％で使用されています。そしてすべての3つはどちらも1％で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=782719766&format=interactive",
  sheets_gid="1918657462",
  sql_file="form_required_controls.sql",
  width="600",
  height="505",
) }}

`required` 属性と `aria-required` 属性は、入力フィールドがオプションではないことを支援技術に伝える2つの方法です。`required` 属性は入力なしでのフォーム送信を防ぎますが、`aria-required` は支援技術に情報を伝えるだけで入力の検証は行いません。私たちの調査では、サイトの67％が `required` 属性を使用し、32％が `aria-required` を使用していることがわかりました。しかし、まだ22％のウェブサイトが、フィールドが必須であることを示すためにアスタリスク（*）のみを使用しています。これは、`required` と `aria-required` と一緒に使用されない限り、絶対に避けるべきです。

### キャプチャ

ウェブサイトはしばしば、訪問者が人間であり、ウェブサイトを巡回するためのさまざまな目的でプログラムされたボットではないことを確認したいと考えます。たとえば、Web Almanacは毎年、ウェブサイトから情報を収集するために同様のウェブクローラーを送り出して作成されています。このような「人間のみ」のテストはCAPTCHA -「完全自動化された公開チューリングテスト、コンピューターーと人間を区別するためのテスト」と呼ばれます。

{{ figure_markup(
  content="19%",
  caption="CAPTCHAを使用しているモバイルサイト",
  classes="big-number",
  sheets_gid="1615174635",
  sql_file="captcha_usage.sql",
) }}

検出可能な2つのキャプチャ実装のうち、19%のモバイルウェブサイトが使用しています。このタイプのテストはすべての人にとって解決が難しいかもしれません（[CAPTCHAs Have an 8% Failure Rate](https://baymard.com/blog/captchas-in-checkout)を参照）が、とくに低視力者やその他の視覚または読解に関連する障害のある人々にとってはさらに困難です。また、このようなテストは[WCAG 3.3.7 Accessible Authentication](https://w3c.github.io/wcag/understanding/accessible-authentication.html)の下でWCAG 2.2がリリースされたら失敗する可能性があります。実際、W3Cには視覚的なチューリングテストの代替案に関する[論文](https://www.w3.org/TR/turingtest/)があり、それは非常にオススメです。

## ウェブ上のメディア

ウェブ上でのメディア消費に関しては、アクセシビリティの考慮が非常に重要になります。多くのメディアは、障害のある人々が代替方法が提供されない限り消費できないような方法で設計されています。たとえば、盲目の人や視力障害のある人には、画像やビデオに対する音声説明が必要です。スクリーンリーダーは、画像やビデオを説明する代替テキストが存在する場合にのみ、音声説明を作成できます。同様に、聴覚障害のある人々にとって、ビデオのキャプションやオーディオのテキストトラックは、素材にアクセスするために不可欠です。

### 画像

{{ figure_markup(
  content="59%",
  caption="altテキストを持つ画像に対してLighthouse image-alt監査に合格したモバイルページ",
  classes="big-number",
  sheets_gid="1270834582",
  sql_file="lighthouse_a11y_audits.sql",
) }}

ウェブ上の画像は、画像の代替テキスト説明を提供する `alt` 属性を持つことができます。スクリーンリーダーは、この情報を使用して、視覚障害のある人に画像の音声説明を作成できます。私たちは、altテキストを持つ画像に関するテストに合格したサイトが59%であることを発見しました。これは2021年から1%の小さな増加です。

{{ figure_markup(
  image="pages-containing-alt-with-file-extension.png",
  caption="ファイル拡張子を含む `alt` 属性を持つページ。",
  description="2020年にはデスクトップサイトの6.8%、モバイルサイトの6.4%が `alt` 属性で拡張子を使用していました。これは2021年にデスクトップサイトの7.3%、モバイルサイトの7.1%に増加し、2022年にはデスクトップサイトの7.2%、モバイルサイトの7.5%になりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1961543902&format=interactive",
  sheets_gid="304752448",
  sql_file="alt_ending_in_image_extension.sql",
) }}

`alt` 属性のテキストは文脈に依存します。画像が装飾的で意味のある情報を提供しない場合は、`alt=""` が理想的です。しかし、画像がページの文脈にとって重要である場合は、適切なテキスト説明が不可欠です。画像がリンクの子である場合、理想的には `alt` 属性を使用してリンクをラベル付けし、ユーザーがリンク先を知ることができるようにすべきです。モバイルウェブページの7.5%とデスクトップページの7.2%で、`alt` 属性にファイル拡張子が割り当てられていることがわかりました。これはおそらく `alt` 属性が単に画像ファイル名を含んでいることを意味し、これはまったく役に立たない可能性が高く、すべての場合で避けるべきです。

{{ figure_markup(
  image="common-file-extensions-in-alt-text.png",
  caption="`alt` テキストでもっとも一般的なファイル拡張子。",
  description="altテキストで使用されるすべての拡張子の中で、`jpg` がデスクトップサイトの53％、モバイルサイトの53％で使用されており、`png` がそれぞれ34％と34％、`ico` が5％と5％、`jpeg` が3％と4％、`svg` が2％と2％、`gif` が2％と2％、`webp` が0％と1％、最後に `tif` が0％と0％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=288529525&format=interactive",
  sheets_gid="304752448",
  sql_file="alt_ending_in_image_extension.sql"
) }}

altテキストの値に明示的に含まれているトップ5のファイル拡張子（非空のalt値を持つ画像のサイトに限定）は、jpg、png、ico、jpeg、svgです。これは、CMSや他のコンテンツ管理方法が画像に代わるテキストを自動生成するか、コンテンツエディターに画像の説明を強制的に求めていることを反映している可能性があります。ただし、CMSが単に画像ファイル名を `alt` 属性に入れる場合、これはユーザーにとって何の価値も提供しないため、意味のあるテキスト説明が提供されることが重要です。

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` 属性の長さ。",
  description="デスクトップ画像の18％とモバイル画像の18％に `alt` が設定されていません。それぞれ27％と28％が空に設定されています。10文字以下に設定されているのは16％と15％、20文字以下は14％と14％、30文字以下は8％と8％、100文字以下は15％と15％、100文字を超えるものは1％と1％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1428144088&format=interactive",
  sheets_gid="877399863",
  sql_file="common_alt_text_length.sql",
) }}

デスクトップおよびモバイルウェブサイトのaltテキスト属性の27％が空であることがわかりました。空の `alt` 属性は、画像が表現的でスクリーンリーダーや他の支援技術によって説明されるべきではない場合にのみ使用されるべきです。しかし、[ウェブ上のほとんどの画像はウェブページのコンテンツに価値を加える](https://www.smashingmagazine.com/2021/06/img-alt-attribute-alternate-description-decorative/)ため、適切なテキスト説明を持つべきです。15.3％が10文字以下であることがわかりましたが、これはほとんどの画像にとって奇妙に短い説明であり、情報の平等性が達成されていないことを示しています。ただし、リンクのラベル付けに使用される場合は問題ありません。

### オーディオとビデオ

`<track>` は `<audio>` および `<video>` 要素に対してタイミングを合わせたテキストコンテンツを提供するために使用されます。これは、字幕、キャプション、説明、又は章に使用できます。キャプションは、恒久的または一時的な聴覚障害を持つ人々がオーディオコンテンツを消費することを可能にします。説明は、盲目のスクリーンリーダーユーザーがビデオ内で何が起こっているかを理解するのに役立ちます。

{{ figure_markup(
  content="0.06%",
  caption="`<audio>` 要素を持つデスクトップウェブサイトで少なくとも1つの `<track>` 要素を持つもの",
  classes="big-number",
  sheets_gid="201877037",
  sql_file="audio_track_usage.sql",
) }}

`<track>` は1つ以上のWebVTTファイルをロードし、これによりテキストコンテンツを説明しているオーディオと同期させることができます。検出可能な `<audio>` 要素があるサイトのみを見ると、デスクトップのページの0.06%、モバイルのページの0.09%のみが少なくとも1つの `<track>` 要素を持っていることがわかります。すべての `<audio>` 要素を見ると、それぞれ0.03%と0.05%だけが `<track>` を含んでいます。

{{ figure_markup(
  content="0.71%",
  caption="`<video>` 要素に対応する `<track>` 要素を持つデスクトップサイト",
  classes="big-number",
  sheets_gid="345150659",
  sql_file="video_track_usage.sql",
) }}

`<track>` 要素は、対応する `<video>` 要素と一緒に使用されることは1%未満でした。デスクトップサイトでは0.71%、モバイルサイトでは0.65%です。これらのデータポイントには、ポッドキャストやYouTubeビデオなどのコンテンツに一般的な `<iframe>` 要素を介して埋め込まれたオーディオやビデオは含まれていません。また、ほとんどの一般的なサードパーティのオーディオおよびビデオ埋め込みサービスには、同期されたテキストの代替手段を追加する機能が含まれています。

## ARIAを使用した支援技術

<a hreflang="en" href="https://www.w3.org/TR/using-aria/">Accessible Rich Internet Applications、またはARIA</a>は、障害のある人々のためにウェブコンテンツをよりアクセシブルにするためにHTML5要素に使用できる一連の属性を定義しています。しかし、ARIAの過剰使用は、アクセシビリティの改善よりも問題を引き起こす可能性があります。常に、HTML5だけでは完全にアクセシブルなエクスペリエンスを作成するのに十分でない場合にのみ、ARIA属性を使用することが推奨されます。それはネイティブのHTML5要素の代替として使用されるべきではなく、不必要に過剰使用されるべきではありません。

### ARIAの役割

支援技術が要素に遭遇すると、その要素の役割は、誰かがそのコンテンツとどのように相互作用するかに関する情報を伝えます。

たとえば、[タブ付きインターフェイス](https://inclusive-components.design/tabbed-interfaces/)は、UIの構造を適切に伝えるために、さまざまなARIAの役割を明示的に定義する必要があるもっとも一般的に使用されるUI要素の1つです。アクセシブルなタブ付きインターフェイスの一般的な実装は、[WAI-ARIAオーサリングプラクティスデザインパターン](https://www.w3.org/TR/wai-aria-practices-1.1/#tabpanel)で述べられています。タブリストウィジェットを作成する場合、コンテナー要素に `tablist` 役割を割り当てることができます。これは、ネイティブHTMLに同等のものがないためです。

HTML5は、役割を含む暗黙のセマンティクスを持つ多くの新しいネイティブ要素を導入しました。たとえば、`<nav`> 要素には暗黙の `role="navigation"` があり、この役割をARIAを介して明示的に追加する必要はありません。

{{ figure_markup(
  image="sites-using-role.png",
  caption="パーセンタイル別に使用されているARIAの役割数。",
  description="パーセンタイル別に使用されているARIAの役割数を示す棒グラフ。10パーセンタイルと25パーセンタイルでデスクトップとモバイルの両方で0役割が使用されており、50パーセンタイルで両方とも4役割が使用されています。75パーセンタイルではデスクトップで16役割、モバイルで15役割が使用されており、90パーセンタイルではデスクトップで43役割、モバイルで38役割が使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=2082926503&format=interactive",
  sheets_gid="752623932",
  sql_file="sites_using_role.sql",
) }}

現在、デスクトップページの72％に少なくとも1つのARIAの役割属性があります。中央値のサイトには `role` 属性のインスタンスが4つあります。

{{ figure_markup(
  image="top-10-aria-roles.png",
  caption="もっとも一般的なARIAの役割トップ10。",
  description="`button` がデスクトップサイトの32％、モバイルサイトの33％で使用されており、`presentation` がそれぞれ25％と24％、`dialog` が23％と22％、`navigation` が22％と22％、`search` が20％と19％、`main` が16.8％と17％、`banner` が13％と13％、`img` が13％と12％、`contentinfo` が11％と11％、最後に `none` が11％と11％で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1302320094&format=interactive",
  sheets_gid="283521996",
  sql_file="common_aria_role.sql",
  width="600",
  height="540",
) }}

2021年の29％、2020年の25％から上昇し、デスクトップおよびモバイルサイトの33％が明示的に `role="button"` を割り当てられた少なくとも1つの要素を持つホームページを持っていることがわかりました。この割合の増加はおそらく良いことではありません。これは、ウェブサイトが `<div>` や `<span>` を使用してカスタムボタンを作成しているか、または `<button>` 要素に冗長な役割を追加していることを示しています。これらはどちらも悪い実践であり、[ARIAの最初のルール](https://www.w3.org/TR/using-aria/#rule1)に反しています。このルールにしたがって、この場合は `<button>` として、可能な場合は常にネイティブHTML要素を使用する必要があります。

{{ figure_markup(
  content="21%",
  caption="少なくとも1つのリンクに `button` 役割を持つデスクトップウェブサイト",
  classes="big-number",
  sheets_gid="751886683",
  sql_file="anchors_with_role_button.sql",
) }}

ARIAの役割を追加すると、支援技術に要素は何であるかを伝えます。しかし要素はそのネイティブの同等物のように振る舞うための他の機能は提供しません。たとえば、少なくとも1つのリンクに `role="button"` を持つウェブサイトが21％ありました。この種のパターンは、リンクとボタンが異なる相互作用を持っているため、キーボードナビゲーションに問題を引き起こす可能性があります。リンクとボタンの両方がインタラクティブです、リンクはスペースキーでアクティベートされませんが、ボタンはそうです。

### presentationロールの使用

要素に `role="presentation"` が宣言されている場合、そのセマンティクスは取り除かれ、その子要素のセマンティクスも取り除かれます（子要素が必須の子要素である場合、たとえば `ul` 要素の下にネストされた `li` やテーブルの行やセルなど）。あと、親のテーブルまたはリスト要素に `role="presentation"` を宣言すると、その役割が必須の子要素にカスケードされ、それらのどれもテーブルやリストのセマンティクスを持たなくなります。

{{ figure_markup(
  content="24%",
  caption="少なくとも1つの要素に `role=presentation` を持つモバイルウェブサイト",
  classes="big-number",
  sheets_gid="283521996",
  sql_file="common_aria_role.sql",
) }}

要素のセマンティクスを削除すると、その要素は振る舞いを失います。それは視覚的にのみ存在し、支援技術はその要素の構造を理解できず、そのメッセージをユーザーに伝えることができません。たとえば、`role="presentation"` を持つリストは、スクリーンリーダーにリスト構造に関する情報を伝えなくなります。デスクトップページの25％とモバイルページの24％に、少なくとも1つの `role="presentation"` を持つ要素があることがわかりました。

{{ figure_markup(
  content="11%",
  caption="少なくとも1つの要素に `role=none` を持つモバイルウェブサイト",
  classes="big-number",
  sheets_gid="283521996",
  sql_file="common_aria_role.sql",
) }}

`role="none"` によるセマンティクスの削除も同じ効果があります。今年、`role="none"` の割合も11％に増加し、もっとも一般的なARIAの役割のトップ10に入っていることがわかりました。これが支援技術のユーザーにとくに役立つ使用例はほとんどありません。たとえば、レイアウト目的でのみ `<table>` 要素が使用されている場合です。しかし、それ以外では有害であり、慎重に使用する必要があります。

ほとんどのブラウザは、リンクや入力、または `tabindex` 属性が設定されたものなど、フォーカス可能な要素に対する `role="presentation"` と `role="none"` を無視します。また、ブラウザは、要素に `aria-describedby` などのグローバルARIAの状態やプロパティが含まれている場合、役割の含まれることも無視します。

### ARIAを使用した要素のラベリング

DOMに平行して、アクセシビリティツリーと呼ばれる類似のブラウザ構造があります。これには、HTML要素に関する情報（アクセシブルな名前、説明、役割、状態など）が含まれています。この情報は、アクセシビリティAPIを介して支援技術に伝えられます。

アクセシブルな名前は、要素のコンテンツ（ボタンのテキストなど）、属性（画像の `alt` 属性の値など）、または関連する要素（フォームコントロールのプログラムで関連付けられたラベルなど）から派生できます。複数の潜在的なソースがある場合に、要素がそのアクセシブルな名前をどこから取得するかを決定するために、特定の優先順位付けが使用されます。[Léonie Watson](https://x.com/LeonieWatson)の記事、[What is an accessible name?](https://developer.paciellogroup.com/blog/2017/04/what-is-an-accessible-name/)は、アクセシブルな名前について学ぶのに素晴らしい情報源です。

{{ figure_markup(
  image="top10-aria-attributes.png",
  caption="トップ10のARIA属性。",
  description="`aria-label` はデスクトップサイトの58%とモバイルサイトの57%で使用され、`aria-hidden` がそれぞれ58%と57%、`aria-expanded` が29%と28%、`aria-labelledby` が24%と23%、`aria-controls` が24%と23%、`aria-live` が23%と22%、`aria-haspopup` が20%と19%、`aria-current` が18%と19%、`aria-describedby` が16%と14%、最後に `aria-atomic` が11%と10%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1585975336&format=interactive",
  sheets_gid="711360879",
  sql_file="common_element_attributes.sql",
) }}

要素にアクセシブルな名前を提供するのに役立つ2つのARIA属性があります：`aria-label` と `aria-labelledby`。これらの属性は、ネイティブに派生するアクセシブルな名前よりも優先されるため、非常に慎重に、必要な場合にのみ使用する必要があります。スクリーンリーダーで得られたアクセシブルな名前をテストし、障害のある人々を巻き込んで、実際に役立つことを確認し、コンテンツをさらにアクセシブルでなくすることがないようにするのが常に良いアイデアです。

アクセシブルな名前の提供に `aria-label` 属性を使用する要素が少なくとも1つあるデスクトップページは58%、モバイルホームページは57%で、アクセシブルな名前を提供するためのもっとも人気のあるARIA属性であることがわかりました。`aria-labelledby` 属性を持つ要素が少なくとも1つあるデスクトップページは24%、モバイルページは23%でした。これは、より多くの要素がアクセシブルな名前を持つようになったことを意味するかもしれませんが、より多くの要素が視覚的なラベルを欠いていることを示している可能性もあります。これは、認知障害のある人々や音声からテキストへのユーザーにとって問題になる可能性があります（[`<label>`要素](#label要素)を参照）。

{{ figure_markup(
  image="button-name-sources.png",
  caption="ボタンのアクセシブルな名前のソース。",
  description="コンテンツがデスクトップボタンの61%とモバイルボタンの58%で使用されていることを示す棒グラフ、`aria-label` 属性がそれぞれ20%と23%で使用されており、アクセシブルな名前がないのは9%と12%、`value` 属性が10%と7%、`title` 属性が両方とも1%、関連する `aria-labelledby` 要素が両方とも0%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=561787469&format=interactive",
  sheets_gid="597786485",
  sql_file="button_name_sources.sql",
  width="600",
  height="457",
) }}

ボタンは通常、そのコンテンツまたはARIA属性からアクセシブルな名前を取得します。ARIAの最初のルールによれば、要素がARIAを使用せずにアクセシブルな名前を導出できる場合、これが望ましいです。したがって、`<button>` はARIA属性ではなく、そのテキストコンテンツからアクセシブルな名前を取得する必要があります。

デスクトップのボタンの61%とモバイルサイトの58%がコンテンツからアクセシブルな名前を取得していることがわかりました。これは良いことです。また、デスクトップサイトのボタンの20%とモバイルサイトのボタンの23%が `aria-label` 属性からアクセシブルな名前を取得していることもわかりました。

`aria-label` が役立ついくつかのケースがあります。たとえば、同じコンテンツを持つ複数のボタンがあるが、異なる目的がある場合、`aria-label` を使用してより良いアクセシブルな名前を提供できます。開発者は、ボタンに画像やアイコンのみがある場合に `aria-label` を使用することもあります。これが、モバイルサイトがコンテンツではなく `aria-label` を使用してアクセシブルな名前を定義する理由の1つかもしれません。

### コンテンツの非表示

時には視覚的インターフェイスに支援技術のユーザーにとって役に立たない冗長な要素が含まれることがあります。そのような場合には、`aria-hidden="true"` を使用してスクリーンリーダーからその要素を隠すことができます。しかし、そのような要素を省略するとスクリーンリーダーユーザーが視覚インターフェイスよりも少ない情報を得る場合には決して使用すべきではありません。支援技術からコンテンツを隠すことは、アクセシブルにするのが困難なコンテンツをスキップするために使用されるべきではありません。

{{ figure_markup(
  content="58%",
  caption="少なくとも1つの `aria-hidden` 属性を持つデスクトップウェブサイト",
  classes="big-number",
  sheets_gid="711360879",
  sql_file="common_element_attributes.sql",
) }}

`aria-hidden` 属性を持つ要素が少なくとも1つあるデスクトップページは58％、モバイルページは57％でした。コンテンツの非表示と表示は、現代のインターフェイスで一般的なパターンであり、すべての人のためにUIをすっきりさせるのに役立つことがあります。

適切なaria属性を使用して正しいメッセージを伝えることが重要です。たとえば、開示ウィジェットは `aria-expanded` 属性を使用して、コントロールがアクティブにされると何かが展開されて表示され、再度アクティブにされると隠されることを支援技術に示す必要があります。`aria-expanded` 属性を持つ要素が少なくとも1つあるデスクトップページは29％、モバイルページは28％でした。

### スクリーンリーダー専用テキスト

開発者がスクリーンリーダーユーザーに追加情報を提供するために採用する一般的な手法は、テキストの一部を視覚的に非表示にしつつスクリーンリーダーで発見可能にするCSSを使用することです。この[CSSコード](https://css-tricks.com/inclusively-hidden/)は、視覚的には隠されていますがアクセシビリティツリーに存在するように使用されます。

{{ figure_markup(
  content="15%",
  caption="`sr-only` または `visually-hidden` クラスを持つデスクトップウェブサイト",
  classes="big-number",
  sheets_gid="642136962",
  sql_file="sr_only_classes.sql",
) }}

`sr-only` と `visually-hidden` は、スクリーンリーダー専用テキストを実現するために開発者やUIフレームワークによってもっとも一般的に使用されるクラス名です。たとえば、BootstrapやTailwindはこのような要素に `sr-only` クラスを使用しています。デスクトップページの15％とモバイルページの14％にこれらのCSSクラス名のいずれかまたは両方があることがわかりました。すべてのスクリーンリーダーユーザーが完全に視覚障害者であるわけではないため、スクリーンリーダー専用ソリューションの使用を過度に行わないようにすることが重要です。

### 動的にレンダリングされるコンテンツ

DOM内の新しいコンテンツや更新されたコンテンツがスクリーンリーダーに伝えられる必要があることがあります。たとえば、フォームの検証エラーは伝える必要がありますが、遅延読み込みされた画像はそうではないかもしれません。DOMへの更新も、中断を引き起こさないように行う必要があります。

{{ figure_markup(
  content="23%",
  caption="`aria-live` を使用してライブリージョンを持つデスクトップページ",
  classes="big-number",
  sheets_gid="711360879",
  sql_file="common_element_attributes.sql",
) }}

ARIAライブリージョンを使用すると、DOM内の変更を監視し、更新されたコンテンツをスクリーンリーダーによってアナウンスできます。デスクトップページの23%（2021年の21%、2020年の17%から増加）とモバイルページの22%（2021年の20%、2020年の16%から増加）が `aria-live` を使用してライブリージョンを持っていることがわかりました。さらに、ページは暗黙の `aria-live` 値を持つ[ライブリージョンARIAの役割](https://www.w3.org/TR/wai-aria-1.1/#live_region_roles)も使用しています：

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">役割</th>
        <th scope="col">暗黙の <code>aria-live</code> 値</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>status</code></td>
        <td><code>polite</code></td>
        <td class="numeric">5.6%</td>
        <td class="numeric">5.1%</td>
      </tr>
      <tr>
        <td><code>alert</code></td>
        <td><code>assertive</code></td>
        <td class="numeric">3.7%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td><code>timer</code></td>
        <td><code>off</code></td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td><code>log</code></td>
        <td><code>polite</code></td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td><code>marquee</code></td>
        <td><code>off</code></td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ライブリージョンARIAの役割とその暗黙の `aria-live` 値を持つページ",
      sheets_gid="283521996",
      sql_file="common_aria_role.sql",
    ) }}
  </figcaption>
</figure>

[`<output>` 要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element/output)も、その内容をエンドユーザーにアナウンスする暗黙のライブリージョン役割を持つ唯一のHTML要素として特筆に値します。私たちのデータセットでは、モバイルサイトで16,144回、デスクトップで12,120回使用されているか、要素の使用率の約0.0002%です。

ライブリージョンのバリエーションや使用法についての詳細は、[MDNライブリージョンドキュメント](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/ARIA_Live_Regions)を参照するか、[Dequeによるこのライブデモ](https://dequeuniversity.com/library/aria/liveregion-playground)で遊んでみてください。

## アクセシビリティアプリとオーバーレイ

アクセシビリティオーバーレイは、ウェブサイトのアクセシビリティ問題を自動的に修正すると主張するツールです。

[オーバーレイの事実](https://overlayfactsheet.com/#what-is-a-web-accessibility-overlay)によると、これらは「ウェブサイトのアクセシビリティを改善することを目指す技術の幅広い用語です。これらはサードパーティのソースコード（通常はJavaScript）を適用し、ウェブサイトのフロントエンドコードを自動的に改善します」と定義されています。

これらのベンダーは一般的に、オンラインアクセシビリティに対して迅速かつ簡単な解決策を約束しています：1つのJavaScriptスニペットをサイトに統合して準拠させるだけです。このような箱から出してすぐに使えるソリューションでウェブアクセシビリティを達成することは単純に不可能です。自動化ツールは、そもそもアクセシビリティ問題の[30〜50%しか検出できません](https://alphagov.github.io/accessibility-tool-audit/)し、検出可能な問題に対しても、オーバーレイによる自動修正は常に信頼性を持って問題を修正できるわけではありません。

{{ figure_markup(
  image="pages-using-a11y-apps.png",
  caption="アクセシビリティアプリを使用するページ。",
  description="デスクトップサイトで1.6％、モバイルサイトで1.2％がアクセシビリティアプリを使用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1586321777&format=interactive",
  sheets_gid="667492149",
  sql_file="a11y_technology_usage.sql",
) }}

2022年に検出可能な22の特定のアクセシビリティアプリを使用するデスクトップウェブサイトは1.6%で、これは2021年の約1%に比べて明らかな上昇です。

これらの製品のすべてがアクセシビリティオーバーレイであるわけではありませんが、検出可能な特定のオーバーレイも同様の上昇を示しています。

{{ figure_markup(
  image="a11y-app-usage-by-rank.png",
  caption="ランク別のアクセシビリティアプリの使用状況。",
  description="ドメインランク別のデスクトップサイトでもっとも人気のあるアクセシビリティアプリの使用状況を示す棒グラフ。AccessiBeはトップ1,000サイトの0.13%とトップ10,000サイトの0.15%で使用され、トップ100,000サイトでは0.48%、トップ100万サイトでは0.48%、すべてのサイトでは0.37%で使用されています。AudioEyeはそれぞれ0.13%（1つ）、0.27%、0.16%、0.21%、0.35%で使用されています。EqualWebはトップ1,000サイトでは使用されていません、トップ10,000サイトの0.02%、トップ100,000サイトの0.07%、トップ100万サイトの0.05%、すべてのサイトの0.03%で使用されています。Texthelpも同様にトップ1,000サイトやトップ10,000サイトでは使用されていません、トップ100,000サイトの0.02%、トップ100万サイトの0.04%、すべてのサイトの0.03%で使用されています。最後に、UserWayはトップ1,000サイトでは使用されていませんが、トップ10,000サイトの0.07%、トップ100,000サイトの0.12%、トップ100万サイトの0.31%、すべてのサイトの0.49%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=741701117&format=interactive",
  sheets_gid="1961985994",
  sql_file="a11y_technology_usage_by_domain_rank.sql",
) }}

データセットでもっとも人気のあるオーバーレイはUserWayで、デスクトップウェブサイトの0.49%とモバイルで0.39%で使用されています。これは、2021年のそれぞれ0.39%と0.33%と比較しています。

{{ figure_markup(
  image="pages-using-a11y-apps-by-rank.png",
  caption="ランク別のアクセシビリティアプリを使用するページ。",
  description="トップ1,000サイトのデスクトップで0.4%、モバイルで0.3%、トップ10,000サイトではそれぞれ0.9%と0.8%、トップ100,000サイトでは1.2%と1.1%、トップ100万サイトでは1.4%と1.3%、すべてのサイトでは1.6%と1.2%のアクセシビリティアプリを使用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=2069674657&format=interactive",
  sheets_gid="134319036",
  sql_file="a11y_overall_tech_usage_by_domain_rank.sql",
) }}

アクセシビリティアプリ一般に、オーバーレイの使用は高トラフィックのウェブサイトではまれです。訪問者数でトップ1,000にランクされたサイトでは、わずか0.3%、つまり3つのウェブサイトがオーバーレイを使用しています。

### オーバーレイに対する懸念

オーバーレイに対しては、[アクセシビリティ擁護者](https://overlayfactsheet.com/)や[ユーザー](https://www.vice.com/en/article/m7az74/people-with-disabilities-say-this-ai-tool-is-making-the-web-worse-for-them)から多くの反発があります。National Federation of the Blindは、とくにAccessiBeの実践を[非難しています](https://nfb.org/about-us/press-room/national-convention-sponsorship-statement-regarding-accessibe)。AccessiBeは、[偽のレビューを含む](https://www.joedolson.com/2021/02/accessibe-the-fake-wordpress-plug-in-reviews/)欺瞞的なマーケティングで知られています：

> […] 当委員会は、accessiBeが現在、社会における盲人の進歩に有害な行動をとっていると考えています。
> […]
> AccessiBeは、盲目の専門家や定期的なスクリーンリーダーユーザーが何がアクセシブルで何がアクセシブルでないかを知っていることを認めていないようです。国内の盲人はなだめられたり、脅迫されたり、買収されたりすることはありません。
>
> — <a hreflang="en" href="https://nfb.org/about-us/press-room/national-convention-sponsorship-statement-regarding-accessibe">National Federation for the Blind</a>

AccessiBeは[2022年にさらに3,000万ドルを調達しました](https://www.geektime.com/accessibe-raised-30m/)が、年々使用率が明確に上昇しているオーバーレイの1つです。2021年にはデスクトップサイトの0.27%とモバイルサイトの0.21%でしたが、2022年には0.37%と0.25%に増加しました。

Adrian Roselliの[accessiBe Will Get You Sued](https://adrianroselli.com/2020/06/accessibe-will-get-you-sued.html)は、このようなオーバーレイの使用に関連する法的リスクやプライバシー問題を含む実用的な意味についての優れたリソースです。

## 結論

私たちの分析によると、ウェブサイトで見られるアクセシビリティ問題にはあまり大きな変化がありませんでした。たとえば、`:focus-visible`の採用は今年約9%増加しましたが、カラーコントラストや画像の `alt` 属性など、対処すれば大きな影響を与える可能性のある簡単な修正がまだたくさんあります。

実際には体験を損なうことが多いにもかかわらず、よりアクセシブルなものであるという錯覚を与える機能の誤用が多いことがわかります。たとえば、ウェブサイトの20%で `role=button` がアンカータグに使用されています。また、ウェブサイト全体での `alt` 属性の2.2%にファイル拡張子が含まれており、これが画像の意味を伝える上でほとんど役に立たないことはほぼ確実です。

私たちの分析で見られる多くのアクセシビリティ問題は、デザイナーや開発者が最初からウェブアクセシビリティについて考え、最後の強化としてではなく、避けることができます。[Anna E. Cookがかつて述べた](https://x.com/annaecook/status/1404615552883060737)ように、「アクセシビリティなしにMVPはない」のです。ウェブコミュニティは、ウェブサイトがすべての人にとって素晴らしいユーザーエクスペリエンスを持つためには、そのユーザーエクスペリエンスがどのデバイスや支援技術を使用していても機能する必要があることを認識する必要があります。簡単に対処できる主要なメトリクスに焦点を当ててみましたが、2023年には数字が改善されることを期待しています。
