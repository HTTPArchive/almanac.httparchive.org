---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: CMS chapter of the 2019 Web Almanac covering CMS adoption, how CMS suites are built, User experience of CMS powered websites, and CMS innovation.
hero_alt: Hero image of Web Almanac charactes on a type writer writing a web page.
authors: [ernee, amedina]
reviewers: [sirjonathan]
analysts: [rviscomi]
editors: [rviscomi]
translators: []
discuss: 1769
results: https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/
amedina_bio: Alberto Medina is a Developer Advocate in the Web Content Ecosystems Team at Google, focusing on advancing the proliferation of quality content on the web via progressive technologies such as Amp, and the use of modern Web APIs. Alberto's work currently has a strong focus on Content Management Systems as he leads an area of Content Ecosystem called CMS Developer Relations.
ernee_bio: Renee Johnson is a web and product consultant, a WordPress enthusiast, and frequent WordCamp organizer and volunteer. She's currently working with the Content Management System Developer Relations team at Google as a Product Support Specialist.
featured_quote: The general term Content Management System (CMS) refers to systems enabling individuals and organizations to create, manage, and publish content. A CMS for web content, specifically, is a system aimed at creating, managing, and publishing content to be consumed and experienced via the open web. Each CMS implements some subset of a wide range of content management capabilities and the corresponding mechanisms for users to build websites easily and effectively around their content.
featured_stat_1: 40%
featured_stat_label_1: Pages powered by a CMS
featured_stat_2: 74%
featured_stat_label_2: CMS sites that use WordPress
featured_stat_3: 1,232 KB
featured_stat_label_3: Median image KB loaded per desktop CMS page
---

## Introduction

The general term **Content Management System (CMS)** refers to systems enabling individuals and organizations to create, manage, and publish content. A CMS for web content, specifically, is a system aimed at creating, managing, and publishing content to be consumed and experienced via the open web.

Each CMS implements some subset of a wide range of content management capabilities and the corresponding mechanisms for users to build websites easily and effectively around their content. Such content is often stored in some type of database, providing users with the flexibility to reuse it wherever needed for their content strategy. CMSs also provide admin capabilities aimed at making it easy for users to upload and manage content as needed.

There is great variability on the type and scope of the support CMSs provide for building sites; some provide ready-to-use templates which are "hydrated" with user content, and others require much more user involvement for designing and constructing the site structure.

When we think about CMSs, we need to account for all the components that play a role in the viability of such a system for providing a platform for publishing content on the web. All of these components form an ecosystem surrounding the CMS platform, and they include hosting providers, extension developers, development agencies, site builders, etc. Thus, when we talk about a CMS, we usually refer to both the platform itself and its surrounding ecosystem.

### Why do content creators use a CMS?

At the beginning of (web evolution) time, the web ecosystem was powered by a simple growth loop, where users could become creators just by viewing the source of a web page, copy-pasting according to their needs, and tailoring the new version with individual elements like images.

As the web evolved, it became more powerful, but also more complicated. As a consequence, that simple growth loop was broken and it was not the case anymore that any user could become a creator. For those who could pursue the content creation path, the road became arduous and hard to achieve. The <a hreflang="en" href="https://medinathoughts.com/2018/05/17/progressive-wordpress/">usage-capability gap</a>, that is, the difference between what can be done in the web and what is actually done, grew steadily.

{{ figure_markup(
  image="web-evolution.png",
  caption="Chart illustrating the increase in web capabilities from 1999 to 2018.",
  description="On the left, labeled circa 1999, we have a bar chart with two bars showing what can be done is close to what is actually done. On the right, labeled 2018, we have a similar bar chart but what can be done is much larger, and what is done is slightly larger. The gap between what can be done and what is actually done has greatly increased.",
  width=600,
  height=492
  )
}}

Here is where a CMS plays the very important role of making it easy for users with different degrees of technical expertise to enter the web ecosystem loop as content creators. By lowering the barrier of entry for content creation, CMSs activate the growth loop of the web by turning users into creators. Hence their popularity.

### The goal of this chapter

There are many interesting and important aspects to analyze and questions to answer in our quest to understand the CMS space and its role in the present and the future of the web. While we acknowledge the vastness and complexity of the CMS platforms space, and don't claim omniscient knowledge fully covering all aspects involved on all platforms out there, we do claim our fascination for this space and we bring deep expertise on some of the major players in the space.

In this chapter, we seek to scratch the surface area of the vast CMS space, trying to shed a beam of light on our collective understanding of the status quo of CMS ecosystems, and the role they play in shaping users' perception of how content can be consumed and experienced on the web. Our goal is not to provide an exhaustive view of the CMS landscape; instead, we will discuss a few aspects related to the CMS landscape in general, and the characteristics of web pages generated by these systems. This first edition of the Web Almanac establishes a baseline, and in the future we'll have the benefit of comparing data against this version for trend analysis.

## CMS adoption

{{ figure_markup(
  caption="Percent of web pages powered by a CMS.",
  content="40%",
  classes="big-number"
)
}}

Today, we can observe that more than 40% of the web pages are powered by some CMS platform; 40.01% for mobile and 39.61% for desktop more precisely.

There are other datasets tracking market share of CMS platforms, such as <a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management">W3Techs</a>, and they reflect higher percentages of more than 50% of web pages powered by CMS platforms. Furthermore, they observe also that CMS platforms are growing, as fast as 12% year-over-year growth in some cases! The deviation between our analysis and W3Tech's analysis could be explained by a difference in research methodologies. You can read more about ours on the [Methodology](./methodology) page.

In essence, this means that there are many CMS platforms available out there. The following picture shows a reduced view of the CMS landscape.

{{ figure_markup(
  image="cms-logos.png",
  caption="The top content management systems.",
  description="Logos of the top CMS providers, including WordPress, Drupal, Wix, etc.",
  width=600,
  height=559
  )
}}

Some of them are open source (e.g. WordPress, Drupal, others) and some of them are proprietary (e.g. AEM, others). Some CMS platforms can be used on "free" hosted or self-hosted plans, and there are also advanced options for using these platforms on higher-tiered plans even at the enterprise level. The CMS space as a whole is a complex, federated universe of *CMS ecosystems*, all separated and at the same time intertwined in the vast fabric of the web.

It also means that there are hundreds of millions of websites powered by CMS platforms, and an order of magnitude more of users accessing the web and consuming content through these platforms. Thus, these platforms play a key role for us to succeed in our collective quest for an evergreen, healthy, and vibrant web.

### The CMS landscape

A large swath of the web today is powered by one kind of CMS platform or another. There are statistics collected by different organizations that reflect this reality. Looking at the [Chrome UX Report](./methodology#chrome-ux-report) (CrUX) and HTTP Archive datasets, we get a picture that is consistent with stats published elsewhere, although quantitatively the proportions described may be different as a reflection of the specificity of the datasets.

Looking at web pages served on desktop and mobile devices, we observe an approximate 60-40 split in the percentage of such pages which were generated by some kind of CMS platform, and those that aren't.

{{ figure_markup(
  image="fig4.png",
  caption="Percent of desktop and mobile websites that use a CMS.",
  description="Bar chart showing that 40% of desktop and 40% of mobile websites are built using a CMS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644425372&format=interactive"
  )
}}

CMS-powered web pages are generated by a large set of available CMS platforms. There are many such platforms to choose from, and many factors that can be considered when deciding to use one vs. another, including things like:

* Core functionality
* Creation/editing workflows and experience
* Barrier of entry
* Customizability
* Community
* And many others.

The CrUX and HTTP Archive datasets contain web pages powered by a mix of around 103 CMS platforms. Most of those platforms are very small in terms of relative market share. For the sake of our analysis, we will be focusing on the top CMS platforms in terms of their footprint on the web as reflected by the data. For a full analysis, <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/edit#gid=0">see this chapter's results spreadsheet</a>.

{{ figure_markup(
  image="fig5.png",
  caption="Top CMS platforms as a percent of all CMS websites.",
  description="Bar chart showing WordPress making up 75% of all CMS websites. The next biggest CMS, Drupal, has about 6% of the CMS market share. The rest of the CMSs quickly shrink in adoption to less than 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1652315665&format=interactive",
  width=600,
  height=600,
  data_width=600,
  data_height=600
  )
}}

The most salient CMS platforms present in the datasets are shown above in Figure 14.5. WordPress comprises 74.19% of mobile and 73.47% of desktop CMS websites. Its dominance in the CMS landscape can be attributed to a number of factors that we'll discuss later, but it's a _major_ player. Open source platforms like Drupal and Joomla, and closed SaaS offerings like Squarespace and Wix, round out the top 5 CMSs. The diversity of these platforms speak to the CMS ecosystem consisting of many platforms where user demographics and the website creation journey vary. What's also interesting is the long tail of small scale CMS platforms in the top 20. From enterprise offerings to proprietary applications developed in-house for industry specific use, content management systems provide the customizable infrastructure for groups to manage, publish, and do business on the web.

The <a hreflang="en" href="https://wordpress.org/about/">WordPress project</a> defines its mission as "*democratizing publishing*". Some of its main goals are ease of use and to make the software free and available for everyone to create content on the web. Another big component is the inclusive community the project fosters. In almost any major city in the world, one can find a group of people who gather regularly to connect, share, and code in an effort to understand and build on the WordPress platform. Attending local meetups and annual events as well as participating in web-based channels are some of the ways WordPress contributors, experts, businesses, and enthusiasts participate in its global community.

The low barrier of entry and resources to support users (online and in-person) with publishing on the platform and to develop extensions (plugins) and themes contribute to its popularity. There is also a thriving availability of and economy around WordPress plugins and themes that reduce the complexity of implementing sought after web design and functionality. Not only do these aspects drive its reach and adoption by newcomers, but also maintains its long-standing use over time.

The open source WordPress platform is powered and supported by volunteers, the WordPress Foundation, and major players in the web ecosystem. With these factors in mind, WordPress as the leading CMS makes sense.

## How are CMS-powered sites built

Independent of the specific nuances and idiosyncrasies of different CMS platforms, the end goal for all of them is to output web pages to be served to users via the vast reach of the open web. The difference between CMS-powered and non-CMS-powered web pages is that in the former, the CMS platform makes most of the decisions of how the end result is built, while in the latter there are not such layers of abstraction and decisions are all made by developers either directly or via library configurations.

In this section we take a brief look at the status quo of the CMS space in terms of the characteristics of their output (e.g. total resources used, image statistics, etc.), and how they compare with the web ecosystem as a whole.

### Total resource usage

The building blocks of any website also make a CMS website: [HTML](./markup), [CSS](./css), [JavaScript](./javascript), and [media](./media) (images and video). CMS platforms give users powerfully streamlined administrative capabilities to integrate these resources to create web experiences. While this is one of the most inclusive aspects of these applications, it could have some adverse effects on the wider web.

{{ figure_markup(
  image="fig6.png",
  caption="Distribution of CMS page weight.",
  description="Bar chart showing the distribution of CMS page weight. The median desktop CMS page weighs 2.3 MB. At the 10th percentile it is 0.7 MB, 25th percentile 1.2 MB, 75th percentile 4.2 MB, and 90th percentile 7.4 MB. Desktop values are very slightly higher than mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=991628102&format=interactive"
  )
}}

{{ figure_markup(
  image="fig7.png",
  caption="Distribution of CMS requests per page.",
  description="Bar chart showing the distribution of CMS requests per page. The median desktop CMS page loads 86 resources. At the 10th percentile it loads 39 resources, 25th percentile 57 resources, 75th percentile 127 resources, and 90th percentile 183 resources. Desktop is consistently higher than mobile by a small margin of 3-6 resources.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=140872807&format=interactive"
  )
}}

In Figures 14.6 and 14.7 above, we see the median desktop CMS page loads 86 resources and weighs 2.29 MB. Mobile page resource usage is not too far behind with 83 resources and 2.25 MB.

The median indicates the halfway point that all CMS pages either fall above or below. In short, half of all CMS pages load fewer requests and weigh less, while half load more requests and weigh more. At the 10th percentile, mobile and desktop pages have under 40 requests and 1 MB in weight, but at the 90th percentile we see pages with over 170 requests and at 7 MB, almost tripling in weight from the median.

How do CMS pages compare to pages on the web as a whole? In the [Page Weight](./page-weight) chapter, we find some telling data about resource usage. At the median, desktop pages load 74 requests and weigh 1.9 MB, and mobile pages on the web load 69 requests and weigh 1.7 MB. The median CMS page exceeds this. CMS pages also exceed resources on the web at the 90th percentile, but by a smaller margin. In short: CMS pages could be considered as some of the heaviest.

<figure>
  <table>
    <thead>
      <tr>
        <th>percentile</th>
        <th>image</th>
        <th>video</th>
        <th>script</th>
        <th>font</th>
        <th>css</th>
        <th>audio</th>
        <th>html</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">1,233</td>
        <td class="numeric">1,342</td>
        <td class="numeric">456</td>
        <td class="numeric">140</td>
        <td class="numeric">93</td>
        <td class="numeric">14</td>
        <td class="numeric">33</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">2,766</td>
        <td class="numeric">2,735</td>
        <td class="numeric">784</td>
        <td class="numeric">223</td>
        <td class="numeric">174</td>
        <td class="numeric">97</td>
        <td class="numeric">66</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">5,699</td>
        <td class="numeric">5,098</td>
        <td class="numeric">1,199</td>
        <td class="numeric">342</td>
        <td class="numeric">310</td>
        <td class="numeric">287</td>
        <td class="numeric">120</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribution of desktop CMS page kilobytes per resource type.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>percentile</th>
        <th>image</th>
        <th>video</th>
        <th>script</th>
        <th>css</th>
        <th>font</th>
        <th>audio</th>
        <th>html</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">1,264</td>
        <td class="numeric">1,056</td>
        <td class="numeric">438</td>
        <td class="numeric">89</td>
        <td class="numeric">109</td>
        <td class="numeric">14</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">2,812</td>
        <td class="numeric">2,191</td>
        <td class="numeric">756</td>
        <td class="numeric">171</td>
        <td class="numeric">177</td>
        <td class="numeric">38</td>
        <td class="numeric">67</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">5,531</td>
        <td class="numeric">4,593</td>
        <td class="numeric">1,178</td>
        <td class="numeric">317</td>
        <td class="numeric">286</td>
        <td class="numeric">473</td>
        <td class="numeric">123</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribution of mobile CMS page kilobytes per resource type.") }}</figcaption>
</figure>

When we look closer at the types of resources that load on mobile or desktop CMS pages, images and video immediately stand out as primary contributors to their weight.

The impact doesn't necessarily correlate with the number of requests, but rather how much data is associated with those individual requests. For example, in the case of video resources with only two requests made at the median, they carry more than 1 MB of associated load. Multimedia experiences also come with the use of scripts to integrate interactivity, deliver functionality and data to name a few use cases. In both mobile and desktop pages, those are the 3rd heaviest resource.

With our CMS experiences saturated with these resources, we must consider the impact this has on website visitors on the frontend- is their experience fast or slow? Additionally, when comparing mobile and desktop resource usage, the amount of requests and weight show little difference. This means that the same amount and weight of resources are powering both mobile and desktop CMS experiences. Variation in connection speed and mobile device quality adds <a hreflang="en" href="https://medinathoughts.com/2017/12/03/the-perils-of-mobile-web-performance-part-iii/">another layer of complexity</a>. Later in this chapter, we'll use data from CrUX to assess user experience in the CMS space.

### Third-party resources

Let's highlight a particular subset of resources to assess their impact in the CMS landscape. [Third-party](./third-parties) resources are those from origins not belonging to the destination site's domain name or servers. They can be images, videos, scripts, or other resource types. Sometimes these resources are packaged in combination such as with embedding an `iframe` for example. Our data reveals that the median amount of 3rd party resources for both desktop and mobile are close.

The median amount of 3rd party requests on mobile CMS pages is 15 and weigh 264.72 KB, while the median for these requests on desktop CMS pages is 16 and weigh 271.56 KB. (Note that this excludes 3P resources considered part of "hosting").

{{ figure_markup(
  image="fig10.png",
  caption="Distribution of third-party weight (KB) on CMS pages.",
  description="Bar chart of percentiles 10, 25, 50, 75, and 90 representing the distribution of third-party kilobytes on CMS pages for desktop and mobile. The median (50th percentile) desktop third-party weight is 272 KB. The 10th percentile is 27 KB, 25th 104 KB, 75th 577 KB, and 90th 940 KB. Mobile is slightly smaller in the smaller percentiles and slightly larger in the larger percentiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=354803312&format=interactive"
  )
}}

{{ figure_markup(
  image="fig11.png",
  caption="Distribution of the number of third-party requests on CMS pages.",
  description="Bar chart of percentiles 10, 25, 50, 75, and 90 representing the distribution of third-party requests on CMS pages for desktop and mobile. The median (50th percentile) desktop third-party request count is 16. The 10th percentile is 3, 25th 7, 75th 31, and 90th 52. Desktop and mobile have nearly equivalent distributions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=699762709&format=interactive"
  )
}}

We know the median value indicates at least half of CMS web pages are shipping with more 3rd party resources than what we report here. At the 90th percentile, CMS pages can deliver up to 52 resources at approximately 940 KB, a considerable increase.

Given that third-party resources originate from remote domains and servers, the destination site has little control over the quality and impact these resources have on its performance. This unpredictability could lead to fluctuations in speed and affect the user experience, which we'll soon explore.

### Image stats

{{ figure_markup(
  image="fig12.png",
  caption="Distribution of image weight (KB) on CMS pages.",
  description="Bar chart of percentiles 10, 25, 50, 75, and 90 representing the distribution of image kilobytes on CMS pages for desktop and mobile. The median (50th percentile) desktop image weight is 1,232 KB. The 10th percentile is 198 KB, 25th 507 KB, 75th 2,763 KB, and 90th 5,694 KB. Desktop and mobile have nearly equivalent distributions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1615220952&format=interactive"
  )
}}

{{ figure_markup(
  caption="The median number of image kilobytes loaded per desktop CMS page.",
  content="1,232 KB",
  classes="big-number"
)
}}

Recall from Figures 14.8 and 14.9 earlier, images are a big contributor to the total weight of CMS pages. Figures 14.12 and 14.13 above show that the median desktop CMS page has 31 images and payload of 1,232 KB, while the median mobile CMS page has 29 images and payload of 1,263 KB. Again we have very close margins for the weight of these resources for both desktop and mobile experiences. The [Page Weight](./page-weight) chapter additionally shows that image resources well exceed the median weight of pages with the same amount of images on the web as a whole, which is 983 KB and 893 KB for desktop and mobile respectively. The verdict: CMS pages ship heavy images.

Which are the common formats found on mobile and desktop CMS pages? From our data JPG images on average are the most popular image format. PNG and GIF formats follow, while formats like SVG, ICO, and WebP trail significantly comprising approximately a little over 2% and 1%.

{{ figure_markup(
  image="fig14.png",
  caption="Adoption of image formats on CMS pages.",
  description="Bar chart of the adoption of image formats on CMS pages for desktop and mobile. JPEG makes up nearly half of all image formats, PNG comprises a third, GIF comprises a fifth, and the remaining 5% shared among SVG, ICO, and WebP. Desktop and mobile have nearly equivalent adoption.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=98218771&format=interactive"
  )
}}

Perhaps this segmentation isn't surprising given the common use cases for these image types. SVGs for logos and icons are common as are JPEGs ubiquitous. WebP is still a relatively new optimized format with <a hreflang="en" href="https://caniuse.com/#search=webp">growing browser adoption</a>. It will be interesting to see how this impacts its use in the CMS space in the years to come.

## User experience on CMS-powered websites

Success as a web content creator is all about user experience. Factors such as resource usage and other statistics regarding how web pages are composed are important indicators of the quality of a given site in terms of the best practices followed while building it. However, we are ultimately interested in shedding some light on how are users actually experiencing the web when consuming and engaging with content generated by these platforms.

To achieve this, we turn our analysis towards some <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics">user-perceived performance metrics</a>, which are captured in the CrUX dataset. These metrics relate in some ways to <a hreflang="en" href="https://paulbakaus.com/tutorials/performance/the-illusion-of-speed/">how we, as humans, perceive time</a>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Duration</th>
        <th>Perception</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>< 0.1 seconds</td>
        <td>Instant</td>
      </tr>
      <tr>
        <td>0.5-1 second</td>
        <td>Immediate</td>
      </tr>
      <tr>
        <td>2-5 seconds</td>
        <td>Point of abandonment</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="How humans perceive short durations of time.") }}</figcaption>
</figure>

If things happen within 0.1 seconds (100 milliseconds), for all of us they are happening virtually instantly. And when things take longer than a few seconds, the likelihood we go on with our lives without waiting any longer is very high. This is very important for content creators seeking sustainable success in the web, because it tells us how fast our sites must load if we want to acquire, engage, and retain our user base.

In this section we take a look at three important dimensions which can shed light on our understanding of how users are experiencing CMS-powered web pages in the wild:

* First Contentful Paint (FCP)
* First Input Delay (FID)
* Lighthouse scores

### First Contentful Paint

<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/first-contentful-paint">First Contentful Paint</a> measures the time it takes from navigation until content such as text or an image is first displayed. A successful FCP experience, or one that can be qualified as "fast," entails how quickly elements in the DOM are loaded to assure the user that the website is loading successfully. Although a good FCP score is not a guarantee that the corresponding site offers a good UX, a bad FCP almost certainly does guarantee the opposite.

{{ figure_markup(
  image="fig16.png",
  caption="Average distribution of FCP experiences across CMSs.",
  description="Bar chart of the average distribution of FCP experiences per CMS. Refer to Figure 14.17 below for a data table of the top 5 CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644531590&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>Fast<br>(&lt; 1000ms)</th>
        <th>Moderate</th>
        <th>Slow<br>(&gt;= 3000ms)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">24.33%</td>
        <td class="numeric">40.24%</td>
        <td class="numeric">35.42%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">37.25%</td>
        <td class="numeric">39.39%</td>
        <td class="numeric">23.35%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">22.66%</td>
        <td class="numeric">46.48%</td>
        <td class="numeric">30.86%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">14.25%</td>
        <td class="numeric">62.84%</td>
        <td class="numeric">22.91%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">26.23%</td>
        <td class="numeric">43.79%</td>
        <td class="numeric">29.98%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Average distribution of FCP experiences for the top 5 CMSs.") }}</figcaption>
</figure>

FCP in the CMS landscape trends mostly in the moderate range. The need for CMS platforms to query content from a database, send, and subsequently render it in the browser, could be a contributing factor to the delay that users experience. The resource loads we discussed in the previous sections could also play a role. In addition, some of these instances are on shared hosting or in environments that may not be optimized for performance, which could also impact the experience in the browser.

WordPress shows notably moderate and slow FCP experiences on mobile and desktop. Wix sits strongly in moderate FCP experiences on its closed platform. TYPO3, an enterprise open-source CMS platform, has consistently fast experiences on both mobile and desktop. TYPO3 advertises built-in performance and scalability features that may have a positive impact for website visitors on the frontend.

### First Input Delay

<a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">First Input Delay</a> (FID) measures the time from when a user first interacts with your site (i.e. when they click a link, tap on a button, or use a custom, JavaScript-powered control) to the time when the browser is actually able to respond to that interaction. A "fast" FID from a user's perspective would be immediate feedback from their actions on a site rather than a stalled experience. This delay (a pain point) could correlate with interference from other aspects of the site loading when the user tries to interact with the site.

FID in the CMS space generally trends on fast experiences for both desktop and mobile on average. However, what's notable is the significant difference between mobile and desktop experiences.

{{ figure_markup(
  image="fig18.png",
  caption="Average distribution of FID experiences across CMSs.",
  description="Bar chart of the average distribution of FCP experiences per CMS. Refer to Figure 14.19 below for a data table of the top 5 CMSs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=625179047&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>Fast<br>(&lt; 100ms)</th>
        <th>Moderate</th>
        <th>Slow<br>(&gt;= 300ms)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">80.25%</td>
        <td class="numeric">13.55%</td>
        <td class="numeric">6.20%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">74.88%</td>
        <td class="numeric">18.64%</td>
        <td class="numeric">6.48%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">68.82%</td>
        <td class="numeric">22.61%</td>
        <td class="numeric">8.57%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">84.55%</td>
        <td class="numeric">9.13%</td>
        <td class="numeric">6.31%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">63.06%</td>
        <td class="numeric">16.99%</td>
        <td class="numeric">19.95%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Average distribution of FID experiences for the top 5 CMSs.") }}</figcaption>
</figure>

While this difference is present in FCP data, FID sees bigger gaps in performance. For example, the difference between mobile and desktop fast FCP experiences for Joomla is around 12.78%, for FID experiences the difference is significant: 27.76%. Mobile device and connection quality could play a role in the performance gaps that we see here. As we highlighted previously, there is a small margin of difference between the resources shipped to  desktop and mobile versions of a website. Optimizing for the mobile (interactive) experience becomes more apparent with these results.

### Lighthouse scores

[Lighthouse](./methodology#lighthouse) is an open-source, automated tool designed to help developers assess and improve the quality of their websites. One key aspect of the tool is that it provides a set of audits to assess the status of a website in terms of **performance**, **accessibility**, **progressive web apps**, and more. For the purposes of this chapter, we are interested in two specific audits categories: PWA and accessibility.

#### PWA

The term **Progressive Web App** ([PWA](./pwa)) refers to web-based user experiences that are considered as being <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#reliable">reliable</a>, <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#fast">fast</a>, and <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#engaging">engaging</a>. Lighthouse provides a set of audits which returns a PWA score between 0 (worst) and 1 (best). These audits are based on the <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist#baseline">Baseline PWA Checklist</a>, which lists 14 requirements. Lighthouse has automated audits for 11 of the 14 requirements. The remaining 3 can only be tested manually. Each of the 11 automated PWA audits are weighted equally, so each one contributes approximately 9 points to your PWA score.

{{ figure_markup(
  image="fig20.png",
  caption="Distribution of Lighthouse PWA category scores for CMS pages.",
  description="Bar chart showing the distribution of Lighthouse PWA category scores for all CMS pages. The most common score is 0.3 at 22% of CMS pages. There are two other peaks in the distribution: 11% of pages with scores of 0.15 and 8% of pages with scores of 0.56. Fewer than 1% of pages get a score above 0.6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1812566020&format=interactive"
  )
}}

{{ figure_markup(
  image="fig21.png",
  caption="Median Lighthouse PWA category scores per CMS.",
  description="Bar chart showing the median Lighthouse PWA score per CMS. The median score for WordPress websites is 0.33. The next five CMSs (Joomla, Drupal, Wix, Squarespace, and 1C-Bitrix) all have a median score of 0.3. The CMSs with the top PWA scores are Jimdo with a score of 0.56 and TYPO3 at 0.41.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1071586621&format=interactive"
  )
}}

#### Accessibility

An accessible website is a site designed and developed so that people with disabilities can use them. Lighthouse provides a set of accessibility audits and it returns a weighted average of all of them (see <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Cxzhy5ecqJCucdf1M0iOzM8mIxNc7mmx107o5nj38Eo/edit#gid=1567011065">Scoring Details</a> for a full list of how each audit is weighted).

Each accessibility audit is pass or fail, but unlike other Lighthouse audits, a page doesn't get points for partially passing an accessibility audit. For example, if some elements have screenreader-friendly names, but others don't, that page gets a 0 for the *screenreader-friendly-names* audit.

{{ figure_markup(
  image="fig22.png",
  caption="Distribution of Lighthouse accessibility category scores for CMS pages.",
  description="Bar chart showing the distribution of CMS pages' Lighthouse accessibility scores. The distribution is heavily skewed to the higher scores with a mode of about 0.85.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=764428981&format=interactive"
  )
}}

{{ figure_markup(
  image="fig23.png",
  caption="Median Lighthouse accessibility category scores per CMS.",
  description="Bar chart showing the median Lighthouse accessibility category score per CMS. Most CMSs get a score of about 0.75. Notable outliers include Wix with a median score of 0.93 and 1-C Bitrix with a score of 0.65.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=940747460&format=interactive"
  )
}}

As it stands now, only 1.27% of mobile CMS home pages get a perfect score of 100%. Of the top CMSs, Wix takes the lead by having the highest median accessibility score on its mobile pages. Overall, these figures are dismal when you consider how many websites (how much of the web that is powered by CMSs) are inaccessible to a significant segment of our population. As much as digital experiences impact so many aspects of our lives, this should be a mandate to encourage us to *build accessible web experiences from the start*, and to continue the work of making the web an inclusive space.

## CMS innovation

While we've taken a snapshot of the current landscape of the CMS ecosystem, the space is evolving. In efforts to address [performance](./performance) and user experience shortcomings, we're seeing experimental frameworks being integrated with the CMS infrastructure in both coupled and decoupled/ headless instances. Libraries and frameworks such as React.js, its derivatives like Gatsby.js and Next.js, and Vue.js derivative Nuxt.js are making slight marks of adoption.

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>React</th>
        <th>Nuxt.js,<br>React</th>
        <th>Nuxt.js</th>
        <th>Next.js,<br>React</th>
        <th>Gatsby,<br>React</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">131,507</td>
        <td class="numeric"></td>
        <td class="numeric">21</td>
        <td class="numeric">18</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">50,247</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">3,457</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">2,940</td>
        <td class="numeric"></td>
        <td class="numeric">8</td>
        <td class="numeric">15</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>DataLife Engine</td>
        <td class="numeric">1,137</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Adobe Experience Manager</td>
        <td class="numeric">723</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">7</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Contentful</td>
        <td class="numeric">492</td>
        <td class="numeric">7</td>
        <td class="numeric">114</td>
        <td class="numeric">909</td>
        <td class="numeric">394</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">385</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">340</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>TYPO3 CMS</td>
        <td class="numeric">265</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Weebly</td>
        <td class="numeric">263</td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Jimdo</td>
        <td class="numeric">248</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">223</td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>SDL Tridion</td>
        <td class="numeric">152</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td class="numeric">123</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adoption (number of mobile websites) of React and companion frameworks per CMS.") }}</figcaption>
</figure>

We also see hosting providers and agencies offering Digital Experience Platforms (DXP) as holistic solutions using CMSs and other integrated technologies as a toolbox for enterprise customer-focused strategies. These innovations show an effort to create turn-key, CMS-based solutions that make it possible, simple, and easy by default for the users (and their end users) to get the best UX when creating and consuming the content of these platforms. The aim: good performance by default, feature richness, and excellent hosting environments.

## Conclusions

The CMS space is of paramount importance. The large portion of the web these applications power and the critical mass of users both creating and encountering its pages on a variety of devices and connections should not be trivialized. We hope this chapter and the others found here in the Web Almanac inspire more research and innovation to help make the space better. Deep investigations would provide us better context about the strengths, weaknesses, and opportunities these platforms provide the web as a whole. Content management systems can make an impact on preserving the integrity of the open web. Let's keep moving them forward!
