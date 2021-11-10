---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: Privacy chapter of the 2021 Web Almanac covering adoption and impact of online tracking, privacy preference signals and browser initiatives for a privacy-friendlier web.
authors: [ydimova, victorlep]
reviewers: [maudnals]
analysts: [victorlep, max-ostapenko]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/
ydimova_bio: Yana Dimova is a PhD student at imec-DistriNet, working on web privacy. Her general interests and work focus on online tracking, privacy vulnerabilites and privacy legislation and policies.
victorlep_bio: Victor Le Pochat is a PhD researcher at the <a hreflang="en" href="https://distrinet.cs.kuleuven.be/">imec-DistriNet</a> research group of KU Leuven in Belgium. His interests lie in the exploration of web ecosystems, and in web security/privacy research metholodogy, both analyzing and improving current methods.
featured_quote: "Browsers are paving the way for better user privacy&colon; Firefox and Safari have already deployed Tracking Protection, while Chrome is proposing new privacy-protecting technologies that are discussed in the open and can be tested by website owners."
featured_stat_1: 82/83%
featured_stat_label_1: Websites that include at least one tracker
featured_stat_2: 43.02/39.7%
featured_stat_label_2: Websites that contain a privacy policy link
featured_stat_3: 4.18%
featured_stat_label_3: Popular sites opting out of FLoC cohorts
---



## Introduction

_"On the Internet, nobody knows you're a dog."_ While it might be true that you could try to remain anonymous to use the Internet as such, it can be quite hard to keep your personal data fully private. A [whole industry](https://crackedlabs.org/en/corporate-surveillance/) is dedicated to tracking users online, to build detailed user profiles for purposes such as targeted advertising, fraud detection, price differentiation, or even credit scoring. Sharing geolocation data with websites can prove very useful in day-to-day life, but may also allow them to <a hreflang="en" href="https://www.nytimes.com/interactive/2019/12/19/opinion/location-tracking-cell-phone.html">see your every movement</a>. Even if a service treats a user's private information diligently, the mere act of storing personal data provides hackers with an opportunity to <a hreflang="en" href="https://haveibeenpwned.com/">breach services and leak millions of personal records online</a>.

Recent legislative efforts such as the <a hreflang="en" href="https://ec.europa.eu/info/law/law-topic/data-protection/data-protection-eu">GDPR</a> in Europe, <a hreflang="en" href="https://www.oag.ca.gov/privacy/ccpa">CCPA</a> in California, <a hreflang="pt-br" href="https://www.gov.br/cidadania/pt-br/acesso-a-informacao/lgpd">LGPD</a> in Brazil, or the <a hreflang="en" href="https://www.meity.gov.in/data-protection-framework">PDP Bill</a> in India all strive to require companies to protect personal data and implement privacy by default, including online. Major technology companies such as Google, Facebook and Amazon have already received <a hreflang="en" href="https://en.wikipedia.org/wiki/GDPR_fines_and_notices">massive fines</a> for alleged violations of user privacy. These new laws have given users a much larger say in how comfortable they are with sharing personal data — you probably already have clicked through quite a few cookie consent banners that enable this choice. Furthermore, web browsers are implementing <a hreflang="en" href="https://privacysandbox.com/">technological solutions</a> to improve user privacy, from blocking third-party cookies over hiding sensitive data to innovative ways to balance legitimate use cases on personal attributes with individual user privacy.

In this chapter, we give an overview of the current state of privacy on the web. We first consider how user privacy can be harmed: we discuss how websites profile you through [online tracking](#how-websites-profile-you-online-online-tracking), and how they [access your sensitive data](#how-websites-handle-your-sensitive-data). We then look at the impact of tools that empower users to protect their privacy. Next, we dive into ways websites [protect sensitive data](#how-websites-protect-your-sensitive-data) and give you a choice through [privacy preference signals](#how-websites-give-you-a-privacy-choice-privacy-preference-signals). We close with an [outlook on the efforts that browsers are making to safeguard your privacy in the future](#how-browsers-are-evolving-their-privacy-approaches).


## How websites profile you online: Online tracking

The HTTP protocol is inherently stateless, so by default there is no way for a website to know whether two visits to the same website, or two visits to different websites, are from the same user. However, such information could be useful for websites to build more personalized user experiences, and for third parties building profiles of user behavior across websites for funding content on the web through targeted advertising or providing services such as fraud detection.

Unfortunately, obtaining this information currently often relies on online tracking, [around which many large and small companies have built their business](https://crackedlabs.org/en/corporate-surveillance/). This has even led to <a hreflang="en" href="https://www.forbrukerradet.no/wp-content/uploads/2021/06/20210622-final-report-time-to-ban-surveillance-based-advertising.pdf">calls to ban targeted advertising</a>, since invasive tracking is at odds with users' privacy: users might not want anyone to follow their tracks across the web, especially when visiting websites on sensitive topics. We'll look at the main companies and technologies that make up the online tracking ecosystem.


### Third-party tracking

Online tracking is often done through certain third-party libraries. These libraries usually provide some (useful) service, but in the process some of them also generate a unique identifier for each user, which can then be used to follow and profile users across websites. The <a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a> project is dedicated to discovering the most widely deployed online trackers. We use WhoTracksMe's classification of trackers, but restrict ourselves to four <a hreflang="en" href="https://whotracks.me/blog/tracker_categories.html">categories</a>: advertising, pornvertising, site analytics and social media.

We see that Google-owned domains are prevalent in the online tracking market, namely in site analytics. Google Analytics, which reports website traffic, is present on almost two thirds of all websites. Around 30% of sites include Facebook libraries, while other trackers only reach single-digit percentages. Overall, 82% of mobile sites and 83% of desktop sites include at least one tracker, usually for site analytics or advertising purposes. Three out of four websites have fewer than 10 trackers, but there is a long tail of sites with many more trackers: one desktop site contacted 133 (!) distinct trackers.



{{ figure_markup(
  image="most_common_trackers.png",
  caption="10 most popular trackers and their prevalence",
  description="Bar chart showing the 10 most popular trackers and the percentage of websites that include them.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=290736860&format=interactive",
  sheets_gid="1466954359",
  sql_file="most_common_trackers.sql"
  )
}}

{{ figure_markup(
  image="most_common_tracker_categories.png",
  caption="Percentage of websites that use each tracker category",
  description="Bar chart showing the most popular tracker categories and the number of websites embedding a tracker from that category.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1126546581&format=interactive",
  sheets_gid="2084631443",
  sql_file="most_common_tracker_categories.sql"
  )
}}

{{ figure_markup(
  image="nb_websites_with_nb_trackers.png",
  caption="The number of trackers per website",
  description="Plot showing the number of trackers per website.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=268105548&format=interactive",
  sheets_gid="690197217",
  sql_file="nb_websites_with_nb_trackers.sql"
  )
}}




### Third-party cookies

The main technical approach to store and retrieve cross-site user identifiers is through cookies that are persistently stored in your browser. Note that while third-party cookies are often used for cross-site tracking, they can also be used for non-tracking use cases, like state sharing for a third-party widget across sites. We searched for the cookies that appear most often while browsing the web, and the domains that set them. Google's subsidiary DoubleClick takes the top spot by setting cookies on 31.4% of desktop websites and 28.86% on mobile websites. Another major player is Facebook, which stores cookies on over 21% of websites. Most of the other top domains setting cookies are related to online advertising.



{{ figure_markup(
  image="top100_domains_that_set_cookies_via_response_header.png",
  caption="Most popular tracker domains that set cookies",
  description="Chart showing the percentage of websites that include a cookie set via the response header for the 10 most popular tracking domains setting cookies.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=932933299&format=interactive",
  sheets_gid="1256177287",
  sql_file="top100_domains_that_set_cookies_via_response_header.sql"
  )
}}


Looking at the specific cookies that these websites set, the most common cookie from a tracker is the `test_cookie` from doubleclick.net. The next most common cookies are advertising-related and remain on a user's device much longer: Facebook's `fr` cookie persists for <a hreflang="en" href="https://www.facebook.com/policy/cookies/">90 days</a>, while DoubleClick's `IDE` cookie stays for <a hreflang="en" href="https://business.safety.google/adscookies/">13 months in Europe and 2 years elsewhere</a>.



{{ figure_markup(
  image="top100_cookies_set_from_header.png",
  caption="10 most popular cookies set from header",
  description="Chart showing the name of the cookies set on the largest number of websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=293333315&format=interactive",
  sheets_gid="1599373042",
  sql_file="top100_cookies_set_from_header.sql"
  )
}}


With `Lax` becoming the default value of the <a hreflang="en" href="https://web.dev/samesite-cookies-explained/">`SameSite` cookie attribute</a>, sites that want to continue sharing third-party cookies across websites must explicitly set this attribute to `None`. For third parties, 85% have done this so far on mobile and 64% on desktop, potentially for tracking purposes. You can read more about the `SameSite` cookie attribute over at the [Security](./security) chapter.


### Fingerprinting

With the rise of privacy-protecting tools such as ad blockers and initiatives to phase out third-party cookies from major browsers such as [Firefox](https://blog.mozilla.org/en/products/firefox/todays-firefox-blocks-third-party-tracking-cookies-and-cryptomining-by-default/), <a hreflang="en" href="https://webkit.org/blog/10218/full-third-party-cookie-blocking-and-more/">Safari</a>, and by 2023 also <a hreflang="en" href="https://blog.google/products/chrome/updated-timeline-privacy-sandbox-milestones/#:~:text=Chrome%20could%20then%20phase%20out%20third-party%20cookies%20over%20a%20three%20month%20period%2C%20starting%20in%20mid-2023%20and%20ending%20in%20late%202023">Chrome</a>, trackers are looking for more persistent and stealthy ways to track users across sites. One such technique is _browser fingerprinting_. A website collects information about the user's device, such as the <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Glossary/User_agent">user agent</a>, screen resolution and installed fonts, and uses the often unique combination of those values to create a _fingerprint_. This fingerprint is recreated every time a user visits the website, and can then be matched to identify the user. While this method can be used for fraud detection, it is also used to persistently track recurring users, or to track users across sites.

Detecting fingerprinting is complex: it is effective through a combination of method calls and event listeners that may also be used for non-tracking purposes. Instead of focusing on these individual methods, we therefore focus on five popular libraries that make it easy for a website to implement fingerprinting. From the percentage of websites using these third-party services, we can see that the most widely used library, <a hreflang="en" href="https://fingerprintjs.com/">Fingerprint.js</a>, is used 19 times more on desktop than the second most popular library. However, the overall percentage of websites that use an external library to fingerprint their users is quite small.




{{ figure_markup(
  image="nb_websites_using_each_fingerprinting.png",
  caption="Websites using each fingerprinting library",
  description="Chart showing the percentage of websites that include each of the third-party fingerprinting libraries.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1537414997&format=interactive",
  sheets_gid="1785016530",
  sql_file="nb_websites_using_each_fingerprinting.sql"
  )
}}



### CNAME tracking

Continuing with techniques that circumvent blocks on third-party tracking, <a hreflang="en" href="https://medium.com/nextdns/cname-cloaking-the-dangerous-disguise-of-third-party-trackers-195205dc522a">CNAME tracking</a> is a novel approach where a first-party subdomain redirects to a third-party tracker using a CNAME record at the [DNS level](https://adguard.com/en/blog/cname-tracking.html). From the viewpoint of the browser, everything happens within a first-party context, so none of the third-party countermeasures are applied. Major tracking companies such as Adobe and Oracle are <a hreflang="en" href="https://sciendo.com/article/10.2478/popets-2021-0053">already offering CNAME tracking solutions</a> to their customers.

The most popular company performing CNAME-based tracking is <a hreflang="en" href="https://www.pardot.com/">Pardot</a>, which is present on 6619 desktop websites. Also notable in size is Adobe, with 2671 publisher domains.



{{ figure_markup(
  image="nb_sites_with_cname_tracking.png",
  caption="Websites using CNAME-based tracking on a desktop client",
  description="Chart showing the number of websites that use a CNAME-based tracker, ordered by the popularity of the tracker.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1887798671&format=interactive",
  sheets_gid="1286114815",
  sql_file="nb_sites_with_cname_tracking.sql"
  )
}}


When we look at the rank of the websites that use CNAME-based tracking, we see that 4.2% of the top 1,000 websites embed a CNAME tracker. In the top 10,000, that number falls to 3.33% of websites.



{{ figure_markup(
  image="nb_sites_with_cname_tracking_per_rank.png",
  caption="Number of websites that use CNAME-based tracking according to the their rank.",
  description="Chart showing the number of websites that use CNAME-based tracking divided by their popularity rank on the desktop client.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=231210750&format=interactive",
  sheets_gid="518784663",
  sql_file="nb_sites_with_cname_tracking_per_rank.sql"
  )
}}


Apart from the `.com` suffix, a large number of the websites using CNAME-based tracking have a `.jp` domain. Also a notable amount of CNAME trackers are prevalent on `.uk` and `.fr` websites.

{{ figure_markup(
  image="nb_sites_with_cname_tracking_per_public_suffix.png",
  caption="Number of websites with public suffix that use CNAME-based tracking",
  description="Chart showing the number of websites that use CNAME-based tracking on a desktop client, according to the public suffix of the website.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=432551848&format=interactive",
  sheets_gid="1155429637",
  sql_file="nb_sites_with_cname_tracking_per_public_suffix.sql"
  )
}}


CNAME-based tracking is resorted to when the user might have enabled tracking protection against third-party tracking. Since few tracker-blocking tools and <a hreflang="en" href="https://www.cookiestatus.com/">browsers</a> have already implemented a defense against CNAME tracking, it is prevalent on a number of websites up to date.


### (Re)targeting

Ad retargeting refers to the practice of keeping track of the products that a user has looked at but has not purchased, and following up with ads about these products on different websites. Instead of opting for an aggressive marketing strategy while the user is visiting, the website chooses to nudge the user into buying the product by continuously reminding them of the brand and product. A number of trackers provide a solution for ad retargeting. The most widely used one, Google Remarketing Tag, is present on 26.92% of websites on desktop and 26.64% of websites on mobile.





{{ figure_markup(
  image="nb_websites_using_each_retargeting.png",
  caption="Percentage of pages using a retargeting service",
  description="Chart showing the most popular services used for retargeting and the number of wesites that use them.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=882622568&format=interactive",
  sheets_gid="1940290757",
  sql_file="nb_websites_using_each_retargeting.sql"
  )
}}



## How websites handle your sensitive data

Some websites request access to specific features and browser APIs that can impact the user's privacy, for instance by accessing the geolocation data, microphone, camera, etc. While these features usually serve very useful purposes, such as discovering nearby points of interest or allowing people to communicate with each other, there is a risk of exposing sensitive data if the user does not fully understand how those resources are used, or if a site misbehaves. We'll look at how often websites request access to sensitive resources. Moreover, any time a service stores sensitive data, there is the danger of hackers stealing and leaking that data. We'll look at recent data breaches that prove that this danger is real.


### Device sensors

Sensors can be useful to make a website more interactive, but could also be abused for <a hreflang="en" href="https://www.esat.kuleuven.be/cosic/publications/article-3078.pdf">fingerprinting users</a>. The graph shows the most commonly accessed sensor events, based on the use of JavaScript event listeners. The orientation of the device is accessed the most, both on mobile and on desktop clients. Note that we searched for the presence of event listeners on websites, but we do not know if the code is actually executed. Therefore, the access to device sensor events in this section is an upper bound.



{{ figure_markup(
  image="nb_websites_with_device_sensor_events.png",
  caption="5 most used sensor events",
  description="Bar chart showing the most widely accessed sensor events, based on the use of JavaScript listeners.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=40988621&format=interactive",
  sheets_gid="1513080238",
  sql_file="nb_websites_with_device_sensor_events.sql"
  )
}}



### Media devices

The MediaDevices API can be used to access connected media input such as cameras, microphones and screen sharing. On 7.23% of websites, the `enumerateDevices()` method is called, which provides a list of the connected input devices.



{{ figure_markup(
  image="nb_websites_with_mediadevices_blink_usage.png",
  caption="Percentage of websites that request information to media devices",
  description="Bar chart showing the percentage of websites that use the enumerateDevices() method to obtain information about the connected media devices.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1398654768&format=interactive",
  sheets_gid="2141743069",
  sql_file="nb_websites_with_mediadevices_blink_usage.sql"
  )
}}



### Geolocation-as-a-service

Geolocations services provide GPS and other location data of the user (such as <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Glossary/IP_Address">IP address</a>) and can be used by trackers to provide more relevant content to the user among other things.
Therefore, we analyze the use of geolocation-as-a-service technologies on websites, based on libraries detected through [Wappalyzer](./methodology#wappalyzer). We find that the most popular service, <a hreflang="en" href="https://www.ipify.org/">ipify</a>, is used on 0.09% of desktop websites and 0.07% of mobile websites.



{{ figure_markup(
  image="nb_websites_using_each_geolocation.png",
  caption="Percentage of websites that use geolocation services",
  description="Chart that shows the percentage of websites using each of the geolocation service libraries.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2115506749&format=interactive",
  sheets_gid="1274602607",
  sql_file="nb_websites_using_each_geolocation.sql"
  )
}}


According to our data, few websites utilize geolocation services. Geolocation data can also be accessed by websites through a <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API">web browser API</a>.
We find that 0.59% of websites on a desktop client and 0.63% of websites on a mobile client access the current position of the user (based on [Blink features](./methodology#blink-features)), as can be seen in graph {add ref to graph}.


{{ figure_markup(
  image="nb_websites_with_geolocation_blink_usage.png",
  caption="Percentage of websites that use geolocation features",
  description="Bar chart that shows the percentage of websites using each geolocation feature.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1513111756&format=interactive",
  sheets_gid="1110372680",
  sql_file="nb_websites_with_geolocation_blink_usage.sql"
  )
}}



### Data breaches

Poor security management within a company can have a significant impact on its customers' private data. <a hreflang="en" href="https://haveibeenpwned.com/">HaveIBeenPwned</a> allows users to check whether their email address or phone number was leaked in a data breach. Up until now, HaveIBeenPwned has tracked 562 breaches, leaking 640 million records. In 2020, 40 domains were breached and personal data about millions more users leaked, as we show in {add ref to graph?}.Breaches that are _sensitive_ in nature refer to the possibility of a negative impact on the user, if someone were to find that user's data in the breach. One example of a sensitive breach is "[Carding Mafia](https://www.vice.com/en/article/v7m9jx/credit-card-hacking-forum-gets-hacked-exposing-300000-hackers-accounts)", a platform where stolen credit cards are traded.

<p class="note">Note that 40 breaches in the previous year is a lower bound, since many breaches are only discovered, or made public, several months after they have occurred.</p>


{{ figure_markup(
  image="data_breaches_pwned_websites_per_date_and_breach_sensitivity.png",
  caption="Data breaches in the previous year and their sensitivity",
  description="Chart that shows the number of domains involved in a breach over the course of the previous year and the sentitivity of the data breach.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2029950563&format=interactive",
  sheets_gid="1435927653",
  sql_file="data_breaches_pwned_websites_per_date_and_breach_sensitivity.sql"
  )
}}


{{ figure_markup(
  image="data_breaches_pwned_accounts_per_class.png",
  caption="Number of impacted accounts in breaches per data class",
  description="Bar chart showing the number of user accounts involved in data breaches, according to the data class that leaked in the breach.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1612339126&format=interactive",
  sheets_gid="1158689200",
  sql_file="data_breaches_pwned_accounts_per_class.sql"
  )
}}


The email addresses of users are leaked in _every_ breach. This is already a huge privacy risk, since many users employ their full name or credentials to set up their email address. Furthermore, a lot of other highly sensitive information is leaked in some breaches, such as users' genders, bank account numbers and even full physical addresses.


## How websites protect your sensitive data

While you're browsing the web, there is certain data that you might want to keep private: the web pages that you visit, any sensitive data that you enter into forms, your location, and so on. Over at the [Security](./security) chapter, you can learn how 92.5% of desktop sites have enabled HTTPS to protect your data from snooping while it traverses the Internet. Here, we'll focus on how websites can further instruct browsers to ensure privacy for sensitive resources.


### Permissions Policy / Feature Policy

The <a hreflang="en" href="https://www.w3.org/TR/permissions-policy-1/">Permissions Policy</a> (previously Feature Policy) provides a way for websites to define which web features they intend to use, and which features will need to be explicitly approved by the user — when requested by third parties for instance. This gives websites control over what features embedded third-party scripts can request to access; for example, a permissions policy can be used by a website to ensure that no third-party requests microphone access on their site. The policy allows developers to granularly choose web APIs they intend to use, by specifying them with the `allow` attribute.

The most commonly used directives with relation to the feature policy are shown below. On 3049 websites on mobile and 2901 websites on desktop, the use of the microphone feature is specified. Other often accessed features are geolocation, camera and payment.



{{ figure_markup(
  image="most_common_featurepolicy_permissionspolicy_directives.png",
  caption="Number of websites accessing a feature policy directive",
  description="Bar chart showing the most common directives used to define the feature policy and the number of websites that are using them.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1180513630&format=interactive",
  sheets_gid="899874026",
  sql_file="most_common_featurepolicy_permissionspolicy_directives.sql"
  )
}}


To gain a deeper understanding of how the directives are used, we looked at the top 3 most used directives and the distribution of the values assigned to these directives.



{{ figure_markup(
  image="most_common_featurepolicy_permissionspolicy_directive_values.png",
  caption="Values used for the most popular feature policy directives",
  description="Bar chart showing the distribution of the values assigned to the 3 most popular directives for the feature policy.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=280518522&format=interactive",
  sheets_gid="436267650",
  sql_file="most_common_featurepolicy_permissionspolicy_directive_values.sql"
  )
}}


`none` is the most used value. This specifies that the feature is disabled in top-level and nested browsing contexts. The second most used value, `self` is used to specify that the feature is allowed in the current document and within the same origin, while `*` allows cross-origin access.


### Referrer Policy

HTTP requests may include the optional `Referer` header, which indicates the origin or web page URL a request was made from.
The `Referer` header might be present in different types of requests:

* Navigation requests, when a user clicks a link.
* Subresource requests, when a browser requests images, iframes, scripts, and other resources that a page needs.

For navigations and iframes, this data can also be accessed via JavaScript using `document.referrer`.

The `Referer` value can be insightful. But when the full URL including the path and query string is sent in the `Referer` across origins, this can be privacy-hindering: URLs can contain private information—sometimes even identifying or sensitive information. Leaking this silently across origins can compromise users' privacy, and pose security risks.
Therefore, the <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy">`Referrer-Policy`</a> HTTP header allows developers to restrict what referrer data is made available for requests made from their site.

We show the most commonly assigned values to the `Referrer-Policy` header below.
A first point to note is that most sites do not explicitly set a referrer policy.
Only 11.2% of desktop websites and 10.4% of mobile websites explicitly define a referrer policy. The rest of them (the other 88.8% on desktop and 89.6% on mobile) will fall back to the browser's default policy. <a hreflang="en" href="https://web.dev/referrer-best-practices/#default-referrer-policies-in-browsers">Most major browsers</a> use a default policy of `strict-origin-when-cross-origin` (see <a hreflang="en" href="https://blog.mozilla.org/security/2021/03/22/firefox-87-trims-http-referrers-by-default-to-protect-user-privacy/">Firefox</a> and <a hreflang="en" href="https://developers.google.com/web/updates/2020/07/referrer-policy-new-chrome-default">Chrome)</a>. `strict-origin-when-cross-origin` removes the path and query fragments of the URL on cross-origin requests, which reduces security and privacy risks.



{{ figure_markup(
  image="nb_websites_with_referrerpolicy.png",
  caption="Percentage of websites that specify a referrer policy",
  description="Bar chart showing the percentage of websites that use a referrer-policy according to how the websites specified the policy.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2144839216&format=interactive",
  sheets_gid="1720798838",
  sql_file="nb_websites_with_referrerpolicy.sql"
  )
}}


The most common referrer policy that is explicitly set is `no-referrer-when-downgrade`. It's set on 3.38% of websites on mobile clients and 3.81% of websites on desktop clients. `no-referrer-when-downgrade` is not privacy-enhancing. With this policy, full URLs of pages a user visits on a given site are shared in cross-origin requests, which makes this information accessible to other parties (origins).

In addition, around 0.5% of websites set the value of the referrer policy to `unsafe-url`, which allows the origin, host and query string to be sent with _any_ request, regardless of the security level of the receiver. In this case, a referrer could be sent in the clear, potentially leaking private information. Worryingly, sites are actively being configured to enable this behavior.

{{ figure_markup(
  image="most_common_referrerpolicy_values.png",
  caption="Percentage of pages using referrer policy values",
  description="Bar chart showing the percentage of pages that use each referrer policy value.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1467607776&format=interactive",
  sheets_gid="1846818406",
  sql_file="most_common_referrerpolicy_values.sql"
  )
}}


Note: Websites may also send the referrer information as a URL parameter to the destination site. We did not measure usage of that mechanism for this report.


### User-Agent Client Hints

When a web browser makes an HTTP request, it will include a <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent">`User-Agent` header</a> that provides information about the client's browser, device and network capabilities. However, this can be abused for profiling users or uniquely identifying them through [fingerprinting](#fingerprinting). <a hreflang="en" href="https://wicg.github.io/ua-client-hints/">User-Agent Client Hints</a> enable access to the same information as the `User-Agent` string, but in a more privacy-preserving way. This will in turn enable browsers to eventually reduce the amount of information provided by default by the `User-Agent` string, as Chrome is proposing with a gradual plan for <a hreflang="en" href="https://www.chromium.org/updates/ua-reduction">User Agent Reduction</a>.

Servers can indicate their support for these client hints by specifying the `Accept-CH` header. This header lists the attributes that the server requests from the client in order to serve a device-specific or network-specific resource. In general, client hints provide a way for servers to obtain only the minimum information necessary to serve content in an efficient manner.

However, at this point, few websites have implemented client hints. We also see a big difference between the use of client hints on popular websites and on less popular ones. 3.6% of the top 1,000 most popular websites request client hints. In the top 10,000 websites, the implementation rate drops to less than 1.4%.



{{ figure_markup(
  image="nb_websites_with_user_agent_client_hints.png",
  caption="Percentage of pages that use user agent client hints",
  description="Bar chart showing the percentage of pages that use user agent client hints according to the rank of the website.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2107002085&format=interactive",
  sheets_gid="190615661",
  sql_file="nb_websites_with_user_agent_client_hints.sql"
  )
}}



## How websites give you a privacy choice: Privacy preference signals

In light of the recent introduction of privacy regulations, such as the <a hreflang="en" href="https://ec.europa.eu/info/law/law-topic/data-protection/data-protection-eu">GDPR</a> in Europe, <a hreflang="en" href="https://www.oag.ca.gov/privacy/ccpa">CCPA</a> in California, <a hreflang="pt-br" href="https://www.gov.br/cidadania/pt-br/acesso-a-informacao/lgpd">LGPD</a> in Brazil, the <a hreflang="en" href="https://www.meity.gov.in/data-protection-framework">PDP Bill</a> in India, and more, websites are required to obtain explicit user consent about the collection of personal data for any non-essential features such as marketing and analytics. Therefore, websites turned to the use of cookie consent banners, privacy policies and other mechanisms (which have <a hreflang="en" href="https://sciendo.com/article/10.2478/popets-2021-0069">evolved over time</a>) to inform users about what data these sites process, and give them a choice. In this section, we look at the prevalence of such tools.


### Consent Management Platforms

Consent Management Platforms (CMPs) are third-party libraries that websites can include to provide a cookie consent banner for users. We saw around 7% of websites using a Consent Management Platform. The most popular libraries are <a hreflang="en" href="https://www.cookieyes.com/">CookieYes</a> and <a hreflang="en" href="https://www.osano.com/">Osano</a>, but we found more than twenty different libraries that allow websites to include cookie consent banners. Each library was only present on a small share of websites, at less than 2% each.



{{ figure_markup(
  image="nb_websites_with_cmp.png",
  caption="Percentage of websites that use a consent management platform",
  description="Bar chart showing the percentage of websites that use a third-party library for consent management.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=246947280&format=interactive",
  sheets_gid="147308043",
  sql_file="nb_websites_with_privacy_service.sql"
  )
}}


{{ figure_markup(
  image="nb_websites_using_each_cmp.png",
  caption="10 most popular consent management platforms",
  description="Bar chart showing tthe percentage of pages using the 10 most popular third-party libraries for providing consent management.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=619927070&format=interactive",
  sheets_gid="387302670",
  sql_file="nb_websites_using_each_cmp.sql"
  )
}}



### IAB's Consent Frameworks

The <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency and Consent Framework</a> (TCF) is an initiative of the Interactive Advertising Bureau Europe for providing an industry standard for communicating user consent to advertisers. The framework consists of a Global Vendor List, in which vendors can specify the legitimate purpose of the processed data, and a list of CMPs who act as an intermediary between the vendors and the publishers. Each CMP is responsible for communicating the legal basis and storing the consent option provided by the user in the browser. We refer to the stored cookie as the "consent string".

TCF is meant as a GDPR-compliant mechanism in Europe, although [a recent decision by the Belgian Data Protection Authority](FIXME # https://iabeurope.eu/all-news/update-on-the-belgian-data-protection-authoritys-investigation-of-iab-europe/ or https://www.iccl.ie/news/online-consent-pop-ups-used-by-google-and-other-tech-firms-declared-illegal/) found that this system is still infringing. When the CCPA came into play in California, IAB Tech Lab US developed a <a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">CCPA Compliance Framework for Publishers & Technology Companies</a> (USP), using the same concepts.

Below, we show the distribution of the usage of both versions of TCF and of USP. Note that the crawl is US-based, therefore we do not expect many websites to have implemented TCF. This is depicted in the graph: less than 2% of websites use any TCF version, while twice as many websites use the US Privacy framework.



{{ figure_markup(
  image="nb_websites_with_iab.png",
  caption="Percentage of websites using IAB compliance frameworks",
  description="Bar chart showing the percentage of webites using each compliance framework of both IAB Europe and US.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1697790298&format=interactive",
  sheets_gid="1662197018",
  sql_file="nb_websites_with_iab.sql"
  )
}}

In the 10 most popular consent management platforms that are part of the framework, at the top we find <a hreflang="en" href="https://www.quantcast.com/products/choice-consent-management-platform/">Quantcast</a> with 0.34% on mobile and 0.32% on desktop. Other popular solutions are <a hreflang="en" href="https://www.didomi.io/">Didomi</a> and Wikia, with 0.3% and 0.23% on mobile and desktop respectively.



{{ figure_markup(
  image="most_common_cmps_for_iab_tcf_v2.png",
  caption="10 most popular consent management platforms for IAB ",
  description="Bar chart showing the 10 most popular consent management platforms used for IAB's compliance frameworks.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2085725571&format=interactive",
  sheets_gid="692122193",
  sql_file="most_common_cmps_for_iab_tcf_v2.sql"
  )
}}


In the USP framework, the website's and user's privacy settings are encoded in a "<a hreflang="en" href="https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md">privacy string</a>". As shown in the following graph, the most common privacy string is `1---`. This indicates that CCPA does not apply to the website and therefore the website not obliged to provide an opt-out for the user. CCPA only applies to companies whose main business involves selling personal data, or to companies that process data and have an annual turnover of more than $25 million. The second most recurring string is `1YNY`. This indicates that the website provided "notice and opportunity to opt-out of sale of data", but that the user has _not_ opted out of the sale of their personal data.


{{ figure_markup(
  image="most_common_strings_for_iab_usp.png",
  caption="Percentage of websites using IAB US privacy strings",
  description="Bar chart showing the percentage of websites that use each privacy string for IAB US' consent framework.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2039463193&format=interactive",
  sheets_gid="1524219137",
  sql_file="most_common_strings_for_iab_usp.sql"
  )
}}



### Privacy policies

Nowadays, most websites have a privacy policy, where users can learn about the types of information that is stored and processed about them. By looking for keywords such as 'privacy policy', 'cookie policy', and more, in a <a hreflang="en" href="https://github.com/RUB-SysSec/we-value-your-privacy/blob/master/privacy_wording.json">number of languages</a>, we see that almost 40% of websites refer to some sort of privacy policy. While some websites are not required to have such a policy, many websites handle personal data and should therefore have a privacy policy to be fully transparent towards their users.



{{ figure_markup(
  image="nb_websites_with_privacy_links.png",
  caption="Percentage of websites with privacy policy link",
  description="Bar chart showing the percentage of websites that include a link to a privacy policy, based on the use of privacy policy keywords.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=659763990&format=interactive",
  sheets_gid="473955086",
  sql_file="nb_websites_with_privacy_links.sql"
  )
}}



### Do Not Track - Global Privacy Control

The <a hreflang="en" href="https://www.eff.org/issues/do-not-track">Do Not Track</a> (DNT) HTTP header can be used to communicate to websites that a user does not wish to be tracked. We can see the number of sites that appear to access the current value for DNT below, based on the presence of the <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/API/Navigator/doNotTrack">`Navigator.doNotTrack`</a> JavaScript call.

Around the same percentage of pages on mobile and desktop clients use DNT. However, in practice hardly any websites actually respect the DNT opt-outs. The Tracking Protection Working Group, which specifies DNT, <a hreflang="en" href="https://www.w3.org/2016/11/tracking-protection-wg.html">closed down</a> in 2018, due to <a hreflang="en" href="https://lists.w3.org/Archives/Public/public-tracking/2018Oct/0000.html">"lack of support"</a>. Safari then <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-12_1-release-notes#:~:text=Removed%20support%20for%20the%20expired%20Do%20Not%20Track">stopped supporting DNT</a>.

{{ figure_markup(
  image="nb_websites_with_dnt_blink_usage.png",
  caption="Percentage of website using DNT",
  description="Bar chart showing the percentage of websites that access the value of DNT by using the NavigatorDoNotTrack feature.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1302428398&format=interactive",
  sheets_gid="485103492",
  sql_file="nb_websites_with_dnt_blink_usage.sql"
  )
}}


DNT's successor <a hreflang="en" href="https://globalprivacycontrol.org/">Global Privacy Control</a> (GPC) was released in October 2020 and is meant to provide a more enforceable alternative, with the hopes of better adoption. This privacy preference signal is implemented with a single bit in all HTTP requests. We did not yet observe any uptake, but we can expect this to improve in future as <a hreflang="en" href="https://www.washingtonpost.com/technology/2021/10/26/global-privacy-control-firefox/">major browsers are now starting to implement GPC</a>.


## How browsers are evolving their privacy approaches

Given the push to better protect users' privacy while browsing the web,major browsers are implementing new features that should better safeguard users' sensitive data. We already covered ways in which browsers have started enforcing more privacy-preserving default settings for [`Referrer-Policy` headers](#referrer-policy) and [`SameSite` cookies](#third-party-cookies). Furthermore, Firefox and Safari seek to block tracking through <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/Privacy/Tracking_Protection">Enhanced Tracking Protection</a> and <a hreflang="en" href="https://webkit.org/tracking-prevention/">Intelligent Tracking Prevention</a> respectively. Beyond blocking trackers, Chrome has launched the <a hreflang="en" href="https://privacysandbox.com/">Privacy Sandbox</a> to develop new web standards that provide more privacy-friendly functionality for various use cases, such as advertising and fraud protection. We'll look more closely at these up-and-coming technologies that are designed to reduce the opportunity for sites to track users.


### Privacy Sandbox

To seek ecosystem feedback, early and experimental versions of Privacy Sandbox APIs are made available initially behind <a hreflang="en" href="https://www.chromium.org/developers/how-tos/run-chromium-with-flags">feature flags</a> for testing by individual developers, and then in Chrome via <a hreflang="en" href="https://developer.chrome.com/blog/origin-trials/">origin trials</a>. Sites can take part in these origin trials to test experimental web platform features, and give feedback to the web standards community on a feature's usability, practicality, and effectiveness, before it's made available to all websites by default.

**Disclaimer:** Origin trials are only available for a limited amount of time. The numbers below represent the state or Privacy Sandbox origin trials at the time of this writing, in October 2021.


### FLoC

One of the most hotly debated Privacy Sandbox experiments has been <a hreflang="en" href="https://privacysandbox.com/proposals/floc">Federated Learning of Cohorts</a>, or FLoC for short. The origin trial for FLoC ended in July 2021.

Interest-based ad selection is commonly used on the web. FLoC provided an API to meet that specific use case without the need to identify and track individual users. FLoC has taken some <a hreflang="en" href="https://www.economist.com/the-economist-explains/2021/05/17/why-is-floc-googles-new-ad-technology-taking-flak">flak</a>: [Firefox](https://blog.mozilla.org/en/privacy-security/privacy-analysis-of-floc/) and <a hreflang="en" href="https://www.theverge.com/2021/4/16/22387492/google-floc-ad-tech-privacy-browsers-brave-vivaldi-edge-mozilla-chrome-safari">other Chromium-based browsers</a> have declined to implement it, and the <a hreflang="en" href="https://www.eff.org/deeplinks/2021/03/googles-floc-terrible-idea">Electronic Frontier Foundation</a> has voiced concerns that it might introduce new privacy risks. However, FLoC was a first experiment. Future iterations of the API could alleviate these concerns and see wider adoption.

With FLoC, instead of assigning unique identifiers to users, the browser determined a user's _cohort_: a group of thousands of people who visited similar pages and may therefore be of interest to the same advertisers.

Since FLoC was an experiment, it was not widely deployed. Instead, websites could test it by enrolling in an origin trial. We found 62 and 64 websites that tested FLoC across desktop and mobile respectively.

Here is how the first FloC experiment worked: as a user moved around the web, their browser used the FLoC algorithm to work out its _interest cohort_, which was the same for thousands of browsers with a similar recent browsing history. The browser recalculated its cohort periodically, on the user's device, without sharing individual browsing data with the browser vendor or other parties. When working out its cohort, a browser was choosing between cohorts that <a hreflang="en" href="https://www.chromium.org/Home/chromium-privacy/privacy-sandbox/floc#:~:text=web%20pages%20on%20sensitive%20topics">didn't reveal sensitive categories</a>.

Individual users and websites could opt out of being included in the cohort calculation.
We saw that 4.1% of the top 1,000 websites have opted out of FLoC. Across all other websites, around 1% have opted out.



{{ figure_markup(
  image="nb_websites_with_floc_opt_out.png",
  caption="Percentages of websites that opt out of FLoC cohorts",
  description="Bar chart showing the percentage of pages that opt out of FLoC cohorts, according to the rank of the website.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=129384991&format=interactive",
  sheets_gid="637590731",
  sql_file="nb_websites_with_floc_opt_out.sql"
  )
}}



### Other Privacy Sandbox experiments

Within the Privacy Sandbox, a number of experiments are in various stages of development.

The <a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/attribution-reporting/">Attribution Reporting API</a> (previously called Conversion Measurement) makes it possible to measure when user interaction with an ad leads to a conversion — for example, when an ad click eventually led to a purchase. We saw the first origin trial (which ended in October 2021) enabled on 10 origins.

<a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/fledge/">FLEDGE</a> seeks to address ad targeting. The API can be tested in current versions of Chrome <a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/fledge/">locally by individual developers</a> but there is no origin trial as of October 2021.

<a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/">Trust Tokens</a> enable a website to convey a limited amount of information from one browsing context to another to help combat fraud, without passive tracking. We saw the first <a hreflang="en" href="https://developer.chrome.com/blog/third-party-origin-trials/">origin trial</a> (which will end in May 2022) enabled on 7 origins that are likely embedded in a number of sites as third-party providers.

<a hreflang="en" href="https://github.com/WICG/CHIPS">CHIPS (Cookies Having Independent Partitioned State)</a> allows websites to mark cross-site cookies as "Partitioned", putting them in a separate cookie jar per top-level site. (Firefox has already introduced the similar <a hreflang="en" href="https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/">Total Cookie Protection</a> feature for cookie partitioning.) As of October 2021, there is no origin trial for CHIPS.

<a hreflang="en" href="https://github.com/shivanigithub/fenced-frame">Fenced Frames</a> protect frame access to data from the embedding page. As of October 2021, there is no origin trial.

Finally, <a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/first-party-sets/">First-Party Sets</a> allow website owners to define a set of distinct domains that actually belong to the same entity. Owners can then set a `SameParty` attribute on cookies that should be sent across cross-site contexts, as long as the sites are in the same first-party set. A first origin trial ended in September 2021. We saw the `SameParty` attribute on a few thousand cookies.



{{ figure_markup(
  image="same_party_cookie_attribute.png",
  caption="Percentage of cookies with the SameParty cookie attribute",
  description="Bar chart showing the percentage of cookies with the SameParty cookie attribute according to the request context.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=935824621&format=interactive",
  sheets_gid="858972835",
  sql_file=""
  )
}}



## Conclusion

Users' privacy remains at risk on the web today: over 80% of all websites have some form of tracking enabled, and novel tracking mechanisms such as CNAME tracking are being developed. Some sites also handle sensitive data such as geolocation, and if they're not careful, potential breaches could result in users' personal data being exposed.

Fortunately, increased awareness about the need for privacy on the web has led to concrete action. Websites now have access to features that allow them to safeguard access to sensitive resources. Legislation across the globe enforces explicit user consent for sharing personal data. Websites are implementing privacy policies and cookie banners to comply. Finally, browsers are proposing and developing innovative technologies to continue supporting use cases such as advertising and fraud detection in a more privacy-friendly way.

Ultimately, users should be empowered to have a say in how their personal data is treated. Meanwhile, browsers and website owners should develop and deploy the technical means to guarantee that users' privacy is protected. By incorporating privacy throughout our interactions with the web, users can feel more certain that their personal data is well protected.
