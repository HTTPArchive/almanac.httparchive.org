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

<a hreflang="en" href="https://webassembly.org/">WebAssembly</a> is a binary instruction format that allows developers to compile code written in languages other than JavaScript and bring it to the web in an efficient, portable package. The existing use-cases range from reusable libraries and codecs to full GUI applications. It's been available in all browsers since 2017 - for 4 years now - and has been gaining adoption since, and this year we've decided it's about time to start tracking its usage in the Web Almanac.

## Methodology

For our analysis we've selected all WebAssembly responses from the HTTP Archive crawl on 2021-09-01 that matched either `Content-Type` (`application/wasm`) or a file extension (`.wasm`). Then, we downloaded <a hreflang="en" href="https://github.com/RReverser/wasm-stats/blob/master/downloader/wasms.csv">all of those</a> with a <a hreflang="en" href="https://github.com/RReverser/wasm-stats/blob/master/downloader/index.mjs">script</a> that additionally stored the URL, response size, uncompressed size and content hash in a <a hreflang="en" href="https://github.com/RReverser/wasm-stats/blob/master/downloader/results.csv">CSV file</a> in the process. We excluded the requests where we repeatedly couldn't get a response due to server errors, as well as those where the content did not in fact look like WebAssembly. For example, some <a hreflang="en" href="https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor">Blazor</a> websites served <a hreflang="en" href="https://docs.microsoft.com/en-us/troubleshoot/windows-client/deployment/dynamic-link-library#the-net-framework-assembly">.NET DLLs</a> with `Content-Type: application/wasm`, even though those are actually DLLs parsed by the framework core, and not WebAssembly modules.

For WebAssembly content analysis, we couldn't use BigQuery directly. Instead, we created a <a hreflang="en" href="https://github.com/RReverser/wasm-stats">tool</a> that parses all the WebAssembly modules in the given directory and collects numbers of instructions per category, section sizes, numbers of imports/exports and so on, and stores all the stats in a `stats.json` file. After executing it on the directory with downloads from the previous step, the resulting JSON file was <a hreflang="en" href="https://cloud.google.com/bigquery/docs/batch-loading-data">imported into BigQuery</a> and <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/util/wasm_stats.sql">joined with the corresponding `summary_requests` and `summary_pages` tables</a> into `httparchive.almanac.wasm_stats` so that each record is self-contained and includes all the necessary information about the WebAssembly request, response and module contents. This final table was then used for all further analysis in this chapter.

Using crawler requests as a source for analysis has its own tradeoffs you need to be aware of when looking at the numbers in this article:

- First, we don't have information about requests that can be triggered by user interaction. We include only resources collected during the page load.
- Second, some websites are more popular than others, but we don't have precise visitor data and don't take it into account - instead, each detected Wasm usage is treated as equal.
- Finally, in graphs like sizes we count the same WebAssembly module used across multiple websites as unique usages, instead of comparing only unique files. This is because we are most interested in the global picture of WebAssembly usage across the web pages rather than comparing libraries to each other.

Those tradeoffs are most consistent with analysis done in other chapters, but if you're interested in gathering other statistics, you're welcome to run your own queries against the table `httparchive.almanac.wasm_stats`.

## How many modules?

We got 3854 confirmed WebAssembly requests on desktop and 3173 on mobile. Those Wasm modules are used across 2724 domains on desktop and 2300 domains on mobile, which represents 0.06% and 0.04% of all domains on desktop and mobile correspondingly.

Interestingly, when we look at the most popular resulting mime-types, we can see that while `Content-Type: application/wasm` is by far the most popular, it doesn't cover all the Wasm responses - good thing we included other URLs with `.wasm` extension too.

{{ figure_markup(
  caption="Top mime types.",
  description="Bar chart showing the distribution of most popular mime types. application/wasm accounts for 72.8% and 69.6% of WebAssembly requests on desktop and mobile correspondingly, application/octet-stream accounts for 13.1% and 14.2%, absent mime-type accounts for 10.5% and 12.7, text/plain accounts for 1.7% and 2% and the rest account for less than 1% each.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1635040165&format=interactive",
  sheets_gid="298942353",
  sql_file="mime_types.sql",
  image="mime_types.png"
  )
}}

Some of those used `application/octet-stream` - a generic type for arbitrary binary data, some didn't have any `Content-Type` header, and others incorrectly used text types like plain or HTML or even invalid ones like `binary/octet-stream`.

In case of WebAssembly, providing correct `Content-Type` header is important not only for security reasons, but also because it enables a faster streaming compilation and instantiation via [`WebAssembly.compileStreaming`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/compileStreaming) and [`WebAssembly.instantiateStreaming`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/instantiateStreaming).

## How often do we reuse Wasm libraries?

While downloading those responses, we've also deduplicated them by hashing their contents and using that hash as a filename on disk. After that we were left with 656 unique WebAssembly files on desktop and 534 on mobile.

{{ figure_markup(
  caption="Number of Wasm responses.",
  description="Bar chart showing numbers of total Wasm responses on desktop and mobile datasets as well as number of unique files. Number of unique files is much lower - only 656 out of 3854 total responses on desktop and 534 out of 3173 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=341129382&format=interactive",
  sheets_gid="1692581795",
  sql_file="counts.sql",
  image="counts.png"
  )
}}

The stark difference between the numbers of unique files and total responses already suggests high reuse of WebAssembly libraries across various websites. It's further confirmed if we look at the distribution of cross-origin / same-origin WebAssembly requests:

{{ figure_markup(
  caption="Cross-origin WebAssembly usage.",
  description="Bar chart showing that 55.2% of WebAssembly usages on desktop and 45.5% on mobile load modules from 3rd-party domains.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1239068211&format=interactive",
  sheets_gid="49966611",
  sql_file="cross_domain.sql",
  image="cross_domain.png"
  )
}}

Let's dive deeper and figure out what those reused libraries are. First, we've tried to deduplicate libraries by content hash alone, but it became quickly apparent that many of those left are still duplicates that differ only by library version.

Instead, we decided to extract library names from URLs. While it's more problematic in theory due to potential name clashes, it turned out to be a more reliable option for top libraries in practice. We extracted filenames from URLs, removed extensions, minor versions and suffixes that looked like content hashes, sorted the results by number of repetitions and extracted the top 10 modules for each client. For those left, we did manual lookups to understand which libraries those modules are coming from.

{{ figure_markup(
  caption="Popular libraries.",
  description="Bar chart showing top 10 libraries in desktop and mobile datasets, merged into one graph. Each library is shown along with percentage of Wasm requests that could be attributed to it. The list is as follows: Amazon IVS (30.3% on desktop and 28.7% on mobile), Hyphenopoly (13.2% and 18.9%), Blazor (3.5% and 5.0%), ArcGIS (3.7% and 3.6%), Draco (2.9% and 2.4%), CanvasKit (3.6% and 1%), Playa Games (3.3% on desktop only), Tableau (1.3% on desktop and 1.9% on mobile), Xat (1.5% and 1.4%), Tencent Video (2% on desktop only), Nimiq (0.5% and 1%), and Scandit (0.2% and 1.2%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1871029886&format=interactive",
  sheets_gid="1520429605",
  sql_file="popular_by_name.sql",
  image="popular_by_name.png"
  )
}}

Almost 1/3 of WebAssembly usages on both desktop and mobile belong to the <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon Interactive Video Service</a> player library. While it's not open-source, the inspection of the associated JavaScript glue code suggests that it was built with <a hreflang="en" href="https://emscripten.org/">Emscripten</a>.

The next up is <a hreflang="en" href="https://github.com/mnater/Hyphenopoly">Hyphenopoly</a> - a library for hyphenating text in various languages - that accounts for 13% and 19% of Wasm requests on desktop and mobile correspondingly. It's built with JavaScript and <a hreflang="en" href="https://www.assemblyscript.org/">AssemblyScript</a>.

Other libraries from both top 10 desktop and mobile lists account for up to 5% of WebAssembly requests each. Here's a complete list of libraries shown above, with inferred toolchains and links to corresponding homepages with more information:

- <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon IVS</a> (Emscripten)
- <a hreflang="en" href="https://mnater.github.io/Hyphenopoly/">Hyphenopoly</a> (AssemblyScript)
- <a hreflang="en" href="https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor">Blazor</a> (.NET)
- <a hreflang="en" href="https://developers.arcgis.com/javascript/latest/">ArcGIS</a> (Emscripten)
- <a hreflang="en" href="https://google.github.io/draco/">Draco</a> (Emscripten)
- <a hreflang="en" href="https://skia.org/docs/user/modules/canvaskit/">CanvasKit</a> (Emscripten)
- <a hreflang="en" href="https://www.playa-games.com/en/">Playa Games</a> (Unity via Emscripten)
- <a hreflang="en" href="https://help.tableau.com/current/api/js_api/en-us/JavaScriptAPI/js_api.htm">Tableau</a> (Emscripten)
- <a hreflang="en" href="https://xat.com/">Xat</a> (Emscripten)
- <a hreflang="en" href="https://intl.cloud.tencent.com/products/vod">Tencent Video</a> (Emscripten)
- <a hreflang="en" href="https://www.npmjs.com/package/@nimiq/core-web">Nimiq</a> (Emscripten)
- <a hreflang="en" href="https://www.scandit.com/developers/">Scandit</a> (Emscripten)

Few more caveats about the methodology and results here:

1. Hyphenopoly loads dictionaries for various languages as tiny WebAssembly files, too, but since those are technically not separate libraries nor are they unique usages of Hyphenopoly itself, we've excluded them from the graph above.
2. WebAssembly file from Playa Games seems to be used by the same game hosted across similarly-looking domains. We count those as individual usages in our query, but, unlike other items in the list, it's not clear if it should be counted as a reusable library.

## How much do we ship?

Languages compiled to WebAssembly usually have their own standard library. Since APIs and value types are so different across languages, they can't reuse the JavaScript built-ins. Instead, they have to compile not only their own code, but also APIs from said standard library and ship it all together to the user in a single binary. What does it mean for the resulting file sizes? Let's take a look:

{{ figure_markup(
  caption="Uncompressed response sizes.",
  description="Bar chart showing distribution of uncompressed response sizes on desktop and mobile at percentiles 0, 10, 25, 50, 75, 90 and 100. Most notably, minimum falls at 93 bytes in both desktop and mobile datasets, 10% at 1.3 KB, median at about 830 KB, 90% at 6.8 MB on desktop and 2.8 MB on mobile, and the maximum falls at 84 MB for both datasets.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=528882928&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="uncompressed_resp_sizes.png"
  )
}}

The sizes vary a lot, which indicates a decent coverage of various types of content - from simple helper libraries to full applications compiled to WebAssembly.

Sizes of up to 84 MiB look pretty concerning, but keep in mind those are uncompressed responses. While they're also important for RAM footprint and start-up performance, one of the benefits of Wasm bytecode is that it's highly compressible, and size over the wire is what matters for download speed and billing reasons.

Let's check sizes of raw response bodies as sent by servers instead:

{{ figure_markup(
  caption="Raw response sizes.",
  description="Bar chart similar to the one above, but showing distribution of raw response sizes as received from the server. 0% is still at 93 bytes for both, 10% is at 1.3 KB on desktop and 1 KB on mobile, median is around 300 KB, 90% is at 2.6 MB on desktop and 1.4 MB on mobile, and maximum is at 46 MB on desktop and 29 MB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1094358341&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="raw_resp_sizes.png"
  )
}}

The median is at around 300 KiB, meaning that half of usages download below 300 KiB, and half are larger. 90% of all Wasm responses stay below 2.6 MiB on desktop and 1.4 MiB on mobile. At the same time, the largest response in the HTTP Archive downloads about 46 MiB of Wasm on desktop and 29 MiB on mobile.

Even with compression, those numbers are still pretty extreme, considering that many parts of the world still don't have a high-speed internet connection. Aside from reducing the scope of applications and libraries themselves, is there anything websites could do to improve those stats?

### How is Wasm compressed in the wild?

First, let's take a look at compression methods used in these raw responses, based on `Content-Encoding` header. I'll show the mobile dataset here because on mobile bandwidth is even more important, but desktop numbers are pretty similar:

{{ figure_markup(
  caption="Compression methods.",
  description="Pie chart showing the distribution of compression methods on mobile. It shows that 45.6% of responses were shipped with gzip, 40.2% were uncompressed, 14.2% used Brotli, and insignificantly few used deflate.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1660946444&format=interactive",
  sheets_gid="189654676",
  sql_file="compression_methods.sql",
  image="compression_methods.png"
  )
}}

Unfortunately, it shows that ~40% of WebAssembly responses on mobile are shipped without any compression.

{{ figure_markup(
  content="40.2%",
  caption="Percent of uncompressed WebAssembly responses on mobile.",
  classes="big-number"
  )
}}

Another ~46% use gzip, which has been a de-facto standard method on the web for a long time, and still provides a decent compression ratio, but it's not the best algorithm today. Finally, only ~14% use Brotli - a modern compression format that provides an even better ratio and is supported <a hreflang="en" href="https://caniuse.com/brotli">in all modern browsers</a>. In fact, Brotli is supported in every browser that has WebAssembly support too, so there's no reason not to use them together.

### Can we improve compression?

Would it have made a difference? We've decided to recompress all those WebAssembly files with Brotli (compression level 9) to figure it out. The command used on each file was:

```bash
brotli -k9f some.wasm -o some.wasm.br
```

Here are the resulting sizes:

{{ figure_markup(
  caption="Sizes after Brotli compression.",
  description="Bar chart showing the distribution of sizes after manual Brotli recompression along various percentiles. Most notably, minimum falls at 74 bytes for both datasets, 10% at 784 bytes, median at about 250 KB, 90% at 2.3 MB on desktop and 870 KB on mobile, and maximum at 11.6 MB on both clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=2085720303&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="br_sizes.png"
  )
}}

The median drops from almost 300 KiB to 250 KiB, which is already a pretty good sign. The top 10% go down from 2.6 MiB / 1.4 MiB to 2.3 MiB / 0.8 MiB. We can see significant improvements across all other percentiles, too.

Due to their nature, percentiles don't necessarily fall onto the same files between datasets, so it might be hard to compare numbers directly between graphs and to understand the size savings. Instead, from now on, let me show the savings themselves provided by each optimization, step by step:

{{ figure_markup(
  caption="Brotli response savings.",
  description="Similar bar chart to the one above, but adjusted to show savings. 0% shows a 1.4 MB regression, 10% shows 253 bytes improvement on desktop and 19 bytes improvement on mobile, median shows 47 KB and 40 KB improvements on desktop and mobile, 90% at 610 KB on desktop and 335 KB on mobile, and maximum improvement at 36.4 MB / 22.4 MB on desktop and mobile correspondingly.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1741617577&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="br_savings.png"
  )
}}

Median savings are around 40 KiB. The top 10% save over 600 KiB on desktop and 335 KiB on mobile, and the largest savings produced reach as much as 36 MiB / 22 MiB. Those differences speak in favor of enabling Brotli compression whenever possible, at least for WebAssembly content.

You might be curious - what happened at the worst end - how is it possible that Brotli recompression has made things worse for some modules? As mentioned above, in this article we've used Brotli with compression level 9, but it also has levels 10 and 11. Those levels produce even better results in exchange for a steep performance drop-off, as seen, for example, in <a hreflang="en" href="https://quixdb.github.io/squash-benchmark/#results-table">Squash benchmarks</a>. Such trade-off can make them worse candidates for the common on-the-fly compression, which is why we didn't use them in this article and went for a more moderate level 9. However, website authors can choose to compress their static resources ahead of time or cache the compression results, and save even more bandwidth without sacrificing CPU time. Cases like these show up as regressions in the graph above, meaning some resources were already optimized even better than we did in this article.

### Which sections take up most of the space?

Compression aside, we could also look for optimization opportunities by analyzing the high-level structure of WebAssembly binaries. Which sections are taking up most of the space? To find out, we've summed up section sizes from all the Wasm modules and divided them by the total binary size. Once again, I'll use numbers from the mobile dataset here, but desktop numbers aren't too far off:

{{ figure_markup(
  caption="Section size distribution.",
  description="Pie chart showing the distribution of total binary size between various section kinds on mobile. Code accounts for 73.7%, data for 19.3%, custom sections for 6.5% and the rest take up insignificant portions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=683121338&format=interactive",
  sheets_gid="1082802229",
  sql_file="section_sizes.sql",
  image="section_sizes.png"
  )
}}

Unsurprisingly, most - ~74% - of the total binary size comes from the compiled code itself, followed by ~19% for embedded static data. Function types, import/export descriptors and such comprise a negligible part of the total size. However, one section type stands out - it's custom sections, which account for ~6.5% of total size in the mobile dataset.

{{ figure_markup(
  content="6.5%",
  caption="Portion of custom sections in the total binary size of mobile dataset.",
  classes="big-number"
  )
}}

Custom sections are mainly used in WebAssembly for 3rd-party tooling - they might contain information for type binding systems, linkers, DevTools and such. While all of those are legitimate use-cases, they are rarely necessary in production code, so such a large percentage is suspicious. Let's take a look at what they are in top 10 files with largest custom sections:

| URL                                                                                                                                               | Size of custom sections | Custom sections           |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- | ------------------------- |
| <a hreflang="en" href="https://gallery.platform.uno/package_85a43e09d7152711f12894936a8986e20694304a/dotnet.wasm">.../dotnet.wasm</a>                                      | 15,053,733             | name                      |
| <a hreflang="en" href="https://cdn.decentraland.org/@dcl/unity-renderer/1.0.12536-20210902152600.commit-86fe4be/unity.wasm.br?v=1.0.8874">.../unity.wasm.br?v=1.0.8874</a> | 9,705,643              | name                      |
| <a hreflang="en" href="https://nanoleq.com/nanoleq-HTML5-Shipping.wasmgz">.../nanoleq-HTML5-Shipping.wasmgz</a>                                                            | 8,531,376              | name                      |
| <a hreflang="en" href="https://convertmodel.com/export.wasm">.../export.wasm</a>                                                                                           | 7,306,371              | name                      |
| <a hreflang="en" href="https://webasset-akm.imvu.com/asset/c0c43115a4de5de0/build/northstar/js/northstar_api.wasm">.../c0c43115a4de5de0/.../northstar_api.wasm</a>                              | 6,470,360              | name, external_debug_info |
| <a hreflang="en" href="https://webasset-akm.imvu.com/asset/9982942a9e080158/build/northstar/js/northstar_api.wasm">.../9982942a9e080158/.../northstar_api.wasm</a>                              | 6,435,469              | name, external_debug_info |
| <a hreflang="en" href="https://superctf.com/ReactGodot.wasm">.../ReactGodot.wasm</a>                                                                                       | 4,672,588              | name                      |
| <a hreflang="en" href="https://ui.perfetto.dev/v18.0-591dd9336/trace_processor.wasm">.../v18.0-591dd9336/trace_processor.wasm</a>                                                          | 2,079,991              | name                      |
| <a hreflang="en" href="https://ui.perfetto.dev/v18.0-615704773/trace_processor.wasm">.../v18.0-615704773/trace_processor.wasm</a>                                                          | 2,079,991              | name                      |
| <a hreflang="en" href="https://unpkg.com/canvaskit-wasm@0.25.1/bin/profiling/canvaskit.wasm">.../canvaskit.wasm</a>                                                        | 1,491,602              | name                      |

All of those are almost exclusively the `name` section which contains function names for basic debugging. In fact, if we keep looking through the dataset, we can see that almost all of those custom sections contain just the debug information.

### How much can we save by stripping debug info?

While debug information is useful for local development, those sections can be hefty - they take up to 15 MiB before compression in the table above. If you want to be able to debug production issues users are experiencing, a better approach might be to strip the debug information out of the binary using `llvm-strip`, `wasm-strip` or `wasm-opt --strip-debug` before shipping, collect raw stacktraces and match them back to source locations locally, using the original binary.

Let's check how much stripping this debug information would save us in combination with Brotli, vs. just Brotli from the previous step:

{{ figure_markup(
  caption="strip-debug + Brotli savings.",
  description="Bar chart showing distribution of savings achieved by transformation described above. 0 percentile shows a tiny regression of 501 bytes, most others show no size change, 90% shows tiny improvements under 90 bytes on both desktop and mobile, but maximum achieved savings are at 2.4 MB on desktop and 1.3 MB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1943000224&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="strip_br_savings.png"
  )
}}

Most files in the archive already didn't have custom sections. In those that did, we could save up to 2.4 MiB / 1.3 MB for the largest Wasm binaries on desktop and mobile, which is a pretty noticeable improvement, especially on slow connections.

You might have noticed that the difference is a lot smaller than raw sizes of custom sections from the table above. The reason is that the `name` section, as its name suggests, consists mostly of function names, which are ASCII strings with lots of repetitions, and, as such, are highly compressible.

There are a few outliers where the process of removing custom sections with `llvm-strip` made some changes to the WebAssembly module that made it smaller before compression, but slightly larger after the compression. Such cases are rare though, and the difference in size is insignificant compared to the total size of the compressed module.

### How much can we save via wasm-opt?

`wasm-opt` from the <a hreflang="en" href="https://github.com/WebAssembly/binaryen">Binaryen</a> suite is a powerful optimization tool that can improve both size and performance of the resulting binaries. It's used in major WebAssembly toolchains such as Emscripten, wasm-pack and AssemblyScript to optimize binaries produced by the underlying compiler.

It provides significant size savings on both uncompressed and compressed real-world benchmarks:

{{ figure_markup(
  caption="wasm-opt uncompressed size benchmarks.",
  description="Bar chart showing wasm-opt size benchmarks across a wide variety of real-world modules such as base64, box2d, lua, sqlite, zlib, etc. The resulting sizes vary from 78% to, worst-case, 93% of the original. Median is at 89%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=724059342&format=interactive",
  sheets_gid="1763590037",
  image="wasm_opt_bench.png"
  )
}}

{{ figure_markup(
  caption="wasm-opt + Brotli size benchmarks.",
  description="Another bar chart showing same wasm-opt size benchmarks, but with Brotli compression applied to both original and resulting WebAssembly modules. Results vary from 83% to 99% with median at 91%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=2047888306&format=interactive",
  sheets_gid="1763590037",
  image="wasm_opt_br_bench.png"
  )
}}

We've decided to check the performance of wasm-opt on the collected HTTP Archive dataset as well, but there's a catch.

As mentioned above, wasm-opt is already used by most compiler toolchains, so most of the modules in the dataset are already its resulting artifacts. Unlike in compression analysis above, there's no way for us to reverse existing optimizations and run wasm-opt on the originals. Instead, we're re-running wasm-opt on pre-optimized binaries, which skews the results. This is the command we've used on binaries produced after the strip-debug step:

```bash
wasm-opt -O -all some.wasm -o some.opt.wasm
```

Then, we compressed the results to Brotli and compared to the previous step, as usual.

While the resulting data is not representative of real-world usage and not relevant to regular consumers who should use `wasm-opt` as they normally do, it might be useful to consumers like CDNs that want to run optimizations at scale, as well as to the Binaryen team itself:

{{ figure_markup(
  caption="wasm-opt + Brotli savings.",
  description="Bar chart showing the distribution of absolute size changes when wasm-opt + Brotli are executed against our modified datasets. The results are mixed - 0 percentile shows a 260 KB regression on desktop and 180 KB on mobile, 10% shows 27 KB and 6 KB regressions, median is at 3.6 KB / 0.6 KB regressions, 90% shows 513 bytes improvement on desktop and 77 bytes improvement on mobile, and maximum savings end up at 1 MB on desktop and almost 250 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=541095203&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="wasm_opt_br_savings.png"
  )
}}

There are significant savings in a small percentage of files that were not optimized before publishing on the web. But why are the other results so mixed?

If we look at the uncompressed savings, it becomes more clear that, even on our dataset, wasm-opt consistently keeps files either roughly the same size or still improves size slightly further in majority of cases, and produces significant savings for the unoptimized files.

{{ figure_markup(
  caption="Uncompressed wasm-opt savings.",
  description="Bar chart showing savings from running wasm-opt on the same datasets, but this time without Brotli. 0 percentile shows an insignificant regression of 3 bytes, 10% shows an insignificant improvement of 8 bytes on desktop and no change on mobile, median shows an improvement of 12 KB on both, 90% shows improvements of almost 100 KB on desktop and 47 KB on mobile, and maximum improvement achieved is at 3 MB on desktop and 1.2 MB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=270629181&format=interactive",
  sheets_gid="1401232418",
  sql_file="sizes_and_savings.sql",
  image="wasm_opt_savings.png"
  )
}}

This suggests several reasons for the surprising distribution in the post-compression graph:

1. As mentioned above, our dataset does not resemble real-world wasm-opt usage as the majority of the files have been already pre-optimized by wasm-opt. Further instruction reordering that improves uncompressed size a bit further, is bound to make certain patterns either more or less compressible than others, which, in turn, produces statistical noise.
2. Also as mentioned earlier, the network (compressed) size is not everything.
   Smaller WebAssembly binaries tend to mean faster compilation in the VM, less memory consumption while compiling, and less memory to hold the compiled code. wasm-opt has to strike a balance here, which might also mean that the compressed size might sometimes regress in favor of better raw sizes.
3. Finally, some regressions at the extreme end of the graph look like potentially valuable examples to study and improve that balance. We've <a hreflang="en" href="https://github.com/WebAssembly/binaryen/issues/4322">reported them back</a> to the Binaryen team so that they could look deeper into potential optimizations.

## What are the most popular instructions?

We've already glimpsed at the contents of Wasm when sliced by section kinds above. Let's take a deeper look at the contents of the code section - the largest and the most important part of a WebAssembly module.

We've split instructions into various categories and counted them across all the modules together:

{{ figure_markup(
  caption="Instruction kinds.",
  description="Pie chart showing distribution of instruction kinds as collected by the wasm-stats tool. Local variable operations account for 36% of instructions on mobile, constants for 15.2%, load/store operations for 14.7%, math, logic and other operations for 14.3%, control flow for 13.3%, direct calls for 4.6% and the rest are much smaller.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=1316275499&format=interactive",
  sheets_gid="1402848319",
  sql_file="instruction_kinds.sql",
  image="instruction_kinds.png"
  )
}}

One surprising takeaway from this distribution is that local var operations - that is, `local.get`, local.set`and`local.tee` - comprise the largest category - 36%, far ahead from the next few categories - inline constants (15.2%), load/store operations (14.7%) and all the math and logical operations (14.3%). Local var operations are usually generated by compilers as a result of optimization passes in compilers. They downgrade expensive memory access operations to local variables where possible, so that engines can subsequently put those local variables into CPU registers, which makes them much cheaper to access.

It's not actionable information for developers compiling to Wasm, but something that might be interesting to engine and tooling developers as a potential area for further size optimizations.

## What's the usage of post-MVP extensions?

Another interesting metric to look at is post-MVP Wasm extensions. While WebAssembly 1.0 was released several years ago, it's still actively developed and grows with new features over time. Some of those improve code size by moving common operations to the engines, some provide more powerful performance primitives, and others improve developer experience and integration with the web. On the official <a hreflang="en" href="https://webassembly.org/roadmap/">feature roadmap</a> we track support for those proposals across latest versions of every popular engine.

Let's take a look at their adoption in the Almanac dataset too:

{{ figure_markup(
  caption="Post-MVP extensions usage.",
  description="Bar chart showing total module counts along with numbers of modules using various post-MVP extensions. Total numbers, as mentioned in the beginning of the article, are at 3854 and 3173 on desktop and mobile correspondingly. Sign extension ops stand out and were found in a large number of those - 2938 on desktop and 2137 on mobile. The rest are so much lower that the graph had to use a logarithmic scale. Each of atomics, BigInt imports/exports, bulk memory, SIMD and mutable imports/exports proposals were found only in up to 30 modules on desktop and up to 21 modules on mobile. Proposals like multi-value, non-trapping float-to-int conversions, reference types and tail calls weren't found in any modules in either dataset.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT6yhkn3lw148YQQHLoqA71NIsZLSSoBtgFmd_hRyhcmyPl2OpLyuOjUBk64I5DLE_grN8esL8oA3zt/pubchart?oid=706910122&format=interactive",
  sheets_gid="1918192673",
  sql_file="proposals.sql",
  image="proposals.png"
  )
}}

One feature stands out - it's the <a hreflang="en" href="https://github.com/WebAssembly/sign-extension-ops/blob/master/proposals/sign-extension-ops/Overview.md">sign-extension operators proposal</a>. It was shipped in all browsers not too long after the MVP, and enabled in LLVM (a compiler backend used by Clang / Emscripten and Rust) by default, which explains its high adoption rate. All other features currently have to be enabled explicitly by the developer at compilation time.

For example, <a hreflang="en" href="https://github.com/WebAssembly/nontrapping-float-to-int-conversions/blob/master/proposals/nontrapping-float-to-int-conversion/Overview.md">non-trapping float-to-int conversions</a> is very similar in spirit to sign-extension operators - it also provides built-in conversions for numeric types to save some code size - but it became uniformly supported only recently with the release of Safari 15. That's why this feature is not yet enabled by default, and most developers don't want the complexity of building & shipping different versions of their WebAssembly module to different browsers without a very compelling reason. As a result, none of the Wasm modules in the dataset used those conversions.

Other features with zero detected usages - multi-value, reference types and tail calls - are in a similar situation: they could also benefit most WebAssembly use-cases, but they suffer from incomplete compiler and/or engine support.

Among the remaining, used, features, two that are particularly interesting are SIMD and atomics. Both provide instructions for parallelising and speeding up execution at different levels: <a hreflang="en" href="https://v8.dev/features/simd">SIMD</a> allows to perform math operations on several values at once, and atomics provide a basis for <a hreflang="en" href="https://web.dev/webassembly-threads/">multithreading in Wasm</a>. Those features are not enabled by default, require specific use-cases, and multithreading in particular requires using special APIs in the source code as well as additional configuration to make the website <a hreflang="en" href="https://web.dev/coop-coep/">cross-origin isolated</a> before it can be used on the web. As a result, a relatively low usage level is unsurprising, although we expect them to grow over time.

## Conclusion

While WebAssembly is a relatively new and somewhat niche participant on the web, it's great to see its adoption across a variety of websites and use-cases, from simple libraries to large applications.

In fact, we could see that it integrates so well into the web ecosystem, that many website owners might not even know they already use WebAssembly - to them it looks like any other 3rd-party JavaScript dependency.

We found some room for improvement in shipped sizes which, through further analysis, appears to be achievable via changes to compiler or server configuration. We've also found some interesting stats and examples that might help engine, tooling and CDN developers to understand and optimize WebAssembly usage at scale.

We'll be tracking those stats over time and return with updates in the next Web Almanac.
