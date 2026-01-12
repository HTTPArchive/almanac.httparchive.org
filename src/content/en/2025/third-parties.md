---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
description: Third Parties chapter of the 2025 Web Almanac covering data of what third parties are used on the web and an analysis of inclusion chains of third parties.
hero_alt: Hero image of Web Almanac characters plugging various things into a web page.
authors: [jazlan01, abubakaraziz]
reviewers: [tunetheweb]
analysts: [jazlan01]
editors: [tunetheweb]
translators: []
jazlan01_bio: Muhammad Jazlan is a second year PhD student in Computer Science at University of California, Davis. His research focuses on the measurement, detection and mitigation of tracking on the web.
abubakaraziz_bio: Muhammad Abu Bakar Aziz is a PhD candidate in Computer Science at Northeastern University in Boston. His research focuses on web privacy. In particular, he empirically measures how third parties and online advertisers comply with privacy laws such as the CCPA and GDPR.
results: https://docs.google.com/spreadsheets/d/1FPssodcLgX8iFWFXDrthWVkBCUTl5_IJon2cyaZVudU/edit
featured_quote: The top 10 third-party domains are dominated by Google.
featured_stat_1: 90%
featured_stat_label_1: Pages with at least one third party
featured_stat_2: 16
featured_stat_label_2: The median number of third-party domains present on a page
featured_stat_3: 18%
featured_stat_label_3: Percentage of websites that use TCF Standard
doi: TODO
---

## Introduction

Third parties are ubiquitous on the web. Website developers rely on them to implement key features such as advertising, analytics, social media integration, payment processing, and content delivery. This modular approach enables efficient and rapid deployment of rich functionality. However, it introduces potential privacy, security, and performance concerns. New this year, we analyze how user consent choices are propagated among third parties on the web, including the consent frameworks used and the third parties that receive these signals.

In this chapter, we conduct an empirical analysis of third-party usage patterns on the web. We examine:

- **Prevalence:** How many websites use third parties and in what proportions
- **Resource types:** The forms third parties take (images, JavaScript, fonts, etc.)
- **Functional categories:** Ad networks, analytics, CDNs, video providers, tag managers, and others
- **Integration methods:** How third parties are loaded directly or indirectly on pages
- **Consent infrastructure:** Which third parties transfer consent signals and how those transmissions happen in practice

## Definitions

First, we establish some definitions and terminology that are used throughout our analysis.

### Sites and pages

In this chapter, like previous years,  we use the term site to depict the registerable part of a given domain which is often referred to as *extended Top Level Domain plus one* (eTLD+1). For example, given the URL `https://www.bar.com/` the eTLD+1 is `bar.com` and for the URL `https://foo.co.uk` the eTLD+1 is `foo.co.uk`. By page (or web page), we mean a unique URL or, more specifically, the document (for example HTML or JavaScript) located at the particular URL.

### What is a third party?

We stick to the definition of a third party used in previous editions of the Web Almanac to allow for comparison with earlier versions.

A _third party_ is an entity different from the site owner (also known as the first party). It involves the aspects of the site not directly implemented and served by the site owner. More precisely, third-party content is loaded from a different site rather than the one originally visited by the user. Assume that the user visits `example.com` (the first party) and `example.com` includes silly cat images from `awesome-cats.edu` (for example using an `<img>` tag). In that scenario, `awesome-cats.edu` is the third party, as it was not originally visited by the user. However, if the user directly visits `awesome-cats.edu`, `awesome-cats.edu` is the first party.

For our analysis, only third parties originating from a domain whose resources can be found on at least five unique pages in the HTTP Archive dataset were included.

When third-party content is directly served from a first party domain, it is counted as first party content. For example, self-hosted analytics scripts, CSS, or fonts are counted as first party content. Similarly, first-party content served from a third-party domain is counted as third-party content. Some third parties serve content from different subdomains. However, regardless of the number of subdomains, they are counted as a single third party.

Further, it is becoming increasingly common for third parties to be masqueraded as a first party. Two key techniques enable this:

- **CNAME cloaking** involves using a CNAME record to make a third party's content appear to come from the first party domain. We consider CNAME-cloaked services as first parties in this analysis.

- **Server-side tracking** is an emerging trend where the site owner embeds the tracker as a first party and routes all requests through the first party domain, making the tracker appear as a first party. For example, a website `www.example.com` may embed server-side Google Tag Manager with Google Analytics and cloak the subdomain `sst.example.com` to send requests to a Google Tag Manager container. In this way, requests to third parties originate from the tag manager's server rather than the user's browser.

In our analysis, we treat such cases as first party interactions because the third party communication occurs server-to-server and is not directly observable in the client-side HTTP Archive data. As a result, our measurements represent a lower bound on the actual prevalence of third parties on the web.

## Categories

As previously indicated, third parties can be used for various use cases—for example, to include videos, to serve ads, or to include content from social media sites. Similar to the previous year, to categorize the observed third parties in our dataset, we rely on the <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">Third-Party Web</a> repository from <a hreflang="en" href="https://x.com/patrickhulce">Patrick Hulce</a>. The repository breaks down third parties along the following categories:

- **Ad:** These scripts are part of advertising networks, either serving or measuring.
- **Analytics:** These scripts measure or track users and their actions. There’s a wide range of impact here, depending on what’s being tracked.
- **CDN:** These are a mixture of publicly hosted open source libraries (for example jQuery) served over different public CDNs and private CDN usage.
- **Content:** These scripts are from content providers or publishing-specific affiliate tracking.
- **Customer Success:** These scripts are from customer support/marketing providers that offer chat and contact solutions. These scripts are generally heavier in weight.
- **Hosting:** These scripts are from web hosting platforms (WordPress, Wix, Squarespace, etc.).
- **Marketing:** These scripts are from marketing tools that add popups/newsletters/etc.
- **Social:** These scripts enable social features.
- **Tag Manager:** These scripts tend to load many other scripts and initiate many tasks.
- **Utility:** These scripts are developer utilities (API clients, site monitoring, fraud detection, etc.).
- **Video:** These scripts enable video player and streaming functionality.
- **Consent provider:** These scripts allow sites to manage the user consent (e.g. for the [General Data Protection Regulation](https://wikipedia.org/wiki/General_Data_Protection_Regulation) compliance). They are also known as the ’Cookie Consent’ popups and are usually loaded on the critical path.
- **Other:** These are miscellaneous scripts delivered via a shared origin with no precise category or attribution.

### `Content-Type`

We use the [`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) HTTP header to categorize third-party resources into different types, such as scripts, HTML content, JSON data, plain text, and images. This allows us to analyze the composition of third-party resources served across websites.

## Prevalence

{{ figure_markup(
  image="pages-using-at-least-one-3p.png",
  caption="Percentage of pages that use one or more third parties.",
  description="Bar chart showing percentage of pages across different rank groups that are using at least one third-party. Around 90%-92% pages use third-parties across different rank groups.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=249114645&format=interactive",
  sheets_gid="1741089577",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

Compared to [the previous year](../2024/third-parties#prevalence), we observe a slight decrease in the percentage of pages that use one or more third parties across websites. However, despite this decrease, the percentage of pages with one or more third parties remains greater or equal to 90%.

{{ figure_markup(
  image="num-3p-by-rank.png",
  caption="Distribution of the number of third parties by rank.",
  description="Bar chart showing distribution of number of third parties by rank groups. Number of third parties decrease with increasing rank groups.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=211745165&format=interactive",
  sheets_gid="199539546",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

Compared to the previous year, we observe a significant decrease in the median number of third-party domains across all website ranks, with a particularly large decrease among low-ranked websites.

This decline may be due to several factors. First, third parties are increasingly obscured through `CNAME` cloaking and server-side tracking, which can reduce their visibility in client-side measurements. Second, HTTP Archive crawlers do not interact with web pages or scroll down the page, which may prevent some third parties from loading properly due to lazy loading. As a result, fewer third-party requests may be observed.

We also observe that desktop pages generally include more third parties than mobile pages.

{{ figure_markup(
  image="num-3p-req-per-page-by-rank.png",
  caption="Distribution of the number of third party requests per page by rank.",
  description="Bar chart displaying the median number of third party requests per page by rank. Number of third party requests per page increases from top 1K to top 10K rank groups and then decreases for higher rank groups.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1763082827&format=interactive",
  sheets_gid="641162136",
  sql_file="number_of_third_party_requests_per_page_by_rank.sql"
  )
}}

Low-ranked websites load more third-party requests. The top 1,000 have a median of 129 requests on desktop and 106 on mobile, compared to 83 on desktop and 79 on mobile across all sites.

Year-over-year, third-party requests have increased across all ranks. The top 1,000 sites show an increase of 15 requests on desktop and 15 on mobile [compared to 2024](../2024/third-parties#fig-3), while the broader dataset increased by five requests on desktop and five on mobile. This upward trend occurs despite the decrease in the number of unique third-party domains we observed earlier, suggesting that individual third parties are sending more requests per page.

{{ figure_markup(
  image="3p-req-categories-by-rank.png",
  caption="Distribution of the third-party request categories by rank.",
  description="Bar chart showing distribution of third-party categories by rank group. The top categories are ad, analytics, and cdn.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1133634663&format=interactive",
  sheets_gid="445864775",
  sql_file="number_of_third_party_providers_by_rank_and_category.sql"
  )
}}

The bar chart shows the median number of third-party providers per page by rank and category. In the previous edition, this analysis focused on the number of third-party domains per page by rank and category, whereas this year we measure the number of unique third-party providers, which results in lower counts overall. This year, the top categories are `ad`, `analytics`, and `cdn`.

{{ figure_markup(
  image="3p-req-types-by-rank.png",
  caption="Distribution of the third-party request types by rank.",
  description="Pie chart showing percentage distribution of third party requests by content type. The top 3 content types are `script` (24.8%), `image` (19.9%), and other (13.9%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1309978891&format=interactive",
  sheets_gid="418010554",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

The chart shows that third-party requests are dominated by `script`, `image`, and the `other` category. Together, `script`, `image`, and `other` account for more than half of all third-party request content types. This pattern is consistent with [the 2024 edition](../2024/third-parties#fig-5), which also identified `script`, `image`, and `other` as the top request types, indicating little change since last year.

{{ figure_markup(
  image="top-3p-by-num-pages.png",
  caption="Top third parties by the number of pages.",
  description="Bar chart showing top third parties by the percentage of pages with their presence.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=194077318&format=interactive",
  sheets_gid="803451847",
  sql_file="top100_third_parties_by_number_of_websites.sql",
  width=600,
  height=498
  )
}}

The top 10 third-party domains are dominated by Google-owned services, including `fonts.googleapis.com`, `googletagmanager.com`, `google-analytics.com`, `accounts.google.com`, and `adservice.google.com`. Meta's `facebook.com` is the only non-Google domain in the top 10, appearing at rank 7 with 21% of pages.

## Consent propagation among third parties

In this section, we examine how different third parties transmit user consent across the web. <a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">Previous research</a> has shown that third parties often rely on industry-standard frameworks to communicate consent information. In our analysis, we focus primarily on the IAB’s three consent standards: the <a hrefland="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency and Consent Framework (TCF)</a>, the <a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">CCPA Framework</a>, and the <a hrefland="en" href="https://iabtechlab.com/gpp/">Global Privacy Protocol (GPP)</a>.

These frameworks define how consent information is encoded and shared between websites and third parties. We begin by identifying which consent standards are most prevalent among the third parties observed in our dataset. To determine which framework a third party uses, we rely on the presence of specific parameters in the request URLs. Details of the different standards are below:

- **TCF Standard**: We identify use of the TCF framework by checking whether a third-party request includes the `gdpr` or `gdpr_consent` parameters, as specified by the IAB TCF.

- **GPP Standard**: We identify use of the GPP framework by checking for the presence of the `gpp` and `gpp_sid` parameters.

- **USP Standard and non-USP Standard**: We identify use of the USP Standard by checking whether a request transmits a `us_privacy` parameter, as defined by the IAB CCPA Framework. We also identify use of the non-standard USP Standard by detecting consent strings transmitted via non-standard parameters identified in the <a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">prior work</a>.

We analyze consent signal prevalence across website ranks, third-party categories, and the most frequently observed consent-receiving third parties.

### Prevalence of consent signals across different ranks

{{ figure_markup(
  image="consent-signal-prevalence-by-rank.png",
  caption="Consent signal prevalence by rank.",
  description="Bar chart showing the prevalence of different consent standards in third-party requests across website ranks.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=2066656520&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

We find that TCF Standard is the dominant consent standard, particularly among low-ranked sites where it reaches 36% compared to 18% across all sites. This higher adoption aligns with stronger opt-in consent requirements under GDPR. The USP Standard is the second most prevalent, with adoption ranging from 9–17% across ranks. This reflects use of the IAB CCPA consent framework introduced in response to the CCPA. GPP adoption remains minimal at 3–6%, despite its goal to unify consent frameworks across jurisdictions.

### Consent standard distribution across different categories

{{ figure_markup(
  image="consent-signal-prevalence-by-category.png",
  caption="Consent signal prevalence by category.",
  description="Bar chart showing consent standard prevalence across different third-party categories.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=828032137&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

We observe different consent standard preferences across different third-party categories. For example, Social services show the highest TCF adoption, while advertising vendors employ a more balanced mix of GPP, USP Standard, and smaller TCF shares. Furthermore, Analytics vendors predominantly adopt GPP.

### Top third parties receiving consent

{{ figure_markup(
  image="consent-signal-prevalence-by-domain.png",
  caption="Consent signal prevalence by domain.",
  description="Bar chart showing the third parties that receive the highest volume of consent signals.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1262795614&format=interactive",
  sheets_gid="1788947788",
  sql_file="consent_signals_by_parameter_and_domain_optimized.sql"
  )
}}

Among top-ranked websites, `pubmatic.com` receives the highest volume of consent signals, with `adservice.google.com` in second place. The majority of domains receiving the most consent signals are advertising and ad tech vendors—ad exchanges, DSPs, and ad servers. This makes intuitive sense, as in many jurisdictions third party advertising and analytics providers must obtain user consent before using user data for ads and other purposes.

## Inclusion

Recall from our earlier example that `example.com` (a first party) can include an image from `awesome-cats.edu` (a third party via an `<img>` tag). This inclusion of an image would be considered direct inclusion. However, if the image was loaded by a third-party script on the site via the `XMLHttpRequest`, then the inclusion of the image would be considered indirect inclusion. The indirectly included third parties can further include additional third parties. For example, a third-party script that is directly included on the site may further include another third-party script. In this chapter, we do basic analysis of the depths of inclusion chains of the third parties.

{{ figure_markup(
  image="median-depth-tp-inclusion-chains.png",
  caption="Median depth of third-party inclusion chains.",
  description="Bar chart showing the median depth from inclusion chain.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=692408075&format=interactive",
  sheets_gid="1518420053",
  sql_file="inclusion_chain.sql"
  )
}}

The median depth of the inclusion chain is 3 which means the majority of the third parties include at least another third party on a web page. The maximum depth of the inclusion chain is 2,285.

## Conclusion

Our findings show the ubiquitous and increasingly concentrated nature of third parties on the web. More than nine-in-ten web pages include one or more third parties. While the median number of unique third-party domains has decreased compared to the previous year, we observe a significant increase in the total number of requests from third parties, suggesting individual vendors are sending more requests per page.

In terms of consent standards, TCF is the dominant consent standard across all website ranks. Among individual third parties, `pubmatic.com`, `adservice.google.com` and other ad tech domains receive the highest volume of consent signals.

Finally, the increasing use of obfuscation techniques such as CNAME cloaking and server-side tracking reduces visibility of third parties in client-side measurements, suggesting our findings represent a lower bound on actual prevalence.
