---
part_number: IV
chapter_number: 15
title: 圧縮
description: HTTP圧縮、アルゴリズム、コンテンツタイプ、ファーストパーティとサードパーティの圧縮および機会をカバーする2019 Web Almanacの圧縮の章。
authors: [paulcalvano]
reviewers: [obto, yoavweiss]
translators: [ksakae]
discuss: 1770
results: https://docs.google.com/spreadsheets/d/1IK9kaScQr_sJUwZnWMiJcmHEYJV292C9DwCfXH6a50o/
queries: 15_Compression
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-03-02T00:00:00.000Z
---

## 序章

HTTP圧縮は、元の表現よりも少ないビットを使用して情報をエンコードできる技術です。 Webコンテンツの配信に使用すると、Webサーバーはクライアントに送信されるデータ量を削減できます。これにより、クライアントの利用可能な帯域幅の効率が向上し、[ページの重さ](./page-weight)が軽減され、[Webパフォーマンス](./performance)が向上します。

圧縮アルゴリズムは、多くの場合、非可逆または可逆に分類されます。

*   非可逆圧縮アルゴリズムが使用される場合、プロセスは不可逆的であり、元のファイルを圧縮解除しても復元できません。これは一般に、一部のデータを失ってもリソースに重大な影響を与えない画像やビデオコンテンツなどのメディアリソースを圧縮するために使用されます。
*   ロスレス圧縮は完全に可逆的なプロセスであり、[HTML](./markup)、[JavaScript](./javascript)、[CSS](./css)などのテキストベースのリソースを圧縮するために一般的に使用されます。

この章では、テキストベースのコンテンツがWeb上でどのように圧縮されるかを検討します。非テキストベースのコンテンツの分析は、[メディア](./media)の章の一部を形成します。


## HTTP圧縮の仕組み

クライアントがHTTPリクエストを作成する場合、多くの場合、デコード可能な圧縮アルゴリズムを示す[`Accept-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding)ヘッダーが含まれます。サーバーは、示されたエンコードのいずれかを選択してサポートし、圧縮されたレスポンスを提供できます。圧縮されたレスポンスには[`Content-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding)ヘッダーが含まれるため、クライアントはどの圧縮が使用されたかを認識できます。また、提供されるリソースの[MIME](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)タイプを示すために、[`Content-Type`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type)ヘッダーがよく使用されます。

以下の例では、クライアントはgzip、brotli、およびdeflate圧縮のサポートを示してます。サーバーは、`text/html`ドキュメントを含むgzip圧縮された応答を返すことにしました。


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

IANAは、`Accept-Encoding`および`Content-Encoding`ヘッダーで使用できる有効な[HTTPコンテンツエンコーディングのリスト](https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding)を保持しています。これらには、gzip、deflate、br（brotli）などが含まれます。これらのアルゴリズムの簡単な説明を以下に示します。

*   [Gzip](https://tools.ietf.org/html/rfc1952)は、[LZ77](https://ja.wikipedia.org/wiki/LZ77)および[ハフマンコーディング](https://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%95%E3%83%9E%E3%83%B3%E7%AC%A6%E5%8F%B7)圧縮技術を使用しており、Web自体よりも古い。もともと1992年にUNIX gzipプログラム用として開発されました。HTTP/ 1.1以降、Web配信の実装が存在し、ほとんどのブラウザーとクライアントがそれをサポートしています。
*   [Deflate](https://tools.ietf.org/html/rfc1951)はgzipと同じアルゴリズムを使用しますが、コンテナは異なります。一部のサーバーおよびブラウザとの互換性の問題のため、Webでの使用は広く採用されていません。
*   [Brotli](https://tools.ietf.org/html/rfc7932)は、[Googleが発明](https://github.com/google/brotli)した新しい圧縮アルゴリズムです。 LZ77アルゴリズムの最新のバリアント、ハフマンコーディング、および2次コンテキストモデリングの組み合わせを使用します。 Brotliを介した圧縮はgzipと比較して計算コストが高くなりますが、アルゴリズムはgzip圧縮よりもファイルを[15〜25％](https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf)削減できます。 Brotliは2015年にWebコンテンツの圧縮に初めて使用され、[すべての最新のWebブラウザーでサポートされています](https://caniuse.com/#feat=brotli)。

HTTPレスポンスの約38％はテキストベースの圧縮で配信されます。これは驚くべき統計のように思えるかもしれませんが、データセット内のすべてのHTTP要求に基づいていることに留意してください。画像などの一部のコンテンツは、これらの圧縮アルゴリズムの恩恵を受けません。次の表は、各コンテンツエンコーディングで処理されるリクエストの割合をまとめたものです。

<figure>
  <table>
    <thead>
      <tr>
        <td scope="col"></td>
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
        <td><p style="text-align: right">62.87%</p></td>
        <td><p style="text-align: right">61.47%</p></td>
        <td><p style="text-align: right">260,245,106</p></td>
        <td><p style="text-align: right">285,158,644</p></td>
      </tr>
      <tr>
      <td>gzip</td>
        <td><p style="text-align: right">29.66%</p></td>
        <td><p style="text-align: right">30.95%</p></td>
        <td><p style="text-align: right">122,789,094</p></td>
        <td><p style="text-align: right">143,549,122</p></td>
      </tr>
      <tr>
        <td>br</td>
        <td><p style="text-align: right">7.43%</p></td>
        <td><p style="text-align: right">7.55%</p></td>
        <td><p style="text-align: right">30,750,681</p></td>
        <td><p style="text-align: right">35,012,368</p></td>
      </tr>
      <tr>
        <td>deflate</td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">68,802</p></td>
        <td><p style="text-align: right">70,679</p></td>
      </tr>
      <tr>
        <td><em>Other / Invalid</em></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">67,527</p></td>
        <td><p style="text-align: right">68,352</p></td>
      </tr>
      <tr>
        <td>identity</td>
        <td><p style="text-align: right">0.000709%</p></td>
        <td><p style="text-align: right">0.000563%</p></td>
        <td><p style="text-align: right">2,935</p></td>
        <td><p style="text-align: right">2,611</p></td>
      </tr>
      <tr>
        <td>x-gzip</td>
        <td><p style="text-align: right">0.000193%</p></td>
        <td><p style="text-align: right">0.000179%</p></td>
        <td><p style="text-align: right">800</p></td>
        <td><p style="text-align: right">829</p></td>
      </tr>
      <tr>
        <td>compress</td>
        <td><p style="text-align: right">0.000008%</p></td>
        <td><p style="text-align: right">0.000007%</p></td>
        <td><p style="text-align: right">33</p></td>
        <td><p style="text-align: right">32</p></td>
      </tr>
      <tr>
        <td>x-compress</td>
        <td><p style="text-align: right">0.000002%</p></td>
        <td><p style="text-align: right">0.000006%</p></td>
        <td><p style="text-align: right">8</p></td>
        <td><p style="text-align: right">29</p></td>
      </tr>
    </tbody>
  </table>
  <figcaption>図1.圧縮アルゴリズムの採用。</figcaption>
</figure>

圧縮されて提供されるリソースの大半は、gzip（80％）またはbrotli（20％）のいずれかを使用しています。他の圧縮アルゴリズムはあまり使用されません。

<figure>
  <a href="/static/images/2019/compression/fig2.png">
    <img src="/static/images/2019/compression/fig2.png" alt="図2.デスクトップページでの圧縮アルゴリズムの採用。" aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">図1のデータテーブルの円グラフ。</div>
  <figcaption id="fig2-caption">図2.デスクトップページでの圧縮アルゴリズムの採用。</figcaption>
</figure>

さらに「none」「UTF-8」「base64」「text」など、無効な`Content-Encoding`を返す67Kのリクエストがあります。これらのリソースは圧縮されていない状態で提供される可能性があります。

HTTP Archiveによって収集された診断から圧縮レベルを判断することはできませんが、コンテンツを圧縮するためのベストプラクティスは次のとおりです。

*   少なくとも、テキストベースのアセットに対してgzip圧縮レベル6を有効にします。これは、計算コストと圧縮率の間の公平なトレードオフを提供し、[多くのWebサーバーのデフォルト](https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/)にもかかわらず、[Nginxは依然として低すぎることが多いレベル1のままです](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level)。
*   brotliおよびprecompressリソースをサポートできる場合は、brotliレベル11に圧縮します。これはgzipよりも計算コストが高くなります。したがって、遅延を避けるためには、事前圧縮が絶対に必要です。
*   brotliをサポートでき、事前圧縮できない場合は、brotliレベル5に圧縮します。このレベルでは、gzipと比較してペイロードが小さくなり、同様の計算オーバーヘッドが発生します。


## どの種類のコンテンツを圧縮していますか？

ほとんどのテキストベースのリソース（HTML、CSS、JavaScriptなど）は、gzipまたはbrotli圧縮の恩恵を受けることができます。ただし、多くの場合、これらの圧縮技術をバイナリリソースで使用する必要はありません。画像、ビデオ、一部のWebフォントなどが既に圧縮されているため。

次のグラフでは、上位25のコンテンツタイプが、リクエストの相対数を表すボックスサイズで表示されています。各ボックスの色は、これらのリソースのうちどれだけ圧縮されて提供されたかを表します。ほとんどのメディアコンテンツはオレンジ色で網掛けされていますが、これはgzipとbrotliにはほとんどまたはまったく利点がないためです。テキストコンテンツのほとんどは、それらが圧縮されていることを示すために青色で網掛けされています。ただし、一部のコンテンツタイプの水色の網掛けは、他のコンテンツタイプほど一貫して圧縮されていないことを示しています。

<figure>
  <a href="/static/images/2019/compression/fig3.png">
    <img src="/static/images/2019/compression/fig3.png" alt="図3.上位25の圧縮コンテンツタイプ。" aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="780" height="482" data-width="780" data-height="482" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">image/jpeg（167,912,373リクエスト-3.23％圧縮）、application/javascript（121,058,259リクエスト-81.29％圧縮）、image/png（113,530,400リクエスト-3.81％圧縮）、text/css（86,634,570リクエスト-81.81％圧縮）を示すツリーマップグラフ、text/html（81,975,252リクエスト-43.44％圧縮）、image/gif（70,838,761リクエスト-3.87％圧縮）、text/javascript（60,645,767リクエスト-89.52％圧縮）、application/x-javascript（38,816,387リクエスト-91.02％圧縮） 、font/woff2（22,622,918リクエスト-3.87％圧縮）、application/json（16,501,326リクエスト-59.02％圧縮）、image/webp（12,911,688リクエスト-1.66％圧縮）、image/svg + xml（9,862,643リクエスト-64.42％圧縮） 、text/plain（6,622,361リクエスト-24.72％圧縮）、application/octet-stream（3,884,287リクエスト-6.01％圧縮）、image/x-icon（3,737,030リクエスト-37.60％圧縮）、application/font-woff2（3,061,857リクエスト- 5.90％圧縮）、application/font-woff（2,117,999リクエスト-23.61％圧縮） d）、image/vnd.microsoft.icon（1,774,995リクエスト-15.55％圧縮）、video/mp4（1,472,880リクエスト-0.03％圧縮）、font/woff（1,255,093リクエスト-24.33％圧縮）、font/ttf（1,062,747リクエスト- 84.27％圧縮）、application/x-font-woff（1,048,398リクエスト-30.77％圧縮）、image/jpg（951,610リクエスト-6.66％圧縮）、application/ocsp-response（883,603リクエスト-0.00％圧縮）。</div>
  <figcaption id="fig3-caption">図3.上位25の圧縮コンテンツタイプ。</figcaption>
</figure>

最も人気のある8つのコンテンツタイプを除外すると、これらのコンテンツタイプの残りの圧縮統計をより明確に確認できます。

<figure>
  <a href="/static/images/2019/compression/fig4.png">
    <img src="/static/images/2019/compression/fig4.png" alt="図4.トップ8を除く圧縮コンテンツタイプ" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="780" height="482" data-width="780" data-height="482" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">font/woff2（22,622,918リクエスト-3.87％圧縮）、application/json（16,501,326リクエスト-59.02％圧縮）、image/webp（12,911,688リクエスト-1.66％圧縮）、image/svg + xml（9,862,643リクエスト-64.42％）を示すツリーマップグラフ圧縮）、text/plain（6,622,361リクエスト-24.72％圧縮）、application/octet-stream（3,884,287リクエスト-6.01％圧縮）、image/x-icon（3,737,030リクエスト-37.60％圧縮）、application/font-woff2（3,061,857リクエスト-5.90％圧縮）、application/font-woff（2,117,999リクエスト-23.61％圧縮）、image/vnd.microsoft.icon（1,774,995リクエスト-15.55％圧縮）、video/mp4（1,472,880リクエスト-0.03％圧縮）、フォント/ woff（1,255,093リクエスト-24.33％圧縮）、font/ttf（1,062,747リクエスト-84.27％圧縮）、application/x-font-woff（1,048,398リクエスト-30.77％圧縮）、image/jpg（951,610リクエスト-6.66％圧縮） 、application/ocsp-response（883,603リクエスト-0.00％圧縮）</div>
  <figcaption id="fig4-caption">図4.トップ8を除く圧縮コンテンツタイプ</figcaption>
</figure>

`application/json`および`image/svg+xml`コンテンツタイプは、65％未満の時間で圧縮されます。

カスタムWebフォントのほとんどは、すでに圧縮形式になっているため、圧縮せずに提供されます。ただし、`font/ttf`は圧縮可能ですが、TTFフォント要求の84％のみが圧縮で提供されているため、ここにはまだ改善の余地があります。

以下のグラフは、各コンテンツタイプに使用される圧縮技術の内訳を示しています。上位3つのコンテンツタイプを見ると、デスクトップとモバイルの両方で、最も頻繁に要求されるコンテンツタイプの圧縮に大きなギャップがあります。 `text/html`の56％と`application/javascript`および`text/css`リソースの18％は圧縮されていません。これにより、パフォーマンスが大幅に向上します。

<figure>
  <a href="/static/images/2019/compression/fig5.png">
    <img src="/static/images/2019/compression/fig5.png" alt="図5.デスクトップのコンテンツタイプによる圧縮。" aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">application/javascriptを示す積み上げ棒グラフは、圧縮タイプ（Gzip/Brotli/None）別で3618万/897万/1047万、text/cssは24.29M/8.31M/7.20M、text/htmlは11.37M/4.89M/20.57Mです。text/javascriptは23.21M/1.72M/3.03M、application/x-javascriptは11.86M/4.97M/1.66M、application/jsonは4.06M/0.50M/3.23M、image/svg+xmlは2.54M/0.46M/1.74M、text/plainは0.71M/0.06M/2.42M、image/x-iconは0.58M/0.10M/1.11Mです。Deflateはいつでもほとんど使用されず、登録されません。チャート上。。</div>
  <figcaption id="fig5-caption">図5.デスクトップのコンテンツタイプによる圧縮。</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/compression/fig6.png">
    <img src="/static/images/2019/compression/fig6.png" alt="図6.モバイルのコンテンツタイプによる圧縮。" aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">application/javascriptを示す積み上げ棒グラフは、圧縮タイプ（Gzip/Brotli/None）で4307万/1017万/1219万、text/cssは28.3M/9.91M/8.56M、text/htmlは13.86M/5.48M/25.79Mです。text/javascriptは27.41M/1.94M/3.33M、application/x-javascriptは12.77M/5.70M/1.82M、application/jsonは4.67M/0.50M/3.53M、image/svg + xmlは2.91M/0.44M/1.77M、text/plainは0.80M/0.06M/1.77M、image/x-iconは0.62M/0.11M/1.22Mです。デフレートはいつでもほとんど使用されず、チャートに登録されません。</div>
  <figcaption id="fig6-caption">図6.モバイルのコンテンツタイプによる圧縮。</figcaption>
</figure>

圧縮率が最も低いコンテンツタイプには、`application/json`、`text/xml`、および`text/plain`が含まれます。これらのリソースは通常、XHRリクエストに使用され、Webアプリケーションが豊かな体験を創造するために使用できるデータを提供します。それらを圧縮すると、ユーザー体験は向上する可能性があります。 `image/svg+xml`や`image/x-icon`などのベクターグラフィックスは、テキストベースと見なされることはあまりありませんが、これらを使用するサイトは圧縮の恩恵を受けるでしょう。

<figure>
    <a href="/static/images/2019/compression/fig7.png">
    <img src="/static/images/2019/compression/fig7.png" alt="図7.コンテンツタイプによる圧縮のデスクトップ割合。" aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">圧縮タイプ（Gzip/Brotli/None）別にapplication/javascriptが65.1％/16.1％/18.8％、text/cssが61.0％/20.9％/18.1％、text/htmlが30.9％/13.3％/55.8％を示す積み上げ棒グラフ、text/javascriptは83.0％/6.1％/10.8％、application/x-javascriptは64.1％/26.9％/9.0％、application/jsonは52.1％/6.4％/41.4％、image/svg+xmlは53.5％/9.8％/36.7％、text/plainは22.2％/2.0％/75.8％、image/x-iconは32.6％/5.3％/62.1％です。デフレートはいつでもほとんど使用されず、チャートに登録されません。</div>
  <figcaption id="fig7-caption">図7.コンテンツタイプによる圧縮のデスクトップ割合。</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/compression/fig8.png">
    <img src="/static/images/2019/compression/fig8.png" alt="図8.コンテンツタイプによる圧縮のモバイル割合。" aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">圧縮タイプ（Gzip/Brotli/None）別にapplication/javascriptが65.8％/15.5％/18.6％である積み上げ棒グラフ、text/cssは60.5％/21.2％/18.3％、text/htmlは30.7％/12.1％/57.1％、text/javascriptは83.9％/5.9％/10.2％、application/x-javascriptは62.9％/28.1％/9.0％、application/jsonは53.6％/8.6％/34.6％、image/svg+xmlは23.4％/1.8％/74.8％、text/plainは23.4％/1.8％/74.8％、image/x-iconは31.8％/5.5％/62.7％です。デフレートはいつでもほとんど使用されず、チャートに登録されません。</div>
  <figcaption id="fig8-caption">図8.コンテンツタイプによる圧縮のモバイル割合。</figcaption>
</figure>

すべてのコンテンツタイプで、gzipは最も一般的な圧縮アルゴリズムです。新しいbrotli圧縮はあまり頻繁に使用されず、最も多く表示されるコンテンツタイプは`application/javascript`、`text/css`、`application/x-javascript`です。これは、CDNが通過するトラフィックにbrotli圧縮を自動的に適用することの原因である可能性があります。

## ファーストパーティとサードパーティの圧縮

[サードパーティ](./third-parties)の章では、サードパーティとパフォーマンスへの影響について学びました。ファーストパーティとサードパーティの圧縮技術を比較すると、サードパーティのコンテンツはファーストパーティのコンテンツよりも圧縮される傾向であることがわかります。

さらに、サードパーティのコンテンツの場合、brotli圧縮の割合が高くなります。これは、GoogleやFacebookなど、通常brotliをサポートする大規模なサードパーティから提供されるリソースの数が原因である可能性と考えられます。

<figure>
  <table>
    <thead>
        <tr>
          <td scope="col"></td>
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
        <td><p style="text-align: right">66.23%</p></td>
        <td><p style="text-align: right">59.28%</p></td>
        <td><p style="text-align: right">64.54%</p></td>
        <td><p style="text-align: right">58.26%</p></td>
      </tr>
      <tr>
        <td>gzip</td>
        <td><p style="text-align: right">29.33%</p></td>
        <td><p style="text-align: right">30.20%</p></td>
        <td><p style="text-align: right">30.87%</p></td>
        <td><p style="text-align: right">31.22%</p></td>
      </tr>
      <tr>
        <td>br</td>
        <td><p style="text-align: right">4.41%</p></td>
        <td><p style="text-align: right">10.49%</p></td>
        <td><p style="text-align: right">4.56%</p></td>
        <td><p style="text-align: right">10.49%</p></td>
      </tr>
      <tr>
        <td>deflate</td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
      </tr>
      <tr>
        <td><em>Other / Invalid</em></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
      </tr>
    </tbody>
  </table>
  <figcaption>図9.デバイスタイプ別のファーストパーティとサードパーティの圧縮。</figcaption>
</figure>

## 圧縮の機会を見分ける

Googleの[Lighthouse](https://developers.google.com/web/tools/lighthouse)ツールを使用すると、ユーザーはWebページに対して一連の監査を実行できます。[テキスト圧縮監査](https://developers.google.com/web/tools/lighthouse/audits/text-compression)は、サイトが追加のテキストベースの圧縮の恩恵を受けることができるかどうかを評価します。これは、リソースを圧縮し、オブジェクトのサイズを少なくとも10％と1,400バイト削減できるかどうかを評価することでこれを行います。スコアに応じて、圧縮可能な特定のリソースのリストとともに、結果に圧縮の推奨事項を表示する場合があります。

<figure>
  <a href="/static/images/2019/compression/ch15_fig8_lighthouse.jpg">
    <img src="/static/images/2019/compression/ch15_fig8_lighthouse.jpg" alt="図10.Lighthouse圧縮の提案" aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="303">
  </a>
  <div id="fig10-description" class="visually-hidden">リソースのリスト（名前は編集済み）およびサイズと節約の可能性を示すLighthouseレポートのスクリーンショット。最初の項目では、91KBから73KBに大幅に節約できる可能性がありますが、6KB以下の他の小さなファイルでは、4KBから1KBの小さい節約になります。</div>
  <figcaption id="fig10-caption">図10.Lighthouse圧縮の提案</figcaption>
</figure>

各モバイルページに対して[HTTP ArchiveはLighthouse監査を実行する](./methodology#lighthouse)ため、すべてのサイトのスコアを集計して、より多くのコンテンツを圧縮する機会があるかどうかを知ることができます。全体として、ウェブサイトの62％がこの監査に合格しており、ウェブサイトのほぼ23％が40を下回っています。これは、120万を超えるウェブサイトが追加のテキストベースの圧縮を有効にすることを意味します。

<figure>
  <a href="/static/images/2019/compression/fig11.png">
    <img src="/static/images/2019/compression/fig11.png" alt="図11. Lighthouseの「テキスト圧縮を有効にする」監査スコア。" aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="760" height="331" data-width="760" data-height="331" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&amp;format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">7.6％の圧縮が10％未満であり、13.2％のサイトが10-39％のスコア、13.7％のサイトが40-79％のスコア、2.9％のサイトが80-99％のスコア、62.5％のスコアを示す積み上げ棒グラフのサイトにはパスがあり、100％を超えるテキストアセットが圧縮されています。</div>
  <figcaption id="fig11-caption">図11. Lighthouseの「テキスト圧縮を有効にする」監査スコア。</figcaption>
</figure>

Lighthouseは、テキストベースの圧縮を有効にすることで、保存できるバイト数も示します。テキスト圧縮の恩恵を受ける可能性のあるサイトのうち、82％がページの重さを最大1MB削減できます！

<figure>
  <a href="/static/images/2019/compression/fig12.png">
    <img src="/static/images/2019/compression/fig12.png" alt="図12.潜在的なバイト削減を監査するLighthouseの「テキスト圧縮を有効にする」" aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="760" height="331" data-width="760" data-height="331" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">82.11％のサイトが1Mb未満、15.88％のサイトが1〜2Mbを、2％のサイトが3MB以上を節約できることを示す積み上げ棒グラフ。</div>
  <figcaption id="fig12-caption">図12.潜在的なバイト削減を監査するLighthouseの「テキスト圧縮を有効にする」</figcaption>
</figure>

## 結論

HTTP圧縮は、Webコンテンツのサイズを削減するために広く使用されている非常に貴重な機能です。 gzipとbrotliの両方の圧縮が使用される主要なアルゴリズムであり、圧縮されたコンテンツの量はコンテンツの種類によって異なります。 Lighthouseなどのツールは、コンテンツを圧縮する機会を発見するのに役立ちます。

多くのサイトがHTTP圧縮をうまく利用していますが、特にWebが構築されている`text/html`形式については、まだ改善の余地があります！　同様に、`font/ttf`、`application/json`、`text/xml`、`text/plain`、`image/svg+xml`、`image/x-icon`のようなあまり理解されていないテキスト形式は、多くのWebサイトで見落とされる余分な構成を取る場合があります。

Webサイトは広くサポートされており、簡単に実装で処理のオーバーヘッドが低いため、少なくともすべてのテキストベースのリソースにgzip圧縮を使用する必要があります。 brotli圧縮を使用するとさらに節約できますが、リソースを事前に圧縮できるかどうかに基づいて圧縮レベルを慎重に選択する必要があります。
