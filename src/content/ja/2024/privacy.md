---
title: プライバシー
description: 2024年のWeb Almanacのプライバシーの章では、オンライントラッキングの採用と影響、プライバシー設定シグナル、プライバシーに配慮したWebに向けたブラウザの取り組みについて解説します。
hero_alt: Web Almanacのキャラクターたちがカメラや電話、マイクを持ってパパラッチのように振る舞い、別のキャラクターがシャワーカーテンを開けて背後にあるウェブページを見せているヒーロー画像。
authors: [Yash-Vekaria, bgstandaert, max-ostapenko, haddiamjad, ydimova, shaoormunir, ChrisBeeti, umariqbal]
reviewers: [AlbertoFDR]
editors: [tunetheweb]
analysts: [max-ostapenko, Yash-Vekaria, bgstandaert, haddiamjad]
translators: [ksakae1216]
Yash-Vekaria_bio: Yash Vekariaは、<a hreflang="en" href="https://www.ucdavis.edu/">カリフォルニア大学デービス校</a>のコンピューターサイエンス博士課程の学生です。彼は、Webのダイナミクスを研究し改善するために、Webベースの大規模なインターネット測定を実施しています。とくに、彼の研究はオンライントラッキングの実践とユーザーのプライバシー問題の研究と透明性の確保に焦点を当てています。
bgstandaert_bio: Benjamin Standaertは、<a hreflang="en" href="https://wustl.edu/">セントルイス・ワシントン大学</a>のコンピューターサイエンス学科の修士課程の学生です。彼は広告ブロックソフトウェアやプライバシー強化技術の開発経験があります。
max-ostapenko_bio: Max Ostapenkoは、トラッキング、プライバシー、Webの収益化に関する専門知識を持つデータおよび広告分野のプロダクトマネージャーです。HTTP Archiveの共同メンテナーとして、MaxはWebの洞察のアクセシビリティに貢献しています。
haddiamjad_bio: <a hreflang="en" href="https://hadiamjad.github.io">Hadi Amjad</a>は、<a hreflang="en" href="https://cs.vt.edu/">バージニア工科大学</a>のコンピューターサイエンスの博士課程の学生です。彼の研究は、インターネットのセキュリティ、プライバシー、プログラム分析の交差点にあります。彼は、インターネット上のプライバシーとセキュリティ侵害の原因となるコード領域を特定するためのJavaScriptプログラム分析を専門としています。彼の研究はプライバシー重視のツールを強化し、より安全でセキュアなWeb環境に貢献しています。
ydimova_bio: Yana Dimovaは、ルーヴェン・カトリック大学のDistriNetの博士課程の学生で、プライバシーに対するユーザーの視点とWeb上でそれをどのように保護できるかに焦点を当てています。彼女の研究対象は、オンライントラッキング、個人データの漏洩、プライバシーとデータ保護法です。
shaoormunir_bio: Shaoor Munirは、カリフォルニア大学デービス校のコンピューターサイエンスの博士課程の学生で、プライバシー強化技術（PET）の分析と開発、およびオンラインデータ収集を管理するポリシーを専門としています。彼の研究は、技術革新と責任あるデータガバナンスのバランスをとることで、ネチズンのプライバシー保護を推進することを目指しています。
ChrisBeeti_bio: Chris Böttgerは、<a href="https://www.en.w-hs.de/">ウェストファリアン応用科学大学</a>のコンピューターサイエンスの博士課程の候補者です。彼の研究は、Webとネットワークのセキュリティに焦点を当てており、とくにユーザーのプライバシーとトラッキング技術に重点を置いています。
umariqbal_bio: Umar Iqbalは、<a hreflang="en" href="https://wustl.edu/">セントルイス・ワシントン大学</a>のコンピューターサイエンス・エンジニアリング学科の助教です。彼の研究は、コンピューティングシステムに透明性と制御をもたらし、ユーザー、プラットフォーム、規制当局がユーザーのプライバシーとセキュリティを向上させることを可能にすることに焦点を当てています。
results: https://docs.google.com/spreadsheets/d/18r8cT6x9lPdM-rXvXjsqx84W7ZDdTDYGD59xr0UGOwg/
featured_quote: Facebookのトラッキングは、サードパーティCookieからファーストパーティCookieへと移行し、ステルス化しています。これは2024年の主要なトレンドとして、ファーストパーティトラッキングへの移行を浮き彫りにしています。
featured_stat_1: 3
featured_stat_label_1: ページあたりのもっとも一般的なトラッカー数
featured_stat_2: 63%
featured_stat_label_2: ページ全体でのProtected Audience APIの存在
featured_stat_3: 14.3%
featured_stat_label_3: FacebookのファーストパーティCookieを持つページ
doi: 10.5281/zenodo.14261510
---

## はじめに

ユーザーはウェブを閲覧する際に、重大なプライバシー問題に直面します。たとえば、ユーザーが訪問するほとんどのウェブサイトには、ユーザーの活動を監視しプロファイリングする _トラッカー_ が含まれています。プロファイリングされたユーザーの活動は、ターゲットを絞ったパーソナライズドオンライン広告やユーザーデータの直接販売など、プライバシーを侵害するさまざまな目的で利用されます。

トラッカーは、Cookie（ファーストパーティとサードパーティの両方）、ブラウザフィンガープリント、個人を特定できる情報（メールアドレスなど）の使用など、ウェブ上でユーザーを追跡するために幅広い技術を展開しています。

プライバシーを保護するため、ユーザーは広告ブロッカーやトラッカーブロッカーのようなプライバシー強化ツールに頼っています。これらのツールはウェブページへのオンライントラッカーの読み込みを阻止します。同様に、ブラウザはサードパーティCookieのブロックなど、設計によっていくつかのプライバシー問題を排除することを目的としたプライバシー保護機能を導入しています。

残念ながら、トラッカーはプライバシー強化技術との競争を繰り広げており、ブラウザのプライバシー保護を回避するメカニズムを継続的に模索しています。最近ではバウンストラッキングやCNAMEトラッキングがそれに当たります。ここ数年、政府はカリフォルニア州のCCPAやEUのGDPRといったデータ保護規制に介入し、ユーザーがデータ収集に同意しないなどの権利を行使できる仕組みを提供しています。

この章では、オンライン追跡の概要を説明します。これには、Cookieやブラウザフィンガープリントなどの追跡メカニズムが含まれます。さらに、ブラウザが提供するプライバシー保護、トラッカーが悪用する回避技術、データ保護規則の下で提供される保護の導入についても概説します。

## オンライントラッキング

{{ figure_markup(
  image="Distribution-of-trackers-per-page.png",
  caption="ページごとのトラッカーの分布。",
  description="ページごとのトラッカーの分布を示す折れ線グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=2035809959&format=interactive",
  sheets_gid="936905739"
  )
}}

私たちは主に、<a hreflang="en" href="http://WhoTracks.Me">WhoTracks.Me</a>のデータを活用しています。これは、さまざまなウェブサイトに存在するサードパーティトラッカーをカタログ化した公開リストです。このリソースを利用して、ウェブサイト上で、もっとも普及しているトラッカーを特定しました。これにより、特定のトラッキング企業の優位性を評価しサードパーティトラッキングの全体像をより深く理解できました。WhoTracks.Meはドメインレベルでいくつかのトラッカーを識別するため、注意が必要です。これらのドメインに関連付けられたURLの多くはトラッキングを行っていますが、そのドメインのすべてのURLがそうであるとは限りません。

オンライントラッキングは、インターネット上で日常的に行われています。多くのウェブサイトには、自サイト内や複数のサイトにわたってユーザーの活動を記録する、専門のオンラインサービスが含まれています。私たちの調査から、デスクトップウェブサイトの95％とモバイルウェブサイトの94％に、少なくとも1つのトラッカーが含まれていることが明らかになりました。

また、デスクトップサイトの27％、モバイルサイトの26％と、いずれも4分の1以上が10個以上のトラッカーを含んでいることも注目されます。これらのトラッカーにより、企業はオンライン行動に基づいた詳細なユーザープロファイルを作成できます。これはパーソナライズ広告やウェブサイト所有者へのインサイト提供に定期的に利用されます。以降のセクションでは、トラッカーがユーザーの活動を監視するために用いるさまざまな技術と、最新ブラウザが導入したプライバシー保護をいかにして回避しようとしているのかを探ります。

### ステートフルな追跡

オンライントラッキングは、ステートフル追跡とステートレス追跡の2つに大別されます。ステートフル追跡は、ユーザーに関する情報をユーザーのデバイスに直接保存するものです。通常はCookieを介して行われますが、セッションをまたいで持続するローカルストレージのような、他のストレージメカニズムも利用されます。

ユーザーがこのようなトラッカーの埋め込まれたウェブサイトを訪問すると、トラッカーに関連するCookieが自動的にネットワークリクエストに含まれます。これにより、複数のウェブサイトに埋め込まれたトラッキングサービスは、ユーザーが訪問したすべてのウェブサイトを監視できるのです。

#### サードパーティのトラッキングサービス

以下の図は、オンライントラッキングドメインの普及率の分布を示したものです。

{{ figure_markup(
  image="top-whotracksme-trackers.png",
  caption="WhoTracksMeのトップトラッカー。",
  description="WhoTracksMeデータセットからもっとも一般的なトラッカーを、それらが表示されるページの割合でソートして示した棒グラフ。トップトラッカーはGoogle APIs（デスクトップ69％、モバイル68％）、Google Static（デスクトップ67％、モバイル61％）、Google Tag（デスクトップ60％、モバイル57％）、Google Analytics（デスクトップ55％、モバイル52％）、Google（デスクトップ48％、モバイル47％）、DoubleClick（デスクトップ40％、モバイル38％）、Facebook（デスクトップ25％、モバイル23％）、Cloudflare（デスクトップ17％、モバイル17％）、Youtube（デスクトップ11％、モバイル11％）です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=307091186&format=interactive",
  sheets_gid="1429146110",
  sql_file="number_of_websites_with_whotracksme_trackers.sql"
  )
}}

Googleが所有するドメインがトラッキング業界を席巻しており、`googleapis.com`とGoogleの`gstatic.com`がそれぞれ68％と61％と、もっとも高い割合のページに表示されていることがわかります。その他の著名なトラッカーには、Google TagとGoogle Analyticsがあり、それぞれ50％以上のページで見られ、Googleのトラッキングサービスの広範なリーチを浮き彫りにしています。Googleとその関連サービスに加えて、FacebookとCloudflareの顕著な存在も確認できます。

##### サードパーティCookie

{{ figure_markup(
  image="top-third-party-cookie-origins.png",
  caption="サードパーティCookieのトップオリジン。",
  description="サードパーティCookieのもっとも一般的なオリジンを、それらが表示されるページの割合で示した棒グラフ。表示されている値は、`doubleclick.net` (デスクトップ27%; モバイル26%), `youtube.com` (デスクトップ7%; モバイル6%), `google.com` (デスクトップ5%; モバイル4%), `www.google.com` (デスクトップ5%; モバイル4%), `linkedin.com` (デスクトップ4%; モバイル4%), `bing.com` (デスクトップ4%; モバイル3%), `yandex.ru` (デスクトップ3%; モバイル5%), `adnxs.com` (デスクトップ3%; モバイル3%), `mc.yandex.ru` (デスクトップ3%; モバイル4%), `c.bing.com` (デスクトップ3%; モバイル3%), `yandex.com` (デスクトップ3%; モバイル4%), `mc.yandex.com` (デスクトップ3%; モバイル4%), `adsrvr.org` (デスクトップ3%; モバイル3%), `googleadservices.com` (デスクトップ3%; モバイル3%), `yahoo.com` (デスクトップ3%; モバイル3%)。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=542106842&format=interactive",
  sheets_gid="1230745383",
  sql_file="cookies_top_third_party_domains.sql"
  )
}}

サードパーティCookieは、ウェブ上でユーザーを追跡するために使用される主要なメカニズムです。私たちの測定では、Googleの`doubleclick.com`がサードパーティCookieの最大のソースであり、クロールされたウェブページの4分の1以上に存在することが明らかになりました。[2022年の分析](../2022/privacy)と比較して、サードパーティCookieのトップソースはほぼ静的なままであり、以前は2番目に大きなサードパーティCookieのソースであったFacebookが著しく欠けています。しかし、次のセクションで示すように、代わりにファーストパーティのコンテキストでFacebookによって設定された多数のCookieが見られます。

{{ figure_markup(
  image="top-third-party-cookie-names.png",
  caption="サードパーティCookieのトップネーム。",
  description="サードパーティCookieのもっとも一般的な名前を、それらが表示されるページの割合で示した棒グラフ。表示される値は、`test_cookie` (デスクトップ17%、モバイル16%)、`IDE` (デスクトップ14%、モバイル13%)、`YSC` (デスクトップ11%、モバイル9%)、`VISITOR_INFO1_LIVE` (デスクトップ11%、モバイル9%)、`__cf_bm` (デスクトップ8%、モバイル7%)、`receive-cookie-deprecation` (デスクトップ8%、モバイル6%)、`NID` (デスクトップ8%、モバイル7%)、`uid` (デスクトップ6%、モバイル8%)、i (デスクトップ6%、モバイル8%)、`ar_debug` (デスクトップ6%、モバイル6%)、`c` (デスクトップ5%、モバイル7%)、`_GRECAPTCHA` (デスクトップ5%、モバイル5%)、`bcookie` (デスクトップ4%、モバイル5%)、`lidc` (デスクトップ4%、モバイル5%)、`MUID` (デスクトップ4%、モバイル4%)。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1978360808&format=interactive",
  sheets_gid="766149659",
  sql_file="cookies_top_third_party_names.sql"
  )
}}

多くのドメインでCookieを共有するトラッカーを特定するため、サードパーティCookieのもっとも一般的な名前も調査します。<a hreflang="en" href="https://business.safety.google/adscookies/">Googleのドキュメント</a>に記載されているように、上位4つのCookie名はGoogleの広告製品とYouTubeによって設定されたCookieに対応しており、5番目によくある名前はCloudflareによって設定されたCookieに対応していることがわかります。
CloudflareのCookie `__cf_bm` は、「<a hreflang="en" href="https://developers.cloudflare.com/fundamentals/reference/policies-compliances/cloudflare-cookies/#__cf_bm-cookie-for-cloudflare-bot-products">自動化されたトラフィックを特定して軽減するために</a>」使用されます。このCookieはCloudflareの個々の顧客のドメインで設定されるため、Cookieのドメインごとのランキングには含まれません。

##### ファーストパーティCookie

{{ figure_markup(
  image="top-first-party-cookie-names.png",
  caption="ファーストパーティCookieのトップネーム。",
  description="ファーストパーティCookieのもっとも一般的な名前を、それらが表示されるページの割合で示した棒グラフ。表示値は `_ga` (デスクトップ49%; モバイル47%), `_gid` (デスクトップ29%; モバイル27%), `_fbp` (デスクトップ15%; モバイル14%), `_gcl_au` (デスクトップ14%; モバイル13%), `PHPSESSID` (デスクトップ13%; モバイル13%), `_gat` (デスクトップ10%; モバイル9%), `XSRF-TOKEN` (デスクトップ5%; モバイル5%), `__eoi` (デスクトップ5%; モバイル5%), `__gads` (デスクトップ5%; モバイル5%), `__gpi` (デスクトップ5%; モバイル5%), `sbjs_current` (デスクトップ4%; モバイル4%), `sbjs_session` (デスクトップ4%; モバイル4%), `sbjs_udata` (デスクトップ4%; モバイル4%), `sbjs_first` (デスクトップ4%; モバイル4%), `sbjs_first_add` (デスクトップ4%; モバイル4%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=132012980&format=interactive",
  sheets_gid="452718378",
  sql_file="cookies_top_first_party_names.sql"
  )
}}

一般的なファーストパーティCookieを測定すると、分析および広告サービスがファーストパーティのコンテキストでCookieを設定している広範な証拠が見られます。上位2つのCookie、`_ga`と`_gid`は、どちらもGoogle Analyticsの一部です。

次のCookie `_fbp` は、Metaによって設定されるトラッキングCookieです。2022年以降、MetaのCookieトラッキングは主にサードパーティのコンテキストからファーストパーティのコンテキストに移行したようです。Meta Pixelのデフォルト設定では、<a hreflang="en" href="https://www.facebook.com/business/help/471978536642445">ファーストパーティCookieが設定されるようになりました</a>。

残りのCookieの大部分は、Googleの<a hreflang="en" href="https://business.safety.google/adscookies/">ドキュメント</a>に記載されているように、Googleが設定したCookieと一致します。ファーストパーティCookieは、単一サイトでのアクティビティ追跡またはクロスサイト追跡のいずれかに使用できます。これらのCookieの正確な目的を特定しようとはしません。上位のCookie名のうち、`PHPSESSID`と`XSRF-TOKEN`の2つだけが、明確な非追跡目的を持っています。`PHPSESSID`は<a hreflang="en" href="https://www.php.net/manual/en/session.configuration.php#ini.session.name">PHPフレームワーク</a>がユーザーのセッションIDを保存するために使用するデフォルトのCookie名で、`XSRF-TOKEN`は<a hreflang="en" href="https://v17.angular.io/api/common/http/HttpClientXsrfModule">Angularフレームワーク</a>が使用するデフォルト名です。

[Cookies](./cookies)の章では、Cookieの詳細と使用傾向についてさらに詳しく説明しています。

### ステートレス追跡

ステートフル追跡では識別子がブラウザに保存されるのに対し、ステートレス追跡では識別子が実行時に生成されます。これらの識別子は、ユーザーのデバイスやブラウザのユニークな特性に依存することがよくあります。この方法はステートフル追跡よりも信頼性が低いかもしれませんが、通常は識別とブロックがより困難です。

#### ブラウザフィンガープリント

ブラウザフィンガープリントは、もっとも一般的なステートレス追跡技術の1つです。ブラウザフィンガープリントを実施するために、トラッカーはJavaScript API（たとえば、Canvas）やHTTPヘッダー（たとえば、`User-Agent`）を介してブラウザが公開するデバイス構成情報を利用します。

ブラウザがCookieに課す制限を拡大し続けるにつれて、フィンガープリントは魅力的な代替手段となっています。<a hreflang="en" href="https://ieeexplore.ieee.org/abstract/document/9519502">先行研究</a>では、フィンガープリントが現在一般的であり、その普及率が高まっていることがわかっています。ここでは、ウェブ全体でもっとも一般的なフィンガープリントのソースを特定しようと試みます。

私たちの分析では、まず有名なフィンガープリントライブラリの存在を調べました。テストしたライブラリの中で、ウェブ上でフィンガープリントを実行するために使用されるもっとも普及しているライブラリはFingerprintJS（<a hreflang="en" href="https://github.com/fingerprintjs/fingerprintjs">FingerprintJS</a>）であり、全ウェブサイトの0.57％で見つかりました。これは、このライブラリがオープンソースであり、無料版があるためである可能性が高いです。[2022年の測定値](../2022/privacy#回避技術フィンガープリンティング)と比較すると、これらのフィンガープリントライブラリの使用はわずかに減少していますが、今年は約400万ページものウェブページをクロールしていることに注意することが重要です。

{{ figure_markup(
  image="Fingerprinting-usage.png",
  caption="フィンガープリントの使用状況。",
  description="FingerprintJSはもっとも一般的に使用されているスクリプトで、モバイルページの0.57%に表示され、他のどのスクリプトよりも大幅に多くなっています。ClientJSは2番目に多く、0.03%のページで見つかります。MaxMindは0.02%のページに存在し、TruValidateとThreatMetrixはそれぞれ0.01%のページでしか見つかりません。一般に、フィンガープリントスクリプトはモバイルよりもデスクトップの方が一般的であるようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1011732208&format=interactive",
  sheets_gid="219682214",
  sql_file="number_of_websites_using_each_fingerprinting.sql"
  )
}}

私たちは有名なフィンガープリントベンダーの普及率を検出しましたが、フィンガープリントに関与する可能性のある他のいくつかのサービス（ファーストパーティスクリプトを含む）があります。フィンガープリントの潜在的なソースを特定するために、まず一般的に使用されているフィンガープリントライブラリであるFingerprintJSのソースコードを調べます。次に、ライブラリが使用するAPIのリストをコンパイルし、クロールされたすべてのスクリプトでこれらのAPIの出現を検索します。5つ以上の使用箇所があるスクリプトを _潜在的な_ フィンガープリントスクリプトとしてマークします。次に、読み込まれるページ数でスクリプトをランク付けします。

{{ figure_markup(
  image="top-potential-fingerprinting-scripts.png",
  caption="フィンガープリントAPIの使用箇所があるトップスクリプト。",
  description="フィンガープリントによく使われるAPIを使ったスクリプトを、表示されるページの割合順に並べた棒グラフ。各スクリプトはファイル名の後に、関連する会社名や製品名が続きます。表示値は `recaptcha__en.js` (Google Recaptcha) (デスクトップ10%; モバイル10%), `aframe` (Google Recaptcha) (デスクトップ6%; モバイル6%), `common.js` (Google Maps API) (デスクトップ5%; モバイル5%), `www-embed-player.js` (Youtube) (デスクトップ4%; モバイル4%), `base.js` (Youtube) (デスクトップ4%; モバイル4%), `adsbygoogle.js` (Google) (デスクトップ3%; モバイル3%), `wix-perf-measure.umd.min.js` (Wix) (デスクトップ3%; モバイル3%), `modules.db8890ba82a7e392473f.js` (Hotjar) (デスクトップ2%; モバイル2%), `group_5.2de88a07.chunk.min.js` (Wix) (デスクトップ2%; モバイル3%), `group_3.b26b356a.chunk.min.js` (Wix) (デスクトップ2%; モバイル3%), `tpaCommons.1b788520.chunk.min.js` (Wix) (デスクトップ2%; モバイル3%), `Qj-BdKDLI_z.js` (Facebook) (デスクトップ2%; モバイル2%), `tag.js` (Yandex Metrika) (デスクトップ2%; モバイル3%), `main.cd290f82.bundle.min.js` (Wix) (デスクトップ2%; モバイル3%), `thunderbolt-commons.35876736.bundle.min.js` (Wix) (デスクトップ2%; モバイル2%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=928442588&format=interactive",
  sheets_gid="772204378",
  sql_file="fingerprinting_most_common_scripts.sql"
  )
}}

追跡に主に使用されるスクリプトと、追跡以外の目的も持つスクリプトが混在していることがわかります。もっとも一般的なスクリプトであるRecaptchaは、<a hreflang="en" href="https://media.kasperskycontenthub.com/wp-content/uploads/sites/63/2017/11/21031220/asia-16-Sivakorn-Im-Not-a-Human-Breaking-the-Google-reCAPTCHA-wp.pdf">フィンガープリントを使用して</a>人間とボットを区別することが知られています。Google広告とYandex Metrikaも主に追跡スクリプトです。ただし、Google Maps APIやYoutube埋め込みAPIなどの他のスクリプトには、追跡以外の目的もあるため、これらのAPIの使用はフィンガープリント以外の目的がある可能性があります。これらのスクリプトが実際にフィンガープリントを実行しているかどうかを確認するには、さらに手動で分析する必要があります。

## トラッキング保護の回避

Cookieによるサードパーティのブロックなど、トラッキング保護がウェブブラウザで一般的になるにつれて、トラッカーはそれらを回避するメカニズムをますます探求しています。これらの方法は、ブラウザの機能とDNS構成を悪用し、プライバシー対策がより厳格になっても永続的なトラッキングを可能にします。

私たちは、CNAMEトラッキングとバウンストラッキングという2つの著名なトラッキング保護回避慣行を調査し、これらがウェブ上でどの程度普及しているか、またブラウザがこれらを減らし、デフォルトでユーザーのプライバシーを維持しようとしているかを調べました。

### CNAMEクローキング

CNAMEクローキングは、DNS CNAMEレコードを利用して、サードパーティのトラッカーをファーストパーティのエンティティとして偽装します。CNAMEレコードを使用すると、サブドメインを別のドメインにポイントできます。トラッカーは、埋め込まれているウェブサイトのサブドメインにCNAMEレコードを設定することでこれを利用します。たとえば、`tracker.example.com`は`tracker.trackingcompany.com`を指すことができます。トラッカーがCookieを設定すると、それは`example.com`から発信されたように見え、事実上ファーストパーティCookieとなり、多くのサードパーティCookieブロッキングメカニズムを回避します。この戦術はとくに効果的です。なぜなら、ほとんどのトラッキング保護対策はサードパーティのアクセスを制限することに集中しているのに対し、ファーストパーティCookieは通常、不可欠なウェブサイト機能のために許可されているからです。

DNSデータの分析では、ウェブサイトのプライマリドメインから発信され、サードパーティドメインを指すリクエストで使用されるCNAMEレコードを特定します。CNAMEレコードは、CDNなどのホスティングサービスによって正当に使用されることがありますが、トラッキングにも悪用される可能性があります。トラッキング固有の使用法に焦点を当てるために、特定されたドメインを<a hreflang="en" href="https://github.com/AdguardTeam/cname-trackers/blob/master/script/src/cloaked-trackers.json">AdGuardトラッカーリスト</a>と相互参照し、<a hreflang="en" href="http://WhoTracks.Me">WhoTracks.Me</a>のデータを使用して、主にホスティング関連のドメインを除外しました。

2022年のCNAMEクローキングの分析は、ファーストパーティのホスト名を<a hreflang="en" href="https://github.com/AdguardTeam/cname-trackers/tree/master/data">AdGuardの偽装CNAMEホスト名リスト</a>にマッピングすることに依存していました。今年の分析では、特定のページから発信された各要求ホスト名の実際のDNSレコードを収集するという大幅な機能強化が組み込まれています。この直接DNS解決により、サードパーティドメインにリダイレクトするCNAMEレコードを持つホスト名を正確に特定でき、CNAMEクローキング活動のより正確で包括的なビューを提供します。この改善された方法論により、これまで文書化されていなかった`utiq.com`、`truedata.co`、`actioniq.com`などに関連するトラッカーを特定し、これらをAdGuardリストにフィードバックできました。

{{ figure_markup(
  image="most-common-cname-domains.png",
  caption="トップ10のCNAMEクローキングドメイン。",
  description="トップ10のCNAMEクローキングドメイン。デスクトップとモバイルのウェブページに表示される頻度を、表示されるページの割合で示しています。これらのドメインは主にサイト分析と広告目的で使用されており、Adobe Analyticsに関連する`omtrdc.net`と`adobedc.net`が両プラットフォームでもっとも普及しているクローキングドメインです。omtrdc.netはモバイルページの0.031%、デスクトップでは0.04%に表示されます。`adobedc.net`はモバイルでの普及率0.015%で2位です。残りのドメインはそれぞれ0.01%以下のページを占めています。一般的に、これらのCNAMEクローキングドメインはモバイルのウェブページよりもデスクトップの方が一般的です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1893938121&format=interactive",
  sheets_gid="1426844224",
  sql_file="most_common_cname_domains.sql"
  )
}}

2024年のWeb Almanacデータは、CNAMEクローキングの継続的な傾向を明らかにしており、Adobe Analyticsに関連する`omtrdc.net`と`adobedc.net`が、それぞれモバイルページの0.031%（約9,000）と0.015%（約4,500）以上で表示され、サイト分析カテゴリをリードしています。

分析関連ドメインの普及は、CNAMEクローキングが広告だけに限定されず、より広範なデータ収集目的にも利用されていることを示唆しています。`actionsoftware.com`やその他の広告関連ドメインの存在は、この技術がターゲット広告に利用されていることをさらに裏付けています。

データは、CNAME全体の利用率は従来の追跡方法に比べて比較的低いものの、トラフィックの多いウェブサイトに集中しているため、多くのユーザーにとって重大なプライバシー上の懸念となっていることを浮き彫りにしています。

### バウンストラッキング

バウンストラッキングは、トラッカーがファーストパーティのコンテキストからCookieを読み取ることを可能にする、もう1つの高度な回避技術です。より具体的には、バウンストラッキングはブラウザを騙してトラッキングドメインをファーストパーティサイトとして訪問させ、ファーストパーティストレージからCookieを読み書きできるようにします。トラッキングサーバーと直接通信する代わりに、ブラウザはまず中間ドメイン、つまり「バウンス」ドメイン（<a hreflang="en" href="https://bounce-tracking-demo.glitch.me/">デモ</a>）にリダイレクトされます。したがって、サードパーティのCookieがブロックされている場合、トラッカーはファーストパーティストレージから永続的な識別子を読み取ることができます。この中間ドメインは、実際のウェブサイトにリダイレクトします。

このナビゲーションパターンは、フェデレーション認証（たとえば、OAuth）などの機能的なパターンに似ているため、バウンストラッキングのブロックは困難です。しかし、[Chrome](https://developers.google.com/privacy-sandbox/protections/bounce-tracking-mitigations)（サードパーティCookieのブロックをオプトインした場合）、<a hreflang="en" href="https://webkit.org/blog/11338/cname-cloaking-and-bounce-tracking-defense/#:~:text=SameSite%3DStrict%20Cookie%20Jail%20for%20Bounce%20Trackers">Safari</a>、<a hreflang="en" href="https://brave.com/privacy-updates/16-unlinkable-bouncing/">Brave</a>、<a hreflang="en" href="https://firefox-source-docs.mozilla.org/toolkit/components/antitracking/anti-tracking/bounce-tracking-protection/index.html">Firefox</a>などのウェブブラウザは、バウンストラッキングに対する緩和策を展開しているか、展開中です。

クロールの性質が限られており、特定のページセットの読み込みに限定されているため、リダイレクトの分析は、別のページに移動した後に元のページに戻るもののみを対象としました。バウンストラッキングは、ユーザーを元のページに戻す前にファーストパーティCookieを設定するサードパーティトラッカーへの瞬間的なリダイレクトを検出することによって識別します。

{{ figure_markup(
  image="most-common-bounce-domains.png",
  caption="トップ10のステートフルバウンスドメイン。",
  description="このグラフは、トップ10のステートフルバウンスドメインを示しており、デスクトップとモバイルのウェブサイトに表示される頻度を、それらが見つかるページの割合で測定しています。これらのドメインはトラッキングを含むさまざまな目的で使用されており、興味深いことにデスクトップとモバイルで普及率が異なり、`indapass.hu`はモバイルでもっとも一般的で、`medium.com`はデスクトップでより一般的です。medium.comはモバイルで0.009%、デスクトップで0.013%のページでリードしています。`indapass.hu`は主にモバイルで0.012%でそれに続きます。note.comはページの約0.004%を占めています。残りのドメイン（queue-it.net、photoshelter.com、payhip.com、streamlit.io、elsevierhealth.com、mistore.jp、kcrwork.com、imodules.com）は、それぞれ約0.002%以下です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1199006042&format=interactive",
  sheets_gid="1855869877",
  sql_file="most_common_bounce_domains.sql"
  )
}}

<a hreflang="en" href="http://medium.com">`medium.com`</a>（モバイル0.009%または1,515ページ、デスクトップ0.013%または1,641ページで利用可能）と`indapass.hu`（<a hreflang="en" href="https://indamedia.hu/">IndaMedia</a>）（モバイルページ0.012%または1,991ページ）がバウンストラッキングのようなナビゲーションでもっとも多く表示されることに注目します。これらの企業は、バウンストラッキングを使用して訪問者のグローバルなアイデンティティを管理し、<a hreflang="en" href="https://policy.medium.com/medium-privacy-policy-f03bf92035c9">訪問回数をカウントしてサービスを改善しています</a>（MediumとIndaMediaは両方とも出版社です）。

クロール可能なページに限定された私たちの分析は網羅的ではなく、特定されたすべてのドメインが必ずしもプライバシーを侵害する行動を示すわけではありません。SSO（たとえば、`login.taobao.com`）や決済ソリューションなどの正当な使用は、バウンスドメインでのユーザー操作の有無によってトラッキングと区別できることがよくあります。

## プライバシーを向上させるブラウザのポリシー

広告やソーシャルメディアプラットフォームなど、サードパーティサービスのコンテンツをウェブサイトに含めるのは一般的な慣行です。残念ながら、サードパーティサービスは暗黙のうちに信頼できるものではなく、多くの場合、ユーザーのプライバシーを直接害します。たとえば、サードパーティの追跡サービスを含めることによってです。[サードパーティ](./third-parties)の章で、より詳細な分析をご覧ください。

最近、ウェブ標準化団体やブラウザベンダーは、ウェブサイト開発者がサードパーティサービスによってもたらされるプライバシーの脅威を軽減するために使用できる多くのコントロールを提供しようと介入してきました。私たちは、そのような著名なブラウザ提供のコントロールの普及率を分析します。Permissions Policyなど一部のブラウザポリシーは、セキュリティとプライバシーの両方に影響を及ぼすことに注意してください。このようなポリシーについては、[セキュリティ](./security#許可ポリシー)の章で説明します。

### User-Agent Client Hints

とくにUser-Agent文字列を介して、ブラウジング環境について公開される情報量を最小限に抑えるための取り組みとして、User-Agent Client Hintsメカニズムがブラウザと標準化団体によって導入されています。

重要な考え方は、ユーザーのブラウジング環境に関する特定の高エントロピー情報にアクセスしたいウェブサイトは、最初の応答でヘッダー（Accept-CH）を設定する必要があるということです。

{{ figure_markup(
  image="Percentage-of-pages-with-Client-Hints.png",
  caption="Client Hintsを使用しているページの割合。",
  description="Client Hintsの使用は、もっとも人気のあるウェブサイト（上位1,000サイト）に集中しています。この上位ランクのバケットにあるページの約16%がClient Hintsを利用しています。下位のウェブサイトでは使用率が劇的に低下し、上位10,000サイトのバケットでは5%のページしかClient Hintsを使用していません。この傾向は下位のウェブサイトでも続き、上位1,000,000サイトのバケットでは1%未満のページしかClient Hintsを利用していません。分布はデスクトップとモバイルデバイスで比較的均等です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1362669305&format=interactive",
  sheets_gid="210309462",
  sql_file="number_of_websites_with_client_hints.sql"
  )
}}

上位1,000のモバイルウェブサイトの15.8%、上位10,000のモバイルウェブサイトの5.1%で展開されていることに注目します。[2022年の章](../2022/privacy#user-agent-client-hints)の結果（上位1,000：9.11%、上位10,000：3.12%）と比較して、`Accept-CH`ヘッダーで応答するサイトの採用を見ると、人気のある1,000サイトで6.69%の採用増加が見られます。この採用の増加は、ChromiumがUser-Agent文字列で共有される情報を（<a hreflang="en" href="https://www.chromium.org/updates/ua-reduction/">User-Agent削減計画</a>を通じて）削減しているという事実に関連していると推測されます。すべてのウェブサイトについて、Accept-CHは、デスクトップとモバイルのすべてのクロールされたウェブサイトのそれぞれ0.4%と0.5%で展開されています。

### Referrerポリシー

デフォルトでは、ほとんどのユーザーエージェントに`Referer`ヘッダーが含まれており、リクエストの送信元となったウェブサイト、あるいは特定のページをサードパーティに公開します。これは、ウェブページに埋め込まれたリソースや、ユーザーがリンクをクリックして発生したリクエストで起こります。その結果、サードパーティは特定のユーザーがどのウェブサイトやページを訪問していたかを知ることができ、プライバシー上の懸念につながる可能性があります。

{{ figure_markup(
  image="Referrer-policy-implementations.png",
  caption="Referrer Policyの実装。",
  description="Referrer Policyへの実装方法を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=613754677&format=interactive",
  sheets_gid="1555566389",
  sql_file="number_of_websites_with_referrerpolicy.sql"
  )
}}

[Referrer Policy](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Referrer-Policy)を利用することで、ウェブサイトはReferrerヘッダーがリクエストに含まれるインスタンスを制限し、ユーザーのプライバシーを向上させることができます。

Referrer Policyは、ドキュメントレベルとリクエストレベルの両方で含めることができます。Referrer Policyは、デスクトップウェブページの33.87%、モバイルウェブページの32%で展開されていることがわかりました。そのようなページの21.82%では、Referrer Policyはref=noreferer HTMLタグを使用してリクエストレベルで展開されており、11.31%のインスタンスでは、Referrer Policyはドキュメントレベルで展開されています。

{{ figure_markup(
  image="Most-common-Referrer-Policy-values.png",
  caption="もっとも一般的なReferrer Policyの値。",
  description="もっとも一般的なリファラーポリシーの値を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=944991454&format=interactive",
  sheets_gid="380345202",
  sql_file="most_common_referrer_policy.sql"
  )
}}

Referrer Policyは一部の追跡を軽減できますが、すべてのオプションが同じ効果を持つわけではありません。そこで次に、個々のReferrer Policyオプションの展開を測定します。

私たちの分析によると、`strict-origin-when-cross-origin`がReferrer Policyでもっとも一般的に使用されているオプションであり、クロールされたウェブページの8%で展開されています。また、[2022年の章](../2022/privacy#ユーザーエージェントクライアントヒント)でクロールされたウェブページのわずか2.68%でしか展開されていなかったのと比較して、その展開がほぼ3倍に増加したことにも注目します。

`strict-origin-when-cross-origin`は、ポリシーが指定されていない場合のデフォルトオプションでもあり、`referer`ヘッダーの完全なURLを同一オリジンリクエストにのみ共有します。クロスオリジンリクエストの場合、パスとクエリ文字列パラメータは削除されます。

次に一般的に展開されているオプションは`no-referrer-when-downgrade`で、これはダウングレードリクエスト、つまりHTTPS対応ページで開始されたHTTPリクエストでRefererヘッダーを含めません。残念ながら、これでもほとんどのシナリオ、つまりHTTPS対応リクエストでユーザーが訪問しているページが漏洩します。

### プライバシー関連のオリジントライアル

オリジントライアルにより、ウェブサイト開発者は新しいブラウザAPIなど、ウェブブラウザ（ChromeまたはFirefox）がリリースした新機能をテストできます。ウェブサイト開発者がオリジントライアルに登録すると、新しいブラウザ機能がすべてのユーザーに利用可能になります。ウェブブラウザはサードパーティのCookieを排除するなど、プライバシーを強化する機能をますます展開しているため、次にウェブサイト開発者がプライバシー関連のオリジントライアルに参加しているかどうかを分析し、ブラウザで今後のプライバシー強化機能に対する準備状況を評価します。

{{ figure_markup(
  image="Privacy-focused-Origin-Trials.png",
  caption="プライバシー重視のオリジントライアル。",
  description="このグラフは、DisableThirdPartyStoragePartitioningがデスクトップとモバイルの両ユーザーで10%強ともっとも高い採用率であることを明確に示しています。`FledgeBiddingAndAuctionServer`はモバイルで6.62%の採用率でそれに続きます。`AttributionReportingCrossAppWeb`の使用率は2.1%です。残りの機能である`Tpcd`、`SendFullUserAgentAfterReduction`、`PrivacySandboxAdsAPIs`、`DisableThirdPartySessionStoragePartitioning`、`InterestCohortAPI`、`UserAgentReduction`、`TopLevelTpcd`はすべて、0.65%から0.01%の範囲で、著しく低い採用率を示しています。一般的に、これらのプライバシー重視のオリジントライアルへの参加は比較的低く、まだ実験と採用の初期段階にあることを示唆しています。`DisableThirdPartyStoragePartitioning`と`FledgeBiddingAndAuctionServer`の使用率が高いことは、それらの特定のプライバシー保護技術への関心または成熟度が潜在的により高いことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1221242964&format=interactive",
  sheets_gid="1174105425",
  sql_file="number_of_websites_with_related_origin_trials.sql"
  )
}}

プライバシー強化機能の中で、`disableThirdPartyStoragePartitioning`がもっとも広く使用されているコントロールであり、モバイルウェブサイトの10.21%で展開されていることに注目します。`disableThirdPartyStoragePartitioning`は、トップレベルサイトが、そのページに埋め込まれたサードパーティコンテンツのストレージ、サービスワーカー、通信APIでパーティション分割を解除（トップレベルサイトによる分離を一時的に削除）できるようにします。

これは、ウェブサイトの10%以上が、サードパーティストレージのパーティショニングによって提供される利点を無効にする機能をテストしていることを意味します。[ストレージパーティショニング](https://developers.google.com/privacy-sandbox/cookies/storage-partitioning)は、Cookieを含まない一部のストレージ関連APIに適用されることに注意してください。2番目に普及しているトライアルは<a hreflang="en" href="https://chromestatus.com/feature/4649601971257344">`FledgeBiddingAndAuctionServer`</a>で、モバイルウェブサイトの6.62%以上で展開されています。

## Privacy Sandboxの提案

2019年にGoogleによって導入されたPrivacy Sandboxには、ユーザーのプライバシーと、ウェブ上の無料コンテンツやサービスを支えるオンライン広告の継続的な存続可能性とのバランスをとることを目指し、ウェブ上のプライバシー侵害行為を抑制することを目的とした、いくつかの提案が含まれています。Privacy Sandboxの提案の中でも、Topics、Protected Audience、Attribution Reportingは、それぞれターゲット広告、インタレストベース広告オークション、プライバシーを保護するコンバージョントラッキングへの影響から、大きな注目を集めています。このセクションでは、これらの提案の採用状況を測定し、ウェブサイトやアドテク（たとえば広告プラットフォーム、追跡エンティティ）がこれらの提案を組み込む準備ができているかを評価します。これらの提案の一部はChromeに限定されず、Microsoft Edgeなどの他のブラウザでもテストされていることに注意してください。

まず、これらのAPIの普及率を示します。Topics API、Protected Audience API（旧FLEDGE）、Attribution Reporting APIは、さまざまな広告配信技術においてもっとも高い存在感を示していることがわかります。これらは、上位1,000のウェブサイトのそれぞれ33%、63%、27%に存在します。上位1,000万のウェブサイトの中では、その存在感はそれぞれ7%、63%、24%に低下します。この存在は、ウェブサイトによるこれらのAPIの採用を意味するものではないことに注意してください。

### Topics API

GoogleのTopics提案は、「スポーツ」や「テクノロジー」など、ユーザーの最近の閲覧行動に基づいて、大まかなトピックの小さなセットをユーザーに割り当てることで機能します。これらのトピックはユーザーのデバイスにローカルに保存され、関連性の高い広告を配信するためにウェブサイトや広告主と共有されます。ユーザーは広告主と共有されるトピックを表示し、制御することもできます。

{{ figure_markup(
  image: "Topics-API-Presence.png",
  caption: "Topics APIのプレゼンス。",
  description: "ランク別のページでのTopics APIの使用状況を示す棒グラフ。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1967446286&format=interactive",
  sheets_gid: "2114689864",
  sql_file: "privacy-sandbox-adoption-by-third-parties-by-publishers.sql"
  )
}}

このAPIはHTTPヘッダーとJavaScriptの両方を介して展開できるため、これらの両方の軸にわたるTopics APIの採用を測定します。JavaScriptベースの存在（`document.browsingTopics`）はページの7%で見られ、ヘッダーベースの存在（`sec-browsing-topics`）の約4%よりも広まっていることがわかります。

{{ figure_markup(
  image: "FLoC-API-Presence.png",
  caption: "FLoC APIのプレゼンス。",
  description: "ランク別のページでのFLoC APIの使用状況を示す棒グラフ。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=89328056&format=interactive",
  sheets_gid: "2114689864",
  sql_file: "privacy-sandbox-adoption-by-third-parties-by-publishers.sql"
  )
}}

驚くべきことに、Topics APIの前身であるFederated Learning of Cohorts API（FLoC）は、いくつかのプライバシー問題により非推奨とされているにもかかわらず、かなりの数のページにまだ存在していることもわかります。Topics APIは現状を改善しますが、<a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0004.pdf">先行研究</a>では、ユーザーのブラウザから返されるトピックを一定期間監視することで、ユーザーの再識別につながる可能性があることが示されています。

### Protected Audience API

Protected Audience APIは、ブラウザによるデバイス上のオークションを可能にし、ユーザーが以前に訪問したウェブサイトから関連性の高い広告を選択します。これにより、リマーケティングやターゲット広告で通常採用されているプライバシーを侵害するデータ収集や広範な追跡が不要になります。これにより、広告主はサイトをまたいでユーザーを追跡することなく、関連性の高い広告を配信できます。

{{ figure_markup(
  image: "Protected-Audience-(FLEDGE)-API-Presence.png",
  caption: "Protected Audience (FLEDGE) APIのプレゼンス。",
  description: "ランク別のページにおけるProtected Audience APIのプレゼンスを示す棒グラフ。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=616049578&format=interactive",
  sheets_gid: "2114689864",
  sql_file: "privacy-sandbox-adoption-by-third-parties-by-publishers.sql"
    )
  }}

Protected Audience APIで利用可能なさまざまなメソッド呼び出しの中で、`navigator.joinAdInterestGroup()`がサードパーティサービスによってもっとも多く使用されていることがわかります（上位1,000万のウェブサイトの63%）。

このAPIは、サードパーティサービスがブラウザに指示して、訪問ユーザーのインタレストグループをブラウザのメンバーシップリストに追加する機能を提供します。最近の研究（<a hreflang="en" href="https://www.usenix.org/system/files/usenixsecurity24-calderonio.pdf">Calderonio et al.</a>、<a hreflang="en" href="https://arxiv.org/pdf/2405.08102">Long and Evans</a>）では、Protected Audience APIに関するさまざまなプライバシー上の欠陥が発見されています。たとえば、サードパーティのトラッカーは、サイドチャネルを使用してユーザーのインタレストグループを実際のユーザーにリンクさせ、サイトをまたいで追跡できる可能性があります。共謀するエンティティの可能性は、関連するプライバシーリスクをさらに高めます。

### アトリビューションレポーティングAPI

[アトリビューションレポーティングAPI](https://developers.google.com/privacy-sandbox/private-advertising/attribution-reporting)（ARA）は、Google Chromeで広告のコンバージョンを測定するためのプライバシー保護メカニズムを導入しています。その目的は、パブリッシャーと広告主のウェブサイトでそれぞれアトリビューションソースとトリガーを登録する機能を提供することにより、アトリビューション測定を可能にすることです。Chromeはすべてのコンバージョンを記録し、差分プライベートレポートを生成して、遅延付きで承認されたソースに送信し、ユーザーのクロスサイトリンクを防ぎます。このメカニズムは、特定のHTTPヘッダーを使用して機能します。

1. `attribution-reporting-eligible`: このヘッダーは、特定のリクエストの応答がアトリビューションレポートの対象であることを示します。
2. `attribution-reporting-register-source`: パブリッシャーに広告主の広告を表示する際に、アトリビューションソースを登録するために使用されます。
3. `attribution-reporting-register-trigger`: ユーザーが広告を操作したときにコンバージョンを測定するトリガーを登録するために、広告主のウェブサイトで使用されます。

私たちの分析から、ソースを登録しているサードパーティよりも、トリガーを登録しているサードパーティの方が2倍多いことがわかります。この傾向は、初期の広告表示イベントの追跡と比較して、コンバージョンの測定に重点が置かれていることを示しています。

{{ figure_markup(
  image: "Attribution-Reporting-API-Presence.png",
  caption: "アトリビューションレポーティングAPIのプレゼンス。",
  description: "ランク別のページでのアトリビューションレポーティングAPIのプレゼンスを示す棒グラフ。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=855872461&format=interactive",
  sheets_gid="2114689864",
  sql_file="top_ara_destinations_registered_by_most_publishers.sql"
  )
}}

もっとも人気のあるブラウザのほとんどが、ChromeのARA、Safariの<a hreflang="en" href="https://webkit.org/blog/11529/introducing-private-click-measurement-pcm/">プライベートクリック測定</a>（PCM）、MozillaとMetaによる<a hreflang="en" href="https://github.com/patcg-individual-drafts/ipa">相互運用可能なプライベートアトリビューション</a>（IPA）などの提案で、プライバシー保護アトリビューションの分野で互いに競合しているため、ARAをより詳細に分析します。さまざまなウェブサイトでの広告デスティネーションの登録を調べます。

{{ figure_markup(
  image="ARA-Destination-registration.png",
  caption="ARAデスティネーション登録。",
  description="ランクごとのドメインの割合に対するARAデスティネーション登録を示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=908490027&format=interactive",
  sheets_gid="618355658",
  sql_file="number_of_ara_destinations_registered_by_third_parties_and_publishers.sql"
  )
}}

上位1,000のウェブサイトの8.8%のパブリッシャーで、14.6%の異なる広告主が`attribution-reporting-register-trigger`ヘッダーを使用して自身を登録するためにARAを使用していることがわかります。合計で、上位100万（上位1,000万）のウェブサイトの5.1%（2.4%）のパブリッシャーで、1.6%（0.5%）の異なる広告主がARAを採用していることがわかります。これは、広告主の採用と比較して、多くのパブリッシャーがARAを採用していないことを示しています。広告主は、広告クリックに対するユーザーのコンバージョンをアトリビュートするためにARAに依存する必要があるポストCookie時代に備えています。

<aside class="note"><b>制限事項</b>：この分析では、「存在」とは、JavaScriptにおけるプライバシーサンドボックスAPI呼び出しの単なる存在を指すことに注意してください。これは、APIが実行時に実行または使用されることを保証するものではありません。</aside>

### 関連ウェブサイトセット

[関連ウェブサイトセット](https://developers.google.com/privacy-sandbox/cookies/related-website-sets)により、同じ所有者のウェブサイト間でCookieを共有できます。関連ウェブサイトセットの作成と送信は、現在、Googleプロジェクトの貢献者が有効と判断した場合にチェックしてマージする<a hreflang="en" href="https://github.com/GoogleChrome/related-website-sets">GitHubリポジトリ</a>でプルリクエストを開くことで行われます。同じ関連ウェブサイトセットに属するウェブサイトは、<a hreflang="en" href="https://www.iana.org/assignments/well-known-uris/well-known-uris.xhtml">.well-known URI</a> `.well-known/related-website-set.json` に対応するファイルを配置して、それを示す必要があります。

Chromeには、Chromeチームによって検証された関連ウェブサイトセットを含むプリロードされたファイルが付属しています。執筆時点（バージョン2024.8.10.0）では、64個の異なる関連ウェブサイトセットがあります。各関連ウェブサイトセットには、プライマリドメインと、次の属性のいずれかの下でプライマリドメインに関連する他のドメインのリストが含まれています： `associatedSites` 、 `servicesSites` 、および/または `ccTLDs` 。これらの64個のプライマリドメインはそれぞれ、セットの一部としてセカンダリドメインに関連付けられています：60個のセットには `associatedSites` が、11個には `servicesSites` が、7個には `ccTLDs` が含まれています。詳細な結果については、[Cookie](./cookies#関連ウェブサイトセット)の章を参照してください。

## 法律とポリシー

オンライントラッキングに対する監視が強まる中、オンライン広告主やトラッカーの責任を問う新たな法律や規制が数多く可決されています。このセクションでは、これらの規制がプライバシーに与えた影響を見ていきます。

### 同意ダイアログ

欧州連合における<a hreflang="en" href="https://gdpr-info.eu/">一般データ保護規則</a>（GDPR）や<a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">カリフォルニア州消費者プライバシー法</a>（CCPA）などのプライバシー規制の導入により、ウェブサイトはユーザーデータの収集、共有、処理（たとえばサードパーティの追跡Cookieの収集と使用）についてユーザーの同意を得る必要があります。これにより、Cookie同意ダイアログが広く使用されるようになり、ユーザーにデータ収集慣行を通知し、同意、拒否、またはカスタマイズを可能にしています。

これらの同意ダイアログはウェブ全体で普遍的な機能となっていますが、ユーザーのプライバシーを真に保護する上での有効性は議論の余地があります。多くのウェブサイトは「ダークパターン」を使用してユーザーに追跡を承諾させようとし、また、技術に詳しくないユーザーを圧倒する可能性のある複雑なオプションを提示するものもあります。Interactive Advertising Bureau（IAB）ヨーロッパは、ターゲット広告の同意を得るプロセスを標準化するために、<a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">透明性と同意のフレームワーク</a>（TCF）を導入しました。IAB同意ダイアログは、多くのウェブサイトや広告技術企業が、パーソナライズされた広告を引き続き提供しながら、GDPRやその他のプライバシー法を遵守するために使用しています。このフレームワークは、ユーザーデータがどのように処理されるかについて透明性を提供し、パーソナライズされた広告、分析、コンテンツ配信など、さまざまな目的でユーザーが同意を与えたり差し控えたりする機能を提供することを目的としています。

私たちの調査結果は、TCFが他のプライバシーフレームワークとともに、出版社がGDPRやCCPAなどのデータ保護法を遵守しようとする中で広く実装されていることを示しています。ここでの測定は米国を拠点としており、TCFによれば、EU以外の訪問には同意バナーは不要であることに注意してください。したがって、これによりTCFの使用状況の測定値が実際よりも小さくなる可能性があります。

{{ figure_markup(
  image: "Presence-of-IAB-privacy-frameworks.png",
  caption: "IABプライバシーフレームワークの存在。",
  description: "このグラフは、ページのほぼ6%がTCFまたはUSPのいずれかを実装していることを示しています。TCFのみを見ると、ページの約4.2%がこのフレームワークのバージョンを利用しています。具体的には、TCF v2は約4%のページに存在し、USPは約3.3%で見つかります。準拠したTCF v2およびv1の実装ははるかに一般的ではなく、それぞれページの約1.7%および0.1%にしか表示されません。基本的なTCF v1の使用は約0.2%です。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1902161831&format=interactive",
  sheets_gid="616126986",
  sql_file="number_of_websites_with_iab.sql"
  )
}}

2024年のデータは、[2022年](../2022/privacy#IAB同意フレームワーク)と比較してプライバシーの状況が変化したことを明らかにしています。まず、IABフレームワーク全体の普及率が増加しました。2022年には、もっとも広範なIABのプレゼンス（「IAB all」）がページの4.4%（デスクトップとモバイルの合計）で見つかりました。2024年には、TCFまたはUSPフレームワークのいずれかがホームページの5.8%に表示されます。これは、規制の監視強化やユーザーの意識向上によって、プライバシー基準の採用が拡大していることを示唆しています。

個々のフレームワークを調べると、TCFの使用（任意のバージョン）はページの4.2%に表示されますが、USPは単独でページの3.3%に存在します。ページの4.0%が最新バージョンのTCF（v2）を使用しており、これがもっとも普及しているバージョンでもあります。準拠したセットアップ（ベンダーの同意設定の存在）を持つTCF v2は、より小さなサブセットであるページの1.7%に表示されます。GDPR施行前の古いTCF v1は、0.2%とごくわずかです。

興味深いことに、IABフレームワーク全体の使用率は上昇していますが、USPの採用率は比較的安定しており、2022年の約3.4%に対し2024年は3.3%です。これは、プライバシーフレームワーク採用の全体的な成長が、主にTCF、とくにTCF v2の使用増加によって牽引されていることを示唆しています。

最後に、TCF v1からTCF v2への移行は明らかです。2022年のTCF v1には測定可能なプレゼンス（モバイルで0.3%）がありましたが、2024年には0.2%とほぼ廃止されています。TCF v2の採用は大幅に増加しており（1.9%から4%）、これは新しいGDPRに沿った同意メカニズムへの移行をさらに示しています。しかし、完全なTCF v2コンプライアンスは依然として比較的低く、その複雑な要件を完全に実装するという継続的な課題を浮き彫りにしています。

{{ figure_markup(
  image: "Top-10-TCF-v2-compliant-CMPs.png",
  caption: "トップ10のTCF v2準拠CMP。",
  description: "Automattic, Inc.は、TCF v2に準拠したCMPプロバイダーの中でトップであり、モバイルページの0.67%をカバーしています。InMobi PTE LtdとDidomiがそれぞれ約0.25%と0.22%の普及率でそれに続きます。Wikia, Inc. ( FANDOM) はページの約0.14%を占めています。残りのCMP（iubenda、SIRDATA、OneTrust LLC、AppConsent by SFBX®、Sourcepoint Technologies, Inc.、Objectis Ltd）は、それぞれモバイルページの0.1%未満の存在感です。リストされているすべてのCMPで、モバイルでの使用は一般的にデスクトップの実装を上回っており、Automattic, Inc.が両者で最も顕著な差を示しています。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1496134639&format=interactive",
  sheets_gid: "1039725590",
  sql_file: "most_common_cmps_for_iab_tcf_v2.sql"
  )
}}

TCF v2エコシステム内での同意管理プラットフォーム（CMP）の使用状況の分析によると、Automattic, Inc.が採用をリードしており、ページの0.67%に表示され、InMobi PTE Ltdが0.25%、Didomiが0.22%でそれに続いています。これは、特定のCMPが同意を効果的に管理するために信頼されるようになったことを示唆していますが、採用率が比較的低いことは、多くのサイトがまだ社内ソリューションやあまり広く認識されていないCMPに依存している可能性があることを意味します。

### Do Not Track

Do Not Track（DNT）は、2010年代初頭に導入されたブラウザベースのプライバシーイニシアチブです。これにより、ユーザーはウェブサイトによる追跡を希望しないことを示すブラウザ設定を行えました。しかし、DNTは主に任意であり、強制メカニズムがなかったため、広く採用されるには至りませんでした。

{{ figure_markup(
  caption: "デスクトップページでは、依然としてDNT（Do Not Track）HTTPヘッダーが使用されています。",
  content: "19.8%",
  classes: "big-number",
  sheets_gid: "1906789372",
  sql_file: "number_of_websites_with_dnt.sql"
)
}}

DNTはユーザープライバシーにおける先駆的なアイデアでしたが、主要な広告主やトラッカーがDNTリクエストを無視することを選択し、どの法的枠組みにも祀られていなかったため、最終的には時代遅れになりました。時代遅れであるにもかかわらず、私たちの分析によると、デスクトップウェブサイトの19.8%、モバイルウェブサイトの18.4%が依然としてDNTシグナルをサポートしています。これらのサイトはDNTシグナルをチェックするかもしれませんが、これらのサイトがシグナルをどの程度遵守し、準拠しているかは不明であると指摘することが重要です。

### Global Privacy Control

Global Privacy Control（GPC）は、DNTと同様に、ユーザーがプライバシー設定をウェブサイトに伝えるためのシンプルなブラウザベースのメカニズムを提供するように設計された、より最近のイニシアチブです。ただし、DNTとは異なり、GPCはCCPA（カリフォルニア州消費者プライバシー法）などの法規制に裏付けられています。

GPCを使用すると、ユーザーは自分のデータが第三者に販売または共有されることを望まないことを通知でき、企業は特定の法律の下でこの信号を尊重する法的義務を負います。主要なブラウザやプライバシー重視の拡張機能はGPCをサポートしており、ユーザープライバシーのためのより効果的なツールとして注目を集めています。

{{ figure_markup(
  image: "Presence-of-Global-Privacy-Control.png",
  caption: "Global Privacy Controlの存在。",
  description: "`present in JS resources`: これは、GPCがウェブページによって実行されるJavaScriptコード内で検出されたことを示し、サイトによる信号のアクティブな実装または認識を示唆しています。この方法では、デスクトップで約55.8%、モバイルで54.9%という高いGPCの普及率が明らかになります。`.well-known available`: これは、特定のオリジンで特定のリソースが利用可能であることを指し、GPCがサポートされているが必ずしも遵守されているわけではないことを意味します。この方法による普及率は著しく低く、デスクトップとモバイルで約0.3%です。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1177501662&format=interactive",
  sheets_gid: "500113190",
  sql_file: "number_of_websites_with_gpc.sql"
  )
}}

分析によると、デスクトップサイトの55.8%、モバイルサイトの54.9%でGPC信号がJavaScriptを介してアクセスでき、これはDNT信号よりも大幅に高いことがわかります。GPCのもう1つのオプション要件は、ウェブサイトのオリジンサーバーURLに対して相対的な`/.well-known/gpc.json`エンドポイントにあるウェルノウンURLです。このリソースは、ウェブサイトがGPCを認識し、サポートしていることを示すためのものですが、同時にGPCを遵守することを保証するものではありません。私たちの測定では、モバイルサイトとデスクトップサイトのわずか0.2%しか、アクセス可能なウェルノウンエンドポイントを持っていないことがわかりました。

### カリフォルニア州消費者プライバシー法

2018年に制定されたカリフォルニア州消費者プライバシー法（CCPA）は、米国で可決されたもっとも重要なプライバシー法の1つです。これにより、カリフォルニア州の住民は、収集されているデータを知る権利、データの削除を要求する権利、データの販売をオプトアウトする権利など、個人データに対する権利を与えられます。CCPAは、カリフォルニア州の住民からデータを収集または処理する場合、世界中の企業が遵守しなければならないため、ウェブに大きな影響を与えています。これにより、多くのウェブサイトで「私の個人情報を販売しない」リンクが導入され、米国でのデータプライバシーに対する意識が高まりました。

<a hreflang="en" href="https://www.oag.ca.gov/privacy/ccpa">法律の下では</a>、カリフォルニアで事業を行い、特定の規模のしきい値を満たす事業は、ユーザーが個人情報の販売または共有をオプトアウトする方法を提供しなければなりません。法律を遵守するため、カリフォルニア州司法長官室は、事業のホームページに「私の個人情報を販売しない」というテキストと標準化されたアイコンを含むリンクを配置することを<a hreflang="en" href="https://www.oag.ca.gov/privacy/ccpa/icons-download">推奨しています</a>。一般的なCCPAリンクフレーズのセットを特定した<a hreflang="en" href="https://petsymposium.org/popets/2022/popets-2022-0030.pdf">先行研究</a>に基づいて、人気度レベルに応じてサイト全体でのこれらのリンクの普及率の分析を実施しました。

{{ figure_markup(
  image: "Prevalence-of-CCPA-Links-on-Website-home-pages.png",
  caption: "ウェブサイトのホームページにおけるCCPAリンクの普及率。",
  description: "ウェブサイトのホームページにおけるCCPAリンクの普及率を示す棒グラフ。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1672202318&format=interactive",
  sheets_gid: "1223494608",
  sql_file: "ccpa_prevalence.sql"
  )
}}

全体として、CCPAリンクを含むウェブサイトはわずか0.96%であることがわかります。また、ランクの低いウェブサイトと比較して、ランクの高いウェブサイトほどCCPAリンクを含んでいることもわかります。ランクの高いウェブサイトは、CCPAの対象となるしきい値を満たしている可能性が高いか、単に要件をより認識しているため、CCPAリンクを含んでいる可能性が高くなります。

しかし、上位1,000のウェブサイトにおけるリンクの割合はわずか7.19%であり、これは非常に低い値です。これらのサイトのうち、CCPAの対象となる要件を満たしているサイトがいくつあるかを知ることは不可能ですが、上位ランクのウェブサイトの多くは少なくとも収益のしきい値を満たしている可能性が高いため、カリフォルニアのユーザーを積極的にブロックする措置を講じない限り、対象となっているように見えます。

私たちのクロールの1つの制限は、地理的に分散しているため、カリフォルニアの訪問者にのみCCPAリンクを動的に表示するウェブサイトを正確に考慮できないことです。したがって、私たちの結果はこれらのリンクの普及率を過小評価している可能性があります。ただし、2022年に実施された<a hreflang="en" href="https://petsymposium.org/popets/2022/popets-2022-0030.pdf">先行研究</a>によると、CCPAリンクのわずか17%しか動的に非表示にされていなかったことに注意することが重要です。

最後に、CCPAリンクでもっとも一般的に使用されている言い回しを調べます。

{{ figure_markup(
  image: "Top-10-Phrases-in-CCPA-Links.png",
  caption: "CCPAリンクのトップ10フレーズ。",
  description: "CCPAリンクのトップ10フレーズを示す棒グラフ。",
  chart_url: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=956353245&format=interactive",
  sheets_gid: "1792311741",
  sql_file: "ccpa_most_common_phrases.sql"
  )
}}

ほとんどのサイトは、CCPAで推奨されている「do not sell my personal information」というフレーズの変形を使用しています。しかし、かなりの数のサイトには「your privacy choices」というタイトルのリンクも含まれており、その意味はあまり明確ではありません。これにより、ユーザーがこれらのサイトでオプトアウトすることがより困難になる可能性があります。


## 結論

私たちは、オンライントラッキングが単に普及しているだけでなく、ほぼ普遍的であり、デスクトップウェブサイトの95%、モバイルウェブサイトの94%に少なくとも1つのトラッカーが含まれていることを発見しました。GoogleやFacebookなどの主要企業は、それぞれウェブページの68%と23%に存在し、この状況を支配しています。また、トラッカーがステートフルな方法（Cookieやローカルストレージなど）とステートレスな方法（ブラウザのフィンガープリントなど）の両方を利用して、インターネット全体でユーザーを追跡していることも観察しています。

トラッカーは、プライバシー強化の取り組みを回避するために、洗練された技術を継続的に開発しています。とくに、CNAMEクローキングやバウンストラッキングなどの方法が出現し、トラッカーがファーストパーティエンティティになりすまし、ブラウザの機能を悪用して追跡活動を継続できるようになっています。

この章では、User-Agent Client HintsやReferrer Policyなど、ユーザーのプライバシーを強化するために設計されたブラウザポリシーの採用も評価しています。2022年（この分析が最後に行われた年）からこれらの機能の実装は徐々に増加していますが、ウェブ全体での採用は依然として不均一です。さらに、Topics API、Protected Audience API、Attribution Reporting APIなどのPrivacy Sandbox提案の導入は、オンライン広告におけるプライバシー保護技術への前向きなシフトを示しています。

法的な面では、GDPRやCCPAなどの規制により、同意ダイアログやIABの透明性と同意のフレームワークなどのフレームワークが急増しました。しかし、採用が限られているため、これらの措置の有効性は疑問視されています。
