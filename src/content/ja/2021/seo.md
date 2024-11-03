---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: クローラビリティ、インデクサビリティ、ページエクスペリエンス、オンページSEO、リンク、AMP、国際化などを網羅した「2021 Web Almanac」のSEOの章です。
authors: [patrickstox, Tomek3c, wrttnwrd]
reviewers: [fili, SeoRobt, fellowhuman1101]
analysts: [jroakes, rvth]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/11hw7zg4dpIY8XbQR5bNp5LvwbaQF0TjV0X5cK0ng8Bg/
patrickstox_bio: <a hreflang="en" href="https://ahrefs.com/">Ahrefs</a> のプロダクトアドバイザー、テクニカルSEO、ブランドアンバサダーを務める。<a hreflang="en" href="https://www.meetup.com/RaleighSEO/">Raleigh SEOミートアップ</a>（米国で最も成功したSEO Meetup）、<a hreflang="en" href="https://www.meetup.com/beerandseo/">ビールとSEOミートアップ</a>、<a hreflang="en" href="https://raleighseomeetup.org/conference/">Raleigh SEOカンファレンス</a>の主催者でもある。また、Technical SEO Slack グループを運営し、<a hreflang="en" href="https://www.reddit.com/r/TechSEO">/r/TechSEO on Reddit</a> のモデレーターを務めています。また、PatrickはTwitterの「Uncommon SEO Knowledge」というスレッドで、ランダムにSEOの知識を共有するのが好きです。彼は有名なカンファレンススピーカーであり、業界ブロガー（最近は主に<a hreflang="en" href="https://ahrefs.com/blog/">Ahrefのブログ</a>で）、検索賞の審査員、そして米国労働省の検索マーケティング戦略家の役割の定義に貢献しました。
Tomek3c_bio: Tomekは、<a hreflang="en" href="http://onely.com/">Onely</a>の研究開発責任者です。また、ウェブサイト所有者がより多くのコンテンツをGoogleにインデックスさせることを目的とした製品、<a hreflang="en" href="https://www.ziptie.dev/">ZipTie</a>を開発中です。余暇には、ハイキングとポーカーを楽しんでいます。
wrttnwrd_bio: Ianは、マーケティングコンサルタント、SEO、講演者、回復代理店の創業者です。1995年にデジタル・マーケティング・エージェンシーであるPortentを設立し、2017年にClearlinkに売却しました。今は独立して、<a hreflang="en" href="https://www.ianlurie.com/digital-marketing-consulting/">大好きなブランドのコンサルティング</a>をしたり、<a hreflang="en" href="https://www.ianlurie.com/speaking/">ダイエットコークを提供する会議</a>で話したりしています。ダンジョンズ＆ドラゴンズのプロプレイヤーにも挑戦しているが、なかなかうまくいかない。シアトルの坂を自転車で登るのが日課。
featured_quote: SEOはかつてないほど人気があり、企業が顧客にアプローチする新しい方法を模索する中で、ここ数年大きな成長を遂げています。SEOの人気は、他のデジタルチャネルをはるかにしのいでいます。
featured_stat_1: 16.5%
featured_stat_label_1: robots.txtファイルが存在しないWebサイト
featured_stat_2: 41.5%
featured_stat_label_2: canonicalタグのないモバイルページ
featured_stat_3: 67%
featured_stat_label_3: Core WebVitalsチェックに失敗したモバイルWebサイト
---

## 序章

SEO (Search Engine Optimization) は、検索エンジンのオーガニック検索結果からのトラフィックの量と質を高めるために、ウェブサイトやウェブページを最適化することです。

SEOはかつてないほど人気があり、企業が顧客にアプローチする新しい方法を模索する中で、ここ数年大きな成長を遂げています。SEOの人気は、他のデジタルチャネルをはるかにしのいでいます。

{{ figure_markup(
  image="seo-term-trends.png",
  caption="Google TrendsによるSEOとペイパークリック、ソーシャルメディアマーケティング、Eメールマーケティングの比較。",
  description="Google Trendsで、検索エンジン最適化、ペイパークリック、ソーシャルメディアマーケティング、メールマーケティングの4つのデジタルマーケティングチャネルを比較し、時系列で関心を示している画面です。SEOは、近年、他のチャネルをはるかにしのぐ関心を集め、もっとも人気のあるデジタルマーケティングチャネルであり続けました。SEOは、世界中でコミュニティが拡大し、進化を続けている分野です。",
  width=1155,
  height=605
  )
}}

Web AlmanacのSEOの章の目的は、Webサイトの最適化に関連するさまざまな要素を分析することです。この章では、Webサイトがユーザーと検索エンジンに優れた体験を提供しているかどうかをチェックします。

分析には、<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>、<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report (CrUX)</a> 、モバイルとデスクトップの <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> から得られる生とレンダリングのHTML要素を含む多くのデータが使用されました。HTTP ArchiveとLighthouseの場合、サイト全体のクロールではなく、ウェブサイトのホームページのみから特定されるデータに限定されます。このことを念頭に置いて、私たちの結果から結論を出してください。分析の詳細については、[方法論](./methodology)のページでご覧いただけます。

Webの現状と検索エンジンの利便性については、こちらをご覧ください。

## クロール性とインデックス性

このようなユーザーの問い合わせに対して適切な結果を返すために、検索エンジンはウェブの索引を作成する必要がある。そのためのプロセスには

1. **クローリング** - 検索エンジンは、ウェブクローラー（スパイダー）を使ってインターネット上のページを巡回しています。スパイダーは、サイトマップやページ間のリンクなどの情報源から新しいページを見つけます。
2. **処理** - このステップでは、検索エンジンがページのコンテンツをレンダリングすることがあります。検索エンジンはインデックスを作成・更新し、ページをランク付けし、新しいコンテンツを発見するために使用するコンテンツやリンクなど、必要な情報を抽出します。
3. **インデックス作成** - コンテンツの品質と独自性に関する一定のインデックス作成要件を満たしたページは、通常、インデックスに登録されます。インデックスされたページは、ユーザーのクエリに対して返される資格があります。

ここでは、クローラビリティとインデックス作成に影響を与える可能性のある問題をいくつか見てみましょう。

### `robots.txt`

`robots.txt` とは、ウェブサイトの各サブドメインのルートフォルダーに置かれるファイルで、検索エンジンのクローラーなどのロボットへどこに行ってよいか、どこに行ってはいけないかを伝えるためのものです。

81.9%のWebサイトがrobots.txtファイル（モバイル）を活用している。前回（2019年72.2%、2020年80.5%）と比較すると、やや改善されたことになります。

robots.txtの作成は必須でありません。404 not foundを返している場合、Googleはウェブサイトのすべてのページがクロールできると仮定しています。他の検索エンジンでは、これとは異なる扱いを受ける可能性があります。

{{ figure_markup(
  image="robots-txt-status-codes.png",
  caption="robots.txtのステータスコードの内訳。",
  description="robots.txtが有効なページの割合を示す棒グラフ。ステータスコード200は81.9%のモバイルサイトに、ステータスコード404は16.5%のモバイルサイトに存在しました。その他のステータスコードはほとんど使用されておらず、デスクトップの数値もモバイルとほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2062029998&format=interactive",
  sheets_gid="91318795",
  sql_file="robots-txt-status-codes.sql"
  )
}}

`robots.txt`を使用することで、ウェブサイトのオーナーは検索エンジンのロボットを制御できます。しかし、16.5%ものウェブサイトが`robots.txt`ファイルを持っていないというデータも出ています。

ウェブサイトが `robots.txt` ファイルを誤って設定している可能性があります。たとえば、人気のあるウェブサイトの中には、（おそらく間違って）検索エンジンをブロックしているものがありました。Googleはこれらのウェブサイトのインデックスを一定期間維持するかもしれませんが、最終的には検索結果での可視性は低下します。

`robots.txt`に関連するエラーのもう1つのカテゴリーは、アクセシビリティやネットワークエラーです。つまり、`robots.txt`は存在するがアクセスできない状態です。Googleが `robots.txt` ファイルを要求してこのようなエラーが発生した場合、ボットはしばらくの間、ページの要求を停止することがあります。これは、検索エンジンがあるページをクロールできるかできないか分からないので、`robots.txt`がアクセスできるようになるまで待つというロジックです。

データセットに含まれるウェブサイトの~0.3%が403 Forbiddenまたは5xxを返しました。ボットによってこれらのエラーの扱いが、異なる可能性があるため、Googlebotが何を見たのかは正確にはわかりません。

<a hreflang="en" href="https://www.youtube.com/watch?v=JvYh1oe5Zx0&amp;t=315s">Googleが公開している2019年からの</a>最新情報では、5％ものウェブサイトがrobots.txtで一時的に5xxを返し、26％ものウェブサイトが到達不能になっていたそうです。

{{ figure_markup(
  image="robots-usage-presentation.png",
  caption="Googlebotが遭遇したrobots.txtのステータスコードの内訳。",
  description="Googlebotが遭遇したrobots.txtのステータスコードの割合を示す画面。2019年のデータから引用すると、69%のサイトがGoodでステータスコード200を利用するか、オープンアクセスで404を返しています。5%ものサイトが、`robots.txt`で5xxを返すTemporarily OKでした。26%ものサイトがUnreachableでした。",
  width=609,
  height=313
  )
}}

HTTP ArchiveとGoogleのデータの不一致の原因として、2つのことが考えられます。

1. Googleは2年前のデータを提示し、HTTP Archiveは最近の情報に基づいている、あるいは

2. HTTP Archiveは、CrUXのデータに含まれるほど人気のあるWebサイトに焦点を当て、Googleは既知のWebサイトをすべて訪問しようとします。

### `robots.txt` のサイズ

{{ figure_markup(
  image="robots-txt-size-distribution.png",
  caption="`robots.txt` のサイズ分布。",
  description="robots.txtのサイズ分布を示す棒グラフ。ほぼすべてのrobots.txtファイルは、0～100kbの間で小さくなっています。モバイルページのrobots.txtファイルの96.72%が0-100kbの間であることがわかりました（デスクトップでも同様の結果でした）。また、100kbを超えるrobots.txtファイルを持つウェブページは、デスクトップ、モバイルともにほぼ皆無で、1.58%は見つからないことがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1491943936&format=interactive",
  sheets_gid="1066408164",
  sql_file="robots-text-size.sql"
  )
}}

ほとんどのrobots.txtファイルは0～100kbの間でかなり小さいです。しかし、Googleの最大制限を超える500キロバイトを超えるrobots.txtファイルを持っている3,000以上のドメインを発見しました。このサイズ制限を超えたルールは無視されます。

{{ figure_markup(
  image="robots-txt-user-agent.png",
  caption="`robots.txt` のユーザーエージェント使用状況。",
  description="robots.txtのユーザーエージェントの使用頻度がもっとも高い10種類を示した棒グラフです。結果はデスクトップとモバイルでほぼ同じで、75.2%のドメインが特定のユーザーエージェントを示していませんでした。`adsbot-google` 6.3%、`mj12bot` 5.6%、`ahrefsbot` 5.0%、`mediapartners-google` 4.9%、`googlebot` 3.4%、`nutch` 3.3%、`yandex` 3.1%、`pinterest` 2.9%、`ahrefssiteaudit` 2.7%であることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1206728832&format=interactive",
  sheets_gid="964313002",
  sql_file="robots-txt-user-agent-usage.sql"
  )
}}

全ロボットに対するルールを宣言することも、特定のロボットに対するルールを指定することも可能です。ボットは通常、ユーザーエージェントのもっとも具体的なルールに従おうとします。`User-agent: Googlebot` はGooglebotのみを参照し、`User-agent: *`はより具体的なルールを持たないすべてのボットを指します。

もっとも指定されたユーザーエージェントのトップ5に、`mj12bot` (Majestic) と `ahrefsbot` (Ahrefs) というSEO関連の2つの人気ロボットが、あることがわかりました。

### `robots.txt` 検索エンジンの内訳

<figure>
  <table>
    <thead>
      <tr>
        <th>ユーザーエージェント</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Googlebot</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td>Bingbot</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td>Baiduspider</td>
        <td class="numeric">1.9%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>Yandexbot</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`robots.txt` 検索エンジンの内訳。", sheets_gid="964313002", sql_file="robots-txt-user-agent-usage.sql") }}</figcaption>
</figure>

特定の検索エンジンに適用されるルールを見ると、Googlebotがもっとも参照され、クロールされたWebサイトの3.3%に出現しています。

Bing、Baidu、Yandexなど他の検索エンジンに関連するロボットルールはあまり人気がない（それぞれ2.5%、1.9%、0.5%）。これらのボットにどのようなルールが適用されているかは調べていません。

### Canonicalタグ

ウェブは膨大なドキュメントの集合体であり、その中には重複しているものもあります。重複コンテンツの問題を防ぐために、ウェブマスターはcanonicalタグを使って、どのバージョンをインデックスされるのが好ましいかを検索エンジンに伝えることができます。また、canonicalは、ランキングページへのリンクなどのシグナルを統合するのに役立ちます。

{{ figure_markup(
  image="canonical-tag-usage.png",
  caption="Canonicalタグの使用方法。",
  description="canonicalタグの使用状況を示す棒グラフ。ほとんどのWebページでcanonicalタグが使用されていることがわかりました（モバイルページで58.5%、デスクトップページでは56.6%）。正規化されたウェブページの割合は、デスクトップ（4.3%）に比べ、モバイル（8.3%）で高いことがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=118545040&format=interactive",
  sheets_gid="1066408164",
  sql_file="pages-canonical-stats.sql"
  )
}}

このデータでは、年々canonicalタグの導入が進んでいることがわかります。たとえば、2019年版では、48.3%のモバイルページがcanonicalタグを使用していたことがわかります。2020年版では53.6%に増え、2021年版では58.5%となっています。

モバイルページにはデスクトップページよりも多くのcanonicalが設定されています。また、モバイルページの8.3%、デスクトップページの4.3%が別のページに正規化されており、Googleやその他の検索エンジンにcanonicalタグで示されたページがインデックスされるべきページであることを明確に示唆するようになっています。

モバイルで正規化されたページの数が多いのは、<a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">個別のモバイルURL</a>を使用しているWebサイトに関連していると思われます。このような場合、Googleは対応するデスクトップのURLを指す`rel="canonical"`タグを設置することを推奨しています。

今回のデータセットと分析は、ウェブサイトのホームページに限定したものであり、テスト対象ウェブサイトのすべてのURLを考慮すると、データは異なる可能性があります。

#### canonicalタグを実装する2つの方法

canonicalを実装する場合、指定する方法は2つあります。

1. ページのHTMLの`<head>`セクションで
2. HTTPヘッダーの中で（`Link` HTTPヘッダーを経由して）

{{ figure_markup(
  image="canonical-raw-rendered-usage.png",
  caption="未加工のCanonicalとレンダリングの使い分けの目安。",
  description="未加工とレンダリングのcanonicalタグの有無を示す棒グラフ（未加工、レンダリング、レンダリングだが未加工ではない、レンダリングを変更した、httpヘッダーを変更した）。当社のデータでは、未加工のcanonicalタグはデスクトップページの55.9%、モバイルページの57.7%に見られました。レンダリングされたcanonicalタグは、デスクトップページの56.5%、モバイルページの58.4%で見つかりました。その他のタグは、デスクトップまたはモバイルページの1.5%未満にしか見当たりませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1288519273&format=interactive",
  sheets_gid="1066408164",
  sql_file="pages-canonical-stats.sql"
  )
}}

canonicalタグをHTMLページの`<head>`に実装することは、`Link`ヘッダーを使う方法よりもはるかに一般的です。一般に、headセクションにタグを実装する方が簡単だと考えられており、そのため、使用率が非常に高くなっています。

また、配信された未加工のHTMLと、JavaScriptを適用した後のレンダリングHTMLの間で、canonicalにわずかな変化（1％未満）が見られました。

#### canonicalタグの矛盾

ページには、複数のcanonicalタグを含むことがあります。このように相反するシグナルがある場合、検索エンジンはそれを把握しなければなりません。GoogleのSearch Advocateの一人である[Martin Splitt](https://x.com/g33konaut)は、かつて<a hreflang="en" href="https://www.youtube.com/watch?v=bAE3L1E1Fmk&amp;t=772s">Google側で未定義の動作を引き起こす</a>と発言しています。

先ほどの図では、1.3%ものモバイルページが、最初のHTMLとレンダリングバージョンで異なるcanonicalタグを持っていることが示されています。

[昨年の章では次のように指摘しています](../2020/seo#正規化) "実装方法の違いでも同様の衝突が見られ、モバイルページの0.15%、デスクトップページの0.17%が、HTTPヘッダーとHTMLヘッドを介して実装したcanonicalタグの衝突を示しました"。

その衝突に関する今年のデータは、さらに心配なものです。デスクトップで0.4%、モバイルでは0.3%のケースでページが矛盾する信号を送っています。

Web Almanacのデータはホームページのみを対象としているため、アーキテクチャの奥深くに位置するページにはさらに問題のある可能性があり、これらは正規化シグナルを必要なページである可能性が高くなります。

## ページ経験

2021年は、ユーザー体験への注目が高まりました。Googleは<a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">ページ体験の更新</a>を開始し、HTTPSやモバイルフレンドリーなどの既存のシグナルと、Core Web Vitalsという新しいスピード指標を盛り込みました。

### HTTPS

{{ figure_markup(
  image="usage-of-https.png",
  caption="HTTPSで提供されるデスクトップおよびモバイルページの割合。",
  description="HTTPSの比率を示す棒グラフ。モバイルページの81.2％はHTTPS、デスクトップページの84.3％ではHTTPSであることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1826599611&format=interactive",
  sheets_gid="1347655296",
  sql_file="seo-stats.sql"
  )
}}

HTTPSの採用は依然として増加している。モバイルページの81.2%、デスクトップページの84.3%でHTTPSがデフォルトとして採用されました。これは、前年比でモバイルサイトでは約8％、デスクトップサイトでは7％増加しています。

### モバイルフレンドリー

今年はモバイルの利便性が若干向上しています。レスポンシブデザインの導入は増加し、ダイナミックサーブは比較的横ばいで推移しています。

レスポンシブデザインは同じコードを送信し、画面サイズに応じてウェブサイトの表示方法を調整するのに対し、ダイナミックサービングはデバイスに応じて異なるコードを送信します。レスポンシブWebサイトの識別には`viewport`メタタグが、`Vary: User-Agent header`は、ダイナミックサービングを使用しているウェブサイトを識別するために使用されます。

{{ figure_markup(
  caption="モバイルフレンドリーのシグナルである `viewport` メタタグを使用したモバイルページの割合。",
  content="91.1%",
  classes="big-number",
  sheets_gid="704656954",
  sql_file="meta-tag-usage-by-name.sql"
)
}}

モバイルページの91.1％が`viewport`メタタグを含んでおり、2020年の89.2％から増加した。また、デスクトップページの86.4％がviewport metaタグを含んでおり、2020年の83.8％から増加しています。

{{ figure_markup(
  image="vary-usage-agent-header-usage.png",
  caption="`Vary: User-Agent` ヘッダーの使用状況。",
  description="モバイルフレンドリーを識別するために使用される `vary` ヘッダーを示す棒グラフ。ほとんどのウェブページがレスポンスデザインを利用していること（デスクトップ：87.4%、モバイル：86.6%）と、ダイナミックサーブを利用しているページ（デスクトップ：12.6%、モバイル：13.4%）を比較すると、レスポンスデザインの方が多いようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1985736287&format=interactive",
  sheets_gid="478009067",
  sql_file="html-response-vary-header-used.sql"
  )
}}

また、`Vary: User-Agent`ヘッダーについては、このフットプリントのデスクトップページの12.6％、モバイルページの13.4％がこのヘッダーを使用しており、数値はほとんど変わりません。

{{ figure_markup(
  caption="モバイルページで読みやすいフォントサイズを使用していない割合。",
  content="13.5%",
  classes="big-number",
  sheets_gid="1705330480",
  sql_file="lighthouse-seo-stats.sql"
)
}}

モバイルフレンドリーに失敗した最大の理由のひとつは、13.5%のページが読みやすいフォントサイズを使用していないことでした。つまり、<a hreflang="en" href="https://web.dev/font-size/">60%以上のテキストが、モバイルで読みにくい12pxより小さいフォントサイズだった</a>ということです。

### Core Web Vitals

Core Web Vitalsは、Googleのページ体験シグナルの一部である新しい速度指標です。この指標は、最大コンテンツペイント（LCP）による視覚的負荷、累積レイアウトシフト（CLS）による視覚的安定性、最初の入力遅延（FID）を使用した対話性を測定します。

このデータは、オプトインしたChromeユーザーの実測データを記録した「Chromeユーザーエクスペリエンスレポート（CrUX）」から得られたものです。

{{ figure_markup(
  image="core-web-vitals-trend.png",
  caption="Core web vitalsの指標推移。",
  description="モバイルでのCWVの良い体験の割合を示す折れ線グラフ。2021年にはGood LCPが42％から45％に、Good FIDが81％から90％に、Good CLSが55％から62％に、Good CWVが23％から29％に増加しました。この結果から、良いCWV体験を提供するモバイルサイトの割合は、年々増加し続けることが予想されます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1693723951&format=interactive",
  sheets_gid="460991760",
  sql_file="core-web-vitals.sql"
  )
}}

モバイルサイトの29％がコアウェブバイタルの基準値をクリアしており、昨年の20％から増加しています。ほとんどのWebサイトがFIDをクリアしていますが、WebサイトのオーナーはCLSとLCPの改善に苦戦しているようです。このトピックについては、[パフォーマンス](./performance)の章を参照してください。

## On-Page

検索エンジンは、あなたのページのコンテンツを見て、それが検索クエリに関連する結果であるかどうかを判断します。その他のページ上の要素も、検索エンジンでの順位や見た目に影響を与える場合があります。

### メタデータ

メタデータには、`<title>` 要素と `<meta name="description">` タグが含まれます。メタデータは直接的、間接的にSEOのパフォーマンスに影響を与えることがあります。

{{ figure_markup(
  image="title-meta-description-usage.png",
  caption="タイトルとメタ記述の使用状況の内訳。",
  description="メタデータを持つページの割合を示す棒グラフ。モバイルページとデスクトップページの98.8%に`title`要素があり、モバイルページとデスクトップページの71.1%にメタ記述がありました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=541272297&format=interactive",
  sheets_gid="1347655296",
  sql_file="seo-stats.sql"
  )
}}

2021年、デスクトップとモバイルのページの98.8%が `<title>` 要素を持っていた。デスクトップとモバイルのホームページの71.1%が `<meta name="description">` タグを持っていました。

#### `<title>` 要素

`<title>`要素は、ページの関連性に関する強いヒントを提供するページ上のランキング要因であり、検索エンジンの結果ページ（SERP）に表示されることがあります。2021年8月、<a hreflang="en" href="https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles">Googleは検索結果のタイトルをより多く書き換えるようになりました</a>。

{{ figure_markup(
  image="title-word-counts.png",
  caption="title要素に使用されている単語数。",
  description="タイトルタグのパーセンタイル（10、25、50、75、90）の単語数を示す棒グラフ。中央のページには6語のタイトルが含まれ、全体の50%は3～9語のタイトルが含まれていました。 データセット内では、デスクトップとモバイルの間で単語数に差はありませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2017837375&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats.sql"
  )
}}

{{ figure_markup(
  image="title-character-counts.png",
  caption="title要素で使用される文字数。",
  description="パーセンタイル（10、25、50、75、90）ごとのタイトルタグの文字数を示す棒グラフ。中央値のページのタイトル文字数は、デスクトップで39文字、モバイルで40文字でした。今回のデータセットでは、デスクトップとモバイルで文字数にほとんど差はありませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1099454676&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats.sql"
  )
}}

2021年に

- 中央のページ `<title>` には6つの単語が含まれていた。
- ページの`<title>`の中央値は、デスクトップとモバイルでそれぞれ39文字と40文字でした。
- 10％のページで、12語を含む`<title>`要素があった。
- デスクトップとモバイルのページの10%に、それぞれ74文字と75文字を含む`<title>` 要素がありました。

これらの統計のほとんどは、昨年から比較的変化していません。これらはホームページのタイトルで、より深いページで使用されるものより短い傾向があることに注意してください。

#### メタ記述タグ

`<meta name="description>` タグは、ランキングに直接影響を与えません。しかし、SERP上でページの説明文として表示されることがあります。

{{ figure_markup(
  image="meta-word-counts.png",
  caption="メタ記述に使用されている単語数。",
  description="パーセンタイル（10、25、50、75、90）ごとのmeta記述の単語数を示す棒グラフ。中央のページには、デスクトップで20語、モバイルで19語のメタ記述が含まれていました。デスクトップとモバイルの文字数には、ほとんど差がありませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2013621429&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats.sql"
  )
}}

{{ figure_markup(
  image="meta-character-counts.png",
  caption="メタ記述に使用される文字数。",
  description="パーセンタイル（10、25、50、75、90）ごとのメタ記述タグの文字数を示す棒グラフ。中央のページでは、デスクトップページで138文字、モバイルページで137文字のメタ記述が含まれていました。このデータセットでは、デスクトップとモバイルで文字数にほとんど差はありませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=971210715&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats.sql"
  )
}}

2021年に

- デスクトップとモバイルのページの `<meta name="description>` タグには、それぞれ20語と19語が含まれています（中央値）。
- デスクトップとモバイルページの`<meta name="description>` タグ文字数の中央値は、それぞれ138文字と127文字でした。
- デスクトップとモバイルのページの10%に、35語を含む`<meta name="description>`タグがありました。
- デスクトップとモバイルのページの10%に、それぞれ232文字と231文字を含む`<meta name="description>`タグがありました。

この数値は、昨年と比較すると、ほぼ横ばいです。

### 画像

{{ figure_markup(
  image="number-of-images-per-page.png",
  caption="各ページの画像枚数。",
  description="パーセンタイル（10、25、50、75、90）ごとに、1ページあたりの`<img>`要素の数を示す棒グラフです。デスクトップ用ページの中央値は21個の `<img>` 要素、モバイル用ページの中央値は19個の `<img>` 要素を備えていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1314615789&format=interactive",
  sheets_gid="1483073708",
  sql_file="image-alt-stats.sql"
  )
}}

画像は、画像検索順位やページパフォーマンスに影響を与えるため、直接的・間接的にSEOに影響を与える可能性があります。

- 10%のページでは、`<img>`タグが2つ以下になっています。これは、デスクトップとモバイルの両方に当てはまります。
- デスクトップ用ページの中央値には21個の`<img>`タグがあり、モバイル用ページの中央値には19個の`<img>`タグがあります。
- デスクトップページの10%は、83個以上の`<img>`タグを持っています。モバイルページの10%は、73個以上の`<img>`タグを持っています。

この数字は2020年以降、ほとんど変化していません。

#### 画像の `alt` 属性

`<img>` 要素の `alt` 属性は、画像の内容を説明するのに役立ち、<a hreflang="en" href="https://almanac.httparchive.org/en/2021/accessibility">アクセシビリティ</a>へ影響を及ぼします。

なお、`alt`属性の欠落は問題を示さない場合があります。ページには極端に小さい画像や空白の画像が含まれていることがありますが、SEO（あるいはアクセシビリティ）上の理由から `alt` 属性は必要でありません。

{{ figure_markup(
  image="images-with-alt-attribute.png",
  caption="`alt` 属性を含む画像の割合。",
  description="パーセンタイル（10、25、50、75、90）ごとに`alt`属性が存在する画像の数を示す棒グラフです。このデータから、中央のウェブページには、モバイルページで54.6%、デスクトップページでは56.5%の`alt`属性の付いた画像が含まれていることがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1862003290&format=interactive",
  sheets_gid="412947118",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="images-with-blank-alt-attribute.png",
  caption="`alt` 属性が空白の割合。",
  description="パーセンタイル（25、50、75、90）ごとに、空白`alt`属性がフィーチャーされる割合を示す棒グラフ。中央のウェブページでは、デスクトップで10.5%、モバイルでは11.8%の空白の`alt`属性が表示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=198831003&format=interactive",
  sheets_gid="412947118",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="images-with-missing-alt-attribute.png",
  caption="`alt`属性がない画像の割合。",
  description="パーセンタイル（10、25、50、75、90）ごとに`alt`属性が欠落している画像の割合を示す棒グラフです。中央のウェブページでは、デスクトップでは `alt` 属性の欠落が1.4%、モバイルでは `alt` 属性の欠落が0%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=819909313&format=interactive",
  sheets_gid="412947118",
  sql_file="image-alt-stats.sql"
  )
}}

私たちはそれがわかりました

- デスクトップ用ページの中央値では、56.5%の `<img>` タグに `alt` 属性が設定されています。これは、2020年に比べてわずかに増加しています。
- モバイルページの中央値では、54.6%の `<img>` タグに `alt` 属性が設定されています。これは、2020年と比較して若干の増加です。
- しかし、デスクトップとモバイルページの中央値では、10.5%と11.8%の `<img>` タグが `alt` 属性を空白にしています（それぞれ）。これは事実上、2020年と同じです。
- 中央のデスクトップとモバイルのページでは、`<img>` タグに `alt` 属性なしがゼロか、それと近い値になっています。これは、中央ページにある`<img>`タグの2～3%に`alt`属性がなかった2020年に比べて改善されています。

#### 画像 `loading` 属性

`<img>` 要素の `loading` 属性は、ユーザーエージェントがページ上の画像のレンダリングと表示をどのように優先させるかに影響します。ユーザー体験やページの読み込み性能に影響を与える可能性があり、これらはいずれもSEOの成功に影響を与えます。

{{ figure_markup(
  image="image-loading-property-usage.png",
  caption="画像読み込みのプロパティの使用状況。",
  description='ページと画像読み込みプロパティの使用率（missing, lazy, eager, invalid, auto, blank）を示す棒グラフ。当社のデータでは、デスクトップページの83.3%、モバイルページの83.5%で画像の読み込みプロパティが欠落していることが判明しました。その結果、デスクトップとモバイルのページの15.6%が `loading="lazy"` を使用しており、`loading="eager"` はデスクトップとモバイルのページの0.8%に過ぎないことがわかりました。その他のケースは、デスクトップとモバイルのページで1%未満です。これには、無効なプロパティや空白のプロパティ、または `loading="auto"` を持つケースが含まれます。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1305654777&format=interactive",
  sheets_gid="55531578",
  sql_file="image-loading-property-usage.sql"
  )
}}

私たちはそれを見たのです。

- 85.5%のページでは、画像の `loading` プロパティが使用されていません。
- 15.6%のページが `loading="lazy"` を使用しており、ビューポートに入る寸前まで画像の読み込みを遅らせています。
- 0.8%のページでは、ブラウザがコードを読み込むと同時に画像を読み込む `loading="eager"` が使用されています。
- 0.1%のページで無効なローディングプロパティが使用されています。
- 0.1%のページでは、ブラウザのデフォルトの読み込み方法を使用する `loading="auto"` が使用されています。


### 単語数

ページ内の文字数はランキング要因ではありませんが、ページが文字を配信する方法はランキングに大きな影響を与えます。言葉は、未加工のページコードに含まれることも、レンダリングされたコンテンツに含まれることもあります。

#### レンダリング文字数

まず、レンダリングされたページの内容を見ます。_レンダリング_とは、ブラウザがすべてのJavaScriptとDOMまたはCSSOMを変更する他のコードを実行した後のページのコンテンツです。

{{ figure_markup(
  image="visible-rendered-words-percentile.png",
  caption="レンダリングされた可視ワードの割合。",
  description="パーセンタイル（10、25、50、75、90）別にレンダリングされた可視ワード数を示す棒グラフ。レンダリングされたデスクトップページの中央値は425語、モバイルページの中央値は367語でした。モバイル・ページで、すべてのパーセンタイルでレンダリングされる単語数が少なくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=833732027&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

- デスクトップページのレンダリング文字数の中央値は425語で、2020年には402語になっています。
- モバイルページのレンダリングの中央値は367語であるのに対し、2020年には348語となっています。
- モバイルページのレンダリングは、デスクトップページのレンダリングより13.6%少ない単語数です。Googleはモバイル専用のインデックスであることに注意してください。モバイル版にないコンテンツはインデックスされない可能性があります。

#### 未加工のワード数

次に、未加工のページコンテンツについて見ていきます。_未加工_とは、ブラウザがJavaScriptやDOMやCSSOMを修正する他のコードを実行する前のページのコンテンツのことです。ソースコードで配信され、目に見える「未加工」のコンテンツです。

{{ figure_markup(
  image="visible-raw-words-percentile.png",
  caption="未加工の可視化単語の割合。",
  description="パーセンタイル（10、25、50、75、90）ごとの未加工の可視ワード数を示す棒グラフ。デスクトップ用未加工ページの中央値は369語、モバイル用ページの中央値は321語でした。モバイル・ページで、すべてのパーセンタイルで未加工の単語数が少なくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=58186900&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

- デスクトップページの中央値は369語であるのに対し、2020年には360語になっています。
- モバイルページの中央値は321語であるのに対し、2020年には312語となっています。
- モバイルの未加工ページは、デスクトップの未加工ページよりも13.1%少ない単語しか含まれていません。Googleはモバイル専用のインデックスであることに注意してください。モバイルHTML版にないコンテンツは、インデックスされない可能性があります。

全体として、デスクトップ端末で書かれたコンテンツの15％が、モバイル版では14.3％がJavaScriptによって生成されています。

### 構造化データ

これまで検索エンジンは、非構造化データ、つまりページ上のテキストを構成する単語、段落、その他のコンテンツの山を扱ってきた。

スキーママークアップやその他の構造化データは、検索エンジンがコンテンツを解析し、整理するための別の方法を提供します。構造化データは、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/search-gallery">Googleの検索機能</a>の多くに力を与えています。

構造化データは、ページ上の単語と同様に、JavaScriptで変更できます。

{{ figure_markup(
  image="structured-data-usage.png",
  caption="構造化データの割合。",
  description="未加工の構造化データとレンダリングされた構造化データのページ数を示す棒グラフ。デスクトップでは41.8%、モバイルで42.5%のページが未加工の構造化データを持っていました。構造データをレンダリングしているページは、デスクトップで43.2%、モバイルでは44.2%であった。構造データのレンダリングのみを行っているページは少なく、デスクトップでは1.4％、モバイルでは1.7％でした。最後に、構造データのレンダリングが変更されたページは、デスクトップ用ページの4.5%、モバイル用ページの4.7%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1924313131&format=interactive",
  sheets_gid="1347655296",
  sql_file="seo-stats.sql"
  )
}}

モバイルページの42.5%、デスクトップページの41.8%が、HTML内に構造化データを有しています。モバイルページの4.7%、デスクトップページの4.5%で、JavaScriptが構造化データを修正しています。

モバイルページの1.7%、デスクトップページの1.4%で、最初のHTMLレスポンスに存在しない構造化データがJavaScriptによって追加されています。

#### もっとも一般的な構造化データ形式

{{ figure_markup(
  image="structured-data-formats.png",
  caption="構造化データ形式の内訳",
  description="構造化データ形式（JSON-LD、microdata、RDFa、microformats2）を採用しているページ数を示す棒グラフ。JSON-LD構造化データ形式は、デスクトップサイトの62.4%、モバイルサイトの60.5%で実装されています。microdata形式は、デスクトップの34.6%、モバイルの36.9%で実装されていた。RDFa形式は、デスクトップ用サイトの2.9%、モバイル用サイトの2.4%に実装されています。microformats2フォーマットは、データセット内のデスクトップとモバイルのサイトの0.2%で使用されていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1433352391&format=interactive",
  sheets_gid="1113852331",
  sql_file="structured-data-formats.sql"
  )
}}

構造化データをページに含めるには、いくつかの方法があります。JSON-LD、microdata、RDFa、microformats2などです。JSON-LDは、もっとも一般的な実装方法です。構造化データを持つデスクトップとモバイルのページの60%以上が、JSON-LDで実装しています。

構造化データを実装しているWebサイトのうち、デスクトップおよびモバイルページの36%以上がmicrodataを使用しており、RDFaまたはmicroformats2を使用しているページは3%未満です。

構造化データの導入は昨年より少し増えている。2020年の30.6%に対し、2021年は33.2%のページで使用されています。

#### もっとも一般的なスキーマの種類

{{ figure_markup(
  image="most-popular-schema-types.png",
  caption="もっとも一般的なスキーマの種類。",
  description="ホームページでもっともよく使われているスキーマの種類を示した棒グラフ。デスクトップとモバイルのホームページでほぼ同じ結果でした。もっとも人気のあるスキーマタイプは、WebSite、SearchAction、WebPage、UnknownType、Organizationでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=242663990&format=interactive",
  sheets_gid="1580260783",
  sql_file="structured-data-schema-types.sql",
  width=600,
  height=532
  )
}}

ホームページでもっともよく見られるスキーマタイプは `WebSite`、`SearchAction`、`WebPage` です。`SearchAction` は、<a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">サイトリンク検索ボックス</a> を動かすもので、Googleが検索結果ページで表示することを選択できます。

### `<h>` 要素（見出し）

見出し要素（`<h1>`、`<h2>`など）は、重要な構造要素です。ランキングに直接影響を与えるものではありませんが、Googleがページのコンテンツをより理解するのに役立ちます。

{{ figure_markup(
  image="heading-element-usage.png",
  caption="見出し要素の割合。",
  description="見出しタグ（レベル1、2、3、4）別に、H要素が存在するページの割合を示した棒グラフ。デスクトップとモバイルの結果にほとんど差はありませんでした。`h1`の見出しは65.4%のページに、`h2`は71.9%のページにもっとも多く、`h3`3は61.8%のページに、`h4`の見出しは37.6%のページに見受けられた。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1197492338&format=interactive",
  sheets_gid="1347655296",
  sql_file="seo-stats.sql"
  )
}}

主な見出しについては、 `h1`（65.4％）よりも多くのページ（71.9％）に`h2`があります。この差に明確な説明はありません。デスクトップとモバイルのページの61.4%は `h3` を使い、`h4` は39%以下です。

デスクトップとモバイルの見出しの使い方にほとんど差はなく、2020年に対して大きな変化もありませんでした。

{{ figure_markup(
  image="non-empty-heading-element-usage.png",
  caption="空でない見出し要素の使用状況。",
  description="見出しタグ（レベル1、2、3、4）別に、空でない`<h>`要素が存在するページの割合を示した棒グラフです。デスクトップとモバイルの結果には、ほとんど差がありませんでした。`h1`の見出しは58.1%のページで、`h2`は70.5%のページで、`h3`は60.3%のページで、`h4`の見出しは36.5%のページで、それぞれもっとも多く見受けられました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2102902536&format=interactive",
  sheets_gid="1347655296",
  sql_file="seo-stats.sql"
  )
}}

しかし、_空ではない_`<h>`要素、とくに`h1`を含むページの割合は低くなっています。ホームページでは、ロゴ画像を`<h1>`要素で囲むことが多いので、このような結果になったのでしょう。

## リンク

検索エンジンは、リンクを利用して新しいページを発見し、ページの重要性を判断するのに役立つ[_ページランク_](https://ja.wikipedia.org/wiki/%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%A9%E3%83%B3%E3%82%AF)を渡すために使用しています。

{{ figure_markup(
  caption="説明的でないリンクテキストを使用しているページ。",
  content="16.0%",
  classes="big-number",
  sheets_gid="1705330480",
  sql_file="lighthouse-seo-stats.sql"
)
}}

ページランクに加え、リンクアンカーとして使用されるテキストは、検索エンジンがリンク先のページが何であるかを理解するのに役立ちます。Lighthouseでは、使用されているアンカーテキストが有用なテキストであるか、それとも「詳しくはこちら」や「ここをクリック」といったあまり説明的でない一般的なアンカーテキストであるかをチェックするテストが用意されています。テストしたリンクの16%は、説明的なアンカーテキストを持っていませんでした。これは、SEOの観点からは機会を逃し、またアクセシビリティの観点からも良くありません。

### 内部および外部リンク

{{ figure_markup(
  image="outgoing-internal-link.png",
  caption="ホームページからの内部リンク",
  description="ホームページの内部リンク数をパーセンタイル（10、25、50、75、90）別に示した棒グラフです。デスクトップ用ホームページの中央値には64の内部リンクがあったのに対し、モバイル用ホームページには55の内部リンクがありました。どのパーセンタイルでも、デスクトップのホームページの方が内部リンクは多くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1929473622&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

内部リンクとは、同じサイト内の他のページへのリンクのことです。デスクトップ版に比べ、モバイル版ではページのリンクが少なかった。

このデータによると、デスクトップの内部リンク数の中央値はモバイルよりも16%多く、それぞれ64対55となっています。これは、開発者が小さい画面でも使いやすいように、モバイルではナビゲーションメニューやフッターを最小限にする傾向があるためと思われます。

もっとも人気のあるウェブサイト（CrUXのデータによると上位1,000）は、人気のないウェブサイトよりも多くの発信内部リンクを持っています。デスクトップでは144、モバイルでは110で、中央値より2倍以上多いのです。これは、一般的にページ数の多い大規模なサイトでメガメニューが使用されているためと思われます。

{{ figure_markup(
  image="outgoing-external-links.png",
  caption="ホームページからの外部リンク",
  description="ホームページの外部リンク数をパーセンタイル（10、25、50、75、90）別に示した棒グラフ。デスクトップ用ホームページの中央値には7つの外部リンクがあったのに対し、モバイル用ホームページには6つの外部リンクがありました。どのパーセンタイルでも、デスクトップ用ホームページの方が外部リンクは多いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=876769621&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

外部リンクとは、あるウェブサイトから別のサイトへのリンクのことです。このデータでも、モバイル版のページで外部リンクは少ないことがわかります。

2020年とほぼ同じ数字になっています。Googleは今年、モバイルファーストインデックスを展開したにもかかわらず、ウェブサイトはモバイル版をデスクトップ版と同等にすることができていないのです。

### テキストと画像のリンク

{{ figure_markup(
  image="text-links.png",
  caption="ホームページからのテキストリンク",
  description="パーセンタイル（10、25、50、75、90）ごとのテキストリンクの数を示す棒グラフ。中央値のページには、デスクトップで69、モバイルで63のテキストリンクが含まれていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1700739999&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="image-links.png",
  caption="ホームページからの画像リンク",
  description="パーセンタイル（10、25、50、75、90）ごとの画像リンク数を示す棒グラフ。中央のウェブページには、デスクトップでは7つの画像リンクが、モバイルでは6つの画像リンクが含まれていました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1217720785&format=interactive",
  sheets_gid="455169599",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

ウェブ上のリンクの大部分はテキストベースですが、画像から他のページにリンクしているものもあります。デスクトップページのリンクの9.2％、モバイルページのリンクの8.7％が画像リンクです。画像リンクでは、画像に設定された `alt` 属性がアンカーテキストとして機能し、そのページが何についてのページなのか、さらに詳しい情報を提供します。

### リンク属性

2019年9月、Googleは<a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">リンクを_スポンサー_または_ユーザーが作成したコンテンツ_に分類できる属性を導入しました</a>。これらの属性は、以前<a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">2005年に導入された`rel=nofollow`を追加したものです</a>。新しい属性である `rel=ugc` と `rel=sponsored` は、リンクに追加情報を与えます。

{{ figure_markup(
  image="rel-attibute-usage.png",
  caption="Rel属性の使用状況。",
  description='デスクトップとモバイルでのrel属性の使用率（％）を示す棒グラフ。当社のデータでは、デスクトップ版で29.2%、モバイル版では30.7%のホームページがnofollow属性を採用していることがわかりました。`rel="noopener"`は、デスクトップページの31.6%、モバイルページの30.1%で採用されました。`rel="noreferrer"`はデスクトップページの15.8%、モバイルページの14.8%に掲載されました。`rel="dofollow"`、`rel="ugc"`、`rel="sponsored"`、`rel="follow"`はいずれもデスクトップとモバイルのページの1%未満にしか表示されませんでした。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1672151299&format=interactive",
  sheets_gid="1936997045",
  sql_file="anchor-rel-attribute-usage.sql"
  )
}}

新しい属性は、少なくともホームページではまだかなり稀で、`rel="ugc"`はモバイルページの0.4%、`rel="sponsored"`はモバイルページの0.3%に表示されます。これらの属性は、ホームページ以外のページでより多く採用されている可能性があります。

`rel="follow"` と `rel=dofollow` は `rel="ugc"` や `rel="sponsored"` よりも多くのページで表示されます。これは問題ではありませんが、Googleは `rel="follow"` と `rel="dofollow"` を公式の属性ではないので無視します。

`rel="nofollow"`は30.7%のモバイルページで見つかり、昨年と同様でした。この属性は非常に多く使われているため、Googleが`nofollow`をヒントに変更したのは当然のことで、つまり、それを尊重するかどうかを選択できるようになったのです。

## アクセラレイテッド・モバイル・ページ（AMP）

2021年、アクセラレイテッド・モバイル・ページ (AMP)のエコシステムに大きな変化がありました。AMPは <a hreflang="en" href="https://developers.google.com/search/blog/2021/04/more-details-page-experience#details">トップページカルーセルには必要なくなり、Google Newsアプリにも必要なくなり、GoogleはSERPのAMP結果の横にAMPロゴを表示しなくなりました</a>。

{{ figure_markup(
  image="amp-markup-types.png",
  caption="AMP属性の使用状況。",
  description="AMPマークアップタイプを持つページの割合を示す棒グラフ。Amp属性は、デスクトップ向けページの0.09%、モバイル向けページの0.22%に存在しました。Amp & Emjoi属性は、デスクトップ向けページの0.02%、モバイル向けページの0.04%に適用されています。AmpまたはEmjoi属性は、デスクトップページの0.10%、モバイルページの0.26%で使用されました。最後に、Rel Ampタグは、デスクトップページの0.82%、モバイルページの0.75%で使用されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1787667985&format=interactive",
  sheets_gid="718210755",
  sql_file="markup-stats.sql"
  )
}}

しかし、2021年になってもAMPの採用は増え続けている。現在、デスクトップページの0.09%にAMP属性が含まれているのに対し、モバイルページは0.22%となっています。これは、2020年のデスクトップページの0.06％、モバイルページの0.15％から上昇したものです。

## 国際化

<figure>
  <blockquote>言語や地域によって複数のバージョンのページがある場合は、Googleにそのことを伝えてください。そうすることで、Google検索がユーザーに言語や地域ごとにもっとも適切なバージョンのページを提供することができます。</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://developers.google.com/search/docs/advanced/crawling/localized-versions">Google SEOのドキュメント</a></cite></figcaption>
</figure>

検索エンジンにローカライズされたページを知らせるには、`hreflang`タグを使用します。`hreflang`属性は、<a hreflang="en" href="https://yandex.com/support/webmaster/yandex-indexing/locale-pages.html">Yandex</a> やBing（[ある程度](https://x.com/facan/status/1304120691172601856)）でも使用されています。

{{ figure_markup(
  image="hreflang-usage.png",
  caption="hreflangタグのトップ属性表。",
  description="hreflangの使用状況を示す横棒グラフ。もっとも利用されているhreflang属性は`en`（英語版）で、hreflang属性（全言語）はデスクトップおよびモバイルページの5%未満にしか実装されていませんでした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1149395895&format=interactive",
  sheets_gid="866829014",
  sql_file="hreflang-link-tag-usage.sql",
  width=600,
  height=546
  )
}}

デスクトップ用ページの9.0%、モバイル用ページの8.4%がhreflang属性を使用しています。

`hreflang` 情報の実装方法には、HTMLの `<head>` 要素、 `Link` ヘッダー、XMLサイトマップの3つがあります。このデータには、XMLサイトマップのデータは含まれていない。

hreflang属性でもっとも利用されているのは、`"en"`（英語版）です。モバイル用ホームページの4.75％、デスクトップ用ホームページの5.32％が使用しています。

`x-default`（フォールバック版とも呼ばれる）は、モバイルでは2.56%のケースで使用されています。`hreflang` 属性で指定されるその他の一般的な言語は、フランス語とスペイン語です。

Bingにとって、[`hreflang` は `content-language` ヘッダーよりも「はるかに弱い信号」です](https://x.com/facan/status/1304120691172601856)。

他の多くのSEOパラメーターと同様に、[`content-language`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Language)には、以下のような複数の実装方法があります。

1. HTTPサーバーレスポンス
2. HTMLタグ

{{ figure_markup(
  image="language-usage-html-http.png",
  caption="言語使用状況（HTML、HTTPヘッダー）。",
  description="言語が使用されているページの割合を示す横棒グラフ（HTMLとHTTPヘッダー）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2048466165&format=interactive",
  sheets_gid="933228304",
  sql_file="content-language-usage.sql",
  width=600,
  height=529
  )
}}

`content-language` を実装するには、HTTPサーバーレスポンスを使用するのがもっとも一般的な方法です。デスクトップでは8.7％、モバイルでは9.3％のウェブサイトがこの方法を採用しています。

HTMLタグの使用はあまり一般的でなく、content-languageが表示されるのはモバイルサイトのわずか3.3%です。

## 結論

ウェブサイトは、SEOの観点から徐々に改善されてきています。おそらく、ウェブサイトがSEOを改善し、ウェブサイトをホストするプラットフォームも改善していることが複合的に作用しているのだろう。ウェブは広くて厄介な場所なので、まだまだやるべきことはたくさんありますが、一貫した進歩が見られるのは嬉しいことです。
