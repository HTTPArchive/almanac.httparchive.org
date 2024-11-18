---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 性能
description: 2020年 Web 年鉴性能篇，涵盖了网页核心指标、Lighthouse 性能评分、首次内容绘制（FCP）、首字节时间（TTFB）。
hero_alt: Hero image of Web Almanac characters images to a web page, while another Web Almanac character times them with a stopwatch.
authors: [thefoxis]
reviewers: [borisschapira, rviscomi, foxdavidj, noamr, Zizzamia, exterkamp]
analysts: [max-ostapenko, dooman87]
editors: [tunetheweb]
translators: [Zuckjet]
thefoxis_bio: Karolina 是 <a hreflang="en" href="https://calibreapp.com/">Calibre</a> 产品设计主管，致力打造最全面的速度监测平台。她创办了性能期刊，也就是你平时看到的性能简讯的来源。Karolina <a hreflang="en" href="https://calibreapp.com/blog/category/web-platform">也经常发表</a>关于性能如何影响用户体验的文章。
discuss: 2045
results: https://docs.google.com/spreadsheets/d/164FVuCQ7gPhTWUXJl1av5_hBxjncNi0TK8RnNseNPJQ/
featured_quote: 性能差不仅会导致挫败感或对用户转化产生负面影响，也给现实生活带来障碍。今年的全球疫情使得这些存在的障碍更加明显。
featured_stat_1: 25%
featured_stat_label_1: FCP 性能良好的站点
featured_stat_2: 18%
featured_stat_label_2: TTFB 性能良好的站点
featured_stat_3: 4%
featured_stat_label_3: Lighthouse v6 评分不变的站点
---

## 介绍

毫无疑问，网站加载速度慢会对整体的用户体验有不良影响，进而导致较低的转化率。但性能差不仅会导致挫败感或对业务目标造成不良影响，也给现实生活带来障碍。今年的全球疫情<a hreflang="en" href="https://www.weforum.org/agenda/2020/04/coronavirus-covid-19-pandemic-digital-divide-internet-data-broadband-mobbile/">使得这些存在的障碍更加明显</a>。随着远程学习、工作、社交的转变，我们的整个生活突然转移到了网上。较差的网络连接和缺乏功能齐全的设备使得这一转变极为痛苦，然而对于很多人来说，就连这些条件都不具备。这是一次真正的测试，凸显了全球范围内网络连接、设备以及网速的不平等。

性能工具不断发展，以描绘用户体验的各个方面，并使发现潜在问题变得更加容易。自[去年性能章节](../2019/performance)发布后，该领域有许多重大发展，已经改变了我们监控速度的方式。

随着流行的质量审计工具 Lighthouse 6 的重大版本发布，<a hreflang="en" href="https://calibreapp.com/blog/how-performance-score-works">著名的性能评分算法发生了重大改变</a>, 因此总评分机制也随之发生了改变。<a hreflang="en" href="https://calibreapp.com/blog/core-web-vitals">网页核心指标</a>，即一系列新的度量标准去描述不同方面的用户体验，也一同发布了。它将来会成为搜索排名的因素之一，这会使得社区开发者的注意力转移到这些新的速度指标。

在本章中，我们将通过这些新的发展来查看由<a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome 用户体验报告 (CrUX)</a>提供的真实性能数据，以及分析一些其他相关指标。需要注意的是由于 iOS 的限制，CrUX 移动端统计结果不包含运行苹果移动操作系统的设备。这毫无疑问会影响我们的分析，尤其是在检查每个国家的性能指标时。

让我们继续深入吧。

## Lighthouse 性能评分

2020年5月，<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/releases/tag/v6.0.0">Lighthouse 6 发布</a>。这个流行的、新的主要版本性能评审套件，对它的性能评分算法做了显著的改变。性能得分是对站点速度的概况性描述。在 Lighthouse 6 中，分数通过“六不五法则”来测量：首次有意义的绘制和首次 CPU 空闲被移除了，取而代之的是最大内容绘制、总阻塞时间（TBT，等价于实验性的首次输入延迟）和累计布局偏移（CLS）。

新的评分算法优先考虑新一代的性能指标：网页核心指标。与此同时，降低了首次内容绘制、可交互时间以及页面可见区域平均渲染时间的评分权重。该算法明确强调了用户体验的三个方面：*交互性*（总阻塞时间和可交互时间），*视觉稳定性*（累计页面偏移）和*感知性*（首次内容绘制，可见区域渲染平均时间，最大内容渲染）。

另外，该评分机制会对桌面端和移动端应用使用不同的参考标准。这意味着该机制对于桌面应用的要求不会过于宽松、对移动应用的要求不至于太严格（因为移动端 benchmark 性能评分要低于桌面端应用）。你可以比较一下 Lighthouse 5 和 6 在<a hreflang="en" href="https://googlechrome.github.io/lighthouse/scorecalc/">Lighthouse 计分器</a>中分数的不同，看这些分数到底是如何改变的。

{{ figure_markup(
  image="performance-change-in-lighthouse-score.png",
  caption="Lighthouse 5和6的性能得分差异。",
  description="柱形图显示了 Lighthouse 5和6之间性能得分的变化。最高比例的网站（4%）没有观察到分数的变化，分数下降的网站数量超过了分数提高的网站。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=786955541&format=interactive",
  sheets_gid="518150031",
  sql_file="lh6_vs_lh5_performance_score_02.sql"
  )
}}

由上我们观察到4%的站点性能评分没有变化，但是负面变化的网站超过了得分改善的网站。性能评分等级变得更糟（下降曲线最明显的是10-25点区间）,下图更为直接地描述了这一点：

{{ figure_markup(
  image="performance-lighthouse-score-distributions-yoy.png",
  caption="Lighthouse 5和6性能得分分布",
  description="散点图显示了在Lighthouse 5和6中获得0-100性能得分的网站百分比。使用Lighthouse 6算法，得分在0-25之间的网站百分比上升，得分在50到100之间的网站数量减少。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=926035471&format=interactive",
  sheets_gid="1303574513",
  sql_file="lh6_vs_lh5_performance_score_distribution.sql"
  )
}}

在 Lighthouse 5 and Lighthouse 6 的比较中，我们可以直接观察到分数分布发生了怎样的改变。在Lighthouse 6中，我们观察到网页评分在0-25分之间的比例有所上升，在50-100分之间有所下降。而在 Lighthouse 5 中，我们看到 3% 的页面得到100分，但是在Lighthouse 6中100分比例下降到1%。

考虑到算法的大量修正，这些全面的改变并不意外。

## 页面关键指标：最大内容绘制

最大内容绘制（LCP）是一个具有里程碑意义的基于时间的度量指标，它表明了最大的<a hreflang="en" href="https://web.dev/articles/lcp#what-elements-are-considered">页面可见区域元素</a>渲染时间。

### 按设备类型看 FCP

{{ figure_markup(
  image="performance-lcp-by-device.png",
  caption="按设备类型分类的 LCP 总性能。",
  description="条形图显示53％的桌面设备和43％的移动网站体验被归类为良好。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=696629857&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

在上面的图表中，我们可以观察到43%-53%的站点有不错的 LCP 性能（低于2.5秒）：绝大部分站点都设法尽可能加载关键的、页面可见区域的资源。对于一个相对较新的评分指标而言，这是一个积极的信号。桌面端和移动端轻微的差异可能是由于网速、设备性能和图片大小导致的。（大的、适用于桌面端的图片会花费较长时间去下载和渲染）。

### 按地理位置看 FCP

{{ figure_markup(
  image="performance-lcp-by-geo.png",
  caption="按国家分类的 LCP 总性能。",
  description="条形图显示，LCP 评分为良好的的最高百分比分布在欧洲和亚洲国家之间。韩国以76％的良好浏览体验领先，而印度以16％的良好浏览体验排名倒数第二。.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1936626175&format=interactive",
  width="645",
  height="792",
  sheets_gid="263037691",
  sql_file="web_vitals_by_country.sql"
  )
}}

最高比例的表现良好的 LCP 浏览体验主要集中分布在欧洲和有着76%良好浏览体验的韩国为首的亚洲国家。据<a hreflang="en" href="https://www.speedtest.net/global-index">Speedtest Global Index</a>报导，十月份韩国下载速度高达145Mbps，在移动端的网速一直领先。日本、捷克、台湾、德国和比利时等一些国家或地区的移动端网速也比较快。澳大利亚尽管在移动端网速方面领先，但是在桌面端连接速度慢和延迟令人失望，使得他的排名在上述国家之后。

在我们的调查数据中，印度依然保持着最后一名，仅有16%的良好体验。尽管新的互联网用户正在持续增长，移动端和桌面端的网速<a hreflang="en" href="https://www.opensignal.com/reports/2020/04/india/mobile-network-experience">仍然是个问题</a>，4G平均下载速度是10Mbps、3G平均下载速度是3Mbps、桌面端下载速度低于50Mbps。

### 按连接类型看 FCP

{{ figure_markup(
  image="performance-lcp-by-connection-type.png",
  caption="按国家分类的 LCP 总性能。",
  description="条形图显示48％的网站在4G上具有良好的LCP。评级良好的网站数量在3G上下降到8％，在2G上下降到1％，在慢速2G上下降到0％，在离线连接上下降到18％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=97874305&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

由于 LCP 指的是最大的首屏元素（包括图片、视频或包含文本的块级元素）渲染出来的时间，因此网速越慢、评测得分越差也就不足为奇了。

网速和更好的 LCP 性能之间有明确的相关性，但即便是4G网络，仍然只有48%的统计结果被归为良好，也就意味着有一半的站点的浏览体验需要改进。自动媒体优化、提供正确的尺寸和格式、同时针对低数据模式的优化，将会帮助我们实现优化目标。更多内容请参见<a hreflang="en" href="https://web.dev/articles/optimize-lcp">LCP 优化指南</a>

## 网页核心指标：累计布局偏移

累计布局移动（CLS）量化了在页面访问过程中，视口内有多少元素移动了。它描述了网站出现的意外的偏移程度，以此来对用户体验进行评分，而不是试图去借助秒或毫秒这样的的单位来测量一个特定的交互部分。它有助于查明网站上发生意外移动的程度，从而对用户体验进行评级，而不是试图借助于秒或毫秒等单位来衡量交互的特定部分。

从这个角度来说，CLS 与本章提到的其他指标相比，是一种不同的、新型的用户体验整体性指标。

### 按设备类型查看 CLS

{{ figure_markup(
  image="performance-cls-by-device.png",
  caption="按设备类型分类的 CLS 总性能。",
  description="条形图显示，超过一半的网站具有良好的 CLS，其中桌面端为54％，移动端为60％。在这两种情况下，只有21％的网站的 CLS 被评为差。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1672696367&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

根据 Chrome 用户体验数据，桌面端和移动端设备，超过一半的网站有着良好的 CLS 评分。桌面端和移动端表现良好比例的网站略有差别（6个百分点），后者稍高一些。 我们可以推测，移动端之所以在 CLS 评分中良好比例领先，是因为对于移动端站点的优化我们通常采取的策略是削弱它的功能和视觉效果。

### 按地理位置查看 CLS

{{ figure_markup(
  image="performance-cls-by-geo.png",
  caption="按国家分类的 CLS 总性能",
  description="条形图显示，排名前28位的国家/地区至少有50％的网站报告了良好的 CLS 评分。中等（需要改进）的浏览体验总体稳定在11-15％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1861585123&format=interactive",
  width="645",
  height="792",
  sheets_gid="47865955",
  sql_file="web_vitals_by_country.sql"
  )
}}

CLS 在不同地域的表现总体上是好的，至少有56%的网站获得了良好的评价。对于可感知的视觉稳定性来说，这是一个极好的消息。我们可以观察到类似的国家处于领先地位，正如我们在 LCP 地理分布中看到的那样--韩国、日本、捷克、德国、波兰。

相对于其他指标，比如 LCP，视觉稳定性受地理和延迟的影响较小。排名最好的国家和排名最差的国家之间的百分比差距，在 LCP 指标上达到了61%，在 CLS 指标上达到了13%。中等评分的网站比例在整个网站中相对较低，让位于整个网站中19%-29%的差体验。导致CLS差的因素有很多--在<a hreflang="en" href="https://web.dev/articles/optimize-cls">优化累积布局转移指南</a>中了解如何解决这些问题。整体而言，中等评分网站的比例最低，甚至低于19%-29的最差用户体验的比例。有许多因素都可能导致较差的CLS，请在<a hreflang="en" href="https://web.dev/articles/optimize-cls">优化累积布局偏移指南</a>中了解如何解决这些问题。

### 按连接类型查看 CLS

{{ figure_markup(
  image="performance-cls-by-connection-type.png",
  caption="按连接类型分类的 CLS 总性能",
  description="条形图显示良好、需要改进和较差的 CLS 评分分布均匀。离线和4G领先，分别拥有70％和64％的良好体验",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=151288279&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

除离线和4G外，大多数连接类型的 CLS 评分都是合理的均匀分布。在离线场景下，我们可以推测网站应该是使用了 Service Worker。因此，不会因连接类型而导致下载延迟，而下载延迟却是对站点获得良好评分有着至关重要的影响。

对4G得出明确的结论是具有挑战性的，但我们可以推测，也许4G+连接是作为桌面设备的一种上网方式。如果这一假设成立，网络字体和图像可能会被大量缓存，这对 CLS 测量产生了积极影响。

## 网页核心指标: 首次输入延迟

首次输入延迟（FID）指的是用户第一次交互和浏览器能够响应该交互之间的时间。FID 是衡量网站交互性的一个很好的指标。

### 按设备分类查看 FID

{{ figure_markup(
  image="performance-fid-by-device.png",
  caption="按设备类型分类的 FID 总性能",
  description="条形图显示了在台式机（100％）和移动设备（80％）上良好 FID 性能的百分比很高。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2090682651&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

在如此高比例的网站都有良好的性能评分是非常少见的的。在桌面端，基于网站分布的第75个百分位中100%的网站全部获得了快速 FID 评级，这意味着经历交互延迟的人数非常少。

在移动设备上，有80％的网站被评为良好。一个可能的解释是，与台式机相比，CPU 功能降低，移动设备的网络延迟（导致脚本下载和执行延迟）以及电池效率和温度限制，从而限制了移动设备的 CPU 潜力。所有这些都直接影响交互性指标，例如 FID。

### 按地理位置查看 FID

{{ figure_markup(
  image="performance-fid-by-geo.png",
  caption="按国家分类的 FID 总性能",
  description="条形图显示了每个国家/地区良好的 FID 性能。前28个国家/地区报告的良好的 FID 体验介于79％至97％之间，几乎没有被评为差体验的。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1107653062&format=interactive",
  width="645",
  height="792",
  sheets_gid="2120295762",
  sql_file="web_vitals_by_country.sql"
  )
}}

FID 评分的地理分布图证实了前面设备汇总图的发现。在最差的情况下，79%的网站有良好的 FID，其中97%的网站排名靠前，韩国再次领先。有趣的是，CLS 和 LCP 排名较好的国家，如捷克、波兰、乌克兰和俄罗斯联邦在这里的排名都掉到了最后。

再次申明，我们可以推测为什么会这样，但需要进一步分析才能真正确定。假设 FID 与 JavaScript 执行能力相关，那么功能更强大的设备价格更高，甚至被作为奢侈品的国家/地区，其 FID 排名可能会更低。波兰就是一个很好的例子，与美国市场相比，波兰是<a hreflang="en" href="https://qz.com/1106603/where-the-iphone-x-is-cheapest-and-most-expensive-in-dollars-pounds-and-yuan/"> iPhone 价格最高的国家之一</a>，再加上[相对较低的工资](https://en.wikipedia.org/wiki/List_of_European_countries_by_average_wage#Net_average_monthly_salary)，单个人的薪资是不足以购买苹果的旗舰产品的。相反，以澳大利亚的<a hreflang="en" href="https://www.news.com.au/finance/average-australian-salary-how-much-you-have-to-earn-to-be-better-off-than-most/news-story/6fcdde092e87872b9957d2ab8eda1cbd">平均薪资</a>，能够以一周的工薪购买一部苹果设备。幸运的是，评分较低的网站的百分比通常为0，只有1-2％的浏览例外，这表明该网站对交互的响应相对较快。幸运的是，评分低的网站比例大多为0，少数例外有1-2%的较差评分，这说明绝大部分网站对交互的响应都很及时。

### 按连接类型查看 FID

{{ figure_markup(
  image="performance-fid-by-connection-type.png",
  caption="按连接类型分类的 FID 总性能",
  description="条形图显示了在不同类型的网络中始终保持高分布的良好的 FID 性能。离线，3G和4G拥有超过80％的良好网站体验。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=808962538&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

我们可以观察到网速和快速的 FID 有着直接的关联，从2G的73%上升到4G的87%。更快的网络将有助于加快脚本文件的下载，使得浏览器可以提前解析，并减少主线程的阻塞任务。看到这样的结果是乐观的，尤其是当评级为差的网站体验的比例不超过5%的时候。

## 首次内容绘制

首次内容绘制（FCP）测量的是浏览器首次渲染任何文本、图片、非白色画布和 SVG 内容的时间。FCP 是一个很好的速度感知指标，因为它描述了人们需要等待网站加载多久才能看到有意义的内容。

### 按设备查看 FCP

{{ figure_markup(
  image="performance-fcp-desktop-distribution.png",
  caption="标注在桌面端 FCP 性能快、一般、慢的网站分布",
  description="标注在桌面端 FCP 性能快、一般、慢的网站分布。评级为快速的网站的分布呈线性，中间呈凸起状。与2019年相比，更快的 FCP 体验和 更慢的 FCP 体验均有所增长。而由于 FCP 评级的变化，中等体验数量有所减少。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1953305743&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

{{ figure_markup(
  image="performance-fcp-mobile-distribution.png",
  caption="标注在移动端 FCP 性能快、一般、慢的网站分布",
  description="标注在移动端 FCP 性能快、一般、慢的网站分布。快速网站的分布呈线性，中间有少量凸起。2019年相比，更快的 FCP 体验和 更慢的 FCP 体验均有所增长。而由于 FCP 评级的变化，中等体验数量有所减少。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=38297781&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

在上图中，FCP 的分布被分为桌面端和移动端两个类别。[和上一年相比](../2019/performance#fcp-by-device)，中等 FCP 浏览体验明显下降，然而不管什么类型的设备，快速和慢速的用户体验的百分比都在上升。我们仍然可以观察到相同的趋势，即移动端用户比桌面端用户经历了更多的慢 FCP。总体而言，用户更有可能经历更好的或更差的用户体验，而不是中等的用户体验。

{{ figure_markup(
  image="performance-fcp-mobile-year-on-year.png",
  caption="比较了2019年至2020年之间 FCP 性能被标记为良好、需要改进和较差的网站的分布情况。",
  description="条形图显示了2019年至2020年之间 FCP 性能被标记为良好、需要改进和较差的网站的分布情况。在2020年，75％的网站的 FCP 低于标准值。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2037503700&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

逐年比较移动设备上的 FCP，我们发现良好的用户体验较少，而中等或者较差的用户体验居多。 75％的网站的 FCP 低于标准值。我们可以推测，高比例的低于理想 FCP 的站点是造成用户体验下降的原因。

许多因素都会导致浏览器绘制的延迟，比如服务端延迟（通过一些指标来衡量，比如[首字节时间（TTFB）](#首字节时间)和 RTT)，阻塞的 JavaScript 请求，或者对自定义字体的不当处理等等。

### 按地理位置查看 FCP

{{ figure_markup(
  image="performance-fcp-by-geo.png",
  caption="按国家分类的 FCP 总性能",
  description="条形图显示，在28个国家中，只有7个拥有40％以上的 FCP 性能良好的网站。由于 FCP 值范围的变化，与2019年相比，良好和较差的评分数量都有所增加。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=78259488&format=interactive",
  sheets_gid="1708427314",
  width="645",
  height="792",
  sql_file="web_vitals_by_country.sql"
  )
}}

在深入分析之前，值得一提的是，在2019年的性能章节中，"好 "和 "差 "的分类门槛与2020年有所不同。在2019年，FCP 低于1s的站点被认为是好的，而 FCP 高于3s的站点则被归类为差。在2020年，这些范围转变为1.5s为好，2.5s为差。

这种变化意味着评分将更多的转向“好”和“差”的评级网站，我们可以通过对比去年的结果观察到这个趋势，因为良好的网站和差的网站的比例都有所上升。与2019年相比，被评级为快速网站的比例最高的前十名，地域分布相对来说没有改变，捷克和比利时比例有所增长，美国和英国则略有下降。韩国以62%的快速 FCP 领先，自去年以来几乎翻了一番（这同样可能是由于评分规则改变导致的结果）。排名靠前的其他国家的良好体验数量也增加了一倍。

虽然评级为中等("需要改进")的比例变小了，但 FCP 性能不佳的网站数量却上升了，这一点在拉美和南亚地区的排名中尤为明显。

再次申明，有很多因素会对 FCP 产生负面影响，比如较差的 TTFB 浏览，但如果没有必要的背景，很难证明这些原因。例如，如果我们要分析具体国家的性能评分，比如澳大利亚，我们发现它竟然处于排名靠后的位置。澳大利亚是全球智能手机普及率最高的国家之一，也是移动网络最快的国家之一，平均收入水平也相对较高。我们很容易认为它应该更高。然而，考虑到缓慢的宽带连接、延迟和 Chrome 用户体验数据中缺少 iOS 的性能，它的排名开始变得更加合理。通过这样的例子（仅从表面看），我们可以看到理解每个国家的背景是多么困难。

### 按连接类型查看 FCP

{{ figure_markup(
  image="performance-fcp-by-connection-type.png",
  caption="按国家分类的 FCP 总性能",
  description="条形图显示，在4G网络中只有31％的网站 FCP 是良好。在离线状态下，该数量减少到10％，而其余的连接类型几乎只能提供较差的 FCP 体验。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1949864731&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

和其他指标相似，FCP 会被连接速度影响。在3G网络中，只有2%的体验是良好，而在4G网络中，达到了31%。它不是 FCP 性能的理想状态，但是[自2019年以来已经有改进](../2019/performance#fcp-by-effective-connection-type)，这可能又是和站点被评定为良好和差的标准的更改有关。我们看到好的站点和差站点的比例都有一样的增长，这减少了中等（需要改进）体验的网站数目。

这个趋势说明了数字鸿沟在不断加剧，用户体验在较慢的网络和较差性能的设备上会一直恶化。在较慢连接的场景中提高 FCP 和增强 TTFB 是正相关的，这在[通过连接类型汇总 TTFB 性能图标](#按连接类型查看-ttfb)中可以观察到，也就是说较差的 TTFB 等同于较差的 FCP。

<a hreflang="en" href="https://ismyhostfastyet.com/">主机提供商</a>或<a hreflang="en" href="https://www.cdnperf.com/">内容分发网络</a>的选择将会对速度有叠加的影响。尽可能选择最快伺服的主机提供商和内容分发网络，将会对提高 FCP 和 TTFB 有帮助，特别是在较慢的网络状况下。字体加载时间也很大程度上影响了 FCP，因此，<a hreflang="en" href="https://web.dev/font-display/">确保字体加载过程中页面文本仍然可见</a>是一个有价值的策略（特别是在连接速度较慢的情况下，这些资源的获取成本很高）。

查看“离线”统计数据，我们可以推断出大量 FCP 问题也与网络类型不相关。如果这一说法是正确的，我们将不会在这一类别中获得重大收益。似乎渲染并不会因为获取 JavaScript 资源文件而受到较大延迟，但是它受解析和执行的影响。

## 首字节时间

首字节时间（TTFB）指的是初始的 HTML 请求到浏览器接收到第一个字节的时间。能否快速处理请求的问题会迅速影响其他性能指标，因为它们不仅会延迟绘制，还会延迟任何资源的获取。

### TTFB 设备分类

{{ figure_markup(
  image="performance-ttfb-by-device.png",
  caption="按设备类型分类的 TTFB 总性能",
  description="条形图显示，有76％的网站在桌面端上的 TTFB 较差，在移动设备上这一比例为83％。具有良好TTFB的网站数量不超过24％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1981576071&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

在桌面端，76%的站点有着不太好的 TTFB，然而在移动端，这个比例上升到了83%。我们可以假设这个数据描述了 TTFB 是一个通常被忽略的指标，大多数性能测量和工作都集中在了前端和视觉渲染，而不是资源伺服和服务端工作。高 TTF 将对大量其他性能指标产生直接的负面影响，而这仍然是需要解决的问题。

### TTFB 地理位置分布

{{ figure_markup(
  image="performance-ttfb-by-geo.png",
  caption="按国家分类的 TTFB 总性能",
  description="条形图显示 TTFB 的性能始终低于标准，在28个国家中，只有4个拥有超过30％的 TTFB 良好的网站。有大量的网站被归类为需要改善（始终高于40％），不良体验的比例随着排名的降低而上升。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1135415956&format=interactive",
  width="645",
  height="792",
  sheets_gid="1440255644",
  sql_file="web_vitals_by_country.sql"
  )
}}

今年的 TTFB 地理分布图和[2019年结果](../2019/performance#ttfb-by-geo)相似，都表明了有更多的站点变快了，但是和 FCP 相似，阈值都发生了改变。以前，我们认为 TTFB 在200ms以下为快，而在1000ms以上为慢。 2020年，低于500ms的 TTFB 被归类为良好，高于1500ms的 TTFB 被归类为较差。这些评级方面的许多变化可以解释我们观察到的重大改变，比如韩国有着良好用户体验的站点增加了36％，台湾增加了22%。总体上，我们仍然看到了一些和往年的相似点，例如亚太地区和某些欧洲地区仍然处于领先地位。

### 按连接类型查看 TTFB

{{ figure_markup(
  image="performance-ttfb-by-connection-type.png",
  caption="按连接类型分类的 TTFB 总性能",
  description="条形图显示，TTFB 受到连接类型的严重影响，在4G和离线的场景下，分别只有21％和22％的体验良好。其他连接类型几乎没有良好的 TTFB 体验（3G上为1％除外）。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=810992122&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

TTFB 受网络延迟和连接类型的影响。由上图可知，延迟越高、连接越慢，TTFB 度量值就会越差。即使在被认为快速（4G）的移动端连接上，也只有21%的网站有一个快速的 TTFB。低于4G速度的站点基本上不会被评定为快速。

我们来看看<a hreflang="en" href="https://www.speedtest.net/insights/blog/content/images/2020/02/Ookla_Mobile-Speeds-Poster_2020.png">2018年12月-2019年11月全球移动端网速</a>，可以看出整体上移动端连接网速并不高。那些网速和代表蜂窝网络的技术（比如5G）分布不均，并且最终会影响 TTFB。举个例子，[我们看尼日利亚的网络分布图]，该国大部分区域覆盖的都是2G和3G，极少数区域才有4G网络分布。

令人惊讶的是，离线站点和通过4G网络访问的站点有着相同数目的良好的TTFB。通过 service workers，我们可以预期一些 TTFB 问题会得到缓解，但该趋势并未在上图中反映出来。

## 性能监测的使用

有许多不同的以用户为中心的指标可用于评估网站和应用程序。然而，有时预定义的指标并不完全符合我们的特定场景和需要。[性能监测对象 API](https://developer.mozilla.org/docs/Web/API/PerformanceObserver)允许我们通过[自定义时间测量 API](https://developer.mozilla.org/docs/Web/API/User_Timing_API)、[Long Tasks API](https://developer.mozilla.org/docs/Web/API/Long_Tasks_API)、<a hreflang="en" href="https://web.dev/custom-metrics/#event-timing-api">Event Timing API</a>和<a hreflang="en" href="https://web.dev/custom-metrics/">一些底层 APIs</a>去获取自定义度量数据。举例来说，在这些 API 的帮助下我们可以记录页面转场时间或者量化服务端渲染应用的客户端激活。

{{ figure_markup(
  image="performance-performance-observer-usage.png",
  caption="按设备分类的性能监测的使用",
  description="条形图显示，性能监测 API 的采用率很低，桌面端为6.6％，移动端为7％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=632678090&format=interactive",
  sheets_gid="934401790",
  sql_file="performance_observer.sql"
  )
}}

上图显示，被跟踪的站点中有6-7％使用了性能监测，它具体取决于设备类型。这些站点借助这些底层 API 去创建自定义度量指标，并通过性能监测 API 去核对，然后可能通过其他性能报告工具去使用。这样的采用率表明人们更倾向于使用预定义的指标（比如 Lighthouse 里面定义的指标），但那些特定应用场景的 API 也令人印象深刻。

## 总结

用户体验不仅是某一个特定范围的问题，还取决于多种因素。要试图了解性能状态而又不排除欠佳的用户体验，我们必须通盘考虑。每次访问网站都在讲述一个故事。我们的个人和国家的社会经济状况决定了我们可以负担得起的设备和互联网提供商的类型。我们居住地的地理位置影响了延迟（我们澳大利亚人经常能感受到这种痛苦），而经济状况决定了可用的蜂窝网络覆盖范围。我们在浏览什么网站？我们浏览网站的目的是什么？在构建所有人都可以快速访问的用户体验过程中，背景对于分析数据和发展必要的同理心和关怀都至关重要。

表面看来，我们看到了有关新的网页核心指标中性能指标的乐观信号。如果我们不把焦点总是局限在较差网络下的最大内容绘制指标上，在桌面和移动端都有至少一半网站有着良好的用户体验。虽然较新的指标表明正在解决性能问题，但是缺乏重大改进的首次内容绘制指标和首字节时间指标令人担忧。在相同的网络类型下，最大内容绘制、快速连接以及桌面设备对用户体验的影响是最大的。

数据显示，我们必须继续努力以改善在各种场景下的性能，而这些场景由于各方面的优势（中高收入国家、高薪和功能强大的设备），我们通常没有经历过。它还强调了在加快初始页面绘制（LCP 和 FCP）和静态资源请求（TTFB）方面仍然有很多需要改进的地方。通常感觉性能就像是前端固有的问题，然而通过合适的基础设施，后端可以实现许多重大改进。再重申一次，用户体验是由多方面因素决定的一类问题，我们需要从整体上看待它。

新的指标带来了新的视角来分析用户体验，但是我们一定不能够忽视现存的问题。让我们把精力集中在最需要改进的地方，为大多数用户体验不好的人群带来积极的转变。快速、便捷的互联网是一项人权。
