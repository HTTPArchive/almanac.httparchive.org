---
part_number: II
chapter_number: 9
title: アクセシビリティ
description: 読みやすさ、メディア、操作性の容易さ、および支援技術とその互換性をカバーする2019 Web Almanacアクセシビリティの章。
authors: [nektarios-paisios, obto, kleinab]
reviewers: [ljme]
translators: [MSakamaki]
discuss: 1764
results: https://docs.google.com/spreadsheets/d/16JGy-ehf4taU0w4ABiKjsHGEXNDXxOlb__idY8ifUtQ/
queries: 09_Accessibility
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-05-27T00:00:00.000Z
---

## 導入

Webのアクセシビリティは、包摂的で公平な社会の上では無くてはならない存在です。私たちの社会性と仕事や生活の多くがオンラインの世界に推移するにつれて、障害のある人々も分け隔てなく、すべてのオンラインの対話に参加できることがさらに重要になってきます。建築家が車椅子用の傾斜路のようなアクセシビリティ機能を作成や省略できるように、Web開発者はユーザーが頼りにしている支援技術を助けたり邪魔したりできます。

障害を持つユーザーの事を考えた時ユーザージャーニーはほぼ同じとなることを忘れないでください、彼らは異なるツールを使っているだけでしかありません。よく知られてるツールとして、スクリーンリーダー、画面拡大鏡、ブラウザまたは文字の拡大、音声コントロールなどがありますが、これ以外にも色々とあります。

ほとんどの場合、アクセシビリティを改善することでサイトを訪れるすべての人に対してメリットを与える事ができます。私達は普通、障害者は生涯その障害を抱えていると思っていますが、一時的だったり状況的に障害を持つような人も居ます。たとえばその誰かが全盲なのか、一時的な目の感染症なのか、はたまた野外で眩しい太陽の下という状況なのか。これらすべて、その誰かが画面を見ることができない理由の説明になります。誰もが状況により障害を持ちうるため、Webページのアクセシビリティを改善することは、あらゆる状況ですべてのユーザーの体験を向上させることに繋がります。

[Webコンテンツのアクセシビリティガイドライン](https://www.w3.org/WAI/WCAG21/quickref/) (WCAG)はWebサイトの利便性を向上する方法についてのアドバイスが纏められています。このガイドラインを分析の基礎に使いました。しかし、ほとんどの場合においてWebサイトのアクセシビリティをプログラムによって分析するのは非常に困難です。たとえば、Webプラットフォームは機能的には同じ結果となる複数の方法を提供しており、それを実現するための基盤となるコードはまったく別物になる場合があります。したがって、私達の分析結果はWebアクセシビリティ全体の単なる概算でしかありません。

私達はもっとも興味深い洞察を4種類のカテゴリに分類しました。それは読みやすさ、Web上のメディア、ページナビゲーションのしやすさ、補助技術との互換性です。

テスト中にデスクトップとモバイルの間でアクセシビリティに大きな違いは見つかりませんでした。この結果で提示されているメトリックは、とくに明記していない限りはデスクトップの分析結果です。

## 読みやすさ

Webページの主な目的はユーザーの興味を引くコンテンツを配信することです。このコンテンツはビデオや画像の組み合わせなどありますが、ほとんどの場合、シンプルなページ上のテキストです。テキストコンテンツが読者にとって読みやすいことは、とても重要です。訪問者がWebページを読めない場合、訪問者はWebページに興味を持つことがなくなり、最終的には離脱してしまうでしょう。この節ではサイトが苦労するであろう3つの分野を見ていきます。

### 色のコントラスト

あなたのサイトの訪問者が完璧な内容を見ることができない、さまざまな可能性があります。訪問者は色覚多様性を持ち、フォントと背景色を区別できない場合があります（ヨーロッパ系の[男性12人に1人、女性200人に1人](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf)）。おそらく、彼らは太陽の下で画面の明るさを最大にして読んでいるため、視力を著しく損なっているのでしょう。もしくは年をとってしまい、彼らの目が以前と同じように色を区別できなくなったのでしょう。

このような条件下であっても、あなたのWebサイトが確実に読めるようにするため、テキストと背景で十分な色のコントラストがあることを確認することは重要です。

<figure>
  <a href="/static/images/2019/accessibility/example-of-good-and-bad-color-contrast-lookzook.svg">
    <img alt="図1.色のコントラストが不十分なテキストの表示例 LookZook提供" aria-labelledby="fig1-caption" aria-describedby="fig1-description" src="/static/images/2019/accessibility/example-of-good-and-bad-color-contrast-lookzook.svg" width="568" height="300">
  </a>
  <div id="fig1-description" class="visually-hidden">褐色とグレー4色のボックスに白いテキストがあり、2列に並んでいます。左の列は、色の薄い、<code>#FCA469</code>と書かれた褐色色の背景色があります。右の列は、推奨と表示されており、褐色色の背景色に<code>#BD5B0E</code>と書かれています。各列の上のボックスには白いテキスト#FFFFFFに褐色色の背景で、下のボックスは灰色の背景に白いテキスト#FFFFFFとなっています。同等のグレースケールは、それぞれ<code>＃B8B8B8</code>および<code>＃707070</code>です。LookZook提供。</div>
  <figcaption id="fig1-caption">図1.色のコントラストが不十分なテキストの表示例 LookZook提供</figcaption>
</figure>

すべてのテキストに十分な色のコントラストが適用されているサイトは22.04％のみでした。これは言い換えると、5つのサイトのうち4つは背景に溶け込んで読みにくいテキストを持っていると言うことです。

<p class="note">注意：画像中のテキストは分析できていないため、ここで報告されているメトリックはカラーコントラストテストに合格したWebサイトの総数の上限でしかありません。</p>

### ズーミングとページのスケーリング

[読みやすいフォントサイズ](https://accessibleweb.com/question-answer/minimum-font-size/)や[ターゲットサイズ](https://www.w3.org/WAI/WCAG21/quickref/#target-size)を使うことで、ユーザーがWebサイトを読んだり操作するのを手助けできます。しかし、このガイドラインに対して完全に準拠しているWebサイトですら、訪問者一人ひとりの特定のニーズを満たすことはできません。これがピンチズームやスケーリングなどのデバイスによる機能が非常に重要となる理由です。ユーザーが貴方のページを微調整できるようにして彼らのニーズを満たします。また、小さなフォントやボタンが使われて操作が非常に難しいサイトであっても、ユーザーにそのサイトを使う機会を与えることができます。

まれですが、スケーリングの無効化が許容される場合はあります。それは問題となるページがタッチコントロールを使ったWebベースのゲームなどの場合です。このような場合、有効にしてしまうとプレイヤーがゲームで2回タップをするたびにプレイヤーのスマホがズームインやズームアウトしてしまい、皮肉なことに操作できなくなってしまいます。

なので、開発者は[メタビューポートタグ](https://developer.mozilla.org/ja/docs/Mobile/Viewport_meta_tag)で次の2つのプロパティのどちらかを設定することで、この機能を無効化できます。

1. `user-scalable`を`0`か`no`に設定

2. `maximum-scale`を`1`もしくは`1.0`などに設定

悲しいことに、開発者はこの機能を誤用しすぎており、モバイルサイトの3つのうち1つ（32.21％）でこの機能を無効化しています。さらにApple（iOS 10の時点）でWeb開発者がズームを無効化できなくなってしまいました。モバイルSafariは純粋に[タグを無視します](https://archive.org/details/ios-10-beta-release-notes)。すべてのサイトは新しいiOSデバイスでズームとスケーリングができます。

<figure>
  <a href="/static/images/2019/accessibility/fig2.png">
    <img src="/static/images/2019/accessibility/fig2.png" alt="図2. ズームとスケーリングを無効にしているサイトとデバイスの種類の割合。" aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=2053904956&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">20刻みの0から80までの垂直測定パーセンテージデータ。デバイスタイプをデスクトップとモバイルでグループ化しています。デスクトップで有効なのは 75.46%無効が24.54%、モバイルで有効なのは67.79%無効が32.21%.</div>
  <figcaption id="fig2-caption">図2. ズームとスケーリングを無効にしているサイトとデバイスの種類の割合。</figcaption>
</figure>

### 言語の識別

Webには驚くべき大量のコンテンツが溢れていますが、ここには大きな落とし穴があります。世界には1,000以上の異なる言語が存在しており、探しているコンテンツが流暢な言葉で書かれていない可能性があります。昨今、私たちは翻訳技術で大きな進歩を遂げており、貴方はおそらくその1つをWebで利用しているでしょう（例：Google翻訳）

この機能を円滑に行うために、翻訳エンジンはあなたのページがどの言語で書かれているかを知る必要があります。これには[`lang`属性](https://developer.mozilla.org/ja/docs/Web/HTML/Global_attributes/lang)が使われます。lang属性がないと、コンピューターはページが記述されている言語を推測する必要が出てきます。想像できると思いますが、ページ中で複数の言語が使われている場合、これは多くの間違いを引き起こします（たとえば、ページナビゲーションは英語なのに投稿されているコンテンツが日本語のような場合）。

この言語が指定されていない場合の問題は、規定のユーザー言語でテキストを読む傾向があるスクリーンリーダーのようなテキスト読み上げ支援技術で顕著になります。

分析の結果、26.13％で`lang`属性による言語指定がありませんでした。これは4分の1以上のページが上記のような問題の影響を受けやすいという事です。良いニュース？ `lang`属性を使っているサイトの99.68％で有効な言語コードが適用されています。

### 煩わしいコンテンツ

認知障害などの一部のユーザーは、1つの作業に対して長時間集中することが困難です。こういったユーザーは、とくに表面的なエフェクトが多く、それが目の前の作業に関わらない場合、動きやアニメーションが多く含まれるページを利用したくありません。

残念なことに、私達の調査結果では無限ループアニメーションがWebでは非常に一般的であり、21.04％のページが無限CSSアニメーションや[`<marquee>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/marquee)および[`<blink>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/blink)要素が使われている事を示しています。

ただし、この問題の大部分は人気のあるサードパーティー製のスタイルシートが規定で無限ループのCSSアニメーションが含まれている事が原因であることに注意してください。このようなアニメーションスタイルを実際に適用したページ数がいくつあるのか、私達は特定できませんでした。

## Web上のメディア

### 画像の代替テキスト

画像はWebの体験の根幹です。それらは強い物語性を伝えることができ、注意を引いて感情を引き出すことができます。しかし、ストーリーの一部を伝えるために私達が頼っている画像は、誰でも見ることができるわけではありません。幸いなことに、1995年、HTML 2.0でこの問題に対する解決策が提供されました、それは[alt属性](https://webaim.org/techniques/alttext/)です。alt属性は使われている画像にテキストの説明を追加できる機能をWeb開発者に提供します。これによって、画像を見ることができない（もしくは読み込めない）ときに、altテキストに書かれた説明を読むことができます。altテキストは、彼らが見逃していたかもしれないストーリーの一部を埋めることができます。

alt属性は25年前から存在していますが、49.91％のページで画像の一部にalt属性が提供されておらず、8.68％のページでまったく使用されていませんでした。

### ビデオやオーディオの字幕

画像が強力なストーリーテラーであるように、オーディオとビデオも注目を集めたりアイデアを表現する事ができます。オーディオやビデオコンテンツに字幕が付けられていない場合、コンテンツが聞こえないユーザーはWebのほとんどを見逃してしてしまいます。耳が聞こえない、もしくは難聴のユーザーから一番よく聞くのは、すべてのオーディオとビデオコンテンツに字幕を含めて欲しいというお話です。

[`<audio>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/audio)や[`<video>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/video)要素を使うサイトのうち、字幕を提供しているのは0.54％のみでした（[`<track>`](https://developer.mozilla.org/ja/docs/Web/Guide/Audio_and_video_delivery/Adding_captions_and_subtitles_to_HTML5_video)要素を含むサイトで測定）一部のWebサイトには、ユーザーにビデオとオーディオの字幕を提供するカスタムソリューションがあります。これらは検出できなかったので、字幕を利用しているサイトの本当の割合は、おそらく少し高いでしょう。

## 使いやすいページナビゲーション

レストランでメニューを開くとき、おそらく最初にするのは前菜、サラダ、主料理、デザートなどのセクションヘッダーをすべて読むことでしょう。ここから、すべてのメニューの選択肢を見渡し、もっとも興味のある料理に飛ぶことができます。同様に、訪問者がWebページを開く時、訪問者の目標はもっとも興味を持っている情報を見つけることです（それがページにアクセスした理由のはずです）ユーザーが目的のコンテンツをできるだけ早く見つけることができるように（それと、戻るボタンを押させないため）ページのコンテンツをいくつかの視覚的に異なるセクションに分割する必要があります。たとえば、ナビゲーション用のサイトヘッダーを置き、記事の見出しをユーザーが素早く見渡せるようにしたりその他の無関係なリソースを纏めたフッターなどをに分割する等です。

これは非常に重要な事で、訪問者のコンピューターがこれらの異なるセクションを認識できるよう、注意してページのマークアップをする必要があります。それはなぜかと言うと、ほとんどの読者はマウスを利用してページを探索しますが、それ以外の読者はキーボードとスクリーンリーダーに依存しています。これらのテクノロジーは、コンピューターがあなたのページをどの程度理解できるかに大きく依存します。

### 見出し

見出しは見た目上で有用なだけではなく、スクリーンリーダーでも役立ちます。見出しによってスクリーンリーダーはセクション間を素早く移動でき、さらに、セクションが終了して別のセクションが開始される場所を明示的にします。

スクリーンリーダーを使うユーザーの混乱を避けるために、見出しのレベルを飛ばさないようにしてください。たとえば、H2をスキップして、H1の次にH3を使うのは止めてください。なぜこれが重要なのか？　それはスクリーンリーダーを使うユーザーが、予期せぬ変化からコンテンツを見逃したと勘違いしてしまうためです。このような場合、本当は見逃しがないにもかかわらず、見逃している可能性があるものを探し始めてしまいます。あわせて、より一貫したデザインを維持することで、すべての読者を支援します。

そうは言いつつも、結果としては次のようになっています。

1. 89.36％のページが何らかの方法で見出しを使っています。素晴らしことです。
2. 38.6％のページは見出しのレベルを飛ばしています。
3. 不思議な事に、H2はH1よりも多くのサイトで見つかりました。

<figure>
  <a href="/static/images/2019/accessibility/fig3.png">
    <img src="/static/images/2019/accessibility/fig3.png" alt="図3. 見出しレベルの人気。" aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-crolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1123601243&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">20毎に0から80の範囲のパーセンテージデータを測定する垂直棒グラフ。各見出しはh1〜h6レベルを表します。H1：63.25％、H2：67.86％、H3：58.63％、H4：36.38％、H5：14.64％、H6：6.91％。</div>
  <figcaption id="fig3-caption">図3. 見出しレベルの人気。</figcaption>
</figure>

### Mainランドマーク

[mainランドマーク](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/Roles/Main_role)はWebページのメインコンテンツが始まる場所をスクリーンリーダーに示すことで、ユーザーがーすぐその場所に飛ぶことができます。mainランドマークがない場合、スクリーンリーダーのユーザーはサイト内の新しいページにアクセスするたび、手動でナビゲーションをスキップする必要が出てきます。これは明らかにイライラするでしょう。

ページの4分の1（26.03％）にだけmainランドマークが含まれていることが判明しました。さらに驚くべきことに、8.06％のページに複数のmainランドマークが誤って含まれているため、ユーザーは実際のメインコンテンツがどのランドマークなのかを推測する必要が出ていました。

<figure>
  <a href="/static/images/2019/accessibility/fig4.png">
    <img src="/static/images/2019/accessibility/fig4.png" alt="図4. 「main」ランドマークの数によるページの割合。" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1420590464&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">20毎に0〜80の範囲のパーセントデータを表示する垂直棒グラフと、0〜4のページごとの「main」ランドマークの数を表すバー。ソース：HTTP Archive （2019年7月）。 0：73.97％、1：17.97％、2：7.41％、3：0.15％; 4：0.06％。</div>
  <figcaption id="fig4-caption" >図4. 「main」ランドマークの数によるページの割合。</figcaption>
</figure>

### HTML section要素

HTML5は2008年リリースされ、2014年に公式の標準となっているので、コンピューターとスクリーンリーダーがページの見た目と構造を理解するのに有用なHTML要素がたくさんあります。

[`<header>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/header)、[`<footer>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/footer)、[`<navigation>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/nav)、[`<main>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/main)などの要素は特定の種類のコンテンツがどこにあるか明示的にして、ユーザーがそのページへ素早く飛ぶことを可能にします。これらはWeb全体で幅広く使われており、ほとんどがページの50％以上で使われています。(`<main>`は外れ値です。)

[`<article>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/article)、[`<hr>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/hr)、[`<aside>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/aside)のようなものは、読者がページのメインコンテンツを理解するのに役立ちます。たとえば、`<article>`は記事が終了して別の記事が開始される場所を示します。これらの要素はほとんど使われておらず、使用率は約20％ですが、これらはすべてのWebページで必要となるわけではないため、とくに驚くべき統計ではありません。

これらの要素はすべてアクセシビリティサポートを主目的として設計されており、見た目の変化はありません。つまりこれは、既存の要素を安全に置き換えることが可能なので意図しない影響で苦しむことはないでしょう。

<figure>
  <a href="/static/images/2019/accessibility/fig5.png">
    <img src="/static/images/2019/accessibility/fig5.png" alt="図5. 色々なHTMLセマンティック要素の利用率。" aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=708035719&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">各要素のバーと20毎に0〜60の範囲のページの割合を表す水平線を含む縦棒グラフ。nav：53.94％、header：54.82％、footer：55.92％、main：18.47％、aside：16.99％、article：22.59％、hr：19.1％、section：36.55%。</div>
  <figcaption id="fig5-caption" >図5. 色々なHTMLセマンティック要素の利用率。</figcaption>
</figure>

### ナビゲーションで使われているその他のHTML要素

よく使われているスクリーンリーダーは、ユーザーがリンク、一覧、一覧のアイテム、iframe、それと編集フィールド、ボタン、リストボックスなどのフォームフィールドに素早く飛び、誘導できます。図6はこういった要素を使うページの表示頻度を表しています。

<figure>
  <a href="/static/images/2019/accessibility/fig6.png">
    <img src="/static/images/2019/accessibility/fig6.png" alt="図6. ナビゲーションで使われるその他のHTML要素。" aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=389034849&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">各要素を示すバーと、25毎に0~100の範囲でページの割合を示す縦棒グラフ。a：98.22％、ul：88.62％、input：76.63％、iframe：60.39％、button：56.74％、select：19.68％、textarea：12.03%。</div>
  <figcaption id="fig6-caption">図6. ナビゲーションで使われるその他のHTML要素。</figcaption>
</figure>

### スキップリンク

[スキップリンク](https://webaim.org/techniques/skipnav/)はスクリーンリーダーやキーボードだけを使うユーザーが、メインコンテンツに直接飛ぶことができるようにする、ページ上部に配置されるリンクです。これは、ページの上部にあるすべてのナビゲーションリンクとメニューを効率的に「スキップ」します。スキップリンクは、スクリーンリーダーを利用していないキーボードユーザーにとってとくに便利です。それは、このようなユーザーは通常他のクィックナビゲーションモード（ランドマークや見出しなど）にアクセスできないためです。サンプリングされたページの14.19％にスキップリンクが使われていました。

スキップリンクの動作を試す事ができます！　シンプルにGoogle検索を実行し、検索結果ページが表示されたらすぐに「Tab」キーを押します。図7のような、事前に隠されたリンクが表示されます。

<figure>
  <a href="/static/images/2019/accessibility/example-of-a-skip-link-on-google.com.png">
    <img alt="図7. google.comのスキップリンク外観。" aria-labelledby="fig7-caption" aria-describedby="fig7-description" src="/static/images/2019/accessibility/example-of-a-skip-link-on-google.com.png" width="600" height="333">
  </a>
  <div id="fig7-description" class="visually-hidden">「Http Archive」を検索するためのGoogle検索結果ページのスクリーンショット。表示される「メインコンテンツにスキップ」のリンクは青色のフォーカスハイライトと、スキップリンクを示す赤い矢印の付いた黄色のオーバーレイボックスに囲まれ「google.comのスキップリンク」と表示されます。</div>
  <figcaption id="fig7-caption">図7. google.comのスキップリンク外観。</figcaption>
</figure>

サイトを分析するときに、正しいスキップリンクを判断するのは困難です。なのでこの分析ではページの最初の3つのリンク内にアンカーリンク（`href=#heading1`）が見つかった場合、それをスキップリンクのあるページと定義しました。つまり14.19％というのは厳密には上限です。

### ショートカット

[`aria-keyshortcuts`](https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts)や[`accesskey`](https://developer.mozilla.org/ja/docs/Web/HTML/Global_attributes/accesskey)属性を介して設定されたショートカットキーは、次の2つの方法のどちらかで使うことができます。

1. リンクやボタンなどのページ上の要素を活性化させます。

2. 特定の要素に対するページフォーカスを提供します。たとえばページ上にある特定の入力にフォーカスを移動させて、すぐさまユーザーが入力できるようにします。

サンプルを見る限り[`aria-keyshortcuts`](https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts)はほとんど採用されておらず、400万以上ある分析対象のうち、たった159のサイトでだけ使われていました。[`accesskey`](https://developer.mozilla.org/ja/docs/Web/HTML/Global_attributes/accesskey)属性はかなり利用されており、Webページの2.47％（モバイルだと1.74％）で使われています。デスクトップでショートカットの利用率が多いのは、開発者がモバイルでサイトにアクセスする時、キーボードでなくタッチスクリーンのみで利用することを期待しているためと考えています。

とくに驚くべき点は、ショートカットキーを適用しているモバイルサイトの15.56％とデスクトップサイトの13.03％で、1つのショートカットキーを複数の要素に割り当てている事です。これはブラウザがショートカットキーの対象となる要素を推測する必要があることを意味しています。

### テーブル

テーブルは大量のデータを整理し表現する主要な方法の1つです。スクリーンリーダーやスイッチ（運動障害のあるユーザーが使ったりします）などのさまざまな支援技術には、この表形式データをより効率的に操作できる特別な機能を持っています。

#### テーブルの見出し

テーブルの詳細な構造に対応したテーブルヘッダーを使うことで、特定の列または行が参照するコンテキストを失うこと無く、列や行全体を簡単に読み取り可能とします。ヘッダー行や列のないテーブルを操作しないといけないのは、スクリーンリーダーのユーザーにとっては使いづらいでしょう。これは、テーブルが非常に大きい時にスクリーンリーダーのユーザーはヘッダーのないテーブルだと自分の場所を把握するのが難しいからです。

テーブルのヘッダーをマークアップするには、シンプルに（[`<td>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/td)タグの代わりに）[`<th>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/th)タグを使うか、ARIAの [`columnheader`](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/Roles/Table_Role)か[`rowheader`](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/Roles/Table_Role)ロールのどれかを使います。この方法のどれかでテーブルがマークアップされていたのは、テーブルを含むページの24.5％だけでした。そのため、テーブルにヘッダーが含まれない四分の三のページは、スクリーンリーダーのユーザーにとって非常に深刻な課題を持っています。

`<th>`と `<td>`を利用するのは、テーブルにヘッダーをマークアップするもっとも一般的な方法のようです。`columnheader`と`rowheader`のロールを使っているサイトはほとんど存在せず、使っているサイトは合計677個（0.058％）のみでした。

#### キャプション

[`<caption>`](https://developer.mozilla.org/ja/docs/Web/HTML/Element/caption)要素が使われているテーブルキャプションは、さまざまな読者に対してより多くのコンテキストを提供できます。キャプションはテーブルが共有している情報を読む準備ができてる人や、集中できない環境だったり、作業の中断が必要な人々にとってとくに便利になります。また、スクリーンリーダーユーザーや学習障害、知的障害のある人などの、大きなテーブルだと自分の見ている場所で迷子になる可能性がある人々にとっても有用です。読者が分析している内容を理解しやすくすればするほど、より良い結果を得られるでしょう。

にもかかわらず、表が含まれるページでは4.32％だけでしかキャプションを提供していません。

## 支援技術との互換性

### ARIAの使用

Web上でもっとも一般的かつ広く活用されているアクセシビリティの使用の1つに[Accessible Rich Internet Applications](https://www.w3.org/WAI/standards-guidelines/aria/) (ARIA)という標準があります。この標準は視覚的要素の背景にある目的（つまり、セマンティクスな意味）と、それにより可能になるアクションの種類を教えるのに役立つ追加のHTML属性をもった大きな配列を提供します。

ARIAを適切かつ正しく使うのは難しい場合があります。例えば、ARIA属性を使っているページでは12.31％の属性に無効な値が割り当てられていました。ARIA属性の利用に誤りがあると、ページに視覚的な影響が及ばないため問題になります。これらの間違いは自動検証ツールを使っても検出できますが、一般的には実際の支援ソフトウェア（スクリーンリーダーなど）を実際に使う必要があります。この節ではARIAがWeb上でどのように使われているか、特に標準のどの部分が最も普及しているのかを検証していきます。

<figure>
  <a href="/static/images/2019/accessibility/fig8.png">
    <img src="/static/images/2019/accessibility/fig8.png" alt="図8. 総ページ数とARIA属性の割合。" aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=792161340&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">0〜25の範囲で5ずつ増加するパーセントデータと、各属性のバーを表示する垂直棒グラフ。 aria-hidden：23.46％、aria-label：17.67％、aria-expanded：8.68％、aria-current：7.76％、aria-labelledby：6.85％、aria-controls：3.56％、aria-haspopup：2.62％、aria-invalid：2.68％、aria-describedby：1.69％、aria-live：1.04％、aria-required：1％</div>
  <figcaption id="fig8-caption" >図8. 総ページ数とARIA属性の割合。</figcaption>
</figure>

#### `role`属性

「ロール」属性は、すべてのARIAの仕様中で最も重要な属性です。これは指定されたHTML要素の目的（セマンティックな意味）をブラウザへ通知するために使用されます。たとえば、CSSを使って視覚的にボタンのようにスタイルが適用された`<div>`要素には`button`のARIAロールを与える必要があります。

実際には46.91％のページが少なくとも1つのARIAロール属性を使っています。以下の図9は、最もよく使われているトップ10のARIAロールの値一覧を纏めました。

<figure>
  <a href="/static/images/2019/accessibility/fig9.png">
    <img src="/static/images/2019/accessibility/fig9.png" alt="図9. ariaロールトップ10。" aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=176877741&amp;format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">0から25までの範囲で5ずつ増加サイトの割合と各ロールタイプのバーを備えた垂直棒グラフ。Navigation：20.4％。 search：15.49％; main：14.39％; banner：13.62％; contentinfo：11.23％; button：10.59％; dialog：7.87％; complementary：6.06％; menu：4.71％; form：3.75％</div>
  <figcaption id="fig9-caption" >図9. ariaロールトップ10。</figcaption>
</figure>

図9の結果を見ると、2つの興味深い見解が得られます。UIフレームワークを更新すると、Web全体のアクセシビリティおよび操作しやすいダイアログとなっているサイトの数が非常に多くなるようです。

##### UIフレームワークの更新は、Web全体のアクセシビリティを向上させる方法となる可能性がある

11％以上のページに表示されるトップ5のロールはランドマークロールです。これはコンボボックスなどのヴィジェット機能が何かを説明するためではなく、ナビゲーションを助けるために使われています。ARIAが開発された主な目的は、Web開発者が汎用のHTML要素(`<div>`など)で作られたヴィジェット機能に対して説明を追加できる機能を提供することだったため、これは予想しなかった結果です。

とても良く使われているWeb UIフレームワークは、テンプレートにナビゲーションロールが含まれているはずです。これはランドマーク属性が普及している説明に繋がります。この見解が正しい場合、一般的なUIフレームワークを更新してアクセシビリティサポートを追加すると、Webのアクセシビリティに大きな影響が出る可能性を持っています。

この結論が導き出されるもう1つの答えは、より「高度」で同じくらい重要なARIA属性が一切使用されていないように見えるという事実です。この属性はUIフレームワークを介してかんたんにデプロイすることはできません。なぜなら、このような属性は各サイトの構造と外観に基づいて個々にカスタマイズする必要がある為です。例えば`posinset`や`setsize`属性は0.01％のページでしか使われていませんでした。これらの属性は一覧やメニューにあるアイテムの数と現在選択されているアイテムを、スクリーンリーダーユーザーに伝えることができます。そのため、視覚障害のあるユーザーがメニューを操作しようとすると「ホーム、5分の1」「製品、5分の2」「ダウンロード、5分の3」というようなインデックスのアナウンスが聞こえます。

##### 多くのサイトは、ダイアログをアクセス可能にしようとしています

スクリーンリーダーを使っているユーザーはダイアログへのアクセスが難しく、見るからにそれが[ダイアログロール](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/Roles/dialog_role)その相対的な人気となっています。そのため、分析されたページの約8％で挑戦しはじめているのを見るのは興奮します。繰り返しますが、これはいくつかのUIフレームワークを使った結果に思えます。

#### 対話的要素のあるラベル

ユーザーがWebサイトを操作する最も一般的な方法は、Webサイトを閲覧するためのリンクやボタンなどのコントロールを使うことです。ただし、殆どの場合においてスクリーンリーダーのユーザーは、活性化されたコントロールが何を実行するのかを判断できません。この混乱が発生する原因の多くは、テキストラベルが無いためです。例えば、左向きの矢印アイコンが表示された「戻る」事を示すボタンですが、テキストが実際は含まれていません。

ボタンまたはリンクを使うページの約4分の1（24.39％）でしか、これらのコントロールにテキストラベルが含まれていませんでした。コントロールにラベルが付いていない場合、スクリーンリーダーのユーザーは「検索」などの意味のある単語ではなく「ボタン」などの一般的なものを読み上げることがあります。

ボタンとリンクはタブオーダーの対象であるため、視認性は非常に高くなります。Tabキーを使ってのWebサイト閲覧は、キーボードだけを使っているユーザーのWebサイト閲覧では普通の事です。なので、ユーザーはTabキーを使ってWebサイトを移動している場合に、ラベルのないボタンとリンクに必ず遭遇するでしょう。

### フォームコントロールのアクセシビリティ

フォームへの入力は私達が毎日行う沢山行う作業です。ショッピングや旅行の予約、仕事の申込みなど、フォームはユーザーがWebページと情報を共有する主な方法です。そのため、フォームを便利にすることは非常に重要です。これを達成するための簡単な方法は、各入力にラベルを提供することです（[`<label>`要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element/label)や[`aria-label`](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute)または[`aria-labelledby`](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute)を用いて）。悲しいことに、すべてのフォーム入力にラベルを提供しているのページは22.33％しかありませんでした。つまり、5ページあるうちの4ページは非常に記入が難しいフォームを持っています。

#### 必須や無効なフィールドであることを示す手がかり

大きなアスタリスクがあるフィールドに出会うと、それが必須フィールドだと理解できます。もしくは、サブミットをクリックして無効な入力があると通知された場合に、異なる色で強調表示されているものは全てを修正してから再送信する必要があります。しかし、視力が低い人や無い人はこのような視覚的合図に頼ることができないため、htmlの入力属性である `required`や`aria-required`と`aria-invalid` などが非常に重要になります。これらは、スクリーンリーダーに対して赤いアスタリスクや赤い強調表示されたフィールドと同等の物を提供します。更に良いことに、必要なフィールドをブラウザに教えれば[フォームの一部を検証](https://developer.mozilla.org/ja/docs/Learn/HTML/Forms/Form_validation)することも可能です。これにはJavaScriptが必要ありません。

フォームを使っているページのうち21.73％は必須フィールドをマークアップするときに `required`か`aria-required` を適用しています。５分の１のサイトでだけ、これらは使用されています。これはサイトを使いやすくするための簡単な手続きです、すべてのユーザーに対してブラウザの役立つ機能を開放します。

フォームを持つサイトの3.52％で`aria-invalid`が使われていることも判明しました。しかし、ほとんどのフォームは誤った情報が送信された後にこのフィールドを参照するため、このマークアップを適用しているサイトの本当の割合を確認することはできませんでした。

#### 重複したID

HTMLでIDを使い２つの要素をリンクさせることができます。例えば[`<label>`要素](https://developer.mozilla.org/ja/docs/Web/HTML/Element/label)は次のように機能します。ラベルにinputフィールドのIDを指定し、ブラウザはその２つをリンクさせます。結果はどうなるか？　ユーザーはこのラベルをクリックすることでユーザーはinputフィールドにフォーカスすることが可能になり、スクリーンリーダーはこのラベルを説明として使うことができます。

残念ながら34.62％のサイトで重複したIDが確認できます、つまり多くのサイトではユーザーの指定したIDが複数の異なったinputを参照しています。そのため、ユーザーがラベルをクリックしてフィールドを選択すると、意図したものと[違う項目が選択される](https://www.deque.com/blog/unique-id-attributes-matter/)可能性を持っています。想像されている通り、これはショッピングカートのようなものに対して良くない結果をもたらす可能性があります。

この問題はユーザーが選択肢の内容を視覚的に再確認できないスクリーンリーダーユーザーに対してさらに際立ちます。そして、[`aria-describedby`](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-describedby_attribute)や[`aria-labelledby`](https://developer.mozilla.org/ja/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute)などのARIA属性は上で説明したlabel要素と同じように機能します。つまり、サイトを操作しやすくするには、最初に重複するIDを全て削除するのが良いでしょう。

## 結論

アクセシビリティを必要としているのは障害のある人々だけではありません。例えば、一時的に手首を負傷している人は小さな操作対象を触れるのが難しいと感じているはずです。視力は年齢とともに低下することが多く、小さなフォントで書かれたテキストは読みにくくなります。指の器用さは年齢毎に異なるため、かなりの割合のユーザーが対話的なコントロールに触れたり、モバイルWebサイトのコンテンツをスワイプしたりするのが難しくなっていきます。

同様に支援ソフトウェアは障害のある人のためだけでなく、すべての人の日々の体験を良くしていくためのものです。
- モバイルデバイスと家庭用の両方で音声認識が人気なのは、コンピューティングデバイスを音声コマンドで制御することが多くのユーザーにとって有意義であり不可欠であることを示しています。このような音声制御は、以前はアクセシビリティ機能にしかありませんでしたが現在では商品の主流になりつつあります。
- 運転手は道路から目を離す事無くニュース記事のような長文を読み上げるスクリーンリーダーの恩恵を受けることができるでしょう。
- 字幕はビデオを聞く事ができない人だけでなく、騒々しいレストランや、図書館でビデオを見たい人なども楽しませています。

一度Webサイトが完成すると、既存のサイト構成とウィジェットに対してアクセシビリティを改良する事は殆どの場合で困難になります。アクセシビリティは後で簡単にデコレーションすることが出来るものではなく、設計と実装のプロセスとして必要になります。しかし残念ながら、認識不足または使いやすいテストツールのせいで多くの開発者は、すべてのユーザーのニーズと支援ソフトウェアの要件に精通していません。

これは結論ではありませんが、私達の活動結果からARIAやアクセシビリティのベストプラクティス（代替テキストを使うなど）のようなアクセシビリティ標準の利用はWebの*かなりの、しかし実質的でない*部分で見つかることが示されています。表面的にはこれは励みになりますが、こういった良い方向にある事柄の多くは特定のUIフレームワークがよく利用されているからだと私達は訝しんでいます。一方、Web開発者にとってはシンプルにUIフレームワークを頼ってサイトにアクセシビリティを差し込むことはできないため、非常に期待はずれです。その一方で、UIフレームワークがWebのアクセシビリティに与える影響の大きさを確認できるのは心強いでしょう。

私達の見解では次の開拓地は、UIフレームワークを介して利用可能なウィジェットをより簡単に操作できるようになることです。世の中で使われている多くの複雑なウィジェット（カレンダーのピッカーなど）はUIライブラリなどに含まれており、こういったウィジェットがそのまま使えるのは素晴らしいことです。私達は次の結果を集める時、より適切に実装された複雑なARIAロールの利用が増えて、より複雑なウィジェットに対しても操作が簡単になっていることを願っています。そして、すべてのユーザーがウェブの豊かさを楽しむことが出来るよう、映画やビデオなどがさらにアクセスしやすいメディアとなった未来を見たいと思います。
