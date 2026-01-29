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

WebAssembly (Wasm) is no longer just a "web" technology; it has evolved into a high-performance, universal bytecode format. Officially <a hreflang="en" href="https://www.w3.org/TR/2019/REC-wasm-core-1-20191205/">a W3C standard since 2019</a>, the ecosystem reached a major milestone with the release of <a hreflang="en" href="https://webassembly.github.io/spec/core/">Wasm Version 3.0 in December 2025</a>, marking significant growth in both browser-based and standalone environments.

WebAssembly has evolved from a web-centric optimization tool into a high-performance, universal bytecode format. Officially <a hreflang="en" href="https://www.w3.org/TR/2019/REC-wasm-core-1-20191205/">a W3C standard since 2019</a>, the ecosystem reached a technical turning point with the release of <a hreflang="en" href="https://webassembly.github.io/spec/core/">Wasm Version 3.0 in December 2025</a>. This version standardizes several <a hreflang="en" href="https://webassembly.github.io/spec/core/">advanced features</a> — such as Garbage Collection, 64-bit address space, and Multiple Memories — allowing high-level languages like Java, Kotlin, and Dart to run natively and efficiently in both browser and standalone environments.


## Methodology

We follow the same methodology from [the 2021 Web Almanac](../2021/webassembly#methodology), where WebAssembly was introduced for the first time.

**Data Collection:** This chapter relies on this dataset provided by HTTP Archive Juli 2025 crawl data which is hosted on Google BigQuery. to identify WebAssembly modules by matching the `Content-Type` (`application/wasm`) and the `.wasm` file extension. Using this method, we identified 233,857 Wasm modules on desktop and 255,060 on mobile.

**Analysis:** In addition to the HTTP Archive dataset, we use the <a hreflang="en" href="#">almanac-wasm</a> tool to download and validate the WebAssembly modules identified from the HTTP Archive for local analysis. This tool extracts metadata from these downloaded files, allowing us to identify programming languages, libraries, and specific features used within the Wasm modules.

**Limitations:** Our tool `àlmanac-wasm` focuses on static analysis of Wasm modules and does not execute them. Therefore, we cannot capture dynamic behaviors or runtime features that may be present during actual execution in a browser or standalone environment. Additionally, some Wasm modules may be obfuscated or minified, which can limit our ability to accurately identify their characteristics. 


## WebAssembly usage

{{ figure_markup(
  caption="Desktop sites using WebAssembly.",
  content="0.35%",
  classes="big-number",
  sheets_gid="540023407",
  sql_file="counts.sql"
  )
}}

Our analysis shows while WebAssembly's adoption in 2021 0.04% was, we find that in 2025, it has grown to 0.35% on desktop and 0.28% on mobile, representing approximately 43,000 sites for each platform within our dataset. 

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
  caption="Adoption of WebAssembly by site rank",
  description="Bar chart showing distribution of page ranking groups from 1000, 10,000, 100000, 1000000, 10000000 and all on client requests for desktop and mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1476075550&format=interactive",
  sql_file="ranking.sql",
  sheets_gid="540023407"
  )
}}

We see a strong correlation between site popularity and WebAssembly adoption. Usage is most concentrated among the top 1,000 websites, reaching 2% on desktop and 1.27% on mobile. These top-tier sites frequently host complex applications—such as design tools or heavy media editors—that require the high performance Wasm provides.

Adoption rates decrease as site rank declines, following a consistent distribution pattern. For sites outside the top 10 million, adoption is approximately 0.33% for desktop and 0.28% for mobile. While desktop usage remains higher in the top ranking groups, the gap narrows significantly in the long tail, suggesting that for the majority of the web, WebAssembly is deployed as a cross-platform resource rather than being restricted to specific environments.


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

We observed that the MIME type `application/wasm` is used in 293,470 requests on desktop clients and 301,127 requests on mobile clients.

Some requests lacked a `Content-Type` header, and some had incorrect MIME types, such as `text/html` or `text/plain`. These account for 3.2% and 2.4% of requests, respectively. Compared to 2021, these percentages have dropped significantly, indicating increased awareness in setting the correct MIME type for Wasm applications.


### Module size

The smallest WebAssembly modules are likely used for specific functions, such as "Micro-Utility" like _Base64 Encoder/Decoder_ or a _CRC32 Checksum_ utility—These are typically used for performance-critical calculations or polyfills where JavaScript might be too slow or lack the specific precision needed.

Larger modules are probably full applications compiled to WebAssembly. These are massive modules where an entire desktop-grade codebase (often millions of lines of C++ or Rust) is compiled to run in the browser. For example, Adobe Photoshop Web, AutoCAD, and Google Earth. Large modules  handle complex image rendering, layer management, and 3D engine calculations directly on the client side browser.

Small modules of WebAssembly often found using AssemblyScript or Rust and Large modules of WebAssembly often found using languages like C++ or C# (.net). You can get more details on the Wasm Language Usage section.

{{ figure_markup(
  image="raw-response-sizes.png",
  caption="Raw response sizes.",
  description="Bar chart showing the distribution of WebAssembly (Wasm) raw response sizes across desktop and mobile platforms, measured in kilobytes across various percentiles. At the lower and median percentiles, the file sizes are identical and extremely small, starting at just 2 KB at the 10th percentile and reaching 14 KB at the 50th percentile for both platforms. However, a significant divergence occurs at the 90th percentile, where desktop response sizes reach 381 KB compared to 316 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=658325543&format=interactive",
  sql_file="module_sizes.sql",
  sheets_gid="241152503"
  )
}}

{{ figure_markup(
  image="uncompressed-response-sizes.png",
  caption="Uncompressed response sizes.",
  description="Bar chart showing the uncompressed response sizes for WebAssembly (Wasm) modules, showing a significant divergence between platforms at higher percentiles. While modules at the 10th, 25th, and 50th percentiles remain small and nearly identical across devices—ranging from 5 KB to 31 KB—the gap widens considerably for the largest files. At the 90th percentile, desktop modules reach 897 KB compared to 756 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1570587851&format=interactive",
  sql_file="module_sizes.sql",
  sheets_gid="241152503"
  )
}}

These WebAssembly modules differ considerably in size, with the smallest being just a few kilobytes, and the largest one is 228.102 MB in desktop's client and 166.415 MB for mobile client.

{{ figure_markup(
  caption="Largest WebAssembly file detected.",
  content="228 MB",
  classes="big-number",
  sheets_gid="241152503",
  sql_file="module_sizes.sql"
  )
}}

## WebAssembly libraries

Our crawl identified a modest number of modules, it is possible to analyze and learn about the most popular libraries in requests for Wasm.

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

Let's look a bit more into the top three libraries:

- **System (43.1%)** is used for fundamental "glue" code and It often includes "system-level" bindings (like those from WASI or Emscripten) that allow a Wasm module to communicate with the host environment (the browser) to handle tasks like memory management or basic I/O. system utilities.

- **Microsoft (23.2%)** represents the massive footprint of the Microsoft ecosystem on the web, primarily driven by Blazor WebAssembly. Blazor allows developers to build interactive web UIs using C# and .NET instead of JavaScript. The high percentage reflects many enterprise and business applications that have been ported to the web using Microsoft's specialized Wasm runtime for the .NET framework.

- **RXEngine (6.2%)** is a more specialized entry, often associated with high-performance execution engines used for specific industries like gaming or advanced data processing. While more niche than the top two, its 6.2% share indicates it is a popular choice for developers who need a pre-built, optimized engine to handle computationally intensive tasks (such as real-time analytics or complex UI interactions) without building the entire infrastructure from scratch.

## WebAssembly languages

WebAssembly can use various languages and using toolchains It can be compiled in binary format to server browser and desktop applications. It can carry much of the information in the source (programming language, application structure, variable names).

Each WebAssembly has import and or export components, Most WebAssembly toolchains create a small amount of JavaScript code, for the purposes of 'binding', making it easier to integrate components into JavaScript applications. These bindings often have recognisable function names which are present in the components exports or imports, giving a reliable mechanism for identifying the language that was used to author the component.

If Wasm has not used obfuscation and or other techniques that are stripped down while building deliverable then we can use the rust libraries and WebAssembly Binary Toolkit (WABT) to understand the source programming language.

We enhanced the wasm-stats project and created tool <a hreflang="en" href="https://github.com/nimeshvk/almanac-wasm">`almanac-wasm`</a> that helps to download wasm file from the 3rd party server with preferred request parameters for example user-agent, compression method etc, validates the downloaded Wasm file and with rust library and WABT (Wasm2wat), It  finds the author's language and populates wasm statistics along with language.

For example, [wasm-bindgen](https://crates.io/crates/wasm-bindgen) is a suite of tools that helps to generate high level code Rust-compiled WebAssembly (Wasm) component and JavaScript with name as "wbindgen" so If We import the component from WebAssembly and find "wbindgen" then there is  clearly indication that component in WebAssembly was written in Rust language.

Like wise, We have researched and found various language indicators inside WebAssembly's different components with the tool.

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

We have found the .Net / Mono eco system based languages (including Blazor) reserves the first position for the language used in WebAssembly for desktop clients with 40.5% and for mobile clients with 39.8%

However 41.1% clients in desktop and 41.6% clients in mobile have language "Unknown" that means We could not find the author's (source) language because of missing language indicators or WebAssembly is stripped with the obfuscation or other techniques; These techniques are used to reduce the size, enable privacy/security features or to optimize the performance of the WebAssembly by the modern compilers.

## WebAssembly features

The initial release of WebAssembly was considered an Minimal Viable Product (MVP). In common with other web standards, it is continually evolving under the governance of the World Wide Web Consortium (W3C). This year saw the announcement of the WebAssembly version 2.0, adding a number of new features. The version 3.0 shows the true vision and its potential for WebAssembly. You can explore the various additional features on <a hreflang="en" href="https://webassembly.org/features/">features page</a>.

<a hreflang="en" href="https://v8.dev/features/simd">Single Instruction, Multiple Data (SIMD)</a> instructions are a special class of instructions that exploit data parallelism in applications by simultaneously performing the same operation on multiple data elements. Compute intensive applications like audio/video codecs, image processors, are all examples of applications that take advantage of SIMD instructions to accelerate performance. Most modern architectures support some variants of SIMD instructions.

{{ figure_markup(
  image="extensions-usage.png",
  caption="Post-MVP extensions usage.",
  description="Bar chart showing total module counts along with numbers of modules using various post-MVP extensions. Total numbers, as mentioned in the beginning of the article, are at 233,857 and 255,060 on desktop and mobile respectively. Sign extension ops stand out and were found in a large number of those—45,969 on desktop clients and 50,394 on mobile. The bulk memory is 187,674 on desktop and 204,103 on mobile. The rest are so much lower that they barely register on the graph.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1868040845&format=interactive",
  sql_file="proposals.sql",
  sheets_gid="111956915"
  )
}}

SIMD is a new feature and isn't yet available in all browsers with WebAssembly support. In the year 2021, We had found SIMD extension usage in 20 Wasm modules on desktop and 21 Wasm modules on mobile clients, This feature usage is now increased with 2265 Wasm modules on desktop and 2,470 on mobile clients.

Other exciting features include <a hrefleng="en" href="https://github.com/WebAssembly/sign-extension-ops/tree/master">Sign-extension-ops</a> and <a hreflang="en" href="https://github.com/WebAssembly/nontrapping-float-to-int-conversions">Non-Trapping float to int</a>.

With respect to the total extension usage in year 2021, It is observed that total extension usage in 2025 drastically ~61 times more on desktop clients and ~80 times more on mobile based clients. To make the usage of very complex tasks, the WebAssembly, We have marked the Bulk Memory stats are increased  to 8936 times higher on desktop and 25,512 times higher on mobile clients with respect to year 2021 stats.

## Conclusions

There is a significant increase in the number of webpages using this technology for serverless, containerization, machine learning components and plug-n-play types of applications. The future of WebAssembly could be as a niche web technology, but as an entirely mainstream runtime on a wide range of other platforms. WebAssembly runtime (multi-language, lightweight, secure) are making it a popular choice for a wider range of non-browser applications for agnostic platforms.

Despite being a niche technology, WebAssembly is already adding value to the web. There are a number of web applications that benefit greatly from this technology. However, web applications are often not visible to the 'crawl' which forms the basis of this study.
