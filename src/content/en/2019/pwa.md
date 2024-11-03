---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: PWA chapter of the 2019 Web Almanac covering service workers (registations, installability, events and filesizes), Web App Manifests properties, and Workbox.
authors: [tomayac, jeffposnick]
reviewers: [logicalphase, ahmadawais]
analysts: [jrharalson]
editors: [tunetheweb]
translators: []
discuss: 1766
results: https://docs.google.com/spreadsheets/d/19BI3RQc_vR9bUPPZfVsF_4gpFWLNT6P0pLcAdL-A56c/
tomayac_bio: Thomas Steiner is a Web Developer Advocate at Google Hamburg, focused on making the Web a better place through standardization, creating and sharing best practices, and doing research. He blogs at <a hreflang="en" href="https://blog.tomayac.com/">blog.tomayac.com</a> and tweets as <a href="https://x.com/tomayac">@tomayac</a>.
jeffposnick_bio: Jeff Posnick is a member of Google's Web Developer Relations team, based in New York. His focus is on <a hreflang="en" href="https://developers.google.com/web/tools/workbox/">Workbox</a>, a set of service worker libraries for Progressive Web Apps. He blogs at <a hreflang="en" href="https://jeffy.info">https://jeffy.info</a> and tweets as <a href="https://x.com/jeffposnick">@jeffposnick</a>.
featured_quote: Progressive Web Apps (PWAs) are a new class of web applications, building on top of platform primitives like the Service Worker APIs. Service workers allow apps to support network-independent loading by acting as a network proxy, intercepting your web app's outgoing requests, and replying with programmatic or cached responses.
featured_stat_1: 0.44%
featured_stat_label_1: Sites that register a service worker
featured_stat_2: 15%
featured_stat_label_2: Pageviews that use a Service Worker
featured_stat_3: 57%
featured_stat_label_3: PWAs that use the `standalone` `display` property
---

## Introduction

Progressive Web Apps (PWAs) are a new class of web applications, building on top of platform primitives like the [Service Worker APIs](https://developer.mozilla.org/docs/Web/API/Service_Worker_API). Service workers allow apps to support network-independent loading by acting as a network proxy, intercepting your web app's outgoing requests, and replying with programmatic or cached responses. Service workers can receive push notifications and synchronize data in the background even when the corresponding app is not running. Additionally, service workers, together with [Web App Manifests](https://developer.mozilla.org/docs/Web/Manifest), allow users to install PWAs to their devices' home screens.

Service workers were <a hreflang="en" href="https://blog.chromium.org/2014/12/chrome-40-beta-powerful-offline-and.html">first implemented in Chrome 40</a>, back in December 2014, and the term Progressive Web Apps was <a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">coined by Frances Berriman and Alex Russell</a> in 2015. As service workers are now finally <a hreflang="en" href="https://jakearchibald.github.io/isserviceworkerready/">implemented in all major browsers</a>, the goal for this chapter is to determine how many PWAs are actually out there, and how they make use of these new technologies. Certain advanced APIs like <a hreflang="en" href="https://developers.google.com/web/updates/2015/12/background-sync">Background Sync</a> are currently still <a hreflang="en" href="https://caniuse.com/#feat=background-sync">only available on Chromium-based browsers</a>, so as an additional question, we looked into which features these PWAs actually use.

## Service workers

### Service worker registrations and installability

{{ figure_markup(
  caption="Percent of desktop pages that register a service worker.",
  content="0.44%",
  classes="big-number"
)
}}

The first metric we explore are service worker installations. Looking at the data exposed through feature counters in the HTTP Archive, we find that 0.44% of all desktop and 0.37% of all mobile pages register a service worker, and both curves over time are steeply growing.

{{ figure_markup(
  image="fig2.png",
  caption="Service Worker installation over time for desktop and mobile.",
  description="Timeseries chart of service worker installation. Since Janurary 2017, desktop and mobile have increased steadily from approximately 0.0% to about 0.4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=251442414&format=interactive"
  )
}}

Now this might not look overly impressive, but taking traffic data from Chrome Platform Status into account, we can see that a service worker controls about <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">15% of all page loads</a>, which can be interpreted as popular, high-traffic sites increasingly having started to embrace service workers.

{{ figure_markup(
  caption='Percent of page views on a page that registers a service worker. (Source: <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">Chrome Platform Status</a>)',
  content="15%",
  classes="big-number"
)
}}

[Lighthouse](./methodology#lighthouse) checks whether a page is eligible for an <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/install-prompt">install prompt</a>. 1.56% of mobile pages have an <a hreflang="en" href="https://web.dev/installable-manifest/">installable manifest</a>.

To control the install experience, 0.82% of all desktop and 0.94% of all mobile pages use the <a hreflang="en" href="https://w3c.github.io/manifest/#beforeinstallpromptevent-interface">`OnBeforeInstallPrompt` interface</a>. At present <a hreflang="en" href="https://caniuse.com/#feat=web-app-manifest">support is limited to Chromium-based browsers</a>.

### Service worker events

In a service worker one can <a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers/lifecycle">listen for a number of events</a>:

- `install`, which occurs upon service worker installation.
- `activate`, which occurs upon service worker activation.
- `fetch`, which occurs whenever a resource is fetched.
- `push`, which occurs when a push notification arrives.
- `notificationclick`, which occurs when a notification is being clicked.
- `notificationclose`, which occurs when a notification is being closed.
- `message`, which occurs when a message sent via `postMessage()`  arrives.
- `sync`, which occurs when a background sync event occurs.

{{ figure_markup(
  image="fig4.png",
  caption="Popularity of service worker events.",
  description="Bar chart showing the popularity of various service worker events. Fetch is used on 73% of mobile service workers, install 71%, activate 56%, notification click 10%, push 8%, message 5%, notification close 2%, and sync 1%. The usage on desktop service workers is similar, but slightly lower for fetch, install, and activate.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2110574556&format=interactive"
  )
}}

We have examined which of these events are being listened to by service workers we could find in the HTTP Archive. The results for mobile and desktop are very similar with `fetch`, `install`, and `activate` being the three most popular events, followed by `notificationclick` and `push`. If we interpret these results, offline use cases that service workers enable are the most attractive feature for app developers, far ahead of push notifications. Due to its limited availability, and less common use case, background sync doesn't play a significant role at the moment.

### Service worker file sizes

File size or lines of code are generally a bad proxy for the complexity of the task at hand. In this case, however, it is definitely interesting to compare (compressed) file sizes of service workers for mobile and desktop.

{{ figure_markup(
  image="fig5.png",
  caption="Distribution of service worker transfer size.",
  description="Bar chart showing the distribution of transfer sizes of service workers. The 10, 25, 50, 75, and 90th percentiles for desktop service worker transfer sizes are: 176, 350, 895, 2,010, and 4,138 bytes. Desktop service workers are larger across each percentile from as many as 1,000 bytes at the 90th percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=345926232&format=interactive"
  )
}}

The median service worker file on desktop is 895 bytes, whereas on mobile it's 694 bytes. Throughout all percentiles desktop service workers are larger than mobile service workers. We note that these stats don't account for dynamically imported scripts through the [`importScripts()`](https://developer.mozilla.org/docs/Web/API/WorkerGlobalScope/importScripts) method, which likely skews the results higher.

## Web app manifests

### Web app manifest properties

The web app manifest is a simple JSON file that tells the browser about a web application and how it should behave when installed on the user's mobile device or desktop. A typical manifest file includes information about the app name, icons it should use, the start URL it should open at when launched, and more. Only 1.54% of all encountered manifests were invalid JSON, and the rest parsed correctly.

We looked at the different properties defined by the <a hreflang="en" href="https://w3c.github.io/manifest/#webappmanifest-dictionary">Web App Manifest specification</a>, and also considered non-standard proprietary properties. According to the spec, the following properties are allowed:

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

{{ figure_markup(
  image="fig6.png",
  caption="Popularity of web app manifest properties.",
  description="Bar chart showing the popularity of web app manifest properties for desktop and mobile. 88% of desktop web app manifests include the name property, 82% icons, 61% display, 55% theme color, 49% background color, 45% short name, 36% start URL, 19% GCM sender ID, 9% GCM user visible only, 9% orientation, 7% description, 5% scope, and 4% lang. The popularity of properties on mobile web app manifests is similar, plus or minus 2 percentage points.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1904325089&format=interactive",
  width=600,
  height=452,
  data_width=600,
  data_height=452
  )
}}

The proprietary properties we encountered frequently were `gcm_sender_id` and `gcm_user_visible_only` from the legacy Google Cloud Messaging (GCM) service. Interestingly there are almost no differences between mobile and desktop. On both platforms, however, there's a long tail of properties that are not interpreted by browsers yet contain potentially useful metadata like `author` or `version`. We also found a non-trivial amount of mistyped properties; our favorite being `shot_name`, as opposed to `short_name`. An interesting outlier is the `serviceworker` property, which is standard but not implemented by any browser vendor. Nevertheless, it was found on 0.09% of all web app manifests used by mobile and desktop pages.

### Display values

Looking at the values developers set for the `display` property, it becomes immediately clear that they want PWAs to be perceived as "proper" apps that don't reveal their web technology origins.

{{ figure_markup(
  image="fig7.png",
  caption="Usage of web app manifest <code>display</code> properties.",
  description='Bar chart showing how the display property of web app manifests is used by desktop and mobile websites. In both cases, the "standalone" value is used 57% of the time. The property is not set at all in 38% of manifests. The "minimal UI", "browser", and "fullscreen" values each make up only 1 or 2% of usage.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1514793237&format=interactive"
  )
}}

By choosing `standalone`, they make sure no browser UI is shown to the end-user. This is reflected by the majority of apps that make use of the `prefers_related_applications` property: more that 97% of both mobile and desktop applications do _not_ prefer native applications.

### Category values

The `categories` property describes the expected application categories to which the web application belongs. It is only meant as a hint to catalogs or app stores listing web applications, and it is expected that websites will make a best effort to list themselves in one or more appropriate categories.

{{ figure_markup(
  image="fig8.png",
  caption="Top web app manifest categories.",
  description='Bar chart showing the top web app manifest categories. 60 mobile manifests are in the "shopping" category, 15 "business", 9 "web", 9 "technology", 8 "games", 8 "entertainment", 7 "social", etc. Desktop manifests follow a similar distribution except for "shopping", for which there is only 1 desktop manifest.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1609487902&format=interactive"
  )
}}

There were not too many manifests that made use of the property, but it is interesting to see the shift from "shopping" being the most popular category on mobile to "business", "technology", and "web" (whatever may be meant with that) on desktop that share the first place evenly.

### Icon sizes

Lighthouse <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/manifest-contains-192px-icon">requires</a> at least an icon sized 192x192 pixels, but common favicon generation tools create a plethora of other sizes, too.

{{ figure_markup(
  image="fig9.png",
  caption="Top web app manifest icon sizes.",
  description="Bar chart showing the usage of top web app manifest icon size property values. All values are given in height and width pixels, for example the top value in 23% of manifests is 192 by 192 pixels. The next most popular sizes are 144 at 11%, 96 at 11%, 72 at 10%, 48 at 10%, 512 at 9%, 36% at 9%, 256 at 5%, 384 at 2%, 128 at 1%, and 152 at 1%. Desktop and mobile have identical usage patterns.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=1369881840&format=interactive"
  )
}}

Lighthouse's rule is probably the culprit for 192 pixels being the most popular choice of icon size on both desktop and mobile, despite <a hreflang="en" href="https://developers.google.com/web/fundamentals/web-app-manifest#icons">Google's documentation</a> explicitly recommending 512x512, which doesn't show as a particularly prominent option.

### Orientation values

The valid values for the `orientation` property are defined in the <a hreflang="en" href="https://www.w3.org/TR/screen-orientation/#dom-orientationlocktype">Screen Orientation API specification</a>. Currently, they are:

- `"any"`
- `"natural"`
- `"landscape"`
- `"portrait"`
- `"portrait-primary"`
- `"portrait-secondary"`
- `"landscape-primary"`
- `"landscape-secondary"`

{{ figure_markup(
  image="fig10.png",
  caption="Top web app manifest orientation values.",
  description='Bar chart showing the top web app manifest orientation values. "Portrait" is set in 6% of desktop manifests, followed by "any" in 2%, and the everything else in fewer than 1% of manifests. This is similar to usage in mobile manifests, except "portrait" is set in 8% of manifests and "portrait-primary" in 1%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT7DUzACr4eBhNU4cDz8-17oSx2qYbi9OFDjngz0NXNBP2IzZFxvDxLX2XThlN4SZymKMygOXzpI2AJ/pubchart?oid=2065142361&format=interactive"
  )
}}

`"portrait"` orientation is the clear winner on both platforms, followed by `"any"` orientation.

## Workbox

<a hreflang="en" href="https://developers.google.com/web/tools/workbox">Workbox</a> is a set of libraries that help with common service worker use cases. For instance, Workbox has tools that can plug in to your build process and generate a manifest of files, which are then precached by your service worker. Workbox includes libraries to handle runtime caching, request routing, cache expiration, background sync, and more.

Given the low-level nature of the service worker APIs, many developers have turned to Workbox as a way of structuring their service worker logic into higher-level, reusable chunks of code. Workbox adoption is also driven by its inclusion as a feature in a number of popular JavaScript framework starter kits, like <a hreflang="en" href="https://create-react-app.dev/">`create-react-app`</a> and <a hreflang="en" href="https://www.npmjs.com/package/@vue/cli-plugin-pwa">Vue's PWA plugin</a>.

The HTTP Archive shows that 12.71% of websites that register a service worker are using at least one of the Workbox libraries. This percentage is roughly consistent across desktop and mobile, with a slightly lower percentage (11.46%) on mobile compared to desktop (14.36%).

## Conclusion

The stats in this chapter show that PWAs are still only used by a small percentage of sites. However, this relatively small usage is driven by the more popular sites which have a much larger share of traffic, and pages beyond the home page may use this more: we showed that 15% of page loads use a service workers. The advantages they give for [performance](./performance) and greater control over [caching](./caching) particularly for [mobile](./mobile-web) should mean that usage will continue to grow.

PWAs have often been seen as Chrome-driven technology. Other browsers have made great strides recently to implement most of the underlying technologies, although first-class installability lags on some platforms. It's positive to see support becoming more widespread. [Maximiliano Firtman](https://x.com/firt) does a great job of tracking this on iOS, including <a hreflang="en" href="https://medium.com/@firt/iphone-11-ipados-and-ios-13-for-pwas-and-web-development-5d5d9071cc49">explaining Safari PWA support</a>. Apple doesn't use the term PWA much, and has <a hreflang="en" href="https://developer.apple.com/news/?id=09062019b">explicitly stated that these HTML5 apps are best delivered outside of the App Store</a>. Microsoft went the opposite direction, not only <a hreflang="en" href="https://web.archive.org/web/20190711051508/https://docs.microsoft.com/en-us/microsoft-edge/progressive-web-apps/microsoft-store">encouraging PWAs in its app store, but even automatically shortlisting PWAs to be added that were found via the Bing web crawler</a>. Google has also provided a method for listing web apps in the Google Play Store, via <a hreflang="en" href="https://developers.google.com/web/updates/2019/02/using-twa">Trusted Web Activities</a>.

PWAs provide a path forward for developers who would prefer to build and release on the web instead of on native platforms and app stores. Not every operating system and browser offers full parity with native software, but improvements continue, and perhaps 2020 is the year where we see an explosion in deployments?
