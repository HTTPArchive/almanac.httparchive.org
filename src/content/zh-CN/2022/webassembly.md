---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: 2022 年 Web 年鉴的 WebAssembly 章节涵盖其用法、语言和 post-MVP 特性。
hero_alt: Hero image of Web Almanac characters performing scientific experiments on various code symbols resulting in 1s and 0s coming out the other end.
authors: [ColinEberhardt]
reviewers: [binji, RReverser]
analysts: [JamieWhitMac]
editors: [tunetheweb]
translators: [luckybai]
ColinEberhardt_bio: Colin 是 <a hreflang="en" href="https://www.scottlogic.com/">Scott Logic</a> 的 CTO，同时也是一个多产的技术作家、博客写作者以及一系列技术演讲人。他是 <a hreflang="en" href="https://www.finos.org/">FINOS</a> 的董事会成员, 这鼓励了金融部门的开源合作。他还在 GitHub 上非常活跃，为许多不同的项目做出了贡献。
results: https://docs.google.com/spreadsheets/d/11jyABro0fKtuN6INnYP9pJlv5QWwp0jfJyTsGfKgScg/
featured_quote: 尽管 WebAssembly 是一项小众技术，但它已经为 Web 带来了价值，有许多 Web 应用程序从这项技术中受益匪浅。
featured_stat_1: 383
featured_stat_label_1: 发现的独有的 WebAssembly 二进制文件
featured_stat_2: 34.9%
featured_stat_label_2: 使用 Amazon IVS 的移动端网站
featured_stat_3: 72.8%
featured_stat_label_3: 使用 Emscripten 脚本的模块
---

## 简介

WebAssembly（简写 Wasm）是 Web 技术家族（JavaScript、HTML、CSS）中相对较新的成员，于 2019 年 12 月成为 W3C 官方认可的标准。

WebAssembly 在浏览器中引入了一个新的运行时，该运行时与 JavaScript 运行时协同工作。相比之下，它更轻量，拥有少量的指令集以及严格的隔离模型（WebAssembly 默认没有 I/O）。开发 WebAssembly 的主要动机之一是为更多的编程语言（C++、Rust、Go 等）提供编译目标，允许开发人员使用更广泛的工具集开发新的 Web 应用程序或移植现有的应用程序。

WebAssembly 的高光示例包括它<a hreflang="en" href="https://blog.chromium.org/2019/06/webassembly-brings-google-earth-to-more.html">在 Google Earth 中的使用</a>，它的 C++ 桌面应用程序现在可以在浏览器中使用。基于浏览器的设计工具 <a hreflang="en" href="https://www.figma.com/blog/webassembly-cut-figmas-load-time-by-3x/">Figma</a> 使用该技术显著提高了其性能。最近 <a hreflang="en" href="https://web.dev/ps-on-the-web/">Photoshop</a> 也出于类似的原因在使用 WebAssemply。

## 研究方法

WebAssembly 作为编译目标，以二进制模块分发。因此，我们在分析其在网络上的使用时面临着许多挑战。2021 Web 年鉴中的 WebAssembly 是其第一版，其中详细地介绍了[研究方法](../../en/2021/webassembly#methodology)和相关注意事项。2022 年的调研结果采用了相同的方法，唯一的增强是新增了一种用于确定编写 WebAssembly 模块语言的机制，分析的准确性会在各自章节中详细介绍。

## WebAssembly 的使用范围有多广？

我们在桌面端和移动端应用程序中分别找到了 3204 个和 2777 个确认的 WebAssembly 请求，它们分别在 2524 个和 2216 个域名中使用，分别占各自域名的 0.06% 和 0.04%。

这表示我们在爬虫中发现模块的数量略有下降，桌面端和移动端请求分别减少了 16% 和 12%。但这并不一定意味着 WebAssembly 正在衰落，在解释这一变化时，以下几点值得注意：

- 虽然你可以使用 WebAssembly 创建各种基于 Web 的内容，但它的主要优势是在复杂业务线具有大型代码库的应用程序中使用，这些应用通常已有多年历史（例如 Google Earth、Photoshop、AutoCAD）。这些 Web “应用程序” 并不像网站那么多，同时由于 Almanac 的爬虫网络主要是基于一些不太使用 WebAssembly 的站点首页组成，所以它们也并不总是可以被统计到。
- 正如我们将在后面章节中看到的那样，大部分 WebAssembly 的使用都是来自于数量相对较少的第三方库。因此，这些库中的任何一个发生微小的变化都会对我们找到的模块数量产生重大影响。

我们发现在移动端浏览器中使用 WebAssembly 模块更少一些（-13%），但这并不是移动端浏览器 WebAssembly 功能的反映，移动端浏览器通常具有更好的支持。相反，更可能是因为[渐进式增强](https://developer.mozilla.org/docs/Glossary/Progressive_Enhancement)标准的实践。在这些场景中，越是高级功能需要 WebAssembly 反而不支持。

{{ figure_markup(
  caption="Wasm 响应数量",
  description="条形图显示了桌面端和移动端数据集上总的 Wasm 响应数以及去重文件数。去重文件的数量要低得多，在桌面端上 3204 个总响应中只有 383 个，在移动端上 2777 个响应中只有 310 个。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1842699031&format=interactive",
  sheets_gid="2142789475",
  sql_file="counts.sql",
  image="counts.png"
  )
}}

通过对 WebAssembly 模块进行哈希，我们可以确定桌面端应用中这 3204 个模块中有多少是独一无二的。通过消除重复模块，总数大约减少了 10 倍，其中有 383 个用于桌面浏览器，310 个用于移动端浏览器。这表明这些网站进行了大量的复用，且很可能是通过共享模块实现的。

Wasm 的请求中很大一部分是跨域的，这进一步说明了它们是被复用的。值得注意的是，与去年相比，这一比例显著增加（67.2% vs 55.2%）。

{{ figure_markup(
  caption="跨域 WebAssembly 的使用",
  description="条形图显示，在桌面端和移动端 WebAssembly 的使用中，跨域占比分别为 67.2% 和 60.9%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=2039142493&format=interactive",
  sheets_gid="491240617",
  sql_file="cross_domain.sql",
  image="cross_domain.png"
  )
}}

这些 WebAssembly 模块的大小差异很大，最小的只有几 KB，最大的为 7.3MB。更详细地看，在未压缩的大小上，我们可以看到大小的中位数（50%）为 835KB。

最小的 WebAssembly 模块可能用于非常特定的功能，例如抹平浏览器功能或者简单的加密任务。较大的模块可能是整个应用程序编译成 WebAssembly 格式。

{{ figure_markup(
  caption="未压缩的响应数据大小",
  description="条形图显示了桌面端和移动端设备上百分比分别为 25%、50%、75%、90% 的未压缩响应包大小的分布。最值得注意的是，有 10% 的响应大小为23 KB，中位数约为 835 KB，90% 的桌面端为 4.87 MB，移动端设备为 3.24 MB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=736723663&format=interactive",
  sheets_gid="1169986524",
  sql_file="module_sizes.sql",
  image="uncompressed_resp_sizes.png"
  )
}}

显然，WebAssembly 并没有被广泛使用，我们看到的不是使用量的增长，而是适度的收缩。

## WebAssembly 的用途是什么？

{{ figure_markup(
  caption="流行的 WebAssembly 库",
  description="条形图显示了桌面端和移动端数据集中流行前 10 的库及其 Wasm 请求百分比。名单如下：Amazon IVS（桌面端占 33.5%，移动端占 34.9%）、Hyphenopoly（8.2% 和 12.1%）、Blazor（6.2% 和 8.5%）、ArcGIS（6.7% 和 6.0%）、CanvasKit（7.7% 和 2.7%）、Tableau（5.2% 和 3.0%）、Draco（3.2% 和 3.1%）、Xat（1.6% 和 1.5%）以及 Hewlett-Packard Enterprise（HPE）（1.6% 和 0.8%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1535512737&format=interactive",
  sheets_gid="721946887",
  sql_file="popular_by_name.sql",
  image="popular_by_name.png"
  )
}}

- <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon IVS (Amazon Interactive Video Service)</a> - 在这里 WebAssembly 可能被用作视频编解码器，独立于用户浏览器的编解码器实现的一致的视频解码功能。
- <a hreflang="en" href="https://mnater.github.io/Hyphenopoly/">Hyphenopoly</a> - 这是一个 npm 模块，为 CSS 提供自动分词功能，核心算法通过 WebAssembly 模块提供，占用空间小，性能稳定。
- <a hreflang="en" href="https://dotnet.microsoft.com/zh-cn/apps/aspnet/web-apps/blazor">Blazor</a> - 微软 Blazor 是一个平台运行时和 UI 库，支持使用 .NET 平台和 C# 开发 Web 应用程序。
- <a hreflang="en" href="https://developers.arcgis.com/javascript/latest/">ArcGIS</a> - 一整套用于构建交互式地图应用程序的工具。性能是 ArcGIS 团队的首要关注点，他们使用各种技术（如 WebGL）来实现这一点。具体来说，WebAssembly 用于快速实现客户端效果。
- <a hreflang="en" href="https://skia.org/docs/user/modules/canvaskit/">CanvasKit</a> - 该库提供了比标准 Canvas2D API 更高级的功能，通过 Skia 实现的。Skia 是用 C++ 编写的图形库，它被编译为 WebAssembly，允许在浏览器中执行。
- <a hreflang="en" href="https://www.tableau.com/">Tableau</a> - 一款流行的用于构建交互式可视化的工具。目前尚不清楚 WebAssembly 是否在其核心产品中使用，还是仅用于爬虫发现的特定仪表盘页面中。
- <a hreflang="en" href="https://google.github.io/draco/">Draco</a> - 一个用于压缩和解压缩三维几何网格和点云的库。它是用 C++ 编写的，编译成 WebAssemby 在浏览器中使用。
- <a hreflang="en" href="https://xat.com/">Xat</a> - 一款社交媒体网站。目前尚不清楚他们使用 WebAssembly 是为了什么。
- <a hreflang="en" href="https://www.hpe.com/cn/zh/home.html">Hewlett Packard Enterprise</a> - 尚不清楚他们使用 WebAssembly 是为了什么。

通过了解流行的 WebAssembly 库，我们可以看到它的使用是非常有针对性的，通常用于特定的数字处理任务或者利用大型成熟的 C++ 代码库，无需移植到 JavaScript 就能将其功能应用到 Web 上。

## 大家都使用什么语言？

WebAssembly 是一种二进制格式，因此，许多源码相关的信息如编程语言、应用程序结构、变量名等会在编译过程中被混淆或者完全丢失。

不过，模块通常具有导出和导入，并在宿主环境（浏览器 JavaScript 运行时）中命名函数、描述模块的接口。大多数 WebAssembly 工具链都会创建少量的 JavaScript 代码用于 “绑定”，从而更容易地将模块集成到 JavaScript 应用程序中。这些绑定代码通常具有可识别的函数名，出现在模块导出或导入中，为识别用于编写模块的语言提供了可靠的机制。

我们增强了 <a hreflang="en" href="https://github.com/HTTPArchive/wasm-stats">wasm-stats</a> 项目，使得该项目能够为爬虫提供 WebAssembly 的分析，添加了能够检查导出/导入的代码，以此来识别一些能够为模块提供所用语言说明的常见模式。例如，如果一个模块导入了一个名为 `wbindgen` 的模块，这是对 <a hreflang="en" href="https://crates.io/crates/wasm-bindgen">wasm-bindgen</a> 生成的代码的引用，清楚地表明了该模块是用 Rust 编写的。

在某些情况下，导出/导入名称会压缩，使得识别源码语言变得更加困难。然而，Emscripten（一个 C++ 工具链）对于压缩的名称有一个独特的约定，这意味着我们可以相对确定显示这种模式的模块是使用 Emscripten 生成的。

{{ figure_markup(
  caption="WebAssembly 语言的使用",
  description="LikelyEmscripten（桌面端 63.8%、移动端 61.1%）、Unknown（11.7% 和 16.9%）、Emcripten（13.3% 和 11.8%）、Rust（8.0% 和 6.0%）、Blazor（2.7% 和 3.5%）以及 Go（0.6% 和 0.7%）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1942715596&format=interactive",
  sheets_gid="915015663",
  sql_file="language_usage.sql",
  image="language_usage.png"
  )
}}

查看结果我们发现，在桌面应用中 72.8% 的模块很可能是使用 Emscripten 创建的，因此很可能是用 C++ 编写的。其次是 Rust（6.0%），然后是 Blazor（C#）（3.5%）。此外我们还发现了少量用 Go 编写的模块。

值得注意的是，16.9% 的模块没有识别出其使用的编程语言。<a hreflang="en" href="https://www.assemblyscript.org/">AssemblyScript</a> 是一种流行的专门用于编写 WebAssembly 的语言，它在生成的模块中是没有提供任何明显线索的。我们知道占所有模块 8.2% 的 Hypehnopoly 是使用 AssemblyScript 的实现的，它几乎占这些未识别模块的一半。

将这些结果与 <a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">2022 年 WebAssembly 调研</a>进行对比就非常有意思了，报告中显示 Rust 是最常用的语言。这是因为在那项调研中的大量受访者是将 WebAssembly 用于非浏览器应用程序的。

## 哪些功能被使用？

WebAssembly 的初始版本被视为 MVP，与其它的 Web 标准一样，它在万维网联盟（W3C）的管理下不断发展。今年 W3C 发布了 <a hreflang="en" href="https://www.w3.org/TR/wasm-core-2/">WebAssembly v2 草案</a>，增加了一些新功能。

{{ figure_markup(
  caption="WebAssembly Post-MVP 功能使用",
  description="条形图显示了模块总数以及使用各种 post-MVP 扩展的模块数量。如本文开头所述，桌面端和移动端设备上的总数分别为 3204 和 2777。Sign extension 的使用非常多，在大量的应用程序中都可以找到 —— 桌面端上 2850 个，移动端上 2378 个。其余扩展的使用则非常低，在条形图上几乎看不到。Atomics、BigInt import/export、Bulk memory、SIMD 以及 Mutable import/export 在桌面端和移动端上多的分别能在 38 个和 28 个模块中找到。有些提案则在数据集中就没有发现，比如多值 multi-value、非陷阱浮点到整数转换、引用类型和尾部调用等。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1935172150&format=interactive",
  sheets_gid="1865524955",
  sql_file="proposals.sql",
  image="proposals.png"
  )
}}

我们查看了正在使用的 Post-MVP 的功能后发现，符号扩展 _sign extension_（一种相对简单的增强，添加运算符，允许将整数值扩展到更大的 bit-depth）是目前最常用的。这与[去年的分析结果](../../en/2021/webassembly#whats-the-usage-of-post-mvp-extensions)没有显著差异。

值得注意的是，虽然 Web 开发人员面临着使用 HTML/JavaScript/CSS 中哪些功能的选择，但对于 WebAssembly 而言，这通常是由工具链开发人员做出决定。因此，当一个工具链确定了一个 Post-MVP 功能现在是一个可行的选项时，我们可能会看到它会被直接采用。

## 总结

不可否认，WebAssembly 在 Web 中是以小众技术出现的，而且它很有可能永远是。虽然 WebAssembly 为 Web 带来了很多语言 —— C++、Rust、Go、AssemblyScript、C# 等，但这些语言还不能与 JavaScript 互转。对于绝大多数内容偏静态（用 HTML 和 CSS 呈现）、交互性适中（通过 JavaScript）的网站而言，目前根本没有令人信服的理由来使用 WebAssembly。

有一些重要的提议可能在将来改变这一现状。最初的 WebIDL 被接口类型（Interface Types）取代，而接口类型又一次被组件模型（Component Model）规范取代。虽然现在 JavaScript 与任何其它编程语言互转都是不可行的，但未来是有可能实现的。

尽管 WebAssembly 是一项小众技术，但它已经为 Web 带来了价值，有许多 Web 应用从这项技术中受益匪浅。不过，这些 Web 应用程序通常对本次调研使用的爬虫是不可见的。

最后，WebAssembly 运行时的核心功能（多语言、轻量级、安全）使其成为更广泛的非浏览器应用的非常受欢迎的选择。通过 <a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">WebAssembly 2022 现状调查</a>可以看到，在 serverless、容器化以及插件化应用程序中使用该技术的人数显著增加。在未来 WebAssembly 可能会继续作为一种小众的 Web 技术，但会在广泛的其它平台上成为主流的运行时。
