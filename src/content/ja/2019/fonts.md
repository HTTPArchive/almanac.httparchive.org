---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: フォント
description: フォントがどこから読み込まれるか、フォントのフォーマット、フォントの読み込み性能、可変フォント、カラーフォントを網羅した2019年Web AlmanacのFontsの章。
authors: [zachleat]
reviewers: [hyperpress, AymenLoukil]
analysts: [tjmonsi, rviscomi]
editors: [tunetheweb]
translators: [ksakae]
discuss: 1761
results: https://docs.google.com/spreadsheets/d/108g6LXdC3YVsxmX1CCwrmpZ3-DmbB8G_wwgQHX5pn6Q/
zachleat_bio: Zachは<a hreflang="en" href="https://www.filamentgroup.com/">Filament Group</a>のWeb開発者だ。彼は現在、<a hreflang="en" href="https://www.zachleat.com/web/fonts/">web fonts</a>と<a hreflang="en" href="https://www.zachleat.com/web/introducing-eleventy/">static site generators</a>に夢中だ。彼の<a hreflang="en" href="https://www.zachleat.com/web/speaking/">講演履歴</a>には、JAMstack_conf、Beyond Tellerrand、Smashing Conference、CSSConf、そして<a hreflang="en" href="https://www.zachleat.com/web/whitehouse/">The White House</a>のようなイベントでの8カ国での講演が含まれています。また、<a hreflang="en" href="http://nejsconf.com/">NEJS CONF</a>や<a hreflang="en" href="http://nebraskajs.com">NebraskaJS</a>のミートアップも手伝っている。
featured_quote: ウェブフォントは、ウェブ上で美しく機能的なタイポグラフィを可能にします。ウェブフォントを使用することは、デザインに力を与えるだけでなく、デザインのサブセットを民主化します。しかし、どんなに良いことがあっても、ウェブフォントが適切に読み込まれていないと、サイトのパフォーマンスに大きな悪影響を及ぼすこともあります。
featured_stat_1: 74.9%
featured_stat_label_1: 3P Googleフォントを使用したフォントリクエスト
featured_stat_2: 29%
featured_stat_label_2: Google Fontsスタイルシートのリンクを含むページの割合
featured_stat_3: 718
featured_stat_label_3: 1ページでのフォントのリクエストが多い
---

## 序章

ウェブフォントは、ウェブ上で美しく機能的なタイポグラフィを可能にします。ウェブフォントを使用することは、デザインに力を与えるだけでなく、デザインのサブセットを民主化します。しかし、どんなに良いことがあってもウェブフォントが適切に読み込まれていないと、サイトのパフォーマンスに大きな悪影響を及ぼすこともあります。

それらはウェブにとってプラスになるのか？　それらは害よりも多くの利益を提供しているか?　Web標準の牛道は、デフォルトでWebフォントの読み込みのベストプラクティスを奨励するために十分に舗装されているだろうか？　そうでない場合、何を変える必要があるのでしょうか？　今日のウェブ上でウェブフォントがどのように使用されているかを調べることで、これらの疑問に答えられるかどうかをデータ駆動型で覗いてみましょう。

## そのウェブフォントはどこで手に入れたの？

最初の、そして最も顕著な問題は、パフォーマンスです。[パフォーマンス](./performance)に特化した章がありますが、ここではフォント固有のパフォーマンスの問題について少し掘り下げてみましょう。

ホストされたWebフォントを使用すると、実装やメンテナンスが容易になりますが、セルフホスティングは最高のパフォーマンスを提供します。Webフォントはデフォルトで、Webフォントの読み込み中にテキストを非表示にする（<a hreflang="en" href="https://css-tricks.com/fout-foit-foft/">Flash of Invisible Text</a>、またはFOITとしても知られています）ことを考えると、Webフォントのパフォーマンスは画像のような非ブロッキング資産よりも重要になる可能性があります。

### フォントは同じホストでホストされているのか、それとも別のホストでホストされているのか？

サードパーティのホスティングに対するセルフホスティングの差別化は、[HTTP/2](./http)の世界ではますます重要になってきています。同一ホストのリクエストには、ウォーターフォール内の他の同一ホストのリクエストに対して優先順位をつける可能性が高いという大きな利点があります。

別のホストからウェブフォントを読み込む際のパフォーマンスコストを軽減するための推奨事項としては、`preconnect`、`dns-prefetch`、`preload` [リソースのヒント](./resource-hints)の使用がありますが、優先度の高いウェブフォントは、ウェブフォントのパフォーマンスへの影響を最小限に抑えるため、同一ホストからのリクエストにすべきです。これは視覚的に、非常に目立つコンテンツやページの大部分を占める本文コピーで使用されるフォントへ対して特に重要です。

{{ figure_markup(
  image="fig1.png",
  caption="人気のあるウェブフォントのホスティング戦略。font hosting strategies.",
  description="ウェブフォントのサードパーティおよびセルフホスティング戦略の人気を示す棒グラフ。モバイルWebページの75%がサードパーティ製ホストを使用し、25%がセルフホストを使用しています。デスクトップのウェブサイトでも、同様の利用状況です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1546332659&format=interactive"
  )
}}

4分の3がホストされているという事実は、おそらく我々が議論するGoogle Fontsの優位性を考えると意外と知られていません[以下](#最も人気のあるサードパーティ製のホストは何ですか？)。

Googleは`https://fonts.googleapis.com`でホストされているサードパーティのCSSファイルを使ってフォントを提供しています。開発者は、マークアップの`<link>`タグを使ってこれらのスタイルシートにリクエストを追加します。これらのスタイルシートはレンダーブロッキングされていますが、そのサイズは非常に小さいです。しかし、フォントファイルは`https://fonts.gstatic.com`という別のドメインでホストされています。2つの異なるドメインへの2つの別々のホップを必要とするモデルでは、CSSがダウンロードされるまで発見されない2つ目のリクエストには`preconnect`が最適な選択肢となります。

`preload`はリクエストのウォーターフォールの上位にフォントファイルをロードするための素晴らしい追加機能ですが（`preconnect`は接続を設定するもので、ファイルの内容をリクエストするものではないことを覚えておいてください）、`preload`はGoogle Fontsではまだ利用できません。Google Fontsはフォントファイル用のユニークなURLを生成します<a hreflang="en" href="https://github.com/google/fonts/issues/1067">これは変更される可能性があります</a>。

### 最も人気のあるサードパーティ製のホストは何ですか？

<figure>
  <table>
    <thead>
      <tr>
        <th>ホスト</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>fonts.gstatic.com</td>
        <td class="numeric">75.4%</td>
        <td class="numeric">74.9%</td>
      </tr>
      <tr>
        <td>use.typekit.net</td>
        <td class="numeric">7.2%</td>
        <td class="numeric">6.6%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>use.fontawesome.com</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>static.parastorage.com</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>fonts.shopifycdn.com</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>use.typekit.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>netdna.bootstrapcdn.com</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>fast.fonts.net</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>static.dealer.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>themes.googleusercontent.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>static-v.tawk.to</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>stc.utdstc.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>kit-free.fontawesome.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>open.scdn.co</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>assets.squarespace.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>fonts.jimstatic.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リクエストの割合による上位20のフォントホスト。") }}</figcaption>
</figure>

ここでのGoogle Fontsの優位性は、同時に驚くべきことであると同時に意外性のないものであった。期待していたという点では予想外でしたが、サービスの圧倒的な人気の高さには驚きました。フォントリクエストの75％というのは驚異的だ。TypeKitは一桁台の遠い2位で、Bootstrapライブラリがさらに遠い3位を占めていました。

{{ figure_markup(
  caption="ドキュメント内にGoogle Fontsスタイルシートのリンクを含むページの割合 <code><head></code> 。",
  content="29%",
  classes="big-number"
)
}}

ここでのGoogle Fontsの使用率の高さは非常に印象的だが、Google Fonts`<link>`要素を含むページが29％しかなかったことも注目に値する。これはいくつかのことを意味しているかもしれない。

- ページがGoogle Fontsを使用する場合、彼らはGoogle Fontsを多く使用しています。それらは結局のところ、金銭的なコストなしで提供されています。おそらく、人気のあるWYSIWYGエディタで使われているのではないでしょうか？　これは非常に可能性の高い説明のように思えます。
- あるいは、もっとありそうにない話としては、多くの人が`<link>`の代わりに`@import`を使ってGoogle Fontsを使っているということかもしれません。
- あるいは、超ありえないシナリオにまで踏み込んでみたいのであれば、多くの人が代わりに[HTTP `Link:`ヘッダー](https://developer.mozilla.org/ja/docs/Web/HTTP)を使ってGoogle Fontsを使っているということになるかもしれません。

{{ figure_markup(
  caption="ドキュメントの最初の子としてGoogle Fontsスタイルシートのリンクを含むページの割合 <code><head></code>。",
  content="0.4%",
  classes="big-number"
)
}}

Google Fontsのドキュメントでは、Google Fonts CSSの`<link>`はページの`<head>`の最初の子として配置することを推奨しています。これは大きなお願いです！　実際、これは一般的でありません。全ページの半分のパーセント（約20,000ページ）しかこのアドバイスを受けていないので、これは一般的でありません。

さらに言えば、ページが`preconnect`や`dns-prefetch`を`<link>`要素として使用している場合、これらはいずれにしてもGoogle Fonts CSSの前へ来ることになります。これらのリソースのヒントについては、続きを読んでください。

### サードパーティホスティングの高速化

上述したように、サードパーティホストへのウェブフォント要求を高速化する超簡単な方法は、`preconnect`[リソースヒント](./resource-hints)を使用することです。

{{ figure_markup(
  caption="モバイルページがウェブフォントホストにプリコネクティングしている割合。",
  content="1.7%",
  classes="big-number"
)
}}

うわー！　2％未満のページが<a hreflang="en" href="https://web.dev/uses-rel-preconnect">`preconnect`</a>を使用している！　Google Fontsが75％であることを考えると、これはもっと高いはずです！　開発者の皆さん: Google Fontsを使うなら、`preconnect`を使いましょう！　Google Fonts:`preconnect`をもっと宣伝しよう！

実際、もしあなたがGoogle Fontsを使っているのであれば、`<head>`にこれを追加してください。

```html
<link rel="preconnect" href="https://fonts.gstatic.com/">
```

### 最も人気のある書体

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>フォントファミリー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Open Sans</td>
        <td class="numeric">24%</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Roboto</td>
        <td class="numeric">15%</td>
        <td class="numeric">19%</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>Montserrat</td>
        <td class="numeric">5%</td>
        <td class="numeric">4%</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>Source Sans Pro</td>
        <td class="numeric">4%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>Noto Sans JP</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td class="numeric">6</td>
        <td>Lato</td>
        <td class="numeric">3%</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td class="numeric">7</td>
        <td>Nanum Gothic</td>
        <td class="numeric">4%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td class="numeric">8</td>
        <td>Noto Sans KR</td>
        <td class="numeric">3%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td class="numeric">9</td>
        <td>Roboto Condensed</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td class="numeric">10</td>
        <td>Raleway</td>
        <td class="numeric">2%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td class="numeric">11</td>
        <td>FontAwesome</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">12</td>
        <td>Roboto Slab</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">13</td>
        <td>Noto Sans TC</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">14</td>
        <td>Poppins</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">15</td>
        <td>Ubuntu</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">16</td>
        <td>Oswald</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">17</td>
        <td>Merriweather</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">18</td>
        <td>PT Sans</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">19</td>
        <td>Playfair Display</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td class="numeric">20</td>
        <td>Noto Sans</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="全フォント宣言に占める上位20のフォントファミリーの割合。") }}</figcaption>
</figure>

ここでの上位のエントリが<a hreflang="en" href="https://fonts.google.com/?sort=popularity">Google Fontsの人気順フォント一覧</a>と非常によく似ていることは驚くに値しません。

## どのようなフォント形式を使用していますか？

今日のブラウザでは<a hreflang="en" href="https://caniuse.com/#feat=woff2">WOFF2はかなりサポートされています</a>。Google FontsはWOFF2というフォーマットを提供していますが、これは前身のWOFFよりも圧縮率が向上したフォーマットで、それ自体はすでに他の既存のフォントフォーマットよりも改善されていました。

{{ figure_markup(
  image="fig7.png",
  caption="ウェブフォントのMIMEタイプの普及率",
  description="ウェブフォントのMIMEタイプの人気を示す棒グラフ。フォントの74%でWOFF2が使用されており、次いでWOFFが13%、octet-streamが 6%、TTFが3%、plainが2%、HTMLが1%、SFNTが1%、その他のすべてのタイプが1%未満となっています。デスクトップとモバイルでは、同様の分布となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=998584594&format=interactive"
  )
}}

私から見れば、ここでの結果を見て、WebフォントはWOFF2オンリーにした方がいいという意見もあるかもしれません。二桁台のWOFF使用率はどこから来ているのでしょうか？　もしかして、まだWebフォントをInternet Explorerに提供している開発者がいるのでしょうか？

第3位の`octet-stream`(およびもう少し下の`plain`)は、多くのウェブサーバが不適切に設定されており、ウェブフォントファイルのリクエストで誤ったMIMEタイプを送信していることを示唆しているように見えます。

もう少し深く掘り下げて、`@font-face`宣言の`src:`プロパティで使われている`format()`の値を見てみましょう。

{{ figure_markup(
  image="fig8.png",
  caption="<code>@font-face</code> 宣言におけるフォントフォーマットの人気度。",
  description="フォントフェイス宣言で使用されるフォーマットの人気を示す棒グラフ。デスクトップページの@font-face宣言の 69%がWOFF2形式を指定しており、11%がWOFF、10%がTrueType、8%がSVG、2%がEOT、1%未満でOpenType、TTF、OTFを指定しています。モバイルページの分布も同様です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=700778025&format=interactive"
  )
}}

<a hreflang="en" href="https://caniuse.com/#feat=svg-fonts">SVGフォント</a>が衰退しているのを見て期待していたのですが。バグだらけだし、Safari以外のブラウザでは実装が削除されている。そろそろ捨ててしまおうか。

ここのSVGデータポイントを見ると、どのMIMEタイプでSVGフォントを提供しているのか気になります。図6.7のどこにも`image/svg+xml`は見当たりません。とにかく、それを修正することは気にしないで、ただそれらを取り除くだけです！

### WOFF2専用

<figure>
  <table>
    <thead>
      <tr>
        <th>ランク</th>
        <th>フォーマットの組み合わせ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>woff2</td>
        <td class="numeric">84.0%</td>
        <td class="numeric">81.9%</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>svg, truetype, woff</td>
        <td class="numeric">4.3%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>svg, truetype, woff, woff2</td>
        <td class="numeric">3.5%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>eot, svg, truetype, woff</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">2.9%</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>woff, woff2</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td class="numeric">6</td>
        <td>eot, svg, truetype, woff, woff2</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td class="numeric">7</td>
        <td>truetype, woff</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td class="numeric">8</td>
        <td>woff</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td class="numeric">9</td>
        <td>truetype</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td class="numeric">10</td>
        <td>truetype, woff, woff2</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td class="numeric">11</td>
        <td>opentype, woff, woff2</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">12</td>
        <td>svg</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">13</td>
        <td>eot, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">14</td>
        <td>opentype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">15</td>
        <td>opentype</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">16</td>
        <td>eot</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">17</td>
        <td>opentype, svg, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">18</td>
        <td>opentype, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">19</td>
        <td>eot, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">20</td>
        <td>svg, woff</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="フォントフォーマットの組み合わせトップ20") }}</figcaption>
</figure>

このデータセットは、大多数の人がすでに`@font-face`ブロックでWOFF2のみを使っていることを示唆しているように見える。しかし、このデータセットにおけるGoogle Fontsの優位性についての以前の議論によれば、もちろんこれは誤解を招くものです。Google Fontsは合理化されたCSSファイルを提供するためにいくつかのスニッフィングメソッドを実行しており、最新の`format()`のみを含んでいる。当然のことながら、WOFF2がここでの結果を支配しているのはこの理由によるもので、WOFF2に対するブラウザのサポートは以前からかなり広くなっている。

重要なのは、この特定のデータはまだWOFF2オンリーのケースを支持しているわけではないということですが、魅力的なアイデアであることに変わりはありません。

## 見えない文字との戦い

デフォルトのWebフォントの読み込み動作である「読み込み中は見えない」(FOITとしても知られています)に対抗するため持っている第一のツールは`font-display`です。`font-display: swap`を`@font-face`ブロックに追加すると、ウェブフォントが読み込まれている間にフォールバックテキストを表示するようにブラウザに指示する簡単な方法です。

<a hreflang="en" href="https://caniuse.com/#feat=mdn-css_at-rules_font-face_font-display">ブラウザ対応</a>もいいですね。Internet ExplorerやChromium以前のEdgeではサポートされていませんが、Webフォントが読み込まれたときにデフォルトでフォールバックテキストをレンダリングしてくれます（ここではFOITは使えません）。Chromeのテストでは、`font-display`はどのくらいの頻度で使われているのでしょうか？

{{ figure_markup(
  caption="<code>font-display</code> スタイルを利用しているモバイルページの割合。",
  content="26%",
  classes="big-number"
)
}}

私はこれが時間の経過とともに忍び寄ってくることを想定しています、特に今は<a hreflang="en" href="https://www.zachleat.com/web/google-fonts-display/">Google Fontsがすべての新しいコードスニペットに `font-display` を追加しています</a>が彼らのサイトからコピーされています。

Google Fontsを使っているなら、スニペットを更新しよう！　Google Fontsを使っていない場合は、`font-display`を使いましょう！　`font-display`についての詳細は [MDN](https://developer.mozilla.org/ja/docs/Web/CSS/@font-face/font-display) を参照してください。

どのような`font-display`値が人気あるのか見てみましょう。

{{ figure_markup(
  image="fig11.png",
  caption="<code>font-display</code> の値の使用法。",
  description="フォント表示スタイルの利用状況を示す棒グラフ。モバイルページの2.6％がこのスタイルを「swap」、1.5％が「auto」、0.7％が「block」、0.4％が「fallback」、0.2％が「optional」、0.1％が引用符で囲んだ「swap」に設定しているが、これは無効である。デスクトップの分布は、「swap」の利用率が0.4％ポイント低く、「auto」の利用率が0.1％ポイント高くなっている以外は似ている。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1988783738&format=interactive"
  )
}}

ウェブフォントの読み込み中にフォールバックテキストを表示する簡単な方法として、`font-display: swap`が最も一般的な値として君臨しています。`swap`は新しいGoogle Fontsのコードスニペットでもデフォルト値として使われています。いくつかの著名な開発者のエバンジェリストがこれを求めてちょっとした働きかけをしていたので、ここでは`optional`(キャッシュされた場合にのみレンダリングする)がもう少し使われることを期待していたのですが、駄目でした。

## ウェブフォントの数が多すぎる？

ある程度のニュアンスが必要な質問です。フォントはどのように使われているのか？　ページ上のコンテンツの量は？　そのコンテンツはレイアウトのどこにあるのか？　フォントはどのようにレンダリングされているのか？　しかし、ニュアンスの代わりに、リクエスト数を中心とした大まかで重い分析に飛び込んでみましょう。

{{ figure_markup(
  image="fig12.png",
  caption="ページあたりのフォント要求の分布。",
  description="ページごとのフォント要求の分布を示す棒グラフ。デスクトップでの10、25、50、75、90パーセンタイルは以下の通りです。0、1、3、6、9のフォント要求があります。モバイルの分布は75パーセンタイルと90パーセンタイルまでは同じで、モバイルページでは要求されるフォントが1つ少なくなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=451821825&format=interactive"
  )
}}

中央値のウェブページでは、3つのウェブフォントをリクエストしています。90パーセンタイルでは、モバイルとデスクトップでそれぞれ6つと9つのウェブフォントをリクエストしています。

{{ figure_markup(
  image="fig13.png",
  caption="ページあたりに要求されたウェブフォントのヒストグラム。",
  description="ページあたりのフォントリクエスト数の分布を示すヒストグラム。最も人気のあるフォントリクエスト数は0で、デスクトップページの22%を占めています。この分布は、1つのフォントを持つページの9%まで落ち込み、2～4つのフォントでは10%で頂点に達し、フォント数が増えるにつれて落ち込んでいきます。デスクトップとモバイルの分布は似ていますが、モバイルの分布はページあたりのフォント数が少ない方にわずかに傾いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1755200484&format=interactive"
  )
}}

Webフォントのリクエストがデスクトップとモバイルの間でかなり安定しているように見えるというのは非常に興味深いことです。私は、<a hreflang="en" href="https://css-tricks.com/snippets/css/using-font-face/#article-header-id-6">`@media`クエリの中の`@font-face`ブロックを隠すことを推奨すること</a>が流行らなかったのを見てうれしく思います (何も考えないでください)。

しかし、モバイルデバイスでのフォントのリクエストはわずかに多い。ここでの私の勘は、モバイルデバイスで利用できる書体が少ないということはGoogle Fonts CSSでの`local()`のヒット数が少ないということであり、ネットワークからのフォントリクエストに戻ってしまうのではないかと考えています。

### この賞を受賞したくない

{{ figure_markup(
  caption="1ページで最も多くのWebフォントのリクエストがあった。",
  content="718",
  classes="big-number"
)
}}

最も多くのウェブフォントをリクエストしたページの賞は、**718**のウェブフォントをリクエストしたサイトに贈られます！

コードに飛び込んだ後、それらの718のリクエストのすべてがGoogle Fontsに向かっています！　どうやらWordPress用の「ページの折り返しの上に」最適化プラグインが誤作動して、このサイトで不正を行い、すべてのGoogle Fonts-oopsにリクエストしている（DDoS-ing？）。

パフォーマンス最適化プラグインは、あなたのパフォーマンスをはるかに悪化させることができることを皮肉っています！

## `Unicode-range`を使うとより正確なマッチングが可能になります

{{ figure_markup(
  caption="<code>unicode-range</code> プロパティでWebフォントを宣言しているモバイルページの割合。",
  content="56%",
  classes="big-number"
)
}}

[`unicode-range`](https://developer.mozilla.org/ja/docs/Web/CSS/@font-face/unicode-range)は、ブラウザに、ページがフォントファイルで使用したいコードポイントを具体的に知らせるための優れたCSSプロパティです。`@font-face`宣言に`unicode-range`がある場合、ページ上のコンテンツは、フォントが要求される前に、その範囲内のコードポイントのいずれかにマッチしなければなりません。これは非常に良いことです。

Google FontsはそのCSSのほとんど（すべてではないにしても）で`unicode-range`を使用しているので、これもGoogle Fontsの使用状況によって偏っていると予想される指標です。ユーザーの世界でこれはあまり一般的でないと思いますが、Web Almanacの次の版ではGoogle Fontsのリクエストをフィルタリングして除外することが可能かもしれません。

## システムフォントが存在する場合、ウェブフォントを要求しないようにする

{{ figure_markup(
  caption="<code>local()</code> プロパティでWebフォントを宣言しているモバイルページの割合。",
  content="59%",
  classes="big-number"
)
}}

`local()`は`@font-face`、`src`のシステムフォントを参照するための良い方法です。もし `local()`フォントが存在するならば、ウェブフォントを要求する必要は全くありません。これはGoogle Fontsによって広く使われており、論争の的にもなっているのでユーザの土地からパターンを得ようとしているのであれば、これも歪んだデータの一例になるでしょう。

ここでは、私よりも賢い人々(TypeKitのBram Stein氏) が、<a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">インストールされているフォントのバージョンが古くて信頼性は低い場合があるため、`local()`を使うことは予測不可能である可能性がある</a>と述べていることにも注目しておきましょう。

## 縮約されたフォントと`font-stretch`

{{ figure_markup(
  caption="<code>font-stretch</code> プロパティを持つスタイルを含むデスクトップページとモバイルページの割合。",
  content="7%",
  classes="big-number"
)
}}

歴史的に、`font-stretch`はブラウザのサポートが悪く、よく知られた`@font-face`プロパティではありませんでした。詳しくは[MDNの`font-stretch`について](https://developer.mozilla.org/ja/docs/Web/CSS/font-stretch) を参照してください。しかし、<a hreflang="en" href="https://caniuse.com/#feat=css-font-stretch">ブラウザのサポート</a>は広がっています。

小さいビューポートで凝縮されたフォントを使用することで、より多くのテキストを表示できるようになることが示唆されていますが、このアプローチは一般的には使用されていません。とはいえ、このプロパティがモバイルよりもデスクトップで半パーセントポイント多く使われているというのは予想外で、7％というのは私が予想していたよりもはるかに高いと思えます。

## 可変フォントは未来のもの

[可変フォント](https://developer.mozilla.org/ja/docs/Web/CSS/CSS_Fonts/Variable_Fonts_Guide)では、1つのフォントファイルに複数のフォントの太さやスタイルを含めることができます。

{{ figure_markup(
  caption="可変フォントを含むページの割合",
  content="1.8%",
  classes="big-number"
)
}}

1.8％でさえ、これは予想よりも高かったが、これがうまくいくのを見て興奮している。<a hreflang="en" href="https://developers.google.com/fonts/docs/css2">Google Fonts v2</a>には可変フォントのサポートがいくつか含まれています。

{{ figure_markup(
  image="fig19.png",
  caption="<code>font-variation-settings</code> 軸の使用法。",
  description="font-variation-settingsプロパティの使用状況を示す棒グラフ。デスクトップページのプロパティの42%が`opsz`の値に設定されており、32%が`wght`、16%が`wdth`、2%以下が`roun`、`crsb`、`slnt`、`inln`などに設定されています。デスクトップページとモバイルページで顕著な違いは、`opsz`の使用率が26％、`wght`の使用率が38％、`wdth`の使用率が23％となっており、`wght`の使用率は、`wght`の使用率と`wght`の使用率の差が大きい。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=699343351&format=interactive"
  )
}}

この大規模なデータセットのレンズを通して見ると、これらの結果は非常に低いサンプルサイズであることがわかります。しかし、デスクトップページで最も一般的な軸として`opsz`が注目され、`wght`と`wdth`が後に続く。私の経験では、可変フォントの入門デモはたいていウェイトベースです。

## カラーフォントも未来かも？

{{ figure_markup(
  caption="カラーフォントを含むデスクトップウェブページの数。",
  content="117",
  classes="big-number"
)
}}

これらのここでの使用法は基本的に存在しませんが、詳細については<a hreflang="en" href="https://www.colorfonts.wtf/">カラーフォント！　WTF?</a>という優れたリソースをチェックできます。フォント用のSVGフォーマット(これは良くないし消えていく)に似ていますが(全くそうではありません)、これを使うとOpenTypeファイルの中にSVGを埋め込むことができ、これは素晴らしくクールです。

## 結論

ここでの最大の収穫は、Google Fontsがウェブフォントの議論を支配しているということだ。彼らが取ったアプローチは、ここで記録したデータに大きく影響している。ここでのポジティブな点はウェブフォントへのアクセスが容易であること、優れたフォントフォーマット（WOFF2）であること、そして自由な`unicode範囲`の設定が可能であることだ。ここでの欠点はサードパーティのホスティング、異なるホストからのリクエスト、および`preload`にアクセスできないことでパフォーマンスが低下することです。

私は、将来的には「バリアブルフォントの台頭」を見ることになるだろうと完全に予想しています。バリアブルフォントは複数の個々のフォントファイルを1つの合成フォントファイルに結合するので、これはウェブフォントのリクエストの減少と対になっているはずです。しかし歴史が示しているように、ここで通常起こることは、あるものを最適化してその空所を埋めるためにさらに多くのものを追加してしまうことです。

カラーフォントの人気が高まるかどうかは非常に興味深いところです。私は、これらは可変フォントよりもはるかにニッチなものになると予想していますが、アイコンフォントのスペースに生命線を見ることができるかもしれません。

フォントを凍らせるなよ。
