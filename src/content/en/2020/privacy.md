---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 10
title: Privacy
description: Privacy chapter of the 2020 Web Almanac covering online tracking cookies, privacy enhancing technologies (PET) and privacy policies
authors: [ydimova]
reviewers: [ldevernay]
analysts: [ydimova, max-ostapenko]
translators: []
#ydimova_bio: TODO
discuss: 2046
results: https://docs.google.com/spreadsheets/d/16bE70rv4qbmKIqbZS1zUiTRpk5eOlgxBXEabL1qiduI/
queries: 10_Privacy
featured_quote: This topic has been increasing in popularity recently and has raised awareness on the users’ side. The need for guidelines has been met with various regulations (such as GDPR in Europe, LGPD in Brazil, CCPA in California…), that aim to increase the accountability of data processors and their transparency towards users. In this chapter, we discuss the prevalence of online tracking with different techniques and the adoption rate of cookie consent banners and privacy policies by websites.
featured_stat_1: 93%
featured_stat_label_1: Websites load at least one tracker
featured_stat_2: Nine out of ten
featured_stat_label_2: Largest domains that set cookies on the biggest percentage of websites are Google-owned.
featured_stat_3: 44.8%
featured_stat_label_3: Sites have a privacy policy
unedited: true
---


## Introduction

This chapter of the Web Almanac gives an overview of the current state of privacy on the web. This topic has been increasing in popularity recently and has raised awareness on the users’ side. The need for guidelines has been met with various regulations (such as [GDPR](https://gdpr-info.eu/) in Europe,  [LGPD](https://lgpd-brazil.info/) in Brazil, [CCPA](https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5) in California…), that aim to increase the accountability of data processors and their transparency  towards users. In this chapter, we discuss the prevalence of online tracking with different techniques and the adoption rate of cookie consent banners and privacy policies by websites.


## Online Tracking
Third-party trackers collect user data to build up profiles of the user’s behavior to be monetized for advertising purposes. This raises privacy concerns with users on the web, which resulted in the emergence of various tracking protections. However, as we will see in this section, online tracking is still widely used. Not only does it have a negative impact on privacy, online tracking has a [huge impact on the environment](https://gerrymcgovern.com/calculating-the-pollution-cost-of-website-analytics-part-1/) and avoiding it can lead to [better performance](https://twitter.com/fr3ino/status/1000166112615714816). 
We examine the prominence of the most common types of third-party tracking, namely by means of third-party cookies and the use of fingerprinting. Online tracking is not limited to just these two techniques, new ones keep arising to circumvent existing countermeasures. 


### Third-party trackers
We use [WhoTracksMe](https://whotracks.me/)’s tracker list to determine the percentage of websites that issue a request to a tracker. As in the following figure, we find that on roughly 93% of websites, at least one tracker is present. 

{{ figure_markup(
  image="websites_that_load_trackers.png",
  caption="Websites including at least one tracker",
  description="This figure shows the percentage of websites that load at least one tracker.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1325818112&format=interactive",
  sheets_gid="1591448294"
  )
}}

We examine the largest (most widely used) trackers and plot the prevalence of the 10 most popular ones.

{{ figure_markup(
  image="biggest_third-party_trackers.png",
  caption="Top 10 Trackers",
  description="This figure shows the prevalence of the 10 most popular trackers used on mobile and desktop clients.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=850649042&format=interactive",
  sheets_gid="1677398038"
  )
}}

The largest player on the online tracking market is definitely Google, with eight of  its tracking domains present in the top 10 trackers and prevalent on at least 70% of websites. Following are Facebook and Cloudflare. 

WhoTracksMe’s tracker list also defines categories that the trackers belong to. The following figure shows the distribution of the different categories for the 100 largest trackers.

{{ figure_markup(
  image="tracker_categories.png",
  caption="Categories of the 100 most popular trackers",
  description="This figure shows distribution of the top 100 trackers on the web.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1117413918&format=interactive",
  sheets_gid="1431872451",
  )
}}

Nearly 60% of the most popular trackers are advertising-related. This could be due to the profitability of the online advertising market.

### Cookies
We looked into the most popular cookies being set on websites in HTTP's response header, according to their name and domain.

<figure markdown>
| Client | Domain | Cookie Name | Websites present on   |
| -------- | ------- | ------ | ------ |
| desktop |	doubleclick.net|	test_cookie|	24%|
|desktop|	facebook.com|	fr|		10%|
|desktop|	youtube.com|	VISITOR_INFO1_LIVE|	10%
|desktop|	youtube.com|	YSC|10%
|desktop|	doubleclick.net|	IDE|9%
|desktop|	doubleclick.net|unknown|	9%
|desktop|	youtube.com	|GPS|9%
|desktop|	doubleclick.net|	unknown|	8%
|desktop|	google.com|	NID|	6%
|desktop|	doubleclick.net|	unknown|6%
|mobile|	doubleclick.net|	test_cookie|32%
|mobile|	doubleclick.net	|IDE|	21%
|mobile|	facebook.com|	fr|	10%
|mobile|	youtube.com|	VISITOR_INFO1_LIVE|10%
|mobile	|youtube.com|	YSC|10%
|mobile|	google.com|	NID|10%
|mobile|	youtube.com	|GPS|	8%
|mobile|	doubleclick.net	|DSID|	7%
|mobile|	yandex.ru|	yandexuid|	6%
|mobile|	yandex.ru|	i|	6%

<figcaption>{{ figure_link(caption="Top cookies", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

As found previously, Google’s  tracking domain ‘doubleclick.net’  sets cookies on roughly one fourth of websites on a mobile client and one third of all  websites on a desktop client. Again, nine out of the ten most popular cookies on desktop client and 7 on mobile are set by a Google domain. This is a lower bound for the amount of websites the cookie is set on, since we are only conting cookies set via an HTTP header, a large amount of tracking cookies is set by using third-party scripts.

### Fingerprinting

Another widely-used tracking technique is fingerprinting, which consists of collecting different kinds of information about the user with the goal of building a unique “fingerprint” for them. Different types of fingerprinting are used on the web by trackers. Browser fingerprinting uses characteristics specific to the browser of the user, relying on the fact that the chance of another user having the exact same browser information is fairly small. In our crawl, we examined the presence of  the [FingerprintJS](https://fingerprintjs.com/) library, which provides browser fingerprinting as a service.  

{{ figure_markup(
  image="websites_with_fingerprint.js_library.png",
  caption="Websites using FingerprintJS",
  description="This figure shows the percentage of websites using FingerprintJS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1556252953&format=interactive",
  sheets_gid="222110824",
    sql_file="percent_of_websites_with_fingerprinting.sql "
  )
}}
Although the library is present on less than 1% of websites, the main issue with fingerprinting is its persistent nature.  Furthermore, FingerprintJS is not the only attempt at fingerprinting.  Other libraries, tools and native code can also serve this purpose.

## Consent Management Platforms
Cookie consent banners are being used by websites for years now, to allow users to specify their third-party cookie choices as well as increase transparency towards them. While a lot of websites opt for using their own implementation of cookie banners, third-party solutions called ‘Consent Management Platforms’ have recently emerged. The platforms provide an easy way for websites to collect user’s consent for different types of cookies. We see that 4.4% of websites use some consent management platform  to provide cookie choices on desktop clients, and 4% on mobile clients. 

{{ figure_markup(
  image="websites_with_consent_management _platform.png",
  caption="Websites using a consent management platform",
  description="This figure shows the ahre of websites that are using a popular consent management platform.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=2025542332&format=interactive",
  sheets_gid="1910033502",
    sql_file="percent_of_websites_with_cmp.sql"
  )
}}
{{ figure_markup(
  image="consent_management_platform_popularity.png",
  caption="Popularity of consent management platform",
  description="This figure shows the popularity of each consent management platform.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341496718&format=interactive",
  sheets_gid="1104760876",
    sql_file="percent_of_websites_using_each_cmp.sql"
  )
}}

When looking at the popularity of the different consent management solutions, we can see that Osano and Quantcast choice are the leading platforms.

#### IAB Europe’s Transparency Consent Framework
IAB Europe proposed a [Transparency Consent Framework](https://iabeurope.eu/transparency-consent-framework/) (TCF) as a GDPR-compliant solution to obtain users' consent about their digital advertising preferences. The implementation provides an industry standard for communication between publishers and advertisers about consumer consent. 
{{ figure_markup(
  image="adoption_of_the_TCF_banner.png",
  caption="Adoption rate of TCF banner",
  description="This figure shows the percentage of websites using IAB Europe's TCF banner.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341275612&format=interactive",
  sheets_gid="2077755325",
    sql_file="percent_of_websites_with_iab_tcf_banner.sql"
  )
}}
While our results show that the TCF banner is not yet the ‘industry standard’, it is a step in the right direction. Considering the main target group of IAB Europe is in fact European publishers, having an adoption rate on 1.5% of websites on desktop client and 1.4% on mobile is not too bad. 

## Privacy Policies
Privacy policies are widely used by websites to increase transparency towards users about data collection practices. In our crawl, we searched for keywords indicating the presence of a privacy policy text on each visited website. 

{{ figure_markup(
  image="websites_with_privacy_link.png",
  caption="Websites that have a privacy policy",
  description="This figure shows the percentage of websites that indicate to have implemented a privacy policy text.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=329249623&format=interactive",
  sheets_gid="495362514",
    sql_file="percent_of_websites_with_privacy_links.sql "
  )
}}
The results show that almost half of the websites in the dataset have included a privacy policy, which is positive. However, studies have shown that the majority of internet users do not bother reading privacy policies and when they do, they lack understanding due to the length and complexity of most privacy policy texts.

## Conclusion
This chapter gives an overview of the current state of privacy on the web. Third-party tracking remains prominent on both desktop and mobile clients, with Google tracking the largest percentage of websites. Consent management platforms are used on a small percentage of websites, however a lot of websites implement their own cookie consent banners. Lastly, roughly half of the websites include a privacy policy, which benefits greatly transparency towards users about data processing practices.  This is undoubtedly a step forward but there is a lot to be done. Most of the time, privacy policies are hard to read and understand and cookie consent banners manipulate users into consent. For the web to truly respect users, privacy has to be a part of conception, not an afterthought. Regulations are a good thing and it is reassuring to see them appearing worldwide but, more than that and financial sanctions, Privacy by Design should be the norm, rather than deploying texts and tools in order to avoid fines.



  
