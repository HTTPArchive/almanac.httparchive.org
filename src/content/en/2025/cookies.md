---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookies
description: Cookies chapter of the 2025 Web Almanac covering the prevalence and structure of cookies on the web.
hero_alt: Hero image of Web Almanac characters carrying a large cookie, while crumbs are thrown off by another character. Another Web Almanac character is following the trail of cookies with a detective hat and a magnifying glass.
authors: [yohhaan]
reviewers: [JannisBush,martinakraus]
analysts: [ChrisBeeti]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1ZirsnaXgbOMzBmt0X2eMMu3rVJvWCtQgE7pNG7fKcvc/edit
yohhaan_bio: Yohan Beugin is a Ph.D. student in the Department of Computer Sciences at the University of Wisconsin–Madison where he is a member of the Security and Privacy Research Group and advised by Prof. Patrick McDaniel. He is interested in building more secure, privacy-preserving, and trustworthy systems. His current research so far has focused on tracking and privacy in online advertising as well as security of open-source software.
featured_quote: Overall, cookies remain a fundamental component of the web that continue to pose privacy and security risks for users. Both first- and third-party cookies are used for tracking, and while several web browsers (Brave, Safari, Firefox, etc.) have deprecated or limited third-party cookies, Google decided in 2025 to still support them in Chrome and deprecate most of their Privacy Sandbox proposals.
featured_stat_1: 60%
featured_stat_label_1: Cookies that are third-party
featured_stat_2: 11%
featured_stat_label_2: First-party desktop cookies having `SameSite=None`
featured_stat_3: 10%
featured_stat_label_3: Third-party cookies that are partitioned (CHIPS)
---

## Introduction

[Cookies](https://developer.mozilla.org/docs/Web/HTTP/Cookies) allow websites to save data and maintain state information across HTTP requests, a stateless protocol. Web applications use cookies for several purposes, like authentication, fraud prevention and security, or remembering preferences and user choices. However, ever since their introduction in the mid-1990s, cookies have also played a dominant role in online tracking of web users.

Over the years, browser vendors such as Brave, Firefox, and Safari have imposed [restrictions, partitioned, and removed third-party cookies](https://developer.mozilla.org/docs/Web/Privacy/Guides/Third-party_cookies#how_do_browsers_handle_third-party_cookies). While Chrome initially appeared to follow in these same steps by announcing <a hreflang="en" href="https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html">plans to block all third-party cookies</a>, several delays and postponements later, Google eventually decided to <a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">keep third-party cookies unrestricted and let users decide to disable them in Chrome</a>.

In this chapter, we measure and report on the prevalence and structure of web cookies encountered on the web pages visited by the HTTP Archive crawl of July 2025. The majority of these results, except when mentioned otherwise, are for the top one million (top million) most popular websites according to their rank in the Chrome User Experience report (CrUX) rank recorded in the HTTP Archive dataset at the time of the crawl. Results are also shown for both desktop and mobile devices although, in practice for this chapter we rarely observe any significant difference between the two types of devices.

## Background

First up let's get a common understanding of some of the terms used in this chapter.

### HTTP cookie

When a user visits a website, they interact with a web server that can request the user's web browser to set and save an [HTTP cookie](https://developer.mozilla.org/docs/Web/HTTP/Cookies). This cookie corresponds to data saved in a text string on the user's device and is sent with subsequent HTTP requests to the web server. Cookies are used to persist stateful information about users across multiple HTTP requests—which can allow authentication, session management, and tracking. Cookies are also associated with privacy and security risks.

### First and third-party cookies

Cookies are set by a web server and can be of two types: _first-party_ and _third-party_ cookies. First-party cookies are set by the same domain as the site the user is visiting, while third-party cookies are set from a different domain.

Third-party cookies may be from a third party, or from a different site or service belonging to the same "first party" as the top-level site. _Third-party cookies_ are really _cross-site cookies_.

For example, imagine that the owner of the domain `example.com` also owns `example.net` and that the following cookies are set for a user visiting `https://www.example.com`:

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookie name</th>
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
  <figcaption>{{ figure_link(caption="Cookie Context.") }}</figcaption>
</figure>

### Privacy & security risks

Cookies, while fundamental to allow the web to work, do pose privacy & security risks:

- **Web tracking.** Cookies are used by third parties to track users across websites and record their browsing behavior and interests. In targeted advertising, this data is leveraged to show users advertisements aligned with their interest.

  This tracking usually takes place the following way: third-party code embedded on a site can set a cookie that identifies a user. Then, the same third-party can record user activity by obtaining that cookie back when the user visits other websites where it is embedded as well (see also the [Privacy](./privacy) chapter).

  We note that first-party cookies can also be used for online tracking, methods such as cookie syncing allow bypassing the limitation of third-party cookies and track users <a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3442381.3449837">across different websites</a>.

- **Cookie theft and session hijacking.** Cookies are used to store session information such as credentials (for example, a session token) for authentication purposes across several HTTP requests. However, if these cookies were to be obtained by a malicious actor they could use them to authenticate to the corresponding web servers.

  If cookies are not properly set by web servers, they could be prone to cross-site vulnerabilities such as [session hijacking](https://developer.mozilla.org/docs/Glossary/Session_Hijacking), [cross-site request forgery (CSRF)](https://developer.mozilla.org/docs/Web/Security/Practical_implementation_guides/CSRF_prevention), [cross-site script inclusion (XSS)](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting), and others (see also the [Security](./security) chapter).

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

The overall prevalence of first- and third-party cookies on the top one million most popular websites from the HTTP Archive crawl of July 2025 is similar to [last year's distribution](../2024/cookies#first-and-third-party-prevalence).

On both desktop and mobile devices, roughly 40% of cookies are first-party and about 60% third-party.

### First and third-party prevalence by rank

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

We observe that the most popular websites set in proportion more third-party than first-party cookies: 78% of cookies are third-party on the top 1,000 most visited websites when it is just below 50% on the top 10 million. This may be explained by the fact that more popular websites also include more third-party content and scripts that in turn set third-party cookies to enable different functionalities.

## Cookie attributes

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  caption="An overview of cookie attributes for desktop clients.",
  description="This figures gives an overview of how cookie attributes are used for desktop clients for both first- and third-party cookies. Only 1% of first-party cookies and 10% of third-party cookies use `Partioned`. 19% of first-party cookies set their `Session` attribute, while this is the case for only 7% of third-party cookies. Finally, 12% of first-party cookies and 28% of third-party cookies use the `HttpOnly` attribute.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1053912620&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="An overview of cookie attributes for mobile clients.",
  description="This figures gives an overview of how cookie attributes are used for mobile clients for both first- and third-party cookies. We observe the exact same results as for desktop clients. Only 1% of first-party cookies and 9% of third-party cookies use `Partioned`. 19% of first-party cookies set their `Session` attribute, while this is the case for only 5% of third-party cookies. Finally, 12% of first-party cookies and 26% of third-party cookies use the `HttpOnly` attribute.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=435743769&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

The data showcases the different [cookie attributes](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie) for each type of cookies observed. Let's delve into each of these.

### `Partitioned` (CHIPS proposal)

On [compatible browsers](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility), partitioned cookies prevent third-party cookies to be used for cross-site tracking by placing them into a storage partitioned per top-level site.

{{ figure_markup(
  caption="Percent of `Partition` cookies on mobile pages.",
  content="8.6%",
  classes="big-number",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
)
}}

In July 2025, nearly 9% of third-party cookies on the top million are partitioned. We observe here a slight increase in adoption of this relatively new attribute in comparison to [the 6% of last year's results](../2024/cookies#partitioned).

{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="Top partitioned cookies (CHIPS) in third-party context.",
  description="A chart showing the top third-party domains setting partitioned cookies. The top partitioned cookies in third-party context are `cf_clearance` set by Cloudflare and is used for anti-bot challenge.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1834436287&format=interactive",
  sheets_gid="581303793",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}

The previous chart shows the 10 most common partitioned cookies (name and domain) found in third-party context on web pages in July 2025. Here, we observe a major change from last year's analysis, indeed the overall usage of third-party partitioned cookies in 2025 appears to have plummeted to very low levels.

Interestingly, partitioned cookies that were somewhat predominant in 2024 (on about 9% of websites with partitioned cookies) are not present anymore; two of these cookies were set by YouTube and another one was the `receive-cookie-deprecation` cookie set by domains that [participated in the testing phase](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing) of Chrome's Privacy Sandbox. Instead, Cloudflare's `cf_clearance` cookie accounts for the entirety of the top 10 most common partitioned third-party cookies in 2025.

So, in the past year YouTube appears to have altered how these cookies were set on `youtube.com` and on video iframes embedded on other websites. Potential reasons that could explain these changes include: incorrect setting, A/B testing, and more likely infrastructure or policy updates following Google's announcements on the pause and then deprecation of Privacy Sandbox APIs, despite support for partitioned cookies (CHIPS proposal) still being continued.

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="Top partitioned cookies (CHIPS) in first-party context.",
  description="A chart showing the top first-party partitioned cookies. The top cookie `cf_clearance` is set by Cloudflare on about 92% of pages with partitioned cookies, and is related to bot detection.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1232746047&format=interactive",
  sheets_gid="581303793",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}

In 2025, we continue to observe that 1% of first-party cookies are set as partitioned; this might be a bit surprising as the CHIPS proposal is mainly about partitioning third-party cookies, and even if it mentions a <a hreflang="en" href="https://github.com/privacycg/CHIPS?tab=readme-ov-file#first-party-chips">specific uncommon case</a> for partitioned first-party cookies, the <a hreflang="en" href="https://github.com/privacycg/CHIPS/issues/51">behavior requirement</a> appears unclear in first-party context. One reason could be that some cookies are always set the same way—that is, the web server setting them is not distinguishing whether it is currently first-party or third-party.

In 2025, more than 90% of these first-party partitioned cookies are Cloudflare's `cf_clearance` cookie related to bot detection. Comparing to [2024's analysis](/2024/cookies#fig-8), we remark that the first-party partitioned cookie `receive-cookie-deprecation`, set by domains participating in Privacy Sandbox APIs tests, is not as popular anymore. Perhaps, this observation can be explained by a pause or reduction of adoption of these APIs due to Google's corresponding announcements in this past year.

### Session

19% of first-party and 7% of third-party cookies are session cookies; temporary cookies only valid for a single user session that expire once the user quits the corresponding website they were set on, or closes their web browser, whichever happens first.

### `HttpOnly`

[`HttpOnly`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#httponly) cookies provide some mitigation against [cross-site scripting (XSS)](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting) as they can not be accessed by JavaScript code (but are still sent along `XMLHttpRequest` or `fetch` requests initiated from JavaScript).

12% and a little more than 26% of first- and third-party cookies have this attribute set, respectively.

### `Secure`

[`Secure`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#secure) cookies are only sent to requests made through HTTPS, same trend as [last year here](../2024/cookies#secure); while only 24% of first-party cookies set this attribute, all third-party cookies have to set it if they want to use `SameSite=None` (which they all do, see below).

### `SameSite`

The [`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) cookie attribute allows sites to specify when cookies are included with cross-site requests:

- `SameSite=Strict`: a cookie is only sent in response to a request from the same site as the cookie's origin.
- `SameSite=Lax`: same as `SameSite=Strict` except that the browser also sends the cookie on navigation to the cookie's origin site. On Chrome, this is the default value of `SameSite` if no value is set.
- `SameSite=None`: cookies are sent on same-site or cross-site requests.
This means that in order to make third-party tracking with cookies possible, the tracking cookies must have their `SameSite` attribute set to `None`.

To learn more about the `SameSite` attribute, see the following references:
- [`SameSite` cookies explained](https://web.dev/articles/samesite-cookies-explained)
- ["Same-site" and "same-origin"](https://web.dev/articles/same-site-same-origin)
- [What are the parts of a URL?](https://web.dev/articles/url-parts)


{{ figure_markup(
  image="same-site-desktop.png",
  caption="`SameSite` attribute for cookies on desktop client.",
  description="Shows the prevalence of the `SameSite` attribute and its value for both first-party and third-party cookies on desktop clients. 3% of first-party cookies set the `SameSite` attribute to `Strict`, 19% use `SameSite=Lax` (which is the default on Chrome), 11% set the value to `None` and 66% do not specify the value of `SameSite`. Nearly 100% of third-party cookies set the `SameSite` attribute to `None`, in order for these cookies to be sent in a cross-site context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=42361140&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="same-site-mobile.png",
  caption="`SameSite` attribute for cookies on mobile client.",
  description="Shows the prevalence of the `SameSite` attribute and its value for both first-party and third-party cookies on mobile clients. We see very similar results as for desktop clients. 3% of first-party cookies set the `SameSite` attribute to `Strict`, 19% use `SameSite=Lax` (which is the default on Chrome), 11% set the value to None and 63% do not specify the value of `SameSite`. Nearly 100% of third-party cookies set the `SameSite` attribute to `None`, in order for these cookies to be sent in a cross-site context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=413420306&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

The overall distribution of this attribute for first- and third-party cookies across clients is similar to [last year's](../2024/cookies#samesite): nearly 100% of third-party cookies are sent on cross-site requests (`SameSite=None`) which can enable cross-site tracking.

A majority of first-party cookies (66% on desktop, 62% on mobile) do not set this attribute and so are assigned by Chrome the default `Lax` behavior that 19% other first-party cookies explicitly pick, leaving only 3% setting it to the `Strict` setting, and the remaining 11% being sent on both same-site and cross-site requests (`SameSite=None`).

## Cookie prefixes

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="Cookie prefixes observed on desktop pages.",
  description="Shows the observed cookies prefixes used on desktop pages. Very few first- and third-party cookies include the `__Host-` or `__Secure-` prefix.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=908965565&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="Cookie prefixes observed on mobile pages.",
  description="Shows the observed cookies prefixes used on mobile pages. Very few first- and third-party cookies include the `__Host-` or `__Secure-` prefix.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1209286948&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

[Cookie prefixes](https://developer.mozilla.org/docs/Web/HTTP/Cookies#cookie_prefixes) `__Host-` and `__Secure-` can be used in the cookie name to indicate that they can only be set or modified by a secure HTTPS origin. This is to defend against [session fixation](https://developer.mozilla.org/docs/Web/Security/Types_of_attacks#session_fixation) attacks.

Cookies with both prefixes must be set by a secure HTTPS origin and have the `Secure` attribute set. Additionally, `__Host-` cookies must not contain a `Domain` attribute and have their `Path` set to `/`, thus `__Host-` cookies are only sent back to the exact host they were set on, and so not to any parent domain.

Here, we draw the same conclusion as [last year](../2024/cookies#cookie-prefixes): these prefixes have seen very low adoption on the web since their introduction 10 years ago, and so, in practice the defense-in-depth measure that they provide remains unused.

## Top cookies and domains setting them

{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="Top first-party cookies set.",
  description="The chart shows the most widely-set first-party cookies. Google Analytics sets the `_ga` and `_gcl_au` cookies, which are used for website statistics, analytics reports, and targeted advertising, on around 60% and 25% of websites, respectively, for both mobile and desktop clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=219782191&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_first_party_cookies.sql"
  )
}}

The previous chart reports the top 10 most common first-party cookies names being set.
Google Analytics sets the `_ga` and `_gcl_au` cookies, which are used for website statistics, analytics reports, and targeted advertising, on around 60% and 25% of websites.
Other cookies present in this top 10 are related to online tracking, session cookies used to identify user's sessions, or performance.

{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="Top third-party cookies and domains that set them.",
  description="The chart shows the most widely-set third-party cookies. DoubleClick sets third-party advertising cookies on a little over 35% of pages. Microsoft also sets advertising cookies on 23% of pages. The top domains setting third-party cookies are related to tracking and advertising.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=232078905&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_third_party_cookies.sql"
  )
}}

Similarly, this figure shows the top 10 most common third-party cookies being created on the top million websites.

The `IDE` and `test_cookie` cookies are set by `doubleclick.net` (owned by Google) and are present on more than 35% and 25% of websites respectively. DoubleClick checks if a user's web browser supports third-party cookies by trying to set `test_cookie`.

`MUID` from Microsoft comes next, present on more than 23% of websites, and is also used for targeted advertising and cross-site tracking.

As already pointed out in the [`Partitioned` cookies](#partitioned-chips-proposal) section, this year we do not observe the `YSC` and `VISITOR_INFO1_LIVE` from YouTube among top third-party cookies anymore. This is likely due to changes from YouTube (perhaps linked to Google's announcements such as [this one](https://privacysandbox.google.com/blog/privacy-sandbox-next-steps) on the Privacy Sandbox proposals), since the 2024 analysis. It appears that these cookies are not set anymore when the embedding page is just loaded and the video has not been played. Additionally, [Google's Privacy & Terms](https://policies.google.com/technologies/cookies?hl=en-US) also document that `VISITOR_INFO1_LIVE` is being replaced by a `__Secure-YNID` cookie.

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Top registrable domains setting cookies.",
  description="The chart shows the most common domains that set cookies on the web. Google's owned advertising platform DoubleClick sets cookies on more than 33% of the top 1M websites while others in this top 10 domains are at about 5% to 15%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=483296297&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_domains_setting_cookies.sql"
  )
}}

Perhaps, unsurprisingly from prior results, the 10 most common domains that set cookies on the web are all involved with search, targeting, and advertising services.

Google's coverage (`doubleclick.net`, `google.com`, and `youtube.com`) is reaching at least 33% of the websites, and Microsoft's (`bing.com`, `clarity.ms`, `linkedin.com`) at least 14%.

## Number of cookies set by websites

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
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
  <figcaption>{{ figure_link(caption="Statistics for number of cookies set on the top one million desktop pages.", sheets_gid="1535389309", sql_file="nb_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
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
  <figcaption>{{ figure_link(caption="Statistics for number of cookies set on the top one million mobile pages.", sheets_gid="1535389309", sql_file="nb_cookies_quantiles.sql") }}</figcaption>
</figure>

Websites set a median of 9 cookies of any type overall, 7 or 6 first-party cookies, and 7 or 4 third-party cookies for desktop and mobile devices, respectively.

The tables report several other statistics about the number of cookies observed per website and the figures below display their cumulative distribution functions (cdf). For example: on desktop a maximum of 178 first-party and 885 third-party cookies are set per website:

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

## Size of cookies

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
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
  <figcaption>{{ figure_link(caption="Statistics for size of cookies set on the top one million desktop pages.", sheets_gid="1499552173", sql_file="size_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
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
  <figcaption>{{ figure_link(caption="Statistics for size of cookies set on the top one million mobile pages.", sheets_gid="1499552173", sql_file="size_cookies_quantiles.sql") }}</figcaption>
</figure>

We find that the median size of cookies across all observed cookies is 40 bytes and with a maximum of 4 KB which is consistent with the limits defined in <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc6265#section-6.1">RFC 6265</a>.

Similar to [last year](../2024/cookies#size-of-cookies), we observe some cookies that are of a single byte in size, these are likely set by error by empty `Set-Cookie` headers.

We can chart the cumulative distribution function (cdf) of the size of all the cookies seen on the top 1M websites for each client:

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
        <th>Percentile</th>
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
        <td class="numeric">21</td>
      </tr>
      <tr>
        <td>median</td>
        <td class="numeric">365</td>
        <td class="numeric">360</td>
        <td class="numeric">364</td>
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
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on the top one million desktop pages.", sheets_gid="718820729", sql_file="age_expire_cookies_quantiles.sql") }}</figcaption>
</figure>


<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
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
        <td class="numeric">270</td>
        <td class="numeric">360</td>
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
  <figcaption>{{ figure_link(caption="Statistics for age of cookies set on the top one million mobile pages.", sheets_gid="718820729", sql_file="age_expire_cookies_quantiles.sql") }}</figcaption>
</figure>

Cookies are set to an expiration date when they are created. If session cookies expire immediately after the session is over ([see previous section](#session)), most first- and third-party cookies do not and have a median age of a full year.

The longer cookies live, the longer they can be used for re-identification or cross-site tracking which is why most tracking cookies are typically set to be stored in the browser for a longer time.

The maximum age among the cookies that we can observe with the instrumentation and collection of the HTTP Archive Tools for this chapter is of 400 days, due to the [hard limits](https://developer.chrome.com/blog/cookie-max-age-expires) that Chrome imposes on cookie `Expires` and `Max-Age` attribute.

## Conclusion

The observations from this chapter confirm [the conclusions from last year's analysis](../2024/cookies#conclusion):

- A majority (60%) of cookies encountered on the web are third-party cookies and popular websites have significantly more third-party cookies than less popular sites.
- Most popular cookies can be linked to advertising, tracking, and analytics use cases.
- Cookies tend to be long-lived with a median average lifetime of 12 months.
Ephemeral session cookies only represent 19% of first- and 7% of third-party cookies.
- Other restrictions on cookies capabilities are used very little to not at all: if 10% of third-party cookies are partitioned (which represents a slight uptake from last year's 6%), 100% of third-party cookies have `SameSite=None` allowing them to be sent in cross-site requests. Additionally, cookies prefixes adoption is almost non-existent.

Finally, while several web browsers have [deprecated or limited third-party cookies](https://developer.mozilla.org/docs/Web/Privacy/Guides/Third-party_cookies#how_do_browsers_handle_third-party_cookies) due to privacy concerns, Google has decided to <a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">still support them in Chrome</a>. Google is also phasing out most technologies from its Privacy Sandbox initiative, initially designed to _"create a thriving web ecosystem that is respectful of users and private by default"_. As a result, whether trackers use third-party cookies or develop other techniques (first-party syncing, fingerprinting, etc.) to track users online, cookies remain a fundamental component of the web that continue to pose privacy and security risks for users.
