---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 14
title: PWA
description: PWA chapter of the 2020 Web Almanac covering service workers (registations, installability, events and filesizes), Web App Manifests properties, and Workbox.
authors: [hemanth, logicalphase]
reviewers: [thepassle, jadjoubran, pearlbea, gokulkrishh, jaisanth]
analysts: [bazzadp]
translators: []
#hemanth_bio: TODO
#logicalphase_bio: TODO
discuss: 2050
results: https://docs.google.com/spreadsheets/d/1AOqCkb5EggnE8BngpxvxGj_fCfssT9sZ0ElCQKp4pOw/
queries: 14_PWA
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---

# Introduction

In 1990 we had the first ever browser called the “WorldWideWeb” and ever since the web and the browser has been evolving and for web to progress itself into a native behaviour is a big win special in this ear of mobile domination, URLs have provided an ubiquitous way to distribute information and nothing better than the browser to handle them and hence a technology which provides such capabilities to the browser becomes a game changer and Progressive Web Apps provide such advantages for the web to win yet again.

Simply put, a web application which progresses into a native-like application can be considered as a PWA, built using common web technologies including HTML, CSS and JavaScript and can operate seamlessly across devices and environments on a standards-compliant browser.

The crux of a progressive web app is “The ServiceWorker”, which can be thought of as a proxy sitting between the browser and user and gives the developer total control over the network, rather than the network controlling the application.

It all started in December 2014 when Chrome 40 first implemented the meat of what is now known as Progressive Web Apps which was a collaborative effort for the web standards body and the terms was coined by [Frances Berriman and Alex Russell](https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/) in 2015.

In this chapter of Web Almanac we will be looking into each of the ingredients that make PWA what it is from a data-driven perspective.

  

# Service workers

## Service worker registrations and installability

From the data we gathered it was derived that about **0.88%** for desktop, **0.87%** for mobile for the month of August 2020 it's 49,305 (out of 5,593,642) for desktop and 55,019 (out of 6,347,919) for mobile. It is important that we realize that it translates into **16.6%** of the entire [traffic]
(https://www.chromestatus.com/metrics/feature/timeline/popularity/990). 

![](https://lh3.googleusercontent.com/LWvKIzfDAY5487x_scblRbPz2mog_xHmRXGth0J49jXrivPqmVZiaFeMgixG8pKxC0bafdb4MBR8yuOk8cc0jxVanEWNGV-QIi-D0xLOGwixg9sWQqQC-Fd12Pg-SIhCxiSrlNSH "Chart")


# Insights from lighthouse scores

[Lighthouse](https://github.com/GoogleChrome/lighthouse) provides automated auditing, performance metrics, and best practices for the web and has been instrumental in shaping web’s performance.  The score we gathered over 6811475 pages, has given us great insights on a few important touch points for the month of September 2020.

| Lighthouse Audit         | Weight | Number of Pages | Percentage |   |
|--------------------------|--------|-----------------|------------|---|
| load-fast-enough-for-pwa |      7 |      1,876,086* |    27.97%* |   |
| works-offline            |      5 |          54,015 |      0.86% |   |
| installable-manifest     |      2 |         139,005 |      2.21% |   |
| is-on-https              |      2 |       4,168,056 |     66.67% |   |
| redirects-http           |      2 |       4,371,335 |     70.33% |   |
| viewport                 |      2 |       5,528,992 |     88.43% |   |
| apple-touch-icon         |      1 |       2,172,548 |     34.75% |   |
| content-width            |      1 |       4,962,326 |     79.37% |   |
| maskable-icon            |      1 |           6,905 |      0.11% |   |
| offline-start-url        |      1 |          46,868 |      0.75% |   |
| service-worker           |      1 |          64,373 |      1.03% |   |
| splash-screen            |      1 |         119,326 |      1.90% |   |
| themed-omnibox           |      1 |         249,920 |      4.00% |   |
| without-javascript       |      1 |       6,064,478 |     97.57% |   |


* Note the Lighthouse performance stats were incorrect for August so the `load-fast-enough-for-pwa` stat has been replaced with September results.

A fast page load over a cellular network ensures a good mobile user experience. [Learn more]([https://web.dev/load-fast-enough-for-pwa/](https://web.dev/load-fast-enough-for-pwa/))

**27.56%** of pages loaded fast enough for a PWA. Given how geo distributed the web is, having a fast load time with lighter pages matter the most of the next billion users of the web, most of them were introduced to the internet via a mobile device.

If you're building a Progressive Web App, consider using a service worker so that your app can work offline. [Learn more]([https://web.dev/works-offline/](https://web.dev/works-offline/)) **0.92%** of pages were offline ready.

Browsers can proactively prompt users to add your app to their homescreen, which can lead to higher engagement. [Learn more]([https://web.dev/installable-manifest/](https://web.dev/installable-manifest/)) **2.21%** of pages had an installable manifest. Manifest plays an important role in how the application starts, the looks and feel of the icon on the homescreen and as an impact on the engagement rate directly.

All sites should be protected with HTTPS, even ones that don't handle sensitive data. This includes avoiding [mixed content](https://developers.google.com/web/fundamentals/security/prevent-mixed-content/what-is-mixed-content), where some resources are loaded over HTTP despite the initial request being served over HTTPS. HTTPS prevents intruders from tampering with or passively listening in on the communications between your app and your users, and is a prerequisite for HTTP/2 and many new web platform APIs. [Learn more]([https://web.dev/is-on-https/](https://web.dev/is-on-https/)). **67.27%** of sites were on HTTPS and it is surprising that we haven’t reached there yet. This number is pretty decent and will get better as browsers mandate the applications to be on HTTPS and scrutinize those which are not on HTTPS.

If you've already set up HTTPS, make sure that you redirect all HTTP traffic to HTTPS in order to enable secure connection the users without changing the URL [Learn more]([https://web.dev/redirects-http/](https://web.dev/redirects-http/)) **69.92%** of the sites redirects HTTP. Redirecting all the HTTP to HTTPS on your application should be simple steps towards robustness, though the HTTP redirection to HTTPS has a decent number, it can do better.

By adding `<meta name="viewport">` tag to optimize your app for mobile screens. [Learn more]([https://web.dev/viewport/](https://web.dev/viewport/)). **88.43%** of the sites have the viewport meta tag. It is not surprising that the usage of viewport meta tag is on the higher side as most of the applications are aware and getting there in terms of viewport optimization.

For ideal appearance on iOS, your progressive web app should define an `apple-touch-icon` meta tag. It must point to a non-transparent 192px (or 180px) square PNG. [Learn More]([https://web.dev/apple-touch-icon/](https://web.dev/apple-touch-icon/)) **32.34%** of the sites use the apple touch icon.

If the width of your app's content doesn't match the width of the viewport, your app might not be optimized for mobile screens. [Learn more]([https://web.dev/content-width/](https://web.dev/content-width/)) **79.18%** of the sites have the content-width set.

A maskable icon ensures that the image fills the entire shape without being letterboxed when adding the progressive web app to the home screen.. [Learn more]([https://web.dev/maskable-icon-audit/](https://web.dev/maskable-icon-audit/)) **0.14%** of sites use this, given that it is a brand new feature, the percentage of adaptation is pretty decent. This being a new feature we were expecting the numbers to be low and for sure shall improve in the coming years.

A service worker enables your web app to be reliable in unpredictable network conditions. [Learn more]([https://web.dev/offline-start-url/](https://web.dev/offline-start-url/)) **0.77%** of sites has an offline start URL.

The service worker is the feature that enables your app to use many Progressive Web App features, such as offline, add to homescreen, and push notifications. [Learn more]([https://web.dev/service-worker/](https://web.dev/service-worker/)) **1.05%** of pages have service workers enabled, bare in mind this for the month of September 2020. Serviceworker helps to achieve offline support, which is the most important feature for a PWA, as flaky networks are the most common issue that the user of web applications face and this is circumvented with Serviceworkers, it is pretty surprising that number was this low for the month under investigation.

A themed splash screen ensures a native like experience when users launch your app from their homescreens. [Learn more]([https://web.dev/splash-screen/](https://web.dev/splash-screen/)) **1.95%** of pages had splash screens.

The browser address bar can be themed to match your site. [Learn more]([https://web.dev/themed-omnibox/](https://web.dev/themed-omnibox/)) **3.98%** of pages had themed omnibox.

Your app should display some content when JavaScript is disabled, even if it's just a warning to the user that JavaScript is required to use the app. [Learn more]([https://web.dev/without-javascript/](https://web.dev/without-javascript/)) **96.23%** pages can work with JavaScript disabled.


# Service worker events

In a service worker one can listen for a number of events:  

1.  `install`, which occurs upon service worker installation.
    
2.  `activate`, which occurs upon service worker activation.
    
3.  `fetch`, which occurs whenever a resource is fetched.
    
4.  `push`, which occurs when a push notification arrives.
    
5.  `notificationclick`, which occurs when a notification is being clicked.
    
6.  `notificationclose`, which occurs when a notification is being closed.
    
7.  `message`, which occurs when a message sent via postMessage() arrives.
    
8.  `sync`, which occurs when a background sync event occurs.
    

  

![](https://lh6.googleusercontent.com/saXCVd5ClUVGqA4HF558mPJfTI5YqRoq9rRPQCiPgZOZ5QuCGx2IJuHytFzgN-Zlz1Ppdjd59vF1pk4pZ-Tn8XVg45tCKdsQHVay02-x4Qfio75zmFw7hMT9EvlY3IWXCW_Lue76 "Chart")

We have examined which of these events are being listened to by service workers we could find in the HTTP Archive. The results for mobile and desktop are very similar with install, fetch, and activate being the three most popular events, followed by message, notification click, push and sync. If we interpret these results, offline use cases that service workers enable are the most attractive feature for app developers, far ahead of push notifications. Due to its limited availability, and less common use case, background sync doesn't play a significant role at the moment.

# Web app manifests

The web app manifest is a JSON-based file format that provides developers with a centralized place to put metadata associated with a web application, it dictates how the application should behave on desktop or mobile in terms of the icon, orientation, theme color and likes.

It is not a mandate that the web app manifest can’t exist independently, but just its presence can’t make it a progressive web application, below are some stats we collected in terms of the web manifest usage and the month of September 2020, which has both servicewokers and manifest usage.


![](https://lh6.googleusercontent.com/rX5qgiYwz-tiHEthTNhF9po0Y-UjGkBcY6Z9h56U0mgLAsR1bAkti3GtOCi77PMrLBuLOc71arn_fuvCxx5U3vkmiFFA0zmozJaKRrxFg7cNQ0Be6Rm7OLd8uhIgUIGJ91qzdcKk "Chart")

  

## Manifest Properties

Web manifest dictates the applications meta properties, we looked at the different properties defined by the Web App Manifest specification, and also considered non-standard proprietary properties. According to the spec, the following properties are [allowed](https://w3c.github.io/manifest/#webappmanifest-dictionary):

1.  background_color
    
2.  categories
    
3.  description
    
4.  dir
    
5.  display
    
6.  iarc_rating_id
    
7.  icons
    
8.  lang
    
9.  name
    
10.  orientation
    
11.  prefer_related_applications
    
12.  related_applications
    
13.  scope
    
14.  screenshots
    
15.  short_name
    
16.  shortcuts
    
17.  start_url
    
18.  theme_color
    

Interestingly there were very little differences between mobile and desktop stats.

The proprietary properties we encountered frequently were gcm_sender_id Google Cloud Messaging (GCM) service we found other interesting attributes like: browser_action, DO_NOT_CHANGE_GCM_SENDER_ID [which was an attribute that substituted a comment as JSON doesn’t provide comments], scope, public path, cacheDigest.

On both platforms, however, there's a long tail of properties that are not interpreted by browsers yet contain potentially useful metadata.

We also found a non-trivial amount of mistyped properties; our favorite ones being variation of theme-color, Theme_color, theme-color, Theme_color and oriendation.

In order for a PWA to be fruitful it needs to have a Manifest and a Service Worker. It is interesting to note that Manifests are used a lot more than SW. This is due, in large part, to the fact that CMS like wordpress, drupal and Joomla have Manifests by default.

![](https://lh3.googleusercontent.com/uoVbrzZ3ObLOuUpWxZAKVQ4VfHyDn0RDURK6vIXk9PmWLH__8Lfk50up9_pz6MOcZEDXEcqJfRJp_IAbGuWyuajck4FCpb7nyzWq7BPf4BEOwhnTnhLPqTvdpwYEXjYJ1ifzaWoz "Chart")

  

### Top Manifest display values

  

![](https://lh4.googleusercontent.com/9Zt-ATZ9VyFONGGrwbqITljbpandMoDJRL1Y2LSGLSnvP69UiEFOT-gVqo-1mQP2tB9WB5tY2ZCBSvL3nasH2CyGzO3B8ciXhaoUVfO6S4zuydmz2cBDpH-6pn1SLmnvnXXxe-7A "Chart")


### Top manifest categories

Note these numbers are different than 2019 version as we are looking into PWA pages (i.e. Manifests and SW) as it makes more sense to concentrate on the PWA stats and ignoring the non-PWA for this section.

![](https://lh3.googleusercontent.com/6J-6UxsYmeOF-AB33I0UlztOXArk8fY1hl4zPyeMgiW1Uk9ZQtvfeQSkkOfX-uDQrE-I0_ovCOnAzeFuX3Ci5VA2KCPEmXFvTKH6ACKTmbTu0DRRw2TMfXcCtRQU0AVxH3m5EHn5 "Chart")


### Manifests preferring native

![](https://lh4.googleusercontent.com/AE9HbDCOmo7QQVjE2Hk9AgZkOm9sYQZXQ4dIcTZtvwVVsHbvutsU-__0XvIXQDbm1OyeB2cftqGZaUQjUY15gOa4NY92wVJtw2vpuwx_atfzUgPO-FpqUhSnPFc5pVkL1Lg1zARc "Chart")


### Top manifest icon sizes

![](https://lh4.googleusercontent.com/uRxARqeBve_s_Sz4Q5rBHiyRR_ShohFtpOt4jxO4qN1p0oBs-P4qgedt04iYG8Okthcs90TK8PS2OzfhkR_7ehgLd5EN5O4RixSVn7u0BlB8z8tyYoXwmXiWnbFsttUAp8Manm0E "Chart")

Lighthouse requires at least an icon sized 192x192 pixels, but common favicon generation tools create a plethora of other sizes, too. It is always better to use the recommended icon size so that it looks as intended.

  

### Top manifest orientations

The valid values for the orientation property are defined in the Screen Orientation API [specification](https://www.w3.org/TR/screen-orientation/). Currently, they are:

 1. "any"
 2.  "natural"
 3. "landscape"
 4. "portrait"
 5. "portrait-primary"
 6. "portrait-secondary"
 7. "landscape-primary"
 8. "landscape-secondary"

Out of which we noticed that portrait, any and portrait-primary properties took precedence.

![](https://lh4.googleusercontent.com/X3Ua3TbS3FamLhLfgz1zl2BQ4xXaExqTxCQcNLaAql77pDKIUFrHFg0267RjGBmPAe_TwYDutXDef82cNVvRcKy-BqlZcuaZALLYX8kfHwFcdyqb5zTvKbGLEdnIdTqwwumsz9Zi "Chart")

  

# Servicewoker library Metrics

## Popular scripts pulling into service workers using ImportScript

The importScripts() API of the WorkerGlobalScope interface synchronously imports one or more scripts into the worker's scope, the same is used to import external dependencies to the serviceworker.

![](https://lh4.googleusercontent.com/PDuGCDZWRwv0QIxwzSIEX8YLoP95MwwRyvyNCw7hg74mi4VJwMpjHnTqe4NGTM83W4Egqj6gGgFm7X-ZpCwyT8z_78WQaazYCDHfsVx5kkjcnVLxAbdRNVARhXC88FnNcRTAvFOZ "Chart")

Around 30% of the Desktop and 25% of Mobile environments uses importScripts, which indicates that these use cases are requiring external libraries, out of which workbox, sw_toolbox and firebase take the first three positions respectively.

## Workbox Adoptions and package methods

Out of many libraries available workbox stood first with an adoption rate of **12.86%** and **15.29%** on mobile and desktop environments respectively.

Out of many methods that workbox provides, we noticed that strategies were used by **29.53%** of Desktop and **25.71%** on Mobile, routing followed it with **18.91%** and **15.61%** adoption and finally precaching caught up with **16.54%** and **12.98%** on Desktop and mobile respectively.

This indicated that strategies API played a very important role and one of the most complicated requirements for the developers to decide natively and relayed on libraries like workbox and like.

![](https://lh6.googleusercontent.com/b5tj8yocToC8Pa_-QiJklYeHsODSPFSBPAG9yhMqhh-SnyO5LJxxdFaVVyALftXBkWGhtxGtcFstgYqqgTSF1P1U7BfUAEBbUf98x8r3xQjimGvNq1EtW7mPnlDIsgFX357oMcfW "Chart")

  

# Conclusion

The stats in this chapter show that PWAs have come a long way in terms of adoption but with the advantages they give for [performance](https://almanac.httparchive.org/en/2019/performance) and greater control over [caching](https://almanac.httparchive.org/en/2019/caching) particularly for [mobile](https://almanac.httparchive.org/en/2019/mobile-web) should mean that usage we still have a lot of potential for growth and when compared to 2019 we have gotten better in both capabilities and adoptions, we would for sure have more progress in 2021!

More and more browsers and platforms are supporting the technologies powering PWAs. This year, we saw that Edge gained support for the Web App Manifest. Depending on your use case and target market, you may find that the majority of your users (close to 96%) have PWA support. That is a great improvement! In all cases, it’s important to approach technologies such as Service Worker, Web App Manifest should be treated as progressive enhancement. Where you can provide an exceptional user experience through these technologies whenever possible.
With the above stats, we’re excited for another year of PWA growth!
