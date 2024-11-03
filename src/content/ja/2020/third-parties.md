---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: サードパーティ
description: 2020年Web Almanacのサードパーティの章では、サードパーティがどのように使用されているか、何のために使用されているか、パフォーマンスへの影響、プライバシーへの影響などのデータを網羅しています。
authors: [simonhearne]
reviewers: [jzyang, exterkamp]
analysts: [max-ostapenko, paulcalvano]
editors: [tunetheweb]
translators: [ksakae1216]
simonhearne_bio: Simonはウェブパフォーマンスアーキテクトです。彼は、より速く、よりアクセスしやすいウェブを提供することに情熱を注いでいます。<a href="https://x.com/simonhearne">@SimonHearne</a>でツイートしたり、<a hreflang="en" href="https://simonhearne.com">simonhearne.com</a>でブログを書いています。
discuss: 2042
results: https://docs.google.com/spreadsheets/d/1uW4SMkC45b4EbC4JV1xKAUhwGN2K8j0qFy_jSIYnHhI/
featured_quote: サードパーティコンテンツはかつてないほど普及しており、94%のページに少なくとも1つのサードパーティリソースがあり、ページの中央値では24個のサードパーティリソースがあります。この章では、サードパーティコンテンツの普及率、ページの重さとブラウザのCPUへの影響をレビューした後、サードパーティコンテンツがページパフォーマンスに与える影響を軽減する方法を提案します。
featured_stat_1: 94.1%
featured_stat_label_1: サードパーティのコンテンツがあるページ
featured_stat_2: 21.5%
featured_stat_label_2: JavaScriptで配信されるサードパーティコンテンツ
featured_stat_3: 24
featured_stat_label_3: ページの中央値でのサードパーティからのリクエスト
---

## 序章

サードパーティのコンテンツは、今日ではほとんどのウェブサイトの重要なコンポーネントとなっています。アナリティクス、ライブ チャット、広告、動画共有など、あらゆるものに影響を与えています。サードパーティのコンテンツは、サイト所有者の負担を軽減し、コアコンピタンスに集中できるようにすることで価値を提供します。

多くの人は、サードパーティのコンテンツはJavaScriptベースのものだと考えていますが、データによると、これはリクエストの22%にすぎません。サードパーティのコンテンツは、画像(37%)から音声(0.1%)まで、あらゆる形で提供されています。

この章では、サードパーティコンテンツの普及率と2019年以降の変化をレビューします。また、サードパーティコンテンツがページの重み（全体的なパフォーマンスへの影響を表す良いプロキシ）に与える影響、ページのライフサイクルの早い段階でロードされるスクリプト、サードパーティコンテンツがブラウザのCPU時間に与える影響、サードパーティがパフォーマンスデータをどのように公開しているかについてもレビューします。

## 定義

データに飛び込む前に、この章で使用する用語を定義する必要があります。

### "サードパーティ"

サードパーティリソースとは、主なサイトユーザーの関係の外にある存在のことです。これは、サイト所有者の管理下にはないが、サイト所有者の承認を得て存在するサイトの側面を含みます。例えば、Google Analyticsスクリプトは一般的なサードパーティリソースです。

私たちは、サードパーティのリソースをこれらとみなしています。

* _共有_ および _パブリック_ オリジンでホストされています
* 様々なサイトで広く利用されている
* 個人のサイトオーナーの影響を受けない

これらの目標を可能な限り正確に一致させるために、この章ではサードパーティリソースの正式な定義を以下のようにしています：HTTP Archiveデータセット内の少なくとも50のユニークなページにリソースを見つけることができるドメインに由来するリソース。

これらの定義を使用して、ファーストパーティドメインから提供されたサードパーティコンテンツはファーストパーティコンテンツとしてカウントされることに注意してください。例えば、セルフホスティングのGoogle Fontsやbootstrap.cssは _ファーストパーティコンテンツ_ としてカウントされます。

同様に、サードパーティのドメインから提供されるファーストパーティのコンテンツもサードパーティのコンテンツとしてカウントされます。関連する例。サードパーティのドメインでCDNを介して提供されるファーストパーティの画像は、 _サードパーティのコンテンツ_ とみなされます。

### プロバイダカテゴリ

この章では、サードパーティプロバイダーをさまざまなカテゴリに分けて説明します。それぞれのカテゴリには、簡単な説明が含まれています。ドメインとカテゴリのマッピングは、<a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">サードパーティのウェブリポジトリ</a>にあります。

* 広告 - 広告の表示と測定
* アナリティクス - サイト訪問者の行動を追跡
* CDN - 公共の共有ユーティリティやユーザーのプライベートコンテンツをホストするプロバイダー
* コンテンツ - パブリッシャーを促進し、シンジケートされたコンテンツをホストするプロバイダー
* カスタマーサクセス - サポートと顧客関係管理機能
* ホスティング - ユーザーの任意のコンテンツをホストするプロバイダー
* マーケティング - 営業、リードジェネレーション、メールマーケティング機能
* ソーシャル - ソーシャルネットワークとその連携
* タグマネージャー - 他のサードパーティの包含を管理することが唯一の役割であるプロバイダー
* ユーティリティー - サイトオーナーの開発目的を支援するコード
* ビデオ - ユーザーの任意のビデオコンテンツをホストするプロバイダー
* その他 - 未分類または不適合な活動

_CDNに関する注意事項。ここでのCDNカテゴリには、パブリックCDNドメイン（例：bootstrapcdn.com、cdnjs.cloudflare.comなど）上でリソースを提供するプロバイダが含まれており、単にCDN上で提供されるリソースは含まれていません。_

### 警告事項

* ここで提示されているデータはすべて、非インタラクティブなコールドロードに基づいています。これらの値は、ユーザーとのインタラクションの後では、かなり異なって見えるようになる可能性があります。
* このページは、Cookieが設定されていない米国のサーバーでテストされているため、オプトイン後に要求された第三者は含まれていません。これは特に、[一般データ保護規則](https://ja.wikipedia.org/wiki/EU%E4%B8%80%E8%88%AC%E3%83%87%E3%83%BC%E3%82%BF%E4%BF%9D%E8%AD%B7%E8%A6%8F%E5%89%87)やその他の類似の法律の適用範囲内にある国でホストされ、主に提供されているページに影響を与えます。
* テスト対象はホームページのみです。それ以外のページは、サードパーティの要件が異なる場合があります。
* リクエスト量別のサードパーティドメインの約84%が特定され、分類されています。残りの16%は「その他」のカテゴリーに分類されています。

[方法論](./methodology)についてはこちらをご覧ください。

## 普及率

この分析の良い出発点は、サードパーティコンテンツが今日のほとんどのウェブサイトの重要な構成要素であるという声明を確認することです。サードパーティコンテンツを利用しているウェブサイトはどれくらいあるのでしょうか？

{{ figure_markup(
  image="pages-with-thirdparties.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1149547895&format=interactive",
  caption="サードパーティのコンテンツがあるページ",
  description="サードパーティコンテンツの普及は2019年から微増しています。2019年にはモバイルページの93.6%がサードパーティコンテンツを持っていたが、2020年には94.1%になった。2019年にはデスクトップページの93.6%がサードパーティコンテンツを持っていたが、2020年には93.9%となった。",
  width=600,
  height=371,
  sheets_gid="1477664642",
  sql_file="percent_of_websites_with_third_party.sql"
  )
}}

これらの普及率の数字は、[2019年の結果](../2019/third-parties): デスクトップクロールのページの93.87%が少なくとも1つのサードパーティのリクエストを持っていたが、モバイルクロールのページの94.10%とわずかに高くなっていた。サードパーティのコンテンツがないページの数が少ないことを簡単に調べてみると多くはアダルトサイトであり、いくつかは政府のドメインであり、いくつかはコンテンツが少ない基本的なランディング/ホールディングページであることがわかりました。大多数のページには、少なくとも1つのサードパーティ製コンテンツが含まれていることがわかります。

下のグラフは、サードパーティ数別のページの分布を示しています。10％台のページでは2件のサードパーティからのリクエストがあるのに対し、中央値のページでは24件となっています。10%以上のページでは、100件以上のサードパーティからのリクエストがあります。

{{ figure_markup(
  image="distribution-of-request-count.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1394563639&format=interactive",
  caption="サードパーティリクエストの配信。",
  description="サードパーティからのリクエストによるページのパーセンタイル図。モバイルサイトの中央値では、サードパーティからのリクエストは24件（デスクトップでは23件）で、10パーセンタイルでは両方とも2件だったのが、90パーセンタイルではモバイルは104件、デスクトップは106件と指数関数的に増加しています。",
  width=600,
  height=371,
  sheets_gid="181718921",
  sql_file="distribution_of_third_parties_by_number_of_websites.sql"
  )
}}

### コンテンツタイプ

サードパーティのリクエストをコンテンツタイプ別に分解できます。これは、サードパーティドメインから配信されたリソースの[content-type](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type)が報告されているものです。

{{ figure_markup(
  image="thirdparty-by-content-types.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=258155228&format=interactive",
  caption="タイプ別サードパーティコンテンツ",
  description="サードパーティコンテンツの大部分（60％）を占めるのは画像とJavaScriptです。サードパーティコンテンツの37.1%が画像、21.9%がJavaScript、16.1%が不明またはその他、15.4%がHTMLです。",
  width=600,
  height=371,
  sheets_gid="53929561",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

その結果、サードパーティコンテンツの主な貢献者は画像（38%）とJavaScript（22%）で、次に多いのは不明（16%）であることがわかりました。不明は、テキスト/プレーンなどの非カテゴライズグループのサブセットと、コンテンツタイプのヘッダーがないレスポンスです。

これはシフトを示しています<a href="../2019/third-parties#%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9%E3%81%AE%E7%A8%AE%E9%A1%9E">2019年と比較して</a>：相対的な画像コンテンツは33%から38%に増加している一方で、JavaScriptコンテンツは32%から22%に大幅に減少しています。この減少は、cookieとデータ保護規制への順守が増え、HTTPアーカイブのテスト実行の範囲外である明示的なユーザーのオプトインの後までサードパーティの実行を減らしたことによるものと思われます。

### サードパーティドメイン

サードパーティのコンテンツを提供しているドメインをさらに掘り下げてみると、Google Fontsが圧倒的に多いことがわかります。テストしたモバイルページの7.5%以上に存在してます。フォントがサードパーティコンテンツの3%程度しか占めていないのに対し、これらのコンテンツのほとんどはGoogle Fontsサービスによって配信されています。あなたのページでGoogle Fontsを使用している場合は、可能な限り最高のユーザーエクスペリエンスを確保するために、<a hreflang="en" href="https://csswizardry.com/2020/05/the-fastest-google-fonts/">ベストプラクティス</a>に必ず従ってください。

{{ figure_markup(
  image="top-domains-by-prevalence.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=2082639138&format=interactive",
  caption="普及率別トップドメイン。",
  description="普及率別のトップドメインを示す棒グラフ最も普及しているドメインは、フォントファウンドリ、広告、ソーシャルメディア、JavaScript CDNです。",
  width=600,
  height=371,
  sheets_gid="583962013",
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

次の4つの最も一般的なドメインはすべて広告プロバイダです。それらはページから直接要求されるのではなく、別の広告ネットワークによって開始されたリダイレクトの複雑なチェーンを経由している可能性があります。

6番目に多いドメインは`digicert.com`です。`digicert.com`への呼び出しは、TLS証明書がOCSPのステープリングを有効にしていなかったり、中間証明書のピン留めを防ぐExtended Validation(EV)証明書を使用していたりするため、一般的にOCSPの失効チェックが行われます。この数は、すべてのページロードが事実上の初回訪問者であるため、HTTP Archiveでは誇張されています。OCSPレスポンスは一般的にキャッシュされ、実際のブラウジングでは7日間有効です。この問題についての詳細は<a hreflang="en" href="https://simonhearne.com/2020/drop-ev-certs/">このブログ記事</a> を参照してください。

2.43%でさらに下位にランクインしているのは、Googleの<a hreflang="en" href="https://developers.google.com/speed/libraries">Hosted Libraries project</a>の`ajax.googleapis.com`です。ホストされたサービスからjQueryなどのライブラリをロードするのは簡単ですが、サードパーティのドメインに接続するための追加コストがパフォーマンスにマイナスの影響を与える可能性があります。可能であれば、重要なJavaScriptとCSSはすべてルートドメインでホストするのがベストです。また、現在ではすべての主要ブラウザが<a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">ページごとにキャッシュを分割</a>しているため、共有CDNリソースを使用することによるキャッシュのメリットはありません。ハリー・ロバーツ氏は<a hreflang="en" href="https://csswizardry.com/2019/05/self-host-your-static-assets/">How to host your own static assets</a>で詳細なブログ記事を書いています。

## ページ重量の影響

サードパーティは、ブラウザによってダウンロードされたバイト数として測定されるページの重さに大きな影響を与える可能性があります。ページの重さの章で詳しく説明していますが、ここではページの重さに最も大きな影響を与えるサードパーティに焦点を当てています。
### 最も重いサードパーティ

最大のサードパーティを、ページ重量の影響度の中央値、つまり、それらのサードパーティがページにもたらすバイト数によって抽出できます。この結果は、サードパーティがどれだけ人気があるかを考慮しておらず、バイト数でのインパクトだけを考慮しているため、興味深いものです。

{{ figure_markup(
  image="page-size-by-host.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=429818290&format=interactive",
  caption="ホストによるサードパーティサイズの貢献度。",
  description="サードパーティのホストとページサイズへの影響を示したもので、 trailercentral.comの2.7MBからcontenservice.mc.reyrey.netの510KBまでの範囲です。ページサイズへの貢献度が最も大きいのはメディアプロバイダーです。",
  width=600,
  height=371,
  sheets_gid="1423970958",
  sql_file="top100_third_parties_by_median_body_size_and_time.sql"
  )
}}

ページ重量のトップの貢献者は、一般的に画像や動画のホスティングなどのメディア コンテンツプロバイダーです。例えば、Vidazooの場合、ページ重量の中央値は約2.5MBです。`inventory.vidazoo.com`ドメインはビデオホスティングを提供しているため、このサードパーティ製のページの中央値は2.5MBの_余分_なメディアコンテンツがあります。

この影響を軽減する簡単な方法は、ユーザーがページと対話するまで動画の読み込みを延期することで、動画を消費しない訪問者の影響を軽減されます。

この分析をさらに発展させて、サードパーティのカテゴリの有無による総ページサイズ（すべてのリソースについてダウンロードされたバイト数）の分布を作成できます。このチャートでは、ほとんどのサードパーティのカテゴリの存在が総ページサイズに顕著な影響を与えていないことがわかります。これはプロットの乖離として見えるでしょう。これに対する注目すべき例外は広告（黒で表示）で、これはページサイズとの関係が非常に小さいことを示しており、広告リクエストがページに大きな重みを加えていないことを示しています。これは、これらのリクエストの多くが小さなリダイレクトであり、[中央値はわずか420バイト](#大きなリダイレクト)であるためと考えられます。タグマネージャーやアナリティクスについても同様に影響が少ないことがわかります。

スペクトルのもう一方の端では、CDN、コンテンツ、ホスティングのカテゴリはすべてページの総重量と強い関係を表しています。これは、ホスティングサービスを使用しているサイトの方が、一般的にページ重量が大きいことを示しています。

{{ figure_markup(
  image="page-size-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1508418357&format=interactive",
  caption="サードパーティカテゴリ別のページサイズ分布。",
  description="サードパーティのカテゴリとページサイズの分布は、サードパーティの存在とページが大きくなる可能性との関係を示しています。CDNとホスティングは強い相関関係を示し、アナリティクスは弱い相関関係を示しています。",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

### キャッシュ可能性

サードパーティのレスポンスの中には、常にキャッシュされているものがあります。サードパーティが提供する画像や動画などのメディアやJavaScriptライブラリなどが良い候補となります。一方、トラッキングピクセルやアナリティクスビーコンは決してキャッシュすべきではありません。結果は、全体的にサードパーティのリクエストの3分の2が`cache-control`のような有効なキャッシュヘッダーで提供されていることを示しています。

{{ figure_markup(
  image="requests-cached-by-content-type.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=299325299&format=interactive",
  caption="コンテンツの種類によってキャッシュされるサードパーティのリクエスト。",
  description="コンテンツの種類別にキャッシュ可能なリクエストの割合を示したコラムチャート。フォントが96%と最も高く、XMLが18%と最も低くなっています。",
  width=600,
  height=371,
  sheets_gid="1363055589",
  sql_file="percent_of_third_party_cache.sql"
  )
}}

レスポンスタイプ別に分解すると、次のような仮定が確認できます：xmlとテキストレスポンス（一般的にトラッキングピクセル/アナリティクスビーコンによって配信される）は、キャッシュ可能である可能性が低くなります。驚くべきことに、サードパーティによって提供される画像の3分の2以下がキャッシュ可能です。さらに調べてみると、これはキャッシュ不可能なゼロサイズGIF画像レスポンスとして返されるトラッキング「ピクセル」を使用していることが原因です。

### 大きなリダイレクト

多くのサードパーティは、HTTPステータスコード3XXなどのリダイレクトレスポンスを返します。これらは、バニティドメインを使用したり、リクエストヘッダーを通してドメイン間で情報を共有したりするために発生します。これは特に広告ネットワークに当てはまります。大きなリダイレクトレスポンスは設定ミスを示すもので、有効な`Location`レスポンスヘッダーにオーバーヘッドを加えた場合、レスポンスは約340Byteになるはずです。下の表は、HTTP Archiveのすべてのサードパーティ製リダイレクトのボディサイズの分布を示しています。

{{ figure_markup(
  image="redirects-body-size.png",
  caption="サードパーティ3XXボディサイズの分布",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1145900631&format=interactive",
  description="90%が420Byte以下、1%が30KByte以上、0.1%が100KByte以上であることを示すリダイレクトボディサイズの分布。",
  width=600,
  height=371,
  sheets_gid="1056232541",
  sql_file="distribution_of_3XX_response_body_size.sql"
  )
}}

結果は、3XXのレスポンスの大部分が小さいことを示しています：90パーセンタイルは420Byte、つまり3XXのレスポンスの90%は420Byte以下です。95パーセンタイルの割合は6.5KByte、99%は36KByte、99.9%は100KByteを超えています！　 リダイレクトは無害に見えるかもしれませんが、単に別のレスポンスにつながるだけのレスポンスに対して、100KByteは不合理な量のバイト数です。

## 早期のローダー

ページの読み込みが遅いスクリプトは、総ページ読み込み時間とページの重さに影響を与えますが、ユーザー体験に影響を与えない可能性があります。しかしページの早い段階でロードされるスクリプトは、重要なファーストパーティリソースの帯域幅を共食いする可能性があり、ページのロードを妨害する可能性が高くなります。これは、パフォーマンスメトリクスやユーザー体験に悪影響を及ぼす可能性があります。

下のグラフは、デバイスの種類とサードパーティのカテゴリ別に、早くロードされるリクエストの割合を示しています。目立つ3つのカテゴリーはCDN、ホスティング、タグマネージャーで、これらはすべてドキュメントの先頭でリクエストされたJavaScriptを配信する傾向があります。広告リソースは、広告ネットワークのリクエストが一般的にページのロード後に実行される非同期スクリプトであるため、ページの早い段階でロードされる可能性が最も低くなっています。

{{ figure_markup(
  image="requests-before-dom-by-category.png",
  caption="カテゴリー別に見た初期のサードパーティのリクエスト",
  description="コラムチャートは、DOM Content Loadedの前にロードされたリクエストの割合を示しています。パブリックCDNリソースはデスクトップで50%と可能性が最も高く、広告リソースは7%と可能性が最も低いです。",
  width=600,
  height=371,
  sheets_gid="2118409936",
  sql_file="percent_of_third_party_loaded_before_DOMContentLoaded.sql"
  )
}}

## CPUの影響

ウェブ上のすべてのバイトが等しいわけではありません: 500KByteの画像は、500KByteの圧縮されたJavaScriptバンドルよりも、ブラウザで処理する方がはるかに簡単かもしれません。クライアント側のコードが1.8MByteに膨らみます！　サードパーティ製スクリプトのCPU時間への影響は、ネットワーク上の追加バイト数や時間よりもはるかに重要になります。

サードパーティのカテゴリの存在とページ上の総CPU時間を相関させることで、各サードパーティのカテゴリがCPU時間に与える影響を推定できます。

{{ figure_markup(
  image="cpu-time-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=225817673&format=interactive",
  caption="カテゴリー別のCPU時間の分布。",
  description="サードパーティのカテゴリの有無によるCPU負荷時間の分布。ほとんどのカテゴリは同じパターンに沿っており、特に低いパーセンタイルでは、より高いCPU負荷時間を示す外れ値の広告が表示されています。",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

このグラフは、各ページに存在するサードパーティのカテゴリ別の総ページCPU時間の確率密度関数を示しています。ページの中央値はパーセンタイル軸で50です。データによると、すべてのサードパーティのカテゴリは同様のパターンで、中央値のページのCPU時間は400～1,000ミリ秒となっています。ここでの外れ値は広告（黒）です：広告タグが付いているページは、ページロード時のCPU使用率が高い可能性が高くなります。広告タグがあるページのCPU負荷時間の中央値は1,500msであるのに対し、広告タグがないページのCPU負荷時間は500msです。低いパーセンタイルでの高いCPU負荷時間は、最速のサイトでも広告として分類されるサードパーティの存在によって大きな影響を受けていることを示しています。

## `timing-allow-origin`の普及率

[Resource Timing API](https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API)は、ウェブサイトのオーナーがJavaScriptを介して個々のリソースのパフォーマンスを測定することを可能にします。このデータは、サードパーティコンテンツのようなクロスオリジンのリソースに対しては、デフォルトでは非常に制限されています。例えば、ウェブサイトのオーナーは、ウィジェットのリクエストのレスポンスサイズを測定することで、訪問者がFacebookにログインしているかどうかを判断できるかもしれません。しかし、ほとんどのサードパーティコンテンツの場合、`timing-allow-origin`ヘッダーを設定することは、ホスティングウェブサイトがサードパーティコンテンツのパフォーマンスとサイズを追跡できるようにするための透明性の行為です。

{{ figure_markup(
  image="requests-with-tao.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1886505312&format=interactive",
  caption="`timing-allow-origin`ヘッダを持つリクエスト。",
  description="サードパーティの応答の35%未満がtiming-allow-originヘッダーで提供されています",
  width=600,
  height=371,
  sheets_gid="1947152286",
  sql_file="tao_by_third_party.sql"
  )
}}

HTTP Archiveの結果は、サードパーティのレスポンスの3分の1だけが、ホスティングウェブサイトに詳細なサイズとタイミングの情報を公開していることを示しています。

## 反響

サイトに任意のJavaScriptを追加すると、サイトの速度とセキュリティの両方にリスクをもたらすことがわかっています。サイトの所有者はサードパーティ製スクリプトの価値と、それらがもたらす可能性のある速度のペナルティのバランスを取るために勤勉でなければならず、また強力なセキュリティ態勢を維持するために、[サブリソースの完全性](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity)や[コンテンツセキュリティポリシー](https://developer.mozilla.org/docs/Web/HTTP/CSP)のような最新の機能を使用しなければなりません。これらおよびその他のブラウザのセキュリティ機能の詳細については、[セキュリティの章](./security)を参照してください。

## 結論

2020年のデータで驚いたのは、相対的なJavaScriptリクエストの減少です。ウェブ上のJavaScriptの実際の使用量がこのように大幅に減少したとは考えられませんが、ウェブサイトが同意管理を導入している可能性が高く、ほとんどの動的なサードパーティコンテンツはユーザーのオプトインによってのみ読み込まれるようになっています。このオプトインプロセスは、場合によっては、同意管理プラットフォーム（CMP）によって管理される可能性があります。サードパーティデータベースにはまだCMPのカテゴリがありませんが、これは2021年のWeb Almanacの分析に適しており、[プライバシーの章](./privacy#consent-management-platforms)の別の方法論でカバーされています。

広告依頼は、CPU時間に与える影響が大きくなるようです。広告スクリプトを使用した中央値のページは、なしのものと同じくらいのCPUを3倍消費します。しかし興味深いことに、広告スクリプトはページの重さの増加とは相関関係がありません。このことから、単にリクエスト数やサイズだけでなく、ブラウザ上のサードパーティ製スクリプトの総合的な影響を評価することがさらに重要になります。

サードパーティのコンテンツは多くのウェブサイトにとって重要ですが、各プロバイダーの影響を監査することは、ユーザー体験、ページの重さ、またはCPU使用率に大きな影響を与えないようにするために非常に重要です。サードパーティのウェイトに貢献している上位のプロバイダーには、セルフホスティングのオプションがあることが多いですが、共有資産を使用することによるキャッシングのメリットがないため、これは特に検討する価値があります。

* Google Fontsは、<a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">セルフホスティング</a>の資産を許可します。
* JavaScriptのCDNをセルフホストのアセットに置き換えることができます。
* 実験スクリプトは、セルフホスト型にできます。 <a hreflang="en" href="https://help.optimizely.com/Set_Up_Optimizely/Optimizely_self-hosting_for_Akamai_users">Optimizely</a>

この章では、ウェブ上のサードパーティコンテンツのメリットとコストについて説明してきました。サードパーティはほぼすべてのウェブサイトに不可欠であり、その影響はサードパーティのプロバイダーによって異なることがわかりました。新しいサードパーティをページに追加する前に、サードパーティが与える影響を考えてみてください。
