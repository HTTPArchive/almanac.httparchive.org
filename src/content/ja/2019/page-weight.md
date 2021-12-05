---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: ページの重さが重要な理由、帯域幅、複雑なページ、経時的なページの重み、ページ要求、およびファイル形式をカバーする2019 Web Almanacのページの重さの章。
authors: [tammyeverts, khempenius]
reviewers: [paulcalvano]
analysts: [khempenius]
editors: [obto]
translators: [ksakae1216]
discuss: 1773
results: https://docs.google.com/spreadsheets/d/1nWOo8efqDgzmA0wt1ipplziKhlReAxnVCW1HkjuFAxU/
tammyeverts_bio: Tammy Evertsは、20年以上にわたってユーザビリティとUXを研究してきました。過去10年間、彼女はウェブパフォーマンスとビジネスのUX交差に焦点を当ててきました。彼女は、<a hreflang="en" href="https://speedcurve.com/">SpeedCurve</a>のCXOであり、<a hreflang="en" href="https://perfnow.nl/">performance.now()カンファレンス</a>の共同議長であり、O'Reillyの本の著者<em><a hreflang="en" href="http://shop.oreilly.com/product/0636920041450.do">時は金なり。パフォーマンスのビジネス価値。</a></em>.
khempenius_bio: Katie HempeniusはChromeチームのエンジニアで、ウェブの高速化に取り組んでいます。
featured_quote: なぜページサイズはもう重要ではないのかという共通の議論は、高速インターネットとスープアップされたデバイスのおかげで、私たちは一般の人々に大規模で複雑な（そして大規模に複雑な）ページを提供することができるということです。この仮定は、あなたが言った高速インターネットとスープアップデバイスへのアクセスを持っていないインターネットユーザーの広大な範囲を無視して大丈夫だとしている限り、うまく動作します。
featured_stat_1: 10%
featured_stat_label_1: 6MB以上のデータを送信しているサイト
featured_stat_2: 434 KB
featured_stat_label_2: 昨年のデスクトップサイズ中央値の増加
featured_stat_3: 69
featured_stat_label_3: ホームページあたりのリクエストの中央値
---

## 序章

中央Webページのサイズは約1900KBで、74のリクエストが含まれています。悪くないですね。

ここに中央値の問題があります：それらは問題を隠します。定義上、それらは分布の中間にのみ焦点を合わせています。全体像を理解するには、両極端のパーセンタイルを考慮する必要があります。

90パーセンタイルを見ると、不快なものが明らかになります。疑いを持たない人々に向けてプッシュしているページのおよそ10％は6MBを超えており、179のリクエストが含まれています。これは、率直に言ってひどいです。もしあなたがひどくないと思うのであれば、間違いなくこの章を読む必要があります。

### 神話：ページサイズは関係ない

ページサイズが重要ではなくなった理由に関する一般的な論点は、高速インターネットと強化されたデバイスのおかげで、大規模で複雑な（そして非常に複雑な）ページを一般の人々に提供できるということです。この仮定は、高速インターネットや強化されたデバイスでアクセスできない巨大なインターネットユーザー層を無視しても問題ない限り、うまく機能します。

はい。一部のユーザーにとっては、高速で堅牢なページを構築できます。ただし、すべてのユーザー、特に帯域幅の制約やデータ制限へ対処するモバイル専用ユーザーにどのように影響するかという観点からページの肥大化に注意する必要があります。

<p class="note" data-markdown="1">Tim Kadlecの魅力的なオンライン計算機、[What Does My Site Cost?]（https://whatdoesmysitecost.com/）をチェックしてください。これは、世界中の国のページのコスト（1人あたりのドルと国民総所得）を計算します。それは目を見張るものです。たとえば、執筆時点で2.79MBのAmazonのホームページの費用は、モーリタニアの1人当たりGNIの1日あたり1.89％です。世界のいくつかの地域の人々が数十ページを訪問するだけで一日の賃金をあきらめなければならないとき、ワールドワイドウェブはどれほどグローバルなのでしょうか？</p>

### 帯域幅を増やすことは、Webパフォーマンスの魔法の弾丸ではありません

より多くの人がより良いデバイスとより安価な接続にアクセスできたとしても、それは完全なソリューションではありません。帯域幅を2倍にしても、2倍速くなるわけではありません。実際、帯域幅を最大1,233％増やすと、ページが55％速くなるだけであることが<a hreflang="en" href="https://developer.akamai.com/blog/2015/06/09/heres-why-more-bandwidth-isnt-magic-bullet-web-performance">実証</a>されています。

問題は遅延です。私たちのネットワークプロトコルのほとんどは、多くの往復を必要とし、それらの各往復は遅延ペナルティを課します。遅延がパフォーマンスの問題である限り（つまり、近い将来）パフォーマンスの主な原因は、今日の典型的なWebページには数十の異なるサーバーでホストされている100程度のアセットが含まれていることです。これらのアセットの多くは、最適化されておらず、測定と監視がされていないため予測不能です。

### HTTP Archiveはどのような種類のアセットを追跡し、どの程度の重要性を持ちますか？

HTTP Archiveが追跡するページ構成メトリックの簡単な用語集と、パフォーマンスとユーザーエクスペリエンスの観点から重要なメトリックを以下に示します。

- **合計サイズ**は、ページのバイト単位の合計重量です。特に、限られたデータや測定データがあるモバイルユーザーにとって重要です。

- 通常、**HTML**はページ上の最小のリソースです。そのパフォーマンスリスクはごくわずかです。

- 多くの場合、最適化されていない**画像**がページの肥大化の最大の原因です。ページの重さの分布の90パーセンタイルを見ると、約7MBのページの5.2MBを画像が占めています。つまり画像は総ページ重量のほぼ75％を占めます。そして、それだけでは不十分な場合、ページ上の画像の数は、小売サイトでのコンバージョン率の低下につながります（これについては後で詳しく説明します）。

- **JavaScript**が重要です。ページのJavaScriptの重さは比較的小さい場合がありますが、それでもJavaScriptによるパフォーマンスの問題が生じます。単一の100KBのサードパーティスクリプトでさえ、ページに大損害を与える可能性があります。ページ上のスクリプトが多いほど、リスクは大きくなります。

  JavaScriptのブロックだけに集中するだけでは十分でありません。 JavaScriptのレンダリング方法により、ページにブロッキングリソースが含まれていなくても、パフォーマンスが最適とは言えない可能性があります。 JavaScriptが他のすべてのブラウザーアクティビティを組み合わせた場合よりも多くのCPUを消費するため、ページ上のCPU使用率を理解することが非常に重要です。 JavaScriptがCPUをブロックしますてる間、ブラウザーはユーザー入力に応答できません。これにより、一般に「ジャンク」と呼ばれるものが作成されます。これは不安定なページレンダリングの不快な感覚です。

- **CSS**は、現代のWebページにとって信じられないほどの恩恵です。ブラウザの互換性から設計の保守と更新まで、無数の設計上の問題を解決します。 CSSがなければ、レスポンシブデザインのような素晴らしいものはありません。しかし、JavaScriptのように、CSSは問題を引き起こすためにかさばる必要はありません。スタイルシートの実行が不十分な場合、ダウンロードと解析に時間がかかりすぎるスタイルシート、ページの残りの部分のレンダリングをブロックする不適切に配置されたスタイルシートに至るまで、パフォーマンスの問題が多数発生する可能性はあります。またJavaScriptと同様にCSSファイルが多くなると潜在的な問題が発生します。

### 大きくて複雑なページはビジネスに悪い場合があります

あなたが、あなたのサイト訪問者を気にしない心無いモンスターでないと仮定しましょう。しかしあなたがそうであれば、より大きく、より複雑なページを提供することもあなたを傷つけることを知っておくべきです。これは、小売サイトから100万以上のビーコンに相当する実際のユーザーデータを収集した<a hreflang="en" href="https://www.thinkwithgoogle.com/marketing-resources/experience-design/mobile-page-speed-load-time/">Google主導の機械学習</a>の調査結果の1つでした。

この研究から、3つの重要なポイントがありました。

1. **ページ上の要素の総数は、コンバージョンの最大の予測因子でした。** 最新のWebページを構成するさまざまなアセットによって課されるパフォーマンスリスクについて説明したことを考えると、これが大きな驚きにならないことを願っています。

2. ページ上の画像の数は、コンバージョンの2番目に大きな予測因子でした。ユーザーが変換したセッションでは、変換しなかったセッションよりも画像が38％少なくなりました。

{{ figure_markup(
  image="ch18_fig1_conversion_difference.png",
  caption="変換されたセッションと変換されないセッション。",
  description="19の変換済みセッションと31の非変換セッションを示すグラフ",
  width=600,
  height=432
  )
}}

3. **スクリプトが多いセッションは、変換される可能性が低くなりました。** このグラフで本当に魅力的なのは、約240個のスクリプトを実行した後の変換確率の急激な低下だけではありません。最大1,440個のスクリプトが含まれる小売セッションの数を示すのはロングテールです！

{{ figure_markup(
  image="ch18_fig2_conversion_graph.jpg",
  caption="スクリプトが増加すると変換率は低下します。",
  description="変換率が80スクリプトまで上昇し、その後スクリプトが1440スクリプトまで増加すると低下することを示すグラフ。",
  width=600,
  height=336
  )
}}

ページサイズと複雑さが重要である理由について説明したので、Webの現在の状態とページの肥大化の影響をよりよく理解できるように、ジューシーなHTTP Archiveの統計を見てみましょう。

## 分析

このセクションの統計はすべて、ページとそのリソースの転送サイズに基づいています。 Web上のすべてのリソースが送信前に圧縮されるわけではありませんが、圧縮されている場合、この分析では圧縮サイズが使用されます。

### ページの重さ

大まかに言って、モバイルサイトはデスクトップの対応サイトよりも約10％小さくなっています。違いの大部分は、モバイルサイトが対応するデスクトップよりも少ない画像バイトを読み込んでいるためです。

#### モバイル

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>合計 (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>画像 (KB)</th>
      <th>ドキュメント (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>6226</td>
      <td>107</td>
      <td>1060</td>
      <td>234</td>
      <td>4746</td>
      <td>49</td>
    </tr>
    <tr>
      <td>75</td>
      <td>3431</td>
      <td>56</td>
      <td>668</td>
      <td>122</td>
      <td>2270</td>
      <td>25</td>
    </tr>
    <tr>
      <td>50</td>
      <td>1745</td>
      <td>26</td>
      <td>360</td>
      <td>56</td>
      <td>893</td>
      <td>13</td>
    </tr>
    <tr>
      <td>25</td>
      <td>800</td>
      <td>11</td>
      <td>164</td>
      <td>22</td>
      <td>266</td>
      <td>7</td>
    </tr>
    <tr>
      <td>10</td>
      <td>318</td>
      <td>6</td>
      <td>65</td>
      <td>5</td>
      <td>59</td>
      <td>4</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別のモバイルのページウェイト。") }}</figcaption>
</figure>

#### デスクトップ

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>合計 (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>画像 (KB)</th>
      <th>ドキュメント (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>6945</td>
      <td>110</td>
      <td>1131</td>
      <td>240</td>
      <td>5220</td>
      <td>52</td>
    </tr>
    <tr>
      <td>75</td>
      <td>3774</td>
      <td>58</td>
      <td>721</td>
      <td>129</td>
      <td>2434</td>
      <td>26</td>
    </tr>
    <tr>
      <td>50</td>
      <td>1934</td>
      <td>27</td>
      <td>391</td>
      <td>62</td>
      <td>983</td>
      <td>14</td>
    </tr>
    <tr>
      <td>25</td>
      <td>924</td>
      <td>12</td>
      <td>186</td>
      <td>26</td>
      <td>319</td>
      <td>8</td>
    </tr>
    <tr>
      <td>10</td>
      <td>397</td>
      <td>6</td>
      <td>76</td>
      <td>8</td>
      <td>78</td>
      <td>4</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別に分類されたデスクトップ上のページの重み") }}</figcaption>
</figure>

### 時間と共に変化するページの重さ

過去1年間に、デスクトップサイトのサイズの中央値は434KB増加し、モバイルサイトのサイズの中央値は179KB増加しました。画像はこの増加を圧倒的に促進しています。

#### モバイル

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>合計 (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>画像 (KB)</th>
      <th>ドキュメント (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>+376</td>
      <td>-50</td>
      <td>+46</td>
      <td>+36</td>
      <td>+648</td>
      <td>+2</td>
    </tr>
    <tr>
      <td>75</td>
      <td>+304</td>
      <td>-7</td>
      <td>+34</td>
      <td>+21</td>
      <td>+281</td>
      <td>0</td>
    </tr>
    <tr>
      <td>50</td>
      <td>+179</td>
      <td>-1</td>
      <td>+27</td>
      <td>+10</td>
      <td>+106</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>+110</td>
      <td>-1</td>
      <td>+16</td>
      <td>+5</td>
      <td>+36</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>+72</td>
      <td>0</td>
      <td>+13</td>
      <td>+2</td>
      <td>+20</td>
      <td>+1</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="2018年以降のモバイルページのウェイトの変化。") }}</figcaption>
</figure>

#### デスクトップ

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>合計 (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>画像 (KB)</th>
      <th>ドキュメント (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>+1106</td>
      <td>-75</td>
      <td>+22</td>
      <td>+45</td>
      <td>+1291</td>
      <td>+5</td>
    </tr>
    <tr>
      <td>75</td>
      <td>+795</td>
      <td>-12</td>
      <td>+9</td>
      <td>+32</td>
      <td>+686</td>
      <td>+1</td>
    </tr>
    <tr>
      <td>50</td>
      <td>+434</td>
      <td>-1</td>
      <td>+10</td>
      <td>+15</td>
      <td>+336</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>+237</td>
      <td>0</td>
      <td>+12</td>
      <td>+7</td>
      <td>+138</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>+120</td>
      <td>0</td>
      <td>+10</td>
      <td>+2</td>
      <td>+39</td>
      <td>+1</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="2018年以降のデスクトップページの重みの変化。") }}</figcaption>
</figure>

ページの重さが時間とともにどのように変化するかについての長期的な視点については、HTTP Archiveから<a hreflang="en" href="https://httparchive.org/reports/page-weight#bytesTotal">この時系列グラフ</a>をご覧ください。ページサイズの中央値は、HTTP Archiveが2010年11月にこのメトリックの追跡を開始して以来ほぼ一定の割合で成長しており、過去1年間に見られたページウェイトの増加はこれと一致しています。

### ページリクエスト

デスクトップページの中央値は74リクエストで、モバイルページの中央値は69リクエストです。これらのリクエストの大部分は画像とJavaScriptアカウントです。昨年、リクエストの量や分布に大きな変化はありませんでした。

#### モバイル

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>合計 (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>画像 (KB)</th>
      <th>ドキュメント (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>168</td>
      <td>15</td>
      <td>52</td>
      <td>20</td>
      <td>79</td>
      <td>7</td>
    </tr>
    <tr>
      <td>75</td>
      <td>111</td>
      <td>7</td>
      <td>32</td>
      <td>12</td>
      <td>49</td>
      <td>2</td>
    </tr>
    <tr>
      <td>50</td>
      <td>69</td>
      <td>3</td>
      <td>18</td>
      <td>6</td>
      <td>28</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>40</td>
      <td>2</td>
      <td>9</td>
      <td>3</td>
      <td>15</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>22</td>
      <td>1</td>
      <td>4</td>
      <td>1</td>
      <td>7</td>
      <td>0</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別に分類されたモバイルページリクエスト。") }}</figcaption>
</figure>

#### デスクトップ

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>合計 (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>画像 (KB)</th>
      <th>ドキュメント (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>179</td>
      <td>14</td>
      <td>53</td>
      <td>20</td>
      <td>90</td>
      <td>6</td>
    </tr>
    <tr>
      <td>75</td>
      <td>118</td>
      <td>7</td>
      <td>33</td>
      <td>12</td>
      <td>54</td>
      <td>2</td>
    </tr>
    <tr>
      <td>50</td>
      <td>74</td>
      <td>4</td>
      <td>19</td>
      <td>6</td>
      <td>31</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>44</td>
      <td>2</td>
      <td>10</td>
      <td>3</td>
      <td>16</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>24</td>
      <td>1</td>
      <td>4</td>
      <td>1</td>
      <td>7</td>
      <td>0</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別に分類されたデスクトップページリクエスト。") }}</figcaption>
</figure>

### ファイル形式

前述の分析では、リソースタイプのレンズを通してページの重さを分析することに焦点を当ててきました。ただし、画像とメディアの場合、特定のファイル形式間のリソースサイズの違いを調べて、さらに深く掘り下げることができます。

#### 画像形式によるファイルサイズ（モバイル）

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>GIF (KB)</th>
      <th>ICO (KB)</th>
      <th>JPG (KB)</th>
      <th>PNG (KB)</th>
      <th>SVG (KB)</th>
      <th>WEBP (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0</td>
      <td>0</td>
      <td>3.08</td>
      <td>0.37</td>
      <td>0.25</td>
      <td>2.54</td>
    </tr>
    <tr>
      <td>25</td>
      <td>0.03</td>
      <td>0.26</td>
      <td>7.96</td>
      <td>1.14</td>
      <td>0.43</td>
      <td>4.89</td>
    <tr>
      <td>50</td>
      <td>0.04</td>
      <td>1.12</td>
      <td>21</td>
      <td>4.31</td>
      <td>0.88</td>
      <td>13</td>
    </tr>
    <tr>
      <td>75</td>
      <td>0.06</td>
      <td>2.72</td>
      <td>63</td>
      <td>22</td>
      <td>2.41</td>
      <td>33</td>
    </tr>
    <tr>
      <td>90</td>
      <td>2.65</td>
      <td>13</td>
      <td>155</td>
      <td>90</td>
      <td>7.91</td>
      <td>78</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="モバイルの画像ファイルサイズを画像形式別に分類したもの。") }}</figcaption>
</figure>

これらの結果の一部、特にGIFの結果は、本当に驚くべきものです。 GIFが非常に小さい場合、なぜそれらはJPG、PNG、およびWEBPなどの形式に置き換えられるのですか？

上記のデータは、Web上のGIFの大部分が実際には小さな1×1ピクセルであるという事実を覆い隠しています。これらのピクセルは通常「トラッキングピクセル」として使用されますが、さまざまなCSS効果を生成するためのハックとしても使用できます。これらの1×1ピクセルは文字通りのイメージですが、その使用の精神はおそらくスクリプトまたはCSSに関連付けるものと近いでしょう。

データセットをさらに調査すると、GIFの62％が43バイト以下（43バイトは透明な1×1ピクセルGIFのサイズ）であり、GIFの84％は1KB以下であることが明らかになりました。

{{ figure_markup(
  image="ch18_fig3_gif_cdf.png",
  caption="GIFファイルサイズの累積分布関数。",
  description="GIFの25％が35バイト以下（1x1ホワイトGIFの最適サイズ）であり、GIFの62％が43バイト以下（1x1透明GIFの最適サイズ）であることを示すグラフ。これは、GIFの75％を100バイト以下に増やすだけです。",
  width=600,
  height=330
  )
}}

以下の表は、これらの小さな画像をデータセットから削除するための2つの異なるアプローチを示しています。最初の方法は、ファイルサイズが100バイトを超える画像に基づいており、2番目はファイルサイズが1024バイトを超える画像に基づいています。

#### 画像の画像形式ごとのファイルサイズ> 100バイト

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>GIF (KB)</th>
      <th>ICO (KB)</th>
      <th>JPG (KB)</th>
      <th>PNG (KB)</th>
      <th>SVG (KB)</th>
      <th>WEBP (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0.27</td>
      <td>0.31</td>
      <td>3.08</td>
      <td>0.4</td>
      <td>0.28</td>
      <td>2.1</td>
    </tr>
    <tr>
      <td>25</td>
      <td>0.75</td>
      <td>0.6</td>
      <td>7.7</td>
      <td>1.17</td>
      <td>0.46</td>
      <td>4.4</td>
    </tr>
    <tr>
      <td>50</td>
      <td>2.14</td>
      <td>1.12</td>
      <td>20.47</td>
      <td>4.35</td>
      <td>0.95</td>
      <td>11.54</td>
    </tr>
    <tr>
      <td>75</td>
      <td>7.34</td>
      <td>4.19</td>
      <td>61.13</td>
      <td>21.39</td>
      <td>2.67</td>
      <td>31.21</td>
    </tr>
    <tr>
      <td>90</td>
      <td>35</td>
      <td>14.73</td>
      <td>155.46</td>
      <td>91.02</td>
      <td>8.26</td>
      <td>76.43</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="100バイトを超える画像の画像形式ごとのファイルサイズ。") }}</figcaption>
</figure>

#### 画像の画像形式ごとのファイルサイズ > 1024バイト

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>GIF (KB)</th>
      <th>ICO (KB)</th>
      <th>JPG (KB)</th>
      <th>PNG (KB)</th>
      <th>SVG (KB)</th>
      <th>WEBP (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>1.28</td>
      <td>1.12</td>
      <td>3.4</td>
      <td>1.5</td>
      <td>1.2</td>
      <td>3.08</td>
    </tr>
    <tr>
      <td>25</td>
      <td>1.9</td>
      <td>1.12</td>
      <td>8.21</td>
      <td>2.88</td>
      <td>1.52</td>
      <td>5</td>
    </tr>
    <tr>
      <td>50</td>
      <td>4.01</td>
      <td>2.49</td>
      <td>21.19</td>
      <td>8.33</td>
      <td>2.81</td>
      <td>12.52</td>
    </tr>
    <tr>
      <td>75</td>
      <td>11.92</td>
      <td>7.87</td>
      <td>62.54</td>
      <td>33.17</td>
      <td>6.88</td>
      <td>32.83</td>
    </tr>
    <tr>
      <td>90</td>
      <td>67.15</td>
      <td>22.13</td>
      <td>157.96</td>
      <td>127.15</td>
      <td>19.06</td>
      <td>79.53</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="1024バイトを超える画像の画像形式ごとのファイルサイズ。") }}</figcaption>
</figure>

JPEG画像に比べてPNG画像のファイルサイズが小さいことは驚くべきことです。 JPEGは[非可逆圧縮](https://ja.wikipedia.org/wiki/%E9%9D%9E%E5%8F%AF%E9%80%86%E5%9C%A7%E7%B8%AE)を使用します。非可逆圧縮によりデータが失われるため、ファイルサイズを小さくできます。一方、PNGは[可逆圧縮](https://ja.wikipedia.org/wiki/%E5%8F%AF%E9%80%86%E5%9C%A7%E7%B8%AE)を使用します。これによりデータが失われることはありません。これにより、より高品質で大きな画像が生成されます。ただし、このファイルサイズの違いはエンコーディングと圧縮の違いではなく、透過性のサポートによるアイコンのグラフィックのPNGの人気を反映している可能性があります。

#### メディア形式ごとのファイルサイズ

MP4は、今日のWebで圧倒的に最も人気のあるビデオ形式です。人気の点では、それぞれWebMとMPEG-TSが続きます。

このデータセットの他のテーブルの一部とは異なり、このテーブルにはほとんど満足のいく結果があります。動画はモバイルでは常に小さく表示されるのですばらしいです。さらに、MP4ビデオのサイズの中央値は、モバイルでは18KB、デスクトップでは39KBと非常に合理的です。 WebMの数値の中央値はさらに優れていますが、一度見てください。複数のクライアントとパーセンタイルでの0.29KBの重複測定は少し疑わしいです。考えられる説明の1つは、非常に小さなWebMビデオの同一のコピーが多くのページに含まれていることです。 3つの形式のうち、MPEG-TSは常にすべてのパーセンタイルで最高のファイルサイズを持っています。これは1995年にリリースされたという事実に関連している可能性があり、これらの3つのメディア形式の中で最も古いものになっています。

##### モバイル

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>MP4 (KB)</th>
      <th>WebM (KB)</th>
      <th>MPEG-TS (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0.89</td>
      <td>0.29</td>
      <td>0.01</td>
    </tr>
    <tr>
      <td>25</td>
      <td>2.07</td>
      <td>0.29</td>
      <td>55</td>
    </tr>
    <tr>
      <td>50</td>
      <td>18</td>
      <td>1.44</td>
      <td>153</td>
    </tr>
    <tr>
      <td>75</td>
      <td>202</td>
      <td>223</td>
      <td>278</td>
    </tr>
    <tr>
      <td>90</td>
      <td>928</td>
      <td>390</td>
      <td>475</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="モバイルのメディア形式によるビデオサイズ。") }}</figcaption>
</figure>

##### デスクトップ

<figure>
  <table>
    <tr>
      <th>パーセンタイル</th>
      <th>MP4 (KB)</th>
      <th>WebM (KB)</th>
      <th>MPEG-TS (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0.27</td>
      <td>0.29</td>
      <td>34</td>
    </tr>
    <tr>
      <td>25</td>
      <td>1.05</td>
      <td>0.29</td>
      <td>121</td>
    </tr>
    <tr>
      <td>50</td>
      <td>39</td>
      <td>17</td>
      <td>286</td>
    </tr>
    <tr>
      <td>75</td>
      <td>514</td>
      <td>288</td>
      <td>476</td>
    </tr>
    <tr>
      <td>90</td>
      <td>2142</td>
      <td>896</td>
      <td>756</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="デスクトップ上のメディア形式によるビデオサイズ。") }}</figcaption>
</figure>

## 結論

過去1年間で、ページのサイズは約10％増加しました。 Brotli、パフォーマンスバジェット、および基本的な画像最適化のベストプラクティスは、おそらくページウェイトを維持または改善すると同時に広く適用可能で実装が非常に簡単な3つのテクニックです。そうは言っても、近年ではページの重さの改善は、テクノロジー自体よりもベストプラクティスの採用が少ないことにより制約されています。言い換えれば、ページの重さを改善するための多くの既存のテクニックがありますが、それらが使用されなければ違いはありません。
