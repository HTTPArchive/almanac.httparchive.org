---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: PWA chapter of the 2025 Web Almanac covering service workers (usage and features), web app manifests, Fugu APIs, and Web Push notifications.
hero_alt: Hero image of Web Almanac characters converting a web page to a mobile web app.
authors: [diekus, MichaelSolati]
reviewers: [webmaxru, Schweinepriester, aarongustafson]
analysts: []
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1mEbm1NTrqy8B4l5zY3gPgbKWxyNdWOPfVmi1pDIyMus/edit
diekus_bio: Diego Gonzalez is a computer engineer from Costa Rica working as the PM for PWA platform features for the Microsoft Edge browser.
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

The year 2015 was the first time we <a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">read about Progressive Web Applications</a>. Nine attributes—responsive, connectivity independent, app-like-interactions, fresh, safe, discoverable, re-engageable, installable and linkable—were what defined the cutting edge of what could be achieved with web technologies back then. _The PWA concept was coined 10 years ago_, and it is with great pride that we look at the state of this set of technologies, one decade after its ideation.

The concept of a PWA has evolved a lot in these 10 years, and different browsers support it in different variations and with different names. An idea that started as a way of enabling access to a web application via "Add to home screen" (A2HS) on mobile browsers is now present on multiple platforms and devices. This set of technologies allow to integrate web content directly into the underlying platform, enabling at the same time advanced capabilities and a more native look and feel. Let's dive into what the last couple of years have brought to PWAs.

## Changes to PWA/web apps

The last couple of years have seen new features coming to web apps that enable more customization, advanced control of the application's behavior and better performance. But above all, there has been progress in supporting web apps (to an extent or another) on multiple engines!

_Chromium_ based browsers prompt for an application installation once a minimum set of requirements is identified. This used to be the case on apps that had a manifest file, a service worker and were served over a secure connection. For a while this was the "trifecta" for PWA installability. This has changed and nowadays _only_ the manifest is required (the HTTPS connection is still there, do not worry);  service workers are no longer required for browsers like Edge and Chrome to display the installation prompt.

On the other hand, Safari does not prompt for web app installation. It does however allow _any web page_ to be installed as an application by <a hreflang="en" href="https://support.apple.com/en-us/104996">adding it to the dock</a> on macOS 14.

Another great news for PWAs is that <a hreflang="en" href="https://support.mozilla.org/en-US/kb/web-apps-firefox-windows">Firefox now supports web apps</a> from version 143! It is available for PWAs on Windows _only_, following what has been a <a hreflang="en" href="https://connect.mozilla.org/t5/discussions/how-can-firefox-create-the-best-support-for-web-apps-on-the/m-p/60561/highlight/true#M21220">"top request from the Mozilla Connect community"</a>.

With web apps, being _web_ based, one of the concerns of not having a service worker is offline support. It is true using service workers allow developers to provide a great offline experience by caching resources that make up the UI of the web app. The change in requirements (for Chromium) or default behaviors (for Safari and Firefox) means that the browser may create a default offline experience that shields users from lack of connectivity.

<aside class="note">Bear in mind that service workers are still required for the best offline UX. For an up-to-date summary of web app installability, see this [MDN article](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Guides/Making_PWAs_installable).</aside>

With this summary, we are now ready to jump into the data and understand the state of PWAs right now. We will finalize by comparing this year's data with the data from [3 years ago](../2022/pwa), which was the last time there was a chapter on PWAs, when possible.

## Service worker

Service workers (SW) remain essential to allow advanced capabilities like background sync, offline support and push notifications to web apps. This year, the data suggest around one fifth of web properties are using service workers.

To start strong, we will look at the service worker controlled pages by rank. From the top 1000 pages, 28.8% (desktop) and 27.5% (mobile) are managed by a service worker. This is **around a 20% increase compared to the data from 3 years ago**. Overall, across every rank grouping there was a strong increase, when looking at _all_ the percentage of PWA websites going from 1.4% (desktop and mobile) in 2022 to 20.1% (desktop) and 19.7% in mobile.

{{ figure_markup(
  image="pwa-sw-control-ranking.png",
  caption="SW controlled pages by rank.",
  description="Bar chart showing the PWA websites controlled by SW by their ranking.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1868664844&format=interactive",
  sheets_gid="374256727",
  sql_file="TODO"
  )
}}

Following we have usage data for capabilities of service worker by events, methods and objects.

### Service worker events

{{ figure_markup(
  image="pwa-sw-events.png",
  caption="Most used service worker events.",
  description="Bar chart showing the popularity of SW events, with activate being around 96% and install around 63%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1621146621&format=interactive",
  sheets_gid="577288813",
  sql_file="TODO"
  )
}}

The most used event for these service workers is the activation (`activate`) with almost every SW using it, around 96% of PWAs using it. The `install` event takes second place with around 64% usage. Both `install` and `activate` are core lifecycle events so these numbers do not come as a surprise. This might suggest that applications are caching resources to speed up their loading times and performing SW management.

Usage of other advanced events, like `fetch`, `notificationclick` and `push` falls considerably, possibly due to these being capabilities that fall into more advanced scenarios, like intercepting network requests, bypassing the default offline UX or delivering notifications from a push service.

### Service worker methods

{{ figure_markup(
  image="pwa-sw-methods.png",
  caption="Most used service worker methods.",
  description="Bar chart showing the popularity of SW methods, with skipWaiting being used aproximate 66%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=628466183&format=interactive",
  sheets_gid="1005909719",
  sql_file="TODO"
  )
}}

Looking at the most used service worker method, `skipWaiting()` has a notable use, with 66% usage on desktop and 62% on mobile. The browser will activate the service worker and replace the old one immediately. This implies developers are keen to ensure users don't get stuck with stale assets. This is beneficial for applications that require frequent updates, like dashboards and messaging apps. It basically helps users get the latest version of the application right away.

### Service worker objects

{{ figure_markup(
  image="pwa-sw-objects.png",
  caption="Most used service worker objects.",
  description="Bar chart showing the popularity of SW objects.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1490213107&format=interactive",
  sheets_gid="928442900",
  sql_file="TODO"
  )
}}

The most used SW objects are `clients`, `caches` and `cache`. For clients, this can be expected as it is the way to tell the service worker to take control of all open pages by calling `clients.claim`. Regarding `caches`, management methods appear on top, also not surprising considering that these are the methods that developers would use to make sure their assets are up to date to achieve that speedy page load.

As hinted before, the main methods from these correspond to `claim`, `open`/`delete`/`keys`/`match`, and `add`.

### Registration properties

{{ figure_markup(
  image="pwa-sw-reg-properties.png",
  caption="Most registered service worker properties.",
  description="Bar chart showing the most registered SW properties, with pushManager.subscribe and pushManager.getSubscription on top with a 7% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=304535758&format=interactive",
  sheets_gid="1703056951",
  sql_file="TODO"
  )
}}

Diving deeper into service worker functionality, the data sheds some light into advanced capabilities that PWAs are using. For all PWAs using service workers across desktop and mobile, ~7% are registering for pushManager, 2% register for sync and 2% register for navigationPreload.

## Web application manifest

The web application manifest is now, more than ever, the most important part of a web app. It defines a look and feel, enables advanced capabilities that are gated behind an installation and is becoming an integral part that identifies a web application as a whole. But in order to be effective, the manifest file needs to be well formed. For the current year, 94.4% of desktop sites and 95% of mobile sites are parseable. There is no change from the last data set, and same as last time around, the fact that the manifest file was able to be parsed does not imply completeness or minimum availability of features. Many values in the manifest, as important as they may seem, have reasonable fallbacks in place.

From those parseable manifests, we will now look at individual present fields. This can give us an understanding of how developers are using the manifest file and if there have been changes since 2022.

### manifest properties

Straight up, these are the most used PWA manifest properties: name, icons, short_name and display and background_color. The top 4 most used properties are the same ones from 2022, with subtle notable changes regarding their order.

{{ figure_markup(
  image="pwa-manifest-properties.png",
  caption="Most used manifest properties.",
  description="Bar chart showing the most used Web App manifest properties. Name Icons and short_name on the top.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1634923260&format=interactive",
  sheets_gid="2030078867",
  sql_file="TODO"
  )
}}

Let's examine how individual members rate in the totality of manifest files scanned by the Web Almanac. Unless noted otherwise, values are very similar so I will refer to both mobile and desktop sites.

<figure>
  <table>
    <thead>
      <tr>
        <th>Manifest field</th>
        <th class="numeric">Sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>description</code></td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td><code>file_handlers</code></td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td><code>iarc_rating_id</code></td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td><code>lang</code></td>
        <td class="numeric">14%</td>
      </tr>
      <tr>
        <td><code>screenshots</code></td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td><code>share_target</code></td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td><code>shortcuts</code></td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td><code>window-controls-overlay</code></td>
        <td class="numeric">0.046%</td>
      </tr>
      <tr>
        <td><code>note-taking</code></td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>protocol_handlers</code></td>
        <td class="numeric">0.21%</td>
      </tr>
      <tr>
        <td><code>prefer_related_applications</code></td>
        <td class="numeric">8%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Manifest properties.", sheets_gid="2030078867", sql_file="TODO.sql") }}</figcaption>
</figure>

For the manifests that specify the `categories` member, the top categories are:

{{ figure_markup(
  image="pwa-manifest-categories.png",
  caption="Most used manifest category values.",
  description="Bar chart showing the top categories defined in the manifest field (shopping/business and education).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=991806108&format=interactive",
  sheets_gid="848602015",
  sql_file="TODO"
  )
}}

While the [manifest key `categories`](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest/Reference/categories) is not used in many PWAs, these results hint at the top verticals on which web apps are more popular.

### Manifest `display` values

The display member is used to specify the preferred display mode for the web app. Different browsers have different interpretations of these values, but overall it hints to the UA how much of the browser UX to show/hide.

{{ figure_markup(
  image="pwa-manifest-displays.png",
  caption="Most used display values in the manifest (standalone).",
  description="Bar chart showing the most used display values in the manifest file (standalone).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=364018981&format=interactive",
  sheets_gid="1096790994",
  sql_file="TODO"
  )
}}

Most web apps (78%) opt for a `standalone` value for the display member. From the documentation, [standalone](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest/Reference/display#standalone) "opens the app to look and feel like a standalone native app". This is not surprising as the general intention of a web app for a developer would be to have the app look more native-like, removing the browser chrome and some other UX. On the end this is something that varies with the implementation, as for example in Chromium browsers you get a `...` menu and on Firefox some browser UI like the URL bar still remains for installed apps.

### Manifest `icons` sizes values

{{ figure_markup(
  image="pwa-manifest-icons.png",
  caption="Most used icons size values in the manifest.",
  description="Bar chart showing the most used icon size values in the manifest file (192px and 512px).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1792269416&format=interactive",
  sheets_gid="1340146193",
  sql_file="TODO"
  )
}}

Top sizes include 192x192 and 512x512.

###  Manifest `orientation` values

{{ figure_markup(
  image="pwa-manifest-orientation.png",
  caption="Most used orientation values in the manifest.",
  description="Bar chart showing the most used orientation values in the manifest file (none!).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=165636531&format=interactive",
  sheets_gid="701832198",
  sql_file="TODO"
  )
}}

Unsurprisingly, around 79.5% of PWAs do not set orientation. Responsive design and modern development make defining the app's orientation less necessary, but portrait takes second place with around 11.9%.

##  Service worker and manifest usage

We've seen the latest data on what the most used service worker and manifest features are. In 2025, we can see that roughly one fifth of sites use service workers, and roughly one tenth use manifests.

{{ figure_markup(
  image="pwa-manifest-sw-manifest-usage.png",
  caption="PWA service worker and manifest file usage.",
  description="Bar chart showing service worker (18.9%) and manifest file (~9%) usage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=588231319&format=interactive",
  sheets_gid="1678838470",
  sql_file="TODO"
  )
}}

Overall, there are considerable changes to the data from the 2022 HTTP Almanac. service worker usage has taken a huge leap from around 1.7% to 18.9%. That is around a 10 times increase in adoption. manifest usage is slightly higher but remains at a very similar spot as it was 3 years ago.

## PWAs and Fugu APIs

These are the top 10 used advanced capabilities in PWAs for 2025.

<figure>
  <table>
    <thead>
      <tr>
        <th>Capability</th>
        <th>Mobile</th>
        <th>Desktop </th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Compression Streams</td>
        <td class="numeric">18.6%</td>
        <td class="numeric">21.1%</td>
      </tr>
      <tr>
        <td>Async Clipboard</td>
        <td class="numeric">17.9%</td>
        <td class="numeric">19.2%</td>
      </tr>
      <tr>
        <td>Device Memory</td>
        <td class="numeric">10.3%</td>
        <td class="numeric">10.3%</td>
      </tr>
      <tr>
        <td>Web Share</td>
        <td class="numeric">8.9%</td>
        <td class="numeric">9.0%</td>
      </tr>
      <tr>
        <td>Media Session</td>
        <td class="numeric">6.8%</td>
        <td class="numeric">7.8%</td>
      </tr>
      <tr>
        <td>Add to Home Screen</td>
        <td class="numeric">6.8%</td>
        <td class="numeric">7.3%</td>
      </tr>
      <tr>
        <td>Media Capabilities</td>
        <td class="numeric">6.4%</td>
        <td class="numeric">7.4%</td>
      </tr>
      <tr>
        <td>Cache Storage</td>
        <td class="numeric">9.0%</td>
        <td class="numeric">3.0%</td>
      </tr>
      <tr>
        <td>Service worker</td>
        <td class="numeric">3.7%</td>
        <td class="numeric">3.3%</td>
      </tr>
      <tr>
        <td>Push</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 10 used advanced capabilities in PWAs.", sheets_gid="220067822", sql_file="TODO.sql") }}</figcaption>
</figure>

There is a complete separate chapter dedicated to [capabilities](./capabilities.md) to dive deeper in the adoption that these sort of APIs have had in 2025.

## Notifications and PWAs

Notifications make sense for apps as they allow the user to re-engage with the application. This is a controversial capability as there is considerable bad UX and dark patterns to try to get users to accept them. The data shows that in both desktop and mobile, the most common action a user takes is to ignore these requests.

{{ figure_markup(
  image="pwa-manifest-notification-rates.png",
  caption="PWA notification acceptance rates.",
  description="Bar chart showing PWA notification acceptance rates. Most of them are ignored in both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1327754740&format=interactive",
  sheets_gid="487663654",
  sql_file="TODO"
  )
}}

Desktop notification acceptance is overwhelmingly ignored:  78% of them are disregarded, with a slightly lower but still meaningful 48% on mobile. This is not a surprise considering overall the notification fatigue users deal with on a regular basis.

## Conclusion

It has been a decade since PWAs. The landscape has changed a bit as the technology and capabilities reach maturity; we now have all major browsers (Edge, Chrome, Firefox and Safari) supporting web apps to a degree. Web apps continue to show growth and almost one fourth of web sites crawled have either a service worker or a manifest file.

If you have noticed a slow down in pace of new features, you are correct. There are less web app features being launched today than a few years ago. I believe this has to do with the fact that capability-wise the platform has reached a level of maturity that allows a wide range of use cases to be created using a web tech stack. On the other hand there is a question of adoption that is tightly coupled with cross-engine capability support. It is until (very) recently that some major browsers are starting to support (some) advanced features, yet alone the possibility to acquire or install a web app.

Whilst advanced capabilities continue to be used sparingly, likely due to slow implementor support, the oldest capabilities like Web Share are starting to show up as well, and even more niche UX features like 'window-controls-overlay' are starting to show up in the data. Slowly but surely these features are being commoditized.

If we look back to the last Almanac that had a PWA chapter, these are the things we can notice:

- 2 more browsers (Safari and Firefox) have support for web apps.
- Service worker controlled pages have gone up around 20% for all PWA websites from 2022.
- There is less diversity of SW events being used than 3 years ago. Less percentage of PWAs are using `notificationclick`, `push`, and `fetch`.
- Percentage of `pushManager` registrations has dropped since 2022, likely due to the rise of usage (see note below) of SW to focus on performance rather than pushing notifications.
- Between 2022 and 2025 the total of PWA technology usage (desktop 12.5 million and mobile 15.5 million) has around doubled (desktop 5.4 million and mobile 7.9 million - 2022). The percentage of usage for service workers has surged around 10 times, and manifests have largely stayed around the same 8-9% usage.
- Ignoring notification prompts is still the most common behavior for users.

<aside class="note">Since these are percentages, it is worth noticing that "diversity of calls" or "drop in registrations" isn't particularly a sign of rejection or lack of use, but instead is a result to the fact that the usage of the core technology has _risen_. As an example, for PWA registration properties, the total for `pushManager.getSubscription` goes up from 52 thousand pages to roughly under 3 million in the last 3 years.</aside>

As we close the 2025 Web Almanac PWA chapter, there's ongoing work and agreement towards looking at a way to democratize web app distribution by baking installation capabilities directly into the platform. We hope in the next 10 years the PWA technologies will follow the same fate as responsive design, where they have been commoditized and web apps that have good UX for application lifecycle management will be the norm, in conjunction with newer capabilities that redefine what a web app can do. Here's to the next decade for web apps!
