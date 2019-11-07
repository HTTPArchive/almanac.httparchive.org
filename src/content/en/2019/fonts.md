---
part_number: I
chapter_number: 6
title: Fonts
description: Fonts chapter of the 2019 Web Almanac covering ecommerce platforms, payloads, images, third parties, performance, seo, and PWAs
authors: [zachleat]
reviewers: [hyperpress, AymenLoukil]
published: 2019-11-04T12:00:00+00:00:00
last_updated: 2019-11-04T22:37:21.000Z 
---

## Introduction

**06.02 and 06.32: Popular web font hosts**

Google Fonts’ dominance here was simultaneously surprising and unsurprising at the same time. It was unsurprising in that I expected the service to be the most popular and surprising in the sheer dominance of its popularity. 75% of requests is astounding. TypeKit was a distant single-digit second place, with the Bootstrap library accounting for an even more distant third place. 

**06.46: Uses a Google Fonts link**

While Google Fonts’ dominance on requests was very impressive, it’s very noteworthy that only 29% of pages included a Google Fonts `<link>` element. This could mean a few things:

- When pages uses Google Fonts, they use _a lot_ of Google fonts. They are free, after all. This seems like the most likely reason.
- A lot of people are using Google Fonts with `@import` instead of `<link>`. My hunch is that this seems unlikely but maybe!
- Google Fonts are being requested using an [HTTP `Link: ` header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) instead. Now we’re going off the deep end into very unlikely scenarios.

**06.47: Uses a Google Fonts link first**

Google Fonts documentation encourages the `<link>` for the Google Fonts CSS to be placed as the first child in the `<head>` of a page. This is a big ask! In practice, this is not common as only half a percent of all pages took this advice. More so, if a page is using `preconnect` or `dns-prefetch` (read on for more about these) as `<link>` elements, these would come before the Google Fonts CSS anyway. In conclusion, 🤷‍♂️!

**06.01:  Are fonts being hosted on the same host or by a different host than the main content?**

This differentiation is important for performance reasons, increasingly relevant in an H2 world where the performance gap between a same-host and different-host connection can be wider. Same-host requests can also be better prioritized against same-host requests for other resources in the waterfall. Recommendations to mitigate this include `preconnect`, `dns-prefetch`, and `preload` but high priority web fonts (those used by a lot of content on your page) should be same-host requests to minimize the performance impact of web fonts.

This is perhaps unsurprising given Google Fonts dominance in `06.02`, as 75% Google Fonts requests-dominance would all be different host requests. Note that `preload` is not yet available with Google Fonts.

**06.03:  MIME types**

WOFF2 is pretty well supported in web browsers today. Google Fonts serves WOFF2, a format that offers improved compression over its predecessor. To me this is perhaps supporting evidence for a case to be made to go WOFF2-only for web fonts. I wonder where the double-digit WOFF usage is coming from—perhaps Internet Explorer?

Third place `octet-stream` (and `plain` a little further down) would seem to suggest that a lot of web servers are misconfigured to not properly send a MIME type with web font file requests.

**06.36–38:  src formats included in @font-face blocks**

I was hoping to see [SVG fonts](https://caniuse.com/#feat=svg-fonts) on the decline. They’re buggy and implementations have been removed from every browser except Safari. Time to drop these, y’all.

**06.39–41:  src formats combinations**

- [ ] TODO *Zach’s note: The order here is important, yeah.*

**06.04:  font-display Usage**

I assume this will be creeping up over time, especially now that [Google Fonts is adding `font-display` to all new code snippets](https://www.zachleat.com/web/google-fonts-display/) copied from their site. If you’re using Google Fonts—update your snippets! If you’re not using Google Fonts—use `font-display`! Read more about [`font-display` on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display).

**06.44: font-display values**

As an easy way to show fallback text while a web font is loading, `font-display: swap` reigns supreme and is the most common descriptor value. `swap` is also the default descriptor value used by new Google Fonts code snippets too. I would have expected `optional` (only render if cached) to have a bit more usage here as a few prominent developer evangelists lobbied for it a bit—but no dice.

**06.09a: Web font requests per page**

The median web page makes 4 web font requests. Even the 10th percentile requests one. The ubiquity of Web fonts is complete. It does seem interesting to me that web font requests seem to be pretty steady across desktop and mobile. I’m glad to see the recommendation to hide `@font-face` blocks inside of a `@media` query didn’t catch on (don’t do this).

**06.34: Font requests per page**

Why are there more requests for fonts made on mobile devices? Is it related to fewer typefaces available on mobile devices, which in turn means fewer `local()` hits in Google Fonts CSS? Actually we might be on to something here.

**06.09b: Web font families**

- [ ] TODO *Zach’s note: Is this families per page? What is `httparchive.almanac.parsed_css`?*

These results were a little surprising. I didn’t expect this to line up so well with the number of web font requests per page. Namely I didn’t expect so many unique font families! To me this suggests a few things might be happening here:

- Authors are mapping web fonts that share the same typeface to unique font-family names. My intuition seems to think this is unlikely.
- Authors are only using one web font from each font-family (this will be more common as variable font usage increases).
- I’ve seen some foundries (typography.com) use multiple font-family names as a copy-prevention mechanism for web fonts but I don’t think this is very common.

**06.10: Italics**

Only 29% of pages declare at least one italic font. This suggests a lot of faux-italic across the web, as web browsers will synthesize a fake bold version if one is not available for use. That means using elements with italic user agent styling (`em`, `i`, et al) will render faux-italic.

Faux bold may be even larger of a problem, as about 53–55% of pages have a font-face with a weight above 400, and (arguably) bold usage is more common than italic usage.

(Counterargument: a `@font-face` needn’t be declared bold or italic if the underlying glyphs are from a bold or italic variant of the typeface)

 **06.13: CSS Font Loading API**

This is the first metric that elicited an audible “oof” from me. The [CSS Font Loading API](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/webfont-optimization#the_font_loading_api) is currently the only way to group web font repaints. Arguably unnecessary if you’re only using one font file per typeface, which per the implication in in `06.09b` may be common practice!

 **06.14, 06.14b: unicode-range**

This is another metric that I expect was skewed by Google Fonts usage, as Google Fonts uses `unicode-range` in most of (if not all) its CSS. I’d expect this to be less common in userland—but perhaps filtering out Google Fonts requests in the next edition of the Almanac may be possible 😀.

 **06.15: Preconnect**

Wow—less than 2% of pages are using [preconnect](https://web.dev/uses-rel-preconnect)! Given that Google Fonts is at 75%, this should be higher! Developers: if you use Google Fonts, use preconnect!! Google Fonts, proselytize preconnect more!

**06.16: local()**

See `06.14`, my comments are similar. It has been said (and I agree) that using `local()` can be unpredictable as installed versions of fonts can be outdated and unreliable.

**06.18, 06.21, 06.25: Variable Fonts**

Even at 1.8% this was higher than expected—although I’m excited to see this take off even higher. I would be interested in some deeper analysis here. Is a big player using variable fonts? Can we slice this by host instead of requests?

**06.28 and 06.28b: Variable Font variation axes**

Through the lens of the this large data set, these are very low sample sizes—take these results with a grain of salt. However, `opsz` as the most common axis is notable, with `wght` and `wdth` trailing. In my experience, the introductory demos for variable fonts are usually `font-weight` based.

**06.29: Variable Font variation axes +/- 20pt**

- [ ] TODO [CONTENT_NEEDED]

**06.30: Variable Font variation axes combinations**

- [ ] TODO [CONTENT_NEEDED]

**06.26: font-stretch**

`font-stretch` is not a well known `@font-face` descriptor, historically, due to poor browser support. Read more about [`font-stretch` on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/font-stretch). That’s changed and it is now well supported. It has been suggested that using condensed fonts on smaller viewports allows more text to be viewable, but it certainly isn’t common. That being said, that this descriptor is used more on desktop than mobile is unexpected—and ~7% seems much higher than I would have predicted.

**06.31: Top Fonts**

It’s super weird that the top fonts here seem to match up very similarly to the list on [https://fonts.google.com/?sort=popularity](https://fonts.google.com/?sort=popularity)

**06.35: Page with the most font requests**

After diving into the code, the site that requests 718 web fonts is actually requesting 718 Google Fonts! It looks like a malfunctioning “Above the Page fold” optimization plugin for WordPress has gone rogue on this site and is requesting all the Google Fonts—oops!

**06.42 and 06.43: color fonts**

Usage here of these is basically nonexistent but you can check out the excellent resource [Color Fonts! WTF?](https://www.colorfonts.wtf/) for more information. Similar (but not at all) to the SVG format for fonts (which is bad and going away), this allows you to embed SVG inside of OpenType files (which is awesome and cool).
