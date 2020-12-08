---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: I
chapter_number: 6
title: Third Parties
description: Third Parties chapter of the 2020 Web Almanac covering data of what third parties are used, what they are used for, performance impacts and privacy impacts.
authors: [simonhearne]
reviewers: [tammyeverts, jzyang]
analysts: [max-ostapenko]
translators: []
simonhearne_bio: Simon is a web performance architect, he is passionate about helping deliver a faster and more accessible web. You can find him tweeting <a href="https://twitter.com/simonhearne">@SimonHearne</a> and blogging at <a href="https://simonhearne.com">simonhearne.com</a>.
discuss: 2042
results: https://docs.google.com/spreadsheets/d/1uW4SMkC45b4EbC4JV1xKAUhwGN2K8j0qFy_jSIYnHhI/
queries: 06_Third_Parties
featured_quote: Third-party content is critical to most websites, from analytics and advertizing to video and image content. In this chapter we review how prevalent third-party content is on the web and what impact is has on key performance indicators.
featured_stat_1: 94.1%
featured_stat_label_1: Pages with third-party content
featured_stat_2: 21.5%
featured_stat_label_2: Third-party content delivered as JavaScript
featured_stat_3: 38.5%
featured_stat_label_3: Third-party content delivered as Images
unedited: true
---
## Introduction

Third-party content is a critical component of most websites today.  It powers everything: Analytics, live chat, advertising, video sharing, etc.  Third-party content provides value by taking the heavy lifting off of site owners and allows them to focus on their core competencies.

Many think of third-party content as being typically JavaScript-based, but the data shows that this is only true for 22% of requests! Third-party content comes in all forms, from images (37%) to audio (0.1%).

In this chapter we will review the prevalence of third-party content and how this has changed in recent years. We will also review:  The impact of third-party content on page weight (a good proxy for overall performance impact), scripts that load early in the page lifecycle, the impact of third-party content on browser CPU time, and how open third-parties are with their performance data.

## Definitions

### "Third Party"

A third party resource is an entity outside the primary site-user relationship.  It involves the aspects of the site not directly within the control of the site owner but present, with their approval.  For example, the Google Analytics script is a common third-party resource.

Third-party resources are:



*   Hosted on a _shared_ and _public_ origin
*   Widely used by a variety of sites
*   Uninfluenced by an individual site owner

To match these goals as closely as possible, the formal definition used throughout this chapter for third-party resources is: A resource that originates from a domain whose resources can be found on at least 50 unique pages in the HTTP Archive dataset.

Note that using these definitions, third-party content served from a first-party domain is counted as a first-party content. For example: Self-hosting Google Fonts or bootstrap.css is counted as _first-party content_.  Similarly, first-party content served from a third-party domain is counted as third-party content. An associated example: First-party images served over a CDN on a third-party domain are considered _third-party content_.


### Provider categories

This chapter divides third-party providers into different categories. A brief description is included with each of the categories.  The mapping of domain to category can be found in the [third-party-web repository](https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5).



*   Ad - display and measurement of advertisements
*   Analytics - tracking site visitor behavior
*   CDN - providers that host public shared utilities or private content of their users
*   Content - providers that facilitate publishers and host syndicated content
*   Customer Success - support and customer relationship management functionality
*   Hosting - providers that host the arbitrary content of their users
*   Marketing - sales, lead generation, and email marketing functionality
*   Social - social networks and their affiliated integrations
*   Tag Manager - provider whose sole role is to manage the inclusion of other third parties
*   Utility - code that aids the development objectives of the site owner
*   Video - providers that host the arbitrary video content of their users
*   Other - uncategorized or non-conforming activity

_Note on CDNs: The CDN category here includes providers that provide resources on public CDN domains (e.g. bootstrapcdn.com, cdnjs.cloudflare.com, etc.) and does not include resources that are simply served over a CDN. i.e. putting Cloudflare in front of a page would not influence its first-party designation according to our criteria._

### Caveats

*   All data presented here is based on a non-interactive, cold load. These values could start to look quite different after user interaction.
*   The pages are tested with no cookies set, so third-parties requested after opt-in are not included. This will especially affect pages hosted and predominantly served to countries in scope for the [General Data Protection Regulation](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation).
*   Roughly 84% of all third-party domains by request volume have been identified and categorized. The remaining 16% fall into the "Other" category.

## Prevalence

A good starting point for this analysis is to back up the statement that third-party content is a critical component of most websites today. How many websites use third-party tags, and how many tags do they use?

<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


The numbers show a slight increase on [2019’s results](https://almanac.httparchive.org/en/2019/third-parties): 93.87% of pages in the desktop crawl had at least one third-party request, the number was slightly higher at 94.10% of pages in the mobile crawl. A brief look into the small number of pages with no third-party content revealed that many were adult sites, some government domains and some basic landing / holding pages.


### Content-Types

For the pages with third-party content, we can break down the requests by their content type. This is the reported [content-type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type) of the resources delivered from third-party domains.

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image3.png "image_tooltip")

The results show that the major contributors of third-party content are images (38%) and JavaScript (22%), with the next largest contributor being unknown (16%).  Unknown is a subset of non-categorized groups such as text/plain as well as responses without a content-type header.

This shows a shift when[ compared to 2019](https://almanac.httparchive.org/en/2019/third-parties#resource-types): Relative image content has increased from 33% to 38%, whilst JavaScript content has decreased from 32% to 22%. It is likely that increased adherence to cookie and data protection regulations limited third-party tag execution until after explicit opt-in.

### Third-Party Domains

When we dig further into domains serving third-party content  we see that Google Fonts is by far the most common.  It is present on more than 7.5% of mobile pages tested.  While fonts only account for around 3% of third-party content, almost all of these are delivered by the Google Fonts service. If your page uses Google Fonts, make sure to follow [best practices](https://csswizardry.com/2020/05/the-fastest-google-fonts/) to ensure the best possible user experience.

The next four most common domains are all advertising providers, they may not be requested directly by your page but through a complex chain of redirects initiated by another advertising network.

The sixth most common domain is digicert.com.  Calls to digicert.com are generally OCSP revocation checks due to TLS certificates not having OCSP stapling enabled, or the use of Extended Validation (EV) certificates which prevent pinning of intermediate certificates. This number is exaggerated in HTTP Archive due to all page loads being effectively first-time visitors - OCSP responses are generally valid for seven days. See [here](https://simonhearne.com/2020/drop-ev-certs/) to read more on this issue.

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image4.png "image_tooltip")

Further down the list at 2.43% is ajax.googleapis.com, Google's [Hosted Libraries project](https://developers.google.com/speed/libraries). Whilst loading a library such as jQuery from a hosted service is easy, the additional cost of a connection to a third-party domain may have a negative impact on performance. It is best to host all critical JavaScript and CSS on the root domain, if possible. There is also no cache benefit to using a shared CDN resource, all major browsers now [partition caches by page](https://developers.google.com/web/updates/2020/10/http-cache-partitioning).

## Page Weight Impact

### Heaviest third-parties

We can extract the largest third-parties by the median page weight impact, i.e. how many bytes they bring to the pages they are on. The results are interesting as this does not take into account how popular the third-parties are, just their impact in bytes.

<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image5.png "image_tooltip")

The top contributors of page weight are generally media content providers, such as image and video hosting. Vidazoo, for example, results in a median page weight impact of about 2.5MB. The inventory.vidazoo.com domain provides video hosting, so a median page with this third-party has an _extra_ 2.5MB of media content!

A simple method to reduce this impact is to defer video loading until a user interacts with the page, so that the impact is reduced for those visitors that never consume the video.

We can take this analysis further to produce a distribution of total page size (in bytes downloaded for all resources) by third-party category presence. This chart shows that the presence of most third-party categories does not have a noticeable impact on total page size: this would be visible as a divergence in the plots. A notable exception to this is Advertising (in black) which shows a very small relationship with page size, indicating that advertisement requests do not add significant weight to pages. This is likely because many of these requests are small redirects, the median is only 420 bytes. We see similar low impact for tag managers, and analytics.

On the other end of the spectrum, the categories CDN, Content and Hosting all represent strong relationship with total page weight. This indicates that sites using hosted services are generally larger in page weight.

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image6.png "image_tooltip")

### Cacheability

Some third-party responses should always be cached.  Media such as images and videos served by a third-party, or JavaScript libraries are good candidates. The results show that overall two-thirds of third-party requests are served with a valid caching header such as `cache-control`.

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image7.png "image_tooltip")

Breaking down by response type highlights some common offenders: xml and text responses are less likely to be cacheable. Surprisingly, less than two-thirds of images served by third-parties are cacheable. On further inspection, this is due to the use of tracking 'pixels' which are returned as non-cacheable zero-size image responses. 

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image8.png "image_tooltip")

### Large redirects (i.e. 301 / 302 with >0 body size)?

Many third-parties result in redirect responses (i.e. HTTP status codes 3XX). These occur because of the use of vanity domains or to share information across domains through request headers. This is especially true for advertising networks. Large redirect responses are an indication of a misconfiguration, as the response should be around 340B for a valid `Location` response header plus overheads. The chart below shows the distribution of body size 

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image9.png "image_tooltip")

The results show that the majority of 3XX responses are small: the 90th percentile is 420B (i.e. 90% of 3XX responses are 420 bytes or smaller). The 95th percentile is 6.5kB and the 99th is 36kB! Whilst redirects may seem innocuous, 36kB is a reasonable amount of bytes over the wire for a response that simply leads to another response!

## Early-loaders

Scripts that load late in the page will have an impact on total page load duration and page weight, but might have no impact on the user experience. Scripts that load early in the page, however, will potentially cannibalize bandwidth for critical first-party resources and are more likely to interfere with the page load.  This can have a detrimental impact on performance metrics and user experience.

The chart below shows the percentage of requests that load early, by device type and third-party type. The three stand-out categories are CDN, Hosting and Tag Managers, all of which tend to deliver JavaScript that is requested in the head of a document. 

<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image10.png "image_tooltip")

## CPU Impact

Not all bytes on the web are equal.  For example, a 500kB image may be far easier for a browser to process than a 500kB compressed JavaScript bundle which inflates to 1.8MB of client-side code! The impact of third-party scripts on CPU time can be far more critical than the additional bytes or time spent on the network.

We have a few measures to capture this impact and with the [TaskAttributionTiming](https://w3c.github.io/longtasks/#sec-TaskAttributionTiming) interface we can determine which scripts are responsible for [long tasks](https://developer.mozilla.org/en-US/docs/Web/API/Long_Tasks_API).

Long tasks are defined as single main-thread tasks which take longer than 50ms to complete, indicating that the user experience will be degraded while they are executing.

<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image11.png "image_tooltip")

This chart shows the probability density function of third-party categories and the CPU time on the page on which the third-party was loaded. The median page is at 50 on the percentile axis. The data shows that all third-party categories follow a similar pattern, with the median page between 400-1,000 ms CPU time. The outlier here is advertising (in black): if a page has advertising tags it is much more likely to have high CPU usage during page load. The median page with advertising tags has a CPU load time of 1,500ms, compared to 500ms for pages without advertising.

## Other

Third-party origins can opt-in to providing improved performance and security visibility to the parent origin. Two response headers are specifically designed for this purpose:

*   [Timing-Allow-Origin: *](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Timing-Allow-Origin) allows origin JavaScript to access detailed performance information about the third-party content, such as download size, TLS negotiation time etc. Without this header, only a total download duration is available to JavaScript.
*   [Access-Control-Allow-Origin: *](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) allows origin JavaScript access to the stack of third-party content, important for determining the cause of errors in the field.

### Timing-Allow-Origin prevalence

Size and timing information is extremely limited without a timing-allow-origin response header. There are legitimate reasons for not providing this timing information, such as responses that vary by authentication state: e.g. a website owner may be able to determine if a visitor is logged into a Facebook by measuring the response size of a widget request. For most third-party content, though, setting the timing-allow-origin header is an act of transparency to allow the hosting website to track performance and size of their third-party content.

<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image12.png "image_tooltip")

The results in HTTP Archive show that only one third of third-party responses expose detailed size and timing information to the hosting website.

## Repercussions

We know that adding arbitrary JavaScript to our sites can have a detrimental impact on both site speed and security. Site owners must be diligent to balance the value of the third-party scripts they include with the speed penalty they may bring, and use modern features such as [subresource integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity) and [content security policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) to maintain a strong security posture.

## Conclusion

One of the surprises in the data from 2020 is the drop in relative JavaScript requests, from 32% of the total to just 22%. It is unlikely that the actual amount of JavaScript on the web has decreased this significantly, so it is more likely that websites are implementing consent management - so that most third-party content is only loaded on user opt-in. The third-party database does not yet have a category for CMPs (consent management platforms), but this would be a good analysis for the 2021 Web Almanac.

Advertising requests appear to have an increased impact on CPU time, pages with advertising scripts consume three times as much CPU as those without. Interestingly though, advertising scripts are not correlated with increased page weight. The

Whilst third-party content is critical to many websites, auditing the impact of each provider is critical to ensure that they do not significantly impact page weight or CPU utilization. There are often self-hosting options for the top contributors to third-party weight, this is especially worth considering as there is now no caching benefit to using shared assets:

* Google Fonts allows [self-hosting](https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/) the assets
* JavaScript CDNs can be replaced with self-hosted assets
* Experimentation scripts can be self-hosted, e.g. [Optimizely](https://help.optimizely.com/Set_Up_Optimizely/Optimizely_self-hosting_for_Akamai_users)

