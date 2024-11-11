---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: Jamstack chapter of the 2022 Web Almanac covers quantifying Jamstack sites, the growth of Jamstack, Jamstack-y frameworks and hosting.
authors: [seldo, whitep4nth3r]
reviewers: [tunetheweb]
analysts: [seldo, tunetheweb]
editors: [DesignrKnight]
translators: []
seldo_bio: Laurie has been a web developer since 1996, with occasional breaks to found companies like <a hreflang="en" href="https://www.crunchbase.com/organization/snowball-factory">awe.sm</a> (2010) and <a hreflang="en" href="https://npmjs.com/">npm</a> (2014). He currently works as a Data Evangelist at <a hreflang="en" href="https://netlify.com">Netlify</a>. He loves making the web bigger and better. He thinks one of the best ways to do that is to encourage more people to do web development, by teaching them existing techniques and by building tools and services that make web development easier, so they don't have to learn so much.
whitep4nth3r_bio: Salma writes code for your entertainment. She's a live streamer, software engineer and developer educator, and loves helping people get into tech. After a career as a music teacher and comedian, Salma transitioned to technology in 2014, specializing in front end development and tech leadership for startups, agencies and global e-commerce. She currently works in Developer Relations. <a hreflang="en" href="https://twitch.tv/whitep4nth3r">Find Salma on Twitch</a> to see what she's currently building.
results: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/
featured_quote: Although we can't claim to know exactly what percentage of the web is Jamstack, we can say that around 3% of the web is Jamstack-y, and that this group has been growing strongly for the last 3 years—a great sign for the Jamstack community.
featured_stat_1: ~3%
featured_stat_label_1: Jamstack-y sites on the web in 2022
featured_stat_2: 106%
featured_stat_label_2: Growth of Jamstack-y sites since 2020
featured_stat_3: 36%
featured_stat_label_3: Jekyll sites that are Jamstack-y
---

## Introduction

One of the biggest problems in writing about Jamstack is defining what, exactly, the Jamstack is. Here are three different definitions (we have emphasized some words):

1. Fast and secure sites and apps delivered by pre-rendering files and serving them directly from a CDN, removing the requirement to manage or run web servers.

2. Jamstack is an **architecture** designed to make the web **faster**, more secure, and easier to scale. It builds on many of the tools and workflows which developers love, and which bring maximum productivity.

3. Jamstack is an **architectural approach** that **decouples** the web experience layer from data and business logic, improving flexibility, scalability, **performance**, and maintainability.

All three of the above definitions come from <a hreflang="en" href="https://jamstack.org/">Jamstack.org</a>: in <a hreflang="en" href="https://web.archive.org/web/20200331214426/https://jamstack.org/">2020</a>, <a hreflang="en" href="https://web.archive.org/web/20210924115533/https://jamstack.org/what-is-jamstack/">2021</a>, and <a hreflang="en" href="https://web.archive.org/web/20220809174445/https://jamstack.org/">2022</a> respectively. It's hard to think of a more authoritative source for the definition of Jamstack, so it's fair to say the definition is something of a moving target.

But as the emphasized words demonstrate, there's clearly some continuity: the sites should be fast, they should be pre-rendered, and they should use an architectural approach that decouples "where you get your data" from "how you render your data". Even if a precise dictionary definition is hard to come by, Jamstack developers know what you mean when you say "Jamstack": you've got a site that loads really quickly, renders a lot of its useful content once, at build time, and retrieves additional data (if it needs to) via JavaScript.

<p class="note">Disclosure: the two authors of this report were Netlify employees. Netlify invented the term Jamstack and owns Jamstack.org. This report and the underlying analysis were reviewed and approved by others not affiliated with Netlify.</p>

## Quantifying the Jamstack: what counts?

But the problem gets more tricky when you're trying to put together the 2022 Web Almanac. When you're dealing with millions of websites, "I know it when I see it" can't be your definition. How do we quantify the Jamstack? How do we precisely identify it so we can learn about it? We started by asking ourselves a series of questions.

### Is every static site a Jamstack site?

That seems like it should be an obvious "yes": if the page is flat HTML that renders all at once then it certainly sounds like it should be Jamstack. But what about all those pages people built in the 90s, before JavaScript was popular and most sites were static? Are they Jamstack? It felt like they weren't, not every static site is a Jamstack site. So we tried to think of why.

We landed on the "CDN" aspect of the early definition of Jamstack: it doesn't have to be any specific CDN provider, but part of the definition is definitely the "pre-rendering" part, which implies: you're rendering something, and then caching it. So a Jamstack site should be cached (though whether you cache it yourself, or use a CDN, doesn't matter).

That produces another edge-case: lots of sites are cached! Even completely dynamic sites often cache things for a few minutes to avoid load spikes, and lots of sites are served by CDNs these days, which are intrinsically a cache even if the site's architecture owes nothing to Jamstack patterns. So what's the difference between a normal cached site and a Jamstack site? Cacheability is one part, but what else?

### Does a Jamstack site have to use JavaScript?

We decided a Jamstack site doesn't necessarily use JavaScript. Lots of Jamstack sites do, of course: the "J" in Jamstack used to stand for "JavaScript", after all. But even the earliest definitions of Jamstack made it clear that using JavaScript was optional – a fully static site with no JavaScript has always been Jamstack.

### Does using the Jamstack mean a specific framework?

There are definitely some frameworks that people think of when they think about the Jamstack; so much so that the 2020 and 2021 versions of the Web Almanac [defined the Jamstack exclusively by the frameworks used](../2021/jamstack), focusing on Static Site Generators (SSGs). That's logical enough, but we thought this presented some problems.

First, what about frameworks you can't easily detect? As an example, <a hreflang="en" href="https://www.11ty.dev/">Eleventy</a>, a growing and popular choice in the Jamstack, leaves no trace in the generated HTML; it's invisible to the end user (by default, though you can add a <a hreflang="en" href="https://www.11ty.dev/docs/data-eleventy-supplied/#eleventy-variable">generator tag</a> if you want to). Not counting frameworks that politely get out of the way seems wrong.

Secondly: there are a lot of frameworks! There are dozens of big ones and thousands of smaller ones. Even for the ones that can be detected, we don't always have a good way to detect them. Plus, we agreed that it is definitely possible to build a site that feels "Jamstack-y" without using a framework at all. Plain HTML can definitely be Jamstack.

Thirdly: using a framework that's popular with Jamstack developers by no means guarantees that the site you build will be a Jamstack site. If for architectural reasons it's really slow to render, or dynamically renders every page, it's not going to be a Jamstack site even if you're using the same framework as many Jamstack sites. Not every site has to be Jamstack, and that's okay.

So we decided to ignore frameworks as part of the definition this time around, although as you'll see later, the frameworks you'd expect to find turned up in the results anyway.

### Does a Jamstack site have to be performant?

The only feature common to all three definitions of Jamstack was _performance_. But "fast" is kind of a fuzzy word when it comes to websites: if you've spent any time reading the Web Almanac, you'll know there are dozens of metrics you can use to measure the performance of a website, and lots of good arguments for all of them.

So we thought hard about what a Jamstack site feels like. First was that a Jamstack site renders its initial content very quickly. Of all the metrics we could use, we decided the one that most clearly captured that idea was <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a>, or LCP. This is a measure of the time it takes for the largest item on the page to render. You can pull in extra content via APIs, or not, and still be Jamstack, but you have to render something substantial quickly.

## Defining the metrics

If you are not interested in the nuts and bolts of how we picked a precise definition of Jamstack that we could represent as queries in the HTTP Archive, you can safely skip the next two sections and head down to [the growth of the Jamstack](#the-growth-of-the-jamstack). Understanding our methodology is not critical to you getting actionable insights here.

We knew we wanted to measure: sites that load most of their content very quickly, and can be cached. After a lot of experimentation with different ways of measuring these things, we came up with some specific metrics.

**Largest Contentful Paint (LCP)**: we got the distribution of all LCP times across all pages, picked the median of real-world user data from the <a hreflang="en" href="https://developer.chrome.com/docs/crux">Chrome UX Report</a>, and decided that any site equal or less to the median counted as "loaded most content quickly". This was 2.4 seconds on mobile devices, and 2.0 seconds on desktop devices.

**Cumulative Layout Shift (CLS)**: we wanted to avoid sites that very quickly load a skeleton but then take a long time to load real content. The closest we could get to that is the <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a>, a measure of how much the page layout jumps around while loading. While there are ways to "game" CLS, we still believe it's a reasonable proxy for what we're trying to measure. We liked this measure because we felt that a "jumpy" site also felt less "Jamstack-y", a word we were going to end up using a lot. Again, we picked the median of Chrome UX Report data.

<p class="note">Chrome UX report data rounds CLS data to the nearest 0.05, which is a shame, because the "real" median seems to be around 0.02-0.03, so on mobile it rounds down to zero and on desktop it rounds up to 0.05. Since 0 excludes huge numbers of pages, we decided to use 0.05 as the best available threshold for both mobile and desktop.</a>

**Caching**: this was particularly tricky to quantify, since most home pages, even on Jamstack sites, request revalidation even if they are in practice cached for a long time. We went with a combination of HTTP Headers including `Age`, `Cache-Control`, and `Expires` that we found were common in pages that could be cached for a long time.

We initially thought we'd need another measure to exclude "tiny" sites – sites that load very quickly because they are just a "coming soon" or "Hello world" page that nobody would visit in real life – but the HTTP Archive data is defined by their <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#popularity-eligibility">popularity according to Chrome</a> user visits, and very few of those sites are visited enough to make it into the sample (although example.com is in there!).

A good question is: why not use <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals</a> (CWV) numbers for these metrics? For LCP, our numbers are nearly the same as CWV. For CLS, the CWV team explicitly <a hreflang="en" href="https://web.dev/defining-core-web-vitals-thresholds/#achievability-3">relaxed the requirements</a> (their threshold is more than double the median) which we thought was not representative of a Jamstack experience. So we decided it was fairer to pick the median for both. And CWV does not have a metric for"cacheability".

## "Jamstack-y": a disclaimer

We want to be clear: this is a very, very fuzzy definition of "Jamstack". In fact, we started using the word "Jamstack-y" when doing this work, just to be clear.

The biggest source of error is fundamental: the definition of Jamstack is about _architecture_, but architecture is not something you can determine by crawling the generated HTML, except in very broad strokes. There is simply no way to look at a pile of HTML and tell whether the front-end and the back-end were decoupled. So our measurements, while a best effort, are a rough estimate, and we don't want to misrepresent that.

This methodology both under-counts and over-counts Jamstack sites:

* If your site is static but not decoupled (for instance, <a hreflang="en" href="https://www.squarespace.com/">SquareSpace</a> and <a hreflang="en" href="https://www.wix.com/">Wix</a> sites are clearly tightly coupled to their back-ends) but performs well, we'll over-count it.
* If your Jamstack site is decoupled but you update your content very frequently, your caching strategy might be different than what we look for, so we'll under-count it.
* If your Jamstack site renders very slowly, even though it's decoupled, your LCP number will be high and we will under-count it.
* Conversely, if your non-Jamstack dynamic site is really fast, we might mistake it for Jamstack and over-count it.

Despite all these caveats, we think this year's estimate of "Jamstack-y" sites is an improvement over a strictly SSG-focused definition and gives a better sense of where the web really is today, which is after all the goal of the Almanac.

## The growth of the Jamstack

Applying our new criteria, we measured what percentage of sites in the HTTP Archive qualify as "Jamstack". Because the measures we used in 2020 and 2021 were very different, we also went back and re-measured those samples using the 2022 definitions.

{{ figure_markup(
  caption="Jamstack sites.",
  description="Bar chart showing the percentage of Jamstack sites on desktop and mobile in 2020, 2021 and 2022. In 2020 it was 1.7% for both desktop and mobile, in 2021 it was 2.2% and 2.1% respectively, and in 2022 it was 2.7% on desktop and 3.6% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=2132409776&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack_counts.sql",
  image="jamstack-counts.png"
  )
}}

Our headline finding is that 3.6% of mobile websites in 2022 seem "Jamstack-y" and that this has grown more than 100% since 2020. On desktop, 2.7% of sites are Jamstack-y and that number is also growing, the difference between the two groups being driven primarily by different numbers of sites meeting the CLS threshold, which varies a lot by device because of layout differences. Again, see above for the many caveats about how approximate this is.

The historic figures, with this new definition, are [considerably higher than measured last year](../2021/jamstack#adoption-of-ssgs) when we based the adoption purely on technologies used. This is perhaps not surprising when we consider the limits of detecting certain technologies, coupled with the inclusion of technologies that were not previously considered as Jamstack.

When we as humans randomly sampled the sites in the set we identified, we were mostly satisfied that we were finding sites that, to the best of our abilities to judge, looked and felt like Jamstack sites are supposed to look and feel.

To judge for yourself, and keep us honest, here are 10 "Jamstack-y" sites from our sample, selected entirely at random without curation of any kind:

- <a hreflang="en" href="https://www.cazador-del-sol.de/">www.cazador-del-sol.de</a>
- <a hreflang="en" href="https://snpbooks.org/">snpbooks.org</a>
- <a hreflang="en" href="https://eikounoayumi.jp/">eikounoayumi.jp</a>
- <a hreflang="en" href="https://rochesteronline.precollegeprograms.org/">rochesteronline.precollegeprograms.org</a>
- <a hreflang="en" href="https://surveyforcustomers.com/">surveyforcustomers.com</a>
- <a hreflang="en" href="https://www.shopmate.eu/">www.shopmate.eu</a>
- <a hreflang="en" href="https://docs.saleor.io/">docs.saleor.io</a>
- <a hreflang="en" href="https://www.wildeyebrewing.ca/">www.wildeyebrewing.ca</a>
- <a hreflang="en" href="https://360insurancegroup.com/">360insurancegroup.com</a>
- <a hreflang="en" href="https://144onthehill.co.uk/">144onthehill.co.uk</a>

Whether or not exactly 3.6% (or 2.7% on desktop) of the web is Jamstack – which, because the definition of Jamstack relies on architectural choices we can't verify, we cannot definitively say – what we can be sure of is that Jamstack is growing. The percentage of sites that meet all of our criteria has been getting steadily bigger year on year. The web is getting more "Jamstack-y".

Of course, since our definition is two performance metrics and a caching metric, one way we could be wrong is if the web is just getting more performant in general. To check that, we split the metrics back up (this is mobile data; desktop data was not significantly different):

{{ figure_markup(
  caption="Changes in Jamstack metrics over time on mobile.",
  description="Line chart showing the change in the three Jamstack metrics from 2020, 2021, and 2022. After being largely static between 2020 and 2021, the percentage of CLS has risen in the last year (from 48% to 61%), as has LCP to a lesser extent (from 44% to 50%). The percentage cacheable has stayed largely static at 11% in all three years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=806511079&format=interactive",
  sheets_gid="1068922155",
  sql_file="percentage_jamstack_criteria_per_year.sql",
  image="changes-in-jamstack-counts-over-time.png"
  )
}}

As you can see, there has been some mild improvement in our metrics from 2020 to 2022. However, even the smallest number here – the percentage of sites that meet our caching criteria – is 11-14% of the web, depending on the year and whether you're looking at mobile or desktop. Our set of Jamstack sites is the intersection of these groups; the set of sites that meet all 3 of these criteria at the same time is a lot smaller than any of the individual groups.

So we really are looking at a distinct subset of sites, and the set is growing a lot faster than the performance of the web as a whole is improving. We aren't just measuring "how many fast sites are there".

## Jamstack-y frameworks

Having satisfied ourselves that Jamstack-y sites are real and identifiable, we can now ask some questions about them. This is where it gets fun: because our definition of Jamstack-y doesn't include a framework, we can look at our sites and see what frameworks show up most often in the Jamstack.

We used framework identifications provided for us by Wappalyzer, which means (as we mentioned earlier) some "invisible" frameworks like Eleventy can't be counted or analyzed.

Wappalyzer has a somewhat arbitrary distinction between "web frameworks" and "JavaScript frameworks". Here are the top 10 JavaScript frameworks for the web as a whole:

{{ figure_markup(
  caption="JavaScript frameworks used by all sites.",
  description="Bar chart showing that React is used by 8.2% of desktop and 8.1% of mobile sites, GSAP by 6.9% and 7.7% respectively, Vue.js by 3.1% and 2.8%, RequireJS by 2.3% and 2.3%, styled-components by 1.9% and 1.8%, Handlebars by 1.8% and 1.5%, Backbone.js by 1.7% and 1.4%, AngularJS by 1.4% and 1.1%, Mustache by 1.1% and 1.3%, and finally MooTools is used by 0.9% of desktop and 1.1% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1813867996&format=interactive",
  sheets_gid="496656547",
  sql_file="jamstack_javascript_frameworks.sql",
  image="all-sites-javascript-frameworks.png",
  width=600,
  height=489
  )
}}

And here's the top 10 in Jamstack sites:

{{ figure_markup(
  caption="JavaScript frameworks used by Jamstack sites.",
  description="Bar chart showing React is used by 12.0% of desktop and 12.5% of mobile Jamstack sites, GSAP by 6.4% and 7.3% respectively, Stimulus by 6.0% and 5.6%, RequireJS by 3.4% and 4.5%, Vue.js by 2.3% and 1.9%, styled-components by 1.5% and 1.6%, Mustache by 0.7% and 1.8%, AMP by 1.0% and 1.5%, Emotion by 1.3% and 0.8%, and finally Gatsby is used by 1.2% of desktop and 0.8% of mobile Jamstack sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=691994111&format=interactive",
  sheets_gid="496656547",
  sql_file="jamstack_javascript_frameworks.sql",
  image="jamstack-javascript-frameworks.png",
  width=600,
  height=489
  )
}}

You can see that React is more popular in the Jamstack than the general web, and so is Gatsby. Now let's look at "web frameworks", again as somewhat arbitrarily defined by Wappalyzer:

{{ figure_markup(
  caption="Web frameworks used by all sites.",
  description="Bar chart showing Microsoft ASP.NET is used by 8.4% of desktop and 6.7% of mobile sites, Ruby on Rails by 1.4% and 1.1% respectively, Laravel by 1.0% and 1.0%, Express by 0.8% and 0.7%, Next.js by 0.8% and 0.7%, CodeIgniter by 0.7% and 0.7%, Nuxt.js by 0.5% and 0.4%, Django by 0.3% and 0.3%, Helix Ultimate by 0.3% and 0.3%, and finally Yii is used by 0.3% of desktop and 0.2% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=193748603&format=interactive",
  sheets_gid="1751614355",
  sql_file="jamstack_web_frameworks.sql",
  image="all-sites-web-frameworks.png",
  width=600,
  height=493
  )
}}

A great question here is: why are Next.js and Nuxt.js considered web frameworks, but Vue.js and React considered JavaScript frameworks? But leaving that aside, you can see that Microsoft's ASP.Net framework is extremely popular across the web as a whole, and so is stalwart Ruby on Rails. What does it look like in the Jamstack?

{{ figure_markup(
  caption="Web frameworks used by Jamstack sites.",
  description="Bar chart showing Microsoft ASP.NET is by 3.5% of desktop and 3.1% of mobile Jamstack sites, Symfony by 2.1% and 1.8% respectively, Next.js by 1.8% and 1.4%, Ruby on Rails by 0.7% and 0.8%, Nuxt.js by 0.6% and 0.4%, CodeIgniter by 0.4% and 0.4%, Django by 0.4% and 0.3%, Express by 0.4% and 0.3%, and finally Laravel and Yii are used by 0.2% of both desktop and mobile Jamstack sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1904684465&format=interactive",
  sheets_gid="1751614355",
  sql_file="jamstack_web_frameworks.sql",
  image="jamstack-web-frameworks.png",
  width=600,
  height=493
  )
}}

As you can see, while still the number one web framework, ASP.Net is far less popular in Jamstack, and so is Ruby on Rails. Instead, Jamstack favorite Next.js climbs from fifth to third place, and Nuxt.js from seventh to fifth. A surprising addition is Symfony, which misses the cut for general sites (it's number 11) but climbs all the way to second place in our Jamstack set.

Since Next.js and Nuxt.js are two of the biggest frameworks in the Jamstack community, this is not a huge surprise, but it was again nice to see our framework-agnostic definition correctly identifying "Jamstack-y" sites.

At first glance it might be surprising that ASP.Net is still #1 in the Jamstack-y group, and even more to see PHP-based Symfony hit #2. But there's no reason you can't build a performant, modern site using ASP.NET or PHP: Jamstack is an architectural approach, not any specific list of technologies, so we hope those working in less-trendy tech stacks will find this result encouraging.

What about the SSGs? Wappalyzer has them as a separate category; here are their numbers for both Jamstack-y and general sites (note: we added Nuxt.js and Next.js manually to this list; Wappalyzer does not consider them SSGs but both can be used that way, so we thought it was useful to consider them). Here they are for all sites:

{{ figure_markup(
  caption="Detectable SSGs used by all sites.",
  description="Bar chart showing Next.js is used by 0.74% of desktop and 0.63% of mobile sites, Nuxt.js by 0.45% and 0.40% respectively, Gatsby by 0.22% and 0.21%, Hugo by 0.09% and 0.06%, Jekyll by 0.07% and 0.03%, Docusaurus by 0.02% and 0.01%, Hexo by 0.02% and 0.00%, Gridsome by 0.01% and 0.01%, and finally SitePad and Astro are used by 0.00% of both mobile and desktop sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=582270948&format=interactive",
  sheets_gid="1299424402",
  sql_file="jamstack_ssgs.sql",
  image="all-sites-web-frameworks.png",
  width=600,
  height=496
  )
}}

And here they are for Jamstack sites:

{{ figure_markup(
  caption="Detectable SSGs used by Jamstack sites.",
  description="Bar chart showing Next.js is used by 1.79% of desktop and 1.40% of mobile Jamstack sites, Gatsby by 1.19% and 0.81% respectively, Hugo by 0.77% and 0.49%, Jekyll by 0.85% and 0.34%, Nuxt.js by 0.56% and 0.41%, Docusaurus by 0.19% and 0.09%, Hexo by 0.16% and 0.04%, Gridsome by 0.05% and 0.03%, Octopress by 0.02% and 0.01%, and finally Astro is used by 0.02% of desktop and 0.01% of mobile Jamstack sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1349389169&format=interactive",
  sheets_gid="1299424402",
  sql_file="jamstack_ssgs.sql",
  image="jamstack-web-frameworks.png",
  width=600,
  height=496
  )
}}

As you can see, it's very much the same list, in almost the same order, although Nuxt drops a few spots. This makes intuitive sense, since you'd expect sites generated by SSGs to qualify as Jamstack-y, although they are clearly not the only way to achieve that architectural goal.

The SSGs also make up a much larger percentage of all Jamstack sites than they do of all sites in general, indicating that an SSG is a pretty good way of getting a Jamstack site. However, using an SSG doesn't guarantee you'll make a Jamstack site. Take a look at the total numbers of some of the frameworks in our sample:

<figure>
  <table>
    <thead>
      <tr>
        <th>SSG</th>
        <th>All sites</th>
        <th>Jamstack sites</th>
        <th>Jamstack %</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Next.js</td>
        <td class="numeric">39,928</td>
        <td class="numeric">2,651</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>Nuxt.js</td>
        <td class="numeric">24,600</td>
        <td class="numeric">824</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>Gatsby</td>
        <td class="numeric">12,014</td>
        <td class="numeric">1,765</td>
        <td class="numeric">15%</td>
      </tr>
      <tr>
        <td>Hugo</td>
        <td class="numeric">5,071</td>
        <td class="numeric">1,135</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td>Jekyll</td>
        <td class="numeric">3,531</td>
        <td class="numeric">1,259</td>
        <td class="numeric">36%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="SSGs as a percentage of Jamstack sites (desktop).",
      sheets_gid="1299424402",
      sql_file="jamstack_ssgs.sql",
    ) }}
  </figcaption>
</figure>

For all the SSGs, the percentage of sites that qualified as Jamstack-y by our definition was less than the total number of sites in that framework. Jekyll does best with more than a third of sites in Jekyll also meeting our criteria. Next and Nuxt have particularly low percentages, which is to be expected since even though they can be used as SSGs they are also frequently used to make dynamic sites, and we don't have a way of determining which mode they're in.

## Jamstack-y hosting

We were also interested in where people host their Jamstack-y sites. Would there be a pattern? Once again, we used Wappalyzer's data to identify technologies, this time using their Platform as a Service (PaaS) category.

{{ figure_markup(
  caption="PaaS used by all sites.",
  description="Bar chart showing Amazon Web Services is used by 7.2% of desktop and 5.9% of mobile sites, WP Engine by 1.7% and 1.1% respectively, Azure by 1.1% and 0.9%, WordPress.com by 0.8% and 1.1%, SiteGround by 0.7% and 0.6%, Heroku by 0.4% and 0.3%, Kinsta by 0.4% and 0.3%, Flywheel by 0.3% and 0.2%, Aruba.it by 0.2% and 0.4%, and finally Netlify is used by 0.3% of desktop and 0.2% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=966567769&format=interactive",
  sheets_gid="351874654",
  sql_file="jamstack_paas.sql",
  image="all-sites-paas.png",
  width=600,
  height=473
  )
}}

And here for Jamstack sites:

{{ figure_markup(
  caption="PaaS used by Jamstack sites.",
  description="Bar chart showing Amazon Web Services is used by 10.8% of desktop and 9.4% of mobile Jamstack sites, GitHub Pages by 4.6% and 2.0% respectively, Netlify by 2.4% and 1.7%, Pantheon by 2.1% and 1.7%, Vercel by 1.6% and 1.1%, Acquia Cloud Platform by 1.4% and 1.2%, Cloudways by 0.7% and 0.9%, Azure by 0.7% and 0.7%, Platform.sh by 0.4% and 0.3%, and finally Heroku by 0.3% of desktop and 0.2% of mobile Jamstack sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=437110555&format=interactive",
  sheets_gid="351874654",
  sql_file="jamstack_paas.sql",
  image="jamstack-paas.png",
  width=600,
  height=473
  )
}}

Web giant Amazon Web Services is unsurprisingly dominant in both sets, but there are some significant differences between the global preferences and those of Jamstack-y developers.

WP Engine, Azure, and WordPress.com, hugely popular on the web as a whole, drop significantly in popularity in the Jamstack crowd. GitHub pages, which is #11 on the wider web, is #2 in the Jamstack set. Meanwhile Netlify and Vercel, darlings of Jamstack developers, occupy the #3 and #5 spots, while in the larger web Netlify is at #10 and Vercel at #14 (not shown). Pantheon and Acquia Cloud Platform, neither in the top 10 overall, jump significantly from #11 to #4 and from #12 to #6 respectively.

The change in relative popularity of some of these hosts relative to the wider web is perhaps surprising given that they are not all household names, so we thought it was worth looking at how platform preferences changed from 2021 to 2022 in our sets. Using mobile data, here's how the percentage of Jamstack sites using various platforms changed from 2021 to 2022:

<figure>
  <table>
    <thead>
      <tr>
        <th>PaaS</th>
        <th class="numeric">2021</th>
        <th class="numeric">2022</th>
        <th>Change</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Amazon Web Services</td>
        <td class="numeric">7.00%</td>
        <td class="numeric">9.45%</td>
        <td class="numeric">2.45%</td>
      </tr>
      <tr>
        <td>GitHub Pages</td>
        <td class="numeric">2.62%</td>
        <td class="numeric">1.99%</td>
        <td class="numeric">-0.63%</td>
      </tr>
      <tr>
        <td>Pantheon</td>
        <td class="numeric">1.97%</td>
        <td class="numeric">1.70%</td>
        <td class="numeric">-0.27%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">1.68%</td>
        <td class="numeric">1.72%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>Acquia Cloud Platform</td>
        <td class="numeric">1.37%</td>
        <td class="numeric">1.18%</td>
        <td class="numeric">-0.20%</td>
      </tr>
      <tr>
        <td>Vercel</td>
        <td class="numeric">0.50%</td>
        <td class="numeric">1.10%</td>
        <td class="numeric">0.60%</td>
      </tr>
      <tr>
        <td>Cloudways</td>
        <td></td>
        <td class="numeric">0.91%</td>
        <td class="numeric">N/A</td>
      </tr>
      <tr>
        <td>Azure</td>
        <td></td>
        <td class="numeric">0.67%</td>
        <td class="numeric">N/A</td>
      </tr>
      <tr>
        <td>Platform.sh</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.29%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Heroku</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.22%</td>
        <td class="numeric">-0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="SSGs as a percentage of Jamstack sites (desktop).",
      sheets_gid="1299424402",
      sql_file="jamstack_ssgs.sql",
    ) }}
  </figcaption>
</figure>

GitHub Pages, Pantheon, Acquia Cloud Platform and Heroku all appear to be declining in popularity as a Jamstack hosting choice, while AWS, Netlify, Vercel, and Platform.sh are getting more popular. Note that Cloudways or Azure are not in the 2021 PaaS data, so we can't compare them. We can hypothesize that AWS, Netlify and Vercel are growing in popularity because they're not just hosting—they offer a suite of tools for a developer workflow.

Absent from all the platform lists is web giant Cloudflare, which Wappalyzer categorizes as a CDN rather than a PaaS. Although Cloudflare has a PaaS offering that is very Jamstack-y, called Cloudflare Pages, Wappalyzer data does not distinguish between "hosted on a CDN" and "hosts some assets on that CDN" so we could not include it in this analysis. The author believes that Cloudflare is a very popular Jamstack hosting option, but we do not have good data to verify this.

## Conclusion

Our most important takeaway from this year's analysis is that the Jamstack is hard to measure just by looking at HTTP Archive data. Nevertheless, our ability to use a measurement approach that was agnostic to both platform and framework and find in the resulting data strong correlations to "known" Jamstack platforms and frameworks was an encouraging sign that we have made progress in reliably identifying Jamstack sites in the Archive.

Although we can't claim to know exactly what percentage of the web is Jamstack, we can say that around 3% of the web is Jamstack-y, and that this group has been growing strongly for the last 3 years—a great sign for the Jamstack community.

We also found some frameworks and hosting platforms are more popular in the Jamstack than they are in the wider web. This might be because they are technically better at achieving our criteria, or it might just be because Jamstack developers have community preferences for specific stacks.

Of course, if the Jamstack community prefers certain platforms and frameworks, that becomes a self-reinforcing trend: there will be more documentation and tutorials on how to achieve Jamstack sites using those tools, which will in turn make it easier to build Jamstack sites using those tools. So while we believe (and the data demonstrates) that you can achieve Jamstack-y results with any tech stack, we hope you find this data useful in identifying tools and platforms that might make it easier to achieve a Jamstack site.

We also believe that the final useful takeaway from this exercise in quantifying "what counts as Jamstack" is that now, as a developer, you have a firmer target to aim for when building a Jamstack site. It doesn't mean you pick a specific framework and forget about it: it's about the results. By analyzing your LCP and CLS times you can quantify if your efforts are "Jamstack-y", which is a useful thing to be able to automate.
