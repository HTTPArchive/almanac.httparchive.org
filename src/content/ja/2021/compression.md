---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 圧縮
description: 2021 Web Almanacの圧縮の章では、HTTP圧縮、アルゴリズム、圧縮レベル、コンテンツタイプ、ファーストパーティとサードパーティの圧縮と機会について説明しています。
hero_alt: Hero image of Web Almanac charactes using a ray gun to shrink an HTML page to make it much smaller.
authors: [lvandeve, mo271, jyrkialakuijala]
reviewers: [fischbacher, eustas, iulia-m-comsa]
analysts: [paulcalvano]
editors: [shantsis]
translators: [ksakae1216]
jyrkialakuijala_bio: Jyrki Alakuijalaは、オープンソースソフトウェアコミュニティの活発なメンバーであり、データ圧縮の研究者でもあります。最近の研究テーマは、Zopfli、Butteraugli、Guetzli、Gipfeli、WebP lossless、Brotli、JPEG XL圧縮形式とアルゴリズム、および2つのハッシュアルゴリズム、CityHashとHighwayHashです。Google入社以前は、脳神経外科や放射線治療の治療計画のためのソフトウェアを開発していました。
mo271_bio: Moritz Firschingは、Googleスイスのソフトウェアエンジニアで、プログレッシブ画像フォーマットとフォント圧縮を研究しています。それ以前は、数学者として多面体の研究をしていた。
lvandeve_bio: Lode Vandevenneは、ソフトウェアエンジニアとしてGoogleスイスに勤務し、Zopfli、Brotli、JPEG XL画像フォーマットなどの圧縮プロジェクトに貢献しています。
results: https://docs.google.com/spreadsheets/d/1-FQlNvtBw9ai8cBF7wEich_AcXnrNkNGW7dMYvHFl2w/
featured_quote: HTTP圧縮を使用すると、ウェブサイトの読み込みが速くなるため、より良いユーザー体験が保証されます。
featured_stat_1: 33%
featured_stat_label_1: Brotliを使用した圧縮応答
featured_stat_2: 66%
featured_stat_label_2: Gzipを使用する圧縮されたレスポンス
featured_stat_3: 72%
featured_stat_label_3: Lighthouseの監査に合格し、テキスト圧縮で最高得点を得たウェブサイト
---

## 序章

ユーザーの時間は貴重なので、ウェブページの読み込みに長時間待たされることはないはずです。HTTPプロトコルはレスポンスを圧縮することができ、コンテンツの転送に必要な時間を短縮できます。圧縮は、多くの場合、ユーザー体験の大幅な向上につながります。[ページの重さ](./page-weight)を減らし、[Webパフォーマンス](./performance)を向上させ、検索順位を上げることができるのです。そのため、[検索エンジン最適化](./seo)の重要な一部となっています。

この章では、HTTPレスポンスに適用されるロスレス圧縮について説明します。画像、音声、動画などの [media](../2020/media) フォーマットで使用される非可逆圧縮と可逆圧縮は、ページの読み込み速度を上げるために（それ以上に）同様に重要です。しかし、これらは通常、ファイル形式自体の一部であるため、この章の範囲ではありません。

## HTTP圧縮を使用するコンテンツタイプ

HTTP圧縮は、[HTML](./markup)、[CSS](./css)、[JavaScript](./javascript)、JSON、SVGなどのテキストベースのコンテンツや、`woff`, `ttf`, `ico` ファイルに対して推奨されています。画像のようなすでに圧縮されているメディアファイルは、前述のようにその表現にすでに内部圧縮が含まれているため、HTTP圧縮の恩恵を受けることはありません。

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="コンテンツの種類に応じた圧縮方法",
  description="圧縮アルゴリズムの使用率をコンテンツタイプ別に分類した棒グラフです。積み上げられた棒グラフは、Brotli、Gzip、および圧縮なしの使用率を分割しています。`text/plain` と `text/html` は、50%以下の頻度で圧縮される唯一のコンテンツタイプです。`application/json` は約68%、 `image/svg+xml`では約64%圧縮されています。`text/css` と `application/javascript` はそれぞれ85%以上、`application/x-javascript` と `text/javascript` は90%以上圧縮されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1292728213&format=interactive",
  sheets_gid="234112121",
  sql_file="compression_by_content_type.sql"
  )
}}

他のタイプのコンテンツと比較すると、`text/plain` と `text/html` はもっとも圧縮率が低く、12%と14%しか圧縮を使用していない。これは、動的に生成されたコンテンツも圧縮することが良い影響を与えるにもかかわらず、`text/html`がJavaScriptやCSSなどの静的コンテンツよりも動的に生成されることが多いためかもしれません。JavaScriptコンテンツの圧縮に関する詳しい分析は、[JavaScript](./javascript)の章にあります。

## HTTP圧縮のためのサーバー設定

HTTPのコンテンツエンコーディングについては、HTTP規格で [Accept-Encoding](https://developer.mozilla.org/docs/Web/HTTP/Headers/Accept-Encoding)リクエストヘッダーが定義されており、HTTPクライアントは、どのコンテンツエンコーディングを扱えるかをサーバーに通知できます。サーバーの応答には、応答本文のデータを変換するためにどのエンコーディングが選ばれたかを指定する [Content-Encoding](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Encoding) ヘッダーフィールドを含めることができます。

実質的にすべてのテキスト圧縮は、2つのHTTPコンテンツエンコーディングのうちの1つによって行われます。<a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a>と<a hreflang="en" href="https://github.com/google/brotli">Brotli</a>です。BrotliとGzipの両方は、事実上すべてのブラウザでサポートされています。サーバー側では、nginxやApacheなど[もっとも普及しているサーバー](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression)でBrotliやGzipを使用するように設定できます。この設定は、コンテンツが生成されるタイミングによって異なります。

- 静的コンテンツ：このコンテンツはあらかじめ圧縮しておくことができます。ウェブサーバーは、ファイル名の拡張子などに基づいて、URLを適切な圧縮ファイルにマップするように設定できます。たとえば、CSSやJavaScriptは静的コンテンツであることが多いので、あらかじめ圧縮しておくと、Webサーバーがリクエストごとに圧縮する手間を省くことができます。
- 動的に生成されるコンテンツ：これは、ウェブサーバー（またはプラグイン）自身がリクエストごとにその場で圧縮する必要があります。たとえば、HTMLやJSONは、場合によっては動的コンテンツになり得ます。

BrotliまたはGzipでテキストを圧縮する場合、異なる圧縮レベルを選択することが可能です。圧縮レベルを高くすると、圧縮ファイルは小さくなりますが、圧縮に時間がかかります。解凍中、CPU使用率は重く圧縮されたファイルほど高くならない傾向があります。むしろ、高い圧縮レベルで圧縮されたファイルは、デコードが若干速くなります。

使用するWebサーバーソフトによっては、圧縮を有効にする必要があり、あらかじめ圧縮されたコンテンツと動的に圧縮されたコンテンツとで設定が、分かれる場合があります。<a hreflang="en" href="https://httpd.apache.org/">Apache</a>では、Brotliは <a hreflang="en" href="https://httpd.apache.org/docs/2.4/mod/mod_brotli.html">mod_brotli</a> で、Gzipは <a hreflang="en" href="https://httpd.apache.org/docs/2.4/mod/mod_deflate.html">mod_deflate</a> で有効にすることができるようになっています。nginxでは、<a hreflang="en" href="https://github.com/google/ngx_brotli">Brotliを有効にする</a>方法、<a hreflang="en" href="https://nginx.org/en/docs/http/ngx_http_gzip_module.html">Gzipを有効にする</a> 方法も公開されています。

## HTTP圧縮の動向

下のグラフは、過去3年間のHTTP Archiveメトリクスによるロスレス圧縮の使用率シェアの推移を示したものです。2019年からBrotliの利用率が2倍に、Gzipの利用率が若干減少しており、全体的にデスクトップ、モバイルでHTTP圧縮の利用率が伸びていることがわかります。

{{ figure_markup(
  image="compression-format-trend-desktop.png",
  caption="デスクトップでの圧縮方法の傾向。",
  description="2019年、2020年、2021年のデスクトップにおけるBrotli、Gzip、テキスト圧縮なしの使用率を示す積み上げ棒グラフ。2019年については、Brotliが7.4％、Gzipが29.5％、テキスト圧縮なしが63.1％です。2020年については、Brotli 9.1％、Gzip 30.8％、テキスト圧縮なし60.1％と表示されます。2021年については、Brotli 14.0%、Gzip 28.2%、テキスト圧縮なし58.8%と表示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1962012452&format=interactive",
  sheets_gid="703407907",
  sql_file="compression_format_trend.sql"
  )
}}

{{ figure_markup(
  image="compression-format-trend-mobile.png",
  caption="モバイル向け圧縮方式の動向。",
  description="2019年、2020年、2021年のモバイルでのBrotli、Gzip、テキスト圧縮なしの使用率を示す積み上げ棒グラフ。2019年は、Brotliが7.5%、Gzip30.8%、テキスト圧縮なし61.6%です。2020年については、Brotli 9.1％、Gzip 31.6％、テキスト圧縮なし59.3％を示しています。2021年については、Brotli 14.3%、Gzip 28.6%、テキスト圧縮なし57.1%と表示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=646268399&format=interactive",
  sheets_gid="703407907",
  sql_file="compression_format_trend.sql"
  )
}}

圧縮されて提供されているリソースのうち、大多数はGzip (66%) またはBrotli (33%) を使用しています。その他の圧縮アルゴリズムが使用されることはほとんどありません。この割合は、デスクトップとモバイルでほぼ同じです。

{{ figure_markup(
  image="compression-algorithms-for-http-responses.png",
  caption="HTTPレスポンスの圧縮アルゴリズム。",
  description="HTTPレスポンスにおけるさまざまな圧縮アルゴリズムの使用率を示す棒グラフです。圧縮を使用するHTTPレスポンスの66.7%はGzipアルゴリズム、33.2%はBrotli、0.1%はその他の方式を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=676651936&format=interactive",
  sheets_gid="1289551244",
  sql_file="compression_formats.sql"
  )
}}

## ファーストパーティとサードパーティの圧縮

[サードパーティー](./third-parties)は、ウェブサイトのユーザー体験に影響を与えます。歴史的に、サードパーティーと比較してファーストパーティーが使用する圧縮の量は大きく異なっていました。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">デスクトップ</th>
        <th scope="colgroup" colspan="2">モバイル</th>
      </tr>
      <tr>
        <th scope="col">コンテンツエンコーディング</th>
        <th scope="col">ファーストパーティ</th>
        <th scope="col">サードパーティ</th>
        <th scope="col">ファーストパーティ</th>
        <th scope="col">サードパーティ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>テキスト圧縮なし</em></td>
        <td class="numeric">58.0%</td>
        <td class="numeric">57.5%</td>
        <td class="numeric">56.1%</td>
        <td class="numeric">58.3%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">28.1%</td>
        <td class="numeric">28.4%</td>
        <td class="numeric">29.1%</td>
        <td class="numeric">28.1%</td>
      </tr>
      <tr>
        <td>Brotli</td>
        <td class="numeric">13.9%</td>
        <td class="numeric">14.1%</td>
        <td class="numeric">14.9%</td>
        <td class="numeric">13.7%</td>
      </tr>
      <tr>
        <td>Deflate</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td><em>その他/無効</em></td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デバイスタイプ別のファーストパーティ製とサードパーティ製の圧縮率。", sheets_gid="2074687558", sql_file="first_vs_third_party.sql") }}</figcaption>
</figure>

この結果から、[*2020年との比較*](../2020/compression#ファーストパーティとサードパーティの圧縮)では、ファーストパーティコンテンツがサードパーティコンテンツに圧縮の利用で追いつき、同等の方法で圧縮を使っていることが分かります。圧縮、とくにBrotliの利用が両カテゴリーで伸びている。Brotliの圧縮率は、ファーストパーティコンテンツにおいて、1年前と比較して2倍になっています。

## 圧縮レベル

圧縮レベルとは、エンコーダーに与えられるパラメーターで、入力の冗長性を見つけるための努力の量を調整し、結果として高い圧縮密度を達成するために使われます。圧縮レベルが高くなると圧縮速度が遅くなりますが、伸長速度にはあまり影響がなく、むしろ若干速くなります。圧縮前のコンテンツの場合、圧縮に要する時間は事前に設定できるため、ユーザー体験に影響を与えることはない。動的コンテンツの場合、CPUがリソースを圧縮するのに必要な時間は、圧縮されたデータをネットワーク経由で送信する速度向上とトレードオフできる。

Brotliエンコーディングは0から11の圧縮レベルを許容し、Gzipは1から9のレベルを使用します。Zopfliのようなツールを使えば、Gzipでもより高いレベルを達成することができる。これは下のグラフで `opt` として示されている。

HTTPアーカイブの `summary_response_bodies` データテーブルを使用して、現在ウェブで使用されている圧縮レベルを分析しました。これは異なる圧縮レベル設定でレスポンスを再圧縮し、もっとも近い実際のサイズを取ることで、Brotliを使用した約14,000の圧縮レスポンスと、Gzipを使用した約11,000の圧縮レスポンスを基に推定しています。

各レベルのインスタンス数をプロットすると、もっともよく使われるBrotli圧縮レベルについて、圧縮レベル5付近と最大圧縮レベルの2つのピークが、あることがわかる。4以下の圧縮レベルの使用はまれです。

{{ figure_markup(
  image="compression-levels-brotli.png",
  caption="Brotliの圧縮レベル。",
  description="Brotliを使用した回答の圧縮レベルの使用状況を、圧縮レベル0～11で示した積み上げ棒グラフです。レベル5とレベル11にピークが、あることがわかる。各レベルは、コンテンツの種類によっても分類されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=1630047521&format=interactive",
  sheets_gid="150560131"
  )
}}

Gzip圧縮は、圧縮レベル6を中心に、レベル9まで適用されます。レベル1にピークがあるのは、人気のあるWebサーバー<a hreflang="en" href="https://nginx.org/">nginx</a>のデフォルト圧縮レベルであるためと思われます。比較のため、Gzipレベル9は何千もの冗長性マッチングを試み、レベル6はそれを約100に制限し、レベル1は冗長性マッチングを4つの候補のみに制限し、圧縮率が15%悪いことを意味します。

{{ figure_markup(
  image="compression-levels-gzip.png",
  caption="Gzipの圧縮レベル。",
  description="Gzipを使用したレスポンスの圧縮レベル1から9、およびZopfliなどのオプティマイザーに対応する `opt` の使用状況を示す棒グラフの積み重ね。レベル1とレベル6にピークがあり、レベル9まで延びていることがわかります。また、各レベルはコンテンツの種類によって分けられている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=586666706&format=interactive",
  sheets_gid="150560131"
  )
}}

図は、各圧縮レベルをコンテンツタイプ別に分けたものです。ほぼすべてのケースで、JavaScriptがもっとも一般的なコンテンツタイプです。Brotliでは、もっとも高い圧縮レベルではJavaScriptの割合が低い圧縮レベルよりも高く、低い圧縮レベルではJSONが多くなっている。Gzipでは、JavaScriptのコンテンツタイプの分布はどのレベルでもほぼ同じです。

## サイトの圧縮率を分析する方法

WebサイトのどのコンテンツがHTTP圧縮を使用しているかを確認するには、[Firefox Developer Tools](https://developer.mozilla.org/docs/Tools) または <a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a> を使用することが可能です。開発者ツールで、「ネットワーク」タブを開き、サイトを再読み込みしてください。HTML、CSS、JavaScript、フォント、画像などのレスポンスのリストが表示されるはずです。どれが圧縮されているかを確認するには、その応答ヘッダーのコンテンツエンコーディングをチェックします。列を有効にすることで、すべてのレスポンスについて一度に簡単に確認できます。これを行うには、列のタイトルを右クリックし、メニューの［レスポンスヘッダー］に移動して［コンテンツエンコード］を有効にします。

Gzipで圧縮された応答は "gzip "と表示され、Brotliで圧縮された応答は "br "と表示されます。この値が空白の場合、HTTP圧縮は行われません。画像の場合、これらのリソースはすでにそれ自体で圧縮されているため、これは正常です。

{{ figure_markup(
  image="content-encoding.jpg",
  caption='Chrome DevToolsでレスポンスのcontent-encodingをチェックする。',
  description="Chrome DevToolsを使用してコンテンツエンコーディングが使用されているかどうかを確認する方法を示す画像です。",
  width=575,
  height=828
  )
}}

サイトの圧縮を分析できる別のツールとして、Googleの<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>というツールがあります。<a hreflang="ja" href="https://web.dev/i18n/ja/uses-text-compression/">「テキストの圧縮を有効にする」監査</a>を含む一連の監査を実行します。この監査では、リソースの圧縮を試み、少なくとも10%および1,400バイトが削減されたかどうかをチェックします。スコアに応じて、圧縮の推奨事項を結果に表示し、圧縮することでWebサイトに利益をもたらすリソースのリストを表示できます。

HTTP Archiveでは、すべてのモバイルページに対して[Lighthouse監査](./methodology#lighthouse)を実施しており、このデータから72%のWebサイトがこの監査に合格していることが確認されました。これは、[昨年の](../2020/compression#fig-9) 74%より2%少なく、これは昨年と比較して全体的にテキスト圧縮の使用率が高いにもかかわらず、わずかに低下しています。

{{ figure_markup(
  image="text-compression-lighthouse-scores.png",
  caption="テキスト圧縮Lighthouseのスコア。",
  description='Lighthouseの監査で「テキスト圧縮を有効にする」と判定されたページのスコアを棒グラフにしたもの。10%未満のサイトが16%、10～39%のサイトが3.3%、40～79%のサイトが5.8%、80～99%のサイトが2.8%、そして100%以上のテキスト資産が、圧縮されたパスが72.1%のサイトであることを示しています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtfyTM9VEweN_Hli3IuxxqU1CRap4V5Q28baEs7aEBResoPRgk9Dwp1m_vdS9lzNlfO8J4hZN7GPT7/pubchart?oid=261012442&format=interactive",
  sheets_gid="1612612722",
  sql_file="lighthouse_compression_scores.sql"
  )
}}

## 圧縮率を向上させる方法

コンテンツの圧縮方法を考える前に、そもそも送信するコンテンツを減らすことが、賢明である場合が多い。これを実現する1つの方法は、<a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>、 <a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a>、<a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a> などのいわゆる「ミニマイズ」を使うことです。

送信するコンテンツの最小限の形式が決まったら、次は圧縮が有効であることを確認します。前のセクションで強調したように、有効になっていることを確認し、必要に応じてWebサーバーを設定します。

Gzip圧縮（DeflateまたはZlibとしても知られている）だけを使用している場合、Brotliのサポートを追加することは有益です。Gzipと比較して、Brotliは<a hreflang="en" href="https://quixdb.github.io/squash-benchmark/">同じ速度でより小さなファイルに圧縮し</a>、同じ速度で解凍する。

よく調整された圧縮レベルを選択できます。どの圧縮レベルが正しいかは、複数の要因に依存するかもしれませんが、より重く圧縮されたテキストファイルは、デコード時に多くのCPUを必要としないことに留意してください。したがって、圧縮前の資産の場合、圧縮レベルをできるだけ高く設定しても、ユーザーの観点からは欠点がありません。動的圧縮の場合は、圧縮にかかる時間と転送時間が短くなる可能性の両方を考慮して、より重く圧縮されたファイルをユーザーが、より長く待つ必要がないようにする必要があります。この違いは、両者の圧縮レベルの推奨値を見れば明らかです。

圧縮前のリソースにGzip圧縮を使用する場合、より小さなGzip互換ファイルを生成する[Zopfli](https://ja.wikipedia.org/wiki/Zopfli)の使用を検討してください。Zopfliは反復的なアプローチで非常にコンパクトな構文解析を見つけ、3-8%の高密度出力をもたらしますが、計算にはかなり時間がかかります。一方、Gzipはより単純ですが、あまり効果的ではないアプローチを採用しています。<a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">複数のコンプレッサーの比較</a> と、Gzipの異なる圧縮レベルを考慮した  <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">GzipとZopfliの比較</a> を参照してください。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Brotli</th>
        <th scope="col">Gzip</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>圧縮前</td>
        <td>11</td>
        <td>9 か Zopfli</td>
      </tr>
      <tr>
        <td>動的に圧縮</td>
        <td>5</td>
        <td>6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="使用する推奨圧縮レベル。") }}</figcaption>
</figure>

ウェブサーバソフトウェアのデフォルト設定を改善することは、ウェブパフォーマンスに時間を投資できない人々に大きな改善をもたらすでしょう。とくにGzip品質レベル1は異常値のようで、HTTPアーカイブ `summary_response_bodies` データで15%圧縮されるデフォルト6が有益でしょう。また、Brotliをサポートしているユーザーエージェントでは、Gzipの代わりにBrotliをデフォルトで有効にすることも大きなメリットになります。

## 結論

28,000件のHTTPレスポンスに使用された圧縮レベルを分析した結果、Gzip圧縮されたコンテンツの約0.5%にZopfliなどのより高度な圧縮器が使用されており、同様の「最適解析」アプローチはBrotli圧縮されたコンテンツの17%に使用されていることが明らかになりました。このことは、より効率的な方法が利用できれば、たとえ速度が遅くても、相当数のユーザーが静的コンテンツにこれらの方法を導入することを示しています。

HTTP圧縮の利用が増え続けており、とくにBrotliは[前年の章](../2020/compression)と比較して大きく増加しています。いずれかのテキスト圧縮を使用したHTTPレスポンスの数は2%増加しましたが、Brotliは4%以上増加しました。増えたとはいえ、サーバーの圧縮設定をいじることで、より多くのHTTP圧縮を利用できる機会があることは確かです。ご自身のウェブサイトのレスポンスとサーバーの設定をよく見てみると、その恩恵にあずかれるでしょう。圧縮を使用していない場合は圧縮を有効にすることを検討し、圧縮を使用している場合は、その場で生成されるHTMLなどの動的コンテンツと静的コンテンツの両方で、圧縮レベルを高くするように圧縮方法を調整することを検討できます。一般的なHTTPサーバーのデフォルトの圧縮設定を変更すると、ユーザーに大きな影響を与える可能性があります。



