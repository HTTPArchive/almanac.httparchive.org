---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Accessibility
description: Accessibility chapter of the 2024 Web Almanac covering ease of reading, navigation, forms, media, ARIA, and accessibility apps.
hero_alt: Hero image of a robot with a blue, human accessibility icon on its front scanning a web page, while Web Almanac characters check some labels.
authors: [mgifford]
reviewers: [hidde, b_atish, katekalcevich]
analysts: [mgifford]
editors: [JonathanPagel, JonathanAvila, shantsis]
translators: []
discuss:
results: https://docs.google.com/spreadsheets/d/1btB1r9QpdgTyToPhn7glcGAdMFs7eq4UcQSVIHBqiYQ/
mgifford_bio: Mike Gifford is CivicActions' Open Standards & Practices Lead. He is also a thought leader on open government, digital accessibility and sustainability. He has served as a Drupal Core Accessibility Maintainer and also a W3C Invited Expert. He is a recognized authoring tool accessibility expert and contributor to the W3C's Draft Web Sustainability Guidelines (WSG) 1.0.
featured_quote: Most modern governments have committed to either WCAG 2.0 AA or WCAG 2.1 AA. It is clear that the implementation of these policies isn't being equally delivered.
featured_stat_1: 40%
featured_stat_label_1: Of desktop sites and 39% of mobile sites have at least one `role="presentation"`.
featured_stat_2: 0.1%
featured_stat_label_2: Sites with `<audio>` elements include a `<track>` element.
featured_stat_3: 57%
featured_stat_label_3: Mobile sites passing the Lighthouse audit for properly ordered headings.
doi: 10.5281/zenodo.14063775
---

## Introduction

The web is continuing to change. Voice assistants like Siri, Alexa, and Cortana often provide responses by reading from web pages using screen reader technology. Similar methods have been around since the <a hreflang="en" href="https://www.theverge.com/23203911/screen-readers-history-blind-henter-curran-teh-nvda">early days of personal computing</a>. Captions (sometimes referred to as subtitles) were created for people who are hard of hearing, but are increasingly [used for convenience](https://wikipedia.org/wiki/Subtitles#Use_by_hearing_people_for_convenience) by everyone, and the vibration mode of the smartphone is now a standard feature.  Other groups that enjoy using captions include individuals with ADHD, who use them to maintain focus, non-native speakers, who rely on them to enhance language comprehension, and people in noisy environments, where spoken content might be easily missed.

Modern devices and platforms offer many options for accessibility. These help to personalize the user experience for both people with disabilities as well as the general public. But not many people open the accessibility menu to try them out.

Good accessibility is beneficial to everyone, not just those with disabilities. This is a fundamental principle of <a hreflang="en" href="https://universaldesign.ca/principles-and-goals/">Universal Design</a>. As Tim Berners-Lee stated: <a hreflang="en" href="https://www.w3.org/WAI/fundamentals/accessibility-intro/">"The power of the Web is in its universality. Access by everyone regardless of disability is an essential aspect."</a> The COVID-19 pandemic made it clear that improving accessibility for digital interfaces can no longer be perceived as optional. It is increasingly hard to navigate the real world without reliable access to the virtual world.

<a hreflang="en" href="https://inclusive.microsoft.design/">Microsoft's Inclusive Design Guidelines</a> go beyond permanent disability scenarios and extend them to temporary or situational limitations. Human abilities vary. No matter if a person has lost an arm (permanent), or is wearing a cast because of an accident (temporary) or holding a baby (situational limitation), being able to use the computer or phone with one hand or voice interaction benefits them.

{{ figure_markup(
  image="microsoft-inclusivity-gudelines.png",
  alt="Microsoft's Inclusive Design illustration.",
  caption='Microsoft\'s Inclusive Design illustration.<br>This image and approach is courtesy of their <a hreflang="en" href="https://inclusive.microsoft.design/tools-and-activities/Inclusive101Guidebook.pdf">Inclusive 101 Guidebook</a>.',
  description="Microsoft's Inclusive Design illustration focusing on disability scenarios—permanent (one arm), temporary (arm injury) and situational (new parent).",
  width=404,
  height=658
  )
}}

Governments worldwide recognize that digital accessibility is not only a moral obligation but also in many instances legally required. Accessibility is also great for commerce and democracy. For example, the European Union (EU) mandates that by June 2025, websites in a wide range of sectors must adhere to the <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Web Content Accessibility Guidelines (WCAG)</a> principles (via the [EN 301 549](https://wikipedia.org/wiki/EN_301_549) standard). This will ultimately allow more people to buy and sell services in the EU. Other countries passed similar laws, which increase the pressure on organizations to make their virtual offerings more accessible.

Standards referenced in legislation like EN 301 549 and <a hreflang="en" href="https://www.section508.gov/manage/laws-and-policies/">Section 508</a> are based on the Web Content Accessibility Guidelines, and the automated accessibility tests used in this report can only test against some parts of the guidelines. Our tests leverage the open source tool, <a href="https://developer.chrome.com/docs/lighthouse/accessibility/scoring">Google Lighthouse</a>, which in turn uses <a hreflang="en" href="https://github.com/dequelabs/axe-core">Deque's open source axe-core</a>.

There is a lot of updated information on our [report from previous years](../2022/accessibility). It is useful to track changes over time, and note where change occurs. We also wanted to introduce a new section about different sectors and web accessibility. Through our analysis we can track CMS's, JavaScript frameworks, and evaluate the average accessibility of different technologies. We can also compare the accessibility of different countries and governments and track how it changes over time.

Despite ongoing challenges, there has been noticeable improvement in web accessibility. The median score for Lighthouse Accessibility audits rose to 84% over the past two years. In WCAG 2.2, the 4.1.1 Success criteria was removed. <a hreflang="en" href="https://www.deque.com/blog/wcag-2-2-removes-4-1-1-parsing-and-how-axe-core-is-impacted/?_gl=1*1yzu5tn*_up*MQ..*_ga*MTY0NDE2MjY4LjE3MjY3NTI0NTg.*_ga_C9H6VN9QY1*MTcyNjc1MjQ1Ny4xLjAuMTcyNjc1MjQ1Ny4wLjAuMA..">Deque therefore removed <code>duplicate-id</code> and <code>duplicate-id-active</code> audits from axe</a>, and so this was no longer included in our scan. These depreciated axe rules impacted millions of sites surveyed in our 2022 report. There were also <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/">new Success Criteria added in 2.2</a> added with corresponding tests being <a hreflang="en" href="https://www.deque.com/blog/axe-core-4-5-first-wcag-2-2-support-and-more/">added to axe-core</a>.

Accessibility scores are an important tool, but people familiar with [Goodhart's Law](https://wikipedia.org/wiki/Goodhart%27s_law) will know the danger of a measure becoming a target. We must also acknowledge that automated tests <a hreflang="en" href="https://www.smashingmagazine.com/2022/11/automated-test-results-improve-accessibility/#automate-it">can only address a portion</a> of the WCAG Success Criteria, and that <a hreflang="en" href="https://www.matuzo.at/blog/building-the-most-inaccessible-site-possible-with-a-perfect-lighthouse-score">a perfect score does not guarantee an accessible site</a>.

{{ figure_markup(
  image="lighthouse-audit-median-score-yoy.png",
  caption="Lighthouse audit improvements year-over-year.",
  description="A bar chart showing the average increase in accessibility over time for five years the Median Google Lighthouse score for accessibility. Values increase slowly year by year, as follows: 2019 (83%), 2020 (80%), 2021 (82%), 2022 (83%) and 2024 (84%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=837866368&format=interactive",
  sheets_gid="255848343",
  sql_file="lighthouse_a11y_score.sql"
  )
}}

We can similarly see an increase in the median Lighthouse score by page rank with an increase in the percentage of pages evaluated. It is a smaller improvement than it was between 2020 and 2021 and the 2023 Web Almanac wasn't produced, so there is a 1% increase for two years. However, it is also worth noting that the Lighthouse score is leveraging axe, which has increased its tests to align more with <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/">WCAG 2.2</a>.

Looking at the most common errors with most improved Lighthouse tests, it is possible to see which parts of the Lighthouse audit improved the most. Although far from perfect, we are seeing advancements.

{{ figure_markup(
  image="lighthouse-audit-markup-improvements.png",
  caption="Most improved Lighthouse accessibility tests (axe).",
  description="A bar chart showing how many sites pass 5 specific Lighthouse audits, in 2022 and 2024. `aria-allowed-attr` passes on 82% of sites in 2022, and 95% in 2024. `aria-input-field-name` passes on 14% of sites in 2022, and 21% in 2024. `aria-progressbar-name` passes on 3% of sites in 2022, and 14% in 2024. `color-contrast` passes on 23% of sites in 2022, and 29% in 2024. `frame-title` passes on 36% of sites in 2022, and 51% in 2024.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=899104036&format=interactive",
  sheets_gid="1279863228",
  sql_file="lighthouse_a11y_audits.sql"
  )
}}

Google Lighthouse now contains <a href="https://developer.chrome.com/docs/lighthouse/accessibility/scoring">57 different audit tests</a> which they use for their scoring. These are all based on Deque's <a hreflang="en" href="https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md">open source axe-core</a>, which is widely adopted in a range of accessibility products and services. With the exception of 7 audits (`aria-meter-name`, `aria-toggle-field-name`, `aria-tooltip-name`, `document-title`, `duplicate-id-active`, `html-lang-valid`, and `object-alt`) there have been improvements across the board. Both `object-alt` and `aria-tooltip-name` were called out for their improvements in 2022, but sadly this improvement was not repeated in 2024.

Throughout this chapter, we have included actionable links and solutions that readers can apply and follow in their own accessibility initiatives. For the sake of consistency, we opted to use the person-first language "people with disabilities" throughout, though we recognize that the identity-first term "disabled people" is also widely used. Our terminology choice is not intended to suggest which term is more appropriate.

## Ease of Reading

Readability of information and content on the web is crucial. There are different factors in a website that contribute to the content's readability. Taking these aspects into account ensures that everyone on the internet can easily consume the content. This report covers those things which can be measured, and although plain language is critical to readability, it is not easy to measure. There are fairly straightforward mathematical readability scores, like [Flesch–Kincaid](https://wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests). Some people use it to [determine readability](https://wikipedia.org/wiki/Readability) in English, but the web is global. Language is difficult, and there is no agreed-to standard for automated plain language testing that can be applied even across the most popular languages.

### Color Contrast

Color contrast refers to the difference between the foreground and background colors of elements on a page that enables users to see the content. It is very common for websites to have insufficient contrast on key elements like text and icons, despite WCAG making it quite clear how to comply with contrast guidelines.

The <a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum">minimum contrast requirement</a> defined by the WCAG for normal sized text (up to 24px or if bolded 18px) is 4.5:1 for AA conformance and 7:1 for AAA conformance. However, for larger font sizes, the contrast requirement is only 3:1 as larger text has increased legibility even at a lower contrast.

Google Lighthouse can easily test for most but not all color contrast issues. There are a wide range of <a hreflang="en" href="https://accessibility.civicactions.com/guide/tools#color">open source tools for checking color combinations</a> which can be easily incorporated into anyone's workflow. It is important to note that the use of these tools is necessary, as you can't rely on your own perception of sufficient contrast when you have typical contrast sensitivity.

The Lighthouse test determined that 29% of mobile sites and 28% of desktop sites have sufficient text color contrast. This is a moderate improvement over previous years, but it is still far below what is required for basic readability.

{{ figure_markup(
  image="color-contrast-2019-2020-2021-2022-2024.png",
  caption="Sites with sufficient color contrast.",
  description="A bar chart showing gradual progress in color contrast. 22% of mobile sites had sufficient color contrast in 2019, dipping slightly to 21% in 2020 and increasing slightly to 22% for 2020, increasing more to 23% in 2022, 2024 saw a big jump to 29% for mobile. Desktop sites in 2022 were at 23% and in 2024 rose to 28%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=476448992&format=interactive",
  sheets_gid="985048008",
  sql_file="color_contrast.sql"
  )
}}

Color contrast becomes more <a hreflang="en" href="https://www.nia.nih.gov/health/vision-and-vision-loss/aging-and-your-eyes">important as we age</a>. It is also something which regularly is an issue for <a hreflang="en" href="https://inclusive.microsoft.design/">temporary disabilities and situational limitations</a>, such as when people don't have their reading glasses or need to read content outside.  Achieving appropriate contrast is becoming more challenging as browsers and operating systems have implemented support for light, dark, and high-contrast modes. These are well supported by browsers and operating systems, but not yet well supported by most websites. There is a growing demand for sites to follow a user's set preference, and multiple types of disabilities can benefit from giving users this control. See the User preferences section below for more information.

### Zooming and scaling

More than ever, users are engaging with websites with a variety of technologies from super-wide curved screens to mobile phones and even watches. Disabling scaling takes away user agency to define what works best for them. <a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/resize-text">WCAG requires</a> that text in a website must be resizable up to at least 200% without any loss in content or functionality.

We're revisiting <a hreflang="en" href="https://adrianroselli.com/2015/10/dont-disable-zoom.html">Adrian Roselli's post</a>, which we previously highlighted in 2022, to emphasize the importance of not disabling zoom functionality, as many still don't fully understand the reasons behind it.

{{ figure_markup(
  image="pages-zooming-scaling-disabled.png",
  caption="Pages with zooming and scaling disabled.",
  description="A bar chart showing data on disabled zooming for desktop and mobile. 14% of desktop sites and 16% of mobile sites disable scaling, 18% and 20% respectively set a max scale of 1 and 20% and 23% use either.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1480116719&format=interactive",
  sheets_gid="1937244738",
  sql_file="viewport_zoom_scale.sql"
  )
}}

We are happy to say that we are seeing a reduction in sites which are disabling zooming and scaling.  Compared with 2022's data for mobile users there are 2% less sites who have disabled scaling and 4% that have disabled a max scale of 1. The desktop average both went down by 2% compared to the last report. Users can configure their browsers to override this setting, but some defaults still respect the author's preferences.

To check if your site has disabled or limited zoom look at the source of the page and search for `<meta name="viewport">` if it is tagged with a maximum-scale, minimum-scale, user-scalable=no, or user-scalable=0. Ideally, there wouldn't be any restrictions for content resizing, but WCAG only specifies the need for <a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-scale.html#:~:text=Content%20satisfies%20the%20Success%20Criterion%20if%20it%20can,more%20extreme%2C%20adaptive%20layouts%20may%20introduce%20usability%20problems.">200% magnification</a>.

{{ figure_markup(
  image="font-unit-usage.png",
  caption="Font unit usage.",
  description="A bar chart showing px is used for font sizes on 65% of desktop and 66% of mobiles pages. em on 9% on both. rem on 4% of both, % on 4% of desktop and 5% of mobile, `<number>` on 2% of both, and finally pt on 15% on desktop and 14% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=655410508&format=interactive",
  sheets_gid="806505055",
  sql_file="units_properties.sql"
  )
}}

How font sizes are defined also affects the readability, as pixels are not as flexible as other units. Pixel (px) use is 65% in desktop and 66% in mobile. The use of em has increased to 9% from 6% in 2022. rem was at 6% in 2022, and has reduced to 4% now. There is not a significant increase in the use of em or rem since 2022, even though it often <a hreflang="en" href="https://www.freecodecamp.org/news/css-units-when-to-use-each-one/">gives the user a better experience</a> when they increase or decrease their font size in their browser settings.

### Language identification

Identifying language with the lang attribute enhances screen reader support and facilitates automatic browser translations. This feature benefits all users. For instance, without the lang attribute, Chrome's automatic translation feature may produce inaccurate translations. Manuel Matuzović provides an example of <a hreflang="en" href="https://www.matuzo.at/blog/lang-attribute/">how missing lang attributes can lead to translation errors</a>. The lang attribute is also helpful when <a hreflang="en" href="https://chenhuijing.com/blog/css-for-i18n/">styling web pages for different languages and reading directions</a>, as Chen Hui-Jing points out.

{{ figure_markup(
  caption="Mobile sites have a valid lang attribute.",
  content="86%",
  classes="big-number",
  sheets_gid="559595084",
  sql_file="valid_html_lang.sql"
)
}}

It's promising to note that in 2022, 83% of mobile websites included a lang attribute, and two years later it is at 86%. However, since this is a Level A conformance issue under WCAG, there is still room for improvement. To meet this criterion, the lang attribute should be added to the `<html>` tag with a recognized <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/act/rules/bf051a/#known-primary-language-tag">primary language tag</a>. Properly defining the language is crucial. Sometimes, when a template is copied to create a new website, discrepancies can arise between the language of the content and the language attribute (lang="en") in the code.

Also, keep in mind that there is the page language, but pages often contain multiple languages within them. The lang attribute can also be applied to other tags if the page contains multiple languages. The W3C has good documentation on <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/language-of-parts.html">how to address the Language of Parts</a>.

### User preference

Modern CSS includes <a hreflang="en" href="https://www.w3.org/TR/mediaqueries-5">Level 5 Media Queries</a>, which include <a hreflang="en" href="https://12daysofweb.dev/2021/preference-queries/">User Preference Media Queries</a>.  User Preference Media Queries enhance accessibility by allowing users to select configurations that work for them. This includes choices like color schemes or contrast modes that suit individual preferences, such as dark mode. Users can also choose to minimize animations on a page, which is beneficial for users with vestibular disorders.

{{ figure_markup(
  image="userpreference-media-queries.png",
  caption="User preference media queries.",
  description="A bar chart showing that 49% of desktop sites and 50% of mobile sites use the `prefers-reduced-motion` media query, 12% of sites use `prefers-color-scheme`, and `prefers-contrast` is used by just under 1% of desktop and mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=570596768&format=interactive",
  sheets_gid="1665700473",
  sql_file="media_query_features.sql"
  )
}}

We discovered that over 50% of mobile sites include the `prefers-reduced-motion` media query, up from 34% in 2022. This is important because <a hreflang="en" href="https://kb.iu.edu/d/bizw">digital animations can harm individuals with vestibular disorders</a>; using this query allows for adapting or removing such animations to improve accessibility. Mozilla's Developer community has some good resources on <a href="https://developer.mozilla.org/docs/Web/CSS/@media/prefers-reduced-motion">building motion-sensitive sites</a>.

The [Sustainability](./sustainability) chapter has some great statistics on the rise in the use of animations, and the impact on digital sustainability.

For contrast, only 12% of desktop and mobile websites utilize the `prefers-color-scheme` media query, which is up from 8% in 2022. To enhance content readability it is a good practice to allow your users to adjust display modes. The prefers-color-scheme query enables browsers to detect the user's preferred color scheme, supporting light and dark modes. The `prefers-contrast` query is valuable for users with low vision or photosensitivity by enabling high contrast modes.

Support for <a href="https://developer.mozilla.org/docs/Web/CSS/@media/forced-colors"><code>forced-contrast</code></a> increased about 4% in 2024 to 14% for desktop. Forced Colors Mode is an accessibility feature designed to enhance text readability through improved color contrast. When activated, the user's operating system takes control of most color-related styles, overriding website color settings. This mode disables common patterns like background images to ensure more predictable text-to-background contrast.

The most well-known implementation is Windows' High Contrast Mode, now called <a hreflang="en" href="https://support.microsoft.com/en-us/topic/fedc744c-90ac-69df-aed5-c8a90125e696">Contrast Themes</a>. These themes offer alternative color palettes with low and high contrast options, and allow users to customize the system colors to their preference. Use of `-ms-high-contrast` has decreased slightly in 2024 to about 23%. This can be emulated in <a hreflang="en" href="https://blogs.windows.com/msedgedev/2024/04/29/deprecating-ms-high-contrast/">Edge</a> and <a href="https://developer.chrome.com/docs/devtools/rendering/emulate-css/">Chrome</a>, so it is now easier to test.

## Navigation

When discussing website navigation, it's crucial to recognize that users may employ a range of methods and input devices. Some might use a mouse to scroll, while others may rely on a keyboard, switch control device, or screen reader to navigate through headings. When designing a website, it's essential to ensure it functions effectively for all users, regardless of the device or assistive technology they use. Wide-screen TV's and voice interfaces (like Siri and Amazon Alexa) both place challenges on how we design our navigation. Building a good semantic structure into a site helps screen reader users navigate a site, but also helps users of many other types of technology.

### Focus indication

Focus indication is crucial for users who navigate websites primarily using a keyboard and some alternative navigation devices. WebAim has some great resources on assistive technology for <a hreflang="en" href="https://webaim.org/articles/motor/assistive">individuals with limited motor abilities</a>. These devices are also customized by the user to maximize what they can control. There are a lot of similarities between how visible focus styles and focus order are managed with these devices, but it may be different than for keyboard only users.

Most automated tests do not test for focus order or keyboard traps. Lighthouse can not tell you that your site is keyboard navigable. All it can do is tell you that it isn't if your site fails some basic tests which are essential. Lighthouse uses <a hreflang="en" href="https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md">Deques' axe rules</a> to evaluate best practices. Even with a perfect score for focus indication, you need to test your pages manually. Lighthouse recommends testing for:

- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focus-traps">Focus traps</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focusable-controls">Interactive controls are keyboard focusable</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/logical-tab-order">Logical tab order</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/managed-focus">Focus directed to new content on a page</a>

<a hreflang="en" href="https://accessibilityinsights.io/docs/web/overview/">Accessibility Insights</a> is a great open source tool that leverages Deque's axe. This <a hreflang="en" href="https://accessibilityinsights.io/downloads/">Chrome/Edge extension</a> can help with keyboard-only testing and guide developers through other tests. The Tab Stops feature is a great visual indicator of a keyboard-only user's progress through a website.

### Focus styles

WCAG mandates a visible focus indicator for all interactive content to ensure users can identify which element is currently focused as they move through a page.

{{ figure_markup(
  image="pages-overriding-focus-styles.png",
  caption="Pages overriding browser focus styles.",
  description="A bar chart showing 82% websites sites use a :focus pseudo class, and 53% of sites using the :focus pseudo class to set the outline to 0 or none. 14% of desktop sites and 12% of mobile sites use the :focus-visible pseudo class.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1264001671&format=interactive",
  sheets_gid="1799906695",
  sql_file="focus_outline_0.sql"
  )
}}

We discovered that 53% of websites apply `:focus {outline: 0}` (in 2022 it was 86%), which removes the default outline provided by browsers for focused interactive elements. Although some websites implement custom styles to override this, it's not always the case, making it challenging for users to identify the currently focused element and impeding navigation. Sara Soueidan offers valuable guidance on <a hreflang="en" href="https://www.sarasoueidan.com/blog/focus-indicators/">designing WCAG-compliant focus indicators</a>. On a positive note, 12% of websites now use :focus-visible (up from 9% in 2022 and 0.6% in 2021), which is a pseudo class that uses browser heuristics to determine when to show the focus indicator. This is a significant improvement in accessibility practices.

### `tabindex`

Generally, HTML will have focus order set without having to set the tabindex. CSS and JavaScript often cause changes to how it is presented in the DOM. The tabindex attribute controls whether an element can receive focus and determines its position in the keyboard focus or "tab" order.

Our analysis shows that 63% of mobile websites and 64% of desktop websites utilize tabindex (up from 60% and 62% respectively). This attribute serves several purposes, which can affect accessibility:

- `tabindex="0"` places an element in the sequential keyboard focus order. Custom interactive elements and widgets should have `tabindex="0"` to ensure they are included in the focus sequence.
- `tabindex="-1"` removes the element from the keyboard focus order but allows it to be focused programmatically via JavaScript.
- A positive tabindex value overrides the default keyboard focus order, often leading to issues with <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-order.html">WCAG 2.4.3 - Focus Order</a>.

It's important to avoid placing non-interactive elements in the keyboard focus order, as this can be confusing for screen reader users who can see and alternative navigation users.

{{ figure_markup(
  image="tabindex-usage-and-values.png",
  caption="tabindex usage.",
  description="Bar chart showing that of pages that use tabindex, a tabindex of 0 is used on 49% of those pages for desktop and 47% of those pages for mobile, a negative tabindex is used on 48% for desktop and 47% for mobile, and finally a positive tabindex is used on 4% for all sites surveyed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1092084835&format=interactive",
  sheets_gid="2010133634",
  sql_file="tabindex_usage_and_values.sql"
  )
}}

Of all websites using the tabindex attribute, 4% employ positive values (down from 7% in 2022). Using positive tabindex values is generally considered poor practice as it disrupts the natural tab order. Karl Groves provides an <a hreflang="en" href="https://karlgroves.com/2018/11/13/why-using-tabindex-values-greater-than-0-is-bad">insightful article on this topic</a>.

### Landmarks

Landmarks help structure a web page into distinct thematic regions, facilitating easier navigation for users of assistive technologies. For instance, a <a hreflang="en" href="https://www.afb.org/blindness-and-low-vision/using-technology/cell-phones-tablets-mobile/apple-ios-iphone-and-ipad-2">rotor menu</a> can help navigate between different page landmarks, while <a hreflang="en" href="https://webaim.org/techniques/skipnav/">skip links</a> can direct users to specific landmarks, such as `<main>`. Landmarks can be defined using various HTML5 elements. This semantic structure can also be applied with Web Accessibility Initiative – Accessible Rich Internet Applications (ARIA)'s <a hreflang="en" href="https://www.w3.org/TR/WCAG20-TECHS/ARIA11.html">landmark roles</a>. However, it's best to use native HTML5 elements whenever possible, in line with <a hreflang="en" href="https://www.a11y-collective.com/blog/the-first-rule-for-using-aria/">ARIA's first rule</a>.

Although ARIA landmarks have traditionally been only visible to screen reader users, some sites are beginning to use tools like this <a hreflang="en" href="https://github.com/paypal/skipto">open source SkipTo script</a> which aggregates headings and landmarks into a page-specific table of contents. Exposing the document structure to the user helps everyone's comprehension. SkipTo delivers what really should be basic browser functionality. This goes beyond the skip links that are discussed in a later section.

<figure>
  <table>
    <thead>
      <tr>
        <th>Element type</th>
        <th>% of element</th>
        <th>% of role</th>
        <th>% of both</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>main</code></td>
        <td class="numeric">37%</td>
        <td class="numeric">17%</td>
        <td class="numeric">44%</td>
      </tr>
      <tr>
        <td><code>header</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">12%</td>
        <td class="numeric">66%</td>
      </tr>
      <tr>
        <td><code>nav</code></td>
        <td class="numeric">66%</td>
        <td class="numeric">19%</td>
        <td class="numeric">70%</td>
      </tr>
      <tr>
        <td><code>footer</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">10%</td>
        <td class="numeric">67%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Landmark element and `role` usage (desktop).",
      sheets_gid="1224962143",
      sql_file="landmark_elements_and_roles.sql",
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="pages-with-element-role-yty.png",
  caption="Yearly growth in pages with element role.",
  description="A line graph with the roles identified in the table above. There is a gradual growth in the footer, header and nav lements and nearly 9% increase in the use of the main role.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1090856027&format=interactive",
  sheets_gid="1224962143",
  sql_file="landmark_elements_and_roles.sql"
  )
}}

The most commonly expected landmarks for most web pages include `<main>`, `<header>`, `<nav>`, and `<footer>`. Our findings reveal that:
- only 37% of all pages use the native HTML `<main>` element,
- 17% of all pages have an element with `role="main"`, and
- 43% are using either one of them (up from 35% in 2021).

Scott O'Hara's <a hreflang="en" href="https://www.scottohara.me/blog/2018/03/03/landmarks.html">article on landmarks</a> provides valuable insights for enhancing accessibility.

### Heading hierarchy

Headings are crucial for all users, including those with assistive technologies, as they aid in navigating a website. Assistive technologies enable users to jump to specific sections of interest. As highlighted in Marcy Sutton's <a hreflang="en" href="https://marcysutton.com/how-i-audit-a-website-for-accessibility#Headings-and-Semantic-Structure">article on headings and semantic structure</a>, headings function like a table of contents, allowing users and search engines to navigate to particular content areas efficiently.

Sadly the heading hierarchy has gotten worse over the last two years. Lighthouse tracks properly ordered headings and it has dropped just over 1% to:

{{ figure_markup(
  caption="Mobile sites passing the Lighthouse audit for properly ordered heading.",
  content="57%",
  classes="big-number",
  sheets_gid="1279863228",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

Heading levels are associated with different font sizes and are frequently misused to visually style a website or mark specific sections rather than structure the content. This misuse negatively impacts both user experience and accessibility tools as well as search engines. CSS should be used to style elements, not heading tags.

WCAG mandates that websites offer multiple navigation options beyond the primary menu in the header, as outlined in <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/multiple-ways.html">Success Criterion 2.4.5: Multiple Ways</a>. For instance, many users, including those with cognitive disabilities, prefer search features to locate pages on large websites.

Currently, 21% of mobile websites and 22% of desktop websites include a search input (down from 23% and 24% respectively in 2022). This is not a good trend.

### Skip links

Skip links enable users who rely on the keyboard, switch control devices, or other alternative navigation tools to bypass various sections of a webpage without having to navigate through every focusable element. A common use is to skip over the primary navigation and move directly to the `<main>` content, particularly on sites with extensive interactive navigation menus. This can dramatically improve the user experience for some users.

{{ figure_markup(
  caption="Mobile and desktop pages likely featuring a skip link.",
  content="24%",
  classes="big-number",
  sheets_gid="756398875",
  sql_file="skip_links.sql"
)
}}

We discovered that 24% of both desktop and mobile pages likely include a skip link, helping users to avoid unnecessary parts of the page. This percentage may actually be higher, as our analysis only detects skip links positioned near the top of the page (such as those for bypassing navigation). Skip links can also be used to skip other sections of the page, as we described above with the SkipTo script.

### Document titles

Descriptive page titles are important for navigating between pages, tabs, and windows. Assistive technologies, such as screen readers, read these titles aloud, helping users keep track of their location.

{{ figure_markup(
  image="page_title-information.png",
  caption="Title element statistics.",
  description="A bar chart showing 97% of desktop and mobile sites use the `<title>` element, 69% of sites of those titles have four or more words, and 7% of desktops and 6% of mobile titles are changed on render.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1921322394&format=interactive",
  sheets_gid="1803785019",
  sql_file="page_title.sql"
  )
}}

While 97% of mobile websites include a document title, only 69% have titles that are more than four words long. Since our analysis is limited to the homepage and a secondary, we have limited insights about the inner pages. We did find that secondary pages were 8% more likely to have descriptive titles of more than four words (78% on average in 2024). Ideally, a title should include both a brief description of the page's content to enhance navigation and the website's name.

The titles changed on render value is derived from a comparison of the initial HTML title and the final value of the page after JavaScript has loaded. The data indicates that 7% of desktops sites scanned are dynamically changing the content of the title. Secondary pages are slightly less likely to change the title than the homepage.

### Tables

Tables present data and relationships using two dimensions. For accessibility, tables need a well-structured format with elements like captions and header cells to help users with assistive technologies understand and navigate the data. A caption, using the `<caption>` element, is especially important as it provides context for screen readers. Currently, 1.6% of desktop sites use a `<caption>` (slightly up from 1.3 in 2022), but this is a crucial aspect for making tables more accessible.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan=2>Table Sites</th>
        <th scope="colgroup" colspan=2>All Sites</th>
      </tr>
      <tr>
        <th></th>
        <th scope="col">desktop</th>
        <th scope="col">mobile</th>
        <th scope="col">desktop</th>
        <th scope="col">mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">Captioned tables</th>
        <td class="numeric">5.5%</td>
        <td class="numeric">4.8%</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <th scope="row">Presentational table</th>
        <td class="numeric">4.4%</td>
        <td class="numeric">5.0%</td>
        <td class="numeric">3.1%</td>
        <td class="numeric">4.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Table usage.",
      sheets_gid="1512848123",
      sql_file="table_stats.sql",
    ) }}
  </figcaption>
</figure>

Tables don't need to be used for page layout, thanks to CSS Flexbox and Grid. If necessary, tables can use `role="presentation"` to explicitly remove semantics and thereby avoid confusion when they are used for layout purposes. We see that 4% of mobile tables use this workaround (versus 1% in 2022).

## Forms

Forms are essential for user interactions, such as logging in or making purchases. For users with disabilities, accessible forms are crucial for completing tasks and achieving equal functionality. Forms are also often much more complicated for developers to build than static HTML pages.

### `<label>` element

The `<label>` element is the preferred way for [linking input fields with their accessible names](https://developer.mozilla.org/docs/Learn/Forms/Basic_native_form_controls). Using the for attribute to match the id of an input ensures proper programmatic association, improving form usability. Furthermore, when the label element is used properly it allows users to click or tap on the label to focus the form field.

For example:

```
<label for="emailaddress">Email</label>
<input type="email" id="emailaddress">
```

{{ figure_markup(
  image="form-input-name-sources.png",
  caption="Where inputs get their accessible names from.",
  description="A bar chart showing the source of the accessible name for the label element. 27% of sites had no accessible name. 32% now get get their accessible name from a `label` element. 24% of desktops inputs get their accessible names from the `placeholder` attribute and 25% for mobile. `aria-label` is responsible for 9%. The `value` attrabute contributes 3%. A `title` attribute contributes to 3% of the desktop and 2% of the mobile sites surveyed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=2076905999&format=interactive",
  sheets_gid="1902508631",
  sql_file="form_input_name_sources.sql"
  )
}}

Unfortunately, 13% of mobile inputs lack accessible names (a significant improvement from 38% in 2022). Only 15% of mobile sites use `<label>` (down from 19% in 2022), which can hinder users relying on screen readers or voice-to-text tools. An accessible name always needs to be used and sites should support assistive technology beyond just screen readers by ensuring the accessible name matches the visible label on the input. WCAG 2.1 added 2.5.3 Label in Name (Level A) to help ensure that technologies like Voice Control would be better supported.  Use of `aria-label` and `aria-labelledby` should only be used if an HTML `<label>` cannot be used.

### `placeholder` attribute

The `placeholder` attribute provides example input formats. It should not replace a `<label>` as a way to provide an accessible name. When placeholders are the only way of providing a visible label, that reference point disappears when the user starts typing. It is not a new concern that <a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">browsers by default do not give placeholder text sufficient contrast</a> to meet WCAG. Furthermore, they are <a hreflang="en" href="https://www.digitala11y.com/anatomy-of-accessible-forms-placeholder-is-a-mirage/">not always supported by screen readers</a>. A better solution is to show example input formats below or beside the input and connect them to the input programmatically using aria-describedby.

{{ figure_markup(
  image="placeholder-but-no-label.png",
  caption="Use of placeholders on inputs.",
  description="A bar chart showing 55% of desktop sites and 54% of mobile sites use placeholders. 59% of desktop sites and 61% of mobile sites have inputs with no label. 55% of desktop sites and 57% of mobile sites have placeholders and also inputs with no labels.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=186177069&format=interactive",
  sheets_gid="615941327",
  sql_file="placeholder_but_no_label.sql"
  )
}}

57% of mobile sites and 55% of desktop sites use placeholders alone, which can lead to accessibility issues. As per HTML5 guidelines, placeholders should not replace labels for accessibility.

<figure>
  <blockquote>Use of the placeholder attribute as a replacement for a label can reduce the accessibility and usability of the control for a range of users including older users and users with cognitive, mobility, fine motor skill or vision impairments.</blockquote>
  <figcaption>
  — <cite><a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">The W3C's Placeholder Research</a></cite>
  </figcaption>
</figure>


### Requiring information

Indicating required fields is crucial for forms. Before HTML5, an asterisk (*) was commonly used, but it's only a visual cue and doesn't provide error validation. In addition, the required attribute in HTML5 and `aria-required` attribute can improve the semantics for indicating mandatory fields.

{{ figure_markup(
  image="form-required-controls.png",
  caption="How required inputs are specified.",
  description="A bar chart showing the required attribute is used on 64% of desktop sites and 65% of mobile sites, `aria-required` is used by 41% and 40%, asterisk is used by 20% and 19%, 2 of 3 of these implemnted 14% and 13%, and all three are used by 2% on desktop and 1% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=285790110&format=interactive",
  sheets_gid="1192677260",
  sql_file="form_required_controls.sql"
  )
}}

Currently,
* 65% of mobile sites use the required attribute (down from 67% in 2022), and
* 40% use `aria-required` (up from 32% in 2022), but
* 19% still rely only on an asterisk (which is down from 22% in 2022).

This should be avoided unless supplemented by required and `aria-required`.

### Captchas

Websites often use CAPTCHAs to verify that a visitor is human and not a bot. CAPTCHAs, which stands for "Completely Automated Public Turing Test to Tell Computers and Humans Apart," are commonly used to prevent malicious software.

{{ figure_markup(
  caption="Mobile sites implementing one of the two detectable CAPTCHA types.",
  content="16%",
  classes="big-number",
  sheets_gid="590408963",
  sql_file="captcha_usage.sql"
)
}}

These tests can be challenging for everyone, especially for those with low vision or reading disabilities. The W3C has suggested alternatives to visual CAPTCHAs, which are worth exploring.

## Media on the web

Accessibility of media is crucial. People with disabilities need alternative methods to understand and interact with media content. For example, blind users require audio descriptions for images or videos, while those who are deaf or hard of hearing need sign language or captions.

Transcripts are needed for audio only and video only content. Non-text content such as images need equivalent alternatives or if they are just decorative they need to be semantically marked as such.

A media player is often embedded in the page to allow a user to play the audio or video content directly inline. If this is the case, it is important that an accessible player, such as the open source <a hreflang="en" href="https://ableplayer.github.io/ableplayer/">Able Player</a>, is used.

## Images

Images can have an `alt` attribute that provides a text description for screen readers. 69% of images passed the Google Lighthouse <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.7/image-alt">audit for images with alt text</a> (up from 59% in 2022). Which is a notable increase, especially because the number only increased about 1% from 2021 to 2022.

{{ figure_markup(
  caption="Pass the Lighthouse audit for images with alt text.",
  content="69%",
  classes="big-number",
  sheets_gid="1279863228",
  sql_file="lighthouse_a11y_audits.sql"
)
}}


The alt text should reflect the image's context. For decorative images, `alt=""` is appropriate, while meaningful images require informative descriptions. It's also important to avoid using file names as alt text, as it almost never provides relevant information. Currently 7.5% of mobile and 7.2% of desktop sites currently do.

{{ figure_markup(
  image="common-file-extensions-in-alt-text.png",
  caption="Most common file extensions in alt text.",
  description="A bar chart showing of all extensions used in alt jpg is used 53% of the time on desktop sites and 52% for mobile, png is 33% on both, jpeg is 5% and 5%, ico is 4%, svg is 2%, gif is 1%, webp is 2%, and finally tif is 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=283728620&format=interactive",
  sheets_gid="942056773",
  sql_file="alt_ending_in_image_extension.sql"
  )
}}

The most common file extensions found in alt text values (for sites with non-empty `alt` attributes) are `jpg` (and `jpeg`), `png`, `ico`, and `svg`. This likely indicates that CMS or other content management systems either automatically generate alt text or require content editors to provide it. However, if the CMS merely includes the image filename in the `alt` attribute, it typically offers no benefit to users. Therefore, it's crucial to use meaningful text descriptions.

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` attribute lengths.",
  description="A bar chart comparing the length of text alternatives for images for desktop sites. Showing no alt is set on 15%, it is set to empty on 30%, it is 10 characters or less on 17%, 20 characters or less on 15%, 30 characters or less on 8% , 100 characters or less on 15%, and it is greater than 100 characters on 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=580789543&format=interactive",
  sheets_gid="1040825973",
  sql_file="common_alt_text_length.sql"
  )
}}

There is a slight decline in images with no alt text currently at 15%, down 3% from the 2022 values. We discovered that 30% of alt text attributes on both desktop and mobile sites are empty, up from 27% in 2022. An empty `alt` attribute should be used only for images that are purely decorative and do not need to be described by screen readers or other assistive technologies. Most images contribute to the page content, so they should generally <a hreflang="en" href="https://www.craigabbott.co.uk/blog/how-to-write-good-alt-text-for-screen-readers/">include a meaningful description</a>.

Unfortunately, 17% of `alt` attributes contain 10 or fewer characters, this is down one percent from 2022. These unusually brief descriptions suggest inadequate information to describe the image appropriately. While some of these may be used to label links, which is acceptable, <a hreflang="en" href="https://adrianroselli.com/2024/05/my-approach-to-alt-text.html">many lack sufficient descriptive content</a>.

There is certainly more that can be done to change these stats. Very few content tools support authors through better documentation and validation as suggested in <a hreflang="en" href="https://www.w3.org/TR/ATAG20/">Authoring Tools Accessibility Guidelines (ATAG) 2.0</a>. Increasingly people are looking at Artificial Intelligence (AI) to create the alt text, usually on the client side. Brian Teeman wrote an interesting critique of the <a hreflang="en" href="https://magazine.joomla.org/all-issues/june-2024/ai-generated-alt-text">AI generation of Alt Text</a>.

One promising approach is from Mike Feranda in Drupal who has incorporated AI into CKEditor with <a hreflang="en" href="https://www.drupal.org/project/aidmi">AIDmi</a>. By showing authors an example of what the alt-text could be, they may be more likely to edit it to have it reflect what they are trying to say. This approach could be applied to other editing tools.

### Audio and video

The `<track>` element is used to provide timed text for `<audio>` and `<video>` elements, such as captions and descriptions. This helps users with hearing loss or visual impairments understand the content.

{{ figure_markup(
  caption="Sites with `<audio>` elements include a `<track>` element.",
  content="0.1%",
  classes="big-number",
  sheets_gid="546746158",
  sql_file="audio_track_usage.sql"
)
}}

For `<video>` elements, the figure is slightly higher at 0.5% for both desktops and 0.65% for mobile sites. These statistics do not cover audio or video embedded via `<iframe>`, where third-party services are less likely to offer text alternatives. Our industry can do a lot better.

## Assistive technology with ARIA

<a hreflang="en" href="https://www.w3.org/TR/using-aria/">Accessible Rich Internet Applications (ARIA)</a> provides a set of attributes for HTML5 elements designed to enhance web accessibility for individuals with disabilities. However, excessive use of ARIA attributes can sometimes create more problems than it solves. ARIA should be employed only when native HTML5 elements are inadequate for ensuring a fully accessible experience and should not replace or be used beyond what is necessary.

### ARIA roles

When assistive technologies interact with an element, the element's role helps convey how users might engage with its content.

For instance, <a hreflang="en" href="https://inclusive-components.design/tabbed-interfaces/">tabbed interfaces</a> often require specific ARIA roles to accurately represent their structure. The <a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/#tabpanel">WAI-ARIA Authoring Practices Design Patterns</a> outline how to create an accessible tabbed interface, suggesting that a tablist role be assigned to the container element due to the absence of a native HTML equivalent.

HTML5 introduced numerous native elements with built-in semantics and roles. For example, the `<nav>` element inherently has a `role="navigation"`, making it unnecessary to explicitly add this role with ARIA.

{{ figure_markup(
  image="top-10-aria-roles.png",
  caption="Top 10 most common ARIA roles.",
  description="Bar chart showing button is used by 49% of desktop sites and 50% of mobile sites, presentation by 40% and 39% respectively, dialog by 31%, navigation by 26% and 25%, search by 25%, main by 23%, image by 20%, banner by 16%, contentinfo by 14%, and finally region by 14%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=176303741&format=interactive",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
  )
}}

We observed that over 50% of mobile sites had homepages with at least one element assigned the `role="button"` (up from 33% in 2022, and 29% in 2021 and 25% in 2020). This increase is concerning, as it suggests websites may be using `<div>` or `<span>` elements as custom buttons or redundantly applying roles to `<button>` elements. Both practices are problematic and violate the fundamental ARIA principle of using native HTML elements—such as `<button>`—whenever possible.

{{ figure_markup(
  caption='Websites with at least one anchor with an href with a `role="button"`.',
  content="18%",
  classes="big-number",
  sheets_gid="172806090",
  sql_file="anchors_with_role_button.sql"
)
}}

18% of websites have at least one link with `role="button"` (slightly down from 21% in 2022). While adding an ARIA role can inform assistive technologies about an element's purpose, it doesn't make the element function like its native counterpart. This discrepancy can lead to issues with keyboard navigation since links and buttons have different behaviors. For example, links are not activated by the space key, whereas buttons are.

### Using the presentation role

When an element is assigned the `role="presentation"`, it loses its inherent semantics, along with those of its required child elements (e.g., list items within a `<ul>`, or rows and cells within a table). For instance, applying `role="presentation"` to a parent `<table>` or `<ul>` element will propagate this role to its child elements, causing them to lose their table or list semantics.

Removing semantics with `role="presentation"` means the element only has visual presence and its structure is not recognized by assistive technologies. The element's content will be read by a screen reader, but no information about the semantics will be provided.

{{ figure_markup(
  caption='Of desktop sites and 39% of mobile sites have at least one `role="presentation"`.',
  content="40%",
  classes="big-number",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
)
}}

This is concerning as in 2022 it was already high at 25% of desktop sites and 24% of mobile sites.

Similarly, using `role="none"` also removes the element's semantics. This year, 5% of sites used `role="none"`, down from 11% in 2022. While it may be useful in rare cases, such as when a `<table>` is used purely for layout, it generally should be used cautiously as it can be detrimental to accessibility.

Most browsers disregard `role="presentation"` and `role="none"` when exposing a role in the accessibility tree for focusable elements, including links and inputs, or elements with a tabindex attribute. Similarly, if an element with these roles includes global ARIA states or properties (such as `aria-describedby`), the `presentation` and `none` roles may be ignored.

### Labeling elements with ARIA

In addition to the DOM, browsers have an <a href="https://developer.mozilla.org/docs/Glossary/Accessibility_tree">accessibility tree</a>, containing details about HTML elements such as accessible names, descriptions, roles, and states. This information is communicated to assistive technologies through accessibility APIs.

An element's accessible name can come from its content (e.g., button text), attributes (e.g., image `alt` attribute), or associated elements (e.g., a label linked to a form control). There is a hierarchy used to determine the source of the accessible name when multiple sources are available. For further reading on accessible names, Léonie Watson's article, <a hreflang="en" href="https://developer.paciellogroup.com/blog/2017/04/what-is-an-accessible-name/">"What is an accessible name?"</a> is a valuable resource.

{{ figure_markup(
  image="top10-aria-attributes.png",
  caption="Top 10 ARIA attributes.",
  description="A bar chart showing `aria-label` is used by 65% of sites, `aria-hidden` by 63%, `aria-expanded` by 35% and 34%, `aria-live` by 29% and 28%, `aria-controls` by 29% and 28%, `aria-labelledby` by 27% and 26%, `aria-current` by 25% and 26%, `aria-haspopup` by 25% and 23%, `aria-describedby` by 18% and 16%, and finally `aria-atomic` by 15% and 14%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=859350702&format=interactive",
  sheets_gid="941417225",
  sql_file="common_element_attributes.sql"
  )
}}

Two ARIA attributes that aid in assigning accessible names are `aria-label` and `aria-labelledby`. These attributes are given precedence over natively derived accessible names and should be used sparingly and only when necessary. Testing accessible names with screen readers and involving individuals with disabilities is crucial to ensure that the names are helpful and do not hinder accessibility.

We observed that almost 66% of pages evaluated featured at least one element with the `aria-label` attribute (up from 58% for desktop and 57% on mobile in 2022), making it the most frequently used ARIA attribute for accessible names. Additionally, 27% of desktop pages and 25% of mobile pages had at least one element with the `aria-labelledby` attribute (both are up 2% from 2022 data). This trend suggests that while more elements are being assigned accessible names, it might also indicate a rise in elements lacking visual labels. This can be challenging for users with cognitive disabilities and voice input users.

{{ figure_markup(
  image="button-name-sources.png",
  caption="Button accessible name source.",
  description="A bar chart showing the contents are used for 59% of desktop buttons and 57% of mobile buttons, `aria-label` attribute is used for 24%, there is no accessible name for 10% and 12%, the value attribute is used for 6% and 5%, title attribute is used for 1% on both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1222426699&format=interactive",
  sheets_gid="883063802",
  sql_file="button_name_sources.sql"
  )
}}

Buttons typically receive their accessible names from their content or ARIA attributes. According to <a hreflang="en" href="https://www.w3.org/WAI/ARIA/apg/patterns/button/">ARIA guidelines</a>, it's preferable for an element to derive its accessible name from its content rather than an ARIA attribute if possible. We found that 59% of buttons on desktop obtain their accessible names from their text content, a slight drop from 2022 when it was 61%. Use of the `aria-label` attribute is up slightly to 23.9% on desktop (from 20% in 2022) meaning more sites are using the `aria-label` attribute for their accessible names.

In some cases, `aria-label` is useful, such as when multiple buttons have the same content but different functions, or when a button contains only an image or icon.

## Hiding content

Sometimes, visual interfaces include redundant elements that aren't beneficial for users of assistive technologies. In these cases, `aria-hidden="true"` can be used to <a hreflang="en" href="https://niquette.ca/articles/hiding-elements/">hide elements from screen readers</a>. However, this approach should not be used if removing the element would result in less information for screen reader users compared to what is presented visually. Hiding content from assistive technologies should not be a way to bypass content that is difficult to make accessible.

{{ figure_markup(
  caption="Had at least one element with the `aria-hidden` attribute.",
  content="63%",
  classes="big-number",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
)
}}

Using this attribute to hide and show semantic content is a common practice in modern interfaces in order to indicate when content is hidden to the accessibility API. . An example of this is a accordion component where content under a list of headings is hidden until a user selects one of the headings to show the related content.

ARIA can have a huge impact on accessibility and needs to be used cautiously. <a hreflang="en" href="https://blog.pope.tech/2022/07/12/what-you-need-to-know-about-aria-and-how-to-fix-common-mistakes/">It's crucial to apply ARIA correctly</a> to convey the right message.

For instance, disclosure widgets should use the `aria-expanded` attribute to signal to assistive technologies when an element is revealed or hidden by expanding or collapsing. We observed that 34% of mobile pages had at least one element with the `aria-expanded` attribute, which is up almost 5% from 2022.

## Screen reader-only text

A common approach developers use to provide extra information for screen reader users involves hiding text visually with CSS while keeping it accessible to screen readers. This CSS technique ensures that the text is included in the accessibility tree but remains hidden from sight.

{{ figure_markup(
  caption="Desktop websites with a sr-only or visually-hidden class.",
  content="16%",
  classes="big-number",
  sheets_gid="538059940",
  sql_file="sr_only_classes.sql"
)
}}

The sr-only and visually-hidden class names are frequently used by developers and UI frameworks to create text that is only accessible to screen readers. For instance, Bootstrap and Tailwind include sr-only classes for this purpose. We found that 16% of desktop pages and 15% of mobile pages used one or both of these CSS classes (each up a percentage point from 2022). It's important to note that not all screen reader users are visually impaired, so relying too heavily on screen reader-only solutions should be avoided. When this technique is used with an interactive element's accessible name, it can make it difficult for people who use their voice to control their computer to know what command to give to interact with the element.

## Dynamically-rendered content

Sometimes, it's necessary to inform screen readers about new or updated content in the DOM. For example, form validation errors should be communicated, while a lazy-loaded image might not need to be announced. Updates to the DOM should be made in a non-disruptive manner.

{{ figure_markup(
  caption="Desktop pages with live regions using `aria-live`.",
  content="29%",
  classes="big-number",
  sheets_gid="514880281",
  sql_file="common_aria_role.sql"
)
}}

ARIA live regions enable screen readers to announce changes in the DOM. We found that 29% of desktop pages use live regions with the `aria-live` attribute (up from 23% in 2022) and 28% of mobile pages use `aria-live` (up from 22% in 2022). Additionally, pages use ARIA live region roles with implicit `aria-live` values:

<figure>
  <table>
    <thead>
      <tr>
        <th>role</th>
        <th>desktop</th>
        <th>mobile</th>
        <th>Implicit <code>aria-live</code> value</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>status</code></td>
        <td class="numeric">9.2%</td>
        <td class="numeric">8.7%</td>
        <td><code>polite</code></td>
      </tr>
      <tr>
        <td><code>alert</code></td>
        <td class="numeric">6.9%</td>
        <td class="numeric">6.7%</td>
        <td><code>assertive</code></td>
      </tr>
      <tr>
        <td><code>timer</code></td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.8%</td>
        <td><code>off</code></td>
      </tr>
      <tr>
        <td><code>log</code></td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
        <td><code>polite</code></td>
      </tr>
      <tr>
        <td><code>marquee</code></td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
        <td><code>off</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Pages with live region ARIA roles, and their implicit `aria-live` value.",
      sheets_gid="514880281",
      sql_file="common_aria_role.sql",
    ) }}
  </figcaption>
</figure>

For more details on live region variants and their usage, check the [MDN live region documentation](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Live_Regions) or explore this <a hreflang="en" href="https://dequeuniversity.com/library/aria/liveregion-playground">live demo by Deque</a>.

## User Personalization Widgets and Overlay Remediation

Users are increasingly used to seeing accessibility widgets on websites. These allow them to access accessibility features that improve their experience. Accessibility Overlays are one type of these and usually include two types of technology: a personalization widget and a JavaScript overlay. Overlays can be either generic or custom:

- **User personalization**: tools that enable the site visitor to make changes to the appearance of the site via an on-site menu — changes like font or color contrast adjustments, and
- **Automated overlay remediation**: a generic technology that automatically scans for and attempts to remediate many common WCAG issues which affect the user interface, with complex algorithms and/or Artificial Intelligence.
- **Custom overlay remediation**: site specific code written by expert developer(s) to address specific conformance needs, and verified by accessibility experts in context, to avoid conflict with assistive technology.

Browsers have great built-in tools for personalization, but many users do not know about them.  Some sites add **personalization widgets** that often provide a range of accessibility features to make customization easier. Often this includes font size, spacing, and contrast, which is <a hreflang="en" href="https://mcmw.abilitynet.org.uk/">included in the browser</a>. This may also include tools like [text to speech](https://wikipedia.org/wiki/Speech_synthesis), which is <a hreflang="en" href="https://www.microsoft.com/en-us/edge/features/read-aloud?form=MA13FJ">included in Edge</a>. This can be useful for a range of users, but especially for those that do not have their own assistive technology available in that environment. These widgets can be helpful for users who are not actively using assistive technology or already maximizing their browser's built-in accessibility features.

If used, it is important that these tools do not interfere with the user experience (UX) including that of assistive technology users. For that reason, the European Disability Forum (EDF) published a report clearly stating that <a hreflang="en" href="https://www.edf-feph.org/accessibility-overlays-dont-guarantee-compliance-with-european-legislation">Accessibility overlays don't guarantee compliance with European legislation</a>:

"Users of assistive technology already have their devices and browsers configured to their preferred settings. The overlay technology can interfere with the user's assistive technology and override user settings, forcing people to use the overlay instead. This makes the website less accessible to some user groups and may prevent access to content."

**Overlay remediations** are the second type of technology often found in an overlay product. Automated overlay remediation continuously tries to find and address common WCAG issues as the page is being rendered in the browser. Custom overlay remediations can also be written in JavaScript to overcome accessibility barriers, especially when there is legacy code which can no longer be updated.  With good manual testing, especially with users with disabilities, a custom overlay can be an effective solution.

There are many documented reports of popular automated overlays making a product less accessible for some users.

This technology can address some common barriers for some users, making the site more accessible. Automated overlays can also advance an organization's accessibility progress and path to compliance by freeing development teams to focus on more complex issues that can only be resolved by addressing the design or source code.

Unfortunately, many teams simply stop investing in accessibility after investing in an overlay.

This technology does not replace the need for good accessibility practices. Accessibility needs to be included in all stages of the product life cycle. Overlays are always going to have more usability, security and performance problems than simply fixing the errors at the source. It is important to remember that no automated tool can make a website fully accessible or WCAG compliant.

{{ figure_markup(
  image="pages-using-a11y-apps.png",
  caption="Pages using accessibility apps (overlays).",
  description="A bar chart showing 2024 data with almost 2% of desktop sites and almost 1.7% of mobile sites use an accessibility app. The chart also compares 2022 and 2021 data on this. There is almost a doubling in desktop use of overlays compared to 2021, when it was just under 1% for desktops and .8% for mobile. 2022 data for desktop and mobile is 1.6% and 1.2%, so inline with the growth observed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=924673292&format=interactive",
  sheets_gid="1139100212",
  sql_file="a11y_technology_usage.sql"
  )
}}

In 2024, we observed that almost 2% of desktop websites utilize known accessibility apps. While not all of these products are accessibility overlays, the detectable overlays show a similar growth trend.

{{ figure_markup(
  image="a11y-app-usage-by-rank.png",
  caption="Accessibility app usage by rank.",
  description="A bar chart showing that for the 4 most commonly used overlay brands and the percentile in a grouping rank of the top 1,000, 10,000, 100,000, 1,000,000, 10,000,000, and all pages. UserWay is the most popular, followed by AccessiBe, AudioEye and EqualWeb. For comparison, just looking at the top 10 million pages, we see Userway with 0.71%, Accessiby with 0.49%, AudioEye with 0.45% and EqualWeb with 0.04%. AccessiBe seems to outperform compared with other values in the top million sites. AudioEye seems to be popular in the top 10,000 sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1842351478&format=interactive",
  sheets_gid="251539385",
  sql_file="a11y_technology_usage_by_domain_rank.sql"
  )
}}

UserWay is the most widely used overlay in our dataset.

{{ figure_markup(
  image="pages-using-a11y-apps-by-rank.png",
  caption="Pages using accessibility apps by rank.",
  description="A bar chart showing that for the top 1,000 sites, 0.3% on desktop and 0.2% on mobile use and accessibility app, for the top 10,000 it's 0.5% and 0.4% respectively, for the top 100,000 it's 0.8% and 0.7%, for the top million it's 1.1% and 1.0%, for the top 10 million it's 1.2% and 1.0%, for all sites it's 1.0% and 0.9%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=2030664465&format=interactive",
  sheets_gid="300879270",
  sql_file="a11y_overall_tech_usage_by_domain_rank.sql"
  )
}}

These solutions are generally used less for high-traffic websites. For sites ranked in the top 1,000 by visits, only 0.2%, use an overlay.

### Confusion on Overlays

<a hreflang="en" href="https://www.accessibilityassociation.org/">The International Association of Accessibility Professionals (IAAP)</a> published a paper outlining its <a hreflang="en" href="https://www.accessibilityassociation.org/s/overlay-position-and-recommendations">Accessibility Overlay Position and Recommendations</a>. In it, IAAP stresses that overlay technology must never impede a user's access. Furthermore, it states that IAAP members must not support claims that imply a website or application can be made fully accessible with overlay technology.

False advertising claims made by many overlay providers have prompted outcry from accessibility advocates: <a hreflang="en" href="https://adrianroselli.com/2020/06/accessiBe-will-get-you-sued.html">Adrian Roselli's #accessiBe Will Get You Sued</a> initially published in 2020 but actively updated as the case evolved; Lainey Feingold's <a hreflang="en" href="https://www.lflegal.com/2023/07/adrian-roselli-slapp-lawsuit/">American legal perspective</a>.

It is important to clearly understand the capabilities and limitations of any tool or technology used to advance accessibility. False claims by companies about their abilities have confused many clients. Organizations are responsible for doing appropriate research to ensure they meet applicable accessibility requirements and provide the best experience to visitors.

Neither the EU Commission or the US Department of Justice (DOJ) state how web accessibility standards have to be met—just that they must be met. From the <a hreflang="en" href="https://www.federalregister.gov/documents/2024/04/24/2024-07758/nondiscrimination-on-the-basis-of-disability-accessibility-of-web-information-and-services-of-state">DOJ ADA Title II rulemaking</a> the rule "does not address the internal policies or procedures that public entities might implement to conform to the technical standard under this rule."

In some instances, a combination of overlays and manual expertise has the potential to accelerate accessibility improvements.

## Sectors and accessibility

This year we are providing a series of new data comparisons. We want to highlight that there are discernible differences in how different communities have handled accessibility. Whether it is based on good governance, or good defaults, it is possible to see differences in accessibility that are significant. It is the hope of the authors of this section that this will prompt a review of how the various communities treat accessibility.

We also asessed the accessibility of websites in this section using the open source tool, [Google Lighthouse](https://developer.chrome.com/docs/lighthouse/accessibility/scoring).

### Country

There are two means by which we can identify country information, first by the GeoID of the server, and the second by the Top Level Domain. Because of the price of hosting in different countries, some are much better represented by GeoID than others. Likewise, given that many domains can operate independently of the country like the `.ai` or `.io` domain, we can't assume that all `.ca`, `.es`, or `.fi` domains are located in Canada, Spain or Finland.

{{ figure_markup(
  image="country-by-geoid.png",
  caption="Most accessible countries by GeoID.",
  description="A bar chart with the GeoID, the country with the highest average for accessibility is the USA with a value of 84%. There is a drop of less a perscent as we move to Canada, UK, Australia, Germany, Netherlands, France, Mexico, Italy, Spain, Argentina, Indonesia, India, Poland, Brazil, Japan, Turkey, Vietnam, China and finally the Republic of Korea with 78%. These were for countries that hosted more than 100000 domains.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=421126157&format=interactive",
  sheets_gid="260430925",
  sql_file="lighthouse_score_by_country.sql",
  width=600,
  height=504
  )
}}

It is worth noting that many sites that operate in the USA are subject to the Section 508 guidelines on accessibility. Organizations are being sued in the USA, under ADA Title III, for not having accessible websites. It is not surprising that the USA is the most accessible country. Other jurisdictions are beginning to penalize companies that sell inside their geography or to their citizens. Increasingly people are looking at the [European Accessibility Act](https://wikipedia.org/wiki/European_Accessibility_Act) and preparing for the new requirements that will be introduced in 2025.

The following map shows the average desktop accessibility score by country top level domain (TLD).

{{ figure_markup(
  image="country-by-tld-globe.png",
  caption="Map of the accessible countries by Top Level Domain (TLD).",
  description="In looking at Top Level Domains with more than 45,000 domains, we learn about accessibility. Displayed visually in a world map the most accessible countries are Norway, Filand, Canada, USA, UK, Sweden, Ireland, Australia, New Zealand, Austria, Belgium, Switzerland, Denmark, and South Africa. China is the least accessible by Top Level Domain. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1241724533&format=interactive",
  sheets_gid="1209052596",
  sql_file="lighthouse_score_by_tld.sql"
  )
}}

But it is a bit easier to see the TLD ranked and including the non-country codes as well.

{{ figure_markup(
  image="country-by-tld.png",
  caption="Accessible countries by Top Level Domain (TLD).",
  description="A bar chart with looking at Top Level Domains with more than 45,000 domains, we learn about accessibility. Displayed as a bar chart with the accessible domains .edu (Education), .gov (US Government), Norway, Filand, .io, Canada, USA, .app, UK, Sweden, Ireland, Australia, New Zealand, .co, Austria, Belgium, Switzerland, Denmark, and South Africa, .org.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=783736776&format=interactive",
  sheets_gid="1209052596",
  sql_file="lighthouse_score_by_tld.sql"
  )
}}

As with the prior chart `.edu` and `.gov` domains are the most accessible. The US Government under Section 508 and <a hreflang="en" href="https://www.levelaccess.com/compliance-overview/section-504-compliance/">Section 504</a>, have had this as part of their mandate for more than two decades. Early accessibility legislation and <a hreflang="en" href="https://www.accessibility.com/digital-lawsuits">active lawsuits</a> have driven accessibility adoption in the United States. Countries outside the USA started providing legislation and enforcement measures for WCAG conformance later. Lainey Feingold maintains a great list of <a hreflang="en" href="https://www.lflegal.com/global-law-and-policy/">global law and policy</a>.

### Government

Not all government domains follow consistent accessibility rules, however we were able to isolate many countries' government sites. Some countries are inconsistent about naming government sites, so there will be exceptions which are not covered. We have collected averages for most government agencies around the world.

{{ figure_markup(
  image="accessible-governments.png",
  caption="Most accessible government websites.",
  description="A bar chart with with the most accessible global governments. The Netherlands (98%), Luxembourg (96%), Finland (94%), UK (92%), European Union (91%), Norway (91%), Jersey (91%), Singapore (92%), Belgium (91%), Germany (91%),  France (90%), Australia (89%), New Zealand (89%), Dnmark (89%). ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=415917251&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

Most modern governments have committed to either WCAG 2.0 AA or WCAG 2.1 AA. It is clear that the implementation of these policies isn't being equally delivered. This is particularly important when looking into accessibility within the European Union where each member state needs to implement legislation based on the <a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/policies/web-accessibility-directive-standards-and-harmonisation">Web Accessibility Directive</a>. It should be possible to compare the 3-year <a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/library/web-accessibility-directive-monitoring-reports">EU member state reports</a> with the values provided here and in future Web Almanacs. It is worth noting that the average for the United States is 87%.

{{ figure_markup(
  image="accessible-governments-world.png",
  caption="Map of the accessibility of global government websites.",
  description="The map simply illustrates visually the table above. Scandinavian countries stand out as do many in Europe. Australia and New Zealand are highlighted in the Pacific. Canada is slightly darker than the United States.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1696489298&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

The Netherlands (98%) are firmly in the lead, followed by Luxembourg (96%) and Finland (94%). The <a hreflang="en" href="https://design-system.service.gov.uk">United Kingdom</a> and the <a hreflang="en" href="https://github.com/nl-design-system">Netherlands</a> both have a standardized design system which is prioritizes accessibility.  What contributes to Luxembourg and Finland's success? Considering that most accessibility content is available only in English, has this reduced adoption by some governments?

Government domains were largely found based on domain name pattern matching. There are a lot of inconsistencies in how governments use domain names, but there is enough information here to provide comparisons. It is worth noting that `.gov` covers all levels of the US government, so we have tried to filter out those state specific sub domains except in the state specific reporting. In this report, we could not filter out municipal or regional `.gov` sites. When looking at the TLD `.gov` domain chart above the average was 87%.

We can also review the accessibility of various states.

{{ figure_markup(
  image="US-state-governments.png",
  caption="The most accessible US state governments.",
  description="A bar chart with with the most accessible states in the US.  Colorado (96%), Vermont (94%), Nevada (93%), South Carolina (91%), Georgia (91%), North Carolina (91%), Kansas (90%), Maine (90%), California (90%), New York (90%), Hawaii (89%), DC (89%), Rhode Island (89%), Missouri (89%), Massachusettes (89%), New Hampshire (89%), Minnesota (89%), Michigan (88%), Oregon (88%), Iowa (88%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=174949843&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql",
  width=600,
  height=504
  )
}}


{{ figure_markup(
  image="US-state-governments-map.png",
  caption="Map of the most accessible US state governments.",
  description="Visualization of the data above with a US state specific map.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1855786285&format=interactive",
  sheets_gid="720509689",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

Again, Colorado and Vermont are much further ahead than other states. The state of Georgia has a <a hreflang="en" href="https://digital.georgia.gov/services/govhub">central Drupal installation</a> managed through a central agency, does this explain why it is in the top 5? Colorado has established a centralized <a hreflang="en" href="https://sipa.colorado.gov/">Statewide Internet Portal Authority (SIPA)</a>, along with <a hreflang="en" href="https://oit.colorado.gov/accessibility-law">new accessibility legislation</a> and now has an average of 95%. Pennsylvania's state average is much lower at 82% but they also have a new <a hreflang="en" href="https://code.oa.pa.gov/">digital experience team</a> established in 2023.

Earlier this year, the US Department of Justice <a hreflang="en" href="https://www.ada.gov/resources/2024-03-08-web-rule/">updated its regulations for Title II of the Americans with Disabilities Act (ADA)</a>. US state and local governments will now all be required to be fully WCAG 2.1 AA compliant. The compliance date depends on the size of their population but will be either April 2026 or April 2027. It will be important to measure how US states comply with this new regulation. We should see improvements in these numbers.

### Content Management Systems (CMS)

The <a hreflang="en" href="https://webaim.org/projects/million/">WebAim Million</a> study reviewed CMS data, and we are able to provide comparable results through the Web Almanac. The Web Almanac uses a customized version of a fork of Wappalyzer, from when it was open source. With this the report can identify which CMS is used and compare results. It is clear that Typo3 had better results in WebAim than when using Google Lighthouse data. Both studies clearly indicated that the choice of CMS had an impact on accessibility.

When most folks think about CMS, they think about the ones that you can download and install yourself. This is predominantly made up of open source tools, but not exclusively. Adobe Experience Manager (AEM), Contentful and Sitecore were the most accessible three in this list of top 10. A possible explanation for this is that closed-source software like AEM is more likely to be used by larger corporations, which have more resources to address accessibility issues. Additionally, open-source software gives website owners a lot of freedom, which in some cases can lead to worse accessibility.

{{ figure_markup(
  image="traditional-cms.png",
  caption="A bar chart with the accessible traditional Content Management Systems (CMS).",
  description="The most accessible CMS with over 10,000 instances are AEM (87%), Contentful (87%), Sitecore (85%), WordPress (85%), Craft CMS (84%), Contao (84%), Drupal (84%), Liferay (83%), TypoCMS (83%), DNN (82%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=174688785&format=interactive",
  sheets_gid="686463338",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

Looking at audits of these Traditional CMS, the top four Lighthouse issues have a great deal of consistency. Color contrast, link name, heading order and alt text are regular problems across these CMS, those issues are mainly related to the user since a CMS can not be responsible for the chosen colors or the naming of the links.

<figure>
  <table>
    <thead>
      <tr>
        <th>Traditional CMS</th>
        <th>Most popular</th>
        <th>2nd most</th>
        <th>3rd most</th>
        <th>4th most</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Adobe Experience Manager</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>label-content-name-mismatch</code></td>
      </tr>
      <tr>
        <td>Contentful</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>image-alt</code></td>
      </tr>
      <tr>
        <td>Sitecore</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>image-alt</code></td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>target-size</code></td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td><code>color-contrast</code></td>
        <td><code>link-name</code></td>
        <td><code>heading-order</code></td>
        <td><code>image-alt</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top accessibilty audit issues for popular CMS'.",
      sheets_gid="653243391",
      sql_file="lighthouse_a11y_audits_by_cms.sql",
    ) }}
  </figcaption>
</figure>

The different CMS do have a lot of commonalities in the top errors that they have. They mostly have to do with content issues, which is something that ATAG 2.0 was written to support. It is hoped that the best practices of ATAG will be brought into WCAG 3.0. This scan is only for publicly available websites, so authoring interfaces are not evaluated. It is worth noting that authors have disabilities, and authors should be able to expect an accessible interface. Authors also need support in creating accessible content. To help facilitate greater focus on authoring tools, the W3C produced a <a hreflang="en" href="https://www.w3.org/WAI/atag/report-tool/">ATAG Report Tool</a>.

There are many tools which can be used to help authors evaluate the accessibility of a page. Institutions that control the browser configurations of their staff, could choose to simply install the open source <a hreflang="en" href="https://accessibilityinsights.io/docs/web/getstarted/assessment/">Accessibility Insights</a> browser plugin for all of their browsers. This would make errors much more visible to administrators. For many of the CMS above though, the best solution might be to install a tool like <a hreflang="en" href="https://sa11y.netlify.app/">Sa11y</a> or <a hreflang="en" href="https://editoria11y.princeton.edu/">Editoria11y</a> which is geared to help authors. From Joomla version 4.1 onwards <a hreflang="en" href="https://sa11y.netlify.app/joomla/">Sa11y is included by default</a>, so all authors benefit.

Website platforms in general performed better than the Traditional CMS with Wix, Squarespace and Google Sites being significantly better.

{{ figure_markup(
  image="platform-cms.png",
  caption="A bar chart with the most accessible Website Platform Content Management Systems (CMS).",
  description="A bar graph with with the most accessible CMS: Wix (94%), Squarespace (92%), Google Sites (90%), Duda (87%), HubSpot CMS (87%), Pixnet (86%), Weebly (86%), GoDaddy Website Builder (85%), WebNode (84%), Tilda (83%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1383581431&format=interactive",
  sheets_gid="686463338",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

Looking at audits of these CMS Platforms, the top four Lighthouse issues have less consistency in the frewquency of issues but still have lots of similarities. Alternative text, link name, heading order and color contrast are all still issues, but just with different rates of occurrence.

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform CMS</th>
        <th>Most popular</th>
        <th>2nd most</th>
        <th>3rd most</th>
        <th>4th most</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Wix</td>
        <td><code>heading-order</code></td>
        <td><code>link-name</code></td>
        <td><code>button-name</code></td>
        <td><code>color-contrast</code></td>
      </tr>
      <tr>
        <td>Google Sites</td>
        <td><code>image-alt</code></td>
        <td><code>link-name</code></td>
        <td><code>aria-allowed-attr</code></td>
        <td><code>heading-order</code></td>
      </tr>
      <tr>
        <td>Duda</td>
        <td><code>link-name</code></td>
        <td><code>color-contrast</code></td>
        <td><code>image-alt</code></td>
        <td><code>heading-order</code></td>
      </tr>
      <tr>
        <td>HubSpot CMS</td>
        <td><code>color-contrast</code></td>
        <td><code>heading-order</code></td>
        <td><code>link-name</code></td>
        <td><code>target-size</code></td>
      </tr>
      <tr>
        <td>Pixnet</td>
        <td><code>heading-order</code></td>
        <td><code>link-name</code></td>
        <td><code>color-contrast</code></td>
        <td><code>frame-title</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top accessibilty audit issues for popular CMS platforms.",
      sheets_gid="653243391",
      sql_file="lighthouse_a11y_audits_by_cms.sql",
    ) }}
  </figcaption>
</figure>

Different CMS platforms have varying strengths and weaknesses. For example, it's clear that ARIA components must have accessible names, yet 36% of websites built with GoDaddy Website Builder fail this test, while the median failure rate for all CMS platforms with more than 100,000 occurrences in our dataset is just 1%. GoDaddy is also an outlier in the area of dialog names, with 14% of tests failing compared to a mean failure rate of 1.3%.

On the positive side, Duda stands out for button names, where only 3% of its websites fail the test, compared to a median of 13%. Even more impressive is Wix only 20% of Wix websites fail the Lighthouse test for color contrast, while the median failure rate among the most-used CMS platforms is 70%. Similarly, Wix performs exceptionally well regarding alternative text for images, with only 1% failing, compared to a median of 34%.

The differences show that it is possible for CMS to make an impact on accessibility even when the author needs to take the last step to make content accessible.

### JavaScript Frontend Frameworks

<a hreflang="en" href="https://webaim.org/projects/million/#frameworks">WebAim Million</a> also looks at the impact of JavaScript frameworks and libraries. Again it is possible to see patterns in the data based on the libraries used. We have worked with the definitions from the <a hreflang="en" href="https://2023.stateofjs.com/">State of JavaScript 2023</a>.

{{ figure_markup(
  image="javascript-frontend-ui.png",
  caption="Most Accessible JavaScript Frontend UI Frameworks.",
  description="A bar chart with ranked with Stimulus (91%), Remix (89%), Owik (89%), Astro (89%), OpenUI5 (89%), Next.js (87%), React (87%), AlpineJS (86%), Htmx (85%), Svelte (85%), Ember.js (85%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=1864888468&format=interactive",
  sheets_gid="1029816121",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

Stimulus, Remix and Qwik are several percent more accessible on average than React, Svelte or Ember.js.

{{ figure_markup(
  image="javascript-meta-frameworks.png",
  caption="Most Accessible JavaScript Meta-frameworks.",
  description="A bar chart with meta-frameworks are in the following order RedwoodJS (92%), Remix (89%), Astro (89%), SolidStart(88%), Gatsby (88%), Next.js (87%), Nuxt.js (84%), AdonisJS (82%), Quasar (82%), Meteor (73%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ32BLKultx6YJbcQP5DB6a4NTnf4h9RCC3QXte5oS-Onx-9cFqiPQ23dWgWgffj2QA1Q60zhrxJVYb/pubchart?oid=506578618&format=interactive",
  sheets_gid="1029816121",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

RedwoodJS is clearly the most accessible, followed by Remix and Astro.

## Conclusion

Our analysis indicates that there hasn't been a significant change in web accessibility. While there have been some improvements, many straightforward issues remain unresolved. Improving color contrast and use of image `alt` attributes could have a substantial impact if addressed. CMS systems and JavaScript frameworks have a huge responsibility and examples prove that they can have real positive impact on accessibility.

We often observe that features intended to enhance accessibility can sometimes create a false sense of improvement, while actually degrading the user experience. Many of these accessibility problems could be avoided if designers and developers integrated accessibility considerations from the start rather than treating them as an afterthought. Organizations must prioritize accessibility training, operations, and budgets to enable the development of more accessible user experiences. Some governments have demonstrated how effective that approach is.

The web community must understand that a website only offers an excellent customer experience when it accommodates everyone. In 2024 we should not be discriminating against people based on the device, browser or assistive technology used. We have focused on key metrics that are straightforward to address and are hoping to see more improvements in 2025.
