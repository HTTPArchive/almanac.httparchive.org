---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: コンテンツ、METAタグ、インデックス性、リンク、スピード、構造化データ、国際化、SPA、AMP、セキュリティを網羅した2020年Web AlmanacのSEO編。
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [aleyda, ipullrank, fellowhuman1101]
reviewers: [natedame, catalinred, dsottimano, dwsmart, en3r0, ibnesayeed, tunetheweb]
analysts: [Tiggerito, antoineeripret]
editors: [rviscomi]
translators: [ksakae1216]
aleyda_bio: SEOコンサルタント、作家、講演者、起業家。<a hreflang="en" href="https://www.orainti.com/">Orainti</a>（SaaSからマーケットプレイスまで、トップレベルのウェブプロパティやブランドを扱うブティック型SEOコンサルタント）の創設者であり、<a hreflang="en" href="https://remoters.net/">Remoters.net</a>（リモートワークを促進するためのリモートジョブ、ツール、イベント、ガイドなどを提供する、無料のリモートワークハブ）の共同創設者でもあります。また、<a hreflang="en" href="https://www.aleydasolis.com/en/blog/">ブログ</a>、<a hreflang="en" href="https://www.aleydasolis.com/en/seo-tips/">#SEOFOMO ニュースレター</a>、<a hreflang="en" href="https://www.aleydasolis.com/en/crawling-mondays-videos/">Crawling Mondays</a> ビデオとポッドキャストシリーズ、<a href="https://x.com/aleyda">Twitter</a>などを通じて、SEOについての情報を発信しています。
ipullrank_bio: アーティストであり、テクノロジストでもあるマイケル・キングは、企業向けデジタルマーケティングエージェンシーである<a hreflang="en" href="https://ipullrank.com">iPullRank</a>の創設者であり、自然言語生成アプリ<a hreflang="en" href="https://www.copyscience.io">CopyScience</a>の創設者でもあります。独立系のヒップホップミュージシャンとしての経歴を活かし、魅力的なコンテンツを作成し、受賞歴のあるダイナミックな講演者として、世界中のテクノロジーやマーケティングに関するカンファレンスやブログで活躍しています。また、<a href="https://x.com/ipullrank">Twitter</a>では、マイクがゴミの話をしているところを見ることができます。
fellowhuman1101_bio: 100%人間であり、完全にロボットではないJamie Indigoは、人間が有益な情報にアクセスし、企業が価値あるデジタル体験を提供できるよう、テクノロジーを解きほぐします。彼女は<a hreflang="en" href="https://not-a-robot.com">Not a Robot</a>を設立し、技術的なSEOの人間的な側面に焦点を当て、技術や検索業界における倫理やインクルージョンを含めたコンサルティングを行っています。 彼女は、<a href="https://x.com/Jammer_Volts">Twitter</a>で公の場で学んでいるのを見つけることができます。
discuss: 2043
results: https://docs.google.com/spreadsheets/d/1ram47FshAjzvbQVJbAQPgxZN7PPOPCKIK67VJZCo92c/
featured_quote: モバイルデバイスの使用が増え、Googleがモバイルファーストインデックスに移行したにもかかわらず、モバイルとデスクトップのリンクのように、モバイルとデスクトップのページで些細な格差が見られました。
featured_stat_1: 10.84%
featured_stat_label_1: モバイルページにviewportタグが含まれていない
featured_stat_2: 19.96%
featured_stat_label_2: モバイルサイトの評価は「Good」 コアウェブバイタルを獲得しました
featured_stat_3: 11.5%
featured_stat_label_3: 中央のモバイルサイトでは、生のHTMLよりもレンダリングされた方がより多くの単語が表示される
---

## 序章

検索エンジン最適化（SEO）とは、ウェブサイトの技術的な構成、コンテンツの関連性、リンクの人気度などを最適化することで、ユーザーの検索ニーズを満たすために情報を見つけやすくし関連性を高めることです。その結果、Webサイトのコンテンツやビジネスに関連するユーザーの検索結果における視認性が向上し、トラフィック、コンバージョン、利益が増加します。

SEOは複雑な複合領域であるにもかかわらず、近年ではもっとも人気のあるデジタルマーケティング戦略・チャネルの1つに進化しています。

{{ figure_markup(
  image="seo-google-trends.png",
  caption="Google TrendsによるSEOとペイパークリックやソーシャルメディアマーケティングの比較。",
  description="デジタルマーケティングに関連する3つの用語の時間的変化を示すGoogle Trendsのスクリーンショット。検索エンジン最適化は25％から始まっていますが、時間の経過とともに重要性が増し、現在は75％になっています。クリック課金型も25％で始まりましたが、2009年から減少し始め、現在は10％以下になっているようです。ソーシャルメディア・マーケティングは最初非常に小さく（約5％）、時間の経過とともに少しずつ増加し、最終的にクリック課金型をわずかに上回る10％程度となっています。",
  width=1600,
  height=844
  )
}}

Web AlmanacのSEOの章の目的は、Webサイトのオーガニック検索最適化に役割を果たす主な要素や構成を特定し、評価することです。これらの要素を特定することでウェブサイトが検索エンジンにクロールされ、インデックスされ、ランキングされる能力を向上させるために我々の調査結果を活用していただきたいと考えています。本章では、2020年の状態のスナップショットと、[2019年以降](../2019/seo)に変更された点のまとめを提供します。

この章は、モバイルサイトの<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>の分析に基づいていることに注意してください。 モバイルとデスクトップ、および未加工の<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">ChromeUXレポート</a> モバイルとデスクトップで<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>からHTML要素をレンダリングしました。 HTTP ArchiveとLighthouseの場合、サイト全体のクロールではなく、Webサイトのホームページからのみ識別されるデータに制限されます。 評価を行う際、これを考慮に入れています。 結果から結論を引き出すときは、この区別を念頭に置くことが重要です。 詳細については、[方法論](./methodology)ページをご覧ください。

今年のオーガニック検索最適化の主な調査結果を見てみましょう。

## ファンダメンタルズ

このセクションでは検索エンジンがウェブサイトを正しくクロールし、インデックスを作成し、ユーザーに最適な結果を提供するための基盤となるウェブの構成や要素について最適化に関する知見を紹介します。

### クローラビリティとインデクサビリティ

検索エンジンはウェブ・クローラー（スパイダーとも呼ばれる）を使用して、ページ間のリンクをたどってウェブを閲覧しながら、ウェブサイトから新規または更新されたコンテンツを発見します。クローリングとは、新しいまたは更新されたWebコンテンツ（Webページ、画像、動画など）を探すプロセスのことです。

検索クローラーは、URL間のリンクを辿るだけでなく、ウェブサイトの所有者が提供する追加ソースを利用してコンテンツを発見します。たとえば、XMLサイトマップ（ウェブサイトの所有者が検索エンジンにインデックスさせたいURLのリスト）の作成や、Googleのサーチコンソールのような検索エンジンツールを使った直接のクロールリクエストなどがあります。

検索エンジンはウェブコンテンツにアクセスすると、ウェブブラウザと同様にレンダリングを行い、インデックスを作成する必要があります。検索エンジンは識別された情報を分析してカタログ化し、ユーザーと同じように理解しようとし、最終的にインデックス（ウェブデータベース）に保存します。

ユーザーがクエリを入力すると、検索エンジンはインデックスを検索してクエリに答えるため、検索結果ページに表示する最適なコンテンツを探し、さまざまな要素を用いてどのページが他のページよりも先に表示されるかを決定します。

検索結果での表示を最適化したいと考えているウェブサイトでは、特定のクローラビリティとインデクサビリティのベストプラクティスに従うことが重要です。たとえば、`robots.txt`、robots `meta`タグ、`X-Robots-Tag`HTTPヘッダー、canonicalタグなどを正しく設定することです。これらのベストプラクティスは、検索エンジンがウェブコンテンツに容易にアクセスし、より正確にインデックスを作成するのに役立ちます。以下では、これらの設定を徹底的に分析します。

#### `robots.txt`

サイトのルートに置かれる`robots.txt`ファイルは検索エンジンのクローラーがどのページを操作するか、どのくらいの速さでクロールするか、そして発見されたコンテンツをどうするかをコントロールするための効果的なツールです。

Googleは、2019年に`robots.txt`をインターネットの公式規格にすることを正式に提案しました。<a hreflang="en" href="https://tools.ietf.org/html/draft-koster-rep-02">2020年6月のドラフト</a>には、`robots.txt`ファイルの技術的要件に関する明確な文書が含まれています。これにより、検索エンジンのクローラーが規格外のコンテンツにどのように対応すべきか、より詳細な情報が求められるようになりました。

`robots.txt`ファイルはプレーンテキストで、UTF-8でエンコードされ、リクエストに対して200 HTTPステータスコードで応答しなければなりません。検索エンジンのクローラーは、不正な`robots.txt`や4XX（クライアントエラー）レスポンス、5つ以上のリダイレクトは _full allow_ と解釈し、すべてのコンテンツはクロールされる可能性があることを意味します。5XX（サーバーエラー）のレスポンスは、 _full disallow_ と解釈され、いかなるコンテンツもクロールできないことを意味します。もし`robots.txt`が30日以上届かない場合、Googleは<a hreflang="en" href="https://developers.google.com/search/reference/robots_txt#handling-http-result-codes">仕様</a>で説明されているように、最後にキャッシュされたコピーを使用します。

全体として、80.46%のモバイルページが`robots.txt`に対して2XXの応答をしました。このうち、25.09%は有効であると認識されませんでした。これは、[27.84%のモバイルサイトが有効な`robots.txt`を持っていた](../2019/seo#robotstxt)ことが判明した2019年よりも若干改善されています。

`robots.txt`の有効性をテストするためのデータソースであるLighthouseは、v6アップデートの一環として、<a hreflang="ja" href="https://web.dev/i18n/ja/robots-txt/">`robots.txt`の監査</a>を導入しました。この導入により、リクエストが正常に解決されても、基礎ファイルがWebクローラーに必要な指示を与えることができるとは限らないことが強調されました。

<figure>
  <table>
    <thead>
      <tr>
        <th>レスポンスコード</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2XX</td>
        <td class="numeric">80.46%</td>
        <td class="numeric">79.59%</td>
      </tr>
      <tr>
        <td>3XX</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td>4XX</td>
        <td class="numeric">17.67%</td>
        <td class="numeric">18.64%</td>
      </tr>
      <tr>
        <td>5XX</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>6XX</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
      <tr>
        <td>7XX</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.12%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="<code>robots.txt</code>のレスポンスコード。",
      sheets_gid="769973954",
      sql_file="pages_robots_txt_by_device_and_status.sql"
    ) }}
  </figcaption>
</figure>

ステータスコードが似ていることに加えて、モバイル版とデスクトップ版の`robots.txt`ファイルでは、`Disallow`ステートメントが一貫して使用されていました。

もっとも多く見られた`User-agent`宣言文は、ワイルドカードの`User-agent: *`、これはモバイルの`robots.txt`リクエストの74.40%とデスクトップの73.16%に見られました。2番目に多かった宣言文は`adsbot-google`で、モバイルの`robots.txt`リクエストの5.63%とデスクトップの5.68%に現れていました。Google AdsBotは、ウェブページやアプリの広告の品質をデバイス間でチェックするため、ワイルドカードの記述を無視し、具体的な名前を指定する必要があります。

もっとも頻繁に使用されたディレクティブは、検索エンジンとその有料マーケティングに関連するものでした。SEOツールのAhrefとMajesticは、どちらのデバイスでも`Disallow`ステートメントのトップ5に入っていました。

<figure>
  <table>
    <thead>
      <tr>
          <td></td>
          <th colspan="2" scope="colgroup"><code>robots.txt</code>の使用率</th>
      </tr>
      <tr>
        <th scope="col"><code>ユーザーエージェント</code></th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">74.40%</td>
        <td class="numeric">73.16%</td>
      </tr>
      <tr>
        <td>adsbot-google</td>
        <td class="numeric">5.63%</td>
        <td class="numeric">5.68%</td>
      </tr>
      <tr>
        <td>mediapartners-google</td>
        <td class="numeric">5.55%</td>
        <td class="numeric">3.83%</td>
      </tr>
      <tr>
        <td>mj12bot</td>
        <td class="numeric">5.49%</td>
        <td class="numeric">5.30%</td>
      </tr>
      <tr>
        <td>ahrefsbot</td>
        <td class="numeric">4.80%</td>
        <td class="numeric">4.66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="<code>robots.txt User-agent</code>のディレクティブです。",
      sheets_gid="243594173",
      sql_file="pages_robots_txt_by_device_and_useragent.sql"
    ) }}
  </figcaption>
</figure>

Lighthouseが提供する600万以上のサイトのデータを使って、`robots.txt`の`Disallow`文の使用状況を分析したところ、97.84%が完全にクロール可能で、`Disallow`文を使用しているのは1.05%に過ぎないことがわかりました。

また、<a hreflang="en" href="https://developers.google.com/search/reference/robots_meta_tag">meta robots</a> _indexability_ ディレクティブに沿った `robots.txt`の `Disallow`ステートメントの使用状況を分析したところ、1. 02%のサイトが、meta robots `index` ディレクティブを使用したインデックス可能なページで `Disallow`ステートメントを使用しており、meta robots `noindex`ディレクティブを使用した _noindex_ ページで`robots.txt`の`Disallow`ステートメントを使用しているサイトは0.03%しかありませんでした。

これは、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/robots/intro">Googleのドキュメント</a>によると、サイトオーナーはGoogle検索からウェブページを隠す手段として`robots.txt`を使用すべきではないとしています。代わりに、サイトオーナーは、meta robotsによる `noindex` ディレクティブのような他の方法を使うべきです。

#### Meta robots

メタタグ `robots` とHTTPヘッダー `X-Robots-Tag` は、提案されている <a hreflang="en" href="https://webmasters.googleblog.com/2019/07/rep-id.html">Robots Exclusion Protocol</a> (REP) を拡張したもので、より詳細なレベルでディレクティブを設定できます。REPはまだ正式なインターネット標準ではないため、ディレクティブのサポートは検索エンジンによって異なります。

メタタグは、デスクトップの27.70％、モバイルの27.96％のページで使用されており、粒度の高い実行方法として圧倒的な支持を得ていました。`X-Robots-Tag`は、デスクトップで0.27%、モバイルでは0.40%でした。

{{ figure_markup(
  image="seo-robots-directive-use.png",
  caption="meta robotsと<code>X-Robots-Tag</code>ディレクティブの使用。",
  description="ロボットの使用状況を示す棒グラフ。Meta robotsはデスクトップで27.70%、モバイルでは27.96%となっており、X-Robots-Tagはデスクトップで0.27%、モバイルでは0.40%とチャートにはほとんど表示されていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=99993402&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

Lighthouseのテストでmeta robotsタグの使用状況を分析したところ、クロール可能なページの0.47%が _noindex_ になっていることがわかりました。これらのページの0.44%は、`noindex`ディレクティブを使用しており、`robots.txt`でそのページのクロールを禁止していませんでした。

また、robots.txt内の`Disallow`とmeta robots内の`noindex`ディレクティブの組み合わせは、わずか0.03%のページでしか見つかりませんでした。この方法は、ベルトとサスペンダーのような冗長性がありますが、ページ上の `noindex` ディレクティブを有効にするためには、ページが`robots.txt`ファイルによってブロックされていない必要があります。

興味深いことに、レンダリングによってmeta robotsタグが変更されたページは0.16%でした。JavaScriptを使ってページにmeta robotsタグを追加したり、コンテンツを変更したりすることに本質的な問題はありませんが、SEO担当者は慎重に実行する必要があります。レンダリング前、meta robotsタグに`noindex`ディレクティブを入れてページを読み込むと、<a hreflang="en" href="https://developers.google.com/search/docs/guides/javascript-seo-basics#use-meta-robots-tags-carefully">検索エンジンはタグの値を変更するJavaScript</a>を実行したり、ページをインデックスできません。

#### 正規化

<a hreflang="en" href="https://developers.google.com/search/docs/advanced/crawling/consolidate-duplicate-urls">Canonicalタグ</a>はGoogleが説明しているように、同一または非常に類似したコンテンツを掲載しているURLが多数ある場合に、そのページを代表すると考えられる優先的なcanonical URLバージョンを検索エンジンに指定するため使用されます。重要なのは以下の点です。

- canonicalタグの設定は、ページのcanonical URLを選択するために他のシグナルとともに使用されますが、それだけではありません。
- 自己参照用のcanonicalタグが使われることもありますが、必須ではありません。

[昨年の章](../2019/seo#canonicalization)では、モバイルページの48.34%がcanonicalタグを使用していることが確認されました。今年はcanonicalタグを採用しているモバイルページは53.61%に増えています。

{{ figure_markup(
  image="seo-presence-of-canonical-tag.png",
  caption="canonicalタグの使い方。",
  description="canonicalタグの有無を示す棒グラフ。大半のウェブページにcanonicalタグが含まれており、その主な部分は自己参照である（デスクトップ：47.88％、モバイル：45.31％）。正準化されたウェブページの割合は、デスクトップ（4.1％）よりもモバイル（8.45％）の方が高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1777344456&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

今年のモバイルページのcanonicalタグの構成を分析したところ、45.31%が自己参照で、8.45%が正規のものとは異なるURLを指していることが検出されました。

一方、今年は51.85%のデスクトップページがcanonicalタグを採用していることが判明し、47.88%が自己参照、4.10%が別のURLを指していることがわかりました。

モバイルページはデスクトップページよりも多くのcanonicalタグを含んでいる（53.61％対51.85％）だけでなく、他のURLにcanonical化しているモバイルホームページは、デスクトップホームページよりも比較的多い（8.45％対4.10％）。これは、デスクトップ版とは別のURLに正規化する必要がある一部のサイトが、独立した（または別の）モバイルウェブ版を使用しているためと考えられます。

正準化URLはHTTPヘッダーやページのHTMLの`head`を介して正準化リンクを使用する方法と、XMLサイトマップで提出する方法など、さまざまな方法で指定できます。正準化リンクの実装方法としてもっとも多く利用されているのはどれかを分析したところ、HTTPヘッダーに依存して実装しているのは、デスクトップページで1.03%、モバイルページでは0.88%に過ぎず、正準化タグはページのHTMLの`head`を介して実装されることが多いことがわかりました。

{{ figure_markup(
  image="seo-canonical-implementation-method.png",
  caption="HTTPヘッダーとHTML <code>head</code>の正規化メソッドの使用。",
  description="canonicalタグの実装方法を示す棒グラフ。デスクトップページで1.03%、モバイルページでは0.88%しかHTTPヘッダーに依存していないことがわかり、canonicalタグはHTMLのheadで実装されることが多いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=542127514&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

生のHTMLにcanonicalタグが実装されているものと、クライアントサイドのJavaScriptによるレンダリングに依存しているものを分析したところ、モバイルページの0.68％、デスクトップページの0.54％が、生のHTMLではなくレンダリングされたHTMLにcanonicalタグを含んでいることがわかりました。つまり、JavaScriptでcanonicalタグを実装しているページは、ごく少数であることがわかります。

一方、モバイルページの0.93%、デスクトップページの0.76%では、生のHTMLとレンダリングされたHTMLの両方でcanonicalタグが実装されており、同じページの生のHTMLで指定されたURLとレンダリングされたHTMLで指定されたURLの間に矛盾が生じていました。これにより、同じページのcanonical URLがどちらであるかという情報が混在して検索エンジンに送信されるため、インデクサビリティの問題が発生します。

また、実装方法の違いによっても同様の問題が発生しており、モバイルページの0.15%とデスクトップページの0.17%で、HTTPヘッダーとHTMLの`head`で実装されたcanonicalタグの間で問題が発生しています。

### コンテンツ

検索エンジンと検索エンジン最適化の主な目的は、ユーザーが必要とするコンテンツを可視化することです。検索エンジンは、ページの特徴を抽出してコンテンツの内容を判断します。このように、両者は共生しています。抽出された特徴は、関連性を示すシグナルと一致し、ランキングに反映されます。

検索エンジンが何を効果的に抽出できているかを理解するために、そのコンテンツの構成要素を分解し、モバイルとデスクトップのコンテキスト間でそれらの特徴の発生率を調べました。また、モバイルとデスクトップのコンテンツの格差についても検討しました。モバイルとデスクトップの格差がとくに重要なのは、Googleがすべての新規サイトに対して<a hreflang="en" href="https://developers.google.com/search/blog/2020/03/announcing-mobile-first-indexing-for"> _mobile-first indexing_ </a>（MFI）は、すべての新しいサイトで2021年3月の時点でモバイルコンテキスト内に表示されない _mobile-only index_ iSeriesコンテンツへ移動します。ランキングの評価は行われません。

#### レンダリングされたテキストコンテンツとレンダリングされていないテキストコンテンツ

ウェブの発展に伴い、シングルページアプリケーション（SPA）[JavaScript](./javascript)技術の使用が爆発的に増加しています。このデザインパターンは実行時のJavaScript変換の実行と、ロード後のページでのユーザーのインタラクションの両方が、追加コンテンツの表示やレンダリングを引き起こす可能性があるため、検索エンジンのスパイダーにとっては困難なものとなっています。

検索エンジンはそのクロール活動を通じてページに出会いますが、ページをレンダリングする第2段階を実施することを選択する場合もあれば、しない場合もあります。その結果、ユーザーが目にするコンテンツと、検索エンジンがインデックスを作成し、ランキングの対象とするコンテンツとの間に差異が生じることがあります。

その格差のヒューリスティックな指標として、語数を評価しました。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">価値観</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">差異</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>そのまま</td>
        <td class="numeric">360</td>
        <td class="numeric">312</td>
        <td class="numeric">-13.33%</td>
      </tr>
      <tr>
        <td>レンダリング</td>
        <td class="numeric">402</td>
        <td class="numeric">348</td>
        <td class="numeric">-13.43%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">差異</th>
        <th scope="col" class="numeric">11.67%</th>
        <th scope="col" class="numeric">11.54%</th>
        <td></td>
      </tr>
    </tfoot>
  </table>
  <figcaption>
    {{ figure_link(
      caption="デスクトップとモバイルのページあたりのそのままの単語数とレンダリングされた単語数の中央値の比較。",
      sheets_gid="775602646",
      sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
    ) }}
  </figcaption>
</figure>

今年は、デスクトップページの中央値が402語、モバイルページの中央値は348語であることがわかりました。一方、[昨年](../2019/seo#word-count)では、デスクトップページの中央値は346語、モバイルページの中央値は306語と、わずかに語数が少なかった。これはそれぞれ16.2%と13.7%の成長を示しています。

その結果、デスクトップサイトの中央値は、生のHTMLを最初にクロールしたときと比較して、レンダリング時に表示される文字数は11.67%多いことがわかりました。また、モバイルサイトの中央値は、デスクトップサイトに比べてテキストコンテンツの表示は13.33%少ないことがわかりました。モバイルサイトの中央値は、生のHTMLに比べてレンダリング時に表示される単語数は11.54%多いことがわかりました。

今回のサンプルセットでは、モバイル／デスクトップ、レンダリング／非レンダリングの組み合わせに格差が見られました。これは検索エンジンがこの分野で継続的に改善しているにもかかわらず、ウェブ上のほとんどのサイトは、コンテンツが利用可能でインデックス可能であることを確実にすることへ集中することでオーガニック検索の可視性を向上させる機会を逃していることを示唆しています。また多くのSEOツールは、上記のようなコンテキストの組み合わせではクロールせず、自動的に問題として認識するためこの点も懸念されます。

#### 見出し

見出し要素（`H1`～`H6`）は、ページのコンテンツの構造を視覚的に示す仕組みとして機能します。これらのHTML要素は検索ランキングにおいて以前のような重みはありませんが、ページを構造化し、 _featured snippets_ や<a hreflang="en" href="https://www.blog.google/products/search/search-on/">Googleの新しいパッセージインデックス</a>に沿った他の抽出方法のように検索エンジン結果ページ（SERP）の他の要素にシグナルを送るための貴重な方法として機能しています。

{{ figure_markup(
  image="seo-presence-of-h-elements.png",
  caption="空の見出しを含む、見出しレベル1から4の使用。",
  description="見出し要素（レベル1、2、3、4）を持つページの割合を示す棒グラフ。モバイルとデスクトップの両方で、60%以上のページがH1要素を備えています。この数字は、H2とH3では60％以上、H4では40％前後で推移しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=2103713054&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

60%以上のページが、モバイルとデスクトップの両方で`H1`要素（空のものも含む）を使用しています。

これらの数字は、`H2`と`H3`で60%以上を占めています。`H4`要素の出現率は4%以下で、ほとんどのページではこのレベルの特殊性は必要とされていないか、開発者がコンテンツの視覚的構造をサポートするために他の見出し要素を別のスタイルにしていることを示唆しています。

`H2`要素が`H1`要素よりも多いということは、複数の`H1`要素を使用しているページが少ないことを示唆しています。

{{ figure_markup(
  image="seo-presence-of-non-empty-h-elements.png",
  caption="空の見出しを除く、見出しレベル1から4の使用法。",
  description="見出し要素が空でないページの割合を示す棒グラフ（レベル1，2，3，4）。H1の7.55％、H2の1.4％、H3の1.5％、H4の1.1％にテキストがないことがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=833166653&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

空ではない見出し要素の採用状況を確認したところ、テキストがない要素は、`H1`が7.55％、`H2`が1.4％、`H3`が1.5％、`H4`が1.1％でした。このような結果になった理由としては、これらの部分がページのスタイリングのために使われているか、あるいはコーディングミスの結果であることが考えられます。

見出しの使い方については、[マークアップの章](./markup#headings)で詳しく説明していますが、これには非標準の`H7`や`H8`要素の誤用も含まれています。

#### 構造化データ

過去10年間、検索エンジン、とくにGoogleは、ウェブのプレゼンテーション層になることを目指して邁進し続けてきました。これらの進歩は、非構造化コンテンツから情報を抽出する能力の向上（例：<a hreflang="en" href="https://blog.google/products/search/search-on/">パッセージ・インデックス</a>）や、 _構造化データ_ という形でのセマンティック・マークアップの採用によって部分的に推進されています。検索エンジンはコンテンツ制作者や開発者に対して、検索結果のコンポーネント内でコンテンツをより見やすくするために、構造化データを実装することを推奨しています。

検索エンジンは、<a hreflang="en" href="https://blog.google/products/search/introducing-knowledge-graph-things-not/">「文字列からモノへ」</a>という流れの中で、ウェブコンテンツ内のさまざまな人、場所、モノをマークアップするための、幅広いオブジェクトの語彙に合意しました。しかし、その語彙の一部だけが、検索結果のコンポーネントに含まれます。Googleは、サポートしている語彙とその表示方法を<a hreflang="en" href="https://developers.google.com/search/docs/guides/search-gallery">search gallery</a>で指定し、そのサポートと実装を検証するための<a hreflang="en" href="https://search.google.com/test/rich-results">ツール</a>を提供しています。

検索エンジンが進化してこれらの要素が検索結果へ反映されるようになると、異なる語彙の発生率がウェブ上で変化します。

検証の一環として、さまざまな種類の構造化マークアップの発生率を調べてみました。利用可能な語彙には、<a hreflang="en" href="https://www.w3.org/TR/rdfa-primer/">RDFa</a>と<a hreflang="en" href="https://schema.org/">schema.org</a>があり、これらにはmicroformatsと<a hreflang="en" href="https://www.w3.org/TR/json-ld11/">JSON-LD</a>の両方の種類があります。Googleは最近<a hreflang="en" href="https://developers.google.com/search/blog/2020/01/data-vocabulary">data-vocabulary</a>のサポートを終了しましたが、これは主にパンくずの実装に使用されていました。

一般的に、JSON-LDはよりポータブルで管理しやすい実装であると考えられているため、このフォーマットが好まれています。その結果、モバイルページの29.78％、デスクトップページの30.60％にJSON-LDが採用されていることがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <th>フォーマット</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>JSON-LD</td>
        <td class="numeric">29.78%</td>
        <td class="numeric">30.60%</td>
      </tr>
      <tr>
        <td>Microdata</td>
        <td class="numeric">19.55%</td>
        <td class="numeric">17.94%</td>
      </tr>
      <tr>
        <td>RDFa</td>
        <td class="numeric">1.42%</td>
        <td class="numeric">1.63%</td>
      </tr>
      <tr>
        <td>Microformats2</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.10%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="各構造化データフォーマットの使い方",
      sheets_gid="361660017",
      sql_file="pages_wpt_bodies_structured_data_by_device_and_format.sql"
    ) }}
  </figcaption>
</figure>

このタイプのデータでは、モバイルとデスクトップの格差が続いていることがわかります。Microdataは、モバイルページの19.55％、デスクトップページの17.94％に掲載されています。RDFaは、モバイルページの1.42％、デスクトップページの1.63％に掲載されています。

##### レンダリングされた構造化データとレンダリングされていない構造化データ

その結果、デスクトップページの38.61%、モバイルページの39.26%が、生のHTMLにJSON-LDまたはmicroformatの構造化データを搭載しており、デスクトップページの40.09%、モバイルページの40.97%がレンダリングされたDOMに構造化データを搭載していることがわかりました。

さらに詳しく調べてみるとデスクトップページの1.49％、モバイルページの1.77％が、検索エンジンのJavaScriptの実行能力に依存して、JavaScriptの変換によってレンダリングされたDOM内にこの種の構造化データを掲載していることがわかりました。

最後にデスクトップページの4.46%、モバイルページの4.62%が、生のHTMLに表示され、その後レンダリングされたDOM内でJavaScriptの変換によって変更された構造化データを備えていることがわかりました。構造化データの構成に適用された変更の種類によっては、検索エンジンがレンダリングする際に複雑なシグナルを生成する可能性があります。

##### もっとも一般的な構造化データオブジェクト

[昨年に引き続き](../2019/seo#structured-data)、もっとも普及している構造化データオブジェクトは`WebSite`、`SearchAction`、`WebPage`、`Organization`、`ImageObject`であり、これらの使用量は増え続けています。

* `WebSite`は、デスクトップで9.37%、モバイルで10.5%の成長を遂げました。
* `SearchAction`はデスクトップとモバイルの両方で7.64%成長しました。
* `WebPage`はデスクトップで6.83%、モバイルで7.09%成長しました。
* `Organization`はデスクトップで4.75%、モバイルで4.98%成長しました。
* `ImageObject`の成長率は、デスクトップで6.39%、モバイルで6.13%でした。

`WebSite`、`SearchAction`、`Organization`はいずれも一般的にホームページに関連するもので、これはデータセットの偏りを示すものであり、ウェブ上で実装されている構造化データの大部分を反映しているわけではありません。

一方、レビューはホームページと関連づけられるべきではないにもかかわらず、データによると、モバイルでは23.9%、デスクトップでは23.7%に`AggregateRating`が使用されています。

また、動画に注釈をつけるための<a hreflang="en" href="https://developers.google.com/search/docs/data-types/video">`VideoObject`</a>の成長も興味深いものがあります。Googleの動画検索結果では<a hreflang="en" href="https://moz.com/blog/youtube-dominates-google-video-results-in-2020">YouTubeの動画が圧倒的に多いのですが</a>、`VideoObject`の使用率はデスクトップで30.11%、モバイルで27.7%と伸びています。

これらのオブジェクトの増加は、構造化データの導入が進んでいることを一般的に示しています。また、Googleが検索機能の中で可視化すると、あまり使われていないオブジェクトの発生率が高まることも示唆されています。Googleは2019年に<a hreflang="en" href="https://developers.google.com/search/docs/data-types/faqpage">`FAQPage`</a>、<a hreflang="en" href="https://developers.google.com/search/docs/data-types/how-to">`HowTo`</a>、<a hreflang="en" href="https://developers.google.com/search/docs/data-types/qapage">`QAPage`</a>のオブジェクトを可視化の機会として発表し、それらは前年比で大幅な成長を維持しました。

* `FAQPage`のマークアップは、デスクトップでは3,261%、モバイルでは3,000%増加しました。
* `HowTo`マークアップは、デスクトップでは605％、モバイルでは623％増加しました。
* `QAPage`のマークアップは、デスクトップで166.7%、モバイルで192.1%増加しました。

<aside class="note">
  繰り返しになりますが、これらのオブジェクトは通常、内部ページに配置されているため、このデータは彼らの実際の成長レベルを代表していない可能性があることに注意する必要があります。
</aside>

構造化データの採用は、データを抽出することが豊富なユースケースにとって価値があるため、ウェブに恩恵をもたらします。検索エンジンの利用が拡大し、ウェブ検索以外のアプリケーションにも利用されるようになると、構造化データは今後も増加すると予想されます。

#### メタデータ

メタデータは、クリックの向こう側にあるコンテンツの価値を説明し、解説する機会です。ページタイトルは検索順位に直接影響すると考えられていますが、メタ・ディスクリプションはそうでありません。どちらの要素もその内容に基づいて、ユーザーのクリックを促したり、阻害したりできます。

これらの特徴を調べ、ページがオーガニック検索からのトラフィックを促進するためのベストプラクティスに定量的に合致しているかを確認しました。

##### タイトル

ページタイトルは検索エンジンの検索結果にアンカーテキストとして表示され、一般的に、ページのランキングに影響を与えるもっとも価値のあるオンページ要素の1つと考えられています。

`title`タグの使用状況を分析したところ、デスクトップおよびモバイルページの99%にタグが付いてることがわかりました。これは、モバイルページの97%が`title`タグを持っていた[昨年](../2019/seo#page-titles)からわずかに改善されています。

中央値のページは、ページタイトルが6語となっています。このデータセットでは、モバイルとデスクトップの間で単語数に違いはありませんでした。これは、ページタイトル要素が、異なるページテンプレートタイプ間で変更されない要素であることを示唆しています。

{{ figure_markup(
  image="seo-title-word-count.png",
  caption="ページタイトルごとの文字数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとにタイトルタグのWord数を示す棒グラフ。中央値のページのページタイトルの長さは6語です。今回のデータセットでは、モバイルとデスクトップで単語数に違いはありませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=2028212539&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

ページタイトルの文字数の中央値は、モバイルとデスクトップの両方で38文字となっています。興味深いことに、[昨年の分析結果](../2019/seo#page-titles)ではデスクトップで20文字、モバイルで21文字でしたが、今回はそれよりも増えています。コンテキスト間の格差は、90パーセンタイル内で1文字の差があることを除いて、前年比でなくなっています。

{{ figure_markup(
  image="seo-title-character-count.png",
  caption="ページタイトルごとの文字数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとのtitleタグの文字数を示す棒グラフ。ページタイトルの文字数の中央値は、モバイル、デスクトップともに38文字です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1040977563&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

##### メタ・ディスクリプション

meta descriptionは、Webページの広告キャッチフレーズの役割を果たします。<a hreflang="en" href="https://www.searchenginejournal.com/google-rewrites-meta-descriptions-over-70-of-the-time/382140/">最近の調査</a>によると、このタグは70%の確率でGoogleに無視され、書き換えられているという結果が出ていますがユーザーのクリックを誘う目的で用意される要素です。

メタ・ディスクリプションの使用状況を分析したところ、デスクトップ・ページの68.62%、モバイル・ページの68.22%にメタ・ディスクリプションがあることがわかりました。これは意外と低いかもしれませんが、モバイルページの64.02%しかメタディスクリプションを持っていなかった[昨年](../2019/seo#meta-descriptions)と比べると、少し改善されています。

{{ figure_markup(
  image="seo-meta-description-word-length.png",
  caption="メタ・ディスクリプションごとの単語数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとのmeta descriptionタグの単語数を示す棒グラフ。我々のデータセットにおけるmeta descriptionの長さの中央値は19Wordです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=156955276&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

メタディスクリプションの長さの中央値は19Wordです。唯一の単語数の格差は、デスクトップのコンテンツがモバイルよりも1単語多い90パーセンタイルで発生します。

{{ figure_markup(
  image="seo-meta-description-character-length.png",
  caption="メタ・ディスクリプション1つあたりの文字数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとのmeta descriptionタグの文字数を示す棒グラフ。メタディスクリプションの文字数の中央値は、デスクトップページで138文字、モバイルページで136文字となっている",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1293879233&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

メタディスクリプションの文字数の中央値は、デスクトップページで138文字、モバイルページで136文字となっています。75パーセンタイルを除けば、データセット全体でモバイルとデスクトップのmeta descriptionの長さにはわずかな差があります。SEOのベストプラクティスでは、指定されたmeta descriptionを160文字以内に抑えることが推奨されていますが、Googleはスニペットで300文字以上を表示することがあります。

メタ・ディスクリプションがソーシャル・スニペットやニュース・フィード・スニペットなどの他のスニペットに影響を与え続けていること、またGoogleがメタ・ディスクリプションを継続的に書き換えており直接的なランキング要因とは考えていないことを考えると、メタ・ディスクリプションが160文字の制限を超えて成長し続けると予想するのは妥当です。

#### イメージ

ページ内で画像、とくに `img` タグを使用することは、コンテンツを視覚的に表現することに重点を置いていることを意味します。コンピュータビジョンに関する検索エンジンの能力は向上し続けていますが、この技術がページのランキングに使用されているという事実はありません。`alt`属性は、検索エンジンが画像を「見る」代わりに、画像を説明するための主要な手段であり続けます。また、`alt`属性はアクセシビリティにも対応しており、視覚障害のあるユーザーに対してページ上の要素を明確にできます。

デスクトップページの中央値には21個の `img` タグが含まれ、モバイルページの中央値には19個の `img` タグが含まれています。帯域幅の拡大やスマートフォンの普及により、ウェブは画像を多用する傾向にあります。しかし、これはパフォーマンスを犠牲にします。

{{ figure_markup(
  image="seo-img-elements-per-page.png",
  caption="ページあたりの`<img>`要素数の分布。",
  description="ページあたりの`<img>`要素の数をパーセンタイル（10、25、50、75、90）で表した棒グラフです。デスクトップページの中央値には21個の`<img>`要素が、モバイルページの中央値には19個の`<img>`タグが配置されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=923860709&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
) }}

ウェブページの中央値は、デスクトップでは2.99%の`alt`属性が欠けており、モバイルでは2.44%の`alt`属性が欠けています。`alt`属性の重要性については、[アクセシビリティ](./accessibility)の章を参照してください。

{{ figure_markup(
  image="seo-percentage-of-missing-img-alt-attribute.png",
  caption="イメージの`alt`属性を欠く`<img>`要素のページあたりの割合の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとに欠落している`alt`属性の割合を示す棒グラフ。中央値のWebページでは、デスクトップで2.99%の`alt`属性が欠落しており、モバイルでは2.44%の`alt`属性が欠落しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=862590664&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
  )
}}

その結果、中央値のページでは、画像の51.22%にしか`alt`属性が含まれていないことがわかりました。

{{ figure_markup(
  image="seo-percentage-of-img-alt-attributes-present.png",
  caption="ページごとの`alt`属性を持つ画像の割合の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとに存在する`alt`属性の割合を示す棒グラフ。デスクトップでは53.86％、モバイルでは51.22％のページにしか画像の`alt`属性が表示されていないことがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=827771545&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
) }}

ウェブページの中央値では、空白の`alt`属性を持つ画像が、デスクトップは10.00%、モバイルでは11.11%ありました。

{{ figure_markup(
  image="seo-percentage-of-blank-img-alt-attributes.png",
  caption="空白の`alt`属性を持つイメージのページごとの割合の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとに、フィーチャーされた`alt`のブランク属性の割合を示す棒グラフ。ウェブページの中央値は、デスクトップでは10％、モバイルでは11.11％の空白の`alt`属性が表示されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=378651979&format=interactive",
  sheets_gid="1317352222",
  sql_file="pages_markup_by_device_and_percentile.sql"
) }}

### リンク

現代の検索エンジンはページ間のハイパーリンクを利用して、新しいコンテンツを発見してインデックスを作成したり、権威を示してランキングに反映させたりしています。リンクグラフは、検索エンジンがアルゴリズムと手動によるレビューの両方で積極的に管理しているものです。したがって、ページ全体に豊富なリンクを張ることが重要ですが、Googleが<a hreflang="en" href="https://developers.google.com/search/docs/beginner/seo-starter-guide#use-links-wisely">SEOスターターガイド</a>で言及しているように賢くリンクを張ることも重要です。

#### 発信リンク

この分析の一環として、各ページからの発信リンクを評価できます。同じドメインの内部ページや外部ページへのリンクかどうかを評価できますが、着信リンクは分析していません。

デスクトップページの中央値には76本のリンクがあり、モバイルページの中央値には67本のリンクがあります。歴史的には、Googleからの指示により、リンクは1ページあたり100個までにするよう提案されていました。この推奨事項は現代のウェブでは時代遅れであり、Googleはその後、<a hreflang="en" href="https://www.seroundtable.com/google-link-unlimited-18468.html">制限なし</a>と言及していますが、私たちのデータセットの中央値のページはそれを守っています。

{{ figure_markup(
  image="seo-outgoing-links.png",
  caption="ページごとのリンク数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとのリンク数を示す棒グラフ。デスクトップページの中央値には76本、モバイルページの中央値には67本のリンクが張られています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=284216213&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

中央値のページの内部リンク（同じサイト内のページへのリンク）は、デスクトップで61、モバイルで54となっています。これは[昨年の分析](../2019/seo#linking)からそれぞれ12.8%と10%減少しています。このことから、サイトは一昨年のように、ページ内のクローラビリティとリンクエクイティの流れを改善する能力を最大限に発揮できていないと考えられます。

{{ figure_markup(
  image="seo-outgoing-links-internal.png",
  caption="ページごとの内部リンク数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとの内部リンクの数を示す棒グラフ。デスクトップページの中央値には61本の内部リンクがあり、モバイルページの中央値には54本の内部リンクがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=739265254&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

ページの中央値は、外部サイトへのリンクがデスクトップで7回、モバイルで6回となっています。これは、1ページあたりの外部リンク数の中央値がデスクトップで10回、モバイルで8回であった昨年よりも減少しています。このような外部リンクの減少はリンクポピュラリティを渡さないために、あるいはユーザーを紹介するために、ウェブサイトが他のサイトにリンクする際により慎重になっていることを示唆していると考えられます。

{{ figure_markup(
  image="seo-outgoing-links-external.png",
  caption="ページごとの外部への発信リンク数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとの外部発信リンクの数を示す棒グラフ。中央値のページは、外部サイトへのリンクがデスクトップで7回、モバイルで6回となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=391564643&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

#### テキストリンクとイメージリンク

ウェブページの中央値では、デスクトップページの9.80％、モバイルページの9.82％で画像をアンカーテキストとして使用してリンクを張っています。これらのリンクは、キーワードに関連したアンカーテキストを実装する機会を失ったことを意味します。これが重大な問題となるのは、ページの90％に達したときです。

{{ figure_markup(
  image="seo-image-links.png",
  caption="ページごとの画像を含むリンクの割合の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとの画像リンクの割合を示す棒グラフ。中央値のウェブページには、デスクトップで9.80％、モバイルで9.82％の画像リンクが貼られています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1292929825&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
) }}

#### モバイルとデスクトップのリンク

Googleがモバイルファーストインデックスだけでなく、モバイルオンリーインデックスにも力を入れるようになると、モバイルとデスクトップのリンクに格差が生じサイトに悪影響を及ぼすことになります。このことは、中央値のウェブページのリンク数がデスクトップの68に対してモバイルでは62であることからもわかります。

{{ figure_markup(
  image="seo-text-links.png",
  caption="ページごとのテキストリンク数の分布。",
  description="パーセンタイル（10、25、50、75、90）ごとのテキストリンク数を示す棒グラフ。モバイルとデスクトップではリンク数に格差がある（モバイル：62リンク、デスクトップ：68リンク）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1588324966&format=interactive",
  sheets_gid="775602646",
  sql_file="pages_wpt_bodies_by_device_and_percentile.sql"
  )
}}

#### `rel=nofollow`、`ugc`、`sponsored`属性の使用法

2019年9月、<a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">Googleが属性を導入しました</a>これにより、パブリッシャーはリンクをスポンサー付きコンテンツまたはユーザー生成コンテンツとして分類できます。 これらの属性は、以前は<a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">2005年に導入された`rel=nofollow`へ追加されます</a>。 新しい属性 `rel=ugc`と`rel=sposnsored`は、これらのリンクが特定のWebページに表示される理由を明確化または限定することを目的としています。

ページを調査したところ、デスクトップでは28.58％、モバイルでは30.74％のページに`rel=nofollow`属性が含まれていました。しかし、`rel=ugc`と`rel=sponsored`の採用率は非常に低く、0.3%未満のページ（約20,000ページ）にしか採用されていません。これらの属性は、パブリッシャーにとって`rel=nofollow`よりも付加価値がないため、今後も採用率が低くなると予想するのが妥当でしょう。

{{ figure_markup(
  image="seo-nofollow-ugc-sponsored-attributes.png",
  caption="`rel=nofollow`、`rel=ugc`、`rel=sponsored`の属性を持つページの割合です。",
  description="デスクトップとモバイルにおける`rel`属性の使用率（%）を示す棒グラフ。我々の調査によると、デスクトップ版で28.58%、モバイル版では30.74%のページが `nofollow`属性を採用しています。しかし、`ugc`と`sponsored`の採用率は非常に低く、0.3%以下のページしか採用されていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1177251312&format=interactive",
  sheets_gid="1271677392",
  sql_file="pages_robots_txt_by_device_and_status.sql"
) }}

## アドバンスド

このセクションではサイトのクローラビリティやインデクサビリティには直接影響しないものの、検索エンジンがランキングシグナルとして使用していることが確認されていたり、ウェブサイトが検索機能を利用する能力に影響を与えるようなウェブの構成や要素に関する最適化の機会を探ります。

### モバイル対応

ウェブを閲覧、検索することにモバイルデバイスの利用が増えていることから、検索エンジンは数年前からモバイルフレンドリーを<a hreflang="en" href="https://developers.google.com/search/blog/2015/02/finding-more-mobile-friendly-search">ランキング要素として考慮しています</a>。

また先に述べたように、<a hreflang="en" href="https://developers.google.com/search/blog/2016/11/mobile-first-indexing">2016年から</a>Googleはモバイルファーストインデックスに移行しており、クロール、インデックス、ランキングされるコンテンツは、モバイルユーザーや<a hreflang="en" href="https://developers.google.com/search/docs/advanced/crawling/googlebot?hl=en">スマートフォンのGooglebot</a>がアクセスできるものであることを意味しています。

さらに、<a hreflang="en" href="https://developers.google.com/search/blog/2019/05/mobile-first-indexing-by-default-for">2019年7月以降</a>、Googleはすべての新しいウェブサイトにモバイルファーストインデックスを使用しており、3月初めには、<a hreflang="en" href="https://webmasters.googleblog.com/2020/03/announcing-mobile-first-indexing-for.html">検索結果に表示されるページの70%がすでに移行していることを発表しました</a>。現在、Googleは2021年3月に<a hreflang="en" href="https://webmasters.googleblog.com/2020/07/prepare-for-mobile-first-indexing-with.html">全面的にモバイルファーストインデックスに切り替えると予想されています</a>。

モバイルフレンドリーは、良好な検索体験を提供し、結果的に検索結果での順位を上げたいと考えているWebサイトにとって基本的なことです。

モバイルフレンドリーなウェブサイトを実現するには、レスポンシブウェブデザインを採用する方法、ダイナミックサービングを使用する方法、モバイルウェブ版を別途用意する方法など、さまざまな方法があります。しかしモバイル版を別に用意することは、Googleからは推奨されておらず、レスポンシブウェブデザインが推奨されています。

#### ビューポートのメタタグ

ブラウザのビューポートとは、ページコンテンツの可視領域のことで、使用するデバイスに応じて変化します。`<meta name="viewport">`タグ（またはviewport metaタグ）を使用すると、ブラウザにビューポートの幅とスケーリングを指定でき、異なるデバイス間で正しいサイズを表示できます。レスポンシブWebサイトでは、viewport metaタグとCSSメディアクエリを使用して、モバイルフレンドリーな表示を実現しています。

モバイルページの42.98％、デスクトップページの43.2％が、`content=initial-scale=1,width=device-width`属性のviewport metaタグを記述しています。しかしモバイルページの10.84％、デスクトップページの16.18％は、このタグをまったく含んでおらず、まだモバイルフレンドリーではないことがうかがえます。

<figure>
  <table>
    <thead>
      <tr>
        <th>ビューポート</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>initial-scale=1,width=device-width</code></td>
        <td class="numeric">42.98%</td>
        <td class="numeric">43.20%</td>
      </tr>
      <tr>
        <td><em>not-set</em></td>
        <td class="numeric">10.84%</td>
        <td class="numeric">16.18%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,width=device-width</code></td>
        <td class="numeric">5.88%</td>
        <td class="numeric">5.72%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width</code></td>
        <td class="numeric">5.56%</td>
        <td class="numeric">4.81%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width</code></td>
        <td class="numeric">3.93%</td>
        <td class="numeric">3.73%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="各ビューポートメタタグの<code>content</code>属性値を持つページの割合。",
      sheets_gid="479500659",
      sql_file="../markup/summary_pages_by_device_and_viewport.sql"
    ) }}
  </figcaption>
</figure>

#### CSSメディアクエリ

メディアクエリは、レスポンシブWebデザインの基本的な役割を果たすCSS3の機能です。メディアクエリは、ブラウザやデバイスが特定のルールに合致した場合にのみスタイリングを適用する条件を指定できます。これにより、同じHTMLでもビューポートサイズに応じて異なるレイアウトを作成できます。

デスクトップページの80.29％、モバイルページの82.92％が`height`、`width`、`aspect-ratio`のいずれかのCSS機能を使用しており、高い割合でレスポンシブ機能を搭載していることがわかりました。もっともよく使われている機能を以下の表に示します。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>max-width</code></td>
        <td class="numeric">78.98%</td>
        <td class="numeric">78.33%</td>
      </tr>
      <tr>
        <td><code>min-width</code></td>
        <td class="numeric">75.04%</td>
        <td class="numeric">73.75%</td>
      </tr>
      <tr>
        <td><code>-webkit-min-device-pixel-ratio</code></td>
        <td class="numeric">44.63%</td>
        <td class="numeric">38.78%</td>
      </tr>
      <tr>
        <td><code>orientation</code></td>
        <td class="numeric">33.48%</td>
        <td class="numeric">33.49%</td>
      </tr>
      <tr>
        <td><code>max-device-width</code></td>
        <td class="numeric">26.23%</td>
        <td class="numeric">28.15%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="各メディアクエリ機能が含まれているページの割合。",
      sheets_gid="1141218471",
      sql_file="../css/media_query_features.sql"
    ) }}
  </figcaption>
</figure>

#### `Vary: User-Agent`

動的な配信構成（使用するデバイスに基づいて同じページの異なるHTMLを表示する構成）でモバイルフレンドリーなWebサイトを実装する場合は、検索エンジンがを検出できるように、 `Vary：User-Agent`HTTPヘッダーを追加することをオススメします。 Webサイトをクロールするときのモバイルコンテンツ。これは、応答がユーザーエージェントによって異なることを通知するためです。

モバイルページの13.48％とデスクトップページの12.6％のみが、 `Vary：User-Agent`ヘッダーを指定していることがわかりました。

```html
<link rel="alternate" media="only screen and (max-width: 640px)">
```

モバイル版を持つデスクトップのウェブサイトは、HTMLの`head`内にこのタグを使ってリンクを張ることが推奨されます。分析したデスクトップページのうち、指定した`media`属性値でこのタグを含んでいるのは0.64%に過ぎませんでした。

### Webパフォーマンス

ウェブサイトの読み込みが速いことは、ユーザーに優れた検索体験を提供するための基本です。その重要性から、長年にわたり検索エンジンのランキング要素として考慮されてきました。Googleは当初、2010年に<a hreflang="en" href="https://webmasters.googleblog.com/2010/04/using-site-speed-in-web-search-ranking.html">ランキング要因としてサイトスピードを使用することを発表し</a>、その後2018年に<a hreflang="en" href="https://webmasters.googleblog.com/2018/01/using-page-speed-in-mobile-search.html">モバイル検索</a>でも同様のことを行いました。

2020年11月に発表されたように、<a hreflang="en" href="https://webmasters.googleblog.com/2020/05/evaluating-page-experience.html">Core Web Vitals</a>と呼ばれる3つのパフォーマンス指標は、2021年5月に「ページ体験」シグナルの一部としてランキング要因となる予定です。Core Web Vitalsの構成は以下の通りです。

**<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">Largest Contentful Paint</a> (LCP)**
- 表現：ユーザーが感じるロードエクスペリエンス
- 測定：ページロードタイムラインにおいて、ビューポート内にページ最大の画像またはテキストブロックが表示される時点
- 目標：2.5秒未満

**<a hreflang="ja" href="https://web.dev/i18n/ja/fid/">First Input Delay</a> (FID)**
- 表現：ユーザーの入力に対するレスポンスの良さ
- 計測：ユーザーが最初にページへアクセスしてから、そのアクセスに対応するイベントハンドラーの処理をブラウザが実際に開始できるまでの時間
- 目標：300ミリ秒未満

**<a hreflang="ja" href="https://web.dev/i18n/ja/cls/">Cumulative Layout Shift</a> (CLS)**
- 表現：視覚的安定性
- 計測方法：シフトしたビューポートの割合に近似した _レイアウトシフトスコア_ の数の合計値
- 目標：<0.10

#### デバイスごとのCore Web Vitals体験

モバイルデバイスを利用するユーザーが増えているにもかかわらず、デスクトップは引き続きユーザーにとってよりパフォーマンスの高いプラットフォームとなっています。Core Web Vitalsの評価では、デスクトップ版では33.13%が「良い」と評価されたのに対し、モバイル版では19.96%しか評価されませんでした。

{{ figure_markup(
  image="seo-good-core-web-vitals-score-per-device.png",
  caption="デバイスごとのCore Web Vitals評価に合格したウェブサイトの割合。",
  description="デバイスごとにコア・ウェブ・バイタルの良いスコアを獲得したウェブサイトの割合を示す棒グラフです。デスクトップ版では33.13%のウェブサイトが「良い」と評価されたのに対し、モバイル版では19.96%しかコア・ウェブ・バイタルの評価に合格していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=1601210449&format=interactive",
  sheets_gid="996380787",
  sql_file="../performance/web_vitals_by_device.sql"
) }}

#### 国ごとのCore Web Vitalsの経験

ユーザーの物理的な位置は、その地域で利用可能な通信インフラ、ネットワーク帯域幅の容量、データのコストなどにより、独自の負荷条件が生じるため、パフォーマンスの認識に影響を与えます。

米国にいるユーザーは、合格点を獲得しているサイトは32％にすぎないにもかかわらず、_Good_ Core WebVitalsエクスペリエンスを備えたWebサイトの絶対数が最大でした。 韓国は、_Good_ Core Web Vitalエクスペリエンスの割合が52％ともっとも高かった。 各国が要求するウェブサイト全体の相対的な部分は注目に値します。 米国のユーザーは、韓国のユーザーが生成した発信元リクエストの合計の8倍を生成しました。

{{ figure_markup(
  image="seo-aggregate-cwv-performance-by-country.png",
  caption="国別のCore Web Vitals評価に合格したウェブサイトの割合。",
  description="国別のコア・ウェブ・バイタルのパフォーマンスを集約した横棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=2077593128&format=interactive",
  sheets_gid="220428774",
  sql_file="../performance/web_vitals_by_country.sql",
  width=645,
  height=792
) }}

Core Web Vitalsのパフォーマンスについて、有効な接続タイプ別のディメンションや特定のメトリクスによる追加分析は、[パフォーマンスの章](./performance)でご覧いただけます。

### 国際化

国際化とは多言語・多国語対応のウェブサイトが、異なる言語や国のバージョンを検索エンジンに通知し、それぞれのケースでユーザーに表示する関連ページを特定しターゲティングの問題を回避するために使用できる設定を指します。

今回分析した2つの国際的な設定は、`content-language`というメタタグと`hreflang`という属性で、これを使って各ページの言語とコンテンツを指定できます。さらに、`hreflang`アノテーションでは、各ページの代替言語や国別バージョンを指定できます。

<a hreflang="en" href="https://support.google.com/webmasters/answer/189077?hl=en">Google</a>や<a hreflang="en" href="https://yandex.com/support/webmaster/yandex-indexing/locale-pages.html">Yandex</a>のような検索エンジンはページの言語や国のターゲットを決定するシグナルとして`hreflang`属性を使用しており、GoogleはHTMLのlangや`content-language`メタタグを使用していませんが、後者の最後のタグはBingが使用しています。

#### `hreflang`

デスクトップページの8.1％、モバイルページの7.48％が`hreflang`属性を使用しており、低いと思われるかもしれませんが、これは多言語や複数の国のウェブサイトでのみ使用されているので当然です。

その結果、HTTPヘッダーで`hreflang`を実装しているのは、デスクトップページは0.09％、モバイルページでは0.07％にすぎず、ほとんどがHTMLの`head`による実装に依存していることがわかりました。

また、hreflangアノテーションのレンダリングにJavaScriptを使用しているページがあることも確認しました。デスクトップおよびモバイルページの0.12%が、生のHTMLではなくレンダリングされたものに`hreflang`を表示していました。

言語と国の値の観点から、HTMLヘッドを介した実装を分析したところ、英語（`en`）がもっともよく使われており、モバイルページの4.11%、デスクトップページの4.64%にこの値が含まれていることがわかりました。英語に次いで多く使われている値は、`x-default`（対象外の言語や国のユーザー向けに _default_ や _fallback_ のバージョンを定義する際に使用）で、モバイルページの2.07%、デスクトップページの2.2%がこの値を含んでいます。

3番目、4番目、5番目に人気があるのは、ドイツ語（`de`）、フランス語（`fr`）、スペイン語（`es`）で、イタリア語（`it`）、アメリカ英語（`en-us`）と続きますが下の表にあるように残りの値はHTMLの`head`で実装されています。

<figure>
  <table>
    <thead>
      <tr>
        <th>値</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>en</code></td>
        <td class="numeric">4.11%</td>
        <td class="numeric">4.64%</td>
      </tr>
      <tr>
        <td><code>x-default</code></td>
        <td class="numeric">2.07%</td>
        <td class="numeric">2.20%</td>
      </tr>
      <tr>
        <td><code>de</code></td>
        <td class="numeric">1.76%</td>
        <td class="numeric">1.88%</td>
      </tr>
      <tr>
        <td><code>fr</code></td>
        <td class="numeric">1.74%</td>
        <td class="numeric">1.87%</td>
      </tr>
      <tr>
        <td><code>es</code></td>
        <td class="numeric">1.74%</td>
        <td class="numeric">1.84%</td>
      </tr>
      <tr>
        <td><code>it</code></td>
        <td class="numeric">1.27%</td>
        <td class="numeric">1.33%</td>
      </tr>
      <tr>
        <td><code>en-us</code></td>
        <td class="numeric">1.15%</td>
        <td class="numeric">1.31%</td>
      </tr>
      <tr>
        <td><code>ru</code></td>
        <td class="numeric">1.12%</td>
        <td class="numeric">1.13%</td>
      </tr>
      <tr>
        <td><code>en-gb</code></td>
        <td class="numeric">0.87%</td>
        <td class="numeric">0.98%</td>
      </tr>
      <tr>
        <td><code>pt</code></td>
        <td class="numeric">0.87%</td>
        <td class="numeric">0.87%</td>
      </tr>
      <tr>
        <td><code>nl</code></td>
        <td class="numeric">0.83%</td>
        <td class="numeric">0.94%</td>
      </tr>
      <tr>
        <td><code>ja</code></td>
        <td class="numeric">0.73%</td>
        <td class="numeric">0.81%</td>
      </tr>
      <tr>
        <td><code>pl</code></td>
        <td class="numeric">0.72%</td>
        <td class="numeric">0.75%</td>
      </tr>
      <tr>
        <td><code>de-de</code></td>
        <td class="numeric">0.69%</td>
        <td class="numeric">0.78%</td>
      </tr>
      <tr>
        <td><code>tr</code></td>
        <td class="numeric">0.69%</td>
        <td class="numeric">0.66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="HTMLの<code>head</code>に上位の<code>hreflang</code>の値を含んでいるページの割合。",
      sheets_gid="1272459525",
      sql_file="pages_wpt_bodies_hreflang_by_device_and_link_tag_value.sql"
    ) }}
  </figcaption>
</figure>

また、HTTPヘッダーで実装されている`hreflang`言語と国の値の上位には、若干の違いが見られました。ここでも英語（`en`）がもっとも多く、フランス語（`fr`）、ドイツ語（`de`）、スペイン語（`es`）、オランダ語（`nl`）が続きました。

<figure>
  <table>
    <thead>
      <tr>
        <th>値</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>en</code></td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>fr</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td><code>de</code></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td><code>es</code></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><code>nl</code></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="HTTPヘッダーに上位の<code>hreflang</code>値が含まれるページの割合。",
      sheets_gid="1726610181",
      sql_file="pages_wpt_bodies_hreflang_by_device_and_http_header_value.sql"
    ) }}
</figcaption>
</figure>

#### `Content-Language`

`content-language`の使用状況と値を分析したところ、HTMLの`head`にmetaタグとして実装しているか、HTTPヘッダーに実装しているかにかかわらず、モバイルページの8.5％、デスクトップページの9.05％しかHTTPヘッダーで指定していないことがわかりました。また、HTMLの`head`内の`content-language`タグで言語や国を指定しているWebサイトはさらに少なく、モバイルページの3.63％、デスクトップページの3.59％しかmetaタグを使用していませんでした。

言語と国の値の観点から見ると、`content-language`メタタグやHTTPヘッダーで指定される値は、英語（`en`）と米国英語（`en-us`）がもっとも多くなっています。

英語（`en`）の場合、デスクトップページの4.34％、モバイルページの3.69％がHTTPヘッダーで英語を指定しており、デスクトップページの0.55％、モバイルページの0.48％がHTMLの`head`内の`content-language`メタタグで指定していることがわかりました。

2番目に多い値であるEnglish for US（`en-us`）については、HTTPヘッダーで指定しているのはモバイルページの1.77％、デスクトップページの1.7％、HTMLで指定しているのはモバイルページの0.3％、デスクトップページの0.36％であることがわかりました。

もっとも人気のある言語と国の値の残りの部分は、以下の表で見ることができます。

<figure>
  <table>
    <thead>
      <tr>
        <th>値</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>en</code></td>
        <td class="numeric">3.69%</td>
        <td class="numeric">4.34%</td>
      </tr>
      <tr>
        <td><code>en-us</code></td>
        <td class="numeric">1.77%</td>
        <td class="numeric">1.70%</td>
      </tr>
      <tr>
        <td><code>de</code></td>
        <td class="numeric">0.50%</td>
        <td class="numeric">0.44%</td>
      </tr>
      <tr>
        <td><code>es</code></td>
        <td class="numeric">0.34%</td>
        <td class="numeric">0.33%</td>
      </tr>
      <tr>
        <td><code>fr</code></td>
        <td class="numeric">0.31%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td><code>ru</code></td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.16%</td>
      </tr>
      <tr>
        <td><code>pt-br</code></td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.16%</td>
      </tr>
      <tr>
        <td><code>nl</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.15%</td>
      </tr>
      <tr>
        <td><code>it</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td><code>ja</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.10%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="HTTPヘッダーで上位の<code>content-language</code>の値を使用しているページの割合。",
      sheets_gid="962106511",
      sql_file="summary_requests_by_device_and_http_content_language.sql"
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>値</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>en</code></td>
        <td class="numeric">0.48%</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td><code>en-us</code></td>
        <td class="numeric">0.30%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td><code>pt-br</code></td>
        <td class="numeric">0.24%</td>
        <td class="numeric">0.24%</td>
      </tr>
      <tr>
        <td><code>ja</code></td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>fr</code></td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td><code>tr</code></td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td><code>es</code></td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.15%</td>
      </tr>
      <tr>
        <td><code>de</code></td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>cs</code></td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td><code>pl</code></td>
        <td class="numeric">0.11%</td>
        <td class="numeric">0.09%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
      {{ figure_link(
        caption="HTMLメタタグで上位の<code>content-language</code>の値を使用しているページの割合。",
        sheets_gid="1056888726",
        sql_file="pages_almanac_by_device_and_content_language.sql"
      ) }}
    </figcaption>
</figure>

### セキュリティ

Googleは、あらゆる面でセキュリティにとくに力を入れています。検索エンジンは、不審な活動を行っているサイトやハッキングされたサイトのリストを管理しています。Search Consoleはこれらの問題を表面化させ、Chromeユーザーはこれらの問題があるサイトへアクセスする前に警告を表示します。さらに、Googleは、<a hreflang="en" href="https://developers.google.com/search/blog/2014/08/https-as-ranking-signal">HTTPS</a>(Hypertext Transfer Protocol Secure)で提供されるページに対して、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/security/https">algorithmic boost</a>を提供しています。このトピックに関するより詳細な分析については、[セキュリティ](./security)の章をご覧ください。

#### HTTPSの使用

デスクトップページの77.44％、モバイルページの73.22％がHTTPSを採用していることがわかりました。これは昨年に比べて10.38%増加しています。ここで重要なのは、ブラウザがHTTPSを積極的に推進するようになったことで、HTTPSなしでページを閲覧すると安全ではないというシグナルを発するようになったことです。また、HTTPSは現在、HTTP/2やHTTP/3（HTTP over QUICとも呼ばれる）のようなより高性能なプロトコルを活用するための要件となっています。これらのプロトコルの状況については、[HTTP/2](./http)の章で詳しく説明しています。

これらのことが、前年比での採用率の上昇につながっていると思われます。

{{ figure_markup(
  image="seo-percentage-of-https.png",
  caption="HTTPSで提供されているページの割合。",
  description="デバイス別にHTTPSプロトコルを採用しているページの割合を示す棒グラフ。デスクトップページの77.44％、モバイルページの73.22％がHTTPSを採用していることがわかった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTeddX0_5hUvxpYkd-927hEBlIqzuQiFn5450F2gNc9RJ5K8Wy0ln3KKD-gPWAxJ5Lo3H_km4ljHQEt/pubchart?oid=422955435&format=interactive",
  sheets_gid="337739550",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

### AMP

<a hreflang="en" href="https://amp.dev/">AMP</a>（旧称：Accelerated Mobile Pages）は、とくにモバイル端末でのページの読み込みを速くするための方法として、2015年にGoogleが発表したオープンソースのHTMLフレームワークです。AMPは、既存のウェブページの代替バージョンとして実装することも、AMPフレームワークを使って一から開発することもできます。

ページにAMPバージョンが用意されていると、Googleがモバイル検索結果にAMPロゴとともに表示します。

また、AMPの使用状況はGoogle（または他の検索エンジン）のランキング要素ではありませんが、ウェブスピードはランキング要素であることにも注意が必要です。

さらに、この記事を書いている時点ではニュース関連の出版物にとって重要な機能であるGoogleのモバイル検索結果のトップストーリーズのカルーセルに掲載されるためには、AMPが必須条件となっています。ただしこれは2021年5月に変更され、AMP以外のコンテンツであっても、<a hreflang="en" href="https://support.google.com/news/publisher-center/answer/6204050">Googleニュースのコンテンツポリシー</a>を満たし、今年11月にGoogleが発表した<a hreflang="en" href="https://developers.google.com/search/docs/guides/page-experience">優れた<a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">ページエクスペリエンス</a>を提供するものであれば対象となります。

AMPベースではないページの代替バージョンとしてのAMPの使用状況を確認したところ、モバイルWebページの0.69%、デスクトップWebページの0.81%が、AMPバージョンを指す`amphtml`タグを含んでいることがわかりました。まだまだ採用率は低いですが、モバイルページの0.62%しかAMP版へのリンクを含んでいなかった[昨年の調査結果](../2019/seo#amp)よりも若干改善されています。

一方、ウェブサイト開発のフレームワークとしてのAMPの利用状況を評価したところ、AMPベースのページを示す絵文字属性`<html amp>`や`<html ⚡>`を指定しているのは、モバイルページは0.18%、デスクトップページでは0.07%に過ぎませんでした。

### シングルページのアプリケーション

シングル・ページ・アプリケーション（SPA）は、ユーザーの要求に応じてページ上のコンテンツが更新されても、ブラウザは単一のページ・ロードを保持し更新できます。JavaScriptフレームワーク、AJAX、WebSocketなどの複数の技術が、後続のページロードを軽量化するために使用されています。

これらのフレームワークは特別なSEO上の配慮が必要でしたが、Googleは積極的なキャッシング戦略により、クライアントサイドレンダリングによる問題を軽減するよう努めてきました。<a hreflang="en" href="https://youtu.be/rq8sFkl0KnI">Google Webmaster's 2019 conference</a>のビデオの中でソフトウェアエンジニアのErik Hendriksは、Googleはもはや`Cache-Control`ヘッダーに依存せず、代わりに`ETag`または`Last-Modified`ヘッダーを探してファイルのコンテンツが変更されたかどうかを確認していることを共有しました。

SPAはキャッシュを細かく制御するために、[Fetch API](https://developer.mozilla.org/docs/Web/API/Fetch_API)を利用する必要があります。このAPIでは、特定のキャッシュオーバーライドを設定した `Request` オブジェクトを渡すことができ、必要な `If-Modified` や `ETag` ヘッダーを設定するのに使用できます。

検索エンジンやそのWebクローラーにとって、発見できないリソースはやはり最大の関心事です。検索クローラーは、リンクされたページを見つけるために、`<a>`タグの`href`属性を探します。これらがないと、ページは内部リンクのない孤立したものとみなされます。調査対象となったデスクトップページの5.59％、モバイルレンダリングページの6.04％に内部リンクが含まれていませんでした。これは、そのページがJavaScriptフレームワークのSPAの一部であり、内部リンクを発見するために必要な有効な`href`属性を持つ`<a>`タグがないことを示しています。

SPAに使われている人気のJavaScriptフレームワークのリンクの発見可能性は、2020年に[前年比](../2019/seo#spa-crawlability)で劇的に増加しました。2019年には、Reactサイトのモバイルナビゲーションリンクの13.08%が非推奨のハッシュURLを使用していました。2020年は、テストされたReactのリンクのうち、ハッシュ化されていたのは6.12%だけでした。

同様に、Vue.jsは、前年の8.15%から3.45%に低下しました。Angularは、2019年にもっともクロールできないハッシュ化されたモバイルナビゲーションリンクの使用率が低く、モバイルページのわずか2.37%でした。2020年は、その数字が0.21%に激減しました。

## 結論

発見されたことと[昨年の結論](../2019/seo#conclusion)と一致しており、ほとんどのサイトがクローラブルでインデックス可能なデスクトップページとモバイルページを持ち、SEO関連の基本的な設定を活用している。

SPAに使用されている主要なJavaScriptフレームワークのリンク発見率が、2019年に比べて飛躍的に向上したことを強調しておきます。モバイルナビゲーションのリンクをハッシュ化したURLでテストしたところ、Reactを使用したサイトからはクロールされないリンクのインスタンスが-53％、Vue.jsを使用したサイトからは-58％、AngularのSPAからは-91％減少しました。

さらに、多くの分析分野において、昨年の調査結果から若干の改善が見られたことも確認しました。

- **`robots.txt`**: 昨年は72.16%のモバイルサイトが有効な`robots.txt`を持っていましたが、今年は74.91%でした。
- **canonicalタグ**: 昨年は、モバイルページの48.34%がcanonicalタグを使用していたのに対し、今年は53.61%でした。
- **`title`タグ**: 今年は、デスクトップページの98.75％が1つを備えているのに対し、モバイルページの98.7％もそれを含んでいることがわかりました。 昨年の章では、モバイルページの97.1％に`title`タグが付いていることがわかりました。
- **`meta`記述**: 今年の調査では、デスクトップページの68.62%、モバイルページの68.22%に`meta`記述があり、モバイルページの64.02%にあった昨年よりも改善されました。
- **構造化データ**: 本来、レビューはホームページとは関係ないはずなのに、データによると`AggregateRating`はモバイルで23.9％、デスクトップでは23.7％上昇しています。
- **HTTPSの使用**: デスクトップページの77.44％、モバイルページの73.22％がHTTPSを採用している。これは、昨年より10.38%増加しています。

しかし、この1年ですべてが改善されたわけではありません。デスクトップページの中央値には61本の内部リンクが含まれているのに対し、モバイルページの中央値には54本の内部リンクが含まれています。これは[昨年](../2019/seo#linking)と比べてそれぞれ12.8%と10%減少しており、サイトがページを介したクローラビリティとリンクエクイティの流れを改善する能力を最大限に発揮できていないことを示唆しています。

また、多くの重要なSEO関連の領域と構成にわたって改善の重要な機会がまだあることに注意することも重要です。 モバイルデバイスの使用が増え、Googleがモバイルファーストインデックスに移行したにもかかわらず、次のようになりました。

- モバイルページの10.84％、デスクトップページの16.18％は、`viewport`タグをまったく含んでおらず、まだモバイルフレンドリーではないことを示唆しています。
- モバイルページとデスクトップページでは、些細な違いが見られました。たとえばモバイルとデスクトップのリンクの違いは、中央値のウェブページでモバイルのリンクが62であるのに対し、デスクトップのリンクが68であることで示されています。
- ウェブサイトの33.13％がデスクトップで _Good_ Core Web Vitalsを獲得しましたが、モバイル版の19.96％のみがCore Web Vitalsの評価に合格しました。これは、デスクトップが引き続きユーザーにとってよりパフォーマンスの高いプラットフォームであることを示しています。

これらの調査結果は、Googleが<a hreflang="en" href="https://webmasters.googleblog.com/2020/07/prepare-for-mobile-first-indexing-with.html">2021年3月にモバイルファーストインデックス</a>への移行を完了する際に、サイトに悪影響を及ぼす可能性があります。

また、レンダリングされたHTMLとレンダリングされていないHTMLにも格差が見られました。たとえば、モバイルページの中央値では、レンダリング時に表示される文字数が生のHTMLに比べて11.5%多く、クライアントサイドのJavaScriptに依存してコンテンツを表示していることがわかります。

検索クローラーは、リンクされたページを見つけるために、`<a href>`タグを探します。これがないと、ページは内部リンクのない孤立したものとみなされます。デスクトップページの5.59％、モバイルレンダリングページの6.04％に内部リンクがありませんでした。

これらの調査結果は、検索エンジンがウェブサイトを効果的にクロール、インデックス、ランキングする能力を継続的に進化させていることを示唆しており、もっとも重要なSEOの設定も現在ではよりよく考慮されています。

しかし、ウェブ上の多くのサイトが、重要な検索上の可視性と成長の機会を逃しているのが現状です。このことは、組織全体でのSEOの伝道とベストプラクティスの採用が依然として必要であることを示しています。
