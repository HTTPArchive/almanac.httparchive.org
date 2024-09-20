---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Mobile Web
description: Mobile Web chapter of the 2021 Web Almanac covering page web vitals, images, technology adoption, accessibility and more.
authors: [fellowhuman1101, dwsmart, ashleyish]
reviewers: [foxdavidj, fili]
analysts: [rvth, foxdavidj]
editors: [shantsis]
translators: []
results: https://docs.google.com/spreadsheets/d/1mdma245ja_THTBApaJTeS4vmLY_Fn8VC6Kd8qx7wp-o/
fellowhuman1101_bio: Jamie Indigo isn't a robot, but speaks bot. As a technical SEO consultant at <a hreflang="en" href="https://www.deepcrawl.com">Deepcrawl</a>, they study how search engines crawl, render, and index the web. They love to tame wild JavaScript frameworks and optimize rendering strategies. When not working, Jamie likes horror movies, graphic novels, and Dungeons & Dragons.
dwsmart_bio: Dave Smart is a developer and technical search engine consultant at <a hreflang="en" href="https://tamethebots.com">Tame the Bots</a>. They love building tools and experimenting with the modern web and can often be found at the front in a gig or two.
ashleyish_bio: Ashley Berman Hale is a technical SEO and VP of professional services at <a hreflang="en" href="https://www.deepcrawl.com">Deepcrawl</a>. She is a mom to plants, animals, and tiny humans. Ashley plays in her local roller derby league and mentors upcoming SEOs.
featured_quote: In 2021, the perception of a distinct "mobile web" is outdated. Across multiple data sources, it seems that the mobile is one of many ways a user can interact with digital content.
featured_stat_1: 18.4%
featured_stat_label_1: Mobile page loads using native lazy-loading
featured_stat_2: 43.4%
featured_stat_label_2: Mobile page loads contain inappropriately sized images
featured_stat_3: 45.0%
featured_stat_label_3: Of the top 1,000 mobile page loads prevent zooming
---

## Introduction

In January 2021, 59.5% of the global population was on the internet. Of the global 4.66 billion active internet users, <a hreflang="en" href="https://www.statista.com/statistics/617136/digital-population-worldwide/">92.6% accessed the internet on a mobile device</a>.

With the ubiquity of mobile web tucked in our pockets, <a hreflang="en" href="https://www.statista.com/statistics/330695/number-of-smartphone-users-worldwide/">Statista</a> reports that 80.8% of the global population owns a smartphone. This is a relatively minor growth of 0.0% year over year. In comparison, 49.4% of the population in 2016 owned a smartphone.

In this chapter, we looked at recent trends on the mobile web including worldwide connectivity, technology adoption, and mobile-friendly feature usage.

### A note on methodology

When considering the challenge of how to categorize tablet experiences in relation to the mobile web, we decided to omit the data set from our analysis. Often, tablet data will be grouped into desktop or mobile. There is no uniform standard as to which it should default.

### A note on our data sources

We've used a few different data sources in this chapter:

* CrUX
* HTTP Archive
* Lighthouse
* Wappalyzer
* <a hreflang="en" href="https://twitter.com/paulcalvano/status/1454866401781587969">Akamai</a>

It is worth noting that HTTP Archive and Lighthouse data is limited to the data identified from websites' home pages only, and not site-wide. Learn more in our [Methodology](./methodology) page.

## Worldwide connectivity

2021 is another year affected by the global COVID-19 pandemic, which has both affected different regions of the world differently, and the measures to combat the pandemic have varied from area to area too. Has this changed how people use their mobile devices versus laptops and computers?

### Cost of mobile web access

The financial cost of mobile web access varied greatly in 2021. <a hreflang="en" href="https://www.cable.co.uk/mobiles/worldwide-data-pricing/">One analysis</a> showed that the average price of 1 GB is only $0.05 USD in Israel. The same data cost usage in Equatorial Guinea would cost a user $49.67 USD.

Data from the Performance chapter shows the median site now weighs 2,205 KB. Using market data, <a hreflang="en" href="https://whatdoesmysitecost.com/#usdCost">What Does My Site Cost</a> calculated the best-case scenario price to load the median site.

The most expensive paid loads cost Canadian users $0.26 USD, followed by Brazil at $0.18 USD. The same page loaded on a commonly available data plan in Poland or Russia would barely register on a users' bill, costing less than $0.01 USD.

### Traffic to a site from mobile versus desktop (CrUX)

What percentage of traffic comes from mobile devices vs. desktop? Predicting this for any individual site can be hard, and the type of site and the industry it is in can vastly change the make-up of these different users.

#### Traffic use by popularity

{{ figure_markup(
    caption="Percent of the 817,4923 origins in the July 2021 data received more mobile traffic than desktop traffic.",
    content="77.4%",
    classes="big-number",
    sheets_gid="601797488",
    sql_file="mobile_greater_than_desktop.sql"
)
}}

New this year, the CrUX dataset allows us to query the most popular sites <a hreflang="en" href="https://developers.google.com/web/updates/2021/03/crux-rank-magnitude">ranked by magnitude</a>, by traffic recorded to these origins.

{{ figure_markup(
    image="mobile-web-more-mobile-than-desktop-traffic.png",
    caption="Percentage of Sites with more mobile than desktop traffic.",
    description="Bar chart showing the breakdown of sites that have more mobile traffic than desktop as grouped by rank magnitude. For sites in the top 1K origins, 84.9% have more mobile traffic. The second grouping, 10K origins, saw a higher rate of mobile traffic at 85.1%. 82.6% of 100K origins and 80.1% of top 1M origins received more traffic from mobile than desktop.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=787161132&format=interactive",
    sheets_gid="601797488",
    sql_file="mobile_greater_than_desktop.sql"
  )
}}

When grouped by CrUX ranking (the top 1,000, 10,000 and so on origins by traffic in the dataset), the more traffic a site receives, there is a slight increase of the percentage of traffic it gets from mobile, all except the top 1,000, which get slightly less (84.9% vs. 85.1%) mobile vs. desktop.

#### Traffic distribution

{{ figure_markup(
    image="mobile-web-mobile-traffic-distribution.png",
    caption="Distribution of mobile vs other traffic.",
    description="Chart showing how mobile is the majority of traffic for most websites. 50% of websites analyzed receive 79.4% or more of their traffic from mobile devices, an increase from 77.6% in 2020.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=2123612862&format=interactive",
    sheets_gid="1909852444",
    sql_file="mobile_traffic_distribution.sql"
  )
}}

The distribution shows a similar, mobile heavy trend. At the 50th percentile, 79.4% of traffic comes from mobile devices, an increase over 77.6% in 2020, and catching up with the 79.9% percentage in 2019.

#### Beyond CrUX data

A limitation of the CrUX dataset is that it can only collect data from Chrome users, who are signed in, have syncing enabled and have not disabled the _Make searches and browsing better_ / _Sends URLs of pages you visit to Google_ setting. This means that:

* Other major browsers, like Firefox and Safari are missing
* There is no data from iOS users at all (Chrome uses WebKit on iOS, like all other browsers on iOS devices)

Fortunately, there are a few other sources. <a href="./contributors#paulcalvano">Paul Calvano</a> ran some analysis on the <a hreflang="en" href="https://www.akamai.com/products/mpulse-real-user-monitoring">Akamai mPulse</a> real user monitoring data for July 2021. It found a slightly more even match between Mobile and Desktop traffic, at 59.4% being from mobile devices. The mPulse data is aggregated hourly, so it reveals some interesting trends

##### Not all days are equal

{{ figure_markup(
    image="mobile-web-akamai-device-distribution-by-day.png",
    caption="Device type distribution by day - mPulse July 2021.",
    description="Mobile vs. Desktop traffic distribution, by the day of the week, from Akamai's mPulse in July 2021 showing a noticeable 10% increase in mobile traffic at every weekend, with a similar offsetting dip in desktop traffic.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1981057164&format=interactive",
    sheets_gid="634917379"
  )
}}

Weekend days show a greater proportion of mobile traffic, climbing somewhere around 10% from around 55 - 56% to 65 - 67%. Globally, not every country has Monday to Friday work weeks -  Sunday to Thursday is also <a hreflang="en" href="https://en.wikipedia.org/wiki/Workweek_and_weekend">another common pattern</a>, something that can be seen with a slight ramp up on Fridays, leading to a bigger jump in mobile usage on Saturdays and Sundays.

##### Not all times are equal

On weekdays, mobile usage decreases, and desktop usage increases as an overall percentage of traffic. This indicates that internet users are switching between mobile and desktop devices. Around 5 AM UTC and starts climbing again at 7 PM UTC (with a small bump around 10 / 11 AM). This aligns with working hours.

{{ figure_markup(
    image="mobile-web-akamai-device-distribution-by-hour-weekdays.png",
    caption="Device type distribution by hour on weekend - mPulse July 2021.",
    description="A line chart of Mobile vs. Desktop traffic distribution, by the hour of the day on weekdays, in UTC, from Akamai's mPulse in July 2021. The patterns show that an inverse variation between mobile and desktop traffic. As traffic for one device type increases, the other decreases. Desktop usage is at its highest through what could be thought of as traditional working hours (7am - 6pm), though mobile usage is larger at all times ranging from 52% to 65%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=12081105&format=interactive",
    sheets_gid="300179855",
    width="600",
    height="480"
  )
}}

On weekends the split between mobile and desktop traffic remains more stable.

{{ figure_markup(
    image="mobile-web-akamai-device-distribution-by-hour-weekends.png",
    caption="Device type distribution by hour on weekend - mPulse July 2021.",
    description="Mobile vs. Desktop traffic distribution, by the hour of the day on Saturdays and Sundays, in UTC, from Akimai's mPulse in July 2021. This is a much flatter graph than the previous one showing little variation per hour.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1776273851&format=interactive",
    sheets_gid="300179855",
    width="600",
    height="480"
  )
}}

This all suggests that people who have the choice between different devices are more likely to use mobile ones in their personal time.

Cloudflare also released a great study. Like the Akamai data, this study shows a much closer split between mobile and desktop devices than the CrUX dataset. In the 30 days leading up to October 4th, 52% of traffic was mobile.

<figure>
  <blockquote>We looked for, in the past month, the country with the highest proportion of mobile Internet traffic. And the answer is... Sudan, with 83% of Internet traffic is done using mobile devices — actually it's a tie with Yemen.</blockquote>
  <figcaption>— João Tomé, <cite><a hreflang="en" href="https://blog.cloudflare.com/where-mobile-traffic-more-and-less-popular/">Where is mobile traffic the most and least popular?</a></cite></figcaption>
</figure>

<a hreflang="en" href="https://radar.cloudflare.com/">Cloudflare's Radar</a> trend reports allow them to segment traffic by geographic region, and it's interesting to see the variations regionally between the split of mobile vs. desktop, from Sudan and Yemen tying at 83% usage, compared to the Seychelles at just 29% mobile.

#### Drawing conclusions

Mobile device usage remains strong, and it's apparent that despite a global trend of people being at home more than ever before (due to restrictions and advice from health authorities and governments), mobile devices remain the most popular way to access websites. The popularity of mobile over desktop seems to have regained most of the ground lost last year—itself a fairly small regression.

Naturally the figures cannot tell us the reasons behind that, but it's worth remembering that for a large amount of web users, mobile devices may be the only device available to them, and there is no choice between using a mobile or a desktop.

Whilst it can be hard to predict if your mobile traffic percentage is expected, if it seems low vs. your region and sector, it could be an indication you are under-serving this portion of your user base.

## Mobile methodology & tech stacks

While mobile web is highly used, these experiences typically have less processing power and slower internet interconnectivity.  Many technologies have emerged to mitigate these limitations.  These include Client Hints and APIs that identify the connection type and serve assets best suited for the connection.

In this section we will also look at overall app usage for the mobile web and how the programming languages, content management systems, and web servers compare to desktop experiences.

### Client Hints

[_Client Hints_](https://developer.mozilla.org/docs/Glossary/Client_hints) are a collection of HTTP request header fields a server can request from the client accessing it to get information on the device, its capabilities, the network conditions and other agent settings and preferences.

This gives the ability to make decisions and serve code, content and experience that's more tailored to that device.

For the mobile web, poor network conditions and lower powered devices are much more common, and sites that are proactively requesting this information are likely to be thinking beyond merely squeezing down their desktop pages to fit on a mobile screen.

HTTP Client Hints are a relatively new, and somewhat experimental feature, with the <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8942#section-3.1">RFC only published in February this year</a>. It's therefore fairly encouraging that we found 1.4% of sites are requesting at least one of these Client Hints from mobile users, compared with just 1.0% for desktop users.

Whilst we are not able to tell what the sites might do with that information, and exactly how they use these hints to tailor the experience to mobile users, asking is a good first sign.

These hints can be roughly assigned into three groups:

* **Device Client Hints**: Details of the capabilities and features of the device accessing the site.
* **Network Client Hints**: Details of the network connection between the device and the server.
* **User-Agent Hints**: Details about the agent accessing the site.

#### Device Client Hints

{{ figure_markup(
    image="mobile-web-usage-of-device-client-hints.png",
    caption="Usage of Device Client Hint directives.",
    description="Bar chart comparing the usage of device Client Hint directives detected on mobile and desktop page loads. Desktop sites were less likely than mobile to use `device-memory`, `dpr`, or `viewport-width` Client Hints (approximately 0.10% compared to 0.15%). Usage of the `width` was equal between device types at 0.01%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=663083561&format=interactive",
    sheets_gid="1041308066",
    sql_file="client_hints.sql"
  )
}}

Uptake here is low, with [`DPR`](https://developer.mozilla.org/docs/Web/HTTP/Headers/DPR) and [`Viewport-Width`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Viewport-Width) leading with 0.15% of mobile sites requesting this, [`Device-Memory`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Device-Memory) a little behind at 0.14% and [`Width`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Width) at just 0.0%, but this is now deprecated, the proposed replacement being Sec-CH-Width, we detected no sites requesting this.

Currently, only Chrome, (and Chromium based browsers like Microsoft's Edge), and Opera support these headers, with <a hreflang="en" href="https://caniuse.com/client-hints-dpr-width-viewport">Safari and Firefox not yet onboard</a>.

#### Network Client Hints

{{ figure_markup(
    image="mobile-web-usage-of-network-client-hints.png",
    caption="Usage of Network Client Hint directives.",
    description="Bar chart showing the usage of network Client Hint directives detected on mobile and desktop page loads. Again, mobile seems higher (0.09% for desktop versus 0.15% for mobile) for most with `save-data` being used less by both at 0.04% and 0.08% respectively.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=172140786&format=interactive",
    sheets_gid="1041308066",
    sql_file="client_hints.sql"
  )
}}

Network Client Hints show a similar uptake to Device Client Hints, with [Downlink](https://developer.mozilla.org/docs/Web/HTTP/Headers/Downlink) and [ECT](https://developer.mozilla.org/docs/Web/HTTP/Headers/ECT) (effective connection type) being requested by 0.2% of loads on mobile, and [RTT](https://developer.mozilla.org/docs/Web/HTTP/Headers/RTT) (round trip time) on 0.1% of loads on mobile.

Save-Data is surprisingly present less, at just 0.1% of mobile requests, seemingly a missed opportunity, given the user benefits possible, as detailed in the Google Web Fundamentals article, <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/save-data/">Delivering Fast and Light Applications with Save-Data</a>.

#### User-Agent Client Hints

Major browsers like <a hreflang="en" href="https://blog.chromium.org/2021/05/update-on-user-agent-string-reduction.html">Chrome</a>, <a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=216593">Safari</a> and <a hreflang="en" href="https://bugzilla.mozilla.org/show_bug.cgi?id=1679929">Firefox</a> reducing and capping the `User-Agent` string to reduce <a hreflang="en" href="https://www.w3.org/2001/tag/doc/unsanctioned-tracking/#unsanctioned-tracking-tracking-without-user-control">passive fingerprinting</a>.

Traditionally, sites may have used this information to tailor the experience to those devices. This approach has always had some drawbacks in trying to keep up with the ever-changing landscape of devices, and the fact the user-agent string is easily changeable and spoofable.

_User-Agent Client Hints_ offer a way to get this information, but unlike the Device and Network Hints do not require the server to request this via the `Accept-CH` header. This is perhaps why we detected only a tiny handful of sites requesting this.

### Network Information API and Device Memory API usage

The [_Network Information API_](https://developer.mozilla.org/docs/Web/API/Network_Information_API) and [`Navigator.deviceMemory`](https://developer.mozilla.org/docs/Web/API/Navigator/deviceMemory) offer an interface to JavaScript to gather device and connection information, similar in scope to those exposed with Client Hints.

#### Network Information API

{{ figure_markup(
    image="mobile-web-usage-of-networkinformation-effectivetype.png",
    caption="Usage of `NetworkInformation.effectiveType`.",
    description="Bar chart comparing the usage of Network Client Hint Directives between desktop and mobile devices. 18.4% of desktop devices use this API compared to 18.2% of mobile devices.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=844974484&format=interactive",
    sheets_gid="277973945",
    sql_file="network_info_effective_type_usage.sql"
  )
}}

We focused of mobile vs. desktop page loads making use of [`NetworkInformation.effectiveType`](https://developer.mozilla.org/docs/Web/API/NetworkInformation/effectiveType), which returns a string based on the effective connection type, `slow-2g`, `2g`, `3g`, or `4g`. The top tier is `4g`, so could really be seen as "4g or faster", including 5g and broadband, fixed connections.

18.2% of mobile requests had page loads utilizing `NetworkInformation.effectiveType`, but surprisingly, a very slightly higher 18.4% of desktop requests detected use of this API.

#### Device Memory API

{{ figure_markup(
    image="mobile-web-usage-of-navigator-devicememory.png",
    caption="Usage of `Navigator.deviceMemory`.",
    description="Bar chart comparing the usage of `Navigator.deviceMemoryAPI` on mobile and desktop. 10.2% of desktop sites used the Device Memory API compared to 10.9% of mobile page loads.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=634683822&format=interactive",
    sheets_gid="1309485612",
    sql_file="navigator_device_memory_usage.sql"
  )
}}

This API returns an approximate amount of device memory, useful to judge what the client might be capable of handling and adapt accordingly.

10.9% of mobile page loads utilized this API, slightly higher than 10.2% for desktop loads.

Much like Client Hints, these APIs are still experimental, and also do not have universal support across browsers (source: <a hreflang="en" href="https://caniuse.com/netinfo">Network Information API</a> & <a hreflang="en" href="https://caniuse.com/mdn-api_navigator_devicememory">`Navigator.deviceMemory`</a> but have much wider adoption.

One reason for wider adoption could be third-party scripts requesting these on page loads. Another reason may be ease of implementation. Setting and reading HTTP headers may be seen as more complex and more likely to involve changes to infrastructure.

### Client Hints, Network Information API and Device Memory API conclusions

For experimental APIs and features, there are already some encouraging take up of these features. Hopefully as browser support grows and the APIs move from experimental status, uptake will grow further.

If you have a network or device capability limited web app, and you have a significant proportion of users accessing from lower powered devices, and/or poor network connections, now might be the time to investigate if these APIs can let you offer a better user experience for them.

### App usage on the mobile web

The most commonly used libraries and technologies found on the mobile web impact performance and inform us on technology adoption.

According to <a hreflang="en" href="https://www.wappalyzer.com/">Wappalyzer</a> data, JavaScript library JQuery is the dominant library of the mobile web, present in 84.4% of tested sites. Google is the dominant provider, holding three of the top five spots.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">App</th>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
        <th scope="col">Diff desktop v mobile use</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">84.4%</td>
        <td class="numeric">84.4%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Google Analytics</td>
        <td class="numeric">65.4%</td>
        <td class="numeric">68.6%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td>PHP</td>
        <td class="numeric">50.5%</td>
        <td class="numeric">50.5%</td>
        <td class="numeric">-0.4%</td>
      </tr>
      <tr>
        <td>Google Font API</td>
        <td class="numeric">47.6%</td>
        <td class="numeric">47.6%</td>
        <td class="numeric">-0.1%</td>
      </tr>
      <tr>
        <td>Google Tag Manager</td>
        <td class="numeric">43.4%</td>
        <td class="numeric">43.4%</td>
        <td class="numeric">2.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Popular technology usage.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

Of the top five mobile web technologies, adoption rates for three were higher on desktop sites.  It is reasonable to attribute lower mobile adoption rates of these apps to mobile performance initiatives as these apps are frequently flagged by Lighthouse, the open-source auditing tool recommended by Google to diagnose performance issues.

In 2021, Google added the <a href="https://developers.google.com/search/docs/advanced/experience/page-experience">Page Experience Ranking Signal</a> to its algorithm.  This ranking signal is specific to search engine results pages served on mobile devices and uses aggregated data from real user page loads to measurement performance.

JavaScript library JQuery is the dominant library of the mobile web, present in 84.4% of mobile page loads. Google is the dominant provider, holding three of the top five spots.

#### Content Management Systems

Content management systems allow site owners to publish, update, and control content through an authenticated backend. The top five content management systems on the mobile web in 2021 were:

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">CMS</th>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">33.6%</td>
        <td class="numeric">32.9%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prominent mobile vs. desktop CMS.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

WordPress, an open-source CMS written in PHP, was the dominant CMS in 2021. The technology appeared on 33.6% of sites.

#### Comparing desktop technology adoption rates

Technology adoption rates for the mobile web moved in step with desktop. The most notable difference came in the form of third-party pixel use. 68.6% of desktop sites used Google Analytics compared to 65.4% of mobile sites.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Category</th>
        <th scope="col">Technology</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">% higher desktop adoption rate</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Analytics</td>
        <td>Google Analytics</td>
        <td class="numeric">68.6%</td>
        <td class="numeric">65.4%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td>Tag managers</td>
        <td>Google Tag Manager</td>
        <td class="numeric">46.0%</td>
        <td class="numeric">43.4%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>Analytics</td>
        <td>Facebook Pixel</td>
        <td class="numeric">20.6%</td>
        <td class="numeric">18.9%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Widgets</td>
        <td>Facebook</td>
        <td class="numeric">28.0%</td>
        <td class="numeric">26.3%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>JavaScript libraries</td>
        <td>jQuery UI</td>
        <td class="numeric">23.8%</td>
        <td class="numeric">22.2%</td>
        <td class="numeric">1.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Technology with higher desktop adoption rates.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

Given the changes to performance measurement and prioritization, it's reasonable to consider the absence of these JavaScript-heavy, third-party, assets as part of an intentional effort to improve mobile page experience. The Facebook Pixel analytics script was found on -1.7% fewer mobile sites than desktop.

Mobile sites were more likely to adopt certain technologies, but with a smaller margin. Blogger was found on 3.1% of mobile sites and 1.7% of desktop sites

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Category</th>
        <th scope="col">Technology</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">% higher mobile adoption rate</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Blogs</td>
        <td>Blogger</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">3.1%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Web servers</td>
        <td>OpenGSE</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">3.2%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Programming languages</td>
        <td>Python</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td>Programming languages</td>
        <td>Java</td>
        <td class="numeric">2.8%</td>
        <td class="numeric">4.0%</td>
        <td class="numeric">1.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Technology with higher mobile adoption rates.", sheets_gid="1172584192", sql_file="most_used_tech_by_domain_rank.sql") }}</figcaption>
</figure>

#### Drawing conclusions on mobile web app usage

JavaScript via JQuery permeated the mobile web in 2021. Third-party analytics tools had a lower adoption rate on mobile.

One thing that shines through in the data is that at a CMS and web server level, mobile and desktop share a close correlation in how people develop sites, perhaps in large part to the lower overheads of responsive design, meaning one codebase for all experiences.

With WordPress not only maintaining, but extending its popularity for mobile sites, and other CMSs enjoying a similar share to the desktop experience, there's a great opportunity for CMS core improvements and optimizations to bring an outsized benefit to the whole mobile web.

This makes drives like the <a hreflang="en" href="https://make.wordpress.org/core/2021/10/12/proposal-for-a-performance-team/">proposed WordPress Performance Team</a> important and valuable.

## Interacting with the mobile web

Attention to mobile design and friendliness are critical to reducing friction in the user journey. Users navigate the mobile web with taps of their fingers rather than the more refined control provided by a mouse or trackpad.

### Alternative protocol links

The web is built on links. On the mobile web, [Unique Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) schemes beyond http/s, can allow users to complete tasks like <a hreflang="en" href="https://developers.google.com/web/fundamentals/native-hardware/click-to-call">dialing a phone number using `tel:`</a> or starting an email with minimal friction.

The most prevalent URI schemes were `https:`, found on 93.2% of sites, and its non-secure equivalent, `http:`, appearing on 56.7%. The high use of non-secure link protocols is noteworthy as 2020 saw major announcements from browsers to protect users' safety by alerting them when content is not secure.

After web page links, the next five most used protocols in anchor href values on the mobile web are as follows:

{{ figure_markup(
    image="mobile-web-popular-link-protocols.png",
    caption="Popular alternative protocol links.",
    description="Bar chart showing the use of popular alternative protocol links on desktop and mobile. `mailto` is used slightly more on desktop (28.9% compared to 28.3%), `tel` more on mobile (20.7% versus 24.2%), `whatsapp`, `viber`, and `skype` are used less but more so on mobile (0.4%, 0.4%, and 0.3% on desktop compared to 0.6%, 0.5%, and 0.3% respectively on mobile).",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=859715983&format=interactive",
    sheets_gid="115658247",
    sql_file="popular_link_protocols.sql"
  )
}}

Mobile devices whilst limited in some aspects do tend to be better connected, they are a phone, have SMS and other messaging services where desktop clients may not. Usage of other link protocols past the standard `http:` / `https:` can help unlock some of these capabilities. Providing a tappable link to call or send a message without having to copy and paste makes for a smoother, more integrated user interaction.

#### `mailto`

`mailto:` invokes the users chosen email client, clicking:

```html
<a href="mailto:enquiries@example.com?subject=Enquiring about Red Widgets">
  enquiries@example.com
</a>
```

Would prefill an email with the specified email address and subject line. Helpful on mobile, but also relevant for desktop too.

#### `tel`

`tel:` invokes a call:

```html
<a href="tel:+44123467890">
  Call +44 (0)123 4567890
</a>
```

Would open the phone app, ready to dial that number. This saves copy / paste and reduces friction if your business values phone leads or enquiries.

#### `sms`

`sms:` invokes the clients default SMS messaging app:

```html
<a href="sms:+441234567890">
  Text Us
</a>
```

When clicked would prefill a message with the right number, you can also prefill the message body. This fell out of the top 5, with just 0.3% of mobile site loads utilizing this.

#### Other messaging apps

Other messaging apps can register a protocol to have a `<a href="">` open them, as seen in the table above, WhatsApp and Viber are the two leading ones here, outstripping the native `sms:` app usage.

#### Alternative protocol links conclusions

`mailto:` has a long history on the internet, <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc1738#section-3">right back to 1994</a>, but it's encouraging to see `tel:` reach 24% usage, not a long way behind, given its additional usefulness on mobile devices.

It's surprising to see sms with such small uptake, and disappointing that its uptake is below proprietary apps like WhatsApp and Viber.

SMS is more likely to be available as default and require no additional installations, so seemingly more accessible. However, WhatsApp and Viber messages are free, while SMS messages may incur charges from the user's mobile provider. This could explain that relative popularity.

If you aren't using some of the extended capabilities for communication that protocols past `https:` can offer your users, and it's a good fit for your mobile website, these could offer a simple, user friendly, low development benefit.

### Input fields

While URI schemes allow users to take actions from a website, input fields allow users to provide information to a website.

Input elements are one of the most powerful and complex features in HTML. Input elements are used to create interactive controls for web-based forms. Web users experience these elements such as buttons, checkboxes, calendars, search, and other elements which allow control of a page's content based on user input.

{{ figure_markup(
    caption="Percent of mobile pages using inputs.",
    content="71.5%",
    classes="big-number",
    sheets_gid="702940634",
    sql_file="mobile_greater_than_desktop.sql"
)
}}

71.5% of mobile pages tested contained inputs. This is slightly higher than the 71.1% of desktop.

#### Type declarations

{{ figure_markup(
    image="mobile-web-popular-input-types.png",
    caption="Popular mobile input types.",
    description="Bar chart showing the use of popular input types on mobile. `text` is used on 72.6% of mobile pages that use input types, `hidden` is used on 53.2%, `submit` is used on 40.1%, it is not set (n/a) on 27.1%, `email` is used on 25.1%, `search` is used on 23.9%, `checkbox` is used on 23.7%, `password` is used on 13.7% `radio` is used on 5.9%, and finally `tel` is used on 5.4%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1625671749&format=interactive",
    sheets_gid="1769747270",
    sql_file="popular_mobile_input_types.sql"
  )
}}

We can track occurrences of interactive controls created by input by looking for the `type` attribute. The `type` attribute is the most important because it controls how the input element works. The `type` attribute value was declared on 70.9% of tested sites.

If the `type` attribute is not present the input defaults to `text`, a single line text field. In analysis of pages using input elements, 27.1% of those pages did not declare an input type and used the default `text` string value.

Out of all pages using inputs, 72.6% contained at least one `text` input type. This was the most used.

The declared `text` value combined with the fallback value indicates that 99.7% of sites using input elements capture a text value.

#### Advanced input types

{{ figure_markup(
    caption="Percent of mobile pages using inputs.",
    content="44.8%",
    classes="big-number",
    sheets_gid="785717317",
    sql_file="usage_of_advanced_input_types.sql"
)
}}

Of pages with at least one input, 44.8% of them use one or more "advanced input types". Advanced input types include `color`, `date`, `datetime-local`, `email`, `month`, `number`, `range`, `reset`, `search`, `tel`, `time`, `url`, `week`, `datalist`.

##### Telephone

5.4% of pages asked users for their telephone number. For mobile users, navigating from the alpha to numeric keyboard is a high friction point. 62.6% of pages soliciting a telephone number used an input field missing the `type=tel` value.

##### Email

The `email` input type requires the user to submit a valid email address. A non-email value entered in the form prompts an error to display when the form is submitted.

25.1% of pages contained at least one field asking users for their email.

Email collection is often a key micro conversion in the user journey so capturing it with minimal friction benefits the site with a higher conversion rate. Even with this clear business value, 42% of pages which ask for user emails do not use the type=email input type on at least one instance.

##### Search input

Site search is a powerful tool in navigating users to their desired content. Search inputs are text fields functionally identical to text. The main difference between search and text input fields is how they are handled by the browser.

Use of the search input type can trigger a cross icon which allows users to quickly clear existing query text. Many modern browsers also store search queries across domains. When the search type is denoted, stored queries can be used to autocomplete the field.

23.9% of tested pages contained a search input field. It is worth noting that these fields may be present though using a text or undeclared input type. This is a slight increase over 2020 which saw 17% of sites using search input.

Business value appears to impact input type adoption. Ecommerce sites have a vested interest in swiftly moving users to a desired product in order to meet the business goal of a transaction.

43.3% of tested ecommerce sites use search input on their mobile experience. Interestingly, this is higher than 42.6% of sites using the input type for desktop clients.

#### Autocomplete

The [`autocomplete`](https://developer.mozilla.org/docs/Web/HTML/Attributes/autocomplete) attribute allows some control over how forms and inputs work with browsers autofill features. There are a number of options, from disabling it entirely, to providing hints as to what to autofill, like a name, or street address.

Inputting text and data on mobile devices is a generally more tedious process than on a device with a full keyboard, so autofill becomes an even more useful and time saving feature than for desktop users. <a hreflang="en" href="https://www.youtube.com/watch?v=m2a9hlUFRhg&t=1433s">Google discovered</a> a 25% increase in form submission when autofill is used.

For mobile page loads, 24.8% of pages utilized the `autocomplete` attribute, lower than the 27% of desktop page loads.

As the HTTP Archive data captures only homepages, usage could be much higher in checkout, contact and other places that are likely to require inputs, but it is perhaps disappointing to see lower usage on mobile experiences, where arguably it is the most useful.

#### Input field conclusions

Input type declarations are critical in reducing friction. If an input element is marked up using the appropriate type, input elements can prompt different keyboards to improve the experience. The boon to user experience makes the low-lift adoption of input types a meaningful investment.

The low rates of adoption for input types like telephone and email are surprising given the ubiquity of input fields on the mobile web. This gap between business goals and the user experience illustrates that user experience on the mobile web is critical. The greatest opportunities from websites may not come from in-house feature development, but rather leveraging the growing functionalities natively available in modern browsers.

### Accessibility on the mobile web

The pandemic forced humans around the world to isolate themselves from friends, family, and community. The number of persons facing disabilities also increased due to <a hreflang="en" href="https://www.hhs.gov/civil-rights/for-providers/civil-rights-covid19/guidance-long-covid-disability/index.html#footnote10_0ac8mdc">post-COVID conditions</a>. This shift forced digital spaces to the new default as in-person services, commerce, and communication were disrupted.

The goal of accessibility is to create web experiences which provide feature and information parity to all users. Users on the mobile benefit from accessibility as accessibility practices make information available to people using slow internet connections, or who have limited or expensive data plans.

#### ARIA roles

Accessible Rich Internet Applications (ARIA) is a set of attributes that supplement HTML so that commonly used interactions and widgets can be passed to assistive technologies. These attributes are also <a hreflang="en" href="https://webaim.org/blog/web-accessibility-and-seo/">useful to search engines in understanding page content</a>.

When a site is accessed using assistive technology, an element's ARIA role communicates information about how the user can interact.

{{ figure_markup(
    image="mobile-web-most-common-mobile-aria-roles.png",
    caption="Top 10 most common ARIA roles.",
    description="Bar chart showing adoption of ARIA roles on mobile web compared to desktop. `button` is used on 29.0% of mobile page loads, followed by `navigation` (22.5%), `presentation` (21.1%), `dialog` (20.1%), `search` (18.8%), `main` (16.8%), `banner` (14.3%), `contentinfo` (12.1%), `img` (10.9%), and finally `tablist` (7.4%). Desktop usage looks similar.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1644250399&format=interactive",
    sheets_gid="1584971419",
    sql_file="../accessibility/common_aria_role.sql"
  )
}}

The most prevalent ARIA role in 2021 was `button` which appeared on 29% of sites. The `button` role indicates a clickable element that triggers a response when activated by users.

While over 71% of mobile sites have interactive-controls for web-based forms, the most commonly adopted ARIA attribute, aria-label, only appeared on 11.2% of tested sites. This accessibility-focused attribute is used to label input with a text string.

#### Color contrast

A lack of color contrast impacts users with color blindness as well as low color sensitivity, a condition common in older people. Sufficient color contrast allows for equal access to content and a positive impact to business goals. In a case study by Google, ecommerce site Eastpak saw a <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">20% increase in click through rate</a>  when call-to-action buttons used sufficient contrast between text color and its background.

{{ figure_markup(
    image="mobile-web-sufficient-color-contrast.png",
    caption='Mobile Sites with sufficient color contrast.',
    description="Bar chart showing percent of mobile page loads with a sufficient color contrast. 2019 saw 22.0% of sites pass the audit. In 2020, this dropped to 21.1%. 2021 saw an increase to 22.2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1440359640&format=interactive",
    sheets_gid="1628455121",
    sql_file="../accessibility/color_contrast.sql"
  )
}}

Despite the potential for increased conversion, 77.8% of sites failed Lighthouse audits for use of sufficient color contrast. This is a slight improvement year over year.

#### Tap targets

Tap targets are elements that respond to user input. These include links, buttons, form fields, and many others.

In order for effective user interactions, tap targets need to be both appropriately sized and spaced apart from other tap targets on the page. Interactive elements should be at least 48x48 pixels and have a padding of at least 8 pixels separating them from other interactive elements.

{{ figure_markup(
  caption="Percent of mobile sites using sufficiently-sized tap targets.",
  content="39.3%",
  classes="big-number",
  sheets_gid="1766782050",
  sql_file="tap_targets.sql"
)
}}

Overall, 39.3% of sites tested used sufficiently-sized mobile tap targets. Tap target adoption was consistent across domain rank groupings. This is a slight increase from 2020, which saw 36.3% of tap targets properly sized.

#### Zoom and scaling

The Viewport meta element is important to inform a browser how to lay out the page on a user's device. It's also possible to configure this by adding the `user-scalable="no"` or a small `maximum-scale:` parameter to either prevent totally, or limit the ability for users to zoom in on the content. On mobile devices, this is commonly pinch zooming.

Preventing the ability to zoom in is an issue for low vision users and is <a hreflang="en" href="https://dequeuniversity.com/rules/axe/3.3/meta-viewport">something that would fail</a> the WCAG 2.0 guidance.

Disappointingly, 29.4% of mobile page loads fail this requirement, and contained a viewport that prevented zooming, this is a slight improvement over the 30.7% (source: [2020 Web Almanac Accessibility](../2020/accessibility#zooming-and-scaling) chapter).

Things look even worse when looking at the usage by domain ranking.

{{ figure_markup(
    image="mobile-web-zoom-blocking-viewport-tags.png",
    caption="Disabled zooming and scaling by domain rank.",
    description="Bar chart showing the percentage of mobile pages loads were zooming and scaling was disabled, grouped by the origin popularity. At 45.0% the top 1K origins saw the most page loads were zooming and scaling were disabled. The percentage drops incrementally by each group with the 30.4% of top 1M sites disabling the feature, and 29.4% of all sites disabling this. This indicates that the most popular sites (as measure by Crux metric ranking magnitude) were most likely to disable the accessibility feature. For desktop there is a lower disabling for all ranks of 22.4% to 27%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=86675708&format=interactive",
    sheets_gid="1840321233",
    sql_file="viewport_zoom_scale_by_domain_rank.sql"
  )
}}

The more popular sites are more likely to fail this, meaning that overall, more users are reaching mobile sites that are not compliant.

#### Accessibility conclusions

When the web is accessible, more people can perceive, understand, navigate, interact with, and contribute to the web. Equal and inclusive access must be prioritized in order to keep pace with the growth and necessity of web access.

The areas we've covered here are a small part of accessibility. ARIA, zooming, and color contrasts are bare minimum requirements. <a hreflang="en" href="https://www.w3.org/WAI/business-case/#increase-market-reach">A study from W3C's Web Accessibility Initiative</a> show that 15% of the world's population (over 1 billion people) have a recognized disability. Far more may go unregistered or will develop a disability at some point in their lives that may affect their ability to access your sites. Accessibility isn't for a tiny minority.

The poor adoption of good accessibility practice creates a technical barrier to these users that should disturb us as humans, aside from the clear commercial opportunity of properly catering for this sizable group of potential users.

In many jurisdictions, accessibility is not just good practice.

<figure>
  <blockquote>Last year <a hreflang="en" href="https://info.usablenet.com/2020-report-on-digital-accessibility-lawsuits">lawsuits related to the Americans with Disabilities Act were up 20%</a>.</blockquote>
<figcaption>— Web Almanac <cite><a href="./accessibility">2021 Accessibility Chapter</a></cite></figcaption>
</figure>

To learn more about accessibility on the mobile web, visit the [Accessibility](./accessibility) chapter.

## Mobile Search Engine Optimization (SEO)

For any website, acquisition is a critical step, the best optimized mobile website is no different to the worse if no one finds and visits it.

The primary avenue of discovery is quite likely to be from a search engine, along with social media and links from other websites.

With search engines being the primary source of acquisition for many sites, and a still sizeable one for many more, SEO is an important consideration for pretty much every site.

There are some mobile specific areas and concerns in SEO.

### Mobile-first index

Google recognizes that the predominant method of accessing the web is now mobile, and now index websites predominately with a <a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-first-indexing">mobile user-agent</a>. Since July 2019, all new sites have been indexed this way, and most existing sites have now transitioned to mobile-first indexing too.

This means that if you have content or markup that's only served to desktop devices, google will no longer index that part.

### Mobile-friendliness

Both <a hreflang="en" href="https://developers.google.com/search/blog/2015/04/rolling-out-mobile-friendly-update">Google</a> and <a hreflang="en" href="https://blogs.bing.com/webmaster/2015/11/12/mobile-friendly-test">Bing</a>, among other search engines, use some concept of mobile friendliness as a direct ranking signal. This mostly comprises testing to make sure that the content fits in the viewport, text is legible and tap targets are of a reasonable size.

Google offers a <a hreflang="en" href="https://search.google.com/test/mobile-friendly">mobile-friendly test</a>, as does <a hreflang="en" href="https://www.bing.com/webmaster/tools/mobile-friendliness">Bing</a> to help diagnose if your pages are passing.

The recommended way of achieving this is using responsive web design, web.dev have a <a hreflang="en" href="https://web.dev/learn/design/">great learning resource</a>.

### Core Web Vitals & Page Experience

On July 15th 2021, Google announced that they were rolling out the <a hreflang="en" href="https://developers.google.com/search/blog/2021/04/more-details-page-experience">Page Experience Ranking Update</a>. This comprises a few different signals, including mobile-friendliness, with the major new additions being the <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals metrics</a>.

Of particular interest to the mobile web is that the Core Web Vitals part is <a hreflang="en" href="https://support.google.com/webmasters/thread/104436075/core-web-vitals-page-experience-faqs-updated-march-2021">mobile specific</a>, these metrics only play a part in the mobile results so far, although a roll out to desktop is planned in <a hreflang="en" href="https://developers.google.com/search/blog/2021/11/bringing-page-experience-to-desktop">February 2022</a>.

You can learn more about the role of mobile-friendliness and the Core Web Vitals in SEO over in the [SEO](./seo#mobile-friendliness) chapter.

## Mobile performance

A mobile device is likely to be lower powered, and on a slower and less reliable network connection than desktop devices. Given these circumstances, performance can be a bigger challenge and a bigger priority.

### Loading performance

Grabbing the attention of your newly acquired user or keeping the attention of a returning user begins with making sure they see the important content of the site quickly.

#### Largest Contentful Paint

<a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP) is a metric designed to capture this experience (and is one of the Core Web Vitals). It's a measure of when the largest element in the viewport is rendered, it's limited to `<img>`, `<image>` inside an `<svg>`, `<video>` (if the poster is set), a block element with a background image, or a text block.

An LCP of 2.5 seconds or less is considered a good score.

{{ figure_markup(
    image="mobile-web-largest-contentful-paint.png",
    caption='LCP performance by device. Data from the [Performance](./performance) chapter.',
    description="Stacked bar charts comparing LCP threshold groupings for mobile and desktop. 60.3% of desktop sites scored as Good compared to 45.3% of mobile. 27.5% of desktop scored as Needs Improvement vs 35.2% for mobile. 12.2% of desktop sites and 19.5% of mobile scored as Poor LCP.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=875306231&format=interactive",
    sheets_gid="1682201087",
    sql_file="../performance/web_vitals_by_device.sql"
  )
}}

The data shows that just 45% of mobile page loads recorded in the CrUX dataset are meeting the 2.5 second or under target, far lower than the 60% desktop achieves.

It does represent a small improvement from 2020, where only [43% of mobile page loads](../2020/performance#lcp-by-device) met the 2.5 second or under threshold.

There are clearly bigger challenges to achieving good LCP scores for the mobile demographic, but one worth chasing. A recent <a hreflang="en" href="https://web.dev/vodafone/">study from Vodafone</a> showed that a reduction of just 8% in LCP times lead to increased conversions of 31%. Performance can have a direct effect on revenue.

### Images

Many different assets can and do affect load times on mobile, CSS & JavaScript can all play a big part. But a big factor remains images.

Too often an approach to responsive web design is to supply an image whose native size is appropriate for desktop users, and just scale it to the screen with CSS.

#### Appropriately sized images

{{ figure_markup(
    caption="Percent of mobile page loads that had appropriately sized images",
    content="56.6%",
    classes="big-number",
    sheets_gid="1754517886",
    sql_file="correctly_sized_images.sql"
)
}}

This is sadly a step back from 58.8% in 2020. That's 43.4% of mobile users getting the wrong size images.

#### Responsive images

Images can be [served responsively](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images) too, the `srcset` attribute, and the `<picture>` element allow appropriately sized, and appropriately formatted images to be specified, allowing the browser to download the one that best matches the screen and device.

{{ figure_markup(
    image="mobile-web-responsive-images.png",
    caption="Use of `<picture>` and `srcset` to serve responsive images.",
    description="Bar chart showing that 6.2% of mobile sites used `<picture>` elements (compared to 6.3% of desktop sites) and 32.0% used `srcset` attributes (compared to 31.7% of desktop sites) to load images responsively.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1030195048&format=interactive",
    sheets_gid="1802999215",
    sql_file="picture_source_srcset_usage.sql"
  )
}}

Just 6.2% of mobile page loads that included images used the `<picture>` element, slightly lower than desktop.

A healthier 32% of mobile page loads including images use the `srcset` attribute. It is worth mentioning here that this attribute can be used in both the `<picture>` element and the `<img>` element, so there's likely to be some crossover here.

#### Lazy loading

Deferring, or lazy loading, images that aren't in the initial viewport is a good strategy to help resources be focused on loading things that are visible. The native lazy-load attribute, supported in Chrome, Opera, and from September 2021 Firefox for Android (source: <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">caniuse.com</a>) allows this to happen without JavaScript workarounds.

{{ figure_markup(
    caption='Mobile page loads that contained images used `loading="lazy"`',
    content="18.4%",
    classes="big-number",
    sheets_gid="1889147690",
    sql_file="lazy_loading_usage.sql"
  )
}}

This is a big jump up from just 4.1% in 2020.

Looking at the HTTP Archive's <a hreflang="en" href="https://httparchive.org/reports/state-of-images#imgLazy">Native Image Lazy Loading Report</a>, uptake of using the attribute on the `<img>` tag specifically shows the same, impressive growth.

{{ figure_markup(
    image="mobile-web-native-lazy-loading-over-time.png",
    caption="Usage of Lazy Loading attribute over time.",
    description="Line chart from http archive data showing the percentage of mobile and desktop pages using the `loading='lazy'` attribute over time. The lines follow the upward trajectory, starting with 1.4% in July 2020 and climbing in tandem to 19.4% in October 2021.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=62374244&format=interactive",
    sheets_gid="1889147690"
  )
}}

A driving factor in this growth can be attributed to the prevalence of WordPress (source: <a hreflang="en" href="https://twitter.com/rick_viscomi/status/1344380340153016321?s=20">Rick Viscomi on Twitter</a>). WordPress added <a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">support for native lazy-loading in version 5.5</a> which rolled out to the public on August 11th, 2020.

It's also worth mentioning that incorrectly used, <a hreflang="en" href="https://web.dev/articles/lcp-lazy-loading">Lazy Loading LCP Candidates</a> can harm performance. Making sure to apply `loading="lazy"` only to images below the fold is best practice.

#### Image conclusions

It's disappointing to see that more mobile page loads this year had images that were not correctly sized. `<picture>` uptake remains low too, perhaps based on the complexity compared to the `<img>` element.

But great strides have been made in adoption of the `loading="lazy"` attribute, a huge jump in just one year.

Images remain a vital part of the web, and that doesn't change for mobile users. If your site doesn't take advantage of some of the available approaches to serve mobile appropriate images, it's time to investigate this.

### Layout stability

With a generally smaller form factor, and limited screen real estate, unexpected shifting content can be particularly jarring on mobile devices.

Reading an article, only to have the paragraph you are on jump down the screen as an ad loads in above, or shift around as a font loads in and changes before your eyes, is an uncomfortable and negative experience.

#### Cumulative Layout Shift

One of the Core Web Vitals, <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a> (CLS) is a metric designed to capture the impact of this kind of shifting of elements.

The metric is a calculation of impact fraction multiplied by distance fraction. The impact fraction is how much of the area of the screen is shifted and the distance fraction is how much of the screen it moved by.

A CLS score of 0.1 or under is considered good, under 0.25 considered indeed of improvement, and over that it's considered a poor experience

Smaller screen sizes are susceptible to greater shifts, at 360 x 640px, this example block causes a CLS score of 0.22

{{ figure_markup(
    gif="mobile-cls-example.gif",
    image="mobile-cls-example-static.png",
    caption="Screen capture mock-up showing an ad causing CLS on a mobile sized screen.",
    description="The ad insert causes a relatively large amount of content to be shifted on screen at mobile viewport sizes.",
    width=600,
    height=371,
    gif_width=197,
    gif_height=350
  )
}}

At desktop screen sizes, the same element appearing leads to a CLS score of just 0.07.

{{ figure_markup(
    gif="desktop-cls-example.gif",
    image="desktop-cls-example-static.png",
    caption="Screen capture mock-up showing an ad causing CLS on a desktop sized screen.",
    description="The ad insert causes a relatively small amount of content to be shifted on screen at desktop viewport sizes.",
    width=600,
    height=371,
    gif_width=600,
    gif_height=341
  )
}}

The CrUX dataset shows that 62% of mobile page loads had a CLS of 0.1 or under:

{{ figure_markup(
    image="mobile-web-cumulative-layout-shift.png",
    caption='CLS performance by device.',
    description="Stacked bar charts comparing CLS threshold groupings for mobile and desktop. 62.2% desktop and 61.6% of mobile sites scored as Good. 22.7% of desktop scored as Needs Improvement vs 21.1% for mobile. 15.0% of desktop sites and 17.3% of mobile scored as Poor CLS.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=776500715&format=interactive",
    sheets_gid="1682201087",
    sql_file="../performance/web_vitals_by_device.sql"
  )
}}

This is a big step over the 43% achieved last year, but direct comparison is hard, as the metric changed on the <a hreflang="en" href="https://web.dev/evolving-cls/">1st of June 2021</a>to better capture the experience on long-lived pages, so some of this jump could be attributable to this.

### Response to user interaction

When a user interacts with a site, long delays from clicking on something, to something actually happening make a website or app feel sluggish and slow. This lag between input and the action happening is often down to heavy JavaScript processes blocking the main thread, leaving the browser unable to process the command the user issued until it had completed those processes.

Mobile devices are generally much lower powered than desktop and laptops, so the effect of this can be amplified.

#### First Input Delay

<a hreflang="en" href="https://web.dev/articles/fid">First input delay</a> (FID) is the third Core Web Vital metric designed to capture this. It measures the time between the first interaction (a tap or a click on an element) until the browser can start processing that it has happened. It doesn't measure how long the process that tap may have triggered takes.

A good FID score is 100 ms or under, a poor FID score is over 300 ms.

{{ figure_markup(
    image="mobile-web-first-input-delay.png",
    caption='FID performance by device.',
    description="Stacked bar charts comparing FID threshold groupings for mobile and desktop. 99.0% of desktop sites scored as Good compared to 90.0% of mobile. 9.8% of mobile scored as Needs Improvement.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQv2xPBvpLK9_1QqEmOhsXHXcCzunEdsY14Xzeo1D7MYTuu0inzwmz0NtGSFI0mBRP5snPw8ciVWaJQ/pubchart?oid=1158252805&format=interactive",
    sheets_gid="1682201087",
    sql_file="../performance/web_vitals_by_device.sql"
  )
}}

Encouragingly, 90% of mobile page loads in the CrUX dataset had a good FID score, up from 80% from 2020.

Efforts are being made to better capture responsiveness, with the Chrome Speed Metrics team <a hreflang="en" href="https://web.dev/responsiveness/">sharing some plans and inviting feedback</a> on a new responsiveness metric.

If you are looking to learn more about Core Web Vitals in general, the [Performance](./performance) chapter has plenty of details about the Core Web Vitals.

### Service workers

[Service workers](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) while not only applying to mobile devices do become uniquely useful in their ability to add offline capabilities, and better control of loading from caches to web apps, both features which are often more relevant to mobile users, who are more likely to encounter poor or total loss of connectivity.

14.8% of sites register a service worker, a sizeable uptake since 2020's 0.9%

To learn more about service workers and PWA (progressive web apps), visit the [PWA](./pwa) chapter.

### Mobile performance conclusions

Overall, performance has taken a step forward over 2020, with a particularly strong improvement in layout stability.

There are some good, positive signs too in impressive usage growth in `loading="lazy"` and the uptake of service workers. The fact developers are embracing these is a positive sign that performance is being taken seriously.

It does however seem that improving Large Contentful Paint, and handing images are areas developers are struggling with more than other areas. Hopefully tooling and libraries like <a hreflang="en" href="https://nextjs.org/docs/api-reference/next/image">next/image</a> for the
Next.js framework, and adoption by popular CMSs like WordPress will help developers overcome these pain points.

## Conclusion

In 2021, the perception of a distinct "mobile web" is outdated.

Across multiple data sources, it seems that the mobile is one of many ways a user can interact with digital content—and in fact comprises the majority of digital interactions.

For many users, mobile devices are their primary or only means of interacting with the web. Despite this, adoption of methodologies, performance strategies, accessibility principles and adoption of browser-supported features is low.

There has been great progress in some areas, most performance metrics are an improvement over 2020's data. There do remain areas where there's lots of room for growth too.

Accessibility remains an area where it would be great to see more effort and time spent, and image best practices still have some way to go.

With the continuing growth and size of the mobile user sector, for many industries it's no longer a case of having to make a business case to support the mobile web, it is a case of fully embracing it and making use of the many tools and techniques available to a developer in 2021.
