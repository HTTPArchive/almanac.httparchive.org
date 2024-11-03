---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: Privacy chapter of the 2024 Web Almanac covers the adoption and impact of online tracking, privacy preference signals, and browser initiatives for a privacy-friendlier web.
authors: [bgstandaert, ydimova]
reviewers: []
editors: []
analysts: [bgstandaert, max-ostapenko]
translators: []
results: https://docs.google.com/spreadsheets/d/18r8cT6x9lPdM-rXvXjsqx84W7ZDdTDYGD59xr0UGOwg/
featured_quote:
featured_stat_1:
featured_stat_label_1:
featured_stat_2:
featured_stat_label_2:
featured_stat_3:
featured_stat_label_3:
---

## Stateful Tracking

### Third-Party Tracking Services

One of the most common forms of online tracking is through third-party services, where a website owner typically includes a third-party, cross-site, script that provides site analytics or shows advertisements to visitors. This script can then set a third-party cookie, and log which website the user visited. Whenever the user visits another website that includes the same third-party service, the cookie will be sent along to the tracker, allowing them to re-identify the user and link both website visits to the same profile.

We leverage data from [WhoTracks.Me](http://whotracks.me/), a publicly available list that catalogs third-party trackers present across a wide range of websites. By utilizing this resource, we identify the most prevalent trackers on the websites. This helped us assess the dominance of certain tracking companies and better understand the overall landscape of third-party tracking.

Google-owned domains dominate the tracking landscape, with googleapis.com and gstatic appearing on the highest percentage of pages—68% and 61%, respectively. Other prominent trackers include google_tag and google_analytics, each seen on over 50% of pages, highlighting the significant reach of Google's tracking services. Additionally, platforms like Facebook and YouTube also play notable roles in third-party tracking, though with lesser coverage compared to Google.

{{ figure_markup(
  image="top-whotracksme-trackers.png",
  caption="Top WhoTracksMe trackers.",
  description="A bar chart showing the most-common trackers form the WhoTracksMe dataset, sorted by the percent of pages on which they appear. The top trackers are googleapis.com (69% desktop; 68% mobile), gstatic (67% desktop; 61% mobile), google_tag (60% desktop; 57% mobile), google_analytics (55% desktop; 52% mobile); google (48% desktop; 47% mobile), doubleclick (40% desktop; 38% mobile), facebook (25% desktop; 23% mobile), cloudflare (17% desktop; 17% mobile), youtube (11% desktop; 11% mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=307091186&format=interactive",
  sheets_gid="1429146110",
  sql_file="number_of_websites_with_whotracksme_trackers.sql"
  )
}}

### Third-Party Cookies

{{ figure_markup(
  image="top-third-party-cookie-origins.png",
  caption="Top Third-Party Cookie Origins.",
  description="A bar chart showing the most-common origins for third-party cookies, by the percent of pages on which they appear. Displayed values are doubleclick.net (27% desktop; 26% mobile), youtube.com (7% desktop; 6% mobile), google.com (5% desktop; 4% mobile), `www.google.com` (5% desktop; 4% mobile), linkedin.com (4% desktop; 4% mobile), bing.com (4% desktop; 3% mobile), yandex.ru (3% desktop; 5% mobile), adnxs.com (3% desktop; 3% mobile), mc.yandex.ru (3% desktop; 4% mobile), c.bing.com (3% desktop; 3% mobile), yandex.com (3% desktop; 4% mobile), mc.yandex.com (3% desktop; 4% mobile), adsrvr.org (3% desktop; 3% mobile), googleadservices.com (3% desktop; 3% mobile), yahoo.com (3% desktop; 3% mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=542106842&format=interactive",
  sheets_gid="1230745383",
  sql_file="cookies_top_third_party_domains.sql"
  )
}}

Third-party cookies are the main mechanism used to track the users on the web. Our measurements reveal that Google’s doubleclick.com is the largest source of third-party cookies, with presence on more than a quarter of the crawled web pages. Compared to [the 2022 measurements](https://almanac.httparchive.org/en/2022/privacy#third-party-cookies), the top sources of third-party cookies have remained largely static, with the notable absence of Facebook, previously the second-largest source of third-party cookies. However, as shown in the next section, we instead see a significant number of cookies set by Facebook in the first-party context.

In order to identify trackers that share cookies across many domains, we also examine the most common names for third-party cookies. We note that the top four cookie names correspond to cookies set by Google’s advertising products and Youtube, as described in [their documentation](https://business.safety.google/adscookies/), and the fifth most-common name corresponds to a cookie set by Cloudflare.

Cloudflare’s cookie, `__cf_bm``, is used to ["identify and mitigate automated traffic"](https://developers.cloudflare.com/fundamentals/reference/policies-compliances/cloudflare-cookies/#__cf_bm-cookie-for-cloudflare-bot-products). As this cookie is set on the domains of Cloudflare’s individual customers, it is not captured in a per-domain ranking of cookies.

{{ figure_markup(
  image="top-third-party-cookie-names.png",
  caption="Top Third-Party Cookie Names.",
  description="A bar chart showing the most-common names for third-party cookies, by the percent of pages on which they appear. Displayed values are test_cookie (17% desktop; 16% mobile), IDE (14% desktop; 13% mobile), YSC (11% desktop; 9% mobile), VISITOR_INFO1_LIVE (11% desktop; 9% mobile), __cf_bm (8% desktop; 7% mobile), receive-cookie-deprecation (8% desktop; 6% mobile), NID (8% desktop; 7% mobile), uid (6% desktop; 8% mobile), i (6% desktop; 8% mobile), ar_debug (6% desktop; 6% mobile), c (5% desktop; 7% mobile), _GRECAPTCHA (5% desktop; 5% mobile), bcookie (4% desktop; 5% mobile), lidc (4% desktop; 5% mobile), MUID (4% desktop; 4% mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1978360808&format=interactive",
  sheets_gid="766149659",
  sql_file="cookies_top_third_party_names.sql"
  )
}}

### First-Party Cookies

{{ figure_markup(
  image="top-first-party-cookie-names.png",
  caption="Top First-Party Cookie Names.",
  description="A bar chart showing the most-common names for first-party cookies, by the percent of pages on which they appear. Displayed values are _ga (49% desktop; 47% mobile), _gid (29% desktop; 27% mobile), _fbp (15% desktop; 14% mobile), _gcl_au (14% desktop; 13% mobile), PHPSESSID (13% desktop; 13% mobile), _gat (10% desktop; 9% mobile), XSRF-TOKEN (5% desktop; 5% mobile), __eoi (5% desktop; 5% mobile), __gads (5% desktop; 5% mobile), __gpi (5% desktop; 5% mobile), sbjs_current (4% desktop; 4% mobile), sbjs_session (4% desktop; 4% mobile), sbjs_udata (4% desktop; 4% mobile), sbjs_first (4% desktop; 4% mobile), sbjs_first_add (4% desktop; 4% mobile)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=132012980&format=interactive",
  sheets_gid="452718378",
  sql_file="cookies_top_first_party_names.sql"
  )
}}

When measuring common first-party cookies, we see extensive evidence of analytics and advertising services setting cookies in the first-party context. The top two cookies, _ga and _gid, are both part of Google Analytics. The next cookie, _fbp, is a tracking cookie set by Facebook. Since 2022, Facebook’s cookie tracking appears to have moved primarily from the third-party context into the first-party context; the [default setting for the Meta Pixel](https://www.facebook.com/business/help/471978536642445?id=1205376682832142) now sets first-party cookies. The majority of the remaining cookies are either additional Google cookies or cookies associated with Sourcebuster, a site analytics plugin. Only two of the top cookie names, PHPSESSID and XSRF-TOKEN, have a clear non-tracking purpose. PHPSESSID is the default cookie name used by the PHP framework to store the user’s session ID, and XSRF-TOKEN is a default name used by the Angular framework.

## Stateless Tracking

### Fingerprinting

As browsers continue to expand the restrictions placed on cookies, fingerprinting–a technique that combines data from various browser APIs to develop a unique identifier for a particular user–has become an attractive alternative. Prior studies, such as ["Fingerprinting the Fingerprinters"](https://ieeexplore.ieee.org/abstract/document/9519502), have found that fingerprinting is now common and is increasing in prevalence. Here, we attempt to determine the most common sources of fingerprinting across the web.

Detecting fingerprinting is difficult, as the APIs used in fingerprinting can also be used for non-tracking purposes. To identify potential sources of fingerprinting, we start by examining the source code of [FingerprintJS](https://github.com/fingerprintjs/fingerprintjs), a commonly-used fingerprinting library. After compiling a list of APIs used by the library, we search for occurrences of these APIs in each request, and mark any script with 5 or more usages as a potential fingerprinting script. Finally, we rank the scripts by the number of pages on which they are loaded.

{{ figure_markup(
  image="top-potential-fingerprinting-scripts.png",
  caption="Top Scripts with Usages of Fingerprinting APIs.",
  description="A bar chart showing scripts with usages of APIs commonly used for fingerprinting, ordered by the percentage of pages on which they appear. Each script is identified by its file name followed by the name of its associated company or product. Displayed values are recaptcha__en.js (Google Recaptcha) (10% desktop; 10% mobile), aframe (Google Recaptcha) (6% desktop; 6% mobile), common.js (Google Maps API) (5% desktop; 5% mobile), www-embed-player.js (Youtube) (4% desktop; 4% mobile), base.js (Youtube) (4% desktop; 4% mobile), adsbygoogle.js (Google) (3% desktop; 3% mobile), wix-perf-measure.umd.min.js (Wix) (3% desktop; 3% mobile), modules.db8890ba82a7e392473f.js (Hotjar) (2% desktop; 2% mobile), group_5.2de88a07.chunk.min.js (Wix) (2% desktop; 3% mobile), group_3.b26b356a.chunk.min.js (Wix) (2% desktop; 3% mobile), tpaCommons.1b788520.chunk.min.js (Wix) (2% desktop; 3% mobile), Qj-BdKDLI_z.js (Facebook) (2% desktop; 2% mobile), tag.js (Yandex Metrika) (2% desktop; 3% mobile), main.cd290f82.bundle.min.js (Wix) (2% desktop; 3% mobile), thunderbolt-commons.35876736.bundle.min.js (Wix) (2% desktop; 2% mobile)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=928442588&format=interactive",
  sheets_gid="772204378",
  sql_file="fingerprinting_most_common_scripts.sql"
  )
}}

Through this, we find a mixture of scripts that are primarily used for tracking, and scripts that also have a non-tracking purpose. Recaptcha, the most common script, is known to use fingerprinting to separate humans from bots. Google Ads and Yandex Metrika are also primarily tracking scripts. However, other scripts, such as the Google Maps API and Youtube embed API, also have a non-tracking purpose, and so their usage of these APIs may have purposes other than fingerprinting. Further manual analysis is required to confirm whether these scripts are actually performing fingerprinting.

### Covert Cross-site Tracking

Websites employ various covert techniques to track users across the web, often bypassing privacy protections like ad blockers and third-party cookie restrictions. These methods exploit vulnerabilities in browser functionality and DNS configurations, enabling persistent tracking even as privacy measures become more stringent. We examined two prominent covert tracking practices: CNAME tracking and bounce tracking, and looked into how browsers are trying to reduce such pervasive covert tracking and maintain user privacy by default.

#### CNAME tracking

Traditional blocklist-based tracking protection, like ad blockers, often rely on blocking third-party requests based on their domain. To circumvent these tools, some trackers employ CNAME cloaking (or CNAME tracking). This technique leverages CNAME records at the DNS level to connect a first-party subdomain (e.g., `subdomain.example.com` on `www.example.com`) to the actual third-party tracker (e.g., `example.tracker.com`). Because the request appears to originate from the first-party domain, ad blockers are less likely to intervene, and cookies are set in a first-party context.

Our analysis of DNS data identifies CNAME records pointing to domains different from the website's primary domain. While CNAME records are legitimately used by hosting services like CDNs, they can also be exploited for tracking. To focus on tracking-specific usage, we cross-referenced identified domains with tracker lists from [Ghostery](https://github.com/ghostery/trackerdb) and [AdGuard](https://github.com/AdguardTeam/cname-trackers), filtering out primarily hosting-related domains.

{{ figure_markup(
  image="most-common-cname-domains.png",
  caption="Most common CNAME tracking domains by the percentage of pages and their count of related requests domains.",
  description="While `wordpress.com` appears on a larger percentage of pages, the number of request domains associated with `salesforce.com`, `omtrdc.net` and `eloqua.com` suggests SalesForce, Adobe and Oracle correspondingly are the major players in CNAME tracking.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1893938121&format=interactive",
  sheets_gid="1426844224",
  sql_file="most_common_cname_domains.sql"
  )
}}

The chart highlights the top 10 CNAME tracking domains categorized by [Ghostery](https://www.ghostery.com/blog/how-ghostery-categorizes-trackers) as used for analytics and/or advertising. `wordpress.com`, used for website usage insights, is the most prevalent. Adobe's `omtrdc.net` and `2o7.net` follow closely.

The number of request domains associated with each CNAME domain is also shown. The distribution of request domains mirrors the page prevalence, reflecting the typical one-CNAME-per-tracker-per-website pattern. However, third-party origins also exist, such as Adobe's CNAME from `smetrics.ford.com` to `ford.com.ssl.sc.omtrdc.net` that exists on multiple pages. `salesforce.com` utilizes the highest number of different CNAME domains, often mixing first and third-party usage (e.g., third-party `bpd.my.salesforce-sites.com` vs. first-party `kundportal.lidl.se` pointing to Salesforce domains).

While our chart shows the top 10, we identified 13 CNAME trackers classified for advertising/analytics and present on at least 100 pages. In summary, CNAMEs are being used for tracking in practice. Not only do they use first-party subdomains, but even when cloaking the tracking domain under a different third-party domain, the trackers can still circumvent blocklists.

To combat CNAME tracking, browser vendors and privacy extensions are developing countermeasures. Brave, for example, uses DNS resolution to uncover and block CNAME trackers, while Safari's ITP limits cookie lifetimes.

#### Bounce tracking

With increasing browser restrictions on third-party cookies, bounce tracking has emerged as a bypass technique. It exploits a vulnerability in browsers like Safari, which [restrict cookie setting](https://webkit.org/tracking-prevention/#the-default-cookie-policy) unless a domain has been directly visited. Bounce tracking momentarily tricks the browser into visiting the tracking domain as a first-party site, allowing it to set a cookie that can be accessed later as a third-party. This way trackers become able to read/write cookies across sites, rendering third-party cookie blocking ineffective. The user is then redirected back to the original or intended page. While used for legitimate purposes like federated authentication (e.g., OAuth), bounce tracking is also employed for cross-site tracking and ad campaign measurement. [Chrome](https://developers.google.com/privacy-sandbox/protections/bounce-tracking-mitigations), [Safari](https://webkit.org/tracking-prevention/#:~:text=to%20as%20bounce-,tracking,-.%20ITP%20counts%20the), [Brave](https://brave.com/glossary/bounce-tracking/) and other browsers actively block bounce tracking.

Given the constrained nature of the crawl, limited to the loading of a specific set of pages, our analysis of redirections encompassed only those returning to the originating page. We identify bounce tracking by detecting instantaneous redirects to a third-party tracker that sets a first-party cookie before returning the user to the original page.

{{ figure_markup(
  image="number-of-websites-with-bounce-tracking.png",
  caption="Most common bounce tracking domains by number of pages.",
  description="`daemon.indapass.hu` is the most prevalent, appearing on 422 pages in the dataset, followed by `medium.com` (364 pages) and `api.action-media.ru` (155 pages). The remaining domains appear on significantly fewer pages, ranging from 83 down to 23.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQIBO5Jzld2vEAQ69_eJQV00i_dTTz4jcRUHUDXdpqtA3bKoJrkcoMwjQCO9vzjXDB4IGYkKw6Ma1Lk/pubchart?oid=1199006042&format=interactive",
  sheets_gid="1426844224",
  sql_file="number_of_websites_with_bounce_tracking.sql"
  )
}}

The chart shows prevalent bounce tracking hostnames, with `daemon.indapass.hu` (422 pages) and `medium.com` (364 pages) leading.

Our analysis, limited to crawlable pages, isn't exhaustive, and not all identified domains necessarily exhibit privacy-intrusive behavior. Legitimate uses, like SSO (e.g., `login.szn.cz`), can often be distinguished from tracking by the presence of user interaction on the bounce domain.
