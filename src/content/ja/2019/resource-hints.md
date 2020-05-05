---
part_number: IV
chapter_number: 19
title: リソースヒント
description: 2019年のWeb Almanacのリソースヒントの章では、dns-prefetch、preconnect、preload、prefetch、priority hints、ネイティブの遅延ローディングの使用法をカバーしています。
authors: [khempenius]
reviewers: [andydavies, bazzadp, yoavweiss]
translators: [ksakae]
discuss: 1774
results: https://docs.google.com/spreadsheets/d/14QBP8XGkMRfWRBbWsoHm6oDVPkYhAIIpfxRn4iOkbUU/
queries: 19_Resource_Hints
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-03-02T00:00:00.000Z
---

## 序章

[リソースヒント](https://www.w3.org/TR/resource-hints/) は、どのようなリソースがすぐに必要になるかについての「ヒント」をブラウザに提供します。このヒントを受け取った結果としてブラウザが取るアクションは、リソースヒントの種類によって異なります。リソースヒントは正しく使用されると、重要なアクションを先取りすることでページのパフォーマンスを向上させることができます。

[例](https://youtu.be/YJGCZCaIZkQ?t=1956)は、リソースヒントの結果としてパフォーマンスが向上しています。

*   Jabongは、重要なスクリプトをプリロードすることで、対話までの時間を1.5秒短縮しました。
*   Barefoot Wineは、目に見えるリンクを先読みすることで、将来のページの対話までの時間を2.7秒短縮しました。
*   Chrome.comは、クリティカルなオリジンに事前接続することで、待ち時間を0.7秒短縮しました。

今日、ほとんどのブラウザでサポートされているリソースヒントには、4つの独立したものがあります。`dns-prefetch`, `preconnect`, `preload`, `prefetch` です。

### `dns-prefetch`

[`dns-prefetch`](https://developer.mozilla.org/en-US/docs/Learn/Performance/dns-prefetch)の役割は、初期のDNS検索を開始することである。サードパーティのDNSルックアップを完了させるのに便利です。たとえば、CDN、フォントプロバイダー、サードパーティAPIのDNSルックアップなどです。

### `preconnect`

[`preconnect`](https://web.dev/uses-rel-preconnect)は、DNSルックアップ、TCPハンドシェイク、TLSネゴシエーションを含む早期接続を開始します。このヒントはサードパーティとの接続を設定する際に有用である。`preconnect`の用途は`dns-prefetch`の用途と非常によく似ているが、`preconnect`はブラウザのサポートが少ない。しかし、IE 11のサポートを必要としないのであれば、preconnectの方が良い選択であろう。

### `preload`

[`preload`](https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf)ヒントは、早期のリクエストを開始します。これは、パーサによって発見されるのが遅れてしまうような重要なリソースをロードするのに便利です。たとえば、ブラウザがスタイルシートを受信し解析したあとでしか重要な画像を発見できない場合、画像をプリロードすることは意味があるかもしれません。

### `prefetch`

[`prefetch`](https://calendar.perfplanet.com/2018/all-about-prefetching/)は優先度の低いリクエストを開始します。これは、次の（現在のページではなく）ページの読み込みで使われるであろうリソースを読み込むのに便利です。プリフェッチの一般的な使い方は、アプリケーションが次のページロードで使われると「予測」したリソースをロードすることです。これらの予測は、ユーザーのマウスの動きや、一般的なユーザーの流れ/旅のようなシグナルに基づいているかもしれません。

## 文法

リソースヒント使用率の97%は、リソースヒントを指定するために[`<link>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/link)タグを使用しています。たとえば、以下のようになります。
```
<link rel="prefetch" href="shopping-cart.js">
```

リソースヒント使用率のわずか3%は、リソースヒントの指定に[HTTPヘッダ](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link)を使用しました。たとえば、以下のようになります。
```
Link: <https://example.com/shopping-cart.js>; rel=prefetch
```

HTTPヘッダー内のリソースヒントの使用量が非常に少ないため、本章の残りの部分では、`<link>`タグと組み合わせたリソースヒントの使用量の分析のみに焦点を当てています。しかし、今後、[HTTP/2 Push](./http2#http2-push)が採用されるようになると、HTTPヘッダーでのリソースヒントの使用量が増える可能性のあることは注目に値します。これは、HTTP/2 Pushがリソースをプッシュするためのシグナルとして、HTTPのプリロード `Link` ヘッダーを再利用していることに起因しています。

## リソースヒント

<p class="note">注: モバイルとデスクトップでは、リソースヒントの利用パターンに目立った違いはありませんでした。そのため、簡潔にするために、本章ではモバイルの統計のみを掲載しています。</p>

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
  <figcaption>図1. リソースヒントの採用。</figcaption>
</figure>

`dns-prefetch`の相対的な人気は驚くに値しません。これはよく知られたAPIであり（[2009](https://caniuse.com/#feat=link-rel-dns-prefetch)ではじめて登場しました）、すべての主要なブラウザでサポートされており、すべてのリソースヒントの中でもっとも「安価」なものです。`dns-prefetch`はDNSの検索を行うだけなので、データの消費量が非常に少なく、使用する上でのデメリットはほとんどありません。`dns-prefetch`はレイテンシの高い状況でもっとも有用である。

つまり、IE11以下をサポートする必要がないサイトであれば、`dns-prefetch`から`preconnect`に切り替えるのが良いでしょう。HTTPSがユビキタスな時代には、`preconnect`は安価でありながら、より大きな[パフォーマンス](./performance)の向上をもたらします。`dns-prefetch`とは異なり、`preconnect`はDNSの検索だけでなく、TCPハンドシェイクとTLSネゴシエーションも開始することに注意してください。[証明書チェーン](https://knowledge.digicert.com/solution/SO16297.html)はTLSネゴシエーション中にダウンロードされるが、これには通常数キロバイトのコストがかかります。

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
  <figcaption>図2. そのリソースヒントを使用している全ページのうち、1ページあたりに使用されているリソースヒントの数の中央値と90パーセンタイル。</figcaption>
</figure>

リソースヒントは、選択的に使用されるときにもっとも効果的です（_"すべてが重要なときには、何も重要ではない"_）。上の図2は、少なくとも1つのリソースヒントを使用しているページの1ページあたりのリソースヒントの数を示しています。適切なリソースヒントの数を定義する明確なルールはありませんが、ほとんどのサイトが適切にリソースヒントを使用しているように見えます。

## `crossorigin`属性

ウェブ上に取り込まれるほとんどの「伝統的な」リソース（[images](./media)、[stylesheets](./css)、[script](./javascript)）は、クロスオリジンリソース共有（[CORS](https://developer.mozilla.org/ja/docs/Web/HTTP/CORS)）を選択せずに取り込まれています。つまり、これらのリソースがクロスオリジンサーバーからフェッチされた場合、デフォルトでは同一オリジンポリシーのために、その内容をページで読み返すことができないということです。

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
  <figcaption>図3. リソースヒントインスタンスの割合としての<code>クロスオリジン</code>属性の採用。</figcaption>
</figure>

リソースヒントのコンテキストでは、`crossorigin`属性を使用することで、マッチすることになっているリソースのCORSモードにマッチし、リクエストに含めるべき資格情報を示すことができます。たとえば、`anonymous`はCORSを有効にし、クロスオリジンリクエストには資格情報を含めるべきではないことを示します。
```
<link rel="prefetch" href="https://other-server.com/shopping-cart.css" crossorigin="anonymous">
```

他のHTML要素はcrossorigin属性をサポートしていますが、この分析では、リソースヒントを使った使用法のみを見ています。

## `as`属性

`as`は`preload`リソースヒントと一緒に使用されるべき属性で、要求されたリソースの種類（画像、スクリプト、スタイルなど）をブラウザに知らせるため使用されます。これにより、ブラウザがリクエストに正しく優先順位をつけ、正しいコンテンツセキュリティポリシー([CSP](https://developers.google.com/web/fundamentals/security/csp))を適用するのに役立ちます。CSPはHTTPヘッダーで表現される[セキュリティ](./security)メカニズムです、信頼できるソースのセーフリストを宣言することで、XSSやその他の悪意のある攻撃の影響を緩和するのに役立ちます。

<figure>
  <div class="big-number">88%</div>
  <figcaption>図4. <code>as</code>属性を使用したリソースヒントインスタンスの割合。</figcaption>
</figure>

リソースヒントインスタンスの88%は`as`属性を使用しています。`as`が指定されている場合、圧倒的にスクリプトに使われています。92%がスクリプト、3%がフォント、3%がスタイルです。これはスクリプトがほとんどのサイトのアーキテクチャで重要な役割を果たしていることと、スクリプトが攻撃のベクターとして使用される頻度が高いことを考えると当然のことです（したがって、スクリプトが正しいCSPを適用されることがとくに重要です）。

## 将来のこと

現時点では、現在のリソースヒントのセットを拡張する提案はありません。しかし、優先度ヒントとネイティブの遅延ローディングは、ローディングプロセスを最適化するためのAPIを提供するという点で、リソースヒントに似た精神を持つ2つの技術が提案されています。

### 優先順位のヒント

[優先度ヒント](https://wicg.github.io/priority-hints/)は、リソースのフェッチの優先度を`high`,`low`,`auto`のいずれかで表現するためのAPIです。これらは幅広いHTMLタグで利用できます。とくに`<image>`,`<link`>,`<script>`,`<iframe>`などです。

<figure>
<div class="code-block floating-card">
  <pre><code>&lt;carousel>
  &lt;img src="cat1.jpg" importance="high">
  &lt;img src="cat2.jpg" importance="low">
  &lt;img src="cat3.jpg" importance="low">
&lt;/carousel></code></pre></div>
<figcaption>図5. 画像のカルーセルで優先度ヒントを使用するHTMLの例。</figcaption>
</figure>

たとえば、画像カルーセルがある場合、優先度ヒントを使用して、ユーザーがすぐに見る画像に優先順位をつけ、後の画像に優先順位をつけることができます。

<figure>
  <div class="big-number">0.04%</div>
  <figcaption>図6. 優先ヒントの採用率。</figcaption>
</figure>

優先度ヒントは[実装](https://www.chromestatus.com/feature/5273474901737472)されており、Chromiumブラウザのバージョン70以降では機能フラグを使ってテストできます。まだ実験的な技術であることを考えると、0.04%のサイトでしか使用されていないのは当然のことです。

優先度ヒントの85%は`<img>`タグを使用しています。優先度ヒントはほとんどがリソースの優先順位を下げるために使われます。使用率の72%は`importance="low"`で、28%は`importance="high"`です。

### ネイティブの遅延ローディング

[ネイティブの遅延ローディング](https://web.dev/native-lazy-loading)は、画面外の画像やiframeの読み込みを遅延させるためのネイティブAPIです。これにより、最初のページ読み込み時にリソースを解放し、使用されないアセットの読み込みを回避できます。以前は、この技術はサードパーティの[JavaScript](./javascript)ライブラリでしか実現できませんでした。

ネイティブな遅延読み込みのためのAPIはこのようになります。`<img src="cat.jpg" loading="lazy">`.

ネイティブな遅延ローディングは、Chromium76以上をベースにしたブラウザで利用可能です。このAPIは発表が遅すぎて今年のWeb Almanacのデータセットには含まれていませんが、来年に向けて注目しておきたいものです。

## 結論

全体的に、このデータはリソースヒントをさらに採用する余地があることを示唆しているように思われる。ほとんどのサイトでは、`dns-prefetch`から`preconnect`に切り替えることで恩恵を受けることができるだろう。もっと小さなサブセットのサイトでは、`prefetch`や`preload`を採用することで恩恵を受けることができるだろう。`prefetch`と`preload`をうまく使うには、より大きなニュアンスがあり、それが採用をある程度制限していますが、潜在的な利益はより大きくなります。HTTP/2 Pushや機械学習技術の成熟により、`preload`や`prefetch`の採用が増える可能性もあります。
