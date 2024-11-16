---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 圧縮
description: HTTP圧縮、アルゴリズム、コンテンツタイプ、ファーストパーティとサードパーティの圧縮および機会をカバーする2019 Web Almanacの圧縮の章。
hero_alt: Hero image of Web Almanac charactes using a ray gun to shrink an HTML page to make it much smaller.
authors: [paulcalvano]
reviewers: [foxdavidj, yoavweiss]
analysts: [paulcalvano]
editors: [tunetheweb]
translators: [ksakae1216]
discuss: 1770
results: https://docs.google.com/spreadsheets/d/1IK9kaScQr_sJUwZnWMiJcmHEYJV292C9DwCfXH6a50o/
paulcalvano_bio: Paul Calvanoは、<a hreflang="en" href="https://www.akamai.com/">アカマイ</a> のウェブパフォーマンス・アーキテクトで、ウェブサイトのパフォーマンス向上を支援しています。また、HTTP Archiveプロジェクトの共同管理者でもあります。<a href="https://x.com/paulcalvano">@paulcalvano</a> でツイートしたり、<a hreflang="en" href="https://paulcalvano.com">http://paulcalvano.com</a> でブログを書いたり、<a hreflang="en" href="https://discuss.httparchive.org">https://discuss.httparchive.org</a> でHTTP Archiveの研究を共有したりしています。
featured_quote: HTTP圧縮とは、元の表現よりも少ないビット数で情報をエンコードすることを可能にする技術です。ウェブコンテンツの配信に使用すると、ウェブサーバーがクライアントに送信するデータ量を減らすことができます。これにより、クライアントの利用可能な帯域幅の効率が向上し、ページの重さが軽減され、ウェブパフォーマンスが向上します。
featured_stat_1: 38%
featured_stat_label_1: テキストベースの圧縮を使用したHTTPレスポンス
featured_stat_2: 80%
featured_stat_label_2: Gzip圧縮の使用
featured_stat_3: 56%
featured_stat_label_3: 圧縮を使用していないHTMLレスポンス
---

## 序章

HTTP圧縮は、元の表現よりも少ないビットを使用して情報をエンコードできる技術です。 Webコンテンツの配信に使用すると、Webサーバーはクライアントに送信されるデータ量を削減できます。これにより、クライアントの利用可能な帯域幅の効率が向上し、[ページの重さ](./page-weight)が軽減され、[Webパフォーマンス](./performance)が向上します。

圧縮アルゴリズムは、多くの場合、非可逆または可逆に分類されます。

* 非可逆圧縮アルゴリズムが使用される場合、プロセスは不可逆的であり、元のファイルを圧縮解除しても復元できません。これは一般に、一部のデータを失ってもリソースに重大な影響を与えない画像やビデオコンテンツなどのメディアリソースを圧縮するために使用されます。
* ロスレス圧縮は完全に可逆的なプロセスであり、[HTML](./markup)、[JavaScript](./javascript)、[CSS](./css)などのテキストベースのリソースを圧縮するために一般的に使用されます。

この章では、テキストベースのコンテンツがWeb上でどのように圧縮されるかを検討します。非テキストベースのコンテンツの分析は、[メディア](./media)の章の一部を形成します。

## HTTP圧縮の仕組み

クライアントがHTTPリクエストを作成する場合、多くの場合、デコード可能な圧縮アルゴリズムを示す[`Accept-Encoding`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Accept-Encoding)ヘッダーが含まれます。サーバーは、示されたエンコードのいずれかを選択してサポートし、圧縮されたレスポンスを提供できます。圧縮されたレスポンスには[`Content-Encoding`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Encoding)ヘッダーが含まれるため、クライアントはどの圧縮が使用されたかを認識できます。また、提供されるリソースの[MIME](https://developer.mozilla.org/docs/Web/HTTP/Basics_of_HTTP/MIME_types)タイプを示すために、[`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type)ヘッダーがよく使用されます。

以下の例では、クライアントはGzip、Brotli、およびDeflate圧縮のサポートを示してます。サーバーは、`text/html`ドキュメントを含むGzip圧縮された応答を返すことにしました。

```
    > GET / HTTP/1.1
    > Host: httparchive.org
    > Accept-Encoding: gzip, deflate, br

    < HTTP/1.1 200
    < Content-type: text/html; charset=utf-8
    < Content-encoding: gzip
```

HTTP Archiveには、530万のWebサイトの測定値が含まれており、各サイトには少なくとも1つの圧縮テキストリソースがホームページにロードされています。さらに、リソースはWebサイトの81％のプライマリドメインで圧縮されました。

## 圧縮アルゴリズム

IANAは、`Accept-Encoding`および`Content-Encoding`ヘッダーで使用できる有効な<a hreflang="en" href="https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding">HTTPコンテンツエンコーディングのリスト</a>を保持しています。これらには、`gzip`、`deflate`、`br`（Brotli）などが含まれます。これらのアルゴリズムの簡単な説明を以下に示します。

* <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a>は、[LZ77](https://ja.wikipedia.org/wiki/LZ77)および[ハフマンコーディング](https://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%95%E3%83%9E%E3%83%B3%E7%AC%A6%E5%8F%B7)圧縮技術を使用しており、Web自体よりも古い。もともと1992年にUNIX `gzip`プログラム用として開発されました。HTTP/ 1.1以降、Web配信の実装が存在し、ほとんどのブラウザーとクライアントがそれをサポートしています。
* <a hreflang="en" href="https://tools.ietf.org/html/rfc1951">Deflate</a>はGzipと同じアルゴリズムを使用しますが、コンテナは異なります。一部のサーバーおよびブラウザとの互換性の問題のため、Webでの使用は広く採用されていません。
* <a hreflang="en" href="https://tools.ietf.org/html/rfc7932">Brotli</a>は、<a hreflang="en" href="https://github.com/google/brotli">Googleが発明</a>した新しい圧縮アルゴリズムです。 LZ77アルゴリズムの最新のバリアント、ハフマンコーディング、および2次コンテキストモデリングの組み合わせを使用します。 Brotliを介した圧縮はGzipと比較して計算コストが高くなりますが、アルゴリズムはGzip圧縮よりもファイルを<a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">15〜25％</a>削減できます。 Brotliは2015年にWebコンテンツの圧縮に初めて使用され、<a hreflang="en" href="https://caniuse.com/#feat=brotli">すべての最新のWebブラウザーでサポートされています</a>。

HTTPレスポンスの約38％はテキストベースの圧縮で配信されます。これは驚くべき統計のように思えるかもしれませんが、データセット内のすべてのHTTP要求に基づいていることに留意してください。画像などの一部のコンテンツは、これらの圧縮アルゴリズムの恩恵を受けません。次の表は、各コンテンツエンコーディングで処理されるリクエストの割合をまとめたものです。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >リクエストの割合</th>
        <th scope="colgroup" colspan="2" >リクエスト</th>
      </tr>
      <tr>
        <th scope="col">コンテンツエンコーディング</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>テキスト圧縮なし</em></td>
        <td class="numeric">62.87%</td>
        <td class="numeric">61.47%</td>
        <td class="numeric">260,245,106</td>
        <td class="numeric">285,158,644</td>
      </tr>
      <tr>
      <td><code>gzip</code></td>
        <td class="numeric">29.66%</td>
        <td class="numeric">30.95%</td>
        <td class="numeric">122,789,094</td>
        <td class="numeric">143,549,122</td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td class="numeric">7.43%</td>
        <td class="numeric">7.55%</td>
        <td class="numeric">30,750,681</td>
        <td class="numeric">35,012,368</td>
      </tr>
      <tr>
        <td><code>deflate</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">68,802</td>
        <td class="numeric">70,679</td>
      </tr>
      <tr>
        <td><em>Other / Invalid</em></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">67,527</td>
        <td class="numeric">68,352</td>
      </tr>
      <tr>
        <td><code>identity</code></td>
        <td class="numeric">0.000709%</td>
        <td class="numeric">0.000563%</td>
        <td class="numeric">2,935</td>
        <td class="numeric">2,611</td>
      </tr>
      <tr>
        <td><code>x-gzip</code></td>
        <td class="numeric">0.000193%</td>
        <td class="numeric">0.000179%</td>
        <td class="numeric">800</td>
        <td class="numeric">829</td>
      </tr>
      <tr>
        <td><code>compress</code></td>
        <td class="numeric">0.000008%</td>
        <td class="numeric">0.000007%</td>
        <td class="numeric">33</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td><code>x-compress</code></td>
        <td class="numeric">0.000002%</td>
        <td class="numeric">0.000006%</td>
        <td class="numeric">8</td>
        <td class="numeric">29</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="圧縮アルゴリズムの採用。") }}</figcaption>
</figure>

圧縮されて提供されるリソースの大半は、Gzip（80％）またはBrotli（20％）のいずれかを使用しています。他の圧縮アルゴリズムはあまり使用されません。

{{ figure_markup(
  image="fig2.png",
  caption="デスクトップページでの圧縮アルゴリズムの採用。",
  description="図15.1のデータテーブルの円グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&format=interactive"
  )
}}

さらに「none」「UTF-8」「base64」「text」など、無効な`Content-Encoding`を返す67Kのリクエストがあります。これらのリソースは圧縮されていない状態で提供される可能性があります。

HTTP Archiveによって収集された診断から圧縮レベルを判断することはできませんが、コンテンツを圧縮するためのベストプラクティスは次のとおりです。

* 少なくとも、テキストベースのアセットに対してGzip圧縮レベル6を有効にします。これは、計算コストと圧縮率の間の公平なトレードオフを提供し、<a hreflang="en" href="https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/">多くのWebサーバーのデフォルト</a>にもかかわらず、[Nginxは依然として低すぎることが多いレベル1のままです](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level)。
* Brotliおよびprecompressリソースをサポートできる場合は、Brotliレベル11に圧縮します。これはGzipよりも計算コストが高くなります。したがって、遅延を避けるためには、事前圧縮が絶対に必要です。
* Brotliをサポートでき、事前圧縮できない場合は、Brotliレベル5に圧縮します。このレベルでは、Gzipと比較してペイロードが小さくなり、同様の計算オーバーヘッドが発生します。

## どの種類のコンテンツを圧縮していますか？

ほとんどのテキストベースのリソース（HTML、CSS、JavaScriptなど）は、GzipまたはBrotli圧縮の恩恵を受けることができます。ただし、多くの場合、これらの圧縮技術をバイナリリソースで使用する必要はありません。画像、ビデオ、一部のWebフォントなどが既に圧縮されているため。

次のグラフでは、上位25のコンテンツタイプが、リクエストの相対数を表すボックスサイズで表示されています。各ボックスの色は、これらのリソースのうちどれだけ圧縮されて提供されたかを表します。ほとんどのメディアコンテンツはオレンジ色で網掛けされていますが、これはGzipとBrotliにはほとんどまたはまったく利点がないためです。テキストコンテンツのほとんどは、それらが圧縮されていることを示すために青色で網掛けされています。ただし、一部のコンテンツタイプの水色の網掛けは、他のコンテンツタイプほど一貫して圧縮されていないことを示しています。

{{ figure_markup(
  image="fig3.png",
  caption="上位25の圧縮コンテンツタイプ。",
  description="image/jpeg（167,912,373リクエスト-3.23％圧縮）、application/javascript（121,058,259リクエスト-81.29％圧縮）、image/png（113,530,400リクエスト-3.81％圧縮）、text/css（86,634,570リクエスト-81.81％圧縮）を示すツリーマップグラフ、text/html（81,975,252リクエスト-43.44％圧縮）、image/gif（70,838,761リクエスト-3.87％圧縮）、text/javascript（60,645,767リクエスト-89.52％圧縮）、application/x-javascript（38,816,387リクエスト-91.02％圧縮） 、font/woff2（22,622,918リクエスト-3.87％圧縮）、application/json（16,501,326リクエスト-59.02％圧縮）、image/webp（12,911,688リクエスト-1.66％圧縮）、image/svg + xml（9,862,643リクエスト-64.42％圧縮） 、text/plain（6,622,361リクエスト-24.72％圧縮）、application/octet-stream（3,884,287リクエスト-6.01％圧縮）、image/x-icon（3,737,030リクエスト-37.60％圧縮）、application/font-woff2（3,061,857リクエスト- 5.90％圧縮）、application/font-woff（2,117,999リクエスト-23.61％圧縮） d）、image/vnd.microsoft.icon（1,774,995リクエスト-15.55％圧縮）、video/mp4（1,472,880リクエスト-0.03％圧縮）、font/woff（1,255,093リクエスト-24.33％圧縮）、font/ttf（1,062,747リクエスト- 84.27％圧縮）、application/x-font-woff（1,048,398リクエスト-30.77％圧縮）、image/jpg（951,610リクエスト-6.66％圧縮）、application/ocsp-response（883,603リクエスト-0.00％圧縮）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

最も人気のある8つのコンテンツタイプを除外すると、これらのコンテンツタイプの残りの圧縮統計をより明確に確認できます。

{{ figure_markup(
  image="fig4.png",
  caption="トップ8を除く圧縮コンテンツタイプ",
  description="font/woff2（22,622,918リクエスト-3.87％圧縮）、application/json（16,501,326リクエスト-59.02％圧縮）、image/webp（12,911,688リクエスト-1.66％圧縮）、image/svg + xml（9,862,643リクエスト-64.42％）を示すツリーマップグラフ圧縮）、text/plain（6,622,361リクエスト-24.72％圧縮）、application/octet-stream（3,884,287リクエスト-6.01％圧縮）、image/x-icon（3,737,030リクエスト-37.60％圧縮）、application/font-woff2（3,061,857リクエスト-5.90％圧縮）、application/font-woff（2,117,999リクエスト-23.61％圧縮）、image/vnd.microsoft.icon（1,774,995リクエスト-15.55％圧縮）、video/mp4（1,472,880リクエスト-0.03％圧縮）、フォント/ woff（1,255,093リクエスト-24.33％圧縮）、font/ttf（1,062,747リクエスト-84.27％圧縮）、application/x-font-woff（1,048,398リクエスト-30.77％圧縮）、image/jpg（951,610リクエスト-6.66％圧縮） 、application/ocsp-response（883,603リクエスト-0.00％圧縮）",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

`application/json`および`image/svg+xml`コンテンツタイプは、65％未満の時間で圧縮されます。

カスタムWebフォントのほとんどは、すでに圧縮形式になっているため、圧縮せずに提供されます。ただし、`font/ttf`は圧縮可能ですが、TTFフォント要求の84％のみが圧縮で提供されているため、ここにはまだ改善の余地があります。

以下のグラフは、各コンテンツタイプに使用される圧縮技術の内訳を示しています。上位3つのコンテンツタイプを見ると、デスクトップとモバイルの両方で、最も頻繁に要求されるコンテンツタイプの圧縮に大きなギャップがあります。 `text/html`の56％と`application/javascript`および`text/css`リソースの18％は圧縮されていません。これにより、パフォーマンスが大幅に向上します。

{{ figure_markup(
  image="fig5.png",
  caption="デスクトップのコンテンツタイプによる圧縮。",
  description="application/javascriptを示す積み上げ棒グラフは、圧縮タイプ（Gzip/Brotli/None）別で3618万/897万/1047万、text/cssは24.29M/8.31M/7.20M、text/htmlは11.37M/4.89M/20.57Mです。text/javascriptは23.21M/1.72M/3.03M、application/x-javascriptは11.86M/4.97M/1.66M、application/jsonは4.06M/0.50M/3.23M、image/svg+xmlは2.54M/0.46M/1.74M、text/plainは0.71M/0.06M/2.42M、image/x-iconは0.58M/0.10M/1.11Mです。Deflateはいつでもほとんど使用されず、登録されません。チャート上。。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig6.png",
  caption="モバイルのコンテンツタイプによる圧縮。",
  description="application/javascriptを示す積み上げ棒グラフは、圧縮タイプ（Gzip/Brotli/None）で4307万/1017万/1219万、text/cssは28.3M/9.91M/8.56M、text/htmlは13.86M/5.48M/25.79Mです。text/javascriptは27.41M/1.94M/3.33M、application/x-javascriptは12.77M/5.70M/1.82M、application/jsonは4.67M/0.50M/3.53M、image/svg + xmlは2.91M/0.44M/1.77M、text/plainは0.80M/0.06M/1.77M、image/x-iconは0.62M/0.11M/1.22Mです。デフレートはいつでもほとんど使用されず、チャートに登録されません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

圧縮率が最も低いコンテンツタイプには、`application/json`、`text/xml`、および`text/plain`が含まれます。これらのリソースは通常、XHRリクエストに使用され、Webアプリケーションが豊かな体験を創造するために使用できるデータを提供します。それらを圧縮すると、ユーザー体験は向上する可能性があります。 `image/svg+xml`や`image/x-icon`などのベクターグラフィックスは、テキストベースと見なされることはあまりありませんが、これらを使用するサイトは圧縮の恩恵を受けるでしょう。

{{ figure_markup(
  image="fig7.png",
  caption="コンテンツタイプによる圧縮のデスクトップ割合。",
  description="圧縮タイプ（Gzip/Brotli/None）別にapplication/javascriptが65.1％/16.1％/18.8％、text/cssが61.0％/20.9％/18.1％、text/htmlが30.9％/13.3％/55.8％を示す積み上げ棒グラフ、text/javascriptは83.0％/6.1％/10.8％、application/x-javascriptは64.1％/26.9％/9.0％、application/jsonは52.1％/6.4％/41.4％、image/svg+xmlは53.5％/9.8％/36.7％、text/plainは22.2％/2.0％/75.8％、image/x-iconは32.6％/5.3％/62.1％です。デフレートはいつでもほとんど使用されず、チャートに登録されません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="コンテンツタイプによる圧縮のモバイル割合。",
  description="圧縮タイプ（Gzip/Brotli/None）別にapplication/javascriptが65.8％/15.5％/18.6％である積み上げ棒グラフ、text/cssは60.5％/21.2％/18.3％、text/htmlは30.7％/12.1％/57.1％、text/javascriptは83.9％/5.9％/10.2％、application/x-javascriptは62.9％/28.1％/9.0％、application/jsonは53.6％/8.6％/34.6％、image/svg+xmlは23.4％/1.8％/74.8％、text/plainは23.4％/1.8％/74.8％、image/x-iconは31.8％/5.5％/62.7％です。デフレートはいつでもほとんど使用されず、チャートに登録されません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

すべてのコンテンツタイプで、Gzipは最も一般的な圧縮アルゴリズムです。新しいBrotli圧縮はあまり頻繁に使用されず、最も多く表示されるコンテンツタイプは`application/javascript`、`text/css`、`application/x-javascript`です。これは、CDNが通過するトラフィックにBrotli圧縮を自動的に適用することの原因である可能性があります。

## ファーストパーティとサードパーティの圧縮

[サードパーティ](./third-parties)の章では、サードパーティとパフォーマンスへの影響について学びました。ファーストパーティとサードパーティの圧縮技術を比較すると、サードパーティのコンテンツはファーストパーティのコンテンツよりも圧縮される傾向であることがわかります。

さらに、サードパーティのコンテンツの場合、Brotli圧縮の割合が高くなります。これは、GoogleやFacebookなど、通常Brotliをサポートする大規模なサードパーティから提供されるリソースの数が原因である可能性と考えられます。

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
        <td class="numeric">66.23%</td>
        <td class="numeric">59.28%</td>
        <td class="numeric">64.54%</td>
        <td class="numeric">58.26%</td>
      </tr>
      <tr>
        <td><code>gzip</code></td>
        <td class="numeric">29.33%</td>
        <td class="numeric">30.20%</td>
        <td class="numeric">30.87%</td>
        <td class="numeric">31.22%</td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td class="numeric">4.41%</td>
        <td class="numeric">10.49%</td>
        <td class="numeric">4.56%</td>
        <td class="numeric">10.49%</td>
      </tr>
      <tr>
        <td><code>deflate</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><em>Other / Invalid</em></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デバイスタイプ別のファーストパーティとサードパーティの圧縮。") }}</figcaption>
</figure>

## 圧縮の機会を見分ける

Googleの<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>ツールを使用すると、ユーザーはWebページに対して一連の監査を実行できます。<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/text-compression">テキスト圧縮監査</a>は、サイトが追加のテキストベースの圧縮の恩恵を受けることができるかどうかを評価します。これは、リソースを圧縮し、オブジェクトのサイズを少なくとも10％と1,400バイト削減できるかどうかを評価することでこれを行います。スコアに応じて、圧縮可能な特定のリソースのリストとともに、結果に圧縮の推奨事項を表示する場合があります。

{{ figure_markup(
  image="ch15_fig8_lighthouse.jpg",
  caption="Lighthouse圧縮の提案",
  description="リソースのリスト（名前は編集済み）およびサイズと節約の可能性を示すLighthouseレポートのスクリーンショット。最初の項目では、91KBから73KBに大幅に節約できる可能性がありますが、6KB以下の他の小さなファイルでは、4KBから1KBの小さい節約になります。",
  width=600,
  height=303
  )
}}

各モバイルページに対して[HTTP ArchiveはLighthouse監査を実行する](./methodology#lighthouse)ため、すべてのサイトのスコアを集計して、より多くのコンテンツを圧縮する機会があるかどうかを知ることができます。全体として、ウェブサイトの62％がこの監査に合格しており、ウェブサイトのほぼ23％が40を下回っています。これは、120万を超えるウェブサイトが追加のテキストベースの圧縮を有効にすることを意味します。

{{ figure_markup(
  image="fig11.png",
  caption="Lighthouseの「テキスト圧縮を有効にする」監査スコア。",
  description="7.6％の圧縮が10％未満であり、13.2％のサイトが10-39％のスコア、13.7％のサイトが40-79％のスコア、2.9％のサイトが80-99％のスコア、62.5％のスコアを示す積み上げ棒グラフのサイトにはパスがあり、100％を超えるテキストアセットが圧縮されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

Lighthouseは、テキストベースの圧縮を有効にすることで、保存できるバイト数も示します。テキスト圧縮の恩恵を受ける可能性のあるサイトのうち、82％がページの重さを最大1MB削減できます！

{{ figure_markup(
  image="fig12.png",
  caption="潜在的なバイト削減を監査するLighthouseの「テキスト圧縮を有効にする」",
  description="82.11％のサイトが1Mb未満、15.88％のサイトが1〜2Mbを、2％のサイトが3MB以上を節約できることを示す積み上げ棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

## 結論

HTTP圧縮は、Webコンテンツのサイズを削減するために広く使用されている非常に貴重な機能です。 GzipとBrotliの両方の圧縮が使用される主要なアルゴリズムであり、圧縮されたコンテンツの量はコンテンツの種類によって異なります。 Lighthouseなどのツールは、コンテンツを圧縮する機会を発見するのに役立ちます。

多くのサイトがHTTP圧縮をうまく利用していますが、特にWebが構築されている`text/html`形式については、まだ改善の余地があります！　同様に、`font/ttf`、`application/json`、`text/xml`、`text/plain`、`image/svg+xml`、`image/x-icon`のようなあまり理解されていないテキスト形式は、多くのWebサイトで見落とされる余分な構成を取る場合があります。

Webサイトは広くサポートされており、簡単に実装で処理のオーバーヘッドが低いため、少なくともすべてのテキストベースのリソースにGzip圧縮を使用する必要があります。 Brotli圧縮を使用するとさらに節約できますが、リソースを事前に圧縮できるかどうかに基づいて圧縮レベルを慎重に選択する必要があります。
