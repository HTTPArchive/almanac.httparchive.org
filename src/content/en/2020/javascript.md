---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: I
chapter_number: 2
title: JavaScript
description: JavaScript chapter of the 2020 Web Almanac covering how much JavaScript we use on the web, compression, libraries and frameworks, loading, and source maps.
authors: [tkadlec]
reviewers: [ibnesayeed, jadjoubran, ahmadawais, denar90]
analysts: [rviscomi, paulcalvano]
translators: []
#tkadlec_bio: TODO
discuss: 2038
results: https://docs.google.com/spreadsheets/d/1cgXJrFH02SHPKDGD0AelaXAdB3UI7PIb5dlS0dxVtfY/
queries: 02_JavaScript
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
JavaScript has come a long way from its humble origins as the last of the three web cornerstones—alongside CSS and HTML. Today, JavaScript has started to infiltrate a broad spectrum of the technical stack. JavaScript is no longer confined to the client-side—it's an increasingly popular choice for build tools and server-side scripting, and is creeping its way into the CDN layer as well thanks to edge computing solutions.

Developers love us some JavaScript. The [`script` element is the 6th most popular HTML element in use](https://almanac.httparchive.org/en/2020/markup) (ahead of elements like `p`'s and `i`'s, among countless others). We spend around 14x as many bytes on it as we do on HTML, the building block of the web, and 6x as many bytes as CSS.

{{ need to link to page weight results here, maybe put the chart here too?}}

But nothing is free, and that's especially true for JavaScript—all that code has a cost. Let's dig in and take a closer look at how much script we use, how we use it, and what the fallout is.

## How much JavaScript Do We Use?
We mentioned that the script tag is the 6th most used HTML element. Let's dig in a bit deeper to see just how much JavaScript that actually amounts to.

The median site (the 50th percentile) sends 444kb of JavaScript when loaded on a desktop device, and slightly less (411kb) to a mobile device.

{{ chart showing percentiles for JS use on mobile and desktop}}

It's a bit disappointing that there isn't a bigger gap here. While it's dangerous to make too many assumptions about network or processing power based on whether the device in use is a phone or a desktop (or somewhere in between), it's worth noting that HTTP Archive mobile tests are done by emulating a Moto G4 and a 3G network. In other words, if there was any work being done adapt to less than ideal circumstances by passing down less code, these tests should be showing it.

The trend also seems to be in favor of using more JavaScript, not less. Comparing to last year's results, at the median we see a 13.6% increase in JavaScript as tested on a desktop device, and a 14.5% increase in the amount of JavaScript sent to a mobile device.

{{ chart showing historical trend }}

At least some of this weight seems to be unnecessary. If we look at a breakdown of how much of that JavaScript is unused on any given page load, we see that the median page is shipping 152kb of unused JavaScript. That number jumps to 334kb at the 75th percentile and 567kb at the 90th percentile.

{{ distribution of unused JS bytes}}

As raw numbers, those may or may not jump out at you depending on how much of a performance nut you are, but when you look at it as a percentage of the total JavaScript used on each page, it becomes a bit easier to see just how much waste we're sending.

{{ Maybe a bar graph showing percentage saved at each percentile? Don't think we need another query here since we have the data }}

That 152kb equates to ~37% of the total script size that we send down to mobile devices. There's definitely some room for improvement here.

### Request Count
Another way of looking at how much JavaScript we use is to explore how many JavaScript requests are made on each page. While reducing the number of requests was paramount to maintaing good performance with HTTP 1.1, with HTTP/2 the opposite is the case: breaking JavaScript down into smaller, individual files is ideal for performance. 

{{ Distribution of JavaScript requests by client }}

At the median, pages make 20 JavaScript requests. That's only a minor increase over last year where the median page made 19.

{{ Distribution of JavaScript requests by client, compared to 2019}}

## Where does it come from?
One trend that likely contributes to the increase in JavaScript used on our pages is the seemingly ever-increasing amount of third-party scripts that get added to pages to help with everything from client-side A/B testing and analytics, to serving ads and handling personalization.

Let's drill into that a bit to see just how much third-party script we're serving up.

Righ up until the median, sites serve roughly the same number of first-party scripts as they do third-party scripts—at the median, 9 scripts per page are first-party compared to 10 per page from third-parties. From there, the gap widens a bit—the more scripts a site serves in the total, the more likely it is that the majority of those scripts are from third-party sources.

{{ distribution of JS requests by host for mobile and desktop}}

While the amount of JavaScript requests are similar at the median, the actual size of those scripts is weighted (pun intended) a bit more heavily toward third-party sources. The median site sends 267kb of JavaScript from third-parties to desktop devices compared to 147kb from first-parties. The situation is very similar on mobile, where the median site ships 255kb of third-party scripts compared to 134kb of first-party scripts.

{{ JS bytes by host distribution chart, based on 3P DB }}

## How do we load our JavaScript?
The way we load JavaScript has a significant impact on the overall experience.

JavaScript, by default, is parser blocking. In other words, when the browser discovers a script element, it must pause parsing of the HTML until the script has been downloaded, parsed and executed. It's a significant bottleneck and a common contributor to pages that are slow to render.

We can start to offset some of the cost of loading JavaScript by loading scripts either asynchronously (which only halts the HTML parser during the parse and execution phases, but not during the download phase) or deferred (which doesn't halt the HTML parser at all). Both attributes are only available on external scripts—inline scripts cannot have them applied.

On mobile, external scripts comprise 59.0% of all script elements found. _As an aside, when we talk about how much JavaScript is loaded on a page earlier, that total doesn't account for the size of these inline scripts—because they're part of the HTML document, they're counted against the markup size. This means we load even more script that the numbers show._

{{ pie chart of extneral vs internal }}

Of those external scripts, only 12.2% of them are loaded with the `async` attribute and 6.0% of them are loaded with the `defer` attribute.

{{ pie chart showing async vs defer vs neither }}

Considering that `defer` provides us with the best loading performance (by ensuring downloading the script happens in parallel to other work, and execution waits until after the page can be displayed), we would hope to see that percentage a bit higher. In fact, as it is that 6.0% is a bit misleading.

Back when supporting IE8 and IE9 was more common, it was relatively common to use _both_ the `async` and `defer` attributes. With both attributes in place, any browser supporting both will use `async`. IE8 and IE9, which don't support `async` will fall back to defer.

Nowadays, the pattern is unnecessary for the vast majority of sites and any script loaded with the pattern in place will interrupt the HTML parser when it needs to be executed, instead of deferring until the page has loaded. The pattern is still used surprisingly often, with 11.4% of mobile pages serving at least one script with that pattern in place.

## How do we serve JavaScript?
As with any text-based resource on the web, we can save significant file savings through minimization and compression. Neither of these are new optimizations—they've been around for quite awhile—so we should expect to see them applied in more cases than not.

One of the audits in Lighthouse checks for unminified JavaScript, and provides a score (0 being the worst, 100 being the best) based on the findings. 

{{ distribution of unminified JS scores}}

The chart above shows that most pages tested (77%) get a score of 90 or above, meaning that few unminified scripts are found. 

Overall, only 4.5% of the JavaScript requests recorded are unminified. 

Interestingly, while we've picked on 3rd party requests a bit, this is one area where third-party scripts are doing better than first-party scripts. 82% of the average mobile page's unminified JavaScript bytes come from first-party code.

{{[ pie chart of 3rd vs 1st unminified bytes ]}}

### Compression
Minification is a great way to help reduce file size, but compression is even more effective and, therefore, more important—it provides the bulk of network savings more often than not.

{{ compression mtehods by request pie chart }}

85% of all JavaScript requests have some level of network compression applied. GZip makes up the majority of that, with 65% of scripts having GZip compression applied compared to 20% for Brotli. While the percentage of Brotli (which is more effective than GZip) is low compared to its browser support, it's trending in the right direction, increasing by 5 percentage points in the last year.

Once again, this appears to be an area where third-party scripts are actually doing better than first-party scripts. If we break the compression methods out by first and third-party, we see that 24% of third-party scripts have Brotli applied compared to only 15% of third-party scripts.

{{ scritps by party by compression type }}

Third-party scripts are also less likely to be served without any compression at all: 12% of third-party scripts have neither GZip nor Brotli applied, compared to 19% of first-party scripts.

It's worth taking a closer look those scripts that _don't_ have compression applied. Compression becomes more efficient in terms of savings the more content it has to work with. In other words, if the file is tiny, sometimes the cost of compressing the file doesn't outweight the miniscule reduction in file size.

Thankfully, that's exactly what we see, particularly in third-party scripts where 90% of uncompressed scripts are less than 5kb in size. On the other hand, 49% of uncompressed first-party scripts are less than 5kb and 37% of uncompressed first-party scripts are over 10kb. So while we do see a lot of small uncompressed first-party scripts, there are still quite a few that would benefit from some compression.

## What do we use? {{WIP}}
As we've increasingly used more JavaScript to power our sites and applications, there has also been an increasing demand for open-source libraries and frameworks to help with improving developer productivity and overall code maintainability. Sites that _don't_ wield one of these tools are definitely the minority on today's web—jQuery alone is found on nearly 85% of the mobile pages tracked by HTTP Archive.

It's important that we think critically about the tools we use to build the web and what the trade-offs are, so it makes sense to look closely at what we see in use today.

### Libraries
HTTP Archive uses Wappalyzer to detect technologies in use on a given page. Wappalazyer tracks both JavaScript Libraries (think of these as a collection of snippets or helper functions to ease development, like jQuery) and JavaScript Frameworks (these are more likely scaffolding and provide templating and structure, like React).

The popular libraries in use are largely unchanged from last year, with jQuery continuing to dominate usage and only one of the top 21 libraries falling out (lazy.js, replaced by DataTables). In fact, even the percentages of the top libraries has barely changed from last year. 

{{ table? showing rank, library, percentage and last years rank}}

Last year, Houssein posited a few reasons for why jQuery's dominance continues:

> WordPress, which is used in more than 30% of sites, includes jQuery by default.
> Switching from jQuery to a newer client-side library can take time depending on how large an application is, and many sites may consist of jQuery in addition to newer client-side libraries.

Both are very sound guesses, and it seems the situation hasn't changed much on either front.

In fact, the dominance of jQuery is supported even further when you stop to consider that, of the top 10 libraries, 6 of them are either jQuery or require jQuery in order to be used (jQuery UI, jQuery Migrate, FancyBox, Lightbox and Slick).

### Frameworks


## What's the Impact?
We have a pretty good picture now of how much JavaScript we use, where it comes from and what we use it for. While that's interesting enough on its own, the real kicker is the "so what?" What impact does all this script actually have on the experience of our pages?

The first thing we should consider is what happens with all that JavaScript once its been downloaded. Downloading is only the first part of the JavaScript journey. The browser still has to parse all that script, compile it, and eventually execute it. While browsers are increasingly finding ways to offload 

If you recall, there was only a 30kb difference between what is shipped to a mobile device versus a desktop device. Depending on your point of view, you could be forgiven for not getting to upset about the small gap in the amount of code sent to a desktop browser versus a mobile one—after all, what's an extra 30kb or so at the median, right?

The biggest problem comes when all of that code gets served to a device low to middle-end device, something a bit less like the kind of device most developers are likely to have, and a bit more like the kind of devices you'll see from the majority of people across the world. That relatively small gap between desktop and mobile is much more dramatic when we look at it in terms of processing time.

The median desktop site spends 891ms on the main thread of a browser working with all that JavaScript. The median mobile site, however, spends 1,897ms—over two timese the time spent on the desktop. It's even worse for the long tail of sites. At the 90th percentile, mobile sites spend a staggering 8,921ms of main thread time dealing with JavaScript, compared to 3,838ms for desktop sites.

{{ percentiles of javascript main thread time }}

### Correlating JavaScript Use to Lighthouse Scoring
One way of looking at how this translates into impacting the user experience is to try to correlate some of the JavaScript metrics we've identified earlier with Lighthouse scores for different metrics and categories.

{{ correlations of JS on UX }}

The above chart uses the Pearson coefficient of correlation. There's a long, kinda complex definition of what that means precisely, but the gist is that we're looking for the strength of the correlation between two different numbers. If we find a coefficient of 1, we'd have a direct correlation. A correlation of 0 would show no connection between two numbers. Anything below zero shows a negative correlation—in other words, as one number goes up the other one decreases.

First, there doesn't seem to be much measurable correlation between our JavaScript metrics and the Lighthouse Accessibility score here. That stands in stark opposition to what's been found elsewhere, notably through [WebAim's annual research](https://webaim.org/projects/million/#frameworks).

The most likely explanation for this is that Lighthouse's accessibility tests aren't as comprehensive (yet!) as what is available through other tools, like WebAIM, that have accessibility as their primary focus.

Where we do see a strong correlation is between the amount of JavaScript bytes and both the overall Lighthouse performance score and Total Blocking Time.

The correlation between JavaScript bytes and Lighthouse performance scores is -.47. In other words, as JS bytes increase, Lighthouse performance scores decrease. The overall bytes has a stronger correlation than the amount of third-party scripts, hinting that while they certainly play a role, we can't place all the blame on third-parties.

The connection between Total Blocking Time and JavaScript bytes is even more signficant (.55 for overall bytes, .48 for third-party bytes). That's not too surprising given what we know about all the work browsers have to do to get JavaScript to run in a page—more bytes means more time.

### Security Vulnerabilities
One other helpful audit that Lighthouse runs is to check for known security vulnerabilities in third-party libraries. It does this by detecting which libraries and frameworks are used on a given page, and what version is used of each. Then it checks [Snyk's open-source vulnerability database](https://snyk.io/vuln?type=npm) to see what vulnerabilities have been discovered in the identified tools.

{{ pie chart showing percentage with at least one known vuln }}

According to the audit, 83.5% of mobile pages use a JavaScript library or framework with at least one known security vulnerability.

This is what we call the jQuery effect. Remember how we saw that jQuery is used on a whopping 83% of all pages tested by HTTP Archive? Several older versions of jQuery contain known vulnerabilities, which comprises the vast majority of the vulnerabilities this audit checks.

Of the roughly 5 million or so mobile pages that are tested against, 81% of them contain a vulnerable version of jQuery—a sizeable lead over the second most commonly found vulnerable library—jQuery UI at 15.6%.

{{ Top X most commonly found }}

In other words, get folks to migrate away from those outdated, vulnerable versions of jQuery and we would see the number of sites with known vulnerabilities plummet (at least, until we start finding some in the newer frameworks).

The bulk of the vulnerabilities found fall into the "medium" severity category. 

{{ percentage of pages by vuln severity }}

## Conclusion {{WIP}}
JavaScript is steadily rising in popularity, and there's a lot that's positive about that. It's incredible to consider what we're able to accomplish on today's web thanks to JavaScript that, even a few years ago, would have been unimagineable.

But it's clear we've also got to tread carefully. The amount of JavaScript consistently rises each year (if the stock market were that predictable, we'd all be incredibly wealthy), and that comes with trade-offs. More JavaScript is connected to an increase in processing time which negatively impacts key metrics like Total Blocking Time. And, if we let those libraries languish without keeping them updated, they carry the risk of exposing users through known security vulnerabilities.
