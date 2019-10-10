(( chapter image ))

In 2005, Ian "Hixie" Hickson posted [some analysis of markup data](https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html)  building upon various previous work. Much of this work aimed to investigate class names to see if there were common informal semantics that were being adopted by developers which it might make sense to standardize upon.  Some of this research helped inform new elements in HTML5.

14 years later, it's time to take a fresh look.  Since then, we've also had the introduction of Custom Elements and the [Extensible Web Manifesto](https://extensiblewebmanifesto.org/) encouraging that we find better ways to pave the cowpaths by allowing developers to explore the space of elements themselves and allow standards bodies to[ act more like dictionary editors](https://bkardell.com/blog/Dropping-The-F-Bomb-On-Standards.html).  Unlike CSS class names which might be used for anything, we can be far more certain that authors who used a non-standard *element* really intended this to be an element.  

As of July 2019, the HTTP Archive has begun collecting all used *element* names in the DOM for about 4.4 million desktop home pages, and about 5.3 million mobile home pages which we can now begin to research and dissect. 

This crawl encountered *over 5000 distinct non-standard element names* in these pages, so we capped the total distinct number of elements that we count to the 'top' (explained below) 5048. 

## Methodology

Names of elements on each page were collected from the DOM itself, post initial run of JavaScript.

Looking at a raw frequency count isn't especially helpful, even for standard elements:  About 25% of all elements encountered are `<div>`.  About 17% are `<a>`, about 10.6% are `<span>` -- and those are the only elements that account for more than 10% of occurrences.  Languages are [generally like this](https://www.youtube.com/watch?v=fCn8zs912OE), a small number of terms are astoundingly used by comparison.  Further, when we start looking at non-standard elements for uptake, this would be very misleading as one site could use a certain element a thousand times and thus make it look artificially very popular.  

Instead, as in Hixie's original study,  what we will look at is how many sites include each  element at least once in their homepage (Note: This is, itself, not without some potential biases.  Popular products can be used by several sites, which introduce non-standard markup, even 'invisibly' to individual authors.  Thus, care must be taken to acknowledge that usage doesn't necessarily imply direct author knowledge and conscious adoption as much as it does the servicing of a common need, in a common way.  During our research, we found several examples of this, some we will call out.)

## Top elements and general info

In 2005, Hixie's survey listed the top few most commonly used elements on pages.  The top 3 were `html`, `head` and `body` which he noted as interesting because they are optional and created by the parser if omitted.  Given that we use the post-parsed DOM,  they'll show up universally in our data.  Thus, we'll begin with the 4th most used element. Below is a comparison of the data from then to now (I've included the frequency comparison here as well just for fun).

<table>
  <tr>
    <td>2005 (per site)</td>
    <td>2019 (per site)</td>
    <td>2019 (frequency)</td>
  </tr>
  <tr>
    <td>title</td>
    <td>title</td>
    <td>div</td>
  </tr>
  <tr>
    <td>a</td>
    <td>meta</td>
    <td>a</td>
  </tr>
  <tr>
    <td>img</td>
    <td>a</td>
    <td>span</td>
  </tr>
  <tr>
    <td>meta</td>
    <td>div</td>
    <td>li</td>
  </tr>
  <tr>
    <td>br</td>
    <td>link</td>
    <td>img</td>
  </tr>
  <tr>
    <td>table</td>
    <td>script</td>
    <td>script</td>
  </tr>
  <tr>
    <td>td</td>
    <td>img</td>
    <td>p</td>
  </tr>
  <tr>
    <td>tr</td>
    <td>span</td>
    <td>option</td>
  </tr>
</table>


### Elements per page

Comparing data to that of Hixie's report from 2005 shows that the average size of DOM trees has gotten bigger.

<table>
  <tr>
    <td>2005</td>
    <td>2019</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>


And also that both the average number of types of elements per page has increased, as well as the maximum numbers of unique elements that we encounter...

<table>
  <tr>
    <td>2005</td>
    <td>2019</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>


## Custom elements?

Most of the elements we recorded are custom (as in simply 'not standard'), but discussing which elements are and are not custom can get a little challenging. Written down in some spec or proposal somewhere are, actually, quite a few elements.  For purposes here, we considered 244 elements as standard (though, some of them are deprecated or unsupported):

* 145 Elements from HTML
* 68 Elements from SVG
* 31 Elements from MathML

In practice, we encountered only 214 of these:

* 137 from HTML
* 54 from SVG
* 23 from MathML

In the desktop dataset we collected data for the top 4,834 non-standard elements that we encountered. Of these:

* 155 (3.21%) are identifiable as very probable markup or escaping errors (they contain characters in the parsed tag name which imply that the markup is broken)
* 341 (7.05%) use XML-style colon namespacing (though, as HTML, they don't use actual XML namespaces)
* 3207 (66.44%) are valid custom element names
* 1211 (25.05%) are in the global namespace (non-standard, having neither dash, nor colon)
    * 216 of these we have flagged as *possible *typos as they are longer than 2 characters and have a Levenshtein distance of 1 from some standard element name like `<cript>`,`<spsn>` or `<artice>`. Some of these (like `<jdiv>`), however, are certainly intentional.

Additionally, 15% of desktop pages and 16% of mobile pages contain deprecated elements (NOTE:  A lot of this is very likely due to the use of products rather than individual authors continuing to manually create this markup.), here's the most common 10 and the number of pages they appear on in each set...

<table>
  <tr>
    <td>element</td>
    <td>mobile</td>
    <td>desktop</td>
  </tr>
  <tr>
    <td>`<center>`</td>
    <td>7.96%</td>
    <td>8.30%</td>
  </tr>
  <tr>
    <td>`<font>`</td>
    <td>7.80%</td>
    <td>8.01%</td>
  </tr>
  <tr>
    <td>`<marquee>`</td>
    <td>1.20%</td>
    <td>1.07%</td>
  </tr>
  <tr>
    <td>`<nobr>`</td>
    <td>0.55%</td>
    <td>0.71%</td>
  </tr>
  <tr>
    <td>`<big>`</td>
    <td>0.47%</td>
    <td>0.53%</td>
  </tr>
  <tr>
    <td>`<frame>`</td>
    <td>0.35%</td>
    <td>0.39%</td>
  </tr>
  <tr>
    <td>`<frameset>`</td>
    <td>0.39%</td>
    <td>0.35%</td>
  </tr>
  <tr>
    <td>`<strike>`</td>
    <td>0.27%</td>
    <td>0.32%</td>
  </tr>
  <tr>
    <td>`<noframes>`</td>
    <td>0.27%</td>
    <td>0.25%</td>
  </tr>
</table>


Most of these can seem like very small numbers, but perspective matters.

## Perspective on Value and Usage

In order to discuss numbers about the use of elements (standard, deprecated or custom), we first need to establish some perspective.

The top 150 element names, counting the number of pages where they appear, are shown in this chart:

(( TODO: there is a corresponding image in the google doc https://docs.google.com/document/d/16TY_pV-FyW35DzuvdlaOiENz6o6PWYpl_RviU-HW7Qc/edit ))

Note how quickly use drops off.

11 elements occur in over 90% `<html>`, `<head>`, `<body>`, `<title>`, `<meta>`, `<a>`,`<div>`, `<link>`, `<script>`, `<img>` and `<span>`. 

Only 15 more elements occur in at least 50% of the home pages (`<ul>`, `<li>`, `<p>`, `<style>`, `<input>`, `<br>`, `<form>`, `<h2>`, `<h1>`, `<iframe>`, `<h3>`, `<button>`, `<footer>`, `<header>`, `<nav>` are the others).  

And only 40 more elements occur on more than 5% of pages.

Even `<video>`, for example, doesn't make that cut.  It appears on only 4.21% of pages in the dataset (on desktop, only 3.03% on mobile).  While these numbers sound very low, 4.21% is actually *quite* popular by comparison.  In fact, only 98 elements occur on more than 1% of pages.  

It's interesting, then, to look at what the distribution of these elements looks like and which ones have more than 1% use.  Below is a chart that shows the rank of each element and which category they fall into.  I've separated the data points into discrete sets simply so that they can be viewed (otherwise there just aren't enough pixels to capture all that data), but they represent a single 'line' of popularity - the left-most being the most common, the right-most being the least common.  The arrow points to the end of elements that appear in more than 1% of the pages.

(( TODO: there is a corresponding image in the google doc https://docs.google.com/document/d/16TY_pV-FyW35DzuvdlaOiENz6o6PWYpl_RviU-HW7Qc/edit ))

You can observe two things here: First, that the set of elements that have more than 1% use are not exclusively HTML.  In fact, *27 of the most popular 100 elements aren't even HTML* - they are SVG! And there are *non-standard tags at or very near that cutoff too*!  Second, note that a whole lot of HTML elements are used by less than 1% of pages.

 

So, are all of those elements used by less than 1% of pages "useless?".  Definitely not.  This is why establishing perspective matters.

`<code>`, for example, is an element that I both use and encounter a lot.  It's definitely important - and yet it is used on only 0.57% of these pages.  Part of this is skewed based on what we are measuring - home pages are generally *less likely* to include certain kinds of things (like `<code>` for example): They serve a less general purpose than, for example, headings, paragraphs, links and lists, however, the data is generally useful.

We also collected information about which pages contained an author defined (not native) `.shadowRoot` -- About 0.22% of the pages on desktop, and 0.15% on mobile.  This might not sound like a lot, but it is roughly 6.5k sites in the mobile dataset and 10k sites on the desktop and is more than several HTML elements.  `<summary>` for example, has about equivalent use on the desktop and it is the 146th most popular element.

`<datalist>` appeared in 0.04% of homepages, it is the 201st most popular element.

In fact, over 15% of elements we're counting as defined by HTML are outside the top 200 in the desktop dataset .  `<meter>` is the least popular "HTML5 era" element  (2004-2011, before HTML moved to a Living Standard model): It is around the 1000th most popular element.  `<slot>`, the most recently introduced element (April 2016), is only around the 1400th most popular element.

# Lots of data: Real DOM on the Real Web

With this perspective in mind about what use of native/standard features looks like in the dataset, let's talk about the non-standard stuff.

You might expect that lots of elements we recorded are used only on a single domain, but in fact, no element we're talking about in this list of 5048 elements is used on only a single domain.  The least number of domains an element in our dataset appears in is 15.  About a fifth of them occur on more than 100 domains.  About 7% occur on more than 1000 domains.

To help analyze the data, I hacked together a [little tool with Glitch](https://rainy-periwinkle.glitch.me) - where possible I link my observations to a page containing the data.  You can use this tool yourself, and please share a permalink back with the [@HTTPAchive](https://twitter.com/HTTPArchive) along with your observations (Tommy Hodgins has also built a similar [CLI tool](https://github.com/tomhodgins/hade) which you can use to explore).

Let's look at some data...  

### Products (and libraries) and their custom markup

As in Hixie's original research, it seems that several of the extremely popular ones have more to do with being a part of popular *products than themselves being universally adopted*. Many of the ones [Ian Hickson mentioned 14 years ago](https://web.archive.org/web/20060203031245/http://code.google.com/webstats/2005-12/editors.html) seem to have dwindled, but not disappeared, but some are still pretty huge.

Those he mentioned as being pervasive and created by [Claris Home Page](https://en.wikipedia.org/wiki/Claris_Home_Page) (whose last stable release was 21 years ago) still appeared on over 100 domains.  [`<x-claris-window>`, for example still appears on 130 mobile domains](https://rainy-periwinkle.glitch.me/permalink/28b0b7abb3980af793a2f63b484e7815365b91c04ae625dd4170389cc1ab0a52.html) (desktop is similar).   Some of the `<actinic:*>` elements he mentioned appear on even more:  [`actinic:basehref`, still shows up on 154 pages in the desktop data](https://rainy-periwinkle.glitch.me/permalink/30dfca0fde9fad9b2ec58b12cb2b0271a272fb5c8970cd40e316adc728a09d19.html).  (These come from British e-commerce provider [Oxatis](https://www.oxatis.co.uk)).

Macromedia's elements seem to have largely disappeared, [only one appears at all on our list, and on only 22 domains](https://rainy-periwinkle.glitch.me/permalink/17d49e765c4f1bfef2a3bd183ee0961fe40f0623d2b9ddf885ee35e1f251d14c.html), however Adobe's Go-Live tags like [`<csscriptdict>`](https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html) [still appear on 640 domains in the desktop dataset](https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html).

[`<o:p>` (created by Microsoft Office) still appears in ~0.46% of desktop pages](https://rainy-periwinkle.glitch.me/permalink/bc8f154a95dfe06a6d0fdb099b6c8df61727b2289141a0ef16dc17b2b57d3068.html) (that's over 20k domains) and [0.32% of mobile page](https://rainy-periwinkle.glitch.me/permalink/66f75e1fd2b8e62a1e77033601d9f65516df3ff8cb1896ce37fbdb932853d5c5.html) (more than a lot of standard HTML elements).

But there are plenty of newcomers that weren't in Hixie's original report too, and with even bigger numbers...

[`<ym-measure>` is used on more than 1% of pages (both desktop and mobile)](https://rainy-periwinkle.glitch.me/permalink/e8bf0130c4f29b28a97b3c525c09a9a423c31c0c813ae0bd1f227bd74ddec03d.html) -- that's *huge* -- putting it in the top 100.  It's a tag injected by Yandex's [Metrica](https://metrica.yandex.com/about) analytics [package](https://www.npmjs.com/package/yandex-metrica-watch).

[`<g:plusone>` from Google's now defunct Google Plus occurs on over 21k domains (both desktop and mobile)](https://rainy-periwinkle.glitch.me/permalink/a532f18bbfd1b565b460776a64fa9a2cdd1aa4cd2ae0d37eb2facc02bfacb40c.html).

[`<fb:like>` occurs on ~13.8k](https://rainy-periwinkle.glitch.me/permalink/2e2f63858f7715ef84d28625344066480365adba8da8e6ca1a00dfdde105669a.html) (mobile, [12.8k on desktop](https://rainy-periwinkle.glitch.me/permalink/a9aceaee7fbe82b3156caf79f48d7ef6b42729bce637f6683dc6c287df52cd5b.html)) and [`<fb:like-box>` occurs on 7.8k](https://rainy-periwinkle.glitch.me/permalink/5a964079ac2a3ec1b4f552503addd406d02ec4ddb4955e61f54971c27b461984.html) (mobile, [7k on desktop](https://rainy-periwinkle.glitch.me/permalink/cc56280bb2d659b4426050b0c135b5c15b8ea4f8090756b567c564dac1f0659b.html))

And [`<app-root>` (generally a framework like Angular) appears on 8.2k mobile sites](https://rainy-periwinkle.glitch.me/permalink/6997d689f56fe77e5ce345cfb570adbd42d802393f4cc175a1b974833a0e3cb5.html) ([8.5k on desktop](https://rainy-periwinkle.glitch.me/permalink/ee3c9dfbcab568e97c7318d9795b9ecbde0605f247b19b68793afc837796aa5c.html)).

Comparing these to a few of the native HTML elements that are below the 5% bar, for perspective, looks something like this (note -- varies slightly based on dataset).

(( TOOD: there is a corresponding image in the google doc https://docs.google.com/document/d/16TY_pV-FyW35DzuvdlaOiENz6o6PWYpl_RviU-HW7Qc/edit ))


You could draw interesting observations like these all day long.

Here's one that's a little different:  Productization causing popularity is evident in outright errors as well. [`<pclass="ddc-font-size-large">` was a parsed tag name which occurred in our dataset in over 1000 sites](https://rainy-periwinkle.glitch.me/permalink/3214f840b6ae3ef1074291f60fa1be4b9d9df401fe0190bfaff4bb078c8614a5.html).  This was thanks to a missing space in a popular 'as a service' kind of product.  Happily, we reported this error during our research and it was quickly fixed.

In his original paper, Hixie mentions that "The good thing, if we can be forgiven for trying to remain optimistic in the face of all this non-standard markup, is that at least these elements are all clearly using vendor-specific names. This massively reduces the likelihood that standards bodies will invent elements and attributes that clash with any of them."  However, as mentioned above, this is not universal.  Over 25% of the non-standard elements that we captured don't use any kind of namespacing strategy to avoid polluting the global namespace.  Here is [a list of 1157 elements like that from the mobile dataset](https://rainy-periwinkle.glitch.me/permalink/53567ec94b328de965eb821010b8b5935b0e0ba316e833267dc04f1fb3b53bd5.html).  Many of those, as you can see, are probably non-problematic as they are obscure names, misspellings and so on -- but at least a few probably present some challenges.  You'll note, for example,  that `<toast>` (which Googlers [recently tried to propose as `<std-toast>`](https://www.chromestatus.com/feature/5674896879255552)) appears in this list.

Among the probably not challenging, but popular ones are some interesting entries:

[`<ymaps>` (from yahoo maps) appears on ~12.5k mobile sites](https://rainy-periwinkle.glitch.me/permalink/2ba66fb067dce29ecca276201c37e01aa7fe7c191e6be9f36dd59224f9a36e16.html) ([~8.3k desktop](https://rainy-periwinkle.glitch.me/permalink/7f365899dc8a5341ed5c234162ee4eb187e99a23fc28cdea31af2322029d8b48.html))

[`<cufon>` and `<cufontext>` from a font replacement library from 2008, appear on ~10.5k of mobile pages](https://rainy-periwinkle.glitch.me/permalink/5cfe2db53aadf5049e32cf7db0f7f6d8d2f1d4926d06467d9bdcd0842d943a17.html) (~[8.7k desktop](https://rainy-periwinkle.glitch.me/permalink/c9371b2f13e7e6ff74553f7918c18807cd9222024d970699e493b2935608a5f2.html)) 

There is also [the `<jdiv>` element appears to be injected by Jivo chat, a popular chat solution which appears on ~40.3k of mobile sites](https://rainy-periwinkle.glitch.me/permalink/976b0cf78c73d125644d347be9e93e51d3a9112e31a283259c35942bda06e989.html) ([~37.6k of desktop pages -- that's roughly ~0.86%)](https://rainy-periwinkle.glitch.me/permalink/98fb3bf4f44c33edabc05439b10a374a121dbbfc5f83af65e00e859039b13acd.html)!

 

Placing these into our same chart as above for perspective looks something like this (again, it varies slightly based on the dataset)


(( TODO: there is a corresponding image in the google doc https://docs.google.com/document/d/16TY_pV-FyW35DzuvdlaOiENz6o6PWYpl_RviU-HW7Qc/edit ))

The interesting thing about these is that they also introduce a few other ways that our tool can come in very handy:  If we're interested in exploring the space of the data, a very specific tag name is just one possible measure.  It's definitely the strongest indicator if we can find good slang developing.  However, what if that's not all we're interested in? 

### Common use cases and solutions

What if, for example, we were interested in people solving common use cases?  This could be because we're looking for solutions to use cases that we currently have ourselves, or for researching more broadly what common use cases people are solving with an eye toward incubating some standardization effort.  Let's take a common example: Tabs.  Over the years there have been a lot of requests for things like tabs.  We can use a fuzzy search here and find that there are [many variants of tabs](https://rainy-periwinkle.glitch.me/permalink/c6d39f24d61d811b55fc032806cade9f0be437dcb2f5735a4291adb04aa7a0ea.html).  It's a little harder to count use here since we can't as easily distinguish if two elements appear on the same page, so the count provided there conservatively simply takes the one with the largest count -- in most cases the real number of domains is probably significantly larger.

There are also [lots of accordions](https://rainy-periwinkle.glitch.me/permalink/e573cf279bf1d2f0f98a90f0d7e507ac8dbd3e570336b20c6befc9370146220b.html), [dialogs](https://rainy-periwinkle.glitch.me/permalink/0bb74b808e7850a441fc9b93b61abf053efc28f05e0a1bc2382937e3b78695d9.html), at least [65 variants of carousels](https://rainy-periwinkle.glitch.me/permalink/651e592cb2957c14cdb43d6610b6acf696272b2fbd0d58a74c283e5ad4c79a12.html), lots of stuff about ['popups'](https://rainy-periwinkle.glitch.me/permalink/981967b19a9346ac466482c51b35c49fc1c1cc66177ede440ab3ee51a7912187.html), at least [27 variants of toggles and switches](https://rainy-periwinkle.glitch.me/permalink/2e6827af7c9d2530cb3d2f39a3f904091c523c2ead14daccd4a41428f34da5e8.html), and so on.

Perhaps we could research why we need [92 variants of button related elements that aren't a native button](https://rainy-periwinkle.glitch.me/permalink/5ae67c941395ca3125e42909c2c3881e27cb49cfa9aaf1cf59471e3779435339.html), for example, and try to fill the native gap.

If we notice popular things pop up (like `<jdiv>`, solving chat) we can take knowledge of things we know (like, that that is what `<jdiv>` is about, or `<olark>`) and try to look [at at least 43 things we've built for tackling that](https://rainy-periwinkle.glitch.me/permalink/db8fc0e58d2d46d2e2a251ed13e3daab39eba864e46d14d69cc114ab5d684b00.html) and follow connections to survey the space.

### In Summary

So, there's lots of data here, but to summarize: 

* Pages have more elements than they did 14 years ago -- both on average and max.
* The lifetime of things on home pages is *very* long.  Deprecating or discontinuing things doesn't make them go away, and it might never.
* There is a lot of broken markup out there in the wild (misspelled tags, missing spaces, bad escaping, misunderstandings)
* Measuring what 'useful' means is tricky -- lots of native elements don't pass the 5% bar, or even the 1% bar, but lots of custom ones do -- and for lots of reasons.  Passing 1% should definitely grab our attention at least, but perhaps so should 0.5% because that is, according to the data, comparatively *very* successful.
* There is already a ton of custom markup out there.  It comes in a lot of forms, but elements containing a dash definitely seem to have taken off.
* We need to increasingly study this data and come up with good observations to help find and pave the cowpaths.

That last one is where you come in:  We'd love to tap into the creativity and curiosity of the larger community to help explore this data using some of the tools (like [https://rainy-periwinkle.glitch.me/](https://rainy-periwinkle.glitch.me/)) -- please share your interesting observations and help build our commons of knowledge and understanding.



