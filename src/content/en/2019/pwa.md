---
part_number: II
chapter_number: 11
title: PWA
description: PWA chapter of the 2019 Web Almanac covering service workers (registations, installability, events and filesizes), Web App Manifests properties, and Workbox.
authors: [tomayac, jeffposnick]
reviewers: [hyperpress, ahmadawais]
translators: []
discuss: 1766
results: https://docs.google.com/spreadsheets/d/19BI3RQc_vR9bUPPZfVsF_4gpFWLNT6P0pLcAdL-A56c/
queries: 11_PWA
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-03-01T00:00:00.000Z
---

## Introduction

Progressive Web Apps (PWAs) are a new class of web applications, building on top of platform primitives like the [Service Worker APIs](https://developer.mozilla.org/en/docs/Web/API/Service_Worker_API). Service workers allow apps to support network-independent loading by acting as a network proxy, intercepting your web app's outgoing requests, and replying with programmatic or cached responses. Service workers can receive push notifications and synchronize data in the background even when the corresponding app is not running. Additionally, service workers, together with [Web App Manifests](https://developer.mozilla.org/en-US/docs/Web/Manifest), allow users to install PWAs to their devices' home screens.

Service workers were [first implemented in Chrome 40](https://blog.chromium.org/2014/12/chrome-40-beta-powerful-offline-and.html), back in December 2014, and the term Progressive Web Apps was [coined by Frances Berriman and Alex Russell](https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/) in 2015. As service workers are now finally [implemented in all major browsers](https://jakearchibald.github.io/isserviceworkerready/), the goal for this chapter is to determine how many PWAs are actually out there, and how they make use of these new technologies. Certain advanced APIs like [Background Sync](https://developers.google.com/web/updates/2015/12/background-sync) are currently still [only available on Chromium-based browsers](https://caniuse.com/#feat=background-sync), so as an additional question, we looked into which features these PWAs actually use.

## Service workers

### Service worker registrations and installability

<figure>
  <div class="big-number">0.44%</div>
  <figcaption>Figure 1. Percent of desktop pages that register a service worker.</figcaption>
</figure>

The first metric we explore are service worker installations. Looking at the data exposed through feature counters in the HTTP Archive, we find that 0.44% of all desktop and 0.37% of all mobile pages register a service worker, and both curves over time are steeply growing.

<figure>
  <a href="/static/images/2019/pwa/fig2.png" class="fig-mobile">
    <img src="/static/images/2019/pwa/fig2.png" alt="Figure 2. Service Worker installation over time for desktop and mobile." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=251442414&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">Timeseries chart of service worker installation. Since Janurary 2017, desktop and mobile have increased steadily from approximately 0.0% to about 0.4%.</div>
  <figcaption id="fig2-caption">Figure 2. Service Worker installation over time for desktop and mobile.</figcaption>
</figure>

Now this might not look overly impressive, but taking traffic data from Chrome Platform Status into account, we can see that a service worker controls about [15% of all page loads](https://www.chromestatus.com/metrics/feature/timeline/popularity/990), which can be interpreted as popular, high-traffic sites increasingly having started to embrace service workers.

<figure>
  <div class="big-number">15%</div>
  <figcaption>Figure 3. Percent of page views on a page that registers a service worker. (Source: <a href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">Chrome Platform Status</a>)</figcaption>
</figure>

[Lighthouse](./methodology#lighthouse) checks whether a page is eligible for an [install prompt](https://developers.google.com/web/tools/lighthouse/audits/install-prompt). 1.56% of mobile pages have an [installable manifest](https://web.dev/installable-manifest/).

To control the install experience, 0.82% of all desktop and 0.94% of all mobile pages use the [`OnBeforeInstallPrompt` interface](https://w3c.github.io/manifest/#beforeinstallpromptevent-interface). At present [support is limited to Chromium-based browsers](https://caniuse.com/#feat=web-app-manifest).

### Service worker events

In a service worker one can [listen for a number of events](https://developers.google.com/web/fundamentals/primers/service-workers/lifecycle):

- `install`, which occurs upon service worker installation.
- `activate`, which occurs upon service worker activation.
- `fetch`, which occurs whenever a resource is fetched.
- `push`, which occurs when a push notification arrives.
- `notificationclick`, which occurs when a notification is being clicked.
- `notificationclose`, which occurs when a notification is being closed.
- `message`, which occurs when a message sent via `postMessage()`  arrives.
- `sync`, which occurs when a background sync event occurs.

<figure>
  <a href="/static/images/2019/pwa/fig4.png">
    <img src="/static/images/2019/pwa/fig4.png" alt="Figure 4. Popularity of service worker events." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2110574556&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">Bar chart showing the popularity of various service worker events. Fetch is used on 73% of mobile service workers, install 71%, activate 56%, notification click 10%, push 8%, message 5%, notification close 2%, and sync 1%. The usage on desktop service workers is similar, but slightly lower for fetch, install, and activate.</div>
  <figcaption id="fig4-caption">Figure 4. Popularity of service worker events.</figcaption>
</figure>

We have examined which of these events are being listened to by service workers we could find in the HTTP Archive. The results for mobile and desktop are very similar with `fetch`, `install`, and `activate` being the three most popular events, followed by `notificationclick` and `push`. If we interpret these results, offline use cases that service workers enable are the most attractive feature for app developers, far ahead of push notifications. Due to its limited availability, and less common use case, background sync doesn't play a significant role at the moment.

### Service worker file sizes

File size or lines of code are generally a bad proxy for the complexity of the task at hand. In this case, however, it is definitely interesting to compare (compressed) file sizes of service workers for mobile and desktop.

<figure>
  <a href="/static/images/2019/pwa/fig5.png">
    <img src="/static/images/2019/pwa/fig5.png" alt="Figure 5. Distribution of service worker transfer size." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=345926232&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Bar chart showing the distribution of transfer sizes of service workers. The 10, 25, 50, 75, and 90th percentiles for desktop service worker transfer sizes are: 176, 350, 895, 2,010, and 4,138 bytes. Desktop service workers are larger across each percentile from as many as 1,000 bytes at the 90th percentile.</div>
  <figcaption id="fig5-caption">Figure 5. Distribution of service worker transfer size.</figcaption>
</figure>

The median service worker file on desktop is 895 bytes, whereas on mobile it's 694 bytes. Throughout all percentiles desktop service workers are larger than mobile service workers. We note that these stats don't account for dynamically imported scripts through the [`importScripts()`](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts) method, which likely skews the results higher.

## Web app manifests

### Web app manifest properties

The web app manifest is a simple JSON file that tells the browser about a web application and how it should behave when installed on the user's mobile device or desktop. A typical manifest file includes information about the app name, icons it should use, the start URL it should open at when launched, and more. Only 1.54% of all encountered manifests were invalid JSON, and the rest parsed correctly.

We looked at the different properties defined by the [Web App Manifest specification](https://w3c.github.io/manifest/#webappmanifest-dictionary), and also considered non-standard proprietary properties. According to the spec, the following properties are allowed:

- `dir`
- `lang`
- `name`
- `short_name`
- `description`
- `icons`
- `screenshots`
- `categories`
- `iarc_rating_id`
- `start_url`
- `display`
- `orientation`
- `theme_color`
- `background_color`
- `scope`
- `serviceworker`
- `related_applications`
- `prefer_related_applications`

The only property that we didn't observe in the wild was `iarc_rating_id`, which is a string that represents the International Age Rating Coalition (IARC) certification code of the web application. It is intended to be used to determine which ages the web application is appropriate for.

<figure>
  <a href="/static/images/2019/pwa/fig6.png">
    <img src="/static/images/2019/pwa/fig6.png" alt="Figure 6. Popularity of web app manifest properties." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="452" data-width="600" data-height="452" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1904325089&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">Bar chart showing the popularity of web app manifest properties for desktop and mobile. 88% of desktop web app manifests include the name property, 82% icons, 61% display, 55% theme color, 49% background color, 45% short name, 36% start URL, 19% GCM sender ID, 9% GCM user visible only, 9% orientation, 7% description, 5% scope, and 4% lang. The popularity of properties on mobile web app manifests is similar, plus or minus 2 percentage points.</div>
  <figcaption id="fig6-caption">Figure 6. Popularity of web app manifest properties.</figcaption>
</figure>

The proprietary properties we encountered frequently were `gcm_sender_id` and `gcm_user_visible_only` from the legacy Google Cloud Messaging (GCM) service. Interestingly there are almost no differences between mobile and desktop. On both platforms, however, there's a long tail of properties that are not interpreted by browsers yet contain potentially useful metadata like `author` or `version`. We also found a non-trivial amount of mistyped properties; our favorite being `shot_name`, as opposed to `short_name`. An interesting outlier is the `serviceworker` property, which is standard but not implemented by any browser vendor. Nevertheless, it was found on 0.09% of all web app manifests used by mobile and desktop pages.

### Display values

Looking at the values developers set for the `display` property, it becomes immediately clear that they want PWAs to be perceived as "proper" apps that don't reveal their web technology origins.

<figure>
  <a href="/static/images/2019/pwa/fig7.png">
    <img src="/static/images/2019/pwa/fig7.png" alt="Figure 7. Usage of web app manifest display properties." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1514793237&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Bar chart showing how the display property of web app manifests is used by desktop and mobile websites. In both cases, the "standalone" value is used 57% of the time. The property is not set at all in 38% of manifests. The "minimal UI", "browser", and "fullscreen" values each make up only 1 or 2% of usage.</div>
  <figcaption id="fig7-caption">Figure 7. Usage of web app manifest <code>display</code> properties.</figcaption>
</figure>

By choosing `standalone`, they make sure no browser UI is shown to the end-user. This is reflected by the majority of apps that make use of the `prefers_related_applications` property: more that 97% of both mobile and desktop applications do _not_ prefer native applications.

### Category values

The `categories` property describes the expected application categories to which the web application belongs. It is only meant as a hint to catalogs or app stores listing web applications, and it is expected that websites will make a best effort to list themselves in one or more appropriate categories.

<figure>
  <a href="/static/images/2019/pwa/fig8.png">
    <img src="/static/images/2019/pwa/fig8.png" alt="Figure 8. Top web app manifest categories." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1609487902&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Bar chart showing the top web app manifest categories. 60 mobile manifests are in the "shopping" category, 15 "business", 9 "web", 9 "technology", 8 "games", 8 "entertainment", 7 "social", etc. Desktop manifests follow a similar distribution except for "shopping", for which there is only 1 desktop manifest.</div>
  <figcaption id="fig8-caption">Figure 8. Top web app manifest categories.</figcaption>
</figure>

There were not too many manifests that made use of the property, but it is interesting to see the shift from "shopping" being the most popular category on mobile to "business", "technology", and "web" (whatever may be meant with that) on desktop that share the first place evenly.

### Icon sizes

Lighthouse [requires](https://developers.google.com/web/tools/lighthouse/audits/manifest-contains-192px-icon) at least an icon sized 192x192 pixels, but common favicon generation tools create a plethora of other sizes, too.

<figure>
  <a href="/static/images/2019/pwa/fig9.png">
    <img src="/static/images/2019/pwa/fig9.png" alt="Figure 9. Top web app manifest icon sizes." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1369881840&amp;format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">Bar chart showing the usage of top web app manifest icon size property values. All values are given in height and width pixels, for example the top value in 23% of manifests is 192 by 192 pixels. The next most popular sizes are 144 at 11%, 96 at 11%, 72 at 10%, 48 at 10%, 512 at 9%, 36% at 9%, 256 at 5%, 384 at 2%, 128 at 1%, and 152 at 1%. Desktop and mobile have identical usage patterns.</div>
  <figcaption id="fig9-caption">Figure 9. Top web app manifest icon sizes.</figcaption>
</figure>

Lighthouse's rule is probably the culprit for 192 pixels being the most popular choice of icon size on both desktop and mobile, despite [Google's documentation](https://developers.google.com/web/fundamentals/web-app-manifest#icons) explicitly recommending 512x512, which doesn't show as a particularly prominent option.

### Orientation values

The valid values for the `orientation` property are defined in the [Screen Orientation API specification](https://www.w3.org/TR/screen-orientation/#dom-orientationlocktype). Currently, they are:

- `"any"`
- `"natural"`
- `"landscape"`
- `"portrait"`
- `"portrait-primary"`
- `"portrait-secondary"`
- `"landscape-primary"`
- `"landscape-secondary"`

<figure>
  <a href="/static/images/2019/pwa/fig10.png">
    <img src="/static/images/2019/pwa/fig10.png" alt="Figure 10. Top web app manifest orientation values." aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2065142361&amp;format=interactive">
  </a>
  <div id="fig10-description" class="visually-hidden">Bar chart showing the top web app manifest orientation values. "Portrait" is set in 6% of desktop manifests, followed by "any" in 2%, and the everything else in fewer than 1% of manifests. This is similar to usage in mobile manifests, except "portrait" is set in 8% of manifests and "portrait-primary" in 1%.</div>
  <figcaption id="fig10-caption">Figure 10. Top web app manifest orientation values.</figcaption>
</figure>

`"portrait"` orientation is the clear winner on both platforms, followed by `"any"` orientation.

## Workbox

[Workbox](https://developers.google.com/web/tools/workbox) is a set of libraries that help with common service worker use cases. For instance, Workbox has tools that can plug in to your build process and generate a manifest of files, which are then precached by your service worker. Workbox includes libraries to handle runtime caching, request routing, cache expiration, background sync, and more.

Given the low-level nature of the service worker APIs, many developers have turned to Workbox as a way of structuring their service worker logic into higher-level, reusable chunks of code. Workbox adoption is also driven by its inclusion as a feature in a number of popular JavaScript framework starter kits, like [`create-react-app`](https://create-react-app.dev/) and [Vue's PWA plugin](https://www.npmjs.com/package/@vue/cli-plugin-pwa).

The HTTP Archive shows that 12.71% of websites that register a service worker are using at least one of the Workbox libraries. This percentage is roughly consistent across desktop and mobile, with a slightly lower percentage (11.46%) on mobile compared to desktop (14.36%).

## Conclusion

The stats in this chapter show that PWAs are still only used by a small percentage of sites. However, this relatively small usage is driven by the more popular sites which have a much larger share of traffic, and pages beyond the home page may use this more: we showed that 15% of page loads use a service workers. The advantages they give for [performance](./performance) and greater control over [caching](./caching) particularly for [mobile](./mobile-web) should mean that usage will continue to grow.

PWAs have often been seen as Chrome-driven technology. Other browsers have made great strides recently to implement most of the underlying technologies, although first-class installability lags on some platforms. It's positive to see support becoming more widespread. [Maximiliano Firtman](https://twitter.com/firt) does a great job of tracking this on iOS, including [explaining Safari PWA support](https://medium.com/@firt/iphone-11-ipados-and-ios-13-for-pwas-and-web-development-5d5d9071cc49). Apple doesn't use the term PWA much, and has [explicitly stated that these HTML5 apps are best delivered outside of the App Store](https://developer.apple.com/news/?id=09062019b). Microsoft went the opposite direction, not only [encouraging PWAs in its app store, but even automatically shortlisting PWAs to be added that were found via the Bing web crawler](https://docs.microsoft.com/en-us/microsoft-edge/progressive-web-apps/microsoft-store). Google has also provided a method for listing web apps in the Google Play Store, via [Trusted Web Activities](https://developers.google.com/web/updates/2019/02/using-twa).

PWAs provide a path forward for developers who would prefer to build and release on the web instead of on native platforms and app stores. Not every operating system and browser offers full parity with native software, but improvements continue, and perhaps 2020 is the year where we see an explosion in deployments?
