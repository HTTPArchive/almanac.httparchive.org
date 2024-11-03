---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: アクセシビリティ
description: 読みやすさ、メディア、ナビゲーションのしやすさ、支援技術との互換性などを網羅した「2021 Web Almanac」のアクセシビリティの章です。
authors: [alextait1, scottdavis99, oluoluoxenfree, gwilhelm, kachiden]
reviewers: [ericwbailey, clottman, shantsis, estelle, GigiRajani, cdixon83]
analysts: [foxdavidj]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1WjAM5ZnHjMQt-rKyHvj2eVhU_WdzzFTjpoYWMr_I0Cw/
alextait1_bio: Alex Tait はアクセシビリティのスペシャリストで、インターフェイスアーキテクチャとデザインシステムにおけるアクセシビリティとモダンな JavaScript の交差に情熱を注いでいます。開発者として、アクセシビリティを前面に押し出したインクルージョン主導の開発手法が、すべての人にとってより良い製品につながると信じています。コンサルタントおよびストラテジストとして、「より少なく」を信条とし、障害者のためのコア機能の平等性よりも新機能の範囲拡大を優先させることはできないと考えている。また、教育者として、技術産業がより多様で公平、かつ包括的な産業となるよう、情報に対する障壁を取り除くことを信条としている。
scottdavis99_bio: Scott Davisは、著者であり、[Thoughtworks](https://www.thoughtworks.com/)のデジタル・アクセシビリティ提唱者として、ウェブ開発の最先端/革新/新興/非伝統的な側面に焦点を当てています。"デジタル・アクセシビリティは、コンプライアンスのチェックボックスを超えるものであり、アクセシビリティはイノベーションの出発点です。"
oluoluoxenfree_bio: Olu Niyi-Awosusi は[Oddbird](https://www.oddbird.net/) の JavaScript エンジニアで、リスト、新しいことを学ぶこと、Bee and Puppycat、<a hreflang="en" href="https://alistapart.com/article/building-the-woke-web/">社会正義、アクセシビリティ</a> を愛し、日々努力する人です。
gwilhelm_bio: Gary Wilhelmは、[UNC-Chapel Hill](https://www.unc.edu/)のDivision of Finance and Operationsのデジタルソリューションマネージャーで、WebサイトやWebアプリケーションの開発に従事しています。2013年から仕様書を勉強してWebサイトのアクセシビリティ化に取り組み始め、数千枚のPDF文書の改善を通じてPDFアクセシビリティの学習に多大な時間を費やすなど、それ以来アクセシビリティに関心を持ち続けています。余暇には、旅行、庭仕事、ランニング、スポーツ観戦、妻と2人のティーンエイジャーを困らせること、そして愛犬がリスやウサギ探しを手伝うことが好きだそうです。
kachiden_bio: QA、UX、フロントエンド開発、CSSとの愛憎関係、そして計り知れない量のコーヒーなど、技術者としての長く曲がりくねった道を歩んできたアクセシビリティエンジニアで猫好き。
featured_quote: ウェブ・アクセシビリティとは、機能と情報の平等性を実現することで、障害者がインターフェースのあらゆる側面に完全にアクセスできるようにすることです。デジタル製品やウェブサイトは、誰にでも使えるものでなければ、完全なものとは言えません。デジタル製品が特定の障害者を排除している場合、これは差別であり、罰金や訴訟の対象となる可能性があります。
featured_stat_1: 0.96%
featured_stat_label_1: 6万を超えるデスクトップWebサイトがアクセシビリティ・オーバーレイを使用している
featured_stat_2: 22%
featured_stat_label_2: Lighthouseのカラーコントラスト監査に合格したWebサイト
featured_stat_3: 57%
featured_stat_label_3: コンテンツからアクセス可能な名称を取得しているサイトのボタン
---

## 序章

インターネットは年々拡大し、2021年1月現在、<a hreflang="en" href="https://www.statista.com/statistics/617136/digital-population-worldwide/">46億6000万人のアクティブインターネットユーザー</a>が存在すると言われています。しかし残念ながら、この章を通して見るように、アクセシビリティはこの成長とともに実質的に改善されていません。インターネットソリューションへの依存度が高まるにつれ、ウェブに平等にアクセスできない人々の疎外感も高まっています。

2021年は、現在進行中のCOVID-19のパンデミックの2年目にあたります。COVID -19の長期的な影響により、<a hreflang="en" href="https://www.scientificamerican.com/article/a-tsunami-of-disability-is-coming-as-a-result-of-lsquo-long-covid-rsquo/">障害者人口が増加していることは明らかです</a>。COVID-19の長期的な健康への影響と同時に、パンデミックの結果、社会全体がデジタルサービスへの依存度を高めています。誰もがより多くの時間をオンラインで過ごし、より多くの必要な活動もオンラインで完了するようになったのです。<a hreflang="en" href="https://www150.statcan.gc.ca/n1/pub/45-28-0001/2021001/article/00027-eng.htm">カナダ統計局インターネット利用調査</a>によると、「15歳以上のカナダ人の75％がパンデミックの発生以来、さまざまなインターネット関連の活動に従事する頻度が増えた」という。

また、パンデミックによって商品やサービスが急速にオンラインに移行しています。<a hreflang="en" href="https://www.mckinsey.com/business-functions/strategy-and-corporate-finance/our-insights/how-covid-19-has-pushed-companies-over-the-technology-tipping-point-and-transformed-business-forever">このマッキンゼーのレポート</a>によると、「おそらくもっと驚くべきことは、デジタルまたはデジタル的に強化された提供物の作成のスピードが上がっていることです。地域別に見ると、企業がこうした[オンライン]製品やサービスを開発する割合は、平均で7年増加していることが示唆された。

ウェブ・アクセシビリティとは、機能と情報の平等性を実現することで、障害者がインターフェイスのあらゆる側面に完全にアクセスできるようにすることです。デジタル製品やウェブサイトは、誰にでも使えるものでなければ、完全なものとは言えません。デジタル製品が特定の障害者を排除している場合、これは差別であり、罰金や訴訟の対象となる可能性があります。昨年は、<a hreflang="en" href="https://info.usablenet.com/2020-report-on-digital-accessibility-lawsuits">米国障害者法に関連する訴訟が20%増加</a>しました。

悲しいことに、年々、私たちや、<a hreflang="en" href="https://webaim.org/projects/million/">WebAIM Million</a> のような分析を行う他のチームは、これらの指標にほとんど改善が見られないことを発見しています。WebAIMの調査では、ホームページの97.4%がアクセシビリティの障害を自動的に検出しており、これは2020年の監査より1%も低いものでした。

すべての<a hreflang="ja" href="https://web.dev/i18n/ja/lighthouse-accessibility/">Lighthouse Accessibility</a>監査データのサイト総合スコアの中央値は、2020年の80%から2021年の82%に上昇しました。この2％の増加は、正しい方向へのシフトを意味するものであることを期待しています。しかし、これらは自動チェックであり、開発者がルール エンジンをよりうまく破壊していることを潜在的に意味する可能性もあります。

私たちの分析は、自動化された測定基準のみに基づいているため、自動化されたテストは、インターフェイスに存在し得るアクセシビリティ・バリアのほんの一部しか捉えていないことを忘れてはいけません。アクセシブルなWebサイトやアプリケーションを実現するためには、障がい者によるマニュアルテストやユーザビリティテストなどの定性的な分析が必要です。

私たちは、もっとも興味深い洞察を6つのカテゴリーに分けました。
* 読みやすさ
* ページナビゲーションのしやすさ
* フォーム
* Web上のメディア
* ARIAによる支援技術のサポート
* アクセシビリティオーバーレイ

この章ではウェブにおける深刻な測定基準と実証されたアクセシビリティの過失を満載し、読者がこの作業を優先し、より包括的なインターネットへとシフトしていくよう、その実践を変えるきっかけになることを願っています。

<p class="note">本章では、人物優先の用語として「障害者」を使用することにしました。私たちは、多くの人がアイデンティティを優先する「障害者」という用語を好むことを認めます。私たちが選んだ用語は、どの用語が適切かを規定するものでは決してありません。</p>

## 読みやすさ

Webアクセシビリティの重要な要素として、コンテンツを可能な限りシンプルかつクリアに読めるようすることが挙げられます。ページのコンテンツが読めない場合、その情報にアクセスできないだけでなく、アカウント登録や購入などのタスクを完了することができなくなります。

色のコントラスト、ページの拡大・縮小、言語の識別など、ウェブページには読みやすさや読みにくさを左右するさまざまな要素があります。

### カラーコントラスト

<a hreflang="en" href="https://www.a11yproject.com/posts/2015-01-05-what-is-color-contrast/">色のコントラスト</a>とは、テキストやその他のページの成果物が周囲の背景に対してどの程度容易に目立つかを示すものです。コントラストが高いほど、人は内容を識別しやすくなります。<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Web Content Accessibility Guidelines</a> (WCAG) には、テキストとテキスト以外のコンテンツに対する最低限のコントラスト要件が定められています。

低コントラストのコンテンツは、色覚異常の方、軽度から中等度の視力低下の方、明るい場所で画面がまぶしいなど状況的に視聴が困難な方など、視聴困難な場合があります。

{{ figure_markup(
  image="color-contrast-2019-2020-2021.png",
  caption="十分なカラーコントラストが確保されたモバイルサイト",
  description="2019年は22.0%のサイトが十分なカラーコントラストを持ち、2020年は21.1%とやや低下し、22.2%とやや上昇したことを示す棒グラフ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1642421167&format=interactive",
  sheets_gid="51084807",
  sql_file="color_contrast.sql"
) }}

今年、Lighthouseでカラーコントラストのスコアが合格だったサイトは、わずか22%であることがわかりました。非テキストコンテンツは非常に多様であるため、これらのスキャンはテキストベースのコントラストの問題しか捉えることができないことは注目に値します。このスコアは前年とほぼ同じで、2020年は21％、2019年は22％でした。テキストベースのコントラストの問題をキャッチすることは、一般的なさまざまな自動化ツールで可能であるため、この指標はややがっかりさせられるものです。

### ズームとスケーリング

弱視の方は、ページの内容（とくに文字）を見るために、システム設定や画面拡大・縮小ソフトに頼ることがあります。Web Content Accessibility Guidelinesでは、とくにテキストは<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-scale.html">少なくとも200%</a>までリサイズできることが求められています。

[Adrian Roselli](https://x.com/aardrian) は、<a hreflang="en" href="https://adrianroselli.com/2015/10/dont-disable-zoom.html">ユーザーに対してズームが有効でない場合に生じるさまざまな害について、包括的な記事</a>を書きました。現在、多くのブラウザは開発者がズームコントロールを上書きすることを防いでいますが、世界規模でブラウザやOSの使用範囲が広いことを考慮すると、すべてのブラウザがこの動作を上書きしているとは言い切れないため、コードレベルで回避する必要があります。

{{ figure_markup(
  image="pages-zooming-scaling-disabled.png",
  caption="拡大・縮小が無効になっているページ。",
  description="棒グラフは、デスクトップサイトの16.1%とモバイルサイトの19.3%がスケーリングを無効にしており、それぞれ20.8%と25.7%が最大スケールを1、24.1%と29.4%がどちらかを使用していることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=2099068658&format=interactive",
  sheets_gid="744885125",
  sql_file="viewport_zoom_scale.sql"
) }}

デスクトップ用ホームページの24％とモバイル用ホームページの29％が、`maximum-scale`を1以下に設定するか、`user-scalable`を`0`または`none`に設定して、スケーリングを無効にしようとしていることがわかりました。

{{ figure_markup(
  image="pages-zooming-scaling-disabled-by-rank.png",
  caption="ランクによってズームや拡大縮小が無効になっているページ。",
  description="棒グラフは上位1,000サイトでは、デスクトップサイトの22.4%、モバイルサイトの45.0%がズームとスケーリングを無効にしており、上位1万サイトで、それぞれ27.0%と40.5%、上位10万サイトでは26.2%と34.1%、トップミリオンでは25.2%と30.4%、最後にすべてのサイトでは24.1%と29.4%となっていることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1312122950&format=interactive",
  sheets_gid="645664156",
  sql_file="../mobile-web/viewport_zoom_scale_by_domain_rank.sql"
) }}

とくに人気のあるサイトについて考えてみると、モバイルの数字が気になります。トラフィックの多い上位1,000サイトのうち、デスクトップサイトの22％、モバイルサイトの45％に、ユーザーのスケーリングを無効化しようとするコードがあります。これは、Webアプリケーションの普及から来る傾向かもしれません。人々は、コンテンツがWebサイトかWebアプリケーションかにかかわらず、Webブラウジングの体験（ズームや拡大縮小など）をカスタマイズできるようにする必要があるのです。

### 言語の識別

{{ figure_markup(
  caption="モバイルサイトでは、有効な `lang` 属性があります。",
  content="80.5%",
  classes="big-number",
  sheets_gid="2009310389",
  sql_file="valid_html_lang.sql"
)
}}

HTMLの `lang` 属性を設定することで、ページの翻訳が容易になり、スクリーン・リーダーのサポートが向上し、一部のスクリーン・リーダーが読み上げるテキストに適切なアクセントや抑揚を適用することができるようになります。今年は、`lang`属性が存在するサイトの割合が81%（2020年の78%から増加）となり、属性が存在するサイトのうち、99.7%が有効な`lang`属性を持っていました。

### 文字サイズと行の高さ

最小フォントサイズや行の高さに関しては、WCAGからの具体的な要求はありません。しかし、<a hreflang="en" href="https://accessibility.digital.gov/visual-design/typography/">基本のフォントサイズを16px</a>以上にすれば、誰もが読みやすくなるというのが一般的な見解です。とくに弱視の方。 ただし、[テキストを200%まで拡大・縮小できる](#ズームとスケーリング)という要件があります。また、ユーザーはブラウザレベルで独自の最小フォントサイズを設定することができ、これらのカスタマイズ設定にも対応する必要があります。

{{ figure_markup(
  image="pages-overriding-focus-styles.png",
  caption="フォント単位の使用状況。",
  description="棒グラフは、デスクトップ用ページの68.4％とモバイル用ページの69.0％で`px`が、それぞれ16.7％と16.4％で`em`が、5.0％と5.4％で`%`、5.5％と5.2％で`rem`、2.3％と2.1％で`<number>`、最後の1.8％と1.6％で`pt`が使用されていることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1495101594&format=interactive",
  sheets_gid="1740727138",
  sql_file="../css/units_properties.sql"
) }}

フォントが `px` 単位で宣言されている場合、それらは静的なサイズである。ブラウザを拡大したときにフォントが適切に拡大縮小されるようにするには、<a hreflang="en" href="https://www.24a11y.com/2019/pixels-vs-relative-units-in-css-why-its-still-a-big-deal/">`em`や`rem`などの相対単位</a>を使用するのがもっともよい方法です。デスクトップのフォントサイズ宣言の68%は`px`単位で、17%は`em`単位で、5%は`rem`単位で設定されていることがわかった。

### フォーカススタイル

ビジブルフォーカススタイルは誰にとっても便利ですが、その存在に依存してナビゲートする目の見えるキーボードユーザーにとっては必要なものです。WCAGでは、すべての対話型コンテンツに <a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-focus-visible.html">視認性の良いフォーカスインジケーター</a> を要求しています。

{{ figure_markup(
  image="pages-overriding-focus-styles.png",
  caption="フォーカススタイルをオーバーライドするページ。",
  description="デスクトップサイトの92.6%、モバイルサイトの94.1%が `:focus` 擬似クラスを使用しており、デスクトップサイトの90.0%、モバイルサイトの91.0%がその `:focus` 擬似クラスを使ってアウトラインを0またはゼロに設定しているという棒グラフです。デスクトップサイトの0.6%、モバイルサイトの0.6%は `:focus-visible` 疑似クラスを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1277337070&format=interactive",
  sheets_gid="1517955087",
  sql_file="../css/focus_outline_0.sql"
) }}

ボタンやフォームコントロール、リンクなどのインタラクティブなコンテンツでは、CSSプロパティ `:focus { outline: none; }` や `:focus { outline: 0; }` を用いて、時には `:focus-within` や `:focus-visible` と共に、デフォルトのフォーカス表示を解除することがよくあります。デスクトップページの91%に`:focus { outline: 0; }`が宣言されていることがわかりました。場合によっては、より効果的なカスタムスタイルを適用できるように、この宣言は削除されます。残念ながら、多くの場合、単に削除されただけで置き換えられることはなく、キーボード・ユーザーにとって使い勝手の悪いページになってしまいます。

ブラウザのデフォルトのフォーカススタイルのいくつかの制限を含む、アクセシブルなフォーカス表示を実現する方法の詳細については、[Sara Soueidan](https://x.com/SaraSoueidan) の記事、<a hreflang="en" href="https://www.sarasoueidan.com/blog/focus-indicators/">"A guide to designing accessible, WCAG-compliant focus indicators"</a> がオススメです。

### ユーザー嗜好のメディアクエリ、ハイコントラストへの対応

2020年に公開された<a hreflang="en" href="https://www.w3.org/TR/mediaqueries-5">CSSメディアクエリ レベル5仕様</a>では、ユーザーがウェブサイト自体の外で設定したアクセシビリティ機能をウェブサイトが検出できるようにする_User Preference Media Features_というコレクションが導入されました。これらの機能は、通常、オペレーティング システムやプラットフォームの環境設定によって構成されます。

{{ figure_markup(
  image="userpreference-media-queries.png",
  caption="ユーザー嗜好のメディアクエリ。",
  description="棒グラフは、デスクトップとモバイルサイトの31.6％が`prefers-reduced-motion`メディアクエリを使用し、デスクトップサイトの5.7％とモバイルサイトの7.1％が`prefers-color-scheme`、`prefers-contrast`の使用がどちらも非常に小さいため、0.0％に見えることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=168171508&format=interactive",
  sheets_gid="1027210289",
  sql_file="../css/media_query_features.sql"
) }}

[`prefers-reduced-motion`](https://developer.mozilla.org/docs/Web/CSS/@media/prefers-reduced-motion) は、ウェブ制作者がウェブページ上のアニメーションやその他の動きのあるソースを通常はコンテンツを削除したり、置き換えたりして、より静的な体験へ置き換えるために使用します。 これは、画面上の速い動きによって注意力が散漫になったり、その他の誘因を受けたりするさまざまな人々を助けることができます。32%のウェブサイトが `prefers-reduced-motion` メディアクエリを使用していることがわかりました。

`prefers-reduced-transparency` は、エンドユーザーがオペレーティングシステムに半透明や透明効果を最小化または除去するように依頼したことを示します。このアフォーダンスは、エンドユーザーが読解を助けるため、あるいは視覚障害のあるユーザーに悪影響を与える可能性のある一般的な「ハロー効果」を避けるためオンにされるかもしれません。この比較的新しいメディアクエリの使用に関するデータはありません。

[`prefers-contrast`](https://developer.mozilla.org/docs/Web/CSS/@media/prefers-contrast) (`high` または `low`) は、エンドユーザーが [ハイコントラストかローコントラスト](#カラーコントラスト) のコントラストテーマを好むことを示唆します。読解力や眼精疲労に効果が期待できます。この比較的新しいメディアクエリの使用に関するデータはありませんが、25%のウェブサイトが[`ms-high-contrast`](https://developer.mozilla.org/docs/Web/CSS/@media/-ms-high-contrast)を使用しており、Windows特有のコントラスト優先の処理方法であることがわかっています。

[`prefers-color-scheme`](https://developer.mozilla.org/docs/Web/CSS/@media/prefers-color-scheme) (`light` または `dark`) は、ユーザーが暗い背景の体験に明るい色を要求したり、その逆を行うことができるようにします。User Preference Media Queriesの中でもっとも早く導入されました。この機能は通称「ダークモード」対応と呼ばれ、2019年に<a hreflang="en" href="https://en.wikipedia.org/wiki/Light-on-dark_color_scheme#History">AppleがiOS 13とiPadOSで標準化</a>したことにより一躍有名になりましたが、それ以前からアクセシビリティ機能としては一般的な機能となっていました。

ダークモードはアクセシビリティのアフォーダンスとして多くの開発者やデザイナーに認識されていますが、実際には特定のユーザーにとってアクセシビリティを低下させる可能性があることに注意することが重要です。<a hreflang="en" href="https://www.boia.org/blog/dark-mode-can-improve-text-readability-but-not-for-everyone">失読症や乱視の人の中には、暗い背景に明るいテキストは読みにくく</a>、ハロー効果を悪化させると感じる人がいるかもしれません。ここで重要なことは、ユーザーに最適なものを選んでもらうことです。7%のウェブサイトが `prefers-color-scheme` メディアクエリを使用していることがわかりました。

## ページ移動のしやすさ

ウェブコンテンツを閲覧することは、私たちがオンラインに関わる基本的な方法の1つであり、これを実現する方法は数多くあります。人によっては、マウスでスクロールしながら、ページを視覚的にスキャンすることもあります。また、スクリーンリーダーを使ってページの見出しを操作することから始める人もいるかもしれません。ユーザーが迷ったり、探しているコンテンツを見つけられないということがないように、ウェブサイトは簡単に操作できる必要があります。

### ランドマークとページ構成

ランドマークとは、HTMLの指定要素、または他のHTML要素に適用できるARIAの役割で、支援技術を必要とする障害者がページ全体の構造やナビゲーションをすばやく理解できるようにするためのものです。たとえば、<a hreflang="en" href="https://webaim.org/articles/voiceover/mobile#rotor">ローターメニュー</a>は、ページの異なるランドマークへ移動するために使うことができ、また[skip link](#リンクをスキップする) は `<main>` ランドマークへ移動するために使うことができます。

HTML5導入以前は、これを実現するためにARIAのランドマークロールが必要でした。しかし、現在では、ランドマークページの構造の大部分を達成するために、ネイティブのHTML要素が利用できるようになっています。ネイティブのHTMLランドマーク要素を活用することは、ARIAロールを適用するよりも望ましいことです。<a hreflang="en" href="https://www.w3.org/TR/using-aria/#rule1">ARIAの最初の規則</a>に従います。詳しくは、この章の[ARIAロール](#ariaロール)の節を参照してください。

<figure>
  <table>
    <thead>
      <tr>
        <th>HTML5 <br>要素</th>
        <th>ARIAロール <br>と同じ</th>
        <th>要素 <br>のあるページ</th>
        <th>ロール <br>のあるページ</th>
        <th>要素またはロール <br>のあるページ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`<main>`</td>
        <td>`role="main"`</td>
        <td class="numeric">27.68%</td>
        <td class="numeric">16.90%</td>
        <td class="numeric">35.00%</td>
      </tr>
      <tr>
        <td>`<header>`</td>
        <td>`role="banner"`</td>
        <td class="numeric">62.13%</td>
        <td class="numeric">14.34%</td>
        <td class="numeric">63.49%</td>
      </tr>
      <tr>
        <td>`<nav>`</td>
        <td>`role="navigation"`</td>
        <td class="numeric">61.69%</td>
        <td class="numeric">22.79%</td>
        <td class="numeric">65.53%</td>
      </tr>
      <tr>
        <td>`<footer>`</td>
        <td>`role="contentinfo"`</td>
        <td class="numeric">63.35%</td>
        <td class="numeric">12.21%</td>
        <td class="numeric">64.52%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="ランドマーク要素とロールの使い方（デスクトップ）。",
    sheets_gid="1736231238",
    sql_file="landmark_elements_and_roles.sql"
  ) }}</figcaption>
</figure>

ウェブページの大半が持つべきランドマークとして、もっとも一般的に期待されているのは、`<main>`、`<header>`、`<nav>`、`<footer>`です。デスクトップページの28%だけがネイティブなHTMLの `<main>` 要素を持ち、17%が `role="main"` の要素を持ち、35%がどちらかの要素を持つことがわかりました。

たとえば、プライマリーサイトナビゲーションとパンくずセカンダリーナビゲーションなど、1つのページに同じランドマークが複数ある場合、それぞれに一意のアクセス可能な名前を付けることが重要です。これにより、支援技術を必要とする障害者は、どのナビゲーションランドマークに遭遇したかをよりよく理解できるようになります。これを実現するためのテクニックは、<a hreflang="en" href="https://www.scottohara.me/blog/2018/03/03/landmarks.html">さまざまなランドマークと、異なるスクリーン リーダーのナビゲーション方法</a>に関する [Scott O'Hara](https://x.com/scottohara) の総合記事に網羅されています。

### ドキュメントタイトル

説明的なページタイトルは、コンテキストが変更されると通知されるため、支援技術を使ってページ、タブ、ウィンドウ間を移動する際のコンテキストに役立ちます。

{{ figure_markup(
  image="page_title-information.png",
  caption="Title要素の統計",
  description="デスクトップサイトの98.2%、モバイルサイトの98.1%が`<title>`要素を使用しており、そのうちの68.5%、69.3%が4文字以上のタイトルで、レンダリング時に変更されるのはデスクトップ、モバイルともに4.1%という棒グラフが示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=467029485&format=interactive",
  sheets_gid="1437437016",
  sql_file="page_title.sql"
) }}

当社のデータでは、98％のウェブページにタイトルがあります。しかし、そのうち4語以上のタイトルを持つページは68%に過ぎず、かなりの割合のウェブページが、ページの内容に関する十分な情報を提供するユニークで意味のあるタイトルを持っていない可能性があります。

### セカンダリーナビゲーション

多くのユーザーは、Webサイトで探しているコンテンツを見つけるために、二次的なナビゲーションの方法を利用しています。<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-mult-loc.html">WCAGは、複雑なウェブサイトには二次的なナビゲーション手段を設けることを要求しています</a>。もっとも一般的で有用なセカンダリーナビゲーションの方法のひとつに、検索メカニズムがあります。全サイトの24％が検索入力を使っていることがわかりました。

また、セカンダリーナビゲーションの方法として、サイトマップというWebサイト上のすべてのリンクを明確に整理したコレクションを実装する方法もあります。サイトマップの存在に関するデータはありませんが、この<a hreflang="en" href="https://www.w3.org/TR/WCAG20-TECHS/G63.html">W3Cによるテクニックガイド</a>では、サイトマップとは何か、どのようにすれば効果的に実装できるかについて詳しく説明されています。

### タブインデックス

`tabindex` は、要素に追加することで、その要素にフォーカスを当てることができるかどうかを制御することができる属性です。その値によって、その要素はキーボードフォーカス、つまり「タブ」順になることもできます。

`tabindex` の値が `0` の場合、その要素はプログラム的にフォーカス可能で、キーボードフォーカスの順番になることができます。ボタン、リンク、フォームコントロールなどのインタラクティブコンテンツは `tabindex` 値が `0` と同等であり、キーボードフォーカスの順番がネイティブであることを意味します。

インタラクティブでキーボードフォーカスの順番を意図したカスタム要素やウィジェットは、明示的に `tabindex="0"` を割り当てる必要があり、そうしないとキーボードで使用できなくなります。

もしある要素がフォーカス可能であるべきだが、キーボードフォーカスの順番にない場合、 `tabindex`値の`-1`（あるいは任意の負の整数）をフックとして使うことで、キーボードフォーカスの順番に加えずJavaScriptでプログラム的にその要素にフォーカスできるようにできます。これは、フォーカスを割り当てたい場合に便利です。たとえば、[Marcy Sutton](https://x.com/marcysutton) が <a hreflang="en" href="https://www.gatsbyjs.com/blog/2019-07-11-user-testing-accessible-client-routing/">post on accessible client-side routing techniques</a> で取り上げた、単一ページのアプリケーションで新しいページに移動するとき見出しへフォーカスを当てるような場合などです。キーボードのフォーカス順に非インタラクティブ要素を配置すると、視覚障害者が混乱するため、避けるべきです。

ページのフォーカス順序は、常にドキュメントフロー、つまりドキュメント内のHTML要素の順序で決定されるべきです。`tabindex`に正の整数を設定すると、ページの自然な順序が上書きされ、しばしば<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-focus-order.html">WCAG 2.4.3 - Focus Order</a>の失敗を招きます。一般に、ページの自然なフォーカス順序を尊重することは、キーボードのフォーカス順序を過剰に操作するよりも、よりアクセシブルな体験につながります。

その結果、デスクトップサイトの58％、モバイルサイトの56％が、`tabindex`属性を何らかの形で利用していることがわかりました。

{{ figure_markup(
  image="tabindex-usage-and-values.png",
  caption="`tabindex` の使用状況",
  description="`tabindex`を使用しているページのうち、デスクトップでは96.9%、モバイルで97.4%がマイナスまたはゼロの`tabindex`を使用し、68.2%と68.3%が0の`tabindex`、74.2%と73.3%がマイナスの`tabindex`、最後に8.7%と7.7%がプラスの`tabindex`を使用し、棒グラフになっていることが示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=632373616&format=interactive",
  sheets_gid="1330777562",
  sql_file="tabindex_usage_and_values.sql"
) }}

少なくとも1つの `tabindex` 属性のインスタンスを持つデスクトップページを見ると

* 96.9%は`0`の値を使用しており、これは要素がフォーカス可能で、キーボードフォーカスの順番に追加されることを意味します。
* 68.2%が負の整数を使用、つまりキーボードのフォーカス順から明示的に要素を削除
* 8.7%は正の整数値であり、ウェブ制作者がDOM構造に任せるのではなく、フォーカスの順番をコントロールしようとしていることを意味します。

`tabindex`属性には有効な宣言がありますが、これらのテクニックに誤って手を出すと、多くのキーボードや支援技術を必要とする障害者にとって共通のアクセシビリティの障害になります。正の整数を `tabindex` に使うことの落とし穴については、 [Karl Groves](https://x.com/karlgroves) の記事、 <a hreflang="en" href="https://karlgroves.com/2018/11/13/why-using-tabindex-values-greater-than-0-is-bad">"0以上の`tabindex`値を使用することが悪い理由"</a> がオススメです。

### リンクをスキップする

キーボードに頼った操作をする人のために、スキップリンクを用意しました。複数のページで繰り返されるコンテンツのセクションやナビゲーションセクションをスキップして、別の目的地、通常はページの `<main>` 要素に移動できます。スキップリンクは通常、ページの最初の要素であり、UIで永続的に表示するか、キーボードフォーカスがあるまで目に見えるように隠すことができます。たとえば、多くのインタラクティブなコンテンツ（リンクでいっぱいの堅牢なナビゲーションシステムなど）は、画面のメインコンテンツへ到達する前にタブで移動するのが非常に面倒で、とくにこれらが複数のページにわたって繰り返される傾向があります。

情報量の多いサイトでは、ユーザーがよくアクセスする場所にジャンプできるように、スキップリンクをいくつか用意しているところもあります。たとえば、<a hreflang="en" href="https://www.canada.ca/">カナダ政府のウェブサイト</a>には、「メインコンテンツへスキップ」「政府についてへスキップ」「基本HTMLバージョンへ切り替え」の3つがあります。

スキップリンクは、<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/bypass-blocks.html">ブロックのバイパス</a>とみなされます。しかし、デスクトップとモバイルのサイトの20％_近く_がスキップリンクを使用している可能性が、あることがわかりました。これは、ページの最初の3つのリンクのうち1つに `href="#main"` 属性があるかどうかを調べることで判断しました。これは、スキップリンクの一般的な実装です。

### 見出しの階層

見出しは、スクリーンリーダーがページを適切に操作できるよう、目次のような階層を提供します。

{{ figure_markup(
  caption="モバイルサイトは、見出しの順序が適切かどうかのLighthouse監査に合格しています。",
  content="58%",
  classes="big-number",
  sheets_gid="461215072",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

私たちの監査では、チェックしたサイトの58%が、<a hreflang="ja" href="https://web.dev/i18n/ja/heading-order/">見出しテスト</a> で、レベルを飛ばさないテストに合格していることがわかりました。<a hreflang="en" href="https://webaim.org/projects/screenreadersurvey9/#heading"> WebAIMが2021年に調査したスクリーン リーダーのユーザーの</a> 85% 以上が、ウェブのナビゲーションに見出しが役に立つと回答しています。見出しを正しい順序で表示すること、つまり、レベルを飛ばすことなく昇順に表示することは、支援技術を必要とする障害者が最高の体験をすることを意味します。

### テーブル

テーブルは、データを2軸の関係で効率的に表示することができるため、比較検討などに有効です。支援技術を必要とする障害者は、ユーザーが効果的にナビゲートし、理解し、対話できるように機械可読構造を提供する特定のテーブルマークアップに依存しています。

テーブルは、キャプション、適切なヘッダーとフッター、すべてのデータセルに対応するヘッダーセルを含む、適切な要素と定義された関係を持つ整形された構造である必要があります。スクリーンリーダーのユーザーは発表された内容を通じて、このような明確に定義された関係に依存しているため、不完全または不正確に宣言された構造は、誤解を招いたり、情報が欠落したりする可能性があります。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">表サイト</th>
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
        <td class="numeric">4.6%</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>プレゼン用テーブル</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="アクセシブルなテーブルの使用状況。",
    sheets_gid="1802381033",
    sql_file="table_stats.sql"
  ) }}</figcaption>
</figure>

### テーブルキャプション

テーブルのキャプションは、テーブル全体の見出しとして機能し、その情報の要約を提供します。テーブルにラベルを付ける場合、`<caption>` 要素はスクリーン・リーダーのユーザーにもっとも多くのコンテキストを提供する正しい意味での選択ですが、[テーブルのための他の代替キャプション技術](https://www.w3.org/WAI/tutorials/tables/caption-summary/) もあることに注意すべきです。

テーブル全体の見出し要素は、`<caption>` 要素が適切に実装されていれば、しばしば不要となり、`<caption>` 要素は見出しに似たスタイルと視覚的な位置づけが可能です。テーブル要素が存在するデスクトップとモバイルのサイトのうち、`<caption>`を使用しているのはわずか5%で、2020年からわずかに増加しました。

### レイアウト用テーブル

<a hreflang="en" href="https://www.w3schools.com/css/css3_flexbox.asp">Flexbox</a> や <a hreflang="en" href="https://www.w3schools.com/css/css_grid.asp">Grid</a> などのCSSメソッドの導入は、ウェブ開発者が簡単に流体対応のレイアウトを作成できるようにする機能を提供したのです。<a hreflang="en" href="https://www.w3schools.com/css/css3_flexbox.asp">Flexbox</a> や <a hreflang="en" href="https://www.w3schools.com/css/css_grid.asp">Grid</a> などのCSSメソッドの導入は、ウェブ開発者が簡単に流動的なレスポンシブレイアウトを作成できる機能を提供したのです。それ以前は、テーブルをデータの表示ではなく、レイアウトのために使うことが多かった。残念ながら、レガシーなWebサイトやレガシーな開発手法の組み合わせにより、レイアウトにテーブルを使用しているWebサイトがまだ存在しています。このレガシーな開発手法が今もどの程度使われているのか、判断するのは難しい。

この技術に手を伸ばす絶対的な必要がある場合、支援技術がテーブルのセマンティクスを無視するように、`プレゼンテーション`の役割をテーブルに適用する必要があります。デスクトップとモバイルのページの1％が、プレゼンテーションの役割を持つテーブルを含んでいることがわかりました。これが良いことなのか悪いことなのか、判断がつきません。これは、プレゼンテーション用のテーブルが少ないということもありますが、レイアウト用のテーブルが不足しているだけである可能性が高いのです。

### タブ

タブは非常に一般的なインターフェイスウィジェットですが、それをアクセシブルにすることは多くの開発者にとって課題となっています。アクセシブルな実装のための一般的なパターンは、<a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/#tabpanel">WAI-ARIAオーサリングプラクティスのデザインパターン</a> に由来しています。ARIAオーサリングプラクティス文書は仕様書ではなく、一般的なウィジェットに対するARIAの理想的な使い方を示すことを意図していることに注意してください。これらは、ユーザーによるテストなしに実運用で使用すべきではありません。

オーサリングプラクティスのガイドラインでは、常に`tabpanel`ロールと`role="tab"`を組み合わせて使用することを推奨しています。デスクトップページの8％が `role="tablist"` を持つ要素を持ち、7％が `role="tab"` を持つ要素を持ち、6％が `role="tabpanel"` を持つ要素を持つことが分かっています。詳しくは、以下の[ARIAロール](#ariaロール)の項をご覧ください。

### キャプチャ

一般公開されているWebサイトには、人間とWebを巡回するコンピューターの2種類の訪問者が定期的に訪れます。人間の訪問者を惹きつけるために、ウェブサイトは検索エンジンに大きく取り上げられることを望みます。検索エンジンはクローラーと呼ばれる自動化されたプログラムを送り込み、ウェブサイトを訪問し、見て回り、その結果を検索エンジンに報告し、コンテンツを分類・整理している。

たとえばWeb Almanacは、毎年、同様のウェブクローラーを派遣して、約800万種類のウェブサイトの情報を収集し、作成しています。そして、その結果を著者が要約し、読者に提供します。

Webサイトが、訪問者が人間であることを確認したい場合、Web制作者は、人間が理論的にパスでき、コンピューターがパスできないテストを設置するテクニックを用いることがあります。このような「人間限定」のテストは、キャプチャと呼ばれます。「コンピューターと人間を区別するための完全に自動化された公開チューリングテスト」です。

{{ figure_markup(
  caption="キャプチャを使用したデスクトップサイト",
  content="10.2%",
  classes="big-number",
  sheets_gid="1059643233",
  sql_file="captcha_usage.sql"
)
}}

デスクトップとモバイルの両方で、訪問したウェブサイトのおよそ10％にキャプチャが、あることがわかりました。

キャプチャには、アクセシビリティを阻害する可能性のあるものが多数存在します。たとえば、もっとも一般的なキャプチャの1つは、波打った歪んだテキストの画像を表示し、そのテキストを解読して入力するようユーザーに要求します。この種のテストは、誰にとっても解きにくいものですが、弱視やその他の視覚・読書関連の障害を持つ人にとっては、より困難なものになると思われます。<a hreflang="en" href="https://baymard.com/blog/captchas-in-checkout">あるユーザビリティ調査では、およそ3人に1人のユーザーがキャプチャの解読に失敗していることが分かっています</a>。

もしキャプチャが[altテキスト](#代替テキストの概要) を含んでいれば、答えはプレーンテキストとして提供されるので、コンピューターがテストをパスすることは些細なことでしょう。しかし、altテキストを含めないことで、キャプチャはスクリーンリーダーやそれを使用する視覚障害者を排除していることになります。

キャプチャがもたらすアクセシビリティの障壁については、W3Cの論文をオススメします。<a hreflang="en" href="https://www.w3.org/TR/turingtest/">「キャプチャにアクセスできない：Webでのビジュアルチューリングテストの代替案」</a>。

論文より「セキュリティソリューションとしてキャプチャを使うことは、ますます効果がなくなってきていることを認めることが重要である。2段階認証やマルチデバイス認証などの代替セキュリティ手法や、高い信頼性で人間のユーザーを識別する新しいプロトコルも、セキュリティとアクセス性の両方の理由から、従来の画像ベースのキャプチャ手法よりも優先して慎重に検討すべきである。」

## フォーム

フォームは、ウェブへのアクセスを左右するものであり、それはますます社会参加や必要不可欠なサービスへのアクセスを意味するようになっています。多くの人が銀行、食料品の買い物、飛行機の予約、予約のスケジュール、仕事など、さまざまな活動をオンラインで行っています。

COVID-19の大流行の影響により、2021年には数百万人の子どもたちがオンラインで学校へ通うようになりました。これらのサービスはすべて、最低でも登録とサインインのためのフォームを必要とし、多くは財務情報など他の機密情報を必要とする、より複雑なフォームを持っています。アクセスできないフォームは差別的であり、深刻な被害をもたらす可能性があります。

2019年に英国で行われたクリック・アウェイ・パウンドの調査は、「障害者のオンラインショッピング体験を探り、障害者の買い物客を無視した場合のビジネスへのコストを検証する」ことを目的としています。その結果、英国企業はウェブサイトのアクセシビリティの障壁のために放棄されたショッピングカートで170億ポンド以上の売上を逃すことがわかりました。利益が障害者の権利を尊重する第一の理由であってはなりませんが、ビジネスケースは非常に充実しています。

### `<label>` 要素

HTMLフォームをアクセシブルにするもっとも重要な方法の1つは、`<label>`要素を使って、[フォームコントロール](https://developer.mozilla.org/docs/Learn/Forms/Basic_native_form_controls)を説明する短い記述テキストをプログラムでリンクさせることです。これは通常、 `<label>` 要素の `for` 属性とフォームコントロール要素の `id` 属性をマッチングさせることで行われます。たとえば

```html
<label for="first-name">First Name</label>
<input type="text" id="first-name">
```

ウェブ開発者が `<label>` 要素を入力に関連付けない場合、そうでなければ無料で手に入るはずの多くの重要な機能を逃していることになるのです。たとえば、 `<label>`が `<input>`フィールドに適切に関連付けられている場合、 `<label>`をタップまたはクリックすると自動的に `<input>`フィールドにフォーカスが移ります。 これは、ユーザビリティの大きなメリットであるだけでなく、Web上で期待される動作でもあります。

{{ figure_markup(
  image="form-input-name-sources.png",
  caption="入力のアクセス可能な名称はどこから来るのか",
  description="デスクトップの入力要素の33.0%、モバイルの入力要素の32.7%にアクセシブルネームがないことを示す棒グラフです。`relatedElement: label`は、デスクトップページの27.2％、モバイルページの27.4％がソースとなっています。`placeholder`ではそれぞれ24.9%と25.3%、`attribute: aria-label`では6.7%と6.9%、`attribute: value`ではどちらも3.9%、`attribute: title`では1.9%と1.8%、`attribute: alt`では1.0%と0.8%, `relatedElement: aria-labelledby` は0.7%と0.8%, `attribute: type` は0.6%と0.5%, `contents` と `relatedElement: aria-labeledby` は小さすぎるので0.0%として表示されています.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1447032816&format=interactive",
  sheets_gid="1517205301",
  sql_file="form_input_name_sources.sql",
  width=600,
  height=537
) }}

`<label>` 要素は、1999年のHTML4で導入されました。過去20年以上にわたってすべてのモダンブラウザで利用可能であるにもかかわらず、すべての `<input>` 要素のうち、プログラムによって関連付けられたラベルからアクセス可能な名前を得るのは27%のみで、32%の入力要素には [アクセス可能な名前](#ariaによる要素のラベリングと説明) がまったくありません。

もっとも重要なことは適切なアクセス可能な名前がないと、スクリーン・リーダーや音声合成の利用者が、フォーム・フィールドの目的を狙ったり、特定したりできない可能性があることです。入力に関連する `<label>` 要素は、これを行うためのもっとも強固で期待できる方法です。

これは、エンドユーザーがはじめてフォームに入力するときだけでなく、フォームの検証で特定のフィールドにエラーが見つかり、ユーザーがフォームを送信する前に修正しなければならない場合にも同様に重要なことです。たとえば、クレジットカードの有効期限を記入し忘れた場合、ユーザーは購入手続きを行うことができません。また、入力漏れのあるフィールドを見つけ、入力の目的とエラーを修正するために必要な手順の両方を理解できなければ、購入を完了することはできません。

### 入力のラベル付けに `placeholder` 属性の不適切な使用について

2014年にHTML5で導入された`placeholder`属性。その使用目的は、ユーザーから提供されることが予想されるデータの例を提供することです。たとえば、`<input type="text" id="credit-card" placeholder="1234-5678-9999-0000">` は入力フィールドにプレースホルダーをかすかなテキストとして表示し、ユーザーがフィールドに入力を始めた瞬間に消えます。

{{ figure_markup(
  image="placeholder-but-no-label.png",
  caption="入力にプレースホルダーを使用。",
  description="デスクトップサイトの57.8％、モバイルサイトの55.7％がプレースホルダーを使用していることを示す棒グラフです。デスクトップ用サイトの69.2%、モバイル用サイトの69.7%で、ラベルのない入力項目があります。デスクトップ用サイトの63.4％、モバイル用サイトの64.8％が、プレースホルダーとラベルのない入力項目を備えています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1871025491&format=interactive",
  sheets_gid="743455437",
  sql_file="placeholder_but_no_label.sql"
) }}

`<label>` 要素の代わりにプレースホルダーを使うという不適切な使い方は、驚くほど多く見受けられます。今年の調査では、デスクトップおよびモバイルWebサイトの約58％が`placeholder`属性を使用していました。 これらのサイトのうち、65％近くが `placeholder`属性を含み、プログラムで関連付けられた`<label>`要素を含めることができませんでした。

<a hreflang="en" href="https://www.smashingmagazine.com/2018/06/placeholder-attribute/">プレースホルダーのテキストがもたらす多くのアクセシビリティの問題</a>が存在します。たとえば、ユーザーが入力を始めると消えてしまうため、認知障害のある人は、フォーム要素の目的に対する文脈を見失う可能性があります。

<a hreflang="en" href="https://html.spec.whatwg.org/#the-placeholder-attribute">HTML5仕様</a>には、"placeholder属性はラベルの代わりとして使用してはならない "と明確に記載されています。

<a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">W3Cのプレースホルダー調査</a> は、意味的に正しい `<label>` 要素の代わりにプレースホルダーを使うという欠陥のある設計手法に反対する、26の異なる記事をリストアップしています。そして、こう言っています。

<figure>
  <blockquote>ラベルの代わりにplaceholder属性を使用すると、高齢者や認知、移動、運動、視覚に障害のあるユーザーを含む様々なユーザーにとって、コントロールのアクセシビリティとユーザビリティが低下する可能性があります。</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">W3Cのプレースホルダーに関する研究</a></cite></figcaption>
</figure>

### 情報提供の必要性

ウェブ開発者がエンドユーザーから情報を収集する場合、どの情報がオプションで、どの情報が必要なのかを明確に示す必要があります。たとえば、エンドユーザーがオンラインで何かをダウンロード購入する場合、配送先の住所は任意です。しかし、支払い方法は、販売を完了するために必要である可能性が高いです。

2014年にHTML5が`<input>`フィールドに[`required`属性](https://developer.mozilla.org/docs/Web/HTML/Attributes/required)を導入する以前は、Web開発者はこの問題をアドホックにケースバイケースで解決することを余儀なくされました。一般的な慣例は、必須入力フィールドのラベルにアスタリスク（`*`）を付けることです。これは純粋に視覚的、様式的な慣習であり、アスタリスクの付いたラベルはいかなる種類のフィールド検証を強制するものではありません。さらに、スクリーン・リーダーは、この文字が明示的に支援技術から隠されていない限り、通常「星」とアナウンスするので、混乱することがあります。

フォームフィールドの必要な状態を支援技術に伝えるため使用できる属性は2つあります。`required` 属性は、ほとんどのスクリーンリーダーによって通知され、必須フィールドが適切に記入されていない場合、実際にはフォームの送信を阻止します。[`aria-required`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-required_attribute)属性は、支援技術に必須フィールドを示すために使用できますが、フォーム送信を妨害するような関連した動作は付属していません。

{{ figure_markup(
  image="form-required-controls.png",
  caption="必要な入力の指定方法",
  description="棒グラフは、`required`属性がデスクトップサイトの64.3%、モバイルサイトの65.7%、`aria-required`が32.3%と31.6%、アスタリスクが21.9%と22.6%で使用されていることを表しています。 `required`と`aria-required`は7.4%と7.7%、アスタリスクと`aria-required`は7.3%と8.2%、アスタリスクと`required`は7.1%と6.3%、3つとも使われているサイトはどちらも0.8%であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1608381516&format=interactive",
  sheets_gid="2064792791",
  sql_file="form_required_controls.sql",
  width=600,
  height=505
) }}

デスクトップ型ウェブサイトの21%に、ラベルにアスタリスク（`*`）、`required`属性、`aria-required`属性のいずれか、またはこれらの手法を組み合わせたフォーム要素がありました。これらのフォーム要素の3分の2は `required` 属性を使用していました。必須入力の約3分の1は `aria-required` 属性を使用しています。およそ22%はラベルにアスタリスクを使用していました。

## ウェブ上のメディア

アクセシビリティは、ウェブ上のあらゆるメディア消費において、ますます重要な役割を果たすようになっています。聴覚障害者のために、キャプションはビデオへのアクセスを提供します。目が不自由な人や視覚に障害がある人は、音声ガイドで情景を説明できます。メディアコンテンツへのアクセスの障壁を取り除かない限り、私たちはウェブ上で訪問されるものの大半から人々を排除していることになります。

<a hreflang="en" href="https://www.streamingmedia.com/Articles/ReadArticle.aspx?ArticleID=144177">このStreaming Mediaの調査</a>によると、「2022年までに、動画視聴はすべてのインターネットトラフィックの82%を占めるようになる」そうです。ウェブコンテンツで画像、音声、動画などのメディアを使用する場合は、必ずすべての人がアクセスできるようにする必要があります。

### 代替テキストの概要

すべてのHTMLメディア要素では、テキストの代替を提供できますが、すべての作者がこのアクセシビリティ機能を利用しているわけではありません。

1995年のHTML 2.0仕様で、画像を表示するための `<img>` 要素が導入された。同時に導入された `alt` 属性は、ウェブ開発者が画像に代わるテキストを提供するための明確なメカニズムを提供します。

この画像の代替説明文は、スクリーンリーダーが画像を見ることができない人のために画像を説明するために使用されます。また、画像をダウンロードまたは表示できない場合に、すべての人に画像を説明するために使用されます。画像を見ることのできないユーザーとは、検索エンジンのことです。検索エンジン最適化（SEO）では、画像を表示したウェブページをテキスト検索で発見できるよう、優れた`alt`テキストが重要な役割を担います。

HTML5仕様では、2014年に `<video>` と `<audio>` 要素が導入され、サードパーティのブラウザープラグインを必要としない、リッチメディアをウェブサイトに組み込むための標準ベースの方法が提供されました。`<video>` と `<audio>` の両方の要素に `<track>` を含めることができ、クローズドキャプション、字幕、音声ディスクリプションは、リッチメディアを楽しむためのテキストベースの代替手段を提供できます。

このトラックは、画像に対する`alt`テキストと同様のSEO効果をもたらしますが、2021年の調査では、`<track>`要素を提供しているウェブサイトは1%未満でした。

#### 画像

`alt` 属性は、ウェブ制作者が画像で伝達される視覚情報の代替テキストを提供することを可能にします。スクリーン・リーダーは、画像の代替テキストをアナウンスすることで、その視覚的な意味を音声で伝えることができます。また、画像を読み込むことができない場合は、説明文の代替テキストが表示されます。

画像は適切に説明する必要があります。短い説明文が役立つ場合もあれば、画像の意味や意図を理解するために長い説明文が必要な場合もあります。

2021年のLighthouse監査データによると、57%のサイトが<a hreflang="en" href="https://web.dev/image-alt/">`alt`テキスト付き画像のテスト</a>をパスし、前年の54%からわずかに上昇しました。このテストは `img` 要素に `alt`、`aria-label` または `aria-labelledby` 属性のうち少なくとも1つが存在するかどうかを調べます。ほとんどの場合、 `alt` 属性を使用するのがもっとも良い選択です。

{{ figure_markup(
  image="pages-containing-alt-with-file-extension.png",
  caption="ファイル拡張子を持つ `alt` 属性を含むページ。",
  description="2020年にデスクトップサイトの6.8%、モバイルサイトの6.4%が`alt`属性で拡張機能を使用したことを示す棒グラフです。2021年にはデスクトップサイトの7.3%、モバイルサイトの7.1%に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=403540154&format=interactive",
  sheets_gid="747755748",
  sql_file="alt_ending_in_image_extension.sql"
) }}

代替テキストの有無の自動チェックは、通常、このテキストの品質を評価するものではありません。役に立たないパターンの1つは、画像のファイル拡張子名での説明です。私たちは、デスクトップ・サイト（`alt`属性のインスタンスを少なくとも1つ持つ）の7.1％が、少なくとも1つの `img` 要素の `alt` 属性の値にファイル拡張子を持つことを発見しました（前年は7.3％でした）。

{{ figure_markup(
  image="common-file-extensions-in-alt-text.png",
  caption="もっとも一般的なファイル拡張子を `alt` テキストで表示します。",
  description="すべての拡張子で使用されているものを棒グラフで示すと、デスクトップサイトでは`jpg`55.1%、モバイルサイトで54.44%、`png`32.8%、33.11%、`ico`が5.2%、5.36%、`jpeg`は2.8%と3.00%、`gif`は2.0%と1.92%、`svg`は1.5%と1.36%、`tif`は0.3%と0.38%、`webp`は0.2%と0.21%、`jpe`は0.0%、そして最後に `cur` は 0.0%と 0.03% であることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1350890749&format=interactive",
  sheets_gid="747755748",
  sql_file="alt_ending_in_image_extension.sql",
  width=600,
  height=764
) }}

テキスト値 `alt` に明示的に含まれるファイル拡張子のトップ5（空ではない `alt` 値を持つ画像を持つサイトでは）は、`jpg`、`png`、`ico`、`gif`、`jpeg` となっています。これは、CMSやその他の自動生成された代替テキストの仕組みに由来していると思われます。これらの `alt` 属性値は、どのように実装されているかにかかわらず、意味のある値であることが不可欠です。

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` 属性の長さ。",
  description="棒グラフはデスクトップ画像の19.1%とモバイル画像の19.0%で`alt`が設定されておらず、それぞれ26.9%と27.0%で空になっており、15.9%と15.3%で10文字以内、13.9%と14.0%で20文字以内、8.2%と8.4%で30文字以内、14.8%と15.1%で100文字以内、そして1.1%と1.1%で100文字超になることが示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=159159336&format=interactive",
  sheets_gid="384780873",
  sql_file="common_alt_text_length.sql"
) }}

その結果、`alt`のテキスト属性の27%は空であることが判明した。理想的な世界では、これに関連する<a hreflang="en" href="https://www.w3.org/WAI/tutorials/images/decorative/#:~:text=For%20example%2C%20the%20information%20provided,technologies%2C%20such%20as%20screen%20readers.">画像は装飾的</a>であり、支援技術で記述されるべきものではありません。しかし、大半の画像はインターフェイスに付加価値を与えるものであり、そのような画像は説明されるべきものです。その結果、10文字以下の画像が15％あり、ほとんどの画像に対して妙に短い説明文になっており、情報の同等性が達成されていないことがわかりました。

#### 音声

[`<track>`](https://developer.mozilla.org/docs/Web/HTML/Element/track) は、`<audio>` と `<video>` 要素の音声と同等のテキストの方法を提供します。これにより、永久的または一時的な難聴の方でも、音声コンテンツを理解できます。

{{ figure_markup(
  caption="デスクトップの `<audio>` 要素には、少なくとも1つの `<track>` 要素が付随しています。",
  content="0.02%",
  classes="big-number",
  sheets_gid="1198212185",
  sql_file="audio_track_usage.sql"
)
}}

`<track>` は1つまたは複数のWebVTTファイルを読み込み、テキストコンテンツと説明する音声を同期させることができます。デスクトップでは全ページの0.02%、モバイルでは全ページの0.05%が、検出可能な`<audio>`要素に少なくとも1つの`<track>`要素が付随していることがわかりました。

これらのデータポイントには、`<iframe>`要素で埋め込まれた音声は含まれていません。これは、録音をホストしてリスト化するためにサードパーティのサービスを使用するポッドキャストのようなコンテンツによくあることです。

#### 動画

2021年版Web Almanacに掲載されたWebサイトのうち、`<video>`要素は約5％にしか存在しませんでした。

{{ figure_markup(
  caption="`<video>` 要素を持つデスクトップWebサイトには、少なくとも1つの `<track>` 要素が付随しています。",
  content="0.5%",
  classes="big-number",
  sheets_gid="1261793459",
  sql_file="video_track_usage.sql"
)
}}

`<audio>`の調査結果と同様に、`<track>`要素が対応する`<video>`要素と共に含まれているのは、デスクトップサイトでは1%未満、モバイルサイトでは0.6%でした。実際の数字では、630万件のデスクトップサイトのうち、`<video>`要素があるところに`<track>`要素が含まれていたのは2,836件だけでした。750万件のモバイルサイトのうち、`<video>`要素で読み込んだコンテンツに対応する`<track>`要素を含むことでビデオへアクセスできるようにしたサイトは、わずか2,502件でした。

この図は `<audio>` 要素と同様に、サードパーティの `<iframe>` によって読み込まれたビデオコンテンツ、たとえば埋め込まれたYouTubeビデオを考慮していないかもしれません。また、一般的なサードパーティの音声やビデオの埋め込みサービスには、同期されたテキストを追加する機能があることに留意する必要があります。

## ARIAで支援技術をサポートする

<a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/aria/">Accessible Rich Internet Applications</a>ARIAは、2014年にWeb Accessibility Initiativeがはじめて発表したWeb標準のスイートである。ARIAは、支援技術のユーザーの体験を向上させるためHTMLマークアップに追加できる一連の属性を提供します。

ARIAの使用には多くのニュアンスと複雑さがあり、また支援技術のサポートの程度もさまざまです。一般的なルールとして、ARIAは控えめに使用すべきであり、同等のネイティブHTMLソリューションがある場合には、決して使用しないでください。ARIAは、支援技術に役立つ情報を提供できますが、キーボードの操作性などの関連する動作はありません。

<a hreflang="en" href="https://www.w3.org/TR/using-aria/">ARIAの5つのルール</a>は、ARIAの使用に関する有用な指針をいくつか述べています。2021年9月、W3ワーキンググループは、ARIAをどのように、いつ使うことができるかについて非常に詳細な情報を持つ仕様案、<a hreflang="en" href="https://www.w3.org/TR/2021/PR-html-aria-20210930/#priv-sec">ARIA in HTML</a>を発表しました。

### ARIAロール

支援技術が要素に遭遇したとき、その要素の役割は、誰かがそのコンテンツをどのように操作する可能性があるかについての情報を伝えます。たとえば、`<a>`要素はリンクの役割を支援技術に公開します。これは通常、要素がアクティブになるとどこかに移動することを伝えるものです。

HTML5では多くの新しいネイティブ要素が導入されましたが、それらはすべて <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#implicit_semantics">暗黙的意味論</a> を持ち、ロールも含まれます。たとえば、`<nav>` 要素は暗黙のうちに `role="navigation"` を持っており、支援技術に目的情報を伝えるために、ARIAを介してこの役割を明示的に追加する必要はないのです。

ARIAを使用すると、適合するネイティブなHTMLロールを持たないコンテンツに、明示的にロールを追加できます。たとえば、[`tablist`](#タブインデックス) ウィジェットを作成する場合、コンテナー要素に `tablist` というロールを割り当てることができます。

{{ figure_markup(
  image="sites-using-role.png",
  caption="パーセンタイルごとのARIAロールの使用数。",
  description="ARIAロールの使用数をパーセンタイルで示した棒グラフ。10パーセンタイルと25パーセンタイルでは、デスクトップとモバイルの両方で使用されているロールは0、50パーセンタイルでは両方で使用されているロールは3、75パーセンタイルではデスクトップで12、モバイルで11、90パーセンタイルではデスクトップで34、モバイルで31のロールが使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1547371971&format=interactive",
  sheets_gid="1612528407",
  sql_file="sites_using_role.sql"
) }}

現在、デスクトップページの69%（2020年の65%から増加）が、ARIA `role`属性のインスタンスを少なくとも1つ持っています。中央値では、3つの`role`属性があります（2020年の2つから増加）。もっともよく使われるロールを以下に示します。

{{ figure_markup(
  image="top-10-aria-roles.png",
  caption="ARIAの代表的な役割トップ10。",
  description="棒グラフは、`button`がデスクトップで29.4%、モバイルでは29.0%、`navigation`が22.8%、22.5%、`presentation`22.2%、21.1%、`dialog`20.8%、20.1%、`search`19.3%と18.8%、`main`が16.9%と16.8%、`banner`が14.3%と14.3%、`contentinfo`が12.2%と12.1%、`img`が11.4%と10.9%、最後の`tablist`は7.7%と7.4%であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1136878573&format=interactive",
  sheets_gid="2046624948",
  sql_file="common_aria_role.sql",
  width=600,
  height=540
) }}

### ボタンを使うだけ！

ARIAロールのもっとも一般的な誤用の1つは、 `<div>`や `<span>`などの非対話型要素または `<a>`要素にボタンロールを追加することです。ネイティブのHTMLの `<button>` 要素は、暗黙のうちにボタンの役割を果たし、期待されるキーボード操作性と動作を備えており、ARIAに手を伸ばす前の最初のアプローチであるべきです。

デスクトップサイトの29%（2020年の25%から増加）とモバイルサイトの29%（2020年の25%から増加）が、明示的に割り当てられた `role="button"` の要素を少なくとも1つ持つホームページを持っていることがわかりました。このことから3分の1近くのウェブサイトが、明示的にボタンの役割を割り当てられたボタンを除いて、セマンティクスを変更するため要素に `button` の役割を使用しており、これは冗長であることがわかります。

もし、`<div>`や`<span>`などの非インタラクティブ要素がボタンの役割を与えられていた場合、期待されるキーボードのフォーカス順や操作性が適用されず、<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/keyboard-operation-keyboard-operable.html">WCAG 2.1.1 Keyboard</a>や<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-focus-order.html">2.4.3 Focus order</a>に問題の発生する可能性が大きいです。さらに、<a hreflang="en" href="https://ericwbailey.design/writing/truths-about-digital-accessibility/#windows-high-contrast-mode-ignores-aria">Windows High Contrast ModeはARIAを尊重しないため</a> 、ネイティブHTMLボタン要素でない要素は、このモードでは対話可能に見えないことがあります。デスクトップとモバイルのサイトの11%に、`button`の役割を明示した`<div>`または`<span>`がありました。

ボタンの役割を `<a>` 要素に適用すると、アンカー要素が持つ暗黙のリンクの役割が上書きされます。なぜなら、ボタンに期待される動作はページ内のアクションを引き起こすことであり、一方リンクは通常どこかに移動することだからです。また、正しいキーボードの動作が実装されていない場合、<a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/keyboard-operation-keyboard-operable.html">WCAG 2.1.1, Keyboard</a> に違反します（リンクはスペースキーで有効になりませんが、ボタンは有効になります）。さらに、ボタンの役割が期待される動作なしにスクリーンリーダーによって告知されると、支援技術ユーザーにとって混乱と見当違いを引き起こす可能性があります。

{{ figure_markup(
  caption="デスクトップのWebサイトには、少なくとも1つのボタンの役割を持つリンクがあります。",
  content="18.6%",
  classes="big-number",
  sheets_gid="1014817325",
  sql_file="anchors_with_role_button.sql"
)
}}

デスクトップページの19％（2020年の16％から増加）、モバイルページの18％（2020年の15％から増加）に `role="button"` のアンカー要素が少なくとも1つ含まれていることがわかりました。ネイティブの `<button>` 要素の方が、<a hreflang="en" href="https://www.w3.org/TR/using-aria/#rule1">ARIAの最初の規則</a>にしたがって、より良い選択でしょう。

このARIAロールを追加する行為、つまり<a hreflang="en" href="https://adrianroselli.com/2020/02/role-up.html">"role-up"</a>は、通常、正しいネイティブHTML要素を使用するより理想的ではありません。繰り返しますが、これらのケースの大部分では、問題の要素に明示的に `role="button"` を定義するよりも、ネイティブのHTML`<button>` 要素を活用する方が良いパターンでしょう。

### プレゼンテーションの役割の活用

要素に `role="presentation"` が宣言されると、その子要素と同様にそのセマンティクスが取り除かれます。たとえば、親であるテーブルやリスト要素に `role="presentation"` を宣言すると、そのロールは子要素にカスケードされます。この場合、セマンティクスも削除されます。

要素のセマンティクスを削除するということは、その要素の動作や支援技術による理解の観点から、その要素はもはやその要素ではなく、その視覚的な外観だけが残るということを意味します。たとえば、`role="presentation"`を持つリストは、リストの構造に関する情報をスクリーン・リーダーに伝えることができなくなります。デスクトップ・ページの22%とモバイル・ページの21%に、少なくとも1つの要素が `role="presentation"` を持つことがわかりました。このロールが支援技術利用者にとってとくに役立つユースケースは非常に少ないので、控えめに、そして慎重に使用してください。

### ARIAによる要素のラベリングと説明

DOMと平行して、[アクセシビリティツリー](https://developer.mozilla.org/docs/Glossary/Accessibility_tree)と呼ばれる同様のブラウザ構造があります。これには、アクセシブルな名前、説明、役割、状態など、HTML要素に関する情報が含まれています。この情報は、アクセシビリティAPIを通じて支援技術に伝達されます。

アクセシビリティツリーには、コントロール、ウィジェット、グループ、ランドマークに対して、アクセシブルネーム（ある場合）を割り当て、支援技術によって告知またはターゲット化できるようにする計算システムがあります。

アクセス可能な名前は、要素のコンテンツ（ボタンのテキストなど）、属性（画像の `alt` テキスト値など）、関連付けられた要素（プログラム的に関連付けられた [フォームコントロールの `label`](#label-要素) など）から得ることができます。複数の候補がある場合、アクセス可能な名前にどの値を割り当てるかを決定するために起こる特異性の順位付けがあります。

アクセシブルネームについての詳細は、[Léonie Watson](https://x.com/LeonieWatson) の記事、<a hreflang="en" href="https://developer.paciellogroup.com/blog/2017/04/what-is-an-accessible-name/">アクセシブルネームとは何ですか？</a> をご覧ください。

また、ARIAを利用して、要素にアクセシブルな名前を付けることも可能です。これを実現するARIA属性は、<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/aria/ARIA14.html">`aria-label`</a> と <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/aria/ARIA16.html">`aria-labelledby`</a> の2つがあります。これらの属性のいずれかが、アクセス可能な名前の計算に「勝ち」、ネイティブに派生したアクセス可能な名前を上書きします。この2つの属性は注意して使用することが重要で、必ずスクリーンリーダーでテストするか、アクセシビリティツリーを見て、アクセシブルな名前がユーザーの期待するものであることを確認するようにしてください。ARIAを使って要素に名前を付けるとき、<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/label-in-name.html">WCAG 2.5.3、名前にラベルをつける</a> 基準に違反していないことを確認することが重要で、可視ラベルは少なくともそのアクセス可能な名前の一部であると期待します。

{{ figure_markup(
  image="top10-aria-attributes.png",
  caption="ARIAの属性トップ10。",
  description="棒グラフは、`aria-hidden`がデスクトップサイトの53.8%、モバイルサイトの53.0%、`aria-label`が53.1%、51.8%、`aria-expanded`25.5%、25.1%、`aria-labelledby`21.3%、19.9%、`aria-controls`20.9%と20.2%、`aria-live`が20.8%と19.7%、`aria-haspopup`が18.3%と17.1%、`aria-current`が16.1%と16.9%、`aria-describedby`が12.7%と12.1%、最後に `aria-atomic` が 8.2%と 7.7% であった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=1828569038&format=interactive",
  sheets_gid="1763660541",
  sql_file="common_element_attributes.sql"
) }}

`aria-label` 属性は、開発者が文字列の値を提供することを可能にし、これが要素のアクセス可能な名前として使用されることになります。音声読み上げのユーザーは、目に見えるテキストを参照にしないと、名前が付いたコントロールに照準を合わせるのが難しいかもしれないことは、注目に値します。認知障害のある人も目に見えるテキストが、役に立つことがよくあります。不可視のアクセス可能な名前は、アクセス可能な名前がないよりはましですが、ほとんどの場合、可視ラベルはアクセス可能な名前を提供するか、最低でも要素のアクセス可能な名前に含まれる必要があります。

デスクトップページの53％（2020年の40％から増加）、モバイルホームページの52％（2020年の39％から増加）に少なくとも1つの要素に`aria-label`属性があり、アクセシブルな名前を提供するARIA属性としてもっとも人気があり、1年間で使用率が非常に大きく増加していることがわかりました。これは、これまでアクセシブルな名称がなかった要素に、より多くの名称が付けられるようになったことを示すポジティブな兆候かもしれません。しかし、目に見えるラベルのない要素が増えたことを意味する場合もあり、認知障害のある人や音声読み上げの利用者に悪影響を与える可能性があります。

`aria-labelledby` 属性は、その値として `id` 参照を受け付けます。この参照は、そのアクセス可能な名前を提供するために、インターフェイスの他の要素に関連付けます。その要素は、アクセス可能な名前を提供する他の要素によって「ラベル付け」されるようになります。デスクトップページの21%（2020年の18%から増加）とモバイルページの20%（2020年の16%から増加）が、少なくとも1つの要素に `aria-labelledby` 属性を持つことがわかりました。

`aria-describedby` 属性は、要素に対してより堅牢な記述が必要な場合に使用できます。また、インターフェイスの他の場所に存在する記述的なテキストと接続するために、その値としてid参照を受け入れることができます。アクセシブルネームは提供されません。アクセシブルネームは、代替ではなく、補足として併用されるべきです。デスクトップページの13%、モバイルページの12%に `aria-describedby` 属性の要素を1つ以上持つことがわかりました。

<p class="note">楽しい事実！1,886のウェブサイトに`aria-lavel`という属性があることがわかりました！これは`aria-label`属性のスペルミスです。このような簡単に回避できるエラーは、必ず自動チェックで拾ってください。</p>

#### ボタンのアクセス可能な名称はどこから来ているのでしょうか？

ボタンは通常、そのコンテンツまたはARIA属性からアクセス可能な名前を取得します。<a hreflang="en" href="https://www.w3.org/TR/using-aria/#rule1">ARIAの最初の規則</a>により、もし要素がARIAを使わずにそのアクセス可能な名前を導き出せるなら、これは望ましいことです。したがって、`<button>`は、可能であればARIA属性ではなく、そのテキストコンテンツからアクセス可能な名前を取得する必要があります。

ボタンが画像やアイコンを用いたグラフィカルなコントロールであるため、アクセス可能な名前を提供するためにテキストコンテンツを使用しない一般的な実装があります。これは、テキストを表示せずに制御を行う必要のある音声読み上げユーザにとって問題となる可能性があり、テキストを表示するオプションがある場合には、使用すべきではありません。

{{ figure_markup(
  image="button-name-sources.png",
  caption="ボタンアクセス可能な名前のソースです。",
  description="棒グラフは、デスクトップのボタンの49.9%とモバイルのボタンの47.3%にコンテンツが使用され、それぞれ20.7%と22.2%に `aria-label` 属性が使用され、17.5%と19.9%にアクセス可能な名前が存在せず`value` 属性は 9.2% と 8.1%、 `title` 属性が 2.6% と 2.5%、 `aria-labelledby` 関連要素が 0.1% と 0.1% で使用されたことを表します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=2097166988&format=interactive",
  sheets_gid="1467280228",
  sql_file="button_name_sources.sql",
  width=600,
  height=457
) }}

その結果、デスクトップとモバイルの両サイトにおいて、57%のボタンがコンテンツからアクセシブルネームを取得していることがわかりました。また、デスクトップサイトでは29%、モバイルサイトで27%のボタンが `aria-label` 属性からアクセシブルネームを取得していることがわかりました。

### コンテンツの非表示

支援技術がコンテンツを発見しないようにするには、いくつかの方法があります。CSSの `display: none;` を利用して、アクセシビリティツリーから要素を省くことができます。スクリーン・リーダーからコンテンツを隠したい場合は、`aria-hidden="true"`を使用できます。`display: none;`とは異なり、`aria-hidden="true"`の宣言は、要素とその子要素を目に見える形で削除しないことに注意してください。

{{ figure_markup(
  caption="デスクトップのウェブサイトには、少なくとも1つの `aria-hidden` 属性のインスタンスがあります。",
  content="53.8%",
  classes="big-number",
  sheets_gid="1763660541",
  sql_file="common_element_attributes.sql"
)
}}

デスクトップページの54％（2020年の48％から増加）とモバイルページの53％（2020年の49％から増加）に、少なくとも1つの `aria-hidden` 属性付き要素のインスタンスが、あることがわかりました。

これらのテクニックは、ビジュアルインターフェイスの何かが冗長であったり、支援技術のユーザーにとって役に立たない場合に、もっとも役に立ちます。アクセシブルにするのが難しいコンテンツをスキップするために、支援技術からコンテンツを隠すことは、決して行ってはなりません。

コンテンツを隠したり、見せたりすることは、現代のインターフェイスでは一般的なパターンであり、誰にとっても隠れたUIを断捨離するのに役立つことがある。Hide/showウィジェットでは、`aria-expanded` 属性を使用して、コントロールをアクティブにすると何かが現れ、再びアクティブにすると隠されることを支援技術に示す必要があります。デスクトップページの26％（2020年の21％から増加）、モバイルページの25％（2020年の21％から増加）に、少なくとも1つの要素で `aria-expanded` 属性が、あることがわかりました。

### スクリーンリーダー専用テキスト

スクリーン・リーダーの利用者に追加情報を提供するために開発者が採用する一般的な手法は、CSSを使用してテキストの一節を視覚的に隠し、スクリーン・リーダーがそれを発見できるようにすることです。`display: none;`はアクセシビリティツリーにコンテンツが存在しないようにするため、CSSコードの特定の宣言セットを含む共通のパターンが存在します。

{{ figure_markup(
  caption="`sr-only` または `visually-hidden` クラスを持つデスクトップWebサイト",
  content="14.3%",
  classes="big-number",
  sheets_gid="960991314",
  sql_file="sr_only_classes.sql"
)
}}

この <a hreflang="en" href="https://css-tricks.com/inclusively-hidden/">code snippet</a> のもっとも一般的なCSSクラス名は、（慣習的にもBootstrapなどのライブラリ全体でも）`sr-only` と `visually-hidden` です。デスクトップ用ページの14％、モバイル用ページの13％に、これらのCSSクラス名のいずれか、または両方が含まれていることがわかりました。スクリーン・リーダーの利用者の中には、ある程度の視力を持つ人もいるため、視覚的に隠されたテキストに過度に依存すると、一部の人は混乱する可能性があることは留意しておく必要があります。

### ダイナミックレンダリングコンテンツ

DOMに新しいコンテンツや更新されたコンテンツがある場合、スクリーン・リーダーに伝える必要があります。フラストレーションを避けるために、どの更新を伝える必要があるかについて、ある程度考慮する必要があります。たとえば、フォームの検証エラーは伝える必要がありますが、遅延ロードされた画像は伝える必要がないかもしれません。DOMの更新は、混乱を招かない方法で行われる必要があります。

_ARIAライブリージョン_は、DOMの変更を監視し、スクリーンリーダーで更新されたコンテンツを知らせることができます。デスクトップページの21％（2020年の17％から増加）、モバイルページの20％（2020年の16％から増加）がライブリージョンを持っていることがわかりました。ライブリージョンバリアントや使い方についての詳しい情報は [ARIAライブリージョン](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Live_Regions) をチェックするか、この <a hreflang="en" href="https://dequeuniversity.com/library/aria/liveregion-playground">Dequeによるライブデモ</a>で遊んでみてください。

## アクセシビリティオーバーレイ

アクセシビリティオーバーレイは、アクセシビリティプラグインやオーバーレイウィジェットと呼ばれることもあり、ウェブサイトのアクセシビリティ問題を簡単に解決するツールとして販売されているデジタル製品です。<a hreflang="en" href="https://overlayfactsheet.com/#what-is-a-web-accessibility-overlay">Overlay Fact Sheet</a> では、「ウェブサイトのアクセシビリティを向上させることを目的とした技術の広義の用語と定義されています。それらは、ウェブサイトのフロントエンドのコードの改善を自動化するために、サードパーティのソースコード（通常はJavaScript）を適用します。」

これらの製品の多くは、1行のコードでウェブサイトがアクセシブルになる、あるいは少なくともアクセシビリティの観点からは合法的に準拠することを示唆する、欺瞞的なマーケティング材料を使用しています。

たとえば、この分野でもっとも積極的な製品の1つである <a hreflang="en" href="https://en.wikipedia.org/wiki/AccessiBe">accessiBe</a> は、そのプロセスをJavaScriptのインストール コードを本番コードに貼り付けるだけで、48時間以内にサイトをアクセス可能かつコンプライアントにすることが可能であると説明しています。

残念ながら、ウェブアクセシビリティは、このようなすぐに使えるソリューションでは実現できないのです。もしそうであれば、この章にあるような悲惨な統計データを見ることはないでしょう。

{{ figure_markup(
  image="pages-using-a11y-apps.png",
  caption="アクセシビリティアプリを使用したページ。",
  description="デスクトップサイトの0.96％、モバイルサイトの0.80％がアクセシビリティアプリを使用していることを示す棒グラフです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=618692173&format=interactive",
  sheets_gid="150155313",
  sql_file="a11y_technology_usage.sql"
) }}

その結果、デスクトップWebサイトの0.96％（6万件以上）で、これらのアクセシビリティ・オーバーレイが使用されていることがわかりました。この分野の有名な製品のリストを照会したことは、注目に値します。しかし、このリストは網羅的なものでないので、この指標は実際にはもっと高い可能性があります。

{{ figure_markup(
  image="a11y-app-usage-by-rank.png",
  caption="アクセシビリティ・アプリのランク別利用状況。",
  description="デスクトップサイトでもっとも人気のあるアクセシビリティ・アプリのドメインランク別の利用状況を示す棒グラフです。AccessiBeは上位1,000サイトでは利用されていないが、上位10,000サイトでは0.15%、上位100,000サイトが0.39%、上位100万サイトは0.37%、全サイトで0.27%利用されていることがわかる。AudioEyeは、それぞれ0.13%、0.20%、0.13%、0.16%、0.24%で使用されています。EqualWebは、上位1,000サイトや上位10,000サイトでは使用されていませんが、上位10万サイトの0.02％、上位100万サイトの0.03％、全サイトの0.02％で使用されています。 テキストヘルプも同様に、上位1,000サイトや上位10,000サイトでは使用されていませんが、上位10万サイトの0.02％、上位100万サイトの0.04％、全サイトの0.02％で使用されています。最後に、UserWayは上位1,000サイトでは使用されていないが、上位1万サイトの0.04%、上位10万サイトの0.09%、上位100万サイトの0.24%、全サイトの0.39%で使用されている。AudioEyeのみ、上位1,000サイトで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=473077851&format=interactive",
  sheets_gid="2077755325",
  sql_file="a11y_technology_usage_by_domain_rank.sql"
) }}

ドメインランクを考慮すると、上位1,000サイトのオーバーレイ使用率は0.1%と低くなっています。しかし、これらの上位サイトのリーチを考慮すると、これだけのトラフィックを持つ1つのWebサイトがオーバーレイを使用した場合の潜在的な影響は非常に大きなものです。

{{ figure_markup(
  image="pages-using-a11y-apps-by-rank.png",
  caption="アクセシビリティ・アプリを使用しているページのランク別推移。",
  description="上位1,000サイトではデスクトップで0.1%、モバイル利用とアクセシビリティアプリで0.1%、上位1万サイトではそれぞれ0.6%、0.5%、上位10万サイトは0.8%、0.7%、上位100万サイトで0.9%、0.8%、最後にすべてのサイトで1%、0.8%となっており、棒グラフが示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQf4cxIC7ywDV-K2RpfaTeCYI4URyJE1air8BCAxoOw7VW9MjGRQfwHuILvhw-6UmcWnsrAJ0-1TTD_/pubchart?oid=851935325&format=interactive",
  sheets_gid="827309922",
  sql_file="a11y_overall_tech_usage_by_domain_rank.sql"
) }}

### オーバーレイのもたらすもの

これらのツールはしばしば支援技術を妨害し、実際に多くの人にとってウェブサイトをアクセスしにくくします。これに関して、<a hreflang="en" href="https://www.vice.com/en/article/m7az74/people-with-disabilities-say-this-ai-tool-is-making-the-web-worse-for-them">「障害者はこのAIツールがウェブを悪化させていると言う」という適切なタイトルのViceの記事で調査されています</a>。<a hreflang="en" href="https://www.accessibyebye.org/">accessiByeBye</a> というオープンソースの拡張機能もあります。これは、支援技術ユーザーがサードパーティのオーバーレイ製品を使用しているWebサイトの使用を妨げられないよう、オーバーレイをブロックするために特別に開発されたものです。

市民権弁護士の[Haben Girma](https://x.com/HabenGirma)が<a hreflang="en" href="https://www.youtube.com/watch?v=R12Z1Sp-u4U">アクセシビリティオーバーレイに関するこの動画</a>で説明しているように、「AIはツールであり、今のところアクセシビリティに対してできることが極めて限られている」のです。さらに、自動生成された自分の名前のキャプションが、「Haben Girma」を「happen grandma」と誤訳したこと、このような情報の誤伝達が聴覚障害者のユーザーに与える影響について説明します。

このようなオーバーレイ会社と、彼らが奉仕すると称している障害者コミュニティとの間には、緊張関係が存在する。たとえば、全米盲人連合は、<a hreflang="en" href="https://www.forbes.com/sites/gusalexiou/2021/06/26/largest-us-blind-advocacy-group-bans-web-accessibility-overlay-giant-accessibe/?sh=16621ec55a15">アクセシービーをその全国大会から追放し</a>、<a hreflang="en" href="https://nfb.org/about-us/press-room/national-convention-sponsorship-statement-regarding-accessibe">同社による被害についてこのように発表しています</a>。

<figure>
  <blockquote>accessiBeは、何がアクセシブルで何がアクセシブルでないかを、盲目の専門家やスクリーンリーダーの常用者が知っていることを認めていないようです。この国の視覚障害者は、なだめたり、いじめたり、買収されたりすることはありません。</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://nfb.org/about-us/press-room/national-convention-sponsorship-statement-regarding-accessibe">全米盲人連合</a></cite></figcaption>
</figure>

### 個人情報保護への配慮

これらのツールの中には、支援技術の利用を検知する技術を持つものもあります。これは、本人の同意なしに、その人の障害に関する個人データを収集される可能性があることを意味します。

<a hreflang="en" href="https://overlayfactsheet.com/#privacy">オーバーレイファクトシート</a>より。

<figure>
<blockquote>オーバーレイの中には、同じオーバーレイを使用しているサイト間でユーザーの設定を持続させるものがあることが分かっています。これは、ユーザーのコンピューターにクッキーを設定することで行われます。ユーザーがあるサイトでオーバーレイ機能の設定を有効にすると、他のサイトでも自動的にその機能が有効になります。大きなプライバシー問題は、ユーザーが追跡されることを決してオプトインしておらず、オプトアウトする能力もないことです。このようにオプトアウト（明示的にその設定をオフにすること以外）がないため、オーバーレイのお客様には一般データ保護規則（GDPR）とカリフォルニア消費者プライバシー法（CCPA）のリスクが発生します。</blockquote>
<figcaption>— <cite><a hreflang="en" href="https://overlayfactsheet.com/">オーバーレイファクトシート</a></cite></figcaption>
</figure>

この<a hreflang="en" href="https://tink.uk/accessibe-and-data-protection/">Léonie Watsonによる記事</a>は、アクセシビリティ オーバーレイにおけるこの種のデータ追跡のプライバシーに関する懸念を探ったものです。

### オーバーレイと訴訟

これらのウィジェットは、それを使用する企業に対して多くのアクセシビリティ訴訟の一部として名指しされています。<a hreflang="en" href="https://info.usablenet.com/2020-report-on-digital-accessibility-lawsuits">UsableNetの2020年デジタルアクセシビリティ訴訟に関するレポート</a>によると、「訴えられた250社以上がアクセシビリティウィジェットやオーバーレイに投資していた」そうです。<a hreflang="en" href="https://sheribyrnehaber.com/technology-doesnt-make-accessibility-hard-people-who-dont-care-do/">アクセシビリティ専門家のSherri Byrne-Haberは</a>、「2020年末に起こされるアクセシビリティ訴訟の10％は、プラグイン、オーバーレイ、ウィジェットをインストールした企業に対して、それらがADA訴訟の防弾になると考えてのものだ」と引用しています。アクセシビリティに関する法律は、「障害を持つアメリカ人法」に限らず、<a hreflang="en" href="https://www.3playmedia.com/blog/countries-that-have-adopted-wcag-standards-map/">WCAGを指した法律を持つ国々が世界中に存在することは注目に値します</a>。

これらのオーバーレイを使用する際の法的な影響については、こちらをご覧ください。[Lainey Feingold](https://x.com/LFLegal)の記事<a hreflang="en" href="https://www.lflegal.com/2020/08/quick-fix/">Honor the ADAを参照してください。Avoid Web Accessibility Quick-Fix Overlays</a>とAdrian Roselliの記事<a hreflang="en" href="https://adrianroselli.com/2020/06/accessibe-will-get-you-sued.html">#accessiBe Will Get You Suedを参照してください</a>。

### なぜオーバーレイを使う企業があるのですか？

根本的には、<a hreflang="en" href="https://www.forbes.com/sites/andrewpulrang/2020/10/25/words-matter-and-its-time-to-explore-the-meaning-of-ableism/?sh=7ab349837162">ableism</a> に後押しされ、オーバーレイは、ほとんどの組織が苦労している問題を解決するものとして位置づけられています。この章を通して、インターネットはほとんどアクセスできない、というデータは明らかです。

これらの製品は、組織のアクセシビリティに関する知識のギャップを利用したものです。問題領域の枠組みは、障害者のアクセスに対する障壁を本質的に取り除くのではなく、解決策を自動化することによって、訴訟を回避することを目的としています。なぜこのような訴訟が起こるかというと、オンラインにアクセスする権利が侵害されることで、実際に公民権侵害が起こっているからです。たとえばAIツールが画像のアクセシブルでない説明を提供しても、自動化ツールのチェックには合格するかもしれませんが、目の見えない人にとっての障壁は取り除けませんし、情報の平等性を提供するものではありません。

一部のオーバーレイ企業は、1行のコードと月々の数ドルでアクセシビリティと完全なコンプライアンスを実現すると約束し、欺瞞的なマーケティングに振り回されることがあります。しかし、残念なことに、これらのツールは障害者にとって新たな障壁となり、組織は予期しない法的問題に直面する可能性があります。

即効性のある解決策はありません。組織やデジタル事業者は、ウェブコンテンツのアクセシビリティの問題を実際に解決することを優先する必要があります。障害者のコミュニティでよく言われるのは、「私たちなしでは、私たちのことは何もできない」ということです。オーバーレイは、障害者コミュニティがあまり関与しないまま作成され、<a hreflang="en" href="https://www.nbcnews.com/tech/innovation/blind-people-advocates-slam-company-claiming-make-websites-ada-compliant-n1266720">これらの企業の中には、このことについて発言した障害者をさらに遠ざけてしまったところもあります</a>。これらの製品では、障がい者の方々のウェブへの平等なアクセスを実現することはできません。

### オーバーレイに関するその他の資料

* <a hreflang="en" href="https://catchthesewords.com/do-automated-solutions-like-accessibe-make-the-web-more-accessible/">Connor Scott-Gardener氏のオーバーレイ使用体験談</a>
* <a hreflang="en" href="https://uxdesign.cc/important-settlement-in-an-ada-lawsuit-involving-an-accessibility-overlay-748a82850249">オーバーレイをめぐるADA訴訟の事例</a>
* <a hreflang="en" href="https://www.a11yproject.com/posts/2021-03-08-should-i-use-an-accessibility-overlay/">A11yプロジェクト - アクセシビリティ・オーバーレイを使うべきですか？</a>
* <a hreflang="en" href="https://uxdesign.cc/theres-no-such-thing-as-fully-automated-web-accessibility-260d6f4632a8">完全に自動化されたウェブアクセシビリティは存在しない</a>
* <a hreflang="en" href="https://www.forbes.com/sites/gusalexiou/2021/10/28/why-automated-tools-alone-cant-make-your-website-accessible-and-legally-compliant/?sh=2e538b62364e">自動化されたツールだけでは、ウェブサイトにアクセシビリティと法令遵守を実現できない理由</a>
* <a hreflang="en" href="https://shouldiuseanaccessibilityoverlay.com/">アクセシビリティオーバーレイを使うべきですか？</a>

## 結論

アクセシビリティの提唱者である<a href="https://x.com/thebillygregory/status/552466012713783297?s=20">Billy Gregoryがかつて言ったように</a>、「UXがすべてのユーザーを考慮しないとき、それはSOMEユーザーエクスペリエンス、またはSUXとして知られるべきでは」ないでしょうか。アクセシビリティの作業は、追加事項、エッジケース、あるいは技術的負債と同等とみなされ、ウェブサイトや製品の成功の中核となるべきものではないことがあまりに多くあります。

成功するためには、製品チームと組織全体が、アクセシビリティを責務の一部として、C-suiteに至るまで優先させる必要があります。アクセシビリティの作業は、<a hreflang="en" href="https://feather.ca/shift-left/">製品サイクルの左側にシフトする必要があります</a>。つまり、開発前の研究、構想、設計段階に焼き付ける必要があるのです。そして、もっとも重要なことは、障害者がこのプロセスに参加する必要があることです。

技術業界は、インクルージョン主導の開発に移行する必要があります。これにはある程度の先行投資が必要ですが、アクセシビリティを考慮せずに構築されたサイトやアプリを後付けしようとするよりも、製品に組み込むことができるようにサイクル全体に組み込む方がはるかに簡単で、長期的に見てもコストがかからないと思われます。

業界として、この章の数字が物語るように、私たちは障害者の期待を裏切っていることを認める時が来たのです。2021年からの数字は、2020年から大きく動いていない。これは、トップダウンのリーダーシップと投資（ブラウザからの継続的な参加を含む）、そして我々の実践を前進させ、ウェブを利用する障害者のニーズ、安全、インクルージョンを擁護するボトムアップの努力の組み合わせによってもたらされなければならないのです。
