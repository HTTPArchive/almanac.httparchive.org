---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: プライバシー
description: 2025年版Web Almanacのプライバシーチャプターは、オンライントラッキングの採用と影響、プライバシー設定シグナル、プライバシーに配慮したウェブのためのブラウザ施策を取り上げます。
hero_alt: カメラ、スマートフォン、マイクを持つWeb Almanacのキャラクターたちがパパラッチのように振る舞い、別のキャラクターがシャワーカーテンを引いてウェブページを明らかにするヒーロー画像。
authors: [RumaisaHabib, securient, nrllh]
analysts: [max-ostapenko]
reviewers: [JannisBush]
editors: [max-ostapenko]
nrllh_bio: Nurullah Demirは、スタンフォード大学の訪問ポスドク研究者であり、サイバーセキュリティプラットフォームSecuSeekの創設者です。インターネット規模のセキュリティとプライバシーリスクに焦点を当てた研究を行っています。
RumaisaHabib_bio: Rumaisa Habibは、スタンフォード大学の実証セキュリティ研究グループで研究するPhD課程3年生です。主な研究関心は、大規模なインターネット計測を活用して西洋以外のコンテキストにおけるウェブの理解を深めることです。
securient_bio: VinodはPIP Labsのスタッフセキュリティエンジニアで、Amazon、Zapier、HackerOneなどの企業でのサイバーセキュリティ経験が10年以上あります。ペネトレーションテストとクラウドセキュリティを専門とし、Mediumでセキュリティについて執筆し、従来型およびWeb3環境の新たな脅威を積極的に研究しています。
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1Svyw40Th7VbigX6lpR1lb1WXwTUVKZWrK7O2YELrml4/edit
featured_quote: 少数の主要プレイヤーへのこの高い集中は、ウェブプライバシーのベースラインを効果的に設定しており、大多数のユーザーデータが少数の支配的なプラットフォームを通じて流れる構造になっています。
featured_stat_1: 75%
featured_stat_label_1: 少なくとも1つのトラッカーを持つウェブサイト
featured_stat_2: 0.9%
featured_stat_label_2: Global Privacy Platformの採用率
featured_stat_3: 5.1%
featured_stat_label_3: Client Hintsの採用率
doi: 10.5281/zenodo.18258635
---

## はじめに

ウェブはデジタルサービスの主要なインターフェースであり、数十億のユーザーが日々これらのシステムと交流することで、膨大なデータの発生源となっています。その結果、訪問者に関するデータを収集する行為であるウェブサイトトラッキングは、現代のウェブエコシステムの基本的な構成要素となっています。このデータ収集の目的は多岐にわたり、アプリケーションのパフォーマンスや機能の改善から、ターゲット広告やマーケティング分析の実現まで様々です。

しかし、このデータ収集の規模は深刻なプライバシー上の懸念を引き起こしており、<a hreflang="en" href="https://www.w3.org/TR/tracking-compliance/">技術的</a>・<a hreflang="en" href="https://eur-lex.europa.eu/eli/reg/2016/679/oj/eng">政策的</a>な議論の場でも広く取り上げられ、<a hreflang="en" href="https://pulse-of-cybersecurity.com/topics?sortBy=total-papers&sortOrder=desc&page=1&pageSize=21&search=web&topic=Web+Tracking+and+Browser+Fingerprinting&conferences=%5B%5D">研究</a>の主要なテーマにもなっています。開発者がHTTP Cookieやブラウザフィンガープリンティングなどの様々な技術を用いてユーザーを追跡する一方で、ブラウザベースの制限、法規制対応ツール、プライバシー強化拡張機能といったプライバシー保護措置も拡大しています。

本チャプターでは、ウェブプライバシーの現状について技術的な概要を提供します。一般的なトラッキング手法の採用状況を分析し、トラッキングを防ぐための措置の普及状況を調査することで、現在のユーザーデータ収集の全体像をデータに基づいて考察します。

## オンライントラッキング

{{ figure_markup(
  image="distribution-of-trackers-per-page.png",
  caption="ページあたりのトラッカー分布",
  description="デスクトップとモバイルのページあたりのトラッカー分布を示す棒グラフ。デスクトップページの75%、モバイルページの74%に少なくとも1つのトラッカーが存在します。チャートは様々なトラッカー数を持つページの割合を示しており、10個以上のトラッカーまで長い裾野が伸びています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=2085934780&format=interactive",
  sheets_gid="2064348596",
  sql_file="tracker_distribution.sql"
  )
}}

本分析では、<a hreflang="en" href="https://www.ghostery.com/whotracksme/">WhoTracks.Me</a>の人気サードパーティトラッカーカタログを使用して、ウェブページに存在するトラッカーを特定しています。分析を保守的に行うため、WhoTracksMeのカテゴリのうち `advertising`、`pornvertising`、`site_analytics`、`social_media` のみをトラッカーとしてカウントしています。この手法により、各ウェブページについてドメインレベルで個別のサードパーティトラッカーを特定できます。なお、報告される数値はHTTPリクエストの総数ではなく、ユニークなドメイン数を表している点に注意が必要です。

{{ figure_markup(
  caption="少なくとも1つのトラッカーを持つウェブサイト。",
  content="75%",
  classes="big-number",
  sheets_gid="2064348596",
  sql_file="tracker_distribution.sql"
)
}}

全ウェブページの75%（デスクトップ75%、モバイル74%）に少なくとも1つのサードパーティトラッカーが存在することが確認されました。デスクトップページの55%は2つのトラッカーを含み、39%は3つのトラッカーを含んでいます。6つ以下のトラッカーの設定はデスクトップページでより多く見られる一方、7つ以上のトラッカーはモバイルページでより多く確認されています。

### ステートフルトラッキング

トラッキングの仕組みはステートフルとステートレスに分類されます。Cookieやローカルストレージなどのステートフルなアプローチは、識別情報をユーザーのデバイスに保存します。一方、フィンガープリンティングのようなステートレスなアプローチは、実行時に固有の特性からこの情報を推測します。

#### サードパーティトラッキングサービス

{{ figure_markup(
  image="most-common-whotracksme-categories.png",
  caption="最も一般的なWhoTracksMemカテゴリ",
  description="WhoTracksMeによる異なるトラッカーカテゴリを使用しているウェブサイトの割合を示す棒グラフ。CDNが最も一般的なトラッカーカテゴリ（74%）で、広告（59%）、必須トラッカー（55%）、サイト解析（52%）と続きます。音声/動画プレイヤー（12%）やソーシャルメディア（9%）などの他のカテゴリは採用率が低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1654856624&format=interactive",
  sheets_gid="657953413",
  sql_file="whotracksme_categories_top.sql"
  )
}}

ここでは、WhoTracksMeのすべてのカテゴリを考察します。大半のウェブページが、コンテンツデリバリネットワーク（CDN）および広告に分類されるドメインに接続していることが確認されました。CDN関連ドメインはウェブページの74%に存在し、続いて広告関連ドメインが59%に見られます。また、ウェブページの55%には必須ドメイン（Google Tag Managerなど）が含まれ、52%には解析ドメイン（Google Analyticsなど）が含まれています。少数の主要プレイヤーへのこの高い集中は、ウェブプライバシーのベースラインを効果的に設定しており、大多数のユーザーデータが少数の支配的なプラットフォームを通じて流れる構造になっています。

{{ figure_markup(
  image="most-common-whotracksme-trackers.png",
  caption="最も一般的なWhoTracksMeトラッカー",
  description="WhoTracksMeによって特定された上位の個別トラッカーを一覧表示した棒グラフ。Googleのサービスがリストを占め、Google APIがサイトの61%に、Google Fontsが51%に、Google Analyticsが44%に表示されています。DoubleClick（32%）とFacebook（22%）も最も注目すべきトラッキングサービスの一つです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1917807724&format=interactive",
  sheets_gid="582617590",
  sql_file="whotracksme_trackers_top.sql"
  )
}}

個別トラッカーの分析では、GoogleとFacebookがトラッキングサービスの大半を占めていることが明らかになりました。これらはウェブ上で最も存在感のあるトラッカーであり、Googleはウェブページの61%に、Facebookは少なくとも22%のウェブページに存在しています。次いでBing（6%）、Adobe（4%）が続きます。

{{ figure_markup(
  image="most-common-tracking-categories.png",
  caption="最も一般的なトラッキングカテゴリ",
  description="トラッキングカテゴリの頻度を示す棒グラフ。解析が最も一般的なカテゴリで、ウェブサイトの64%に大きく差をつけて登場しています。広告（15%）とCookie同意（14%）が次に多く、セグメンテーションやリターゲティングなどの専門的なトラッキングはサイトの2%以下に留まっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=785780417&format=interactive",
  sheets_gid="1330549895",
  sql_file="tracker_categories_top.sql"
  )
}}

さらに、これらのサービスを機能別に分類すると、解析がデスクトップウェブページの64%に登場して全体をリードしています。広告（15%）とCookie同意ツール（14%）がこれに続き、パフォーマンス監視がデータ収集の主な目的であり続けていることを示しています。セグメンテーションやリターゲティングなどのより専門的なトラッキング手法は、それぞれサイトの3%未満と格段に少ない状況です。

{{ figure_markup(
  image="most-common-tracking-technologies.png",
  caption="最も一般的なトラッキング技術",
  description="上位のトラッキング技術を示す棒グラフ。Google Analyticsが53%の採用率でリードし、Facebook Pixelが15%で続いています。Google AdSense（6%）やMicrosoft Advertising（4%）などの他の技術はより小さいシェアを維持しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1822948153&format=interactive",
  sheets_gid="1071044283",
  sql_file="tracker_technologies_top.sql"
  )
}}

トラッキングは、ウェブページ上のユーザー行動の把握から複雑な広告プロファイルの構築まで、様々な文脈で行われます。ウェブユーザーのトラッキングに最も多く使われている技術は、Google Analytics（53%）とFacebook Pixel（16%）であることが分かりました。これらの市場リーダーを超えると採用率は急激に低下し、GoogleのSite Kit（6.41%）とAdSense（6.18%）が次のティアを形成しています。Microsoftなどの他のプレイヤーも、AdvertisingとClarityがそれぞれウェブサイトの約4%に存在するなど、一定ながらも小さいシェアを維持しています。

#### サードパーティCookie

サードパーティCookieの利用は、ウェブユーザーのトラッキングとターゲティングに効率的な手法です。サードパーティはユーザートラッキングにCookieを活用しており、継続的な批判にもかかわらず、ウェブ上で一般的な手法であり続けています。Googleのような一部のベンダーは[サードパーティCookieの廃止](https://support.google.com/google-ads/answer/14762010)を発表し（その後[撤回](https://privacysandbox.google.com/blog/privacy-sandbox-update)しましたが）、依然としてトラッキングの重要な手法であり、トラッキング目的で使われるサードパーティCookieの大部分を占めています。

{{ figure_markup(
  image="most-common-third-party-cookie-domains.png",
  caption="最も一般的なサードパーティCookieドメイン",
  description="サードパーティCookieを設定している上位ドメインを示す棒グラフ。DoubleClick.netが20%で最も一般的で、続いてYouTube（9%）、Google（8%）が続きます。Bing、Clarity、LinkedInも重要なサードパーティCookieの発生源です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1297044362&format=interactive",
  sheets_gid="669742262",
  sql_file="cookie_domains_third_party_top.sql"
  )
}}

分析の結果、`doubleclick.net` がデスクトップサイトの20%に登場する最も一般的なサードパーティCookieドメインであり、続いて `youtube.com`（9%）と `google.com`（8%）が続くことが分かりました。全体として、Googleのエンティティが上位を占める中、Microsoftの `bing.com` と `clarity.ms`、そして `linkedin.com` が最も重要な代替サードパーティCookie設定元となっています。

{{ figure_markup(
  image="most-common-third-party-cookies.png",
  caption="最も一般的なサードパーティCookie",
  description="ドメインと名前別の最も一般的なサードパーティCookieを示す棒グラフ。IDE（11%）やtest_cookie（11%）などのDoubleClick Cookieが最も多く見られます。YouTube、Google、BingのCookieも上位にランクインしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=885109540&format=interactive",
  sheets_gid="2119622651",
  sql_file="cookies_third_party_top.sql"
  )
}}

#### ファーストパーティCookie

次の図は最も一般的なファーストパーティCookieを示しています。これらのCookieはファーストパーティのコンテキストで設定されていますが、その名前からトラッキング目的で主に使用されていることが分かります。`_ga` CookieはGoogle Analyticsによってウェブページの46%に設定され、`_gid` は18%に登場しており、続いて `gcl_au` がウェブページの16%に見られます。これらのCookieの正確な目的は検証していませんが、GoogleはそれらのCookieの[意図された機能を公開](https://business.safety.google/adscookies/)しています。
もう一つの人気ファーストパーティCookieは `_fbp` で、Metaによってウェブページの14%で使用されています。MetaはMetaピクセルとともにファーストパーティCookieを使用するオプションを広告主に<a hreflang="en" href="https://www.facebook.com/business/help/471978536642445?id=1205376682832142">提供</a>しています。サードパーティのコンテキストで観察された結果と同様に、ファーストパーティCookieのコンテキストでもGoogleとMetaがトラッキングの主要エンティティであり続けています。

ウェブ上でのCookieの使用は依然として主にトラッキング目的です。機能的な例外として、`PHPSESSID` はPHPアプリケーション用のユニークなセッションIDをページの12%に保存し、`XSRF-TOKEN` はクロスサイトリクエストフォージェリ対策のセキュリティを担いウェブページの6%に見られます。

{{ figure_markup(
  image="most-common-first-party-cookie-names.png",
  caption="最も一般的なファーストパーティCookie名",
  description="最も一般的なファーストパーティCookie名の棒グラフ。_ga（46%）や_gid（18%）などのGoogle Analytics Cookieが最も一般的です。その他の重要なCookieにはMetaの_fbp（14%）や機能的な`PHPSESSID`（12%）があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=899945810&format=interactive",
  sheets_gid="749744705",
  sql_file="cookies_first_party_top.sql"
  )
}}

[Cookie](./cookies)チャプターでは、Cookieの詳細と使用傾向についてさらに詳しく説明しています。

### ステートレストラッキング

ステートレストラッキングは、ユーザー識別子をブラウザに状態として保存するのではなく、その場で生成するプロセスです。これらの識別子は通常、対象ユーザーのデバイスやブラウザから能動的または受動的に収集できる情報を使用して作成されます。複数のデバイスを使用するユーザーのセッションを相関させることは難しいものの、一部のシグナルはデバイスやウェブサイトの機能に固有のものであり、簡単に「ブロック」できないという点で効果的です。

#### ブラウザフィンガープリンティング

ブラウザフィンガープリンティングは、ウェブサイトがユーザーのブラウザ固有の情報に基づいてユーザーを特定する手法です。この情報には、システムフォント、言語設定、ハードウェア構成など、一見無害に見えるデータポイントが<a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3543507.3583333">含まれます</a>。これらは個別には少ない情報しか明かしませんが、組み合わせることで特定のユーザーの<a hreflang="en" href="https://amiunique.org/">固有のプロファイル</a>を描くことができます。これらは一般的にHTTPヘッダーやJavaScript APIコールを通じて漏洩します。

<a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3696410.3714548">先行研究</a>により、ブラウザフィンガープリンティングはオンライントラッキングにおいて非常に広く使われていることが明らかになっています。その魅力は、ブロックが難しく、ユーザーがシークレットブラウザを使用していても効果的であると言われている点にあります。本レポートでは、ブラウザフィンガープリンティングに使用される最も一般的な技術を特定します。

{{ figure_markup(
  image="top-fingerprinting-technologies.png",
  caption="上位のフィンガープリンティング技術",
  description="ブラウザフィンガープリンティングライブラリの採用状況を示す棒グラフ。FingerprintJSが最も一般的で0.59%を占め、ClientJSやMaxMindなどの他のライブラリは採用率が非常に低い（0.05%未満）状況です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1773674944&format=interactive",
  sheets_gid="1545664117",
  sql_file="fingerprinting_top.sql"
  )
}}

特筆すべきことに、<a hreflang="en" href="https://github.com/fingerprintjs/fingerprintjs">FingerprintJS</a>ライブラリはブラウザフィンガープリンティングを実施する最も人気のあるツールであり続けており、他のライブラリを大きく引き離しています。FingerprintJSはモバイルアクセスのウェブサイトの0.59%で使用されており、0.04%に留まる<a hreflang="en" href="https://github.com/jackspirou/clientjs">ClientJS</a>（次に人気の高い技術）を大幅に上回っています。

FingerprintJSの人気は、ClientJSよりも活発に見えるその活発なオープンソースコミュニティに起因していると考えられます。

## トラッキング保護の回避

ブラウザやプライバシーツールがサードパーティトラッカーのブロックにおいてより効果的になるにつれて、トラッキング業界も適応してきました。CNAMEクローキングやバウンストラッキングなどの技術により、トラッカーはファーストパーティリソースを装ったり、中間リダイレクトを使用して従来のブロック手法を回避したりすることができます。これらのアプローチはブラウザがファーストパーティリクエストに置く信頼を悪用するため、検出とブロックがより難しくなります。このセクションでは、クロールデータのリダイレクトチェーンを通じて観察できるバウンストラッキングに焦点を当てます。

### バウンストラッキング

バウンストラッキングは、ユーザーが目的地に到達する前に一時的に中間ドメインを経由してリダイレクトされる手法です。このリダイレクト中（ユーザーには気づかれないことが多い）、中間サイトはCookieを設定または読み取ることができ、ファーストパーティとのやり取りのように見えながらもサイトをまたいでユーザーを効果的に追跡できます。これにより、従来のサードパーティCookieブロックを迂回することができます。

{{ figure_markup(
  image="top-bounce-domains.png",
  caption="上位のバウンスドメイン",
  description="バウンストラッキングに関与するドメインを示す棒グラフ。`indapass.hu` や `medium.com` などの上位ドメインでさえ、0.001%未満のドメインでしか観察されておらず、低い普及率または効果的なブラウザ対策を反映しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=535689421&format=interactive",
  sheets_gid="89646096",
  sql_file="bounce_domains_top.sql"
  )
}}

2025年のデータセットでは `medium.com` が0.0003%で引き続き最も一般的なバウンスドメインであり、`note.com` と `indapass.hu` がこれに続きます。前年比で普及率は大幅に低下しており、例えば `medium.com` は0.009%から0.0003%に、`indapass.hu` は0.012%から0.0004%に減少しました。この低下はChromeのバウンストラッキング対策が効果を発揮していることを反映していると考えられます。上位ドメイン（`queue-it.net`、`payhip.com`、`medium.com`）は正当な機能的サービスであるため、データは観察された動作の大半が秘密のトラッキングではなく、必要なリダイレクトによるものであることを示唆しています。

## プライバシーを改善するブラウザポリシー

ブラウザは、ウェブサイトがサードパーティと共有する情報量に影響を与えるさまざまな仕組みを導入してきました。これらの機能はプロトコルレベルで動作し、ヘッダーを制御し、データの露出を制限し、サイトが外部リソースと通信する方法を標準化します。実際のプライバシーへの影響は、実装、採用状況、そしてサイトがこれらを使用するかどうかによって異なります。

このセクションでは、3つのメカニズムを検討します。従来のUser-Agent文字列に対してより制御された代替手段を提供するUser-Agent Client Hints、サードパーティに渡されるナビゲーションのコンテキスト情報量をサイトが制限できるReferrer Policy、そして広範な展開前にブラウザが新機能を試験するプライバシー関連のOrigin Trialsです。

### User-Agent Client Hints

{{ figure_markup(
  image="client-hints-usage.png",
  caption="Client Hintsの使用状況",
  description="デスクトップとモバイルのUser-Agent Client Hints使用状況を比較した棒グラフ。モバイル（5.1%）の方がデスクトップ（3.3%）よりも採用率が高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1040809316&format=interactive",
  sheets_gid="1264661022",
  sql_file="client_hints_usage.sql"
  )
}}

User-Agent Client Hintsは、従来のUser-Agent文字列に対してプライバシーを重視した代替手段を提供し、ブラウザがサーバーから明示的に要求された場合のみデバイスとブラウザの情報を共有できるようにします。デフォルトで詳細なフィンガープリントを公開するのではなく、サイトは特定のヒントにオプトインする必要があるため、受動的なデータ漏洩が削減されます。2025年、採用率はデスクトップで3.3%、モバイルで5.1%となっており、モバイルの方が高い理由はレスポンシブデザインシグナルへのニーズが大きいことを反映していると考えられます。この移行は恒久的なものとなっており、Chrome 145が `UserAgentReduction` ポリシーを廃止したことで、詳細なブラウザやデバイス情報が必要なサイトは[User-Agent Client Hintsへの移行](https://web.dev/articles/migrate-to-ua-ch)が必要です。

昨年のデータは、サイトの人気度とClient Hintsの使用間に強い相関関係を示していました。上位1,000サイトは15.85%に達する一方、10万位層では約1.6%まで急落しました。今年の方法論ではランク別の内訳がありませんが、全体的な数値から採用は依然として大規模なサイトに集中しており、ロングテールはまだこの標準を採用していないことが示唆されます。

{{ figure_markup(
  image="top-client-hints.png",
  caption="上位のClient Hints",
  description="最も頻繁にリクエストされるClient Hintsの棒グラフ。プラットフォームバージョン（4.3%）とデバイスモデル（4.2%）が最も一般的なヒントで、続いてアーキテクチャ、ビット数、フルバージョン情報（それぞれ約2.7%）が続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=191725698&format=interactive",
  sheets_gid="873514757",
  sql_file="client_hints_top.sql"
  )
}}

最もリクエストの多いClient Hintsは sec-ch-ua-platform-version で4.28%を占め、互換性判断のためのOS版バージョン検出に使用されます。sec-ch-ua-modelが4.25%で僅差で続きますが、注目すべき偏りがあります。モバイルの使用がデスクトップを大幅に上回っており、デバイスモデルが主にモバイル体験とデバッグに関連していることを考えると理にかなっています。アーキテクチャ、ビット数、フルバージョンリスト、フォームファクターを網羅する残りのヒントは2.60%〜2.67%の間に密集しており、Client Hintsをリクエストするサイトは個々のシグナルを選択するのではなく、複数をまとめてリクエストする傾向があることを示唆しています。

### Referrer Policy

{{ figure_markup(
  image="referrer-policy-usage.png",
  caption="Referrer Policyの使用状況",
  description="Referrer Policyの実装方法を示す棒グラフ。サイトの38%が何らかのポリシーを使用しており、リンクレベルの設定が最も一般的な方法（25%）で、ヘッダーによるドキュメント全体のポリシー（10%）が続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1204421352&format=interactive",
  sheets_gid="809060556",
  sql_file="referrer_policy_usage.sql"
  )
}}

あるウェブサイトから別のウェブサイトのリンクをクリックすると、ブラウザはページのフルURLを含む参照元情報を公開する可能性があります。Referrer Policyは、ウェブサイトのオーナーがこの情報の共有量を制御できる仕組みで、サードパーティがユーザーの閲覧経路について参照できる情報を制限することでプライバシー保護に役立ちます。

Referrer Policyの全体的な採用率は2024年の32%から2025年の37.66%に上昇しており、健全な増加といえます。最も一般的な実装方法は、個別リンクへの `rel="noreferrer"` などのリンクレベルの制御で24.70%を占め、ヘッダーで設定するドキュメント全体のポリシーは10.16%となっています。これは、多くのサイトが一律のルールとしてではなく、選択的にリファラー制限を適用していることを示しています。

メタタグによる実装は2.47%で依然として最も少なく、2024年の2%からほぼ変わらない状況です。これは予想通りの結果で、ヘッダーはページ読み込み前に適用され改ざんが難しいため、セキュリティポリシーには一般的にヘッダーが好まれます。

{{ figure_markup(
  image="most-common-referrer-policies.png",
  caption="最も一般的なReferrer Policy",
  description="最も一般的なReferrer Policyの値を示す棒グラフ。最も多いのはstrict-origin-when-cross-origin（5.7%）とno-referrer-when-downgrade（3.8%）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1432498120&format=interactive",
  sheets_gid="1695930298",
  sql_file="referrer_policy_top.sql"
  )
}}

今年は最もプライバシーを重視するポリシーで低下が見られました。他のサイトへ移動する際にオリジンは共有するがフルパスを削除する strict-origin-when-cross-origin は7.5%から5.69%に低下しました。同様に、no-referrer-when-downgrade は7.0%から3.81%に落ちました。これらは依然として上位2つのポリシーですが、低下はサイトの一部が設定を緩和したか、実装方法を変更したことを示唆しています。

ポジティブな面としては、same-origin（1.26%）やno-referrer（0.75%）などの真に制限的なオプションは引き続き使用されていますが、採用率は低い状況です。これらのポリシーはサードパーティのサイトと情報を一切共有しないため、プライバシーには理想的ですが、サイトが依存する解析やアフィリエイトトラッキングには制限的な場合があります。

一部のサイトは依然として unsafe-url（0.50%）を指定しており、これはあらゆる接続先にフルURLを公開しますが、この動作はChromeに固有で他のブラウザでは廃止されています。also（0.54%）という無効な値も見られ、ブラウザはこれを無視してデフォルトの strict-origin-when-cross-origin にフォールバックします。これらの値が存在することは、サイトの一部がプライバシーに不親切な設定を意図的に選択しているのではなく、Referrer Policyの設定が誤っているか古くなっていることを示唆しています。

### プライバシー関連のOrigin Trials

{{ figure_markup(
  image="most-common-privacy-related-origin-trials.png",
  caption="最も一般的なプライバシー関連のOrigin Trials",
  description="プライバシー関連のChrome Origin Trialsの棒グラフ。サードパーティストレージのパーティショニングを無効にするトライアルが最も多く（12.3%）、続いてFledge/Protected Audience APIトライアル（6.9%）が続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1865806391&format=interactive",
  sheets_gid="2077422127",
  sql_file="related_origin_trials_top.sql"
  )
}}

Origin Trialsにより、ブラウザは完全な展開にコミットする前に実際のウェブサイトで実験的な機能をテストできます。サイトは早期に新機能にアクセスするためにオプトインするか、既存の機能を壊す変更を一時的に遅らせるための廃止トライアルにオプトインすることができます。これらのトライアルはブラウザベンダーが本番環境での機能パフォーマンスに関するデータを収集しながら、開発者が適応する時間を与えるために役立ちます。これから分かるように、プライバシー関連の採用のほとんどは廃止カテゴリに該当しています。

最も広く採用されているトライアルは依然として `DisableThirdPartyStoragePartitioning` で、2024年の10.21%から2025年の12.33%に増加しました（現在3回目のイテレーション）。このトライアルにより、サイトはCookieとストレージをサイトごとに分離するプライバシー機能であるストレージのパーティショニングを一時的にオプトアウトし、開発者がレガシー実装を移行する時間を確保できます。同様に、サイト横断トラッキングなしで興味関心ベースの広告を行うGoogleのPrivacy Sandboxイニシアチブの一部である `FledgeBiddingAndAuctionServer` は、6.62%から6.93%に緩やかに増加しました。

最大の変化は `AttributionReportingCrossAppWeb` で、2.10%から0.04%へと急落しました。これはトライアルが終了したか、サイトがクロスアプリのアトリビューションテストから離れたことを示唆しています。新しいエントリには `FetchLaterAPI`（0.73%）、遅延リクエスト、フェデレーテッドアイデンティティが含まれます。一方、物議を醸したFLoCの前身である `InterestCohortAPI` は0.20%と大きく変わらず、主に残留物として留まっています。

## 法律と政策

プライバシー規制は、ウェブサイトとユーザーとのやり取りのあり方を形作り続けています。このセクションでは、サイトが同意ダイアログを通じてどのように対応しているか、また Do Not Track や Global Privacy Control などのプライバシーシグナルが有意義な採用を獲得しているかどうかを検討します。

### 同意ダイアログ

<a hreflang="en" href="https://gdpr-info.eu/">GDPR</a>や<a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">CCPA</a>などのプライバシー規制は、個人データを収集・処理する前にユーザーの同意を得ることをウェブサイトに義務付けています。これにより、Consent Management Platform（CMP）によって管理されることが多いCookieの同意ダイアログが、現代のウェブのほぼ普遍的な機能となっています。広告エコシステム全体で同意の収集と伝達を標準化するために、Interactive Advertising Bureau（IAB）はTransparency and Consent Framework（TCF）、US Privacy String（USP）、より新しいGlobal Privacy Platform（GPP）などのフレームワークを開発しました。

これらのフレームワークはユーザーに制御権を与えることを目的としていますが、採用率と実装品質は大きく異なります。一部のサイトはTCFv2に完全に準拠している一方、実装が不完全なサイトや古い標準に依存しているサイトもあります。また、クローラーが米国を拠点としており、TCFの下では非EU訪問者にはCookieバナーの表示が不要なため、実際のTCF使用量はここで計測している値よりも高い可能性があることも注目に値します。

{{ figure_markup(
  image="iab-frameworks-usage.png",
  caption="IABフレームワークの使用状況",
  description="IABプライバシーフレームワークの採用状況を示す棒グラフ。サイトの約6%がいずれかのフレームワークを使用しています。TCFv2（3.8%）とUSP（3.3%）が最も一般的ですが、完全にTCFv2に準拠しているサイトは1.7%に過ぎません。より新しいGPPフレームワークはサイトの0.9%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1097791964&format=interactive",
  sheets_gid="214257120",
  sql_file="iab_usage.sql"
  )
}}

IABフレームワークの全体的な採用率は、モバイルとデスクトップの両方で5.5%をわずかに超える水準で安定しています。TCFは4.0%で引き続き最も広く採用されているフレームワークで、TCFv2がその3.8%を占めています。しかし、完全にTCFv2に準拠しているサイトは1.7%に過ぎず、TCFv2を使用していると主張するサイトの半数未満であり、多くの実装が不完全または不適切に設定されていることを示唆しています。USPは3.3%で安定しており、CCPA対応への継続的な取り組みを反映しています。

廃止されたTCFv1はほぼ消滅しており、0.2%に留まり準拠しているのはわずか0.1%と、業界がv2に移行した可能性を示しています。今年の注目すべき追加はGPPで、IABの新しい統合フレームワークがサイトの0.9%に登場しています。好ましいことに、gpp_data_availableが0.9%と一致しており、GPPを採用したサイトがコードを読み込むだけでなく、実際にユーザーの設定を伝達するために使用していることを意味しています。

前年比で見ると、全体的なフレームワーク採用率は横ばいだった一方、TCFの使用率は4.2%から4.0%にわずかに低下しました。この緩やかな低下はGPPへの早期移行を反映している可能性がありますが、トレンドと呼ぶには早すぎます。コンプライアンスのギャップは続いており、TCFv2のコンプライアンスは1.7%で変わらず、採用だけでは適切な実装を保証しないことを浮き彫りにしています。

{{ figure_markup(
  image="most-common-cmps-with-iab-tcf-v2.png",
  caption="IAB TCF v2で最も一般的なCMP",
  description="TCFv2で使用されている上位のConsent Management Platform（CMP）を示す棒グラフ。Didomiが0.50%でトップ、続いてAutomattic（0.30%）とCookie-script（0.27%）が続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=608609863&format=interactive",
  sheets_gid="567555460",
  sql_file="iab_tcf_v2_cmps_top.sql"
  )
}}

今年はCMPの状況が大きく変化しました。2024年に0.67%でリードしていたAutomatticは2025年に0.30%に低下した一方、Didomiは0.22%から0.50%に上昇してトップの座を獲得しました。Cookie-scriptが0.27%で新規参入し、デスクトップで2位にランクインしました。残りのプロバイダー（InMobi、Iubenda、Sirdata、AppConsent、OneTrust、Sourcepoint、Ezoic）はそれぞれサイトの0.12%未満で、TCFv2のCMP採用が少数の主要プレイヤーに集中していることが分かります。

{{ figure_markup(
  image="iab-tcf-v2-top-publisher-countries.png",
  caption="IAB TCF v2、上位パブリッシャー国",
  description="パブリッシャー国別のTCFv2採用状況を示す棒グラフ。特定された国の中では、ドイツ（0.042%）がトップで、続いてフランス（0.030%）、米国（0.017%）が続きます。かなりの割合（0.26%）が不明な国コードに分類されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1344719218&format=interactive",
  sheets_gid="88543288",
  sql_file="iab_tcf_v2_countries_top.sql"
  )
}}

EUの加盟国の中ではドイツ（0.042%）とフランス（0.030%）がTCFv2パブリッシャーの採用をリードしており、EUの域外ではTCFが義務でないにもかかわらず米国が0.017%で登場しています。最も大きな割合（0.26%）は未定義の国コード「AA」に分類されており、パブリッシャーのメタデータのギャップやCMPの実装の誤りを示しています。GDPRの要件にもかかわらず、欧州のパブリッシャーの間でさえ全体的な採用率は低く、TCFv2が一部の少数のサイトに集中していることを示唆しています。

{{ figure_markup(
  image="most-common-iab-usp-string-values.png",
  caption="最も一般的なIAB USP文字列の値",
  description="最も一般的なIAB USP文字列の値を示す棒グラフ。通知あり・オプトアウトなしを示すシグナル1YNYが1.3%で最も多く、続いてさまざまなプレースホルダーやデフォルトの文字列が続きます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=1738259892&format=interactive",
  sheets_gid="1361217219",
  sql_file="iab_usp_strings_top.sql"
  )
}}

最も一般的なUSP文字列は1.296%の1YNYで、通知が行われ、ユーザーがオプトアウトしておらず、サイトがLimited Service Provider Agreementの対象であることを示します。2番目に多い値は1.073%の1---で、意味のあるシグナルを提供しないプレースホルダー文字列であり、多くの実装が不完全またはデフォルト設定であることを示唆しています。`1YYN` を表示するサイトは、新規訪問者をデフォルトでオプトアウト状態にするようCMPを設定しており、これは要件よりも厳格なプライバシーの姿勢です。低い普及率（0.078%）は、ほとんどのサイトが同意を明示的に撤回するまでの間は同意しているとみなすCCPAの標準的なオプトアウトモデルに従っていることを示しています。

### Do Not Track

{{ figure_markup(
  image="donottrack-usage.png",
  caption="Do Not Trackの使用状況",
  description="サイトの人気度別のDo Not Track（DNT）シグナル検出を示す棒グラフ。検出率は上位5,000サイトで44%でピークに達し、サイトの人気度が低下するにつれて徐々に減少し、上位5,000万サイトでは17%に達しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5/pubchart?oid=356049506&format=interactive",
  sheets_gid="1362349490",
  sql_file="dnt_usage.sql"
  )
}}

標準としてほぼ廃止され、<a hreflang="en" href="https://www.loeb.com/en/insights/publications/2013/10/california-enacts-law-requiring-do-not-track-dis__">法的根拠</a>がほとんどなく広告主のほとんどが無視しているにもかかわらず、Do Not Trackシグナルはウェブ全体に残り続けています。興味深いことに、採用率はサイトの人気度と強い相関があります。上位10,000サイトの中でDNT検出は約43%でピークに達し、たとえ実際の影響が疑わしいとしても、ロングテールのサイトはレガシーなプライバシーシグナルを維持する傾向があります。

モバイルの採用率はすべてのランク層でデスクトップをわずかに上回っていますが、差は僅かです。最も急激な低下は上位100,000サイト（35%）と500,000サイト（27%）の層の間で起きており、中規模以下のサイトはDNTをチェックする可能性がはるかに低いことを示しています。これらのサイトが単に検出するだけでなく実際にシグナルを尊重しているかどうかは、DNTへの準拠が一度も強制されてこなかったため、未解決の問題として残っています。

### Global Privacy Control

Global Privacy Control（GPC）は、データの販売または共有のオプトアウトのユーザー設定を伝えるブラウザシグナルです。Do Not Trackとは異なり、GPCはCCPA/CPRAの下で法的根拠を持ちます。ウェブサイトはそれを有効なオプトアウトリクエストとして扱わなければなりません。Firefox、Brave、SafariはすでにGPCをサポートしており、2027年までにブラウザがこの設定を提供することを義務付けるカリフォルニア州の法律を受けて、Chromeも<a hreflang="en" href="https://chromestatus.com/feature/5137324344213504">2026年に実装する予定</a>です。ただし、DNTと同様に、GPCは技術的な水準でウェブサイトが自発的にシグナルを尊重することに依存しています。ブラウザはヘッダー（Sec-GPC: 1）を送信しますが、コンプライアンスを強制することはできません。違いは、GPCを無視すると法的リスクが伴うという点で、これはDNTの純粋に自発的なアプローチよりも効果的であることが証明されるかもしれません。

## 結論

オンライントラッキングは今日のインターネットにおける標準となっています。実際に、訪問したウェブサイトの75%（デスクトップ）または74%（モバイル）に少なくとも1つのトラッカーが含まれていることが確認されました。

Googleはトラッキングの分野で引き続き支配的な地位を占めており、Facebookがこれに続いています。一見すると、オンライントラッキングはよりターゲットを絞った広告を配信するために活用できる大企業にとって収益性の高い手段です。しかし、少数の集中したプレイヤー間でのトラッキング情報の統合は、よりプライバシーを意識するユーザーにとって懸念事項となっています。

トラッキングを回避する取り組みは絶えず展開され、また回避され続けています。例えば、`medium.com` がバウンスシーケンスで観察されましたが、これは秘密のトラッキングではなく機能的な目的のためと考えられます。一方で、実際のUser-Agent文字列の代わりにUser-Agent Client Hintsを共有するなど、より安全なブラウザポリシーについても考察しました。

オンライントラッキングを管理する法律と規制は、それに準拠するために展開されるメカニズムとともに進化し続けています。TCFの最新バージョン（v2）の不完全な実装と低い採用率が見られますが、IABによる新しい追加であるGlobal Privacy Platformの採用増加も伴っています。さらに、Consent Management Platformの状況にも変化が見られます。
