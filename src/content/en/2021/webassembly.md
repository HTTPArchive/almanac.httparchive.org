---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: TODO
authors: [RReverser]
reviewers: [jsoverson, carlopi, kripken]
analysts: [RReverser]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1IMa2SbdQgshb4pGWF1KOh9s4zMtLbRymWZGYjdaatXY/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

[WebAssembly](https://webassembly.org/) is a binary instruction format that allows developers to compile code written in languages other than JavaScript and bring it to the web in an efficient, portable package. The ported use-cases range from reusable libraries and codecs to full GUI applications. It's been available in all browsers since 2017 - for 4 years now - and has been gaining adoption since, and this year we've decided it's about time to start tracking its usage in the Web Almanac.

## Methodology

For our analysis we've selected all WebAssembly responses from the HTTP Archive crawl on 2021-09-01 that matched either `Content-Type` (`application/wasm`) or a file extension (`.wasm`). Then, we downloaded [all of those](https://github.com/RReverser/wasm-stats/blob/master/downloader/wasms.csv) with a [script](https://github.com/RReverser/wasm-stats/blob/master/downloader/index.mjs) that additionally stored the URL, response size, uncompressed size and content hash in a [CSV file](https://github.com/RReverser/wasm-stats/blob/master/downloader/results.csv) in the process. We excluded the requests where we repeatedly couldn't get a response due to server errors, as well as those where the content did not in fact look like WebAssembly. For example, some [Blazor](https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor) websites served [.NET DLLs](https://docs.microsoft.com/en-us/troubleshoot/windows-client/deployment/dynamic-link-library#the-net-framework-assembly) with `Content-Type: application/wasm`, even though those are actually DLLs parsed by the framework core, and not WebAssembly modules.

For WebAssembly content analysis, we couldn't use BigQuery directly. Instead, we created a [tool](https://github.com/RReverser/wasm-stats) that parses WebAssembly modules in the given directory and collects numbers of instructions per category, section sizes, numbers of imports/exports and so on, and stores all the stats in a `stats.json` file. After executing it on all the modules from the previous step, the resulting file was [imported into BigQuery](https://cloud.google.com/bigquery/docs/batch-loading-data) and [joined with the corresponding `summary_requests` table](https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/util/wasm_stats.sql) into `httparchive.almanac.wasm_stats` so that each request record contains all the Wasm stats. This final table was then used for all further analysis.

Using crawler requests as a source for analysis has its own tradeoffs you need to be aware of when looking at the numbers in this article:

+   First, we don't have information about requests that can be triggered by user interaction. We include only resources collected during the page load.
+   Second, some websites are more popular than others, but we don't have precise visitor data and don't take it into account - instead, each detected Wasm usage is treated as equal.
+   Finally, in graphs like sizes we count the same WebAssembly module used across multiple websites as unique usages, instead of comparing only unique files. This is because we are most interested in the global picture of WebAssembly usage across the web pages rather than comparing libraries to each other.

Those tradeoffs are most consistent with analysis done in other chapters, but if you're interested in gathering other statistics, you're welcome to run your own queries against the table `httparchive.almanac.wasm_stats`.

## How many modules?

We got 3854 confirmed WebAssembly requests on desktop and 3173 on mobile. Those Wasm modules are used across 2724 domains on desktop and 2300 domains on mobile, which represents 0.06% and 0.04% of all domains on desktop and mobile correspondingly.

Interestingly, when we look at the most popular resulting content-types, we can see that while `Content-Type: application/wasm` is by far most popular, it doesn't cover all the Wasm responses:

![image](insert_image_url_here)

Some of those used `application/octet-stream` - a generic content-type for arbitrary binary data, some didn't have any content-type header, and others incorrectly used text types (plain text, HTML and JSON) or even invalid types like `binary/octet-stream`.

In the case of WebAssembly, providing correct `Content-Type` is important not only for security reasons, but also because it enables a faster streaming compilation and instantiation via [`WebAssembly.compileStreaming](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/compileStreaming)` and [`WebAssembly.instantiateStreaming](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/instantiateStreaming)`.

While downloading those responses, we've also deduplicated them by hashing their contents and using that hash as a filename on disk. After that we were left with 656 unique WebAssembly files on desktop and 534 on mobile.

![image](insert_image_url_here)

The stark difference between the numbers of unique files and total responses already suggests high reuse of WebAssembly libraries across various websites. It's further confirmed if we look at the distribution of cross-origin / same-origin WebAssembly requests:

![image](insert_image_url_here)

Let's dive deeper into that and figure out what those reused libraries are. First, we've tried to deduplicate libraries by content hash alone, but it became quickly apparent that many of those are still duplicates that differ only by library version.

Instead, we decided to extract library names from URLs. While it's more problematic in theory due to potential name clashes, it turned out to be a more reliable option in practice. We extracted filenames from URLs, removed suffixes that looked like versions or content hashes, sorted the results by number of repetitions and extracted the top 10 modules for each client. For those left, we did manual lookups to understand which libraries those modules are coming from.

![image](insert_image_url_here)

Almost 1/3 of WebAssembly usages on both desktop and mobile belong to the [Amazon Interactive Video Service](https://aws.amazon.com/ivs/) player library. While it's not open-source, the inspection of the associated JavaScript glue code suggests that it was built with [Emscripten](https://emscripten.org/).

The next up is [Hyphenopoly](https://github.com/mnater/Hyphenopoly) - a library for hyphenating text in various languages - that accounts for 13% and 19% of Wasm requests on desktop and mobile correspondingly. It's built with JavaScript and [AssemblyScript](https://www.assemblyscript.org/).

Other libraries from both top 10 desktop and mobile lists account for up to 5% of WebAssembly requests each. Here's a complete list of libraries from the graph above, with toolchains and links to the corresponding homepages:

+   [Amazon IVS](https://aws.amazon.com/ivs/) (Emscripten)
+   [Hyphenopoly](https://mnater.github.io/Hyphenopoly/) (AssemblyScript)
+   [Blazor](https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor) (.NET)
+   [ArcGIS](https://developers.arcgis.com/javascript/latest/) (Emscripten)
+   [Draco](https://google.github.io/draco/) (Emscripten)
+   [CanvasKit](https://skia.org/docs/user/modules/canvaskit/) (Emscripten)
+   [Playa Games](https://www.playa-games.com/en/) (Unity via Emscripten)
+   [Tableau](https://help.tableau.com/current/api/js_api/en-us/JavaScriptAPI/js_api.htm) (Emscripten)
+   [Xat](https://xat.com/) (Emscripten)
+   [Tencent Video](https://intl.cloud.tencent.com/products/vod) (Emscripten)
+   [Nimiq](https://www.npmjs.com/package/@nimiq/core-web) (Emscripten)
+   [Scandit](https://www.scandit.com/developers/) (Emscripten)

## How much do we ship?

Languages compiled to WebAssembly usually have their own standard library. Since APIs and value types are so different across languages, they can't reuse the JavaScript built-ins. Instead, they have to compile not only their own code, but also APIs from said standard library and ship it all together to the user in a single binary. What does it mean for the resulting file sizes? Let's take a look:

![image](insert_image_url_here)

The sizes vary a lot, which indicates a decent coverage of various types of content - from simple helper libraries to full applications compiled to WebAssembly.

Sizes of up to 84 MiB look pretty concerning, but keep in mind those are uncompressed responses. While they're also important for RAM footprint and start-up performance, one of the benefits of Wasm bytecode is that it's highly compressible, and size over the wire is what matters for download speed and billing reasons.

Let's check sizes of raw response bodies as sent by servers instead:

![image](insert_image_url_here)

The median is at around 300 KiB, meaning that half of usages download below 300 KiB, and half are larger. 90% of all Wasm responses stay below 2.6 MiB on desktop and 1.4 MiB on mobile. At the same time, the largest response in the HTTP Archive downloads about 46 MiB of Wasm on desktop and 29 MiB on mobile.

Even with compression, those numbers are still pretty extreme, considering that many parts of the world still don't have a high-speed internet connection. Aside from reducing the scope of applications and libraries themselves, is there anything websites could do to improve those stats?

### How is Wasm compressed in the wild?

First, let's take a look at compression methods used in these raw responses:

![image](insert_image_url_here)

Unfortunately, ~38% of those WebAssembly responses are shipped without any compression.

38%
_Percent of uncompressed WebAssembly responses_

Another ~45% use gzip, which has been a de-facto standard method on the web for a long time, and still provides a decent compression ratio, but not the best one today. Finally, only ~17% use Brotli - a modern compression format with an even better ratio that is supported [in all modern browsers](https://caniuse.com/brotli). In fact, Brotli is supported in every browser that has WebAssembly support too, so there's no reason not to use them together.

### Can we improve compression?

Would it have made a difference? We've decided to recompress all those WebAssembly files with Brotli (compression level 9) to figure it out. The command used on each file:

```bash
brotli -k9f some.wasm -o some.wasm.br
```

Resulting sizes:

![image](insert_image_url_here)

The median drops from 300 KiB to 250 KiB, which is already a pretty good sign. The top 10% go down from 2.6 MiB / 1.4 MiB to 2.3 MiB / 0.8 MiB. We can see significant improvements across all other percentiles, too.

Due to their nature, percentiles don't necessarily fall onto the same files between datasets, so it might be hard to compare numbers directly between graphs and to understand the distribution of savings. Instead, from now on, let me show the savings themselves provided by each optimization, step by step:

![image](insert_image_url_here)

Median savings are around 40 KiB. The top 10% save over 600 KiB on desktop and 335 KiB on mobile, and the largest savings produced reach as much as 36 MiB / 22 MiB. Those differences speak in favor of enabling Brotli compression whenever possible, at least for WebAssembly content.

What happened at the worst end - how is it possible that Brotli recompression has made things worse for some modules? As mentioned above, in this article we've used Brotli with compression level 9, but it also has levels 10 and 11. They produce even better results in exchange for a steep performance drop-off, as seen, for example, in [Squash benchmarks](https://quixdb.github.io/squash-benchmark/#results-table). This trade-off can make them worse candidates for the common on-the-fly compression, which is why we didn't use them in this article and went for a more moderate level 9. However, website authors can choose to compress their static resources ahead of time or cache the compression results, and save even more bandwidth without sacrificing CPU time. Cases like these show up as regressions in the graph above.

### Which sections take up most of the space?

Compression aside, we can also look at the high-level structure of WebAssembly binaries. What are the largest sections? I'll ignore the desktop/mobile split as it's less interesting here, and just sum up uncompressed section sizes from all requests together:

![image](insert_image_url_here)

Unsurprisingly, most - 77% - of the total size comes from the compiled code itself, followed by 18% for embedded static data. Things like function types, import/export descriptors and such comprise a negligible part - 0.3% - of the total size. However, one section type stands out - it's custom sections, which account for ~4.5% of total binary size in the dataset.

4.5%
_Percent of total Wasm size in the dataset that belongs to custom sections_

Custom sections are mainly used in WebAssembly for 3rd-party tooling - they might contain information for type binding systems, linkers, DevTools and such. While all of those are legitimate use-cases, they are rarely necessary in production code, so such a large percentage is suspicious. Let's take a look at what they are in top 10 files with largest custom sections:

<table>
<thead>
<tr>
<th>url</th>
<th>custom_sections_size</th>
<th>custom_sections</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://gallery.platform.uno/package_85a43e09d7152711f12894936a8986e20694304a/dotnet.wasm">https://gallery.platform.uno/package_85a43e09d7152711f12894936a8986e20694304a/dotnet.wasm</a></td>
<td>15053733</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://cdn.decentraland.org/@dcl/unity-renderer/1.0.12536-20210902152600.commit-86fe4be/unity.wasm.br?v=1.0.8874">https://cdn.decentraland.org/@dcl/unity-renderer/1.0.12536-20210902152600.commit-86fe4be/unity.wasm.br?v=1.0.8874</a></td>
<td>9705643</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://nanoleq.com/nanoleq-HTML5-Shipping.wasmgz">https://nanoleq.com/nanoleq-HTML5-Shipping.wasmgz</a></td>
<td>8531376</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://convertmodel.com/export.wasm">https://convertmodel.com/export.wasm</a></td>
<td>7306371</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://webasset-akm.imvu.com/asset/c0c43115a4de5de0/build/northstar/js/northstar_api.wasm">https://webasset-akm.imvu.com/asset/c0c43115a4de5de0/build/northstar/js/northstar_api.wasm</a></td>
<td>6470360</td>
<td>name, external_debug_info</td>
</tr>
<tr>
<td><a href="https://webasset-akm.imvu.com/asset/9982942a9e080158/build/northstar/js/northstar_api.wasm">https://webasset-akm.imvu.com/asset/9982942a9e080158/build/northstar/js/northstar_api.wasm</a></td>
<td>6435469</td>
<td>name, external_debug_info</td>
</tr>
<tr>
<td><a href="https://superctf.com/ReactGodot.wasm">https://superctf.com/ReactGodot.wasm</a></td>
<td>4672588</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://ui.perfetto.dev/v18.0-591dd9336/trace_processor.wasm">https://ui.perfetto.dev/v18.0-591dd9336/trace_processor.wasm</a></td>
<td>2079991</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://ui.perfetto.dev/v18.0-615704773/trace_processor.wasm">https://ui.perfetto.dev/v18.0-615704773/trace_processor.wasm</a></td>
<td>2079991</td>
<td>name</td>
</tr>
<tr>
<td><a href="https://unpkg.com/canvaskit-wasm@0.25.1/bin/profiling/canvaskit.wasm">https://unpkg.com/canvaskit-wasm@0.25.1/bin/profiling/canvaskit.wasm</a></td>
<td>1491602</td>
<td>name</td>
</tr>
</tbody>
</table>

All of those are almost exclusively the `name` section which contains function names for basic debugging. In fact, if we keep looking through the dataset, we can see that almost all of those custom sections contain just the debug information.

### How much can we save by stripping debug info?

While debug information is useful for local development, those sections can be hefty - they take up to 15 MiB before compression in the table above. If you want to be able to debug production issues users are experiencing, a better approach might be to strip the debug information out of the binary using `llvm-strip`, `wasm-strip` or `wasm-opt --strip-debug` before shipping, collect raw stacktraces and match them back to source locations locally, using the original binary.

Let's check how much stripping this debug information would save us in combination with Brotli, vs. just Brotli from the previous step:

![image](insert_image_url_here)

Most files in the archive already didn't have custom sections. In those that did, we could save up to 2.4 MiB / 1.3 MB for the largest Wasm binaries on desktop and mobile, which is a pretty noticeable improvement, especially on slow connections.

You might have noticed that the difference is a lot smaller than raw sizes of custom sections from the table above. The reason is that the `name` section, as its name suggests, consists mostly of function names, which are ASCII strings with lots of repetitions, and, as such, are highly compressible.

There are a few outliers where the process of removing custom sections with `llvm-strip` made some changes to the WebAssembly module that made it smaller before compression, but slightly larger after the compression. Such cases are rare though, and the difference in size is insignificant compared to the total size of the compressed module.

### How much can we save via wasm-opt?

`wasm-opt` from the [Binaryen](https://github.com/WebAssembly/binaryen) suite is a powerful optimization tool that can improve both size and performance of the resulting binaries. It's used in major WebAssembly toolchains such as Emscripten, wasm-pack and AssemblyScript to optimize binaries produced by the underlying compiler.

It provides significant size savings on both uncompressed and compressed real-world benchmarks:

![image](insert_image_url_here)

![image](insert_image_url_here)

We've decided to check the performance of wasm-opt on the collected HTTP Archive dataset as well, but there's a catch.

As mentioned above, wasm-opt is already used by most compiler toolchains, so most of the modules in the dataset are already its resulting artifacts. Unlike in compression analysis above, there's no way for us to reverse existing optimizations and run wasm-opt on the originals. Instead, we're re-running wasm-opt on pre-optimized binaries, which skews the results. This is the command we've used on binaries produced after the strip-debug step:

```bash
$ wasm-opt -O -all some.wasm -o some.opt.wasm
```

Then, we compressed the results to Brotli and compared to the previous step, as usual.

While the resulting data is not representative of real-world usage and not relevant to regular consumers who should use `wasm-opt` as they normally do, it might be useful to consumers like CDNs that want to run optimizations at scale, as well as to the Binaryen team itself:

![image](insert_image_url_here)

There are significant savings in a small percentage of files that were not optimized before publishing on the web. But why are the other results so mixed?

If we look at the uncompressed savings, it becomes more clear that, even on our dataset, wasm-opt consistently keeps files either roughly the same size or still improves size slightly further in majority of cases, and produces significant savings for the unoptimized files.

![image](insert_image_url_here)

This suggests several reasons for the surprising distribution in the post-compression graph:

1.  As mentioned above, our dataset does not resemble real-world wasm-opt usage as the majority of the files have been already pre-optimized by wasm-opt. Further instruction reordering that improves uncompressed size a bit further, is bound to make certain patterns either more or less compressible than others, which, in turn, produces statistical noise.
1.  Also as mentioned earlier, the network (compressed) size is not everything.
Smaller WebAssembly binaries tend to mean faster compilation in the VM, less memory consumption while compiling, and less memory to hold the compiled code. wasm-opt has to strike a balance here, which might also mean that the compressed size might sometimes regress in favor of better raw sizes.
1.  Finally, some regressions at the extreme end of the graph look like potentially valuable examples to study and improve that balance. We've [reported them back](https://github.com/WebAssembly/binaryen/issues/4322) to the Binaryen team so that they could look deeper into potential optimizations.

## What are the most popular instructions?

We've already glimpsed at the contents of Wasm when sliced by section kinds above. Let's take a deeper look at the contents of the code section - the largest and the most important part of a WebAssembly module.

First, we've split instructions into various categories and counted them across all desktop and mobile Wasm modules together:

![image](insert_image_url_here)

One surprising takeaway from this distribution is that local var operations - that is, `local.get`, local.set` and `local.tee` - comprise the largest category - 35.6%, far ahead from the next few categories - inlined constants (15.8%), load/store operations (15.2%) and all the math/logic operations (14.4%). Those operations are usually generated by compilers as a result of optimization passes in compilers. They downgrade expensive memory access operations to local variables where possible, so that engines can subsequently put those local variables into CPU registers, which makes them much cheaper to access.

It's not actionable information for developers compiling to Wasm, but something that might be interesting to engine and tooling developers as a potential area for further size optimizations.

## What's the usage of post-MVP extensions?

Another interesting metric to look at is post-MVP Wasm extensions. While WebAssembly 1.0 was released several years ago, it's still actively developed and grows new features over time - some improve code size by moving common operations to the engines, some provide more powerful performance primitives, and others improve developer experience and integration with the web. On the official [feature roadmap](https://webassembly.org/roadmap/) we track support for those proposals across latest versions of every popular engine.

Let's take a look at their adoption in the Almanac dataset too:

![image](insert_image_url_here)

One feature stands out - it's the [sign-extension operators proposal](https://github.com/WebAssembly/sign-extension-ops/blob/master/proposals/sign-extension-ops/Overview.md). It was shipped in all browsers not too long after the MVP, and enabled in LLVM (a compiler backend used by Clang / Emscripten and Rust) by default, which explains its high adoption rate. All other features currently have to be enabled explicitly by the developer at compilation time.

For example, [non-trapping float-to-int conversions](https://github.com/WebAssembly/nontrapping-float-to-int-conversions/blob/master/proposals/nontrapping-float-to-int-conversion/Overview.md) is very similar in spirit to sign-extension operators - it also provides built-in conversions for numeric types to save some code size - but it became uniformly supported only recently with the release of Safari 15. That's why this feature is not yet enabled by default, and most developers don't want the complexity of building & shipping different versions of their WebAssembly module to different browsers without a very compelling reason. As a result, none of the Wasm modules in the dataset used those conversions.

Other features with zero detected usages - multi-value, reference types and tail calls - are in a similar situation and they could also be useful for most WebAssembly modules, but they additionally suffer from either incomplete compiler or browser support.

Among the remaining, used, features, two that are particularly interesting are SIMD and atomics. Both provide instructions for parallelising and speeding up execution at different levels: [SIMD](https://v8.dev/features/simd) allows to perform math operations on several values at once, and atomics provide a basis for [multithreading in Wasm](https://web.dev/webassembly-threads/). They are not enabled by default, require specific use-cases, and multithreading in particular requires using special libraries in the source code as well as additional configuration to make the website [cross-origin isolated](https://web.dev/coop-coep/) before it can be used on the web. As a result, a relatively low usage level is expected, although we expect them to grow over time.

##

## Conclusion

While WebAssembly is a relatively new and somewhat niche participant on the web, it's great to see its adoption across a variety of websites and use-cases, from simple libraries to large applications.

In fact, we could see that it integrates so well into the web ecosystem, that many website owners might not even know they already use WebAssembly - to them it looks like any other 3rd-party JavaScript dependency.

We found some room for improvement in shipped sizes which, through further analysis, appears to be achievable via changes to compiler or server configuration. We've also found some interesting stats and examples that might help engine, tooling and CDN developers to understand and optimize WebAssembly usage at scale.

We'll be tracking those stats over time and return with updates in the next Web Almanac.
