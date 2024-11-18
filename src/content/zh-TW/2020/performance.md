---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 效能
description: 2020 Web Almanac 的效能章節涵蓋了 Core WebVitals、Lighthouse Performance Score、First Contentful Paint (FCP) 以及 Time to First Byte (TTFB)。
hero_alt: Hero image of Web Almanac characters images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [thefoxis]
reviewers: [borisschapira, rviscomi, foxdavidj, noamr, Zizzamia, exterkamp]
analysts: [max-ostapenko, dooman87]
editors: [tunetheweb]
translators: [cybai]
thefoxis_bio: Karolina 是 <a hreflang="en" href="https://calibreapp.com/">Calibre</a> 的產品設計主管。她主要負責打造最全面的速度監測平台。她同時也是為您蒐集效能相關訊息與資訊的 <a hreflang="en" lang="en" href="https://perf.email/">Performance Newsletter</a> 發起人之一。Karolina 也<a hreflang="en" href="https://calibreapp.com/blog/category/web-platform">時常寫有關於效能如何影響使用者體驗的文章</a>。
discuss: 2045
results: https://docs.google.com/spreadsheets/d/164FVuCQ7gPhTWUXJl1av5_hBxjncNi0TK8RnNseNPJQ/
featured_quote: 糟糕的效能並不只是讓使用者挫折或是對業務目標造成負面影響，它還築起了現實生活中人們與網路世界的屏障；今年的全球性疫情更凸顯了那些已經存在的屏障。
featured_stat_1: 25%
featured_stat_label_1: 擁有 Good 的 FCP 的手機版網頁
featured_stat_2: 18%
featured_stat_label_2: 擁有 Good 的 TTFB 的手機版網頁
featured_stat_3: 4%
featured_stat_label_3: 在 Lighthouse 6 時效能分數（Performance Score）未改變的網站
---

## 簡介

緩慢的速度無庸置疑地對使用者體驗造成了負面的影響，進而影響了轉換率。但糟糕的效能並不只是讓使用者挫折或是對業務目標造成負面影響，它還築起了現實生活中人們與網路世界的屏障。今年的全球性疫情<a hreflang="en" href="https://www.weforum.org/agenda/2020/04/coronavirus-covid-19-pandemic-digital-divide-internet-data-broadband-mobbile/">更凸顯了那些已經存在的屏障</a>。隨著遠端學習、遠端工作還有遠端社交興起，人們的生活重心突然就被移到網路世界。微弱的訊號以及缺乏資源取得可用設備將這個轉變顯得更痛苦，即使不是非常嚴重，也已經對很多人造成影響。這樣的考驗凸顯了全球在訊號強度、設備以及網路速度上的不平等。

效能調校工具在近幾年持續演進，幫助工程師從不同面向去檢視使用者體驗，也使問題的成因更容易被找到。從[去年的效能章節](../2019/performance)開始，在這個領域中，已經有許多重要的開發貢獻改變了我們監控速度的方式。

隨著很受歡迎的品質檢測工具 <span lang="en">Lighthouse</span> 釋出 <span lang="en">Lighthouse</span> 6 後，<a hreflang="en" href="https://calibreapp.com/blog/how-performance-score-works">眾所皆知的效能分數（<span lang="en">Performance Score</span>）背後的演算法已經有了重大的改動</a>，因此分數也隨之變動。新釋出的<a hreflang="en" href="https://calibreapp.com/blog/core-web-vitals"><span lang="en">Core WebVitals</span></a>提供一套新的衡量標準來描述不同面向的使用者體驗。未來它將會影響搜尋引擎的排行，進而促使相關開發者社群聚焦於新的速度準則。

在此章節，我們將透過這些新工具來透視<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report"><span lang="en">Chrome User Experience Report</span> (CrUX)</a>提供的真實效能資料並分析相關的準則。在這邊必須特別註記，由於 iOS 的限制，CrUX 手機版的結果並不包含 Apple 手機作業系統的裝置。這個限制確實影響了我們的分析，尤其是在檢視各個國家的效能衡量標準的時候更能顯現出分析結果的差異。

讓我們一起一探究竟吧。

## <span lang="en">Lighthouse</span> 效能分數（<span lang="en">Performance Score</span>）{Lighthouse 效能分數}

在 2020 年五月時，<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/releases/tag/v6.0.0"><span lang="en">Lighthouse</span> 6 被釋出</a>。在此主版號更新中，受歡迎的效能檢測組針對效能分數（<span lang="en">Performance Score</span>）演算法做了顯著的改變。效能分數（<span lang="en">Performance Score</span>）可以說是檢測網站速度的最佳寫照 (<span lang="en">high-level portrayal</span>)。在 <span lang="en">Lighthouse</span> 6 之中，以六項（不是五項）衡量標準來評估分數：<span lang="en">First Meaningful Paint</span>、<span lang="en">First CPU Idle</span> 被移除並以 <span lang="en">Largest Contentful Paint</span> (LCP) 取代之、<span lang="en">Total Blocking Time</span>（TBT, the lab equivalent of <span lang="en">First Input Delay</span>）以及 <span lang="en">Cumulative Layout Shift</span> (CLS)。

新的分數演算法調整了新一代的效能衡量標準的優先度：<span lang="en">Core WebVitals</span>，以及降低 <span lang="en">First Contentful Paint</span> (FCP)、<span lang="en">Time to Interactive</span> (TTI) 以及 Speed Index 的優先度並減少他們的分數權重。此演算法現在也會個別強調三個層面的使用者體驗： **互動性**（<span lang="en">Total Blocking Time</span> 及 <span lang="en">Time to Interactive</span>）、**視覺穩定性**（<span lang="en">Cumulative Layout Shift</span>）以及**體感載入速度**（<span lang="en">First Contentful Paint</span>, Speed Index, <span lang="en">Largest Contentful Paint</span>）。

此外，該分數會根據桌機和手機的不同來使用不一樣的參考標準做計算。 實際上來說，這代表對桌機的標準較嚴格（預期較快的網頁）而在手機上標準較寬鬆（因為手機效能比桌機較慢）。你可以透過 <a hreflang="en" href="https://googlechrome.github.io/lighthouse/scorecalc/"><span lang="en">Lighthouse</span> 分數計算機</a>來比較 <span lang="en">Lighthouse</span> 5 及 6 之間的差異。所以，在評分上到底做了什麼變動呢？

{{ figure_markup(
  image="performance-change-in-lighthouse-score.png",
  caption="Lighthouse 版本 5 跟版本 6 之間的效能分數（Performance Score）差異",
  description="此柱狀圖顯示出版本 5 與版本 6 之間的效能分數（Performance Score）差異。最高有 4% 的網頁在分數上沒有任何改變，除此之外，分數下降的網站比分數改善的網站還多。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=786955541&format=interactive",
  sheets_gid="518150031",
  sql_file="lh6_vs_lh5_performance_score_02.sql"
  )
}}

由上表得知，有 4% 的網頁在效能分數（<span lang="en">Performance Score</span>）上沒有任何改變，但是分數變差的網頁比分數改善的網頁多。由下圖可以更直接的看到，效能分數（<span lang="en">Performance Score</span>）級距變得更差了（尤其是從百分比 10 至 25 的區間呈現下滑的曲線）：

{{ figure_markup(
  image="performance-lighthouse-score-distributions-yoy.png",
  caption="Lighthouse 5 及 6 的 Lighthouse 效能分數（Performance Score）分佈圖",
  description="在 Lighthouse 5 及 6 得到 0-100 效能分數（Performance Score）網站的散佈圖。隨著在 Lighthouse 6 的演算法改變，在百分比 0-25 的網站比率提高了，而 50-100 的比率減少了。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=926035471&format=interactive",
  sheets_gid="1303574513",
  sql_file="lh6_vs_lh5_performance_score_distribution.sql"
  )
}}

比較 <span lang="en">Lighthouse</span> 5 及 <span lang="en">Lighthouse</span> 6 之後，我們可以發現分數的分佈已經改變了。在 <span lang="en">Lighthouse</span> 6 演算法之下，我們可以觀察到在百分比 0 至 25 之間的頁面比率是上升的，而百分比 50 至 100 之間則在下降。而在 <span lang="en">Lighthouse</span> 5 時，可以看到有 3% 的頁面是得到 100 分的，在 <span lang="en">Lighthouse</span> 6 上，這個比率降低到只有 1%。

在針對演算法做了大量修改後，這樣子的變化是可預期的。

## <span lang="en">Core WebVitals</span>: <span lang="en">Largest Contentful Paint</span> {core-web-vitals-largest-contentful-paint}

<span lang="en">Largest Contentful Paint</span> (LCP) 是指標性的時間基準衡量標準，此項會回報最大的 <a hreflang="en" href="https://web.dev/articles/lcp#what-elements-are-considered"><span lang="en">above-the-fold element</span></a> 被 <span lang="en">render</span> 所需時間。（註：<span lang="en">above-the-fold element</span> 的意思是，一進到網頁時，不滑動所看到的畫面。<span lang="en">above-the-fold</span> 原意來自於一份未打開的報紙所看到的封面。）

### 根據不同裝置來分析 LCP

{{ figure_markup(
  image="performance-lcp-by-device.png",
  caption="根據不同裝置來分析的 LCP 效能綜合分析表",
  description="此柱狀圖顯示出有 53% 的桌機版網頁以及 43% 的手機版網頁被分類為 Good 體驗的網頁",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=696629857&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

在上表中，我們可以觀察到有 43% 至 53% 的網頁有好的 LCP 效能（低於 2.5 秒）：大多數網頁都會將重要資源根據優先度排序後，使得重要的多媒體能夠被快速的載入。對一個相對新的衡量標準來說，這是一個樂觀的訊號。在桌機及手機間些微的差距有可能是因為網路速度的不同、裝置性能以及圖片尺寸（尺寸較大或是針對桌機尺寸的圖片均須花較長時間下載並 render）所引起。

### 根據地理位置來分析 LCP

{{ figure_markup(
  image="performance-lcp-by-geo.png",
  caption="根據地理位置來分析的 LCP 效能分析表",
  description="此柱狀圖顯示出最高的 Good 百分比的 LCP 效能分佈在歐洲及亞洲國家之間。韓國以 76% 的 Good 數據位居第一，而印度以 16% 的數據排名最後。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1936626175&format=interactive",
  width="645",
  height="792",
  sheets_gid="263037691",
  sql_file="web_vitals_by_country.sql"
  )
}}

<span lang="en">Good</span> LCP 數值高於其他等級（<span lang="en">Needs Improvement</span> 及 <span lang="en">Poor</span>）的網站大多分布在歐洲及亞洲國家之間，其中由韓國（南韓）以 76% 的 <span lang="en">Good</span> 位居第一。南韓在手機速度這方面一直都是領導者，在今年十月 <a hreflang="en" href="https://www.speedtest.net/global-index">Speedtest Global Index</a> 的報告中更有著令人印象深刻的 145Mbps 下載速度的數據。日本、捷克、台灣、德國以及比利時也都是有著相當高速且穩定的手機網路速度的國家。澳洲雖然在手機網路速度保持領先順位，但整體來說卻受到桌機版緩慢的連線時間及網路延遲時間（latency）影響而排名下滑。

在我們的資料中，印度以僅有 16% 的好體驗持續呈現在最後一名。儘管在印度第一次接觸網際網路的人口數持續在成長，但手機及桌機網路速度<a hreflang="en" href="https://www.opensignal.com/reports/2020/04/india/mobile-network-experience">仍然是個問題</a>；4G 的平均下載速度是 10Mbps、3G 的平均下載速度是 3Mbps 而桌機則低於 50Mbps。

### 根據連線方式來分析的 LCP

{{ figure_markup(
  image="performance-lcp-by-connection-type.png",
  caption="以連線方式為單位的 LCP 效能分析表",
  description="此柱狀圖顯示出在 4G 有 48% 的網站呈現 Good 的 LCP。在 3G 時，被評為 Good 的網站比例驟減至 8%；2G 時剩下 1%，而慢速 2G 則是 0%。另外在離線狀態時為 18%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=97874305&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

因為 LCP 是用來計算最大的 <span lang="en">above-the-fold element</span> 被 <span lang="en">render</span> 時（包括圖像、影片或 <span lang="en">block</span> 層級包含文字的元素）的所需時間，因此無庸置疑地，網路速度越慢，LCP 的表現也越糟。

可以發現網路速度及好的 LCP 效能有明確的關聯，但即使是 4G 也只有 48% 的結果被歸類為 <span lang="en">Good</span>，其餘的一半仍有改進空間。自動化多媒體最佳化、提供正確的尺寸及格式還有為 Low Data Mode 做最佳化都能夠改善效能。詳情請看<a hreflang="en" href="https://web.dev/articles/optimize-lcp">LCP 改善指南</a>。

## <span lang="en">Core WebVitals</span>: <span lang="en">Cumulative Layout Shift</span> {core-web-vitals-cumulative-layout-shift}

<span lang="en">Cumulative Layout Shift</span> (CLS) 跟其他用秒或毫秒來衡量網頁可互動性的指標不同。它量化了在訪問網頁時，可視區域（<span lang="en">viewport</span>）中有多少元素移動了，藉此協助我們找出訪問網頁時未預期的元素移動並以此來衡量使用者體驗的好壞。

因此，相較於其他此章節提到的衡量標準，CLS 是一個不一樣且更完整的新型態 UX 衡量標準。

### 根據不同裝置來分析 CLS

{{ figure_markup(
  image="performance-cls-by-device.png",
  caption="根據不同裝置來分析的 CLS 效能分析表",
  description="此柱狀圖顯示出有超過半數的網站擁有 Good 的 CLS 數值，在桌機有 54%，而在手機則有 60%。在兩種情境下都只有 21% 的網站被評為 Poor 的 CLS。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1672696367&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

根據 CrUX 資料顯示，在桌機及手機裝置中有半數以上的網站得到 <span lang="en">Good</span> CLS 分數。被評為優質的桌機版網頁及手機版網頁之間有些微的差距（大約 6 個百分比），後者（手機版）較優。我們可以推測手機版佔有 <span lang="en">Good</span> CLS 比率，是因為有些手機版網站會透過較少功能及較少視覺化效果來做最佳化。

### 根據地理位置來分析 CLS

{{ figure_markup(
  image="performance-cls-by-geo.png",
  caption="根據地理位置來分析的 CLS 效能分析表",
  description="此柱狀圖顯示出前 28 名的國家至少有 50% 的網站呈現出 Good 的 CLS。而中階（Needs Improvement）數值的網站則在各國之間穩定地呈現 11-15%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1861585123&format=interactive",
  width="645",
  height="792",
  sheets_gid="47865955",
  sql_file="web_vitals_by_country.sql"
  )
}}

在不同地區的 CLS 效能原則上都表現的不錯，且至少有 56% 的網站得到 <span lang="en">Good</span> 的評比。對感知視覺穩定性來說，這是一個很棒的消息。此外，我們可以同樣觀察到排名較前面的國家與 LCP 排名較前面的國家相似，其中包括韓國、日本、捷克、德國以及波蘭。

相較其他的衡量標準（例如 LCP），視覺穩定性較少受到地理位置或是網路延遲時間的影響。排名最佳與最差的國家之間，<span lang="en">Good</span> 百分比的差距在 LCP 有 61% 之差，但在 CLS 僅有 13%。根據以上數據，評分中段的網頁相對地少，反倒是 <span lang="en">Poor</span> 的使用者佔了 19% 至 29%。造成 CLS 分數下降的因素有很多種，詳情請見 <a hreflang="en" href="https://web.dev/articles/optimize-cls"><span lang="en">Cumulative Layout Shift</span> 最佳化指南</a>。

### 根據連線方式來分析的 CLS

{{ figure_markup(
  image="performance-cls-by-connection-type.png",
  caption="以連線方式為單位的 CLS 效能分析表",
  description="此柱狀圖顯示出 Good、Need Improvement 及 Poor 呈現平均分佈的 CLS 測量結果。離線及 4G 則各以 70% 和 64% 的 Good 體驗領先其他連線方式。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=151288279&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

除了離線及 4G 之外，其餘連線方式都有著合理地平均分佈的 CLS 分數。在離線的情境下，我們可以推測網站是由 <span lang="en">Service Worker</span> 來提供服務。因此，在離線方式下並不會有任何的下載延遲，也就得到了較高的 <span lang="en">Good</span> 分數。

針對 4G 比較難下明確的結論，但我們可以推測大概是因為 4G+ 的連線方式都是由桌機裝置所連線。如果此假設為真，web fonts 及圖像皆可以被 <span lang="en">cache</span>，因此也正面地影響了 CLS 的測量結果。

## <span lang="en">Core WebVitals</span>: <span lang="en">First Input Delay</span> {core-web-vitals-first-input-delay}

<span lang="en">First Input Delay</span> (FID) 用於測量首次使用者互動到瀏覽器可以反應該互動的時間差，因此 FID 是適合顯示網頁互動性有多高的指標。

### 根據不同裝置來分析 FID

{{ figure_markup(
  image="performance-fid-by-device.png",
  caption="根據不同裝置來分析的 FID 效能分析表",
  description="此柱狀圖顯示出在兩種裝置上均有高比例的 Good 的 FID 效能；在桌機上有 100%，在手機上則是 80%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2090682651&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

相較其他評比，手機及桌機均以高百分比分佈在 <span lang="en">Good</span> 比較不常見。在桌機中，基於 75% 網頁分佈來說，有 100% 的網站得到相當快的 FID 時間差，這也意味著體驗到互動延遲的使用者極少。

在手機中，有 80% 的網站被評比為 <span lang="en">Good</span>。較合理的解釋可能是，相較於桌機，手機的 CPU 性能較低，而網路延遲（導致 <span lang="en">script</span> 下載及執行的延遲）、電池功率以及溫度限制都是消耗 CPU 的潛在因素。以上所述因素皆有可能影響像是 FID 這種類型的互動性衡量標準。

### 根據地理位置來分析 FID

{{ figure_markup(
  image="performance-fid-by-geo.png",
  caption="根據地理位置來分析的 FID 效能分析表",
  description="此柱狀圖顯示出每個國家皆有完美的 FID 效能。前 28 名的國家呈現出 79% 至 97% 如此近乎無 Poor 體驗的完美 Good FID 體驗數值。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1107653062&format=interactive",
  width="645",
  height="792",
  sheets_gid="2120295762",
  sql_file="web_vitals_by_country.sql"
  )
}}

FID 分數的地理分佈結果證實了上一段綜合裝置圖表的結果。最差還有 79% 網站得到 <span lang="en">Good</span> FID，而韓國則再次以驚人的 97% 在此項評比位居第一。有趣的是，在 CLS 及 LCP 的前幾名競爭者（如：捷克、波蘭、烏克蘭及俄羅斯）反倒在這裡跌至倒數的名次。

再次強調，我們可以推測出為何如此，但我們會需要更多的分析來佐證我們的推測是正確的。如果假設 FID 與 JavaScript 執行性能有關係，在手機性能越好則越貴或甚至被當成奢侈品的國家，反而會得到較低的 FID 排名。波蘭身為 <a hreflang="en" href="https://qz.com/1106603/where-the-iphone-x-is-cheapest-and-most-expensive-in-dollars-pounds-and-yuan/">iPhone 價格最貴</a>國家之一就是個好例子；再加上[平均薪資較低](https://en.wikipedia.org/wiki/List_of_European_countries_by_average_wage#Net_average_monthly_salary)，一份薪水可能還不夠買一隻 Apple 旗艦機。相反地，澳洲的<a hreflang="en" href="https://www.news.com.au/finance/average-australian-salary-how-much-you-have-to-earn-to-be-better-off-than-most/news-story/6fcdde092e87872b9957d2ab8eda1cbd">平均薪資</a>足以讓澳洲人以一週的薪水就能夠買一隻 iPhone。幸運地是，除少數 1-2% 的例外，低評分的網頁大部份趨近於 0，這也表示我們邁向相對快的互動網頁體驗。

### 根據連線方式來分析的 FID

{{ figure_markup(
  image="performance-fid-by-connection-type.png",
  caption="以連線方式為單位的 FID 效能分析表",
  description="此柱狀圖顯示出 Good FID 以高比例分佈在各個連線方式下。離線、3G 及 4G 則以高於 80% 的 Good 網站體驗領先其餘連線方式。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=808962538&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

從 2G 的 73% 到 4G 的 87%，我們可以觀察到網路速度與 FID 有直接關係。較快的網路可以較快地下載 <span lang="en">script</span>，也因此提早了開始 <span lang="en">parsing</span> 的時間以及減少了阻塞 <span lang="en">main thread</span> 的 <span lang="en">task</span>。這是一份很樂觀的結果報告，特別是評比不佳的網站比例不超過 5%。

## <span lang="en">First Contentful Paint</span> {first-contentful-paint}

<span lang="en">First Contentful Paint</span> (FCP) 用於測量瀏覽器第一次 <span lang="en">render</span> 任何文字、圖片、非白色 <span lang="en">canvas</span> 或是 SVG 內容。FCP 能夠顯現出「在網站載入時，使用者需要等待多久時間才能看到第一個內容被呈現」，因此是個適合測量使用者體感速度的指標。

### 根據不同裝置來分析 FCP

{{ figure_markup(
  image="performance-fcp-desktop-distribution.png",
  caption="以 Fast、Average 以及 Slow 分類的 FCP 效能的桌機版分佈圖",
  description="以 Fast、Average 以及 Slow 分類的 FCP 效能的桌機版分佈圖。Fast 以線性分佈，但中間稍微突起。相較於 2019 年，由於 FCP 分類方式的改變，今年更多 Fast 與 Slow 的 FCP 體驗。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1953305743&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

{{ figure_markup(
  image="performance-fcp-mobile-distribution.png",
  caption="以 Fast、Average 以及 Slow 分類的 FCP 效能的手機版分佈圖",
  description="以 Fast、Average 以及 Slow 分類的 FCP 效能的手機版分佈圖。Fast 仍然以線性分佈，但不像桌機版中間有個突起。相較於 2019 年，由於 FCP 分類方式的改變，今年更多 Fast 與 Slow 的 FCP 體驗。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=38297781&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

在上表中，FCP 分佈被拆成桌機及手機。[相較去年結果](../2019/performance#fcp-by-device)，可以發現到較少 FCP 指數呈現為 <span lang="en">Average</span>，反而可以觀察到無論是哪種裝置，<span lang="en">Fast</span> 及 <span lang="en">Slow</span> 的比率都升高了。此外，也可以發現手機使用者相較桌機使用者更頻繁的體驗較慢的 FCP 的情況仍然存在。整體來說，使用者們的體驗較為兩極，不是好就是差，很少有一般的體驗。

{{ figure_markup(
  image="performance-fcp-mobile-year-on-year.png",
  caption="2019 與 2020 年手機版網站 FCP 被標為 Good、Needs Improvement 以及 Poor 分佈相比",
  description="此柱狀圖顯示手機版網站 FCP 被標為 Good、Needs Improvement 以及 Poor 在 2019 至 2020 間已經改變了。在 2020 年，有 75% 的網站是低於標準的 FCP。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2037503700&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

對比前年同期手機裝置的 FCP 數值的話，我們可以觀察到好的體驗變少了，且中等及不佳的體驗增加了。75% 的網站的 FCP 值低於平均。我們可以推測如此高比例的 FCP 數值低於理想值，必定是造成使用者感到挫折或是使用者體驗下降的原因之一。

還有很多種因素可能造成繪製延遲，例如：<span lang="en">server</span> 延遲時間（以一些衡量標準來評估，例如：[<span lang="en">Time to First Byte</span> (TTFB)](#time-to-first-byte) 以及 RTT），阻擋 <span lang="en">JavaScript requests</span> 或是沒被適當處理的客製化字體等等。<!-- markdownlint-disable-line MD051 -->

### 根據地理位置來分析 FCP

{{ figure_markup(
  image="performance-fcp-by-geo.png",
  caption="根據地理位置來分析的 FCP 效能分析表",
  description="此柱狀圖顯示出在 28 個國家之中只有 7 個國家擁有超過 40% 的網站被評為 Good 的 FCP 效能。相較於 2019，由於 FCP 評分標準的改變，Good 以及 Poor 的比例都增加了。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=78259488&format=interactive",
  sheets_gid="1708427314",
  width="645",
  height="792",
  sql_file="web_vitals_by_country.sql"
  )
}}

在我們開始分析前，值得一提的是，2019 年效能章節的 <span lang="en">Good</span> 及 <span lang="en">Poor</span> 評估標準和 2020 年不同。在 2019 年的標準中，FCP 低於 1 秒的網站被分類為 <span lang="en">Good</span>，高於 3 秒的才會被分類為 <span lang="en">Poor</span>。而在 2020 年的標準中，評分標準變成低於 1.5 秒為 <span lang="en">Good</span>、高於 2.5 秒為 <span lang="en">Poor</span>。

相較於[去年的結果](../2019/performance#fcp-by-geography)，評估標準的變動帶來的影響是有更多的網站都被評為 <span lang="en">Good</span> 及 <span lang="en">Poor</span>。以地理位置分佈來說，前十名最快的網站的國家與 2019 相同，但捷克與比利時的排名變前面且美國與英國的名次下降了。韓國以幾近於去年兩倍的 62% 的超快 FCP 數值領先在第一名（可以猜測受惠於評估標準的改變）。前幾名的國家也幾乎都是去年的 <span lang="en">Good</span> 的兩倍。

當中等階段（<span lang="en">Needs Improvement</span>）的百分比變少，FCP 數值不佳的網頁也隨之增加，尤其是倒數幾名的拉丁美洲及南亞地區國家。

再次強調，有可能有多種因素造成 FCP 降低，例如不佳的 TTFB 數值，但我們很難在不確定前因後果的情況下來證明為什麼 FCP 降低。舉例來說，假設我們想要分析特定國家的效能，比方說澳洲，我們會意外地發現他的名次很後面。澳洲的智慧型手機普及率是世界排名最高之一，並且他們擁有最快的手機網路以及相對高的平均所得。我們可能會因此輕易地認為澳洲的排名應該要更前面。但是，當我們考慮到較慢的定點連線、網路延遲時間以及在 CrUX 中缺少 iOS 的數據等，就可以慢慢理解為什麼澳洲的名次可能會在如此後面。以這樣的例子來說（只談論到表面的問題），我們就可以了解要完整了解每個國家的情況來分析此數據有多困難了。

### 根據連線方式來分析的 FCP

{{ figure_markup(
  image="performance-fcp-by-connection-type.png",
  caption="以連線方式為單位的 FCP 效能分析表",
  description="此柱狀圖顯示出在 4G 時僅有 31% 的網站呈現 Good 的 FCP。離線時此數值減少至 10%；其餘的連線方式則幾近於只有 Poor 的 FCP 體驗。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1949864731&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

與其他衡量標準相同，FCP 同樣也受到連線速度影響。在 3G 網路下，只有 2% 的人感受到 <span lang="en">Good</span> 體驗，而在 4G 則有 31%。雖然這並不是最理想的 FCP 效能，但相較於去年有些地區[已經改善了](../2019/performance#fcp-by-effective-connection-type)，但需要再次強調的是這可能也是受到了 <span lang="en">Good</span> 及 <span lang="en">Poor</span> 的重新分類。我們同樣可以看到 <span lang="en">Good</span> 及 <span lang="en">Poor</span> 增加、中階（<span lang="en">Needs Improvement</span>）網頁減少的趨勢。

這個趨勢更進一步描繪出了數位差距，網路越慢且可能性能越差的裝置條件下的效能體驗越差。 改善慢速連線下的 FCP 與增強 TTFB 有直接關係，我們可以在 [Aggregate TTFB 根據連線方式來分析的 performance chart](#根據連線方式來分析的-ttfb) 觀察到 <span lang="en">Poor</span> TTFB = <span lang="en">Poor</span> FCP。

對 <a hreflang="en" href="https://ismyhostfastyet.com/">hosting provider</a> 或是 <a hreflang="en" href="https://www.cdnperf.com/">CDN</a> 的選擇對於速度也許會有加乘效果。選擇速度可能最快的服務會幫助改善 FCP 及 TTFB，在網路較慢的情況下更是如此。字體載入時間也深深影響了 FCP，所以<a hreflang="en" href="https://web.dev/font-display/">確保 Web Fonts 下載後是看得到的</a>也是值得一試的策略（特別是在較慢的網路通訊之下，下載這些資源都相當耗時）。

仔細觀察離線的數據後，我們可以歸類出 FCP 數值的問題與網路型態**無關**。我們並沒有在此圖表中觀察到數值隨著網路型態變化而有重大的增加；當然，如果我們假設此問題與網路型態有關，那我們必定會觀察到此數值隨之增加。可以發現 <span lang="en">rendering</span> 並沒有隨著下載 JavaScript 而延遲，反倒是受到 <span lang="en">parsing</span> 及 <span lang="en">execution</span> 的影響。

## <span lang="en">Time to First Byte</span> {time-to-first-byte}

<span lang="en">Time to First Byte</span> (TTFB) 是計算初始 HTML request 發出到第一個 <span lang="en">byte</span> 被返回到瀏覽器之間的時間。 迅速地處理 <span lang="en">requests</span> 很快的會影響到其他效能衡量標準，因為他們不只會延遲畫面繪製，還會延遲下載資源。

### 根據不同裝置來分析 TTFB

{{ figure_markup(
  image="performance-ttfb-by-device.png",
  caption="根據不同裝置來分析的 TTFB 效能分析表",
  description="此柱狀圖顯示出在桌機版中有 76% 的網站被評為 Poor 的 TTFB 而在手機版則是 83%。Good 的 TTFB 網站比例不超過 24%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1981576071&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

在桌機中，有 76% 的網站**沒**被評為 <span lang="en">Good</span> 的 TTFB；在手機上，這個百分比甚至上升到 83%。當這項指標假設大多效能評估與工作都專注於前端及視覺上的 <span lang="en">rendering</span> 而非資源傳輸或是 server-side 的工作，我們也許可以假設此數據描繪出 TTFB 往往是個被過度分析的衡量標準。高 TTFB 會直接對其他過多的效能有負面的影響，這仍然是個需要被改善的領域。

### 根據地理位置來分析 TTFB

{{ figure_markup(
  image="performance-ttfb-by-geo.png",
  caption="根據地理位置來分析的 TTFB 效能分析表",
  description="此柱狀圖顯示出 TTFB 的效能持續呈現低於標準的狀態，在 28 個國家之中僅有 4 個有超過 30% 的網站擁有 Good 的 TTFB 數值。當排名越低時，越可以發現被評為 Needs Improvement 的中階網站持續佔有超過 40%，而 Poor 體驗網站的比例也隨著名次下降而提升。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1135415956&format=interactive",
  width="645",
  height="792",
  sheets_gid="1440255644",
  sql_file="web_vitals_by_country.sql"
  )
}}

將今年的 TTFB 地理位置數據與 [2019 結果](../2019/performance#ttfb-by-geo)相比，可以注意到有更多較快的網頁了；但與 FCP 情況相似的是，TTFB 的衡量標準已經改變了。在去年，我們視 TTFB 低於 200ms 為快的，而高於 1000ms 為慢的；在 2020 年的衡量標準則變成低於 550ms 為 <span lang="en">Good</span> 而高於 1500ms 為 <span lang="en">Poor</span>。在如此重大改變之下，我們可以發現到圖表也跟著有了重大的改變；例如，在韓國 <span lang="en">Good</span> 網頁上升了 36% 或是台灣上升了 22%。總體來說，我們仍然可以觀察到相似的區域（例如亞太地區及特定歐洲地區）在這項數據保持領先。

### 根據連線方式來分析的 TTFB

{{ figure_markup(
  image="performance-ttfb-by-connection-type.png",
  caption="以連線方式為單位的 TTFB 效能分析表",
  description="此柱狀圖顯示出 TTFB 深受連線方式影響，在 4G 及離線狀態各擁有 21% 及 22% 的 Good 的體驗的網站。其餘連線方式（除了僅有 1% 的 3G）幾乎是沒有 Good 的 TTFB 數值。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=810992122&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

TTFB 會受到網路延遲時間及網路連線方式的影響。網路延遲時間越高且網路連線越慢就會得到越糟的 TTFB 測量結果，就如上圖所示。即使是在手機使用快速的 4G 網路，也只有 21% 的網頁得到快速的 TTFB。當網路連線低於 4G 時，可以說是幾近於沒有網站被歸類為快的。

看看<a hreflang="en" href="https://www.speedtest.net/insights/blog/content/images/2020/02/Ookla_Mobile-Speeds-Poster_2020.png">2018 年 12 月至 2019 年 11 月的全球手機網路速度</a>，我們可以發現全球的手機網路速度並不快。行動網路（例如 5G）的網路速度及科技標準沒有平均分佈，因此影響了 TTFB 的數據。舉例來說，<a hreflang="en" href="https://www.mobilecoveragemaps.com/map_ng#7/8.744/7.670">看看此奈及利亞的網路地圖</a> - 在奈及利亞大部分區域是被 2G 及 3G 所涵蓋，只有小部分範圍是 4G。

驚人的是離線與 4G 之間的 <span lang="en">Good</span> TTFB 結果相似度。在有 <span lang="en">service worker</span> 的情況下，我們可以預期他可以舒緩一些 TTFB 的問題，但此趨勢並沒有被反映在上表中。

## <span lang="en">Performance Observer</span> 的用途 {performance-observer-的用途}

能夠估算網站及應用程式的使用者體驗效能的衡量標準有百百種。但是，有時候那些既有的衡量標準並不一定符合我們的需求或是情境。[PerformanceObserver API](https://developer.mozilla.org/docs/Web/API/PerformanceObserver) 能夠讓我們取得透過 [User Timing API](https://developer.mozilla.org/docs/Web/API/User_Timing_API)、[Long Task API](https://developer.mozilla.org/docs/Web/API/Long_Tasks_API)、<a hreflang="en" href="https://wicg.github.io/event-timing/">Event Timing API</a> 或<a hreflang="en" href="https://web.dev/custom-metrics/">其他的低階 APIs</a> 所客製的衡量標準資料。舉例來說，有了這些 API 的幫助，我們可以紀錄頁面之間轉換的時間或是量化 <span lang="en">server-side-rendered (SSR) hydration</span> 時間。

{{ figure_markup(
  image="performance-performance-observer-usage.png",
  caption="根據不同裝置來分析的 Performance Observer 使用率",
  description="此柱狀圖顯示出採用 Performance Observer API 的比例很低，在桌機僅有 6.6% 而手機則有 7%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=632678090&format=interactive",
  sheets_gid="934401790",
  sql_file="performance_observer.sql"
  )
}}

上表指出，在我們調查的網站中，根據不同的裝置，大約有 6-7% 的網站使用 <span lang="en">Performance Observer</span>。這些網站可以透過上述的低階 API 來製作客製化的衡量標準，並利用 PerformanceObserver API 來整理搜集後，可以與其他的效能報告工具一起使用。這樣的採用率或許也道出多數使用者傾向使用既有的衡量標準（例如 <span lang="en">Lighthouse</span>）但對於如此方便的 API 也深感興趣。

## 總結

使用者體驗是一個基於**種種因素**所產生的光譜。為了不能忽視低於效能衡量標準或是無法體驗適當效能的人們，我們一定要設法了解並分析各個面向的數據。每個網頁訪問都述說著各自的故事。我們個人的以及國家層級的經濟狀況也敘述著我們能夠負擔的裝置型態以及網路提供者（<span lang="en">internet provider</span>）。我們生活的地方也深深影響著我們的網路延遲時間（澳洲人時常感受到這個痛苦），而且該國家的經濟也反應了當地行動網路覆蓋率。我們會訪問怎麼樣的網頁呢？我們為什麼想訪問那些網頁呢？了解 context 非常的重要，這不僅僅是為了要分析資料，也是為了能夠開發有足夠同理心、在乎是否容易被訪問且提供了快速的使用者體驗的網頁給所有的使用者。

以粗淺的分析來說，我們可以看到新 <span lang="en">Core WebVitals</span> 效能衡量標準有著樂觀的結果。**如果**我們不將 <span lang="en">Largest Contentful Paint</span> 的數據限縮到 <span lang="en">Poor</span> 體驗以及較慢的網路的話，至少在桌機及手機上，有一半的使用者體驗同時是好的。儘管新的衡量標準現在正有計劃在改善效能問題，但缺少對 FCP (<span lang="en">First Contentful Paint</span>) 以及 TTFB (<span lang="en">Time to First Byte</span>) 的改善方案仍然是個必須面對的嚴重問題。在這裡與 <span lang="en">Largest Contentful Paint</span> 相同網路型態 、快速網路連結以及桌機裝置的最不利。效能分數（<span lang="en">Performance Score</span>）也在速度方面呈現了下降的曲線（抑或是說，這比過去我們所測量過的數據更為準確）。

根據這些數據所知，可能因為我們養尊處優（中至高收入的國家、高薪水且持有新又性能好的裝置）無法時常體會各式各樣的情境（例如較慢的網路連接速度），我們更應該要花心力來為這各式各樣的情境去改善效能。這同時也替我們強調了，我們在加速初始瀏覽器繪製（LCP 及 FCP）和資源傳送（TTFB）都還有許多未完成的事情。這些效能問題時常聽起來像前端的問題，但其實許多重要的改善是可以透過適當的 <span lang="en">infrastructure</span> 選擇或是在後端做出適當的修改所達成。再次強調，使用者體驗是由各式各樣因素所組成的光譜，所以我們必須一視同仁。

新的衡量標準為我們帶來了不一樣的視野來分析使用者體驗，但我們也莫忘既有的問題與數據。為了那些體驗不良的使用者們，讓我們繼續努力，持續改進需要被加強的領域。快速且無障礙的網路是基本人權。
