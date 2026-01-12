---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Accessibility
description: Accessibility chapter of the 2025 Web Almanac covering ease of reading, navigation, forms, media, ARIA, and accessibility apps.
hero_alt: Hero image of a robot with a blue, human accessibility icon on its front scanning a web page, while Web Almanac characters check some labels.
authors: [tricinel, mgifford]
reviewers: [hidde, atierney, scottdavis99]
analysts: [mgifford, tunetheweb]
editors: [tricinel]
translators: []
tricinel_bio: Bogdan is the accessibility consultant who helps product owners ship accessible websites without blocking ongoing work. He brings over a decade of experience in education and healthcare, with deep expertise in inclusive design and web accessibility. He's been writing a <a hreflang="en" href="https://dailyaccessibility.com">daily newsletter</a> on accessibility since March 2024, driven by one core belief. "Make room for everyone."
mgifford_bio: Mike Gifford is CivicActions' Open Standards & Practices Lead. He is also a thought leader on open government, digital accessibility and sustainability. He has served as a Drupal Core Accessibility Maintainer and also a W3C Invited Expert. He is a recognized authoring tool accessibility expert and contributor to the W3C's Draft Web Sustainability Guidelines (WSG) 1.0.
results: https://docs.google.com/spreadsheets/d/13sY_wmYODArxo-hH5cSuRAbvtLdGI3x5Xc9qUyqP8as/
featured_quote: The web should work for everyone. Until that principle guides our decisions, accessibility gaps will persist.
featured_stat_1: 85
featured_stat_label_1: Median Lighthouse accessibility score.
featured_stat_2: 67%
featured_stat_label_2: Sites removing default focus outlines.
featured_stat_3: 2%
featured_stat_label_3: Sites using accessibility overlays.
---

## Introduction

The web is changing fast. In 2025, web accessibility matters more than ever as mainstream technologies increasingly rely on inclusive features. For example, voice-activated assistants use screen reader technologies. Features originally designed for accessibility, such as video captions and haptic feedback, are now common.

Universal Design principles are fundamentally important for our work in modern web development. We're increasingly creating solutions that address diverse needs and improve experiences for all users. As Sir Tim Berners-Lee famously said, "The power of the Web is in its universality. Access by everyone regardless of disability is an essential aspect."

Recent global events and shifting legal requirements have pushed digital inclusion into focus. <a hreflang="en" href="https://inclusive.microsoft.design/">Microsoft's Inclusive Design Guidelines</a> show that accessibility helps more than just people with permanent disabilities. The guidelines specifically mention temporary and situational limitations. For example, the ability to use a device with one hand can help individuals with injuries, parents with young children, as well as people carrying items.

In 2025, web accessibility laws have real teeth. The European Union's (EU) [European Accessibility Act (EAA)](https://en.wikipedia.org/wiki/European_Accessibility_Act) is a major step forward. It set a deadline of June 2025 for numerous websites and apps to conform to the [EN 301 549](https://en.wikipedia.org/wiki/EN_301_549) standard, which references the <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Web Content Accessibility Guidelines (WCAG)</a>.

The United States updated its regulations as well. State and local government sites must now meet <a hreflang="en" href="https://www.w3.org/TR/WCAG21/">WCAG 2.1</a>, as <a hreflang="en" href="https://www.ada.gov/resources/2024-03-08-web-rule/">required by Title II of the Americans with Disabilities Act</a>. The 2024 data gives us a critical baseline to measure the tangible impact of these deadlines on the accessibility of websites globally.

Google Lighthouse powers our analysis using <a hreflang="en" href="https://www.deque.com/axe/axe-core/">Deque's axe-core engine</a>. We benchmark 2025 findings against 2024 data and identify key trends. With broader adoption of WCAG 2.2, we examine the uptake of new Success Criteria and continued changes from deprecated rules such as `duplicate-id`.

Our approach is similar to that of the <a hreflang="en" href="https://webaim.org/projects/million/">WebAim Million</a> but with differences in sites crawled and analysis tools used. The HTTP Archive crawls 17 million sites each month across home and secondary pages using Lighthouse and other tools. WebAim surveys the <a hreflang="en" href="https://webaim.org/projects/million/#method">top million home pages</a> with <a hreflang="en" href="https://wave.webaim.org/">WAVE</a>.

Automated tests, including axe-core which is used by Lighthouse, can <a hreflang="en" href="https://html5accessibility.com/stuff/2025/03/24/a-tools-errand/#:~:text=automation%20blues">only partially check a subset of WCAG Success Criteria</a>. Alphagov from GOV.UK offers a <a hreflang="en" href="https://alphagov.github.io/accessibility-tool-audit/">comparison of popular automated audit tools</a> and they all detect less than 50% of accessibility errors. Many criteria lack automated tests altogether, and not all accessibility issues have matching criteria in WCAG.

But remember Goodhart's Law. When a metric becomes a target, it stops being a reliable metric. A perfect score doesn't guarantee full accessibility. You should treat Lighthouse accessibility scores as a starting point for evaluation rather than a final goal. Still, tracking these scores offers a valuable snapshot of the web's overall progress.

Our report focuses exclusively on HTML and doesn't include PDF or other office documents.

Compared to 2024, the median Lighthouse Accessibility score improved by 1%, reaching over 85% in 2025. Since the first Web Almanac in 2019, we've seen steady and incremental progress. <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/accessibility/scoring">Google Lighthouse assigns different weights</a> to axe-core issues, so <a hreflang="en" href="https://accessibility.civicactions.com/posts/prioritizing-accessibility-bugs-for-maximum-impact">organizations may prioritize fixes differently</a>.

{{ figure_markup(
  image="lighthouse-audit-improvements-yoy.png",
  caption="Lighthouse audit improvements year-over-year.",
  description="A bar chart showing the average increase in the media Google Lighthouse accessibility score over time for six years. Values increase slowly year by year, as follows: in 2019 83%, in 2020 80%, in 2021 82%, in 2022 83%, in 2024 84%, and in 2025 85%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1116937150&format=interactive",
  sheets_gid="1543303999",
  sql_file="lighthouse_a11y_score.sql"
  )
}}

This year, we've seen the biggest advances in the following axe-core tests:

- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-input-field-name">ARIA input fields must have an accessible name</a>: +3% over 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-meter-name">ARIA `meter` nodes must have an accessible name</a>: +15% over 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-progressbar-name">ARIA `progressbar` nodes must have an accessible name</a>: +5% over 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-tooltip-name">ARIA `tooltip` nodes must have an accessible name</a>: +13% over 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/meta-refresh">Avoid delayed refresh under 20 hours</a>: +1% over 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/object-alt">`<object>` elements must have alternate text</a>: +1% over 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/select-name">`<select>` element must have an accessible name</a>: +5% over 2024

{{ figure_markup(
  image="most-improved-lighthouse-accessibility-tests-axe.png",
  caption="Most improved Lighthouse accessibility tests (axe).",
  description="A series chart showing the improvements on seven specific Lighthouse checks over time for four years. For `aria-input-field-name`, in 2021 12%, in 2022 14%, in 2024 21%, and in 2025 24%. For `aria-meter-name`, in 2021 0%, in 2022 100%, in 2024 35%, and in 2025 50%. For `aria-progressbar-name`, in 2021 1%, in 2022 3%, in 2024 14%, and in 2025 19%. For `aria-tooltip-name`, in 2021 29%, in 2022 75%, in 2024 74%, and in 2025 87%. For `meta-refresh`, in 2021 and 2022 2%, in 2024 7%, and in 2025 8%. For `object-alt`, in 2021 1%, in 2022 20%, in 2024 10%, and in 2025 11%. For `select-name`, in 2024 37%, and in 2025 42%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=2072636024&format=interactive",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
  )
}}

This year, we're adding a new section on [Artificial Intelligence (AI)](#the-impact-of-artificial-intelligence-ai) to the Web Almanac. AI is changing how we build websites, write code, generate content, optimize performance, and interact with interfaces. It already plays a growing role in accessibility work, from generating image descriptions and captions to assistants that help teams find and fix issues.

At the same time, AI introduces risks and unanswered questions. There's no reliable way yet to see when AI has created or assisted in creating a website. Language models are trained on code and content that often contain accessibility problems. Automated descriptions or patterns can easily miss context, user intent, or nuance. Broader concerns about data use, environmental impact, and encoded bias directly affect who benefits from AI on the web and who is harmed or excluded.

The new AI chapter explores these tensions: how AI is already helping teams, where it falls short, and what standards, safeguards, and practices are needed. One principle runs through the analysis: AI should support human expertise and inclusive design, not replace them.

Throughout this chapter, you will find actionable links and practical solutions to help you improve accessibility on your own sites.

## Ease of reading

Users need to easily read and understand web content. This goes beyond picking legible fonts. It also covers using clear language, organizing pages logically, and following predictable design patterns.

While this report focuses on measurable technical metrics, qualitative factors, such as writing in plain language, matter just as much. WCAG 3.0 is exploring how to incorporate requirements for clear language, but it's still in the development phase.

Similar to plain language, numbers pose their own accessibility challenges. Some users struggle to interpret them, and automated tests can't reliably catch this as a barrier. To address this, review resources like <a hreflang="en" href="https://accessiblenumbers.com">Accessible Numbers</a> for practical advice on presenting numeric information clearly on the web.

Readability metrics exist for English content. The [Flesch-Kincaid](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests) readability score is one example. But the web is global. It spans many languages and diverse audiences. No standardized automated test covers all cases or languages.

### Color contrast

The difference between foreground and background colors determines whether people can perceive web content. Insufficient color contrast remains a common barrier, especially for users with low vision or <a hreflang="en" href="https://www.colourblindawareness.org/">color vision deficiencies</a>.

Color contrast is especially important for older users, people with temporary disabilities, like missing reading glasses, and anyone reading under bright sunlight or in challenging environments.

WCAG requires contrast ratios of at least 4.5:1 for standard text and 3:1 for large text to achieve AA conformance. AAA conformance demands 7:1 for normal text. [WCAG contrast ratios](https://developer.mozilla.org/en-US/docs/Web/Accessibility/Guides/Understanding_WCAG/Perceivable/Color_contrast) are an important baseline, but these guidelines don't address every form of color blindness or individual variation in perception.

Other documents, including the <a hreflang="en" href="https://git.myndex.com/">Accessible Perceptual Contrast Algorithm (APCA)</a>, aim to offer a more perceptually accurate measurement of contrast.

<a hreflang="en" href="https://accessibility.civicactions.com/guide/tools#color">Open source tools</a>, like the <a hreflang="en" href="https://contrast.report/">newly released Contrast Report</a>, make it easier than ever to find and fix color contrast issues. They even suggest modifications when colors fail to meet required ratios. For additional guidance, you can consult expert resources, such as <a hreflang="en" href="https://www.dennisdeacon.com/web/accessibility/testing-methods-use-of-color/">Dennis Deacon's article on color contrast testing</a>.

{{ figure_markup(
  image="sites-with-sufficient-color-contrast.png",
  caption="Sites with sufficient color contrast.",
  description="A series bar chart showing the percentage of website with sufficient color contrast across six years, on both desktop and mobile. In 2019 22% had sufficient color contrast. In 2020, it dropped to 21%, and recovered in 2021 to 22%. In 2022 on desktop and mobile it was 23%, and in 2024 it shot up on desktop to 28% and on mobile to 29%. In 2025 on both desktop and mobile it is 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1491798527&format=interactive",
  sheets_gid="15996962",
  sql_file="color_contrast.sql"
  )
}}

This year, text contrast pass rate improved by roughly 1% compared to 2024. But only 31% of mobile sites currently meet minimum color contrast requirements. Since mobile experiences depend heavily on clear visibility, this gap is a real problem for users accessing the web on their phones.

Browsers and operating systems increasingly support light, dark, and high-contrast modes. Users have more control now. Most sites still don't respond to these preferences though.

### Zooming and scaling

Users must be able to resize content to suit their needs. Disabling zoom removes user control and is a direct violation of WCAG resizing requirements. This is more than a minor inconvenience. It may make a site completely unusable for people with low vision or those who rely on screen magnification for reading.

In 2025, this restrictive pattern still appears, often because developers want pixel-perfect layouts on mobile devices. Unfortunately, that comes at the cost of usability and accessibility.

{{ figure_markup(
  image="pages-with-zooming-and-scaling-disabled.png",
  caption="Pages with zooming and scaling disabled.",
  description="A series of bar charts showing data on disabled zooming for desktop and mobile. 15% of desktop sites and 13% of mobile sites disable scaling, 19% and 17% respectively set a max scale of 1 and 21% and 19% use either.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=327558014&format=interactive",
  sheets_gid="684000055",
  sql_file="viewport_zoom_scale.sql"
  )
}}

The number of sites that disable zooming or scaling continues to drop. In 2025, only 19% of mobile sites and 21% of desktop sites restrict scaling, either by using `user-scalable=no` or setting a restrictive maximum scale. That's a 1–2% improvement over 2024, showing slow but steady progress.

{{ figure_markup(
  image="font-unit-usage.png",
  caption="Font unit usage.",
  description="A bar chart showing `px` is used for font sizes on 67% of desktop, `em` on 16%, `rem` on 9%, percentages on 4%, `<number>` on 2%, and finally `pt` on 1% of websites tested.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=611369037&format=interactive",
  sheets_gid="1493373752",
  sql_file="units_properties.sql"
  )
}}

Font size units directly affect how text can respond to user preferences. Relative units, such as `em` and `rem`, let text to scale predictably with browser settings. In 2025, the use of `em` on mobile sites increased by 2%, improving user experiences for those who adjust font sizes to increase readability. Otherwise, font size unit usage stays largely the same as last year.

If you want to check whether your site is restricting zoom, examine its source code for the `<meta name="viewport">` tag. Avoid using values like `maximum-scale`, `minimum-scale`, `user-scalable=no`, or `user-scalable=0`, as these limit resizing. Instead, let users freely adjust content size. <a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-scale.html#:~:text=Content%20satisfies%20the%20Success%20Criterion%20if%20it%20can,more%20extreme%2C%20adaptive%20layouts%20may%20introduce%20usability%20problems.">WCAG requires that text can resize up to 200%</a> without loss of content or functionality.

### Language identification

Declaring a page's primary language with the `lang` attribute is essential. It lets screen readers select the correct pronunciation rules and enables browsers to provide more accurate automatic translations. Beyond the primary language, it's equally important to specify the language of sections that differ from the main language. This ensures that screen readers properly switch pronunciation for foreign words or phrases.

Despite being a <a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/language-of-page">straightforward Level A WCAG requirement</a>, language declaration remains an area where many sites fall short. In 2025, roughly 86% of sites include a valid `lang` attribute, largely unchanged from 2024. This suggests steady adoption but also highlights room for improvement.

Correctly applying the `lang` attribute begins with including it on the `<html>` tag to specify the page's primary language. Pages often contain multiple languages. Use the `lang` attribute on individual elements or sections as needed. The <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/language-of-parts.html">W3C's documentation on specifying the language of parts</a> provides detailed guidance on this topic.

Missing or incorrect language declarations can cause translation errors.

For example, Chrome's automatic translation might misinterpret page content without a declared language, leading to confusing or inaccurate translations. Proper language tagging also supports styling for right-to-left languages and other language-specific behaviors.

## User preference

Modern CSS includes [User Preference Media Queries](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-color-scheme) that let websites adapt to a user's operating system or browser settings. Users get a more comfortable, personalized experience. Websites can respond to preferences for motion, contrast, and color schemes.

{{ figure_markup(
  image="user-preference-media-query.png",
  caption="User preference media queries.",
  description="A bar chart comparing the share of pages that use various user preference media features on desktop and mobile. The most widely used feature is `prefers-reduced-motion`, appearing on about half of both desktop (49.99%) and mobile (50.55%) pages. `-ms-high-contrast` and `forced-colors` also show notable usage, at around 21% and 16% on desktop and 20% and 19% on mobile, respectively. Other features, such as `prefers-color-scheme` (about 13% on both platforms) and `prefers-contrast` (around 1%), are used much less, while several legacy or experimental features appear on virtually no pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1063383428&format=interactive",
  sheets_gid="1601070335",
  sql_file="media_query_features.sql",
  width=600,
  height=551
  )
}}

The most familiar queries, `prefers-reduced-motion` and `prefers-color-scheme`, remain widely supported by browsers. In 2025, adoption of these queries by websites shows little change. However, the use of `forced-colors`, which supports high-contrast modes for users with low vision, increased by 5% to 19%. Meanwhile, use of the outdated `-ms-high-contrast` media query has declined by 3% down to 20%. This reflects a gradual shift towards modern CSS standards.

Continuing to incorporate these preferences advances accessibility and user satisfaction by respecting individual needs and system settings.

Broader implementation of personalization through CSS media queries hasn't seen significant growth despite these incremental gains. Encouraging further adoption helps ensure websites honor users' preferences, including reducing motion for vestibular disorder sensitivities and adapting display colors or contrast for visual comfort.

## Navigation

Users navigate websites in different ways. Some use a mouse to scroll. Others use a keyboard, switch control device, or screen reader to navigate through headings. An effective navigation system must work for every user, regardless of their input device.

Wide-screen TVs and voice interfaces like Siri and Amazon Alexa create unique navigation challenges. Building good semantic structure into a site helps screen reader users navigate. It also helps users of many other types of technology.

### Focus indication

Focus indication is essential for users who rely primarily on keyboard navigation and assistive devices to move through web content. It provides a visible cue that highlights which element is currently focused, so users understand where they are on the page.

Automated testing tools like Google Lighthouse can identify many basic requirements and flag obvious failures around focus indicators. But they're limited when it comes to complex interactions like keyboard traps, focus order, and whether focus moves logically to new content. Passing automated audits doesn't guarantee a site's keyboard accessibility or a good user experience for keyboard users.

Comprehensive manual testing is irreplaceable.

Tools like the open source <a hreflang="en" href="https://accessibilityinsights.io/docs/web/overview/">Accessibility Insights for the Web</a> extension leverage Deque's axe-core and offer guided manual tests. The "Tab Stops" visualization feature helps testers see the path keyboard users take and identify potential issues effectively, like missing focus styles or unexpected focus traps.

Users of alternative navigation devices with limited motor abilities have unique needs related to focus visibility and sequence. Customizing assistive technology interfaces helps maximize control tailored to their abilities.

Focus testing best practices include:

- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focus-traps">No focus traps where keyboard users get stuck</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focusable-controls">All interactive controls are keyboard focusable</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/logical-tab-order">Tab order is logical and intuitive</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/managed-focus">Focus is appropriately directed to new or dynamically loaded content</a>

<a hreflang="en" href="https://www.a11y-collective.com/blog/focus-indicator/">The A11y Collective's report on understanding focus indicators</a> offers practical insights for implementing and testing visible focus outline styles.

#### Focus styles

WCAG mandates that all interactive content must have a <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-visible.html">clearly visible focus indicator</a>. This visual cue helps keyboard users identify which element is currently focused as they move through the page.

Without a prominent focus indicator, keyboard users and those relying on assistive technologies can easily become lost. Robust focus styles, like a high-contrast outline, are fundamental to accessible design. Many institutions, like <a hreflang="en" href="https://www.gov.uk/">GOV.UK</a>, have established standards for focus indicators to ensure consistency and clarity.

Design annotations need to specify keyboard interactions, as <a hreflang="en" href="https://tetralogical.com/blog/2025/09/23/annotating-designs-using-common-language/">Craig Abbott clearly laid out in the TetraLogical blog</a>. Shortly after this post, GitHub released their accessibility <a hreflang="en" href="https://github.com/github/annotation-toolkit">Annotation Toolkit</a>, addressing the same problem.

{{ figure_markup(
  image="pages-overriding-browser-focus-styles.png",
  caption="Pages overriding browser focus styles.",
  description="A bar chart comparing the share of pages that use three focus-related CSS patterns on desktop and mobile. The basic `:focus` selector is present on about 90% of both desktop and mobile pages, while removing focus outlines with `:focus { outline: 0; }` appears on roughly two-thirds of pages (67%) for both. Usage of the more accessible `:focus-visible` selector is much lower, at about one-quarter of pages (25% on desktop and 24% on mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1774339890&format=interactive",
  sheets_gid="1499298533",
  sql_file="focus_outline_0.sql"
  )
}}

In 2025, 67% of sites explicitly removed default focus outlines, up 14% from 2024. This concerning trend may impair accessibility if not replaced with effective styles. On the positive side, adoption of the `:focus-visible` pseudo-class has grown. This means developers are starting to create context-aware focus indicators that are visible only when necessary.

#### `tabindex`

The `tabindex` attribute controls an element's participation in the keyboard focus order. It lets developers include, exclude, or reorder focusable elements. Correct use supports logical navigation and accessibility, and is a <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-order.html">WCAG requirement</a>. Misuse, especially with positive values, can disrupt natural tab order and confuse users.

{{ figure_markup(
  image="tabindex-usage.png",
  caption="`tabindex` usage.",
  description="A bar chart showing the share of pages that use different `tabindex` values on desktop and mobile. Just over half of pages use `0` (52.1% on desktop and 50.1% on mobile), and a similar share use negative `tabindex` values such as `-1` (52.0% on desktop and 50.3% on mobile). In contrast, positive `tabindex` values appear on only a small minority of pages (3.7% on desktop and 3.4% on mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=140565248&format=interactive",
  sheets_gid="1566430802",
  sql_file="tabindex_usage_and_values.sql"
  )
}}

In 2025, `tabindex` usage has increased slightly. Just over 50% of sites used it, around 3-4% higher than 2024. Positive `tabindex` use remains stable, generally low, reflecting continued awareness that positive tabindex values should be avoided.

### Landmarks

Landmarks structure a web page into distinct thematic regions, using native HTML elements such as `<header>`, `<nav>`, `<main>`, and `<footer>`. These elements create a clear, high-level page outline that help users of assistive technologies quickly understand the layout and jump directly to relevant sections.

A common accessibility anti pattern persists when developers add redundant ARIA attributes. For example, adding `role="navigation"` to a `<nav>` element. The `<nav>` element inherently carries the navigation role, so this duplication adds clutter to the code without benefit and may confuse assistive technology. <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/html/H101">Best practice is to favor native HTML5 elements</a> first before adding ARIA landmark roles. That's ARIA's primary guideline.

Accessibility experts like Eric Bailey have highlighted <a hreflang="en" href="https://www.smashingmagazine.com/2025/06/what-i-wish-someone-told-me-aria/">the pitfalls of overusing ARIA</a> in contexts where native semantic HTML is enough. Heydon Pickering's <a hreflang="en" href="https://heydonworks.com/article/pride-shame-and-accessibility/">twelve principles of web accessibility</a> also emphasize the critical role semantic structure and landmarks play in accessible navigation.

<figure>
  <table>
    <thead>
      <tr>
        <th>Element</th>
        <th>Element %</th>
        <th>Role %</th>
        <th>Both %</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>main</td>
        <td class="numeric">40.72%</td>
        <td class="numeric">17.81%</td>
        <td class="numeric">47.34%</td>
      </tr>
      <tr>
        <td>header</td>
        <td class="numeric">65.99%</td>
        <td class="numeric">10.95%</td>
        <td class="numeric">67.41%</td>
      </tr>
      <tr>
        <td>nav</td>
        <td class="numeric">67.73%</td>
        <td class="numeric">18.02%</td>
        <td class="numeric">70.94%</td>
      </tr>
      <tr>
        <td>footer</td>
        <td class="numeric">66.38%</td>
        <td class="numeric">9.59%</td>
        <td class="numeric">67.66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Landmark element and role usage (desktop).",
      sheets_gid="445686890",
      sql_file="landmark_elements_and_roles.sql"
      )
    }}
  </figcaption>
</figure>

{{ figure_markup(
  image="yearly-growth-in-pages-with-element-role.png",
  caption="Yearly growth in pages with element role.",
  description="A chart showing the percentage of pages using landmark `role` attributes (`footer`, `header`, `main`, `nav`) across five years. Usage has grown steadily for all roles: `nav` leads at 66% in 2021 rising to 71% in 2025, followed by `footer` (65% to 68%), `header` (64% to 67%), and `main` (35% to 47%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=553285039&format=interactive",
  sheets_gid="445686890",
  sql_file="landmark_elements_and_roles.sql"
  )
}}

In 2025, the adoption of ARIA landmarks has increased slightly, led by the growing use of the native `<main>` element, now at 47%, up 3% from 2024. This progress reflects better compliance with semantic HTML and more robust page structure for users relying on assistive tools.

Screen reader users often navigate via "rotors" or landmark menus to jump between these page regions. Skip links pointing to landmarks improve usability by allowing immediate access to core content. They circumvent repeated navigation blocks or banners. We discuss Skip links in a later section.

Continued education on leveraging native HTML5 landmarks and minimizing redundant ARIA roles will further improve keyboard and assistive technology navigation experiences. The growth in semantic structure adoption supports accessibility goals and aligns web content with modern best practices.

### Heading hierarchy

A coherent heading structure acts like a table of contents for a web page. It supports accessibility, SEO, and user comprehension. For screen reader users, navigating via headings is a key way to find information quickly. Search engines also rely on heading hierarchy to understand a page's organization and relevance.

Headings should communicate document structure, not just visual styling. Using heading tags such as `<h3>` or `<h4>` solely for their font size breaks the logical order. It makes navigation difficult for users of assistive technologies and violates the principle of separating structure from presentation. Instead, developers should style headings with CSS and use heading tags according to content hierarchy.

For a refresher on why semantics matter, review <a hreflang="en" href="https://www.jonoalderson.com/conjecture/why-semantic-html-still-matters/">this article by Jono Alderson</a>.

After a multi-year decline, heading hierarchy scores improved by almost 2% in 2025, indicating a renewed focus on proper heading structure.

{{ figure_markup(
  caption="Mobile sites passing the Lighthouse audit for properly ordered heading.",
  content="59%",
  classes="big-number",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

Nevertheless, misusing headings for styling instead of structure remains common.

### Skip links

Skip links are navigation aids that allow keyboard users and others using non-mouse input devices to bypass large, repetitive blocks of content, such as site navigation menus, and jump straight to the main page content. Typically, a "skip to main content" link is present as the first focusable element on the page for efficient navigation.

Bypassing blocks of content is a <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/bypass-blocks.html">WCAG requirement</a>, and basic implementations remain the norm.

Sophisticated tools, like <a hreflang="en" href="https://paypal.github.io/skipto/">PayPal's open source SkipTo</a>, exist to generate dynamic menus of all major landmarks and headings on a page. This richer interaction benefits a wider range of users, enhancing overall navigability and usability. Eleanor Hecks wrote a compelling article on the <a hreflang="en" href="https://www.smashingmagazine.com/2025/04/what-mean-site-be-keyboard-navigable/">importance of keyboard accessibility</a>, as did <a hreflang="en" href="https://tetralogical.com/blog/2025/05/09/foundations-keyboard-accessibility/">TetraLogical</a>.

Adoption of skip links has remained largely static from 2024 to 2025.

{{ figure_markup(
  caption="Mobile and desktop pages likely featuring a skip link.",
  content="24%",
  classes="big-number",
  sheets_gid="1734473098",
  sql_file="skip_links.sql"
)
}}

Approximately 24% of desktop and mobile pages include skip links detectable by common analysis methods. This figure might under-represent actual usage, as some skip links appear deeper in the page or target landmarks beyond navigation menus.

{{ figure_markup(
  image="yearly-growth-in-pages-with-skip-links.png",
  caption="Yearly growth in pages with skip links.",
  description="A multi-series column chart showing the percentage of pages with skip links on desktop and mobile across four years. Usage has grown steadily from 19.7% in 2021 to 25.65% on desktop and 26.23% on mobile in 2025, with mobile consistently slightly higher than desktop in recent years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=688571011&format=interactive",
  sheets_gid="1734473098",
  sql_file="skip_links.sql"
  )
}}

### Document titles

A descriptive page `<title>` is a basic necessity. It provides context for users navigating between browser tabs and windows and is often the first piece of information announced by a screen reader, helping users get oriented. WCAG also mandates that <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/page-titled">every page should have a meaningful title</a>.

{{ figure_markup(
  image="title-element-statistics.png",
  caption="Title element statistics.",
  description="A bar chart comparing title element usage patterns on desktop and mobile. Nearly all pages (98%) have a title element on both platforms, while titles with four or more words appear on 69% of desktop pages and 67% of mobile pages. Titles that change after rendering occur on 7% of pages for both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1678943411&format=interactive",
  sheets_gid="480324977",
  sql_file="page_title"
  )
}}

The 2025 data shows a slight improvement in the presence and descriptiveness of document titles compared to previous years. Approximately 98% of sites now include a `<title>` element, a 1% increase from 2024.

This is positive. But despite this high inclusion rate, many titles remain insufficiently descriptive. This impacts usability, especially for screen reader users who rely on clear titles for orientation.

There was a 2% decrease in mobile sites having titles with four or more words, which may indicate shorter or less specific titles on mobile pages. Including both a brief description of the page content and the website's name remains best practice for enhancing navigation and context.

Document titles remain a fundamental accessibility feature that benefits all users. They provide context when navigating browser tabs and windows. While near-universal in presence, improving title descriptiveness and consistency continues to be an important focus in 2025 and beyond.

### Tables

HTML tables present data in a two-dimensional grid. Accessibility depends on structuring them with appropriate semantic elements. Using `<caption>` provides crucial context for screen reader users, while `<th>` elements define headers for rows and columns, helping users understand relationships within the data. <a hreflang="en" href="https://codepen.io/stevef/pen/ByoMebv">Steve Faulkner's tool</a>, released in 2025, can help developers quickly inspect the semantics of any HTML element.

The use of `<caption>` remained steady in 2025 compared to 2024, with only a small percentage of sites including captions. This low adoption is similar to prior years: roughly 1.6% of desktop sites include captions, which is an important, though often overlooked, accessibility feature.

Tables shouldn't be misused for layout purposes. CSS Flexbox and Grid handle layout. When tables are used purely for layout, the `role="presentation"` attribute removes their semantic meaning to avoid confusion with assistive technologies.

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>desktop</th>
        <th>mobile</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Captioned tables</td>
        <td class="numeric">5.6%</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Presentational table</td>
        <td class="numeric">4.9%</td>
        <td class="numeric">5.4%</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">4.8%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Table usage.",
      sheets_gid="1701660946",
      sql_file="table_stats.sql"
      )
    }}
  </figcaption>
</figure>

In 2025, 4.9% of mobile tables use this technique, up from 4% in 2024 and 1% in 2022. The emphasis remains on using semantic HTML elements correctly to make tables accessible.

## Forms

Forms are how users interact with the web, from logging in to making a purchase to sharing information. Ensuring they're accessible is critical for users to complete tasks and participate fully online.

### `<label>` element

The `<label>` element remains the standard, recommended way to provide accessible names for input fields. By programmatically associating descriptive text with a form control, typically through the `for` attribute pointing to the input's `id`, it ensures users of assistive technology clearly understand what information is required. Proper labels also improve usability by increasing the clickable area, since clicking the label sets focus to the input.

{{ figure_markup(
  image="where-inputs-get-their-accessible-names-from.png",
  caption="Where inputs get their accessible names from.",
  description="A bar chart showing the sources of accessible names for inputs on desktop and mobile. The most common source is an associated `<label>` element, used for about one-third of inputs (34.27% on desktop and 34.57% on mobile), followed closely by `placeholder` text (24.49% on desktop and 25.12% on mobile) and inputs with no accessible name at all (24.65% on desktop and 24.93% on mobile). Other sources, such as `aria-label`, `title`, or `value` attributes, and `aria-labelledby` relationships, account for only a small fraction of inputs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1732059331&format=interactive",
  sheets_gid="1144087268",
  sql_file="form_input_name_sources.sql"
  )
}}

In 2025, about 35% of mobile inputs receive their accessible names from `<label>`, up from 32% in 2024. This is a positive trend.

We also saw a modest 2% reduction in inputs deriving accessible names only from placeholder text. Placeholder text is less reliable and not a substitute for labels. However, the proportion of inputs lacking accessible names altogether remained unchanged from last year, indicating ongoing accessibility gaps.

The 2025 data shows incremental improvement in `label` usage. It also underscores the need to continue expanding proper labeling practices to achieve full accessibility compliance and usability.

### `placeholder` attribute

The placeholder attribute provides a hint or example of the expected input format inside a form field. But it should never replace the `<label>` element as the accessible name for that input. Placeholder text disappears as soon as the user starts typing, making it unavailable for reference.

Placeholder text also usually has poor default contrast, often failing WCAG color contrast requirements. Screen reader support for placeholders varies widely as well.

The recommended approach is to use visible, programmatically associated labels for inputs, with the placeholder serving only as a supplementary hint or example.

{{ figure_markup(
  image="use-of-placeholders-on-inputs.png",
  caption="Use of placeholders on inputs.",
  description="A bar chart comparing the share of sites using placeholders on inputs and related patterns on desktop and mobile. About 56% of desktop sites and 55% of mobile sites use placeholders, while 58% of desktop sites and 59% of mobile sites have inputs without labels. Notably, 53% of desktop sites and 55% of mobile sites use both placeholders and lack input labels.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1130613025&format=interactive",
  sheets_gid="1641253918",
  sql_file="placeholder_but_no_label.sql"
  )
}}

In 2025, there was a 2% reduction in the use of placeholder text as the only accessible name for inputs. Despite this positive trend, the practice remains all too common. 53% of desktop and 55% of mobile inputs rely solely on placeholder text for accessible naming, which still poses significant accessibility barriers.

### Requiring information

Communicating that a form field is mandatory is essential for usability and accessibility. While a visual indicator such as an asterisk (\*) is common, it alone is insufficient because it lacks semantic information.

The HTML5 `required` attribute provides a native, machine-readable way to indicate that a user must fill in a field before submitting the form. This attribute works with many input types like text, email, password, date, checkbox, and radio. Browsers enforce validation and assistive technologies convey the required status to users.

{{ figure_markup(
  image="how-required-inputs-are-specified.png",
  caption="How required inputs are specified.",
  description="A bar chart comparing methods for marking required inputs on desktop and mobile. The `required` attribute is most common at 67% on desktop and 66% on mobile, followed by `aria-required` at 36% and 37%. Visual asterisks appear on 18% of desktop and 19% of mobile sites, with overlaps like both `required` and `aria-required` on 9% of sites for both platforms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1477108194&format=interactive",
  sheets_gid="1187751102",
  sql_file="form_required_controls.sql"
  )
}}

We are seeing a modest increase in the adoption of the required attribute, up 1% in 2025 to 66% for mobile. Use of `aria-required` has dropped 3% to 37% for mobile. This indicates a gradual shift towards more semantic usage of native HTML validation over ARIA, which is intended to supplement but not replace native semantics.

Progress in 2025 reflects slow but steady movement toward better semantic indication of required inputs, improving form accessibility and user experience.

### Captchas

CAPTCHAs differentiate humans from automated bots, mitigating malicious activity. The acronym stands for "Completely Automated Public Turing Test to Tell Computers and Humans Apart." While CAPTCHAs serve a necessary security function, they frequently create significant accessibility barriers, particularly for people with visual, motor, or cognitive disabilities.

Traditional visual CAPTCHAs can be difficult or impossible for users with disabilities to solve. The W3C recommends exploring alternative verification methods that are more inclusive, such as:

- Audio CAPTCHAs that provide spoken challenges
- "Invisible" CAPTCHAs that work in the background without user input
- Incorporating multi-factor authentication methods or simpler verification flows.

In 2025, CAPTCHA use has remained roughly steady compared to previous years.

{{ figure_markup(
  image="captcha-usage-year-over-year.png",
  caption="CAPTCHA usage year over year.",
  description="A multi-series column chart showing the percentage of sites using captchas on desktop and mobile from 2021 to 2025. Usage peaked in 2022 at 20% on desktop and 19% on mobile, then declined slightly to 17% and 16% in 2024, remaining stable at 18% and 17% in 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1433910378&format=interactive",
  sheets_gid="1834983243",
  sql_file="captcha_usage.sql"
  )
}}

Notably, the Government of Luxembourg released a <a hreflang="en" href="https://accessibilite.public.lu/en/news/2025-09-22-captchas.html">CAPTCHA scanner</a> tool. It assesses and monitors CAPTCHA implementations across government websites, aiming to improve accessibility compliance in the public sector.

Continued efforts to replace or supplement visual CAPTCHAs with more accessible options are essential. All users should be able to complete verification steps without undue difficulty or exclusion.

## Media on the web

Accessible media on the web requires providing alternative formats to ensure content is usable by everyone. Users with visual impairments benefit from audio descriptions that convey important visual information. Users who are deaf or hard of hearing rely on captions or sign language interpretation to access audio content.

Audio descriptions and captions aren't enough. Transcripts are necessary for audio-only and video-only content, offering a complete textual alternative. For non-text content like images, provide appropriate alternative text. If they don't add meaningful information, mark them as decorative.

The principles and requirements for accessible media remain consistent between 2024 and 2025, emphasizing the ongoing importance of providing inclusive multimedia experiences to users with disabilities.

### Images

The `alt` attribute provides a textual description of an image. It's essential for screen reader users to understand the visual content. In 2025, this attribute remains fundamental to image accessibility, with no significant change in error rates from previous years.

{{ figure_markup(
  caption="Percentage of images passing the Lighthouse audit for images with `alt` text.",
  content="69%",
  classes="big-number",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

JPG and PNG files continue to dominate web images, but there is encouraging growth in the use of WEBP and SVG formats. SVG files offer rich semantics that benefit complex and interactive images.

{{ figure_markup(
  image="most-common-file-extensions-in-alt-text.png",
  caption="Most common file extensions in `alt` text.",
  description="A bar chart showing the most common file extensions found in image alt text on desktop and mobile. JPEG images dominate with `jpg` at 54.0% on desktop and 53.4% on mobile, followed by `png` at 34.5% and 34.6%. Other formats like `jpeg` (4.8% desktop, 10.1% mobile), `webp`, `svg`, `ico`, and `gif` make up smaller shares.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1120578928&format=interactive",
  sheets_gid="2115828969",
  sql_file="alt_ending_in_image_extension.sql"
  )
}}

However, we noticed one issue that continues to persist: approximately 8.5% of image alt texts end with common file extensions like `.jpg` or `.png`. This typically happens when automated authoring tools insert filenames as `alt` text. Unfortunately, this adds no value and doesn't help users relying on assistive technologies.

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` attribute lengths.",
  description="A grouped bar chart showing the distribution of `alt` attribute lengths for images on desktop and mobile. Around 13–14% of images have no `alt` attribute and 30% use an empty `alt` on both platforms. Of the remaining images with non-empty text, most are short: about 20% have 10 or fewer characters, 17% have 20 or fewer, and 18% (desktop) and 10% (mobile) have 30 or fewer, while only about 1% have 100 or more characters and virtually none exceed 100 characters.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=536884664&format=interactive",
  sheets_gid="785975896",
  sql_file="common_alt_text_length"
  )
}}

There is a positive trend toward alt texts between 20 and 30 characters in length, which tend to balance descriptiveness and brevity. But about 50% of images still have either empty alt attributes or text shorter than 10 characters. Empty alt text is appropriate only for purely decorative images. Most images however convey important information deserving meaningful descriptions and therefore will benefit from a meaningful alt text.

Best practices continue to emphasize providing concise yet descriptive alt text tailored to image context, avoiding filenames, and using semantic file formats like SVG when appropriate. Artificial Intelligence (AI) tools show promise too. <a hreflang="en" href="https://www.drupal.org/project/ai_image_alt_text">Drupal's integration of AI-assisted alt text suggestions</a> helps authors create better alt attributes by providing editable examples. Brian Teeman wrote an interesting critique of the <a hreflang="en" href="https://magazine.joomla.org/all-issues/june-2024/ai-generated-alt-text">AI generation of Alt Text</a>.

Images remain an area with opportunities for significant accessibility improvement despite steady progress.

### Audio and video

The HTML `<track>` element provides timed text tracks like captions, subtitles, and audio descriptions for media elements like `<video>` and `<audio>`. In 2025, this element is still underutilized. Despite its importance for users who are deaf, hard of hearing, or blind, adoption rates stay exceptionally low, at under 1%.

Many modern video platforms now commonly use [HTTP Live Streaming (HLS)](https://en.wikipedia.org/wiki/HTTP_Live_Streaming) instead of the native `<track>` element. This may contribute to the low usage statistics. HLS, which requires custom implementation, means that developers need to be more intentional about building in caption support themselves. This means there's more room for developers to forget about captions or do them poorly.

Captions are essential for deaf and hard of hearing users. They also benefit viewers in noisy environments or those with difficulty understanding spoken language. Audio descriptions enable users with visual impairments to gain context about visual content.

Compared to 2024, we've seen no significant growth in `<track>` usage for captions and subtitles, going from 0.1% to 0.4% on desktop and 0.1% to 0.2% on mobile. This tells us that the industry still has substantial room for improvement.

## Assistive technology with ARIA

Accessible Rich Internet Applications (ARIA) is a set of HTML attributes to improve the accessibility of web content. ARIA is particularly valuable for complex or custom components that can't be made accessible with native HTML alone. ARIA enhances dynamic, interactive user interfaces, making sure people using screen readers or other assistive technologies can understand and interact with all page elements.

ARIA must be used with care.

Incorrect or excessive use can introduce new barriers, causing confusion for both users and accessibility tools. For example, ARIA attributes that don't match the intended functionality, roles added to inappropriate elements, or redundant ARIA can disrupt the user experience and increase accessibility errors.

Adrian Roselli's work highlights <a hreflang="en" href="https://adrianroselli.com/2025/01/aria-description-does-not-translate.html">the limitations of certain ARIA properties</a>, such as `aria-description`, and underscores the importance of understanding both the strengths and pitfalls of ARIA.

The most important principle for ARIA is:

**If you can use native HTML, you should.**

Native elements like `<button>` , `<input>`, and `<nav>` come with built-in accessibility that ARIA can't fully reproduce. ARIA should only supplement native semantics where required, not replace them.

Recent <a hreflang="en" href="https://www.a11y-collective.com/blog/aria-in-html/">guidance</a> by experts including Florian Schroiff as well as current best practices reinforce applying ARIA only for complex custom elements, and strictly following specifications to avoid accidental exclusion or miscommunication.

In 2025, ARIA continues to play a vital but occasionally problematic role in web accessibility.

### ARIA roles

ARIA roles communicate an element's purpose or type to assistive technologies. In 2025, they continue to play a significant role in making web content accessible. While native HTML elements like `<button>` come with built-in semantics, ARIA provides the ability to assign roles to custom components that lack native equivalents, such as tabbed interfaces or `dialog` components.

{{ figure_markup(
  image="top-ten-most-common-aria-roles.png",
  caption="Top ten most common ARIA roles.",
  description="A bar chart showing the ten most common ARIA roles on desktop and mobile pages. `button` is the most widely used role (53.06% on desktop and 53.56% on mobile), followed by `presentation` (42.48% and 41.54%) and `dialog` (34.05% and 36.01%). Other frequently used roles include `search`, `navigation`, `img`, `main`, `region`, `group`, and `status`, all appearing on roughly 15–25% of pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1028393265&format=interactive",
  sheets_gid="2081252628",
  sql_file="common_aria_role",
  width=600,
  height=676
  )
}}

We've seen an approximately 4% increase in the use of the ARIA `button` role, reaching 53% on desktop and 54% on mobile sites in 2025. We've seen similar increases in the use of roles like `presentation` and `dialog`, whereas the use of the `search` role usage remains stable.

The increased use of the ARIA `button` role raises concerns. It often indicates that websites are applying roles like `button` to non-semantic elements such as `<div>` or `<span>`. Or they're redundantly assigning roles to native HTML elements like `<button>`.

### Using the presentation role

Applying `role="presentation"` or `role="none"` instructs assistive technologies to treat the element as purely presentational. It removes its native semantics from the accessibility tree. While this can be useful for layout elements that convey no meaningful information, overuse or misuse can create significant accessibility barriers.

For example, applying `role="presentation"` to a `<ul>` element causes the entire list semantics, including those of child `<li>` elements, to be ignored. Screen reader users lose crucial contextual and structural information, like how many items are in a list.

While the `presentation` role can help remove misleading semantics when elements are used purely decoratively or for layout, it should be applied sparingly and with clear intent.

{{ figure_markup(
  caption="Percentage of desktop sites and mobile sites have at least one `presentation` role.",
  content="42%",
  classes="big-number",
  sheets_gid="2081252628",
  sql_file="common_aria_role.sql"
)
}}

In 2025, the use of `role="presentation"` increased by 2%, continuing a concerning trend.

### Labeling elements with ARIA

Browsers maintain an accessibility tree that exposes information about page elements, such as their accessible names, roles, states, and descriptions. Assistive technologies rely on this to convey context to users. An element's accessible name is crucial and is usually derived from visible text content. However, ARIA attributes like `aria-label` and `aria-labelledby` can be used to explicitly set or override accessible names when native text is insufficient or unavailable.

{{ figure_markup(
  image="top-10-aria-attributes.png",
  caption="Top 10 ARIA attributes.",
  description="A bar chart showing the ten most common ARIA attributes on desktop and mobile pages. `aria-label` leads at 70% on desktop and 68% on mobile, followed closely by `aria-hidden` (66% on both). Other frequently used attributes include `aria-expanded` (40% and 38%), `aria-controls` (34% and 33%), `aria-live` (33% and 32%), and `aria-labelledby` (30% and 29%), with usage decreasing down to `aria-describedby` at 17% on both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=318641062&format=interactive",
  sheets_gid="1821302308",
  sql_file="common_element_attributes.sql",
  width=780,
  height=676
  )
}}

In 2025, the use of almost all top ARIA attributes increased. Desktop usage of `aria-label` rose by 5% and `aria-labelledby` by 3%. Use of `aria-describedby` on desktop decreased by 1%.

These changes suggest developers increasingly assign accessible names programmatically to more elements. This can be helpful but also problematic if not carefully implemented.

{{ figure_markup(
  image="button-accessible-name-source.png",
  caption="Button accessible name source.",
  description="A bar chart showing the sources of accessible names for buttons on desktop and mobile. Button contents provide the accessible name for the majority (57% on desktop and 55% on mobile), followed by `aria-label` attributes (28% and 29%). About 9% of desktop buttons and 11% of mobile buttons have no accessible name, with smaller shares from `title` (1%) and `value` (5% and 4%) attributes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=312250756&format=interactive",
  sheets_gid="1995812848",
  sql_file="button_name_sources.sql"
  )
}}

We are seeing a concerning trend with the continued increase of 4% to 5% in defining buttons with `aria-label` alone, without corresponding visible labels. This disconnect between what a user sees visually and what assistive technologies announce can create confusion and barriers. This is especially true for people with cognitive disabilities or who use voice input. Ideally, the accessible name and visible label should match to provide a consistent user experience.

Nearly 66% of pages use the `aria-label` attribute, up from earlier years, making it the most frequently used ARIA attribute for accessible names. About a quarter of pages use `aria-labelledby`.

While using ARIA to enhance accessibility is positive, it underscores the importance of testing with assistive technologies and involving users with disabilities to ensure meaningful and accurate naming.

### Hiding content

The `aria-hidden="true"` attribute removes an element and all its descendants from the accessibility tree, making the content invisible to screen readers. This is useful for hiding purely decorative or redundant visual elements that would otherwise confuse non-visual users.

{{ figure_markup(
  caption="Pages with at least one element with the `aria-hidden` attribute.",
  content="66%",
  classes="big-number",
  sheets_gid="2081252628",
  sql_file="common_aria_role.sql"
)
}}

In 2025, use of `aria-hidden` increased by 3% compared to 2024. Approximately 66% of websites have some content hidden using this ARIA attribute.

Similarly, the `aria-expanded` attribute, which signals whether a section of content is expanded or collapsed, also saw increased adoption, reaching 40% of desktop sites and 38% of mobile sites. This attribute is important for communicating the state of disclosure widgets like accordions or expandable menus to assistive technologies.

Thoughtful application of these ARIA attributes remains crucial in 2025. They help with the management of dynamic content and ensure inclusive experiences across devices and user needs.

### Screen reader-only text

In 2025, a common and effective technique for accessibility is the use of screen reader-only text. This is text that's visually hidden but remains accessible to assistive technologies like screen readers. This approach is often applied to provide additional context, instructions, or descriptive labels for interactive elements without cluttering the visible interface.

Developers frequently use common CSS classes such as `.sr-only`, `.visually-hidden` , or `.element-invisible` to achieve this effect. These classes typically use off-screen positioning, clipping, or zero-sized boxes to hide the text visually while ensuring it remains in the accessibility tree and readable by screen readers.

{{ figure_markup(
  caption="Desktop websites with a sr-only or visually-hidden class.",
  content="16%",
  classes="big-number",
  sheets_gid="1554469444",
  sql_file="sr_only_classes.sql"
)
}}

Usage of these common screen reader-only classes remained essentially unchanged between 2024 and 2025. Some websites include hidden text to provide context to screen reader users in ways that may not be apparent from the semantic HTML alone.

### Dynamically-rendered content

ARIA live regions are critical for making dynamically changing content accessible. They inform screen readers about updates to page content, such as form validation messages, status updates, or live feeds. These updates occur without a full page reload, and are therefore necessary for users to receive important information without disruption.

<figure>
  <table>
    <thead>
      <tr>
        <th>Role</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Implicit <code>aria-live</code> value</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>status</td>
        <td class="numeric">15.18%</td>
        <td class="numeric">14.51%</td>
        <td>polite</td>
      </tr>
      <tr>
        <td>alert</td>
        <td class="numeric">7.12%</td>
        <td class="numeric">6.74%</td>
        <td>assertive</td>
      </tr>
      <tr>
        <td>timer</td>
        <td class="numeric">0.91%</td>
        <td class="numeric">0.84%</td>
        <td>off</td>
      </tr>
      <tr>
        <td>log</td>
        <td class="numeric">0.61%</td>
        <td class="numeric">0.55%</td>
        <td>polite</td>
      </tr>
      <tr>
        <td>marquee</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
        <td>off</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Pages with live region ARIA roles and their implicit `aria-live` value.",
      sheets_gid="2081252628",
      sql_file="common_aria_role.sql"
      )
    }}
  </figcaption>
</figure>

In 2025, about 33% of sites use the `aria-live` attribute, up 4% from 2024. Usage of the `role` value `status`, essentially an `aria-live` value of `polite`, increased by approximately 5%. This signals more widespread adoption of polite notifications that inform users of non-urgent updates.

Additional ARIA roles, such as `alert`, `timer`, `log`, and `marquee`, also have implicit `aria-live` attributes with predefined behaviors, enabling a broad spectrum of live region use cases.

Increased use of ARIA live regions in 2025 reflects progress in communicating dynamic content updates effectively, supporting users who rely on assistive technologies to interact with modern, responsive web experiences.

## User personalization widgets and overlay remediation

Accessibility widgets and overlay remediation tools are third-party scripts designed to enhance website accessibility. They offer user personalization options, such as font size or contrast adjustments, and automated fixes for common accessibility issues.

These overlays often promise quick-fix compliance but fall short of addressing complex accessibility challenges that require manual code and design changes. <a hreflang="en" href="https://www.edf-feph.org/accessibility-overlays-dont-guarantee-compliance-with-european-legislation/">The European Disability Forum</a> has warned that such tools can interfere with users' own assistive technologies, creating conflicts that reduce accessibility and frustrate users.

Though overlays can help remove some surface-level barriers and provide additional personalization features, reliance on them often leads organizations to stop investing in proper accessibility. Overlays generally have more usability, security, and performance drawbacks than fixing underlying code issues.

{{ figure_markup(
  image="pages-using-accessibility-apps-overlays.png",
  caption="Pages using accessibility apps (overlays).",
  description="A multi-series column chart showing the percentage of pages using accessibility apps (overlays) on desktop and mobile from 2021 to 2025. Usage has grown steadily: desktop from 1.0% to 2.1% and mobile from 0.8% to 1.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=277084081&format=interactive",
  sheets_gid="93717182",
  sql_file="a11y_technology_usage.sql"
  )
}}

Data shows about 2% of desktop sites use such accessibility apps. Rates are even lower rates among the highest-traffic sites, at 0.2% among the top 1,000. This pattern shows that overlays are mostly adopted by lower-traffic sites and remain a controversial and imperfect solution.

Despite a marginal increase in their use in 2025, the distribution of these accessibility apps remains consistent with 2024, dominated by providers like <a hreflang="en" href="https://userway.org/">UserWay</a>, <a hreflang="en" href="https://accessibe.com/">AccessiBe</a>, <a hreflang="en" href="https://www.audioeye.com/">AudioEye</a>, and <a hreflang="en" href="https://www.equalweb.com/">EqualWeb</a>.

{{ figure_markup(
  image="accessibility-app-usage-by-rank.png",
  caption="Accessibility app usage by rank.",
  description="A multi-series column chart showing the percentage of pages using specific accessibility apps (AccessiBe, AudioEye, EqualWeb, UserWay) by site rank grouping from top 1000 to top 100 million. UserWay shows the highest usage across most ranks, peaking at 0.81% in the top 10 million group, while AccessiBe peaks at 0.58% in the top 1 million group. Usage tends to be higher for mid-tier rank groups (10,000 to 10 million) compared to both top-tier and bottom-tier sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1915310442&format=interactive",
  sheets_gid="2094043875",
  sql_file="a11y_technology_usage_by_domain_rank.sql"
  )
}}

### Confusion on overlays

Accessibility overlays and personalization widgets, while growing marginally in use by about 2% in 2025, continue to be a source of significant controversy and confusion.

Leading organizations such as the International Association of Accessibility Professionals (IAAP) and the European Disability Forum (EDF) have explicitly warned that overlays are not a silver bullet. They must never impede users' access or interfere with their assistive technologies and shouldn't be marketed as making a site fully compliant.

Marketing claims often create unrealistic expectations among organizations, leading to legal and practical risks. These tools can't replace inclusive design, manual accessibility testing, and ongoing remediation. All these are essential to meet accessibility standards.

The European Accessibility Act and other regulations emphasize that accessibility must be built into websites at the source. While accessibility overlays exist, they don't meet the detailed criteria of accessibility standards if the underlying website itself isn't accessible. They're therefore not an appropriate solution on their own.

Bitvtest.de has <a hreflang="de" href="https://bitvtest.de/test-methodik/web/beschreibung-des-pruefverfahrens#c761">recently decided</a> to stop testing and disallow their certification mark on websites that use an overlay tool. Bitvtest is a professional accessibility testing service built around the German BITV-Test, which is a structured way to check how accessible a website or app is.

## The Impact of Artificial Intelligence (AI)

Artificial intelligence (AI) is a broad field of computer science focused on building systems that can perform tasks that normally require human intelligence. Within this field, large language models (LLMs) are a specific kind of AI system trained on very large datasets to learn statistical patterns.

LLMs use these patterns to generate and transform text, answer questions, and follow instructions, but they don't have understanding or intent in a human sense. They predict likely words and sentences based on their training data.

Web accessibility tools increasingly rely on LLMs. Many platforms now offer AI-generated `alt` text as a way to address missing image descriptions, though the quality and accuracy of these automated solutions varies widely.

Developers are adding AI tools, like <a hreflang="en" href="https://github.com/github/accessibility-scanner">GitHub's Accessibility Scanner</a>, to their every day work. These tools give instant feedback and accessibility recommendations, making it easier to fix accessibility issues.

But AI in accessibility isn't without its problems.

Right now, there's no standard way to tell if AI made or improved a website or its content. This makes it harder to evaluate sites and leaves users in the dark about what they're looking at.

Some experts, like accessibility advocate Léonie Watson, talk about an "<a hreflang="en" href="https://tetralogical.com/blog/2025/08/08/accessibility-and-the-agentic-web/">agentic web</a>" where AI changes how we interact with content online. This raises questions about how accessibility standards need to adapt.

AI-powered browsers and extensions are becoming mainstream fast. Voice assistants and AI agents built into browsers might soon handle most of our basic information searches. People already have the option of choosing AI-generated answers over traditional search results. This shift could help or hurt accessible design. It all depends on whether these AI tools are themselves fully accessible.

Experts like Joe Dolson have explored whether <a hreflang="en" href="https://wpbuilds.com/accessibility/5/">AI can build fully accessible websites on its own</a>, highlighting both the potential and current limitations of the technology. Scott Vinkle's <a hreflang="en" href="https://scottvinkle.com/blogs/work/4-ways-i-use-ai-as-an-accessibility-specialist">experiences at Shopify</a> shows how AI can improve accessibility in real-world situations.

<a hreflang="en" href="https://www.a11y-collective.com/blog/artificial-intelligence-accessibility/">The A11Y Collective blog on Artificial Intelligence and Accessibility</a> points out that while AI tools that automate `alt` text or real-time captions, and voice assistants can help accessibility at scale, they still struggle with accuracy, context, privacy, and bias.

<a hreflang="en" href="https://dri.es/comparing-local-llms-for-alt-text-generation">Research by Dries Buytaert</a> shows AI can tackle huge backlogs of unlabeled images, but human review is still essential for quality. He explores the balance between quality, privacy, cost, and complexity for organizations considering AI-powered alt text.

<a hreflang="en" href="https://www.digitalaccesstraining.com/pages/articles?p=ai-and-accessibility-opportunities-and-challenges-for-content-creators">Digital Accessibility Training</a> outlines the opportunities and challenges of AI for content creators. AI tools enable accessibility features at scale but raise concerns about content validity, bias, and ethical usage.

Hidde de Vries <a hreflang="en" href="https://hidde.blog/ai-for-accessible-components/">contrasts how humans and language models approach accessible component code</a>. Humans base HTML, CSS, and ARIA decisions on specifications, user needs, assistive technology behavior, and platform quirks, all guided by intentions for the interface. LLMs instead predict likely code from training data, which is problematic because most existing code has accessibility issues, and the models lack intent or understanding of specific users.

Adrian Roselli acknowledges that recent advances in computer vision and LLMs have brought real benefits, such as better image descriptions and improved captions and summaries. However, he argues <a hreflang="en" href="https://adrianroselli.com/2023/06/no-ai-will-not-fix-accessibility.html">these tools still lack context and authorship</a>. They can't know why content was created, what a joke or meme depends on, or how an interface is meant to work. Their descriptions and code suggestions can easily miss the point or mislead users.

AI raises significant ethical concerns that go beyond accessibility.

{{ figure_markup(
  caption="Comparable number of gasoline cars for carbon emissions needed to train an LLM.",
  content="100",
  classes="big-number",
)
}}

One major issue is environmental impact. A <a hreflang="en" href="https://arxiv.org/ftp/arxiv/papers/2104/2104.10350.pdf">study on carbon emissions and large neural network training</a> estimated that training a single large language model such as GPT‑3 consumed more than 1,200 megawatt-hours of electricity and produced around 500–550 metric tons of CO₂-equivalent. This is comparable to the lifetime emissions of over 100 gasoline cars. For more information refer to the [Sustainability](./sustainability) chapter.

Another core concern is how training data is collected and used. Several <a hreflang="en" href="https://natlawreview.com/article/two-major-lawsuits-aim-answer-multi-billion-dollar-question-can-ai-train-your">high-profile lawsuits</a> allege that AI vendors scraped and used copyrighted material without permission or compensation. This included millions of stock photos and books.

<a hreflang="en" href="https://www.boia.org/blog/ethics-of-ai-in-accessibility-avoiding-bias-when-using-generative-ai-text">Studies</a> of large models show they can amplify ableist, racist, and other harmful biases present in their training data. This ultimately shapes how disability, race, and gender are described, reinforcing stigma at scale.

Looking forward, it's clear to us that AI will increasingly become a tool web developers and content creators rely on. However, AI should support human expertise, not replace it.

As these tools get better, the accessibility community needs to answer some important questions in 2026 and beyond:

- How do we check if AI-generated content is accurate and accessible?
- What standards should govern AI use in web content?
- How will assistive technologies work with AI-driven interfaces?
- Can AI provide equal accessibility while respecting individual needs?
- What ethical guidelines do we need to prevent AI from reinforcing bias or excluding people?

## Sectors and accessibility

This section compares accessibility scores across various industry and community sectors to identify patterns and leaders.

### Country

We can identify a website's country of origin either by the server's geographic location (GeoID) or by its Top-Level Domain (TLD). Both methods have limitations. Hosting costs, server location strategies, and domain ownership practices mean that a website's server may not reflect its target audience. Globally-used TLDs like `.ai` or `.io` aren't necessarily tied to their countries of origin.

{{ figure_markup(
  image="most-accessible-by-geoid-of-server.png",
  caption="Most Accessible by GeoID of Server",
  description="A table ranking countries by average accessibility score across their top-level domains, with the United States leading at 85.63%, followed closely by Canada (84.98%), the United Kingdom (84.96%), and Australia (84.59%). Germany (84.53%) and other European countries like the Netherlands (83.86%) and France (83.82%) also rank highly, while Asian countries like Japan (81.54%), South Korea (79.39%), and Taiwan (79.19%) score lower.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1913573905&format=interactive",
  sheets_gid="134589352",
  sql_file="lighthouse_score_by_country.sql",
  height=500
  )
}}

In 2025, the United States remains the most accessible country by GeoID, a position driven by decades of Section 508 compliance requirements for federal agencies and ongoing ADA Title III litigation. The `.edu` and `.gov` TLDs also lead accessibility metrics, reflecting mandatory compliance for U.S. government and educational institutions.

We also note the EU Accessibility Act's limited impact in 2025. While the Act became fully effective on June 28, 2025, mandating that private and public sector digital services be accessible across the European Union, preliminary data shows no dramatic spike in website accessibility for European-based sites.

This lag likely reflects implementation challenges, transitional periods for existing services, and the time required for organizations to redesign and audit their digital offerings.

Legal enforcement and the threat of litigation remain the strongest drivers of accessibility compliance, as evidenced by the United States' leading position. The full impact of newer European and global legislation may take years to manifest in web accessibility statistics, as organizations work through implementation timelines and transition periods.

We noticed a notable trend emerging in 2025. `.ai` domains appeared for the first time in accessibility rankings, now outperforming all TLDs except `.edu` and `.gov`. This likely reflects the growing adoption of AI-related businesses, many of which prioritize modern development practices, including accessibility.

Originally assigned to [Anguilla](https://en.wikipedia.org/wiki/Anguilla), a small Caribbean island, in 1995, the `.ai`TLD extension remained relatively obscure for nearly 15 years until 2009, when Anguilla opened direct registrations worldwide. The domain lay dormant for most of its history until the artificial intelligence boom of 2022 onward transformed it into one of the fastest-growing TLDs globally.

The catalyst came with the arrival of ChatGPT in late 2022, which sparked unprecedented interest in AI. Between July 2022 and July 2023, <a hreflang="en" href="https://domainwheel.com/ai-domains-statistics/">registered `.ai` domains skyrocketed</a> from 75,314 to 196,292, a 161% increase in just twelve months.

Geographically, North America drives the majority of `.ai` <a hreflang="en" href="https://techjury.net/industry-analysis/the-rise-of-ai-domains/">registrations</a> at 62.5%, with the United States alone accounting for 62.5% of all registered `.ai` domains. Asia follows at 18.8%, and Europe at 17.2%.

Many `.ai` domain holders are venture-backed, well-funded tech startups which are more likely to use AI. It's still up for debate whether AI can produce more accessible code than human teams, but this is one indicator.

Unlike older traditional companies using `.com` or `.org`, newer AI companies often build with contemporary web standards and tools that consider accessibility from the start. These companies that use an `.ai` domain and sell AI products are very likely to have involved AI in building their website, at least by consulting it for code or content, if not by using it in more automated agentic setups.

Traditional TLDs like `.com`, `.org`, `.net` don't rank as accessibility leaders. This suggests that domain type alone isn't a strong predictor of accessibility compliance.

{{ figure_markup(
  image="accessible-countries-by-top-level-domain-tld.png",
  caption="Accessible countries by Top Level Domain (TLD).",
  description="A bar chart ranking top-level domains (TLDs) by average accessibility score. Educational (.edu) and government (.gov) domains lead at 89.1% and 87.6%, followed by .ai (87.2%), .no (87.0%), and .fi (86.5%). Country-code TLDs like .ca (85.9%), .io (85.8%), .se (85.5%), .at (85.4%), and .uk (85.3%) also score highly, with general TLDs like .de (85.0%) and .co (84.6%) toward the lower end of the top 20.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=414356016&format=interactive",
  sheets_gid="1037208406",
  sql_file="lighthouse_score_by_tld.sql",
  width=600,
  height=480
  )
}}

The map of TLD ranking is very similar to 2024, but obviously doesn't include the increasing number of non-country specific TLDs now available.

{{ figure_markup(
  image="map-accessible-countries-by-tld.png",
  caption="Map of ccessible countries by Top Level Domain (TLD).",
  description="Displayed visually in a world map, the most accessible countries are Norway with 87%, Finland with 86%, followed by Canada, USA, UK, Sweden, Ireland, Australia, New Zealand, Austria, Belgium, Switzerland, Denmark, and South Africa. China is the least accessible by Top Level Domain, with close to 67%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1554186781&format=interactive",
  sheets_gid="1037208406",
  sql_file="lighthouse_score_by_tld.sql"
  )
}}

### Government

Government websites remain a critical arena for demonstrating public commitment to accessibility. But implementation varies dramatically across jurisdictions. The 2025 data reveals important trends in global government website accessibility, influenced by recent legislation, methodological changes in data collection, and enforcement mechanisms.

We used a different methodology this year to be able to assess a broader range of domains which fell outside of scans in 2024.

In 2024, we only sampled 79 domains from the government of the Netherlands. In 2025 we queried over 10 times that number with 957 domains. We similarly scanned about twice the number of domains for Luxembourg and Finland. The greater accuracy means we have a more comprehensive dataset, but also a more complex year-over-year comparison.

In the United Kingdom, we saw an improvement to 94% accessibility, up 2% from 2024. This reflects the benefits of standardized design systems, such as the <a hreflang="en" href="https://www.gov.uk/service-manual/service-standard">UK Government's Digital Service Standard</a>, which prioritizes accessibility across all public digital services. The Netherlands, Luxembourg, and Finland continue to lead, with the Netherlands achieving 98% in previous years. They have maintained this position through consistent governance frameworks and design system prioritization.

We also made an effort to include Scotland (gov.scot) and Wales (gov.wales). In 2025, we averaged from 19,568 domains, while in 2024 it was only 16,594.

Monitoring is a key part of prioritizing accessibility, and we applaud <a hreflang="en" href="https://observatoire.numerique.gouv.fr/observatoire">dashboards like the French Government's</a> which highlight progress on a number of website quality indicators, including accessibility. Much of the code behind this is open source. The Dutch government also has a <a hreflang="en" href="https://dashboard.digitoegankelijk.nl/">dashboard</a> that keeps track of almost 9.000 websites and applications. At the time of writing, 60% of all tracked web properties comply with legal requirements.

The <a hreflang="en" href="https://accessible-eu-centre.ec.europa.eu/accessibility-monitoring_en">Accessibility Monitoring Reports done by AccessibleEU</a> are important, but much more abstracted. The [Web Accessibility Directive](https://en.wikipedia.org/wiki/Web_Accessibility_Directive) in the EU requires member states to monitor and report accessibility compliance every 3 years. <a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/news/web-accessibility-directive-monitoring-reports-2022-2024">These reports</a> are publicly available.

The European Union's evolving regulatory landscape has significantly impacted government website accessibility in 2025.

The EU Web Accessibility Directive requires public sector organizations to meet specific technical standards. The broader European Accessibility Act (EAA), which became fully effective on June 28, 2025, extends requirements to private sector organizations in key sectors such as e-commerce, travel, and banking.

Despite this regulatory momentum, 2025 accessibility data shows no dramatic spike in European government website compliance, suggesting that implementation is still underway and the full impact may not be visible until 2026.

EU Member States are required to publish accessibility statements and provide feedback mechanisms for users to report barriers. <a hreflang="en" href="https://cerovac.com/a11y/2025/07/we-need-to-talk-about-your-accessibility-statement/">Accessibility statements</a> are an important part of the EU's Web Accessibility Directive, but as yet, we don't have a good way to include them in the site scans. The Funka Foundation has reminded us of the <a hreflang="en" href="https://www.linkedin.com/pulse/yes-nordics-score-well-lets-think-one-step-further-funkafoundation-yczzf/">limitations of this type of testing for compliance</a>.

{{ figure_markup(
  image="most-accessible-national-government.png",
  caption="Most accessible national government.",
  description="A bar chart ranking national government domains by average accessibility score. The United Kingdom leads at 94.31%, followed closely by the Netherlands (93.81%), Finland (93.77%), Norway (93.49%), and Sweden (93.37%). Several other European and Commonwealth governments, including Singapore, Denmark, Luxembourg, the European Union, Australia, Austria, Belgium, Iceland, New Zealand, and Ireland, also score at or above 90%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=940831164&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

The map of 2025 is almost indistinguishable from 2024.

{{ figure_markup(
  image="map-accessibility-global-government-websites.png",
  caption="Map of the accessibility of global government websites.",
  description="The map illustrates visually the most accessible government websites around the world. Scandinavian countries stand out as do many in Europe. Australia and New Zealand are highlighted in the Pacific. Canada is slightly darker than the United States.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1960560393&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

In the United States, state government compliance remains inconsistent despite new federal mandates. The Department of Justice's (DOJ) final rule on Title II of the Americans with Disabilities Act, published in June 2024, requires all state and local government entities to achieve WCAG 2.1 AA compliance by specific deadlines: April 26, 2026, for entities serving populations of 50,000 or more, and April 26, 2027, for smaller entities.

States like Colorado and Vermont have excelled by establishing centralized governance structures. <a hreflang="en" href="https://sipa.colorado.gov/">Colorado's Statewide Internet Portal Authority</a> (SIPA) demonstrates how centralized management improves accessibility across multiple agencies.

Nevada, Kansas, California, and New York did well in the samples from both years. But the averages don't indicate that state governments made any significant progress in achieving the new requirements from the <a hreflang="en" href="https://www.justice.gov/archives/opa/pr/justice-department-publish-final-rule-strengthen-web-and-mobile-app-access-people">2024 US Department of Justice Final Rule to Strengthen Web and Mobile App Access</a>. State technology leaders at the National Association of State Chief Information Officers (NASCIO) national conference <a hreflang="en" href="https://statescoop.com/accessibility-nascio-state-priority-2025/">reaffirmed accessibility as a top priority</a>.

The Americans with Disabilities Act (ADA), which <a hreflang="en" href="https://www.access-board.gov/news/2025/07/21/celebrating-35-years-of-americans-with-disabilities-act/">turned 35 in July</a>, was pioneering work that set a precedent globally.

<a hreflang="en" href="https://archive.opengovasia.com/2025/03/11/digital-accessibility-singapores-commitment-to-inclusivity/?c=ca">Singapore's recent commitment to accessibility</a> improvement, demonstrated through the open source tool <a hreflang="en" href="https://github.com/GovTechSG/oobee">Oobee</a>, shows emerging global momentum. Oobee allows organizations to scan hundreds of pages and generate consolidated accessibility reports, positioning it as a <a hreflang="en" href="https://www.digitalpublicgoods.net/r/oobee">Digital Public Good</a>.

{{ figure_markup(
  image="most-accessible-us-state-governments.png",
  caption="The most accessible US state governments.",
  description="A bar chart ranking US state and territory government sites by average accessibility score. New Hampshire leads at 94.61%, followed by Nevada (92.43%), Kansas (91.67%), New York (91.45%), and South Carolina (91.07%). Many other states, including Arizona, California, Missouri, Montana, and North Carolina, also score around 90% or higher, while states like New Jersey (83.91%) and Rhode Island (83.31%) appear toward the lower end of the list.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=445029634&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql",
  width=600,
  height=500
  )
}}

### Content Management Systems (CMS)

A website's choice of Content Management System (CMS) significantly influences its accessibility outcomes. Using <a hreflang="en" href="https://almanac.httparchive.org/en/2024/methodology#wappalyzer">Wappalyzer</a> data, the 2025 Web Almanac compared accessibility scores across traditional CMSs, platforms, and specialized website builders. This revealed both consistent patterns and notable outliers.

{{ figure_markup(
  image="most-accessible-traditional-cms.png",
  caption="Most accessible traditional CMS.",
  description="A bar chart ranking traditional content management systems (CMSs) by average accessibility score. Contentful and Adobe Experience Manager lead with scores of 88.28% and 88.26%, followed by WordPress (85.58%), Contao (85.29%), Drupal (85.22%), and Craft CMS (85.13%). TYPO3 CMS, Odoo, DNN, and Joomla round out the list with scores ranging from 84.71% down to 82.11%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=2137638034&format=interactive",
  sheets_gid="419466395",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

Among traditional CMSs, <a hreflang="en" href="https://www.sitecore.com/">Sitecore</a> maintained 85% accessibility in 2025, though its instance count dropped below 10,000. <a hreflang="en" href="https://business.adobe.com/products/experience-manager/sites/aem-sites.html">Adobe Experience Manager (AEM)</a> and <a hreflang="en" href="https://www.contentful.com/">Contentful</a> continue to lead, likely because larger corporations adopting these enterprise solutions have more resources to address accessibility issues. <a hreflang="en" href="https://wordpress.com/">WordPress</a> showed no significant improvement from 2024, but rose to third place, reflecting its market dominance and the growing accessibility consciousness of its user base.

Remarkably, the top five traditional CMSs share consistent error patterns. Color contrast, link names, and heading order dominate as the most common issues. These errors primarily reflect content choices rather than platform limitations, since a CMS can't dictate link naming or color selections. However, AEM stands alone with `label-content-name-mismatch` in its top-five errors. WordPress is unique in having `meta-viewport` errors.

In the top 10 CMS, only <a hreflang="en" href="https://www.dnnsoftware.com/">DNN</a> has `image-alt` in the top 3 errors. For most traditional CMSs, `image-alt` and `target-size` are consistently in the fourth or fifth place for Google Lighthouse errors.

{{ figure_markup(
  image="most-accessible-website-platform-cms.png",
  caption="Most accessible website platform CMS.",
  description="A bar chart ranking website platform content management systems (CMSs) by average accessibility score. Wix leads with an average score of 94.19%, followed by Squarespace (93.05%), WebNode (91.44%), and Google Sites (90.10%). Other platforms such as Webflow, HubSpot CMS Hub, Shopify, Framer Sites, Duda, and Weebly also show strong performance, with scores ranging from 89.07% down to 85.80%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=408491967&format=interactive",
  sheets_gid="419466395",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform CMS</th>
        <th>Most popular</th>
        <th>Second most</th>
        <th>Third most</th>
        <th>Fourth most</th>
        <th>Fifth most</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a hreflang="en" href="https://www.wix.com/">Wix</a></td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>color-contrast</td>
        <td>button-name</td>
        <td>target-size</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.squarespace.com/">Squarespace</a></td>
        <td>color-contrast</td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>label-content-name-mismatch</td>
        <td>frame-title</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.webnode.com/">Webnode</a></td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>frame-title</td>
        <td>color-contrast</td>
        <td>image-redundant-alt</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://workspace.google.com/products/sites/">Google Sites</a></td>
        <td>image-alt</td>
        <td>link-name</td>
        <td>aria-allowed-attr</td>
        <td>heading-order</td>
        <td>color-contrast</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://webflow.com/">Webflow</a></td>
        <td>link-name</td>
        <td>color-contrast</td>
        <td>heading-order</td>
        <td>html-has-lang</td>
        <td>target-size</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top accessibility audit issues for popular CMS platforms.",
      sheets_gid="419466395",
      sql_file="lighthouse_score_by_cms.sql"
      )
    }}
  </figcaption>
</figure>

Website platforms like Wix, Squarespace, and Google Sites significantly outperform traditional CMSs in accessibility. This superior performance likely stems from their approach. These platforms often constrain user choices through templated designs and built-in accessibility defaults, reducing opportunities for poor accessibility decisions.

The data proves that CMS choice meaningfully impacts accessibility outcomes, even when content creators must take final responsibility for some decisions. Platforms with stricter design constraints and embedded accessibility defaults perform better, while those offering maximum flexibility leave accessibility decisions to users.

### JavaScript frontend frameworks

The choice of JavaScript framework also significantly influences a website's accessibility outcomes. Using classifications from the <a hreflang="en" href="https://stateofjs.com/en-US">State of JS report</a>, we examined how different UI frameworks and meta-frameworks correlate with accessibility performance. This revealed patterns, shifts, and emerging concerns.

{{ figure_markup(
  image="most-accessible-javascript-frontend-ui-frameworks.png",
  caption="Most Accessible JavaScript Frontend UI Frameworks.",
  description="A bar chart ranking JavaScript frontend UI frameworks by average accessibility score. Qwik leads with an average score of 91.86%, followed by Stimulus (91.42%) and OpenUI5 (90.23%). Astro (89.22%), Next.js (88.05%), Remix (87.61%), React (87.56%), Ember.js (86.72%), Alpine.js (85.91%), Angular (85.63%), and Preact (85.28%) also achieve relatively high accessibility scores.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=430687243&format=interactive",
  sheets_gid="1977955459",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

In 2025, <a hreflang="en" href="https://openui5.org/">OpenUI5</a> has risen in accessibility rankings, while frameworks that led in 2024 (<a hreflang="en" href="https://stimulus.hotwired.dev/">Stimulus</a>, <a hreflang="en" href="https://remix.run/">Remix</a>, and <a hreflang="en" href="https://qwik.dev/">Qwik</a>) have shifted positions. Remix appears in both UI and meta-framework categories, but has declined in rankings in 2025, allowing other frameworks to advance. This volatility may reflect sample size changes or real improvements in competing frameworks. The fact that all Remix functionality was integrated right into the next version of <a hreflang="en" href="https://reactrouter.com/">React Router</a>, making Remix redundant as a React framework, can also have an impact on rankings.

Historically, Stimulus, Remix, and Qwik outperformed mainstream options like React, <a hreflang="en" href="https://svelte.dev/">Svelte</a>, or <a hreflang="en" href="http://Ember.js">Ember.js</a> by several percentage points, likely because they prioritize progressive enhancement and semantic HTML.

Among meta-frameworks, Remix, <a hreflang="en" href="https://rwsdk.com/">RedwoodJS</a>, and <a hreflang="en" href="https://astro.build/">Astro</a> led in 2024, with Remix's decline allowing <a hreflang="en" href="https://www.gatsbyjs.com/">Gatsby</a> to rise to third place in 2025. The rise of server-first meta-frameworks (SvelteKit, Astro, Remix, Qwik, <a hreflang="en" href="https://fresh.deno.dev/">Fresh</a>, <a hreflang="en" href="https://analogjs.org/">Analog</a>) reflects a broader industry shift toward better performance and accessibility practices by reducing client-side JavaScript complexity.

The choice of library also has an impact on accessibility.

React offers maximum flexibility and customization, but requires developers to intentionally implement accessibility. Its extensive ecosystem includes accessibility-focused libraries like <a hreflang="en" href="https://react-spectrum.adobe.com/react-aria/index.html">React Aria</a> and <a hreflang="en" href="https://reach.tech/">Reach UI</a>, but accessibility isn't enforced by default.

<a hreflang="en" href="https://angular.dev/">Angular</a> provides strong built-in accessibility features, structured conventions that promote semantic HTML, ARIA attribute support, and <a hreflang="en" href="https://material.angular.io/">Material Design</a> components with keyboard navigation and screen reader support out-of-the-box. Angular's opinionated structure tends to guide developers toward more standardized, accessible practices.

<a hreflang="en" href="http://Vue.js">Vue.js</a> aims to strike a balance between React's flexibility and Angular's structure. Vue's progressive design, clear template syntax, and component architecture support accessibility, though it relies more on developer discipline and third-party plugins like <a hreflang="en" href="https://github.com/vue-a11y">vue-a11y</a>.

We also note that <a hreflang="en" href="https://github.blog/open-source/social-impact/our-pledge-to-help-improve-the-accessibility-of-open-source-software-at-scale/">GitHub took the Global Accessibility Awareness Day (GAAD) pledge</a> to improve open source accessibility at scale. This commitment addresses a critical gap: 90% of companies use open source, 97% of codebases contain open source components, and an estimated 70–90% of code within commercial tools derives from open source.

{{ figure_markup(
  image="most-accessible-javascript-meta-frameworks.png",
  caption="Most Accessible JavaScript Meta-frameworks.",
  description="A bar chart ranking JavaScript meta-frameworks by average accessibility score. RedwoodJS leads with an average score of 92.38%, followed by Astro (89.22%), Gatsby (88.20%), Next.js (88.05%), and Remix (87.61%). Nuxt.js, AdonisJS, Quasar, and Meteor complete the list, with scores ranging from 84.52% down to 79.91%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=208297617&format=interactive",
  sheets_gid="1977955459",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

RedwoodJS remains the most accessible, followed by Astro and Gatsby.

## Conclusion

The 2025 Web Almanac accessibility analysis reveals a year of incremental progress, tempered by significant challenges and missed opportunities.

Automated testing remains essential for assessing accessibility at scale. But the data demonstrates that <a hreflang="en" href="https://www.a11y-collective.com/blog/how-to-check-web-accessibility/">measurement alone doesn't guarantee meaningful improvement</a>. The web community must move beyond basic compliance metrics to address the systemic issues that continue to exclude millions of users with disabilities.

The most notable improvements in 2025 emerged in sectors and regions where regulatory pressure and enforcement mechanisms are strongest. However, the lack of dramatic improvement following the European Accessibility Act's June 28, 2025, deadline is instructive. The full impact may not be apparent until 2026 and beyond.

The rapid rise of the `.ai` domain to among the most accessible TLDs reflects an important pattern. Newer, venture-backed technology companies tend to build with modern accessibility practices from the start, whereas legacy websites often remain inaccessible. This proves that accessibility is achievable when prioritized early in development.

Despite improvements in specific areas, the core accessibility barriers identified in 2024 persist largely unchanged in 2025.

Color contrast, link naming, heading hierarchy, and image `alt` text remain the top four issues across nearly every platform and framework. These aren't failures directly of the tool, but how the authors use them. Authors have some role in all of these failures according to the W3C's <a hreflang="en" href="https://www.w3.org/WAI/planning/arrm/tasks/">Accessibility Roles and Responsibilities Mapping (ARRM)</a>.

This reality reveals a critical insight. CMS platforms, JavaScript frameworks, and web technologies can provide accessibility foundations, but they can't force content creators to make accessible choices. Approaches like the <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/atag/">Authoring Tool Accessibility Guidelines (ATAG) 2.0</a> and the new W3C <a hreflang="en" href="https://www.w3.org/community/atag/">ATAG Community Group</a> could help.

The 2025 metrics suggest stagnation where we expected incremental improvement, highlighting the gap between what's easy to measure and what's easy to fix.

The continued rise of accessibility overlays (now on 2% of sites) is concerning. It seems that organizations often choose shortcuts over genuine accessibility. The IAAP and European Disability Forum have explicitly warned that overlays can interfere with users' assistive technology and must never replace accessible design. The 2025 data confirms overlays remain concentrated in lower-traffic sites, a sign that high-quality, well-resourced organizations are moving away from them toward real solutions.

The 2025 data underscores that automation is necessary but insufficient. Lighthouse and similar tools detect easily measurable violations, yet 50% of images on the web have empty or inadequate `alt` text. Heading hierarchy can be audited, but semantic meaningfulness requires human judgment. Color contrast can be checked, but visual design choices involve subjective artistic decisions informed by accessibility requirements.

Our 2025 findings reveal a web that remains largely inaccessible for millions of people with disabilities.

While incremental improvements in specific areas offer encouragement, persistent gaps in color contrast, link naming, heading structure, and image descriptions demonstrate that the web community hasn't yet made accessibility a genuine priority.

The rise of `.ai` domains, GitHub's open source pledge, and regulatory deadlines like the EU Accessibility Act and ADA Title II final rule offer hope that 2026 may see more substantial change. That's only if organizations move beyond measurement to accountability, from rhetoric to resources, and from compliance to genuine inclusion.

The web should work for everyone. Until that principle guides our design, development, and deployment decisions, the accessibility gaps documented in this report will persist.
