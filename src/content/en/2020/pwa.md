---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 14
title: PWA
description: PWA chapter of the 2020 Web Almanac covering service workers (registations, installability, events and filesizes), Web App Manifests properties, and Workbox.
authors: [hemanth]
reviewers: [thepassle, jadjoubran, pearlbea, gokulkrishh]
analysts: [bazzadp]
translators: []
hemanth_bio: <a href="https://h3manth.com">Hemanth HN</a> is a FOSS Computer polyglot, FOSS philospher, GDE for web and payments domain, DuckDuckGo community member, TC39 delegate and Google Launchpad Accelerator mentor. Loves The WEB && CLI. Hosts <a href="https://TC39er.us">TC39er.us</a> podcast.
discuss: 2050
results: https://docs.google.com/spreadsheets/d/1AOqCkb5EggnE8BngpxvxGj_fCfssT9sZ0ElCQKp4pOw/
queries: 14_PWA
featured_quote: Web application which progresses into a native-like application can be considered as a PWA.
featured_stat_1: 16.6%
featured_stat_label_1: Percentage of page loads using a service worker.
featured_stat_2: 27.97%
featured_stat_label_2: Web apps that load fast enough for a PWA.
featured_stat_3: 25%
featured_stat_label_3: Percentage of mobile PWA sites using importScripts.
unedited: true
---

## Introduction

In 1990 we had the first ever browser called the “WorldWideWeb” and ever since the web and the browser have been evolving and for the web to progress itself into a native behaviour is a big win especially in this era of mobile domination. URLs and web browsers have provided a ubiquitous way to distribute information and so a technology which provides native app capabilities to the browser is a game changer. Progressive Web Apps provide such advantages for the web to compete with other applications.

Simply put, a web application which give native-like application experience can be considered as a PWA,. It is built using common web technologies including HTML, CSS and JavaScript and can operate seamlessly across devices and environments on a standards-compliant browser.

The crux of a progressive web app is the _service worker_, which can be thought of as a proxy sitting between the browser and user. A service worker gives the developer total control over the network, rather than the network controlling the application.

It all started in December 2014 when Chrome 40 first implemented the meat of what is now known as Progressive Web Apps which was a collaborative effort for the web standards body and the terms was coined by [Frances Berriman and Alex Russell](https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/) in 2015.

In this chapter of Web Almanac we will be looking into each of the components that make PWA what it is, from a data-driven perspective.

## Service workers

Service workers are at the very center of the progressive web apps and can be thought as a proxy servers between web applications running in browsers and the network. They help developers control the network requests rather than the network requests controlling the application.

### Service worker usage

From the data we gathered it was derived that about **0.88%** for desktop, **0.87%** for mobile for the month of August 2020 it's 49,305 (out of 5,593,642) for desktop and 55,019 (out of 6,347,919) for mobile. It is important that we realize that it translates into **16.6%** of the entire [traffic](https://www.chromestatus.com/metrics/feature/timeline/popularity/990).

{{ figure_markup(
  image="pwa-timeseries-of-service-worker-installations.png",
  caption="Timeseries of Service Worker installation.",
  description="Line graph of Service Worker installation starting at 0.03% for desktop, 0.04% for mobile in January 2017 and growing in a roughly linear fashion to 0.88% for desktop and 0.87% for mobile. In general desktop and mobile follow each other closely with mobile outpacing desktop for until mid 2018, what looks like an anomaly for the second half of 2018 and then desktop outpacing mobile from the start of 2019 until now.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1883263914&format=interactive",
  sheets_gid="1626594877",
  sql_file="sw_adoption_over_time.sql"
  )
}}

## Insights from lighthouse scores

[Lighthouse](https://github.com/GoogleChrome/lighthouse) provides automated auditing, performance metrics, and best practices for the web and has been instrumental in shaping web’s performance. The score we gathered over 6811475 pages, has given us great insights on a few important touch points for the month of September 2020.

<figure>
  <table>
    <thead>
      <tr>
        <th>Lighthouse Audit</th>
        <th>Weight</th>
        <th>Percentage</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>load-fast-enough-for-pwa</td>
        <td class="numeric">7</td>
        <td class="numeric">27.97%*</td>
      </tr>
      <tr>
        <td>works-offline</td>
        <td class="numeric">5</td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td>installable-manifest</td>
        <td class="numeric">2</td>
        <td class="numeric">2.21%</td>
      </tr>
      <tr>
        <td>is-on-https</td>
        <td class="numeric">2</td>
        <td class="numeric">66.67%</td>
      </tr>
      <tr>
        <td>redirects-http</td>
        <td class="numeric">2</td>
        <td class="numeric">70.33%</td>
      </tr>
      <tr>
        <td>viewport</td>
        <td class="numeric">2</td>
        <td class="numeric">88.43%</td>
      </tr>
      <tr>
        <td>apple-touch-icon</td>
        <td class="numeric">1</td>
        <td class="numeric">34.75%</td>
      </tr>
      <tr>
        <td>content-width</td>
        <td class="numeric">1</td>
        <td class="numeric">79.37%</td>
      </tr>
      <tr>
        <td>maskable-icon</td>
        <td class="numeric">1</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>offline-start-url</td>
        <td class="numeric">1</td>
        <td class="numeric">0.75%</td>
      </tr>
      <tr>
        <td>service-worker</td>
        <td class="numeric">1</td>
        <td class="numeric">1.03%</td>
      </tr>
      <tr>
        <td>splash-screen</td>
        <td class="numeric">1</td>
        <td class="numeric">1.90%</td>
      </tr>
      <tr>
        <td>themed-omnibox</td>
        <td class="numeric">1</td>
        <td class="numeric">4.00%</td>
      </tr>
      <tr>
        <td>without-javascript</td>
        <td class="numeric">1</td>
        <td class="numeric">97.57%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Lighthouse PWA audits.", sheets_gid="814184412", sql_file="lighthouse_pwa_audits.sql") }}</figcaption>
</figure>

<p class="note">Note the Lighthouse performance stats were incorrect for August so the load-fast-enough-for-pwa stat has been replaced with September results.</p>

A [fast](https://web.dev/load-fast-enough-for-pwa/) page load over a cellular network ensures a good mobile user experience.

**27.56%** of pages loaded fast enough for a PWA. Given how geo distributed the web is, having a fast load time with lighter pages matter the most of the next billion users of the web, most of them were introduced to the internet via a mobile device.

If you're building a Progressive Web App, consider using a service worker so that your app can [work offline](https://web.dev/works-offline/) **0.92%** of pages were offline ready.

Browsers can proactively prompt users to add your app to their homescreen, which can lead to higher engagement. **2.21%** of pages had an [Installable manifest](https://web.dev/installable-manifest/). Manifest plays an important role in how the application starts, the looks and feel of the icon on the homescreen and as an impact on the engagement rate directly.

All sites should be protected with HTTPS, even ones that don't handle sensitive data. This includes avoiding [mixed content](https://developers.google.com/web/fundamentals/security/prevent-mixed-content/what-is-mixed-content), where some resources are loaded over HTTP despite the initial request being served over HTTPS. HTTPS prevents intruders from tampering with or passively listening in on the communications between your app and your users, and is a prerequisite for HTTP/2 and many new web platform APIs. Learn more about [is-on-https check](https://web.dev/is-on-https/). **67.27%** of sites were on HTTPS and it is surprising that we haven’t reached there yet. This number is pretty decent and will get better as browsers mandate the applications to be on HTTPS and scrutinize those which are not on HTTPS.

If you've already set up HTTPS, make sure that you [redirect all](https://web.dev/redirects-http/) HTTP traffic to HTTPS in order to enable secure connection the users without changing the URL **69.92%** of the sites redirects HTTP. Redirecting all the HTTP to HTTPS on your application should be simple steps towards robustness, though the HTTP redirection to HTTPS has a decent number, it can do better.

By adding `<meta name="viewport">` tag to optimize your app for mobile screens. **88.43%** of the sites have the [viewport]((https://web.dev/viewport/) meta tag. It is not surprising that the usage of viewport meta tag is on the higher side as most of the applications are aware and getting there in terms of viewport optimization.

For ideal appearance on iOS, your progressive web app should define an `apple-touch-icon` meta tag. It must point to a non-transparent 192px (or 180px) square PNG. **32.34%** of the sites use the [apple touch icon](https://web.dev/apple-touch-icon/).

If the width of your app's content doesn't match the width of the viewport, your app might not be optimized for mobile screens. **79.18%** of the sites have the [content-width](https://web.dev/content-width/) set.

A [maskable icon](https://web.dev/maskable-icon-audit/) ensures that the image fills the entire shape without being letterboxed when adding the progressive web app to the home screen. **0.14%** of sites use this, given that it is a brand new feature, the percentage of adaptation is pretty decent. This being a new feature we were expecting the numbers to be low and for sure shall improve in the coming years.

A service worker enables your web app to be reliable in unpredictable network conditions. **0.77%** of sites has an [offline start URL](https://web.dev/offline-start-url/).

The [service worker](https://web.dev/service-worker/) is the feature that enables your app to use many Progressive Web App features, such as offline, add to homescreen, and push notifications. **1.05%** of pages have service workers enabled, bare in mind this for the month of September 2020. Serviceworker helps to achieve offline support, which is the most important feature for a PWA, as flaky networks are the most common issue that the user of web applications face and this is circumvented with Serviceworkers, it is pretty surprising that number was this low for the month under investigation.

A themed [splash screen](https://web.dev/splash-screen/) ensures a native like experience when users launch your app from their homescreens. **1.95%** of pages had splash screens.

The browser address bar can be themed to match your site. **3.98%** of pages had themed [omnibox](https://web.dev/themed-omnibox/).

Your app should display some content when JavaScript is disabled, even if it's just a warning to the user that JavaScript is required to use the app. **96.23%** pages can work with JavaScript [disabled](https://web.dev/without-javascript/).

## Service worker events

In a service worker one can listen for a number of events:

1.  `install`, which occurs upon service worker installation.
2.  `activate`, which occurs upon service worker activation.
3.  `fetch`, which occurs whenever a resource is fetched.
4.  `push`, which occurs when a push notification arrives.
5.  `notificationclick`, which occurs when a notification is being clicked.
6.  `notificationclose`, which occurs when a notification is being closed.
7.  `message`, which occurs when a message sent via postMessage() arrives.
8.  `sync`, which occurs when a background sync event occurs.

{{ figure_markup(
  image="pwa-most-used-service-worker-events.png",
  caption="Most used service worker events.",
  description="Bar chart showing the percentage of the most used service worker events, with `install` used by 69% of desktop sites with service workers and 73% of mobile sites, `fetch` used by 66% and 71%, `activate` used by 55% and 59%, `notificationclick` by 24% and 20%, `push` by 23% and 20%, `message` by 8% and 6%, `notificationclose` by 3% for both desktop and mobile, and `sync` used by 1% of both",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1964906335&format=interactive",
  sheets_gid="1698485238",
  sql_file="sw_events.sql"
  )
}}

We have examined which of these events are being listened to by service workers we could find in the HTTP Archive. The results for mobile and desktop are very similar with install, fetch, and activate being the three most popular events, followed by message, notification click, push and sync. If we interpret these results, offline use cases that service workers enable are the most attractive feature for app developers, far ahead of push notifications. Due to its limited availability, and less common use case, background sync doesn't play a significant role at the moment.

## Web app manifests

The web app manifest is a JSON-based file format that provides developers with a centralized place to put metadata associated with a web application, it dictates how the application should behave on desktop or mobile in terms of the icon, orientation, theme color and likes.

It is not a mandate that the web app manifest can’t exist independently, but just its presence can’t make it a progressive web application, below are some stats we collected in terms of the web manifest usage and the month of September 2020, which has both servicewokers and manifest usage.

{{ figure_markup(
  image="pwa-manifest-and-service-worker-usage.png",
  caption="Manifest and service worker usage.",
  description="Bar chart showing percentage of pages with manifests, service workers or both showing 6.04% of desktop pages and 5.66% of mobile pages have a manifest, 0.76% of desktop and 0.84% of mobile have a service worker and 0.59% of desktop pages and 0.68% of mobile pages have both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=257125618&format=interactive",
  sheets_gid="227354805",
  sql_file="manifests_and_service_workers.sql"
  )
}}

### Manifest Properties

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
10. orientation
11. prefer_related_applications
12. related_applications
13. scope
14. screenshots
15. short_name
16. shortcuts
17. start_url
18. theme_color

Interestingly there were very little differences between mobile and desktop stats.

The proprietary properties we encountered frequently were gcm_sender_id Google Cloud Messaging (GCM) service we found other interesting attributes like: browser_action, DO_NOT_CHANGE_GCM_SENDER_ID [which was an attribute that substituted a comment as JSON doesn’t provide comments], scope, public path, cacheDigest.

On both platforms, however, there's a long tail of properties that are not interpreted by browsers yet contain potentially useful metadata.

We also found a non-trivial amount of mistyped properties; our favorite ones being variation of theme-color, Theme_color, theme-color, Theme_color and oriendation.

In order for a PWA to be fruitful it needs to have a Manifest and a Service Worker. It is interesting to note that Manifests are used a lot more than SW. This is due, in large part, to the fact that CMS like wordpress, drupal and Joomla have Manifests by default.

{{ figure_markup(
  image="pwa-manifest-properties-on-service-worker-pages.png",
  caption="Manifest properties on service worker pages.",
  description="Bar chart showing the percentage of various manifest properties used on service worker pages by desktop and mobile. The first seven properties (`name`, `display`, `icons`, `short_name`, `start_url`, `theme_color`, and `background_color`) are used by 93 to 98% of both desktop and mobile. After this there is a sharp drop off for the remaining properties with `gcm_sender_id` used by 21.66% of desktop sites and 28.98% of mobile sites, `scope` used by 29.32% of desktop and 28.77% of mobile, `description` used by 23.32% of desktop and 18.84% mobile, `orientation` by 19.45% of desktop and 17.65% of mobile, and finally `lang` used by 12.31% of desktop and 11.01% of mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=257125618&format=interactive",
  sheets_gid="887021927",
  sql_file="top_manifest_properties_sw.sql"
  )
}}

### Top Manifest display values

Out of the five most common `display` values, `standalone` dominated the list with `86.73%` of desktop and `89.28%` of mobile pages display mode was `standalone` which isn't suprising at all as this mode provide the native app like feel and next in the list was `minimal-ui` with `6.30%` of desktop and `5.00%` of mobile opting for them as it is closers to `standalone` apart for the fact thatbut some browser UI is retained.

{{ figure_markup(
  image="pwa-most-used-display-values-for-service-worker-pages.png",
  alt="Most used display values for service worker pages.",
  caption="Most used `display` values for service worker pages.",
  description="Bar chart showing the percentage of pages using the 5 most common `display` values, dominated by `standalone` which is used by 86.73% of desktop and 89.28% of mobile pages, `minimal-ui` is used by 6.30% of desktop and 5.00% of mobile, `fullscreen` by 4.80% of desktop and 4.11% of mobile, 1.15% of desktop pages and 0.88% of mobile pages do not set a `display` value, and finally 1.00% of desktop and 0.72% of mobile set this to `browser`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=872942071&format=interactive",
  sheets_gid="1208193001",
  sql_file="top_manifest_display_values_sw.sql"
  )
}}

### Top manifest categories

In [last year's section on manifests](../2019/pwa#web-app-manifests), we looked at all manifests in our datasets. This year we have decided to concentrate only on sites which have both a manifest and a service worker–in other words PWAs–and the data in this section therefore only details PWA manifests.

Out of all the top `categories`, shopping stood at the top at with `13.16%` on the mobile traffic, which is pretty predictable as most of the PWAs are e-commerce applications and next in the position is news with `5.26%` on the mobile traffic.

{{ figure_markup(
  image="pwa-manifest-categories.png",
  caption="PWA manifest categories.",
  description="Bar chart showing the percentage of PWA pages for the top 10 most popular categories with shopping have 3.45% of desktop but a huge 13.46% of mobile pages towering above the other figures. After that news has 4.60% of desktop and 5.26% of mobile, entertainment has 6.90% and 5.26% respectively, utilities have 6.32% and 4.74%, business has 6.90% and 4.74%, lifestyle having 2.87% and 3.16, social 2.87% and 2.63%, finance having 2.87% and 2.63% and finally web having 1.72% and 2.11%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=137093819&format=interactive",
  sheets_gid="423855457",
  sql_file="top_manifest_categories_sw.sql"
  )
}}

### Manifests preferring native

`98.24%` of destop sites prefer native, and `98.52%` of mobile sites prefer native, this is a signal that there are many web applications that just have a manifest and isn't really a PWA yet, but is making use of the manifest to prefer native.

{{ figure_markup(
  image="pwa-manifest-preferring-native.png",
  caption="Manifest preferring native.",
  description="Horiztonal stacked bar chart showing that on desktop 98.24% of destop sites prefer native, and 98.52% of mobile sites prefer native.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1370804413&format=interactive",
  sheets_gid="153006256",
  sql_file="manifests_preferring_native_apps_sw.sql"
  )
}}

### Top manifest icon sizes

{{ figure_markup(
  image="pwa-top-manifest-icon-sizes.png",
  caption="Top manifest icon sizes.",
  description="Bar chart showing the top icon sizes with 192 by 192 pixels being used by 19.10% of desktop sites and 19.76% of mobile sites, similar numbers for the next size of 512 by 512 pixels with 18.21% and 18.85%. This is followed by a sharp drop for 96 by 96 pixels having 7.21% for desktop and 7.11% for mobile, and then it continues to drop roughly linearly for the remaining values of 72 by 72 pixels, 48 by 48 pixels, 128 by 128 pixels, 152 by 152 pixels, 384 by 384 pixels, 256 by 256 pixels, 36 by 26 pixels, 196 by 196 pixels, 120 by 120 pixels, 168 by 168 pixels, 32 by 32 pixels until we get to 16 by 16 pixels used by 0.89% of desktop sites and 0.81% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=263579568&format=interactive",
  sheets_gid="806224609",
  sql_file="top_manifest_icon_sizes_sw.sql"
  )
}}

Lighthouse requires at least an icon sized 192x192 pixels, but common favicon generation tools create a plethora of other sizes, too. It is always better to use the recommended icon size so that it looks as intended.

### Top manifest orientations

The valid values for the orientation property are defined in the Screen Orientation API [specification](https://www.w3.org/TR/screen-orientation/). Currently, they are:

1. "any"
2. "natural"
3. "landscape"
4. "portrait"
5. "portrait-primary"
6. "portrait-secondary"
7. "landscape-primary"
8. "landscape-secondary"

Out of which we noticed that portrait, any and portrait-primary properties took precedence.

{{ figure_markup(
  image="pwa-top-manifest-orientations.png",
  caption="Top manifest orientations.",
  description="Bar chart showing the top 5 manifest orientations with `portrait` used by 14.25% of desktop sites and 14.47% of mobile, `any` used by 7.25% of desktop and 6.45% of mobile, `portrait-primary` used by 1.56% of desktop and 1.52% mobile, `natural` used by 0.86% of desktop and 0.79% of mobile, and finally `landscape` is used by 0.53% of desktop and 0.39% of mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1217279338&format=interactive",
  sheets_gid="2070230147",
  sql_file="top_manifest_orientations_sw.sql"
  )
}}

## Servicewoker library Metrics

There are many cases, where the serviceworkers would need many libraries as dependencies, may it be external dependencies or the application's internal dependencies that are fetched to the serviceworker via `importScripts` API, in this section we will look into stats on such libraries.

### Popular scripts pulling into service workers using ImportScript

The [importScripts() API](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts) of the [WorkerGlobalScope interface](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope) synchronously imports one or more scripts into the worker's scope, the same is used to import external dependencies to the service worker.

<figure>
<table>
  <thead>
    <tr>
      <th>client</th>
      <th>desktop</th>
      <th>mobile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Uses Importscript</td>
      <td class="numeric">29.60%</td>
      <td class="numeric">23.76%</td>
    </tr>
    <tr>
      <td><code>Workbox<code></td>
      <td class="numeric">17.70%</td>
      <td class="numeric">15.25%</td>
    </tr>
    <tr>
      <td><code>sw_toolbox<code></td>
      <td class="numeric">13.92%</td>
      <td class="numeric">12.84%</td>
    </tr>
    <tr>
      <td><code>firebase<code></td>
      <td>3.40%</td>
      <td>3.09%</td>
    </tr>
    <tr>
      <td><code>OneSignalSDK<code></td>
      <td class="numeric">4.23%</td>
      <td class="numeric">2.76%</td>
    </tr>
    <tr>
      <td><code>najva<code></td>
      <td class="numeric">1.89%</td>
      <td class="numeric">1.52%</td>
    </tr>
    <tr>
      <td><code>upush<code></td>
      <td class="numeric">1.45%</td>
      <td class="numeric">1.23%</td>
    </tr>
    <tr>
      <td><code>cache_polyfill<code></td>
      <td class="numeric">0.70%</td>
      <td class="numeric">0.72%</td>
    </tr>
    <tr>
      <td><code>analytics_helper<code></td>
      <td class="numeric">0.34%</td>
      <td class="numeric">0.39%</td>
    </tr>
    <tr>
      <td>Other Library</td>
      <td class="numeric">0.27%</td>
      <td class="numeric">0.15%</td>
    </tr>
    <tr>
      <td>No Library</td>
      <td class="numeric">58.81%</td>
      <td class="numeric">64.44%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="PWA library usage.", sheets_gid="1399126426", sql_file="popular_pwa_libraries.sql") }}</figcaption>
</figure>

Around **30%** of the Desktop and **25%** of Mobile environments uses importScripts, which indicates that these use cases are requiring external libraries, out of which workbox, sw_toolbox and firebase take the first three positions respectively.

### Workbox usage

Out of many libraries available, Workbox was the most heavily used with an adoption rate of **12.86%** and **15.29%** of PWA sites on mobile and desktop respectively.

Out of many methods that Workbox provides, we noticed that `strategies` were used by **29.53%** of desktop and **25.71%** on mobile, `routing` followed it with **18.91%** and **15.61%** adoption and finally `precaching` were next most used with **16.54%** and **12.98%** on desktop and mobile respectively.

This indicated that the strategies API, as one of the most complicated requirements for the developers, played a very important role when they decided to code themselves or relay on libraries like Workbox.

{{ figure_markup(
  image="pwa-most-used-workbox-packages.png",
  caption="Most used Workbox packages.",
  description="Bar",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=550366577&format=interactive",
  sheets_gid="1614661441",
  sql_file="workbox_package_methods.sql"
  )
}}

## Conclusion

The stats in this chapter show that PWAs are still continuing to grow in adoption, due to the advantages they give for [performance](./performance) and greater control over [caching](./caching) particularly for [mobile](./mobile-web). With those advantages and ever increasing capabilities, means we still have a lot of potential for growth and when compared to 2019. We expect to see even more progress in 2021!

More and more browsers and platforms are supporting the technologies powering PWAs. This year, we saw that Edge gained support for the Web App Manifest. Depending on your use case and target market, you may find that the majority of your users (close to 96%) have PWA support. That is a great improvement! In all cases, it’s important to approach technologies such as Service Worker, Web App Manifest should be treated as progressive enhancement. Where you can provide an exceptional user experience through these technologies whenever possible.
With the above stats, we’re excited for another year of PWA growth!
