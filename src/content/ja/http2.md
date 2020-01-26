---
part_number: IV
chapter_number: 20
title: HTTP/2
description: HTTP/2、HTTP/2プッシュ、HTTP/2の問題、およびHTTP/3の採用と影響をカバーするWeb年鑑2019のHTTP/2章
authors: [bazzadp]
reviewers: [bagder, rmarx, dotjs]
translators: [ksakae]
discuss: 1775
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-23T00:00:00.000Z 
---

## 導入
HTTP/2は、ほぼ20年ぶりになるWebのメイン送信プロトコルの最初の主要な更新でした。それは多くの期待を持ってやってきました：欠点なしで無料のパフォーマンス向上を約束しました。それ以上にHTTP/1.1が非効率なため、強制されていたすべてのハッキングや回避策をやめることができました。デフォルトではパフォーマンスが向上するため、ドメインのバンドル、分割、インライン化、さらにはシャーディングまでもがすべてHTTP/2の世界でアンチパターンになります。

これは、[Webパフォーマンス](./performance)に集中するスキルとリソースを持たない人でも、すぐにパフォーマンスの高いWebサイトにできます。しかし現実は相変わらずそれよりも少し微妙です。 2015年5月に[RFC 7540](https://tools.ietf.org/html/rfc7540)で標準としてHTTP/2に正式承認されてから4年以上経過してます。ということでこの比較的新しい技術が現実の世界でどのように発展したかを見てみる良い機会です。

## HTTP/2とは?
この技術に精通していない人にとって、この章のメトリックと調査結果を最大限に活用するには、ちょっとした背景が役立ちます。最近までHTTPは常にテキストベースのプロトコルでした。 WebブラウザーのようなHTTPクライアントがサーバーへのTCP接続を開き、`GET /index.html`のようなHTTPコマンドを送信して、リソースを要求します。

これは*HTTPヘッダー*を追加するためにHTTP/1.0で拡張されました、なのでリクエストに加えてブラウザの種類、理解できる形式などさまざまなメタデータを含めることができます。これらのHTTPヘッダーもテキストベースであり改行文字で区切られていました。サーバーは、要求とHTTPヘッダーを1行ずつ読み取ることで着信要求を解析し、サーバーは要求されている実際のリソースに加えて独自のHTTP応答ヘッダーで応答しました。

プロトコルはシンプルに見えましたが制限もありました。 なぜならHTTPは本質的に同期であるため、HTTP要求が送信されると応答が返され、読み取られ、処理されるまでTCP接続全体が基本的に他のすべてに対して制限されていました。これは非常に効率が悪く、限られた形式の並列化を可能にするため複数のTCP接続（ブラウザーは通常6接続を使用）が必要でした。

特に暗号化を設定するための追加の手順を必要とするHTTPSを使用する場合、TCP接続は設定と完全な効率を得るのに時間とリソースを要するため、それ自体に問題が生じます。 HTTP/1.1はこれを幾分改善し、後続のリクエストでTCP接続を再利用できるようにしましたが、それでも並列化の問題は解決しませんでした。

HTTPはテキストベースですが、実際、少なくとも生の形式でテキストを転送するために使用されることはほとんどありませんでした。 HTTPヘッダーがテキストのままであることは事実でしたが、ペイロード自体しばしばそうではありませんでした。 [HTML](./markup)、[JS](./javascript)、[CSS](./css)などのテキストファイルは通常、gzip、brotliなどを使用してバイナリ形式に転送するため[圧縮](./compression)されます。[画像や動画](./media) などの非テキストファイルは、独自の形式で提供されます。その後、[セキュリティ](./security)上の理由からメッセージ全体を暗号化するために、HTTPメッセージ全体がHTTPSでラップされることがよくあります。

そのため、Webは基本的に長い間テキストベースの転送から移行していましたが、HTTPは違いました。この停滞の1つの理由は、HTTPのようなユビキタスプロトコルに重大な変更を導入することが非常に困難だったためです（以前努力しましたが、失敗しました）。多くのルーター、ファイアウォール、およびその他のミドルボックスはHTTPを理解しており、HTTPへの大きな変更に対して過剰に反応します。それらをすべてアップグレードして新しいバージョンをサポートすることは、単に不可能でした。

2009年に、Googleは[SPDY](https://www.chromium.org/spdy)と呼ばれるテキストベースのHTTPに代わるものへ取り組んでいると発表しましたが、SPDYは非推奨です。これはHTTPメッセージがしばしばHTTPSで暗号化されるという事実を利用しており、メッセージが読み取られ途中で干渉されるのを防ぎます。

Googleは、最も人気のあるブラウザー（Chrome）と最も人気のあるWebサイト（Google、YouTube、Gmailなど）の1つを制御しました。 Googleのアイデアは、HTTPメッセージを独自の形式にパックし、インターネット経由で送信してから反対側でアンパックすることでした。独自の形式であるSPDYは、テキストベースではなくバイナリベースでした。これにより、単一のTCP接続をより効率的に使用できるようになり、HTTP/1.1で標準になっていた6つの接続を開く必要がなくなりHTTP/1.1の主要なパフォーマンス問題の一部が解決しました。

現実の世界でSPDYを使用することで、ラボベースの実験結果だけでなく、実際のユーザーにとってより高性能であることを証明できました。すべてのGoogle WebサイトにSPDYを展開した後、他のサーバーとブラウザーが実装を開始し、この独自の形式をインターネット標準に標準化するときが来たため、HTTP/2が誕生しました。

HTTP/2には次の重要な概念があります。

* バイナリ形式
* 多重化
* フロー制御
* 優先順位付け
* ヘッダー圧縮
* Push

**バイナリ形式**とは、HTTP/2メッセージが事前定義された形式のフレームにラップされることを意味しHTTPメッセージの解析が容易になり、改行文字のスキャンが不要になります。これは、以前のバージョンのHTTPに対して多くの[脆弱性](https://www.owasp.org/index.php/HTTP_Response_Splitting)があったため、セキュリティにとってより優れています。また、HTTP/2接続を**多重化**できることも意味します。各フレームにはストリーム識別子とその長さが含まれているため、異なるストリームの異なるフレームを互いに干渉することなく同じ接続で送信できます。多重化により、追加の接続を開くオーバーヘッドなしで、単一のTCP接続をより効率的に使用できます。理想的にはドメインごと、または[複数のドメイン](https://daniel.haxx.se/blog/2016/08/18/http2-connection-coalescing/)に対しても単一の接続を開きます！

個別のストリームを使用すると、潜在的な利点とともにいくつかの複雑さが取り入れられます。 HTTP/2は異なるストリームが異なるレートでデータを送信できるようにする**フロー制御**の概念を必要としますが、以前応答は1つに1つだけで、これはTCPフロー制御によって接続レベルで制御されていました。同様に、**優先順位付け**では複数のリクエストを一緒に送信できますが、最も重要なリクエストではより多くの帯域幅を取得できます。

最後に、HTTP/2には、**ヘッダー圧縮**と**HTTP/2プッシュと**いう2つの新しい概念が導入されました。ヘッダー圧縮により、セキュリティ上の理由からHTTP/2固有の[HPACK](https://tools.ietf.org/html/rfc7541)形式を使用して、これらのテキストベースのHTTPヘッダーをより効率的に送信できました。 HTTP/2プッシュにより、要求への応答として複数の応答を送信できるようになり、クライアントが必要と認識する前にサーバーがリソースを「プッシュ」できるようになりました。プッシュは、CSSやJavaScriptなどのリソースをHTMLに直接インライン化して、それらのリソースが要求されている間、ページが保持されないようにするというパフォーマンスの回避策を解決することになっています。 HTTP/2を使用するとCSSとJavaScriptは外部ファイルとして残りますが、最初のHTMLと共にプッシュされるため、すぐに利用できました。これらのリソースはキャッシュされるため後続のページリクエストはこれらのリソースをプッシュしません。したがって、帯域幅を浪費しません。

急ぎ足で紹介したこのHTTP/2は、新しいプロトコルの主な歴史と概念を提供します。この説明から明らかなように、HTTP/2の主な利点は、HTTP/1.1プロトコルのパフォーマンス制限に対処することです。また、セキュリティの改善も行われました。恐らく最も重要なのは、HTTP/2以降のHTTPSを使用するパフォーマンスの問題に対処することです、HTTPSを使用しても[通常のHTTPよりもはるかに高速](https://www.httpvshttps.com/)です。 HTTPメッセージを新しいバイナリ形式にパックするWebブラウザーと、反対側でWebサーバーがそれをアンパックする以外は、HTTP自体の中核的な基本はほぼ同じままでした。これは、ブラウザーとサーバーがこれを処理するため、WebアプリケーションがHTTP/2をサポートするために変更を加える必要がないことを意味します。オンにすることで、無料でパフォーマンスを向上させることができるため、採用は比較的簡単です。もちろん、Web開発者がHTTP/2を最適化して、その違いを最大限に活用する方法もあります。

## Adoption of HTTP/2
As mentioned above, internet protocols are often difficult to adopt since they are ingrained into so much of the infrastructure that makes up the internet. This makes introducing any changes slow and difficult. IPv6 for example has been around for 20 years but has [struggled to be adopted](https://www.google.com/intl/en/ipv6/statistics.html).

<figure>
  <div class="big-number">95%</div>
  <figcaption>Figure 1. The percent of global users who can use HTTP/2.</figcaption>
</figure>

HTTP/2 however, was different as it was effectively hidden in HTTPS (at least for the browser uses cases), removing barriers to adoption as long as both the browser and server supported it. Browser support has been very strong for some time and the advent of auto updating *evergreen* browsers has meant that an estimated [95% of global users now support HTTP/2](https://caniuse.com/#feat=http2).

Our analysis is sourced from the HTTP Archive, which tests approximately 5 million of the top desktop and mobile websites in the Chrome browser. (Learn more about our [methodology](./methodology).)


<figure>
  <a href="/static/images/2019/20_HTTP_2/ch20_fig2_http2_usage_by_request.png">
    <img alt="Figure 2. HTTP/2 usage by request." aria-labelledby="fig2-caption" aria-describedby="fig2-description" src="/static/images/2019/20_HTTP_2/ch20_fig2_http2_usage_by_request.png" width="600">
  </a>
  <div id="fig2-description" class="visually-hidden">Timeseries chart of HTTP/2 usage showing adoption at 55% for both desktop and mobile as of July 2019. The trend is growing steadily at about 15 points per year.</div>
  <figcaption id="fig2-caption">Figure 2. HTTP/2 usage by request. (Source: <a href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)</figcaption>
</figure>

The results show that HTTP/2 usage is now the majority protocol-an impressive feat just 4 short years after formal standardization! Looking at the breakdown of all HTTP versions by request we see the following:

<figure markdown>
| Protocol | Desktop | Mobile | Both   |
| -------- | ------- | ------ | ------ |
|          |  5.60%  |  0.57% |  2.97% |
| HTTP/0.9 |  0.00%  |  0.00% |  0.00% |
| HTTP/1.0 |  0.08%  |  0.05% |  0.06% |
| HTTP/1.1 | 40.36%  | 45.01% | 42.79% |
| HTTP/2   | 53.96%  | 54.37% | 54.18% |

<figcaption>Figure 3. HTTP version usage by request.</figcaption>
</figure>

Figure 3 shows that HTTP/1.1 and HTTP/2 are the versions used by the vast majority of requests as expected. There is only a very small number of requests on the older HTTP/1.0 and HTTP/0.9 protocols. Annoyingly, there is a larger percentage where the protocol was not correctly tracked by the HTTP Archive crawl, particularly on desktop. Digging into this has shown various reasons, some of which can be explained and some of which can't. Based on spot checks, they mostly appear to be HTTP/1.1 requests and, assuming they are, desktop and mobile usage is similar.

Despite there being a little larger percentage of noise than we'd like, it doesn't alter the overall message being conveyed here. Other than that, the mobile/desktop similarity is not unexpected; HTTP Archive tests with Chrome, which supports HTTP/2 for both desktop and mobile. Real-world usage may have slightly different stats with some older usage of browsers on both, but even then support is widespread, so we would not expect a large variation between desktop and mobile.

At present, HTTP Archive does not track HTTP over [QUIC](https://www.chromium.org/quic) (soon to be standardized as HTTP/3) separately, so these requests are currently listed under HTTP/2, but we'll look at other ways of measuring that later in this chapter.

Looking at the number of requests will skew the results somewhat due to popular requests. For example, many sites load Google Analytics, which does support HTTP/2, and so would show as an HTTP/2 request, even if the embedding site itself does not support HTTP/2. On the other hand, popular websites tend to support HTTP/2 are also underrepresented in the above stats as they are only measured once (e.g. "google.com" and "obscuresite.com" are given equal weighting). _There are lies, damn lies, and statistics._

However, our findings are corroborated by other sources, like [Mozilla's telemetry](https://telemetry.mozilla.org/new-pipeline/dist.html#!cumulative=0&measure=HTTP_RESPONSE_VERSION), which looks at real-world usage through the Firefox browser.

<figure markdown>
| Protocol | Desktop | Mobile | Both   |
| -------- | ------- | ------ | ------ |
|          |  0.09%  |  0.08% |  0.08% |
| HTTP/1.0 |  0.09%  |  0.08% |  0.09% |
| HTTP/1.1 | 62.36%  | 63.92% | 63.22% |
| HTTP/2   | 37.46%  | 35.92% | 36.61% |

<figcaption>Figure 4. HTTP version usage for home pages.</figcaption>
</figure>

It is still interesting to look at home pages only to get a rough figure on the number of sites that support HTTP/2 (at least on their home page). Figure 4 shows less support than overall requests, as expected, at around 36%.

HTTP/2 is only supported by browsers over HTTPS, even though officially HTTP/2 can be used over HTTPS or over unencrypted non-HTTPS connections. As mentioned previously, hiding the new protocol in encrypted HTTPS connections prevents networking appliances which do not understand this new protocol from interfering with (or rejecting!) its usage. Additionally, the HTTPS handshake allows an easy method of the client and server agreeing to use HTTP/2.

<figure markdown>
| Protocol | Desktop | Mobile | Both   |
| -------- | ------- | ------ | ------ |
|          |  0.09%  |  0.10% |  0.09% |
| HTTP/1.0 |  0.06%  |  0.06% |  0.06% |
| HTTP/1.1 | 45.81%  | 44.31% | 45.01% |
| HTTP/2   | 54.04%  | 55.53% | 54.83% |

<figcaption>Figure 5. HTTP version usage for HTTPS home pages.</figcaption>
</figure>

The web is moving to HTTPS, and HTTP/2 turns the traditional argument of HTTPS being bad for performance almost completely on its head. Not every site has made the transition to HTTPS, so HTTP/2 will not even be available to those that have not. Looking at just those sites that use HTTPS, in Figure 5 we do see a higher adoption of HTTP/2 at around 55%, similar to the percent of *all requests* in Figure 2.

We have shown that browser support for HTTP/2 is strong and that there is a safe road to adoption, so why doesn't every site (or at least every HTTPS site) support HTTP/2? Well, here we come to the final item for support we have not measured yet: server support.

This is more problematic than browser support as, unlike modern browsers, servers often do not automatically upgrade to the latest version. Even when the server is regularly maintained and patched, that will often just apply security patches rather than new features like HTTP/2. Let's look first at the server HTTP headers for those sites that do support HTTP/2.

<figure markdown>
| Server        | Desktop | Mobile | Both   |
| ------------- | ------- | -------| ------ |
| nginx         |  34.04% | 32.48% | 33.19% |
| cloudflare    |  23.76% | 22.29% | 22.97% |
| Apache        |  17.31% | 19.11% | 18.28% |
|               |   4.56% |  5.13% |  4.87% |
| LiteSpeed     |   4.11% |  4.97% |  4.57% |
| GSE           |   2.16% |  3.73% |  3.01% |
| Microsoft-IIS |   3.09% |  2.66% |  2.86% |
| openresty     |   2.15% |  2.01% |  2.07% |
| ...           |   ...   |  ...   |  ...   |

<figcaption>Figure 6. Servers used for HTTP/2.</figcaption>
</figure>

Nginx provides package repositories that allow ease of installing or upgrading to the latest version, so it is no surprise to see it leading the way here. Cloudflare is the most popular [CDN](./cdn) and enables HTTP/2 by default, so again it is not surprising to see it hosts a large percentage of HTTP/2 sites. Incidently, Cloudflare uses a [heavily customized](https://blog.cloudflare.com/nginx-structural-enhancements-for-http-2-performance/) version of nginx as their web server. After those, we see Apache at around 20% of usage, followed by some servers who choose to hide what they are, and then the smaller players such as LiteSpeed, IIS, Google Servlet Engine, and openresty, which is nginx based.

What is more interesting is those servers that that do *not* support HTTP/2:

<figure markdown>
| Server        | Desktop | Mobile | Both   |
| ------------- | ------- | -------| ------ |
| Apache        |  46.76% | 46.84% | 46.80% |
| nginx         |  21.12% | 21.33% | 21.24% |
| Microsoft-IIS |  11.30% |  9.60% | 10.36% |
|               |   7.96% |  7.59% |  7.75% |
| GSE           |   1.90% |  3.84% |  2.98% |
| cloudflare    |   2.44% |  2.48% |  2.46% |
| LiteSpeed     |   1.02% |  1.63% |  1.36% |
| openresty     |   1.22% |  1.36% |  1.30% |
| ...           |   ...   |  ...   |  ...   |

<figcaption>Figure 7. Servers used for HTTP/1.1 or lower.</figcaption>
</figure>

Some of this will be non-HTTPS traffic that would use HTTP/1.1 even if the server supported HTTP/2, but a bigger issue is those that do not support HTTP/2 at all. In these stats, we see a much greater share for Apache and IIS, which are likely running older versions.

For Apache in particular, it is often not easy to add HTTP/2 support to an existing installation, as Apache does not provide an official repository to install this from. This often means resorting to compiling from source or trusting a third-party repository, neither of which is particularly appealing to many administrators.

Only the latest versions of Linux distributions (RHEL and CentOS 8, Ubuntu 18 and Debian 9) come with a version of Apache which supports HTTP/2, and many servers are not running those yet. On the Microsoft side, only Windows Server 2016 and above supports HTTP/2, so again those running older versions cannot support this in IIS.

Merging these two stats together, we can see the percentage of installs per server, that use HTTP/2:

<figure markdown>
| Server        | Desktop | Mobile |
| ------------- | ------- | -------|
| cloudflare    |  85.40% | 83.46% |
| LiteSpeed     |  70.80% | 63.08% |
| openresty     |  51.41% | 45.24% |
| nginx         |  49.23% | 46.19% |
| GSE           |  40.54% | 35.25% |
|               |  25.57% | 27.49% |
| Apache        |  18.09% | 18.56% |
| Microsoft-IIS |  14.10% | 13.47% |
| ...           |   ...   |  ...   |

<figcaption>Figure 8. Percentage installs of each server used to provide HTTP/2.</figcaption>
</figure>

It's clear that Apache and IIS fall way behind with 18% and 14% of their installed based supporting HTTP/2, which has to be (at least in part) a consequence of it being more difficult to upgrade them. A full operating system upgrade is often required for many servers to get this support easily. Hopefully this will get easier as new versions of operating systems become the norm.

None of this is a comment on the HTTP/2 implementations here ([I happen to think Apache has one of the best implementations](https://twitter.com/tunetheweb/status/988196156697169920?s=20)), but more about the ease of enabling HTTP/2 in each of these servers-or lack thereof.

## Impact of HTTP/2
The impact of HTTP/2 is much more difficult to measure, especially using the HTTP Archive [methodology](./methodology). Ideally, sites should be crawled with both HTTP/1.1 and HTTP/2 and the difference measured, but that is not possible with the statistics we are investigating here. Additionally, measuring whether the average HTTP/2 site is faster than the average HTTP/1.1 site introduces too many other variables that require a more exhaustive study than we can cover here.

One impact that can be measured is in the changing use of HTTP now that we are in an HTTP/2 world. Multiple connections were a workaround with HTTP/1.1 to allow a limited form of parallelization, but this is in fact the opposite of what usually works best with HTTP/2. A single connection reduces the overhead of TCP setup, TCP slow start, and HTTPS negotiation, and it also allows the potential of cross-request prioritization.

<figure>
  <a href="/static/images/2019/20_HTTP_2/ch20_fig9_num_tcp_connections_trend_over_years.png">
    <img alt="Figure 9. TCP connections per page." aria-labelledby="fig9-caption" aria-describedby="fig9-description" src="/static/images/2019/20_HTTP_2/ch20_fig9_num_tcp_connections_trend_over_years.png" width="600">
  </a>
  <div id="fig9-description" class="visually-hidden">Timeseries chart of the number of TCP connections per page, with the median desktop page having 14 connections and the median mobile page having 16 connections as of July 2019.</div>
  <figcaption id="fig9-caption">Figure 9. TCP connections per page. (Source: <a href="https://httparchive.org/reports/state-of-the-web#tcp">HTTP Archive</a>)</figcaption>
</figure>

HTTP Archive measures the number of TCP connections per page, and that is dropping steadily as more sites support HTTP/2 and use its single connection instead of six separate connections.

<figure>
  <a href="/static/images/2019/20_HTTP_2/ch20_fig10_total_requests_per_page_trend_over_years.png">
    <img alt="Figure 10. Total requests per page." aria-labelledby="fig10-caption" aria-describedby="fig10-description" src="/static/images/2019/20_HTTP_2/ch20_fig10_total_requests_per_page_trend_over_years.png" width="600">
  </a>
  <div id="fig10-description" class="visually-hidden">Timeseries chart of the number of requests per page, with the median desktop page having 74 requests and the median mobile page having 69 requests as of July 2019. The trend is relatively flat.</div>
  <figcaption id="fig10-caption">Figure 10. Total requests per page. (Source: <a href="https://httparchive.org/reports/state-of-the-web#reqTotal">HTTP Archive</a>)</figcaption>
</figure>

Bundling assets to obtain fewer requests was another HTTP/1.1 workaround that went by many names: bundling, concatenation, packaging, spriting, etc. This is less necessary when using HTTP/2 as there is less overhead with requests, but it should be noted that requests are not free in HTTP/2, and [those that experimented with removing bundling completely have noticed a loss in performance](https://engineering.khanacademy.org/posts/js-packaging-http2.htm). Looking at the number of requests loaded per page over time, we do see a slight decrease in requests, rather than the expected increase.

This low rate of change can perhaps be attributed to the aforementioned observations that bundling cannot be removed (at least, not completely) without a negative performance impact and that many build tools currently bundle for historical reasons based on HTTP/1.1 recommendations. It is also likely that many sites may not be willing to penalize HTTP/1.1 users by undoing their HTTP/1.1 performance hacks just yet, or at least that they do not have the confidence (or time!) to feel that this is worthwhile.

The fact that the number of requests is staying roughly static is interesting, given the ever-increasing [page weight](./page-weight), though perhaps this is not entirely related to HTTP/2.

## HTTP/2 Push
HTTP/2 push has a mixed history despite being a much-hyped new feature of HTTP/2. The other features were basically performance improvements under the hood, but push was a brand new concept that completely broke the single request to single response nature of HTTP. It allowed extra responses to be returned; when you asked for the web page, the server could respond with the HTML page as usual, but then also send you the critical CSS and JavaScript, thus avoiding any additional round trips for certain resources. It would, in theory, allow us to stop inlining CSS and JavaScript into our HTML, and still get the same performance gains of doing so. After solving that, it could potentially lead to all sorts of new and interesting use cases.

The reality has been, well, a bit disappointing. HTTP/2 push has proved much harder to use effectively than originally envisaged. Some of this has been due to [the complexity of how HTTP/2 push works](https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/), and the implementation issues due to that.

A bigger concern is that push can quite easily cause, rather than solve, performance issues. Over-pushing is a real risk. Often the browser is in the best place to decide *what* to request, and just as crucially *when* to request it but HTTP/2 push puts that responsibility on the server. Pushing resources that a browser already has in its cache, is a waste of bandwidth (though in my opinion so is inlining CSS but that gets must less of a hard time about that than HTTP/2 push!).

[Proposals to inform the server about the status of the browser cache have stalled](https://lists.w3.org/Archives/Public/ietf-http-wg/2019JanMar/0033.html) especially on privacy concerns. Even without that problem, there are other potential issues if push is not used correctly. For example, pushing large images and therefore holding up the sending of critical CSS and JavaScript will lead to slower websites than if you'd not pushed at all!

There has also been very little evidence to date that push, even when implemented correctly, results in the performance increase it promised. This is an area that, again, the HTTP Archive is not best placed to answer, due to the nature of how it runs (a crawl of popular sites using Chrome in one state), so we won't delve into it too much here. However, suffice to say that the performance gains are far from clear-cut and the potential problems are real.

Putting that aside let's look at the usage of HTTP/2 push.

<figure markdown>
| Client  | Sites Using HTTP/2 Push | Sites Using HTTP/2 Push (%) |
| ------- | ----------------------- | --------------------------- |
| Desktop |  22,581                 | 0.52%                       |
| Mobile  |  31,452                 | 0.59%                       |

<figcaption>Figure 11. Sites using HTTP/2 push.</figcaption>
</figure>

<figure markdown>
| Client  | Avg Pushed Requests | Avg KB Pushed |
| ------- | ------------------- | ------------- |
| Desktop |  7.86               | 162.38        |
| Mobile  |  6.35               | 122.78        |

<figcaption>Figure 12. How much is pushed when it is used.</figcaption>
</figure>

These stats show that the uptick of HTTP/2 push is very low, most likely because of the issues described previously. However, when sites do use push, they tend to use it a lot rather than for one or two assets as shown in Figure 12.

This is a concern as previous advice has been to be conservative with push and to ["push just enough resources to fill idle network time, and no more"](https://docs.google.com/document/d/1K0NykTXBbbbTlv60t5MyJvXjqKGsCVNYHyLEXIxYMv0/edit). The above statistics suggest many resources of a significant combined size are pushed.

<figure>
  <a href="/static/images/2019/20_HTTP_2/ch20_fig13_what_push_is_used_for.png">
    <img src="/static/images/2019/20_HTTP_2/ch20_fig13_what_push_is_used_for.png" aria-labelledby="fig13-caption" alt="Figure 13. What asset types is push used for?" aria-describedby="fig13-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQLxLA5Nojw28P7ceisqti3oTmNSM-HIRIR0bDb2icJS5TzONvRhdqxQcooh_45TmK97XVpot4kEQA0/pubchart?oid=466353517&amp;format=interactive">
  </a>
  <div id="fig13-description" class="visually-hidden">Pie chart breaking down the percent of asset types that are pushed. JavaScript makes up almost half of the assets, then CSS with about a quarter, images about an eighth, and various text-based types making up the rest.</div>
  <figcaption id="fig13-caption">Figure 13. What asset types is push used for?</figcaption>
</figure>

Figure 13 shows us which assets are most commonly pushed. JavaScript and CSS are the overwhelming majority of pushed items, both by volume and by bytes. After this, there is a ragtag assortment of images, fonts, and data. At the tail end we see around 100 sites pushing video, which may be intentional, or it may be a sign of over-pushing the wrong types of assets!

One concern raised by some is that HTTP/2 implementations have repurposed the preload HTTP `link` header as a signal to push. One of the most popular uses of the preload [resource hint](./resource-hints) is to inform the browser of late-discovered resources, like fonts and images, that the browser will not see until the CSS has been requested, downloaded, and parsed. If these are now pushed based on that header, there was a concern that reusing this may result in a lot of unintended pushes.

However, the relatively low usage of fonts and images may mean that risk is not being seen as much as was feared. `<link rel="preload" ... >` tags are often used in the HTML rather than HTTP `link` headers and the meta tags are not a signal to push. Statistics in the [Resource Hints](./resource-hints) chapter show that fewer than 1% of sites use the preload HTTP `link` header, and about the same amount use preconnect which has no meaning in HTTP/2, so this would suggest this is not so much of an issue. Though there are a number of fonts and other assets being pushed, which may be a signal of this.

As a counter argument to those complaints, if an asset is important enough to preload, then it could be argued these assets should be pushed if possible as browsers treat a preload hint as very high priority requests anyway. Any performance concern is therefore (again arguably) at the overuse of preload, rather than the resulting HTTP/2 push that happens because of this.

To get around this unintended push, you can provide the `nopush` attribute in your preload header:

```
link: </assets/jquery.js>; rel=preload; as=script; nopush
```

5% of preload HTTP headers do make use of this attribute, which is higher than I would have expected as I would have considered this a niche optimization. Then again, so is the use of preload HTTP headers and/or HTTP/2 push itself!

## HTTP/2 Issues
HTTP/2 is mostly a seamless upgrade that, once your server supports it, you can switch on with no need to change your website or application. You can optimize for HTTP/2 or stop using HTTP/1.1 workarounds as much, but in general, a site will usually work without needing any changes-it will just be faster. There are a couple of gotchas to be aware of, however, that can impact any upgrade, and some sites have found these out the hard way.

One cause of issues in HTTP/2 is the poor support of HTTP/2 prioritization. This feature allows multiple requests in progress to make the appropriate use of the connection. This is especially important since HTTP/2 has massively increased the number of requests that can be running on the same connection. 100 or 128 parallel request limits are common in server implementations. Previously, the browser had a max of six connections per domain, and so used its skill and judgement to decide how best to use those connections. Now, it rarely needs to queue and can send all requests as soon as it knows about them. This can then lead to the bandwidth being "wasted" on lower priority requests while critical requests are delayed (and incidentally [can also lead to swamping your backend server with more requests than it is used to!](https://www.lucidchart.com/techblog/2019/04/10/why-turning-on-http2-was-a-mistake/)).

HTTP/2 has a complex prioritization model (too complex many say - hence why it is being reconsidered for HTTP/3!) but few servers honor that properly. This can be because their HTTP/2 implementations are not up to scratch, or because of so-called *bufferbloat*, where the responses are already en route before the server realizes there is a higher priority request. Due to the varying nature of servers, TCP stacks, and locations, it is difficult to measure this for most sites, but with CDNs this should be more consistent.

[Patrick Meenan](https://twitter.com/patmeenan) created [an example test page](https://github.com/pmeenan/http2priorities/tree/master/stand-alone), which deliberately tries to download a load of low priority, off-screen images, before requesting some high priority on-screen images. A good HTTP/2 server should be able to recognize this and send the high priority images shortly after requested, at the expense of the lower priority images. A poor HTTP/2 server will just respond in the request order and ignore any priority signals. [Andy Davies](./contributors#andydavies) has [a page tracking the status of various CDNs for Patrick's test](https://github.com/andydavies/http2-prioritization-issues). The HTTP Archive identifies when a CDN is used as part of its crawl, and merging these two datasets can tell us the percent of pages using a passing or failing CDN.

<figure markdown>
| CDN               | Prioritizes Correctly? | Desktop | Mobile | Both   |
| ----------------- | -----------------------| ------- | ------ | ------ |
| Not using CDN     | Unknown                | 57.81%  | 60.41% | 59.21% |
| Cloudflare        | Pass                   | 23.15%  | 21.77% | 22.40% |
| Google            | Fail                   |  6.67%  |  7.11% |  6.90% |
| Amazon CloudFront | Fail                   |  2.83%  |  2.38% |  2.59% |
| Fastly            | Pass                   |  2.40%  |  1.77% |  2.06% |
| Akamai            | Pass                   |  1.79%  |  1.50% |  1.64% |
|                   | Unknown                |  1.32%  |  1.58% |  1.46% |
| WordPress         | Pass                   |  1.12%  |  0.99% |  1.05% |
| Sucuri Firewall   | Fail                   |  0.88%  |  0.75% |  0.81% |
| Incapsula         | Fail                   |  0.39%  |  0.34% |  0.36% |
| Netlify           | Fail                   |  0.23%  |  0.15% |  0.19% |
| OVH CDN           | Unknown                |  0.19%  |  0.18% |  0.18% |

<figcaption>Figure 14. HTTP/2 prioritization support in common CDNs.</figcaption>
</figure>

Figure 14 shows that a fairly significant portion of traffic is subject to the identified issue, totaling 26.82% on desktop and 27.83% on mobile. How much of a problem this is depends on exactly how the page loads and whether high priority resources are discovered late or not for the sites affected.

<figure>
  <div class="big-number">27.83%</div>
  <figcaption>Figure 15. The percent of mobile requests with sub-optimal HTTP/2 prioritization.</figcaption>
</figure>

Another issue is with the `upgrade` HTTP header being used incorrectly. Web servers can respond to requests with an `upgrade` HTTP header suggesting that it supports a better protocol that the client might wish to use (e.g. advertise HTTP/2 to a client only using HTTP/1.1). You might think this would be useful as a way of informing the browser a server supports HTTP/2, but since browsers only support HTTP/2 over HTTPS and since use of HTTP/2 can be negotiated through the HTTPS handshake, the use of this `upgrade` header for advertising HTTP/2 is pretty limited (for browsers at least).

Worse than that, is when a server sends an `upgrade` header in error. This could be because a backend server supporting HTTP/2 is sending the header and then an HTTP/1.1-only edge server is blindly forwarding it to the client. Apache emits the `upgrade` header when `mod_http2` is enabled but HTTP/2 is not being used, and an nginx instance sitting in front of such an Apache instance happily forwards this header even when nginx does not support HTTP/2. This false advertising then leads to clients trying (and failing!) to use HTTP/2 as they are advised to.

108 sites use HTTP/2 while they also suggest upgrading to HTTP/2 in the `upgrade` header. A further 12,767 sites on desktop (15,235 on mobile) suggest upgrading an HTTP/1.1 connection delivered over HTTPS to HTTP/2 when it's clear this was not available, or it would have been used already. These are a small minority of the 4.3 million sites crawled on desktop and 5.3 million sites crawled on mobile, but it shows that this is still an issue affecting a number of sites out there. Browsers handle this inconsistently, with Safari in particular attempting to upgrade and then getting itself in a mess and refusing to display the site at all.

All of this is before we get into the few sites that recommend upgrading to `http1.0`, `http://1.1`, or even `-all,+TLSv1.3,+TLSv1.2`. There are clearly some typos in web server configurations going on here!

There are further implementation issues we could look at. For example, HTTP/2 is much stricter about HTTP header names, rejecting the whole request if you respond with spaces, colons, or other invalid HTTP header names. The header names are also converted to lowercase, which catches some by surprise if their application assumes a certain capitalization. This was never guaranteed previously, as HTTP/1.1 specifically states the [header names are case insensitive](https://tools.ietf.org/html/rfc7230#section-3.2), but still some have depended on this. The HTTP Archive could potentially be used to identify these issues as well, though some of them will not be apparent on the home page, but we did not delve into that this year.

## HTTP/3
The world does not stand still, and despite HTTP/2 not having even reached its fifth birthday, people are already seeing it as old news and getting more excited about its successor, [HTTP/3](https://datatracker.ietf.org/doc/draft-ietf-quic-http/). HTTP/3 builds on the concepts of HTTP/2, but moves from working over TCP connections that HTTP has always used, to a UDP-based protocol called [QUIC](https://datatracker.ietf.org/wg/quic/about/). This allows us to fix one case where HTTP/2 is slower then HTTP/1.1, when there is high packet loss and the guaranteed nature of TCP holds up all streams and throttles back all streams. It also allows us to address some TCP and HTTPS inefficiencies, such as consolidating in one handshake for both, and supporting many ideas for TCP that have proven hard to implement in real life (TCP fast open, 0-RTT, etc.).

HTTP/3 also cleans up some overlap between TCP and HTTP/2 (e.g. flow control being implemented in both layers) but conceptually it is very similar to HTTP/2. Web developers who understand and have optimized for HTTP/2 should have to make no further changes for HTTP/3. Server operators will have more work to do, however, as the differences between TCP and QUIC are much more groundbreaking. They will make implementation harder so the rollout of HTTP/3 may take considerably longer than HTTP/2, and initially be limited to those with certain expertise in the field like CDNs.

QUIC has been implemented by Google for a number of years and it is now undergoing a similar standardization process that SDPY did on its way to HTTP/2. QUIC has ambitions beyond just HTTP, but for the moment it is the use case being worked on currently. Just as this chapter was being written, [Cloudflare, Chrome, and Firefox all announced HTTP/3 support](https://blog.cloudflare.com/http3-the-past-present-and-future/), despite the fact that HTTP/3 is still not formally complete or approved as a standard yet. This is welcome as QUIC support has been somewhat lacking outside of Google until recently, and definitely lags behind SPDY and HTTP/2 support from a similar stage of standardization.

Because HTTP/3 uses QUIC over UDP rather than TCP, it makes the discovery of HTTP/3 support a bigger challenge than HTTP/2 discovery. With HTTP/2 we can mostly use the HTTPS handshake, but as HTTP/3 is on a completely different connection, that is not an option here. HTTP/2 also used the `upgrade` HTTP header to inform the browser of HTTP/2 support, and although that was not that useful for HTTP/2, a similar mechanism has been put in place for QUIC that is more useful. The *alternative services* HTTP header (`alt-svc`) advertises alternative protocols that can be used on completely different connections, as opposed to alternative protocols that can be used on this connection, which is what the `upgrade` HTTP header is used for.

<figure>
  <div class="big-number">8.38%</div>
  <figcaption>Figure 15. The percent of mobile sites which support QUIC.</figcaption>
</figure>

Analysis of this header shows that 7.67% of desktop sites and 8.38% of mobile sites already support QUIC, which roughly represents Google's percentage of traffic, unsurprisingly enough, as it has been using this for a while. And 0.04% are already supporting HTTP/3. I would imagine by next year's Web Almanac, this number will have increased significantly.

## Conclusion
This analysis of the available statistics in the HTTP Archive project has shown what many of us in the HTTP community were already aware of: HTTP/2 is here and proving to be very popular. It is already the dominant protocol in terms of number of requests, but has not quite overtaken HTTP/1.1 in terms of number of sites that support it. The long tail of the internet means that it often takes an exponentially longer time to make noticeable gains on the less well-maintained sites than on the high profile, high volume sites.

We've also talked about how it is (still!) not easy to get HTTP/2 support in some installations. Server developers, operating system distributors, and end customers all have a part to play in pushing to make that easier. Tying software to operating systems always lengthens deployment time. In fact, one of the very reasons for QUIC is to break a similar barrier with deploying TCP changes. In many instances, there is no real reason to tie web server versions to operating systems. Apache (to use one of the more popular examples) will run with HTTP/2 support in older operating systems, but getting an up-to-date version on to the server should not require the expertise or risk it currently does. Nginx does very well here, hosting repositories for the common Linux flavors to make installation easier, and if the Apache team (or the Linux distribution vendors) do not offer something similar, then I can only see Apache's usage continuing to shrink as it struggles to hold relevance and shake its reputation as old and slow (based on older installs) even though up-to-date versions have one of the best HTTP/2 implementations. I see that as less of an issue for IIS, since it is usually the preferred web server on the Windows side.

Other than that, HTTP/2 has been a relatively easy upgrade path, which is why it has had the strong uptake it has already seen. For the most part, it is a painless switch-on and, therefore, for most, it has turned out to be a hassle-free performance increase that requires little thought once your server supports it. The devil is in the details though (as always), and small differences between server implementations can result in better or worse HTTP/2 usage and, ultimately, end user experience. There has also been a number of bugs and even [security issues](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-002.md), as is to be expected with any new protocol.

Ensuring you are using a strong, up-to-date, well-maintained implementation of any newish protocol like HTTP/2 will ensure you stay on top of these issues. However, that can take expertise and managing. The roll out of QUIC and HTTP/3 will likely be even more complicated and require more expertise. Perhaps this is best left to third-party service providers like CDNs who have this expertise and can give your site easy access to these features? However, even when left to the experts, this is not a sure thing (as the prioritization statistics show), but if you choose your server provider wisely and engage with them on what your priorities are, then it should be an easier implementation.

On that note it would be great if the CDNs prioritized these issues (pun definitely intended!), though I suspect with the advent of a new prioritization method in HTTP/3, many will hold tight. The next year will prove yet more interesting times in the HTTP world.
