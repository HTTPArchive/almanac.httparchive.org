---
title: プライバシー
description: 2022年のWeb Almanacのプライバシー章は、オンライン追跡の採用と影響、プライバシー設定信号、およびよりプライバシーに配慮したウェブを目指すブラウザの取り組みについて取り上げています。
authors: [tomvangoethem, nrllh]
reviewers: [iskander-sanchez-rola]
analysts: [max-ostapenko, ydimova]
editors: [DesignrKnight]
translators: [ksakae1216]
tomvangoethem_bio: Tom Van Goethemは最近、GoogleのChromeプライバシーチームに参加しました。それ以前には、ベルギーのルーヴェン大学のDistriNetグループで博士課程に在籍していました。彼の研究興味は、ウェブセキュリティとプライバシーの分野における幅広いトピックをカバーしており、特にサイドチャネル攻撃に重点を置いています。脅威を明らかにし、緩和策を提案することで、Tomはウェブを少しずつでもより良い場所にすることを目指しています。
nrllh_bio: Nurullah Demirは、サイバーセキュリティ研究者であり、<a hreflang="en" href="https://www.internet-sicherheit.de/en/">インターネットセキュリティ研究所</a>および<a hreflang="en" href="https://intellisec.de">インテリジェントシステムセキュリティ、KASTELセキュリティ研究ラボ</a>の博士課程の学生です。彼の研究はウェブセキュリティとプライバシー、そしてウェブ計測に焦点を当てています。
results: https://docs.google.com/spreadsheets/d/1iJqj3g0VEjpmjzvtX6VLeRehE7LDQGcw6lOadxGxkjk/
featured_quote: 完全に実現するまでに数年かかるかもしれませんが、ユーザーがどの情報をどの当事者と共有したいかをよりコントロールできるウェブへと移行しています。この収束はスペクトラムの両端で見られます：一方でウェブサイトによって開始され、もう一方でブラウザによって強制されています。
featured_stat_1: 82%
featured_stat_label_1: 少なくとも1つのサードパーティトラッカーを含むサイト。
featured_stat_2: 11%
featured_stat_label_2: 同意管理プラットフォーム（CMP）の普及。
featured_stat_3: 9.5%
featured_stat_label_3: トップ1000のサイトの中でUser-Agentクライアントヒントを利用しているもの。
---

## 序章

最新のニュースを入手するため、オンラインソーシャルメディアを通じて友人と連絡を取り合うため、または素敵なドレスやセーターを購入するために、多くの人々がクリックするだけでこれらのサービスや情報を提供するウェブに依存しています。[インターネットで平均して1日約7時間を過ごす](https://datareportal.com/reports/digital-2022-global-overview-report)という副作用は、多くの閲覧活動、そして間接的には個人の興味やデータが、無数のオンラインウェブサービスや企業と共有されたり捕捉されたりすることです。

広告主はユーザーに最も関連性の高い広告（最も関与しそうなもの）を提供しようとするため、しばしばサードパーティの追跡を用いてユーザーの興味を推測します。本質的には、ユーザーのオンライン活動がステップバイステップで追跡され、特にウェブ上で最も普及している追跡者には、ユーザーの興味を推測するために必要ない情報が含まれている可能性のある情報の山が提供されます。その上、ユーザーはこれをオプトアウトする適切な選択肢を一般的に与えられていません。

この章では、プライバシーの観点から現在のウェブの状態を探ります。サードパーティの追跡の普及、このエコシステムを構成する異なるサービス、および特定の当事者がユーザーのプライバシーを守るために採用している保護措置（例えば、ブロックリストベースのアンチトラッカー）を回避しようとしている方法について報告します。さらに、ウェブサイトが訪問者のプライバシーを高めようとしている方法、つまり他の当事者と共有される情報を制限する機能を採用するか、[GDPR](https://gdpr.eu/)や[CCPA](https://oag.ca.gov/privacy/ccpa)などのプライバシー規制に準拠することによっても調査します。

## オンライン追跡

{{ figure_markup(
  caption="デスクトップで少なくとも1つのサードパーティトラッカーを含むウェブサイトの割合。",
  content="82%",
  classes="big-number",
  sheets_gid="225736044",
  sql_file="most_common_tracker_categories.sql"
)
}}

追跡はウェブ上で最も広範にわたる技術の一つであり、デスクトップウェブサイトの82%（モバイルでは80%）が少なくとも1つのサードパーティトラッカーを含んでいることがわかります。オンラインでのユーザーの行動を追跡することにより、これらの追跡会社はユーザーのプロファイルを作成することができ、これはパーソナライズされた広告に使用されるほか、ウェブサイトの所有者に誰が彼らのウェブサイトを訪問しているかの洞察を与えた

### サードパーティによる追跡

オンライン追跡の最も一般的な形態の一つは、サードパーティのサービスを通じて行われます。通常、ウェブサイトの所有者は、サイトの分析を提供したり、訪問者に広告を表示するためのサードパーティのクロスサイトスクリプトを含めます。このスクリプトはサードパーティのクッキーを設定し、ユーザーが訪れたウェブサイトを記録することができます。ユーザーが同じサードパーティサービスを含む別のウェブサイトを訪問するたびに、このクッキーはトラッカーに送信され、彼らはユーザーを再識別し、両方のウェブサイト訪問を同じプロファイルにリンクすることができます。

含まれているサードパーティサービスの種類は多少異なりますが、それによってウェブサイト訪問者を追跡する機能が暗黙のうちに与えられています。そのようなトラッカーの2つの最も一般的なカテゴリは、[WhoTracks.meによって定義されているように](https://whotracks.me/blog/tracker_categories.html)、サイト分析スクリプト（モバイルで68％、デスクトップで73％）と広告（モバイルで66％、デスクトップで68％）です。これらに続いて、追跡と明確なリンクがないかもしれないいくつかのカテゴリがあります。例えば、顧客対話（顧客がウェブサイトの所有者に簡単にメッセージを送ることを可能にするサービス）、オーディオ/ビデオプレイヤー（例えば、YouTube埋め込みビデオ）、ソーシャル（例えば、Facebookの「いいね！」ボタン）などです。

{{ figure_markup(
  image="most-common-trackers.png",
  caption="最も一般的なトラッカー。",
  description="ウェブページ上のトラッカーの普及を示す棒グラフ。Googleアナリティクス（サイト分析）はデスクトップサイトの65％とモバイルサイトの60％で見られ、Google（広告）はそれぞれ51％と49％、DoubleClick（広告）は50％と46％、Facebook（広告）は30％と28％、Google Adservices（広告）は23％と21％、Google Syndication（広告）は12％、WordPress統計（サイト分析）はモバイルとデスクトップの両方で6％、Twitter（ソーシャルメディア）は6％と5％、Adobe Audience Manager（広告）は5％と6％、そして最後にRubicon（広告）はモバイルとデスクトップサイトの両方で5％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=951980374&format=interactive",
  sheets_gid="944492219",
  sql_file="most_common_trackers.sql",
  width=600,
  height="524"
  )
}}

トラッカーがユーザーのプロファイルを成功裏に作成するためには、多くのウェブサイトに含まれる必要があります。このようにしてユーザーのオンライン活動のかなりの部分を追跡することができます。最も一般的なトラッカーを見ると、これらは主に「いつもの容疑者」です。トップ10の最も一般的なトラッカーのうち、5つはGoogleに関連しています。このリストには、FacebookやTwitterなどの人気のソーシャルネットワークも含まれています。

{{ figure_markup(
  image="number-of-trackers-per-site.png",
  caption="ウェブサイトごとのトラッカーの数。",
  description="モバイルとデスクトップサイトの両方で1から20のトラッカーまでの範囲のウェブサイトごとのトラッカーの数を示す折れ線グラフ。約15％のサイト（デスクトップおよびモバイルの両方）が1つのトラッカーを含んでいます。折れ線グラフは10個のトラッカーを持つサイトの割合が1％未満になるまで線形に減少します。グラフの残りの部分は、より多くのトラッカーを持つサイトの割合が低い長い尾を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1803959066&format=interactive",
  sheets_gid="1992611959",
  sql_file="number_of_websites_with_nb_trackers.sql"
  )
}}

ウェブサイトは複数のサードパーティサービスを利用したいかもしれませんので、そのウェブサイトには複数のトラッカーが含まれることがあります（詳細については、ウェブ上に含まれるサードパーティに関する[サードパーティ](./third-parties)章をぜひご覧ください！）。私たちは、デスクトップサイトの約15％とモバイルサイトの16％が「ちょうど」1つのトラッカーを含んでいることを発見しました。残念ながら、これはウェブサイトが複数のトラッカーを含むことがより一般的であることを意味します。私たちは126個の異なるトラッカーを含むウェブサイトさえ見つけました！

### (再)ターゲティング

{{ figure_markup(
  image="retargeting-services.png",
  caption="最も一般的なリターゲティングサービス。",
  description="特定のリターゲティングサービスを含むページの割合を示す棒グラフ。Criteoはデスクトップで2.04％、モバイルサイトで1.98％で見られ、Yahoo広告は0.44％と0.54％、AdRollは0.34％と0.49％、OptiMonkは0.09％と0.11％、SharpSpring Adsは0.08％と0.12％でした。チャートの残りのエントリーは0.10％未満の普及率を持っています。これらはAlbacross、Smarter Click、Blue、SteelHouse、Cross Pixel、Linx Impulse、およびPicreelです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=2098143733&format=interactive",
  sheets_gid="96406513",
  sql_file="number_of_websites_using_each_retargeting.sql",
  width=600,
  height="454"
  )
}}

ウェブを閲覧していると、最近調べた製品の広告に遭遇することがよくあります。その理由は広告のリターゲティングにあります。ウェブサイトがユーザーが特定の製品に興味を持っているかもしれないと検出すると、トラッカーや広告主にこれを報告し、後にユーザーが他の関連性のないウェブサイトを訪問する際に、ユーザーが興味を持っているとされる製品の広告を表示し、それによって購入へと誘導しようとします。

純粋にリターゲティングサービスを提供するトラッカーで最も普及しているのはCriteoで、デスクトップで1.98％、モバイルで2.04％の普及率を持っています。それに続くのはYahoo広告とAdRollで、合わせてCriteoの市場シェアの半分以下です。[昨年](../2021/privacy)の最も広く使用されていたリターゲティングサービスであるGoogleタグマネージャーは、今回の結果には表示されていません。これは現在「タグマネージャー」のWappalyzerカテゴリに分類されているためです。このサービスはリターゲティングに使用されますが、リターゲティングタグの含まれることによって間接的に行われ、それらのタグは別々に検出されます。

### サードパーティクッキー

前述の通り、異なるウェブサイト間でユーザーを追跡する最も確立された方法はサードパーティクッキーを使用することです。ブラウザのポリシーの最近の変更により、クッキーはデフォルトでクロスサイトリクエストに含まれなくなります。技術的な用語では、ほとんどのブラウザがクッキーの`SameSite`属性をデフォルト値の`Lax`に設定します。ウェブサイトはこれを明示的に自ら設定することで上書きすることができます。これは大規模に行われており、`SameSite`クッキーを設定するサードパーティクッキーの98％が`None`の値を設定しており、クロスサイトリクエストに含まれることを可能にしています。さらに、クッキーの有効期限もその有効期間を決定します。クッキーの中央値の寿命は365日です。クッキーとクッキー属性についての詳細は、[セキュリティ](./security#クッキー)章を参照してください。

{{ figure_markup(
  image="cookie-origins.png",
  caption="トラッカーによって設定されたクッキーの上位10の発生元。",
  description="クロスサイトクッキーを設定する異なる発生元の普及を示す棒グラフ。doubleclick.netによって設定されたクッキーは、それぞれデスクトップで26.3％、モバイルで24.1％のサイトで見られます。facebook.comの場合、モバイルで18.9％、デスクトップで17.5％でした。youtube.comによって設定されたクッキーは、モバイルで9.7％、デスクトップで8.7％のサイトで見られます。google.comは6.4％と6.0％、yandex.ruは4.3％と4.9％、linkedin.comは4.1％と3.2％、adsrvr.orgは4.0％と3.8％、pubmatic.comは4.0％と4.9％、yahoo.comは3.9％と3.6％、bing.comは3.8％と2.8％、そして最後にrubiconproject.comによって設定されたクッキーはデスクトップで3.7％、モバイルで3.3％のサイトで見られます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=852543503&format=interactive",
  sheets_gid="1010563596",
  sql_file="top100_domains_that_set_cookies_via_response_header.sql",
  width=600,
  height="429"
  )
}}

大部分において、クッキーを設定するサードパーティのトラッカーはウェブサイトに含まれるサードパーティと一致しています。しかし、最も人気のあるサードパーティのトラッカーであるGoogleアナリティクスはここではそれほど普及していません。これは、Googleアナリティクスがファーストパーティクッキー（`_ga`）を設定し、それが[彼らの定義](https://policies.google.com/technologies/cookies?hl=en-US)によると「特定のプロパティに固有であるため、関連性のないウェブサイト間で特定のユーザーやブラウザを追跡するために使用することはできません」とされているためです。それにもかかわらず、サードパーティクッキーを設定する最も一般的な追跡ドメインは、依然としてGoogleに関連する`doubleclick.net`です。リスト上の他のドメインはソーシャルメディアと広告に関連しています。

{{ figure_markup(
  image="most-common-cookies.png",
  caption="トラッカーによって設定された上位10のクッキー。",
  description="クロスサイトクッキーの普及を示す棒グラフで、クッキー名でグループ化されています。doubleclick.netによって設定された`test_cookie`という名前のクッキーは、それぞれデスクトップサイトの26％とモバイルサイトの24％で見られます。facebook.comによって設定された`fr`は19％と17％、doubleclick.netによって設定された`IDE`は12％と12％、youtube.comによって設定された`YSC`は10％と9％、`VISITOR_INFO1_LIVE`は10％と8％、yandex.ruによって設定された`sync_cookie_csrf`は4％と5％、yandex.comによって設定された`yandexuid`は4％と5％、`yuidss`は4％と5％、`i`は4％と5％、そして最後にyandex.comによって設定された`ymex`は4％と5％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1506966442&format=interactive",
  sheets_gid="1112448573",
  sql_file="top100_cookies_set_from_header.sql"
  )
}}

最も一般的なサードパーティクッキーを見ると、再びいくつかの追跡ドメインが現れます。`doubleclick.net`からの`test_cookie`が先導しており、これは機能目的で使用されるクッキーで、寿命は15分です。このクッキーに続いて、`facebook.com`によって設定された`fr`クッキーがあります。これは「広告の配信、測定、および関連性の向上のために使用されるクッキーで、寿命は90日です」と[その定義](https://www.facebook.com/policy/cookies/)によるとされています。最も普及している10個のサードパーティクッキーの残りはYouTubeとYandexによって設定されています。

### 回避技術：フィンガープリンティング

{{ figure_markup(
  image="fingerprinting-services.png",
  caption="フィンガープリンティングサービスの使用状況。",
  description="フィンガープリンティングサービスの普及を示す棒グラフ。FingerprintJSのフィンガープリンティングスクリプトは、それぞれデスクトップで0.62％、モバイルサイトで0.73％で見つかりました。ClientJSは0.04％と0.04％で検出され、MaxMindは0.03％と0.04％、TruValidateは0.02％と0.03％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=79170171&format=interactive",
  sheets_gid="1069316937",
  sql_file="number_of_websites_using_each_fingerprinting.sql"
  )
}}

クッキーベースのトラッキングに対する対策が増えるにつれて、サードパーティクッキーのブロックをユーザーがより制御できるようになる中、一部のトラッカーはこれらの保護を回避しようとします。その一つの技術がフィンガープリンティングで、ブラウザ固有の機能（例：インストールされたブラウザ拡張機能）、OS固有の機能（例：インストールされたフォント）、ハードウェア固有の機能（例：使用されているGPUに基づく複雑な構成のレンダリングの違い）を利用してユーザーのユニークなフィンガープリントを作成します。このフィンガープリントにより、トラッカーは異なる関連性のないウェブサイト間で同じユーザーを再識別することができます。

私たちの分析では、5つの異なる、知られているフィンガープリンティングライブラリを調べ、ウェブ上でフィンガープリンティングを実行するために最も普及しているライブラリは[FingerprintJS](https://github.com/fingerprintjs/fingerprintjs)であり、全てのウェブサイトの0.62％で見つかりました。これはライブラリがオープンソースで、無料版があるためであると考えられます。[昨年の測定](../2021/privacy)と比較して、フィンガープリンティングの使用はほぼ変わっていないことがわかります。

### 回避技術：CNAMEトラッキング

ほとんどのトラッキング対策がサードパーティクッキーのブロックまたは無効化に焦点を当てている中、これらの保護を回避するもう一つの方法は、ファーストパーティクッキーを代わりに使用することです。ここでは、トラッカーがウェブサイトのサブドメインにCNAMEレコードを使用して偽装されます。トラッカーがクッキーを設定すると、それはファーストパーティクッキーと見なされます。CNAMEベースのトラッキングの制限は、特定のウェブサイト内でのユーザーの活動のみを追跡できるという点ですが、トラッカーはまだ[cookie syncing](https://adtechexplained.com/cookie-syncing-explained/)を利用して複数のサイト間の訪問を一致させることができます。

{{ figure_markup(
  image="cname-tracking-services.png",
  caption="上位5つのCNAMEトラッキングサービス。",
  description="CNAMEトラッカーの普及を示す棒グラフ。Adobe Experience Cloudはそれぞれデスクトップで0.65％、モバイルサイトで0.38％で見つかりました。Pardotは0.44％と0.25％、Oracle Eloquaは0.06％と0.03％、Act-On Softwareは0.05％と0.03％、Webtrekkは0.02％と0.01％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=118406352&format=interactive",
  sheets_gid="1717363829",
  sql_file="nb_sites_with_cname_tracking.sql"
  )
}}

さまざまなCNAMEトラッカーを分析すると、市場シェアは主に2つの主要サービス、Adobe Experience Cloud（デスクトップで0.65％、モバイルで0.38％）とPardot（デスクトップで0.25％、モバイルで0.44％）に集中していることがわかります。興味深いことに、CNAMEトラッキングの採用はモバイルで訪問されたウェブサイトよりもデスクトップブラウザで訪問されたウェブサイトで著しく高いです。これは、モバイルブラウザにはプライバシーを保護するメカニズムが少ないためと思われます。たとえば、モバイルの人気ブラウザのほとんどは拡張機能をサポートしていません。

{{ figure_markup(
  image="cname-tracking-by-rank.png",
  caption="ウェブサイトランク別のCNAMEトラッキングの使用状況。",
  description="ランク別の異なるグループでCNAMEトラッカーの普及を示す棒グラフ。1,000位までのサイトでは、デスクトップで6.2％、モバイルで5.8％がCNAMEトラッキングを使用しています。10,000位まででは5.9％と5.3％、100,000位まででは2.9％と2.7％、1,000,000位まででは1.3％と1.2％、そしてすべてのサイトをカバーするカテゴリでは、デスクトップで0.9％、モバイルで0.5％の普及率があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=213195774&format=interactive",
  sheets_gid="303099519",
  sql_file="nb_sites_with_cname_tracking_per_rank.sql"
  )
}}

CNAMEベースのトラッキングの全体的な普及率は非常に高くはないかもしれません（デスクトップウェブサイトで0.9％、モバイルサイトで0.5％）が、その採用は主に非常に人気のあるウェブサイトに集中しています。訪問されたウェブサイトのトップ1,000では、デスクトップサイトの6.2％とモバイルサイトの5.8％がCNAMEトラッカーを組み込んでいます。これは、ユーザーがウェブを閲覧する際にこのようなトラッカーに遭遇する可能性が高いことを意味します。

## ブラウザからの（機密）データへのアクセス

ブラウザには数多くのAPIがあり、開発者がさまざまなコンポーネントと任意の方法でやり取りするための便利なメカニズムを提供しています。これらのAPIのいくつかは、ユーザーのデバイスに接続されているセンサーやその他の周辺機器から情報を抽出するためにも使用できます。ほとんどのAPIは限定的な情報（例えば、画面の向き）を提供しますが、他のAPIは非常に詳細な情報（例えば、加速度計やジャイロスコープ）を提供し、これをデバイスのフィンガープリンティングや、モバイルデバイスで行う動作に基づいてユーザーが入力するパスワードを推測するために使用することができます。

### センサーイベント

{{ figure_markup(
  image="sensor-events.png",
  caption="使用されている主なデバイスセンサーイベント。",
  description="特定のセンサーイベントを使用しているウェブサイトの割合を示す棒グラフ。`deviceOrientation`イベントはデスクトップで4.04％、モバイルで4.10％のサイトで使用されており、`deviceReady`は1.16％と1.28％、`devicemotion`は0.78％と0.72％、`deviceChange`は0.29％と0.28％、最後に`deviceproximity`イベントはデスクトップで0.03％、モバイルで0.02％のサイトで見られました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=2114701877&format=interactive",
  sheets_gid="217371442",
  sql_file="number_of_websites_with_device_sensor_events.sql"
  )
}}

ウェブサイトが最も注目しているセンサーイベントは`deviceOrientation`イベントであり、デバイスがポートレートモードからランドスケープモードに変わる、またはその逆の場合に発生します。デスクトップウェブサイトの4.0％、モバイルウェブサイトの4.1％で使用されています。使用率が（比較的）高いのは、デバイスの向きが変わるとウェブサイトがレイアウトの要素を更新したいと考えるかもしれないからです。

### メディアデバイス

{{ figure_markup(
  caption="メディアデバイスを列挙するデスクトップページの割合。",
  content="0.59％",
  classes="big-number",
  sheets_gid="1554147968",
  sql_file="number_of_websites_with_device_sensor_blink_usage.sql"
)
}}

[MediaDevices API](https://developer.mozilla.org/ja/docs/Web/API/MediaDevices)を使用すると、ウェブ開発者は`enumerateDevices()`メソッドを使ってユーザーのデバイスに接続されているすべてのメディアデバイスのリストを取得できます。この機能は、ビデオ通話を開始するためにユーザーがカメラやマイクロフォンを接続しているかどうかを判断するのに便利ですが、フィンガープリンティング目的でシステムの環境に関する情報を収集するためにも使用されることがあります。デスクトップウェブサイトの0.59％、モバイルサイトの0.48％が接続されているメディアデバイスのリストにアクセスしようとしていることがわかります。興味深いことに、[このAPIの使用は昨年以来かなり減少しています](../2021/privacy#メディアデバイス)。メディアデバイスのリストにアクセスするサイトの普及率は12倍高かったです。これはおそらく、もはやAPIを呼び出さない人気のあるライブラリが原因です。

### ジオロケーション

{{ figure_markup(
  image="gelocation-services.png",
  caption="最も一般的なジオロケーションサービス。",
  description="ウェブサイトがジオロケーションサービスを使用している割合を示す棒グラフ。ジオロケーションサービスipifyはデスクトップサイトの0.083％、モバイルサイトの0.115％で見つかりました。MaxMindは0.029％と0.044％、IPinfoは0.003％と0.005％、最後にGeo Targetlyは0.002％と0.002％で検出されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1039516482&format=interactive",
  sheets_gid="1999414939",
  sql_file="number_of_websites_using_each_geolocation.sql"
  )
}}

私たちがウェブサイトを訪れる場所に基づいてローカライズされたコンテンツが多く提供されています。ウェブ開発者が訪問者の位置を特定するためには、サードパーティのジオロケーションサービスを利用できます。これらはIPアドレスに基づいてユーザーの位置を特定します。このジオロケーションは通常バックエンドで使用されますが、フロントエンドでもいくつかの使用例が見られます：デスクトップサイトの0.115％とモバイルサイトの0.083％が、ユーザーのIP位置を特定するためにipifyに連絡しています。


{{ figure_markup(
  caption="ブラウザのジオロケーションにアクセスしようとするデスクトップページの割合。",
  content="0.65%",
  classes="big-number",
  sheets_gid="1213448832",
  sql_file="number_of_websites_with_geolocation.sql"
)
}}

IPベースのジオロケーションサービスは、特にユーザーがVPNを利用して元のIPアドレスを隠している場合には正確でないことがあります。そのため、ウェブサイトはより詳細な位置情報を[ジオロケーションAPI](https://developer.mozilla.org/ja/docs/Web/API/Geolocation_API)を通じて要求することがあります。もちろん、この（プライバシー侵害的な）APIへのアクセスは、ユーザーが手動で提供する必要がある許可によって守られています。それでも、デスクトップサイトの0.65％とモバイルサイトの0.61％がホームページを訪れた際に、ユーザーの現在の位置情報にアクセスしようとしています。興味深いことに、安全でない接続でページがロードされた際にこの機能にアクセスしようとする574のデスクトップサイトを発見しました（昨年は900サイトでした）。この機能が提供するデータの性質がデリケートであるため、ほとんどのブラウザは安全な起源での使用に制限を設けています。

## 訪問者のプライバシーを改善するための確立されたコントロール

ウェブサイトは完全に信頼していないサードパーティ（スクリプト、プラグインなど）から多くのコンテンツを含むため、これらのサードパーティからユーザーのプライバシーを保護することが望まれます。次に、サードパーティがアクセスできる機能やデータを制限するために使用できるさまざまなコントロールを探ります。また、ウェブサイトがユーザーからどの情報を取得したいかを明確にする方法も調査します。

### パーミッションポリシー

{{ figure_markup(
  image="permissions-policy-type.png",
  caption="APIタイプ別のパーミッションポリシーの使用状況。",
  description="ウェブサイトがパーミッションポリシーまたはフィーチャーポリシーを使用している割合を示す棒グラフ。フィーチャーポリシーAPIはデスクトップで0.69％、モバイルで0.52％のサイトで使用されており、パーミッションポリシーAPIはデスクトップで2.7％、モバイルで2.3％のサイトで見られ、合計でデスクトップで3.3％、モバイルで2.7％のサイトがポリシーを設定することでサイトでサポートされる機能を制御しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1921531833&format=interactive",
  sheets_gid="741173570",
  sql_file="number_of_websites_with_permissions_policy.sql"
  )
}}

デフォルトでは、サードパーティのスクリプトは、組み込まれているウェブサイトと同じブラウザ機能にアクセスできます。ウェブサイトが有効にする機能を制限するために、ウェブサイトは[パーミッションポリシー](https://developer.chrome.com/docs/privacy-securitypermissions-policy?hl=ja)を利用できます。HTTPレスポンスヘッダーを通じて、ウェブサイトはどの機能を許可するかを示すことができます。例えば、`microphone`機能がこのリストに含まれていない場合、ウェブページに組み込まれているスクリプトはそれを使用することができません。このポリシーは比較的新しいものですが、デスクトップサイトの2.71％、モバイルサイトの2.31％で採用が見られます。

パーミッションポリシーは、[フィーチャーポリシー](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Permissions-Policy)を置き換えるもので、デスクトップサイトの0.69％、モバイルサイトの0.52％で依然として見られます。
デフォルトでは、パーミッションポリシーによって規制されるほとんどの機能は、クロスオリジンのiframeで無効になっていますが、`allow`属性を通じて明示的に有効にすることができます。デスクトップサイトの15.18％、モバイルサイトの14.32％がこの機能を利用しています。iframe上の`allow`属性の使用に関する詳細な分析については、[セキュリティ](./security#パーミッションポリシー　)章を参照してください。

{{ figure_markup(
  image="permission-policy-features.png",
  caption="最も一般的なパーミッションポリシー機能名。",
  description="最も一般的なパーミッションポリシー機能を示す棒グラフ。パーミッションポリシーの`interest-cohort`機能は、それぞれデスクトップで1.18％、モバイルで0.93％のサイトに存在し、`geolocation`機能は0.80％と0.58％のサイトで指定されています。`microphone`は0.78％と0.57％、`camera`は0.75％と0.55％、`payment`は0.57％と0.42％、`gyroscope`は0.54％と0.40％、`magnetometer`は0.54％と0.39％、`fullscreen`は0.47％と0.34％、`usb`は0.45％と0.33％、そして最後に`accelerometer`はデスクトップで0.44％、モバイルで0.32％に定義されていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1803269356&format=interactive",
  sheets_gid="315730924",
  sql_file="most_common_permissions_policy_directives.sql",
  width="600",
  height="448"
  )
}}

パーミッションポリシーで使用されるディレクティブを見ると、[昨年](../2021/privacy)と比較して類似の使用状況が見られますが、2022年に最も広く使用されたのは`interest-cohort`ディレクティブです。このディレクティブは、現在は機能していないFLoC APIへのアクセスを制限するために使用されます。この増加は、FLoCのさまざまな欠点（フィンガープリンティングの表面を増加させる、ユーザーについての潜在的にセンシティブな情報を明らかにするなど）に対し、ウェブサイトの所有者や提供者、ライブラリがユーザーのプライバシーを保護するために積極的な対策を講じたためと思われます。

### リファラーポリシー

{{ figure_markup(
  caption="ドキュメント全体のリファラーポリシーを設定するデスクトップサイトの割合。",
  content="12％",
  classes="big-number",
  sheets_gid="1186623225",
  sql_file="number_of_websites_with_referrerpolicy.sql"
)
}}

デフォルトでは、ほとんどのユーザーエージェントは`Referer`ヘッダーを含めます。簡単に言うと、これは第三者に対して、どのウェブサイトやページからリクエストが開始されたかを明らかにします。これはウェブページに埋め込まれたリソースに対しても、リンクをクリックした後に開始されたリクエストに対しても当てはまります。もちろん、これは望ましくない副作用として、これらの第三者が特定のユーザーが訪れていたウェブサイトやウェブページを知ることができるというものです。[リファラーポリシー](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Referrer-Policy)を利用することで、ウェブサイトは`Referer`ヘッダーがリクエストに含まれるインスタンスを制限し、ユーザーのプライバシーを改善することができます。私たちは、12％のデスクトップサイトと10％のモバイルサイトが、主にHTTPレスポンスヘッダーを介して、そのようなドキュメント全体のポリシーを設定していることを発見しました。

{{ figure_markup(
  image="referrer-policies.png",
  caption="最も一般的なリファラーポリシー。",
  description="ウェブサイトによって定義されたリファラーポリシーを示す棒グラフ。ポリシー`no-referrer-when-downgrade`はデスクトップで4.33％、モバイルで3.70％のサイトで見つかりました。`strict-origin-when-cross-origin`はデスクトップで2.68％、モバイルで2.14％、`always`は1.07％と0.53％、`unsafe-url`は0.64％と0.71％、`same-origin`は0.74％と0.60％、`origin`は0.41％と0.57％、`no-referrer`は0.44％と0.33％、`origin-when-cross-origin`は0.37％と0.32％、`strict-origin`は0.32％と0.25％、そして最後に`no-referrer, strict-origin-when-cross-origin`はデスクトップで0.11％、モバイルで0.09％のサイトで見つかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=2062222912&format=interactive",
  sheets_gid="1353802246",
  sql_file="most_common_referrer_policy.sql",
  width=600,
  height="473"
  )
}}

リファラーポリシーの使用状況を見ると、`Referer`ヘッダーをダウングレードリクエストに含めないことが最も一般的です。つまり、HTTPSが有効なページで開始されたHTTPリクエストには含まれません。残念ながら、これはほとんどのシナリオでHTTPSリクエストにおいてユーザーが訪れたページが漏れることを意味します。しかし、デスクトップサイトの2.7％とモバイルサイトの2.1％が`strict-origin-when-cross-origin`ポリシーを用いて、ユーザーが訪れた具体的なウェブページを隠そうとしています。これは現在、ポリシーが指定されていない場合のほとんどのブラウザのデフォルトです。

### ユーザーエージェント・クライアント・ヒント

ブラウザ環境に関する情報、特に`User-Agent`文字列について公開される情報を減らすために、[User-Agent Client Hints](https://wicg.github.io/ua-client-hints/)メカニズムが導入されました。この機能を通じて、ユーザーのブラウジング環境（ブラウザのバージョン、オペレーティングシステムなど）について特定の情報を取得したいウェブサイトは、最初のレスポンスでヘッダー（`Accept-CH`）を設定する必要があります。これにより、ブラウザは後続のリクエストで要求されたデータを送信します。この機能は、フィンガープリンティングの表面を減らす他、ブラウザが特定のデータの送信を介入することを可能にします（例えば、[Privacy Budget](https://github.com/mikewest/privacy-budget)提案を通じて）。

{{ figure_markup(
  image="client-hints-by-rank.png",
  caption="ランクグループ別のクライアントヒントを使用するウェブサイトの数。",
  description="1,000から1,000,000までのランクグループと、すべてのサイトをカバーする別のカテゴリで、ユーザーエージェント・クライアント・ヒントを使用しているウェブサイトの普及を示す棒グラフ。トップ1,000のサイトでは、デスクトップで9.53％、モバイルで9.11％がクライアントヒントを有効にしており、トップ10,000ではデスクトップで3.14％、モバイルで3.12％、トップ100,000では1.02％と1.05％、トップ1,000,000では0.38％と0.39％、全体ではデスクトップで0.31％、モバイルで0.56％がクライアントヒントを使用していました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=318395619&format=interactive",
  sheets_gid="1199573159",
  sql_file="number_of_websites_with_client_hints.sql"
  )
}}

昨年（トップ1k：3.56％、トップ10k：1.44％）と比較して、`Accept-CH`ヘッダーで応答するサイトの採用を見ると、特に最も人気のあるサイトでの採用がほぼ3倍に増加しています。この採用の増加は、Chromiumが`User-Agent`文字列で共有される情報を減らしている事実（[User-Agent Reduction plan](https://www.chromium.org/updates/ua-reduction/)を通じて）に関連していると考えられます。

ユーザーエージェント・クライアント・ヒントを利用するサイトは、一般的に比較的多くのプロパティへのアクセスを要求しており、ブラウザがUser-Agent Reductionなどの努力を通じて達成しようとしている利益を制限しています。近い将来、ブラウザがユーザーのブラウジング環境に関する多くの情報を取得する慣行をどのように制限するかを見るのが興味深いでしょう。

## ブラウザによるプライバシーの改善のための新たな取り組み

過去数年間で、一般のウェブユーザーはオンラインでのプライバシーに対してますます意識が高まっています。一方で、ますます大きくなるデータ漏洩が頻発しており、ほとんどの人が影響を受けていません。また、サードパーティクッキーを通じたユーザーの広範な追跡が一般によく知られるようになっています。その結果、ますます多くのユーザーが自分のブラウザにプライバシーを保護し、オンライン行動の追跡をより制御することを期待しています。ブラウザベンダー、オンラインパブリッシャー、広告技術会社は、プライバシーの改善に対するこの需要を聞き、Google Chromeが主導するプライバシーサンドボックスというイニシアチブを提案しています。

### プライバシーサンドボックスオリジントライアル

本年のWeb Almanacの公開時点では、プライバシーサンドボックスの機能は一般に利用可能ではありません。しかし、ウェブサイトやウェブサービス（例えば、iframe内で表示される広告など）は、[オリジントライアル](https://developers.google.com/privacy-sandbox/blog/privacy-sandbox-unified-origin-trial?hl=ja)を利用してプライバシーサンドボックス機能の初期テストに参加することができます。この機能をサポートしているブラウザを使用しているユーザーに限ります—プライバシーサンドボックス機能はChromeにのみ実装されており、この記事の執筆時点ではデフォルトで無効になっています。これにより、ウェブサービスはプライバシーサンドボックス関連のAPIである[Topics](https://developers.google.com/privacy-sandbox/relevance/topics/developer-guide?hl=ja)、[FLEDGE](https://developers.google.com/privacy-sandbox/relevance/protected-audience?hl=ja)、および[Attribution Reporting](https://developers.google.com/privacy-sandbox/relevance/attribution-reporting?hl=ja)にアクセスできます。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能を要求するオリジン</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>https://www.googletagmanager.com</td>
        <td class="numeric">12.53%</td>
        <td class="numeric">10.99%</td>
      </tr>
      <tr>
        <td>https://googletagservices.com</td>
        <td class="numeric">11.05%</td>
        <td class="numeric">10.52%</td>
      </tr>
      <tr>
        <td>https://doubleclick.net</td>
        <td class="numeric">11.04%</td>
        <td class="numeric">10.51%</td>
      </tr>
      <tr>
        <td>https://googlesyndication.com</td>
        <td class="numeric">11.04%</td>
        <td class="numeric">10.51%</td>
      </tr>
      <tr>
        <td>https://googleadservices.com</td>
        <td class="numeric">2.50%</td>
        <td class="numeric">2.29%</td>
      </tr>
      <tr>
        <td>https://s.pinimg.com</td>
        <td class="numeric">1.49%</td>
        <td class="numeric">1.21%</td>
      </tr>
      <tr>
        <td>https://criteo.net</td>
        <td class="numeric">0.64%</td>
        <td class="numeric">0.41%</td>
      </tr>
      <tr>
        <td>https://criteo.com</td>
        <td class="numeric">0.59%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>https://imasdk.googleapis.com</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td>https://teads.tv</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="プライバシーサンドボックスAPIオリジントライアルにアクセスを要求するオリジンの普及率。",
      sheets_gid="1410031518",
      sql_file="number_of_websites_with_origin_trial_from_token.sql",
    ) }}
  </figcaption>
</figure>

プライバシーサンドボックスのオリジントライアル中にテストを行うウェブ上で最も普及しているサービスは、Google Tag Manager、Doubleclick、Google Syndication、そしてGoogle Ad Servicesです。これらはデスクトップとモバイルサイトの両方でトップ5に入っています。これに続くのはソーシャルメディアサイトのPinterestや、他のトラッカーや広告主であるCriteo、Google Ads SDK、Teadsです。

### プライバシーサンドボックス実験

プライバシーサンドボックスイニシアティブは、さまざまな側面に関わる多くの異なる機能で構成されており、サードパーティクッキーが段階的に廃止される際に、ユーザーがウェブ上で行う一般的なアクションを依然としてサポートすることを目指しています。ほとんどの機能はまだ積極的に開発中であり、ウェブサイトがそれらを採用しているわけではありません（`PrivacySandboxAdsAPIs`オリジントライアルにオプトインしているサービスを除く）。

一時期、プライバシーサンドボックス機能のオリジントライアルは、各機能ごとに分けられていました。これらの試用は現代のブラウジング環境では効果がありませんが、一部のウェブサービスはそれらにオプトインし、`Origin-Trial`レスポンスヘッダーの削除を忘れていました。

例えば、34,128のサイトでウェブサービスが`ConversionMeasurement`オリジントライアルにオプトインしているのが見られます。このトライアルは、かつて[Attribution Reporting API](https://developers.google.com/privacy-sandbox/relevance/attribution-reporting?hl=ja)（以前はConversion Measurement APIと呼ばれていました）へのアクセスを提供していました。このAPIは、例えば広告をクリックしたユーザーの購入への変換を追跡するために使用されます。

また、有効期限が切れている[TrustTokens](https://developers.google.com/privacy-sandbox/protections/private-state-tokens?hl=ja)オリジントライアルにも、まだ6,005のサイトでウェブサービスがオプトインしています。このメカニズムは、一つのブラウジングコンテキスト（例えば、サイト）が別のコンテキストに限定された情報を伝達することを可能にすることで、詐欺と戦うことを目的としています。

興味深いことに、30,000以上のウェブサイトで、ウェブサービスがユーザーの興味グループのFLoCへのアクセスを提供する`InterestCohort`オリジントライアルにまだオプトインしています。しかし、APIのプライバシー上の懸念から、この取り組みは追求されなくなり、開発は中止されました。これに取って代わるのは、リマーケティングやカスタムオーディエンスのための「デバイス上での広告オークションを提供する」[FLEDGE API](https://developers.google.com/privacy-sandbox/relevance/protected-audience?hl=ja)と、クロスサイト追跡を必要とせずにユーザーの興味に基づいて広告を配信することを目的とする[Topics API](https://developers.google.com/privacy-sandbox/relevance/topics/developer-guide?hl=ja)です。

## プライバシー規制への準拠

データプライバシー規制の領域は立法の最新のフロンティアとして拡大し続けています。これらの規制は、組織に対してユーザーのデータ処理についてより透明性を持たせ、そのデータを保護することを要求しています。[一般データ保護規則（GDPR）](https://data.consilium.europa.eu/doc/document/ST-9565-2015-INIT/en/pdf)や[IABの透明性と同意フレームワーク（TCF）v2.0](https://www.iabeurope.eu/)などの重要なデータプライバシー規制の登場を受けて、ウェブサイト提供者は訪問中に処理されるデータについてユーザーに情報を提供し、追跡や広告など非機能的な目的でのデータ処理についてもこれらのユーザーから同意を得るために行動を起こしました。これにより、ウェブサイト提供者が主に（クッキー）同意バナーを通じてユーザーに通知したり同意を求めたりするため、ウェブサイト上でクッキーバナーをより頻繁に見るようになりました。

ほとんどの場合、ユーザーはこのような同意バナーと対話し、どのデータを処理するかを設定することができます。しかし、ますます複雑になる現代の洗練されたウェブ上でこのようなタスクを管理することは容易ではありません。このため、ウェブサイト運営者はこのタスクをサードパーティであるいわゆる同意管理プラットフォーム（CMP）に委ねようとしています。CMPは、該当するウェブサイト上でクッキーが法律に従って使用されることを保証します。次に、CMPの使用とプライバシーポリシーの通知について議論します。

### 同意管理プラットフォーム（CMP）

すでに議論したように、同意管理プラットフォーム（CMP）の使用は、特にクッキーの扱いに関して、ウェブサイトが法的に適合する方法で運用されることを保証すべきです。

この時点で、CMPサービスの統合がウェブサイトが法的に適合する状態を常に保証するわけではないことも指摘しておくべきです。この分野の研究（例えば、[Santos et al.](https://arxiv.org/abs/2104.06861)や[Fouad et al.](https://ieeexplore.ieee.org/document/9229842)）が示しています。

{{ figure_markup(
  image="cmp-services.png",
  caption="最も一般的な同意管理プラットフォーム（CMP）サービス。",
  description="最も一般的なCMPサービスを示す棒グラフ。CookieYesのCMPサービスは、それぞれデスクトップで2.0％、モバイルで2.1％のサイトで見つかりました。Osanoサービスは1.4％と1.4％、OneTrustは1.2％と0.9％、Cookiebotは1.0％と0.8％、Cookie Noticeは0.6％と0.6％、iubendaは0.5％と0.5％、Complianzは0.5％と0.5％、Moove GDPR Consentは0.4％と0.4％、Quantcast Choiceは0.4％と0.4％、最後にBorlabs Cookieは0.2％と0.3％のサイトに存在しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1774136411&format=interactive",
  sheets_gid="2107042211",
  sql_file="number_of_websites_using_each_cmp.sql"
  )
}}

私たちの分析によると、CMPの使用は昨年から11％へと7％から増加し、ほぼ60％の増加を記録しました。また、今年はモバイルよりもデスクトップの方が関与が少ないことが見て取れますが、その差は最小限です。
また、CookieYes（18％増）、OneTrust（64％増）、Cookiebot（56％増）といったプロバイダーが昨年から市場シェアを増やしていることも確認できます。

### IAB同意フレームワーク

GDPRと比較して、[IAB Europe透明性および同意フレームワーク（TCF）](https://iabeurope.eu)は、[グローバルベンダー](https://iabeurope.eu/vendor-list/)が関与する業界標準です。その目的は、ユーザーの同意と広告主との間のコミュニケーションを確立することです。TCFは、ヨーロッパのウェブサイトがGDPRに準拠していることを保証します。IAB Tech Lab USが開発した[アメリカ合衆国プライバシー技術仕様（USP）](https://iabtechlab.com/standards/ccpa/)は、TCFと同じコンセプトを使用してアメリカ合衆国向けに設計されました。

{{ figure_markup(
  image="iab-prevalence.png",
  caption="IABを使用しているウェブサイト。",
  description="最も一般的なIABフレームワークを示す棒グラフ。全体として、IABはデスクトップで4.6%、モバイルで4.4%のサイトで見られました。IAB USPはデスクトップで3.5%、モバイルで3.4%のサイトで見られ、IAB TCFはデスクトップで2.2%、モバイルで1.9%のサイトで見られました。そのうち、バージョン2はそれぞれ2.1%と1.8%、バージョン1はそれぞれ0.4%と0.3%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1149211507&format=interactive",
  sheets_gid="772029978",
  sql_file="number_of_websites_with_iab.sql"
  )
}}

デスクトップウェブサイトの4.6%で何らかのIABが使用されており、そのうち3.5%がUSPを、2.2%がIAB TCFを使用しています。これは昨年からの両仕様の使用増加を示しています。ここで注記すべきは、私たちの測定は米国ベースであるため、TCFによれば、EU外の訪問には同意バナーが必要ないため、USPを使用しているウェブサイトが多いことが理由の一つと考えられます。

{{ figure_markup(
  image="iab-tcfv2-prevalence.png",
  caption="IAB TCF v2のためのトップCMP。",
  description="IAB TCFバージョン2に対する最も一般的なCMPプロバイダーを示す棒グラフ。Quantcast International Limitedはデスクトップで0.37%、モバイルで0.33%のサイトでCMPプロバイダーとして見られ、Google LLCは0.34%と0.29%、Didomiは0.31%と0.26%でした。その他に1020, Inc. dba PlacecastおよびEricsson Emodoが0.23%と0.17%、iubendaが0.10%と0.10%、Sourcepoint Technologies, Inc.が0.07%と0.07%、そして最後にSIRDATAが0.06%と0.07%のサイトで見られました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1405483323&format=interactive",
  sheets_gid="1374296424",
  sql_file="most_common_cmps_for_iab_tcf_v2.sql",
  width="600",
  height="459"
  )
}}

Quantcast International Limited (0.37%)、Google LLC (0.34%)、およびDidomi (0.31%) がIAB TCF v2のための人気のあるCMPプロバイダーです。

{{ figure_markup(
  image="iab-publisher-countries.png",
  caption="IAB TCF v2を使用しているパブリッシャーの最も一般的な国。",
  description="IAB TCF v2を使用するパブリッシャーの最も一般的な国を示す棒グラフ。パブリッシャーの国はデスクトップで0.31%、モバイルで0.29%のサイトで不明でした。サイトの0.04%でパブリッシャーの国がドイツと設定されており、デスクトップで0.04%、モバイルで0.03%のサイトで米国と設定されていました。さらに、0.03%と0.02%で欧州連合、0.02%と0.01%のサイトでイギリスでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1828110274&format=interactive",
  sheets_gid="1272054750",
  sql_file="most_common_countries_for_iab_tcf_v2.sql"
  )
}}

私たちの分析によると、特定された最も一般的なパブリッシャーはドイツ、米国、およびEUからです。

### プライバシーポリシー

データ処理に関する通知は、同意バナーを介して行われるだけではありません。これらは通常、そのようなバナーと比較して別のページでより詳細に説明されます。このようなページでは、統合されたサードパーティ、どのデータがどの目的で処理されるかなどの情報を見つけることができます。このようなサイトを特定するために、[ある研究](https://github.com/RUB-SysSec/we-value-your-privacy/blob/master/privacy_wording.json)からのプライバシーに関連するシグネチャを使用しました。この方法を使用して、デスクトップウェブサイトの45%（モバイルでは41%）がホームページにプライバシー関連ページへのリンクを含んでいることが判明しました。以下の図は、トッププライバシーリンクキーワードの分布を示しています。

{{ figure_markup(
  image="privacy-link-keywords.png",
  caption="プライバシーリンクの主要キーワード。",
  description="ウェブサイトのプライバシーポリシーに言及するために使用される最も一般的なキーワードを示す棒グラフ。'privacy'という単語はデスクトップで28.63%、モバイルで22.95%のサイトでプライバシーポリシーへのリンクに使用され、'policy'は24.26%と19.41%のサイトで、'cookies'は8.19%と7.90%で、'cookie policy'は3.63%と3.30%で、'privacidad'は2.68%と2.99%で、'datenschutz'は2.09%と3.14%で、'mentions légales'は2.08%と1.85%で、'privacidade'は1.66%と1.76%で、'aviso legal'は1.35%と1.65%で、'prywatności'は0.97%と1.12%で、そして最後に'gdpr'は0.99%と0.94%のサイトでプライバシーポリシーへのリンクに使用されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=817391735&format=interactive",
  sheets_gid="1284713488",
  sql_file="most_common_privacy_link_keywords.sql",
  )
}}

プライバシー（29%）、ポリシー（24%）、クッキー（8%）がこのようなリンクのトップキーワードです。

## 結論

この章では、ウェブ上のオンラインプライバシーに関連するさまざまな側面を探求しました。過去1年間にプライバシーに影響を与える多くの変化があったことは明らかであり、今後もこの進展が続くことが期待されます。簡単に言うと、私たちの前には興味深い時代が広がっています。一方で、いつかウェブの遺産として参照できることを願っている不幸な進化も見つかりました。第三者トラッキングは、主に第三者クッキーによって推進され、82％以上のウェブサイトに少なくとも1つのトラッカーが含まれており、依然として普及しています。さらに、反トラッキング対策を回避するための逃避的な手法を採用しているウェブサイトやウェブサービスも少なくありません。

より前向きでプライバシーを尊重する方向で、ブラウザAPIから潜在的にセンシティブな情報にアクセスしようとするサイトが減少していることがわかります。この傾向が、定期的にブラウザに導入される新しいAPIでも続くことを願っています。

一般的に、ウェブサイトはユーザーのプライバシーを尊重するという呼びかけに応じ始めているようです。この呼びかけはますます大きくなっています。ますます多くのサイトが、第三者に送信される情報を制限するブラウザ機能を採用しています。さらに、GDPRやCCPAなどのプライバシー規制に主に動機づけられて、同意管理プラットフォーム（CMP）の採用が明確に増加しており、ユーザーが共有したい情報をよりコントロールできるようになっています。

最後に、ブラウザの側でも、オンラインプライバシーの管理を強化するための強力な進化が見られます。プライバシーに焦点を当てたいくつかのブラウザが内蔵ソリューションとして提供する機能に加えて、プライバシーサンドボックスイニシアティブも、クロスサイトトラッキングの悪影響なしに、ウェブ上での現在の機能（ターゲット広告、詐欺防止、購入の帰属など）を提供し続けることを目指しています。開発はまだかなり初期段階にありますが、多くのウェブサイトでウェブサービスがオリジントライアルにオプトインしていることが見られます。この機能は広範囲にテストされており、ウェブの恒久的な部分になる可能性が高いです。

完全にそこに到達するまでには数年かかるかもしれませんが、ユーザーがどの当事者とどの情報を共有したいかをよりコントロールできるウェブへと移行しています。この収束はスペクトルの両側で見られます：一方ではウェブサイトによって、もう一方ではブラウザによって強制されます。近い将来、私たちが共有するデータは意図したデータであり、日常的に行うウェブ上の旅が、現在遭遇している数多くのトラッカーによって収集、共有、分析される必要がなくなることを期待できます。これは、明日のための敬意を表しています。
