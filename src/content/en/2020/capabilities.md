---
part_number: II
chapter_number: 13
title: Capabilities
description: Capabilities chapter of the 2020 Web Almanac covering brand-new, powerful web platform APIs.
authors: [christianliebel]
reviewers: [logicalphase,tomayac]
analysts: [tomayac]
translators: []
discuss: 1981
results: https://docs.google.com/spreadsheets/d/1N6j1qKv7vc51p1W9z_RrbJX9Se3Pmb-Uersfz4gWqqs/
queries: 13_Capabilities
published: 2020-11-07T00:00:00.000Z
last_updated: 2020-11-07T00:00:00.000Z
---

## Introduction

The Capabilities Project, informally also known as Project Fugu, is a cross-company effort by Google, Microsoft, and Intel to close the gap between native applications and web apps. To do so, the Chromium contributors implement new APIs exposing capabilities of the operating system to the web, while maintaining user security, privacy, and trust. These capabilities include, but are not limited to:

- [File System Access API](https://web.dev/file-system-access/) for accessing files on the local file system
- [File Handling API](https://web.dev/file-handling/) for registering as a handler for certain file extensions
- [Async Clipboard API](https://web.dev/async-clipboard/) to access the user's clipboard
- [Web Share API](https://web.dev/web-share/) for sharing files with other applications
- [Contact Picker API](https://web.dev/contact-picker/) to access contacts from the user's address book
- [Shape Detection API](https://web.dev/shape-detection/) for efficient detection of faces or barcodes in images
- [Web NFC](https://web.dev/nfc/), [Web Serial](https://web.dev/serial/), Web USB, Web Bluetooth, and other APIs (for the entire list, see the [Fugu API Tracker](https://goo.gle/fugu-api-tracker))

Everyone can propose a new capability by [creating a ticket in the Chromium bug tracker](https://bit.ly/new-fugu-request). The Chromium contributors examine the proposals and discuss all APIs with other developers and browser vendors through the appropriate standards bodies. Meanwhile, the Fugu team implements the API in Chromium, where it is initially implemented behind a flag. In the further process, the API is made available to a limited audience via an [origin trial](https://web.dev/origin-trials/). During this phase, developers can sign up for a token to test the API on a specific origin. If the API turns out to be robust enough, the API ships in Chromium and, if the vendors decide so, other browsers.

The codename of the Capabilities project is named after a Japanese dish: Correctly prepared, the meat of the blowfish is a special taste experience. If prepared incorrectly, however, it can be fatal. The powerful APIs of Project Fugu are extremely exciting for developers. However, they can affect the security and privacy of the user. Therefore, the Fugu team pays special attention to these issues: For instance, new interfaces require the website to be sent over a secure connection (HTTPS). Some of them require a user gesture, such as a click or key press, to prevent fraud. Other capabilities require explicit permission by the user. Developers can use all APIs as a progressive enhancement: By feature detecting the APIs, applications won't break in browsers lacking support for those capabilities. In browsers that support them, users can get a better user experience. This way, web apps [progressively enhance](https://web.dev/progressively-enhance-your-pwa/) according to the user's particular browser.

This chapter gives an overview of various modern web APIs, and the state of web capabilities in 2020 based on usage data by the HTTP Archive. Due to technical limitations, the HTTP Archive only has data available for APIs that require neither permission, nor a user gesture. Where no data is available, the percentage of page loads in Google Chrome according to [Chrome Platform Status](https://chromestatus.com/metrics/feature/timeline/popularity) will be shown instead. Since some interfaces are brand-new and their usage is still very low, the statistics are not necessarily meaningful. However, in many cases trends can still be read from the data. Unless otherwise noted, the APIs are only available in Chromium-based browsers, and their specifications are in the early stages of standardization.

## Async Clipboard API

With the help of the `document.execCommand()` method, websites could already access the user's clipboard. However, this approach is somewhat restricted, as the API is synchronous (making it difficult to process clipboard items), and it can only interact with selected text in the DOM. This is where the [Async Clipboard API](https://web.dev/async-clipboard/) ([W3C Working Draft](https://www.w3.org/TR/clipboard-apis/#async-clipboard-api)) comes in. This new API is not only asynchronous, meaning it doesn't block the page for large chunks of data or waiting for a permission to be granted, but also allows for images to be copied to or pasted from the clipboard in supported browsers such as Chrome, Edge, and Safari.

### Read Access

The Async Clipboard API provides two methods for reading content from the clipboard: A shorthand method for plain text, called `navigator.clipboard.readText()`, and a method for arbitrary data, called `navigator.clipboard.read()`. Currently, most browsers only support HTML content and PNG images as additional data formats. Due to privacy reasons, reading from the clipboard always requires the user's consent.

{{ figure_markup(
  image="async_clipboard_api.png",
  caption="Async Clipboard API",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1740212588&format=interactive",
  sheets_gid="2077755325"
  )
}}

The Async Clipboard API is comparatively new, so its usage is currently rather low. In March 2020, Safari added support for the Async Clipboard API in Safari 13.1. Over the course of 2020, the usage of the `read()` API was growing. In October 2020, the API was called during 0.0003 percent of all page loads in Google Chrome.

### Write Access

Apart from reading operations, the Async Clipboard API also offers two methods for writing content to the clipboard. Again, there's a shorthand method for plain text, called `navigator.clipboard.writeText()`, and one for arbitrary data called `navigator.clipboard.write()`. In Chromium-based browsers, writing to the clipboard while the tab is active does not require permission. Trying to write to the clipboard when the website is in the background does, however. As this method requires a user gesture and permission first, it's not covered by the HTTP Archive metrics. In contrast to the `read()` method, the `write()` method shows an exponential growth in usage, being part of 0.0006 percent of all page loads in October 2020.

The Raw Clipboard Access API ([related Chromium bug](https://bugs.chromium.org/p/chromium/issues/detail?id=897289)), another Fugu capability, might even further enhance the Async Clipboard API by allowing arbitrary data to be copied from or pasted to the clipboard.

## StorageManager API

Web browsers allow users to store data on the user's system in different ways, such as Cookies, the Indexed Database (IndexedDB), the Service Worker's Cache Storage, or Web Storage (Local Storage, Session Storage). In modern browsers, developers can easily [store hundreds of megabytes and even more](https://web.dev/storage-for-the-web/), depending on the browser. When browsers run out of space, they can clear data until the system is no longer over the limit, which can lead to data loss.

Thanks to the [StorageManager API](https://web.dev/storage-for-the-web/#check-available) (part of the [WHATWG Storage Living Standard](https://storage.spec.whatwg.org/#storagemanager)), browsers no longer behave like a black box in that regard: This API allows developers to estimate the remaining space available, and to opt-in to [persistent storage](https://web.dev/persistent-storage/), meaning that the browser will not clear a website's data when disk space is low. Therefore, the API introduces a new `StorageManager` interface on the `navigator` object, currently available on Chrome, Edge, and Firefox.

### Estimate the available storage

Developers can estimate the available storage by calling `navigator.storage.estimate()`. This method returns a promise resolving to an object with two properties: `usage` shows the number of bytes used by the application and `quota` contains the maximum number of bytes available.

{{ figure_markup(
  image="storage_manager_api_estimate.png",
  caption="StorageManager API :: Estimate",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1853644024&format=interactive",
  sheets_gid="1811313356",
  sql_file="storage_manager_api_estimate.sql"
  )
}}

The Storage Manager API is supported in Chrome since 2016, Firefox since 2017, and the new Chromium-based Edge. HTTP Archive data shows that the API is used in 0.36 percent of all desktop websites tracked by the archive, and 0.21 percent of all mobile websites. Over the course of 2020, the usage of the Storage Manager API kept growing. This also makes this interface the most commonly used API in this chapter.

### Opt-in to persistent storage

There are two categories of web storage: "Best Effort" and "Persistent", with the first being the default. When a device is low on storage, the browser automatically tries to free up best effort storage. For instance, Firefox and Chromium-based browsers evict storage from the least recently used origins. This, however, poses a risk of losing critical data. To prevent eviction, developers can opt for persistent storage. In this case, the browser will not clear the storage, even when space is low. Users can still choose to clear up the storage manually. To opt for persistent storage, developers need to call the `navigator.storage.persist()` method. Depending on the browser and site engagement, a permission prompt may show, or the request will automatically be accepted or denied.

{{ figure_markup(
  image="storage_manager_api_persist.png",
  caption="StorageManager API :: Persist",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=644836316&format=interactive",
  sheets_gid="1095648844",
  sql_file="storage_manager_api_persist.sql"
  )
}}

The `persist()` API is less often called than the `estimate()` method. Only about 0.003 percent of mobile websites make use of this API, compared to around 0.0005 percent of desktop websites. While usage on the desktop seems to remain at this low level, there is no clear trend on mobile devices.

## New Notification APIs

With the help of the Push and Notifications APIs, web applications have long been able to receive push messages and display notification banners. However, some parts were missing: Up until now, push messages had to be sent via the server; they could not be scheduled offline. Also, web applications installed to the system could not show badges on their icon. The Badging and Notification Triggers APIs enable both scenarios.

### Badging API

On several platforms, it's common for applications to present a badge on the application's icon indicating the amount of open actions: For instance, the badge could show the number of unread emails, notifications, or to-do items to complete. The [Badging API](https://web.dev/badging-api/) ([W3C Unofficial Draft](https://w3c.github.io/badging/)) allows installed web applications to show such a badge on its icon. By calling `navigator.setAppBadge()`, developers can set the badge. This method takes a number to be shown on the application's badge. The browser then takes care of displaying the closest possible representation on the user's device. If no number is specified, a generic badge will be shown (e.g., a white dot on macOS). Calling `navigator.clearAppBadge()` removes the badge again. Badging API is a great choice for email clients, social media apps, or messengers. The Twitter PWA makes use of the Badging API to show the number of unread notifications on the application's badge.

{{ figure_markup(
  image="badging_api.png",
  caption="Badging API",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1145004925&format=interactive",
  sheets_gid="1154751352"
  )
}}

In April 2020, Google Chrome 81 shipped the new Badging API, followed by Microsoft Edge 84 in July. After Chrome shipped the API, the usage numbers shot up. In October 2020, on 0.022 percent of all page loads in Google Chrome, the `setAppBadge()` method is called. The `clearAppBadge()` method is less often called, during around 0.014 percent of page loads.

### Notification Triggers API

The Push API requires the user to be online to receive a notification. Some applications, such as games, reminder or to-do apps, calendars, or alarm clocks, could also determine the target date for a notification locally and schedule it. To support this feature, the Chrome team experiments with a new API called [Notification Triggers](https://web.dev/notification-triggers/) ([Explainer](https://github.com/beverloo/notification-triggers/blob/master/README.md), not on a standards track yet). This API adds a new property called `showTrigger` to the `options` map that can be passed to the `showNotification()` method on the Service Worker's registration. The API is designed to allow for different kinds of triggers in the future, albeit for now, only time-based triggers are implemented. For scheduling a notification based on a certain date and time, developers can create a new instance of a `TimestampTrigger` and pass the target timestamp to it:

```js
registration.showNotification('Title', {
  body: 'Message',
  showTrigger: new TimestampTrigger(timestamp),
});
```

{{ figure_markup(
  image="notification_triggers_api.png",
  caption="Notification Triggers API",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1388597384&format=interactive",
  sheets_gid="1740370570"
  )
}}

The Fugu team first experimented with Notification Triggers in an origin trial from Chrome 80 to 83, pausing development afterwards due to the lack of feedback by developers. Starting from Chrome 86 released in October 2020, the API has entered the origin trial phase again. This also explains the usage data of Notification Triggers API that peaked at being called on 0.000032 percent of page loads in Chrome during the first origin trial at around March 2020.

## Screen Wake Lock API

To save energy, mobile devices darken the screen backlight and eventually turn off the device's display, which makes sense in most cases. However, there are scenarios where the user may want the application to explicitly keep the display awake, for instance, when reading a recipe while cooking or watching a presentation. The [Screen Wake Lock API](https://web.dev/wakelock/) ([W3C Working Draft](https://www.w3.org/TR/screen-wake-lock/)) solves this problem by providing a mechanism to keep the screen on.

To obtain a wake lock, call the `navigator.wakeLock.request()` method. This method takes a `WakeLockType` parameter. In the future, the Wake Lock API could provide other lock types, such as turning the screen off, but keeping the CPU on. For now, the API only supports screen locks, so there is just one optional argument with the default value of `'screen'`. The method returns a promise that resolves to a `WakeLockSentinel` object. To release the screen wake lock later on, call the `release()` method on this object, so developers need to store the reference. The browser will automatically release the lock when the tab is inactive, or the user minimizes the window. Also, the browser may deny a request and reject the promise, for example due to low battery.

{{ figure_markup(
  image="screen_wake_lock_api.png",
  caption="Screen Wake Lock API",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=718278185&format=interactive",
  sheets_gid="1008442251",
  sql_file="screen_wake_lock_api.sql"
  )
}}

BettyCrocker.com, a popular cooking website in the US, offers their users an option to prevent the screen from going dark while cooking with the help of the Screen Wake Lock API. In a [case study](https://web.dev/betty-crocker/), they published that the average session duration was 3.1 times longer than normal, the bounce rate reduced by 50%, and purchase intent indicators increased by about 300 percent. The interface therefore has a directly measurable effect on the success of the website or application, repectively. The Screen Wake Lock API shipped with Google Chrome 84 in July 2020. The HTTP Archive only has data for April, May, August and September. After the release of Chrome 84, usage data quickly rose to 0.00011 percent on desktop and 0.00009 percent on mobile.

## Idle Detection API

Some applications need to determine if the user is actively using a device or if they are idle. For instance, chat applications may display that the user is absent. There are various factors that can be taken into account, such as a lack of interaction with the screen, mouse, or keyboard. The [Idle Detection API](https://web.dev/idle-detection/) ([WICG Draft Community Group Report](https://wicg.github.io/idle-detection/)) provides an abstract API that allows developers to check if either the user is idle or the screen locked, given a certain threshold.

To do so, the API provides a new `IdleDetector` interface on the global `window` object. Before developers can use this functionality, they have to request permission by calling `IdleDetector.requestPermission()` first. If the user grants the permission, developers can create a new instance of `IdleDetector`. This object provides two properties, `userState` and `screenState` containing the respective states. It will raise a `change` event when either the user's, or the screen's state change. Finally, the idle detector needs to be started by calling its `start()` method. The method takes a configuration object with two parameters: A `threshold` defining the time in milliseconds that the user has to be idle (the minimum is a minute). Optionally, developers can pass an `AbortSignal` to the `abort` property, which serves to abort idle detection later on.

{{ figure_markup(
  image="idle_detection_api.png",
  caption="Idle Detection API",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=963792757&format=interactive",
  sheets_gid="1324588405"
  )
}}

At the time of this writing, the Idle Detection API is in an origin trial, so its API shape may change in the future. For the same reason, its usage is very low and hardly measurable.

## Periodic Background Sync API

When the user closes a web application, it cannot communicate with its backend service anymore. In some cases, developers might still want to synchronize data on a more or less regular basis, just as native applications can. For instance, news applications might want to download the latest headlines before the user wakes up. The [Periodic Background Sync API](https://web.dev/periodic-background-sync/) ([WICG Draft Community Group Report](https://wicg.github.io/periodic-background-sync/)) strives to bridge this gap between web and native.

### Register for periodic sync

Periodic background sync relies on Service Workers that can run even when the app is closed. As other capabilities, this API requires permission first. The API implements a new interface called `PeriodicSyncManager`. If present, developers can access an instance of this interface on the Service Worker's registration. To synchronize data in the background, the application has to register first, by calling `periodicSync.register()` on the registration. This method takes two parameters: A `tag`, which is an arbitrary string to recognize the registration again later on. The second one is a configuration object that takes a `minInterval` property. This property defines the desired minimum interval in milliseconds by the developer, however, the browser ultimately decides how often it will actually invoke background synchronization:

```
registration.periodicSync.register('articles', {
  minInterval: 24 * 60 * 60 * 1000 // one day
});
```

### Respond to a periodic sync interval

For each tick of the interval, and if the device is online, the browser triggers the Service Worker's `periodicsync` event. Then, the Service Worker script can perform the necessary steps to synchronize the data:

```
self.addEventListener('periodicsync', (event) => {
  if (event.tag === 'articles') {
    event.waitUntil(syncStuff());
  }
});
```

At the time of this writing, only Chromium-based browsers implement this API. On these browsers, the application has to be installed (i.e., added to the homescreen) first, before the API can be used. The [site engagement score](https://www.chromium.org/developers/design-documents/site-engagement) of the website defines if and how often periodic sync events can be invoked. In the current conservative implementation, websites can sync content once a day.

{{ figure_markup(
  image="periodic_background_sync_api.png",
  caption="Periodic Background Sync API",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1444904371&format=interactive",
  sheets_gid="386193538",
  sql_file="periodic_background_sync_api.sql"
  )
}}

The use of the interface is currently very low. Apart from two outliers, the use on mobile and desktop websites is very close together.

## Integration with native app stores

Progressive Web Apps are a versatile application model. However, in some cases, it may still make sense to offer a separate native application: For example, if the app needs to use features that are not available on the web, or based on the programming experience of the app developer team. When the user already has a native app installed, apps might not want to send notifications twice or promote the installation of a corresponding PWA.

To detect if the user already has a related native application or PWA on the system, developers can use the [getInstalledRelatedApps() method](https://web.dev/get-installed-related-apps/) ([WICG Draft Community Group Report](https://wicg.github.io/get-installed-related-apps/spec/)) on the `navigator` object. This method is currently provided by Chromium-based browsers and works for both Android and Universal Windows Platform (UWP) apps. Developers need to adjust the native app bundles to refer to the website and add information about the native app(s) to the Web App Manifest of the PWA. Calling the `getInstalledRelatedApps()` method will then return the list of apps installed on the user's device:

```
const relatedApps = await navigator.getInstalledRelatedApps();
relatedApps.forEach((app) => {
  console.log(app.id, app.platform, app.url);
});
```

{{ figure_markup(
  image="get_installed_related_apps.png",
  caption="getInstalledRelatedApps()",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1774881171&format=interactive",
  sheets_gid="860146688",
  sql_file="get_installed_related_apps.sql"
  )
}}

Over the course of 2020, the `getInstalledRelatedApps()` API shows exponential growth on mobile websites. In September, 0.005 percent of mobile websites tracked by the HTTP Archive made use of this API. On the desktop, the API does not grow quite as fast, but still strictly monotonous. This could also be due to Android stores currently providing significantly more apps than the Microsoft Store does for Windows.

## Content Indexing API

Web apps can store content offline using various ways, such as Cache Storage, or IndexedDB. However, for users it's hard to discover which content is available offline. The [Content Indexing API](https://web.dev/content-indexing-api/) ([WICG Editor's Draft](https://wicg.github.io/content-index/spec/)) allows developers to expose content more prominently. Currently, Chrome on Android is the only browser to support this API. This browser shows a list of "Articles for you" in the Downloads menu. Content indexed via the Content Indexing API will appear there.

The Content Indexing API extends the Service Worker API by providing a new `ContentIndex` interface. This interface is available via the `index` property of the Service Worker's registration. The `add()` method allows developers to add content to the index: Each piece of content must have an ID, a URL, a launch URL, title, description, and a set of icons. Optionally, the content can be grouped into different categories such as articles, homepages, or videos. The `delete()` method allows for removing content from the index again, and the `getAll()` method returns a list of all indexed entries.

{{ figure_markup(
  image="content_indexing_api.png",
  caption="Content Indexing API :: Add",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=258329620&format=interactive",
  sheets_gid="626752011"
  )
}}

The Content Indexing API launched with Chrome 84 in July 2020. Directly after shipping, the API was used during approximately 0.0002 percent of page loads in Chrome. In October 2020, this value has quadrupled.

## New Transport APIs

Finally, there are two new transport methods that are currently in origin trial. The first one allows developers to receive high-frequency messages with WebSockets, while the second one introduces an entirely new bidirectional communication protocol apart from HTTP and WebSockets.

### Backpressure for WebSockets

The WebSocket API is a great choice for bidirectional communication between websites and servers. However, the WebSocket API does not allow for backpressure, so applications dealing with high-frequency messages may freeze. The [WebSocketStream API](https://web.dev/websocketstream/) ([Explainer](https://github.com/ricea/websocketstream-explainer/blob/master/README.md), not on the standards track yet) wants to bring easy-to-use backpressure support to the WebSocket API by extending it with streams. Instead of using the usual `WebSocket` constructor, developers need to create a new instance of the `WebSocketStream` interface. The `connection` property of the stream returns a promise that resolves to a readable and writable stream that allow to obtain a stream reader or writer, respectively:

```
const wss = new WebSocketStream(WSS_URL);
const {readable, writable} = await wss.connection;
const reader = readable.getReader();
const writer = writable.getWriter();
```

The WebSocketStream API transparently solves backpressure, as the stream readers and writers will only proceed if it's safe to do so.

{{ figure_markup(
  image="websocketstreams.png",
  caption="WebSocketStreams",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1714443590&format=interactive",
  sheets_gid="691106754"
  )
}}

The WebSocketStream API has completed its first origin trial and is now back in the experimentation phase again. This also explains why the usage of this API currently is so low that it's hardly measurable.

### Make it QUIC

[QUIC](https://www.chromium.org/quic) ([IETF Internet-Draft](https://www.ietf.org/archive/id/draft-ietf-quic-transport-31.txt)) is a multiplexed, stream-based, bidirectional transport protocol implemented on UDP. It's an alternative to HTTP/WebSocket APIs that are implemented on top of TCP. The [QuicTransport API](https://web.dev/quictransport/) is the client-side API for sending messages to and receiving messages from a QUIC server. Developers can choose to send data unreliably via datagrams, or reliably by using its streams API:

```
const transport = new QuicTransport(QUIC_URL);
await transport.ready;

const ws = transport.sendDatagrams();
const stream = await transport.createSendStream();
```

QuicTransport is a valid alternative to WebSockets, as it supports the use cases from the WebSocket API and adds support for scenarios where minimal latency is more important than reliability and message order. This makes it a good choice for games and applications dealing with high-frequency events.

{{ figure_markup(
  image="quic_transport.png",
  caption="QuicTransport",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1571330893&format=interactive",
  sheets_gid="708893754"
  )
}}

The use of the interface is currently still so low that it's hardly measurable.

## Conclusion

The state of web capabilities in 2020 is healthy, as new powerful APIs regularly ship with new releases of Chromium-based browsers. Some interfaces like the Content Indexing API or Idle Detection API help to add finishing touches to certain web applications. Other APIs, such as the File System Access and Async Clipboard API, allow a whole new application category, namely productivity apps, to finally fully make the shift to the web. Some APIs such as Async Clipboard and Web Share API have already made their way into other, non-Chromium browsers. Safari even was the first mobile browser to implement the Web Share API.

Through its [rigorous process](https://developers.google.com/web/updates/capabilities#process), the Fugu team ensures that access to these features takes place in a secure and privacy-friendly manner. Additionally, the Fugu team actively solicits the feedback from other browser vendors and web developers. While the usage of most of these new APIs is comparatively low, some APIs presented in this chapter show an exponential or even hockey stick-like growth, such as the Badging or Content Indexing API. It is dependent on web developers what the state of web capabilities in 2021 will look like: The author encourages the community to build great web applications, make use of the powerful APIs in a backwards-compatible manner, and help make the web a more capable platform.
