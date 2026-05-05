---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: 2025 Web Almanac 網路年鑑的 CMS 章節，涵蓋 CMS 採用率、採用 CMS 平台的網站使用者體驗，以及 CMS 資源大小。
hero_alt: Hero image of Web Almanac characters on a type writer writing a web page.
authors: [VaheSODP]
reviewers: [dknauss]
analysts: [onurglr, alonko]
editors: [samuelfatola, sreemoyeebhattacharya]
translators: [bobo52310]
VaheSODP_bio: Vahe Arabian is a digital publishing entrepreneur, growth strategist, and the founder of <a hreflang="en" href="https://www.stateofdigitalpublishing.com/">State of Digital Publishing</a> and <a hreflang="en" href="https://www.sodpmedia.com/">SODP Media</a>. He works with publishers, startups, and media organizations to drive sustainable growth across SEO, audience development, monetization, and product strategy. Vahe is a frequent speaker and writer on digital media trends, AI in publishing, and the evolving future of online journalism.
results: https://docs.google.com/spreadsheets/d/1b3VLQPtJJOB7MmEx_RgmWSCef1BK8mrqpQT44UiMQyE/edit
featured_quote: 今年，業界對效能與使用者體驗的關注持續加深，CMS 平台在 Core Web Vitals 和 Lighthouse 分數上展現了穩定的進步。許多 CMS 採用了能提升載入速度、互動性和無障礙性的最佳化策略，反映出對以使用者為優先的網頁體驗的共同承諾。
featured_stat_1: 35%
featured_stat_label_1: 使用 WordPress 的行動版網站
featured_stat_2: 54%
featured_stat_label_2: 使用 CMS 的行動版網站
featured_stat_3: 64%
featured_stat_label_3: WordPress 佔 CMS 市場份額
doi: 10.5281/zenodo.18246656
---

## 簡介

內容管理系統（CMS）如今驅動了幾乎所有的網站。到了 2025 年，CMS 的功能遠不止讓人們建立和發布頁面。它們影響著網站的建置方式、使用便利性，以及內容在搜尋引擎和 AI 驅動工具中的呈現效果。隨著網站規模擴大、內容更活躍、個人化程度更高，CMS 可以決定一個網站是快速、直覺且可靠，還是緩慢又令人沮喪。本章透過 HTTP Archive 的資料來檢視 CMS 的生態全貌。

我們將探討有多少網站使用 CMS、頂級網站與整體網路的差異、CMS 驅動網站的效能表現，以及隨著這些平台大規模運作而出現的新能力。本章不只是比較 CMS 的功能清單，而是聚焦於 CMS 的預設值、託管模式和建置方式，如何塑造前百萬名到前一萬名網站在使用者與搜尋引擎眼中的實際網頁體驗。

資料顯示，如今大多數網站都採用 CMS，而未使用 CMS 的網站則年年減少。為了理解這對速度、可用性與內容可見度帶來哪些取捨，本章會先探討整體 CMS 採用情況，再檢視這對效能和使用者體驗的意義，最後觀察伴隨 CMS 普及而出現的新工具和模式。

## 什麼是 CMS？

內容管理系統是一種軟體，讓人們無需為每次變更都修改程式碼，就能在網路上建立和更新內容。大多數 CMS 會把內容和呈現方式分開，因此編輯者可以在不撰寫 HTML、CSS 或 JavaScript 的情況下修改文字、圖片和結構。開發者則可以透過建立佈景主題、外掛或模組來擴充 CMS。

廣義來說，CMS 主要分為兩種類型。傳統的單體式 CMS 把內容儲存、呈現與提供整合在同一套系統中。

無頭式或可組合式 CMS 則將內容管理與負責呈現內容的網站或應用程式分開。在實務上，大多數 CMS 都會處理一組共同任務：內容建模、內容編輯、媒體管理、功能擴充，以及與其他系統整合。當我們觀察整個網路的採用和實作模式時，它們在這些任務上的做法差異就會變得更加明顯。

## CMS 採用情況

到了 2025 年，CMS 的採用反映出一個既成熟又日益專業化的網路。現在幾乎每個網站都使用某種 CMS，但這些平台的使用方式會因地區、流量層級和底層技術而有很大差異。市場並未朝向單一主流系統收斂，而是明顯走向碎片化，不同平台在全球不同地區、不同使用情境和不同規模下各有優勢。

### 整體採用率

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMS 採用率。",
  description="2021 年至 2025 年桌面版和行動版平台使用內容管理系統的網頁百分比。資料顯示兩個類別呈穩定上升趨勢，桌面版採用率從 42% 上升至 55%，行動版採用率從 43% 增加至 54%。雖然行動版在早期年份的採用率略高於或等同於桌面版，但桌面版使用率在 2025 年大幅躍升，以 1% 的差距領先行動版。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1626517714&format=interactive",
  sheets_gid="1841486394",
  sql_file="cms_adoption.sql"
  )
}}

HTTP Archive 的整體採用率數據顯示，CMS 驅動的網站在 2025 年占觀測網站的 54% 以上，鞏固了 CMS 作為網路預設基礎設施的地位。

### 依地區分析採用率

CMS 的採用率在不同地區呈現出不同的樣貌。

{{ figure_markup(
  image="cms-adoption-by-geo.png",
  caption="依地區分析的 CMS 採用率。",
  description="長條圖比較了十個不同國家在桌面版和行動版平台上使用 CMS 的網站百分比。義大利以行動版網站 51% 的最高採用率領先，緊隨其後的是美國和英國，均為 49%。相比之下，印尼和巴西的採用率最低，分別為 25% 和 32%，而行動版採用率在幾乎所有列出的國家中始終高於桌面版。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1849936162&format=interactive",
  sheets_gid="897134076",
  sql_file="cms_adoption_by_geo.sql",
  width=600,
  height=528
  )
}}

HTTP Archive 資料顯示，託管型 CMS 平台在北美和西歐的集中度較高。相比之下，開源系統在亞洲和東歐部分地區佔有相對較強的地位。

### 依排名分析採用率

網站排名持續影響 CMS 的採用模式。高流量網站傾向選擇支援複雜工作流程、深度客製化和長期可擴充性的平台。低流量網站則更可能使用能降低維運負擔的託管型或整合式解決方案。

{{ figure_markup(
  image="top-5-cms-by-rank.png",
  caption="依排名分析的前 5 大 CMS。",
  description="長條圖顯示行動版不同網站流量排名中的主要內容管理系統。WordPress 是明顯的領導者，隨著網站數量增加，其採用率急劇攀升，在所有網站中達到 35.0% 的峰值。相比之下，Shopify 和 Wix 等競爭對手的市佔率小得多，Shopify 在前一千萬名網站中達到最高使用率 5.0%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=481895919&format=interactive",
  sheets_gid="156249791",
  sql_file="top_cms_by_rank.sql"
  )
}}

在前一萬名網站中，WordPress 佔 CMS 使用量約 58%，Drupal 則約佔 6% 到 7%，遠高於它在整體市場約 1% 的佔比。Wix 和 Shopify 等平台在這個流量層級幾乎看不到。

### 最受歡迎的 CMS

{{ figure_markup(
  image="cms-adoption-share.png",
  caption="CMS 採用市佔率。",
  description="圓餅圖突顯了 WordPress 的巨大市場主導地位，占所有行動版 CMS 使用量的 64.3%。Shopify 以 7.3% 的市佔率位居第二，Wix 以 5.2% 緊隨其後，而 Squarespace 和 Joomla 等競爭者的市佔率維持在 3% 以下。圖表的其餘部分分散在數十個利基供應商之間，Webflow 和 Drupal 等系統各自僅占總採用量的不到 2%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1716078713&format=interactive",
  sheets_gid="54237467",
  sql_file="top_cms.sql"
  )
}}

WordPress 在 2025 年依然是主導的 CMS，驅動了約 64% 的 CMS 網站。然而，其成長已放緩至每年不到一個百分點，這更像是市場飽和的跡象，而非來自任何單一競爭者的重大威脅。

資料顯示，這種放緩並非由某個平台取代 WordPress 所致。相反，微小的增長分散在多個 CMS 之間。Shopify 成長至約 7.3-7.8% 的 CMS 市佔率，Wix 約 5%，Squarespace 約 3%。沒有任何單一平台的成長大到足以抵消 WordPress 放緩的擴張，這意味著生態系統更加碎片化，而非趨於整合。

整體而言，資料顯示出一個更加多元的 CMS 生態，由市場成熟度和更多選擇所塑造。WordPress 仍被廣泛採用，但新的成長越來越分散在多個平台之間，而非集中在單一預設 CMS 上。

### 成長最快的 CMS

{{ figure_markup(
  image="top-5-cms.png",
  caption="前 5 大 CMS。",
  description="長條圖追蹤 2022 年至 2025 年最受歡迎平台的行動版年度採用趨勢。WordPress 在整個期間維持對競爭者的巨大且穩定的領先優勢，以 35.6% 的採用率結束這段期間。雖然 Wix 和 Squarespace 經歷了穩定成長，分別達到 2.8% 和 1.5%，但較舊的開源平台如 Joomla 和 Drupal 的市場份額則逐漸下降。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1261903171&format=interactive",
  sheets_gid="54237467",
  sql_file="top_cms.sql"
  )
}}

2025 年各 CMS 平台的年成長幅度溫和且不平均。Shopify 是今年新納入的項目，先前僅被歸類在電子商務類別，如今也被歸入 CMS 類別。Squarespace 呈現小幅但正向的成長，約增加 0.2 到 0.3 個百分點，來到約 3.0% 到 3.3%。Wix 的成長則比前幾年明顯趨緩，在經歷一段快速擴張後，目前約停留在 5.2% 的市佔率。這些增長都屬於漸進且分散的變化，並不是新一波爆發性成長的訊號。

相比之下，WordPress 的市佔率年減幅度雖然不到 1 個百分點，卻是它在經過數十年擴張後首次出現持續放緩的訊號。即便如此，WordPress 仍支撐著大多數 CMS 網站，依然是整個網路無可爭議的領導者。Joomla 和 Drupal 等傳統開源平台的整體市佔率則持續長期下滑，儘管 Drupal 在高流量網站中的佔比仍明顯偏高。簡單來說，2025 年成長最快的 CMS 主要是在特定利基市場有所進展，而 WordPress 在絕對數據上仍然居於主導地位，持續支撐更廣泛的生態系統。

## 2025 年的 WordPress

鑑於 WordPress 在 CMS 領域的主導地位，值得進一步討論。

### 市場與生態系統

WordPress 在 CMS 生態系統中的重要性，如今更多體現在影響力，而不是成長幅度本身。它的龐大規模，使它成為理解架構選擇、效能模式和實際實作取捨的重要參考。由於 WordPress 幾乎橫跨所有流量層級和使用情境，其在線上環境中的表現，對整體網路效能和 CMS 驅動網站的成果都有很大影響。

這種影響力建立在高度可擴充的生態系統之上。WordPress 不強制採用單一的開發或託管模式，而是透過外掛、佈景主題和整合層支援多種作法。這種彈性讓網站可以逐步演進，不論是新增功能、擴大獲利模式，或提高編輯流程的複雜度，都不一定得更換平台。因此，WordPress 往往能一路陪伴網站經過多個世代，即使其他平台在較狹窄的領域持續成長也是如此。

然而，這種開放性也帶來了顯著差異。和整合度更高的 CMS 相比，WordPress 網站在架構、效能表現和維運複雜度上都有更大的落差。它的主導地位並不代表結果會趨於一致；相反地，實作方式的不同，反而讓成果呈現出更廣泛的分布。接下來的章節會進一步檢視這種彈性在實務中的樣貌，包括架構、效能指標，以及擴大規模時會遇到的限制。

### 技術效能與改進

近期的 WordPress 開發重點，在於降低隨著網站規模擴大、編輯流程變複雜，以及區塊使用量增加而出現的效能瓶頸。核心工程工作不是重新定義互動模式，而是著重讓現有系統更快、更容易快取，並降低對設定差異的敏感度。

其中一個主要進展在編輯器效能。針對範本載入、區塊渲染和樣式模式重複使用的最佳化，讓區塊密集的情境下範本載入速度最高可提升 35%。針對可重複使用區塊模式和全域樣式的持久快取，也減少了重複運算，緩解大型網站在複雜版面下長期存在的可擴充性問題。

媒體處理也有所改善。圖片處理流程的更新使 <a hreflang="en" href="http://core.trac.wordpress.org/ticket/61758?st_source=ai_mode#:~:text=AVIF%20generation%20has%20improved%20from,:%2095.81%20MB%20(100463863%20bytes)">AVIF 圖片生成速度提升了約 20%</a>，自動尺寸調整更佳，延遲載入也更為可靠。這些改變減少了伺服器端的處理時間和前端的版面位移，在無需個別網站層級調整的情況下改善了載入效能。

在前端方面，效能優化則著重在削減不必要的資源載入和重複處理。核心現在會更有選擇地載入區塊樣式與腳本，避免替隱藏區塊載入資源，並更積極地快取產生出的樣式。推測式載入技術，例如預取和預渲染可能的導覽路徑，也進一步改善了支援瀏覽器中的體感速度和最大內容繪製。整體來看，這些最佳化瞄準的是常見的真實瓶頸，讓各種設定下的表現更一致。HTTP Archive 的資料也佐證了這個現象，顯示 WordPress 的效能差異更多來自設定，而不是核心本身的限制。

無障礙性的改進與效能工作同步進行。對語意標記、鍵盤導航、標籤和編輯器可用性的增強，旨在讓無障礙性成為 WordPress 輸出的基本屬性，而非完全取決於佈景主題或外掛的選擇。

### WordPress 在 2025 年的進展

這些變化顯示，WordPress 正從追求擴張轉向追求穩定。對編輯器反應速度、快取重複利用、資源縮減和差異控制的重視，與 HTTP Archive 的發現一致，也就是 WordPress 網站的效能分布範圍很大，而不是集中在最好或最差的兩端。核心的改變越來越著眼於拉高表現最差的實作，縮小調校良好與調校不佳網站之間的差距。

對區塊架構和全站編輯（FSE）的持續投入，看起來更像是長期承諾，而不是短期實驗。WordPress 並沒有從區塊模式退回去，而是透過持續最佳化來吸收它的維運成本。區塊如今已被視為核心基礎設施，效能工作則聚焦在讓它在大型、長期運作的網站上也能可行。

同樣重要的是，WordPress 核心也很清楚自己「不做」什麼。儘管更廣泛的生態系統已經在 AI、協作工具和進階工作流程上做了大量實驗，核心依然優先考慮 API、基本元件和向後相容性，而不是打包那些帶有明確取向的一般使用者功能。這延續了 WordPress 一貫的歷史路線：把創新留在生態系邊緣發生，同時維持核心的保守與可預測性。

在日益兩極化的 CMS 市場中，這些選擇進一步強化了 WordPress 作為長期網路基礎設施的地位。其他平台或許是靠更緊密管理、垂直整合的體驗來做出差異化，但 WordPress 依然更偏向適應性、長期可維持性，以及在大規模下降低風險。它在 2025 年的技術走向，不是逐項功能追趕競爭者，而是要在最廣泛、最多樣的網路使用情境中維持可運作性。

### 頁面編輯器

頁面編輯器已成為 WordPress 生態系統中的主要操作介面之一。估計約有 60% 的 WordPress 網站使用頁面編輯器，反映出市場對更快迭代、減少對開發者依賴，以及提高編輯自主權的需求。Elementor 擁有最大的觀測使用量，其次是 WPBakery 和 Divi，而原生區塊編輯器也被廣泛使用。

頁面編輯器之所以受歡迎，是因為它們能加快工作流程。所見即所得的編輯、可重複使用元件和範本庫，讓非技術使用者也能在不寫程式的情況下調整版面，這和更廣泛的無程式碼與元件式開發趨勢一致。對許多組織來說，這能有效縮短瓶頸與迭代週期。

但這些優勢也伴隨取捨。頁面編輯器通常會產生更複雜的 DOM 結構，以及更大的 CSS 和 JavaScript 套件，在規模擴大時提高效能風險。尤其較舊的建構器，更容易留下長期維護和供應商綁定問題。隨著效能期待越來越高，這些成本也變得更加明顯。

作為回應，主要的建構器正逐步向 WordPress 核心慣例靠攏。較新的發展方向優先考慮區塊原生輸出、減少對短代碼的依賴，以及與區塊編輯器和 FSE 的更深入整合。許多建構器不再試圖取代核心，而是圍繞共享的基礎元件逐漸收斂，主要在使用者體驗層競爭。

頁面編輯器改變了 WordPress 頁面的組合與渲染方式，對效能有很直接的影響。它們把版面與設計抽象成視覺元件，減少了自訂程式碼的需求，也加快了網站建置速度。但這層額外抽象同時會影響 DOM 複雜度、資源載入行為和執行階段的負擔，使頁面編輯器成為 WordPress 網站之間效能差異的重要來源。

從歷史來看，許多頁面編輯器都和冗長的標記，以及大量 CSS、JavaScript 載入有關，這往往會導致載入速度變慢，Core Web Vitals 表現也較差。較新的建構器嘗試透過條件式資源載入、壓縮處理，以及減少短代碼使用來改善這點。這些努力確實有幫助，但仍不足以完全消除大量使用建構器的網站和控制更嚴謹的建置方式之間的效能差距。

{{ figure_markup(
  image="top-5-page-builders.png",
  caption="前 5 大頁面編輯器。",
  description="長條圖比較了桌面版和行動版平台上主要頁面編輯器的採用率。Elementor 是明顯的市場領導者，行動版採用率達 43%、桌面版 42%，是 WordPress 區塊編輯器 18% 的兩倍多。其他受歡迎的建構器如 wpBakery（13%）和 Divi（10%）緊隨其後，而所有列出平台在桌面版和行動版之間的採用差距都相當一致。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=216707306&format=interactive",
  sheets_gid="527845777",
  sql_file="wordpress_page_builders.sql"
  )
}}

使用模式也正在改變。從 2024 年到 2025 年，Elementor 仍是最廣泛使用的頁面編輯器，但市佔率已從約 56% 降到 43%，顯示整體生態變得更分散。WordPress 區塊編輯器成長到約 18%，WPBakery 則從約 21% 降到 13%。Divi 從約 14% 降至 10%，Beaver Builder 則維持在約 2% 這個小而穩定的市佔率。這些趨勢顯示，市場正逐漸從較舊的建構器，轉向區塊原生或更重視效能的做法。

{{ figure_markup(
  image="top-5-page-builder-bundles.png",
  caption="前 5 大頁面編輯器組合。",
  description="長條圖顯示桌面版和行動版平台上使用特定頁面編輯器組合的網頁百分比。Elementor 和 WordPress 區塊編輯器的組合是明顯的市場領導者，應用在 5.0% 的行動版網站和 4.7% 的桌面版網站上。其他受歡迎的組合，如 Elementor 搭配 wpBakery，採用率明顯較低，約為 1.3%；而 WordPress 區塊編輯器加上網站編輯器這種較新的組合，目前僅被 0.2% 的頁面使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=2140205874&format=interactive",
  sheets_gid="527845777",
  sql_file="wordpress_page_builders.sql"
  )
}}

整體而言，資料顯示頁面編輯器仍是 WordPress 生態系統的核心一環，但它們對效能的影響，如今高度取決於和 WordPress 核心的契合程度。能減少標記負擔、避免全域資源載入，並且深度整合區塊編輯器的建構器，往往更能有效控制效能成本。隨著外界對效能的期待持續提高，建構器之間的技術差異，可能會比它們提供哪些視覺功能更重要。

## CMS 使用者體驗

到目前為止所描述的架構和效能權衡，不僅受平台設計影響，也受 CMS 的實際使用方式影響。CMS 的使用者體驗——尤其是編輯者和管理員的體驗——仍然是現實成果中一個關鍵但往往被低估的驅動因素。

跨平台來看，編輯端使用者體驗通常強調靈活性多於結構性，提供大量選項，卻少有足夠的防呆機制。有效的 CMS 使用者體驗反而更依賴結構化元件、合理的預設值，以及基於角色的權限設計，來降低認知負擔並支援一致的發布流程。隨著網站成長，額外需求例如治理、審核工作流程、分類法管理和在地化，也會讓 CMS 使用者體驗從設計偏好轉變成維運需求。

雖然大多數訪客看不見這一層，CMS 使用者體驗卻會直接影響前端品質。限制不足的編輯工具，可能導致版面不一致、頁面過重、無障礙問題，以及內容過時。換句話說，後台使用者體驗其實會間接形塑一般使用者感受到的效能、內容可見度和無障礙性。

面對這些挑戰，一個常見做法就是採用頁面編輯器，透過對編輯者更友善的視覺介面來簡化版面和設計。這和 HTTP Archive 的發現相互呼應：WordPress 網站的效能差異，更多是由設定與工具選擇造成，而不是核心本身。

## Core Web Vitals

Core Web Vitals 提供了一種務實的方式，來觀察 CMS 平台在真實世界條件下的效能表現。這些指標不是呈現理論上的最佳效能，而是捕捉平台預設值、託管選擇、佈景主題、外掛和頁面編輯器綜合作用後，由真實使用者實際感受到的結果。

本節檢視主要 CMS 平台逐年的 Core Web Vitals 效能表現，並聚焦在行動版，因為它的限制更嚴格、差異也更容易看出來。目標不是要選出單一「最快」的 CMS，而是理解不同程度的平台控制力和生態系複雜度，會如何在大規模部署時影響效能。

### 年度趨勢

{{ figure_markup(
  image="mobile-year-over-year-core-web-vitals-performance-per-cms.png",
  caption="各 CMS 行動版年度 Core Web Vitals 效能。",
  description="長條圖追蹤 2024 年和 2025 年間十個主要平台行動版網站達到「良好」分數的百分比。Duda 以 85% 的網站達標表現最佳，其次是 TYPO3 CMS 的 79% 和 Wix，後者從 55% 大幅躍升至 74%。雖然大多數平台顯示穩定改善，但 Weebly 是唯一略有下降的 CMS，降至 47%，而 WordPress 仍屬最低排名之列，通過率為 45%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1431389142&format=interactive",
  sheets_gid="12600581",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

從 2024 年到 2025 年，大多數 CMS 平台的整體 Core Web Vitals 效能有所改善，但改善幅度各異。擁有更嚴格管理環境的平台取得了最大的進步——由 Wix（年度約 +14%）和 Duda（+11%）領先，接著是 Squarespace（+8%）和 Joomla（+7%）。一些較小的平台，包括 1C-Bitrix、Tilda 和 TYPO3，改善了約 5%。

可擴充性較高的平台改善幅度較小。WordPress 和 Drupal 各自年增約 4%，而 Weebly 則略為下滑（約 -1%）。這些模式凸顯出，在允許更多客製化和實作多樣性的生態系中，要把改進平均推展出去有多困難。

### 最大內容繪製（LCP）

最大內容繪製衡量頁面主要內容出現的速度，是感知載入速度中最重要的指標之一。

{{ figure_markup(
  image="mobile-year-over-year-cms-lcp-performance.png",
  caption="行動版年度 CMS LCP 效能。",
  description="長條圖顯示 2024 年和 2025 年各平台行動版網站達到「良好」LCP 分數的百分比。Duda 以 94% 的行動版網站達標表現最佳，其次是 TYPO3 CMS 的 89% 和 Wix 的 81%。雖然大多數平台顯示穩定的年度進步——Tilda 達到 56%、WordPress 達到 53%——Weebly 是唯一略有下降的 CMS，降至 52%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=625293536&format=interactive",
  sheets_gid="12600581",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

在 2025 年，54% 的網站達到了「良好」LCP 分數，反映出整體仍在持續進步，但平台間的差異依然明顯。

大多數 CMS 平台的 LCP 都有逐年改善。Wix 以約 10% 的增幅領先，接著是 Squarespace（+7%）和 Duda（+5%）。WordPress、Joomla 和 Drupal 各自改善約 4%，而 Weebly 則略為下滑（約 -1%）。這些差異，和各平台在資源載入、圖片最佳化及預設設定上的選擇相當一致。

### 累計版面位移（CLS）

累計版面位移透過測量意外的版面移動來捕捉頁面在載入時的視覺穩定性。

{{ figure_markup(
  image="mobile-year-over-year-cms-cls-performance.png",
  caption="行動版年度 CMS CLS 效能。",
  description="長條圖比較 2024 年和 2025 年十個平台行動版網站達到「良好」CLS 分數的百分比。Wix 顯示最顯著的改善，從 2024 年約 86% 上升至 2025 年的 95%，而 Duda 和 Squarespace 也以 93% 和 89% 的分數維持強勢領先。相反，Weebly 是唯一明顯下降的平台，降至 58%，而 WordPress 和 Joomla 維持穩定在約 84% 的分數。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1790391969&format=interactive",
  sheets_gid="12600581",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

CLS 仍然是跨平台中最不均衡的指標之一，反映了在管理延遲載入內容、嵌入物和動態版面方面的挑戰。

Wix 再次顯示最強的年度改善（約 +8%），接著是 Duda（約 +4%），然後是 Joomla 和 1C-Bitrix（各約 +3%）。其他平台變化不大，而 Weebly 則經歷了顯著的下降（約 -8%）。整體而言，CLS 的結果似乎高度依賴於實作紀律，而非僅僅是平台選擇。

### 互動至下次繪製（INP）

互動至下次繪製衡量頁面在所有使用者互動中的回應速度，而不僅是初始載入時。

{{ figure_markup(
  image="mobile-year-over-year-cms-inp-performance.png",
  caption="行動版年度 CMS INP 效能。",
  description="長條圖顯示 2024 年和 2025 年十個不同平台行動版網站達到「良好」INP 分數的百分比。Squarespace 以令人印象深刻的 96% 成功率領先，緊隨其後的是 TYPO3 CMS 的 95% 和 Duda 的 94%。雖然幾乎所有平台都顯示年度改善——Tilda 從約 58% 顯著躍升至 68%——1C-Bitrix 和 Weebly 仍是表現最低的，均為 71% 的分數。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1672867090&format=interactive",
  sheets_gid="12600581",
  sql_file="core_web_vitals_yoy.sql",
  width=600,
  height=559
  )
}}

與 LCP 和 CLS 相比，INP 的改善幅度不大，這突顯了管理 JavaScript、長時間任務和第三方腳本的困難程度。

在 2025 年，1C-Bitrix 在 INP 改善方面領先（約 +10%），接著是 Squarespace 和 Duda（約 +6%），Joomla 和 Tilda（約 +5%），以及 Drupal（+3%）。Weebly 再次出現下降（-3%）。整體而言，沒有任何 CMS 能在規模化時持續提供優異的 INP，這表明互動延遲仍然是一個共同的問題。

## Lighthouse 品質指標

Lighthouse 從實驗室測試的角度提供了關於網站品質的互補觀點，涵蓋效能、無障礙性、SEO 和最佳實踐。雖然 Lighthouse 分數不直接反映真實使用者體驗，但它們有助於在一致的測試條件下比較典型的實作。

### 效能

{{ figure_markup(
  image="median-lighthouse-performance-score.png",
  caption="Lighthouse 效能分數中位數。",
  description="長條圖顯示各種內容管理系統在桌面版和行動版平台上的中位數效能結果。Wix 在兩種裝置上都取得了最高的中位數效能分數，桌面版 87 分、行動版 64 分，接著是 Duda 和 Webflow 也有相對較高的結果。相比之下，Squarespace、1C-Bitrix 和 PrestaShop 在行動版的效能最低，分數在 30 至 32 分之間。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1861912868&format=interactive",
  sheets_gid="1453203753",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

2024 年至 2025 年間，Lighthouse 效能分數的中位數在桌面版和行動版上均有改善，桌面版的分數始終較高。在桌面版中，Wix（87）和 Duda（81）遙遙領先，接著是 Webflow（73）。WordPress 記錄了 63 分的中位數，多個平台的分數相近。

在行動版上，各平台的分數普遍較低。Wix 以 64 分領先，接著是 Webflow（58）、Duda（57）和 Shopify（52）。WordPress（41）和 Joomla（40）排在其後，而 PrestaShop 和 1C-Bitrix 則分數最低。年度變化方面，Wix 在行動版上的進步最大（從 55 升至 64），而大多數其他平台僅有小幅變動或保持穩定。這些實驗室分數最好作為背景參考，而非真實使用者體驗的替代指標。

### SEO

{{ figure_markup(
  image="median-lighthouse-seo-score.png",
  caption="Lighthouse SEO 分數中位數。",
  description="長條圖顯示十大主要 CMS 在桌面版和行動版上的 SEO 分數。Wix 和 Webflow 表現最佳，在兩種裝置類型上均達到滿分 100 分。值得注意的是，其他所有列出的 CMS——包括 WordPress、Shopify 和 Drupal——均維持相同的 92 分高分，在所有列出平台的桌面版和行動版之間沒有效能差異。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=2147163809&format=interactive",
  sheets_gid="1453203753",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

在 2025 年，Lighthouse SEO 分數在 CMS 平台間普遍偏高，大多數在行動版和桌面版上聚集在 92 到 100 分之間。Webflow 和 Wix 達到滿分，而 WordPress、Duda 和 Joomla 則維持在約 92 分。微小的年度變化顯示，基本的 SEO 最佳實踐現在已廣泛內建於現代 CMS 平台中。

### 無障礙性

{{ figure_markup(
  image="median-lighthouse-accessibility-score.png",
  caption="Lighthouse 無障礙性分數中位數。",
  description="長條圖顯示十大主要 CMS 在桌面版和行動版裝置上的無障礙性分數。Wix 和 Squarespace 分別以 95 分和 94 分的優異成績領先，在兩種平台上表現高度一致。雖然 Webflow 和 Shopify 等其他系統分別維持 90 分和 89 分的穩定分數，1C-Bitrix 以 76 分的最低分落在最後。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=2114036485&format=interactive",
  sheets_gid="1453203753",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

無障礙性分數比 SEO 的差異更大，但年度變化仍然有限。在 2025 年，中位數分數範圍從 76 到 95 分，Wix（95）和 Squarespace（94）領先。WordPress 和 Joomla 保持穩定，而 1C-Bitrix 以 76 分落後。整體而言，改善是漸進的，顯示出穩定但並非變革性的進展。

### 最佳實踐

{{ figure_markup(
  image="median-lighthouse-best-practices-score.png",
  caption="Lighthouse 最佳實踐分數中位數。",
  description="長條圖比較了十個不同 CMS 平台在桌面版和行動版裝置上的最佳實踐分數。Wix 和 Squarespace 表現最佳，桌面版均達到近乎完美的 96 分，Wix 在行動版緊隨其後為 93 分。大多數其他平台，包括 WordPress、Shopify 和 Duda，維持在 70 多分到 80 分出頭的穩定分數，而 1C-Bitrix 以桌面版 59 分和行動版 61 分的最低分落在最後。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=630122711&format=interactive",
  sheets_gid="1453203753",
  sql_file="lighthouse_category_scores_per_cms.sql",
  width=600,
  height=559
  )
}}

最佳實踐分數顯示出更明顯的分化。在行動版上，Squarespace（96）和 Wix（93）領先，接著是 Drupal 和 PrestaShop（均為 82）。WordPress、Duda 和 Joomla 聚集在 79 分附近，1C-Bitrix 排名最低為 61 分。桌面版的結果遵循類似的模式。

年度變化方面，部分平台有明顯改善，尤其是 Wix（從 79 升至 93）和 Drupal（從 79 升至 82），而其他平台則幾乎沒有變動。這些差異反映出，在現代 API 使用、安全設定和錯誤處理等面向上，平台之間仍存在持續性的落差。

## 頁面大小與資源組成

「頁面大小」是瀏覽器渲染頁面所需下載的所有資源的總大小。在過去十年中，頁面大小持續增加。

{{ figure_markup(
  image="distribution-of-cms-page-weight.png",
  caption="CMS 頁面大小分佈。",
  description="長條圖顯示五個受歡迎的行動版 CMS 平台在各百分位數的總頁面大小（以 KB 為單位）。Squarespace 產生最重的網站，中位數（第 50 百分位數）為 3,974 KB，而 Joomla 和 WordPress 最輕，分別為 2,900 KB 和 2,894 KB。所有平台在第 90 百分位數都有大幅增加，一些行動版頁面超過 8,000 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1506051680&format=interactive",
  sheets_gid="1551200507",
  sql_file="page_weight_distribution.sql"
  )
}}

在 2025 年，平均頁面在桌面版約為 2.67 MB，行動版約為 2.28 MB。兩者都超過了常見的 1-1.5 MB 建議範圍，反映了整個網路持續的膨脹。

大部分的成長來自圖片和 JavaScript，而 HTML 在總傳輸量中仍只佔相對較小的一部分。儘管大家對效能問題的認知不斷提高，頁面大小仍持續增加。載入時間超過 3 秒的頁面，通常會有更高的跳出率，而額外延遲也和較低的轉換率高度相關。對使用慢速或按量計費連線的行動使用者來說，過重的頁面可能就是實際的存取障礙。

因此，頁面大小不只是技術細節。它會形塑使用者感受、無障礙性，以及商業成果。把頁面大小當成第一級限制來管理的組織，通常能得到更可預測的效能；忽略這點的組織，往往就得承受遲滯的體驗與降低的參與度。

### 依 CMS 分析的總頁面大小

CMS 平台間的總頁面大小差異很大，受預設佈景主題、資源處理流程、外掛生態系統和託管模式的影響。雖然所有平台的頁面大小都在增加，但 CMS 的選擇仍然影響著頁面大小的中位數和分佈範圍。

{{ figure_markup(
  image="median-cms-page-weight.png",
  caption="CMS 頁面大小中位數。",
  description="長條圖比較了五個主要平台在桌面版和行動版裝置上的中位數總載入位元組。Squarespace 產生的網站明顯最重，行動版中位數為 3,974 KB，桌面版更高。相比之下，Joomla 和 WordPress 是最輕的平台，行動版中位數分別為 2,900 KB 和 2,894 KB。所有列出系統的桌面版頁面載入位元組始終高於行動版。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=439542488&format=interactive",
  sheets_gid="1256129490",
  sql_file="resource_weights.sql"
  )
}}

處在更受控環境中的平台，往往會呈現更集中的分布。可擴充性較高的 CMS 則顯示出更大的差異，頁面大小不太是由核心決定，而更多是佈景主題、外掛、頁面編輯器和第三方工具長期累積後的結果。因此，即使使用同一套 CMS，兩個網站的總傳輸量也可能差很多。

這種差異也呼應了前面看到的效能模式，進一步強化頁面大小和整體效能結果之間的關聯。

### 資源組成：圖片

圖片仍然是所有 CMS 平台上頁面大小的最大貢獻者。即使現代格式和回應式圖片技術變得更加普遍，其好處往往被不斷增加的圖片數量和更大的視覺資源所抵消——尤其是在範本密集和視覺豐富的網站上。

{{ figure_markup(
  image="median-cms-size-of-images.png",
  caption="CMS 圖片大小中位數。",
  description="長條圖顯示五個不同 CMS 在桌面版和行動版平台上載入的中位數圖片總位元組。資料顯示 Joomla 和 Squarespace 的中位數圖片大小最高，Joomla 在行動版以 1,612 KB 領先，而 Wix 以行動版僅 194 KB 的數值維持了明顯最小的佔用。所有列出的 CMS，包括 WordPress 和 Shopify，桌面版載入的圖片資料量始終高於行動版。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1131984006&format=interactive",
  sheets_gid="1256129490",
  sql_file="resource_weights.sql"
  )
}}

在圖片處理上提供更強預設值的 CMS 平台，通常會產生更小、也更一致的圖片載入量。在較有彈性的系統中，圖片最佳化高度仰賴佈景主題選擇、外掛設定和編輯習慣，因此更容易出現落差。

圖片載入量持續增加，也說明了為什麼有些平台即使改善了載入指標，整體頁面依然會變得更重。

### 資源組成：JavaScript

JavaScript 是頁面大小中成長最快的一部分，也是執行階段效能最重要的因素之一。JavaScript 載入量反映出 CMS 核心邏輯、佈景主題、頁面編輯器、分析工具、廣告和其他第三方服務加總起來的成本。

頁面編輯器和元件式系統通常會提高 JavaScript 的使用量，因為它們增加了前端渲染和互動層。雖然較新的作法試圖減少不必要腳本的載入，但 JavaScript 仍然是前面提到那些互動延遲與反應速度問題的主要來源。

{{ figure_markup(
  image="median-cms-size-of-javascript.png",
  caption="CMS JavaScript 大小中位數。",
  description="長條圖顯示五個主要 CMS 在桌面版和行動版裝置上載入的中位數 JavaScript 位元組。Wix 和 Shopify 呈現最高的 JavaScript 載入量，行動版中位數分別為 1,634 KB 和 1,615 KB。相比之下，Joomla 和 WordPress 維持明顯較小的 JavaScript 佔用，行動版裝置載入中位數分別為 453 KB 和 638 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=782647613&format=interactive",
  sheets_gid="1256129490",
  sql_file="resource_weights.sql"
  )
}}

和整體頁面大小一樣，在可擴充性較高的 CMS 生態系中，JavaScript 成本的差異也非常明顯。實作選擇往往比單純的平台選擇更重要。

### CSS 和 HTML

CSS 和 HTML 在總頁面大小中的佔比雖然小於圖片和 JavaScript，但仍然會影響渲染。大型全域樣式表、重複規則，或沒有明確作用範圍的樣式，都可能拖慢渲染並增加阻塞時間。

{{ figure_markup(
  image="median-cms-size-of-html.png",
  caption="CMS HTML 大小中位數。",
  description="長條圖顯示五個主要 CMS 在桌面版和行動版平台上載入的中位數 HTML 位元組。Wix 的 HTML 佔用明顯最大，桌面版中位數載入 163 KB、行動版 162 KB。相比之下，Joomla 和 Squarespace 維持最小的中位數大小，Joomla 桌面版僅載入 22 KB、行動版 20 KB。所有顯示的系統中，HTML 的中位數大小在裝置類型之間相對一致，但桌面版在每個情況下都略重。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1793928495&format=interactive",
  sheets_gid="1256129490",
  sql_file="resource_weights.sql"
  )
}}

{{ figure_markup(
  image="median-cms-size-of-css.png",
  caption="CMS CSS 大小中位數。",
  description="長條圖顯示五個 CMS 在桌面版和行動版裝置上載入的中位數 CSS 位元組。Squarespace 和 WordPress 載入最多 CSS，Squarespace 行動版中位數達 165 KB、WordPress 為 119 KB。相比之下，Wix 幾乎不載入外部 CSS 檔案，桌面版和行動版的中位數值僅為 1 KB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQl8kslfFxccGPgWkzCtjnDEtkWaZfqnxncddAaoIhMjAtkmY_1laqzaTbrq-9G-cCiQlzjqeXFk3P4/pubchart?oid=1384155263&format=interactive",
  sheets_gid="1256129490",
  sql_file="resource_weights.sql"
  )
}}

基於區塊和元件驅動的系統，越來越常動態產生 CSS。當快取和重複使用做得好時，這有助於減少未使用樣式；但如果處理不當，反而會增加複雜度和負擔。這些取捨也呼應了本章前面談過的更大架構主題。

### 頁面大小、效能與差異

頁面大小與效能之間的關係並非嚴格線性的，但關聯性很強。較重的頁面更可能未達到 Core Web Vitals 門檻，尤其是在行動裝置上，網路和 CPU 限制會放大低效率。

跨 CMS 來看，頁面大小比較像是一個會層層累加的因素，而不是單一故障點。大量圖片載入、過大的 JavaScript，以及全域資源會隨時間越堆越多，進一步提高載入緩慢、視覺不穩定和互動遲滯的機率。限制客製化的平台，通常會透過一致的預設值來降低這種風險；可擴充性較高的系統，則把更多責任交給網站擁有者和建置團隊。

整體而言，頁面大小再次強化了本章的核心觀點：CMS 平台是透過影響資源如何被組成與傳遞，來間接形塑效能。隨著頁面越來越複雜，管理頁面裡放了什麼，以及它們如何被傳遞，就成了維持穩定效能的關鍵。

## 新興 Web API

隨著 CMS 平台日趨成熟，瀏覽器能力在塑造效能和使用者體驗上扮演的角色也越來越大。新的 Web API 越來越能提供跨框架與 CMS 都適用的改進，把部分最佳化工作從伺服器移到瀏覽器端。這些 API 不會消除底層成本，但若使用得宜，確實可以降低體感延遲並改善反應速度。

本節重點介紹那些已開始影響 CMS 驅動網站導覽速度、互動反應速度和體感效能的瀏覽器層級能力。

### Speculation Rules API

導覽延遲仍然是內容密集型多頁面網站最明顯的卡頓來源之一，而這正是許多 CMS 最常支撐的網站型態。Speculation Rules API 透過讓瀏覽器預測可能發生的導覽，並提前預備頁面內容，例如預取或預渲染，來緩解這個問題。

和傳統預載不同，推測規則允許開發者宣告哪些導覽最有可能發生，以及瀏覽器應在什麼條件下採取行動。早期採用結果顯示，它確實能為導覽效能帶來可衡量的改善，包括更低的 First Contentful Paint、最大內容繪製，以及常見瀏覽路徑上更流暢的頁面轉場。

對 CMS 而言，Speculation Rules API 的關鍵價值在於，它能在不改變後端渲染邏輯的情況下改善體感導覽速度。由於推測式載入發生在瀏覽器端，因此可以降低資料庫延遲、外掛帶來的額外負擔，或頁面編輯器複雜度所造成的影響，特別是在導覽路徑較可預測的網站上。這個 API 目前已獲 Chromium 系列瀏覽器支援，在其他瀏覽器中則會被安全地忽略，因此很適合用於漸進式增強。

### Long Animation Frames API（LoAF）

雖然許多 CMS 平台的載入效能已有改善，但互動反應速度仍然是長期難題。Long Animation Frames API 建立在先前長任務測量的基礎上，專門追蹤那些會阻塞視覺更新與使用者回饋的延遲動畫幀。這對理解互動至下次繪製（INP）特別有幫助。

LoAF 把焦點從單一 JavaScript 任務移到完整幀延遲，因此更容易精準找出真正影響反應速度的因素。它會指出哪些腳本、版面操作或渲染步驟最常造成慢幀，幫助團隊找出那些未必會在初始頁面載入測試中浮現的問題。

這對 CMS 驅動網站尤其重要，因為卡頓通常不是來自單一阻塞操作，而是長期累積的複雜度。頁面編輯器、分析工具、廣告和第三方服務，可能會以拖慢整體反應速度的方式彼此互相影響。LoAF 讓團隊能在真實使用者監控中看見這些模式，理解互動在整段使用流程中的表現，而不只是頁面剛載入時的情況。

### View Transitions API

View Transitions API 透過允許瀏覽器為內容變更製作動畫效果，實現更流暢的視覺轉場。雖然這更多是關於視覺連續性而非原始速度，但它可以顯著改善感知效能——尤其是在使用者頻繁導航的內容密集型網站上。

對 CMS 平台來說，視覺轉場之所以重要，是因為它縮小了傳統多頁面網站與單頁應用程式之間的體驗差距。若再搭配推測式載入等技術，就能讓伺服器端渲染的 CMS 網站也呈現更流暢的感受，而不必採用複雜的 SPA 架構。瀏覽器支援仍不平均，實際採用也還在早期，但初步跡象已顯示市場對提升體感效能的興趣持續增加。

### Priority Hints 和 Scheduling API

隨著頁面變得更複雜，資源優先順序在效能中的角色也越來越重要。Priority Hints 可讓開發者告訴瀏覽器哪些資源，例如圖片、字型或腳本，更值得優先處理，好讓瀏覽器在條件受限時調整載入順序。若使用得當，它能在不減少總頁面大小的前提下，改善關鍵渲染里程碑。

同樣地，新的 Scheduling API 也讓開發者對主執行緒工作的排程時機有更多控制，能更容易把較不重要的任務延後到使用者可見互動之後再執行。對功能層次很多的 CMS 頁面而言，這些工具有助於減少關鍵互動時刻的資源競爭。

### 對 CMS 平台的影響

總體而言，這些 API 代表了網路效能改善方式更廣泛的轉變。平台不再只能依賴後端變更或 CMS 專屬最佳化，而是越來越能依靠會根據使用者行為和裝置能力調整的瀏覽器端智慧。當然，這些 API 並不會消除大型載入量或繁重執行本身的成本。

對 CMS 生態系統而言，這再次強化了一個熟悉的模式：瀏覽器 API 雖然可以緩和部分因可擴充性而帶來的差異，但仍無法消除靈活性和可預測性之間的核心取捨。它們能發揮多大效果，仍取決於審慎的設定、對使用者行為的務實假設，以及與既有架構之間是否相容。

隨著瀏覽器持續演進，CMS 平台很可能會逐步採用這些 API，用它們讓導覽更順、反應更快、體感延遲更低，而不需要把核心設計整個重做。從這個角度看，新興 Web API 更像是現有效能策略的放大器，而不是顛覆性的力量。

## CMS 中的人工智慧

AI 功能在 CMS 平台中越來越普遍，但目前它對內容工作流程的影響，仍大於對核心內容傳遞效能的影響。大多數情況下，AI 主要被用來協助內容建立、整理與豐富，而不是直接改變內容如何被渲染或提供給使用者。

跨生態系統而言，AI 的採用是不均衡且大多是可選的。AI 通常以輔助層的形式出現——透過外掛、擴充功能或外部服務——而非作為 CMS 核心的根本性改變。常見的用途包括內容撰寫和編輯、摘要、翻譯、圖片生成、標記和 SEO 中繼資料建議。

大多數 AI 工作流程都發生在內容編寫階段，或是在非同步後端執行，因此不太會明顯影響頁面大小、資源組成或 Core Web Vitals。當 AI 真正被用在執行階段，例如個人化、推薦或動態內容時，它的影響則更可能透過額外的 JavaScript 或網路請求間接顯現，端看實作方式而定。

AI 和其他 CMS 趨勢交會的一個領域，是內容製作規模。當 AI 降低了製作、上架與更新內容的成本，也縮短了分發到其他管道所需的時間，就可能帶來更多頁面、更豐富的媒體，以及更動態的體驗。這些變化也可能進一步加劇頁面大小、前端執行和快取方面既有的效能挑戰，呼應本章其他部分看到的模式。

目前，CMS 平台中的 AI 最適合被理解為工作流程加速器，而不是效能最佳化工具。它對使用者體驗的影響，主要還是透過編輯實務、治理和實作紀律間接產生，而不是直接帶來可量測的載入速度或反應速度提升。未來若 AI 更深入進入執行階段系統，它對效能的影響可能會加大；但目前證據顯示，它的主要影響仍偏向營運層面。

## LLM 搜尋時代的 CMS

基於大型語言模型（LLM）的搜尋與答案引擎正在改變 CMS 內容被評估與使用的方式。和專注於頁面排名的傳統搜尋引擎不同，LLM 系統會擷取、摘要並重新組合內容。這讓內容結構、清晰度、即時性和機器可讀訊號變得更重要。

從 HTTP Archive 的角度來看，這些變化會反映在結構化資料使用增加、內容層級更清楚，以及語意標記更一致等現象上。能促進結構良好 HTML、合理標題順序和豐富中繼資料的 CMS 平台，更有利於內容被 LLM 系統準確理解並再次使用。

索引行為也正在改變。基於 LLM 的工具，通常更偏好定期更新、來源清楚且容易擷取的內容。支援快速更新和程式化產生中繼資料的 CMS，可能因此取得間接優勢。另一方面，若頁面高度依賴前端渲染、大量 JavaScript 套件，或延後內容水合，內容就可能變得較不容易被看見，因為擷取速度會更慢，或擷取結果不完整。

這些變化和前面談到的效能模式密切相關。若某個 CMS 已經在 JavaScript 膨脹、LCP 偏慢或 INP 不佳方面表現吃力，就可能進一步面臨複合型的內容可見度問題，因為 LLM 系統會越來越偏好效率與清晰度。LLM 搜尋不會取代傳統索引，但它確實放大了靈活性、效能和內容結構之間既有的取捨。

## 結構化資料的演進

結構化資料已成為 CMS 平台、搜尋引擎和 AI 驅動內容消費端之間的重要層。到了 2025 年，它不再只是用來支援複合式搜尋結果或強化搜尋呈現的工具，而是越來越常被當成機器可讀的上下文，用來決定內容如何在自動化系統中被解讀、摘要與呈現。

HTTP Archive 資料顯示，CMS 中結構化資料的使用穩定成長，但實作品質差異很大。具有原生 Schema 支援的平台，往往能產生更一致、也更可預測的標記；高度依賴外掛或自訂實作的平台，則呈現出更大的落差。這也呼應了更廣泛的效能模式，也就是靈活性往往要用一致性來交換。

結構化資料也會和效能及頁面大小相互影響。實作不當的 Schema，可能在沒有實質好處的情況下讓 HTML 膨脹，並增加 DOM 複雜度。相反地，定義良好的結構化資料只會帶來很小的額外負擔，同時讓內容更容易被理解。隨著 CMS 越來越常自動產生 Schema，而且常常透過 AI 輔助工具完成，風險也從「缺少結構化資料」轉向「結構化資料過多」；冗餘或不必要的標記只會增加負擔，卻不見得改善結果。

在搜尋和探索系統不斷演進的環境中，結構化資料就是一種相對穩定的訊號。會驗證 Schema、限制冗餘，並把結構化資料整合進核心範本，而不是零散散落在各種臨時外掛中的 CMS 平台，更有可能產出長期可用、也更機器友善的內容。隨著自動化內容消費持續增長，結構化資料的成熟度也越來越成為不只在 SEO，而是在內容長期韌性上的關鍵差異化因素。

## 結論

2025 年的 CMS 生態反映出一個成熟且日益兩極化的網路。HTTP Archive 資料顯示，如今絕大多數網站都由 CMS 平台支撐，而非 CMS 網站在整體網路中的佔比則持續縮減。同時，採用模式、效能結果和資源使用，也會因平台選擇、託管模式和實作紀律而有很大差異。

市場佔比資料再次確認，WordPress 仍是主導性的 CMS，支撐超過 60% 的 CMS 網站。Shopify 等平台在特定利基市場持續快速成長，尤其是在電子商務領域；而許多其他託管型頁面編輯器則已出現放緩跡象。依排名來看，這些趨勢並不平均：開源 CMS 在高流量網站中仍然佔比較高，而 SaaS 建構器則主導了較小規模網站的長尾。這也代表 CMS 的選擇越來越受到組織需求和限制條件驅動，而不只是一般性的知名度。

效能資料強化了這種分化。垂直整合的平台傾向提供更一致的 Core Web Vitals，尤其在行動版上。自行託管的 CMS 則顯示出更大的差異，受佈景主題、外掛和第三方整合的影響。頁面大小和資源組成的資料進一步顯示，實作決策通常比平台預設值更為重要。即使在同一個 CMS 內，網站的表現也從高度最佳化到嚴重膨脹不等，這突顯了效能是一個持續的實踐，而非內建的保證。

Core Web Vitals 和 Lighthouse 的結果共同突顯了一個反覆出現的主題：CMS 的選擇主要是透過它提供的限制、預設值和工具來影響效能。處在更受控環境中的平台，往往能產生更穩定的成果；可擴充性較高的系統，則同時容許非常出色和非常糟糕的實作存在。

這些模式並不指向簡單的贏家和輸家。相反，它們反映了靈活性、控制力和可預測性之間的權衡。隨著 CMS 生態系統日趨多樣化，成果越來越少取決於網站底部的標誌，而更多取決於每個平台的工具和限制如何契合網站的複雜度、團隊的能力和長期維護目標。

現代 Web API、AI 輔助工作流程，以及基於 LLM 的內容消費越來越重要，也帶來了額外壓力。結構化資料、語意標記和高效率的內容傳遞，已經不再只是錦上添花的最佳化，而是越來越決定內容在傳統搜尋和新一代 AI 介面中，是否更容易被找到、被理解，並維持良好效能。能促進一致結構、限制不必要複雜度，並善用現代瀏覽器能力的 CMS 平台，也會更有適應優勢。

總體而言，2025 年 CMS 生態系統的關鍵不在於成長幅度，而在於取捨。靈活性往往會放大效能差異，易用性可能帶來更重的頁面，而自動化則引入新的治理與品質挑戰。CMS 平台會持續演進，但現實成果中真正的主導因素仍然是實作。隨著網路越來越重視速度、穩定性和機器可讀內容，CMS 仍會繼續扮演核心基礎設施的角色，不是因為它們隱藏了複雜度，而是因為它們決定了複雜度在大規模運作時會如何呈現。
