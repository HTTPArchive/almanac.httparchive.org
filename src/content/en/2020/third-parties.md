---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
description: Third Parties chapter of the 2020 Web Almanac covering data of what third parties are used, what they are used for, performance impacts and privacy impacts.
hero_alt: Hero image of Web Almanac chracters plugging various things into a web page.
authors: [simonhearne]
reviewers: [jzyang, exterkamp]
analysts: [max-ostapenko, paulcalvano]
editors: [tunetheweb]
translators: []
simonhearne_bio: Simon is a web performance architect. He is passionate about helping deliver a faster and more accessible web. You can find him tweeting <a href="https://x.com/simonhearne">@SimonHearne</a> and blogging at <a hreflang="en" href="https://simonhearne.com">simonhearne.com</a>.
discuss: 2042
results: https://docs.google.com/spreadsheets/d/1uW4SMkC45b4EbC4JV1xKAUhwGN2K8j0qFy_jSIYnHhI/
featured_quote: Third-party content is more prevalent than ever, 94% of pages have at least one third-party resource and the median page has 24. In this chapter we review the prevalence of third-party content, the impact on page weight and browser CPU, then suggest methods to reduce the impact of third-party content on page performance.
featured_stat_1: 94.1%
featured_stat_label_1: Pages with third-party content
featured_stat_2: 21.5%
featured_stat_label_2: Third-party content delivered as JavaScript
featured_stat_3: 24
featured_stat_label_3: Third-party requests on the median page
---

## Introduction

Third-party content is a critical component of most websites today. It powers everything: analytics, live chat, advertising, video sharing and more. Third-party content provides value by taking the heavy lifting off of site owners and allows them to focus on their core competencies.

Many think of third-party content as being JavaScript-based, but the data shows that this is only true for 22% of requests. Third-party content comes in all forms, from images (37%) to audio (0.1%).

In this chapter we will review the prevalence of third-party content and how this has changed since 2019. We will also review: the impact of third-party content on page weight (a good proxy for overall performance impact), scripts that load early in the page lifecycle, the impact of third-party content on browser CPU time, and how open third-parties are with their performance data.

## Definitions

Before jumping into the data we should define the terminology used in this chapter.

### "Third Party"

A third-party resource is an entity outside the primary site-user relationship. It involves the aspects of the site not directly within the control of the site owner but present, with their approval. For example, the Google Analytics script is a common third-party resource.

We consider third-party resources as those:

* Hosted on a _shared_ and _public_ origin
* Widely used by a variety of sites
* Uninfluenced by an individual site owner

To match these goals as closely as possible, the formal definition used throughout this chapter for third-party resources is: a resource that originates from a domain whose resources can be found on at least 50 unique pages in the HTTP Archive dataset.

Note that using these definitions, third-party content served from a first-party domain is counted as a first-party content. For example: self-hosting Google Fonts or bootstrap.css is counted as _first-party content_.

Similarly, first-party content served from a third-party domain is counted as third-party content. An associated example: First-party images served over a CDN on a third-party domain are considered _third-party content_.

### Provider categories

This chapter divides third-party providers into different categories. A brief description is included with each of the categories. The mapping of domain to category can be found in the <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">third-party-web repository</a>.

* Ad - display and measurement of advertisements
* Analytics - tracking site visitor behavior
* CDN - providers that host public shared utilities or private content of their users
* Content - providers that facilitate publishers and host syndicated content
* Customer Success - support and customer relationship management functionality
* Hosting - providers that host the arbitrary content of their users
* Marketing - sales, lead generation, and email marketing functionality
* Social - social networks and their affiliated integrations
* Tag Manager - provider whose sole role is to manage the inclusion of other third parties
* Utility - code that aids the development objectives of the site owner
* Video - providers that host the arbitrary video content of their users
* Other - uncategorized or non-conforming activity

_Note on CDNs: The CDN category here includes providers that provide resources on public CDN domains (e.g. bootstrapcdn.com, cdnjs.cloudflare.com, etc.) and does not include resources that are simply served over a CDN. i.e. putting Cloudflare in front of a page would not influence its first-party designation according to our criteria._

### Caveats

* All data presented here is based on a non-interactive, cold load. These values could start to look quite different after user interaction.
* The pages are tested from servers in the US with no cookies set, so third-parties requested after opt-in are not included. This will especially affect pages hosted and predominantly served to countries in scope for the [General Data Protection Regulation](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation), or other similar legislation.
* Only the home pages are tested. Other pages may having difference third-party requirements.
* Roughly 84% of all third-party domains by request volume have been identified and categorized. The remaining 16% fall into the "Other" category.

Learn more about our [methodology](./methodology).

## Prevalence

A good starting point for this analysis is to confirm the statement that third-party content is a critical component of most websites today. How many websites use third-party content, and how many third-parties do they use?

{{ figure_markup(
  image="pages-with-thirdparties.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1149547895&format=interactive",
  caption="Pages with third-party content.",
  description="Third party content prevalence has grown slightly since 2019. In 2019 93.6% of mobile pages had third-party content, in 2020 this was 94.1%. In 2019 93.6% of desktop pages had third-party content, in 2020 this was 93.9%.",
  width=600,
  height=371,
  sheets_gid="1477664642",
  sql_file="percent_of_websites_with_third_party.sql"
  )
}}

These prevalence numbers show a slight increase on [the 2019 results](../2019/third-parties): 93.87% of pages in the desktop crawl had at least one third-party request, the number was slightly higher at 94.10% of pages in the mobile crawl. A brief look into the small number of pages with no third-party content revealed that many were adult sites, some were government domains and some were basic landing / holding pages with little content. It is fair to say that the vast majority of pages have at least one third-party.

The chart below shows the distribution of pages by third-party count. The 10th percentile page has two third-party requests while the median page has 24. Over 10% of pages have more than 100 third-party requests.

{{ figure_markup(
  image="distribution-of-request-count.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1394563639&format=interactive",
  caption="Distribution of third-party requests.",
  description="Percentile chart of pages by third-party requests. The median mobile website has 24 third-party requests (23 on desktop) and it increases exponentially from 2 requests for both at the 10th percentile to 104 requests on mobile and 106 requests on desktop at the 90th percentile.",
  width=600,
  height=371,
  sheets_gid="181718921",
  sql_file="distribution_of_third_parties_by_number_of_websites.sql"
  )
}}

### Content-types

We can break down third-party requests by their content type. This is the reported [content-type](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) of the resources delivered from third-party domains.

{{ figure_markup(
  image="thirdparty-by-content-types.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=258155228&format=interactive",
  caption="Third-party content by type.",
  description="Images and JavaScript account for the majority (60%) of third-party content: 37.1% of third-party content is images, 21.9% is JavaScript, 16.1% is unknown or other, 15.4% is HTML",
  width=600,
  height=371,
  sheets_gid="53929561",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

The results show that the major contributors of third-party content are images (38%) and JavaScript (22%), with the next largest contributor being unknown (16%). Unknown is a subset of non-categorized groups such as text/plain as well as responses without a content-type header.

This shows a shift when <a href="../2019/third-parties#resource-types">compared to 2019</a>: relative image content has increased from 33% to 38%, whilst JavaScript content has decreased significantly from 32% to 22%. This reduction is likely due to increased adherence to cookie and data protection regulations, reducing third-party execution until after explicit user opt-in which is out of scope for HTTP Archive test runs.

### Third-party domains

When we dig further into domains serving third-party content we see that Google Fonts is by far the most common. It is present on more than 7.5% of mobile pages tested. While fonts only account for around 3% of third-party content, almost all of these are delivered by the Google Fonts service. If your page uses Google Fonts, make sure to follow <a hreflang="en" href="https://csswizardry.com/2020/05/the-fastest-google-fonts/">best practices</a> to ensure the best possible user experience.

{{ figure_markup(
  image="top-domains-by-prevalence.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=2082639138&format=interactive",
  caption="Top domains by prevalence.",
  description="Bar chart showing the top domains by prevalence. The most prevalent domains are font foundries, advertising, social media and JavaScript CDNs",
  width=600,
  height=371,
  sheets_gid="583962013",
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

The next four most common domains are all advertising providers. They may not be requested directly by the page but through a complex chain of redirects initiated by another advertising network.

The sixth most common domain is `digicert.com`. Calls to `digicert.com` are generally OCSP revocation checks due to TLS certificates not having OCSP stapling enabled, or the use of Extended Validation (EV) certificates which prevent pinning of intermediate certificates. This number is exaggerated in HTTP Archive due to all page loads being effectively first-time visitors - OCSP responses are generally cached and valid for seven days in real-world browsing. See <a hreflang="en" href="https://simonhearne.com/2020/drop-ev-certs/">this blog post</a> to read more on this issue.

Further down the list at 2.43% is `ajax.googleapis.com`, Google's <a hreflang="en" href="https://developers.google.com/speed/libraries">Hosted Libraries project</a>. Whilst loading a library such as jQuery from a hosted service is easy, the additional cost of a connection to a third-party domain may have a negative impact on performance. It is best to host all critical JavaScript and CSS on the root domain, if possible. There is also now no cache benefit to using a shared CDN resource, as all major browsers <a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">partition caches by page</a>. Harry Roberts has written a detailed blog post on <a hreflang="en" href="https://csswizardry.com/2019/05/self-host-your-static-assets/">how to host your own static assets</a>.

## Page weight impact

Third-parties can have a significant impact on the weight of a page, measured as the number of bytes downloaded by the browser. The [Page Weight chapter](./page-weight) explores this in more detail, here we focus on the third-parties that have the greatest impact on page weight.
### Heaviest third-parties

We can extract the largest third-parties by the median page weight impact, i.e. how many bytes they bring to the pages they are on. The results are interesting as this does not take into account how popular the third-parties are, just their impact in bytes.

{{ figure_markup(
  image="page-size-by-host.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=429818290&format=interactive",
  caption="Third-party size contribution by host.",
  description="Chart of third-party hosts and impact on page size, ranging from trailercentral.com at 2.7 MB to contenservice.mc.reyrey.net at 510 KB. Media providers result in the largest contribution to page size.",
  width=600,
  height=371,
  sheets_gid="1423970958",
  sql_file="top100_third_parties_by_median_body_size_and_time.sql"
  )
}}

The top contributors of page weight are generally media content providers, such as image and video hosting. Vidazoo, for example, results in a median page weight impact of about 2.5MB. The `inventory.vidazoo.com` domain provides video hosting, so a median page with this third-party has an _extra_ 2.5MB of media content!

A simple method to reduce this impact is to defer video loading until a user interacts with the page, so that the impact is reduced for those visitors that never consume the video.

We can take this analysis further to produce a distribution of total page size (in bytes downloaded for all resources) by third-party category presence. This chart shows that the presence of most third-party categories does not have a noticeable impact on total page size: this would be visible as a divergence in the plots. A notable exception to this is Advertising (in black) which shows a very small relationship with page size, indicating that advertisement requests do not add significant weight to pages. This is likely because many of these requests are small redirects, the [median is only 420 bytes](#large-redirects). We see similar low impact for tag managers, and analytics.

On the other end of the spectrum, the categories CDN, Content and Hosting all represent strong relationship with total page weight. This indicates that sites using hosted services are generally larger in page weight.

{{ figure_markup(
  image="page-size-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1508418357&format=interactive",
  caption="Page size distributions by third-party category.",
  description="Distribution of third-party categories and page size showing relationships between presence of third-parties and likelihood for pages to be large. CDN & Hosting show a strong correlation, Analytics shows a weak correlation.",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

### Cacheability

Some third-party responses should always be cached. Media such as images and videos served by a third-party, or JavaScript libraries are good candidates. On the other hand, tracking pixels and analytics beacons should never be cached. The results show that overall two-thirds of third-party requests are served with a valid caching header such as `Cache-Control`.

{{ figure_markup(
  image="requests-cached-by-content-type.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=299325299&format=interactive",
  caption="Third-party requests cached by content type.",
  description="Column chart showing percentage of cacheable requests by content type. Fonts are the highest at 96%, XML is the lowest at 18%",
  width=600,
  height=371,
  sheets_gid="1363055589",
  sql_file="percent_of_third_party_cache.sql"
  )
}}

Breaking down by response type confirms our assumptions: xml and text responses (as commonly delivered by tracking pixels / analytics beacons) are less likely to be cacheable. Surprisingly, less than two-thirds of images served by third-parties are cacheable. On further inspection, this is due to the use of tracking 'pixels' which are returned as non-cacheable zero-size gif image responses.

### Large redirects

Many third-parties result in redirect responses, i.e. HTTP status codes 3XX. These occur due to the use of vanity domains or to share information across domains through request headers. This is especially true for advertising networks. Large redirect responses are an indication of a misconfiguration, as the response should be around 340B for a valid `Location` response header plus overheads. The chart below shows the distribution of body size for all third-party redirects in the HTTP Archive.

{{ figure_markup(
  image="redirects-body-size.png",
  caption="Distribution of third-party 3XX body size.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1145900631&format=interactive",
  description="Distribution of redirect body sizes showing 90% are under 420 B, 1% are over 30 kB and 0.1% are over 100 kB.",
  width=600,
  height=371,
  sheets_gid="1056232541",
  sql_file="distribution_of_3XX_response_body_size.sql"
  )
}}

The results show that the majority of 3XX responses are small: the 90th percentile is 420 bytes, i.e. 90% of 3XX responses are 420 bytes or smaller. The 95th percentile is 6.5 kB, the 99th is 36 kB and the 99.9th is over 100 kB! Whilst redirects may seem innocuous, 100kB is an unreasonable amount of bytes over the wire for a response that simply leads to another response.

## Early-loaders

Scripts that load late in the page will have an impact on total page load duration and page weight but might have no impact on the user experience. Scripts that load early in the page, however, will potentially cannibalize bandwidth for critical first-party resources and are more likely to interfere with the page load. This can have a detrimental impact on performance metrics and user experience.

The chart below shows the percentage of requests that load early, by device type and third-party category. The three stand-out categories are CDN, Hosting and Tag Managers: all of which tend to deliver JavaScript that is requested in the head of a document. Advertising resources are least likely to load early in the page, due to advertisement network requests generally being asynchronous scripts run after page load.

{{ figure_markup(
  image="requests-before-dom-by-category.png",
  caption="Early third-party requests by category.",
  description="Column chart showing percentage of requests loaded before DOM Content Loaded. Public CDN resources are most likely at 50% on desktop, whilst advertising resources are least likely at 7%",
  width=600,
  height=371,
  sheets_gid="2118409936",
  sql_file="percent_of_third_party_loaded_before_DOMContentLoaded.sql"
  )
}}

## CPU impact

Not all bytes on the web are equal: a 500 KB image may be far easier for a browser to process than a 500 KB compressed JavaScript bundle, which inflates to 1.8MB of client-side code! The impact of third-party scripts on CPU time can be far more critical than the additional bytes or time spent on the network.

We can correlate the presence of third-party categories with the total CPU time on the page, this allows us to estimate the impact of each third-party category on CPU time.

{{ figure_markup(
  image="cpu-time-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=225817673&format=interactive",
  caption="Distribution of CPU time by categories.",
  description="Distribution of CPU load time by presence of third-party categories. Most categories follow the same pattern, with advertising the outlier showing higher CPU load time, especially at lower percentiles.",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

This chart shows the probability density function of total page CPU time by the third-party categories present on each page. The median page is at 50 on the percentile axis. The data shows that all third-party categories follow a similar pattern, with the median page between 400 - 1,000 ms CPU time. The outlier here is advertising (in black): if a page has advertising tags it is much more likely to have high CPU usage during page load. The median page with advertising tags has a CPU load time of 1,500 ms, compared to 500 ms for pages without advertising. The high CPU load time at the lower percentiles indicates that even the fastest sites are impacted significantly by the presence of third-parties categorized as advertising.

## `timing-allow-origin` prevalence

The [Resource Timing API](https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API) allows website owners to measure the performance of individual resources via JavaScript. This data is, by default, extremely limited for cross-origin resources like third-party content. There are legitimate reasons for not providing this timing information such as responses that vary by authentication state: e.g. a website owner may be able to determine if a visitor is logged into a Facebook by measuring the response size of a widget request. For most third-party content, though, setting the `timing-allow-origin` header is an act of transparency to allow the hosting website to track performance and size of their third-party content.

{{ figure_markup(
  image="requests-with-tao.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1886505312&format=interactive",
  caption="Requests with `timing-allow-origin` header.",
  description="Less than 35% of third-party responses are served with a timing-allow-origin header",
  width=600,
  height=371,
  sheets_gid="1947152286",
  sql_file="tao_by_third_party.sql"
  )
}}

The results in HTTP Archive show that only one third of third-party responses expose detailed size and timing information to the hosting website.

## Repercussions

We know that adding arbitrary JavaScript to our sites introduces risks to both site speed and security. Site owners must be diligent to balance the value of the third-party scripts they include with the speed penalty they may bring, and use modern features such as [subresource integrity](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity) and [content security policy](https://developer.mozilla.org/docs/Web/HTTP/CSP) to maintain a strong security posture. See the [Security chapter](./security) for more detail on these and other browser security features.

## Conclusion

One of the surprises in the data from 2020 is the drop in relative JavaScript requests: from 32% of the total to just 22%. It is unlikely that the actual amount of JavaScript on the web has decreased this significantly, it is more likely that websites are implementing consent management - so that most dynamic third-party content is only loaded on user opt-in. This opt-in process could be managed by a Consent Management Platform (CMP) in some cases. The third-party database does not yet have a category for CMPs, but this would be a good analysis for the 2021 Web Almanac and is covered through a different methodology in [the Privacy chapter](./privacy#consent-management-platforms).

Advertising requests appear to have an increased impact on CPU time. The median page with advertising scripts consume three times as much CPU as those without. Interestingly though, advertising scripts are not correlated with increased page weight. This makes it even more important to evaluate the total impact of third-party scripts on the browser, not just request count and size.

While third-party content is critical to many websites, auditing the impact of each provider is critical to ensure that they do not significantly impact user experience, page weight or CPU utilization. There are often self-hosting options for the top contributors to third-party weight, this is especially worth considering as there is now no caching benefit to using shared assets:

* Google Fonts allows <a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">self-hosting</a> the assets
* JavaScript CDNs can be replaced with self-hosted assets
* Experimentation scripts can be self-hosted, e.g. <a hreflang="en" href="https://help.optimizely.com/Set_Up_Optimizely/Optimizely_self-hosting_for_Akamai_users">Optimizely</a>

In this chapter we have discussed the benefits and costs of third-party content on the web. We have seen that third-parties are integral to almost all websites, and that the impact varies by third-party provider. Before adding a new third-party to your pages, consider the impact that they will have!
