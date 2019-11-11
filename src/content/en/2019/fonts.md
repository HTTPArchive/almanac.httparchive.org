---
unedited: true
part_number: I
chapter_number: 6
title: Fonts
description: Fonts chapter of the 2019 Web Almanac covering where fonts are loaded from, font formats, font loading performance, variable fonts and color fonts.
authors: [zachleat]
reviewers: [hyperpress, AymenLoukil]
discuss: 1761
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-11T00:00:00.000Z
---

## Introduction

Web Fonts enable beautiful and functional typography on the web. Use web fonts not only empowers design but democratizing a subset of design as they allow easier access to those who might not have particularly strong design skill. However, for all the good they can do, web fonts can also do great harm to your site's performance if they aren't loaded properly.

Are they a net positive for the web? Do they provide more benefit than harm? Are the web standards cowpaths sufficiently paved to encourage web font loading best practices by default? And if not, what needs to change? Let's take a data-driven peek at whether or not we can answer those questions by inspecting how web fonts are used on the web today.

## Where did you get those web fonts?

The first and most prominent question: Performance. There is a whole chapter dedicated to [performance](./performance) but we will delve a little into font-specific performance issues here.

Using hosted web fonts allows ease of implementation and maintenance but self-hosting offers the best performance. Given that web fonts by default make text invisible while the web font is loading (also known as the [Flash of Invisible Text, or FOIT](https://css-tricks.com/fout-foit-foft/)), the performance of web fonts can be more critical than non-blocking assets like images.

### Are fonts being hosted on the same host or by a different host?

Differentiating self-hosting against third-party hosting is increasingly relevant in an [HTTP/2](./http2) world where the performance gap between a same-host and different-host connection can be wider. Same-host requests have the huge benefit of better potential for prioritization against other same-host requests in the waterfall.

Recommendations to mitigate the performance costs of loading web fonts from another host include [`preconnect`](https://www.w3.org/TR/resource-hints/#preconnect), [`dns-prefetch`](https://www.w3.org/TR/resource-hints/#dns-prefetch), and [`preload`](https://www.w3.org/TR/preload/) [resource hints](./resource-hints) but high priority web fonts should be same-host requests to minimize the performance impact of web fonts. This is especially important for fonts used by very visually prominent content or body copy occupying the majority of a page.

(Graph Title: Third-party hosted versus self-hosted (local); Source: 06.01)

The fact that three quarters are hosted is perhaps unsurprising given Google Fonts dominance that we will discuss [below](#what-are-the-most-popular-third-party-hosts). Note that `preload` is not yet available with Google Fonts, as they generate unique URLs for their fonts [which are liable to change](https://github.com/google/fonts/issues/1067), and even [serve different fonts for different browsers](https://github.com/google/fonts/issues/234). Google serves fonts by getting websites to include a CSS link to a stylesheet. This will be in the main HTML (more on which below), so will already be connected to quickly. However, the fonts themselves are hosted on another domain (https://fonts.gstatic.com) so `preconnect` is a great option here as that will not be discovered until the CSS is downloaded.

### What are the most popular third-party hosts?

(Graph Title: Popular Web Font Hosts by Request, Source: 06.02)

The dominance of Google Fonts here was simultaneously surprising and unsurprising at the same time. It was unsurprising in that I expected the service to be the most popular and surprising in the sheer dominance of its popularity. 75% of requests (55–57% of fonts) is astounding. TypeKit was a distant single-digit second place, with the Bootstrap library accounting for an even more distant third place.

(Graph Title: Popular Web Fonts by Host, Source: 06.32)

While the high usage of Google Fonts here is very impressive, it is also noteworthy that only 29% of pages included a Google Fonts `<link>` element.

(Graph Title: Percentage of Pages with a Google Fonts `<link>`, Source: 06.46)

This could mean a few things:

- When pages uses Google Fonts, they use _a lot_ of Google Fonts. They are provided without monetary cost, after all. Perhaps they're being used in a popular WYSIWYG editor? This seems like a very likely explanation.
- Or a more unlikely story is that it could mean that a lot of people are using Google Fonts with `@import` instead of `<link>`.
- Or if we want to go off the deep end into super unlikely scenarios, it could mean that many people are using Google Fonts with an [HTTP `Link:` header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) instead.

Google Fonts documentation encourages the `<link>` for the Google Fonts CSS to be placed as the first child in the `<head>` of a page. This is a big ask! In practice, this is not common as only half a percent of all pages took this advice.

(Graph Title: Percentage of pages that have a Google Fonts `<link>` first, Source: 06.47)

More so, if a page is using `preconnect` or `dns-prefetch` as `<link>` elements, these would come before the Google Fonts CSS anyway. Read on for more about these resource hints.

### Speeding up third-party hosting

As mentioned above, a super easy way to speed up web font requests to a third-party host is to use the `preconnect` [resource hint](./resource-hints).

(Graph Title: Pages using `preconnect`; Source: 06.15)

Wow! Less than 2% of pages are using [`preconnect`](https://web.dev/uses-rel-preconnect)! Given that Google Fonts is at 75%, this should be higher! Developers: if you use Google Fonts, use `preconnect`! Google Fonts: proselytize `preconnect` more!

In fact, if you're using Google Fonts go ahead and add this to your `<head>` if it's not there already:

```<link rel="preconnect" href="https://fonts.gstatic.com/">```

### Most popular typefaces

(Graph Title: Top typefaces, Source: 06.31)

It is unsurprising that the top entries here seem to match up very similarly to [Google Fonts' list of fonts sorted by popularity](https://fonts.google.com/?sort=popularity).

## What font formats are being used?

[WOFF2 is pretty well supported](https://caniuse.com/#feat=woff2) in web browsers today. Google Fonts serves WOFF2, a format that offers improved compression over its predecessor, which was already an improvement over the other font formats.

(Graph Title: Popular MIME Types, Source: 06.03)

From my perspective an argument could be made to go WOFF2-only for web fonts after seeing the results here. I wonder where the double-digit WOFF usage is coming from? Perhaps developers still serving web fonts to Internet Explorer?

Third place `octet-stream` (and `plain` a little further down) would seem to suggest that a lot of web servers are configured improperly, sending an incorrect MIME type with web font file requests.

Let's dig a bit deeper and look at the `format()`s used in the `src:` descriptor in `@font-face` blocks:

(Graph Title: Top Declared src formats, Source: 06.36-38)

I was hoping to see [SVG fonts](https://caniuse.com/#feat=svg-fonts) on the decline. They're buggy and implementations have been removed from every browser except Safari. Time to drop these, y'all.

The SVG data point here also makes me wonder what MIME type y'all are serving these SVG fonts with. I don't see `image/svg+xml` anywhere in the `06.03` data set. Anyway, don't worry about fixing that, just get rid of them!

### WOFF2-only

(Graph Title: Popular Font format() Combinations, Source: 06.39-41)

This data set seems to suggest that the majority of people are already using WOFF2-only in their `@font-face` blocks. But this is misleading of course, per our earlier discussion on the dominance of Google Fonts in the data set. Google Fonts does some sniffing methods to serve a streamlined CSS file and only includes the most modern `format()`. Unsurprisingly WOFF2 dominates the results here for that reason, as browser support for WOFF2 has been pretty broad for some time now.

Importantly, this particular data doesn't really support or detract from the case to go WOFF2-only yet, but it remains a tempting idea.

## Fighting against invisible text

The number one tool we have to fight the default web font loading behavior of "invisible while loading" (also known as the Flash of Invisible Text, or FOIT), is `font-display`. Adding `font-display: swap` to your `@font-face` block is an easy way to tell the browser to show fallback text while the web font is loading.

[Browser support is great too](https://caniuse.com/#feat=mdn-css_at-rules_font-face_font-display). Internet Explorer and pre-Chromium Edge don't have support but they also by-default render fallback text when a web font loads (no FOITs allowed here). For other browsers, how commonly is `font-display` used?

(Graph Title: Usage of `font-display`; Source: 06.04)

I assume this will be creeping up over time, especially now that [Google Fonts is adding `font-display` to all new code snippets](https://www.zachleat.com/web/google-fonts-display/) copied from their site.

If you're using Google Fonts, update your snippets! If you're not using Google Fonts, use `font-display`! Read more about `font-display` on [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display).

Let's have a look at what `font-display` values are popular:

(Graph Title: `font-display` value popularity; Source: 06.44)

As an easy way to show fallback text while a web font is loading, `font-display: swap` reigns supreme and is the most common descriptor value. `swap` is also the default descriptor value used by new Google Fonts code snippets too. I would have expected `optional` (only render if cached) to have a bit more usage here as a few prominent developer evangelists lobbied for it a bit, but no dice.

## How many web fonts are too many?

This is a question that requires some measure of nuance. How are the fonts being used? For how much content on the page? Where does this content live in the layout? How are the fonts being rendered? In lieu of nuance however let's dive right into some broad and heavy handed analysis specifically centered on request counts.

(Graph Title: Distribution of fonts per page; Source: 06.09a)

The median web page makes four web font requests. The pages with the most web fonts (in the 90th percentile) requested nine and ten web fonts on mobile and desktop, respectively.

(Graph Title: Font requests per page; Source: 06.34)

It does seem quite interesting that web font requests seem to be pretty steady across desktop and mobile. I'm glad to see the [recommendation to hide `@font-face` blocks inside of a `@media` queries](https://css-tricks.com/snippets/css/using-font-face/#article-header-id-6) didn't catch on (don't get any ideas).

That said there are marginally more requests for fonts made on mobile devices. My hunch here is that fewer typefaces are available on mobile devices, which in turn means fewer `local()` hits in Google Fonts CSS, falling back to network requests for these.

### You don't want to win this award

The award for the page that requests the most web fonts goes to a site that made **718** web font requests!

After diving into the code, all of those 718 requests are going to Google Fonts! It looks like a malfunctioning "Above the Page fold" optimization plugin for WordPress has gone rogue on this site and is requesting (DDoS-ing?) all the Google Fonts—oops!

Ironic that a performance optimization plugin can make your performance much worse!

## Faux web fonts are socks with sandals

(Graph Title: Percentage of Pages Declaring an Italic Web Font; Source: 06.10)

Only 29% of pages declare at least one italic font. This suggests a lot of faux-italic across the web, as web browsers will synthesize a fake italic version of a font if one is not declared and available for use. That means using elements with italic user agent styling (`<em>`, `<i>`, et al) will render faux-italic.

Faux bold may be even larger of a problem, as about 53–55% of pages have a font-face with a weight above 400, and (arguably) bold usage is more common than italic usage.

(Counterpoint: a `@font-face` needn't be declared bold or italic if the underlying glyphs are from a bold or italic variant of the typeface but y'all wouldn't do this, would you??)

## Using JavaScript to improve web font loading

(Graph Title: Pages using the CSS Font Loading API; Source: 06.13)

This is the first metric that elicited an audible "oof" from me. The [CSS Font Loading API](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/webfont-optimization#the_font_loading_api) is currently the only way to group web font repaints. Arguably unnecessary if you're only using one font file per typeface, which per the implication in `06.09b` may be common practice.


(Do something with 6.09b and update above text?)

## More accurate matching with `unicode-range`

(Graph Title: Pages with at least one Web Font using unicode-range; Source: 06.14)

[`unicode-range` is a great CSS descriptor](https://developer.mozilla.org/en-US/docs/Web/CSS/%40font-face/unicode-range) to let the browser know specifically which code points the page would like to use in the font file. If the `@font-face` block has a `unicode-range`, content on the page must match one of the code points in the range before the font is requested. It is a very good thing.

This is another metric that I expect was skewed by Google Fonts usage, as Google Fonts uses `unicode-range` in most of (if not all) its CSS. I'd expect this to be less common in userland, but perhaps filtering out Google Fonts requests in the next edition of the Almanac may be possible.

## Don't request web fonts if a system font exists

(Graph Title: Pages that declare a Web Font with a `local()`; Source: 06.16)

`local()` is a nice way to reference a system font in your `@font-face` `src`. If the `local()` font exists, it doesn't need to make a request for a web font at all. This is used both extensively and controversially by Google Fonts, so it likely is another example of skewed data if we're trying to glean patterns from user land.

It should also be noted here that it has been said by smarter people than I (Bram Stein of TypeKit) that [using `local()` can be unpredictable as installed versions of fonts can be outdated and unreliable](https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html).

## Condensed fonts and `font-stretch`

(Graph Title: Top Variation Axes; Source: 06.26)

Historically `font-stretch` has suffered from poor browser support and was not a well-known `@font-face` descriptor. Read more about [`font-stretch` on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/font-stretch). But [browser support](https://caniuse.com/#feat=css-font-stretch) has broadened.

It has been suggested that using condensed fonts on smaller viewports allows more text to be viewable, but this approach isn't commonly used. That being said, that this descriptor is used more on desktop than mobile is unexpected, and ~7% seems much higher than I would have predicted.

## Variable fonts are the future

[Variable fonts](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Fonts/Variable_Fonts_Guide) allow several font weights and styles to be included in the one font file.

(Graph Title: Pages that Include a Variable Font; Source: 06.18)

Even at 1.8% this was higher than expected, although I am excited to see this take off. [Google Fonts v2 does include some support for Variable Fonts](https://developers.google.com/fonts/docs/css2).

(Graph Title: Top variation axes; Source: 06.28)

Through the lens of this large data set, these are very low sample sizes-take these results with a grain of salt. However, `opsz` as the most common axis is notable, with `wght` and `wdth` trailing. In my experience, the introductory demos for variable fonts are usually weight-based.

## Color fonts might also be the future?

(Graph Title: Percentage of Pages with Color Fonts; Source: 06.42)

Usage here of these is basically nonexistent but you can check out the excellent resource [Color Fonts! WTF?](https://www.colorfonts.wtf/) for more information. Similar (but not at all) to the SVG format for fonts (which is bad and going away), this allows you to embed SVG inside of OpenType files (which is awesome and cool).

## Conclusion

The biggest takeaway here is that Google Fonts dominates the web font discussion. Approaches they've taken weigh heavily on the data we've recorded here. The positives here are easy access to web fonts, good font formats (WOFF2), and for-free `unicode-range` configurations. The downsides here are performance drawbacks associated with third-party hosting, different-host requests, no access to `preload`.

I fully expect that in the future we'll see the Rise of the Variable Font. This _should_ be paired with a decline in web font requests, as Variable Fonts combine multiple individual font files into a single composite font file. But history has shown us that what usually happens here is that we optimize a thing and then add more things to fill the vacancy.

It will be very interesting to see if Color Fonts increase in popularity. I expect these to be far more niche than Variable Fonts but may see a lifeline in the icon font space.

Keep those fonts frosty, y'all.