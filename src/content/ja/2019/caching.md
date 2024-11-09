---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: キャッシング
description: 2019 Web Almanacのキャッシュの章は、キャッシュコントロール、有効期限、TTL、有効性、変化、Cookieの設定、アプリケーションキャッシュ、Service Worker、および機会について説明します。
authors: [paulcalvano]
reviewers: [foxdavidj, bkardell]
analysts: [paulcalvano, foxdavidj]
editors: [tunetheweb]
translators: [ksakae1216]
discuss: 1771
results: https://docs.google.com/spreadsheets/d/1mnq03DqrRBwxfDV05uEFETK0_hPbYOynWxZkV3tFgNk/
paulcalvano_bio: Paul Calvanoは、<a hreflang="en" href="https://www.akamai.com/">アカマイ</a> のウェブパフォーマンス・アーキテクトで、ウェブサイトのパフォーマンス向上を支援しています。また、HTTP Archiveプロジェクトの共同管理者でもあります。<a href="https://x.com/paulcalvano">@paulcalvano</a> でツイートしたり、<a hreflang="en" href="https://paulcalvano.com">http://paulcalvano.com</a> でブログを書いたり、<a hreflang="en" href="https://discuss.httparchive.org">https://discuss.httparchive.org</a> でHTTP Archiveの研究を共有したりしています。
featured_quote: キャッシングは、以前にダウンロードしたコンテンツの再利用を可能にする技術です。高価なネットワークリクエストを回避することでパフォーマンスに大きなメリットがあり、また、ウェブサイトのオリジンインフラストラクチャへのトラフィックを減らすことでアプリケーションの拡張性を高めることができます。古いことわざに「最速のリクエストは、作る必要のないものである」というものがありますが、キャッシングはリクエストをしなくても済むようにするための重要な方法の一つです。
featured_stat_1: 27%
featured_stat_label_1: キャッシングヘッダを使用していないレスポンス
featured_stat_2: 39%
featured_stat_label_2: `Vary`ヘッダーを使用したレスポンス
featured_stat_3: 82%
featured_stat_label_3: キャッシングを最適化することで1Mbを節約できるサイト
---

## 導入

キャッシングは、以前にダウンロードしたコンテンツの再利用を可能にする手法です。コストのかかるネットワークリクエストを回避することにより、[パフォーマンス](./performance)が大幅に向上します。また、Webサイトのオリジンインフラストラクチャへのトラフィックを削減することで、アプリケーションの拡張にも役立ちます。「最速のリクエストはあなたがする必要のないものです」という古い格言があり、キャッシュはリクエストを行わなくて済むようにするための重要な方法の1つです。

Webコンテンツのキャッシュには、3つの基本原則があります。可能な限りキャッシュする、できる限りキャッシュする、エンドユーザーのできるだけ近くでキャッシュする。

**可能な限りキャッシュする。** キャッシュできる量を検討する場合、レスポンスが静的か動的かを理解することが重要です。静的なレスポンスとして提供される要求は、リソースとそれを要求するユーザーとの間に1対多の関係があるため、通常はキャッシュ可能です。動的に生成されたコンテンツはより微妙である可能性があり、慎重に検討する必要があります。

**できるだけ長くキャッシュする。**リソースをキャッシュする時間の長さは、キャッシュされるコンテンツの機密性に大きく依存します。バージョン管理されたJavaScriptリソースは非常に長い時間キャッシュされる可能性がありますが、バージョン管理されていないリソースはユーザーが最新バージョンを取得できるように、より短いキャッシュ期間を必要とする場合があります。

**エンドユーザーのできるだけ近くでキャッシュする。**エンドユーザーの近くでコンテンツをキャッシュすると、待ち時間がなくなり、ダウンロード時間が短縮されます。たとえば、リソースがエンドユーザーのブラウザにキャッシュされている場合、リクエストはネットワークに送信されず、ダウンロード時間はマシンのI/Oと同じくらい高速です。初めての訪問者、またはキャッシュにエントリがない訪問者の場合、通常、キャッシュされたリソースが返される場所はCDNになります。ほとんどの場合、オリジンサーバーと比較して、ローカルキャッシュかCDNからリソースをフェッチする方が高速です。

通常、Webアーキテクチャには<a hreflang="en" href="https://blog.yoav.ws/tale-of-four-caches/">複数のキャッシュ層</a>が含まれます。たとえば、HTTPリクエストは次の場所にキャッシュされる可能性があります。

* エンドユーザーのブラウザ
* ユーザーのブラウザーのService Workerキャッシュ
* 共有ゲートウェイ
* エンドユーザーに近い側でキャッシュする機能を提供するCDN
* バックエンドの仕事長を削減するための、アプリケーションの前のキャッシングプロキシ
* アプリケーション層とデータベース層

この章では、Webブラウザー内でリソースがキャッシュされる方法について見ていきましょう。

## HTTPキャッシングの概要

HTTPクライアントがリソースをキャッシュするには、2つの情報を理解する必要があります。

* 「これをキャッシュできる期間はどれくらいですか？」
* 「コンテンツがまだ新しいことを検証するにはどうすればよいですか？」

Webブラウザーがクライアントにレスポンスを送信するとき、通常リソースにキャッシュ可能か、キャッシュする期間、リソースの古さを示すヘッダーが含まれます。 RFC 7234は、これをセクション<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.2">4.2（新しさ）</a>および<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.3">4.3（検証）</a>でより詳細にカバーしています。

通常、有効期間を伝えるために使用されるHTTPレスポンスヘッダーは次のとおりです。

* `Cache-Control` キャッシュの生存期間（つまり、有効期間）を設定できます。
* `Expires` 有効期限の日付または時刻を提供します（つまり、期限切れになるとき）。

`Cache-Control` 両方が存在する場合に優先されます。これらについては、[以下で詳しく説明します](#cache-controlとexpires)。

キャッシュ内に保存された応答を検証するためのHTTPレスポンスヘッダー、つまりサーバー側で比較するため、条件付き要求を提供するHTTPレスポンスヘッダーは次のとおりです。

* `Last-Modified` オブジェクトが最後に変更された日時を示します。
* エンティティタグ (`ETag`) コンテンツの一意の識別子を提供します。

`ETag` 両方が存在する場合に優先されます。これらについては、以下で詳しく説明します。

以下の例には、HTTP Archiveのmain.jsファイルからのリクエスト/レスポンスヘッダーの抜粋が含まれています。これらのヘッダーは、リソースを43,200秒（12時間）キャッシュでき、最後は2か月以上前に変更されたことを示します（`Last-Modified`ヘッダーと`Date`ヘッダーの違い）。

```
> GET /static/js/main.js HTTP/1.1
> Host: httparchive.org
> User-agent: curl/7.54.0
> Accept: */*

< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

<a hreflang="en" href="https://redbot.org/">RedBot.org</a>というツールにURLを入力すると、レスポンスのヘッダーを元としたキャッシュ方法の詳細な説明が表示できます。たとえば、<a hreflang="en" href="https://redbot.org/?uri=https%3A%2F%2Fhttparchive.org%2Fstatic%2Fjs%2Fmain.js">上記のURLのテスト</a>は次のような内容を出力します。

{{ figure_markup(
  image="ch16_fig1_redbot_example.jpg",
  caption="ロボットからの <code>Cache-Control</code> 情報",
  description="リソースがいつ変更されたか、キャッシュがそれを保存できるかどうか、リソースが新鮮であると見なされる期間、および警告に関する詳細情報を示すRedbotの応答例。",
  width=600,
  height=138
  )
}}

レスポンスにキャッシュヘッダーが存在しない場合、<a hreflang="en" href="https://paulcalvano.com/index.php/2018/03/14/http-heuristic-caching-missing-cache-control-and-expires-headers-explained/">クライアントはレスポンスをヒューリスティクスにキャッシュできます</a>。ほとんどのクライアントは、RFCの推奨ヒューリスティックバリエーションを実装します。これは、`Last-Modified`から経過した時間の10％です。ただし、レスポンスを無期限にキャッシュする可能性もあります。そのため、特定のキャッシュルールを設定して、キャッシュ可能性を確実に制御することが重要です。

レスポンスの72％は`Cache-Control`ヘッダーで提供され、レスポンスの56％は`Expires`ヘッダーで提供されます。ただし、レスポンスの27％はどちらのヘッダーも使用していないため、ヒューリスティックキャッシュの対象となります。これは、デスクトップとモバイルサイトの両方で一貫しています。

{{ figure_markup(
  image="fig2.png",
  caption="HTTP <code>Cache-Control</code> および <code>Expires</code> ヘッダーの存在",
  description="リクエストの72％がCache-Controlヘッダーを使用し、56％がExpiresを使用し、27％がどちらも使用しないことを示す、モバイルとデスクトップの棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1611664016&format=interactive"
  )
}}

## キャッシュするコンテンツの種類は何ですか？

キャッシュ可能なリソースは、クライアントによって一定期間保存され、後続のリクエストで再利用できます。すべてのHTTPリクエスト全体で、レスポンスの80％はキャッシュ可能と見なされます。つまり、キャッシュがそれらを格納することを許可されています。

* 要求の6％のTime To Time（TTL）は0秒で、キャッシュされたエントリはすぐに無効になります。
* 27％は`Cache-Control`ヘッダーがないため、ヒューリスティックにキャッシュされます。
* 47％は0秒以上キャッシュされます。

残りのレスポンスは、ブラウザーのキャッシュに保存できません。

{{ figure_markup(
  image="fig3.png",
  caption="キャッシュ可能なレスポンスの分布。",
  description="デスクトップレスポンスの20％がキャッシュ不可、47％が0秒以上のキャッシュ、27％がヒューリスティックにキャッシュ、6％が0秒のTTLを示す積み上げ棒グラフ。モバイルの統計は非常に似ています（19％、47％ 、27％および7％）",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1868559586&format=interactive"
  )
}}

次の表は、デスクトップリクエストのキャッシュTTL値をタイプ別に詳細に示しています。ほとんどのコンテンツタイプはキャッシュされますが、CSSリソースは高いTTLで一貫してキャッシュされるようです。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="5" >デスクトップキャッシュTTLパーセンタイル（時間）</th>
      </tr>
      <tr>
        <td></td>
        <th scope="col">10</th>
        <th scope="col">25</th>
        <th scope="col">50</th>
        <th scope="col">75</th>
        <th scope="col">90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">Audio</th>
        <td class="numeric">12</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">CSS</th>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Font</th>
        <td class="numeric">< 1</td>
        <td class="numeric">3</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">87,600</td>
      </tr>
      <tr>
        <th scope="row">HTML</th>
        <td class="numeric">< 1</td>
        <td class="numeric">168</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,766</td>
      </tr>
      <tr>
        <th scope="row">Image</th>
        <td class="numeric">< 1</td>
        <td class="numeric">1</td>
        <td class="numeric">28</td>
        <td class="numeric">48</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Other</th>
        <td class="numeric">< 1</td>
        <td class="numeric">2</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Script</th>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">1</td>
        <td class="numeric">6</td>
        <td class="numeric">720</td>
      </tr>
      <tr>
        <th scope="row">Text</th>
        <td class="numeric">21</td>
        <td class="numeric">336</td>
        <td class="numeric">7,902</td>
        <td class="numeric">8,357</td>
        <td class="numeric">8,740</td>
      </tr>
      <tr>
        <th scope="row">Video</th>
        <td class="numeric">< 1</td>
        <td class="numeric">4</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">336</td>
      </tr>
      <tr>
        <th scope="row">XML</th>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別のデスクトップキャッシュTTLパーセンタイル。") }}</figcaption>
</figure>

TTLの中央値のほとんどは高いですが、低いパーセンタイルは、見逃されたキャッシングの機会の一部を強調しています。たとえば画像のTTLの中央値は28時間ですが、25パーセンタイルは1〜2時間であり、10パーセンタイルはキャッシュ可能な画像コンテンツの10％が1時間未満キャッシュされることを示します。

以下の図16.5でコンテンツタイプごとのキャッシュ可能性を詳細に調べると、すべてのHTMLレスポンスの約半分がキャッシュ不可と見なされていることがわかります。さらに、画像とスクリプトの16％はキャッシュ不可です。

{{ figure_markup(
  image="fig5.png",
  caption="デスクトップのコンテンツタイプごとのキャッシュ可能性の分布。",
  description="キャッシュ不可、0秒を超えたキャッシュ、デスクトップのタイプごとに0秒だけキャッシュの分割を示す積み上げ棒グラフ。小さいがかなりの割合でキャッシュ不可能でHTMLでは最大50％になり、ほとんどはキャッシュが大きく0で、小さいキャッシュは0 TTLです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1493610744&format=interactive"
  )
}}

モバイルの同じデータを以下に示します。ご覧のとおり、コンテンツタイプのキャッシュ可能性はデスクトップとモバイルで一貫しています。

{{ figure_markup(
  image="fig6.png",
  caption="モバイルのコンテンツタイプ別のキャッシュ可能性の分布。",
  description="キャッシュ不可、0秒を超えたキャッシュ、デスクトップのタイプごとに0秒だけキャッシュの分割を示す積み上げ棒グラフ。小さいがかなりの割合でキャッシュ不可能でHTMLでは最大50％になり、ほとんどはキャッシュが大きく0で、小さいキャッシュは0 TTLです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1713903788&format=interactive"
  )
}}

## `Cache-Control`と`Expires`

HTTP/1.0では、`Expires`ヘッダーは、レスポンスが古くなったと見なされる日時を示すために使用されました。その値は、次のような日付のタイムスタンプです。

`Expires: Thu, 01 Dec 1994 16:00:00 GMT`

HTTP/1.1は`Cache-Control`ヘッダーを導入し、最新のクライアントのほとんどは両方のヘッダーをサポートしています。このヘッダーは、キャッシングディレクティブを介して、はるかに高い拡張性を提供します。例えば。

* `no-store` リソースをキャッシュしないことを示すために使用できます。
* `max-age` 鮮度の寿命を示すために使用できます。
* `must-revalidate` キャッシュされたエントリは、使用する前に条件付きリクエストで検証する必要があることをクライアントに伝えます。
* `private` レスポンスはブラウザによってのみキャッシュされ、複数のクライアントにサービスを提供する仲介者によってキャッシュされるべきではないことを示します。

HTTPレスポンスの53％は、`max-age`ディレクティブを持つ`Cache-Control`ヘッダーが含まれ、54％はExpiresヘッダーが含まれます。ただし、これらのレスポンスの41％のみが両方のヘッダーを使用します。つまり、レスポンスの13％が古い`Expires`ヘッダーのみに基づいてキャッシュされます。

{{ figure_markup(
  image="fig7.png",
  caption="<code>Cache-Control</code> と <code>Expires</code> ヘッダーの使用法。",
  description="レスポンスの53％を示す棒グラフには、「Cache-Control：max-age」、54％-55％が「Expires」、41％-42％が両方を使用し、34％がどちらも使用していません。数字は、デスクトップとモバイルの両方について示されていますが、有効期限の使用率が高いモバイルとほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1909701542&format=interactive"
  )
}}

## `Cache-Control`ディレクティブ

HTTP/1.1<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-5.2.1">仕様</a>には、`Cache-Control`レスポンスヘッダーで使用できる複数のディレクティブが含まれており、以下で詳しく説明します。1つのレスポンスで複数を使用できることに注意してください。

<figure>
  <table>
    <tr>
      <th>ディレクティブ</th>
      <th>説明</th>
    </tr>
    <tr>
      <td>max-age</td>
      <td>リソースをキャッシュできる秒数を示します。</td>
    </tr>
    <tr>
      <td>public</td>
      <td>任意のキャッシュにレスポンスを保存できます。</td>
    </tr>
    <tr>
      <td>no-cache</td>
      <td>キャッシュされたエントリは、使用する前に再検証する必要があります。</td>
    </tr>
    <tr>
      <td>must-revalidate</td>
      <td>古いキャッシュエントリは、使用する前に再検証する必要があります。</td>
    </tr>
    <tr>
      <td>no-store</td>
      <td>レスポンスがキャッシュ不可能なことを示します。</td>
    </tr>
    <tr>
      <td>private</td>
      <td>レスポンスは特定のユーザー向けであり、共有キャッシュに保存しない。</td>
    </tr>
    <tr>
      <td>no-transform</td>
      <td>このリソースに対して変換を行わないでください。</td>
    </tr>
    <tr>
      <td>proxy-revalidate</td>
      <td>must-revalidateと同じですが、共有キャッシュに適用されます。</td>
    </tr>
    <tr>
      <td>s-maxage</td>
      <td>max ageと同じですが、共有キャッシュにのみ適用されます。</td>
    </tr>
    <tr>
      <td>immutable</td>
      <td>キャッシュされたエントリは決して変更されず、再検証は不要であることを示します。</td>
    </tr>
    <tr>
      <td>stale-while-revalidate</td>
      <td>クライアントがバックグラウンドで新しいレスポンスを非同期にチェックしながら、古いレスポンスを受け入れようとしていることを示します。</td>
    </tr>
    <tr>
      <td>stale-if-error</td>
      <td>新しいレスポンスのチェックが失敗した場合に、クライアントが古いレスポンスを受け入れる意思があることを示します。</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="<code>Cache-Control</code> ディレクティブ。") }}</figcaption>
</figure>

たとえば、`cache-control：public、max-age = 43200`は、キャッシュされたエントリを43,200秒間保存し、共有キャッシュに保存できることを示します。

{{ figure_markup(
  image="fig9.png",
  caption="モバイルでの <code>Cache-Control</code> ディレクティブの使用。",
  description="15のcache-controlディレクティブとその使用量の棒グラフ。74.8％のmax-age、37.8％のpublic、27.8％のno-cache、18％のno-store、14.3％のprivate、3.4％のimmutable、3.3％のno-transform、2.4％のstale-while-revalidate、2.2％のpre-check、2.2％のpost-check、1.9％のs-maxage、1.6％のproxy-revalidate、0.3％set-cookieおよび0.2％のstale-if-error。統計は、デスクトップとモバイルでほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1054108345&format=interactive",
  width=600,
  height=662,
  data_width=600,
  data_height=662
  )
}}

上記の図16.9は、モバイルWebサイトで使用されている上位15の`Cache-Control`ディレクティブを示しています。デスクトップとモバイルの結果は非常に似ています。これらのキャッシュディレクティブの人気について、興味深い観察結果がいくつかあります。

* `max-age`は`Cache-Control`ヘッダーのほぼ75％で使用され、`no-store`は18％で使用されます。
* `private`が指定されない限り、キャッシュされたエントリは`public`であると想定されるため、`public`が必要になることはほとんどありません。回答の約38％に`public`が含まれています。
* `immutable`ディレクティブは比較的新しく、<a hreflang="en" href="https://code.facebook.com/posts/557147474482256/this-browser-tweak-saved-60-of-requests-to-facebook">2017年に導入</a>され、[FirefoxおよびSafariでサポート](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cache-Control#Browser_compatibility)されています。その使用率は3.4％に拡大し、<a hreflang="en" href="https://discuss.httparchive.org/t/cache-control-immutable-a-year-later/1195">Facebook、Googleのサードパーティのレスポンス</a>で広く使用されています。

このリストに表示される別の興味深いディレクティブセットは、`pre-check`と`post-check`です。これらは、`Cache-Control`レスポンスヘッダーの2.2％（約780万件のレスポンス）で使用されます。このヘッダーのペアは、<a hreflang="en" href="https://blogs.msdn.microsoft.com/ieinternals/2009/07/20/internet-explorers-cache-control-extensions/">バックグラウンドで検証を提供するためにInternet Explorer 5で導入された</a>ものですが、Webサイトによって正しく実装されることはほとんどありませんでした。これらのヘッダーを使用したレスポンスの99.2％は、`pre-check=0`と`post-check=0`の組み合わせを使用していました。これらのディレクティブの両方が0に設定されている場合、両方のディレクティブは無視されます。したがって、これらのディレクティブは正しく使用されなかったようです！

ロングテールでは、レスポンスの0.28％で1,500を超える間違ったディレクティブが使用されています。これらはクライアントによって無視され、「nocache」「s-max-age」「smax-age」「maxage」などのスペルミスが含まれます。「max-stale」「proxy-public」「surrogate-control」など存在しないディレクティブも多数あります。

## `Cache-Control`: `no-store`, `no-cache` and `max-age=0`

レスポンスがキャッシュ可能でない場合、`Cache-Control` `no-store`ディレクティブを使用する必要があります。このディレクティブを使用しない場合、レスポンスはキャッシュ可能です。

レスポンスをキャッシュ不可に設定しようとすると、いくつかの一般的なエラーが発生します。

* `Cache-Control: no-cache`の設定は、リソースがキャッシュできないように聞こえるかもしれません。ただし、`no-cache`ディレクティブでは、使用する前にキャッシュされたエントリを再検証する必要があり、キャッシュ不可と同じではありません。
* `Cache-Control: max-age = 0`を設定すると、TTLが0秒に設定されますが、これはキャッシュ不可と同じではありません。 max-ageを0に設定すると、リソースはブラウザーのキャッシュに保存され、すぐに無効になります。これにより、ブラウザは条件付きリクエストを実行してリソースの新しさを検証する必要があります。

機能的には、`no-cache`と`max-age=0`は似ています。どちらもキャッシュされたリソースの再検証を必要とするためです。 `no-cache`ディレクティブは、0より大きい`max-age`ディレクティブと一緒に使用することもできます。

300万を超えるレスポンスには、`no-store`、`no-cache`、`max-age=0`の組み合わせが含まれます。これらのディレクティブのうち、`no-store`が優先され、他のディレクティブは単に冗長です。

レスポンスの18％には`no-store`が含まれ、レスポンスの16.6％には`no-store`と`no-cache`の両方が含まれます。`no-store`が優先されるため、リソースは最終的にキャッシュ不可になります。

`max-age=0`ディレクティブは、`no-store`が存在しないレスポンスの1.1％（400万を超えるレスポンス）に存在します。これらのリソースはブラウザにキャッシュされますが、すぐに期限切れになるため、再検証が必要になります。

## キャッシュTTLとリソースの経過時間はどのように比較されますか？

これまで、Webサーバーがキャッシュ可能なものをクライアントに通知する方法と、キャッシュされる期間について説明してきました。キャッシュルールを設計するときは、提供しているコンテンツの古さを理解することも重要です。

キャッシュTTLを選択するときは、「これらのアセットをどのくらいの頻度で更新しますか？」と自問してください。そして「彼らのコンテンツの感度は何ですか？」。たとえば、ヒーローのイメージがたまに更新される場合、非常に長いTTLでキャッシュします。 JavaScriptリソースが頻繁に変更されることが予想される場合は、バージョン管理して長いTTLでキャッシュするか、短いTTLでキャッシュします。

以下のグラフは、コンテンツタイプごとのリソースの相対的な年を示しています。ここで、<a hreflang="en" href="https://discuss.httparchive.org/t/analyzing-resource-age-by-content-type/1659">より詳細な分析</a>を読むことができます。 HTMLは最も短い年齢のコンテンツタイプである傾向があり、伝統的にキャッシュ可能なリソース（[スクリプト](./javascript)、[CSS](./css)、および[フォント](./fonts)）の非常に大きな割合が1年以上古いです！

{{ figure_markup(
  image="ch16_fig8_resource_age.jpg",
  caption="コンテンツタイプ別のリソース年分布。",
  description="コンテンツの年を示すスタック棒グラフ。0〜52週に分割され、1年以上と2年以上で、nullと負の数字も表示されます。統計は、ファーストパーティとサードパーティに分かれています。値0は、特にファーストパーティのHTML、テキスト、およびxml、およびすべてのアセットタイプのサードパーティリクエストの最大50％に使用されます。中間年を使用し、その後1年と2年の間かなりの使用量を使用するミックスがあります。",
  width=600,
  height=325
  )
}}

リソースのキャッシュ可能性をその経過時間と比較することにより、TTLが適切であるか短すぎるかを判断できます。たとえば、以下のレスポンスによって提供されるリソースは、2019年8月25日に最後の変更がされました。つまり、配信時に49日経過していました。 `Cache-Control`ヘッダーは、43,200秒（12時間）キャッシュできることを示しています。より長いTTLが適切かどうかを調査するのに十分古いものです。

```
< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

全体的に、Webで提供されるリソースの59％のキャッシュTTLは、コンテンツの年齢に比べて短すぎます。さらに、TTLと経過時間のデルタの中央値は25日です。

これをファーストパーティとサードパーティで分けると、ファーストパーティのリソースの70％がより長いTTLの恩恵を受けることもわかります。これは、キャッシュ可能なものに特に注意を払い、キャッシュが正しく構成されていることを確認する必要があることを明確に強調しています。

<figure>
  <table>
    <tr>
      <th>クライアント</th>
      <th>ファーストパーティ</th>
      <th>サードパーティ</th>
      <th>全体</th>
    </tr>
    <tr>
      <td>デスクトップ</td>
      <td class="numeric">70.7%</td>
      <td class="numeric">47.9%</td>
      <td class="numeric">59.2%</td>
    </tr>
    <tr>
      <td>モバイル</td>
      <td class="numeric">71.4%</td>
      <td class="numeric">46.8%</td>
      <td class="numeric">59.6%</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="TTLが短いリクエストの割合。") }}</figcaption>
</figure>

## 鮮度の検証

キャッシュ内に格納されたレスポンスの検証に使用されるHTTPレスポンスヘッダーは、`Last-Modified`および`ETag`です。 `Last-Modified`ヘッダーは、その名前が示すとおりに機能し、オブジェクトが最後に変更された時刻を提供します。 `ETag`ヘッダーは、コンテンツの一意の識別子を提供します。

たとえば、以下のレスポンスは2019年8月25日に変更され、`「1566748830.0-3052-3932359948」`の`ETag`値があります。

```
< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

クライアントは、`If-Modified-Since`という名前のリクエストヘッダーの`Last-Modified`値を使用して、キャッシュされたエントリを検証する条件付きリクエストを送信できます。同様に、`If-None-Match`リクエストヘッダーを使用してリソースを検証することもできます。これは、クライアントがキャッシュ内のリソースに対して持っている`ETag`値に対して検証します。

以下の例では、キャッシュエントリはまだ有効であり、`HTTP 304`がコンテンツなしで返されました。これにより、リソース自体のダウンロードが保存されます。キャッシュエントリが最新ではない場合、サーバーは`200`で更新されたリソースを応答し、再度ダウンロードする必要があります。

```
> GET /static/js/main.js HTTP/1.1
> Host: www.httparchive.org
> User-Agent: curl/7.54.0
> Accept: */*
> If-Modified-Since: Sun, 25 Aug 2019 16:00:30 GMT

< HTTP/1.1 304
< Date: Thu, 17 Oct 2019 02:31:08 GMT
< Server: gunicorn/19.7.1
< Cache-Control: public, max-age=43200
< Expires: Thu, 17 Oct 2019 14:31:08 GMT
< ETag: "1566748830.0-3052-3932359948"
< Accept-Ranges: bytes
```

全体としてレスポンスの65％は`Last-Modified`ヘッダーで、42％は`ETag`で提供され、38％は両方を使用します。ただし、レスポンスの30％には`Last-Modified`ヘッダー、`ETag`ヘッダーは含まれていません。

{{ figure_markup(
  image="fig12.png",
  caption="デスクトップWebサイトの <code>Last-Modified</code> および <code>ETag</code> ヘッダーを介した鮮度の検証の採用。",
  description="デスクトップリクエストの64.4％が最後に変更され、42.8％がETagを持ち、37.9％が両方を持ち、30.7％がどちらも持たないことを示す棒グラフ。モバイルの統計は、最終変更が65.3％、ETagが42.8％、両方が38.0％、どちらも29.9％というほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=20297100&format=interactive"
  )
}}

## 日付文字列の有効性

タイムスタンプの伝達に使用されるHTTPヘッダーがいくつかあり、これらの形式は非常に重要です。 `Date`レスポンスヘッダーは、リソースがいつクライアントに提供されたかを示します。 `Last-Modified`レスポンスヘッダーは、サーバーでリソースが最後に変更された日時を示します。また、`Expires`ヘッダーは、（`Cache-Control`ヘッダーの存在しない場合）リソースがキャッシュ可能な期間を示すために使用されます。

これら3つのHTTPヘッダーはすべて、日付形式の文字列を使用してタイムスタンプを表します。

例えば。

```
> GET /static/js/main.js HTTP/1.1
> Host: httparchive.org
> User-Agent: curl/7.54.0
> Accept: */*

< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

ほとんどのクライアントは、無効な日付文字列を無視します。これにより、提供されているレスポンスを無視します。これは、誤った`Last-Modified`ヘッダーがLast-Modifiedタイムスタンプなしでキャッシュされるため、条件付きリクエストを実行できなくなるため、キャッシュ可能性に影響を与える可能性があります。

通常、`Date` HTTPレスポンスヘッダーは、クライアントにレスポンスを提供するWebサーバーまたはCDNによって生成されます。ヘッダーは通常、サーバーによって自動的に生成されるため、エラーが発生しにくい傾向はあります。これは、無効な`Date`ヘッダーの割合が非常に低いことを反映しています。 `Last-Modified`ヘッダーは非常に類似しており、無効なヘッダーは0.67％のみでした。しかし、驚いたのは、3.64％の`Expires`ヘッダーが無効な日付形式を使用していたことです！

{{ figure_markup(
  image="fig13.png",
  caption="レスポンスヘッダーの無効な日付形式。",
  description="デスクトップレスポンスの0.10％に無効な日付があり、0.67％に無効なLast-Modifiedがあり、3.64％に無効なExpiresがあることを示す棒グラフ。モバイルの統計は非常によく似ており、レスポンスの0.06％に無効な日付があり、0.68％に無効なLast-Modifiedがあり、3.50％に無効な有効期限があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1500819114&format=interactive"
  )
}}

`Expires`ヘッダーの無効な使用の例は次のとおりです。

* 有効な日付形式ですが、GMT以外のタイムゾーンを使用しています
* 0や-1などの数値
* `Cache-Control`ヘッダーで有効な値

無効な`Expires`ヘッダーの最大のソースは、人気のあるサードパーティから提供されるアセットからのものです。たとえば、`Expires：Tue、27 Apr 1971 19:44:06 EST`など、日付/時刻はESTタイムゾーンを使用します。

## ヘッダーを変更

キャッシングで最も重要な手順の1つは、要求されているリソースがキャッシュされているかどうかを判断することです。これは単純に見えるかもしれませんが、多くの場合、URLだけではこれを判断するには不十分です。たとえば同じURLのリクエストは、使用する[圧縮](./compression)（Gzip、Brotliなど）が異なる場合や、モバイルの訪問者に合わせて変更および調整できます。

この問題を解決するために、クライアントはキャッシュされた各リソースに一意の識別子（キャッシュキー）を与えます。デフォルトでは、このキャッシュキーは単にリソースのURLですが、開発者はVaryヘッダーを使用して他の要素（圧縮方法など）を追加できます。

Varyヘッダーは、1つ以上の要求ヘッダー値の値をキャッシュキーに追加するようにクライアントに指示します。この最も一般的な例は、`Vary：Accept-Encoding`です。これにより、`Accept-Encoding`リクエストヘッダー値（`gzip`、`br`、`deflate`など）のキャッシュエントリが別になります。

別の一般的な値は`Vary：Accept-Encoding`、`User-Agent`です。これは、Accept-Encoding値と`User-Agent`文字列の両方によってキャッシュエントリを変更するようにクライアントに指示します。共有プロキシとCDNを扱う場合、`Accept-Encoding`以外の値を使用すると、キャッシュキーが弱められ、キャッシュから提供されるトラフィックの量が減少するため、問題発生の可能性があります。

一般に、そのヘッダーに基づいてクライアントに代替コンテンツを提供する場合のみ、キャッシュを変更する必要があります。

`Vary`ヘッダーは、HTTPレスポンスの39％、および`Cache-Control`ヘッダーを含むレスポンスの45％で使用されます。

以下のグラフは、上位10個の`Vary`ヘッダー値の人気を示しています。 `Accept-Encoding`はVaryの使用の90％を占め、`User-Agent`（11％）、`Origin`（9％）、`Accept`（3％）が残りの大部分を占めています。

{{ figure_markup(
  image="fig14.png",
  caption="Varyヘッダーの使用率。",
  description="accept-encodingは90％で使用、ユーザーエージェントは10％-11％、オリジンは約7％-8％、acceptは少なく、cookie、x-forward-proto、accept-language、host、x-origin、access-control-request-method、およびaccess-control-request-headersの使用はほとんどありません",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=384675253&format=interactive",
  width=600,
  height=655,
  data_width=600,
  data_height=655
  )
}}

## キャッシュ可能なレスポンスにCookieを設定する

レスポンスがキャッシュされると、そのヘッダー全体もキャッシュにスワップされます。これが、DevToolsを介してキャッシュされたレスポンスを検査するときにレスポンスヘッダーを表示できる理由です。

{{ figure_markup(
  image="ch16_fig12_header_example_with_cookie.jpg",
  caption="キャッシュされたリソースのChrome開発ツール。",
  description="キャッシュされたレスポンスのHTTPレスポンスヘッダーを示すChrome開発者ツールのスクリーンショット。",
  width=600,
  height=359
  )
}}

しかし、レスポンスに`Set-Cookie`がある場合はどうなりますか？ <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234セクション8</a>によると、`Set-Cookie`レスポンスヘッダーはキャッシングを禁止しません。これは、キャッシュされたエントリが`Set-Cookie`でキャッシュされている場合、それが含まれている可能性があることを意味します。 RFCでは、適切な`Cache-Control`ヘッダーを構成して、レスポンスのキャッシュ方法を制御することを推奨しています。

`Set-Cookie`を使用してレスポンスをキャッシュすることのリスクの1つは、Cookieの値を保存し、後続の要求に提供できることです。 Cookieの目的によっては、心配な結果になる可能性があります。たとえば、ログインCookieまたはセッションCookieが共有キャッシュに存在する場合、そのCookieは別のクライアントによって再利用される可能性があります。これを回避する1つの方法は、`Cache-Control``プライベート`ディレクティブを使用することです。これにより、クライアントブラウザーによるレスポンスのキャッシュのみが許可されます。

キャッシュ可能なレスポンスの3％に`Set-Cookieヘッダー`が含まれています。これらのレスポンスのうち、`プライベート`ディレクティブを使用しているのは18％のみです。残りの82％には、パブリックおよびプライベートキャッシュサーバーでキャッシュできる`Set-Cookie`を含む530万のHTTPレスポンスが含まれています。

{{ figure_markup(
  image="ch16_fig16_cacheable_responses_set_cookie.jpg",
  caption="<code>Set-Cookie</code> レスポンスのキャッシュ可能なレスポンス。",
  description="レスポンスの97％を示す棒グラフはSet-Cookieを使用せず、3％が使用します。この3％の内、15.3％がプライベート、84.7％がデスクトップ、モバイルは18.4％がパブリック、81.6％がプライベートであるという別の棒グラフに拡大されています。",
  width=600,
  height=567
  )
}}

## AppCacheおよびService Worker

アプリケーションキャッシュまたはAppCacheはHTML5の機能であり、開発者はブラウザがキャッシュするリソースを指定し、オフラインユーザーが利用できるようにできます。この機能は<a hreflang="en" href="https://web.archive.org/web/20191115024726/https://html.spec.whatwg.org/multipage/offline.html">廃止されており、Web標準からも削除</a>され、ブラウザーのサポートは減少しています。実際、使われているのが見つかった場合、[Firefox v44 +は、開発者に対して代わりにService Workerを使用することを推奨しています](https://developer.mozilla.org/docs/Web/API/Service_Worker_API/Using_Service_Workers)。 <a hreflang="en" href="https://www.chromestatus.com/feature/5714236168732672">Chrome 70は、アプリケーションキャッシュをセキュリティで保護されたコンテキストのみに制限します</a>。業界では、このタイプの機能をService Workerに実装する方向へ移行しており、<a hreflang="en" href="https://caniuse.com/#feat=serviceworkers">ブラウザサポート</a>は急速に成長しています。

実際、<a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">HTTP Archiveトレンドレポートの1つは、以下に示すService Worker</a>の採用を示しています。

{{ figure_markup(
  image="ch16_fig14_service_worker_adoption.jpg",
  caption='Service Workerが制御するページの時系列。 (引用: <a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">HTTP Archive</a>)',
  description="2016年10月から2019年7月までのService Workerが制御するサイトの使用状況を示す時系列チャート。モバイルとデスクトップの両方で使用量は年々着実に増加していますが、依然として両方で0.6％未満です。",
  width=600,
  height=311
  )
}}

採用率はまだウェブサイトの1％を下回っていますが、2017年1月から着実に増加しています。[プログレッシブWebアプリ](./pwa)の章では、人気サイトでの使用によりこのグラフが示唆するよりも多く使用されているという事実を含め、上記のグラフでは1回のみカウントされます。

次の表では、AppCacheとService Workerの使用状況の概要を確認できます。 32,292のWebサイトでService Workerが実装されていますが、1,867のサイトでは非推奨のAppCache機能が引き続き使用されています。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Service Workerを使用しない</th>
        <th scope="col">Service Workerを使用する</th>
        <th scope="col">合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>AppCacheを使用しない</td>
        <td class="numeric">5,045,337</td>
        <td class="numeric">32,241</td>
        <td class="numeric">5,077,578</td>
      </tr>
      <tr>
        <td>AppCacheを使用する</td>
        <td class="numeric">1,816</td>
        <td class="numeric">51</td>
        <td class="numeric">1,867</td>
      </tr>
      <tr>
        <td>合計</td>
        <td class="numeric">5,047,153</td>
        <td class="numeric">32,292</td>
        <td class="numeric">5,079,445</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="AppCacheを使用するWebサイトとService Workerの数。") }}</figcaption>
</figure>

これをHTTPとHTTPSで分類すると、さらに興味深いものになります。 581のAppCache対応サイトはHTTP経由で提供されます。つまり、Chromeがこの機能を無効にしている可能性があります。 HTTPSはService Workerを使用するための要件ですが、それらを使用するサイトの907はHTTP経由で提供されます。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <td></td>
        <th scope="col">Service Workerを使用しない</th>
        <th scope="col">Service Workerを使用する</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="rowgroup" rowspan="2" >HTTP</th>
        <td>AppCacheを使用しない</td>
        <td class="numeric">1,968,736</td>
        <td class="numeric">907</td>
      </tr>
      <tr>
        <td>AppCacheを使用する</td>
        <td class="numeric">580</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <th scope="rowgroup" rowspan="2" >HTTPS</th>
        <td>AppCacheを使用しない</td>
        <td class="numeric">3,076,601</td>
        <td class="numeric">31,334</td>
      </tr>
      <tr>
        <td>AppCacheを使用する</td>
        <td class="numeric">1,236</td>
        <td class="numeric">50</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="AppCacheを使用するWebサイト数とHTTP/HTTPSによるService Workerの使用量。") }}</figcaption>
</figure>

## キャッシングの機会を特定する

Googleの<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>ツールを使用すると、ユーザーはWebページに対して一連の監査を実行できます。<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">キャッシュポリシー監査</a>では、サイトが追加のキャッシュの恩恵を受けることができるかどうかを評価します。これは、コンテンツの経過時間（`Last-Modified`ヘッダー経由）をキャッシュTTLと比較し、リソースがキャッシュから提供される可能性を推定することによりこれを行います。スコアに応じて、結果にキャッシュの推奨事項が表示され、キャッシュできる特定のリソースのリストが表示される場合があります。

{{ figure_markup(
  image="ch16_fig15_lighthouse_example.jpg",
  caption="キャッシュポリシーの改善の可能性を強調したLighthouseレポート。",
  description="Google Lighthouseツールからのレポートの一部のスクリーンショット。「効率的なキャッシュポリシーを使用した静的アセットの提供」セクションが開いており、多数のリソース、名前が編集された人、キャッシュTTLとサイズのリストが表示されます。",
  width=600,
  height=459
  )
}}

Lighthouseは、監査ごとに0％〜100％の範囲のスコアを計算し、それらのスコアは全体のスコアに組み込まれます。<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">キャッシングスコア</a>は、潜在的なバイト節約に基づいています。 Lighthouseの結果を調べると、キャッシュポリシーでどれだけのサイトがうまく機能しているかを把握できます。

{{ figure_markup(
  image="fig21.png",
  caption="モバイルWebページの「Use Long Cache TTL」監査のLighthouseスコアの分布。",
  description="積み上げ棒グラフの38.2％のウェブサイトのスコアは10％未満、29.0％のウェブサイトのスコアは10％〜39％、18.7％のウェブサイトのスコアは40％〜79％、10.7％のウェブサイトは80％から99％のスコア、および3.4​​％のWebサイトが100％のスコアを取得します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=827424070&format=interactive"
  )
}}

100％を獲得したサイトは3.4％のみです。これは、ほとんどのサイトがキャッシュの最適化の恩恵を受けることができることを意味します。サイトの圧倒的多数が40％未満で、38％が10％未満のスコアを記録しています。これに基づいて、Webにはかなりの量のキャッシュの機会があります。

Lighthouseは、より長いキャッシュポリシーを有効にすることで、繰り返しビューで保存できるバイト数も示します。追加のキャッシュの恩恵を受ける可能性のあるサイトのうち、82％がページの重みを最大で1MB削減できます。

{{ figure_markup(
  image="fig22.png",
  caption="Lighthouseキャッシング監査による潜在的なバイト節約の分布。",
  description="Webサイトの56.8％が1MB未満の潜在的なバイト節約を示す積み上げ棒グラフ、22.1％は1〜2MBの節約、8.3％は2〜3MBの節約になります。 4.3％は3〜4MB節約でき、6.0％は4MB以上節約できました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1698914500&format=interactive"
  )
}}

## 結論

キャッシングは非常に強力な機能であり、ブラウザ、プロキシ、その他の仲介者（CDNなど）がWebコンテンツを保存し、エンドユーザーへ提供できるようにします。これにより、往復時間が短縮され、コストのかかるネットワーク要求が最小限に抑えられるため、パフォーマンス上のメリットは非常に大きくなります。

キャッシュも非常に複雑なトピックです。キャッシュエントリを検証するだけでなく、新鮮さを伝えることができるHTTPレスポンスヘッダーは多数あります。`Cache-Control`ディレクティブは、非常に多くの柔軟性と制御を提供します。ただし、開発者は、それがもたらす間違いの追加の機会に注意する必要があります。キャッシュ可能なリソースが適切にキャッシュされていることを確認するためにサイトを定期的に監査することをお勧めします。<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>や<a hreflang="en" href="https://redbot.org/">REDbot</a>などのツールは、分析の簡素化に役立ちます。
