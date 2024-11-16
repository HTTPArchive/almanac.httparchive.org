---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: プライバシー
description: 2020年版Web Almanacのプライバシーの章では、オンライントラッキングCookie、プライバシー強化技術（PET）、プライバシーポリシーについて解説しています。
hero_alt: Hero image of Web Almanac characters with cameras, phones, and microphones acting like paparazzi while another character pulls back a shower curtain to reveal a web page behind it.
authors: [ydimova]
reviewers: [ldevernay]
analysts: [ydimova, max-ostapenko]
editors: [tunetheweb]
translators: [ksakae1216]
ydimova_bio:  Yana Dimovaは、ベルギーのKUルーヴェン大学の博士課程に在籍し、プライバシーとウェブセキュリティの研究を行っています。
discuss: 2046
results: https://docs.google.com/spreadsheets/d/16bE70rv4qbmKIqbZS1zUiTRpk5eOlgxBXEabL1qiduI/
featured_quote: 最近、プライバシーの重要性が高まり、ユーザー側の意識も高まっています。ガイドラインの必要性は、様々な規制（ヨーロッパのGDPR、ブラジルのLGPD、カリフォルニアのCCPAなど）によって満たされてきました。これらは、データ処理者の説明責任とユーザーに対する透明性を高めることを目的としています。本章では、さまざまな手法によるオンライントラッキングの普及と、ウェブサイトにおけるCookie同意バナーやプライバシーポリシーの採用率について説明します。
featured_stat_1: 93%
featured_stat_label_1: 少なくとも1つのトラッカーを読み込んでいるウェブサイト
featured_stat_2: Nine out of ten
featured_stat_label_2: Googleが所有するCookie設定の上位ドメイン
featured_stat_3: 44.8%
featured_stat_label_3: プライバシーポリシーを定めているウェブサイト
---

## 序章

Web Almanacのこの章では、Web上のプライバシーの現状を概観します。このトピックは、最近人気が高まっており、ユーザー側の意識も高まっています。ガイドラインの必要性は、さまざまな規制によって満たされてきました（ヨーロッパの<a hreflang="en" href="https://gdpr-info.eu/">GDPR</a>、ブラジルの<a hreflang="en" href="https://lgpd-brazil.info/">LGPD</a>、カリフォルニアの<a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">CCPA</a>など）。これらは、データ処理業者の説明責任とユーザーに対する透明性を高めることを目的としています。本章では、さまざまな技術を用いたオンライントラッキングの普及状況と、ウェブサイトにおけるCookie同意バナーやプライバシーポリシーの採用率について説明します。

## オンライントラッキング

第三者のトラッカーは、ユーザーデータを収集してユーザーの行動のプロファイルを構築し、広告目的で収益化します。このことは、ウェブ上のユーザーにプライバシーに関する懸念を抱かせ、その結果、さまざまなトラッキング保護手段が登場することになりました。しかし、このセクションでご紹介するように、オンライントラッキングは今でも広く利用されています。プライバシーに悪影響を及ぼすだけでなく、オンライン・トラッキングは<a hreflang="en" href="https://gerrymcgovern.com/calculating-the-pollution-cost-of-website-analytics-part-1/">環境に多大な影響を与えており</a>、それを避けることは[パフォーマンスの向上](https://x.com/fr3ino/status/1000166112615714816)につながります。

サードパーティーCookieとフィンガープリンティングを用いた、もっとも一般的なサードパーティートラッキングを検証します。オンライントラッキングはこの2つの手法に限らず、既存の対策を回避するための新しい手法が次々と生まれています。

### サードパーティートラッカー

当社では、<a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a>のトラッカーリストを使用して、潜在的なトラッカーにリクエストを発行するウェブサイトの割合を調べています。次の図に示すように、少なくとも1つの潜在的なトラッカーがおよそ93％のウェブサイトに存在することがわかりました。

{{ figure_markup(
  image="privacy-websites-that-load-trackers.png",
  caption="少なくとも1つの潜在的なトラッカーを含むウェブサイト",
  description="デスクトップWebサイトの92.94％、モバイルWebサイトの92.97％がトラッカーを搭載していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1325818112&format=interactive",
  sheets_gid="1591448294"
  )
}}

私たちは、もっとも広く使われているトラッカーを調べ、もっとも人気のある10種類のトラッカーの普及率をプロットしました。

{{ figure_markup(
  image="privacy-biggest-third-party-potential-trackers.png",
  caption="トップ10の潜在的なトラッカー",
  description="モバイルとデスクトップのクライアントで使用されているもっとも人気のある10種類の潜在的なトラッカーの普及率を示す棒グラフ。デスクトップとモバイルではほとんど差がなく、モバイルでgoogle_analyticsが65.5%、googleapis.comが65.9%、gstaticが63.3%、google_fontsが58.3%、doubleclickが50.0%、googleが47.6%、google_tag_managerが42.4%、facebookが30.9%、google_adservicesが19.2%、cloudflareが12.7%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=850649042&format=interactive",
  sheets_gid="1677398038"
  )
}}

オンライントラッキング市場の最大手は、間違いなくGoogleです。同社の8つのドメインがトラッカー候補のトップ10に入っており、少なくとも70％のウェブサイトで利用されています。次いでFacebook、Cloudflarと続きますが、後者はホスティングサイトとしての人気を反映していると思われます。

WhoTracksMeのトラッカーリストには、トラッカーが所属するカテゴリーも定義されています。CDNとホスティングサイトを統計から除外すると、これらのサイトはトラッキングを行わないか、少なくともそれが主な機能ではないと仮定すると、トップ10の見方が少し変わります。

{{ figure_markup(
  image="privacy-biggest-third-party-trackers.png",
  caption="トップ10トラッカー",
  description="モバイルとデスクトップのクライアントで使用されているもっとも人気のある10種類のトラッカーの普及率を示す棒グラフ。デスクトップとモバイルの差はほとんどなく、モバイルではgoogle_analyticsが65.5％、doubleclickが50.0％、googleが47.6％、google_tag_managerが42.4％、facebookが30.9％、google_adservicesが19.2％、youtubeが12.7％、google_syndicationが19.2％、twitterとwordpress_statsがともに6.5％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1831606887&format=interactive",
  sheets_gid="1677398038"
  )
}}

ここでは、トップ10のドメインのうち7つをGoogleが占めています。次の図は、潜在的なトラッカーの数が多い100件について、カテゴリー別の分布を示したものです。

{{ figure_markup(
  image="privacy-tracker-categories.png",
  caption="ポテンシャルトラッカー100選のカテゴリー",
  description="ウェブ上の潜在的なトラッカーのトップ100の分布を示す棒グラフで、広告が56、cdnが11、site_analyticsが9、ソーシャルメディアとmiscの両方が6、essentialとcustomer_helpの両方が3、オーディオとビデオの両方が2、コメントとundefinedの両方が1となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1117413918&format=interactive",
  sheets_gid="1431872451",
  )
}}

もっとも人気のあるトラッカーの60％近くが広告関連である。これは、オンライン広告市場の収益性がトラッキングの量に関係していると認識されているためと考えられる。

### Cookies

WebサイトでHTTPのレスポンスヘッダーに設定されているもっとも一般的なCookieを、その名前とドメイン別に調べました。

<figure>
  <table>
    <thead>
      <tr>
        <th>ドメイン</th>
        <th>Cookieの名称</th>
        <th>ウェブサイト</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="デスクトップサイトのトップCookie", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>ドメイン</th>
        <th>Cookieの名称</th>
        <th>ウェブサイト</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">32%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>DSID</code></td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>yandexuid</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>i</code></td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="モバイルサイトのトップCookie", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

ご覧のとおり、Googleのトラッキングドメイン「doubleclick.net」は、モバイルクライアントでは約4分の1、デスクトップクライアントでは全Webサイトの3分の1のWebサイトにCookieを設定しています。ここでも、デスクトップクライアントでもっとも人気のある10個のCookieのうち9個、モバイルでは10個のうち7個がGoogleのドメインによって設定されています。これは、HTTPヘッダーを介して設定されたCookieのみをカウントしているため、Cookieが設定されているウェブサイトの数の下限となります。

### フィンガープリンティング

もう1つの広く使われているトラッキング技術は、フィンガープリンティングです。これは、ユーザーに固有の「フィンガープリント」を作成することを目的として、ユーザーに関するさまざまな種類の情報を収集するものです。ウェブ上では、さまざまな種類のフィンガープリンティングがトラッカーによって使用されています。ブラウザフィンガープリントでは、ユーザーのブラウザに固有の特性を使用します。これは、追跡するための変数の数が十分に多ければ、他のユーザーがまったく同じブラウザを設定している可能性はかなり低くなるという事実に基づいています。今回の調査では、ブラウザ・フィンガープリントをサービスとして提供している<a hreflang="en" href="https://fingerprintjs.com/">FingerprintJS</a>ライブラリの存在を調べました。

{{ figure_markup(
  image="privacy-websites-with-fingerprintjs-library.png",
  caption="FingerprintJSを使用しているサイト",
  description="Barchartによると、デスクトップサイトの0.17％、モバイルサイトの0.18％がFingerprintJSを使用している。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1556252953&format=interactive",
  sheets_gid="222110824",
  sql_file="percent_of_websites_with_fingerprinting.sql "
  )
}}

このライブラリはウェブサイトのごく一部にしか存在していませんが、フィンガープリンティングの永続的な性質から、わずかな使用でも大きな影響を与える可能性があります。さらに、フィンガープリンティングの試みはFingerprintJSだけではありません。他のライブラリ、ツール、ネイティブコードでもこの目的を果たすことができますので、これは一例に過ぎません。

## コンセントマネジメント・プラットフォーム

Cookie同意バナーは今や一般的になっています。このバナーは、Cookieに対する透明性を高め、しばしばユーザーがCookieの選択肢を指定できるようにします。多くのウェブサイトが独自のCookie・バナーの実装を選択していますが、最近では<em>Consent Management Platforms</em>と呼ばれる第三者のソリューションが登場しています。このプラットフォームは、ウェブサイトがさまざまなタイプのCookieに対するユーザの同意を収集するための簡単な方法を提供します。4.4%のウェブサイトが同意管理プラットフォームを使用して、デスクトップ・クライアントでのCookieの選択を管理しており、モバイル・クライアントでは4.0%となっています。

{{ figure_markup(
  image="privacy-websites-with-consent-management-platform.png",
  caption="コンセント・マネジメント・プラットフォームを使用しているウェブサイト",
  description="デスクトップサイトの4.4%、モバイルサイトの4.0%がConsent Management Platformを利用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=2025542332&format=interactive",
  sheets_gid="1910033502",
  sql_file="percent_of_websites_with_cmp.sql"
  )
}}

{{ figure_markup(
  image="privacy-consent-management-platform-popularity.png",
  caption="コンセント・マネジメント・プラットフォームの普及",
  description="バーチャートでは、Osanoが1.6％、Quantcast Choiceが1.0％、CookiebotとOneTrustが0.4％、Iubendaが0.3％、Crownpeak、Didomi、TrustArcが0.1％、CIVIC、Cookie Script、CookieHub、Termly、Uniconsent、CookieYes、eucookie.eu、Seers、Metomicが約0.0％となっており、人気の高い同意管理プラットフォームが示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341496718&format=interactive",
  sheets_gid="1104760876",
  sql_file="percent_of_websites_using_each_cmp.sql"
  )
}}

さまざまな同意管理ソリューションの人気度を見ると、OsanoとQuantcast Choiceが主要なプラットフォームです。

### IABヨーロッパのトランスペアレンシー・コンセント・フレームワーク

IABヨーロッパ（Interactive Advertising Bureau）は、ヨーロッパのデジタルマーケティングと広告に関する団体です。彼らは、デジタル広告の好みに関するユーザーの同意を得るために、GDPRに準拠したソリューションとして、<a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency Consent Framework</a>（TCF）を提案しました。この実装は、パブリッシャーと広告主の間で消費者の同意に関するコミュニケーションを行うための業界標準を提供するものです。

{{ figure_markup(
  image="privacy-adoption-of-the-tcf-banner.png",
  caption="TCFバナーの採用率",
  description="デスクトップサイトの1.5％、モバイルサイトの1.4％がIABヨーロッパのTCFバナーを導入していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341275612&format=interactive",
  sheets_gid="2077755325",
  sql_file="percent_of_websites_with_iab_tcf_banner.sql"
  )
}}

今回の結果は、TCFバナーがまだ「業界標準」ではないことを示していますが、正しい方向への一歩と言えるでしょう。IABヨーロッパの主なターゲットはヨーロッパのパブリッシャーであり、私たちの活動はグローバルなものであることを考えると、デスクトップクライアントで1.5%、モバイルでは1.4%のウェブサイトで採用されていることは悪くないと思います。

## プライバシーポリシー

プライバシーポリシーは、法的義務を果たし、データ収集方法についてユーザーへの透明性を高めるために、ウェブサイトで広く使用されています。クロールでは、訪問したウェブサイトにプライバシーポリシーのテキストが存在することを示すキーワードを検索しました。

{{ figure_markup(
  image="privacy-websites-with-privacy-link.png",
  caption="プライバシーポリシーのあるサイト",
  description="デスクトップサイトの44.8％、モバイルサイトの42.3％がプライバシーリンクを設置していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=329249623&format=interactive",
  sheets_gid="495362514",
  sql_file="percent_of_websites_with_privacy_links.sql "
  )
}}

その結果、データセットに含まれるウェブサイトの約半数がプライバシーポリシーを記載していることがわかり、ポジティブな印象を受けました。しかし研究によると大多数のインターネットユーザーは、プライバシーポリシーを読もうとはせず、読んだとしても、ほとんどのプライバシーポリシーの文章が長くて複雑なため、理解できていないことがわかっています。しかし、プライバシーポリシーが存在することは、正しい方向への一歩と言えるでしょう。

## 結論

本章では、デスクトップとモバイルの両方のクライアントにおいて、第三者によるトラッキングが依然として顕著であり、Googleがもっとも多くのウェブサイトをトラッキングしていることを示しました。コンセント管理プラットフォームが使用されているウェブサイトの割合は少ないですが、多くのウェブサイトでは、独自のCookie同意バナーが実装されています。

最後に、約半数のウェブサイトがプライバシーポリシーを掲載しており、データ処理の方法についてユーザーに大きな透明性をもたらしています。これは間違いなく一歩前進ですが、まだやるべきことはたくさんあります。今回の分析以外にも、プライバシーポリシーは読みにくく理解しにくいものであり、Cookieの同意バナーはユーザーを操作して同意させるものであることがわかっています。

ウェブが真にユーザーを尊重するためには、プライバシーは後回しにするのではなく、発想の一部にしなければなりません。この点において、規制は良いことであり、世界的にプライバシー規制が増加していることは心強いことです。[プライバシーバイデザイン](https://ja.wikipedia.org/wiki/%E3%83%97%E3%83%A9%E3%82%A4%E3%83%90%E3%82%B7%E3%83%BC%E3%83%90%E3%82%A4%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3)は、最低限の法的要件を満たし、金銭的なペナルティを避けるためにポリシーやツールを導入するのではなく、規範となるべきものです。
