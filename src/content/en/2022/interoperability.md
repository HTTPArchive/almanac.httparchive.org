---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Interoperability
description: Interoperability chapter of the 2022 Web Almanac covering Compat 2021 (Gird and Flexbox) and Interop 2022 (Forms, Scrolling, Typography and encodings, dialog, containment, subgrid, color spaces, viewport units and cascade layers)
authors: [bkardell]
reviewers: [meyerweb, foolip]
analysts: [rviscomi, kevinfarrugia]
editors: [tunetheweb]
translators: []
bkardell_bio: Brian Kardell is a developer advocate and W3C Advisory Committee Representative at <a hreflang="en" href="https://igalia.com">Igalia</a>, a standards contributor, <a hreflang="en" href="https://bkardell.com">blogger</a>. He was a founder of the Extensible Web Community Group and co-author of <a hreflang="en" href="https://extensiblewebmanifesto.org">The Extensible Web Manifesto</a>.
results: https://docs.google.com/spreadsheets/d/1w3GzzTNeKxafFODmjDs6OC2dseNEDDKwUV8KeSgRI1Y/
featured_quote: Interoperability is a key goal of standards, but we've sometimes fallen short.  This chapter will begin providing an annual update to developers about efforts to come together to improve things. It will cover what's new or improved in terms of interoperability this year, and will provide a means for implementers to measure the impacts over time.
featured_stat_1: 309%
featured_stat_label_1: The increase in sites using CSS `aspect-ratio` between April 2021 and September 2022
featured_stat_2: 0.3%
featured_stat_label_2: The percentage of sites using the newly interoperable `dialog` element as of September 2022
featured_stat_3: 4%
featured_stat_label_3: Mobile pages using recently interoperable CSS `containment`. This support is critical for Container Queries.
---

## Introduction

In 2019, the Mozilla Developer Network's (MDN) Product Advisory Board put together a significant survey of over 28,000 developers and designers from 173 countries. Findings from this were published as the first <a hreflang="en" href="https://insights.developer.mozilla.org/reports/pdf/MDN-Web-DNA-Report-2019.pdf">Web Developer Needs Assessment</a> (Web DNA). This study identified—among other things—that some of the key frustrations and pain points most often involved differences between browsers. In 2020 this led to a followup known as the <a hreflang="en" href="https://insights.developer.mozilla.org/reports/mdn-browser-compatibility-report-2020.html">MDN Browser Compatibility Report</a>.

Historically, implementer priorities and focus are independently managed. However, given this new data, browser manufactures came together for another first-of-its-kind effort called <a hreflang="en" href="https://web.dev/compat2021/">_Compat 2021_</a>, which identified 5 specific areas of joint focus toward alignment across thousands of Web Platform Tests. At the beginning of Compat 2021, all engines scored only 65-70% compatibility in the five areas in stable, shipping browsers. Today, all of them are over 90%. In 2022, this effort was expanded—and renamed—to <a hreflang="en" href="https://hacks.mozilla.org/2022/03/interop-2022/">_Interop 2022_</a>.

Both of these efforts offer some different things for this chapter to look at. It's been nearly a year since most improvements from Compat 2021 shipped, and while many things in Interop 2022 are already deployed in shipping browsers, there is more to come before the end of the year.

An interesting question in these efforts is "how do we know that we did well (or didn't)?" Seeing significant score improvements is useful, but insufficient without developer adoption. So, this year for the first time, the Web Almanac will also include a new Interoperability chapter to begin wrestling with these questions and provide some central information to developers about what's changed, and what's worth another look.

This chapter will summarize the work done in Compat 2021 and measure what we can, as well as look into what's happening in Interop 2022 and consider whether there are also potentially valuable metrics we can track over time. Both of these efforts contain a wide mix of cases from stable, already useful features with varying degrees of incompatibility or frustration to brand new things we tried to set off right from the start.

## Compat 2021

Compat 2021 had 5 major focus areas

- Grid
- Flexbox
- Sticky Position
- Transforms
- Aspect Ratio

In January 2021, all stable/shipping browsers scored 65-70% compatibility in these areas, and it wasn't necessarily the same 30-35% of tests that were failing in each browser.

{{ figure_markup(
  image="compat-2021-dashboard.png",
  caption='Compat 2021 dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/compat2021">Web Platform Tests</a>)',
  description="A recent screenshot from Compat 2021 dashboard showing the improvement in interoperability in real, shipping, stable browsers: Chrome/Edge 96%, Firefox 91%, Safari 94%.",
  width=780,
  height=801
  )
}}

Today, you can see that significant levels of improvement have been made. Chrome and Edge are at 96%, Firefox at 91%, and Safari at 94%.

### Grid

CSS Grid is one of the most popular features in many years. [The HTTP Archive data](./css#flexbox-and-grid-adoption) shows year over year doubling of adoption since its arrival, with a slight slowdown this year—only increasing half-again instead of doubling. Grid already had quite a high degree of interoperability, but there were still a number of minor differences in support. Work was done throughout 2021 and 2022 to improve alignment of the over 900 tests in Web Platform Tests that test features of Grid. If you've had past headaches trying to do something in Grid, give it another try—the situation may have changed for the better.

A good example of this is the ability to animate grid tracks—grid rows and columns—which as of mid-2022 was only supported by Firefox. However, as this chapter was being written, grid-track animation was added to both <a hreflang="en" href="https://webkit.org/blog/13152/webkit-features-in-safari-16-0/">WebKit</a> and <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/Ll7br0giMk8/m/l4WNHdatBQAJ">Chromium</a>, meaning all three major engines should be animating grid tracks by the time you read this.

### Flexbox

Flexbox is even older and more widely used. This year its use has grown again, [now appearing on 75% of mobile pages and 76% of desktop pages](./css#flexbox-and-grid-adoption). It has a similar number of tests to Grid and despite very wide adoption started in much worse shape. Entering 2021, we had a combination of ragged bugs and sub-features that remained under-implemented.  For example, [positional-alignment keyword values](https://developer.mozilla.org/docs/Web/CSS/CSS_Box_Alignment#positional_alignment_keyword_values) (which can be applied to justify-content and align-content and also to justify-self and align-self) had ragged support and several interoperability issues. For absolute positioned flex items this was even worse. These issues have been resolved.

{{ figure_markup(
  caption="Desktop pages using `flex-basis: content` in their stylesheets.",
  content="112,323",
  classes="big-number",
  sheets_gid="1354091711",
  sql_file="flex_basis_content.sql"
)
}}

Another bit of focus was toward `flex-basis: content`, which is used to automatically size based on the flex item's content.  This was initially implemented in Firefox, but implementations in WebKit and Chromium were underway in 2021. Today these tests pass uniformly in all browsers and `flex-basis: content` appears on 112,323 pages on desktop and 75,565 mobile, roughly 1% of pages. That's not a bad start for a feature in its first year of universal support and about double what it was last year. We'll keep an eye on this metric in the future.

### Sticky positioning

{{ figure_markup(
  caption="Desktop pages using `position: sticky` in their stylesheets.",
  content="5.5%",
  classes="big-number",
  sheets_gid="712845051",
  sql_file="position_sticky.sql"
)
}}

Sticky positioning has been around for a while. In fact, it's worth noting that it is the [most popular feature query in used by a large margin](../2022/css#feature-queries), accounting for over 50% of feature queries. It had several interoperability issues; for example, the inability to stick headers in tables in Chrome. `position: sticky` is actively used in around 5% of desktop pages and 4% of mobile pages in 2022. We'll keep an eye on this metric for some time to come to see how addressing those interoperability issues affects adoption over time.


### CSS transforms

{{ figure_markup(
  image="css-transforms-wpt-dashboard-stable.png",
  caption='CSS Transforms Web Page Tests dashboard (stable).<br>(Source: <a hreflang="en" href="https://wpt.fyi/compat2021?feature=css-transforms&stable">Web Platform Tests</a>)',
  description="Compat 2021 graph showing css-transforms improving by 20-30% in all stable browsers between then and now.",
  width=720,
  height=479
  )
}}

CSS Transforms are popular and have been around for a long time. However, there were many interoperability issues at the start, particularly around `perspective:none` and `transform-style: preserve-3d`. This meant that many animations were<a hreflang="en" href="https://web.dev/compat2021/#css-transforms"> annoyingly inconsistent</a>.

{{ figure_markup(
  image="css-transforms-wpt-dashboard-experimental.png",
  caption='CSS Transforms Web Page Tests dashboard (experimental).<br>(Source: <a hreflang="en" href="https://wpt.fyi/compat2021?feature=css-transforms">Web Platform Tests</a>)',
  description="Compat 2021 graph showing the same CSS transforms in experimental browsers, in which all browsers are scoring 90% or better.",
  width=720,
  height=479
  )
}}

A recent compat 2021 graph showing the same CSS transforms in experimental browsers as above shows all browsers are scoring 90% or better in their experimental versions, which show future versions of the browsers. This was one of the areas with big, visible improvements in stable browsers, which continue to improve, as part of Interop 2022 involves continuing Compat 2021 work.

### `aspect-ratio`

`aspect-ratio` was a new feature developed in 2021. Given its potential widespread usefulness, we chose to aim for high interoperability from the start.

{{ figure_markup(
  image="aspect-ratio-usage.png",
  caption='Aspect-ratio usage over time.<br>(Source: <a hreflang="en" href="https://chromestatus.com/metrics/css/timeline/popularity/657">Chrome Status</a>)',
  description="A chart showing steady adoption over time of aspect-ratio containing rules over the last year and a half or so, going from 0.11% on desktop and 0.24% on mobile to 1.44% on desktop and 1.55% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=921119661&format=interactive",
  sheets_gid="1987465082"
) }}

In 2022, `aspect-ratio` is already appearing in the [CSS of 2% of URLs in the archive crawl](./css#the-aspect-ratio-property). Note that doesn't mean that 2% of these pages are using `aspect-ratio` themselves: rules may be loaded for use in other pages on the site. Which rules are applied in those pages is a different question, and it shows a more modest 1.55% of page views on desktop and 1.44% on mobile. Still, the growth chart shows steady and increasing adoption. This will be an interesting metric to track as we move forward.

## Interop 2022

Like the _Compat_ effort before it, the renamed _Interop_ effort focuses on a mix of things from collections of bugs to landing good, final implementations to relatively new but quickly shipping features we'd like to set off in good standing. Let's start with the bugs…

### Bugs

In many cases, we have otherwise mature features with ragged bugs reported in different browsers. Ragged bugs mean that the authoring experience is potentially a lot worse than individual pass rates might imply. For example, if all browsers report a pass rate on a series of tests of 70%, but all browsers fail on a different 30%, interoperability in practice would be quite low. A significant portion of our focus in Interop 2022 is around aligning implementations and closing bugs on features like these.

#### Forms

For most of the web's history, forms have played a pretty important role. In 2022, <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit#gid=2057119066">over 69% of desktop pages include a `<form>` element</a>. They've had a lot of investment, but despite that, they're still the source of a lot of browser bugs as developers find cases where things differ from the specs, or differ from other implementations in sometimes subtle ways. We identified <a hreflang="en" href="https://wpt.fyi/results/?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-forms">a set of 200 tests</a> in which the pass rate was very ragged. Individual scores ranged from ~62% (Safari) to ~91% (Chrome), but again, each browser had different gaps in support.

We have made some pretty radical progress toward closing these gaps in experimental releases, and we hope that as we close out the year these will land in stable browsers. There is probably little that can be tracked here using the HTTP Archive data in terms of use, or adoption, but hopefully developers experience less pain and frustration and require fewer workarounds for individual browsers.

{{ figure_markup(
  image="forms-wpt-dashboard.png",
  caption='Forms WPT dashboard (experimental).<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-forms&stable">Web Platform Tests</a>)',
  description="A chart showing the improvement in forms interoperability over the course of 2022 in all browsers—very significant for Safari. All browsers are now scoring between ~92-99%.",
  width=732,
  height=696
  )
}}

#### Scrolling

Over the years we've added new patterns and developed new abilities around scroll experiences like `scroll-snap`, `scroll-behavior`, and `overscroll-behavior`. The desire for these sorts of powers are clear—in 2022, the number of CSS stylesheets including some of these key properties looked like this:

{{ figure_markup(
  image="scroll-property-adoption.png",
  caption='Scroll property adoption.',
  description="A chart scroll property adoption on desktop and mobile. `scroll-snap-type` is used on 7.8% of desktop pages and 7.9% of mobile pages, `scroll-behavior` is used on 7.2% of desktop pages and 6.9% of mobile pages, and finally `overscroll-behavior` is used on 2.4% of desktop pages and 3.0% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=1940734631&format=interactive",
  sheets_gid="1538908642",
  sql_file="../css/all_properties.sql"
) }}

Unfortunately, this is an area where a number of incompatibilities remain, and dealing with incompatibilities in scrolling causes developers a lot of pain. We identified <a hreflang="en" href="https://wpt.fyi/results/css?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-scrolling">106 Web Platform Tests</a> around scrolling. At the beginning of the process, stable-release scores ranged from ~70% (Firefox and Safari) to about 88% (Chrome). Again, keep in mind that these are overall scores—because the gaps differed, the real "interoperability" intersection was lower than any of these.

{{ figure_markup(
  image="scrolling-wpt-dashboard.png",
  caption='Scolling WPT dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-scrolling&stable">Web Platform Tests</a>)',
  description="A recent chart showing improvements in experimental browsers showing significant gains and alignment, particularly in Firefox which went from about 71% to over 86%.",
  width=718,
  height=683
  )
}}

It is very difficult to estimate what effect these improvements will have on adoption over time, but we'll keep an eye on these metrics. In the meantime, if you've experienced some interoperability pains with scrolling features, you might give them another look. We hope that as these improvements continue and reach stable browser releases, the experience will get a lot better.

#### Typography and Encodings

Rendering of text is sort of the web's forte. Like forms, many basic ideas have been around forever, but there remain a number of gaps and inconsistencies around support for typography and encodings.

Interop 2022 took up a general bag of issues around `font-variant-alternates`, `font-variant-position`, the `ic` unit, and CJK text encodings. We identified <a hreflang="en" href="https://wpt.fyi/results/?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-text">114 tests in Web Platform Tests</a> representing different sorts of gaps.

{{ figure_markup(
  image="typography-and-encodings-wpt-dashboard.png",
  caption='Typography and encodings WPT dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-text&stable">Web Platform Tests</a>)',
  description="A chart showing the interoperability scores for typography and encodings over the past year. Chrome began at about 70%, Safari at about 79% and Firefox at about 98%. Chrome has pretty much closed the ground between itself and Safari, but the chart is otherwise 3 straight lines with no change.",
  width=727,
  height=688
  )
}}

Chrome has recently begun to close gaps with Safari, but both Safari and WebKit still require some attention to catch up to the completeness of Firefox in this area.

### Completing Implementations

Aligning implementations is particularly difficult. There is a delicate balance between the need for experimentation and initial implementation experience and having enough agreement to ensure that the work is well understood and very likely to reach the status of shipping implementation in all browsers. Sometimes this alignment can take years. This year we've focused on three items which had an implementation and at least some agreement that it's ready: The `<dialog>` element, CSS Containment, and Subgrid. Let's look at each.

#### `<dialog>`

A dialog element was first shipped in Chrome 37 in August 2014. Introducing a dialog requires introducing and defining a number of supporting concepts like "top-layer" and "inertness." It also requires answering many new accessibility and UX questions.

A number of things caused work on dialogs to stall for a long time, but over the years it's picked back up. It landed in Firefox Nightly 53 behind a flag in April 2017. Since then, a lot of work has gone into answering all of those questions. Final details were sorted out and work was prioritized as part of Interop 2022 to ensure good interoperability to start with. We identified 88 Tests. It was shipped by default in stable browsers in both [Firefox 98](https://developer.mozilla.org/docs/Mozilla/Firefox/Releases/98) and <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-15_4-release-notes">Safari 15.4</a> in March 2022, with all browsers scoring ~93% or better.

{{ figure_markup(
  image="dialog-element-wpt-dashboard.png",
  caption='Dialog element WPT dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-dialog&stable">Web Platform Tests</a>)',
  description="A chart showing the interoperability scores for dialog over the past year. Firefox and Safari began at about 80%, with Chrome a little higher on 87%. All have made steady improvements with Chrome/Edge ending on 99.4%, Safari on 97.5% and Firefox on 92.8%.",
  width=720,
  height=685
  )
}}

It's hard to predict how many of the pages the archive crawls will require a `<dialog>`, but tracking its growth will be informative and interesting. Last year, only one shipping browser supported `<dialog>`, and it appeared on ~0.101% of pages in the mobile data set. At the time of the crawl we used for this chapter, it had been shipping universally for about 5 months and <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit#gid=2057119066">we found it appearing in ~0.148%</a>. Still small numbers, but that's ~146% of what it was this time last year. We will continue to track this metric next year. In the meantime, if you have a need for a `<dialog>` there's good news: It's now universally available for use!

#### CSS containment

CSS containment introduces a concept for isolating a subtree of the page from the rest of the page in terms of how CSS should process and render it. It was introduced as a primitive which could be used to improve performance, and to open the door for figuring out [Container Queries](https://developer.mozilla.org/docs/Web/CSS/CSS_Container_Queries).

{{ figure_markup(
  image="containment-wpt-dashboard.png",
  caption='Containment WPT dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-contain&stable">Web Platform Tests</a>)',
  description="A chart showing the interoperability scores for containment over the past year. Safari started quite low at about 30% but shot up to 88% early on and steadily increased to 99%. Chrome/Edge and Firefox all started much higher (84% and 95% respectively) but have also improved to 99%",
  width=709,
  height=675
  )
}}

It first shipped in Chrome stable in July 2016. Firefox shipped the second implementation in September 2019. This year it was taken up by Interop 2022 to align and ensure that as it becomes universally available, we start out in good shape. We identified <a hreflang="en" href="https://wpt.fyi/results/css/css-contain?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-contain">235 tests</a>. <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-15_4-release-notes">Safari shipped containment support in stable release 15.4</a> in March 2022. Throughout the year, each browser improved support, and it is now universally available.

{{ figure_markup(
  caption="Number of mobile pages using containment in their stylesheets.",
  content="3.7%",
  classes="big-number",
  sheets_gid="1436876723",
  sql_file="contain.sql"
)
}}

In the 2022 data, containment appears in stylesheets on 3.7% of pages on mobile and 3.1% of pages on desktop.


{{ figure_markup(
  image="contain-property-usage.png",
  caption="`contain` property usage.",
  description="A bar chart showing `layout` is 27% of `contain` values on desktop pages and 34% on mobile pages, `strict` is 24% and 19%, `content` is 12% and 11%, `paint` is 12% and 9%, `none` is 7% and 8%, `style layout paint` is 10% and 8%, `layout style` is 2% and 4%, `style` is 1% and 3%, `layout size style` is 1% and 1%, `style size layout` is 2% and 1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=932967645&format=interactive",
  sheets_gid="1251142331",
  sql_file="contain_values.sql",
  width=600,
  height=489
) }}

The figure above shows the relative appearance of values in those pages—`layout` containment being far and away the most popular usage, accounting for 34% of `contain` values.

While it is useful on its own, additional levels of containment support are a prerequisite to supporting container queries, so this will be an interesting metric to continue to track over time as container queries is the <a hreflang="en" href="https://2021.stateofcss.com/en-US/opinions/#currently_missing_from_css_wins">#1 most requested CSS feature</a> for many years. Now that containment is universally available, it's a great time for you to have a look and familiarize yourself with the basic concepts.

Note that some degree of container queries support is already available in Chrome and Safari and polyfills are available, so we also decided to look at how many stylesheets already contain a `@container` ruleset, wondering how much this would account for the use we saw above.

{{ figure_markup(
  caption="Percentage of mobile pages containing a `@container` ruleset.",
  content="0.002%",
  classes="big-number",
  sheets_gid="1772897513",
  sql_file="container.sql"
)
}}

Not much, yet it would seem! A mere 238 pages, out of the nearly 8 million pages we crawled in our mobile data set use container queries. Given that it is brand new and not yet completely shipping, this isn't surprising. It does give us a nice baseline to start tracking adoption from in the future though.

#### Subgrid

While CSS grid layout has allowed a container to express layout of its children in terms of rows, columns and tracks—there has always been something of a limit here. There is frequently a need for descendants that are not children to participate in the same grid layout. [Subgrid](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout/Subgrid) is the solution for problems like this. It was first supported in a stable release in Firefox in December 2019, but other implementations didn't immediately follow.

Coordinating work on this long awaited feature and ensuring good interoperability was another goal in Interop 2022. We marked <a hreflang="en" href="https://wpt.fyi/results/css/css-grid/subgrid?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-subgrid">51 Tests in Web Platform Tests</a>.

{{ figure_markup(
  image="subgrid-wpt-dashboard.png",
  caption='Subgrid WPT dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-subgrid&stable">Web Platform Tests</a>)',
  description="A chart showing the scores of subgrid in stable releases over the past year. Chrome started at has reached about 20%, Safari went from around 10% to around 98% and Firefox from about 81% to about 83%.",
  width=719,
  height=683
  )
}}

As of the time of this writing, there has been very good progress (Safari is now the most complete), and there are at least 2 implementations (Safari and Firefox) in stable shipping browsers. We hope to see rapid improvement in Chrome before the end of the year.

{{ figure_markup(
  caption="Percentage of mobile pages containing a use of `subgrid` in their stylesheet.",
  content="0.002%",
  classes="big-number",
  sheets_gid="519660506",
  sql_file="subgrid.sql"
)
}}

While this isn't fully available in all stable browsers yet the dataset did include some small amount of use already.

### New Features

This year, all of the new features that fall under the category of CSS, and most of the data about them, will be covered in the [CSS](./css) chapter. Here, we'll mainly focus on some highlights.

#### Color Spaces and Functions

Color on the web has always been full of fascinating challenges. Over the years, we've given authors many ways to express what are—in the end—the same [sRGB](https://en.wikipedia.org/wiki/SRGB) colors. That is, one can write as a color name (`red`). Simple enough.

However, we could also use its hex equivalent`(#FF0000)`. Humans don't generally think in hexadecimal, so we added the `rgb()` color function (`rgb(255,0,0)`). Note that both of those are just using two different, but equivalent, numbering systems. They are also about expressing things in terms of mixing the intensity of individual lights that were common in cathode ray tube displays.

The RGB method of constructing colors can be very hard for humans to visualize, so we developed other coordinate systems for expressing sRGB colors in a (perhaps?) easier to understand, like [`hsl(0, 100%, 50%)`](https://en.wikipedia.org/wiki/HSL_and_HSV)or [`hwb(0, 0%, 0%)`](https://en.wikipedia.org/wiki/HWB_color_model). However, again, these are sRGB coordinate systems.

{{ figure_markup(
  image="p3-color-space.jpg",
  caption="p3 color space compared to sRGB.",
  description="An illustrating showing that the p3 color space is a wider gammut than sRGB and capable of expressing more colors.",
  width=736,
  height=300
  )
}}

So, what happens when our display abilities exceed their limits? This is, in fact, the case today, as can be seen with wide gamut displays.

In Safari 10, released in 2017, Apple added support for P3 color images. The new `lab()` and `lch()` coordinate systems were added to CSS in order to support the full available gamut space, based on the [CIELAB model](https://en.wikipedia.org/wiki/CIELAB_color_space#Cylindrical_model). They are perceptually uniform, allowing us to express colors we could not previously (and defining what to do if support is lacking). Support for these first shipped in Safari 15 in September 2021.

The fuller gamut space and better perceptual uniformity of `lab()` and `lch()` also allow us to more easily focus on new color functions like `color-mix()`, which takes two colors and returns the result of mixing them in a specified color space by a specified amount.

Interop 2022 took up <a hreflang="en" href="https://wpt.fyi/results/css/css-color?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-color">189 tests</a> around these items with a goal of prioritizing good interoperability. Safari began pretty well out ahead and has only improved—both Firefox and Chrome have made steady improvements, but they're still quite a bit behind in this area. One challenge, inevitably, is that much lower-level support—<a hreflang="en" href="https://youtu.be/eHZVuHKWdd8?t=906">throughout the underlying graphics library, rendering pipeline, etc.</a>—is also built to deal in sRGB, so adding support is not easy.

{{ figure_markup(
  image="color-spaces-and-functions-wpt-dashboard.png",
  caption='Color spaces and functions WPT dashboard.<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-color&stable">Web Platform Tests</a>)',
  description=" chart showing the scores of Color spaces and functions in stable releases over the past year. Chrome/Edge and Firefox started around 50% and Firefox has only moderately improved, while Chrome/Edge has improved a bit more to nearly 65%. Safari started strong at just above 90% and moved up above 95%.",
  width=719,
  height=684
  )
}}

#### Viewport Units

In the 2020 MDN Browser Compatibility Report, <a hreflang="en" href="https://insights.developer.mozilla.org/reports/mdn-browser-compatibility-report-2020.html#findings-viewport">the ability to work with the reported size of the viewport with existing vh/vw units was a common theme</a>. As browsers experiment with different interface choices and websites have different design needs, the <a hreflang="en" href="https://drafts.csswg.org/css-values-4/#viewport-variants">CSS Working Group defined several new classes of viewport units</a> for measuring the largest (`lv*` units), smallest (`sv*` units) and dynamic (`dv*` units) viewport measures. All viewport related measures includes similar units:

- 1% of the width (`vw`, `lvw`, `svw`, `dvw`)
- 1% of the height (`vh`, `lvh`, `svh`, `dvh`)
- 1% of the size in the inline axis (`vi`, `lvi`, `svi`, `dvi`)
- 1% of the size of the initial containing block (`vb`, `lvb`, `svb`, `dvb`)
- The smaller of two dimensions (`vmin`, `lvmin`, `svmin`, `dvmin`)
- The larger of two dimensions (`vmax`, `lvmax`, `svmax`, `dvmax`)

{{ figure_markup(
  image="viewport-units-wpt-dashboard.png",
  caption='Viewport units WPT dashboard (experimental).<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-viewport">Web Platform Tests</a>)',
  description="A chart showing the scores of viewport units in experimental releases over the past year. In January, no engine supported them. Safari had an early jump, getting about 65% support in February, but was quickly surpassed by Chrome with about 87% support. As of September, all scored 100% pass rates.",
  width=732,
  height=697
  )
}}

Interop 2022 identified 7 tests to verify various aspects of those units. Safari shipped the first support for these units in March 2022, followed by Firefox at the end of May. As of the time of this writing it is supported in experimental builds of Chromium.

As of the time of this writing, the HTTP Archive hasn't turned up any use of these units in the wild yet, but it's very new. We'll continue to track adoption on this going forward.

#### Cascade Layers

Cascade Layers are an interesting new feature of CSS, built on a fundamental idea that has existed in CSS all along. As authors, our primary means of expressing the importance of rules has been specificity. This works well for a lot of things but it can quickly get unwieldy as we try to incorporate ideas for design systems or components. Browsers also use CSS internally in what is called the UA stylesheet. However, you might note that you don't typically have specificity related battles with the UA stylesheet. That's because there are "layers" of rules built right into how CSS works. Cascade Layers provides a way for authors to plug into that same mechanism and manage their CSS and specificity challenges more effectively. [Miriam Suzanne](https://x.com/TerribleMia) wrote <a hreflang="en" href="https://css-tricks.com/css-cascade-layers/">a fuller explanation and guide</a>.

{{ figure_markup(
  image="cascade-layers-wpt-dashboard.png",
  caption='Cascade layers WPT dashboard (experimental)..<br>(Source: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-cascade">Web Platform Tests</a>)',
  description="A chart showing the scores of cascade layers support in experimental releases over the past year. In January, Firefox had roughly 75% support, Safari 62% and Chrome only about 11%. Throughout the year each gained steadily. As of September both Firefox and Chrome have scores of about 96%, and Safari 100%.",
  width=720,
  height=675
  )
}}

To set this off well, Interop 2022 defined <a hreflang="en" href="https://wpt.fyi/results/css/css-cascade?label=experimental&label=master&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-cascade">31 tests in Web Platform Tests</a>. Support in stable browsers at the beginning of the year was non-existent, but since April it is now universally implemented among stable releases in the 3 engines. Here's what development looked like.

{{ figure_markup(
  caption="Percentage of mobile pages containing a `@layer` ruleset.",
  content="0.003%",
  classes="big-number",
  sheets_gid="474436360",
  sql_file="layer_adoption.sql"
)
}}

As of the time of the dataset for this year, layers occurred on a very small number of sites in the wild.

The largest number of layers defined was 6. Future editions of the Web Almanac will continue to track adoption and trends on Cascade Layers. Hopefully aligned work, close releases and early focus on good interoperability help it reach its potential and reduce any frustrations.

Given that it's shipping everywhere, now would be a great time to learn more about how Cascade Layers can help you wrangle control of your CSS.

## Conclusion

Interoperability is the goal of standards, and ultimately key to large scale adoption. However, in practice, reaching interoperability is the culmination of complex independent work, focus, budgeting and priorities. Historically this has occasionally been challenging with gaps of sometimes many years between implementations landing and then various incompatibilities. Browser vendors have heard this feedback and begun to put efforts toward increased focus on coordinated efforts to close existing gaps and to tighten the timeframe that it takes for new implementations to arrive with a very high degree of interoperability.

We hope that this review of the work that has been done this year serves to inform developers and prompt adoption of and attention to these features. We will continue to track those metrics that we can and look toward how we can use data to inform our sense of how we're doing and influence where and how we're focusing.
