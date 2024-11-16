---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: リソースヒント
description: 2021年版Web Almanacのリソースヒントの章では、リソースヒントの採用、その使い方、バッドプラクティス、パフォーマンスへの影響について説明しています。
hero_alt: Hero image of Web Almanac charactes lining up to HTML, JavaScript, and image resources in a line on the way to a web page.
authors: [kevinfarrugia]
reviewers: [siakaramalegos, tunetheweb, andydavies, samarpanda, westonruter]
analysts: [Nithanaroy]
editors: [rviscomi]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1Mw6TjkIClRtlZPHbij5corOZbaSUp-vgTVq3Ig18IwQ/
kevinfarrugia_bio: Kevin Farrugiaは、ウェブパフォーマンスとソフトウェアアーキテクチャのコンサルタントです。ブログは<a hreflang="en" href="https://imkev.dev">imkev.dev</a> でご覧いただけます。
featured_quote: 資源のヒントは、レーシングカーのエンジンを微調整するようなものです。遅いエンジンを速くすることはできないし、調整しすぎると壊れてしまう。でも、ちょっとした工夫で、その性能を最大限に引き出すことができる。
featured_stat_1: 44.3%
featured_stat_label_1: 上位1,000サイトにおけるプリロードの採用状況
featured_stat_2: 21.5%
featured_stat_label_2: 最初の3秒間の未使用のプリロードヒント
featured_stat_3: 423%
featured_stat_label_3: 画像へのネイティブ遅延ローディングの採用が拡大
---

## 序章

リソースヒントは、ウェブサイトのパフォーマンスを向上させるために使用できる、ブラウザへの指示です。この指示によりブラウザが、取得および処理する必要があるオリジンまたはリソースの優先順位を決定するのを支援できます。

ここでは、リソースヒントの実装方法、よくある落とし穴、そしてリソースヒントをできるだけ効果的に使うためにできることを詳しく見ていきましょう。

### Linkディレクティブ

もっとも広く採用されているリソースヒントは、Linkディレクティブの `rel` 属性で実装されています。それらは<a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-dns-prefetch">`dns-prefetch`</a>、<a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-preconnect">`preconnect`</a>、<a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-prefetch">`prefetch`</a>、<a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-prerender">`prerender`</a>と<a hreflang="en" href="https://www.w3.org/TR/preload/">`preload`</a>です。

これらは、次の2つの方法で実装できます。

#### HTML要素

```html
<link rel="dns-prefetch" href="https://example.com">
```

#### HTTPヘッダー

```
Link: <https://example.com>; rel=dns-prefetch
```

また、JavaScriptを使用することで、HTML要素を動的に注入することも可能です。

```js
const link = document.createElement("link");
link.rel="prefetch";
link.href="https://example.com";
document.head.appendChild(link);
```

HTTPヘッダーの採用率は、ドキュメントマークアップの一部としてリソースヒントを実装するよりも著しく低く、分析したページの1.5%未満しかHTTPヘッダーでリソースヒントを実装していません。これは、サーバ側でHTTPヘッダーを追加するのに比べ、HTMLソースから簡単に追加・変更できることに起因すると思われます。

{{ figure_markup(
  image="http-headers-vs-html-markup.png",
  caption='HTTPヘッダーやHTMLマークアップとしてのリソースヒントの普及。',
  description='HTTPヘッダーとHTMLマークアップとしてのリソースヒントの人気を示す棒グラフです。HTMLマークアップは、デスクトップでは91.2%、モバイルで94.1% のインスタンスで使用されています。HTTPヘッダーは、デスクトップのインスタンスの8.8%、モバイルのインスタンスの5.9%で使用されています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1056457221&format=interactive",
  sheets_gid="1707816066",
  sql_file="http_headers_hints_adoption.sql"
  )
}}

私たちの現在の [方法論](./methodology) では、<a hreflang="en" href="https://github.com/GoogleChromeLabs/quicklink">QuickLink</a> を通じて追加されるような、ユーザー インタラクションに続いて追加されるリソース ヒントを確実に測定することは不可能ですが、この特定のライブラリは[コアウェブ・バイタル・テクノロジー・レポート](https://datastudio.google.com/s/uMbv5CQfW4Q)によると分析したページの0.1%以下でしか表示されませんでした。

HTTPヘッダーを用いたリソースヒントの採用は、`<link>` HTML要素に対する採用よりも著しく少ないことを考慮し、本章の残りの部分では、HTML要素を用いたリソースヒントの使用状況の分析に焦点を当てることにする。

### リソースヒントの種類

現在、ほとんどのブラウザでサポートされているリソースヒントのリンク関係は5つあります。`dns-prefetch`, `preconnect`, `prefetch`, `prerender`, `preload` です。

#### `dns-prefetch`

```html
<link rel="dns-prefetch" href="https://example.com/">
```

`dns-prefetch` ヒントは、ドメイン名を解決するための初期リクエストを開始します。これはクロスオリジンドメインのDNS検索にのみ有効で、 `preconnect` とペアで使用することができる。Chromeは現在、最大で<a hreflang="en" href="https://source.chromium.org/chromium/chromium/src/+/fdf9418d23d434e0f7134da67dc41b0fe8268e91:net/dns/host_resolver_manager.cc;l=416">64</a>の同時実行中のDNS要求をサポートしていますが、昨年までの6から増加し、他のブラウザではまだ厳しい制限を受けています。たとえば、Firefoxでは <a hreflang="en" href="https://github.com/mozilla/gecko-dev/blob/master/netwerk/dns/nsHostResolver.h#L48">8</a> に制限されています。

#### `preconnect`

```html
<link rel="preconnect" href="https://example.com/">
```

`preconnect` ヒントは `dns-prefetch` と同様の動作をしますが、DNSルックアップに加えて、HTTPSで提供される場合はTLSハンドシェイクとともに接続を確立します。`dns-prefetch` の代わりに `preconnect` を使用すると、より高いパフォーマンスを得ることができます。しかし、証明書は通常3KB以上あり、他のリソースの帯域と競合してしまうため、控えめに使用する必要があります。また、重要なリソースに必要のないコネクションを開いてCPU時間を浪費することも避けたいものです。もしコネクションが短時間（たとえばChromeでは10秒）使用されない場合、ブラウザによって自動的に閉じられ、`preconnect`の努力がムダになることを覚えておいてください。

#### `prefetch`

```html
<link rel="prefetch" href="/library.js" as="script">
```

`prefetch` ヒントを使うと、次のナビゲーションでリソースが必要になるかもしれないことをブラウザに勧めることができます。ブラウザはリソースの優先順位の低いリクエストを開始し、必要なときにキャッシュから取得されるため、ユーザー体験を向上させることができるかもしれません。リソースは `prefetch` で事前に取得できますが、ユーザーがリソースを必要とするページに移動するまで、前処理や実行は行われません。

#### `prerender`

```html
<link rel="prerender" href="https://example.com/page-2/">
```

`prerender` ヒントを使用すると、ページをバックグラウンドでレンダリングし、ユーザがそのページに移動した場合のロード時間を改善できます。リソースを要求するだけでなく、ブラウザは前処理を行い、サブリソースを取得・実行できます。`prerender` は、ユーザーがプリレンダリングされたページにナビゲートしない場合、ムダに終わる可能性があります。仕様に反して、Chromeは `prerender` ヒントを <a hreflang="en" href="https://developers.google.com/web/updates/2018/07/nostate-prefetch">NoStateプリフェッチ</a> として扱い、このリスクを軽減しています。完全なプリレンダーとは異なり、JavaScriptの実行やページの一部のレンダリングは事前に行わず、リソースを事前に取得するのみです。

#### `preload`

ほとんどのモダンブラウザは `preload` ヒントも<a hreflang="en" href="https://caniuse.com/link-rel-preload">サポート</a>していますし、<a hreflang="en" href="https://caniuse.com/link-rel-modulepreload">程度の差</a>はありますが <a hreflang="en" href="https://html.spec.whatwg.org/multipage/links.html#link-type-modulepreload">`modulepreload`</a> というヒントもサポートしています。`preload` 命令は、ページの読み込みに必要なリソースの初期フェッチを開始し、フォントファイルやスタイルシートで参照される画像など、発見が遅れたリソースにもっともよく使用されます。リソースのプリロードは、リソースの優先順位を上げるために使われることがあり、開発者はHTMLの解析中に発見されたとしても、<a hreflang="en" href="https://web.dev/articles/lcp">最大のコンテントフルペイント</a> (LCP) 画像の読み込みを優先させることができます。

`modulepreload` は `preload` に特化した代替手段で、動作は似ていますが、使用できるのは <a hreflang="en" href="https://html.spec.whatwg.org/multipage/webappapis.html#module-script">モジュールスクリプト</a> に限定されています。

## 採用実績と傾向

{{ figure_markup(
  image="resource-hints-adoption.png",
  caption='リンクのrel属性の採用。',
  description='link rel属性の値を使用しているページの割合を示す棒グラフです。`dns-prefetch`はモバイルで36.4%、デスクトップでは35.7%の割合で採用されています。`preload` はモバイルで22.1%、デスクトップでは22.0%の採用率です。`preconnect` はモバイルで12.7%、デスクトップでは12.9%の採用率です。`prefetch` はモバイルで2.1%、デスクトップでは2.4%の採用率です。`prerender` はモバイルで0.1%、デスクトップでは0.1% の採用率です。`modulepreload` はモバイルで0.1%、デスクトップでは0.1% の採用率です。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1740212588&format=interactive",
  sheets_gid="2077755325",
  sql_file="hints_adoption.sql"
  )
}}

もっとも多く利用されているリソースヒントは `dns-prefetch` (モバイルでは36.4%)です。というのは、<a hreflang="en" href="https://caniuse.com/link-rel-dns-prefetch">2009年</a>に導入されたことを考えると、当然といえば当然なのですが。HTTPSの普及に伴い、そのドメインに接続することが確実な場合は、多くの場合、`preconnect`に置き換える必要があります（モバイルでは12.7％）。`preload` ヒントは<a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/_nu6HlbNQfo/m/XzaLNb1bBgAJ?pli=1">2016年</a> にChromeではじめて登場した比較的新しいものですが、2番目に広く採用されているリソースヒント（モバイルでは22.1%）で、前年比で一定の成長を見せていることが、この指示の重要性と柔軟性を裏付けています。

上のグラフにあるように、モバイルとデスクトップでの普及率はほぼ同じです。

### ランク別

{{ figure_markup(
  image="rel-preload-adoption-by-rank.png",
  caption='`rel="preload"`のCrUXランク別採用状況。',
  description='`rel="preload"`の採用率をCrUXランクで区分した棒グラフです。モバイルの上位1,000サイトで44.2%、デスクトップでは44.3%となっています。上位10,000サイトでは、モバイルが43.3％、デスクトップが44.1％。モバイルの上位10万サイトで35.3%、デスクトップでは35.7%となっています。モバイルの上位100万サイトで27.2%、デスクトップでは27.3%。モバイルで全サイトの22.1%、デスクトップでは22.0%となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=291501434&format=interactive",
  sheets_gid="1880502987",
  sql_file="hints_adoption_by_rank.sql"
  )
}}

[ランク](./methodology#chrome-ux-report)でデータを分割すると、採用率が顕著に変化し、`preload`ヒントはデータセット全体の22.1%から、上位1000サイトでは44.3%の採用率でトップに立っていることが観察されます。

{{ figure_markup(
  image="rel-dns-prefetch-adoption-by-rank.png",
  caption='`rel="dns-prefetch"`の採用状況をCrUXランクで区分したもの。',
  description='`rel="dns-prefetch"`の採用率をCrUXランクで区分した棒グラフです。`rel="dns-prefetch"`は、モバイルの上位1,000サイトで28.6%、デスクトップでは28.2%となっています。上位10,000サイトは、モバイルが25.5%、デスクトップは25.3%となっています。上位10万サイトは、モバイルで22.9%、デスクトップでは22.7%となっています。上位100万サイトでは、モバイルでは27.0％、デスクトップでは27.1％となっています。モバイルの全サイトでは36.4%、デスクトップで35.7%となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1340595902&format=interactive",
  sheets_gid="1880502987",
  sql_file="hints_adoption_by_rank.sql"
  )
}}

上位1,000サイトと全体の導入状況を比較すると、`dns-prefetch`が唯一の導入減少を示すリソースヒントであることがわかります。

{{ figure_markup(
  image="rel-preconnect-adoption-by-rank.png",
  caption='`rel="preconnect"`のCrUXランク別採用状況。',
  description='`rel="preconnect"`の採用率をCrUXランクで区分した棒グラフです。モバイルの上位1,000サイトでは29.7%、デスクトップは29.0%となっています。上位10,000サイトでは、モバイルが24.9%、デスクトップは24.9%となっています。上位10万サイトでは、モバイルが18.2%、デスクトップは18.4%となっています。上位100万サイトのモバイルでは13.6%、デスクトップは13.7%となっています。モバイルの全サイトでは12.7%、デスクトップは12.9%となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1818271680&format=interactive",
  sheets_gid="1880502987",
  sql_file="hints_adoption_by_rank.sql"
  )
}}

この減少に対抗するため、上位1,000ページでは `preconnect` ヒントの採用が増加し、その性能向上と幅広いサポートを活用しています。今後、他のインターネットサイトがこれに追随することで、`preconnect`の採用が増加し続けるものと思われます。

### 使用方法

リソースヒントは、正しく使用すれば非常に効果的です。ブラウザから開発者に責任を移すことで、重要なレンダリングパスに必要なリソースを優先し、ロード時間やユーザー体験を向上させることができます。

<figure>
<table>
  <thead>
    <tr>
      <th>ランク</th>
      <th>`pre`&shy;`load`</th>
      <th>`pre`&shy;`fetch`</th>
      <th>`pre`&shy;`connect`</th>
      <th>`pre`&shy;`render`</th>
      <th>`dns-prefetch`</th>
      <th>`module`&shy;`preload`</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="numeric">1,000</td>
      <td class="numeric">3</td>
      <td class="numeric">2</td>
      <td class="numeric">4</td>
      <td class="numeric">0</td>
      <td class="numeric">4</td>
      <td class="numeric">1</td>
    </tr>
    <tr>
      <td class="numeric">10,000</td>
      <td class="numeric">3</td>
      <td class="numeric">1</td>
      <td class="numeric">4</td>
      <td class="numeric">1</td>
      <td class="numeric">3</td>
      <td class="numeric">1</td>
    </tr>
    <tr>
      <td class="numeric">100,000</td>
      <td class="numeric">2</td>
      <td class="numeric">2</td>
      <td class="numeric">3</td>
      <td class="numeric">1</td>
      <td class="numeric">3</td>
      <td class="numeric">1</td>
    </tr>
    <tr>
      <td class="numeric">1,000,000</td>
      <td class="numeric">2</td>
      <td class="numeric">2</td>
      <td class="numeric">2</td>
      <td class="numeric">1</td>
      <td class="numeric">2</td>
      <td class="numeric">1</td>
    </tr>
    <tr>
      <td class="numeric">all</td>
      <td class="numeric">2</td>
      <td class="numeric">2</td>
      <td class="numeric">1</td>
      <td class="numeric">1</td>
      <td class="numeric">2</td>
      <td class="numeric">1</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption='1ページあたりのリソースヒントの数のランク別中央値。', sheets_gid="528380369", sql_file="resource_hints_distribution_by_rank.sql") }}</figcaption>
</figure>

リソースヒントを使用しているサイトのうち、上位1,000サイトの中央値をコーパス全体と比較すると、上位のサイトほどページあたりのリソースヒントの数が、多いことがわかる。上位1,000サイトで合計0回しか出現していない`prerender`は、異なるパターンを観察する唯一のヒントです。

## コアウェブバイタルとの相関

{{ figure_markup(
  image="correlation-of-good-cwv-and-preload.png",
  caption='良好なCWVスコアと`rel="preload"`ヒントの数との相関関係',
  description='良いCWVスコアを持つページ数と、そのページ上の `rel="preload"` ヒントの数を示す、傾向線のある散布図。デスクトップページの30.8%、モバイルページの23.0%はプリロードヒントが0個で、良いCWVスコアを持っています。プリロード・ヒントが20個あるデスクトップ・ページの25.1%とモバイル・ページの18.2%が、良いCWVスコアを持っています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=450137807&format=interactive",
  sheets_gid="2032682744",
  sql_file="correlation_cwv_preload.sql"
  )
}}

CrUXデータセットにおけるページの <a hreflang="ja" href="https://web.dev/i18n/ja/vitals/">コアウェブ・バイタル</a> のスコアとプリロード リソースヒントの使用を組み合わせることにより、リンク要素の数とCWVで良い評価を得たページの割合の間に負の相関関係を観察することができました。プリロードヒントが少ないページは、良い評価を受けやすいと言えます。

{{ figure_markup(
  image="correlation-of-good-lcp-and-preload.png",
  caption='良いLCPスコアと`rel="preload"`ヒントの数との相関関係',
  description='LCPスコアが高いページの数と、そのページの `rel="preload"` ヒントの数を示す、傾向線付きの散布図です。プリロード・ヒントが0個のデスクトップ・ページの49.0%、モバイル・ページの37.2%が良いLCPスコアを持っています。プリロード・ヒントが20個あるデスクトップ・ページの42.8%、モバイル・ページの31.1%が、良いLCPスコアを持っています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1720796384&format=interactive",
  sheets_gid="2032682744",
  sql_file="correlation_cwv_preload.sql"
  )
}}

この現象は、ページのLCPにも見られ、多くの場合、開発者はLCP要素のレンダリングに必要のないリソースを優先させ、その結果、ユーザー体験を低下させていることがわかります。

これは、プリロードヒントがあるとページが遅くなることを証明するものではありませんが、多くのヒントを持つことは、パフォーマンスが低下することと相関しています。しかし、多くの場合、プリロードされるリソースの数は少なくし、リソースの優先順位付けは可能な限りブラウザに委ねるべきです。

<p class="note">注: ヒントの数だけでなく、プリロードされる各リソースのサイズもウェブサイトのパフォーマンスに影響を及ぼします。上図では、プリロードされた各リソースのサイズは考慮されていません。</p>

## `rel="preload"`

とはいえ、より多くのウェブサイトが `preload` を採用することが予想されるため、preloadリソースヒントをよりよく見て、なぜそれが効果的でありながら同時に誤用されやすいのかを理解しましょう。

### `as` 属性

`as` 属性は、 `rel="preload"` (または `rel="prefetch"`) を使用して、ダウンロードするリソースの種類を指定するときに指定する必要があります。正しい `as` 属性を適用することで、ブラウザはより正確にリソースの優先順位を決定できます。たとえば、`preload as="script"` は低または中の優先順位になり、`preload as="style"` は内部リクエストの優先順位が _最高_ になります。`as` 属性は、今後のリクエストに備えてリソースをキャッシュし、正しい <a hreflang="en" href="https://developer.mozilla.org/docs/Web/HTTP/CSP">コンテンツセキュリティポリシー</a> を適用するために必要です。

{{ figure_markup(
  image="preload-as-attribute-values.png",
  caption='`rel="preload" as` の属性値です。',
  description='rel="preload "の値の使用状況を示す棒グラフ。scriptはモバイルで54.6%、デスクトップでは54.5%の割合で使用されています。フォントはモバイルで21.9%、デスクトップでは23.5%、スタイルはモバイルで10.9%、デスクトップでは11.3%が使用されています。fetchはモバイルで9.4%、デスクトップでは7.5%使用され、imageはモバイルで2.8%、デスクトップでは2.8%使用されています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1844544440&format=interactive",
  sheets_gid="1246058294",
  sql_file="hint_attribute_usage.sql"
  )
}}

#### `script`

`script` はかなりの差をつけてもっとも一般的な値です。`<script>` 要素は最初のHTML文書に埋め込まれるため、通常は早期に発見されますが、 `<body>` タグを閉じる前に `<script>` 要素を配置するのが一般的なやり方となっています。HTMLは順次解析されるため、DOMがダウンロードされ解析された後にスクリプトが発見されることになり、JavaScriptフレームワークに依存するWebサイトが増えたことで、JavaScriptを早期に読み込む必要性が高まっています。しかしJavaScriptのリソースは、画像やスタイルシートなど、HTML文書内で発見された他のリソースよりも優先されるため、ユーザー体験が、損なわれる可能性があります。

#### `font`

2番目によくプリロードされるリソースは `font` です。ブラウザはレイアウトフェーズの後に、そのフォントがページ上に表示されることが分かってはじめてフォントファイルをダウンロードするので、これは発見が遅れたリソースと言えます。

#### `style`

スタイルシートは通常ドキュメントの `<head>` に埋め込まれ、ドキュメントのパース中、早期に発見されます。さらに、スタイルシートはレンダーブロッキングリソースであるため、リクエスト優先度が _最高_ に割り当てられています。これにより、スタイルシートのプリロードは不要になるはずですが、リクエストの再優先が必要な場合もあります。Google Chromeの <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=629420">バグ</a>（Chrome95で修正）は、プリロードスキャナーが検出した、CSSファイルなどの優先度の高いリソースよりも、プリロードしたリソースを優先して使用します。スタイルシートをプリロードすると、その優先順位は _最高_ に戻されます。スタイルシートがプリロードされるもう1つの例は、HTMLドキュメントから直接ダウンロードされない場合です。たとえば、<a hreflang="en" href="https://www.filamentgroup.com/lab/async-css.html">非同期CSS</a>ハックは `onload` イベントを使って、重要ではないCSSによるページのレンダーブロックを回避するものです。

#### `fetch`

プリロードは、JSONレスポンスやストリームなど、ページのレンダリングに重要なデータを取得するためのリクエストを開始するために使用できます。

#### `image`

CSSの `background-image` のように、画像が最初のHTMLに含まれていない場合、画像をプリロードすることでLCPスコアを向上させることが、できる場合があります。

### `crossorigin` 属性

`crossorigin` 属性は、要求されたリソースを取得する際に[オリジン間リソース共有](https://developer.mozilla.org/docs/Web/HTTP/CORS) (CORS)を使用しなければならないかどうかを示すために使用されます。これはあらゆるリソースタイプに適用できますが、フォントファイルは常にCORSを使用して要求されるべきなので、もっとも一般的に関連付けられます。

<figure>
  <table>
    <thead>
      <tr>
        <th>値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>未設定</td>
        <td class="numeric">66.6%</td>
        <td class="numeric">65.9%</td>
      </tr>
      <tr>
        <td><code>クロスオリジン</code> (または同等)</td>
        <td class="numeric">14.5%</td>
        <td class="numeric">13.5%</td>
      </tr>
      <tr>
        <td><code>使用許可証</code></td>
        <td class="numeric">&lt; 0.1%</td>
        <td class="numeric">&lt; 0.1%</td>
      </tr>
    </tbody>
  </table>

<figcaption>{{ figure_link(caption='<code>rel="preload" crossorigin</code> 属性の値。', sheets_gid="1246058294", sql_file="hint_attribute_usage.sql") }}</figcaption>
</figure>

#### `anonymous`

値が指定されていない場合のデフォルト値は `anonymous` で、この値では資格情報フラグが <a hreflang="en" href="https://developer.mozilla.org/docs/Web/Security/Same-origin_policy">`same-origin`</a> に設定されます。CORSで保護されたリソースをダウンロードする際に必要です。また、フォント ファイルをダウンロードする際の <a hreflang="en" href="https://drafts.csswg.org/css-fonts/#font-fetching-requirements">必須条件</a>でもあります、たとえそれが同じオリジンであってもです！プリロードされたリソースに対する最終的なリクエストがCORSを使用しているときに `crossorigin` 属性を省略すると、プリロードキャッシュでマッチしないため、重複したリクエストになってしまいます。

#### `use-credentials`

たとえば、クッキー、クライアント証明書、`Authorization`ヘッダーなどの使用により、認証を必要とするクロスオリジンリソースを要求する場合。`crossorigin="use-credentials"` 属性を設定すると、このデータをリクエストに含め、サーバーがリクエストに応答して、リソースをプリロードできるようにします。これは0.1%の使用率で一般的なシナリオではありませんが、ページのコンテンツが認証状態に依存している場合、ログイン状態を取得するために早期フェッチリクエストを開始するために使用できます。

### `media` 属性

`rel="preload"` の機能として、メディアクエリを `media` 属性で指定できますが、この属性を使っているプリロードは全体の4%未満です。`media` 属性はメディアクエリを受け付け、メディアタイプやビューポート幅のような特定のブラウザ機能をターゲットにできます。たとえば、`media`属性を使えば、ビューポートが狭いデバイスには低解像度の画像を、ビューポートが大きいデバイスにはフルサイズの画像をあらかじめ読み込ませることができます。

`media` 属性に加えて、 `<link>` 要素は `imagesrcset` と `imagesizes` 属性をサポートしています。これは、 `<img>` 要素の `srcset` と `sizes` 属性に対応するものです。これらの属性を使用すると、画像に使用するのと同じリソースの選択基準を使用できます。残念ながら、その採用率は非常に低く（1％未満）、Safariの<a hreflang="en" href="https://caniuse.com/mdn-html_elements_link_imagesizes">サポート</a>がないためと思われます。

<p class="note">注: `media` 属性は、仕様にあるようにすべての `<link>` 要素で利用できるわけではなく、 `rel="preload"` にのみ利用できます。</p>

### 悪い習慣

`rel="preload"` の多用途性により、preloadヒントの実装方法を規定する明確なルールはありませんが、失敗から多くを学び、それを回避する方法を理解することは可能です。

#### 未使用のプリロード

Webサイトのパフォーマンスとプリロードヒントの数には、負の相関があることをすでに見てきました。この関係には、2つの要因が影響している可能性があります。
- 不適切なプリロード
- 未使用のプリロード

不正なプリロードとは、ブラウザが優先するはずの他のリソースよりも重要でないリソースをプリロードした場合を指します。ヒントを表示した場合と表示しない場合のA/Bテストが必要なため、不正なプリロードの程度を測定することはできません。

未使用のプリロードは、ページを読み込んでから数秒以内に必要のないリソースをプリロードした場合に発生します。

{{ figure_markup(
  caption='最初の3秒間で未使用のプリロードヒントのパーセンテージ。',
  content="21.5%",
  classes="big-number",
  sheets_gid="2013605735",
  sql_file="consoleLog_unused_preload.sql"
)
}}

このような場合、すぐに必要でない、あるいはまったく必要でないファイルやリソースをダウンロードし、優先的に使用するようブラウザに指示しているため、プリロードヒントはウェブサイトのパフォーマンスを低下させることになります。リソースヒントは定期的なメンテナンスが必要であり、プロセスを自動化すると、このような問題が、発生する可能性があります。

#### 不正確な `crossorigin` 属性

正しい `crossorigin` 属性を含めずにCORS対応のリソースをプリロードしようとすると、同じリソースを2回ダウンロードすることになります。最終的なリクエストでもCORSを使用する場合は、`<link>` 要素に `crossorigin` 属性が必要です。これは、同じオリジンでフォントファイルをセルフホストしている場合でも、フォントファイルは常にCORSが有効であるとして扱われるため、フォントファイルをリクエストする場合にも当てはまります。

{{ figure_markup(
  image="incorrect-crossorigin-attribute-by-file-extension.png",
  caption='モバイル端末において、ファイル拡張子ごとに区分したクロスオリジン値の不正確さの割合。',
  description='モバイル端末のファイル拡張子ごとに区分したクロスオリジン値の不正確さの割合を示す円グラフ。`woff2`は29.9%の可能性があります。`woff` 19.1%です。`js`は9.9%の可能性があります。`css` 7.6%です。`gif` 7.2%です。 fonts.googleapis.com 7.1%です。`png`は6.9%の可能性があります。`ttf` 6.6%です。`jpg`は2.0%の可能性があります。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=277634745&format=interactive",
  sheets_gid="699889350",
  sql_file="consoleLog_incorrect_crossorigin_type.sql"
  )
}}

`rel="preload"` ヒントの `crossorigin` 属性が見つからないか不正確な場合の半数以上 (63.6%) は、フォントファイルのプリロードに関連しており、データセット全体で合計14,818インスタンスになります。

#### 無効な `as` 属性

`as` 属性はリソースをプリロードする際に重要な役割を果たします。これを間違えると、同じリソースを2回ダウンロードすることになるかもしれません。ほとんどのブラウザでは、認識できない `as` 属性を指定すると、プリロードが無視されます。サポートされている値は `audio`、`document`、`embed`、`fetch`、`font`、`image`、`object`、`script`、`style`、`track`、`worker` および `video` です。

認識できない値は17,861件あり、もっとも多い誤りは完全に省略することです。一方、値としてもっとも多い無効なものは `other` と `stylesheet` です（正しい値は `style` です）。

{{ figure_markup(
  caption='ページで `"style"` の代わりに `as="stylesheet"` が誤って使用されていた。',
  content="1,114",
  classes="big-number",
  sheets_gid="1681733418",
  sql_file="consoleLog_unused_preload.sql"
)
}}

正しくない `as` 属性値（たとえば `script` の代わりに `style` を使用するような認識できない値）を使用すると、ブラウザはプリロードキャッシュに保存されているリソースと一致しないため、ファイルのダウンロードを重複して行うことになります。

<p class="note">注: <code>video</code>は仕様に含まれていますが、どのブラウザでもサポートされていないため、無効な値として扱われ、無視されるでしょう。</p>

#### 未使用のフォントファイル

フォントファイルをプリロードするページの5%以上が、必要以上のフォントファイルをプリロードしています。フォントファイルをプリロードする場合、`preload` をサポートしているすべてのブラウザは `.woff2` もサポートしています。つまり、`.woff2`のフォントファイルが利用可能であると仮定すると、`.woff`を含む古い形式のフォントをプリロードする必要はありません。

## サードパーティ

リソースヒントを使用して、ファーストパーティとサードパーティの両方に接続したり、リソースをダウンロードしたりできます。`dns-prefetch` と `preconnect` はサブドメインを含む異なるオリジンへの接続時にのみ有効ですが、 `preload` と `prefetch` は同じオリジンのリソースとサードパーティーがホストするリソースの両方に使用できます。

サードパーティーのリソースにどのリソースヒントを使用するかを検討する際には、アプリケーションのロード体験における各サードパーティーの優先順位と役割、およびコストが正当化されるかどうかを評価する必要があります。

自社のコンテンツよりも第三者のリソースを優先させることは、潜在的に警告のサインですが、これが推奨される場合もあります。たとえばEUでは <a href="https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87">一般データ保護規則</a> によって要求されているCookie通知スクリプトを見ると、これらは通常 `dns-prefetch` または `preconnect` ヒントを伴っており、ユーザー体験に非常に邪魔である上、パーソナライズした広告の配信など、一部のサイト機能にとって必要不可欠なものだからです。

<figure>
  <table>
  <thead>
    <tr>
      <th>ホスト</th>
      <th>`dns-prefetch`</th>
      <th>`preconnect`</th>
      <th>`preload`</th>
      <th>合計</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>adservice.google.com</td>
      <td class="numeric">0.2%</td>
      <td class="numeric">0.5%</td>
      <td class="numeric">35.7%</td>
      <td class="numeric">36.4%</td>
    </tr>
    <tr>
      <td>fonts.gstatic.com</td>
      <td class="numeric">0.9%</td>
      <td class="numeric">24.0%</td>
      <td class="numeric">0.6%</td>
      <td class="numeric">25.5%</td>
    </tr>
    <tr>
      <td>fonts.googleapis.com</td>
      <td class="numeric">14.0%</td>
      <td class="numeric">4.5%</td>
      <td class="numeric">2.7%</td>
      <td class="numeric">21.2%</td>
    </tr>
    <tr>
      <td>s.w.org</td>
      <td class="numeric">19.7%</td>
      <td class="numeric">0.2%</td>
      <td class="numeric">-</td>
      <td class="numeric">19.9%</td>
    </tr>
    <tr>
      <td>cdn.shopify.com</td>
      <td class="numeric">-</td>
      <td class="numeric">1.7%</td>
      <td class="numeric">9.6%</td>
      <td class="numeric">11.2%</td>
    </tr>
    <tr>
      <td>siteassets.parastorage.com</td>
      <td class="numeric">-</td>
      <td class="numeric">-</td>
      <td class="numeric">5.9%</td>
      <td class="numeric">5.9%</td>
    </tr>
    <tr>
      <td>
        www.google-analytics.com
      </td>
      <td class="numeric">1.2%</td>
      <td class="numeric">3.9%</td>
      <td class="numeric">0.2%</td>
      <td class="numeric">5.3%</td>
    </tr>
    <tr>
      <td>
          www.googletagmanager.com
      </td>
      <td class="numeric">1.9%</td>
      <td class="numeric">2.7%</td>
      <td class="numeric">0.2%</td>
      <td class="numeric">4.8%</td>
    </tr>
    <tr>
      <td>static.parastorage.com</td>
      <td class="numeric">-</td>
      <td class="numeric">-</td>
      <td class="numeric">4.7%</td>
      <td class="numeric">4.7%</td>
    </tr>
    <tr>
      <td>ajax.googleapis.com</td>
      <td class="numeric">2.2%</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">0.3%</td>
      <td class="numeric">4.1%</td>
    </tr>
    <tr>
      <td>www.google.com</td>
      <td class="numeric">2.7%</td>
      <td class="numeric">1.0%</td>
      <td class="numeric">0.1%</td>
      <td class="numeric">3.8%</td>
    </tr>
    <tr>
      <td>images.squarespace-cdn.com</td>
      <td class="numeric">-</td>
      <td class="numeric">3.5%</td>
      <td class="numeric">-</td>
      <td class="numeric">3.5%</td>
    </tr>
    <tr>
      <td>cdnjs.cloudflare.com</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">1.0%</td>
      <td class="numeric">0.4%</td>
      <td class="numeric">2.9%</td>
    </tr>
    <tr>
      <td>monorail-edge.shopifysvc.com</td>
      <td class="numeric">2.0%</td>
      <td class="numeric">0.8%</td>
      <td class="numeric">-</td>
      <td class="numeric">2.8%</td>
    </tr>
    <tr>
      <td>fonts.shopifycdn.com</td>
      <td class="numeric">-</td>
      <td class="numeric">1.1%</td>
      <td class="numeric">1.0%</td>
      <td class="numeric">2.1%</td>
    </tr>
  </tbody>
</table>


<figcaption>{{ figure_link(caption="モバイル端末でリソースヒントを使用しているもっとも普及しているサードパーティ接続。", sheets_gid="1254656281", sql_file="preload_host_by_url.sql") }}</figcaption>
</figure>

上の表を分析すると、`preload` ヒントを含む全ページの36.7%がadservice.google.comでホストされているリソースをプリロードしています。s.w.orgホストは `dns-prefetch` でもっとも普及しているドメインで、WordPressサイト（バージョン4.6以降）で、ブラウザがネイティブの絵文字をサポートしていないと検出された場合にTwemoji CDNからのSVG画像を読み込むために使用されています。Google Fonts関連のサービスでは、`fonts.gstatic.com` と `fonts.googleapis.com` が `preconnect` ディレクティブを使用するホストとしてもっとも普及しているようです。

{{ figure_markup(
  image="google-fonts.png",
  alt="Google Fontsのフォントを埋め込むための手順",
  caption='Google Fontsの説明では、fonts.gstatic.comとfonts.googleapis.comへ事前接続するようになっています。（出典: <a hreflang="en" href="https://fonts.google.com/">Google Fonts</a>）',
  description='「ウェブで使う」というタイトルのコードスニペットで、「フォントを埋め込むには、htmlの`<head>`内にコードをコピーしてください」というサブタイトルが付いています。コードスニペットの内容は、`<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">`となります。',
  width=268,
  height=255
  )
}}

Google Fontsは現在、fonts.gstatic.com originとfonts.googleapis.comの両方に `preconnect` するように指示します。これは通常、発見が遅れたリソースの影響を相殺する良い習慣です。

サードパーティのあり方について詳しく知りたい方は、[サードパーティ](./third-parties)の章をご覧ください。

## ネイティブ遅延ローディング

遅延ローディングとは、リソース（この場合は画像やiframe）のダウンロードを、それが必要になるまで、あるいはビューポート内で見えるようになるまで延期する技術のことを指します。ネイティブ遅延ローディングは、これを処理するためにJavaScriptライブラリを使用するのではなく、HTMLで `loading="lazy"` 属性を使用して指定できることを指します。画像とiframeのネイティブ遅延ローディングは2019年に標準化され、それ以来、その採用は、とくに画像について飛躍的に伸びています。

画像の `loading="lazy"` は、ほとんどの主要なブラウザでサポートされています。Safariでは、<a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=200764">進行中</a> と表示され、フラグの後ろに表示されて利用できますが、まだデフォルトでは有効ではありません。

iframeの遅延ロードはChromeでサポートされ、Safariでは再びフラグの背後にありますが、<a hreflang="en" href="https://bugzilla.mozilla.org/show_bug.cgi?id=1622090">Firefoxではまだサポートされていません</a> 。

`loading` 属性をサポートしていないブラウザは、この属性を無視しますから、不要な副作用なしに安全に追加できます。JavaScriptベースの代替品、たとえば<a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes</a>はまだ使えるかもしれませんが、ブラウザのフルサポートが間近であることを考えると、この段階でプロジェクトに追加する価値はないかもしれません。

{{ figure_markup(
  image="adoption-of-loading-lazy-on-img.png",
  caption='`img` 要素に `loading="lazy"` 属性が設定されているページの割合です。',
  description='デスクトップとモバイルで `img` 要素に `loading="lazy"` 属性が設定されているページの割合を示す時系列です。2019年開始時点では、デスクトップで0％、モバイルで0％の採用率です。2020年開始時点では、デスクトップで0％、モバイルで0％の採用率。2021年開始時点では、デスクトップで14.2％、モバイルで13.5％の採用率です。2021年7月時点では、デスクトップ17.9％、モバイル17.8％となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=1314627953&format=interactive",
  sheets_gid="157636784",
  sql_file="imgLazy.sql"
  )
}}

また、`loading="lazy"`を使用しているページの割合は、2020年の4.2%から、分析時点では17.8%に増加しています。なんと423%もの成長率です。この急成長は驚異的であり、その背景には2つの重要な要素があると思われます。クロスブラウザーに対応したページへの追加が容易であること、そしてこれらのウェブサイトを支えているフレームワークや技術です。WordPress 5.5では<a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">lazy-loading imagesがデフォルトの実装となり</a>、 `loading="lazy"` の採用率は急上昇し、WordPressサイトでは、ネイティブ画像の遅延ロードを使用するページ全体の <a hreflang="en" href="https://web.dev/articles/lcp-lazy-loading">84%</a> が構成されるようになったそうです。

{{ figure_markup(
  image="lazy-loaded-images.png",
  caption='初期ビューポートにある `loading="lazy"` を持つ `img` 要素の割合です。',
  description='`loading="lazy"` の `img` 要素のうち、初期ビューポート内にある割合の棒グラフ。遅延ロードされたイメージの61.5%（モバイル）、63.1%（デスクトップ）が初期ビューポート内に収まっています。遅延ロードされたイメージのうち、モバイルで38.5%、デスクトップでは36.9%が初期ビューポート内にはありません。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTgxCYoH2vDbhTky1qQKEeV034kReHF8JYYq0aDyoo6LG22XL6Tar3dNPsqU1_zyvR6vuFEdMGoF1oP/pubchart?oid=977858704&format=interactive",
  sheets_gid="1468369891",
  sql_file="lazy_viewport_images.sql"
  )
}}

モバイルで遅延ロードされた画像の61.5%、デスクトップで遅延ロードされた画像の63.1%は、実際には初期ビューポート内にあり、遅延ロードされるべきではない画像です。遅延ロードを使用したページのロード時間に関する<a hreflang="en" href="https://web.dev/articles/lcp-lazy-loading">研究</a>によると、遅延ロードを使用したページはLCP性能が、悪化する傾向があり、おそらく遅延ロード属性を使いすぎたことが原因であると指摘されています。これは、遅延ロードされるべきではないLCP要素でますます顕著になります。もしあなたが `loading="lazy"` を使っているなら、遅延ロードされた画像が折り目の下にあるかどうか、さらに決定的なことは、LCP要素が遅延ロードされていないかどうかを確認する必要があります。LCPイメージのレイジーローディングがコアウェブ・バイタルに与える影響については、[パフォーマンス](./performance)の章で詳しく説明しています。

{{ figure_markup(
  caption='`iframe` 要素に `loading="lazy"` 属性が設定されているページの割合です。',
  content="2.6%",
  classes="big-number",
  sheets_gid="1935094298",
  sql_file="native_iframe_lazy_loading.sql"
)
}}

少なくとも1つのiframeを含むページの可能性は、画像を含むページよりもはるかに低く、iframeを含むページのわずか2.6%しかネイティブ遅延ローディングを利用していません。iframeは、スクリプトや画像を含むより多くのリソースをダウンロードするためにさらなるリクエストを開始する可能性があるため、iframeを遅延ロードすることの利点は潜在的に重要です。これは、YouTubeやTwitterの埋め込みなどの埋め込みを使用する場合にとくに当てはまります。同様に、画像の読み込み方法を決定する場合、iframeが初期ビューポート内に表示されているかどうかを確認する必要があります。もし表示されていない場合は、通常、`<iframe>` 要素に `loading="lazy"` を追加することで、初期読み込みを減らし、パフォーマンスを向上させることができるので安全です。

## HTTP/2サーバープッシュ

HTTP/2は _サーバープッシュ_ と呼ばれる技術をサポートしており、クライアントがリクエストすると予想されるリソースを先取りしてプッシュします。サーバーはクライアントにリソースを要求するよう通知する代わりにリソースをプッシュするので、キャッシュ管理が複雑になり、場合によっては、プッシュされたリソースがHTMLの配信を遅らせることさえあります。

残念ながら、HTTP/2プッシュは期待外れでした。ブラウザがすでに持っている、あるいはブラウザが要求するリソースよりも重要度の低いリソースを過剰にプッシュするリスクと比較して、約束したパフォーマンスの向上を提供するという証拠がほとんどないのです。

つまり技術は広く普及しているにもかかわらず、これらの障害を克服するために、普及率が非常に低く、採用率は1％未満にとどまっているのです。Chromeはまた、<a hreflang="en" href="https://lists.w3.org/Archives/Public/ietf-http-wg/2019JulSep/0078.html">削除の意向</a> を提出しました。これは103の初期ヒント（次に説明）のテスト可能な実装が利用可能になるまで一時停止されます。ChromeはHTTP/3でのServer Pushも<a hreflang="en" href="https://github.com/httpwg/http2-spec/issues/786#issuecomment-724371629">サポートしていません</a>。

HTTP、HTTP/2、HTTP/3については、[HTTP](./http)の章に詳しく書かれています。

## 未来

新しい `rel` ディレクティブを追加する提案はありませんが、Chromeの優先順位付け<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=629420">バグ</a>など、現在のリソースヒントのセットに対するブラウザベンダーの改善は、良い影響を与えると期待されます。ヒントの採用が進み、`preload`の用途が本来の目的である発見が遅れたリソースにシフトしていくことが予想されます。

さらに、初期ヒント103と優先順位付けのヒントという2つの提案も近日中に公開される予定で、すでにChromeでは実験的なサポートが提供されています。

### 初期のヒント103

Chrome 95では、`preload`と`preconnect`に対して、<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8297">初期ヒント103</a>を実験的にサポートしました。初期ヒントは、メインレスポンスが提供される前にブラウザがリソースをプリロードすることを可能にし、リクエストが送信されてからサーバーからのレスポンスが送信されるまでのブラウザ上のアイドル時間を利用します。初期ヒント103を使用する場合、サーバーは、実際のドキュメント応答を処理している間に、HTTPヘッダーメソッドを使用してプリロードされるリソースの詳細を示す「情報」レスポンスステータスを直ちに送信します。こうすることで、ブラウザはHTMLが届く前でも、重要なリソースに対してプリロードのリクエストを開始することができ、ドキュメントのマークアップに `<link>` 要素を使用する場合よりもずっと早くプリロードのリクエストを開始することができるようになるのです。初期ヒント103は、HTTP/2サーバープッシュで発生する困難のほとんどを克服しています。

### 優先順位付けのヒント

優先度ヒントは、ページ内のリソースの相対的な重要度をブラウザに通知し、重要なリソースを優先してコアウェブバイタルを向上させることを目的としています。優先度ヒントは、`<img>` や `<script>` などのリソースに `importance` 属性を追加することで、ドキュメントのマークアップを通じて有効になります。`importance` 属性は `high`, `low`, `auto` の列挙を受け付け、これをリソースのタイプと組み合わせることで、ブラウザはヒューリスティックに基づいて最適なフェッチ優先度を割り当てることができるようになります。優先ヒントは、Chrome 96で<a hreflang="en" href="https://developer.chrome.com/blog/origin-trials">オリジン・トライアル</a>として利用できます。

## 結論

この1年間でリソースヒントの採用は拡大し、開発者がこれらのAPIを活用してリソースの優先順位を決め、ユーザーの体験を向上させることから、今後も拡大すると予想されています。同時に、ブラウザベンダーは、これらのディレクティブを調整し、その役割と効果を進化させています。

リソースヒントは、ユーザーにとっての利点を評価しなければ、諸刃の剣になりかねません。プリロード要求のほぼ4分の1は未使用であり、プリロードヒントの数はロード時間の遅さと相関しています。

資源のヒントは、レーシングカーのエンジンの微調整に似ている。遅いエンジンを速くすることはできないし、調整しすぎると壊れてしまう。でも、ちょっとした工夫で、その性能を最大限に引き出すことができる。

もう一度言いますが、リソースヒントには、「すべてが重要なら、何も重要ではない」という考え方があります。リソースヒントは賢く使い、使い過ぎないようにしましょう。
