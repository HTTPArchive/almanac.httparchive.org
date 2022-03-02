---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: サードパーティ
description: 2021年版Web Almanacのサードパーティの章では、どのようなサードパーティが使用されているか、何のために使用されているかのデータ、パフォーマンスへの影響についての深堀、セキュリティやプライバシーへの影響についての考察をカバーしています。
authors: [tunetheweb]
reviewers: [patrickhulce, andydavies, simonhearne, csswizardry]
analysts: [tunetheweb]
editors: [rviscomi]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1tf4RMF8SYr6he9tbqt61yuFJ_QK-F-i7XPxaPkpKSDI/
tunetheweb_bio: Barry Pollard はソフトウェア開発者であり、Munning の本 <a hreflang="en" href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a> の著者です。彼は、ウェブは素晴らしいが、それをさらに良くしたいと思っている。ツイッターは<a href="https://twitter.com/tunetheweb">@tunetheweb</a> 、ブログは<a hreflang="en" href="https://www.tunetheweb.com">www.tunetheweb.com</a> でご覧いただけます。
featured_quote: サードパーティはウェブに不可欠な存在です。サードパーティーの普及がなければ、ウェブサイトを構築するのは難しく、機能も充実していないでしょう。
featured_stat_1: 94.4%
featured_stat_label_1: サードパーティを利用したサイト
featured_stat_2: 1,626 ms
featured_stat_label_2: YouTubeの埋め込みメインスレッドのブロック時間
featured_stat_3: 45.9%
featured_stat_label_3: サードパーティのリクエスト
---

## 序章

ああ、サードパーティはウェブ上の多くの問題の解決策であり。。。他の多くの問題の原因でもあります。基本的に、ウェブは常に相互接続と共有のためにあります。サードパーティのコンテンツをウェブサイトで使用することは、その自然な延長であり、HTML 2.0の<a hreflang="en" href="https://www.w3.org/MarkUp/html-spec/html-spec_5.html#SEC5.10">`<img>`要素の導入ではじめて動き出したものである。</a>それ以来、外部のコンテンツを直接文書にハイパーリンクすることができるようになりました。これは、[CSS](./css) や [JavaScript](./javascript) の導入により、一見単純な `<link>` や `<script>` 要素を含むだけでページの一部（または全部！）を完全に変更することができるようになり、さらに発展しています。

サードパーティは、画像、ビデオ、フォント、ツール、ライブラリ、ウィジェット、トラッカー、広告、その他あなたが想像できるあらゆるものを、私たちのウェブページへ埋め込むために、尽きることのないコレクションを提供しています。これにより、技術者でない人でもコンテンツを作成し、ウェブに公開することができるようになりました。サードパーティがいなければ、ウェブは今日の私たちの生活に欠かせないリッチで没入感のある複雑なプラットフォームではなく、非常に退屈な、テキストベースの学術的メディアになる可能性が高いでしょう。

しかし、ウェブ上でサードパーティーのコンテンツを利用することには、暗黒面があります。画像や便利なライブラリを無邪気に取り入れると、多くの開発者が十分に考慮しない、あらゆる種類の[パフォーマンス](./performance)、[プライバシー](./privacy)、[セキュリティ](./security)への門が開かれます。そのような業界のプロフェッショナルに話を聞くと、彼らはサードパーティのコンテンツの使用が生活をより困難にしていることを嘆きます。<a hreflang="ja" href="https://web.dev/i18n/ja/vitals/">GoogleのCore Web Vitals initiative</a> によってパフォーマンスがとくに注目され、政府や個人によるプライバシーへの注目が高まり、Webに固有の悪意のある脆弱性の脅威が増え続ける中、精査は確実に進むと思われます。

この章では、ウェブにおけるサードパーティの状況について見ていきます。サードパーティをどれくらい使っているのか、何のために使っているのか、そしてとくに上記3つの懸念事項を考慮すると、昨年から使い方に変化はあったのでしょうか。これらの疑問に答えたいと思います。

## 定義

何をもって「サードパーティ」とするか、「サードパーティのコンテンツを利用」とするかについては、それぞれ考え方が異なるでしょうから、この章ではまず「サードパーティとは何か」という定義から説明します。

### "サードパーティ"

サードパーティの定義は、[2019](../2019/third-parties)、[2020](../2020/third-parties)編と同じものを使用していますが、少し異なる解釈をすると、次節で述べるように今年はあるカテゴリーを除外することになります。

サードパーティとは、主たるサイト利用者関係の外にある存在、すなわちサイト所有者の直接の管理下にないが、その承認を得て存在する側面のことである。たとえば、Google Analyticsのスクリプトは、一般的なサードパーティリソースの一例です。

サードパーティのリソースは
- 共有・公開オリジンでのホスティング
- さまざまなサイトで広く利用されている
- 個々のサイトオーナーに影響されない

これらの目標にできるだけ近づけるため、この章で使用するサードパーティリソースの正式な定義は、HTTP Archiveデータセット内の少なくとも50のユニークなページでそのリソースが見つかるドメインから発信されるものです。

これらの定義を使用すると、ファーストパーティのドメインから提供されるサードパーティのコンテンツは、ファーストパーティのコンテンツとしてカウントされることに留意してください。たとえば、セルフホスティングのGoogle Fontsや `bootstrap.css` は、_ファーストパーティのコンテンツ_ としてカウントされます。

同様にサードパーティのドメインから提供されたファーストパーティコンテンツは、たとえリソース自体がそのウェブサイトに固有のものであっても、「50ページ以上の基準」をクリアしていれば、サードパーティのコンテンツとしてカウントされます（ドメインによってはそうなる可能性があります）。たとえば、サードパーティのドメインでCDNを介して提供されるファーストパーティの画像は、_サードパーティ_とみなされます。

### サードパーティーのカテゴリー

今年も、サードパーティを特定し分類するために、<a hreflang="en" href="https://twitter.com/patrickhulce">Patrick Hulce</a> による <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/master/data/entities.js">third-party-web</a> リポジトリを大いに利用する予定です。このリポジトリでは、よく使われるサードパーティのURLを以下のように分類しています。
- **Ad** - これらのスクリプトは、広告ネットワークの一部であり、配信または測定を行っています。
- **Analytics** - ユーザーとその行動を測定または追跡するスクリプトです。何を追跡するかによって、さまざまな影響があります。
- **CDN** - これらは、一般にホストされているオープンソースライブラリ（例：jQuery）が、さまざまなパブリックCDNやプライベートCDNで提供されているものです。
- **Content** - これらのスクリプトは、コンテンツプロバイダーや出版社特有のアフィリエイトトラッキングによるものです。
- **Customer Success** - これらのスクリプトは、チャットやコンタクトソリューションを提供するカスタマーサポート/マーケティングプロバイダーからのものです。これらのスクリプトは、一般的に重いスクリプトです。
- **Hosting** - これらのスクリプトは、ウェブホスティングプラットフォーム（WordPress、Wix、Squarespaceなど）のものです。
- **Marketing** - これらのスクリプトは、ポップアップ/ニュースレターなどを追加するマーケティングツールのものです。
- **Social** - ソーシャル機能を実現するスクリプトです。
- **Tag Manager** - これらのスクリプトは、他の多くのスクリプトをロードし、多くのタスクを開始させる傾向があります。
- **Utility** - これらのスクリプトは、開発者向けのユーティリティ（APIクライアント、サイト監視、不正検出など）です。
- **Video** - ビデオプレーヤーやストリーミング機能を実現するスクリプトです。
- **Other** - これらは共有のオリジンを介して配信される雑多なスクリプトで、正確なカテゴリや属性はありません。

<p class="note">注：ここでいうCDNのカテゴリには、公開CDNドメイン（bootstrapcdn.com、cdnjs.cloudflare.comなど）でリソースを提供するプロバイダが含まれ、単にCDN経由で提供されるリソースは含まれません。たとえば、Cloudflareをページの前に置いても、私たちの基準によるファーストパーティの指定には影響しません。</p>

今年、私たちが行った方法の変更の1つは、ホスティングカテゴリを分析から除外することです。WordPress.comをブログに、Shopifyをeコマースプラットフォームに使用している場合、そのサイトによるこれらのドメインに対する他のリクエストは多くの点でこれらのプラットフォームのホスティングの一部であり、真の「サードパーティ」ではないとして無視することにしています。上記の注記と同様に、ページの前にあるCDNは「サードパーティ」とは見なしません。実際には、これは数字にほとんど影響を与えませんでしたが、上記の定義で「サードパーティ」と見なすべきものをより正確に反映し、また他の章がこの用語をどのように使用しているかにより近いと私たちは考えています。

### 注意事項

- ここで紹介するデータはすべて、非インタラクティブ、コールドロードに基づくものです。これらの値は、ユーザーとのインタラクションの後では、かなり違って見えるようになる可能性があります。
- ページはCookieが設定されていない米国内のサーバーからテストされているため、オプトイン後に要求されたサードパーティは含まれません。これはとくに、<a href="https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87">一般データ保護規則</a>やその他の類似の法律の適用範囲にある国でホストされ、主に提供されるページに影響します。
- トップページのみテストしています。その他のページでは、サードパーティーの要件が、異なる場合があります。
- あまり使われていないサードパーティードメインの一部は、_unknown_カテゴリに分類されています。この分析の一環として、サードパーティウェブデータセットを改善するために、使用率の高いドメインのカテゴリを増やして提出しました。

[方法論](./methodology)の詳細はこちらです。

## 普及率

では、サードパーティはどの程度利用されているのでしょうか。その答えは、「たくさん」です。

{{ figure_markup(
  caption="少なくとも1つのサードパーティリソースを使用しているモバイルサイトの割合。",
  content="94.4%",
  classes="big-number",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party.sql"
)
}}

なんと、モバイルサイトの94.4％、デスクトップサイトの94.1％が、少なくとも1つのサードパーティリソースを利用していることが判明しました。サードパーティの定義を新しくしたとはいえ、これはWeb Almanacがスタートした[2019](../2019/third-parties)当時から継続的に成長していることを表しています。

{{ figure_markup(
  image="third-parties-websites-using-third-parties-by-year.png",
  caption="サードパーティを利用しているウェブサイト（年別）",
  description="過去3年間にサードパーティを利用したWebサイトの数を、デスクトップとモバイルに分けて示した棒グラフです。デスクトップでは、2019年に89.1%のWebサイトがサードパーティを利用し、次いで2020年93.9%、2021年94.1%のWebサイトがサードパーティを利用しています。モバイルでは、2019年に88.5％がサードパーティを利用し、次いで2020年に94.0％、2021年に94.4％となっています",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1728778967&format=interactive",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party.sql"
  )
}}

過去3回のWeb Almanacのデータセットを、より厳格な新しい定義で再実行したところ、上のグラフのように、当社のウェブサイトにおけるサードパーティの利用は、デスクトップで0.2%、モバイルでは0.4%と昨年よりわずかに増加していることがわかりました。

{{ figure_markup(
  caption="サードパーティからのリクエストの割合。",
  content="45.9%",
  classes="big-number",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party.sql"
)
}}

モバイルで45.9%、デスクトップでは45.1%がサードパーティからのリクエストで、これは[昨年の結果](../2020/third-parties)とほぼ同じです。

<a href="https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87">GDPR</a> や <a href="https://en.wikipedia.org/wiki/California_Consumer_Privacy_Act">CCPA</a> のようなプライバシー保護のための規制は、第三者の使用に対する私たちの意欲を減退させていないように思われます。ただし、私たちの[方法論](./methodology)は、米国のデータセンターからウェブサイトをテストしているので、そのために異なるコンテンツが提供されるかもしれないことを忘れてはなりません。

では、ほぼすべてのサイトがサードパーティを利用していることはわかったが、どれくらいの数を利用しているのだろうか。

{{ figure_markup(
  image="third-parties-number-of-third-parties-per-website.png",
  caption="ウェブサイト毎のサードパーティの数。",
  description="デスクトップとモバイルのウェブサイトごとのサードパーティードメインの数をさまざまなパーセンタイルで示した棒グラフです。10パーセンタイルではデスクトップ、モバイルともにサイトあたりのサードパーティ数は2、25パーセンタイルではデスクトップが9、モバイルが8、それぞれ23と21、50パーセンタイルでは50と46、75パーセンタイルではそれぞれ91と89になっています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=2111523872&format=interactive",
  sheets_gid="1338630434",
  sql_file="distribution_of_websites_by_number_of_third_parties.sql"
  )
}}

サードパーティーのホストネームの数で示されるサードパーティーを2つしか使用していないウェブサイトが10パーセンタイルにあり、90パーセンタイルでは89または91までと、大きなばらつきがあります。

なお90パーセンタイルは、デスクトップとモバイルでそれぞれ104と106だった[昨年の分析](../2020/third-parties#fig-2)から少し下がっていますが、これは昨年の統計で行わなかった、今年50ウェブサイト以上で使用されている資産にドメインを限定したことに起因しているようです。

中央値のウェブサイトは、モバイルで21、デスクトップで23のサードパーティを使用しており、これでもかなり多いようです。

### ランク別サードパーティ普及率

{{ figure_markup(
  image="third-parties-websites-using-third-parties-by-rank.png",
  caption="ランク別にサードパーティを利用したウェブサイトを紹介。",
  description="さまざまなランクのカテゴリーにおいて、モバイルとデスクトップ別にサードパーティを利用しているWebサイトの割合を示す棒グラフです。上位1,000サイトではデスクトップ96.6%、モバイル96.9%がWebサイトを利用しており、上位1万サイトではそれぞれ96.8%、96.6%、上位10万サイトは94.5%、94.4%、上位百サイトでは93.4%、93.3%、最後に全サイトで94.1%、94.4%とほぼ同様の数値になっています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=871714070&format=interactive",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

今年は、各ウェブサイトの<a hreflang="en" href="https://developers.google.com/web/updates/2021/03/crux-rank-magnitude">Chrome UX Report (CrUX) "rank"</a> へアクセスできるようになりました。これは各サイトの人気度を割り出すもので、これにより、もっとも利用されている上位1,000サイト（ページビューベース）、上位10,000サイトなどにデータを分類できます。この人気順位でデータをスライスすると、人気のないウェブサイトではサードパーティの利用率がわずかに減少していますが、93.3%を下回ることはなく、かなり多くのウェブサイトが少なくとも1つのサードパーティを含めることが好きであることを再確認できます。

しかし、変わるのは、ウェブサイトが利用するサードパーティの数です。

{{ figure_markup(
  image="third-parties-per-website-by-rank.png",
  caption="ウェブサイトあたりのサードパーティ数の順位別中央値。",
  description="さまざまなランキングのデスクトップとモバイル別に、1ウェブサイトあたりのサードパーティドメイン数の中央値を示した棒グラフです。上位1,000ウェブサイトでは、デスクトップで47、モバイルで40のサードパーティが使用されていますが、これが上位10,000ウェブサイトではそれぞれ42と39、上位10万ウェブサイトでは32と30、上位100万ウェブサイトでは26と25、すべてのウェブサイトでは23と21にまで減少しています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1770094484&format=interactive",
  sheets_gid="1338630434",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

中央値（50パーセンタイル）の統計を見ると、ランキングが上がるにつれて著しく低下しており、もっとも人気のあるウェブサイトは、データセット全体の2倍の数のサードパーティを使用していることがわかります。これは、ほぼ完全に広告によってもたらされていることがおわかりいただけると思います。これは、収益化する目玉が増える、より人気のあるウェブサイトでより一般的であることは、おそらく驚くべきことではないでしょう。

## サードパーティーの種類

私たちの分析によると、私たちはサードパーティーをたくさん使っているようですが、何のために使っているのでしょうか？各サードパーティーのリクエストのカテゴリーを見てみると、以下のようになります。

{{ figure_markup(
  image="third-parties-requests-by-type.png",
  caption="サードパーティリクエストの種類別内訳",
  description="積み上げ棒グラフでは、`ad`のサードパーティはデスクトップで25.7%、モバイルでは29.1%、`unknown`のサードパーティはそれぞれ19.8%と19.6%、`cdn`は15.2%と13.4%、`social`は11.0%と10.1%、`utility`は8.6%と8.7%、`analytics`は8.0%と8.6%、`video`は4.0%と3.5%、`tag-manager`は2.5%と2.4%、`customer-success`は1.6%と1.5%、`marketing`は1.4%と1.2%、`content`は1.1%と0.9%、`other`は0.9%と0.8%、最後に`consent-provider`は0.2%と0.2%でした。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1925773513&format=interactive",
  sheets_gid="1613966374",
  sql_file="percent_of_third_party_requests_and_bytes_by_category_and_content_type.sql"
  )
}}

adがもっとも多く、次いで「unknown」（分類されていない、またはあまり利用されていないさまざまなサイトの集合体）、そしてCDN、social、utility、analyticsという順になっています。このように、あるカテゴリが他のカテゴリよりも人気がある一方で、サードパーティの利用がいかに多様であるかということが、おそらくここから得られる大きな収穫です。1つや2つのユースケースがすべてを支配するのではなく、本当にさまざまな理由で使われているのです。

### サードパーティリクエストの種類と順位

{{ figure_markup(
  image="third-parties-median-third-party-requests-by-type-and-rank-on-mobile.png",
  caption="サードパーティーのリクエストの種類と順位別の中央値。",
  description="各タイプのリクエスト数をランキング形式で表示した積み上げ棒グラフ。上位1,000サイトでは、中央値で`ad`サードパーティが20、`unknown` 17、`cdn` 4、`social` 6、`utility` 3、`analytics` 5、`video` 3、`tag-manager` 2、`customer-success` 9、`marketing` 2、`content` 5、`other` 2、`consent-provider` 6が存在してます。上位1万サイトでは、中央値が19、12、4、6、4、5、4、2、9、2、5、2、6となっています。上位10万人では、13、9、5、6、3、4、9、2、10、3、5、2、4となってます。トップミリオンでは、6、7、5、3、11、1、10、3、5、2、2です。全サイトでは、4、7、5、3、11、1、9、3、5、2、1です。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1542898751&format=interactive",
  sheets_gid="1430893885",
  sql_file="number_of_third_parties_by_rank_and_category.sql"
  )
}}

順位別、カテゴリー別に分けてみると、先に述べたリクエスト数の多さの理由が見えてきます。人気のあるサイトでは、広告がより多く利用されてます。

このグラフは、各カテゴリーの順位別リクエスト数の中央値を示していますが、すべてのページですべてのカテゴリーが使用されているわけではありません。そのため、順位ごとの合計が、前のグラフの順位別リクエスト数の中央値よりもずっと高くなっているのです。

## コンテンツの種類

このデータをもとに、サードパーティからのリクエストからどのようなコンテンツが返ってくるかを見てみましょう。

{{ figure_markup(
  image="third-parties-usage-by-content-type.png",
  caption="コンテンツタイプ別のサードパーティ利用状況。",
  description="積み上げ棒グラフで示す。デスクトップにおけるサードパーティからのリクエストのうち、`script` リソースが33.6% を占め、`image` 28.7%, `html` 10.6%, `other` 7.9%, `font` 8.4%, `css` 6.4%, `text` 3.8%, `video` 0.3%, `audio` 0.2%, そして最後に `xml` 0.1% となっています。モバイルでは、サードパーティのリソースのうち、`script`が33.2％、`image`が28.6％、`html`が12.3％、`other`が8.6％、`font`が6.7％、`css`が6.3％、`text`が3.7％、`video`が0.2％、`audio`が0.2％、そして最後に`xml`が0.1％でした。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=521975460&format=interactive",
  sheets_gid="655382603",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

当然のことながら、[JavaScript](./javascript)、[images](./media)、[HTML](./markup)がサードパーティからのリクエストの大部分を占めています。JavaScriptは、広告、トラッカー、ライブラリなど、機能を追加するためにほとんどのサードパーティによって使用されます。同様に、トラッキングソリューションで好まれる1ピクセルの空白画像も含まれるため、画像の使用頻度が高いことも予想されます。

HTMLの使用率が高いことは、最初は意外に思われるかもしれません（確かにドキュメントはHTMLの一般的な形式であり、それらはファーストパーティのリクエストでしょう）。しかし調査の結果、ほとんどiframeであることがわかりました。これは、広告やその他のウィジェットを格納するために使用されることが多いので、より理にかなっています（たとえば、YouTubeは動画そのものではなくプレーヤーを含むiframeでHTMLドキュメントを提供します）。

だから、純粋にリクエストの数で判断します。サードパーティは、コンテンツよりも機能を追加しているように見えますが、それは少し誤解があります。YouTubeの例のように、一部のサードパーティはコンテンツを有効にするため機能を追加しています。

{{ figure_markup(
  image="third-parties-requests-by-content-type-and-category-on-mobile.png",
  caption="コンテンツの種類およびカテゴリー別サードパーティからのリクエスト（モバイル）。",
  description="サードパーティーの種類とコンテンツタイプ別に、サードパーティーのバイト数を棒グラフで表示したものです。`ad`の場合、ほとんどがスクリプトのバイト数で、画像やhtmlは少量、それ以外のものはほとんどありません。`analytics`に関しては98%がスクリプト、`cdn`はほぼすべてがスクリプトかフォント、`consent-provider`もほぼすべてがスクリプトです。`content` のタイプは、スクリプトが少し、画像が少し、しかしほとんどがビデオと少しのオーディオです。`customer-success`はほぼスクリプト、`marketing`はスクリプトと画像、`other`は画像とスクリプト、socialはスクリプトか画像、tag-managerは99.8%がスクリプト、`unknown`はスクリプトと画像が多い、utilityはスクリプトと画像、videoは少量のビデオで似ています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=304580528&format=interactive",
  sheets_gid="1613966374",
  sql_file="percent_of_third_party_requests_and_bytes_by_category_and_content_type.sql"
  )
}}

リクエストされたコンテンツの種類をサードパーティーの種類で分けると、ほとんどの種類でスクリプト、画像、HTMLの3種類が多く、JavaScriptの多いことがわかります（動画タイプでも！）。上の図はモバイルのものですが、デスクトップの様子もよく似ています。

{{ figure_markup(
  image="third-parties-bytes-by-content-type-and-category-on-mobile.png",
  caption="コンテンツの種類とカテゴリー別のサードパーティリクエスト。",
  description="モバイルのコンテンツタイプ別に、各サードパーティーの内訳を示した棒グラフ。`ad`サードパーティーのリクエストは、スクリプト、画像、html、その他に、少量のテキストがかなり均等に分かれています。アナリティクスはスクリプトと画像が中心で、html、その他、テキストは少量です。`cdn`のリクエストでは、スクリプト、画像、CSSが混在していますが、ほとんどがフォントです。次のセット（`consent-providers`, `content`, `customer-success`, `marketing`, `other`, `social`, `tag-manager`, `unknown` と `utility`）はほぼすべてスクリプトか画像である。`video` も同様で、動画コンテンツの量はグラフ上でも目立ちません。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=4067008&format=interactive",
  sheets_gid="1613966374",
  sql_file="percent_of_third_party_requests_and_bytes_by_category_and_content_type.sql"
  )
}}

リクエスト数ではなく、バイト数で見ると、JavaScriptの多さがさらに気になります。ここでもモバイルを示しましたが、デスクトップの場合に大きな違いはありません。

<a hreflang="en" href="https://twitter.com/addyosmani">Addy Osmani</a>（同じ文章で2回！）の<a hreflang="en" href="https://medium.com/@addyosmani/the-cost-of-javascript-in-2018-7d8950fbb5d4">"Cost of JavaScript"</a> 投稿を引用すると、「バイト単位でみるとJavaScriptは今でも私たちが送信するもっとも高価なリソース」、そして「200KBのスクリプトと200KBの画像にはまったく異なるコスト」だそうです。Analytics、Consent Provider、Tag ManagerなどのカテゴリはかなりJavaScriptが多く、AdやCustomer Successなどのカテゴリも遠くおよびません。サードパーティーリソースの使用によるパフォーマンスへの影響については、JavaScriptの使用によるコスト高が、原因であることが多いので、また後日ご紹介します。

## サードパーティードメイン

サードパーティからの要望はどこから来るのでしょうか？これらの名前のほとんどは驚くようなものでありませんが、ある名前の普及は、その会社が多くの異なるカテゴリーで優位に立っていることを改めて示すものです。

{{ figure_markup(
  image="third-parties-top-15-by-usage.png",
  caption="サードパーティーの利用率上位15位。",
  description="サードパーティーを利用しているウェブサイトの割合上位15位をデスクトップとモバイルに分けて棒グラフで表示。`*.google-analytics.com` はデスクトップの66.2%、モバイルの62.7%、 `fonts.googleapis.com` で65.1%、62.0%、 `adservice.google.com` で50.5%、48.9%、 `accounts.google.com`で50.3%、48.9%、 `*.googletagmanager.com` で44.8%、42.5%、 `ajax.googleapis.com` で35.5%と31.1%、 `*.facebook.com` は30.8%と29.2%, `amp.cloudflare.com` は12.8%と12.0%, `*.youtube.com` は11.3%と10.2%, `*.bootstrapcdn.com` は10.1%と9.7%, `maps.google.com` は8.0%と9.1%、`*.jsdelivr.net`は7.1%と6.6%、`*.jquery.com`は6.3%と5.9%、`*.fontawesome.com`は6.3%と5.8%、最後に `*.adobedtm.com` は4.5%と5.6% となっています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1408467789&format=interactive",
  sheets_gid="564520146",
  width=600,
  height=494,
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

もっとも利用されているサードパーティーの上位15位のうち8位（うち上位6位）をGoogleが占めており、他の追随を許さない状況です。Googleは、Analytics、フォント、広告、アカウント、タグマネージャー、ビデオなどの分野で市場をリードしています。モバイルサイトの62.7%がGoogle Analyticsを、ほぼ同数がGoogle Fontsを利用しており、広告、アカウント、タグマネージャーも42%から49%の範囲で利用されています。

非Googleの1位はFacebookで、29.2%と比較的低い利用率になっています。続いて、人気の高いライブラリなどを前面に押し出したCloudflareのCDNが続きます。amp.cloudflare.comと表示されていますが、より大きなcdnjs.cloudflare.comも含まれており、来年はよりよく使われるドメインを表示するように更新されました。

この後、YouTubeでGoogleに戻り、Mapsはその2つ後のスポットとなります。残りのスポットは、他の一般的なライブラリやツールのCDNで満たされています。

## サードパーティによるパフォーマンスへの影響

サードパーティを使用すると、パフォーマンスに顕著な影響を与えることがあります。それは、必ずしもサードパーティーであること自体が原因ではありません。サイトオーナーがファーストパーティーリソースとして実装したのと同じ機能でも、サードパーティーが持つ特定の分野の専門知識を考慮すると、パフォーマンスが低下することはよくあるのです。

ですから必ずしもリソースが、サードパーティであることがパフォーマンスに影響するわけではなく、むしろそのリソースが何をしているかが問題なのです。また、サードパーティーの利用は、単にサービスを提供する場所としてではなく、サードパーティーのサービスに依存することがほとんどです。

しかし、第三者のビジネスは、そのコンテンツやサービスが多くのウェブサイトでホストされることを許可することにあります。サードパーティは、その依存による悪影響を最小限に抑えることを保証する義務があるのです。サイト所有者は、サードパーティを利用するかしないか以外に、サードパーティのパフォーマンスへの影響に対するコントロールや影響力が限られていることが多いため、これはとくに重要な義務であると言えます。


### サードパーティードメインの使用とセルフホスティングの比較

ほとんどのサードパーティがグローバルに分散した高性能のCDNを使用しているにもかかわらず、他のドメインに接続するには明確なコストがかかります。多くのウェブパフォーマンス支持者（この著者を含む！）は、このペナルティを避けるために可能な限りセルフホスティングを推奨しています。これは、すべての主要なブラウザがオリジン間でキャッシュを共有しないようになった今、とくに重要なことです。したがって、あるサイトがそのリソースをダウンロードしたら、訪問した他のサイトもその恩恵を受けることができるという主張は、もはや真実ではありません。とはいえ、ライブラリのバージョン数やHTTPキャッシュの制限を考えると、昔もこの主張には疑問があったのですが。

とはいえ、思うようにいかないのが現実で、場合によっては、セルフホストはかえってパフォーマンスを低下させることもあります。筆者は以前、<a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">Googleフォントをセルフホスティングするかどうか</a>という問題は、見た目ほど明確ではなく、パフォーマンス面でGoogleフォントが行っていることをすべて再現するためには、ある程度の専門知識が必要だということを書きました。その手間を省くには、ホストされたバージョンを使用すればよく、<a hreflang="en" href="https://twitter.com/csswizardry">Harry Roberts</a> が <a hreflang="en" href="https://csswizardry.com/2020/05/the-fastest-google-fonts/">The Fastest Google Fonts</a> という投稿で述べたように、パフォーマンスの影響をできる限り軽減していることを確認できます。

同様に画像CDNはほとんどのファーストパーティよりもメディアを最適化することができ、さらに重要なことは必然的に省略されたり、時に間違って行われたりする手動ステップを必要とせずに、自動的にこれを行うことができます。

### 人気のサードパーティの埋め込みとそのパフォーマンスへの影響

サードパーティーのパフォーマンスへの影響を理解するために、もっとも人気のあるサードパーティーの埋め込みをいくつか見ていきます。これらの中には、Webパフォーマンス界で悪名高いものもあるので、その悪評が本当にふさわしいかどうか見てみましょう。そのために、2つの[Lighthouse](./methodology#lighthouse)監査を活用することにします。<a hreflang="en" href="https://web.dev/render-blocking-resources/">レンダーブロッキングリソースの排除</a> と <a hreflang="en" href="https://web.dev/third-party-summary/">サードパーティーコードの影響を軽減</a>を基にした<a hreflang="en" href="https://twitter.com/hdjirdeh">Houssein Djirdeh</a>による<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Td-4qFjuBzxp8af_if5iBC0Lkqm_OROb7_2OcbxrU_g/edit?usp=sharing&resourcekey=0-ZCfve5cngWxF0-sv5pLRzg">同様の研究</a>があります。

#### 人気のあるサードパーティとレンダーへの影響

サードパーティがレンダリングに与える影響を理解するために、Lighthouseのレンダーブロッキングリソース監査でサイトリソースのパフォーマンスを分析し、[third-party-web](methodology#third-party-web) データセットと相互参照することでサードパーティを識別しています。

{{ figure_markup(
  image="third-parties-most-popular-third-parties-impact-on-render.png",
  caption="レンダーに影響を与えるサードパーティーの上位15位。",
  description="上位15位のサードパーティがレンダリングをブロックした回数の割合を示す棒グラフ。`*.google-analytics.com`は0.1% レンダーをブロックしています。 `fonts.googleapis.com` 51.3%、 `accounts.google.com` 3.2%、 `adservice.google.com` 0.5%、 `*.googletagmanager.com` 4.5%、 `ajax.googleapis.com` 22.7%、 `*.facebook.com` 0.1%、 `amp.cloudflare.com` 45.0%、 `*.youtube.com` 1.0%、 `*.bootstrapcdn.com` 63.1%、 `maps.google.com` 13.6%、 `*.jsdelivr.net` 30.3%、 `*.jquery.com` 46.4%、 `*.fontawesome.com` 66.0%、 `*.adobedtm.com` 3.1%となりました。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1221471478&format=interactive",
  width=600,
  height=585,
  sheets_gid="1866731351",
  sql_file="third_parties_blocking_rendering.sql"
  )
}}

もっとも人気のあるサードパーティーの上位15位は、ページの初期レンダリング時にブロックされるリソースの割合とともに、上に表示されています。

全体として、これは肯定的な話です。ほとんどはレンダリングをブロックせず、ブロックするのはレイアウトに関連する一般的なライブラリ (例: bootstrap) や、おそらく最初のレンダリングをブロックすべきフォント (<a hreflang="en" href="https://twitter.com/tunetheweb/status/1364278446311043073">この作者は `font-display: swap` や `optional` を使うことが良いことだとは思っていない</a>) のためです。

多くの場合、サードパーティの組み込みはレンダリングのブロックを避けるために `async` や `defer` を使用するように助言していますし、その多くがそうであるように見えます。

#### 人気サードパーティと本スレッドへの影響

Lighthouseには <a hreflang="en" href="https://web.dev/third-party-summary/">サードパーティコードの影響軽減</a> 監査があり、すべてのサード パーティ製リソースのメイン スレッドの時間が一覧表示されます。では、もっとも人気のあるものはどれくらいの時間メイン スレッドをブロックしているのでしょうか？

{{ figure_markup(
  image="third-parties-popular-third-parties-main-thread-blocking-time.png",
  caption="サードパーティーの上位15位のメインスレッドブロック時間。",
  description="もっとも人気のあるサードパーティーのモバイルにおけるメインスレッドのブロック時間の中央値を示す棒グラフ。Google Analyticsがメインスレッドを中央値で96ミリ秒ブロック、ms、Google Fontsが0ms、Google/Doubleclick Adsが0ms、その他のGoogle API/SDKが0ms、Google Tag Managerが42ms、Google CDNが54msでした。Facebook 139 ms、Cloudflare CDN 0 ms、YouTube 1,625 ms、Bootstrap CDN 0 ms、Google Maps 259 ms、JSDelivr CDN 0 ms、jQuery CDN 38 ms、FontAwesome CDN 0 ms、Adobe Tag Manager 0 msです。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=973901251&format=interactive",
  sheets_gid="329121076",
  width=600,
  height=585,
  sql_file="third_parties_blocking_main_thread.sql"
  )
}}

ここでは、YouTubeが突出しているので、もう少し掘り下げてみましょう。

##### YouTube

{{ figure_markup(
  image="third-parties-youtube-main-thread-impact.png",
  caption="YouTubeが本スレッドに与える影響。",
  description="YouTubeがモバイルのメインスレッドに与える影響をブロッキング時間、転送サイズをパーセンタイルで示した棒グラフです。ブロック時間は、10パーセンタイルと25パーセンタイルで0.0秒、50パーセンタイルで1,626ミリ秒、75パーセンタイルで2,512ミリ秒、90パーセンタイルで4,551ミリ秒となっています。これは、転送サイズが10パーセンタイルで43キロバイト、25パーセンタイルで129キロバイト、50パーセンタイルで703、75パーセンタイルで800、90パーセンタイルで968と増加していることと多少相関があります。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=291120635&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

中央値（50パーセンタイル）では、メインスレッド活動が1.6秒、90パーセンタイルでは4.6秒と、大きな影響があります（それでも10％のウェブサイトは、これよりも悪い影響を受けているということです！）。しかし、これはスロットルで調整された、実験室でシミュレートされたタイミングであるため、実際のユーザーの多くはこのレベルの影響を経験していないかもしれませんが、それでもかなりのものであることは覚えておく必要があります。

また、転送サイズは大きくなるほど影響が大きくなることも明らかで、処理量が多いので当然かもしれません。また、クロールはこれらのビデオとインタラクションを行わないため、自動再生されるビデオか、YouTubeプレーヤー自体がこのような使用を引き起こしていることがわかります。

ここで、リストにある他のサードパーティの埋め込みについて、もう少し掘り下げてみましょう。

##### Google Analytics

{{ figure_markup(
  image="third-parties-google-analytics-main-thread-impact.png",
  caption="Google Analyticsが本スレッドに与える影響。",
  description="Google Analyticsがモバイルのメインスレッドに与える影響をブロッキング時間、転送サイズをパーセンタイルで示した棒グラフです。ブロッキング時間は、10パーセンタイルで0ミリ秒、25パーセンタイルで62ミリ秒、50パーセンタイルで96ミリ秒、75パーセンタイルで154ミリ秒、90パーセンタイルで250ミリ秒となっています。これは、10パーセンタイルで17キロバイト、25パーセンタイルで20キロバイト、50パーセンタイルで20、75パーセンタイルで20、90パーセンタイルで21というほぼ静的な転送サイズとは相関がないことを示しています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1235735976&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Google Analyticsはかなり優秀なので、トラッキングのすべてを考慮すると、明らかに最適化に多くの労力が費やされています。

##### Google/Doubleclick広告

{{ figure_markup(
  image="third-parties-google-doubleclick-ads-main-thread-impact.png",
  caption="Google/Doubleclick広告の本スレッドへの影響。",
  description="Google/Doubleclick広告がモバイルのメインスレッドに与える影響をブロック時間、転送サイズをパーセンタイルで示した棒グラフです。ブロック時間は、10%、25%、50%で0.00ミリ秒、75%で14ミリ秒、そして90%で1,429ミリ秒に跳ね上がります。これは、転送サイズが10パーセンタイル台と25パーセンタイル台で0キロバイト、50パーセンタイル台で2キロバイト、75パーセンタイル台で21、90パーセンタイル台で289と増加したことに密接な相関があります。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=2069770165&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Google広告は、90パーセンタイルに達するまでは、とてもうまくいっていたのですが、チャートから吹き飛ばされてしまったのです。繰り返しますが、これは10％のウェブサイトがこれらより悪い数字であることを意味します。

##### Googleタグマネージャー

{{ figure_markup(
  image="third-parties-google-tag-manager-main-thread-impact.png",
  caption="Google Tag Managerが本スレッドに与える影響。",
  description="Google Tag Managerがモバイルのメインスレッドに与える影響をブロック時間、転送サイズをパーセンタイルで示した棒グラフです。ブロック時間は、10パーセンタイルで0ミリ秒、25パーセンタイルで4ミリ秒、50パーセンタイルで42ミリ秒、75パーセンタイルで129ミリ秒、90パーセンタイルで275ミリ秒となっています。これは、転送サイズが10パーセンタイルで35キロバイト、25パーセンタイルで36キロバイト、50パーセンタイルで39、75パーセンタイルで74、90パーセンタイルで116と増加したことに密接な相関があります。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1275343309&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Googleタグマネージャーは、正直なところ、予想以上に良い結果を出しています。筆者は、もう使われない古いタグやトリガーで溢れかえった、恐ろしいGTMの実装をいくつか見てきました。しかし、GTMはテストページのロードでメインスレッドを長時間ブロックすることがなく、うまくいっているようです。

##### Facebook

{{ figure_markup(
  image="third-parties-facebook-main-thread-impact.png",
  caption="Facebookが本スレッドに与える影響",
  description="Facebookがモバイルのメインスレッドに与える影響をブロッキング時間、転送サイズをパーセンタイルで示した棒グラフです。ブロック時間は、10パーセンタイルで0.00ミリ秒、25パーセンタイルで58ミリ秒、50パーセンタイルで139ミリ秒、75パーセンタイルで250ミリ秒、90パーセンタイルで415ミリ秒となっています。これは、転送サイズが10パーセンタイルで69キロバイト、25パーセンタイルで72キロバイト、50パーセンタイルで100、75パーセンタイルで167、90パーセンタイルで233と増加したことに密接な相関があります。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1572246557&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Facebookも、思ったほどリソースを消費しません。Facebookの投稿の埋め込みは、Twitterの埋め込みよりも人気がないようなので、これらはFacebookのリターゲティング・トラッカーになる可能性が高いでしょう。これらのトラッカーはバックグラウンドで静かに動作し、メインスレッドにまったく影響を与えないはずです。したがって、Facebookがここで行うべきことはまだあることが明らかです。私は、<a hreflang="en" href="https://www.tunetheweb.com/blog/adding-controls-to-google-tag-manager/#pixels">Facebook JavaScript APIを使用せず、Googleタグマネージャー</a>を通じてピクセルトラッキングを使用しても、機能を失うことなく良い結果を得ているので、このオプションを検討することをオススメします。

##### Googleマップ

{{ figure_markup(
  image="third-parties-google-maps-main-thread-impact.png",
  caption="Googleマップが本スレッドに与える影響。",
  description="Google Mapsがモバイルのメインスレッドに与える影響をブロック時間、転送サイズをパーセンタイルで示した棒グラフです。ブロック時間は、10パーセンタイルで18ミリ秒、25パーセンタイルで61ミリ秒、50パーセンタイルで259ミリ秒、75パーセンタイルで617ミリ秒、90パーセンタイルで930ミリ秒となっています。これは、転送サイズが10パーセンタイルで164キロバイト、25パーセンタイルで165キロバイト、50パーセンタイルで273、75パーセンタイルで310、90パーセンタイルで434と増加したことに多少相関があります。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=934181875&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Googleマップは、間違いなくいくつかの改善が必要です。とくに、メインコンテンツではなく、ページ上の小さな余分な部分として存在することが多いからです。ウェブサイトの所有者として、Googleマップのコードを必要なページにのみ含めることの重要性が浮き彫りになっています。

##### Twitter

そして最後に、さらに1つ下のリストを見てみましょう。Twitterです。

{{ figure_markup(
  image="third-parties-twitter-main-thread-impact.png",
  caption="Twitterが本スレッドに与える影響",
  description="モバイルでTwitterがメインスレッドに与える影響をブロック時間、転送サイズをパーセンタイルで示した棒グラフです。ブロック時間は、10パーセンタイルで0ミリ秒、25パーセンタイルで58ミリ秒、50パーセンタイルで134ミリ秒、75パーセンタイルで307ミリ秒、90パーセンタイルで685ミリ秒となっています。これは、転送サイズが10パーセンタイル台と25パーセンタイル台で132キロバイト、50パーセンタイル台で148キロバイト、75パーセンタイル台で673、90パーセンタイル台で1538と増加したことに密接な相関があります。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1661844053&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

サードパーティとしてのTwitterは、リターゲティング広告のトラッカーとして、またツイートを埋め込む方法として、2つの方法で利用できます。ページへのツイートの埋め込みは、他のソーシャルネットワークよりも人気があります。しかし、<a href="https://twitter.com/TheRealNooshu">Matt Hobbs</a> の <a hreflang="en" href="https://nooshu.com/blog/2021/02/06/using-puppeteer-and-squoosh-to-fix-twitter-embeds/">PuppeteerとSquooshを使って埋め込みツイートのWebパフォーマンスを修正する</a> という投稿を含め、ウェブパフォーマンスのコミュニティの多くからページに過度の影響を与えるとして指摘されています。とくに、上記のグラフにあるようなトラッキングのユースケース（おそらくより軽量なもの）は希薄になるため、我々の分析はそれを裏付けるものです。

上記の例の中には、良くも悪くもなるものがありますが、ウェブサイトのパフォーマンスに本当に影響を与えるのは、これらの累積効果であることを忘れてはなりません。地図と埋め込みTweetのあるページにGoogle Analytics、Facebook、TwitterのトラッキングをロードするGTMを追加すると、膨大な量になります。スマホがときどき熱くて手に負えなくなったり、ネットサーフィンをしているだけでPCのファンが回りだしたりするのは、当然といえば当然ですよね。

これらのことから、Googleがドキュメントの順序付け、遅延ローディング、ファサード、その他のテクニックを使用して、<a hreflang="en" href="https://web.dev/embed-best-practices/">埋め込みの影響を軽減する</a>（皮肉にもほとんどが自分たちのものです！）ことを推奨している理由がわかります。しかし、これらのうちのいくつかはデフォルトではなく、これらのような高度なテクニックはウェブサイト所有者の責任に帰する必要があることは、実に腹立たしいことです。ここで取り上げたサードパーティは、本当はリソースや技術的なノウハウを持っていて、デフォルトですべての人の製品使用による影響を減らすことができるのに、そうしないことを選択することが多いのです。このパフォーマンス編は、サードパーティを使うことが必ずしもパフォーマンスに悪いわけではない、というところから始まりましたが、これらの例を見ると確かにこの分野ではもっとできることがあるようです。

このような有名な例を取り上げることで、読者が自分のサイトにおけるサードパーティーの埋め込みの影響を調査し、本当にすべて価値があるのか自問するきっかけになればと思います。おそらく、このテーマをサードパーティにもっと重要視してもらえば、パフォーマンスを優先してくれるでしょう。

### Timing-Allow-Originヘッダーの普及率

昨年は、<a href="https://developer.mozilla.org/ja/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API">Resource Timing API</a> をサードパーティのリクエストで使用できるようにする [`timing-allow-origin` header の普及](./third-parties#timing-allow-origin-prevalence) について調べました。このHTTPヘッダーがない場合、サードパーティからのリクエストに対してオンページ・パフォーマンス・モニタリング・ツールが利用できる情報は、セキュリティとプライバシー上の理由から制限されます。しかし、静的なリクエストについては、このヘッダーを許可するサードパーティは、そのリソースの読み込み性能についてより高い透明性を実現します。

{{ figure_markup(
  image="third-parties-timing-allow-origin-header-usage.png",
  caption="Timing-Allow-Originヘッダーの使用状況。",
  description="過去3年間のデスクトップとモバイルのサードパーティリクエストにおける `timing-allow-origin` HTTPヘッダーの普及状況を示す棒グラフ。2019年7月には、このヘッダーはデスクトップ・リクエストの30.0%、モバイル・リクエストの31.9%に搭載されていました。2020年8月にはそれぞれ31.5%、31.3%に増加したが、2021年7月にはデスクトップのサードパーティからのリクエストで27.8%、モバイルのサードパーティからのリクエストで26.7%に減少しています。",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=626106432&format=interactive",
  sheets_gid="1788549043",
  sql_file="tao_by_third_party.sql"
  )
}}

過去3年間のWeb Almanacの利用状況を見ると、今年は利用状況がかなり落ち込んでいます。データを深く掘り下げると、Facebookのリクエストは33％減少していることがわかりました。このヘッダーをサポートし、広く使用されていることを考えると、この減少の大部分はこれで説明できます。おもしろいことに、Facebookが使われているページの数は実際に増えています。しかし、Facebookは昨年、リクエストを少なくするように埋め込みを変更したようで、その普及率を考えると、`timing-allow-origin`ヘッダーの使用にかなりの打撃を与えているようです。それは、<a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">Core Web Vitalsのランキングへの影響</a>によりパフォーマンスに焦点が当てられていることを考えると、少し残念なことです。

## セキュリティとプライバシー

サードパーティを利用することによるセキュリティやプライバシーへの影響を測定することは、より困難です。サードパーティにアクセスすることは、セキュリティとプライバシーの両面でリスクを増大させることは間違いなく、もっとも一般的であることが分かっているスクリプトを実行するためのアクセスを与えることは、実質的にウェブサイトへのフルアクセスを意味します。しかしサードパーティーのリソースは、サイト上でシームレスに使用できるようすることが目的であり、これを制限することは、サードパーティーの機能そのものを制限することになります。

### セキュリティ

サイト自身は、さまざまな方法でサードパーティを利用するリスクを減らすことができます。`HttpOnly` 属性で<a href="https://developer.mozilla.org/ja/docs/Web/HTTP/Cookies#restrict_access_to_cookies">クッキーへのアクセスを制限し</a>、JavaScriptからアクセスできないようにし、`SameSite` 属性を適切に使用します。これらについては、[セキュリティの章](./security)で詳しく説明されていますので、ここではこれ以上掘り下げません。

サードパーティのリソースをより安全にするもう1つのセキュリティ機能は、<a href="https://developer.mozilla.org/ja/docs/Web/Security/Subresource_Integrity">Subresource Integrity</a> (SRI) の使用です。これは、リソースを読み込む `<link>` または `<script>` 要素にリソースの暗号ハッシュを追加して有効にするものです。このハッシュをブラウザで確認することにより、ダウンロードされたコンテンツが期待通りのものであることを確認します。しかし、サードパーティーのリソースはさまざまな性質を持っているため、サードパーティーが意図的にリソースを更新した場合、サイトが壊れるなど、解決策よりもリスクが大きくなる可能性もあります。もし、本当に静的なコンテンツであれば、セルフホスティングが可能であり、SRIの必要性はない。このように多くの人がSRIを推奨していますが、筆者はSRIが、本当に推進派が主張するようなセキュリティ上の利点を提供しているのか、まだ確信が持てません。

サードパーティのリソースの使用や、ユーザーが作成したコンテンツなど、サードパーティのコンテンツがサイトに入ってくる際のセキュリティ リスクを減らすには、堅牢な <a href="https://developer.mozilla.org/ja/docs/Web/HTTP/CSP">Content Security Policy</a> (CSP) が最適な方法の1つでしょう。これは、オリジナルのウェブサイトとともに送信されるHTTPヘッダーで、どのようなリソースを誰が読み込むめるのか、またできないかを正確にブラウザに伝えます。[セキュリティ](./security)の章によると、使っているサイトは少ないという、より高度な技術でありCSPの使用状況の分析は彼らに任せるとして、ここで取り上げる価値があるのは普及しない理由の1つ_が_サードパーティにあるのではないかということです。筆者の経験では、サードパーティを問題なく利用するためにサイトがポリシーに追加しなければならない要件を正確に記載したCSP情報を公開しているサードパーティはごくわずかです。さらに悪いことに、安全なCSPと互換性のないものもあります。一部のサードパーティは、インラインのスクリプト要素を使用したり、通知なしにドメインを変更したりするため、CSPを使用しているサイトでは、ポリシーを更新するまでその機能が壊れてしまいます。Google広告は、<a hreflang="en" href="https://stackoverflow.com/questions/34361383/google-adwords-csp-content-security-policy-img-src">国ごとに異なるドメインの使用</a>により、CSPを本当にロックダウンすることを難しくしているもう1つの例です。

そもそも自分の管理下にあるサイトの部分についてCSPを設定することだけでも十分難しいのに、サードパーティーの複雑さが加わって、自分の管理外のことがさらに難しくなっているのです。サードパーティは、サイトがCSPを使用するリスクを軽減するために、CSPのサポートをより良くする必要があります。

### プライバシー

サードパーティを利用することによるプライバシーへの影響については、改めてこのトピックに特化した[プライバシー](./privacy)の章に譲るとして、上記の分析からすでに明らかなのは、Webユーザーのプライバシーに大きな影響を与える次の2点である。

- Webサイトにおけるサードパーティーの利用率は95％弱。
- GoogleやFacebookなど、プライバシーの味方とは言い難い特定のサードパーティが優勢であること。

もちろん、あなたのサイトでサードパーティを利用する主な理由の1つは、広告目的のトラッキングであり、その性質上、あなたの訪問者の最高のプライバシー利益になるとは思えません。基本的にサードパーティの利用によってのみ可能となるこの広範なトラッキングに対する代替案は、<a hreflang="en" href="https://blog.google/products/ads-commerce/2021-01-privacy-sandbox/">Googleのプライバシー サンドボックスやFLoCイニシアチブ</a>など提案されていますが、これまでのところ幅広いエコシステムに十分な牽引力を与えるには至っていません。

さらに問題なのは、ウェブサイトの利用者や所有者が気づかないうちに、トラッキングが行われていることでしょう。製品やサービスに対してお金を払っていないなら、あなたが製品であるという古い格言があります。多くのサードパーティは、製品を「無料」で提供していますが、これはほとんどの場合、他の方法で収益化していることを意味します。通常、訪問者のプライバシーを犠牲にしています

<a href="https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Feature-Policy">`feature-policy` や `permission-policy`</a> といった新しい技術を採用すると、マイクやビデオカメラといったブラウザの特定の機能の使用を制限できます。これらの多くは、通常、ブラウザのプロンプトの背後に保護されているため、黙って起動されることはありませんが、プライバシーとセキュリティのリスクを軽減できます。Googleはまた、ウェブブラウザのプライバシーへの影響を制限するための<a hreflang="en" href="https://github.com/bslassey/privacy-budget">プライバシー予算案</a>に取り組んでいますが、他の人々は<a hreflang="en" href="https://blog.mozilla.org/en/mozilla/google-privacy-budget-analysis/"> この分野での彼らの仕事に対して懐疑的なまま</a>なのです。全体として、多くのサードパーティリソースの意図を考えると、プライバシーコントロールを追加することは、流れに逆らっているように見えます。

## 結論

サードパーティはウェブに不可欠な存在です。サードパーティの普及がなければ、ウェブサイトを構築するのは難しく、機能も充実していないでしょう。冒頭で述べたように、ウェブの核心は相互接続性であり、サードパーティはその自然な延長線上にあるのです。私たちの分析によると、サードパーティはかつてないほど普及しており、サードパーティのないサイトは非常に例外的なのです。

しかし、サードパーティーの利用はリスクがないわけではありません。本章では、サードパーティーがパフォーマンスに与える影響を調査し、サードパーティーをサイトで利用する際に起こりうるセキュリティとプライバシーのリスクについて説明しました。

サードパーティのツール、ウィジェット、トラッカーなど、思いつく限りのものでウェブサイトを不必要に満載することには、結果が伴います。サイトの所有者は、すべてのサードパーティコンテンツの影響を調べ、その潜在的な影響に見合う機能性があるかどうかを判断する責任があります。

しかし、ネガティブなことばかりに目を奪われがちなので、この章の最後にポジティブなことを振り返ってみましょう。サードパーティがこれほど普及しているのには理由があり、彼らは（たいてい！）選択の余地なく使っているのです。共有することがウェブの本質なので、サードパーティはウェブの精神にとても合っているのです。私たちウェブデベロッパーが自由に使える機能、そしてそれをサイトに追加することがいかに簡単であるかは、驚くべきことです。この章を読んで、あなたがそのような取引をするときに、十分に理解しているかどうか、もう少し考えるようになることを願っています。
