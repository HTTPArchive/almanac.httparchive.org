---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 生成AI
description: 2025年版Web Almanacの生成AIチャプター。ローカルブラウザベースAIへの移行、WebNNとBuilt-in AIの採用、llms.txtのような新しい発見可能性標準、そしてウェブ上でのAIフィンガープリントの出現を網羅。
hero_alt: AI支援ウェブ開発ワークフローを示すヒーロー画像。AI生成を示す星印が付いたソースコードと画像アセットが、赤いキャラクターがトークンを供給し青い脳型キャラクターがプロセスを監督するパイプラインに流れ込み、ブラウザウィンドウに表示された完全レンダリングされたウェブページが生成される。
authors: [christianliebel, Yash-Vekaria, JonathanPagel]
reviewers: [tomayac, umariqbal, webmaxru]
analysts: [JonathanPagel, christianliebel, tomayac]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1q_hFsWlt6DZMmwnxrTmU3nCRjT2w38AomAlw8b_lthE/edit
christianliebel_bio: Christian Liebel（修士）は、<a hreflang="en" href="https://w3ctag.org/">W3C技術アーキテクチャグループ</a>（TAG）の選出メンバー、<a hreflang="en" href="https://webmachinelearning.github.io/">W3C Web Machine Learning</a>（WebML）コミュニティグループおよびワーキンググループの参加者、そしてWeb AIのGoogle Developer Expert（GDE）です。
Yash-Vekaria_bio: Yash Vekariaは<a hreflang="en" href="https://www.ucdavis.edu/">カリフォルニア大学デービス校</a>のコンピュータサイエンス博士候補者です。ウェブベースの大規模インターネット計測を行い、ウェブのダイナミクスの研究と改善に取り組んでいます。特に、オンライントラッキング慣行とユーザープライバシー問題の研究と透明性向上に焦点を当てています。
JonathanPagel_bio: Jonathan Pagelは学士課程でeコマースを学び、以来この分野、特にショップやウェブサイトの速度最適化とアクセシビリティに関心を持っています。現在はこの分野でフリーランスとして活動しながら、AI・社会論の修士号取得を目指しています。
featured_quote: 2025年、生成AIはクラウド専用技術から基本的なブラウザコンポーネントへと移行しました。
featured_stat_1: 591%
featured_stat_label_1: WebGPU採用率の増加
featured_stat_2: 340%
featured_stat_label_2: WebLLM npmダウンロード数の増加
featured_stat_3: 4.5%
featured_stat_label_3: OpenAIのGPTBot向けに`robots.txt`ルールを定義しているウェブサイト
doi: 10.5281/zenodo.18246438
---

## はじめに

2022年11月30日、<a hreflang="en" href="https://openai.com/index/chatgpt/">OpenAIはChatGPTを公開しました</a>。このサービスは _生成的人工知能_ （生成AI）を研究室から<a hreflang="en" href="https://openai.com/index/how-people-are-using-chatgpt/#:~:text=Given%20the%20sample%20size%20and%20700%20million%20weekly%20active%20users%20of%20ChatGPT">数百万人の日常生活へ</a>と一気に引き上げました。このリリースはアプリケーションとウェブがどうあるべきかというユーザーの期待を根本から変えました。さらに、付随する _アプリケーションプログラミングインターフェース_ （API）はソフトウェア開発者に、アプリケーションを劇的にスマートにする強力なツールをもたらしました。

{{ figure_markup(
  content="700,000,000",
  caption="ChatGPTの週間アクティブユーザー数。",
  classes="big-number",
) }}

生成AIは、テキスト、ソースコード、画像、動画、音声、音楽など人間が理解できるコンテンツの処理と生成に特化した専門分野です。 _大規模言語モデル_ （LLM）はこの分野の重要なコンポーネントです。膨大なテキストデータで学習されたLLMは自然言語を解釈・生成し、開発者が初めて人間言語を効果的に処理できるようにすることでソフトウェアアーキテクチャを拡張しています。最近では生成AI機能がWindows、Office、Photoshopなどの確立されたアプリケーションにも統合されています。

生成AIがますます普及する中、この章ではウェブにおける生成AIの新興トレンドを検討します。具体的には、「Built-in AI」と「Bring Your Own AI」アプローチによって実現するローカル生成AIの使用、`llms.txt`を介した生成AIコンテンツの発見可能性、そしてコンテンツ作成とソースコードへの生成AIの影響（ _AIフィンガープリント_ ）に焦点を当てます。

## データソース

この章では、HTTP Archiveのデータセットだけでなく、<a hreflang="en" href="https://www.npmjs.com/">npm</a>のダウンロード統計、および<a hreflang="en" href="https://chromestatus.com/">Chrome Platform Status</a>や他の研究者が提供するデータも使用しています。

特に断りのない限り、[方法論](./methodology)で説明されている2025年7月のHTTP Archiveクロールを参照しています。APIの採用を検出するために、コード内の特定のAPI呼び出しの存在についてウェブサイトをスキャンしました。これはその存在を示すものであり、実行時の実際の使用状況を必ずしも示すものではありません。Chrome Platform Statusの使用データは常に、すべてのリリースチャンネルとプラットフォームにわたって、特定のAPIを少なくとも1回使用するGoogle Chromeのページロードの割合を指しています。

## 技術概要

このセクションでは、クラウドベースのAIモデルとローカルAIモデルの違いを説明し、これらのアプローチの長所と短所について議論した後、ローカル技術を詳しく検討します。

### クラウド対ローカル

ほとんどの人は、<a hreflang="en" href="https://openai.com/api/">OpenAI</a>、<a hreflang="en" href="https://ai.azure.com/">Microsoft Foundry</a>、<a hreflang="en" href="https://aws.amazon.com/de/bedrock/">AWS Bedrock</a>、<a hreflang="en" href="https://cloud.google.com/products/ai">Google Cloud AI</a>、または<a hreflang="en" href="https://platform.deepseek.com/">DeepSeekプラットフォーム</a>などのクラウドサービスを通じて生成AIを使用しています。これらのプロバイダーは膨大な計算リソースとストレージ容量にアクセスできるため、いくつかの重要な利点を提供しています：

- **高品質なレスポンス**: モデルは非常に有能で強力です。
- **高速な推論時間**: 強力なサーバーでレスポンスが素早く生成されます。
- **最小限のデータ転送**: AIモデル全体ではなく、入出力データのみを転送する必要があります。
- **ハードウェア非依存**: クライアントのハードウェアや計算リソースに関わらず動作します。

しかし、クラウドベースのモデルには欠点もあります：

- **接続性**: 安定したインターネット接続が必要です。
- **信頼性**: ネットワーク遅延、サーバーの可用性、容量制限の影響を受けます。
- **プライバシー**: データをクラウドサービスに転送する必要があり、潜在的なプライバシーの懸念が生じます。ユーザーデータが将来のモデルの反復学習に使用されているかどうかは、しばしば不明確です。
- **コスト**: 通常、サブスクリプションやAPI使用料が必要であり、ウェブサイト作者は推論のコストを負担しなければならないことが多いです。

### ローカルAI技術

クラウドベースシステムの限界は、[Web AIと呼ばれる](https://developer.chrome.com/blog/io24-web-ai-wrapup#:~:text=Web%20AI%20is%20a%20set%20of%20technologies%20and%20techniques%20to%20use%20machine%20learning%20\(ML\)%20models%2C%20client%2Dside%20in%20a%20web%20browser%20running%20on%20a%20device%27s%20CPU%20or%20GPU.)ローカルAI技術を介して推論をクライアントに移行することで対処できます。モデルはユーザーのシステムにダウンロードされるため、その _重み_ （内部モデルパラメーター）を秘密にすることはできません。そのため、このアプローチは主にオープンウェイトモデルと組み合わせて使用されますが、オープンウェイトモデルは商用のクラウドベースのクローズドウェイトモデルと比べて<a hreflang="en" href="https://www.vellum.ai/llm-leaderboard">一般的に性能が低い</a>です。<a hreflang="en" href="https://epoch.ai/data-insights/open-weights-vs-closed-weights-models">Epoch AIによると</a>、オープンウェイトモデルは平均して約3か月、最先端の性能に遅れをとっています。

{{ figure_markup(
  content="3か月",
  caption="オープンウェイトモデルが最先端性能に遅れをとる平均期間。",
  classes="big-number",
) }}

<a hreflang="en" href="https://www.w3.org/">World Wide Web Consortium</a>（W3C）の<a hreflang="en" href="https://webmachinelearning.github.io/">Web Machine Learning</a>コミュニティグループとワーキンググループは、AIを「ファーストクラスのウェブ市民」にするためにこの移行の標準化を積極的に進めています。この取り組みは2つの主要なアーキテクチャ方向に従っています：_Bring Your Own AI_ と _Built-in AI_ です。

#### Bring Your Own AI

Bring Your Own AI（BYOAI）アプローチでは、開発者がモデルをユーザーに配信する責任を担います。ウェブアプリケーションは特定のモデルバイナリをダウンロードし、ローカルハードウェア上の低レベルAPIを使用して実行します。これにより、ユースケースに特化した高度に専門化されたモデルを実行できますが、大きな帯域幅も必要とします。

AIの推論をローカルで実行するために使用できる<a hreflang="en" href="https://www.w3.org/2024/01/webevolve-series-events/media/slides/hu-ningxin.pdf#page=4">3つの処理ユニット</a>があります：

- _中央処理装置_ （CPU）：応答が速く、低遅延のAIワークロードに最適。
- _グラフィックス処理装置_ （GPU）：高スループットで、AI加速デジタルコンテンツ作成に最適。
- _ニューラル処理装置_ （NPU）または _テンソル処理装置_ （TPU）：低消費電力で、継続的なAIワークロードとバッテリー寿命のためのAIオフロードに最適。

ローカルAI推論を促進する3つの主要なAPIはWebAssembly（CPU）、WebGPU（GPU）、WebNN（CPU、GPU、NPU）です。

WebAssemblyとWebGPUの使用がAI活動を確認するわけではないことに注意することが重要です。これらは複雑な計算、3Dビジュアライゼーション、またはゲームなどのタスクに頻繁に使用される汎用APIです。

##### WebAssembly

[WebAssembly](https://developer.mozilla.org/docs/WebAssembly)はウェブのバイトコードとして機能します。C++やRustなどのさまざまなプログラミング言語で書かれたコードをWebAssemblyにコンパイルできます。開発者がユーザーのCPUでブラウザのスクリプティングエンジンによって実行される最適化された高性能コードを書くことができます。

WebAssemblyは2017年以来すべての主要なブラウザエンジンに実装されており、広範なブラウザサポートを持っています。

{{ figure_markup(
  image="genai-wasm-usage.png",
  caption="Chrome Platform Statusデータによる2025年のWebAssembly使用状況。",
  description="2025年を通じたChrome Platform StatusデータによるページロードあたりのパーセンテージでのWebAssembly使用状況の成長を示す折れ線グラフ。使用率は1月の4.44%のページロードから12月の5.64%へと線形に増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=148205691&format=interactive",
  sheets_gid="303424003"
  )
}}

<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2237">Chrome Platform Statusデータ</a>によると、WebAssemblyの使用率は2025年1月の4.44%のページロードから2025年12月の5.64%へと27%の線形成長を経験しました。2024年1月、WebAssemblyはページロードの3.37%でのみ有効でした。

##### WebGPU

[WebGPU](https://developer.mozilla.org/docs/Web/API/WebGPU_API)は[WebGL](https://developer.mozilla.org/docs/Web/API/WebGL_API)の近代的な後継であり、現代のGPUの機能をウェブに公開するために設計されています。厳密にグラフィックス用であったWebGLとは異なり、WebGPUは _コンピュートシェーダー_ のサポートを提供し、グラフィックスカード上での汎用コンピューティングを可能にします。これにより、開発者はAIモデルが必要とする大規模な並列計算をユーザーのグラフィックスカード上で直接実行できます。

WebGPUはブラウザでのAIワークロード実行の標準的な基盤となっています。2025年11月のFirefox 141のリリースにより、[WebGPUはすべての主要なブラウザエンジンで利用可能になりました](https://web.dev/blog/webgpu-supported-major-browsers)（Chromium、Gecko、WebKit）。

{{ figure_markup(
  image="genai-webgpu-usage.png",
  caption="2025年のWebGPU使用状況。",
  description="2024年7月クロールと2025年7月クロールにおけるWebGPUの使用状況（ページの割合）を比較した棒グラフ。デスクトップでは使用率が0.035%から0.243%に増加。モバイルでは0.029%から0.238%に増加。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2117448035&format=interactive",
  sheets_gid="1071092495"
  )
}}

2025年7月のHTTP ArchiveデータクロールはAPIがすべてのデスクトップサイトの0.243%とモバイルサイトの0.238%で使用されていることを示しています。全体的にはまだ小さいながらも、2024年7月クロールと比較してデスクトップで591%（0.035%から増加）、モバイルで709%（0.029%から増加）という大幅な増加を示しています。<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3888">Chrome Platform Statusデータ</a>は、2025年を通じて147%増加したページロードあたりのアクティベーションの指数的成長を示唆しています。

##### WebNN

<a hreflang="en" href="https://webnn.io/en">Web Neural Network API</a>（WebNN）は機械学習に特化した専用APIです。WebMLワーキンググループによって仕様策定され、このAPIはW3C勧告トラック—ウェブ標準となるための正式なプロセス—に位置づけられています。

WebNNはハードウェア非依存の抽象化レイヤーとして機能し、ブラウザがデバイス上で利用可能な最も効率的なハードウェアに処理をルーティングできるようにします。WebAssembly（CPUのみ）とWebGPU（GPUのみ）とは対照的に、WebNNはCPU、GPU、NPUで計算を実行できます。ネイティブに近い実行速度を達成できます。

{{ figure_markup(
  image="genai-webnn-usage.png",
  caption="Chrome Platform Statusデータによる2025年のWebNN使用状況。",
  description="2025年を通じたChrome Platform StatusデータによるページロードあたりのパーセンテージでのWebNN使用状況を示す折れ線グラフ。採用率は極めて低く変動が大きく、2月の0.000029%のページロードでピークに達しましたが、5月と7月には0%のページロードにも達しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2004233407&format=interactive",
  sheets_gid="939568069"
  )
}}

WebNNは現在活発に開発中であり、ChromeOS、Linux、macOS、Windows、Androidの<a hreflang="en" href="https://webnn.io/en/api-reference/browser-compatibility/api">Chromiumベースのブラウザ</a>でフラグの後ろに実装されています。2025年11月、<a hreflang="en" href="https://github.com/mozilla/standards-positions/issues/1215#issuecomment-3520278819">FirefoxがAPIを正式にサポートする2番目のエンジンとして参加しました</a>。WebNNがまだ実験的なAPIであることを考えると、<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/5023">Chrome Platform Statusデータ</a>によれば使用数は現在非常に低く、変動が大きく、2025年2月の最大アクティベーション率は0.000029%です。

##### ランタイム：ONNX RuntimeとTensorflow.js

<a hreflang="en" href="https://onnxruntime.ai/docs/tutorials/web/">ONNX Runtime</a>（Microsoftが開発）と<a hreflang="en" href="https://www.tensorflow.org/js">Tensorflow.js</a>（Googleが開発）は、ブラウザ上でAIモデルを直接実行するための主要なランタイムの2つです。これらのランタイムはWebAssembly、WebGPU、WebNNなどの低レベル技術の複雑さを抽象化します。

TensorFlow.jsはTensorFlowエコシステムと緊密に統合されており、学習と推論の両方をサポートしている一方、ONNX RuntimeはONNX標準を使用したクロスプラットフォーム推論に焦点を当て、複数のフレームワークからのモデルをクライアントサイドで実行できるようにしています。

{{ figure_markup(
  image="genai-runtime-downloads.png",
  caption="`@tensorflow/tfjs`と`onnxruntime-web`のnpmパッケージダウンロード数。",
  description="2025年1月から11月にかけてのAIランタイムONNX RuntimeとTensorflow.jsのnpmパッケージダウンロード数を比較した折れ線グラフ。ONNX Runtimeのダウンロード数は1月の773,018から11月の2,204,245へと急速に成長した一方、Tensorflow.jsは同期間に509,599から869,680へのみ増加しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2128444354&format=interactive",
  sheets_gid="815003361"
  )
}}

2025年1月から11月にかけて、<a hreflang="en" href="https://npm-stat.com/charts.html?package=onnxruntime-web&from=2025-01-01&to=2025-11-30">ONNX Runtimeのnpmパッケージダウンロード数は</a>185%増加し、<a hreflang="en" href="https://npm-stat.com/charts.html?package=%40tensorflow%2Ftfjs&from=2025-01-01&to=2025-11-30">TensorFlow.jsのダウンロード数</a>は70%増加し、ブラウザベースのAIへの開発者の強い関心と高まりを示しています。

##### ライブラリ：WebLLMとTransformers.js

<a hreflang="en" href="https://mlc.ai/">MLC AI</a>研究チームが開発した<a hreflang="en" href="https://webllm.mlc.ai/">WebLLM</a>は、LLMに特化した高性能なブラウザ内推論エンジンです。<a hreflang="en" href="https://www.llama.com/">Llama</a>、<a hreflang="en" href="https://azure.microsoft.com/en-us/products/phi">Phi</a>、<a hreflang="en" href="https://deepmind.google/models/gemma/">Gemma</a>、<a hreflang="en" href="https://mistral.ai/">Mistral</a>などの様々なオープンウェイトLLMをブラウザ上で直接実行できます。現在、WebLLMは推論にWebGPUを使用しています。

{{ figure_markup(
  image="genai-webllm-downloads.png",
  caption="`@mlc-ai/web-llm`のnpmパッケージダウンロード数。",
  description="2025年1月から11月にかけての`@mlc-ai/web-llm`パッケージのnpmダウンロード数を示す折れ線グラフ。ダウンロード数は1月の23,425から11月の103,084へと340%増加し、7月の57,114から8月の102,440へとほぼ倍増する大きなスパイクが8月に発生しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=672596885&format=interactive",
  sheets_gid="87936740"
  )
}}

WebLLMはブラウザ内LLM推論の最も注目すべきソリューションの1つとして急速に台頭しました。2025年1月から11月にかけて、<a hreflang="en" href="https://npm-stat.com/charts.html?package=%40mlc-ai%2Fweb-llm&from=2025-01-01&to=2025-11-30">npmからのWebLLMパッケージのダウンロード数</a>は340%増加しました。8月だけでダウンロード数がほぼ倍増しました。このサージを特定のイベントに帰因することはできませんでした。

<a hreflang="en" href="https://huggingface.co/">Hugging Face</a>が開発した<a hreflang="en" href="https://huggingface.co/docs/transformers.js/index">Transformers.js</a>は、人気のPython `transformers` APIを模倣した包括的なJavaScriptライブラリとして機能します。内部ではONNX Runtimeに依存して実行されます。LLMだけでなく、シンプルな高レベルパイプラインを通じてさまざまなタスクの事前学習済みモデルを実行できます。

{{ figure_markup(
  image="genai-tfjs-downloads.png",
  caption="`@huggingface/transformers`のnpmパッケージダウンロード数。",
  description="2025年1月から11月にかけての`@huggingface/transformers`パッケージのnpmダウンロード数を示す折れ線グラフ。ダウンロード数は1月の240,389から11月の719,103へとほぼ3倍になりました。トレンドは8月の大きなスパイクを示しており、年初来ピークの758,393に達しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1045307255&format=interactive",
  sheets_gid="303133226"
  )
}}

2025年1月から11月にかけて、<a hreflang="en" href="https://npm-stat.com/charts.html?package=%40huggingface%2Ftransformers&from=2025-01-01&to=2025-11-30">npmパッケージのダウンロード数</a>はほぼ3倍になり、2025年8月にも顕著なサージが見られました。

#### Built-in AI

[Built-in AI](https://developer.chrome.com/docs/ai/built-in)はGoogleとMicrosoftが推進するイニシアティブで、ウェブ開発者に高レベルのAI APIを提供することを目指しています。BYOAIとは異なり、このアプローチはブラウザ自身が提供するモデルを活用します。開発者は特定のモデルを指定できませんが、この方法によりすべてのウェブサイトが同じモデルを共有でき、一度だけダウンロードすれば良いことを意味します。

このイニシアティブは複数のAPIで構成されています：

- **Prompt API**: 開発者にローカルLLMへの低レベルアクセスを提供します。
- タスク固有のAPI：
  - **Writing Assistance APIs**: テキストの要約、執筆、リライトを行います。
  - **Proofreader API**: テキスト内の誤りを発見・修正します。
  - **Language Detector** と **Translator APIs**: テキストコンテンツの言語を検出し、別の言語に翻訳します。

すべてのAPIはWebMLコミュニティグループ内で仕様策定されており、まだインキュベーション中でW3C勧告トラックには載っていません。一部のAPIはすでに一般提供されていますが、[他はブラウザフラグの有効化が必要](https://developer.chrome.com/docs/ai/built-in-apis)だったり、[Origin Trial](https://developer.chrome.com/docs/web-platform/origin-trials)中で有効化に登録済みトークンが必要です—安定していて本番機能の出荷に広く利用可能なWebGPUとは異なります。

{{ figure_markup(
  image="genai-typings-downloads.png",
  caption="`@types/dom-chromium-ai`のnpmパッケージダウンロード数。",
  description="2025年1月から11月にかけての`@types/dom-chromium-ai`パッケージのnpmダウンロード数を示す折れ線グラフ。ダウンロード数は1月の2,653から始まり、8月の25,770でピークに達し、11月の12,478へと緩やかに減少しました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=83152267&format=interactive",
  sheets_gid="232169116"
  )
}}

Built-in AI向けのTypeScriptタイピングを含む<a hreflang="en" href="https://www.npmjs.com/package/@types/dom-chromium-ai">`@types/dom-chromium-ai`パッケージ</a>の<a hreflang="en" href="https://npm-stat.com/charts.html?package=%40types%2Fdom-chromium-ai&from=2025-01-01&to=2025-11-30">ダウンロード数</a>は、APIの実験的なステータスを反映しているかもしれません：ダウンロード数は2025年8月に25,770でピークに達し、その後緩やかに減少しました。このトレンドは開発者が実験的なAPIの採用に慎重であることを示唆しているかもしれません。ただし、タイピングパッケージのダウンロード統計はAPIの実際の使用状況を反映していない場合があります。

##### Prompt API

Prompt APIは、ChromeでGemini Nano（<a hreflang="en" href="https://store.google.com/intl/en/ideas/articles/gemini-nano-offline/">Gemini Nano</a>）やEdgeでPhi-4-mini（<a hreflang="en" href="https://learn.microsoft.com/en-us/microsoft-edge/web-platform/prompt-api">Phi-4-mini</a>）など、ユーザーのブラウザが提供するLLMにアクセスするための標準化されたインターフェースを導入します。これらの一度だけダウンロードするモデルを活用することで、APIはモデルの重みダウンロードを必要とするライブラリに関連する帯域幅の障壁とコールドスタートの遅延を解消します。

しかし、2025年12月時点では技術は移行段階にあります：[Chrome 138のブラウザ拡張機能では完全に出荷されています](https://developer.chrome.com/docs/ai/prompt-api)が、ウェブページのアクセスはまだOrigin Trialに制限されています。このAPIは現在モバイルデバイスでは利用できません。

{{ figure_markup(
  image="genai-prompt-api-adoption.png",
  caption="Prompt APIの採用状況。",
  description="2025年7月クロール時のデスクトップとモバイルサイトにおけるPrompt APIの採用状況を比較した棒グラフ。APIはすべてのデスクトップサイトの0.095%とモバイルサイトの0.078%で検出されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1191364409&format=interactive",
  sheets_gid="1142091854",
  sql_file="../capabilities/fugu.sql"
  )
}}

そのため、採用はまだ初期段階にあります。2025年7月（利用可能な最初の計測）のHTTP Archiveデータでは、すべてのデスクトップサイトのわずか0.095%とモバイルサイトの0.078%でAPIが検出され、標準的なユーティリティではなく実験としての現在のステータスを反映しています。

分析したサンプルサイトの多くは、外部スクリプトの[Google Publisher Tags](https://developers.google.com/publisher-tag/guides/get-started)を通じてPrompt APIを使用していました。このプロジェクトは、著者がウェブサイトに動的な広告を組み込むことを可能にします。<a hreflang="en" href="https://securepubads.g.doubleclick.net/pagead/managed/js/gpt/m202512040101/pubads_impl.js">Google Publisher Tagsスクリプト</a>はPrompt APIを使用してページのコンテンツを<a hreflang="en" href="https://github.com/InteractiveAdvertisingBureau/Taxonomies/blob/develop/Content%20Taxonomies/Content%20Taxonomy%203.1.tsv">Interactive Advertising Bureau（IAB）コンテンツ分類3.1カテゴリ</a>のリストに分類し、Summarizer API（次のセクションを参照）を使用してページのコンテンツの要約を生成し、両方をサーバーに送信します。ただし、分析中にコードブランチはアクティブではないように見えました。

##### Writing Assistance APIsとProofreader API

次に、タスク固有のAPIを検討します。<a hreflang="en" href="https://learn.microsoft.com/en-us/microsoft-edge/web-platform/writing-assistance-apis">Writing Assistance APIs</a>はプロンプトエンジニアリングの複雑さを抽象化します。同じ基盤となる埋め込みLLMを使用しますが、異なる言語的目標を達成するために特殊なシステムプロンプトを適用します：

- **Writer API**: プロンプトに基づいて新しいコンテンツを作成します
- **Rewriter API**: プロンプトに基づいて入力を言い換えます
- **Summarizer API**: テキストの要約を生成します

さらに、[Proofreader API](https://developer.chrome.com/docs/ai/proofreader-api)は開発者がテキストを校正し、文法エラーやスペルミスを修正することを可能にします。

Summarizer APIはChrome 138で出荷されました。2025年12月時点では、Writer、Rewriter、Proofreader APIはOrigin Trial中です。すべてのAPIは現在モバイルデバイスでは利用できません。

2025年7月のHTTP Archiveクロールでは、`Writer.create()`への呼び出しのみが検出されました（デスクトップサイトの0.127%とモバイルサイトの0.137%）。これは当初Writer APIの使用を示唆していましたが、手動チェックにより、サンプリングされたサイトの多くが実際には同じAPIシグネチャを共有する<a hreflang="en" href="https://github.com/protobufjs/protobuf.js/blob/827ff8e48253e9041f19ac81168aa046dbdfb041/src/writer.js#L142">Protobuf.jsのWriter</a>を使用していることが判明しました。そのため、このメトリクスのチャートは省略することにしました。

##### Translator APIとLanguage Detector API

Built-in AI APIの最後のカテゴリは[Translator APIとLanguage Detector API](https://developer.mozilla.org/docs/Web/API/Translator_and_Language_Detector_APIs)で構成されています。Writing Assistance APIsとは異なり、これらのAPIはLLMに依存せず、代わりに特殊なタスク固有のニューラルネットワークを活用しており、生成AIの厳密な定義の外に置かれます。

[APIはChrome 138で出荷されました](https://developer.chrome.com/release-notes/138#web_apis)が、現在モバイルデバイスでは利用できません。

{{ figure_markup(
  image="genai-translator-language-detector-adoption.png",
  caption="Translator APIとLanguage Detector APIの採用状況。",
  description="2025年7月クロール時のデスクトップとモバイルサイトにおけるTranslator APIとLanguage Detector APIの採用状況を比較した棒グラフ。採用率はほぼ同一で：Translator APIはデスクトップの0.277%とモバイルサイトの0.262%で検出され、Language Detector APIはデスクトップの0.276%とモバイルサイトの0.261%で検出されました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=463876937&format=interactive",
  sheets_gid="1189045533",
  sql_file="../capabilities/fugu.sql"
  )
}}

これらはBuilt-in AI APIの中で最も広い採用を達成しています。2025年7月のHTTP ArchiveクロールはTranslator APIをすべてのデスクトップサイトの0.277%とモバイルサイトの0.262%で検出し、Language Detector APIはわずか0.001%少ないサイトで使用されていました。

チェックしたサンプルサイトの多くは、Shopifyストアのアドオンとして機能するレビューツール<a hreflang="en" href="http://Judge.me">Judge.me</a>を利用していました。Judge.meは<a hreflang="en" href="https://judge.me/help/en/articles/11379816-translating-reviews-in-the-review-widget">Language DetectorとTranslator APIの両方を使用しており</a>、これが使用の密な結合の理由かもしれません：Language Detector APIはほぼ同じ絶対数のサイトに存在し、Translator APIにわずか約100サイト遅れていました。

#### ブラウザ固有のランタイム：Firefox AI Runtime

ChromiumサイドによるBuilt-in AI APIsの代替として、Firefoxは<a hreflang="en" href="https://firefox-source-docs.mozilla.org/toolkit/components/ml/index.html">Firefox AI Runtime</a>を試験的に導入しています。これはTransformers.jsとONNX Runtimeをベースにしたネイティブで動作するローカル推論ランタイムです。ただし、このランタイムはまだ一般のウェブからはアクセスできません。拡張機能や、Firefoxの<a hreflang="en" href="https://www.firefox.com/en-US/features/translate/">組み込み翻訳機能</a>などの特権的な用途にのみ使用できます。

## 発見可能性

このセクションでは、ウェブにおける生成AIの採用増加に伴うウェブの発見可能性のダイナミクスを見ていきます。AIプラットフォームやサービスがコンテンツを発見する方法に影響を与える2つの重要なアプローチ、`robots.txt`と`llms.txt`ファイルに主に焦点を当てます。

### `robots.txt`

ドメインのルートに配置された<a hreflang="en" href="https://www.robotstxt.org/">`robots.txt`ファイル</a>（例：`http://example.com/robots.txt`）は、ウェブサイトオーナーが自動化ボットに対するクロールディレクティブを宣言できるようにします。歴史的にウェブクロールは主に検索エンジンやアーカイブによって行われていました。しかし、生成AIの時代には、ウェブサイトはAIエージェントによっても、またはLLMの学習のためにインターネット規模のデータを収集するモデルプロバイダーによってもクロールされる可能性があります。その結果、ウェブサイトはこれらのクローラーへのアクセスを管理するためにますます`robots.txt`ファイルに依存しています。

<a hreflang="en" href="https://platform.openai.com/docs/bots">OpenAIがモデルのトレーニングに使用する</a>ユーザーエージェント`GPTBot`をターゲットにしたディレクティブの例を以下に示します：

```
User-Agent: GPTBot
Disallow: /
```

`robots.txt`への準拠は任意であり、アクセス制御を厳密に強制するものではないことに注意することが重要です。

{{ figure_markup(
  image="genai-robots-txt-adoption.png",
  caption="`robots.txt`の採用状況。",
  description="`robots.txt`がある場合とない場合のサイトを比較した棒グラフ。サイトの94.1%という大部分がファイルを提供しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1609639660&format=interactive",
  sheets_gid="342591090",
  sql_file="sites-with-robot-txt.sql"
  )
}}

`robots.txt`の使用は依然として非常に普及しています：分析した約1,290万サイトのうち約94.1%が少なくとも1つのディレクティブを含む`robots.txt`ファイルを持っています。

{{ figure_markup(
  image="genai-robots-txt-directives.png",
  caption="ウェブサイトランク別トップ`robots.txt`ディレクティブ。",
  description="サイトランク別に最も一般的な`robots.txt`のUser-Agentディレクティブをランク付けした棒グラフ。ワイルドカード`*`が最も一般的なディレクティブで、次に`gptbot`ディレクティブが続きます。次のAIボット`claudebot`は8位にいます。トップ1kサイトはより人気の低いサイトよりも頻繁にボットに言及する傾向があります。例えば、`gptbot`はトップ1kサイトの20.9%、トップ10kサイトの12.1%、トップ100kサイトの6.1%、トップ100万サイトの3.6%、トップ1000万サイトの4%の`robots.txt`ファイルで言及されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1897808878&format=interactive",
  width="621",
  height="845",
  sheets_gid="342591090",
  sql_file="user-agent-named.sql"
  )
}}

上図はすべてのウェブサイトで観察されたトップディレクティブを、ランク別にグループ化して示しています。ワイルドカードディレクティブ`*`が最も一般的に使用され、`robots.txt`ファイルの97.4%に存在します。これにより、サイト作者がすべてのボットに対するグローバルなルールを設定できます。2番目に多く使用されるユーザーエージェントは`gptbot`（分析ではユーザーエージェント名を小文字化したことに注意）で、[2024年の2.6%](../2024/seo#aiクローラー)から[2025年の約4.5%](../2025/seo#ai-crawlers-named-in-robotstxt)へと採用が増加しました。

他に頻繁にターゲットにされるAIボットには、<a hreflang="en" href="https://www.anthropic.com/">Anthropic</a>（`claudebot`、`anthropic-ai`、`claude-web`）、Google（`google-extended`）、OpenAI（`chatgpt-user`）、<a hreflang="en" href="https://www.perplexity.ai/">Perplexity</a>（`perplexitybot`）のものが含まれます。

AIボットをターゲットにしたディレクティブは人気サイトで著しく多く見られ、そのほぼすべてがアクセスを拒否しています。これは人気サイトがオーガニックトラフィックに悪影響を与えることなくAIクローラーを制限できるためと考えられます。全体として、`robots.txt`ファイル内でのAI固有ディレクティブの採用の明確な増加が観察されました。

### `llms.txt`

<a hreflang="en" href="https://llmstxt.org/">`llms.txt`ファイル</a>は、推論時にLLMがウェブサイトを効果的に活用できるように設計された新興のプロポーザルです。`robots.txt`と同様に、ウェブサイトのドメインのルートにホストされます（例：`https://example.com/llms.txt`）。主な違いはその機能にあります：`robots.txt`はトレーニングや推論中にクロールを許可・禁止するものをボットに指示しますが、`llms.txt`はウェブサイトのコンテンツの構造化されたLLMフレンドリーな概要を提供します。これにより、LLMはユーザーのクエリに答える際にリアルタイムでウェブサイトを効率的にナビゲートできます。

{{ figure_markup(
  image="genai-llms-txt-adoption.png",
  caption="`llms.txt`の採用状況。",
  description="`llms.txt`があるサイトとないサイトのデスクトップとモバイルを比較した棒グラフ。ファイルはデスクトップの2.13%とモバイルサイトの2.1%にのみ存在し、大多数のデスクトップの97.87%とモバイルサイトの97.9%には存在しません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1543827839&format=interactive",
  sheets_gid="187293662"
  )
}}

`llms.txt`は比較的新しいため、ウェブ上での使用は非常に限られていました。デスクトップページでは、有効な`llms.txt`エントリを示すのはわずか2.13%で、97.87%はこのファイルの証拠を示していません。モバイルページも同様のパターンを示し、2.1%のページが有効なエントリを含み、97.9%が含んでいません。

したがって、大多数のサイトはまだ`llms.txt`を通じて明示的なAIアクセス設定を示していません。存在する場合、そのファイルはアーリーアダプターがAI駆動の発見可能性を試験的に実装しているか、エージェントのユースケースを促進しているか、または _生成エンジン最適化_ （GEO）を探求していることを示します。検索エンジン最適化（SEO）とは対照的に、GEOはコンテンツをLLMやPerplexityや<a hreflang="en" href="https://search.google/ways-to-search/ai-mode/">Google AI Mode</a>などのAI対応検索ツールが容易に取り込めるようにすることに焦点を当てています。詳細については[SEO](./seo#llmstxt)章を参照してください。

## AIフィンガープリント

<a hreflang="en" href="https://chatgpt.com/">OpenAI ChatGPT</a>、<a hreflang="en" href="https://gemini.google.com/">Google Gemini</a>、<a hreflang="en" href="https://www.copilot.com/">Microsoft Copilot</a>などのサービスはすでに広く使用されています。AIの支援を受けてコンテンツが書かれることが増えています。このセクションでは、生成AIがウェブコンテンツとソースコードに与える影響を分析します。

### AIカラー

モデルは特定の単語を過剰に使用する傾向があり、それがAIフィンガープリントとして機能します。フロリダ州立大学の研究者たちは2020年から2024年にかけてPubMedに発表された研究論文を比較しました。<a hreflang="en" href="https://aclanthology.org/2025.coling-main.426.pdf">彼らの分析</a>は、「delves」という単語の使用が驚異の6,697%増加したことを明らかにしました。動詞「delve」の他の活用形も大幅に増加しました。このような指標を個々のケースをAI生成として分類するために使用すべきではありませんが、採用のトレンドを理解するためには依然として有用です。この章のこの部分では、LLMがウェブサイトを生成するために使用する一般的なパターンを掘り下げます（delve）😉。

{{ figure_markup(
  content="6,697%",
  caption="PubMedに発表された研究論文での「delves」という単語の使用増加率。",
  classes="big-number",
) }}

AI生成ウェブデザインの最も認識しやすい指標は、「<a hreflang="en" href="https://ai-engineering-trend.medium.com/the-mystery-behind-ais-purple-problem-revealed-0234afdb292e">AIパープル問題</a>」とも呼ばれる紫色とグラデーションの広範な使用です。

広く採用されているCSSフレームワーク<a hreflang="en" href="https://tailwindcss.com/">Tailwind</a>の作成者[Adam Wathan](https://x.com/adamwathan)は、<a hreflang="en" href="https://youtu.be/AG_791Y-vs4?t=86">最近のインタビュー</a>で、このトレンドは主要なAIトレーニングクロールのタイミングから生じている可能性が高いと述べました。2020年代初頭、Tailwindチームは当時のデザイントレンドを反映するためにドキュメントや例に深い紫色を多く使用していました。その結果、そのデータでトレーニングされたLLMは、現在の黒いデザインへの好みなど、より現代的なトレンドに置き換えられた美学を「固定」してしまったようです。

「AIパープル」の美学を定量化するために、ChatGPTのリリース後の年からデータセット内のすべてのルートページのCSS（ウェブサイトのスタイリングを担当）を分析しました。よく知られた`indigo-500`カラー（`#6366f1`）の存在、CSSグラデーションの使用、およびAI生成ウェブサイトに関連する他のカラーを追跡しました。

{{ figure_markup(
  image="genai-ai-colors-tailwind.png",
  caption="Tailwindページにおける「AIカラー」の経年使用状況。",
  description="2022年第3四半期以降の四半期ごとのHTTP Archiveクロールに基づき、Tailwindページにおける前述のAIカラーとindigo-500の使用状況を比較した折れ線グラフ。両方のラインは同様のパターンに従い、使用率はTailwindページの約2%前後で変動しています。どちらのカラーの使用にも顕著なサージは見られません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1045089879&format=interactive",
  width="642",
  height="417",
  sheets_gid="1065437374",
  sql_file="gradient.sql"
  )
}}

TailwindはClaude、Gemini、OpenAIモデルなどのLLMが好むフレームワークであるため、これらの指標を使用しているTailwindベースのウェブサイトの割合を特に調べました。TailwindウェブページはHTTP Archiveの<a hreflang="en" href="https://github.com/HTTPArchive/wappalyzer">Wappalyzerフォーク</a>を使用して識別されました。驚くことに、`indigo-500`または他の2つの一般的に言及されるAIカラー（`#8b5cf6`バイオレットと`#a855f7`パープル）を使用するウェブサイトに顕著なサージは見られませんでした。

{{ figure_markup(
  image="genai-ai-colors.png",
  caption="「AIカラー」の経年使用状況。",
  description="2022年第3四半期以降の四半期ごとのHTTP Archiveクロールに基づき、すべてのページにわたる前述のAIカラーとindigo-500の使用状況を比較した折れ線グラフ。使用率は2022年第3四半期の0.02%（パープル）と0.03%（indigo-500）から2025年第4四半期の0.49%（パープル）と0.54%（indigo-500）へと上昇し、indigo-500がやや人気になっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=428756366&format=interactive",
  width="642",
  height="417",
  sheets_gid="1065437374",
  sql_file="gradient.sql"
  )
}}

しかし、Tailwindフレームワークの全体的な爆発的成長により、ウェブ全体の割合として測定した場合、これらの特定のカラーは大幅な増加を示しました。

分析はCSSの変数のみに依存しており、ソースコード全体を解析すると現実的な限界を超えるためです。その結果、私たちの数値は控えめな推定値を表しています。ハードコードされた16進数値（例：`#6366f1`）や古いプリプロセッサを使用しているサイトはクエリで見えませんでした。さらに、カラーの明度を1%調整するだけでも検出を回避できます。

[「AIスロップ」](https://www.wikipedia.org/wiki/AI_slop)や紫がかったデザインに関するオンラインでの頻繁な議論にもかかわらず、HTTP Archiveデータセットの分析は、このトレンドがAIが紫を「選択した」結果というよりも、Tailwindの人気の全般的な上昇を反映しているかもしれないことを示唆しています。

グラデーション、シャドウ、特定のフォントのサージもテストしましたが、統計的に有意な増加は見られませんでした。

### バイブコーディングプラットフォーム

新たに作成されるウェブサイトの数が多い理由の1つは、ウェブサイト構築を容易にするプラットフォームの出現です。前の10年間のコンテンツ管理システム（CMS）ツールの普及後、ユーザーはそれらの制約を超えて、<a hreflang="en" href="https://v0.app/">v0</a>、<a hreflang="en" href="https://replit.com/">Replit</a>、または<a hreflang="en" href="https://lovable.dev/">Lovable</a>などのツールを使用して会話型AIを通じてウェブサイトを生成できるようになりました。これらのプラットフォームでは、独自のドメインまたはプラットフォーム提供のサブドメイン（例：`mywebsite.tool.com`）を使用してページを公開できます。

{{ figure_markup(
  image="genai-vibe-coding-subdomains.png",
  caption="バイブコーディングプラットフォームのサブドメイン。",
  description="2020年第1四半期以降の四半期クロールに基づき、HTTP Archiveデータセット全体に対するバイブコーディングプラットフォームのサブドメイン数を比較した折れ線グラフ。Vercelがトレンドをリードし、2021年から着実に上昇して2025年10月までにすべてのサイトの約0.04%に達する一方、LovableやReplitなどの新規参入者は2025年初頭から目立つ採用を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1670163713&format=interactive",
  width="797",
  height="417",
  sheets_gid="2051033428",
  sql_file="vibecodetools.sql"
  )
}}

上図はHTTP Archiveデータセット内でのバイブコーディングプラットフォームのサブドメインの相対的な成長を示しています。Vercel（`*.vercel.app`）が依然として支配的なプロバイダーですが、2023年後半のバイブコーディングツールv0（`*.v0.dev`）のリリースよりずっと前からサブドメインホスティングを提供していました。データはv0のローンチ後の即時サージを示していませんでした。Lovable（`*.lovable.app`と`*.lovable.dev`）は2025年初頭の10サブドメインから2025年10月には315に成長しました。これはデータセットで利用可能なページのみを含むことに注意してください。Lovableによると、<a hreflang="en" href="https://lovable.dev/blog/one-year-of-lovable">Lovableでは毎日100,000もの新しいプロジェクトが構築されています</a>。

### `.ai`ドメイン

{{ figure_markup(
  image="genai-ai-domain.png",
  caption="ランク別の.aiドメイン使用状況：2022年対2025年。",
  description="ChatGPTリリース前（2022年6月）と2025年7月の.aiドメイン数をサイトランク別にグループ化して比較した棒グラフ。トップ1kサイトでは、使用数は2022年の0サイトから2025年の2サイトに増加しました。トップ10kでは1から21に増加しました。トレンドは低ランクで加速：トップ100kでは17対180、トップ100万では273対1,606、トップ1000万サイトでは2,824対11,848。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=702698195&format=interactive",
  sheets_gid="8436279",
  sql_file="ai_tld.sql"
  )
}}

AIも`.ai`ドメインもChatGPT以前から存在していましたが、ChatGPT登場後に生まれた新たな可能性がAIネイティブビジネスの波をもたらしました。その多くは<a hreflang="en" href="https://www.iana.org/domains/root/db/ai.html">アンギラの国コード</a>である`.ai`トップレベルドメインを採用しました。このトレンドは、上図に示す2022年のChatGPT以前の状況と2025年の使用状況の比較が示すように、すべてのランクにわたって`.ai`ドメイン登録の大幅な増加をもたらしました。

Chromeデータセットでトップ1,000の最も訪問されたウェブサイトに入った`.ai`ドメインは、https://character.aiとアダルトサイトの2つのみでした。

## 結論

2025年、生成AIはクラウド専用技術から基本的なブラウザコンポーネントへと移行しました。BYOAIはWebAssemblyやWebGPUなどの基盤APIの成長、またWebLLMやTransformers.jsなどのライブラリに後押しされて即時採用を支配しました。同時に、Built-in AIはブラウザ内に直接標準化されたAIレイヤーの基盤を築き始めました。より制限的な`robots.txt`ファイルと歓迎的な`llms.txt`の構造の間に緊張関係が生まれています。バイブコーディングと`.ai`ドメインの台頭は、AIがアプリの機能だけでなく、アプリの構築方法も再形成していることを証明しています。

2025年を超えて見ると、次の進化の飛躍はすでに見えています：エージェントAIです。インタラクティブなチャットボットの時代から、継続的なユーザー介入なしに意思決定、マルチステップワークフローの実行、複雑なタスクの解決ができる自律エージェントへと移行しています。このシフトは、[Perplexity Comet](https://www.perplexity.ai/comet)、[ChatGPT Atlas](https://chatgpt.com/atlas/)、または[Opera Neon](https://www.operaneon.com/)などの新しいクラスの「エージェントブラウザ」の台頭をもたらしています。

これらのエージェントをウェブの広大なリソースに接続するために、[WebMCP](https://github.com/webmachinelearning/webmcp)（Web Model Context Protocol）などの新しいプロトコルが登場しています。HTTPがリソースの送信を標準化するように、WebMCPはエージェントがウェブインターフェースを認識し操作する方法を標準化することを目指しており、AIネイティブウェブが読み取り可能なだけでなく、アクション可能であることを保証します。
