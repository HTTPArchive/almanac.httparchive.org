---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: 2020年Web Almanac「JavaScript」の章では、ウェブ上でどれだけJavaScriptを使用しているか、圧縮、ライブラリとフレームワーク、ロード、ソースマップを網羅しています。
authors: [tkadlec]
reviewers: [ibnesayeed, denar90]
analysts: [rviscomi, paulcalvano]
editors: [rviscomi]
translators: [ksakae1216]
tkadlec_bio: Timは、誰もが使えるWebを構築することに焦点を当てたWebパフォーマンスコンサルタントであり、トレーナーです。著書に『High Performance Images』（O'Reilly, 2016）、『Implementing Responsive Design』（New Riders, 2012）があります。彼は<a hreflang="en" href="https://timkadlec.com/">timkadlec.com</a>でウェブ全般について書いています。<a href="https://twitter.com/tkadlec">@tkadlec</a>で、彼の考えを簡潔にまとめてTwitterで紹介しています。
discuss: 2038
results: https://docs.google.com/spreadsheets/d/1cgXJrFH02SHPKDGD0AelaXAdB3UI7PIb5dlS0dxVtfY/
featured_quote: JavaScriptは、CSS、HTMLと並んでウェブの3つの礎となる最後の礎として、その謙虚な起源から長い道のりを歩んできました。今日では、JavaScriptは技術スタックの幅広い範囲に浸透し始めています。JavaScriptはもはやクライアントサイドに限定されたものではなく、ビルドツールやサーバーサイドのスクリプティングのための選択肢として、ますます人気が高まっています。エッジコンピューティングソリューションのおかげで、JavaScriptはCDNレイヤーにも浸透してきています。
featured_stat_1: 1,897ms
featured_stat_label_1: モバイルでのJSメインスレッド時間の中央値
featured_stat_2: 37.22%
featured_stat_label_2: モバイルでJS未使用の割合
featured_stat_3: 12.2%
featured_stat_label_3: 非同期に読み込まれたスクリプトの割合
---

## 序章

JavaScriptは、CSSとHTMLと並んでウェブの3つの礎となる最後の礎として、その謙虚な起源から長い道のりを歩んできました。今日では、JavaScriptは技術スタックの幅広い範囲に浸透し始めています。JavaScriptはもはやクライアントサイドに限定されたものではなく、ビルドツールやサーバーサイドのスクリプティングのための選択肢として、ますます人気が高まっています。エッジコンピューティングソリューションのおかげで、JavaScriptはCDNレイヤーにも浸透してきています。

開発者はJavaScriptが大好きです。マークアップの章によると、`script`要素は、現在使用されている[6番目に人気のあるHTML要素](./markup)です（数え切れないほどの要素の中で、`p`や`i`などの要素よりも上位にあります）。ウェブの構成要素であるHTMLの約14倍、CSSの約6倍のバイト数を費やしています。

{{ figure_markup(
  image="../page-weight/bytes-distribution-content-type.png",
  caption="コンテンツタイプごとのページ重さの中央値。",
  description="画像、JS、CSS、HTMLにわたるデスクトップページとモバイルページのページ重量の中央値を示す棒グラフ。モバイルページの各コンテンツタイプのバイト数の中央値は以下の通りです。画像が916KB、JSが411KB、CSSが62KB、HTMLが25KBです。デスクトップページでは、画像の量がかなり多く（約1000KB）、JSの量がやや多い（約450KB）傾向にあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1wG4u0LV5PT9aN-XB1hixSFtI8KIDARTOCX0sp7ZT3h0/#378779486",
  sql_file="../page-weight/bytes_per_type_2020.sql"
) }}

しかし、無料のものはありません。特にJavaScriptコードにはすべてコストがかかります。私たちがどのくらいのスクリプトを使っているのか、どのように使っているのか、そしてその結果はどうなるのか、詳しく見ていきましょう。

## どのくらいのJavaScriptを使っているのか？

前に、`script`タグはHTML要素の中で6番目に多く使われている要素であることを述べました。実際にどのくらいのJavaScriptが使われているのか、もう少し掘り下げて見てみましょう。

中央値のサイト（50パーセンタイル）では、デスクトップ端末で読み込んだときに444KBのJavaScriptを送信し、モバイル端末ではわずかに少ない（411KBの）JavaScriptを送信しています。

{{ figure_markup(
  image="bytes-2020.png",
  caption="1ページあたりに読み込まれたJavaScriptのキロバイト数の分布。",
  description="ページあたりのJavaScriptバイト数の分布を10%程度の割合で示した棒グラフ。デスクトップページは、モバイルページよりも一貫してJavaScriptのバイト数が多く読み込まれています。デスクトップの10％、25％、50％、75％、90％は以下の通りです。87KB、209KB、444KB、826KB、および1,322KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=441749673&format=interactive",
  sheets_gid="2139688512",
  sql_file="bytes_2020.sql"
) }}

ここに大きなギャップがないのは少し残念です。使用中のデバイスが電話かデスクトップ（またはその間のどこか）かどうかに基づいて、ネットワークや処理能力についてあまりにも多くの仮定をするのは危険ですが、[HTTP Archive mobile tests](./methodology#webpagetest) は、Moto G4と3Gネットワークをエミュレートすることによって行われていることは注目に値します。言い換えれば、より少ないコードを渡すことであまり理想的でない状況に適応するために行われている作業があった場合、これらのテストはそれを示しているはずです。

また、傾向としては、JavaScriptの使用量を減らすのではなく、より多くのJavaScriptを使用することに賛成しているようです。[昨年の結果](./2019/javascript#how-much-javascript-do-we-use)と比較すると、中央値ではデスクトップでテストされたJavaScriptが13.4%増加し、モバイルに送信されたJavaScriptの量が14.4%増加しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>クライアント</th>
        <th>2019</th>
        <th>2020</th>
        <th>変化</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>デスクトップ</td>
        <td class="numeric">391</td>
        <td class="numeric">444</td>
        <td class="numeric">13.4%</td>
      </tr>
      <tr>
        <td>モバイル</td>
        <td class="numeric">359</td>
        <td class="numeric">411</td>
        <td class="numeric">14.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="1 ページあたりの JavaScript キロバイト数の中央値の前年比変化。",
      sheets_gid="86213362",
      sql_file="bytes_2020.sql"
    ) }}
  </figcaption>
</figure>

少なくともこの重量の一部は不要なもののようです。任意のページロードでどのくらいのJavaScriptが未使用になっているかの内訳を見ると、中央値のページでは152KBの未使用JavaScriptが提供されていることがわかります。その数は75パーセンタイルで334KB、90パーセンタイルで567KBに跳ね上がっています。

{{ figure_markup(
  image="unused-js-bytes-distribution.png",
  caption="モバイルページあたりのJavaScriptの無駄なバイト数の分布。",
  description="1ページあたりのJavaScriptの無駄なバイト数の分布を示す棒グラフ。10,25,50,75,90パーセンタイルの順に分布しています。0,57,153,335,568KBとなります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=773002950&format=interactive",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

しかし、各ページで使用されているJavaScriptの全体のパーセンテージとして見ると、どれだけ無駄なものを送っているのかが少しわかりやすくなります。

{{ figure_markup(
  caption="中央のモバイルページのJavaScriptバイトのうち、未使用のものの割合。",
  content="37.22%",
  classes="big-number",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

その153KBは、モバイルデバイスに送信するスクリプトの総サイズの約37%に相当します。ここには間違いなく改善の余地があります。

### `module`と`nomodule`
送信するコードの量を減らす可能性のあるメカニズムの1つとして、 <a hreflang="en" href="https://web.dev/serve-modern-code-to-modern-browsers/">`module`/`nomodule`パターン</a>を利用することがあります。このパターンでは、モダンブラウザ向けのバンドルとレガシーブラウザ向けのバンドルの2つのセットを作成します。モダンブラウザ向けのバンドルは`type=module`、レガシーブラウザ向けのバンドルは`type=nomodule`となります。

このアプローチにより、サポートしているブラウザに最適化された最新の構文を持つ小さなバンドルを作成できますが、そうでないブラウザには条件付きで読み込まれたポリフィルと異なる構文を提供します。

`module`や`nomodule`のサポートは広がっているが、まだ比較的新しいものです。その結果、採用率はまだ少し低いです。レガシーブラウザをサポートするために`type=module`のスクリプトを少なくとも1つ使っているのはモバイルページの3.6%に過ぎず、`type=nomodule`のスクリプトを少なくとも1つ使っているのはモバイルページの0.7%に過ぎません。

### リクエスト数

私たちがどれだけのJavaScriptを使用しているかを見るもう1つの方法は、各ページでどれだけのJavaScriptリクエストが行われているかを調べることです。HTTP/1.1ではリクエスト数を減らすことがパフォーマンスを維持するための最優先事項でしたが、HTTP/2ではその逆です。JavaScriptを<a hreflang="en" href="https://web.dev/granular-chunking-nextjs/">小さくて個別のファイル</a>に分解することが[通常はパフォーマンスを向上させる]のです../2019/http#impact-of-http2)。

{{ figure_markup(
  image="requests-2020.png",
  caption="1ページあたりのJavaScriptリクエストの分布。",
  description="2020年の1ページあたりのJavaScriptリクエストの分布を示す棒グラフ。モバイルページの10、25、50、75、90パーセンタイルは4、10、19、34、55となっています。デスクトップページでは、1ページあたりのJavaScriptリクエスト数が0または1と多い傾向にあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=153746548&format=interactive",
  sheets_gid="1804671297",
  sql_file="requests_2020.sql"
) }}

中央値では、ページは20回のJavaScriptリクエストを行います。これは中央値で19回のJavaScriptリクエストを行っていた昨年よりもわずかに増加しています。

{{ figure_markup(
  image="requests-2019.png",
  caption="2019年の1ページあたりのJavaScriptリクエストの配信。",
  description="2019年の1ページあたりのJavaScriptリクエストの分布を示す棒グラフ。モバイルページの10、25、50、75、90パーセンタイルは4、9、18、32、52となっています。2020年の結果と同様に、デスクトップページでは1ページあたりのリクエスト数が0または1と多い傾向にあります。これらの結果は2020年の結果よりも若干低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=528431485&format=interactive",
  sheets_gid="1983394384",
  sql_file="requests_2019.sql"
) }}

## それはどこから来るのか？

ページで使用されるJavaScriptの増加の一因となっていると思われる傾向として、クライアント側のA/Bテストや分析から広告配信、パーソナライゼーションの処理まで、あらゆることを支援するためページに追加されるサードパーティ製のスクリプトの量が増え続けていることが挙げられます。

サードパーティのスクリプトがどれくらいあるのか、少し掘り下げてみましょう。

中央値までは、サードパーティのスクリプトとほぼ同じ数のファーストパーティのスクリプトを提供しています。中央値では、1ページあたり9個のファーストパーティのスクリプトがあるのに対し、サードパーティのスクリプトは1ページあたり10個となっています。サイトが提供しているスクリプトの数が多いほど、その大半がサードパーティ製のスクリプトである可能性が高くなります。

{{ figure_markup(
  image="requests-by-3p-desktop.png",
  caption="デスクトップ用のホスト別のJavaScriptリクエスト数の分布。",
  description="デスクトップ用のホストごとのJavaScriptリクエストの分布を示す棒グラフです。ファーストパーティのリクエストの10, 25, 50, 75, 90パーセンタイルは、2、4、9、17、30です。1ページあたりのサードパーティのリクエスト数は、上位のパーセンタイルで1から6リクエストの方がわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1566679225&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

{{ figure_markup(
  image="requests-by-3p-mobile.png",
  caption="モバイル向けのホスト別のJavaScriptリクエスト数の分布。",
  description="モバイル用のホストごとのJavaScriptリクエストの分布を示す棒グラフ。ファーストパーティのリクエストの10、25、50、75、90パーセンタイルは1ページあたり2、4、9、17、30リクエストです。これはデスクトップと同じです。1ページあたりのサードパーティのリクエスト数は、デスクトップと同様に上位のパーセンタイルでは1から5リクエストの方がわずかに高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1465647946&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

JavaScriptリクエストの量は中央値では同じようなものですが、実際のスクリプトのサイズは、サードパーティのソースの方が少し重くなっています（ダジャレを意図したものです）。中央値のサイトでは、サードパーティからデスクトップデバイスに267KBのJavaScriptを送信していますが、ファーストパーティからは147KBです。モバイルでも状況は非常によく似ており、中央のサイトがサードパーティのスクリプトを255KB送っているのに対し、ファーストパーティのスクリプトは134KBです。

{{ figure_markup(
  image="bytes-by-3p-desktop.png",
  caption="デスクトップ用のホスト別のJavaScriptバイト数の分布。",
  description="デスクトップ用のホストごとのJavaScriptのバイト数分布を示す棒グラフ。ファーストパーティのバイト数の10、25、50、75、および90パーセンタイルは1ページあたり21、67、147、296、599KB。1ページあたりのサードパーティからのリクエスト数は、343KBまでの上位パーセンタイルで大幅に増加しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1749995505&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

{{ figure_markup(
  image="bytes-by-3p-mobile.png",
  caption="モバイル向けのホスト別のJavaScriptバイト数の分布。",
  description="モバイル向けのホストごとのJavaScriptのバイト数分布を示す棒グラフです。ファーストパーティバイトの10、25、50、75、および90パーセンタイルは18、60、134、275、および560KB。これらの値は、デスクトップの値よりも一貫して小さいですが、10～30KBの差しかありません。デスクトップと同様にサードパーティのバイト数はファーストパーティよりも高く、モバイルではこの差はそれほど大きくなく、90パーセンタイル台では328KBまでしかありません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=231883913&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

## どうやってJavaScriptを読み込むのか？

JavaScriptの読み込み方法は、全体的な体験に大きな影響を与えます。

デフォルトでは、JavaScriptは_parser-blocking_になっています。言い換えれば、ブラウザが`script`要素を発見したとき、スクリプトがダウンロードされ、解析され、実行されるまでHTMLの解析を一時停止しなければなりません。これは重要なボトルネックであり、レンダリングに時間がかかるページの一般的な原因となっています。

非同期（`async`属性を使用）にスクリプトを読み込むことで、JavaScriptの読み込みにかかるコストの一部を相殺できます。どちらの属性も外部スクリプトでのみ利用可能で、インラインスクリプトには適用できません。

モバイルでは外部スクリプトが、検出されたスクリプト要素全体の59.0%を占めています。

<p class="note">
  余談ですが、先ほどページに読み込まれるJavaScriptの量について話したとき、その合計にはこれらのインラインスクリプトのサイズは含まれていませんでした。つまり、数字が示す以上に多くのスクリプトが読み込まれているということです。
</p>

{{ figure_markup(
  image="external-inline-mobile.png",
  caption="モバイルページごとの外部スクリプトとインラインスクリプトの数の分布。",
  description="モバイルスクリプトの41.0％がインライン、59.0％が外部スクリプトであることを示す円グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1326937127&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

これらの外部スクリプトのうち、`async`属性でロードされたものは12.2%に過ぎず、`defer`属性でロードされたものは6.0%に過ぎない。

{{ figure_markup(
  image="async-defer-mobile.png",
  caption="モバイルページあたりの`async`および`defer`スクリプトの数の分布。",
  description="円グラフによると、外部モバイルスクリプトで非同期を使用しているのは12.2%で、6.0%が遅延を使用しており、81.8%がどちらも使用していないことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=662584253&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

`defer`が最高のロードパフォーマンスを提供してくれることを考えると（スクリプトのダウンロードが他の作業と並行して行われ、ページを表示できるようになるまで実行が待たされることを保証することで）、その割合がもう少し高くなることを期待したいところです。実際には、6.0%というのは少し膨らんでいます。

IE8とIE9のサポートが一般的だった頃は、`async`と`defer`属性の両方を使うのが比較的一般的でした。両方の属性を使えば、両方をサポートしているブラウザは`async`を使うことになります。IE8とIE9は`async`をサポートしていないので、`defer`属性を使うようになります。

今日では、大多数のサイトではパターンは不要でありパターンが配置された状態で読み込まれたスクリプトはページが読み込まれるまで延期するのではなく、実行する必要があるときにHTMLパーサーを中断します。このパターンは今でも驚くほど頻繁に使用されており、モバイルページの11.4%がこのパターンを実装したスクリプトを少なくとも1つ提供しています。言い換えれば、`defer`を使用している6%のスクリプトのうち、少なくとも一部は`defer`属性の恩恵を十分に受けていないということです。

しかし、ここには心強い話があります。

Harry Robertsが[Twitterでアンチパターンについてつぶやいていた](https://twitter.com/csswizardry/status/1331721659498319873)ということで、野生でどれくらいの頻度で発生しているのかを確認するように促されました。[Rick Viscomiが調べてみた](https://twitter.com/rick_viscomi/status/1331735748060524551)で、「stats.wp.com」が最も多くの違反者を出していたことが判明しました。Automatticの@Kraftさんから返信があり、パターンは現在[削除済です](https://twitter.com/Kraft/status/1336772912414601224)。

ウェブのオープン性についての素晴らしい点の1つは、1つの観察がいかに意味のある変化につながるかということであり、それはまさにここで起こったことです。

### リソースのヒント

JavaScriptの読み込みにかかるネットワークコストの一部を相殺するためのもう1つのツールとしての[リソースヒント](./resource-hints)、具体的には`prefetch`と`preload`があります。

ヒント`prefetch`は、次のページのナビゲーションでリソースが使用されることを開発者に示すものです。

`preload`ヒントは、現在のページでリソースが利用されることを示し、ブラウザはそのリソースをより高い優先度ですぐにダウンロードすべきであることを示します。

全体では、モバイルページの16.7%が、JavaScriptをより積極的に読み込むための2つのリソースヒントのうち少なくとも1つを使用していることがわかります。

そのうち、ほぼすべての利用は`preload`に由来しています。モバイルページの16.6%がJavaScriptを読み込むために少なくとも1つの`preload`ヒントを使用しているのに対し、モバイルページでは少なくとも1つの`prefetch`ヒントを使用しているのは0.4%に過ぎません。

特に`preload`の場合、ヒントを多用しすぎて効果が低下するリスクがあるので、ヒントを使用しているページを見て、そのページがどれだけの数のヒントを使用しているかを確認する価値があります。

{{ figure_markup(
  image="prefetch-distribution.png",
  caption="1ページあたりの`prefetch`ヒントの数の分布。",
  description="任意のprefetchヒントのあるページあたりの分布を示す棒グラフ。デスクトップページとモバイルページの10、25、50パーセンタイルでは、1ページあたりのprefetchヒントは1、2、3です。デスクトップページの75%では6、モバイルページでは4です。90パーセンタイルの割合では、デスクトップページでは1ページあたり14個、モバイルページでは12個のprefetchヒントを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1874381460&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

{{ figure_markup(
  image="preload-distribution.png",
  caption="任意の`preload`ヒントを持つページあたりの`preload`ヒントの数の分布。",
  description="任意のpreloadヒントを使用したページごとの分布を示す棒グラフ。preloadヒントを使用しているデスクトップとモバイルのページの75%は、正確には1回だけ使用しています。90パーセンタイルでは、デスクトップでは1ページあたり5個、モバイルでは7個のpreloadヒントが使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=320533828&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

中央値では、`prefetch`ヒントを使ってJavaScriptを読み込むページで3つのヒントが使われていますが、`preload`ヒントを使っているページでは1つしか使われていません。90パーセンタイル台では12個の`prefetch`ヒントが使用され、90パーセンタイル台では7個の`preload`ヒントが使用されています。リソースヒントの詳細については、今年の [Resource Hints](./resource-hints) の章を参照してください。

## どのようにJavaScriptを提供するのか？

ウェブ上のあらゆるテキストベースのリソースと同様に、最小化と圧縮によってかなりのバイト数を節約できます。これらの最適化はどちらも新しいものではなく、かなり前から行われていたものなので、適用されていないケースが多いと予想されます。

[Lighthouse](./methodology#lighthouse)の監査では、未定義のJavaScriptをチェックし、その結果に基づいてスコア（0.00が最悪、1.00が最高）を提供しています。

{{ figure_markup(
  image="lighthouse-unminified-js.png",
  caption="未定義のJavaScript Lighthouseの監査スコアをモバイルページごとに配布しています。",
  description="棒グラフは、JavaScript Lighthouseの監査スコアが0.25未満のモバイルページの0％、0.25～0.5の間の4％、0.5～0.75の間の10％、0.75～0.9の間の8％、0.9～1.0の間の77％のページのスコアを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=158284816&format=interactive",
  sheets_gid="362705605",
  sql_file="lighthouse_unminified_js.sql"
) }}

上のチャートを見ると、ほとんどのページが0.90以上のスコアを取得している（77％）ことがわかりますが、これは未完のスクリプトがほとんどないことを意味します。

全体では、記録されたJavaScriptリクエストのうち、4.5%しか未処理のものはありません。

興味深いことに、サードパーティのリクエストを少し取り上げましたが、これはサードパーティのスクリプトがファーストパーティのスクリプトよりもうまくいっている分野の1つです。平均的なモバイルページの統一されてないJavaScriptバイトの82%はファーストパーティのコードから来ています。

{{ figure_markup(
  image="lighthouse-unminified-js-by-3p.png",
  caption="ホスト別の最小化されていないJavaScriptのバイト数の平均分布。",
  description="円グラフを見ると、統一されてないJSバイトの17.7%がサードパーティスクリプトで、82.3%がファーストパーティスクリプトであることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=2073491355&format=interactive",
  sheets_gid="1169731612",
  sql_file="lighthouse_unminified_js_by_3p.sql"
) }}

### 圧縮

縮小化はファイルサイズの削減に役立つ優れた方法ですが、圧縮はさらに効果的であり、それゆえより重要です。

{{ figure_markup(
  image="compression-method-request.png",
  caption="圧縮方法別のJavaScriptリクエストの割合の分布。",
  description="圧縮方式別のJavaScriptリクエストの割合の分布を示す棒グラフ。デスクトップとモバイルの値は非常によく似ています。JavaScriptリクエストの65%がGzip圧縮を使用しており、20%がbr(Brotli)圧縮を使用しており、15%が何の圧縮も使用しておらずdeflate、UTF-8、identityはどれも0%のようです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=263239275&format=interactive",
  sheets_gid="1270710983",
  sql_file="compression_method.sql"
) }}

すべてのJavaScriptリクエストの85%には、何らかのレベルのネットワーク圧縮が適用されています。Gzipがその大部分を占めており、スクリプトの65%にGzip圧縮が適用されているのに対し、Brotli(br)は20%です。Brotli（Gzipよりも効果が高い）の割合は、ブラウザのサポートに比べれば低いですが、正しい方向に向かっており、昨年より5%もポイント増加しています。

繰り返しになりますが、これはサードパーティ製スクリプトがファーストパーティ製スクリプトよりも実際にうまくいっている分野のようです。圧縮方法をファーストパーティスクリプトとサードパーティスクリプトで分けてみると、サードパーティスクリプトの24%がBrotliを適用しているのに対し、ファーストパーティスクリプトでは15%しか適用されていません。

{{ figure_markup(
  image="compression-method-3p.png",
  caption="モバイルJavaScriptリクエストの圧縮方法とホスト別の割合の分布。",
  description="モバイルJavaScriptリクエストの圧縮方法とホスト別の割合の分布を示す棒グラフ。ファーストパーティとサードパーティのJavaScriptリクエストの66%と64%がGzipを使用しています。ファーストパーティの15%とサードパーティのスクリプトのリクエストの24%がBrotliを使用しています。そして、ファーストパーティの19%とサードパーティスクリプトの12%は圧縮方法を設定していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1402692197&format=interactive",
  sheets_gid="564760060",
  sql_file="compression_method_by_3p.sql"
) }}

サードパーティ製のスクリプトは、圧縮を全く行わずに提供される可能性も低くなっています。サードパーティ製のスクリプトの12%がGzipもBrotliも適用されていないのに対し、ファーストパーティ製のスクリプトは19%です。

圧縮が適用されていないスクリプトをよく見てみる価値はあります。圧縮は、作業しなければならない内容が多いほど、節約の面で効率的になります。つまりファイルが極小であれば、ファイルを圧縮するためのコストが、ファイルサイズの極小化に勝るとも劣らないことがあります。

{{ figure_markup(
  caption="5KB未満のサードパーティ製JavaScriptの非圧縮リクエストの割合。",
  content="90.25%",
  classes="big-number",
  sheets_gid="347926930",
  sql_file="compression_none_by_bytes.sql"
) }}

ありがたいことに、特にサードパーティスクリプトでは、非圧縮スクリプトの90%が5KB未満のサイズであることが、まさにそれを示しています。一方、非圧縮のファーストパーティスクリプトの49%は5KB未満で、非圧縮のファーストパーティスクリプトの37%は10KBを超えています。このように、小さな非圧縮ファーストパーティ スクリプトが多く見られますが、ある程度圧縮することで恩恵を受けることができるものはまだかなりの数があります。

## 何を使うのか？

サイトやアプリケーションにJavaScriptを使用する機会が増えるにつれ、開発者の生産性やコードの保守性を向上させるためのオープンソースのライブラリやフレームワークへの需要も増えてきました。これらのツールを使用していないサイトは、今日のウェブでは少数派であることは間違いありません。

ウェブを構築するために使用するツールとそのトレードオフは何かを批判的に考えることが重要なので、現在使用されているものをよく見ることは理にかなっています。

### ライブラリ

HTTP Archiveは[Wappalyzer](./methodology#wappalyzer) を使用して、特定のページで使用されている技術を検出します。WappalazyerはJavaScriptライブラリ（jQueryのような開発を容易にするためのスニペットやヘルパー関数の集合体と考えてください）とJavaScriptフレームワーク（Reactのようなテンプレートや構造を提供する足場となる可能性が高いものです）の両方を追跡します。

使用されている人気のあるライブラリは昨年とほとんど変わっておらず、jQueryが引き続き圧倒的に使用されており、上位21のライブラリのうち1つだけが脱落しています（lazy.jsはDataTablesに置き換わっています）。実際、上位のライブラリの割合も昨年とほとんど変わっていません。

{{ figure_markup(
  image="frameworks-libraries.png",
  caption="ページに占めるトップJavaScriptフレームワークとライブラリの採用率。",
  description="トップフレームワークとライブラリの採用率をページの割合で示した棒グラフです（ページビューやnpmのダウンロードではありません）。jQueryは圧倒的なリーダーで、83%のモバイルページで発見されています。次いでjQuery migrateが30%、jQuery UIが21%、Modernizrが15%、FancyBoxが7%、SlickとLightboxが6%、残りのフレームワークやライブラリが4%、3%となっていてMoment.js、Underscore.js、Lodash、React、GSAP、Select2、RequireJS、prettyPhotoです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=419887153&format=interactive",
  sheets_gid="1654577118",
  sql_file="frameworks_libraries.sql"
) }}

昨年、[Houssein posited some reasons why jQuery's dominance continues](./2019/javascript#open-source-libraries-and-frameworks)を発表しました。

> 3割以上のサイトで利用されているWordPressには、デフォルトでjQueryが含まれています。
> アプリケーションの規模によってはjQueryから新しいクライアントサイドライブラリへの切り替えに時間がかかる場合があり、多くのサイトでは新しいクライアントサイドライブラリに加えてjQueryで構成されている場合があります。

どちらも非常に健全な推測であり、どちらのフロントでも状況はあまり変わっていないようです。

実際、上位10のライブラリのうち、jQuery UI、jQuery Migrate、FancyBox、Lightbox、Slickの6つがjQueryであるか、使用するためにjQueryを必要としていることを考えると、jQueryの優位性はさらに裏付けられています。

### フレームワーク

フレームワークを見てみると、昨年注目された主要なフレームワークでも、採用率という点であまり劇的な変化は見られません。Vue.jsは大幅に増加し、AMPは少し成長しましたが、ほとんどのフレームワークは1年前とほぼ同じ位置にあります。

昨年指摘された<a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">問題が今も適用されていることは注目に値し</a>、ここでも結果に影響を与えます。これらのツールの人気に大きな変化があった可能性はありますが、現在のデータ収集方法ではそれが見られないだけです。

### それが何を意味するのか

ツール自体の人気よりも面白いのは、作ったものにインパクトがあることです。

まず、1つのツール対1つのツールの使い方を考えても、実際には1つのライブラリやフレームワークだけを使って制作することはほとんどありません。分析されたページのうち、わずか21%のページが1つのライブラリまたはフレームワークのみを報告しています。フレームワークが2つ、3つというのはかなり一般的で、ロングテールはあっという間に長くなってしまいます。

制作現場でよく見かける組み合わせを見てみると、そのほとんどが予想通りの組み合わせになっています。jQueryの優位性を知っていれば、人気のある組み合わせのほとんどは、jQueryとjQuery関連のプラグインをいくらでも含んでいるのは当然のことです。

<figure>
  <table>
    <thead>
      <tr>
        <th>組み合わせ</th>
        <th>ページ数</th>
        <th>(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">1,312,601</td>
        <td class="numeric">20.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">658,628</td>
        <td class="numeric">10.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">289,074</td>
        <td class="numeric">4.6%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery</td>
        <td class="numeric">155,082</td>
        <td class="numeric">2.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">140,466</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate</td>
        <td class="numeric">85,296</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery</td>
        <td class="numeric">84,392</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Slick, jQuery</td>
        <td class="numeric">72,591</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>GSAP, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">61,935</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery UI</td>
        <td class="numeric">61,152</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery</td>
        <td class="numeric">60,395</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">53,924</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Slick, jQuery, jQuery Migrate</td>
        <td class="numeric">51,686</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery, jQuery Migrate</td>
        <td class="numeric">50,557</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery, jQuery UI</td>
        <td class="numeric">44,193</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>Modernizr, YUI</td>
        <td class="numeric">42,489</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td class="numeric">37,753</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Moment.js, jQuery</td>
        <td class="numeric">32,793</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery, jQuery Migrate</td>
        <td class="numeric">31,259</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>MooTools, jQuery, jQuery Migrate</td>
        <td class="numeric">28,795</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>
    {{ figure_link(
      caption="モバイルページでよく使われるライブラリやフレームワークの組み合わせ。",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

また、React、Vue、Angularなどの「モダン」なフレームワークがjQueryとペアリングされているのも、サードパーティによる移行や組み込みなどの結果として、かなりの量を目にすることがあります。

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">組み合わせ</th>
        <th scope="col">jQueryなし</th>
        <th scope="col">jQueryあり</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>GSAP, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">1.0%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0.4%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery, jQuery Migrate</td>
        <td>&nbsp;</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>Vue.js, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Vue.js</td>
        <td class="numeric">0.2%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>AngularJS, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>GSAP, Hammer.js, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">0.2%</td>
        <td>&nbsp;</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">合計</th>
        <th scope="col" class="numeric">1.7%</th>
        <th scope="col" class="numeric">1.4%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>
    {{ figure_link(
      caption="React、Angular、VueのjQueryの有無で最も人気のある組み合わせです。",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

さらに重要なことは、これらのツールはすべて、より多くのコードとより多くの処理時間を意味します。

使用されているフレームワークを具体的に見てみると、それらを使用しているページのJavaScriptのバイト数の中央値は、_what_が使用されているかによって大きく異なることがわかります。

以下のグラフは、最も一般的に検出されたフレームワークのトップ35のいずれかが検出されたページのバイト数の中央値をクライアント別に示しています。

{{ figure_markup(
  image="frameworks-bytes.png",
  caption="JavaScriptフレームワークごとの1ページあたりのJavaScriptのキロバイト数の中央値。",
  description="JavaScriptフレームワークの人気順に分解して、ページあたりのJavaScriptキロバイト数の中央値を示す棒グラフです。最もポピュラーなフレームワークであるReactは、モバイルページではJSの中央値が1,328となっています。RequireJSやAngularのような他のフレームワークは、1ページあたりのJSの中央値のバイト数が多い。MooTools、Prototype、AMP、RightJS、Alpine.js、Svelteを使用しているページは、モバイルページあたりの中央値が500KB未満です。Ember.jsは、モバイルページあたりのJSの中央値が約1,800KBの外れ値を持っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=955720480&format=interactive",
  sheets_gid="1206934500",
  width="600",
  height="835",
  sql_file="frameworks-bytes-by-framework.sql"
) }}

ReactやAngular、Emberのようなフレームワークは、クライアントに関係なく多くのコードを提供する傾向があります。一方、Alpine.jsやSvelteのようなミニマリストフレームワークは、非常に有望な結果を示しています。デフォルトは非常に重要で、パフォーマンスの高いデフォルトから始めることで、SvelteもAlpineも（今のところサンプルサイズはかなり小さいですが）軽いページを作ることに成功しているようです。

これらのツールが検出されたページのメインスレッドの時間を見ると、非常に似たような画像が得られます。

{{ figure_markup(
  image="frameworks-main-thread.png",
  caption="JavaScriptフレームワークによる1ページあたりのメインスレッド時間の中央値。",
  description="フレームワーク別のメインスレッド時間の中央値を示す棒グラフ。モバイルメインスレッド時間の中央値が20,000ミリ秒（20秒）を超えているEmber.js以外は気がつきにくいです。それに比べれば、他のフレームワークはちっぽけなものです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=691531699&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Emberのモバイルメインスレッドの時間が飛び出して、どれくらいの時間がかかるかでグラフが歪んでしまいます。（これについてもう少し時間をかけて調べてみましたが、Ember自体に根本的な問題があるというよりも、<a hreflang="en" href="https://timkadlec.com/remembers/2021-01-26-what-about-ember/">このフレームワークを非効率的に使用しているある特定のプラットフォームに大きく影響されている</a>ようです）。それを引き出すことで、絵が少し理解しやすくなります。

{{ figure_markup(
  image="frameworks-main-thread-no-ember.png",
  caption="Ember.jsを除くJavaScriptフレームワーク別の1ページあたりのメインスレッド時間の中央値。",
  description="Ember.jsを除くフレームワーク別のメインスレッド時間の中央値を示す棒グラフ。モバイルのメインスレッドの時間は、モバイル用に遅いCPU速度を使用するテスト方法を採用しているため、いずれも高くなっています。React、GSAP、RequireJSなどの最も人気のあるフレームワークのメインスレッド時間は、デスクトップでは2～3秒、モバイルでは5～7秒程度と高いです。Polymerも人気リストのさらに下の方に突出しています。MooToos、Prototype、Alpine.js、Svelteはメインスレッドの時間が2秒以下と低い傾向にあります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=77448759&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

ReactやGSAP、RequireJSなどのツールは、デスクトップやモバイルのページビューに関わらず、ブラウザのメインスレッドに多くの時間を費やす傾向があります。アルパインやスベルテのようなツールは、全体的にコードが少なくなる傾向はありますが、同じツールでもメインスレッドへの影響が少なくなる傾向はあります。

フレームワークがデスクトップとモバイルに提供する経験のギャップもまた、掘り下げる価値があります。モバイルトラフィックはますます支配的になってきており、私たちのツールがモバイルページビューに対して可能な限りのパフォーマンスを発揮することが重要です。フレームワークのデスクトップとモバイルのパフォーマンスのギャップが大きければ大きいほど、危険信号は大きくなります。

{{ figure_markup(
  image="frameworks-main-thread-no-ember-diff.png",
  caption="デスクトップとモバイルの1ページあたりのメインスレッド時間の中央値の差Ember.jsを除くJavaScriptフレームワーク別。",
  description="Ember.jsを除くJavaScriptフレームワーク別に、デスクトップとモバイルの1ページあたりのメインスレッド時間の中央値の絶対的な差と相対的な差を示す棒グラフです。Polymerは、デスクトップページよりもモバイルページの中央値のメインスレッドの時間が約5秒、250％遅いという高い差があるとして、人気リストの中では後に飛び出しています。他に目立ったフレームワークとしては、GSAPやRequireJSは4秒や150%の差があります。最も差が少ないフレームワークはMustacheとRxJSで、モバイルでは20～30%程度しか遅くなりません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1758266664&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

さすがに[エミュレートされたMoto G4](method#webpagetest)の処理能力が低いため、使用しているすべてのツールにギャップがあります。EmberとPolymerは特に忌まわしい例として飛び出ているように見えますが、RxJSやMustacheのようなツールはデスクトップとモバイルの間でわずかな違いしかありません。

## 何の影響があるの？

私たちは今JavaScriptをどのくらい使っているのか、どこから来ているのか、何のために使っているのか、かなり良い画像を持っています。それだけでも十分に興味深いのですが、本当のキッカケは「だから何？」このスクリプトが実際にページの体験にどのような影響を与えるのか？

まず最初に考えるべきことは、ダウンロードされたJavaScriptがどうなるかということです。ダウンロードはJavaScriptの旅の最初の部分に過ぎません。ブラウザはスクリプトをすべて解析してコンパイルし、最終的に実行しなければなりません。ブラウザはそのコストの一部を他のスレッドにオフロードする方法を常に模索していますが、その作業の多くは依然としてメインスレッドで行われており、ブラウザはレイアウトやペイント関連の作業を行うことができずユーザーのインタラクションに応答することもできません。

思い起こせば、モバイルデバイスに提供されるものとデスクトップデバイスに提供されるものの間には、わずか30KBの差しかありませんでした。考え方にもよりますが、デスクトップブラウザとモバイルブラウザに送信されるコードの量にわずかな差があることにあまり動揺しないということは許されるかもしれません。

最大の問題はそのコードがすべてローエンドからミドルエンドのデバイスへ提供されたときに生じるもので、ほとんどの開発者が持っている可能性のあるデバイスではなく、世界中の大多数の人が目にするであろうデバイスのようなものです。デスクトップとモバイルの間のこの比較的小さな差は、処理時間の面で見るとはるかに劇的です。

デスクトップサイトの中央値は、JavaScriptのすべての作業を行うブラウザのメインスレッドに891msを費やしています。しかし、モバイルサイトの中央値は1,897ミリ秒と、デスクトップの2倍以上の時間を費やしています。ロングテールのサイトの方がよっぽどヤバい。90パーセンタイルで、モバイルサイトではJavaScriptを扱うメインスレッドの時間が8,921ミリ秒であるのに対し、デスクトップサイトでは3,838ミリ秒であるという驚異的な結果が出ています。

{{ figure_markup(
  image="main-thread-time.png",
  caption="メインスレッドの時間配分。",
  description="デスクトップとモバイルのメインスレッド時間の分布を示す棒グラフ。モバイルの方が分布全体を通して2～3倍高くなっています。デスクトップの10、25、50、75、90パーセンタイルは137、356、891、1,988、3,838ミリ秒となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=740020507&format=interactive",
  sheets_gid="2039579122",
  sql_file="main_thread_time.sql"
) }}

### JavaScriptの利用とLighthouseのスコアリングの相関関係

これがどのようにユーザー体験に影響を与えるかを見る方法の1つとして、先に確認したJavaScriptのメトリクスのいくつかと、さまざまなメトリクスやカテゴリのLighthouseのスコアを関連付けることを試してみることがあります。

{{ figure_markup(
  image="correlations.png",
  caption="ユーザー体験の様々な側面におけるJavaScriptの相関関係。",
  description="ユーザー体験の様々な側面についてのピアソン相関係数を示す棒グラフ。Lighthouseのパフォーマンススコアとバイトの相関関係は-0.47です。バイトとLighthouseのアクセシビリティスコア：0.08。バイトと総ブロッキング時間（TBT）：0.55。サードパーティのバイトとLighthouseのパフォーマンススコア：-0.37。サードパーティのバイトとLighthouseのアクセシビリティスコア：0.00。サードパーティのバイトとTBT：0.48。1ページあたりの非同期スクリプト数とLighthouseのパフォーマンススコア：-0.19。非同期スクリプトとLighthouseのアクセシビリティスコア：0.08。非同期スクリプトとTBT：0.36。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=649523941&format=interactive",
  sheets_gid="2035770638",
  sql_file="correlations.sql"
) }}

上のグラフは[ピアソン相関係数](https://ja.wikipedia.org/wiki/%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0)を使用しています。正確には何を意味するのか、長くてちょっと複雑な定義がありますが、要は2つの異なる数字の間の相関の強さを探しているということです。係数が1.00だとすると、正の相関関係があることになります。0.00の相関関係は、2つの数字の間に何の関係もないことを示しています。0.00以下のものは、負の相関関係、つまり、ある数字が上がるともう1つの数字が下がることを示しています。

まず、JavaScriptのメトリクスとLighthouseのアクセシビリティ（チャートでは「LH A11y」）のスコアの間には、測定可能な相関関係はあまりないようです。これは、特に<a hreflang="en" href="https://webaim.org/projects/million/#frameworks">WebAimの年次調査</a>など、他の場所で発見されていることとは全く対照的です。

これについて最も可能性の高い説明は、Lighthouseのアクセシビリティテストが、WebAIMのようなアクセシビリティを主眼とした他のツールで利用可能なものほど包括的ではないということです（まだです！）。

強い相関関係が見られるのは、JavaScriptのバイト数（「バイト数」）とLighthouseの総合的なパフォーマンス（「LH Perf」）スコアと総ブロッキング時間（「TBT」）の間です。

JavaScriptのバイト数とLighthouseのパフォーマンススコアの相関関係は-0.47です。つまり、JSのバイト数が増えるとLighthouseのパフォーマンススコアは低下します。全体のバイト数は、サードパーティのバイト数（「3Pバイト」）よりも強い相関関係があります。

総ブロッキング時間とJavaScriptのバイト数の関係はさらに重要です (全体のバイト数では0.55、サードパーティのバイト数では0.48)。これは、ブラウザがページ内でJavaScriptを実行させるためにブラウザが行わなければならないすべての作業について知っていることを考えれば、それほど驚くべきことではありません。

### セキュリティの脆弱性

Lighthouseが実行するもう1つの有益な監査は、サードパーティのライブラリに既知のセキュリティ脆弱性がないかどうかをチェックすることです。これは、あるページでどのライブラリやフレームワークが使われているか、またそれぞれのバージョンを検出することで行います。次に、<a hreflang="en" href="https://snyk.io/vuln?type=npm">Snyk's open-source vulnerability database</a>をチェックして、特定されたツールにどのような脆弱性が発見されているかを確認します。

{{ figure_markup(
  caption="モバイルページの割合は、少なくとも1つの脆弱性のあるJavaScriptライブラリを含んでいます。",
  content="83.50%",
  classes="big-number",
  sheets_gid="1326928130",
  sql_file="lighthouse_vulnerabilities.sql"
) }}

監査によると、モバイルページの83.5％が、少なくとも1つの既知のセキュリティ脆弱性を持つJavaScriptのライブラリやフレームワークを使用しています。

これがjQuery効果と呼ばれるものです。jQueryが83%ものページで使用されていることを覚えていますか？　いくつかの古いバージョンのjQueryには既知の脆弱性が含まれており、この監査でチェックされる脆弱性の大部分を占めています。

約500万ほどのモバイルページのうち、81%に脆弱性のあるバージョンのjQueryが含まれており、2番目によく見られる脆弱性のあるライブラリjQuery UIの15.6%を大きく引き離しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ライブラリ</th>
        <th>脆弱なページ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">80.86%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">15.61%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">13.19%</td>
      </tr>
      <tr>
        <td>Lodash</td>
        <td class="numeric">4.90%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.61%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.38%</td>
      </tr>
      <tr>
        <td>AngularJS</td>
        <td class="numeric">1.26%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.77%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.53%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Lighthouseによると、脆弱性のあるモバイルページの数が最も多いことに貢献しているライブラリトップ10。",
      sheets_gid="1803013938",
      sql_file="lighthouse_vulnerable_libraries.sql"
    ) }}
  </figcaption>
</figure>

言い換えれば、時代遅れで脆弱性のあるバージョンのjQueryから人々を移行させることができれば、既知の脆弱性を持つサイトの数は激減するでしょう（少なくとも新しいフレームワークで脆弱性を見つけ始めるまでは）。

発見された脆弱性の大部分は、「中程度」の深刻度カテゴリに分類されます。

{{ figure_markup(
  image="vulnerabilities-by-severity.png",
  caption="JavaScriptの脆弱性を持つモバイルページの割合を深刻度別に分布。",
  description="円グラフでは、JavaScriptの脆弱性がないモバイルページは13.7％、深刻度の低い脆弱性が0.7％、深刻度が中程度の脆弱性が69.1％、深刻度の高い脆弱性が16.4％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1932740277&format=interactive",
  sheets_gid="1409147642",
  sql_file="lighthouse_vulnerabilities_by_severity.sql"
) }}

## 結論

JavaScriptの人気は着実に上昇しており、それはポジティブなことがたくさんあります。数年前には想像もできなかったようなことが、JavaScriptのおかげで今日のウェブ上でできるようになったことを考えると、信じられないことです。

しかし、私たちも慎重に行動しなければならないことは明らかです。JavaScriptの使用量は毎年一貫して増加しています（株式市場がこれほど予測可能であれば私たちは皆、信じられないほど裕福になっているでしょう）が、それにはトレードオフが伴います。JavaScriptの増加は処理時間の増加と関連しており、総ブロッキング時間のような主要な指標に悪影響を及ぼします。また、これらのライブラリを更新せずに放置しておくと、既知のセキュリティ上の脆弱性を利用してユーザーを危険にさらすことになります。

ページに追加するスクリプトのコストを慎重に検討しツールに批判的な目を向けて、より多くの質問をすることがアクセスしやすく、パフォーマンスが高く、安全なウェブを構築するための最善の策です。
