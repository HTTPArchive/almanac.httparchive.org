---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: PWA chapter of the 2022 Web Almanac covering service workers (usage and features), Web App Manifests, Lighthouse insights, service worker libraries (including Workbox), and Web Push notifications.
authors: [diekus]
reviewers: [aarongustafson, tropicadri, webmaxru, Schweinepriester, beth-panx]
analysts: [beth-panx]
editors: [siwinlo]
translators: []
results: https://docs.google.com/spreadsheets/d/1PbzjhN%2D%2DjU9MGuWobw5L9EsmlVzI9tlbCe3_NKA7giU/
diekus_bio: Diego Gonzalez (@diekus) is a computer engineer from Costa Rica working as the PM for PWA platform features for the  Microsoft Edge browser.
featured_quote: The increasing features that allow integration of installable web applications with desktop platforms has driven adoption of the PWAs by big names in the industry.
featured_stat_1: 95%
featured_stat_label_1: Percent of manifest files that are JSON parseable on desktop
featured_stat_2: 63%
featured_stat_label_2: Usage of the install event from the Service Worker on desktop PWAs
featured_stat_3: 60%
featured_stat_label_3: Percentage of PWAs that use Workbox in some capacity
unedited: true
---

## Introduction

In the early days of Progressive Web Apps, there were two key features that harnessed the promise of an advanced modern web application: offline support and a direct icon on the home screen of the device.

These two concepts were enabled after installing a PWA, a process that generally began by tapping on an “ambient badge” that would appear on the browser’s URL bar. This badge would prompt the user to install the website. Mobile browsers such as Samsung Internet and Mozilla Firefox, were among the first ones to explicitly support this behaviour, commonly known as [“Add to home screen” (A2HS)](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Add_to_home_screen).

Five years ago, this was a radical idea. A website would be able to launch directly from the home screen, listed alongside other applications a user had installed on their device. This was the start of progress made towards reducing the gap between capabilities of web apps and OS-specific experiences.

The A2HS scenario has evolved into web apps that can be fully installed and deeply integrated into the host OS, in both mobile and desktop contexts. These past 12 months have seen browsers take important steps towards making sure that PWAs have a tight integration with desktop platforms, and many of the new additions to this year’s almanac reflect these changes. This is the state of PWAs in 2022.

Note: As a set of web technologies, PWAs are not isolated from the rest of the web platform. While there is a chapter dedicated to Capabilities, this year we have investigated the intersection of some of these new advanced capabilities when used inside a PWA.

## Service Workers

[Service Workers](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API) are one of the 3 core technologies (alongside Manifest file and HTTPS) of PWAs and the enabler of offlining apps, getting push notifications, and doing background processing. They serve as the base for most of the advanced experiences we expect from applications. They are also being used to define data updates and for upcoming modern functionality like [widgets based on PWA technologies](https://github.com/aarongustafson/pwa-widgets#rich-widgets).

While there [isn't parity between major browsers when it comes to Service Worker](https://caniuse.com/push-api) feature support, Webkit  adding support for push notifications was a huge milestone. Earlier this year it was announced that [Apple had made changes](https://webkit.org/blog/12945/meet-web-push/) to their desktop platform to support the relevant parts of the [Push API](https://developer.mozilla.org/en-US/docs/Web/API/Push_API), [Notifications API](https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API) and that [Service Workers](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API) would enable Web Push. They also announced the feature would be coming to their mobile platforms in 2023.

### Service Worker Usage

Service workers are not as common as other core technologies of PWAs. For comparison reasons, we have run the same queries as last year, which allows us to try to make sense of the evolution of service worker usage. You can read the explanation of [why it isn’t trivial to find out actual usage of service worker](https://almanac.httparchive.org/en/2021/pwa#service-workers-usage),

* Lighthouse detects a 1.6% (mobile) and 1.7% (desktop) of all websites employ a service worker. We expect this is lower than the real-world percentage due to [additional checks](https://web.dev/service-worker) that Lighthouse takes into consideration.
* Following the same [metrics introduced last year](https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/pwa.js), usage of a Service Worker in websites comes up to 1.63% on desktop and 1.81% on mobile.

{{ figure_markup(
  image="sw_controlled_pages_rank.png",
  caption="Service Worker controlled pages by rank.",
  description="Bar chart showing the percent of PWA websites that are controlled by a service worker. 8.26% of desktop and 8.68% of the top 1000 websites are controlled by a service worker.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1762012854&format=interactive",
  sheets_gid="2067971287",
  sql_file="sw_adoption_over_time_ranking.sql"
  )
}}

There hasn’t been a noticeable change for Service Worker controlled pages in the top 1000 sites as well, with only a slight decrease in desktop and even smaller increase in mobile properties. But there was an increase in all other categories. If we follow the [reasoning from last year](https://almanac.httparchive.org/en/2021/pwa#:~:text=And%20how%20can,via%20service%20workers.), where we postulated that bigger websites adopted the advanced technologies faster. Seeing more growth in other categories makes sense, as smaller companies and developers have learned and adopted the technology shared from case studies and examples from the companies with more traffic.

### Service Worker Features

#### Service Worker events

A Service Worker acts as a proxy server that sits between the web app, the browser and the network. To install a Service Worker it must be fetched and registered. If this is successful, the Service Worker is executed in a [special worker container](https://developer.mozilla.org/en-US/docs/Web/API/ServiceWorkerGlobalScope) that runs off the main thread and has no DOM access. This is when events can be processed.

{{ figure_markup(
  image="most_used_sw_events.png",
  caption="Most used Service Worker events.",
  description="Bar chart showing the most used service worker events. install, activate, notificationclick, push and fetch are the top events each with over 50% usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1426457626&format=interactive",
  sheets_gid="573162824",
    sql_file="sw_events.sql"
  )
}}

The previous chart displays information on the most used service worker events. Each one of these events can be categorized as:

* Lifecycle event
* Notification-related event
* Background processing event

##### Lifecycle events

Install and activate are lifecycle events. It is common practice to create a cache of assets that will allow running the app offline when installing. Activation is generally used to clean up old caches associated with the previous service worker.

{{ figure_markup(
  caption="Usage install event on desktop",
  content="63%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

The service worker needs to be active in order to receive events like fetch and push. This makes them the cornerstone of service workers, and hence the 63% usage on desktop and 61% on mobile for install, and 63% usage on desktop and 61% on mobile regarding activate. The remaining ~40% of sites with Service Worker might not be actively using these events, as they can be using Service Worker for notifications or utilizing techniques to cache requests made only when the site is running, also known as [runtime caching](https://web.dev/runtime-caching-with-workbox/).

While these are still the most used events, we can speculate that there is an increased number of Service Workers which their main task is not pre-caching. This is reflected in the increase of other types of events being used.

##### Notification-related-events

Push notification events come next in most used service worker methods.

{{ figure_markup(
  caption="Usage percent of Notificationclick event (desktop)",
  content="57%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

* `notificationclick` comes up to 57% (an 11% increase over last year’s data) on desktop and 51% (up 5%) on mobile.
* `push` 56% (up 12%) on desktop and 50% (up 5%) on mobile.
* `notificationclose` is now at 15% (up 9%) on desktop and 16% (up 10%) on mobile.

A couple of takeaways here is that momentum continues to grow this year for PWAs on desktop, and push notifications is not an exception. Usage of related events for notifications has gone up around 11%. Many tweaks and fixes have been worked on in different platforms to make sure that these pieces of UX feel completely integrated with the host OS. We expect these numbers to continue growing, following the newly announced [support for Web Push on Webkit](https://webkit.org/blog/12945/meet-web-push/). This is a feature that has being requested by many developers for a long time and finally having support on macOS (and hopefully soon iOS devices) can encourage developers to use the API.

##### Background processing events

The remaining events in the chart represent background processing events.

{{ figure_markup(
  caption="Usage percent of fetch event (desktop).",
  content="49%",
  classes="big-number",
  sheets_gid="573162824",
  sql_file="sw_events.sql"
)
}}

* Fetch, which occurs when a request is sent to the server, can be used to intercept said request and respond with custom or cached assets, enabling offline support for our PWAs. Fetch usage is 49% on desktop and 50% on mobile.
* Sync, which fires when the UA believes the user has connectivity, has a usage of 6% on desktop and 5% on mobile.
* Periodicsync, which allows web applications to periodically synchronize data in the background, is currently at 0.01% on both desktop and mobile platforms. It should be noted that periodicsync is limited to a max of once every 12 hours. This can be artificially suppressing usage of the feature.

#### Other popular SW features

Following the trend of last year, the [skipWaiting](https://developer.mozilla.org/en-US/docs/Web/API/ServiceWorkerGlobalScope/skipWaiting) method that is used to immediately activate the service worker is still very popular among developers, being present in 60% of desktop and 59% of mobile web apps.

{{ figure_markup(
  image="usage_skip_waiting.png",
  caption="Usage of skipWaiting() method.",
  description="Bar chart showing the usage of the skipWaiting() method. 60% on desktop, 59% on mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=174072819&format=interactive",
  sheets_gid="58784102",
  sql_file="xxx.sql"
  )
}}

These are the top most used service worker objects:

{{ figure_markup(
  image="most_used_sw_objects.png",
  caption="Most used Service Worker objects.",
  description="Bar chart depicting the most used Service Worker objects. Clients, caches, cache and client are the top 4 objects.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1869777638&format=interactive",
  sheets_gid="1746822463",
  sql_file="sw_objects.sql"
  )
}}

And these are the most used methods:

* clients.matchAll
* clients.claim
* clients.openWindow
* caches.open
* caches.delete

{{ figure_markup(
  image="most_used_sw_objects_methods.png",
  caption="Most used Service Worker object methods.",
  description="Bar chart that depicts the most used methods for the most used service worker objects. clients.matchAll (61%), clients.claim (58%) and clients.openWindow (56%) on desktop are the top 3 methods used.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1209078963&format=interactive",
  sheets_gid="1969934262",
  sql_file="sw_methods.sql"
  )
}}

## Web App Manifest

The Web App Manifest file is a JSON file that contains information about the application itself. Among the data that is present in the key-value pairs is information relevant to display, promote and integrate the app into the host OS.

Keeping the web app’s manifest fully authored is essential to take advantage of advanced discoverability through online repositories, submissions to application stores, and more recently, a way to tap into advanced capabilities like share target and file handling for your app. Cutting edge work to [enable Widgets based on PWA technology](https://github.com/aarongustafson/pwa-widgets#how-widgets-are-represented-in-these-apis) is also being rooted in the manifest, proving the versatility of the file itself for advanced platform integration even further.

{{ figure_markup(
  caption="Percent of manifest files parseable (desktop)",
  content="95%",
  classes="big-number",
  sheets_gid="717325565",
  sql_file="manifests_not_json_parsable.sql"
)
}}

For most cases, 95% in desktop and 94% in mobile, websites that have a manifest are JSON parseable. This indicates that almost all web apps that use the manifest are correctly formed. This does not indicate completeness or minimum availability of certain fields that would contribute to the installation of the web app. As a matter of fact, there is currently no required properties for the Manifest file. Am empty file technically is a valid Manifest file.

### Manifest Properties and Installability criteria

The manifest file is one of the core technologies that defines PWAs and it plays a key part in signaling to the browser to prompt for installation. Although the way the prompt is triggered [varies with different browsers](https://web.dev/installable-manifest/#in-other-browsers), there’s always a subset of the manifest file involved.

Following are the usage numbers of manifest file alongside service worker. These two used in conjunction generally imply installability.

{{ figure_markup(
  image="sw_manifest_usage.png",
  caption="Service Worker and Manifest usage.",
  description="Bar chart that shows the usage of service workers, manifest files and their combination in web apps. On desktop, service worker is on 1.63% of websites, manifest on 8.38%, and both on 0.77% of web apps.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=409958839&format=interactive",
  sheets_gid="1885116887",
  sql_file="manifests_and_service_workers.sql"
  )
}}

The data tells us that web applications are around 5 times more likely to have a manifest file than a service worker. A contributing factor is that many platforms, such as Content Management Systems (CMSs), auto-generate manifest files for websites.

Only a small percentage of websites, 0.77% on desktop and 0.84% on mobile, implement both service worker and manifest files, which means  less than 1% of websites can be installed on devices like traditional apps.

Looking at top properties used in manifest files this year as compared to last year, there is no significant change:

* `name` (87% desktop / 88% mobile)
* `display` (83% desktop / 85% mobile)
* `icons` (81% desktop / 83% mobile)
* `short_name` (78% desktop / 81% mobile)
* `start_url` (77% desktop / 81% mobile)
* `background_color` (78% desktop / 80% mobile)
* `theme_color` (73% desktop / 76% mobile)
* `description` (38% desktop / 37% mobile)
* `lang` (24% desktop / 24% mobile)
* `gcm_sender_id` (23% desktop / 21% mobile)

Note that the last field, `gcm_sender_id`, is not a standardized property. It is used by the Google Developer Console to identify an app and enabled older versions of Chrome to implement web push, which relied on the GCM service.

{{ figure_markup(
  image="top_pwa_manifest_props.png",
  caption="Top PWA manifest properties.",
  description="Bar chart that shows the top properties used in the manifest file for PWAs. Top 5 are: name, display, icons, short_name and start_url.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=314127541&format=interactive",
  sheets_gid="400343770",
  sql_file="top_manifest_properties.sql"
  )
}}

* lang: 24% of desktop and 23% of mobile manifests are using the `lang` tag to specify the primary language for the value of the manifest’s localizable members.
* display: `standalone` mode is the most common display mode, used by  almost 3/4 of websites that define a display mode. It’s also  one of the display modes that enables an app to be installable.

{{ figure_markup(
  image="display_values.png",
  caption="PWA manifest display values.",
  description="Bar chart that shows the top manifest values used in PWAs. `standalone` with 71% on desktop and `minimal-ui` with 8% are the top 2 values used.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=463813741&format=interactive",
  sheets_gid="264101844",
  sql_file="top_manifest_display_values.sql"
  )
}}

* `orientation`: Most PWAs, 80% for desktop and 79% for mobile do not define a preferred orientation. When set, the most frequently used value is “portrait,” with 13% on desktop and 15% on mobile web sites defining that value on their manifest.
* `icons`: PWAs need to generate different icon sizes to accommodate the range of surfaces where the app can be advertised and placed. Many tools exist to generate the plethora of icons needed for different desktop and mobile environments. The 2 most common icon sizes present in manifest files are `192x192` and `512x512`. Both sizes appear in around 70% of the manifest files analyzed.

{{ figure_markup(
  image="top-icon-sizes.png",
  caption="Top PWA manifest icon sizes.",
  description="Bar chart that depicts the most used sizes for icons in the manifest file. `192x192` and `512x512` are the top icon sizes used with around 70% of manifest using these sizes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1961814023&format=interactive",
  sheets_gid="1009563515",
  sql_file="top_manifest_icon_sizes.sql"
  )
}}

### Installation and discoverability properties

A web app manifest file can contain data that is useful in describing of the application. These properties can be used by stores or other distribution mechanisms to promote the application. An increased growth of [rich browser-based installation dialogs](https://developer.chrome.com/blog/richer-pwa-installation/) is also utilizing these fields more prominently. Relevant fields, which can be found as part of the Application Information supplement to the Manifest file are listed below:

* `description`: This property exists in 36% of desktop and 34% of mobile web app manifests. The description is important since it explains what the application does. It’s commonly used to provide information about the app for a store. Currently around a third of installable PWAs would offer this information.
* `screenshots`: This property provides the URLs of one or more screenshots for use  in app stores and in-browser install prompts. PWAs with manifests that take advantage of this feature total 1.12% for desktop and 1.19% for mobiles devices.
* `categories`: Used as hints for catalog organization.

{{ figure_markup(
  image="top_pwa_manifest_cats.png",
  caption="Top PWA manifest categories.",
  description="Bar chart that shows the top categories for PWA as defined in the manifest. Top 5 are: shopping, news, business, lifestyle and social.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2026035912&format=interactive",
sheets_gid="xxx",
  sql_file="top_manifest_categories.sql"
  )
}}

{{ figure_markup(
  image="top_manifest_cats.png",
  caption="Top manifest categories.",
  description="Bar chart that shows the top categories for all websites as defined in the manifest. Top 5 are: news, shopping, business, social, entertainment.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417728851&format=interactive",
sheets_gid="217012426",
  sql_file="top_manifest_categories.sql"
  )
}}

The top categories for both websites and PWAs remain the same, yet each is slightly different. Top categories are shopping, news, and business.

* `iarc_rating_id`: It’s a string that represents the [IARC certification code](https://www.globalratings.com/how-iarc-works.aspx) of the web app. 0.05% of desktop and mobile apps utilize this field to advertise the rating of their app or game.

#### Advanced capabilities

The manifest file also allows for the activation of modern platform capabilities. These capabilities can allow for advanced windowing capabilities or registration of behaviours in the host OS. Many of these capabilities have landed very recently into the platform, and therefore, we hope this data register an inception of many of these new APIs.

* `shortcuts`: 6.2% of desktop and 4.3% of mobile PWAs are using shortcuts to deeplink into the app.
* `file_handlers`: allows an installed PWA to register itself as a handler for a specific file extension. Only 0.01% of desktop and 0.02% of mobile are using `file_handlers`.
* `protocol_handlers`: PWAs can register to be handlers for predefined or custom protocols. Current usage stands at 0% on desktop and 0.01% for mobile web sites.
* `share_target`: 5.3% of desktop and 3.1% of mobile PWAs have the ability to register themselves to receive shared data.
* [Window Controls Overlay](https://wicg.github.io/window-controls-overlay/): The ability to free the area generally occupied by the title bar is a desktop only feature. This feature has recently launched in Chromium 105 and 0.01% of manifests of desktop PWAs are utilizing it.
* `note_taking`: 0% of desktop and 0.01% of mobile sites are using the ability to have special integration as a convenient way of taking a quick note.

### Other properties

#### Manifest preferring native

{{ figure_markup(
  caption="Manifest files with a related_applications field (desktop)",
  content="2.3%",
  classes="big-number",
  sheets_gid="228985826",
  sql_file="manifests_preferring_native_apps.sql"
)
}}

There is a property in the manifest that specifies if applications listed in the `related_applications` field should be preferred over the web application. This might make the user agent suggest the installation of the related app instead of the web app. From all the manifest files analyzed, only 2.3% on desktop and 2.02% on mobile rely on this.

### FUGU APIs

PWAs go hand in hand with advanced web capabilities. These capabilities are generally part of project FUGU which is the codename for a collection of new web platform features incubating within the Chromium project. From the growing list of features that have been added to the web platform, these are the top APIs being used on the web that are useful for PWAs:

{{ figure_markup(
  caption="Most used FUGU API (desktop)",
  content="8.8%",
  classes="big-number",
  sheets_gid="1110821491",
  sql_file="fugu.sql"
)
}}

* Web Share (desktop): 8.8%
* Add to Home Screen (desktop): 8.6%
* Web Share (mobile): 8.4%
* Add to Home Screen (mobile): 7.7%
* Service Worker (desktop): 4.2%
* Service Worker (mobile): 3.9%
* Push (desktop): 2.0%
* Push (mobile): 1.9%

For detailed information about the FUGU APIs refer to the capabilities chapter.

### PWA Insights

#### Lighthouse audits

Lighthouse scores give an idea of the performance, quality and correctness of web apps. The available data sheds some light on interesting facts about the state of PWAs these past 12 months.

{{ figure_markup(
  image="lighthouse_pwa_audits_desktop.png",
  caption="Lighthouse PWA Audits for desktop.",
  description="Lighthouse PWA Audits for desktop. Top audits look for viewport meta tag, content-width and an installable manifest.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=2100711487&format=interactive",
sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

The top three PWA audits for desktop devices are the presence of a [viewport meta tag](https://web.dev/viewport/#how-to-add-a-viewport-meta-tag), an [installable manifest](https://developer.chrome.com/docs/lighthouse/pwa/installable-manifest/) and the [apple-touch-icon](https://web.dev/apple-touch-icon/#how-the-lighthouse-apple-touch-icon-audit-fails) meta tag.

{{ figure_markup(
  image="lighthouse_pwa_audits_mobile.png",
  caption="Lighthouse PWA Audits for mobile.",
  description="Lighthouse PWA Audits for mobile. Top audits look for viewport meta tag, installable manifest and apple touch icon.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=51840174&format=interactive",
sheets_gid="2095859911",
  sql_file="lighthouse_pwa_audits.sql"
  )
}}

The top three PWA audits for mobile devices include the presence of a viewport meta tag, a [content-width meta tag](https://developer.chrome.com/docs/lighthouse/pwa/content-width/) and an installable manifest.

The presence of a viewport meta tag is relevant because it removes a 300-350ms delay that waits for a double-tap back when that was the way to zoom in. It has the additional benefit on mobile devices of optimizing the app for the device’s screen size. It is not surprising that almost all websites, PWA or not, include this.

Installable manifest also appears in both top 3 lists. As expected, this has a very high value for PWA sites, both on desktop (90.2%) and mobile (95.2%), with a very low counterpart for all websites, presumably because developers don’t intend for these to be  installed.

Finally, apple-touch-icon is third on PWA related Lighthouse audits. Since iOS 1.1.3, Safari for iOS has supported a way for developers to specify an image that will be used to represent the web site or app on the home screen. This is mostly relevant for mobile devices.

#### Lighthouse scores

To conclude the Lighthouse insights section, we take a look at the Lighthouse PWA scores for PWA sites.

{{ figure_markup(
  image="lighthouse_scores_desktop.png",
  caption="Lighthouse scores for desktop.",
  description="Lighthouse PWA scores for desktop sites. Installable PWAs have higher scores",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1918292266&format=interactive",
sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

{{ figure_markup(
  image="lighthouse_scores_mobile.png",
  caption="Lighthouse scores for mobile.",
  description="Lighthouse PWA scores for mobile sites. Installable PWAs have higher scores.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=1463181209&format=interactive",
sheets_gid="674035010",
  sql_file="lighthouse_pwa_score.sql"
  )
}}

As expected, PWA sites tend to have considerably higher PWA audit scores. These audits look into speed, reliability, installability and other PWA requirements, as detailed in their [documentation](https://developer.chrome.com/docs/lighthouse/pwa/).

### Service Worker Libraries

Service workers are really powerful tools, their API allows developers to create app experiences that were impossible before, like creating their own offline experience or caching assets to improve performance, however, creating code that handles the relationship between your web app and the network comes with complexities and caveats. Here is where libraries can make life better for developers by providing higher level abstractions around the Service Worker API.

#### Workbox Usage

[Workbox]([https://developer.chrome.com/workbox/](https://developer.chrome.com/workbox/)) is precisely a set of libraries that was born to ease the usage of service workers for developers. It includes a set of libraries that go from the basics that are reused in other Workbox libraries with [workbox-core](https://developer.chrome.com/docs/workbox/modules/workbox-core/) to more specific tasks like [caching strategies](https://developer.chrome.com/docs/workbox/modules/workbox-strategies/), [background sync](https://developer.chrome.com/docs/workbox/modules/workbox-background-sync/), [precaching](https://developer.chrome.com/docs/workbox/modules/workbox-precaching/) and [much more]([https://developer.chrome.com/docs/workbox/modules/](https://developer.chrome.com/docs/workbox/modules/)).

{{ figure_markup(
  image="workbox usage.png",
  caption="Use of workbox on PWA pages .",
  description="Big spike in workbox usage compared to last year.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=417225871&format=interactive",
sheets_gid="1871711300",
  sql_file="workbox_usage.sql"
  )
}}

Compared with last year we see a big spike in Workbox usage. Last year its usage on mobile was 33% compared to 54% this year, and almost 60% of PWAs use Workbox in some capacity.

Since the growth that we saw in the number of pages controlled by service workers was not in the top 1000 websites but in more granular categories, and this growth on Workbox usage we can infer that adoption of Workbox is happening inside this companies and websites that might have waited for the technology to be adopted by the top websites, or that might not have the need for a completely custom implementation of service workers and get the most out of Workbox’s tested patterns.

#### Workbox packages

Workbox is structured in a way that developers can choose which parts to add to their projects depending on their site's needs. The usage shown below helps us document which PWA features are developers implementing at the moment.

{{ figure_markup(
  image="top_workbox_packages.png",
  caption="Top Workbox packages.",
  description="Increase in usage of the workbox-core base library.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=205966463&format=interactive",
sheets_gid="122135540",
  sql_file="workbox_packages.sql"
  )
}}

Here we also see an overall increase in usage, workbox-core. The base library saw an increase of 14% in usage. Workbox-core, together with workbox-routing and workbox-strategies, is used to create a caching strategy that works to serve different artifacts in their webapp to improve performance.  It makes sense they are all at the top as they enable a core benefit of service workers.

There is also a considerable jump in usage on workbox-precaching. Pre-caching can be used to emulate the model that packaged apps use. With workbox-precaching, you can choose assets that will be cached at the time of service worker installation to make those assets load faster in subsequents visits.

What is surprising is the rise in workbox-sw usage,  because starting with [Workbox 5](https://github.com/GoogleChrome/workbox/releases/tag/v5.0.0), the Workbox team has encouraged developers to create custom bundles of the Workbox runtime instead of using `importScripts()` to load <code>[workbox-sw](https://developers.google.com/web/tools/workbox/modules/workbox-sw)</code> (the runtime). The Workbox team will continue supporting <code>workbox-sw</code>, but the new technique is now the recommended approach. In fact, the defaults for the build tools have switched to prefer that method.

It is possible the increase is coming from libraries that use older versions of Workbox like [create-react-app version 3](https://github.com/facebook/create-react-app/blob/v3.4.4/packages/react-scripts/package.json#L82)

### Web Push Notifications

Notifications are a powerful way to re-engage with users. It is also one characteristic that we expect from platform-specific applications. Notifications are the perfect way to give timely, relevant and precise information, and it is powered by the Web Push API.

#### Web Push notification acceptance rates

We can acknowledge that the implementation for web notifications has not been the smoothest for developers or users, but it is important to also note how useful of a tool they are. Like calendar notifications, subscription updates, or games, the important thing is that users get to choose when to turn them on.

It bears repeating that for a notification to be useful it has to be [timely, precise, and relevant](https://developers.google.com/web/fundamentals/push-notifications). At the moment of showing the prompt to request permission, the user needs to understand the value of the service. Developers have the chance to onboard the users into notifications before they show the browser permissions dialog by sharing the advantages the users will get your specific notifications.

{{ figure_markup(
  image="notification_acceptance.png",
  caption="Notification acceptance rates.",
  description="Chart that shows the acceptance of notifications across desktop and mobile. It shows that users tend to ignore notification more and more frequently.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS7KgpDrr_m20ZDaHDBYLFSGNVdj3lhGHbHopEi4071q21U5rZDJfbYrrdyaEIU1D9cwgxxBCI6NBsV/pubchart?oid=148157045&format=interactive",
sheets_gid="435156894",
  sql_file="pwa_notification_acceptance_rates.sql"
  )
}}

With the growth of notification support and the UX improvements  in different platforms, there hasn’t been any major changes in the acceptance of notifications. Since early 2020 they have been around the 6% acceptance rate on desktop and 20% on mobile.

{{ figure_markup(
  caption="Notification acceptance rate (desktop)",
  content="6%",
  classes="big-number",
  sheets_gid="435156894",
  sql_file="pwa_notification_acceptance_rates_over_time.sql"
)
}}

{{ figure_markup(
  caption="Notification acceptance rate (mobile)",
  content="19%",
  classes="big-number",
  sheets_gid="435156894",
  sql_file="pwa_notification_acceptance_rates_over_time.sql"
)
}}

Desktop and mobile notification acceptance rate share a common fashion, and it is the trend to ignore notifications. The sum of “ignore” has gone up from 48% in February 2020 all the way up to 70% in June 2022. For mobile platforms, from 1.88% in February 2020 to a staggering 34% for June this year. Notification fatigue, coupled with increasing number of prompts for security, privacy, and advanced capabilities are partially responsible, and work is being carried out to address this and present better unified UX across different platforms.

## Conclusion

2022 has been a stellar year for PWAs. The increasing features that allow integration of installable web applications with desktop platforms has driven adoption of the technology by big names in the industry. This past year advanced capabilities like protocol handlers, window controls overlay, run on OS login, and more have started to position PWAs as a key technology for application development. Whilst encouraging, this is not representative of the totality of the web platform. Service Worker usage percentage fell to around half, compared to the data from 2021, but the rise of big applications constructed using PWA technology rose.

Manifest files continue to be in a healthy state, with a slight increase over last year to a 95% on desktop. The correctness of these files is superb, but their completeness still leaves much to be desired. Currently, only around 0.8% of all websites qualify as installable.  Many advanced capabilities like `shortcuts` and `share_target` are beginning to gain traction, appearing in around 5% of PWAs. Other capabilities like `protocol_handlers` and windows controls overlay are too new to have an impact on the data. This year also provides an initial snapshot for many of these FUGU APIs.

Notification fatigue is, understandably, still a factor, but users also request and appreciate legitimate notification use cases. Browser vendors are experimenting with less intrusive permission requests and web push notifications have the advantage of providing a consistent experience across platforms, giving the users the nudge they requested independently of the device they are using.

We hope this information sheds some light in your PWA journey and helps developers understand the current technology trends in API adoption.
