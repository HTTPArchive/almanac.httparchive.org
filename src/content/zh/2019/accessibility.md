---
part\_number: II
chapter\_number: 9
title: 可访问性
description: 2019 Web Almanac 的易访问性章节，涵盖易阅读、媒体、导航和与辅助技术的兼容性。
authors: [nektarios-paisios, obto, kleinab]
reviewers: [ljme]
translators: []
discuss: 1764
results: https://docs.google.com/spreadsheets/d/16JGy-ehf4taU0w4ABiKjsHGEXNDXxOlb\_\_idY8ifUtQ/
queries: 09\_Accessibility
published: 2019-11-11T00:00:00.000Z
last\_updated: 2020-05-27T00:00:00.000Z
---

## Introduction

互联网的可访问性对一个包容和公平的社会至关重要。随着我们的社会生活和工作生活越来越多地转移到网络世界，残疾人能够无障碍地参与所有在线互动就变得更加重要了。正如建筑设计师可以创建或省略无障碍功能，例如轮椅坡道，web开发人员可以帮助或阻碍用户依赖的辅助技术。

当考虑到残疾用户时，我们应该记住他们的用户旅程通常是相同的——他们只是使用不同的工具。这些流行的工具包括但不限于:屏幕阅读器、屏幕放大器、浏览器或文本缩放以及语音控制。

通常，提高站点的可访问性对每个人都有好处。虽然我们通常认为残疾人是永久性残疾，但任何人都可能有暂时的或随着环境变化的残疾。例如失明，有人可能是永久失明，有人是暂时的眼睛感染，而有人在特定的情况下，比如在外面强烈的阳光下。所有这些都可以解释为什么有些人看不见自己的屏幕。每个人都有环境障碍，因此改进web页面的可访问性将改善所有用户在任何情况下的体验。

[网页内容易读性指引][1] (WCAG) 就如何使网页容易易阅读提供意见。这些准则被用作我们分析的基础。然而，在许多情况下，很难通过编程来分析网站的可访问性。例如，web平台提供了几种实现类似功能结果的方法，但是支持它们的底层代码可能完全不同。因此，我们的分析只是对整体网页可访问性的一个近似。

我们将最有趣的观点分为四类:阅读的便捷性、网络媒体、页面导航的便捷性以及与辅助技术的兼容性。

在测试过程中，桌面和移动设备的可访问性没有显著差异。因此除非另有说明，否则我们呈现的所有指标都是我们的桌面分析的结果。

## 阅读的便捷性

网页的主要目标是提供用户想要参与的内容。这些内容可能是视频或各种图像，但很多时候，它只是页面上的文本。我们的文本内容对读者来说是易读的，这是极其重要的。如果访问者不能阅读一个网页，他们就不能参与其中，最终导致他们离开。在这一节中，我们将看到网站遇到的三个方面的困难。

### 色彩对比

在很多情况下，访问者可能无法完美的看到你的网站。访问者可能是色盲，无法区分字体和背景颜色(欧洲血统中[每12名男性中就有一名，每200名女性中就有一名][2] ). 也许他们只是在太阳出来的时候看书，在屏幕上产生大量的眩光——严重地损害了他们的视力。又或者他们只是年纪大了，眼睛不能像以前那样区分颜色了。

为了确保你的网站在这些情况下是可读的，确保你的文字与它的背景有足够的颜色对比是至关重要的。同时，要考虑当颜色转换为灰度时将显示什么对比也是非常重要的。

<figure>
  <a href="/static/images/2019/accessibility/example-of-good-and-bad-color-contrast-lookzook.svg">
    <img alt="Figure 1. Example of what text with insufficient color contrast looks like. Courtesy of LookZook" aria-labelledby="fig1-caption" aria-describedby="fig1-description" src="/static/images/2019/accessibility/example-of-good-and-bad-color-contrast-lookzook.svg" width="568" height="300">
  </a>
  <div id="fig1-description" class="visually-hidden">Four colored boxes of brown and gray shades with white text overlaid inside creating two columns. The left column says Too lightly colored and has the brown background color written as <coce>#FCA469</code>. The right column says Recommended and the brown background color is written as <code>#BD5B0E</code>. The top box in each column has an brown background with white text <code>#FFFFFF</code> and the bottom box has a gray background with white text <code>#FFFFFF</code>. The grayscale equivalents are <code>#B8B8B8</code> and <code>#707070</code> respectively. Courtesy of LookZook</div>
  <figcaption id="fig1-caption">Figure 1. Example of what text with insufficient color contrast looks like. Courtesy of LookZook</figcaption>
</figure>

只有22.04%的网站给所有的文本提供了足够的颜色对比。或换句话说:每5个网站中就有4个网站的文字很容易和背景融合，导致难以阅读。

<p class="note">Note that we weren't able to analyze any text inside of images, so our reported metric is an upper-bound of the total number of websites passing the color contrast test.</p>

### 缩放页面

使用 [清晰的字体大小 ][3] 和 [目标大小][4] 帮助用户阅读网站以及与你的网站互动。但即使网站完全遵循所有这些准则，也不能满足每个访问者的特定需求。这就是为什么像掐拉缩放这样的设备特性如此重要:它们允许用户调整你的页面以满足他们的需求。在某些使用微小字体和按钮的难以访问的网站上，这些特性甚至给了用户使用该网站的机会。

在少数情况下，禁用缩放是可以接受的，比如有问题的页面是一个使用触摸控制的基于web的游戏。如果在这种情况下保持开启状态，玩家的手机游戏会在玩家双击时放大或缩小，讽刺的是，这个功能反而使得游戏无法访问。

因此，开发人员被赋予禁用此特性的能力。可以通过设置 [meta viewport tag][5]中的两个属性其中之一，:

1. `user-scalable` 设为 `0` 或 `no`

2. `maximum-scale` 设为 `1`, `1.0`, 等

遗憾的是，开发者们滥用了这一功能，以至于几乎三分之一(32.21%)的移动版网站禁用了这一功能，而苹果(例如 iOS 10)也不再允许网络开发者禁用缩放功能。移动版 Safari 简单 [忽略了这个标记][6]. 无论如何设置，所有网站都可以在更新的iOS设备上进行缩放。

<figure>
  <a href="/static/images/2019/accessibility/fig2.png">
    <img src="/static/images/2019/accessibility/fig2.png" alt="Figure 2. Percentage of sites that disable zooming and scaling vs device type." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=2053904956&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">Vertical measuring percentage data, ranging from 0 to 80 in increments of 20, vs. the device type, grouped into desktop and mobile. Desktop enabled: 75.46%; Desktop disabled 24.54%; Mobile enabled: 67.79%; Mobile disabled: 32.21%.</div>
  <figcaption id="fig2-caption">Figure 2. Percentage of sites that disable zooming and scaling vs device type.</figcaption>
</figure>

### Language identification

网络充满了惊人数量的内容。但是，这里有一个问题:世界上有超过1000种不同的语言，而你要找的内容可能不是用你能流利使用的语言书写的。近年来我们在翻译技术方面取得了很大的进步，你可能已经在网络上使用过其中的一种(例如，谷歌翻译)。

为了方便使用这个功能，翻译引擎需要知道你的页面是用什么语言编写的。这是通过使用 [`lang` 属性][7] 来实现的。否则，计算机必须猜测你的页面是用什么语言写的。正如你所想象的那样，这会导致很多错误，特别是当页面使用多种语言时(例如，你的页面导航是英文的，但是发布的内容是日语的)。

这个问题在使用类似屏幕阅读器这样的文字转语音辅助技术时会更加明显，如果没有指定语言，它们倾向于使用默认的用户语言来读取文本。

在被分析的页面中，26.13%的页面没有给语言指定带有 `lang` 属性。这使得超过四分之一的页面容易受到上述所有问题的影响。 好的方面呢? 在使用 `lang` 属性的站点中, 它们正确指定有效语言代码的几率为 99.68% 。

### 分散注意力的内容

有些使用者，比如有认知障碍的人，很难长时间专注于同一项任务。这些用户不希望处理包含大量移动和动画的页面，特别是当这些效果是纯修饰性的、与手上的任务无关的时候。至少，这些用户需要一种方法来关闭所有分散注意力的动画。

不幸的是，我们的发现表明无限循环动画在web上很常见，有21.04%的页面通过无限的CSS动画或者[`<marquee>`][8] 和[`<blink>`][9] 元素来使用它们

有趣的是，这个问题大部分似乎是因为一些流行的第三方样式表默认包含了无限循环的CSS动画。我们无法确定有多少页面实际使用了这些动画样式。

## 网上的媒体

### 图像上的替代文本

图片是网络体验的重要组成部分。它们能讲述强有力的故事，吸引注意力，引发情感。但并不是每个人都能看到这些我们用于讲述部分故事的图像。幸运的是，在1995年，HTML 2.0为这个问题提供了一个解决方案： [alt 属性][10]。alt属性为web开发人员提供了向我们使用的图像添加文本描述的功能，这样当有人无法看到我们的图像(或图像无法加载)时，他们可以阅读alt文本以获得描述。alt文本将描述填充到读者可能错过的那部分故事。

尽管alt属性已经存在了25年，但是49.91%的页面仍然没有为一些图片提供alt属性，8.68%的页面从来没有使用过。

### 音频和视频的字幕

正如图片是强有力的故事讲述者一样，音频和视频在吸引注意力和表达想法方面也是如此。当音频和视频内容没有字幕时，无法听到这些内容的用户会错过大部分web内容。我们从耳聋或重听的用户中最常听到的需求之一就是需要为所有音频和视频内容加上字幕。

Of sites using [`<audio>`][11] or [`<video>`][12] elements, only 0.54% provide captions (as measured by those that include the [`<track>`][13] element). Note that some websites have custom solutions for providing video and audio captions to users. We were unable to detect these and thus the true percentage of sites utilizing captions is slightly higher.

## Ease of page navigation

When you open the menu in a restaurant, the first thing you probably do is read all of the section headers: appetizers, salads, main course, and dessert. This allows you to scan a menu for all of the options and jump quickly to the dishes most interesting to you. Similarly, when a visitor opens a web page, their goal is to find the information they are most interested in—the reason they came to the page in the first place. In order to help users find their desired content as fast as possible (and prevent them from hitting the back button), we try to separate the contents of our pages into several visually distinct sections, for example: a site header for navigation, various headings in our articles so users can quickly scan them, a footer for other extraneous resources, and more.

While this is exceptionally important, we need to take care to mark up our pages so our visitors' computers can perceive these distinct sections as well. Why? While most readers use a mouse to navigate pages, many others rely on keyboards and screen readers. These technologies rely heavily on how well their computers understand your page.

### Headings

Headings are not only helpful visually, but to screen readers as well. They allow screen readers to quickly jump from section to section and help indicate where one section ends and another begins.

In order to avoid confusing screen reader users, make sure you never skip a heading level. For example, don't go straight from an H1 to an H3, skipping the H2. Why is this a big deal? Because this is an unexpected change that will cause a screen reader user to think they've missed a piece of content. This might cause them to start looking all over for what they may have missed, even if there isn't anything missing. Plus, you'll help all of your readers by keeping a more consistent design.

With that being said, here are our results:

1. 89.36% of pages use headings in some fashion. Awesome.
2. 38.6% of pages do skip heading levels.
3. Strangely, H2s are found on more sites than H1s.

<figure>
  <a href="/static/images/2019/accessibility/fig3.png">
    <img src="/static/images/2019/accessibility/fig3.png" alt="Figure 3. Popularity of heading levels." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-crolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1123601243&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">Vertical bar chart measuring percentage data, ranging from 0 to 80 in increments of 20, vs. bars representing each heading level h1 through h6.  H1: 63.25%; H2: 67.86%; H3: 58.63%; H4: 36.38%; H5: 14.64%; H6: 6.91%.</div>
  <figcaption id="fig3-caption">Figure 3. Popularity of heading levels.</figcaption>
</figure>

### Main landmark

A [main landmark][14] indicates to screen readers where the main content of a web page starts so users can jump right to it. Without this, screen reader users have to manually skip over your navigation every single time they go to a new page within your site. Obviously, this is rather frustrating.

We found only one in every four pages (26.03%) include a main landmark. And surprisingly, 8.06% of pages erroneously contained more than one main landmark, leaving these users guessing which landmark contains the actual main content.

<figure>
  <a href="/static/images/2019/accessibility/fig4.png">
    <img src="/static/images/2019/accessibility/fig4.png" alt="Figure 4. Percent of pages by their number of 'main' landmarks." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1420590464&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">Vertical bar chart displaying percentage data, ranging from 0 to 80 in increments of 20, vs. bars representing the number of “main” landmarks per page from 0 to 4. Source: HTTP Archive (July 2019). Zero: 73.97%; One: 17.97%; Two: 7.41%; Three: 0.15%; 4: 0.06%.</div>
  <figcaption id="fig4-caption" >Figure 4. Percent of pages by their number of "main" landmarks.</figcaption>
</figure>

### HTML section elements

Since HTML5 was released in 2008, and made the official standard in 2014, there are many HTML elements to aid computers and screen readers in understanding our page layout and structure.

Elements like [`<header>`][15], [`<footer>`][16], [`<navigation>`][17], and [`<main>`][18] indicate where specific types of content live and allow users to quickly jump around your page. These are being used widely across the web, with most of them being used on over 50% of pages (`<main>` being the outlier).

Others like [`<article>`][19], [`<hr>`][20], and [`<aside>`][21] aid readers in understanding a page's main content. For example, `<article>` says where one article ends and another begins. These elements are not used nearly as much, with each sitting at around 20% usage. Not all of these belong on every web page, so this isn't necessarily an alarming statistic.

All of these elements are primarily designed for accessibility support and have no visual effect, which means you can safely replace existing elements with them and suffer no unintended consequences.

<figure>
  <a href="/static/images/2019/accessibility/fig5.png">
    <img src="/static/images/2019/accessibility/fig5.png" alt="Figure 5. Usage of various HTML semantic elements." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=708035719&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Vertical bar chart with bars for each element type vs percent of pages ranging from 0 to 60 in increments of 20. nav: 53.94%; header: 54.82%; footer: 55.92%; main: 18.47%; aside: 16.99%; article: 22.59%; hr: 19.1%; section: 36.55%.</div>
  <figcaption id="fig5-caption" >Figure 5. Usage of various HTML semantic elements.</figcaption>
</figure>

### Other HTML elements used for navigation

Many popular screen readers also allow users to navigate by quickly jumping through links, lists, list items, iframes, and form fields like edit fields, buttons, and list boxes. Figure 6 details how often we saw pages using these elements.

<figure>
  <a href="/static/images/2019/accessibility/fig6.png">
    <img src="/static/images/2019/accessibility/fig6.png" alt="Figure 6. Other HTML elements used for navigation" aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=389034849&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">Vertical bar chart with bars for each element type vs percent of pages ranging from 0 to 100 in increments of 25. a: 98.22%; ul: 88.62%; input: 76.63%; iframe: 60.39%; button: 56.74%; select: 19.68%; textarea: 12.03%.</div>
  <figcaption id="fig6-caption">Figure 6. Other HTML elements used for navigation.</figcaption>
</figure>

### Skip Links

A [skip link][22] is a link placed at the top of a page which allows screen readers or keyboard-only users to jump straight to the main content. It effectively "skips" over all navigational links and menus at the top of the page. Skip links are especially useful to keyboard users who don't use a screen reader, as these users don't usually have access to other modes of quick navigation (like landmarks and headings). 14.19% of the pages in our sample were found to have skip links.

If you'd like to see a skip link in action for yourself, you can! Just do a quick Google search and hit "<kbd>tab</kbd>" as soon as you land on the search result pages. You'll be greeted with a previously hidden link just like the one in Figure 7.

<figure>
  <a href="/static/images/2019/accessibility/example-of-a-skip-link-on-google.com.png">
    <img alt="Figure 7. What a skip link looks like on google.com." aria-labelledby="fig7-caption" aria-describedby="fig7-description" src="/static/images/2019/accessibility/example-of-a-skip-link-on-google.com.png" width="600" height="333">
  </a>
  <div id="fig7-description" class="visually-hidden">Screenshot of Google search results page for search 'http archive'. The visible 'Skip to main content' link is surrounded by a blue focus highlight and a yellow overlaid box with a red arrow pointing to the skip link reads 'A skip link on google.com'.</div>
  <figcaption id="fig7-caption">Figure 7. What a skip link looks like on google.com.</figcaption>
</figure>

In fact you don't need to even leave this site as we [use them here too][23]!

It's hard to accurately determine what a skip link is when analyzing sites. For this analysis, if we found an anchor link (`href=#heading1`) within the first 3 links on the page, we defined this as a page with a skip link. So 14.19% is a strict upper bound.

### Shortcuts

Shortcut keys set via the [`aria-keyshortcuts`][24] or [`accesskey`][25] attributes can be used in one of two ways:

1. Activating an element on the page, like a link or button.

2. Giving a certain element on the page focus. For example, shifting focus to a certain input on the page, allowing a user to then start typing into it.

Adoption of [`aria-keyshortcuts`][26] was almost absent from our sample, with it only being used on 159 sites out of over 4 million analyzed. The [`accesskey`][27] attribute was used more frequently, being found on 2.47% of web pages (1.74% on mobile). We believe the higher usage of shortcuts on desktop is due to developers expecting mobile sites to only be accessed via a touch screen and not a keyboard.

What is especially surprising here is 15.56% of mobile and 13.03% of desktop sites which use shortcut keys assign the same shortcut to multiple different elements. This means browsers have to guess which element should own this shortcut key.

### Tables

Tables are one of the primary ways we organize and express large amounts of data. Many assistive technologies like screen readers and switches (which may be used by users with motor disabilities) might have special features allowing them to navigate this tabular data more efficiently.

#### Headings

Depending on the way a particular table is structured, the use of table headers makes it easier to read across columns or rows without losing context on what data that particular column or row refers to. Having to navigate a table lacking in header rows or columns is a subpar experience for a screen reader user. This is because it's hard for a screen reader user to keep track of their place in a table absent of headers, especially when the table is quite large.

To mark up table headers, simply use the [`<th>`][28] tag (instead of [`<td>`][29]), or either of the ARIA [`columnheader`][30] or [`rowheader`][31] roles. Only 24.5% of pages with tables were found to markup their tables with either of these methods. So the three quarters of pages choosing to include tables without headers are creating serious challenges for screen reader users.

Using `<th>` and `<td>` was by far the most commonly used method for marking up table headers. The use of `columnheader` and `rowheader` roles was almost non-existent with only 677 total sites using them (0.058%).

#### Captions

Table captions via the [`<caption>`][32] element are helpful in providing more context for readers of all kinds. A caption can prepare a reader to take in the information your table is sharing, and it can be especially useful for people who may get distracted or interrupted easily. They are also useful for people who may lose their place within a large table, such as a screen reader user or someone with a learning or intellectual disability. The easier you can make it for readers to understand what they're analyzing, the better.

Despite this, only 4.32% of pages with tables provide captions.

## Compatibility with assistive technologies

### The use of ARIA

One of the most popular and widely used specifications for accessibility on the web is the [Accessible Rich Internet Applications][33] (ARIA) standard. This standard offers a large array of additional HTML attributes to help convey the purpose behind visual elements (i.e., their semantic meaning), and what kinds of actions they're capable of.

Using ARIA correctly and appropriately can be challenging. For example, of pages making use of ARIA attributes, we found 12.31% have invalid values assigned to their attributes. This is problematic because any mistake in the use of an ARIA attribute has no visual effect on the page. Some of these errors can be detected by using an automated validation tool, but generally they require hands-on use of real assistive software (like a screen reader). This section will examine how ARIA is used on the web, and specifically which parts of the standard are most prevalent.

<figure>
  <a href="/static/images/2019/accessibility/fig8.png">
    <img src="/static/images/2019/accessibility/fig8.png" alt="Figure 8. Percent of total pages vs ARIA attribute." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=792161340&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Vertical bar chart displaying percentage data, ranging from 0 to 25 in increments of 5, vs. bars representing each attribute. Aria-hidden: 23.46%, aria-label: 17.67%, aria-expanded: 8.68%, aria-current: 7.76%, aria-labelledby: 6.85%, aria-controls: 3.56%, aria-haspopup: 2.62%, aria-invalid: 2.68%, aria-describedby: 1.69%, aria-live: 1.04%, aria-required: 1%</div>
  <figcaption id="fig8-caption" >Figure 8. Percent of total pages vs ARIA attribute.</figcaption>
</figure>

#### The `role` attribute

The "role" attribute is the most important attribute in the entire ARIA specification. It's used to inform the browser what the purpose of a given HTML element is (i.e., the semantic meaning). For example, a `<div>` element, visually styled as a button using CSS, should be given the ARIA role of `button`.

Currently, 46.91% of pages use at least one ARIA role attribute. In Figure 9 below, we've compiled a list of the top ten most widely used ARIA role values.

<figure>
  <a href="/static/images/2019/accessibility/fig9.png">
    <img src="/static/images/2019/accessibility/fig9.png" alt="Figure 9. Top 10 aria roles." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=176877741&amp;format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">Vertical bar chart with bars for each role type vs percent of sites using ranging from 0 to 25 in increments of 5. Navigation: 20.4%; search: 15.49%; main: 14.39%; banner: 13.62%; contentinfo: 11.23%; button: 10.59%; dialog: 7.87%; complementary: 6.06%; menu: 4.71%; form: 3.75%</div>
  <figcaption id="fig9-caption" >Figure 9. Top 10 aria roles.</figcaption>
</figure>

Looking at the results in Figure 9, we found two interesting insights: updating UI frameworks may have a profound impact on accessibility across the web, and the impressive number of sites attempting to make dialogs accessible.

##### Updating UI frameworks could be the way forward for accessibility across the web

The top 5 roles, all appearing on 11% of pages or more, are landmark roles. These are used to aid navigation, not to describe the functionality of a widget, such as a combo box. This is a surprising result because the main motivator behind the development of ARIA was to give web developers the capability to describe the functionality of widgets made of generic HTML elements (like a `<div>`).

We suspect that some of the most popular web UI frameworks include navigation roles in their templates. This would explain the prevalence of landmark attributes. If this theory is correct, updating popular UI frameworks to include more accessibility support may have a huge impact on the accessibility of the web.

Another result pointing towards this conclusion is the fact that more "advanced" but equally important ARIA attributes don't appear to be used at all. Such attributes cannot easily be deployed through a UI framework because they might need to be customized based on the structure and the visual appearance of every site individually. For example, we found that the `posinset` and `setsize` attributes were only used on 0.01% of pages. These attributes convey to a screen reader user how many items are in a list or menu and which item is currently selected. So, if a visually impaired user is trying to navigate through a menu, they might hear index announcements like: "Home, 1 of 5", "Products, 2 of 5", "Downloads, 3 of 5", etc.

##### Many sites attempt to make dialogs accessible

The relative popularity of the [dialog role][34] stands out because making dialogs accessible for screen reader users is very challenging. It is therefore exciting to see around 8% of the analyzed pages stepping up to the challenge. Again, we suspect this might be due to the use of some UI frameworks.

#### Labels on interactive elements

The most common way that a user interacts with a website is through its controls, such as links or buttons to navigate the website. However, many times screen reader users are unable to tell what action a control will perform once activated. Often the reason this confusion occurs is due to the lack of a textual label. For example, a button displaying a left-pointing arrow icon to signify it's the "Back" button, but containing no actual text.

Only about a quarter (24.39%) of pages that use buttons or links include textual labels with these controls. If a control is not labeled, a screen reader user might read something generic, such as the word "button" instead of a meaningful word like "Search".

Buttons and links are almost always included in the tab order and thus have extremely high visibility. Navigating through a website using the tab key is one of the primary ways through which users who use only the keyboard explore your website. So a user is sure to encounter your unlabeled buttons and links if they are moving through your website using the tab key.

### Accessibility of Form Controls

Filling out forms is a task many of us do every single day. Whether we're shopping, booking travel, or applying for a job, forms are the main way users share information with web pages. Because of this, ensuring your forms are accessible is incredibly important. The simplest means of accomplishing this is by providing labels (via the [`<label>` element][35], [`aria-label`][36] or [`aria-labelledby`][37]) for each of your inputs. Sadly, only 22.33% of pages provide labels for all their form inputs, meaning 4 out of every 5 pages have forms that may be very difficult to fill out.

#### Indicators of required and invalid fields

When we come across a field with a big red asterisk next to it, we know it's a required field. Or when we hit submit and are informed there were invalid inputs, anything highlighted in a different color needs to be corrected and then resubmitted. However, people with low or no vision cannot rely on these visual cues, which is why the HTML input attributes `required`, `aria-required`, and `aria-invalid` are so important. They provide screen readers with the equivalent of red asterisks and red highlighted fields. As a nice bonus, when you inform browsers what fields are required, they'll [validate parts of your forms][38] for you. No JavaScript required.

Of pages using forms, 21.73% use `required` or `aria-required` when marking up required fields. Only one in every five sites make use of this. This is a simple step to make your site accessible, and unlocks helpful browser features for all users.

We also found 3.52% of sites with forms make use of `aria-invalid`. However, since many forms only make use of this field once incorrect information is submitted, we could not ascertain the true percentage of sites using this markup.

#### Duplicate IDs

IDs can be used in HTML to link two elements together. For example, the [`<label>` element][39] works this way. You specify the ID of the input field this label is describing and the browser links them together. The result? Users can now click on this label to focus on the input field, and screen readers will use this label as the description.

Unfortunately, 34.62% of sites have duplicate IDs, which means on many sites the ID specified by the user could refer to multiple different inputs. So when a user clicks on the label to select a field, they may end up [selecting something different][40] than they intended. As you might imagine, this could have negative consequences in something like a shopping cart.

This issue is even more pronounced for screen readers because their users may not be able to visually double check what is selected. Plus, many ARIA attributes, such as [`aria-describedby`][41]  and [`aria-labelledby`][42], work similarly to the label element detailed above. So to make your site accessible, removing all duplicate IDs is a good first step.

## Conclusion

People with disabilities are not the only ones with accessibility needs. For example, anyone who has suffered a temporary wrist injury has experienced the difficulty of tapping small tap targets. Eyesight often diminishes with age, making text written in small fonts challenging to read. Finger dexterity is not the same across age demographics, making tapping interactive controls or swiping through content on mobile websites more difficult for a sizable percentage of users.

Similarly, assistive software is not only geared towards people with disabilities but for improving the day to day experience of everyone:
- The recent popularity of voice assistance, both on mobile devices and in the home, has demonstrated that controlling a computing device using voice commands is both desirable and essential for many users. Voice commands like these used to only be an accessibility feature but are now turning into a mainstream product.
- Drivers would benefit from a screen reading feature that, while they keep their eyes on the road, reads long pieces of text like news stories aloud.
- Captions are enjoyed not only by people who cannot hear a video but also by people who want to watch a video in a loud restaurant or in a library.

Once a website is built, it's often hard to retrofit accessibility on top of existing site structures and widgets. Accessibility isn't something that can be easily sprinkled on afterwards, rather it needs to be part of the design and implementation process. Unfortunately, either through a lack of awareness or easy-to-use testing tools, many developers are not familiar with the needs of all their users and the requirements of the assistive software they use.

While not conclusive, our results indicate that the use of accessibility standards like ARIA and accessibility best practices (e.g., using alt text) are found on a *sizable, but not substantial* portion of the web. On the surface this is encouraging, but we suspect many of these positive trends are due to the popularity of certain UI frameworks. On one hand, this is disappointing because web developers cannot simply rely on UI frameworks to inject their sites with accessibility support. On the other hand though, it's encouraging to see how large of an effect UI frameworks could have on the accessibility of the web.

The next frontier, in our opinion, is making widgets which are available through UI frameworks more accessible. Since many complex widgets used in the wild (e.g., calendar pickers) are sourced from a UI library, it would be great for these widgets to be accessible out of the box. We hope that when we collect our results next time, the usage of more properly implemented complex ARIA roles is on the rise—signifying more complex widgets have also been made accessible. In addition, we hope to see more accessible media, like images and video, so all users can enjoy the richness of the web.

[1]:	https://www.w3.org/WAI/WCAG21/quickref/
[2]:	http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf
[3]:	https://accessibleweb.com/question-answer/minimum-font-size/
[4]:	https://www.w3.org/WAI/WCAG21/quickref/#target-size
[5]:	https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag
[6]:	https://archive.org/details/ios-10-beta-release-notes
[7]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang
[8]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/marquee
[9]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/blink
[10]:	https://webaim.org/techniques/alttext/
[11]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
[12]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video
[13]:	https://developer.mozilla.org/en-US/docs/Web/Guide/Audio_and_video_delivery/Adding_captions_and_subtitles_to_HTML5_video
[14]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Main_role
[15]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/header
[16]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/footer
[17]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/nav
[18]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/main
[19]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/article
[20]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/hr
[21]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/aside
[22]:	https://webaim.org/techniques/skipnav/
[23]:	https://github.com/HTTPArchive/almanac.httparchive.org/pull/645
[24]:	https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts
[25]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/accesskey
[26]:	https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts
[27]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/accesskey
[28]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/th
[29]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/td
[30]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Table_Role
[31]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Table_Role
[32]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/caption
[33]:	https://www.w3.org/WAI/standards-guidelines/aria/
[34]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/dialog_role
[35]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label
[36]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute
[37]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute
[38]:	https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/Form_validation
[39]:	https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label
[40]:	https://www.deque.com/blog/unique-id-attributes-matter/
[41]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-describedby_attribute
[42]:	https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute