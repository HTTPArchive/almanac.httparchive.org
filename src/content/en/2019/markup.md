---
part_number: I
chapter_number: 3
title: Markup
authors: [bkardell]
reviewers: [zcorpan, tomhodgins, matthewp]
---

In 2005, Ian "Hixie" Hickson posted [some analysis of markup data](https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html)  building upon various previous work. Much of this work aimed to investigate class names to see if there were common informal semantics that were being adopted by developers which it might make sense to standardize upon.  Some of this research helped inform new elements in HTML5.

14 years later, it's time to take a fresh look.  Since then, we've also had the introduction of [Custom Elements](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements) and the [Extensible Web Manifesto](https://extensiblewebmanifesto.org/) encouraging that we find better ways to pave the cowpaths by allowing developers to explore the space of elements themselves and allow standards bodies to[ act more like dictionary editors](https://bkardell.com/blog/Dropping-The-F-Bomb-On-Standards.html).  Unlike CSS class names, which might be used for anything, we can be far more certain that authors who used a non-standard *element* really intended this to be an element.  

As of July 2019, the HTTP Archive has begun collecting all used *element* names in the DOM for about 4.4 million desktop home pages, and about 5.3 million mobile home pages which we can now begin to research and dissect. _(Learn more about our [Methodology](../methodology).)_

This crawl encountered *over 5,000 distinct non-standard element names* in these pages, so we capped the total distinct number of elements that we count to the 'top' (explained below) 5,048. 

## Methodology

Names of elements on each page were collected from the DOM itself, after the initial run of JavaScript.

Looking at a raw frequency count isn't especially helpful, even for standard elements:  About 25% of all elements encountered are `<div>`.  About 17% are `<a>`, about 11% are `<span>` -- and those are the only elements that account for more than 10% of occurrences.  Languages are [generally like this](https://www.youtube.com/watch?v=fCn8zs912OE); a small number of terms are astoundingly used by comparison.  Further, when we start looking at non-standard elements for uptake, this would be very misleading as one site could use a certain element a thousand times and thus make it look artificially very popular.  

Instead, as in Hixie's original study,  what we will look at is how many sites include each  element at least once in their homepage.

<aside class="note">Note: This is, itself, not without some potential biases.  Popular products can be used by several sites, which introduce non-standard markup, even "invisibly" to individual authors.  Thus, care must be taken to acknowledge that usage doesn't necessarily imply direct author knowledge and conscious adoption as much as it does the servicing of a common need, in a common way.  During our research, we found several examples of this, some we will call out.</aside>

## Top elements and general info

In 2005, Hixie's survey listed the top few most commonly used elements on pages.  The top 3 were `html`, `head` and `body` which he noted as interesting because they are optional and created by the parser if omitted.  Given that we use the post-parsed DOM,  they'll show up universally in our data.  Thus, we'll begin with the 4th most used element. Below is a comparison of the data from then to now (I've included the frequency comparison here as well just for fun).

<figure id="fig1" markdown>

2005 (per site) | 2019 (per site) | 2019 (frequency)
-- | -- | --
title | title | div
a | meta | a
img | a | span
meta | div | li
br | link | img
table | script | script
td | img | p
tr | span | option

<figcaption>Figure 1. Comparison of the top elements from 2005 to 2019.</figcaption>
</figure>

### Elements per page

<figure id="fig2">
  <img src="/static/images/2019/03_Markup/hixie_elements_per_page.png" alt="Distribution of Hixie's 2005 analysis of element frequencies">
  <figcaption>Figure 2. Distribution of Hixie's 2005 analysis of element frequencies.</figcaption>
</figure>

<figure id="fig3">
    <iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=2141583176&amp;format=interactive"></iframe>
  <figcaption>Figure 3. Element frequencies as of 2019.</figcaption>
</figure>

Comparing the latest data in Figure 3 to that of Hixie's report from 2005 in Figure 2, we can see that the average size of DOM trees has gotten bigger.

<figure id="fig4">
      <img src="/static/images/2019/03_Markup/hixie_element_types_per_page.png" alt="Histogram of Hixie's 2005 analysis of element types per page">
  <figcaption>Figure 4. Histogram of Hixie's 2005 analysis of element types per page.</figcaption>
</figure>

<figure id="fig5">
    <iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=2141583176&amp;format=interactive"></iframe>
  <figcaption>Figure 5. Histogram of element types per page as of 2019.</figcaption>
</figure>

We can see that both the average number of types of elements per page has increased, as well as the maximum numbers of unique elements that we encounter.

## Custom elements

Most of the elements we recorded are custom (as in simply 'not standard'), but discussing which elements are and are not custom can get a little challenging. Written down in some spec or proposal somewhere are, actually, quite a few elements.  For purposes here, we considered 244 elements as standard (though, some of them are deprecated or unsupported):

* 145 Elements from HTML
* 68 Elements from SVG
* 31 Elements from MathML

In practice, we encountered only 214 of these:

* 137 from HTML
* 54 from SVG
* 23 from MathML

In the desktop dataset we collected data for the top 4,834 non-standard elements that we encountered. Of these:

* 155 (3%) are identifiable as very probable markup or escaping errors (they contain characters in the parsed tag name which imply that the markup is broken)
* 341 (7%) use XML-style colon namespacing (though, as HTML, they don't use actual XML namespaces)
* 3,207 (66%) are valid custom element names
* 1,211 (25%) are in the global namespace (non-standard, having neither dash, nor colon)
    * 216 of these we have flagged as *possible* typos as they are longer than 2 characters and have a Levenshtein distance of 1 from some standard element name like `<cript>`,`<spsn>` or `<artice>`. Some of these (like `<jdiv>`), however, are certainly intentional.

Additionally, 15% of desktop pages and 16% of mobile pages contain deprecated elements.

<aside class="note">Note: A lot of this is very likely due to the use of products rather than individual authors continuing to manually create this markup.</aside>

<figure id="fig6">
  <iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1304237557&amp;format=interactive"></iframe>
  <figcaption>Figure 6. Most frequently used deprecated elements.</figcaption>
</figure>

Figure 6 above shows the top 10 most frequently used deprecated elements. Most of these can seem like very small numbers, but perspective matters.

## Perspective on value and usage

In order to discuss numbers about the use of elements (standard, deprecated or custom), we first need to establish some perspective.

<figure id="fig7">
  <iframe width="600" height="778" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1694360298&amp;format=interactive"></iframe>
  <figcaption>Figure 7. Top 150 elements.</figcaption>
</figure>

In Figure 7 above, the top 150 element names, counting the number of pages where they appear, are shown. Note how quickly use drops off.

Only 11 elements are used on more than 90% of pages:

- `<html>`
- `<head>`
- `<body>`
- `<title>`
- `<meta>`
- `<a>`
- `<div>`
- `<link>`
- `<script>`
- `<img>`
- `<span>`

There are only 15 other elements that occur on more than 50% of pages:

- `<ul>`
- `<li>`
- `<p>`
- `<style>`
- `<input>`
- `<br>`
- `<form>`
- `<h2>`
- `<h1>`
- `<iframe>`
- `<h3>`
- `<button>`
- `<footer>`
- `<header>`
- `<nav>`

And there are only 40 other elements that occur on more than 5% of pages.

Even `<video>`, for example, doesn't make that cut. It appears on only 4% of desktop pages in the dataset (3% on mobile). While these numbers sound very low, 4% is actually *quite* popular by comparison.  In fact, only 98 elements occur on more than 1% of pages.

It's interesting, then, to see what the distribution of these elements looks like and which ones have more than 1% use.

<figure id="fig8">
  <a href="https://rainy-periwinkle.glitch.me/scatter/html">
    <img src="/static/images/2019/03_Markup/element_categories.png" alt="Element popularity categorized by standardization">
  </a>
  <figcaption>Figure 8. Element popularity categorized by standardization.</figcaption>
</figure>

Figure 8 shows the rank of each element and which category they fall into.  I've separated the data points into discrete sets simply so that they can be viewed (otherwise there just aren't enough pixels to capture all that data), but they represent a single 'line' of popularity; the left-most being the most common, the right-most being the least common.  The arrow points to the end of elements that appear in more than 1% of the pages.

You can observe two things here. First, the set of elements that have more than 1% use are not exclusively HTML.  In fact, *27 of the most popular 100 elements aren't even HTML* - they are SVG! And there are *non-standard tags at or very near that cutoff too*!  Second, note that a whole lot of HTML elements are used by less than 1% of pages.

So, are all of those elements used by less than 1% of pages "useless"?  Definitely not.  This is why establishing perspective matters.  There are around [two billion web sites on the web](https://www.websitehostingrating.com/internet-statistics-facts/). If something appears on 0.1% of all websites in our dataset, we can extrapolate that this represents perhaps *two million web sites* in the whole web. Even 0.01% extrapolates to _two hundred thousand sites_.  This is also why removing support for elements, even very old ones which we think aren't great ideas, is a very rare occurrence.  Breaking hundreds of thousands or millions of sites just isn't a thing that browser vendors can do lightly.  

Many elements, even the native ones, appear on fewer than 1% of pages and are still very important and successful.  `<code>`, for example, is an element that I both use and encounter a lot.  It's definitely useful and important, and yet it is used on only 0.57% of these pages.  Part of this is skewed based on what we are measuring; home pages are generally *less likely* to include certain kinds of things (like `<code>` for example). Home pages serve a less general purpose than, for example, headings, paragraphs, links and lists. However, the data is generally useful.

We also collected information about which pages contained an author-defined (not native) `.shadowRoot`. About 0.22% of desktop pages and 0.15% of mobile pages had a shadow root.  This might not sound like a lot, but it is roughly 6.5k sites in the mobile dataset and 10k sites on the desktop and is more than several HTML elements.  `<summary>` for example, has about equivalent use on the desktop and it is the 146th most popular element. `<datalist>` appears on 0.04% of homepages and it's the 201st most popular element.

In fact, over 15% of elements we're counting as defined by HTML are outside the top 200 in the desktop dataset .  `<meter>` is the least popular "HTML5 era" element, which we can define as 2004-2011, before HTML moved to a Living Standard model. It is around the 1,000th most popular element.  `<slot>`, the most recently introduced element (April 2016), is only around the 1,400th most popular element.

## Lots of data: real DOM on the real web

With this perspective in mind about what use of native/standard features looks like in the dataset, let's talk about the non-standard stuff.

You might expect that many of the elements we measured are used only on a single web page, but in fact all one of the 5,048 elements appear on more than one page.  The fewest pages an element in our dataset appears on is 15.  About a fifth of them occur on more than 100 pages.  About 7% occur on more than 1,000 pages.

To help analyze the data, I hacked together a [little tool with Glitch](https://rainy-periwinkle.glitch.me).  You can use this tool yourself, and please share a permalink back with the [@HTTPAchive](https://twitter.com/HTTPArchive) along with your observations. (Tommy Hodgins has also built a similar [CLI tool](https://github.com/tomhodgins/hade) which you can use to explore.)

Let's look at some data.

### Products (and libraries) and their custom markup

For several non-standard elements, their prevalence may have more to do with their inclusion in popular third party tools than first party adoption. For example, the `<fb:like>` element is found on 0.3% of pages not because site owners are explicitly writing it out but because they include the Facebook widget. Many of the elements [Hixie mentioned 14 years ago](https://web.archive.org/web/20060203031245/http://code.google.com/webstats/2005-12/editors.html) seem to have dwindled, but others are still pretty huge:

- Popular elements created by [Claris Home Page](https://en.wikipedia.org/wiki/Claris_Home_Page) (whose last stable release was 21 years ago) *still* appear on over 100 pages. [`<x-claris-window>`](https://rainy-periwinkle.glitch.me/permalink/28b0b7abb3980af793a2f63b484e7815365b91c04ae625dd4170389cc1ab0a52.html), for example, appears on 130 pages.
- Some of the `<actinic:*>` elements from British ecommerce provider [Oxatis](https://www.oxatis.co.uk) appear on even more pages. For example, [`<actinic:basehref>`](https://rainy-periwinkle.glitch.me/permalink/30dfca0fde9fad9b2ec58b12cb2b0271a272fb5c8970cd40e316adc728a09d19.html) still shows up on 154 pages in the desktop data.
- Macromedia's elements seem to have largely disappeared. Only one element, [`<mm:endlock>`](https://rainy-periwinkle.glitch.me/permalink/836d469b8c29e5892dedfd43556ed1b0e28a5647066858ca1c395f5b30f8485c.html), appears on our list and on only 22 pages.
- Adobe Go-Live's [`<csscriptdict>`](https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html) still appears on 640 pages in the desktop dataset.
- Microsoft Office's [`<o:p>`](https://rainy-periwinkle.glitch.me/permalink/bc8f154a95dfe06a6d0fdb099b6c8df61727b2289141a0ef16dc17b2b57d3068.html) element still appears on 0.5% of desktop pages, over 20k pages.

But there are plenty of newcomers that weren't in Hixie's original report too, and with even bigger numbers.

- [`<ym-measure>`](https://rainy-periwinkle.glitch.me/permalink/e8bf0130c4f29b28a97b3c525c09a9a423c31c0c813ae0bd1f227bd74ddec03d.html) is a tag injected by Yandex's [Metrica analytics package](https://www.npmjs.com/package/yandex-metrica-watch). It's used on more than 1% of desktop and mobile pages, solidifying its place in the top 100 most used elements. That's huge!
- [`<g:plusone>`](https://rainy-periwinkle.glitch.me/permalink/a532f18bbfd1b565b460776a64fa9a2cdd1aa4cd2ae0d37eb2facc02bfacb40c.html) from the now-defunct Google Plus occurs on over 21k pages.
- Facebook's [`<fb:like>`](https://rainy-periwinkle.glitch.me/permalink/2e2f63858f7715ef84d28625344066480365adba8da8e6ca1a00dfdde105669a.html)  occurs on 14k mobile pages.
- Similarly, [`<fb:like-box>`](https://rainy-periwinkle.glitch.me/permalink/5a964079ac2a3ec1b4f552503addd406d02ec4ddb4955e61f54971c27b461984.html)  occurs on 7.8k mobile pages.
- [`<app-root>`](https://rainy-periwinkle.glitch.me/permalink/6997d689f56fe77e5ce345cfb570adbd42d802393f4cc175a1b974833a0e3cb5.html), which is generally included in frameworks like Angular, appears on 8.2k mobile pages.

Let's compare these to a few of the native HTML elements that are below the 5% bar, for perspective.

<figure id="fig9">
  <iframe width="600" height="370" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=962404708&amp;format=interactive"></iframe>
  <figcaption>Figure 9. Popularity of product-specific and native elements under 5% adoption.</figcaption>
</figure>

You could discover interesting insights like these all day long.

Here's one that's a little different: popular elements could be caused by outright errors in products. For example, [`<pclass="ddc-font-size-large">`](https://rainy-periwinkle.glitch.me/permalink/3214f840b6ae3ef1074291f60fa1be4b9d9df401fe0190bfaff4bb078c8614a5.html) occurrs on over 1,000 sites. This was thanks to a missing space in a popular "as-a-service" kind of product.  Happily, we reported this error during our research and it was quickly fixed.

In his original paper, Hixie mentions that:

<blockquote>The good thing, if we can be forgiven for trying to remain optimistic in the face of all this non-standard markup, is that at least these elements are all clearly using vendor-specific names. This massively reduces the likelihood that standards bodies will invent elements and attributes that clash with any of them.</blockquote>

However, as mentioned above, this is not universal.  Over 25% of the non-standard elements that we captured don't use any kind of namespacing strategy to avoid polluting the global namespace.  For example, here is [a list of 1157 elements like that from the mobile dataset](https://rainy-periwinkle.glitch.me/permalink/53567ec94b328de965eb821010b8b5935b0e0ba316e833267dc04f1fb3b53bd5.html).  Many of those, as you can see, are likely to be non-problematic as they have obscure names, misspellings and so on. But at least a few probably present some challenges.  You'll note, for example,  that `<toast>` (which Googlers [recently tried to propose as `<std-toast>`](https://www.chromestatus.com/feature/5674896879255552)) appears in this list.

There are some popular elements that are probably not so challenging:

- [`<ymaps>`](https://rainy-periwinkle.glitch.me/permalink/2ba66fb067dce29ecca276201c37e01aa7fe7c191e6be9f36dd59224f9a36e16.html) from Yahoo Maps appears on ~12.5k mobile pages.
- [`<cufon>` and `<cufontext>`](https://rainy-periwinkle.glitch.me/permalink/5cfe2db53aadf5049e32cf7db0f7f6d8d2f1d4926d06467d9bdcd0842d943a17.html) from a font replacement library from 2008, appear on ~10.5k mobile pages.
- The [`<jdiv>`](https://rainy-periwinkle.glitch.me/permalink/976b0cf78c73d125644d347be9e93e51d3a9112e31a283259c35942bda06e989.html) element, which appears to be injected by the Jivo chat product, appears on ~40.3k mobile pages,

Placing these into our same chart as above for perspective looks something like this (again, it varies slightly based on the dataset)

<figure id="fig10">
  <iframe width="600" height="370" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=468373762&amp;format=interactive"></iframe>
  <figcaption>Figure 10. Other popular elements in the context of product-specific and native elements with under 5% adoption.</figcaption>
</figure>

The interesting thing about these results is that they also introduce a few other ways that our tool can come in very handy.  If we're interested in exploring the space of the data, a very specific tag name is just one possible measure.  It's definitely the strongest indicator if we can find good "slang" developing.  However, what if that's not all we're interested in?

### Common use cases and solutions

What if, for example, we were interested in people solving common use cases?  This could be because we're looking for solutions to use cases that we currently have ourselves, or for researching more broadly what common use cases people are solving with an eye toward incubating some standardization effort.  Let's take a common example: tabs.  Over the years there have been a lot of requests for things like tabs.  We can use a fuzzy search here and find that there are [many variants of tabs](https://rainy-periwinkle.glitch.me/permalink/c6d39f24d61d811b55fc032806cade9f0be437dcb2f5735a4291adb04aa7a0ea.html).  It's a little harder to count usage here since we can't as easily distinguish if two elements appear on the same page, so the count provided there conservatively simply takes the one with the largest count. In most cases the real number of pages is probably significantly larger.

There are also lots of [accordions](https://rainy-periwinkle.glitch.me/permalink/e573cf279bf1d2f0f98a90f0d7e507ac8dbd3e570336b20c6befc9370146220b.html), [dialogs](https://rainy-periwinkle.glitch.me/permalink/0bb74b808e7850a441fc9b93b61abf053efc28f05e0a1bc2382937e3b78695d9.html), at least 65 variants of [carousels](https://rainy-periwinkle.glitch.me/permalink/651e592cb2957c14cdb43d6610b6acf696272b2fbd0d58a74c283e5ad4c79a12.html), lots of stuff about [popups](https://rainy-periwinkle.glitch.me/permalink/981967b19a9346ac466482c51b35c49fc1c1cc66177ede440ab3ee51a7912187.html), at least 27 variants of [toggles and switches](https://rainy-periwinkle.glitch.me/permalink/2e6827af7c9d2530cb3d2f39a3f904091c523c2ead14daccd4a41428f34da5e8.html), and so on.

Perhaps we could research why we need [92 variants of button related elements that aren't a native button](https://rainy-periwinkle.glitch.me/permalink/5ae67c941395ca3125e42909c2c3881e27cb49cfa9aaf1cf59471e3779435339.html), for example, and try to fill the native gap.

If we notice popular things pop up (like `<jdiv>`, solving chat) we can take knowledge of things we know (like, that that is what `<jdiv>` is about, or `<olark>`) and try to look [at at least 43 things we've built for tackling that](https://rainy-periwinkle.glitch.me/permalink/db8fc0e58d2d46d2e2a251ed13e3daab39eba864e46d14d69cc114ab5d684b00.html) and follow connections to survey the space.

## Conclusion

So, there's lots of data here, but to summarize: 

* Pages have more elements than they did 14 years ago, both on average and max.
* The lifetime of things on home pages is *very* long.  Deprecating or discontinuing things doesn't make them go away, and it might never.
* There is a lot of broken markup out there in the wild (misspelled tags, missing spaces, bad escaping, misunderstandings).
* Measuring what "useful" means is tricky. Lots of native elements don't pass the 5% bar, or even the 1% bar, but lots of custom ones do, and for lots of reasons.  Passing 1% should definitely grab our attention at least, but perhaps so should 0.5% because that is, according to the data, comparatively *very* successful.
* There is already a ton of custom markup out there.  It comes in a lot of forms, but elements containing a dash definitely seem to have taken off.
* We need to increasingly study this data and come up with good observations to help find and pave the cowpaths.

That last one is where you come in.  We'd love to tap into the creativity and curiosity of the larger community to help explore this data using some of the tools (like [https://rainy-periwinkle.glitch.me/](https://rainy-periwinkle.glitch.me/)). Please share your interesting observations and help build our commons of knowledge and understanding.