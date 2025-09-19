---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Eコマース
description: この章では、Eコマースエコシステムのトレンドを探り、プラットフォームの人気、パフォーマンス指標、地域差を検証します。Core Web Vitals、Lighthouseスコア、アクセシビリティを取り上げ、WooCommerceやShopifyのようなプラットフォームがどのように優位に立っているか、また新しいプレーヤーが特定の地域やニッチでどのように支持を得ているかを明らかにします。
hero_alt: Web Almanacのキャラクターがスーパーマーケットのレジで買い物かごから商品をコンベアベルトに移し、別のキャラクターがクレジットカードで支払っているヒーロー画像。
authors: [JonathanPagel]
reviewers: [nrllh]
analysts: [JonathanPagel]
editors: [niko-kaleev]
translators: [ksakae1216]
results: https://docs.google.com/spreadsheets/d/1LABlisQFCLjOyEd43tdUb-Hxs6pGuboTresntMk71Lc/
JonathanPagel_bio: Jonathan Pagelは学士号でEコマースを学び、以来、とくにショップやウェブサイトのスピード最適化とアクセシビリティの分野でこの分野に関心を持っています。現在、この分野でフリーランスとして活動し、AIと社会の修士号を取得しています。
featured_quote: Eコマースプラットフォームは多様で、さまざまなプロバイダーに広く分散していますが、決済システムのような技術は少数の主要プレーヤーが独占しています。
featured_stat_1: 21%
featured_stat_label_1: Eコマースサイトの割合
featured_stat_2: 37%
featured_stat_label_2: WooCommerceで構築されたEコマースサイトの割合。
featured_stat_3: 3.5%
featured_stat_label_3: 支払い方法としてPayPalを提供しているサイトの割合
doi: 10.5281/zenodo.14065664
---

## 導入

この章では、ウェブにおけるEコマースの現状を概観します。Eコマースウェブサイトとは、物理的またはデジタルな商品を販売する「オンラインストア」のことです。オンラインストアを構築する際には、いくつかの種類のプラットフォームから選択できます。

1. **Software-as-a-Service (SaaS)** プラットフォーム（Shopifyなど）は、オンラインストアの開店や運営に必要な技術的知識を最小限に抑えます。これは、コードベースへのアクセスを制限し、ホスティングの心配をなくすことによって実現します。
2. **Platform-as-a-Service (PaaS)** ソリューション（Adobe Commerce (Magento)など）は、最適化された技術スタックとホスティング環境を提供しつつ、コードベースへの完全なアクセスを許可します。
3. **セルフホストプラットフォーム**（WooCommerceなど）。
4. **ヘッドレスプラットフォーム**（CommerceToolsなど）は、「API-as-a-service」です。これらはEコマースのバックエンドをSaaSとして提供し、小売業者はフロントエンド体験の構築とホスティングを担当します。

一部のプラットフォームは、これらのカテゴリの複数に当てはまる場合があることに注意してください。たとえば、ShopwareはSaaS、PaaS、セルフホストのオプションを提供しています。

私たちの目標は、Eコマースエコシステムの現状とこの1年の動向を概観することです。前半では、プラットフォームの利用状況やCore Web Vitals、Lighthouseのパフォーマンス結果に基づいたランキングに焦点を当てます。後半はより実験的な内容です。さまざまなEコマース技術と、それらが時間とともにどのように進化してきたかを調査しました。

## プラットフォームの検出

私たちは、ウェブサイトで使われている技術を検出するために、<a hreflang="en" href="https://www.wappalyzer.com/">Wappalyzer</a>というオープンソースのツールを使用しました。Wappalyzerは、コンテンツ管理システム、Eコマースプラットフォーム、JavaScriptフレームワークやライブラリなどを特定できます。

## 制限事項

私たちの方法論には、その正確性に影響を与える可能性のあるいくつかの制限があります。

### Eコマースサイトの認識における制限事項

第一に、Eコマースサイトを認識する私たちの能力には、いくつかの制限があります。

- WappalyzerがEコマースプラットフォームを検出している必要があります。
- この分析ではホームページのみを分析しました。Eコマースプラットフォームがサブディレクトリ内でホストされている場合、この分析から除外される可能性があります。
- ヘッドレス実装では、使用中のプラットフォームを検出する能力が低下します。Eコマースプラットフォームを特定する主な方法の1つは、標準的なHTMLまたはJavaScriptコンポーネントを認識することです。したがって、Eコマースプラットフォームのフロントエンドを使用しないヘッドレスのウェブサイトでは、検出が困難になります。

### 指標と解説の正確性

指標と解説の正確性は、以下の制限によっても影響を受ける可能性があります。

- 観測されたトレンドは、業界のトレンドを反映するのではなく、検出精度の変化に影響されている可能性があります。たとえば、検出方法が改善されたというだけで、あるEコマースプラットフォームがより人気になったように見えるかもしれません。
- すべてのウェブサイトリクエストは米国から行われました。ウェブサイトが地理的な場所に基づいてリダイレクトする場合、最終的に分析されるバージョンは米国向けのものになります。
- 私たちは[Chrome UX Report](https://developer.chrome.com/docs/crux)データセットを使用しましたが、これには実際のChromeセッションのデータのみが含まれており、すべてのブラウザのユーザー体験を表すものではありません。

## 上位のEコマースプラットフォーム

合計で、2024年にはEコマースプラットフォーム上に構築された約250万のウェブサイトを検出し、これは分析された全ウェブサイトの約21%に相当します。もっとも広く使用されているEコマースプラットフォームはWooCommerceで、次にShopify、Squarespaceと続きます。

{{ figure_markup(
  image="ecommerce-platforms-distribution.png",
  caption="Eコマースプラットフォームの分布。",
  description="2024年に使用されるEコマースプラットフォームの分布を示す円グラフ。WooCommerceが35.8%でリードし、Shopifyが19.6%、Squarespace Commerceが9.2%と続いています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=2506095&format=interactive",
  sheets_gid="1000255969",
  sql_file="top_ecommerce.sql"
  )
}}

WooCommerce（36%）とShopify（20%）がEコマースプラットフォームの市場を独占しています。OpenCartは、検出された362のショップシステムの中で、市場シェア1%以上を確保している最後のシステムです。

{{ figure_markup(
  image="top-5-platforms-2021-2024.png",
  caption="2021年から2024年までの上位5つのEコマースプラットフォーム。",
  description="2021年から2024年までの上位5つのEコマースプラットフォームを示す折れ線グラフ。WooCommerceがもっとも人気のあるプラットフォームであり続け、Shopify、Squarespace Commerce、PrestaShop、Wix ecommerceがそれに続きます。グラフは、プラットフォームの人気が年々わずかに変動していることを示しており、WooCommerceは一貫して35%以上、Shopifyは約18-19%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=91913395&format=interactive",
  sheets_gid="1000255969",
  sql_file="top_ecommerce.sql"
  )
}}

長年にわたり、上位5つのプラットフォームは比較的一貫しています。しかし、Wix ecommerceは2023年にPrestaShopを上回り、5位から4位に浮上しました。トレンドとしては、オープンソースプロジェクトのWooCommerceがわずかに市場シェアを失い、2022年の37%から2024年には36%に減少している一方、その商業的な競合であるShopifyは同期間に市場シェアを伸ばしています（18%から20%に増加）。

## ランク別上位Eコマースプラットフォーム

Chrome User Experience Reportのデータを用いて、ランク別にEコマースプラットフォームを調査しました。

{{ figure_markup(
  image="platform-adoption-by-rank.png",
  caption="デスクトップとモバイルのランク別プラットフォーム採用状況。",
  description="2024年のデスクトップおよびモバイルデバイスにおけるウェブサイトランク別のプラットフォーム採用率を示す棒グラフ。採用率はランクとともに増加し、デスクトップとモバイルの両方で1,000ランクで1.74%、10,000ランクで3.74%、100,000ランクで7.82%、1,000,000ランクで16.99%、10,000,000ランクで21.30%となっており、上位ランクのサイトほど普及が進んでいることがわかります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=2037087785&format=interactive",
  sheets_gid="1407431623",
  sql_file="top_vendors_crux_rank.sql"
  )
}}

私たちのデータによると、上位1,000のウェブサイトではごく少数のEコマースプラットフォームしか利用されていませんが、上位1,000万のウェブサイトの約20%がEコマースプラットフォームを利用しています。この差は、上位1,000のサイトがカスタムソリューションを利用することが多いためと考えられます。

<figure>
  <table>
    <thead>
      <tr>
        <th>順位</th>
        <th>10,000</th>
        <th>100,000</th>
        <th>1,000,000</th>
        <th>10,000,000</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Fourthwall</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Amazon Webstore</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td>4</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
      </tr>
      <tr>
        <td>5</td>
        <td>SAP Commerce Cloud</td>
        <td>Amazon Webstore</td>
        <td>1C-Bitrix</td>
        <td>Magento</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="ランク別上位Eコマースプラットフォーム。",
      sheets_gid="1407431623",
      sql_file="top_vendors_crux_rank.sql",
    ) }}
  </figcaption>
</figure>

ウェブ全体と比較すると、上位1,000万のウェブサイトではプラットフォームの人気に顕著な違いがあります。たとえば、Wix ecommerceは上位5つのプラットフォームから姿を消し、代わりにMagentoが上位5つに加わります。上位100万のサイトでは、ShopifyがWooCommerceを抜いてもっとも人気のあるプラットフォームとなり、SquarespaceとWix ecommerceは上位5つから外れ、上位20位以下に落ちます。

上位10万のウェブサイトでは、Salesforce Commerce CloudとAmazon Webstoreがもっとも利用されているプラットフォームの中に現れ、Shopifyは依然として1位の座を維持しています。最後に、上位1万のウェブサイトでは、これまで上位を占めていたプラットフォームはどれもトップ5には入っておらず、代わりにFourthwall、SAP、Salesforce Commerce Cloudといった商用ソリューションが独占しています。

## 地域別上位Eコマースプラットフォーム

地域間では、好みにかなりの違いがあります。私たちはCrUXデータセットの追加データを使用しました。このデータは、地理的エリアごとにもっとも訪問されたウェブサイトを分類しています。たとえば、`google.com`はアメリカのウェブサイトですが、ドイツのすべてのインターネットユーザーにとってもっとも訪問されたウェブサイトの1つでもあります。

{{ figure_markup(
  image="top-ecommerce-platform-by-country.png",
  caption="国別のトップEコマースプラットフォーム。",
  description="人気に基づいた国別のトップEコマースプラットフォームを示す地図。この地図では、WooCommerce（紫）、Shopify（緑）、1C-Bitrix（赤）の3つのプラットフォームが強調されています。CrUXデータセットから得られたデータは、地域的な好みを示しており、WooCommerceは南北アメリカとヨーロッパの一部でリードし、Shopifyはいくつかの地域で人気があり、1C-Bitrixはロシアと近隣諸国で優位に立っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=826337660&format=interactive",
  sheets_gid="1132201023",
  sql_file="top_shopsystem_by_geo.sql"
  )
}}

各国のトップの座を占めるのは、WooCommerce（紫）、Shopify（緑）、1C-Bitrix（赤）の3つの主要プラットフォームであることがわかります。この地図はGoogleスプレッドシートの制限により、これら3つのみを可視化しています。

## EコマースにおけるCore Web Vitals

GoogleのCore Web Vitalsは、ユーザー体験の重要な側面を評価するために設計された3つの主要なパフォーマンス指標で、読み込み速度、インタラクティビティ、視覚的な安定性に焦点を当てています。
2020年に導入され、2021年にランキングシグナルとして採用されたこれらの指標は、他の多くの指標とともに、ページがGoogleの検索結果でどのくらい高くランク付けされるかを決定します。

ここでは、各プラットフォームで「良好」なスコアを達成したサイトの割合を示します。つまり、3つのCore Web Vitalsすべて（LCP（Largest Contentful Paint）が2.5秒未満、INP（Interaction to Next Paint）が200ミリ秒未満、CLS（Cumulative Layout Shift）が0.1未満）のパフォーマンスしきい値を満たしているということです。

- **2.5秒未満のLCP**：これは、ページ上で最大の可視要素が読み込まれるまでにかかる時間を測定します。このしきい値を達成することで、ユーザーは過度な遅延なくメインコンテンツをすばやく表示できます。
- **200ミリ秒未満のINP**：これは、ユーザーのインタラクション（クリックやタップなど）からブラウザが画面を更新（ペイント）するまでの時間を測定します。200ミリ秒未満のスコアは、ページが非常に応答性が高く、スムーズなユーザー体験を提供することを意味します。
- **0.1未満のCLS**：これは、ページが読み込まれる際に要素が予期せずどれだけ移動するかを測定することで、ページの視覚的な安定性を追跡します。0.1未満のスコアは、移動が最小限であることを示し、より安定した視覚体験を保証します。

{{ figure_markup(
  image="mobile-core-web-vitals-performance.png",
  caption="プラットフォームごとのモバイルにおけるCore Web Vitalsの年次パフォーマンス。",
  description="2022年から2024年にかけて、さまざまなEコマースプラットフォームにおけるモバイルのCore Web Vitalsの年次パフォーマンスを示す棒グラフ。このグラフは、WooCommerce、Shopify、Squarespace Commerceなどのプラットフォーム全体での改善傾向を強調しており、良好なCore Web Vitals基準を満たすモバイルウェブサイトの割合が年々増加していることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=218915083&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=644
  )
}}

Squarespaceのように、2022年の良好スコア33%から2024年には60%に増加するなど、目覚ましい改善を遂げたプラットフォームもあります。MagentoやWooCommerceのような他のプラットフォームは、依然として実世界のユーザー体験に苦戦しています。このグラフやこのセクションの他のグラフは、ウェブトラフィックのほとんどがモバイルからであり、トップスコアに到達するのがより困難であるため、モバイルのパフォーマンスのみを考慮しています。

### Largest Contentful Paint (LCP)

Largest Contentful Paint (LCP)は、ウェブページのメインコンテンツが読み込まれ、ユーザーに表示されるまでにかかる時間を測定します。具体的には、画面上の最大の要素（大きな画像やテキストブロックなど）の読み込み時間を追跡するため、ユーザーがページ上で意味のあるものをどれだけ早く見られるかを示す良い指標となります。

良好なLCP時間は2.5秒未満であるべきです。時間がかかりすぎると、ウェブサイトが遅く感じられ、ユーザーが離脱する可能性があります。LCPを改善するには、画像を最適化し、サーバーの応答を速くし、ブロッキングスクリプトを最小限に抑えることで、主要なコンテンツがより迅速に表示されるようにします。

{{ figure_markup(
  image="mobile-lcp-performance.png",
  caption="モバイルにおけるプラットフォームごとのLCPパフォーマンスの年次推移。",
  description="2022年から2024年にかけて、さまざまなEコマースプラットフォームにおけるモバイルデバイスでのLargest Contentful Paint（LCP）の年次パフォーマンスを示す棒グラフ。このグラフは、WooCommerce、Shopify、Squarespace Commerceなどのプラットフォームで良好なLCPスコアを達成するモバイルウェブサイトの割合が改善傾向にあることを示しており、年々読み込みパフォーマンスが向上していることを示唆しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=523370223&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=644
  )
}}

これらの課題にもかかわらず、上位10のEコマースプラットフォームは、LCPスコアで年々大幅な改善を示しています。Shopify、OpenCart、Shopwareのようなプラットフォームは2022年以来、一貫して良好なLCP合格率を維持していますが、アルゼンチンで人気のプラットフォームであるTiendanubeは、合格率を2022年の28%から2024年には61%に増加させるなど、目覚ましい進歩を遂げました。一方、WooCommerceは合格率がわずか34%と遅れをとっています。

### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS)は、ページが読み込まれる際にコンテンツが予期せずどれだけずれるかを追跡することで、ページのレイアウトの安定性を測定します。良好なCLSスコアとは、ウェブサイトの訪問の75%以上が0.1以下のスコアを記録することを意味し、これは安定したユーザーフレンドリーな体験を示します。

{{ figure_markup(
  image="mobile-cls-performance.png",
  caption="モバイルにおけるプラットフォームごとのCLSパフォーマンスの年次推移。",
  description="2022年から2024年にかけて、さまざまなEコマースプラットフォームにおけるモバイルでのCumulative Layout Shift（CLS）の年次パフォーマンスを示す棒グラフ。このグラフは、WooCommerce、Shopify、Squarespace Commerce、Wix ecommerceなどのプラットフォームで良好なCLSスコアを達成するモバイルウェブサイトの割合の改善傾向を浮き彫りにし、時間とともに安定性が向上し、レイアウトのずれが減少したことを反映しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=1657299227&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=644
  )
}}

LCPと比較して、CLSの改善はそれほど劇的ではありません。多くのプラットフォームはわずかな進歩しか遂げておらず、Magentoは他よりも苦戦しています。WooCommerceは他の指標では課題に直面していますが、CLSでは他の多くのプラットフォームと同様に非常に優れたパフォーマンスを発揮しています。

### Interaction to Next Paint (INP)

INPは、ユーザーがページと対話した瞬間（たとえば、ボタンをクリックするなど）から、ブラウザがその対話に視覚的に応答するまでにかかる時間を捉えます。良好な[INPスコアは200ミリ秒以下](https://web.dev/articles/inp)であり、これによりスムーズで応答性の高い体験が保証されます。

{{ figure_markup(
  image="mobile-inp-performance.png",
  caption="モバイルにおけるプラットフォームごとのINPパフォーマンスの年次推移。",
  description="2022年から2024年にかけて、さまざまなEコマースプラットフォームにおけるモバイルでのInteraction to Next Paint（INP）の年次パフォーマンスを示す棒グラフ。このグラフは、WooCommerce、Shopify、Squarespace Commerceなどのプラットフォームで良好なINPスコアを達成するモバイルウェブサイトの割合の改善傾向を示しており、時間とともに対話性と応答時間が向上したことを反映しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=596833810&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=644
  )
}}

ほとんどのプラットフォームがINPスコアを改善していますが、MagentoやBigCommerceなど一部は依然として遅れており、合格率はそれぞれ49%と67%です。しかし、ほとんどのプラットフォームは75%以上の合格率を達成しており、業界全体で大幅な進歩が見られます。

## Lighthouse

[Lighthouse](https://developers.google.com/web/tools/lighthouse/)は、ウェブページの品質を監査するためのオープンソースの自動化ツールです。パフォーマンス、アクセシビリティ、ベストプラクティス、検索エンジン最適化（SEO）などの側面に関する指標とレポートを提供します。

開発者にウェブサイトを強化するための実用的な提案を提供するラボデータを含むレポートを生成します。ただし、Lighthouseのスコアは[CrUX](https://developers.google.com/web/tools/chrome-user-experience-report)によって収集された実世界のフィールドデータに直接影響を与えるものではないことに注意することが重要です。HTTP Archiveは、モバイルおよびデスクトップのウェブページでLighthouseを実行し、[スロットルされたCPUパフォーマンスの低速4G接続](./methodology#lighthouse)をシミュレートします。Lighthouse Performanceは、デスクトップおよびモバイルユーザー向けの特定のテストプロファイルに合わせたウェブサイトパフォーマンスのラボベースの評価です。両方の指標の違いをよりよく理解するには、[この記事](https://web.dev/articles/lab-and-field-data-differences)を参照してください。

Core Web Vitalsは実世界のデータを提供しますが、限られた指標セットしか提供しません。一方、Lighthouseは、さまざまな指標のラボデータを提供します。Chrome DevToolsを使用してこのページのLighthouseテストを実行することもできます。次のセクションでは、人々が一般的に使用し、私たちのグラフで認識されるシステムを強調するために、50,000回以上検出されたEコマースシステムに焦点を当てます。ただし、完全なデータはスプレッドシートで入手でき、例外的なケースについては、より小規模なショップシステムについても言及します。

### パフォーマンス

Lighthouseの[パフォーマンススコア](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring)は、ウェブページの全体的なパフォーマンスを要約する指標であり、とくに訪問者にとってどれだけ速くスムーズに読み込まれ、使用可能になるかに焦点を当てています。このスコアは0から100の範囲で、高いスコアほど優れたパフォーマンスを示します。

Lighthouseのパフォーマンススコアは、First Contentful Paint（10%）、Speed Index（10%）、Largest Contentful Paint（25%）、Total Blocking Time（30%）、Cumulative Layout Shift（25%）の5つの指標スコアの加重平均です。

{{ figure_markup(
  image="median-lighthouse-performance-score.png",
  caption="デスクトップおよびモバイルにおけるさまざまなEコマースプラットフォームの中央値Lighthouseパフォーマンススコア。",
  description="2024年のデスクトップおよびモバイルデバイス向けに、さまざまなEコマースプラットフォームにおける中央値Lighthouseパフォーマンススコアを比較した棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=31552374&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql",
  width=600,
  height=559
  )
}}

Wix ecommerceが他のシステムと比較して、デスクトップとモバイルの両方で非常に優れたパフォーマンスを発揮していることがわかります。これは、ランキングデータが、上位1,000万以外のウェブサイトで主に使用されており、専門的でない店舗である可能性が高いことを示しているため、驚くべきことです。このパフォーマンスは、WooCommerceのようなオープンソースシステムと比較して、カスタマイズオプションが限られていることにも起因する可能性があります。

しきい値を50,000回ではなく5,000回以上出現するプラットフォームに下げると、Gumroadが非常に良いスコアを記録しており、デスクトップで中央値87、モバイルで59となっています。さらに、アルゼンチンでもっとも人気のあるショップシステムであるTiendanubeも、デスクトップで74、モバイルで58と良いスコアを記録しています。

### アクセシビリティ

アクセシビリティは、道徳的な理由だけでなく、法的な理由からもますます重要なトピックとなっています。Lighthouseは<a hreflang="en" href="https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md">Axeフレームワーク</a>を使用してアクセシビリティスコアを決定します。アクセシビリティスコアは、障害を持つ人々を含むすべての人があなたのウェブサイトをどれだけ簡単に使用できるかを示します。スコアは0から100の範囲で、数値が高いほど、より多くの人々にとってウェブサイトが使いやすいことを意味します。

スコアは一連のテストに基づいています。たとえば、スクリーンリーダーを使用している人々のために画像に説明があるか、ボタンが明確にラベル付けされているかなどをチェックします。また、ウェブサイトが理解しやすく、ナビゲートしやすいように、見出しの適切な使用や良好なカラーコントラストなどの問題も探します。アクセシビリティに関する章全体もあり、そちらでより詳しく説明しています。

優れたアクセシビリティスコアが、必ずしもウェブサイトが完全にアクセス可能であることを意味するわけではないことに注意することが重要です。なぜなら、多くの問題は自動ツールでは検出できないからです。たとえば、画像の不正確な説明は問題ですが、Lighthouseはそれを検出しません。

{{ figure_markup(
  image="median-lighthouse-accessibility-score.png",
  caption="デスクトップおよびモバイルにおけるさまざまなEコマースプラットフォームの中央値Lighthouseアクセシビリティスコア。",
  description="2024年にデスクトップとモバイルのEコマースプラットフォームにおけるLighthouseアクセシビリティスコアの中央値を示す棒グラフ。Squarespace Commerce、Wix ecommerce、WooCommerceは高いスコアを記録しており、強力なアクセシビリティへの取り組みを示しています。Shopifyも良いスコアですが、PrestaShop、Magento、1C-Bitrixはわずかに低いスコアですが、それでも合理的なパフォーマンスです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=1033635068&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql",
  width=600,
  height=559
  )
}}

商用プラットフォームのWix、Squarespace、Shopifyは優れたパフォーマンスを発揮していますが、どのシステムも著しく悪い結果にはなっていません。

### SEO

LighthouseのSEOスコアは、ウェブサイトがGoogleのような検索エンジンに見つけられるようにどれだけうまく設定されているかを示します。スコアは0から100の範囲で、高いスコアはサイトが検索エンジン向けに最適化されていることを意味し、より多くの人々がそれを見つけるのに役立ちます。テストでは、メタディスクリプション、タイトル、正しい見出し構造がチェックされます。

{{ figure_markup(
  image="median-lighthouse-seo-score.png",
  caption="デスクトップおよびモバイルにおけるさまざまなEコマースプラットフォームの中央値Lighthouse SEOスコア。",
  description="2024年にデスクトップおよびモバイルデバイスの両方におけるEコマースプラットフォームの中央値Lighthouse SEOスコアを表示する棒グラフ。Squarespace Commerce、WooCommerce、Shopifyを含むほとんどのプラットフォームは、一貫して高いSEOスコアを達成しており、業界全体で強力なSEOプラクティスが反映されています。Wix ecommerceはモバイルとデスクトップで完璧な100点を獲得しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=2064035544&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql",
  width=600,
  height=559
  )
}}

SEOの重要性はLighthouseの結果に反映されており、ほとんどのプラットフォームが非常に良いスコアを記録しています。その中でもWixは中央値スコア100点を記録し、トップに立っています。

### ベストプラクティス

ベストプラクティススコアは、あなたのウェブサイトが、サイトを安全で信頼性の高いものにすることに焦点を当てた、優れたウェブ開発の一般的なルールにどれだけ従っているかを示します。サイトが安全なHTTPS接続を使用しているか、JavaScriptの機能が安全に使用されているか、画像やリソースが適切に読み込まれるかなどをチェックします。目標は、ウェブサイトがユーザーにとって安全でなく、遅く、または信頼性の低いものになる可能性のある一般的な問題を回避することです。

{{ figure_markup(
  image="median-lighthouse-best-practices-score.png",
  caption="デスクトップおよびモバイルにおけるさまざまなEコマースプラットフォームの中央値Lighthouseベストプラクティススコア。",
  description="2024年にデスクトップとモバイルのEコマースプラットフォームにおけるLighthouseベストプラクティススコアの中央値を示す棒グラフ。Squarespace Commerceは高得点でリードしており、デスクトップで100点、モバイルで96点を達成しています。WooCommerce、Wix ecommerce、Shopify、PrestaShopは78～79点あたりで一貫したスコアを維持していますが、1C-Bitrixはもっとも低いスコアであり、ベストプラクティスの遵守に改善の余地があることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=1049035792&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql",
  width=600,
  height=559
  )
}}

私たちのデータセットで50,000ページ以上を持つプラットフォームの中で、Squarespaceは2位のWooCommerceに22ポイントの差をつけて、はるかにリードしています。

## 決済事業者

決済事業者の検出は、さまざまなEコマースプラットフォームの検出ほど高度でも正確でもありません。これは、ウェブサイト全体ではなくホームページのみを分析したため、使用されている決済事業者の明確な兆候が得られない可能性があるためです。さまざまな決済事業者がどのように検出されるかを理解するには、<a hreflang="en" href="https://github.com/HTTPArchive/wappalyzer">WappalyzerのGitHubプロファイルのチェックポイント</a>を参照できます。同じウェブサイトで複数の決済事業者を使用できます。そのような場合、ウェブサイトは検出された各決済事業者についてカウントされます。

次のセクションでは、Eコマースシステムが特定されなかった場合でも、決済事業者が検出された各ウェブサイトに焦点を当てます。

{{ figure_markup(
  image="mobile-payment-provider-distribution.png",
  caption="モバイル決済事業者分布の年次推移。",
  description="2022年から2024年にかけてモバイルEコマースサイトで使用された決済事業者の分布を示す棒グラフ。PayPalがもっとも人気のある決済事業者であり続け、Apple Pay、Shop Pay、Visaがそれに続きます。このグラフは、ほとんどの事業者で年々採用が徐々に増加していることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=611186794&format=interactive",
  sheets_gid="1631427419",
  sql_file="top_payment_yoy.sql",
  width=600,
  height=644
  )
}}

データによると、PayPalはモバイルウェブサイトでもっとも一般的に検出される支払い方法であり、データセット内の全ページの3.5%に表示されています。これは、分析された1,600万以上のモバイルページのうち、約56万ページでPayPalが検出されたことを意味します。

Apple Payは2位にランクされ、Google Payよりも頻繁に検出されており、モバイルEコマースでの存在感が高まっていることを示しています。一方、Shopifyが提供する決済ソリューションであるShop Payは、ランキングで3位を確保しています。

## 結論

Eコマースはまだ進化を続けており、プラットフォームの好みは地域やウェブサイトの規模によって異なります。多くの人にとってWooCommerceが頼りになるプラットフォームであり続けていますが、Shopifyはとくに高トラフィックのウェブサイトの間で着実にシェアを広げています。興味深いことに、Wix ecommerceのようなプラットフォームは、小規模なサイトでより人気があるにもかかわらず、ユーザー体験の指標では優れたパフォーマンスを発揮しています。全体として、パフォーマンスからアクセシビリティまで、ほとんどの指標で過去数年間にわたる改善が見られ、すべての人に利益をもたらしています。

Eコマースプラットフォームは多様で、さまざまなプロバイダーに広く分散していますが、決済システムのような技術は少数の主要プレーヤーが独占しています。今後数年間でこの状況がどのように進化し続けるかを見るのは興味深いでしょう。
