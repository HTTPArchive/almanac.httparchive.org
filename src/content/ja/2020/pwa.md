---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: サービスワーカー（登録、インストール性、イベント、ファイルサイズ）、Web App Manifestsのプロパティ、Workboxをカバーする2020年Web AlmanacのPWAの章。
authors: [hemanth]
reviewers: [thepassle, jadjoubran, pearlbea, gokulkrishh]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: [ksakae1216]
hemanth_bio: <a hreflang="en" href="https://h3manth.com">Hemanth HM</a>は、コンピュータポリグロット、FOSS哲学者、Webと決済ドメインのためのGDE、DuckDuckGoコミュニティメンバー、TC39代表者、Google Launchpad Acceleratorメンター。WEB & CLIが大好き。<a hreflang="en" href="https://TC39er.us">TC39er.us</a>ポッドキャストを主催。
discuss: 2050
results: https://docs.google.com/spreadsheets/d/1AOqCkb5EggnE8BngpxvxGj_fCfssT9sZ0ElCQKp4pOw/
featured_quote: ネイティブライクなアプリケーションに進行するWebアプリケーションは、PWAとみなすことができます。
featured_stat_1: 16.6%
featured_stat_label_1: サービスワーカーを利用したページ読み込みの割合
featured_stat_2: 27.97%
featured_stat_label_2: PWAにしては読み込みが速いWebアプリ。
featured_stat_3: 25%
featured_stat_label_3: importScriptsを使用しているモバイルPWAサイトの割合。
---

## 序章

1990年に「WorldWideWeb」と呼ばれる史上初のブラウザが登場し、それ以来、ウェブとブラウザは進化を続けてきました。ウェブがネイティブアプリケーションの動作に進化したことは、とくにモバイルが支配しているこの時代には、大きな勝利と言えるでしょう。URLやウェブブラウザは情報を配信するためのユビキタスな方法を提供してきたので、ブラウザにネイティブアプリの機能を提供する技術はゲームチェンジャーです。プログレッシブウェブアプリは、他のアプリケーションと競合するウェブにこのような利点を提供します。

簡単に言えば、ネイティブライクなアプリケーション体験を提供するウェブアプリケーションをPWAとみなすことができます。HTML、CSS、JavaScriptなどの一般的なWeb技術を用いて構築されており、標準に準拠したブラウザ上でデバイスや環境を超えてシームレスに動作できます。

プログレッシブなWebアプリの核心は _サービスワーカー_ であり、ブラウザとユーザーの間に座っているプロキシと考えることができます。サービスワーカーは、ネットワークがアプリケーションを制御するのではなく、開発者がネットワークを完全に制御できるようにします。

[昨年の章](../2019/pwa)で述べたように、それは2014年12月にChrome 40が現在プログレッシブウェブアプリ（PWA）として知られているものの要点を最初に実装したときに始まりました。これはウェブ標準化団体の共同作業であり、PWAという言葉は2015年に<a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">Frances BerrimanとAlex Russell</a>によって作られました。

Web Almanacのこの章では、データ駆動の観点から、PWAを現在のものにしている各コンポーネントを見ていきます。

## サービスワーカー

サービスワーカーは、進歩的なウェブアプリの中心にいます。彼らは開発者がネットワークリクエストを制御するのを助けます。

### サービスワーカーの利用状況

収集したデータから、デスクトップサイトの約0.88%、モバイルサイトの約0.87%がサービスワーカーを利用していることがわかります。これは2020年8月の月のデータで、これを考慮すると、デスクトップサイトは49,305件（5,593,642件のうち）、モバイルサイトは55,019件（6,347,919件のうち）に相当します。

{{ figure_markup(
  image="pwa-timeseries-of-service-worker-installations.png",
  caption="サービスワーカー導入の時系列。",
  description="サービスワーカーの導入率の折れ線グラフは、2017年1月にデスクトップが0.03%、モバイルが0.04%で始まり、デスクトップが0.88%、モバイルが0.87%とほぼ直線的に成長しています。一般的にデスクトップとモバイルは互いに密接に追従しており、2018年半ばまではモバイルがデスクトップを上回り、2018年後半は異常と思われるものが、2019年初頭から現在に至るまでデスクトップがモバイルを上回っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1883263914&format=interactive",
  sheets_gid="1626594877",
  sql_file="sw_adoption_over_time.sql"
  )
}}

この使用率は低いように見えるかもしれませんが、他の測定値では<a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">ウェブトラフィック</a>の16.6%に相当し、トラフィックの多いウェブサイトではサービスワーカーの使用率が高くなる傾向があるため、その差は大きいことを認識することが重要です。

## Lighthouseの洞察力

<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse">Lighthouse</a>は、Webの自動監査、パフォーマンスメトリック、およびベストプラクティスを提供し、Webのパフォーマンスの形成に役立ちました。 6,782,042ページを超える収集されたPWAカテゴリの監査を調べたところ、いくつかの重要なタッチポイントに関する優れた洞察が得られました。

<figure>
  <table>
    <thead>
      <tr>
        <th>Lighthouse監査</th>
        <th>重量</th>
        <th>割合</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>load-fast-enough-for-pwa</code></td>
        <td class="numeric">7</td>
        <td class="numeric">27.97%*</td>
      </tr>
      <tr>
        <td><code>works-offline</code></td>
        <td class="numeric">5</td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td><code>installable-manifest</code></td>
        <td class="numeric">2</td>
        <td class="numeric">2.21%</td>
      </tr>
      <tr>
        <td><code>is-on-https</code></td>
        <td class="numeric">2</td>
        <td class="numeric">66.67%</td>
      </tr>
      <tr>
        <td><code>redirects-http</code></td>
        <td class="numeric">2</td>
        <td class="numeric">70.33%</td>
      </tr>
      <tr>
        <td><code>viewport</code></td>
        <td class="numeric">2</td>
        <td class="numeric">88.43%</td>
      </tr>
      <tr>
        <td><code>apple-touch-icon</code></td>
        <td class="numeric">1</td>
        <td class="numeric">34.75%</td>
      </tr>
      <tr>
        <td><code>content-width</code></td>
        <td class="numeric">1</td>
        <td class="numeric">79.37%</td>
      </tr>
      <tr>
        <td><code>maskable-icon</code></td>
        <td class="numeric">1</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>offline-start-url</code></td>
        <td class="numeric">1</td>
        <td class="numeric">0.75%</td>
      </tr>
      <tr>
        <td><code>service-worker</code></td>
        <td class="numeric">1</td>
        <td class="numeric">1.03%</td>
      </tr>
      <tr>
        <td><code>splash-screen</code></td>
        <td class="numeric">1</td>
        <td class="numeric">1.90%</td>
      </tr>
      <tr>
        <td><code>themed-omnibox</code></td>
        <td class="numeric">1</td>
        <td class="numeric">4.00%</td>
      </tr>
      <tr>
        <td><code>without-javascript</code></td>
        <td class="numeric">1</td>
        <td class="numeric">97.57%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Lighthouse PWAの監査。", sheets_gid="814184412", sql_file="lighthouse_pwa_audits.sql") }}</figcaption>
</figure>

<p class="note">Lighthouseテストのパフォーマンス統計が8月のクロールでは正しくなかったので、<code>load-fast-enough-for-pwa</code>の結果は9月の結果に置き換えられています。</p>

<a hreflang="en" href="https://web.dev/load-fast-enough-for-pwa/">高速なページロード</a>は、とくに遅い携帯電話ネットワークを考慮に入れた場合、良好なモバイルユーザー体験を保証します。27.56%のページがPWAで十分に高速に読み込まれました。ウェブがどのように地理的に分散しているかを考えると、次の10億人のウェブユーザー、そのほとんどがモバイルデバイスを介してインターネットを利用することになるであろう人々にとって、より軽量なページで高速なロードタイムを持つことはもっとも重要なことです。

プログレッシブWebアプリを構築している場合、アプリが<a hreflang="en" href="https://web.dev/works-offline/">オフラインで作業できるように、サービスワーカーの利用を検討してみてください</a>0.92%のページがオフライン準備ができていました。

ブラウザは積極的にユーザーにアプリをホーム画面に追加するよう促すことができ、エンゲージメントの向上につながる可能性があります。2.21%のページには、<a hreflang="en" href="https://web.dev/installable-manifest/">インストール可能なマニフェスト</a>が表示されていました。マニフェストは、アプリがどのように起動するか、ホーム画面上のアイコンの見た目や感触、エンゲージメント率に直接影響を与えるものとして重要な役割を果たしています。

機密データを扱わないサイトであっても、すべてのサイトはHTTPSで保護されるべきです。これには、<a hreflang="en" href="https://developers.google.com/web/fundamentals/security/prevent-mixed-content/what-is-mixed-content">混合コンテンツ</a>の回避も含まれます。これには、最初のリクエストがHTTPSで提供されているにもかかわらず、一部のリソースがHTTPでロードされていることも含まれます。HTTPSは、侵入者がアプリとユーザー間の通信を改ざんしたり、受動的に盗聴したりすることを防ぎ、サービスワーカーや、[HTTP/2](./http)のような多くの新しいウェブプラットフォーム機能やAPIの前提条件となります。 <a hreflang="en" href="https://web.dev/is-on-https/">is-on-httpsチェック</a>では、67.27%のサイトがコンテンツが混在していないhttpsになっており、まだ上位には到達していないのが驚きです。[セキュリティ](./security#transport-security)の章では、86.91%のサイトがHTTPSを使用していることが示されており、混合コンテンツの方が今は大きな問題になっている可能性があることを示唆しています。この数字は、ブラウザがアプリケーションにHTTPS対応を義務づけ、HTTPS対応していないものをより精査するようになれば、さらに良くなるでしょう。

すでにHTTPSを設定している場合は、URLを変更せずにユーザーに安全な接続を可能にするため、<a hreflang="en" href="https://web.dev/redirects-http/">すべてのHTTPトラフィックをHTTPSにリダイレクトすることを確認してください</a>: サイトの69.92%だけがこの監査に合格しています。アプリケーション上のすべてのHTTPをHTTPSにリダイレクトすることは、HTTPSへのHTTPリダイレクトはまともな数のサイトが通過しているにもかかわらず、堅牢性に向けたシンプルなステップである必要がありますが、それはより良いことができます。

`<meta name="viewport">`タグを追加することで、アプリをモバイル画面に最適化できます。88.43%のサイトでは、<a hreflang="en" href="https://web.dev/viewport/">viewport</a>のメタタグが使用されています。ほとんどの開発者やツールがビューポートの最適化を意識しているため、ビューポートメタタグの使用率が高い側にあることは驚くべきことではありません。

iOS上で理想的な外観を得るために、プログレッシブウェブアプリは`apple-touch-icon`メタタグを定義する必要があります。それは、非透過性の192px（または180px）の正方形のPNGを指す必要があります。32.34%のサイトが<a hreflang="en" href="https://web.dev/apple-touch-icon/">apple touch icon</a>のチェックを通過しています。

アプリのコンテンツの幅とビューポートの幅が一致しない場合、アプリがモバイル画面に最適化されていない可能性があります。79.18%のサイトでは、<a hreflang="en" href="https://web.dev/content-width/">コンテンツの幅</a>が正しく設定されています。

<a hreflang="en" href="https://web.dev/maskable-icon-audit/">マスカブルアイコン</a>は、プログレッシブウェブアプリをホーム画面へ追加する際に、文字化けせずに画像が全体を埋め尽くすことを保証します。これを使用しているサイトは0.11%に過ぎませんが、真新しい機能であることを考えると、この機能が使用されていることは励みになります。まだ導入されたばかりなので、この数字は非常に低いと予想していましたが、今後数年で改善されていくはずです。

サービスワーカーは、予測できないネットワーク状況でもWebアプリの信頼性を高めることができます。0.77%のサイトでは、ネットワークに接続されていない状態でもアプリを動作させるための<a hreflang="en" href="https://web.dev/offline-start-url/">オフライン起動URL</a>が用意されています。ネットワークの不備は、Webアプリケーションの利用者が直面するもっとも一般的な問題であるため、これはPWAにとってもっとも重要な機能の1つと言えるでしょう。

<a hreflang="en" href="https://web.dev/service-worker/">サービスワーカー</a>は、オフラインでの利用やプッシュ通知など、プログレッシブウェブアプリの多くの機能をアプリで利用できるようにする機能です。1.05%のページでサービスワーカーが有効化されています。サービスワーカーで対応できる強力な機能と、以前からサポートされていたことを考えると、その数がまだ少ないのは驚きです。

テーマ付きの<a hreflang="en" href="https://web.dev/splash-screen/">スプラッシュスクリーン</a>は、ユーザーがホーム画面からアプリを起動した際のネイティブに近い体験を保証します。1.95%のページにスプラッシュスクリーンがありました。

ブラウザのアドレスバーをサイトに合わせてテーマ化できます。4.00%のページでは、<a hreflang="en" href="https://web.dev/themed-omnibox/">オムニボックス</a>がテーマ化されていました。

JavaScriptが無効になっている場合、アプリを使用するにはJavaScriptが必要であるというユーザーへの単なる警告であっても、アプリは一部のコンテンツを表示する必要があります。 97.57％のページには、JavaScriptが<a hreflang="en" href="https://web.dev/without-javascript/">無効</a>の空白ページ以上のものが表示されます。 ホームページのみを調査していることを考えると、3.43％のサイトがこの監査に失敗したことはおそらくもっと驚くべきことです！

## サービスワーカーのイベント

サービスワーカーでは、いくつかのイベントをリッスンできます。

1. `install`は、サービスワーカーのインストール時に発生します。
2. `activate`は、サービスワーカーの起動時に発生します。
3. `fetch`は、リソースがfetchされるたびに発生します。
4. `push`は、プッシュ通知が届いたときに発生します。
5. `notificationclick`は、通知がクリックされたときに発生します。
6. `notificationclose`は、通知を閉じているときに発生します。
7. `message`は、postMessage()で送信したメッセージが到着したときに発生します。
8. `sync`は、バックグラウンドの同期イベントが発生したときに発生します。

今回のデータセットでは、これらのイベントのうち、どのイベントがサービスワーカーに聴かれているかを調べました。

{{ figure_markup(
  image="pwa-most-used-service-worker-events.png",
  caption="もっとも利用されるサービスワーカーのイベント",
  description="もっとも使用されているサービスワーカーイベントの割合を示す棒グラフ。サービスワーカーを導入しているデスクトップサイトの69%とモバイルサイトの73%が`install`を、66%と71%が`fetch`を、55%と59%が`activate`を、24%と20%が`notificationclick`を、23%と20%が`push`を、8%と6%が`message`を、デスクトップとモバイルの両方で3%が`notificationclose`を、そして両方で1%が`sync`を使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1964906335&format=interactive",
  sheets_gid="1698485238",
  sql_file="sw_events.sql"
  )
}}

 モバイルとデスクトップの結果は非常に似ており、`install`、`fetch`、`activate`がもっとも人気のある3つのイベントで、`message`、`notification click`、`push`、`sync`と続きます。この結果を解釈すると、サービスワーカーが可能にするオフラインのユースケースは、アプリ開発者にとってプッシュ通知をはるかにしのぐ、もっとも魅力的な機能であると言えます。バックグラウンド同期は、利用可能な機能が限られており、一般的なユースケースではないため、現時点では重要な役割を果たしていません。

## ウェブアプリのマニフェスト

Webアプリマニフェストは、JSONベースのファイルで、Webアプリケーションに関連するメタデータを開発者が一元的に配置できるようにするものです。マニフェストは、アイコンや向き、テーマカラーなど、デスクトップやモバイルでのアプリケーションの動作を規定します。

PWAを実りあるものにするためには、マニフェストとサービスワーカーが必要です。興味深いのは、サービスワーカーよりもマニフェストの方が多く使用されていることです。これは、WordPress、Drupal、JoomlaなどのCMSがデフォルトでマニフェストを備えていることが大きな理由です。

{{ figure_markup(
  image="pwa-manifest-and-service-worker-usage.png",
  caption="マニフェストとサービスワーカーの利用",
  description="マニフェスト、サービスワーカー、またはその両方を持つページの割合を示す棒グラフで、デスクトップページの6.04%、モバイルページの5.66%がマニフェストを持ち、デスクトップの0.76%、モバイルの0.84%がサービスワーカーを持ち、デスクトップページの0.59%、モバイルページの0.68%がその両方を持つことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=257125618&format=interactive",
  sheets_gid="227354805",
  sql_file="manifests_and_service_workers.sql"
  )
}}

Webアプリマニフェストは、サービスワーカーの使用とは無関係に存在することができるため、Webアプリマニフェストがあるからといって、そのサイトがプログレッシブWebアプリであるとは限りません。しかし、本章ではPWAに関心があるため、サービスワーカーも存在するサイトのマニフェストのみを調査しました。[昨年のPWAの章](../2019/pwa#web-app-manifests)で行った、マニフェスト全体の使用状況を調べるアプローチとは異なるため、今年の結果には若干の違いがあるかもしれません。

### マニフェストのプロパティ

ウェブマニフェストは、アプリケーションのメタプロパティを規定するものです。ここでは、Web App Manifest仕様で定義されているさまざまなプロパティに加え、標準ではない独自のプロパティについても検討しました。

{{ figure_markup(
  image="pwa-manifest-properties-on-service-worker-pages.png",
  caption="サービスワーカーページのマニフェストプロパティ",
  description="サービスワーカーのページで使用されているさまざまなマニフェストのプロパティの割合を、デスクトップとモバイル別に棒グラフで示しています。最初の7つのプロパティ (`name`, `display`, `icons`, `short_name`, `start_url`, `theme_color`, `background_color`) は、デスクトップとモバイルの両方で93～98%が使用しています。`gcm_sender_id`はデスクトップの21.66%、モバイルの28.98%、`scope`はデスクトップの29.32%、モバイルの28.77%、`description`はデスクトップの23.32%、モバイルの18.84%、`orientation`はデスクトップの19.45%、モバイルの17.65%、最後に`lang`はデスクトップの12.31%、モバイルの11.01%で使用されていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=427650634&format=interactive",
  sheets_gid="887021927",
  sql_file="top_manifest_properties_sw.sql"
  )
}}

<a hreflang="en" href="https://w3c.github.io/manifest/#webappmanifest-dictionary">仕様書によると、以下のプロパティが有効なプロパティです</a>。

- `background_color`
- `categories`
- `description`
- `dir`
- `display`
- `iarc_rating_id`
- `icons`
- `lang`
- `name`
- `orientation`
- `prefer_related_applications`
- `related_applications`
- `scope`
- `screenshots`
- `short_name`
- `shortcuts`
- `start_url`
- `theme_color`

モバイルとデスクトップの統計の違いはほとんどありませんでした。

Google Cloud Messaging(GCM)サービスで使用されている`gcm_sender_id`という独自のプロパティが頻繁に見つかりました。他にも、以下のような興味深い属性がありました。`browser_action`, `DO_NOT_CHANGE_GCM_SENDER_ID`（これは基本的にコメントで、JSONではコメントが許されていないために使用されています）、`scope`、`public path`、 `cacheDigest`。

しかし、どちらのプラットフォームでも、ブラウザでは解釈されず、潜在的に有用なメタデータを含むプロパティのロングテールがあります。

また、ミスタイプされたプロパティも多数発見されました。私たちが気に入っているのは、`theme-color`, `Theme_color`, `theme-color`, `Theme_color`, `orientation`のバリエーションです。

### トップマニフェストの表示値

{{ figure_markup(
  image="pwa-most-used-display-values-for-service-worker-pages.png",
  caption="サービスワーカーのページでもっとも使用される`display`の値です。",
  description="もっとも一般的な5つの`display`値を使用しているページの割合を示す棒グラフで、デスクトップページの86.73%、モバイルページの89.28%が使用している`standalone`が圧倒的に多く、`minimal-ui`はデスクトップの6.30%、モバイルの5.00%で使用され、デスクトップページの1.15%、モバイルページの0.88%が`display`値を設定しておらず、最後にデスクトップの1.00%、モバイルの0.72%が`browser`に設定しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=872942071&format=interactive",
  sheets_gid="1208193001",
  sql_file="top_manifest_display_values_sw.sql"
  )
}}

もっとも一般的な5つの`display`値のうち、デスクトップページの86.73％、モバイルページの89.28％が`standalone`を使用しており、上位を占めています。このモードでは、ネイティブアプリのような操作感が得られるので、驚くことではありません。次に多かったのは`minimal-ui`で、デスクトップで6.30%、モバイルでは5.00%が採用していました。これは`standalone`と似ていますが、一部のブラウザのUIが維持されるという点が異なります。

### トップマニフェストのカテゴリー

{{ figure_markup(
  image="pwa-manifest-categories.png",
  caption="PWAマニフェストのカテゴリー",
  description="PWAページの割合を示した棒グラフでは、人気の高いトップ10のカテゴリーについて、ショッピングがデスクトップでは3.45％、モバイルでは13.46％と他の数値を大きく上回っています。次いで、ニュースがデスクトップで4.60％、モバイルで5.26％、エンターテインメントが6.90％、5.26％、ユーティリティが6.32％、4.74％、ビジネスが6.90％、4.74％、ライフスタイルが2.87％、3.16％、ソーシャルが2.87％、2.63％、ファイナンスが2.87％、2.63％、最後にウェブが1.72％、2.11％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=137093819&format=interactive",
  sheets_gid="423855457",
  sql_file="top_manifest_categories_sw.sql"
  )
}}

これは、PWAが電子商取引アプリケーションであることから予想できることです。次いで`ニュース`が5.26%となっている。

### ネイティブにこだわるマニフェスト

{{ figure_markup(
  image="pwa-manifest-preferring-native.png",
  caption="マニフェストは、ネイティブを好む。",
  description="デスクトップで98.24%、モバイルでは98.52%のサイトがネイティブを好んでいることを示す水平方向の積み上げ棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1370804413&format=interactive",
  sheets_gid="153006256",
  sql_file="manifests_preferring_native_apps_sw.sql"
  )
}}

デスクトップPWAサイトの98.24%、モバイルPWAサイトの98.52%が、ネイティブアプリを優先せず、存在するウェブバージョンを使用するように、`preferred_related_applications`マニフェストプロパティを設定しています。このプロパティが`true`に設定されているごく一部のサイトでは、マニフェストを持つだけで実際にはまだ完全なPWAではない多くのウェブアプリケーションが存在することを示しています。

### トップマニフェストのアイコンサイズ

{{ figure_markup(
  image="pwa-top-manifest-icon-sizes.png",
  caption="トップマニフェストのアイコンサイズ",
  description="192×192ピクセルは、デスクトップで19.10％、モバイルで19.76％、512×512ピクセルも18.21％、18.85％と、上位のアイコンサイズを棒グラフで示しています。その後、96×96ピクセルではデスクトップで7.21％、モバイルで7.11％と急激に減少し、残りの72×72ピクセル、48×48ピクセル、128×128ピクセル、152×152ピクセル、384×384ピクセル、256×256ピクセル、36×26ピクセル、196×196ピクセル、120×120ピクセル、168×168ピクセル、32×32ピクセルではほぼ直線的に減少し、16×16ピクセルではデスクトップサイトで0.89％、モバイルサイトで0.81％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=263579568&format=interactive",
  sheets_gid="806224609",
  sql_file="top_manifest_icon_sizes_sw.sql"
  )
}}

Lighthouseでは、最低でも192x192ピクセルのアイコンが必要ですが、一般的なファビコン生成ツールでは、他のサイズも多数作成されています。各デバイスで推奨されているアイコンサイズを使用することが望ましいので、さまざまなサイズのアイコンが広く使われていることは心強いことです。

### トップマニフェストの方向性

{{ figure_markup(
  image="pwa-top-manifest-orientations.png",
  caption="Top manifest orientations.",
  description="棒グラフは、`portrait`がデスクトップの14.25％、モバイルの14.47％で使用され、`any`がデスクトップの7.25％、モバイルの6.45％で使用され、`portrait-primary`がデスクトップの1.56％、モバイルの1.52％で使用され、`natural`がデスクトップの0.86％、モバイルの0.79％で使用され、最後に`landscape`がデスクトップの0.53％、モバイルの0.39％で使用されていることから、上位5つの表示方法を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1217279338&format=interactive",
  sheets_gid="2070230147",
  sql_file="top_manifest_orientations_sw.sql"
  )
}}

orientationプロパティの有効な値は、Screen Orientation API<a hreflang="en" href="https://www.w3.org/TR/screen-orientation/">specification</a>で定義されています。現在のところ、以下の通りです。

- `any`
- `natural`
- `landscape`
- `portrait`
- `portrait-primary`
- `portrait-secondary`
- `landscape-primary`
- `landscape-secondary`

その中で、`portrait`、`any`、`portrait-primary`のプロパティが優先されることに気づきました。

## サービスワーカーライブラリ

サービスワーカーがライブラリを依存関係として使用するケースは、外部依存関係であれ、アプリケーションの内部依存関係であれ、多くあります。これらは通常、`importScripts()`APIによってサービスワーカーに取り込まれます。このセクションでは、そのようなライブラリの統計情報を見ていきます。

### 人気のインポートスクリプト

[WorkerGlobalScope インタフェース](https://developer.mozilla.org/ja/docs/Web/API/WorkerGlobalScope)の[importScripts() API](https://developer.mozilla.org/ja/docs/Web/API/WorkerGlobalScope/importScripts)は、1つまたは複数のスクリプトをワーカーのスコープに同期的にインポートします。同じことが、外部の依存関係をサービスワーカーにインポートするためにも使われます。

<figure>
<table>
  <thead>
    <tr>
      <th>スクリプト</th>
      <th>デスクトップ</th>
      <th>モバイル</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>importScripts()</code>使用率</td>
      <td class="numeric">29.60%</td>
      <td class="numeric">23.76%</td>
    </tr>
    <tr>
      <td><code>Workbox<code></td>
      <td class="numeric">17.70%</td>
      <td class="numeric">15.25%</td>
    </tr>
    <tr>
      <td><code>sw_toolbox<code></td>
      <td class="numeric">13.92%</td>
      <td class="numeric">12.84%</td>
    </tr>
    <tr>
      <td><code>firebase<code></td>
      <td class="numeric">3.40%</td>
      <td class="numeric">3.09%</td>
    </tr>
    <tr>
      <td><code>OneSignalSDK<code></td>
      <td class="numeric">4.23%</td>
      <td class="numeric">2.76%</td>
    </tr>
    <tr>
      <td><code>najva<code></td>
      <td class="numeric">1.89%</td>
      <td class="numeric">1.52%</td>
    </tr>
    <tr>
      <td><code>upush<code></td>
      <td class="numeric">1.45%</td>
      <td class="numeric">1.23%</td>
    </tr>
    <tr>
      <td><code>cache_polyfill<code></td>
      <td class="numeric">0.70%</td>
      <td class="numeric">0.72%</td>
    </tr>
    <tr>
      <td><code>analytics_helper<code></td>
      <td class="numeric">0.34%</td>
      <td class="numeric">0.39%</td>
    </tr>
    <tr>
      <td>Other Library</td>
      <td class="numeric">0.27%</td>
      <td class="numeric">0.15%</td>
    </tr>
    <tr>
      <td>No Library</td>
      <td class="numeric">58.81%</td>
      <td class="numeric">64.44%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="PWAライブラリーの利用状況", sheets_gid="1399126426", sql_file="popular_pwa_libraries.sql") }}</figcaption>
</figure>

デスクトップPWAサイトの約30%、モバイルPWAサイトの約25%が`importScripts()`を使用しており、そのうち`workbox`、`sw_toolbox`、`firebase`がそれぞれ1位から3位を占めています。

### ワークボックスの使い方

数多くあるライブラリの中で、もっとも多く利用されたのはWorkboxで、モバイルとデスクトップのPWAサイトでそれぞれ12.86％と15.29％の採用率を記録しました。

{{ figure_markup(
  image="pwa-most-used-workbox-packages.png",
  caption="もっとも使用されているWorkboxのパッケージ。",
  description="もっと使用されているWorkboxパッケージを使用率の高い順に棒グラフで示しています。デスクトップのサービスワーカーページで29.53%、モバイルでは25.71%、`routing`はそれぞれ18.91%、15.61%、`precaching`は16.54%、12.98%となっています。`core`が16.28%と12.44%、`expiration`が7.49%と7.13%、`setConfig`が6.54%と4.80%、`skipWaiting`がデスクトップのサービスワーカーサイトで3.89%、モバイルでは3.03%使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=550366577&format=interactive",
  sheets_gid="1614661441",
  sql_file="workbox_package_methods.sql"
  )
}}

Workboxが提供する多くのメソッドのうち、`strategies`はデスクトップで29.53%、モバイルでは25.71%が使用し、`routing`が18.91%、15.61%と続き、最後に`precaching`がデスクトップとモバイルでそれぞれ16.54%、12.98%となっています。

これは、開発者にとってもっとも複雑な要件の1つである戦略APIが、自分でコーディングするかWorkboxのようなライブラリに頼るかを決める際に、非常に重要な役割を果たしていることを示しています。

## 結論

本章の統計によると、PWAは、とくに[モバイル](./mobile-web)において、[パフォーマンス](./performance)や[キャッシング](./caching)のコントロールがしやすいという利点があるため、今もなお採用が増え続けています。このような利点と、増え続ける[capabilities](./capabilities)により、私たちにはまだ大きな成長の可能性があります。2021年には、さらなる進化を期待しています。

ますます多くのブラウザやプラットフォームが、PWAを支える技術をサポートしています。今年は、EdgeがWeb App Manifestをサポートするようになりました。ユースケースやターゲット市場にもよりますが、ユーザーの大半（96％近く）がPWAをサポートしていることに気づくかもしれません。これは素晴らしい改善です。どのような場合でも、サービスワーカーやWeb App Manifestなどの技術を進歩的な機能強化としてアプローチすることが重要です。これらの技術を利用して、優れたユーザーエクスペリエンスを提供できます。上記の統計を見ると、今年もPWAの成長が期待できそうですね。
