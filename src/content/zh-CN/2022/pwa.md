---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: 2022 Web 年鉴的 PWA 章节涵盖 Service Workers 的使用和功能、Web 应用程序清单、Lighthouse 的洞察、Service Worker 库（包括 Workbox）和 Web 推送通知。
authors: [diekus]
reviewers: [aarongustafson, tropicadri, webmaxru, Schweinepriester, beth-panx]
analysts: [beth-panx]
editors: [siwinlo, tunetheweb]
translators: [ibelem]
results: https://docs.google.com/spreadsheets/d/1PbzjhN%2D%2DjU9MGuWobw5L9EsmlVzI9tlbCe3_NKA7giU/
diekus_bio: Diego Gonzalez 是来自哥斯达黎加的计算机工程师，在 Microsoft Edge 浏览器团队担任 PWA 平台功能的 PM。
featured_quote: 随着可安装的 Web 应用与桌面平台集成的功能不断增加，推动了业内知名厂商使用 PWA。
featured_stat_1: 95%
featured_stat_label_1: 桌面端可 JSON 解析的 manifest 文件
featured_stat_2: 63%
featured_stat_label_2: 桌面端 PWA 使用 Service Worker 的 install 事件
featured_stat_3: 60%
featured_stat_label_3: 以某种方式使用 Workbox 的 PWA 应用
---

## 简介

在渐进式 Web 应用 PWA 的早期，有两个关键功能吸纳了现代 Web 应用的能力，离线支持和添加到主屏幕的快捷方式。

这两个概念在安装 PWA 后启用，该过程通常从点击浏览器地址栏中出现的安装图标开始。该图标会提示用户安装该网站。Samsung Internet 和 Mozilla Firefox 等移动浏览器最早明确支持此行为，被熟知为[添加到主屏幕 (A2HS)](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Add_to_home_screen)。

五年前，这还是一个激进的想法。一个网站能够直接从主屏启动，并与设备中其他安装的应用一起列出。这是在缩小 Web 应用的功能与特定于操作系统体验之间差距的方面取得进展的开始。

Web 应用的添加到主屏幕的场景已经演变为，可以完全在移动和桌面环境中安装，并深度集成到了操作系统中。在过去的 12 个月里，浏览器在确保 PWA 与桌面平台紧密集成方面取得了重要进展，今年年鉴中的许多新增内容都反映了这些变化。这是 2022 年 PWA 的最新状态。

注：作为 Web 技术的集合，PWA 并不与 Web 平台的其余部分隔绝。前面的章节专门介绍了[能力](./capabilities)，今年我们也研究了在 PWA 中使用这些新的高级功能。

## Service Workers

[Service Workers](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) 是 PWA 的核心技术之一，使离线应用、获取推送通知以及后台处理成为可能。Service Workers 是我们从应用中获得大多数高级体验的基石。Service Workers 还被用于定义数据更新和支持即将推出的新功能，例如 <a hreflang="en" href="https://github.com/aarongustafson/pwa-widgets#rich-widgets">基于 PWA 技术的 widgets</a>。

在 Service Worker 功能支持方面，虽然各主要浏览器之间并不一致，但 Webkit 添加对<a hreflang="en" href="https://caniuse.com/push-api">推送通知</a> 的支持是一个巨大的里程碑。今年早些时候，Apple 宣布<a hreflang="en" href="https://webkit.org/blog/12945/meet-web-push/">对其桌面平台进行了更改</a>，以支持 [Push API](https://developer.mozilla.org/docs/Web/API/Push_API) 、[Notifications API](https://developer.mozilla.org/docs/Web/API/Notifications_API) 以及 [Service Workers](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) 将会启用 Web Push。Apple 还宣布该功能将于 2023 年进入他们的移动平台。

### Service Worker 的使用情况

为了比较，我们进行了与去年类似的调查，使我们能够了解 Service Worker 使用的演变。去年的章节解释了[为什么找出 Service Worker 的实际使用情况并非易事](../2021/pwa#service-workers-usage)，今年同样如此。

看两组数据：

- Lighthouse 检测到所有网站中有 1.6%（移动）和 1.7%（桌面）使用了 Service Worker。由于 Lighthouse 进行了<a hreflang="en" href="https://web.dev/service-worker">额外检查</a>，我们预计这些数字低于实际百分比。
- 遵循去年推出的相同<a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/pwa.js">指标</a>， 网站中 Service Worker 的使用率在桌面端和移动端分别达到 1.63% 和 1.81%。

{{ figure_markup(
  image="sw-controlled-pages-rank.png",
  caption="支持 Service Worker 的网站（按排名）",
  description="柱状图显示在桌面端，前 1000 个网站中有 8.3% 使用 Service Worker，前 10,000 个网站为 8.0%，前 100,000 个为 4.5%，前 100 万个为 2.2%，整个数据集则为 1.4%。移动端分别为 8.7%、7.9%、4.7%、2.3% 和 1.4%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1762012854&format=interactive",
  sheets_gid="2067971287",
  sql_file="sw_adoption_over_time_ranking.sql"
  )
}}

在前 1000 个网站中，支持 Service Worker 的页面数量没有明显的变化，桌面端略有下降，而移动端的增长则更小，但所有其他类别都有所增加。如果我们遵循[去年的推理](../2021/pwa#fig-2)，即假设大型网站更快地采用先进技术，那么看到其他类别的更多增长是合理的。似乎较小的公司和开发人员已经学习并采用了从流量更多的公司案例研究和示例中分享的技术。

### Service Worker 事件

Service Worker 在 Web 应用、浏览器和网络之间充当代理服务器的角色。要安装 Service Worker，必须获取并注册它。注册成功后，Service Worker 将在一个[特殊 Woker 容器](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope)中执行，该容器在主线程之外运行并且没有 DOM 访问权。这是可以处理事件的时机。

{{ figure_markup(
  image="most-used-sw-events.png",
  caption="最常用的 Service Worker 事件",
  description="柱状图显示 63% 的桌面和 61% 的移动 PWA 网站使用了`install`，分别有 63% 和 61% 使用了`activate`，57% 和 51% 使用了`notificationclick`，56% 和 51 使用了`push` %，49% 和 50% 使用 `fetch`，15% 和 16% 使用 `notificationclose`，6% 和 5% 使用 `sync`，最后 0% 使用 `periodicsync`。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1426457626&format=interactive",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
  )
}}

上面的图表显示了最常用的 Service Worker 事件信息。这些事件可以分类为：

- 生命周期事件
- 通知相关的事件
- 后台处理事件

#### 生命周期事件

`install` 和 `activate` 是生命周期事件。创建资产缓存以允许在安装时离线运行应用是一种常见的做法。激活通常用于清理与之前的 Service Worker 关联的旧缓存。

{{ figure_markup(
  caption="移动端 Service Worker 的 `install` 事件使用率",
  content="61%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

Service Worker 需要处于活动状态才能接收诸如 fetch 和 push 之类的事件。它们是 Service Workers 的基石，因此在桌面端有 63%，以及移动端有 61% 用于`安装` 和 `激活`。

剩下约 40% 的站点可能没有活跃地使用这些事件，因为他们可以使用 Service Worker 进行通知或利用仅在站点运行时缓存发出的请求，也称为<a hreflang="en" href="https://web.dev/runtime-caching-with-workbox/">运行时缓存</a>。

虽然这些仍然是最常用的事件，但正在使用的其他类型事件的增加使我们推测，有更多的 Service Worker 不（仅仅）用预缓存作为他们的主要任务。

#### 通知相关的事件

{{ figure_markup(
  caption="桌面端 Service Worker 的 `notificationclick` 事件使用率",
  content="57%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

在最常用的 Service Worker 方法中，推送通知 (Push Notification) 事件紧随其后。

- 桌面端的`notificationclick` 高达 57%（比去年的数据<span class="numeric-good">▲11%</span> ），移动端占 51% (<span class="numeric-good">▲5 %</span>) 。
- 桌面端的 `push` 达到 56% (<span class="numeric-good">▲12%</span>) ，移动端占 50% (<span class="numeric-good">▲5%</span>)。
- 桌面端的 `notificationclose` 为 15% (<span class="numeric-good">▲9%</span>) 移动端为 16% (<span class="numeric-good">▲10%</span >) 。

几个要点：2022 年桌面端 PWA 的势头继续增长，推送通知 (Push Notification) 也不例外。通知相关事件的使用量增加了约 11%。用户体验部分已经在不同的平台上进行了许多调整和修复，以确保它们与操作系统完全集成。在新宣布的<a hreflang="en" href="https://webkit.org/blog/12945/meet-web-push/">支持 Webkit 的 Web 推送</a>之后，我们预计这些数字将继续增长。这是许多开发人员长期以来一直要求的功能，最终在 macOS 上得到支持，希望 iOS 设备也能很快跟进，如此则可以鼓励开发人员使用该 API。

#### 后台处理事件

{{ figure_markup(
  caption="桌面端 Service Worker 的 `fetch` 事件",
  content="49%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

图表中剩余的事件为后台处理事件：
- `fetch`：当请求发送到服务器时发生，可拦截请求并使用自定义或缓存资产进行响应，从而为 PWA 提供离线支持。桌面端的 fetch 使用率为 49%，移动端为 50%。
- `sync`：当 UA 认为用户有连接时触发，桌面端的使用率为 6%，移动端的使用率为 5%。
- `periodicsync`：允许 Web 应用在后台定期同步数据，目前在桌面和移动平台都是 0.01%。应该注意的是，`periodicsync` 被限制为最多每 12 小时一次。这可以人为地抑制该功能的使用。

### 其他受欢迎的 Service Worker 功能

{{ figure_markup(
  image="usage-skip-waiting.png",
  caption="`skipWaiting()` 方法的使用",
  description="柱状图显示 `skipWaiting()` 的使用率在桌面端为 60%，在移动端为 59%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=174072819&format=interactive",
  sheets_gid="58784102",
  sql_file="sw_methods.sql"
  )
}}

类似于[去年的数据](../2021/pwa#other-popular-service-worker-features)，用于立即激活 Service Worker 的 [`skipWaiting`](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/skipWaiting) 方法在开发人员中仍然非常流行，存在于 60% 的桌面和 59% 的移动 Web 应用中。

这些是最常用的 Service Worker 对象：

{{ figure_markup(
  image="most-used-sw-objects.png",
  caption="最常用的 Service Worker 对象",
  description="柱状图显示 93% 的桌面和 87% 的移动网站使用了 `clients` 对象，`caches` 的使用率分别为 45% 和 44%，`cache` 占比为 21% 和 21%，最后是 `client`，桌面端为 12%，移动端 PWA 网站为 13%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1869777638&format=interactive",
  sheets_gid="1746822463",
  sql_file="sw_objects.sql"
  )
}}

{# TODO Anything to say about this graph? #}

这些是最常用的对象方法：

{{ figure_markup(
  image="most-used-sw-objects-methods.png",
  caption="最常用的 Service Worker 对象方法",
  description="柱状图显示 61% 的桌面和 55% 的移动 PWA 网站使用了`clients.matchAll`，`clients.claim` 的使用率分别为 58% 和 58%，`clients.openWindow` 分别为 56% 和 51%，`caches.open` 为 44% 和 43%，`caches.delete` 为 29% 和 24%，`caches.match` 为 25% 和 28%，`caches.keys` 为 21% 和 18%，`cache.put` 为 12% 和 14%，`client.url` 为 10% 和 11%，最后 `cache.add` 用于 8% 的桌面和 7% 的移动端 PWA 网站。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1209078963&format=interactive",
  sheets_gid="1969934262",
  sql_file="sw_methods.sql"
  )
}}

{# TODO Anything to say about this graph? #}

## Web 应用程序清单（Web App Manifest）

_Web 应用程序清单（Web App Manifest）_ 是一个 JSON 文件，其中包含应用程序本身的信息。Manifest 文件是定义 PWA 的另一项主要核心技术。键值对中的数据包括与显示、推广和将应用集成到操作系统相关的信息。

Web 应用程序 manifest 对于通过在线存储库、提交到应用商店、利用最新的高级功能（如应用的共享目标和文件处理）至关重要。<a hreflang="en" href="https://github.com/aarongustafson/pwa-widgets#how-widgets-are-represented-in-these-apis">启用基于 PWA 技术的 Widgets</a> 也植根于 manifest 中，证明了 manifest 的多功能性，并进一步用于高级平台集成。

{{ figure_markup(
  caption="桌面端的 manifest 文件的百分比",
  content="95%",
  classes="big-number",
  sheets_gid="717325565",
  sql_file="manifests_not_json_parsable.sql"
)
}}

我们发现，大多数情况下，在 95% 的桌面端和 94% 的移动端，manifest 是 JSON 可解析的。这表明几乎所有 Web 应用的 manifest 格式都是正确的。

这并不表示有助于安装 Web 应用的某些字段的完整性或最低可用性。事实上，manifest 文件目前没有必需的属性。从技术上讲，空文件也是有效的 manifest 文件。

Manifest 文件在向浏览器发出安装提示方面起着关键作用，尽管提示的触发方式<a hreflang="en" href="https://web.dev/installable-manifest/#in-other-browsers">因不同的浏览器而异</a>，总会涉及到 manifest 文件的一个子集。

以下是 manifest  文件与 Service Worker 一起使用的数量。这两者结合使用通常意味着 PWA 的可安装性。

{{ figure_markup(
  image="sw-manifest-usage.png",
  caption="Service Worker 及 Manifest 的使用率",
  description="柱状图显示 Service Worker、清单 manifest 文件及其在 Web 应用中的组合使用情况。 在桌面端，Service Worker 出现在 1.6% 的网站上，此时 manifest 占 8.4%，只使用其一以及两者都使用则分别占 9.2% 和 0.8%。 对于移动设备，数据分别为 1.8%、7.7%、8.6% 和 0.8%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=409958839&format=interactive",
  sheets_gid="1885116887",
  sql_file="manifests_and_service_workers.sql"
  )
}}

数据显示，Web 应用拥有 manifest 文件的可能性是 Service Worker 的 5 倍左右。一个促成因素是许多平台，例如内容管理系统 (CMS) 会为网站自动生成 manifest 文件。

只有一小部分网站（桌面和移动设备上均为 0.8%）同时实现了 Service Worker 和 manifest 文件，这意味着只有不到 1% 的网站可以像原生应用一样安装到设备上。

在本章中，我们最感兴趣的是同时具有 Service Worker 和 manifest 的站点，除非另有说明，本章中的 manifest 数据是针对 PWA 站点的。

### Manifest 成员

{{ figure_markup(
  image="top-pwa-manifest-props.png",
  caption="常用 PWA manifest 成员",
  description="柱状图显示：87% 的桌面 PWA 网站和 88% 的移动 PWA 网站使用了`name`，`display` 分别为 83% 和 85%，`icons` 为 81% 和 83%，`short_name` 为 78% 和 81 %，`start_url` 为 77% 和 81%，`background_color` 为 78% 和 80%，`theme_color` 为 73% 和 76%，`description` 为 38% 和 37%，`lang` 为 24% 和 24%，最后 `gcm_sender_id` 则是 23% 和 21%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=314127541&format=interactive",
  sheets_gid="400343770",
  sql_file="top_manifest_properties.sql"
  )
}}

与去年相比，今年 manifest 文件中使用的顶级成员没有显著变化。

请注意，`gcm_sender_id` 不是标准化成员。Google Developer Console 使用它来识别应用程序并启用旧版本的 Chrome 来实现依赖于 GCM 服务的 Web 推送。

大多数 PWA（80% 桌面端，79% 移动端）没有定义首选方向（orientation）。而 manifest 中定义该成员的最常用的值是 `portrait`，其中 13% 在桌面端，15% 用于移动网站。

#### `display` 成员

深入研究 `display` 成员，我们看到以下值：

{{ figure_markup(
  image="display-values.png",
  caption="PWA manifest display 值",
  description="柱状图显示：`standalone` 是最常用的 `display` 值，桌面端占比 71%，移动端占比 73%，`minimal-ui` 分别占 8% 和 7%，`fullscreen` 占比为 3% 和 4%，`browser` 为 1% 和 1%，而 17% 的桌面和 15% 的移动 PWA 网站没有设置该成员。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=463813741&format=interactive",
  sheets_gid="264101844",
  sql_file="top_manifest_display_values.sql"
  )
}}

`display:standalone` 是最常见的 `display` 模式，几乎 3/4 定义了 `display` 模式的网站都使用这个值。它也是使应用可安装的 `display` 模式之一。

#### `icons` 成员

{{ figure_markup(
  image="top-icon-sizes.png",
  caption="顶级 PWA 的 manifest 图标尺寸",
  description="柱状图显示: `192x192` 的桌面端占比为 72%，移动端占比为 74%；`512x512` 分别占 72% 和 69%，`144x144` 占 34% 和 32%，`96x96` 占 25% 和 24%，`72x72` 占 22% 和 22%，`384x384` 占 20% 和 18%，`48x48` 占 19% 和 18%，`152x152` 占 16% 和 15%，`120x120`  占 12% 和 11%，`256x256` 占 12% 和 10%，`128x128` 占 10% 和 11%，`64x64` 占 9% 和 7%，`36x36` 占 9% 和 8%，`32x32` 占 5% 和 5%，`180x180` 占比分别为 4% 和 5%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1961814023&format=interactive",
  sheets_gid="1009563515",
  sql_file="top_manifest_icon_sizes.sql"
  )
}}

PWA 需要生成不同的图标大小，以适应推广和显示应用的需要。很多工具支持生成桌面和移动设备所需的大量图标。Manifest 文件中最常见的两种图标大小是 `192x192` 和 `512x512`。在所分析的 manifest 文件中，这两种大小都出现的情况大约占 70%。

#### 安装和可被发现成员

Web 应用 manifest 文件包含描述应用有用的数据。应用商店或其他分发机制可以使用这些属性来推广应用。<a hreflang="en" href="https://developer.chrome.com/blog/richer-pwa-installation">基于浏览器的富安装对话框</a>的增长也在更多地利用这些字段。下面列出了manifest 文件中作为补充应用信息的一部分的相关字段：

* `description`：此成员存在于 36% 的桌面应用和 34% 的移动 Web 应用的 manifest 中。`description` 很重要，因为它解释了应用的功能。它通常用于为商店提供有关应用的信息。目前大约有 1/3 的可安装 PWA 提供这些信息。
* `screenshots`：此成员提供一个或多个屏幕截图的 URL，以在应用商店或浏览器的安装提示中使用。具有此功能的 manifest 的 PWA 在桌面端占 1.12%，在移动设备中占 1.19%。
* `categories`：类别用作目录或应用商店列表的提示。
* `iarc_rating_id`：这是一个字符串，代表 Web 应用的 <a hreflang="en" href="https://www.globalratings.com/how-iarc-works.aspx">IARC 认证代码</a>。0.05% 的桌面和移动应用利用此成员来宣传其应用或游戏的评级。

#### 类别 `categories` 成员

让我们再深入研究一下 `categories`

{{ figure_markup(
  image="top-pwa-manifest-cats.png",
  caption="顶级 PWA 的 manifest 类别",
  description="柱状图显示：`购物`类别的桌面端占比为 0.31％，移动端为 0.27％；`新闻`类别的桌面端占比为 0.27％，移动端为 0.28％；`生活方式`类别的桌面端占比为 0.15％，移动端为 0.15％；`社交`类别的桌面端占比为 0.12％，移动端为 0.18％；`教育`类别的桌面端占比为 0.16％，移动端为 0.12％；`娱乐`类别的桌面端占比为 0.13％，移动端为 0.14％；`生产力`类别的桌面端占比为 0.07％，移动端为 0.06％；`杂志`类别的桌面端占比为 0.06％，移动端为 0.07％；`体育`类别的桌面端占比为 0.07％，移动端为 0.06％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2026035912&format=interactive",
  sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

除了使用 Service Worker 来定义的 “PWA 网站” 之外，下面是所有网站的数据：

{{ figure_markup(
  image="top-manifest-cats.png",
  caption="顶级 manifest 类别",
  description="柱状图显示：`新闻`类别的桌面端占比为 0.36％，移动端为 0.37％；`购物`类别的桌面端占比为 0.36％，移动端为 0.34％；`商业`类别的桌面端占比为 0.22％，移动端为 0.20％；`社交`类别的桌面端占比为 0.16％，移动端为 0.24％；`娱乐`类别的桌面端占比为 0.18％，移动端为 0.20％；`生活方式`类别的桌面端占比为 0.19％，移动端为 0.18％；`教育`类别的桌面端占比为 0.21％，移动端为 0.16％；`游戏`类别的桌面端占比为 0.09％，移动端为 0.09％；`生产力`类别的桌面端占比为 0.09％，移动端为 0.08％；`工具`类别的桌面端占比为 0.08％，移动端为 0.08％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417728851&format=interactive",
  sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

普通网站和 PWA 的顶级类别基本一致，但略有不同。 前三类别是购物，新闻和商业。

#### 高级功能

Manifest 文件还允许激活最新的平台能力，支持操作系统的高级窗口功能或注册行为。最近已经有许多新功能得到了支持。

由于这些功能较少使用但更高级，它们没有在[我们之前的顶级 manifest 属性图](#manifest-成员)中显示，但了解它们的用法是值得的：

* `shortcuts`：6.2％ 的桌面端和 4.3％ 的移动 PWA 都使用 `shortcuts`。
* `file_handlers`：允许已安装的 PWA 注册自己作为特定文件扩展的处理程序。只有 0.01％ 的台式机和 0.02％ 的移动设备使用了`file_handlers`。
* `protocol_handlers`: 可以注册 PWA 为预定义或自定义协议的处理应用。当前桌面端使用率为 0％，移动端的使用率为 0.01％。
* `share_target`:  5.3％ 的桌面端和 3.1％ 的移动端 PWA 能够注册并接收来自其他应用的分享数据。
* <a hreflang="en" href="https://wicg.github.io/window-controls-overlay/">窗口控件覆盖</a>：允许开发人员在桌面端将自定义内容放置在由浏览器控制的标题栏区域。该功能在 Chrome 105 启用，有 0.01％的桌面 PWA 的 manifest 包含此功能。
* `note_taking`: 有 0％ 的桌面端和 0.01％ 的移动端网站正使用特殊集成的能力作为快速笔记的便利方式。

#### Manifest 原生偏向

{{ figure_markup(
  caption="移动端带有 `related_applications` 字段的 mainfest 文件",
  content="2.0%",
  classes="big-number",
  sheets_gid="228985826",
  sql_file="manifests_preferring_native_apps.sql"
)
}}

Manifest 中的 `related_applications` 成员字段旨在将该字段列出的应用替代提供类似功能的 Web 应用。从所有 manifest 文件中分析的结果表明，桌面端有 2.3％，移动端有 2.0％ 设置了该值。

## Fugu APIs

PWA 与 高级的 Web 能力齐头并进。这些能力通常是 Project Fugu 的一部分，而 Project Fugu 是 Chromium 项目孵化的新的 Web 平台能力的代号。

{{ figure_markup(
  caption="大多数使用的 Fugu API（桌面端）",
  content="8.8%",
  classes="big-number",
  sheets_gid="1110821491",
  sql_file="fugu.sql"
)
}}

Web 平台的新能力越来越多，这些是 Web 中可用于 PWA 的使用最多的 API：

<figure>
  <table>
    <thead>
      <tr>
        <th>Api</th>
        <th>桌面端</th>
        <th>移动端</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Web 共享 (Web Share)</td>
        <td class="numeric">8.8%</td>
        <td class="numeric">8.4%</td>
      </tr>
      <tr>
        <td>添加到主屏幕</td>
        <td class="numeric">8.6%</td>
        <td class="numeric">7.7%</td>
      </tr>
      <tr>
        <td>Service Worker</td>
        <td class="numeric">4.2%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Push 推送</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">1.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="大多数使用的 Fugu APIs.",
      sheets_gid="1110821491",
      sql_file="fugu.sql",
    ) }}
  </figcaption>
</figure>

由于有单独的章节介绍[能力](./capabilities)，因此在此我们不作过多叙述。

## 来自 Lighthouse 的 PWA 洞察

<a hreflang="en" href="https://developer.chrome.com/docs/lighthouse">Lighthouse</a> 是一个开源的自动化工具，用于提升网页质量。 它可在网站中运行很多检测，特别是专用于 PWA 类别的审计。 已有数据阐明了过去 12 个月关于 PWA 的一些有趣的事实。

### Lighthouse 审计

{{ figure_markup(
  image="lighthouse-pwa-audits-desktop.png",
  caption="桌面端 Lighthouse PWA 审计",
  description="柱状图显示/Lighthouse 审计：`viewport`：桌面端网页 92%，桌面端 PWA 99%；`installable-manifest` 分别为 9% 和 90%；`apple-touch-icon` 为 42% 和 80%；`service-worker` 为 2% 和 69%；`themed-omnibox` 有 6% 和 62%；`splash-screen` 有 3% 和 51%；`maskable-icon` 在所有桌面网站中有 1% 而在桌面 PWA 中占比 21%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2100711487&format=interactive",
  sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

与普通的网站相比，通过 PWA 审计的 PWA 网站更多并不奇怪，尽管某些审计例如 <a hreflang="en" href="https://web.dev/viewport/#how-to-add-a-viewport-meta-tag">viewport meta 标签</a> 以及 <a hreflang="en" href="https://web.dev/apple-touch-icon/#how-the-lighthouse-apple-touch-icon-audit-fails">apple-touch-icon</a> 也经常出现在非 PWA 网站中。

{{ figure_markup(
  image="lighthouse-pwa-audits-mobile.png",
  caption="移动端 Lighthouse PWA 审计",
  description="柱状图显示/Lighthouse 审计：`viewport`：移动端网页 93%，移动端 PWA 100%；`content-width` 分别为 83% 和 95%；`installable-manifest` 分别为 8% 和 93%；`apple-touch-icon` 为 42% 和 79%；`service-worker` 为 2% 和 75%；`themed-omnibox` 有 5% 和 65%；`splash-screen` 有 3% 和 53%；`maskable-icon` 在所有移动端网站中有 1% 而在移动端 PWA 中占比 21%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=51840174&format=interactive",
  sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

我们看到 Lighthouse 关于移动网站一些类似的统计数据，仅用于移动端的 <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/pwa/content-width">content-width</a> 元标签都通过了。

Viewport 元标签的存在很重要，因为它在以重新缩放的方式等待双击时移除了 300-350ms 的延迟。在移动设备上，它还具有为屏幕尺寸优化应用的额外好处 。几乎所有 PWA 的网站都包含这个标签毫不奇怪。

可安装 manifest 也在两个列表中位列前 3。 不出所料，这对 PWA 站点很有价值，无论是在桌面端（90.2％）还是移动设备（95.2％）。但对所有网站来说该数据却非常低，可能是因为开发人员不打算安装这些网站。

最后，`apple-touch-icon` 在与 PWA 相关的 Lighthouse 审计中排名第三。 自 iOS 1.1.3 以来，iOS Safari 支持开发人员指定用于主屏的网站或应用的图片，这主要还是移动端相关的。

### Lighthouse 评分

作为 Lighthouse 洞察部分的总结，让我们看看基于审计的 PWA 站点的 Lighthouse PWA 总体得分。

{{ figure_markup(
  image="lighthouse-scores-desktop.png",
  caption="桌面 Lighthouse 得分",
  description="桌面端柱状图：在第 10 个百分位，所有站点的 Lighthouse PWA 中位数为 22，而 PWA 站点的中位数为 44；在第 25 个百分位分别为 22 和 67；在第 50 个百分位，得分分别为 22 和 78，在第 75 个百分位，得分分别是 33 和 89，最后在第 90 个百分位，所有站点的 Lighthouse PWA 得分中位数为 33，而PWA 站点为 100。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1918292266&format=interactive",
  sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

{{ figure_markup(
  image="lighthouse-scores-mobile.png",
  caption="移动端 Lighthouse 得分",
  description="移动端柱状图：在第 10 个百分位，所有站点的 Lighthouse PWA 中位数为 20，而 PWA 站点的中位数为 50；在第 25 个百分位分别为 30 和 70；在第 50 个百分位，得分分别为 30 和 80，在第 75 个百分位，得分分别是 40 和 90，最后在第 90 个百分位，所有站点的 Lighthouse PWA 得分中位数为 40，而PWA 站点为 100。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1463181209&format=interactive",
  sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

正如预期的那样，PWA 网站的 PWA 审计分数往往要高得多。 这些审核会检测速度、可靠性、可安装性和其他的 PWA 需求，详见他们的<a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/pwa">文档</a>。

同样值得注意的是 PWA 站点中的审计分数范围（50-100）代表了 PWA 的差异。 相比之下，其余网站的分数范围相当一致（20-40），这反映了之前讨论的大多数网站相关的两个主要审计内容：viewport 和图标 icons。

## Service Worker 库

Service Workers 非常强大，这些 API 允许开发人员创建以前不可能实现的应用体验，例如离线体验或缓存资产以提高性能。但是，处理 Web 应用和网络之间关系的代码会带来复杂性和更多问题。下面的一些库围绕 Service Worker API 提供了更高级别的抽象，让开发人员的工作更便捷。

### Workbox 的使用

<a hreflang="en" href="https://developer.chrome.com/workbox/">Workbox</a> 是一组库，旨在简化开发人员对 Service Worker 的使用。这些库包含在其他 Workbox 库中重用的带有 <a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-core">workbox-core</a>的基础知识，到更具体的任务，如<a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-strategies">缓存策略</a>、<a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-background-sync">后台同步</a>、<a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-precaching">预缓存</a> 以及<a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules">更多</a>。

{{ figure_markup(
  image="workbox-usage.png",
  caption="PWA 页面的 Workbox 使用率",
  description="柱状图显示 Workbox 在 PWA 页面中的使用率：桌面网站从 33% 增加到 59%，移动网站从 32% 增加到了 54%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417225871&format=interactive",
  sheets_gid="1871711300",
  sql_file="workbox_usage.sql"
  )
}}

与去年相比，我们看到 Workbox 的使用量出现了大幅增长。 去年，它在移动设备上的使用率为 33%，而今年为 54%，近 60% 的桌面 PWA 在一定程度上使用了 Workbox。

Service Workers 控制的页面数量的增长不在前 1000 个网站，而是在更细化的类别中。而 Workbox 使用量的增长，我们能够推断各大公司和网站内部正在采用 Workbox，他们也许在等待顶级网站采用该技术，或者不需要完全自定义的 Service Workers 实现，而是充分利用开箱即用的 Workbox。

#### Workbox 包

Workbox 可以使开发人员根据站点的需要选择将哪些部分添加到他们的项目中。 下面显示的用法有助于我们记录开发人员目前正在实施哪些 PWA 功能。

{{ figure_markup(
  image="top-workbox-packages.png",
  caption="Top Workbox packages.",
  description="柱状图显示，`core` 是使用最多的 Workbox 包，在 36% 的桌面和 37% 的移动 PWA 网站上使用，`sw` 次之，分别为 29% 和 31%，其次是 `routing`，占 28% 和 31%，然后是 23% 和 21% 的 `strategies`，然后是 22% 和 18% 的 `precaching`，接着是 10% 和 9% 的 `expiration`，然后是 9% 和 8% 的  `window`，然后是 5% 和 4% 的 `background-sync`，然后 `cacheable-response` 占比 4% 和 4%，最后 `navigation-preload` 用于 4% 的桌面和 3% 的移动 PWA 网站。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=205966463&format=interactive",
  sheets_gid="122135540",
  sql_file="workbox_packages.sql"
  )
}}

我们还看到 `workbox-core` 整体使用量的增加。基础库的使用量增加了 14%。`workbox-core` 与 `workbox-routing` 和 `workbox-strategies` 一起用于创建缓存策略，用于在其 Web 应用中提供不同的工件以提高性能。有意义的是，它们都处于领先地位，因为它们能够为 Service Workers 带来核心利益。

`workbox-precaching` 的使用也有相当大的跳跃。预缓存可用于模拟打包应用的使用。使用 `workbox-precaching`，您可以在 Service Worker 安装时选择将要缓存的资产，以使这些资产在后续访问中加载得更快。

令人惊讶的是 `workbox-sw` 使用率的上升，因为从 <a hreflang="en" href="https://github.com/GoogleChrome/workbox/releases/tag/v5.0.0">Workbox 5</a> 开始，Workbox 团队鼓励开发人员创建 Workbox 运行时的自定义包，而不是使用 `importScripts()` 来加载 <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-sw">`workbox-sw`</a>（运行时）。Workbox 团队将继续支持 _workbox-sw_，但现在推荐使用新技术。 事实上，构建工具的默认设置已切换为推荐的方法。

这个数字的增加有可能是因为使用了旧版本 Workbox 库，例如 <a hreflang="en" href="https://github.com/facebook/create-react-app/blob/v3.4.4/packages/react-scripts/package.json#L82">`create-react-app` 版本 3</a>

### Web 推送通知 Push Notifications

通知是与用户重新互动的有效方式。这也是我们对特定平台应用的期望之一。通知是提供及时、相关和准确信息的完美方式，它由 Web Push API 提供支持。

#### Web 推送通知 Push Notifications 接受率

对于开发人员或用户来说，Web 通知的实现并不一定顺畅，但这确实是非常有用的工具。 对于日历通知、订阅更新或者游戏来说，用户可以选择何时打开它们是很重要的。

值得重申的是，通知必须<a hreflang="en" href="https://developers.google.com/web/fundamentals/push-notifications">及时、准确和相关</a>才有意义。在显示请求权限提示的那一刻，用户需要了解服务的价值。开发人员有机会分享给用户获得特定通知的好处，在用户显示浏览器权限对话框之前将其加入通知。

{{ figure_markup(
  image="notification-acceptance.png",
  caption="通知接受率",
  description="堆栈图显示，在桌面端，6% 的通知被接受，7% 被拒绝，70% 被忽略，17% 被驳回。 在移动端，19% 的通知被接受，35% 被拒绝，34% 被忽略，13% 被驳回。 在移动设备接受或拒绝的比例要高得多，而忽略的比例要小得多。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=148157045&format=interactive",
  sheets_gid="435156894",
  sql_file="pwa_notification_acceptance_rates.sql"
  )
}}

随着通知支持的增长和不同平台用户体验的改进，在接受通知方面没有重大变化。自 2020 年初以来，桌面端接受率约为 6%，移动设备接受率为 20%。

桌面端和移动端的通知接受率趋于一致，忽略通知是趋势。 “忽略”的总和从 2020 年 2 月的 48% 一路上升到 2022 年 6 月的 70%。对于移动平台，从 2020 年 2 月的 1.88% 上升到今年 6 月的惊人的 34%。 通知疲劳，加上越来越多的安全、隐私和高级功能提示是部分原因，相关的工作正在开展来解决这个问题，并在不同平台上提供更好的统一的用户体验。

## 总结

2022 年对于 PWA 来说是辉煌的一年。允许将可安装 Web 应用与桌面平台集成的功能不断增加，推动了该技术被业内知名厂商采用。在过去的一年里，协议处理（protocol handlers）、窗口控件覆盖（window controls overlay）、在系统登录时运行等高级功能已将 PWA 定位为应用开发的关键技术。虽然令人鼓舞，但这并不代表整个 Web 平台。与 2021 年的数据相比，Service Worker 的使用百分比下降到一半左右，但使用 PWA 技术构建的大型应用正在兴起。

Manifest 文件继续处于健康状态，桌面端的比例比去年略有增加，达到了 95%。这些文件的正确性非常好，但它们的完整性仍有诸多不足。目前，只有大约 0.8% 的网站符合可安装的条件。许多高级功能，如 `shortcuts`  和 `share_target` 开始受到关注，出现在大约 5% 的 PWA 中。`protocol_handlers` 和窗口控件覆盖等功能太新，暂时无法对数据产生影响。今年还提供了许多 Fugu API 的初始快照。

可以理解，通知疲劳仍然是一个因素，但用户也会请求并欣赏合法的通知用例。浏览器厂商正在尝试侵入性较低的权限请求，而 Web 推送通知的优势在于提供跨平台的一致体验，从而为用户提供他们所请求的与设备无关的轻推。

我们希望这些信息能为您的 PWA 之旅提供一些启示，并帮助开发人员了解在 API 适配方面的技术趋势。
