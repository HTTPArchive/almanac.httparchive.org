---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: リソースヒント
description: 2019年のWeb Almanacのリソースヒントの章では、dns-prefetch、preconnect、preload、prefetch、priority hints、ネイティブの遅延ローディングの使用法をカバーしています。
hero_alt: Hero image of Web Almanac characters lining up to HTML, JavaScript, and image resources in a line on the way to a web page.
authors: [khempenius]
reviewers: [andydavies, tunetheweb, yoavweiss]
analysts: [rviscomi]
editors: [rviscomi]
translators: [ksakae1216]
discuss: 1774
results: https://docs.google.com/spreadsheets/d/14QBP8XGkMRfWRBbWsoHm6oDVPkYhAIIpfxRn4iOkbUU/
khempenius_bio: Katie HempeniusはChromeチームのエンジニアで、ウェブの高速化に取り組んでいます。
featured_quote: リソースヒントは、どのようなリソースがすぐに必要になるかについてブラウザに<em>ヒント</em>を提供します。このヒントを受け取った結果としてブラウザが取るアクションは、リソースヒントのタイプによって異なります。リソースヒントが正しく使用されていれば、重要なアクションを先取りすることでページのパフォーマンスを向上させることができます。
featured_stat_1: 29%
featured_stat_label_1: `dns-prefetch`を使用しているサイト
featured_stat_2: 88%
featured_stat_label_2: `as`属性を使用したリソースヒント。
featured_stat_3: 0.04%
featured_stat_label_3: 優先順位のヒントの使い方
---

## 序章

<a hreflang="en" href="https://www.w3.org/TR/resource-hints/">リソースヒント</a> は、どのようなリソースがすぐに必要になるかについての「ヒント」をブラウザに提供します。このヒントを受け取った結果としてブラウザが取るアクションは、リソースヒントの種類によって異なります。リソースヒントは正しく使用されると、重要なアクションを先取りすることでページのパフォーマンスを向上させることができます。

<a hreflang="en" href="https://youtu.be/YJGCZCaIZkQ?t=1956">例</a>は、リソースヒントの結果としてパフォーマンスが向上しています。

* Jabongは、重要なスクリプトをプリロードすることで、対話までの時間を1.5秒短縮しました。
* Barefoot Wineは、目に見えるリンクを先読みすることで、将来のページの対話までの時間を2.7秒短縮しました。
* Chrome.comは、クリティカルなオリジンに事前接続することで、待ち時間を0.7秒短縮しました。

今日、ほとんどのブラウザでサポートされているリソースヒントには、4つの独立したものがあります。`dns-prefetch`, `preconnect`, `preload`, `prefetch` です。

### `dns-prefetch`

[`dns-prefetch`](https://developer.mozilla.org/docs/Learn/Performance/dns-prefetch)の役割は、初期のDNS検索を開始することである。サードパーティのDNSルックアップを完了させるのに便利です。たとえば、CDN、フォントプロバイダー、サードパーティAPIのDNSルックアップなどです。

### `preconnect`

<a hreflang="ja" href="https://web.dev/i18n/ja/uses-rel-preconnect">`preconnect`</a>は、DNSルックアップ、TCPハンドシェイク、TLSネゴシエーションを含む早期接続を開始します。このヒントはサードパーティとの接続を設定する際に有用である。`preconnect`の用途は`dns-prefetch`の用途と非常によく似ているが、`preconnect`はブラウザのサポートが少ない。しかし、IE 11のサポートを必要としないのであれば、preconnectの方が良い選択であろう。

### `preload`

<a hreflang="en" href="https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf">`preload`</a>ヒントは、早期のリクエストを開始します。これは、パーサによって発見されるのが遅れてしまうような重要なリソースをロードするのに便利です。たとえば、ブラウザがスタイルシートを受信し解析したあとでしか重要な画像を発見できない場合、画像をプリロードすることは意味があるかもしれません。

### `prefetch`

<a hreflang="en" href="https://calendar.perfplanet.com/2018/all-about-prefetching/">`prefetch`</a>は優先度の低いリクエストを開始します。これは、次の（現在のページではなく）ページの読み込みで使われるであろうリソースを読み込むのに便利です。プリフェッチの一般的な使い方は、アプリケーションが次のページロードで使われると「予測」したリソースをロードすることです。これらの予測は、ユーザーのマウスの動きや、一般的なユーザーの流れ/旅のようなシグナルに基づいているかもしれません。

## 文法

リソースヒント使用率の97%は、リソースヒントを指定するために[`<link>`](https://developer.mozilla.org/docs/Web/HTML/Element/link)タグを使用しています。たとえば、以下のようになります。

```html
<link rel="prefetch" href="shopping-cart.js">
```

リソースヒント使用率のわずか3%は、リソースヒントの指定に[HTTPヘッダ](https://developer.mozilla.org/docs/Web/HTTP/Headers/Link)を使用しました。たとえば、以下のようになります。

```
Link: <https://example.com/shopping-cart.js>; rel=prefetch
```

HTTPヘッダー内のリソースヒントの使用量が非常に少ないため、本章の残りの部分では、`<link>`タグと組み合わせたリソースヒントの使用量の分析のみに焦点を当てています。しかし、今後、[HTTP/2 Push](./http#http2プッシュ)が採用されるようになると、HTTPヘッダーでのリソースヒントの使用量が増える可能性のあることは注目に値します。これは、HTTP/2 Pushがリソースをプッシュするためのシグナルとして、HTTPのプリロード `Link` ヘッダーを再利用していることに起因しています。

## リソースヒント

<aside class="note">注: モバイルとデスクトップでは、リソースヒントの利用パターンに目立った違いはありませんでした。そのため、簡潔にするために、本章ではモバイルの統計のみを掲載しています。</aside>

<figure>
  <table>
    <tr>
      <th>リソースヒント</th>
      <th>利用状況（サイトの割合）</th>
    </tr>
    <tr>
      <td><code>dns-prefetch</code>
      </td>
      <td>29%
      </td>
    </tr>
    <tr>
      <td><code>preload</code>
      </td>
      <td>16%
      </td>
    </tr>
    <tr>
      <td><code>preconnect</code>
      </td>
      <td>4%
      </td>
    </tr>
    <tr>
      <td><code>prefetch</code>
      </td>
      <td>3%
      </td>
    </tr>
    <tr>
      <td><code>prerender</code> (非推奨)
      </td>
      <td>0.13%
      </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="リソースヒントの採用。") }}</figcaption>
</figure>

`dns-prefetch`の相対的な人気は驚くに値しません。これはよく知られたAPIであり（<a hreflang="en" href="https://caniuse.com/#feat=link-rel-dns-prefetch">2009</a>ではじめて登場しました）、すべての主要なブラウザでサポートされており、すべてのリソースヒントの中でもっとも「安価」なものです。`dns-prefetch`はDNSの検索を行うだけなので、データの消費量が非常に少なく、使用する上でのデメリットはほとんどありません。`dns-prefetch`はレイテンシの高い状況でもっとも有用である。

つまり、IE11以下をサポートする必要がないサイトであれば、`dns-prefetch`から`preconnect`に切り替えるのが良いでしょう。HTTPSがユビキタスな時代には、`preconnect`は安価でありながら、より大きな[パフォーマンス](./performance)の向上をもたらします。`dns-prefetch`とは異なり、`preconnect`はDNSの検索だけでなく、TCPハンドシェイクとTLSネゴシエーションも開始することに注意してください。<a hreflang="en" href="https://knowledge.digicert.com/solution/SO16297.html">証明書チェーン</a>はTLSネゴシエーション中にダウンロードされるが、これには通常数キロバイトのコストがかかります。

`prefetch`は3%のサイトで利用されており、もっとも広く利用されていないリソースヒントである。この使用率の低さは、`prefetch`が現在のページの読み込みよりも後続のページの読み込みを改善するのに有用であるという事実によって説明できるかもしれません。したがって、ランディングページの改善や最初に閲覧されたページのパフォーマンスを向上させることだけに焦点を当てているサイトでは、これは見過ごされてしまうだろう。

<figure>
  <table>
    <tr>
      <th>リソースヒント</th>
      <th>ページごとのリソースヒント<br>中央値</th>
      <th>ページごとのリソースヒント<br>90パーセンタイル</th>
    </tr>
    <tr>
      <td><code>dns-prefetch</code>
      </td>
      <td>2
      </td>
      <td>8
      </td>
    </tr>
    <tr>
      <td><code>preload</code>
      </td>
      <td>2
      </td>
      <td>4
      </td>
    </tr>
    <tr>
      <td><code>preconnect</code>
      </td>
      <td>2
      </td>
      <td>8
      </td>
    </tr>
    <tr>
      <td><code>prefetch</code>
      </td>
      <td>1
      </td>
      <td>3
      </td>
    </tr>
    <tr>
      <td><code>prerender</code> (非推奨)
      </td>
      <td>1
      </td>
      <td>1
      </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="そのリソースヒントを使用している全ページのうち、1ページあたりに使用されているリソースヒントの数の中央値と90パーセンタイル。") }}</figcaption>
</figure>

リソースヒントは、選択的に使用されるときにもっとも効果的です（_"すべてが重要なときには、何も重要ではない"_）。上の図19.2は、少なくとも1つのリソースヒントを使用しているページの1ページあたりのリソースヒントの数を示しています。適切なリソースヒントの数を定義する明確なルールはありませんが、ほとんどのサイトが適切にリソースヒントを使用しているように見えます。

## `crossorigin`属性

ウェブ上に取り込まれるほとんどの「伝統的な」リソース（[images](./media)、[stylesheets](./css)、[script](./javascript)）は、クロスオリジンリソース共有（[CORS](https://developer.mozilla.org/docs/Web/HTTP/CORS)）を選択せずに取り込まれています。つまり、これらのリソースがクロスオリジンサーバーからフェッチされた場合、デフォルトでは同一オリジンポリシーのために、その内容をページで読み返すことができないということです。

場合によっては、ページはコンテンツを読む必要がある場合、CORSを使用してリソースを取得するようにオプトインできます。CORSは、ブラウザが「許可を求める」ことを可能にし、それらのクロスオリジンリソースへのアクセスを取得します。

新しいリソースタイプ（フォント、`fetch()` リクエスト、ESモジュールなど）では、ブラウザはデフォルトでCORSを使用してリソースをリクエストし、サーバーがアクセス許可を与えていない場合はリクエストを完全に失敗させます。

<figure>
  <table>
    <tr>
      <th><code>クロスオリジン</code>値</th>
      <th>使用方法</th>
      <th>説明</th>
    </tr>
    <tr>
      <td>未設定
      </td>
      <td>92%
      </td>
      <td>crossorigin属性がない場合、リクエストはシングルオリジンポリシーに従います。
      </td>
    </tr>
    <tr>
      <td>anonymous(に相当する)
      </td>
      <td>7%
      </td>
      <td>クレデンシャルを含まないクロスオリジンリクエストを実行します。
      </td>
    </tr>
    <tr>
      <td>use-credentials
      </td>
      <td>0.47%
      </td>
      <td>クレデンシャルを含むクロスオリジンリクエストを実行します。
      </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="リソースヒントインスタンスの割合としての <code>クロスオリジン</code> 属性の採用。") }}</figcaption>
</figure>

リソースヒントのコンテキストでは、`crossorigin`属性を使用することで、マッチすることになっているリソースのCORSモードにマッチし、リクエストに含めるべき資格情報を示すことができます。たとえば、`anonymous`はCORSを有効にし、クロスオリジンリクエストには資格情報を含めるべきではないことを示します。

```html
<link rel="prefetch" href="https://other-server.com/shopping-cart.css" crossorigin="anonymous">
```

他のHTML要素はcrossorigin属性をサポートしていますが、この分析では、リソースヒントを使った使用法のみを見ています。

## `as`属性

`as`は`preload`リソースヒントと一緒に使用されるべき属性で、要求されたリソースの種類（画像、スクリプト、スタイルなど）をブラウザに知らせるため使用されます。これにより、ブラウザがリクエストに正しく優先順位をつけ、正しいコンテンツセキュリティポリシー(<a hreflang="en" href="https://developers.google.com/web/fundamentals/security/csp">CSP</a>)を適用するのに役立ちます。CSPはHTTPヘッダーで表現される[セキュリティ](./security)メカニズムです、信頼できるソースのセーフリストを宣言することで、XSSやその他の悪意のある攻撃の影響を緩和するのに役立ちます。

{{ figure_markup(
  caption="<code>as</code> 属性を使用したリソースヒントインスタンスの割合。",
  content="88%",
  classes="big-number"
)
}}

リソースヒントインスタンスの88%は`as`属性を使用しています。`as`が指定されている場合、圧倒的にスクリプトに使われています。92%がスクリプト、3%がフォント、3%がスタイルです。これはスクリプトがほとんどのサイトのアーキテクチャで重要な役割を果たしていることと、スクリプトが攻撃のベクターとして使用される頻度が高いことを考えると当然のことです（したがって、スクリプトが正しいCSPを適用されることがとくに重要です）。

## 将来のこと

現時点では、現在のリソースヒントのセットを拡張する提案はありません。しかし、優先度ヒントとネイティブの遅延ローディングは、ローディングプロセスを最適化するためのAPIを提供するという点で、リソースヒントに似た精神を持つ2つの技術が提案されています。

### 優先順位のヒント

<a hreflang="en" href="https://wicg.github.io/priority-hints/">優先度ヒント</a>は、リソースのフェッチの優先度を`high`,`low`,`auto`のいずれかで表現するためのAPIです。これらは幅広いHTMLタグで利用できます。とくに`<image>`,`<link`>,`<script>`,`<iframe>`などです。

<figure class="figure-block">
<div class="code-block floating-card">
  <pre role="region" aria-label="Code 0" tabindex="0"><code>&lt;carousel>
  &lt;img src="cat1.jpg" importance="high">
  &lt;img src="cat2.jpg" importance="low">
  &lt;img src="cat3.jpg" importance="low">
&lt;/carousel></code></pre></div>
<figcaption>{{ figure_link(caption="画像のカルーセルで優先度ヒントを使用するHTMLの例。") }}</figcaption>
</figure>

たとえば、画像カルーセルがある場合、優先度ヒントを使用して、ユーザーがすぐに見る画像に優先順位をつけ、後の画像に優先順位をつけることができます。

{{ figure_markup(
  caption="優先ヒントの採用率。",
  content="0.04%",
  classes="big-number"
)
}}

優先度ヒントは<a hreflang="en" href="https://www.chromestatus.com/feature/5273474901737472">実装</a>されており、Chromiumブラウザのバージョン70以降では機能フラグを使ってテストできます。まだ実験的な技術であることを考えると、0.04%のサイトでしか使用されていないのは当然のことです。

優先度ヒントの85%は`<img>`タグを使用しています。優先度ヒントはほとんどがリソースの優先順位を下げるために使われます。使用率の72%は`importance="low"`で、28%は`importance="high"`です。

### ネイティブの遅延ローディング

<a hreflang="en" href="https://web.dev/native-lazy-loading">ネイティブの遅延ローディング</a>は、画面外の画像やiframeの読み込みを遅延させるためのネイティブAPIです。これにより、最初のページ読み込み時にリソースを解放し、使用されないアセットの読み込みを回避できます。以前は、この技術はサードパーティの[JavaScript](./javascript)ライブラリでしか実現できませんでした。

ネイティブな遅延読み込みのためのAPIはこのようになります。`<img src="cat.jpg" loading="lazy">`.

ネイティブな遅延ローディングは、Chromium76以上をベースにしたブラウザで利用可能です。このAPIは発表が遅すぎて今年のWeb Almanacのデータセットには含まれていませんが、来年に向けて注目しておきたいものです。

## 結論

全体的に、このデータはリソースヒントをさらに採用する余地があることを示唆しているように思われる。ほとんどのサイトでは、`dns-prefetch`から`preconnect`に切り替えることで恩恵を受けることができるだろう。もっと小さなサブセットのサイトでは、`prefetch`や`preload`を採用することで恩恵を受けることができるだろう。`prefetch`と`preload`をうまく使うには、より大きなニュアンスがあり、それが採用をある程度制限していますが、潜在的な利益はより大きくなります。HTTP/2 Pushや機械学習技術の成熟により、`preload`や`prefetch`の採用が増える可能性もあります。
