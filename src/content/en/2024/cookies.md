---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookies
description: Cookies chapter of the 2024 Web Almanac covering the prevalence and structure of cookies on the web.
authors: [yohhaan,samdutton,ydimova]
reviewers: [samdutton,rowan-m]
analysts: [yohhaan]
editors: []
translators: []
discuss:
results: https://docs.google.com/spreadsheets/d/1wDGnUkO0rgcU5_V6hmUrhm1pq60VU2XbeMHgYJEEaSM/
yohhaan_bio: Yohan Beugin is a Ph.D. student in the Department of Computer Sciences at the University of Wisconsin–Madison where he is a member of the Security and Privacy Research Group and advised by Prof. Patrick McDaniel. He is interested in building more secure, privacy-preserving, and trustworthy systems. His current research so far has focused on tracking and privacy in online advertising.
samdutton_bio: Sam Dutton is a Developer Advocate with the Privacy Sandbox team at Google, focused on helping sites migrate away from relying on third-party cookies. Sam grew up in South Australia, went to university in Sydney, and has lived since 1986 in London. He previously worked as a software engineer at BBC R&D and ITN, as a typesetter for Decca Records, and as a researcher at Picador Books.
ydimova_bio: Yana Dimova is a PhD student at DistriNet, KU Leuven, focusing on the user's perspective of privacy and how they can protect it on the web. Her research interests are online tracking, personal data leaks and privacy and data protection law.
featured_quote: Our results indicate both first-party and third-party tracking are common. We show that online tracking by means of cookies is still predominant on the web.
featured_stat_1: 61%
featured_stat_label_1: Cookies are third-party
featured_stat_2: 10.78%
featured_stat_label_2: First-party desktop cookies have SameSite=None
featured_stat_3: 6%
featured_stat_label_3: Third-party cookies are partitioned (CHIPS)
---


## Introduction

The following chapter of the Web Almanac 2024 is focused on cookies. Cookies have multiple functionalities and are to some extent essential for the web e.g., for authentication, fraud prevention and security. However, some cookies can track users across websites and are utilized to build behavior profiles.
In this chapter, we measure the prevalence and structure of web cookies encountered while visiting mainly the top one million websites during the HTTP Archive crawl of June 2024.
Additionally, we discuss and measure the adoption of alternative mechanisms to third-party cookies that were introduced by Google on Chrome as part of the [Privacy Sandbox](https://privacysandbox.com/) initiative to reduce cross-site tracking.

We find that 61% of cookies are set in a third-party context. Generally, third-party cookies can be used for online tracking and targeted advertising. For this reason, Google proposed to phase out all third-party cookies and introduce more privacy-friendly options to replace their functionality with the Privacy Sandbox.
On the other hand, not all third-party cookies are used for online tracking. Browsers such as Chrome include a number of ways to limit the way that third-party cookies are used. For example, cookies that are partitioned (CHIPS) cannot be accessed across different top-level sites from the one the cookies are set on originally, which makes it impossible to track users across websites. Nonetheless, we find that the most prevalent partitioned cookies are set by domains related to advertising. Another example is the `SameSite` cookies attribute, which ensures that (first-party) cookies are not included in cross-site requests by default. Trackers can disable this setting by explicitly setting the value of the `SameSite` attribute to `None`. Therefore, in practice, we find that for 11% of observed first-party cookies, `SameSite` is set to `None`.  Additionally, we observe that the most widely set third-party cookies are used for advertising and analytics, with Google being prevalent on the largest percentage of websites.
First-party cookies can also be used to track recurring users. From our analysis, we conclude that the most prevalent first-party cookies are used for analytics. In theory, because of the same-origin policy, these cookies cannot be used for cross-site tracking. However, by using advanced tracking methods such as cookie syncing and CNAME tracking, trackers can bypass this limitation. We refer to the [privacy chapter](https://almanac.httparchive.org/en/2024/privacy) for more details on online tracking methods.

Our results indicate both first-party and third-party tracking are common. We show that online tracking by means of cookies is still predominant on the web.


## Definitions

### HTTP cookie

When a user visits a website, they interact with a web server that can request the user's web browser to set and save an [HTTP cookie](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies). This cookie corresponds to data saved in a text string on the user's device, and is sent with subsequent HTTP requests to the web server. Cookies are used to persist stateful information about users across multiple HTTP requests, which can allow authentication, session management, and tracking. Cookies are also associated with privacy and security risks.

### First and third-party cookies {#first-and-third-party-cookies}

Cookies are set by a web server and there are two types of cookies: **first-party** and **third-party** cookies. First-party cookies are set by the same domain as the site the user is visiting, while third-party cookies are set from a different domain.

Third-party cookies may be from a third party, or from a different site or service belonging to the same "first party" as the top-level site. **Third-party cookies** are really **cross-site cookies**.

**Example**: imagine that the owner of the domain "example.com" also owns "example.net" and that the following cookies are set for a user visiting "https://www.example.com":
<figure>
  <table>
    <thead>
      <tr>
        <th>Cookie Name </th>
        <th>Set by</th>
        <th>Type of cookie</th>
        <th>Reason</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`cookie_a`</td>
        <td>`www.example.com`</td>
        <td>First-party</td>
        <td>Same domain as visited website</td>
      </tr>
      <tr>
        <td>`cookie_b`</td>
        <td>`cart.example.com`</td>
        <td>First-party</td>
        <td>Same domain as visited website: subdomains do not matter</td>
      </tr>
      <tr>
        <td>`cookie_c`</td>
        <td>`www.example.edu`</td>
        <td>Third-party</td>
        <td>Different domain than visited website</td>
      </tr>
      <tr>
        <td>`cookie_d`</td>
        <td>`tracking.example.org`</td>
        <td>Third-party</td>
        <td>Different domain than visited website</td>
      </tr>
      <tr>
        <td>`cookie_e`</td>
        <td>`login.example.net`</td>
        <td>Third-party</td>
        <td>Different domain than visited website even if owned by the same owner in this example (cross-site cookie from the same "first party" at the top-level site)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Cookie Context") }}</figcaption>
</figure>


### Privacy & security risks
**Web tracking.** Cookies are used by third parties to track users across websites and record their browsing behavior and interests. In targeted advertising, this data is leveraged to show users advertisements aligned with their interest. This tracking usually takes place the following way; third-party code embedded on a site can set a cookie that identifies a user. Then, the same third-party can record user activity by obtaining that cookie back when the user visits other websites where it is embedded as well (see also the [privacy](https://almanac.httparchive.org/en/2024/privacy) chapter) We note that first-party cookies can also be used for online tracking, methods such as cookie syncing allow to bypass the limitation of third-party cookies and track users [across different websites](https://dl.acm.org/doi/abs/10.1145/3442381.3449837).

**Cookie theft and session hijacking.** Cookies are used to store session information such as credentials (session token) for authentication purposes across several HTTP requests. However, if these cookies were to be obtained by a malicious actor, they could use them to authenticate to the corresponding web servers. If cookies are not properly set by web servers, they could be prone to cross-site vulnerabilities such as [session hijacking](https://developer.mozilla.org/en-US/docs/Glossary/Session_Hijacking), cross-site request forgery ([CSRF](https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/CSRF_prevention)), cross-site script inclusion ([XSS](https://developer.mozilla.org/en-US/docs/Glossary/Cross-site_scripting)), and others (see also the [security](https://almanac.httparchive.org/en/2024/security) chapter).

### Caveats

You can learn more about the methodology applied by the HTTP Archive for the Web Almanac in 2024 on the [methodology page](https://almanac.httparchive.org/en/2024/methodology). There are limitations to that methodology which may impact the results in this chapter:
- Data is collected by automatically visiting websites in a non-interactive way; user interaction could modify the way websites set and use cookies in practice. For example, HTTP Archive's tools do not interact with cookie banners (if any) and so cookies that would be set after interaction with these banners are not observed by our study.
- Websites are visited from servers located in the US that have no cookie set when each independent website visit starts; this is quite different from a user accumulating and saving web cookies while browsing the web. The location from which visits are performed can impact cookie behavior due to regulation and legislation such as [GDPR](https://gdpr-info.eu/).
- For each website, the home page is visited as well as one other page from the same website.
- Most of the results presented in this chapter are based on the top one million (top 1M by CrUX rank) most visited websites that were successfully reached during the HTTP Archive crawl of June 2024.
- The cookies collected for the analysis in this chapter were obtained at the end of the visit of each website page by extracting all cookies stored by the web browser in its cookie jar. As a result, the collected data only contains cookies that are deemed valid by the web browser and successfully set. Thus, if websites attempt to set invalid cookies (too large, attributes mismatch, etc.) they would be missing from our analysis.


### Notes

The figures plotted in this chapter indicate in their subtitle (a) the type of client device (**desktop** or **mobile**) that was used to access the websites for the plotted data and (b) the top number of websites visited (according to their [CrUX rank](https://developer.chrome.com/blog/crux-rank-magnitude)). If the information is not specified, it must be on one of the axes of the graph.

## Prevalence and structure of cookies

In this section, we report on the prevalence of cookies, their type, and their attributes on the web.

### First and third-party prevalence

First-party cookies are set by the same domain as the website that the user is visiting, while third-party cookies are set by a different domain [see Definitions](#definitions). In this analysis, we examine the percentage of cookies set on websites that are first- and third-party across clients (desktop or mobile) and CrUX ranks.


{{ figure_markup(
  image="first-and-third-party-prevalence.png",
  caption="First- and third-party prevalence",
  description="Bar chart showing the prevalence of first- and third-party cookies on desktop and mobile clients. For both clients, we see the same distribution on the top 1M websites: 39% of cookies are first-party and 61% of cookies set are third-party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=627993125&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

On the top one million (top 1M) most visited websites, about 39% of the cookies are first-party and 61% are third-party cookies. Thus, a majority of the cookies set on the Web are third-party cookies. We also observe that this distribution is very similar whether these websites are accessed through a desktop or a mobile client. This indicates that overall there is little to no behavior change based on the type of client used. However, some websites may still behave differently and/or use other tracking methods such as fingerprinting depending on the type of client (see the [privacy chapter](https://almanac.httparchive.org/en/2024/privacy) for more).

{{ figure_markup(
  image="first-and-third-party-prevalence-by-rank-desktop.png",
  caption="First- and third-party prevalence of cookies by rank on desktop clients",
  description="Bar chart showing the prevalence of first- and third-party cookies on desktop clients according to the popularity of the website (we used Chrome User Experience report to determine the popularity of websites). We see that more popular websites set significantly more third-party cookies. For the top 1k most popular websites on desktop clients, 77% of cookies set are third-party, while for the top 1M websites, 61% of cookies are third-party. One explanation for this difference is that more popular websites tend to include more third-party content that sets cookies.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1327011561&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

{{ figure_markup(
  image="first-and-third-party-prevalence.png-by-rank-mobile.png",
  caption="First- and third-party prevalence of cookies by rank on mobile clients",
  description="Bar chart showing the prevalence of first- and third-party cookies on mobile clients according to the popularity of the website (we used Chrome User Experience report to determine the popularity of websites). We see that more popular websites set significantly more third-party cookies. For the top 1k most popular websites on desktop clients, 77% of cookies set are third-party, while for the top 1M websites, 61% of cookies are third-party. One explanation for this difference is that more popular websites tend to include more third-party content that sets cookies. We see the same results for both mobile and desktop clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1792338085&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

Looking at the prevalence of the type of cookies across website rankings, we observe that more popular websites have a higher proportion of third-party cookies than the ones visited less often. For instance, in comparison to the results reported on the top 1M websites, 23% and 77% of the cookies are first and third-party on the top one thousand (top 1k) websites, respectively. This is likely due to the fact that websites that are the most visited by users embed more third-party code (that in turn sets more third-party cookies) than less visited ones.
Additionally, the prevalence of each cookie type across the ranks is quite similar between desktop and mobile clients; we observe that previous remarks made on the top 1M websites also hold across CrUX ranks.

### Cookie attributes

Next, we discuss the distribution of different cookie [attributes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie). Furthermore, we zoom into the use of the `SameSite` cookie attribute. The following two figures show the proportion of first and third-party cookies set on the top 1M websites for each client that have one of the following attributes set: `Partitioned`, `Session`, `HttpOnly`, `Secure`, `SameSite`. Before diving into more details for each attribute, let's observe here again the similarity of the distribution of the different attributes between desktop or mobile clients.

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  description="This figures gives an overview of how cookie attributes are used for desktop clients for both first- and third-party cookies. 100% of third-party cookies include the `SameSite` and `Secure` attributes. Only 1% of first-party cookies and 6% of third-party cookies use `Partioned`. 16% of first-party cookies set their `Session` attribute, while this is the case for only 4% of third-party cookies. Finally, 12% of first-party cookies and 19% of third-party cookies use the `HttpOnly` attribute.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=69067153&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}
{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="An overview of cookie attributes for mobile clients",
  description="This figures gives an overview of how cookie attributes are used for mobile clients for both first- and third-party cookies. We observe the exact same results as for desktop clients. 100% of third-party cookies include the `SameSite` and `Secure` attributes. Only 1% of first-party cookies and 6% of third-party cookies use `Partioned`. 16% of first-party cookies set their `Session` attribute, while this is the case for only 4% of third-party cookies. Finally, 12% of first-party cookies and 19% of third-party cookies use the `HttpOnly` attribute.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2109248653&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}


#### Partitioned {#partitioned}

Partitioned cookies are stored by [compatible browsers](https://developer.mozilla.org/en-US/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility) using partitioned storage. Cookies that have the `Partitioned` attribute set can only be accessed by the same third party and from the same top-level site where they were created in the first place. In other words, partitioned cookies can not be used for third-party tracking across websites and allow for the legitimate use of third-party cookies on a top-level site. For more details see: [Cookies Having Independent Partitioned State (CHIPS)](https://developer.mozilla.org/en-US/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies).

We observe that about 6% of third-party cookies set on desktop or mobile while visiting the top 1M websites are partitioned. The next figure shows the most common partitioned cookies (name and domain) that are set in third-party context on the top 1M websites. For each client (desktop and mobile) only the top ten partitioned cookies in percentage of websites they are seen on are reported.
The top 2 most widely-used partitioned cookies are set by `youtube.com` on 9.88% on desktop and 8.89% mobile websites. The `YSC` cookie is used for security purposes i.e., to prevent fraud and abuse, and expires at the end of the user session, while `VISITOR_INFO1_LIV`'s main purpose is analytics (see [Google's documentation](https://policies.google.com/technologies/cookies/embedded?hl=en-US)).
Most of the cookies listed in the graph are set by advertising domains e.g., `adnxs.com`, `criteo.com`, and `doubleclick.net`.


{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="Top partitioned cookies (CHIPS) in third-party context",
  description="A chart showing the top third-party domains setting partitioned cookies. The top two partitioned cookies set are Google-owned. `YSC` and `VISITOR_INFO1_LIVE` are set by `youtube.com` on 9.88% of desktop websites and 8.89% of mobile websites. Most of the top domains using CHIPS belong to the advertising or analytics category.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1075137054&format=interactive",
  sheets_gid="1597405066",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}


Perhaps a bit surprising, 1% of all the first-party cookies that are set on the top 1M websites (desktop and mobile client) are partitioned. However, partitioning cookies in a first-party context appears to be a bit redundant as first-party cookies are already accessible, by definition, only by that first-party on that top-level site. The following figure displays the top ten partitioned cookies set in first-party context for each client. `receive-cookie-deprecation` is set by domains that [participate in the testing phase](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing) of Chrome's Privacy Sandbox. `cf_clearance` and `csrf_token` are cookies set by Cloudflare to indicate that the user has successfully completed an anti-bot challenge or to identify trusted web traffic, respectively.

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="Top partitioned cookies (CHIPS) in first-party context",
  description="A chart showing the top first-party partitioned cookies. The top cookie `receive-cookie-deprecation` is part of the Privacy Sandbox's testing phase. The second most widely set first-party partitioned cookie is set by Cloudflare on 4.21% of desktop sites and 4.13% of mobile pages, and indicates that the user has successfully completed bot detection.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1330654598&format=interactive",
  sheets_gid="1597405066",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}


#### Session
Session cookies are cookies that are only valid for a single user session. In other words, session cookies are temporary and expire once the user quits the corresponding website they were set on, or closes their web browser, whichever happens first. However, note that some web browsers allow users to restore a previous session on startup, in that case the session cookies set in that previous session are also restored.

The results from our analysis on the top 1M websites in June 2024 show that 16% of first-party cookies and only 4% of third-party cookies are session cookies (on both desktop and mobile clients).

#### HttpOnly {#httponly}

The [`HttpOnly`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#httponly) attribute prevents cookies from being accessed by javascript code, this provides some mitigation against [cross-site scripting (XSS)](https://developer.mozilla.org/en-US/docs/Glossary/Cross-site_scripting) attacks. Note that setting the `HttpOnly` attribute does not prevent cookies from being sent along `XMLHttpRequest` or `fetch` requests initiated from javascript.

Only 12% of first-party cookies have the `HttpOnly` attribute set, while for third-party cookies 19% on desktop and 18% on mobile do.


#### Secure

Cookies with the [`Secure`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#secure) attribute are only sent to requests made through HTTPs. This prevents [man-in-the-middle](https://developer.mozilla.org/en-US/docs/Glossary/MitM) attacks.

For first-party cookies, 23% on desktop and 22% on mobile have the `Secure` attribute and all third-party cookies observed have the `Secure` attribute. Indeed, these third-party cookies also have the `SameSite=None` attribute that requires `Secure` to be set (see the next section).


#### SameSite {#samesite}

The [`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) cookie attribute allows sites to specify when cookies are included with cross-site requests:
- `SameSite=Strict`: a cookie is only sent in response to a request from the same site as the cookie's origin.
- `SameSite=Lax`: same as `SameSite=Strict` except that the browser also sends the cookie on navigation to the cookie's origin site. This is the default value of `SameSite`.
- `SameSite=None`: cookies are sent on same-site or cross-site requests.
This means that in order to make third-party tracking with cookies possible, the tracking cookies must have their `SameSite` attribute set to `None`.

To learn more about the `SameSite` attribute, see the following references:
- [`SameSite` cookies explained](https://web.dev/articles/samesite-cookies-explained)
- ["Same-site" and "same-origin"](https://web.dev/articles/same-site-same-origin)
- [What are the parts of a URL?](https://web.dev/articles/url-parts)

{{ figure_markup(
  image="same-site-desktop.png",
  caption="`SameSite` attribute for cookies on desktop client",
  description="Shows the prevalence of the `SameSite` attribute and its value for both first-party and third-party cookies on desktop clients. 2.16% of first-party cookies set the `SameSite` attribute to `Strict`, 20.17% use `SameSite=Lax` (which is the default), 10.78% set the value to `None` and 66.89% do not specify the value of `SameSite`. Nearly 100% of third-party cookies set the `SameSite` attribute to `None`, in order for these cookies to be sent in a cross-site context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=797398172&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}
{{ figure_markup(
  image="same-site-mobile.png",
  caption="`SameSite` attribute for cookies on mobile client",
  description="Shows the prevalence of the `SameSite` attribute and its value for both first-party and third-party cookies on mobile clients. We see very similar results as for desktop clients. 2.21% of first-party cookies set the `SameSite` attribute to `Strict`, 20% use `SameSite=Lax` (which is the default), 10.63% set the value to None and 67.16% do not specify the value of `SameSite`. Nearly 100% of third-party cookies set the `SameSite` attribute to `None`, in order for these cookies to be sent in a cross-site context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2030447900&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

We observe that for each client about 33% of the first-party cookies and nearly 100% third-party cookies seen on the top 1M websites have a `SameSite` attribute that is explicitly set when they are created (reminder: `SameSite` defaults to `Lax` if not specified). The two bar charts above represent the distribution of this `SameSite` attribute for first and third-party cookies across clients. We observe that the differences in results across clients is here again somewhat negligible. Nearly 100% of third-party cookies have `SameSite=None`, and so are sent on cross-site requests.
For first-party cookies, about 87% of them have the `SameSite=Lax` (20% explicitly set the attribute, and the remaining 67% are concerned by the default behavior when `SameSite` is not set). 11% of cookies have their `SameSite` attributes explicitly set to have the value `None`. It's hard to determine the exact purpose for which cookies are set, but it is likely that a fraction of these cookies are used to track users in a first-party context. Only 2% of cookies have `SameSite` set to `Strict`.


### Cookie prefixes

Two [cookie prefixes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#cookie_prefixes) "__Host-" and "__Secure-" can be used in the cookie name to indicate that they can only be set or modified by a secure HTTPS origin. This is to defend against [session fixation](https://developer.mozilla.org/en-US/docs/Web/Security/Types_of_attacks#session_fixation) attacks. Cookies with both prefixes must be set by a secure HTTPs origin and have the "Secure" attribute set. Additionally, "__Host-" cookies must not contain a "Domain" attribute and have their "Path" set to "/", thus "__Host-" cookies are only sent back to the exact host they were set on, and so not to any parent domain.

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="Cookie prefixes observed on desktop pages",
  description="Shows the observed cookies prefixes used on desktop pages. We see that 0.032% of first-party cookies and only 0.001% of third-party cookies include '__Host-'. Similarly, 0.03% of first-party cookies and 0.001% of third-party cookies include '__Secure-'. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1811649614&format=interactive",
  sheets_gid="1700493344",
  sql_file = 'prevalence_attributes_per_type.sql'
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="Cookie prefixes observed on mobile pages",
  description="Shows the observed cookies prefixes used on mobile pages. We observe very similar results to the cookies prefixes used on desktop pages. We see that 0.031% of first-party cookies and only 0.001% of third-party cookies include '__Host-'. Similarly, 0.03% of first-party cookies and 0.001% of third-party cookies include '__Secure-'. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1019127638&format=interactive",
  sheets_gid="1700493344",
  sql_file = 'prevalence_attributes_per_type.sql'
  )
}}

We measure that 0.032% and 0.030% of the first-party cookies observed on desktop have the "__Host-" and "__Secure-" prefix set, respectively. These numbers are 0.001% for third-party cookies. These results show the very low adoption of these prefixes and the associated defense-in-depth measure since they were first [introduced](https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis#section-4.1.3.1) at the end of 2015.

## Top first and third-party cookies and domains setting them

In the following section, we report for each client (desktop and mobile) the top ten first-party cookies, third-party cookies, as well as domains that set them. We comment on a few of them using results from [Cookiepedia](https://cookiepedia.co.uk/) and invite curious readers to refer to this resource for more.


{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="Top first-party cookies set",
  description="The chart shows the most widely-set first-party cookies. Google analytics sets the `_ga` and `_gid` cookies, which are used for website statistics and analytics reports, on more than 61% of websites fot both mobile and desktop clients." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=380182537&format=interactive",
  sheets_gid="1236728722",
  sql_file = 'top_20_first_party_cookies.sql'
  )
}}

The first two first-party cookies "_ga" and "_gid" are set by [Google Analytics](https://business.safety.google/adscookies/) to store client identifiers and statistics for site analytics reports, a majority of websites use Google Analytics (more than 60% and 35%, respectively).
The third one "_fbp" is set by Facebook and used for targeted advertising on 25% of the websites.


{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="Top third-party cookies and domains that set them",
  description="The chart shows the most widely-set third-party cookies. Doubliclick sets third-party advertising cookies on 28.9% websites and 26.7% of mobile websites. Microsoft also sets advertising cookies on 12.4% of desktop and 11.3% of mobile pages. Most of the top domains setting third-party cookies are related to tracking and advertising." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1907061819&format=interactive",
  sheets_gid="1236728722",
  sql_file = 'top_20_third_party_cookies.sql'
  )
}}

The "IDE" and "test_cookie" cookies are set by doubleclick.net (owned by Google) and are the most common third-party cookies observed on the top 1M websites; they are used for targeted advertising. DoubleClick checks if a user's web browser supports third-party cookies by trying to set "test_cookie". "MUID" from Microsoft comes next and is also used in targeted advertising to store the user's unique identifier for cross-site tracking.

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Top registrable domains setting cookies.",
  description="The chart shows the most common domains that set cookies on the web. Google's owned advertising platform DoubleClick sets cookies on more than 44% of the top 1M websites while others are at about 8% to 12%." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1700710012&format=interactive",
  sheets_gid="1236728722",
  sql_file = 'top_20_domains_setting_cookies.sql'
  )
}}

Among the ten most common domains that set cookies on the web, we only find domains involved in search, targeting, and advertising services. This result outlines the coverage that some third-parties have of the web, for example: Google's owned advertising platform DoubleClick sets cookies on more than 44% of the top 1M websites while others are at about 8% to 12%.

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
        <td class="numeric">5</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">13</td>
        <td class="numeric">17</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">22</td>
        <td class="numeric">66</td>
        <td class="numeric">51</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">46</td>
        <td class="numeric">331</td>
        <td class="numeric">323</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">160</td>
        <td class="numeric">632</td>
        <td class="numeric">662</td>
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
        <td class="numeric">7</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">12</td>
        <td class="numeric">18</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">21</td>
        <td class="numeric">64</td>
        <td class="numeric">52</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">45</td>
        <td class="numeric">327</td>
        <td class="numeric">316</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">168</td>
        <td class="numeric">604</td>
        <td class="numeric">645</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for number of cookies set on mobile pages.") }}</figcaption>
</figure>




Websites set a median of nine or ten cookies of any type overall, seven first-party cookies, and four or five third-party cookies for mobile and desktop clients, respectively. The tables above report several other statistics about the number of cookies observed per website and the figures below display their cumulative distribution functions (cdf). For example: on desktop a maximum of 160 first-party and 632 third-party cookies are set per website.

{{ figure_markup(
  image="number-cookies-cdf-desktop.png",
  caption="Number of cookies per website (cdf) for desktop pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on desktop pages. We see that more websites have a number of first-party cookies that is closer to the maximum of first-party cookies observed, than for third-party cookies." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=250423340&format=interactive",
  sheets_gid="1448286433",
  sql_file = 'nb_cookies_cdf.sql'
  )
}}

{{ figure_markup(
  image="number-cookies-cdf-mobile.png",
  caption="Number of cookies per website (cdf) for mobile pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on mobile pages. We see that more websites have a number of first-party cookies that is closer to the maximum of first-party cookies observed, than for third-party cookies. Additionally, we observe very simililar results for both desktop and mobile websites." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2118660652&format=interactive",
  sheets_gid="1448286433",
  sql_file = 'nb_cookies_cdf.sql'
  )
}}


We see that more websites have a number of first-party cookies that is closer to the maximum of first-party cookies observed, than for third-party cookies.


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
        <td class="numeric">26</td>
        <td class="numeric">22</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">39</td>
        <td class="numeric">36</td>
        <td class="numeric">37</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">59</td>
        <td class="numeric">58</td>
        <td class="numeric">58</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">148</td>
        <td class="numeric">114</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">380</td>
        <td class="numeric">274</td>
        <td class="numeric">348</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4087</td>
        <td class="numeric">4094</td>
        <td class="numeric">4094</td>
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
        <td class="numeric">26</td>
        <td class="numeric">22</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">39</td>
        <td class="numeric">37</td>
        <td class="numeric">38</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">59</td>
        <td class="numeric">59</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">149</td>
        <td class="numeric">114</td>
        <td class="numeric">130</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">382</td>
        <td class="numeric">278</td>
        <td class="numeric">352</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4086</td>
        <td class="numeric">4093</td>
        <td class="numeric">4093</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for size of cookies set on mobile pages.") }}</figcaption>
</figure>

This section focuses on the actual size of these cookies. We find that the median size across all cookies observed on desktop during the HTTP Archive crawl of June 2024 is 37 bytes. This median value is consistent across first and third-party cookies as well as clients. The maximal size that we obtain is at about 4K bytes which is consistent with the limits defined in [RFC 6265](https://datatracker.ietf.org/doc/html/rfc6265#section-6.1). Note that because of the way the HTTP Archive tools work and collect the cookies, if websites try to set cookies larger than the limit of 4K bytes this information would be missing from the data analyzed in this chapter.
The smallest cookies that we observe are of a single byte in size, they are likely set by error by empty "Set-Cookie" headers. Additionally, we also report the cumulative distribution function (cdf) of the size of all the cookies seen on the top 1M websites for each client.
Most cookies used for tracking have a size greater than [35 bytes](https://link.springer.com/chapter/10.1007/978-3-319-15509-8_21). The reason for this is that size is related to the tracking capability of cookies: trackers assign identifiers randomly to users in order to be able to re-identify them. So the larger the size (number of bytes) for the identifier, the more unique users they can be assigned to.


{{ figure_markup(
  image="size-cookies-cdf-desktop.png",
  caption="Size of cookies per website (cdf) for desktop pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on desktop pages. We see a very similar distribution for cookies sizes for both desktop and mobile clients." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=164030978&format=interactive",
  sheets_gid="1882828646",
  sql_file = 'size_cookies_cdf.sql'
  )
}}

{{ figure_markup(
  image="size-cookies-cdf-mobile.png",
  caption="Size of cookies per website (cdf) for mobile pages.",
  description="The graph shows the cumulative distribution function for the number of cookies set on mobile pages. We see a very similar distribution for cookies sizes for both desktop and mobile clients." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=771938257&format=interactive",
  sheets_gid="1882828646",
  sql_file = 'size_cookies_cdf.sql'
  )
}}


## Persistence (expiration)
<figure>
  <table>
    <thead>
      <tr>
        <th>Age of cookies (desktop top 1M) in bytes </th>
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
        <td class="numeric">183</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">396</td>
        <td class="numeric">365</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on desktop pages.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Age of cookies (desktop top 1M) in bytes </th>
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
        <td class="numeric">183</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">396</td>
        <td class="numeric">365</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr><figure>
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on desktop pages.") }}</figcaption>
</figure>
      <tr>
        <td>max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on mobile pages.") }}</figcaption>
</figure>

After looking into cookie size, let's now dive into cookie age. Cookies are set to an expiration date when they are created. Recall that session cookies expire immediately after the session is over ([see above](#first-and-third-party-cookies-first-and-third-party-cookies)). The median age of first-party cookies is at about 183 days or roughly 6 months, while the median age of third-party cookies is a full year. After less than one day and thirty days, 25% of first-party and third-party cookies expire, respectively. The maximum age among the cookies that we can observe with the instrumentation and collection of the HTTP Archive Tools is of 400 days, this is aligned with the [hard limits](https://developer.chrome.com/blog/cookie-max-age-expires) that Chrome imposes on cookie "Expires" and "Max-Age" attribute. Below, are the cumulative distribution functions (cdf) of the age of the cookies set on the top 1M websites whether it is on a desktop or mobile client.

{{ figure_markup(
  image="age-cookies-cdf-desktop.png",
  caption="Age of cookies per website (cdf) for desktop pages.",
  description="The graph shows the cumulative distribution function for the age of cookies set on desktop pages. About 45% of cookies expire after 90 days. We find the same results for both mobile and desktop clients. Additionally, 75% of cookies have a lifespan of maximum 1 year, while the other half remain stored in the browser for longer than a year. We see a very similar distribution for cookies sizes for both desktop and mobile clients." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1838066617&format=interactive",
  sheets_gid="135614941",
  sql_file = 'age_expires_cookies_cdf.sql'
  )
}}

{{ figure_markup(
  image="age-cookies-cdf-mobile.png",
  caption="Age of cookies per website (cdf) for mobile pages.",
  description="The graph shows the cumulative distribution function for the age of cookies set on mobile pages. About 45% of cookies expire after 90 days. We find the same results for both mobile and desktop clients. Additionally, 75% of cookies have a lifespan of maximum 1 year, while the other half remain stored in the browser for longer than a year. We see a very similar distribution for cookies sizes for both desktop and mobile clients." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=702122056&format=interactive",
  sheets_gid="135614941",
  sql_file = 'age_expires_cookies_cdf.sql'
  )
}}

From the graph, we deduce that about 45 % of cookies expire after 90 days. We find the same results for both mobile and desktop clients. Additionally, 75% of cookies have a lifespan of maximum 1 year, while the other half remain stored in the browser for longer than a year. In theory, the longer the lifespan of the cookies, the longer that they can re-identify a recurring user. For this reason, most tracking cookies are typically stored in the browser for a longer time.

## Privacy Sandbox initiative

### What is the Privacy Sandbox initiative?

In [2019](https://blog.google/products/chrome/building-a-more-private-web/), Google announced the launch of the [Privacy Sandbox](https://developers.google.com/privacy-sandbox) initiative to reduce cross-site (Web) and cross-app (Android) tracking while retaining utility for advertising and other use cases that historically have relied on third-party cookies and other tracking mechanisms . The Privacy Sandbox is composed of more than [20 different proposals](https://privacysandbox.com) that aim to diminish the use of unique identifiers, limiting covert tracking, fighting spam and fraud, showing relevant ads to users, and measuring ad conversions.

Part of Google's initial plan with the Privacy Sandbox was to deprecate third-party cookies, but in [recent updates](https://privacysandbox.com/news/privacy-sandbox-update) Google announced that this was not their intention anymore and that they would rather introduce a "new experience in Chrome that lets people make an informed choice that applies across their web browsing". At the same time, Google will "continue to make the Privacy Sandbox APIs available and invest in them to further improve privacy and utility".

We partnered with the [Privacy chapter](https://almanac.httparchive.org/en/2024/privacy) of the Web Almanac 2024 to measure adoption of the Privacy Sandbox APIs on the websites visited by the HTTP Archive crawl and will defer interested readers to their chapter for the analysis of the results. Next, we present an overview of the proposed mechanisms that are part of the Privacy Sandbox and aim at replacing a capability provided by cookies so far.

### Topics API

The [Topics AP I](https://developers.google.com/privacy-sandbox/private-advertising/topics/web) enables interest-based advertising, without using third-party cookies. The API allows callers (such as ad tech platforms) to access topics of interest that they have observed for a user, but without revealing additional information about the user's activity.


See the [Privacy chapter](https://almanac.httparchive.org/en/2024/privacy) for some results about the adoption of the Topics API.

### Protected Audience

The [Protected Audience API](https://developers.google.com/privacy-sandbox/private-advertising/protected-audience) enables on-device ad auctions to serve remarketing and custom audiences, without cross-site third-party tracking. Advertisers can add users to interest groups that are saved by the browser while users are navigating on the web. This allows advertisers to perform retargeted advertising by bidding on the available interest groups the user is part of when they visit a website where an ad auction is performed.

See the [Privacy chapter](https://almanac.httparchive.org/en/2024/privacy) for some results about the adoption of the Protected Audience API.

### Attribution Reporting API

The [Attribution Reporting API](https://developers.google.com/privacy-sandbox/private-advertising/attribution-reporting) allows websites and third parties to measure ad conversion, i.e., when a view or a click on an advertisement leads later for example to a purchase. The Attribution Reporting API aims to enable measurement of ad conversion but without the use of cross-site identifiers and cookies.

See the [Privacy chapter](https://almanac.httparchive.org/en/2024/privacy) for some results about the adoption of the Attribution Reporting  API.

### CHIPS

[Cookies Having Independent Partitioned State (CHIPS)
](https://developers.google.com/privacy-sandbox/cookies/chips) allow web developers to specify that they would like the cookies that they are setting to be saved in a partitioned storage, i.e., in a separate cookie jar per top-level site. CHIPS cookies correspond to the partitioned cookies discussed previously in this chapter, in the [partitioned](#partitioned) section.

### Related Website Sets

[Related Website Sets](https://developers.google.com/privacy-sandbox/cookies/related-website-sets) allow websites from the same owner to share cookies among themselves.The creation and submission of a Related Website Set is done at the moment through opening a pull request on a [GitHub repository](https://github.com/GoogleChrome/related-website-sets) that Google employees check and merge if deemed valid. Websites that belong to the same related website set must also indicate it by placing a corresponding file at the [.well-known URI](https://www.iana.org/assignments/well-known-uris/well-known-uris.xhtml) "/.well-known/related-website-set.json".

{{ figure_markup(
  caption="Number of related primary website sets.",
  content= "64 related primary website sets validated by Google at the moment",
  classes="really-big-number",
  sheets_gid="199073475"
)
}}

Chrome ships with a pre-loaded file containing related website sets validated by the Chrome team; at the moment of writing (version "2024.8.10.0"), there are 64 distinct related website sets. Each related website set contains a primary domain and a list of other domains related to the primary one below one of the following attributes: "associatedSites", "servicesSites", and/or "ccTLDs". These 64 primary domains are each associated with secondary domains as part of their set: 60 sets contain "associatedSites", 11 "servicesSites", and 7 "ccTLDs". We report on the following figure the number of secondary domains for each set. We observe that if a majority of the primary domains are associated with 5 or less secondary domains, "https://journaldesfemmes.com", "https://ya.ru", and "https://mercadolibre.com" are linked to 8, 17, and 39 secondary domains among which third party requests are handled as if they were all from the first party, respectively.


{{ figure_markup(
  image="secondary-domains.png",
  caption="Secondary domains per primary domain.",
  description="The graph shows secondary domains associated to primary domains for Related Website Sets, which is part of Google's Privacy Sandbox. We observe that if a majority of the primary domains are associated with 5 or less secondary domains, `https://journaldesfemmes.com`, `https://ya.ru`, and `https://mercadolibre.com` are linked to 8, 17, and 39 secondary domains among which third party requests are handled as if they were all from the first party, respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=627102878&format=interactive",
  sheets_gid="199073475"
  )
}}


### Attestation file

In order to use some of the Privacy Sandbox APIs, API callers have to go through an [enrollment](https://developers.google.com/privacy-sandbox/private-advertising/enrollment) process to declare that they will not abuse these APIs for cross-site re-identification, but only for their intended use cases. The legal implications of this commitment if not respected is quite unclear, but this allows these callers to obtain an attestation file that must be placed at the .well-known URI "/.well-know/privacy-sandbox-attestations.json" on the domain they registered to call these APIs from.

Chrome ships with a pre-loaded file containing a list of domains that have an attestation file registered. Currently, this list contains 257 distinct domains (version "2024.10.7.0") that have enrolled to call the following APIs: Attribution Reporting, Protected App Signals (Android only), Private Aggregation (Chrome only), Protected Audience (FLEDGE), Shared Storage (Chrome only), and Topics.
We used a [custom crawler](https://github.com/privacysandstorm/well-known-crawler) separate from the HTTP Archive tools to obtain and parse these attestation files. We successfully retrieved attestation files for 232 distinct domains with that crawler (some attestation files may be available but not obtained by this crawler due to networking issues for example). We report next the proportion of domains that are enrolled for each API on Chrome and Android. We observe that the majority of these origins are enrolled to call one of the five Chrome APIs requiring an attestation while the proportion is way less for the Android APIs.


{{ figure_markup(
  image="attestation-files.png",
  caption="Enrollment from Privacy Sandbox APIs attestation files.",
  description="257 domains have already enrolled for Google's Privacy Sandbox and are part of the attestation file. The graph shows the  proportion of domains that are enrolled for each API on Chrome and Android. We observe that the majority of these origins are enrolled to call one of the five Chrome APIs requiring an attestation while the proportion is way less for the Android APIs." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1937515788&format=interactive",
  sheets_gid="2119972682"  )
}}

## Conclusion

In this chapter, we report on the use of cookies on the web. Our analysis allows us to answer multiple questions:

**Which type of cookies is set by websites?**
We find that the majority of cookies on the web (61%) are third-party. Moreover, more popular websites set significantly more third-party cookies, presumably because they generally include more third-party content. Additionally, we observe that about 6% of third-party cookies are partitioned (CHIPS). Partitioned cookies cannot be used for third-party tracking given that the cookie jar is separate for each website (domain) that the user visits. However, we find that partitioned cookies are predominantly set by advertising domains and are used for analytics.

**Which cookie attributes are set?**
Out of all cookies set, 16% of first-party cookies and only 4% of third-party cookies are session cookies. The remainder of the cookies are more persistent since they are not deleted when the user closes the browser. Generally, the average lifetime of cookies (the median) is 6 months for first-party and 1 year for third-party cookies.
Furthermore, for 100% of third-party cookies the `SameSite` attribute is explicitly set to `None`, which allows these cookies to be included in cross-site requests and therefore to track users with them.

**Who sets cookies and what are they used for?**
The top first-party cookies are mainly used for analytics. Google Analytics, whose primary function is to report on the use of websites by users i.e, first-party analytics, is prevalent on at least 60% of websites. Meta follows its footsteps, by setting first-party cookies on 25% websites.
Third-party cookies also predominantly set by Google: doubleclick.net sets a cookie on 44% of websites. Other top trackers have a considerably smaller reach of 8-12% of websites. In general, the most popular third-party cookies belong predominantly to the targeted advertising category.

We conclude the chapter with an overview of the Privacy Sandbox, which aims to replace third-party cookies altogether, and refer to the [Privacy chapter](https://almanac.httparchive.org/en/2024/privacy) for more results.
