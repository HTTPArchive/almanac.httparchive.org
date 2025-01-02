---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: マークアップ
description: 2022年版Web Almanacのマークアップの章では、文書データ（doctypes、圧縮、言語、HTML conformance、文書サイズ）、HTML要素や属性の使用、データ属性、ソーシャルメディアについて解説しています。
hero_alt: Hero image of Web Almanac characters as dressed as constructor workers putting together a web page from HTML element blocks.
authors: [j9t]
reviewers: [bkardell, zcorpan]
analysts: [rviscomi]
editors: [tunetheweb]
translators: [ksakae1216]
j9t_bio: Jens Oliver Meiertは、エンジニアリングリードであり、著者(<a hreflang="en" href="https://leanpub.com/web-development-glossary"><cite>The Web Development Glossary</cite></a>、<a hreflang="en" href="https://www.amazon.com/dp/B094W54R2N/"><cite>Upgrade Your HTML</cite></a>)で、<a hreflang="en" href="https://www.liveperson.com/">LivePerson</a>でエンジニアリング・マネージャーとして活躍する。専門はHTMLとCSSの最小化・最適化。Jens は、自身のウェブサイト <a hreflang="en" href="https://meiert.com/en/">meiert.com</a>で定期的にウェブ開発の技術について執筆しています。
results: https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/
featured_quote: HTMLがなければ、Webページも、Webサイトも、Webアプリも存在しない。HTMLがなければウェブもない、と言えるでしょう。そのため、HTMLはもっとも重要なウェブ標準のひとつ、とは言わないまでも、もっとも重要なウェブ標準のひとつとなっているのです。
featured_stat_1: 90%
featured_stat_label_1: HTMLのdoctypeを使用する文書。
featured_stat_2: 30 KB
featured_stat_label_2: HTMLドキュメントの転送サイズ中央値
featured_stat_3: 29%
featured_stat_label_3: `div`となる要素。
---

## 序章

[2020年版の章](../2020/markup#序章)にあるように、HTMLがなければ、WebページもWebサイトもWebアプリもありません。HTMLがなければ、Webは存在しないと言ってもよいでしょう。そのため、HTMLはもっとも重要なWeb標準の1つ、とは言えないまでも、もっとも重要なWeb標準の1つであると言えます。

そこで、例年通り、数百万ページのデータセットを使って、モバイルセットで790万ページ、デスクトップセットで540万ページ（重複あり）を対象に、HTMLの調査も実施しました。この章では、HTMLに関する「すべて」をカバーしているわけではありません。したがって、[私たちが集めたデータを分析し](https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit) 、あなた自身の結論を共有することを明確に推奨します。その際には、[#htmlalmanac](https://x.com/hashtag/htmlalmanac)のタグを付けてください。

## ドキュメントデータ

HTMLをどのように書くかについては、好奇心をそそられることがたくさんあります。たくさんの質問をできますが、一般的なHTMLに関しては、マークアップ自体の内容に触れる前、私たちのHTMLがどのようにブラウザに送信されるかを見てみましょう。

### Doctypes

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`html`</td>
        <td class="numeric">88.1%</td>
        <td class="numeric">90.0%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd xhtml 1.0 transitional//en http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd`</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Doctypeなし</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">2.7%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd xhtml 1.0 strict//en http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd`</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd html 4.01 transitional//en http://www.w3.org/tr/html4/loose.dtd`</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd html 4.01 transitional//en`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Doctypeの使用法。",
      sheets_gid="1535288056",
      sql_file="doctype.sql",
    ) }}
  </figcaption>
</figure>

まずはdoctypeから。もっとも人気のあるdoctypeはどれでしょう？でも、この答えはわかっているはずです。それは、短くてシンプルで退屈な標準的なHTMLのdoctype、つまり、`<!DOCTYPE html>` です。

{{ figure_markup(
  content="90%",
  caption="標準的なHTMLのdoctypeを使用したモバイル。",
  classes="big-number",
  sheets_gid="1535288056",
  sql_file="doctype.sql",
) }}

すべてのモバイルページの90%がこれを使用しています。モバイルデータセットが最大であるため、この章では通常そのデータを使用します。次に多いのはXHTML 1.0 Transitional（3.9%、[2021年の4.6%から減少](../2021/markup#doctypes)）です。その次は2.7%でまったくdoctypeが設定されていない、昨年の2.5%から上昇しています。

### 圧縮

{{ figure_markup(
  image="content-encoding.png",
  caption="HTML文書のコンテンツのエンコーディング。",
  description="デスクトップとモバイルのHTMLドキュメントの28%がBrotliで圧縮され、デスクトップとモバイルのドキュメントの58%がGzipで圧縮され、デスクトップの14%とモバイルの13%がまったく圧縮されていないことを示す棒グラフを積み重ねた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1176900527&format=interactive",
  sheets_gid="1434175283",
  sql_file="content_encoding.sql",
) }}

HTML文書は圧縮されていますか？いくつ？どのように？全体の58％（昨年比5.8％減）がgzip圧縮、28％（同6.1％増）がBrotliで圧縮されています。全体として、圧縮される文書がわずかに増え、より効果的に圧縮されています。

### 言語

{{ figure_markup(
  image="html-languages.png",
  caption="もっとも一般的な地域別HTMLのlangの値です。",
  description="棒グラフは、デスクトップページの22%とモバイルページの19%で`en`が設定され、それぞれ18%と17%で`(未設定)`、16%と13%で`en-us`、6%と6%で`ja`、4%と5%で`es`、2%と3%で`pt-br`、2%と2%で`en-gb`、2%と2%で`ru`、2%と2%で`de`、デスクトップ1%とモバイルページ2%が`de-de`を設定していることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=677908280&format=interactive",
  sheets_gid="1194853402",
  sql_file="lang.sql",
  width=600,
  height=511
) }}

言語についてはどうでしょうか？私たちのデータセットでは、35%のページで `lang` 属性が英語にマッピングされていました。17%は言語が設定されていません。サンプルは偏っている可能性が高く、また全世界を反映するほど大きくはありませんし、`lang`属性が使われていないことは言語が設定されていないことと同じではないので、このデータは役に立ちません。

### 適合性

ドキュメントがHTMLの仕様に準拠しているか。有効ですか？簡単に見分けるには、<a hreflang="en" href="https://validator.w3.org/">W3Cマークアップ検証サービス</a>のようなツールを使うとよいでしょう。

まだしていませんし、確認もできません。では、なぜこのセクションを入れたのか？

少なくとも適合性について言及する理由は適合性をチェックしない場合、検証しない場合、かなりの確率で実際には、<a hreflang="en" href="https://meiert.com/en/blog/valid-html-2022/">事実上100%の確率で</a>、少なくともいくつかの架空の、空想の（したがって間違った）HTMLを書いてしまうことになるからです。しかしHTMLはフィクション、ファンタジーでもなく、何が有効、無効かという明確なルールがあるハードな技術標準なのです。

プロフェッショナルにとって、これらのルールを知っておくことは良いことです。また、動作するコードを作成し、余分なものを含まないことも良い仕事です。そして学習することと、動作しないものや余計なものを提供しないことの両方が、適合性が重要な理由であり、バリデーションが重要な理由なのです。

Web Almanacで共有できる適合性データはまだありませんが、だからといって、このポイントの重要性が低いというわけではありません。もしあなたがまだ適合性に注目していないのなら、HTML出力の検証を始めてください。もしかしたら、Web Almanacの次のエディションで、あなたのおかげで共有できるポジティブなニュースがあるかもしれません。

### ドキュメントサイズ

HTMLペイロードとドキュメントサイズは、この連載の定番です。私たちは2019年からこの情報を見てきました。しかし、その傾向は明らかで、他の章でも確認できる共通のテーマに沿っていますが、決して素晴らしいものではありません。

{{ figure_markup(
  image="html-document-transfer-size.png",
  caption="HTML文書の転送サイズの中央値。",
  description="HTML文書の中央値の転送サイズを示すコラムチャートは上昇傾向にある。2019年はデスクトップで27KB、モバイルで26KB、2020年はそれぞれ26KB、25KBとやや減少しましたが、2021年は29KB、27KBと再び増加し、2022年はデスクトップで31KB、モバイルで30KBとまだ最大になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=381017848&format=interactive",
  sheets_gid="1090657426",
  sql_file="document_trends.sql",
) }}

2020年に一時的に緩和されたものの、2021年、2022年と文書サイズは成長を続け、モバイルデータセットにおける転送サイズの中央値は30kBとなりました。

この傾向に対抗するひとつの方法は、<a hreflang="en" href="https://css-tricks.com/write-html-the-html-way-not-the-xhtml-way/">HTML、（XHTMLの方法ではなく）</a>の方法で書くことで、すでにHTMLの転送サイズを小さくできます。_公開: この著者は、HTMLの書き方の分類を考えるのが好きで、最小限のHTMLを推進するのを楽しんでいます。_

## 要素

`svg` と `math` 要素を含めない場合（これらはHTMLの外部で指定されているから）、現在のHTML仕様は111個の要素で構成されています。

<aside class="note">タグではなく要素です。なぜなら、`<li>` や `</ins>` のような単なる開始タグや終了タグを指しているのではないからです。また、HTML 要素の数え方を変える人もいますが、もっとも重要なのは、<a hreflang="en" href="https://meiert.com/en/blog/the-number-of-html-elements/">どのように数えているかをはっきりさせることです。</a></aside>

何を観察できるのか？

### 要素の多様性

{{ figure_markup(
  image="element-count-distribution.png",
  caption="ページごとの明確な要素の分布。",
  description="ページあたりの個別要素数を共通のパーセンタイルで示したコラムチャート。デスクトップとモバイルはほぼ同じで、10パーセンタイルでは22要素、25パーセンタイルでは27要素、50パーセンタイルでは32要素、75パーセンタイルではデスクトップが39、モバイルが38、90パーセンタイルでは45要素となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=2146886292&format=interactive",
  sheets_gid="1201800477",
  sql_file="element_count_distribution.sql",
) }}

まず注目すべきは、開発者が1ページあたり使用する要素の種類が若干増えていることで、1文書あたりの要素の中央値は32種類となっています。

中央値は[2021年31要素](../2021/markup#要素の多様性)、[2020年30要素](../2020/markup#要素の多様性)から上昇した。これは全体的な傾向として、開発者がHTML要素をより有効に活用し、その目的に応じた使い方をするようになったことの表れかもしれません。

しかし、原稿のサイズが大きくなると、1ページあたりの要素数が増えるという傾向もあります。

{{ figure_markup(
  image="element-count-distribution.png",
  caption="1ページあたりの要素数分布。",
  description="一般的なパーセンタイルにおけるデバイスごとの要素数を示すコラムチャート。デスクトップでは、10パーセンタイルで177、25パーセンタイルで394、50パーセンタイルで711、75パーセンタイルで1,220、90パーセンタイルで2,023の要素数になっています。携帯電話の傾向は同じですが、その量は少なくなっています。それぞれ、192、371、653、1,104、1,832。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1598321449&format=interactive",
  sheets_gid="1201800477",
  sql_file="element_count_distribution.sql",
) }}

中央値は現在、1ページあたり653要素で、2021年の616要素、2020年の587要素から増加しています。すべて各モバイルデータによるものです。私たちはより多くのコンテンツを発行し、それらを保持するためにより多くの要素を必要とするのでしょうか（たとえば、テキストごとに段落を増やし、より多くの `p` 要素を必要とするようなもの）？それともこれは単に `div` が抑制されずに蔓延していることの表れなのでしょうか？私たちのデータはこれに答えてはいませんが、おそらくその両方、あるいはそれ以上の理由によるものでしょう。

### トップ要素

もっともよく使われるのは、以下の要素です。

<figure>
  <table>
    <thead>
      <tr>
        <th>2019</th>
        <th>2020</th>
        <th>2021</th>
        <th>2022</th>
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
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`option`</td>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td></td>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`i`</td>
      </tr>
      <tr>
        <td></td>
        <td>`option`</td>
        <td>`i`</td>
        <td>`meta`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="もっとも使われている要素。",
      sheets_gid="571472591",
      sql_file="element_frequency.sql",
    ) }}
  </figcaption>
</figure>

`div` 要素はもっともよく使われている要素です。モバイル データセットでは2,123,819,193回、デスクトップ データセットでは1,522,017,185回、出現しました。

{{ figure_markup(
  content="29%",
  caption="`div` 要素の割合。",
  classes="big-number",
  sheets_gid="571472591",
  sql_file="element_frequency.sql",
) }}

[ディバイス](https://en.wiktionary.org/wiki/divitis)は実在します。

もしあなたが奇妙な存在である [`i` 要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element/i)について疑問に思うならば、それはやはり <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>とその議論の余地のないこの要素の誤用によるところが大きいのだろうと推論できます。この要素は、XHTML時代には誰もが `em` を代わりに使うように勧めていたため、悪い評判もあります。しかし、そのアドバイスは適切でなく、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-i-element">`i` 要素にはその使用例</a>があるのです。

もっとも多くの文書で使用されている要素については、少し違った印象を受けます。

{{ figure_markup(
  image="adoption-of-top-html-elements.png",
  caption="トップHTML要素の採用。",
  description="棒グラフは`html`がデスクトップの99.3%とモバイルの99.4%、`head`が99.3%と99.4%で、`body` が99.1%と99.2%で、`title`が98.9%と99.0%、`meta`が98.5%と98.9%、`div`が98.3%と98.5%、`a`が98.0%と98.1%、`link`は97.8%と98.0%、`script`は97.6%と97.8%、`img`は95.9%と96.1%、`span`は94.2%と94.7%、`p`は89.9%と90.0%、`ul`は88.8%と88.7%、最後に `li` はデスクトップのページでは88.7%、モバイルで88.6%が利用しているとされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=714125011&format=interactive",
  sheets_gid="2057119066",
  sql_file="element_popularity.sql",
  width=600,
  height=656
) }}

ほぼすべての文書で `html`、`head`、`body` タグが使われているのは当然のことで、これらは自動的にDOMに挿入され、ここでカウントされています。100%より少し少ないのは、私たちが使用しているJavaScript APIをオーバーライドすることで検出を中断している少数のページによるものです。たとえば、<a hreflang="en" href="https://mootools.net/">MooTools</a> は `JSON.stringify()` APIをオーバーライドしています。

全サンプル文書の1%で`title`を見逃す方がよっぽど驚きです。この要素はオプションではなく、DOMに挿入されておらず、その省略は適合性チェックの欠如の指標となる。

とくに、`a`、`img`、`meta`は、2005年の<a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">Ian HicksonによるHTMLの研究</a>以来、人気のある要素となっています。

現在の標準に含まれるHTML要素の中で、もっとも使用頻度の低いものは何かと聞かれたら？これは、<a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-samp-element">`samp`</a>で、モバイルセットではわずか2,002件しかありません。

### カスタム要素

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts">Custom要素</a>内側の名前にハイフンが使われていることで大まかに識別できる要素も再びサンプルに、含まれるようになりました。しかし、今年はトップ10を<a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a>が完全に独占しているのです。

<figure>
  <table>
    <thead>
      <tr>
        <th>カスタム要素</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`rs-module-wrap`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-module`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-slides`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-slide`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-sbg-wrap`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-sbg-px`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-sbg`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-progress`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-layer`</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`rs-mask-wrap`</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="もっとも使用されているカスタムエレメント。",
      sheets_gid="2057119066",
      sql_file="element_popularity.sql",
    ) }}
  </figcaption>
</figure>

しかし、Slider Revolutionは全サンプルページの約2%で使用されているというだけで、ほとんど参考になりません。

Slider Revolutionに含まれない、次に人気のあるカスタム要素とは？

<figure>
  <table>
    <thead>
      <tr>
        <th>カスタム要素</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`pages-css`</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`wix-image`</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`router-outlet`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>`wix-iframe`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>`ss3-loader`</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="`rs-`で始まらない、もっともよく使われるカスタム要素。",
      sheets_gid="2057119066",
      sql_file="element_popularity.sql",
    ) }}
  </figcaption>
</figure>

これはより多様です。`pages-css`、`wix-image`、`wix-iframe`は、Wixウェブサイトビルダーからきています。`router-outlet`はAngularに由来するものです。そして、`ss3-loader`はSmart Sliderと関係があるようです。

### 廃止された要素

廃止された要素はまだあるのですか？検証しないことがまだあることを考えると、そうです。

{{ figure_markup(
  image="obsolete-elements.png",
  caption="廃止された要素。",
  description="棒グラフは、`center`がデスクトップとモバイルのページの6.3%、`font`がそれぞれ5.7%と5.4%、`marquee`が0.8%と1.0%、`nobr`が0.5%と0.4%、そして最後に`big`がデスクトップとモバイルのページの0.4%で使用されていることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=2039309980&format=interactive",
  sheets_gid="69619977",
  sql_file="obsolete_elements.sql",
) }}

6.1%のページでまだ `center` 要素 (hi <a hreflang="en" href="https://www.google.com/">Googleホームページ</a>) が見つかり、5.4%のページで `font` 要素が見つかっています。幸いなことに、この2つの要素の使用率は下がりました（どちらも0.5%減）。一方、`marquee`、`nobr`、`big`には大きな変化は見られませんでした。

私たちの分析では、`center`と`font`が廃止された要素の大部分（81.2%）を占めています。

{{ figure_markup(
  image="obsolete-elements-relative-use.png",
  caption="相対的な使用を廃止した要素。",
  description="円グラフでは、モバイルでの廃止要素の使用率は、`center` 43.0%、`font` 38.2%、`marquee` 7.0%、`nobr` 2.6%、`big` 2.6%、`frame` 1.5%、残りはラベルのない他の要素で構成されていることが示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1875548366&format=interactive",
  sheets_gid="69619977",
  sql_file="obsolete_elements.sql",
) }}

## 属性

要素がHTMLのパンだとしたら、属性はバターです。ここで私たちは何を学ぶことができるでしょうか？

### トップ属性

もっとも人気のある属性は、昔も今も `class` です。

{{ figure_markup(
  image="attribute-usage.png",
  caption="属性の使い方。",
  description="棒グラフは、`class`がモバイルとデスクトップの両方で34%の使用率、`href`がデスクトップで10%、モバイルでは9%、`style`が両方で5%、`id`が両方で5%、`src`が両方で4%、`type`が両方で3%、 `title` が両方2%、`alt` が両方2%、`rel` が2%、最後に `value` が両方で1%であることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=143284257&format=interactive",
  sheets_gid="1979652187",
  sql_file="attributes.sql",
  width=600,
  height=558
) }}

この順番は昨年までと変わらないのですが、いくつか変更点があります。

- `class` (<span class="numeric-bad">▼0.3%</span>)、`href` (<span class="numeric-bad">▼0.9%</span>)、`style` (<span class="numeric-bad">▼0.6%</span>)、`id` (<span class="numeric-bad">▼0. 2%</span>)、`type` (<span class="numeric-bad">▼0.1%</span>)、`title` (<span class="numeric-bad">▼0.3%</span>)、and `value` (<span class="numeric-bad">▼0.5%</span>) は、いずれも使用頻度が以前より少し減っています。
- `src` (<span class="numeric-good">▲0.3%</span>) と `alt` (<span class="numeric-good">▲0.1%</span>) は以前より多く使われており、アクセシビリティにとって比較的良いニュースです!
- `rel` の使い方は大きく変わっていません。

（ほぼ）すべての文書に見られる属性があるのでしょうか？はい、あります。

{{ figure_markup(
  image="attribute-usage.png",
  caption="ページごとの属性の使用状況。",
  description="棒グラフは、`href`がデスクトップとモバイルの99%のページで、`src`が両方の99%で、`content`がデスクトップの98%とモバイルの99%、`name`がそれぞれ98%と99%、 `type` が両方の98%、 `class` が両方の98%、 `rel` が両方の98%、 `id` が97%と98%、 `style` が両方とも96%、最後に `alt` が両方とも91%の割合で使用されていることを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=143284257&format=interactive",
  sheets_gid="1979652187",
  sql_file="attributes.sql",
  width=600,
  height=558
) }}

`href`、`src`、`content`（メタデータ）、`name`（メタデータ、フォーム識別子）は、サンプルのほぼすべての文書に存在します。

### `data-*`属性

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">`data-*` 属性</a>（作者が独自のメタデータを埋め込むことができる属性）についても、新しい情報が引き出されました。

これは、[昨年の `data-*` 属性の統計](../2021/markup#data--属性) と比べると、ほとんど変化がありません。以下は、その変更点です。

- `data-id` は2021年と比較して0.7% 増加しており、もっとも人気のある `data-*` 属性であることに変わりはありません。
- `data-element_type` は、順位は変わらないが、同じく0.7%上昇した。
- `data-testid`は以前6位でしたが、0.3%上昇し、4位に躍進しました。
- `data-widget_type`は8位で0.4%の人気を獲得し、さらに2つ順位を上げて2022年には6位を獲得しました。

`data-element_type` と `data-widget_type` は <a hreflang="en" href="https://developers.elementor.com/">Elementor</a> に関連しており、一方data-testidは <a hreflang="en" href="https://testing-library.com/">Testing Library</a> から来るものです。

それでは、`data-*`という属性がページ上でどの程度見られるか見てみましょう。

{{ figure_markup(
  image="data-attribute-popularity.png",
  caption="データ属性の人気度。",
  description="棒グラフでは、`data-toggle`がデスクトップページの23%、モバイルページの22%、`data-src`がそれぞれ20%と20%、`data-target`が20%と20%、`data-id`が18%と19%、`data-type`が15%と15%で使用されていることが示されています。`data-href` は9%と10%、 `data-fbcssmodules` は10%と10%、 `data-slick-index` は10%と9%、 `data-google-container-id` は10%と9%、最後に `data-load-complete` はモバイルページの10%とデスクトップページの9%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1008069119&format=interactive",
  sheets_gid="1727867391",
  sql_file="data_attributes.sql",
  width=600,
  height=558
) }}

その人気は高いです。上のグラフでは、4つめのドキュメントに `data-*` 属性が使用されています。しかし、全体のデータでは、88%のドキュメントが少なくとも1つの `data-*` 属性を使用しています。 これはかなりの普及率です。

### ソーシャルマークアップ

昨年の版では、[ソーシャルマークアップのセクション](../2021/markup#ソーシャルマークアップ)という、ソーシャルプラットフォームがそれぞれのメタデータを識別して表示することを容易にする特別なマークアップが紹介されました。ここでは、2022年のアップデート内容を紹介します。

{{ figure_markup(
  image="social-meta-nodes-usage.png",
  caption="ソーシャルメタノードの利用状況。",
  description="棒グラフでは、`og:title`がデスクトップの56%、モバイルの57%、`og:url`が53%、54%、`og:type`は51%、51%、`og:description`が50%、50%、`og.site_name`は45% と45%、 `twitter:card` が40%と39%、 `og:image` が39% と39%、 `og:locale` が28%と29%、 `twitter:title` が24% と23%、そして最後に `twitter:description` が21% のそれぞれで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=429652195&format=interactive",
  sheets_gid="1925328234",
  sql_file="meta_node_names.sql",
  width=600,
  height=604
) }}

このメタデータはすべて必要なのでしょうか？それは、あなたの要件によります。しかし、これらの要件がタイトル、説明、画像の表示に関するものであれば、ほぼ必要ないように思われます。`twitter:card`、`og:title`、`og:description` (標準の `description` メタデータにフックされる）、そして `og:image` でできるかもしれません。筆者や他の多くの人が、<a hreflang="en" href="https://meiert.com/en/blog/minimal-social-markup/">最小限のソーシャル マークアップ</a>のためのオプションを説明しています。

## 結論

これは、2022年のHTMLを一目見ただけです。

結論は簡潔です。年ごとに見ると、どのような重要なトレンドが始まったのか、あるいは逆転したのかはわかりません。少なくとも、2020年、2021年、2022年の3年間は、ドキュメントのサイズが大きくなり続けているようです。1ページの要素数も年々増えています。しかし、それは相対的なものであり、より多くの画像が適切な `alt` 属性を持つかどうか、またそのテキストが本当に<a hreflang="en" href="https://html.spec.whatwg.org/multipage/images.html#alt">有意義</a>であるかどうかは分かりません。

でも、そんなとき、Web Almanacが役に立ちます。来年も、再来年も、その次の年も、またHTMLについて見ていくつもりです。そしてまた、より詳細に、より多くの年を振り返っていくつもりです。

また、適合性にも目を向けることができるようになるかもしれません。私たちの分野では、現時点では誰もがこのことを気にしているわけではないかもしれません。しかし、私たちは皆プロフェッショナルであり、全体として<a hreflang="en" href="https://html.spec.whatwg.org/multipage/">基礎となる標準</a>に対応する作品を作っているかどうかを知ることは少なくとも関連性があると思われます。結局のところ、この章は空想のHTMLについての章ではなく、実際に機能するHTMLについての章であるべきなのです。もっとも重要なWeb標準の1つです。
