---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: フォント
description: 2020年版Web Almanacのフォントの章では、フォントがどこから読み込まれるか、フォントフォーマット、フォント読み込みのパフォーマンス、可変フォント、カラーフォントについて説明しています。
hero_alt: Hero image of Web Almanac characters on an assembly line preparing various F letters in various styles and shapes.
authors: [raphlinus, jpamental]
reviewers: [RoelN, svgeesus, davelab6, rsheeter, mandymichael]
analysts: [AbbyTsai]
editors: [tunetheweb]
translators: [ksakae1216]
jpamental_bio: デザイナー、試行錯誤する人、タイポグラファー。 レスポンシブタイポグラフィの作家は、W3Cの専門家、そしてWeb上のタイポグラフィに焦点を当てた10年以上の経験を述べました。
raphlinus_bio: Raph Levienは、カリフォルニア大学バークレー校でフォントデザインツールに関する博士号を取得するなど、35年以上にわたってフォントに携わってきました。2010年にチームを共同設立した後、フォント技術研究者として<a hreflang="en" href="https://fonts.google.com/">Google Fonts</a>に再参加しています。
discuss: 2040
results: https://docs.google.com/spreadsheets/d/1jjvZqYay5KmTle4atzFWqtbkz9ohw25KFmNtCS-7n3s/
featured_quote: Webフォントの技術は、圧縮などの技術的な改良を重ねながらかなり成熟していますが、新しい機能も続々と登場しています。可変フォントに対するブラウザのサポートはかなり充実してきており、この機能は昨年最も成長した機能です。
featured_stat_1: 70.3%
featured_stat_label_1: フォントホスティングサービスにおけるGoogle Fontsの人気度
featured_stat_2: 10.3%
featured_stat_label_2: `font-display`スワップの使い方
featured_stat_3: 11.0%
featured_stat_label_3: モバイルサイトでのバリアブルフォントの使用
---
## 序章

ほとんどのウェブサイトでは、テキストが中心となっています。タイポグラフィとは、そのテキストを視覚的で魅力的かつ効果的に表現する技術です。優れたタイポグラフィを実現するには、適切なフォントを選択する必要がありますが、デザイナーは膨大な種類のウェブフォントから選択できます。他のリソースと同様にパフォーマンスや互換性の問題がありますが、適切に使用すれば、その価値は十分にあります。この章では、ウェブフォントがどのように使用されているか、とくにどのように最適化されているかをデータに基づいて説明します。

## Webフォントはどこで使われていますか？

ウェブフォントの使用率は、時間の経過とともに着実に増加しており（2011年末にはゼロに近かった）、デスクトップ向けのウェブページでは82％、モバイルでは80％がウェブフォントを使用しています。

{{ figure_markup(
  image="fonts-web-fonts-usage.png",
  caption="Webフォントの使用状況を時系列で表示しています。",
  description="Webフォントを含むモバイルおよびデスクトップのWebページの割合を時間の関数として表した散布図。2010年頃には0％だった使用率が、現在は80％とほぼ直線的に増加しています。デスクトップとモバイルの使用率はほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=666273773&format=interactive",
  sheets_gid="655527383",
  sql_file="04_01.web_fonts_usage.sql"
  )
}}

ウェブフォントの使用率は、少数の例外を除き、世界中でほぼ一貫しています。以下のグラフはウェブページあたりのウェブフォントのキロバイト数の中央値に基づいておりこれはフォントの多さ、大きさ、またはその両方を示す指標となります。

{{ figure_markup(
  image="fonts-web-fonts-usage-by-country.png",
  caption="国別のWebフォント使用状況（デスクトップ）。",
  description='各国のWebフォントの使用量を、Webフォントデータの中央値（キロバイト）で表した世界地図です。アフリカ、トルクメニスタン、台湾、日本、その他の極東の国々など、フォント使用量の少ない「ホットスポット」が目立ちます。',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=961243485&format=interactive",
  sheets_gid="68624087",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

もっとも多くのフォントを使用している国は韓国ですが、これは韓国のインターネットの速度が常に高速で、遅延が少ないことや韓国語（ハングル）のフォントがラテン語よりも一桁以上大きいことを考えると驚くことではありません。日本や中国語圏では、ウェブフォントの使用量はかなり少なくなっています。これは、中国語や日本語のフォントが非常に大きいためです（フォントサイズの中央値は、ラテン語の中央値の1000倍以上にもなります）。つまり、日本ではWebフォントの利用率は非常に低く、中国では利用率はゼロに近い。しかし、後述する<a hreflang="en" href="https://www.w3.org/TR/2020/NOTE-PFE-evaluation-20201015/">progressive font enhancement</a>の最近の動向を見ると、数年以内に両国でウェブフォントが使えるようになるかもしれません。中国ではGoogle Fontsが確実に利用できないという報告もあり、それも採用を妨げる要因になっているかもしれません。

{{ figure_markup(
  image="fonts-web-fonts-usage-top-countries.png",
  caption="ウェブフォント使用率、上位国（デスクトップ）。",
  description="Webフォントの使用率が高い国を、Webフォントデータの中央値（KB）で表したグラフです。最上位は155KBの韓国で、トルコ（117）、イラン（115）、スロベニア（114）、ギリシャ（111）、サウジアラビア（109）と続き、最下位は108KBずつの3カ国（オーストラリア、米国、ポーランド）となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=705183861&format=interactive",
  sheets_gid="68624087",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

HTTP Archiveのディスカッションフォーラムには、<a hreflang="en" href="https://discuss.httparchive.org/t/how-does-web-font-usage-vary-by-country/1649">web font usage by country</a>という興味深いスレッドがあり、本章で使用したクエリにも影響を与えています。アジアの言語用に制作された書体の数が多いことを考えると、それらのフォントをより効率的に提供する技術が利用可能になれば、アジア地域での使用率は上昇すると考えられます。

### サービスで提供する

{{ figure_markup(
  caption="フォントホスティングサービスの中でのGoogle Fontsの人気。",
  content="70.3%",
  classes="big-number",
  sheets_gid="1925210751",
  sql_file="04_05.web_font_usage_breakdown_with_fcp.sql"
) }}

<a hreflang="en" href="https://fonts.google.com/">Google Fonts</a>が依然として圧倒的に人気のあるプラットフォームであることについて驚くことではないと思われますが、実際に使用割合は2019年から5％近く減少し、約70％となっています。<a hreflang="en" href="https://fonts.adobe.com/">Adobe Fonts</a>（旧Typekit）も同様に3％ほど下がっていますが、<a hreflang="en" href="https://getbootstrap.com/">Bootstrapの使用率</a>は約3％から6％以上に伸びています（複数のプロバイダーからの集計）。なお、Bootstrapの最大のプロバイダー（<a hreflang="en" href="https://www.bootstrapcdn.com/">BootstrapCDN</a>）は<a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>のアイコンフォントも提供しているのでBootstrap自体ではなく、アイコンフォントファイルを参照している古いバージョンがこのソースデータの上昇の背景にあるのかもしれません。

もう1つの驚きは、<a hreflang="en" href="https://www.shopify.com/">Shopify</a>で提供されるフォントの増加です。2019年には約1.1%だったのが、2020年には約4%になっており、このプラットフォームでホストされているサイトのWebフォントの使用率が大幅に上昇していることが明らかになっています。そのサービスが自社のCDNでホスティングするフォントをより多く提供しているためなのか、そのプラットフォームの利用が増えているためなのか、あるいはその両方なのかは不明です。しかしShopifyとBootstrapの使用量の増加は、Google Fonts以外では最大の増加量であり、非常に注目すべきデータです。

#### すべてのサービスが同じサービスではない

{{ figure_markup(
  image="fonts-median-fcp-of-sites-using-hosted-fonts.png",
  caption="ホストされたフォントを使用しているサイトのFCPの中央値。",
  description="さまざまなフォントホストを使用したデスクトップおよびモバイルサイトのFCPの中央値を示す棒グラフです。`static.parastorage.com`はデスクトップで1,443ミリ秒、モバイルで3,060ミリ秒ともっとも速く、`fonts.shopifycdn.com`はデスクトップで1,407ミリ秒、モバイルで4,426ミリ秒、`cdn.shopify.com`は1,492ミリ秒、4,676ミリ秒、`cdnjs.cloudflare.com`は2,150ミリ秒、5,167ミリ秒、`maxcdn. bootstrapcdn.com`は2,166と5,224、`netdna.bootstrapcdn.com`は2,239と5,304、`use.fontawesome.com`は2,350と5,572、`fonts. gstatic.com`は2,543と5,709、`cdn.jsdelivr.net`は2,603と6,434、`use.typekit.net`は2,384と7,370になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=919344016&format=interactive",
  sheets_gid="1925210751",
  sql_file="04_05.web_font_usage_breakdown_with_fcp.sql"
  )
}}

興味深いのは、さまざまなフリー/オープンソースおよび商用サービスを使用しているサイトの速度の違いです。コンテンツの初回ペイント（FCP）と最大のコンテンツフルペイント（LCP）の時間を見ると、Google Fontsを使用しているサイトはほぼ中央に位置していますが、一般的には中央値よりも少し遅くなっています。データセットの中でもっとも高速なサイトはShopifyとWix（`parastorage.com`からアセットを提供）であり、これらのサイトは少数の高度に最適化されたファイルに焦点を当てていると推測されます。一方、Googleは、（言語によって）サイズが大きく異なるWebフォントをグローバルに提供しており、その結果、中央値の時間が若干遅くなっていると思われます。

{{ figure_markup(
  image="fonts-median-lcp-of-sites-using-hosted-fonts.png",
  caption="ホストされたフォントを使用しているサイトのLCPの中央値。",
  description="さまざまなフォントホストを使用したデスクトップおよびモバイルサイトのFCPの中央値を示す棒グラフです。`cdn.shopify.com`はデスクトップで3,335、モバイルで8,401ともっとも速く、`fonts.shopifycdn.com`はそれぞれ3,224と8,531、`netdna.bootstrapcdn.com`は3,910と8,183、`maxcdn.bootstrapcdn.com`は4,240と8,530、`cdnjs.cloudflare.com`は4,105と8,730、`use.fontawesome.com`は4,519と9,166、`fonts.gstatic.com`は4,878と9,558、`cdn.jsdelivr.net`は5,368と10,646、`static.parastorage.com` は4,322と11,813、`use.typekit.net`は4,700と12,552になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2012634758&format=interactive",
  sql_file="04_05.web_font_usage_breakdown_with_fcp.sql"
  )
}}

Adobe（`use.typekit.net`）やMonotype（`fast.fonts.com`）などの商用サービスを見ていると、デスクトップではGoogle Fontsと同じかわずかに速い傾向があるが、モバイルでは明らかに遅いという点が興味深いです。これまでの常識では、これらのサービスで使用されているトラッキングスクリプトが大幅に速度を低下させていると考えられていましたが、現在では以前ほど問題になっていないようです。私たちが測定しているのはサイトのパフォーマンスであり、必ずしもフォントホストのパフォーマンスではないことは事実ですが、これらのトラッキングスクリプトはクライアントでのフォント読み込みに影響を与えるため、これらの見解を含めることは適切だと思われます。

#### セルフホスティングが必ずしも良いとは限らない

<a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">私たちがこのウェブサイトで発見したように</a>、ウェブサイトと同じドメインでフォントをセルフホスティングすると速くなることがありますが、データが示すように、必ずしもそうではありません。

{{ figure_markup(
  image="fonts-web-hosting-performance-desktop.png",
  caption="Webフォントのホスティング性能、デスクトップ",
  description="3種類のWebフォントホスティング戦略について、デスクトップのコンテンツの初回ペイントと最大のコンテンツフルペイントの中央値（単位：ミリ秒）を示した棒グラフ：ローカルはFCPの中央値で2,426ミリ秒、LCPの中央値で4,176ミリ秒、エクスターナルはそれぞれ2,034ミリ秒と3,671ミリ秒、両方はそれぞれ2,663ミリ秒と5,044ミリ秒です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=506816237&format=interactive",
  sheets_gid="838326315",
  sql_file="04_04.self_hosted_vs_hosted_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-web-hosting-performance-mobile.png",
  caption="Webフォントのホスティング性能、モバイル",
  description="3種類のWebフォントホスティング戦略におけるモバイルの中央値Fコンテンツの初回ペイントと最大のコンテンツフルペイントを示す棒グラフ（単位：ミリ秒）。localはFCPの中央値で5,326ミリ秒、LCPの中央値で8,521ミリ秒、externalはそれぞれ5,056ミリ秒、8,229ミリ秒、bothはそれぞれ5,847ミリ秒、9,900ミリ秒です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1955186104&format=interactive",
  sheets_gid="838326315",
  sql_file="04_04.self_hosted_vs_hosted_with_fcp.sql"
  )
}}

上記のデータからホスティング戦略との因果関係を推測するのは健全でないでしょう、なぜなら関係を混同する他の変数があるからです。しかし、それはさておきセルフホスティングフォントを追加しても、必ずしもパフォーマンスが向上するとは限らないことがわかりました。ホスティングされたフォントソリューションは、多くの最適化（サブセット化、OpenType機能の削除、可能な限り小さいフォントフォーマットの確保など）を実行しますが、セルフホスティングの場合は必ずしも再現されないことがあります。

#### ローカルが必ずしも良いとは限らない

サイトのサーバーでフォントを自前でホストする方法の他に、システムにインストールされているフォントを、クライアントでも`font-face`宣言で`local`を使用して使用する方法があります。`local`の使用は、バイト数を節約できるため、<a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">議論の的</a>となっていますが、ローカルにインストールされたフォントのバージョンが古い場合には悪い結果になることもあります。[2020年11月](https://x.com/googlefonts/status/1328761547041148929?s=19)現在、Google Fontsはモバイルプラットフォーム上のRobotoに対してのみ`local`を使用するように移行しており、それ以外の場合は常にネットワーク経由でフォントを取得しています。

## ファーストペイントへの挑戦

Webフォントを統合する際のパフォーマンス上の最大の懸念点は、最初に読めるテキストが表示されるまでの時間が遅れることです。このような問題を軽減するために、2つの最適化技術があります。`font-display`とリソースヒントです。

[`font-display`](https://developer.mozilla.org/docs/Web/CSS/@font-face/font-display)の設定は、Webフォントの読み込みを待つ間の動作を制御し、一般的にはパフォーマンスと視覚的な豊かさのトレードオフとなります。 もっともポピュラーなのは`swap`で、約10%のWebページで使用されています。これは、Webフォントがすぐ読み込まれない場合に予備フォントを使用して表示し、読み込まれたときにWebフォントを入れ替えるというものです。その他の設定としては、テキストの表示を一切行わない（Flash効果の可能性を最小限に抑える）`block`、`swap`と似ていますが、適度な時間でフォントが読み込まれない場合に使用する`fallback`、すぐに諦めて予備フォントを使用する`optional`などがあります。これを使用しているのは、パフォーマンスを重視するウェブページの1％に過ぎません。

{{ figure_markup(
  image="fonts-usage-of-font-display.png",
  caption="font-displayの使い方。",
  description="`swap`はデスクトップサイトの10.9%、モバイルサイトの10.3%、`auto`はそれぞれ5.2%、5.6%、`block`はそれぞれ4.1%、4.2%、`fallback`はそれぞれ0.9%、最後の`optional`はデスクトップサイトの0.3%、モバイルサイトの0.1%が使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=654093509&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

これらの設定がコンテンツの初回ペイントと最大のコンテンツフルペイントに与える影響を分析できます。驚くことではありませんが、`optional`の設定は最大のコンテンツフルペイントに大きな影響を与えます。また、コンテンツの初回ペイントにも影響がありますが、これは因果関係よりも相関関係の方が強いかもしれません。というのも、`block`を除くすべてのモードは、"極端に小さいブロック期間"の後に *何らかの* テキストを表示するからです。

{{ figure_markup(
  image="fonts-font-display-performance-desktop.png",
  caption="デスクトップでの`font-display`のパフォーマンスを改善しました。",
  description="フォント表示の設定を変えたときの、デスクトップの最初のコンテンツ描画（FCP）と最後のコンテンツ描画（LCP）の中央値をミリ秒単位で表した棒グラフです。`none`はFCPの中央値が2,286ミリ秒、LCPの中央値が4,028ミリ秒、`optional`はそれぞれ1,766ミリ秒、3,055ミリ秒、`swap`は2,223ミリ秒、4,176ミリ秒、`fallback`は2,397ミリ秒、4,106ミリ秒、`block`は2,454ミリ秒、4,696ミリ秒、`auto`は2,605ミリ秒、4,883ミリ秒です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1618299142&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-font-display-performance-mobile.png",
  caption="モバイルでの`font-display`のパフォーマンスを向上させました。",
  description="フォント表示の設定を変えたときの、モバイルの最初のコンテンツ描画（FCP）と最後のコンテンツ描画（LCP）の中央値をミリ秒単位で表した棒グラフです。`none`はFCPの中央値が5,279ms、LCPの中央値が8,381ms、`optional`はそれぞれ4,733msと6,598ms、`swap`は5,268msと8,748ms、`fallback`は5,478msと8,706ms、`block`は5,739msと9,625ms、`auto`は6,181msと10,103msとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2135700957&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

このデータからは、他にも2つの興味深い推論があります。`block`の設定は、とくにモバイルではFCPに大きな影響を与えると予想されますが、実際にはその効果はそれほど大きくありません。これは、フォントアセットの待ち時間がWebページ全体のパフォーマンスを制限する要因になることはほとんどないことを示唆していますが、画像などのリソースが多くないページでは大きな要因になることは間違いありません。`auto`の設定（指定しなかった場合の設定）は、ブラウザ次第です。<a hreflang="en" href="https://nooshu.github.io/blog/2020/02/23/improving-perceived-performance-with-the-css-font-display-property/">デフォルトではほとんどの場合にブロックされます</a>ので、`block`とよく似ています。

最後に、`fallback`を使用する正当な理由のひとつとして、`swap`と比較して最大コンテンツの描画時間を向上させることが挙げられます（デザイナーの視覚的意図を尊重する可能性が高いです）。そのためか、この設定は人気がなく、約1％のページでしか使われていません。

Google Fontsの推奨統合コードに`swap`が追加されました。現在使用していない場合は、これを追加することで、とくに低速回線のユーザーのパフォーマンスを向上させることができるかもしれません。

### リソースのヒント

`font-display`はフォントの読み込みが遅いときにページの表示を速くできますが、リソースヒントはWebフォントアセットの読み込みをカスケードの早い段階に移動させることができます。

通常、Webフォントの取得は2段階のプロセスで行われます。第一段階はCSSの読み込みで、CSSには実際のフォントバイナリへの参照が（`@font-face`セクションに）含まれています。

これは、ホスティングされたフォントソリューションにとくに関係しています。フォントが、必要であることがわかってはじめて、そのサーバーへの接続を開始できます。これはさらに、サーバーへのDNSクエリと、実際の接続の開始（最近では通常HTTPSの暗号ハンドシェイクを伴う）に分かれます。

{{ figure_markup(
  image="fonts-resource-hints-use.png",
  caption="フォントに関するリソース・ヒントの利用",
  description="フォントデータに対するさまざまなリソースヒント設定の使用状況を示す棒グラフです。`dns-prefetch`はデスクトップとモバイルの両方のサイトで32％、`preload`はデスクトップで17％、モバイルで16％、`preconnect`は両方で8％、`prefetch`は両方で3％、`prerender`は両方で0％の割合で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1880156934&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

HTMLに<a hreflang="en" href="https://www.w3.org/TR/resource-hints/#resource-hints">リソースヒント要素</a>を追加すると、2つ目の接続が早く始まります。さまざまなリソースヒントの設定は、実際のフォントリソースのURLを取得するまでの距離を制御します。もっとも一般的なのは（ウェブページの約32％）`dns-prefetch`ですが、ほとんどの場合、より良い選択肢があります。

次に、これらのリソースヒントがページのパフォーマンスに影響を与えるかどうかを見てみましょう。

{{ figure_markup(
  image="fonts-resource-hints-performance-desktop.png",
  caption="リソース・ヒント パフォーマンス、デスクトップ",
  description="リソースヒントの設定を変えた場合の、デスクトップの最初のコンテンツ描画と最後のコンテンツ描画の中央値（ミリ秒）を示す棒グラフ。`prerender`ではFCPの中央値が1,658ms、LCPの中央値が2,904ms、`preload`ではそれぞれ2,045msと3,865ms、`prefetch`では1,909msと3,702ms、`preconnect`では2,069msと4,213ms、`none`では2,489msと4,816ms、`dns-prefetch`では2,630msと5,061msとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=355239876&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-resource-hints-performance-mobile.png",
  caption="リソース・ヒント・パフォーマンス、モバイル",
  description="リソースヒントの設定を変えた場合の、モバイルの最初のコンテンツ描画と最後のコンテンツ描画の中央値（ミリ秒単位）を示す棒グラフ。`prerender`はFCPの中央値が3,387ms、LCPの中央値が7,362ms、`preload`はそれぞれ4,900msと8,222ms、`prefetch`は4,942msと8,191ms、`preconnect`は4,858msと9,131ms、`none`は5,825msと10,027ms、`dns-prefetch`は5,908msと9,962msとなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=640692889&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

このデータを分析すると、`dns-prefetch`設定は、もっとも一般的な設定であるにもかかわらず、あまりパフォーマンスを改善していないことがわかります。おそらく、人気のあるWebフォントサーバのDNSは、いずれにせよキャッシュされていると思われます。他の設定では、使いやすさ、柔軟性、パフォーマンスの向上の点で、`preconnect`がもっとも優れています。2020年3月現在、Google Fontsは、HTMLソースのCSSリンクの直前にこの行を追加することを推奨している。

```html
<link rel="preconnect" href="https://fonts.gstatic.com">
```

`preconnect`の使用率は昨年の2％から8％へと大幅に増加していますが、まだまだ潜在的なパフォーマンスは残っています。この行を追加することは、Google Fontsを使用しているWebページにとって唯一の最適化となるかもしれません。

パイプラインをさらに進めてフォントアセットのプリロードやプリレンダリングを行いたいと思うかもしれませんが、レンダリングエンジンの性能に合わせてフォントを微調整したり、後述する`unicode-range`の最適化など他の最適化と衝突する可能性があります。リソースをプリロードするためにはどのリソースをロードするかを *正確* に知る必要があり、タスクに最適なリソースは、HTMLオーサリング時には容易に入手できない情報に依存する可能性があります。

## ホーム・オン・ザ・（Unicode）・レンジ

フォントはますますたくさんの言語へ対応するようになっています。他のフォントでは、筆記体系（とくに日中韓）が必要とするために大量のグリフを持つことがあります。いずれの理由であれ、ファイルサイズは大きくなります。ウェブページが実際には多言語辞書ではなく、フォントの機能のほんの一部しか使っていない場合は残念なことです。

古い方法としては、HTML作成者が明示的にフォントサブセットを指定する方法があります。しかしこれにはコンテンツに関するより深い知識が必要で、コンテンツがフォントでサポートされている文字を使用していても選択されたサブセットではサポートされていない場合、「身代金要求」効果を発生させる危険性があります。フォールバックの仕組みについては、Marcin Wichary氏の素晴らしいエッセイ <a hreflang="en" href="https://www.figma.com/blog/when-fonts-fall/">When fonts fall</a> をご覧ください。

この問題を解決するには、`unicode-range`で示される静的なサブセットの方が良い方法です。フォントはサブセットにスライスされ、それぞれ個別の`@font-face`ルールで、そのスライスのUnicodeカバレッジを`unicode-range`記述子で示します。ブラウザは、レンダリングパイプラインの一部としてコンテンツを分析し、そのコンテンツのレンダリングに必要なスライスのみをダウンロードします。

アルファベット言語の場合、これは一般的にうまく機能しますが、異なるサブセット内のキャラクター間のカーニングが、悪くなることがあります。アラビア語、ウルドゥー語、多くのインド系言語など、グリフシェーピングに依存する言語では、静的サブセットを使用するとテキストレンダリングがよくおかしくなります。また日中韓では連続したUnicode範囲に基づく静的サブセットは、特定のページで使用される文字がさまざまなサブセットに、ほぼランダムに散らばっているためほとんどメリットがありません。このような問題があるため、静的サブセットを正しくかつ効率的に使用するには、慎重な分析と実装が必要となります。

{{ figure_markup(
  image="fonts-usage-of-unicode-range.png",
  caption="`unicode-range`の使い方。",
  description="ウェブフォントを使用しているモバイルおよびデスクトップのウェブページにおけるユニコードレンジの使用率を示す棒グラフ。デスクトップでは、37.05%のページがユニコードレンジを使用し、62.95%のページが使用していません。モバイルでは、38.27%のページがユニコードレンジを使用しており、61.73%が使用していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1739264728&format=interactive",
  sheets_gid="640499741",
  sql_file="04_08.font_unicode_range_with_fcp.sql"
  )
}}

テキストレイアウトがUnicodeをグリフにマッピングする方法には多くの複雑さがあるため、`unicode-range`を正しく適用するのは難しいが、Google Fontsはこれを自動的かつ透過的に行う。しかし、Google Fontsはこれを自動的かつ透過的に行う。いずれにせよ、現在の使用率はデスクトップで37％、モバイルで38％となっている。

## フォーマットとMIMEタイプ

WOFF2はもっとも優れた圧縮フォーマットで、現在ではInternet Explorerのバージョン11以前を除くほぼすべてのブラウザで <a hreflang="en" href="https://caniuse.com/woff2">サポートされています</a>。WOFF2ソースのみで`@font-face`ルールを使用してウェブフォントを提供することは、 *ほぼ* 可能です。このフォーマットは、提供されるフォントの約75％を占めています。

{{ figure_markup(
  image="fonts-web-font-mime-types.png",
  caption="ポピュラーなウェブフォントのMIMEタイプ。",
  description="ウェブフォントを提供する際のさまざまなMIMEタイプの割合の内訳を示す棒グラフです。フォントを使用しているページのうち、デスクトップで75.83%、モバイルでは74.32%がWOFF2を使用しており、WOFFはそれぞれ11.57%と11.61%、octet-streamは6.33%と6.09%、ttfは2.54%と4.42%、plainは1.41%と1.32%となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2028456617&format=interactive",
  sheets_gid="316058576",
  sql_file="04_10.font_formats.sql"
  )
}}

WOFFは、より古く効率の悪い圧縮メカニズムですがほぼ全世界でサポートされており、提供されているフォントの11.6%を占めています。ほとんどすべての場合（Internet Explorer 9-11は例外）、フォントをWOFFとして提供することはパフォーマンスを犠牲にすることであり、セルフホスティングのリスクを示しています。ホストサービスを利用すると、最適なフォーマットが選択され、関連するすべての最適化が保証されます。

世界のブラウザシェアの約1.5％を占めるInternet Explorerの古いバージョン（6～8）は、EOTフォーマットしかサポートしていません。これらはMIMEフォーマットのトップ5には含まれていませんが、最大限の互換性を確保するために必要です。

OTFやTTFファイルなどの非圧縮フォントは圧縮フォントに比べて2〜3倍の大きさですが、それでも提供されるフォントの約5％を占めておりモバイルでの利用が、多いことが分かります。もしこれらのフォントを提供しているのであれば、最適化が可能であることを示すレッドフラッグとなるはずです。

## 人気のあるフォント

アイコンフォントは、もっとも人気のあるウェブフォントのトップ10のうち半分を占めており、残りはクリーンで堅牢なサンセリフ書体のデザインです（このランキングではRoboto Slabが19位、Playfair Displayが26位に入っており他のスタイルのデビューとなっていますがセリフ書体のデザインは分布の末尾によく現れています）。

{{ figure_markup(
  image="fonts-popular-typefaces.png",
  caption="人気のある書体です。",
  description="Font Awesome（デスクトップとモバイルで35％）、Open Sans（デスクトップで23％、モバイルで25％）、Roboto（デスクトップで17％、モバイルで23％）を筆頭に、もっとも人気のあるWebフォント10種類を棒グラフで表示しています。Glyphicons Halflings（デスクトップ16％、モバイル8％）、Lato（デスクトップ11％、モバイル11％）、Montserrat（デスクトップ19％、モバイル19％）、Font Awesome 5 Brands（デスクトップ9％、モバイル9％）、Font Awesome 5 Free（デスクトップ9％、モバイル8％）、Raleway（デスクトップ6％、モバイル6％）、dashicons（デスクトップ6％、モバイル6％）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=551344676&format=interactive",
  sheets_gid="179750099",
  sql_file="04_11a.popular_typeface.sql",
  width="600",
  height="520"
  )
}}

注意点としてはもっとも人気のあるフォントを決定する際、測定方法によって異なる結果が、得られる可能性があります。上のグラフは指定されたフォントを参照する`@font-face`ルールを含むページの数をカウントしたものです。これは、複数のスタイルを一度だけカウントするものであり、シングルスタイルのフォントに有利に働くことは間違いありません。

## カラーフォント

カラーフォントは、何らかの形でほとんどのモダンブラウザでサポートされていますが使用率はまだ皆無に近い状態です（合計で755ページ、その大部分はChromeではサポートされていないSVGフォーマットです）。問題の1つは、フォーマットの多様性で、実際には4つのフォーマットが広く使用されています。これらには、ビットマップ形式とベクター形式があります。2つのビットマップフォーマットは技術的には非常によく似ていますが、SBIX（元々はApple独自のフォーマット）はFirefoxではサポートされておらず、CBDT/CBLCはSafariではサポートされていません。

COLRベクトルフォーマットは、すべての主要なモダンブラウザでサポートされていますが、かなり最近になってサポートされました。4つ目のフォーマットは、OpenType（SVGフォントと混同しないように）にSVGを埋め込むものですが、Chromeではサポートされていません。OpenTypeのSVGの欠点は、現代のウェブデザインでますます重要になっている、フォントのバリエーションがサポートされていないことです。とくにグラデーションやクリッピングのサポートについては、COLRの将来のバージョンに向けて開発が進められているため、COLRフォーマットが主流になると思われます。ベクターフォーマットは通常、画像よりもはるかに小さく、また、より大きなサイズにきれいに拡大できます。

ウェブでのカラーフォントのサポートが不十分な理由のひとつは、カラーをフォントファイル自体に焼き付ける必要があることです。同じ書体を3つの異なる色の組み合わせで使用する場合、ほぼ同じファイルを3回ダウンロードしなければならず、色を変更するにはフォントエディターを使用しなければなりません。

CSSには、<a hreflang="en" href="https://drafts.csswg.org/css-fonts-4/#font-palette-values">フォントのカラーパレットを上書きしたり、置き換えたりする機能がありますが</a>、これはまだブラウザに実装されておらず、カラーウェブフォントの導入のしやすさを阻んでいるのが現状です。

カラーフォントの用途は、おそらく絵文字がほとんどだと思いますが、その機能は汎用的でカラーフォントには多くのデザインの可能性があります。カラーWebフォントはまだ普及していませんが、その技術は、ファイルフォーマットの互換性があまり問題にならないシステム絵文字の配信に多用されています。

ブラウザのサポートは非常に断片的であるため、カラーフォントはまだcaniuse.comでは追跡されていませんが、<a hreflang="en" href="https://github.com/Fyrd/caniuse/issues/1018">そのための課題が公開されています</a>。

カラーフォントについては、例を含めて多くの情報が<a hreflang="en" href="https://www.colorfonts.wtf/">colorfonts.wtf</a>にあります。

## 可変フォント

{{ figure_markup(
  caption="モバイルでの可変フォントの使用",
  content="11.00%",
  classes="big-number",
  sheets_gid="91894176",
  sql_file="04_14a.variable_font_comparison_fcp.sql"
) }}

可変フォントは、確かに今年の最大の話題の1つです。デスクトップでは10.54％、モバイルでは11.00％が可変フォントを使用しています。これは、昨年の平均1.8％からの増加で、大きな成長要因となっています。デザインの自由度が高くとくに同じページで同じフォントを複数使用している場合、2つのフォントサイズが、小さくなる可能性があるからです。

この増加の最大の要因はGoogle Fontsがページで使用されているウェイトが十分で、ブラウザがサポートしている場合に、人気のあるフォントの多くを可変フォントとして提供するようなったことにあると思われます。使用されているCSSを変更することなく、またWeb制作者の手を煩わせることなくパフォーマンスを向上させることができる可変フォントの「スワップイン」機能は、この技術の実行可能性を顕著に示している。

バリアブルフォントフォーマットを簡単に説明すると、1つのフォントファイルが複数の役割を果たすということです。ウェイトや幅さらにはイタリックなど、それぞれに個別のフォントファイルを用意するのではなく、それらをすべて1つの効率の良いファイルに収めることができます。このファイルは、CSS（またはCSSをサポートする他のアプリケーション）を介して、指定された軸の値の組み合わせでフォントをレンダリングできます。標準化された、つまり「登録された」軸がいくつかあるほか、フォントデザイナーが独自の軸を定義してユーザーに公開することもできます。

ウェイト（`wght`）はレギュラーやボールドライトといった伝統的な概念に対応し、幅（`wdth`）はコンデンスやエクステンデッドといったスタイルに対応し、スラント（`slnt`）はフォントの斜めの角度を意味し、イタリック（`ital`）は通常フォントを斜めにし、特定のグリフを代替スタイルに置き換えます。そして、オプティカルサイズ（`opsz`）は、ウェブでは比較的新しいものを意味しますが、実際には数百年前の金属活字の制作で一般的だった技術の復活です。歴史的にはオプティカルサイジングとは、物理的に小さいサイズのフォントで読みやすさを高めるためにストロークのコントラスト（太い線と細い線）を減らして文字の間隔を広げ、逆にかなり大きなサイズで表示されたフォントでは、コントラストを増やして文字の間隔を狭めることを意味します。デジタルタイプでこの機能を有効にすると、1つのフォントを非常に小さいサイズで使用した場合と大きいサイズで使用した場合とで、見た目や動作を大きく変えることができます。<a hreflang="en" href="https://variablefonts.io">variablefonts.io</a>では、この機能について詳しく説明し、多くの例を見ることができます。

{{ figure_markup(
  image="fonts-font-variation-settings-usage.png",
  caption="font-variation-settingsの軸の使い方。",
  description="フォントのバリエーション設定でもっとも人気のある6つの軸の使用率を棒グラフで示しています。デスクトップでは84.7％、モバイルでは90.4％の`wght`が圧倒的に多く、残りの`wdth`はデスクトップで5.6％、モバイルで4.3％、`opsz`はそれぞれ3.7％と1.2％、`slnt`は1.8％と1.4％、`fanu`は0.5％と0.6％、`ital`はデスクトップで0.5％、モバイルで0.4％となっており、`wght`が圧倒的に多いことがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=635348995&format=interactive",
  sheets_gid="309969915",
  sql_file="04_17.VF_axis_value.sql"
  )
}}

もっともよく使われている軸は`wght`（重さを制御する）で、デスクトップで84.7%、モバイルでは90.4%となっています。しかし、`wdth`（幅）は可変フォントの使用率の約5％を占めている。2020年、Google Fontsは幅軸と重さ軸の両方を持つ2軸フォントの提供を開始した。

この2つの軸については、可変フォントをサポートするすべてのブラウザで完全にサポートされているため、低レベルの`font-variation-settings`構文ではなく、`font-weight`および`font-stretch`を使用するのが望ましい方法であることを覚えておいてください。重さを`font-weight: [number]`で重みを設定し、`font-stretch.html`で幅を設定します。これにより、可変フォントの読み込みに失敗した場合でも、エンドユーザーに適切なレンダリングを提供できます。また、カスケードによるスタイルの通常の継承を変更することもありません。

オプティカルサイズ（`opsz`）機能は、可変フォントの使用量の約2％に使用されています。意図した表示サイズに合わせてフォントの外観を調整することで微妙ではありますが、視覚的な洗練度が向上するため、この機能には注目が集まっています。また光学的サイズの定義方法について、現在のクロスブラウザやクロスプラットフォームの不確実性が解消されれば、使用量は増加すると思われます。オプティカルサイズ機能の魅力的な点は、`auto`の設定で、自動的に変化することです。つまり、開発者は`opsz`機能を持つフォントを使うだけで、洗練された恩恵を受けることができます。

可変フォントの使用には多くの利点があります。軸が増えるごとにファイルサイズは大きくなりますが、一般的にはある書体の2つまたは3つ以上のウェイトが使用されている場合には可変バージョンの方が、総ファイルサイズが同等か小さくなる可能性が高いというのが転換点のようです。これは、<a hreflang="en" href="https://fonts.google.com/?vfonly=true">Google Fontsで提供されているバリアブル・フォント</a>の劇的な増加によって裏付けられている。

また、可変フォントを採用して活用することで、より変化に富んだデザインを実現することもできます（利用可能なウェイトや幅の範囲をより多く使用できます）。幅軸を使用することで、とくに大きな見出しや長い言語の場合、小さな画面での行の折り返しを改善できます。代替ライトモードの採用が進んでいるため、モードを切り替える際にフォントウェイトを少しずつ調整することで、読みやすさを向上させることができます（使い方や実装方法については、<a hreflang="en" href="https://variablefonts.io">variablefonts.io</a>を参照してください）。

## 結論

Webフォントの技術は、圧縮などの技術的な改良を重ねながらかなり成熟していますが、新しい機能も続々と登場しています。可変フォントに対するブラウザのサポートはかなり充実してきており、この機能は昨年もっとも成長した機能です。

<a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">cache partitioning</a>の出現により、CDNフォントリソースのキャッシュを複数のサイトで共有することによるパフォーマンス上のメリットが減少しているため、パフォーマンスの状況は多少変化しています。CDNを利用するよりも、サイトと同じドメインでより多くのフォント資産をホスティングする傾向は、おそらく今後も続くでしょう。それでも、Google Fontsのようなサービスは高度に最適化されており、`swap`や`preconnect`の使用などのベストプラクティスにより、追加のHTTP接続による影響の多くが緩和されます。

可変フォントの使用は非常に加速しており、とくにブラウザやデザインツールのサポートが向上すれば、この傾向は間違いなく続くでしょう。また、2021年はカラーWebフォントの年になるかもしれません。技術的には実現していますが、まだ実現していません。

最後に、W3CのWeb Font Working Groupで研究されているWebフォント技術の新しいコンセプトについて触れておきましょう。Progressive Font Enrichmentです。PFEは、本章で指摘した多くの課題に対する回答として設計されています。すなわちグリフ数の多いフォントファイル（アラビア語や日中韓のフォントなど）や、より大きな多軸フォントやカラーフォントを使用する場合、または単に遅いネットワーク接続環境を使用する場合のパフォーマンスとユーザーエクスペリエンスに対処するものです。

簡単に言うと、あるページのコンテンツをレンダリングするために、あるフォントファイルの一部だけをダウンロードすればよいというコンセプトです。その後のページ読み込みでは、各ページのレンダリングに必要なグリフのみを含むフォントファイルの「パッチ」が配信されます。このように、ユーザーは一度にフォントファイル全体をダウンロードする必要はありません。

プライバシーの確保や下位互換性の確保など、さまざまな詳細を詰めていく必要がありますが、初期の研究では非常に有望な結果が得られており今後2、3年のうちにこの技術が広くウェブに普及することが期待されています。この技術については、<a hreflang="en" href="https://rwt.io/typography-tips/progressive-font-enrichment-reinventing-web-font-performance">Jason Pamental氏による紹介文</a>や、W3Cのサイトにある<a hreflang="en" href="https://www.w3.org/TR/2020/NOTE-PFE-evaluation-20201015/">Working Group Evaluation Report</a>の全文で詳しく知ることができます。
