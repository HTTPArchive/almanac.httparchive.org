---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: WebAssembly chapter of the 2025 Web Almanac covering usage, languages, and post-MVP features.
hero_alt: Hero image of Web Almanac characters performing scientific experiments on various code symbols resulting in 1s and 0s coming out the other end.
authors: [nimeshgit]
reviewers: [nrllh, tunetheweb]
analysts: [nimeshgit]
editors: [tunetheweb]
translators: []
nimeshgit_bio: Nimesh provides digital transformation and automation solutions, with a focus on AI and ML analytics, operations, and business processes.
results: https://docs.google.com/spreadsheets/d/16z2MNwq8FFbuNYcJJZceML6rB5VAmBXNNHZy5FZuf8g/edit
featured_quote: WebAssembly is no longer just a "web" technology; it has evolved into a high-performance, universal bytecode format.
featured_stat_1: 0.35%
featured_stat_label_1: Desktop sites using WebAssembly.
featured_stat_2: 228 MB
featured_stat_label_2: Largest WebAssembly file detected.
featured_stat_3: 2.05%
featured_stat_label_3: Desktop sites in top 1,000 using WebAssembly
doi: 10.5281/zenodo.18258991
---

## Introduction

WebAssembly (Wasm) has evolved from a web-centric optimization tool into a high-performance, universal bytecode format. Officially <a hreflang="en" href="https://www.w3.org/TR/2019/REC-wasm-core-1-20191205/">a W3C standard since 2019</a>, the ecosystem reached a technical turning point with the release of <a hreflang="en" href="https://webassembly.github.io/spec/core/">Wasm Version 3.0 in December 2025</a>. This version standardizes several <a hreflang="en" href="https://webassembly.github.io/spec/core/">advanced features</a> — such as Garbage Collection, 64-bit address space, and Multiple Memories — allowing high-level languages like Java, Kotlin, and Dart to run natively and efficiently in both browser and standalone environments.


## Methodology

We follow the same methodology from [the 2021 Web Almanac](../2021/webassembly#methodology), where WebAssembly was introduced for the first time.

**Data Collection:** This chapter relies on this dataset provided by HTTP Archive Juli 2025 crawl data which is hosted on Google BigQuery. to identify WebAssembly modules by matching the `Content-Type` (`application/wasm`) and the `.wasm` file extension. Using this method, we identified 233,857 Wasm modules on desktop and 255,060 on mobile.

**Analysis:** In addition to the HTTP Archive dataset, we use <a hreflang="en" href="#/">almanac-wasm</a> a tool to download and validate the WebAssembly modules identified from the HTTP Archive for local analysis. This tool extracts metadata from these downloaded files, allowing us to identify programming languages, libraries, and specific features used within the Wasm modules.


**Limitations:** Our tool `almanac-wasm` focuses on static analysis of Wasm modules and does not execute them. Therefore, we cannot capture dynamic behaviors or runtime features that may be present during actual execution in a browser or standalone environment. Additionally, some Wasm modules may be obfuscated or minified, which can limit our ability to accurately identify their characteristics.


## WebAssembly usage

{{ figure_markup(
  caption="Desktop sites using WebAssembly.",
  content="0.35%",
  classes="big-number",
  sheets_gid="540023407",
  sql_file="counts.sql"
  )
}}

Our analysis shows while WebAssembly's [adoption in 2021 was 0.04%](../2021/webassembly#how-many-modules), in 2025 it has grown to 0.35% on desktop and 0.28% on mobile, representing approximately 43,000 sites for each platform within our dataset.

### Year-on-year trend

{{ figure_markup(
  image="usage-trends.png",
  caption="WebAssembly usage trend",
  description="Bar chart showing WebAssembly usage after several years of rapid growth. Between 2024 and 2025, the percentage of desktop sites using WebAssembly saw a slight decrease from 0.36% to 0.35%, while mobile usage remained flat at 0.28%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=729417371&format=interactive",
  sql_file="counts.sql",
  sheets_gid="540023407"
  )
}}

We find that WebAssembly adoption has grown from 0.04% in 2021, although rates have remained consistent over the last two years. In 2025, we found WebAssembly modules on 0.35% of desktop sites and 0.28% of mobile sites, representing approximately 43,000 sites. Furthermore, mobile adoption was lower than desktop adoption in all observed years, averaging a 30% difference.

### WebAssembly by rank

{{ figure_markup(
  image="webassembly-by-rank.png",
  caption="WebAssembly usage site rank",
  description="Bar chart showing distribution of page ranking groups from 1000, 10,000, 100000, 1000000, 10000000 and all on client requests for desktop and mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1476075550&format=interactive",
  sql_file="ranking.sql",
  sheets_gid="540023407"
  )
}}

We see a strong correlation between site popularity and WebAssembly adoption. Usage is most concentrated among the top 1,000 websites, reaching 2% on desktop and 1.27% on mobile. These top-tier sites frequently host complex applications—such as design tools or heavy media editors—that require the high performance Wasm provides.

Adoption rates decrease as site rank declines, following a consistent distribution pattern. For sites outside the top 10 million, adoption is approximately 0.33% for desktop and 0.28% for mobile.

While desktop usage remains higher in the top ranking groups, the gap narrows significantly in the long tail, suggesting that for the majority of the web, WebAssembly is deployed as a cross-platform resource rather than being restricted to specific environments.


## WebAssembly requests

{{ figure_markup(
  image="number-of-wasm-requests.png",
  caption="Number of Wasm requests",
  description="Bar chart showing total Wasm, unique Wasm files and unique response by modules with both clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=74534440&format=interactive",
  sql_file="counts.sql",
  sheets_gid="540023407"
  )
}}


Overall, we recorded 303,496 WebAssembly requests on desktop and 308,971 on mobile. Although more desktop sites utilize WebAssembly, the total volume of requests is slightly higher on mobile.

Furthermore, we identified 157,967 unique URLs on desktop and 165,870 on mobile. To estimate the number of unique binaries, we grouped modules by identical filename and response size. Using this method, we found 87,596 unique Wasm modules on desktop and 84,851 on mobile. These findings indicate that approximately 72% of WebAssembly requests serve duplicate modules, highlighting substantial reuse of libraries across the web.


### MIME type

{{ figure_markup(
  image="top-mime-types.png",
  caption="Top MIME types",
  description="Bar chart showing MimeTypes and Percentage of Wasm request with both clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1325615855&format=interactive",
  sql_file="mime_types.sql",
  sheets_gid="1706394885",
  width="600",
  height="430"
  )
}}

The `application/wasm` MIME type was identified in 293,470 desktop and 301,127 mobile requests. Instances of missing or incorrect MIME types (such as `text/html` or `text/plain`) were low, affecting 3.2% of desktop and 2.4% of mobile requests. These represent a significant decline compared to 2021, indicating improved awareness and adherence to proper server configuration.


### Module size


{{ figure_markup(
  image="raw-response-sizes.png",
  caption="Raw response sizes.",
  description="Bar chart showing the distribution of WebAssembly (Wasm) raw response sizes across desktop and mobile platforms, measured in kilobytes across various percentiles. At the lower and median percentiles, the file sizes are identical and extremely small, starting at just 2 KB at the 10th percentile and reaching 14 KB at the 50th percentile for both platforms. However, a significant divergence occurs at the 90th percentile, where desktop response sizes reach 381 KB compared to 316 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=658325543&format=interactive",
  sql_file="module_sizes.sql",
  sheets_gid="241152503"
  )
}}


WebAssembly module sizes vary drastically based on their specific use cases. We observed that the bottom 50% of modules are quite small, ranging between 2 KB and 14 KB. These are typically "micro-utilities" like Base64 encoders or checksum calculators, often written in AssemblyScript or Rust to handle performance-critical tasks where JavaScript lacks precision.

Conversely, at the 90th percentile, sizes increase significantly to 381 KB on desktop and 316 KB on mobile. These larger binaries usually represent full desktop-grade applications ported to the web—such as Adobe Photoshop or Google Earth—compiled from heavier languages like C++ or C# to handle complex 3D rendering and logic.

{{ figure_markup(
  image="uncompressed-response-sizes.png",
  caption="Uncompressed response sizes.",
  description="Bar chart showing the uncompressed response sizes for WebAssembly (Wasm) modules, showing a significant divergence between platforms at higher percentiles. While modules at the 10th, 25th, and 50th percentiles remain small and nearly identical across devices—ranging from 5 KB to 31 KB—the gap widens considerably for the largest files. At the 90th percentile, desktop modules reach 897 KB compared to 756 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1570587851&format=interactive",
  sql_file="module_sizes.sql",
  sheets_gid="241152503"
  )
}}

When examining uncompressed sizes, we observe that while the median module remains lightweight at approximately 30 KB on both platforms, the largest binaries at the 90th percentile are significantly heavier on desktop (897 KB) than on mobile (756 KB).


{{ figure_markup(
  caption="Largest WebAssembly file detected.",
  content="228 MB",
  classes="big-number",
  sheets_gid="241152503",
  sql_file="module_sizes.sql"
  )
}}

Beyond these standard distributions, the dataset contains significant outliers. The largest single WebAssembly module identified measured 228 MB on desktop and 166 MB on mobile, indicating the deployment of large-scale client-side applications.

## WebAssembly libraries

Next, we analyze the import names within WebAssembly binaries to understand the most popular underlying libraries and frameworks in the ecosystem.

{{ figure_markup(
  image="popular-webAssembly-libraries.png",
  caption="Popular WebAssembly libraries.",
  description="Bar chart showing popular libraries in desktop and mobile datasets, merged into one graph. Each library is shown along with the percentage of Wasm requests that could be attributed to it.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1063093178&format=interactive",
  sql_file="popular_library_by_name.sql",
  sheets_gid="1181339291",
  width="600",
  height="596"
  )
}}


We find that System (43%), Microsoft (23%), RXEngine (6%), and Dotnet (6%) are the most popular libraries or frameworks used in WebAssembly modules, indicating Microsoft's dominance within this ecosystem, driven specifically by the Dotnet and Blazor frameworks.

## WebAssembly languages


WebAssembly can be developed using various languages, including C++, C#, and Ruby. With the introduction of Wasm 3.0, the range of supported languages has extended to include examples such as Java, Scala, Kotlin, and Dart. In this section, we provide an overview of the languages used to develop WebAssembly modules.


{{ figure_markup(
  image="language-usage.png",
  caption="WebAssembly language usage.",
  description="Unknow (41.1% on desktop and 41.6% on mobile),.Net Mono based language (39.8% and 40.5%), LikelyEmscripten (6.9% and 6.1%), Scala (3.91% and 3.9%), Blazor (4.5% and 3.3%), Rust (1.5% and 2.4%), Rust (1.48% and 2.41%), AssemblyScript (1.27% and 1.3%), Emscripten (0.87% and 0.78%), Go/TinyGo (0.09 and 0.08%) and TeaVM based language (0.04% and 0.1%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1492105065&format=interactive",
  sql_file="language_usage.sql",
  sheets_gid="101432539",
  width="600",
  height="422"
  )
}}

Our tool successfully identified the source languages for 51% of WebAssembly modules. The remaining 41% could not be identified, primarily due to minification or the stripping of metadata.

Among the identified languages, .NET/Mono is the most common, holding a 41% share. Although minified export/import names often obscure the source language, the Emscripten (C++) toolchain uses a distinctive naming convention. This allows us to attribute these modules with confidence, finding that Emscripten accounts for 8% of usage, followed by Scala at 4%.

Together with our findings on library usage, these results underscore the significant dominance of the Microsoft ecosystem within the WebAssembly landscape.


## WebAssembly features

In this section, we analyze the usage of post-MVP (Minimum Viable Product) WebAssembly features. While we acknowledge that the features discussed here are limited and do not cover all the features WebAssembly <a hreflang="en" href="https://webassembly.org/features/">supports</a>, we believe highlighting the adoption of these features remains important. We encourage readers to contribute to the analysis tool used in this chapter to help track further features in the future.


{{ figure_markup(
  image="extensions-usage.png",
  caption="Post-MVP extensions usage.",
  description="Bar chart showing total module counts along with numbers of modules using various post-MVP extensions. Total numbers, as mentioned in the beginning of the article, are at 233,857 and 255,060 on desktop and mobile respectively. Sign extension ops stand out and were found in a large number of those—45,969 on desktop clients and 50,394 on mobile. The bulk memory is 187,674 on desktop and 204,103 on mobile. The rest are so much lower that they barely register on the graph.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1868040845&format=interactive",
  sql_file="proposals.sql",
  sheets_gid="111956915"
  )
}}

We find that Bulk Memory is the most widely adopted feature, appearing in 187,674 desktop and 204,103 mobile modules. This feature improves performance by allowing efficient copying and initialization of large memory blocks, mirroring the efficiency of the native memcpy function in C. Furthermore, Sign Extension—which provides operators for extending integer values (such as extending an 8-bit integer to 32-bit)—is the second most popular feature, found in 45,969 desktop and 50,394 mobile modules.

## Conclusions

WebAssembly adoption has significantly increased over the last four years, rising from 0.04% in 2021 to 0.35% in 2025, though growth has stabilized in the last two years. Usage is most prevalent on high-ranking websites and decreases significantly among less popular pages. We find that WebAssembly is currently deployed for two distinct purposes: handling specific utility functions (such as encryption or checksums) and powering full standalone applications. Furthermore, our findings highlight the widespread adoption of Microsoft’s frameworks, indicating their significant role in driving the current WebAssembly ecosystem.

Considering the significant developments in Wasm specifications and increased interest from the community, we believe the adoption of WebAssembly will further increase in the future.
