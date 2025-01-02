---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP/2
description: HTTP/2、HTTP/2 Push、HTTP/2 Issues、HTTP/3の採用と影響を網羅した2020年版Web AlmanacのHTTP/2の章。
hero_alt: Hero image of Web Almanac characters driving vehicles in various lanes carrying script and images resources.
authors: [dotjs, rmarx, MikeBishop]
reviewers: [LPardue, tunetheweb, ibnesayeed]
analysts: [gregorywolf]
editors: [rviscomi]
translators: [ksakae1216]
dotjs_bio: Andrewは<a hreflang="en" href="https://www.cloudflare.com/">Cloudflare</a>で働き、ウェブの高速化と安全性の向上に貢献しています。彼は、エンドユーザーのウェブサイトのパフォーマンスを向上させるために、新しいプロトコルやアセット配信の展開、測定、改善に時間を費やしています。
rmarx_bio: Robinは<a hreflang="en" href="https://www.uhasselt.be/edm">ベルギーのハッセルト大学</a> のウェブプロトコルとパフォーマンスの研究者です。彼は、<a hreflang="en" href="https://github.com/quiclog">qlogやqvis</a>のようなツールを作成することで、QUICやHTTP/3を使えるようにすることに取り組んでいます。
MikeBishop_bio: <a hreflang="en" href="https://quicwg.org/">QUIC Working Group</a>のHTTP/3のエディタ。<a hreflang="en" href="https://www.akamai.com/">Akamai</a>のファウンドリグループのアーキテクト。
discuss: 2058
results: https://docs.google.com/spreadsheets/d/1M1tijxf04wSN3KU0ZUunjPYCrVsaJfxzuRCXUeRQ-YU/
featured_quote: この章では、HTTP/2とgQUICの現状の展開をレビューし、優先順位付けやサーバプッシュなどのプロトコルの新機能がどの程度採用されているかを確認します。次に、HTTP/3の動機、プロトコルバージョン間の主な違い、QUICを使ってUDPベースのトランスポートプロトコルにアップグレードする際の潜在的な課題について説明します。
featured_stat_1: 64%
featured_stat_label_1: HTTP/2で提供されるリクエスト
featured_stat_2: 31.7%
featured_stat_label_2: HTTP/2の優先順位が正しくないCDN リクエスト
featured_stat_3: 80%
featured_stat_label_3: CDNが使用されている場合はHTTP/2で提供されるページ、CDNが使用されていない場合は30%です。
---

## 序章

HTTPは、ネットワーク接続されたデバイス間で情報を転送するために設計されたアプリケーション層のプロトコルで、ネットワークプロトコルスタックの他の層の上で動作します。HTTP/1.xがリリースされてから、最初のメジャーアップデートであるHTTP/2が2015年に標準化されるまで20年以上かかりました。

それだけではありません。過去4年間、HTTP/3とQUIC（新しい遅延削減、信頼性、安全性の高いトランスポートプロトコル）はIETFのQUICワーキンググループで標準化開発が行われてきました。実は、同じ名前を持つプロトコルは2つあります。"Google QUIC"（略して "gQUIC"）とは、Googleが設計して使用していたオリジナルのプロトコルと、より新しいIETF標準化版（IETF QUIC/QUIC）のことです。IETF QUICはgQUICをベースにしていましたが、設計や実装が大きく異なるものに成長しています。2020年10月21日、IETF QUICのドラフト32が<a hreflang="en" href="https://mailarchive.ietf.org/arch/msg/quic/ye1LeRl7oEz898RxjE6D3koWhn0/">最終版</a>に移行し、重要な節目を迎えました。これは、作業グループがほぼ完成したと考え、より広いIETFコミュニティに最終レビューを要求する標準化プロセスの一部です。

この章では、HTTP/2とgQUICの展開の現状をレビューします。優先順位付けやサーバプッシュなど、プロトコルの新機能のいくつかがどの程度採用されているかを探ります。次に、HTTP/3の動機、プロトコルバージョン間の主な違い、QUICを使ってUDPベースのトランスポートプロトコルにアップグレードする際の潜在的な課題について説明します。

### HTTP/1.0からHTTP/2

HTTPプロトコルが進化しても、HTTPのセマンティクスは変わりません。HTTPメソッド（GETやPOSTなど）、ステータスコード (200や恐ろしい404)、URI、ヘッダフィールドに変更はありません。HTTPプロトコルが変わったところでは、ワイヤーエンコーディングと、基礎となるトランスポートの機能の使用が違います。

1996年に公開されたHTTP/1.0は、テキストベースのアプリケーションプロトコルを定義し、クライアントとサーバがリソースを要求するためにメッセージを交換することを可能にしました。リクエスト/レスポンスごとに新しいTCP接続が必要となり、オーバーヘッドが発生していました。TCP接続では、飛行中のデータ量を最大化するために輻輳制御アルゴリズムを使用しています。このプロセスは、新しい接続ごとに時間がかかります。この「スロースタート」は、利用可能なすべての帯域幅がすぐに使用されるわけではないことを意味します。

1997年にHTTP/1.1が導入され、「keep-alives」を追加してTCP接続の再利用を可能にし、接続開始時のトータルコストを削減することを目的としています。時間の経過とともに、ウェブサイトのパフォーマンスへの期待が高まるにつれ、 リクエストの同時実行性が必要になってきました。HTTP/1.1は、前のレスポンスが完了した後にのみ別のリソースを要求できました。そのため、追加のTCP接続を確立する必要があり、keep-alives接続の影響を軽減し、さらにオーバーヘッドを増加させていました。

2015年に公開されたHTTP/2は、クライアントとサーバ間の双方向ストリームの概念を導入したバイナリベースのプロトコルです。これらのストリームを使用することで、ブラウザは単一のTCP接続を最適に利用して、複数のHTTPリクエスト/レスポンスを同時に多重化できます。HTTP/2はまた、この多重化を制御するための優先順位付けスキームを導入しました。クライアントは、より重要なリソースを他のリソースよりも優先して送信できるようにリクエストの優先順位をシグナルできます。

## HTTP/2の採用

この章で使用したデータはHTTP Archiveから入手したもので、700万以上のウェブサイトをChromeブラウザでテストしています。 他の章と同様に、分析はモバイルとデスクトップのウェブサイトに分かれています。デスクトップとモバイルの結果が似ている場合は、モバイルのデータセットから統計情報を表示しています。詳細は[方法論](./methodology)のページに掲載されています。このデータを見直す際には、リクエストの数に関係なく、それぞれのウェブサイトが同等の重みを受けることを念頭に置いてください。このデータは、幅広いアクティブなウェブサイトの傾向を調査していると考えることをお勧めします。

{{ figure_markup(
  image="http2-h2-usage.png",
  link="https://httparchive.org/reports/state-of-the-web#h2",
  caption='リクエスト別のHTTP/2の使用状況。(提供元: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="2019年7月時点でデスクトップ、モバイルともに64％の採用率を示すHTTP/2利用状況の時系列図。この傾向は年15ポイント程度で順調に伸びています。",
  width=600,
  height=321
  )
}}

昨年のHTTP Archiveデータの分析では、HTTP/2がリクエストの50%以上に使用されており、ご覧のように2020年も直線的な成長が続いており、現在ではリクエストの60%以上がHTTP/2で提供されています。

{{ figure_markup(
  caption="HTTP/2を使用するリクエストの割合。",
  content="64%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

図22.3と昨年の結果を比較すると、**HTTP/2リクエストが10%増加し**、HTTP/1.xリクエストが10%減少しています。これはgQUICがデータセットで確認できるようになった最初の年です。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロトコル</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">**34.47%</td>
        <td class="numeric">34.11%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63.70%</td>
        <td class="numeric">63.80%</td>
      </tr>
      <tr>
        <td>gQUIC</td>
        <td class="numeric">1.72%</td>
        <td class="numeric">1.71%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="HTTP version usage by request.", sheets_gid="2122693316", sql_file="adoption_of_http_2_by_site_and_requests.sql") }}</figcaption>
</figure>

<aside class="note">
  ** 昨年のクロールと同様に、デスクトップリクエストの約4%はプロトコルバージョンを報告していませんでした。分析によると、これらはほとんどがHTTP/1.1であり、今後のクロールと分析のためにこのギャップを修正しました。データは2020年8月のクロールに基づいていますが、公開前の2020年10月のデータセットで修正を確認したところ、これらのリクエストは確かにHTTP/1.1であったことが判明したため、上記の表の統計に追加しました。
</aside>

ウェブサイトのリクエストの総数を確認すると、一般的なサードパーティのドメインに偏りが出てきます。サーバーインストールによるHTTP/2の採用状況をよりよく理解するために、代わりにサイトのホームページからHTMLを提供するために使用されるプロトコルを見てみましょう。

昨年はホームページの約37%がHTTP/2で、63%がHTTP/1で提供されていましたが、今年はモバイルとデスクトップを合わせるとほぼ同じ割合で図22.4に示すように初めてHTTP/2で提供されたデスクトップサイトの数がわずかに増えています。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロトコル</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">49.22%</td>
        <td class="numeric">50.05%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">49.97%</td>
        <td class="numeric">49.28%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="HTTP version usage for home pages.", sheets_gid="1447413141", sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql") }}</figcaption>
</figure>

gQUICがホームページのデータに表示されないのには、2つの理由があります。gQUIC上のウェブサイトを測定するために、HTTP Archiveのクロールは[alternative services](#代替サービス)ヘッダーを介してプロトコルネゴシエーションを実行し、このエンドポイントを使用してgQUIC上のサイトをロードする必要があります。これは今年サポートされていませんでしたが、来年のWeb Almanacで利用できるようになると期待しています。また、gQUICはホームページを提供するのではなく、サードパーティのGoogleツールに主に使用されています。

ウェブ上の[セキュリティ](./security)と[プライバシー](./privacy)を向上させようとする動きにより、TLSを利用したリクエストは<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">過去4年間で150%以上</a>増加しています。今日では、モバイルとデスクトップにおけるすべてのリクエストの86%以上が暗号化されています。ホームページだけを見ると、デスクトップでは78.1%、モバイルでは74.7%という印象的な数字になっています。これは、HTTP/2がTLSを介したブラウザでのみサポートされていることが重要です。図22.5に示すように、HTTP/2でサービスされる割合も[昨年](../2019/http#fig-5)から10ポイント増えており、55%から65%になっています。

<figure>
  <table>
    <thead>
      <tr>
        <th>プロトコル</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">36.05%</td>
        <td class="numeric">34.04%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63.95%</td>
        <td class="numeric">65.96%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="HTTP version usage for HTTPS home pages.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

60%以上のWebサイトがHTTP/2またはgQUICで提供されているため、個々のサイト間で行われたすべてのリクエストのプロトコル分布のパターンをもう少し詳しく見てみましょう。

{{ figure_markup(
  image="http2-h2-or-gquic-requests-per-page.png",
  caption="2020年の1ページあたりのHTTP/2リクエストの割合の分布を2019年と比較してみましょう。",
  description="ページパーセンタイル別のHTTP/2リクエストの割合の棒グラフです。ページあたりのHTTP/2またはgQUICリクエストの割合の中央値は、2019年の46%から2020年には76%に増加しています。10、25、75、90パーセンタイルでは、1ページあたりのHTTP/2またはgQUICリクエストの割合は、2019年の3％、15％、93％、100％に比べて、2020年は5％、24％、98％、100％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1328744214&format=interactive",
  sheets_gid="152400778",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

図22.6は、今年と昨年の間にWebサイトでどれだけHTTP/2またはgQUICが使用されているかを比較したものです。最も顕著な変化は、昨年の46%に対し、半数以上のサイトで75%以上のリクエストがHTTP/2またはgQUICで提供されていることです。7%未満のサイトではHTTP/2またはgQUICリクエストを行わず、10%のサイトでは完全にHTTP/2またはgQUICリクエストを行っています。

ページ自体の内訳は？　一般的には、ファーストパーティコンテンツとサードパーティコンテンツの違いについて話します。サードパーティとは、広告、マーケティング、分析などの機能を提供するサイト所有者の直接の管理下にないコンテンツと定義されています。既知のサードパーティの定義は、<a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">サードパーティウェブ</a>のリポジトリから引用しています。

図22.7では、他のリクエストと比較して既知のサードパーティまたはファーストパーティのHTTP/2リクエストの割合で、すべてのWebサイトに注文を付けています。全サイトの40%以上のサイトでは、ファーストパーティのHTTP/2リクエストやgQUICリクエストが全くないため、顕著な違いが見られます。対照的に、下位5%のページでさえ、30%のサードパーティコンテンツがHTTP/2で提供されています。これは、HTTP/2の普及の大部分がサードパーティによるものであることを示しています。

{{ figure_markup(
  image="http2-first-and-third-party-http2-usage.png",
  caption="1ページあたりのサードパーティとファーストパーティのHTTP/2リクエストの割合の分布。",
  description="ファーストパーティのHTTP/2リクエストとサードパーティのHTTP/2またはgQUICリクエストの割合を比較した折れ線グラフ。このグラフでは、HTTP/2リクエストの割合でウェブサイトを並べています。45%のWebサイトでは、HTTP/2のファーストパーティリクエストがありません。半数以上のWebサイトでは、HTTP/2またはgQUICでのみサードパーティのリクエストを提供しています。80%のWebサイトでは、76%以上のサードパーティのHTTP/2またはgQUICリクエストがあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1409316276&format=interactive",
  sql_file="http2_1st_party_vs_3rd_party.sql",
  sheets_gid="733872185"
)
}}

HTTP/2とgQUICのどちらのコンテンツタイプで提供されるかに違いはありますか？ 図22.8は、例えば、90%のWebサイトがサードパーティのフォントとオーディオを100%HTTP/2またはgQUICで提供しており、HTTP/1.1では5%しか提供しておらず、5%が混在していることを示しています。サードパーティのアセットの大部分はスクリプトまたは画像で、HTTP/2またはgQUICでのみ提供されているWebサイトがそれぞれ60%と70%あります。

{{ figure_markup(
  image="http2-third-party-http2-usage-by-content-type.png",
  caption="ウェブサイトごとのコンテンツタイプ別の既知のサードパーティHTTP/2またはgQUICリクエストの割合。",
  description="サードパーティのHTTP/2リクエストの割合をコンテンツタイプ別に比較した棒グラフです。すべてのサードパーティのリクエストは、オーディオとフォントの90%、CSSとビデオの80%、html、画像、テキストの70%、スクリプトの60%に対してHTTP/2またはgQUICで提供されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1264128523&format=interactive",
  sheets_gid="419557288",
  sql_file="http2_1st_party_vs_3rd_party_by_type.sql"
)
}}

図22.9に示すように、広告、分析、コンテンツ配信ネットワーク（CDN）リソース、タグ管理者は主にHTTP/2またはgQUICで提供されています。顧客満足度の高いコンテンツやマーケティングコンテンツは、HTTP/1で提供される可能性が高いです。

{{ figure_markup(
  image="http2-third-party-http2-usage-by-category.png",
  caption="ウェブサイトごとのカテゴリ別の既知のサードパーティ製HTTP/2またはgQUICリクエストの割合。",
  description="HTTP/2またはgQUICによるサードパーティリクエストの割合をカテゴリー別に比較した棒グラフ。すべてのウェブサイトのすべてのサードパーティのリクエストは、タグマネージャーの95%、アナリティクスとCDNの90%、広告、ソーシャル、ホスティング、ユーティリティの80%、マーケティングの40%、カスタマーサクセスの30%に対してHTTP/2またはgQUICで提供されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1419102835&format=interactive",
  sheets_gid="1059610651",
  sql_file="http2_3rd_party_by_types.sql"
)
}}

### サーバーサポート

ブラウザの自動更新メカニズムは、新しいウェブ標準をクライアント側で採用するための原動力となっています。それは<a hreflang="en" href="https://caniuse.com/http2">推定</a>で、全世界のユーザーの97%以上がHTTP/2をサポートしており、昨年測定された95%からわずかに増加しています。

残念ながら、サーバーのアップグレードパスは、特にTLSをサポートする必要があるため、より難しくなっています。モバイルとデスクトップでは、図22.10を見ると、HTTP/2サイトの大部分がnginx、Cloudflare、Apacheによって提供されていることがわかります。HTTP/1.1のサイトのほぼ半分はApacheによって提供されています。

{{ figure_markup(
  image="http2-server-protocol-usage.png",
  caption="モバイル上でのHTTPプロトコルによるサーバーの使用状況",
  description="モバイルクライアントに最も人気のあるサーバのHTTP/1.xまたはHTTP/2によって提供されているウェブサイトの数を示す棒グラフです。Nginxは727,181のHTTP/1.1と1,023,575のHTTP/2サイトにサービスを提供しています。Cloudflareは59,981のHTTP/1.1と679,616のHTTP/2を提供しています。Apache 1,521,753のHTTP/1.1と585,096のHTTP/2。Litespeed 50,502のHTTP/1.1と166,721のHTTP/2。Microsoft-IIS 284,047のHTTP/1.1と81,490のHTTP/2。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=718663369&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
)
}}

各サーバの昨年のHTTP/2採用率はどのように変化したのでしょうか？　図22.11は、昨年からすべてのサーバでHTTP/2の採用率が約10%増加していることを示しています。ApacheとIISはまだ25%以下のHTTP/2です。これは新しいサーバがnginxになる傾向があるか、ApacheやIISをHTTP/2やTLSにアップグレードするのが難しすぎるか、価値がないと思われているかのどちらかだと考えられます。

{{ figure_markup(
  image="http2-h2-usage-by-server.png",
  caption="サーバー別にHTTP/2で提供されたページの割合",
  description="2019年と2020年の間にHTTP/2で提供されたWebサイトの割合を比較した棒グラフ。Cloudflareは85.40%から93.08%に増加。Litespeedは70.80%から81.91%に増加。Openrestyは51.40%から66.24%に増加。Nginxは49.20%から60.84%に増加。Apacheが18.10%から27.19%に、MIcorsoft-IISが14.10%から22.82%に増加した。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=936321266&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

ウェブサイトのパフォーマンスを向上させるために長期的に推奨されてきたのは、CDNの使用です。その利点は、コンテンツを提供することと、エンドユーザーに近いところで接続を終了させることの両方によって待ち時間が短縮されることです。これは、プロトコルの展開における急速な進化と、サーバーやOSのチューニングにおける追加の複雑さを緩和するのに役立ちます（詳細については、[優先順位付け](#優先順位付け)セクションを参照してください）。新しいプロトコルを効果的に利用するためには、CDNを利用することが推奨されています。

CDNは大きく分けて2つのカテゴリーに分類されます：ホームページや資産のサブドメインを提供するものと、サードパーティのコンテンツを提供するために主に使用されるものです。最初のカテゴリの例としては、大規模で汎用的なCDN（Cloudflare、Akamai、Fastlyなど）と、より特殊なCDN（WordPressやNetlifyなど）があります。CDNの有無によるホームページのHTTP/2採用率の違いを見てみると、次のようになります。

- CDNが使用されている場合、モバイルホームページの**80%**はHTTP/2で提供されます。
- CDNを使用しない場合、モバイルホームページの**30%**はHTTP/2で提供されます。

図22.12は、より具体的で、現代のCDNはHTTP/2上のトラフィックの高い割合を提供しています。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="colgroup" class="no-wrap">HTTP/2 (%)</th>
        <th scope="colgroup">CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>100%</td>
        <td>Bison Grid, CDNsun, LeaseWeb CDN, NYI FTW, QUIC.cloud, Roast.io, Sirv CDN, Twitter, Zycada Networks</td>
      </tr>
      <tr>
        <td>90 - 99%</td>
        <td>Automattic, Azion, BitGravity, Facebook, KeyCDN, Microsoft Azure, NGENIX, Netlify, Yahoo, section.io, Airee, BunnyCDN, Cloudflare, GoCache, NetDNA, SFR, Sucuri Firewall</td>
      </tr>
      <tr>
        <td>70 - 89%</td>
        <td>Amazon CloudFront, BelugaCDN, CDN, CDN77, Erstream, Fastly, Highwinds, OVH CDN, Yottaa, Edgecast, Myra Security CDN, StackPath, XLabs Security</td>
      </tr>
      <tr>
        <td>20 - 69%</td>
        <td>Akamai, Aryaka, Google, Limelight, Rackspace, Incapsula, Level 3, Medianova, OnApp, Singular CDN, Vercel, Cachefly, Cedexis, Reflected Networks, Universal CDN, Yunjiasu, CDNetworks</td>
      </tr>
      <tr>
        <td> < 20%</td>
        <td>Rocket CDN, BO.LT, ChinaCache, KINX CDN, Zenedge, ChinaNetCenter </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentage of HTTP/2 requests served by the first-party CDNs over mobile.", sheets_gid="781660433", sql_file="cdn_detail_by_cdn.sql") }}</figcaption>
</figure>

2番目のカテゴリのコンテンツの種類は、一般的に共有リソース（JavaScriptやフォントCDN）、広告、またはアナリティクスです。これらすべての場合において、CDNを使用することで、様々なSaaSソリューションのパフォーマンスとオフロードを向上させることができます。

{{ figure_markup(
  image="http2-cdn-http2-usage.png",
  caption="CDNを利用したWebサイトのHTTP/2とgQUICの利用状況の比較。",
  description="CDNを使用しているウェブサイトのHTTP/2またはgQUICを使用したリクエストの割合を、使用していないサイトと比較した折れ線グラフです。X軸は、リクエストの割合で順に並べられたウェブページのパーセンタイルを示しています。CDNを使用していないWebサイトの23%は、HTTP/2またはgQUICを使用していません。一方、CDNを使用しているWebサイトの60%は、すべてのHTTP/2またはgQUICを使用しています。CDNを使用しているWebサイトの93%と、CDNを使用していないサイトの47%が50%以上のHTTP/2またはgQUICを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1779365083&format=interactive",
  sheets_gid="1457263817",
  sql_file="cdn_summary.sql"
)
}}

図22.13では、ウェブサイトがCDNを使用している場合のHTTP/2とgQUICの採用に大きな違いが見られます。CDNを使用している場合、70%のページがすべてのサードパーティのリクエストにHTTP/2を使用しています。CDNを使用しない場合は、25%のページのみがすべてのサードパーティのリクエストにHTTP/2を使用しています。

## HTTP/2のインパクト

プロトコルがどのように動作しているかの影響を測定することは、現在のHTTP Archive[アプローチ](./methodology)では困難です。同時接続の影響、パケットロスの影響、さまざまな輻輳制御メカニズムを定量化できるのは、本当に魅力的なことでしょう。実際にパフォーマンスを比較するには、各ウェブサイトを異なるネットワーク条件の各プロトコル上でクロールする必要があります。その代わりにできることは、ウェブサイトが使用する接続数への影響を調べることです。

### 接続を減らす

[前述](#http10からhttp2)したように、HTTP/1.1ではTCP接続で一度に1つのリクエストしかできません。ほとんどのブラウザは、ホストごとに6つの並列接続を許可することでこの問題を回避しています。HTTP/2の大きな改善点は、1つのTCP接続で複数のリクエストを多重化できることです。 これにより、ページをロードするために必要なコネクションの総数と、関連する時間とリソースを減らすことができます。

{{ figure_markup(
  image="http2-total-number-of-connections-per-page.png",
  caption="1ページあたりの総接続数の分布",
  description="デスクトップで2016年と2020年を比較した総接続数のパーセンタイル図。接続数の中央値は2016年が23、2020年が13。10パーセンタイルでは、2016年に6つの接続数、2020年に5つの接続数。25パーセンタイルでは、2016年に12の接続、2020年に8。75パーセンタイルでは、2016年に43接続、2020年に20接続。90パーセンタイルでは、2016年に76接続、2020年に33接続。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=17394219&format=interactive",
  sheets_gid="1432183252",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
)
}}

図22.15は、2016年と比較して2020年に1ページあたりのTCP接続数がどのように減少したかを示しています。すべてのウェブサイトの半数が、2016年には23個のTCP接続を使用していたのに対し、2020年には13個以下のTCP接続を使用するようになり、44%の減少となっています。同じ期間に、[リクエスト数の中央値]（https://httparchive.org/reports/state-of-the-web#reqTotal）は74から73に減少しただけです。TCP接続あたりのリクエスト数の中央値は3.2から5.6に増加しています。

TCPは、効率的かつ公平な平均的なデータフローを維持するように設計されています。各フローが他のフローに圧力をかけ、他のすべてのフローに反応して、ネットワークの公平なシェアを提供するフロー制御プロセスを想像してみてください。公平なプロトコルでは、すべてのTCPセッションが他のセッションを圧迫することはなく、時間の経過とともにパス容量の1/Nを占有することになります。

ウェブサイトの大部分は、今でも15のTCP接続で開かれています。HTTP/1.1では、ブラウザがドメインに対して開くことができる6つの接続は、時間の経過とともに単一のHTTP/2接続の6倍の帯域幅を要求できます。低容量ネットワークでは、競合する接続数が増加し、重要なリクエストから帯域幅を奪うため、プライマリアセットドメインからのコンテンツ配信が遅くなる可能性があります。これは、サードパーティドメインの数が少ないウェブサイトに有利です。

HTTP/2は、異なるが関連するドメイン間の<a hreflang="en" href="https://tools.ietf.org/html/rfc7540#section-9.1">接続の再利用</a>を可能にします。TLSリソースの場合、URI内のホストに対して有効な証明書を必要とします。これは、サイト作成者の管理下にあるドメインに必要な接続数を減らすために使用できます。

### 優先順位付け

HTTP/2レスポンスは多くの個々のフレームに分割でき、複数のストリームからのフレームを多重化できるため、フレームがインターリーブされてサーバーによって配信される順序が重要なパフォーマンスの考慮事項となります。典型的なウェブサイトは、可視コンテンツ（HTML、CSS、画像）、アプリケーションロジック（JavaScript）、広告、サイト利用状況を追跡するためのアナリティクス、マーケティングトラッキングビーコンなど多くの異なるタイプのリソースで構成されています。ブラウザがどのように動作するかを知ることで、最速のユーザー体験をもたらすリソースの最適な順序を定義できます。最適と非最適の違いは、パフォーマンスを50%以上向上させることができます。

HTTP/2は、クライアントがどのように多重化を行うべきだと考えているかをサーバへ伝えるために、優先順位付けの概念を導入しました。すべてのストリームには重み（利用可能な帯域幅のうちどれだけのストリームを割り当てるべきか）と親（最初に配信すべき別のストリーム）が割り当てられています。HTTP/2の優先順位付けモデルの柔軟性を考えると、現在のブラウザエンジンのすべてが<a hreflang="en" href="https://calendar.perfplanet.com/2018/http2-prioritization/">異なる優先順位付け戦略</a> を実装していても不思議ではありませんが、どれも<a hreflang="en" href="https://www.youtube.com/watch?v=nH4iRpFnf1c">最適</a> ではありません。

またサーバ側にも問題があり、多くのサーバでは優先順位付けがうまくいかなかったり、まったくできなかったりしています。 HTTP/1.xの場合、サーバ側の送信バッファーを可能な限り大きくするようにチューニングすることは、メモリ使用量の増加（CPUとメモリを交換する）以外には何のデメリットもなく、ウェブサーバのスループットを向上させる効果的な方法です。これはHTTP/2の場合はそうではありませんが、TCP送信バッファー内のデータは新しいより重要なリソースのリクエストが来た場合、再優先順位をつけることができません。 HTTP/2サーバでは、最適な送信バッファサイズは、利用可能な帯域幅を十分に利用するために必要な最小データ量です。これにより、より優先度の高いリクエストを受信した場合、サーバは即座に応答できます。

このように大きなバッファーが優先順位付けを混乱させる問題は、ネットワークにも存在し、「bufferbloat」と呼ばれています。 ネットワーク機器は、短いバーストがあるときにパケットをドロップするよりも、むしろパケットをバッファリングするでしょう。 しかし、サーバーがクライアントへのパスを消費できる以上のデータを送信すると、これらのバッファーは容量いっぱいになります。ネットワーク上にすでに「保存」されているこれらのバイトは、大きな送信バッファーがそうであるように、より優先度の高いレスポンスをより早く送信するサーバーの能力を制限します。バッファーに保持されるデータ量を最小化するには、<a hreflang="en" href="https://blog.cloudflare.com/http-2-prioritization-with-nginx/">BBRのような最近の輻輳制御アルゴリズムを使用する必要があります</a>.

Andy Daviesによって維持されているこの<a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">テストスイート</a> は、様々なCDNとクラウドホスティングサービスがどのようにパフォーマンスを発揮するかを測定し、報告しています。悪いニュースは、36のサービスのうち9つだけが正しく優先順位をつけているということです。図22.16は、CDNを使用しているサイトでは、約31.7%が正しく優先順位を付けていないことを示しています。これは昨年の26.82%から上昇していますが、これは主にGoogle CDNの利用が増えたことによるものです。ブラウザから送られてくる優先順位に頼るのではなく、代わりに<a hreflang="en" href="https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/">サーバ側優先順位付け</a> スキームを実装し、ブラウザのヒントを追加ロジックで改良しているサーバもあります。

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>正しく優先<br>順位をつける</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>CDNを使用していない</td>
        <td>不明</td>
        <td class="numeric">59.47%</td>
        <td class="numeric">60.85%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>パス</td>
        <td class="numeric">22.03%</td>
        <td class="numeric">21.32%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>失敗</td>
        <td class="numeric">8.26%</td>
        <td class="numeric">8.94%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>失敗</td>
        <td class="numeric">2.64%</td>
        <td class="numeric">2.27%</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>パス</td>
        <td class="numeric">2.34%</td>
        <td class="numeric">1.78%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>パス</td>
        <td class="numeric">1.31%</td>
        <td class="numeric">1.19%</td>
      </tr>
      <tr>
        <td>Automattic</td>
        <td>パス</td>
        <td class="numeric">0.93%</td>
        <td class="numeric">1.05%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>失敗</td>
        <td class="numeric">0.77%</td>
        <td class="numeric">0.63%</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>失敗</td>
        <td class="numeric">0.42%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>失敗</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.20%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTTP/2 prioritization support in common CDNs.", sheets_gid="1152953475", sql_file="percentage_of_h2_and_h3_sites_affected_by_cdn_prioritization.sql") }}</figcaption>
</figure>

CDN以外の利用では、HTTP/2の優先順位付けを正しく適用するサーバーの数はかなり少なくなると予想されます。例えば、NodeJSのHTTP/2実装は[優先順位付けをサポートしていません](https://x.com/jasnell/status/1245410283582918657)。

### さよならサーバープッシュ？

サーバープッシュはHTTP/2の追加機能の1つで、実際に実装するには混乱と複雑さの原因となりました。プッシュは、ブラウザ/クライアントがHTMLページをダウンロードし、そのページを解析し、そのページが追加のリソース（スタイルシートなど）を必要としていることを発見するのを待つことを避けようとしています。これらの作業と往復には時間がかかります。 サーバプッシュを使えば、理論的には、サーバは一度に複数のレスポンスを送信できるので、余分なラウンドトリップを避けることができます。

残念なことに、TCPの輻輳制御が効いていると、データ転送は非常に遅く、複数回の往復で転送速度が十分に向上するまでは、<a hreflang="en" href="https://calendar.perfplanet.com/2016/http2-push-the-details/">すべての資産をプッシュすることはできない</a>となります。また、クライアントの処理モデルが完全に合意されていなかったため、ブラウザ間では<a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">実装の違い</a>があります。例えば、ブラウザごとに _プッシュのキャッシュ_ 実装が異なります。

もう1つの問題は、ブラウザが既にキャッシュしたリソースをサーバの方で認識していないことです。サーバが不要なものをプッシュしようとすると、クライアントは `RST_STREAM`フレームを送信できますが、その時点でサーバはすでにすべてのデータを送信している可能性があります。 これは帯域幅を無駄にし、サーバはブラウザが実際に必要としたものをすぐに送信する機会を失ってしまいます。クライアントがキャッシュの状態をサーバに知らせることができるようにする<a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-httpbis-cache-digest-05">proposal</a> もありましたが、プライバシーの問題がありました。

下の図20.17からわかるように、サーバープッシュを利用しているサイトの割合は非常に少ない。

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>HTTP/2ページ</th>
        <th>HTTP/2(%)</th>
        <th>gQUICページ</th>
        <th>gQUIC(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">44,257</td>
        <td class="numeric">0.85%</td>
        <td class="numeric">204</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>モバイル</td>
        <td class="numeric">62,849</td>
        <td class="numeric">1.06%</td>
        <td class="numeric">326</td>
        <td class="numeric">0.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Pages using HTTP/2 or gQUIC server push.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

図22.18、図22.19のプッシュされたアセットの分布をさらに見てみると、デスクトップでは合計サイズ140KBのリソースを4個以下、モバイルではサイズ184KBのリソースを3個以下でプッシュしているサイトが半数を占めています。gQUICの場合は、デスクトップが7以下、モバイルが2となっています。最悪の違反ページは、デスクトップでgQUICを上回る _41アセット_ をプッシュしています。

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>HTTP/2</th>
        <th>サイズ(KB)</th>
        <th>gQUIC</th>
        <th>サイズ(KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">3.95</td>
        <td class="numeric">1</td>
        <td class="numeric">15.83</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">2</td>
        <td class="numeric">36.32</td>
        <td class="numeric">3</td>
        <td class="numeric">35.93</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">4</td>
        <td class="numeric">139.58</td>
        <td class="numeric">7</td>
        <td class="numeric">111.96</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">8</td>
        <td class="numeric">346.70</td>
        <td class="numeric">21</td>
        <td class="numeric">203.59</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">17</td>
        <td class="numeric">440.08</td>
        <td class="numeric">41</td>
        <td class="numeric">390.91</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribution of pushed assets on desktop.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>パーセンタイル</th>
        <th>HTTP/2</th>
        <th>サイズ(KB)</th>
        <th>gQUIC</th>
        <th>サイズ(KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">15.48</td>
        <td class="numeric">1</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">1</td>
        <td class="numeric">36.34</td>
        <td class="numeric">1</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">3</td>
        <td class="numeric">183.83</td>
        <td class="numeric">2</td>
        <td class="numeric">24.06</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">10</td>
        <td class="numeric">225.41</td>
        <td class="numeric">5</td>
        <td class="numeric">204.65</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">12</td>
        <td class="numeric">351.05</td>
        <td class="numeric">18</td>
        <td class="numeric">453.57</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribution of pushed assets on mobile.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

図 22.20のコンテンツタイプ別のプッシュの頻度を見ると、90%のページがスクリプトをプッシュし、56%がCSSをプッシュしていることがわかります。これらのファイルは通常、ページをレンダリングするためのクリティカルパス上にある小さなファイルである可能性があるため、これは理にかなっています。

{{ figure_markup(
  image="http2-pushed-content-types.png",
  caption="特定のコンテンツタイプをプッシュしているページの割合",
  description="デスクトップでリソースをプッシュするページについて、プッシュスクリプト89.1％、CSS67.9％、画像6.1％、フォント1.3％、その他0.7％、html0.7％の棒グラフを示しています。モバイルでは、90.29%のプッシュスクリプト、56.08%のCSS、3.69%の画像、0.97%のフォント、0.36%のその他、0.39%のhtml。", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1708672642&format=interactive",
  sheets_gid="238923402",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql"
)
}}

普及率が低いことと、プッシュされたリソースのうち実際に有用なものがどれだけ少ないか（つまり、キャッシュされていないリクエストにマッチするか）を測定した後、GoogleはHTTP/2とgQUICの両方について、<a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">Chromeからプッシュサポートを削除する意向</a>を発表しました。また、ChromeはHTTP/3のプッシュを実装していません。

これらすべての問題にもかかわらず、サーバープッシュが改善点を提供できる状況があります。理想的な使用例は、HTMLレスポンス自体よりもはるかに早い段階でプッシュの約束を送信できることです。これが利益をもたらすシナリオは、<a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317">CDNが使用されている場合</a>です。CDNがリクエストを受信してからオリジンからのレスポンスを受信するまでの「デッドタイム」をインテリジェントに利用して、TCP接続をウォームアップし、CDNですでにキャッシュされているアセットをプッシュできます。

しかし、アセットがプッシュされるべきであることをCDNエッジサーバにシグナルする方法は標準化されていなかった。その代わりに、プリロードHTTPリンクヘッダーを再利用した実装が行われていました。このシンプルなアプローチはエレガントに見えますが、実際のコンテンツの準備が整う前にヘッダーが送信されない限り、HTMLが生成されるまでのデッドタイムを利用していません。それは、HTMLがエッジで受信されるとリソースをプッシュするようにエッジをトリガーし、HTMLの配信と競合することになります。

テスト中の代替案として、<a hreflang="en" href="https://tools.ietf.org/html/rfc8297">RFC8297</a>があり、これは情報を提供する`103(Early Hints)`レスポンスを定義している。これにより、サーバが完全なレスポンスヘッダーを生成するのを待たずに、すぐにヘッダーを送ることができるようになる。これは、オリジンがCDNにプッシュされたリソースを提案したり、CDNがクライアントにフェッチする必要のあるリソースを警告したりするために使用できます。しかし現時点では、クライアントとサーバの両方の観点からのサポートは非常に低く、<a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">しかし、成長しています</a>。

## より良いプロトコルに到達するために

クライアントとサーバがHTTP/1.1とHTTP/2の両方をサポートしているとしましょう。どちらを使うかはどうやって選ぶのでしょうか？　最も一般的な方法はTLS[Application Layer Protocol Negotiation](https://ja.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) (ALPN) で、クライアントはサポートするプロトコルのリストをサーバに送信し、サーバはその接続に使用するプロトコルを選択します。 ブラウザはHTTPS接続を設定する際にTLSパラメーターをネゴシエートする必要があるため、同時にHTTPバージョンもネゴシエートできます。HTTP/2とHTTP/1.1の両方が同じTCPポート（443）から提供されるので、ブラウザは接続を開く前にこの選択をする必要はありません。

プロトコルが同じポートにない場合、異なるトランスポートプロトコルを使用している場合（TCPとQUIC）、あるいはTLSを使用していない場合は、このようなことはできません。これらのシナリオでは、最初に接続したポートで利用可能なものから始めて、他のオプションを見つけます。HTTPには、接続後にオリジンのプロトコルを変更するための2つのメカニズムが定義されています。`Upgrade`と`Alt-SVC`です。

### `Upgrade`

Upgradeヘッダーは長い間HTTPの一部でした。 HTTP/1.xでは、`Upgrade`によってクライアントはあるプロトコルを使ってリクエストを行い、別のプロトコル（HTTP/2のような）をサポートしていることを示すことができます。 サーバが提供されたプロトコルもサポートしている場合、サーバはステータス101(`Switching Protocols`)で応答し、新しいプロトコルでリクエストに応答します。 そうでない場合、サーバはHTTP/1.xでリクエストに応答する。 サーバは応答の`Upgrade`ヘッダーを使って別のプロトコルのサポートを示すことができます。

`Upgrade`の最も一般的なアプリケーションは[WebSockets](https://developer.mozilla.org/docs/Web/API/WebSockets_API)です。HTTP/2もまた、暗号化されていないクリアテキストモードで使用するための`Upgrade`パスを定義しています。しかし、Webブラウザでこの機能はサポートされていません。したがって、我々のデータセットに含まれるHTTP/1.1のクリアテキストリクエストのうち、応答に`Upgrade`ヘッダーが含まれていたのは3%未満であったことは驚くに値しません。非常に少数のTLSを使用するリクエスト（HTTP/2の0.0011%、HTTP/1.1の0.064%）もレスポンスで`Upgrade`ヘッダーを受け取っていました。これらは、HTTP/2を話したりTLSを終了させたりしているが、`Upgrade`ヘッダーを適切に削除していない仲介者の背後にあるクリアテキストHTTP/1.1サーバーである可能性が高いです。

### 代替サービス

Alternative Services(`Alt-SVC`)は、HTTPオリジンが同じコンテンツを提供する他のエンドポイントを示すことを可能にします。 珍しいことですが、HTTP/2はサイトのHTTP/1.1サービスとは異なるポートや異なるホストに位置しているかもしれません。さらに重要なことは、HTTP/3はQUIC（つまりUDP）を使用するので以前のバージョンのHTTPはTCPを使用していましたが、HTTP/3は常にHTTP/1.xやHTTP/2サービスとは異なるエンドポイントに位置しているということです。

`Alt-SVC`を使用する場合、クライアントは通常通りにオリジンへのリクエストを行う。 しかしサーバーがヘッダーを含むか、代替案のリストを含むフレームを送る場合、クライアントは他のエンドポイントへの新しい接続を行い、そのオリジンへの将来のリクエストにそれを使うことができます。

当然のことながら、`Alt-SVC`の使用はほとんどの場合、高度なHTTPバージョンを使用しているサービスから発見されています。 HTTP/1.xリクエストの0.055%と比較してHTTP/2リクエストの12.0%とgQUICリクエストの60.1%がレスポンスで`Alt-Svc`ヘッダーを受信しています。ここでの我々の方法論は`Alt-Svc`ヘッダーのみをキャプチャしており、HTTP/2の`ALTSVC`フレームはキャプチャしていないことに注意してください。

`Alt-Svc`は全く異なるホストを指すことができますが、この機能のサポートはブラウザによって異なります。`Alt-Svc`ヘッダーのうち、異なるホスト名のエンドポイントを広告しているのはわずか4.71%でしたが、これらはほぼすべて（99.5%）Google Ads上のgQUICとHTTP/3サポートを広告していました。Google ChromeはHTTP/2のクロスホストの`Alt-SVC`広告を無視するので、他の多くのインスタンスは無視されているでしょう。

クロスホストHTTP/2のサポートの希少性を考えると、`Alt-Svc`を使用したHTTP/2エンドポイントの広告が実質的にゼロ（0.007%）であったことは驚くべきことではありません。`Alt-Svc`は通常、HTTP/3（`Alt-Svc`ヘッダーの74.6%）やgQUIC（`Alt-Svc`ヘッダーの38.7%）のサポートを示すために使用されていました。

## HTTP/3の未来に向けて

HTTP/2は強力なプロトコルで、わずか数年でかなりの採用が見られました。しかし、QUICを利用したHTTP/3がすでに登場しています。4年以上の歳月をかけて作られたHTTPの次のバージョンは、IETFでほぼ標準化されています（2021年の前半に予定されています）。この時点で、すでに<a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">多くのQUICとHTTP/3の実装が利用可能</a>で、サーバ用とブラウザ用の両方があります。これらは比較的成熟しているとはいえ、まだ実験的な状態にあるといえます。

これは、HTTP Archiveデータの使用数に反映されていますが、HTTP/3リクエストは全く確認されていませんでした。これは少し奇妙に思えるかもしれませんが、<a hreflang="en" href="https://blog.cloudflare.com/experiment-with-http-3-using-nginx-and-quiche/">Cloudflare</a> はGoogleやFacebookと同様、実験的にHTTP/3をサポートしていました。これは主に、データ収集時にChromeがデフォルトでHTTP/3プロトコルを有効にしていなかったためです。

しかし、古いgQUICの数字でさえ、全体のリクエストの2%未満を占める比較的控えめなものでした。これは、gQUICのほとんどがGoogleとアカマイによって導入され、その他の関係者はIETF QUICを待っていたため、予想されていたことです。このように、gQUICはまもなくHTTP/3に完全に置き換えられると予想されています。

{{ figure_markup(
  caption="デスクトップとモバイルでgQUICを使用するリクエストの割合",
  content="1.72%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

この採用率の低さは、WebページをロードするためのgQUICとHTTP/3の使用状況を反映しているに過ぎないことに注意が必要です。すでに数年前から、Facebookはネイティブアプリケーション内でデータをロードするために、IETF QUICとHTTP/3をより広範囲に展開しています。<a hreflang="en" href="https://engineering.fb.com/2020/10/21/networking-traffic/how-facebook-is-bringing-quic-to-billions/">QUICとHTTP/3はすでに彼らの総インターネットトラフィックの75%以上を占めています</a>。HTTP/3がまだ始まったばかりであることは明らかです。

今、あなたは疑問に思うかもしれません: もし誰もが既にHTTP/2を使っていないのであれば、なぜすぐにHTTP/3が必要なのでしょうか？　実際にはどのような利点があるのでしょうか？　内部メカニズムを詳しく見てみましょう。

### QUICとHTTP/3

インターネット上に新しいトランスポートプロトコルを展開しようとする過去の試みは、[Stream Control Transmission Protocol](https://ja.wikipedia.org/wiki/Stream_Control_Transmission_Protocol) (SCTP)のように困難であることが証明されています。QUICはUDPの上で動作する新しいトランスポートプロトコルです。QUICは、信頼性の高い順番配信やネットワークへのフラッディングを防ぐ輻輳制御など、TCPと同様の機能を提供します。

[HTTP/1.0とHTTP/2](#http10からhttp2)で説明したように、HTTP/2は1つの接続の上に複数の異なるストリームを _多重化_ しています。TCP自体はこの事実に気付いていないため、パケットロスや遅延が発生したときに非効率やパフォーマンスに影響を与えてしまいます。 _head-of-line blocking_  (HOL blocking)<a hreflang="en" href="https://github.com/rmarx/holblocking-blogpost">として知られるこの問題の詳細については、こちらを参照してください</a>。

QUICはHTTP/2のストリームをトランスポート層に落とし、ストリームごとの損失検出と再送を行うことで、HOLブロッキングの問題を解決します。つまり、HTTP/2をQUICの上に置けばいいんですよね？　さて、TCPとHTTP/2でフロー制御を行うことで発生する問題のいくつかを[すでに述べました](#接続を減らす)。2つの独立した競合するストリーミングシステムを重ねて実行することは、さらなる問題となるでしょう。さらに、QUICストリームは独立しているので、HTTP/2がシステムのいくつかに要求する厳格な順序付けの要件を混乱させることになります。

最終的には、QUICを直接使用する新しいHTTPバージョンを定義する方が簡単だと判断され、HTTP/3が誕生しました。その高レベルの機能はHTTP/2から知っているものと非常に似ていますが、内部の実装メカニズムはかなり異なっています。HPACKヘッダー圧縮は<a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-quic-qpack-19">QPACK</a>に置き換えられ、圧縮効率とHOLブロッキングリスクのトレードオフを<a hreflang="en" href="https://blog.litespeedtech.com/tag/quic-header-compression-design-team/">手動で調整</a>することが可能になり、優先順位付けシステムは<a hreflang="en" href="https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/">よりシンプルなものに置き換え</a>られています。後者はHTTP/2にバックポートすることも可能で、この記事で以前に議論した優先順位付けの問題を解決するのに役立つかもしれません。HTTP/3はサーバプッシュの仕組みを提供し続けていますが、例えばChromeはそれを実装していません。

QUICのもう1つの利点は、基盤となるネットワークが変化しても、接続を移行して維持できることです。典型的な例は、いわゆる「駐車場問題」です。あなたのスマートフォンが職場のWi-Fiネットワークに接続されていて、大きなファイルをダウンロードし始めたところを想像してみてください。あなたがWi-Fiの範囲から離れると、あなたのスマートフォンは自動的に新しい5Gセルラーネットワークに切り替わります。普通の古いTCPでは、接続が切れて中断してしまいます。しかしQUICはよりスマートで、ネットワークの変化に強く、クライアントが中断することなく切り替えられるようにアクティブな _接続マイグレーション_ 機能を提供しています。

最後に、HTTP/1.1とHTTP/2の保護にはすでにTLSが使われています。しかし、QUICはTLS1.3を深く統合しており、HTTP/3のデータとQUICのパケット番号などのメタデータの両方を保護しています。このようにTLSを使用することで、エンドユーザーのプライバシーとセキュリティが向上し、プロトコルの継続的な進化が容易になります。トランスポートと暗号化ハンドシェイクを組み合わせることで、TCPの最低2回のRTTと最悪の場合4回のRTTが必要なのに対し、接続設定は1回で完了します。場合によっては、QUICはさらに一歩進んで、 _0-RTT_ と呼ばれる最初のメッセージと共にHTTPデータを送信します。これらの高速な接続設定時間は、HTTP/3がHTTP/2よりも優れた性能を発揮するのに役立つと期待されています。

**では、HTTP/3は役に立つのでしょうか？**

表面上では、HTTP/3はHTTP/2と実際にはそれほど違いはありません。大きな機能は追加されていませんが、主に既存の機能を変更しています。真の改善点はQUICによるもので、接続設定の高速化、ロバスト性の向上、パケットロスへの耐性の向上などが挙げられます。このようにHTTP/3は、より悪いネットワークではHTTP/2よりも優れたパフォーマンスを発揮し、より速いシステムでは非常に似たようなパフォーマンスを提供することが期待されています。しかし、それはウェブコミュニティがHTTP/3を動作させることができればの話ですが、実際には難しいかもしれません。

### HTTP/3の導入と検出

QUICとHTTP/3はUDPで動作するので、HTTP/1.1やHTTP/2のように単純ではありません。通常、HTTP/3クライアントは、まずQUICがサーバで利用可能であることを発見しなければなりません。このために推奨される方法は、[HTTP Alternative Services](#代替サービス) です。ウェブサイトへの最初の訪問では、クライアントはTCPを使ってサーバに接続します。その後、`Alt-SVC`を通じてHTTP/3が利用可能であることを発見し、新しいQUIC接続を設定できます。`Alt-SVC`のエントリはキャッシュされ、後続の訪問でTCPのステップを回避できますが、エントリは最終的に陳腐化し再検証が必要になります。これはおそらく各ドメインごとに個別に行う必要があり、ほとんどのページロードはHTTP/1.1、HTTP/2、HTTP/3のミックスを使用することになるでしょう。

しかし、サーバーがQUICやHTTP/3をサポートしていることがわかっていても、その間のネットワークがブロックしてしまう可能性があります。UDPトラフィックはDDoS攻撃で一般的に使用されており、例えば多くの企業ネットワークではデフォルトでブロックされています。QUICには例外があるかもしれませんが、暗号化されているため、ファイアウォールがトラフィックを評価することは困難です。これらの問題に対する潜在的な解決策はありますが、当面の間、QUICは443のようなよく知られたポートで成功する可能性が高いと予想されています。そして、それは完全にQUICをブロックされていることが完全に可能です。実際には、QUICが失敗した場合、クライアントはTCPにフォールバックするため洗練されたメカニズムを使用する可能性が高い。1つの選択肢は、TCPとQUICの両方の接続を「レース」して、最初に完了した方を使用することです。

TCPステップを必要とせずにHTTP/3を検出する方法を定義するための進行中の作業があります。UDPのブロッキングの問題はTCPベースのHTTPの利用を意味しそうなので、これは最適化と考えるべきでしょう。<a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-dnsop-svcb-https">HTTPS DNSレコード</a> はHTTP Alternative Servicesと似ており、いくつかのCDNはすでに<a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">これらのレコードを使って実験中</a> です。 長期的には、ほとんどのサーバがHTTP/3を提供するようになったら、ブラウザはデフォルトでそれを試みるように切り替えるかもしれません。

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">HTTP/1.x</th>
        <th scope="colgroup" colspan="2">HTTP/2</th>
      </tr>
      <tr>
        <th scope="col">TLSバージョン</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>不明</td>
        <td class="numeric">4.06%</td>
        <td class="numeric">4.03%</td>
        <td class="numeric">5.05%</td>
        <td class="numeric">7.28%</td>
      </tr>
      <tr>
        <td>TLS 1.2</td>
        <td class="numeric">26.56%</td>
        <td class="numeric">24.75%</td>
        <td class="numeric">23.12%</td>
        <td class="numeric">23.14%</td>
      </tr>
      <tr>
        <td>TLS 1.3</td>
        <td class="numeric">5.25%</td>
        <td class="numeric">5.11%</td>
        <td class="numeric">35.78%</td>
        <td class="numeric">35.54%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="TLS adoption by HTTP version.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

図22.21に示すように、QUICはTLS1.3に依存しており、リクエストの約41%で使用されています。これでは59%のリクエストがHTTP/3をサポートするためにTLSスタックを更新する必要があることになります。

### HTTP/3はまだですか？

では、いつからHTTP/3とQUICを本格的に使えるようになるのでしょうか？　まだまだですが、うまくいけばもうすぐです。<a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">多数の成熟したオープンソース実装</a>があり、主要なブラウザは実験的にサポートしています。しかし、代表的なサーバのほとんどは、いくつかの遅れに苦しんでいます。nginxは他のスタックより少し遅れており、Apacheは公式のサポートを発表しておらず、NodeJSはOpenSSLに依存しており、<a hreflang="en" href="https://github.com/openssl/openssl/pull/8797">QUICのサポートはいつでもすぐには追加されません</a>。それでも、2021年を通してHTTP/3とQUICのデプロイが増加することを期待しています。

HTTP/3とQUICは、新しいHTTP優先順位付けシステム、HOLブロッキング除去、0-RTT接続確立など、強力なパフォーマンスとセキュリティ機能を備えた高度なプロトコルです。この高度なプロトコルは、HTTP/2のように、正しく展開して使用することが難しいプロトコルでもあります。初期の導入は、主にCloudflare、Fastly、AkamaiなどのCDNの早期導入によって行われると予測しています。これはおそらく、HTTP/2トラフィックの大部分が2021年に自動的にHTTP/3にアップグレードされることを意味しており、新しいプロトコルに大きなトラフィックシェアを与えることになるでしょう。小規模な導入がいつ、そしてそれに追随するかどうかは、答えを出すのが難しいところです。おそらく、HTTP/3、HTTP/2、さらにはHTTP/1.1の健全な組み合わせが今後何年にもわたってウェブ上で見られることになるでしょう。

## 結論

今年は、HTTP/2が支配的なプロトコルとなり、全リクエストの64%を提供しており、この1年で10%ポイント増加しました。ホームページはHTTP/2の採用率が13%増加し、HTTP/1.1とHTTP/2で提供されるページが均等に分かれています。ホームページを提供するためにCDNを使用すると、HTTP/2の採用率は80%まで上昇しますが、CDNを使用しない場合は30%となっています。ApacheやIISなどの古いサーバは、HTTP/2やTLSへのアップグレードに抵抗があります。大きな成功は、HTTP/2接続多重化によるWebサイトの接続使用量の減少です。2016年の接続数の中央値は23だったのに対し、2020年は13でした。

HTTP/2の優先順位付けとサーバープッシュは、大規模な展開を行うにはより複雑であることが判明しました。特定の実装の下では、これらの機能は明らかにパフォーマンス上の利点を示しています。しかし、これらの機能を効果的に使用するために、既存のサーバーをデプロイしてチューニングすることには大きな障壁があります。優先順位付けを効果的にサポートしていないCDNの割合が依然として大きい。また、ブラウザの一貫したサポートにも問題があります。

HTTP/3はすぐそこまで来ています。普及率を追い、発見メカニズムがどのように進化していくのか、そしてどの新機能が成功裏に導入されるのかを見極めることは非常に興味深いことでしょう。来年のWeb Almanacでは、興味深い新データが出てくることを期待しています。
