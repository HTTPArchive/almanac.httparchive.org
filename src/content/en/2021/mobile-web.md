---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Mobile Web
description: Mobile Web chapter of the 2021 Web Almanac covering page web vitals, images, technology adoption, accessibility and more.
authors: [fellowhuman1101, dwsmart, ashleyish]
reviewers: [obto, fili]
analysts: [rvth, obto]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1mdma245ja_THTBApaJTeS4vmLY_Fn8VC6Kd8qx7wp-o/
fellowhuman1101_bio: Jamie Indigo isn’t a robot, but speaks bot.  As a technical SEO consultant at <a href="https://www.deepcrawl.com">Deepcrawl</a>, they study how search engines crawl, render, and index the web.  They love to tame wild JavaScript frameworks and optimize rendering strategies. When not working, Jamie likes horror movies, graphic novels, and Dungeons & Dragons.
dwsmart_bio: Dave Smart is a developer and technical search engine consultant at <a href="https://tamthebots.com">Tame the Bots</a>. They love building tools and experimenting with the modern web, and can often be found at the front in a gig or two.
featured_quote: In 2021, the perception of a distinct "mobile web" is outdated. Across multiple data sources, it seems that the mobile is one of many ways a user can interact with digital content.
featured_stat_1: 18.4%
featured_stat_label_1: Mobile page loads using native lazy-loading
featured_stat_2: 43.4%
featured_stat_label_2: Mobile page loads contain inappropriately sized images
featured_stat_3: 45.03%
featured_stat_label_3: Of the top 1000 mobile page loads prevent zooming
unedited: true
---


## Introduction

In January 2021, 59.5% of the global population was on the internet.  Of the global 4.66 billion active internet users, [92.6% accessed the internet on a mobile device](https://www.statista.com/statistics/617136/digital-population-worldwide/).

With the ubiquity of mobile web tucked in our pockets, [Statista](https://www.statista.com/statistics/330695/number-of-smartphone-users-worldwide/) reports that 80.76% of the global population owns a smartphone.  This is a relatively minor growth of 0.03% year over year. In comparison, 49.40% of the population in 2016 owned a smartphone.

In this chapter, we take a look at recent trends on the mobile web including worldwide connectivity, technology adoption, and mobile-friendly feature usage..


### A note on methodology

When considering the challenge of how to categorize tablet experiences in relation to the mobile web, we decided to omit the data set from our analysis.  Often, tablet data will be grouped into desktop or mobile.  There is no uniform standard as to which it should default.


### A note on our data sources

We’ve used a few different data sources in this chapter:



* CrUX
* HTTP archive
* Lighthouse
* Wappalyzer
* [Akamai](https://twitter.com/paulcalvano/status/1454866401781587969)

It is worth noting that HTTP Archive and Lighthouse data is limited to the data identified from websites’ home pages only, and not site-wide.


## Worldwide connectivity

2021 is another year affected by the global COVID-19 pandemic, which has both affected different regions of the world differently, and the measures to combat the pandemic have varied from area to area too. Has this changed how people use their mobile devices vs. laptops & computers?


### Cost of Mobile Web Access

The financial cost of mobile web access varied greatly in 2021.  One [analysis](https://www.cable.co.uk/mobiles/worldwide-data-pricing/) showed that the average price of 1GB cost only $0.05 USD in Israel.  The same data cost usage in Equatorial Guinea would cost a user $49.67 USD.

Data from the Performance chapter shows the median site now weighs 2205kb.  Using market data, [What Does My Site Cost](https://whatdoesmysitecost.com/#usdCost) calculated the best case scenario price to load the median site.

The most expensive paid loads cost Canadian users $0.26USD, followed by Brazil at $0.18USD.  The same page  loaded on a commonly available data plan in Poland or Russia would barely register on a users' bill, costing less than $0.01 USD.


### Traffic to a site from mobile versus desktop (CrUX)

What percentage of traffic comes from  mobile devices vs. desktop? Predicting this for any individual site can be hard, and the type of site and the industry it is in can vastly change the make-up of these different users.


#### Traffic Use by Popularity

{{ figure_markup(
  caption="Percent of the  817,4923 origins in the July 2021 data received more mobile traffic than desktop traffic.",
  content="77.35%",
  classes="big-number",
  sheets_gid="601797488",
  sql_file="mobile_greater_than_desktop.sql"
)
}}

New this year, the CrUX dataset allows us to query the most popular sites ([ranked by magnitude](https://developers.google.com/web/updates/2021/03/crux-rank-magnitude),  by traffic recorded to th%ese origins).

{{ figure_markup(
  image="mobile-web-more-mobile-than-desktop-traffic.png",
  caption="Percentage of Sites with more Mobile than Desktop Traffic",
  description="Bar chart showing the breakdown of sites that have more mobile traffic than desktop, grouped by CrUX magnitude",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=787161132&format=interactive",
  sheets_gid="601797488",
  sql_file="mobile_greater_than_desktop.sql"
  )
}}


When grouped by CrUX ranking, (the top 1000, 10,000 and so on origins by traffic in the dataset) the more traffic a site receives,  there is a slight increase of the percentage of traffic it gets from mobile, all except the top 1000, which get slightly less (84.90% vs. 85.08%) mobile vs. desktop.


#### Traffic Distribution


   {{ figure_markup(
   image="mobile-web-mobile-traffic-distribution.png",
   caption="Distribution of mobile vs other traffic",
   description="Chart showing how mobile is the majority of traffic for most websites. 50% of websites analyzed receive 79.44% or more of their traffic from mobile devices, an increase from 77.61% in 2020.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=2123612862&format=interactive",
   sheets_gid="1909852444",
   sql_file="mobile_traffic_distribution.sql"
   )
   }}


The distribution shows a similar, mobile heavy trend. At the 50th Percentile, **79.44%** of traffic comes from mobile devices, an increase over **77.61%** in 2020, and catching up with the **79.93%** percentage in 2019.


#### Beyond CrUX Data

A limitation of the CrUX dataset is that it can only collect data from Chrome users, who are signed in, have syncing enabled and have not disabled the "Make searches and browsing better / Sends URLs of pages you visit to Google" setting. This means that:



* Other major browsers, like FireFox and Safari are missing
* There is no data from iOS users at all (Chrome uses WebKit on iOS, like all other browsers on iOS devices)

Fortunately there are a few other sources. Paul Calvano ran some analysis on the [Akamai  mPulse](https://www.akamai.com/products/mpulse-real-user-monitoring)real user monitoring data for July 2021. It found a slightly more even match between Mobile and Desktop traffic, at **59.4%** being from mobile devices. The mPulse data is aggregated hourly, so it reveals some interesting trends


##### Not all days are equal



   {{ figure_markup(
   image="mobile-web-akimai-device-distribution-by-day.png",
   caption="Device type distribution by day - mPulse July 2021",
   description="Mobile vs. Desktop traffic distribution, by the day of the week, from Akimai's mPulse in July 2021",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1981057164&format=interactive",
   sheets_gid="634917379"
   )
   }}



Weekend days show a greater proportion of Mobile traffic, with 66.06% on Saturdays, **66.54%** on Sundays, and a slight increase to **59.06%**. Globally, not every country have Monday - Friday work weeks, Sunday - Thursday is another common pattern, (source: [Wikipedia](https://en.wikipedia.org/wiki/Workweek_and_weekend))


##### Not all times are equal

On weekdays, mobile usage dips vs. desktop usage around 5 am UTC and starts climbing again at 7pm UTC (with a small bump around 10 / 11am). This aligns with working hours.

{{ figure_markup(
   image="mobile-web-akimai-device-distribution-by-hour-weekdays.png",
   caption="Device type distribution by hour on weekend - mPulse July 2021",
   description="Mobile vs. Desktop traffic distribution, by the hour of the day on weekdays, in UTC, from Akimai's mPulse in July 2021",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=12081105&format=interactive",
   sheets_gid="300179855",
   width="600",
   height="480"
   )
   }}

On weekends the split between mobile and desktop traffic remains more stable.
{{ figure_markup(
   image="mobile-web-akimai-device-distribution-by-hour-weekends.png",
   caption="Device type distribution by hour on weekend - mPulse July 2021",
   description="Mobile vs. Desktop traffic distribution, by the hour of the day on Saturdays and Sundays, in UTC, from Akimai's mPulse in July 2021",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1776273851&format=interactive",
   sheets_gid="300179855",
   width="600",
   height="480"
   )
   }}

This all suggests that people who have the choice between different devices are more likely to use mobile ones in their personal time.

 Cloudflare also released a great study. Like the Akamai data, this  study shows a much closer split between mobile and desktop devices than the CrUX dataset. In the 30 days leading up to October 4th, 52% of traffic was mobile.

 <figure>
<blockquote>We looked for, in the past month, the country with the highest proportion of mobile Internet traffic. And the answer is... Sudan, with 83% of Internet traffic is done using mobile devices — actually it’s a tie with Yemen.</blockquote>
<figcaption>— João Tomé, <cite><a hreflang="en" href="https://blog.cloudflare.com/where-mobile-traffic-more-and-less-popular/">Where is mobile traffic the most and least popular?</a></cite></figcaption>
</figure>

[Cloudflare's Radar](https://radar.cloudflare.com/) trend reports allow them to segment traffic by geographic region, and it's interesting to see the variations regionally between the split of mobile vs. desktop, from Sudan and Yemen tying at 83% usage, compared to the Seychelles at just 29% mobile.


#### Drawing Conclusions

Mobile device usage remains strong, and It's apparent that despite a global trend of people being at home more than ever before, due to restrictions and advice from health authorities and governments, that mobile devices remain the  most popular way to access websites. The popularity of mobile over desktop seems to have regained most of the ground lost last year (itself a fairly small regression).

Naturally the figures cannot tell us the reasons behind that, but it's worth remembering that for a large amount of web users, mobile devices may be the only device available to them, and there is no choice between using a mobile or a desktop.

Whilst it can be hard to predict if your mobile traffic percentage is expected, if it seems low vs. your region and sector, it could be an indication you are under-serving this portion of your user base.


## Mobile methodology & tech stacks


### Client Hints

[Client Hints](https://developer.mozilla.org/en-US/docs/Glossary/Client_hints) are a collection of HTTP request header fields a server can request from the client accessing it to get information on the device, it's capabilities, the network conditions and other agent settings and preferences.

This gives the ability to make decisions and serve code, content and experience that's more tailored to that device.

For the mobile web, poor network conditions and lower powered devices are much more common, and sites that are proactively requesting this information are likely to be thinking beyond merely squeezing down their desktop pages to fit on a mobile screen.

HTTP client hints are a relatively new, and somewhat experimental feature, with the [RFC only published in February this year](https://www.rfc-editor.org/rfc/rfc8942#section-3.1). It's therefore fairly encouraging that we found **1. 41%** of sites are requesting at least one of these Client Hints from mobile users, compared with just **0.95%** for desktop users.

Whilst we are not able to tell what the sites might do with that information, and exactly how they use these hints to tailor the experience to mobile users, asking is a good first sign.

These hints can be roughly assigned into three groups:



* **Device client hints**
Details of the capabilities and features of the device accessing the site.
* **Network client hints**
Details of the network connection between the device and the server.
* **User Agent Hints**
Details about the agent accessing the site.


#### Device client hints

{{ figure_markup(
   image="mobile-web-usage-of-device-client-hints.png",
   caption="Usage of Device Client Hint Directives",
   description="Bar chart showing the usage of device client hint directives detected on mobile and desktop page loads",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=663083561&format=interactive",
   sheets_gid="1041308066",
  sql_file="client_hints.sql"
   )
}}


Uptake here is low, with [DPR](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/DPR) & [Viewport-Width](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Viewport-Width) leading with **0.15%** of mobile sites requesting this, [Device-Memory](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Device-Memory) a little behind at **0.14%** and [Width](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Width)at just **0.01%**, but this is now deprecated, the proposed replacement being Sec-CH-Width, we detected no sites requesting this.

Currently, only Chrome, (and Chromium based browsers like Microsoft's Edge) & Opera support these headers, with Safari and Firefox not yet onboard (source: [CanIUse.com](https://caniuse.com/client-hints-dpr-width-viewport)).


#### Network client hints

{{ figure_markup(
   image="mobile-web-usage-of-network-client-hints.png",
   caption="Usage of Network Client Hint Directives",
   description="Bar chart showing the usage of network client hint directives detected on mobile and desktop page loads",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=172140786&format=interactive",
   sheets_gid="1041308066",
  sql_file="client_hints.sql"
   )
}}


Network client hints show a similar uptake to Device client hints, with [Downlink](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Downlink)and [ECT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ECT) (effective connection type) being requested by **0.15%** of loads on mobile, and [RTT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/RTT) (round trip time) on 0.14% of loads on mobile.

Save-Data is surprisingly present less, at just 0.08% of mobile requests, seemingly a missed opportunity, given the user benefits possible, as detailed in the Google Web Fundamentals article, [Delivering Fast and Light Applications with Save-Data](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/save-data/).


#### User Agent Hints

Major browsers like Chrome (Source: [Chromium Blog](https://blog.chromium.org/2021/05/update-on-user-agent-string-reduction.html)), Safari (Source: [WebKi Bugzilla](https://bugs.webkit.org/show_bug.cgi?id=216593)) and FireFox (source: [Mozilla Bugzilla](https://bugzilla.mozilla.org/show_bug.cgi?id=1679929)) reducing and capping the User-Agent string to reduce [passive fingerprinting](https://www.w3.org/2001/tag/doc/unsanctioned-tracking/#unsanctioned-tracking-tracking-without-user-control).

Traditionally, sites may have used this information to tailor the experience to those devices. This approach has always had some drawbacks in trying to keep up with the ever changing landscape of devices, and the fact the user-agent string is easily changeable and spoofable.

User Agent Client hints offer a way to get  this information, but unlike the Device and Network Hints do not require the server to request this via the Accept-CH header. This is perhaps why we detected only a tiny handful of sites requesting this.


### Network Information API and Device Memory API Usage

The [Network Information API](https://developer.mozilla.org/en-US/docs/Web/API/Network_Information_API) and [Navigator.deviceMemory](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/deviceMemory) offer an interface to JavaScript to gather device and connection information, similar in scope to those exposed with Client Hints.


#### Network Information API

{{ figure_markup(
   image="mobile-web-usage-of-networkinformation-effectivetype.png",
   caption="Usage of NetworkInformation.effectiveType",
   description="Bar chart showing the usage of NetworkInformation.effectiveType API, detected on mobile and desktop page loads",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=844974484&format=interactive",
   sheets_gid="277973945",
  sql_file="network_info_effective_type_usage.sql"
   )
}}


We focused of mobile vs. desktop page loads making use of [NetworkInformation.effectiveType](https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation/effectiveType), which returns a string based on the effective connection type, 'slow-2g', '2g', '3g', or '4g'. 4g is the top tier, so could really be seen as 4g or faster, including 5g and broadband, fixed connections.

**18.19%** of mobile requests had page loads utilising NetworkInformation.effectiveType, but surprisingly, a very slightly higher **18.41%** of desktop requests detected use of this API


#### Device Memory API

{{ figure_markup(
   image="mobile-web-usage-of-navigator-devicememory.png",
   caption="Usage of Navigator.deviceMemory",
   description="Bar chart showing the usage of Navigator.deviceMemoryAPI, detected on mobile and desktop page loads",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=634683822&format=interactive",
   sheets_gid="1309485612",
  sql_file="navigator_device_memory_usage.sql"
   )
}}

This api returns an approximate amount of device memory, useful to judge what the client might be capable of handling and adapt accordingly.

**10.88%** of mobile page loads utilised this api, slightly higher than **10.19%** for desktop loads.

Much like Client Hints, these APIs are still experimental, and also do not have universal support across browsers.  (source: [Network Information API](https://caniuse.com/netinfo) & [Navigator API: deviceMemory](https://caniuse.com/mdn-api_navigator_devicememory) caniuse.com) but have much wider adoption.

One reason for wider adoption could be third party scripts requesting these on page loads. Another reason may be ease of implementation. Setting and reading http headers may be seen as more complex and more likely to involve  changes to infrastructure.


### Client Hints, Network Information API and Device Memory API Conclusions

For experimental APIs and features, there is already some encouraging take up of these features, hopefully as browser support growns and the APIs move from experimental status, uptake will grow further.

If you have a network or device capability limited web app, and you have a significant proportion of users accessing from lower powered devices, and / or poor network connections, now might be the time to investigate if these APIs can let you offer a better user experience for them.


### App usage on the Mobile Web

The most commonly used libraries and technologies found on the mobile web impact performance and inform us on technology adoption.

According to [Wappalyzer](https://www.wappalyzer.com/) data, JavaScript library JQuery is the dominant library of the mobile web, present in 84.38% of tested sites.  Google is the dominant provider, holding three of the top five spots.

<figure>
<table>
  <thead>
    <tr>
      <th scope="col">App</th>
      <th scope="col">Percentage Mobile Sites with App</th>
      <th scope="col">Percentage Desktop Sites with App</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>jQuery</td>
      <td>84.38%</td>
      <td>84.38%</td>
    </tr>
    <tr>
      <td>Google Analytics</td>
      <td>65.40%</td>
      <td>68.64%</td>
    </tr>
    <tr>
      <td>PHP</td>
      <td>50.46%</td>
      <td>50.46%</td>
    </tr>
    <tr>
      <td>Google Font API</td>
      <td>47.56%</td>
      <td>47.56%</td>
    </tr>
    <tr>
      <td>Google Tag Manager</td>
      <td>43.37%</td>
      <td>43.37%</td>
    </tr>
  </tbody>
</table>

<figcaption>{{ figure_link(caption="Popular Technology Usage.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>


Of the top five mobile web technologies, adoption rates for three were higher on desktop sites.

<figure>
<table>
  <thead>
    <tr>
      <th scope="col">App</th>
      <th scope="col">Diff Desktop v Mobile use</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>jQuery</td>
      <td>1.02%</td>
    </tr>
    <tr>
      <td>Google Analytics</td>
      <td>3.24%</td>
    </tr>
    <tr>
      <td>PHP</td>
      <td>-0.38%</td>
    </tr>
    <tr>
      <td>Google Font API</td>
      <td>-0.13%</td>
    </tr>
    <tr>
      <td>Google Tag Manager</td>
      <td>2.60%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="Technologies - Mobile Vs. Desktop Uptake.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

JavaScript library JQuery is the dominant library of the mobile web, present in 84.38%.  Google is the dominant provider, holding three of the top five spots.  The most


#### Programming languages

The most prominent programming language on the mobile web is PHP with 50.46% of tested sites using the language.  There is a large gap between PHP and the next most prevalent, Java, which appeared on 3.95% of sites.

<figure>
<table>
  <thead>
    <tr>
      <th scope="col">Language</th>
      <th scope="col">Percentage of Mobile Page Loads</th>
      <th scope="col">Percentage of Desktop Page Loads</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>PHP</td>
      <td>50.46%</td>
      <td>50.08%</td>
    </tr>
    <tr>
      <td>Java</td>
      <td>3.95%</td>
      <td>2.75%</td>
    </tr>
    <tr>
      <td>Python</td>
      <td>3.57%</td>
      <td>2.18%</td>
    </tr>
    <tr>
      <td>Node.js</td>
      <td>1.68%</td>
      <td>1.87%</td>
    </tr>
    <tr>
      <td>Ruby</td>
      <td>1.12%</td>
      <td>1.53%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="Prominent Mobile vs. Desktop Programming Languages.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>


Content management systems allow site owners to publish, update, and control content through an authenticated backend.   WordPress, an open-source CMS written in PHP, was the dominant CMS in 2021.  The technology appeared on 33.57% of sites.


#### Content Management Systems

The top five content management systems on the mobile web in 2021 were:

<figure>
<table>
  <thead>
    <tr>
      <th scope="col">CMS</th>
      <th scope="col">Percentage of Mobile Page Loads</th>
      <th scope="col">Percentage of Desktop Page Loads</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>WordPress</td>
      <td>33.57%</td>
      <td>32.94%</td>
    </tr>
    <tr>
      <td>Joomla</td>
      <td>1.95%</td>
      <td>1.74%</td>
    </tr>
    <tr>
      <td>Drupal</td>
      <td>1.76%</td>
      <td>2.12%</td>
    </tr>
    <tr>
      <td>Wix</td>
      <td>1.64%</td>
      <td>1.22%</td>
    </tr>
    <tr>
      <td>Squarespace</td>
      <td>1.01%</td>
      <td>1.24%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="Prominent Mobile vs. Desktop CMS.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>



#### Web Servers

The most prevalent web servers powering the mobile web in 2021 were Apache at 30.53% and Nginx at 29.66%.


#### Comparing Desktop Technology Adoption Rates

Technology adoption rates for the mobile web moved in step with desktop.  The most notable difference  came in the form of third-party pixel use.  68.64% of desktop sites used Google Analytics compared to 65.40% of mobile sites.

<figure>
<table>
  <thead>
    <tr>
      <th scope="col">Category</th>
      <th scope="col">Percentage of Desktop Page Loads</th>
      <th scope="col">Percentage of Mobile Page Loads</th>
      <th scope="col">% higher Desktop Adoption Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Analytics</td>
      <td>Google Analytics</td>
      <td>68.64%</td>
      <td>65.40%</td>
      <td>3.24%</td>
    </tr>
    <tr>
      <td>Tag managers</td>
      <td>Google Tag Manager</td>
      <td>45.97%</td>
      <td>43.37%</td>
      <td>2.60%</td>
    </tr>
    <tr>
      <td>Analytics</td>
      <td>Facebook Pixel</td>
      <td>20.56%</td>
      <td>18.86%</td>
      <td>1.70%</td>
    </tr>
    <tr>
      <td>Widgets</td>
      <td>Facebook</td>
      <td>27.95%</td>
      <td>26.32%</td>
      <td>1.63%</td>
    </tr>
    <tr>
      <td>JavaScript libraries</td>
      <td>jQuery UI</td>
      <td>23.77%</td>
      <td>22.24%</td>
      <td>1.53%</td>
    </tr>
  </tbody>
</table>

<figcaption>{{ figure_link(caption="Technology with higher desktop adoption rates.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>


Given the changes to performance measurement and prioritization, it's reasonable to consider the absence of these JavaScript-heavy third party assets as part of an intentional effort to improve mobile page experience.  The Facebook Pixel analytics script was found on -1.70% fewer mobile sites than desktop.

Mobile sites were more likely to adopt certain technologies, but with a smaller margin.  Blogger was found on 3.13% of mobile sites and 1.67% of desktop sites

<figure>
<table>
  <thead>
    <tr>
      <th scope="col">Category</th>
      <th scope="col">Percentage of Desktop Page Loads</th>
      <th scope="col">Percentage of Mobile Page Loads</th>
      <th scope="col">% higher Mobile Adoption Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Blogs</td>
      <td>Blogger</td>
      <td>1.67%</td>
      <td>3.13%</td>
      <td>1.46%</td>
    </tr>
    <tr>
      <td>Web servers</td>
      <td>OpenGSE</td>
      <td>1.71%</td>
      <td>3.16%</td>
      <td>1.45%</td>
    </tr>
    <tr>
      <td>Programming languages</td>
      <td>Python</td>
      <td>2.18%</td>
      <td>3.57%</td>
      <td>1.39%</td>
    </tr>
    <tr>
      <td>Programming languages</td>
      <td>Java</td>
      <td>2.75%</td>
      <td>3.95%</td>
      <td>1.19%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="Technology with higher mobile adoption rates.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>



#### Drawing Conclusions on Mobile Web App Usage

JavaScript via JQuery permeated the mobile web in 2021.  Third-party analytics tools had a lower adoption rate on mobile.

One thing that shines through in the data is that at a CMS and web server level, mobile and desktop share a close correlation in how people develop sites, perhaps in large part to the lower overheads of responsive design, meaning one codebase for all experiences.

With WordPress not only maintaining, but extending its popularity for mobile sites, and other CMSs enjoying a similar share to the desktop experience, there's a great opportunity for CMS core improvements and optimisations to bring an outsized benefit to the whole mobile web.

This makes drives like the [proposed WordPress Performance Team](https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/) important and valuable.


## Interacting with the Mobile Web

Attention to mobile design and friendliness are critical to reducing friction in the user journey.  Users navigate the mobile web with taps of their fingers rather than the more refined control provided by a mouse or trackpad.


### Alternative Protocol Links

The web is built on links.  On the mobile web, Unique Resource Identifier schemes beyond http/s, can allow users to complete tasks like dialing a phone number or starting an email with minimal friction.

The most prevalent URI schemes were https, found on 93.15% of sites, and it's non-secure equivalent, http, appearing on 56.65%.  The high use of non-secure link protocols is noteworthy as 2020 saw major announcements from browsers to protect users' safety by alerting them when content is not secure.

After webpage links, the next five most used protocols in  anchor href values  on the mobile web are as follows:

<figure>
<table>
  <thead>
  <th scope="col">URI Protocol</th>
    <th scope="col">Percent of Mobile Page Loads</th>
    </thead>
  <tbody>
    <tr>
      <td><code>mailto:</code></td>
      <td>28.25%</td>
    </tr>
    <tr>
      <td><code>tel:</code></td>
      <td>24.21%</td>
    </tr>
    <tr>
      <td><code>whatsapp:</code></td>
      <td>0.61%</td>
    </tr>
    <tr>
      <td><code>viber:</code></td>
      <td>0.46%</td>
    </tr>
    <tr>
      <td><code>skype:</code></td>
      <td>0.30%</td>
    </tr>
  </tbody>
</table>

<figcaption>{{ figure_link(caption="Popular alternative protocol links.", sheets_gid="115658247", sql_file="popular_link_protocols.sql") }}</figcaption>
</figure>

Mobile devices whilst limited in some aspects do tend to be better connected, they are a phone, have SMS and other messaging services where desktop clients may not. Usage of other link protocols past the standard http / https can help unlock some of these capabilities. Providing a tapable link to call or send a message without having to copy and paste makes for a smoother, more integrated user interaction.


#### mailto

`mailto:` invokes the users chosen email client, clicking:
```
<a href="mailto:enquiries@example.com?subject=Enquiring about Red Widgets">enquiries@example.com</a>
```
Would prefill an email with the specified email address and subject line. Helpful on mobile, but probably pretty relevant for desktop too.


#### tel

`tel:` invokes a call:
```
<a href="tel:+44123467890">Call +44 (0)123 4567890</a>
```
Would open the phone app, ready to dial that number.  This saves copy / paste and reduces friction if your business values phone leads or enquiries.


#### sms

`sms:` invokes the clients default SMS messaging app:
```
<a href="sms:+441234567890>Text Us</a>
```
When clicked would prefill a message with the right number, you can also prefill the message body.  This fell out of the top 5, with just **0.27%** of mobile site loads utilizing this.


#### Other Messaging Apps

Other messaging apps can register a protocol to have a `<a href="">` open them, as seen in the table above, whats app & viber are the two leading ones here, outstripping the native sms: app usage.


#### Alternative Protocol Links Conclusions

`mailto:` has a long history on the internet, [right back to 1994](https://datatracker.ietf.org/doc/html/rfc1738#section-3), but it's encouraging to see tel: reach 24% usage, not a long way behind, given its additional usefulness on mobile devices.

It's surprising to see sms with such small uptake, and disappointing that its uptake is  below proprietary apps like whatsapp and viber.

SMS is more likely to be available as default and require no additional installations, so seemingly more accessible.

 However whatsapp and viber messages are free, SMS messages may incur charges from the users mobile provider. This could explain that relative popularity.

If you aren't using some of the extended capabilities for communication that protocols past https can offer your users, and it's a good fit for your mobile website, these could offer a simple, user friendly, low development benefit.


### Input Fields

While URI schemes allow users to take actions from a website, input fields allow users to provide information to a website.

Input elements are one of the most powerful and complex features in HTML.  Input elements are used to create interactive controls for web based forms.  Web users experience these elements such as buttons, checkboxes, calendars, search, and other elements which allow control of a page's content based on user input.

71.48% of mobile pages tested contained inputs.  This is slightly higher than the 71.14% of desktop.


#### Type Declarations

We can track occurrences of interactive controls created by input by looking for the "type" attribute.  The type attribute is the most important because it controls how the input element works. The type input value was declared on 70.92% of tested sites.

If the type attribute is not present the input defaults to text, a single line text field.  In analysis of pages using input elements, 27.06% of pages did not declare an input type and used the default text string value.

Out of all pages using inputs, 72.59% contained at least one text input type.  This was the most used.

If the type attribute is not present the input defaults to text, a single line text field.  In analysis of pages using input elements, 27.06% of pages did not declare an input type and used the default text string value.

The declared text value combined with the fallback value indicates that 99.65% of sites using input elements capture a text value.


#### Advanced Input Types

Of pages with at least one input, 44.8% of them use one or more "advanced input types".  Advanced input types include color, date, datetime-local, email, month, number, range, reset, search, tel, time, url, week, datalist.


##### Telephone

Similarly, 5.40% of pages asked users for their telephone number.  For mobile users, navigating from the alpha to numeric keyboard is a high friction point.  62.60% of pages soliciting a telephone number used an input field missing the type=tel value.


##### Email

The email input type requires the user to submit a valid email address.  A non-email value entered in the form prompts an error to  display when the form is submitted.

25.08% of pages contained at least one field asking users for their email.

Email collection is often a key micro conversion in the user journey so capturing it with minimal friction benefits the site with a higher conversion rate.  Even with this clear business value, 42% of pages which ask for user emails do not use the type=email input type on at least one instance.


##### Search Input

Site search is a powerful tool in navigating users to their desired content.  Search inputs are text fields functionally identical to text. The main difference between search and text input fields is how they are handled by the browser and accessibility tools.

Use of the search input type can trigger a cross icon which allows users to quickly clear existing query text.  Many modern browsers also store search queries across domains.  When the search type is denoted, stored queries can be used to autocomplete the field.

23.88% of tested pages contained a search input field.  It is worth noting that these fields may be present though using a text or undeclared input type.  This is a slight increase over 2020 which saw 17% of sites using search input.

Business value appears to impact input type adoption.  Ecommerce sites have a vested interest in swiftly moving users to a desired product in order to meet the business goal of a transaction.

43.31% of tested ecommerce sites use search input on their mobile experience.  Interestingly, this is higher than 42.63% of sites using the input type for desktop clients.


#### Autocomplete

The [autocomplete](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) attribute allows some control over how forms and inputs work with browsers autofill features. There are a number of options, from disabling it entirely, to providing hints as to what to autofill, like a name, or street address.

Inputting text and data on mobile devices is a generally more tedious process than on a device with a full keyboard, so autofill becomes an even more useful and time saving feature than for desktop users.  Google discovered a 25% increase in form submission when autofill is used. (source: [Keynote by Darin Fisher, VP of Chrome (Chrome Dev Summit 2015) video on YouTube](https://www.youtube.com/watch?v=m2a9hlUFRhg&t=1433s))

For mobile page loads, **24.8%** of pages utilized the autocomplete attribute, lower than the **27%** of desktop page loads.

As the http archive data captures only homepages, usage could be much higher in checkout, contact and other places that are likely to require inputs, but it is perhaps disappointing to see lower usage on mobile experiences, where arguably it is the most useful.


### Input field Conclusions

Input type declarations are critical in reducing friction.  If an input element is marked up using the appropriate type, input elements can prompt different keyboards to improve the experience.  The boon to user experience makes the low-lift adoption of input types a meaningful investment.

The low rates of adoption for input types like telephone and email are surprising given the ubiquity of input fields on the mobile web.  This gap between business goals and the user experience illustrates that user experience on the mobile web is critical.  The greatest opportunities from websites may not come from in-house feature development, but rather leveraging the growing functionalities natively available in modern browsers.


### Accessibility on the mobile web

The pandemic forced humans around the world to isolate themselves from friends, family, and community.  The number of persons facing disabilities also increased due to [post-COVID conditions](https://www.hhs.gov/civil-rights/for-providers/civil-rights-covid19/guidance-long-covid-disability/index.html#footnote10_0ac8mdc). This shift forced digital spaces to the new default as in-person services, commerce, and communication were disrupted.

The goal of accessibility is to create web experiences which provide feature and information parity to all users.  Users on the mobile benefit from accessibility as accessibility practices make information available to people using slow internet connections, or who have limited or expensive data plans.


#### ARIA Roles

Accessible Rich Internet Applications (ARIA) is a set of attributes that supplement HTML so that commonly used interactions and widgets can be passed to assistive technologies.  These attributes are also [useful to search engines in understanding  page content](https://webaim.org/blog/web-accessibility-and-seo/).

When a site is accessed using assistive technology, an element's ARIA role communicates information about how the user can interact.

The most prevalent ARIA role in 2021 was `button` which appeared on 29% of sites.  The button role indicates a clickable element that triggers a response when activated by users.

{{ figure_markup(
   image="mobile-web-most-common-mobile-aria-roles.png",
   caption='Top 10 most common ARIA roles on mobile web. Data from the [Accessibility Chapter](/en/2021/accessibility)',
   description="Bar chart showing the most defined ARIA role on mobile page loads.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=23131628&format=interactive",
   sheets_gid="1584971419",
  sql_file="../accessibility/common_aria_role.sql"
   )
}}


While over 71% of mobile sites have interactive-controls for web based forms, the most commonly adopted ARIA attribute, aria-label, only appeared on 11.23% of tested sites. This accessibility-focused attribute is used to label input with a text string.


#### Color Contrast

A lack of color contrast impacts users with color blindness as well as low color sensitivity, a condition common in older people.  Sufficient color contrast allows for equal access to content and a positive impact to business goals.  In a case study by Google, ecommerce site Eastpak saw a [20% increase in click thru rate](https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/)  when call-to-action buttons used sufficient contrast between text color and its background.

Despite the potential for increased conversion, 77.8% of sites failed lighthouse audits for use of sufficient color contrast.  This is a slight improvement year over year.

{{ figure_markup(
  image="mobile-web-sufficient-color-contrast.png",
  caption='Mobile Sites with sufficient color contrast. Data from the [Accessibility Chapter](/en/2021/accessibility)',
  description="Bar chart showing percent of mobile page loads with a sufficient colour contrast.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1440359640&format=interactive",
  sheets_gid="1628455121",
  sql_file="../accessibility/color_contrast.sql"
  )
}}



#### Tap Targets

Tap targets are elements that respond to user input.  These include links, buttons, form fields, and many others.

In order for effective user interactions, tap targets need to be both appropriately sized and spaced apart from other tap targets on the page.  Interactive elements should be at least 48x48 pixels and have a padding of at least 8 pixels separating them from other interactive elements.

Overall, 39.3% of sites tested used sufficiently sized mobile tap targets.  Tap target adoption was consistent across domain rank groupings.  This is a slight increase from 2020, which saw 36.31% of tap targets properly sized.


#### Zoom and Scaling

The Viewport meta element is important to inform a browser how to lay out the page on a users device. It's also possible to configure this by adding the user-scalable="no" or a small maximum-scale: parameter to prevent totally, or limit the ability for users to zoom in on the content. On mobile devices, this is commonly pinch zooming.

Preventing the ability to zoom in is an issue for low vision users, and is [something that would fail](https://dequeuniversity.com/rules/axe/3.3/meta-viewport) the WCAG 2.0 guidance.

Disappointingly, **29.4%** of mobile page loads  fail this requirement, and contained a viewport that prevented zooming, this is a slight improvement over the **30.7%** (source: [2020 Web Almanac Accessibility Chapter](https://almanac.httparchive.org/en/2020/accessibility#zooming-and-scaling))

Things look even worse when looking at the usage by domain ranking.

{{ figure_markup(
   image="mobile-web-zoom-blocking-viewport-tags.png",
   caption="Disabled Zooming and Scaling by Domain Rank",
   description="Bar chart showing the percentage of mobile page loads, by rank, has a viewport that prevents zooming",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=86675708&format=interactive",
   sheets_gid="1840321233",
  sql_file="viewport_zoom_scale_by_domain_rank.sql"
   )
}}

The more popular sites are more likely to fail this, meaning that overall, more users are reaching mobile sites that are not compliant.

#### Accessibility conclusions

When the web is accessible, more people can perceive, understand, navigate, interact with, and contribute to the web.  Equal and inclusive access must be prioritized in order to keep pace with the growth and necessity of web access.

The areas we've covered here are a small part of accessibility, ARIA. zooming and colour contrasts are bare minimum requirements. A study from W3C's Web Accessibility Initiative (source: [The Business Case for Digital Accessibility](https://www.w3.org/WAI/business-case/#increase-market-reach)) show that 15% of the world's population, that's 1 billion plus people have a recognized disability, far more may go unregistered, or will develop a disability at some point in their lives that may affect their ability to access your sites. Accessibility isn't for a tiny minority.

The poor adoption of good accessibility practice creates a technical barrier to these users that should disturb us as humans, aside from the clear commercial opportunity of properly catering for this sizable group of potential users.

In many jurisdictions, accessibility is not just good practice.


<figure>
<blockquote>Last year [lawsuits related to the Americans with Disabilities Act were up 20%](https://info.usablenet.com/2020-report-on-digital-accessibility-lawsuits).</blockquote>
<figcaption>— Web Almanac <cite><a hreflang="en" href="https://almanac.httparchive.org/en/2021/accessibility">2021 Accessibility Chapter</a></cite></figcaption>
</figure>


To learn more about accessibility on the mobile web, vist the [Accessibility chapter](https://almanac.httparchive.org/en/2021/accessibility).


## Mobile Search Engine Optimisation (SEO)

For any website, acquisition is a critical step, the best optimised mobile website is no different to the worse if no one finds and visits it.

The primary avenue of discovery is quite likely to be from a search engine, along with social media and links from other websites.

With search engines being the primary source of acquisition for many sites, and a still sizeable one for many more, SEO is an important consideration for pretty much every site.

There are some mobile specific areas and concerns in SEO.


### Mobile-First Index

Google recognizes that the predominant method of accessing the web is now mobile, and now index websites predominately with a [mobile user-agent](https://developers.google.com/search/mobile-sites/mobile-first-indexing). Since July 2019, all new sites have been indexed this way, and most existing sites have now transitioned to mobile-first indexing too.

This means that if you have content or markup that's only served to desktop devices, google will no longer index that part.


### Mobile-Friendliness

Both [Google](https://developers.google.com/search/blog/2015/04/rolling-out-mobile-friendly-update)and [Bing](https://blogs.bing.com/webmaster/2015/11/12/mobile-friendly-test), amongst other search engines, use some concept of mobile friendliness  as a direct ranking signal. This mostly comprises testing to make sure that the content fits in the viewport, text is legible and tap targets are of a reasonable size.

Google offers a [mobile-friendly test](https://search.google.com/test/mobile-friendly), as does [Bing](https://www.bing.com/webmaster/tools/mobile-friendliness) to help diagnose if your pages are passing.

The recommended way of achieving this is using responsive web design, web.dev have a [great learning resource here](https://web.dev/learn/design/)


### Core Web Vitals & Page Experience

On July 15th 2021, Google announced that they were rolling out the [Page Experience Ranking Update](https://developers.google.com/search/blog/2021/04/more-details-page-experience). This comprises a few different signals, including mobile-friendliness, with the major new additions being the [Core Web Vitals metrics](https://web.dev/vitals/).

Of particular interest to the mobile web is that the core web vitals part is[mobile specific](https://support.google.com/webmasters/thread/104436075/core-web-vitals-page-experience-faqs-updated-march-2021), these metrics only play a part in the mobile results so far, although a roll out to desktop is planned in [February 2022](https://developers.google.com/search/blog/2021/11/bringing-page-experience-to-desktop).

You can learn more about the role of mobile-friendliness and the core web vitals in SEO over in the [SEO Chapter](https://almanac.httparchive.org/en/2020/seo#mobile-friendliness).


## Mobile Performance

A mobile device is likely to be lower powered, and on a slower and less reliable network connection than desktop devices. Given these circumstances, performance can be a bigger challenge and a bigger priority.


### Loading Performance

Grabbing the attention of your newly acquired user, or keeping the attention of a returning user begins with making sure they see the important content of the site quickly.


#### Largest Contentful Paint

[Largest contentful paint](https://web.dev/lcp/) (LCP) is a metric designed to capture this experience (and is one of the core web vitals). It's a measure of when the largest element in the viewport is rendered, it's limited to &lt;img>, &lt;image> inside an &lt;svg>, &lt;video> (if the poster is set), a block element with a background image, or a text block.

A LCP of 2.5 seconds or less is considered a good score.

{{ figure_markup(
  image="mobile-web-largest-contentful-paint.png",
  caption='LCP performance by device. data from the [Performance Chapter](/en/2021/performance)',
  description="Chart showing mobile and desktop page loads reaching the LCP thresholds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=875306231&format=interactive",
  sheets_gid="1682201087",
  sql_file="../performance/web_vitals_by_device.sql"
  )
}}

The data shows that just 45% of mobile page loads recorded in the CrUX dataset are meeting the 2.5 second or under target, far lower than the 60% desktop achieves.

It does represent an small improvement from 2020, where only [43% of mobile page loads](https://almanac.httparchive.org/en/2020/performance#lcp-by-device) met the 2.5 second or under threshold.

There are clearly bigger challenges to achieving good LCP scores for the mobile demographic, but one worth chasing. A recent [study from Vodafone](https://web.dev/vodafone/)showed that a reduction of just **8%** in LCP times lead to increased conversions of **31%**. Performance can have a direct effect on revenue.


### Images

Many different assets can and do affect load times on mobile, CSS & JavaScript can all play a big part. But a big factor remains images.

Too often an approach to responsive web design is to supply an image whose native size is appropriate for desktop users, and just scale it to the screen with CSS.


#### Appropriately sized images

{{ figure_markup(
  caption="percent of mobile page loads had appropriately sized images",
  content="56.6%",
  classes="big-number",
  sheets_gid="1754517886",
  sql_file="correctly_sized_images.sql"
)
}}

This is sadly a step back from 58.8% in 2020. That's 43.4% of mobile users getting the wrong size images.


#### Responsive Images

Images can be [served responsively](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images)too, the srcset attribute, and the &lt;picture> element allow appropriately sized, and appropriately formatted images to be specified, allowing the browser to download the one that best matches the screen and device.

{{ figure_markup(
   image="mobile-web-responsive-images.png",
   caption="Use of Picture and scrset to serve responsive images",
   description="Bar chart showing the percentage of mobile and desktop pages using &lt;picture> element and / or srcset attributes to load images responsively.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1030195048&format=interactive",
   sheets_gid="1802999215",
  sql_file="picture_source_srcset_usage.sql"
   )
}}

Just **6.2%** of mobile page loads that included images used the `<picture>` element, slightly lower than desktop.

A more healthy **32%** of mobile page loads including images use the `srcset` attribute. It is worth mentioning here that this attribute can be used in both the `<picture>` element and the `<img>` element, so there's likely to be some crossover here.


#### Lazy Loading

Deferring, or lazy loading,  images that aren't in the initial viewport is a good strategy to help resources be focused on loading things that are visible. The native lazy-load attribute, supported in Chrome, Opera, and from September 2021 Firefox for Android (source: [caniuse.com](https://caniuse.com/loading-lazy-attr)) allows this to happen without JavaScript work-arounds.

{{ figure_markup(
  caption='Mobile page loads that contained images used loading="lazy"',
  content="18.4%",
  classes="big-number",
  sheets_gid="1889147690",
  sql_file="lazy_loading_usage.sql"
)
}}


This is a big jump up from just 4.1% in 2020.


Looking at the http archive's [Native Image Lazy Loading Report](https://httparchive.org/reports/state-of-images#imgLazy), uptake of using the attribute on the `<img>` tag specifically shows the same, impressive growth.

{{ figure_markup(
   image="mobile-web-native-lazy-loading-over-time.png",
   caption="Usage of Lazy Loading Attribute Overtime",
   description="Chart from http archive data showing the percentage of mobile and desktop pages using the loading='lazy' attribute over time",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=62374244&format=interactive",
   sheets_gid="1889147690"
   )
}}

#### Image conclusions

It's disappointing to see that more mobile page loads this year had images that were not correctly sized. &lt;picture> uptake remains low too, perhaps based on the complexity compared to the &lt;img> element.

But great strides have been made in adoption of the loading="lazy" attribute, a huge jump in just one year.

Images remain a vital part of the web, and that doesn't change for mobile users. If your site doesn't take advantage of some of the available approaches to serve mobile appropriate images, it's time to investigate this.


### Layout Stability

With a generally smaller form factor, and limited screen real estate, unexpected shifting content can be particularly jarring on mobile devices.

Reading an article only to have the paragraph you are on jump down the screen as an ad loads in above, or shift around as a font loads in and changes before your eyes is an uncomfortable and negative experience.


#### Cumulative Layout Shift

One of the Core Web Vitals, [Cumulative Layout Shift](https://web.dev/cls/) is a metric designed to capture the impact of this kind of shifting of elements.

The metric is a calculation of impact fraction * distance fraction. The impact fraction is how much of the area of the screen is shifted, the distance fraction is how much of the screen it moved by.

A CLS score of **0.1** or under is considered good, under 0.25 considered indeed of improvement, and over that it's considered a poor experience

Smaller screen sizes are susceptible to greater shifts, at 360 x 640px, this example block causes a CLS score of **0.22**


{{ figure_markup(
  image="mobile-cls-example.gif",
  alt="GIF animation showing a mock ad block appearing on mobile",
  caption="Screen capture GIF of a mock-up showing an ad causing CLS on a mobile sized screen",
  description="The Ad insert causes a relatively large amount of content to be shifted on screen at mobile viewport sizes.",
  width=197,
  height=350
  )
}}

At desktop screen sizes, the same element appearing leads to a CLS score of just **0.07**.


{{ figure_markup(
  image="desktop-cls-example.gif",
  alt="GIF animation showing a mock ad block appearing on desktop",
  caption="Screen capture GIF of a mock-up showing an ad causing CLS on a desktop sized screen",
  description="The Aad insert causes a relatively small amount of content to be shifted on screen at desktop viewport sizes.",
  width=600,
  height=341
  )
}}



The CrUX dataset shows that 62% of mobile page loads had a CLS of **0.1** or under


{{ figure_markup(
  image="mobile-web-cumulative-layout-shift.png",
  caption='CLS performance by device. data from the [Performance Chapter](/en/2021/performance)',
  description="Chart showing mobile and desktop page loads reaching the CLS thresholds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=776500715&format=interactive",
  sheets_gid="1682201087",
  sql_file="../performance/web_vitals_by_device.sql"
  )
}}


This is a big step over the 43% achieved last year, but direct comparison is hard, as the metric changed on the [1st of June 2021](https://web.dev/evolving-cls/)to better capture the experience on long-lived pages, so some of this jump could be attributable to this.


### Response to User Interaction

When a user interacts with a site, long delays from clicking on something, to something actually happening make a website or app feel sluggish and slow. This lag between input and the action happening is often down to heavy JavaScript processes blocking the main thread, leaving the browser unable to process the command the user issued until it had completed those processes.

Mobile devices are generally much lower powered than desktop and laptops, so the effect of this can be amplified.


#### First Input Delay

[First input delay](https://web.dev/fid/) (FID) is the third Core Web Vital metric designed to capture this. It measures the time between the first interaction (a tap or a click on an element) until the browser can start processing that it has happened. It doesn't measure how long the process that tap may have triggered takes.

A good FID score is  **100ms** or under, a poor FID score is over **300ms**.

{{ figure_markup(
  image="mobile-web-first-input-delay.png",
  caption='FID performance by device. data from the [Performance Chapter](/en/2021/performance)',
  description="Chart showing mobile and desktop page loads reaching the FID thresholds.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1158252805&format=interactive",
  sheets_gid="1682201087",
  sql_file="../performance/web_vitals_by_device.sql"
  )
}}

Encouragingly, **90%** of mobile page loads in the CrUX dataset had a good FID score, up from **80%** from 2020.

Efforts are being made to better capture responsiveness, with the Chrome Speed Metrics team [sharing some plans and inviting feedback](https://web.dev/responsiveness/) on a new responsiveness metric.

If you are looking to learn more about Core Web Vitals in general, the  [performance chapter](https://almanac.httparchive.org/en/2021/performance) has plenty of details about the core web vitals.


### Service Workers

[Service workers](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API) whilst not only applying to mobile devices do become uniquely useful in their ability to add offline capabilities, and better control of loading from caches  to web apps, both features which are often more relevant to mobile users, who are more likely to encounter poor or total loss of connectivity.

**14.8%** of sites register a service worker, a sizeable uptake since 2020's **0.87%**

To learn more about service workers and PWA (progressive web apps), vist the [PWA chapter](https://almanac.httparchive.org/en/2020/pwa).


### Mobile Performance Conclusions

Overall, performance has taken a step forward over 2020, with a particularly strong improvement in layout stability.

There are some good, positive signs too in impressive usage growth in loading="lazy" and the uptake of service workers. The fact developers are embracing these is a positive sign that performance is being taken seriously.

It does however seem that improving  Large Contentful Paint, and handing images are areas developers are struggling with more than other areas. Hopefully tooling  and libraries like [next/image](https://nextjs.org/docs/api-reference/next/image) for the nextjs framework, and  adoption by popular CMSs like WordPress will help developers overcome these pain points.


## Mobile Web Conclusions

In 2021, the perception of a distinct "mobile web" is outdated.

Across multiple data sources, it seems that the mobile is one of many ways a user can interact with digital content-- and in fact comprises the majority of digital interactions.

For many users, mobile devices are their primary or only means of interacting with the web.  Despite this, adoption of methodologies, performance strategies, accessibility principles and adoption of browser-supported features is low.

There has been great progress in some areas, most performance metrics are an improvement over 2020's data. There do remain areas where there's lots of room for growth too.

Accessibility remains an area where it would be great to see more effort and time spent, and image best practices still have some way to go.

With the continuing growth and size of the mobile user sector, for many industries it's no longer a case of having to make a business case to support the mobile web, it is a case of fully embracing it and making use of the many tools and techniques available to a developer in 2021.
