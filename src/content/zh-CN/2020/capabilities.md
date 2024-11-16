---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 能力
description: 2020年 Web Almanac网络年鉴中的能力篇，涵盖了全新的、强大的网络平台API。
hero_alt: Hero image of Web Almanac charactes with superhero capes plugging various capabilities into a web page.
authors: [christianliebel]
reviewers: [tomayac]
analysts: [tomayac]
editors: [rviscomi]
translators: [chengxicn]
discuss: 2049
results: https://docs.google.com/spreadsheets/d/1N6j1qKv7vc51p1W9z_RrbJX9Se3Pmb-Uersfz4gWqqs/
christianliebel_bio: Christian Liebel 是<a hreflang="en" href="https://thinktecture.com">Thinktecture</a>, 的顾问，支持来自不同业务领域的客户实现一流的网络应用。他是微软开发者技术的MVP，也是 Web/能力 和 Angular的 Google GDE，并且参加了W3C Web应用工作组。
featured_quote: 2020年的Web能力（Capability）状态是健康的，因为新的、强大的API定期与基于Chromium的浏览器的新版本一起发布。一些API已经进入了其他非Chromium的浏览器。
featured_stat_1: 0.0006%
featured_stat_label_1: (Chrome) 使用异步剪贴板API加载页面
featured_stat_2: 0.49%
featured_stat_label_2: 使用存储管理API的网站
featured_stat_3: 363
featured_stat_label_3: 网站允许安装相关应用程序
---

## 介绍

[渐进式Web应用](./pwa) (PWA)是一种基于网络技术的跨平台应用模型。在 Service Workers的帮助下，这些应用即使在用户离线时也可以运行。[Web应用程序清单](https://developer.mozilla.org/docs/Web/Manifest) 允许用户将PWA添加到主屏幕或程序列表中。当从那里打开时，PWA将作为原生应用Native App出现。然而，PWA只能使用通过Web平台API暴露的功能和能力，而无法调用任意的本地接口，这使得Native App和Web App之间留下了一个缺隙。

<a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">能力项目</a>，非正式的被称为<span lang="en">Project Fugu</span>，是谷歌、微软和英特尔通过跨公司的努力来弥补web和原生之间差距的工程项目。这对于保持web作为一个平台的相关性非常重要。为此，Chromium的贡献者们实现了新的API，将操作系统的能力（capability）暴露给网络，同时维护用户的安全、隐私和信任。这能力包括但不局限于:

- <a hreflang="en" href="https://web.dev/file-system-access/">文件系统访问 API</a> 用于访问本地文件系统的文件
- <a hreflang="en" href="https://web.dev/file-handling/">文件Handling API</a> 为特定的文件扩展注册一个 handler
- <a hreflang="zh" href="https://web.dev/i18n/zh/async-clipboard/">异步剪贴板 API</a> 访问用户剪贴板
- <a hreflang="en" href="https://web.dev/web-share/">Web共享 API</a> 和其他应用共享文件
- <a hreflang="zh" href="https://web.dev/i18n/zh/contact-picker/">联系人 API</a> 从用户地址簿访问联系人
- <a hreflang="en" href="https://web.dev/shape-detection/">形状检测 API</a> 用于高效检测图像中的人脸或条形码
- <a hreflang="en" href="https://web.dev/nfc/">Web NFC</a>, <a hreflang="ja" href="https://web.dev/i18n/ja/serial/">Web 串口</a>, <a hreflang="zh" href="https://web.dev/i18n/zh/usb/">Web USB</a>, <a hreflang="zh" href="https://web.dev/i18n/zh/bluetooth/">Web 蓝牙</a>，以及其他 API (完整列表请参考 <a hreflang="en" href="https://goo.gle/fugu-api-tracker">Fugu API Tracker</a>)

任何人都可以通过<a hreflang="en" href="https://bit.ly/new-fugu-request">在Chromium bug追踪器中创建一个票据</a>来提出一个新的能力。Chromium的贡献者会对这些建议进行审查，并通过相应的标准机构与其他开发者和浏览器厂商讨论所有的API。同时，Fugu团队在Chromium中实现API，在Chromium中，它最初是在一个标记后面实现的。后期，API会通过<a hreflang="en" href="https://web.dev/origin-trials/">原点试用</a>(origin trial)向有限的受众开放。在这个阶段，开发者可以注册一个令牌，在特定的原点上测试API。如果这个API被证明足够强健，API就会在Chromium中发布，如果其他浏览器厂商也决定这样做，也会在其他浏览器中发布。<a hreflang="zh" href="https://web.dev/i18n/zh/fugu-status/">能力状态</a>网站显示了不同的能力API在这个进程中的位置。

能力项目的代号 "Project Fugu "是以日本的一道菜命名的：如果正确的加工食材，那么河豚的肉是一种特别的味蕾体验。然而如果食材加工不当，则可能是致命的。Fugu项目强大的API对于开发者来说是非常令人兴奋的。但是，它们可能会影响到用户的安全和隐私。因此Fugu团队特别关注这些问题。例如，新的接口要求网站通过安全连接（HTTPS）发送。其中一些功能需要用户的动作，如点击或按键，以防止欺诈。别的功能则需要用户的明确许可。开发者可以用一种渐进式的功能扩展来使用所有的API：通过对API的特性检测，应用程序在缺乏对这些能力支持的浏览器中不会崩溃。在支持这些功能的浏览器中，用户可以获得更佳的体验。这样一来，Web应用就会根据用户的特定浏览器<a hreflang="en" href="https://web.dev/progressively-enhance-your-pwa/">渐进式增强</a>。

本章根据HTTP Archive和<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity">Chrome平台状态</a>的使用数据，综述了各种现代Web API，还有2020年Web能力的状态。由于一些接口是全新的，它们的（相对）使用率非常低。因此，与大多数章节不同，HTTP Archive的使用量统计将以页面的绝对数量而非相对百分比的形式呈现。由于[技术限制](./methodology#metrics)，HTTP Archive只有那些既不需要权限，也不需要用户动作的API的数据。在没有数据的情况下，将根据Chrome平台状态显示Google Chrome浏览器中的页面加载百分比。即使有些数字太小，统计数据不一定有意义，但在很多情况下仍然可以从数据中读出趋势。另外，这些统计数据还可以作为本章未来年度版本的基线，来回顾这些API的成熟度和改进采用情况。除非另有说明，否则这些API只适用于基于Chromium的浏览器，其规范还处于标准化的早期阶段。

## 异步剪贴板API

在`document.execCommand()`方法的帮助下，网站已经可以访问用户的剪贴板。但是这种方法受到了一定的限制，因为API是同步的（使得处理剪贴板条目很困难），而且它只能与DOM中选定的文本交互。这就是<a hreflang="en" href="https://webkit.org/blog/10855/async-clipboard-api/">异步剪贴板API</a>(<a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#async-clipboard-api">W3C工作草案</a>)的作用。这个新的API是异步的，这意味着它不会因为大块数据而阻塞页面或等待授予权限，同时它还允许在支持的浏览器（如Chrome、Edge和Safari）中从剪贴板复制或粘贴图片。

### 读访问

异步剪贴板API提供了两种从剪贴板读取内容的方法：一种是针对纯文本的速记方法，称为`navigator.clipboard.readText()`，另一种是针对任意数据的方法，称为`navigator.clipboard.read()`。目前，大多数浏览器只支持HTML内容和PNG图片作为附加数据格式。由于剪贴板可能包含敏感数据，从剪贴板读取数据需要得到用户的同意。

{{ figure_markup(
  image="async_clipboard_api.png",
  caption='在Chrome中使用异步剪贴板 API的页面加载百分比。<br>(来源: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2369">异步剪贴板读</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2370">异步剪贴板写</a>)',
  description="异步剪贴板 API使用情况图，基于Chrome浏览器中使用该功能的页面加载百分比。它比较了读和写方法的使用情况，显示在2020年期间，写的使用量呈指数级增长，而读的使用量则呈线性增长。在2020年10月，在Chrome浏览器所有页面加载过程中，0.0003%的页面加载过程中调用了读，0.0006%的页面加载过程中调用了写。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1740212588&format=interactive",
  sheets_gid="2077755325"
  )
}}

由于异步剪贴板API比较新，所以目前的使用率相当低。2020年3月，Safari在版本13.1中增加了对异步剪贴板API的支持。在2020年间，`read()`API的使用率越来越高。在2020年10月的谷歌Chrome浏览器中，0.0003%的页面加载过程中调用了该API。

### 写访问

除了读取操作外，异步剪贴板API还提供了两种向剪贴板写入内容的方法。同样，有一个针对纯文本的速记方法，叫做`navigator.clipboard.writeText()`，还有一个针对任意数据的方法，叫做`navigator.clipboard.write()`。在基于Chromium的浏览器中，当标签页处于活动状态时，向剪贴板写入内容不需要权限。但是，当网站处于后台时，试图向剪贴板写入数据则需要权限。由于这种方法需要先有用户的动作和权限，所以不在HTTP Archive指标的范围内。与`read()`方法相比，`write()`方法的使用量呈指数级增长，在2020年10月占了所有页面加载过程的0.0006%。

<a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=897289">原始剪贴板访问API</a>是Fugu的另一个能力，它甚至可以通过允许从剪贴板复制或粘贴任意数据来进一步增强异步剪贴板API。

## 存储管理(<span lang="en">StorageManager</span>)API {存储管理storagemanagerapi}

Web浏览器允许用户以不同的方式在用户系统上存储数据，如Cookie、索引数据库(IndexedDB)、Service Worker的缓存存储或Web存储(本地存储、会话存储)。在现代的浏览器中，取决于浏览器，开发者可以轻松<a hreflang="zh" href="https://web.dev/i18n/zh/storage-for-the-web/">存储数百兆甚至更多</a>。当浏览器的空间耗尽时，可以清除数据，直到系统不再超过限制（可能导致数据丢失）。

归功于[存储管理API](https://developer.mozilla.org/docs/Web/API/StorageManager)，它是<a hreflang="en" href="https://storage.spec.whatwg.org/#storagemanager">WHATWG 存储动态标准</a>的一部分，使得浏览器在这方面的表现不再像一个黑盒子了。这个API允许开发者估计剩余的可用空间，并选择加入<a hreflang="en" href="https://web.dev/persistent-storage/">持久性存储</a>，这意味着当磁盘空间不足时，浏览器不会清除网站的数据。因此，该API在`navigator` 对象上引入了一个新的`StorageManager`接口，目前在Chrome、Edge和Firefox上都支持。

### 预估可用存储

开发者可以通过调用`navigator.storage.repair()`来估计可用的存储空间。该方法返回一个承诺(promise)，解析为一个具有两个属性的对象：`usage`显示应用程序使用的字节数，`quota`包含可用的最大字节数。

{{ figure_markup(
  image="storage_manager_api_estimate.png",
  caption="使用存储管理 API的预估方法的页数。",
  description="根据HTTPArchive监控的页面数量，存储管理 API的预估方法的使用情况图。它比较了移动设备和桌面设备上的使用情况。它显示了桌面上的线性增长，而它同时显示了移动设备的爆炸性增长。在10月份，大约有34000个移动网站和27000个桌面网站利用它。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1853644024&format=interactive",
  sheets_gid="1811313356",
  sql_file="durable_storage_estimate_usage.sql"
  )
}}

Chrome浏览器从2016年开始支持存储管理API，Firefox以及基于Chromium的新Edge浏览器是从2017年开始支持的。HTTP Archive数据显示，27,056个桌面页面（0.49%）和34,042个移动页面（0.48%）使用了该API。在2020年之间，存储管理器API的使用量不断增长。这也使得该接口成为本章中最常用的API。

### 选择加入持久存储

Web存储有两类。"尽力"和 "持久"，第一种是默认的。当设备的存储空间不足时，浏览器会自动尝试释放出尽力存储空间。例如，基于Firefox和Chromium的浏览器会从最近使用最少的源回收存储。然而，这带来了丢失关键数据的风险。为了防止回收，开发者可以选择持久存储。在这种情况下，即使空间不足浏览器也不会清除存储。用户仍然可以选择手动清理存储。要选择持久存储，开发者需要调用`navigator.storage.persist()`方法。根据浏览器和网站的参与情况，可能会出现权限提示，或者自动接受和拒绝请求。

{{ figure_markup(
  image="storage_manager_api_persist.png",
  caption="使用存储管理 API的持久方法的页面数。",
  description="根据HTTPArchive监控的页面数量，存储管理 API的持久化方法的使用情况图。它比较了移动设备和桌面设备上的使用情况。在桌面页面上，使用量几乎是稳定的，而在移动设备上则有更多的波动。在2020年10月，有25个桌面页面和176个移动页面利用该API。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=644836316&format=interactive",
  sheets_gid="1095648844",
  sql_file="durable_storage_persist_usage.sql"
  )
}}

`persist()`API的调用频率低于`estimate()`方法。只有176个移动网页使用了这一API，桌面站点只有25个。桌面上的使用量保持于低位，同时在移动设备上也没有明显的趋势。

## 新的通知API

在推送和通知API的帮助下，Web应用早已能够接收推送消息和显示通知横幅。不过，还有一些部分缺失。到目前为止，推送消息必须通过服务器发送；它们不能被安排离线。此外，安装到系统中的Web应用也不能在其图标上显示角标。角标和通知触发器API可以实现这两种情况。

### 角标（<span lang="en">Badging</span>）API {角标-badging-api}

在一些平台上，会较常见到应用程序在图标上显示一个角标来表明打开操作的量。例如，角标可以显示未读邮件、通知或待办事项的数量。<a hreflang="en" href="https://web.dev/badging-api/">角标API</a> (<a hreflang="en" href="https://w3c.github.io/badging/">W3C非官方草案</a>)允许已安装的Web应用程序在其图标上显示这样的角标。通过调用`navigator.setAppBadge()`，开发者可以设置角标。这个方法需要一个数字来显示在应用程序的角标上。然后浏览器负责在用户的设备上显示最接近的表示。如果没有指定数字，则会显示一个通用的角标（例如，macOS上的一个白点）。调用`navigator.clearAppBadge()`会再次移除角标。角标API是电子邮件客户端、社交媒体应用或消息工具的绝佳选择。Twitter PWA利用角标API在应用程序的角标上显示未读通知的数量。

{{ figure_markup(
  image="badging_api.png",
  caption='在Chrome浏览器中使用角标 API的页面加载百分比。<br>(来源: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2726">角标设置</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2727">角标清除</a>)',
  description="角标 API 使用情况的图表，基于 Chrome 浏览器中使用该功能的页面加载百分比。它比较了设置方法和清除方法。随着时间的推移，两种方法的使用量都在增长，一般来说，设置方法的调用频率更高。在2020年10月，这两种方法都会有一个突飞猛进的增长，最高峰时，设置方法占页面加载的0.025%，清除方法占页面加载的0.016%。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1145004925&format=interactive",
  sheets_gid="1154751352"
  )
}}

2020年4月，谷歌Chrome版本81支持了新的角标API，随后微软Edge版本84在7月支持。在Chrome支持了这个API后，使用量直线上升。2020年10月，在谷歌浏览器中0.025%的页面加载中，`setAppBadge()`方法被调用。`clearAppBadge()`方法被调用的次数较少，在大约0.016%的页面加载中被调用。

### 通知触发器API

推送API需要用户在线接收通知。一些应用程序，如游戏、提醒或待办应用、日历或闹钟，也可以在本地确定通知的目标日期，并做出安排。为了支持这个功能，Chrome团队正在试验一个新的API，名为<a hreflang="en" href="https://web.dev/notification-triggers/">通知触发器</a>(<a hreflang="en" href="https://github.com/beverloo/notification-triggers/blob/master/README.md">解释</a>，还没有进入标准轨道)。这个API在`options`映射中添加了一个名为`showTrigger` 的新属性，可以传递给Service Worker注册时的 `showNotification()` 方法。该API的设计是为了在未来允许不同类型的触发器，尽管目前只实现了基于时间的触发器。对于基于某个日期和时间的通知调度，开发者可以创建一个新的`TimestampTrigger`实例，并将目标时间戳传递给它。

```js
registration.showNotification('Title', {
  body: 'Message',
  showTrigger: new TimestampTrigger(timestamp),
});
```

{{ figure_markup(
  image="notification_triggers_api.png",
  caption='在Chrome浏览器中使用通知触发器API的页面加载百分比。<br>(来源: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">通知触发器</a>)',
  description="通知触发器API使用情况的图表，基于使用该功能的Chrome浏览器中页面加载的百分比。它显示了2020年3月的峰值，约占页面加载的0.00003%，在2020年10月下降到零。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1388597384&format=interactive",
  sheets_gid="1740370570"
  )
}}

从Chrome 80到83版本，Fugu团队首次在初期试用中尝试使用通知触发器，之后由于开发者反馈不足而暂停开发。从2020年10月发布的Chrome 86开始，API再次进入初期试用阶段。这也解释了通知触发API的使用数据，在2020年3月左右的第一次初期试用中的调用达到了峰值，在Chrome浏览器中占0.000032%的页面加载量。

## 屏幕唤醒锁定API

为了节约能源，移动设备会将屏幕背光变暗，最终关闭设备的显示屏，这在大多数情况下是合理的。然而，在某些情况下，用户可能希望应用程序明确地保持显示屏的唤醒，例如，在做饭时阅读菜谱或观看演示时。[屏幕唤醒锁定API](https://developer.mozilla.org/docs/Web/API/Screen_Wake_Lock_API)(<a hreflang="en" href="https://www.w3.org/TR/screen-wake-lock/">W3C工作草案</a>)通过提供一种保持屏幕开启的机制来解决这个问题。

`navigator.wakeLock.request()`方法创建一个唤醒保持锁。这个方法需要一个`WakeLockType`参数。在未来，唤醒保持API可以提供其他的保持类型，比如关闭屏幕但保持CPU开启。目前，该API只支持屏幕唤醒的保持，所以只有一个可选的参数，默认值为`screen`。该方法返回一个承诺，该承诺解析为一个`WakeLockSentinel`对象。开发者需要存储这个引用，以便以后调用它的`release()`方法，释放屏幕唤醒保持锁。当标签页处于非活动状态，或者用户将窗口最小化时，浏览器会自动释放保持锁。另外，浏览器可能会拒绝请求，拒绝承诺，例如由于电池电量不足的时候。

{{ figure_markup(
  image="screen_wake_lock_api.png",
  caption="使用屏幕唤醒锁定 API的页面数量。",
  description="屏幕唤醒锁定API使用情况图，基于HTTP Archive监控的页面数量，对比桌面和移动页面。在2020年10月，该API被10个桌面页面和5个移动页面使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=718278185&format=interactive",
  sheets_gid="1008442251",
  sql_file="wake_lock_acquire_screen_lock_usage.sql"
  )
}}

BettyCrocker.com是美国一家很受欢迎的烹饪网站，在屏幕唤醒锁定 API的帮助下，他们为用户提供了一个防止烹饪时屏幕变黑的选项。在一项<a hreflang="en" href="https://web.dev/betty-crocker/">案例研究</a>中，他们公布了平均会话时长是正常时长的3.1倍，跳出率降低了50%，购买意向指标增加了约300%。因此，界面对网站或应用的成功与否，分别有直接可衡量的影响。2020年7月，屏幕唤醒保持API与谷歌浏览器84一起发布。HTTP Archive 只有4月、5月、8月、9月和10月的数据。Chrome 84发布后，使用量迅速上升。2020年10月，该API在10个桌面和5个移动页面上被采用。

## 空闲检测API

一些应用程序需要确定用户是否在活跃的使用设备，或是否处于闲置状态。例如，聊天应用可能会显示用户不在。有多种因素可以考虑，例如缺乏与屏幕、鼠标或键盘的交互。<a hreflang="en" href="https://web.dev/idle-detection/">空闲检测 API</a>(<a hreflang="en" href="https://wicg.github.io/idle-detection/">WICG 社区小组报告草案</a>)提供了一个抽象的 API，允许开发者在给定一定阈值的情况下，检查用户是否处于闲置状态或锁屏状态。

为此，API在全局`window`对象上提供了一个新的`IdleDetector`接口。在开发者使用这个功能之前，他们必须先调用`IdleDetector.requestPermission()`来请求权限。如果用户授予权限，开发者就可以创建一个新的`IdleDetector`实例。这个对象提供了两个属性。`userState`和`screenState`，包含各自的状态。当用户或屏幕的状态发生变化时，它将引发一个`change`事件。最后，需要通过调用其`start()`方法来启动空闲检测器。该方法需要一个配置对象，有两个参数：一个`阈值`定义用户必须处于空闲状态的时间，单位是毫秒（最小是一分钟），开发者可以选择给`abort`属性传递一个`AbortSignal`，它的作用是在以后中止空闲检测。

{{ figure_markup(
  image="idle_detection_api.png",
  caption='使用空闲检测 API 的 Chrome 浏览器中页面加载的百分比。<br>(Source: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">空闲检测</a>)',
  description="空闲检测API使用情况图，基于Chrome中使用该功能的页面加载百分比。只有2020年7月和10月的数据，显示该API的采用率非常低。.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=963792757&format=interactive",
  sheets_gid="1324588405"
  )
}}

在写这篇文章的时候，空闲检测API正处于初期试用阶段，所以它的API形态在未来可能会发生变化。出于同样的原因，它的使用率非常低，几乎无法衡量。

## 周期性后台同步API

当用户关闭一个Web应用时，它就无法再与其后端服务进行通信。在某些情况下，开发人员可能仍然希望或多或少地定期同步数据，就像本地应用程序一样。例如，新闻应用可能希望在用户醒来之前下载最新的头条新闻。<a hreflang="zh" href="https://web.dev/i18n/zh/periodic-background-sync/">周期性后台同步API</a>(<a hreflang="en" href="https://wicg.github.io/periodic-background-sync/">WICG 社区小组报告草案</a>)力图弥合web和原生应用之间的这个差距。

### 注册定期同步

周期性后台同步 API 依赖于即使在应用关闭时也能运行的 Service Worker。与其他功能一样，这个API首先需要用户的许可。该API实现了一个名为`PeriodicSyncManager`的新接口。如果存在，开发者可以在Service Worker的注册上访问这个接口的实例。要在后台同步数据，应用程序必须先进行注册，在注册时调用`periodicSync.register()`。这个方法需要两个参数：一个是`tag`，这是一个任意的字符串，用于以后再次识别注册；一个是配置对象，需要一个`minInterval`属性。这个属性由开发者定义了所需的最小间隔时间，单位为毫秒。然而，浏览器最终决定它实际调用后台同步的频率。

```js
registration.periodicSync.register('articles', {
  minInterval: 24 * 60 * 60 * 1000 // one day
});
```

### 定期同步间隔的响应

对于间隔的每一个周期，如果设备在线，浏览器会触发服务工作程序的 "periodicsync "事件。然后，服务工作程序脚本可以执行必要的步骤来同步数据。

```js
self.addEventListener('periodicsync', (event) => {
  if (event.tag === 'articles') {
    event.waitUntil(syncStuff());
  }
});
```

在撰写本文时，只有基于Chromium的浏览器实现了这个API。在这些浏览器上，必须先安装应用程序（即添加到主屏幕上），然后才能使用该API。网站的<a hreflang="en" href="https://www.chromium.org/developers/design-documents/site-engagement">网站参与度评分</a>定义了是否可以调用周期性同步事件以及调用的频率。在目前保守的实现中，网站每天可以同步一次内容。

{{ figure_markup(
  image="periodic_background_sync_api.png",
  caption="使用周期性后台同步 API的页面数量。",
  description="基于HTTPArchive监控的页面数量的周期性后台同步 API使用情况图。它比较了移动和桌面设备上的使用情况。自2020年4月以来，该API被一到两个桌面和移动页面使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1444904371&format=interactive",
  sheets_gid="386193538",
  sql_file="periodic_background_sync_usage.sql"
  )
}}

目前，该接口的使用率非常低。在2020年，HTTP Archive监测到的网页中只有一两个页面使用了这个API。

## 同原生应用商店集成

PWA是一种多功能的应用模式。然而，在某些情况下，提供一个单独的原生应用可能仍然是有意义的：例如，如果应用需要使用网络上无法使用，或者基于应用开发团队的编程经验的功能。当用户已经安装了一个原生应用时，应用可能不希望发送两次通知或推广安装相应的PWA。

为了检测用户在系统中是否已经有相关的原生应用或PWA，开发者可以在`navigator`对象上使用<a hreflang="en" href="https://web.dev/get-installed-related-apps/">getInstalledRelatedApps()方法</a>(<a hreflang="en" href="https://wicg.github.io/get-installed-related-apps/spec/">WICG社区组报告草案</a>)。该方法目前由基于Chromium的浏览器提供，适用于Android和通用Windows平台（UWP）应用。开发者需要调整本地应用捆绑以引用网站，并将本地应用的信息添加到PWA的Web应用清单中。调用`getInstalledRelatedApps()`方法将返回用户设备上安装的应用列表。

```js
const relatedApps = await navigator.getInstalledRelatedApps();
relatedApps.forEach((app) => {
  console.log(app.id, app.platform, app.url);
});
```

{{ figure_markup(
  image="get_installed_related_apps.png",
  caption="使用 getInstalledRelatedApps() 的页面数量",
  description="getInstalledRelatedApps() 使用情况的图表，基于HTTP Archive监控的页面数量。它比较了移动设备和桌面设备上的使用情况。它显示了移动设备的稳定增长，在2020年10月达到顶峰，为363页，而桌面页面为44页。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1774881171&format=interactive",
  sheets_gid="860146688",
  sql_file="get_installed_related_apps_usage.sql"
  )
}}

在2020年期间，`getInstalledRelatedApps()`API在移动网站上呈现出稳定的增长。10月份，HTTP Archive跟踪的363个移动页面使用了这个API。在桌面页面上，该API的增长速度没有那么快。这也可能是由于Android商店目前提供的应用明显多于微软商店为Windows提供的应用。

## 内容索引 API

Web应用可以使用各种方式离线存储内容，比如Cache Storage，或者IndexedDB。然而，对于用户来说，很难发现哪些内容是离线可用的。<a hreflang="en" href="https://web.dev/content-indexing-api/">内容索引API</a>(<a hreflang="en" href="https://wicg.github.io/content-index/spec/">WICG编辑草案</a>)可以让开发者更加突出地暴露内容。目前，Android上的Chrome是唯一支持该API的浏览器。该浏览器在下载菜单中显示了 "为您提供的文章 "列表。通过内容索引 API 索引的内容将出现在那里。

内容索引 API 通过提供新的`ContentIndex`接口扩展了 Service Worker API。这个接口可以通过Service Worker注册的`index`属性获得。`add()`方法允许开发者向索引中添加内容。每个内容必须有一个ID、一个URL、一个启动URL、标题、描述和一组图标。可以选择将内容分成不同的类别，如文章、主页或视频。`delete()`方法允许再次从索引中删除内容，`getAll()`方法返回所有索引条目的列表。

{{ figure_markup(
  image="content_indexing_api.png",
  caption='在Chrome浏览器中使用内容索引API的页面加载百分比。<br>(来源: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">内容索引</a>)',
  description="内容索引 API 使用情况图，基于 Chrome 中使用该功能的页面加载百分比。它显示出一开始的使用率相对较低，直到2020年10月突然增长了十倍，在Chrome浏览器中0.0021%的页面加载中使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=258329620&format=interactive",
  sheets_gid="626752011"
  )
}}

内容索引API在2020年7月与Chrome 84一起推出。版本发布后，在Chrome浏览器中约0.0002%的页面加载过程中使用了该API。到2020年10月，这个数字几乎增加了十倍。

## 新的传输API

最后，目前有两种新的传输方式正在进行初期试用。第一种允许开发者使用WebSockets接收高频消息，而第二种则在HTTP和WebSockets之外引入了一个全新的双向通信协议。

### WebSockets的背压机制

WebSocket API 是网站和服务器之间双向通信的绝佳选择。但是，WebSocket API 不允许背压，因此处理高频消息的应用程序可能会冻结。<a hreflang="zh" href="https://web.dev/i18n/zh/websocketstream/">WebSocketStream API</a>(<a hreflang="en" href="https://github.com/ricea/websocketstream-explainer/blob/master/README.md">解释</a>，尚未进入标准轨道)希望通过用流来扩展WebSocket API，为其带来易于使用的背压支持。开发者不需要使用通常的`WebSocket`构造函数，而是需要创建一个新的`WebSocketStream`接口实例。流的`connection`属性返回一个承诺，该承诺解析为一个可读和可写的流，允许分别获得一个流读取器或写入器。

```js
const wss = new WebSocketStream(WSS_URL);
const {readable, writable} = await wss.connection;
const reader = readable.getReader();
const writer = writable.getWriter();
```

WebSocketStream API透明地解决了背压问题，因为流读取器和写入器只有在安全的情况下才会进行。

{{ figure_markup(
  image="websocketstreams.png",
  caption='使用 WebSocketStreams 的 Chrome 浏览器中页面加载的百分比。<br>(来源: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3018">WebSocketStream</a>)',
  description="WebSocketStreams 使用情况图，基于使用该功能的 Chrome 浏览器中页面加载的百分比。它显示了2020年6月和7月的峰值，其中API在大约0.0008%的页面加载中被使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1714443590&format=interactive",
  sheets_gid="691106754"
  )
}}

WebSocketStream API已经完成了第一次初期试用，现在又回到了实验阶段。这也解释了为什么目前这个API的使用率很低，几乎无法衡量。

### 启用QUIC

<a hreflang="en" href="https://www.chromium.org/quic">QUIC</a> (<a hreflang="en" href="https://www.ietf.org/archive/id/draft-ietf-quic-transport-31.txt">IETF Internet-Draft</a>)是一种基于UDP实现的多路复用、基于流的双向传输协议。它是在TCP之上实现的HTTP/WebSocket API的替代品。<a hreflang="zh" href="https://web.dev/i18n/zh/webtransport/">QuicTransport API</a>是用于向QUIC服务器发送消息和接收消息的客户端API。开发者可以选择通过数据包不可靠地发送数据，或者通过使用其流API可靠地发送数据。

```js
const transport = new QuicTransport(QUIC_URL);
await transport.ready;

const ws = transport.sendDatagrams();
const stream = await transport.createSendStream();
```

QuicTransport 是 WebSockets 的有效替代方案，因为它支持 WebSocket API 的用例，并增加了最小延迟比可靠性和消息顺序更加重要的场景的支持。这使得它成为处理高频事件的游戏和应用程序的良好选择。

{{ figure_markup(
  image="quic_transport.png",
  caption='使用QuicTransport的Chrome浏览器的页面加载百分比。<br>(Source: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3184">QuicTransport</a>)',
  description="QuicTransport使用情况图表，基于使用该功能的Chrome浏览器中页面加载的百分比。它显示了2020年10月的峰值，其中API在大约0.00089%的页面加载中被使用。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1571330893&format=interactive",
  sheets_gid="708893754"
  )
}}

该接口的使用率还很低，几乎无法衡量。在2020年10月，它的使用率强势上升，目前在Chrome浏览器中0.00089%的页面加载中存在。

## 结论

2020年的Web能力（Capability）状态是健康的，因为新的、强大的API定期与基于Chromium的浏览器的新版本一起发布。一些接口，如内容索引API或空闲检测API，有助于为某些Web应用添加最后的润色。其他API，如文件系统访问和异步剪贴板API，允许一个全新的应用类别，即生产力应用，来最终完全转移到Web上。一些API，如异步剪贴板和Web共享API已经进入了其他非Chromium浏览器。Safari甚至是第一个实现Web共享API的移动浏览器。

通过<a hreflang="en" href="https://developers.google.com/web/updates/capabilities#process">严格的程序</a>，Fugu团队确保了这些能力的访问是以安全和隐私友好的方式进行的。此外，Fugu团队还积极征求其他浏览器厂商和网络开发者的[反馈](mailto:fugu-dev@chromium.org)。虽然这些新API的使用率大多比较低，但本章介绍的一些API却呈现出指数级甚至爆炸般的增长，例如角标或内容索引API。2021年Web能力的状况将取决于Web开发者自身。笔者鼓励社区构建优秀的Web应用，以向后兼容的方式利用强大的API，帮助把Web建设成为一个更强能力的平台。
