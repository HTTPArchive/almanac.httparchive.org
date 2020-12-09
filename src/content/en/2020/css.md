---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: I
chapter_number: 1
title: CSS
description: CSS chapter of the 2020 Web Almanac covering color, units, selectors, layout, typography and fonts, spacing, decoration, animation, and media queries.
authors: [LeaVerou, svgeesus, rachelandrew]
reviewers: [fantasai, j9t, estellevw, mirisuzanne, catalinred, hankchizljaw]
analysts: [rviscomi, LeaVerou, dooman87]
translators: []
#LeaVerou_bio: TODO
#svgeesus_bio: TODO
#rachelandrew_bio: TODO
discuss: 2037
results: https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/
queries: 01_CSS
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---

## Introduction

Cascading Style Sheets (CSS) is a language used to lay out, format, and paint web pages and other media. It is one of the three main languages for building websites, the other two being HTML, used for structure, and JavaScript, used to specify behavior.

In [last year’s inaugural Web Almanac](https://almanac.httparchive.org/en/2019/), we looked at [a variety of CSS metrics](https://almanac.httparchive.org/en/2019/css) measured through 41 SQL queries over the HTTPArchive corpus, to assess the state of the technology in 2019. This year, we went a lot deeper, to measure not only how many pages use a given CSS feature, but also *how* they use it.

Overall, what we observed was a Web in two different gears when it comes to CSS adoption. In our blog posts and twitter bubbles, we tend to mostly discuss the newest and shiniest. However, there are still *millions* of sites using decade-old code. Things like [vendor prefixes from a bygone era](#vendor-prefixes), [proprietary IE filters](#filters), and [floats for layout](#layout), in all their [clearfix](#class-names) glory. But we also observed impressive adoption of many new features, even features that only got support across the board this very year, like [`min()` and `max()`](#feature-queries). However, there is generally an inverse correlation between how cool something is perceived to be and how much it's actually used, e.g. cutting-edge Houdini features were practically nonexistent.

Similarly, in our conference talks, we often tend to focus on complicated, elaborate use cases that make heads explode and twitter feeds fill with "CSS can do *that*?!". However, as it turns out, most CSS usage in the wild is fairly simple. [CSS Variables are mostly used as constants](#complexity) and rarely refer to other variables, `calc()` is [mostly used with two terms](#calculations), gradients [mostly have two stops](#gradients) and so on.

The Web is not a teenager any more. It is now 30 years old, and acts like it. It tends to favor stability over new bling, and readability over complexity, occasional guilty pleasures aside.

## Methodology

The [HTTP Archive](https://httparchive.org/) crawls [millions of pages](https://httparchive.org/reports/state-of-the-web#numUrls) every month and runs them through a private instance of [WebPageTest](https://webpagetest.org/) to store key information of every page. (You can learn more about this in our [methodology](./methodology)).

For this year, we decided to involve the community in which metrics to study. We started with an [app to propose metrics and vote on them](https://projects.verou.me/mavoice/?repo=leaverou/css-almanac&labels=proposed%20stat). In the end, there were so many interesting metrics that we ended up including nearly all of them. We only excluded Font metrics, since there is a whole separate [Fonts chapter](https://almanac.httparchive.org/en/2020/fonts) and there was significant overlap.

The data in this chapter took 121 SQL queries to produce, totaling over 10K lines of SQL, which includes 3K lines of JS, making it the largest chapter in Web Almanac's history.

A lot of engineering work went into making this scale of analysis feasible. Like last year, we put all CSS code through a [CSS parser](https://github.com/reworkcss/css), and stored the [Abstract Syntax Trees](https://en.wikipedia.org/wiki/Abstract_syntax_tree) (AST) for all stylesheets in the corpus, resulting in a whopping 10 TB of data. This year, we also developed a [library of helpers](https://github.com/leaverou/rework-utils) that operate on this AST, and a [selector parser](https://projects.verou.me/parsel), both of which were also released as separate open source projects. Most metrics involved [JS](https://github.com/LeaVerou/css-almanac/tree/master/js) to collect data from a single AST, and [SQL](https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/sql/2020/01_CSS) to aggregate this data over the entire corpus. Curious how your own CSS does against our metrics? We made an [online playground](https://projects.verou.me/css-almanac/playground) where you can try them out on your own sites.

For certain metrics, looking at the CSS AST was not enough. We wanted to look at [SCSS](https://sass-lang.com/) wherever it was provided via sourcemaps as it shows us what developers *need* from CSS that is not yet possible, whereas studying CSS shows us what developers currently use that is. For that, we had to use a *custom metric*, i.e. JS code that runs in the crawler when it visits a given page. We could not use a proper SCSS parser as that could slow down the crawl too much, so we had to resort to [regular expressions](https://github.com/LeaVerou/css-almanac/blob/master/runtime/sass.js) (*oh, the horror!*). Despite the crude approach, we got [a plethora of insights](#sass)!

Custom metrics were also used for part of the [Custom properties analysis](#custom-properties). While we can get a lot of information about custom property usage from the stylesheets alone, we cannot build a dependency graph without being able to look at the DOM tree for context, as custom properties are inherited. Looking at the computed style of the DOM nodes also gives us information like what kinds of elements each property is applied to, and which of them are [registered](https://developer.mozilla.org/en-US/docs/Web/API/CSS/RegisterProperty), information that we also cannot get from the stylesheets.

*Unless otherwise noted, stats presented in this chapter refer to the set of mobile pages.*

## Usage

While JavaScript far surpasses CSS in its share of page weight, CSS has certainly grown in size over the years, with the median desktop page loading 62 KB of CSS code, and 1 in 10 pages loading more than 240 KB of CSS code. Mobile pages do use slightly less CSS code across all percentiles, but only by 4 to 7 KB. While this is definitely greater than previous years, it doesn't come close to [Javascript’s whopping median of 444 KB and top 10% of 1.2 MB](../javascript/#how-much-javascript-do-we-use)

{{ figure_markup(
  image="stylesheet-size.png",
  caption="Distribution of the stylesheet transfer size per page.",
  description="Bar chart showing the distribution of stylesheet transfer size per page, which includes compression when enabled. Desktop tends to have slightly more stylesheet bytes per page by about 10 KB. The 10, 25, 50, 75, and 90th percentiles for mobile are: 5, 22, 56, 122, and 234 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=762340058&format=interactive",
  sheets_gid="314594173",
  sql_file="stylesheet_kbytes.sql"
) }}

It would be reasonable to assume that a lot of this CSS is generated via preprocessors or other build tools, however **only about 15%** included sourcemaps. It is unclear whether this says more about sourcemap adoption, or build tool usage. Of those, the overwhelming majority (45%) came from other CSS files, indicating usage of build processes that operate on CSS files, such as minification, [autoprefixer](https://autoprefixer.github.io/), and/or [PostCSS](https://postcss.org/). [Sass](https://sass-lang.com/) was far more popular than [Less](http://lesscss.org/) (34% of stylesheets with sourcemaps vs 21%), with SCSS being the more popular dialect (33% for .scss vs 1% for .sass).

All these kilobytes of code are typically distributed across multiple files and `<style>` elements; only about 7% of pages concentrate all their CSS code in one remote stylesheet, as we are often taught to do. In fact, the median page contains 3 `<style>` elements and 6 (!) remote stylesheets, with 10% of them carrying over 14 `<style>` elements and over 20 remote CSS files! While this is suboptimal on desktop, it really kills performance on mobile, where round-trip latency is more important than raw download speed.

Shockingly, the maximum number of stylesheets per page is an incredible 26,777 `<style>` elements and 1,379 remote ones! I'd definitely want to avoid loading *that* page!

{{ figure_markup(
  image="stylesheet-count.png",
  caption="Distribution of the number of stylesheets per page.",
  description="Bar chart showing the distribution of stylesheets per page. Desktop and mobile are nearly equal throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for mobile are: 1, 3, 6, 12, and 21 stylesheets per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=163217622&format=interactive",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
) }}

Another metric of size is the number of rules. The median page carries a total of 448 rules and 5,454 declarations. Interestingly, 10% of pages contain a tiny amount of CSS: fewer than 13 rules! Despite mobile having slightly smaller stylesheets, it also has slightly more rules, indicating smaller rules overall (as it tends to happen with media queries).

{{ figure_markup(
  image="rules.png",
  caption="Distribution of the total number of style rules per page.",
  description="Bar chart showing the distribution of style rules per page. Mobile tends to have slightly more rules than desktop. The 10, 25, 50, 75, and 90th percentiles for mobile are: 13, 140, 479, 1,074, and 1,831 rules per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1918103300&format=interactive",
  sheets_gid="42376523",
  sql_file="selectors.sql"
) }}

## Selectors and the cascade

### Class names

What do developers use class names for these days? To answer this question, we looked at the most popular class names. The list was dominated by FontAwesome classes, with 192 out of 198 being `fa` or `fa-*`! The only thing that initial exploration could tell us was that FontAwesome is exceedingly popular and is used by almost one third of websites!

However, once we collapsed `fa-*` and then `wp-*` classes (which come from WordPress, another exceedingly popular piece of software), we got more meaningful results. Omitting these, state-related classes seem to be most popular, with `.active` occurring in nearly half of websites, and `.selected` and `.disabled` following soon after.

Only a few of the top classes were presentational, with most of those being either alignment related (`pull-right` and `pull-left` from older Bootstrap, `alignright`, `alignleft` etc) or `clearfix`, which still occurs in 22% of websites, despite floats being superseded as a layout method by the more modern Grid and Flexbox modules.

{{ figure_markup(
  image="popular-class-names.png",
  caption="The most popular class names by the percent of pages.",
  description="Bar chart showing the top 14 most popular class names for desktop and mobile pages. The active class is found on 40% of pages. The rest of the classes are found on 20-30% of pages and are, in decreasing order: fa, fa-*, pull-right, pull-left, selected, disabled, clearfix, button, title, wp-*, btn, container, and sr-only.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1187401149&format=interactive",
  sheets_gid="863628849",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}

### IDs

Despite IDs being discouraged these days in some circles due to their much higher specificity, most websites still use them, albeit sparingly. Fewer than half of pages used more than one ID in any of their selectors (had a max specificity of (1,x,y) or less) and nearly all had a median specificity that did not include IDs (0,x,y).

But what are these IDs used for? It turns out that the most popular IDs are structural: `#content`, `#footer`, `#header`, `#main`, despite [corresponding HTML elements](https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure#HTML_layout_elements_in_more_detail).

{{ figure_markup(
  image="popular-ids.png",
  caption="The most popular IDs by the percent of pages.",
  description="Bar chart showing the top 10 most popular IDs for desktop and mobile pages. The most popular ID is content at 14% of pages. The footer and header IDs have slightly smaller adoption. The logo, main, respond, comments, fancybox-loading, wrapper, and submit IDs have between 5 and 10% adoption on pages. The only notable difference between desktop and mobile is the comments ID used on about 8% of mobile pages but only 5% of desktop pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=141873739&format=interactive",
  sheets_gid="734822190",
  sql_file="top_selector_ids.sql"
) }}

IDs can also be used to intentionally reduce or increase specificity. The specificity hack of writing an ID selector as an attribute selector (`[id="foo"]` instead of `#foo`) was surprisingly rare, with only 0.3% of pages using it at least once. Another ID-related specificity hack, using a negation + descendant selector like `:not(#nonexistent) .foo` instead of `.foo` to increase specificity, was also very rare, appearing in only 0.1% of pages.

### !important

Instead, the old, crude `!important` is still used a fair bit despite its [well-known drawbacks](https://www.impressivewebs.com/everything-you-need-to-know-about-the-important-css-declaration/#post-475:~:text=Drawbacks,-to). The median page uses `!important` in nearly 2% of its declarations, or 1 in 50. Some developers literally cannot get enough of it: we found 2304 desktop pages and 2138 mobile ones that use `!important` in **every single declaration!**.

{{ figure_markup(
  image="important-properties.png",
  caption="Distribution of the percent of `!important` properties per page.",
  description="Bar chart showing the distribution of the percent of !important properties per page. Desktop pages tend to use !important on slightly more properties than mobile. The 10, 25, 50, 75, and 90th percentiles for mobile are: 0, 1, 2, 4, and 7% of properties having !important.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=768784205&format=interactive",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
) }}

What is it that developers are so keen to override? We looked at breakdown by property, and found that nearly 80% of pages use `!important` with the `display` property. It is a common strategy to apply `display: none !important` to hide content in helper classes to override existing CSS that uses `display` to define a layout mode. This is a side effect of what, in hindsight, was a flaw in CSS. It combined three orthogonal characteristics into one: internal layout mode, flow behavior, and visibility status are all controlled by the `display` property. There are efforts to separate out these values into separate `display` keywords so that they can be tweaked independently via custom properties, but [browser support is virtually nonexistent](https://caniuse.com/mdn-css_properties_display_multi-keyword_values) for the time being.

{{ figure_markup(
  image="important-top-properties.png",
  caption="The top `!important` properties by the percent of pages.",
  description="Bar chart showing the top 10 properties used with !important. Mobile and desktop have similar usage. The display property is used with !important the most, by 79% of mobile pages. In decreasing order, the subsequent properties on 71-58% of mobile pages are: color, width, height, background, padding, margin, border, background-color, and float.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=257343566&format=interactive",
  sheets_gid="1222608982",
  sql_file="meta_important_properties.sql"
) }}

### Specificity and classes

Besides keeping ids and `!important`s few and far between, there is a trend to circumvent specificity altogether by cramming all the selection criteria of a selector in a single class name, thus forcing all rules to have the same specificity and turning the cascade into a simpler last-one-wins system. BEM is a popular methodology of that type, albeit not the only one. While it is difficult to assess how many websites use BEM-style methodologies exclusively, since following it in every rule is rare (even the [BEM website](http://getbem.com/) uses multiple classes in many selectors), about 10% of pages had a median specificity of (0,1,0), which may indicate mostly following a BEM-style methodology. On the opposite end of BEM, often developers use [duplicated classes](https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/#safely-increasing-specificity) to *increase* specificity and nudge a selector ahead of another one (e.g. `.foo.foo` instead of `.foo`). This kind of specificity hack is actually more popular than BEM, being present in 14% of mobile websites (9% of desktop)! This may indicate that most developers do not actually want to get rid of the cascade altogether, they just need more control over it.


<figure markdown>
Percentile | Desktop | Mobile
-- | -- | --
10 | 0,1,0 | 0,1,0
25 | 0,2,0 | 0,1,2
50 | 0,2,0 | 0,2,0
75 | 0,2,0 | 0,2,0
90 | 0,3,0 | 0,3,0

  <figcaption>
    {{ figure_link(
      caption="Distribution of the median specificity per page.",
      sheets_gid="1213836297",
      sql_file="specificity.sql"
    ) }}
  </figcaption>
</figure>

### Attribute selectors

The most popular attribute selector, by far, is on the `type` attribute, used in 45% of pages, likely to style inputs of different types, e.g. to style textual inputs differently from radios, checkboxes, sliders, file upload controls etc.

{{ figure_markup(
  image="attribute-selectors.png",
  caption="The most popular attribute selectors by the percent of pages.",
  description="Bar chart showing the top attribute selectors by the percent of pages. Mobile and desktop have similar usage. The most popular attribute selector by far is type, used on 46% of mobile pages. Next, the class attribute selector is used on 30% of mobile pages. The following attribute selectors are used on between 17 and 3% in descending order: disabled, dir, title, hidden, controls, data-type, data-align, href, poster, role, style, xmlns, aria-disabled, src, id, name, lang, and multiple.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=320159317&format=interactive",
  sheets_gid="1926527049",
  sql_file="top_selector_attributes.sql"
) }}

### Pseudo-classes and pseudo-elements

There is always a lot of inertia when we change something in the Web platform after it's long established. As an example, the Web has still largely not caught up with pseudo-elements having separate syntax compared to pseudo-classes, even though this was a change that happened over a decade ago. All pseudo-elements that are also available with a pseudo-class syntax for legacy reasons are **vastly** more widespread (2.5x to 5x!) with the pseudo-class syntax.

{{ figure_markup(
  image="selector-pseudo-classes.png",
  caption="Usage of legacy `:pseudo-class` syntax for `::pseudo-elements` as a percent of mobile pages.",
  description="Bar chart showing the percent of pages that use pseudo-class syntax (prefixed by one colon) versus pseudo-element syntax (two colons) for pseudo-elements. The before pseudo-element is used with pseudo-class syntx on 71% of mobile pages and pseudo-element syntax on 33% of mobile pages. The after pseudo-element is used with class and element syntax on 68% and 30% of mobile pages, first-letter on 7% and 1% of mobile pages, and first-line on 1% and 0% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=227968207&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

By far the most popular pseudo-classes are user action ones, with `:hover`, `:focus`, and `:active` at the top of the list, all used in over two thirds of pages, indicating that developers like the convenience of specifying declarative UI interactions.

`:root` seems far more popular than is justified by its function, used in one third of pages. In HTML content, it just selects the `<html>` element, so why didn't developers just use `html`? A possible answer may lie in a common practice related to defining custom properties, [which are also highly used](#custom properties), on the `:root` pseudo-class. Another answer may lie in specificity: `:root`, being a pseudo-class, has a higher specificity than `html`: (0, 1, 0) vs (0, 0, 1). It is a common hack to increase specificity of a selector by prepending it with `:root`, e.g. `:root .foo` has a specificity of (0, 2, 0) compared to just (0, 1, 0) for `.foo`. This is often all that is needed to nudge a selector slightly over another one in the cascade race and avoid the sledgehammer that is `!important`. To test this hypothesis, we also measured exactly that: how many pages use `:root` at the start of a descendant selector? The results verified our hypothesis: a remarkable 29% of pages use `:root` that way! Furthermore, 14% of desktop pages and 19% of mobile pages use `html` at the start of a descendant selector, possibly to give the selector an even smaller specificity boost. The popularity of these specificity hacks strongly indicates that developers need more fine grained control to tweak specificity than what is afforded to them via `!important`. Thankfully, this is coming soon with [`:where()`](https://developer.mozilla.org/en-US/docs/Web/CSS/:where), which is already [implemented across the board](https://caniuse.com/mdn-css_selectors_where) (albeit behind a flag in Chrome for now).

{{ figure_markup(
  image="popular-selector-pseudo-classes.png",
  caption="The most popular pseudo-classes as a percent of pages.",
  description="Bar chart showing the most popular pseudo-classes as a percent of pages for desktop and mobile. Desktop and mobile are mostly similar, with mobile tending to have slightly higher adoption. The most popular pseudo-class is hover, used on 84% of pages. The following pseudo-classes decrease in popularity from 71% to 12% almost linearly: before, after, focus, active, first-child, last-child, visited, not, root, nth-child, link, disabled, empty, nth-of-type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1363774711&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

When it comes to pseudo-elements, after the usual suspects `::before` and `::after`, nearly all popular pseudo-elements were browser extensions for styling form controls and other built-in UI, strongly echoing the developer need for more fine-grained control over styling of built in UI. Styling of focus rings, placeholders, search inputs, spinners, selection, scrollbars, media controls was especially popular.

{{ figure_markup(
  image="popular-selector-pseudo-elements.png",
  caption="The most popular pseudo-elements as a percent of pages.",
  description="Bar chart showing the most popular pseudo-elements as a percent of pages for desktop and mobile. Desktop and mobile are mostly similar, with mobile tending to have slightly higher adoption. The most popular pseudo-element is before, used on 33% of mobile pages. The after pseudo-element is used on 30% of mobile pages. -moz-focus-inner is unsed on 24% of pages. The popularity drops after those from 17% to 4% in decreasing order: -webkit-input-placeholder, -moz-placeholder, -webkit-search-decoration, -webkit-search-cancel-button, -webkit-inner-spin-button, -webkit-outer-spin-button, -webkit-scrollbar (7%), selection, -ms-clear, -moz-selection, -webkit-media-controls, and -webkit-scrollbar-thumb.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1417577353&format=interactive",
  sheets_gid="1972610663",
  sql_file="top_selector_pseudo_elements.sql",
  width=600,
  height=500
) }}

## Values and units

### Lengths

The humble `px` unit has gotten a lot of negative press over the years. At first, because it didn't play nicely with old IE's zoom functionality, and, more recently, because there are better units for most tasks that scale based on another design factor, such as viewport size, element font size, or root font size, reducing maintenance effort by making implicit design relationships explicit. The main selling point of `px` — its correspondence to one device pixel giving designers full control — is also gone now, as a pixel is not a device pixel anymore with the modern high pixel density screens. Despite all this, CSS pixels still nearly ubiquitously drive the Web's designs.

{{ figure_markup(
  caption="Percentage of `<length>` values that use the `px` unit.",
  content="72.58%",
  classes="big-number",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

The `px` unit is still going strong as the most popular length unit overall, with a whopping **72.58% of all length values across all stylesheets using `px`**! And if we exclude percentages (since they are not really a unit) the share of `px` increases even more, to 84.14%.

{{ figure_markup(
  image="length-units.png",
  caption="The most popular `<length>` units as a percent of occurrences.",
  description="Bar chart showing the most popular length units as a percent of occurrences (the frequency that the units appear in all stylesheets). The px unit is by far the most popular, used 73% of the time in mobile stylesheets. The next most popular unit is % (percent sign), at 17%, followed by em at 9%, and rem at 1%. The following units all have usage so low that they round to 0%: pt, vw, vh, ch, ex, cm, mm, in, vmin, pc, and vmax.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2095127496&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

How are these `px` distributed across properties? Is there any difference depending on the property? Most definitely. For example, as one might expect, `px` is far more popular in borders (80-90%) compared to font-related metrics such as `font-size`, `line-height` or `text-indent`. However, even for those, `px` usage vastly outnumbers any other unit. In fact, the **only** properties for which another unit (*any* other unit) is more used than `px` are `vertical-align` (55% `em`), `mask-position` (50% `em`), `padding-inline-start` (62% `em`), `margin-block-start` and `margin-block-end` (65% `em`), and the brand new `gap` with 62% `rem`.

One could easily argue that a lot of this content is just old, written before authors were more enlightened about using relative units to make their designs more adaptable and save themselves time down the line. However, this is easily debunked by looking at more recent properties such as `grid-gap` (62% `px`).

<figure>
  <table>
    <thead>
      <tr>
        <th>Property</th>
        <th><code>px</code></th>
        <th><code>&lt;number&gt;</code></th>
        <th><code>em</code></th>
        <th><code>%</code></th>
        <th><code>rem</code></th>
        <th><code>pt</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>font-size</td>
        <td class="numeric">70%</td>
        <td class="numeric">2%</td>
        <td class="numeric">17%</td>
        <td class="numeric">6%</td>
        <td class="numeric">4%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>line-height</td>
        <td class="numeric">54%</td>
        <td class="numeric">31%</td>
        <td class="numeric">13%</td>
        <td class="numeric">3%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>border</td>
        <td class="numeric">71%</td>
        <td class="numeric">27%</td>
        <td class="numeric">2%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>border-radius</td>
        <td class="numeric">65%</td>
        <td class="numeric">21%</td>
        <td class="numeric">3%</td>
        <td class="numeric">10%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>text-indent</td>
        <td class="numeric">32%</td>
        <td class="numeric">51%</td>
        <td class="numeric">8%</td>
        <td class="numeric">9%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>vertical-align</td>
        <td class="numeric">29%</td>
        <td class="numeric">12%</td>
        <td class="numeric">55%</td>
        <td class="numeric">4%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>grid-gap</td>
        <td class="numeric">63%</td>
        <td class="numeric">11%</td>
        <td class="numeric">9%</td>
        <td class="numeric">1%</td>
        <td class="numeric">16%</td>
        <td></td>
      </tr>
      <tr>
        <td>mask-position</td>
        <td></td>
        <td></td>
        <td class="numeric">50%</td>
        <td class="numeric">50%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>padding-inline-start</td>
        <td class="numeric">33%</td>
        <td class="numeric">5%</td>
        <td class="numeric">62%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>gap</td>
        <td class="numeric">21%</td>
        <td class="numeric">16%</td>
        <td class="numeric">1%</td>
        <td></td>
        <td class="numeric">62%</td>
        <td></td>
      </tr>
      <tr>
        <td>margin-block-end</td>
        <td class="numeric">4%</td>
        <td class="numeric">31%</td>
        <td class="numeric">65%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>margin-inline-start</td>
        <td class="numeric">38%</td>
        <td class="numeric">46%</td>
        <td class="numeric">14%</td>
        <td></td>
        <td class="numeric">1%</td>
        <td></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Unit usage by property.",
      sheets_gid="1200981062",
      sql_file="units_properties.sql"
    ) }}
  </figcaption>
</figure>

Similarly, despite the much touted advantages of `rem` vs `em` for many use cases, and its universal browser support [for years](https://caniuse.com/rem), the Web has still largely not caught up with it: the trusty `em` accounts for 87% of all font-relative units usage and `rem` trails far behind with 12%. We did see some usage of `ch` (width of the '0' glyph) and `ex` (x-height of the font in use) in the wild, but very small (only 0.37% and 0.19% of all font-relative units).

{{ figure_markup(
  image="font-units.png",
  caption="Relative share of font-relative units",
  description="Bar chart showing the relative popularity of different font-based units. em is used overwhelmingly on 87.3% of instances, followed by rem at 12.2, ch at 0.4%, and ex at 0.2% of instances on mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=166603845&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

Lengths are the only types of CSS values for which we can omit the unit when the value is zero, i.e. we can write `0` instead of `0px` or `0em` etc. Developers (or CSS minifiers?) are taking advantage of this extensively: Out of all `0` values, 89% were unitless.

{{ figure_markup(
  image="zero-lengths.png",
  caption="Relative popularity of 0 lengths by unit as a percent of occurrences on mobile pages.",
  description="Pie chart showing 0 lengths with no unit (AKA unitless) used 88.7% of the time on mobile pages, the px unit at 10.7%, and other units on 0.5% of instances.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1935151776&format=interactive",
  sheets_gid="313150061",
  sql_file="units_zero.sql"
) }}

### Calculations

When the [`calc()`](https://developer.mozilla.org/en-US/docs/Web/CSS/calc()) function was introduced for performing calculations between different units in CSS, it was a revolution. Previously, only preprocessors were able to accommodate such calculations, but the results were limited to static values and unreliable, since they were missing the dynamic context that is often necessary.

Today, `calc()` has been [supported by every browser](https://caniuse.com/calc) for nine years already, so it comes as no surprise that it has been widely adopted with 60% of pages using it at least once. If anything, we expected even higher adoption than this.

`calc()` is primarily used for lengths, with 96% of its usage being concentrated in properties that accept `<length>` values, and 60% of that (58% of total usage) on the `width` property!

{{ figure_markup(
  image="calc-properties.png",
  caption="Relative popularity of properties that use `calc()` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of properties that use the calc function as a percent of occurrences. Desktop and mobile have similar results. The calc function is used most often on the width property, 59% of calc occurrences on mobile pages. It's used on the left property 11% of the time, top 5%, max-width 4%, height 4%, and the remaining properties are decreasing at 2% and 1%: min-height, margin-left, flex-basis, margin-right, max-height (1%), right, padding-bottom, padding-left, font-size, and padding-right.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=722318406&format=interactive",
  sheets_gid="1661677319",
  sql_file="calc_properties.sql"
) }}

It appears that most of this usage is to subtract pixels from percentages, as evidenced by the fact that the most common units in `calc()` are `px` (51% of `calc()` usage) and `%` (42% of `calc()` usage), and that 64% of `calc()` usage involves subtraction. Interestingly, the most popular length units with `calc()` are different than the most popular length units overall (e.g. `rem` is more popular than `em`, followed by viewport units), most likely due to the fact that code using `calc()` is newer.

{{ figure_markup(
  image="calc-units.png",
  caption="Relative popularity of units that use `calc()` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of properties that use the calc function as a percent of occurrences. Desktop and mobile have similar results. The calc function is used most often on the width property, 59% of calc occurrences on mobile pages. It's used on the left property 11% of the time, top 5%, max-width 4%, height 4%, and the remaining properties are decreasing at 2% and 1%: min-height, margin-left, flex-basis, margin-right, max-height (1%), right, padding-bottom, padding-left, font-size, and padding-right.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=477094785&format=interactive",
  sheets_gid="769910871",
  sql_file="calc_units.sql"
) }}

{{ figure_markup(
  image="calc-operators.png",
  caption="Relative popularity of operators that use `calc()` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of operators that use the calc function as a percent of occurrences. Desktop and mobile have similar results. The calc function is used most often with the subtraction operator (minus sign), 64% of calc instances on mobile pages, followed by division (forward slash) 20%, addition (plus sign) 11%, and multiplication (asterisk) 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1909242522&format=interactive",
  sheets_gid="2077258816",
  sql_file="calc_operators.sql"
) }}

Most calculations are very simple, with 99.5% of calculations involving up to 2 different units, 88.5% of calculations involving up to 2 operators and 99.4% of calculations involving one set of parentheses or fewer (3 out of 4 calculations include no parentheses at all).

{# TODO(analysts): Figure out what happened to the 3+ label in this chart. #}
{{ figure_markup(
  image="calc-complexity-units.png",
  caption="Distribution of the number of units per `calc()` occurrence.",
  description="Bar chart showing the distribution of the number of units per calc function occurrence. Desktop and mobile have similar results. Calc is used with one unit 11% of the time on mobile pages, twice 89% of the time, and 3 or more times approximately 0% of the time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=695698141&format=interactive",
  sheets_gid="1493602565",
  sql_file="calc_complexity_units.sql"
) }}

### Global keywords and `all`

For a long time, CSS only supported one global keyword: [`inherit`](https://developer.mozilla.org/en-US/docs/Web/CSS/inherit), which enables the resetting of an inheritable property to its inherited value or reusing the parent’s value for a given non-inheritable property. It turns out the former is far more common than the latter, with 81.37% of `inherit` usage being found on inheritable properties. The rest is mostly to inherit backgrounds, borders, or dimensions. The latter likely indicates layout struggles, as with the proper layout mode one rarely needs to force `width` and `height` to inherit.

The `inherit` keyword has been particularly useful for resetting the gory default link colors to the parent’s text color, when we intend to use something other than color as an affordance for links. It is therefore no surprise that `color` is the most common property that `inherit` is used on. Nearly one third of all `inherit` usage is found on the `color` property. 75% of pages use `color: inherit` at least once.

While a property’s *initial value* is a concept that [has existed since CSS 1](https://www.w3.org/TR/CSS1/#cascading-order), it only got its own dedicated keyword, `initial`, to explicitly refer to it [17 years later](https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#initial-keyword), and it took another two years for said keyword to gain [universal browser support](https://caniuse.com/css-initial-value) in 2015. It is therefore no surprise that it is used far less than `inherit`. While the ol’ inherit is found on 85% of pages, `initial` appears in 51% of them. Furthermore, there is a lot of confusion about what `initial` actually does, since `display` tops the list of properties most commonly used with `initial`, with `display: initial` appearing in 10% of pages. Presumably, the developers thought that this resets `display` to its value from the [user agent stylesheet](https://developer.mozilla.org/en-US/docs/Web/CSS/Cascade#User-agent_stylesheets) value and were using it to toggle `display: none` on and off. However, [the initial value of `display` is `inline`](https://drafts.csswg.org/css-display/#the-display-properties), so `display: initial` is just another way to write `display: inline` and has no context-dependent magical properties.

Instead, `display: revert` would have actually done what these developers likely expected and would have reset `display` to the UA value for the given element. However, `revert` is much newer: it was defined [in 2015](https://www.w3.org/TR/2015/WD-css-cascade-4-20150908/#valdef-all-revert) and  [only gained universal browser support this year](https://caniuse.com/css-revert-value), which explains its underuse: it only appears in 0.14% of pages and half of its usage is `line-height: revert;`, found in [recent versions of Wordpress’ TwentyTwenty theme](https://github.com/WordPress/WordPress/commit/303180b392c530b8e2c8b3c27532d591b915caeb).

The last global keyword, `unset` is essentially a hybrid of `initial` and `inherit`. On inherited properties it becomes `inherit` and on the rest it becomes `initial`, essentially resetting the property across all cascade origins. Similarly, to `initial`, it was [defined in 2013](https://www.w3.org/TR/2013/WD-css-cascade-3-20130730/#inherit-initial) and gained [full browser support in 2015](https://caniuse.com/css-unset-value). Despite `unset`’s higher utility, it is used in only 43% of pages, whereas `initial` is used in 51% of pages. Furthermore, besides `max-width` and `min-width`, in every other property `initial` usage outweighs `unset` usage.

{{ figure_markup(
  image="keyword-totals.png",
  caption="Adoption of global keywords as a percent of pages.",
  description="Bar chart showing the adoption of global keywords as a percent of pages. Mobile pages tend to have a higher adoption rate. The inherit keyword is used on 85% of mobile pages, initial on 51%, unset on 43%, and revert on approximately 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1246886332&format=interactive",
  sheets_gid="437371205",
  sql_file="keyword_totals.sql"
) }}

The `all` property was [introduced in 2013](https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#all-shorthand) and gained [near-universal support in 2016 (except Edge) and universal support earlier this year](https://caniuse.com/css-all). It is a shorthand of nearly every property in CSS (except custom properties, `direction`, and `unicode-bidi`), and only accepts the four global keywords as values. It was envisioned as a one liner CSS reset, either as `all: unset` or `all: revert`, depending on what kind of reset we wanted. However, adoption is still very low: we only found `all` on 477 pages (0.01% of all pages), and only used with the `revert` keyword.

## Color

They say the old jokes are the best, and that goes for colors too. The original, cryptic, `#rrggbb` hex syntax remains the most popular way to specify a color in CSS in 2020: Half of all colors are written that way. The next most popular format is the somewhat shorter `#rgb` three-digit hex format at 26%. While it is shorter, it is also able to express *way* fewer colors; only 4096, out of the 16.7 million sRGB values.

{{ figure_markup(
  image="popular-color-formats.png",
  caption="Relative popularity of color formats as a percent of occurrences.",
  description="Bar chart showing the relative popularity of color formats as a percent of occurrences. The #rrggbb color format is used in 50% of occurrences on mobile pages, with desktop slightly higher at 52%. The #rgb format is used in 25% of occurrences, followed by rgba() at 14%, transparent at 8%, a named color (like red) at 1%, and the remaining color formats all have approximately 0% relative popularity on mobile pages: #rrggbbaa, rbg(), hsla(), currentColor, #rgba, a system color, hsl(), and color().",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=65722098&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

Similarly, 99.89% of functionally specified sRGB colors are using the since-forever legacy format with commas `rgb(127, 255, 84)` rather than the new comma-less form `rgb(127 255 84)`. Because, despite all modern browsers accepting the new syntax, changing offers zero advantage to developers.

So why do people stray from these tried and true formats? To express alpha transparency. This is clear when you look at `rgba()`, which is used 40 times more than `rgb()` (13.82% vs 0.34% of all colors) and `hsla()`, which is used 30 times more than `hsl()` (0.25% vs 0.01% of all colors).

And yes, these numbers also show that despite the much-vaunted (but [largely incorrect](https://drafts.csswg.org/css-color-4/#the-hsl-notation)) *easily-understood* or *easily-modified advantages* of HSL, in practice it is used *far less* than RGB.

{{ figure_markup(
  image="color-formats-alpha.png",
  caption="Relative popularity of color formats grouped by alpha support as a percent of occurrences on mobile pages (excluding `#rrggbb` and `#rgb`).",
  description="Bar chart showing the relative popularity of color formats grouped by alpha support as a percent of occurrences on mobile pages, excluding #rrggbb and #rgb. Color formats that support alpha add up to about 23% of occurrences, while color formats that do not support alpha add up to only 2% of occurrences on mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1861989753&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

What about named colors? The keyword `transparent`, which is just another way to say `rgb(0 0 0 / 0)`, is most popular, at 8.25% of all sRGB values (66% of all named-color usage); followed by  all the named (X11) colors – I’m looking at you, `papayawhip` – at 1.48%. The most popular of these were the easily understood names like `white`, `black`, `red`, `gray`, `blue`. `Whitesmoke` was the most common  of the non-ordinary names (sure, we can visualize whitesmoke, right) while the likes of `gainsboro`, `lightCoral` and `burlywood` were used way less. We can understand why, you need to look them up to see what they actually mean.

And if you are going for fanciful color names, why not define your own with CSS [Custom properties](#custom-properties)? `--intensePurple` and `--corporateBlue` mean whatever you need them to mean. This probably explains why [50% of Custom Properties](#usage-by-type) are used for colors.

{#TODO mention color keyword app}

{# TODO(analysts, CSS experts): figure out why the swatches aren't working. #}
<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>Keyword</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{{ swatch('transparent') }}</span></td>
        <td>transparent</td>
        <td class="numeric">84.04%</td>
        <td class="numeric">83.51%</td>
      </tr>
      <tr>
        <td>{{ swatch('white') }}</td>
        <td>white</td>
        <td class="numeric">6.82%</td>
        <td class="numeric">7.34%</td>
      </tr>
      <tr>
        <td>{{ swatch('black') }}</span></td>
        <td>black</td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.42%</td>
      </tr>
      <tr>
        <td>{{ swatch('red') }}</td>
        <td>red</td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.01%</td>
      </tr>
      <tr>
        <td>{{ swatch('currentColor') }}</span></td>
        <td>currentColor</td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.43%</td>
      </tr>
      <tr>
        <td>{{ swatch('gray') }}</span></td>
        <td>gray</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td>{{ swatch('silver') }}</span></td>
        <td>silver</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>{{ swatch('grey') }}</span></td>
        <td>grey</td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td>{{ swatch('green') }}</span></td>
        <td>green</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>{{ swatch('magenta') }}</span></td>
        <td>magenta</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('blue') }}</span></td>
        <td>blue</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('whitesmoke') }}</span></td>
        <td>whitesmoke</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgray') }}</span></td>
        <td>lightgray</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>{{ swatch('orange') }}</span></td>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgrey') }}</span></td>
        <td>lightgrey</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('yellow') }}</span></td>
        <td>yellow</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>{{ swatch('Highlight') }}</span></td>
        <td>Highlight</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('gold') }}</span></td>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('pink') }}</span></td>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>{{ swatch('teal') }}</span></td>
        <td>teal</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Relative popularity of color keywords as a percent of occurrences.",
      sheets_gid="1429541094",
      sql_file="color_keywords.sql"
    ) }}
  </figcaption>
</figure>

And, lastly, the once-deprecated, now partially un-deprecated system colors like `Canvas` and `ThreeDDarkShadow`: These were a terrible idea, introduced to emulate the typical user interface of things like Java or Windows 95, and already unable to keep up with Windows 98, they soon fell by the wayside. Some sites use these system colors to try and fingerprint you, a loophole that [we are trying to close as we speak](https://github.com/w3c/csswg-drafts/issues/5710). There are *few good reasons* to use them, and most websites (99.99%) don’t, so we are all good.

The rather useful value `currentColor`, surprisingly, trailed at 0.14% of all sRGB colors (1.62% of all named colors).

All the colors we discussed so far have one thing in common: sRGB, the standard color space for the Web (and for High Definition TV, which is where it came from). Why is that so bad? Because it can only display a limited range of colors: your phone, your TV, and probably your laptop are able to display much more vivid colors due to advances in display technology. Displays with wide color gamut, which used to be reserved for well-paid professional photographers and graphic designers, are now available to everyone. Native apps use this capability, as do digital movies and streaming TV services, but until recently the Web was missing out.

And we are still missing out. Despite being [implemented in Safari in 2016](https://webkit.org/blog/6682/improving-color-on-the-web/), the use of display-p3 color in Web pages is vanishingly small. Our crawl of the Web found only 29 mobile and 36 desktop pages (!) using it. (And more than half of those were syntax errors, mistakes, or attempts to use the never-implemented `color-mod()` function). We were curious why.

Compatibility, right? You don’t want things to break? No. In the stylesheets we examined, we found solid use of fallback: with document order, the cascade, `@supports`, the `color-gamut` media query, all that good stuff. So in a style sheet we would see the color the designer wanted, expressed in display-p3, and also a fallback sRGB color. We computed the visible difference (a calculation called [ΔE2000](http://zschuessler.github.io/DeltaE/learn/)) between the desired and fallback color and this was typically quite modest. A small tweak. A careful exploration. In fact, 37.6% of the time, the color specified in display-p3 actually fell inside the range of colors (the gamut) that sRGB can manage.

{# TODO What to do with this huge table?}
<figure>
  <table>
    <thead>
      <tr>
        <th>sRGB</th>
        <th></th>
        <th><code>display-p3</code></th>
        <th>ΔE2000</th>
        <th>In gamut</th>
      </tr>
    </thead>
    <tbody>
        <tr><td>rgba(255,205,63,1) <td style="background-color:rgba(255,205,63,1) "><td>color(display-p3 1 0.80 0.25 / 1)<td>3.88<td>false</tr>
        <tr><td>rgba(120,0,255,1)<td style="background-color:rgba(120,0,255,1)"><td>color(display-p3 0.47 0 1 / 1)<td>1.933<td>false</tr>
        <tr><td>rgba(121,127,132,1)<td style="background-color:rgba(121,127,132,1)"><td>color(display-p3 0.48 0.50 0.52 / 1)<td>0.391<td>true</tr>
        <tr><td>rgba(200,200,200,1)<td style="background-color:rgba(200,200,200,1)"><td>color(display-p3 0.78 0.78 0.78 / 1)<td>0.274<td>true</tr>
        <tr><td>rgba(97,97,99,1)<td style="background-color:rgba(97,97,99,1)"><td>color(display-p3 0.39 0.39 0.39 / 1)<td>1.474<td>true</tr>
        <tr><td>rgba(0,0,0,1)<td style="background-color:rgba(0,0,0,1)"><td>color(display-p3 0 0 0 / 1)<td>0<td>true</tr>
        <tr><td>rgba(255,255,255,1)<td style="background-color:rgba(255,255,255,1)"><td>color(display-p3 1 1 1 / 1)<td>0.015<td>false</tr>
        <tr><td>rgba(84,64,135,1)<td style="background-color:rgba(84,64,135,1)"><td>color(display-p3 0.33 0.25 0.53 / 1)<td>1.326<td>true</tr>
        <tr><td>rgba(131,103,201,1)<td style="background-color:rgba(131,103,201,1)"><td>color(display-p3 0.51 0.40 0.78 / 1)<td>1.348<td>true</tr>
        <tr><td>rgba(68,185,208,1)<td style="background-color:rgba(68,185,208,1)"><td>color(display-p3 0.27 0.75 0.82 / 1)<td>5.591<td>false</tr>
        <tr><td>rgb(255,0,72)<td style="background-color:rgb(255,0,72)"><td>color(display-p3 1 0 0.2823 / 1)<td>3.529<td>false</tr>
        <tr><td>rgba(255,205,63,1)<td style="background-color:rgba(255,205,63,1)"><td>color(display-p3 1 0.80 0.25 / 1)<td>3.88<td>false</tr>
        <tr><td>rgba(241,174,50,1)<td style="background-color:rgba(241,174,50,1)"><td>color(display-p3 0.95 0.68 0.17 / 1)<td>4.701<td>false</tr>
        <tr><td>rgba(245,181,40,1)<td style="background-color:rgba(245,181,40,1)"><td>color(display-p3 0.96 0.71 0.16 / 1)<td>4.218<td>false</tr>
        <tr><td>rgb(147, 83, 255)<td style="background-color:rgb(147, 83, 255)"><td>color(display-p3 0.58 0.33 1 / 1)<td>2.143<td>false</tr>
        <tr><td>rgba(75,3,161,1)<td style="background-color:rgba(75,3,161,1)"><td>color(display-p3 0.29 0.01 0.63 / 1)<td>1.321<td>false</tr>
        <tr><td>rgba(255,0,0,0.85)<td style="background-color:rgba(255,0,0,0.85)"><td>color(display-p3 1 0 0 / 0.85)<td>7.115<td>false</tr>
        <tr><td>rgba(84,64,135,1)<td style="background-color:rgba(84,64,135,1)"><td>color(display-p3 0.33 0.25 0.53 / 1)<td>1.326<td>true</tr>
        <tr><td>rgba(131,103,201,1)<td style="background-color:rgba(131,103,201,1)"><td>color(display-p3 0.51 0.40 0.78 / 1)<td>1.348<td>true</tr>
        <tr><td>rgba(68,185,208,1)<td style="background-color:rgba(68,185,208,1)"><td>color(display-p3 0.27 0.75 0.82 / 1)<td>5.591<td>false</tr>
        <tr><td>#6d3bff<td style="background-color:#6d3bff"><td>color(display-p3 .427 .231 1)<td>1.584<td>false</tr>
        <tr><td>#03d658<td style="background-color:#03d658"><td>color(display-p3 .012 .839 .345)<td>4.958<td>false</tr>
        <tr><td>#ff3900<td style="background-color:#ff3900"><td>color(display-p3 1 .224 0)<td>7.14<td>false</tr>
        <tr><td>#7cf8b3<td style="background-color:#7cf8b3"><td>color(display-p3 .486 .973 .702)<td>4.284<td>true</tr>
        <tr><td>#f8f8f8<td style="background-color:#f8f8f8"><td>color(display-p3 .973 .973 .973)<td>0.028<td>true</tr>
        <tr><td>#e3f5fd<td style="background-color:#e3f5fd"><td>color(display-p3 .875 .945 .976)<td>1.918<td>true</tr>
        <tr><td>#e74832<td style="background-color:#e74832"><td>color( display-p3 .905882353 .282352941 .196078431 / 1 )<td>3.681<td>true</tr>
        <tr><td>#303e6a<td style="background-color:#303e6a"><td>color( display-p3 0.188 0.243 0.416 / 1 )<td>1.413<td>true</tr>
        <tr><td>#08257c<td style="background-color:#08257c"><td>color( display-p3 0.031 0.145 0.486 / 1 )<td>1.055<td>false</tr>
        <tr><td>#706f6f<td style="background-color:#706f6f"><td>color(display-p3 .439 .435 .435/1)<td>0.174<td>true</tr>
        <tr><td>#005992<td style="background-color:#005992"><td>color(display-p3 0 .349 .573/1)<td>3.211<td>false</tr>
        <tr><td>#1a1b1f<td style="background-color:#1a1b1f"><td>color(display-p3 .102 .106 .122/1)<td>0.317<td>true</tr>
        <tr><td>#e0ebf2<td style="background-color:#e0ebf2"><td>color(display-p3 .878 .922 .949/1)<td>1.321<td>true</tr>
        <tr><td>#e9607e<td style="background-color:#e9607e"><td>color( display-p3 0.914 0.376 0.494 / 1 )<td>3.146<td>true</tr>
        <tr><td>#222222<td style="background-color:#222222"><td>color( display-p3 0.133 0.133 0.133 / 1 )<td>0.027<td>true</tr>
        <tr><td>#fef8e7<td style="background-color:#fef8e7"><td>color( display-p3 0.996 0.973 0.906 / 1 )<td>0.805<td>false</tr>
        <tr><td>#e15718<td style="background-color:#e15718"><td>color( display-p3 0.882 0.341 0.094 / 1 )<td>4.789<td>false</tr>
        <tr><td>#082e54<td style="background-color:#082e54"><td>color( display-p3 0.031 0.18 0.329 / 1 )<td>2.297<td>false</tr>
        <tr><td>#dae0e6<td style="background-color:#dae0e6"><td>color( display-p3 0.855 0.878 0.902 / 1 )<td>0.666<td>true</tr>
        <tr><td>#fff6f8<td style="background-color:#fff6f8"><td>color( display-p3 1 0.965 0.973 / 1 )<td>1.003<td>false</tr>
        <tr><td>#2a93ca<td style="background-color:#2a93ca"><td>color(display-p3 .165 .576 .792 / 1)<td>3.556<td>false</tr>
        <tr><td>#009183<td style="background-color:#009183"><td>color( display-p3 0 0.569 0.514 / 1 )<td>4.376<td>false</tr>
        <tr><td>#ff6e47<td style="background-color:#ff6e47"><td>color( display-p3 1 0.431 0.278 / 1 )<td>3.49<td>false</tr>
        <tr><td>#1b1b1d<td style="background-color:#1b1b1d"><td>color( display-p3 0.106 0.106 0.114 / 1 )<td>0.167<td>true</tr>
        <tr><td>#4f6483<td style="background-color:#4f6483"><td>color( display-p3 0.31 0.392 0.514 / 1 )<td>1.882<td>true</tr>
        <tr><td>#a50832<td style="background-color:#a50832"><td>color( display-p3 0.647 0.031 0.196 / 1 )<td>2.967<td>false</tr>
        <tr><td>#dae0e6<td style="background-color:#dae0e6"><td>color( display-p3 0.855 0.878 0.902 / 1 )<td>0.666<td>true</tr>
        <tr><td>#fafafa<td style="background-color:#fafafa"><td>color( display-p3 0.98 0.98 0.98 / 1 )<td>0.025<td>true</tr>
        <tr><td>#cc0066<td style="background-color:#cc0066"><td>color( display-p3 0.8 0 0.4 / 1 )<td>3.113<td>false</tr>
        <tr><td>#e74832<td style="background-color:#e74832"><td>color( display-p3 .905882353 .282352941 .196078431 / 1 )<td>3.681<td>true</tr>
        <tr><td>#48FF7E<td style="background-color:#48FF7E"><td>color(display-p3 0.462 1 0.5/1)<td>2.338<td>false</tr>
        <tr><td>#FFA500<td style="background-color:#FFA500"><td>color(display-p3 .9961 .6667 0)<td>5.777<td>false</tr>
        <tr><td>#FFCE00<td style="background-color:#FFCE00"><td>color(display-p3 1 .8157 .0667)<td>4.606<td>false</tr>
        <tr><td>#00c<td style="background-color:#00c"><td>color(display-p3 0 0 .8 / 1)<td>1.052<td>false</tr>
        <tr><td>#2db0fe<td style="background-color:#2db0fe"><td>color(display-p3 .176 .69 .996 / 1)<td>3.872<td>false</tr>
        <tr><td>#d1eeff<td style="background-color:#d1eeff"><td>color(display-p3 .82 .933 1 / 1)<td>2.196<td>false</tr>
        <tr><td>#1da0ef<td style="background-color:#1da0ef"><td>color(display-p3 0.122 0.62 0.937)<td>3.385<td>false</tr>
        <tr><td>#F95974<td style="background-color:#F95974"><td>color( display-p3 .97 0.349 0.454 / 1 )<td>2.978<td>false</tr>
        <tr><td>#1BA388<td style="background-color:#1BA388"><td>color( display-p3 0.105 0.639 0.533 / 1 )<td>4.485<td>false</tr>
        <tr><td>#6d3bff<td style="background-color:#6d3bff"><td>color(display-p3 .427 .231 1)<td>1.584<td>false</tr>
        <tr><td>#e3f5fd<td style="background-color:#e3f5fd"><td>color(display-p3 .875 .945 .976)<td>1.918<td>true</tr>
        <tr><td>#ff3900<td style="background-color:#ff3900"><td>color(display-p3 1 .224 0)<td>7.14<td>false</tr>
        <tr><td>#7cf8b3<td style="background-color:#7cf8b3"><td>color(display-p3 .486 .973 .702)<td>4.284<td>true</tr>
        <tr><td>#f8f8f8<td style="background-color:#f8f8f8"><td>color(display-p3 .973 .973 .973)<td>0.028<td>true</tr>
        <tr><td>#6d3bff<td style="background-color:#6d3bff"><td>color(display-p3 0 .478 1)<td>25.945<td>false</tr>
        <tr><td>#dc7100<td style="background-color:#dc7100"><td>color(display-p3 .862745098 .443137255 0 / 1)<td>5.734<td>false</tr>
        <tr><td>#fff7f1<td style="background-color:#fff7f1"><td>color(display-p3 1 .968627451 .945098039 / 1)<td>0.929<td>false</tr>
        <tr><td>#6464dc<td style="background-color:#6464dc"><td>color(display-p3 .392156863 .392156863 .862745098 / 1)<td>0.957<td>true</tr>
        <tr><td>#509b82<td style="background-color:#509b82"><td>color(display-p3 .31372549 .607843137 .509803922 / 1)<td>3.664<td>true</tr>
        <tr><td>#aa5082<td style="background-color:#aa5082"><td>color(display-p3 .666666667 .31372549 .509803922 / 1)<td>2.758<td>true</tr>
        <tr><td>#dc7100<td style="background-color:#dc7100"><td>color(display-p3 .862745098 .443137255 0 / 1)<td>5.734<td>false</tr>
        <tr><td>#509b82<td style="background-color:#509b82"><td>color(display-p3 .31372549 .607843137 .509803922 / 1)<td>3.664<td>true</tr>
        <tr><td>#fff2f7<td style="background-color:#fff2f7"><td>color(display-p3 1 .949019608 .968627451 / 1)<td>1.374<td>false</tr>
        <tr><td>#DC7100<td style="background-color:#DC7100"><td>color(display-p3 .862745098 .443137255 0 / 1)<td>5.734<td>false</tr>
        <tr><td>#509B82<td style="background-color:#509B82"><td>color(display-p3 .31372549 .607843137 .509803922 / 1)<td>3.664<td>true</tr>
        <tr><td>#AA5082<td style="background-color:#AA5082"><td>color(display-p3 .666666667 .31372549 .509803922 / 1)<td>2.758<td>true</tr>
        <tr><td>#1e1f20<td style="background-color:#1e1f20"><td>color(display-p3 .117647059 .121568627 .125490196 / 1)<td>0.193<td>true</tr>
        <tr><td>#082e54<td style="background-color:#082e54"><td>color( display-p3 0.031 0.18 0.329 / 1 )<td>2.297<td>false</tr>
        <tr><td>#dd3333<td style="background-color:#dd3333"><td>color( display-p3 0.867 0.2 0.2 / 1 )<td>3.59<td>true</tr>
        <tr><td>#4f6483<td style="background-color:#4f6483"><td>color( display-p3 0.31 0.392 0.514 / 1 )<td>1.882<td>true</tr>
        <tr><td>#dae0e6<td style="background-color:#dae0e6"><td>color( display-p3 0.855 0.878 0.902 / 1 )<td>0.666<td>true</tr>
        <tr><td>#fff6f8<td style="background-color:#fff6f8"><td>color( display-p3 1 0.965 0.973 / 1 )<td>1.003<td>false</tr>
        <tr><td>#FFA500<td style="background-color:#FFA500"><td>color(display-p3 .9961 .6667 0)<td>5.777<td>false</tr>
        <tr><td>#FFCE00<td style="background-color:#FFCE00"><td>color(display-p3 1 .8157 .0667)<td>4.606<td>false</tr>
        <tr><td>#212121<td style="background-color:#212121"><td>color(display-p3 .129 .129 .129/1)<td>0.033<td>true</tr>
        <tr><td>#bebebe<td style="background-color:#bebebe"><td>color(display-p3 .745 .745 .745/1)<td>0.014<td>true</tr>
        <tr><td>#ee2<td style="background-color:#ee2"><td>color(display-p3 .933 .933 .133/1)<td>4.456<td>false</tr>
        <tr><td>#edede1<td style="background-color:#edede1"><td>color(display-p3 .929 .929 .882/1)<td>0.481<td>true</tr>
        <tr><td>#fffc00<td style="background-color:#fffc00"><td>color(display-p3 1 0.9882 0)<td>5.012<td>false</tr>
        <tr><td>#333<td style="background-color:#333"><td>color( display-p3 0.2 0.2 0.2 / 1 )<td>0.005<td>true</tr>
        <tr><td>#681160<td style="background-color:#681160"><td>color(display-p3 .408 .067 .376/1)<td>2.236<td>true</tr>
        <tr><td>#e91e63<td style="background-color:#e91e63"><td>color(display-p3 .914 .118 .388/1)<td>3.311<td>false</tr>
        <tr><td>#e0dede<td style="background-color:#e0dede"><td>color(display-p3 .878 .871 .871/1)<td>0.134<td>true</tr>
        <tr><td>#00a1f3<td style="background-color:#00a1f3"><td>color(display-p3 .114 .627 .937)<td>3.423<td>false</tr>
        <tr><td>#5b23cb<td style="background-color:#5b23cb"><td>color(display-p3 .357 .137 .796)<td>1.528<td>true</tr>
        <tr><td>#03d658<td style="background-color:#03d658"><td>color(display-p3 .012 .839 .345)<td>4.958<td>false</tr>
        <tr><td>#e3f5fd<td style="background-color:#e3f5fd"><td>color(display-p3 .875 .945 .976)<td>1.918<td>true</tr>
        <tr><td>#ff3900<td style="background-color:#ff3900"><td>color(display-p3 1 .224 0)<td>7.14<td>false</tr>
        <tr><td>#f8f8f8<td style="background-color:#f8f8f8"><td>color(display-p3 .973 .973 .973)<td>0.028<td>true</tr>
        <tr><td>#f29832<td style="background-color:#f29832"><td>color(display-p3 .949 .596 .196/1)<td>3.921<td>false</tr>
        <tr><td>#26ad79<td style="background-color:#26ad79"><td>color(display-p3 .149 .678 .475/1)<td>4.604<td>false</tr>
        <tr><td>rgb(255, 255, 255)<td style="background-color:rgb(255, 255, 255)"><td>color(display-p3 1 1 1)<td>0.015<td>false</tr>
        <tr><td>rgb(242, 242, 247)<td style="background-color:rgb(242, 242, 247)"><td>color(display-p3 0.949 0.949 0.9686)<td>0.234<td>true</tr>
        <tr><td>rgb(54, 54, 56)<td style="background-color:rgb(54, 54, 56)"><td>color(display-p3 0.2117 0.2117 0.2196)<td>0.137<td>true</tr>
        <tr><td>rgb(142, 142, 147)<td style="background-color:rgb(142, 142, 147)"><td>color(display-p3 0.5568 0.5568 0.5764)<td>0.25<td>true</tr>
        <tr><td>rgb(0, 122, 255)<td style="background-color:rgb(0, 122, 255)"><td>color(display-p3 0 0.4784 1)<td>2.847<td>false</tr>
        <tr><td>rgb(229, 229, 234)<td style="background-color:rgb(229, 229, 234)"><td>color(display-p3 0.898 0.898 0.9176)<td>0.236<td>true</tr>
        <tr><td>rgb(255, 59, 48)<td style="background-color:rgb(255, 59, 48)"><td>color(display-p3 1 0.2313 0.1882)<td>3.996<td>false</tr>
        <tr><td>rgb(0, 113, 164)<td style="background-color:rgb(0, 113, 164)"><td>color(display-p3 0 0.4431 0.6431)<td>3.488<td>false</tr>
        <tr><td>rgb(36, 138, 61)<td style="background-color:rgb(36, 138, 61)"><td>color(display-p3 0.1411 0.5411 0.2392)<td>4.257<td>false</tr>
        <tr><td>rgb(88, 86, 214)<td style="background-color:rgb(88, 86, 214)"><td>color(display-p3 0.345 0.3372 0.8392)<td>0.949<td>true</tr>
        <tr><td>rgb(175, 82, 222)<td style="background-color:rgb(175, 82, 222)"><td>color(display-p3 0.6862 0.3215 0.8705)<td>2.5<td>true</tr>
        <tr><td>rgb(255, 149, 0)<td style="background-color:rgb(255, 149, 0)"><td>color(display-p3 1 0.5843 0)<td>5.57<td>false</tr>
        <tr><td>rgb(72, 72, 74)<td style="background-color:rgb(72, 72, 74)"><td>color(display-p3 0.2823 0.2823 0.2901)<td>0.115<td>true</tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="this table shows the fallback sRGB colors (plus a color swatch), then the display-p3 colors. A color difference (ΔE2000) of 1 is barely visible, while 5 is clearly distinct."
    ) }}
  </figcaption>
</figure>

{# TODO the figure below needs an actual object tag, otherwise tooltips are not shown}

{{ figure_markup(
  image="UCS-p3-pairs.svg",
  caption="This 1976 u’v’ diagram shows the chromaticity of colors (flattened to 2D, so lightness is not shown). The outer curved shape represents the spectrum of pure single wavelengths; there are no visible colors outside this. The straight line is purple, a mixture of red and violet. The smaller, grey, triangle is the sRGB gamut while the larger, darker triangle is the display-p3 gamut. The 23 unique display-p3 colors actually in use on the web in 2020 are shown; for each pair of colors the larger circle is the sRGB fallback while the smaller circle is the display-p3 color. If it is inside the sRGB gamut, those circles show the correct color. Otherwise, a white circle with a red edge indicates out of sRGB-gamut colors.",
  width=600,
  height=600
) }}

The purplish colors are similar in sRGB and display-p3, perhaps because both those color spaces have the same blue primary. Various reds, orange-yellows, and greens are near the sRGB gamut boundary (nearly as saturated as possible) and map to analogous points near the display-p3 gamut boundary.

There seem to be two reasons why the Web is still trapped in sRGB land. The first is lack of tools, lack of good color pickers, lack of understanding of what more vivid colors are available. But the major reason, we think, is that to date Safari is the only browser to implement it. This is changing, rapidly - Chrome and Firefox are both implementing right now - but until that support ships, probably using display-p3  is too much effort for too little gain because [only 17% of viewers](https://gs.statcounter.com/browser-market-share) will see those colors. Most people will see the fallback. So current usage is a subtle shift in color vibrancy, rather than a big difference.

It will be interesting to see how the use of display-p3 color (other options exist, but this is the only one we found in the wild) changes over the next year or two.

Because *wide color gamut* (WCG) is only the beginning. The TV and movie industry has already moved past P3 to an even wider gamut, rec2020; and also a wider range of lightness, from blinding reflections to deepest shadows. *High Dynamic Range* (HDR) has already arrived in the home, especially on games, streaming TV and movies. The Web has a bunch of catching up to do.

## Gradients

Despite minimalism and flat design being all the rage, CSS gradients are used in 75% of pages. As expected, nearly all gradients are used in backgrounds. 74.45% of pages specify gradients in backgrounds, but only 7% in **any** other property.

Linear gradients are 5 times more popular than radial ones, appearing in almost 73% of pages, compared to 15% for radial gradients. The difference in popularity is so staggering, that even `-ms-linear-gradient()`, which **was never needed** (IE10 supported gradients both with and without the `-ms-` prefix), is more popular than `radial-gradient()`! The [newly supported](https://caniuse.com/css-conic-gradients) `conic-gradient()` is even more underutilized, appearing in only 652 desktop pages (0.01%) and 848 mobile pages (0.01%), which is expected, since Firefox has only just shipped its implementation to the stable channel.

Repeating gradients of all types are fairly underused too, with `repeating-linear-gradient()` appearing in only 3% of pages and the others trailing behind even more (`repeating-conic-gradient()` is only used in 21 pages!).

Prefixed gradients are also still very common, even though prefixes haven't been needed in gradients since 2013.  It is notable that -webkit-gradient() is still used in half of all websites, even though it [hasn't been needed since 2011](https://caniuse.com/css-gradients). And  `-webkit-linear-gradient()` is still the second most used gradient function of all, appearing in 57% of websites, with the other prefixed forms also being used in a third to half of pages.

{{ figure_markup(
  image="gradient-functions.png",
  caption="The most popular gradient functions as a percent of pages.",
  description="Bar chart showing the most popular gradient functions as a percent of desktop and mobile pages. Gradient functions tend to be more popular on mobile pages. The most popular gradient function is linear-gradient, used on 73% of mobile pages. Followed by -webkit-linear-gradient on 57%, -webkit-gradient and -linear-gradient on 50%, -moz-linear-gradient on 49%, -ms-linear-gradient on 33%, radial-gradient on 15%, -webkit-radial-gradient on 9%, and repeating-linear-gradient and -moz-radial-gradient used on 3% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1552177796&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

{{ figure_markup(
  image="gradient-functions-unprefixed.png",
  caption="The most popular gradient functions as a percent of pages, omitting vendor prefixes.",
  description="Bar chart showing the most popular gradient functions as a percent of desktop and mobile pages, omitting vendor prefixes. Desktop adoption is slightly behind mobile. Variations of linear-gradient are used on 72.57% of mobile pages, radial-gradient on 15.13%, repeating-linear-gradient on 2.99%, repeating-radial-gradient on 0.07%, conic-gradient on 0.01%, and repeating-conic-gradient on approximately 0.00% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1676879657&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

Using color stops with different colors in the same position (hard stops) to create stripes and other patterns is a technique [first popularized in 2010](https://lea.verou.me/2010/12/checkered-stripes-other-background-patterns-with-css3-gradients/) (by Lea Verou), which by now has many interesting variations, including [some really cool ones with blend modes](https://bennettfeely.com/gradients/). While it may seem like a hack, hard stops are found in 50% of pages, indicating a strong developer need for lightweight graphics from within CSS without resorting to image editors or external SVG.

 Interpolation hints (or as Adobe, who popularized the technique, calls them: “midpoints”) are found on 22% of pages, despite [near universal browser support since 2015](https://caniuse.com/mdn-css_types_image_gradient_linear-gradient_interpolation_hints). Which is a shame, because without them, the color stops are connected by straight-lines in the colorspace, rather than smooth curves. This low usage probably reflects a misunderstanding of what they do, or how to use them; contrast this with CSS transitions and animations, where easing functions (which do much the same thing, i.e. connect the keyframes with curves rather than jerky straight lines) are much more commonly used ([80% of transitions](TODO: link to transitions section, or timing function section if possible)). “Midpoints” is not a very understandable description, and “interpolation hint” sounds like you are helping the browser to do simple arithmetic.

Most gradient usage is rather simple, with over 75% of gradients found across the entire dataset only using 2 color stops. In fact, fewer than half of pages contain even a single gradient with more than 3 color stops!

The gradient with the most color stops is [this one](https://dabblet.com/gist/4d1637d78c71ef2d8d37952fc6e90ff5) with 646 stops! So pretty! This is almost certainly generated, and the resulting CSS code is 8KB, so a 1px tall PNG would likely have done the job as well, with a smaller footprint.

{{ figure_markup(
  image="gradient-most-stops.png",
  caption="The gradient with the most color stops, 646.",
  description="A screenshot of the gradient with the most color stops, which is a series of intricate multicolor stripes of varying hues.",
  alt="A screenshot of the gradient with the most color stops, which is a series of intricate multicolor stripes of varying hues.",
  width=600,
  height=100
) }}

## Layout

### Flexbox and Grid adoption

{{ figure_markup(
  image="flexbox-grid-mobile.png",
  caption="Adoption of flexbox and grid by year as a percent of mobile pages.",
  description="Bar chart showing the adoption of flexbox and grid by year as a percent of mobile pages. Flexbox adoption grew from 2019 to 2020 from 41% to 63% of mobile pages. Grid adoption grew from 2% to 4% over the same time period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1879364309&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="flexbox-grid-desktop.png",
  caption="Adoption of flexbox and grid by year as a percent of dekstop pages.",
  description="Bar chart showing the adoption of flexbox and grid by year as a percent of desktop pages. Flexbox adoption grew from 2019 to 2020 from 41% to 65% of mobile pages. Grid adoption grew from 2% to 5% over the same time period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1140202160&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="layout-methods.png",
  caption="Adoption of layout methods as a percent of pages.",
  description="Bar chart showing the adoption of layout methods as a percent of desktop and mobile pages. Desktop and mobile results are similar unless otherwise noted. The top four layout methods are block, absolute, floats, and inline-block at 92%, 92%, 91%, and 90% adoption respectively. Following those, inline, fixed, and css tables have 81%, 80%, and 80% adoption respectively. Flex has 68% adoption, followed by box at 46% and distinctly larger than desktop adoption at 38%, inline-flex at 33%, grid at 30%, list-item at 26%, inline-table at 26%, inline-box at 20%, and sticky at 13% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013998073&format=interactive",
  width="600",
  height="588",
  sheets_gid="1330536609",
  sql_file="layout_properties.sql"
) }}

### Usage of different Grid layout techniques

### Multiple-column layout

### Box sizing

{{ figure_markup(
  image="box-sizing.png",
  caption="Distribution of the number of `border-box` declarations per page.",
  description="Bar chart showing the distribution of the number of box-sizing declarations per page for desktop and mobile. The mobile distribution leads desktop by 0 to 11 declarations per page, growing in the higher percentiles. The mobile distribution's 10, 25, 50, 75, and 90th percentiles are: 0, 4, 17, 46, and 96 border-box declarations per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1626960751&format=interactive",
  sheets_gid="1982524793",
  sql_file="box_sizing.sql"
) }}

## Transitions and animations

{{ figure_markup(
  image="transition-properties.png",
  caption="Adoption of transition properties as a percent of pages.",
  description="Bar chart showing the adoption of the most popular transition properties. Desktop and mobile pages are very similar except filter doesn't appear to be used significantly at all on desktop. The most popular transition property on mobile pages is all, used on 41% of pages, followed by opacity at 37%, transform at 26%, color at 17%, none at 15%, height at 13%, background-color at 12%, background at 10%, filter at 7%, and the remaining properties used on 6% of mobile pages: width, left, top, -webkit-transform, box-shadow, and border-color.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1677028861&format=interactive",
  sheets_gid="134272305",
  sql_file="transition_properties.sql"
) }}

{{ figure_markup(
  image="transition-durations.png",
  caption="Distribution of transition durations.",
  description="Bar chart showing the distribution of transition durations in milliseconds for desktop and mobile pages. Desktop and mobile are equivalent at the 10, 25, and 90th percentiles with 100, 150, and 500ms durations respectively. However at the median and 75th percentiles, desktop has higher durations by 50ms: 300 and 400ms respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1587838983&format=interactive",
  sheets_gid="286912288",
  sql_file="transition_durations.sql"
) }}

{{ figure_markup(
  image="transition-timing-functions.png",
  caption="Relative popularity of timing functions as a percent of occurrences on mobile pages.",
  description="Pie chart showing the relative popularity of timing functions as a percent of occurrences on mobile pages. The most popular timing function is ease at 31% of occurrences, followed by linear at 19%, ease-in-out at 19%, cubic-bezier at 13%, ease-out at 9%, steps at 5%, and ease-in at 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=63879013&format=interactive",
  sheets_gid="1514240349",
  sql_file="transition_timing_functions.sql"
) }}

## Visual effects

### Blend modes

### Filters

### Masks

{{ figure_markup(
  image="mask-properties.png",
  caption="Relative popularity of animation name categories as a percent of occurrences.",
  description="Relative popularity of animation name categories as a percent of occurrences. -webkit-mask-image is used on 22% of mobile pages, up from 19% on desktop. The following properties are mask-size and mask-image at 19%, mask-repeat, mask-postion, mask-mode, and -webkit-mask-size at 18%, -webkit-mask-repeat and -webkit-mask-position at 16%, and -webkit-mask and mask properties at 2% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=615866471&format=interactive",
  width="600",
  height="575",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

### Clipping paths

## Responsive design

### Which media features are people using?

### Common breakpoints

{{ figure_markup(
  image="breakpoints.png",
  caption="The most popular breakpoints by `min-width` and `max-width` as a percent of mobile pages.",
  description="The most popular breakpoints by `min-width` and `max-width` as a percent of mobile pages. 480px is used as a min-width on 21% of mobile pages and as a max-width on 35%. 600px on 27% and 37% for min and max widths respectively, 767px on 8% and 50%, 768px on 54% and 35%, 800px on 8% and 24%, 991px on 3% and 30%, 992px on 37% and 11%, 1024px on 13% and 23%, 1199px on just 31% as a max-width, and 1200px on 40% and 19%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=502128948&format=interactive",
  sheets_gid="1070028321",
  sql_file="media_query_values.sql"
) }}

{{ figure_markup(
  image="media-query-properties.png",
  caption="The most popular properties used in media queries as a percent of pages.",
  description="Bar chart of the most popular properties used in media queries as a percent of pages. Desktop and mobile are very similar. The percent of mobile pages ranges from 79% to 71% for display, width, margin-left, padding, font-size, height, margin, margin-right, margin-top, and position, in that order.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1199544976&format=interactive",
  sheets_gid="190367365",
  sql_file="media_query_properties.sql"
) }}

### Properties used inside media queries

## Custom properties

### Naming

{{ figure_markup(
  image="custom-property-names.png",
  caption="Relative popularity of custom property names per software entity as a perecent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of custom property names per software entity responsible for creating those properties, as a percent of occurrences on mobile pages. 35% of occurrences of custom property names on mobile pages can be traced back to Avada, 31% to Bootstrap, 16% to Elementor, 13% to WordPress, and 3% to an old version of Multirange.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1627287194&format=interactive",
  sheets_gid="1043074687",
  sql_file="custom_property_names.sql"
) }}

### Usage by type

{{ figure_markup(
  image="custom-property-properties.png",
  caption="The most popular property names used with custom properties as a percent of pages.",
  description="Bar chart of the most popular property names used with custom properties, as a percent of pages. Mobile adoption is much higher for each property than their desktop counterparts. Custom properties are used on background-color and color on 19% and 15% of mobile pages respectively. The remaining properties use custom properties from 9% to 6% in descending order: border, background, border-top, border-bottom, background-image, box-shadow, height, width, border-left, min-height, margin-top, border-right, and border-left-color. Desktop adoption is about 4 percentage points smaller.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=16420165&format=interactive",
  sheets_gid="556945658",
  sql_file="custom_property_properties.sql"
) }}

{{ figure_markup(
  image="custom-property-functions.png",
  caption="The most popular function names used with custom properties as a percent of pages.",
  description="Bar chart of the most popular function names used with custom properties, as a percent of pages. Mobile adoption is much higher for the first six functions: calc (7%), linear-gradient, rgba (4%), radial-gradient, hsla, and drop-shadow. The following functions have 1% adoption on desktop and mobile pages: -o-linear-gradient, translate, and -webkit-linear-gradient. And finally these functions have approximately 0% adoption on desktop and mobile pages: scale, -webkit-gradient, max, to, from, and rotate.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1986770560&format=interactive",
  width="600",
  height="525",
  sheets_gid="2076074923",
  sql_file="custom_property_functions.sql"
) }}

### Complexity

{{ figure_markup(
  image="custom-property-depth.png",
  caption="Distribution of depths of custom properties as a percent of occurrences.",
  description="Bar chart of the distribution of depths of custom properties as a percent of occurrences. Custom properties on desktop and mobile page have a depth of 0 for 67% and 60% of occurrences, respectively. For a depth of 1 it is 31% and 38%. At a depth of 2, just 2% each. Approximately 0% of occurrences have a depth of 3 or more.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=262191540&format=interactive",
  sheets_gid="1368222498",
  sql_file="custom_property_depth.sql"
) }}

## CSS and JS

### Houdini

### CSS-in-JS

{{ figure_markup(
  image="css-in-js.png",
  caption="Relative popularity of CSS-in-JS libraries as a percent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of CSS-in-JS libraries as a percent of occurences on mobile pages. Styled Components makes up 42% of occurrences on mobile pages, followed by Emotion at 30%, Aphrodite at 9%, React JSS at 8%, Glamor at 7%, Styled Jsx at 2%, and the rest having less than 1% of occurences: Radium, React Native for Web, Goober, Merge Styles, Styletron, and Fela.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=969014374&format=interactive",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
) }}

## Internationalization

### Direction

### Logical vs physical properties

## Browser support

### Vendor prefixes

{{ figure_markup(
  image="vendor-prefix-features.png",
  caption="The most popular vendor-prefixed features by type as a percent of pages.",
  description="Bar chart of the most popular vendor-prefixed features by type as a percent of pages. Desktop and mobile are very similar. 91% of mobile pages use vendor-prefixed properties, 77% use keywords and pseudo-elements, 65% use functions, 61% use pseudo-classes, and 52% use media.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1057411197&format=interactive",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

{{ figure_markup(
  caption="Percent of mobile pages using any vendor prefixed feature.",
  content="91.05%",
  classes="big-number",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

{{ figure_markup(
  image="vendor-prefix-properties.png",
  caption="Relative popularity of properties that are most used with vendor prefixes, as a percent of occurrences.",
  description="Bar chart of the relative popularity of properties that are most used with vendor prefixes, as a percent of occurrences. Desktop and mobile have similar results. The transform property makes up 19% of vendor prefix usage, followed by 12% transition, 9% border-radius, 8% box-shadow, 5% user-select and box-sizing, 4% animation, 3% filter, 2% each of font-smoothing, backface-visibility, appearance, and flex, and 1% usage for the remaining properties: transform-origin, osx-font-smoothing, animation-name, background-size, transition-property, and tap-highlight-color.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=859599479&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

{{ figure_markup(
  image="top-vendor-prefixes.png",
  caption="Relative popularity of vendor prefixes, as a percent of occurrences.",
  description="Bar chart of the relative popularity of vendor prefixes, as a percent of occurrences. -webkit makes up 49% of vendor prefix usage on mobile pages, -moz 23%, -ms 19%, -o 8%, -khtml 1%, and 0% for -pie, -js, and -ie. Desktop is similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=702800205&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

{{ figure_markup(
  image="vendor-prefix-pseudo-classes.png",
  caption="The most popular vendor-prefixed pseudo-classes as a percent of pages.",
  description="Bar chart of the most popular vendor-prefixed pseudo-classes as a percent of pages. :ms-input-placeholder is used on 10% of mobile pages, :-moz-placeholder 8%, :-mox-focusring 2%, and 1% or less for the following: :-webkit-full-screen, :-moz-full-screen, :-moz-any-link, :-webkit-autofill, :-o-prefocus, :-ms-fullscreen, :-ms-input-placeholde [sic], :-ms-lang, :-moz-ui-invalid, :-webkit-input-placeholder, :-moz-input-placeholder, and :-webkit-any-link.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1884876858&format=interactive",
  sheets_gid="67014375",
  width="600",
  height="650",
  sql_file="vendor_prefix_pseudo_classes.sql"
) }}

{{ figure_markup(
  image="vendor-prefix-pseudo-elements.png",
  caption="Relative popularity of vendor-prefixed pseudo-elements by purpose as a percent of occurrences.",
  description="Bar chart of the relative popularity of vendor-prefixed pseudo-elements by their purpose as a percent of occurrences. placeholder is used in 29% of prefixed occurrences, focus ring 21%, scrollbar 11%, search input 10%, media controls 8%, spinner 7%, other, selection, slider, clear button all at 3%, progress bar 2%, file upload 1%, and the remainder all at approximately 0% relative popularity on mobile pages: date picker, validation, meter, details marker, and resizer.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013685965&format=interactive",
  sheets_gid="1466863581",
  width="600",
  height="566",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

{{ figure_markup(
  image="top-pseudo-element-prefixes.png",
  caption="Relative popularity of pseudo-element vendor prefixes as a percent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of pseudo-element vendor prefixes as a percent of occurrences on mobile pages. -webkit makes up 47% of pseudo-element vendor prefix usage, followed by, 26% -moz, 15% -ms, 7% -o, and 6% other.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=744523431&format=interactive",
  sheets_gid="1466863581",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

{{ figure_markup(
  caption="Percent of occurrences of vendor-prefixed functions on mobile pages that specify gradients.",
  content="98.22%",
  classes="big-number",
  sheets_gid="1586213539",
  sql_file="vendor_prefix_functions.sql"
) }}

{{ figure_markup(
  image="vendor-prefixed-media.png",
  caption="Relative popularity of vendor-prefixed media features as a percent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of vendor-prefixed media features as a percent of occurrences on mobile pages. min-device-pixel-ratio and high-contrast each make up 47% of occurrences, transform-3d at 5%, and the remaining features less than 1% are device-pixel-ratio, max-device-pixel-ratio, and other features",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1940027848&format=interactive",
  sheets_gid="1192245087",
  sql_file="vendor_prefix_media.sql"
) }}

### Feature queries

{{ figure_markup(
  image="supports-criteria.png",
  caption="Relative popularity of `@supports` features queried as a percent of occurrences.",
  description="Bar chart of the relative popularity of @supports features queried as a percent of occurrences. The most popular feature queried is sticky at 49% of occurrences on mobile pages, followed by ime-align at 24%, mask-image at 12%, overflow-scrolling at 5%, grid at 2%, custom properties, transform-style, max(), and object-fit all at 1%, and appearance at approximately 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1901533222&format=interactive",
  sheets_gid="1155233487",
  sql_file="supports_criteria.sql"
) }}

## Meta

### Declaration repetition

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Unique / Total</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">30.97%</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">45.43%</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">63.67%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>
    {{ figure_link(
      caption="Distribution of repetition ratios on mobile pages.",
      sheets_gid="2124098640",
      sql_file="repetition.sql"
    ) }}
  </figcaption>
</figure>

### Shorthands and longhands

#### Shorthands before longhands

{{ figure_markup(
  image="most-popular-longhand-after-shorthand.png",
  caption="Most popular longhand properties after shorthands.",
  description="Bar chart showing `background-size` at 15% for desktop and 41% for mobile, `background-image` at 8% and 6% respectively, `margin-bottom` at 6% and 4%, `margin-top` at 6% and 4%, `border-bottom-color` at 5% and 3%, `font-size` at 4% and 3%, `border-top-color` at 4% and 3%, `background-color` at 4% and 2%, `padding-left` at 3% and 2%, and finally `margin-left` at 3% and 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=176504610&format=interactive",
  sheets_gid="17890636",
  sql_file="meta_shorthand_first_properties.sql",
  width="600",
  height="429"
) }}

{{ figure_markup(
  image="background-shorthand-versus-longhand.png",
  caption="TODO.",
  description="Bar chart showing `background` is 91% on desktop and 92% on mobile, `background-color` is 91% and 92% respectively, `background-image` is 85% and 87%, `background-position` is 84% and 85%, `background-repeat` is 82% and 84%, `background-size` is 77% and 79%, `background-clip` is 48% and 53%, `background-attachment` is 37% and 38%, `background-origin` is 5% on desktop and 12% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2014923335&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="429"
) }}

#### font

#### background

#### Margins and paddings

{{ figure_markup(
  image="margin-padding-shorthand-vs-longhand.png",
  caption="Usage of margin/padding shorthands vs longhands.",
  description="Bar chart showing `padding` is 93% on desktop, 94% on mobile, `margin` is 93% and 93% respectively, `margin-left` is 91% and 92%, `margin-top` is 90% and 91%, `margin-right` is 90% and 91%, `margin-bottom`si 90% and 91%, `padding-left` is 90% and 90%, `padding-top` is 88% and 89%, `padding-bottom` is 88% and 89%, and `padding-right` is 87% and 88%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=804317202&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Flex

{{ figure_markup(
  image="flex-shorthand-vs-longhand.png",
  caption="Usage of flex shorthands vs longhands.",
  description="Bar chart showing `flex-direction` is 55% on desktop and 60% on mobile, `flex-wrap` is 55% and 58% respectively,`flex` is 52% and 56%, `flex-grow` is 44% and 52%,`flex-basis` is 40% and 44%,`flex-shrink` is 28% and 37%, `flex-flow` is 27% and 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=930720666&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Grid

{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="Usage of grid, grid-* properties.",
  description="Bar chart showing `grid-template-columns` is 27% on desktop and 26% on mobile, `grid-template-rows` is 24% and 24% respectively, `grid-column` is 20% and 20%, `grid-row` is 20% and 19%, `grid-area` is 6% and 6%, `grid-template-areas` is 6% and 6%, `grid-gap` is 4% and 5%, `grid-column-gap` is 4% and 3%, `grid-row-gap` is 3% and 3%, `grid-column-end` is 3% and 2%, `grid-column-start` is 3% and 2%, `grid-row-start` is 3% and 2%, `grid-row-end` is 2% and 2%, `grid-auto-columns` is 2% and 2%, `grid-auto-rows` is 1% and 1%, `grid-auto-flow` is 1% and 1%, `grid-template` is 0% and 0%, `grid` is 0% and 0%, `grid-column-span` is 0% and 0%, `grid-columns` is 0% and 0%, and `grid-rows` is 0% and 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=290183398&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="575"
) }}

### CSS mistakes

#### Syntax errors

#### Nonexistent properties

{{ figure_markup(
  image="most-popupular-unknown-properties.png",
  caption="Most popular unknown properties.",
  description="Bar chart showing `webkit-transition` is 15% on desktop and 14% on mobile, `font-smoothing` is 13% and 12% respectively, `user-drag` is 12% on mobile, `white-wpace` is 10% on mobile, `tap-highlight-color` is 10% and 10%, `webkit-box-shadow` is 4% and 4%, `ms-transform` is 2% and 2%, `-transition` is 1% and 1%, `font-rendering` is 0% and 0%, `webkit-border-radius` is 2% on desktop, and `moz-border-radius` is 2% on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1166982997&format=interactive",
  sheets_gid="84286607",
  sql_file="meta_unknown_properties.sql",
  width="600",
  height="401"
) }}

#### Longhands before shorthands

{{ figure_markup(
  image="most-popupular-shorthands-after-longhands.png",
  caption="Most popular shorthands after longhands.",
  description="Bar chart showing `background` is 56.46% of desktop and 55.17% of mobile, `margin` is 12.51% and 12.18% respectively, `font` is 10.15% and 10.31%, `padding` is 8.36% and 7.87%, `border-radius` is 1.08% and 3.14%, `animation` is 3.18% and 3.05%, `list-style` is 2.09% and 2.00%, and `transition` is 1.09% and 0.98%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1389278729&format=interactive",
  sheets_gid="1143644053",
  sql_file="meta_longhand_first_properties.sql"
) }}

## Sass

{{ figure_markup(
  image="most-popupular-sass-function-calls.png",
  caption="Most popular Sass function calls.",
  description="Bar chart showing `(other)` is used on 23% on desktop and 23% on mobile, `darken` is 17% and 18% respectively, `if` is 14% and 14%, `map-keys` is 8% and 9%, `percentage` is 8% and 8%, `map-get` is 8% and 7%, `lighten` is 5% and 6%, `nth` is 5% and 5%, `mix` is 4% and 4%, `length` is 3% and 3%, `type-of` is 2% and 2%, and `(alpha adjustment)` 2% on desktop and 2% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=774248494&format=interactive",
  sheets_gid="170555219",
  sql_file="sass_function_calls.sql"
) }}

{{ figure_markup(
  image="usage-of-control-flow-statements-scss.png",
  caption="Usage of control flow statements in SCSS.",
  description="Bar chart showing `@if` is used on 63% of desktop and 63% of mobile, `@for` is 55% and 55% respectively, `@each` is 54% and 55%, and `@while` is 2% and 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=157473209&format=interactive",
  sheets_gid="498478750",
  sql_file="sass_control_flow_statements.sql"
) }}

{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="usage-of-explicit-nesting-in-scss.",
  description="Bar chart showing `Total` is used by 85% on desktop and 85% on mobile, `&:pseudo-class` is 83% and 83% respectively, `&.class` is 80% and 80%, `&::pseudo-element` is 66% and 66%, `& (by itself)` is 62% and 62%, `&[attr]` is 57% and 57%, `& >`	24% and 23%, `& +`	21% and 20%, `& descendant` is 16% and 15%, and `&#id` is 6% on desktop and 6% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=370242263&format=interactive",
  sheets_gid="1872903377",
  sql_file="sass_nesting.sql"
) }}

## Conclusion
