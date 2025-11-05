---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookies
description: Cookies chapter of the 2025 Web Almanac covering the prevalence and structure of cookies on the web.
hero_alt: Hero image of Web Almanac characters carrying a large cookie, while crumbs are thrown off by another character. Another Web Almanac character is following the trail of cookies with a detective hat and a magnifying glass.
authors: [yohhaan,ajackley]
reviewers: []
analysts: [ChrisBeeti]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1ZirsnaXgbOMzBmt0X2eMMu3rVJvWCtQgE7pNG7fKcvc/edit
yohhaan_bio: Yohan Beugin is a Ph.D. student in the Department of Computer Sciences at the University of Wisconsin–Madison where he is a member of the Security and Privacy Research Group and advised by Prof. Patrick McDaniel. He is interested in building more secure, privacy-preserving, and trustworthy systems. His current research so far has focused on security of open-sourec software as well as tracking and privacy in online advertising.
ajackley_bio: Anne Jackley is ...TODO...
featured_quote: ...TODO
featured_stat_1: ...TODO
featured_stat_label_1: ...TODO
featured_stat_2: ...TODO
featured_stat_label_2: ...TODO
featured_stat_3: ...TODO
featured_stat_label_3: ...TODO
doi: ...TODO
---

## Introduction

[Cookies](https://developer.mozilla.org/docs/Web/HTTP/Cookies) allow websites to save data and maintain state information across HTTP requests, a stateless protocol. Web applications use cookies for several purposes, like authentication, fraud prevention and security, or remembering preferences and user choices, etc. However, ever since their introduction in the mid-1990s, cookies have also played a dominant role in online tracking of web users.

Over the years, browser vendors such as Brave, Firefox, and Safari have imposed restrictions, partitioned, and removed third-party cookies. While Chrome initially appeared to follow in these same steps by announcing <a hreflang="en" href="https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html">plans to block all third-party cookies</a>, several delays and postponements later, Google eventually decided to <a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">maintain their current approach in Chrome</a>. As a result, cookies—the focus of this 2025 Web Almanac Chapter—remain an essential component in today's web landscape.

In the chapter below, we measure and report on the prevalence and structure of web cookies encountered on the webpages visited by the HTTP Archive crawl of July 2025. The majority of these results, except when mentioned otherwise, are for the top one million (top 1M) most popular websites according to their rank in the Chrome User Experience report (i.e., CrUX rank). Results are also shown for both desktop and mobile devices; although, in practice for our results we rarely any significant difference between the two types of devices.

## Background

To avoid repetitions and overlap with concepts and definitions already explained in the 2024 Cookies chapter, we refer interested readers to last year's [Definitions section](../2024/cookies#definitions) for (a) an overview of the different types of cookies and (b) the privacy and security risks they can pose.

{# TODO check that previous link to 2024 is correct #}

{# TODO ask if queries should be uploaded for 2025, although we reused the ones from 2024 #}
{# TODO resolves all todos left in document #}

## First and third-party prevalence

{{ figure_markup(
  image="first-and-third-party-prevalence.png",
  caption="First- and third-party prevalence.",
  description="Bar chart showing the prevalence of first- and third-party cookies on desktop and mobile clients. On desktop: 41% first- and 59% third-party cookies. On mobile: 40% first- and 60% third-party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=133146154&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

The overall prevalence of first- and third-party cookies on the top 1M most popular websites from the HTTP Archive crawl of July 2025 is similar to last year's distribution. On both desktop and mobile devices, 40% of cookies are first-party and 60% third-party ([Figure 1](#fig-1)). Below, we report on the same first- and third-party split across different CrUX ranks.

{{ figure_markup(
  image="first-and-third-party-prevalence-by-rank-desktop.png",
  caption="First- and third-party prevalence of cookies by rank on desktop clients.",
  description="Bar chart showing the prevalence of first- and third-party cookies on desktop clients according to the popularity of the website. We see that more popular websites set significantly more third-party cookies. For the top 1k most popular websites on desktop clients, 78% of cookies set are third-party, while for the top 1M websites, 59% of cookies are third-party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1437171045&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

{{ figure_markup(
  image="first-and-third-party-prevalence.png-by-rank-mobile.png",
  caption="First- and third-party prevalence of cookies by rank on mobile clients.",
  description="Bar chart showing the prevalence of first- and third-party cookies on mobile clients according to the popularity of the website. We see that more popular websites set significantly more third-party cookies. For the top 1k most popular websites on desktop clients, 78% of cookies set are third-party, while for the top 1M websites, 60% of cookies are third-party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=76250674&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

We observe from [Figure 2](#fig-2) and [Figure 3](#fig-3) that the most visited websites tend to set significantly more third-party cookies (78% of cookies on the top 1k) than others visited less often (just below 50% on top 10M). This may be explained by the fact that more popular websites also include more third-party content and scripts that in turns set third-party cookies to enable different functionalities.

## Cookie attributes

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  caption="An overview of cookie attributes for desktop clients.",
  description="This figures gives an overview of how cookie attributes are used for desktop clients for both first- and third-party cookies. 100% of third-party cookies include the `SameSite` and `Secure` attributes. Only 1% of first-party cookies and 10% of third-party cookies use `Partioned`. 19% of first-party cookies set their `Session` attribute, while this is the case for only 7% of third-party cookies. Finally, 12% of first-party cookies and 28% of third-party cookies use the `HttpOnly` attribute.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1053912620&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="An overview of cookie attributes for mobile clients.",
  description="This figures gives an overview of how cookie attributes are used for mobile clients for both first- and third-party cookies. We observe the exact same results as for desktop clients. 100% of third-party cookies include the `SameSite` and `Secure` attributes. Only 1% of first-party cookies and 9% of third-party cookies use `Partioned`. 19% of first-party cookies set their `Session` attribute, while this is the case for only TODO% of third-party cookies. Finally, 12% of first-party cookies and 26% of third-party cookies use the `HttpOnly` attribute.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=435743769&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{# TODO: verify 63% (maybe 6.3%?) for Session attribute for mobile on top 1M #}

[Figure 4](#fig-4) and [Figure 5](#fig-5) showcase the different cookie [attributes](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie) for each type of cookies observed.

### `Partitioned`

On [compatible browsers](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility), partitioned cookies prevent third-party cookies to be used for cross-site tracking by placing them into a storage partitioned per top-level site. In July 2025, about 10% of third-party cookies on the top 1M are partitioned. We observe here a slight increase in adoption of this relatively new attribute in comparison to the 6% of last year's results.

{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="Top partitioned cookies (CHIPS) in third-party context.",
  description="A chart showing the top third-party domains setting partitioned cookies. The top partitioned cookies in third-party context are `cf_clearance` set by Cloudflare and is used for anti-bot challenge.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1834436287&format=interactive",
  sheets_gid="581303793",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}

[Figure 6](#fig-6) shows the 10 most common partitioned cookies (name and domain) that are found in third-party context on webpages during the July 2025 crawl. Here, we observe a major change from last year's analysis, indeed the overall usage of third-party partitioned cookies in 2025 appears to have plummeted to very low levels. Interestingly, partitioned cookies that were somewhat predominant in 2024 (on about 9% of websites) are not present anymore; two cookies were set by YouTube and another one was the `receive-cookie-deprecation` cookie set by domains that [participated in the testing phase](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing) of Chrome's Privacy Sandbox. Instead, Cloudflare's `cf_clearance` cookie accounts for the entirety of the top 10 most common partitioned third-party cookies in 2025.

So, in the past year YouTube appears to have altered how these cookies were set on `youtube.com` and on video iframes embedded on other websites. Potential reasons that could explain these changes include: incorrect setting, A/B testing, and more likely infrastructure or policy updates following Google's announcements on the pause and then deprecation of Privacy Sandbox APIs, despite support for partitioned cookies (CHIPS proposal) still being continued, etc.

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="Top partitioned cookies (CHIPS) in first-party context.",
  description="A chart showing the top first-party partitioned cookies. The top cookie `cf_clearance` is set by Cloudflare on about 92% of pages, and indicates that the user has successfully completed bot detection.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1232746047&format=interactive",
  sheets_gid="581303793",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}

<!-- also change here, no more receive-cookie-deprecation -->

We also continue to observe that some first-party cookies are set as partitioned, when


<!-- Perhaps a bit surprising, 1% of all the first-party cookies that are set on the top 1M websites (desktop and mobile client) are partitioned. However, partitioning cookies in a first-party context appears to be a bit redundant as first-party cookies are already accessible, by definition, only by that first-party on that top-level site. The following figure displays the top ten partitioned cookies set in first-party context for each client. `receive-cookie-deprecation` is set by domains that [participate in the testing phase](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing) of Chrome's Privacy Sandbox. `cf_clearance` and `csrf_token` are cookies set by Cloudflare to indicate that the user has successfully completed an anti-bot challenge or to identify trusted web traffic, respectively. -->


### Session

<!-- Session cookies are cookies that are only valid for a single user session. In other words, session cookies are temporary and expire once the user quits the corresponding website they were set on, or closes their web browser, whichever happens first. However, note that some web browsers allow users to restore a previous session on startup, in that case the session cookies set in that previous session are also restored.

The results from our analysis on the top 1M websites in July 2025 show that 16% of first-party cookies and only 4% of third-party cookies are session cookies (on both desktop and mobile clients). -->

### `HttpOnly`

<!-- The [`HttpOnly`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#httponly) attribute prevents cookies from being accessed by javascript code, this provides some mitigation against [cross-site scripting (XSS)](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting) attacks. Note that setting the `HttpOnly` attribute does not prevent cookies from being sent along `XMLHttpRequest` or `fetch` requests initiated from javascript.

Only 12% of first-party cookies have the `HttpOnly` attribute set, while for third-party cookies 19% on desktop and 18% on mobile do. -->

### `Secure`

<!-- Cookies with the [`Secure`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#secure) attribute are only sent to requests made through HTTPs. This prevents [man-in-the-middle](https://developer.mozilla.org/docs/Glossary/MitM) attacks.

For first-party cookies, 23% on desktop and 22% on mobile have the `Secure` attribute and all third-party cookies observed have the `Secure` attribute. Indeed, these third-party cookies also have the `SameSite=None` attribute that requires `Secure` to be set (see the next section). -->

### `SameSite`

<!-- The [`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) cookie attribute allows sites to specify when cookies are included with cross-site requests:
- `SameSite=Strict`: a cookie is only sent in response to a request from the same site as the cookie's origin.
- `SameSite=Lax`: same as `SameSite=Strict` except that the browser also sends the cookie on navigation to the cookie's origin site. This is the default value of `SameSite`.
- `SameSite=None`: cookies are sent on same-site or cross-site requests.
This means that in order to make third-party tracking with cookies possible, the tracking cookies must have their `SameSite` attribute set to `None`.

To learn more about the `SameSite` attribute, see the following references:
- [`SameSite` cookies explained](https://web.dev/articles/samesite-cookies-explained)
- ["Same-site" and "same-origin"](https://web.dev/articles/same-site-same-origin)
- [What are the parts of a URL?](https://web.dev/articles/url-parts) -->

{{ figure_markup(
  image="same-site-desktop.png",
  caption="`SameSite` attribute for cookies on desktop client.",
  description="Shows the prevalence of the `SameSite` attribute and its value for both first-party and third-party cookies on desktop clients. 3.31% of first-party cookies set the `SameSite` attribute to `Strict`, 19.23% use `SameSite=Lax` (which is the default), 11.21% set the value to `None` and 66.24% do not specify the value of `SameSite`. Nearly 100% of third-party cookies set the `SameSite` attribute to `None`, in order for these cookies to be sent in a cross-site context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=42361140&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="same-site-mobile.png",
  caption="`SameSite` attribute for cookies on mobile client.",
  description="Shows the prevalence of the `SameSite` attribute and its value for both first-party and third-party cookies on mobile clients. We see very similar results as for desktop clients. 3.11% of first-party cookies set the `SameSite` attribute to `Strict`, 19.46% use `SameSite=Lax` (which is the default), 11.28% set the value to None and 66.15% do not specify the value of `SameSite`. Nearly 100% of third-party cookies set the `SameSite` attribute to `None`, in order for these cookies to be sent in a cross-site context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=413420306&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

<!-- Similar results than last year - 66.15% to fix in GGSheet-->

<!-- We observe that for each client about 33% of the first-party cookies and nearly 100% third-party cookies seen on the top 1M websites have a `SameSite` attribute that is explicitly set when they are created (reminder: `SameSite` defaults to `Lax` if not specified). The two bar charts above represent the distribution of this `SameSite` attribute for first and third-party cookies across clients. We observe that the differences in results across clients is here again somewhat negligible. Nearly 100% of third-party cookies have `SameSite=None`, and so are sent on cross-site requests.
For first-party cookies, about 87% of them have the `SameSite=Lax` (20% explicitly set the attribute, and the remaining 67% are concerned by the default behavior when `SameSite` is not set). 11% of cookies have their `SameSite` attributes explicitly set to have the value `None`. It's hard to determine the exact purpose for which cookies are set, but it is likely that a fraction of these cookies are used to track users in a first-party context. Only 2% of cookies have `SameSite` set to `Strict`. -->


## Cookie prefixes


<!-- Two [cookie prefixes](https://developer.mozilla.org/docs/Web/HTTP/Cookies#cookie_prefixes) `__Host-` and `__Secure-` can be used in the cookie name to indicate that they can only be set or modified by a secure HTTPS origin. This is to defend against [session fixation](https://developer.mozilla.org/docs/Web/Security/Types_of_attacks#session_fixation) attacks. Cookies with both prefixes must be set by a secure HTTPs origin and have the `Secure` attribute set. Additionally, `__Host-` cookies must not contain a `Domain` attribute and have their `Path` set to `/`, thus `__Host-` cookies are only sent back to the exact host they were set on, and so not to any parent domain. -->

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="Cookie prefixes observed on desktop pages.",
  description="Shows the observed cookies prefixes used on desktop pages. We see that 0.032% of first-party cookies and only 0.001% of third-party cookies include `__Host-`. Similarly, 0.03% of first-party cookies and 0.001% of third-party cookies include `__Secure-`. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=908965565&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="Cookie prefixes observed on mobile pages.",
  description="Shows the observed cookies prefixes used on mobile pages. We observe very similar results to the cookies prefixes used on desktop pages. We see that 0.031% of first-party cookies and only 0.001% of third-party cookies include `__Host-`. Similarly, 0.03% of first-party cookies and 0.001% of third-party cookies include `__Secure-`. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1209286948&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

<!-- have results been updated? If so, same ones as last year -->

<!-- We measure that 0.032% and 0.030% of the first-party cookies observed on desktop have the `__Host-` and `__Secure-` prefix set, respectively. These numbers are 0.001% for third-party cookies. These results show the very low adoption of these prefixes and the associated defense-in-depth measure since they were first <a hreflang="en" href="https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis#section-4.1.3.1">introduced</a> at the end of 2015. -->


## Top first and third-party cookies and domains setting them

<!-- In the following section, we report for each client (desktop and mobile) the top ten first-party cookies, third-party cookies, as well as domains that set them. We comment on a few of them using results from <a hreflang="en" href="https://cookiepedia.co.uk/">Cookiepedia</a> and invite curious readers to refer to this resource for more. -->

{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="Top first-party cookies set.",
  description="The chart shows the most widely-set first-party cookies. Google Analytics sets the `_ga` and `_gcl_au` cookies, which are used for website statistics, analytics reports, and targeted advertising, on more than 60% and 25% of websites, respectively, for both mobile and desktop clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=219782191&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_first_party_cookies.sql"
  )
}}

<!-- The first two first-party cookies `_ga` and `_gid` are set by <a hreflang="en" href="https://business.safety.google/adscookies/">Google Analytics</a> to store client identifiers and statistics for site analytics reports, a majority of websites use Google Analytics (more than 60% and 35%, respectively). The third one `_fbp` is set by Facebook and used for targeted advertising on 25% of the websites. -->

{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="Top third-party cookies and domains that set them.",
  description="The chart shows the most widely-set third-party cookies. DoubleClick sets third-party advertising cookies on a little over 35% of pages. Microsoft also sets advertising cookies on 23% of pages. All top 10 domains setting third-party cookies are related to tracking and advertising.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=232078905&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_third_party_cookies.sql"
  )
}}

<!-- The `IDE` and `test_cookie` cookies are set by `doubleclick.net` (owned by Google) and are the most common third-party cookies observed on the top 1M websites; they are used for targeted advertising. DoubleClick checks if a user's web browser supports third-party cookies by trying to set `test_cookie`. `MUID` from Microsoft comes next and is also used in targeted advertising to store the user's unique identifier for cross-site tracking. -->

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Top registrable domains setting cookies.",
  description="The chart shows the most common domains that set cookies on the web. Google's owned advertising platform DoubleClick sets cookies on more than 33% of the top 1M websites while others in this top 10 domains are at about 5% to 15%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=483296297&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_domains_setting_cookies.sql"
  )
}}

<!-- Among the ten most common domains that set cookies on the web, we only find domains involved in search, targeting, and advertising services. This result outlines the coverage that some third-parties have of the web, for example: Google's owned advertising platform DoubleClick sets cookies on more than 44% of the top 1M websites while others are at about 8% to 12%. -->



## Number of cookies set by websites
<figure>
  <table>
    <thead>
      <tr>
        <th>Number of cookies (desktop top 1M) </th>
        <th>First-party</th>
        <th>Third-party</th>
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">7</td>
        <td class="numeric">7</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">13</td>
        <td class="numeric">16</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">22</td>
        <td class="numeric">40</td>
        <td class="numeric">44</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">45</td>
        <td class="numeric">399</td>
        <td class="numeric">395</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">178</td>
        <td class="numeric">885</td>
        <td class="numeric">915</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for number of cookies set on desktop pages.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Number of cookies (mobile top 1M) </th>
        <th>First-party</th>
        <th>Third-party</th>
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">6</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">12</td>
        <td class="numeric">15</td>
        <td class="numeric">22</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">21</td>
        <td class="numeric">39</td>
        <td class="numeric">43</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">45</td>
        <td class="numeric">400</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">178</td>
        <td class="numeric">801</td>
        <td class="numeric">831</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for number of cookies set on mobile pages.") }}</figcaption>
</figure>

<!-- Websites set a median of nine or ten cookies of any type overall, seven first-party cookies, and four or five third-party cookies for mobile and desktop clients, respectively. The tables above report several other statistics about the number of cookies observed per website and the figures below display their cumulative distribution functions (cdf). For example: on desktop a maximum of 160 first-party and 632 third-party cookies are set per website. -->

{{ figure_markup(
  image="number-cookies-cdf-desktop.png",
  caption="Number of cookies per website (cdf) for desktop pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on desktop pages. We see that more websites have a number of first-party cookies that is closer to the maximum of first-party cookies observed, than for third-party cookies.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=160162622&format=interactive",
  sheets_gid="1535389309",
  sql_file="nb_cookies_cdf.sql"
  )
}}

{{ figure_markup(
  image="number-cookies-cdf-mobile.png",
  caption="Number of cookies per website (cdf) for mobile pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on mobile pages. We see that more websites have a number of first-party cookies that is closer to the maximum of first-party cookies observed, than for third-party cookies. Additionally, we observe very similar results for both desktop and mobile websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=569578852&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

<!-- We see that more websites have a number of first-party cookies that is closer to the maximum of first-party cookies observed, than for third-party cookies. -->


## Size of cookies

<figure>
  <table>
    <thead>
      <tr>
        <th>Size of cookies (desktop top 1M) in bytes </th>
        <th>First-party</th>
        <th>Third-party</th>
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">29</td>
        <td class="numeric">22</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">41</td>
        <td class="numeric">39</td>
        <td class="numeric">40</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">67</td>
        <td class="numeric">59</td>
        <td class="numeric">64</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">157</td>
        <td class="numeric">145</td>
        <td class="numeric">149</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">414</td>
        <td class="numeric">321</td>
        <td class="numeric">338</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4090</td>
        <td class="numeric">4096</td>
        <td class="numeric">4096</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for size of cookies set on desktop pages.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Size of cookies (mobile top 1M) in bytes </th>
        <th>First-party</th>
        <th>Third-party</th>
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">22</td>
        <td class="numeric">29</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">39</td>
        <td class="numeric">41</td>
        <td class="numeric">40</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">62</td>
        <td class="numeric">67</td>
        <td class="numeric">65</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">145</td>
        <td class="numeric">162</td>
        <td class="numeric">150</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">326</td>
        <td class="numeric">414</td>
        <td class="numeric">388</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4096</td>
        <td class="numeric">4081</td>
        <td class="numeric">4096</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for size of cookies set on mobile pages.") }}</figcaption>
</figure>
<!-- 
This section focuses on the actual size of these cookies. We find that the median size across all cookies observed on desktop during the HTTP Archive crawl of July 2025 is 37 bytes. This median value is consistent across first and third-party cookies as well as clients. The maximal size that we obtain is at about 4K bytes which is consistent with the limits defined in <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc6265#section-6.1">RFC 6265</a>. Note that because of the way the HTTP Archive tools work and collect the cookies, if websites try to set cookies larger than the limit of 4K bytes this information would be missing from the data analyzed in this chapter. -->

<!-- The smallest cookies that we observe are of a single byte in size, they are likely set by error by empty `Set-Cookie` headers. Additionally, we also report the cumulative distribution function (cdf) of the size of all the cookies seen on the top 1M websites for each client. -->
<!-- 
Most cookies used for tracking have a size greater than <a hreflang="en" href="https://link.springer.com/chapter/10.1007/978-3-319-15509-8_21">35 bytes</a>. The reason for this is that size is related to the tracking capability of cookies: trackers assign identifiers randomly to users in order to be able to re-identify them. So the larger the size (number of bytes) for the identifier, the more unique users they can be assigned to. -->

{{ figure_markup(
  image="size-cookies-cdf-desktop-mobile.png",
  caption="Size of cookies per website (cdf) for desktop and mobile pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on desktop and mobile pages. We see a very similar distribution for cookies sizes for both desktop and mobile clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1496593333&format=interactive",
  sheets_gid="1499552173",
  sql_file = 'size_cookies_cdf.sql'
  )
}}

## Persistence (expiration)


<figure>
  <table>
    <thead>
      <tr>
        <th>Age of cookies (desktop top 1M) in days </th>
        <th>First-party</th>
        <th>Third-party</th>
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">60</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">400</td>
        <td class="numeric">395</td>
        <td class="numeric">395</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">20464</td>
        <td class="numeric">20683</td>
        <td class="numeric">20677</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">20689</td>
        <td class="numeric">20689</td>
        <td class="numeric">20689</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on desktop pages.") }}</figcaption>
</figure>

<!-- max values above 400 days to investigate more? -->

<figure>
  <table>
    <thead>
      <tr>
        <th>Age of cookies (mobile top 1M) in days </th>
        <th>First-party</th>
        <th>Third-party</th>
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">365</td>
        <td class="numeric">364</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">395</td>
        <td class="numeric">365</td>
        <td class="numeric">390</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">400</td>
        <td class="numeric">20651</td>
        <td class="numeric">20382</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">20689</td>
        <td class="numeric">20689</td>
        <td class="numeric">20689</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on mobile pages.") }}</figcaption>
</figure>

<!-- After looking into cookie size, let's now dive into cookie age. Cookies are set to an expiration date when they are created. Recall that session cookies expire immediately after the session is over ([see previous section](#session)). The median age of first-party cookies is at about 183 days or roughly 6 months, while the median age of third-party cookies is a full year. After less than one day and thirty days, 25% of first-party and third-party cookies expire, respectively. The maximum age among the cookies that we can observe with the instrumentation and collection of the HTTP Archive Tools is of 400 days, this is aligned with the [hard limits](https://developer.chrome.com/blog/cookie-max-age-expires) that Chrome imposes on cookie `Expires` and `Max-Age` attribute. Below, are the cumulative distribution functions (cdf) of the age of the cookies set on the top 1M websites whether it is on a desktop or mobile client. -->

{{ figure_markup(
  image="age-cookies-cdf-desktop-mobile.png",
  caption="Age of cookies per website (cdf) for desktop and mobile pages.",
  description="The graph shows the cumulative distribution function for the age of cookies set on desktop and mobile pages. About 45% of cookies expire after 90 days. We find the same results for both mobile and desktop clients. Additionally, 50% of cookies have a lifespan of maximum just below 1 year, while the other half remain stored in the browser for longer than a year. We see a somewhat similar distribution for cookies sizes for both desktop and mobile clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1741245502&format=interactive",
  sheets_gid="718820729",
  sql_file="age_expires_cookies_cdf.sql"
  )
}}

<!-- From the graph, we deduce that about 45% of cookies expire after 90 days. We find the same results for both mobile and desktop clients. Additionally, 75% of cookies have a lifespan of maximum 1 year, while the other half remain stored in the browser for longer than a year. In theory, the longer the lifespan of the cookies, the longer that they can re-identify a recurring user. For this reason, most tracking cookies are typically stored in the browser for a longer time. -->


## Conclusion
{# TODO touch on privacy sandbox deprecation and SoK open problems #}

<!-- In this chapter, we report on the use of cookies on the web. Our analysis allows us to answer multiple questions:

**Which type of cookies is set by websites?**

We find that the majority of cookies on the web (61%) are third-party. Moreover, more popular websites set significantly more third-party cookies, presumably because they generally include more third-party content. Additionally, we observe that about 6% of third-party cookies are partitioned (CHIPS). Partitioned cookies cannot be used for third-party tracking given that the cookie jar is separate for each website (domain) that the user visits. However, we find that partitioned cookies are predominantly set by advertising domains and are used for analytics.

**Which cookie attributes are set?**

Out of all cookies set, 16% of first-party cookies and only 4% of third-party cookies are session cookies. The remainder of the cookies are more persistent since they are not deleted when the user closes the browser. Generally, the average lifetime of cookies (the median) is 6 months for first-party and 1 year for third-party cookies.

Furthermore, for 100% of third-party cookies the `SameSite` attribute is explicitly set to `None`, which allows these cookies to be included in cross-site requests and therefore to track users with them.

**Who sets cookies and what are they used for?**

The top first-party cookies are mainly used for analytics. Google Analytics, whose primary function is to report on the use of websites by users i.e, first-party analytics, is prevalent on at least 60% of websites. Meta follows its footsteps, by setting first-party cookies on 25% websites.

Third-party cookies also predominantly set by Google: `doubleclick.net` sets a cookie on 44% of websites. Other top trackers have a considerably smaller reach of 8-12% of websites. In general, the most popular third-party cookies belong predominantly to the targeted advertising category.

We conclude the chapter with an overview of the Privacy Sandbox, which aims to replace third-party cookies altogether, and refer to the [Privacy](./privacy) chapter for more results.
 -->
