---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP/2
description: HTTP/2、HTTP/2プッシュ、HTTP/2の問題、およびHTTP/3の採用と影響をカバーするWeb Almanac 2019のHTTP/2章
hero_alt: Hero image of Web Almanac chracters driving vehicles in various lanes carrying script and images resources.
authors: [tunetheweb]
reviewers: [bagder, rmarx, dotjs]
analysts: [paulcalvano]
editors: [rachellcostello]
translators: [ksakae1216]
discuss: 1775
results: https://docs.google.com/spreadsheets/d/1z1gdS3YVpe8J9K3g2UdrtdSPhRywVQRBz5kgBeqCnbw/
tunetheweb_bio: Barry Pollardはソフトウェア開発者であり、Manningの本 <a hreflang="en" href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a> の著者でもあります。彼はウェブは素晴らしいと思っていますが、それをさらに良くしたいと思っています。<a href="https://x.com/tunetheweb">@tunetheweb</a> でツイートしたり、<a hreflang="en" href="https://www.tunetheweb.com">www.tunetheweb.com</a> でブログを書いたりしています。
featured_quote: HTTP/2は、ほぼ20年ぶりになるWebのメイン送信プロトコルの初となるメジャーアップデートでした。それは多くの期待を持って到来し、欠点なしで無料のパフォーマンス向上を約束しました。それ以上に、HTTP/1.1が非効率なため強制されていたすべてのハックや回避策をやめることができました。デフォルトでパフォーマンスが向上するため、ドメインのバンドル、分割、インライン化、さらにはシャーディングなどはすべてHTTP/2の世界でアンチパターンになります。
featured_stat_1: 95%
featured_stat_label_1: HTTP/2を使用できるグローバルユーザーの割合。
featured_stat_2: 27.83%
featured_stat_label_2: 準最適なHTTP/2優先順位付けによるモバイル要求の割合。
featured_stat_3: 8.38%
featured_stat_label_3: QUICをサポートするモバイルサイトの割合。
---

## 導入
HTTP/2は、ほぼ20年ぶりになるWebのメイン送信プロトコルの初となるメジャーアップデートでした。それは多くの期待を持って到来し、欠点なしで無料のパフォーマンス向上を約束しました。それ以上に、HTTP/1.1が非効率なため強制されていたすべてのハックや回避策をやめることができました。デフォルトでパフォーマンスが向上するため、ドメインのバンドル、分割、インライン化、さらにはシャーディングなどはすべてHTTP/2の世界でアンチパターンになります。

これは、[Webパフォーマンス](./performance)に集中するスキルとリソースを持たない人でも、すぐにパフォーマンスの高いWebサイトにできます。しかし現実はほぼ相変わらずです。 2015年5月に<a hreflang="en" href="https://tools.ietf.org/html/rfc7540">RFC 7540</a>で標準としてHTTP/2に正式承認されてから4年以上経過してます。ということでこの比較的新しい技術が現実の世界でどのように発展したかを見てみる良い機会です。

## HTTP/2とは?
この技術に精通していない人にとって、この章のメトリックと調査結果を最大限に活用するには、ちょっとした背景が役立ちます。最近までHTTPは常にテキストベースのプロトコルでした。 WebブラウザーのようなHTTPクライアントがサーバーへのTCP接続を開き、`GET /index.html`のようなHTTPコマンドを送信して、リソースを要求します。

これは*HTTPヘッダー*を追加するためにHTTP/1.0で拡張されました、なのでリクエストに加えてブラウザの種類、理解できる形式などさまざまなメタデータを含めることができます。これらのHTTPヘッダーもテキストベースであり改行文字で区切られていました。サーバーは、要求とHTTPヘッダーを1行ずつ読み取ることで着信要求を解析し、サーバーは要求されている実際のリソースに加えて独自のHTTP応答ヘッダーで応答しました。

プロトコルはシンプルに見えましたが制限もありました。 なぜならHTTPは本質的に同期であるため、HTTP要求が送信されると応答が返され、読み取られ、処理されるまでTCP接続全体が基本的に他のすべてに対して制限されていました。これは非常に効率が悪く、限られた形式の並列化を可能にするため複数のTCP接続（ブラウザーは通常6接続を使用）が必要でした。

特に暗号化を設定するための追加の手順を必要とするHTTPSを使用する場合、TCP接続は設定と完全な効率を得るのに時間とリソースを要するため、それ自体に問題が生じます。 HTTP/1.1はこれを幾分改善し、後続のリクエストでTCP接続を再利用できるようにしましたが、それでも並列化の問題は解決しませんでした。

HTTPはテキストベースですが、実際、少なくとも生の形式でテキストを転送するために使用されることはほとんどありませんでした。 HTTPヘッダーがテキストのままであることは事実でしたが、ペイロード自体しばしばそうではありませんでした。 [HTML](./markup)、[JS](./javascript)、[CSS](./css)などのテキストファイルは通常、Gzip、Brotliなどを使用してバイナリ形式に転送するため[圧縮](./compression)されます。[画像や動画](./media) などの非テキストファイルは、独自の形式で提供されます。その後、[セキュリティ](./security)上の理由からメッセージ全体を暗号化するために、HTTPメッセージ全体がHTTPSでラップされることがよくあります。

そのため、Webは基本的に長い間テキストベースの転送から移行していましたが、HTTPは違いました。この停滞の1つの理由は、HTTPのようなユビキタスプロトコルに重大な変更を導入することが非常に困難だったためです（以前努力しましたが、失敗しました）。多くのルーター、ファイアウォール、およびその他のミドルボックスはHTTPを理解しており、HTTPへの大きな変更に対して過剰に反応します。それらをすべてアップグレードして新しいバージョンをサポートすることは、単に不可能でした。

2009年に、Googleは<a hreflang="en" href="https://www.chromium.org/spdy">SPDY</a>と呼ばれるテキストベースのHTTPに代わるものへ取り組んでいると発表しましたが、SPDYは非推奨です。これはHTTPメッセージがしばしばHTTPSで暗号化されるという事実を利用しており、メッセージが読み取られ途中で干渉されるのを防ぎます。

Googleは、最も人気のあるブラウザー（Chrome）と最も人気のあるWebサイト（Google、YouTube、Gmailなど）の1つを制御しました。 Googleのアイデアは、HTTPメッセージを独自の形式にパックし、インターネット経由で送信してから反対側でアンパックすることでした。独自の形式であるSPDYは、テキストベースではなくバイナリベースでした。これにより、単一のTCP接続をより効率的に使用できるようになり、HTTP/1.1で標準になっていた6つの接続を開く必要がなくなりHTTP/1.1の主要なパフォーマンス問題の一部が解決しました。

現実の世界でSPDYを使用することで、ラボベースの実験結果だけでなく、実際のユーザーにとってより高性能であることを証明できました。すべてのGoogle WebサイトにSPDYを展開した後、他のサーバーとブラウザーが実装を開始し、この独自の形式をインターネット標準に標準化するときが来たため、HTTP/2が誕生しました。

HTTP/2には次の重要な概念があります。

* バイナリ形式
* 多重化
* フロー制御
* 優先順位付け
* ヘッダー圧縮
* プッシュ

**バイナリ形式**とは、HTTP/2メッセージが事前定義された形式のフレームに包まれることを意味しHTTPメッセージの解析が容易になり、改行文字のスキャンが不要になります。これは、以前のバージョンのHTTPに対して多くの<a hreflang="en" href="https://www.owasp.org/index.php/HTTP_Response_Splitting">脆弱性</a>があったため、セキュリティにとってより優れています。また、HTTP/2接続を**多重化**できることも意味します。各フレームにはストリーム識別子とその長さが含まれているため、異なるストリームの異なるフレームを互いに干渉することなく同じ接続で送信できます。多重化により、追加の接続を開くオーバーヘッドなしで、単一のTCP接続をより効率的に使用できます。理想的にはドメインごと、または<a hreflang="en" href="https://daniel.haxx.se/blog/2016/08/18/http2-connection-coalescing/">複数のドメイン</a>に対しても単一の接続を開きます！

個別のストリームを使用すると、潜在的な利点とともにいくつかの複雑さが取り入れられます。 HTTP/2は異なるストリームが異なるレートでデータを送信できるようにする**フロー制御**の概念を必要としますが、以前応答は1つに1つだけで、これはTCPフロー制御によって接続レベルで制御されていました。同様に、**優先順位付け**では複数のリクエストを一緒に送信できますが、最も重要なリクエストではより多くの帯域幅を取得できます。

最後に、HTTP/2には、**ヘッダー圧縮**と**HTTP/2プッシュと**いう2つの新しい概念が導入されました。ヘッダー圧縮により、セキュリティ上の理由からHTTP/2固有の<a hreflang="en" href="https://tools.ietf.org/html/rfc7541">HPACK</a>形式を使用して、これらのテキストベースのHTTPヘッダーをより効率的に送信できました。 HTTP/2プッシュにより、要求への応答として複数の応答を送信できるようになり、クライアントが必要と認識する前にサーバーがリソースを「プッシュ」できるようになりました。プッシュは、CSSやJavaScriptなどのリソースをHTMLに直接インライン化して、それらのリソースが要求されている間、ページが保持されないようにするというパフォーマンスの回避策を解決することになっています。 HTTP/2を使用するとCSSとJavaScriptは外部ファイルとして残りますが、最初のHTMLと共にプッシュされるため、すぐに利用できました。これらのリソースはキャッシュされるため後続のページリクエストはこれらのリソースをプッシュしません。したがって、帯域幅を浪費しません。

急ぎ足で紹介したこのHTTP/2は、新しいプロトコルの主な歴史と概念を提供します。この説明から明らかなように、HTTP/2の主な利点は、HTTP/1.1プロトコルのパフォーマンス制限に対処することです。また、セキュリティの改善も行われました。恐らく最も重要なのは、HTTP/2以降のHTTPSを使用するパフォーマンスの問題に対処することです、HTTPSを使用しても<a hreflang="en" href="https://www.httpvshttps.com/">通常のHTTPよりもはるかに高速</a>です。 HTTPメッセージを新しいバイナリ形式に包むWebブラウザーと、反対側でWebサーバーがそれを取り出す以外は、HTTP自体の中核的な基本はほぼ同じままでした。これは、ブラウザーとサーバーがこれを処理するため、WebアプリケーションがHTTP/2をサポートするために変更を加える必要がないことを意味します。オンにすることで、無料でパフォーマンスを向上させることができるため、採用は比較的簡単です。もちろん、Web開発者がHTTP/2を最適化して、その違いを最大限に活用する方法もあります。

## HTTP/2の採用
前述のように、インターネットプロトコルはインターネットを構成するインフラストラクチャの多くに深く浸透しているため、しばしば採用を難しくする事があります。これにより、変更の導入が遅くなり、困難になります。たとえば、IPv6は20年前から存在していますが、<a hreflang="en" href="https://www.google.com/intl/en/ipv6/statistics.html">採用に苦労しています。</a>

{{ figure_markup(
  caption="HTTP/2を使用できるグローバルユーザーの割合。",
  content="95%",
  classes="big-number"
)
}}

ただし、HTTP/2はHTTPSで事実上隠されていたため異なってました（少なくともブラウザーの使用例では）、ブラウザーとサーバーの両方がサポートしている限り、採用の障壁を取り除いてきました。ブラウザーのサポートはしばらく前から非常に強力であり、*最新バージョン*へ自動更新するブラウザーの出現により、<a hreflang="en" href="https://caniuse.com/#feat=http2">グローバルユーザーの推定95％がHTTP/2をサポートするようになりました</a>。

私たちの分析は、Chromeブラウザで約500万の上位デスクトップおよびモバイルWebサイトをテストするHTTP Archiveから提供されています。([方法論](./methodology)の詳細をご覧ください。)

{{ figure_markup(
  image="ch20_fig2_http2_usage_by_request.png",
  caption='要求によるHTTP/2の使用。(引用: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="2019年7月現在、デスクトップとモバイルの両方で55％採用されているHTTP/2使用の時系列チャート。傾向は年間約15ポイントで着実に増加しています。",
  width=600,
  height=321
  )
}}

結果は、HTTP/2の使用が、現在過半数のプロトコルであることを示しています。これは、正式な標準化からわずか4年後の目覚しい偉業です。要求ごとのすべてのHTTPバージョンの内訳を見ると、次のことがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocol</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td class="numeric">5.60%</td>
        <td class="numeric">0.57%</td>
        <td class="numeric">2.97%</td>
      </tr>
      <tr>
        <td>HTTP/0.9</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">40.36%</td>
        <td class="numeric">45.01%</td>
        <td class="numeric">42.79%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">53.96%</td>
        <td class="numeric">54.37%</td>
        <td class="numeric">54.18%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="要求によるHTTPバージョンの使用。") }}</figcaption>
</figure>

図20.3は、HTTP/1.1およびHTTP/2が、予想どおり大部分の要求で使用されるバージョンであることを示しています。古いHTTP/1.0とHTTP/0.9プロトコルでは、ごく少数のリクエストしかありません。面倒なことに、特にデスクトップでHTTP Archiveクロールによってプロトコルは正しく追跡されなかった割合が大きくなっています。これを掘り下げた結果、さまざまな理由が示され、そのいくつかは説明できますが、いくつかは説明できません。スポットチェックに基づいて、それらは概ねHTTP/1.1リクエストであるように見え、それらを想定するとデスクトップとモバイルの使用は似ています。

私たちが望むよりもノイズの割合が少し大きいにもかかわらず、ここで伝えられるメッセージ全体を変えることはしません。それ以外、モバイル/デスクトップの類似性は予想外ではありません。 HTTP Archiveは、デスクトップとモバイルの両方でHTTP/2をサポートするChromeでテストします。実際の使用状況は、両方のブラウザーの古い使用状況で統計値がわずかに異なる場合がありますが、それでもサポートは広く行われているため、デスクトップとモバイルの間に大きな違いはないでしょう。

現在、HTTP ArchiveはHTTP over <a hreflang="en" href="https://www.chromium.org/quic">QUIC</a>（もうすぐ[HTTP/3](#http3)として標準化される予定）を個別に追跡しないため、これらの要求は現在HTTP/2の下にリストされますが、この章の後半でそれを測定する他の方法を見ていきます。

リクエストの数を見ると、一般的なリクエストのため結果が多少歪んでいます。たとえば、多くのサイトはHTTP/2をサポートするGoogleアナリティクスを読み込むため、埋め込みサイト自体がHTTP/2をサポートしていない場合でもHTTP/2リクエストとして表示されます。一方、人気のあるウェブサイトはHTTP/2をサポートする傾向があり、上記の統計では1回しか測定されないため、過小評価されます（「google.com」と「obscuresite.com」には同じ重みが与えられます）。_嘘、いまいましい嘘と統計です。_

ただし、私たちの調査結果は、Firefoxブラウザーを介した実際の使用状況を調べる<a hreflang="en" href="https://telemetry.mozilla.org/new-pipeline/dist.html#!cumulative=0&measure=HTTP_RESPONSE_VERSION">Mozillaのテレメトリ</a>など、他のソースによって裏付けられています。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロトコル</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.08%</td>
      </tr>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.09%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">62.36%</td>
        <td class="numeric">63.92%</td>
        <td class="numeric">63.22%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">37.46%</td>
        <td class="numeric">35.92%</td>
        <td class="numeric">36.61%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="ホームページのHTTPバージョンの使用。") }}</figcaption>
</figure>

ホームページを見て、HTTP/2をサポートするサイト数の大まかな数字を取得するだけでも（少なくともそのホームページで）おもしろいです。図20.4は、全体的な要求よりもサポートが少ないことを示しており、予想どおり約36％です。

HTTP/2は、HTTPSまたは暗号化されていない非HTTPS接続で公式に使用できますが、HTTPS上のブラウザーでのみサポートされます。前述のように、暗号化されたHTTPS接続で新しいプロトコルを非表示にすることで、この新しいプロトコルを理解してないネットワーク機器がその使用を妨げる（拒否する）ことを防ぎます。さらに、HTTPSハンドシェイクにより、クライアントとサーバーがHTTP/2の使用に同意する簡単な方法が可能になります。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロトコル</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.09%</td>
      </tr>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">45.81%</td>
        <td class="numeric">44.31%</td>
        <td class="numeric">45.01%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">54.04%</td>
        <td class="numeric">55.53%</td>
        <td class="numeric">54.83%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" HTTPSホームページのHTTPバージョンの使用。") }}</figcaption>
</figure>

WebはHTTPSに移行しており、HTTP/2は、HTTPSがパフォーマンスに悪影響を与えるという従来の議論をほぼ完全に覆しています。すべてのサイトがHTTPSに移行しているわけではないため、HTTP/2を利用できないサイトも利用できません。 HTTPSを使用するサイトのみを見ると、図20.5では図20.2の*すべてのリクエスト*の割合と同様に、HTTP/2の採用率が55％前後です。

HTTP/2のブラウザサポートは強力であり、採用への安全な方法があることを示しました。なぜすべてのサイト（または少なくともすべてのHTTPSサイト）がHTTP/2をサポートしないのですか？　さて、ここで、まだ測定していないサポートの最終項目であるサーバーサポートに進みます。

これは、最新のブラウザとは異なり、サーバーが最新バージョンに自動的にアップグレードしないことが多いため、ブラウザのサポートよりも問題が多くなります。サーバーが定期的に保守され、パッチが適用されている場合でも、多くの場合、HTTP/2のような新機能ではなくセキュリティパッチが適用されます。 HTTP/2をサポートするサイトのサーバーのHTTPヘッダーを最初に見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>サーバー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>nginx</td>
        <td class="numeric">34.04%</td>
        <td class="numeric">32.48%</td>
        <td class="numeric">33.19%</td>
      </tr>
      <tr>
        <td>cloudflare</td>
        <td class="numeric">23.76%</td>
        <td class="numeric">22.29%</td>
        <td class="numeric">22.97%</td>
      </tr>
      <tr>
        <td>Apache</td>
        <td class="numeric">17.31%</td>
        <td class="numeric">19.11%</td>
        <td class="numeric">18.28%</td>
      </tr>
      <tr>
        <td></td>
        <td class="numeric">4.56%</td>
        <td class="numeric">5.13%</td>
        <td class="numeric">4.87%</td>
      </tr>
      <tr>
        <td>LiteSpeed</td>
        <td class="numeric">4.11%</td>
        <td class="numeric">4.97%</td>
        <td class="numeric">4.57%</td>
      </tr>
      <tr>
        <td>GSE</td>
        <td class="numeric">2.16%</td>
        <td class="numeric">3.73%</td>
        <td class="numeric">3.01%</td>
      </tr>
      <tr>
        <td>Microsoft-IIS</td>
        <td class="numeric">3.09%</td>
        <td class="numeric">2.66%</td>
        <td class="numeric">2.86%</td>
      </tr>
      <tr>
        <td>openresty</td>
        <td class="numeric">2.15%</td>
        <td class="numeric">2.01%</td>
        <td class="numeric">2.07%</td>
      </tr>
      <tr>
        <td>…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" HTTP/2に使用されるサーバー。") }}</figcaption>
</figure>

nginxは、最新バージョンへのインストールまたはアップグレードを容易にするパッケージリポジトリを提供しているため、ここをリードしていることについて驚くことではありません。 cloudflareは最も人気のある[CDN](./cdn)で、デフォルトでHTTP/2を有効にしているため、HTTP/2サイトの大部分をホストしていることについて驚くことはありません。ちなみに、cloudflareは、Webサーバーとして<a hreflang="en" href="https://blog.cloudflare.com/nginx-structural-enhancements-for-http-2-performance/">大幅にカスタマイズ</a>されたバージョンのnginxを使用しています。その後、Apacheの使用率は約20％であり、次に何が隠されているかを選択するサーバー、LiteSpeed、IIS、Google Servlet Engine、nginxベースのopenrestyなどの小さなプレイヤーが続きます。

さらに興味深いのは、HTTP/2をサポート*しない*サーバーです。

<figure>
  <table>
    <thead>
      <tr>
        <th>サーバー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Apache</td>
        <td class="numeric">46.76%</td>
        <td class="numeric">46.84%</td>
        <td class="numeric">46.80%</td>
      </tr>
      <tr>
        <td>nginx</td>
        <td class="numeric">21.12%</td>
        <td class="numeric">21.33%</td>
        <td class="numeric">21.24%</td>
      </tr>
      <tr>
        <td>Microsoft-IIS</td>
        <td class="numeric">11.30%</td>
        <td class="numeric">9.60%</td>
        <td class="numeric">10.36%</td>
      </tr>
      <tr>
        <td></td>
        <td class="numeric">7.96%</td>
        <td class="numeric">7.59%</td>
        <td class="numeric">7.75%</td>
      </tr>
      <tr>
        <td>GSE</td>
        <td class="numeric">1.90%</td>
        <td class="numeric">3.84%</td>
        <td class="numeric">2.98%</td>
      </tr>
      <tr>
        <td>cloudflare</td>
        <td class="numeric">2.44%</td>
        <td class="numeric">2.48%</td>
        <td class="numeric">2.46%</td>
      </tr>
      <tr>
        <td>LiteSpeed</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">1.63%</td>
        <td class="numeric">1.36%</td>
      </tr>
      <tr>
        <td>openresty</td>
        <td class="numeric">1.22%</td>
        <td class="numeric">1.36%</td>
        <td class="numeric">1.30%</td>
      </tr>
      <tr>
        <td>…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" HTTP/1.1以前に使用されるサーバー。") }}</figcaption>
</figure>

これの一部は、サーバーがHTTP/2をサポートしていてもHTTP/1.1を使用する非HTTPSトラフィックになりますが、より大きな問題はHTTP/2をまったくサポートしないことです。これらの統計では、古いバージョンを実行している可能性が高いApacheとIISのシェアがはるかに大きいことがわかります。

特にApacheで、既存のインストールにHTTP/2サポートを追加することは簡単でない。これは、ApacheがHTTP/2をインストールするための公式リポジトリを提供していないためです。これは、多くの場合、ソースからのコンパイルやサードパーティのリポジトリの信頼に頼ることを意味しますが、どちらも多くの管理者にとって特に魅力的ではありません。

Linuxディストリビューションの最新バージョン（RHELおよびCentOS 8、Ubuntu 18、Debian 9）のみがHTTP/2をサポートするApacheのバージョンを備えており、多くのサーバーはまだそれらを実行できていません。 Microsoft側では、Windows Server 2016以降のみがHTTP/2をサポートしているため、古いバージョンを実行しているユーザーはIISでこれをサポートできません。

これら2つの統計をマージすると、サーバーごとのインストールの割合を見ることができます。

<figure>
  <table>
    <thead>
      <tr>
        <th>サーバー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>cloudflare</td>
        <td class="numeric">85.40%</td>
        <td class="numeric">83.46%</td>
      </tr>
      <tr>
        <td>LiteSpeed</td>
        <td class="numeric">70.80%</td>
        <td class="numeric">63.08%</td>
      </tr>
      <tr>
        <td>openresty</td>
        <td class="numeric">51.41%</td>
        <td class="numeric">45.24%</td>
      </tr>
      <tr>
        <td>nginx</td>
        <td class="numeric">49.23%</td>
        <td class="numeric">46.19%</td>
      </tr>
      <tr>
        <td>GSE</td>
        <td class="numeric">40.54%</td>
        <td class="numeric">35.25%</td>
      </tr>
      <tr>
        <td></td>
        <td class="numeric">25.57%</td>
        <td class="numeric">27.49%</td>
      </tr>
      <tr>
        <td>Apache</td>
        <td class="numeric">18.09%</td>
        <td class="numeric">18.56%</td>
      </tr>
      <tr>
        <td>Microsoft-IIS</td>
        <td class="numeric">14.10%</td>
        <td class="numeric">13.47%</td>
      </tr>
      <tr>
        <td>…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" HTTP/2を提供するために使用される各サーバーのインストールの割合。") }}</figcaption>
</figure>

ApacheとIISがインストールベースのHTTP/2サポートで1​​8％、14％と遅れを取っていることは明らかです。これは（少なくとも部分的に）アップグレードがより困難であるためです。多くのサーバーがこのサポートを簡単に取得するには、多くの場合、OSの完全なアップグレードが必要です。新しいバージョンのOSが標準になると、これが簡単になることを願っています。

ここで、HTTP/2実装に関するコメントはありません（[Apacheが最高の実装の1つであると思います](https://x.com/tunetheweb/status/988196156697169920?s=20)）が、これらの各サーバーでHTTP/2を有効にすることの容易さ、またはその欠如に関する詳細です。

## HTTP/2の影響
HTTP/2の影響は、特にHTTP Archive[方法論](./methodology)を使用して測定するのがはるかに困難です。理想的には、サイトをHTTP/1.1とHTTP/2の両方でクロールし、その差を測定する必要がありますがここで調査している統計では不可能です。さらに、平均的なHTTP/2サイトが平均的なHTTP/1.1サイトよりも高速であるかどうかを測定すると、ここで説明するよりも徹底的な調査を必要とする他の変数が多くなりすぎます。

測定できる影響の1つは、現在HTTP/2の世界にいるHTTP使用の変化です。複数の接続は、限られた形式の並列化を可能にするHTTP/1.1の回避策でしたが、これは実際、HTTP/2で通常最もよく機能することの反対になります。単一の接続でTCPセットアップ、TCPスロースタート、およびHTTPSネゴシエーションのオーバーヘッドが削減され、クロスリクエストの優先順位付けが可能になります。

{{ figure_markup(
  image="ch20_fig9_num_tcp_connections_trend_over_years.png",
  caption='ページごとのTCP接続。 (引用: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#tcp">HTTP Archive</a>)',
  description="ページあたりのTCP接続数の時系列グラフ。2019年7月現在、デスクトップページの中央値には14の接続があり、モバイルページの中央値には16の接続があります。",
  width=600,
  height=320
  )
}}

HTTP Archiveは、ページあたりのTCP接続数を測定します。これは、HTTP/2をサポートするサイトが増え、6つの個別の接続の代わりに単一の接続を使用するため、徐々に減少しています。

{{ figure_markup(
  image="ch20_fig10_total_requests_per_page_trend_over_years.png",
  caption='ページごとの合計リクエスト。 (引用: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#reqTotal">HTTP Archive</a>)',
  description="ページあたりのリクエスト数の時系列チャート。2019年7月現在、デスクトップページの中央値は74リクエスト、モバイルページの中央値は69リクエストです。傾向は比較的横ばいです。",
  width=600,
  height=321
  )
}}

より少ないリクエストを取得するためのアセットのバンドルは、バンドル、連結、パッケージ化、分割など多くの名前で行われた別のHTTP/1.1回避策でした。HTTP/2を使用する場合、リクエストのオーバーヘッドが少ないため、これはあまり必要ありませんが、注意する必要がありますその要求はHTTP/2で無料ではなく、<a hreflang="en" href="https://engineering.khanacademy.org/posts/js-packaging-http2.htm">バンドルを完全に削除する実験を行った人はパフォーマンスの低下に気付きました</a>。ページごとにロードされるリクエストの数を時間毎に見ると、予想される増加ではなく、リクエストのわずかな減少が見られます。

この減少は、おそらくパフォーマンスへの悪影響なしにバンドルを削除できない（少なくとも完全にではない）という前述の観察と、HTTP/1.1の推奨事項に基づく歴史的な理由で現在多くのビルドツールがバンドルされていることに起因する可能性があります。また、多くのサイトがHTTP/1.1のパフォーマンスハッキングを戻すことでHTTP/1.1ユーザーにペナルティを課す気がないかもしれません、少なくともこれに価値があると感じる確信（または時間！）を持っていない可能性があります。

増加する[ページの重み](./page-weight)を考えると、リクエストの数がほぼ静的なままであるという事実は興味深いですが、これはおそらくHTTP/2に完全に関連しているわけではありません。

## HTTP/2プッシュ
HTTP/2プッシュは、HTTP/2の大いに宣伝された新機能であるにもかかわらず、複雑な歴史を持っています。他の機能は基本的に内部のパフォーマンスの向上でしたが、プッシュはHTTPの単一の要求から単一の応答への性質を完全に破ったまったく新しい概念で、追加の応答を返すことができました。 Webページを要求すると、サーバーは通常どおりHTMLページで応答しますが、重要なCSSとJavaScriptも送信するため、特定のリソースへ追加の往復が回避されます。理論的には、CSSとJavaScriptをHTMLにインライン化するのをやめ、それでも同じようにパフォーマンスを向上させることができます。それを解決した後、潜在的にあらゆる種類の新しくて興味深いユースケースにつながる可能性があります。

現実は、まあ、少し残念です。 HTTP/2プッシュは、当初想定されていたよりも効果的に使用することがはるかに困難であることが証明されています。これのいくつかは、<a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">HTTP/2プッシュの動作の複雑さ</a>、およびそれによる実装の問題によるものです。

より大きな懸念は、プッシュがパフォーマンスの問題を解決するのではなく、すぐ簡単に問題を引き起こす可能性があることです。過剰な押し込みは、本当のリスクです。多くの場合、ブラウザーは*何*を要求するかを決定する最適な場所にあり、要求する*タイミング*と同じくらい重要ですが、HTTP/2プッシュはサーバーにその責任を負わせます。ブラウザが既にキャッシュに持っているリソースをプッシュすることは、帯域幅の浪費です（私の意見ではCSSをインライン化していますが、それについてはHTTP/2プッシュよりも苦労が少ないはずです！）。

<a hreflang="en" href="https://lists.w3.org/Archives/Public/ietf-http-wg/2019JanMar/0033.html">ブラウザのキャッシュのステータスについてサーバーに通知する提案は</a> 、特にプライバシーの問題で行き詰っています。その問題がなくても、プッシュが正しく使用されない場合、他の潜在的な問題があります。たとえば、大きな画像をプッシュして重要なCSSとJavaScriptの送信を保留すると、プッシュしない場合よりもWebサイトが遅くなります。

またプッシュは正しく実装された場合でも、パフォーマンス向上に必ずつながるという証拠はほとんどありませんでした。これも、HTTP Archiveの実行方法（1つの状態でChromeを使用する人気サイトのクロール）の性質により、HTTP Archiveが回答するのに最適な場所ではないため、ここでは詳しく説明しません。 ただし、パフォーマンスの向上は明確でなく、潜在的な問題は現実的であると言えば十分です。

それはさておき、HTTP/2プッシュの使用方法を見てみましょう。

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>HTTP/2プッシュを使用するサイト</th>
        <th>HTTP/2プッシュを使用するサイト(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">22,581</td>
        <td class="numeric">0.52%</td>
      </tr>
      <tr>
        <td>モバイル</td>
        <td class="numeric">31,452</td>
        <td class="numeric">0.59%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" HTTP/2プッシュを使用するサイト。") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>プッシュされた平均リクエスト</th>
        <th>プッシュされた平均KB</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">7.86</td>
        <td class="numeric">162.38</td>
      </tr>
      <tr>
        <td>モバイル</td>
        <td class="numeric">6.35</td>
        <td class="numeric">122.78</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="使用時にプッシュされる量。") }}</figcaption>
</figure>

これらの統計は、HTTP/2プッシュの増加が非常に低いことを示しています。これは、おそらく前述の問題が原因です。ただし、サイトがプッシュを使用する場合、図20.12に示すように1つまたは2つのアセットではなく、プッシュを頻繁に使用する傾向があります。

これは以前のアドバイスでプッシュを控えめにし、「<a hreflang="en" href="https://docs.google.com/document/d/1K0NykTXBbbbTlv60t5MyJvXjqKGsCVNYHyLEXIxYMv0/edit">アイドル状態のネットワーク時間を埋めるのに十分なリソースだけをプッシュし、それ以上はプッシュしない</a>」ということでした。上記の統計は、大きなサイズの多くのリソースがプッシュされることを示しています。

{{ figure_markup(
  image="ch20_fig13_what_push_is_used_for.png",
  caption="プッシュはどの資産タイプに使用されますか？",
  description="プッシュされるアセットタイプの割合を分類する円グラフ。 JavaScriptがアセットのほぼ半分を構成し、次にCSSが約4分の1、画像が約8分の1、残りをテキストベースのさまざまなタイプで構成します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQLxLA5Nojw28P7ceisqti3oTmNSM-HIRIR0bDb2icJS5TzONvRhdqxQcooh_45TmK97XVpot4kEQA0/pubchart?oid=466353517&format=interactive"
  )
}}

図20.13は、最も一般的にプッシュされるアセットを示しています。 JavaScriptとCSSは、ボリュームとバイトの両方で、プッシュされるアイテムの圧倒的多数です。この後、画像、フォント、およびデータのラグタグの種類があります。最後にビデオをプッシュしているサイトは約100あることがわかりますが、これは意図的なものであるか、間違ったタイプのアセットを過剰にプッシュしている兆候かもしれません！

一部の人が提起する懸念の1つは、HTTP/2実装が`プリロード`HTTP`リンク`ヘッダーをプッシュする信号として再利用したことです。`プリロード`の最も一般的な使用法の1つは、CSSが要求、ダウンロード、解析されるまでブラウザに表示されない、フォントや画像などの遅れて発見されたリソースをブラウザに通知することです。これらが現在そのヘッダーに基づいてプッシュされる場合、これを再利用すると多くの意図しないプッシュを発生する可能性があるという懸念はありました。

ただし、フォントと画像の使用率が比較的低いことは、恐れられているほどリスクが見られないことを意味する場合があります。 `<link rel="preload" ...>`タグは、HTTPリンクヘッダーではなくHTMLでよく使用され、メタタグはプッシュするシグナルではありません。[リソースヒント](./resource-hints)の章の統計では、サイトの1％未満がプリロードHTTPリンクヘッダーを使用しており、ほぼ同じ量がHTTP/2で意味のないプリコネクトを使用しているため、これはそれほど問題ではないことが示唆されます。プッシュされているフォントやその他のアセットがいくつかありますが、これはその兆候かもしれません。

これらの苦情に対する反論として、アセットがプリロードするのに十分に重要である場合、ブラウザはプリロードヒントを非常に高い優先度のリクエストとして処理するため、可能であればこれらのアセットをプッシュする必要があると主張できます。したがって、パフォーマンスの懸念は、（これも間違いなく）このために発生するHTTP/2プッシュではなくプリロードの過剰使用にあります。

この意図しないプッシュを回避するには、プリロードヘッダーで`nopush`属性を指定できます。

```
link: </assets/jquery.js>; rel=preload; as=script; nopush
```

プリロードHTTPヘッダーの5％はこの属性を使用しますが、これはニッチな最適化と考えていたため、予想よりも高くなります。繰り返しますが、プリロードHTTPヘッダーやHTTP/2プッシュ自体の使用も同様です。

## HTTP/2問題
HTTP/2は主にシームレスなアップグレードであり、サーバーがサポートすると、Webサイトやアプリケーションを変更することなく切り替えることができます。 HTTP/2向けに最適化するか、HTTP/1.1回避策の使用をやめることができますが、一般的にサイトは通常、変更を必要とせずに動作します。ただし、アップグレードに影響を与える可能性のある注意点がいくつかあり、一部のサイトでこれは難しい方法であることがわかりました。

HTTP/2の問題の原因の1つは、HTTP/2の優先順位付けの不十分なサポートです。この機能により、進行中の複数の要求が接続を適切に使用できるようになります。 HTTP/2は同じ接続で実行できるリクエストの数を大幅に増やしているため、これは特に重要です。サーバーの実装では、100または128の並列リクエスト制限が一般的です。以前は、ブラウザにはドメインごとに最大6つの接続があったため、そのスキルと判断を使用してそれらの接続の最適な使用方法を決定しました。現在では、キューに入れる必要はほとんどなく、リクエストを認識するとすぐにすべてのリクエストを送信できます。これにより、優先度の低いリクエストで帯域幅が「無駄」になり、重要なリクエストが遅延する可能性はあります（また<a hreflang="en" href="https://www.lucidchart.com/techblog/2019/04/10/why-turning-on-http2-was-a-mistake/">偶発的にバックエンドサーバーが使用されるよりも多くのリクエストでいっぱいになる可能性があります！</a>）

HTTP/2には複雑な優先順位付けモデルがあります（非常に複雑すぎるため、なぜHTTP/3で再検討されているのでしょう！）が、それを適切に尊重するサーバーはほとんどありません。これはHTTP/2の実装がスクラッチになっていないか、サーバーがより高い優先度の要求であることを認識する前に応答は既に送信されている、いわゆる*バッファブロート*が原因である可能性も考えられます。サーバー、TCPスタック、および場所の性質が異なるため、ほとんどのサイトでこれを測定することは困難ですがCDNを使用する場合はこれをより一貫させる必要があります。

[Patrick Meenan](https://x.com/patmeenan)は、優先度の高いオンスクリーンイメージを要求する前に、優先度の低いオフスクリーンイメージのロードを意図的にダウンロードしようとする<a hreflang="en" href="https://github.com/pmeenan/http2priorities/tree/master/stand-alone">サンプルテストページ</a>を作成しました。優れたHTTP/2サーバーはこれを認識し、優先度の低い画像を犠牲にして、要求後すぐに優先度の高い画像を送信できるはずです。貧弱なHTTP/2サーバーはリクエストの順番で応答し、優先順位のシグナルを無視します。 [Andy Davies](./contributors#andydavies)には、<a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">Patrickのテスト用にさまざまなCDNのステータスを追跡するページ</a>があります。 HTTP Archiveは、クロールの一部としてCDNが使用されるタイミングを識別しこれら2つのデータセットをマージすると、合格または失敗したCDNを使用しているページの割合を知ることができます。

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>正しい優先順位付け</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
        <th>合計</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>CDNを使用しない</td>
        <td>わからない</td>
        <td class="numeric">57.81%</td>
        <td class="numeric">60.41%</td>
        <td class="numeric">59.21%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>パス</td>
        <td class="numeric">23.15%</td>
        <td class="numeric">21.77%</td>
        <td class="numeric">22.40%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>不合格</td>
        <td class="numeric">6.67%</td>
        <td class="numeric">7.11%</td>
        <td class="numeric">6.90%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>不合格</td>
        <td class="numeric">2.83%</td>
        <td class="numeric">2.38%</td>
        <td class="numeric">2.59%</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>パス</td>
        <td class="numeric">2.40%</td>
        <td class="numeric">1.77%</td>
        <td class="numeric">2.06%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>パス</td>
        <td class="numeric">1.79%</td>
        <td class="numeric">1.50%</td>
        <td class="numeric">1.64%</td>
      </tr>
      <tr>
        <td></td>
        <td>わからない</td>
        <td class="numeric">1.32%</td>
        <td class="numeric">1.58%</td>
        <td class="numeric">1.46%</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>パス</td>
        <td class="numeric">1.12%</td>
        <td class="numeric">0.99%</td>
        <td class="numeric">1.05%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>不合格</td>
        <td class="numeric">0.88%</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.81%</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>不合格</td>
        <td class="numeric">0.39%</td>
        <td class="numeric">0.34%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>不合格</td>
        <td class="numeric">0.23%</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>わからない</td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.18%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="一般的なCDNでのHTTP/2優先順位付けのサポート。") }}</figcaption>
</figure>

図20.14は、トラフィックのかなりの部分が特定された問題の影響を受けていることを示しており、合計はデスクトップで26.82％、モバイルで27.83％です。これがどの程度の問題であるかは、ページの読み込み方法と、影響を受けるサイトの優先度の高いリソースが遅れて検出されるかどうかによって異なります。

{{ figure_markup(
  caption="準最適なHTTP/2優先順位付けによるモバイル要求の割合。",
  content="27.83%",
  classes="big-number"
)
}}

別の問題は、`アップグレード`HTTPヘッダーが誤って使用されていることです。 Webサーバーは、クライアントが使用したいより良いプロトコルをサポートすることを示唆する`アップグレード`HTTPヘッダーで要求に応答できます（たとえば、HTTP/2をHTTP/1.1のみを使用してクライアントに宣伝します）。これは、サーバーがHTTP/2をサポートすることをブラウザーに通知する方法として役立つと思われるかもしれませんがブラウザーはHTTPSのみをサポートし、HTTP/2の使用はHTTPSハンドシェイクを通じてネゴシエートできるため、HTTP/2を宣伝するための`アップグレード`ヘッダーはかなり制限されています（少なくともブラウザの場合）。

それよりも悪いのは、サーバーがエラーで`アップグレード`ヘッダーを送信する場合です。これは、HTTP/2をサポートするバックエンドサーバーがヘッダーを送信し、HTTP1.1のみのエッジサーバーは盲目的にクライアントに転送していることが原因である可能性を考えます。 Apacheは`mod_http2`が有効になっているがHTTP/2が使用されていない場合に`アップグレード`ヘッダーを発行し、そのようなApacheインスタンスの前にあるnginxインスタンスは、nginxがHTTP/2をサポートしない場合でもこのヘッダーを喜んで転送します。この偽の宣伝は、クライアントが推奨されているとおりにHTTP/2を使用しようとする（そして失敗する！）ことにつながります。

108サイトはHTTP/2を使用していますが、アップグレードヘッダーでHTTP/2に`アップグレード`することも推奨しています。デスクトップ上のさらに12,767のサイト（モバイルは15,235）では、HTTPSを使用できない場合、または既に使用されていることが明らかな場合、HTTPS経由で配信されるHTTP/1.1接続をHTTP/2にアップグレードすることをお勧めします。これらは、デスクトップでクロールされた430万サイトとモバイルでクロールされた530万サイトのごく少数ですが、依然として多くのサイトに影響を与える問題であることを示しています。ブラウザはこれを一貫して処理しません。Safariは特にアップグレードを試み、混乱してサイトの表示を拒否します。

これはすべて、`http1.0`、`http：//1.1`、または`-all、+ TLSv1.3、+ TLSv1.2`へのアップグレードを推奨するいくつかのサイトに入る前です。ここで進行中のWebサーバー構成には明らかに間違いがあります！

私たちが見ることのできるさらなる実装の問題があります。たとえば、HTTP/2はHTTPヘッダー名に関してはるかに厳密でありスペース、コロン、またはその他の無効なHTTPヘッダー名で応答するとリクエスト全体を拒否します。ヘッダー名も小文字に変換されます。これは、アプリケーションが特定の大文字化を前提とする場合、驚くことになります。 HTTP/1.1では<a hreflang="en" href="https://tools.ietf.org/html/rfc7230#section-3.2">ヘッダー名で大文字と小文字が区別されない</a>と明記されているため、これは以前保証されていませんでしたが、一部はこれに依存してます。 HTTP Archiveを使用してこれらの問題を特定することもできます、それらの一部はホームページには表示されませんが、今年は詳しく調査しませんでした。

## HTTP/3
世界はまだ止まっておらず、HTTP/2が5歳の誕生日を迎えてないにも関わらず、人々はすでにそれを古いニュースとみなしており後継者であるHTTP/3にもっと興奮しています。 <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-quic-http">HTTP/3</a>はHTTP/2の概念に基づいていますが、HTTPが常に使用しているTCP接続を介した作業から、<a hreflang="en" href="https://datatracker.ietf.org/wg/quic/about/">QUIC</a>と呼ばれるUDPベースのプロトコルに移行します。これにより、パケット損失が大きくTCPの保証された性質によりすべてのストリームが保持され、すべてのストリームが抑制される場合、HTTP/2がHTTP/1.1より遅い1つのケースを修正できます。また、両方のハンドシェイクで統合するなど、TCPとHTTPSの非効率性に対処することもできます。実際、実装が難しいと証明されているTCPの多くのアイデアをサポートします（TCP高速オープン、0-RTTなど）。

HTTP/3は、TCPとHTTP/2の間のオーバーラップもクリーンアップします（たとえば両方のレイヤーでフロー制御は実装されます）が、概念的にはHTTP/2と非常に似ています。 HTTP/2を理解し、最適化したWeb開発者は、HTTP/3をさらに変更する必要はありません。ただし、TCPとQUICの違いははるかに画期的であるため、サーバーオペレータはさらに多くの作業を行う必要があります。 HTTP/3のロールアウトはHTTP/2よりもかなり長くかかる可能性があり、最初はCDNなどの分野で特定の専門知識を持っている人に限定されます。

QUICは長年にわたってGoogleによって実装されており、SPDYがHTTP/2へ移行する際に行ったのと同様の標準化プロセスを現在行っています。 QUICにはHTTP以外にも野心がありますが、現時点では現在使用中のユースケースです。この章が書かれたように、HTTP/3はまだ正式に完成していないか、まだ標準として承認されていないにもかかわらず、<a hreflang="en" href="https://blog.cloudflare.com/http3-the-past-present-and-future/">Cloudflare、Chrome、FirefoxはすべてHTTP/3サポート</a>を発表しました。これは最近までQUICサポートがGoogleの外部にやや欠けていたため歓迎され、同様の標準化段階からのSPDYおよびHTTP/2サポートに確実に遅れています。

HTTP/3はTCPではなくUDPでQUICを使用するため、HTTP/3の検出はHTTP/2の検出よりも大きな課題になります。 HTTP/2では、主にHTTPSハンドシェイクを使用できますが、HTTP/3は完全に異なる接続となるため、ここは選択肢ではありません。またHTTP/2は`アップグレード`HTTPヘッダーを使用してブラウザーにHTTP/2サポートを通知します、HTTP/2にはそれほど有用ではありませんでしたが、QUICにはより有用な同様のメカニズムが導入されています。*代替サービス*HTTPヘッダー（`alt-svc`）は、この接続で使用できる代替プロトコルとは対照的に、まったく異なる接続で使用できる代替プロトコルを宣伝します。これは、`アップグレード`HTTPヘッダーの使用目的です。

{{ figure_markup(
  caption="QUICをサポートするモバイルサイトの割合。",
  content="8.38%",
  classes="big-number"
)
}}

このヘッダーを分析すると、デスクトップサイトの7.67％とモバイルサイトの8.38％がすでにQUICをサポートしていることがわかります。QUICは、Googleのトラフィックの割合を表します。また、0.04％はすでにHTTP/3をサポートしています。来年のWeb Almanacでは、この数は大幅に増加すると予想しています。

## 結論
HTTP Archiveプロジェクトで利用可能な統計のこの分析は、HTTPコミュニティの私たちの多くがすでに認識していることを示しています。HTTP/2はここにあり、非常に人気であることが証明されています。リクエスト数の点ではすでに主要なプロトコルですが、それをサポートするサイトの数の点ではHTTP/1.1を完全に追い抜いていません。インターネットのロングテールは、よく知られた大量のサイトよりもメンテナンスの少ないサイトで顕著な利益を得るために指数関数的に長い時間がかかることを意味します。

また、一部のインストールでHTTP/2サポートを取得するのが（まだ！）簡単ではないことについても説明しました。サーバー開発者、OSディストリビューター、およびエンドカスタマーはすべて、それを容易にするためプッシュすることを関与します。ソフトウェアをOSに関連付けると、常に展開時間が長くなります。実際、QUICのまさにその理由の1つは、TCPの変更を展開することで同様の障壁を破ることです。多くの場合、WebサーバーのバージョンをOSに結び付ける本当の理由はありません。 Apache（より人気のある例の1つを使用する）は、古いOSでHTTP/2サポートを使用して実行されますがサーバーに最新バージョンを取得することは、現在の専門知識やリスクを必要としません。 nginxはここで非常にうまく機能し、一般的なLinuxフレーバーのリポジトリをホストしてインストールを容易にします。Apacheチーム（またはLinuxディストリビューションベンダー）が同様のものを提供しない場合、Apacheの使用は苦労しながら縮小し続けます、最新バージョンには最高のHTTP/2実装の1つがあります、関連性を保持し古くて遅い（古いインストールに基づいて）という評判を揺るがします。 IISは通常、Windows側で優先されるWebサーバーであるため、IISの問題はそれほど多くないと考えています。

それ以外は、HTTP/2は比較的簡単なアップグレードパスであるため、既に見た強力な支持を得ています。ほとんどの場合、これは痛みなく追加が可能で、ほぼ手間をかけずにパフォーマンスが向上し、サーバーでサポートされるとほとんど考慮しなくて済むことが判明しました。しかし、（いつものように）悪魔は細部にいて、サーバー実装間のわずかな違いによりHTTP/2の使用が良くも悪くも最終的にエンドユーザーの体験に影響します。また、新しいプロトコルで予想されるように、多くのバグや<a hreflang="en" href="https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-002.md">セキュリティの問題</a>もありました。

HTTP/2のような新しいプロトコルの強力で最新のメンテナンスされた実装を使用していることを確認することで、これらの問題を確実に把握できます。ただし、それには専門知識と管理が必要です。 QUICとHTTP/3のロールアウトはさらに複雑になり、より多くの専門知識が必要になります。おそらくこれは、この専門知識を持っており、サイトからこれらの機能に簡単にアクセスできるCDNのようなサードパーティのサービスプロバイダーに委ねるのが最善でしょうか？　ただ、専門家に任せたとしても、これは確実でありません（優先順位付けの統計が示すように）。しかし、サーバープロバイダーを賢明に選択して、優先順位が何であるかを確認すれば実装が容易になります。

その点については、CDNがこれらの問題に優先順位を付ければ素晴らしいと思います（間違いなく意図的です！）、HTTP/3での新しい優先順位付け方法の出現を疑っていますが、多くは固執します。来年は、HTTPの世界でさらに興味深い時代になるでしょう。
