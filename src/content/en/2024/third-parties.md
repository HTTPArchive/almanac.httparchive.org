---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
description: Third Parties chapter of the 2024 Web Almanac covering data of what third parties are used on the web and an analysis of inclusion chains of third parties.
hero_alt: Hero image of Web Almanac characters plugging various things into a web page.
authors: [turban1988, Yash-Vekaria, zubairshafiq, ChrisBeeti]
reviewers: [tunetheweb]
editors: [tunetheweb]
analysts: [Yash-Vekaria, ChrisBeeti]
translators: []
turban1988_bio: Doctor of Engineering Tobias Urban is a Professor of Computer Science, specializing in Cybersecurity, at the <a hreflang="en" href="https://www.en.w-hs.de/">Westphalian University of Applied Sciences</a>. His research focuses on IT security, data protection, and the impact of the GDPR on the Internet.
Yash-Vekaria_bio: Yash Vekaria is a PhD candidate in Computer Science at <a hreflang="en" href="https://www.ucdavis.edu/">University of California, Davis</a>. He carries out web-based large-scale Internet measurements to study and improve the dynamics of web. Specifically, his research is focused at studying and bringing transparency to online tracking practices and user privacy issues.
zubairshafiq_bio: Zubair Shafiq is a computer science professor at <a hreflang="en" href="https://www.ucdavis.edu/">University of California, Davis</a>. His research aims to make the Internet private, secure, and safe using empirically grounded measurement and modeling methods.
ChrisBeeti_bio: Chris Böttger is a PhD candidate in Computer Science at the <a hreflang="en" href="https://www.en.w-hs.de/">Westphalian University of Applied Science</a>. His research focuses on web and network security, primarily focusing on user privacy and tracking technologies.
results: https://docs.google.com/spreadsheets/d/18uTDBygSqgT_PNFldOz4guLSuXyMzDthRGnAG5if4sU/
featured_quote: Google is the most popular third-parties on the web, with five of the top ten third-party domains being Google domains.
featured_stat_1: 92%
featured_stat_label_1: Web pages including one or more third parties
featured_stat_2: 78
featured_stat_label_2: The median number of third-party requests per web page
featured_stat_3: 22
featured_stat_label_3: The median number of third-parties per web page
doi: 10.5281/zenodo.14193383
---

## Introduction

Website developers can use third parties to implement certain features such as advertising, analytics, social media integration, payment processing, and content delivery. A web page typically comprises resources served by the first party and various third parties. Using third parties to compose a web page allows for modular development, which enables efficient and rapid deployment of rich features but can also pose potential privacy, security, and performance issues.

In this chapter, we conduct an empirical analysis to shed light on the practice of using third parties on the web. We find that nearly all websites contain one or more third parties. We provide a breakdown of the types of resources served by these third parties, such as images, JavaScript, fonts, etc. We provide a breakdown of different categories of third parties on the Web, such as ad, analytics, CDN, video, tag manager, etc. We also provide a breakdown of how different third parties are included—directly or indirectly—on web pages.

## Definitions

Before we start on our analysis, it helps to have some common definitions of what we will cover in this chapter.

### Sites and pages

In this chapter, we use the term **site** to depict the registerable part of a given domain—often referred to as _extended Top Level Domain plus one_ (eTLD+1). For example, given the URL `https://www.bar.com/` the eTLD+1 is `bar.com` and for the URL `https://foo.co.uk` the eTLD+1 is `foo.co.uk`. By **page** (or web page), we mean a unique URL or, more specifically, the document (for example HTML or JavaScript) located at the particular URL.

### What is a third party?

We stick to the aforementioned definition of a third party used in previous editions of the Web Almanac to allow for comparison between this and the previous editions.

A **third party** is an entity different from the site owner (aka first party). It involves the aspects of the site not directly implemented and served by the site owner. More precisely, third-party content is loaded from a different site (i.e., the third party) rather than the one originally visited by the user. Assume that the user visits `example.com` (the first party) and `example.com` includes silly cat images from `awesome-cats.edu` (for example using an `<img>` tag). In that scenario, `awesome-cats.edu` is the third party, as it was not originally visited by the user. However, if the user directly visits `awesome-cats.edu`, `awesome-cats.edu` is the first party.

Only third parties originating from a domain whose resources can be found on at least 50 unique pages in the HTTP Archive dataset were included to match the definition. When third-party content is directly served from a first-party domain, it is counted as first-party content. For example, self-hosted CSS or fonts are counted as first-party content. Similarly, first-party content served from a third-party domain is counted as third-party content—assuming it passes the "more than 50 pages criteria." Some third parties serve content from different subdomains. However, regardless of the number of subdomains, they are counted as a single third party. Further, it is becoming increasingly common for third parties to be masqueraded as a first party, for example, through techniques like <a hreflang="en" href="https://ldklab.github.io/assets/papers/madweb21-cloaking.pdf">CNAME cloaking</a>. We consider them a first party in this analysis. Thus, our results present a lower bound on the prevalence of third parties on the web.

### Categories

As previously indicated, third parties can be used for various use cases—for example, to include videos, to serve ads, or to include content from social media sites. To categorize the observed third parties in our dataset, we rely on the <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">third-party Web</a> repository from [Patrick Hulce](https://x.com/patrickhulce). The repository breaks down third parties along the following categories:

- **Ad**: These scripts are part of advertising networks, either serving or measuring.
- **Analytics**: These scripts measure or track users and their actions. There's a wide range of impact here, depending on what's being tracked.
- **CDN**: These are a mixture of publicly hosted open source libraries (for example jQuery) served over different public CDNs and private CDN usage.
- **Content**: These scripts are from content providers or publishing-specific affiliate tracking.
- **Customer Success**: These scripts are from customer support/marketing providers that offer chat and contact solutions. These scripts are generally heavier in weight.
- **Hosting***: These scripts are from web hosting platforms (WordPress, Wix, Squarespace, etc.).
- **Marketing**: These scripts are from marketing tools that add popups/newsletters/etc.
- **Social**: These scripts enable social features.
- **Tag Manager**: These scripts tend to load many other scripts and initiate many tasks.
- **Utility**: These scripts are developer utilities (API clients, site monitoring, fraud detection, etc.).
- **Video**: These scripts enable video player and streaming functionality.
- **Consent provider**: These scripts allow sites to manage the user consent (eg. for the [General Data Protection Regulation](https://wikipedia.org/wiki/General_Data_Protection_Regulation) compliance). They are also known as the 'Cookie Consent' popups and are usually loaded on the critical path.
- **Other**: These are miscellaneous scripts delivered via a shared origin with no precise category or attribution.

<p class="note">Note: The CDN category here includes providers that provide resources on public CDN domains (for example <code>bootstrapcdn.com</code>, <code>cdnjs.cloudflare.com</code>, etc.) and does not include resources that are simply served over a CDN. For example, putting Cloudflare in front of a page would not influence its first-party designation according to our criteria.</p>

<p class="note">Similar to previous years, the Hosting category is removed from our analysis. For example, if you happen to use WordPress.com for your blog, or Shopify for your e-commerce platform, then we're going to ignore other requests for those domains by that site as not truly "third-party" as they are, in many ways, part of hosting on those platforms.</p>

### `Content Type`

We use the [`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) HTTP header to determine the type of the third party resources. The values of Content-Type include `text/javascript` or `application/javascript` (for scripts), `text/html` (for HTML content), `application/json` (for JSON data), `text/plain` (for plain text), `image/png` (for PNG images), `image/jpeg` (for JPEG images), `image/gif` (for GIF images), etc.

## Prevalence

{{ figure_markup(
  image="percent_pages_using_atleast_one_3p.png",
  caption="Percentage of pages that use one or more third parties.",
  description="Bar chart showing percentage of pages across different rank groups that are using at least one third-party. Around 92% pages use third-parties across different rank groups.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=984151122&format=interactive",
  sheets_gid="528037668",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

There is a slight decrease in the percentage of pages that use one or more third parties for low-ranked websites. Similar to 2021 and 2022, the percentage of pages with one or more third parties remains high at 92%.

{{ figure_markup(
  image="num_3p_by_rank.png",
  caption="Distribution of the number of third parties by rank.",
  description="Bar chart showing distribution of number of third parties by rank groups. Number of third parties decrease with increasing rank groups.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=964391197&format=interactive",
  sheets_gid="409919642",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

We note a considerable decrease in the number of third parties for lower-ranked websites. The median number of third-parties is 66 for the top thousand websites and 27 for the top million websites. The number of third parties on the desktop is higher than that for mobile pages. The contrast between desktop and mobile is greater for higher-ranked websites.

{{ figure_markup(
  image="num_3p_req_per_page_by_rank.png",
  caption="Distribution of the number of third party requests per page by rank.",
  description="Bar chart displaying the median number of third party requests per page by rank. Number of third party requests per page increases from top 1K to top 10K rank groups and then decreases for higher rank groups.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=2138228339&format=interactive",
  sheets_gid="1476178274",
  sql_file="number_of_third_party_requests_per_page_by_rank.sql"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
We note that the number of third-party requests is higher for higher-ranked websites than lower-ranked websites. When looking at requests, the difference between higher- and lower-ranked websites is less skewed than when looking at the number of third-parties in [figure 2](#fig-2).

{{ figure_markup(
  image="3p_req_categories_by_rank.png",
  caption="Distribution of the third party request categories by rank.",
  description="Bar chart showing distribution of third party categories by rank groups. Top categories are consent provider, video, and customer success.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=1044951420&format=interactive",
  sheets_gid="1662995860",
  sql_file="number_of_third_parties_by_rank_and_category.sql"
  )
}}

Excluding unknown, the top categories include consent provider, video, and customer success. The most popular consent provider domain is `fundingchoicesmessages.google.com`, the most popular video domain is `www.youtube.com`, and the most customer-success domain is `embed.tawk.to`.

{{ figure_markup(
  image="3p_req_types_by_rank.png",
  caption="Distribution of the third party request types by rank.",
  description="Pie chart showing percentage distribution of third party requests by content type. The top 3 content types are `script` (30.5%), `image` (26.0%), and `html` (11.7%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=906292432&format=interactive",
  sheets_gid="418010554",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

The top 3 types include `script`, `image`, and `other`. The most popular domain under these content-types is `fonts.googleapis.com`.

{{ figure_markup(
  image="top_3p_by_num_pages.png",
  caption="Top third parties by the number of pages.",
  description="Bar chart showing top third parties by the percentage of pages with their presence.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=1091257032&format=interactive",
  sheets_gid="1109396463",
  sql_file="top100_third_parties_by_number_of_websites.sql",
  width=600,
  height=498
  )
}}

The top 10 third-party domains include several Google-owned domains such as `googleapis.com`, `googletagmanager.com`, `google-analytics.com`, `google.com`, and `youtube.com`. Meta's `facebook.com` is the only non-Google domain in the top 5.

## Inclusion

Recall from our earlier example that `example.com` (a first party) can include an image from `awesome-cats.edu` (a third party via an `<img>` tag). This inclusion of an image would be considered direct inclusion. However, if the image was loaded by a third-party script on the site via the `XMLHttpRequest`, then the inclusion of the image would be considered indirect inclusion. The indirectly included third parties can further include additional third parties. For example, a third-party script that is directly included on the site may further include another third-party script.

Such indirect inclusion of third parties on a page can be represented as a third-party inclusion chain. The inclusion chain can be constructed using the initiator information, identifying what triggered a particular request. We use the eTLD+1 of a third party as the node identifier in the inclusion chain. An inclusion chain might include multiple domains operated by the same company (for example: `example.com` → `googletagmanager.com` → `google-analytics.com` → `doubleclick.net`) or different companies (for example: `example.com` → `googletagmanager.com` → `facebook.com`).

{{ figure_markup(
  image="median_depth_tp_inclusion_chains.png",
  caption="Median depth of third-party inclusion chains.",
  description="Bar chart showing the median depth from inclusion chain.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=496285056&format=interactive",
  sheets_gid="868914926",
  sql_file="inclusion_chain.sql"
  )
}}

The median depth of the inclusion chains is 3.4 of the inclusion chains are of length > 1, which means that they indirectly include at least one third party on the page. Notably, 14% of the inclusion chains are of length > 5. The inclusion chain with the highest depth has a length of 2,930.

{{ figure_markup(
  image="median_depth_categories.png",
  caption="Median depth of different categories of websites.",
  description="Bar chart showing the median depth of different categories and all.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=186961190&format=interactive",
  sheets_gid="1274132728",
  sql_file="inclusion_chain_by_category.sql"
  )
}}

Across all categories, desktop pages have longer inclusion chains than mobile pages. We observe substantial differences across different website categories. The website category with the longest inclusion chains is `/Games`.

{{ figure_markup(
  image="depth_of_gtm_called_urls.png",
  caption="Google Tag Manager inclusion chain URLs.",
  description="Bar chart showing the median depth of URLs in the inclusion chain called from the Google Tag Manager.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSiKVwcJsvW7J6Kq7hxRDG84Z5-tq7N1fm1ytH7qKI5Ws6hzFmDF2G-UD5cDMjG_3QXihAXaZUMRJt9/pubchart?oid=496082761&format=interactive",
  sheets_gid="1091971377",
  sql_file="depth_of_gtm_calls.sql.sql"
  )
}}

When we look specifically at `googletagmanager.com`, one of the top third-party domains. Note that it includes a number of other Google domains such `googleapis.com`, `google-analytics.com`, `google.com`, `gstatic.com`, `youtube.com`, `googlesyndication.com`, and `googleadservices.com`. Only three of the top 10 third-party domains included by `googletagmanager.com` are non-Google domains, which are `facebook.com` and `facebook.net` for Meta and `shopify.com` for Shopify.

## Conclusion

Our findings show the ubiquitous and complex nature of third-parties on the web. We find that the use of third parties on the web is more common than ever before. More than nine-in-ten web pages include one or more third-parties, often indirectly.

We find that third parties are often not directly included by the first party. Nearly one-third of third parties on all web pages are used for advertising, analytics, and consent management. Google is the most popular third-parties on the web, with five of the top ten third-party domains being Google domains, such as `googleapis.com`, `googletagmanager.com`, `google.com`, `google-analytics.com`, and `youtube.com`.

The inclusion of third-parties presents privacy, security, and performance implications that should be considered by web developers.
