---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Eコマース
description: 本章ではEコマースエコシステムのトレンドを探り、プラットフォームの採用状況、Core Web Vitals、Lighthouseの指標、決済、地域別の違いを取り上げます。WooCommerceやShopifyなどのプラットフォームがリードし、新興プレーヤーが特定の市場で成長している状況を解説します。
hero_alt: Web Almanacのキャラクターがスーパーマーケットのレジでショッピングバスケットからコンベヤーベルトに商品を載せ、別のキャラクターがクレジットカードで支払っているヒーロー画像。
authors: [AmandeepSingh]
reviewers: [tunetheweb]
analysts: [AmandeepSingh]
editors: [tunetheweb]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1tbbH4q4wzj4bpTj8ctRJ_8-NyS5KPBBcNInkemfxcR8
AmandeepSingh_bio: Amandeep Singhは2009年からウェブ開発に携わり、フロントエンド開発、UI/UX、Shopify、BigCommerce、WordPress、プログラミングについて<a hreflang="en" href="https://byaman.com/">byaman.com</a>でブログを書いています。ライター、メンター、スピーカーとして活動しています。
featured_quote: Eコマースプラットフォームは多様で異なるプロバイダーに分散していますが、決済システムなどのテクノロジーでは少数のキープレーヤーが支配しています。
featured_stat_1: 19%
featured_stat_label_1: Eコマースサイトであるモバイルサイトの割合
featured_stat_2: 44%
featured_stat_label_2: WooCommerceで構築されたモバイルEコマースサイトの割合
featured_stat_3: 3.5%
featured_stat_label_3: PayPalを決済手段として提供するモバイルサイトの割合
doi: 10.5281/zenodo.18258559
---

## はじめに

Eコマースはウェブにおける特別なケースではなくなりました。今やEコマース _こそが_ ウェブです。2025年には、購買の旅は検索結果、ソーシャルフィード、ライブストリームから始まり、音声アシスタント、メッセージアプリ、スマートTVのようなリーンバック型のサービスへと続き、さらにはAIエージェントが買い物客の代わりに完結させることも増えています。Eコマースサイトは依然として物理的またはデジタル製品を販売するオンラインストアですが、今やプロダクトページ、決済、パフォーマンス、アクセシビリティ、信頼の交差点に位置しています。

オンラインストアを構築する際、いくつかの一般的なプラットフォームモデルがあります：

1. **Software-as-a-Service（SaaS）** プラットフォーム（例：Shopify）は、コードベースを管理してホスティングを抽象化することで、ストア運営に必要な技術的知識を最小化します。
2. **Platform-as-a-Service（PaaS）** ソリューション（例：Adobe Commerce / Magento）は、完全なコードアクセスを許可しながら最適化されたテクノロジースタックとホスティング環境を提供します。
3. **セルフホスト型**プラットフォーム（例：WooCommerce、OpenCart）は、マーチャントまたはその代理店が管理するインフラストラクチャ上で動作します。
4. **ヘッドレス / APIファースト**プラットフォーム（例：Commercetools、Medusa）は、コマースバックエンドをサービスとして提供し、マーチャントがフロントエンドのエクスペリエンスとホスティングを所有します。
5. **エージェンティックコマース（エージェント対応コマース）** レイヤーはストアフロントの横（または上）に位置します：構造化された製品データ、在庫、ポリシー、アイデンティティ、決済フローがAPIと標準を通じて公開され、アシスタントとAIエージェントが明確なユーザーの同意とガードレールのもとで製品を安全に見つけて購入を実行できます。

プラットフォームは複数のカテゴリーに該当する場合があります。たとえば、一部のベンダーはSaaS、PaaS、セルフホスト型オプションを提供しており、多くのヘッドレスビルドは内部でSaaSバックエンドに依存しています。重要な変数は、誰がホスティングを管理するか、誰がランタイムとアップグレードパスを管理するか、フロントエンドとバックエンドを変更する自由がどれだけあるかです。

## プラットフォームの検出

ウェブサイトが使用する技術を検出するためにWappalyzerというツールを使用しました。EコマースプラットフォームやコンテンツマネジメントシステムやJavaScriptフレームワーク、アナリティクスなどを検出できます。

この分析では、以下のいずれかが検出された場合にサイトをEコマースと見なしました：

- 既知のEコマースプラットフォームの使用、または
- オンラインストアを強く示唆する技術の使用（例：拡張Eコマースアナリティクス）。

### Eコマースサイトの認識における制限事項

私たちの方法論には精度に影響する制限事項があります。

- WappalyzerがEコマースプラットフォームまたは強力なEコマースシグナルを検出した場合にのみEコマースサイトを認識できます。
- 決済処理業者だけの検出（例：PayPal）はサイトをEコマースとして分類するのに十分ではありません。なぜなら多くの非ストアサイトも支払いを受け付けるからです。
- ストアがサブディレクトリでホストされている場合、見逃される可能性があります。サイトごと、クライアント（デスクトップとモバイル）ごとにホームページと他の1ページ（最大の内部リンク）をクロールします。
- ヘッドレス実装はHTML/JSの従来のフィンガープリントが消えることが多いため、プラットフォームの検出可能性を低下させます。
- 明らかなトレンドは、業界の変化だけでなく、検出の改善や後退によって影響を受ける場合があります。
- クロールの地理は重要です：サイトが位置に基づいてリダイレクトする場合、結果が異なる場合があります。
- 基礎となるサイトセットはChromeのフィールドデータエコシステムから抽出されており、Chromeユーザーが訪問するサイトに偏りがあります。

## 全体的な採用状況

{{ figure_markup(
  caption="Eコマースサイトであるモバイルページの割合。",
  content="19.2%",
  classes="big-number",
  sheets_gid="1784928999",
  sql_file="counts.sql"
  )
}}

2025年のデータセットでは、分析した全デスクトップサイトの19.9%と全モバイルサイトの19.2%がEコマースサイトとして検出されました。

この数字は、Eコマースが単なる「一つのバーティカル」ではなく、オープンウェブで実際のユーザーが体験するものの大きな部分を占めていることを改めて示しています。

### ランク別の採用状況

一般的に、最も人気のあるサイトはプロフェッショナルに設計され、大幅に最適化され、より多くの予算で支えられている可能性が高いです。

{{ figure_markup(
  image="adoption-by-rank.png",
  caption="ランク別のEコマース採用状況。",
  description="ウェブサイトのグローバルトラフィックランクに応じてEコマースプラットフォームの採用がどのように大きく異なるかを示す棒グラフ。採用率は上位1,000サイトでわずか1%と最も低いですが、ランクが拡大して低トラフィックサイトを含めるようになると採用率は着実に上昇し、上位1,000万サイトではデスクトップで22%、モバイルで21%でピークに達しています。すべてのランクグループで、デスクトップの採用率は一貫してモバイルより1〜2パーセントポイント高いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlrzXpWshCjsSpSxJnhK5A732UtlRUtWfbtSt39JlV1rbI1YRoA1fRLWUr05vJBKNsS-i7ReTMudhN/pubchart?oid=1753144638&format=interactive",
  sheets_gid="1784928999",
  sql_file="counts.sql"
  )
}}

パターンは一貫しています：

- Eコマースであるサイトの割合は、人気の低いサイトを含めるほど増加します。
- ウェブの最上位（上位1,000）では、Eコマースは存在しますが稀です。
- ランクが下がるにつれて増加します。
- 上位1,000万に達する頃には、5サイトに1つ程度がオンラインストアです。

### 採用トレンド

{{ figure_markup(
  image="adoption-by-year.png",
  caption="年別のEコマース採用状況。",
  description="経年での全体的なEコマース採用状況を示す棒グラフ。2024年と2025年の間で、Eコマースとして識別されたデスクトップサイトの割合は20%で横ばいになり、モバイルの採用も19%で安定しています。これは2022年から両プラットフォームが17%の採用率から始まった段階的な拡大の期間に続くものです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlrzXpWshCjsSpSxJnhK5A732UtlRUtWfbtSt39JlV1rbI1YRoA1fRLWUr05vJBKNsS-i7ReTMudhN/pubchart?oid=1949187093&format=interactive",
  sheets_gid="1784928999",
  sql_file="counts.sql"
  )
}}

時間の経過に伴うトレンドを見ると、前年比で緩やかな増加が見られます。

## プラットフォームの市場シェア

デスクトップとモバイルの両方で、プラットフォームのランドスケープは上位に偏ったままです：少数のシステムが検出されたストアの大半を占め、ニッチおよび地域的なプラットフォームの長いテールが残りを埋めています。

以下の表は、Eコマース内で検出されたEコマースサイトのシェア（プラットフォームの市場シェア）と、データセット内のすべてのサイトで各プラットフォームが表示される頻度を示しています。

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>Eコマースサイトの%</th>
        <th>全サイトの%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">35.4%</td>
        <td class="numeric">7.1%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">21.5%</td>
        <td class="numeric">4.3%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">9.1%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">7.8%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">3.2%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="デスクトップで最も人気のあるEコマースプラットフォーム。",
      sheets_gid="1752605080",
      sql_file="top_ecommerce.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>Eコマースサイトの%</th>
        <th>全サイトの%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">44.4%</td>
        <td class="numeric">7.0%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">25.3%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">11.1%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">9.9%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">3.7%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Square Online</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="モバイルで最も人気のあるEコマースプラットフォーム。",
      sheets_gid="1752605080",
      sql_file="top_ecommerce.sql",
    ) }}
  </figcaption>
</figure>

### 2024年以降のトレンド

ここ数年を俯瞰すると、話は混乱よりも緩やかな統合に関するものです。

- WooCommerceは最大のエコシステムであり続け、ほぼ横ばいを維持しています（2024年から2025年にかけてEコマースサイトの約36% → 36%）。
- Shopifyはシェアを拡大し続けています（約20% → 21%）。
- Wix eCommerceはトップ5で最も急成長しています（約7% → 8%）。
- PrestaShopはシェアが下降トレンドを続けています（約4% → 3%）。

言い換えると：デフォルトの選択肢がさらにデフォルトになっており、小規模なオープンソースのエコシステムは開発者エクスペリエンス、ホスティングのシンプルさ、デフォルトのパフォーマンスでより激しく競争しなければならなくなっています。

### ティア別上位プラットフォーム

ティアが異なれば上位のプラットフォームも異なります。

<figure>
  <table>
    <thead>
      <tr>
        <th>順位</th>
        <th>上位1,000</th>
        <th>上位10,000</th>
        <th>上位100,000</th>
        <th>上位1,000,000</th>
        <th>上位10,000,000</th>
        <th>全体</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Amazon Webstore</td>
        <td>Amazon Webstore</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Magento</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>Pattern by Etsy</td>
        <td>SAP Commerce Cloud</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td></td>
        <td>Magento</td>
        <td>Amazon Webstore</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
        <td>Wix eCommerce</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td></td>
        <td>Shopify</td>
        <td>WooCommerce</td>
        <td>1C-Bitrix</td>
        <td>Wix eCommerce</td>
        <td>PrestaShop</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ランクティア別上位プラットフォーム（デスクトップ）。",
      sheets_gid="301153684",
      sql_file="top_vendors_crux_rank.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>順位</th>
        <th>上位1,000</th>
        <th>上位10,000</th>
        <th>上位100,000</th>
        <th>上位1,000,000</th>
        <th>上位10,000,000</th>
        <th>全体</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Magento</td>
        <td>Amazon Webstore</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Amazon Webstore</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>Pattern by Etsy</td>
        <td>SAP Commerce Cloud</td>
        <td>Salesforce Commerce Clous</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
        <td>Wix eCommerce</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td></td>
        <td>Magento</td>
        <td>Amazon Webstore</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td></td>
        <td>Shopify</td>
        <td>WooCommerce</td>
        <td>1C-Bitrix</td>
        <td>Wix eCommerce</td>
        <td>PrestaShop</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ランクティア別上位プラットフォーム（モバイル）。",
      sheets_gid="301153684",
      sql_file="top_vendors_crux_rank.sql",
    ) }}
  </figcaption>
</figure>

- 最上位のランクでは、エンタープライズおよびカスタムエコシステムがより多く登場します。
- より広いウェブでは、ロングテールの勝者（特にWooCommerce）が数量で支配しています。

### 地域別上位プラットフォーム

プラットフォームの優勢は、言語、地域の決済レール、エージェンシーエコシステム、ベンダーの歴史的なフットプリントにより地域によって異なります。

{{ figure_markup(
  image="top-ecommerce-platform-by-country.png",
  caption="2025年の国別上位Eコマースプラットフォーム。",
  description="2025年の国別で最も人気のあるEコマースプラットフォームを示すマップ。WooCommerceはほとんどの地域でリードしており、ShopifyとTiendanube、Shoptet、Cafe24、Sallaなどの地域リーダーが続いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlrzXpWshCjsSpSxJnhK5A732UtlRUtWfbtSt39JlV1rbI1YRoA1fRLWUr05vJBKNsS-i7ReTMudhN/pubchart?oid=571594362&format=interactive",
  sheets_gid="2084734046",
  sql_file="top_shopsystem_by_geo.sql"
  )
}}

3つの主要プラットフォームがほとんどの国でトップを占めています：WooCommerce（バイオレット）、Shopify（グリーン）、1C-Bitrix（レッド）。

- デスクトップでは、WooCommerceは国別ビューの59の地域のうち42の地域で最も一般的なプラットフォームです（ALL集計を除く）。
- モバイルでは、WooCommerceはさらに多くの地域でリードしています：89のうち71（ALL集計を除く）。

意味のある地域的な例外もあります：

- 1C‑Bitrixは東ヨーロッパと中央アジアの一部（例：ロシア連邦、ベラルーシ、カザフスタン、キルギスタン）でリードしています。
- Tiendanubeはアルゼンチンで際立っています。
- Shoptetはチェコで主要プラットフォームとして登場します。
- Cafe24は韓国でリードしています。
- Sallaはサウジアラビアで強い存在感を示しています。

## EコマースにおけるCore Web Vitals

Eコマースサイトはパフォーマンスに特に敏感です。なぜなら1秒の追加ごとに影響が複合するからです：カテゴリーページが遅くなると商品閲覧数が減り、商品ページが遅くなるとカートへの追加が減り、チェックアウトフローが遅くなるとコンバージョンが減ります。

実際のユーザーエクスペリエンスを要約するためにCore Web Vitals（CWV）フィールド指標を使用します：

- **LCP（Largest Contentful Paint）：** _読み込み_ パフォーマンスを測定します。メインコンテンツがどれだけ早く表示されるかを捉えます。Eコマースでは、ヒーロー画像、商品グリッド、レンダリングをブロックする重要なCSS/JSにマッピングされることが多いです。
- **INP（Interaction to Next Paint）：** _応答性_ を測定します。ユーザーアクション（タップ/クリック）と次のビジュアル更新の間の遅延を捉えます。重いJavaScript、サードパーティタグ、メインスレッドの競合に敏感です。
- **CLS（Cumulative Layout Shift）：** _視覚的安定性_ を測定します。ページの読み込み中にコンテンツがどれだけシフトするかを捉えます。遅れて読み込まれる商品画像、パーソナライゼーションウィジェット、プロモバナーが誤クリックを引き起こす可能性があるため、Eコマースで特に重要です。

CWVで「良い」とみなされるサイトは3つのすべての閾値を通過したものです。

{{ figure_markup(
  image="top-ecommerce-passes-cwv-rates.png",
  caption="上位EコマースプラットフォームのCWV通過率。",
  description="2025年の主要プラットフォームにわたって良いCore Web Vitalsを持つデスクトップEコマースオリジンのシェアを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlrzXpWshCjsSpSxJnhK5A732UtlRUtWfbtSt39JlV1rbI1YRoA1fRLWUr05vJBKNsS-i7ReTMudhN/pubchart?oid=1694550596&format=interactive",
  sheets_gid="755277706",
  sql_file="core_web_vitals_by_platform.sql",
  width="600",
  height="525"
  )
}}

### プラットフォーム別CWV

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>オリジン数</th>
        <th>良好なLCP</th>
        <th>良好なINP</th>
        <th>良好なCLS</th>
        <th>良好なCWV</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">394,462</td>
        <td class="numeric">45%</td>
        <td class="numeric">99%</td>
        <td class="numeric">68%</td>
        <td class="numeric">33%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">289,885</td>
        <td class="numeric">92%</td>
        <td class="numeric">99%</td>
        <td class="numeric">82%</td>
        <td class="numeric">76%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">80,900</td>
        <td class="numeric">90%</td>
        <td class="numeric">100%</td>
        <td class="numeric">78%</td>
        <td class="numeric">69%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">55,706</td>
        <td class="numeric">77%</td>
        <td class="numeric">99%</td>
        <td class="numeric">91%</td>
        <td class="numeric">70%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">45,256</td>
        <td class="numeric">74%</td>
        <td class="numeric">99%</td>
        <td class="numeric">72%</td>
        <td class="numeric">54%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">36,988</td>
        <td class="numeric">59%</td>
        <td class="numeric">99%</td>
        <td class="numeric">55%</td>
        <td class="numeric">36%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">31,150</td>
        <td class="numeric">86%</td>
        <td class="numeric">99%</td>
        <td class="numeric">80%</td>
        <td class="numeric">68%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">14,452</td>
        <td class="numeric">87%</td>
        <td class="numeric">99%</td>
        <td class="numeric">80%</td>
        <td class="numeric">70%</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">13,661</td>
        <td class="numeric">98%</td>
        <td class="numeric">100%</td>
        <td class="numeric">46%</td>
        <td class="numeric">45%</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">12,376</td>
        <td class="numeric">91%</td>
        <td class="numeric">99%</td>
        <td class="numeric">60%</td>
        <td class="numeric">55%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="上位EコマースプラットフォームのCore Web Vitals良好率（デスクトップ）。",
      sheets_gid="755277706",
      sql_file="core_web_vitals_by_platform.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>オリジン数</th>
        <th>良好なLCP</th>
        <th>良好なINP</th>
        <th>良好なCLS</th>
        <th>良好なCWV</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">995,782</td>
        <td class="numeric">39%</td>
        <td class="numeric">88%</td>
        <td class="numeric">85%</td>
        <td class="numeric">35%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">567,932</td>
        <td class="numeric">86%</td>
        <td class="numeric">90%</td>
        <td class="numeric">92%</td>
        <td class="numeric">76%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">234,055</td>
        <td class="numeric">76%</td>
        <td class="numeric">85%</td>
        <td class="numeric">95%</td>
        <td class="numeric">66%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">209,650</td>
        <td class="numeric">76%</td>
        <td class="numeric">96%</td>
        <td class="numeric">89%</td>
        <td class="numeric">69%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">87,486</td>
        <td class="numeric">65%</td>
        <td class="numeric">89%</td>
        <td class="numeric">81%</td>
        <td class="numeric">50%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">76,080</td>
        <td class="numeric">71%</td>
        <td class="numeric">71%</td>
        <td class="numeric">86%</td>
        <td class="numeric">50%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">50,983</td>
        <td class="numeric">52%</td>
        <td class="numeric">87%</td>
        <td class="numeric">64%</td>
        <td class="numeric">35%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">32,914</td>
        <td class="numeric">80%</td>
        <td class="numeric">93%</td>
        <td class="numeric">88%</td>
        <td class="numeric">68%</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">21,836</td>
        <td class="numeric">60%</td>
        <td class="numeric">95%</td>
        <td class="numeric">84%</td>
        <td class="numeric">51%</td>
      </tr>
        <tr>
        <td>Square Online</td>
        <td class="numeric">18,812</td>
        <td class="numeric">0%</td>
        <td class="numeric">39%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="上位EコマースプラットフォームのCore Web Vitals良好率（モバイル）。",
      sheets_gid="755277706",
      sql_file="core_web_vitals_by_platform.sql",
    ) }}
  </figcaption>
</figure>

いくつかのパターンが繰り返し現れます：

- INPはほとんどの主要プラットフォームでデスクトップ全体で一般的に強く、現代のJSスタックとブラウザの改善が応答性を助けていることを示唆しています。
- LCPが最大の差別化要因です。高速なテーマと厳密に管理されたアプリエコシステムを持つプラットフォームはより良いスコアを獲得する傾向があります。
- WooCommerceは規模を持っていますが、自動的なスピードはありません：そのCWV通過率はSaaS重視のエコシステムよりも遅れており、これは無限のカスタマイズという性質と一致しています。

## Lighthouse

Lighthouseは HTTP Archiveのラボベースの監査ツールです。Core Web Vitals（フィールドデータ）とは異なり、制御された環境（シミュレートされたデバイス、スロットルされたネットワーク/CPU）で実行され、パフォーマンス、アクセシビリティ、SEO、ベストプラクティスのスコアを生成します：

- **パフォーマンス**：Lighthouseパフォーマンスは制御されたテストプロファイル下での読み込みと応答性を要約するラボスコア（0〜100）です。プラットフォーム間の相対比較に最も役立ちます。
- **アクセシビリティ**：Lighthouseアクセシビリティは自動チェックに基づいています（すべてを捉えることはできません）が、ラベルの欠如、低コントラスト、不正確なセマンティクスなどの一般的な問題の有用なベースラインシグナルです。
- **SEO**：LighthouseのSEOスコアは技術的なSEOの基礎（例：タイトル/メタ、基本的なクロール可能性シグナル）を反映しています。これらのチェックは通過しやすいため、高い中央値が一般的です。
- **ベストプラクティス**：ベストプラクティスはセキュリティと信頼性のチェック（HTTPS、安全なJSパターン、最新のAPI）の集合体です。プラットフォームのデフォルトとテーマの品質を反映することが多いです。

Lighthouseはテストプロファイルを標準化するため、大規模なサイトセット間の比較に役立ちますが、フィールドデータはデバイス、ネットワーク、地域、ユーザー行動の実際の組み合わせを反映するため、実際のユーザーが体験するものと完全には一致しません。

### プラットフォーム別Lighthouseスコアの中央値

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>全サイトの%</th>
        <th>パフォーマンス（中央値）</th>
        <th>アクセシビリティ（中央値）</th>
        <th>SEO（中央値）</th>
        <th>ベストプラクティス（中央値）</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">7.10%</td>
        <td class="numeric">61</td>
        <td class="numeric">87</td>
        <td class="numeric">92</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">4.32%</td>
        <td class="numeric">71</td>
        <td class="numeric">90</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">1.84%</td>
        <td class="numeric">65</td>
        <td class="numeric">94</td>
        <td class="numeric">92</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">1.57%</td>
        <td class="numeric">88</td>
        <td class="numeric">96</td>
        <td class="numeric">100</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">0.64%</td>
        <td class="numeric">59</td>
        <td class="numeric">78</td>
        <td class="numeric">92</td>
        <td class="numeric">81</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">0.47%</td>
        <td class="numeric">58</td>
        <td class="numeric">75</td>
        <td class="numeric">92</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">60</td>
        <td class="numeric">78</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">0.23%</td>
        <td class="numeric">63</td>
        <td class="numeric">79</td>
        <td class="numeric">91</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">0.20%</td>
        <td class="numeric">39</td>
        <td class="numeric">69</td>
        <td class="numeric">85</td>
        <td class="numeric">56</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">72</td>
        <td class="numeric">81</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="最も人気のあるEコマースプラットフォームのLighthouseスコア（デスクトップ）。",
      sheets_gid="1765174321",
      sql_file="median_lighthouse_score_ecommsites.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>プラットフォーム</th>
        <th>全サイトの%</th>
        <th>パフォーマンス（中央値）</th>
        <th>アクセシビリティ（中央値）</th>
        <th>SEO（中央値）</th>
        <th>ベストプラクティス（中央値）</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">7.03%</td>
        <td class="numeric">38</td>
        <td class="numeric">87</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">4.01%</td>
        <td class="numeric">55</td>
        <td class="numeric">91</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">1.75%</td>
        <td class="numeric">64</td>
        <td class="numeric">95</td>
        <td class="numeric">100</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">1.56%</td>
        <td class="numeric">30</td>
        <td class="numeric">94</td>
        <td class="numeric">92</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">0.59%</td>
        <td class="numeric">36</td>
        <td class="numeric">79</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">0.53%</td>
        <td class="numeric">35</td>
        <td class="numeric">75</td>
        <td class="numeric">92</td>
        <td class="numeric">61</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">0.34%</td>
        <td class="numeric">34</td>
        <td class="numeric">79</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">0.23%</td>
        <td class="numeric">43</td>
        <td class="numeric">78</td>
        <td class="numeric">91</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">50</td>
        <td class="numeric">92</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>Square Online</td>
        <td class="numeric">0.14%</td>
        <td class="numeric">13</td>
        <td class="numeric">85</td>
        <td class="numeric">92</td>
        <td class="numeric">57</td>
      </tr>
      </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="最も人気のあるEコマースプラットフォームのLighthouseスコア（モバイル）。",
      sheets_gid="1765174321",
      sql_file="median_lighthouse_score_ecommsites.sql",
    ) }}
  </figcaption>
</figure>

いくつかのハイレベルなパターン：

- SaaSストアフロントはパフォーマンスカテゴリーで高い方に集中する傾向があります（特にデスクトップで）。これはテーマとデフォルトのより厳密な管理と一致しています。
- アクセシビリティの中央値は上位プラットフォームで一般的に強いですが、中央値はロングテールの変動を隠す可能性があります。
- SEOとベストプラクティスのスコアはほとんどのプラットフォームで高い。チームが通常勝つか負けるかは、基本的な技術的SEOではなく、パフォーマンスと実装の規律です。

## 決済事業者

決済はEコマースが現実になる場所です。また、サードパーティのスクリプト、リダイレクト、不正防止ツール、コンプライアンスの制約という重大な依存関係の領域でもあります。

{{ figure_markup(
  image="payment-provider-distribution.png",
  caption="2025年のEコマースサイトにおける決済プロバイダーの分布。",
  description="PayPalがデスクトップサイトの2.2%、モバイルサイトの2.0%以上に表示されて支配的な決済プロバイダーとして識別する棒グラフ。Apple Pay（1.5%）やShop Pay（1.4%）などの他の主要なデジタルウォレットが続き、デジタルウォレットがEコマース成長の65%を牽引すると予測される2025年の幅広いトレンドを反映しています。興味深いことに、VisaやMastercardなどの従来のカードネットワークは1.2%と直接サイト統合が低く、消費者はより安全な「ワンクリック」デジタルウォレットインターフェースを通じてこれらのカードを使用することをますます好んでいます。Venmo（0.3%）やKlarna Checkout（0.2%）などの専門サービスは、特定の小売バーティカルで後払い（BNPL）オプションがコンバージョン率を引き上げ続ける中、小さいながらも重要なニッチを維持しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlrzXpWshCjsSpSxJnhK5A732UtlRUtWfbtSt39JlV1rbI1YRoA1fRLWUr05vJBKNsS-i7ReTMudhN/pubchart?oid=2038208870&format=interactive",
  sheets_gid="2028626432",
  sql_file="top_payment_providers.sql"
  )
}}

上位10の決済技術が両デバイスでの決済検出の大部分を占めており、決済が素早く統合されるという改めての証しです。ただし、単一または2つのプロバイダーが全体的に支配的として際立っているわけではないことは注目に値します。

### 2022年以降の変化は？

最も注目されるトレンドは、PayPalの決済検出のシェアが低下し、ウォレットとプロセッサーファーストのエコシステムが成長していることです：

- PayPalは2022年の決済検出の約39%から2025年の約30%に低下しています（デスクトップとモバイルの両方でこのパターンが見られます）。
- StripeとGoogle Payは同期間にシェアを獲得しています。
- Apple PayとShop Payは高いレベルで比較的安定しています。

これはPayPalが消滅しているという意味ではありません。ネイティブウォレット、リンクベースのチェックアウト、プラットフォームネイティブのアクセラレーターが標準になるにつれ、特に決済レイヤーがより多様化しているという意味です。

### 地域別決済事業者

{{ figure_markup(
  caption="PayPalが上位の決済プロバイダーである国の数。",
  content="83か国中70か国",
  classes="big-number",
  sheets_gid="732986771",
  sql_file="top_payment_by_geo.sql"
  )
}}

- モバイルでは、PayPalは83の地域のうち70の地域でトップの決済プロバイダーです。
- デスクトップでは、リーダーシップはより分散しています：Stripeが31の地域でリードし、PayPalは22でリードしています。

注目すべき例：

- Apple Payはニュージーランドでリードしています（デスクトップとモバイルの両方）。
- Braintreeは台湾で際立っています。
- いくつかのアフリカと中東の市場では、このデータセットでStripeが最も一般的なトッププロバイダーとして示されています（例：ナイジェリア、ケニア、UAE）。

## 結論

2025年のEコマースは集中していると同時に多様でもあります。少数のプラットフォームが検出されたEコマースサイトの大部分を占めており、WooCommerceとShopifyが先頭に立っている一方、地域とニッチなシステムのロングテールは特定の市場で引き続き重要です。ウェブサイトのランクは別のレイヤーを追加します：エンタープライズ向けのプラットフォームはより高いトラフィックティアで不釣り合いに登場し、ロングテールのサイトは採用しやすくコストの低いソリューションに傾く傾向があります。

パフォーマンスは注釈ではなく、差別化要因であり続けます。フィールド指標（Core Web Vitals）とラボ監査（Lighthouse）の両方が、より厳密なプラットフォームコントロールがより良い中央値の結果と相関する可能性があることを示していますが、そのギャップは運命ではありません。エンジニアリングの規律が強い場合、セルフホスト型と大幅にカスタマイズされたスタックも良いパフォーマンスを発揮できます。決済技術も素早く統合されます：少数のプロバイダーが検出を支配し、ウォレットとプロセッサーファーストのエコシステムはシェアを獲得し続けています。

Eコマースの次の章は、どのプラットフォームかだけでなく、どのチャネルかです：音声、ライブコマース、エージェンティックコマースがストアをより速く、よりアクセシブルで、より機械的に消費可能にすることを促しています。勝者は、カタログの品質、パフォーマンス、信頼を製品機能として扱う人たちです。なぜならますます、買い物客はページをクリックして回る人間ではないかもしれないからです。
