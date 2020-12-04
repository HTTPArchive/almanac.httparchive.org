---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: III
chapter_number: 17
title: Jamstack
description: Jamstack chapter of the 2020 Web Almanac covering the use of Jamstack, the performance of popular Jamstack frameworks, as well as an analysis of real-user experience using the Core Web Vitals metadata.
authors: [ahmadawais]
analysts: [denar90, remotesynth]
reviewers: [maedahbatool, phacks]
translators: []
ahmadawais_bio: Ahmad Awais is an award-winning open-source engineer, Google Developers Expert Dev Advocate, Node.js Community Committee Outreach Lead, WordPress Core Dev, and VP of Engineering DevRel at WGA. He has authored various open-source software tools used by millions of developers worldwide. Like his <a href="https://shadesofpurple.pro/more">Shades of Purple</a> code-theme or projects like the <a href="https://github.com/AhmadAwais/corona-cli">corona-cli</a>. Awais loves to teach. Over 20,000 developers are learning from his <a href="https://AhmadAwais.com/courses">courses</a> i.e. <a href="https://nodecli.com/">Node CLI</a>, <a href="https://vscode.pro/">VSCode.pro</a>, and <a href="https://nextjsbeginner.com/">Next.js Beginner</a>. Awais received FOSS community leadership recognition as one of the <a href="https://ahmadawais.com/github-stars/">12 featured GitHub Stars</a>. He is a member of the SmashingMagazine Experts Panel; featured &amp; published author at CSS-Tricks, Tuts+, Scotch.io, SitePoint. You can mostly find him on Twitter <a href="https://twitter.com/MrAhmadAwais/">@MrAhmadAwais</a> where he tweets his <a href="https://awais.dev/odmt">#OneDevMinute</a> developer tips.
discuss: 2053
results: https://docs.google.com/spreadsheets/d/1BCC5Q4tePpTl8TiaGmSxBc9Lh2to7xBfVPMULFOBwvk/
queries: 17_Jamstack
featured_quote: Stats suggest almost twice as many Jamstack sites exist now than in 2019. Developers enjoy a better development experience but that doesn't always translate to a better user experience. Let’s work towards continued progress for improving the real-user experience of browsing Jamstack sites.
featured_stat_1: 154%
featured_stat_label_1: more mobile websites built with Jamstack in 2020
featured_stat_2: 1 gram
featured_stat_label_2: CO2 is emitted by the median Jamstack page load
featured_stat_3: 38%
featured_stat_label_3: Jamstack sites are built using Next.js (three times more than any other framework!)
---

## Introduction

Jamstack is a relatively new concept of an architecture designed to make the web faster, more secure, and easier to scale. It builds on many of the tools & workflows which developers love and which bring maximum productivity.

The core principles of Jamstack are pre-rendering your site pages and decoupling the frontend from the backend. It relies on the idea of delivering the frontend content hosted separately on a CDN provider that uses APIs (for example, a headless CMS) as its backend if any.

The [HTTP Archive][1] crawls [millions of pages][2] every month and runs them through a private instance of [WebPageTest][3] to store key information on every page. (You can learn more about this in our [methodology][4]). In the context of Jamstack, HTTP Archive provides extensive information on the usage of the frameworks and CDNs for the entire web. This chapter consolidates and analyzes many of these trends.

### Goals: Growth of Jamstack & Real User Perf

The goals of this chapter are to estimate and analyze the growth of the Jamstack sites, the performance of popular Jamstack frameworks, as well as an analysis of real user experience using the Core Web Vitals metadata.

## Adoption: What is the overall level of Jamstack adoption amongst all websites, across desktop and mobile?

Our analysis throughout this work looks at desktop and mobile websites. The vast majority of URLs we looked at are in both datasets, but some URLs are only accessed by desktop or mobile devices. This can cause small divergences in the data, and we thus look at desktop and mobile results separately.

{{ figure_markup(
  image="jamstack-adoption.png",
  caption="Jamstack adoption trend.",
  description="Bar chart showing the increase in the level of Jamstack adoption in 2019 and 2020. Mobile has increased from 0.40% to 0.72%. Desktop has increased from 0.27% to 0.68%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1650360073&format=interactive",
  sheets_gid="908645975",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

More than 0.7% of web pages are powered by Jamstack, an increase of over 79% from 2019. This breaks down to 0.72% on desktop, up from 0.40%  in 2019, and 0.68% on mobile, up from 0.27% in 2019. We believe this is a sign of the steady growth of the Jamstack community. You can read more about ours on the [Methodology][4] page.

<figure markdown>

|   Year   | Desktop | Mobile |
| -------- | ------- | ------ |
| 2019     | 0.40%   | 0.27%  |
| 2020     | 0.72%   | 0.68%  |
| % Change | 79%     | 154%   |

<figcaption>{{ figure_link(caption="Jamstack adoption statistics.", sheets_gid="908645975", sql_file="ssg_compared_to_2019.sql") }}</figcaption>
</figure>

The increase in desktop web pages powered by a Jamstack framework is 79% from last year. On mobile, this increase is almost two folds, at 154%. This is a significant growth from 2019, especially for mobile pages.

## Top SSGs YoY: Which are the most common Jamstack frameworks across desktop and mobile sites?

Our analysis counted 12 separate Jamstack frameworks. Only five frameworks had more than 1% share. Next.js, Gatsby, Hugo, Jekyll being the top contenders for the Jamstack market share.

<figure markdown>

| Jamstack   | 2019   | 2020   | % change |
| ---------- | ------ | ------ | -------- |
| Next.js    | 17.91% | 38.38% | 114%     |
| Gatsby     | 5.64%  | 11.97% | 112%     |
| Hugo       | 5.40%  | 6.28%  | 16%      |
| Jekyll     | 4.33%  | 4.82%  | 11%      |
| Hexo       | 1.51%  | 1.65%  | 9%       |
| Gridsome   | 0.08%  | 0.49%  | 555%     |
| Octopress  | 0.61%  | 0.33%  | -45%     |
| Pelican    | 0.25%  | 0.18%  | -28%     |
| VuePress   |        | 0.09%  |          |
| Phenomic   | 0.05%  | 0.02%  | -51%     |
| Saber      |        | 0.01%  |          |

<figcaption>{{ figure_link(caption="Relative % adoption of Jamstack frameworks (0.01% - 38.38% adoption share)", sheets_gid="364341150", sql_file="ssg_compared_to_2019.sql") }}</figcaption>
</figure>

In 2020, most of the Jamstack market share seems distributed between the top four frameworks. Interestingly, Next.js has a 38% usage share. This is over three times the share of the next most popular Jamstack framework, Gatsby.

{{ figure_markup(
  image="jamstack-adoption-share-2020.png",
  caption="Jamstack adoption share 2020.",
  description="Adoption share of the top-five Jamstack frameworks dominated by Next.js taking three times the share of 38% then the next most popular one, Gatsby with ~12% share.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1357804382&format=interactive",
  sheets_gid="364341150",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

It's worth noting here the fact that Next.js websites include a mix of both Statically Generated Sites (SSG) pages and Server Side Rendered (SSR) pages. This is due to the lack of our ability to measure them separately. This means that the analysis may include sites that are mostly or partially server-rendered, meaning they do not fall under the traditional definition of a Jamstack site. Nonetheless, it appears that this hybrid nature of Next.js gives it a competitive advantage over other frameworks hence making it more popular.

{{ figure_markup(
  image="jamstack-adoption-share-2020-pie.png",
  caption="Jamstack adoption share pi chart 2020.",
  description="Pie chart showing the adoption of Jamstack frameworks dominated by Next.js taking three times the share of 38% then the next most popular one, Gatsby with ~12% share.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=115327297&format=interactive",
  sheets_gid="364341150",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

## What’s the impact of Jamstack on the environment?

This year we have sought to better understand the impact of Jamstack sites on the environment. [The information and communications technology (ICT) industry accounts for 2% of global carbon emissions][6], and data centers specifically account for 0.3% of global carbon emissions. This puts the ICT industry’s carbon footprint equivalent to the aviation industry’s emissions from fuel.

Jamstack is often credited for being mindful of performance. In the next section, we look into the carbon emissions of Jamstack websites.

### Page Weight

Our research looked at the average Jamstack page weight in KB and mapped this to CO2 emissions using logic from the [Carbon API][7]. This generated the following results, split by desktop and mobile:

{{ figure_markup(
  image="jamstack-carbon-emissions-per-jamstack-page-view.png",
  caption="Carbon Emissions per Jamstack page view.",
  description="Bar chart showing the grams of CO2 emissions for Jamstack pages by percentile. At the 10th percentile, it is 0.2 grams for desktop and 0.4 for mobile, at the 25th percentile it is 0.5 grams for desktop and 0.6 grams for mobile, at the 50% it is 1.1 grams for desktop and 0.9 grams for mobile, at the 75th percentile 2.2 grams for desktop and 1.8 for mobile, and at the 90th percentile it is 4.2 grams for desktop and 3.5 for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1748236124&format=interactive",
  sheets_gid="881269360",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_ssg_web_page.sql"
  )
}}

We found that the median Jamstack page load resulted in the transfer of 1.5 MB of various assets and thus the emission of 1.1 grams of CO2 for desktop and 0.9 grams for mobile. This was the same for desktop and mobile. The most efficient percentile of Jamstack web pages result in the generation of at least one third less CO2 than the median, whilst the least efficient percentile of Jamstack web pages goes the other way, generating around four times more.

Page weights are important here. The average desktop Jamstack web page loads 1.5 MB of video, image, script, font, CSS, and audio data. 10% of pages, however, load over 4 MB of this data. On mobile devices, the average web page loads 0.7 MB fewer than on desktop, a fact consistent across all percentiles.

### Image formats

Popular image formats are PNG, JPG, GIF, SVG, WebP, and ICO. Of these, [WebP is the most efficient in most situations][8], with WebP lossless images [26% smaller][9] than equivalent PNGs and [25-34% smaller][10] than comparable JPGs. We see, however, that WebP is the second least popular image format across all Jamstack pages, where PNG is the most popular both for mobile and desktop. Only slightly less popular is JPG whereas GIF is almost 20% of all the images used on Jamstack sites. An interesting discovery is SVG which is almost twice as popular on mobile sites as desktop sites.

{{ figure_markup(
  image="jamstack-popularity-of-image-formats.png",
  caption="Popularity of image formats.",
  description="Bar chart showing the percentage of images by type on Jamstack. Desktop follows mobile usage closely. PNG is 32% on desktop and 27% on mobile, JPG is 29% on desktop and 24% on mobile, GIF is 18% on desktop and 19% on mobile, SVG is 15% on desktop and 25% on mobile, WebP is 4% on desktop and 3% on mobile, whereas ICO is 2% on both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1593285227&format=interactive",
  sheets_gid="1626843605",
  sql_file="adoption_of_image_formats_in_ssgs.sql"
  )
}}

### Third-Party Bytes

Jamstack sites often load third party resources, such as external images, videos, scripts, or stylesheets:

{{ figure_markup(
  image="jamstack-third-party-bytes.png",
  caption="Third party bytes.",
  description="Bar chart showing the amount of third party bytes (in KB) for each percentile for Jamstack pages. At the 10th percentile it is 44.64 KB for desktop and 66.69 for mobile, at the 25th percentile it is 150.63 KB for mobile and 245.78 KB for mobile, at the 50% it's 506.27 KB for desktop and 823.56 KB for mobile, at the 75th percentile 1,340.39 KB for desktop and 1,989.24 for mobile and at the 90th percentile it is 3,169.14 KB for desktop and 3,290.07 for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1779247936&format=interactive",
  sheets_gid="1292933800",
  sql_file="third_party_bytes_and_requests_on_ssgs.sql"
  )
}}

We find that the median desktop Jamstack page has 28 third party requests with 506 KB of content, with the mobile equivalent generating 46 requests with 824 KB of content. Whereas 10% of the desktop sites have 132 requests with 3.1MB of content which is only superseded by 168 requests on mobile with 3.2MB of content.

## Core Web Vitals: what is the user experience on Jamstack websites?

Jamstack websites are often said to offer a good user experience. It's what the entire concept of separating the frontend from the backend and hosting it on the CDN edge is all about. We aim to shed light on real-world user experience when using Jamstack websites. It's what we call, the [Core Web Vitals][11].

In this section, we take a look at three important factors which can shed light on our understanding of how users are experiencing Jamstack pages in the wild:

- Largest Contentful Paint (LCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)

These metrics aim to cover the core elements which are indicative of a great web user experience. How about we take a look at the real-world Core Web Vitals statistics of the top-five Jamstack frameworks.

### Largest Contentful Paint

Largest Contentful Paint (LCP) measures the point when the page’s main content has likely loaded and thus the page is useful to the user. It does this by measuring the render time of the largest image or text block visible within the viewport.  LCP is regarded as a good proxy for measuring when the main content of a page is loaded.

This is different from First Contentful Paint (FCP), which measures from page load until content such as text or an image is first displayed. LCP is regarded as a good proxy for measuring when the main content of a page is loaded.

A “good” LCP is regarded as under 2.5 seconds. Hugo, Jekyll, and Hexo have impressive LCP scores all above 50% where Jekyll and Hugo on desktop went up to 91% and 85% on desktop, respectively. Whereas, Gatsby and Next.js sites lagged — scoring 52% and 38% on desktop and 36% and 23% on mobile.

This might be attributed to the fact that most of the sites built with Next.js and Gatsby have complex layouts and high page weights; in comparison with Hugo and Jekyll which are primarily used to produce static content sites with fewer or no dynamic parts. Like you don't have to use React or any other JavaScript framework for what it's worth with Hugo or Jekyll.

As we explored in the section above, high page weights can have a possible impact on the environment. However, this also affects LCP performance, which is either very good or generally bad depending on the Jamstack framework. This can have an impact on the real user experience as well.

{{ figure_markup(
  image="jamstack-real-user-largest-contentful-paint-experiences.png",
  caption="Real-user Largest Contentful Paint experiences.",
  description='Bar chart showing the top-five Jamstack frameworks and whether they have a "good" Largest Contentful Paint experience. Hexo is middling with 66% on desktop and 62% on mobile, Jekyll is the best with 91% on desktop and 74% on mobile, Hugo is second best with 85% on desktop and 69% on mobile, Gatsby has 52% on desktop but only 36% on mobile and Next.js is the lowest with 38% on desktop and 23% on mobile.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=125934259&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

### First Input Delay

First Input Delay (FID) measures the time from when a user first interacts with your site (i.e. when they click a link, tap on a button, or use a custom, JavaScript-powered control) to the time when the browser is actually able to respond to that interaction.

A "fast" FID from a user's perspective would be immediate feedback from their actions on a site rather than a stalled experience. This delay (a pain point) could correlate with interference from other aspects of the site loading when the user tries to interact with the site.

FID is extremely fast for the average Jamstack website on desktop – most popular frameworks score 100% – and mixed but above 80% on mobile. Most Jamstack websites deliver mobile FID on an average site within a reasonable range of the desktop score.

{{ figure_markup(
  image="jamstack-real-user-first-input-delay-experiences.png",
  caption="Real-user First Input Delay experiences.",
  description='Bar chart showing the top-five Jamstack and whether they have a "good" First Input Delay experience. All have a 100% experience score on desktop. For mobile Next.js has 87%, Gatsby 89%, Hugo 84%, Jekyll 82% and Hexo 88%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=736622498&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

The FID scores are generally very good here, but this does not translate to similar LCP scores. As suggested, the weight of individual pages on Jamstack sites in addition to mobile connection quality could play a role in the performance gaps that we see here.

There is a small margin of difference between the resources shipped to desktop and mobile versions of a website. Last year we noted that optimizing for the mobile experience was necessary. Average scores have increased on desktop and mobile, but further attention to mobile experience is required here.

### Cumulative Layout Shift

Cumulative Layout Shift (CLS) measures the instability of content on a web page within the first 500ms of user input. CLS measures any layout changes which happen after user input. This is important on mobile in particular, where the user will tap where they want to take an action – such as a search bar – only for the location to move as additional images, ads, or similar load.

A score of 0.1 or below is good, over 0.25 is poor, and anything in between needs improvement.

{{ figure_markup(
  image="jamstack-real-user-cumulative-layout-shift-experiences.png",
  caption="Real-user Cumulative Layout Shift experiences.",
  description='Bar chart showing the top-five Jamstack and whether they have a "good" Cumulative Layout Shift experience. Next.js has almost a "good experience" at 48% desktop and 49% on mobile sites. Gatsby has 66% for both desktop and mobile sites. Hugo has 74% for desktop and 78% on mobile sites. Jekyll is 82% for both desktop and mobile sites. Hexo is 57% for desktop and 58% on mobile sites.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1984155453&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

The top-five Jamstack frameworks do average here. About 65% of web pages loaded by top-five Jamstack frameworks have a “good” CLS experience, with this figure rising to 82% on mobile. Across all the average desktop and mobile score is 65%. Next.js is barely reaching 50% which is the lowest of all and has work to do here. Educating developers and documenting how to avoid bad CLS scores can go a long way.

## Conclusion

Jamstack, both as a concept and a stack, has picked up importance in the last year. Stats suggest almost twice as many Jamstack sites exist now than in 2019. Developers enjoy a better development experience by separating the frontend from the backend (a headless CMS, serverless functions, or third party services). But what about the real-user experience of browsing Jamstack sites?

We’ve reviewed the adoption of Jamstack, user experience of websites created by these Jamstack frameworks, and for the first time looked at the impact of Jamstack on the environment. We have answered many questions here but leave further questions unanswered.

There are frameworks like Eleventy which we weren't able to measure or analyze since there is no pattern available to determine the usage of such frameworks, which has an impact on the data presented here. Next.js offers both Static Generation and Server Rendering, separating the two in this data is nearly impossible since it also offers incremental Static Generation. Further research building on this chapter will be gratefully received.

Moreover, we have highlighted some areas which need attention from the Jamstack community. We hope there will be progress to share in the 2021 report. Different Jamstack frameworks can start to document how to improve real user experience by looking at Core Web Vitals.

Vercel, one of the CDNs meant to host Jamstack sites, has built an analytics offering called [Real User Experience Score][12]. While other performance measuring tools like [Lighthouse][13] estimate your user's experience by running a simulation in a lab, Vercel's Real Experience Score is calculated using real data points collected from the devices of the actual users of your application.

Probably worth noting here that Vercel created and maintains Next.js, particularly since Next.js had low LCP scores. This could mean we can hope to see a marked improvement next year. This can be extremely helpful information for developers.

Jamstack frameworks are improving the developer experience of building sites. Let’s work towards continued progress for improving the real-user experience of browsing Jamstack sites.

[1]: https://httparchive.org/&sa=D&ust=1607098534235000&usg=AOvVaw2R775VQXUyZjntdk-mHHNW
[2]: https://httparchive.org/reports/state-of-the-web%23numUrls&sa=D&ust=1607098534235000&usg=AOvVaw2BJsY67QPCr_dmVKbyrkaA
[3]: https://webpagetest.org/&sa=D&ust=1607098534236000&usg=AOvVaw2mcp9-aGTu0fsiijaHLsoq
[4]: ./methodology
[6]: https://www.nature.com/articles/d41586-018-06610-y&sa=D&ust=1607098534270000&usg=AOvVaw28OM8HGgA0E501o7_QU3ty
[7]: https://gitlab.com/wholegrain/carbon-api-2-0/-/blob/master/includes/carbonapi.php%23L342&sa=D&ust=1607098534271000&usg=AOvVaw2Vrq3G6Z4WGeTLSfIYyDeF
[8]: https://developers.google.com/speed/webp/&sa=D&ust=1607098534274000&usg=AOvVaw1R_tAYyDQ5vr1Q7ikkVhre
[9]: https://developers.google.com/speed/webp/docs/webp_lossless_alpha_study%23results&sa=D&ust=1607098534274000&usg=AOvVaw0oFiKtSgU274IoAHpN7j13
[10]: https://developers.google.com/speed/webp/docs/webp_study&sa=D&ust=1607098534275000&usg=AOvVaw2uAD0i-dIh1hTBE57FJBm4
[11]: https://web.dev/learn-web-vitals/&sa=D&ust=1607098534277000&usg=AOvVaw3--KzAg_GIDOfpwy1Aqgh-
[12]: https://vercel.com/docs/analytics%23real-experience-score&sa=D&ust=1607098534287000&usg=AOvVaw1rBzBB81ANaXwxyOX8mivi
[13]: https://web.dev/measure/&sa=D&ust=1607098534287000&usg=AOvVaw2Xs1I6xhfgwIUA7l_sFsXl
