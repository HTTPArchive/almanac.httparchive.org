---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: PWA chapter of the 2022 Web Almanac covering service workers (usage and features), Web App Manifests, Lighthouse insights, service worker libraries (including Workbox), and Web Push notifications.
authors: [diekus]
reviewers: [aarongustafson, tropicadri, webmaxru, Schweinepriester, beth-panx]
analysts: [beth-panx]
editors: [siwinlo, tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1PbzjhN%2D%2DjU9MGuWobw5L9EsmlVzI9tlbCe3_NKA7giU/
diekus_bio: Diego Gonzalez is a computer engineer from Costa Rica working as the PM for PWA platform features for the Microsoft Edge browser.
featured_quote: The increasing features that allow integration of installable web applications with desktop platforms has driven adoption of the PWAs by big names in the industry.
featured_stat_1: 95%
featured_stat_label_1: Manifest files that are JSON parsable on desktop
featured_stat_2: 63%
featured_stat_label_2: Usage of the install event from the service worker on desktop PWAs
featured_stat_3: 60%
featured_stat_label_3: PWAs that use Workbox in some capacity
---

## Introduction

In the early days of Progressive Web Apps, there were two key features that harnessed the promise of an advanced modern web application: offline support and a direct icon on the home screen of the device.

These two concepts were enabled after installing a PWA, a process that generally began by tapping on an "ambient badge" that would appear on the browser's URL bar. This badge would prompt the user to install the website. Mobile browsers such as Samsung Internet and Mozilla Firefox, were among the first ones to explicitly support this behavior, commonly known as ["Add to home screen" (A2HS)](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Add_to_home_screen).

Five years ago, this was a radical idea. A website would be able to launch directly from the home screen, listed alongside other applications a user had installed on their device. This was the start of progress made towards reducing the gap between capabilities of web apps and OS-specific experiences.

The A2HS scenario has evolved into web apps that can be fully installed and deeply integrated into the host OS, in both mobile and desktop contexts. These past 12 months have seen browsers take important steps towards making sure that PWAs have a tight integration with desktop platforms, and many of the new additions to this year's almanac reflect these changes. This is the state of PWAs in 2022.

Note: As a set of web technologies, PWAs are not isolated from the rest of the web platform. While there is a chapter dedicated to [Capabilities](./capabilities), this year we have investigated the intersection of some of these new advanced capabilities when used inside a PWA.

## Service workers

[Service workers](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) is one of the core technologies of PWAs and the enabler of offline apps, getting push notifications, and doing background processing. They serve as the base for most of the advanced experiences we expect from applications. They are also being used to define data updates and for upcoming modern functionality like <a hreflang="en" href="https://github.com/aarongustafson/pwa-widgets#rich-widgets">widgets based on PWA technologies</a>.

While there isn't parity between major browsers when it comes to service worker feature support, Webkit adding support for <a hreflang="en" href="https://caniuse.com/push-api">push notifications</a> was a huge milestone. Earlier this year it was announced that <a hreflang="en" href="https://webkit.org/blog/12945/meet-web-push/">Apple had made changes</a> to their desktop platform to support the relevant parts of the [Push API](https://developer.mozilla.org/docs/Web/API/Push_API), [Notifications API](https://developer.mozilla.org/docs/Web/API/Notifications_API) and that [service workers](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) would enable Web Push. They also announced the feature would be coming to their mobile platforms in 2023.

### Service worker usage

For comparison reasons, we have run the same queries as last year, which allows us to try to make sense of the evolution of service worker usage. Last year's chapter gave the explanation of [why it isn't trivial to find out actual usage of service worker](../2021/pwa#service-workers-usage), and that is just as true this year.

Looking at two of the measures:

- Lighthouse detects a 1.6% (mobile) and 1.7% (desktop) of all websites employ a service worker. We expect this is lower than the real-world percentage due to <a hreflang="en" href="https://web.dev/service-worker">additional checks</a> that Lighthouse takes into consideration.
- Following the same <a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/pwa.js">metrics introduced last year</a>, usage of a Service Worker in websites comes up to 1.63% on desktop and 1.81% on mobile.

{{ figure_markup(
  image="sw-controlled-pages-rank.png",
  caption="Service worker controlled pages by rank.",
  description="Column chart showing that on desktop 8.3% of the top 1,000 websites use a service work, this is 8.0% for the top 10,000 desktop pages, 4.5% for the top 100,000, 2.2% for the top million, and 1.4% for our entire dataset. Mobile is similar with 8.7%, 7.9%, 4.7%, 2.3%, and 1.4% respectively..",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1762012854&format=interactive",
  sheets_gid="2067971287",
  sql_file="sw_adoption_over_time_ranking.sql"
  )
}}

There hasn't been a noticeable change for service worker controlled pages in the top 1,000 sites as well, with only a slight decrease in desktop and even smaller increase in mobile properties. But there was an increase in all other categories. If we follow the [reasoning from last year](../2021/pwa#fig-2)—where we postulated that bigger websites adopted the advanced technologies faster—then seeing more growth in other categories makes sense. It would seem smaller companies and developers have learned and adopted the technology shared from case studies and examples from the companies with more traffic.

### Service worker events

A service worker acts as a proxy server that sits between the web app, the browser and the network. To install a service worker it must be fetched and registered. If this is successful, the service worker is executed in a [special worker container](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope) that runs off the main thread and has no DOM access. This is when events can be processed.

{{ figure_markup(
  image="most-used-sw-events.png",
  caption="Most used service worker events.",
  description="Column chart showing `install` is used on 63% of desktop and 61% of mobile PWA websites, `activate` on 63% and 61% respectively, `notificationclick` on 57% and 51%, `push` on 56% and 51%, `fetch` on 49% and 50%, `notificationclose` on 15% and 16%, `sync` on 6% and 5%, and finally `periodicsync` on 0% of both.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1426457626&format=interactive",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
  )
}}

The previous chart displays information on the most used service worker events. Each one of these events can be categorized into:

- Lifecycle events
- Notification-related events
- Background processing events

#### Lifecycle events

`install` and `activate` are lifecycle events. It is common practice to create a cache of assets that will allow running the app offline when installing. Activation is generally used to clean up old caches associated with the previous service worker.

{{ figure_markup(
  caption="Service worker events that are `install` events on mobile.",
  content="61%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

The service worker needs to be active in order to receive events like fetch and push. This makes them the cornerstone of service workers, and hence the 63% usage on desktop and 61% on mobile for `install`, and the same for `activate`.

The remaining ~40% of sites with service worker might not be actively using these events, as they can be using service worker for notifications or utilizing techniques to cache requests made only when the site is running, also known as <a hreflang="en" href="https://web.dev/runtime-caching-with-workbox/">runtime caching</a>.

While these are still the most used events, the increase of other types of events being used leads us to speculate that there is an increased number of service workers not (only) being used for pre-caching as their main task.

#### Notification-related events

{{ figure_markup(
  caption="Service worker events that are `notificationclick` events on desktop.",
  content="57%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

Push notification events come next in most used service worker methods.

- `notificationclick` comes up to 57% (<span class="numeric-good">▲11%</span> over last year's data) on desktop and 51% (<span class="numeric-good">▲5%</span>) on mobile.
- `push` 56% (<span class="numeric-good">▲12%</span>) on desktop and 50% (<span class="numeric-good">▲5%</span>) on mobile.
- `notificationclose` is now at 15% (<span class="numeric-good">▲9%</span>) on desktop and 16% (<span class="numeric-good">▲10%</span>) on mobile.

A couple of takeaways here is that momentum continues to grow this year for PWAs on desktop, and push notifications is not an exception. Usage of related events for notifications has gone up around 11%. Many tweaks and fixes have been worked on in different platforms to make sure that these pieces of UX feel completely integrated with the host OS. We expect these numbers to continue growing, following the newly announced <a hreflang="en" href="https://webkit.org/blog/12945/meet-web-push/">support for Web Push on Webkit</a>. This is a feature that has being requested by many developers for a long time and finally having support on macOS—and hopefully soon iOS devices—can encourage developers to use the API.

#### Background processing events

{{ figure_markup(
  caption="Service worker events that are `fetch` events on desktop.",
  content="49%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

The remaining events in the chart represent background processing events:
- `fetch`, which occurs when a request is sent to the server, can be used to intercept said request and respond with custom or cached assets, enabling offline support for our PWAs. Fetch usage is 49% on desktop and 50% on mobile.
- `sync`, which fires when the UA believes the user has connectivity, has a usage of 6% on desktop and 5% on mobile.
- `periodicsync`, which allows web applications to periodically synchronize data in the background, is currently at 0.01% on both desktop and mobile platforms. It should be noted that `periodicsync` is limited to a max of once every 12 hours. This can be artificially suppressing usage of the feature.

### Other popular SW features

{{ figure_markup(
  image="usage-skip-waiting.png",
  caption="Usage of `skipWaiting()` method.",
  description="Column chart showing the usage of the `skipWaiting()` method is 60% on desktop and 59% on mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=174072819&format=interactive",
  sheets_gid="58784102",
  sql_file="sw_methods.sql"
  )
}}

Similar to the [stats of last year](../2021/pwa#other-popular-service-worker-features), the [`skipWaiting`](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/skipWaiting) method that is used to immediately activate the service worker is still very popular among developers, being present on 60% of desktop and 59% of mobile web apps.

These are the top most used service worker objects:

{{ figure_markup(
  image="most-used-sw-objects.png",
  caption="Most used service worker objects.",
  description="Column chart showing `clients` objects are used on 93% of desktop and 87% of mobile websites, `caches` on 45% and 44% respectively, `cache` on 21% and 21%, and finally `client` on 12% of desktop and 13% mobile PWA websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1869777638&format=interactive",
  sheets_gid="1746822463",
  sql_file="sw_objects.sql"
  )
}}

{# TODO Anything to say about this graph? #}

And these are the most used methods:

{{ figure_markup(
  image="most-used-sw-objects-methods.png",
  caption="Most used service worker object methods.",
  description="Column chart showing `clients.matchAll` is used on 61% of desktop and 55% of mobile PWA sites, `clients.claim` on 58% and 58% respectively, `clients.openWindow` on 56% and 51%, `caches.open` on 44% and 43%, `caches.delete` on 29% and 24%, `caches.match` on 25% and 28%, `caches.keys` on 21% and 18%, `cache.put` on 12% and 14%, `client.url` on 10% and 11%, and finally `cache.add` is used on 8% of desktop and 7% of mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1209078963&format=interactive",
  sheets_gid="1969934262",
  sql_file="sw_methods.sql"
  )
}}

{# TODO Anything to say about this graph? #}

## Web App Manifest

The _Web App Manifest_ file is a JSON file that contains information about the application itself. The manifest file is the other main core technology that defines PWAs. Among the data that is present in the key-value pairs is information relevant to display, promote and integrate the app into the host OS.

Keeping the web app's manifest fully authored is essential to take advantage of advanced discoverability through online repositories, submissions to application stores, and more recently, a way to tap into advanced capabilities like share target and file handling for your app. Cutting edge work to <a hreflang="en" href="https://github.com/aarongustafson/pwa-widgets#how-widgets-are-represented-in-these-apis">enable Widgets based on PWA technology</a> is also being rooted in the manifest, proving the versatility of the file itself for advanced platform integration even further.

{{ figure_markup(
  caption="Percent of manifest files parsable on desktop.",
  content="95%",
  classes="big-number",
  sheets_gid="717325565",
  sql_file="manifests_not_json_parsable.sql"
)
}}

For most cases—95% in desktop and 94% in mobile—the manifests we found are JSON parsable. This indicates that almost all web apps that use the manifest are correctly formed.

This does not indicate completeness or minimum availability of certain fields that would contribute to the installation of the web app. As a matter of fact, there is currently no required properties for the Manifest file. Am empty file technically is a valid Manifest file.

The manifest file plays a key part in signaling to the browser to prompt for installation, though the way the prompt is triggered <a hreflang="en" href="https://web.dev/installable-manifest/#in-other-browsers">varies with different browsers</a>, there's always a subset of the manifest file involved.

Below are the usage numbers of manifest file alongside service worker. These two used in conjunction generally imply installability.

{{ figure_markup(
  image="sw-manifest-usage.png",
  caption="Service Worker and Manifest usage.",
  description="Bar chart that shows the usage of service workers, manifest files and their combination in web apps. On desktop, service worker is on 1.6% of websites, manifest on 8.4%, either on 9.2% and both on 0.8% of web apps. For mobile it's similar at 1.8%, 7.7%, 8.6%, and 0.8% respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=409958839&format=interactive",
  sheets_gid="1885116887",
  sql_file="manifests_and_service_workers.sql"
  )
}}

The data tells us that web applications are around 5 times more likely to have a manifest file than a service worker. A contributing factor is that many platforms, such as Content Management Systems (CMSs), auto-generate manifest files for websites.

Only a small percentage of websites—0.8% on both desktop and mobile—implement both service worker and manifest files, which means less than 1% of websites can be installed on devices like traditional apps.

For this chapter we are mostly interested in sites that have both a service worker and a manifest so–unless otherwise noted—the manifest data present in this chapter are for PWA sites.

### Manifest properties

{{ figure_markup(
  image="top-pwa-manifest-props.png",
  caption="Top PWA manifest properties.",
  description="Column chart showing `name` is used on 87% of desktop PWA sites, and 88% of mobile PWA sites, `display` 83% and 85% respectively, `icons` 81% and 83%, `short_name` 78% and 81%, `start_url` 77% and 81%, `background_color` 78% and 80%, `theme_color` 73% and 76%, `description` 38% and 37%, `lang` 24% and 24%, and finally `gcm_sender_id` 23% and 21%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=314127541&format=interactive",
  sheets_gid="400343770",
  sql_file="top_manifest_properties.sql"
  )
}}

Looking at top properties used in manifest files this year as compared to last year, there is no significant change.

Note that the `gcm_sender_id`, is not a standardized property. It is used by the Google Developer Console to identify an app and enabled older versions of Chrome to implement web push, which relied on the GCM service.

Most PWAs, 80% for desktop and 79% for mobile do not define a preferred orientation. When set, the most frequently used value is "portrait," with 13% on desktop and 15% on mobile web sites defining that value on their manifest.

#### `display` property

Digging into the `display` property more, we see the following values:

{{ figure_markup(
  image="display-values.png",
  caption="PWA manifest display values.",
  description="Column chart showing `standalone` is the most common display value used on 71% of desktop and 73% of mobile PWA sites, `minimal-ui` on 8% and 7% respectively, `fullscreen` on 3% and 4%, `browser` on 1% and 1%, and it is not set on 17% of desktop and 15% of mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=463813741&format=interactive",
  sheets_gid="264101844",
  sql_file="top_manifest_display_values.sql"
  )
}}

`display: standalone` mode is the most common display mode, used by almost 3/4 of websites that define a display mode. It's also one of the display modes that enables an app to be installable.

#### `icons` property

{{ figure_markup(
  image="top-icon-sizes.png",
  caption="Top PWA manifest icon sizes.",
  description="Column chart showing `192x192` is the manifest icon site on 72% of desktop and 74% mobile PWA sites, `512x512` on 72% and 69% respectively, `144x144` on 34% and 32%, `96x96` on 25% and 24%, `72x72` on 22% and 22%, `384x384` on 20% and 18%, `48x48` on 19% and 18%, `152x152` on 16% and 15%, `120x120` on 12% and 11%, `256x256` on 12% and 10%, `128x128` on 10% and 11%, `64x64` on 9% and 7%, `36x36` on 9% and 8%, `32x32` on 5% and 5%, and finally `180x180` is used on 4% of desktop and 5% mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1961814023&format=interactive",
  sheets_gid="1009563515",
  sql_file="top_manifest_icon_sizes.sql"
  )
}}

PWAs need to generate different icon sizes to accommodate the range of surfaces where the app can be advertised and placed. Many tools exist to generate the plethora of icons needed for different desktop and mobile environments. The 2 most common icon sizes present in manifest files are `192x192` and `512x512`. Both sizes appear in around 70% of the manifest files analyzed.

#### Installation and discoverability properties

A web app manifest file can contain data that is useful in describing of the application. These properties can be used by stores or other distribution mechanisms to promote the application. An increased growth of <a hreflang="en" href="https://developer.chrome.com/blog/richer-pwa-installation">rich browser-based installation dialogs</a> is also utilizing these fields more prominently. Relevant fields, which can be found as part of the Application Information supplement to the Manifest file are listed below:

* `description`: This property exists in 36% of desktop and 34% of mobile web app manifests. The description is important since it explains what the application does. It's commonly used to provide information about the app for a store. Currently around a third of installable PWAs would offer this information.
* `screenshots`: This property provides the URLs of one or more screenshots for use in app stores and in-browser install prompts. PWAs with manifests that take advantage of this feature total 1.12% for desktop and 1.19% for mobiles devices.
* `categories`: Used as hints for catalog organization.
* `iarc_rating_id`: It's a string that represents the <a hreflang="en" href="https://www.globalratings.com/how-iarc-works.aspx">IARC certification code</a> of the web app. 0.05% of desktop and mobile apps utilize this field to advertise the rating of their app or game.

#### Manifest categories

Let's dig into the categories little more.

{{ figure_markup(
  image="top-pwa-manifest-cats.png",
  caption="Top PWA manifest categories.",
  description="Column chart showing `shopping` is the category set on 0.31% of desktop and 0.27% of mobile PWA sites, `news` on 0.27% and 0.28% respectively, `business` on 0.18% and 0.16%, `lifestyle` on 0.15% and 0.15%, `social` on 0.12% and 0.18%, `education` on 0.16% and 0.12%, `entertainment` on 0.13% and 0.14%, `productivity` on 0.07% and 0.06%, `magazines` on 0.06% and 0.07%, and finally `sports` on 0.07% of desktop and 0.06% of mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2026035912&format=interactive",
  sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

And we will also show the same data for all websites, rather than just those with a service worker which we are using as our definition of "PWA sites":

{{ figure_markup(
  image="top-manifest-cats.png",
  caption="Top manifest categories.",
  description="Column chart showing `news` is the category set on 0.36% of desktop and 0.37% of mobile sites, `shopping` on 0.36% and 0.34%, `business` on 0.22% and 0.20%, `social` on 0.16% and 0.24%, `entertainment` on 0.18% and 0.20%, `lifestyle` on 0.19% and 0.18%, `education` on 0.21% and 0.16%, `games` on 0.09% and 0.09%, `productivity` on 0.09% and 0.08%, `utilities` on 0.08% of both desktop and mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417728851&format=interactive",
  sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

The top categories for both websites and PWAs remain the same, yet each is slightly different. Top categories are shopping, news, and business.

#### Advanced capabilities

The manifest file also allows for the activation of modern platform capabilities. These capabilities can allow for advanced windowing capabilities or registration of behaviors in the host OS. Many of these capabilities have landed very recently into the platform, and therefore, we hope this data register an inception of many of these new APIs.

As these are lesser-use, more advanced, capabilities they do not show on [our previous graph of the top manifest properties](#manifest-properties), but are worth looking at to see their usage too:

* `shortcuts`: 6.2% of desktop and 4.3% of mobile PWAs are using shortcuts to deep link into the app.
* `file_handlers`: allows an installed PWA to register itself as a handler for a specific file extension. Only 0.01% of desktop and 0.02% of mobile are using `file_handlers`.
* `protocol_handlers`: PWAs can register to be handlers for predefined or custom protocols. Current usage stands at 0% on desktop and 0.01% for mobile web sites.
* `share_target`: 5.3% of desktop and 3.1% of mobile PWAs have the ability to register themselves to receive shared data.
* <a hreflang="en" href="https://wicg.github.io/window-controls-overlay/">Window Controls Overlay</a>: The ability to free the area generally occupied by the title bar is a desktop only feature. This feature has recently launched in Chromium 105 and 0.01% of manifests of desktop PWAs are utilizing it.
* `note_taking`: 0% of desktop and 0.01% of mobile sites are using the ability to have special integration as a convenient way of taking a quick note.

#### Manifest preferring native

{{ figure_markup(
  caption="Manifest files with a related_applications field on mobile.",
  content="2.0%",
  classes="big-number",
  sheets_gid="228985826",
  sql_file="manifests_preferring_native_apps.sql"
)
}}

There is a property in the manifest that specifies if applications listed in the `related_applications` field should be preferred over the web application. This might make the user agent suggest the installation of the related app instead of the web app. From all the manifest files analyzed, only 2.3% on desktop and 2.0% on mobile manifests set this property.

## Fugu APIs

PWAs go hand in hand with advanced web capabilities. These capabilities are generally part of project Fugu which is the codename for a collection of new web platform features incubating within the Chromium project.

{{ figure_markup(
  caption="Most used Fugu API (desktop).",
  content="8.8%",
  classes="big-number",
  sheets_gid="1110821491",
  sql_file="fugu.sql"
)
}}

From the growing list of features that have been added to the web platform, these are the top APIs being used on the web that are useful for PWAs with web:

<figure>
  <table>
    <thead>
      <tr>
        <th>Api</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Web Share</td>
        <td class="numeric">8.8%</td>
        <td class="numeric">8.4%</td>
      </tr>
      <tr>
        <td>Add to Home Screen</td>
        <td class="numeric">8.6%</td>
        <td class="numeric">7.7%</td>
      </tr>
      <tr>
        <td>Service worker</td>
        <td class="numeric">4.2%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Push</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">1.9%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most used Fugu APIs.",
      sheets_gid="1110821491",
      sql_file="fugu.sql",
    ) }}
  </figcaption>
</figure>

We won't delve into these much more as we have a separate [Capabilities](./capabilities) chapter that covers them.

## PWA insights from Lighthouse

<a hreflang="en" href="https://developer.chrome.com/docs/lighthouse">Lighthouse</a> is an open-source, automated tool for improving the quality of web pages. It can be used to run a number of audits on a website and has a dedicated category for PWA audits. The available data sheds some light on interesting facts about the state of PWAs these past 12 months.

### Lighthouse audits

{{ figure_markup(
  image="lighthouse-pwa-audits-desktop.png",
  caption="Lighthouse PWA Audits for desktop.",
  description="Column chart showing the `viewport` Lighthouse audit passes on 92% of all desktop websites and 99% of desktop PWA sites, `installable-manifest` on 9% and 90% respectively, `apple-touch-icon` on 42% and 80%, `service-worker` on 2% and 69%, `themed-omnibox` on 6% and 62%, `splash-screen` on 3% and 51%,  and finally `maskable-icon` passes on 1% of all desktop websites and 21% of desktop PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2100711487&format=interactive",
  sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

It is not surprising to see PWA sites passing the PWA audits much more frequently than the general web, though some audits such as the presence of a <a hreflang="en" href="https://web.dev/viewport/#how-to-add-a-viewport-meta-tag">viewport meta tag</a> and the <a hreflang="en" href="https://web.dev/apple-touch-icon/#how-the-lighthouse-apple-touch-icon-audit-fails">apple-touch-icon</a> meta tag are also often applicable—and used–by non-PWA sites.

{{ figure_markup(
  image="lighthouse-pwa-audits-mobile.png",
  caption="Lighthouse PWA Audits for mobile.",
  description="Column chart showing the `viewport` Lighthouse audit passes on 93% of all mobile websites and 100% of mobile PWA sites, `content-width` passes on 83% and 95% respectively, `installable-manifest` on 8% and 93%, `apple-touch-icon` on 42% and 79%, `service-worker` on 2% and 75%, `themed-omnibox` on 5% and 65%, `splash-screen` on 3% and 53%, and finally `maskable-icon` passes on 1% of all mobile websites and 21% of mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=51840174&format=interactive",
  sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

Looking at the Lighthouse data on mobile sites we see similar stats, but the mobile-only <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/pwa/content-width">content-width meta tag</a> shows here and is pleasingly passed by both.

The presence of a viewport meta tag is relevant because it removes a 300-350ms delay that waits for a double-tap back when that was the way to zoom in. It has the additional benefit on mobile devices of optimizing the app for the device's screen size. It is not surprising that almost all websites, PWA or not, include this.

Installable manifest also appears in both top 3 lists. As expected, this has a very high value for PWA sites, both on desktop (90.2%) and mobile (95.2%), with a very low counterpart for all websites, presumably because developers don't intend for these to be installed.

Finally, `apple-touch-icon` is third on PWA-related Lighthouse audits. Since iOS 1.1.3, Safari for iOS has supported a way for developers to specify an image that will be used to represent the web site or app on the home screen. This is mostly relevant for mobile devices.

### Lighthouse scores

To conclude the Lighthouse insights section, we take a look at the overall Lighthouse PWA scores for PWA sites, based on the audits.

{{ figure_markup(
  image="lighthouse-scores-desktop.png",
  caption="Lighthouse scores for desktop.",
  description="Column chart showing that, on desktop, at the 10th percentile the median Lighthouse PWA score is 22 for all sites and 44 for PWA sites, at the 25th percentile it's 22 and 67 respectively, at the 50th percentile it's 22 and 78, at the 75th percentile it's 33 and 89, and finally at the 90th percentile the median Lighthouse PWA score is 33 for all sites and 100 for PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1918292266&format=interactive",
  sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

{{ figure_markup(
  image="lighthouse-scores-mobile.png",
  caption="Lighthouse scores for mobile.",
  description="Column chart showing that, on mobile, at the 10th percentile the median Lighthouse PWA score is 20 for all sites and 50 for PWA sites, at the 25th percentile it's 30 and 70 respectively, at the 50th percentile it's 30 and 80, at the 75th percentile it's 40 and 90, and finally at the 90th percentile the median Lighthouse PWA score is 40 for all sites and 100 for PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1463181209&format=interactive",
  sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

As expected, PWA sites tend to have considerably higher PWA audit scores. These audits look into speed, reliability, installability and other PWA requirements, as detailed in their <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/pwa">documentation</a>.

What's also notable is the range of audit scores in PWA sites (50-100) representing the difference in PWAs out there. In contrast the rest of the web has a fairly consistent range of scores (20-40) reflecting the two main audits relevant for most sites discussed previously-viewport and icons.

## Service worker libraries

Service workers are really powerful tools, their API allows developers to create app experiences that were impossible before, like creating their own offline experience or caching assets to improve performance, however, creating code that handles the relationship between your web app and the network comes with complexities and caveats. Here is where libraries can make life better for developers by providing higher level abstractions around the Service Worker API.

### Workbox usage

<a hreflang="en" href="https://developer.chrome.com/workbox/">Workbox</a> is a set of libraries that was born to ease the usage of service workers for developers. It includes a set of libraries that go from the basics that are reused in other Workbox libraries with <a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-core">workbox-core</a> to more specific tasks like <a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-strategies">caching strategies</a>, <a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-background-sync">background sync</a>, <a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules/workbox-precaching">precaching</a> and <a hreflang="en" href="https://developer.chrome.com/docs/workbox/modules">many more</a>.

{{ figure_markup(
  image="workbox-usage.png",
  caption="Use of Workbox on PWA pages.",
  description="Column chart showing the usage of Workbox on PWA pages increased from 33% to 59% on desktop sites, and from 32% to 54% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417225871&format=interactive",
  sheets_gid="1871711300",
  sql_file="workbox_usage.sql"
  )
}}

Compared with last year we see a big spike in Workbox usage. Last year its usage on mobile was 33% compared to 54% this year, and almost 60% of desktop PWAs use Workbox in some capacity.

Since the growth that we saw in the number of pages controlled by service workers was not in the top 1,000 websites but in more granular categories, and this growth on Workbox usage we can infer that adoption of Workbox is happening inside the companies and websites that might have waited for the technology to be adopted by the top websites, or that might not have the need for a completely custom implementation of service workers and get the most out of Workbox's tested patterns.

#### Workbox packages

Workbox is structured in a way that developers can choose which parts to add to their projects depending on their site's needs. The usage shown below helps us document which PWA features are developers implementing at the moment.

{{ figure_markup(
  image="top-workbox-packages.png",
  caption="Top Workbox packages.",
  description="Column chart showing that `core` is the top used Workbox package, used on 36% of desktop and 37% of mobile PWA sites, `sw` is next on 29% and 31% respectively, followed by `routing` on 28% and 31%, then `strategies` on 23% and 21%, then `precaching` on 22% and 18%, then `expiration` on 10% and 9%, then `window` on 9% and 8%, then `background-sync` on 5% and 4%, then `cacheable-response` on 4% and 4%, and finally `navigation-preload` is used on 4% of desktop and 3% of mobile PWA sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=205966463&format=interactive",
  sheets_gid="122135540",
  sql_file="workbox_packages.sql"
  )
}}

Here we also see an overall increase in usage, `workbox-core`. The base library saw an increase of 14% in usage. `workbox-core`, together with `workbox-routing` and `workbox-strategies`, is used to create a caching strategy that works to serve different artifacts in their web app to improve performance. It makes sense they are all at the top as they enable a core benefit of service workers.

There is also a considerable jump in usage on `workbox-precaching`. Pre-caching can be used to emulate the model that packaged apps use. With `workbox-precaching`, you can choose assets that will be cached at the time of service worker installation to make those assets load faster in subsequents visits.

What is surprising is the rise in `workbox-sw` usage, because starting with <a hreflang="en" href="https://github.com/GoogleChrome/workbox/releases/tag/v5.0.0">Workbox 5</a>, the Workbox team has encouraged developers to create custom bundles of the Workbox runtime instead of using `importScripts()` to load <a hreflang="en" href="https://developers.google.com/web/tools/workbox/modules/workbox-sw">`workbox-sw`</a> (the runtime). The Workbox team will continue supporting _workbox-sw_, but the new technique is now the recommended approach. In fact, the defaults for the build tools have switched to prefer that method.

It is possible the increase is coming from libraries that use older versions of Workbox like <a hreflang="en" href="https://github.com/facebook/create-react-app/blob/v3.4.4/packages/react-scripts/package.json#L82">`create-react-app` version 3</a>

### Web Push Notifications

Notifications are a powerful way to re-engage with users. It is also one characteristic that we expect from platform-specific applications. Notifications are the perfect way to give timely, relevant and precise information, and it is powered by the Web Push API.

#### Web Push notification acceptance rates

We can acknowledge that the implementation for web notifications has not been the smoothest for developers or users, but it is important to also note how useful of a tool they are. Like calendar notifications, subscription updates, or games, the important thing is that users get to choose when to turn them on.

It bears repeating that for a notification to be useful it has to be <a hreflang="en" href="https://developers.google.com/web/fundamentals/push-notifications">timely, precise, and relevant</a>. At the moment of showing the prompt to request permission, the user needs to understand the value of the service. Developers have the chance to onboard the users into notifications before they show the browser permissions dialog by sharing the advantages the users will get your specific notifications.

{{ figure_markup(
  image="notification-acceptance.png",
  caption="Notification acceptance rates.",
  description="Stacked bar charter showing that on desktop 6% of notifications are accepted, 7% are denied, 70% are ignored, and 17% are dismissed. On mobile 19% of notification are accepted 35% are denied, 34% are ignored, and 13% are dismissed. On mobile there is a much higher rate of accepting or denying and a much smaller rate of ignoring.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=148157045&format=interactive",
  sheets_gid="435156894",
  sql_file="pwa_notification_acceptance_rates.sql"
  )
}}

With the growth of notification support and the UX improvements in different platforms, there hasn't been any major changes in the acceptance of notifications. Since early 2020 they have been around the 6% acceptance rate on desktop and 20% on mobile.

Desktop and mobile notification acceptance rate share a common fashion, and it is the trend to ignore notifications. The sum of "ignore" has gone up from 48% in February 2020 all the way up to 70% in June 2022. For mobile platforms, from 1.88% in February 2020 to a staggering 34% for June this year. Notification fatigue, coupled with increasing number of prompts for security, privacy, and advanced capabilities are partially responsible, and work is being carried out to address this and present better unified UX across different platforms.

## Conclusion

2022 has been a stellar year for PWAs. The increasing features that allow integration of installable web applications with desktop platforms has driven adoption of the technology by big names in the industry. This past year advanced capabilities like protocol handlers, window controls overlay, run on OS login, and more have started to position PWAs as a key technology for application development. Whilst encouraging, this is not representative of the totality of the web platform. service worker usage percentage fell to around half, compared to the data from 2021, but the rise of big applications constructed using PWA technology rose.

Manifest files continue to be in a healthy state, with a slight increase over last year to a 95% on desktop. The correctness of these files is superb, but their completeness still leaves much to be desired. Currently, only around 0.8% of all websites qualify as installable. Many advanced capabilities like `shortcuts` and `share_target` are beginning to gain traction, appearing in around 5% of PWAs. Other capabilities like `protocol_handlers` and windows controls overlay are too new to have an impact on the data. This year also provides an initial snapshot for many of these Fugu APIs.

Notification fatigue is, understandably, still a factor, but users also request and appreciate legitimate notification use cases. Browser vendors are experimenting with less intrusive permission requests and web push notifications have the advantage of providing a consistent experience across platforms, giving the users the nudge they requested independently of the device they are using.

We hope this information sheds some light in your PWA journey and helps developers understand the current technology trends in API adoption.
