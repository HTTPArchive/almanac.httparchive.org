---
part_number: I
chapter_number: 6
title: Fonts
description: Fonts chapter of the 2019 Web Almanac covering where fonts are loaded from, font formats, font loading performance, variable fonts and color fonts.
authors: [zachleat]
reviewers: [hyperpress, AymenLoukil]
translators: []
discuss: 1761
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-23T00:00:00.000Z
---

## Introduction

Web fonts enable beautiful and functional typography on the web. Using web fonts not only empowers design, but it democratizes a subset of design, as it allows easier access to those who might not have particularly strong design skills. However, for all the good they can do, web fonts can also do great harm to your site's performance if they are not loaded properly.

Are they a net positive for the web? Do they provide more benefit than harm? Are the web standards cowpaths sufficiently paved to encourage web font loading best practices by default? And if not, what needs to change? Let's take a data-driven peek at whether or not we can answer those questions by inspecting how web fonts are used on the web today.

## Where did you get those web fonts?

The first and most prominent question: performance. There is a whole chapter dedicated to [performance](./performance) but we will delve a little into font-specific performance issues here.

Using hosted web fonts enables ease of implementation and maintenance, but self-hosting offers the best performance. Given that web fonts by default make text invisible while the web font is loading (also known as the [Flash of Invisible Text](https://css-tricks.com/fout-foit-foft/), or FOIT), the performance of web fonts can be more critical than non-blocking assets like images.

### Are fonts being hosted on the same host or by a different host?

Differentiating self-hosting against third-party hosting is increasingly relevant in an [HTTP/2](./http2) world, where the performance gap between a same-host and different-host connection can be wider. Same-host requests have the huge benefit of a better potential for prioritization against other same-host requests in the waterfall.

Recommendations to mitigate the performance costs of loading web fonts from another host include using the `preconnect`, `dns-prefetch`, and `preload` [resource hints](./resource-hints), but high priority web fonts should be same-host requests to minimize the performance impact of web fonts. This is especially important for fonts used by very visually prominent content or body copy occupying the majority of a page.

<figure>
  <a href="/static/images/2019/06_Fonts/fig1.png">
    <img src="/static/images/2019/06_Fonts/fig1.png" alt="Figure 1. Popular web font hosting strategies." aria-labelledby="fig1-description" aria-describedby="fig1-caption" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1546332659&amp;format=interactive">
  </a>
  <div id="fig1-description" class="visually-hidden">Bar chart showing the popularity of third-party and self-hosting strategies for web fonts. 75% of mobile web pages use third-party hosts and 25% self-host. Desktop websites have similar usage.</div>
  <figcaption id="fig1-caption">Figure 1. Popular web font hosting strategies.</figcaption>
</figure>

The fact that three quarters are hosted is perhaps unsurprising given Google Fonts dominance that we will discuss [below](#what-are-the-most-popular-third-party-hosts).

Google serves fonts using third-party CSS files hosted on `https://fonts.googleapis.com`. Developers add requests to these stylesheets using `<link>` tags in their markup. While these stylesheets are render blocking, they are very small. However, the font files are hosted on yet another domain, `https://fonts.gstatic.com`. The model of requiring two separate hops to two different domains makes `preconnect` a great option here for the second request that will not be discovered until the CSS is downloaded.

Note that while `preload` would be a nice addition to load the font files higher in the request waterfall (remember that `preconnect` sets up the connection, it doesn’t request the file content), `preload` is not yet available with Google Fonts. Google Fonts generates unique URLs for their font files [which are subject to change](https://github.com/google/fonts/issues/1067).

### What are the most popular third-party hosts?

<figure>
  <table>
    <thead>
      <tr>
        <th>Host</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>fonts.gstatic.com</td>
        <td class="numeric">75.4%</td>
        <td class="numeric">74.9%</td>
      </tr>
      <tr>
        <td>use.typekit.net</td>
        <td class="numeric">7.2%</td>
        <td class="numeric">6.6%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>use.fontawesome.com</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>static.parastorage.com</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>fonts.shopifycdn.com</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>use.typekit.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>netdna.bootstrapcdn.com</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>fast.fonts.net</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>static.dealer.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>themes.googleusercontent.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>static-v.tawk.to</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>stc.utdstc.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>kit-free.fontawesome.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>open.scdn.co</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>assets.squarespace.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>fonts.jimstatic.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 2. Top 20 font hosts by percent of requests.</figcaption>
</figure>

The dominance of Google Fonts here was simultaneously surprising and unsurprising at the same time. It was unsurprising in that I expected the service to be the most popular and surprising in the sheer dominance of its popularity. 75% of font requests is astounding. TypeKit was a distant single-digit second place, with the Bootstrap library accounting for an even more distant third place.

<figure>
  <div class="big-number">29%</div>
  <figcaption>Figure 3. Percent of pages that include a Google Fonts stylesheet link in the document <code>&lt;head></code>.</figcaption>
</figure>

While the high usage of Google Fonts here is very impressive, it is also noteworthy that only 29% of pages included a Google Fonts `<link>` element. This could mean a few things:

- When pages uses Google Fonts, they use _a lot_ of Google Fonts. They are provided without monetary cost, after all. Perhaps they're being used in a popular WYSIWYG editor? This seems like a very likely explanation.
- Or a more unlikely story is that it could mean that a lot of people are using Google Fonts with `@import` instead of `<link>`.
- Or if we want to go off the deep end into super unlikely scenarios, it could mean that many people are using Google Fonts with an [HTTP `Link:` header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) instead.

<figure>
  <div class="big-number">0.4%</div>
  <figcaption>Figure 4. Percent of pages that include a Google Fonts stylesheet link as the first child in the document <code>&lt;head></code>.</figcaption>
</figure>

Google Fonts documentation encourages the `<link>` for the Google Fonts CSS to be placed as the first child in the `<head>` of a page. This is a big ask! In practice, this is not common as only half a percent of all pages (about 20,000 pages) took this advice.

More so, if a page is using `preconnect` or `dns-prefetch` as `<link>` elements, these would come before the Google Fonts CSS anyway. Read on for more about these resource hints.

### Speeding up third-party hosting

As mentioned above, a super easy way to speed up web font requests to a third-party host is to use the `preconnect` [resource hint](./resource-hints).

<figure>
  <div class="big-number">1.7%</div>
  <figcaption>Figure 5. Percent of mobile pages preconnecting to a web font host.</figcaption>
</figure>

Wow! Less than 2% of pages are using [`preconnect`](https://web.dev/uses-rel-preconnect)! Given that Google Fonts is at 75%, this should be higher! Developers: if you use Google Fonts, use `preconnect`! Google Fonts: proselytize `preconnect` more!

In fact, if you're using Google Fonts go ahead and add this to your `<head>` if it's not there already:

```<link rel="preconnect" href="https://fonts.gstatic.com/">```

### Most popular typefaces

<figure markdown>
  <table>
      <thead>
        <tr>
          <th>Rank</th>
          <th>Font family</th>
          <th>Desktop</th>
          <th>Mobile</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="numeric">1</td>
          <td>Open Sans</td>
          <td class="numeric">24%</td>
          <td class="numeric">22%</td>
        </tr>
        <tr>
          <td class="numeric">2</td>
          <td>Roboto</td>
          <td class="numeric">15%</td>
          <td class="numeric">19%</td>
        </tr>
        <tr>
          <td class="numeric">3</td>
          <td>Montserrat</td>
          <td class="numeric">5%</td>
          <td class="numeric">4%</td>
        </tr>
        <tr>
          <td class="numeric">4</td>
          <td>Source Sans Pro</td>
          <td class="numeric">4%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">5</td>
          <td>Noto Sans JP</td>
          <td class="numeric">3%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">6</td>
          <td>Lato</td>
          <td class="numeric">3%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">7</td>
          <td>Nanum Gothic</td>
          <td class="numeric">4%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">8</td>
          <td>Noto Sans KR</td>
          <td class="numeric">3%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">9</td>
          <td>Roboto Condensed</td>
          <td class="numeric">2%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">10</td>
          <td>Raleway</td>
          <td class="numeric">2%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">11</td>
          <td>FontAwesome</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">12</td>
          <td>Roboto Slab</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">13</td>
          <td>Noto Sans TC</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">14</td>
          <td>Poppins</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">15</td>
          <td>Ubuntu</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">16</td>
          <td>Oswald</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">17</td>
          <td>Merriweather</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">18</td>
          <td>PT Sans</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">19</td>
          <td>Playfair Display</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">20</td>
          <td>Noto Sans</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
      </tbody>
    </table>
  <figcaption>Figure 6. Top 20 font families as a percent of all font declarations.</figcaption>
</figure>

It is unsurprising that the top entries here seem to match up very similarly to [Google Fonts' list of fonts sorted by popularity](https://fonts.google.com/?sort=popularity).

## What font formats are being used?

[WOFF2 is pretty well supported](https://caniuse.com/#feat=woff2) in web browsers today. Google Fonts serves WOFF2, a format that offers improved compression over its predecessor WOFF, which was itself already an improvement over other existing font formats.

<figure>
  <a href="/static/images/2019/06_Fonts/fig7.png">
    <img src="/static/images/2019/06_Fonts/fig7.png" alt="Figure 7. Popularity of web font MIME types." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=998584594&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Bar chart showing the popularity of web font MIME types. WOFF2 is used on 74% of fonts, followed by 13% WOFF, 6% octet-stream, 3% TTF, 2% plain, 1% HTML, 1% SFNT, and fewer than 1% for all other types. Desktop and mobile have similar distributions.</div>
  <figcaption id="fig7-caption">Figure 7. Popularity of web font MIME types.</figcaption>
</figure>

From my perspective, an argument could be made to go WOFF2-only for web fonts after seeing the results here. I wonder where the double-digit WOFF usage is coming from? Perhaps developers still serving web fonts to Internet Explorer?

Third place `octet-stream` (and `plain` a little further down) would seem to suggest that a lot of web servers are configured improperly, sending an incorrect MIME type with web font file requests.

Let's dig a bit deeper and look at the `format()` values used in the `src:` property of `@font-face` declarations:

<figure>
  <a href="/static/images/2019/06_Fonts/fig8.png">
    <img src="/static/images/2019/06_Fonts/fig8.png" alt="Figure 8. Popularity of font formats in <code>@font-face</code> declarations." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=700778025&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Bar chart showing the popularity of formats used in font-face declarations. 69% of desktop pages' @font-face declarations specify the WOFF2 format, 11% WOFF, 10% TrueType, 8% SVG, 2% EOT, and fewer than 1% OpenType, TTF, and OTF. The distribution for mobile pages is similar.</div>
  <figcaption id="fig8-caption">Figure 8. Popularity of font formats in <code>@font-face</code> declarations.</figcaption>
</figure>

I was hoping to see [SVG fonts](https://caniuse.com/#feat=svg-fonts) on the decline. They're buggy and implementations have been removed from every browser except Safari. Time to drop these, y'all.

The SVG data point here also makes me wonder what MIME type y'all are serving these SVG fonts with. I don't see `image/svg+xml` anywhere in Figure 7. Anyway, don't worry about fixing that, just get rid of them!

### WOFF2-only

<figure>
  <table>
    <thead>
      <tr>
        <th>Rank</th>
        <th>Format combinations</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>woff2</td>
        <td class="numeric">84.0%</td>
        <td class="numeric">81.9%</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>svg, truetype, woff</td>
        <td class="numeric">4.3%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>svg, truetype, woff, woff2</td>
        <td class="numeric">3.5%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>eot, svg, truetype, woff</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">2.9%</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>woff, woff2</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td class="numeric">6</td>
        <td>eot, svg, truetype, woff, woff2</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td class="numeric">7</td>
        <td>truetype, woff</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td class="numeric">8</td>
        <td>woff</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td class="numeric">9</td>
        <td>truetype</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td class="numeric">10</td>
        <td>truetype, woff, woff2</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td class="numeric">11</td>
        <td>opentype, woff, woff2</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">12</td>
        <td>svg</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">13</td>
        <td>eot, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">14</td>
        <td>opentype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">15</td>
        <td>opentype</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">16</td>
        <td>eot</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">17</td>
        <td>opentype, svg, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">18</td>
        <td>opentype, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">19</td>
        <td>eot, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">20</td>
        <td>svg, woff</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 9. Top 20 font format combinations.</figcaption>
</figure>

This dataset seems to suggest that the majority of people are already using WOFF2-only in their `@font-face` blocks. But this is misleading of course, per our earlier discussion on the dominance of Google Fonts in the data set. Google Fonts does some sniffing methods to serve a streamlined CSS file and only includes the most modern `format()`. Unsurprisingly, WOFF2 dominates the results here for that reason, as browser support for WOFF2 has been pretty broad for some time now.

Importantly, this particular data doesn't really support or detract from the case to go WOFF2-only yet, but it remains a tempting idea.

## Fighting against invisible text

The number one tool we have to fight the default web font loading behavior of "invisible while loading" (also known as FOIT), is `font-display`. Adding `font-display: swap` to your `@font-face` block is an easy way to tell the browser to show fallback text while the web font is loading.

[Browser support](https://caniuse.com/#feat=mdn-css_at-rules_font-face_font-display) is great too. Internet Explorer and pre-Chromium Edge don't have support but they also render fallback text by default when a web font loads (no FOITs allowed here). For our Chrome tests, how commonly is `font-display` used?

<figure>
  <div class="big-number">26%</div>
  <figcaption>Figure 10. Percent of mobile pages that utilize the <code>font-display</code> style.</figcaption>
</figure>

I assume this will be creeping up over time, especially now that [Google Fonts is adding `font-display` to all new code snippets](https://www.zachleat.com/web/google-fonts-display/) copied from their site.

If you're using Google Fonts, update your snippets! If you're not using Google Fonts, use `font-display`! Read more about `font-display` on [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display).

Let's have a look at what `font-display` values are popular:

<figure>
  <a href="/static/images/2019/06_Fonts/fig11.png">
    <img src="/static/images/2019/06_Fonts/fig11.png" alt="Figure 11. Usage of 'font-display' values." aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1988783738&amp;format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">Bar chart showing the usage of the font-display style. 2.6% of mobile pages set this style to "swap", 1.5% to "auto", 0.7% to "block", 0.4% to "fallback", 0.2% to optional, and 0.1% to "swap" enclosed in quotes, which is invalid. The desktop distribution is similar except "swap" usage is lower by 0.4 percentage points and "auto" usage is higher by 0.1 percentage points.</div>
  <figcaption id="fig11-caption">Figure 11. Usage of <code>font-display</code> values.</figcaption>
</figure>

As an easy way to show fallback text while a web font is loading, `font-display: swap` reigns supreme and is the most common value. `swap` is also the default value used by new Google Fonts code snippets too. I would have expected `optional` (only render if cached) to have a bit more usage here as a few prominent developer evangelists lobbied for it a bit, but no dice.

## How many web fonts are too many?

This is a question that requires some measure of nuance. How are the fonts being used? For how much content on the page? Where does this content live in the layout? How are the fonts being rendered? In lieu of nuance however let's dive right into some broad and heavy handed analysis specifically centered on request counts.

<figure>
  <a href="/static/images/2019/06_Fonts/fig12.png">
    <img src="/static/images/2019/06_Fonts/fig12.png" alt="Figure 12. Distribution of font requests per page." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=451821825&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">Bar chart showing the distribution of font requests per page. The 10, 25, 50, 75, and 90th percentiles for desktop are: 0, 1, 3, 6, and 9 font requests. The distribution for mobile is identical until the 75th and 90th percentiles, where mobile pages request 1 fewer font.</div>
  <figcaption id="fig12-caption">Figure 12. Distribution of font requests per page.</figcaption>
</figure>

The median web page makes three web font requests. At the 90th percentile, requested six and nine web fonts on mobile and desktop, respectively.

<figure>
  <a href="/static/images/2019/06_Fonts/fig13.png">
    <img src="/static/images/2019/06_Fonts/fig13.png" alt="Figure 13. Histogram of web fonts requested per page." aria-labelledby="fig13-description" aria-describedby="fig13-caption" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1755200484&amp;format=interactive">
  </a>
  <div id="fig13-description" class="visually-hidden">Histogram showing the distribution of the number of font requests per page. The most popular number of font requests is 0 at 22% of desktop pages. The distribution drops to 9% of pages having 1 font, then crests at 10% for 2-4 fonts before falling as the number of fonts increases. The desktop and mobile distributions are similar, although the mobile distribution skews slightly toward having fewer fonts per page.</div>
  <figcaption id="fig13-caption">Figure 13. Histogram of web fonts requested per page.</figcaption>
</figure>

It does seem quite interesting that web font requests seem to be pretty steady across desktop and mobile. I'm glad to see the [recommendation to hide `@font-face` blocks inside of a `@media` queries](https://css-tricks.com/snippets/css/using-font-face/#article-header-id-6) didn't catch on (don't get any ideas).

That said there are marginally more requests for fonts made on mobile devices. My hunch here is that fewer typefaces are available on mobile devices, which in turn means fewer `local()` hits in Google Fonts CSS, falling back to network requests for these.

### You don't want to win this award

<figure>
  <div class="big-number">718</div>
  <figcaption>Figure 14. The most web font requests on a single page.</figcaption>
</figure>

The award for the page that requests the most web fonts goes to a site that made **718** web font requests!

After diving into the code, all of those 718 requests are going to Google Fonts! It looks like a malfunctioning "Above the Page fold" optimization plugin for WordPress has gone rogue on this site and is requesting (DDoS-ing?) all the Google Fonts—oops!

Ironic that a performance optimization plugin can make your performance much worse!

## More accurate matching with `unicode-range`

<figure>
  <div class="big-number">56%</div>
  <figcaption>Figure 15. Percent of mobile pages that declare a web font with the <code>unicode-range</code> property.</figcaption>
</figure>

[`unicode-range`](https://developer.mozilla.org/en-US/docs/Web/CSS/%40font-face/unicode-range) is a great CSS property to let the browser know specifically which code points the page would like to use in the font file. If the `@font-face` declaration has a `unicode-range`, content on the page must match one of the code points in the range before the font is requested. It is a very good thing.

This is another metric that I expect was skewed by Google Fonts usage, as Google Fonts uses `unicode-range` in most (if not all) of its CSS. I'd expect this to be less common in user land, but perhaps filtering out Google Fonts requests in the next edition of the Almanac may be possible.

## Don't request web fonts if a system font exists

<figure>
  <div class="big-number">59%</div>
  <figcaption>Figure 16. Percent of mobile pages that declare a web font with the <code>local()</code> property.</figcaption>
</figure>

`local()` is a nice way to reference a system font in your `@font-face` `src`. If the `local()` font exists, it doesn't need to make a request for a web font at all. This is used both extensively and controversially by Google Fonts, so it is likely another example of skewed data if we're trying to glean patterns from user land.

It should also be noted here that it has been said by smarter people than I (Bram Stein of TypeKit) that [using `local()` can be unpredictable as installed versions of fonts can be outdated and unreliable](https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html).

## Condensed fonts and `font-stretch`

<figure>
  <div class="big-number">7%</div>
  <figcaption>Figure 16. Percent of desktop and mobile pages that include a style with the <code>font-stretch</code> property.</figcaption>
</figure>

Historically, `font-stretch` has suffered from poor browser support and was not a well-known `@font-face` property. Read more about [`font-stretch` on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/font-stretch). But [browser support](https://caniuse.com/#feat=css-font-stretch) has broadened.

It has been suggested that using condensed fonts on smaller viewports allows more text to be viewable, but this approach isn't commonly used. That being said, that this property is used half a percentage point more on desktop than mobile is unexpected, and 7% seems much higher than I would have predicted.

## Variable fonts are the future

[Variable fonts](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Fonts/Variable_Fonts_Guide) allow several font weights and styles to be included in the one font file.

<figure>
  <div class="big-number">1.8%</div>
  <figcaption>Figure 16. Percent of pages that include a variable font.</figcaption>
</figure>

Even at 1.8% this was higher than expected, although I am excited to see this take off. [Google Fonts v2](https://developers.google.com/fonts/docs/css2) does include some support for variable fonts.

<figure>
  <a href="/static/images/2019/06_Fonts/fig17.png">
    <img src="/static/images/2019/06_Fonts/fig17.png" alt="Figure 17. Usage of 'font-variation-settings' axes." aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=699343351&amp;format=interactive">
  </a>
  <div id="fig17-description" class="visually-hidden">Bar chart showing the usage of the font-variation-settings property. 42% of properties on desktop pages are set to the "opsz" value, 32% to "wght", 16% to "wdth", 2% or fewer to "roun", "crsb", "slnt", "inln", and more. The most notable differences between desktop and mobile pages are 26% usage of "opsz", 38% of "wght", and 23% of "wdth".</div>
  <figcaption id="fig17-caption">Figure 17. Usage of <code>font-variation-settings</code> axes.</figcaption>
</figure>

Through the lens of this large data set, these are very low sample sizes-take these results with a grain of salt. However, `opsz` as the most common axis on desktop pages is notable, with `wght` and `wdth` trailing. In my experience, the introductory demos for variable fonts are usually weight-based.

## Color fonts might also be the future?

<figure>
  <div class="big-number">117</div>
  <figcaption>Figure 18. The number of desktop web pages that include a color font.</figcaption>
</figure>

Usage here of these is basically nonexistent but you can check out the excellent resource [Color Fonts! WTF?](https://www.colorfonts.wtf/) for more information. Similar (but not at all) to the SVG format for fonts (which is bad and going away), this allows you to embed SVG inside of OpenType files, which is awesome and cool.

## Conclusion

The biggest takeaway here is that Google Fonts dominates the web font discussion. Approaches they've taken weigh heavily on the data we've recorded here. The positives here are easy access to web fonts, good font formats (WOFF2), and for-free `unicode-range` configurations. The downsides here are performance drawbacks associated with third-party hosting, different-host requests, and no access to `preload`.

I fully expect that in the future we'll see the "Rise of the Variable Font". This _should_ be paired with a decline in web font requests, as Variable Fonts combine multiple individual font files into a single composite font file. But history has shown us that what usually happens here is that we optimize a thing and then add more things to fill the vacancy.

It will be very interesting to see if color fonts increase in popularity. I expect these to be far more niche than variable fonts but may see a lifeline in the icon font space.

Keep those fonts frosty, y'all.
