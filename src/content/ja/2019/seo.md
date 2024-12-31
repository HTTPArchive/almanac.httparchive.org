---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: コンテンツ、メタタグ、インデクサビリティ、リンク、速度、構造化データ、国際化、SPA、AMP、セキュリティをカバーする2019 Web AlmanacのSEOの章。
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [ymschaap, rachellcostello, AVGP]
reviewers: [clarkeclark, andylimn, AymenLoukil, catalinred, mattludwig]
analysts: [ymschaap]
editors: [rachellcostello]
translators: [MSakamaki]
discuss: 1765
results: https://docs.google.com/spreadsheets/d/1uARtBWwz9nJOKqKPFinAMbtoDgu5aBtOhsBNmsCoTaA/
ymschaap_bio: 技術的なSEOコンサルタント<a hreflang="en" href="https://build.amsterdam/">build.amsterdam</a>の創設者。以前は、10億人以上のユーザーに達したいくつかのウェブ会社を設立しました。2005年以来、彼の最新の（広告）ベンチャーについてブログを書いている。
rachellcostello_bio: Rachel Costelloは、<a hreflang="en" href="https://www.deepcrawl.com/">DeepCrawl</a>のテクニカルSEO &コンテンツマネージャーであり、検索の最新動向を研究し、伝えることに時間を費やしている国際会議のスピーカーでもあります。Rachelは現在、<a hreflang="en" href="https://www.deepcrawl.com/knowledge/white-papers/">技術的なSEOのホワイトペーパー</a>とDeepCrawlのための研究作品の制作を管理しており、<a hreflang="en" href="https://www.searchenginejournal.com/author/rachel-costello/">Search Engine Journal</a>のレギュラーコラムニストでもあります。
AVGP_bio: Martin SplittはGoogleのウェブエコシステムチームの開発者アドボケートで、ウェブを発見しやすい状態に保つことに取り組んでいます。
featured_quote: 検索エンジン最適化（SEO）は、デジタルマーケッターの趣味やサイドプロジェクトではなく、ウェブサイトの成功に欠かせないものです。SEOの主な目標は、ウェブサイトが検索エンジンのボットに最適化されていることを確認し、ページをクロールしてインデックスを作成し、ウェブサイトをナビゲートしてコンテンツを消費するユーザーのために最適化することです。SEOは、それを構築している開発者から、新しい潜在的な顧客にそれを促進する必要がありますデジタルマーケッターまで、ウェブサイト上で働くすべての人に影響を与えます。
featured_stat_1: 346
featured_stat_label_1: 中央値ページの単語数
featured_stat_2: 11%
featured_stat_label_2: 見出しタグのないページ
featured_stat_3: 15%
featured_stat_label_3: リッチな結果の対象となるサイト
---

## 導入

検索エンジン最適化（SEO）はデジタルマーケティングの担当者にとって、単なる趣味やサイドプロジェクトではなくWebサイトを成功に導くための重要な要素です。SEOの主な目標は、Webサイトをクロールする必要のある検索エンジンボットと、Webサイトを操作するコンテンツの消費者向けにWebサイトを最適化することです。SEOはWebサイトを作っている開発者から、新しい潜在顧客に対して宣伝する必要のあるデジタルマーケティング担当者に至るまで、すべてのWebサイトに関わる人に影響を及ぼします。

それでは、SEOの重要性を見ていきましょう。今年のはじめにSEO業界は「困難な年」と言われた後<a hreflang="en" href="https://www.bbc.co.uk/news/business-47877688">ASOSが利益の87%減少</a>を報告したため、その恐ろしさ(と魅力)への注目が集まりました。このブランドの問題は、200以上のマイクロサイトを立ち上げた為に発生した検索エンジンのランキング低下と、Webサイトのナビゲーションの大幅な変更などの技術的変更が原因であると考えられています。驚きです！

Web AlmanacのSEOの章の目的は、検索エンジンによるコンテンツのクロールとインデックス付け、そして最終的にWebサイトのパフォーマンスに影響を与えるWebのオンサイト要素を分析することです。この章では、上位のWebサイトがユーザーおよび検索エンジンに優れた体験を提供するためにどれだけ十分な整備がされているか、そしてどのような作業を行うべきかについて見ていきます。

この分析には、[Lighthouse](./methodology#lighthouse)と、[Chrome UX Report](./methodology#chrome-ux-report)、HTML要素の分析データが含まれています。`<title>`要素、様々な種類のページ上リンク、コンテンツ、読み込み速度などによるSEOの基礎だけではなく、500万以上のインデクサビリティ、構造化データ、国際化、AMPなどSEOのさらなる技術的な面にも注目しています。

カスタムメトリクスはこれまで公開されていなかった洞察を提供します。`hreflang`タグ、リッチリザルトの適格性、見出しタグの使用、さらにシングルページアプリケーションのアンカーによるナビゲーション要素などの採用と実装について断言できるようになりました。

<p class="note">注意：データはホームページの分析のみに限定されており、サイト全体のクロールから集計はされていません。そのようにした理由は、以降説明する多くの指標に影響を与えるため、特定の指標について言及する場合に関連する制限を追加しました。制限の詳しい内容は<a href="./methodology">Methodology</a>を御覧ください。</p>

では、Webの現状と検索エンジンの使いやすさについての詳細をお読みください。

## 基本

検索エンジンにはクロール、インデックスの作成、ランキングの３つの手順があります。それには検索エンジンにとって、ページを見つけやすく、理解でき、search engine results pages(SERPs)（検索エンジンの結果ページ）を閲覧しているユーザーにとって価値が有り高品質なコンテンツが含まれている必要があります。

SEOの基本的なベストプラクティスの基準を満たしているWebの量を分析するため、本文のコンテンツ、`meta`タグ、内部リンクなどのページ上の要素を評価しました。それでは結果を見てみましょう。

### コンテンツ

ページの内容を理解して、最も関連性の高い回答を提供できる検索クエリが何かを決定的にするためには、まず検索エンジンがそのコンテンツを探し出してアクセス出来る必要があります。しかし、検索エンジンは現在どのようにコンテンツを見つけるのでしょうか？、その回答を得るために、単語数と見出しの２つのカスタムメトリクスを作りました。

#### 単語の数

私達は、少なくとも３つの単語グループを探し合計でいくつ見つかったかを数えるようにして、ページのコンテンツを評価しました。デスクトップページには単語グループを持たないものが2.73%見つかりました。これはWebサイトが何を指しているのかを検索エンジンが理解するのに役立つ本文コンテンツが無いことを示しています。

{{ figure_markup(
  image="fig1.png",
  caption="ページ毎の単語数分布。",
  description="ページ毎の単語分布。デスクトップページあたりの単語数の中央値は346でモバイルページの場合は306となっています。デスクトップページには、パーセンタイル全体でより多くの単語があり、90パーセンタイルで120単語もあります",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=190546113&format=interactive"
  )
}}

デスクトップ向けホームページの中央値は346単語で、モバイル向けホームページの中央値は306単語とわずかに少ない単語数になっています。これはモバイル向けサイトが少し少ない量をユーザーにコンテンツとして提供していることを示していますが、300単語を超えたとしても読むのには問題ない量でしょう。これは、例えばホームページは記事があるページなどよりコンテンツが自然と少なくなるため特に該当するでしょう。全体を見ると単語の分布は幅があり、10パーセンタイルのあたりでは22単語、90パーセンタイルあたりで最大1,361単語です。

#### 見出し

また、ページに含まれるコンテンツのコンテキストが適切な方法で構造化されて提供されているかを調べました。見出し（`H1`、 `H2`、 `H3`、など）を使ってページを整え構造化すれば、コンテンツは読みやすく、解析しやすいようになります。そんな見出しの重要性にもかかわらず、ページの10.67%には見出しタグがまったくありませんでした。

{{ figure_markup(
  image="fig2.png",
  caption="ページ毎の見出し数分布。",
  description="ページ毎の見出しの分布。 デスクトップもモバイルもページ毎の見出しの中央値は10です。10/25/75/90それぞれのパーセンタイルではデスクトップの場合 0、3、21、39となっており、モバイルの見出し分布よりも少しだけ高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=676369575&format=interactive"
  )
}}

１ページあたりの見出し要素の中央値は10となっています。見出しにはモバイルページで30単語、デスクトップページで32単語が含まれています。これは、見出しを活用できているWebサイトが、ページが読みやすく、説明的で、ページの構造とコンテキストを検索エンジンボットに明確に概説することに多大な労力を費やしていることを意味します。

{{ figure_markup(
  image="fig3.png",
  caption="ページ毎のH1の長さの分布。",
  description="ページ毎の最初のH1文字数の分布。デスクトップとモバイルの分配はほぼ同様となっており、10、25、50、75、90パーセンタイルで6、11、19、31、47文字です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1380411857&format=interactive"
  )
}}

具体的な見出しの長さを見ると、最初に見つかった`H1`要素の長さの中央値はデスクトップで19文字です。

SEOとアクセシビリティのための`H1`と見出しの処理に関するアドバイスについては、Ask Google Webmastersシリーズの<a hreflang="en" href="https://www.youtube.com/watch?v=zyqJJXWk0gk">John Muellerによるこのビデオの回答</a>をご覧ください。

### メタタグ

メタタグを使用すると、ページ上の色々な要素やコンテンツに関する特定の指示や情報を検索エンジンボットに提供できます。特定のメタタグにはページの注目すべき情報や、クロールとインデックス付けの方法などを伝えることができます。私達はWebサイトの提供するメタタグが、これらの機会を最大限に活用しているかどうかを評価したいと考えました。

#### ページのタイトル

{{ figure_markup(
  caption="<code><title></code> タグを含むモバイルページの割合。",
  content="97%",
  classes="big-number"
)
}}

ページのタイトルはページの目的をユーザーや検索エンジンに伝える重要な手段です。`<title>`タグはSERPSの見出にも、ページにアクセスする時のブラウザーのタブのタイトルとしても使われるので、モバイルページの97.1%にドキュメントタイトルが存在することは驚くことではないでしょう。

{{ figure_markup(
  image="fig5.png",
  caption="ページごとのタイトルの長さの分布。",
  description="ページ毎のタイトル要素毎の文字数分布。デスクトップのタイトルの長さそれぞれの10、25、50、75、90パーセンタイルは、4、9、20、40、66文字です。モバイルの分布も非常に似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1015017335&format=interactive"
  )
}}

一般的に<a hreflang="en" href="https://moz.com/learn/seo/title-tag">GoogleのSERPはページタイトルの最初の50〜60文字を表示</a>しますが、`<title>`タグの長さの中央値はモバイルページで21文字、デスクトップページで20文字でした。75パーセンタイルでも、境界を下回っています。これは、一部のSEOとコンテンツの記者が、検索エンジンによって割り当てられたSERPsのホームページを記述するために割り当てられた領域を最大限利用できていないことを示します。

#### メタディスクリプション

`<title>`タグと比べると、メタディスクリプションが検出されたページは少なくなっており、モバイル用ホームページの64.02%にだけメタディスクリプションが設定されています。Googleが検索者のクエリに応じてSERP内のメタディスクリプションの記述を頻繁に書き換えることを考慮すると、おそらくWebサイトの所有者はメタディスクリプションを含めることを重要視しないでしょう。

{{ figure_markup(
  image="fig6.png",
  caption="ページ毎のメタ記述の長さ分布。",
  description="ページ毎のメタ記述毎の文字数分布。デスクトップのタイトルの長さの10、25、50、75、90パーセンタイルはそれぞれ、9、48、123、162、230文字です。モバイルの分布は任意のパーセンタイルでは10文字未満だけわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1750266149&format=interactive"
  )
}}

メタディスクリプションの長さは<a hreflang="en" href="https://moz.com/learn/seo/meta-description">155-160文字が推奨</a>となっていますが、デスクトップページの中央値ははそれより短い123文字となっています。さらに興味深い事があります、モバイルのSERPはピクセル制限により従来よりも短かくなるにも関わらず、メタディスクリプションは一貫してデスクトップよりもモバイルが長くなっています。この制約は最近拡張されたばかりなので、おそらく多くのWebサイトの所有者がモバイルの結果に対して、より長くて説明的なメタディスクリプションの影響を確認しているのでしょう。

#### 画像の`alt`タグ

SEOとアクセシビリティのための`alt`テキストの重要性を考えたとき、モバイルページの46.71%でしか画像に`alt`属性が使われていないのを見ると理想とはほど遠い状況です。これは、Web上の画像をユーザーにとってさらにアクセスしやすく、検索エンジンにとって理解しやすくすることに関しては、まだ改善する点が多く有ることを意味します。この問題に対する詳細については[アクセシビリティ](./accessibility)の章を御覧ください。

### インデクサビリティ

SERPでユーザーにページのコンテンツを表示するためには検索エンジンのクローラーがそのページにアクセスしてインデックスを作れるようにする必要があります。検索エンジンによるページのクロールとインデックス登録の機能に影響を与える要因には次の様なものがあります。

- ステータスコード
- `noindex`タグ
- canonicalタグ
- `robots.txt`ファイル

#### ステータスコード

検索エンジンにインデックスを付けたい重要なページは常に`200 OK`ステータスコードにしておく事をお勧めします。テストされたページの殆どは検索エンジンにアクセス可能で、デスクトップでは最初のHTML要求の87.03%が`200`ステータスコードを返しました。モバイルの場合は少しだけ低く、82.95%のページだけが`200`となるステータスコードを返しました。

モバイルでは次によく見られるステータスコードは一時的なリダイレクトである`302`となっており、これはモバイルページの10.45%で見つけることができました。この結果はデスクトップよりも多く、デスクトップ用のホームページで`302`ステータスコードを返すのは6.71%しかありませんでした。これは、モバイル用のホームページがレスポンシヴでなく<a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">デバイスごとにWebサイトのバージョンが異なるような</a>、デスクトップページの代替が用意されていることに起因している可能性があります。

<p class="note">注意：この結果にはステータスコード<code>4xx</code>と<code>5xx</code>は含んでいません。</p>

#### `noindex`

`noindex`指示はHTMLの `<head>`もしくはHTTPヘッダーの`X-Robots`指示で使うことができます。`noindex`指示は基本的に検索エンジンにそのページをSERPに含めないように指示しますが、ユーザーがWebサイトを操作しているときでもページはアクセス可能です。一般的に`noindex`指示は、同一コンテンツを提供するページの複製バージョン、またはオーガニック検索からWebサイトにアクセスするユーザーに価値を提供しないであろう低品質のページ(フィルタ、ファセット、内部検索ページなど)に追加されます。

モバイル用ページの96.93%が<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/indexing">Lighthouseのインデックス作成監査に合格しており</a>、これらのページには`noindex`指示が含まれていませんでした。ただし、これはモバイルホームページの3.07%に`noindex`指示が含まれていたことも意味しています。これは心配の種であり、Googleはこれらのページのインデックスを作成できないことを意味しています。

<p class="note">私達の調査に含まれるWebサイトは<a href="./methodology#chrome-ux-report">Chrome UX Report</a>のデータセットから提供されていますが、公開されていないWebサイトは除外されています。これはChromeが非公開であると判断したサイトは分析できないので、バイアスの重要な源です。これについては<a href="./methodology#websites">方法論</a>の詳細を御覧ください。</p>

#### canonicalによる最適化

canonicalタグを使い重複ページと優先代替ページを指定します。これにより検索エンジンは、グループ内の複数のページに散っているオーソリティを1つのメインページに統合してランキングの結果を上げることができます。

モバイル用ホームページの48.34%でcanonicalタグが使われていることが<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/canonical">検出</a>されました。自分を指ししめすcanonicalタグは必須でなく、普通は複製されたページにcanonicalタグを必要とします。ホームページがサイトのどこか他の場所に複製されることはめったに無いので、canonicalタグがページ毎で半分未満になっているのは驚くことではありません。

#### robots.txt

検索エンジンのクロールを制御する最も効果的な方法の1つは、<a hreflang="en" href="https://www.deepcrawl.com/knowledge/technical-seo-library/robots-txt/">`robots.txt`ファイル</a>です。これは、Webサイトのルートドメインに置かれる事で、検索エンジンのクロールに対し許可しないURLとURLパスを指定する事ができるファイルです。

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/robots">Lighthouseの結果</a>からモバイル用サイトの72.16%でしか有効な`robots.txt`を持っていないことがわかりました。見つかった問題の主な内訳は、`robots.txt`ファイルをまったく持たないサイトが22%、無効な`robots.txt`ファイルを提供する約6%で、それぞれ検査に失敗しています。<a hreflang="en" href="https://webmasters.googleblog.com/2017/01/what-crawl-budget-means-for-googlebot.html">クロールバジェットの問題</a>に悩まされないような小規模Webサイトを運営していたりするなど、`robots.txt`ファイルを持たない妥当な理由もあったりしますが、無効な`robots.txt`が有るというのは、それだけで心配の種になります。

### リンク

Webページの最も重要な属性の1つはリンクです。リンクは検索エンジンがインデックスに追加してWebサイトをナビゲートするための新しい関連ページを発見するのに役立ちます。データセットにあるWebページの96%には最低でも1つの内部リンク存在し、93%は少なくとも１つの別ドメインへの外部リンクが存在しています。内部や外部リンクを持たないごく一部のページは、ターゲットページへ通じるリンクという大きな価値を取りこぼしています。

デスクトップ用のページに含まれる内部と外部リンクの数は、モバイル用のページよりも全ての場合で多くなっています。これは殆どの場合、モバイルのデザインはビューポートが小さく空間が限られているために、リンクが含まれるテキストはデスクトップに比べて少なくなっているためです。

モバイル用のページで内部リンクが少ない場合、Webサイトで<a hreflang="en" href="https://moz.com/blog/internal-linking-mobile-first-crawl-paths">問題が発生する可能性</a>が有るため注意が必要です。新しいWebサイトでGoogleの規定である<a hreflang="en" href="https://www.deepcrawl.com/knowledge/white-papers/mobile-first-index-guide/">モバイルファーストインデックス</a>が適用されると、そのページがデスクトップ用ではリンクされているがモバイル用からリンクが無い時、検索エンジンはそのページを見つけてランク付けするのがとても難しくなってしまいます。

{{ figure_markup(
  image="fig7.png",
  caption="ページ毎の内部リンク分布。",
  description="ページ毎の内部リンク数の分布。デスクトップの内部リンクは10、25、50、75、90パーセンタイルごとに、7、29、70、142、261となっています。モバイル分布はかなり低く、90パーセンタイルでリンク数は30、中央値で10となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=534496673&format=interactive"
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="ページ毎の外部リンク数の分布。",
  description="ページ毎の外部リンク数の分布。デスクトップの外部リンクは10、25、50、75、90パーセンタイルごとに、1、4、10、22、51となっています。モバイルの分布はかなり低く、90パーセンタイルでリンク数は11、中央値で2となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1997009875&format=interactive"
  )
}}

デスクトップ用ページの内部リンク(同一サイト)数は中央値で70となっていますが、モバイル用ページの内部リンク数の中央値は60になっています。外部リンク数のページ毎中央値も同じような傾向となっており、デスクトップ用ページの外部リンク数は10で、モバイル用ページは8になっています。

{{ figure_markup(
  image="fig9.png",
  caption="ページ毎のアンカーリンク数の分布。",
  description="ページ毎のアンカーリンク数の分布。デスクトップの内部アンカーは10、25、50、75、90パーセンタイルに対して、0、0、0、1、3となっています。モバイルの分布も同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1852200766&format=interactive"
  )
}}

同一ページの特定スクロール位置にリンクするアンカーリンクはあまり人気が無いようです。ホームページの65%以上でアンカーリンクは使われていません。これはおそらく、一般的なホームページには長文形式のコンテンツが含まれていないからでしょう。

説明的なリンクテキストの測定からは良いニュースが伺えます。モバイル用ページの89.94%が<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/descriptive-link-text">Lighthouseの説明的なリンクテキストの監査</a>で合格しています。つまり、これらのページは一般的な「ここをクリック」「リンク」「続きを読む」「全文表示」のようなリンクを使わず、より有意義なリンクテキストを使うことで、ユーザーと検索エンジンにページのコンテキストやページ同士のつながりがあることを理解できるようにしています。

## Advanced

説明的で有用なコンテンツ以外に対して`noindex`や`Disallow`という指示を出してページを検索エンジンからブロックするだけでは、Webサイトをオーガニックサーチさせるには不十分です。これらは単なる基本でしかありません。WebサイトのパフォーマンスやSERPsの外観を向上させるなど、できることはたくさんあります。

Webサイトのインデックス作成とランク付成功のために重要となっている技術的に複雑な局面として、速度、構造化データ、国際化、セキュリティ、モバイルフレンドリーなどがあります。

### Speed

モバイルの読み込み速度は、<a hreflang="en" href="https://webmasters.googleblog.com/2018/01/using-page-speed-in-mobile-search.html">2018年にGoogleからランキング要素として初めて発表</a>されました。しかしGoogleにとって速度は新しい観点ではありません。2010年に既に速度が<a hreflang="en" href="https://webmasters.googleblog.com/2010/04/using-site-speed-in-web-search-ranking.html">ランキングシグナルとして導入されたことが明らか</a>にっています。

Webサイトが高速であることは、優れたユーザー体験のためにも重要です。サイトの読み込みに数秒待たされるユーザは、すぐ離脱してSERPsから別の似たような内容の素早く読み込まれるページを探す傾向があります。

Web全体の読み込み速度の分析に使った指標は [Chrome UX Report](./methodology#chrome-ux-report)（CrUX）を基にしています。このレポートは、実際のChromeユーザーからデータを収集します。このデータで驚くべき点は、48%のWebサイトが**遅い**とラベル付されていることです。FCPの25%が3秒より遅い場合、_もしくは_ FIDの5%が300ミリ秒より遅い場合にWebサイトは低速とラベル付されます。

{{ figure_markup(
  image="fig10.png",
  caption="デバイスタイプごとのユーザー体験パフォーマンスの分布。",
  description="デスクトップ、電話、タブレットのパフォーマンスにおけるユーザー体験の分布。 デスクトップ：2%高速、52%中程度、46%低速。 電話：高速1%、中程度41%、低速58%。 タブレット：高速0%、中程度35%、低速65%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=2083126642&format=interactive"
  )
}}

デバイスごとに分けるとより鮮明になります、この画像ではタブレット(65%)、電話(58%)を示しています。

数字だけ見るとWebの速度には暗雲が立ち込めるように思えますが、良いニュースもあります。それはSEOの専門家とツールがWebサイトの高速化のための技術課題に集中しているという点です。Webパフォーマンスの状態については[パフォーマンス](./performance)の章で詳しく知ることができます。

### 構造化データ

構造化データを使うことでWebサイトの所有者は、[JSON-LD](https://en.wikipedia.org/wiki/JSON-LD)スニペットや[Microdata](https://developer.mozilla.org/docs/Web/HTML/Microdata)などを加える事で、Webページに付属的なセマンティックデータを付与できます。検索エンジンはこのデータを解析してこれらのページを深く理解し、マークアップにより検索結果に追加の関連情報を表示も行う事ができます。よく見る構造化データの種類には次のようなものがあります。

- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/review-snippet">reviews</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/product">products</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/local-business">businesses</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/movie">movies</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/guides/search-gallery">その他</a>

構造化データがWebサイトに提供できる<a hreflang="en" href="https://developers.google.com/search/docs/guides/enhance-site">追加の可視性</a>はユーザーがサイトに訪れる機会を増やすのに役立つため、サイトの所有者にとっては魅力的です。たとえば、比較的新しい<a hreflang="en" href="https://developers.google.com/search/docs/data-types/faqpage">FAQスキーマ</a>はスニペットとSERPsの領域を２倍にできます。

調査の結果、モバイルでリッチな結果を得ることが出来るサイトは14.67%しか無いことが解りました。興味深いことに、デスクトップサイトの適格性はわずかに低くなり12.46%となっています。これはサイト所有者がホームページ検索で表示されるための最適化に対して、もっと出来ることが有ることを示しています。

構造化データのマークアップを持つサイトの中で、最もよく見る種類は次の５つでした。

1. `WebSite` (16.02%)
2. `SearchAction` (14.35%)
3. `Organization` (12.89%)
4. `WebPage` (11.58%)
5. `ImageObject` (5.35%)

興味深いことに、一番良く利用されている検索エンジンの機能をトリガーするデータ型は<a hreflang="en" href="https://developers.google.com/search/docs/data-types/sitelinks-searchbox">サイトリンクの検索ボックス</a>を強化する`SearchAction`です。

トップ5のマークアップタイプはすべてGoogleの検索結果の可視性を高める物で、これらのタイプの構造化データをさらに採用する理由になるかもしれません。

今回の分析はホームページだけを見ているため、インテリアページも考慮した場合は結果は大きく異なった結果が見えてくる可能性があります。

レビューの星はWebのホームページ上で1.09%だけにしかありません。(<a hreflang="en" href="https://schema.org/AggregateRating">AggregateRating</a>より)また、新しく導入された<a hreflang="en" href="https://schema.org/QAPage">QAPage</a>は48の例しかなく、<a hreflang="en" href="https://schema.org/FAQPage">FAQPage</a>は少しだけ高い数が出現して218となっています。この最後の2種類の数については、クロールを更に実行してWeb Almanacの分析を掘り下げていくと、将来増加することが予想されています。

### 国際化

[一部のGoogle検索の従業員](https://x.com/JohnMu/status/965507331369984002)によれば、国際化はSEOの最も複雑な面の1つとなっているようです。SEOの国際化は、ユーザーが特定の言語のコンテンツをターゲットしていることを確認し、それに合わせて複数の言語や国のバージョンを持つWebサイトから適切なコンテンツを提供することに重点をおいています。

HTML lang属性が英語に設定されているデスクトップ用サイトの38.40%（モバイルでは33.79%）で、別の言語バージョンへの `hreflang`リンクが含まれるサイトはたった7.43%（モバイルで6.79%）しかありませんでした。これから、分析したWebサイトの殆どが言語ターゲティングを必要とするホームページの別バージョンを提供していないことを示しています。しかしそれは、個別のバージョンは存在するが構成が正しく無い場合を除きます。

<figure>
  <table>
    <thead>
      <tr>
        <th><code>hreflang</code></th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>en</td>
        <td class="numeric">12.19%</td>
        <td class="numeric">2.80%</td>
      </tr>
      <tr>
        <td>x-default</td>
        <td class="numeric">5.58%</td>
        <td class="numeric">1.44%</td>
      </tr>
      <tr>
        <td>fr</td>
        <td class="numeric">5.23%</td>
        <td class="numeric">1.28%</td>
      </tr>
      <tr>
        <td>es</td>
        <td class="numeric">5.08%</td>
        <td class="numeric">1.25%</td>
      </tr>
      <tr>
        <td>de</td>
        <td class="numeric">4.91%</td>
        <td class="numeric">1.24%</td>
      </tr>
      <tr>
        <td>en-us</td>
        <td class="numeric">4.22%</td>
        <td class="numeric">2.95%</td>
      </tr>
      <tr>
        <td>it</td>
        <td class="numeric">3.58%</td>
        <td class="numeric">0.92%</td>
      </tr>
      <tr>
        <td>ru</td>
        <td class="numeric">3.13%</td>
        <td class="numeric">0.80%</td>
      </tr>
      <tr>
        <td>en-gb</td>
        <td class="numeric">3.04%</td>
        <td class="numeric">2.79%</td>
      </tr>
      <tr>
        <td>de-de</td>
        <td class="numeric">2.34%</td>
        <td class="numeric">2.58%</td>
      </tr>
      <tr>
        <td>nl</td>
        <td class="numeric">2.28%</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td>fr-fr</td>
        <td class="numeric">2.28%</td>
        <td class="numeric">2.56%</td>
      </tr>
      <tr>
        <td>es-es</td>
        <td class="numeric">2.08%</td>
        <td class="numeric">2.51%</td>
      </tr>
      <tr>
        <td>pt</td>
        <td class="numeric">2.07%</td>
        <td class="numeric">0.48%</td>
      </tr>
      <tr>
        <td>pl</td>
        <td class="numeric">2.01%</td>
        <td class="numeric">0.50%</td>
      </tr>
      <tr>
        <td>ja</td>
        <td class="numeric">2.00%</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td>tr</td>
        <td class="numeric">1.78%</td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td>it-it</td>
        <td class="numeric">1.62%</td>
        <td class="numeric">2.40%</td>
      </tr>
      <tr>
        <td>ar</td>
        <td class="numeric">1.59%</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td>pt-br</td>
        <td class="numeric">1.52%</td>
        <td class="numeric">2.38%</td>
      </tr>
      <tr>
        <td>th</td>
        <td class="numeric">1.40%</td>
        <td class="numeric">0.42%</td>
      </tr>
      <tr>
        <td>ko</td>
        <td class="numeric">1.33%</td>
        <td class="numeric">0.28%</td>
      </tr>
      <tr>
        <td>zh</td>
        <td class="numeric">1.30%</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td>sv</td>
        <td class="numeric">1.22%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>en-au</td>
        <td class="numeric">1.20%</td>
        <td class="numeric">2.31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="よく見る <code>hreflang</code> 値のトップ25。") }}</figcaption>
</figure>

英語の次に最もよく見る言語は、フランス語、スペイン語、およびドイツ語です。この後にアメリカ人向けの英語（`en-us`）やアイルランド人向けのスペイン語（`es-ie`）などの不明瞭な組み合わせなどの、特定の地域を対象とした言語が続いています。

この分析では、異なる言語バージョン同士が相互で適切にリンクしているかどうかなどの正しい実装は確認しませんでした。しかし、<a hreflang="en" href="https://www.google.com/url?q=https://support.google.com/webmasters/answer/189077?hl%3Den&sa=D&ust=1570627963630000&usg=AFQjCNFwzwglsbysT9au_I-7ZQkwa-QvrA">推奨にある</a>x-defaultバージョン（デスクトップでは3.77%、モバイルでは1.30%）の採用が少ない点を考慮すると、この要素が複雑で常に正しいとは限らないということを示しています。

### SPAのクロールに関する可能性

ReactやVue.jsなどのフレームワークで構築されたシングルページアプリケーション（SPA）には、独特のSEOの複雑さが伴っています。ハッシュを使ったナビゲーションを使用するWebサイトは検索エンジンがクロールして適切にインデックスを作成するのがとても難しくなります。例を上げると、Googleには「AJAXクロールスキーム」という回避策がありましたが、開発者だけでなく検索エンジンにとっても難解であることが判明し、この仕様は<a hreflang="en" href="https://webmasters.googleblog.com/2015/10/deprecating-our-ajax-crawling-scheme.html">2015年に廃止</a>されました。

ハッシュURLを介して提供されるリンクの数が比較的少なく、Reactモバイルページの13.08%がナビゲーションにハッシュURLを使用し、モバイルVue.jsページで8.15%、モバイルAngularページで2.37%で使用されているという結果になっています。この結果はデスクトップ用ページでも非常に似通った結果でした。ハッシュURLからコンテンツの発見に対する影響を考慮すると、この結果はSEOの観点からは良い状態と言えるでしょう。

特に驚いた点は、ハッシュURLの数がAngularページでは少ないのとは対照的に、ReactページでのハッシュURLの数が多くなっている点です。両方のフレームワークはハッシュURLに依存せず、代わりにリンク時に[History API](https://developer.mozilla.org/docs/Web/API/History)が標準となっているルーティングパッケージの採用を推奨しています。Vue.jsは`vue-router`パッケージのバージョン3から、<a hreflang="en" href="https://github.com/vuejs/rfcs/pull/40">History APIを標準で使うことを検討</a>しています。

### AMP

AMP（以前は「Accelerated Mobile Pages」として知られていました）は、2015年にGoogleによってオープンソースのHTMLフレームワークとして初めて導入されました。キャッシュ、遅延読み込み、最適化された画像などの最適化手法を使うことで、Webサイトのサイトのコンポーネントと基盤構造を提供することで、ユーザーに高速な体験を提供します。特に、Googleは検索エンジンにもこれを採用し、AMPページも独自のCDNから提供されています。この機能は後に<a hreflang="en" href="https://wicg.github.io/webpackage/draft-yasskin-http-origin-signed-responses.html">Signed HTTP Exchanges</a>という名前の標準提案になりました。

にも関わらず、AMPバージョンへのリンクが含まれるモバイルホームページはわずか0.62%しかありません。このプロジェクトの可視性を考慮しても、これは採用率が比較的低い事が示されています。ただし、今回のホームページに焦点を宛てた分析なので、他のページタイプの採用率は見ていません、記事ページを配信する場合はAMPのほうが有利な場合が多いでしょう。

### セキュリティ

近年、WebがデフォルトでHTTPSに移行するという強力なオンラインの変化がありました。HTTPSでは、例えばユーザー入力データが安全に送信されないパブリックWi-FiネットワークでもWebサイトのトラフィックが傍受されるのを防ぎます。GoogleはサイトでHTTPSを採用するよう推進しており、<a hreflang="en" href="https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html">ランキングシグナルとしてHTTPS</a>を作りました。Chromeはブラウザで非HTTPSページを<a hreflang="en" href="https://www.blog.google/products/chrome/milestone-chrome-security-marking-http-not-secure/">非セキュア</a>としてラベル付けすることでセキュアなページへの移行もサポートしています。

HTTPSの重要性とその採用方法に関するGoogleの詳細な情報と手引については、<a hreflang="en" href="https://developers.google.com/web/fundamentals/security/encrypt-in-transit/why-https">HTTPSが重要な理由</a>をご覧ください。

現在、デスクトップ用Webサイトの67.06%がHTTPS経由で配信されていますWebサイトの半分以下がまだHTTPSに移行しておらず、ユーザーに安全でないページを提供しています。これはかなりの数です。移行は大変な作業になる場合が多く、そのために採用率が高くない可能性がありますが、HTTPSの移行に必要なのは大抵の場合SSL証明書と`.htaccess`ファイルの簡単な変更です。  HTTPSに切り替えない理由はありません。

<a hreflang="en" href="https://transparencyreport.google.com/https/overview">Googleの透明性レポート</a>では、Google以外の上位100ドメインでhttpsの採用率は90%であると報告されています(これは世界中のWebサイトトラフィックの25%です)。この数字と私たちの数字の違いから、比較的小規模なサイトはゆるやかにHTTPSを採用しているという事実によって説明できます。

セキュリティの状態の詳細については、[セキュリティ](./security)の章を御覧ください。

## 結論

分析の結果、ほとんどのWebサイトでは基礎がしっかりしている事が判明しました。ホームページはクロール可能で、インデックス付け可能で、検索エンジンの結果ページでのランキングに必要な主要コンテンツが存在しています。Webサイトを所有する人々がSEOを熟知しているわけではなく、ベストプラクティスの指針などは言うまでもありません。つまり、これらの非常に多くのサイトが基本をカバーしていることは非常に頼もしいことです。

しかし、SEOとアクセシビリティのより高度な面のいくつかに関しては、予想していたよりも多くのサイトが注目していません。サイトの速度については、特にモバイルのときに多くのWebサイトが苦労している要因の一つになっており、これは大きな問題です。なぜなら速度はUXの最大の要因の1つで、ランキングに影響を与える可能性があるためです。HTTPS経由でまだ提供されていないWebサイトの数も、セキュリティの重要性を考慮してユーザーデータを安全に保つという点に問題があるように見えます。

私達全員がSEOのベストプラクティスを学んだり、業界の発展に貢献できることはたくさんあります。これは、検索業界が進化する性質を持ちながら、その変化の速度から必要な事です。検索エンジンは毎年数千のアルゴリズムを改善しています、Webサイトがオーガニックサーチでより多くの訪問者に届くようにしたい場合、置いていかれないようにする必要があります。
