---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 性能
description: 2019 Web Almanac网络年鉴的性能章节，包括 首次有内容的绘制 (FCP), 首包字节 (TTFB), 以及首次输入延迟 (FID)。
authors: [rviscomi]
reviewers: [JMPerez,foxdavidj,sergeychernyshev,zeman]
analysts: [rviscomi, raghuramakrishnan71]
editors: [rachellcostello]
translators: [chengxicn]
discuss: 1762
results: https://docs.google.com/spreadsheets/d/1zWzFSQ_ygb-gGr1H1BsJCfB7Z89zSIf7GX0UayVEte4/
rviscomi_bio: Rick Viscomi 是谷歌的高级开发者项目工程师，从事网络透明度的工作，例如 HTTP Archive 和 Chrome UX Report, 并研究网站建设和体验的交集。Rick 是 <a hreflang="en" href="https://www.youtube.com/playlist?list=PLNYkxOF6rcIBGvYSYO-VxOsaYQDw5rifJ">The State of the Web</a>的播主，专家们在其中讨论网络的发展趋势。 Rick 也是网站性能测试指南<a hreflang="en" href="https://usingwpt.com">Using WebPageTest</a>的合著者, 他也经常在 <a hreflang="en" href="https://dev.to/rick_viscomi">dev.to</a>发表关于Web的文章，他的推特是 <a href="https://twitter.com/rick_viscomi">@rick_viscomi</a>.
featured_quote: 性能是用户体验的重要组成部分。对于许多网站来说，通过降低页面加载时间来改善用户体验与转化率的提高是一致的。相反，当性能不佳时，用户的转化率就不会像往常那样高，甚至还会在导致沮丧的页面观察到愤怒点击。
featured_stat_1: 13%
featured_stat_label_1: 有快速FCP的站点
featured_stat_2: 42%
featured_stat_label_2: 有缓慢TTFB的站点
featured_stat_3: 40%
featured_stat_label_3: 有快速FID的站点
---

## 介绍

性能是用户体验的重要组成部分。对于<a hreflang="en" href="https://wpostats.com/">许多网站</a>来说，通过降低页面加载时间来改善用户体验与转化率的提高是一致的。相反，当性能不佳时，用户的转化率就不会像往常那样高，甚至还会在导致沮丧的页面观察到<a hreflang="en" href="https://blog.fullstory.com/rage-clicks-turn-analytics-into-actionable-insights/">愤怒点击</a>。

有许多方法可以量化Web性能。最关键的事情是要去量度什么是对用户而言真正重要。然而，`onload` 或者 `DOMContentLoaded` 之类的事件可能不一定反映用户的视觉体验。例如，当加载一个电子邮件客户端，收件箱内容异步加载的时候，它可能会显示一个进度栏。这里的问题在于 `onload` 事件不会等待收件箱异步加载。在这个范例中，对用户而言最重要的加载指标是"收件时间"，而关注`onload`事件可能会产生误导。基于这个原因，本章将研究更现代且普遍适用的绘制，加载和交互性指标，以尝试获得用户对页面的真实体验。

性能数据有两种：实验室数据和现场数据。您可能已经听说过这些被称为合成模拟测试和真实用户监控（或RUM）的测试监控方法。在实验室中评估性能可确保在通用条件下测试每个网站，并且例如浏览器，连接速度，物理位置，缓存状态等变量都可以保持一致。这种一致性的保证使各个网站之间都可以互相比较。而另一方面，现场真实的性能评估代表了用户在所有我们在实验室中无法捕捉到的无限的条件组合之下，用户网络体验的真实情况。在本章中，为了理解真实的用户体验，我们将研究现场数据。

## 性能的状态

几乎所有Web Almanac的章节都是基于<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a>的数据。但是，为了捕获真实用户的Web体验，我们需要一个不同的数据集。在本章中，我们使用[Chrome 用户体验报告](http://bit.ly/chrome-ux-report) (CrUX)，这是一个Google的公共数据集，由与HTTP Archive相同的所有网站组成，汇总了Chrome用户访问这些网站的真实体验。体验分为以下类别：

- 用户设备外形
  - 桌面
  - 手机
  - 平板
- 移动用户有效链接类型(ECT)
  - 离线
  - 缓慢的2G
  - 2G
  - 3G
  - 4G
- 用户地理位置

用户体验按月量度，包括绘制、加载和交互性指标。我们要看的第一个度量是<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics#first_paint_and_first_contentful_paint">首次有内容的绘制</a> (FCP)。这个指标是用户等待在屏幕上显示出有用处的页面内容（例如图像或文本）所花费的时间。然后，我们来看一下加载指标[首包时间](https://developer.mozilla.org/docs/Glossary/%E7%AC%AC%E4%B8%80%E5%AD%97%E8%8A%82%E6%97%B6%E9%97%B4) (TTFB)。这是网页从用户导航到接收到响应的第一个字节所花费的时间的指标。最后，我们要看的最后一个真实用户指标是<a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">首次输入延迟</a> (FID)。这是一个相对较新的度量标准，它表示的是用户体验的部分，而不是加载性能。它测量从用户第一次与页面UI交互到浏览器主线程准备好处理事件的时间。

因此，让我们深入研究看看可以找到哪些见解。

### 首次有内容的绘制

{{ figure_markup(
  image="fig1.png",
  caption="网站的快速，中速和慢速FCP性能分布。",
  description="1,000个网站的快速，中速和慢速FCP的分布。快速FCP的分布从100％到0％呈线性关系",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=115935793&format=interactive"
  )
}}

在上面的图7.1中，您可以看到FCP体验是如何在Web上分布的。这个图表从CrUX数据集里面的数百万个网站之中，将分布缩减到1,000个网站，其中每个垂直切片代表一个站点。该图表按快速FCP的百分比排序，快速FCP体验是1秒之内发生的。慢速的体验会在3秒或更长时间内发生，而中速的体验（以前称为“平均”）介于两者之间。在图表的极端情况下，有些网站拥有近100％的快速体验，而有些网站则具有近100％的慢速体验。在这两者之间，兼具快速，中速和慢速性能的网站似乎更倾向于快速或中速，而不是慢速，这很好。

<p class="note">注意：当用户的性能下降时，很难说出原因是什么。网站本身可能设计得很差且效率低下。或可能存在其他环境因素，例如用户的连接速度慢，没有缓存等。因此，在查看该现场数据时，我们更倾向于说用户自身的体验缓慢，而不一定是网站。</p>

为了对网站是否足够**快速**进行分类，我们将使用新的<a hreflang="en" href="https://developers.google.com/speed/docs/insights/v5/about#categories">PageSpeed Insights</a> (PSI) 方法，其中至少有75％的网站FCP体验必须快于1秒。同样，一个足够**慢速**的网站具有25％或更多的FCP体验慢于3秒。我们说一个网站不符合以上两个条件时，它们的性能就是**中速**。

{{ figure_markup(
  image="fig2.png",
  caption="标有快速，中速或慢速FCP的网站的分布。",
  description="条形图显示，有13％的网站具有快速FCP，有66％的网站具有中速FCP，有20％的网站具有慢速的FCP。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=36103372&format=interactive"
  )
}}

图7.2的结果表明，只有13％的网站被认为是快速的。这表明仍然有很多改进的空间，但是许多网站都在快速，一致地绘制有意义的内容。三分之二的网站具有中速的FCP性能体验。

为了帮助我们了解用户在不同设备上的FCP体验，让我们按尺寸来做个分类。

#### 按设备类型看FCP

{{ figure_markup(
  image="fig3.png",
  caption="<em>桌面</em> 站点的快速，中速和慢速的FCP性能分布。",
  description="1,000个桌面站点的快速，中速和慢速的FCP性能分布。快速FCP的分布从100％到0％呈线性关系，中间略有凸起。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1231764008&format=interactive"
  )
}}

{{ figure_markup(
  image="fig4.png",
  caption="<em>移动</em> 站点的快速，中速和慢速的FCP性能分布。",
  description="1,000个移动站点的快速，中速和慢速的FCP性能分布。快速FCP的分布从100％到0％呈线性关系，而没有出现与桌面站点相同的中间凸起。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=167423587&format=interactive"
  )
}}

在上面的图7.3和图7.4中，FCP分布按桌面和移动设备分类。可看到一个细微的区别，就是桌面快速FCP分布的主干似乎比移动用户的分布更凸出一点点。这种视觉上的近似值表明，桌面用户的快速FCP总体比例更高。 为了验证这一点，我们可以将PSI方法应用于每个分布。

{{ figure_markup(
  image="fig5.png",
  caption="按设备类型划分，被标记为具有快速、中速或慢速FCP的网站分布。",
  description="桌面和移动FCP分布的条形图。桌面快速，中速，慢速分别为: 17%，67%和16%。移动: 11%，66%和23%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=486448175&format=interactive"
  )
}}

根据PSI的分类，17%的网站为桌面用户提供了快速的FCP体验，而移动用户则为11％。整个分布偏向于桌面体验略快一些，慢速的网站更少，而快速和中等的网站更多。

为什么桌面用户在网站上体验快速FCP的比例高于移动用户？毕竟，我们只能根据数据集推测网络的运行情况， 对 _为什么_ 的回答则可能和实际表现不相符合。 但有一种猜测是，桌面用户通过更快更可靠的网络（如WiFi）而不是手机基站连接到因特网。为了帮助回答这个问题，我们还可以探讨ECT对用户体验的影响。

#### 按有效连接类型看FCP

{{ figure_markup(
  image="fig6.png",
  caption='被标记为具有快速、中速或慢速FCP的网站分布，按 <abbr title="effective connection type">ECT</abbr> 分类。',
  description="每个有效连接类型的FCP分布条形图。4G 快速, 中速, 慢速: 14%, 67%以及19%。 3G: 1%, 38%以及61%. 2G: 0%, 9%, 90%. 慢速 2G: 0%, 1%, 99%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1987967547&format=interactive"
  )
}}

在上面的图7.6中，FCP体验按用户的有效连接类型（ECT）分组。有意思的是，有效连接类型（ECT）速度与提供快速FCP的网站百分比间存在相关性。随着有效连接类型（ECT）速度的降低，快速体验的比例接近零。具有14％的站点为使用4G有效连接类型（ECT）的用户提供快速的FCP体验，而19％站点的体验较慢。为使用3G有效连接类型（ECT）的用户提供慢速FCP服务的网站比例为61％，为2G有效连接类型（ECT）的用户提供慢速FCP服务的网站比例为90％，为缓慢2G有效连接类型（ECT）的用户提供慢速FCP服务的网站比例为99％。这些结果表明，很少有网站对比4G慢的用户持续提供快速FCP服务。

#### 按地理位置看FCP

{{ figure_markup(
  image="fig7.png",
  caption="标有快速，中速或慢速FCP的网站分布，按地理位置细分。",
  description="排名前23位的最受欢迎地区的FCP分布条形图。韩国拥有最多快速的站点，为36％。从那里开始，其他地区的快速网站百分比迅速下降：日本28％，台湾26％，荷兰21％等。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=792398959&format=interactive",
  width=600,
  height=940,
  data_width=600,
  data_height=940
  )
}}

最后，我们可以按用户的地理位置对FCP进行切片。上面的图表显示了拥有最多独立网站数量的前23个地理位置，这是开放网络总体流行程度的指标。美国的网络用户访问的独立网站最多，数量为1,211,002。地理位置按具有足够快速的FCP体验的网站百分比排序。排在首位的是三个[Asia-Pacific](https://en.wikipedia.org/wiki/Asia-Pacific) (APAC) 地理位置：韩国，台湾和日本。这可以通过在这些地区具有极高的[快速网络连接速度](https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds)。韩国有36％的网站符合快速FCP标准，只有7％被评为慢速FCP。回想一下，快速/中速/慢速网站的全球分布约为13/66/20，这使韩国区域成为一个明显积极的异常值。

其他亚太地区区域则讲述了一个不同的故事。泰国，越南，印度尼西亚和印度都拥有不到10％的快速网站。这些地理位置的慢速网站比例也比韩国高出三倍以上。

### 首包时间(TTFB)

<a hreflang="en" href="https://web.dev/articles/ttfb">首包时间</a> (TTFB)是页面从用户导航到接收到响应的第一个字节为止花费时间的度量。

{{ figure_markup(
  image="nav-timing.png",
  caption="页面导航中Navigation Timing API的事件图。",
  description="该图展示了页面加载过程的网络阶段：startTime (promptForUnload)，重定向，AppCache，DNS，TCP，请求，响应，处理，以及加载。",
  width=2580,
  height=868
  )
}}

为了帮助解释TTFB及其影响因素，让我们借鉴一份[Navigation Timing API 规范](https://developer.mozilla.org/docs/Web/API/Navigation_timing_API)中的图表。在上面的图7.8中，TTFB是从`开始时间 startTime` 到 `响应时间 responseStart`，包括介于两者之间的所有内容：`卸载 unload`，`重定向 redirects`，`AppCache`，`DNS`，`SSL`，`TCP`，以及服务器处理请求的时间。在这些条件下，我们来看看这一指标用户的体验。

{{ figure_markup(
  image="fig9.png",
  caption="网站的快速，中速和慢速TTFB性能分布。",
  description="1,000个网站的快速，中速和慢速TTFB分布。快速TTFB的分布在第10最快分位从约90％迅速下降到50％。然后，其余的90％的网站从50％逐渐降低到0％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=444630188&format=interactive"
  )
}}

与图7.1中的FCP图表相似，这是按快速TTFB排序的1,000个代表性样本的视图。<a hreflang="en" href="https://developers.google.com/speed/docs/insights/Server#recommendations">快速 TTFB</a>是在0.2秒（200毫秒）内发生的，而慢速TTFB在1秒或更长时间内发生的，两者之间就属于中速。

从快速比例的曲线来看，其形状与FCP完全不同。很少有网站的快速TTFB高于75％，而超过一半的网站百分比低于25％。

让我们从上面用于FCP的PSI方法中获得灵感，将TTFB速度标签应用于每个网站。如果网站的快速TTFB达到75％或更高的用户体验，则标记为**快速**。否则，如果它为25％或更多的用户体验提供**慢速**用户体验，则被标为慢速。如果这些条件都不适用，就被标为 **中速** 。

{{ figure_markup(
  image="fig10.png",
  caption="标有快速，中速或慢速TTFB的网站分布。",
  description="条形图显示2％的网站拥有快速的TTFB，56％的网站具有中速的TTFB，42％的网站有慢速的TTFB。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=926985367&format=interactive"
  )
}}

42%的网站TTFB体验缓慢。这很值得注意，因为TTFB阻止了后续所有其他的性能指标。 _按照定义，如果TTFB花费的时间超过1秒，则用户可能无法体验快速的FCP。_

#### 按地理位置看TTFB

{{ figure_markup(
  image="fig11.png",
  caption="标有快速，中速或慢速TTFB的网站分布，按地理位置细分。",
  description="最受欢迎的23个地理区域的TTFB分布条形图。韩国拥有最多的快速网站，为14％。之后其他区域的快速网站百分比迅速下降：台湾7％，日本5％，荷兰4％等。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=685447534&format=interactive",
  width=600,
  height=940,
  data_width=600,
  data_height=940
  )
}}

现在，我们来看为不同地理位置的用户提供快速TTFB的网站百分比。韩国、台湾和日本等亚太地区的地理位置仍然优于其他地区的用户。但没有一个区域拥有15％以上的快速TTFB网站。 例如，印度的快速TTFB网站不到1％，大约79％是慢速TTFB网站。

### 首次输入延迟

我们将要查看的最后一个字段指标是<a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">首次输入延迟</a> (FID)。此度量标准表示从用户第一次与页面UI交互到浏览器主线程准备处理事件的时间。请注意，这不包括应用程序实际花费在处理输入上的时间。最差的情况时，缓慢的FID会导致页面显示无响应，并给用户带来令人沮丧的体验。

让我们从定义一些阈值开始。根据新的PSI方法，**快速**FID是在100毫秒内发生的。这为应用程序提供了足够的时间来处理输入事件，并在瞬时的感觉时间内向用户提供反馈。一个**慢速**FID在300毫秒或更长时间内发生的。 介于两者之间的一切成为**中速**。

{{ figure_markup(
  image="fig12.png",
  caption="网站的快速，中速和慢速FID性能分布。",
  description="1,000个网站的快速，中速和慢速FID分布。对于最快的四分之三的网站，快速FID的分布保持在75％以上，然后迅速下降到0％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=60679078&format=interactive"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
这样你就应该明白了。此图显示了网站的快速，中速和慢速FID体验的分布。这与以前的FCP和TTFB图表截然不同。(分别参见[图 7.1](#fig-1)和[图 7.9](#fig-9))。快速FID曲线从100％缓慢下降到75％，然后急速下降。 大多数网站的绝大多数FID体验都很快。

{{ figure_markup(
  image="fig13.png",
  caption="标有快速，中速或慢速TTFB的网站的分布。",
  description="条形图显示40％的网站具有快速FID，45％的网站具有中速FID，15％的网站具有慢速FID。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1828752871&format=interactive"
  )
}}

将网站标记为具有足够快速或慢速FID的PSI方法与FCP略有不同。为了使网站**快速**，95%的FID体验必须快速。如果5％的FID体验很慢，则该网站为**慢速**。所有其他的体验均为“中速”。

与以前的指标相比，FID总体表现的分布更倾向于快速和中速的体验，而不是慢速的。40％的网站具有快速FID，只有15％的网站具有慢速FID。FID的本质是一种交互性指标-与受网络速度限制的加载指标相反-带来了一种完全不同的性能表现方式。

#### 按设备类型看FID

{{ figure_markup(
  image="fig14.png",
  caption="快速，中度和慢速FID性能 <em>桌面</em> 站点的分布",
  description="1,000个桌面网站的快速，中速和慢速FID分布。对于最快的四分之三的网站，快速FID的分布非常缓慢地从100％降低到90％。之后，快速FID会略微降低到75％。几乎所有桌面网站都拥有超过75％的快速FID体验。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=16379508&format=interactive"
  )
}}

{{ figure_markup(
  image="fig15.png",
  caption="<em>移动</em> 网站的快速，中速和慢速FID性能分布。",
  description="1,000个移动网站的快速，中速和慢速FID分布。 快速FID的分布稳定下降，但比桌面快得多。在四分之三的网站中，它的速度达到75％，然后迅速下降到0％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=519511409&format=interactive"
  )
}}

通过按设备划分FID，我们可以清楚地看到两个非常不同的故事。桌面用户几乎一直都在享受快速FID。当然，有些网站有时会带来缓慢的体验，但基本上都是快的。另一方面，移动用户似乎拥有以下两种体验之一：相当快（但不如桌面用户那么高频）和几乎从来不快。后者只有在尾部10%的站点，用户才会体验到，但这仍然是一个很大的差异。

{{ figure_markup(
  image="fig16.png",
  caption="标有快速，中速或慢速FID的网站分布，按设备类型细分。",
  description="桌面和移动FID分布条形图。桌面快速，中速，慢速:分别为82%、12%和5%。移动:26%，52%，22%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1533541692&format=interactive"
  )
}}

当我们把PSI标签应用于桌面和移动体验时，两者之间的区别变得非常清晰。桌面用户的网站FID 82％具有快速体验，而慢速为5％。对于移动体验，26％的网站是快速的，而22％的是慢速的。设备形状因素在诸如FID之类的交互性指标的性能中起着重要作用。

#### 按有效链接类型看FID

{{ figure_markup(
  image="fig17.png",
  caption='按 <abbr title="effective connection type">ECT</abbr> 划分为具有快速，中速或慢速FID的网站分布。',
  description="每个有效连接类型FID分布的条形图。4G的快速，中速，慢速分别为：41%，45%，15%。3G：22%，52%，26%。2G：19%，58%，23%。慢速2G：15%，58%，27%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1173039776&format=interactive"
  )
}}

从表面上看，FID似乎主要由CPU速度驱动。可以合理地假设如果设备越慢，那么当用户尝试与网页进行交互时设备繁忙的可能性就会越大，对吧？

上面的用户有效连接类型（ECT）结果似乎表明连接速度和FID性能之间存在相关性。随着用户有效连接速度的降低，他们体验快速FID的网站百分比也随之降低：4G有效连接类型（ECT）的用户的快速FID网站比例为41％，3G用户的快速FID的网站比例为22％，2G用户为19％，慢速2G用户为15％。

#### 按地理位置看FID

{{ figure_markup(
  image="fig18.png",
  caption="标有快速，中速或慢速FID的网站分布，按地理位置细分。",
  description="最受欢迎的23个地区的FID分布条形图。韩国拥有最多快速的网站，为69％。从那里开始，其他区域的快速网站百分比稳步下降：澳大利亚55％，美国52％，加拿大51％等。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=11500240&format=interactive",
  width=600,
  height=940,
  data_width=600,
  data_height=940
  )
}}

在按地区划分的FID中，韩国再次领先于其他所有地区。但是排名靠前的地理位置有了一些新面孔：紧随其后的有澳大利亚，美国和加拿大，它们超过50％的网站具有快速FID。

与其他同地理位置相关的结果一样，有太多可能的因素在影响着用户体验。例如，也许较富裕的地区特权更高，因为可以负担得起更快的网络基础设施，同时这里的居民也可能有更多的钱可以花在台式机以及高端手机上。

## 结论

量化网页加载的速度是一门不完美的科学，无法用单个指标来表示。诸如`onload`之类的常规指标可能会通过测量用户体验中无关或不可察觉的部分完全得出错误的结论。用户感知的指标（如FCP和FID）可以更忠实地传达用户的看法和感受。即便如此，这两个指标都无法孤立地得出总体页面加载速度是快还是慢的结论。只有整体地看待许多指标，我们才能开始了解单个站点的性能和网络状态。

本章中提供的数据表明，要实现为快速网站设定的目标仍有大量工作要做。 某些外形尺寸、有效的连接类型和地理位置确实与更好的用户体验相关，但是我们不能忘记组合中性能差的那部分人口统计也在其中。在许多情况下Web平台用于商业，通过提高转化率来赚更多钱会是提升网站速度的巨大驱动力。 归根结底，对于所有网站而言，性能都是要为用户提供积极的体验，而不应阻碍、挫败或激怒用户。

随着网络的年纪又长了一岁，我们衡量用户体验的能力也逐步提高，我期待开发人员能够访问和捕获更多整体用户体验的指标。FCP在向用户展示有用内容上还处于非常初期的阶段，而诸如<a hreflang="en" href="https://web.dev/articles/lcp">最大内容绘制</a> (LCP)之类的新指标正在涌现，提高了我们对页面加载感知的能见度。而<a hreflang="en" href="https://web.dev/articles/cls">不稳定布局API</a>也给我们了超越页面加载之外的视角，一窥用户对访问性能的沮丧体验。

配备了这些新指标后，2020年的网络将变得更加透明，更易于理解，并为开发人员创造有利条件来产生更有意义的进步，提升网络性能并为用户带来积极的体验。
