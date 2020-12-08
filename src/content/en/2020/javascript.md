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

{{ figure_markup(
  image="page-weight-per-content-type.png",
  caption="Median page weight per content type.",
  description="Bar chart showing the median page weight for desktop and mobile pages across images, JS, CSS, and HTML. The median amounts of bytes for each content type on mobile pages are: 916 KB of images, 411 KB of JS, 62 KB of CSS, and 25 KB of HTML. Desktop pages tend to have significantly heavier images (about 1000 KB) and slightly higher amounts of JS (about 450 KB).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive"
) }}

But nothing is free, and that's especially true for JavaScript—all that code has a cost. Let's dig in and take a closer look at how much script we use, how we use it, and what the fallout is.

## How much JavaScript Do We Use?
We mentioned that the script tag is the 6th most used HTML element. Let's dig in a bit deeper to see just how much JavaScript that actually amounts to.

The median site (the 50th percentile) sends 444kb of JavaScript when loaded on a desktop device, and slightly less (411kb) to a mobile device.

{{ figure_markup(
  image="page-weight-per-content-type.png",
  caption="Distribution of the amount of JavaScript bytes loaded per page.",
  description="Bar chart showing the distribution of JavaScript bytes per page by about 10%. Desktop pages consistently load more JavaScript bytes than mobile pages. The 10th, 25th, 50th, 75th, and 90th percentiles for desktop are: 87 KB, 209 KB, 444 KB, 826 KB, and 1,322 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=441749673&format=interactive",
  sheets_gid="2139688512",
  sql_file="bytes_2020.sql"
) }}

It's a bit disappointing that there isn't a bigger gap here. While it's dangerous to make too many assumptions about network or processing power based on whether the device in use is a phone or a desktop (or somewhere in between), it's worth noting that HTTP Archive mobile tests are done by emulating a Moto G4 and a 3G network. In other words, if there was any work being done adapt to less than ideal circumstances by passing down less code, these tests should be showing it.

The trend also seems to be in favor of using more JavaScript, not less. Comparing to last year's results, at the median we see a 13.6% increase in JavaScript as tested on a desktop device, and a 14.5% increase in the amount of JavaScript sent to a mobile device.

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>2019</th>
        <th>2020</th>
        <th>Change</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">391</td>
        <td class="numeric">444</td>
        <td class="numeric">13.4%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">359</td>
        <td class="numeric">411</td>
        <td class="numeric">14.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Year-over-year change in the median number of JavaScript bytes per page.",
      sheets_gid="86213362",
      sql_file="bytes_2020.sql"
    ) }}
  </figcaption>
</figure>

At least some of this weight seems to be unnecessary. If we look at a breakdown of how much of that JavaScript is unused on any given page load, we see that the median page is shipping 152kb of unused JavaScript. That number jumps to 334kb at the 75th percentile and 567kb at the 90th percentile.

{{ figure_markup(
  image="unused-js-bytes-distribution.png",
  caption="Distribution of the amount of wasted JavaScript bytes per mobile page.",
  description="Bar chart showing the distribution of amount of wasted JavaScript bytes per page. From the 10, 25, 50, 75, and 90th percentiles, the distribution goes: 0, 57, 153, 335, and 568 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=773002950&format=interactive",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

As raw numbers, those may or may not jump out at you depending on how much of a performance nut you are, but when you look at it as a percentage of the total JavaScript used on each page, it becomes a bit easier to see just how much waste we're sending.

{{ figure_markup(
  caption="Percent of the median mobile page's JavaScript bytes that are unused.",
  content="37.22%",
  classes="big-number",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

That 153 KB equates to ~37% of the total script size that we send down to mobile devices. There's definitely some room for improvement here.

### Request Count
Another way of looking at how much JavaScript we use is to explore how many JavaScript requests are made on each page. While reducing the number of requests was paramount to maintainingg good performance with HTTP/1.1, with HTTP/2 the opposite is the case: breaking JavaScript down into [smaller, individual files](https://web.dev/granular-chunking-nextjs/) is [typically better for performance](https://almanac.httparchive.org/en/2019/http2#impact-of-http2). 

{{ figure_markup(
  image="requests-2020.png",
  caption="Distribution of JavaScript requests per page.",
  description="Bar chart showing the distribution of JavaScript requests per page in 2020. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: 4, 10, 19, 34, and 55. Desktop pages only tend to have 0 or 1 more JavaScript request per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=153746548&format=interactive",
  sheets_gid="1804671297",
  sql_file="requests_2020.sql"
) }}

At the median, pages make 20 JavaScript requests. That's only a minor increase over last year where the median page made 19.

{{ figure_markup(
  image="requests-2019.png",
  caption="Distribution of JavaScript requests per page in 2019.",
  description="Bar chart showing the distribution of JavaScript requests per page in 2019. The 10, 25, 50, 75, and 90th percentiles for mobile pages are: 4, 9, 18, 32, and 52. Similar to the 2020 results, desktop pages only tend to have 0 or 1 more request per page. These results are slightly lower than the 2020 results.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=528431485&format=interactive",
  sheets_gid="1983394384",
  sql_file="requests_2019.sql"
) }}

## Where does it come from?
One trend that likely contributes to the increase in JavaScript used on our pages is the seemingly ever-increasing amount of third-party scripts that get added to pages to help with everything from client-side A/B testing and analytics, to serving ads and handling personalization.

Let's drill into that a bit to see just how much third-party script we're serving up.

Righ up until the median, sites serve roughly the same number of first-party scripts as they do third-party scripts—at the median, 9 scripts per page are first-party compared to 10 per page from third-parties. From there, the gap widens a bit—the more scripts a site serves in the total, the more likely it is that the majority of those scripts are from third-party sources.

{{ figure_markup(
  image="requests-by-3p-desktop.png",
  caption="Distribution of the number of JavaScript requests by host for desktop.",
  description="Bar chart showing the distribution of JavaScript requests per host for desktop. The 10, 25, 50, 75, and 90th percentiles for first party requests are: 2, 4, 9, 17, and 30 requests per page. The number of third party requests per page is slightly higher in the upper percentiles by 1 to 6 requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1566679225&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

{{ figure_markup(
  image="requests-by-3p-mobile.png",
  caption="Distribution of the number of JavaScript requests by host for mobile.",
  description="Bar chart showing the distribution of JavaScript requests per host for mobile. The 10, 25, 50, 75, and 90th percentiles for first party requests are: 2, 4, 9, 17, and 30 requests per page. This is the same as for desktop. The number of third party requests per page is slightly higher in the upper percentiles by 1 to 5 requests, similar to dekstop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1465647946&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

While the amount of JavaScript requests are similar at the median, the actual size of those scripts is weighted (pun intended) a bit more heavily toward third-party sources. The median site sends 267kb of JavaScript from third-parties to desktop devices compared to 147kb from first-parties. The situation is very similar on mobile, where the median site ships 255kb of third-party scripts compared to 134kb of first-party scripts.


{{ figure_markup(
  image="bytes-by-3p-desktop.png",
  caption="Distribution of the number of JavaScript bytes by host for desktop.",
  description="Bar chart showing the distribution of JavaScript bytes per host for desktop. The 10, 25, 50, 75, and 90th percentiles for first party bytes are: 21, 67, 147, 296, and 599 KB per page. The number of third party requests per page grows much higher in the upper percentiles by up to 343 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1749995505&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

{{ figure_markup(
  image="bytes-by-3p-mobile.png",
  caption="Distribution of the number of JavaScript bytes by host for mobile.",
  description="Bar chart showing the distribution of JavaScript bytes per host for mobile. The 10, 25, 50, 75, and 90th percentiles for first party bytes are: 18, 60, 134, 275, and 560 KB. These values are consistently smaller than the desktop values, but only by 10-30 KB. Similar to desktop, the third party bytes are higher than first party, on mobile this difference is not as wide, only up to 328 KB at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=231883913&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

## How do we load our JavaScript?
The way we load JavaScript has a significant impact on the overall experience.

JavaScript, by default, is parser blocking. In other words, when the browser discovers a script element, it must pause parsing of the HTML until the script has been downloaded, parsed and executed. It's a significant bottleneck and a common contributor to pages that are slow to render.

We can start to offset some of the cost of loading JavaScript by loading scripts either asynchronously (which only halts the HTML parser during the parse and execution phases, but not during the download phase) or deferred (which doesn't halt the HTML parser at all). Both attributes are only available on external scripts—inline scripts cannot have them applied.

On mobile, external scripts comprise 59.0% of all script elements found. _As an aside, when we talk about how much JavaScript is loaded on a page earlier, that total doesn't account for the size of these inline scripts—because they're part of the HTML document, they're counted against the markup size. This means we load even more script that the numbers show._

{{ figure_markup(
  image="external-inline-mobile.png",
  caption="Distribution of the number of external and inline scripts per mobile page.",
  description="Pie chart showing 41.0% of mobile scripts are inline and 59.0% are external.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1326937127&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Of those external scripts, only 12.2% of them are loaded with the `async` attribute and 6.0% of them are loaded with the `defer` attribute.

{{ figure_markup(
  image="async-defer-mobile.png",
  caption="Distribution of the number of `async` and `defer` scripts per mobile page.",
  description="Pie chart showing 12.2% of external mobile scripts use async, 6.0% use defer, and 81.8% use neither.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=662584253&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Considering that `defer` provides us with the best loading performance (by ensuring downloading the script happens in parallel to other work, and execution waits until after the page can be displayed), we would hope to see that percentage a bit higher. In fact, as it is that 6.0% is a bit misleading.

Back when supporting IE8 and IE9 was more common, it was relatively common to use _both_ the `async` and `defer` attributes. With both attributes in place, any browser supporting both will use `async`. IE8 and IE9, which don't support `async` will fall back to defer.

Nowadays, the pattern is unnecessary for the vast majority of sites and any script loaded with the pattern in place will interrupt the HTML parser when it needs to be executed, instead of deferring until the page has loaded. The pattern is still used surprisingly often, with 11.4% of mobile pages serving at least one script with that pattern in place.

## How do we serve JavaScript?
As with any text-based resource on the web, we can save significant file savings through minimization and compression. Neither of these are new optimizations—they've been around for quite awhile—so we should expect to see them applied in more cases than not.

One of the audits in Lighthouse checks for unminified JavaScript, and provides a score (0 being the worst, 100 being the best) based on the findings. 

{{ figure_markup(
  image="lighthouse-unminified-js.png",
  caption="Distribution of unminified JavaScript Lighthouse adudit scores per mobile page.",
  description="Bar chart showing 0% of mobile pages getting unminified JavaScript Lighthouse audit scores under 0.25, 4% of pages getting a score between 0.25 and 0.5, 10% of pages between 0.5 and 0.75, 8% of pages between 0.75 and 0.9, and 77% of pages between 0.9 and 1.0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=158284816&format=interactive",
  sheets_gid="362705605",
  sql_file="lighthouse_unminified_js.sql"
) }}

The chart above shows that most pages tested (77%) get a score of 90 or above, meaning that few unminified scripts are found. 

Overall, only 4.5% of the JavaScript requests recorded are unminified. 

Interestingly, while we've picked on 3rd party requests a bit, this is one area where third-party scripts are doing better than first-party scripts. 82% of the average mobile page's unminified JavaScript bytes come from first-party code.

{{ figure_markup(
  image="lighthouse-unminified-js-by-3p.png",
  caption="Average distribution of unminified JavaScript bytes by host.",
  description="Pie chart showing that 17.7% of unminified JS bytes are third party scripts and 82.3% are first party scripts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=2073491355&format=interactive",
  sheets_gid="1169731612",
  sql_file="lighthouse_unminified_js_by_3p.sql"
) }}

### Compression
Minification is a great way to help reduce file size, but compression is even more effective and, therefore, more important—it provides the bulk of network savings more often than not.

{{ figure_markup(
  image="compression-method-request.png",
  caption="Distribution of the percent of JavaScript requests by compression method.",
  description="Bar chart showing the distribution of the percent of JavaScript requests by compression method. Desktop and mobile values are very similar. 65% of JavaScript requests use gzip compression, 20% use br (brotli), 15% don't use any compression, and deflate, UTF-8, identity, and none appear as having 0%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=263239275&format=interactive",
  sheets_gid="1270710983",
  sql_file="compression_method.sql"
) }}

85% of all JavaScript requests have some level of network compression applied. GZip makes up the majority of that, with 65% of scripts having GZip compression applied compared to 20% for Brotli. While the percentage of Brotli (which is more effective than GZip) is low compared to its browser support, it's trending in the right direction, increasing by 5 percentage points in the last year.

Once again, this appears to be an area where third-party scripts are actually doing better than first-party scripts. If we break the compression methods out by first and third-party, we see that 24% of third-party scripts have Brotli applied compared to only 15% of third-party scripts.

{{ figure_markup(
  image="compression-method-3p.png",
  caption="Distribution of the percent of mobile JavaScript requests by compression method and host.",
  description="Bar chart showing the distribution of the percent of mobile JavaScript requests by compression method and host. 66% and 64% of first and third party JavaScript requests use gzip. 15% of first party and 24% of third party scripts requests use brotli. And 19% of first party and 12% of third party scripts do not have a compression method set.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1402692197&format=interactive",
  sheets_gid="564760060",
  sql_file="compression_method_by_3p.sql"
) }}

Third-party scripts are also less likely to be served without any compression at all: 12% of third-party scripts have neither GZip nor Brotli applied, compared to 19% of first-party scripts.

It's worth taking a closer look those scripts that _don't_ have compression applied. Compression becomes more efficient in terms of savings the more content it has to work with. In other words, if the file is tiny, sometimes the cost of compressing the file doesn't outweight the miniscule reduction in file size.

Thankfully, that's exactly what we see, particularly in third-party scripts where 90% of uncompressed scripts are less than 5kb in size. On the other hand, 49% of uncompressed first-party scripts are less than 5kb and 37% of uncompressed first-party scripts are over 10kb. So while we do see a lot of small uncompressed first-party scripts, there are still quite a few that would benefit from some compression.

## What do we use?
As we've increasingly used more JavaScript to power our sites and applications, there has also been an increasing demand for open-source libraries and frameworks to help with improving developer productivity and overall code maintainability. Sites that _don't_ wield one of these tools are definitely the minority on today's web—jQuery alone is found on nearly 85% of the mobile pages tracked by HTTP Archive.

It's important that we think critically about the tools we use to build the web and what the trade-offs are, so it makes sense to look closely at what we see in use today.

### Libraries
HTTP Archive uses Wappalyzer to detect technologies in use on a given page. Wappalazyer tracks both JavaScript Libraries (think of these as a collection of snippets or helper functions to ease development, like jQuery) and JavaScript Frameworks (these are more likely scaffolding and provide templating and structure, like React).

The popular libraries in use are largely unchanged from last year, with jQuery continuing to dominate usage and only one of the top 21 libraries falling out (lazy.js, replaced by DataTables). In fact, even the percentages of the top libraries has barely changed from last year. 

{# table? showing rank, library, percentage and last years rank #}

Last year, [Houssein posited a few reasons for why jQuery's dominance continues](https://almanac.httparchive.org/en/2019/javascript#open-source-libraries-and-frameworks):

> WordPress, which is used in more than 30% of sites, includes jQuery by default.
> Switching from jQuery to a newer client-side library can take time depending on how large an application is, and many sites may consist of jQuery in addition to newer client-side libraries.

Both are very sound guesses, and it seems the situation hasn't changed much on either front.

In fact, the dominance of jQuery is supported even further when you stop to consider that, of the top 10 libraries, 6 of them are either jQuery or require jQuery in order to be used (jQuery UI, jQuery Migrate, FancyBox, Lightbox and Slick).

### Frameworks
When we look at the frameworks, we also don't see much of a dramatic change in terms of adoption in the main frameworks that were highlighted last year. Vue.js has seen a significant increase, and AMP grew a bit, but most of them are more less where they were a year ago. 

{# Compare same frameworks from last year's chapter to this year in bar chart? #}

It's worth noting that the detection issue that was noted last year still applies, and still impacts th results here. It's possible that there _has_ been a significant change in popularity for a few more of these tools, but we just don't see it with the way the data is currently collected.

### What it all means?
More interesting to me than the popularity of the tools themselves is the impact they have on the things we build.

First, it's worth noting that while we may think of the usage of one tool versus another, in reality, we rarely only use a single library or framework in production. Only 21% of pages analyzed report only one library or framework. Two or three frameworks are pretty common, and the long-tail gets very long, very quickly.

{# Distribution of number of JS frameworks or libraries on a page #}

When we look at the common combinations that we see in production, most of them are to be expected. Knowing jQuery's dominance, it's unsurprising that most of the popular combinations include jQuery and any number of jQuery related plugins.

{# Top 20? Combos with percentage #}

We do also see a fair amount of more "modern" frameworks, like React, Vue and Angular—paired with jQuery, like as a result of either migration or third-parties including one or the other.

{# React/Angular/Vue % with and without jQuery? #}

More importantly, all these tools typically mean more code and more processing time.

Looking specfically at the frameworks in use, we see that the median JavaScript bytes for pages using them varies dramatically depending on _what_ is being used.

The graph below shows the median bytes for pages where any of the top 35 most commonly detected frameworks were found, broken down by client.

{# Median bytes by JS framework #}

On one of the spectrum are frameworks like React or Angular or Ember, which tend to ship a lot of code regardless of the client. On the other end, we see minimalist frameworks like Alpine.js and Svelte showing very promising results. Defaults are very important, and it seems that by starting with highly performant defaults, Svelte and Alpine are both succeeding (so far...the sample size is pretty small) in creating a lighter set of pages.

We get a very similar picture when looking at main thread time for pages where these tools were detected.

{# Median main thread by JS framework #}

Ember's mobile main thread time jumps out and kind of distorts the graph with how long it takes. Pulling it out makes the picture a bit easier to understand. 

{# Median main thread by JS framework, no Ember #}

Tools like React, GASP and RequireJS tend to spend a lot of time on the main thread of the browser, regardless of whether it's a desktop or mobile page view. The same tools that tend to lead to less code overall—tools like Alpine and Svelte—also tend to lead to lower impact on the main thread.

The gap between the experience a framework provides for desktop and mobile is also worth digging into. Mobile traffic is becoming increasingly dominant, and it's critical that our tools perfom as well as possible for mobile pageviews. The bigger the gap we see between desktop and mobile performance for a framework, the bigger the red flag.

{# Table? Gap in absolute and relative terms #}

As you would expect, there's a gap for all tools in use due to the lower processing power of the emulated Moto G4's. Ember and Polymer seem to jump out as particularly egregious examples, while tools like RxJS and Mustache vary only minorly from desktop to mobile.

## What's the Impact?
We have a pretty good picture now of how much JavaScript we use, where it comes from and what we use it for. While that's interesting enough on its own, the real kicker is the "so what?" What impact does all this script actually have on the experience of our pages?

The first thing we should consider is what happens with all that JavaScript once its been downloaded. Downloading is only the first part of the JavaScript journey. The browser still has to parse all that script, compile it, and eventually execute it. While browsers are increasingly finding ways to offload 

If you recall, there was only a 30kb difference between what is shipped to a mobile device versus a desktop device. Depending on your point of view, you could be forgiven for not getting to upset about the small gap in the amount of code sent to a desktop browser versus a mobile one—after all, what's an extra 30kb or so at the median, right?

The biggest problem comes when all of that code gets served to a low to middle-end device, something a bit less like the kind of devices most developers are likely to have, and a bit more like the kind of devices you'll see from the majority of people across the world. That relatively small gap between desktop and mobile is much more dramatic when we look at it in terms of processing time.

The median desktop site spends 891ms on the main thread of a browser working with all that JavaScript. The median mobile site, however, spends 1,897ms—over two timese the time spent on the desktop. It's even worse for the long tail of sites. At the 90th percentile, mobile sites spend a staggering 8,921ms of main thread time dealing with JavaScript, compared to 3,838ms for desktop sites.

{{ figure_markup(
  image="main-thread-time.png",
  caption="Distribution of main thread time.",
  description="Bar chart showing the distribution of main thread time for desktop and mobile. Mobile is 2-3 times higher throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for desktop are: 137, 356, 891, 1,988, and 3,838 milliseconds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=740020507&format=interactive",
  sheets_gid="2039579122",
  sql_file="main_thread_time.sql"
) }}

### Correlating JavaScript Use to Lighthouse Scoring
One way of looking at how this translates into impacting the user experience is to try to correlate some of the JavaScript metrics we've identified earlier with Lighthouse scores for different metrics and categories.

{{ figure_markup(
  image="correlations.png",
  caption="Correlations of JavaScript on various aspects of user experience.",
  description="Bar chart showing the Pearson coefficient of correlation for various aspects of user experience. The correlation of bytes to the Lighthouse performance score has a coefficient of correlation of -0.47. Bytes and Lighthouse accessibility score: 0.08. Bytes and Total Blocking Time (TBT): 0.55. Third party bytes and Lighthouse performance score: -0.37. Third party bytes and the Lighthouse accessibility score: 0.00. Third party bytes and TBT: 0.48. The number of async scripts per page and Lighthouse performance score: -0.19. Async scripts and Lighthouse accessibility score: 0.08. Async scripts and TBT: 0.36.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=649523941&format=interactive",
  sheets_gid="2035770638",
  sql_file="correlations.sql"
) }}

The above chart uses the Pearson coefficient of correlation. There's a long, kinda complex definition of what that means precisely, but the gist is that we're looking for the strength of the correlation between two different numbers. If we find a coefficient of 1, we'd have a direct correlation. A correlation of 0 would show no connection between two numbers. Anything below zero shows a negative correlation—in other words, as one number goes up the other one decreases.

First, there doesn't seem to be much measurable correlation between our JavaScript metrics and the Lighthouse Accessibility score here. That stands in stark opposition to what's been found elsewhere, notably through [WebAim's annual research](https://webaim.org/projects/million/#frameworks).

The most likely explanation for this is that Lighthouse's accessibility tests aren't as comprehensive (yet!) as what is available through other tools, like WebAIM, that have accessibility as their primary focus.

Where we do see a strong correlation is between the amount of JavaScript bytes and both the overall Lighthouse performance score and Total Blocking Time.

The correlation between JavaScript bytes and Lighthouse performance scores is -0.47. In other words, as JS bytes increase, Lighthouse performance scores decrease. The overall bytes has a stronger correlation than the amount of third-party scripts, hinting that while they certainly play a role, we can't place all the blame on third-parties.

The connection between Total Blocking Time and JavaScript bytes is even more significant (0.55 for overall bytes, 0.48 for third-party bytes). That's not too surprising given what we know about all the work browsers have to do to get JavaScript to run in a page—more bytes means more time.

### Security Vulnerabilities
One other helpful audit that Lighthouse runs is to check for known security vulnerabilities in third-party libraries. It does this by detecting which libraries and frameworks are used on a given page, and what version is used of each. Then it checks [Snyk's open-source vulnerability database](https://snyk.io/vuln?type=npm) to see what vulnerabilities have been discovered in the identified tools.

{{ figure_markup(
  caption="Percent of mobile pages contain at least one vulnerable JavaScript library.",
  content="83.50%",
  classes="big-number",
  sheets_gid="1326928130",
  sql_file="lighthouse_vulnerabilities.sql"
) }}

According to the audit, 83.5% of mobile pages use a JavaScript library or framework with at least one known security vulnerability.

This is what we call the jQuery effect. Remember how we saw that jQuery is used on a whopping 83% of all pages tested by HTTP Archive? Several older versions of jQuery contain known vulnerabilities, which comprises the vast majority of the vulnerabilities this audit checks.

Of the roughly 5 million or so mobile pages that are tested against, 81% of them contain a vulnerable version of jQuery—a sizeable lead over the second most commonly found vulnerable library—jQuery UI at 15.6%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Library</th>
        <th>Vulnerable pages</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">80.86%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">15.61%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">13.19%</td>
      </tr>
      <tr>
        <td>Lo-Dash</td>
        <td class="numeric">4.90%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.61%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.38%</td>
      </tr>
      <tr>
        <td>AngularJS</td>
        <td class="numeric">1.26%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.77%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.53%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top 10 libraries contributing to the highest numbers of vulnerable mobile pages according to Lighthouse.",
      sheets_gid="1803013938",
      sql_file="lighthouse_vulnerable_libraries.sql"
    ) }}
  </figcaption>
</figure>


In other words, get folks to migrate away from those outdated, vulnerable versions of jQuery and we would see the number of sites with known vulnerabilities plummet (at least, until we start finding some in the newer frameworks).

The bulk of the vulnerabilities found fall into the "medium" severity category. 

{{ figure_markup(
  image="vulnerabilities-by-severity.png",
  caption="Distribution of the percent of mobile pages having JavaScript vulnerabilities by severity.",
  description="Pie chart showing 13.7% of mobile pages having no JavaScript vulnerabilities, 0.7% having low severity vulnerabilities, 69.1% having medium severity, and 16.4% having high severity.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1932740277&format=interactive",
  sheets_gid="1409147642",
  sql_file="lighthouse_vulnerabilities_by_severity.sql"
) }}

## Conclusion
JavaScript is steadily rising in popularity, and there's a lot that's positive about that. It's incredible to consider what we're able to accomplish on today's web thanks to JavaScript that, even a few years ago, would have been unimagineable.

But it's clear we've also got to tread carefully. The amount of JavaScript consistently rises each year (if the stock market were that predictable, we'd all be incredibly wealthy), and that comes with trade-offs. More JavaScript is connected to an increase in processing time which negatively impacts key metrics like Total Blocking Time. And, if we let those libraries languish without keeping them updated, they carry the risk of exposing users through known security vulnerabilities.
