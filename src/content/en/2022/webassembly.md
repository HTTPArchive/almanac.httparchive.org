---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: WebAssembly chapter of the 2022 Web Almanac covering usage, languages, and post-MVP features.
hero_alt: Hero image of Web Almanac chracters performing scientific experiments on various code symbols resulting in 1's and 0's coming out the other end.
authors: [ColinEberhardt]
reviewers: [binji, RReverser]
analysts: [JamieWhitMac]
editors: [tunetheweb]
translators: []
ColinEberhardt_bio: Colin is CTO at <a hreflang="en" href="https://www.scottlogic.com/">Scott Logic</a> and is a prolific technical author, blogger and speaker on a range of technologies. He is a board member of <a hreflang="en" href="https://www.finos.org/">FINOS</a>, which is encouraging open source collaboration in the financial sector. He is also very active on GitHub, contributing to a number of different projects.
results: https://docs.google.com/spreadsheets/d/11jyABro0fKtuN6INnYP9pJlv5QWwp0jfJyTsGfKgScg/
featured_quote: Despite being a niche technology, WebAssembly is already adding value to the web. There are a number of web applications that benefit greatly from this technology.
featured_stat_1: 383
featured_stat_label_1: Unique WebAssembly binaries discovered
featured_stat_2: 34.9%
featured_stat_label_2: Mobile sites using Amazon IVS
featured_stat_3: 72.8%
featured_stat_label_3: Modules using Emscripten
---

## Introduction

WebAssembly—or Wasm—is a relative newcomer to the family of web technologies (JavaScript, HTML, CSS), becoming an officially recognized W3C standard in December 2019.

WebAssembly introduces a new runtime into the browser, one which works alongside, and in close collaboration, with the JavaScript runtime. It is relatively lightweight in comparison, with a small instruction set and a strict isolation model (WebAssembly has no I/O by default). One of the primary motivators for developing WebAssembly was to provide a compilation target for a wide range of programming languages (C++, Rust, Go etc.), allowing developers to write new web applications, or port existing applications, with a wider toolset.

High-profile examples of WebAssembly include its <a hreflang="en" href="https://blog.chromium.org/2019/06/webassembly-brings-google-earth-to-more.html">use within Google Earth</a>, where the C++ desktop application is now available within the browser, <a hreflang="en" href="https://www.figma.com/blog/webassembly-cut-figmas-load-time-by-3x/">Figma</a>, a browser-based design tool that enjoyed significant performance improvements using this technology, and most recently <a hreflang="en" href="https://web.dev/ps-on-the-web/">Photoshop</a> which uses WebAssembly for similar reasons.

## Methodology

WebAssembly is a compilation target, distributed as binary modules. For this reason, we face a number of challenges when analyzing its usage on the web. The 2021 Web Almanac, which is the first edition that included WebAssembly, includes a [detailed section on the methodology used](../2021/webassembly#methodology), and related caveats. The findings here, in the 2022 edition, followed the same methodology. The only enhancement added is a mechanism for determining the language used to author WebAssembly modules. The accuracy of that analysis is covered in more detail in the respective section.

## How widely is WebAssembly being used?

We found 3,204 confirmed WebAssembly requests on desktop and 2,777 on mobile. Those modules are used across 2,524 domains on desktop and 2,216 domains on mobile, which represents 0.06% and 0.04% of all domains on desktop and mobile correspondingly.

This represents a modest drop in the number of modules we discovered in the crawl, a reduction of 16% for desktop and 12% mobile requests. This doesn't necessarily mean WebAssembly is in decline, when interpreting this change it is worth noting the following:

- While you can use WebAssembly to create all sorts of web-based content, its main benefit is found in more complex line-of-business applications with large codebases, that are often many years old (e.g. Google Earth, Photoshop, AutoCAD). These web 'apps' are not as numerous as the websites, and are not always available to the Almanac crawl, which is primarily based on home pages where WebAssembly may be less prevalent.
- As we shall see in a later section, much of the WebAssembly usage we see comes from a relatively small number of third-party libraries. As a result, a small change in any one of those libraries will have a significant impact on the number of modules we find.

We found slightly fewer (-13%) WebAssembly modules served to mobile browsers. This isn't a reflection on the WebAssembly capabilities of mobile browsers, which generally have excellent support. Rather, it is likely due to the standard practice of [progressive enhancement](https://developer.mozilla.org/docs/Glossary/Progressive_Enhancement), where in these cases the more advanced features that require WebAssembly are not supported for mobile users.

{{ figure_markup(
  caption="Number of Wasm responses.",
  description="Bar chart showing numbers of total Wasm responses on desktop and mobile datasets as well as number of unique  files. Number of unique files is much lower—only 383 out of 3,204 total responses on desktop and 310 out of 2,777 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1842699031&format=interactive",
  sheets_gid="2142789475",
  sql_file="counts.sql",
  image="counts.png"
  )
}}

By hashing the WebAssembly modules we can determine how many of these 3,204 modules—on desktop—are unique. By de-duplicating modules, the total number reduces by roughly a factor of 10, with 383 unique modules served to desktop browsers, and 310 to mobile. This indicates a significant amount of re-use—different websites making use of the same WebAssembly code, most likely through shared modules.

A significant proportion of wasm requests are cross-origin, further reinforcing the notion that they are re-used. Notably this has increased significantly from last year (67.2% vs 55.2%).

{{ figure_markup(
  caption="Cross-origin WebAssembly usage.",
  description="Bar chart showing 67.2% of WebAssembly usage on desktop, and 60.9% on mobile are cross-origin.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=2039142493&format=interactive",
  sheets_gid="491240617",
  sql_file="cross_domain.sql",
  image="cross_domain.png"
  )
}}

These WebAssembly modules differ considerably in size, with the smallest being just a few kilobytes, and the largest weighing in at 7.3 megabytes. Looking in more detail, at the uncompressed size, we see that the median (50th percentile) size is 835KBytes.

The smallest of WebAssembly modules are likely being used for quite specific functionality, for example polyfilling browser capabilities, or simple encryption tasks. The larger modules are likely entire applications that are compiled to WebAssembly.

{{ figure_markup(
  caption="Uncompressed response sizes.",
  description="Bar chart showing distribution of uncompressed response sizes on desktop and mobile at percentiles 25, 50, 75, 90. Most notably, at 10 percentiles there is 23 KB, median at about 835 KB, and 90 percentiles at 4.87 MB on desktop and 3.24 MB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=736723663&format=interactive",
  sheets_gid="1169986524",
  sql_file="module_sizes.sql",
  image="uncompressed_resp_sizes.png"
  )
}}

Clearly WebAssembly isn't widely used, and rather than seeing a growth in usage, we are seeing a modest contraction.

## What is WebAssembly being used for?

{{ figure_markup(
  caption="Popular WebAssembly libraries.",
  description="Bar chart showing top 10 libraries in desktop and mobile datasets, merged into one graph. Each library is shown along with percentage of Wasm requests that could be attributed to it. The list is as follows: Amazon IVS (33.5% on desktop and 34.9% on mobile), Hyphenopoly (8.2% and 12.1%), Blazor (6.2% and 8.5%), ArcGIS (6.7% and 6.0%), CanvasKit (7.7% and 2.7%), Tableau (5.2% and 3.0%), Draco (3.2% and 3.1%), Xat (1.6% and 1.5%), and Hewlett Packard Enterprise (HPE) (1.6% and 0.8%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1535512737&format=interactive",
  sheets_gid="721946887",
  sql_file="popular_by_name.sql",
  image="popular_by_name.png"
  )
}}

- <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon IVS (Amazon Interactive Video Service)</a> - Here WebAssembly is likely being used as a video codec, allowing consistent video decoding independent of the codec support of the user's browser
- <a hreflang="en" href="https://mnater.github.io/Hyphenopoly/">Hyphenopoly</a> - This in an npm module that provides a polyfill for CSS hyphenation. The core algorithm is shipped as a WebAssembly module, giving a small footprint and consistent performance
- <a hreflang="en" href="https://dotnet.microsoft.com/en-us/apps/aspnet/web-apps/blazor">Blazor</a> - Microsoft Blazor is a platform—runtime and UI library—that supports the development of web applications using the .NET platform and C#.
- <a hreflang="en" href="https://developers.arcgis.com/javascript/latest/">ArcGIS</a> - A comprehensive suite of tools for building interactive mapping applications. Performance is a primary concern for the ArcGIS team, and they employ various technologies such as WebGL to achieve this. Specifically, WebAssembly is used to enable fast client-side projections.
- <a hreflang="en" href="https://skia.org/docs/user/modules/canvaskit/">CanvasKit</a> - This library provides more advanced capabilities than the standard Canvas2D API. It is implemented via Skia, a graphics library written in C++, which is compiled to WebAssembly allowing execution in the browser.
- <a hreflang="en" href="https://www.tableau.com/">Tableau</a> - A popular tool for building interactive visualizations. It is not clear whether WebAssembly is used as part of their core product, or whether it is just being used for the specific dashboards that were found as part of the crawl.
- <a hreflang="en" href="https://google.github.io/draco/">Draco</a> - A library for compressing and decompressing 3D geometric meshes and point clouds. It is written in C++, with the WebAssemby building allowing its use within the browser.
- <a hreflang="en" href="https://xat.com/">Xat</a> - A social media site. It is unclear what they are using WebAssembly for.
- <a hreflang="en" href="https://www.hpe.com/us/en/home.html">Hewlett Packard Enterprise</a> - It is unclear what they are using WebAssembly for.

From looking at the popular WebAssembly libraries we can see that its usage is quite targeted, often being used for specific number-crunching tasks, or leveraging large and mature C++ codebases, bringing their capabilities to the web without the need to port to JavaScript.

## What languages are people using?

WebAssembly is a binary format, and as a result, much of the information in the source—programming language, application structure, variable names—is obfuscated or entirely lost in the compilation process.

However, modules often have exports and imports, which name functions within the hosting environment—the JavaScript runtime within the browser—that describe the module interface. Most WebAssembly toolchains create a small amount of JavaScript code, for the purposes of 'binding', making it easier to integrate modules into JavaScript applications. These bindings often have recognizable function names which are present in the modules exports or imports, giving a reliable mechanism for identifying the language that was used to author the module.

We enhanced the <a hreflang="en" href="https://github.com/HTTPArchive/wasm-stats">wasm-stats</a> project, which provides WebAssembly-specific analysis to the crawler, adding code which inspects exports / imports to identify common patterns that provide an indication of the language used to author a given module. As an example, if a module imports a module names `wbindgen` this is a reference to code generated by <a hreflang="en" href="https://crates.io/crates/wasm-bindgen">wasm-bindgen</a> and a clear indicator that the module was written in Rust.

In some cases, the export / import names are minified, making it harder to identify the source language. However, Emscripten (a C++ toolchain), has a distinctive convention for minified names, meaning that we can be relatively confident that modules exhibiting this pattern were generated using Emscripten.

{{ figure_markup(
  caption="WebAssembly language usage.",
  description="LikelyEmscripten (63.8% on desktop and 61.1% on mobile), Unknown (11.7% and 16.9%), Emscripten (13.3% and 11.8%), Rust (8.0% and 6.0%), Blazor (2.7% and 3.5%), and Go (0.6% and 0.7%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1942715596&format=interactive",
  sheets_gid="915015663",
  sql_file="language_usage.sql",
  image="language_usage.png"
  )
}}

Looking at the results, we found that, on desktop, 72.8% of modules were very likely created using Emscripten, and as a result are most likely written in C++. Next most popular is Rust at 6.0%, then Blazor (C#) at 3.5%. We also found a small number of modules written in Go.

Notably, 16.9% of modules didn't have an identifiable language. <a hreflang="en" href="https://www.assemblyscript.org/">AssemblyScript</a> is a popular WebAssembly-specific language which doesn't provide any obvious clues in the modules it produces. We know that Hypehnopoly—which represents 8.2% of all modules—uses AssemblyScript, and it accounts for almost half of these 'unidentified' modules.

It is interesting to contrast these results with the <a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">State of WebAssembly 2022 survey</a>, where Rust was the most frequently used language. However, a significant number of respondents to that survey were using WebAssembly for non-browser based applications.

## What features are being used?

The initial release of WebAssembly was considered an MVP. In common with other web standards, it is continually evolving under the governance of the World Wide Web Consortium (W3C). This year saw the announcement of the <a hreflang="en" href="https://www.w3.org/TR/wasm-core-2/">WebAssembly v2 draft</a>, adding a number of new features.

{{ figure_markup(
  caption="Post-MVP extensions usage.",
  description="Bar chart showing total module counts along with numbers of modules using various post-MVP extensions. Total numbers, as mentioned in the beginning of the article, are at 3,204 and 2,777 on desktop and mobile correspondingly. Sign extension ops stand out and were found in a large number of those—2,850 on desktop and 2,378 on mobile. The rest are so much lower that they barely register on the graph. Each of atomics, BigInt imports/exports, bulk memory, SIMD and mutable imports/exports proposals were found only in up to 38 modules on desktop and up to 28 modules on mobile. Proposals like multi-value, non-trapping float-to-int conversions, reference types and tail calls weren't found in any modules in either dataset.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1935172150&format=interactive",
  sheets_gid="1865524955",
  sql_file="proposals.sql",
  image="proposals.png"
  )
}}

We looked at the Post-MVP features that are being used, finding that _sign extension_ (a relatively simple enhancement adding operators that allow you to extend integer values to a greater bit-depth), was by far the most frequently used. This doesn't represent a significant [difference to the result found in last year's analysis](../2021/webassembly#whats-the-usage-of-post-mvp-extensions).

Notably, while web developers are faced with the choice of which HTML / JavaScript / CSS features to use, with WebAssembly this is often a decision made by the toolchain developers. As a result, we will likely see Post-MVP feature adoption jump when a given toolchain determines that it is now a viable option.

## Conclusions

WebAssembly is undeniably a niche technology when it comes to the web, and there is a very good chance that it always will be. While WebAssembly has brought a wide range of languages to the web—C++, Rust, Go, AssemblyScript, C# and more—these cannot yet be used interchangeably with JavaScript. For the vast majority of websites, where the content is relatively static (rendered in HTML with CSS) with a modest amount of interactivity (via JavaScript) there simply isn't a compelling reason to use WebAssembly at the moment.

There are some significant proposals which could change this in the future. Initially WebIDL, which was superseded by Interface Types, which has once again been superseded by the Component Model specification. These may result in a future where it is possible to easily interchange JavaScript for any other programming language, but for now, this simply isn't the case.

Despite being a niche technology, WebAssembly is already adding value to the web. There are a number of web applications that benefit greatly from this technology. However, web applications are often not visible to the 'crawl' which forms the basis of this study.

Finally, the core features of the WebAssembly runtime—multi-language, lightweight, secure—are making it a popular choice for a wider range of non-browser applications. The <a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">State of WebAssembly 2022 survey</a> saw a significant increase in the number of people using this technology for serverless, containerization and plug-in applications. The future of WebAssembly could be as a niche web technology, but as an entirely mainstream runtime on a wide range of other platforms.
