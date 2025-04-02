---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: マークアップ
description: 2024年版Web Almanacのマークアップの章では、ドキュメントデータ（doctype、圧縮、言語、HTML適合性、ドキュメントサイズ）、HTML要素と属性の使用、データ属性、ソーシャルメディアについて解説します。
hero_alt: Web Almanacのキャラクターが建設作業員として、HTMLの要素ブロックからウェブページを組み立てているヒーロー画像。
authors: [guaca]
reviewers: [bkardell, j9t, zcorpan]
analysts: [guaca]
editors: []
translators: [ksakae1216]
guaca_bio: Estela Francoは、Schneider ElectricのウェブパフォーマンスとテクニカルSEOのスペシャリストです。それ以外にも、コミュニティとの繋がりを大切にしています。国際会議のスピーカー、ウェブテクノロジーのGoogle Developer Expert、Storyblokアンバサダー、Barcelona Web Performanceミートアップの共同主催者、そしてMujeres en SEOコミュニティの共同設立者として活動しています。
results: https://docs.google.com/spreadsheets/d/1TtOMr_w58HvqNBv4RIWX021Lxm6m5ajYOcRykrPdAJc/
featured_quote: すべてのウェブサイト、ウェブアプリケーション、オンラインでのやり取りは、その核となるHTMLから始まり、もっとも重要なウェブ標準の1つとなっています。
featured_stat_1: 92.8%
featured_stat_label_1: HTMLのdoctypeを使用しているドキュメント
featured_stat_2: 32 KB
featured_stat_label_2: HTMLドキュメントの転送サイズの中央値
featured_stat_3: 29%
featured_stat_label_3: `div`要素の割合
doi: 10.5281/zenodo.14065478
---

## はじめに

私たちが知るウェブは、HTMLという基盤の上に構築されています。すべてのウェブサイト、ウェブアプリケーション、オンラインでのやり取りは、その核となるHTMLから始まり、もっとも重要なウェブ標準の1つとなっています。HTMLは、コンテンツを構造化し、関係性を定義し、ブラウザとコミュニケーションを取ることで、私たちが作成したものを世界中のユーザーが閲覧、操作、理解できるようにする言語です。この章では、2024年においてHTMLがどのようにウェブを形作り続けているのか、その使用傾向、カスタム要素の台頭、開発者がよりアクセシブルで効率的、そして将来性のあるウェブサイトを構築するために新機能をどのように活用しているのかを探ります。

今年の版では、データセットにホームページだけでなく、さまざまな二次ページも含まれており、より広い視点を提供しています。ウェブサイトの入り口を超えたページを分析することで、異なるタイプのコンテンツやコンテキストにおけるHTMLの使用状況をより正確に把握できます。ブログ投稿、商品ページ、ログイン画面、記事アーカイブなど、この拡張された範囲により、HTMLの実際の応用についてより深い洞察が得られます。

読者の皆さんには、このデータをより深く掘り下げ、独自の洞察を探求し、ウェブの基礎となる言語の未来について議論に参加していただきたいと思います。

## 一般

マークアップドキュメントのより一般的な側面から見ていきましょう。このセクションでは、ドキュメントタイプ、ドキュメントのサイズ、言語、圧縮について説明します。

### Doctypes

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th><a href="https://hsivonen.fi/doctype/" target="_blank">レンダリングモード</a></th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`<!doctype html>`</td>
        <td>標準モード</td>
        <td class="numeric">91.7%</td>
        <td class="numeric">92.8%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"`</td>
        <td>準標準モード</td>
        <td class="numeric">3.4%</td>
        <td class="numeric">2.7%</td>
      </tr>
      <tr>
        <td>doctypeなし</td>
        <td>互換モード</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd xhtml 1.0 strict//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd"`</td>
        <td>標準モード</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd html 4.01 transitional//en" "http://www.w3.org/tr/html4/loose.dtd"`</td>
        <td>準標準モード</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd html 4.01 transitional//en"`</td>
        <td>互換モード</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Doctypeの使用状況。",
      sheets_gid="1243074845",
      sql_file="doctype.sql",
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  content="92.8%",
  caption="標準のHTML doctypeを使用しているモバイルページ。",
  classes="big-number",
  sheets_gid="1243074845",
  sql_file="doctype.sql",
) }}

モバイルページの93%が標準のHTML doctype、つまり`<!DOCTYPE html>`を使用しています。

これは[2022年のデータ](../2022/markup#doctypes)と比べて3ポイント高くなっています。興味深いのは、2番目に多いのが`XHTML 1.1 Transitional`であることです。ただし、これは徐々に減少しており（2022年の3.9%から2.7%に減少）。

### ドキュメントサイズ

ページのドキュメントサイズは、圧縮を含むネットワーク経由で転送されるHTMLバイト数です。

{{ figure_markup(
  image="document_trends.png",
  caption="HTMLドキュメントの転送サイズの中央値。",
  description="HTMLドキュメントの転送サイズの中央値を示す棒グラフ。2022年は、デスクトップで31 kB、モバイルで29 kB。2023年は、デスクトップで30 kB、モバイルで29 kB。2024年は、デスクトップで33 kB、モバイルで32 kB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1823253654&format=interactive",
  sheets_gid="1730786160",
  sql_file="document_trends.sql"
  )
}}

2023年にわずかな減少を見せた後、HTML転送サイズは2022年と2023年と比較して今年は増加しました。

中央値は妥当な数値に見えますが、他のパーセンタイルをより詳しく見てみましょう。

{{ figure_markup(
  image="document_size_distribution.png",
  caption="HTMLドキュメントの転送サイズの分布。",
  description="転送サイズの10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルの値はそれぞれ6、13、32、71、147 kB。デスクトップの値はそれぞれ6、14、33、73、148 kB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1780108383&format=interactive",
  sheets_gid="619373506",
  sql_file="document_size_distribution.sql"
  )
}}

パーセンタイルの分布を見ると、10パーセンタイルではHTMLファイルは6 KBと小さく、90パーセンタイルでは147 KBに達します。この極端な差は、開発者がページをどのように構造化しているかに大きな違いがあることを示しています。

### 圧縮

HTMLドキュメントファイルの分析において、圧縮は読み込み時間と全体的なパフォーマンスを改善する上で重要な役割を果たし続けています。

{{ figure_markup(
  image="content_encoding.png",
  caption="HTMLドキュメントのコンテンツエンコーディング。",
  description="積み上げ棒グラフで、デスクトップの36%とモバイルの37%のHTMLドキュメントがBrotliで圧縮され、デスクトップの53%とモバイルの52%のドキュメントがGzipで圧縮され、デスクトップとモバイルの11%のHTMLドキュメントが圧縮されていないことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1114599297&format=interactive",
  sheets_gid="1573442294",
  sql_file="content_encoding.sql"
  )
}}

注目すべき傾向の1つは、Brotli（`br`）圧縮形式の人気の高まりです。2024年には、Brotliはモバイルページの37%で使用されており、2023年の28%から着実に増加しています。

`gzip`はもっとも広く使用されている圧縮方式（モバイルで52%）ですが、`br`が普及するにつれて、その使用率は前年から若干減少しています（2022年は58%）。

これらの改善にもかかわらず、HTMLファイルの一部（モバイルで10.5%）は依然として圧縮なしで提供されており、最適化の機会を逃しています。

### ドキュメント言語

{{ figure_markup(
  content="5,625",
  caption="モバイルでの一意のlang属性コードの数。",
  classes="big-number",
  sheets_gid="134927112",
  sql_file="distinct_lang.sql",
) }}

分析では、モバイルの`html`要素で5,625の一意の`lang`属性のインスタンスを確認しました。

HTML `lang`属性は、スクリーンリーダーや検索エンジンがウェブページのコンテンツの言語を理解するのに重要な役割を果たしています。しかし興味深いことに、Google検索はページの言語を判断する際にlang属性を無視します。これは[「ほとんど常に間違っている」と特定した](https://www.youtube.com/watch?v=isW-Ke-AJJU&t=3354s)ためです。これは、実際のコンテンツの言語が異なる可能性があるにもかかわらず、`en`がデータセットで主要な言語属性として、デスクトップの44.2%とモバイルの40.5%で使用されている理由を説明するかもしれません。

{{ figure_markup(
  image="popular_lang.png",
  caption="もっとも人気のあるHTML言語コード（地域を含まない）。",
  description="データセットの上位10言語の使用状況を示す棒グラフ。英語が40%、未設定が13%、スペイン語、日本語、ドイツ語、フランス語、ポルトガル語、ロシア語、イタリア語、オランダ語が6%から2%の範囲でさまざまな使用率を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1428231971&format=interactive",
  sheets_gid="546119077",
  sql_file="lang.sql",
  width=600,
  height=520
  )
}}

さらに、13%のページで`lang`属性が設定されていません。これは多くのウェブサイトがこの指標を提供できていないことを示しています。

非英語および「未設定」以外の`lang`値のパーセンテージを集計すると、全ページの約46%を占めており、ウェブコンテンツの真のグローバル性を反映しています。ただし、上述のように、`lang`属性の誤設定が頻繁にあることを考えると、`en`値の高い割合が必ずしもコンテンツが英語であることを意味しないことを覚えておくことが重要です。

{{ figure_markup(
  image="popular_regional_lang.png",
  caption="もっとも人気のあるHTML言語コード（地域を含む）。",
  description="データセットの上位10言語の使用状況を示す棒グラフ（地域を含む）。英語が22%、アメリカ英語が15%、日本語、スペイン語、ブラジルポルトガル語、イギリス英語、ドイツのドイツ語、ロシア語、ドイツ語が5%から2%の範囲でさまざまな使用率を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=672282298&format=interactive",
  sheets_gid="546119077",
  sql_file="lang.sql",
  width=600,
  height=520
  )
}}

非英語言語に関しては、`ja`（日本語）と`es`（スペイン語）がもっとも人気のある選択肢の一部として際立っており、ページの約5-6%で使用されています。

もっとも一般的な地域バリアントである`en-us`は、デスクトップの16.7%とモバイルの15%のページで使用されています。


lang属性値の誤りの問題はありますが、この属性はアクセシビリティの向上に重要な役割を果たし続けています。スクリーンリーダーを使用するユーザーにとって、`lang`属性を正しく設定することは、現代のウェブ開発において不可欠な実践です。

### コメント

HTMLコメントは、開発者がコードにメモや説明を残すためにコードに含めるテキストの断片で、ウェブページの視覚的な表示には影響を与えません。これらのコメントは`<!-- -->`タグで囲まれ、ブラウザによってレンダリングされないため、ユーザーには表示されません。開発プロセスでは有用ですが、HTMLコメントは本番コードでは必要なく、エンドユーザーに利点がないままファイルサイズをわずかに増加させる可能性があります。

{{ figure_markup(
  content="86%",
  caption="少なくとも1つのコメントを含むモバイルページ。",
  classes="big-number",
  sheets_gid="1268900609",
  sql_file="comments.sql",
) }}

分析によると、モバイルページの86%が少なくとも1つのコメントを含んでいます。

通常のコメントに加えて、**条件付きコメント**として知られる特定のタイプがあります。これらはかつて、Internet Explorer（IE）の特定のバージョンをターゲットにするために広く使用され、開発者は古いIEブラウザのみが処理するカスタムスタイルやスクリプトを提供できました。

`<!--[if IE]>`
`<link rel="stylesheet" href="ie-only-styles.css">`
`<![endif]-->`

モダンブラウザとInternet Explorerの廃止により、条件付きコメントは時代遅れになりました。それにもかかわらず、モバイルページの **26%** がまだ条件付きコメントを含んでおり、これは整理されなかったレガシーコードのため、または一部のサイトが互換性のために古いバージョンのInternet Explorerをサポートし続けているためと考えられます。

## 要素

このセクションでは、HTML要素について探っていきます。どの要素が一般的に使用され、どのくらいの頻度で出現し、典型的なページでどの要素を見つけられるかを見ていきます。また、カスタム要素と時代遅れの要素についても見ていきます。そして明確にしておきましょう。「divitis」はまだ存在するのでしょうか？はい、存在します。

### 要素の多様性

デスクトップとモバイルの両方のページで、10パーセンタイルでは22の異なる要素があり、90パーセンタイルではデスクトップで44要素、モバイルで43要素に達しています。モバイルページの異なる要素の中央値は今年も32で一貫しており、[2022年と同じ](../2022/markup#要素の多様性)で、[2021年の31](../2021/markup#要素の多様性)からわずかに高くなっています。

{{ figure_markup(
  image="distinct_elements_per_page.png",
  caption="ページごとの異なる要素タイプの数の分布。",
  description="ページごとの異なる要素の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルの値はそれぞれ22、27、32、38、43。デスクトップの値はそれぞれ22、27、33、38、44。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1344861022&format=interactive",
  sheets_gid="1098213395",
  sql_file="element_count_distribution.sql"
  )
}}

ただし、ページごとの要素の分布を確認すると、いくつかの違いがあります。データは[2022年と比較して](../2022/markup#要素の多様性)わずかな減少を示しています。モバイルでは、要素の中央値が2022年の653から2024年には594に減少しています。下位の10パーセンタイルでは、モバイルで192から180へのわずかな減少を示しています。90パーセンタイルもわずかな減少を示し、モバイルページは1,832から1,716に減少しています。この全体的な減少は、使用されるHTML要素の数の面でページがわずかにスリム化していることを示唆しています。

{{ figure_markup(
  image="elements_per_page.png",
  caption="ページごとの要素数の分布。",
  description="ページごとの総要素数の10、25、50、75、90パーセンタイルを示す棒グラフ。モバイルの値はそれぞれ180、342、594、1,010、1,716。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1742977516&format=interactive",
  sheets_gid="1098213395",
  sql_file="element_count_distribution.sql"
  )
}}


### 上位要素

以下の要素がもっとも頻繁に使用されています：

<figure>
  <table>
    <thead>
      <tr>
        <th>2021</th>
        <th>2022</th>
        <th>2023</th>
        <th>2024</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
      </tr>
      <tr>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
      </tr>
      <tr>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
      </tr>
      <tr>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
      </tr>
      <tr>
        <td>`img`</td>
        <td>`img`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`script`</td>
        <td>`script`</td>
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td>`meta`</td>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`path`</td>
      </tr>
      <tr>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`path`</td>
        <td>`meta`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="もっとも使用されている要素。",
      sheets_gid="248650818",
      sql_file="element_frequency.sql",
    ) }}
  </figcaption>
</figure>

このリストは前年とほぼ一貫していますが、いくつかの変化が起きています。

{{ figure_markup(
  content="29%",
  caption="div要素である要素の割合。",
  classes="big-number",
  sheets_gid="248650818",
  sql_file="element_frequency.sql",
) }}

`<div>`は依然としてもっとも支配的な要素です。つまり「divitis」はまだ存在し、今後数年間は変わりそうにありません。

{{ figure_markup(
  image="top_elements.png",
  caption="上位HTML要素の頻度。",
  description="上位15のHTML要素の頻度を示す棒グラフ。`div`がもっとも使用されており（モバイルで28.7%）、次いで`a`（12.6%）、`span`（11.2%）、`li`（7.7%）、`script`（3.9%）。残りの上位15要素は`img`、`p`、`link`、`path`、`meta`、`i`、`option`、`ul`、`br`、`td`で、値は3.3%から1.3%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1080941706&format=interactive",
  sheets_gid="248650818",
  sql_file="element_frequency.sql",
  width=600,
  height=656
  )
}}

`<div>`に続いて、`<a>`要素は一貫して2位を維持する重要な要素です。ハイパーリンクの基盤として、サイト間のユーザージャーニーのナビゲーションで重要な役割を果たしています。

近年の注目すべき変化の1つは、`<script>`の使用増加です。2023年には人気度で`<img>`を上回り、動的コンテンツ、インタラクティビティ、フロントエンドロジック、トレースマーケティングキャンペーンに対するJavaScriptへの依存度の高まりを反映しています。この傾向は2024年も続き、`<script>`は5番目によく使用される要素として定着しています。

もう1つの注目すべき変化は、2023年にトップ10入りした`<path>`の台頭です。2024年には`<meta>`を上回り、アイコン、イラスト、グラフィック要素にスケーラブルベクターグラフィックス（SVG）の使用が増加していることを反映しています。

デスクトップとモバイルの両プラットフォームにおける上位HTML要素の採用率は一貫して高く、現代のウェブ開発における基盤的な役割を反映しています。`<html>`、`<head>,`と`<body>`要素はほぼ普遍的で、デスクトップとモバイルの両方のページの99.7%以上で使用されています。

{{ figure_markup(
  image="popularity_of_top_elements.png",
  caption="上位HTML要素の人気度。",
  description="`html`と`head`タグはモバイルページの99.8%で使用され、`body`は99.7%、`meta`は99.2%、`title`は99.1%で使用されています。`div`、`link`、`a`、`script`、`img`、`span`、`p`、`li`、`ul`、`style`が残りの上位15のHTML要素で、値は98.8%から86.2%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1748599287&format=interactive",
  sheets_gid="1606033584",
  sql_file="element_popularity.sql",
  width=600,
  height=656
  )
}}

注目すべき観察として、モバイルページの0.9%で`<title>`タグが欠落しており、これは[2022年のデータ](../2022/markup#トップ要素)（1%）と同様です。

次の要素である`<link>`、`<a>`、`<script>`、`<img>`も高い採用率を示しています。また、上位15要素には含まれていませんが、SVG（スケーラブルベクターグラフィックス）の使用増加も興味深い点です。モバイルでの`<svg>`の採用率は2022年の45.5%から2024年には51.6%に成長し、ウェブ上でよりスケーラブルで解像度に依存しないグラフィックスへの大きな移行を示しています。

### カスタム要素

ハイフンで区切られた名前で簡単に識別できるカスタム要素は、今年も分析で注目を集め、HTMLのネイティブ機能を拡張する上での継続的な重要性を示しています。

{{ figure_markup(
  image="custom_elements_adoption.png",
  caption="年別のカスタム要素の使用状況。",
  description="カスタム要素の使用状況の推移を示す棒グラフ。2022年は、デスクトップサイトの2.9%とモバイルサイトの3.6%がカスタム要素を使用。2023年は、デスクトップサイトの5.1%とモバイルサイトの5.4%がカスタム要素を使用。2024年は、デスクトップサイトの7.7%とモバイルサイトの7.9%がカスタム要素を使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1066623750&format=interactive",
  sheets_gid="1091925040",
  sql_file="custom_elements_adoption.sql"
  )
}}

カスタム要素の使用は近年大幅に増加しており、モバイルでの採用率は2022年の **3.6%** から2024年には **7.9%** に上昇しています。この増加は、開発者とテクノロジーがよりリッチでインタラクティブなウェブ体験を構築するためにカスタム要素を活用する成長傾向を示しています。

ただし、カスタム要素は通常、その機能性とインタラクティビティを有効にするために追加のJavaScriptを必要とします。この要件は、ウェブページのJavaScriptペイロードを調べると特に顕著です。

{{ figure_markup(
  image="custom_elements_js_bytes_distribution.png",
  caption="カスタム要素使用時のJSのkB分布。",
  description="カスタム要素を組み込むモバイルページで使用されるJavaScript（JS）のキロバイト分布を示す棒グラフ。グラフは、カスタム要素を使用するページ（'TRUE'とラベル付け）とカスタム要素を使用しないページ（'FALSE'）間のさまざまなパーセンタイル（10、25、50、75、90）でのJavaScript使用量を比較しています。10パーセンタイル：80 KB（FALSE）対412 KB（TRUE）、25パーセンタイル：229 KB（FALSE）対864 KB（TRUE）、50パーセンタイル（中央値）：522 KB（FALSE）対1,286 KB（TRUE）、75パーセンタイル：1,016 KB（FALSE）対1,784 KB（TRUE）、90パーセンタイル：1,623 KB（FALSE）対2,357 KB（TRUE）。全体的に、カスタム要素を使用するページは、すべてのパーセンタイルでかなり多くのJavaScriptを使用する傾向があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1795165204&format=interactive",
  sheets_gid="1492660858",
  sql_file="custom_elements_js_bytes_distribution.sql"
  )
}}

このグラフでは、中央値でカスタム要素を使用するページは1,286 kBのJavaScriptを使用するのに対し、カスタム要素を使用しないページは522 kBしか必要としないことがわかります。したがって、カスタム要素の台頭はウェブ開発における価値ある進化を表しており、開発者がモジュラーで再利用可能なコンポーネントを作成できるようになりましたが、その使用の影響を考慮することが重要です。

上位10のカスタム要素を詳しく見てみましょう：

{{ figure_markup(
  image="custom_element_popularity.png",
  caption="カスタム要素の人気度。",
  description="要素ごとのページ使用率を示す横棒グラフ。`wow-image`がもっとも使用されており（モバイルで2.7%）、次いで`rs-module-wrap`、`rs-module`、`rs-slides`、`rs-slide`（モバイルで1.6%）、`rs-sbg-wrap`、`rs-sbg`、`rs-sbg-px`、`rs-progress`（モバイルで1%）、`predictive-search`（モバイルで1.4%）となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=300723169&format=interactive",
  sheets_gid="1606033584",
  sql_file="element_popularity.sql",
  width=600,
  height=656
  )
}}

[2022年版](../2022/markup#カスタム要素)でも述べたように、トップ10のカスタム要素のほとんどは<a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a>の `rs-*` 要素が占めています。しかし、今年は新しい（そして意外な）1位が登場しました：`wow-image` 要素です。これはWixサイトで使用される<a hreflang="en" href="https://www.npmjs.com/package/@wix/image"><code>@wix/image パッケージ</code></a>によって使用されています。

今年のトップ10リストの最後にも新顔が登場しています：`predictive-search` です。これはShopifyのコンポーネントで、入力時に候補結果を表示します。

### 廃止された要素

HTML仕様によると、現在<a hreflang="en" href="https://html.spec.whatwg.org/multipage/obsolete.html#non-conforming-features">29の廃止・非推奨要素</a>があります。そして、keygenを除くすべての要素が、今年のデータセットの一部（または多く）のページに出現しています。

{{ figure_markup(
  image="obsolete_elements.png",
  caption="廃止された要素の人気度。",
  description="デスクトップとモバイルデバイスで特定の廃止されたHTML要素を使用しているウェブページの割合を示す棒グラフ。`font`がもっとも使用されており、モバイルページの4.5%で見られ、次いで`center`（モバイルページの4.5%）。残りのリストには`marquee`、`nobr`、`big`、`param`、`strike`、`frame`、`frameset`、`noframes`が含まれ、値は0.9%から0.1%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=496158499&format=interactive",
  sheets_gid="1523691472",
  sql_file="obsolete_elements.sql",
  width=600,
  height=656
  )
}}

これらの結果を[2022年のデータ](../2022/markup#廃止された要素)と比較すると、使用率は緩やかですが着実に減少していることがわかります。注目すべき改善点の1つは、`<center>`要素の使用率が昨年のモバイルサイトの6.1%から今年は4.5%に減少したことです。これは大きな減少を示しており、`<center>`は`<font>`要素に追い抜かれ、現在では4.5%のモバイルページで使用されているもっとも一般的な廃止タグとなっています。興味深いことに、この前向きな傾向にもかかわらず、Googleのホームページのような有名サイトでも、まだマークアップで`<center>`要素を使用しています。

## 属性

このセクションでは、ドキュメントでの属性の使用方法と、`data-*`の使用パターンとソーシャルマークアップについて探ります。

### 上位属性

HTMLでは、属性は要素に付加される key-value ペアで、追加情報を提供したり要素の動作を変更したりします。これらの属性は、スタイル、クラス、リンク、ウェブページ内での動作などの特性を定義する上で基本的なものです。ユーザーやスクリプトによる要素の表示や操作に影響を与えることが多くあります。たとえば、`<img>`タグの`src`属性は画像のソースを定義し、`<a>`タグの`href`属性はリンクの宛先を指定します。

今年も、もっとも使用されている属性は圧倒的に`class`で、モバイルデータセットで480億回出現し、使用されているすべての属性の33%を占めています。

{{ figure_markup(
  image="attribute_usage.png",
  caption="上位属性の頻度。",
  description="上位10のHTML属性の頻度を示す棒グラフ。`class`がもっとも使用されており（モバイルで33%）、次いで`href`（モバイルで8%）、`id`（モバイルで6%）、`style`（モバイルで5%）、`src`（モバイルで3%）。残りのトップ10は`type`、`rel`、`title`、`alt`、`value`で、値は3%から1%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=975284651&format=interactive",
  sheets_gid="927974312",
  sql_file="attributes.sql",
  width=600,
  height=558
  )
}}

そして、ページごとに使用されている属性を見ると、ほぼすべてのページで以下が使用されていることがわかります：

{{ figure_markup(
  image="popularity_attribute_usage.png",
  caption="上位属性の人気度。",
  description="上位10のHTML属性の使用状況を示す棒グラフ。`href`がもっとも使用されており（モバイルページの99%で使用）、次いで`src`（モバイルで99%）、`content`（モバイルで99%）、`name`（モバイルで99%）、`class`（モバイルで99%）。残りのトップ10は`type`、`rel`、`id`、`style`、`alt`で、値は98%から92%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1479935889&format=interactive",
  sheets_gid="927974312",
  sql_file="attributes.sql",
  width=600,
  height=558
  )
}}

### `data-*`属性

ここで、属性のサブセットである`data-*`属性について詳しく見ていきましょう。HTMLでは、開発者は`data-`で始まるカスタム属性を定義できます。これらの属性は、カスタムデータ、注釈、状態情報など、ページやアプリケーション固有の追加情報を格納するように設計されています。既存の属性やタグでは扱えない特定の情報に対して、追加の非標準メタデータを埋め込む方法を提供し、とくに有用です。data-属性はアプリケーションに固有のもので、JavaScriptで簡単にアクセスや操作ができ、動的なコンテンツやデータ状態を管理する柔軟な方法を提供します。

{{ figure_markup(
  content="90%",
  caption="少なくとも1つの`data-*`属性を持つページ。",
  classes="big-number",
  sheets_gid="156537288",
  sql_file="data_attribute_total.sql",
) }}

全体のデータによると、分析されたドキュメントの90%が少なくとも1つの`data-*`属性を使用しています。データを詳しく見ていきましょう。

{{ figure_markup(
  image="data_attribute_popularity.png",
  caption="上位data属性の人気度。",
  description="上位10のHTML `data-*`属性の人気度を示す棒グラフ。`data-id`がもっとも使用されており（モバイルページの24%で使用）、次いで`data-load-time`（モバイルで20%）、`data-tagging-id`（モバイルで20%）、`data-src`（モバイルで19%）、`data-toggle`（モバイルで19%）。残りのトップ10は`data-type`、`data-target`、`data-name`、`data-href`、`data-testid`で、値は17%から10%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1117739253&format=interactive",
  sheets_gid="1682300906",
  sql_file="data_attributes.sql",
  width=600,
  height=558
  )
}}

2022年から2024年にかけての`data-*`属性の人気度を分析すると、その使用方法にいくつかの興味深い変化が見られます。今年、`data-id`がもっとも人気で、モバイルページの24%で使用されており、2022年の19%から大きく増加しています。この増加は、2022年の5位から今年の1位への大きな躍進も示しています。

もう1つの注目すべき変化は、リストに新しい要素が登場したことです：`data-load-time`と`data-tagging-id`は2024年にページの20%で出現し、ランキングの2位と3位を占めています。これらの属性は2022年に特定された`data-*`属性には含まれていなかったもので、パフォーマンス追跡とタグ付けがモダンなウェブ開発でより重要になっていることを示しています。

{{ figure_markup(
  image="data_attribute_frequency.png",
  caption="上位data属性の頻度。",
  description="上位10のHTML `data-*`属性の頻度を示す棒グラフ。`data-id`がもっとも使用されており（モバイルページの全`data-*`属性の5.8%）、次いで`data-element_type`（モバイルで4.1%）、`data-testid`（モバイルで2.8%）、`data-src`（モバイルで2.2%）、`data-widget_type`（モバイルで2.1%）。残りのトップ10は`data-value`、`data-name`、`data-settings`、`data-type`、`data-toggle`で、値は1.4%から0.9%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1977102777&format=interactive",
  sheets_gid="1682300906",
  sql_file="data_attributes.sql",
  width=600,
  height=558
  )
}}

### ソーシャルマークアップ

ソーシャルマークアップとは、HTMLドキュメントに埋め込まれたメタタグのセットで、ウェブコンテンツがソーシャルメディアプラットフォーム上でどのように共有され表示されるかを強化するものです。これらのタグは、タイトル、説明、画像、URLなどの重要なメタデータを提供し、ユーザーがウェブページを共有する際に、Facebook、X（旧Twitter）、LinkedInなどのプラットフォームが正しい情報を取得できるようにします。もっとも一般的なソーシャルマークアップ標準には、Open Graph（`og:`）とTwitter Cards（`twitter:`）があり、どちらもプレビューでコンテンツがどのように表示されるかを定義することで、より豊かで制御された共有体験を提供します。

{{ figure_markup(
  image="social_meta_nodes.png",
  caption="上位ソーシャルメタノードの人気度。",
  description="上位10のHTMLソーシャルメタノードの人気度を示す棒グラフ。`og:title`がもっとも使用されており（モバイルページの61%で使用）、次いで`og:url`（モバイルで58%）、`og:type`（モバイルで56%）、`og:description`（モバイルで53%）、`og:site_name`（モバイルで49%）。残りのトップ10は`og:image`、`twitter:card`、`og:locale`、`twitter:title`、`twitter:description`で、値は46%から24%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1759203973&format=interactive",
  sheets_gid="1216284092",
  sql_file="meta_node_names.sql",
  width=600,
  height=604
  )
}}

2024年のデータによると、もっとも頻繁に使用されているOpen Graphメタタグは`og:title`（モバイルページの61%で使用）と`og:url`（58%）です。これらのタグは共有されるコンテンツのタイトルと正規URLを定義し、`og:type`（56%）と`og:description`（53%）が続き、コンテンツタイプと簡単な要約を提供します。
`twitter:card`（45%）や`twitter:description`（24%）などのTwitter固有のメタタグも、プラットフォームが現在「X」としてブランド変更されているにもかかわらず、依然として広く使用されており、プラットフォーム全体での用語の更新の遅れを示しています。

## その他

これまでのセクションでは、HTMLの概要と、もっともよく使用される要素や属性の採用について説明してきました。このセクションでは、ビューポート、ファビコン、ボタン、入力、リンクなど、いくつかの特殊なケースについてより深く分析します。

### `viewport` の指定

`viewport` メタタグは、`width` や `initial-scale` などのプロパティを設定することで、さまざまなデバイスでコンテンツをどのようにスケーリングするかを指定します。一般的な設定である `width=device-width,initial-scale=1` は、ページが画面の幅いっぱいに表示され、モバイルデバイスで適切なズームレベルで読み込まれることを保証します。

{{ figure_markup(
  image="meta_viewports.png",
  caption="Meta viewport の指定。",
  description="HTMLメタビューポートのトップ10の人気度を示す棒グラフ。`width=device-width,initial-scale=1` がもっとも使用されており（データセットのモバイルページの50%に存在）、次いで `(empty)` （モバイルで5%）、`width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0` （モバイルで4%）、`width=device-width,initial-scale=1,shrink-to-fit=no` （モバイルで4%）、`width=device-width,initial-scale=1,maximum-scale=1` （モバイルで4%）となっています。トップ10の残りは `width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no`、`width=device-width`、`width=320,user-scalable=yes`、`width=device-width,initial-scale=1,minimum-scale=1`、`width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1` で、値は4%から2%の範囲です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=8726003&format=interactive",
  sheets_gid="1271081388",
  sql_file="meta_viewports.sql",
  width=600,
  height=604
  )
}}

現在の使用状況では、もっとも一般的な設定は `width=device-width,initial-scale=1` で、モバイルページの50%に存在します。興味深いことに、分析したモバイルページの5.4%にビューポートタグがありません。つまり、これらのページはモバイル向けに設計されていないということです。その他の設定には、ユーザーのスケーリングを無効にする `width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0` などのバリエーションがあり、モバイルページの4.4%で見られます。

### ファビコン

ウェブサイトに関連付けられた小さなアイコンであるファビコンは、ユーザー体験とブランド認知度を高める上で重要な役割を果たします。これらのアイコンは、ブラウザのタブ、ブックマーク、さらにはユーザーがウェブサイトを保存した際のモバイルのホーム画面にも表示されます。ファビコンの興味深い点の1つは、明示的なHTMLマークアップがなくても機能することです。ファビコンは `.png`、`.ico`、`.jpg`、`.svg` などのさまざまな画像フォーマットをサポートしています。

{{ figure_markup(
  image="favicons.png",
  caption="ファビコンタイプの人気度。",
  description="ファビコンタイプの人気度を示す棒グラフ。`png` がもっとも使用されており（データセットのモバイルページの42%に存在）、次いで `ico` （モバイルで27%）、`NO_ICON` （モバイルで18%）、`jpg` （モバイルで7%）、`svg` （モバイルで1%）となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=516732845&format=interactive",
  sheets_gid="1487566181",
  sql_file="favicons.sql"
  )
}}

2024年現在、`<link rel="icon">` タグで指定されるファビコンでもっとも一般的に使用されているフォーマットは `.png` で、モバイルページの42%に表示されており、2021年の35%から増加しています。対照的に、`.ico` ファイルの使用は2021年の33%から27%に減少しており、開発者がこのフォーマットから `.png` や `.svg` などの他のオプションに移行している可能性があります。ただし、興味深いことに、`.svg` ファビコンは<a hreflang="en" href="https://caniuse.com/link-icon-svg">Safariではサポートされていない</a>点に注意が必要です。

興味深いことに、約18%のページにはまだファビコンがありません。これは2021年にファビコンがなかった22%から若干改善しています。

### ボタンと入力タイプ

ウェブ開発におけるボタンは、その二重機能とさまざまなユースケースにより、頻繁な議論の対象となってきました。議論は通常、ネイティブの`<button>`要素を使用するか、アンカー（`<a>`）リンクを使用するか、あるいはボタンとして機能するカスタムスタイルの`div`要素を使用するかをめぐって展開されます。この議論には立ち入りませんが、データを見てその使用状況を確認してみましょう。

{{ figure_markup(
  content="73%",
  caption="少なくとも1つのbutton要素を使用しているモバイルページ。",
  classes="big-number",
  sheets_gid="1606033584",
  sql_file="element_popularity.sql",
) }}

モバイルページの73%が少なくとも1つの`<button>`要素を使用しており、これは[2021年の65.5%](../2021/markup#ボタンと入力タイプ)から大きく増加しています。2021年と同様に、input型のボタンに関するクエリは実行しませんでしたが、アクセシビリティの章にはボタンに関するとても興味深い情報がたくさんあります。そちらもぜひ読んでみてください！

{{ figure_markup(
  image="buttons.png",
  caption="ボタンタイプの人気度。",
  description="ボタンタイプの人気度を示す棒グラフ。一般的な`<button>`がもっとも使用されており（データセットのモバイルページの47%に存在）、次いで`<button type=button>`（モバイルで45%）、`<button type=submit>`（モバイルで34%）、`<button type=reset>`（モバイルで1%）となっています。デスクトップはほとんどの場合でわずかに高いものの、1パーセントポイント以内です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=2146901303&format=interactive",
  sheets_gid="753312353",
  sql_file="buttons.sql"
  )
}}

詳しく内訳を見てみましょう：

* 一般的な`<button>`要素はモバイルページの46.5%に表示されています。このボタンはデフォルトの動作を持たないため、クライアントサイドのスクリプトが要素のイベントをリッスンできます。
* モバイルページの44.7%が`<button type="button">`を使用しており、これは通常フォーム送信に関連しないアクション（JavaScriptの関数のトリガーなど）に使用されます。
* フォーム送信に特化した`<button type="submit">`バリアントは、モバイルページの34.1%に存在します。
* `<button type="reset">`は比較的まれで、モバイルページのわずか1.4%でしか見られません。これは、フォームのリセットがあまり一般的でないか、開発者がカスタムソリューションを選択していることを示しています。

ボタン以外にも、ボタンとしてレンダリングされ使用される`input`要素があります。

{{ figure_markup(
  image="input_buttons.png",
  caption="inputタイプを使用したボタンの人気度。",
  description="ボタンとして使用されるinputタイプの人気度を示す棒グラフ。`<input type=\"submit\">`がもっとも使用されており（データセットのモバイルページの25%に存在）、次いで`<input type=\"button\">`（モバイルで3%）、`<input type=\"image\">`（モバイルで1%）となっています。デスクトップはほとんどの場合でわずかに高いものの、1パーセントポイント以内です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1616034217&format=interactive",
  sheets_gid="1115291405",
  sql_file="buttons.sql"
  )
}}

データによると、データセットのモバイルページの25.2%が少なくとも1つの`<input type="submit">`要素を持ち、2.8%が少なくとも1つの`<input type="button">`要素を持ち、1.1%が少なくとも1つの`<input type="image">`要素を持っています。


### リンクターゲット

以前は、新しいタブでページを開くために`target="_blank"`属性を持つリンクを使用すると、ターゲットページが`window.opener`を介してあなたのページにアクセスでき、悪意のある行為を実行される可能性がありました。これを防ぐため、開発者は`target="_blank"`リンクに`rel="noopener"`属性を追加する必要がありました。`noopener`値は、新しいタブが`window.opener`オブジェクトにアクセスできないようにします。さらに、`noreferrer`は新しいタブにリファラー情報が渡されるのを防ぐために、しばしば`noopener`と併用されていました。

モダンブラウザでは、このセキュリティ問題は解決されています：現在、`target="_blank"`が使用されると、ブラウザは自動的に`rel="noopener"`を裏で適用します。つまり、ほとんどの場合、開発者はセキュリティの脆弱性を避けるために手動で`noopener`をリンク属性に含める必要がなくなりました。それにもかかわらず、レガシーコードやクロスブラウザの互換性に慎重な開発者のため、多くのウェブページで`noopener`と`noreferrer`の広範な使用が見られます。

<figure>
<table>
  <thead>
    <tr>
      <th>リンク</th>
      <th>デスクトップ</th>
      <th>モバイル</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`target="_blank"`を持つ</td>
      <td class="numeric">81%</td>
      <td class="numeric">81%</td>
    </tr>
    <tr>
      <td>時々`target="_blank"`を`noopener`と`noreferrer`と共に使用</td>
      <td class="numeric">77%</td>
      <td class="numeric">76%</td>
    </tr>
    <tr>
      <td>`target="_blank"`を`noopener`と`noreferrer`なしで持つ</td>
      <td class="numeric">68%</td>
      <td class="numeric">67%</td>
    </tr>
    <tr>
      <td>`target="_blank"`を`noopener`と共に持つ</td>
      <td class="numeric">25%</td>
      <td class="numeric">24%</td>
    </tr>
    <tr>
      <td>常に`target="_blank"`を`noopener`と`noreferrer`と共に使用</td>
      <td class="numeric">23%</td>
      <td class="numeric">24%</td>
    </tr>
    <tr>
      <td>`target="_blank"`を`noopener`と`noreferrer`と共に持つ</td>
      <td class="numeric">20%</td>
      <td class="numeric">19%</td>
    </tr>
    <tr>
      <td>`target="_blank"`を`noreferrer`と共に持つ</td>
      <td class="numeric">3%</td>
      <td class="numeric">3%</td>
    </tr>
  </tbody>
</table>
  <figcaption>{{ figure_link(
    caption="さまざまなリンク属性の組み合わせの採用率。",
    sheets_gid="411740281",
    sql_file="links.sql"
  ) }}</figcaption>
</figure>

データを見ると、81%のページが`target="_blank"`を使用しています。興味深いことに、76%のページが少なくとも1つの`target="_blank"`リンクを`noopener`と`noreferrer`と共に含んでいる一方、67%が`noopener`と`noreferrer`なしで`target="_blank"`を持っています。さらに、モバイルページの24%が常に`target="_blank"`リンクを`noopener`と`noreferrer`と共に使用しています。

## 結論

2024年のHTML使用状況の分析は、この基盤となる言語のウェブ開発における進化と継続的な関連性を示す重要なトレンドと洞察を明らかにしています。

もっとも注目すべき発見の1つは、HTMLドキュメントタイプの標準化の増加で、現在モバイルページの93%が標準の`<!DOCTYPE html>`を使用しています。これはウェブ標準への準拠に向けた前向きな変化を反映していますが、XHTMLはまだ存在しています。

ドキュメントサイズはわずかに増加しており、より複雑なページへの傾向を示していますが、圧縮（とくにBrotli）の使用がより一般的になり、読み込みパフォーマンスを向上させています。ただし、HTMLファイルの約10%で圧縮が依然として使用されていないことは、多くの開発者にとってまだ最適化の機会があることを示唆しています。

カスタム要素の使用が3.6%から7.9%に増加したことは、よりリッチでインタラクティブなウェブ体験を構築する成長傾向を示しています。廃止された項目の存在は減少していますが、継続的なコードメンテナンスとモダンな標準の採用の必要性を示しています。

興味深いことに、上位の`data-*`属性リストは大きな変化を示し、トップ3の属性が完全に異なっています。`data-id`、`data-load-time`、`data-tagging-id`の使用は、現在のウェブ開発でパフォーマンス追跡とタグ付けがより重要になっていることを示唆しています。

ただし、年々変わらないものもあります。*Divitis*はまだ存在し、`class`は属性の世界で依然として主権を持ち続けています。
