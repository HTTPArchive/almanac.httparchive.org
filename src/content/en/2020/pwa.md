---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: PWA chapter of the 2020 Web Almanac covering service workers (registrations, installability, events and filesizes), Web App Manifests properties, and Workbox.
authors: [hemanth]
reviewers: [thepassle, jadjoubran, pearlbea, gokulkrishh]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: []
hemanth_bio: <a hreflang="en" href="https://h3manth.com">Hemanth HM</a> is a Computer polyglot, FOSS philosopher, GDE for web and payments domain, DuckDuckGo community member, TC39 delegate and Google Launchpad Accelerator mentor. Loves The WEB && CLI. Hosts <a hreflang="en" href="https://TC39er.us">TC39er.us</a> podcast.
discuss: 2050
results: https://docs.google.com/spreadsheets/d/1AOqCkb5EggnE8BngpxvxGj_fCfssT9sZ0ElCQKp4pOw/
featured_quote: Web application which progresses into a native-like application can be considered as a PWA.
featured_stat_1: 16.6%
featured_stat_label_1: Percentage of page loads using a service worker.
featured_stat_2: 27.97%
featured_stat_label_2: Web apps that load fast enough for a PWA.
featured_stat_3: 25%
featured_stat_label_3: Percentage of mobile PWA sites using importScripts.
---

## Introduction

In 1990 the first ever browser called the "WorldWideWeb" was launched and ever since, the web and the browser have been evolving. For the web to progress itself into native application behavior is a big win especially in this era of mobile domination. URLs and web browsers have provided a ubiquitous way to distribute information and so a technology which provides native app capabilities to the browser is a game changer. Progressive Web Apps provide such advantages for the web to compete with other applications.

Simply put, a web application which give native-like application experience can be considered as a PWA. It is built using common web technologies including HTML, CSS and JavaScript and can operate seamlessly across devices and environments on a standards-compliant browser.

The crux of a progressive web app is the _service worker_, which can be thought of as a proxy sitting between the browser and user. A service worker gives the developer total control over the network, rather than the network controlling the application.

As [last year's chapter](../2019/pwa) stated, it started in December 2014 when Chrome 40 first implemented the meat of what is now known as Progressive Web Apps (PWA). This was a collaborative effort for the web standards body and the term PWA was coined by <a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">Frances Berriman and Alex Russell</a> in 2015.

In this chapter of Web Almanac we will be looking into each of the components that make PWA what it is, from a data-driven perspective.

## Service workers

Service workers are at the very center of progressive web apps. They help developers control the network requests.

### Service worker usage

From the data we gathered we can see that about 0.88% desktop sites and 0.87% mobile sites use a service worker. This was for the month of August 2020 and, to put that into perspective, that equates to 49,305 (out of 5,593,642) desktop sites and 55,019 (out of 6,347,919) mobile sites.

{{ figure_markup(
  image="pwa-timeseries-of-service-worker-installations.png",
  caption="Timeseries of service worker installation.",
  description="Line graph of service worker installation starting at 0.03% for desktop, 0.04% for mobile in January 2017 and growing in a roughly linear fashion to 0.88% for desktop and 0.87% for mobile. In general desktop and mobile follow each other closely with mobile outpacing desktop for until mid 2018, what looks like an anomaly for the second half of 2018 and then desktop outpacing mobile from the start of 2019 until now.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1883263914&format=interactive",
  sheets_gid="1626594877",
  sql_file="sw_adoption_over_time.sql"
  )
}}

While that usage may seem low, it is important that we realize that other measurements equate that to 16.6% of the <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">web traffic</a>–the difference being due to high traffic websites tending to use service workers more.

## Lighthouse insights

<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse">Lighthouse</a> provides automated auditing, performance metrics, and best practices for the web and has been instrumental in shaping web's performance. We looked at the PWA category audits gathered for over 6,782,042 pages and this has given us great insights on a few important touch points.

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
        <td><code>load-fast-enough-for-pwa</code></td>
        <td class="numeric">7</td>
        <td class="numeric">27.97%*</td>
      </tr>
      <tr>
        <td><code>works-offline</code></td>
        <td class="numeric">5</td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td><code>installable-manifest</code></td>
        <td class="numeric">2</td>
        <td class="numeric">2.21%</td>
      </tr>
      <tr>
        <td><code>is-on-https</code></td>
        <td class="numeric">2</td>
        <td class="numeric">66.67%</td>
      </tr>
      <tr>
        <td><code>redirects-http</code></td>
        <td class="numeric">2</td>
        <td class="numeric">70.33%</td>
      </tr>
      <tr>
        <td><code>viewport</code></td>
        <td class="numeric">2</td>
        <td class="numeric">88.43%</td>
      </tr>
      <tr>
        <td><code>apple-touch-icon</code></td>
        <td class="numeric">1</td>
        <td class="numeric">34.75%</td>
      </tr>
      <tr>
        <td><code>content-width</code></td>
        <td class="numeric">1</td>
        <td class="numeric">79.37%</td>
      </tr>
      <tr>
        <td><code>maskable-icon</code></td>
        <td class="numeric">1</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>offline-start-url</code></td>
        <td class="numeric">1</td>
        <td class="numeric">0.75%</td>
      </tr>
      <tr>
        <td><code>service-worker</code></td>
        <td class="numeric">1</td>
        <td class="numeric">1.03%</td>
      </tr>
      <tr>
        <td><code>splash-screen</code></td>
        <td class="numeric">1</td>
        <td class="numeric">1.90%</td>
      </tr>
      <tr>
        <td><code>themed-omnibox</code></td>
        <td class="numeric">1</td>
        <td class="numeric">4.00%</td>
      </tr>
      <tr>
        <td><code>without-javascript</code></td>
        <td class="numeric">1</td>
        <td class="numeric">97.57%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Lighthouse PWA audits.", sheets_gid="814184412", sql_file="lighthouse_pwa_audits.sql") }}</figcaption>
</figure>

<p class="note">Note the performance statistic for our Lighthouse tests were incorrect for our August crawl so the <code>load-fast-enough-for-pwa</code> result has been replaced with September results.</p>

A <a hreflang="en" href="https://web.dev/load-fast-enough-for-pwa/">fast page load</a> ensures a good mobile user experience, particularly when slower cellular networks are taken into consideration. 27.56% of pages loaded fast enough for a PWA. Given how geographically distributed the web is, having a fast load time with lighter pages matter the most of the next billion users of the web, most of whom will be introduced to the internet via a mobile device.

If you're building a Progressive Web App, consider using a service worker so that your app can <a hreflang="en" href="https://web.dev/works-offline/">work offline</a> 0.92% of pages were offline ready.

Browsers can proactively prompt users to add your app to their home screen, which can lead to higher engagement. 2.21% of pages had an <a hreflang="en" href="https://web.dev/installable-manifest/">installable manifest</a>. Manifest plays an important role in how the application starts, the looks and feel of the icon on the home screen and as an impact on the engagement rate directly.

All sites should be protected with HTTPS, even ones that don't handle sensitive data. This includes avoiding <a hreflang="en" href="https://developers.google.com/web/fundamentals/security/prevent-mixed-content/what-is-mixed-content">mixed content</a>, where some resources are loaded over HTTP despite the initial request being served over HTTPS. HTTPS prevents intruders from tampering with or passively listening in on the communications between your app and your users and is a prerequisite for service workers and many new web platform features and APIs like [HTTP/2](./http). The <a hreflang="en" href="https://web.dev/is-on-https/">is-on-https check</a> shows that 67.27% of sites were on HTTPS without mixed content and it is surprising that we haven't reached higher yet. The [Security](./security#transport-security) chapter shows that 86.91% of sites are using HTTPS, suggesting that mixed content may be the bigger issue now. This number will get better as browsers mandate the applications to be on HTTPS and scrutinize those which are not on HTTPS more.

If you've already set up HTTPS, make sure that you <a hreflang="en" href="https://web.dev/redirects-http/">redirect all HTTP traffic to HTTPS</a> in order to enable secure connection the users without changing the URL: only 69.92% of the sites pass this audit. Redirecting all the HTTP to HTTPS on your application should be simple steps towards robustness, though the HTTP redirection to HTTPS has a decent number of sites passing, it can do better.

By adding `<meta name="viewport">` tag you optimize your app for mobile screens. 88.43% of the sites have the <a hreflang="en" href="https://web.dev/viewport/">viewport</a> meta tag. It is not surprising that the usage of viewport meta tag is on the higher side as most developers and tools are aware of viewport optimization.

For ideal appearance on iOS, your progressive web app should define an `apple-touch-icon` meta tag. It must point to a non-transparent 192px (or 180px) square PNG. 32.34% of the sites pass the <a hreflang="en" href="https://web.dev/apple-touch-icon/">apple touch icon</a> check.

If the width of your app's content doesn't match the width of the viewport, your app might not be optimized for mobile screens. 79.18% of the sites have the <a hreflang="en" href="https://web.dev/content-width/">content-width</a> set correctly.

A <a hreflang="en" href="https://web.dev/maskable-icon-audit/">maskable icon</a> ensures that the image fills the entire shape without being letterboxed when adding the progressive web app to the home screen. Only 0.11% of sites use this, but given that it is a brand new feature, having any usage here is encouraging. As it has just been introduced we were expecting the numbers to be very low and these should improve in the coming years.

A service worker enables your web app to be reliable in unpredictable network conditions. 0.77% of sites have an <a hreflang="en" href="https://web.dev/offline-start-url/">offline start URL</a> to allow the app to run even when not connected to the network. This is one of the most important features for a PWA, as flaky networks are the most common issue that the users of web applications face.

The <a hreflang="en" href="https://web.dev/service-worker/">service worker</a> is the feature that enables your app to use many Progressive Web App features, such as offline usage and push notifications. 1.05% of pages have service workers enabled. Given the powerful features that can be addressed with service workers, and that it has been supported for some time now, it is surprising that number is still so low.

A themed <a hreflang="en" href="https://web.dev/splash-screen/">splash screen</a> ensures a native-like experience when users launch your app from their home screens. 1.95% of pages had splash screens.

The browser address bar can be themed to match your site. 4.00% of pages had themed <a hreflang="en" href="https://web.dev/themed-omnibox/">omnibox</a>.

Your app should display some content when JavaScript is disabled, even if it is just a warning to the user that JavaScript is required to use the app. 97.57% pages show more than just a blank page with JavaScript <a hreflang="en" href="https://web.dev/without-javascript/">disabled</a>. Given that we only survey the home pages, it's perhaps more surprising that 3.43% of sites fail this audit!

## Service worker events

In a service worker one can listen for a number of events:

1. `install`, which occurs upon service worker installation.
2. `activate`, which occurs upon service worker activation.
3. `fetch`, which occurs whenever a resource is fetched.
4. `push`, which occurs when a push notification arrives.
5. `notificationclick`, which occurs when a notification is being clicked.
6. `notificationclose`, which occurs when a notification is being closed.
7. `message`, which occurs when a message sent via postMessage() arrives.
8. `sync`, which occurs when a background sync event occurs.

We have examined which of these events are being listened to by service workers in our dataset.

{{ figure_markup(
  image="pwa-most-used-service-worker-events.png",
  caption="Most used service worker events.",
  description="Bar chart showing the percentage of the most used service worker events, with `install` used by 69% of desktop sites with service workers and 73% of mobile sites, `fetch` used by 66% and 71%, `activate` used by 55% and 59%, `notificationclick` by 24% and 20%, `push` by 23% and 20%, `message` by 8% and 6%, `notificationclose` by 3% for both desktop and mobile, and `sync` used by 1% of both",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1964906335&format=interactive",
  sheets_gid="1698485238",
  sql_file="sw_events.sql"
  )
}}

 The results for mobile and desktop are very similar with `install`, `fetch`, and `activate` being the three most popular events, followed by `message`, `notification click`, `push` and `sync`. If we interpret these results, offline use cases that service workers enable are the most attractive feature for app developers, far ahead of push notifications. Due to its limited availability, and less common use case, background sync doesn't play a significant role at this time.

## Web app manifests

The web app manifest is a JSON-based file that provides developers with a centralized place to put metadata associated with a web application. It dictates how the application should behave on desktop or mobile in terms of the icon, orientation, theme color and likes.

In order for a PWA to be fruitful it needs to have a manifest and a service worker. It is interesting to note that manifests are used a lot more than service workers. This is due, in large part, to the fact that CMS like WordPress, Drupal and Joomla have manifests by default.

{{ figure_markup(
  image="pwa-manifest-and-service-worker-usage.png",
  caption="Manifest and service worker usage.",
  description="Bar chart showing percentage of pages with manifests, service workers or both showing 6.04% of desktop pages and 5.66% of mobile pages have a manifest, 0.76% of desktop and 0.84% of mobile have a service worker and 0.59% of desktop pages and 0.68% of mobile pages have both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=257125618&format=interactive",
  sheets_gid="227354805",
  sql_file="manifests_and_service_workers.sql"
  )
}}

Having a web app manifest does not necessarily indicate the site is a progressive web app, as they can exist independently of service worker usage. However, as we are interested in PWAs in this chapter, we have investigated only those manifests for sites where a service worker also exists. This is different than the approach taken in [last year's PWA chapter](../2019/pwa#web-app-manifests) which looked at overall manifest usage, so you may notice some differences in results this year.

### Manifest Properties

Web manifest dictates the applications meta properties. We looked at the different properties defined by the Web App Manifest specification, and also considered non-standard proprietary properties.

{{ figure_markup(
  image="pwa-manifest-properties-on-service-worker-pages.png",
  caption="Manifest properties on service worker pages.",
  description="Bar chart showing the percentage of various manifest properties used on service worker pages by desktop and mobile. The first seven properties (`name`, `display`, `icons`, `short_name`, `start_url`, `theme_color`, and `background_color`) are used by 93 to 98% of both desktop and mobile. After this there is a sharp drop off for the remaining properties with `gcm_sender_id` used by 21.66% of desktop sites and 28.98% of mobile sites, `scope` used by 29.32% of desktop and 28.77% of mobile, `description` used by 23.32% of desktop and 18.84% mobile, `orientation` by 19.45% of desktop and 17.65% of mobile, and finally `lang` used by 12.31% of desktop and 11.01% of mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=427650634&format=interactive",
  sheets_gid="887021927",
  sql_file="top_manifest_properties_sw.sql"
  )
}}

According to <a hreflang="en" href="https://w3c.github.io/manifest/#webappmanifest-dictionary">the spec, the following properties are valid properties</a>:

- `background_color`
- `categories`
- `description`
- `dir`
- `display`
- `iarc_rating_id`
- `icons`
- `lang`
- `name`
- `orientation`
- `prefer_related_applications`
- `related_applications`
- `scope`
- `screenshots`
- `short_name`
- `shortcuts`
- `start_url`
- `theme_color`

There were very little differences between mobile and desktop stats.

The proprietary properties we encountered frequently were `gcm_sender_id` used by Google Cloud Messaging (GCM) service. We also found other interesting attributes like: `browser_action`, `DO_NOT_CHANGE_GCM_SENDER_ID` (which was basically a comment, used as JSON doesn't allow comments), `scope`, `public path`, `cacheDigest`.

On both platforms, however, there's a long tail of properties that are not interpreted by browsers yet contain potentially useful metadata.

We also found a non-trivial number of mistyped properties; our favorite ones being variation of `theme-color`, `Theme_color`, `theme-color`, `Theme_color` and `orientation`.

### Top Manifest display values

{{ figure_markup(
  image="pwa-most-used-display-values-for-service-worker-pages.png",
  caption="Most used `display` values for service worker pages.",
  description="Bar chart showing the percentage of pages using the 5 most common `display` values, dominated by `standalone` which is used by 86.73% of desktop and 89.28% of mobile pages, `minimal-ui` is used by 6.30% of desktop and 5.00% of mobile, `fullscreen` by 4.80% of desktop and 4.11% of mobile, 1.15% of desktop pages and 0.88% of mobile pages do not set a `display` value, and finally 1.00% of desktop and 0.72% of mobile set this to `browser`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=872942071&format=interactive",
  sheets_gid="1208193001",
  sql_file="top_manifest_display_values_sw.sql"
  )
}}

Out of the five most common `display` values, `standalone` dominated the list with 86.73% of desktop and 89.28% of mobile pages using this. This isn't surprising at all as this mode provides the native app-like feel. Next in the list was `minimal-ui` with 6.30% of desktop and 5.00% of mobile sites opting for them. This is similar to `standalone` except for the fact that some browser UI is retained.

### Top manifest categories

{{ figure_markup(
  image="pwa-manifest-categories.png",
  caption="PWA manifest categories.",
  description="Bar chart showing the percentage of PWA pages for the top 10 most popular categories with shopping have 3.45% of desktop but a huge 13.46% of mobile pages towering above the other figures. After that news has 4.60% of desktop and 5.26% of mobile, entertainment has 6.90% and 5.26% respectively, utilities have 6.32% and 4.74%, business has 6.90% and 4.74%, lifestyle having 2.87% and 3.16, social 2.87% and 2.63%, finance having 2.87% and 2.63% and finally web having 1.72% and 2.11%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=137093819&format=interactive",
  sheets_gid="423855457",
  sql_file="top_manifest_categories_sw.sql"
  )
}}

Out of all the top `categories`, `shopping` stood at the top at with 13.16% on the mobile traffic, which is not unexpected as PWAs are e-commerce applications. `news` was next with 5.26% on the mobile traffic.

### Manifests preferring native

{{ figure_markup(
  image="pwa-manifest-preferring-native.png",
  caption="Manifest preferring native.",
  description="Horizontal stacked bar chart showing that on desktop 98.24% of desktop sites prefer native, and 98.52% of mobile sites prefer native.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1370804413&format=interactive",
  sheets_gid="153006256",
  sql_file="manifests_preferring_native_apps_sw.sql"
  )
}}

98.24% of desktop PWA sites and 98.52% of mobile PWA sites set the `preferred_related_applications` manifest property to not prefer native apps, but instead use web version where they exist. For the small percentage where this is set to `true` this is a signal that there are many web applications that just have a manifest but aren't really full PWAs yet.

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

Lighthouse requires at least an icon sized 192x192 pixels, but common favicon generation tools create a plethora of other sizes, too. It is always better to use the recommended icon sizes for each device so it is encouraging to see such a widespread usage of different icon sizes.

### Top manifest orientations

{{ figure_markup(
  image="pwa-top-manifest-orientations.png",
  caption="Top manifest orientations.",
  description="Bar chart showing the top 5 manifest orientations with `portrait` used by 14.25% of desktop sites and 14.47% of mobile, `any` used by 7.25% of desktop and 6.45% of mobile, `portrait-primary` used by 1.56% of desktop and 1.52% mobile, `natural` used by 0.86% of desktop and 0.79% of mobile, and finally `landscape` is used by 0.53% of desktop and 0.39% of mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1217279338&format=interactive",
  sheets_gid="2070230147",
  sql_file="top_manifest_orientations_sw.sql"
  )
}}

The valid values for the orientation property are defined in the Screen Orientation API <a hreflang="en" href="https://www.w3.org/TR/screen-orientation/">specification</a>. Currently, they are:

- `any`
- `natural`
- `landscape`
- `portrait`
- `portrait-primary`
- `portrait-secondary`
- `landscape-primary`
- `landscape-secondary`

Out of which we noticed that `portrait`, `any` and `portrait-primary` properties took precedence.

## Service worker libraries

There are many cases, where the service workers use libraries as dependencies, be it external dependencies or the application's internal dependencies. These are usually fetched to the service worker via the `importScripts()` API. In this section we will look into stats on such libraries.

### Popular import scripts

The [importScripts() API](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts) of the [WorkerGlobalScope interface](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope) synchronously imports one or more scripts into the worker's scope. The same is used to import external dependencies to the service worker.

<figure>
<table>
  <thead>
    <tr>
      <th>Script</th>
      <th>Desktop</th>
      <th>Mobile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Uses <code>importScripts()</code></td>
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
      <td class="numeric">3.40%</td>
      <td class="numeric">3.09%</td>
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

Around 30% of desktop PWA sites and 25% of mobile PWA sites uses `importScripts()`, of which `workbox`, `sw_toolbox` and `firebase` take the first three positions respectively.

### Workbox usage

Out of many libraries available, Workbox was the most heavily used with an adoption rate of 12.86% and 15.29% of PWA sites on mobile and desktop respectively.

{{ figure_markup(
  image="pwa-most-used-workbox-packages.png",
  caption="Most used Workbox packages.",
  description="Bar chart showing the most used Workbox packages in descending order of usage: `strategies` is used by 29.53% of desktop service worker pages, and 25.71% of mobile, `routing` by 18.91% and 15.61% respectively, `precaching` by 16.54% and 12.98%, `core` by 16.28% 12.44%, `expiration` by 7.49% 7.13%,`setConfig` by 6.54% 4.80%, and `skipWaiting` is used by 3.89% of desktop service worker sites and 3.03% of mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=550366577&format=interactive",
  sheets_gid="1614661441",
  sql_file="workbox_package_methods.sql"
  )
}}

Out of many methods that Workbox provides, we noticed that `strategies` were used by 29.53% of desktop and 25.71% on mobile, `routing` followed it with 18.91% and 15.61% adoption and finally `precaching` were next most used with 16.54% and 12.98% on desktop and mobile respectively.

This indicated that the strategies API, as one of the most complicated requirements for the developers, played a very important role when they decided to code themselves or rely on libraries like Workbox.

## Conclusion

The stats in this chapter show that PWAs are still continuing to grow in adoption, due to the advantages they give for [performance](./performance) and greater control over [caching](./caching) particularly for [mobile](./mobile-web). With those advantages and ever increasing [capabilities](./capabilities), means we still have a lot of potential for growth. We expect to see even more progress in 2021!

More and more browsers and platforms are supporting the technologies powering PWAs. This year, we saw that Edge gained support for the Web App Manifest. Depending on your use case and target market, you may find that the majority of your users (close to 96%) have PWA support. That is a great improvement! In all cases, it is important to approach technologies such as service workers and Web App Manifest as progressive enhancements. You can use these technologies to provide an exceptional user experience and, with the above stats, we're excited for another year of PWA growth!
