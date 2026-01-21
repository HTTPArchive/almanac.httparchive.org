---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: CDNの採用と使用法、RTTとTLSの管理、HTTP/2の採用、キャッシング、および共通ライブラリとコンテンツCDNをカバーする2019 Web AlmanacのCDNの章。
hero_alt: Hero image of Web Almanac characters extending a plug from a cloud into a web page.
authors: [andydavies, colinbendell]
reviewers: [yoavweiss, paulcalvano, pmeenan, enygren]
analysts: [raghuramakrishnan71, rviscomi]
editors: [rviscomi]
translators: [ksakae1216]
discuss: 1772
results: https://docs.google.com/spreadsheets/d/1Y7kAxjxUl8puuTToe6rL3kqJLX1ftOb0nCcD8m3lZBw/
andydavies_bio: Andy Daviesはフリーランスのウェブパフォーマンスコンサルタントであり、英国の大手小売業者、新聞社、金融サービス会社のサイトの高速化を支援してきました。彼は『ウェブパフォーマンスのポケットガイド』を執筆し、『Using WebPageTest』の共著者であり、ロンドンのウェブパフォーマンス・ミートアップの主催者でもあります。アンディは Twitter で <a href="https://x.com/andydavies">@AndyDavies</a> として活動しており、<a hreflang="en" href="https://andydavies.me">https://andydavies.me</a> で時々ブログを更新しています。
colinbendell_bio: Colinは、<a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>のCTOオフィスの一員であり、オライリーの本<a hreflang="en" href="https://www.oreilly.com/library/view/high-performance-images/9781491925799/">High Performance Images</a>の共著者でもあります。彼は、大容量データ、メディア、ブラウザ、標準の交差点で多くの時間を過ごしています。<a href="https://x.com/colinbendell">@colinbendell</a> や <a hreflang="en" href="https://bendell.ca/">https://bendell.ca</a> のブログで彼を見つけることができます。
featured_quote: "コンテンツデリバリネットワークを使用する"は、Webサイトの読み込みを高速化するためのSteve Soudersのオリジナルの推奨事項の1つです。Web Almanacのこの章では、スティーブの推奨事項がどれだけ広く採用されているか、サイトがどのようにコンテンツデリバリネットワーク(CDN)を使用しているか、そして使用している機能のいくつかを探っていきます。
featured_stat_1: 20%
featured_stat_label_1: CDNが提供するホームページ
featured_stat_2: 9.61%
featured_stat_label_2: 最も人気のあるCDN（Cloudflare）が提供するホームページ
featured_stat_3: 30%
featured_stat_label_3: Googleを利用したサードパーティCDNリクエスト
---

## 導入

「コンテンツ配信ネットワーク」は、Webサイトの読み込みを高速化するための[Steve Soudersによる独自の推奨事項](http://stevesouders.com/examples/rules.php)の1つでした。昨今でも有効なアドバイスです。Web Almanacのこの章ではSteveの推奨事項がどの程度広く採用されているか、サイトがコンテンツ配信ネットワーク（CDN）をどのように使用しているか、およびそれらが使用している機能のいくつかを検討します。

基本的にCDNは待ち時間（パケットがネットワーク上の2つのポイント間、たとえば訪問者のデバイスからサーバーに移動する時間）を短縮します、待ち時間はページの読み込み速度の重要な要素です。

CDNは、2つの方法で待機時間を短縮します。ユーザーに近い場所からコンテンツを提供すること、2番目はエンドユーザーに近いTCP接続を終了することです。

歴史的にユーザーからバイトへの論理パスが短くなるように、CDNはバイトのキャッシュまたはコピーに使用されていました。多くの人が要求するファイルは、origin（サーバー）から一度取得してユーザーに近いサーバーへ保存できるため、転送時間を節約できます。

CDNは、TCP遅延にも役立ちます。 TCPの遅延により、ブラウザーとサーバー間の接続を確立するのにかかる時間、接続を保護するのにかかる時間、および最終的にコンテンツをダウンロードする速度が決まります。せいぜいネットワークパケットは光の速度の約3分の2で移動するため、その往復にかかる時間は通信の両端がどれだけ離れているか、その間に何があるかによって決まります。混雑したネットワーク、過負荷の機器、ネットワークのタイプすべてがさらなる遅延を追加します。 CDNを使用して接続のサーバー側を訪問者の近くに移動すると、この遅延のペナルティが減少し、接続時間、TLSネゴシエーション時間が短縮されコンテンツのダウンロード速度が向上します。

CDNは、多くの場合、訪問者の近くで静的コンテンツを保存および提供する単なるキャッシュと考えられていますが、さらに多くの機能を備えています。 CDNは、遅延のペナルティを克服するだけでなく、パフォーマンスとセキュリティの向上に役立つ他の機能を提供するものが増えています。

* CDNを使用して動的コンテンツ（ベースHTMLページ、API応答など）をプロキシすることにより、ブラウザーとCDN自身のネットワークとの間の遅延が短縮され、元の速度に戻ることができます。
* 一部のCDNは、ページを最適化してダウンロードとレンダリングを高速化する変換を提供するか、画像を最適化して表示するデバイスに適したサイズ（画像の大きさとファイルサイズの両方）に変換します。
* [セキュリティ](./security)の観点から、悪意のあるトラフィックとボットは要求がoriginへ到達する前にCDNによって除外される可能性があり、その幅広い顧客ベースによりCDNが新しい脅威をより早く発見して対応できることを意味します。
* [エッジコンピューティング](https://en.wikipedia.org/wiki/Edge_computing)の台頭により、サイトは訪問者の近くで独自のコードを実行できるようになりパフォーマンスが向上し、originの負荷が軽減されました。

最後にCDNもまた、originサーバーがサポートしていない場合でもエッジからブラウザーまでHTTP/2、TLS1.3、またはIPv6を有効にできるなどoriginでの変更を必要とせずにサイトが新しいテクノロジーを採用できるようにします。

### 警告と免責事項

他の観察研究と同様に、測定できる範囲と影響には限界があります。 Web AlmanacのCDN使用に関して収集された統計は、特定のCDNベンダーのパフォーマンスや有効性を意味するものではありません。

Web Almanacに使用されるテスト[方法](./methodology)には多くの制限があります。これらには以下が含まれます。

* **シミュレートされたネットワーク遅延**：Web Almanacは、[トラフィックを総合的に形成する](./methodology#webpagetest)専用ネットワーク接続を使用します。
* **単一の地理的場所**：テストは<a hreflang="en" href="https://httparchive.org/faq#how-is-the-data-gathered">単一のデータセンター</a>から実行されるため、多くのCDNベンダーの地理的分布をテストすることはできません。
* **キャッシュの有効性**：各CDNは独自の技術を使用しており、多くの場合、セキュリティ上の理由により、キャッシュのパフォーマンスは公開されていません。
* **ローカライゼーションと国際化**：地理的分布と同様に言語、地理固有のドメインの影響もテストに対して不透明です。
* <a hreflang="en" href="https://github.com/WPO-Foundation/wptagent/blob/master/internal/optimization_checks.py#L51">CDN検出</a>は、主にDNS解決とHTTPヘッダーを介して行われます。ほとんどのCDNは、DNS CNAMEを使用してユーザーを最適なデータセンターにマッピングします。ただし、一部のCDNはAnyCast IPを使用するか、DNSチェインを隠す委任されたドメインからのA+AAAA応答を直接使用します。それ以外の場合、Webページは複数のCDNを使用して、[WebPageTest](./methodology#webpagetest)のシングルリクエストパスから隠されているベンダー間でバランスを取ります。これらはすべて、測定の有効性を制限します。

最も重要なことは、これらの結果は潜在的な使用率を反映しているが、実際の影響を反映していないことです。 YouTubeは「ShoesByColin」よりも人気がありますが、使用率を比較するとどちらも同じ値として表示されます。

これを念頭に置いて、CDNのコンテキストで測定されなかったいくつかの意図的な統計があります。
* **TTFB**：CDNによる最初のバイトまでの時間について、キャッシュ可能とキャッシュの有効性についての正しい知識がなければ正しく測定できません。1つのサイトには、**ラウンドトリップタイム**（RTT）の管理にCDNを使用してるがキャッシュには使用してない場合、別のCDNベンダーを使用してコンテンツをキャッシュしてる別サイトと比較する時不利になります（注：これは、個々のCDNの[パフォーマンス](./performance#最初のバイトまでの時間time-to-first-byte-ttfb)についての結論を出していないので、パフォーマンスの章でTTFB分析には適用されません）。
* **キャッシュヒットとキャッシュミスのパフォーマンス**：前述のようにこれは正確にテストできません、なのでコールドキャッシュとホットキャッシュでページのパフォーマンステストを繰り返すことは信頼できません。

### さらなる統計

Web Almanacの将来のバージョンでは、CDNベンダー間のTLSおよびRTTの管理をより詳細に検討する予定です。興味深いのは、OCSP Staplingの影響、TLS暗号パフォーマンスの違いです。 CWND（TCP輻輳ウィンドウ）成長率、特にBBR v1、v2、従来のTCP Cubicの採用。

## CDNの採用と使い方

ウェブサイトの場合、CDNはプライマリドメイン（`www.shoesbycolin.com`）、サブドメインまたは兄弟ドメイン（`images.shoesbycolin.com`または`checkout.shoesbycolin.com`）、そして最後にサードパーティ（Google Analyticsなど）のパフォーマンスを改善できます。これらの各ユースケースにCDNを使用すると、さまざまな方法でパフォーマンスが向上します。

歴史的に、CDNは[CSS](./css)、[JavaScript](./javascript)、[画像](./media)などの静的リソース専用に使用されていました。これらのリソースはおそらくバージョン管理され（パスに一意の番号を含む）、長期的にキャッシュされます。このようにして、ベースHTMLドメインと比較して、サブドメインまたは兄弟ドメインでのCDNの採用が増加することを期待する必要があります。従来のデザインパターンでは、`www.shoesbycolin.com`がデータセンター（又は**origin**）から直接HTMLを提供し、`static.shoesbycolin.com`がCDNを使用することを想定していました。

{{ figure_markup(
  image="fig1.png",
  caption="1. CDN使用量 vs. originがホストするリソース",
  description="HTMLがoriginから提供される80％、CDNから20％、サブドメインが61％と39％、サードパーティが34％と66％である積層棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=777938536&format=interactive"
  )
}}

実際、この伝統的なパターンは、クロールされたWebサイトの大部分で見られるものです。 Webページの大部分（80％）は、元のベースHTMLを提供しています。この内訳はモバイルとデスクトップでほぼ同じであり、デスクトップでのCDNの使用率は0.4％しか低下していません。このわずかな差異は、CDNをより頻繁に使用するモバイル固有のWebページ（「mDot」）の小規模な継続使用に起因する可能性があります。

同様に、サブドメインから提供されるリソースは、サブドメインリソースの40％でCDNを利用する可能性が高くなります。サブドメインは、画像やCSSなどのリソースを分割するために使用されるか、チェックアウトやAPIなどの組織チームを反映するために使用されます。

ファーストパーティのリソースの大部分は依然としてoriginから直接提供されていますが、サードパーティのリソースはCDNの採用が大幅に増えています。すべてのサードパーティリソースのほぼ66％がCDNから提供されています。サードパーティのドメインはSaaS統合である可能性が高いため、CDNの使用はこれらのビジネス製品のコアになる可能性が高くなります。ほとんどのサードパーティコンテンツは共有リソース（JavaScriptまたはフォントCDN）、拡張コンテンツ（広告）、または統計に分類されます。これらすべての場合においてCDNを使用すると、SaaSソリューションのパフォーマンスとオフロードが向上します。

## トップCDNプロバイダー
CDNプロバイダーには、汎用CDNと目的別CDNの2つのカテゴリがあります。汎用CDNプロバイダーは、多くの業界のあらゆる種類のコンテンツを提供するカスタマイズと柔軟性を提供します。対照的に、目的に合ったCDNプロバイダーは同様のコンテンツ配信機能を提供しますが、特定のソリューションに焦点を絞っています。

これは、ベースHTMLコンテンツを提供していることが判明した上位のCDNを見ると明確に表されています。 HTMLを提供する最も頻繁なCDNは、汎用CDN（Cloudflare、Akamai、Fastly）およびプラットフォームサービスの一部としてバンドルされたCDN（Google、Amazon）を提供するクラウドソリューションプロバイダーです。対照的に、WordpressやNetlifyなど、ベースHTMLマークアップを提供する目的に合ったCDNプロバイダーはわずかです。

<aside class="note">注：これにはトラフィックや使用量は反映されず、それらを使用するサイトの数のみが反映されます。</aside>

{{ figure_markup(
  image="html_cdn_usage.png",
  caption="HTML CDNの使用",
  description="表3のデータを示すツリーマップグラフ。"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">HTML CDNの使用率 (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">80.39</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">9.61</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">5.54</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">1.08</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">1.05</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0.79</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">0.37</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0.31</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0.28</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">0.1</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0.08</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">0.04</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">0.03</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0.03</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0.02</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Level 3</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Instart Logic</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Azion</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Yunjiasu</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0.01</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0.01</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="サイトごとのHTML上位25のCDN。") }}</figcaption>
</figure>

サブドメインリクエストの構成は非常に似ています。多くのWebサイトは静的コンテンツにサブドメインを使用しているため、CDNの使用量は増加する傾向があります。ベースページリクエストと同様に、これらのサブドメインから提供されるリソースは、一般的なCDN提供を利用します。

{{ figure_markup(
  image="subdomain_resource_cdn_usage.png",
  caption="サブドメインリソースのCDNの使用。",
  description="表5のデータを示すツリーマップグラフ。"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">サブドメインのCDN使用率(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">60.56</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">10.06</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">8.86</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">6.24</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">3.5</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">1.97</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">1.69</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">1.24</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td class="numeric">1.18</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0.8</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">0.43</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td class="numeric">0.41</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0.37</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0.36</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0.29</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0.28</td>
      </tr>
      <tr>
        <td>Reflected Networks</td>
        <td class="numeric">0.28</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0.16</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td class="numeric">0.13</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0.12</td>
      </tr>
      <tr>
        <td>Advanced Hosters CDN</td>
        <td class="numeric">0.1</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">0.07</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td class="numeric">0.07</td>
      </tr>
      <tr>
        <td>Level 3</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td class="numeric">0.06</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="表5のデータを示すツリーマップグラフ。") }}</figcaption>
</figure>

上位CDNプロバイダーの構成は、サードパーティのリソースに対して劇的に変化します。サードパーティのリソースをホストするCDNが頻繁に監視されるだけでなく、Facebook、Twitter、Googleなどの目的に合ったCDNプロバイダーも増加しています。

{{ figure_markup(
  image="thirdparty_resource_cdn_usage.png",
  caption="サードパーティのリソースCDN使用。",
  description="表7のデータを示すツリーマップグラフ。",
  width=600,
  height=376
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">サードパーティのCDN使用率(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">34.27</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">29.61</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td class="numeric">8.47</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">5.25</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">5.14</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">4.21</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">3.87</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">2.06</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">1.45</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td class="numeric">1.27</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0.94</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0.77</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">0.3</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>jsDelivr</td>
        <td class="numeric">0.2</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0.18</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td class="numeric">0.18</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td class="numeric">0.17</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td class="numeric">0.16</td>
      </tr>
      <tr>
        <td>Reapleaf</td>
        <td class="numeric">0.15</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">0.14</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td class="numeric">0.13</td>
      </tr>
      <tr>
        <td>Azion</td>
        <td class="numeric">0.09</td>
      </tr>
      <tr>
        <td>StackPath</td>
        <td class="numeric">0.09</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="サードパーティのリクエストの上位25のリソースCDN。") }}</figcaption>
</figure>

## RTTとTLS管理

CDNは、Webサイトのパフォーマンスのために単純なキャッシング以上のものを提供できます。多くのCDNは、コンテンツのキャッシュを禁止する法的要件またはその他のビジネス要件がある場合、動的またはパーソナライズされたコンテンツのパススルーモードもサポートします。 CDNの物理的な配布を利用すると、エンドユーザーのTCP RTTのパフォーマンスが向上します。<a hreflang="en" href="https://www.igvita.com/2012/07/19/latency-the-new-web-performance-bottleneck/">他の人が指摘したように</a>、<a hreflang="en" href="https://hpbn.co/primer-on-latency-and-bandwidth/">RTTを減らすことは、帯域幅を増やすことに比べてWebページのパフォーマンスを向上させる最も効果的な手段です</a>。

この方法でCDNを使用すると、次の2つの方法でページのパフォーマンスを改善できます。

1. TCPおよびTLSネゴシエーションのRTTを削減します。光の速度は非常に高速であり、CDNはエンドユーザーにより近い、高度に分散したデータセンターのセットを提供します。このようにして、TCP接続をネゴシエートしてTLSハンドシェイクを実行するためにパケットを通過する必要がある論理（そして物理）距離を大幅に短縮できます。

  RTTの削減には、3つの直接的な利点があります。まず、TCP + TLS接続時間はRTTにバインドされているため、ユーザーがデータを受信する時間を短縮します。第二に、これにより輻輳ウィンドウを拡大し、ユーザーが利用できる帯域幅を最大限活用するのにかかる時間が改善されます。最後に、パケット損失の可能性を減らします。 RTTが高い場合、ネットワークインタフェースは要求をタイムアウトし、パケットを再送信します。これにより、二重パケットを配信される可能性があります。

2. CDNは、バックエンドoriginへの事前に暖められたTCP接続を利用できます。ユーザーに近い接続を終了すると、輻輳ウィンドウの拡大にかかる時間が改善されるのと同様に、CDNは輻輳ウィンドウを既に最大化して事前に確立したTCP接続で要求をoriginにリレーできます。このようにして、originはより少ないTCPラウンドトリップで動的コンテンツを返すことができ、コンテンツを待機中のユーザーに配信する準備をより効果的に行うことができます。

## TLSネゴシエーション時間：originはCDNの3倍遅い

TLSネゴシエーションでは、サーバーからデータを送信する前に複数のTCPラウンドトリップが必要になるため、RTTを改善するだけでページのパフォーマンスを大幅に改善できます。たとえば、ベースHTMLページを見ると、発信元リクエストのTLSネゴシエーション時間の中央値は207ミリ秒です（デスクトップWebPageTestの場合）。これだけで、2秒のパフォーマンス予算の10％を占めます。これは、要求に遅延が適用されない理想的なネットワーク条件下です。

対照的に、大半のCDNプロバイダーのTLSネゴシエーションの中央値は60〜70ミリ秒です。 HTMLページに対するOrigin要求は、CDNを使用するWebページよりも、TLSネゴシエーションを完了するのにほぼ3倍時間がかかります。 90パーセンタイルでも、140ミリ秒未満で完了するほとんどのCDNと比較して、この格差は427ミリ秒のoriginTLSネゴシエーションレートで永続します。

<aside class="note">これらのチャートを解釈する際の注意事項：実際のTLSネゴシエーションのパフォーマンスに影響する多くの要因があるため、ベンダーを比較するとき、桁の違いに焦点を合わせることが重要です。これらのテストは、制御された条件下で単一のデータセンターから完了したものであり、インターネットおよびユーザーエクスペリエンスの変動を反映していません。</aside>

{{ figure_markup(
  image="html_tls_negotiation_time.png",
  caption="HTML TLSネゴシエーション時間。",
  description="表9のデータを示すグラフ。"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col"><span class="visually-hidden">10パーセンタイル</span><span aria-hidden="true">p10</span></th>
        <th scope="col"><span class="visually-hidden">25パーセンタイル</span><span aria-hidden="true">p25</span></th>
        <th scope="col"><span class="visually-hidden">50パーセンタイル</span><span aria-hidden="true">p50</span></th>
        <th scope="col"><span class="visually-hidden">75パーセンタイル</span><span aria-hidden="true">p75</span></th>
        <th scope="col"><span class="visually-hidden">90パーセンタイル</span><span aria-hidden="true">p90</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">58</td>
        <td class="numeric">58</td>
        <td class="numeric">60</td>
        <td class="numeric">66</td>
        <td class="numeric">94</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">56</td>
        <td class="numeric">59</td>
        <td class="numeric">63</td>
        <td class="numeric">69</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">58</td>
        <td class="numeric">62</td>
        <td class="numeric">76</td>
        <td class="numeric">77</td>
        <td class="numeric">80</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">63</td>
        <td class="numeric">66</td>
        <td class="numeric">77</td>
        <td class="numeric">80</td>
        <td class="numeric">86</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">59</td>
        <td class="numeric">61</td>
        <td class="numeric">62</td>
        <td class="numeric">83</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">62</td>
        <td class="numeric">68</td>
        <td class="numeric">80</td>
        <td class="numeric">92</td>
        <td class="numeric">103</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">57</td>
        <td class="numeric">59</td>
        <td class="numeric">72</td>
        <td class="numeric">93</td>
        <td class="numeric">134</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">62</td>
        <td class="numeric">93</td>
        <td class="numeric">97</td>
        <td class="numeric">98</td>
        <td class="numeric">101</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">94</td>
        <td class="numeric">97</td>
        <td class="numeric">100</td>
        <td class="numeric">110</td>
        <td class="numeric">221</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">47</td>
        <td class="numeric">53</td>
        <td class="numeric">79</td>
        <td class="numeric">119</td>
        <td class="numeric">184</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">114</td>
        <td class="numeric">115</td>
        <td class="numeric">118</td>
        <td class="numeric">120</td>
        <td class="numeric">122</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">105</td>
        <td class="numeric">108</td>
        <td class="numeric">112</td>
        <td class="numeric">120</td>
        <td class="numeric">210</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">96</td>
        <td class="numeric">100</td>
        <td class="numeric">111</td>
        <td class="numeric">139</td>
        <td class="numeric">243</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">53</td>
        <td class="numeric">64</td>
        <td class="numeric">73</td>
        <td class="numeric">145</td>
        <td class="numeric">166</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">95</td>
        <td class="numeric">106</td>
        <td class="numeric">118</td>
        <td class="numeric">226</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">217</td>
        <td class="numeric">219</td>
        <td class="numeric">223</td>
        <td class="numeric">234</td>
        <td class="numeric">260</td>
      </tr>
      <tr>
        <td><em>ORIGIN</em></td>
        <td class="numeric"><em>100</em></td>
        <td class="numeric"><em>138</em></td>
        <td class="numeric"><em>207</em></td>
        <td class="numeric"><em>342</em></td>
        <td class="numeric"><em>427</em></td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">85</td>
        <td class="numeric">143</td>
        <td class="numeric">229</td>
        <td class="numeric">369</td>
        <td class="numeric">452</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTML TLS接続時間（ミリ秒）。") }}</figcaption>
</figure>

リソース要求（同一ドメインおよびサードパーティを含む）の場合、TLSネゴシエーション時間が長くなり、差異が増加します。これは、ネットワークの飽和とネットワークの輻輳のためと予想されます。サードパーティの接続が確立されるまでに（リソースヒントまたはリソースリクエストにより）、ブラウザはレンダリングと他の並列リクエストの実行でビジー状態となります。これにより、ネットワーク上で競合が発生します。この欠点にもかかわらず、originソリューションを使用するよりもCDNを使用するサードパーティリソースに明らかな利点があります。

{{ figure_markup(
  image="resource_tls_negotiation_time.png",
  caption="リソースTLSネゴシエーション時間。",
  description="ほとんどのCDNを示すグラフのTLSネゴシエーション時間は約80ミリ秒ですが、一部（Microsoft Azure、Yahoo、Edgecast、ORIGIN、およびCDNetworks）は、特にp50パーセンタイルを超えると、200ミリ秒に向かって徐々に変化し始めます。"
  )
}}

TLSハンドシェイクのパフォーマンスは、さまざまな要因の影響を受けます。これらには、RTT、TLSレコードサイズ、およびTLS証明書サイズが含まれます。 RTTはTLSハンドシェイクに最大の影響を与えますが、TLSパフォーマンスの2番目に大きな要因はTLS証明書のサイズです。

<a hreflang="en" href="https://hpbn.co/transport-layer-security-tls/#tls-handshake">TLSハンドシェイク</a>の最初のラウンドトリップ中に、サーバーは証明書を添付します。この証明書は、次へ進む前にクライアントによって検証されます。この証明書交換では、サーバーは検証可能な証明書チェインを含む場合があります。この証明書の交換後、通信を暗号化するために追加のキーが確立されます。ただし、証明書の長さとサイズはTLSネゴシエーションのパフォーマンスに悪影響を与え、場合によってはクライアントライブラリをクラッシュさせる可能性があります。

証明書の交換はTLSハンドシェイクの基礎であり、通常、エクスプロイトの攻撃対象領域を最小限に抑えるため、分離されたコードパスによって処理されます。低レベルの性質のため、バッファは通常動的に割り当てられず、固定されます。この方法では、クライアントが無制限のサイズの証明書を処理できると単純に想定することはできません。たとえば、OpenSSL CLIツールとSafariは<a hreflang="en" href="https://10000-sans.badssl.com">`https://10000-sans.badssl.com`</a>に対して正常にネゴシエートできます。ただし、証明書のサイズが原因でChromeとFirefoxは失敗します。

極端なサイズの証明書は障害を引き起こす可能性がありますが、適度に大きな証明書を送信してもパフォーマンスに影響があります。証明書は、`Subject-Alternative-Name`（SAN）にリストされている1つ以上のホスト名に対して有効です。 SANが多いほど、証明書は大きくなります。パフォーマンスの低下を引き起こすのは、検証中のこれらのSANの処理です。明確にするため、証明書サイズのパフォーマンスはTCPオーバーヘッドに関するものではなく、クライアントの処理パフォーマンスに関するものです。

技術的に、TCPスロースタートはこのネゴシエーションに影響を与える可能性がありますが、そんなことはありません。 TLSレコードの長さは16KBに制限されており、通常の初期の10の輻輳ウィンドウに適合します。一部のISPはパケットスプライサーを使用し、他のツールは輻輳ウィンドウを断片化して帯域幅を人為的に絞る場合がありますが、これはWebサイトの所有者が変更または操作できるものではありません。

ただし、多くのCDNは共有TLS証明書に依存しており、証明書のSANの多くの顧客をリストします。これはIPv4アドレスが不足しているため、必要になることがよくあります。エンドユーザーが`Server-Name-Indicator`（SNI）を採用する前は、クライアントはサーバーに接続し証明書を検査した後にのみ、クライアントはユーザーが探しているホスト名を示唆します（HTTPで`Host`ヘッダーを使用する）。これにより、IPアドレスと証明書が1：1で関連付けられます。物理的な場所が多数あるCDNの場合、各場所に専用IPが必要になる可能性があり、IPv4アドレスの枯渇をさらに悪化させます。したがって、SNIをサポートしていないユーザーがまだいるWebサイトにCDNがTLS証明書を提供する最も簡単で効率的な方法は、共有証明書を提供することです。

アカマイによると、SNIの採用はまだ世界的に<a hreflang="en" href="https://datatracker.ietf.org/meeting/101/materials/slides-101-maprg-update-on-tls-sni-and-ipv6-client-adoption-00">100％ではありません</a>。幸いなことに、近年急速な変化がありました。最大の犯人はもはやWindows XPとVistaではなく、Androidアプリ、ボット、および企業アプリケーションです。SNI採用率が99％であっても、インターネット上の35億人のユーザーの残り1％は、Webサイトの所有者が非SNI証明書を要求する非常に魅力的な動機を生み出すことができます。別の言い方をすれば、特定製品、活動に注力してる(pure play)Webサイトは、標準ブラウザ間でほぼ100％SNIを採用できます。それでもアプリ、特にAndroidアプリでAPIまたはWebViewをサポートするためにWebサイトが使用されている場合、この分布は急速に低下する可能性があります。

ほとんどのCDNは、共有証明書の必要性とパフォーマンスのバランスをとります。ほとんどの場合、SANの数の上限は100〜150です。この制限は多くの場合、証明書プロバイダーに由来します。たとえば、<a hreflang="en" href="https://letsencrypt.org/docs/rate-limits/">LetsEncrypt</a>、<a hreflang="en" href="https://www.websecurity.digicert.com/security-topics/san-ssl-certificates">DigiCert</a>、<a hreflang="en" href="https://www.godaddy.com/web-security/multi-domain-san-ssl-certificate">GoDaddy</a>はすべて、SAN証明書を100個のホスト名に制限しますが、<a hreflang="en" href="https://comodosslstore.com/comodo-mdc-ssl.aspx">Comodo</a>の制限は2,000個です。これにより、一部のCDNがこの制限を超えて、単一の証明書で800を超えるSANを使用できるようになります。 TLSパフォーマンスと証明書のSANの数には強い負の相関があります。

{{ figure_markup(
  image="fig11.png",
  caption="HTMLのTLS SANカウント。",
  description="表12のデータを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=753130748&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col"><span class="visually-hidden">10パーセンタイル</span><span aria-hidden="true">p10</span></th>
        <th scope="col"><span class="visually-hidden">25パーセンタイル</span><span aria-hidden="true">p25</span></th>
        <th scope="col"><span class="visually-hidden">50パーセンタイル</span><span aria-hidden="true">p50</span></th>
        <th scope="col"><span class="visually-hidden">75パーセンタイル</span><span aria-hidden="true">p75</span></th>
        <th scope="col"><span class="visually-hidden">90パーセンタイル</span><span aria-hidden="true">p90</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>section.io</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">7</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">8</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">53</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">8</td>
        <td class="numeric">19</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
        <td class="numeric">39</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">43</td>
        <td class="numeric">47</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">46</td>
        <td class="numeric">56</td>
        <td class="numeric">130</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">11</td>
        <td class="numeric">78</td>
        <td class="numeric">140</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">2</td>
        <td class="numeric">18</td>
        <td class="numeric">57</td>
        <td class="numeric">85</td>
        <td class="numeric">95</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">77</td>
        <td class="numeric">100</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">18</td>
        <td class="numeric">139</td>
        <td class="numeric">145</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">2</td>
        <td class="numeric">7</td>
        <td class="numeric">100</td>
        <td class="numeric">360</td>
        <td class="numeric">818</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTMLのTLS SANカウント。") }}</figcaption>
</figure>

{{ figure_markup(
  image="fig13.png",
  caption="リソースSANカウント（50パーセンタイル）。",
  description="50パーセンタイルの表14のデータを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=528008536&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col"><span class="visually-hidden">10パーセンタイル</span><span aria-hidden="true">p10</span></th>
        <th scope="col"><span class="visually-hidden">25パーセンタイル</span><span aria-hidden="true">p25</span></th>
        <th scope="col"><span class="visually-hidden">50パーセンタイル</span><span aria-hidden="true">p50</span></th>
        <th scope="col"><span class="visually-hidden">75パーセンタイル</span><span aria-hidden="true">p75</span></th>
        <th scope="col"><span class="visually-hidden">90パーセンタイル</span><span aria-hidden="true">p90</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>section.io</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">6</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">3</td>
        <td class="numeric">3</td>
        <td class="numeric">35</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">5</td>
        <td class="numeric">20</td>
        <td class="numeric">54</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">1</td>
        <td class="numeric">10</td>
        <td class="numeric">11</td>
        <td class="numeric">55</td>
        <td class="numeric">68</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
        <td class="numeric">13</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">16</td>
        <td class="numeric">98</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td class="numeric">6</td>
        <td class="numeric">6</td>
        <td class="numeric">79</td>
        <td class="numeric">79</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
        <td class="numeric">98</td>
        <td class="numeric">98</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">2</td>
        <td class="numeric">43</td>
        <td class="numeric">99</td>
        <td class="numeric">99</td>
        <td class="numeric">99</td>
      </tr>
      <tr>
        <td>jsDelivr</td>
        <td class="numeric">2</td>
        <td class="numeric">116</td>
        <td class="numeric">116</td>
        <td class="numeric">116</td>
        <td class="numeric">116</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">132</td>
        <td class="numeric">178</td>
        <td class="numeric">397</td>
        <td class="numeric">398</td>
        <td class="numeric">645</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リソースSANカウントの分布の10、25、50、75、および90パーセンタイル。") }}</figcaption>
</figure>

## TLSの採用

TLSおよびRTTのパフォーマンスにCDNを使用することに加えて、TLS暗号およびTLSバージョンのパッチ適用および採用を確実とするため、CDNがよく使用されます。一般に、メインHTMLページでのTLSの採用は、CDNを使用するWebサイトの方がはるかに高くなっています。 HTMLページの76％以上がTLSで提供されているのに対し、originホストページからは62％です。

{{ figure_markup(
  image="fig15.png",
  caption="HTML TLSバージョンの採用（CDNとorigin）。",
  description="TLS1.0が発信元の時間の0.86％、TLS1.2が55％、TLS1.3が6％、暗号化されていない38％の時間を示す積み上げ棒グラフ。 CDNの場合、これはTLS1.2では35％、TLS1.3では41％、暗号化されていない場合は24％に変更されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1183502256&format=interactive"
  )
}}

各CDNは、TLSと提供される相対的な暗号とバージョンの両方に異なる採用率を提供します。一部のCDNはより積極的で、これらの変更をすべての顧客に展開しますが他のCDNはWebサイトの所有者に最新の変更をオプトインして、これらの暗号とバージョンを容易にする変更管理を提供することを要求します。

{{ figure_markup(
  image="fig16.png",
  caption="CDNによるHTML TLSの採用。",
  description="いくつかのCDN（Wordpressなど）が100％、ほとんどは80％-100％で、次にORIGINを62％、Googleを51％、ChinaNetCenterをCDNで分解した最初のHTML要求に対して確立されたセキュア接続と非セキュア接続の区分36％、ユンジアスは29％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=2053476423&format=interactive"
  )
}}

{{ figure_markup(
  image="fig17.png",
  caption="CDNによるサードパーティTLSの採用。",
  description="CDNの大部分を示す積み上げ棒グラフは、サードパーティリクエストの90％以上でTLSを使用し、75％から90％の範囲のストラグラーがいくつかあり、ORIGINはそれらすべてよりも68％低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=991037479&format=interactive"
  )
}}

このTLSの一般的な採用に加えて、CDNの使用では、TLS1.3などの新しいTLSバージョンの採用も増えています。

一般にCDNの使用は、TLS1.0のような非常に古くて侵害されたTLSバージョンの使用率が高いoriginホストサービスと比較して、強力な暗号およびTLSバージョンの迅速な採用と高い相関があります。

<aside class="note">Web Almanacで使用されるChromeは、ホストが提供する最新のTLSバージョンと暗号にバイアスをかけることを強調することが重要です。また、これらのWebページは2019年7月にクロールされ、新しいバージョンを有効にしたWebサイトの採用を反映しています。</aside>

{{ figure_markup(
  image="fig18.png",
  caption="CDNによるHTML TLSバージョン。",
  description="TLSが使用される場合、TLS1.3またはTLS1.2がすべてのCDNによって使用されることを示す棒グラフ。いくつかのCDNはTLS1.3を完全に採用していますが、一部ではTLS1.2が大部分を採用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=659795773&format=interactive"
  )
}}

TLSバージョンと暗号の詳細については、[セキュリティ](./security)と[HTTP/2](./http)の章を参照してください。

## HTTP/2採用

RTT管理とTLSパフォーマンスの向上に加えて、CDNはHTTP/2やIPv6などの新しい標準も有効にします。ほとんどのCDNはHTTP/2のサポートを提供し、多くはまだ標準以下の開発HTTP/3の早期サポートを示していますが、これらの新機能を有効にするかどうかは依然としてWebサイト所有者に依存しています。変更管理のオーバーヘッドにもかかわらず、CDNから提供されるHTMLの大部分ではHTTP/2が有効になっています。

CDNのHTTP/2の採用率は70％を超えていますが、originページはほぼ27％です。同様にCDNのサブドメインリソースとサードパーティリソースでは90％以上がHTTP/2を採用していて、さらに高くなりますが、originインフラストラクチャから提供されるサードパーティリソースは31％しか採用されていません。 [HTTP/2](./http) のパフォーマンス向上およびその他の機能については、HTTP/2の章でさらに説明します。

<aside class="note">注：すべてのリクエストは、HTTP/2をサポートするChromeの最新バージョンで行われました。 HTTP/1.1のみが報告される場合、これは暗号化されていない（非TLS）サーバーまたはHTTP/2をサポートしないサーバーを示します。</aside>

{{ figure_markup(
  image="fig19.png",
  caption="HTTP/2の採用（CDNとorigin）。",
  description="origin接続の73％がHTTP/1.1を使用し、27％がHTTP/2を使用する積み上げ棒グラフ。これは、29％がHTTP/1.1と71％がHTTP/2を使用しているCDNと比較しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1166990011&format=interactive"
  )
}}

{{ figure_markup(
  image="fig20.png",
  caption="HTTP/2のHTML採用。",
  description="表21のデータを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1896876288&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">HTTP/0.9</th>
        <th scope="col">HTTP/1.0</th>
        <th scope="col">HTTP/1.1</th>
        <th scope="col">HTTP/2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0.38</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1.07</td>
        <td class="numeric">99</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1.56</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>GoCache</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7.97</td>
        <td class="numeric">92</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">12.03</td>
        <td class="numeric">88</td>
      </tr>
      <tr>
        <td>Instart Logic</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">12.36</td>
        <td class="numeric">88</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">14.06</td>
        <td class="numeric">86</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">15.65</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">16.34</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">16.43</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">17.34</td>
        <td class="numeric">83</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">18.19</td>
        <td class="numeric">82</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">25.53</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>Limelight</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">33.16</td>
        <td class="numeric">67</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">37.04</td>
        <td class="numeric">63</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">43.44</td>
        <td class="numeric">57</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">47.17</td>
        <td class="numeric">53</td>
      </tr>
      <tr>
        <td>Myra Security CDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0.06</td>
        <td class="numeric">50.05</td>
        <td class="numeric">50</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">52.45</td>
        <td class="numeric">48</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0</td>
        <td class="numeric">0.01</td>
        <td class="numeric">55.41</td>
        <td class="numeric">45</td>
      </tr>
      <tr>
        <td>Yunjiasu</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">70.96</td>
        <td class="numeric">29</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">0</td>
        <td class="numeric">0.1</td>
        <td class="numeric">72.81</td>
        <td class="numeric">27</td>
      </tr>
      <tr>
        <td>Zenedge</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">87.54</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">88.21</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>ChinaNetCenter</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">94.49</td>
        <td class="numeric">6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CDNによるHTTP/2のHTML採用。") }}</figcaption>
</figure>

{{ figure_markup(
  image="fig22.png",
  caption="HTML/2の採用：サードパーティのリソース。",
  description="表23のデータを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=397209603&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>cdn</th>
        <th>HTTP/0.9</th>
        <th>HTTP/1.0</th>
        <th>HTTP/1.1</th>
        <th>HTTP/2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jsDelivr</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Facebook</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Twitter</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">99</td>
      </tr>
      <tr>
        <td>section.io</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">2</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>BunnyCDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">2</td>
        <td class="numeric">98</td>
      </tr>
      <tr>
        <td>KeyCDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">4</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">6</td>
        <td class="numeric">94</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7</td>
        <td class="numeric">93</td>
      </tr>
      <tr>
        <td>CDN77</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7</td>
        <td class="numeric">93</td>
      </tr>
      <tr>
        <td>NetDNA</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">7</td>
        <td class="numeric">93</td>
      </tr>
      <tr>
        <td>Google</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">8</td>
        <td class="numeric">92</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">10</td>
        <td class="numeric">90</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">14</td>
        <td class="numeric">86</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">16</td>
        <td class="numeric">84</td>
      </tr>
      <tr>
        <td>Yahoo</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">17</td>
        <td class="numeric">83</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">26</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">26</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>Cedexis</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">27</td>
        <td class="numeric">73</td>
      </tr>
      <tr>
        <td>CDNetworks</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">30</td>
        <td class="numeric">70</td>
      </tr>
      <tr>
        <td>Edgecast</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">42</td>
        <td class="numeric">58</td>
      </tr>
      <tr>
        <td>Highwinds</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">43</td>
        <td class="numeric">57</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td class="numeric">0</td>
        <td class="numeric">0.01</td>
        <td class="numeric">47</td>
        <td class="numeric">53</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">56</td>
        <td class="numeric">44</td>
      </tr>
      <tr>
        <td>CDNvideo</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">68</td>
        <td class="numeric">31</td>
      </tr>
      <tr>
        <td>ORIGIN</td>
        <td class="numeric">0</td>
        <td class="numeric">0.07</td>
        <td class="numeric">69</td>
        <td class="numeric">31</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTML/2の採用：サードパーティのリソース。") }}</figcaption>
</figure>

## CDNキャッシュ動作の制御

### `Vary`

Webサイトは、さまざまなHTTPヘッダーを使用して、ブラウザーとCDNのキャッシュ動作を制御できます。 最も一般的なのは、最新のものであることを保証するためにoriginへ戻る前に何かをキャッシュできる期間を具体的に決定する `Cache-Control`ヘッダーです。

別の便利なツールは、`Vary` HTTPヘッダーの使用です。このヘッダーは、キャッシュをフラグメント化する方法をCDNとブラウザーの両方に指示します。`Vary`ヘッダーにより、originはリソースの表現が複数あることを示すことができ、CDNは各バリエーションを個別にキャッシュする必要があります。最も一般的な例は[圧縮](./compression)です。リソースを`Vary：Accept-Encoding`を使用すると、CDNは同じコンテンツを、非圧縮、Gzip、Brotliなどの異なる形式でキャッシュできます。一部のCDNでは、使用可能なコピーを1つだけ保持するために、この圧縮を急いで実行します。同様に、この`Vary`ヘッダーは、コンテンツをキャッシュする方法と新しいコンテンツを要求するタイミングをブラウザーに指示します。

{{ figure_markup(
  image="use_of_vary_on_cdn.png",
  caption="CDNから提供されるHTMLの <code>Vary</code> の使用法。",
  description="accept-encodingを示すツリーマップグラフは使用率が異なり、チャートの73％が使用されます。 Cookie（13％）とユーザーエージェント（8％）がある程度使用され、その後に他のヘッダーが完全に混在しています。",
  width=600,
  height=376
  )
}}

`Vary`の主な用途は`Content-Encoding`の調整ですが、Webサイトがキャッシュの断片化を知らせるために使用する他の重要なバリエーションがあります。 `Vary`を使用すると、DuckDuckGo、Google、BingBotなどのSEOボットに、異なる条件下で代替コンテンツが返されるように指示します。これは、「クローキング」（ランキングを戦うためにSEO固有のコンテンツを送信する）に対するSEOペナルティを回避するために重要でした。

HTMLページの場合、`Vary`の最も一般的な使用法は、`User-Agent`に基づいてコンテンツが変更されることを通知することです。これは、Webサイトがデスクトップ、電話、タブレット、およびリンク展開エンジン（Slack、iMessage、Whatsappなど）に対して異なるコンテンツを返すことを示す略記です。 `Vary：User-Agent`の使用は、コンテンツがバックエンドの「mDot」サーバーと「通常」サーバーに分割された初期モバイル時代の名残でもあります。レスポンシブWebの採用が広く知られるようになりましたが、この`Vary`形式は残ります。

同様に、`Vary：Cookie`は通常、ユーザーのログイン状態またはその他のパーソナライズに基づいてコンテンツが変化することを示します。

{{ figure_markup(
  image="use_of_vary.png",
  caption="HTMLとoriginとCDNから提供されるリソースの <code>Vary</code> 使用の比較。",
  description="ホームページを提供するCDNの場合、Varyの最大の用途はCookieであり、その後にuser-agentが続くことを示す4つのツリーマップグラフのセット、他のリソースを提供するCDNの場合は、originであり、その後にaccept、user-agent、x-origin、およびreferrerが続きます。 originsとホームページの場合、それはuser-agentであり、その後にcookieが続きます。最後に、originsおよびその他のリソースについては、主にuser-agentであり、その後にorigin、accept、range、hostが続きます。"
  )
}}

対照的に、リソースはHTMLリソースほど`Vary：Cookie`を使用しません。代わりに、これらのリソースは`Accept`、`Origin`、または`Referer`に基づいて適応する可能性が高くなります。たとえば、ほとんどのメディアは、`Vary：Accept`を使用してブラウザが提供する`Accept`ヘッダーに応じて画像がJPEG、WebP、JPEG 2000、またはJPEG XRであることを示します。同様に、サードパーティの共有リソースは、埋め込まれているWebサイトによってXHR APIが異なることを通知します。このように、広告サーバーAPIの呼び出しは、APIを呼び出した親Webサイトに応じて異なるコンテンツを返します。

`Vary`ヘッダーには、CDNチェインの証拠も含まれています。これらは、`Accept-Encoding、Accept-Encoding`、または`Accept-Encoding、Accept-Encoding、Accept-Encoding`などの`Vary`ヘッダーで確認できます。これらのチェインと`Via`ヘッダーエントリをさらに分析すると、たとえば、サードパーティタグをプロキシしているサイトの数など興味深いデータが明らかになる可能性があります。

`Vary`の使用の多くは無関係です。ほとんどのブラウザがダブルキーキャッシングを採用しているため、`Vary：Origin`の使用は冗長です。`Vary：Range`または`Vary：Host`または`Vary：*`のように。 `Vary`のワイルドで可変的な使用は、インターネットが奇妙であることの実証可能な証拠です。

### `Surrogate-Control`, `s-maxage`, `Pre-Check`

`Cache-Control`ヘッダーの`Surrogate-Control`、`s-maxage`、`pre-check`、`post-check`の値など、特にCDNまたは他のプロキシキャッシュを対象とする他のHTTPヘッダーがあります。一般的に、これらのヘッダーを使う事は少ないでしょう。

`Surrogate-Control`を使用すると、originはCDNに対してのみキャッシュルールを指定できます。CDNは応答を提供する前にヘッダーを削除する可能性が高いため、使用量が低いと驚くことはありません（いくつかのCDNもヘッダーを削除しているように見えました）。

一部のCDNは、リソースが古くなった場合にリソースを更新できるようにする方法として`pre-check`をサポートし、最大値`maxage`として`pre-check`をサポートしています。ほとんどのCDNでは、`pre-check`と`post-check`の使用率は1％未満でした。Yahoo!はこの例外であり、リクエストの約15％に`pre-check = 0、post-check = 0`がありました。残念ながら、これは積極的な使用ではなく、古いInternet Explorerパターンの名残です。この上のより多くの議論では、[キャッシング](./caching)の章に記載されています。

`s-maxage`ディレクティブは、応答をキャッシュできる期間をプロキシに通知します。 Web Almanacデータセット全体で、jsDelivrは複数のリソースで高いレベルの使用が見られた唯一のCDNです。これは、jsDelivrのライブラリのパブリックCDNとしての役割を考えると驚くことではありません。他のCDNでの使用は、個々の顧客、たとえばその特定のCDNを使用するサードパーティのスクリプトまたはSaaSプロバイダーによって推進されているようです。

{{ figure_markup(
  image="fig26.png",
  caption="CDN応答全体での <code>s-maxage</code> の採用。",
  description="jsDelivrの82％がs-maxage、レベル3の14％、Amazon CloudFrontの6.3％、Akamaiの3.3％、Fastlyの3.1％、Highwindsの3％、Cloudflareの2％、ORIGINの0.91％の応答を提供する棒グラフ、Edgecastの0.75％、Googleの0.07％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=1215102767&format=interactive"
  )
}}

サイトの40％がリソースにCDNを使用しており、これらのリソースが静的でキャッシュ可能であると仮定すると、`s-maxage`の使用は低いようです。

今後の研究では、キャッシュの有効期間とリソースの経過時間、および`s-maxage`の使用法と`stale-while-revalidate`などの他の検証ディレクティブの使用法を検討する可能性があります。

## 一般的なライブラリとコンテンツのCDN

これまでのところ、この章ではサイトが独自のコンテンツをホストするために使用している可能性のあるコマーシャルCDNの使用、またはサイトに含まれるサードパーティリソースによって使用されている可能性について検討しました。

jQueryやBootstrapなどの一般的なライブラリは、Google、Cloudflare、MicrosoftなどがホストするパブリックCDNからも利用できます。コンテンツを自己ホストする代わりに、パブリックCDNの1つのコンテンツを使用することはトレードオフです。コンテンツがCDNでホストされている場合でも、新しい接続を作成して輻輳ウィンドウを拡大すると、CDNを使用する際の低遅延が無効になる場合があります。

GoogleフォントはコンテンツCDNの中で最も人気があり、55％のWebサイトで使用されています。非フォントコンテンツの場合、Google API、CloudflareのJS CDN、およびBootstrapのCDNが次に人気です。

{{ figure_markup(
  image="fig27.png",
  caption="パブリックコンテンツCDNの使用。",
  description="パブリックコンテンツのCDNの55.33％がfonts.googleapis.com、19.86％がajax.googleapis.com、10.47％がcdnjs.cloudflare.com、9.83％がmaxcdn.bootstrapcdn.com、コードが5.95％の棒グラフです。 jquery.com、cdn.jsdelivr.netに4.29％、use.fontawesome.comに3.22％、stackpath.bootstrapcdn.comに0.7％、unpkg.comに0.67％、ajax.aspnetcdn.comに0.52％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRzPn-1SGVa3rNCT0U9QeQNODE97fsmXyaJX1ZOoBNR8nPpclhC6fg8R_UpoodeiX6HkdHrp50WBQ5Q/pubchart?oid=123086113&format=interactive"
  )
}}

分割キャッシュを実装するブラウザが増えると、共通ライブラリをホストするためのパブリックCDNの有効性が低下し、この研究の今後の反復で人気が低くなるかどうかを見るのは興味深いでしょう。

## 結論

CDN配信によるレイテンシーの短縮と、訪問者の近くにコンテンツを保存する機能により、サイトはoriginの負荷を軽減しながらより高速な体験を提供できます。

Steve SoudersによるCDNの使用の推奨は、12年前と同じように今日でも有効ですがCDNを介してHTMLコンテンツを提供しているサイトは20％のみであり、リソースにCDNを使用しているサイトは40％のみです。それらの使用法はさらに成長します。

この分析に含まれていないCDNの採用にはいくつかの側面があります、これはデータセットの制限と収集方法が原因である場合で、他の場合は分析中に新しい研究の質問が出てきました。

Webの進化に伴い、CDNベンダーは革新しサイトの新しいプラクティスを使用します、CDNの採用はWeb Almanacの将来のエディションでのさらなる研究のために豊富な領域のままです。
