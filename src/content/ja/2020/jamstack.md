---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: 2020年のWeb AlmanacのJamstackの章では、Jamstackの利用方法、人気の高いJamstackフレームワークのパフォーマンス、Core Web Vitalsのメタデータを使ったリアルユーザー体験の分析などを取り上げています。
hero_alt: Hero image of the Web Almanac chracters using a large gas cylinder with script markings on the front to inflate a web page.
authors: [ahmadawais]
reviewers: [MaedahBatool, phacks]
analysts: [denar90, remotesynth]
editors: [tunetheweb]
translators: [ksakae1216]
ahmadawais_bio: Ahmad Awaisは、受賞歴のあるオープンソースエンジニアで、Google Developers Expert Dev Advocate、Node.js Community Committee Outreach Lead、WordPress Core Dev、WGAのエンジニアリングDevRelのVPです。彼は世界中の何百万人もの開発者に利用されている様々なオープンソースのソフトウェアツールを執筆しています。彼の<a hreflang="en" href="https://shadesofpurple.pro/more">Shades of Purple</a>のコードテーマや<a hreflang="en" href=" https://github.com/AhmadAwais/corona-cli">corona-cli</a>のようなプロジェクトのように。Awaisは教えることが大好きです。2万人以上の開発者が彼の<a hreflang="en" href="https://AhmadAwais.com/courses/">コース</a>、つまり<a hreflang="en" href="https://nodecli.com/">Node CLI</a>、<a hreflang="en" href="https://vscode.pro/">VSCode.pro</a>、<a hreflang="en" href="https://nextjsbeginner.com/">Next.js Beginner</a>から学んでいます。Awaisは、<a hreflang="en" href="https://ahmadawais.com/github-stars/">12人のGitHub Stars</a>としてFOSSコミュニティのリーダーシップを評価されました。彼はSmashing Magazine Experts Panelのメンバーであり、CSS-Tricks, Tuts+, Scotch.io, SitePointで特集＆出版された著者です。<a hreflang="en" href="https://awais.dev/odmt">#OneDevMinute</a> 開発者のヒントをツイートしています。
discuss: 2053
results: https://docs.google.com/spreadsheets/d/1BCC5Q4tePpTl8TiaGmSxBc9Lh2to7xBfVPMULFOBwvk/
featured_quote: 統計によると、2019年の2倍以上のJamstackサイトが存在しています。開発者は、フロントエンドとバックエンドを分離することで、より良い開発体験を楽しむことができます。しかし、Jamstackサイトを閲覧する際のリアルユーザーの体験はどうでしょうか？
featured_stat_1: 147%
featured_stat_label_1: 2020年のJamstackサイトの増加
featured_stat_2: 1 gram
featured_stat_label_2: ページロード時のJamstack中央値のCO2排出量
featured_stat_3: 58.59%
featured_stat_label_3: Next.jsを使って構築したJamstackサイト
---

## 序章

Jamstackは比較的新しいコンセプトのアーキテクチャでウェブをより速く、より安全に、より簡単に拡張できるよう設計されています。開発者が大好きなツールやワークフローの多くをベースにしており、生産性を最大化します。

Jamstackの中核となる原則は、サイトページのプリレンダリングとフロントエンドとバックエンドの分離です。フロントエンドのコンテンツは、バックエンドとしてAPI（例えば、ヘッドレスCMS）を使用するCDNプロバイダー上で別々にホスティングされたものを配信するという考え方に依存しています。

<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>は、毎月何百億ものページ</a>をクロールし、<a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">WebPageTest</a>のプライベートインスタンスを通して実行し、クロールされたすべてのページのキー情報を保存しています。これについての詳細は[methodology](./methodology) ページを参照してください。Jamstackの文脈では、HTTP Archiveは、Web全体のフレームワークやCDNの利用方法についての広範な情報を提供しています。この章では、これらの傾向の多くを集約して分析しています。

この章の目的は、Jamstackサイトの成長の推定と分析、人気のあるJamstackフレームワークのパフォーマンス、そしてCore Web Vitalsのメトリクスを使った実際のユーザー体験の分析です。

<p class="note">我々の分析は、<a href="./methodology#wappalyzer">Wappalyzer</a>で簡単に識別できるJamstackによって制限されていることに注意してください。これは、<a hreflang="en" href="https://github.com/11ty/eleventy/">Eleventy</a>のように、<a href="https://x.com/eleven_ty/status/1334225624110608387?s=20">意図的に識別できないようにしている人気のあるJamstack</a>はデータに含まれていないことを意味します。理想的にはすべてのJamstacksを含むことになりますが、我々が持っている重要なデータを分析することにはまだ多くの価値があると考えています。</p>

## Jamstackの採用

この作業全体を通して、私たちの分析はデスクトップとモバイルのウェブサイトに注目しています。調査したURLの大部分は両方のデータセットに含まれていますが、一部のURLはデスクトップまたはモバイルデバイスからしかアクセスされていません。このため、データに小さな乖離が生じる可能性があるため、デスクトップとモバイルの結果を別々に見ています。

{{ figure_markup(
  image="jamstack-adoption.png",
  caption="Jamstackの採用動向。",
  description="2019年と2020年のJamstack導入レベルの上昇を示す棒グラフ。モバイルは0.50%から0.91%に増加。デスクトップは0.34%から0.84%に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1650360073&format=interactive",
  sheets_gid="908645975",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

ウェブページの約0.9%がJamstackを利用しており、内訳はデスクトップで0.91%と2019年の0.50%から、モバイルで0.84%と2019年の0.34%から上昇しています。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">年</th>
        <th scope="col">デスクトップ</th>
        <th scope="col">モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2019</td>
        <td class="numeric">0.50%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td>2020</td>
        <td class="numeric">0.91%</td>
        <td class="numeric">0.85%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">% Change</td>
        <th scope="col" class="numeric">85%</td>
        <th scope="col" class="numeric">147%</td>
      </tr>
    </tfoot>
  </table>
  <figcaption>{{ figure_link(caption="Jamstackの採用統計。", sheets_gid="908645975", sql_file="ssg_compared_to_2019.sql") }}</figcaption>
</figure>

Jamstackフレームワークを使ったデスクトップのウェブページの増加率は昨年より85%増加しています。モバイルでは147%とほぼ2.5倍の増加です。これは2019年からの大幅な伸びで、特にモバイルページの伸びが顕著です。これはJamstackコミュニティが着実に成長していることの表れだと考えています。

## Jamstackフレームワーク

私たちの分析では、14個のJamstackフレームワークをカウントしました。1%以上のシェアを持っていたのは6つのフレームワークだけでした。Next.js、Nuxt.js Gatsby、Hugo、JekyllがJamstack市場シェアのトップを争っています。

2020年には、Jamstackのシェアのほとんどが上位5つのフレームワークに分散しているようです。興味深いことに、Next.jsの利用シェアは58.65%です。これは、次に人気のあるJamstackフレームワークであるNuxt.jsのシェア18.6%の3倍以上です。

{{ figure_markup(
  image="jamstack-adoption-share-2020-pie.png",
  caption="Jamstackの採用シェア円グラフ2020年",
  description="Jamstackフレームワークの採用状況を示す円グラフでは、Next.jsが58.6%と3分の2近くのシェアを占め、次に人気の高いNuxt.jsが18.6%、次いでGatsbyが12.0%、Hugoが5.3%、Jekyllが3.4%となっており、さらにラベルのない小さなウェッジが続いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=239192419&format=interactive",
  sheets_gid="1474840498",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

### フレームワーク採用の変更

前年比の成長を見ると、この1年でNext.jsは競合他社よりもリードを伸ばしていることがわかります。

<figure>
  <table>
    <thead>
      <tr>
        <th>Jamstack</th>
        <th>2019</th>
        <th>2020</th>
        <th>% change</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Next.js</td>
        <td class="numeric">47.89%</td>
        <td class="numeric">58.59%</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td>Nuxt.js</td>
        <td class="numeric">20.30%</td>
        <td class="numeric">18.59%</td>
        <td class="numeric">-8%</td>
      </tr>
      <tr>
        <td>Gatsby</td>
        <td class="numeric">12.45%</td>
        <td class="numeric">11.99%</td>
        <td class="numeric">-4%</td>
      </tr>
      <tr>
        <td>Hugo</td>
        <td class="numeric">9.50%</td>
        <td class="numeric">5.30%</td>
        <td class="numeric">-44%</td>
      </tr>
      <tr>
        <td>Jekyll</td>
        <td class="numeric">6.22%</td>
        <td class="numeric">3.43%</td>
        <td class="numeric">-45%</td>
      </tr>
      <tr>
        <td>Hexo</td>
        <td class="numeric">1.16%</td>
        <td class="numeric">0.64%</td>
        <td class="numeric">-45%</td>
      </tr>
      <tr>
        <td>Docusaurus</td>
        <td class="numeric">1.26%</td>
        <td class="numeric">0.60%</td>
        <td class="numeric">-52%</td>
      </tr>
      <tr>
        <td>Gridsome</td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.46%</td>
        <td class="numeric">140%</td>
      </tr>
      <tr>
        <td>Octopress</td>
        <td class="numeric">0.61%</td>
        <td class="numeric">0.20%</td>
        <td class="numeric">-68%</td>
      </tr>
      <tr>
        <td>Pelican</td>
        <td class="numeric">0.31%</td>
        <td class="numeric">0.11%</td>
        <td class="numeric">-64%</td>
      </tr>
      <tr>
        <td>VuePress</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>Phenomic</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">-77%</td>
      </tr>
      <tr>
        <td>Saber</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>Cecil</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">-100%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Jamstackフレームワークの相対的な採用率%", sheets_gid="1474840498", sql_file="ssg_compared_to_2019.sql") }}</figcaption>
</figure>

そして、上位5つのJamstacksに集中することで、Next.jsのリードをさらに示しています。

{{ figure_markup(
  image="jamstack-adoption-share-yoy.png",
  caption="Jamstackの採用シェア前年比",
  description="Jamstackフレームワーク上位5社の採用シェアと2019年から2020年までの変化、Next.jsは47.89%から58.59%に増加しています。残りはかなり小さく、20.30%から18.59%に縮小したNuxt.js、12.45%から11.99%に微減したGatsby、9.50%から5.30%にほぼ半減したHugo、そして最後に6.22%から3.43%に縮小したJekyllが牽引しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=750685917&format=interactive",
  sheets_gid="1474840498",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

ここで注目すべきは、Next.jsとNuxt.jsのウェブサイトには、SSG（Static Site Generated）ページとSSR（Server-Side Rendered）ページの両方が混在しているという事実です。これは、これらを別々に測定する能力がないためです。つまり、分析には大部分または部分的にサーバーレンダリングされたサイトが含まれている可能性があり、従来のJamstackサイトの定義には当てはまらないことを意味します。それにもかかわらず、Next.jsのこのハイブリッドな性質が他のフレームワークと比較して競争上の優位性を与えており、それが人気を高めているように見えます。

## 環境への影響

今年はJamstackのサイトが環境に与える影響の理解を深めようとした。<a hreflang="en" href="https://www.nature.com/articles/d41586-018-06610-y">情報通信技術（ICT）産業は世界の炭素排出量の2%を占めており</a>、データセンターは世界の炭素排出量の0.3%を占めています。これは、ICT業界のカーボンフットプリントを航空業界の燃料からの排出量に相当する。

Jamstackはパフォーマンスに気を使っているとクレジットされることが多いです。次のセクションでは、Jamstackのウェブサイトの二酸化炭素排出量を見てみましょう。

### ページ重量

当社の調査では、Jamstackの平均ページ重量をKB単位で調べ、<a hreflang="en" href="https://gitlab.com/wholegrain/carbon-api-2-0/-/blob/master/includes/carbonapi.php#L342">Carbon API</a>のロジックを使用してCO2排出量にマッピングしました。これにより、デスクトップとモバイルに分けて以下のような結果が得られました。

{{ figure_markup(
  image="jamstack-carbon-emissions-per-jamstack-page-view.png",
  caption="Jamstackのページビューごとの炭素排出量です。",
  description="JamstackのページのCO2排出量をパーセンタイル別に示した棒グラフです。10パーセンタイルではデスクトップ0.3グラム、モバイル0.4グラム、25パーセンタイルでは両方とも0.6グラム、50パーセンタイルではデスクトップ1.2グラム、モバイル1.0グラム、75パーセンタイルではデスクトップ2.3グラム、モバイル1.9グラム、90パーセンタイルではデスクトップ4.4グラム、モバイル3.6グラムとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1748236124&format=interactive",
  sheets_gid="881269360",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_ssg_web_page.sql"
  )
}}

Jamstackのページロードの中央値は、デスクトップでは1.82MB、モバイルでは1.54MBのさまざまな資産を転送し、それぞれ1.2グラムと1.0グラムのCO2を排出していることがわかりました。Jamstackのウェブページの最も効率的なパーセンタイルでは、中央値よりも少なくとも3分の1のCO2排出量が少なくなりますが、Jamstackのウェブページの最も効率的でないパーセンタイルでは、逆に約4倍のCO2排出量になります。

ここで重要なのは、[ページ重量](./page-weight)です。平均的なデスクトップのJamstackのウェブページは、1.5MBのビデオ、画像、スクリプト、フォント、CSS、オーディオデータを読み込みます。しかし、10%のページでは4MB以上のデータが読み込まれます。モバイルデバイスでは、平均的なウェブページの読み込み量はデスクトップよりも0.28MB少なく、すべてのパーセンタイルで一貫しています。

### 画像フォーマット

人気の画像フォーマットはPNG、JPG、GIF、SVG、WebP、ICOです。これらの中では、<a hreflang ="en" href="https://developers.google.com/speed/webp/">ほとんどの状況でWebPが最も効率的</a>で、WebPの損失のない画像は<a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_lossless_alpha_study#results">同等のPNGよりも26%小さく</a>、同等のJPGよりも<a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">25-34%小さく</a>なっています。しかし、WebPはすべてのJamstackページで2番目に人気のない画像フォーマットですが、モバイルとデスクトップではPNGが最も人気があります。一方、JPGはわずかに人気がないのに対し、GIFはJamstackサイトで使用されている画像の20%近くを占めています。興味深いのはSVGで、モバイルサイトではデスクトップサイトの約2倍の人気があります。

{{ figure_markup(
  image="jamstack-popularity-of-image-formats.png",
  caption="画像フォーマットの普及。",
  description="Jamstackの画像の種類別の割合を示す棒グラフ。PNGはデスクトップ33%、モバイル28%、JPGはデスクトップ30%、モバイル26%、GIFはデスクトップ18%、モバイル19%、SVGはデスクトップ14%、モバイル22%、WebPはデスクトップ4%、モバイル3%、ICOはデスクトップ、モバイルともに2%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1593285227&format=interactive",
  sheets_gid="1626843605",
  sql_file="adoption_of_image_formats_in_ssgs.sql"
  )
}}

### サードパーティのバイト

Jamstackサイトは、ほとんどのウェブサイトと同様に、外部画像、ビデオ、スクリプト、スタイルシートなどの[サードパーティ](./third-party)リソースを読み込むことがよくあります。

{{ figure_markup(
  image="jamstack-third-party-bytes.png",
  caption="サードパーティのバイト。",
  description="Jamstackページのパーセンタイルごとのサードパーティ・バイト量（KB単位）を示す棒グラフです。10パーセンタイルではデスクトップ45KB、モバイル60KB、25パーセンタイルではデスクトップ149KB、モバイル212KB、50パーセンタイルではデスクトップ470KB、モバイル642KB、75パーセンタイルではデスクトップ1,219KB、モバイル1,788、90パーセンタイルではデスクトップ2,878KB、モバイル3,044KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1779247936&format=interactive",
  sheets_gid="1292933800",
  sql_file="third_party_bytes_and_requests_on_ssgs.sql"
  )
}}

デスクトップのJamstackページの中央値では、サードパーティからのリクエストが26件、470 KBのコンテンツがあり、モバイルでは38件、642 KBのコンテンツが発生していることがわかりました。一方、デスクトップサイトの10%のサイトでは、2.88MBのコンテンツで114件のリクエストがありますが、モバイルでは3MBのコンテンツで148件のリクエストがあります。

## ユーザー体験

JamstackのWebサイトは、良いユーザー体験を提供するとよく言われます。フロントエンドとバックエンドを分離し、CDNエッジでホスティングするというコンセプトは、まさにその通りです。最近立ち上げた<a hreflang="ja" href="https://web.dev/i18n/ja/learn-web-vitals/">Core Web Vitals</a>を使って、JamstackのWebサイトを利用したときの実際のユーザー体験に光を当てることを目的としています。

Core Web Vitalsは、ユーザーがJamstackのページをどのように体験しているのかを理解するための3つの重要な要素です。

- 最大のコンテンツフルペイント(LCP)
- 最初の入力までの遅延(FID)
- 累積レイアウト変更(CLS)

これらのメトリクスは、優れたウェブ・ユーザー・体験を示すコア要素をカバーすることを目的としています。ここでは、Jamstackフレームワークのトップ5のコア・ウェブ・バイタルの統計を見てみましょう。

### 最大のコンテンツフルペイント

最大のコンテンツフルペイント(LCP)は、ページのメインコンテンツが読み込まれた可能性が高く、ユーザーにとって有用なページであるかどうかを測定します。これは、ビューポート内に表示されている最大の画像またはテキストブロックのレンダリング時間を測定することによって行われます。

これは、ページの読み込みからテキストや画像などのコンテンツが最初に表示されるまでを計測する最初の入力までの遅延(FID)とは異なります。LCPは、ページのメインコンテンツが読み込まれたときに測定する良い代理人と考えられています。

{{ figure_markup(
  image="jamstack-real-user-largest-contentful-paint-experiences.png",
  caption="リアルユーザー最大のコンテントフルペイント体験談",
  description='Jamstackフレームワークの上位5つと、最大のコンテントフルペイントの「良い」体験をしているかどうかを示す棒グラフです。Gatsbyはデスクトップで52%ですが、モバイルでは36%しかなく、Next.jsはデスクトップで38%、モバイルで23%と最下位、Nuxt.jsはデスクトップで31%、モバイルで18%と最下位、Hugoはデスクトップで85%、モバイルで69%と2位、Jekyllはデスクトップで91%、モバイルで74%と1位となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=125934259&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

「良い」LCPは2.5秒以下とされています。JekyllとHugoのLCPスコアはいずれも50%を超えており、デスクトップではJekyllが91%、Hugoが85%と、印象的なスコアとなっています。Gatsby、Next.js、Nuxt.jsのサイトは遅れており、デスクトップではそれぞれ52%、38%、31%、モバイルでは36%、23%、18%となっています。

これは、主に動的な部分が少ない、あるいは全くない静的なコンテンツサイトを作るために使われるHugoやJekyllに比べて、GatsbyやNext.js、Nuxt.jsで構築されたサイトのほとんどが複雑なレイアウトと高いページウェイトを持っているという事実に起因しているかもしれません。とりあえず、HugoやJekyllでReactやVueJSなどのJavaScriptフレームワークを使う必要はありません。

上のセクションで説明したように、ページの重みが高いと環境に影響を与える可能性があります。しかし、これはLCPのパフォーマンスにも影響し、Jamstackフレームワークによって非常に良いか、一般的には悪いかのどちらかになります。これは実際のユーザー体験にも影響を与える可能性があります。

### 最初の入力までの遅延

最初の入力までの遅延(FID)は、ユーザーが最初にサイトとやり取りをした時（リンクをクリックした時、ボタンをタップした時、カスタムJavaScriptを使用したコントロールを使用した時など）から、ブラウザが実際にそのやり取りに反応するまでの時間を測定します。

ユーザーの視点から見た「速い」FIDは、停滞した体験よりも、サイト上での行動から即時のフィードバックを提供します。この遅延は問題点であり、ユーザーがサイトを操作しようとしたときに、サイトの読み込みの他の側面からの干渉と相関する可能性があります。

FIDは、デスクトップの平均的なJamstackのウェブサイトでは非常に速く、最も人気のあるフレームワークでは100%のスコアを獲得し、モバイルでは80%以上のスコアを獲得しています。

{{ figure_markup(
  image="jamstack-real-user-first-input-delay-experiences.png",
  caption="リアルユーザーのファースト入力遅延体験。",
  description='Jamstackのトップ5と「良い」最初の入力までの遅延があるかどうかを示す棒グラフ。デスクトップではすべて100%の体験スコアを持っています。モバイルではGatsbyが89%、Next.jsが87%、Nuxt.jsが86%、Hugoが84%、Jekyllが82%となっています。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=736622498&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

ウェブサイトのデスクトップ版とモバイル版に出荷されるリソースの間には、わずかな差があります。ここではFIDのスコアは概ね非常に良いのですが、これが似たようなLCPのスコアに翻訳されていないのは興味深いところです。示唆されているように、Jamstackサイトの個々のページの重みに加えて、モバイル接続の品質が、ここで見られるパフォーマンスのギャップに一役買っている可能性があります。

### 累積レイアウト変更

累積レイアウト変更（CLS）は、ユーザー入力の最初の500ms以内のウェブページ上のコンテンツの不安定性を測定します。CLSは、ユーザーが入力した後に起こるレイアウトの変化を測定します。これは特にモバイルでは重要です。ユーザーがアクションを起こしたい場所（検索バーなど）をタップしても、追加の画像や広告などが読み込まれると場所が移動してしまう場合があります。

0.1点以下が良い、0.25点以上が悪い、その間は何をしても改善が必要。

{{ figure_markup(
  image="jamstack-real-user-cumulative-layout-shift-experiences.png",
  caption="リアルユーザーの累積レイアウト変更の体験",
  description='Jamstackのトップ5と「良い」累積レイアウト変更の経験があるかどうかを示す棒グラフ。 Gatsbyはデスクトップ、モバイルサイトともに66％、Next.jsはデスクトップ48％、モバイルサイト49％、Nuxt.jsはデスクトップ45％、モバイルサイト46％、Hugoはデスクトップ74％、モバイルサイト78％、Jekyllはデスクトップ、モバイルサイトともに82％と「良い経験」をしていることがわかります。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1984155453&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

Jamstackフレームワークのトップ5は、ここでOKを出しています。トップ5のJamstackフレームワークで読み込まれたウェブページの約65%が「良い」CLS体験を持っており、モバイルでは82%まで上昇しています。デスクトップとモバイルの平均スコアは65%です。Next.jsとNuxt.jsはともに50%を下回っており、ここに課題があります。開発者を教育し、悪いCLSスコアを回避する方法を文書化することは、長い道のりを歩むことになります。

## 結論

Jamstackは、コンセプトとしてもスタックとしても、この1年で重要性を増しました。統計によると、2019年の約2倍のJamstackサイトが存在しています。開発者は、フロントエンドとバックエンド（ヘッドレスCMS、サーバーレス機能、またはサードパーティのサービス）を分離することで、より良い開発体験を楽しむことができます。しかし、Jamstackサイトを閲覧するリアルユーザーの体験はどうでしょうか？

Jamstackの採用状況、Jamstackフレームワークで作成されたWebサイトのユーザーエクスペリエンスをレビューし、初めてJamstackが環境に与える影響を見てみました。ここでは多くの疑問に答えてきましたが、さらなる疑問は残しておきます。

Eleventyのようなフレームワークもありますが、そのようなフレームワークの利用状況を把握するパターンがないため、今回のデータに影響を与えています。Next.jsはスタティックサイト生成とサーバーサイドレンダリングの両方を提供していますが、スタティックサイト生成もインクリメンタルに提供しているため、このデータで両者を分離することはほぼ不可能です。この章をベースにした更なる研究を歓迎します。

さらに、Jamstackコミュニティが注意を払う必要がある分野をいくつか取り上げました。2021年のレポートで共有できるような進展があることを願っています。さまざまなJamstackフレームワークは、コア・ウェブ・バイタルを見ることで、リアル・ユーザー体験を向上させる方法を文書化できます。

JamstackサイトをホストするCDNの1つであるVercelは、<a hreflang="en" href="https://vercel.com/docs/analytics#real-experience-score">リアルユーザー体験スコア</a>と呼ばれる分析サービスを構築しました。<a hreflang="en" href="https://web.dev/measure/">Lighthouse</a>のような他のパフォーマンス測定ツールが、ラボでシミュレーションを実行してユーザーの体験を推定するのに対し、Vercelのリアル体験スコアは、アプリケーションの実際のユーザーのデバイスから収集した実際のデータポイントを使用して計算されます。

ここで注目すべきは、Next.jsのLCPスコアが低かったため、VercelがNext.jsを作成し、維持管理していることでしょう。今回の新しい提供は、来年にはLCPスコアが大幅に改善されることを意味しています。これは、ユーザーや開発者にとって非常に有益な情報となるでしょう。

Jamstackフレームワークは、サイト構築の開発者体験を向上させています。Jamstackのサイトを閲覧する際のリアルユーザー体験を向上させるために、今後も継続的な改善を目指していきましょう。
