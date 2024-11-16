---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: 2021年版Web Almanacのプライバシー章では、オンライントラッキングの導入と影響、プライバシー優先の信号、プライバシーに配慮したWebのためのブラウザの取り組みについて取り上げています。
hero_alt: Hero image of Web Almanac characters with cameras, phones, and microphones acting like paparazzi while another character pulls back a shower curtain to reveal a web page behind it.
authors: [ydimova, victorlep]
reviewers: [maudnals]
analysts: [victorlep, max-ostapenko]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/
ydimova_bio: Yana Dimovaはimec-DistriNetの博士課程に在籍し、ウェブプライバシーについて研究しています。オンライントラッキング、プライバシーの脆弱性、プライバシーの法律と政策に関心を持ち、研究している。
victorlep_bio: Victor Le Pochatは、ベルギーのKU Leuvenの<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">imec-DistriNet</a> 研究グループの博士課程研究者である。彼の興味は、ウェブのエコシステムの探求と、ウェブのセキュリティとプライバシーの研究方法論にあり、現在の方法の分析と改良の両方に取り組んでいます。
featured_quote: FirefoxとSafariはすでにTracking Protectionを導入しており、Chromeは新しいプライバシー保護技術を提案し、オープンな場で議論し、ウェブサイトの所有者がテストすることができるようにしています。
featured_stat_1: 82.08%
featured_stat_label_1: 少なくとも1つのトラッカーを含むモバイルサイト
featured_stat_2: 39.70%
featured_stat_label_2: プライバシーポリシーリンクを含むモバイルサイト
featured_stat_3: 4.10%
featured_stat_label_3: FLoCコホートからのオプトアウトを行う人気サイト
---

## 序章

[_インターネットでは、あなたが犬であることを誰も知らない_](https://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%8D%E3%83%83%E3%83%88%E4%B8%8A%E3%81%A7%E3%81%AF%E3%81%82%E3%81%AA%E3%81%9F%E3%81%8C%E7%8A%AC%E3%81%A0%E3%81%A8%E8%AA%B0%E3%82%82%E7%9F%A5%E3%82%89%E3%81%AA%E3%81%84) 確かに、そのようにインターネットを使うため匿名にすることはできるかもしれませんが、個人情報を完全に非公開にすることはかなり難しいでしょう。

[業界全体](https://crackedlabs.org/en/corporate-surveillance/)は、ターゲット広告、詐欺検出、価格差別化、あるいは信用スコアリングなどの目的で詳細なユーザープロファイルを構築するために、オンラインでユーザーを追跡することに専念しています。ウェブサイトと地理位置情報を共有することは、日常生活において非常に便利ですが、企業が<a hreflang="en" href="https://www.nytimes.com/interactive/2019/12/19/opinion/location-tracking-cell-phone.html">あなたのすべての行動を見る</a>ことができるようになる可能性もあります。たとえサービスがユーザーの個人情報を真摯に扱っていたとしても、個人情報を保存するという行為だけで、ハッカーは<a hreflang="en" href="https://haveibeenpwned.com/">サービスに侵入し、数百万の個人記録をオンラインで流出させる</a>機会を与えてしまうのです。

欧州では<a hreflang="en" href="https://ec.europa.eu/info/law/law-topic/data-protection/data-protection-eu">GDPR</a>など、最近の立法化の動きもあります。カリフォルニア州の<a hreflang="en" href="https://www.oag.ca.gov/privacy/ccpa">CCPA</a>、ブラジルの<a hreflang="pt-br" href="https://www.gov.br/cidadania/pt-br/acesso-a-informacao/lgpd">LGPD</a>や、インドの<a hreflang="en" href="https://www.meity.gov.in/data-protection-framework">PDP Bill</a>は、いずれも企業に個人データの保護を求め、オンラインも含めてデフォルトでプライバシーを実装しようとするものです。Google、Facebook、Amazonなどの大手テクノロジー企業は、ユーザーのプライバシー侵害の疑いで、すでに<a hreflang="en" href="https://en.wikipedia.org/wiki/GDPR_fines_and_notices">巨額の罰金</a>を受け取っています。

この新しい法律により、ユーザーは個人情報を共有することにどれだけ抵抗がないか、より大きな発言権を持つようになりました。おそらく、すでに多くのクッキー同意バナーをクリックし、この選択を可能にしていることでしょう。さらにウェブブラウザは、機密データを隠してサードパーティのクッキーをブロックすることから、個人の属性に関する正当なユースケースと個々のユーザーのプライバシーのバランスをとる革新的な方法まで、ユーザーのプライバシーを改善する<a hreflang="en" href="https://privacysandbox.com/">技術的解決策</a> を実装しています。

この章では、ウェブにおけるプライバシーの現状を概観する。まず、ユーザーのプライバシーがどのように害されうるかを考える。ここでは、ウェブサイトがどのように[オンライントラッキング](#ウェブサイトがあなたをプロファイリングする方法：オンライントラッキング)によってあなたをプロファイリングし、どのように[あなたの機密データにアクセス](#ウェブサイトにおけるお客様の個人情報の取り扱いについて)しているかについて議論します。次に、ウェブサイトが[機密データを保護](#ウェブサイトが機密情報を保護する方法)する方法と、[プライバシー設定シグナル](#ウェブサイトがプライバシーを選択できるようにする方法-プライバシー・プリファレンス・シグナル)によってユーザーに選択肢を与える方法について掘り下げます。最後に、[今後のブラウザによるプライバシー保護への取り組みについての展望](#ブラウザはどのようにプライバシーへのアプローチを進化させているのか)を掲載します。<!-- markdownlint-disable-line MD051 -->


## ウェブサイトがあなたをプロファイリングする方法：オンライントラッキング

[HTTP](./http)プロトコルは本質的にステートレスなので、デフォルトでは2つの異なるウェブサイトへの訪問、あるいは同じウェブサイトへの2つの訪問が、同じユーザーによるものかどうかをウェブサイトが知る方法はありません。しかし、このような情報はウェブサイトがよりパーソナライズされたユーザー体験を構築するために、また第三者がウェブサイト間でユーザー行動のプロファイルを構築しターゲット広告を通じてウェブ上のコンテンツに資金を提供したり、不正行為の検出などのサービスを提供するために有用であると思われます。

残念ながら、この情報を得るには、現状ではオンライントラッキングに頼ることが多く、それを中心に[多くの大小の企業がビジネスを展開している](https://crackedlabs.org/en/corporate-surveillance/)。これにより、侵襲的な追跡はユーザーのプライバシーと矛盾するため、<a hreflang="en" href="https://www.forbrukerradet.no/wp-content/uploads/2021/06/20210622-final-report-time-to-ban-surveillance-based-advertising.pdf">ターゲット広告の禁止</a>を求める声にもつながっているのです。とくにデリケートな話題のウェブサイトを閲覧する場合、ユーザーは自分の足取りを誰にも知られたくないかもしれません。ここでは、オンライントラッキングのエコシステムを構成する主な企業や技術について見ていきます。

### サードパーティトラッキング

オンライントラッキングは、多くの場合、サードパーティのライブラリを通じて行われます。これらのライブラリは通常、何らかの（有用な）サービスを提供しますが、その過程で各ユーザーに固有の識別子を生成、それを使ってウェブサイト全体でユーザーを追跡し、プロファイルすることができるものもあります。<a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a> プロジェクトは、もっとも広く展開されているオンライントラッカーを発見することに専念しています。私たちはWhoTracksMeのトラッカーの分類を使用していますが、トラッキングが主目的の一部であるサービスをカバーする可能性がもっとも高いため、<a hreflang="en" href="https://whotracks.me/blog/tracker_categories.html">カテゴリ</a>の4つに限定しています。_広告_、_ポルノグラフィティ_、_サイト分析_および_ソーシャル・メディア_です。

{{ figure_markup(
  image="most_common_trackers.png",
  caption="人気のトラッカー10選とその普及率",
  description="もっとも人気のある10個のトラッカーと、それらを含むモバイルおよびデスクトップWebサイトの割合を示す棒グラフです。Google_analytics（サイト分析）デスクトップサイトの66.01%、モバイルサイトの62.53%、Google（広告）はそれぞれ50.89%、49.51%、Doubleclick（広告）49.99%、47.51%、Facebook（広告）30.71%、29.04%、Google_AdServices（広告）21.17%と19.98%、google_syndication（広告）が11.12%と11.91%、wordpress_stats（サイト分析）が6.63%と6.79%、Twitter（ソーシャルメディア）が6.42%と5.48%、adobe_audience_manager（広告）が4.35%と5.49%、最後にYandex（広告）が4.50%と5.28%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=290736860&format=interactive",
  sheets_gid="1466954359",
  sql_file="most_common_trackers.sql",
  width=600,
  height=580
  )
}}

オンライントラッキング市場では、Googleの所有するドメインが広く普及していることがわかります。ウェブサイトのトラフィックを報告するGoogle Analyticsは、全ウェブサイトのほぼ3分の2に存在しています。約30%のサイトがFacebookライブラリを含んでおり、他のトラッカーは一桁のパーセンテージにしか達しません。

{{ figure_markup(
  image="most_common_tracker_categories.png",
  caption="もっとも一般的なトラッカーカテゴリ。",
  description="もっとも人気のあるトラッカーカテゴリと、そのカテゴリからトラッカーを埋め込んでいるウェブサイトの数を示す棒グラフです。デスクトップサイトの83.33％、モバイルサイトの82.08％がトラッカーを使用しています。`サイト分析`は73.53%と70.46%、`広告`は68.83%と67.99%、`ソーシャル・メディア`は12.89%、11.66%、`ポルノ広告` 0.56%、0.60%でそれぞれ使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1126546581&format=interactive",
  sheets_gid="2084631443",
  sql_file="most_common_tracker_categories.sql",
  width=600,
  height=421
  )
}}

全体では、モバイルサイトの82.08%、デスクトップサイトの83.33%が少なくとも1つのトラッカーを含んでおり、通常はサイト分析または広告目的のために利用されています。

{{ figure_markup(
  image="nb_websites_with_nb_trackers.png",
  caption="ウェブサイトごとのトラッカー数。",
  description="デスクトップサイトの15.62％とモバイルサイトの16.31％から始まり、1つのトラッカーを持ち、5％でそれぞれ9.30％と8.64％、15のトラッカーで0.38％と0.41％を超えて減少し、その後ロングテールは25トラッカーで0.12％と0.15％でカットオフしました。 モバイルとデスクトップは、全体を通してほぼ同じ数値を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=268105548&format=interactive",
  sheets_gid="690197217",
  sql_file="number_of_websites_with_nb_trackers.sql"
  )
}}

4つのウェブサイトのうち3つはトラッカーが10個以下ですが、それ以上のトラッカーを持つサイトもあり、あるデスクトップ・サイトでは133個（！）の異なるトラッカーに接続しています。

### サードパーティークッキー

クロスサイトのユーザー識別子を保存および取得するための主な技術的アプローチは、ブラウザに永続的に保存されるクッキーを通じて行われます。サードパーティのクッキーは、クロスサイトトラッキングによく使われますが、サイト間でサードパーティのウィジェットの状態を共有するような、トラッキング以外のユースケースにも使われることがあることに注意してください。私たちは、ウェブを閲覧しているときにもっとも頻繁に表示されるクッキーと、それを設定するドメインを検索しました。

{{ figure_markup(
  image="top100_domains_that_set_cookies_via_response_header.png",
  caption="ヘッダーからクッキーを設定するドメイントップ10。",
  description="クッキーを設定している代表的なトラッキングドメイン10種類について、レスポンスヘッダー経由で設定されたクッキーを含むWebサイトの割合を示したグラフです。`doubleclick.net`はデスクトップページの30.49%、モバイルページの28.72%、`facebook.com`はそれぞれ23.07%、21.43%、`youtube.com`では10.02%と8.83%、`google.com`は8.62%と8.45%、 `yandex.ru`は4.42%と5.17%、`pubmatic.com`は3.82%と4.73%。`rlcdn.com`が4.01%と3.99%、`openx.net`が3.57%と4.42%、`adsrvr.org`が4.00%と3.90%、そして最後に`yahoo.com`が3.80%と3.70% といったところです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=162165227&format=interactive",
  sheets_gid="1256177287",
  sql_file="top100_domains_that_set_cookies_via_response_header.sql",
  width=600,
  height=580
  )
}}

グーグルの子会社であるDoubleClickは、デスクトップサイトの31.4％、モバイルサイトの28.7％にクッキーを設定し、首位に立っています。もう1つの主要なプレーヤーはFacebookで、モバイルウェブサイトの21.4%にクッキーを保存しています。クッキーを設定する他の上位ドメインのほとんどは、オンライン広告に関連しています。

{{ figure_markup(
  image="top100_cookies_set_from_header.png",
  caption="ヘッダーから設定されたトップ10のクッキー。",
  description="もっとも多くのWebサイトに設定されているクッキーの名前を示したグラフ。これらのクッキーは、モバイルよりもデスクトップサイトに多く設定されているようです。doubleclick.netの`test_cookie`はデスクトップサイトの30.20%、モバイルサイトの28.66%、facebook.comの`fr`はそれぞれ23.04%、20.96%、 doubleclick.netの`IDE`は18.03%、16.96%、 google.comの`NID`は4.92%、5.09%、yandex.ruの`yandexuid`が4.38%、5.14%、yandex.ruの`yuidss`が4.38%、5.14%、yandex.ruの`i`が4.34%、5.09%、yandex.ruの `ymex` が4.32%と5.08%、yandex.ruの `yabs-sid` が4.32%と5.08%、adsrvr.orgの `TDID`が3.71%と3.89% であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2052032481&format=interactive",
  sheets_gid="1599373042",
  sql_file="top100_cookies_set_from_header.sql",
  width=600,
  height=580
  )
}}

これらのウェブサイトが設定する特定のクッキーを見てみると、トラッカーからのもっとも一般的なクッキーは、doubleclick.netの`test_cookie`です。次に多いのは広告関連のクッキーで、ユーザーの端末にずっと長く残ります。Facebookの`fr`クッキーは<a hreflang="en" href="https://www.facebook.com/policy/cookies/">90日間</a>、DoubleClickの`IDE`クッキーは<a hreflang="en" href="https://business.safety.google/adscookies/">ヨーロッパでは13か月、その他の地域では2年</a>持続する。

`Lax` が <a hreflang="en" href="https://web.dev/samesite-cookies-explained/">`SameSite`クッキー属性</a> のデフォルト値になったため、ウェブサイト間でサードパーティのクッキーを共有し続けたいサイトは、この属性を明示的に `None` に設定しなければならなくなりました。サードパーティーの場合、モバイルでは85％、デスクトップでは64％が、トラッキングを目的とする可能性があるとして、これまでに実施しています。`SameSite`クッキー属性については、[セキュリティー](./security#samesite)の章で詳しく説明されています。

### 指紋認証

広告ブロックなどのプライバシー保護ツールの台頭や[Firefox](https://blog.mozilla.org/en/products/firefox/todays-firefox-blocks-third-party-tracking-cookies-and-cryptomining-by-default/)、<a hreflang="en" href="https://webkit.org/blog/10218/full-third-party-cookie-blocking-and-more/">Safari</a>、そして2023年には<a hreflang="en" href="https://blog.google/products/chrome/updated-timeline-privacy-sandbox-milestones/#:~:text=Chrome%20could%20then%20phase%20out%20third-party%20cookies%20over%20a%20three%20month%20period%2C%20starting%20in%20mid-2023%20and%20ending%20in%20late%202023">Chrome</a>などの主要ブラウザからサードパーティCookieを段階的に排除する取り組みにより、トラッカーはサイト間でユーザーを追跡する、より持続的で密かな方法を探しています。

その1つが_ブラウザフィンガープリント_です。ウェブサイトは、[ユーザーエージェント](https://developer.mozilla.org/docs/Glossary/User_agent)、画面解像度、インストールされているフォントなど、ユーザーのデバイスに関する情報を収集し、それらの値のユニークな組み合わせを使用して_フィンガープリント_を作成できます。このフィンガープリントは、ユーザーがウェブサイトを訪れるたびに再作成され、照合することでユーザーを特定することができるのです。この方法は、不正行為の検出に使用できますが、繰り返し利用するユーザーを持続的に追跡したり、サイト間でユーザーを追跡するためにも使用されます。

フィンガープリントの検出は複雑です。メソッドコールとイベントリスナーの組み合わせにより効果を発揮し、追跡以外の目的にも使用されることがあります。そこで、これらの個々のメソッドに焦点を当てる代わりに、ウェブサイトがフィンガープリントを簡単に実装できるようにする5つの人気のあるライブラリに焦点を当てます。

{{ figure_markup(
  image="nb_websites_using_each_fingerprinting.png",
  caption="各フィンガープリント・ライブラリーを使用しているウェブサイト。",
  description="各サードパーティフィンガープリントライブラリを含むウェブサイトの割合を示すグラフ。FingerprintJSはデスクトップサイトの0.74%、モバイルサイトの0.64%、 ClientJSはそれぞれ0.04%、0.04%、 MaxMindでは0.03%、0.02%、 TruValidateで0.03%、0.02%、 ThreatMetrixでは0.00%と0.00%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1537414997&format=interactive",
  sheets_gid="1785016530",
  sql_file="number_of_websites_using_each_fingerprinting.sql"
  )
}}

これらのサードパーティ サービスを使用しているWebサイトの割合から、もっとも広く使用されているライブラリである <a hreflang="en" href="https://fingerprintjs.com/">Fingerprint.js</a> は、デスクトップでは2番目に多く使用されているライブラリの19倍も使用されていることがわかります。しかし、ユーザーのフィンガープリントに外部ライブラリを使用しているWebサイトの割合は、全体としては非常に小さいものです。

### CNAMEトラッキング

サードパーティトラッキングのブロックを回避するテクニックを続けると、<a hreflang="en" href="https://medium.com/nextdns/cname-cloaking-the-dangerous-disguise-of-third-party-trackers-195205dc522a">CNAMEトラッキング</a>は、ファーストパーティのサブドメインが[DNSレベル](https://adguard.com/en/blog/cname-tracking.html)でCNAMEレコードを使ってサードパーティサービスの使用をマスクするという新しい方法です。ブラウザから見ると、すべてがファーストパーティの文脈で行われるため、サードパーティの対策は一切適用されない。AdobeやOracleなどの大手トラッキング会社は、すでにCNAMEトラッキングソリューションを顧客に提供しています。
この章に含まれるCNAMEベースのトラッキングの結果については、この章の著者の一人（および他の人）によって完成した <a hreflang="en" href="https://sciendo.com/article/10.2478/popets-2021-0053">研究</a> を参照し、DNSデータとHTTP Archiveからのリクエストデータに基づいてCNAMEベースのトラッキングを検出する方法を開発しました。

{{ figure_markup(
  image="nb_sites_with_cname_tracking.png",
  caption="デスクトップクライアントでCNAMEベースのトラッキングを使用しているWebサイト。",
  description="CNAMEベースのトラッカーを使用しているWebサイトの数を、トラッカーの人気順に並べたグラフです。Adobe Experience Cloudはデスクトップサイトの0.59%、モバイルサイトの0.41%、Pardotは0.41%、0.26%、Oracle Eloquaで0.05%、0.03%、Act-On Softwareでは0.05%、0.03%、Webtrekkで0.01%、0.01%、最後にEulerianは0.01%、0.01%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=450379066&format=interactive",
  sheets_gid="1286114815",
  sql_file="nb_sites_with_cname_tracking.sql",
  width=600,
  height=516
  )
}}

CNAMEベースのトラッキングを実行しているもっとも人気のある企業はAdobeで、デスクトップWebサイトの0.59％、モバイルWebサイトの0.41％に存在しています。また、規模では<a hreflang="en" href="https://www.pardot.com/">Pardot</a>が0.41%、0.26%と顕著です。

この数字は小さな割合に見えるかもしれませんが、サイトの人気度でデータを分離すると、その意見は変わります。

{{ figure_markup(
  image="nb_sites_with_cname_tracking_per_rank.png",
  caption="CNAMEトラッキングを使用しているウェブサイトをランク別に紹介。",
  description="CNAMEベースのトラッキングを使用しているWebサイトの数を人気順位で分割したグラフです。上位1,000サイトのうち、デスクトップサイトの5.91%、モバイルサイトの5.53%がCNAMEベースのトラッキングを利用しており、上位1万サイトでは5.67%と5.35%、上位10万サイトでは2.95%と2.78%、上位100万サイトでは1.31%と1.21%、最後にすべてのサイトでは0.79%と0.52%となっていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2129255642&format=interactive",
  sheets_gid="518784663",
  sql_file="nb_sites_with_cname_tracking_per_rank.sql"
  )
}}

CNAMEベースのトラッキングを使用しているウェブサイトのランクを見ると、モバイルの上位1,000ウェブサイトのうち5.53%がCNAMEトラッカーを埋め込んでいることがわかります。上位100,000サイトでは、その数は2.78%に減少し、データセット全体を見ると0.52%に減少しています。

{{ figure_markup(
  image="nb_sites_with_cname_tracking_per_public_suffix.png",
  caption="CNAMEベースのトラッキングを行うサイトのパブリックサフィックス。",
  description="デスクトップクライアントでCNAMEベースのトラッキングを使用しているWebサイトの数を、Webサイトの公開サフィックス別に示したグラフです。接尾辞が`com`のデスクトップWebサイトの0.64%、モバイルWebサイトの0.42%がCNAMEトラッキングを使用しており、`edu`ではそれぞれ0.18%と0.10%、`jp`では0.03%と0.04%、`org`では0.04%、0.03%、 `co.jp` は0.03%、0.02%、 `ca` では0.02%、0.01%、 `de` では0.02%、0.02%、 `ru` では0.01%、0.01%、 `com.au` では0.02%、0.01%、最後に `edu.au` は0.02%、0.01% となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1816699194&format=interactive",
  sheets_gid="1155429637",
  sql_file="nb_sites_with_cname_tracking_per_public_suffix.sql",
  width=600,
  height=543
  )
}}

`.com` サフィックスとは別に、CNAMEベースのトラッキングを使用しているウェブサイトの多くは `.edu` ドメインを持っています。また、CNAMEトラッカーは `.jp` と `.org` ウェブサイトに多く存在します。

CNAMEベースのトラッキングは、ユーザーがサードパーティーのトラッキングに対するトラッキング保護を有効にしている可能性がある場合の対策になります。トラッカーブロックツールや<a hreflang="en" href="https://www.cookiestatus.com/">ブラウザ</a>は、すでにCNAMEトラッキングに対する防御機能を備えているものが少ないため、現在までに多くのウェブサイトで蔓延しているのが現状です。

### （再）ターゲティング

広告再ターゲティングとは、ユーザーが見たが購入していない商品を記録し、その商品に関する広告を別のWebサイトでフォローアップすることを指します。ユーザーが訪問している間、積極的なマーケティング戦略を選ぶのではなく、ウェブサイトは継続的にブランドと製品を思い出させることで、ユーザーが製品を購入するように誘導することを選択します。

{{ figure_markup(
  image="nb_websites_using_each_retargeting.png",
  caption="再ターゲティングサービスを利用しているページの割合。",
  description="再ターゲティングに利用されている代表的なサービスと、その利用サイト数を棒グラフで示したものです。Google Remarketing Tagはデスクトップ26.92%、モバイル26.64%、Criteoがそれぞれ1.25%、1.21%、AdRollでは0.48%、0.38%、SharpSpring Adsで0.12%、0.09%、Albacrossが0.04%と0.03%、SteelHouseが0.03%と0.02%、Smarter Clickが0.02%と0.01%、 Blueが0.02%と0.01%、Cross Pixelが0.02%と0.01%、そして最後にPicreelが0.01%と0.01% となった。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=882622568&format=interactive",
  sheets_gid="1940290757",
  sql_file="number_of_websites_using_each_retargeting.sql",
  width=600,
  height=580
  )
}}

多くのトラッカーが広告再ターゲティングのためのソリューションを提供しています。もっとも広く利用されているGoogle Remarketing Tagは、デスクトップのウェブサイトの26.92%、モバイルのウェブサイトの26.64%で利用されており、それぞれ1.25%未満で利用されている他のサービスよりはるかに優れています。

## ウェブサイトにおけるお客様の個人情報の取り扱いについて

ウェブサイトによっては、ジオロケーションデータ、マイク、カメラなどにアクセスすることで、ユーザーのプライバシーに影響を与える可能性のある特定の機能およびブラウザAPIへのアクセスを要求するものがあります。これらの機能は通常、近くの観光スポットを発見したり、人々が互いに通信できるようにするなど、非常に有用な目的を果たします。これらの機能はユーザーが同意した場合にのみ有効になりますが、ユーザーがこれらのリソースの使用方法を十分に理解していない場合や、サイトが誤動作した場合、機密データが、公開されるリスクがあります。

Webサイトが機密性の高いリソースへのアクセスを要求する頻度を調べました。さらに、サービスが機密データを保存する場合は常に、ハッカーがそのデータを盗み出し、漏えいさせる危険性があるのです。ここでは、この危険性が実際に存在することを証明する、最近のデータ漏洩事件について見ていきます。


### デバイスセンサー

センサーは、ウェブサイトをよりインタラクティブへするのに便利ですが、<a hreflang="en" href="https://www.esat.kuleuven.be/cosic/publications/article-3078.pdf">指紋認証</a>のために悪用される可能性もあります。JavaScriptのイベントリスナーの使用状況から、モバイル、デスクトップクライアントで、デバイスの向きがもっともアクセスされていることがわかります。なお、Webサイト上でイベントリスナーの存在を検索したが、実際にコードが実行されたかどうかはわからない。したがって、本節のデバイスセンサーイベントへのアクセスは、上限値です。

{{ figure_markup(
  image="nb_websites_with_device_sensor_events.png",
  caption="もっとも使用されている5つのセンサーイベント。",
  description="センサーイベントへのアクセス頻度が高いものを、JavaScriptのリスナー使用率から棒グラフで表したものです。`deviceOrientation` はデスクトップサイトの3.32% とモバイルサイトの3.23%、`deviceReady` は1.12%と1.23%、`devicemotion`は0.65%と0.66%、`deviceChange`は0.03%と0.02%、最後に `deviceproximity` は0.03%と0.02% で確認されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=40988621&format=interactive",
  sheets_gid="1513080238",
  sql_file="number_of_websites_with_device_sensor_events.sql"
  )
}}

### メディアデバイス

[MediaDevices API](https://developer.mozilla.org/docs/Web/API/MediaDevices)を使用すると、カメラやマイク、画面共有などの接続されたメディア入力にアクセスできます。

{{ figure_markup(
  caption="`MediaDevicesEnumerateDevices` APIを使用したデスクトップページの割合。",
  content="7.23%",
  classes="big-number",
  sheets_gid="2141743069",
  sql_file="number_of_websites_with_mediadevices_blink_usage.sql"
)
}}

デスクトップのウェブサイトの7.23%、モバイルのウェブサイトの5.33%で `enumerateDevices()` メソッドが呼び出され、接続されている入力デバイスのリストが提供されます。

### ジオロケーションサービス

ジオロケーションサービスは、GPSやユーザーのその他の位置情報（[IPアドレス](https://developer.mozilla.org/docs/Glossary/IP_Address)など）を提供し、トラッカーはとくにユーザーにより関連性の高いコンテンツを提供するために利用できます。そこで、[Wappalyzer](./methodology#wappalyzer)で検出したライブラリをもとに、Webサイトにおける「ジオロケーションサービス」技術の利用を分析します。

{{ figure_markup(
  image="nb_websites_using_each_geolocation.png",
  caption="ジオロケーションサービスを利用しているWebサイトの割合。",
  description="各ジオロケーションサービスライブラリを利用しているWebサイトの割合を示したグラフです。ipifyはデスクトップサイトの0.09%、モバイルサイトの0.07%、MaxMindは0.03%、0.02%、db-ipが0.01%、0.01%、そしてipstackは0.01%、0.01%が利用していることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2115506749&format=interactive",
  sheets_gid="1274602607",
  sql_file="number_of_websites_using_each_geolocation.sql"
  )
}}

もっとも人気のあるサービスである<a hreflang="en" href="https://www.ipify.org/">ipify</a>は、デスクトップWebサイトの0.09%とモバイルWebサイトの0.07% で使用されていることがわかります。つまり、ジオロケーションサービスを利用しているウェブサイトは少ないようです。

{{ figure_markup(
  image="nb_websites_with_geolocation_blink_usage.png",
  caption="ジオロケーション機能を利用しているWebサイトの割合。",
  description="各ジオロケーション機能を利用しているWebサイトの割合を示す棒グラフです。`GeolocationGetCurrentPosition` はデスクトップサイトの0.59%とモバイルサイトの0.63% で、`GeolocationSecureOrigin` はそれぞれ0.59%と0.62% で、`GeolocationInsecureOrigin`は0.01%と0.02%, `GeolocationWatchPosition`が0.02%と0.02%, `GeolocationSecureOriginIframe`が0.02%と0.02%, `GeolocationDisabledByFeaturePolicy`が0.02%と0.01% そして最後に `GeolocationInsecureOriginIframe`は0.00%と0.01%となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1513111756&format=interactive",
  sheets_gid="1110372680",
  sql_file="number_of_websites_with_geolocation_blink_usage.sql"
  )
}}

また、Webサイトからは[WebブラウザAPI](https://developer.mozilla.org/docs/Web/API/Geolocation_API)を介して、ジオロケーションデータにアクセスすることが可能です。デスクトップクライアントで0.59%、モバイルクライアントでは0.63%のWebサイトがユーザーの現在位置にアクセスしていることがわかります（[ブリンク機能](./methodology#blink-features)に基づいています）。

### 情報漏えい

企業におけるセキュリティ管理の不備は、お客様の個人情報にも大きな影響を及ぼします。<a hreflang="en" href="https://haveibeenpwned.com/">Have I Been Pwned</a> は、ユーザーが自分のメールアドレスや電話番号がデータ漏洩で流出したかどうかを確認することができるサービスです。この記事を書いている時点で、Have I Been Pwnedは562件の情報漏えいを追跡し、6億4000万件の記録が漏れていることが判明しています。2020年だけでも40のサービスが侵入され、数百万人のユーザーの個人情報が流出した。このうち3件は_センシティブ_とされ、誰かがそのユーザーのデータを見つけた場合、ユーザーに悪影響が、及ぶ可能性があることを指しています。機密漏洩の一例として、盗まれたクレジットカードが、取引されるプラットフォーム「[Carding Mafia](https://www.vice.com/en/article/v7m9jx/credit-card-hacking-forum-gets-hacked-exposing-300000-hackers-accounts)」が挙げられます。

<p class="note">なお、前年度の40件の違反は、多くの違反が発生してから数カ月後に発見、または公表されるため、下限値であることに注意してください。</p>

{{ figure_markup(
  image="data_breaches_pwned_accounts_per_class.png",
  caption='データクラスごとの違反で影響を受けたアカウント数。(出典：<a hreflang="en" href="https://haveibeenpwned.com/">Have I Been Pwned</a>)',
  description="情報漏えいに関与したユーザーアカウント数を、情報漏えいで流出したデータクラス別に示した棒グラフ。6億4100万件の電子メールアドレス、4億2800万件のパスワード、3億6900万件の氏名、1億7300万件の地理的位置、1億4900万件の電話番号、1億4900万件の性別、1億3400万のソーシャルメディアプロファイル、1億2700万の教育レベル、1億2600万の職種、そして最後に1億1000万の物理アドレスが流出された。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1612339126&format=interactive",
  sheets_gid="1158689200",
  sql_file="data_breaches_pwned_accounts_per_class.sql"
  )
}}

<a hreflang="en" href="https://haveibeenpwned.com/">Have I Been Pwned</a> が追跡したすべてのデータ侵害では、電子メールアドレスが漏れています。これは、ユーザーが自分のデータが侵害されたかどうかを問い合わせる方法だからです。電子メールアドレスの設定には、多くのユーザーがフルネームや認証情報を採用しているため、電子メールアドレスの流出は、すでに大きなプライバシーリスクとなっています。さらに、ユーザーの性別、銀行口座番号、完全な物理的住所など、他の多くの非常に機密性の高い情報が流出するケースもあります。

## ウェブサイトが機密情報を保護する方法

ウェブサイトを閲覧していると、閲覧したページ、フォームに入力した機密データ、位置情報など、非公開にしたいデータがあります。[セキュリティ](./security#トランスポートセキュリティ)の章では、91.1%のモバイルサイトがHTTPSを有効にし、インターネットを通過するデータを盗聴から保護していることをご紹介しています。ここでは、機密性の高いリソースのプライバシーを確保するために、ウェブサイトがブラウザにどのように指示できるかに焦点を当てます。

### パーミッションポリシー／フィーチャーポリシー

<a hreflang="en" href="https://www.w3.org/TR/permissions-policy-1/">パーミッションポリシー</a>（以前はフィーチャーポリシーと呼ばれていました）は、ウェブサイトがどのウェブ機能を使用するつもりで、どの機能がユーザーによって明示的に承認される必要があるか（たとえば、第三者から要求されたとき）を定義する方法を提供します。これにより、埋め込まれたサードパーティーのスクリプトがどのような機能へのアクセスを要求できるかを、ウェブサイトがコントロールできるようになります。たとえば、パーミッションポリシーを使用すると、ウェブサイトは、サードパーティーが自分のサイトでマイクアクセスを要求しないようにできます。このポリシーにより、開発者は `allow` 属性で指定することで、使用する予定のWeb APIを細かく選択できます。

{{ figure_markup(
  image="most_common_featurepolicy_permissionspolicy_directives.png",
  caption="フィーチャーポリシーディレクティブにアクセスしたウェブサイトの数。",
  description="機能ポリシーの定義によく使われるディレクティブと、そのディレクティブを使用しているWebサイトの数を示す棒グラフ。`ジオロケーション`はデスクトップ2,222サイト、モバイル2,323サイト、`マイク`では2,199サイト、`カメラ`では2,082サイト、2,197サイト、`支払い`では1,748サイト、1,879サイト、`usb`では1, 354と1,492、`ジャイロスコープ`が1,145と1,025、`磁力計`が1,141と1,024、`インタレストコーホート`が1,037と1,019、`フルスクリーン`が940と873、`加速度センサー`が892と852です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=820718961&format=interactive",
  sheets_gid="899874026",
  sql_file="most_common_featurepolicy_permissionspolicy_directives.sql",
  width=600,
  height=421
  )
}}

フィーチャーポリシーに関連して、もっともよく使われるディレクティブは上記の通りです。モバイルでは3,049サイト、デスクトップでは2,901サイトで、マイク機能の利用が指定されています。これはデータセットのごく一部であり、まだニッチな技術であることを示しています。その他によく制限される機能は、ジオロケーション、カメラ、支払い機能です。

ディレクティブの使われ方をより深く理解するために、よく使われるディレクティブの上位3つと、そのディレクティブに割り当てられた値の分布について調べてみました。

{{ figure_markup(
  image="most_common_featurepolicy_permissionspolicy_directive_values.png",
  caption="もっとも一般的な3つの機能ポリシーディレクティブに使用される値。",
  description="フィーチャーポリシーでもっとも人気のある3つのディレクティブに割り当てられた値の分布を示す棒グラフです。`マイクロフォン`は、モバイルサイトの0.08%で`self`に、0.49%で`none`に、0.03%で`*`に設定されています。`geolocation` はモバイルサイトの0.17%で `self` に設定され、0.34%で `none` に設定され、0.05%で `*` に設定されています。`カメラ` はモバイルサイトの0.09%で `self` に設定され、0.46%で `none` に、0.03%で `*` に設定されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=280518522&format=interactive",
  sheets_gid="436267650",
  sql_file="most_common_featurepolicy_permissionspolicy_directive_values.sql"
  )
}}

`none` がもっともよく使われる値です。これは、トップレベルおよびネストされたブラウジングのコンテキストで、その機能が無効であることを指定します。2番目によく使われる値である `self` は、現在のドキュメントと同じオリジン内でその機能を許可することを指定するために使われます。一方 `*` は、オリジンをまたいだ完全なアクセスを許可します。

### Refererポリシー

HTTPリクエストはオプションで `Referer` ヘッダーを含むことができます。これはリクエストがどのオリジンまたはWebページのURLから行われたかを示すものです。`Referer` ヘッダーはさまざまなタイプのリクエストに含まれる可能性があります。

* ユーザーがリンクをクリックしたときのナビゲーション要求。
* サブリソースリクエスト。ブラウザが画像、iframe、スクリプトなど、ページが必要とするリソースを要求すること。

ナビゲーションやiframeの場合、このデータはJavaScriptで `document.referrer` を使用してアクセスすることもできます。

`Referer` の値は、洞察力を高めることができます。しかし、パスとクエリ文字列を含む完全なURLが `Referer` としてオリジン間で送信される場合、プライバシーを侵害する可能性があります。URLには、個人情報、時には個人を特定するような重要な情報が含まれていることがあります。このような情報は、送信元を越えて静かに流出することで、ユーザーのプライバシーを侵害し、セキュリティ上のリスクをもたらします。[`Referrer-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Referrer-Policy) HTTPヘッダーは、開発者が自分のサイトからのリクエストで利用できるリファラーデータを制限して、このリスクを軽減することを可能にします。

{{ figure_markup(
  image="nb_websites_with_referrerpolicy.png",
  caption="リファラーポリシーを指定しているWebサイトの割合。",
  description="リファラーポリシーを利用しているWebサイトの割合を、Webサイトがどのようにポリシーを指定しているかによって示した棒グラフ。参照元ポリシーはデスクトップ11.12%、モバイル10.38%、ドキュメント全体9.66%、8.68%、ドキュメント全体のヘッダー7.37%、6.49%、ドキュメント全体のメタ2.65%、2.51%、個別の要求は1.92%、2.10%、リンク関係0%と0%に設定されていることが分かりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2144839216&format=interactive",
  sheets_gid="1720798838",
  sql_file="number_of_websites_with_referrerpolicy.sql"
  )
}}

まず注目すべき点は、ほとんどのサイトがリファラーポリシーを明示的に設定していないことです。デスクトップ用ウェブサイトの11.12%、モバイル用ウェブサイトの10.38%だけが、明示的にリファラーポリシーを定義しています。残りの部分（デスクトップでは88.88％、モバイルでは89.62％）は、ブラウザのデフォルトポリシーにフォールバックされます。<a hreflang="ja" href="https://web.dev/i18n/ja/referrer-best-practices/#default-referrer-policies-in-browsers">最近ほとんどの主要なブラウザ</a>は、2020年8月に<a hreflang="en" href="https://developers.google.com/web/updates/2020/07/referrer-policy-new-chrome-default">Chrome</a> 、2021年3月に<a hreflang="en" href="https://blog.mozilla.org/security/2021/03/22/firefox-87-trims-http-referrers-by-default-to-protect-user-privacy/">Firefox</a>など、 `strict-origin-when-cross-origin` というデフォルトポリシーを導入しています。`strict-origin-when-cross-origin` はクロスオリジンリクエストの際にURLのパスとクエリフラグメントを削除し、セキュリティとプライバシーのリスクを軽減します。

{{ figure_markup(
  image="most_common_referrerpolicy_values.png",
  caption="Percentage of pages using Referrer Policy values.",
  description="各リファラーポリシーの値を使用しているページの割合を示す棒グラフです。`no-referrer-when-downgrade` はデスクトップサイトの3.63% とモバイルサイトの3.31% で、 `strict-origin-when-cross-origin` はそれぞれ1.95%、1.56%。`always`で1.08%、0.82%。`unsafe-url`では0.47%、0.52%。`same-origin`は0.51%、0.44%。`origin`が0.39%、0.51%。`no-referrer`は0.34%、0.31%。`origin-when-cross-origin`で0.31%、0.29%。`strict-origin`が0.26%、0.23%。最後に `no-referrer, strict-origin-when-cross-origin` が0.09% と0.08% になりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=406890714&format=interactive",
  sheets_gid="1846818406",
  sql_file="most_common_referrerpolicy_values.sql",
  width=600,
  height=580
  )
}}

明示的に設定されるもっとも一般的なReferrer Policyは、`no-referrer-when-downgrade`です。モバイルクライアントのウェブサイトの3.38%、デスクトップクライアントのウェブサイトの3.81%で設定されています。`no-referrer-when-downgrade`はプライバシーを強化するものではありません。このポリシーでは、ユーザーがあるサイトで訪れたページの完全なURLが、クロスオリジンのHTTPSリクエスト（リクエストの大部分）で共有され、この情報は他の当事者（オリジン）がアクセスできるようになります。

さらに、約0.5%のウェブサイトがリファラーポリシーの値を`unsafe-url`に設定しており、受信者のセキュリティレベルに関係なく、_あらゆる_リクエストでオリジン、ホスト、クエリー文字列が送信されるようになっています。この場合、リファラーが平文で送信され、個人情報を漏えいさせる可能性があります。心配なことに、この動作を可能にするようにサイトが積極的に設定されているのです。

<p class="note">注：ウェブサイトは、リファラー情報をURLのパラメータとして送信先サイトに送ることもあります。このレポートでは、そのような仕組みの使用状況は測定していません。</p>

### User-Agent クライアントヒント

ウェブブラウザがHTTPリクエストを行う際、クライアントのブラウザ、デバイス、ネットワーク機能に関する情報を提供する[`User-Agent`](https://developer.mozilla.org/docs/Web/HTTP/Headers/User-Agent)ヘッダーが含まれます。しかし、これを悪用してユーザーをプロファイリングしたり、[フィンガープリンティング](#指紋認証)によって一意に特定することが可能です。

<a hreflang="en" href="https://wicg.github.io/ua-client-hints/">User-Agentクライアントヒント</a> は `User-Agent` 文字列と同じ情報へのアクセスを可能にしますが、よりプライバシーを保護する方法でアクセスします。これにより、Chromeが <a hreflang="en" href="https://www.chromium.org/updates/ua-reduction">User Agent削減</a> の段階的な計画で提案しているように、ブラウザが `User-Agent` 文字列をデフォルトで提供する情報量を最終的に削減することができるようになります。

サーバーは `Accept-CH` ヘッダーを指定することで、これらのClient Hintsをサポートすることを示すことができます。このヘッダーは、デバイス固有またはネットワーク固有のリソースを提供するために、サーバーがクライアントに要求する属性をリストアップしています。一般に、Client Hintsはサーバがコンテンツを効率的に提供するために必要な最小限の情報のみを取得する方法を提供します。

{{ figure_markup(
  image="nb_websites_with_user_agent_client_hints.png",
  caption="User-Agentクライアントヒントを使用しているページの割合。",
  description="ウェブサイトのランクに応じて、User-Agent Client Hintsを使用しているページの割合を示す棒グラフです。上位1,000サイトではデスクトップ3.67%、モバイル3.56%、上位1万サイトはそれぞれ1.35%、1.44%、上位10万サイトが0.40%、0.42%、上位100万サイトで0.14%、0.15%、最後にすべてのサイトで0.15%と0.20%となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2107002085&format=interactive",
  sheets_gid="190615661",
  sql_file="number_of_websites_with_user_agent_client_hints.sql"
  )
}}

しかし、現時点では、クライアントヒントを導入しているWebサイトはほとんどありません。また、人気のあるWebサイトとそうでないWebサイトでは、クライアントヒントの利用状況に大きな差があります。モバイルで人気のある上位1,000のWebサイトのうち、3.67%がClient Hintsをリクエストしています。上位10,000のウェブサイトでは、実装率は1.44%に低下しています。

## ウェブサイトがプライバシーを選択できるようにする方法 プライバシー・プリファレンス・シグナル

冒頭で述べたような近年のプライバシー規制の導入に伴い、ウェブサイトは、マーケティングや分析といった本質的でない機能のための個人データの収集について、ユーザーの明確な同意を得ることが求められています。

そのため、ウェブサイトは、クッキーの同意バナーやプライバシーポリシー、その他の仕組み（<a hreflang="en" href="https://sciendo.com/article/10.2478/popets-2021-0069">経時変化</a>）を利用して、これらのサイトが処理するデータについてユーザーに知らせ、選択を与える方向に向かいました。このセクションでは、このようなツールの普及状況について見ていきます。

### 同意書管理プラットフォーム

{{ figure_markup(
  image="nb_websites_with_cmp.png",
  caption="同意管理プラットフォームを使用しているウェブサイトの割合。",
  description="同意管理にサードパーティライブラリを使用しているWebサイトの割合を示す棒グラフです。デスクトップサイトの7.10%、モバイルサイトの6.97%がCMPを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=246947280&format=interactive",
  sheets_gid="147308043",
  sql_file="number_of_websites_with_privacy_service.sql"
  )
}}

同意書管理プラットフォーム（CMP）は、ウェブサイトがユーザーのためにクッキーの同意バナーを提供するために組み込むことができるサードパーティライブラリです。約7%のWebサイトがCMPを利用していることが確認されています。

{{ figure_markup(
  image="nb_websites_using_each_cmp.png",
  caption="もっとも人気のある10の同意管理プラットフォーム。",
  description="同意管理を提供するサードパーティライブラリのうち、もっとも人気のある10個を使用しているページの割合を示す棒グラフです。CookieYesはデスクトップサイトの1.65%、モバイルサイトの1.70%、Osanoはそれぞれ1.64%、1.59%、OneTrustが0.90%、0.73%、Cookiebotで0.74%、0.64%、AdRoll CMP Systemでは0.50%と0.36%、iubendaが0.34%と0.35%、Quantcast Choiceが0.37%と0.34%、Didomiが0.29%と0.24%、USercentricsが0.18%と0.19%、最後にHubSpot Cookie Policy Bannerが0.26%と0.17%となっています。
  ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=619927070&format=interactive",
  sheets_gid="387302670",
  sql_file="number_of_websites_using_each_cmp.sql",
  width=600,
  height=421
  )
}}

もっとも人気のあるライブラリは、<a hreflang="en" href="https://www.cookieyes.com/">CookieYes</a> と <a hreflang="en" href="https://www.osano.com/">Osano</a> ですが、ウェブサイトがクッキー同意バナーを掲載できるライブラリは20種以上見つかりました。各ライブラリは、それぞれ2％未満と、わずかな割合でしか存在しない。

### IABの同意フレームワーク

<a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">透明性と同意のフレームワーク</a> (TCF) は、インタラクティブ広告協会ヨーロッパ（IAB）が主導する、広告主にユーザーの同意を伝えるための業界標準を提供するためのものです。このフレームワークは、ベンダーが処理するデータの正当な目的を指定できる<a hreflang="en" href="https://iabeurope.eu/vendor-list/">グローバルベンダーリスト</a>と、ベンダーとパブリッシャーの仲介をするCMPのリストで構成されています。各CMPは、法的根拠を伝達し、ユーザーから提供された同意の選択肢をブラウザに保存する責任を負っています。私たちは、保存されたクッキーを_コンテントストリング_と呼んでいます。

TCFは、欧州ではGDPRに準拠した仕組みとして意味づけられていますが、<a hreflang="en" href="https://iabeurope.eu/all-news/update-on-the-belgian-data-protection-authoritys-investigation-of-iab-europe/">ベルギーデータ保護局による最近の決定</a>では、この仕組みはまだ侵害されていると判断されています。カリフォルニア州でCCPAが施行されたとき、IAB Tech Lab USは同じコンセプトで<a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">U.S. プライバシー</a> (USP) 技術仕様を策定しました。

{{ figure_markup(
  image="nb_websites_with_iab.png",
  caption="IAB準拠のフレームワークを使用しているウェブサイトの割合。",
  description="IAB欧米それぞれのコンプライアンスフレームワークを使用しているWebサイトの割合を示す棒グラフです。IAB TCF v1はデスクトップサイトの0.35%、モバイルサイトの0.30%、IAB TCF v2はそれぞれ1.58%、1.49%、IAB TCF anyが1.67%、1.57%、IAB USPでは3.13%、3.19%、そして最後にIAB anyは3.92%と3.97%が使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1697790298&format=interactive",
  sheets_gid="1662197018",
  sql_file="number_of_websites_with_iab.sql"
  )
}}

上図は、TCFとUSPの両バージョンの使用率分布を示したものです。なお、今回のクロールは米国をベースにしているため、TCFを導入しているウェブサイトは多くないと思われる。TCFを使用しているサイトは全体の2%以下ですが、USプライバシーフレームワークを使用しているサイトはその2倍です。

{{ figure_markup(
  image="most_common_cmps_for_iab_tcf_v2.png",
  caption="IABでもっとも人気のある10の同意管理プラットフォーム。",
  description="IABのコンプライアンスフレームワークに使用される同意管理プラットフォームのうち、もっとも人気のある10種類を示す棒グラフ。Quantcastはデスクトップサイトの0.31%、モバイルサイトの0.33%、Didomiはそれぞれ0.29%、0.24%、Wikia, Inc. が0.23%、0.19%、Google LLCで0.08%、0.09%、SIRDATAでは0.06%と0.08%、iubendaが0.07%と0.07%、OneTrust LLCが0.05%と0.06%、ソースポイントが0.05%と0.05%、comcentmanager.netが0.03%と0.02%、最後にLiveRampが0.02%と0.01%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2085725571&format=interactive",
  sheets_gid="692122193",
  sql_file="most_common_cmps_for_iab_tcf_v2.sql"
  )
}}

フレームワークに含まれる同意管理プラットフォームでもっとも人気のある10個の中で、トップは<a hreflang="en" href="https://www.quantcast.com/products/choice-consent-management-platform/">Quantcast</a>でモバイルでは0.34%となっています。その他、<a hreflang="en" href="https://www.didomi.io/">Didomi</a>が0.24％、Wikiaが0.30％と、人気の高いソリューションとなっています。

USPフレームワークでは、ウェブサイトとユーザーのプライバシー設定は、<a hreflang="en" href="https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md">_プライバシー文字列_</a>でエンコードされています。

{{ figure_markup(
  image="most_common_strings_for_iab_usp.png",
  caption="IAB USプライバシー文字列を使用しているウェブサイトの割合。",
  description="IABのUSP同意フレームワークの各プライバシーストリングを使用しているWebサイトの割合を示す棒グラフ。`1----`はデスクトップWebサイトの0.87%、モバイルWebサイトの0.80%、`1YNY`はそれぞれ0.72%、0.64%、`1YNN`では0.07%、0.06%、ブランクが0.01%、0.00%で使用されていることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2039463193&format=interactive",
  sheets_gid="1524219137",
  sql_file="most_common_strings_for_iab_usp.sql",
  width=600,
  height=421
  )
}}

もっとも一般的なプライバシーに関する文字列は、`1----`です。これは、CCPAがウェブサイトに適用されないことを示し、したがってウェブサイトはユーザーに対してオプトアウトを提供する義務がないことを示します。CCPAは、個人情報の販売を主業務とする企業、またはデータ処理を行う企業で年間売上高が2500万ドル以上の企業にのみ適用されます。2番目に多い文字列は、`1YNY`です。これは、ウェブサイトが「データの販売をオプトアウトするための通知と機会」を提供したが、ユーザーが個人データの販売をオプトアウトして_いない_ことを示すものです。

### プライバシーポリシー

現在、ほとんどのウェブサイトにはプライバシーポリシーがあり、ユーザーは自分について保存、処理される情報の種類を知ることができます。

{{ figure_markup(
  caption="プライバシーポリシーのリンクがあるモバイルウェブサイトの割合。",
  content="39.70%",
  classes="big-number",
  sheets_gid="473955086",
  sql_file="number_of_websites_with_privacy_links.sql"
)
}}

「プライバシーポリシー」「クッキーポリシー」などのキーワードを<a hreflang="en" href="https://github.com/RUB-SysSec/we-value-your-privacy/blob/master/privacy_wording.json">多くの言語</a>で検索してみると、モバイルサイトの39.70%、デスクトップサイトの43.02%が何らかのプライバシーポリシーに言及していることが分かります。一部のウェブサイトでは、このようなポリシーの策定が義務付けられていませんが、多くのウェブサイトでは個人情報を取り扱っているため、ユーザーに対して十分な透明性を確保するために、プライバシーポリシーを策定することが必要です。

### 追跡禁止 - グローバルなプライバシー管理

<a hreflang="en" href="https://www.eff.org/issues/do-not-track">追跡禁止</a> (DNT) HTTPヘッダーは、ユーザーが追跡を希望しないことをウェブサイトへ伝えるために使用できます。以下に、DNTの現在値にアクセスしていると思われるサイトの数を、[`Navigator.doNotTrack`](https://developer.mozilla.org/docs/Web/API/Navigator/doNotTrack) JavaScriptコールの存在に基づいて確認できます。

{{ figure_markup(
  image="nb_websites_with_dnt_blink_usage.png",
  caption="追跡禁止 (DNT)を使用しているWebサイトの割合。",
  description="`NavigatorDoNotTrack`機能を使用してDNTの価値にアクセスするウェブサイトの割合を示す棒グラフ。デスクトップサイトの17.37％、モバイルサイトの17.39％がアクセスしています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1302428398&format=interactive",
  sheets_gid="485103492",
  sql_file="number_of_websites_with_dnt_blink_usage.sql"
  )
}}

モバイルクライアントとデスクトップクライアントでは、ほぼ同じ割合のページでDNTが使用されています。しかし、実際には、DNTのオプトアウトを尊重するウェブサイトはほとんどありません。DNTを規定するTracking Protection Working Groupは、2018年に<a hreflang="en" href="https://www.w3.org/2016/11/tracking-protection-wg.html">閉鎖</a>された。<a hreflang="en" href="https://lists.w3.org/Archives/Public/public-tracking/2018Oct/0000.html">「サポート不足」</a>のためです。Safariはその後、<a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-12_1-release-notes#:~:text=Removed%20support%20for%20the%20expired%20Do%20Not%20Track">DNTのサポートを止め</a>、[フィンガープリント](#指紋認証) への悪用の可能性を防止するようにしました。

DNTの後継となる<a hreflang="en" href="https://globalprivacycontrol.org/">グローバル・プライバシー・コントロール</a>（GPC）は2020年10月にリリースされ、より強制力のある代替手段を提供するものであり、より良い普及を期待するものです。このプライバシー設定シグナルは、すべてのHTTPリクエストに1ビットで実装されています。まだ取り込みは確認できていませんが、<a hreflang="en" href="https://www.washingtonpost.com/technology/2021/10/26/global-privacy-control-firefox/">主要なブラウザがGPCを実装し始めている</a>ため、今後改善されることが期待できます。

## ブラウザはどのようにプライバシーへのアプローチを進化させているのか

ウェブ閲覧中のユーザーのプライバシー保護を強化するため、主要ブラウザはユーザーの機密情報をより安全に保護する新機能を実装しています。[`Referrer-Policy` ヘッダー](#refererポリシー)や[`SameSite`クッキー](#サードパーティークッキー) に対して、ブラウザがよりプライバシーを保護するデフォルト設定を強制し始めたことは、すでに説明しました。

さらに、Firefoxは[トラッキング防止機能の強化](https://developer.mozilla.org/docs/Web/Privacy/Tracking_Protection)、Safariは<a hreflang="en" href="https://webkit.org/tracking-prevention/">インテリジェントなトラッキング防止</a>によりトラッキングをブロックしようとしています。

トラッカーのブロックにとどまらず、Chromeは<a hreflang="en" href="https://privacysandbox.com/">プライバシー・サンドボックス</a> を立ち上げ、広告や詐欺防止などさまざまなユースケースでよりプライバシーに配慮した機能を提供する新しいウェブ標準を開発中です。サイトがユーザーを追跡する機会を減らすために設計された、これらの新進気鋭の技術について詳しく見ていきます。

### プライバシー・サンドボックス

エコシステムのフィードバックを求めるため、プライバシー サンドボックスAPIの初期および実験バージョンは、最初は個々の開発者によるテストのために <a hreflang="en" href="https://www.chromium.org/developers/how-tos/run-chromium-with-flags">機能フラグ</a> の背後に用意され、その後 <a hreflang="ja" href="https://developer.chrome.com/ja/blog/origin-trials/">_オリジントライアル_</a> を通じてChromeで使用されるようになります。このオリジントライアルに参加することで、Webプラットフォームの実験的な機能をテストし、その機能の使い勝手、実用性、有効性について、すべてのWebサイトにデフォルトで提供される前にWeb標準化コミュニティへフィードバックできます。

<p class="note">**免責事項：** Originのトライアルは限られた時間のみ利用可能です。以下の数字は、この記事を書いている2021年10月時点のプライバシーサンドボックスのオリジントライアルの状態を表しています。</p>

### FLoC

プライバシー・サンドボックスの実験でもっとも話題になったものの1つが、<a hreflang="en" href="https://privacysandbox.com/proposals/floc">_コホートのフェデレート学習_</a>、略して_FLoC_です。FLoCのオリジントライアルは、2021年7月に終了しました。

ウェブ上では、興味関心に基づく広告選択が一般的に行われています。FLoCは、その特定のユースケースを満たすために、個々のユーザーを識別し追跡する必要のないAPIを提供しました。FLoCは、いくつかの<a hreflang="en" href="https://www.economist.com/the-economist-explains/2021/05/17/why-is-floc-googles-new-ad-technology-taking-flak">flak</a>を取りました。[Firefox](https://blog.mozilla.org/en/privacy-security/privacy-analysis-of-floc/) や <a hreflang="en" href="https://www.theverge.com/2021/4/16/22387492/google-floc-ad-tech-privacy-browsers-brave-vivaldi-edge-mozilla-chrome-safari">Chromiumベースの他のブラウザ</a>は実装を拒否し、電子フロンティア財団は <a hreflang="en" href="https://www.eff.org/deeplinks/2021/03/googles-floc-terrible-idea"> 新しいプライバシーリスクをもたらすかもしれないという懸念</a>を唱えている。しかし、FLoCは最初の実験でした。今後のAPIの改良で、これらの懸念が解消され、より広く採用される可能性があります。

FLoCでは、ユーザーに固有の識別子を割り当てる代わりに、ブラウザがユーザーの_コホート_（同じようなページを訪れた、したがって同じ広告主が関心を持つ可能性のある何千もの人々のグループ）を決定したのです。

FLoCは実験的なものであったため、広く展開されることはなかった。その代わり、オリジン・トライアルに登録することで、ウェブサイトが、テストすることができました。デスクトップとモバイルでそれぞれ62と64のウェブサイトがFLoCをテストしていることがわかりました。

最初のFLoC実験の仕組みはこうです。ユーザーがウェブ上を移動すると、ブラウザはFLoCアルゴリズムを使って、最近の閲覧履歴が同じような何千ものブラウザに対して同じ_興味のあるコホート_を算出します。ブラウザは、個々の閲覧データをブラウザベンダーや他の関係者と共有することなく、ユーザーのデバイス上で定期的にコホートを再計算しました。コホートをワークアウトする際、ブラウザは <a hreflang="en" href="https://www.chromium.org/Home/chromium-privacy/privacy-sandbox/floc#:~:text=web%20pages%20on%20sensitive%20topics">センシティブなカテゴリーを明らかにしなかった</a> というコホートの間で選択を行っていました。

個々のユーザーやウェブサイトは、コホート計算の対象から外れることも可能です。

{{ figure_markup(
  image="nb_websites_with_floc_opt_out.png",
  caption="FLoCコホートでオプトアウトするウェブサイトの割合。",
  description="ウェブサイトのランクに応じて、FLoCコホートをオプトアウトするページの割合を示す棒グラフ。上位1,000サイトのうち、デスクトップサイト3.29%、モバイルサイト4.10%、上位1万サイトはそれぞれ1.10%、1.26%、上位10万サイトでは0.64%、0.67%、上位100万サイトで0.69%、0.69%、全体では0.95%と0.86%となっているのが、オプトアウトの特徴です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=129384991&format=interactive",
  sheets_gid="637590731",
  sql_file="number_of_websites_with_floc_opt_out.sql"
  )
}}

上位1,000サイトのうち、4.10%がFLoCをオプトアウトしていることがわかりました。全ウェブサイトのオプトアウト率は1%未満です。

### その他のプライバシー・サンドボックスの実験

GoogleのPrivacy Sandbox構想の中では、さまざまな実験が行われています。

<a hreflang="ja" href="https://developer.chrome.com/ja/docs/privacy-sandbox/attribution-reporting/">_アトリビューションレポートAPI_</a>（旧称：_換算測定_）は、広告とユーザーのインタラクションがいつコンバージョンに結びついたか、たとえば広告クリックが最終的に購買につながったかなどを測定できるようにするものです。最初のオリジントライアル（2021年10月に終了）が10オリジンで有効になっているのを確認しました。

<a hreflang="ja" href="https://developer.chrome.com/ja/docs/privacy-sandbox/fledge/">_FLEDGE_</a>（第1回「グループ上の局所実行型判定」実験）は、広告ターゲティングに対応することを目指したものです。このAPIは、現在のバージョンのChrome<a hreflang="ja" href="https://developer.chrome.com/ja/docs/privacy-sandbox/fledge/">ローカルで個々の開発者で</a>試すことができますが、2021年10月現在、オリジントライアルは行われていません。

<a hreflang="ja" href="https://developer.chrome.com/ja/docs/privacy-sandbox/trust-tokens/">_トラストトークン_</a> は、ウェブサイトがある閲覧状況から別の閲覧状況へと限られた量の情報を伝達し、パッシブ追跡なしで詐欺へ対抗できるようにするものです。私たちは、サードパーティのプロバイダーとして多くのサイトへ組み込まれていると思われる7つのオリジンで、最初の <a hreflang="en" href="https://developer.chrome.com/blog/third-party-origin-trials">オリジン トライアル</a>（2022年5月に終了予定）が有効になっていることを確認しました。

<a hreflang="en" href="https://github.com/WICG/CHIPS">_CHIPS_</a> (Cookies Having Independent Partitioned State) では、ウェブサイトがクロスサイトのクッキーを「パーティションド」としてマークし、トップレベルのサイトごとに別のクッキー入れへ入れられるようにします。（Firefoxでは、Cookieのパーティショニングについて、同様の <a hreflang="en" href="https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/">_トータル・クッキー・プロテクト_</a> 機能がすでに導入されています）。2021年10月現在、CHIPSのオリジントライアルはありません。

<a hreflang="en" href="https://github.com/shivanigithub/fenced-frame">_フェンスフレーム_</a> は、埋め込みページからのデータへのフレームアクセスを保護します。2021年10月現在、オリジントライアルはありません。

{{ figure_markup(
  image="same_party_cookie_attribute.png",
  caption="SamePartyクッキー属性を持つクッキーの割合。",
  description="リクエストのコンテキストに応じて、SamePartyクッキー属性を持つクッキーの割合を示す棒グラフです。ファーストパーティークッキーでは、`SameParty`は38のデスクトップサイトと73のモバイルサイトで使用されており、サードパーティークッキーでは、2,527のデスクトップサイトと1,805のモバイルサイトで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=935824621&format=interactive",
  sheets_gid="858972835",
  sql_file="../security/cookie_attributes.sql"
  )
}}

最後に、<a hreflang="ja" href="https://developer.chrome.com/ja/docs/privacy-sandbox/first-party-sets/">_First-Party Sets_</a> により、ウェブサイトの所有者は、実際には同じエンティティに属している個別のドメインのセットを定義できます。所有者は、サイトが同じファーストパーティセットである限り、クロスサイトコンテキストで送信されるべきクッキーに `SameParty` 属性を設定できます。最初のオリジン・トライアルは2021年9月に終了しました。私たちは数千のクッキーに `SameParty` 属性があることを確認しました。

## 結論

現在もWeb上ではユーザーのプライバシーが危険にさらされています。全Webサイトの80%以上が何らかのトラッキングを有効にしており、CNAMEトラッキングのような新しいトラッキングメカニズムも開発されています。また一部のサイトでは、ジオロケーションなどの機密データを扱っており、注意を怠ると、潜在的な侵害によってユーザーの個人情報を流出させる可能性があります。

幸いなことに、ウェブ上でのプライバシーの必要性についての認識が高まり、具体的な行動につながっています。現在、ウェブサイトは、機密性の高いリソースへのアクセスを保護するための機能を利用できるようになっています。世界中の法律が、個人データの共有について、ユーザーの明示的な同意を義務付けています。ウェブサイトは、プライバシーポリシーやクッキーのバナーを実装し、これに準拠しています。最後にブラウザは、広告や不正行為の検出などのユースケースをよりプライバシーに配慮した方法でサポートし続けるために、革新的な技術を提案し、開発しています。

最終的には、ユーザーは自分の個人データがどのように扱われるかについて発言する権限を与えられるべきです。一方、ブラウザやウェブサイトの所有者は、ユーザーのプライバシーが保護されていることを保証する技術的な手段を開発し、配備する必要があります。ウェブとのインタラクション全体にプライバシーを組み込むことで、ユーザーは自分の個人データが十分に保護されていることをより確信できます。
