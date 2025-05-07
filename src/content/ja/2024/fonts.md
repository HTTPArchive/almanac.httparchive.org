---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: フォント
description: フォントが読み込まれる場所、フォント形式、フォント読み込みパフォーマンス、可変フォント、カラーフォントをカバーする2024 Web Almanacのフォントの章。
hero_alt: Web Almanacのキャラクターたちが、さまざまなスタイルと形のFの文字を準備するアセンブリラインに並んでいるヒーロー画像。
authors: [bramstein, charlesberret]
reviewers: [drott, svgeesus, ivanukhov, jmsole, liamquin, mandymichael, raphlinus]
editors: [charlesberret]
analysts: [ivanukhov]
translators: [ksakae1216]
bramstein_bio: Bram Steinは<a hreflang="en" href="https://thetypefounders.com">The Type Founders</a>のチーフテクノロジーオフィサー（CTO）です。以前は<a hreflang="en" href="https://fonts.adobe.com">Adobe Fonts</a>のウェブフォント部門長を務めていました。<a hreflang="en" href="https://abookapart.com/products/webfont-handbook">Webfont Handbook</a>の著者であり、世界中のカンファレンスでタイポグラフィとウェブパフォーマンスについて講演しています。
charlesberret_bio: Charles Berretはライター、学際的研究者、データジャーナリストとして、メディアと情報技術の歴史と哲学を研究しています。
results: https://docs.google.com/spreadsheets/d/1EkdvJ8e0B9Rr42evC2Ds5Ekwq6gF9oLBW0BA5cmSUT4/
featured_quote: トレンドは明らかです&colon; より多くの人々がウェブフォントをセルフホストすることを好んでいます。これは多くの場合に優れた選択です。なぜなら、セルフホスティングはフォントのようなレンダリングに不可欠なものに対する外部依存を避けることができるからです。
featured_stat_1: 11%
featured_stat_label_1: フォントをプリロードするためにリソースヒントを使用しているページの割合。
featured_stat_2: 55%
featured_stat_label_2: OpenType機能をサポートするフォント。
featured_stat_3: 34%
featured_stat_label_3: 可変フォントを使用しているページの割合。
doi: 10.5281/zenodo.14065682
---

## はじめに

タイポグラフィーは、読みやすさや可読性から、アクセシビリティや感情的な影響に至るまで、ウェブ上のユーザー体験において重要な役割を果たしています。かつてウェブ開発者は限られた数のウェブセーフフォントに制限されていましたが、現在では豊かな表現力と世界の多くの文字体系に対する包括的なサポートを提供する膨大なライブラリを利用できるようになりました。

今年のHTTP Almanacウェブクロールによると、ウェブフォントの使用は成長を続けていますが、以前の年に観測されたペースよりも緩やかになっています。ウェブフォントは現在、単独でも自己ホスティングフォントとの組み合わせでも、全ウェブサイトの約87%で使用されています。同時に、フォント配信の唯一の手段として自己ホスティングを採用するウェブサイトの数が増加しています。このトレンドは、自己ホスティングとフォントサービスの組み合わせを使用するウェブサイトの若干の減少と一致しています。それでも、Google Fontsサービスはウェブで見られるフォントの大部分を提供し続けています。HTTP Archiveのデスクトップクロールで観測されたウェブサイトの約57%、モバイルクロールで観測されたウェブサイトの48%が、単独または他のホスティングオプションと併用してGoogle Fontsを使用しています。

{{ figure_markup(
  image="webfont-usage.png",
  caption="Webフォントの使用状況。",
  description="2010年（使用率0%）から2024年（使用率87%）までのウェブフォントのリクエスト割合を示す散布図。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=760658561&format=interactive",
  sheets_gid="1602101968",
  sql_file="performance/fonts.sql"
  )
}}

OpenType機能のサポートは、HTTP Almanacの過去の版で見られたトレンドに続いて増加し続けています。これは、現在ウェブで使用されているフォントの増加する割合が、合字（リガチャ）、カーニング、分数などの少なくとも1つのOpenType機能を備えてデザインされていることを意味します。このトレンドはデザイナーがフォント自体にOpenType機能を含める傾向が高まっていることを反映していますが、今年のデータによると、より多くのウェブ開発者もCSSでこれらのOpenType機能を活用しています。

長年にわたるOpenType機能のより広範な実装と使用に加えて、カラーフォントや可変フォントなどの新しいOpenType機能の採用も大幅に増加しています。カラーフォントの場合、採用はまだかなり低いレベル（インターネット全体でわずか数千のウェブサイト）ですが、毎年かなりのペースで増加しています。一方、可変フォントの使用はさらに劇的に増加しており、採用を促進している大きな要因は、ウェブユーザーの大規模な人口によって使用されるいくつかの文字体系における可変フォントの人気のようです。中国語、日本語、韓国語（CJK）フォント、特にNotoスーパーファミリーは、現在使用されている可変フォントの特に大きな割合を占めています：ウェブ上のすべての可変フォントのうち、デスクトップでは約42%、モバイルでは34%がNotoのCJKファミリーから来ています。

より広い視点では、ウェブ上でさまざまなグローバルスクリプトや言語の使用とサポートが全般的に増加しており、かつては圧倒的だったラテンフォントの存在感が減少しています。これは、歴史的にほぼ西洋文字のみに焦点を当ててきた書体カタログの中で、長い間軽視されてきた言語のための高品質な書体のデザインと開発をサポートする最近の取り組みの成果を示しています。

本章の残りの部分では、HTTP Archiveウェブクロールのデータを使用して、ウェブ上のフォントの現状を描写するために、これらのテーマとさらに詳細について探求します。本章はウェブフォントのデザインと使用に関連するさまざまなテーマに触れるセクションに分けられています。まず、ホスティング、フォーマット、フォントファイルのサイズなど、フォントがユーザーに配信される方法についての実用的な決定から始めます。次に、最も人気のあるフォントファミリー、これらのフォントをデザインした書体製作所、そして異なる文字体系へのサポートレベルを調査します。最後に、カラーフォントや可変フォントなどの新興技術と、フォントがどのように構築され、ウェブ上で使用されるかに関する技術的な選択について議論します。

しかし、本章を進める前に、いくつかの技術的な注意点を述べておきたいと思います。今年のフォントデータを分析する私たちの全体的なアプローチは、トレンドに重点を置いています。これらのトレンドを調査するために、今年のデータとHTTP Almanacの過去の版を比較しています。2023年には年鑑が出版されなかったため、多くの比較は[2022年版](../2022/fonts)のデータを参照しています。いくつかのケースでは、入手可能で関連性がある場合に2023年のデータも含めています。

本章全体を通してパーセンテージを提示する際には、それぞれの具体的なケースで_何_が実際にカウントされ、そのカウントが_どのように_正規化されてパーセンテージに変換されているかに注意を払うことが重要です。このことを念頭に置かなければ、2つのパーセンテージを比較する際に誤って「りんごとオレンジ」を比較してしまう可能性があります。私たちは3つのカウント方法を使用しています：

- **Webページ：** この方法は the [Web Almanacの方法論](./methodology)に従い、ルートページの数をカウントします。
- **フォントリクエスト：** この方法は ルートページでのフォントリクエストをカウントし、クロール全体のフォントリクエスト総数で割ります。特定のフォントがページ読み込み時にブラウザから複数回リクエストされる場合、それは同じ回数だけカウントされます。
- **フォントファイル：** この方法は 個別のフォントURLの数をカウントし、クロール全体のフォントURL総数で割ります。同じURLが複数のウェブサイトで使用されている場合、1回だけカウントされます。このカウント方法は、オンラインでアクセス可能なフォントファイルの総セットを観察することを目的としています。

## ホスティングとサービス

ウェブサイト訪問者にフォントを配信する方法は基本的に2つあります。1つは <a hreflang="en" href="https://fonts.google.com/">Google Fonts</a> のような無料サービスや <a hreflang="en" href="https://fonts.adobe.com/">Adobe Fonts</a> のような有料サービスを通じてウェブフォントを提供する方法です。もう1つは、ウェブサイト自身のドメインからフォントファイルをセルフホスティングする方法で、外部依存関係なしにファイルを完全に制御できます。

ウェブ開発者が選択するフォントホスティングの選択肢を理解するために、過去のAlmanacの手法に従い、いくつかの重複するカテゴリを見ていきます。「セルフホスティング（非排他的）」カテゴリは、ホスティングサービスも使用している場合でも、セルフホスティングフォントを使用するすべてのウェブサイトを指します。「セルフホスティング（排他的）」カテゴリは、セルフホスティングフォントのみを使用するウェブサイトをカウントします。同様に、「サービス（非排他的）」カテゴリは、セルフホスティングフォントも使用している場合でも、ホスティングサービスを使用するすべてのウェブサイトを指します。「サービス（排他的）」カテゴリのサイトはホスティングサービスのみを使用します。今年は新たに「セルフホスティングとサービスの併用」というカテゴリを追加しました。これはセルフホスティングフォントとサービスの両方を使用するサイトを指します（例：非排他的セルフホスティングサイトから排他的セルフホスティングサイトを引いたもの）。

{{ figure_markup(
  image="hosting-type.png",
  caption="ホスティングタイプ。",
  description="2024年にホストにリクエストを送信するページの割合を示す棒グラフ。非排他的セルフホスティングはモバイルとデスクトップの両方で70%。排他的セルフホスティングはデスクトップで28%、モバイルで34%。サービスとセルフホスティングの併用はデスクトップで43%、モバイルで36%。非排他的サービス利用はデスクトップで60%、モバイルで51%。サービスのみを使用するページはデスクトップで19%、モバイルで16%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=835212931&format=interactive",
  sheets_gid="1014103088",
  sql_file="performance/fonts_services.sql"
  )
}}

今年は排他的セルフホスティングが大幅に増加しました（デスクトップ：2022年の22%から28%へ、モバイル：2022年の28%から34%へ）。同時に、サービスの非排他的使用の減少も見られます（デスクトップ：2022年の63%から60%へ、モバイル：2022年の55%から51%へ）。これらの相互関連するトレンドは2022年に初めて確認されました。この時期、パフォーマンスとプライバシーの向上のために多くのユーザーがフォントのセルフホスティングを始めました（[キャッシュ分割](https://developer.chrome.com/blog/http-cache-partitioning)の導入以降、共有フォントCDNの使用は優位性がなくなりました）。これは _かつてウェブサービスと自身のセルフホスティングフォントの両方を使用していたかなりの数のウェブサイトが、現在はセルフホスティングフォントのみを使用するようになった_ ことを示唆しています。

一方で、ウェブフォントサービスのみを排他的に使用しているウェブサイトの数は、過去2年間でほぼ一定を保ち、デスクトップの約19%、モバイルの約16%のウェブサイトを占めています。今では、ウェブサイトの70%が単独またはサービスとの組み合わせで何らかの形のセルフホスティングフォントを使用しています。これは、セルフホスティングフォントを使用するウェブサイトの全体的なシェアが2022年以降約2ポイント上昇したことを意味します。

{{ figure_markup(
  image="web-font-usage-by-service.png",
  caption="サービス別ウェブフォント使用状況。",
  description="ウェブフォントサービスへのリクエストの割合を時系列で示す棒グラフ。Google Fontsの使用率は2022年の60%から2024年には57%に減少。Adobe Fontsの使用率は2022年の3.7%から2024年には4.1%に増加。Font Awesomeの使用率は2022年の4.4%から2024年には4%に減少。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1521777598&format=interactive",
  sheets_gid="1669287131",
  sql_file="performance/fonts_service.sql"
  )
}}

ウェブフォントのサービス市場は高度に集約されており、その傾向は強まっています。現在、主要なフォントサービスはGoogle Fonts、Adobe Fonts、Font Awesomeのみとなっています。Fonts.comとcloud.typographyは2年前から非常に低い使用レベルに落ちています。フォントホスティングの巨人とも言えるGoogle Fontsでさえ、2023年のクロールでは使用率が低下しましたが（フォントホスティング全体の60%から57%に減少）、現在は安定した使用レベルに回復しています。一方、AdobeとFont Awesomeによって提供されるフォントは、それぞれ今年のウェブページの約4%で見つかりました。

サービス市場の4%のシェアを持つAdobe Fontsは、今年のデータでウェブフォント市場のシェアが増加した唯一のフォントサービスです。Adobeは過去2年間で11パーセントポイント増加しました。もっとも可能性の高い説明は、Adobe FontsがCreative Cloudサブスクリプションと共に多くの高品質で人気のある商用書体をバンドルしていることです。Adobeのウェブフォント使用はページビュー単位で課金されないため、ディストリビューターやファウンドリから高額なウェブライセンスを購入する場合と比較して、高トラフィックのウェブサイトでは安価なオプションとなります。

ウェブサイトは複数のソースからフォントを取得できるため、異なるフォントホスティングオプションの人気度はゼロサムゲームではなく、最も人気のあるオプションは単一のウェブサイト上でよく組み合わせて見られます。

<figure>
  <table>
    <thead>
      <tr>
        <th>サービス</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Fonts, セルフホスティング</td>
        <td class="numeric">39%</td>
        <td class="numeric">33%</td>
      </tr>
      <tr>
        <td>セルフホスティング</td>
        <td class="numeric">28%</td>
        <td class="numeric">34%</td>
      </tr>
      <tr>
        <td>Google Fonts</td>
        <td class="numeric">13%</td>
        <td class="numeric">11%</td>
      </tr>
      <tr>
        <td>Google Fonts, Font Awesome, セルフホスティング</td>
        <td class="numeric">2%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>Google Fonts, Font Awesome</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
      {{ figure_link(
      caption="もっとも人気のあるウェブフォントホスティングの組み合わせトップ5。",
      sheets_gid="1014103088",
      sql_file="performance/fonts_services.sql",
    ) }}
  </figcaption>
</figure>

今年HTTP Archiveによってクロールされたデスクトップとモバイルウェブサイトの約39%がGoogleフォントとセルフホスティングフォントの両方を使用しているのに対し、28%はセルフホスティングフォントのみを使用し、13%はGoogleフォントのみを使用しています。これらの2つのソースは合わせて、ウェブで見られるフォントの大部分を提供しています：2024年にクロールされたウェブサイトの79%がセルフホスティングフォント、Googleウェブフォント、またはその両方を使用しています。それでも、Google Fontsとセルフホスティングを組み合わせているウェブサイトの数に明らかな減少が見られました。2022年から2023年の間に、Googleフォントとセルフホスティングフォントの組み合わせはウェブサイトの41%から38%に減少しました。この数字は今年若干回復し始め、再び上昇して39%に達しています。

全体的に見ると、トレンドは明らかです：ますます多くの人々がウェブフォントをセルフホストすることを好んでいます。これは多くの場合、優れた選択です。なぜなら、セルフホスティングはフォントのようなレンダリングに不可欠なものに対する外部依存を避けることができるからです。また、セルフホスティングフォントが適切に最適化されていれば、最高のパフォーマンスを得ることができます（これについては後で詳しく説明します）。

<aside class="note">注：このセクションで提示された数値は、2022年の章のものとは若干異なります。2022年の章では、いくつかの（比較的）人気のあるウェブフォントサービスについて、CSSファイルに埋め込まれたbase64エンコードフォントを含めようとしました。幸いなことに、CSSにbase64フォントをエンコードすることはもはやフォント提供の一般的な方法ではありません。このため、2024年の章では、別ファイルとして提供されるフォントのみをカウントするように切り替えました。今年のスプレッドシートには、2022年と2023年の再計算された数値も含まれています（このセクションの適切な箇所で言及されています）。</aside>

## ファイル形式

ウェブ上でもっとも多く見られるフォント形式は何でしょうか？WOFF2はウェブフォントにとって断然人気のある形式で、デスクトップの81%、モバイルの78%のウェブサイトで使用されています。これは2022年以降、WOFF2の使用率が3パーセントポイント増加したことを示しています。WOFF2はファイルサイズが小さく、読み込みパフォーマンスが向上するなど、他のメリットもあるため、この傾向は心強いものです。この形式の前身であるWOFFも、デスクトップの8%、モバイルの10%のウェブサイトで見られますが、これらの数字は2022年以降2パーセントポイント減少したことを示しています。

{{ figure_markup(
  image="popular-mime-types.png",
  caption="人気のウェブフォントMIMEタイプ。",
  description="MIMEタイプ別のフォントリクエストの割合を示す棒グラフ。WOFF2はデスクトップで81%、モバイルで78%ともっとも使用されています。WOFFはデスクトップで8%、モバイルで10%です。`application/octet-stream` MIMEタイプはデスクトップで5%、モバイルで6%使用されています。最後に、TrueType（TTF）はデスクトップページの3%、モバイルページの4%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=383455131&format=interactive",
  sheets_gid="627419225",
  sql_file="performance/fonts_format_file.sql"
  )
}}

全体として、WOFFとWOFF2はデスクトップとモバイルのウェブサイトを合わせた総数の約90%を占め、ウェブフォントの大部分を構成しています。TrueTypeファイルも今年のデータで見つかった非WOFFウェブフォントの小さいながらも注目に値するシェア（3%～4%）を占めています。また、ウェブサイトの5%～6%が不正確なMIMEタイプである`application/octet-stream`でフォントを提供していることも指摘する価値があります。データを見ると、フォントに対して不正確なMIMEタイプを提供している主な「セルフホスティング」ホストは、設定が正しくない2つのCDNです：<a hreflang="en" href="https://cdnjs.com/">cdnjs</a>と<a hreflang="en" href="https://www.wix.com/">Wix</a>です。

これらはウェブフォント形式のグローバルな状態に関する有用な洞察ですが、市場がGoogle Fonts、Font Awesome、Adobe Fontsなどのウェブサービスに大きく偏っているため、グローバルデータはトレンドに対してやや過度に肯定的な像を描いています。これらのサービスは提供するデータ量を減らすことに大きな関心を持っており、ウェブ上での彼らの大きな影響力のために、これら少数の主要プレーヤーが下す決断は全体像を歪める傾向があります。ウェブ開発者が下す決断を理解するには、ウェブサービスを除外し、セルフホスティングフォントのデータセットだけを見ることがより興味深いでしょう。

{{ figure_markup(
  image="popular-mime-types-self-hosted.png",
  caption="人気のウェブフォントMIMEタイプ（セルフホスティング）。",
  description="MIMEタイプ別のセルフホスティングフォントリクエストの割合を示す棒グラフ。WOFF2はデスクトップとモバイルの両方で58%ともっとも使用されています。WOFFはデスクトップで18%、モバイルで19%です。`application/octet-stream` MIMEタイプはデスクトップで13%、モバイルで12%使用されています。最後に、TrueType（TTF）はデスクトップとモバイルのページの両方で6%使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=856670415&format=interactive",
  sheets_gid="1375293781",
  sql_file="performance/fonts_format_file_by_service.sql"
  )
}}

幸いなことに、WOFF2はここでもリードしていますが、驚くべきことに、より古いWOFF形式はセルフホスティングのフォントを使用しているウェブサイトでは依然として非常に人気があります。一般的に、非圧縮フォント形式はセルフホスティングフォントのかなりの部分を占めています。まだWOFF2に移行していない開発者にとって、WOFF2に切り替えることで得られるものは多く、この切り替えは手軽に達成できる改善と見なすべきです。OTFやTTFファイルをWOFF2に変換するためのオンラインツールやコマンドラインツールは多数あります。WOFFを解凍して再度WOFF2として圧縮することも可能です（ただし、変換がフォントのライセンスに準拠していることに注意する必要があります）。

## ファイルサイズ

ウェブフォントの平均サイズは、2022年以降、デスクトップとモバイルのほとんどのウェブサイトで増加しています。この全般的な傾向は、特に50パーセンタイル、75パーセンタイル、90パーセンタイルで顕著であり、デスクトップとモバイルのウェブサイト全体で平均サイズが大幅に増加しています。これらの大きなフォントを圧縮形式で配信することは、読み込み時間を管理可能に保つための価値ある手段を提供します。

{{ figure_markup(
  image="font-sizes.png",
  caption="フォントファイルサイズ。",
  description="フォントファイルサイズを示す棒グラフ。10パーセンタイルではデスクトップで9 KB、モバイルで10 KBのフォントが使用され、25パーセンタイルではモバイルとデスクトップの両方で18 KB、50パーセンタイルではモバイルとデスクトップの両方で39 KB、75パーセンタイルでは両方で76 KB、そして最後に90パーセンタイルではデスクトップで116 KB、モバイルで112 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=566180989&format=interactive",
  sheets_gid="1423338282",
  sql_file="performance/fonts_size.sql"
  )
}}

フォント形式を個別に観察することで、WOFF2ファイルサイズと通常のTTFファイルサイズを並べて比較することにより、圧縮の相対的な影響を比較できます。フォントファイルのサイズはその形式に大きく依存します。WOFFやWOFF2のような高度に圧縮された形式は、通常のTrueTypeやOpenTypeファイル（使用すべきではないもの）のような非圧縮フォント形式よりも、平均して小さなファイルサイズになるはずです。WOFF2の使用の着実な増加は良いニュースです：平均フォントファイルサイズが増加する中、WOFF2はこれらの大きなファイルのパフォーマンスへの影響を管理するのに役立ちます。

{{ figure_markup(
  image="woff2-font-sizes.png",
  caption="WOFF2フォントファイルサイズ。",
  description="WOFF2フォントファイルサイズを示す棒グラフ。10パーセンタイルではデスクトップとモバイルで12 KBのフォントが使用され、25パーセンタイルではデスクトップとモバイルで18 KB、50パーセンタイルではデスクトップで39 KB、モバイルで37 KB、75パーセンタイルでは両方で75 KB、そして最後に90パーセンタイルではデスクトップとモバイルで95 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1516367483&format=interactive",
  sheets_gid="1704259188",
  sql_file="performance/fonts_size_by_format.sql"
  )
}}

{{ figure_markup(
  image="ttf-font-sizes.png",
  caption="TTFフォントファイルサイズ。",
  description="TrueType（TTF）フォントファイルサイズを示す棒グラフ。10パーセンタイルではデスクトップとモバイルの両方で7 KBのフォントが使用され、25パーセンタイルではデスクトップで23 KB、モバイルで24 KB、50パーセンタイルではデスクトップで53 KB、モバイルで55 KB、75パーセンタイルではデスクトップで105 KB、モバイルで109 KB、そして最後に90パーセンタイルではデスクトップで184 KB、モバイルで191 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=548670036&format=interactive",
  sheets_gid="1704259188",
  sql_file="performance/fonts_size_by_format.sql"
  )
}}

WOFF2とTTFのファイルサイズの差は、より高いパーセンタイルで最も顕著であり、これは今年ウェブで使用されている各タイプの最大のファイルを表しています。90パーセンタイルでは、今年使用されたTTFファイルはWOFF2ファイルのおよそ2倍の大きさでした。より低いパーセンタイルに向かうと、この差は収束し、最終的には逆転します。10パーセンタイルでは、各形式で見つかったフォントの最小のブラケットを表し、WOFF2ファイルはTTFファイルのほぼ2倍の大きさです。このファイルサイズの関係は、WOFF2圧縮辞書のオーバーヘッドによるものである可能性が最も高いです。フォント形式の選択がウェブサイトのパフォーマンスにこれほど劇的な影響を与える可能性があるため、2022年の呼びかけを繰り返し、開発者にWOFF2フォントの使用を強く勧めます。

セルフホスティングサイトとGoogleフォント（比較のためにGoogleを選んだのは、最もパフォーマンスに焦点を当てたサービスだからです）のWOFF2ファイルサイズの差を見ると、その差は驚くべきものです。50パーセンタイル以上では、セルフホスティングのWOFF2ファイルサイズは、Googleフォントによって提供されるものの平均して2倍になっています。

{{ figure_markup(
  image="woff2-font-sizes-google-vs-self-hosted.png",
  caption="WOFF2フォントファイルサイズ（Googleとセルフホスティングとの比較）。",
  description="GoogleフォントとセルフホスティングのWOFF2フォントファイルサイズを比較する棒グラフ。10パーセンタイルではGoogleフォントは8 KBのWOFF2フォントを提供し、セルフホスティングフォントは12 KB、25パーセンタイルではGoogleフォントで11 KB、セルフホスティングで18 KB、50パーセンタイルではGoogleフォントで16 KB、セルフホスティングで39 KB、75パーセンタイルではGoogleフォントで26 KB、セルフホスティングで75 KB、そして最後に90パーセンタイルではGoogleフォントで45 KB、セルフホスティングで95 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=58104693&format=interactive",
  sheets_gid="732629879",
  sql_file="performance/fonts_size_by_service.sql"
  )
}}

この不一致の理由については推測するしかありません。その一部は、これらの各グループによって使用されるフォントセットの違いによって説明できます。しかし、後で見るように、多くのセルフホスティングフォントはGoogleフォントからダウンロードされており、同様の圧縮率になるはずです。もう一つの説明として、多くのGoogleフォントユーザーはGoogleが提供するサブセッティングを使用している一方、セルフホスティングユーザーはフォント全体を提供している可能性があります。この違いの原因が何であれ、almanacの将来の版でこれを調査するのは興味深いでしょう。

さらに掘り下げて、フォントで使用される個々のテーブルサイズを見てみましょう。2022年に指摘されたように、全体的なファイルサイズに対する特定のOpenTypeテーブルの影響を測定するための合理的なアプローチは、そのテーブルを含むフォントの数によってその中央値サイズを掛けることです。

<figure>
  <table>
    <thead>
      <tr>
        <th>OpenTypeテーブル</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>glyf</td>
        <td class="numeric">77%</td>
        <td class="numeric">78%</td>
      </tr>
      <tr>
        <td>GPOS</td>
        <td class="numeric">6%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>CFF</td>
        <td class="numeric">5%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td>hmtx</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>post</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>name</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>cmap</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>gvar</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>fpgm</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>GSUB</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="「影響度」で測定したトップ10のOpenTypeテーブル。",
      sheets_gid="1322494859",
      sql_file="performance/fonts_size_by_table.sql",
    ) }}
  </figcaption>
</figure>

実際のグリフアウトラインを含むため、`glyf`は最も影響度の高いテーブルであり続けています。しかし、2022年と比較してテーブルの順序にいくつかの顕著な変化がありました。`GPOS`（グリフの配置を制御するGlyph Positioning）は、`CFF`（`glyf`の代替であるCompact Font Format）を追い抜きました。この傾向は、CFFフォントの使用減少が最も考えられる理由です（次のセクションで詳しく説明します）。また、`kern`テーブルがトップ10から消えたのは良いことです。これは`GPOS`テーブルのより現代的なカーニング実装に置き換えられたためです。

`post`と`name`テーブルはまだトップ10に入っていますが、これは（2022年の章で指摘されたように）フォントが適切に最適化されていないことを意味します。`post`と`name`はウェブフォントにとって不必要なデータをほとんど含んでいるため（ウェブアプリがユーザーにそのフォントメニューにウェブフォントを追加させる場合を除いて）、この最適化プロセスを支援するツールがあればいいと思います。

## アウトライン形式

最も一般的なアウトライン形式は引き続きTrueType（`glyf`）であり、デスクトップとモバイルの両方のフォントの92%を占めています。この数字は近年徐々に上昇しており、`glyf`フォーマットが最も近い競合相手である`CFF`（8%のシェアで減少傾向）に対して確固たる地位を築いていることを示唆しています。2022年と比較すると、`glyf`の使用率のわずかな増加（デスクトップで2ポイント、モバイルで1ポイント）は、`CFF`アウトラインの減少とほぼ正確に一致しています。`SVG`や`CFF2`などの他のアウトライン形式は、ウェブフォントの1%をはるかに下回る非常に小さな存在感を示しています（図には示されていません）。

{{ figure_markup(
  image="font-outline-formats.png",
  caption="アウトライン形式。",
  description="フォントアウトライン形式を比較する円グラフ：提供されるフォントの92.4%が`glyf`（TrueType）アウトライン形式を使用し、Compact Font Format（`CFF`）を使用するのはわずか約7.6%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=21563224&format=interactive",
  sheets_gid="810083627",
  sql_file="performance/fonts_size_by_table.sql"
  )
}}

フォントファイルサイズの全般的な増加と一致して、フォントアウトラインサイズにもわずかな増加が見られました。興味深いことに、この増加は`CFF`に不均衡に影響しているようです。これは、全体的な`CFF`使用率の減少と、最も使用されているCFFベースのフォントが大きめの傾向にあるCJKフォントであるという事実が組み合わさったことが原因だと考えられます。

{{ figure_markup(
  image="font-outline-glyf-cff-comparison.png",
  caption="`CFF`と`glyf`を比較するフォントアウトラインサイズ。",
  description="フォントアウトライン形式のサイズを比較する棒グラフ。25パーセンタイルでは`CFF`が16 KB、`glyf`が21 KB、50パーセンタイルでは`CFF`が33 KB、`glyf`が47 KB、75パーセンタイルでは`CFF`が61 KB、`glyf`が119 KB。最後に、90パーセンタイルでは`CFF`が193 KB、`glyf`が159 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=2147340050&format=interactive",
  sheets_gid="1322494859",
  sql_file="performance/fonts_size_by_table.sql"
  )
}}

2022年に指摘されたように、生のテーブルサイズ比較をそのまま受け取るのは良い考えではありません。ウェブフォントは常に圧縮されるべきなので、より公平な比較は圧縮されたテーブルサイズを見ることでしょう。このために私たちは2022年と同じアプローチを使用し、<a hreflang="en" href="https://www.w3.org/TR/2016/NOTE-WOFF20ER-20160315/#brotli-adobe-cff">WOFF2評価レポート</a>の中央値圧縮率を適用しました。圧縮を近似すると非常に明確な結果が得られます：大きなフォントは`CFF`よりも`glyf`（TrueType）アウトラインを使用して提供する方が良いでしょう。

{{ figure_markup(
  image="font-outline-glyf-cff-comparison-compressed.png",
  caption="`CFF`と`glyf`を比較する圧縮フォントアウトラインサイズ。",
  description="圧縮フォントアウトライン形式のサイズを比較する棒グラフ。25パーセンタイルでは`CFF`と`glyf`の両方が6 KB、50パーセンタイルでは`CFF`が17 KB、`glyf`が16 KB、75パーセンタイルでは`CFF`が37 KB、`glyf`が43 KB。最後に、90パーセンタイルでは`CFF`が133 KB、`glyf`が65 KBとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=2038548290&format=interactive",
  sheets_gid="1322494859",
  sql_file="performance/fonts_size_by_table.sql"
  )
}}

<a hreflang="en" href="https://github.com/harfbuzz/boring-expansion-spec/blob/main/glyf1-cubicOutlines.md">`glyf`に3次ベジェ曲線を追加する</a>取り組みが進行中であり、`glyf`と`CFF`のサイズの違いが異なる曲線タイプ（3次ベジェ曲線はより多くの制御点を持つ）によるものか、`CFF`形式の非効率性によるものかを見るのは興味深いでしょう。私たちの予想では両方の要因が組み合わさっていますが、時間が経てばわかるでしょう。

## リソースヒント

ページの読み込み時間を短縮するために、ウェブ開発者はブラウザに対して、ウェブフォントなどの重要なリソースを実際に必要になる前に読み込むよう指示できます。これはリソースヒントを使用して行われ、ブラウザが特定のリソースを予定より早く読み込んだりレンダリングしたりするよう誘導します。リソースヒントを活用することで、コード内でまだ明示的に参照されていない場合でも、重要なフォントをダウンロードして読み込むようブラウザに指示できるため、ページのパフォーマンスが向上します。これによりブラウザはコンテンツをより速く表示し、よりスムーズなユーザー体験を提供できます。

ウェブフォントに関連するリソースヒントには3種類あり、それぞれ影響力のレベルが異なります。`preload`ヒントはリソースヒントの中でもっとも影響力のあるタイプで、実際に必要になる前にリソース（ウェブフォントなど）を読み込むようブラウザに直接指示します。`preconnect`ヒントは、フォントの読み込みを含む将来のリクエストに備えて、サーバーとの接続を確立するようブラウザに指示し、パフォーマンスに中程度の影響を与えます。`dns-prefetch`ヒントは特定のドメインのDNS情報を事前に取得するようブラウザに指示しますが、接続やフォントの読み込みは開始しません。これはパフォーマンスへの影響が比較的小さいです。

今年のAlmanacでは、リソースヒントに関するデータ収集方法に変更を加えました。これは2022年の分析が多すぎるデータを捕捉していたことに気づいたためです。現在は2つの異なる側面を測定しています。`dns-prefetch`と`preconnect`については、既知のフォントサービス（本章全体で使用されているものと同じ）に対するリソースヒントの使用状況のみを測定しています。これにより、フォントをセルフホスティングする自身のウェブホストやCDNへの事前接続やDNSプリフェッチは除外されるため、実際の使用率はおそらくずっと高いでしょう。`preload`については、ヒントに`as`属性と値`font`がある場合を測定しています。

{{ figure_markup(
  image="font-resource-hint-usage.png",
  caption="フォントリソースヒントの使用状況。",
  description="フォント用リソースヒントの使用状況を示す棒グラフ。`preconnect`ヒントはモバイルとデスクトップの両方で18%のページで使用されています。`dns-prefetch`リソースヒントはデスクトップでは15%、モバイルでは16%のページで使用されています。`preload`リソースヒントはデスクトップとモバイルの両方で11%のページで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=769711215&format=interactive",
  sheets_gid="405563602",
  sql_file="performance/pages_link_relationship.sql"
  )
}}

今年のデータでは、`preconnect`と`dns-prefetch`はそれぞれ18%と16%でウェブフォントサービスへの接続を高速化するために使用されています。もっとも効果的なリソースヒントである`preload`は、ページのわずか11%でしか使用されていません。`preload`リソースヒントの使用は、フォントの読み込みを高速化するためにできる単一でもっとも効果的なことなので、この数字が大幅に上昇することを期待します！とはいえ、安定したフォントURLを提供しないサービスを使用している場合など、`preload`を使用できない場合もあります。そのような場合は、`preconnect`または`dns-prefetch`ヒントを使用するのがベストです。

残念ながら、フォント用リソースヒントの使用状況はここ2年間であまり変化していないため、これは十分に活用されていない（しかし非常に効果的な！）機能であり、ウェブ開発者によってより広く採用されることを望んでいます。

## フォントの表示

`@font-face` CSSディレクティブの`font-display`記述子は、開発者がフォントの取得にかかる時間に応じて、ウェブサイトがテキストをいつどのようにレンダリングするかを選択できるようにします。`font-display`記述子の値に応じて、ブラウザはウェブフォントがダウンロードされるまで待機するか、タイムアウト後にフォールバックフォントに切り替えるかを決定します。

{{ figure_markup(
  image="font-display-usage.png",
  caption="`font-display`値の使用状況。",
  description="CSSでの`font-display`値の使用状況を示す棒グラフ。`swap`値はデスクトップページの44%、モバイルページの45%で使用されています。`block`値はデスクトップとモバイルの両方で23%のページで使用されています。`auto`値はデスクトップとモバイルの両方で9%のページで使用されています。`fallback`値はデスクトップとモバイルの両方で3%のページで使用されています。最後に、`optional`値はデスクトップでは0%、モバイルでは1%のページで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1458420916&format=interactive",
  sheets_gid="455989674",
  sql_file="performance/styles_font_display.sql"
  )
}}

`font-display`での`swap`の使用は近年大幅に増加しており、2020年の11%から2022年の30%を経て、今年はデスクトップとモバイルで約45%に達しています。これは良い兆候です。なぜなら`swap`はより早期のテキストレンダリングを提供するからです。唯一のトレードオフは、ウェブフォントが読み込まれる際に潜在的なレイアウトシフトが発生する可能性があることです。これは低速接続のユーザーにとって望ましく、コンテンツをはるかに早く見ることができます。一方、高速接続のユーザーはレイアウトシフトにほとんど気づかないかもしれません（これはリソースヒントとフォントメトリクスオーバーライドを使用してさらに軽減できます）。

一方、悪いニュースとしては、今年のクロールでは`font-display`での`block`の使用増加も示されています。これは意図したフォントが利用可能になるかタイムアウト期間が満了するまで、文字通りテキストのレンダリングをブロックします。`block`には正当なユースケースがありますが、ほとんどのウェブサイトでは`swap`、`fallback`、または`optional`を使用すべきです。`block`の使用増加（デスクトップで24%、モバイルで23%）は2022年からのトレンドを継続しており、その年に`auto`を抜いて`font-display`記述子で使用される2番目に一般的な値となりました。`auto`値自体は現在ウェブサイトの9%で使用されており、`fallback`は3%で使用されています。`optional`と`normal`の値は、`font-display`でウェブサイトの1%未満で使用されていました。

`block`の使用増加が懸念されるため、さらに調査を進めることにしました。`font-display: block`を使用している上位10個の`@font-face`ルールを調べると、興味深い発見がありました：上位10個のフォントはすべてアイコンフォントです！

<figure>
  <table>
    <thead>
      <tr>
        <th>ファミリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Font Awesome</td>
        <td class="numeric">15.5%</td>
        <td class="numeric">16.1%</td>
      </tr>
      <tr>
        <td>ETmodules</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>TablePress</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>icomoon</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>vcpb-plugin-icons</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>fl-icons</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>dm-social-font</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>dm-font</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>dm-social-icons</td>
        <td class="numeric">0%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>dm-common-icons</td>
        <td class="numeric">0%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
      {{ figure_link(
      caption="`font-display: block`でもっとも一般的に使用されている上位10フォント。",
      sheets_gid="1521726011",
      sql_file="performance/styles_font_display_by_family.sql",
    ) }}
  </figcaption>
</figure>

Font Awesomeは15%という驚異的な使用率でリードしており、他のアイコンフォントが上位10位の残りを占めています。これは理にかなっています。アイコンフォントは通常、プライベート使用領域（あるいはさらに悪いことに、ASCIIを上書き）でエンコードされているため、アイコンフォントの読み込み中にフォールバックを表示しても良いユーザー体験を提供できないためです。これはアイコンを表示するためにフォントを使用する主な欠点の1つですが、`font-display: block`の使用増加を説明しています。私たちはアイコンフォントの使用に非常に懐疑的であり、ほとんどの場合、アイコンは（埋め込み）SVGファイルとして提供する方が良いと考えています。

絵文字フォントはこの問題に悩まされません。なぜなら絵文字はUnicodeでエンコードされているため、フォントの読み込みが遅延または失敗した場合でも適切にシステムフォントにフォールバックするからです。したがって、ウェブ上で絵文字フォントを使用することは安全です（もちろん`font-display: swap`を使用して）。

## ファミリーとファウンドリー

今年はどのフォントファミリーが最も人気があり、どのファウンドリー（書体製作所）が作成したのでしょうか？トップ20を見ると、最初の10エントリには2022年と比較してあまり驚きはありません。Robotoは依然としてトップであり、使用率はわずかに増加しています*。Font Awesomeの使用は比較的安定しており、Notoの使用も同様です（2022年と異なり、Notoは現在スクリプト固有の項目に分割されています）。唯一の驚きはLatoの減少で、PoppinsとMontserratに追い抜かれました。

<aside class="note">* 2022年に指摘されたように、Robotoのデスクトップとモバイルでの使用の違いは、主に`local()`の使用によるものです。これはローカルにインストールされたRobotoのバージョンを読み込みます。Androidのシステムフォントであるため、モバイルでの使用率は低くなっています。</aside>

トップ20の残りを見ると、Proxima Novaの使用率はわずかに増加し、ウェブサイトの約1%に達しています。トップ20で唯一の商用の非アイコンフォントとして、この人気レベルは非常に印象的です。2022年と同様に、アイコンフォントは2024年のウェブフォントの約18%を占めています。Interの急激な台頭も見逃せません。これも約1%に達しています。フレームワークやライブラリでの注目度から、今後数年以内にInterがトップ10に入ると予想しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ファミリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Roboto</td>
        <td class="numeric">15.2%</td>
        <td class="numeric">2.7%</td>
      </tr>
      <tr>
        <td>Font Awesome</td>
        <td class="numeric">10.4%</td>
        <td class="numeric">12.4%</td>
      </tr>
      <tr>
        <td>Noto Sans JP</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">5.7%</td>
      </tr>
      <tr>
        <td>Open Sans</td>
        <td class="numeric">5.6%</td>
        <td class="numeric">6.8%</td>
      </tr>
      <tr>
        <td>Poppins</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">5.8%</td>
      </tr>
      <tr>
        <td>Montserrat</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Lato</td>
        <td class="numeric">3.2%</td>
        <td class="numeric">3.8%</td>
      </tr>
      <tr>
        <td>Noto Sans KR</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Source Sans Pro</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Noto Serif JP</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td>Proxima Nova</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>Raleway</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td>Inter</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>icomoon</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>Oswald</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Ubuntu</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>eicons</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Barlow</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>Rubik</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>NanumGothic</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="デスクトップとモバイルのトップ20ファミリーリスト。",
      sheets_gid="536602154",
      sql_file="design/fonts_family_by_foundry.sql",
    ) }}
  </figcaption>
</figure>

ファウンドリーを見ると、最大の驚きはAdobe Fontsのファウンドリーとしての台頭です。この変化には2つの理由があります。今年は、Adobeが商用フォントとオープンソースフォントに使用している2つのベンダー識別子を統合しました。もう一つの理由は、Noto Sans CJK（中国語、日本語、韓国語）フォントがGoogle、Adobe、および他のいくつかのファウンドリーの共同作業だったことです。2022年にはこれらのフォントはGoogleのベンダー識別子で提供されていたためGoogleに帰属していましたが、現在はAdobeのベンダー識別子で提供されており、非常に人気のあるNoto CJKスーパーファミリーはAdobeに帰属しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ファウンドリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Fonts</td>
        <td class="numeric">34%</td>
        <td class="numeric">19%</td>
      </tr>
      <tr>
        <td>Adobe Fonts</td>
        <td class="numeric">14%</td>
        <td class="numeric">15%</td>
      </tr>
      <tr>
        <td>Font Awesome</td>
        <td class="numeric">14%</td>
        <td class="numeric">19%</td>
      </tr>
      <tr>
        <td>Indian Type Foundry</td>
        <td class="numeric">7%</td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>Łukasz Dziedzic</td>
        <td class="numeric">5%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>Julieta Ulanovsky</td>
        <td class="numeric">5%</td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>Mark Simonson Studio</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>Ascender Corporation</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>Paratype</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>Linotype</td>
        <td class="numeric">1%</td>
        <td class="numeric">2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="デスクトップとモバイルのトップ10ファウンドリー。",
      sheets_gid="536602154",
      sql_file="design/fonts_family_by_foundry.sql",
    ) }}
  </figcaption>
</figure>

今年は、トップ10のセルフホスティングフォントとGoogle FontsおよびAdobe Fontsのトップ10フォントも調査しました（Font Awesomeは単一のフォントのみを提供しているため除外しました）。

セルフホスティングフォントのトップ10にはほとんど驚きはありません。先に見たように、多くの人々がホスティングされたGoogle Fontsの使用からGoogle Fontsライブラリのファイルのセルフホスティングに切り替えており、これもこのリストに反映されています。Font Awesome、icomoon、eicons以外では、最も人気のあるセルフホスティングファミリーはすべてオープンソースフォントです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Font Awesome</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Open Sans</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Roboto</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Montserrat</td>
      </tr>
      <tr>
        <td>5</td>
        <td>Poppins</td>
      </tr>
      <tr>
        <td>6</td>
        <td>icomoon</td>
      </tr>
      <tr>
        <td>7</td>
        <td>Lato</td>
      </tr>
      <tr>
        <td>8</td>
        <td>eicons</td>
      </tr>
      <tr>
        <td>9</td>
        <td>Inter</td>
      </tr>
      <tr>
        <td>10</td>
        <td>Source Sans Pro</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="トップ10のセルフホスティングファミリー。",
      sheets_gid="125670327",
      sql_file="performance/fonts_family_by_service.sql",
    ) }}
  </figcaption>
</figure>

Google Fontsの最も人気のあるトップ10ファミリーとグローバルトップリストの間には密接な一致があります。Google Fontsのトップ10にはセルフホスティングリストには存在しないCJKファミリー（Noto Sans JP、Noto Sans KR、Noto Serif JP）が多く含まれていることに注目すべきです。CJK言語の使用が増加し、Googleがグローバルスクリプトの開発を積極的にサポートしていることは素晴らしいことです（これについては後の[文字体系](#文字体系)セクションで詳しく説明します）。

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Roboto</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Noto Sans JP</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Open Sans</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Poppins</td>
      </tr>
      <tr>
        <td>5</td>
        <td>Lato</td>
      </tr>
      <tr>
        <td>6</td>
        <td>Montserrat</td>
      </tr>
      <tr>
        <td>7</td>
        <td>Noto Sans KR</td>
      </tr>
      <tr>
        <td>8</td>
        <td>Noto Serif JP</td>
      </tr>
      <tr>
        <td>9</td>
        <td>Source Sans Pro</td>
      </tr>
      <tr>
        <td>10</td>
        <td>Raleway</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Google Fontsからのトップ10ファミリー。",
      sheets_gid="125670327",
      sql_file="performance/fonts_family_by_service.sql",
    ) }}
  </figcaption>
</figure>

Adobe Fontsのトップ10リストは他のトップリストとは大きく異なります。これはAdobeがファウンドリーからライセンスを受けた商用フォントが主に含まれているためです。そのため、商用書体の世界について興味深い洞察を提供しています（少なくともAdobeにフォントをライセンスしたファウンドリーについてです）。Adobe Fontsで最も人気のあるフォントはProxima Novaで、これはグローバルリストでも高い位置を占めているため驚くことではありません。注目すべきは、Adobe自身のフォントはトップリストに2つしかなく、Adobe Garamond Proが4位、Acumin Proが7位であることです。Adobeのトップ10リストの残りは、<a hreflang="en" href="https://www.marksimonson.com/fonts/view/proxima-nova">Mark Simonson Studio</a>（Proxima Nova）、<a hreflang="en" href="https://www.paratype.com/fonts/pt/futura-pt">Paratype</a>（Futura PT）、<a hreflang="en" href="https://www.hvdfonts.com/fonts/brandon-grotesque">HvD fonts</a>（Brandon Grotesque）、<a hreflang="en" href="https://www.motyfo.com/font-family/sofia-pro/">MoTyFo</a>（Sofia Pro）、<a hreflang="en" href="https://www.daltonmaag.com/font-library/aktiv-grotesk.html">Dalton Maag</a>（Aktiv Grotesk）、<a hreflang="en" href="https://europatype.com/">EuropaType</a>（Europa）、<a hreflang="en" href="https://freightcollection.com/">The Freight Collection</a>（Freight Sans）、<a hreflang="en" href="https://www.exljbris.com/museosans.html">exljbris</a>（Museo Sans）など他のファウンドリーが占めています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Proxima Nova</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Futura PT Web</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Brandon Grotesque</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Adobe Garamond Pro</td>
      </tr>
      <tr>
        <td>5</td>
        <td>Sofia Pro</td>
      </tr>
      <tr>
        <td>6</td>
        <td>Aktiv Grotesk</td>
      </tr>
      <tr>
        <td>7</td>
        <td>Acumin Pro</td>
      </tr>
      <tr>
        <td>8</td>
        <td>Europa</td>
      </tr>
      <tr>
        <td>9</td>
        <td>FreightSans Pro</td>
      </tr>
      <tr>
        <td>10</td>
        <td>Museo Sans</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Adobe Fontsからのトップ10ファミリー。",
      sheets_gid="125670327",
      sql_file="performance/fonts_family_by_service.sql",
    ) }}
  </figcaption>
</figure>

前述のように、過去2年間でさまざまなグローバルスクリプトのサポートが増加しているため、次はそれを見ていきましょう！

## 文字体系

世界には何千もの言語があり、これらの言語は少なくとも150の異なる文字セットで表現されています。これらは文字体系またはスクリプトと呼ばれています。これにより、タイプデザイナーと開発者は、それぞれ独自の特徴、特異性、技術的要求を持つ多くの異なるスクリプトのフォントを作成しサポートするという途方もない課題に直面しています。世界の多くの文字セットの中で、ラテン文字はデジタルタイプデザインの長年の中心として、やや疑わしい特権的な地位を占めています。ラテンアルファベットはデジタル文字エンコーディングの基礎であり、また最も一般的にサポートされている文字セットであるため、他のスクリプトは不運にも「非ラテン」フォントという包括的なカテゴリーに一般的にまとめられる傾向があります。この用語は非常にヨーロッパ中心主義的であり、もはや使用すべきではありません。この用語の変更はすぐには起こらないかもしれませんが、さまざまなスクリプトのサポートレベルが向上し、これらの文字セットを扱う無料で高品質なウェブフォントへのアクセスが拡大するにつれて、近年全体的なバランスが変化し始めています。

マルチスクリプトフォントのサポート増加への傾向は、今年のデータで直接確認できます。ラテン文字をサポートするフォントの全体的な割合は今年約46%となっており、2022年以降デスクトップとモバイルのウェブサイトで8%減少しています。一方で、マルチスクリプトテキストをサポートするフォントの数が対応して増加しており、基本的にあらゆる分野で何倍もの増加となっています。言い換えれば、ラテン文字を使用する英語、フランス語、スウェーデン語、ポーランド語などの言語でのフォント制作が減少しているのではなく、アラビア語、キリル文字、ハングル、デーバナーガリーなど、現在ウェブ全体でのテキストシェアが増加している他のスクリプトをサポートするフォントがより多く利用可能になっているのです。

これらの増加がどこで最も重要な影響を与えたかを理解するために、フォントのスクリプトサポートレベルを全体的な存在感によって分類すると役立ちます。キリル文字はウェブ上で2番目に一般的なスクリプトであり、増加しています。今年のクロールでは、ウェブサイトの13%でキリル文字をサポートするフォントが見つかり、2022年から約7パーセントポイント上昇しました。同時に、ギリシャ文字のサポートも約5パーセントポイント上昇し、全ウェブサイトの約8%に達しています。

{{ figure_markup(
  image="writing-systems.png",
  caption="フォントでサポートされている文字体系。",
  description="フォントでサポートされている文字体系を示す棒グラフ。キリル文字はデスクトップとモバイルの両方で13%、ギリシャ文字はデスクトップで8%、モバイルで7.5%、絵文字はデスクトップとモバイルの両方で1.6%、カタカナはデスクトップで1.2%、モバイルで0.9%、ひらがなはデスクトップで1.2%、モバイルで0.95%、ヘブライ語はデスクトップとモバイルの両方で1.1%、ハングルはデスクトップで0.9%、モバイルで0.5%、デーバナーガリーはデスクトップで0.9%、モバイルで0.8%、アラビア語はデスクトップで0.7%、モバイルで1%、タイ語はデスクトップとモバイルの両方で0.5%、漢字はデスクトップで0.4%、モバイルで0.3%です。他のスクリプトのサポート状況をより明確に示すため、デスクトップで47%、モバイルで46%のラテン文字は省略されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1521239630&format=interactive",
  sheets_gid="1749442653",
  sql_file="performance/styles_font_display.sql",
  width=600,
  height=486
  )
}}

世界で最も広く使用されているフォントに関しては、インド亜大陸、東アジア、中東の言語でも顕著な増加が見られました。北インドとネパールで約7億人が話す言語に使用されるデーバナーガリー文字のサポートは約3倍に増加しました。同様に、4億人以上のネイティブスピーカーにとって朗報となるアラビア語のサポートも3倍になりました。一方、タイ語のサポートは2,500万〜3,000万人のスピーカーに対して約3倍に増加しています。

しかし、中国語に対するウェブフォントの使用はほぼゼロのままです。これはおそらくファイルサイズの問題です：これらのフォントは単純なWOFF2ファイルとして提供するには大きすぎるのです。圧縮しても、中国語のフォントファイルは数メガバイトになり、これは非常に大きすぎます。

最近の技術開発である<a hreflang="en" href="https://www.w3.org/TR/2024/WD-IFT-20240709/">インクリメンタルフォント転送</a>（IFT）は、この問題に対する有望な解決策を提供します。中国語のような言語は通常、非常に大きな文字セットを持っていますが、すべての文書がすべての文字を使用するわけではありません。IFT仕様は、フォントファイルを必要に応じて読み込まれる文字の「チャンク」に分割することでこの問題を解決しようとしています。特定のページのコンテンツに応じて、大きなフォントの必要な部分だけをブラウザにストリーミングします。ウェブフォントを効率的に読み込むためにIFTを使用する「大きな」スクリプトが増えることを期待しています。

ウェブフォントサポートの最近の増加から最も恩恵を受けているグローバルスクリプトに関しては、最も劇的な数値の増加は小さな言語グループ（今年のクロールでフォントの1%未満で見つかりました）で登録されています。アルメニア語のサポートは約500%、チェロキー語は約400%、タミル語は約300%増加しています。1万以下のウェブサイトで見つかった文字体系は、2022年からさらに劇的な増加を示しています。チベット文字は16倍、シリア文字は9倍、サマリア文字は約30倍、バリ文字は約7倍増加しました。つまり、ヒンディー語やアラビア語のような巨大な人口を持つ文字体系だけでなく、新しい書体デザインによってサポートされるスクリプトの多様性の増加から恩恵を受けています。

では、どのフォントファミリーが異なるスクリプトで最も使用されているのでしょうか？特定のファミリーが複数の異なるスクリプトをサポートする「スーパーファミリー」への拡張により、この質問はかつてよりも複雑になっています。Roboto、Open Sans、Montserrat、Latoなどのファミリーは、最も人気のあるラテンフォントであるだけでなく、キリル文字やギリシャ文字のトップリストにも登場します。つまり、特定のスクリプトのトップリストに含まれているからといって、必ずしもそのスクリプトに _使用_ されているわけではなく、そのスクリプトを _サポート_ しているだけかもしれません。

Notoはこの点で特異です。Notoの目標は、Unicodeに標準でエンコードされているすべてのスクリプト（生きているものと絶滅したものの両方を含む）をサポートする単一のスーパーファミリーを提供することです。Notoは最も競争の激しいラテンフォントファミリーのトップ10には入りませんが、特に東アジア諸国でNotoのCJKバリアントを使用している多くの他のスクリプトでトップに近い位置にあります。全体として、Noto SansとSerifを合わせると、30以上の異なるスクリプトでトップ10に入っています。

スクリプトの「サポート」を測定するデータを収集する際にも複雑さが生じます。Unicodeで定義されている特定のスクリプトに100文字あるとしましょう。フォントがそのうち50文字を含んでいる場合、そのスクリプトをサポートしていると言えるでしょうか？必要に応じて、答えは異なるかもしれません。この章の目的では、（かなり恣意的に）「サポート」を、そのスクリプトの文字の5%以上を持つことと定義しています。これは低いしきい値です。この低いしきい値の理由は、ほとんどのスクリプトが複雑であり、特定のスクリプトの100%のカバレッジを持つフォントはほとんどないためです。この低しきい値測定は、スクリプトをサポートする意図を捉えることを目的としており、特定のスクリプトの5%をカバーしていても、タイプデザイナーがそれをサポートする意図があることを示していると感じています。言うまでもなく、このアプローチはいくつかの偽陽性を生み出すので、これらの結果は慎重に受け止める必要があります。

これらの注意点を踏まえて、アラビア語、デーバナーガリー、韓国語、日本語、中国語のトップリストを見てみましょう。これらのスクリプト間にはいくつかの重複がありますが、通常、人気のあるラテンフォントとの重複は少ないです（上記の例外を除いて）。

アラビア語のトップ10リストには、主にアラビア語スクリプト専用にデザインされたフォント（例：Cairo、Tajawal、Almarai）、または他のスクリプト向けに作成され、アラビア語サポートに拡張されたフォント（Droid Arabic、Segoe UI、Arial、DIN Next）が含まれています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Cairo</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Tajawal</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Rubik</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Almarai</td>
      </tr>
      <tr>
        <td>5</td>
        <td>Droid Arabic Kufi</td>
      </tr>
      <tr>
        <td>6</td>
        <td>Segoe UI</td>
      </tr>
      <tr>
        <td>7</td>
        <td>Material Design Icons</td>
      </tr>
      <tr>
        <td>8</td>
        <td>Arial</td>
      </tr>
      <tr>
        <td>9</td>
        <td>IRANSansWeb</td>
      </tr>
      <tr>
        <td>10</td>
        <td>DIN Next LT Arabic</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="アラビア語をサポートするトップ10ファミリー。",
      sheets_gid="1749442653",
      sql_file="design/fonts_family_by_script.sql",
    ) }}
  </figcaption>
</figure>

トップアラビア語ウェブフォントリストの中で変わっているのは、Material Design Iconsが含まれていることです。このフォントが明らかにアラビア語で人気がある理由として考えられるのは、アラビア語のUnicode範囲で使用されるコードポイントにいくつかのアイコンをマッピングしていることですが、この推測は実際のクロールデータで確認することができませんでした。いずれにせよ、アラビア語フォントのトップ10リストで最も目立つのは、表現されているスタイルの多様性であり、これはアラビア語が多くの明確に表現力豊かな書体を持つスクリプトであるため、素晴らしいニュースです。

アラビア語と同様に、デーバナーガリーファミリーのトップ10リストには、デーバナーガリースクリプト専用にデザインされたフォントと、デーバナーガリーをサポートするように拡張された既存のファミリーが混在しています。トップフォントはPoppinsで、次いでNoto Sansです。これらのフォントがデーバナーガリーに使用されているため人気があるのか、それとも単に人気があってたまたまデーバナーガリーをサポートしているか、確かではありません。しかし、Hind、Mukta、Rajdhani、Baloo 2については疑問の余地はなく、これらはデーバナーガリー専用にデザインされたフォントです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Poppins</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Noto Sans</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Hind</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Mukta</td>
      </tr>
      <tr>
        <td>5</td>
        <td>Segoe UI</td>
      </tr>
      <tr>
        <td>6</td>
        <td>Rajdhani</td>
      </tr>
      <tr>
        <td>7</td>
        <td>Teko</td>
      </tr>
      <tr>
        <td>8</td>
        <td>FiraGO</td>
      </tr>
      <tr>
        <td>9</td>
        <td>SVN-Poppins</td>
      </tr>
      <tr>
        <td>10</td>
        <td>Baloo 2</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="デーバナーガリーをサポートするトップ10ファミリー。",
      sheets_gid="1749442653",
      sql_file="design/fonts_family_by_script.sql",
    ) }}
  </figcaption>
</figure>

韓国語では、Pretendardが最も一般的に使用されるフォントとしてリストされており、様々なNotoバージョンがトップ4に入っています（様々なNotoバージョンの合計を加えると1位に入ります）。オープンソースフォントは多くの文字体系で強い存在感を示していますが、韓国は特に顕著です：彼らの最も人気のある10フォントはすべてオープンソースです！

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Pretendard</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Noto Sans KR</td>
      </tr>
      <tr>
        <td>3</td>
        <td>NotoKR</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Noto Sans CJK KR</td>
      </tr>
      <tr>
        <td>5</td>
        <td>나눔고딕</td>
      </tr>
      <tr>
        <td>6</td>
        <td>Spoqa Han Sans Neo</td>
      </tr>
      <tr>
        <td>7</td>
        <td>SpoqaHanSans</td>
      </tr>
      <tr>
        <td>8</td>
        <td>NanumGothic</td>
      </tr>
      <tr>
        <td>9</td>
        <td>나눔스퀘어</td>
      </tr>
      <tr>
        <td>10</td>
        <td>SUIT</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="韓国語をサポートするトップ10ファミリー。",
      sheets_gid="1749442653",
      sql_file="design/fonts_family_by_script.sql",
    ) }}
  </figcaption>
</figure>

日本語フォントのトップ10リストは、韓国語リストと驚くほど似ています。NotoとPretendardがトップにきています。また、日本語のトップ10リストに韓国語フォントが3つ含まれているのも興味深いです：Noto Sans KR、나눔고딕（Nanum Gothic）、나눔스퀘어（Nanum Square）。これらは韓国語フォントですが、かなりの数の日本語文字もサポートしており、私たちの測定基準ではリストに入っています。韓国語のトップ10リストと多くの重複があることを考えると、日本語リストもすべてオープンソースフォントで構成されているのは適切です。素晴らしいですね！

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Noto Sans JP</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Pretendard</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Noto Serif JP</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Noto Sans TC</td>
      </tr>
      <tr>
        <td>5</td>
        <td>Noto Sans KR</td>
      </tr>
      <tr>
        <td>6</td>
        <td>나눔고딕</td>
      </tr>
      <tr>
        <td>7</td>
        <td>Rounded Mplus 1c</td>
      </tr>
      <tr>
        <td>8</td>
        <td>Zen Kaku Gothic New</td>
      </tr>
      <tr>
        <td>9</td>
        <td>나눔스퀘어</td>
      </tr>
      <tr>
        <td>10</td>
        <td>Noto Sans CJK JP</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="日本語をサポートするトップ10ファミリー。",
      sheets_gid="1749442653",
      sql_file="design/fonts_family_by_script.sql",
    ) }}
  </figcaption>
</figure>

残念ながら、中国語フォントのトップに関するデータは信頼性がないようです。中国語リストには（繁体字）中国語フォントが1つしか含まれていません。残りのファミリーはすべて偽陽性で、おそらく日本語と韓国語フォントに漢字が含まれているためです。漢字は中国の文字体系から適応されたもので、[Unicodeでの漢字統合](https://wikipedia.org/wiki/Han_unification)により中国語の文字体系と同じコードポイントを共有しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>ファミリー</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Noto Sans JP</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Noto Sans TC</td>
      </tr>
      <tr>
        <td>3</td>
        <td>나눔스퀘어</td>
      </tr>
      <tr>
        <td>4</td>
        <td>나눔바른고딕</td>
      </tr>
      <tr>
        <td>5</td>
        <td>나눔고딕</td>
      </tr>
      <tr>
        <td>6</td>
        <td>Noto Sans KR</td>
      </tr>
      <tr>
        <td>7</td>
        <td>源ノ角ゴシック JP</td>
      </tr>
      <tr>
        <td>8</td>
        <td>카카오OTF</td>
      </tr>
      <tr>
        <td>9</td>
        <td>Noto Sans CJK JP</td>
      </tr>
      <tr>
        <td>10</td>
        <td>Noto Serif JP</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="中国語をサポートするトップ10ファミリー。",
      sheets_gid="1749442653",
      sql_file="design/fonts_family_by_script.sql",
    ) }}
  </figcaption>
</figure>

中国語（繁体字と簡体字）のフォントがほとんど使用されていないといっても過言ではありません。その理由は、中国語は非常に大きな文字セット（10万以上）を持ち、前述のように中国語フォントは特に大きいためです。この分野では、新しい<a hreflang="en" href="https://www.w3.org/TR/2024/WD-IFT-20240709/">インクリメンタルフォント転送標準</a>が間違いなく役立つでしょう。今後数年でより多くの中国語フォント（および他の多くの文字体系！）が見られることを期待しています。

## OpenType機能

OpenType機能はOpenType形式の「隠れた」宝石の1つです。一部のOpenType機能はテキストを正しくレンダリングするために必要であり（様々なスクリプトでは一般的です）、他の機能は異なるスタイルのオプションを提供します（たとえば、アンパサンドの代替バージョンなど）。ブラウザ（および他のアプリケーション）は、テキストを正しくレンダリングするために必要な場合に備えて、一部の機能をデフォルトで有効にすることがよくありますが、他の機能はオプトイン方式で動作します。どのOpenType機能をフォントに含めるかを決めるのはタイプデザイナー次第なので、すべてのフォントが同じ機能を持っているわけではありません。このセクションでは、OpenType機能の普及状況と、それらがウェブ上でどのように最もよく使用されているかを見ていきます。

{{ figure_markup(
  content="55%",
  caption="OpenType機能を含むフォント。",
  classes="big-number",
  sheets_gid="405374795",
  sql_file="development/fonts_feature.sql",
) }}

OpenType機能の普及率は近年着実に上昇し、フォントの約55%に達しています。これは2022年から約7ポイントの増加を示しています。個々の機能を見ても同様の増加が見られます。今年のデータによると、合字（`liga`）のサポートは10%から40%に、カーニング（`kern`）は13%から38%に、ローカライズされた形式（`locl`）は10%から27%に、分数（`frac`）は8%から26%に、分子（`numr`）は7%から19%に、分母（`dnom`）は7%から19%に増加しています。

{{ figure_markup(
  image="opentype-feature-support-fonts.png",
  caption="フォントでのOpenType機能のサポート。",
  description="フォントでサポートされているOpenType機能を示す棒グラフ。合字はフォントの約40%でサポートされ、カーニングはデスクトップでフォントの38%、モバイルで39%、ローカライズ機能はモバイルとデスクトップの両方でフォントの27%、分数はモバイルとデスクトップでフォントの26%、分子と分母はモバイルとデスクトップの両方でフォントの19%、最後に表形式の数字と比例数字はモバイルとデスクトップの両方でフォントの16%でサポートされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=212641271&format=interactive",
  sheets_gid="1573650259",
  sql_file="development/fonts_feature.sql"
  )
}}

OpenTypeのあまり使用されていない機能も、2022年と比較して今年はウェブで使用されるフォントファイルでの採用が増加しています。代替文字へのアクセス（`aalt`、特定の文字の複数のバージョンを提供）、序数（`ordn`、序数を提供）、文字構成（`ccmp`、特殊な文字の組み合わせを提供）は、デスクトップとモバイルのウェブサイトの両方で使用されるフォントでのサポートが約1%から3%に上昇しています。

フォントがより多くの機能をサポートするようになったのは素晴らしいことですが、実際にウェブサイトで使用されているのでしょうか？ウェブサイトでのフォントの動作を制御するためには、2つの異なるCSSプロパティが利用できます：`font-variant`（およびそれを構成する様々な詳細プロパティ）と、より低レベルの`font-feature-settings`です。`font-variant`プロパティは、スモールキャップス（`small-caps`）などの事前定義されたフォントバリアントのセットから選択するために使用されます。`font-feature-settings`プロパティは、主に`font-variant`の同等のものがない場合に使用すべきです。

{{ figure_markup(
  image="opentype-features-low-level-vs-high-level-properties.png",
  caption="`font-feature-settings`と`font-variant`の使用状況。",
  description="`font-feature-settings`と`font-variant`の使用状況を示す棒グラフ。`font-feature-settings`プロパティはデスクトップページの10.3%、モバイルページの9.7%で使用されています。比較すると、`font-variant`プロパティはデスクトップページの4.5%、モバイルページの4.3%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1344250718&format=interactive",
  sheets_gid="140686901",
  sql_file="development/styles_feature_control.sql"
  )
}}

全体的な`font-feature-settings`の使用は今年約3ポイント減少し、デスクトップで13.3%から10.3%に、モバイルウェブサイトで12.6%から9.7%になりました。一方、`font-variant`の使用はわずかに増加し、デスクトップで3.9%から4.5%に、モバイルウェブサイトで3.5%から4.3%になりました。最も可能性の高い説明は、より多くのサイトが、より良くサポートされるようになった新しい（そしてより良い！）`font-variant`プロパティを使用していることです。このトレンドが続き、最終的に`font-variant`が OpenType機能を有効または無効にする主要な方法として`font-feature-settings`を追い越すことを期待しています。

`font-feature-settings`プロパティと組み合わせて使用される機能を見ると、この点がよく理解できます。`font-feature-settings`で使用されるトップ機能はすべて`font-variant`の同等のものがあります！

{{ figure_markup(
  image="popular-font-feature-settings-values.png",
  caption="もっとも人気のある`font-feature-settings`の値。",
  description="もっとも人気のある`font-feature-settings`の値を示す棒グラフ。`kern`機能タグはデスクトップとモバイルページの2.6%で使用され、`liga`機能タグはデスクトップページの2.3%、モバイルページの2.2%で使用されています。`tnum`機能タグはデスクトップの0.8%、モバイルの0.7%のページで使用され、`palt`機能タグはデスクトップページの0.7%、モバイルページの0.6%で使用されています。`pnum`機能タグはデスクトップページの0.41%、モバイルページの0.39%で使用され、`lnum`機能タグはモバイルの0.4%、デスクトップの0.3%のページで使用されています。最後に、`calt`機能タグはデスクトップとモバイルの両方で0.2%のページで使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=133823749&format=interactive",
  sheets_gid="666056788",
  sql_file="development/styles_font_feature_settings.sql"
  )
}}

さらに悪いことに、多くの機能はすべてのブラウザでデフォルトで有効になっているため（カーニング、一般的な合字、コンテキスト代替など）、`font-feature-settings`に含める必要はありません。唯一の理由は、これらの機能を無効にすることですが、それは奇妙なことでしょう。良いニュースは、これらの機能の使用が2022年からほとんど増加していないことです。カスタムおよび非標準のOpenType機能を除けば、`font-feature-settings`を使用する必要はありません。`font-variant`プロパティだけで専門家レベルの植字を実現できます。

## 可変フォント

可変フォントはデジタルタイポグラフィーにおける表現の可能性を大幅に向上させる技術革新です。正式にはOpenType可変フォント（OTVF）と呼ばれるこの形式では、フォントの外観を微調整する一連の軸に沿って、文字形状を連続的に変化させることができます。つまり、1つの可変フォントファイルには、フォントファミリー内のすべてのインスタンスと、デザイナーがフォントに含めた特定の軸に沿ったあらゆる微調整と組み合わせが含まれています。これはどのように機能するのでしょうか？

従来のフォントファミリーでは太字や細字のウェイトを提供するのに対し、可変フォントではウェイト（`wght`）軸を使って、好みの太さに文字を正確に調整できます。同様に、幅（`wdth`）軸を調整することで、文字形状を圧縮したり拡張したりできます。また、文字サイズにはレジビリティとタイポグラフィカラーに影響する微調整（x高など）が必要なことが多いため、可変フォントではオプティカルサイズを微調整して、文字が占めるスペースと役割に最適になるようにできます。

デザイナーとエンドユーザーにより多くのタイポグラフィ表現の自由度を与えるだけでなく、同じファミリーから複数のスタイルを使用する場合、可変フォントはパフォーマンス向上にもつながります。可変フォントは内部的に各スタイルのアウトラインを個別に保存するのではなく、より効率的なデルタとオフセットのセットを使用するため、対応する「静的な」スタイルと比較して数倍小さくなることがあります。

{{ figure_markup(
  image="variable-font-usage-over-time.png",
  caption="時間経過に伴うウェブサイトでの可変フォントの使用状況。",
  description="時間経過に伴う可変フォントの使用状況を示す棒グラフ。2022年には可変フォントはデスクトップページの28%、モバイルページの29%で使用されていました。2023年には可変フォントはデスクトップページの29%、モバイルページの30%で使用されました。2024年にはこれらの数字はデスクトップページの33%、モバイルページの34%に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1980743167&format=interactive",
  sheets_gid="86484570",
  sql_file="development/fonts_variable.sql"
  )
}}

可変フォントは新しい特殊な技術のように聞こえるかもしれませんが、すでにすべての主要ブラウザでサポートされており、ウェブ全体で増加する数と割合のウェブサイトで使用されています。全体として、約33%のウェブサイトが現在可変フォントを使用しています。これは2022年以降、ウェブ全体で可変フォントが4〜5パーセントポイント増加したことを示しています。それでも、可変フォントの採用の跳躍は、可変フォントの存在がほぼ3倍になった2020年から2022年の間の方がはるかに大きかったです。今後数年間でこの採用率を追跡し続け、可変フォントの使用が成長し続けるか、あるいはプラトーに達し始めたかを確認するのは興味深いでしょう。

余談として、使用率は必ずしもウェブ開発者が通常のフォントよりも可変フォントを選択したことを意味するわけではありません。かなり大きな割合のウェブページが、使用しているサービスが通常のフォントスタイルの代わりに可変フォントを提供することを選択したために可変フォントを使用している可能性が非常に高いです。可変フォントには通常、フォントファミリーの個別のスタイルに対応するインスタンスが含まれているため、サービスはウェブ開発者がCSSスタイルを変更する必要なく可変フォントを簡単に提供できます。実際、2022年に指摘されたように、これは可変フォント使用の突然の跳躍の原因である可能性が高く、Google Fontsはフォントを可変フォント相当のものに急速に置き換えています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ファミリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Noto Sans JP</td>
        <td class="numerical">27%</td>
        <td class="numerical">23%</td>
      </tr>
      <tr>
        <td>Open Sans</td>
        <td class="numerical">16%</td>
        <td class="numerical">18%</td>
      </tr>
      <tr>
        <td>Montserrat</td>
        <td class="numerical">9%</td>
        <td class="numerical">10%</td>
      </tr>
      <tr>
        <td>Noto Sans KR</td>
        <td class="numerical">7%</td>
        <td class="numerical">4%</td>
      </tr>
      <tr>
        <td>Noto Serif JP</td>
        <td class="numerical">5%</td>
        <td class="numerical">5%</td>
      </tr>
      <tr>
        <td>Raleway</td>
        <td class="numerical">3%</td>
        <td class="numerical">4%</td>
      </tr>
      <tr>
        <td>Inter</td>
        <td class="numerical">3%</td>
        <td class="numerical">3%</td>
      </tr>
      <tr>
        <td>Noto Sans TC</td>
        <td class="numerical">2%</td>
        <td class="numerical">2%</td>
      </tr>
      <tr>
        <td>Google Sans 18pt</td>
        <td class="numerical">2%</td>
        <td class="numerical">2%</td>
      </tr>
      <tr>
        <td>Oswald</td>
        <td class="numerical">2%</td>
        <td class="numerical">2%</td>
      </tr>
    </tbody>
  </table>
    <figcaption>
    {{ figure_link(
      caption="もっとも使用されている可変フォントトップ10。",
      sheets_gid="692423415",
      sql_file="development/fonts_variable_family.sql",
    ) }}
  </figcaption>
</figure>

今年もっとも人気のある可変フォントファミリーはNoto Sans JPで、デスクトップウェブサイトの約27%、モバイルウェブサイトの23%で見つかりました。そのセリフバリエーションであるNoto Serif JPは、さらに5%のウェブサイトを占めています。同じフォントのハングルバージョンであるNoto Sans KRも大きなシェアを持ち、可変フォントを使用しているサイトの7%強で見つかりました。そしてNoto Sans TC（繁体字中国語）は約2%、Noto Serif TCは0.5%未満にとどまるとはいえ、NotoのCJK製品は可変フォントの現在の採用において印象的なフットプリントを持っています：可変フォントを使用しているすべてのサイトの約42%がNotoスーパーファミリーからのものです。

Open Sansは今年2番目に人気のある可変フォントで、可変フォントを使用するウェブサイトの16%で見つかりました。Montserratもこれらのウェブサイトの9〜10%で見つかりました。Open SansとMontserratはギリシャ文字やキリル文字を含む最も広く使用されているいくつかのスクリプトをサポートしているため、これらのフォントの多くの用途への適応性は、これらが可変フォントとしても一般的な人気度においても、なぜウェブ上で最も使用されているタイプフェイスの一部であるかを説明するのに役立つかもしれません。

{{ figure_markup(
  image="variable-font-usage-by-service.png",
  caption="時間経過に伴う可変フォント提供の人気ホスト。",
  description="時間経過に伴う可変フォント提供ホストを示す縦棒グラフ。2022年にはGoogle Fontsがすべての可変フォントの97%を提供し、2023年にはわずかに減少（97%）、2024年には92%に減少しました。2022年には可変フォントはページの3%でセルフホスティングされ、2023年には3%、2024年には8%となりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=906487759&format=interactive",
  sheets_gid="1090790567",
  sql_file="development/fonts_variable_service.sql"
  )
}}

可変フォントの提供に関しては、ユーザーの大部分はGoogleとセルフホスティングという2つの選択肢から選んでいます。他のどの可変フォントソースもこの技術を使用しているウェブサイトの1%未満しか登録していません。そしてGoogle Fontsが可変フォントの大部分を提供している（デスクトップ92%、モバイル91%）一方で、このマーケットにおける彼らのシェアは実際には近年わずかに減少しています。2022年には、Google Fontsはデスクトップとモバイルの可変フォントの97%を提供しており、今年のデスクトップとモバイルのシェアは約5〜6%減少しています。この変化は、ウェブサイトが可変フォントを配信する主要な手段としてセルフホスティングが同等に増加したことに対応しており、今年クロールされたサイトの8%を占めています。2022年に提供されたGoogle以外の可変フォントのシェアがわずか3%だったことを考えると、可変フォントをセルフホストするウェブサイトのシェアが5パーセントポイント増加したことは、Googleの可変フォント市場シェアの直接的な移行を反映しているようです。前述のように、Adobe FontsやType Networkなどの他のサービスは、今年ウェブで見つかった可変フォントの1%未満を提供していました。

カラーフォントと同様に、可変フォントにも2つの競合するアウトライン形式があります：`glyf`形式の可変拡張とCompact Font Format 2（`CFF2`）です。`glyf`形式と`CFF2`の主な技術的な違いは、ベジェ曲線のタイプ、より自動化されたヒンティング、そして（おそらく最も重要なのは）それらをバックアップしている企業です。`CFF2`はAdobeによってバックアップされ、`glyf`はOpenType仕様への他の主要な貢献者（Google、Microsoft、Apple）によってバックアップされています。

{{ figure_markup(
  content="99%",
  caption="`glyf`アウトライン形式を使用している可変フォント。",
  classes="big-number",
  sheets_gid="1116222836",
  sql_file="development/fonts_variable_format.sql",
) }}

残念ながらAdobeにとって、今年可変フォントに使用されたアウトラインの99%以上が`glyf`形式でした。この圧倒的な`glyf`アウトラインのシェアは2022年以降かなり一貫しており、この2年間でわずか0.2パーセントポイント下落しただけです。2016年の可変フォント導入以来、`CFF2`はわずか0.6%の使用率しか蓄積していません。`CFF2`の使用率は伸びておらず、他の場所に労力を費やした方が良いのではないかと考えるべきでしょう。

現時点での私たちの推奨は2022年と同じです：ブラウザとオペレーティングシステムのサポートがまだばらつきがあるため、_`CFF2`ベースの可変フォントを避ける_ べきです（そして`glyf`に完全に実用的な代替案があります）。

{{ figure_markup(
  image="variable-font-axes.png",
  caption="可変フォントでのフォント軸のサポート。",
  description="可変フォントでのフォント軸のサポートを示す縦棒グラフ。`wght`軸はデスクトップとモバイルの両方で可変フォントの99%でサポートされ、`slnt`軸はデスクトップのフォントの4.1%、モバイルの4.7%でサポートされ、`wdth`軸はデスクトップのフォントの2.8%、モバイルの2.4%でサポートされ、`opsz`軸はデスクトップのフォントの2.8%、モバイルの2.4%でサポートされ、`GRAD`軸はデスクトップのフォントの0.6%、モバイルの0.5%でサポートされ、最後に`ital`軸はデスクトップのフォントの0.5%、モバイルの0.3%でサポートされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=708080497&format=interactive",
  sheets_gid="1751101951",
  sql_file="development/fonts_variable_axis.sql"
  )
}}

タイプデザイナーが可変フォントの技術的な可能性にどのようにアプローチしているかを把握するために、今年はHTTP Almanacがウェブ上で使用されている可変フォントでサポートされている軸に関するデータを初めて収集しました。99%以上で、他のどの可変フォント軸も`wght`の普及度に近づくことはありません。一桁台のシェアでは、傾斜（`slnt`）が5%、幅（`wdth`）が2%、光学的サイズ（`opsz`）が2%、そしてグレード軸（`GRAD`）がデスクトップとモバイルウェブサイトで約0.5%と続きました。今後数年間でウェブ上の可変フォントで見つかる軸を追跡し続けるのは興味深いでしょう。なぜなら、これはこれらのフォントを使用するためのさまざまな可能性のデザインと利用可能性におけるトレンドを示すからです。

これらの可変フォントのデザインにおけるトレンドを超えて、これらの可変フォント軸は実際にウェブサイト上でどのように使用されているのでしょうか？そのためには、CSSデータに目を向けます。CSSで可変フォントを使用する方法は一般的に2つあります。低レベルの`font-variation-settings`プロパティを通じて、または可変フォントをサポートするように更新された従来からの`font-weight`、`font-stretch`、`font-style`プロパティを通じてです。

標準フォントプロパティを使用した可変フォントの使用を検出するのは難しいです。なぜなら、各クロールされたサイトごとにCSSオブジェクトモデルを再構築し、各ファミリーと関連するプロパティの使用を追跡する必要があるからです。代わりに近似として`font-variation-settings`の使用を見ていきます（したがって、これらの結果は慎重に受け止めてください）。

{{ figure_markup(
  image="font-variation-axes.png",
  caption="可変フォントを使用するページでの`font-variation-settings`軸の使用。",
  description="`font-variation-settings`軸の使用を示す縦棒グラフ。`wght`軸はデスクトップページの75%、モバイルページの78%で使用され、`opsz`軸はデスクトップページの36%、モバイルページの35%で使用され、`FILL`軸はデスクトップとモバイルの両方で30%使用され、`GRAD`軸はデスクトップの28%、モバイルの29%で使用され、`wdth`軸はモバイルとデスクトップの両方で18%使用され、`SOFT`軸はデスクトップページの9%、モバイルページの10%で使用され、`slnt`軸はデスクトップサイトの9%、モバイルサイトの8%で使用され、最後に`ital`軸はデスクトップページの3%、モバイルページの2%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1881791600&format=interactive",
  sheets_gid="1046824821",
  sql_file="development/styles_font_variable_settings_axis.sql"
  )
}}

ウェイト軸（`wght`）は依然として最も一般的に使用される可変フォント軸であり、大きな差をつけています。グリフの薄さや太さに影響するこの軸は、今年可変フォントを使用しているサイトの78%以上で見つかりました。これは2年前に比べてわずかな減少であり、その時はウェイト軸が82%のサイトで使用されていました。この減少は、可変フォントのウェイト軸の値を設定するために、より一般的な`font-weight`プロパティに切り替える人が増えていることが最も考えられる理由です。同時に、他のほとんどの「標準」軸での増加が見られます：`opsz`（光学的サイズ）、`wdth`（幅）、`slnt`（傾斜）、`ital`（イタリック体）。これらの軸にはそれぞれ標準のCSSプロパティがありますが、人々はそれらの使用方法を知らないか、古い時代遅れのアドバイスに従っているのです。今後数年間で、より多くの人々が可変フォントの使用に慣れるにつれて、これらの値の使用が減少することを期待しています。

また、いくつかの非標準軸（`FILL`、`GRAD`またはグレード、`SOFT`）の使用が増加しているのも良いことです。これらの軸を制御するためのCSSプロパティはなく、使用する唯一の方法は`font-variation-settings`プロパティを通じてです。もしそれらの人気が高まれば、CSS仕様（およびOpenType標準）の作者に対して、これらの軸が独自のCSSプロパティに値するという明確な指標となるでしょう（適用可能な場合。一部の軸は特定のタイプフェイスに高度に特化しており、標準化できません）。

今年は、より特殊な可変フォント機能の使用にも興味深いトレンドが見られます。可変フォントアニメーションは増加していますが、依然として非常に低いレベルです。2022年には、HTTP Archiveクロールによってデスクトップで163、モバイルで147のサイトだけがアニメーションを使用していることが確認されましたが、今年はその数がデスクトップで35,000、モバイルで46,000サイトに増加しました。インターネットの規模では、これはまだウェブサイトのごく一部（0.28%）ですが、より高度な可変フォント機能が徐々に採用されていることを示唆しています。

## カラーフォント

カラーフォント（別名クロマティックフォント）は、文字を複数の色やグラデーションで表示する機能を提供します。

{{ figure_markup(
  image="nabla-color.png",
  caption='<a hreflang="en" href="https://nabla.typearture.com/">Nabla Color</a> グラデーションを使用したCOLR v1フォント - Arthur Reinders Folmer（<a hreflang="en" href="https://www.typearture.com/">Typearture</a>）がデザインし、[Just van Rossum](https://wikipedia.org/wiki/Just_van_Rossum)が開発。',
  description="Arthur ReindersとJust van Rossumによるフォント「Nabla Color」のサンプル。「ISOMETRIC, CHROMATIC, PROJECTED」と書かれた3Dカラーテキストの3行を表示しています。",
  width=2243,
  height=1179
  )
}}

カラーフォントを使用しているウェブサイトの数は、インターネット全体の規模ではまだかなり少ないですが、過去2年間で大幅に増加しています。2022年のクロールでは、1,000～1,400のウェブサイトでカラーフォントが見つかり、これはその年のデータで調査された全ウェブサイトの0.02%でした。今年のクロールでは、5,800～6,200のウェブサイトでカラーフォントが見つかり、0.04%に達しています。これらの数字から見ると、カラーフォントを使用しているウェブサイトの数は、全ウェブサイトのごく一部にとどまっているにもかかわらず、過去2年間で3倍になったように見えます。

{{ figure_markup(
  image="color-font-usage-over-time.png",
  caption="カラーフォントの使用状況の推移。",
  description="カラーフォントの使用状況の推移を示す縦棒グラフ。2022年では、カラーフォントの使用率はデスクトップとモバイルの両方でページの0.01%、2023年では使用率はデスクトップとモバイルのページの0.02%、2024年では使用率はデスクトップページの0.05%、モバイルページの0.04%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=2100804676&format=interactive",
  sheets_gid="1377799204",
  sql_file="development/fonts_color.sql"
  )
}}

比較的新しい技術として、カラーフォントの使用はいくつかの競合する形式に分かれています。もっとも人気のあるカラーフォント形式である `SVG`（OT-SVGとも呼ばれ、SVG画像と混同しないでください）と `COLR` はベクターアウトラインに基づいています。この2つの違いは、`COLR` がフォント自体のアウトライン形式（つまり `glyf` または `CFF`）を再利用するのに対し、`SVG` は各グリフにSVGドキュメントを埋め込むことです。`COLR` はOT-SVGにはない機能であるOpenType Variationsとの統合も提供します。そのため、`COLR` を使用してカラー可変フォントを作成することは可能ですが（カラー可変フォントの優れた例として <a hreflang="en" href="https://nabla.typearture.com/">Nabla</a> を参照）、`SVG` では不可能です。それでも、`SVG` は今年もっともよく使用された形式で、カラーフォントを持つデスクトップサイトの53%で見つかりました。`COLR` 形式には2つの異なるバージョンがあります：`v0` と `v1`（グラデーションなどのより多くの機能を持つ `COLR` の新しいバージョン）。ここからはこれらを `COLRv0` と `COLRv1` と呼びます。`COLRv0` フォントもデスクトップサイトの28%とかなりのシェアを占めていました。対照的に、`COLRv1` フォントはカラーフォントを使用しているデスクトップサイトのわずか8%で見つかりました。

{{ figure_markup(
  image="color-font-format-usage.png",
  caption="カラーフォント形式の使用状況。",
  description="カラー形式別のフォント使用状況を示す縦棒グラフ。`SVG` 形式はデスクトップのカラーフォントの53%、モバイルの55%で使用され、`COLRv0` 形式はデスクトップのカラーフォントの28%、モバイルの20%で使用され、`sbix` 形式はデスクトップの13%、モバイルの20%で使用され、`COLRv1` 形式はデスクトップのカラーフォントの8%、モバイルの6%で使用され、最後に `CBDT` 形式はデスクトップのカラーフォントの3%、モバイルページの2%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1477434065&format=interactive",
  sheets_gid="749438529",
  sql_file="development/fonts_color_format.sql"
  )
}}

2つのラスターベースのカラーフォント形式、SBIX（Sbit Binary Image eXtension、OpenTypeテーブルとして小文字化）と `CBDT` は、この技術を使用しているウェブサイトの小さいながらも注目すべきシェアを占めていました。SBIXはデスクトップの13%を占め、`CBDT` ファイルはデスクトップのカラーフォントの3%を構成していました。

今年もっとも人気のあるカラーフォントファミリーはNoto Color Emoji（デスクトップ25%、モバイル28%）とJoy Pixels SVG（デスクトップ23%、モバイル11%）でした。2つの日本語フォントも今年のデータでカラーフォントの強いシェアを記録しました：貂明朝（Ten Mincho、デスクトップ11%、モバイル13%）と貂明朝テキスト（Ten Mincho Text、デスクトップ7%、モバイル9%）。しかし、後で見るように、これらはわずかなカラーグリフしか含んでいないため、真のカラーフォントと呼ぶには疑問があります。

<figure>
<table>
    <thead>
      <tr>
        <th>ファミリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Noto Color Emoji</td>
        <td class="numeric">25%</td>
        <td class="numeric">28%</td>
      </tr>
      <tr>
        <td>JoyPixelsSVG</td>
        <td class="numeric">23%</td>
        <td class="numeric">11%</td>
      </tr>
      <tr>
        <td>貂明朝</td>
        <td class="numeric">11%</td>
        <td class="numeric">13%</td>
      </tr>
      <tr>
        <td>貂明朝テキスト</td>
        <td class="numeric">7%</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>Toss Face Font Mac</td>
        <td class="numeric">4%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>noto-glyf_colr_1</td>
        <td class="numeric">3%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>Material Icons Two Tone</td>
        <td class="numeric">3%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td>Twemoji Mozilla</td>
        <td class="numeric">1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>Aref Ruqaa Ink</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>Cairo Play</td>
        <td class="numeric">1%</td>
        <td class="numeric">2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
    caption="もっとも使用されているカラーフォントトップ10。",
    sheets_gid="2059416190",
    sql_file="development/fonts_color_family.sql",
  ) }}
  </figcaption>
</figure>

もっとも使用されているカラーフォントであるNoto Color Emojiに特別な注目を集めたいと思います。これは複数のカラー形式で提供されるという点でやや独特であり、もっとも人気のあるカラーフォントのリストでいくつかの場所を占めています。Noto Color Emojiには `COLR`、`CBDT`（ラスター）、`SVG` バージョンがあります。もっとも人気があるのは `COLR` バージョンで、次に `CBDT`、最後に `SVG` となっています。

カラーフォントを持つウェブサイトの数が比較的少ないため、過去2年間の使用傾向はもっとも人気のある形式にいくつかの大きな変化をもたらしました。`SVG` の使用は2022年の82%から2024年の53%へと大幅に減少しました。`COLRv0` と `COLRv1` の両方は2023年と2024年に使用の着実な増加が見られました。`COLRv0` と `COLRv1` 形式の組み合わせた使用は、2023年のカラーフォント使用総数の26%、2024年には36%でした。これは大きな増加であり、`SVG` の人気が低下するにつれて継続すると予想されます。

{{ figure_markup(
  image="color-font-format-usage-over-time.png",
  caption="カラーフォント形式の使用状況の推移。",
  description="カラーフォント形式の使用状況の推移を示す縦棒グラフ。`SVG` の使用率は2022年に82%、2023年に73%、2024年に53%でした。`COLRv0` の使用率は2022年に18%、2023年に21%、2024年に28%でした。`sbix` の使用率は2022年と2023年に1%、2024年に13%でした。`COLRv1` の使用率は2022年に0%、2023年に5%、2024年に8%でした。`CBDT` の使用率は2022年に3%、2023年に4%、2024年に3%でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=2116900403&format=interactive",
  sheets_gid="749438529",
  sql_file="development/fonts_color_format.sql"
  )
}}

今年のカラーフォントデータでもっとも予想外の変化は、SBIX形式の突然の上昇です。SBIXはAppleによって導入され、フォントファイル内のビットマップ画像の保存をサポートするためのものです。しかし、SBIX形式には効率性に関していくつかの制限があります：バイナリオーバーヘッドと圧縮の欠如です。今年のSBIX使用率の上昇は、ほぼ完全に <a hreflang="en" href="https://toss.im/tossface">Toss Face Font</a> の人気によるものです。これは数千の絵文字と非常に大きなファイルサイズを持つ韓国のフォントです。非圧縮で12.7 MB、圧縮（WOFF2）で11.7 MBのこのフォントは、確実に `COLR` 形式で配信する方が良いでしょう。実際、Toss Face Fontのホームページでは簡略化された `COLRv0` フォントを使用していますが、残念ながら一般に公開されているようには見えません。`COLRv0` バージョンは非圧縮で6 MB、圧縮（WOFF2）で1.1 MBです。SBIXバージョンと同じ忠実度で `COLRv1` バージョンを作成するのは難しいかもしれませんが、`COLRv0` バージョンはファイルサイズ削減の点でベクター形式への変換の利点を示しています。`COLRv0` バージョンがすぐに一般に公開され、このSBIX使用率の突然の上昇が一時的なものであることを願っています。

絵文字はカラーフォントの初期開発とサポートの大きな原動力となりましたが、HTTP Almanacの前回の版では、カラーフォントが使用されているウェブサイトで絵文字がほとんど見つからなかったことが驚きでした（デスクトップクロールのわずか4%、モバイルの2%）。今年のデータでは、絵文字用のカラーフォントの使用に大きな上昇が見られます：デスクトップの42%、モバイルの31%の結果で、少なくともいくつかの絵文字文字を含むカラーフォントが見つかりました。これは絵文字用のカラーフォントの使用の大幅な成長を示していますが、カラーフォントを使用しているウェブサイトの総数がまだかなり少ないことも（再度）注目に値します。今年のクロールでは、ウェブ全体でデスクトップ約5,800サイト、モバイル6,200サイトでカラーフォントが見つかりました。

カラーフォントに関して収集されたデータの複雑さには注目する価値があります。私たちの分析では、単一のカラーグリフを持つフォントをカラーフォントとみなしています。これはかなり広い定義であり、主に非カラーグリフのために使用される多くのフォントも含まれています。カラーグリフの割合が少ないフォントを計算から除外すると、カラーフォント技術の使用は非常に異なって見えます。たとえば、`SVG` を使用するトップ3フォントである貂明朝（Ten Mincho）、貂明朝テキスト（Ten Mincho Text）、Source Code Proは、`SVG` 総使用量の合計41%を占めていますが、カラーグリフはほんのわずかしか持っていません。コードポイントの5%未満がカラーグリフにマッピングされている「カラー」フォントをすべて計算から除外すると、`SVG` のシェアは約5%に減少します！`COLR` 形式もカラーグリフの割合が低いフォントを持っていますが、その割合は3-4%とさらに低く、`COLRv0` のシェアは25.1%、`COLRv1` は7.2%に減少します。これにより、`COLR` が断然もっとも人気のある形式になるでしょう！

{{ figure_markup(
  image="color-font-formats.png",
  caption="わずかなカラーグリフしか持たないフォントを除外した後のもっとも人気のあるカラー形式。",
  description="カラーグリフが5%以上のフォントのカラー形式別のフォント使用状況を示す縦棒グラフ。`COLRv0` 形式は25%、`sbix` 形式は12%、`COLRv1` 形式は7%、`SVG` 形式は5%、`CBDT` 形式は3%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=892501065&format=interactive",
  sheets_gid="463077022",
  sql_file="development/fonts_color_format_by_family.sql"
  )
}}

今後のAlmanacの版ではカラーフォントの分析をさらに洗練させる予定ですが、`COLR` の使用は成長を続け、すぐに（すでにそうでなければ）主要なカラーフォント形式になると予想しています。

<aside class="note">注意深い読者は、2022年のフォントの章と2024年のフォント章の間でカラーフォントの使用率に若干の違いがあることに気づいたかもしれません。カラーフォントデータをよく調べたところ、フォントにカラーグリフが含まれていなくても、一部の人気のあるフォントツールは空の `SVG` テーブルを含んでいることに気づきました。これが誤って `SVG` の人気を膨らませていました。私たちは2024年にこれを修正し、比較のために2022年と2023年のデータも含めています。</aside>

## フォント平滑化

[非標準のCSSフォント平滑化プロパティ](https://developer.mozilla.org/docs/Web/CSS/font-smooth)は、開発者にフォントのレンダリング方法を選択できるようにすると主張しています。これらは非標準のプロパティであるため、ダッシュとベンダープレフィックスが付いています：`-webkit-font-smoothing`と`-moz-osx-font-smoothing`です。理論的には、これらはウェブ開発者がAppleのMacOSでのみ、グレースケールとサブピクセルアンチエイリアシングを切り替えることを可能にします。興味深いのは、2018年にAppleはMojaveのリリースで[MacOSからサブピクセルアンチエイリアシングを削除](https://wikipedia.org/wiki/MacOS_Mojave#Removed_features)したことです。さらに興味深いことに、すべてのウェブサイトの約70～77%がこのプロパティを`antialiased`または`grayscale`に設定しています。

{{ figure_markup(
  image="font-smoothing-usage.png",
  caption="フォント平滑化プロパティの使用状況。",
  description="フォント平滑化プロパティとその値を示す棒グラフ。`-webkit-font-smoothing: antialiased`プロパティはデスクトップとモバイルページの77%で使用され、`-moz-osx-font-smoothing: grayscale`プロパティはデスクトップとモバイルページの69%で使用されています。`-webkit-font-smoothing; auto`プロパティはデスクトップとモバイルページの13%で使用され、`-webkit-font-smoothing: subpixel-antialiased`プロパティはデスクトップとモバイルページの12%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=70663476&format=interactive",
  sheets_gid="1289816564",
  sql_file="development/styles_smoothing.sql"
  )
}}

では、ここで何が起きているのでしょうか？MacOSがプロパティの値に関係なくグレースケールアンチエイリアシングを使用するならば、なぜみんながこのプロパティを設定しているのでしょうか？これはCSSライブラリやフレームワークの古いバージョンによって設定された古い残骸なのか、それとも実際に _何か_ をしているのでしょうか？

明確にしておくと：このプロパティは他のオペレーティングシステムでは何もせず、MacOSのアンチエイリアシング設定も変更しません。しかし、フォントが描画されたよりも少し太く見えるようにするMacOS特有のステムダークニングを無効にします。Appleはこれを実装して、ステム（文字の垂直部分）を少し太くすることで、小さいテキストの可読性を向上させました。`-webkit-font-smoothing: antialiased`（およびその`-moz`相当）を設定すると、このステムダークニングが無効になり、フォントが特に暗い背景上でやや軽く見えるようになります。

私たちの予想では、多くのデザイナーと開発者がこのMacOS特有の動作を好まず、これらのプロパティを使用して無効にしているのでしょう。最良の解決策が何であるかは明確ではありません。これは明らかにMacOSのみの問題です（これは一般的にCSSでの標準化から除外されるでしょう）。`font-smoothing`プロパティを標準化することも意味がありません。ステムダークニングはアンチエイリアシングとは間接的にしか関係がなく、さらにブラウザやオペレーティングシステムは一般的にアンチエイリアシング方法の切り替えを許可していません。しかし、クロールデータでのこのフォント平滑化選択の人気度から判断すると、これは確かにウェブ開発者にとって問題であり、より良い解決策が慎重な検討に値します。

## 総称フォントファミリー名

システムフォントファミリーはデザインの観点からは理想的ではありませんが、普遍的に利用可能なオプションとして、セルフホスティングやウェブフォントが何らかの理由で読み込みに失敗した場合の有用なフォールバックを提供します。また、ウェブアプリケーションに「ネイティブ」な外観と操作感を実現したい場合や、パフォーマンス予算の制約があってウェブフォントをまったく使用できない場合の良い代替手段でもあります。

{{ figure_markup(
  image="generic-family-name-usage.png",
  caption="総称`font-family`名の使用状況。",
  description="総称`font-family`名の使用状況を示す棒グラフ。`sans-serif`総称ファミリー名はデスクトップとモバイルページの89%で使用され、`monospace`総称ファミリー名はデスクトップページの65%、モバイルページの64%で使用されています。`serif`総称ファミリー名はデスクトップページの50%、モバイルページの51%で使用され、`system-ui`総称ファミリー名はデスクトップとモバイルの両方のページの7%で使用されています。`cursive`総称ファミリー名はデスクトップとモバイルの両方で3%使用され、`ui-monospace`総称ファミリー名はデスクトップページの3%、モバイルページの2%で使用され、`ui-sans-serif`総称ファミリー名はデスクトップとモバイルの両方で2%使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTHmcrit1gMzxfZNeFp9LrA4NQSMEh140fapD4CFQ89knpy6LvEKz7VafGaFGlxCAxTdpLZXaVaq8Pg/pubchart?oid=1077237634&format=interactive",
  sheets_gid="1543061572",
  sql_file="development/styles_family_system.sql"
  )
}}

では、ウェブ上でもっとも使用されている総称ファミリー名は何でしょうか？2024年にもっとも使用されていたのは、約90%の`sans-serif`、65%の`monospace`、50%の`serif`でした。これらの数値は`sans-serif`と`monospace`については2022年からほぼ一貫していますが、`serif`システムフォントは7%減少したことを示しています。`system-ui`フォントはデスクトップとモバイルのウェブサイトの約3.6%にしか表示されていませんでしたが、現在は7.2%となり、2022年に見られた数値のほぼ2倍になっています。これは、タイポグラフィがシステムに合致するアプリを構築するためにますます多くの人々がこれを使用していることを明確に示しています。

システムフォントに関しては、過去2年間で最大の増加が、全体の1%未満（図には示されていません）のいくつかの総称ファミリーで記録されました。特に絵文字システムフォントは、2022年から2024年の間に約13倍の増加を示しました。数学用システムフォントも、全体的なフットプリントは小さいものの大幅な増加を示し、2022年のクロールでは100を少し超えるウェブサイトから、今年はデスクトップとモバイルでおよそ1,300のウェブサイトに達しました。

## 結論

ウェブタイポグラフィの世界はどこに向かっているのでしょうか？今年のデータは、パフォーマンスに関していくつかの有望なトレンドを示しています。より多くの開発者が効率的な圧縮で優れた読み込み時間を提供するWOFF2形式を使用し、サイズが大きくなっているフォントファイルに対応しています。これは素晴らしいことですが、TrueType、OpenType、WOFF形式のセルフホスティングフォントがもっとWOFF2に変換されることを期待しています。ほとんどの場合、これは単純なプロセスであり、ファイルサイズを大幅に削減し、読み込み時間を短縮できます。パフォーマンス向上の可能性がある別の領域はリソースヒントの使用です。現在、ウェブフォントをプリロードするためにリソースヒントを使用しているページはわずか11%です。これには非常に少ない労力（ページに単純な`<link rel="preload" href="..." as="font">`を追加するだけ）で済み、ウェブフォントのパフォーマンスに大きな影響を与えるため、今後数年でこの数字が大幅に上昇することを期待しています。

今年のウェブフォントデータからはいくつかの重要な洞察も得られます。2022年のデータで見られたセルフホスティング率の上昇とウェブフォントサービスの使用減少は、現在ほぼ安定しています。将来的には、これらの率が引き続き横ばいになるのか、あるいは再びどちらかの方向に変化し始めるのかを観察することが興味深いでしょう。将来のホスティング決定に影響を与える主要な要因の1つは、ウェブフォントサービスの使用に関するプライバシー規制です。他の要因としては、セルフホスティングフォントとサービスの間のパフォーマンスと利便性のトレードオフが考えられます。

また、カラーフォントや可変フォントなどの新技術の使用は今後数年間で引き続き増加すると予想しています。カラーフォントについては、全体的な汎用性、可変フォントとの統合、CSSでのパレットサポートにより、`COLR`形式が明確な勝者です。可変フォントについては、より多くの軸のためのデザインとこれらを実践で実装する傾向は、より多くのデザイナーと開発者がこれらの技術的な可能性を活用するにつれて、引き続き広がっていくと思われます。可変フォントは主にCJKフォントを通じて初期の印象的な牽引力を得たように見えますが、今後数年間で可変フォントが他の文字体系にも広がっていくことを期待しています。さらに、新しいマルチスクリプトフォントの継続的な開発は、グローバルウェブデザインのタイポグラフィの多様性を引き続き増加させる可能性が高いです。

（ウェブ）フォントの未来はどうなるでしょうか？`glyf`アウトラインへの3次ベジェ曲線の追加やフォントの65k文字制限の打破など、多くの段階的な技術的進歩が期待されます。これらやフォントに対する他の変更は、いわゆる<a hreflang="en" href="https://github.com/harfbuzz/boring-expansion-spec">「Boring Expansion」仕様</a>で概説されています。その目的は、主に後方互換性を維持しながら（したがって「boring（退屈な）」という部分）、OpenTypeフォント標準にさまざまな機能のサポートを追加することです。最近開発された<a hreflang="en" href="https://w3c.github.io/IFT/Overview.html">インクリメンタルフォント転送（IFT）</a>も、特に大きな文字セットを持つフォントにとってウェブフォントのパフォーマンスを大幅に向上させることを約束しています。これは、ユーザーが特定のウェブサイトで使用されるフォントファイルの一部のみをダウンロードすればよいためです。

全体として、2024年のウェブフォントの状態を観察すると、さまざまな文字体系へのサポートがますます増加し、可変フォントとカラーフォント技術の採用が増えていることに興奮しています。ウェブフォントのパフォーマンスに関してはまだ多くの簡単に達成できる改善点がありますが、開発者がWOFF2、リソースヒント、`font-display`などのテクノロジーを採用してサイトのパフォーマンスを向上させていることは明らかです。これらのトレンドが2025年も続くことを期待しています！
