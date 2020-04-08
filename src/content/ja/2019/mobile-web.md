---
part_number: II
chapter_number: 12
title: モバイルウェブ
description: 2019年Web年鑑のモバイルWebの章では、ページの読み込み、テキストコンテンツ、拡大縮小、ボタンやリンク、フォームへの記入のしやすさなどをカバーしています。
authors: [obto]
reviewers: [AymenLoukil, hyperpress]
translators: [ksakae]
discuss: 1767
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-23T00:00:00.000Z
---

## 序章Introduction

2007年に少し戻ってみましょう。「モバイルウェブ」は現在、レーダー上ではほんの一瞬の出来事に過ぎませんが、それには正当な理由があります。なぜでしょうか？　モバイルブラウザはCSSをほとんどサポートしていないため、サイトの見た目がデスクトップとは全く異なります。画面は信じられないほど小さく、一度に数行のテキストしか表示できません。また、マウスの代わりとなるのは、「タブを使って移動する」ための小さな矢印キーです。言うまでもなく、携帯電話でウェブを閲覧することは本当に愛の労働です。 しかし、このすべてをちょうど変更しようとしている。

プレゼンの途中、スティーブ・ジョブズは発表されたばかりのiPhoneを手にして座り、それまで夢見ていた方法でウェブサーフィンを始めます。大きな画面とフル機能のブラウザで、ウェブサイトをフルに表示します。そして最も重要なことは、人間に知られている最も直感的なポインターデバイスを使ってウェブサーフィンをすることです：私たちの指。小さな矢印キーを使って、これ以上のタブ操作はありません。

2007年以降、モバイルウェブは爆発的な成長を遂げました。そして13年後の現在、2019年7月の[Akamai mPulse](https://developer.akamai.com/akamai-mpulse-real-user-monitoring-solution)のデータによると、モバイルは[全検索の 59%](https://www.merkleinc.com/thought-leadership/digital-marketing-report)と全ウェブトラフィックの58.7％を占めています。モバイルはもはや余計なものでなく、人々がウェブを体験する主要な方法となっています。モバイルの重要性を考えると、私たちは訪問者にどのような体験を提供しているのでしょうか？　どこが不足しているのか？　それを探ってみましょう。

## ページの読み込み体験

私たちが分析したモバイルウェブ体験の最初の部分は、私たちが最も身近に感じているものです。*ページの読み込み体験*です。しかし、今回の調査結果へ飛び込む前に、典型的なモバイルユーザーが*実際に*どのようなユーザーであるかについて全員が同じ見解を持っていることを確認しておきましょう。これは、これらの結果を再現するのに役立つだけでなく、これらのユーザーをよりよく理解することにもつながるからです。

まずは、典型的なモバイルユーザーがどのような電話を持っているかから始めましょう。平均的なAndroid携帯電話[価格は～250ドル](https://web.archive.org/web/20190921115844/https://www.idc.com/getdoc.jsp?containerId=prUS45115119)で、その範囲内の[最も人気のある携帯電話](https://web.archive.org/web/20190812221233/https://deviceatlas.com/blog/most-popular-android-smartphones)の1つは、サムスンのギャラクシーS6です。だから、これはおそらく典型的なモバイルユーザーが使用している携帯電話の種類であり、実際にはiPhone 8よりも4倍遅いです。このユーザーは、高速な4G接続へのアクセス権を持っていませんが、むしろ2G接続（[29%](https://www.gsma.com/r/mobileeconomy/)時間の）または3G接続（[28%](https://www.gsma.com/r/mobileeconomy/)時間の）を使用しています。そして、これが全ての足し算になります。

<figure>
<table>
  <tr>
    <th>Connection type</th>
    <td><a href="https://www.gsma.com/r/mobileeconomy/">2G or 3G</a></td>
  </tr>
  <tr>
    <th>Latency</th>
    <td>300 - 400ms</td>
  </tr>
  <tr>
    <th>Bandwidth</th>
    <td>0.4 - 1.6Mbps</td>
  </tr>
  <tr>
    <th>Phone</th>
    <td><a href="https://www.gsmarena.com/samsung_galaxy_s6-6849.php">Galaxy S6</a> — <a href="https://www.notebookcheck.net/A11-Bionic-vs-7420-Octa_9250_6662.247596.0.html">4x slower</a> than iPhone 8 (Octane V2 score)</td>
  </tr>
</table>
<figcaption>図1. 典型的なモバイルユーザーの技術的プロフィール。</figcaption>
</figure>

この結果に驚かれる方もいらっしゃると思います。あなたがこれまでにサイトをテストしたことのある条件よりも、はるかに悪い条件かもしれません。しかし、モバイルユーザーが本当にどのようなものなのかということについては、今はみんな同じページにいるのでさっそく始めてみましょう。

### JavaScriptで肥大化したページ

モバイルウェブのJavaScriptの状態が恐ろしい。HTTP Archiveの [JavaScript レポート](https://httparchive.org/reports/state-of-javascript?start=2016_05_15&end=2019_07_01&view=list#bytesJs)によると、モバイルサイトの中央値では、携帯電話が375KBのJavaScriptをダウンロードする必要があります。圧縮率を70％と仮定すると、携帯電話は中央値で1.25MBのJavaScriptを解析、コンパイル、実行しなければならないことになります。

なぜこれが問題なのでしょうか？　なぜなら、これだけの量のJSをロードしているサイトは、インタラクティブになるまでに[10秒](https://httparchive.org/reports/loading-speed?start=earliest&end=2019_07_01&view=list#ttci)以上かかるからです。言い換えれば、ページは完全に読み込まれているように見えるかもしれませんが、ユーザーがボタンやメニューをクリックしてもJavaScriptの実行が終了していないため、何も起こりません。ユーザーは、実際に何かが起こる魔法のような瞬間を待つために、10秒以上もボタンをクリックし続けなければなりません。それがどれほど混乱し、イライラさせるかを考えてみてください。

<figure>
  <iframe class="fig-mobile fig-desktop" width="560" height="315" src="https://www.youtube.com/embed/Lx1cYJAVnzA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption>図2. JS がロードされるのを待つのがいかに苦痛であるかの例。</figcaption>
</figure>

さらに深く掘り下げて、各ページがJavaScriptをどの程度利用しているかに焦点を当てた別の指標を見てみましょう。例えば、読み込み中のページは本当に多くのJavaScriptを必要としているのでしょうか？　私たちはこの指標を[Web bloat score](https://www.webbloatscore.com/)に基づいた*JavaScript Bloat Score*と呼んでいます。その背後にある考え方は次のようなものです。

- JavaScriptは、ページの読み込みに合わせて生成と変更の両方を行うためによく使われます。
- また、ブラウザにテキストとして配信されます。そのため、よく圧縮され、ただのページのスクリーンショットよりも速く配信されるはずです。
- そのため、ページがダウンロードするJavaScriptの総量がビューポートのPNGスクリーンショットよりも多い場合（画像やCSSなどを含まない）、私たちはあまりにも多くのJavaScriptを使用していることになります。この時点では、スクリーンショットを送信してページの初期状態を取得した方が早いでしょう!

<p class="note">*JavaScript Bloat Score*は以下のように定義されています。(JavaScriptの総サイズ)/(ビューポートのPNGスクリーンショットのサイズ)で定義されます。1.0より大きい数値は、スクリーンショットを送信するのが速いことを意味します。</p>

その結果は？　分析した500万以上のウェブサイトのうち75.52％がJavaScriptで肥大化していました。まだまだ先は長いですね。

分析した500万以上のサイトすべてのスクリーンショットをキャプチャして測定できなかったことに注意してください。代わりに、1000のサイトからランダムにサンプリングして、ビューポートのスクリーンショットサイズの中央値（140KB）を見つけ各サイトのJavaScriptダウンロードサイズをこの数値と比較しました。

JavaScriptの効果をもっと詳しく知りたい方は、Addy Osmaniの[The Cost of JavaScript in 2018](https://medium.com/@addyosmani/the-cost-of-javascript-in-2018-7d8950fbb5d4)をチェックしてみてください。

### サービスワーカーの使い方

ブラウザは通常、すべてのページを同じように読み込みます。いくつかのリソースのダウンロードを他のリソースよりも優先したり、同じキャッシュルールに従ったりします。[サービスワーカー](https://developers.google.com/web/fundamentals/primers/service-workers)のおかげで、リソースがネットワーク層によってどのように処理されるかを直接制御できるようになりました。

2016年から利用可能になり、すべての主要ブラウザに実装されているにもかかわらず、利用しているサイトはわずか0.64％にとどまっています!

### 読み込み中にコンテンツを移動する

ウェブの最も美しい部分の1つは、ウェブページのロードが自然と進んでいくことです。ブラウザはできる限り早くコンテンツをダウンロードして表示するため、ユーザーはできるだけ早くあなたのコンテンツに引き込む事ができます。しかし、このことを念頭に置いてサイトを設計しないと、悪影響を及ぼす可能性があります。具体的には、リソースのロードに合わせてコンテンツの位置がずれることで、ユーザー体験の妨げになることがあります。

<figure>
  <a href="/static/images/2019/mobile-web/example-of-a-site-shifting-content-while-it-loads-lookzook.gif">
    <img src="/static/images/2019/mobile-web/example-of-a-site-shifting-content-while-it-loads-lookzook.gif" alt="図3. シフト内容が読者の気を散らす例 CLS合計42.59％。画像提供：LookZook" aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="360" height="640">
  </a>
  <div id="fig3-description" class="visually-hidden">Webサイトの読み込みが進んでいく様子を動画で紹介しています。テキストは素早く表示されますが、画像が読み込まれ続けると、テキストはページの下にどんどん移動していき、読むのに非常にイライラします。この例の計算されたCLSは42.59%です。画像提供：LookZook</div>
  <figcaption id="fig3-caption">図3. シフト内容が読者の気を散らす例 CLS合計42.59％。画像提供：LookZook</figcaption>
</figure>

あなたが記事を読んでいるときに突然、画像が読み込まれ、読んでいるテキストが画面の下に押し出されたと想像してみてください。あなたは今、あなたがいた場所を探すか、ちょうど記事を読むことをあきらめなければなりません。または、おそらくさらに悪いことに、同じ場所に広告がロードされる直前にリンクをクリックし始め、代わりに広告を誤ってクリックしてしまうことになります。

では、どのようにしてサイトの移動量を測定するのでしょうか？　以前はかなり困難でしたが（不可能ではないにしても）、新しい [レイアウトの不安定性API](https://web.dev/layout-instability-api) のおかげで、2ステップで測定を行うことができます。

1. レイアウトの不安定性APIを使用して、各シフトがページに与える影響を追跡します。これは、ビューポート内のコンテンツがどれだけ移動したかのパーセンテージとして報告されます。

2. あなたが追跡したすべてのシフトを取り、それらを一緒に追加します。その結果が [累積レイアウトシフト](https://web.dev/layout-instability-api#a-cumulative-layout-shift-score)(CLS)スコアと呼ばれるものです。

訪問者ごとに異なるCLSを持つことができるため、[Chrome UX Report](./methodology#chrome-UX-report) (./methodology#chrome-UX-report)(CrUX)を使用してウェブ全体でこのメトリックを分析するために、すべての体験を3つの異なるバケットにまとめています。

- **Small**CLSを持っている方。CLSが*5%未満*になった経験あり。つまり、ページはほとんど安定していて、まったくズレないということです。参考までに、上の動画のページのCLSは42.59％です。
- **Large**CLSを持っている方。CLSが*100%以上*ある経験。これは小さな個別シフトが多い場合と、大きく目立つシフトが多い場合の2つあります。
- **Medium** CLSを持っている方。SmallとLargeの間にあるもの。

では、ウェブをまたいでCLSを見ると、何が見えてくるのでしょうか？

1. 3サイトに2サイト近く（65.32％）が、全ユーザー体験の50％以上を占めるMediumかLargeCLSを持っています。

2. 20.52％のサイトでは、全ユーザー体験の少なくとも半分がLargeCLSを持っています。これは、約5つのウェブサイトの1つに相当します。図3の動画のCLSは42.59％に過ぎないことを覚えておいてください - これらの体験はそれよりもさらに悪いのです。

この原因の多くは広告や画像など、テキストが画面にペイントされた後、読み込まれるリソースの幅や高さをウェブサイトが明示的に提供していないことにあるのではないかと考えられています。ブラウザがリソースを画面に表示する前、そのリソースがどのくらいのスペースを占めるかを知る必要があります。そのため、CSSやHTML属性でサイズが明示的に指定されていない限り、ブラウザはリソースが実際にどのくらいの大きさなのかを知ることができず、読み込まれるまでは幅と高さを0pxにして表示します。リソースが読み込まれ、ブラウザがリソースの大きさをようやく知ると、ページの内容がずれるため、不安定なレイアウトになってしまいます。

### パーミッションリクエスト

ここ数年、ウェブサイトと「アプリストア」アプリの境界線が曖昧になり続けています。今でもユーザーのマイク、ビデオカメラ、ジオロケーション、通知を表示する機能などへのアクセスを要求する機能があります。

これは開発者にとってさらに多くの機能を開放していますが、これらのパーミッションを不必要に要求するとユーザーがあなたのウェブページを警戒していると感じたままになり、不信感を抱くことになりかねません。これは私たちが常に「私の近くの劇場を探す」ボタンをタップするようなユーザーのジェスチャーにパーミッションリクエストを結びつけることをお勧めする理由です。

現在、1.52％のサイトがユーザーとの対話なしに許可を要求しています。このような低い数字を見ると励みになります。しかし、我々はホームページのみを分析できたことに注意することが重要です。そのため、例えば、コンテンツページ（例えばブログ記事）のみにパーミッションを要求しているサイトは考慮されていませんでした。詳細については、[方法論](./methodology)のページを参照してください。

## テキストの内容

ウェブページの第一の目標は、ユーザーが興味を持ってくれるコンテンツを配信することです。このコンテンツは、YouTubeのビデオや画像の詰め合わせかもしれませんが、多くの場合、ページ上のテキストだけかもしれません。テキストコンテンツが訪問者にとって読みやすいものであることが非常に重要であることは言うまでもありません。なぜなら、訪問者が読めなければ何も残っておらず、離脱してしまうからです。テキストが読みやすいかどうかを確認するには、色のコントラストとフォントサイズの2つが重要です。

### カラーコントラスト

サイトをデザインするとき、私たちは最適な状態で、多くの訪問者よりもはるかに優れた目を持っている傾向があります。訪問者は色盲で、テキストと背景色の区別をできない場合があります。ヨーロッパ系の人は、[男性の12人に1人、女性の200人に1人](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf)が色盲です。あるいは、太陽の光が画面にまぶしさを与えている間にページを読んでいる可能性があり、同様に読みやすさが損なわれている可能性があります。

この問題を軽減するために、テキストや背景色を選択する際に従うことのできる[アクセシビリティ・ガイドライン](https://dequeuniversity.com/rules/axe/2.2/color-contrast)があります。では、これらの基準を満たすにはどうすればよいのでしょうか？　すべてのテキストに十分な色のコントラストを与えているサイトは22.04％にすぎません。この値は実際には下限値であり、背景が無地のテキストのみを分析したためです。画像やグラデーションの背景は分析できませんでした。

<figure>
  <a href="/static/images/2019/mobile-web/example-of-good-and-bad-color-contrast-lookzook.png">
    <img src="/static/images/2019/mobile-web/example-of-good-and-bad-color-contrast-lookzook.png" alt="図4. 色のコントラストが不十分なテキストがどのように見えるかの例。提供：LookZook" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="650" height="300">
  </a>
  <div id="fig4-description" class="visually-hidden">オレンジとグレーの4色のボックスに白のテキストを重ねて、背景色が白のテキストに比べて薄い色になっている場合と、白のテキストに比べて背景色が推奨されている場合の2つの列を作ります。各色の16進数コードが表示され、白は#FFFFFF、オレンジ色の背景の薄い色合いは#FCA469、オレンジ色の背景の推奨色合いは#F56905となっています。画像提供：LookZook</div>
  <figcaption id="fig4-caption">図4. 色のコントラストが不十分なテキストがどのように見えるかの例。提供：LookZook</figcaption>
</figure>

他の人口統計における色覚異常の統計については、[本論文](https://web.archive.org/web/20180304115406/http://www.allpsych.uni-giessen.de/karl/colbook/sharpe.pdf)を参照してください。

### フォントサイズ

読みやすさの第二の部分は、テキストを読みやすい大きさにすることです。これはすべてのユーザーにとって重要ですが、特に年齢層の高いユーザーにとっては重要です。フォントサイズが12px未満では読みにくくなる傾向があります。

ウェブ上では、80.66％のウェブページがこの基準を満たしていることがわかりました。

## ページの拡大、縮小、回転

### ズームと拡大縮小

何万もの画面サイズやデバイスで完璧に動作するようサイトをデザインすることは、信じられないほど難しいことです。ユーザーの中には読むために大きなフォントサイズを必要としたり、製品画像を拡大したり、ボタンが小さすぎて品質保証チームの前を通り過ぎてしまったためにボタンを大きくしたりする必要がある人もいます。このような理由から、ピンチズームやスケーリングなどのデバイス機能が非常に重要になります。

問題のページがタッチコントロールを使用したWebベースのゲームである場合など、この機能を無効にしても問題ない場合が非常に稀にあります。この場合この機能を有効にしておくと、プレイヤーがゲームを2回タップするたびにプレイヤーの携帯電話がズームインしたりズームアウトしたりしてしまい、結果的に利用できなくなってしまいます。

このため、開発者はメタビューポートタグに以下の2つのプロパティのいずれかを設定することで、この機能を無効にできます。

1. `user-scalable`を`0`または`no`に設定

2. `maximum-scale`を`1`、`1.0`などに設定

<figure>
  <a href="/static/images/2019/mobile-web/fig5.png">
    <img src="/static/images/2019/mobile-web/fig5.png" alt="図5. ズーム/スケーリングを有効または無効にしているデスクトップおよびモバイルのウェブサイトの割合。" aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="370" data-width="600" data-height="370" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQcVHQTKIULwgs3f2Jy8IQiHwVAJjKoHrfcvwYX5UAlb4s3bsEA2owiku4c14YZiJeG8H8acgSUul2N/pubchart?oid=655301645&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">"ズームとスケーリングは有効ですか？"と題された縦方向のグループ化された棒グラフでは、0から80までのデータを20刻みで計測し、デバイスの種類をデスクトップとモバイルに分類しています。デスクトップが有効：75.46％、デスクトップが無効：24.54％、モバイルが有効：67.79％、モバイルが無効：32.21％。</div>
  <figcaption id="fig5-caption">図 5. ズーム/スケーリングを有効または無効にしているデスクトップおよびモバイルのウェブサイトの割合。</figcaption>
</figure>

しかし開発者はこれを悪用しすぎて、3つのサイトのほぼ1つ(32.21％)がこの機能を無効にしており、Appleは(iOS 10の時点で)ウェブ開発者がズームを無効にすることを許さなくなっています。モバイルSafariは単に[タグを無視する](https://archive.org/details/ios-10-beta-release-notes)。世界中のウェブトラフィックの[11%](https://gs.statcounter.com/)以上を占める新しいアップルのデバイスでは、どんなサイトでもズームや拡大縮小が可能です。

### ページの回転

モバイルデバイスでは、ユーザーが回転できるので、あなたのウェブサイトをユーザーが好む形式で閲覧できます。ただし、ユーザーはセッション中に常に同じ向きを保つわけではありません。フォームに記入するとき、ユーザーはより大きなキーボードを使用するため横向きに回転できます。また、製品を閲覧しているときには、横向きモードの方が大きい製品画像を好む人もいるでしょう。このようなユースケースがあるため、モバイルデバイスに内蔵されているこの機能をユーザーから奪わないことが非常に重要です。そして良いニュースは、この機能を無効にしているサイトは事実上見当たらないということです。この機能を無効にしているサイトは全体の87サイト（または0.0016％）のみです。これは素晴らしいことです。

## ボタンとリンク

### タップターゲット

デスクトップではマウスのような精密なデバイスを使うことに慣れていますが、モバイルでは全く違います。モバイルでは、私たちは指と呼ばれる大きくて不正確なツールを使ってサイトにアクセスします。その不正確さゆえに、私たちは常にリンクやボタンを「タップミス」して、意図していないものをタップしています。

この問題を軽減するためにタップターゲットを適切に設計することは、指の大きさが大きく異なるために困難な場合があります。しかし現在では多くの研究が行われており、どの程度の大きさのボタンが必要で、どの程度の間隔で離す必要があるかについては安全な[基準](https://developers.google.com/web/tools/lighthouse/audits/tap-targets) があります。

<figure>
  <a href="/static/images/2019/mobile-web/example-of-easy-to-hit-tap-targets-lookzook.png">
    <img src="/static/images/2019/mobile-web/example-of-easy-to-hit-tap-targets-lookzook.png" alt="図6. タップターゲットのサイズと間隔の基準。画像提供：LookZook" aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="800" height="430">
  </a>
  <div id="fig6-description" class="visually-hidden">A diagram displaying two examples of difficult to tap buttons. The first example shows two buttons with no spacing between them; An example below it shows the same buttons but with the recommended amount of spacing between them (8px or 1-2mm). The second example shows a button far too small to tap; An example below it shows the same button enlarged to the recommended size of 40-48px (around 8mm). Image courtesy of LookZook</div>
  <figcaption id="fig6-caption">図6. タップターゲットのサイズと間隔の基準。画像提供：LookZook</figcaption>
</figure>

現在のところ、34.43％のサイトで十分なサイズのタップターゲットを持っています。つまり、「タップミス」が過去のものになるまでには、かなりの道のりがあるということです。

### ラベリングボタン

デザイナーの中には、テキストの代わりにアイコンを使うのが好きな人もいます。しかし、あなたやあなたのチームのメンバーはアイコンの意味を知っていても、多くのユーザーがそうではありません。これは悪名高いハンバーガーのアイコンにも当てはまります。もし私たちを信じられないのであれば、ユーザーテストをしてみて、どれくらいの頻度でユーザーが混乱しているかを見てみましょう。驚くことでしょう。

だからこそ、混乱を避けるためにも、ボタンにサポートテキストやラベルを追加することが重要なのです。現在のところ、少なくとも28.59％のサイトでは、補助テキストを含まないアイコン1つだけのボタンが表示されています。

<p class="note">注：上記の報告されている数字は下限値に過ぎません。今回の分析では、テキストをサポートしないフォントアイコンを使用したボタンのみを対象としました。しかし、現在では多くのボタンがフォントアイコンの代わりにSVGを使用しているため、将来的にはそれらも含める予定です。</p>

## セマンティックフォームフィールド

新しいサービスへのサインアップ、オンラインでの購入、あるいはブログからの新着情報の通知を受け取るためにフォームフィールドはウェブに欠かせないものであり、私たちが日常的に使用するものです。しかし残念なことに、これらのフィールドはモバイルで入力するのが面倒であることで有名です。ありがたいことに、近年のブラウザは開発者に新しいツールを提供し、私たちがよく知っているこれらのフィールドへの入力の苦痛を和らげることができるようになりました。ここでは、これらのツールがどの程度使われているかを見てみましょう。

### 新しい入力タイプ

過去に、デスクトップでは`text`と`password`がほとんどすべてのニーズを満たしていたため、開発者が利用できる入力タイプは`text`と`password`だけでした。しかし、モバイルデバイスではそうではありません。モバイルキーボードは信じられないほど小さく、電子メールのアドレスを入力するような単純な作業では、ユーザーは複数のキーボードを切り替える必要があります。電話番号を入力するだけの単純な作業では、デフォルトのキーボードの小さな数字を使うのは難しいかもしれません。

その後、多くの[新しい入力タイプ](https://developer.mozilla.org/ja/docs/Web/HTML/Element/Input)が導入され、開発者はどのようなデータが期待されるかをブラウザに知らせ、ブラウザはこれらの入力タイプに特化したカスタマイズされたキーボードを提供できるようになりました。例えば、`email`のタイプは"@"記号を含む英数字キーボードをユーザに提供し、`tel`のタイプはテンキーを表示します。

メール入力を含むサイトを分析する際には、56.42％が`type="email"`を使用している。同様に、電話入力では、`type="tel"`が36.7％の割合で使用されています。その他の新しい入力タイプの採用率はさらに低い。

<figure>
  <table>
    <tr>
      <th>タイプ</th>
      <th>頻度(ページ数)</th>
    </tr>
    <tr>
      <td>phone</td>
      <td class="numeric">1,917</td>
    </tr>
    <tr>
      <td>name</td>
      <td class="numeric">1,348</td>
    </tr>
    <tr>
      <td>textbox</td>
      <td class="numeric">833</td>
    </tr>
  </table>
  <figcaption>図7. 最も一般的に使用される無効な入力タイプ</figcaption>
</figure>

利用可能な大量の入力タイプについて自分自身や他の人を教育し、上の図7のようなタイプミスがないことを再確認するようにしてください。

### 入力のオートコンプリートを有効にする

入力属性[`autocomplete`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) は、ユーザーがワンクリックでフォームフィールドへ記入できるようにします。ユーザーは膨大な数のフォームに記入しますが、毎回全く同じ情報を記入することがよくあります。このことに気付いたブラウザは、この情報を安全に保存し、将来のページで使用できるようにし始めました。開発者がすべきことは、この`autocomplete`属性を使用してどの情報を正確に入力する必要があるかをブラウザに伝えるだけで、あとはブラウザが行います。

<figure>
  <div class="big-number">29.62%</div>
  <figcaption>図8. <code>オートコンプリート</code>を使用しているページの割合。</figcaption>
</figure>

現在、入力フィールドを持つページのうち、この機能を利用しているのは29.62％に過ぎません。

### パスワードフィールドへの貼り付け

ユーザーがパスワードをコピーしてページに貼り付けることができるようにすることは、パスワードマネージャーを使用するための1つの方法です。パスワードマネージャーは、ユーザーが強力なパスワードを生成（記憶）し、ウェブページ上で自動的に記入するのに役立ちます。テストしたウェブページの0.02％だけがこの機能を無効にしています。

<p class="note">注: これは非常に励みになりますが、<a href="./方法論">方法論</a>ではホームページのみをテストするという要件があるため、過小評価されている可能性があります。ログインページのような内部ページはテストされません。</p>

## 結論

13年以上もの間、私たちは*モバイル*ウェブをデスクトップの単なる例外のように後回しにしてきました。しかし、今こそこの状況を変える時です。モバイル・ウェブは今や「*ウェブ*」であり、デスクトップはレガシーウェブになりつつあります。現在、世界では40億台のアクティブなスマートフォンが存在し、潜在的なユーザーの70％をカバーしています。デスクトップはどうでしょうか？　デスクトップは現在16億台となっており、毎月のウェブ利用の割合は少なくなっています。

モバイルユーザーへの対応はどの程度できているのでしょうか？　当社の調査によると、71％のサイトがモバイル向けに何らかの努力をしているにもかかわらず、その目標を大きく下回っています。ページの読み込みに時間がかかり、JavaScriptの乱用により使用不能になり、テキストは読めないことが多く、リンクやボタンをクリックしてサイトにアクセスするとエラーが発生しやすくイライラさせられます。

モバイルウェブは今では十分に長い間存在しています。子供たちの世代全体がこれまでに知っていた唯一のインターネットです。私たちは彼らにどのような経験を与えているのでしょうか？　私たちは本質的にダイヤルアップ時代に彼らを連れ戻しています。(私はAOLがまだ無料のインターネットアクセスの1000時間を提供するCDを販売していると聞いて良かった!)

<figure>
  <a href="/static/images/2019/mobile-web/america-online-1000-hours-free.jpg">
    <img alt="A 1000 hour free-trial CD for America Online" src="/static/images/2019/mobile-web/america-online-1000-hours-free.jpg" aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="300" height="285">
  </a>
  <div id="fig9-description" class="visually-hidden">1,000時間無料で提供しているAOLのCD-ROMの写真。</div>
  <figcaption id="fig9-caption">図9. 無料で1000時間の「アメリカオンライン」から。<a href="https://archive.org/details/America_Online_1000_Hours_Free_for_45_Days_Version_7.0_Faster_Than_Ever_AM402R28">archive.org</a>.</figcaption>
</figure>

<p class="note" data-markdown="1">注:

1. モバイルに力を入れているサイトを、より小さな画面に合わせてデザインを調整しているサイトと定義しました。というか、CSSのブレークポイントが600px以下に1つ以上あるサイトを指します。

2. 潜在的なユーザーとは、15歳以上の年齢層を指します。[57億人](https://www.prb.org/international/geography/world)。

3. [デスクトップ検索](https://www.merkleinc.com/thought-leadership/digital-marketing-report)と[ウェブトラフィックシェア](https://gs.statcounter.com/platform-market-share/desktop-mobile-tablet/worldwide/#monthly-201205-201909)はここ数年減少傾向にあります。

4. アクティブなスマートフォンの総数は、アクティブなAndroidsとiPhone（AppleとGoogleが公開している）の数を合計し、中国のネット接続された電話を考慮し少し計算して判明しました。[詳細はこちら](https://www.ben-evans.com/benedictevans/2019/5/28/the-end-of-mobile)。

5. 16億台のデスクトップは、[Microsoft](https://web.archive.org/web/20181030132235/https://news.microsoft.com/bythenumbers/en/windowsdevices)と[Apple](https://web.archive.org/web/20190628161024/https://appleinsider.com/articles/18/10/30/apple-passes-100m-active-mac-milestone-thanks-to-high-numbers-of-new-users)が公開している数字で計算しています。リナックスPCユーザーは含まれていません。
</p>
