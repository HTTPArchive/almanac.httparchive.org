---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: Privacy chapter of the 2020 Web Almanac covering online tracking cookies, privacy enhancing technologies (PET) and privacy policies.
authors: [ydimova]
reviewers: [ldevernay]
analysts: [ydimova, max-ostapenko]
editors: [tunetheweb]
translators: []
ydimova_bio:  Yana Dimova is a PhD student at KU Leuven university in Belgium, working on privacy and web security.
discuss: 2046
results: https://docs.google.com/spreadsheets/d/16bE70rv4qbmKIqbZS1zUiTRpk5eOlgxBXEabL1qiduI/
featured_quote: Privacy has been increasing in popularity recently and has raised awareness on the users' side. The need for guidelines has been met with various regulations (such as GDPR in Europe, LGPD in Brazil, CCPA in California to name but a few). These aim to increase the accountability of data processors and their transparency towards users. In this chapter, we discuss the prevalence of online tracking with different techniques and the adoption rate of cookie consent banners and privacy policies by websites.
featured_stat_1: 93%
featured_stat_label_1: Websites that load at least one tracker
featured_stat_2: Nine out of ten
featured_stat_label_2: Top cookie-setting domains owned by Google
featured_stat_3: 44.8%
featured_stat_label_3: Websites that have a privacy policy
---

## Introduction

This chapter of the Web Almanac gives an overview of the current state of privacy on the web. This topic has been increasing in popularity recently and has raised awareness on the users' side. The need for guidelines has been met with various regulations (such as <a hreflang="en" href="https://gdpr-info.eu/">GDPR</a> in Europe, <a hreflang="en" href="https://lgpd-brazil.info/">LGPD</a> in Brazil, <a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">CCPA</a> in California to name but a few). These aim to increase the accountability of data processors and their transparency towards users. In this chapter, we discuss the prevalence of online tracking with different techniques and the adoption rate of cookie consent banners and privacy policies by websites.

## Online tracking

Third-party trackers collect user data to build up profiles of the user's behavior to be monetized for advertising purposes. This raises privacy concerns with users on the web, which resulted in the emergence of various tracking protections. However, as we will see in this section, online tracking is still widely used. Not only does it have a negative impact on privacy, online tracking has a <a hreflang="en" href="https://gerrymcgovern.com/calculating-the-pollution-cost-of-website-analytics-part-1/">huge impact on the environment</a> and avoiding it can lead to [better performance](https://x.com/fr3ino/status/1000166112615714816).

We examine the prominence of the most common types of [third-party](./third-party) tracking, namely by means of third-party cookies and the use of fingerprinting. Online tracking is not limited to just these two techniques, new ones keep arising to circumvent existing countermeasures.

### Third-party trackers

We use <a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a>'s tracker list to determine the percentage of websites that issue a request to a potential tracker. As shown in the following figure, we have found that at least one potential tracker is present on roughly 93% of websites.

{{ figure_markup(
  image="privacy-websites-that-load-trackers.png",
  caption="Websites including at least one potential tracker.",
  description="Bar chart showing that 92.94% of desktop websites and 92.97% of mobile websites load trackers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1325818112&format=interactive",
  sheets_gid="1591448294"
  )
}}

We examined the most widely used trackers and plot the prevalence of the 10 most popular ones.

{{ figure_markup(
  image="privacy-biggest-third-party-potential-trackers.png",
  caption="Top 10 Potential Trackers.",
  description="Bar chart showing the prevalence of the 10 most popular potential trackers used on mobile and desktop clients. There is little difference between desktop and mobile and mobile has 65.5% for google_analytics, 65.9% for googleapis.com, 63.3% for gstatic, 58.3% for google_fonts, 50.0% for doubleclick, 47.6% for google, 42.4% for google_tag_manager, 30.9% for facebook, 19.2% for google_adservices, and 12.7% for cloudflare.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=850649042&format=interactive",
  sheets_gid="1677398038"
  )
}}

The largest player on the online tracking market is without doubt Google, with eight of its domains present in the top 10 potential trackers and prevalent on at least 70% of websites. They are followed by Facebook and Cloudflare–though the latter is probably more reflective of the popularity of them as a hosting site.

WhoTracksMe's tracker list also defines categories that the trackers belong to. If we remove CDNs and Hosting sites from our statistics, under the assumption they may not track—or at least that that is not their primary function—then you get a slightly different view of the top 10.

{{ figure_markup(
  image="privacy-biggest-third-party-trackers.png",
  caption="Top 10 Trackers.",
  description="Bar chart showing the prevalence of the 10 most popular trackers used on mobile and desktop clients. There is little difference between desktop and mobile and mobile has 65.5% for google_analytics, 50.0% for doubleclick, 47.6% for google, 42.4% for google_tag_manager, 30.9% for facebook, 19.2% for google_adservices, 12.7% for youtube, 19.2% for google_syndication, and 6.5% for both twitter and wordpress_stats.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1831606887&format=interactive",
  sheets_gid="1677398038"
  )
}}

Here Google still makes up seven out of the top 10 domains. The following figure shows the distribution of the different categories for the 100 largest potential trackers by category.

{{ figure_markup(
  image="privacy-tracker-categories.png",
  caption="Categories of the 100 most popular potential trackers.",
  description="Bar chart showing distribution of the top 100 potential trackers on the web with 56 for advertising, 11 for cdn, 9 for site_analytics, 6 for both social media and misc, 3 for both essential and customer_help, 2 for both audio and video and 1 for both comments and undefined.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1117413918&format=interactive",
  sheets_gid="1431872451",
  )
}}

Nearly 60% of the most popular trackers are advertising-related. This could be due to the profitability of the online advertising market being perceived to be related to the amount of tracking.

### Cookies

We looked into the most popular cookies being set on websites in HTTP's response header, according to their name and domain.

<figure>
  <table>
    <thead>
      <tr>
        <th>Domain</th>
        <th>Cookie Name</th>
        <th>Websites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top cookies on desktop sites.", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Domain</th>
        <th>Cookie Name</th>
        <th>Websites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">32%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>DSID</code></td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>yandexuid</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>i</code></td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top cookies on mobile sites.", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

As you can see, Google's tracking domain "doubleclick.net" sets cookies on roughly a quarter of websites on a mobile client and a third of all websites on a desktop client. Again, nine out of the ten most popular cookies on desktop client and seven out of ten on mobile are set by a Google domain. This is a lower bound for the number of websites the cookie is set on, since we are only counting cookies set via an HTTP header–a large number of tracking cookies are set by using third-party scripts.

### Fingerprinting

Another widely-used tracking technique is fingerprinting. This consists of collecting different kinds of information about the user with the goal of building a unique "fingerprint" for them. Different types of fingerprinting are used on the web by trackers. Browser fingerprinting use characteristics specific to the browser of the user, relying on the fact that the chance of another user having the exact same browser set-up is fairly small if there are a large enough number of variables to track. In our crawl, we examined the presence of the <a hreflang="en" href="https://fingerprintjs.com/">FingerprintJS</a> library, which provides browser fingerprinting as a service.

{{ figure_markup(
  image="privacy-websites-with-fingerprintjs-library.png",
  caption="Websites using FingerprintJS.",
  description="Barchart showing 0.17% of desktop sites and 0.18% of mobile sites use FingerprintJS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1556252953&format=interactive",
  sheets_gid="222110824",
  sql_file="percent_of_websites_with_fingerprinting.sql "
  )
}}

Although the library is present on only a small percentage of websites, the persistent nature of fingerprinting means even small usage can have a big impact. Furthermore, FingerprintJS is not the only attempt at fingerprinting. Other libraries, tools and native code can also serve this purpose, so this is just one example.

## Consent Management Platforms

Cookie consent banners have become common now. They increase transparency towards cookies and often allowing users to specify their cookie choices. While a lot of websites opt for using their own implementation of cookie banners, third-party solutions called <em>Consent Management Platforms</em> have recently emerged. The platforms provide an easy way for websites to collect user's consent for different types of cookies. We see that 4.4% of websites use a consent management platform to manage cookie choices on desktop clients, and 4.0% on mobile clients.

{{ figure_markup(
  image="privacy-websites-with-consent-management-platform.png",
  caption="Websites using a consent management platform.",
  description="Bar chart showing 4.4% of desktop sites and 4.0% of mobile sites use a Consent Management Platform.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=2025542332&format=interactive",
  sheets_gid="1910033502",
  sql_file="percent_of_websites_with_cmp.sql"
  )
}}

{{ figure_markup(
  image="privacy-consent-management-platform-popularity.png",
  caption="Popularity of consent management platform.",
  description="Bar chart showing popular consent management platforms from Osano at 1.6%, Quantcast Choice at 1.0%, Cookiebot and OneTrust at 0.4%, Iubenda at 0.3%, Crownpeak, Didomi, and TrustArc all at 0.1%, CIVIC, Cookie Script, CookieHub, Termly, Uniconsent, CookieYes, eucookie.eu, Seers, and Metomic all at approximately 0.0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341496718&format=interactive",
  sheets_gid="1104760876",
  sql_file="percent_of_websites_using_each_cmp.sql"
  )
}}

When looking at the popularity of the different consent management solutions, we can see that Osano and Quantcast Choice are the leading platforms.

### IAB Europe's Transparency Consent Framework

IAB Europe, the Interactive Advertising Bureau, is a European association for digital marketing and advertising. They proposed a <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency Consent Framework</a> (TCF) as a GDPR-compliant solution to obtain users' consent about their digital advertising preferences. The implementation provides an industry standard for communication between publishers and advertisers about consumer consent.

{{ figure_markup(
  image="privacy-adoption-of-the-tcf-banner.png",
  caption="Adoption rate of TCF banner.",
  description="Bar chart showing that 1.5% of desktop sites and 1.4% of mobile sites have implemented IAB Europe's TCF banner.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341275612&format=interactive",
  sheets_gid="2077755325",
  sql_file="percent_of_websites_with_iab_tcf_banner.sql"
  )
}}

While our results show that the TCF banner is not yet the "industry standard", it is a step in the right direction. Considering the main target group of IAB Europe is in fact European publishers, and our crawl is global, having an adoption rate on 1.5% of websites on desktop client and 1.4% on mobile is not too bad.

## Privacy Policies

Privacy policies are widely used by websites to meet legal obligations and increase transparency towards users about data collection practices. In our crawl, we searched for keywords indicating the presence of a privacy policy text on each visited website.

{{ figure_markup(
  image="privacy-websites-with-privacy-link.png",
  caption="Websites that have a privacy policy.",
  description="Bar chart showing that 44.8% of desktop sites and 42.3% of mobile sites have a privacy link.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=329249623&format=interactive",
  sheets_gid="495362514",
  sql_file="percent_of_websites_with_privacy_links.sql "
  )
}}

The results show that almost half of the websites in the dataset have included a privacy policy, which is positive. However, studies have shown that the majority of internet users do not bother reading privacy policies and when they do, they lack understanding due to the length and complexity of most privacy policy texts. Still having a policy at all is a step in the right direction!

## Conclusion

This chapter has shown that third-party tracking remains prominent on both desktop and mobile clients, with Google tracking the largest percentage of websites. Consent Management Platforms are used on a small percentage of websites; however a lot of websites implement their own cookie consent banners.

Lastly, roughly half of the websites include a privacy policy, which benefits greatly transparency towards users about data processing practices. This is undoubtedly a step forward but there is a lot still to be done. Outside of this analysis we know that privacy policies are hard to read and understand and cookie consent banners manipulate users into consent.

For the web to truly respect users, privacy has to be a part of conception, not an afterthought. Regulation is a good thing in this regards, and it is reassuring to see an increase in privacy regulation worldwide. [Privacy by design](https://en.wikipedia.org/wiki/Privacy_by_design) should be the norm, rather than deploying policies and tools in order to meet minimum legal requirements and avoid financial penalties.
