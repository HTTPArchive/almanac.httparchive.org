---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: サードパーティ
description: 2022年版Web Almanacのサードパーティ編では、Web上でどのようなサードパーティが使用されているかというデータと、それらがパフォーマンスに悪影響を及ぼすのを防ぐための深堀りを紹介しています。
hero_alt: Hero image of Web Almanac chracters plugging various things into a web page.
authors: [imeugenia]
reviewers: [tunetheweb, kevinfarrugia, alexnj]
analysts: [kevinfarrugia]
editors: [shantsis]
translators: [ksakae1216]
imeugenia_bio: Eugeniaは、Webパフォーマンスとステートマシンに情熱を注ぐフロントエンドエンジニアであり、技術イベントのスピーカーです。N26やGorillasといったベルリンの急成長スタートアップで働いた経験があり、現在は<a hreflang="en" href="https://rapidapi.com/">RapidAPI</a>に入社しています。彼女はラトビアで数年間、Google Developer Groupを運営していました。
results: https://docs.google.com/spreadsheets/d/1YqoRRsyiNsrEabVLu2nRU98JIG_0zLLuoQhC2nX8xbM/
featured_quote: サードパーティは、ウェブパフォーマンスに悪影響を及ぼすと思われがちです。しかし、サードパーティとウェブサイトの開発者の両方が、サードパーティの機能がユーザー体験に害を及ぼさないように、それを排除できます。
featured_stat_1: 94%
featured_stat_label_1: 少なくとも1つのサードパーティを使用するウェブサイト
featured_stat_2: 2 sec
featured_stat_label_2: Google Mapsによるレンダリングブロック時間の中央値の可能性
featured_stat_3: 59%
featured_stat_label_3: LighthouseのレガシーJavaScript監査は、サードパーティが原因で失敗します。
---

## 序章

サードパーティは、もっともWebサイトにとって不可欠な存在です。この章では、ほぼすべてのウェブサイトが少なくとも1つのサードパーティを使用していること、そしてリクエストの約半分がサードパーティのリクエストであることを示しています。

ウェブサイトの所有者は、分析、広告、ライブチャット、同意管理など、いくつかの複雑な機能を委任するためにサードパーティを使用しています。ウェブサイト開発者は、サードパーティのコードを直接制御することはできませんが、サードパーティがウェブサイトに与える影響に影響を与えることは可能です。サードパーティがどれほど広く使われているかを考慮すると、サードパーティはウェブパフォーマンスに決定的な影響を及ぼします。サードパーティが[とくにモバイル端末でのページレンダリングをブロックする](#パフォーマンスへの影響)ことはよくあることです。たとえば、もっとも普及しているサードパーティーの上位10社のブロック時間の中央値の平均は1.4秒です。このため、サードパーティは、<a hreflang="ja" href="https://web.dev/i18n/ja/vitals/">Core Web Vitals</a>や、<a hreflang="ja" href="https://web.dev/i18n/ja/fcp">視覚コンテンツの初期表示時間</a>などの重要なパフォーマンス指標に直接影響を与えることがあります。

多くの推奨事項が、マイナスの影響を排除するのに役立ちます。それはリソースを最小化するような単純なテクニックかもしれませんし、たとえばレガシーJavaScriptを提供しないサードパーティ製スクリプトを評価して選択したり、Web Workerを使ってサードパーティ製スクリプトをロードして実行したりするような、より複雑なものであるかもしれません。

この章では、ウェブサイトの所有者とサードパーティの開発者が、サードパーティのネガティブな影響をどのように軽減できるか、またベストプラクティスが守られているかどうかというトピックに焦点を当てます。まず、サードパーティの普及状況や、レンダーブロック時間やメインスレッドへの影響といったウェブパフォーマンスに関連する指標について説明します。後半は、リソースの最小化と圧縮、サードパーティーのファサード、`async`と`defer`のスクリプト属性、レガシーJavaScript、およびその他の最適化の機会に関するベストプラクティスを分析します。

## 定義

サードパーティとは、主要なサイトとユーザーの関係の外にある組織です。サイト所有者の直接の管理下にない、しかしその承認を得たサイトの側面に関与します。サードパーティのリソースは

* 共有・公開オリジンにてホスティング
* さまざまなサイトで幅広く利用
* 個々のサイトオーナーに影響されない

サードパーティの例としては、Googleフォント、パブリックオリジンで提供されるjQueryライブラリ、YouTubeの埋め込み動画などがあります。

定義に合わせるため、HTTP Archiveデータセット内の少なくとも50のユニークなページでリソースを見つけることができるドメインから発信されたサードパーティーのみを対象としました。

サードパーティのコンテンツがファーストパーティのドメインから提供されている場合、ファーストパーティのコンテンツとしてカウントされます。たとえば、Googleフォントやbootstrap.cssのセルフホスティングは、 _ファーストパーティのコンテンツ_ としてカウントされます。同様に、サードパーティのドメインから提供されるファーストパーティのコンテンツは、サードパーティのコンテンツとしてカウントされます（「50ページ以上の基準」をクリアしていることが前提です）。

### サードパーティーのカテゴリー

私たちは、サードパーティを特定し分類するために、[Patrick Hulce](https://x.com/patrickhulce) の <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">third-party-web</a> レポジトリに依存しています。このリポジトリでは、サードパーティを以下のカテゴリーに分類しています。

- **Ad** - これらのスクリプトは、広告ネットワークの一部であり、配信または測定を行っています。
- **Analytics** - ユーザーとその行動を測定または追跡するスクリプトです。何を追跡するかによって、ここでの影響は大きく異なります。
- **CDN** - These are a mixture of publicly hosted open source libraries (e.g. jQuery) served over different public CDNs and private CDN usage.
- **Content** - これらのスクリプトは、コンテンツプロバイダーや出版社特有のアフィリエイトトラッキングのものです。
- **Customer Success** - これらのスクリプトは、チャットやコンタクトのソリューションを提供するカスタマーサポート/マーケティングプロバイダーによるものです。これらのスクリプトは、一般的に重量が重くなっています。
- **Hosting*** - これらのスクリプトは、ウェブホスティングプラットフォーム（WordPress、Wix、Squarespaceなど）のものです。
- **Marketing** - これらのスクリプトは、ポップアップやニュースレターなどを追加するマーケティングツールのものです。
- **Social** - ソーシャル機能を実現するスクリプトです。
- **Tag Manager** - これらのスクリプトは、他の多くのスクリプトをロードし、多くのタスクを開始する傾向があります。
- **Utility** - これらのスクリプトは、開発者向けのユーティリティ（APIクライアント、サイト監視、不正検知など）です。
- **Video** - ビデオプレーヤーやストリーミング機能を実現するスクリプトです。
- **Consent provider** - これらのスクリプトにより、サイトはユーザーの同意を管理できます（例：[EU一般データ保護規則](https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87) 準拠のため）。これらは「Cookie Consent」ポップアップとしても知られており、通常、クリティカルパスでロードされます。
- **Other** - これらは、正確なカテゴリーや属性がなく、共有のオリジンを介して配信される雑多なスクリプトです。

注：ここでいうCDNカテゴリには、公開CDNドメイン（bootstrapcdn.com、cdnjs.cloudflare.comなど）でリソースを提供するプロバイダーが含まれ、単にCDN経由で提供されるリソースは含まれません。たとえば、ページの前にCloudflareを配置しても、当社の基準によるファーストパーティの指定に影響を与えることはありません。

* 前年度と同様に、ホスティングカテゴリは分析対象から除外しています。たとえばブログにWordPress.com、eコマースプラットフォームにShopifyをたまたま使っている場合、そのサイトによるこれらのドメインに対する他のリクエストは、多くの点でこれらのプラットフォームのホスティングの一部であり、真の「サードパーティ」ではないとして無視することにしています。

### 注意点

* ここで紹介するすべてのデータは、非インタラクティブなコールドロードに基づくものです。これらの値は、ユーザーとの対話の後、まったく異なるものになる可能性があります。
* ページは、クッキーが設定されていない米国のサーバーからテストされているため、オプトイン後に要求された第三者は含まれません。これはとくに、[EU一般データ保護規則](https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87)、またはその他の類似の法律の適用範囲にある国にホストされ、主に提供されるページに影響を与えるでしょう。
* トップページのみテストしています。その他のページでは、サードパーティーの要件が異なる場合があります。
* あまり使われていないサードパーティドメインの一部は、 _unknown_ カテゴリーに分類されています。
* 私たちは、さまざまな <a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/tree/master/core/audits">Lighthouse監査</a>を活用しています。その中には、カバー範囲が限られているものもあります。すなわち、<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-facades.js">サードパーティ ファサード監査</a>で、既存のファサード実装をすべてカバーすることは現実的でありません。

当社の[方法論](./methodology)について詳しく説明します。

## 普及率

{{ figure_markup(
  caption="少なくとも1つのサードパーティを使用しているモバイルページの割合",
  content="94%",
  classes="big-number",
  sheets_gid="1355951746",
  sql_file="percent_of_websites_with_third_party.sql"
)
}}

サードパーティの普及率は、前年と同じ高い水準で推移しました： 94％のウェブサイトが少なくとも1つのサードパーティを使用しています。

{{ figure_markup(
  image="median-number-of-third-parties-by-rank.png",
  caption="ランク別1ページあたりのサードパーティドメイン数の中央値。",
  description="さまざまなウェブサイトのランクカテゴリーにおけるサードパーティドメインの数の中央値を示す棒グラフ。上位1,000のウェブサイトでは、デスクトップとモバイルウェブサイトでそれぞれ53と43のサードパーティが使用されています。上位10,000のウェブサイトでは、デスクトップとモバイルウェブサイトでそれぞれ48と43のサードパーティが使用されています。上位10万件のウェブサイトでは、デスクトップおよびモバイルウェブサイトでそれぞれ34社および31社のサードパーティが利用されています。上位1,000,000のウェブサイトでは、デスクトップとモバイルウェブサイトでそれぞれ28社と25社のサードパーティを利用しています。全ウェブサイトのサードパーティ数の中央値は、デスクトップとモバイルでそれぞれ24と21です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1946246067&format=interactive",
  sheets_gid="759454652",
  sql_file="number_of_third_party_providers_by_rank.sql"
  )
}}

上の図は、もっとも利用されているウェブサイトのサードパーティドメインの数を示しています。たとえば、人気上位1,000サイトの平均では、モバイルデバイスで43、デスクトップデバイスで53のサードパーティドメインが使用されています。人気の高いウェブサイトほど、サードパーティの数が多いようです。つまり、上位1,000サイトでは、全ウェブサイトのサードパーティの数の中央値よりも2倍多くサードパーティが使われています。たとえば、Yahooは `mempf.yahoo.co.jp`、`yjtag.yahoo.co.jp` などのドメインからコンテンツを配信しています。
サードパーティプロバイダーの正確な数についてはまだ研究が必要ですが、サードパーティドメインに関する現在のデータは、それらがネットワークリクエストに費やす時間にどの程度影響するかを概観できます。新しいドメインへのリクエストには、DNSルックアップと初期接続の確立に時間がかかるため、サードパーティドメインの使用量が多ければ多いほど、ページの読み込み速度に影響を与える可能性があります。

{{ figure_markup(
  image="third-party-domains-per-page-by-rank-and-category.png",
  caption="カテゴリ別、ランク別に見た1ページあたりのサードパーティドメイン数の中央値。",
  description="さまざまなウェブサイトのランクカテゴリーにおけるサードパーティカテゴリー別のサードパーティドメイン数の中央値を示す棒グラフです。モバイルページでのデータを示しています。ランクによって大きく異なるのは、広告、unknown、動画カテゴリのみです。上位1,000のウェブサイトでは、18のサードパーティドメインが広告カテゴリ、21のunknown、5のビデオです。上位10,000サイトでは、広告カテゴリが22、unknownが16、動画が4となっています。もっとも多い10万ウェブサイトの場合、15が広告カテゴリ、12がunknown、8がビデオです。上位1,000,000のウェブサイトでは、7つの広告カテゴリ、9つのunknown、11のビデオです。すべてのウェブサイトでは、広告カテゴリ4、unknown 8、ビデオ11です。その他のサードパーティカテゴリに関するデータによると、1ページあたりのサードパーティドメイン数は、アナリティクスカテゴリが3～5、CDNが4～5、同意プロバイダーが7～8、コンテンツプロバイダーが3～5、カスタマーサクセス9、マーケティング2～3、ソーシャル5～6、タグマネージャー1～2、実用カテゴリ3～4、その他カテゴリ2となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=419972852&format=interactive",
  sheets_gid="163918555",
  sql_file="number_of_third_parties_by_rank_and_category.sql"
  )
}}

サードパーティのカテゴリ別、ランク別の分布を見ると、もっとも普及しているウェブサイトでのサードパーティの増加は、広告と未知の（分類されていない）サードパーティのカテゴリで占められていることが明らかになりました。つまり、サードパーティ（とくに広告）は、ユーザー数の多いウェブサイトで多く利用されているため、ユーザーに決定的な影響を及ぼしていることがわかります。

{{ figure_markup(
  image="top-third-parties-by-number-of-pages.png",
  caption="使用されているページ数でもっとも多いサードパーティ上位10社",
  description="もっとも普及しているサードパーティーのトップ10の使用状況を示す棒グラフです。fonts.googleapis.comはモバイルページの63％、google-analytics.comは51％、accounts.google.comは49％、adservice.google.comは47％、gogletagmanager.comは46％で使われています。残りのajax.googleapis.com、facebook.com、cdnjs.cloudflare.com、youtube.com、maps.google.comは、モバイルページの30％未満に使用されています。デスクトップとモバイルの割合は、すべてのサードパーティで同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=857401072&format=interactive",
  sheets_gid="756029157",
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

Googleのサービス：フォント、分析、アカウント管理、広告、タグ管理は、ウェブ全体でもっとも普及しているサードパーティです。全ページの63%がGoogleフォントを使用しており、これはデータセットに含まれる790万件のモバイルページのうち、490万件以上に相当します！

{{ figure_markup(
  caption="サードパーティからのリクエストのうち、スクリプトの占める割合",
  content="34%",
  classes="big-number",
  sheets_gid="811897794",
  sql_file="percent_of_third_parties_by_content_type.sql"
)
}}

サードパーティのリクエストは、Webサイトが行うリクエストの45％を占め、そのサードパーティのリクエストのうち、約3分の1がスクリプトです。このことから、[ウェブパフォーマンスのベストプラクティス](#ウェブパフォーマンスのベストプラクティス)でスクリプトをより詳細に分析する価値があることがわかります。

## パフォーマンスへの影響

サードパーティーの中には、どうしてもページのレンダリングをブロックしてしまい、Webページの読み込み体験に悪影響を及ぼすものがあるかもしれ<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/byte-efficiency/render-blocking-resources.js">レンダーブロッキングリソース監査</a>があり、レンダーブロッキング時間に関するデータを提供します。

{{ figure_markup(
  image="render-blocking-time-by-most-popular-third-parties.png",
  caption="もっとも普及しているサードパーティーの上位10社のレンダリングブロック時間の中央値。",
  description="レンダーブロッキングを行うサードパーティーのうち、もっとも普及している上位10社の潜在的なレンダーブロッキング時間を示す棒グラフです。fonts.googleapis.comのレンダーブロック時間の中央値はモバイルページで1.085ミリ秒、accounts.google.comのレンダーブロック時間は1,077ミリ秒、adservice.google.comは1,571秒、Googletagmanager. comが1,806秒、ajax.googleapis.comが1,530秒、cloudflare.comが1,300秒、youtube.comが1,146秒、bootstrapcdn.comが1,241秒、maps.google.comが2.095秒、jsdelivr.netが1,370秒です。デスクトップとモバイルのデータは、すべてのサードパーティで同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=549590895&format=interactive",
  sheets_gid="944312903",
  sql_file="third_parties_blocking_rendering_percentiles.sql",
  width=600,
  height=557
  )
}}

上の図は、もっとも普及しているサードパーティーの上位10社のレンダリングブロック時間の中央値を示しています。レンダリング時間にもっとも大きな影響を与えるのは、Googleマップです。中央値のウェブサイトでは、2秒以上を占めています。これは、<a hreflang="ja" href="https://web.dev/i18n/ja/fcp/">視覚コンテンツの初期表示時間</a>の推奨時間（ページ読み込み速度指標）が1.8秒であることを考慮すると、大きな影響と言えます。

Webサイトは、レンダー ブロックを引き起こすリソースを排除することで、読み込み時間を大幅に短縮できます。<a hreflang="en" href="https://web.dev/embed-best-practices/">ブロッキングしない方法でサードパーティを埋め込む</a>方法はたくさんあります。たとえば、Googleマップの場合、<a hreflang="ja" href="https://developers.google.com/maps/documentation/maps-static/overview?hl=ja">Maps Static API</a>を使って、サードパーティのファサードを実装できます。また、サードパーティのiframeを遅延ロードさせることもできます。

さらに、サードパーティのスクリプトは、ウェブサイトのファーストパーティのコードとメインスレッドのリソースを奪い合います。サードパーティのJavaScriptタスクがメインスレッド上で50ms以上、長時間実行されている場合、「メインスレッドをブロックしている」とみなされます。メインスレッドは、ページのレンダリングだけでなく、ユーザーイベントの処理も担っているため、ページを操作する際のユーザー体験に大きな影響を与える可能性があります。メインスレッドがブロックされると、ユーザーはページの応答性が低下します。

私たちは、<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-summary.js">第三者要約監査</a>を検査して、第三者によって引き起こされるメイン スレッドのブロック時間をエミュレートしています。

{{ figure_markup(
  image="third-parties-blocking-main-thread.png",
  caption="本スレを阻むサードパーティーのもっとも多い10社",
  description="サードパーティによってメインスレッドがブロックされているモバイルページの割合を、サードパーティ上位10社別に示した棒グラフです。YouTubeは90%、Google Mapsは85%、その他のGoogle API/SDKは84%、Facebookは82%、Google Dounbleclick Adsは81%、Google CDNは79%、Google Tag Managerは75%、Cloudfare CDNは71%、Google Analyticsは70%、Google Fontsは63%のモバイルページでメインスレッドをブロックしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1753375995&format=interactive",
  sheets_gid="1541263858",
  sql_file="third_parties_blocking_main_thread.sql",
  width=600,
  height=426
  )
}}

上図は、モバイル端末でもっとも多く利用されているサードパーティーの上位10位と、それらがメインスレッドに与える影響を示したものです。なお、デスクトップ端末では、その影響はかなり低くなっています。たとえば、YouTubeは、モバイルウェブサイトの90%でメインスレッドをブロックしますが、デスクトップウェブサイトでは26%しかブロックしていません。これは、デスクトップ端末の方がはるかに高性能であることを考慮すると、理にかなっています。しかし現在では、モバイルユーザー体験は非常に重要であり、[モバイルウェブ](./mobile-web)の章によると、ウェブサイト訪問者の58%がモバイルデバイスから訪れているそうです。

メインスレッドのブロッキングによってウェブサイトユーザーがどのような影響を受けるかをより詳細に調べるために、メインスレッドのブロッキング時間の中央値を確認します。

{{ figure_markup(
  image="main-thread-blocking-time-by-third-party.png",
  caption="もっとも普及しているサードパーティーの上位5社のメインスレッドブロック時間の中央値（単位：ms）。",
  description="上位5社のサードパーティによるメインスレッドブロック時間の中央値を示す棒グラフです。YouTubeはモバイルページで1.721ミリ秒、デスクトップページで117ミリ秒、Google Mapsは298と0、Facebookは93と0、Google Analyticsは76と0、Google Tag Managerは65と0、メインスレッドをブロックしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1006809602&format=interactive",
  sheets_gid="1541263858",
  sql_file="third_parties_blocking_main_thread.sql"
  )
}}

YouTubeは、もっとも多く利用されているサードパーティーの上位5社の中で、もっともブロックが多いサードパーティーです。YouTubeの動画を読み込むウェブサイトの中央値で、1.7秒以上メインスレッドをブロックしています（クロールの一環としてエミュレートしたモバイルデバイスに基づく）。デスクトップのウェブサイトはほとんど影響を受けていないため、デスクトップとモバイルのウェブサイトには顕著な差があります。

Lighthouseは、サードパーティーのサイズが非常に小さく、レンダリングブロッキング時間に明確な影響を与えない場合でも、レンダリングブロッキングの可能性があるとしてマークする場合があります。これは、GoogleフォントやGoogle/Doubleclick Adsのように、レンダリングブロッキング時間の中央値が0ミリ秒であるサードパーティが該当します。

メインスレッドがブロックされると、[最初の入力までの遅延(FID)](https://web.dev/i18n/ja/fid/) と [次のペイントへのインタラクション(INP)](https://web.dev/articles/inp/) の性能指標に大きな影響を及ぼします。Webページの応答性を高めるためには、FIDは100ms以下、INPは200ms以下であることが望ましいとされています。モバイル機器における<a hreflang="en" href="https://github.com/GoogleChromeLabs/chrome-http-archive-analysis/blob/main/notebooks/HTTP_Archive_TBT_and_INP.ipynb">総ブロッキング時間と次のペイントへのインタラクション</a>の相関関係については、[Annie Sullivan](https://x.com/anniesullie)による研究があります。それによると、メインスレッドのブロック時間が小さいほど、サイトが良好なINPとFIDの閾値を満たす可能性が高いことがわかります。このことから、YouTubeの事例のように、サード パーティがメイン スレッドを長時間ブロックしている場合、良好なコアWebパフォーマンス指標を達成することが難しくなるという結論に達します。さらに、他のサードパーティやファーストパーティの資産も、レンダーブロッキング効果の一因となる可能性があります。しかし、サードパーティによるレンダリングブロックを最小限に抑える方法は数多くあります。これについては、次のセクションでさらに検討します。

## ウェブパフォーマンスのベストプラクティス

前節では、サードパーティが潜在的に、Webサイト体験全体に影響を及ぼすような大きなパフォーマンスインパクトを引き起こしていることを確認しました。しかしウェブサイトとサードパーティの開発者は、リソースの最小化からサードパーティのファサードの使用まで、サードパーティのパフォーマンスへの影響を最小限に抑えるために、もっとも高いパフォーマンスを実践できます。私たちは、ベストプラクティスがどのように守られているかを理解するために、さまざまなサードパーティの使用傾向を調べました。

### リソースの最小化

JavaScriptとCSSファイルの最小化は、ウェブパフォーマンスを語る上で、最初に推奨されるものの1つです。サードパーティのリソースがどのように最小化されているかを確認するために、私たちは以下のLighthouseオーディットを利用しています。<a hreflang="en" href="https://web.dev/unminified-javascript/">未定義のJavaScript</a>と<a hreflang="en" href="https://web.dev/unminified-css/">未定義のCSS</a>です。

スクリプトはもっとも普及しているサードパーティーのコンテンツタイプであるため、最小化することで大きな効果が得られるはずです。さらに、CSSのような他のコンテンツタイプに比べ、スクリプトはコメントや大きな変数名など、ファイルサイズに影響するような冗長なものになる傾向があります。

{{ figure_markup(
  image="average-potentially-saved-bytes-of-unminified-javascript.png",
  caption="最小化されていないJavaScriptの平均的な潜在的保存バイトのファーストパーティとサードパーティによる割合。",
  description="モバイルページにおけるリソースのオリジンタイプ別に、潜在的に保存されているJavaScriptの平均バイト数の分布を示す円グラフです。最小化されていないJavaScriptの18.7%はサードパーティから、81.3%はファーストパーティから発信されたものであることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1231774655&format=interactive",
  sheets_gid="1485577770",
  sql_file="lighthouse_average_unminified_js_by_3p.sql"
  )
}}

サードパーティのリソースを最小化することで、一部のJavaScriptバイトを節約できますが、ファーストパーティのスクリプトはウェブサイト上の未削減JavaScriptのもっとも大きな量、すなわち潜在的に節約できる平均総バイト数の81％を占めています。最小化されていないJavaScriptの分布を見ると、75%のWebサイトで34.5KBの削減が可能であるのに対し、サードパーティによる削減は2.8KBにとどまっています。

次の図は、サードパーティによる潜在的な節約額の大きさを表示したものです。ここで重要なのは使用した手法で、外部ドメインから来たサードパーティのみを含み、ファーストパーティがホストするサードパーティのコンテンツ、たとえばノードモジュールとしてインポートされたライブラリはカウントしないことです。

{{ figure_markup(
  image="potential-savings-of-unminified-javascript-by-third-party.png",
  caption="サードパーティ製スクリプトプロバイダー上位5社の、潜在的に保存されている未消化のJavaScriptの平均キロバイト数。",
  description="サードパーティが提供する未消化のJavaScriptを1ページあたり何キロバイト節約できるかを示す棒グラフです。`code.jquery.com`から提供されたスクリプトを最小化した場合、モバイルページでは42キロバイト、`s0.wp.com`では14キロバイト、 `vk.com` では13、 `shopify.com` では20、 `cloudflare.com` では14キロバイテ、デスクトップとモバイルページでほぼ同じ節約効果が期待されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=496701127&format=interactive",
  sheets_gid="438030733",
  sql_file="lighthouse_unminified_js_by_3p.sql"
  )
}}

jQueryのCDNライブラリである`code.jquery.com`は、デスクトップ上の全ウェブサイトの6%で使用されているもっとも普及しているJavaScriptサードパーティ製ライブラリです（なお、jQueryは[はるかに多くのウェブサイト](./javascript#ライブラリの利用状況)で使用されていますが、すべての使用がこのCDNから提供されているとは限りません）。このCDNで利用可能な最小化されたバージョンのリソースを使用することで、最小化されていないjQueryを持つページあたり平均43KBのデータを節約できます。

{{ figure_markup(
  caption="jQueryサードパーティを使用している全ページのうち、jQueryを削除していないデスクトップページの割合。",
  content="17%",
  classes="big-number",
  sheets_gid="438030733",
  sql_file="lighthouse_unminified_js_by_3p.sql"
)
}}

サードパーティのドメインでホストされているjQueryを使用しているウェブサイトの17%が、<a hreflang="en" href="https://web.dev/unminified-javascript/">縮小されていないJavaScriptのLighthouse監査</a>に失敗しました。ライブラリのインポート方法を詳しく調べると、多くのウェブサイトが、開発目的にのみ使用されるべきjQueryの未定義バージョンを使用していることがわかります。同様の傾向は、他のあまり人気のないサードパーティ製スクリプトの使用にも見られます。

このことは、Web開発者にとって、Webサイトに取り込まれたサードパーティ製スクリプトが本番環境に最適化されているかどうかを確認するための注意喚起となるはずです。

{{ figure_markup(
  image="average-potentially-saved-bytes-of-unminified-css.png",
  caption="ファーストパーティとサードパーティによる、潜在的に保存されたCSSの平均バイト数の割合",
  description="モバイルページにおけるリソースオリジンの種類別に、潜在的に保存されている未消化CSSの平均バイト数の分布を示す円グラフです。最小化されていないJavaScriptの10.7%はサードパーティから、89.3%はファーストパーティから発信されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=417912172&format=interactive",
  sheets_gid="1857859997",
  sql_file="lighthouse_average_unminified_css_by_3p.sql"
  )
}}

最小化されていないCSSの監査では、サードパーティの資産の影響がはるかに小さいことがわかります。とくに、ファーストパーティのCSSコードの潜在的な保存バイト数の平均が全体の89％であることと比較すると、サードパーティの資産の影響が大きいことがわかります。このデータは、サードパーティのCSSコンテンツは十分にミニファイされており、ファーストパーティのCSSよりもはるかに影響が小さいことを実証しています。

Googleフォントは、モバイル端末でもっとも普及しているサードパーティであり、全ウェブサイトの62.6%で使用されています。彼らが提供するCSSは、最小化されていません。データによると、Googleフォントを使用している平均的なページでは、最小化することで13.3KBを節約できるそうです。これは、改善のチャンスと思われます。しかしGoogle FontsのCSSには、非常に類似した `font-face` 定義が多数含まれており多くのフォントの場合、ほとんど同じように繰り返されるためHTTPレベルの圧縮がここで非常にうまく機能し、最小化しなくてもファイルサイズを大幅に削減できます。このため、最小化のメリットは、ローカルに複製する可能性のあるCSSを見たい人にとって、コードの読みやすさに比べて非常に低くなります。より複雑で大きなCSSを持つ他のサードパーティは、最小化によってより多くの利益を得られるかもしれません。

### リソースの圧縮

ファイルの圧縮は、サードパーティの開発者がウェブパフォーマンスに好影響を与えるためにできる、もう1つの手っ取り早い方法です。スクリプトやCSSのような重いコンテンツタイプのほとんどは、圧縮率が高いです。サードパーティからのリクエストのうち、圧縮されていないのはスクリプトの12％とCSSファイルの4.5％にすぎません。

{{ figure_markup(
  image="content-encoding-by-content-type.png",
  caption="モバイルページにおけるサードパーティーのコンテンツタイプ別のContent-encoding。",
  description="モバイルページにおけるコンテンツエンコードタイプ別のThirs-partyリクエストの割合を示す分布図。ビデオコンテンツは圧縮なし、その他のコンテンツは2%がgzip圧縮、フォントコンテンツは2%がgzip、1%がbrotli圧縮、画像コンテンツは5%と1%、テキスト4%と5%、プレーン4%と5%、オーディオ33%がgzip、html25%と14%、xml30%と19%、スクリプト60%と29%、CSS69%および27%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1766106033&format=interactive",
  sheets_gid="376393975",
  sql_file="content_encoding_by_content_type.sql"
  )
}}

上図に表示されたウェブサイトのコンテンツエンコードデータから、画像圧縮に関する興味深い事実が判明しました。JPEG、PNG、WebP、AVIFなどの画像フォーマットは、そのフォーマットの一部として圧縮機能を備えているにもかかわらず、画像コンテンツの5.2%がGzipまたはBrotli圧縮を使用して再度圧縮されています。標準的な画像圧縮フォーマットの上にさらに圧縮のレイヤーを追加することは通常不要で、ファイルサイズの増加につながり、画像を解凍する際にCPUに余分な負荷を与える可能性があります。

Gzipは依然としてもっとも普及している圧縮タイプで、つまり59%のスクリプトと68%のCSSがGzipで圧縮されています。しかし、Brotli圧縮はより効果的です。ファーストパーティとサードパーティの動向を見ると、この3年間でBrotli圧縮の使用率が上昇し、圧縮なしとGzipの使用率が低下していることがわかります。

{{ figure_markup(
  image="first-party-content-encoding-by-year.png",
  caption="モバイルサイトにおける、コンテンツエンコードタイプ別および年別のファーストパーティースクリプトリクエストの割合。",
  description="2020年から2022年までのファーストパーティーのコンテンツエンコードの傾向を示す棒グラフ。2020年には19%のコンテンツが圧縮なし、2021年には16%、2022年には15.14%になります。 2020年、13％のコンテンツがbrotli圧縮、2021年32％、2022年40％。2020年には66%のコンテンツがgzip圧縮を行い、2021年には52%、2022年には45%になります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=2058399908&format=interactive",
  sheets_gid="1568790776",
  sql_file="trends_content_encoding_by_type.sql"
  )
}}

brotli経由で圧縮されたファーストパーティーのスクリプトの割合は、15%から40%へと約3倍に増加しました。

{{ figure_markup(
  image="third-party-content-encoding-by-year.png",
  caption="コンテンツエンコードタイプ別、年別のサードパーティ製スクリプトリクエストの割合",
  description="2020年から2022年までのファーストパーティーのコンテンツエンコードの傾向を示す棒グラフ。2020年には12％のコンテンツが圧縮なし、2021年には11％、2022年には12％。 2020年には24%のコンテンツがbrotli圧縮を行い、2021年には30%、2022年には29%になります。2020年には64%のコンテンツがgzip圧縮を行い、2021年には59%、2022年には60%になります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1920216281&format=interactive",
  sheets_gid="1568790776",
  sql_file="trends_content_encoding_by_type.sql"
  )
}}

しかし、サードパーティーのBrotli採用率は24%から29%に変化し、ほぼ同じ水準にとどまっています。わずかなプラス傾向とはいえ、サードパーティーのBrotli採用率にはまだ改善の余地があります。

### サードパーティ製ファサードの使用について

レンダーブロッキング リソースを排除するための複数のテクニックがあります。そのうちの1つが <a hreflang="ja" href="https://developer.chrome.com/ja/docs/lighthouse/performance/third-party-facades/">サードパーティーファサード</a> で、YouTube動画などの視覚コンテンツやライブ チャットなどの対話型ウィジェットに役立ちます。このファサードは、サードパーティを重要なロード シーケンスから除外し、遅延ロードするのに役立ちます。Lighthouseは、監査 <a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/third-party-facades.js">サードパーティーのリソースをファサードで遅延ロード</a> を導入しました。たとえば<a hreflang="en" href="https://github.com/paulirish/lite-youtube-embed">lite-youtube-embed</a> 、<a hreflang="en" href="https://github.com/justinribeiro/lite-youtube">lite-youtube</a> 、またはいくつかのカスタムアプローチなど複数の第三者ファケードソリューションがありますが、監査中にチェックした<a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/master/data/entities.js"> 第三者のリスト</a>にはその一部しか含まれていませんでした。この制限により、現時点では、ウェブ全体におけるサード パーティ製ファサードの使用状況を評価することが複雑になっています。

### `async`と`defer`の使用法

`async`と`defer`の使用は、レンダーブロックを引き起こすサードパーティ製スクリプトの読み込みを最適化するために、ウェブサイト開発者が使用できるもう1つのテクニックです。

{{ figure_markup(
  image="async-and-defer-for-third-party-scripts.png",
  caption="サードパーティーの全スクリプトリクエストのうち、`async`と`defer`の属性による割合です。",
  description="モバイルページでは、62%のサードパーティ製スクリプトが`async`属性を、7%の`defer`属性を持つことが棒グラフで示されています。デスクトップページのデータも非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=1722277284&format=interactive",
  sheets_gid="1590023791",
  sql_file="scripts_using_async_defer.sql"
  )
}}

`async`属性は、`defer`よりもかなり人気があります。モバイルデバイスのサードパーティ製スクリプト全体の62%に使用されています。`async`属性を使用しても、HTMLの解析中にスクリプトの実行が開始されるため、レンダーブロッキングが発生することがあります。`async`属性は、ページの読み込み中に重要なリソースがあり、レンダリングが中断される可能性がある場合に有効です。

`async`がより多く使われているということは、サードパーティーのスクリプトがもっとも重要なリソースとして扱われていることを示しています。これは一部のスクリプトには当てはまりますが、多くのサードパーティ、たとえばビデオプレーヤーはそれほど重要ではありません。遅延スクリプトは、潜在的にページのレンダリング時間に良い影響を与え、それは<a hreflang="ja" href="https://web.dev/i18n/ja/lcp/">最大のコンテンツフルペイント</a>のようなコアウェブパフォーマンスメトリクスに反映されています。ウェブサイト開発者は、重要なレンダリングパスにとって重要でないサードパーティの資産に `defer` を使用することを検討すべきです。

どのリソースが重要で、どのリソースが延期できるかは、とくに他のサードパーティを使用可能にする _コンセントマネジメント_ サードパーティを考慮する場合、厄介な問題かもしれません。たとえば、分析スクリプトは通常サイトオーナーにとって重要なものとされていますが、[GDPR](https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87)や同様の法律がある国ではユーザーの同意なしに使用することはできず、ユーザーの同意がサードパーティにとって重要となっています。クリティカルパスでサードパーティーのリソースをロードすると、累積レイアウトシフトやファーストインプットディレイの原因となり、ユーザー体験が悪くなる場合があります。したがって、開発者は、サードパーティーのロード方法とユーザー体験のバランスを取るように努力する必要があります。

### レガシーJavaScript

JavaScriptの急速な普及にもかかわらず、レガシーコードの普及はまだ顕著です。私たちはLighthouseの監査の1つを利用して、<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/blob/master/core/audits/byte-efficiency/legacy-javascript.js">レガシー JavaScriptをモダンブラウザに提供しているサードパーティがどれくらいあるかをチェックしています</a>。

{{ figure_markup(
  caption="レガシーJavaScript Lighthouseの監査失敗のうち、サードパーティに起因するものの割合",
  content="59%",
  classes="big-number",
  sheets_gid="2078522493",
  sql_file="third_parties_using_legacy_javascript.sql"
)
}}

一般的に、LighthouseのレガシーJavaScript監査失敗の59%はサードパーティが占めています。監査結果を詳しく見ると、レガシーJavaScriptを含むサードパーティーのスクリプトプロバイダーがもっとも多い5社であることがわかります。

{{ figure_markup(
  image="pages-with-third-parties-that-use-legacy-javascript.png",
  caption="レガシーなJavaScriptを搭載したサードパーティを利用しているウェブサイトの割合",
  description="レガシーJavaScriptを提供するサードパーティーのうち、もっとも多く使われているトップ5を示す棒グラフです。モバイルページの18.5%でconnect.facebook.net、3.3%でapis.google.com、3.2%でscript.hotjar.com、2.8%でcdn.shopify.com、2.4%でstatic.xx.fbcdn.netが利用されています。デスクトップページのデータも非常によく似ています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=2145007275&format=interactive",
  sheets_gid="596336022",
  sql_file="percent_of_third_parties_using_legacy_javascript.sql"
  )
}}

Facebookは、もっとも多くのページに影響を与えるレガシーJavaScriptを持つサードパーティです。上のグラフから`facebook.net`と`fbcdn.net`の両方を見た場合、モバイルデバイスとデスクトップデバイスのウェブページ総数のうち、それぞれ約20%にレガシーコードが導入されていることがわかります。Internet Explorerのような古いブラウザに対応する必要がなくなった現在では、レガシーJavaScriptを残す必要性は低くなっています。しかし、過去3年間のレガシーJavaScriptを搭載したFacebookリソースの利用動向を見ると、`facebook.net`だけで2020年の約14％から2022年には18％と、むしろ増えていることがわかります。これは、このサードパーティを埋め込むWebサイトが増加しているためです。

レガシーなJavaScriptをモダンブラウザに提供すると、冗長で低速なコードが大量に発生します。未使用のJavaScriptのサイズを分析することで、これをより詳しく調べることができます。

{{ figure_markup(
  image="size-of-unused-javascript.png",
  caption="未使用のサードパーティ製JavaScriptのサイズ。",
  description="未使用のサードパーティ製JavaScriptのサイズ（キロバイト）をパーセンタイル別に示した棒グラフ。モバイルページの未使用JavaScriptのサイズは、25パーセンタイルで39キロバイト、50パーセンタイルで116キロバイト、75パーセンタイルで261キロバイト、90パーセンタイルで507キロバイトです。デスクトップページでは、未使用のJavaScriptのサイズがわずかに大きくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSefmoEZjMhonz5fkMTxGIywJn-T7F8vYGAaj9wF9n5l8gApihCf3WCMZtrP3Syg-9E8RD8IKZg62U7/pubchart?oid=291457440&format=interactive",
  sheets_gid="1663851660",
  sql_file="distribution_of_lighthouse_unused_js_by_3p.sql"
  )
}}

未使用のサードパーティ製JavaScriptの中央値は、約120KBです。サードパーティ製スクリプトを使用しているウェブサイトの25%では、261 KB以上となっています。

残念ながら、Webサイトの所有者には、サードパーティJavaScriptのバンドル方法を変更する可能性があるとは限りません。しかし、サードパーティの依存関係がセルフホストされている場合、<a hreflang="en" href="https://web.dev/publish-modern-javascript">最新のスクリプト バンドル手法</a>を採用することで開発中に最適化することができ、未使用コードの量を減らすのに役立つ可能性があります。

### その他の最適化技術

サードパーティリソース管理の問題の1つは、時に開発チームを飛び越えて、適切なウェブパフォーマンス評価を行わずにタグ管理ツールを使って追加されることです。その結果、サードパーティーのスクリプトが、ページの読み込みや応答性の体験に制御不能な影響を与えることがあります。

近年、いくつかのモダンなサードパーティのロードと実行のソリューションが登場しています。たとえば、<a hreflang="en" href="https://partytown.builder.io/">Partytown</a> は、ファーストパーティのコードのためにメインスレッドを解放するために、サードパーティのスクリプトをWebワーカーに再配置するライブラリです。現在、ライブラリの利用状況は初期導入段階であり、非常に低い状況です。2022年にデータセット全体から70のウェブサイトしか使用していません。しかし、<a hreflang="en" href="https://nextjs.org/docs/basic-features/script#off-loading-scripts-to-a-web-worker-experimental">Next.jsフレームワークがこのソリューション</a>の導入を開始したことで、Partytownの人気が高まるかもしれません。

前のセクションでは、サードパーティの悪影響に対する責任がファーストパーティとサードパーティの開発者の間で分担されていることを示しました。しかし、<a hreflang="en" href="https://developer.chrome.com/blog/third-party-scripts#proposed-approach">ブラウザもサードパーティ製リソースの読み込みを最適化することに関心を示しています</a>。提案には、より良いリアルユーザーのモニタリングと、サードパーティがウェブサイトに与える影響についてより多くのデータを提供する開発者向けツールが含まれています。

{{ figure_markup(
  caption="Timing-Allow-Originヘッダーを持つサードパーティリクエストの割合",
  content="25%",
  classes="big-number",
  sheets_gid="1045520136",
  sql_file="tao_by_third_party.sql"
)
}}

サードパーティのウェブパフォーマンスデータの透明性を高めるために重要な[Timing-Allow-Origin (TAO)ヘッダー](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Timing-Allow-Origin)を提供するサードパーティのリクエストは全体の25%に過ぎないことから、この達成は困難かもしれません。

[TAOヘッダーの普及率が以前と比較して改善されていない](../2021/third-parties#Timing-Allow-Originヘッダーの普及率)ことを考慮し、ファーストパーティがこれらのリソースのパフォーマンスについてより正確に把握できるように、第三者プロバイダーがより積極的に利用することを推奨します。

## 結論

サードパーティは、しばしばウェブサイトのパフォーマンスに悪影響を及ぼすとされています。実際、レンダリングやメインスレッドのブロックにかかる時間は、とくにモバイルデバイスで顕著になります（モバイルデバイスはますます一般的になっています）。しかし、この章の主な目的は、サードパーティがウェブパフォーマンスに与える影響の責任は、サードパーティのプロバイダーとウェブサイトの所有者の間で共有されることを示すことです。ウェブサイト開発者には、サードパーティーの影響を軽減する機会がたくさんあります。将来的には、ブラウザがサードパーティのリソース最適化を自動的に適用するようになるかもしれません。

圧縮・最小化されたリソース、レガシーAPI、未使用のJavaScriptなど、さまざまなウェブパフォーマンスの推奨事項に関連するデータを分析しました。その結果をもとに、ウェブサイトやサードパーティの開発者がユーザー体験を向上させるために役立つ、以下のようなアクションポイントを実施しました。

- ミニ化・圧縮された本番環境に適したサードパーティ製リソースをロードします。
- とくに動画、地図、ライブチャットなどの「重い」コンテンツでは、レンダリングをブロックし、視覚コンテンツの初期表示時間に決定的な影響を与える可能性があるため、さまざまなサードパーティーのファサード技術を活用します。
- サードパーティーの候補を評価しながら、必要な場合を除き、レガシーなAPIを提供していないことを確認します。
- サードパーティーのコンテンツがページにとってどれだけ重要かを考慮し、レンダーブロッキングが発生しない場合は`defer`属性を使って重要でないリソースをロードします。
- 最新のサードパーティーのロードと実行のストラテジーを探求します。
- gzipよりもBrotli圧縮を選択してください。

最適化の機会はまだまだたくさんあります！サードパーティが提供する機能がユーザー体験を損なうことなくウェブサイトを提供できるよう、ウェブデベロッパーにはそのような取り組みを推奨しています。
