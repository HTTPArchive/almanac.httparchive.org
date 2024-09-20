---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
description: Third Parties chapter of the 2021 Web Almanac covering data of what third parties are used, what they are used for, a deep dive into performance impacts and a discussion on security and privacy impacts.
authors: [tunetheweb]
reviewers: [patrickhulce, andydavies, simonhearne, csswizardry]
analysts: [tunetheweb]
editors: [rviscomi]
translators: []
results: https://docs.google.com/spreadsheets/d/1tf4RMF8SYr6he9tbqt61yuFJ_QK-F-i7XPxaPkpKSDI/
tunetheweb_bio: Barry Pollard is a software developer and author of the Manning book <a hreflang="en" href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a>. He thinks the web is amazing but wants to make it even better. You can find him tweeting <a href="https://twitter.com/tunetheweb">@tunetheweb</a> and blogging at <a hreflang="en" href="https://www.tunetheweb.com">www.tunetheweb.com</a>.
featured_quote: Third parties are integral to the web. In many ways they are the web—without the prevalence of third-parties websites would be harder to build, and be less feature rich.
featured_stat_1: 94.4%
featured_stat_label_1: Sites using third parties
featured_stat_2: 1,626 ms
featured_stat_label_2: YouTube embed main-thread blocking time
featured_stat_3: 45.9%
featured_stat_label_3: Requests which are 3rd party
---

## Introduction

Ah third parties, the solution to so many problems on the web… and cause of so many others! Fundamentally, the web has always been about interconnectivity and sharing. Using third-party content on a website is a natural extension of that and was first set into motion with the introduction of the <a hreflang="en" href="https://www.w3.org/MarkUp/html-spec/html-spec_5.html#SEC5.10">`<img>` element in HTML 2.0</a>; we have been able to hyperlink external content straight into our documents ever since. This has only grown with the introduction of [CSS](./css), and [JavaScript](./javascript) allowing part (or all!) of the page to be changed completely just by including a seemingly simple `<link>` or `<script>` element.

Third parties provide a never-ending collection of images, videos, fonts, tools, libraries, widgets, trackers, ads, and anything else you can imagine embedding into our web pages. This enables even the most non-technical to be able to create and publish content to the web. Without third parties, the web would likely be a very boring, text-based, academic medium instead of the rich, immersive, complex platform that is so integral to the lives of many of us today.

However, there is a dark side to using third-party content on the web. An innocuous inclusion of an image or a helpful library opens the floodgates to all sorts of [performance](./performance), [privacy](./privacy), and [security](./security) implications that many developers do not consider fully. Speak to any professionals in those industries and they will lament the use of third-party content making their lives more difficult. Scrutiny is surely only going to grow with performance getting extra attention through the <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals initiative from Google</a>, increased focus on privacy from governments and individuals, and the ever-increasing threat of exploitable vulnerabilities and malicious threats inherent to the web.

In this chapter we're going to have a look at the state of third parties on the web: how much are we using them, what are we using them for, and has our usage changed over the last year, particularly given the three concerns listed above? These are questions I'm looking to answer here.

## Definitions

We may have different ideas of what constitutes a "third party" or "using third-party content", so we'll start with a definition of what we consider a third party to be for this chapter:

### "Third party"

We use the same definition of third party as we have in the [2019](../2019/third-parties) and [2020](../2020/third-parties) editions, though a slightly different interpretation of it will exclude one category this year, as we'll discuss in the next section.

A third party is an entity outside the primary site-user relationship, i.e. the aspects of the site not directly within the control of the site owner but present with their approval. For example, the Google Analytics script is an example of a common third-party resource.

Third-party resources are:
- Hosted on a shared and public origin
- Widely used by a variety of sites
- Uninfluenced by an individual site owner

To match these goals as closely as possible, the formal definition used throughout this chapter of a third-party resource is one that originates from a domain whose resources can be found on at least 50 unique pages in the HTTP Archive dataset.

Note that using these definitions, third-party content served from a first-party domain is counted as first-party content. For example, self-hosting Google Fonts or `bootstrap.css` is counted as _first-party content_.

Similarly, first-party content served from a third-party domain is counted as third-party content—assuming it passes the "more than 50 pages criteria", which it may well do based on domain, even if the resource itself is unique to that website. For example, first-party images served over a CDN on a third-party domain are considered _third-party content_.

### Third-party categories

This year we will, again, be drawing heavily on the <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/master/data/entities.js">third-party-web</a> repository from <a hreflang="en" href="https://twitter.com/patrickhulce">Patrick Hulce</a> to help us identify and categorize third parties. This repository categorizes commonly used third-party URLs into the following categories:
- **Ad** - These scripts are part of advertising networks, either serving or measuring.
- **Analytics** - These scripts measure or track users and their actions. There's a wide range in impact here depending on what's being tracked.
- **CDN** - These are a mixture of publicly hosted open source libraries (e.g. jQuery) served over different public CDNs and private CDN usage.
- **Content** - These scripts are from content providers or publishing-specific affiliate tracking.
- **Customer Success** - These scripts are from customer support/marketing providers that offer chat and contact solutions. These scripts are generally heavier in weight.
- **Hosting** - These scripts are from web hosting platforms (WordPress, Wix, Squarespace, etc.).
- **Marketing** - These scripts are from marketing tools that add popups/newsletters/etc.
- **Social** - These scripts enable social features.
- **Tag Manager** - These scripts tend to load lots of other scripts and initiate many tasks.
- **Utility** - These scripts are developer utilities (API clients, site monitoring, fraud detection, etc.).
- **Video** - These scripts enable video player and streaming functionality.
- **Other** - These are miscellaneous scripts delivered via a shared origin with no precise category or attribution.

<p class="note">Note: The CDN category here includes providers that provide resources on public CDN domains (e.g. bootstrapcdn.com, cdnjs.cloudflare.com, etc.) and does not include resources that are simply served over a CDN. For example, putting Cloudflare in front of a page would not influence its first-party designation according to our criteria.</p>

One change that we have made to our methodology this year is to remove the Hosting category from our analysis. If you happen to use WordPress.com for your blog, or Shopify for your ecommerce platform, then we're going to ignore other requests for those domains by that site as not truly "third-party", as they are in many ways part of hosting on those platforms. Similar to the note above, we do not consider CDNs in front of a page to be "third party". In reality this made very little difference to the numbers, but we feel it's a more accurate reflection of what we should consider "third party" by the above definition, and also aligns more closely with how the other chapters use this term.

### Caveats

- All data presented here is based on a non-interactive, cold load. These values could start to look quite different after user interaction.
- The pages are tested from servers in the US with no cookies set, so third parties requested after opt-in are not included. This will especially affect pages hosted and predominantly served to countries in scope for the <a href="https://en.wikipedia.org/wiki/General_Data_Protection_Regulation">General Data Protection Regulation</a>, or other similar legislation.
- Only the home pages are tested. Other pages may have different third-party requirements.
- Some of the lesser-used third-party domains are grouped into the _unknown_ category. As part of this analysis, we submitted more categories for the top-used domains to improve the third-party-web dataset.

Learn more about our [methodology](./methodology).

## Prevalence

So how much are third parties used? Well, the answer is a lot!

{{ figure_markup(
  caption="Percentage of mobile sites using at least one third-party resource.",
  content="94.4%",
  classes="big-number",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party.sql"
)
}}

A staggering 94.4% of mobile sites and 94.1% of desktop sites use at least one third-party resource. Even with our newer restrictive definition of third parties, this represents a continued growth from when the Web Almanac started in [2019](../2019/third-parties).

{{ figure_markup(
  image="third-parties-websites-using-third-parties-by-year.png",
  caption="Websites using third parties by year.",
  description="Bar chart showing the number of websites using third parties over the last three years, split by desktop and mobile. On desktop 89.1% of websites used a third party in 2019, followed by 93.9% in 2020, and 94.1% in 2021. On mobile 88.5% used a third party in 2019, followed by 94.0% in 2020, and 94.4% in 2021",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1728778967&format=interactive",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party.sql"
  )
}}

Rerunning the last three annual Web Almanac datasets with the new, stricter definition, we see in the chart above that our usage of third parties on our website has grown slightly on last year by 0.2% on desktop and 0.4% on mobile.

{{ figure_markup(
  caption="Percentage of requests which are third-party.",
  content="45.9%",
  classes="big-number",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party.sql"
)
}}

45.9% of requests on mobile and 45.1% of requests on desktop are third-party requests, which is similar to [last year's results](../2020/third-parties).

It would appear that privacy-preserving regulations like <a href="https://en.wikipedia.org/wiki/General_Data_Protection_Regulation">GDPR</a> and <a href="https://en.wikipedia.org/wiki/California_Consumer_Privacy_Act">CCPA</a> are not dampening our appetite for third-party usage. Though it should be remembered that our [methodology](./methodology) is to test websites from US data centers and so may be served different content because of that.

So, we know nearly all sites use third parties, but how many do they use?

{{ figure_markup(
  image="third-parties-number-of-third-parties-per-website.png",
  caption="Number of third parties per website.",
  description="Bar chart showing the number of third party domains per website on desktop and mobile at various percentiles. At the 10th percentile both desktop and mobile have 2 third parties per site, at the 25th it's 9 third parties on desktop and 8 on mobile, at the 25th it's 23 and 21 respectively, at the 50th it's 50 and 46, and at the 75th percentile it's 91 and 89 respectively.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=2111523872&format=interactive",
  sheets_gid="1338630434",
  sql_file="distribution_of_websites_by_number_of_third_parties.sql"
  )
}}

Looking at the spread, we see there is a large variance with websites only using two third parties–measured as the number of distinct third-party hostnames–at the 10th percentile, up to 89 or 91 at the 90th percentile.

Note that the 90th percentile is down a bit from [last year's analysis](../2020/third-parties#fig-2), where we had 104 and 106 third parties for desktop and mobile respectively, but this looks to be due to restricting our domains to assets used by 50 websites or more this year, which was not done for this statistic last year.

The median website uses 21 third parties on mobile and 23 on desktop, which still seems like quite a lot!

### Third party prevalence by rank

{{ figure_markup(
  image="third-parties-websites-using-third-parties-by-rank.png",
  caption="Websites using third parties by rank.",
  description="Bar chart showing the percentage of websites using third parties by mobile and desktop, across various rank categories. For the top 1,000 websites 96.6% of desktop 96.9% of mobile sites use websites, which is similar to the top 10,000 sites at 96.8% and 96.6% respectively, and the top 100,000 at 94.5% and 94.4%, and the top million websites at 93.4% and 93.3% and finally all sites are at 94.1% and 94.4% respectively.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=871714070&format=interactive",
  sheets_gid="1082574922",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

This year we have access to the <a hreflang="en" href="https://developers.google.com/web/updates/2021/03/crux-rank-magnitude">Chrome UX Report (CrUX) "rank"</a> for each website. This is a popularity assignment for each site, which allows us to group our data into the top 1,000 most-used sites (based on page views), top 10,000 most-used sites, etc. Slicing the data by this popularity rank shows that there is a slight decrease in third-party usage for the less popular websites, but it never dips below 93.3%, again reiterating that pretty much all websites love to include at least one third party.

However, what does change is the number of third parties used by website:

{{ figure_markup(
  image="third-parties-per-website-by-rank.png",
  caption="Median number of third parties per website by rank.",
  description="Bar chart showing the median number of third party domains per website by desktop and mobile across various rankings. For the top 1,000 websites, 47 third parties are used on desktop and 40 on mobile, this drops to 42 and 39 respectively for the top 10,000 websites, to 32 and 30 for the top 100,000 websites, 26 and 25 for the top million websites, and 23 and 21 for all websites.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1770094484&format=interactive",
  sheets_gid="1338630434",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

Looking at the median (50th percentile) statistics, we see a marked decline as we go up the rankings, with the most popular websites using twice as many third parties as the whole dataset. We'll see in a moment that that is driven almost entirely by ads. It is perhaps unsurprising that these are much more prevalent on more popular websites, with more eyeballs to monetize.

## Third-party type

Our analysis shows we're using third parties a lot, but what are we using them for? Looking at the categories of each third-party request, we see the following:

{{ figure_markup(
  image="third-parties-requests-by-type.png",
  caption="Third-party requests by type.",
  description="Stacked bar chart showing that `ad` third-parties are 25.7% desktop third parties and 29.1% of mobile, `unknown` are 19.8% and 19.6% respectively, `cdn` 15.2% and 13.4%, `social` 11.0% and 10.1%, `utility` 8.6% and 8.7%, `analytics` 8.0% and 8.6%, `video` 4.0% and 3.5%, `tag-manager` 2.5% and 2.4%, `customer-success` 1.6% and 1.5%, `marketing` 1.4% and 1.2%, `content` 1.1% and 0.9%, `other` 0.9% and 0.8%, and finally `consent-provider` 0.2% and 0.2%.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1925773513&format=interactive",
  sheets_gid="1613966374",
  sql_file="percent_of_third_party_requests_and_bytes_by_category_and_content_type.sql"
  )
}}

Ads are the most common third-party requests, followed by "unknown"—a collection of various uncategorized or lesser-used sites—then CDN, social, utility, and analytics. So, while some categories are more popular than others, what's perhaps the bigger takeaway here is how varied third-party usage is. They really are used for all sorts of reasons, rather than one or two use cases dominating all the others.

### Third-party requests by type and rank

{{ figure_markup(
  image="third-parties-median-third-party-requests-by-type-and-rank-on-mobile.png",
  caption="Median third-party requests by type and rank.",
  description="Stacked bar chart showing the number of requests of each type by ranking. For the top 1,000 websites there are a median of 20 `ad` third parties, 17 `unknown`, 4 `cdn`, 6 `social`, 3 `utility`, 5 `analytics`, 3 `video`, 2 `tag-manager`, 9 `customer-success`, 2 `marketing`, 5 `content`, 2 `other`, and 6 `consent-provider`. For the top 10,000 websites the median values are 19, 12, 4, 6, 4, 5, 4, 2, 9, 2, 5, 2, and 6. For the top 100,000 it's 13, 9, 5, 6, 3, 4, 9, 2, 10, 3, 5, 2, and 4. For the top million it's 6, 7, 5, 5, 3, 3, 11, 1, 10, 3, 5, 2, and 2. For all sites it's 4, 7, 5, 5, 3, 3, 11, 1, 9, 3, 5, 2, and 1.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1542898751&format=interactive",
  sheets_gid="1430893885",
  sql_file="number_of_third_parties_by_rank_and_category.sql"
  )
}}

Splitting the requests by rank and category, we see the reason for the larger number of requests discussed previously: ads are much more heavily used on the more popular sites.

Note this chart shows the median number of requests for each category, by rank, but not every category is used on every page, explaining why the totals per rank are much higher than the median number of requests per rank from the previous chart.

## Content types

Taking an alternative view on the data, let's see what type of content we're getting back from all those third-party requests.

{{ figure_markup(
  image="third-parties-usage-by-content-type.png",
  caption="Third-party usage by content type.",
  description="Stacked bar chart showing. `script` resources make up 33.6% of third-party requests on desktop, `image` 28.7%, `html` 10.6%, `other` 7.9%, `font` 8.4%, `css` 6.4%, `text` 3.8%, `video` 0.3%, `audio` 0.2%, and finally `xml` 0.1%. On mobile `script` resources are 33.2% of third-party resources, `image` 28.6%, `html` 12.3%, `other` 8.6%, `font` 6.7%, `css` 6.3%, `text` 3.7%, `video` 0.2%, `audio` 0.2%, and finally `xml` 0.1%.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=521975460&format=interactive",
  sheets_gid="655382603",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

Unsurprisingly, [JavaScript](./javascript), [images](./media), and [HTML](./markup) comprise the majority of third-party requests. JavaScript is used by most third parties to add functionality, whether that be in ads, trackers, or libraries. Similarly, the high usage of images is to be expected, as they will include the 1-pixel blank images so beloved of tracking solutions.

The high usage of HTML may seem surprising initially (surely documents would be the prevalent form of HTML and they would be first-party requests?), but our investigation showed them mostly to be iframes, which makes much more sense as they are often used to house ads, or other widgets (e.g. YouTube serves an HTML document in an iframe including the player, rather than just the video itself).

So based purely on the number of requests, third parties seem to be adding functionality more so than content—though that's a little misleading since, as per the YouTube example, some third parties add functionality in order to enable the content.

{{ figure_markup(
  image="third-parties-requests-by-content-type-and-category-on-mobile.png",
  caption="Third-party requests by content type and category (mobile).",
  description="Bar chart showing the third-party bytes by third-party type and content type. For `ad` it's mostly script bytes, with a small amount of image and html and little of anything else. For `analytics` it's 98% scripts, for `cdn` it's nearly all script or font, for `consent-provider` again it's nearly all script. `content` type is a little script, some image, but mostly video and a little audio. `customer-success` is nearly all script, `marketing` is mostly script and image, `other` is mostly image with a bit of script, social is mostly script or image, tag-manager is 99.8% script, `unknown` is a little script and a lot of images, utility is mostly script with some image, and video is similar with only a small amount of actual video.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=304580528&format=interactive",
  sheets_gid="1613966374",
  sql_file="percent_of_third_party_requests_and_bytes_by_category_and_content_type.sql"
  )
}}

Splitting the requested content types by the type of third party, we see the prevalence of those three main types (scripts, images, and HTML) across most types, though the worrying amount of JavaScript (even for video type!) is already apparent. The above chart is for mobile, but the desktop picture is very similar.

{{ figure_markup(
  image="third-parties-bytes-by-content-type-and-category-on-mobile.png",
  caption="Third-party requests by content type and category.",
  description="Bar chart showing the breakdown of each third-party type by content type for mobile. `ad` third-party requests are fairly evenly divided by script, image, html and other with a small amount of text. `analytics` are mostly script and images, with a small amount of html, other and text. For `cdn` requests it is a mixture of script, image, css but mostly fonts. For the next set (`consent-providers`, `content`, `customer-success`, `marketing`, `other`, `social`, `tag-manager`, `unknown` and `utility`) are nearly all scripts or images. `video` is similar with the amount of video content not even noticeable on the graph.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=4067008&format=interactive",
  sheets_gid="1613966374",
  sql_file="percent_of_third_party_requests_and_bytes_by_category_and_content_type.sql"
  )
}}

When looking by bytes, rather than by requests, the amount of JavaScript is even more worrying. Again, we've shown mobile here, but there are no major differences for desktop.

To quote <a hreflang="en" href="https://twitter.com/addyosmani">Addy Osmani</a> (twice in the same sentence!) from his <a hreflang="en" href="https://medium.com/@addyosmani/the-cost-of-javascript-in-2018-7d8950fbb5d4">"Cost of JavaScript"</a> post, "byte-for-byte, JavaScript is still the most expensive resource we send", and "a 200 KB script and a 200 KB image have very different costs". Some categories like Analytics, Consent Provider, and Tag Manager are pretty much all JavaScript, while others like Ad and Customer Success are not far behind. We'll return to the performance impact of using third-party resources, which is often caused by costly use of JavaScript.

## Third-party domains

Who are we loading all these third-party requests from? Most of these names won't be surprising, but the prevalence of one name just reiterates the dominance that company has across a number of different categories:

{{ figure_markup(
  image="third-parties-top-15-by-usage.png",
  caption="Top 15 third parties by usage.",
  description="Bar chart showing the top 15 third parties by percentage of websites using them separated by desktop and mobile. `*.google-analytics.com` is used on 66.2% of desktop pages and 62.7% of mobile, `fonts.googleapis.com` is 65.1% and 62.0% respectively, `adservice.google.com` is 50.5% and 48.9%, `accounts.google.com` is 50.3% and 48.9%, `*.googletagmanager.com` is 44.8% and 42.5%, `ajax.googleapis.com` is 35.5% and 31.1%, `*.facebook.com` is 30.8% and 29.2%, `amp.cloudflare.com` is 12.8% and 12.0%, `*.youtube.com` is 11.3% and 10.2%, `*.bootstrapcdn.com` is 10.1% and 9.7%, `maps.google.com` is 8.0% and 9.1%, `*.jsdelivr.net` is 7.1% and 6.6%, `*.jquery.com` is 6.3% and 5.9%, `*.fontawesome.com` is 6.3% and 5.8%, and finally `*.adobedtm.com` is 4.5% and 5.6%.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1408467789&format=interactive",
  sheets_gid="564520146",
  width=600,
  height=494,
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

Google takes 8 of the top 15 most-used third parties—including the top 6 spots!—and no else comes close. Google is a market leader in Analytics, Fonts, Ads, Accounts, Tag Managers, and Video to name but a few. A staggering 62.7% of mobile websites use Google Analytics, and almost as many use Google Fonts, with Ads, Accounts and Tag Manager usage not far behind in the 42%-49% range.

The first non-Google entity is Facebook, with comparatively low usage of 29.2%. This is followed by Cloudflare's CDN fronting popular libraries and other resources. Despite being listed as amp.cloudflare.com, it also includes the much larger cdnjs.cloudflare.com–this has been updated to show the more commonly used domain for next year.

After this we're back to Google with YouTube, and Maps two spots later. The remaining spots are filled with CDNs for other popular libraries and tools.

## Performance impact of third parties

Using third parties can have a noticeable impact on performance. That's not necessarily a consequence of them being a third party per se. The same functionality implemented by a site owner as a first-party resource can often be less performant, given the expertise the third party should have on the particular field.

So, performance isn't necessarily impacted by the fact that the resources are third-party, it's more of a matter of what those resources are doing. And most third-party usage depends on the third-party service, rather than just as a place to serve it from.

However, a third party's business is in allowing their content or service to be hosted on many websites. Third parties have a duty to ensure that they minimize the negative impact of that dependency. This is an especially important duty given that site owners often have limited control over and influence on the performance impact of third parties other than to use them or not.


### Using third-party domains versus self-hosting

There is a definite cost to connecting to another domain, even though most third parties will be using globally distributed, high-performance CDNs, and many web performance advocates (including this author!) recommend self-hosting where possible to avoid this penalty. This is particularly relevant now that all the major browsers have moved away from sharing caches between origins, so the claim that once one site has downloaded that resource, other sites visited can also benefit from it is no longer true. Though this was a questionable claim even in the past, given the number of versions of libraries, and limitations of the HTTP cache.

Saying that, rarely is life as definitive as we would like and, in some cases self-hosting may actually cost performance. This author has <a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">written before how the question on whether to self-host Google Fonts</a> is not as clear cut as it might seem and requires a degree of expertise to ensure you are replicating all that Google Fonts does for you in the performance front. To avoid that hassle you can just use the hosted version, and ensure you're reducing the performance impact as much as possible, as discussed by <a hreflang="en" href="https://twitter.com/csswizardry">Harry Roberts</a> in his <a hreflang="en" href="https://csswizardry.com/2020/05/the-fastest-google-fonts/">The Fastest Google Fonts</a> post.

Similarly, image CDNs can optimize media better than most first-parties and, more importantly, can do this automatically without the need for manual steps that will inevitably be skipped or done incorrectly on occasion.

### Popular third parties embeds and their performance impact

To try to understand the performance impact of third parties, we will look at some of the most popular third-party embeds. Some of these have gotten a bad name in web performance circles, so let's see if the bad reputation is really deserved. To do that, we'll be making use of two [Lighthouse](./methodology#lighthouse) audits: <a hreflang="en" href="https://web.dev/render-blocking-resources/">Eliminate render blocking resources</a> and <a hreflang="en" href="https://web.dev/third-party-summary/">Reduce the impact of third-party code</a>, based on some <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Td-4qFjuBzxp8af_if5iBC0Lkqm_OROb7_2OcbxrU_g/edit?usp=sharing&resourcekey=0-ZCfve5cngWxF0-sv5pLRzg">similar research</a> by <a hreflang="en" href="https://twitter.com/hdjirdeh">Houssein Djirdeh</a>.

#### Popular third parties and their impact on render

To understand third parties' impact on rendering, we've analyzed how sites resources perform on Lighthouse's render-blocking resources audit, and identified which are third-parties by cross-referencing them with the [third-party-web](methodology#third-party-web) dataset.

{{ figure_markup(
  image="third-parties-most-popular-third-parties-impact-on-render.png",
  caption="Top 15 third parties impact on render.",
  description="Bar chart showing the percentage of times the top 15 third parties block render. `*.google-analytics.com` is blocking render 0.1% of the time, `fonts.googleapis.com` is 51.3% `accounts.google.com` is 3.2% `adservice.google.com` is 0.5% `*.googletagmanager.com` is 4.5% `ajax.googleapis.com` is 22.7% `*.facebook.com` is 0.1% `amp.cloudflare.com` is 45.0% `*.youtube.com` is 1.0% `*.bootstrapcdn.com` is 63.1% `maps.google.com` is 13.6% `*.jsdelivr.net` is 30.3% `*.jquery.com` is 46.4% `*.fontawesome.com` is 66.0% `*.adobedtm.com` is 3.1%.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1221471478&format=interactive",
  width=600,
  height=585,
  sheets_gid="1866731351",
  sql_file="third_parties_blocking_rendering.sql"
  )
}}

The top 15 most popular third parties are shown above along with the percentage of resources they block on the initial render of the page.

On the whole this is a positive story; most do not block rendering, and those that do are for common libraries associated with layout (e.g. bootstrap) or fonts that perhaps should block initial render (<a hreflang="en" href="https://twitter.com/tunetheweb/status/1364278446311043073">this author doesn't agree that using `font-display: swap` or `optional` is a good thing</a>).

Often third-party embeds advise using `async` or `defer` to avoid blocking rendering, and it looks like this might be the case for many of them.

#### Popular third parties and their impact on main thread

Lighthouse has a <a hreflang="en" href="https://web.dev/third-party-summary/">Reduce the impact of third-party code</a> audit that lists the main-thread times of all third-party resources. So how long do the most popular ones block the main thread for?

{{ figure_markup(
  image="third-parties-popular-third-parties-main-thread-blocking-time.png",
  caption="Main-thread blocking time of top 15 third parties.",
  description="Bar chart showing median main-thread blocking times on mobile for the most popular third parties. Google Analytics blocks the main-thread for 96 milliseconds at the median, Google Fonts for 0 ms, Google/Doubleclick Ads for 0 ms, Other Google APIs/SDKs for 0 ms, Google Tag Manager for 42 ms, Google CDN for 54 ms, Facebook for 139 ms, Cloudflare CDN for 0 ms, YouTube for 1,625 ms, Bootstrap CDN for 0 ms, Google Maps for 259 ms, JSDelivr CDN for 0 ms, jQuery CDN for 38 ms, FontAwesome CDN for 0 ms, and Adobe Tag Manager for 0 ms.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=973901251&format=interactive",
  sheets_gid="329121076",
  width=600,
  height=585,
  sql_file="third_parties_blocking_main_thread.sql"
  )
}}

Here we see YouTube sticking out like a sore thumb so let's delve into that a little more:

##### YouTube

{{ figure_markup(
  image="third-parties-youtube-main-thread-impact.png",
  caption="YouTube's impact on the main thread.",
  description="Bar chart showing the impact YouTube has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 0.0 seconds at the 10th and 25th percentile, 1,626 milliseconds at the 50th percentile, 2,512 ms at the 75th percentile, and 4,551 ms at the 90th percentile. This correlates somewhat with the increase in transfer size from 43 kilobytes at the 10th percentiles, 129 KiB at the 25th percentile, 703 at 50th, 800 at the 75th and 968 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=291120635&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

We can see a huge impact of 1.6 seconds of main-thread activity at the median (50th percentile), rising to a shocking 4.6 seconds of main-thread blocking at the 90th percentile (still meaning 10% of websites have a worse impact than even that!). It should be remembered however that these are throttled, lab-simulated timings, so many real users may not be experiencing this level of impact, but it is still a lot.

It's also apparent that the impact increases with transfer size–perhaps not surprising as there is more to process. And remember that our crawl does not interact with these videos, so these are either auto-playing videos, or the YouTube player itself causing all this use.

Let's dig a little deeper into some of the other third party embeds on our list.

##### Google Analytics

{{ figure_markup(
  image="third-parties-google-analytics-main-thread-impact.png",
  caption="Google Analytics' impact on the main thread.",
  description="Bar chart showing the impact Google Analytics has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 0 milliseconds at the 10th percentile, 62 milliseconds at the 25th percentile, 96 milliseconds at the 50th percentile, 154 milliseconds at the 75th percentile, and 250 milliseconds at the 90th percentile. This does not correlates with the approximately static transfer size of 17 kilobytes at the 10th percentiles, 20 KiB at the 25th percentile, 20 at 50th, 20 at the 75th and 21 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1235735976&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Google Analytics is pretty good, so obviously a lot of work has gone into optimizing this, given all that it tracks.

##### Google/Doubleclick Ads

{{ figure_markup(
  image="third-parties-google-doubleclick-ads-main-thread-impact.png",
  caption="Google/Doubleclick Ads' impact on the main thread.",
  description="Bar chart showing the impact Google/Doubleclick Ads has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 0.00 milliseconds at the 10th, 25th and 50th percentile, 14 milliseconds at the 75th percentile, and then shoots up to 1,429 milliseconds at the 90th percentile. This correlates closely with the increase in transfer size from 0 kilobytes at the 10th and 25th percentiles, 2 KiB at the 50th percentile, 21 at the 75th and 289 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=2069770165&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Google Ads was doing so well, until we hit the 90th percentile, when it got blown off the chart. Again, a reminder that this means 10% of websites have worse numbers than these.

##### Google Tag Manager

{{ figure_markup(
  image="third-parties-google-tag-manager-main-thread-impact.png",
  caption="Google Tag Manager's impact on the main thread.",
  description="Bar chart showing the impact Google Tag Manager has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 0 milliseconds at the 10th percentile, 4 milliseconds at the 25th percentile, 42 milliseconds at the 50th percentile, 129 milliseconds at the 75th percentile, and 275 milliseconds at the 90th percentile. This correlates closely with the increase in transfer size from 35 kilobytes at the 10th percentiles, 36 KiB at the 25th percentile, 39 at 50th, 74 at the 75th and 116 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1275343309&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Google Tag Manager fares much better than expected to be honest. This author has seen some horrific GTM implementations, overloaded with old tags and triggers that are no longer used. But GTM seems to do well at not blocking the main thread for too long in our test page loads.

##### Facebook

{{ figure_markup(
  image="third-parties-facebook-main-thread-impact.png",
  caption="Facebook's impact on the main thread.",
  description="Bar chart showing the impact Facebook has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 0.00 milliseconds at the 10th percentile, 58 milliseconds at the 25th percentile, 139 milliseconds at the 50th percentile, 250 milliseconds at the 75th percentile, and 415 milliseconds at the 90th percentile. This correlates closely with the increase in transfer size from 69 kilobytes at the 10th percentiles, 72 KiB at the 25th percentile, 100 at 50th, 167 at the 75th and 233 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1572246557&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Facebook also isn't as resource intensive as I thought it would be. Facebook embeds of posts seem to be less popular than Twitter embeds, so these will likely be Facebook retargeting trackers. These trackers should be working silently in the background and not impacting the main thread at all, so it's apparent there is still more work for Facebook to do here. I've even had good success in <a hreflang="en" href="https://www.tunetheweb.com/blog/adding-controls-to-google-tag-manager/#pixels">not using the Facebook JavaScript API and using pixel tracking through Google Tag Manager</a> without losing any functionality, and would encourage others to consider this option.

##### Google Maps

{{ figure_markup(
  image="third-parties-google-maps-main-thread-impact.png",
  caption="Google Maps' impact on the main thread.",
  description="Bar chart showing the impact Google Maps has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 18 milliseconds at the 10th percentile, 61 at the 25th percentile, 259 milliseconds at the 50th percentile, 617 milliseconds at the 75th percentile, and 930 milliseconds at the 90th percentile. This correlates somewhat with the increase in transfer size from 164 kilobytes at the 10th percentiles, 165 KiB at the 25th percentile, 273 at 50th, 310 at the 75th and 434 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=934181875&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Google Maps definitely needs some improvement. Especially as it's often present as a small extra piece on a page, rather than the main content. As a website owner, this highlights the importance of only including the Google Maps code on pages that require it.

##### Twitter

And finally, let's look at one further down the list: Twitter.

{{ figure_markup(
  image="third-parties-twitter-main-thread-impact.png",
  caption="Twitter's impact on the main thread.",
  description="Bar chart showing the impact Twitter has on the main thread on mobile by blocking time, and transfer size by percentile. The blocking time is 0 milliseconds at the 10th percentile, 58 milliseconds at the 25th percentile, 134 milliseconds at the 50th percentile, 307 milliseconds at the 75th percentile, and 685 milliseconds at the 90th percentile. This correlates closely with the increase in transfer size from 132 kilobytes at the 10th and 25th percentiles, 148 KiB at 50th, 673 at the 75th and 1,538 at the 90th percentile.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=1661844053&format=interactive",
  sheets_gid="1536436674",
  sql_file="third_parties_blocking_main_thread_percentiles.sql"
  )
}}

Twitter as a third-party can be used in one of two ways: as a retargeting advertising tracker, and as a way of embedding tweets. Embedding tweets in pages is more popular than other social networks. However it has been called out as having an undue impact on the page by many in the web performance community, including <a href="https://twitter.com/TheRealNooshu">Matt Hobbs</a> in his <a hreflang="en" href="https://nooshu.com/blog/2021/02/06/using-puppeteer-and-squoosh-to-fix-twitter-embeds/">Using Puppeteer and Squoosh to fix the web performance of embedded tweets</a> post. Our analysis backs that up—especially as those use cases will be diluted with the (presumably lighter) tracking use case in the above graph.

While some of the above examples fare better or worse, it must be remembered that it's the cumulative effect of these that really impacts the performance of a website. It's rare for websites to only use one of these, so add together Google Analytics, GTM loading Facebook and Twitter Tracking, on a page with a Map and an embedded Tweet, and it really starts to add up. Sometimes it's unsurprising why your phone sometimes feels too hot to handle, or your PC fan starts going into overdrive just from surfing the web!

All this shows why Google recommends <a hreflang="en" href="https://web.dev/embed-best-practices/">reducing the impact of embeds</a> (mostly their own ironically!), through the use of document ordering, lazy-loading, facades, and other techniques. However, it's really quite infuriating that some of these are not the default and that advanced techniques like these must fall on the responsibility of the website owner. The third parties highlighted here really do have the resources, and technical know-how to reduce the impact of using their products for everyone by default, but often choose not to. This performance section started by saying that using third parties wasn't necessarily bad for performance, but these examples show there is certainly more that some of them can do in this area!

Hopefully highlighting some of these well-known examples will cause readers to investigate the impact of third-party embeds on their own sites and ask themselves if they really are all worth it. Perhaps if we make this subject more important to the third parties, they will prioritize performance.

### Timing-Allow-Origin header prevalence

Last year we looked at the [prevalence of the `timing-allow-origin` header](../2020/third-parties#timing-allow-origin-prevalence), which allows the <a href="https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API">Resource Timing API</a> to be used on third-party requests. Without this HTTP header, the information available to on-page performance monitoring tools for third-party requests is restricted for security and privacy reasons. However, for static requests, third parties that allow this header enable greater transparency into the loading performance of their resources.

{{ figure_markup(
  image="third-parties-timing-allow-origin-header-usage.png",
  caption="Timing-Allow-Origin header usage.",
  description="Bar chart showing the prevalence of the `timing-allow-origin` HTTP header on third-party requests over the last three years for desktop and mobile. In July 2019 this header was on 30.0% of desktop requests, and 31.9% of mobile requests. In August 2020 this increased to 31.5% and 31.3% respectively, but in July 2021 this decreased to 27.8% of desktop third-party requests and 26.7% of mobile third-party requests.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkT-CF5-NB7Oatd6XZq_08EoMGfiygKZtW4OwVivaaW3cIlt3ZcWNBtOdNePD_nKzkvb2nMlhWOX6g/pubchart?oid=626106432&format=interactive",
  sheets_gid="1788549043",
  sql_file="tao_by_third_party.sql"
  )
}}

Looking at the usage over the last three Web Almanac years, usage has dropped considerably this year. Digging deeper into the data showed a 33% drop in Facebook requests. Given that they supported this header and are widely used, this explains most of this drop. Interestingly, the number of pages with Facebook usage actually increased, but it looks like Facebook have changed their embed to make fewer requests in the last year and, given their prevalence, that's made quite a dent on the usage of the `timing-allow-origin` header. Ignoring that, usage of this header has basically stayed stable, which is a bit disappointing given the focus on performance with <a hreflang="en" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">the ranking impact of the Core Web Vitals</a>.

## Security and Privacy

Measuring the security and privacy impact of using third parties is more difficult. Undoubtedly, giving access to third parties increases risks on both security and privacy, and then giving access to run scripts—which we've shown to be the most prevalent type—effectively gives full access to the website. However, the entire intent of third-party resources is to allow them to be seamlessly used on the sites, meaning restricting this will limit the very functionality they are being used for.

### Security

Sites themselves can reduce the risk of using third parties in a number of ways: <a href="https://developer.mozilla.org/docs/Web/HTTP/Cookies#restrict_access_to_cookies">restricting access to cookies</a> with the `HttpOnly` attribute, so they cannot be accessed by JavaScript, and through appropriate use of `SameSite` attributes. These are explored more in the [Security chapter](./security) so we will not delve further into them here.

Another security feature that can make third-party resources safer is the use of <a href="https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity">Subresource Integrity</a> (SRI), which is enabled by adding a cryptographic hash of a resource to the `<link>` or `<script>` element loading the resource. This hash is then checked by the browser to ensure that the content downloaded is exactly what is expected. However, the varying nature of third-party resources could mean that this introduces more risks than it solves, with sites breaking when resources are intentionally updated by the third party. If content really is static, then it can be self-hosted, removing the need of SRI. So, while many people recommend SRI, this author remains unconvinced that it really offers the security benefits that proponents claim.

One of the best ways sites can reduce the security risk of any third-party content coming onto their site—from either third-party resource use, or even user-generated content—is with a robust <a href="https://developer.mozilla.org/docs/Web/HTTP/CSP">Content Security Policy</a> (CSP). This is an HTTP header sent with the original website that tells the browser exactly what resources can and cannot be loaded and by whom. It is a more advanced technique that few sites use, according to the [Security](./security) chapter, and we'll leave it to them to analyze CSP usage, but what _is_ worth covering here is that one of the reasons for the lack of uptake may be third parties. In this author's experience, very few third parties publish CSP information with the exact requirements that sites must add to their policy to use the third party without issue. Worse still is that others are incompatible with a secure CSP. Some third parties use inline script elements or change domains without notification, which breaks that functionality for sites using CSP until they update their policy. Google Ads is another example which, <a hreflang="en" href="https://stackoverflow.com/questions/34361383/google-adwords-csp-content-security-policy-img-src">through the use of a different domain per country</a>, makes it difficult to really lock down CSP.

It is difficult enough to set up CSP in the first place for the parts of the site in your control, without the added complexity of third parties making it even more difficult for things outside of your control! Third parties really should get better at supporting CSP to make it easier for sites to reduce the risk of using them.

### Privacy

The privacy implications of using third parties is something we will again leave to the [Privacy](./privacy) chapter dedicated to this topic, but what should already be apparent from the above analysis are the following two things that majorly impact the privacy of web users:

- The prevalence of third-party usage on the web at just shy of 95% of websites.
- The dominance of particular third parties, like Google and Facebook, who are not known for being on the side of privacy.

Of course, one of the major reasons for using third parties on your site is for tracking for advertisement purposes, which by its very nature is not going to be in the best privacy interests of your visitors. Alternatives to this pervasive tracking, which is basically only possible by the use of third parties, have been suggested <a hreflang="en" href="https://blog.google/products/ads-commerce/2021-01-privacy-sandbox/">such as Google's Privacy Sandbox and FLoC initiative</a> but have, so far,  failed to gain sufficient traction across the wider ecosystem.

What is perhaps more concerning is the tracking that can occur without website users and owners being aware. There is the old adage that if you're not paying for a product or service, then you are the product. Many third parties give away their product for "free", which for most means they are monetizing it in some other way—usually at the expense of your visitors' privacy!

Adoption of newer technologies like <a href="https://developer.mozilla.org/docs/Web/HTTP/Headers/Feature-Policy">`feature-policy` and `permission-policy`</a> can restrict the usage of certain functionalities of the browser, such as microphones and video cameras. These can reduce the privacy and security risks; though many of these will usually be secured behind a browser prompt to ensure they are not silently activated. Google is also working on a <a hreflang="en" href="https://github.com/bslassey/privacy-budget">Privacy Budget proposal</a> to limit the privacy impact of web browser, though others <a hreflang="en" href="https://blog.mozilla.org/en/mozilla/google-privacy-budget-analysis/">remain skeptical of their work in this space</a>. All in all, adding privacy controls seems to be swimming against the tide given the intent of many third-party resources.

## Conclusion

Third parties are integral to the web. In many ways they are the web; without the prevalence of third parties, websites would be harder to build and less feature rich. As mentioned at the beginning, interconnectedness is at the very heart of the web, and third parties are the natural extension of this. Our analysis has shown that third parties are more prevalent than ever—sites without them are very much the exception!

However, using third parties is not without risks and in this chapter, we have explored the performance impact of third parties and discussed the potential security and privacy risks of using them on your site.

There are consequences to needlessly loading up your website with every third-party tool, widget, tracker and whatever else you can think of. Site owners have a responsibility to look at the impact of all that third-party content and decide if the functionality is worth that potential impact.

It's easy to get sucked into the negative however, so to finish off the chapter, let's look back at the positives. There is a reason that third parties are so prevalent and they are (usually!) used out of choice. Sharing is what the web is about and so third parties are very much in the spirit of the web. It's amazing what functionality we web developers have at our disposal and how easy it is to add them to our sites. Hopefully this chapter has opened your eyes to give a little more thought to making sure you fully understand the deal you're making when you do that.
