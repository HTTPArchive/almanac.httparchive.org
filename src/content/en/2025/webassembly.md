---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: WebAssembly chapter of the 2025 Web Almanac covering usage, languages, and post-MVP features.
hero_alt: Hero image of Web Almanac characters performing scientific experiments on various code symbols resulting in 1's and 0's coming out the other end.
authors: [nrllh, nimeshgit]
reviewers: [tunetheweb]
analysts: [nimeshgit]
editors: [cjihrig]
translators: []
nrllh_bio: Nurullah Demir is a cyber security researcher and PhD student at <a hreflang="en" href="https://www.internet-sicherheit.de/en/">Institute for Internet Security</a> and <a hreflang="en" href="https://intellisec.de">Intelligent System Security, KASTEL Security Research Labs</a>. His research focuses on web security & privacy, and web measurements.
nimeshgit_bio: Nimesh is a digital transformation (automation) solutions in context with AI / ML Analytics , Ops and Business Processes.
results: https://docs.google.com/spreadsheets/d/16z2MNwq8FFbuNYcJJZceML6rB5VAmBXNNHZy5FZuf8g/edit
featured_quote: WebAssembly is no longer just a "web" technology; it has evolved into a high-performance, universal bytecode format.
featured_stat_1: 0.35%
featured_stat_label_1: Desktop sites using WebAssembly.
featured_stat_2: 228 MB
featured_stat_label_2: Largest WebAssembly file detected.
featured_stat_3: 2.05%
featured_stat_label_3: Desktop sites in top 1,000 using WebAssembly
---

## Introduction

WebAssembly is no longer just a "web" technology; it has evolved into a high-performance, universal bytecode format. Officially <a hreflang="en" href="https://www.w3.org/TR/2019/REC-wasm-core-1-20191205/">a W3C standard since 2019</a>, the ecosystem reached a major milestone with the release of <a hreflang="en" href="https://webassembly.github.io/spec/core/">Wasm Version 3.0 in December 2025</a>, marking significant growth in both browser-based and standalone environments.

### The Mission

To provide a secure-by-default foundation for running code across any infrastructure—from cloud and edge computing to blockchain and IoT devices. Supported by industry leaders like Google, Microsoft, Fastly, and Intel, Wasm is redefining software portability.

### The Ecosystem at a Glance

WebAssembly is managed largely by the Bytecode Alliance and CNCF, the ecosystem consists of:

- **Runtimes**: High-performance engines like _Wasmtime_ (server-side) and _WasmEdge_ (cloud-native/edge), alongside native integration in all major browsers.
- **WASI (WebAssembly System Interface)**: A standardized API (akin to POSIX) that allows modules to securely interact with filesystems and networks.
- **Component Model**: An emerging standard enabling different languages to interoperate within a single modular application.
- **Toolchains**: Mature compilers like _Emscripten_ and cargo-component that bridge high-level source code to Wasm bytecode.

In essence, Wasm is moving beyond the browser to provide a secure, high-performance, and portable universal runtime for modern computing.

## Methodology

We follow [the same methodology from the 2021 Web Almanac](../2021/webassembly#methodology), which is the first edition that included WebAssembly. WebAssembly is compiled into bytecode and distributed as binary format. The findings here infer the source language used in the modules. The accuracy of that analysis is covered in more detail in the respective sections.

### Limitations

- **Data Acquisition & Retrieval** Our analysis relies on the almanac-wasm tool to fetch WASM binaries using parameters from the initial HTTP Archive crawl. However, retrieval depends on third-party server availability; 404/403 errors or resource updates since the initial crawl may occur. We assume the retrieved file is identical to the one present during the original recording.

- **Source Language Identification** To identify source languages, we utilize the WebAssembly Binary Toolkit (`wasm2wat`) and Rust-based parsers to analyze imports, exports, and custom sections for compiler metadata and language fingerprints.

  - **Limitations**: This is not a definitive approach. "Stripped" binaries (using tools like *wasm-strip*) or obfuscated code remove the debug info and metadata required for identification.
  - **Example**: Compilers like TinyGo generate unique structures and WASI imports that often diverge from standard *go_exec.js* patterns, resulting in these binaries being classified as "Unknown".

### Feature Detection Constraints

- **No Runtime Check:** WebAssembly lacks a built-in instruction for modules to detect host features from within the sandbox; detection is handled by the host environment (e.g., JavaScript or Wasmtime).
- **Compile-time Dependency:** Advanced features like SIMD or Threads are enabled via compiler flags. If the host environment does not support these specific features at instantiation, the binary will fail to load.

## WebAssembly usage

{{ figure_markup(
  caption="Desktop sites using WebAssembly.",
  content="0.35%",
  classes="big-number",
  sheets_gid="540023407",
  sql_file="counts.sql"
  )
}}

We see that 0.35% of desktop sites and 0.28% of mobile sites are using WebAssembly. This is approximately 43,000 sites in our dataset for both, but with a larger dataset for mobile the relative percentage is lower.

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

Interestingly, looking over previous Web Almanac years, WebAssembly requests have increased drastically from ~0.05% in 2021 to 0.28%/0.35% this year. There was also a slight dip from 2024.

### WebAssembly by rank

{{ figure_markup(
  image="webassembly-by-rank.png",
  caption="Page Ranking (Group) for Web Assembly 2025",
  description="Bar chart showing distribution of page ranking groups from 1000, 10,000, 100000, 1000000, 10000000 and all on client requests for desktop and mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1476075550&format=interactive",
  sql_file="ranking.sql",
  sheets_gid="540023407"
  )
}}

We see a clear "Power Law" in WebAssembly adoption: more popular sites are more likely it is to use Wasm.

Key Insights from the Page Ranking Data:

- **Top-Tier Dominance**: Wasm is most prevalent among the top 1,000 sites mobile. These are typically "heavy" applications like Figma, Adobe, or Google Meet that require high performance for complex tasks.

- **The "Long Tail" Effect**: While the percentage of adoption drops significantly as you move down there ranks, there is still usage across all ranks.

- **Platform Parity**: There is a very close correlation between desktop and mobile usage across all ranking groups. This confirms that Wasm is being used as a cross-platform solution rather than being restricted to desktop-only environments.

High-ranking sites are more likely to be complex web apps that need Wasm for performance, while lower-ranking sites (like simple blogs or small business pages) have not yet found a massive need for it—though they often use it "silently" via third-party libraries.

## WebAssembly requests

{{ figure_markup(
  image="number-of-wasm-requests.png",
  caption="Number of WASM requests",
  description="Bar chart showing total WASM, unique WASM files and unique response by modules with both clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=74534440&format=interactive",
  sql_file="counts.sql",
  sheets_gid="540023407"
  )
}}

There are over 300,000 wasm requests in our dataset, which come down to 32,197 unique wasm file requests on desktop and 29,997 on mobile. The large number of requests shows many sites are requesting multiple (hundreds in come cases!) WASM files.

### MIME type

{{ figure_markup(
  image="top-mime-types.png",
  caption="Top MIME types",
  description="Bar chart showing MimeTypes and Percentage of WASM request with both clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1325615855&format=interactive",
  sql_file="mime_types.sql",
  sheets_gid="1706394885",
  width="600",
  height="430"
  )
}}

We observed that the MIME type `application/wasm` is used in 293,470 requests on desktop clients and 301,127 requests on mobile clients.

Some requests lacked a `Content-Type` header, and some had incorrect MIME types, such as `text/html` or `text/plain`. These account for 3.2% and 2.4% of requests, respectively. Compared to 2022, these percentages have dropped significantly, indicating increased awareness in setting the correct MIME type for WASM applications.

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

These WebAssembly modules differ considerably in size, with the smallest being just a few kilobytes, and the largest one is 228.102 MB in desktop’s client and 166.415 MB for mobile client.

{{ figure_markup(
  caption="Largest WebAssembly file detected.",
  content="228 MB",
  classes="big-number",
  sheets_gid="241152503",
  sql_file="module_sizes.sql"
  )
}}

## WebAssembly libraries

Our crawl identified a modest number of modules, it is possible to analyze and learn about the most popular libraries in requests for wasm.

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

- **Library : System (43.1%)** is used for fundamental "glue" code and It often includes "system-level" bindings (like those from WASI or Emscripten) that allow a Wasm module to communicate with the host environment (the browser) to handle tasks like memory management or basic I/O. system utilities.

- **Library : Microsoft (23.2%)** represents the massive footprint of the Microsoft ecosystem on the web, primarily driven by Blazor WebAssembly. Blazor allows developers to build interactive web UIs using C# and .NET instead of JavaScript. The high percentage reflects many enterprise and business applications that have been ported to the web using Microsoft's specialized Wasm runtime for the .NET framework.

- **Library : RXEngine (6.2%)** is a more specialized entry, often associated with high-performance execution engines used for specific industries like gaming or advanced data processing. While more niche than the top two, its 6.2% share indicates it is a popular choice for developers who need a pre-built, optimized engine to handle computationally intensive tasks (such as real-time analytics or complex UI interactions) without building the entire infrastructure from scratch.

## WebAssembly languages

WebAssembly can use various languages and using toolchains It can be compiled in binary format to server browser and desktop applications. It can carry much of the information in the source (programming language, application structure, variable names).

Each WebAssembly has import and or export components, Most WebAssembly toolchains create a small amount of JavaScript code, for the purposes of ‘binding’, making it easier to integrate components into JavaScript applications. These bindings often have recognisable function names which are present in the components exports or imports, giving a reliable mechanism for identifying the language that was used to author the component.

If WASM has not used obfuscation and or other techniques that are stripped down while building deliverable then we can use the rust libraries and WebAssembly Binary Toolkit (WABT) to understand the source programming language.

We enhanced the wasm-stats project and created tool almanac-wasm that helps to download wasm file from the 3rd party server with preferred request parameters for example user-agent, compression method etc, validates the downloaded wasm file and with rust library and WABT (wasm2wat), It  finds the author’s language and populates wasm statistics along with language.

For example, [wasm-bindgen](https://crates.io/crates/wasm-bindgen) is a suite of tools that helps to generate high level code Rust-compiled WebAssembly (Wasm) component and JavaScript with name as "wbindgen" so If We import the component from WebAssembly and find "wbindgen" then there is  clearly indication that component in WebAssembly was written in Rust language.

Like wise, We have researched and found various language indicators inside WebAssembly’s different components with the tool.

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

However 41.1% clients in desktop and 41.6% clients in mobile have language "Unknown" that means We could not find the author’s (source) language because of missing language indicators or WebAssembly is stripped with the obfuscation or other techniques; These techniques are used to reduce the size, enable privacy/security features or to optimize the performance of the WebAssembly by the modern compilers.

## WebAssembly features

The initial release of WebAssembly was considered an MVP. In common with other web standards, it is continually evolving under the governance of the World Wide Web Consortium (W3C). This year saw the announcement of the WebAssembly version 2.0, adding a number of new features. The version 3.0 shows the true vision and its potential for WebAssembly.

SIMD stands for Single Instruction, Multiple Data. SIMD instructions are a special class of instructions that exploit data parallelism in applications by simultaneously performing the same operation on multiple data elements. Compute intensive applications like audio/video codecs, image processors, are all examples of applications that take advantage of SIMD instructions to accelerate performance. Most modern architectures support some variants of SIMD instructions.

{{ figure_markup(
  image="extensions-usage.png",
  caption="Post-MVP extensions usage.",
  description="Bar chart showing total module counts along with numbers of modules using various post-MVP extensions. Total numbers, as mentioned in the beginning of the article, are at 233,857 and 255,060 on desktop and mobile respectively. Sign extension ops stand out and were found in a large number of those—45,969 on desktop clients and 50,394 on mobile. The bulk memory is 187,674 on desktop and 204,103 on mobile. The rest are so much lower that they barely register on the graph.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1868040845&format=interactive",
  sql_file="proposals.sql",
  sheets_gid="111956915"
  )
}}

SIMD is a new feature and isn't yet available in all browsers with WebAssembly support. In the Year 2021, We had found SIMD extension usage in 20 Wasm modules on desktop and 21 Wasm modules on mobile clients, This feature usage is now increased with 2265 Wasm modules on desktop and 2470 on mobile clients.

With respect to the total extension usage in Year 2021, It is observed that total extension usage in 2025 drastically ~61 times more on desktop clients and ~80 times more on mobile based clients. To make the usage of very complex tasks, the WebAssembly, We have marked the Bulk Memory stats are increased  to 8936 times higher on desktop and 25,512 times higher on mobile clients with respect to Year 2021 stats.

## Conclusions

There is a significant increase in the number of webpages using this technology for serverless, containerization, machine learning components and plug-n-play types of applications. The future of WebAssembly could be as a niche web technology, but as an entirely mainstream runtime on a wide range of other platforms. WebAssembly runtime (multi-language, lightweight, secure) are making it a popular choice for a wider range of non-browser applications for agnostic platforms.

Despite being a niche technology, WebAssembly is already adding value to the web. There are a number of web applications that benefit greatly from this technology. However, web applications are often not visible to the ‘crawl’ which forms the basis of this study.
