---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: 无障碍可访问性
description: 2019 Web Almanac 网络年鉴的无障碍易访问性章节，涵盖易阅读、媒体、易于导航和与辅助技术的兼容性。
authors: [nektarios-paisios, foxdavidj, kleinab]
reviewers: [ljme]
analysts: [dougsillars, rviscomi, foxdavidj]
editors: [foxdavidj]
translators: [chengxicn]
discuss: 1764
results: https://docs.google.com/spreadsheets/d/16JGy-ehf4taU0w4ABiKjsHGEXNDXxOlb__idY8ifUtQ/
nektarios-paisios_bio: Nektarios Paisios 是过去5年致力于Chrome辅助功能的软件工程师。 他主要致力于使Chrome与第三方辅助软件（例如屏幕阅读器和屏幕放大镜）兼容。 在研究Chrome的辅助功能之前，Nektarios曾在公司担任过其他各种职务，例如GSuite辅助功能和展示广告。 Nektarios拥有博士学位。 纽约大学计算机科学专业。
foxdavidj_bio: David Fox 是LookZook的首席可用性研究人员和创始人，LookZook沉迷于发现有关构建满足用户期望的Web体验的所有一切。 他是一位网站心理学家，他深入研究网站不仅要学习用户正在苦苦挣扎的东西，而且要学习为什么以及如何最好地改善他们的体验。 他还是Google Chromium的撰稿人，演讲者以及网络研讨会和UX培训的提供者。
kleinab_bio: Abigail Klein 是谷歌的软件工程师. 她致力于谷歌文档、表格和幻灯片的web可访问性 她为谷歌幻灯片添加了<a hreflang="en" href="https://www.blog.google/outreach-initiatives/accessibility/whats-you-say-present-captions-google-slides/">自动字幕</a>,并改进了屏幕阅读器、盲文、屏幕放大镜和高对比度支持。 她目前致力于谷歌Chrome和ChromeOS的可访问性。她拥有麻省理工学院(MIT)计算机科学学士和硕士学位，在那里她参与创立了一个辅助技术黑客马拉松，她还是该辅助技术课程的实验室助理和客座讲师。
featured_quote: 互联网的无障碍可访问性对一个包容和公平的社会至关重要。随着我们的社会生活和工作生活越来越多地转移到网络世界，残障人士能够无障碍地参与所有在线互动就变得更加重要了。正如建筑设计师可以创建或省略无障碍功能，例如轮椅坡道，web开发人员可以帮助或阻碍用户依赖的辅助技术。
featured_stat_1: 22%
featured_stat_label_1: 使用充分的色彩对比的网站
featured_stat_2: 50%
featured_stat_label_2: 缺少图像alt属性的网站
featured_stat_3: 14%
featured_stat_label_3: 使用跳过链接的网站
---

## 介绍

互联网的无障碍可访问性对一个包容和公平的社会至关重要。随着我们的社会生活和工作生活越来越多地转移到网络世界，残障人士能够无障碍地参与所有在线互动就变得更加重要了。正如建筑设计师可以创建或省略无障碍功能，例如轮椅坡道，web开发人员可以帮助或阻碍用户依赖的辅助技术。

当考虑到残障用户时，我们应该记住他们的用户旅程通常是相同的——他们只是使用不同的工具。这些流行的工具包括但不限于：屏幕阅读器、屏幕放大器、浏览器或文本缩放以及语音控制。

通常，提高站点的可访问性对每个人都有好处。虽然我们通常认为残障人士是永久性残疾，但任何人都可能有暂时的或随着环境变化的残疾。例如失明，有人可能是永久失明，有人是暂时的眼睛感染，而有人在特定的情况下失明，比如在外面强烈的阳光之下。所有这些都可以解释为什么有些人看不见自己的屏幕。每个人都有环境障碍，因此改进web页面的可访问性将改善所有用户在任何情况下的体验。

<a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/">网页内容易读性指引</a> (WCAG) 针对如何使网页容易易阅读提供意见。这些准则被用作我们分析的基础。然而，在许多情况下，很难通过编程来分析网站的可访问性。例如，web平台提供了几种实现类似功能结果的方法，但是支持它们的底层代码可能完全不同。因此，我们的分析只是对整体网页可访问性的一个近似分析。

我们将最有趣的观点分为四类：阅读的便捷性、网络媒体、页面导航的便捷性以及与辅助技术的兼容性。

在测试过程中，桌面和移动设备的可访问性没有显著差异。因此除非另有说明，否则我们呈现的所有指标都是我们的桌面分析的结果。

## 阅读的便捷性

网页的主要目标是提供用户想要参与的内容。这些内容可能是视频或各种图像，但很多时候，它只是页面上的文本。我们的文本内容对读者来说是易读的，这是极其重要的。如果访问者不能阅读一个网页，他们就不能参与其中，最终导致他们离开。在这一节中，我们将看到网站遇到的三个方面的困难。

### 色彩对比

在很多情况下，访问者可能无法完美的看到你的网站。访问者可能是色盲，无法区分字体和背景颜色（欧洲血统中 [每12名男性中就有一名，每200名女性中就有一名](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf)）。也许他们只是在太阳出来的时候看书，在屏幕上产生大量的眩光——严重地损害了他们的视力。又或者他们只是年纪大了，眼睛不能像以前那样区分颜色了。

为了确保你的网站在这些情况下是可读的，确保你的文字与它的背景有足够的颜色对比是至关重要的。同时，要考虑当颜色转换为灰度时将显示什么对比也是非常重要的。

{{ figure_markup(
  image="example-of-good-and-bad-color-contrast-lookzook.svg",
  caption="色彩对比度不足的文本示例。由LookZook提供",
  description="四个彩色框，由棕色和灰色阴影填充，内部是白色文本。创建两个列。左列说明颜色太浅，棕色背景色写为 <code>#FCA469</code>. 右列是推荐的，棕色背景色写为 <code>#BD5B0E</code>。每列的顶部框是带有棕色背景的白色文本 <code>#FFFFFF</code> 底部框是带有灰色背景的白色文本 <code>#FFFFFF</code>。等效的灰度分别是 <code>#B8B8B8</code> 和 <code>#707070</code>。由LookZook提供",
  width=568,
  height=300
  )
}}

只有22.04%的网站给所有的文本提供了足够的颜色对比。或换句话说：每5个网站中就有4个网站的文字很容易和背景融合，导致难以阅读。

<p class="note">请注意，我们无法分析图像中的任何文本，因此我们报告的指标是通过颜色对比测试的网站总数的上限。</p>

### 缩放页面

使用 <a hreflang="en" href="https://accessibleweb.com/question-answer/minimum-font-size/">清晰的字体大小</a> 和 <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/#target-size">目标大小</a> 帮助用户阅读网站以及与你的网站互动。但即使网站完全遵循所有这些准则，也不能满足每个访问者的特定需求。这就是为什么像掐拉缩放这样的设备特性如此重要：它们允许用户调整你的页面以满足他们的需求。在某些使用微小字体和按钮的难以访问的网站上，这些特性甚至给了用户使用该网站的机会。

在少数情况下，禁用缩放是可以接受的，比如有问题的页面是一个使用触摸控制的基于web的游戏。如果在这种情况下保持开启状态，玩家的手机游戏会在玩家双击时放大或缩小，讽刺的是，这个功能反而使得游戏无法访问。

因此，开发人员被赋予禁用此特性的能力。可以通过设置[viewport元标签](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag)中的两个属性其中之一：

1. `user-scalable` 设为 `0` 或 `no`

2. `maximum-scale` 设为 `1`， `1.0`，等

遗憾的是，开发者们滥用了这一功能，以至于几乎三分之一(32.21%)的移动版网站禁用了这一功能，而苹果(例如 iOS 10)也不再允许网络开发者禁用缩放功能。移动版Safari直接<a hreflang="en" href="https://archive.org/details/ios-10-beta-release-notes">忽略了这个标记</a>。无论如何设置，所有网站都可以在更新的iOS设备上进行缩放。

 {{ figure_markup(
  image="fig2.png",
  caption="禁用缩放的站点与设备类型的百分比。",
  description="垂直测量百分比数据， 从0到80，以20为增量，与设备类型相对应，分为桌面和移动设备。启用桌面版：75.46％； 禁用桌面版24.54％； 启用移动版：67.79％； 禁用移动版：32.21％。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=2053904956&format=interactive"
  )
}}

### 语言识别

网络充满了惊人数量的内容。但是，这里有一个问题：世界上有超过1000种不同的语言，而你要找的内容可能不是用你能流利使用的语言书写的。近年来我们在翻译技术方面取得了很大的进步，你可能已经在网络上使用过其中的一种(例如，谷歌翻译)。

为了方便使用这个功能，翻译引擎需要知道你的页面是用什么语言编写的。这是通过使用 [lang`属性`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Global_attributes/lang) 来实现的。否则，计算机必须猜测你的页面是用什么语言写的。正如你所想象的那样，这会导致很多错误，特别是当页面使用多种语言时（例如，你的页面导航是英文的，但是发布的内容是日语的）。

这个问题在使用类似屏幕阅读器这样的文字转语音辅助技术时会更加明显，如果没有指定语言，它们倾向于使用默认的用户语言来读取文本。

在被分析的页面中，26.13%的页面没有给语言指定带有 `lang` 属性。这使得超过四分之一的页面容易受到上述所有问题的影响。好的方面呢? 在使用 `lang` 属性的站点中，它们正确指定有效语言代码的几率为99.68%。

### 分散注意力的内容

有些使用者，比如有认知障碍的人，很难长时间专注于同一项任务。这些用户不希望处理包含大量移动和动画的页面，特别是当这些效果是纯修饰性的、与手上的任务无关的时候。至少，这些用户需要一种方法来关闭所有分散注意力的动画。

不幸的是，我们的发现表明无限循环动画在web上很常见，有21.04%的页面通过无限的CSS动画或者[`<marquee>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/marquee)和[`<blink>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/blink) 元素来使用它们。

有趣的是，这个问题大部分似乎是因为一些流行的第三方样式表默认包含了无限循环的CSS动画。我们无法确定有多少页面实际使用了这些动画样式。

## 网络媒体

### 图像上的替代文本

图片是网络体验的重要组成部分。它们能讲述强有力的故事，吸引注意力，引发情感。但并不是每个人都能看到这些我们用于讲述部分故事的图像。幸运的是，在1995年，HTML 2.0为这个问题提供了一个解决方案：<a hreflang="en" href="https://webaim.org/techniques/alttext/">alt 属性</a>。alt属性为web开发人员提供了向我们使用的图像添加文本描述的功能，这样当有人无法看到我们的图像(或图像无法加载)时，他们可以阅读alt文本以获得描述。alt文本将描述填充到读者可能错过的那部分故事。

尽管alt属性已经存在了25年，但是49.91%的页面仍然没有为一些图片提供alt属性，8.68%的页面从来没有使用过。

### 音频和视频的字幕

正如图片是强有力的故事讲述者一样，音频和视频在吸引注意力和表达想法方面也是如此。当音频和视频内容没有字幕时，无法听到这些内容的用户会错过大部分web内容。我们从耳聋或重听的用户中最常听到的需求之一就是需要为所有音频和视频内容加上字幕。

在使用  [`<audio>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/audio)或 [`<video>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/video) 元素的网站中，只有0.54％提供字幕(根据包含[`<track>`](https://developer.mozilla.org/zh-CN/docs/Web/Guide/Audio_and_video_delivery/Adding_captions_and_subtitles_to_HTML5_video)  元素来评估)。请注意，某些网站具有用于向用户提供视频和音频字幕的自定义解决方案。我们无法检测到这些，因此使用字幕的网站的真实百分比略高。

## 页面导航的便捷性

当您在餐厅中打开菜单时，您可能要做的第一件事就是阅读所有标题：开胃菜，沙拉，主菜和甜点。这使您可以浏览菜单中的所有选项并快速跳转到您最感兴趣的菜肴。同样，当访问者打开网页时，他们的目标是找到他们最感兴趣的信息，这是他们首先进入该页面的原因。为了帮助用户尽快找到所需的内容（并防止他们单击后退按钮），我们尝试将页面的内容分为几个视觉上不同的部分，例如：用于导航的网站标题，在我们的文章中有各种各样的标题，以便用户可以快速浏览它们，在页脚可以链接其他外部无关资源，等等。

尽管这非常重要，但是我们需要注意给页面做标记，以便访问者的电脑也可以感知这些不同的部分。为什么？ 虽然大多数阅读器使用鼠标来浏览页面，但许多其他的阅读器则依靠键盘和屏幕阅读器。这些技术在很大程度上取决于用户的电脑对您的页面的理解程度。

### 表头

表头不仅在视觉上有帮助，而且对屏幕阅读器也有帮助。它们使屏幕阅读器可以快速从一个区域跳到另一个区域，并帮助指示一个区域的结束位置和另一个区域的开始位置。

为了避免使屏幕阅读器用户感到困惑，请确保绝对不要跳过表头级别。例如，不要直接从H1转到H3，而跳过H2。为什么这很重要？因为这是一个意外的更改，将导致屏幕阅读器用户认为他们错过了一部分内容。这可能会导致他们虽然实际上没有错过任何内容，却开始开始四处寻找可能错过的部分。另外，通过保持更一致的设计，您将为所有读者提供帮助。

虽说如此，下面是我们的分析结果：

1. 89.36％的页面以某种方式使用表头。太棒了。
2. 38.6%的页面跳过表头级别。
3. 奇怪的是，在发现H2的网站更多，多于H1。

{{ figure_markup(
  image="fig3.png",
  caption="表头级别的流行程度",
  description="垂直条形图量度百分比数据，范围从0到80，以20为增量，而条形图表示从每个表头h1到h6的级别。H1：63.25%; H2：67.86%; H3：58.63%; H4：36.38%; H5：14.64%; H6：6.91%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1123601243&format=interactive"
  )
}}

### Main 地标

一个[main 地标](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Main_role) 向屏幕阅读器指出网页主要内容的开始位置，以便用户可以直接跳至该页面。如果没有此设置，屏幕阅读器用户每次进入您网站的新页面时都必须手动跳过您的导航。显然，这很令人沮丧。

我们发现，每四个页面中只有一页（26.03％）包含main地标。令人惊讶的是，8.06％的页面错误地包含多个main地标，使这些用户猜测哪个地标包含实际的主要内容。

 {{ figure_markup(
  image="fig4.png",
  caption="按“main”地标数量划分的页面百分比。",
  description="垂直条形图显示百分比数据，范围从0到80，以20为增量，而条形图则表示每页从0到4的“main”地标数量。数据源：HTTP Archive (2019年7月). 0：73.97%; 1：17.97%; 2：7.41%; 3：0.15%; 4：0.06%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1420590464&format=interactive"
  )
}}

### HTML 章节元素

自HTML5于2008年发布并于2014年成为正式标准以来，有许多HTML元素可帮助计算机和屏幕阅读器理解我们的页面布局和结构。

类似 [`<header>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/header)， [`<footer>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/footer)， [`<navigation>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/nav) 等元素，和[`<main>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/main)指出特定类型的内容所在的位置，并允许用户快速跳转到您的页面。这些已在网络上广泛使用，其中大多数已在50％以上的页面上使用 (`<main>` 是例外离群值).

其他元素类似[`<article>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/article)，[`<hr>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/hr)，和[`<aside>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/aside) 帮助读者理解页面的主要内容。例如， `<article>` 说明了一篇文章的结尾，同时也意味着另一篇文章的开头。这些元素的使用率不高，每个元素的使用率约为20％。并非每个网页都拥有所有这些元素，因此这不一定是一个令人担忧的统计数据。

所有这些元素主要是为无障碍可访问性支持而设计的，并且没有视觉效果，这意味着您可以安全地用它们替换现有元素，并且不会遭受意外的后果。

 {{ figure_markup(
  image="fig5.png",
  caption="各种HTML语义元素的使用。",
  description="垂直条形图，每种元素类型的条形与页面百分比的关系，范围从0到60，增量为20。. nav：53.94%; header：54.82%; footer：55.92%; main：18.47%; aside：16.99%; article：22.59%; hr：19.1%; section：36.55%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=708035719&format=interactive"
  )
}}

### 用于导航的其他 HTML 元素

许多流行的屏幕阅读器还允许用户通过快速跳转链接，列表，列表项，iframe和表单字段（如编辑字段，按钮和列表框）进行导航。图9.6详细说明了我们观察到的使用这些元素的页面的频率。

 {{ figure_markup(
  image="fig6.png",
  caption="用于导航的其他HTML元素。",
  description="垂直条形图，每种元素的类型与页面百分比之间的关系，从0到100，以25为增量。a：98.22%; ul：88.62%; input：76.63%; iframe：60.39%; button：56.74%; select：19.68%; textarea：12.03%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=389034849&format=interactive"
  )
}}

### 跳过链接

<a hreflang="en" href="https://webaim.org/techniques/skipnav/">跳过链接</a> 是放置在页面顶部的链接，允许屏幕阅读器或仅使用键盘的用户直接跳至主要内容。它有效地“跳过”了页面顶部的所有导航链接和菜单。跳过链接对于不使用屏幕阅读器的键盘用户特别有用，因为这些用户通常无法访问其他快速导航模式（例如标志和标题）。我们的样本中有14.19％的页面具有跳过链接。

如果您希望自己看到一个跳过链接，没问题！只需进行一次快速的Google搜索，然后在进入搜索结果页面时敲<kbd>tab</kbd>，您将看到一个先前隐藏的链接，如图9.7所示。

{{ figure_markup(
  image="example-of-a-skip-link-on-google.com.png",
  caption="跳过链接在google.com上的样子。",
  description="搜索'http archive'的Google搜索结果页面的屏幕截图。可见“跳至主要内容”链接被突出显示的蓝色焦点框所包围，一个黄色覆盖框伸出红色的箭头指向蓝色焦点框，黄色覆盖框中的文字是“google.com上的跳过链接”。",
  width=600,
  height=333
  )
}}

实际上，您甚至不需要离开此站点，因为我们 <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/645">也在这里使用它们</a>!

在分析网站时，很难准确认定什么是跳过链接。对于此分析，如果我们在页面的前3个链接中找到一个锚链接 (`href=#heading1`) ，我们将其定义为带有跳过链接的页面。因此，严格的上限是14.19％。

### 快捷方式

快捷方式通过<a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a>或者[`accesskey`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Global_attributes/accesskey)属性设置， 可以用于以下两种方式之一：

1. 激活页面上的元素，例如链接或按钮。

2. 在页面焦点上赋予特定元素。例如，将焦点转移到页面上的特定输入框，然后允许用户开始在页面上输入内容。

在我们的样本中几乎没有采用 <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> ，在分析的超过400万网站中仅仅有159个站点使用了它。而 [`accesskey`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Global_attributes/accesskey) 属性的使用频率更高，在2.47％的桌面站点上被找到（移动站点的比例是1.74％）。我们认为，桌面上快捷方式的使用率较高是由于开发人员预计移动网站只能通过触摸屏而非键盘来访问。

尤其令人惊讶的是，使用快捷键的移动站点和桌面站点中有15.56％和13.03％的用户将同一快捷方式分配给多个不同的元素。这意味着浏览器必须猜测哪个元素应拥有此快捷键。

### 表格

表格是我们组织和表达大量数据的主要方式之一。屏幕阅读器和开关（可能由行动不便的用户使用）等许多辅助技术可能具有特殊功能，使他们可以更有效地浏览此表格数据。

#### 表头

根据特定表格的建构方式，利用表头使跨列或行的阅读更加容易，同时不会错过特定列或行所引用的数据的上下文。对于屏幕阅读器用户而言，不得不浏览缺少行头或列头的表格是一种低于标准的体验。这是因为屏幕阅读器用户很难追踪他们在没有表头的表单中的位置，尤其是当表很大时。

要标记表头，只需使用 [`<th>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/th)  标记（而不是[`<td>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/td)) ，或者使用ARIA的 [`columnheader`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Table_Role) 或 [`rowheader`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Table_Role) 角色。在分析中发现只有24.5％的带有表格的页面使用了这两种方法做了标记了。因此，有四分之三的页面选择了包含不带表头的表，这对屏幕阅读器用户构成了严峻的挑战。

到目前为止，使用 `<th>` 和 `<td>` 是标记表头的最常用方法。几乎不存在使用 `columnheader` 和 `rowheader` 角色的情况，只有677个站点使用了它们（0.058％）。

#### 标题

通过 [`<caption>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/caption)  元素标记的表格标题有助于为各类读者提供更多的上下文。标题可以使读者对表格内分享的信息做好阅读准备，这对可能容易注意力分散或容易被打扰的人特别有用。对于可能在大表格内丢失位置的人（例如屏幕阅读器用户或有学习或智力障碍的人），它们也很有用。使读者越容易了解他们所分析的内容就越好。

尽管如此，只有4.32％的带有表单的页面提供标题。

## 和辅助技术的兼容性

### 使用ARIA

关于Web上可访问性的最流行和广泛使用的规范之一是 <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/aria/">Accessible Rich Internet Applications</a> (ARIA) 标准。该标准提供了大量其他HTML属性，以帮助传达视觉元素背后的目的（例如它的语义）以及它们能够执行的操作。

正确和适当的使用ARIA可能会遇到挑战。例如，在使用ARIA属性的页面中，我们发现12.31％的属性分配了无效值。这是有问题的，因为任何使用ARIA属性的错误都不会对页面产生视觉影响。这些错误中的一些可以通过使用自动验证工具来检测，但是通常它们需要动手使用真正的辅助软件（例如屏幕阅读器）。本节将研究如何在网络上使用ARIA，特别是该标准的哪些部分最为普遍。

 {{ figure_markup(
  image="fig8.png",
  caption="页面总数与ARIA属性的百分比。",
  description="垂直条形图显示百分比数据，范围从0到25，以5为增量，条形图代表每个属性。`aria-hidden`：23.46%，`aria-label`：17.67%，`aria-expanded`：8.68%，`aria-current`：7.76%，`aria-labelledby`：6.85%，`aria-controls`：3.56%，`aria-haspopup`：2.62%，`aria-invalid`：2.68%，`aria-describedby`：1.69%，`aria-live`：1.04%，`aria-required`：1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=792161340&format=interactive"
  )
}}

#### `role` 角色属性

“role”角色属性是整个ARIA规范中最重要的属性。它用于通知浏览器给定HTML元素的目的是什么（即语义）。例如，一个`<div>` 元素（使用CSS可视化为按钮）应该赋予ARIA角色为`button`。

当前，有46.91％的页面使用至少一个ARIA角色属性。在下面的图9.9中，我们汇总了使用最广泛的十个ARIA角色值。

 {{ figure_markup(
  image="fig9.png",
  caption="前10名aria角色。",
  description=" 垂直条形图，每种角色类型的条形图和使用的站点百分比，范围是0到25，以5为增量。Navigation：20.4%; search：15.49%; main：14.39%; banner：13.62%; contentinfo：11.23%; button：10.59%; dialog：7.87%; complementary：6.06%; menu：4.71%; form：3.75%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=176877741&format=interactive"
  )
}}

查看图9.9中的结果，我们发现了两个有趣的见解：更新UI框架可能会对整个Web的可访问性产生深远的影响，同时发现尝试让对话框可访问的网站数量之多令人印象深刻。

##### 更新UI框架可能是跨越网络可访问性的前进之路

排名前5位的角色，占页面总数的11％或更多，都是地标角色。这些角色用于辅助导航，而不用于描述小部件（例如组合框）的功能。这是令人惊讶的结果，因为ARIA开发的主要动机是使Web开发人员能够描述由通用HTML元素 (比如`<div>`)组成的小部件的功能。

我们怀疑某些最受欢迎的Web UI框架在其模板中包含导航角色。这将解释地标属性的普遍性。如果该理论正确，那么更新流行的UI框架以包含更多可访问性支持可能会对Web的可访问性产生巨大影响。

指向该结论的另一个结果是，似乎根本没有使用更“高级”但同样重要的ARIA属性。此类属性无法通过UI框架轻松部署，因为可能需要根据每个站点的结构和视觉外观对其进行自定义。例如，我们发现 `posinset` 和 `setsize` 属性仅在0.01％的页面上使用。这些属性传达给屏幕阅读器用户列表或菜单有多少项目，以及当前选中了哪一项。因此，如果视力不佳的用户试图浏览菜单，他们可能会听到索引提示，例如：“首页，第1个，共5个”，“产品，第2个，共5个”，“下载，第3个，共5个”等。

##### 许多站点试图使对话框易于访问

因为使屏幕阅读器用户可以访问对话框非常具有挑战性 ，所以[dialog对话角色](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/dialog_role)的相对受欢迎程度在分析中脱颖而出。我们兴奋的观察到，大约有8％的分析页面正准备迎接挑战。同样，我们怀疑这可能是由于使用了某些UI框架所致。

#### 互动元素的标签

用户与网站互动的最常见方式是通过其控件，例如链接或按钮来浏览网站。但是，很多时候屏幕阅读器用户无法确定控件一旦激活将执行什么操作。这种混乱发生的原因通常是由于缺少文本标签。例如，显示左箭头图标的按钮表示它是“返回”按钮，但不包含实际文本。

使用按钮或链接的页面中只有大约四分之一（24.39％）包含带有这些控件的文本标签。如果未对控件做标记，则屏幕阅读器用户可能会阅读一些通用的内容，例如单词“按钮”，而不是诸如“搜索”之类的有意义的单词。

Tab顺序中几乎总是包含按钮和链接，因此具有极高的可见性。使用Tab键浏览网站是仅使用键盘的用户浏览您的网站的主要方式之一。因此，如果用户使用Tab键在您的网站中移动，则一定会遇到你未做标记的按钮和链接。

### 表单控件的可访问性

填写表格是我们许多人每天要做的一项任务。无论我们是购物，预订旅行还是求职，表格都是用户与网页共享信息的主要方式。因此，确保您的表单可访问性非常重要。实现此目的的最简单方法是为每个输入提供标签 (通过 [`<label>`元素](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/label)，[`aria-label`](https://developer.mozilla.org/zh-CN/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute) 或者 [`aria-labelledby`](https://developer.mozilla.org/zh-CN/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute))。不幸的是，只有 22.33% 页面为其所有表单输入提供标签，这意味着每5页中有4个页面的表格可能非常难以填写。

#### 必填字段和无效字段的指示符

当我们遇到一个旁边有一个大红色星号的字段时，我们知道它是必填字段。或者，当我们点击“提交”并被告知存在无效的输入时，需要更正用不同颜色突出显示的所有内容，然后重新提交。但是，视力低下或没有视力的人不能依靠这些视觉提示， 这就是为什么HTML输入属性 `required`， `aria-required`，和`aria-invalid`如此重要的原因。它们为屏幕阅读器提供了相当于红色星号和红色突出显示字段的内容。额外的好处是，当您通知浏览器需要哪些字段时，它们会为您 [验证表单的某些部分](https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Forms/Data_form_validation)。而无需JavaScript.

在使用表单的网页中，有21.73% 在标记必填字段时使用 `required` 或者 `aria-required`。每五个站点中只有一个使用此功能。这是使您的网站无障碍并为所有用户解锁有帮助的浏览器功能的简单步骤。

我们还发现3.52％的带有表单的网站都使用 `aria-invalid`。但是，由于许多表单仅仅当提交了错误的信息时才会使用此字段，所以我们无法确定使用此标记的网站的真实百分比。

#### 重复的ID

在HTML中 ，ID可以用于将两个元素链接在一起。例如，[`<label>`元素](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/label) 以这种方式工作。您指定此标签描述的输入字段的ID，然后浏览器将它们链接在一起。结果？用户现在可以点击此标签以将焦点放在输入字段上，屏幕阅读器将使用此标签作为说明。

不幸的是，34.62％的站点具有重复的ID，这意味着在许多站点上，用户指定的ID可以引用多个不同的输入。因此，当用户单击标签选择一个字段时，他们可能没有选择他们期望的内容，而是会最终 <a hreflang="en" href="https://www.deque.com/blog/unique-id-attributes-matter/">选择不同的内容</a>。您可能会想到，这也许会对购物车等产生负面影响。

对于屏幕阅读器来说，这个问题更加明显，因为他们的用户可能无法直观地二次检查所选内容。另外，许多ARIA属性，例如 [`aria-describedby`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-describedby_attribute) 和 [`aria-labelledby`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute)与上述标签元素的功能相似。因此，要使您的网站无障碍化，删除所有重复的ID是一个很好的第一步。

## 结论

并非只有残障人士有无障碍访问的需求。例如，任何遭受暂时性腕部伤害的人都曾经历过敲击小目标的困难。视力通常会随着年龄的增长而降低，使以小字体书写的文本难以阅读。手指的敏捷性在各个年龄段的人口统计数据中都不尽相同，这对于相当大比例的用户来说，轻敲交互式控件或在移动网站上滑动内容变得更加困难。

同样，辅助软件不仅适用于残障人士，同时也在改善每个人的日常体验：
- 语音助手最近在移动设备和家庭中的流行已经证明，对于许多用户而言，使用语音命令控制计算设备既是期望的也是必不可少的。诸如此类的语音命令曾经只是一种辅助功能，但现在已成为主流产品。
- 驾驶员将从屏幕阅读功能中受益，该功能在他们注视路面的同时，还能大声朗读长篇的文字，例如新闻报导。
- 字幕不仅可以被无法收听视频的人观看，还可以被想要在喧闹的餐厅或图书馆中观看视频的人观看。

一旦网站建立后，通常很难在现有网站结构和窗口小部件上改造无障碍可访问性。无障碍可访问性并不是以后可以轻易点缀的东西，它必须是设计和实现过程的一部分。不幸的是，由于缺乏认知或缺乏易于使用的测试工具，许多开发人员并不熟悉所有用户的需求以及他们使用的辅助软件的需求。

尽管不是结论性的，我们的结果表明在网络的*相当大，但并非实质性*的部分中可以找到ARIA和可访问性最佳实践（例如使用替代文字）等无障碍标准的使用。从表面上看，这是令人鼓舞的，但是我们怀疑许多积极的趋势是由于某些UI框架的流行。一方面，这令人失望，因为Web开发人员不能仅仅依靠UI框架向其网站提供无障碍化支持。但是，另一方面，令人鼓舞的是，看到UI框架对Web的无障碍化可能有多大的影响。

我们认为，下一个前沿领域是使可通过UI框架访问的小部件更易于访问。由于许多野外使用的复杂小部件（例如，日历选择器）均来自UI库，所以让这些小部件能够开箱即用将是非常棒的。我们希望下次收集结果时，可以看到更正确实现的复杂ARIA角色的使用在增加-这标志着更复杂的小部件也被无障碍化了。此外，我们希望看到更多无障碍访问的媒体，例如图像和视频，以便所有用户都能享受网络的丰富性。
